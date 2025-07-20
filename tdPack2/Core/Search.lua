-- Search.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 9/26/2019, 2:09:42 AM
--
-- luacheck: ignore 212/search 212/operator
--
---- LUA
local _G = _G
local select, pairs, ipairs = select, pairs, ipairs
local tonumber = tonumber

---@type ns
local ns = select(2, ...)

local L = ns.L
local C = ns.C

---- LIBS
local CustomSearch = LibStub('CustomSearch-1.0')
local ItemSearch = LibStub('ItemSearchModify-1.3')
local Filters = {}

---@class Addon.Search: AceModule, AceEvent-3.0
local Search = ns.Addon:NewModule('Search', 'AceEvent-3.0')

function Search:OnInitialize()
    self.filters = {}

    for k, v in pairs(ItemSearch.Filters) do
        self.filters[k] = v
    end

    for k, v in pairs(Filters) do
        self.filters[k] = v
    end
end

function Search:OnEnable()
end

function Search:Matches(link, search)
    return CustomSearch:Matches({link = link}, search, self.filters)
end

Filters.tdpackSpell = {
    keyword = 'spell',

    canSearch = function(self, operator, search)
        return search:lower() == self.keyword
    end,

    match = function(self, item, _, search)
        return not not C.Item.GetItemSpell(item.link)
    end,
}

Filters.tdpackSpellName = {
    tags = {'p', 'spell'},
    onlyTags = true,

    canSearch = function(self, operator, search)
        return search
    end,

    match = function(self, item, _, search)
        local searchId = tonumber(search)
        local spellName, spellId = C.Item.GetItemSpell(item.link)
        if searchId then
            return searchId == spellId
        else
            return CustomSearch:Find(search, spellName or '')
        end
    end,
}

Filters.tdPackEquippable = {
    keyword1 = 'equip',
    keyword2 = EQUIPSET_EQUIP:lower(),

    exclude = tInvert {'INVTYPE_BAG', 'INVTYPE_AMMO'},

    canSearch = function(self, operator, search)
        return self.keyword1 == search or self.keyword2 == search:lower()
    end,

    match = function(self, item)
        if not C.Item.IsEquippableItem(item.link) then
            return false
        end
        return not self.exclude[select(9, C.Item.GetItemInfo(item.link))]
    end,
}

Filters.tdPackBlizzardHasSet = {
    keyword1 = 'bset',

    canSearch = function(self, operator, search)
        return self.keyword1 == search:lower()
    end,

    match = function(self, item, _, search)
        local setId = select(16, C.Item.GetItemInfo(item.link))
        return setId
    end,
}

Filters.tdPackBlizzardSet = {
    tags = {'bset'},
    onlyTags = true,

    canSearch = function(self, operator, search)
        return search
    end,

    match = function(self, item, _, search)
        local setId = select(16, C.Item.GetItemInfo(item.link))
        if setId and setId ~= 0 then
            local setName = C.Item.GetItemSetInfo(setId)
            return CustomSearch:Find(search, setName)
        end
    end,
}

Filters.tdPackInvtype = {
    tags = {'inv'},
    onlyTags = true,

    canSearch = function(self, operator, search)
        return search
    end,

    match = function(self, item, _, search)
        local equipLoc = select(9, C.Item.GetItemInfo(item.link))
        if not equipLoc then
            return
        end
        local text = CustomSearch:Clean(search)
        if text == equipLoc:lower() then
            return true
        end

        local localeLoc = _G[equipLoc]
        return localeLoc and text == localeLoc:lower()
    end,
}

Filters.tdPackTags = {
    tags = {'tag'},

    canSearch = function(self, _, search)
        if #search < 2 then
            return
        end
        for k, v in pairs(self.items) do
            if k:find(search) == 1 then
                return k
            end
        end
    end,

    match = function(self, item, _, search)
        local items = self.items[search]
        if items then
            local id = tonumber(item.link:match('item:(%d+)'))
            return id and items[id]
        end
    end,

    items = (function()
        local items = {}
        for k, v in pairs(ns.ITEM_TAGS) do
            local ids = {}
            for _, id in ipairs(v) do
                ids[id] = true
            end
            items[k:lower()] = ids
            if v.locale then
                local localeKey = L['ITEM_TAG: ' .. k]
                if localeKey then
                    items[localeKey] = ids
                end
            end
        end
        return items
    end)(),
}
