-- the data for LibTalentTree will be loaded (and cached) from blizzard's APIs when the Lib loads
-- @curseforge-project-slug: libtalenttree@

local MAJOR, MINOR = "LibTalentTree-1.0", 14;
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

local MAX_LEVEL = 70;
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

---@alias edgeType
---| 0 # VisualOnly
---| 1 # DeprecatedRankConnection
---| 2 # SufficientForAvailability
---| 3 # RequiredForAvailability
---| 4 # MutuallyExclusive
---| 5 # DeprecatedSelectionOption

---@alias visualStyle
---| 0 # None
---| 1 # Straight

---@alias nodeType
---| 0 # single
---| 1 # Tiered
---| 2 # Selection

---@alias nodeFlags
---| 1 # ShowMultipleIcons
---| 2 # NeverPurchasable
---| 4 # TestPositionLocked
---| 8 # TestGridPositioned

---@class visibleEdge
---@field type edgeType # see Enum.TraitNodeEdgeType
---@field visualStyle visualStyle # see Enum.TraitEdgeVisualStyle
---@field targetNode number # TraitNodeID

---@class libNodeInfo
---@field ID number # TraitNodeID
---@field posX number
---@field posY number
---@field type nodeType # see Enum.TraitNodeType
---@field maxRanks number
---@field flags nodeFlags # see Enum.TraitNodeFlag
---@field groupIDs number[]
---@field visibleEdges visibleEdge[] # The order does not always match C_Traits
---@field conditionIDs number[]
---@field entryIDs number[] # TraitEntryID - generally, choice nodes will have 2, otherwise there's just 1
---@field specInfo table<number, number[]> # specId: conditionType[] Deprecated, will be removed in 10.1.0; see Enum.TraitConditionType
---@field visibleForSpecs table<number, boolean> # specId: true/false, true if a node is visible for a spec; added in 10.1.0
---@field grantedForSpecs table<number, boolean> # specId: true/false, true if a node is granted for free, for a spec; added in 10.1.0
---@field isClassNode boolean

---@class entryInfo
---@field definitionID number # TraitDefinitionID
---@field type number # see Enum.TraitNodeEntryType
---@field maxRanks number
---@field isAvailable boolean # LibTalentTree always returns true
---@field conditionIDs number[] # list of TraitConditionID, LibTalentTree always returns an empty table

---@class gateInfo
---@field topLeftNodeID number # TraitNodeID - the node that is the top left corner of the gate
---@field conditionID number # TraitConditionID
---@field spentAmountRequired number # the total amount of currency required to unlock the gate
---@field traitCurrencyID number # TraitCurrencyID

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
    cache.nodeData = {};
    cache.gateData = {};
    cache.entryData = {};
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

            treeID = treeID or C_ClassTalents.GetTraitTreeForSpec(specID);
            cache.classTreeMap[classID] = treeID;

            C_ClassTalents.InitializeViewLoadout(specID, level);
            C_ClassTalents.ViewLoadout({});

            nodes = nodes or C_Traits.GetTreeNodes(treeID);
            local treeCurrencyInfo = C_Traits.GetTreeCurrencyInfo(configID, treeID, true);
            local classCurrencyID = treeCurrencyInfo[1].traitCurrencyID;

            local treeInfo = C_Traits.GetTreeInfo(configID, treeID);
            for _, gateInfo in ipairs(treeInfo.gates) do
                local conditionID = gateInfo.conditionID;
                local conditionInfo = C_Traits.GetConditionInfo(configID, conditionID);
                gateData[conditionID] = {
                    currencyId = conditionInfo.traitCurrencyID,
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

                    data.visibleEdges = data.visibleEdges or {}
                    mergeTables(data.visibleEdges, nodeInfo.visibleEdges, 'targetNode');

                    data.conditionIDs = data.conditionIDs or {}
                    mergeTables(data.conditionIDs, nodeInfo.conditionIDs);

                    data.groupIDs = data.groupIDs or {}
                    mergeTables(data.groupIDs, nodeInfo.groupIDs);
                    for _, entryID in ipairs(nodeInfo.entryIDs) do
                        cache.entryTreeMap[entryID] = treeID;
                        if not entryData[entryID] then
                            local entryInfo = C_Traits.GetEntryInfo(configID, entryID);
                            entryData[entryID] = {
                                definitionID = entryInfo.definitionID,
                                type = entryInfo.type,
                                maxRanks = entryInfo.maxRanks,
                            }
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

                if lastSpec and not data.posX then
                    nodeData[nodeID] = nil;
                end
            end
        end

        cache.nodeData[treeID] = nodeData;
        cache.entryData[treeID] = entryData;
        cache.gateData[treeID] = gateData;
    end
end

buildCache();

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

--- @public
--- @param nodeId number # TraitNodeID
--- @return ( number | nil ) # TraitTreeID
function LibTalentTree:GetTreeIdForNode(nodeId)
    assert(type(nodeId) == 'number', 'nodeId must be a number');

    return self.cache.nodeTreeMap[nodeId];
end

--- @public
--- @param entryId number # TraitEntryID
--- @return ( number | nil ) # TraitTreeID
function LibTalentTree:GetTreeIdForEntry(entryId)
    assert(type(entryId) == 'number', 'entryId must be a number');

    return self.cache.entryTreeMap[entryId];
end

--- @public
--- @param treeId number # TraitTreeID, or TraitNodeID, if leaving the 2nd argument nil
--- @param nodeId number # TraitNodeID, can be omitted, by passing the nodeId as the first argument, the treeId is automatically determined
--- @return ( libNodeInfo | nil )
--- @overload fun(self: LibTalentTree-1.0, nodeId: number): libNodeInfo | nil
function LibTalentTree:GetLibNodeInfo(treeId, nodeId)
    assert(type(treeId) == 'number', 'treeId must be a number');
    if not nodeId then
        nodeId = treeId;
        treeId = self:GetTreeIdForNode(nodeId);
    end
    assert(type(nodeId) == 'number', 'nodeId must be a number');

    local nodeData = self.cache.nodeData;

    local nodeInfo = nodeData[treeId] and nodeData[treeId][nodeId] and deepCopy(nodeData[treeId][nodeId]) or nil;
    if (nodeInfo) then nodeInfo.ID = nodeId; end

    return nodeInfo;
end

--- @public
--- @param treeId number # TraitTreeID, or TraitEntryID, if leaving the 2nd argument nil
--- @param nodeId number # TraitNodeID, can be omitted, by passing the nodeId as the first argument, the treeId is automatically determined
--- @return ( libNodeInfo ) # libNodeInfo is enriched and overwritten by C_Traits information if possible
--- @overload fun(self: LibTalentTree-1.0, nodeId: number): libNodeInfo
function LibTalentTree:GetNodeInfo(treeId, nodeId)
    assert(type(treeId) == 'number', 'treeId must be a number');
    if not nodeId then
        nodeId = treeId;
        treeId = self:GetTreeIdForNode(nodeId);
    end
    assert(type(nodeId) == 'number', 'nodeId must be a number');

    local cNodeInfo = C_ClassTalents.GetActiveConfigID()
            and C_Traits.GetNodeInfo(C_ClassTalents.GetActiveConfigID(), nodeId)
            or C_Traits.GetNodeInfo(Constants.TraitConsts.VIEW_TRAIT_CONFIG_ID or -3, nodeId);
    local libNodeInfo = treeId and self:GetLibNodeInfo(treeId, nodeId);

    if (not libNodeInfo) then return cNodeInfo; end
    if (not cNodeInfo) then cNodeInfo = {}; end

    if cNodeInfo.ID == nodeId then
        cNodeInfo.specInfo = libNodeInfo.specInfo;
        cNodeInfo.isClassNode = libNodeInfo.isClassNode;
        cNodeInfo.visibleForSpecs = libNodeInfo.visibleForSpecs;
        cNodeInfo.grantedForSpecs = libNodeInfo.grantedForSpecs;

        return cNodeInfo;
    end

    return Mixin(cNodeInfo, libNodeInfo);
end

--- @public
--- @param treeId number # TraitTreeID, or TraitEntryID, if leaving the 2nd argument nil
--- @param entryId number # TraitEntryID, can be omitted, by passing the entryId as the first argument, the treeId is automatically determined
--- @return ( entryInfo | nil )
--- @overload fun(self: LibTalentTree-1.0, entryId: number): entryInfo | nil
function LibTalentTree:GetEntryInfo(treeId, entryId)
    assert(type(treeId) == 'number', 'treeId must be a number');
    if not entryId then
        entryId = treeId;
        treeId = self:GetTreeIdForEntry(entryId);
    end
    assert(type(entryId) == 'number', 'entryId must be a number');

    local entryData = self.cache.entryData;

    local entryInfo = entryData[treeId] and entryData[treeId][entryId] and deepCopy(entryData[treeId][entryId]) or nil;
    if (entryInfo) then
        entryInfo.isAvailable = true;
        entryInfo.conditionIDs = {};
    end

    return entryInfo;
end

--- @public
--- @param class (string | number) # ClassID or ClassFilename - e.g. "DEATHKNIGHT" or 6 - See https://warcraft.wiki.gg/wiki/ClassId
--- @return ( number | nil ) # TraitTreeID
function LibTalentTree:GetClassTreeId(class)
    assert(type(class) == 'string' or type(class) == 'number', 'class must be a string or number');

    local classFileMap = self.cache.classFileMap;
    local classTreeMap = self.cache.classTreeMap;

    local classId = classFileMap[class] or class;

    return classTreeMap[classId] or nil;
end

--- @public
--- @param treeId (number) # a class' TraitTreeID
--- @return (number | nil) # ClassID or nil - See https://warcraft.wiki.gg/wiki/ClassId
function LibTalentTree:GetClassIdByTreeId(treeId)
    treeId = tonumber(treeId);

    if not self.inverseClassMap then
        local classTreeMap = self.cache.classTreeMap;
        self.inverseClassMap = {};
        for classId, mappedTreeId in pairs(classTreeMap) do
            self.inverseClassMap[mappedTreeId] = classId;
        end
    end

    return self.inverseClassMap[treeId];
end

--- @public
--- @param specId number # See https://warcraft.wiki.gg/wiki/SpecializationID
--- @param nodeId number # TraitNodeID
--- @return boolean # whether the node is visible for the given spec
function LibTalentTree:IsNodeVisibleForSpec(specId, nodeId)
    assert(type(specId) == 'number', 'specId must be a number');
    assert(type(nodeId) == 'number', 'nodeId must be a number');

    local specMap = self.cache.specMap;
    local class = specMap[specId];
    assert(class, 'Unknown specId: ' .. specId);

    local treeId = self:GetClassTreeId(class);
    local nodeInfo = self:GetLibNodeInfo(treeId, nodeId);

    if not nodeInfo then return false; end

    -- >= 10.1.0
    if nodeInfo.visibleForSpecs then
        return nodeInfo.visibleForSpecs[specId];
    end

    -- < 10.1.0
    if (nodeInfo.specInfo[specId]) then
        for _, conditionType in pairs(nodeInfo.specInfo[specId]) do
            if (conditionType == Enum.TraitConditionType.Visible or conditionType == Enum.TraitConditionType.Granted) then
                return true;
            end
        end
    end
    for id, conditionTypes in pairs(nodeInfo.specInfo) do
        if (id ~= specId) then
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
--- @param specId number # See https://warcraft.wiki.gg/wiki/SpecializationID
--- @param nodeId number # TraitNodeID
--- @return boolean # whether the node is granted by default for the given spec
function LibTalentTree:IsNodeGrantedForSpec(specId, nodeId)
    assert(type(specId) == 'number', 'specId must be a number');
    assert(type(nodeId) == 'number', 'nodeId must be a number');

    local specMap = self.cache.specMap;
    local class = specMap[specId];
    assert(class, 'Unknown specId: ' .. specId);

    local treeId = self:GetClassTreeId(class);
    local nodeInfo = self:GetLibNodeInfo(treeId, nodeId);

    -- >= 10.1.0
    if nodeInfo and nodeInfo.grantedForSpecs then
        return nodeInfo.grantedForSpecs[specId];
    end

    -- < 10.1.0
    if (nodeInfo and nodeInfo.specInfo[specId]) then
        for _, conditionType in pairs(nodeInfo.specInfo[specId]) do
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
--- @param treeId number # TraitTreeID, or TraitNodeID, if leaving the 2nd parameter nil
--- @param nodeId number # TraitNodeID, can be omitted, by passing the nodeId as the first argument, the treeId is automatically determined
--- @return ( number|nil, number|nil ) # posX, posY - some trees have a global offset
--- @overload fun(self: LibTalentTree-1.0, nodeId: number): (number|nil, number|nil)
function LibTalentTree:GetNodePosition(treeId, nodeId)
    assert(type(treeId) == 'number', 'treeId must be a number');
    if not nodeId then
        nodeId = treeId;
        treeId = self:GetTreeIdForNode(nodeId);
    end
    assert(type(nodeId) == 'number', 'nodeId must be a number');

    local nodeInfo = self:GetLibNodeInfo(treeId, nodeId);
    if (not nodeInfo) then return nil, nil; end

    return nodeInfo.posX, nodeInfo.posY;
end

local gridPositionCache = {};

--- @public
--- Returns an abstraction of the node positions into a grid of columns and rows.
--- Some specs may have nodes that sit between 2 columns, these columns end in ".5". This happens for example in the Druid and Demon Hunter trees.
---
--- The top row is 1, the bottom row is 10
--- The first class column is 1, the last class column is 9
--- The first spec column is 10
---
--- @param treeId number # TraitTreeID, or TraitNodeID, if leaving the 2nd parameter nil
--- @param nodeId number # TraitNodeID, can be omitted, by passing the nodeId as the first argument, the treeId is automatically determined
--- @return ( number|nil, number|nil ) # column, row
--- @overload fun(self: LibTalentTree-1.0, nodeId: number): (number|nil, number|nil)
function LibTalentTree:GetNodeGridPosition(treeId, nodeId)
    assert(type(treeId) == 'number', 'treeId must be a number');
    if not nodeId then
        nodeId = treeId;
        treeId = self:GetTreeIdForNode(nodeId);
    end
    assert(type(nodeId) == 'number', 'nodeId must be a number');

    local classId = self:GetClassIdByTreeId(treeId);
    if not classId then return nil, nil end

    gridPositionCache[treeId] = gridPositionCache[treeId] or {};
    if gridPositionCache[treeId][nodeId] then
        return unpack(gridPositionCache[treeId][nodeId]);
    end

    local posX, posY = self:GetNodePosition(treeId, nodeId);
    if (not posX or not posY) then return nil, nil; end

    local offsetX = BASE_PAN_OFFSET_X - (CLASS_OFFSETS[classId] and CLASS_OFFSETS[classId].x or 0);
    local offsetY = BASE_PAN_OFFSET_Y - (CLASS_OFFSETS[classId] and CLASS_OFFSETS[classId].y or 0);

    posX = (round(posX) / 10) - offsetX;
    posY = (round(posY) / 10) - offsetY;

    local colStart = 176;
    local colSpacing = 60;
    local halfColEnabled = true;
    local classColEnd = 656;
    local specColStart = 956;
    local classSpecGap = specColStart - classColEnd;

    if (posX > (classColEnd + (classSpecGap / 2))) then
        -- remove the gap between the class and spec trees
        posX = posX - classSpecGap + colSpacing;
    end
    local col = getGridLineFromCoordinate(colStart, colSpacing, halfColEnabled, posX);

    local rowStart = 151;
    local rowSpacing = 60;
    local halfRowEnabled = false;

    local row = getGridLineFromCoordinate(rowStart, rowSpacing, halfRowEnabled, posY);

    gridPositionCache[treeId][nodeId] = {col, row};

    return col, row;
end

--- @public
--- @param treeId number # TraitTreeID, or TraitNodeID, if leaving the 2nd parameter nil
--- @param nodeId number # TraitNodeID, can be omitted, by passing the nodeId as the first argument, the treeId is automatically determined
--- @return ( nil | visibleEdge[] ) # The order might not match C_Traits
--- @overload fun(self: LibTalentTree-1.0, nodeId: number): nil | visibleEdge[]
function LibTalentTree:GetNodeEdges(treeId, nodeId)
    assert(type(treeId) == 'number', 'treeId must be a number');
    if not nodeId then
        nodeId = treeId;
        treeId = self:GetTreeIdForNode(nodeId);
    end
    assert(type(nodeId) == 'number', 'nodeId must be a number');

    local nodeInfo = self:GetLibNodeInfo(treeId, nodeId);
    if (not nodeInfo) then return nil; end

    return nodeInfo.visibleEdges;
end

--- @public
--- @param treeId number # TraitTreeID, or TraitNodeID, if leaving the 2nd parameter nil
--- @param nodeId number # TraitNodeID, can be omitted, by passing the nodeId as the first argument, the treeId is automatically determined
--- @return ( boolean | nil ) # true if the node is a class node, false for spec nodes, nil if unknown
--- @overload fun(self: LibTalentTree-1.0, nodeId: number): boolean | nil
function LibTalentTree:IsClassNode(treeId, nodeId)
    assert(type(treeId) == 'number', 'treeId must be a number');
    if not nodeId then
        nodeId = treeId;
        treeId = self:GetTreeIdForNode(nodeId);
    end
    assert(type(nodeId) == 'number', 'nodeId must be a number');

    local nodeInfo = self:GetLibNodeInfo(treeId, nodeId);
    if (not nodeInfo) then return nil; end

    return nodeInfo.isClassNode;
end

local gateCache = {}

--- @public
--- @param specId number # See https://warcraft.wiki.gg/wiki/SpecializationID
--- @return ( gateInfo[] ) # list of gates for the given spec, sorted by spending required
function LibTalentTree:GetGates(specId)
    -- an optimization step is likely trivial in 10.1.0, but well.. effort, and this also works fine still :)
    assert(type(specId) == 'number', 'specId must be a number');

    if (gateCache[specId]) then return deepCopy(gateCache[specId]); end
    local specMap = self.cache.specMap;
    local class = specMap[specId];
    assert(class, 'Unknown specId: ' .. specId);

    local treeId = self:GetClassTreeId(class);
    local gates = {};

    local nodesByConditions = {};
    local gateData = self.cache.gateData;
    local conditions = gateData[treeId];

    local nodeData = self.cache.nodeData;

    for nodeId, nodeInfo in pairs(nodeData[treeId]) do
        if (#nodeInfo.conditionIDs > 0 and self:IsNodeVisibleForSpec(specId, nodeId)) then
            for _, conditionId in pairs(nodeInfo.conditionIDs) do
                if conditions[conditionId] then
                    nodesByConditions[conditionId] = nodesByConditions[conditionId] or {};
                    nodesByConditions[conditionId][nodeId] = nodeInfo;
                end
            end
        end
    end

    for conditionId, gateInfo in pairs(conditions) do
        local nodes = nodesByConditions[conditionId];
        if (nodes) then
            local minX, minY, topLeftNode = 9999999, 9999999, nil;
            for nodeId, nodeInfo in pairs(nodes) do
                local roundedX, roundedY = round(nodeInfo.posX), round(nodeInfo.posY);

                if (roundedY < minY) then
                    minY = roundedY;
                    minX = roundedX;
                    topLeftNode = nodeId
                elseif (roundedY == minY and roundedX < minX) then
                    minX = roundedX;
                    topLeftNode = nodeId
                end
            end
            if (topLeftNode) then
                table.insert(gates, {
                    topLeftNodeID = topLeftNode,
                    conditionID = conditionId,
                    spentAmountRequired = gateInfo.spentAmountRequired,
                    traitCurrencyID = gateInfo.currencyId,
                });
            end
        end
    end
    table.sort(gates, function(a, b)
        return a.spentAmountRequired < b.spentAmountRequired;
    end);
    gateCache[specId] = gates;

    return deepCopy(gates);
end
