-- GearFrame.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 8/23/2024, 11:22:53 AM
--
---@class ns
local ns = select(2, ...)

local L = ns.L

local EQUIP_SLOTS = {
    {id = 1, name = HEADSLOT}, --
    {id = 2, name = NECKSLOT}, --
    {id = 3, name = SHOULDERSLOT}, --
    {id = 15, name = BACKSLOT}, --
    {id = 5, name = CHESTSLOT}, --
    {id = 9, name = WRISTSLOT}, --
    {id = 10, name = HANDSSLOT}, --
    {id = 6, name = WAISTSLOT}, --
    {id = 7, name = LEGSSLOT}, --
    {id = 8, name = FEETSLOT}, --
    {id = 11, name = FINGER0SLOT}, --
    {id = 12, name = FINGER1SLOT}, --
    {id = 13, name = TRINKET0SLOT}, --
    {id = 14, name = TRINKET1SLOT}, --
    {id = 16, name = MAINHANDSLOT}, --
    {id = 17, name = SECONDARYHANDSLOT}, --
    {id = 18, name = RANGEDSLOT}, --
}

local SPACING_V = 3
local SPACING_H = 5
local PADDING = 10
local BG_PADDING = 4

---@class UI.GearFrame : AceEvent-3.0, Frame, tdInspectGearFrameTemplate
---@field unit? UnitToken
---@field name? string
local GearFrame = ns.Addon:NewClass('UI.GearFrame', 'Frame')

function GearFrame:Create(parent, inspect)
    return self:Bind(CreateFrame('Frame', nil, parent, 'tdInspectGearFrameTemplate'), inspect)
end

function GearFrame:Constructor(_, inspect)
    self.inspect = inspect
    self:Hide()
    self:SetScript('OnSizeChanged', self.OnSizeChanged)

    local SlotColumn = CreateFrame('Frame', nil, self)
    SlotColumn:SetPoint('TOPLEFT', PADDING, 0)
    SlotColumn:SetHeight(1)
    self.SlotColumn = SlotColumn

    local LevelColumn = CreateFrame('Frame', nil, self)
    LevelColumn:SetPoint('TOPLEFT', SlotColumn, 'TOPRIGHT', SPACING_H, 0)
    LevelColumn:SetHeight(1)
    self.LevelColumn = LevelColumn

    ---@type table<number, UI.GearItem>
    self.gears = {}
    self.columnWidths = {}

    for i, v in ipairs(EQUIP_SLOTS) do
        local item = ns.UI.GearItem:New(self, v.id, v.name, self.inspect)
        local y = -(i - 1) * (item:GetHeight() + SPACING_V) - 80
        item:SetPoint('TOPLEFT', PADDING, y)
        self.gears[v.id] = item
    end

    self:SetUnit('player')
    self:SetClass(UnitClassBase('player'))
end

function GearFrame:Clear()
    self.unit = nil
    self.name = nil
    self.class = nil
    self:ResetColumnWidths()
end

function GearFrame:ResetColumnWidths()
    wipe(self.columnWidths)
end

function GearFrame:ApplyColumnWidth(key, width)
    self.columnWidths[key] = max(self.columnWidths[key] or 0, width)
    self:RequestUpdateSize()
end

function GearFrame:RequestUpdateSize()
    self:SetScript('OnUpdate', self.OnUpdate)
end

function GearFrame:OnSizeChanged(width, height)
    width = width - BG_PADDING * 2
    height = height - BG_PADDING * 2
    self.TopLeft:SetSize(width * 256 / 300, height * 256 / 330)
    self.TopRight:SetSize(width * 44 / 300, height * 256 / 330)
    self.BottomLeft:SetSize(width * 256 / 300, height * 74 / 330)
    self.BottomRight:SetSize(width * 44 / 300, height * 74 / 330)
end

function GearFrame:OnUpdate()
    self:SetScript('OnUpdate', nil)
    self:UpdateSize()
end

function GearFrame:UpdateSize()
    local width = 0
    for key, v in pairs(self.columnWidths) do
        width = width + v + SPACING_H

        if self[key] then
            self[key]:SetWidth(v)
        end
    end
    self:SetWidth(max(width - SPACING_V + PADDING * 2, 165 + self.Name:GetStringWidth()))
end

function GearFrame:SetClass(class)
    self.class = class
end

function GearFrame:SetUnit(unit, name)
    if unit and not UnitExists(unit) then
        unit = nil
    end
    self.unit, self.name = unit, name

    if unit then
        self.class = UnitClassBase(unit)
    end
end

function GearFrame:UpdateName()
    local name = self.name or ns.UnitName('player')
    self.Name:SetText(name and Ambiguate(name, 'none') or '')
end

function GearFrame:UpdateClass()
    if not self.class then
        return
    end

    local color = RAID_CLASS_COLORS[self.class]
    self.Name:SetTextColor(color.r, color.g, color.b)
    self:SetBackdropBorderColor(color.r, color.g, color.b)
    self.Portrait.PortraitRingQuality:SetVertexColor(color.r, color.g, color.b)
    self.Portrait.LevelBorder:SetVertexColor(color.r, color.g, color.b)
end

function GearFrame:UpdatePortrait()
    local name = self.name or ns.UnitName(self.unit)
    self.Name:SetText(name and Ambiguate(name, 'none') or '')

    if self.unit then
        SetPortraitTexture(self.Portrait.Portrait, self.unit)
        self.Portrait.Portrait:SetTexCoord(0, 1, 0, 1)
    elseif self.class then
        self.Portrait.Portrait:SetTexture([[Interface\TargetingFrame\UI-Classes-Circles]])
        self.Portrait.Portrait:SetTexCoord(unpack(CLASS_ICON_TCOORDS[self.class]))
    else
        self.Portrait.Portrait:SetTexture([[Interface\Icons\INV_Misc_QuestionMark]])
        self.Portrait.Portrait:SetTexCoord(0, 1, 0, 1)
    end
end

function GearFrame:SetItemLevel(level)
    self.ItemLevel:SetFormattedText('%s %.1f', L['iLvl:'], level or 0)
end

function GearFrame:SetLevel(level)
    self.Portrait.Level:SetText(level or '')
end

function GearFrame:SetBackground(background)
    if not background then
        self.TopLeft:Hide()
        self.TopRight:Hide()
        self.BottomLeft:Hide()
        self.BottomRight:Hide()
        self:SetBackdropColor(0, 0, 0, 0.95)
    else
        local base = [[Interface\TalentFrame\]] .. background .. '-'
        self.TopLeft:SetTexture(base .. 'TopLeft')
        self.TopRight:SetTexture(base .. 'TopRight')
        self.BottomLeft:SetTexture(base .. 'BottomLeft')
        self.BottomRight:SetTexture(base .. 'BottomRight')
        self.TopLeft:Show()
        self.TopRight:Show()
        self.BottomLeft:Show()
        self.BottomRight:Show()
        self:SetBackdropColor(0, 0, 0, 0)
    end
end

function GearFrame:UpdateTalents()
    local numGroups = self:GetNumTalentGroups()
    local activeGroup = self:GetActiveTalentGroup()
    if numGroups <= 1 then
        self.Talent2:Hide()
        self:UpdateTalent(self.Talent1, activeGroup, true)
    else
        self:UpdateTalent(self.Talent1, activeGroup, true)
        self:UpdateTalent(self.Talent2, activeGroup == 1 and 2 or 1, false)
    end
end

function GearFrame:UpdateTalent(button, group, isActive)
    button.id = group
    button.isActive = isActive

    local name, icon, bg, points = self:GetTalentInfo(group)
    if name then
        button.Icon:SetTexture(icon)
        button.Text:SetText(name)
        button.Point:SetText(points)
        button:Show()
    else
        button:Hide()
    end

    if isActive then
        if ns.Addon.db.profile.showTalentBackground then
            self:SetBackground(bg)
        else
            self:SetBackground()
        end
    end
end

function GearFrame:OptionOnClick()
    ns.Addon:OpenOptionFrame()
end

function GearFrame:UpdateOptionButton(value)
    self.Option:SetShown(value)
end
