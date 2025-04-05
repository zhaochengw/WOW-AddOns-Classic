-- Token.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 11/29/2019, 11:21:51 AM
--
local format = format
local ipairs = ipairs

local C = LibStub('C_Everywhere')

local IsShiftKeyDown = IsShiftKeyDown
-- @build>3@
local CreateTextureMarkup = CreateTextureMarkup
-- @end-build>3@

local GameTooltip = GameTooltip

-- @build>3@
local Constants = Constants
-- @end-build>3@

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

function Token:Clear()
    self.itemId = nil
    self.currencyId = nil
end

function Token:SetItem(owner, itemId, watchAll)
    self:Clear()
    self.itemId = itemId
    self.Icon:SetTexture(C.Item.GetItemIconByID(itemId))
    self.Icon:SetTexCoord(0, 1, 0, 1)
    if watchAll then
        self.Count:SetText(Counter:GetOwnerItemTotal(owner, itemId))
    else
        local counts = Counter:GetOwnerItemCount(owner, itemId)
        self.Count:SetText(counts and counts[2] or '0')
    end
    self:SetWidth(self.Count:GetWidth() + 20)
end

-- @build>3@
function Token:SetCurrency(_, currencyId, icon, count)
    self:Clear()
    self.currencyId = currencyId
    self.Icon:SetTexture(icon)
    if currencyId == Constants.CurrencyConsts.CLASSIC_HONOR_CURRENCY_ID then
        self.Icon:SetTexCoord(0.03125, 0.59375, 0.03125, 0.59375)
    else
        self.Icon:SetTexCoord(0, 1, 0, 1)
    end
    self.Count:SetText(count)
    self:SetWidth(self.Count:GetWidth() + 20)
end
-- @end-build>3@

function Token:TooltipItem()
    ---@type UI.TokenFrame
    local parent = self:GetParent()
    ns.AnchorTooltip2(parent, 'LEFT', 0, 0, self)

    if self.itemId then
        GameTooltip:SetHyperlink('item:' .. self.itemId)
        -- @build>3@
    else
        GameTooltip:SetHyperlink('currency:' .. self.currencyId)
        -- @end-build>3@
    end

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

    if #watchs == 0 and parent.currencyCount == 0 then
        return
    end

    ns.AnchorTooltip2(parent, 'LEFT', 0, 0, self)
    GameTooltip:SetText(L['Watch Frame'])
    GameTooltip:AddLine(' ')

    -- @build>3@
    if parent.meta:IsSelf() then
        for i = 1, parent.currencyCount do
            local info = C.CurrencyInfo.GetBackpackCurrencyInfo(i)
            if info then
                local iconStr
                if info.currencyTypesID == Constants.CurrencyConsts.CLASSIC_HONOR_CURRENCY_ID then
                    iconStr = CreateTextureMarkup(info.iconFileID, 64, 64, 14, 14, 0.03125, 0.59375, 0.03125, 0.59375)
                else
                    iconStr = format('|T%s:14|t ', info.iconFileID)
                end
                local title = iconStr .. info.name
                local r, g, b = 1, 1, 1
                local currencyInfo = C.CurrencyInfo.GetCurrencyInfo(info.currencyTypesID)

                if currencyInfo and currencyInfo.quality then
                    r, g, b = C.Item.GetItemQualityColor(currencyInfo.quality)
                end

                GameTooltip:AddDoubleLine(title, info.quantity, r, g, b, 1, 0.82, 0)
            end
        end
    end
    -- @end-build>3@

    local owner = parent.meta.owner
    for _, watch in ipairs(watchs) do
        local name, _, quality = C.Item.GetItemInfo(watch.itemId)
        local icon = C.Item.GetItemIconByID(watch.itemId)
        local title = format('|T%s:14|t ', icon) .. (name or ('item:' .. watch.itemId))
        local _, count = ns.Tooltip:GetCounts(Counter:GetOwnerItemCount(owner, watch.itemId))
        local r, g, b = 1, 1, 1

        if quality then
            r, g, b = C.Item.GetItemQualityColor(quality)
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
