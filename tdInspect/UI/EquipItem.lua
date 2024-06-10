-- EquipItem.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 5/18/2020, 11:26:46 AM
--
---@type ns
local ns = select(2, ...)

local GetItemInfo = GetItemInfo
local GetItemQualityColor = GetItemQualityColor

local GameTooltip = GameTooltip

local Inspect = ns.Inspect

---@class UI.EquipItem: UI.BaseItem
local EquipItem = ns.Addon:NewClass('UI.EquipItem', ns.UI.BaseItem)

function EquipItem:Constructor(_, id, slotName, hasBg)
    self:SetHeight(17)
    self:SetID(id)

    local Slot = self:CreateFontString(nil, 'ARTWORK', 'GameFontNormal')
    Slot:SetFont(Slot:GetFont(), 12, 'OUTLINE')
    Slot:SetWidth(38)
    Slot:SetPoint('LEFT')
    Slot:SetText(slotName)
    self.Slot = Slot

    local ItemLevel = self:CreateFontString(nil, 'ARTWORK', 'TextStatusBarText')
    ItemLevel:SetFont(ItemLevel:GetFont(), 13, 'OUTLINE')
    ItemLevel:SetJustifyH('LEFT')
    ItemLevel:SetPoint('LEFT', Slot, 'RIGHT', 5, 0)
    self.ItemLevel = ItemLevel

    local Name = self:CreateFontString(nil, 'ARTWORK', 'ChatFontNormal')
    Name:SetFont(Name:GetFont(), 13)
    Name:SetWordWrap(false)
    Name:SetJustifyH('LEFT')
    Name:SetPoint('LEFT', Slot, 'RIGHT', 30, 0)
    Name:SetPoint('RIGHT')
    self.Name = Name

    --[[@build<2@
    local RuneIcon = self:CreateTexture(nil, 'OVERLAY')
    RuneIcon:SetSize(17, 17)
    RuneIcon:SetPoint('RIGHT')
    self.RuneIcon = RuneIcon
    --@end-build<2@]]

    local ht = self:CreateTexture(nil, 'HIGHLIGHT')
    ht:SetAllPoints(true)
    ht:SetColorTexture(0.5, 0.5, 0.5, 0.3)

    if hasBg then
        local bg = self:CreateTexture(nil, 'BACKGROUND')
        bg:SetAllPoints(true)
        bg:SetColorTexture(0.3, 0.3, 0.3, 0.3)
    end

    self:SetScript('OnLeave', GameTooltip_Hide)
    self:SetScript('OnEnter', self.OnEnter)
    self.UpdateTooltip = self.OnEnter
end

function EquipItem:OnHide()
    self:UnregisterAllEvents()
end

function EquipItem:OnEnter()
    local item = Inspect:GetItemLink(self:GetID())
    if item then
        --[[@build<2@
        if self.RuneIcon:IsVisible() and self.RuneIcon:IsMouseOver() then
            local rune = Inspect:GetItemRune(self:GetID())
            if rune then
                GameTooltip:SetOwner(self, 'ANCHOR_RIGHT')
                GameTooltip:SetSpellByID(rune.spellId)
            end
        else
            --@end-build<2@]]
            GameTooltip:SetOwner(self, 'ANCHOR_RIGHT')
            GameTooltip:SetHyperlink(item)
            ns.FixInspectItemTooltip(GameTooltip, self:GetID(), item)
            --[[@build<2@
        end
        --@end-build<2@]]
    end
end

function EquipItem:Update()
    self.itemId = nil

    local id = self:GetID()

    --[[@build<2@
    local rune = Inspect:GetItemRune(id)
    if rune then
        local icon = rune.icon or select(3, GetSpellInfo(rune.spellId))
        self.RuneIcon:SetTexture(icon)
        self.RuneIcon:Show()
    else
        self.RuneIcon:Hide()
    end
    --@end-build<2@]]

    local item = Inspect:GetItemLink(id)
    if item then
        local name, link, quality, itemLevel = GetItemInfo(item)
        if name then
            local r, g, b = GetItemQualityColor(quality)

            self.itemId = nil
            self.Name:SetText(name)
            self.Name:SetTextColor(r, g, b)
            self.Slot:SetTextColor(r, g, b)
            self.ItemLevel:SetText(itemLevel)
            return
        else
            self:WaitItem(item)
        end
    end

    self.Name:SetText('')
    self.ItemLevel:SetText('')
    self.Slot:SetTextColor(0.6, 0.6, 0.6)
end
