-- GemItem.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 8/23/2024, 11:48:29 AM
--
---@type ns
local ns = select(2, ...)

local L = ns.L

---@class UI.GemItem : AceEvent-3.0, Button, tdInspectSocketItemTemplate, Pool
local GemItem = ns.Addon:NewClass('UI.GemItem', 'Button')

ns.Pool:Mixin(GemItem)

function GemItem:Create(parent)
    return self:Bind(CreateFrame('Button', nil, parent, 'tdInspectSocketItemTemplate'))
end

function GemItem:Constructor()
    self:SetScript('OnClick', self.OnClick)
    self:SetScript('OnEnter', self.OnEnter)
    self:SetScript('OnLeave', GameTooltip_Hide)
    self:SetScript('OnHide', self.Free)
end

function GemItem:OnClick()
    if self.item then
        local _, link = GetItemInfo(self.item)
        HandleModifiedItemClick(link)
    end
end

function GemItem:OnEnter()
    if self.item then
        GameTooltip:SetOwner(self, 'ANCHOR_RIGHT')
        GameTooltip:SetItemByID(ns.ItemLinkToId(self.item))
        GameTooltip:Show()
    elseif self.socketType then
        GameTooltip:SetOwner(self, 'ANCHOR_RIGHT')
        GameTooltip:SetText(self.socketType == -1 and L['Belt buckle'] or L['Empty socket'])
        GameTooltip:Show()
    end
end

function GemItem:Clear()
    self.item = nil
    self.socketType = nil
end

function GemItem:SetSocketItem(socketType, item)
    self:Clear()
    self.socketType = socketType
    self.item = item
    self:Update()
end

function GemItem:Update()
    if self.item then
        self.Icon:SetTexture(GetItemIcon(self.item))
    else
        self.Icon:SetTexture(136509) -- Interface\PaperDoll\UI-Backpack-EmptySlot
    end
    if self.socketType then
        self.Border:SetVertexColor(ns.GetSocketColor(self.socketType))
    else
        self.Border:SetVertexColor(0.5, 0.5, 0.5)
    end
end

function GemItem:OnFree()
    self:Clear()
end
