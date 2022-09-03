-- Counter.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 12/3/2019, 2:52:21 PM
--
local pairs, ipairs = pairs, ipairs

local GetItemCount = GetItemCount

---@type ns
local ns = select(2, ...)
local Cache = ns.Cache

local BAGS = ns.GetBags(ns.BAG_ID.BAG)
local BANKS = ns.GetBags(ns.BAG_ID.BANK)
local GUILDBANKS = ns.GetBags(ns.BAG_ID.GUILDBANK)

---@class Counter: AceAddon-3.0, AceEvent-3.0
local Counter = ns.Addon:NewModule('Counter', 'AceEvent-3.0')

function Counter:OnInitialize()
    self.Cacher = ns.Cacher:New()
    self.Cacher:Patch(self, 'GetOwnerItemCount', true)
    self.GetOwnerItemCount.Cachable = function(info)
        return info.cached
    end
end

function Counter:OnEnable()
    self:RegisterMessage('GUILDBANK_OPENED', 'OnGuildBankUpdate')
    self:RegisterMessage('GUILDBANK_CLOSED', 'OnGuildBankUpdate')
end

function Counter:OnGuildBankUpdate()
    self.Cacher:RemoveCache(ns.GetCurrentGuildOwner())
end

function Counter:GetBagItemCount(owner, bag, itemId)
    local info = Cache:GetBagInfo(owner, bag)
    if not info.count or info.count == 0 then
        return 0
    end

    local count = 0
    for slot = 1, info.count do
        local info = Cache:GetItemInfo(owner, bag, slot)
        if info.id == itemId then
            count = count + (info.count or 1)
        end
    end
    return count
end

function Counter:GetOwnerItemCount(owner, itemId)
    local info = Cache:GetOwnerInfo(owner)
    local mails = self:GetBagItemCount(owner, ns.MAIL_CONTAINER, itemId)
    local cods = self:GetBagItemCount(owner, ns.COD_CONTAINER, itemId)
    local equipInBag = self:GetEquippedBagCount(owner, ns.BAG_ID.BAG, itemId)
    local equipInBank = self:GetEquippedBagCount(owner, ns.BAG_ID.BANK, itemId)
    local equip = self:GetBagItemCount(owner, ns.EQUIP_CONTAINER, itemId)
    local bags, banks, guilds = 0, 0, 0

    if info.cached then
        for _, bag in ipairs(BAGS) do
            bags = bags + self:GetBagItemCount(owner, bag, itemId)
        end
        for _, bag in ipairs(BANKS) do
            banks = banks + self:GetBagItemCount(owner, bag, itemId)
        end
        for _, bag in ipairs(GUILDBANKS) do
            guilds = guilds + self:GetBagItemCount(owner, bag, itemId)
        end
    else
        local owned = GetItemCount(itemId, true)
        local carrying = GetItemCount(itemId)

        bags = carrying - equip - equipInBag
        banks = owned - carrying - equipInBank
    end

    equip = equip + equipInBag + equipInBank

    return {equip, bags, banks, mails, cods, guilds, cached = info.cached}
end

function Counter:GetOwnerItemTotal(owner, itemId)
    local counts = self:GetOwnerItemCount(owner, itemId)
    local count = 0
    for i, v in ipairs(counts) do
        count = count + v
    end
    return count
end

function Counter:GetEquippedBagCount(owner, bagId, itemId)
    local count = 0
    local bags = ns.GetBags(bagId)
    for _, bag in ipairs(bags) do
        local slot = ns.BagToSlot(bag)
        if slot then
            local info = Cache:GetItemInfo(owner, ns.EQUIP_CONTAINER, slot)
            if itemId == info.id then
                count = count + (info.count or 1)
            end
        end
    end
    return count
end

function Counter:RemoveCache(owner)
    self.Cacher:RemoveCache(owner)
end
