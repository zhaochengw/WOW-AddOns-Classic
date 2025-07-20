--[[
Copyright 2013-2025 João Cardoso
ItemSearch is distributed under the terms of the GNU General Public License (Version 3).
As a special exception, the copyright holders of this library give you permission to embed it
with independent modules to produce an addon, regardless of the license terms of these
independent modules, and to copy and distribute the resulting software under terms of your
choice, provided that you also meet, for each embedded independent module, the terms and
conditions of the license of that module. Permission is not granted to modify this library.

This library is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

This file is part of ItemSearch.
--]]

local Lib = LibStub('ItemSearchModify-1.3')
if Lib.Filters then return end

local C = LibStub('C_Everywhere')
local Parser = LibStub('CustomSearch-1.0')
local inRetail = C_TooltipInfo and true

local LE_ITEM_BIND_ON_ACQUIRE = LE_ITEM_BIND_ON_ACQUIRE or Enum.ItemBind.OnAcquire
local LE_ITEM_BIND_ON_EQUIP = LE_ITEM_BIND_ON_EQUIP or Enum.ItemBind.OnEquip
local LE_ITEM_BIND_ON_USE = LE_ITEM_BIND_ON_USE or Enum.ItemBind.OnUse
local LE_ITEM_BIND_QUEST = LE_ITEM_BIND_QUEST or Enum.ItemBind.Quest


--[[ Baseline ]]--

Lib.Filters = {}
Lib.Filters.tooltip = {
    tags = {'t', 'tip', 'tooltip'},
    onlyTags = not C_TooltipInfo,

    canSearch = function(self, operator, search)
        return not operator and search
    end,

    match = function(self, item, _, search)
        local where = item.location
        local data = where and (where.bagID and C.TooltipInfo.GetBagItem(where.bagID, where.slotIndex) or
                     where.equipmentSlotIndex and C.TooltipInfo.GetInventoryItem(where.unitID or 'player', where.equipmentSlotIndex))
                     or C.TooltipInfo.GetHyperlink(item.link)
        if data then
            for i, line in ipairs(data.lines) do
                if Parser:Find(search, line.leftText) then
                    return true
                end
            end
        end
    end
}

Lib.Filters.class = {
    tags = {'c', 'class'},

    canSearch = function(self, operator, search)
        return not operator and search
    end,

    match = function(self, item, _, search)
        local class, subClass = select(6, C.Item.GetItemInfo(item.link))
        return Parser:Find(search, class, subClass)
    end
}

Lib.Filters.level = {
    tags = {'l', 'level', 'lvl', 'ilvl'},

    canSearch = function(self, operator, search)
        return (operator or not inRetail) and tonumber(search)
    end,

    match = function(self, item, operator, num)
        local lvl = item.location and C.Item.GetCurrentItemLevel(item.location)
                    or select(4, C.Item.GetItemInfo(item.link))
        if lvl then
            return Parser:Compare(operator, lvl, num)
        end
    end
}

Lib.Filters.requiredlevel = {
    tags = {'r', 'req', 'rl', 'reql', 'reqlvl'},

    canSearch = function(self, operator, search)
        return (operator or not inRetail) and tonumber(search)
    end,

    match = function(self, item, operator, num)
        local lvl = select(5, C.Item.GetItemInfo(item.link))
        if lvl then
            return Parser:Compare(operator, lvl, num)
        end
    end
}

Lib.Filters.bind = {
    keywords = {
        bop = LE_ITEM_BIND_ON_ACQUIRE,
        boe = LE_ITEM_BIND_ON_EQUIP,
        bou = LE_ITEM_BIND_ON_USE,
        boq = LE_ITEM_BIND_QUEST,
    },

    canSearch = function(self, operator, search)
        return not operator and self.keywords[search]
    end,

    match = function(self, item, _, target)
        return target == select(14, C.Item.GetItemInfo(item.link))
    end
}

Lib.Filters.quality = {
    tags = {'q', 'quality', 'rarity'},
    keywords = {},

    canSearch = function(self, _, search)
        for quality, name in pairs(self.keywords) do
          if Parser:Find(search, name) then
            return quality
          end
        end
    end,

    match = function(self, item, operator, target)
        local quality = item.link:find('battlepet') and tonumber(item.link:match('%d+:%d+:(%d+)'))
                        or C.Item.GetItemQualityByID(item.link)
        return Parser:Compare(operator, quality, target)
    end,
}

for i = 0, #ITEM_QUALITY_COLORS do
    Lib.Filters.quality.keywords[i] = _G['ITEM_QUALITY' .. i .. '_DESC']:lower()
end

if LE_EXPANSION_LEVEL_CURRENT > 0 then
    Lib.Filters.expansion = {
        tags = {'e', 'expac', 'expansion'},
        keywords = {},

        canSearch = function(self, operator, search)
            for expac, name in pairs(self.keywords) do
                if Parser:Find(search, name) then
                    return expac
                end
            end
        end,

        match = function(self, item, operator, target)
            local expac = select(15, C.Item.GetItemInfo(item.link))
            return Parser:Compare(operator, expac, target)
        end
    }

    for i = 0, NUM_LE_EXPANSION_LEVELS do
        Lib.Filters.expansion.keywords[i] = _G['EXPANSION_NAME' .. i]:lower()
    end
end


--[[ Classic Fallbacks ]]--

Lib.Filters.name = {
    tags = {'n', 'name'},
    onlyTags = inRetail,

    canSearch = function(self, operator, search)
        return not operator and search
    end,

    match = function(self, item, _, search)
        return Parser:Find(search, C.Item.GetItemNameByID(item.link) or item.link:match('%[(.+)%]'))
    end
}

Lib.Filters.slot = {
    tags = {'s', 'slot'},
    onlyTags = inRetail,

    canSearch = function(self, operator, search)
        return not operator and search
    end,

    match = function(self, item, _, search)
        local equipSlot = select(9, C.Item.GetItemInfo(item.link))
        return Parser:Find(search, _G[equipSlot])
    end
}

Lib.Filters.bound = {
    onlyTags = inRetail,

    canSearch = function(self, operator, search)
        return not operator and Parser:Find(search, ITEM_SOULBOUND)
    end,

    match = function(self, item)
        return item.location and C.Item.IsBound(item.location)
    end
}

Lib.Filters.sets = {
    tags = {'s', 'set'},
    onlyTags = inRetail,

    canSearch = function(self, operator, search)
        return not operator and search
    end,

    match = function(self, item, _, search)
        local id = item.link:match('item:(%d+)')
		if id then
            return Lib:BelongsToSet(tonumber(id), search)
        end
    end
}

Lib.Filters.spellKeyword = {
    keyword = 'spell',

    canSearch = function(self, operator, search)
        return search:lower() == self.keyword
    end,

    match = function(self, item, _, search)
        return not not C.Item.GetItemSpell(item.link)
    end,
}

Lib.Filters.spell = {
    tags = {'spell'},
    onlyTags = true,

    canSearch = function(self, operator, search)
        return search
    end,

    match = function(self, item, _, search)
        local spellName, spellId = C.Item.GetItemSpell(item.link)
        local searchId = tonumber(search)
        if searchId then
            return searchId == spellId
        else
            return Parser:Find(search, spellName or '')
        end
    end,
}

Lib.Filters.equippable = {
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

Lib.Filters.blizzarSetKeyword = {
    keyword1 = 'bset',

    canSearch = function(self, operator, search)
        return self.keyword1 == search:lower()
    end,

    match = function(self, item, _, search)
        local setId = select(16, C.Item.GetItemInfo(item.link))
        return setId
    end,
}

Lib.Filters.blizzardSet = {
    tags = {'bset'},
    onlyTags = true,

    canSearch = function(self, operator, search)
        return search
    end,

    match = function(self, item, _, search)
        local setId = select(16, C.Item.GetItemInfo(item.link))
        if setId and setId ~= 0 then
            local setName = C.Item.GetItemSetInfo(setId)
            return Parser:Find(search, setName)
        end
    end,
}

Lib.Filters.invtype = {
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
        local text = Parser:Clean(search)
        if text == equipLoc:lower() then
            return true
        end

        local localeLoc = _G[equipLoc]
        return localeLoc and text == localeLoc:lower()
    end,
}
