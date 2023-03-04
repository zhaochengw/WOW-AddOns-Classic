-- Current.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 1/2/2020, 9:55:26 PM
--
---- LUA
local select = select

---- WOW
local GetBankSlotCost = GetBankSlotCost
local GetContainerItemInfo = function(bag, slot)
    if C_Container and C_Container.GetContainerItemInfo then
        local info = C_Container.GetContainerItemInfo(bag, slot)
        if info then
            return info.iconFileID, info.stackCount, info.isLocked, info.quality, info.isReadable, info.hasLoot, info.hyperlink, info.isFiltered, info.hasNoValue, info.itemID, info.isBound
        end
    else
        return _G.GetContainerItemInfo(bag, slot)
    end
end
local GetContainerNumFreeSlots = GetContainerNumFreeSlots or C_Container.GetContainerNumFreeSlots
local GetContainerNumSlots = GetContainerNumSlots or C_Container.GetContainerNumSlots
local GetContainerItemID = GetContainerItemID or C_Container.GetContainerItemID
local GetContainerItemLink = GetContainerItemLink or C_Container.GetContainerItemLink
local GetCursorMoney = GetCursorMoney
local GetInventoryItemID = GetInventoryItemID
local GetInventoryItemLink = GetInventoryItemLink
local GetInventoryItemQuality = GetInventoryItemQuality
local GetInventoryItemTexture = GetInventoryItemTexture
local GetMoney = GetMoney
local GetNumBankSlots = GetNumBankSlots
local GetPlayerTradeMoney = GetPlayerTradeMoney
local HasKey = HasKey
local UnitClassBase = UnitClassBase
local UnitFactionGroup = UnitFactionGroup
local UnitRace = UnitRace
local UnitSex = UnitSex

---- G
local INVSLOT_LAST_EQUIPPED = INVSLOT_LAST_EQUIPPED
local NUM_BAG_SLOTS = NUM_BAG_SLOTS

---@class ns
local ns = select(2, ...)

local KEYRING_FAMILY = ns.KEYRING_FAMILY

---@class Current
local Current = {}
ns.Current = Current

function Current:GetOwnerInfo()
    ---@type tdBag2OwnerInfo
    local data = {}
    data.name, data.realm = ns.PLAYER, ns.REALM
    data.class = UnitClassBase('player')
    data.faction = UnitFactionGroup('player')
    data.race = select(2, UnitRace('player'))
    data.gender = UnitSex('player')
    data.money = (GetMoney() or 0) - GetCursorMoney() - GetPlayerTradeMoney()
    return data
end

function Current:GetBagInfo(bag)
    ---@type tdBag2BagInfo
    local data = {}

    if ns.IsContainerBag(bag) then
        data.free, data.family = GetContainerNumFreeSlots(bag)
        data.count = GetContainerNumSlots(bag)

        if ns.IsCustomBag(bag) then
            data.slot = ns.BagToSlot(bag)
            data.link = GetInventoryItemLink('player', data.slot)
            data.icon = GetInventoryItemTexture('player', data.slot)

            if ns.IsInBank(bag) then
                data.owned = (bag - NUM_BAG_SLOTS) <= GetNumBankSlots()
                data.cost = GetBankSlotCost()
            else
                data.owned = true
            end
        elseif ns.IsKeyring(bag) then
            data.family = KEYRING_FAMILY
            data.owned = HasKey() or data.count > 0
            data.free = data.count and data.free and data.count + data.free - 32
        else
            data.owned = true
        end
    elseif ns.IsEquip(bag) then
        data.count = INVSLOT_LAST_EQUIPPED
        data.family = -4
        data.owned = true
    end
    return data
end

function Current:GetItemInfo(bag, slot)
    ---@type tdBag2ItemInfo
    local data = {}
    if ns.IsContainerBag(bag) then
        data.id = GetContainerItemID(bag, slot)
        data.link = GetContainerItemLink(bag, slot)
        data.icon, data.count, data.locked, data.quality, data.readable = GetContainerItemInfo(bag, slot)
    elseif ns.IsEquip(bag) then
        data.link = GetInventoryItemLink('player', slot)
        data.icon = GetInventoryItemTexture('player', slot)
        data.quality = GetInventoryItemQuality('player', slot)
        data.id = GetInventoryItemID('player', slot)
    end
    return data
end
