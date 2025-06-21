-- SlotItem.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 5/18/2020, 1:28:25 PM
--
---@type ns
local ns = select(2, ...)

local _G = _G
local select = select
local strupper = string.upper
local strsub = string.sub

local GetItemIcon = GetItemIcon
local GetItemInfo = GetItemInfo
local GetItemQualityColor = GetItemQualityColor
local UnitHasRelicSlot = UnitHasRelicSlot
local CursorUpdate = CursorUpdate

local GameTooltip = GameTooltip

local Inspect = ns.Inspect

---@class UI.SlotItem: UI.BaseItem
local SlotItem = ns.Addon:NewClass('UI.SlotItem', ns.UI.BaseItem)

function SlotItem:Constructor()
    self:UnregisterAllEvents()
    self:SetScript('OnEvent', nil)
    self:SetScript('OnUpdate', nil)
    self.RegisterEvent = nop

    self.IconBorder:SetTexture([[Interface\Buttons\UI-ActionButton-Border]])
    self.IconBorder:SetBlendMode('ADD')
    self.IconBorder:ClearAllPoints()
    self.IconBorder:SetPoint('CENTER')
    self.IconBorder:SetSize(67, 67)

    self.LevelText = _G[self:GetName() .. 'Count']

    self.UpdateTooltip = self.OnEnter

    self:SetScript('OnClick', self.OnClick)
    self:SetScript('OnEnter', self.OnEnter)
    self:SetScript('OnShow', self.OnShow)
end

function SlotItem:OnShow()
    self:Event('UNIT_INVENTORY_CHANGED')
end

function SlotItem:UNIT_INVENTORY_CHANGED(_, unit)
    if Inspect.unit == unit then
        self:Update()
    end
end

function SlotItem:Update()
    local item = Inspect:GetItemLink(self:GetID())
    if item then
        SetItemButtonTexture(self, GetItemIcon(item))

        local quality = select(3, GetItemInfo(item))
        if not quality then
            self:WaitItem(item)
        end

        if quality and quality > 1 then
            local r, g, b = GetItemQualityColor(quality)
            local level = select(4, GetItemInfo(item))
            self:UpdateBorder(r, g, b)
            self:UpdateItemLevel(level, quality)
        else
            self:UpdateBorder()
            self:UpdateItemLevel()
        end

        if ns.BUILD == 1 then
            local rune = Inspect:GetItemRune(self:GetID())
            if rune then
                local icon = rune.icon or select(3, GetSpellInfo(rune.spellId))
                self.subicon:SetTexture(icon)
                self.subicon:Show()
            else
                self.subicon:Hide()
            end
        end
    else
        SetItemButtonTexture(self, self:GetEmptyIcon())
        self:UpdateBorder()
        self:UpdateItemLevel()
        if ns.BUILD == 1 then
            self.subicon:Hide()
        end
    end

    self.hasItem = item
end

function SlotItem:UpdateBorder(r, g, b)
    if r then
        self.IconBorder:SetVertexColor(r, g, b, 0.5)
        self.IconBorder:Show()
    else
        self.IconBorder:Hide()
    end
end

local ItemLevelColorMethods = {
    Blizzard = GetItemQualityColor,
    Light = function(quality)
        local color = ns.CUSTOM_ITEM_QUALITY_COLORS[quality]
        return color.r, color.g, color.b
    end,
    White = function()
        return 1, 1, 1
    end,
    Hidden = nop,
}

function SlotItem:GetItemLevelColor(quality)
    if not quality then
        return
    end
    return (ItemLevelColorMethods[ns.db.profile.itemLevelColor])(quality)
end

function SlotItem:UpdateItemLevel(level, quality)
    local r, g, b = self:GetItemLevelColor(quality)
    if not level or level == 0 or not r then
        self.LevelText:Hide()
    else
        if r then
            self.LevelText:SetTextColor(r, g, b, 1)
        else
            self.LevelText:SetTextColor(1, 1, 1, 1)
        end
        self.LevelText:SetText(level)
        self.LevelText:Show()
    end
end

function SlotItem:GetEmptyIcon()
    local icon = self.backgroundTextureName
    if self.checkRelic then
        local unit = Inspect.unit
        if unit and UnitHasRelicSlot(unit) then
            icon = [[Interface\Paperdoll\UI-PaperDoll-Slot-Relic.blp]]
        end
    end
    return icon
end

function SlotItem:OnEnter()
    GameTooltip:SetOwner(self, 'ANCHOR_RIGHT')

    if not ns.ShowBlizzardInventoryItem(Inspect.unit, self:GetID()) then
        local item = Inspect:GetItemLink(self:GetID())
        if item then
            GameTooltip:SetHyperlink(item)
            ns.FixInspectItemTooltip(GameTooltip, self:GetID(), item)
        else
            GameTooltip:SetText(_G[strupper(strsub(self:GetName(), 8))])
        end
    end

    CursorUpdate(self)
end

function SlotItem:OnClick()
    local item = Inspect:GetItemLink(self:GetID())
    if item then
        local _, link = GetItemInfo(item)
        HandleModifiedItemClick(link)
    end
end
