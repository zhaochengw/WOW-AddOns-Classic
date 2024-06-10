-- PaperDoll.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 5/18/2020, 1:22:16 PM
--
---@type ns
local ns = select(2, ...)

local ipairs = ipairs
local pairs = pairs

local UnitLevel = UnitLevel
local UnitClass = UnitClass
local UnitRace = UnitRace
local GetClassColor = GetClassColor
local CreateFrame = CreateFrame

local PLAYER_LEVEL = PLAYER_LEVEL:gsub('%%d', '%%s')

local L = ns.L
local Inspect = ns.Inspect

---@class UI.PaperDoll: Object, Frame, AceEvent-3.0
local PaperDoll = ns.Addon:NewClass('UI.PaperDoll', 'Frame')

function PaperDoll:Constructor()
    self:SuperCall('UnregisterAllEvents')
    self:SetScript('OnEvent', nil)

    self.buttons = {}

    for _, button in ipairs {
        InspectHeadSlot, InspectNeckSlot, InspectShoulderSlot, InspectBackSlot, InspectChestSlot, InspectShirtSlot,
        InspectTabardSlot, InspectWristSlot, InspectHandsSlot, InspectWaistSlot, InspectLegsSlot, InspectFeetSlot,
        InspectFinger0Slot, InspectFinger1Slot, InspectTrinket0Slot, InspectTrinket1Slot, InspectMainHandSlot,
        InspectSecondaryHandSlot, InspectRangedSlot,
    } do
        self.buttons[button:GetID()] = ns.UI.SlotItem:Bind(button)
    end

    do
        local t1 = InspectMainHandSlot:CreateTexture(nil, 'BACKGROUND', 'Char-BottomSlot', -1)
        t1:ClearAllPoints()
        t1:SetPoint('TOPLEFT', -4, 8)

        local t2 = InspectMainHandSlot:CreateTexture(nil, 'BACKGROUND', 'Char-Slot-Bottom-Left')
        t2:ClearAllPoints()
        t2:SetPoint('TOPRIGHT', t1, 'TOPLEFT')

        local t3 = InspectSecondaryHandSlot:CreateTexture(nil, 'BACKGROUND', 'Char-BottomSlot', -1)
        t3:ClearAllPoints()
        t3:SetPoint('TOPLEFT', -4, 8)

        local t4 = InspectRangedSlot:CreateTexture(nil, 'BACKGROUND', 'Char-BottomSlot', -1)
        t4:ClearAllPoints()
        t4:SetPoint('TOPLEFT', -4, 8)

        local t5 = InspectRangedSlot:CreateTexture(nil, 'BACKGROUND', 'Char-Slot-Bottom-Right')
        t5:ClearAllPoints()
        t5:SetPoint('TOPLEFT', t4, 'TOPRIGHT')
    end

    ---@type CheckButton
    local ToggleButton = CreateFrame('CheckButton', nil, self)
    do
        ToggleButton:SetSize(20, 20)
        ToggleButton:SetPoint('BOTTOMLEFT', 23, 85)
        ToggleButton:SetNormalTexture([[Interface\Buttons\UI-CheckBox-Up]])
        ToggleButton:SetPushedTexture([[Interface\Buttons\UI-CheckBox-Down]])
        ToggleButton:SetCheckedTexture([[Interface\Buttons\UI-CheckBox-Check]])
        ToggleButton:SetHighlightTexture([[Interface\Buttons\UI-CheckBox-Highlight]], 'ADD')
        ToggleButton:SetFontString(ToggleButton:CreateFontString(nil, 'ARTWORK', 'GameFontNormalSmall'))
        ToggleButton:GetFontString():SetPoint('LEFT', ToggleButton, 'RIGHT', 0, 0)
        ToggleButton:SetNormalFontObject('GameFontNormalSmall')
        ToggleButton:SetHighlightFontObject('GameFontHighlightSmall')
        ToggleButton:SetText(L['Show Model'])

        ToggleButton:SetScript('OnClick', function(ToggleButton)
            ns.Addon.db.profile.showModel = not not ToggleButton:GetChecked()

            self:UpdateInset()
        end)
    end

    ---@type Texture
    local RaceBackground = self:CreateTexture(nil, 'ARTWORK')
    do
        RaceBackground:SetPoint('TOPLEFT', 65, -76)
        RaceBackground:SetPoint('BOTTOMRIGHT', -85, 115)
        RaceBackground:SetAtlas('transmog-background-race-draenei')
    end

    local LastUpdate = self:CreateFontString(nil, 'OVERLAY', 'GameFontNormalSmallLeft')
    do
        LastUpdate:SetPoint('BOTTOMLEFT', self, 'BOTTOMRIGHT', -130, 85)
    end

    self.RaceBackground = RaceBackground
    self.LastUpdate = LastUpdate
    self.ToggleButton = ToggleButton
    self.LevelText = InspectLevelText
    self.ModelFrame = ns.UI.ModelFrame:Bind(self:CreateInsetFrame())
    self.EquipFrame = ns.UI.EquipFrame:Bind(self:CreateInsetFrame())

    self:SetScript('OnShow', self.OnShow)
    self:SetScript('OnHide', self.OnHide)
end

function PaperDoll:OnShow()
    self:RegisterMessage('INSPECT_READY')
    self:RegisterEvent('UNIT_LEVEL', 'UpdateInfo')
    self:UpdateControls()
    self:UpdateInset()
    self:UpdateInfo()
    self:Update()
end

function PaperDoll:INSPECT_READY()
    self:Update()
    self:UpdateInfo()
end

function PaperDoll:OnHide()
    self:UnregisterAllEvents()
    self:UnregisterAllMessages()
end

function PaperDoll:CreateInsetFrame()
    local frame = CreateFrame('Frame', nil, self)
    frame:SetPoint('TOPLEFT', 65, -76)
    frame:SetPoint('BOTTOMRIGHT', -85, 115)
    return frame
end

function PaperDoll:UpdateControls()
    self.ToggleButton:SetChecked(ns.Addon.db.profile.showModel)
end

function PaperDoll:Update()
    for _, button in pairs(self.buttons) do
        button:Update()
    end
end

function PaperDoll:UpdateInfo()
    local level = Inspect:GetUnitLevel()
    local class = Inspect:GetUnitClass()
    local race = Inspect:GetUnitRace()
    local classFileName = Inspect:GetUnitClassFileName()
    local raceFileName = Inspect:GetUnitRaceFileName()
    local lastUpdate = Inspect:GetLastUpdate()

    self.LevelText:SetFormattedText(PLAYER_LEVEL, level or '??', race or '',
                                    class and ns.strcolor(class, GetClassColor(classFileName)) or '')

    if raceFileName then
        if raceFileName == 'Scourge' then
            raceFileName = 'Undead'
        end
        self.RaceBackground:SetAtlas('transmog-background-race-' .. raceFileName)
    else
        self.RaceBackground:SetAtlas(UnitFactionGroup('player') == 'Alliance' and 'transmog-background-race-draenei' or
                                         'transmog-background-race-bloodelf')
    end

    if lastUpdate then
        self.LastUpdate:SetFormattedText('%s\n|cffffffff%s|r', L['Last update:'], FriendsFrame_GetLastOnline(lastUpdate))
    else
        self.LastUpdate:SetText('')
    end
end

function PaperDoll:UpdateInset()
    local checked = ns.Addon.db.profile.showModel
    self.ModelFrame:SetShown(checked)
    self.EquipFrame:SetShown(not checked)
end
