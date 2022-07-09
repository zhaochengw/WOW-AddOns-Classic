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

local SetItemButtonTexture = SetItemButtonTexture

local GameTooltip = GameTooltip

local Inspect = ns.Inspect

---@class UI.SlotItem: UI.BaseItem
local SlotItem = ns.Addon:NewClass('UI.SlotItem', ns.UI.BaseItem)

function SlotItem:Constructor()
    self:SuperCall('UnregisterAllEvents')
    self:SetScript('OnEvent', nil)
    self:SetScript('OnUpdate', nil)

    self.IconBorder:SetTexture([[Interface\Buttons\UI-ActionButton-Border]])
    self.IconBorder:SetBlendMode('ADD')
    self.IconBorder:ClearAllPoints()
    self.IconBorder:SetPoint('CENTER')
    self.IconBorder:SetSize(67, 67)

    self.UpdateTooltip = self.OnEnter

    self:SetScript('OnClick', self.OnClick)
    self:SetScript('OnEnter', self.OnEnter)
    self:SetScript('OnShow', self.OnShow)
end

function SlotItem:OnShow()
    self:RegisterEvent('UNIT_INVENTORY_CHANGED')
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
            self:UpdateBorder(GetItemQualityColor(quality))
        else
            self:UpdateBorder()
        end
    else
        SetItemButtonTexture(self, self:GetEmptyIcon())
        self:UpdateBorder()
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
    local item = Inspect:GetItemLink(self:GetID())
    if item then
        GameTooltip:SetHyperlink(item)
        ns.FixInspectItemTooltip(GameTooltip)
    else
        GameTooltip:SetText(_G[strupper(strsub(self:GetName(), 8))])
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
