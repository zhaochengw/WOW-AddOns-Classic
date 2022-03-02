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

---@class UI.Token: EventsMixin, Object, tdBag2TokenTemplate
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
        self.Count:SetText(Counter:GetOwnerItemTotal(owner, itemId))
    else
        local counts = Counter:GetOwnerItemCount(owner, itemId)
        self.Count:SetText(counts and counts[2] or '0')
    end
    self:SetWidth(self.Count:GetWidth() + 20)
end

function Token:TooltipItem()
    ---@type UI.TokenFrame
    local parent = self:GetParent()
    ns.AnchorTooltip2(parent, 'LEFT', 0, 0, self)
    GameTooltip:SetHyperlink('item:' .. self.itemId)

    if parent.meta:IsSelf() then
        GameTooltip:AddLine(' ')
        GameTooltip:AddLine(ns.LeftButtonTip(L.TOOLTIP_WATCHED_TOKENS_LEFTTIP))
        GameTooltip:AddLine(ns.RightButtonTip(L.TOOLTIP_WATCHED_TOKENS_RIGHTTIP))
    end
    GameTooltip:Show()
end

function Token:TooltipAll()
    ---@type UI.TokenFrame
    local parent = self:GetParent()
    local watchs = parent.meta.character.watches

    if #watchs == 0 then
        return
    end

    ns.AnchorTooltip2(parent, 'LEFT', 0, 0, self)
    GameTooltip:SetText(L['Watch Frame'])
    GameTooltip:AddLine(' ')

    local owner = parent.meta.owner
    for _, watch in ipairs(watchs) do
        local name, _, quality = GetItemInfo(watch.itemId)
        local icon = GetItemIcon(watch.itemId)
        local title = format('|T%s:14|t ', icon) .. (name or ('item:' .. watch.itemId))
        local _, count = ns.Tooltip:GetCounts(Counter:GetOwnerItemCount(owner, watch.itemId))
        local r, g, b = 1, 1, 1

        if quality then
            r, g, b = GetItemQualityColor(quality)
        end

        GameTooltip:AddDoubleLine(title, count, r, g, b, 1, 0.82, 0)
    end

    GameTooltip:AddLine(' ')
    GameTooltip:AddLine(L.TOOLTIP_WATCHED_TOKENS_SHIFT, 0, 1, 1)

    if parent.meta:IsSelf() then
        GameTooltip:AddLine(ns.LeftButtonTip(L.TOOLTIP_WATCHED_TOKENS_LEFTTIP))
        GameTooltip:AddLine(ns.RightButtonTip(L.TOOLTIP_WATCHED_TOKENS_RIGHTTIP))
    end

    GameTooltip:Show()
end

function Token:OnEnter()
    if IsShiftKeyDown() then
        self:TooltipItem()
    else
        self:TooltipAll()
    end
end

Token.UpdateTooltip = Token.OnEnter
