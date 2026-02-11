--[[
Copyright 2013-2026 João Cardoso
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

local Lib = LibStub('ItemSearch-1.3')
if Lib.Filters then return end

local C = LibStub('C_Everywhere')
local Parser = LibStub('CustomSearch-1.0')

local inRetail = C_TooltipInfo and true
local staticTooltips = setmetatable({}, {
	__index = function (t, link)
		local data = C.TooltipInfo.GetHyperlink(link)
		if data and (#data.lines > 1 or data.battlePetName) then
			t[link] = data
		end
		return data
	end})

C_Timer.NewTicker(60, function() wipe(staticTooltips) end)


--[[ Baseline ]]--

Lib.Filters = {}
Lib.Filters.tooltip = {
	tags = {'tt', 'tip', 'tooltip'},
	onlyTags = not C_TooltipInfo,

	canSearch = function(self, operator, search)
		return not operator and search
	end,

	match = function(self, item, _, search)
		local where = item.location
		local data = where and (where.bagID and C.TooltipInfo.GetBagItem(where.bagID, where.slotIndex) or
					where.equipmentSlotIndex and C.TooltipInfo.GetInventoryItem(where.unitID or 'player', where.equipmentSlotIndex))
					or staticTooltips[item.link]
		if data then
			for i, line in ipairs(data.lines) do
				if Parser:FindOne(search, line.leftText) then
					return true
				end
			end
			return Parser:FindOne(search, data.battlePetName)
		else
			return Parser:FindOne(search, item.link)
		end
	end
}

Lib.Filters.class = {
	tags = {'t', 'type'},

	canSearch = function(self, operator, search)
		return not operator and search
	end,

	match = function(self, item, _, search)
		local class, subClass = select(6, C.Item.GetItemInfo(item.link))
		return Parser:Find(search, class, subClass)
	end
}

Lib.Filters.level = {
	tags = {'l', 'lvl', 'ilvl', 'level'},

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
	tags = {'r', 'req', 'rl', 'reqlvl'},

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
		bop = Enum.ItemBind.OnAcquire,
		boe = Enum.ItemBind.OnEquip,
		bou = Enum.ItemBind.OnUse,
		[C.Item.GetItemClassInfo(Enum.ItemClass.Questitem)] = Enum.ItemBind.Quest,
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
		if name:find(search, 1, true) then
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
	Lib.Filters.quality.keywords[i] = Parser:Clean(_G['ITEM_QUALITY' .. i .. '_DESC'])
end

if LE_EXPANSION_LEVEL_CURRENT > 0 then
	Lib.Filters.expansion = {
		tags = {'e', 'expac', 'expansion'},
		keywords = {},

		canSearch = function(self, operator, search)
			for expac, name in pairs(self.keywords) do
				if name:find(search, 1, true) then
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
		Lib.Filters.expansion.keywords[i] = Parser:Clean(_G['EXPANSION_NAME' .. i])
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
		return Parser:FindOne(search, C.Item.GetItemNameByID(item.link) or item.link:match('%[(.+)%]'))
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
		return Parser:FindOne(search, _G[equipSlot])
	end
}

Lib.Filters.bound = {
	onlyTags = inRetail,
	
	canSearch = function(self, operator, search)
		return not operator and ITEM_SOULBOUND:find(search, 1, true)
	end,

	match = function(self, item)
		return item.location and C.Item.IsBound(item.location)
	end
}

Lib.Filters.sets = {
	tags = {'set'},
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