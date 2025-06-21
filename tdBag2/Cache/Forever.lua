-- Forever.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 12/31/2019, 1:07:26 PM
--
local C = LibStub('C_Everywhere')

---- LUA
local select, pairs, ipairs = select, pairs, ipairs
local tinsert, sort = table.insert, table.sort or sort
local tonumber, floor = tonumber, math.floor
local strsplit, format = strsplit, string.format
local time = time
local tDeleteItem = tDeleteItem
local tAppendAll = tAppendAll

---- WOW
local GetInventoryItemCount = GetInventoryItemCount
local GetInventoryItemLink = GetInventoryItemLink
local GetMoney = GetMoney
local UnitClassBase = UnitClassBase
local UnitFactionGroup = UnitFactionGroup
local UnitRace = UnitRace
local UnitSex = UnitSex
local GetInboxNumItems = GetInboxNumItems
local GetInboxHeaderInfo = GetInboxHeaderInfo
local GetInboxItemLink = GetInboxItemLink
local GetInboxItem = GetInboxItem
local GetNumGuildBankTabs = GetNumGuildBankTabs
local GetGuildBankItemLink = GetGuildBankItemLink
local GetGuildBankItemInfo = GetGuildBankItemInfo

---- G
local NUM_BAG_SLOTS = NUM_TOTAL_EQUIPPED_BAG_SLOTS or Constants.InventoryConstants.NumBagSlots
local INVSLOT_TABARD = INVSLOT_TABARD
local INVSLOT_LAST_EQUIPPED = INVSLOT_LAST_EQUIPPED
local ATTACHMENTS_MAX_RECEIVE = ATTACHMENTS_MAX_RECEIVE

---@class ns
local ns = select(2, ...)

local L = ns.L

local BAGS = ns.GetBags(ns.BAG_ID.BAG)
local BANKS = ns.GetBags(ns.BAG_ID.BANK)
local MAIL_CONTAINER = ns.MAIL_CONTAINER
local EQUIP_CONTAINER = ns.EQUIP_CONTAINER
local COD_CONTAINER = ns.COD_CONTAINER
local SECONDS_OF_DAY = ns.SECONDS_OF_DAY
local KEYRING_FAMILY = ns.KEYRING_FAMILY

local NO_RESULT = {cached = true}

---@class Forever: AceModule, AceEvent-3.0
local Forever = ns.Addon:NewModule('Forever', 'AceEvent-3.0')

function Forever:OnInitialize()
    self.Cacher = ns.Cacher:New()
    self.Cacher:Patch(self, 'GetBagInfo', 'GetOwnerInfo')
    self.Cacher:Patch(self, 'GetItemInfo', true)
    self.GetItemInfo.Cachable = function(info)
        return not info.noCache
    end
end

function Forever:OnEnable()
    self:UpgradeCache()
    self:SetupCache()
    self:SetupAnyAccount()
    self:RefreshOwners()
    self:SetupEvents()
    self:UpdateData()
    self:SendMessage('FOREVER_LOADED')
end

function Forever:SetupAnyAccount()
    self.other = {}

    if not _G.TDDB_BAG2_ANYACCOUNT then
        return
    end

    local guilds = {}

    for _, v in pairs(_G.TDDB_BAG2_ANYACCOUNT) do
        local ok, realmDb = pcall(function()
            return v.global.forever[ns.REALM]
        end)
        if ok and realmDb then
            for owner, data in pairs(realmDb) do
                if owner ~= ns.PLAYER then
                    if ns.IsGuildOwner(owner) then
                        if data.timestamp and (not guilds[owner] or data.timestamp > guilds[owner].timestamp) then
                            guilds[owner] = data
                        end
                    elseif not self.realm[owner] then
                        self.other[owner] = data
                    end
                end
            end
        end
    end

    for k, v in pairs(guilds) do
        self.other[k] = v
    end

    _G.TDDB_BAG2_ANYACCOUNT = nil
end

function Forever:UpgradeCache()
    local database = ns.Addon.db.global.forever

    if database.version and database.version >= 20000 then
        return
    end

    database.version = ns.VERSION

    local db = {}

    for _, realm in ipairs(ns.REALMS) do
        local realmDb = database[realm]
        if realmDb then
            database[realm] = nil
            for name, data in pairs(realmDb) do
                if not name:find('-', nil, true) or not data.name then
                    data.name = format('%s-%s', name, realm)
                    data.realm = ns.REALM
                end
                db[data.name] = data
            end
        end
    end

    database[ns.REALM] = db
end

function Forever:SetupCache()
    self.db = ns.Addon.db.global.forever
    self.db[ns.REALM] = self.db[ns.REALM] or {}
    self.realm = self.db[ns.REALM]
    self.realm[ns.PLAYER] = self.realm[ns.PLAYER] or {}
    self.player = self.realm[ns.PLAYER]

    self.player[EQUIP_CONTAINER] = self.player[EQUIP_CONTAINER] or {}

    self.player.faction = UnitFactionGroup('player')
    self.player.class = UnitClassBase('player')
    self.player.race = select(2, UnitRace('player'))
    self.player.gender = UnitSex('player')

    self.allOwners = {}
    self.localOwners = {}
    self.otherOwners = {}
end

local function compare(a, b)
    return Forever:CompareOwner(a, b)
end

function Forever:CompareOwner(a, b)
    if self.realm[a] and self.realm[b] then
        return self.realm[a].money > self.realm[b].money
    end
    if self.other[a] and self.other[b] then
        return self.other[a].money > self.other[b].money
    end
    return self.realm[a]
end

local function applyOwners(db, owners, guilds, touched)
    for k in pairs(db) do
        if k ~= ns.PLAYER and not touched[k] then
            if ns.IsGuildOwner(k) then
                tinsert(guilds, k)
            else
                tinsert(owners, k)
            end
            touched[k] = true
        end
    end
    sort(owners, compare)
end

function Forever:RefreshOwners()
    local localOwners = wipe(self.localOwners)
    local otherOwners = wipe(self.otherOwners)
    local allOwners = wipe(self.allOwners)
    local guilds = {}
    local touched = {}

    applyOwners(self.realm, localOwners, guilds, touched)
    applyOwners(self.other, otherOwners, guilds, touched)

    tinsert(localOwners, 1, ns.PLAYER)

    tAppendAll(allOwners, localOwners)
    tAppendAll(allOwners, otherOwners)
    tAppendAll(allOwners, guilds)
end

function Forever:GetGuildCache()
    local key = ns.GetCurrentGuildOwner()
    if not key then
        return
    end

    if not self.realm[key] then
        self.realm[key] = {guild = true, faction = UnitFactionGroup('player')}
        self:RefreshOwners()
    end
    return self.realm[key]
end

function Forever:SetupEvents()
    self:RegisterEvent('BAG_UPDATE')
    self:RegisterEvent('BAG_CLOSED')
    self:RegisterEvent('PLAYER_MONEY')
    self:RegisterEvent('PLAYER_INTERACTION_MANAGER_FRAME_SHOW')
    self:RegisterEvent('PLAYER_INTERACTION_MANAGER_FRAME_HIDE')
    self:RegisterEvent('PLAYER_EQUIPMENT_CHANGED')
end

function Forever:UpdateData()
    for _, bag in ipairs(BAGS) do
        self:SaveBag(bag)
    end

    for slot = 1, INVSLOT_LAST_EQUIPPED do
        self:SaveEquip(slot)
    end

    self:PLAYER_MONEY()
end

---- Events

function Forever:PLAYER_INTERACTION_MANAGER_FRAME_SHOW(_, id)
    if id == 17 then
        self.atMail = true
        self:SendMessage('MAIL_OPENED')
    elseif id == 8 then
        self.atBank = true
        self.Cacher:RemoveCache(ns.REALM, ns.PLAYER)
        self:SendMessage('BANK_OPENED')
    elseif id == 10 and ns.FEATURE_GUILDBANK then
        self.atGuildBank = true
        self.Cacher:RemoveCache(ns.REALM, ns.GetCurrentGuildOwner())
        self:SendMessage('GUILDBANK_OPENED')
    end
end

function Forever:PLAYER_INTERACTION_MANAGER_FRAME_HIDE(_, id)
    if id == 17 then
        if self.atMail then
            self:SaveMail()
            self.atMail = nil
        end
        self:SendMessage('MAIL_CLOSED')
    elseif id == 8 then
        if self.atBank then
            for _, bag in ipairs(BANKS) do
                self:SaveBag(bag)
            end
            self.Cacher:RemoveCache(ns.REALM, ns.PLAYER)
            self.atBank = nil
        end
        self:SendMessage('BANK_CLOSED')
    elseif id == 10 and ns.FEATURE_GUILDBANK then
        if self.atGuildBank then
            self:SaveGuild()
            self.Cacher:RemoveCache(ns.REALM, ns.GetCurrentGuildOwner())
            self.atGuildBank = nil
        end
        self:SendMessage('GUILDBANK_CLOSED')
    end
end

function Forever:BAG_UPDATE(_, bag)
    if bag <= NUM_BAG_SLOTS then
        self:SaveBag(bag)
    end
end

Forever.BAG_CLOSED = ns.Spawned(Forever.BAG_UPDATE)

function Forever:PLAYER_MONEY()
    self.player.money = GetMoney()
end

function Forever:PLAYER_EQUIPMENT_CHANGED(_, slot)
    self:SaveEquip(slot)
    self.Cacher:RemoveCache(ns.REALM, ns.PLAYER, EQUIP_CONTAINER, slot)
end

function Forever:ParseItem(link, count, timeout)
    if link then
        if link:find('0:0:0:0:0:-?%d+:-?%d+:-?%d+:0:0') then
            link = link:match('|H%l+:(-?%d+)')
        else
            link = link:match('|H%l+:([%d:-]+)')
        end

        count = count and count > 1 and count or nil
        if count or timeout then
            link = link .. ';' .. (count or '')
        end
        if timeout then
            link = link .. ';' .. timeout
        end
        return link
    end
end

function Forever:SaveBag(bag)
    local size = C.Container.GetContainerNumSlots(bag)
    local items
    if size > 0 then
        items = {}
        items.size = size
        items.family = not ns.IsBaseBag(bag) and select(2, C.Container.GetContainerNumFreeSlots(bag)) or nil

        for slot = 1, size do
            local link = C.Container.GetContainerItemLink(bag, slot)
            local info = C.Container.GetContainerItemInfo(bag, slot)
            local count = info and info.stackCount or nil
            items[slot] = self:ParseItem(link, count)
        end
    end
    self.player[bag] = items

    if not ns.IsBaseBag(bag) then
        local slot = ns.BagToSlot(bag)
        if slot then
            self:SaveEquip(slot)
        end
    end
end

function Forever:SaveEquip(slot)
    local link = GetInventoryItemLink('player', slot)
    local count = GetInventoryItemCount('player', slot)

    self.player[EQUIP_CONTAINER][slot] = self:ParseItem(link, count)
end

function Forever:SaveMail()
    local mails = {}
    local cods = {}
    local now = time()

    local num --[[, total]] = GetInboxNumItems()
    for i = 1, num do
        local codAmount, daysLeft = select(6, GetInboxHeaderInfo(i))
        local timeout = floor(now + daysLeft * SECONDS_OF_DAY)
        local isCod = codAmount > 0

        for j = 1, ATTACHMENTS_MAX_RECEIVE do
            local link = GetInboxItemLink(i, j)
            if link then
                local count = select(4, GetInboxItem(i, j))

                tinsert(isCod and cods or mails, self:ParseItem(link, count, timeout))
            end
        end
    end

    mails.size = #mails
    cods.size = #cods

    self.player[MAIL_CONTAINER] = mails
    self.player[COD_CONTAINER] = cods

    self.Cacher:RemoveCache(ns.REALM, ns.PLAYER, MAIL_CONTAINER)
    self.Cacher:RemoveCache(ns.REALM, ns.PLAYER, COD_CONTAINER)
end

function Forever:SaveGuild()
    local guild = self:GetGuildCache()
    if not guild then
        return
    end
    for i = 1, GetNumGuildBankTabs() do
        local items = {}
        items.size = 98

        for j = 1, 98 do
            local link = GetGuildBankItemLink(i, j)
            local _, count = GetGuildBankItemInfo(i, j)
            items[j] = self:ParseItem(link, count)
        end

        guild[i + 50] = items
    end
    guild.timestamp = time()
end

function Forever:FindData(realm, name, ...)
    local db
    if realm == ns.REALM then
        db = self.realm[name] or self.other[name]
    else
        db = self.db[realm] and self.db[realm][name]
    end
    if not db then
        return
    end

    for i = 1, select('#', ...) do
        local key = select(i, ...)
        db = db[key]
        if not db then
            return
        end
    end
    return db
end

---- interface

function Forever:GetOwnerInfo(realm, name)
    local ownerData = self:FindData(realm, name)
    if ownerData then
        ---@type tdBag2OwnerInfo
        local data = {}
        data.cached = true
        data.name = name
        data.realm = realm
        data.faction = ownerData.faction
        data.class = ownerData.class
        data.race = ownerData.race
        data.gender = ownerData.gender
        data.money = ownerData.money
        data.guild = ownerData.guild
        return data
    end
    return NO_RESULT
end

function Forever:GetBagInfo(realm, name, bag)
    ---@type tdBag2BagInfo
    local data = {}
    local bagData = self:FindData(realm, name, bag)

    data.cached = true

    if ns.IsContainerBag(bag) then
        if ns.IsKeyring(bag) then
            data.family = KEYRING_FAMILY
            data.owned = true
        elseif ns.IsBaseBag(bag) then
            data.count = C.Container.GetContainerNumSlots(bag)
            data.owned = true
            data.family = 0
        end
    elseif ns.IsEquip(bag) then
        data.count = INVSLOT_LAST_EQUIPPED
        data.title = L['Equipped']
    elseif ns.IsMail(bag) then
        data.title = L['Mail']
    elseif bag == ns.COD_CONTAINER then
        data.title = L['COD']
    end

    if bagData then
        local free = 0
        for i = 1, data.count or bagData.size or 0 do
            if not bagData[i] then
                free = free + 1
            end
        end

        data.count = bagData.size or data.count
        data.family = bagData.family or data.family or 0
        data.owned = true
        data.free = free
        data.slot = ns.BagToSlot(bag)

        if data.slot then
            local info = self:GetItemInfo(realm, name, EQUIP_CONTAINER, data.slot)
            data.icon = info.icon
            data.link = info.link
            data.id = info.id
        end
    end
    return data
end

function Forever:GetItemInfo(realm, name, bag, slot)
    local itemData = self:FindData(realm, name, bag, slot)
    if itemData then
        local data = {}
        local link, count, timeout = strsplit(';', itemData)

        data.cached = true
        data.link = 'item:' .. link
        data.count = bag == ns.EQUIP_CONTAINER and slot ~= INVSLOT_TABARD and 1 or tonumber(count)
        data.id = tonumber(link:match('^(%d+)'))
        data.icon = C.Item.GetItemIconByID(data.id)
        data.timeout = tonumber(timeout)

        local itemName, itemLink, quality = C.Item.GetItemInfo(data.link)
        if itemName then
            data.link = itemLink
            data.quality = quality
        else
            data.noCache = true
        end
        return data
    end
    return NO_RESULT
end

function Forever:GetOwners()
    return self.allOwners
end

function Forever:GetLocalOwners()
    return self.localOwners
end

function Forever:GetOtherOwners()
    return self.otherOwners
end

function Forever:HasMultiOwners()
    return #self.otherOwners > 0 or #self.localOwners > 0
end

function Forever:DeleteOwnerInfo(realm, name)
    local realmData = self.db[realm]
    if realmData then
        realmData[name] = nil

        if realmData == self.realm then
            tDeleteItem(self.localOwners, name)
            ns.Events:Fire('OWNER_REMOVED')
        end
    end
end

function Forever:IsOtherOwner(owner)
    return not self.realm[owner]
end
