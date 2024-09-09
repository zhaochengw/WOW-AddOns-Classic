-- EnchantItem.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 8/23/2024, 12:00:23 PM
--
---@type ns
local ns = select(2, ...)

---@class UI.EnchantItem : AceEvent-3.0, Object, Button, tdInspectSocketItemTemplate, Pool
local EnchantItem = ns.Addon:NewClass('UI.EnchantItem', 'Button')

ns.Pool:Mixin(EnchantItem)

function EnchantItem:Create(parent)
    return self:Bind(CreateFrame('Button', nil, parent, 'tdInspectSocketItemTemplate'))
end

function EnchantItem:Constructor()
    self:SetScript('OnClick', self.OnClick)
    self:SetScript('OnEnter', self.OnEnter)
    self:SetScript('OnLeave', GameTooltip_Hide)
    self:SetScript('OnHide', self.Free)

    self.Border:SetVertexColor(0.2, 0.7, 0.2)
end

function EnchantItem:OnFree()
    self.item = nil
    self.spell = nil
end

function EnchantItem:OnClick()
    if self.item then
        local _, link = GetItemInfo(self.item)
        HandleModifiedItemClick(link)
    elseif self.spell then
        local link = GetSpellLink(self.spell)
        HandleModifiedItemClick(link)
    end
end

function EnchantItem:OnEnter()
    if self.item then
        GameTooltip:SetOwner(self, 'ANCHOR_RIGHT')
        GameTooltip:SetItemByID(self.item)
        GameTooltip:Show()
    elseif self.spell then
        GameTooltip:SetOwner(self, 'ANCHOR_RIGHT')
        GameTooltip:SetSpellByID(self.spell)
        GameTooltip:Show()
    elseif self.emptyText then
        GameTooltip:SetOwner(self, 'ANCHOR_RIGHT')
        GameTooltip:SetText(self.emptyText)
        GameTooltip:Show()
    end
end

function EnchantItem:Clear()
    self.item = nil
    self.spell = nil
    self.emptyText = nil
end

function EnchantItem:SetItem(item)
    self:Clear()
    self.item = item
    self:Update()
end

function EnchantItem:SetSpell(spell)
    self:Clear()
    self.spell = spell
    self:Update()
end

function EnchantItem:SetEmpty(text)
    self:Clear()
    self.emptyText = text
    self:Update()
end

function EnchantItem:Update()
    if self.item then
        self.Icon:SetTexture(GetItemIcon(self.item))
    elseif self.spell then
        self.Icon:SetTexture(select(3, GetSpellInfo(self.spell)))
    else
        self.Icon:SetTexture(136509) -- Interface\PaperDoll\UI-Backpack-EmptySlot
    end
end
