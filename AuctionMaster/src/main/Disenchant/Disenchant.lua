--[[
	Copyright (C) Udorn (Blackhand)
	
	This program is free software; you can redistribute it and/or
	modify it under the terms of the GNU General Public License
	as published by the Free Software Foundation; either version 2
	of the License, or (at your option) any later version.

	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with this program; if not, write to the Free Software
	Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.	
--]]

-- Data found on http://www.wowwiki.com/Disenchanting_tables and adjusted by Wowhead and Echantrix
   
vendor.Disenchant = vendor.Vendor:NewModule("Disenchant")

local L = vendor.Locale.GetInstance()
local log = vendor.Debug:new("Disenchant")

-- {ITEM_TYPE, QUALITY, MIN_ITEM_LEVEL, MAX_ITEM_LEVEL, {{ITEM_CODE, PROXIMITY, MIN_ITEMS, MAX_ITEMS}, ... }
local INDEX_ITEM_TYPE = 1
local INDEX_QUALITY = 2
local INDEX_MIN_ITEM_LEVEL = 3
local INDEX_MAX_ITEM_LEVEL = 4
local INDEX_ITEMS = 5

local INDEX_ITEM_CODE = 1
local INDEX_PROXIMITY = 2
local INDEX_MIN_ITEMS = 3
local INDEX_MAX_ITEMS = 4
local INDEX_ESTIMATED = 5

local DEFAULT_DATA = [=[
# String representation of the disenchanting database. The entries are separated by newlines.
# Be very careful when changing anything!
# Modifying this database will prevent from getting any updates, so you should consider to share
# your data by creating a ticket with a copy of your database and reset to defaults, when an 
# AuctionMaster version has arrived containing your data. 
#
# Not disenchantable items are given by the prefix "EXCLUDE:" and a comma separated
# list of item-codes.
EXCLUDE: 20408, 20406, 20407
EXCLUDE: 11287, 11288
#
# Required skill data (prefixed by "SKILL:") is given in the format "SKILL < ITEM_LEVEL",
# which means that the skill is sufficient for all items smaller than
# the given level. The first entry denotes the corrsponding quality, 
# 1 for Uncommon items, 2 for Rare items and 3 for Epic items.
SKILL: 1, 1<21, 25<26, 50<31, 75<36, 100<41, 125<46, 150<51
SKILL: 1, 175<56, 200<61, 225<100, 275<130, 325<154 350<183, 425<334
SKILL: 2, 1<21, 25<26, 50<31, 75<36, 100<41, 125<46, 150<51
SKILL: 2, 175<56, 200<61, 225<100, 275<130, 325<288, 450<378
SKILL: 3, 225<90, 300<152, 375<359, 475<417
#
# And finally the disenchant entries with the prefix "DE:". They are the most difficult ones.
# The format is:
#
# {ITEM_TYPE, QUALITY, MIN_ITEM_LEVEL, MAX_ITEM_LEVEL, {{ITEM_CODE, PROXIMITY, MIN_ITEMS, MAX_ITEMS}, ... }
#
# ITEM_TYPE: 1 = Armor, 2 = Weapons, 3 = Armor + Weapons
# QUALITY: 1 = Uncommon, 2 = Rare, 3 = Epic
# MIN_ITEM_LEVEL: The minimal level for the items to be matched
# MAX_ITEM_LEVEL: The maximal level for the items to be matched
# ITEM_CODE: The item code of the dust, essence or whatever is procuded by the disenchanting
# PROXIMITY: The proximity between 0 and 1 for the given item
# MIN_ITEMS: The minimal estimated count to be produced 
# MAX_ITEMS: The maximal estimated count to be produced (optional)
# ESTIMATED: The estimated number of items. (optional)
#
# Uncommon Armor:
DE: {1, 1, 5, 15, {{10940, 0.8, 1, 2}, {10938, 0.2, 1, 2}}}
DE: {1, 1, 16, 20, {{10940, 0.75, 2, 3}, {10939, 0.2, 1, 2}, {10978, 0.05, 1}}}
DE: {1, 1, 21, 25, {{10940, 0.75, 4, 6}, {10998, 0.15, 1, 2}, {10978, 0.1, 1}}}
DE: {1, 1, 26, 30, {{11083, 0.75, 1, 2}, {11082, 0.2, 1, 2}, {11084, 0.05, 1}}}
DE: {1, 1, 31, 35, {{11083, 0.75, 2, 5}, {11134, 0.2, 1, 2}, {11138, 0.05, 1}}}
DE: {1, 1, 36, 40, {{11137, 0.75, 1, 2}, {11135, 0.2, 1, 2}, {11139, 0.05, 1}}}
DE: {1, 1, 41, 45, {{11137, 0.75, 2, 5}, {11174, 0.2, 1, 2}, {11177, 0.05, 1}}}
DE: {1, 1, 46, 50, {{11176, 0.75, 1, 2}, {11175, 0.2, 1, 2}, {11178, 0.05, 1}}}
DE: {1, 1, 51, 55, {{11176, 0.75, 2, 5}, {16202, 0.2, 1, 2}, {14343, 0.05, 1}}}
DE: {1, 1, 56, 60, {{16204, 0.75, 1, 2}, {16203, 0.2, 1, 2}, {14344, 0.05, 1}}}
DE: {1, 1, 61, 78, {{16204, 0.75, 2, 5}, {16203, 0.2, 2, 3}, {14344, 0.05, 1}}}
DE: {1, 1, 79, 79, {{22445, 0.75, 1, 3}, {22447, 0.22, 1, 3}, {22448, 0.03, 1}}}
DE: {1, 1, 80, 99, {{22445, 0.75, 2, 3}, {22447, 0.22, 2, 3}, {22448, 0.03, 1}}}
DE: {1, 1, 100, 129, {{22445, 0.75, 2, 5}, {22446, 0.22, 1, 2}, {22449, 0.03, 1}}}
DE: {1, 1, 130, 151, {{34054, 0.75, 1, 3}, {34056, 0.22, 1, 2}, {34053, 0.03, 1}}}
DE: {1, 1, 152, 277, {{34054, 0.75, 4, 7}, {34055, 0.22, 1, 2}, {34052, 0.03, 1}}}
DE: {1, 1, 278, 305, {{52555, 0.75, 1, 3}, {52718, 0.25, 1, 3}}}
DE: {1, 1, 306, 315, {{52555, 0.735, 1, 5}, {52719, 0.25, 1, 2}, {52718, 0.015, 1, 3}}}
DE: {1, 1, 316, 333, {{52555, 0.75, 1, 6}, {52719, 0.25, 1, 4}}}
DE: {1, 1, 416, 429, {{74249, 0.75, 2, 5}, {74250, 0.25, 1, 2}}}
DE: {1, 1, 430, 499, {{74249, 0.75, 2, 5}, {74250, 0.25, 1, 4}}}
#
# Uncommon Weapons:
DE: {2, 1, 6, 15, {{10938, 0.8, 1, 2}, {10940, 0.2, 1, 2}}}
DE: {2, 1, 16, 20, {{10939, 0.75, 1, 2}, {10940, 0.2, 2, 3}, {10978, 0.05, 1}}}
DE: {2, 1, 21, 25, {{10998, 0.75, 1, 2}, {10940, 0.15, 4, 6}, {10978, 0.1, 1}}}
DE: {2, 1, 26, 30, {{11082, 0.75, 1, 2}, {11083, 0.2, 1, 2}, {11084, 0.05, 1}}}
DE: {2, 1, 31, 35, {{11134, 0.75, 1, 2}, {11083, 0.2, 2, 5}, {11138, 0.05, 1}}}
DE: {2, 1, 36, 40, {{11135, 0.75, 1, 2}, {11137, 0.2, 1, 2}, {11139, 0.05, 1}}}
DE: {2, 1, 41, 45, {{11174, 0.75, 1, 2}, {11137, 0.2, 2, 5}, {11177, 0.05, 1}}}
DE: {2, 1, 46, 50, {{11175, 0.75, 1, 2}, {11176, 0.2, 1, 2}, {11178, 0.05, 1}}}
DE: {2, 1, 51, 55, {{16202, 0.75, 1, 2}, {11176, 0.22, 2, 5}, {14343, 0.03, 1}}}
DE: {2, 1, 56, 60, {{16203, 0.75, 1, 2}, {16204, 0.22, 1, 2}, {14344, 0.03, 1}}}
DE: {2, 1, 61, 79, {{16203, 0.75, 2, 3}, {16204, 0.22, 2, 5}, {14344, 0.03, 1}}}
DE: {2, 1, 80, 99, {{22447, 0.75, 2, 3}, {22445, 0.22, 2, 3}, {22448, 0.03, 1}}}
DE: {2, 1, 100, 129, {{22446, 0.75, 1, 2}, {22445, 0.22, 2, 5}, {22449, 0.03, 1}}}
DE: {2, 1, 130, 151, {{34056, 0.75, 1, 2}, {34054, 0.22, 1, 4}, {34053, 0.03, 1}}}
DE: {2, 1, 152, 271, {{34055, 0.75, 1, 2}, {34054, 0.22, 4, 7}, {34052, 0.03, 1}}}
DE: {2, 1, 272, 288, {{52718, 0.75, 1, 3}, {52555, 0.25, 1, 3}}}
DE: {2, 1, 289, 305, {{52718, 0.75, 1, 4}, {52555, 0.25, 1, 4}}}
DE: {2, 1, 306, 317, {{52719, 0.75, 1, 2}, {52555, 0.25, 1, 5}}}
DE: {2, 1, 318, 333, {{52719, 0.75, 2, 4}, {52555, 0.25, 1, 7}}}
DE: {2, 1, 400, 428, {{74249, 0.75, 2, 7}, {74250, 0.25, 1, 2}}}
DE: {2, 1, 429, 437, {{74249, 0.75, 3, 5}, {74250, 0.25, 1, 2}}}
#
# Rares:
DE: {3, 2, 1, 25, {{10978, 1, 1}}}
DE: {3, 2, 26, 30, {{11084, 1, 1}}}
DE: {3, 2, 31, 35, {{11138, 1, 1}}}
DE: {3, 2, 36, 40, {{11139, 1, 1}}}
DE: {3, 2, 41, 45, {{11177, 1, 1}}}
DE: {3, 2, 46, 50, {{11178, 1, 1}}}
DE: {3, 2, 51, 55, {{14343, 1, 1}}}
DE: {3, 2, 56, 65, {{14344, 1, 1}}}
DE: {3, 2, 66, 99, {{22448, 1, 1}}}
DE: {3, 2, 100, 129, {{22449, 1, 1}}}
DE: {3, 2, 130, 164, {{34053, 1, 1}}}
DE: {3, 2, 165, 291, {{34052, 1, 1}}}
DE: {3, 2, 292, 324, {{52720, 1, 1}}}
DE: {3, 2, 325, 346, {{52721, 1, 1}}}
DE: {3, 2, 404, 424, {{74252, 1, 1, 1}}}
DE: {3, 2, 425, 467, {{74247, 1, 1, 2}}}
#
# Epics:
DE: {3, 3, 40, 45, {{11177, 1, 2, 4}}}
DE: {3, 3, 46, 50, {{11178, 1, 2, 4}}}
DE: {3, 3, 51, 55, {{14343, 1, 2, 4}}}
DE: {3, 3, 56, 60, {{20725, 1, 1}}}
DE: {3, 3, 61, 94, {{20725, 1, 1}}}
DE: {3, 3, 95, 104, {{22450, 1, 1}}}
DE: {3, 3, 105, 164, {{22450, 1, 1}}}
DE: {3, 3, 165, 200, {{34057, 1, 1}}}
DE: {3, 3, 201, 299, {{34057, 1, 1}}}
DE: {3, 3, 300, 416, {{52722, 1, 1}}}
DE: {3, 3, 420, 496, {{74248, 1, 1}}}
]=]

local ENCHANTING_ICON = "Interface\\Icons\\Trade_Engraving"

local function _GetPlayerSkill(self)
	local rtn
	local name
	local prof1, prof2 = GetProfessions()
	local icon, skillLevel
	if (prof1) then
		name, icon, skillLevel = GetProfessionInfo(prof1)
		if (ENCHANTING_ICON == icon) then
			rtn = skillLevel
		end
	end
	if (not rtn and prof2) then
		name, icon, skillLevel = GetProfessionInfo(prof2)
		if (ENCHANTING_ICON == icon) then
			rtn = skillLevel
		end
	end
	return rtn, name
end

local function _GetRequiredSkill(self, itemLevel, itemRarity)
	local table
	if (itemRarity >= 2 and itemRarity <= 4) then
		table = self.requiredSkills[itemRarity - 1]
	end
	if (table) then
		local n = #table
		for i=1,n do
			local entry = table[i]
			if (itemLevel < entry[2]) then
				return entry[1]
			end
		end
	end
	return nil
end

local function _GetDisenchantMessage(entry)
	local texture = "|T"..GetItemIcon(entry[INDEX_ITEM_CODE])..":14|t"
	local name = GetItemInfo(entry[INDEX_ITEM_CODE]) or ""
	local minItems = entry[INDEX_MIN_ITEMS]
	local maxItems = entry[INDEX_MAX_ITEMS]
	if (maxItems and maxItems > minItems) then
		return ((minItems + maxItems) / 2.0).." "..texture.." "..name.." "..(entry[INDEX_PROXIMITY] * 100).."%"
	end
	return minItems.." "..texture.." "..name.." "..(entry[INDEX_PROXIMITY] * 100).."%"
end

local function _GetDisenchantEntry(self, itemLink)
	local itemName, _, quality, itemLevel, _, itemType = GetItemInfo(itemLink)
	if (itemName and (itemType == self.armor or itemType == self.weapons) and quality > 1 and quality < 5) then
		if (itemType == self.armor) then
			itemType = 1
		else
			itemType = 2
		end
		log:Debug("_GetDisenchantEntry index [%s]", (quality - 2) * 2 + itemType) 
		local entries = self.disenchantTable[(quality - 2) * 2 + itemType]
		if (entries) then
			local n = #entries
			for i=1,n do
				local entry = entries[i]
				if (itemLevel <= entry[INDEX_MAX_ITEM_LEVEL]) then
					log:Debug("_GetDisenchantEntry entry [%s] itemLevel [%s] quality [%s]", entry[INDEX_QUALITY], itemLevel, quality)
					return entry, itemLevel, quality
				end
			end
		end
	end 
end

local function _GetExpectations(entry)
	assert(entry)
	local expectation = 0
	local lowerExpectation = 0
	-- TODO switch to itemId in backend
	local ilink = vendor.Items:GetItemLink(entry[INDEX_ITEM_CODE]) 				
	local _, avgBuyout, _, lowerBuyout = vendor.Gatherer:GetCurrentAuctionInfo(ilink)
	if (not avgBuyout or avgBuyout == 0) then
		avgBuyout = select(2, vendor.Gatherer:GetAuctionInfo(ilink))
	end
	if (avgBuyout and avgBuyout > 0) then
		local q = entry[INDEX_MIN_ITEMS]
		if (entry[INDEX_ESTIMATED]) then
			q = entry[INDEX_ESTIMATED]
		elseif (entry[INDEX_MAX_ITEMS]) then
			q = (entry[INDEX_MIN_ITEMS] + entry[INDEX_MAX_ITEMS]) / 2
		end
		expectation = expectation + (avgBuyout * q * entry[INDEX_PROXIMITY])
		if (lowerBuyout and lowerBuyout > 0 and lowerExpectation) then
			lowerExpectation = lowerExpectation + (lowerBuyout * q * entry[INDEX_PROXIMITY])
		else
			lowerExpectation = nil
		end
	end
	log:Debug("_GetExpectations entry [%s] expectation [%s] lowerExpectation [%s]", entry[INDEX_ITEM_CODE], expectation, lowerExpectation)
	return expectation, lowerExpectation
end

local function _DataError(line, column)
	vendor.Vendor:Error(string.format("Illegal line: %s [%s]", column, line))
end

-- Initializes the excludes table.
local function _InitExcludes(self, lines)
	self.excludes = {}
	local prefix = "EXCLUDE:"
	for i=1,#lines do
		local line = lines[i]
		if (vendor.strStartsWith(line,prefix)) then
			local data = string.sub(line, string.len(prefix) + 1)
			for itemCode in data:gmatch("%w+") do
				self.excludes[tonumber(itemCode)] = true 
			end
		end
	end
end

local function _InitRequiredSkills(self, lines)
	self.requiredSkills = {{},{},{}}
	local prefix = "SKILL:"
	for i=1,#lines do
		local line = lines[i]
		if (vendor.strStartsWith(line,prefix)) then
			local data = string.sub(line, string.len(prefix) + 1)
			local quality
			for entry in data:gmatch("[%w<]+") do
				if (quality == nil) then
					if (entry ~= "1" and entry ~= "2" and entry ~= "3") then
						_DataError(line, i)
						return
					end
					quality = tonumber(entry)
				else
					local left, right = entry:match("([^<]*)<([^<]*)")
					if (left == nil or right == nil) then
						_DataError(line, i)
						return
					end
					local skill = tonumber(left)
					local level = tonumber(right)
					if (skill == nil or level == nil) then
						_DataError(line, i)
						return
					end
					tinsert(self.requiredSkills[quality], {skill, level})
				end
			end
		end
	end
	
	for quality=1,3 do
		sort(self.requiredSkills[quality], function(a, b)
			return a[1] < b[1]
		end)	
	end
end

local function _InitDisenchantTable(self, lines)
	self.disenchantTable = {
		[1] = {}, [2] = {}, 
		[3] = {}, [4] = {},
		[5] = {}, [6] = {}
	}
	local prefix = "DE:"
	for i=1,#lines do
		local line = lines[i]
		if (vendor.strStartsWith(line,prefix)) then
			local data = string.sub(line, string.len(prefix) + 1)
			local entryFunc = loadstring("return "..data)
			if (not entryFunc) then
				_DataError(line, i)
				return
			end
			local entryTable = entryFunc()
			if (not entryTable) then
				_DataError(line, i)
				return
			end
			-- {ITEM_TYPE, QUALITY, MIN_ITEM_LEVEL, MAX_ITEM_LEVEL, {{ITEM_CODE, PROXIMITY, MIN_ITEMS, MAX_ITEMS}, ... }
			local itemType = tonumber(entryTable[INDEX_ITEM_TYPE])
			local quality = tonumber(entryTable[INDEX_QUALITY])
			local minItemLevel = tonumber(entryTable[INDEX_MIN_ITEM_LEVEL])
			local maxItemLevel = tonumber(entryTable[INDEX_MAX_ITEM_LEVEL])
			if (not itemType or itemType < 1 or itemType > 3 or not quality or quality < 1 or quality > 3 or not minItemLevel or minItemLevel < 0 or not maxItemLevel or maxItemLevel < minItemLevel) then
				_DataError(line, i)
				return
			end
			-- check item syntax
			local items = entryTable[INDEX_ITEMS]
			if (not type(items) == "table") then
				_DataError(line, i)
				return
			end
			for i=1,#items do
				local entry = items[i]
				local itemCode = tonumber(entry[INDEX_ITEM_CODE])
				local proximity = tonumber(entry[INDEX_PROXIMITY])
				local minItems = tonumber(entry[INDEX_MIN_ITEMS])
				local maxItems = tonumber(entry[INDEX_MAX_ITEMS])
				local estimated = tonumber(entry[INDEX_ESTIMATED])
				if (not itemCode or itemCode < 0 or not proximity or proximity < 0 or proximity > 1.001 or not minItems or minItems < 0 or (maxItems and maxItems < minItems) or (estimated and estimated < 0)) then
					_DataError(line, i)
					return
				end
			end
			-- store entry
			if (itemType == 3) then
				tinsert(self.disenchantTable[(quality - 1) * 2 + 1], entryTable)				
				tinsert(self.disenchantTable[(quality - 1) * 2 + 2], entryTable)
			else
				tinsert(self.disenchantTable[(quality - 1) * 2 + itemType], entryTable)
			end
		end
	end
	
	-- sort disenchant entries according to theire min level
	for itemType=1,2 do
		for quality=1,3 do
			sort(self.disenchantTable[(quality - 1) * 2 + itemType], function(a, b)
				return a[INDEX_MIN_ITEM_LEVEL] < b[INDEX_MIN_ITEM_LEVEL]
			end)
		end	
	end
end

function vendor.Disenchant:OnInitialize()
	self.db = vendor.Vendor.db:RegisterNamespace("Disenchant", {
		profile = {
    		data = DEFAULT_DATA
    	}
	})
end

function vendor.Disenchant:OnEnable()
	-- get localized versions of Armor and Weapon
	--local classes = {GetAuctionItemClasses()}
	self.weapons = LE_ITEM_CLASS_WEAPON
	self.armor = LE_ITEM_CLASS_ARMOR

--	log:Debug(DEFAULT_DATA)
--	for entry in DEFAULT_DATA:gmatch("[^\n]+") do
--		log:Debug("%s", entry)
--	end
		
	self:UpdateData()
		
	--vendor.TooltipHook:Enable()
	--vendor.TooltipHook:AddAppender(self, 100)
end

-- Parses the data found in the profile.
function vendor.Disenchant:UpdateData()
	local lines = vendor.strSplit(self.db.profile.data, "([^\n]+)")
	
--	for i=1,#lines do
--		log:Debug("[%s] %s", i, lines[i])
--	end
	_InitExcludes(self, lines)
	_InitRequiredSkills(self, lines)
	_InitDisenchantTable(self, lines)
end

-- Resets the database to it's default state.
function vendor.Disenchant:ResetData()
	self.db.profile.data = DEFAULT_DATA
	self:UpdateData()
end

--function vendor.Disenchant:AppendToGameTooltip(tooltip, itemLink, itemName, count)
--
--	if (not vendor.TooltipHook.db.profile.showDisenchant) then
--		return
--	end
--
--	local id = vendor.Items:GetItemLinkId(itemLink)
--	if (id and self.excludes[tonumber(id)]) then
--		return
--	end
--
--	local entry, itemLevel, itemRarity = _GetDisenchantEntry(self, itemLink)
--	if (entry) then
--		local items = entry[INDEX_ITEMS]
--		for k,v in pairs(items) do
--			local msg = _GetDisenchantMessage(v)
--			tooltip:AddLine(msg);
--		end
--		local expectation = self:GetDisenchantValue(itemLink)
--		if (expectation > 0) then
--			local msg1 = L["Disenchant value"]
--			local msg2 = vendor.Format.FormatMoney(expectation, true)
--			tooltip:AddDoubleLine(msg1, msg2)
--		end
--		local requiredSkill = _GetRequiredSkill(self, itemLevel, itemRarity)
--		if (requiredSkill) then
--			local playerSkill, profName = _GetPlayerSkill(self)
--			if (playerSkill and profName and playerSkill < requiredSkill) then
--				tooltip:AddLine("|cffff0000"..ITEM_DISENCHANT_MIN_SKILL:format(profName, requiredSkill).."|r")
--			end
--		end
--	end
--end

function vendor.Disenchant:GetDisenchantValue(itemLink)
	local id = vendor.Items:GetItemLinkId(itemLink)
	if (id and self.excludes[tonumber(id)]) then
		return 0
	end
	
	local rtn = 0
	local entry, itemLevel, itemRarity = _GetDisenchantEntry(self, itemLink)
	if (entry) then
		local expectation = 0
		local lowerExpectation = 0
		local items = entry[INDEX_ITEMS]
		for k,v in pairs(items) do
			local e, l = _GetExpectations(v)
			if (e) then
				expectation = expectation + e
			end
			if (l) then
				lowerExpectation = lowerExpectation + l
			end	
		end
		if (lowerExpectation and lowerExpectation > 0) then
			rtn = lowerExpectation
		else
			rtn = expectation
		end
	end
	log:Debug("GetDisenchantValue rtn [%s]", rtn)
	return rtn
end