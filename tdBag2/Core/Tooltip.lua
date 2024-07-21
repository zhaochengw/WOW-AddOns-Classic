-- Tooltip.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 10/24/2019, 1:03:40 PM
--
---- LUA
local ipairs = ipairs
local tinsert, tconcat = table.insert, table.concat
local format = string.format
local tonumber = tonumber
local pairs, type = pairs, type

---- G
local HEARTHSTONE_ITEM_ID = HEARTHSTONE_ITEM_ID
local RAID_CLASS_COLORS = RAID_CLASS_COLORS
local NORMAL_FONT_COLOR = NORMAL_FONT_COLOR

---- WOW

local GetCraftItemLink = GetCraftItemLink
local GetCraftReagentItemLink = GetCraftReagentItemLink
local Ambiguate = Ambiguate

---- UI
local GameTooltip = GameTooltip
local ItemRefTooltip = ItemRefTooltip

---@type ns
local ns = select(2, ...)
local L = ns.L
local Cache = ns.Cache
local Counter = ns.Counter

---@class Tooltip: AceModule, AceEvent-3.0, AceHook-3.0
local Tooltip = ns.Addon:NewModule('Tooltip', 'AceHook-3.0', 'AceEvent-3.0')
Tooltip.APIS = {
    'SetMerchantItem',
    'SetBuybackItem',
    'SetBagItem',
    'SetAuctionItem',
    'SetAuctionSellItem',
    'SetLootItem',
    'SetLootRollItem',
    'SetInventoryItem',
    'SetTradePlayerItem',
    'SetTradeTargetItem',
    'SetQuestItem',
    'SetQuestLogItem',
    'SetInboxItem',
    'SetSendMailItem',
    'SetHyperlink',
    'SetTradeSkillItem',
    'SetAction',
    'SetItemByID',
    'SetMerchantCostItem',
    'SetGuildBankItem',
    'SetExistingSocketGem',
    'SetSocketGem',
    'SetSocketedItem',
    SetCraftItem = true,
}
Tooltip.EMPTY = {}
Tooltip.CACHED_EMPTY = {cached = true}

Tooltip.SPACES = {
    L['Equipped'], --
    L['Inventory'], --
    L['Bank'], --
    L['Mail'], --
    L['COD'], --
    L['Guild bank'],
}

function Tooltip:OnInitialize()
    self.Cacher = ns.Cacher:New()
    self.Cacher:Patch(self, 'GetOwnerItemInfo', true)
    self.GetOwnerItemInfo.Cachable = function(info)
        return info.cached
    end
end

function Tooltip:OnEnable()
    self:Update()
    -- @build>2@
    self:RegisterMessage('GUILDBANK_OPENED', 'OnGuildBankUpdate')
    self:RegisterMessage('GUILDBANK_CLOSED', 'OnGuildBankUpdate')
    -- @end-build>2@
end

-- @build>2@
function Tooltip:OnGuildBankUpdate()
    self.Cacher:RemoveCache(ns.GetCurrentGuildOwner())
end
-- @end-build>2@

function Tooltip:Update()
    if ns.Addon.db.profile.tipCount then
        self:HookTip(GameTooltip)
        self:HookTip(ItemRefTooltip)
    else
        self:UnhookAll()
    end
end

function Tooltip:HookTip(tip)
    local api, handler
    for k, v in pairs(self.APIS) do
        if type(k) == 'number' then
            api, handler = v, 'OnTooltipItem'
        elseif type(v) == 'string' then
            api, handler = k, v
        else
            api, handler = k, k
        end

        if tip[api] then
            self:SecureHook(tip, api, handler)
        end
    end

    if tip.shoppingTooltips then
        for _, shoppingTip in ipairs(tip.shoppingTooltips) do
            if shoppingTip.SetCompareItem then
                self:SecureHook(shoppingTip, 'SetCompareItem', 'OnCompareItem')
            end
            self:HookTip(shoppingTip)
        end
    end
end

function Tooltip:OnCompareItem(tip1, tip2)
    self:OnTooltipItem(tip1)
    self:OnTooltipItem(tip2)
end

function Tooltip:SetCraftItem(tip, index, slot)
    if not slot then
        return self:OnItem(tip, GetCraftItemLink(index))
    else
        return self:OnItem(tip, GetCraftReagentItemLink(index, slot))
    end
end

function Tooltip:OnTooltipItem(tip)
    local _, item = tip:GetItem()
    if not item then
        return
    end
    self:OnItem(tip, item)
end

function Tooltip:OnItem(tip, item)
    local itemId = tonumber(item and item:match('item:(%d+)'))
    if itemId and itemId ~= HEARTHSTONE_ITEM_ID then
        self:AddOwners(tip, itemId)
        tip:Show()
    end
end

function Tooltip:FormatName(info)
    if info.guild then
        return Ambiguate(info.name:sub(2), 'none')
    else
        return Ambiguate(info.name, 'none')
    end
end

function Tooltip:AddOwners(tip, item)
    local owners, total = 0, 0
    for _, owner in ipairs(Cache:GetOwners()) do
        if ns.Addon.db.profile.tipCountGuild or not ns.IsGuildOwner(owner) then
            local info = self:GetOwnerItemInfo(owner, item)
            if info and info.total then
                local r, g, b = info.color.r, info.color.g, info.color.b
                tip:AddDoubleLine(info.name, info.text, r, g, b, r, g, b)

                total = total + info.total
                owners = owners + 1
            end
        end
    end

    if owners > 1 then
        tip:AddDoubleLine(L['Total'], total, 0.66, 0.66, 0.66, 0.66, 0.66, 0.66)
    end
end

function Tooltip:GetCounts(counts)
    local places = 0
    local total = 0
    local sb = {}
    for i, label in ipairs(self.SPACES) do
        local count = counts[i]

        if count and count > 0 then
            places = places + 1
            total = total + count

            tinsert(sb, format('%s:%d', label, count))
        end
    end

    local text = tconcat(sb, ' ')

    if places > 1 then
        return total, format('%d |cffaaaaaa(%s)|r', total, text)
    elseif places == 1 then
        return total, text
    end
end

function Tooltip:GetOwnerItemInfo(owner, itemId)
    local info = Cache:GetOwnerInfo(owner)
    local total, text = self:GetCounts(Counter:GetOwnerItemCount(owner, itemId))
    local name = self:FormatName(info)
    local item
    if total then
        item = { --
            name = name,
            text = text,
            total = total,
            color = info.guild and NORMAL_FONT_COLOR or RAID_CLASS_COLORS[info.class or 'PRIEST'],
            cached = info.cached,
        }
    elseif info.cached then
        item = self.CACHED_EMPTY
    else
        item = self.EMPTY
    end
    return item
end
