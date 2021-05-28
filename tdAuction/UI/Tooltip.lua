-- Tooltip.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 9/21/2020, 11:15:15 PM
--
---@type ns
local ns = select(2, ...)

local L = ns.L

local pairs, ipairs = pairs, ipairs
local select = select
local format = string.format

local GetAuctionItemInfo = GetAuctionItemInfo
local GetAuctionItemLink = GetAuctionItemLink
local GetAuctionSellItemInfo = GetAuctionSellItemInfo
local GetBuybackItemInfo = GetBuybackItemInfo
local GetBuybackItemLink = GetBuybackItemLink
local GetContainerItemInfo = GetContainerItemInfo
local GetContainerItemLink = GetContainerItemLink
local GetCraftItemLink = GetCraftItemLink
local GetCraftReagentInfo = GetCraftReagentInfo
local GetCraftReagentItemLink = GetCraftReagentItemLink
local GetInboxItem = GetInboxItem
local GetInboxItemLink = GetInboxItemLink
local GetInventoryItemCount = GetInventoryItemCount
local GetInventoryItemLink = GetInventoryItemLink
local GetItemCount = GetItemCount
local GetItemInfo = GetItemInfo
local GetLootRollItemInfo = GetLootRollItemInfo
local GetLootRollItemLink = GetLootRollItemLink
local GetLootSlotLink = GetLootSlotLink
local GetMerchantItemInfo = GetMerchantItemInfo
local GetMerchantItemLink = GetMerchantItemLink
local GetMoneyString = GetMoneyString
local GetQuestItemInfo = GetQuestItemInfo
local GetQuestItemLink = GetQuestItemLink
local GetQuestLogChoiceInfo = GetQuestLogChoiceInfo
local GetQuestLogItemLink = GetQuestLogItemLink
local GetQuestLogRewardInfo = GetQuestLogRewardInfo
local GetSendMailItem = GetSendMailItem
local GetTradePlayerItemInfo = GetTradePlayerItemInfo
local GetTradePlayerItemLink = GetTradePlayerItemLink
local GetTradeSkillItemLink = GetTradeSkillItemLink
local GetTradeSkillNumMade = GetTradeSkillNumMade
local GetTradeSkillReagentInfo = GetTradeSkillReagentInfo
local GetTradeSkillReagentItemLink = GetTradeSkillReagentItemLink
local GetTradeTargetItemInfo = GetTradeTargetItemInfo
local GetTradeTargetItemLink = GetTradeTargetItemLink
local IsEquippableItem = IsEquippableItem
local IsShiftKeyDown = IsShiftKeyDown
local LootSlotHasItem = LootSlotHasItem

local ITEM_LEVEL = NORMAL_FONT_COLOR_CODE .. ITEM_LEVEL_PLUS:gsub(' *%%d%+$', ' %%d') .. '|r'
local CURRENTLY_EQUIPPED = CURRENTLY_EQUIPPED

local INVALID_EQUIP_LOC = { --
    [''] = true,
    ['INVTYPE_BAG'] = true,
    ['INVTYPE_AMMO'] = true,
}

local PREFIX_VENDO = L.TOOLTIP_PREFIX_VENDO
local PREFIX_AUCTION = L.TOOLTIP_PREFIX_AUCTION
local PREFIX_DISENCHANT = L.TOOLTIP_PREFIX_DISENCHANT

local function ShowSingle()
    if ns.profile.tooltip.shiftSingle then
        return IsShiftKeyDown()
    else
        return not IsShiftKeyDown()
    end
end

local function AddPrice(tip, prefix, unitPrice, count)
    count = max(1, count)

    if count == 1 or ShowSingle() then
        tip:AddDoubleLine(prefix, GetMoneyString(unitPrice), 0, 1, 0.5, 1, 1, 1)
    else
        tip:AddDoubleLine(format('%s |cffaaaaffx%d|r', prefix, count), GetMoneyString(unitPrice * count), 0, 1, 0.5, 1,
                          1, 1)
    end
end

---@param tip GameTooltip
local function OnTooltipItem(tip, link, count)
    if ns.profile.tooltip.price then
        local price = select(11, GetItemInfo(link))
        if price and price > 0 then
            AddPrice(tip, PREFIX_VENDO, price, count)
        end
    end

    if ns.profile.tooltip.auctionPrice then
        local itemKey = ns.ParseItemKey(link)
        local price = itemKey and ns.prices[itemKey]
        if price then
            AddPrice(tip, PREFIX_AUCTION, price, count)
        end
    end

    if ns.profile.tooltip.disenchantPrice then
        local _, _, quality, itemLevel, _, _, _, _, equipLoc = GetItemInfo(link)
        local price = ns.GetDisenchantPrice(equipLoc, quality, itemLevel)
        if price then
            AddPrice(tip, PREFIX_DISENCHANT, price, count)
        end

        local showDisenchant = ns.profile.tooltip.showDisenchant
        if showDisenchant and (showDisenchant ~= 1 or IsShiftKeyDown()) then
            local possibles = ns.GetDisenchantPossibles(equipLoc, quality, itemLevel)
            if possibles then
                for i, info in ipairs(possibles) do
                    local name, _, quality = GetItemInfo(info.id)
                    if name then
                        local r, g, b = GetItemQualityColor(quality)

                        local count
                        if info.min == info.max then
                            if info.min == 1 then
                                count = ''
                            else
                                count = info.min
                            end
                        else
                            count = format('%d-%d', info.min, info.max)
                        end

                        local textLeft = format('  |cff%02x%02x%02x%s|r %s', r * 255, g * 255, b * 255, name, count)
                        local textRight = format('%.1f%%', info.rate * 100)

                        tip:AddDoubleLine(textLeft, textRight, 1, 0.82, 0, nil, 1, 0.82, 0)
                    end
                end
            end
        end
    end

    tip:Show()
end

local function OnTooltipSetItem(tip, link, count)
    link = link or select(2, tip:GetItem())
    if link then
        OnTooltipItem(tip, link, count or 1)
    end
end

local function OnCompareItem(tip1, tip2)
    OnTooltipSetItem(tip1)
    OnTooltipSetItem(tip2)
end

local TipMethods = {}

function TipMethods:SetHyperlink(link, num)
    return OnTooltipSetItem(self, nil, num)
end

function TipMethods:SetItemByID(itemId, num)
    return OnTooltipSetItem(self, nil, num)
end

function TipMethods:SetMerchantItem(index)
    return OnTooltipSetItem(self, GetMerchantItemLink(index), select(4, GetMerchantItemInfo(index)))
end

function TipMethods:SetBuybackItem(index)
    return OnTooltipSetItem(self, GetBuybackItemLink(index), select(4, GetBuybackItemInfo(index)))
end

function TipMethods:SetBagItem(bag, slot)
    return OnTooltipSetItem(self, GetContainerItemLink(bag, slot), select(2, GetContainerItemInfo(bag, slot)))
end

function TipMethods:SetAuctionItem(type, index)
    return OnTooltipSetItem(self, GetAuctionItemLink(type, index), select(3, GetAuctionItemInfo(type, index)))
end

function TipMethods:SetAuctionSellItem()
    return OnTooltipSetItem(self, nil, select(3, GetAuctionSellItemInfo()))
end

function TipMethods:SetLootItem(slot)
    if LootSlotHasItem(slot) then
        local link, _, count = GetLootSlotLink(slot)
        return OnTooltipSetItem(self, link, count)
    end
end

function TipMethods:SetLootRollItem(slot)
    return OnTooltipSetItem(self, GetLootRollItemLink(slot), select(3, GetLootRollItemInfo(slot)))
end

function TipMethods:SetInventoryItem(unit, slot)
    return OnTooltipSetItem(self, GetInventoryItemLink(unit, slot), GetInventoryItemCount(unit, slot))
end

function TipMethods:SetTradePlayerItem(id)
    return OnTooltipSetItem(self, GetTradePlayerItemLink(id), select(3, GetTradePlayerItemInfo(id)))
end

function TipMethods:SetTradeTargetItem(id)
    return OnTooltipSetItem(self, GetTradeTargetItemLink(id), select(3, GetTradeTargetItemInfo(id)))
end

function TipMethods:SetQuestItem(type, index)
    return OnTooltipSetItem(self, GetQuestItemLink(type, index), select(3, GetQuestItemInfo(type, index)))
end

function TipMethods:SetQuestLogItem(type, index)
    if type == 'choice' then
        return OnTooltipSetItem(self, GetQuestLogItemLink(type, index), select(3, GetQuestLogChoiceInfo(index)))
    else
        return OnTooltipSetItem(self, GetQuestLogItemLink(type, index), select(3, GetQuestLogRewardInfo(index)))
    end
end

function TipMethods:SetInboxItem(index, attachIndex)
    attachIndex = attachIndex or 1
    return OnTooltipSetItem(self, GetInboxItemLink(index, attachIndex), select(4, GetInboxItem(index, attachIndex)))
end

function TipMethods:SetSendMailItem(id)
    return OnTooltipSetItem(self, nil, select(4, GetSendMailItem(id)))
end

function TipMethods:SetCraftItem(index, slot)
    if not slot then
        return OnTooltipSetItem(self, GetCraftItemLink(index), 1)
    else
        return OnTooltipSetItem(self, GetCraftReagentItemLink(index, slot), select(3, GetCraftReagentInfo(index, slot)))
    end
end

function TipMethods:SetTradeSkillItem(index, slot)
    if not slot then
        return OnTooltipSetItem(self, GetTradeSkillItemLink(index), GetTradeSkillNumMade(index))
    else
        return OnTooltipSetItem(self, GetTradeSkillReagentItemLink(index, slot),
                                select(3, GetTradeSkillReagentInfo(index, slot)))
    end
end

function TipMethods:SetAction(action)
    local link = select(2, self:GetItem())
    return OnTooltipSetItem(self, link, GetItemCount(link))
end

local function HookTip(tip)
    for k, v in pairs(TipMethods) do
        hooksecurefunc(tip, k, v)
    end

    if tip.shoppingTooltips then
        for _, v in ipairs(tip.shoppingTooltips) do
            hooksecurefunc(v, 'SetCompareItem', OnCompareItem)
        end
    end
end

HookTip(GameTooltip)
HookTip(ItemRefTooltip)
