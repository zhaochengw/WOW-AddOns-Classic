-- Forever.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 12/31/2019, 1:07:26 PM
--
---- LUA
local select, pairs, ipairs = select, pairs, ipairs
local tinsert = table.insert
local sort = table.sort or sort
local tonumber = tonumber
local strsplit = strsplit
local time = time
local floor = math.floor
local tDeleteItem = tDeleteItem

---- WOW
local GetContainerItemInfo = GetContainerItemInfo
local GetContainerNumFreeSlots = GetContainerNumFreeSlots
local GetContainerNumSlots = GetContainerNumSlots
local GetInventoryItemCount = GetInventoryItemCount
local GetInventoryItemLink = GetInventoryItemLink
local GetItemIcon = GetItemIcon
local GetItemInfo = GetItemInfo
local GetMoney = GetMoney
local IsLoggedIn = IsLoggedIn
local UnitClassBase = UnitClassBase
local UnitFactionGroup = UnitFactionGroup
local UnitRace = UnitRace
local UnitSex = UnitSex
local GetInboxNumItems = GetInboxNumItems
local GetInboxHeaderInfo = GetInboxHeaderInfo
local GetInboxItemLink = GetInboxItemLink
local GetInboxItem = GetInboxItem

---- G
local NUM_BAG_SLOTS = NUM_BAG_SLOTS
local INVSLOT_LAST_EQUIPPED = INVSLOT_LAST_EQUIPPED
local ATTACHMENTS_MAX_RECEIVE = ATTACHMENTS_MAX_RECEIVE

---@type ns
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

---@type tdBag2Forever
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
    self:SetupEvents()
    self:UpdateData()
    self:SendMessage('FOREVER_LOADED')
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

    local owners = {}
    for k in pairs(self.realm) do
        if k ~= ns.PLAYER then
            tinsert(owners, k)
        end
    end
    sort(owners, function(a, b)
        return self.realm[a].money > self.realm[b].money
    end)
    tinsert(owners, 1, ns.PLAYER)

    self.owners = owners
end

function Forever:SetupEvents()
    self:RegisterEvent('BAG_UPDATE')
    self:RegisterEvent('BAG_CLOSED')
    self:RegisterEvent('PLAYER_MONEY')
    self:RegisterEvent('BANKFRAME_OPENED')
    self:RegisterEvent('BANKFRAME_CLOSED')
    self:RegisterEvent('MAIL_SHOW')
    self:RegisterEvent('MAIL_CLOSED')
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

function Forever:BANKFRAME_OPENED()
    self.atBank = true
    self.Cacher:RemoveCache(ns.REALM, ns.PLAYER)
    self:SendMessage('BANK_OPENED')
end

function Forever:BANKFRAME_CLOSED()
    if self.atBank then
        for _, bag in ipairs(BANKS) do
            self:SaveBag(bag)
        end
        self.Cacher:RemoveCache(ns.REALM, ns.PLAYER)
        self.atBank = nil
    end
    self:SendMessage('BANK_CLOSED')
end

function Forever:MAIL_SHOW()
    self.atMail = true
    self:SendMessage('MAIL_OPENED')
end

function Forever:MAIL_CLOSED()
    if self.atMail then
        self:SaveMail()
        self.atMail = nil
    end
    self:SendMessage('MAIL_CLOSED')
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
        if link:find('0:0:0:0:0:%d+:%d+:%d+:0:0') then
            link = link:match('|H%l+:(%d+)')
        else
            link = link:match('|H%l+:([%d:]+)')
        end

        local count = count and count > 1 and count or nil
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
    local size = GetContainerNumSlots(bag)
    local items
    if size > 0 then
        items = {}
        items.size = size
        items.family = not ns.IsBaseBag(bag) and select(2, GetContainerNumFreeSlots(bag)) or nil

        for slot = 1, size do
            local _, count, _, _, _, _, link = GetContainerItemInfo(bag, slot)
            items[slot] = self:ParseItem(link, count)
        end
    end
    self.player[bag] = items

    if not ns.IsBaseBag(bag) then
        local slot = ns.BagToSlot(bag)
        self:SaveEquip(slot)
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

    local num, total = GetInboxNumItems()
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

function Forever:FindData(...)
    local db = self.db
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
        ---@type tdBag2CacheOwnerData
        local data = {}
        data.cached = true
        data.name = name
        data.realm = realm
        data.faction = ownerData.faction
        data.class = ownerData.class
        data.race = ownerData.race
        data.gender = ownerData.gender
        data.money = ownerData.money
        return data
    end
    return NO_RESULT
end

function Forever:GetBagInfo(realm, name, bag)
    ---@type tdBag2CacheBagData
    local data = {}
    local bagData = self:FindData(realm, name, bag)

    data.cached = true

    if ns.IsContainerBag(bag) then
        if ns.IsKeyring(bag) then
            data.family = KEYRING_FAMILY
            data.owned = true
        elseif ns.IsBaseBag(bag) then
            data.count = GetContainerNumSlots(bag)
            data.owned = true
            data.family = 0
        end
    elseif ns.IsEquip(bag) then
        data.count = INVSLOT_LAST_EQUIPPED - 1
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
        ---@type tdBag2CacheItemData
        local data = {}
        local link, count, timeout = strsplit(';', itemData)

        data.cached = true
        data.link = 'item:' .. link
        data.count = tonumber(count)
        data.id = tonumber(link:match('^(%d+)'))
        data.icon = GetItemIcon(data.id)
        data.timeout = tonumber(timeout)

        local name, link, quality = GetItemInfo(data.link)
        if name then
            data.link = link
            data.quality = quality
        else
            data.noCache = true
        end
        return data
    end
    return NO_RESULT
end

function Forever:GetOwners()
    return self.owners
end

function Forever:HasMultiOwners()
    return #self.owners > 1
end

function Forever:DeleteOwnerInfo(realm, name)
    local realmData = self.db[realm]
    if realmData then
        realmData[name] = nil

        if realmData == self.realm then
            tDeleteItem(self.owners, name)
            ns.Events:Fire('OWNER_REMOVED')
        end
    end
end
