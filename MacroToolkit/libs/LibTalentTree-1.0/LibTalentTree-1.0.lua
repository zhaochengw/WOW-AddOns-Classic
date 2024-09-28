-- the data for LibTalentTree will be loaded (and cached) from blizzard's APIs when the Lib loads
-- @curseforge-project-slug: libtalenttree@

local MAJOR, MINOR = "LibTalentTree-1.0", 21;
--- @class LibTalentTree-1.0
local LibTalentTree = LibStub:NewLibrary(MAJOR, MINOR);

if not LibTalentTree then return end -- No upgrade needed

--- Whether the current game version is compatible with this library. This is generally always true on retail, and always false on classic.
function LibTalentTree:IsCompatible()
    return C_ClassTalents and C_ClassTalents.InitializeViewLoadout and true or false;
end

if not C_ClassTalents or not C_ClassTalents.InitializeViewLoadout then
    setmetatable(LibTalentTree, {
        __index = function()
            error('LibTalentTree requires C_ClassTalents.InitializeViewLoadout to be available');
        end,
    });

    return;
end

local MAX_LEVEL = 100; -- seems to not break if set too high, but can break things when set too low
local MAX_SUB_TREE_CURRENCY = 10; -- blizzard incorrectly reports 20 when asking for the maxQuantity of the currency
local HERO_TREE_REQUIRED_LEVEL = 71; -- while `C_ClassTalents.GetHeroTalentSpecsForClassSpec` returns this info, it's not immediately available on initial load

-- taken from ClassTalentUtil.GetVisualsForClassID
local CLASS_OFFSETS = {
    [1] = { x = 30, y = 31, }, -- Warrior
    [2] = { x = -60, y = -29, }, -- Paladin
    [3] = { x = 0, y = -29, }, -- Hunter
    [4] = { x = 30, y = -29, }, -- Rogue
    [5] = { x = -30, y = -29, }, -- Priest
    [6] = { x = 0, y = 1, }, -- DK
    [7] = { x = 0, y = 1, }, -- Shaman
    [8] = { x = 30, y = -29, }, -- Mage
    [9] = { x = 0, y = 1, }, -- Warlock
    [10] = { x = 0, y = -29, }, -- Monk
    [11] = { x = 30, y = -29, }, -- Druid
    [12] = { x = 30, y = -29, }, -- Demon Hunter
    [13] = { x = 30, y = -29, }, -- Evoker
};
-- taken from ClassTalentTalentsTabTemplate XML
local BASE_PAN_OFFSET_X = 4;
local BASE_PAN_OFFSET_Y = -30;

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local function deepCopy(original)
    local copy;
    if (type(original) == 'table') then
        copy = {};
        for key, value in next, original, nil do
            copy[deepCopy(key)] = deepCopy(value);
        end
        setmetatable(copy, deepCopy(getmetatable(original)));
    else
        copy = original;
    end

    return copy;
end

local function mergeTables(target, source, keyToUse)
    local lookup = {};
    for _, value in pairs(target) do
        if keyToUse then
            lookup[value[keyToUse]] = true;
        else
            lookup[value] = true;
        end
    end
    for _, value in pairs(source) do
        if (keyToUse and not lookup[value[keyToUse]]) or (not keyToUse and not lookup[value]) then
            table.insert(target, value);
        end
    end
end

local roundingFactor = 100;
local function round(coordinate)
    return math.floor((coordinate / roundingFactor) + 0.5) * roundingFactor;
end

local function getGridLineFromCoordinate(start, spacing, halfwayEnabled, coordinate)
    local bucketSpacing = halfwayEnabled and (spacing / 4) or (spacing / 2);
    -- breaks out at 25, which is well above the expected max
    for testLine = 1, 25, (halfwayEnabled and 0.5 or 1) do
        local bucketStart = (start - spacing) + (spacing * testLine) - bucketSpacing;
        local bucketEnd = bucketStart + (bucketSpacing * 2);
        if coordinate >= bucketStart and coordinate < bucketEnd then
            return testLine;
        end
    end

    return nil;
end

local function buildCache()
    local level = MAX_LEVEL;
    local configID = Constants.TraitConsts.VIEW_TRAIT_CONFIG_ID;

    LibTalentTree.cache = {};
    local cache = LibTalentTree.cache;
    cache.classFileMap = {};
    cache.specMap = {};
    cache.classTreeMap = {};
    cache.nodeTreeMap = {};
    cache.entryTreeMap = {};
    cache.entryNodeMap = {};
    cache.specSubTreeMap = {};
    cache.subTreeNodesMap = {};
    cache.treeCurrencyMap = {};
    cache.nodeData = {};
    cache.gateData = {};
    cache.entryData = {};
    cache.subTreeData = {};
    for classID = 1, GetNumClasses() do
        cache.classFileMap[select(2, GetClassInfo(classID))] = classID;

        local nodes;
        local nodeData = {};
        local entryData = {};
        local gateData = {};
        local treeID;

        local numSpecs = GetNumSpecializationsForClassID(classID);
        for specIndex = 1, numSpecs do
            local lastSpec = specIndex == numSpecs;
            local specID = GetSpecializationInfoForClassID(classID, specIndex);
            cache.specMap[specID] = classID;

            --- @type number
            treeID = treeID or C_ClassTalents.GetTraitTreeForSpec(specID);
            cache.classTreeMap[classID] = treeID;

            C_ClassTalents.InitializeViewLoadout(specID, level);
            C_ClassTalents.ViewLoadout({});

            nodes = nodes or C_Traits.GetTreeNodes(treeID);
            local treeCurrencyInfo = C_Traits.GetTreeCurrencyInfo(configID, treeID, true);
            local classCurrencyID = treeCurrencyInfo[1].traitCurrencyID;
            cache.treeCurrencyMap[treeID] = cache.treeCurrencyMap[treeID] or treeCurrencyInfo;
            cache.treeCurrencyMap[treeID][1].isClassCurrency = true;
            cache.treeCurrencyMap[treeID][2].isSpecCurrency = true;
            for _, currencyInfo in ipairs(treeCurrencyInfo) do
                cache.treeCurrencyMap[treeID][currencyInfo.traitCurrencyID] = cache.treeCurrencyMap[treeID][currencyInfo.traitCurrencyID] or currencyInfo;
            end

            local treeInfo = C_Traits.GetTreeInfo(configID, treeID);
            for _, gateInfo in ipairs(treeInfo.gates) do
                local conditionID = gateInfo.conditionID;
                local conditionInfo = C_Traits.GetConditionInfo(configID, conditionID);
                gateData[conditionID] = {
                    currencyID = conditionInfo.traitCurrencyID,
                    spentAmountRequired = conditionInfo.spentAmountRequired,
                };
            end

            for _, nodeID in ipairs(nodes) do
                cache.nodeTreeMap[nodeID] = treeID;
                local nodeInfo = C_Traits.GetNodeInfo(configID, nodeID);
                nodeData[nodeID] = nodeData[nodeID] or {};
                local data = nodeData[nodeID];
                data.grantedForSpecs = data.grantedForSpecs or {};
                data.grantedForSpecs[specID] = false; -- true check is done only if the node is visible
                if nodeInfo.isVisible then
                    data.posX = nodeInfo.posX;
                    data.posY = nodeInfo.posY;
                    data.type = nodeInfo.type;
                    data.maxRanks = nodeInfo.maxRanks;
                    data.flags = nodeInfo.flags;
                    data.entryIDs = nodeInfo.entryIDs;
                    data.subTreeID = nodeInfo.subTreeID;
                    data.isSubTreeSelection = nodeInfo.type == Enum.TraitNodeType.SubTreeSelection;

                    data.visibleEdges = data.visibleEdges or {}
                    mergeTables(data.visibleEdges, nodeInfo.visibleEdges, 'targetNode');

                    data.conditionIDs = data.conditionIDs or {}
                    mergeTables(data.conditionIDs, nodeInfo.conditionIDs);

                    data.groupIDs = data.groupIDs or {}
                    mergeTables(data.groupIDs, nodeInfo.groupIDs);
                    for entryIndex, entryID in ipairs(nodeInfo.entryIDs) do
                        cache.entryTreeMap[entryID] = treeID;
                        cache.entryNodeMap[entryID] = nodeID;
                        if not entryData[entryID] then
                            local entryInfo = C_Traits.GetEntryInfo(configID, entryID);
                            entryData[entryID] = {
                                definitionID = entryInfo.definitionID,
                                type = entryInfo.type,
                                maxRanks = entryInfo.maxRanks,
                                subTreeID = entryInfo.subTreeID,
                            }

                            if entryInfo.subTreeID then
                                cache.specSubTreeMap[specID] = cache.specSubTreeMap[specID] or {};
                                cache.specSubTreeMap[specID][entryIndex] = entryInfo.subTreeID;
                                -- I previously used C_ClassTalents.GetHeroTalentSpecsForClassSpec, but it returns nil on initial load
                                -- it's not actually required to retrieve the data though
                                local subTreeInfo = C_Traits.GetSubTreeInfo(configID, entryInfo.subTreeID);
                                if subTreeInfo then
                                    subTreeInfo.requiredPlayerLevel = HERO_TREE_REQUIRED_LEVEL;
                                    subTreeInfo.maxCurrency = MAX_SUB_TREE_CURRENCY;
                                    subTreeInfo.isActive = false;
                                    cache.subTreeData[entryInfo.subTreeID] = subTreeInfo;
                                    cache.treeCurrencyMap[treeID][subTreeInfo.traitCurrencyID].subTreeID = entryInfo.subTreeID;
                                    cache.treeCurrencyMap[treeID][subTreeInfo.traitCurrencyID].quantity = MAX_SUB_TREE_CURRENCY;
                                    cache.treeCurrencyMap[treeID][subTreeInfo.traitCurrencyID].maxQuantity = MAX_SUB_TREE_CURRENCY;
                                end
                            end
                        end
                    end

                    for _, conditionID in ipairs(data.conditionIDs) do
                        local cInfo = C_Traits.GetConditionInfo(configID, conditionID)
                        if cInfo and cInfo.isMet and cInfo.ranksGranted and cInfo.ranksGranted > 0 then
                            data.grantedForSpecs[specID] = true;
                        end
                    end

                    if nil == data.isClassNode then
                        data.isClassNode = false;
                        local nodeCost = C_Traits.GetNodeCost(configID, nodeID);
                        if not next(nodeCost) and data.grantedForSpecs[specID] then
                            data.isClassNode = true;
                        end
                        for _, cost in ipairs(nodeCost) do
                            if cost.ID == classCurrencyID then
                                data.isClassNode = true;
                                break;
                            end
                        end
                    end
                end
                data.visibleForSpecs = data.visibleForSpecs or {};
                data.visibleForSpecs[specID] = nodeInfo.isVisible;

                if lastSpec then
                	if not data.posX then
                        nodeData[nodeID] = nil;
                    elseif data.subTreeID then
                        cache.subTreeNodesMap[data.subTreeID] = cache.subTreeNodesMap[data.subTreeID] or {};
                        table.insert(cache.subTreeNodesMap[data.subTreeID], nodeID);
                    end
                end
            end
        end

        cache.nodeData[treeID] = nodeData;
        cache.entryData[treeID] = entryData;
        cache.gateData[treeID] = gateData;
    end
end

do
    -- buildCache results in a significant amount of pointless taintlog entries when it's set to log level 11
    -- so we just disable it temporarily
    local backup = C_CVar.GetCVar('taintLog');
    if backup and backup == '11' then C_CVar.SetCVar('taintLog', 0); end
    buildCache();
    if backup and backup == '11' then C_CVar.SetCVar('taintLog', backup); end
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

--- @public
--- @param nodeID number # TraitNodeID
--- @return ( number | nil ) # TraitTreeID
function LibTalentTree:GetTreeIDForNode(nodeID)
    assert(type(nodeID) == 'number', 'nodeID must be a number');

    return self.cache.nodeTreeMap[nodeID];
end
LibTalentTree.GetTreeIdForNode = LibTalentTree.GetTreeIDForNode;

--- @public
--- @param entryID number # TraitEntryID
--- @return ( number | nil ) # TraitTreeID
function LibTalentTree:GetTreeIDForEntry(entryID)
    assert(type(entryID) == 'number', 'entryID must be a number');

    return self.cache.entryTreeMap[entryID];
end
LibTalentTree.GetTreeIdForEntry = LibTalentTree.GetTreeIDForEntry;

--- @public
--- @param entryID number # TraitEntryID
--- @return ( number | nil ) # TraitNodeID
function LibTalentTree:GetNodeIDForEntry(entryID)
    assert(type(entryID) == 'number', 'entryID must be a number');

    return self.cache.entryNodeMap[entryID];
end

--- @public
--- @param treeID number # TraitTreeID, or TraitNodeID, if leaving the 2nd argument nil
--- @param nodeID number # TraitNodeID, can be omitted, by passing the nodeID as the first argument, the treeID is automatically determined
--- @return ( libNodeInfo | nil )
--- @overload fun(self: LibTalentTree-1.0, nodeID: number): libNodeInfo | nil
function LibTalentTree:GetLibNodeInfo(treeID, nodeID)
    assert(type(treeID) == 'number', 'treeID must be a number');
    if not nodeID then
        nodeID = treeID;
        treeID = self:GetTreeIDForNode(nodeID);
    end
    assert(type(nodeID) == 'number', 'nodeID must be a number');

    local nodeData = self.cache.nodeData;

    local nodeInfo = nodeData[treeID] and nodeData[treeID][nodeID] and deepCopy(nodeData[treeID][nodeID]) or nil;
    if (nodeInfo) then nodeInfo.ID = nodeID; end

    return nodeInfo;
end

--- @public
--- @param treeID number # TraitTreeID, or TraitEntryID, if leaving the 2nd argument nil
--- @param nodeID number # TraitNodeID, can be omitted, by passing the nodeID as the first argument, the treeID is automatically determined
--- @return ( libNodeInfo ) # libNodeInfo is enriched and overwritten by C_Traits information if possible
--- @overload fun(self: LibTalentTree-1.0, nodeID: number): libNodeInfo
function LibTalentTree:GetNodeInfo(treeID, nodeID)
    assert(type(treeID) == 'number', 'treeID must be a number');
    if not nodeID then
        nodeID = treeID;
        treeID = self:GetTreeIDForNode(nodeID);
    end
    assert(type(nodeID) == 'number', 'nodeID must be a number');

    local cNodeInfo = C_ClassTalents.GetActiveConfigID()
            and C_Traits.GetNodeInfo(C_ClassTalents.GetActiveConfigID(), nodeID)
            or C_Traits.GetNodeInfo(Constants.TraitConsts.VIEW_TRAIT_CONFIG_ID or -3, nodeID);
    local libNodeInfo = treeID and self:GetLibNodeInfo(treeID, nodeID);

    if (not libNodeInfo) then return cNodeInfo; end
    if (not cNodeInfo) then cNodeInfo = {}; end

    if cNodeInfo.ID == nodeID then
        return Mixin(libNodeInfo, cNodeInfo);
    end

    return Mixin(cNodeInfo, libNodeInfo);
end

--- @public
--- @param treeID number # TraitTreeID, or TraitEntryID, if leaving the 2nd argument nil
--- @param entryID number # TraitEntryID, can be omitted, by passing the entryID as the first argument, the treeID is automatically determined
--- @return ( entryInfo | nil )
--- @overload fun(self: LibTalentTree-1.0, entryID: number): entryInfo | nil
function LibTalentTree:GetEntryInfo(treeID, entryID)
    assert(type(treeID) == 'number', 'treeID must be a number');
    if not entryID then
        entryID = treeID;
        treeID = self:GetTreeIDForEntry(entryID);
    end
    assert(type(entryID) == 'number', 'entryID must be a number');

    local entryData = self.cache.entryData;

    local entryInfo = entryData[treeID] and entryData[treeID][entryID] and deepCopy(entryData[treeID][entryID]) or nil;
    if (entryInfo) then
        entryInfo.isAvailable = true;
        entryInfo.conditionIDs = {};
    end

    return entryInfo;
end

--- @public
--- @param class (string | number) # ClassID or ClassFilename - e.g. "DEATHKNIGHT" or 6 - See https://warcraft.wiki.gg/wiki/ClassID
--- @return ( number | nil ) # TraitTreeID
function LibTalentTree:GetClassTreeID(class)
    assert(type(class) == 'string' or type(class) == 'number', 'class must be a string or number');

    local classFileMap = self.cache.classFileMap;
    local classTreeMap = self.cache.classTreeMap;

    local classID = classFileMap[class] or class;

    return classTreeMap[classID] or nil;
end
LibTalentTree.GetClassTreeId = LibTalentTree.GetClassTreeID;

--- @public
--- @param treeID (number) # a class' TraitTreeID
--- @return (number | nil) # ClassID or nil - See https://warcraft.wiki.gg/wiki/ClassID
function LibTalentTree:GetClassIDByTreeID(treeID)
    treeID = tonumber(treeID);

    if not self.inverseClassMap then
        local classTreeMap = self.cache.classTreeMap;
        self.inverseClassMap = {};
        for classID, mappedTreeID in pairs(classTreeMap) do
            self.inverseClassMap[mappedTreeID] = classID;
        end
    end

    return self.inverseClassMap[treeID];
end
LibTalentTree.GetClassIdByTreeId = LibTalentTree.GetClassIDByTreeID;

--- @public
--- @param specID number # See https://warcraft.wiki.gg/wiki/SpecializationID
--- @param nodeID number # TraitNodeID
--- @return boolean # whether the node is visible for the given spec
function LibTalentTree:IsNodeVisibleForSpec(specID, nodeID)
    assert(type(specID) == 'number', 'specID must be a number');
    assert(type(nodeID) == 'number', 'nodeID must be a number');

    local specMap = self.cache.specMap;
    local class = specMap[specID];
    assert(class, 'Unknown specID: ' .. specID);

    local treeID = self:GetClassTreeID(class);
    local nodeInfo = self:GetLibNodeInfo(treeID, nodeID);

    if not nodeInfo then return false; end

    -- >= 10.1.0
    if nodeInfo.visibleForSpecs then
        return nodeInfo.visibleForSpecs[specID];
    end

    -- < 10.1.0
    if (nodeInfo.specInfo[specID]) then
        for _, conditionType in pairs(nodeInfo.specInfo[specID]) do
            if (conditionType == Enum.TraitConditionType.Visible or conditionType == Enum.TraitConditionType.Granted) then
                return true;
            end
        end
    end
    for id, conditionTypes in pairs(nodeInfo.specInfo) do
        if (id ~= specID) then
            for _, conditionType in pairs(conditionTypes) do
                if (conditionType == Enum.TraitConditionType.Visible) then
                    return false
                end
            end
        end
    end
    if (nodeInfo.specInfo[0]) then
        for _, conditionType in pairs(nodeInfo.specInfo[0]) do
            if (conditionType == Enum.TraitConditionType.Visible or conditionType == Enum.TraitConditionType.Granted) then
                return true;
            end
        end
    end

    return true;
end

--- @public
--- @param specID number # See https://warcraft.wiki.gg/wiki/SpecializationID
--- @param nodeID number # TraitNodeID
--- @return boolean # whether the node is granted by default for the given spec
function LibTalentTree:IsNodeGrantedForSpec(specID, nodeID)
    assert(type(specID) == 'number', 'specID must be a number');
    assert(type(nodeID) == 'number', 'nodeID must be a number');

    local specMap = self.cache.specMap;
    local class = specMap[specID];
    assert(class, 'Unknown specID: ' .. specID);

    local treeID = self:GetClassTreeID(class);
    local nodeInfo = self:GetLibNodeInfo(treeID, nodeID);

    -- >= 10.1.0
    if nodeInfo and nodeInfo.grantedForSpecs then
        return nodeInfo.grantedForSpecs[specID];
    end

    -- < 10.1.0
    if (nodeInfo and nodeInfo.specInfo[specID]) then
        for _, conditionType in pairs(nodeInfo.specInfo[specID]) do
            if (conditionType == Enum.TraitConditionType.Granted) then
                return true;
            end
        end
    end

    if (nodeInfo and nodeInfo.specInfo[0]) then
        for _, conditionType in pairs(nodeInfo.specInfo[0]) do
            if (conditionType == Enum.TraitConditionType.Granted) then
                return true;
            end
        end
    end

    return false;
end

--- @public
--- @param treeID number # TraitTreeID, or TraitNodeID, if leaving the 2nd parameter nil
--- @param nodeID number # TraitNodeID, can be omitted, by passing the nodeID as the first argument, the treeID is automatically determined
--- @return ( number|nil, number|nil ) # posX, posY - some trees have a global offset
--- @overload fun(self: LibTalentTree-1.0, nodeID: number): (number|nil, number|nil)
function LibTalentTree:GetNodePosition(treeID, nodeID)
    assert(type(treeID) == 'number', 'treeID must be a number');
    if not nodeID then
        nodeID = treeID;
        treeID = self:GetTreeIDForNode(nodeID);
    end
    assert(type(nodeID) == 'number', 'nodeID must be a number');

    local nodeInfo = self:GetLibNodeInfo(treeID, nodeID);
    if (not nodeInfo) then return nil, nil; end

    return nodeInfo.posX, nodeInfo.posY;
end

local gridPositionCache = {};

--- @public
--- Returns an abstraction of the node positions into a grid of columns and rows.
--- Some specs may have nodes that sit between 2 columns, these columns end in ".5". This happens for example in the Druid and Demon Hunter trees.
---
--- The top row is 1, the bottom row is 10.
--- The first class column is 1, the last class column is 9.
--- The first spec column is 13. (if the client supports sub trees, otherwise it's 10)
---
--- Hero talents are placed in between the class and spec trees, in columns 10, 11, 12.
--- Hero talent subTrees are stacked to overlap, all subTrees on rows 1 - 5. You're responsible for adjusting this yourself.
---
--- The Hero talent selection node, is hardcoded to row 5.5 and column 10. Making it sit right underneath the sub trees themselves.
---
--- @param treeID number # TraitTreeID, or TraitNodeID, if leaving the 2nd parameter nil
--- @param nodeID number # TraitNodeID, can be omitted, by passing the nodeID as the first argument, the treeID is automatically determined
--- @return ( number|nil, number|nil ) # column, row
--- @overload fun(self: LibTalentTree-1.0, nodeID: number): (number|nil, number|nil)
function LibTalentTree:GetNodeGridPosition(treeID, nodeID)
    assert(type(treeID) == 'number', 'treeID must be a number');
    if not nodeID then
        nodeID = treeID;
        treeID = self:GetTreeIDForNode(nodeID);
    end
    assert(type(nodeID) == 'number', 'nodeID must be a number');

    local classID = self:GetClassIDByTreeID(treeID);
    if not classID then return nil, nil end

    gridPositionCache[treeID] = gridPositionCache[treeID] or {};
    if gridPositionCache[treeID][nodeID] then
        return unpack(gridPositionCache[treeID][nodeID]);
    end

    local posX, posY = self:GetNodePosition(treeID, nodeID);
    if (not posX or not posY) then return nil, nil; end

    local offsetX = BASE_PAN_OFFSET_X - (CLASS_OFFSETS[classID] and CLASS_OFFSETS[classID].x or 0);
    local offsetY = BASE_PAN_OFFSET_Y - (CLASS_OFFSETS[classID] and CLASS_OFFSETS[classID].y or 0);

    local rawX, rawY = posX, posY;

    posX = (round(posX) / 10) - offsetX;
    posY = (round(posY) / 10) - offsetY;
    local colSpacing = 60;

    local row, col;
    local nodeInfo = self:GetLibNodeInfo(treeID, nodeID);
    local subTreeID = nodeInfo and nodeInfo.subTreeID;

    if subTreeID then
        local subTreeInfo = self:GetSubTreeInfo(subTreeID);
        if subTreeInfo then
            local topCenterPosX = subTreeInfo.posX;
            local topCenterPosY = subTreeInfo.posY;
            local offsetFromCenterX = rawX - topCenterPosX;
            if (offsetFromCenterX > colSpacing) then
                col = 12;
            elseif (offsetFromCenterX < -colSpacing) then
                col = 10;
            else
                col = 11;
            end

            local rowStart = topCenterPosY;
            local rowSpacing = 2400 / 4; -- 2400 is generally the height of a sub tree, 4 is number of "gaps" between 5 rows
            local halfRowEnabled = false;
            row = getGridLineFromCoordinate(rowStart, rowSpacing, halfRowEnabled, rawY) or 0;
        end
    elseif nodeInfo and nodeInfo.isSubTreeSelection then
        col = 10;
        row = 5.5;
    end
    if not row or not col then
        local colStart = 176;
        local halfColEnabled = true;
        local classColEnd = 656;
        local specColStart = 956;
        local subTreeOffset = 3 * colSpacing;
        local classSpecGap = (specColStart - classColEnd) - subTreeOffset;
        if (posX > (classColEnd + (classSpecGap / 2))) then
            -- remove the gap between the class and spec trees
            posX = posX - classSpecGap + colSpacing;
        end
        col = getGridLineFromCoordinate(colStart, colSpacing, halfColEnabled, posX);

        local rowStart = 151;
        local rowSpacing = 60;
        local halfRowEnabled = false;
        row = getGridLineFromCoordinate(rowStart, rowSpacing, halfRowEnabled, posY);
    end

    gridPositionCache[treeID][nodeID] = {col, row};

    return col, row;
end

--- @public
--- @param treeID number # TraitTreeID, or TraitNodeID, if leaving the 2nd parameter nil
--- @param nodeID number # TraitNodeID, can be omitted, by passing the nodeID as the first argument, the treeID is automatically determined
--- @return ( nil | visibleEdge[] ) # The order might not match C_Traits
--- @overload fun(self: LibTalentTree-1.0, nodeID: number): nil | visibleEdge[]
function LibTalentTree:GetNodeEdges(treeID, nodeID)
    assert(type(treeID) == 'number', 'treeID must be a number');
    if not nodeID then
        nodeID = treeID;
        treeID = self:GetTreeIDForNode(nodeID);
    end
    assert(type(nodeID) == 'number', 'nodeID must be a number');

    local nodeInfo = self:GetLibNodeInfo(treeID, nodeID);
    if (not nodeInfo) then return nil; end

    return nodeInfo.visibleEdges;
end

--- @public
--- @param treeID number # TraitTreeID, or TraitNodeID, if leaving the 2nd parameter nil
--- @param nodeID number # TraitNodeID, can be omitted, by passing the nodeID as the first argument, the treeID is automatically determined
--- @return ( boolean | nil ) # true if the node is a class node, false for spec nodes, nil if unknown
--- @overload fun(self: LibTalentTree-1.0, nodeID: number): boolean | nil
function LibTalentTree:IsClassNode(treeID, nodeID)
    assert(type(treeID) == 'number', 'treeID must be a number');
    if not nodeID then
        nodeID = treeID;
        treeID = self:GetTreeIDForNode(nodeID);
    end
    assert(type(nodeID) == 'number', 'nodeID must be a number');

    local nodeInfo = self:GetLibNodeInfo(treeID, nodeID);
    if (not nodeInfo) then return nil; end

    return nodeInfo.isClassNode;
end

local gateCache = {}

--- @public
--- @param specID number # See https://warcraft.wiki.gg/wiki/SpecializationID
--- @return ( gateInfo[] ) # list of gates for the given spec, sorted by spending required
function LibTalentTree:GetGates(specID)
    -- an optimization step is likely trivial in 10.1.0, but well.. effort, and this also works fine still :)
    assert(type(specID) == 'number', 'specID must be a number');

    if (gateCache[specID]) then return deepCopy(gateCache[specID]); end
    local specMap = self.cache.specMap;
    local class = specMap[specID];
    assert(class, 'Unknown specID: ' .. specID);

    local treeID = self:GetClassTreeID(class);
    local gates = {};

    local nodesByConditions = {};
    local gateData = self.cache.gateData;
    local conditions = gateData[treeID];

    local nodeData = self.cache.nodeData;

    for nodeID, nodeInfo in pairs(nodeData[treeID]) do
        if (#nodeInfo.conditionIDs > 0 and self:IsNodeVisibleForSpec(specID, nodeID)) then
            for _, conditionID in pairs(nodeInfo.conditionIDs) do
                if conditions[conditionID] then
                    nodesByConditions[conditionID] = nodesByConditions[conditionID] or {};
                    nodesByConditions[conditionID][nodeID] = nodeInfo;
                end
            end
        end
    end

    for conditionID, gateInfo in pairs(conditions) do
        local nodes = nodesByConditions[conditionID];
        if (nodes) then
            local minX, minY, topLeftNode = 9999999, 9999999, nil;
            for nodeID, nodeInfo in pairs(nodes) do
                local roundedX, roundedY = round(nodeInfo.posX), round(nodeInfo.posY);

                if (roundedY < minY) then
                    minY = roundedY;
                    minX = roundedX;
                    topLeftNode = nodeID
                elseif (roundedY == minY and roundedX < minX) then
                    minX = roundedX;
                    topLeftNode = nodeID
                end
            end
            if (topLeftNode) then
                table.insert(gates, {
                    topLeftNodeID = topLeftNode,
                    conditionID = conditionID,
                    spentAmountRequired = gateInfo.spentAmountRequired,
                    traitCurrencyID = gateInfo.currencyID,
                });
            end
        end
    end
    table.sort(gates, function(a, b)
        return a.spentAmountRequired < b.spentAmountRequired;
    end);
    gateCache[specID] = gates;

    return deepCopy(gates);
end

--- @public
--- @param treeID number # TraitTreeID
--- @return treeCurrencyInfo[] # list of currencies for the given tree, first entry is class currency, second is spec currency, the rest are sub tree currencies. The list is additionally indexed by the traitCurrencyID.
function LibTalentTree:GetTreeCurrencies(treeID)
    assert(type(treeID) == 'number', 'treeID must be a number');

    return deepCopy(self.cache.treeCurrencyMap[treeID]);
end

--- @public
--- @param subTreeID number # TraitSubTreeID
--- @return number[] # list of TraitNodeIDs that belong to the given sub tree
function LibTalentTree:GetSubTreeNodeIDs(subTreeID)
    assert(type(subTreeID) == 'number', 'subTreeID must be a number');

    return deepCopy(self.cache.subTreeNodesMap[subTreeID]) or {};
end
LibTalentTree.GetSubTreeNodeIds = LibTalentTree.GetSubTreeNodeIDs;

--- @public
--- @param specID number # See https://warcraft.wiki.gg/wiki/SpecializationID
--- @return number[] # list of TraitSubTreeIDs that belong to the given spec
function LibTalentTree:GetSubTreeIDsForSpecID(specID)
    assert(type(specID) == 'number', 'specID must be a number');

    return deepCopy(self.cache.specSubTreeMap[specID]) or {};
end
LibTalentTree.GetSubTreeIdsForSpecId = LibTalentTree.GetSubTreeIDsForSpecID;

--- @public
--- @param subTreeID number # TraitSubTreeID
--- @return ( subTreeInfo | nil )
function LibTalentTree:GetSubTreeInfo(subTreeID)
    assert(type(subTreeID) == 'number', 'subTreeID must be a number');

    return deepCopy(self.cache.subTreeData[subTreeID]);
end

--- @public
--- @param specID number # See https://warcraft.wiki.gg/wiki/SpecializationID
--- @param subTreeID number # TraitSubTreeID
--- @return number?, number? # TraitNodeID, TraitEntryID; or nil if not found
function LibTalentTree:GetSubTreeSelectionNodeIDAndEntryIDBySpecID(specID, subTreeID)
    assert(type(specID) == 'number', 'specID must be a number');
    assert(type(subTreeID) == 'number', 'subTreeID must be a number');

    local subTreeInfo = self:GetSubTreeInfo(subTreeID);
    for _, selectionNodeID in ipairs(subTreeInfo and subTreeInfo.subTreeSelectionNodeIDs or {}) do
        if self:IsNodeVisibleForSpec(specID, selectionNodeID) then
            local nodeInfo = self:GetLibNodeInfo(selectionNodeID);
            for _, entryID in ipairs(nodeInfo and nodeInfo.entryIDs or {}) do
                local entryInfo = self:GetEntryInfo(entryID);
                if entryInfo and entryInfo.subTreeID == subTreeID then
                    return selectionNodeID, entryID;
                end
            end
            break;
        end
    end

    return nil;
end
