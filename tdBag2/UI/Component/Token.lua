-- Token.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 11/29/2019, 11:21:51 AM

local GetItemIcon = GetItemIcon
local GetItemCount = GetItemCount

local GameTooltip = GameTooltip

---@type ns
local ns = select(2, ...)
local L = ns.L
local Counter = ns.Counter

---@type tdBag2Token
local Token = ns.Addon:NewClass('UI.Token', 'Frame.tdBag2TokenTemplate')

function Token:Constructor()
    self:SetScript('OnEnter', self.OnEnter)
    self:SetScript('OnLeave', GameTooltip_Hide)
    self:SetMouseClickEnabled(false)
end

function Token:SetItem(owner, itemId, watchAll)
    self.itemId = itemId
    self.Icon:SetTexture(GetItemIcon(itemId))
    if watchAll then
        self.Count:SetText(ns.Counter:GetOwnerItemTotal(owner, itemId))
    else
        local counts = ns.Counter:GetOwnerItemCount(owner, itemId)
        self.Count:SetText(counts and counts[2] or '0')
    end
    self:SetWidth(self.Count:GetWidth() + 16)
end

function Token:OnEnter()
    ns.AnchorTooltip(self)
    GameTooltip:SetHyperlink('item:' .. self.itemId)

    if self:GetParent().meta:IsSelf() then
        GameTooltip:AddLine(' ')
        GameTooltip:AddLine(ns.LeftButtonTip(L.TOOLTIP_WATCHED_TOKENS_LEFTTIP))
        GameTooltip:AddLine(ns.RightButtonTip(L.TOOLTIP_WATCHED_TOKENS_RIGHTTIP))
    end
    GameTooltip:Show()
end
