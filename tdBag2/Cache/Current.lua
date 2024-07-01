-- Current.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 1/2/2020, 9:55:26 PM
--
---@class ns
local ns = select(2, ...)

local C = ns.C

---- LUA
local select = select

---- WOW
local GetBankSlotCost = GetBankSlotCost
local GetContainerItemInfo = C.Container.GetContainerItemInfo
local GetContainerNumFreeSlots = C.Container.GetContainerNumFreeSlots
local GetContainerNumSlots = C.Container.GetContainerNumSlots
local GetInventoryItemID = C.Container.GetInventoryItemID
local GetInventoryItemLink = C.Container.GetInventoryItemLink
local GetInventoryItemQuality = C.Container.GetInventoryItemQuality
local GetInventoryItemTexture = C.Container.GetInventoryItemTexture
local GetContainerItemID = C.Container.GetContainerItemID
local GetContainerItemLink = C.Container.GetContainerItemLink
local GetCursorMoney = GetCursorMoney
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
        local info = GetContainerItemInfo(bag, slot)
        if info then
            data.icon = info.iconFileID
            data.count = info.stackCount
            data.locked = info.isLocked
            data.quality = info.quality
            data.readable = info.isReadable
        end
    elseif ns.IsEquip(bag) then
        data.link = GetInventoryItemLink('player', slot)
        data.icon = GetInventoryItemTexture('player', slot)
        data.quality = GetInventoryItemQuality('player', slot)
        data.id = GetInventoryItemID('player', slot)
    end
    return data
end
