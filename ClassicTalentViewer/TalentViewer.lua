local name, ns = ...

if LE_EXPANSION_LEVEL_CURRENT > LE_EXPANSION_SHADOWLANDS then print('[' .. name .. ']: this addon does not work in dragonflight or beyond') return end

local MAX_TALENT_TIERS = 6
local SPEC_SPECIFIC_TALENTS = false -- not sure what expansion this happened, but might as well reuse the old code that was prepared for it :)

--- @class ClassicTalentViewer
ClassicTalentViewer = {
    cache = {
        classNames = {},
        classFiles = {},
        classIconId = {},
        talents = {},
        classSpecs = {},
        sortedTalents = {},
        sharedTalents = {},
        nodes = {},
        tierLevel = {},
        specNames = {},
        specIndexToIdMap = {},
        specIdToClassIdMap = {},
        specIconId = {},
        defaultSpecs = {},
    }
}
local cache = ClassicTalentViewer.cache
local LibDBIcon = LibStub('LibDBIcon-1.0')

----------------------
--- Reorganize data
----------------------
do
    local _
    cache.specs = ns.data.specs
    cache.talents = ns.data.talents
    cache.classes = ns.data.classes

    for tier = 1, MAX_TALENT_TIERS do
        _, _, cache.tierLevel[tier] = GetTalentTierInfo(tier, 1)
    end

    for _, classInfo in pairs(cache.classes) do
        cache.classNames[classInfo.classId], cache.classFiles[classInfo.classId], _ = GetClassInfo(classInfo.classId)
        cache.sharedTalents[classInfo.classId] = {}
        cache.specIndexToIdMap[classInfo.classId] = {}
        cache.classSpecs[classInfo.classId] = {}
        cache.defaultSpecs[classInfo.classId] = classInfo.defaultSpecId
        cache.classIconId[classInfo.classId] = classInfo.iconId
    end

    for _, specInfo in pairs(cache.specs) do
        if cache.classNames[specInfo.classId] and specInfo.index < 5 then
            local _, specName, _, specIconId = GetSpecializationInfoByID(specInfo.specId)
            cache.classSpecs[specInfo.classId][specInfo.specId] = specName
            cache.specNames[specInfo.specId] = specName
            cache.specIndexToIdMap[specInfo.classId][specInfo.index] = specInfo.specId
            cache.specIconId[specInfo.specId] = specIconId
            cache.sortedTalents[specInfo.specId] = {}
            cache.specIdToClassIdMap[specInfo.specId] = specInfo.classId;
        end
    end

    for _, talentInfo in pairs(cache.talents) do
        if talentInfo.specId > 0 then
            cache.sortedTalents[talentInfo.specId][talentInfo.row .. '-' .. talentInfo.column] = talentInfo
        else
            cache.sharedTalents[talentInfo.classId][talentInfo.row .. '-' .. talentInfo.column] = talentInfo
        end
    end
end

----------------------
--- Script handles
----------------------
do
    function TalentViewer_PlayerTalentFrameTalents_OnLoad()
        table.insert(UISpecialFrames, 'TalentViewer_PlayerTalentFrame')
        ClassicTalentViewer:InitDropDown()
        local specId
        local _, _, classId = UnitClass('player')
        local currentSpec = C_SpecializationInfo.GetSpecialization()
        if currentSpec then
            specId = cache.specIndexToIdMap[classId][currentSpec]
        end
        specId = specId or cache.defaultSpecs[classId]
        ClassicTalentViewer:SelectSpec(classId, specId)
    end

    --- @param self TalentViewer_PlayerTalentButtonTemplate
    function TalentViewer_PlayerTalentButton_OnLoad(self)
        self.icon:ClearAllPoints()
        self.name:ClearAllPoints()
        self.icon:SetPoint('LEFT', 35, 0)
        self.name:SetSize(90, 35)
        self.name:SetPoint('LEFT', self.icon, 'RIGHT', 10, 0)

        self:RegisterForClicks('LeftButtonUp')
    end

    --- @param self TalentViewer_PlayerTalentButtonTemplate
    function TalentViewer_PlayerTalentButton_OnClick(self)
        if (IsModifiedClick('CHATLINK')) then
            local spellName, _, _, _ = GetSpellInfo(self:GetID())
            local talentLink, _ = GetSpellLink(self:GetID())
            if ( MacroFrameText and MacroFrameText:HasFocus() ) then
                if ( spellName and not IsPassiveSpell(spellName) ) then
                    local subSpellName = GetSpellSubtext(spellName)
                    if ( subSpellName ) then
                        if ( subSpellName ~= '' ) then
                            ChatEdit_InsertLink(spellName..'('..subSpellName..')')
                        else
                            ChatEdit_InsertLink(spellName)
                        end
                    else
                        ChatEdit_InsertLink(spellName)
                    end
                end
            elseif ( talentLink ) then
                ChatEdit_InsertLink(talentLink)
            end
        end
    end

    --- @param self TalentViewer_PlayerTalentButtonTemplate
    function TalentViewer_PlayerTalentButton_OnEnter(self)
        GameTooltip:SetOwner(self, 'ANCHOR_RIGHT')
        GameTooltip:SetSpellByID(self:GetID())
    end

    function TalentViewer_PlayerTalentButton_OnLeave()
        GameTooltip_Hide()
    end
end

local frame = CreateFrame('FRAME')
local function OnEvent(_, event, ...)
    if event == 'ADDON_LOADED' then
        local addonName = ...
        if addonName == name then
            ClassicTalentViewer:OnInitialize()
            if C_AddOns.IsAddOnLoaded('BlizzMove') then ClassicTalentViewer:RegisterToBlizzMove() end
        end
        if addonName == 'Blizzard_TalentUI' then
            ClassicTalentViewer:AddButtonToBlizzardTalentFrame()
        end
    end
    if event == 'PLAYER_ENTERING_WORLD' then
        ClassicTalentViewer:OnPlayerEnteringWorld()
        frame:UnregisterEvent('PLAYER_ENTERING_WORLD')
    end
end
frame:HookScript('OnEvent', OnEvent)
frame:RegisterEvent('ADDON_LOADED')
frame:RegisterEvent('PLAYER_ENTERING_WORLD')

function ClassicTalentViewer:OnPlayerEnteringWorld()
    if TalentViewer_PlayerTalentFrame:IsShown() then return end
    local specId
    local _, _, classId = UnitClass('player')
    local currentSpec = C_SpecializationInfo.GetSpecialization()
    if currentSpec then
        specId = cache.specIndexToIdMap[classId][currentSpec]
    end
    specId = specId or cache.defaultSpecs[classId]
    ClassicTalentViewer:SelectSpec(classId, specId)
end

function ClassicTalentViewer:OnInitialize()
    ClassicTalentViewerDB = ClassicTalentViewerDB or {}
    self.db = ClassicTalentViewerDB

    if not self.db.ldbOptions then
        self.db.ldbOptions = {
            hide = false,
        }
    end
    local dataObject = LibStub('LibDataBroker-1.1'):NewDataObject(
        name,
        {
            type = 'data source',
            text = 'Classic Talent Viewer',
            icon = '133740',
            OnClick = function()
                if IsShiftKeyDown() then
                    ClassicTalentViewer.db.ldbOptions.hide = true
                    LibDBIcon:Hide(name)
                    return
                end
                ClassicTalentViewer:ToggleTalentView()
            end,
            OnTooltipShow = function(tooltip)
                tooltip:AddLine('Classic Talent Viewer')
                tooltip:AddLine('|cffeda55fClick|r to view the talents for any spec.')
                tooltip:AddLine('|cffeda55fShift-Click|r to hide this button. (|cffeda55f/ctv reset|r to restore)')
            end,
        }
    )
    LibDBIcon:Register(name, dataObject, self.db.ldbOptions)

    SLASH_CLASSIC_TALENT_VIEWER1 = '/ctv'
    SLASH_CLASSIC_TALENT_VIEWER2 = '/tv'
    SLASH_CLASSIC_TALENT_VIEWER3 = '/classictalentviewer'
    SLASH_CLASSIC_TALENT_VIEWER4 = '/talentviewer'
    SlashCmdList['CLASSIC_TALENT_VIEWER'] = function(message)
        if message == 'reset' then
            wipe(ClassicTalentViewer.db.ldbOptions)
            ClassicTalentViewer.db.ldbOptions.hide = false
            ClassicTalentViewer.db.lastSelected = nil

            LibDBIcon:Hide(name)
            LibDBIcon:Show(name)

            return
        end
        ClassicTalentViewer:ToggleTalentView()
    end
end

function ClassicTalentViewer:ToggleTalentView()
    TalentViewer_PlayerTalentFrame:SetShown(not TalentViewer_PlayerTalentFrame:IsShown())
end

--- @param classId number
--- @param specId number
--- @param skipDropdownUpdate boolean?
function ClassicTalentViewer:SelectSpec(classId, specId, skipDropdownUpdate)
    assert(type(classId) == 'number', 'classId must be a number')
    assert(type(specId) == 'number', 'specId must be a number')

    self.selectedClassId = classId
    self.selectedSpecId = SPEC_SPECIFIC_TALENTS and specId or cache.specIndexToIdMap[classId][1]
    self:SetClassIcon(classId)

    TalentViewer_PlayerTalentFrame:SetTitleFormatted(
        SPEC_SPECIFIC_TALENTS and '%s %s - %s' or '%s %s',
        cache.classNames[classId],
        TALENTS,
        cache.classSpecs[classId][specId]
    )

    for tier = 1, MAX_TALENT_TIERS do
        local talentRow = TalentViewer_PlayerTalentFrameTalents['tier'..tier]
        for column = 1, NUM_TALENT_COLUMNS do
            local node = tier .. '-' .. column
            local talentInfo = self:GetTalentInfoByNode(node)
            if talentInfo then
                local spellName, _, icon, _ = GetSpellInfo(talentInfo.spellId)

                --- @type TalentViewer_PlayerTalentButtonTemplate
                local button = talentRow['talent'..column]
                button.tier = tier
                button.column = column

                button:SetID(talentInfo.spellId)

                button.icon:SetTexture(icon)
                button.name:SetText(spellName)
            end
        end

        if(talentRow.level ~= nil) then
            talentRow.level:SetText(cache.tierLevel[tier])
        end
    end

    if not skipDropdownUpdate then
        self.dropDownButton:PickSpecID(specId);
    end
end

function ClassicTalentViewer:GetTalentInfoByNode(node)
    local talentInfo = cache.sortedTalents[self.selectedSpecId][node] or cache.sharedTalents[self.selectedClassId][node] or nil
    if not talentInfo then
        print(string.format(
            'error: could not find a talent in row-col %s, for class [%s (%d)] spec [%s (%d)]',
            node,
            cache.classNames[self.selectedClassId],
            self.selectedClassId,
            cache.classSpecs[self.selectedClassId][self.selectedSpecId],
            self.selectedSpecId
        ))

        return nil
    end

    return talentInfo
end

function ClassicTalentViewer:SetClassIcon(classId)
    local class = cache.classFiles[classId]
    TalentViewer_PlayerTalentFrame:SetPortraitTextureRaw('Interface\\TargetingFrame\\UI-Classes-Circles')
    TalentViewer_PlayerTalentFrame:SetPortraitTexCoord(unpack(CLASS_ICON_TCOORDS[class]))
end

function ClassicTalentViewer:InitDropDown()
    if self.dropDownButton then return; end
    --- @class TalentViewer_DropdownButton
    self.dropDownButton = TalentViewer_PlayerTalentFrame.DropdownButton;

    self.dropDownButton:SetupMenu(function(owner, rootDescription)
        rootDescription:CreateTitle(SPEC_SPECIFIC_TALENTS and 'Select another Specialization' or 'Select another Class');
        self:BuildMenu(rootDescription);
    end);
    self.dropDownButton:SetSelectionText(function(selections)
        return SPEC_SPECIFIC_TALENTS and selections[2].text or selections[1].text;
    end);

    local specList = {};
    local specListReverse = {};
    local index = 1;
    for classID, _ in ipairs(cache.classSpecs) do
        for _, specID in ipairs(cache.specIndexToIdMap[classID]) do
            specList[index] = specID;
            specListReverse[specID] = index;
            index = index + 1;
            if not SPEC_SPECIFIC_TALENTS then break; end
        end
    end

    self.dropDownButton:EnableMouseWheel(true);
    function self.dropDownButton:Increment()
        local currentSpecIndex = specListReverse[ClassicTalentViewer.selectedSpecId];
        local nextSpecIndex = currentSpecIndex + 1;
        if nextSpecIndex > #specList then
            nextSpecIndex = 1;
        end
        self:PickSpecID(specList[nextSpecIndex]);
    end
    function self.dropDownButton:Decrement()
        local currentSpecIndex = specListReverse[ClassicTalentViewer.selectedSpecId];
        local previousSpecIndex = currentSpecIndex - 1;
        if previousSpecIndex < 1 then
            previousSpecIndex = #specList;
        end
        self:PickSpecID(specList[previousSpecIndex]);
    end
    function self.dropDownButton:PickSpecID(specID)
        MenuUtil.TraverseMenu(self:GetMenuDescription(), function(description)
            if description.data == (SPEC_SPECIFIC_TALENTS and specID or cache.specIdToClassIdMap[specID]) then
                self:Pick(description, MenuInputContext.None)
            end
        end);
    end
end

--- @param rootDescription RootMenuDescriptionProxy
function ClassicTalentViewer:BuildMenu(rootDescription)
    local function isClassSelected(classID)
        return classID == self.selectedClassId;
    end
    local function isSpecSelected(specID)
        return specID == self.selectedSpecId;
    end
    local function selectClass(classID)
        self:SelectSpec(classID, cache.specIndexToIdMap[classID][1], true);
    end
    local function selectSpec(specID)
        self:SelectSpec(cache.specIdToClassIdMap[specID], specID, true);
    end

    for classID, _ in ipairs(cache.classSpecs) do
        local nameFormat = '|T%s:16|t %s';
        local elementDescription = rootDescription:CreateRadio(
            nameFormat:format(
                'interface/icons/classicon_' .. cache.classFiles[classID],
                cache.classNames[classID]
            ),
            isClassSelected,
            (not SPEC_SPECIFIC_TALENTS) and selectClass or nil,
            classID
        );
        if SPEC_SPECIFIC_TALENTS then
            for _, specID in ipairs(cache.specIndexToIdMap[classID]) do
                elementDescription:CreateRadio(
                    nameFormat:format(
                        cache.specIconId[specID],
                        cache.specNames[specID]
                    ),
                    isSpecSelected,
                    selectSpec,
                    specID
                );
            end
        end
    end
end

function ClassicTalentViewer:RegisterToBlizzMove()
    --- @type BlizzMoveAPI
    local BlizzMoveAPI = _G.BlizzMoveAPI ---@diagnostic disable-line: undefined-field
    if not BlizzMoveAPI then return end
    BlizzMoveAPI:RegisterAddOnFrames(
        { [name] = { ['TalentViewer_PlayerTalentFrame'] = {} } }
    )
end

function ClassicTalentViewer:AddButtonToBlizzardTalentFrame()
    local button = CreateFrame('Button', nil, PlayerTalentFrame, 'UIPanelButtonTemplate');
    PlayerTalentFrame.ClassicTalentViewer_OpenViewerButton = button;
    button:SetText('Talent Viewer');
    button:SetSize(100, 22);
    button:SetPoint('TOPRIGHT', PlayerTalentFrame, 'TOPRIGHT', -44, 0);
    button:SetScript('OnClick', function()
        self:ToggleTalentView();
    end);
    button:SetFrameStrata('HIGH');
end
