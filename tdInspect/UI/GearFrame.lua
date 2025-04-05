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

---@class UI.GearFrame : EventHandler, Frame, tdInspectGearFrameTemplate
---@field unit? UnitToken
---@field name? string
local GearFrame = ns.Addon:NewClass('UI.GearFrame', 'Frame')

GearFrame.BG_PADDING = 4

function GearFrame:Create(parent, inspect)
    return self:Bind(CreateFrame('Frame', nil, parent, 'tdInspectGearFrameTemplate'), inspect)
end

local function PortraitOnEnter(self)
    GameTooltip:SetOwner(self, 'ANCHOR_RIGHT')
    GameTooltip:SetText(CHARACTER, NORMAL_FONT_COLOR:GetRGB())
    GameTooltip:AddLine(ns.LEFT_MOUSE_BUTTON .. L['Switch my characters'], HIGHLIGHT_FONT_COLOR:GetRGB())
    GameTooltip:Show()
end

local function SpecOnEnter(self)
    GameTooltip:SetOwner(self, 'ANCHOR_RIGHT')
    GameTooltip:SetText(self.id == 1 and TALENT_SPEC_PRIMARY or TALENT_SPEC_SECONDARY)
    if self.isActive then
        GameTooltip:AddLine(L['Active talent'], GREEN_FONT_COLOR:GetRGB())
    end

    local parent = self:GetParent()

    local name, icon, _, points = parent:GetTalentInfo(self.id)
    GameTooltip:AddLine(name .. '  ' .. points, HIGHLIGHT_FONT_COLOR:GetRGB())

    if not parent.isInspect then
        GameTooltip:AddLine(' ')
        if not self.isActive then
            GameTooltip:AddLine(ns.LEFT_MOUSE_BUTTON .. L['Switch talent'], HIGHLIGHT_FONT_COLOR:GetRGB())
        end
        GameTooltip:AddLine(ns.RIGHT_MOUSE_BUTTON .. L['Bind with EquipmentSet'], HIGHLIGHT_FONT_COLOR:GetRGB())
    end

    GameTooltip:Show()
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

    ns.UI.MenuButton:Bind(self.Portrait, function()
        return self:CreateCharecterMenu()
    end)

    self.Portrait:SetScript('OnClick', self.Portrait.ToggleMenu)
    self.Portrait:SetScript('OnEnter', PortraitOnEnter)
    self.Portrait:SetScript('OnLeave', GameTooltip_Hide)

    self.Talent1:SetScript('OnEnter', SpecOnEnter)
    self.Talent1:SetScript('OnLeave', GameTooltip_Hide)
    self.Talent2:SetScript('OnEnter', SpecOnEnter)
    self.Talent2:SetScript('OnLeave', GameTooltip_Hide)

    self.Talent1:RegisterForClicks('LeftButtonUp', 'RightButtonUp')
    self.Talent2:RegisterForClicks('LeftButtonUp', 'RightButtonUp')
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
    width = width - self.BG_PADDING * 2
    height = height - self.BG_PADDING * 2
    self.TopLeft:SetSize(width * 256 / 300, height * 256 / 330)
    self.TopRight:SetSize(width * 44 / 300, height * 256 / 330)
    self.BottomLeft:SetSize(width * 256 / 300, height * 74 / 330)
    self.BottomRight:SetSize(width * 44 / 300, height * 74 / 330)
end

function GearFrame:OnUpdate()
    self:SetScript('OnUpdate', nil)
    self:UpdateSize()
end

local function Checked(button)
    return button.arg1 == ns.Inspect.unitName
end

local function EquipmentSetChecked(button)
    return button.arg1 == ns.Inspect.unitName and button.arg2 == ns.Inspect.setName
end

local function Execute(_, name, setName)
    ns.Inspect:Query(nil, name, setName, true)
end

function GearFrame:CreateCharecterMenu()
    local menu = {}
    local lowLevelMenu = {}
    local characters = ns.Addon:GetCharacters()
    local touchedOther = false

    tinsert(menu, {text = L['Current realm characters'], isTitle = true, notCheckable = true})

    for _, item in ipairs(characters) do
        local targetMenu = item.low and lowLevelMenu or menu

        local char = ns.db.global.characters[item.name] or ns.otherCharacters[item.name]
        -- local hasArrow = not not (char and char.equipmentSets and next(char.equipmentSets))

        if not item.sameRealm and not touchedOther then
            tinsert(menu, {text = L['Other realm characters'], isTitle = true, notCheckable = true})
            touchedOther = true
        end

        tinsert(targetMenu, {
            text = item.coloredName,
            arg1 = item.name,
            checked = Checked,
            func = Execute,
            -- hasArrow = hasArrow,
            -- menuList = hasArrow and (function()
            --     local subMenu = {}
            --     for setName in pairs(char.equipmentSets) do
            --         tinsert(subMenu, {
            --             text = setName,
            --             arg1 = item.name,
            --             arg2 = setName,
            --             checked = EquipmentSetChecked,
            --             func = Execute,
            --         })
            --     end
            --     return subMenu
            -- end)(),
        })
    end

    if ns.db.profile.showLowLevelCharacters and #lowLevelMenu > 0 then
        tinsert(menu, {text = L['Low level characters'], notCheckable = true, hasArrow = true, menuList = lowLevelMenu})
    end

    if not ns.hasAnyAccount then
        tinsert(menu, ns.DROPDOWN_SEPARATOR)
        tinsert(menu, {
            text = [[|TInterface\Common\help-i:24:24:0:0:64:64:10:54:10:54|t]] .. L['See other account character?'],
            notCheckable = true,
            func = function()
                LibStub('tdOptions'):Open('tdSupport')
            end,
        })
    end

    return menu
end

function GearFrame:UpdateSize()
    local width = 0
    for key, v in pairs(self.columnWidths) do
        width = width + v + SPACING_H

        if self[key] then
            self[key]:SetWidth(v)
        end
    end

    local widthGear = width - SPACING_V + PADDING * 2
    local widthHeader = 90 + max(self.Name:GetStringWidth(), self.ItemLevel:GetStringWidth())

    if self.Talent1:IsShown() then
        widthHeader = widthHeader + 48
    end
    if self.Talent2:IsShown() then
        widthHeader = widthHeader + 38
    end

    self:SetWidth(max(widthGear, widthHeader))
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

    C_Timer.After(0, function()
        self.Name:SetWidth(self.Name:GetUnboundedStringWidth() + 10)
    end)
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
        self:UpdateTalent(self.Talent1, activeGroup, true, true)
    else
        self:UpdateTalent(self.Talent1, activeGroup, true)
        self:UpdateTalent(self.Talent2, activeGroup == 1 and 2 or 1, false)
    end
end

function GearFrame:UpdateTalent(button, group, isActive, onlyOne)
    button.id = group
    button.isActive = isActive

    local name, icon, bg, points = self:GetTalentInfo(group)
    if name then
        button.Icon:SetTexture(icon)
        if onlyOne then
            button.Text:SetText(name)
        else
            button.Text:SetFormattedText('%s: %s', group == 1 and L.Major or L.Minor, name)
        end
        button.Point:SetText(points)
        button:Show()
    else
        button:Hide()
    end

    if isActive then
        if ns.db.profile.showTalentBackground then
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

function GearFrame:TapTo(frame, position)
    self:SetParent(frame)
    self:ClearAllPoints()

    if position == 'TOPLEFT' then
        self:SetPoint('TOPLEFT', frame, 'TOPLEFT')
    elseif position == 'TOPRIGHT' then
        self:SetPoint('TOPLEFT', frame, 'TOPRIGHT')
    end
end
