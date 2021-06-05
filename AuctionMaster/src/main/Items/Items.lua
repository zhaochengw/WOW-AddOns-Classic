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

--[[
	Per server database with all information known about the items.
	
	The correspondinmg itemInfo struct contains the following members:
	avgMinBid, avgBuyout, minBid, buyout, stackSize, duration, priceModel, avgBidData, avgBuyoutData
--]]
vendor.Items = vendor.Vendor:NewModule("Items");
local L = vendor.Locale.GetInstance()
local log = vendor.Debug:new("Items")
local ITEMS_VERSION = 6

local function _EncodeHelper(ch)
	if (ch == "/") then
		return "/1"
	elseif (ch == ":") then
		return "/2"
	end
end

local function _DecodeHelper(ch)
	if (ch == "/1") then
		return "/"
	elseif (ch == "/2") then
		return ":"
	end
end

--[[
	Encodes the given string and espaces forbidden chars.
--]]
local function _Encode(str)
	return str:gsub("[/:]", _EncodeHelper)
end

--[[
	Decodes the previously encoded string.
--]]
local function _Decode(str)
	return str:gsub("/%d", _DecodeHelper)
end

--[[
	Migrates the database.
--]]
local function _MigrateDb(self)
	-- TODO migrate realm to factionrealm, server to realm
	local oldDb = vendor.Vendor.oldDb:AcquireDBNamespace("Items")
	if (not self.db.factionrealm.version or self.db.factionrealm.version < 4) then
		-- migrate old "realm" to "factionrealm"
		self.db.factionrealm.index = oldDb.realm.index or {}
		oldDb.realm.index = nil
	end	
	if (not self.db.realm.version or self.db.realm.version < 4) then
		-- migrate old "server" to "realm"
		self.db.realm.index = oldDb.server.index or {}
		oldDb.server.index = nil
	end	
	if (not self.db.factionrealm.version or self.db.factionrealm.version < 6) then
		-- remove the first two numbers for all entries (avgBid and avgBuyout)
		local index = self.db.factionrealm.index
		for k,v in pairs(index) do
			local _, _, a, b, c, d, e, f, g = vendor.Strings.StrSplit(":", v)
			index[k] = strjoin(":",	a, b, c, d, e, f or "", g or "")
		end
	end
	if (not self.db.realm.version or self.db.realm.version < 6) then
		-- remove the first two numbers for all entries (avgBid and avgBuyout)
		local index = self.db.realm.index
		for k,v in pairs(index) do
			local _, _, a, b, c, d, e, f, g = vendor.Strings.StrSplit(":", v)
			index[k] = strjoin(":",	a, b, c, d, e, f or "", g or "")
		end
	end
	self.db.factionrealm.version = ITEMS_VERSION
	self.db.realm.version = ITEMS_VERSION
end

--[[
	Initializes the module.
--]]
function vendor.Items:OnInitialize()
	self.db = vendor.Vendor.db:RegisterNamespace("Items", {
		factionrealm = {
			index = {}
		},
		realm = {
			index = {}
		}
	})
	_MigrateDb(self)
end
	
--[[
	Returns the no. of items.
	@param isNeutral decides whether to access the neutral database.
--]]
function vendor.Items:Size(isNeutral)
	if (isNeutral) then
		return table.getn(self.db.realm.index);
	end
	return table.getn(self.db.factionrealm.index);
end

-- returns a printable version of the itemLink
function vendor.Items:PrintItemLink(itemLink)
	if (not itemLink) then
		return "nil"
	end
	return gsub(itemLink, "\124", "\124\124")
end

-- returns name, texture, stackCount for the given itemLink, will also function for battlepets 
function vendor.Items:GetItemData(itemLink)
	log:Debug("GetItemData [%s]", self:PrintItemLink(itemLink))
	if (not itemLink) then return nil end
	local battlePetString = string.match(itemLink, "battlepet[%-?%d:]+")
	if (battlePetString) then
		local _, id = strsplit(":", battlePetString)
		local name, icon = C_PetJournal.GetPetInfoBySpeciesID(tonumber(id))
		return name, icon, 1
	end
 	local name, _, _, _, _, _, _, stackCount, _, texture = GetItemInfo(itemLink)
 	return name, texture, stackCount
end

function vendor.Items:IsBattlePetLink(itemLink)
	return string.match(itemLink, "Hbattlepet:") ~= nil
end

-- Returns name, speciesId, level, breedQuality, maxHealth, power, speed
function vendor.Items:GetBattlePetStats(itemLink)
	if (itemLink and strmatch(itemLink, "battlepet:")) then
		local _, speciesId, level, breedQuality, maxHealth, power, speed, battlePetId = strsplit(":", itemLink)
		local name = string.gsub(string.gsub(itemLink, "^(.*)%[", ""), "%](.*)$", "")
		return name, tonumber(speciesId), tonumber(level), tonumber(breedQuality), tonumber(maxHealth), tonumber(power), tonumber(speed)
	end
end

--[[
	Takes blizzard's item link and returns a shorter, normalized one.
--]]
function vendor.Items:GetItemLinkKey(itemDesc)
	log:Debug("itemDesc [%s]", vendor.Items:PrintItemLink(itemDesc))
	local key
	local itemString = string.match(itemDesc, "item[%-?%d:]+")
	if (not itemString) then
	  	local battlePetString = string.match(itemDesc, "battlepet[%-?%d:]+")
		if (battlePetString) then
			local _, speciesId, level, breedQuality, maxHealth, power, speed = strsplit(":", battlePetString)
			-- FIXME we doesn't abbreviate here, because we have to reconstruct it later
--			level = tonumber(level or "0")
--			local levelType = 0
--			if (level >= 25) then
--				levelType = 4
--			elseif (level >= 20) then
--				levelType = 3
--			elseif (level >= 15) then
--				levelType = 2
--			elseif (level >= 10) then
--				levelType = 1
--			end
			log:Debug("speciesId [%s] level [%s] quality [%s]", speciesId, level, breedQuality)
			key = "bp:"..strjoin(":", speciesId, level, breedQuality, maxHealth, power, speed)
		end
	else
		local _, itemId, enchantId, jewelId1, jewelId2, jewelId3, jewelId4, suffixId, uniqueId = strsplit(":", itemString)
		key = strjoin(":", itemId, jewelId1, jewelId2, jewelId3, jewelId4, suffixId);
	end
	log:Debug("GetItemLinkKey rtn [%s]", key)
	return key		
end

--[[
	Extracts the first id of the given item link.
--]]
function vendor.Items:GetItemLinkId(itemDesc)
	local itemLinkKey = self:GetItemLinkKey(itemDesc)
	return select(1, strsplit(":", itemLinkKey))
end

--[[
	Takes the short, normailized item key or id and returns a blizzard compatible item link.
--]]
function vendor.Items:GetItemLink(itemLinkKey)
	assert(itemLinkKey)
	log:Debug("GetItemLink [%s]", itemLinkKey)
	if (strbyte(itemLinkKey, 1) == 0x62) then -- 'b'
		log:Debug("PET")
		-- FIXME this is shit! The complete code has to be changed to remember the original itemLink!!!
		local _, speciesId, level, breedQuality, maxHealth, power, speed = strsplit(":", itemLinkKey)
		return "battlepet:"..strjoin(":", speciesId, level, breedQuality, maxHealth, power, speed)
	elseif (type(itemLinkKey) == "number") then
		return "item:"..tostring(itemLinkKey)..":0:0:0:0:0:0:0:0"
	end
	local itemId, jewelId1, jewelId2, jewelId3, jewelId4, suffixId = strsplit(":", itemLinkKey);
	return "item:"..strjoin(":", itemId, 0, jewelId1, jewelId2, jewelId3, jewelId4, suffixId, 0, 0);
end

function vendor.Items:MatchItemLinkKeys(a, b)
	if (strbyte(a, 1) == 0x62) then
		-- match speciesId (and quality?)
		local _, speciesId, level, breedQuality = strsplit(":", a)
		a = speciesId
	end
	if (strbyte(b, 1) == 0x62) then
		-- match speciesId (and quality?)
		local _, speciesId, level, breedQuality = strsplit(":", b)
		b = speciesId
	end
	return a == b
end
--[[
	Returns all information known about the given item. The normalized item link
	is retrieved via Items:GetItemLinkKey() and is not compatible with
	Blizzard's item link. nil will be returned, if nothing is known about the item.
	@param itemLinkKey the normailzed item link.
	@param itemInfo table that will be filled with the information found. 
	@param neutralAh determines whether to retrieve neutral item information (neutral auction houses)
	@return true, if the item was found
--]]
function vendor.Items:GetItemInfo(itemLinkKey, itemInfo, neutralAh)
	log:Debug("itemLinkKey [%s]", itemLinkKey)
--	if (itemLinkKey == "4575:0:0:0:0:1804") then
--		log:Debug("delete")
--		self.db.factionrealm.index[itemLinkKey] = nil
--	end
	local data = self.db.factionrealm.index[itemLinkKey]
	if (neutralAh) then
		data = self.db.realm.index[itemLinkKey]
	end
	if (data) then
		-- apparently "strsplit" has problems with zero bytes
		local minBid, buyout, stackSize, duration, priceModel,
		 	avgBidData, avgBuyoutData, amount = vendor.Strings.StrSplit(":", data)
		itemInfo.minBid = tonumber(minBid)
		itemInfo.buyout = tonumber(buyout)
		itemInfo.stackSize = tonumber(stackSize or 0)
		itemInfo.duration = tonumber(duration or 0)
		itemInfo.priceModel = tonumber(priceModel or 0)
		itemInfo.amount = tonumber(amount or 0)
		itemInfo.avgBidData = _Decode(avgBidData or "")
		itemInfo.avgBuyoutData = _Decode(avgBuyoutData or "")
		return true 
	end
	return false
end

--[[
	Updates all information known about the given item. The normalized item link
	is retrieved via Items:GetItemLinkKey() and is not compatible with
	Blizzard's item link. 
	@param itemLinkKey the normailzed item link.
	@param isNeutral determines whether to retrieve neutral item information (neutral auction houses)
--]]
function vendor.Items:PutItemInfo(itemLinkKey, isNeutral, itemInfo)
	local avgBidData = itemInfo.avgBidData or ""
	assert(avgBidData:len() == 0 or avgBidData:len() == 9)
	if (avgBidData:len()) then
		avgBidData = _Encode(avgBidData)
	end
	local avgBuyoutData = itemInfo.avgBuyoutData or ""
	assert(avgBuyoutData:len() == 0 or avgBuyoutData:len() == 9)
	if (avgBuyoutData) then
		avgBuyoutData = _Encode(avgBuyoutData)
	end
	assert(itemInfo.minBid)
	assert(itemInfo.buyout)
	assert(itemInfo.stackSize)
	assert(itemInfo.duration)
	assert(itemInfo.priceModel)
	local data = strjoin(":",  
		itemInfo.minBid, itemInfo.buyout, itemInfo.stackSize, itemInfo.duration, itemInfo.priceModel, 
		avgBidData or "", avgBuyoutData or "", itemInfo.amount or 0)
	if (isNeutral) then
		self.db.realm.index[itemLinkKey] = data;
	else
		self.db.factionrealm.index[itemLinkKey] = data;
	end
end

--[[
	Returns an empty item info struct.
--]]
function vendor.Items:InitItemInfo(itemInfo)
	itemInfo.minBid = 0
	itemInfo.buyout = 0
	itemInfo.stackSize = 0
	itemInfo.duration = 0
	itemInfo.priceModel = 0
	itemInfo.avgBidData = nil
	itemInfo.avgBuyoutData = nil
end

function vendor.Items:Reset()
	local itemInfo = {}
	for k, _ in pairs(self.db.factionrealm.index) do
		self:GetItemInfo(k, itemInfo)
		itemInfo.avgBidData = nil
		itemInfo.avgBuyoutData = nil
		self:PutItemInfo(k, false, itemInfo)
	end
end

function vendor.Items:GetAuctionItemClasses()
	return LE_ITEM_CLASS_CONSUMABLE,
			LE_ITEM_CLASS_CONTAINER,
			LE_ITEM_CLASS_WEAPON,
			LE_ITEM_CLASS_GEM,
			LE_ITEM_CLASS_ARMOR,
			LE_ITEM_CLASS_REAGENT,
			LE_ITEM_CLASS_PROJECTILE,
			LE_ITEM_CLASS_TRADEGOODS,
			LE_ITEM_CLASS_ITEM_ENHANCEMENT,
			LE_ITEM_CLASS_RECIPE,
			LE_ITEM_CLASS_QUIVER,
			LE_ITEM_CLASS_QUESTITEM,
			LE_ITEM_CLASS_KEY,
			LE_ITEM_CLASS_MISCELLANEOUS,
			LE_ITEM_CLASS_GLYPH,
			LE_ITEM_CLASS_BATTLEPET,
			LE_ITEM_CLASS_WOW_TOKEN
end