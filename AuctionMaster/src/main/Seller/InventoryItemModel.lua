--[[
	Copyright (C) Ordo Lunaris (Blackhand)
	
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
	ItemModel implementation for selling items from inventory.
--]]
vendor.InventoryItemModel = {}
vendor.InventoryItemModel.prototype = {}
vendor.InventoryItemModel.metatable = {__index = vendor.InventoryItemModel.prototype}

local L = vendor.Locale.GetInstance()
local AceEvent = LibStub("AceEvent-3.0")

-- the identifiers of the supported columns
vendor.InventoryItemModel.TEXTURE = 1
vendor.InventoryItemModel.NAME = 2
vendor.InventoryItemModel.COUNT = 3
vendor.InventoryItemModel.BID = 4
vendor.InventoryItemModel.BUYOUT = 5
vendor.InventoryItemModel.CURRENT_AUCTIONS = 6

local log = vendor.Debug:new("InventoryItemModel")

--[[
	Flattens the given line of data.
--]]
local function _Unpack(line)
	return line.itemLinkKey, line.itemLink, line.name, line.texture, line.count, line.bid, line.buyout
end

--[[
	Create a hidden tooltip
--]]
local function _CreateTooltip(self)
    self.tooltip = CreateFrame("GameTooltip", "CanAuctionTooltip")
    self.tooltip:SetOwner(WorldFrame, "ANCHOR_NONE")
    self.numLines = 60
    self.cells = {}
    for l = 1, self.numLines do
    	self.cells[l] = {}
    	self.cells[l][1] = self.tooltip:CreateFontString("$parentTextLeft"..l, nil, "GameTooltipText") 
    	self.cells[l][2] = self.tooltip:CreateFontString("$parentTextRight"..l, nil, "GameTooltipText")
    	self.tooltip:AddFontStrings(self.cells[l][1], self.cells[l][2])
    end
end

--[[
	Parse the content of the tooltip.
--]]
local function _ScanTooltip(self)
	self.tooltip.isNotAuctionable = false
	for i=1, self.tooltip:NumLines(), 1 do
		local txt = getglobal("CanAuctionTooltipTextLeft"..i):GetText()
		if (txt) then
			if (txt == ITEM_SOULBOUND or txt == ITEM_BIND_QUEST or txt == ITEM_ACCOUNTBOUND) then
				self.tooltip.isNotAuctionable = true
			end
		end
	end	
end

-- the several sort functions
local SORT_FUNCS = {
	[vendor.InventoryItemModel.COUNT] = {
		[true] = function(a, b) 
			return a.count < b.count
		end,
		[false] = function(a, b)
			return a.count > b.count
		end
	},
	[vendor.InventoryItemModel.CURRENT_AUCTIONS] = {
		[true] = function(a, b) 
			return (a.currentAuctions or -1) < (b.currentAuctions or -1)
		end,
		[false] = function(a, b)
			return (a.currentAuctions - 1) > (b.currentAuctions or -1)
		end
	},
	[vendor.InventoryItemModel.NAME] = {
		[true] = function(a, b)
				log:Debug("a [%s] < b [%s] rtn [%s]", a.name, b.name, a.name < b.name)
				return a.name < b.name
			end,
		[false] = function(a, b)
			log:Debug("a [%s] > b [%s] rtn [%s]", a.name, b.name, a.name > b.name)
			return a.name > b.name
		end
	},
	[vendor.InventoryItemModel.BID] = {
		[true] = function(a, b)
				return (a.bid or 0) < (b.bid or 0)
			end,
		[false] = function(a, b)
				return (a.bid or 0) > (b.bid or 0)
			end
	},
	[vendor.InventoryItemModel.BUYOUT] = {
		[true] = function(a, b)
				return (a.buyout or 0) < (b.buyout or 0)
			end,
		[false] = function(a, b)
					return (a.buyout or 0) > (b.buyout or 0)
				end
	},
	[vendor.InventoryItemModel.TEXTURE] = {
		[true] = function(a, b) 
			return a.rarity < b.rarity;
		end,
		[false] = function(a, b)
			return a.rarity > b.rarity;
		end
	}
	
};

--[[
	Checks whether the list has to be sorted and does it in case.
--]]
local function _EnsureSorting(self)
	if (not self.sorted) then
		table.sort(self.index, self.sortFunc)
		self.sorted = true
		self.updateCount = self.updateCount + 1
	end
end

--[[
	Inits the table of descriptors.
--]]
local function _InitDescriptors(self)
	self.descriptors = {
		[vendor.InventoryItemModel.TEXTURE] = {type = "texture", title = L["Texture"], align = "LEFT", order = 1};
		[vendor.InventoryItemModel.NAME] = {type = "text", align = "LEFT", weight = 35, minWidth = 60, sortable = true, title = L["Name"], order = 2};
		[vendor.InventoryItemModel.COUNT] = {type = "number", align = "CENTER", weight = 10, minWidth = 20, sortable = true, title = L["Itms."], order = 3};
		[vendor.InventoryItemModel.CURRENT_AUCTIONS] = {type = "number", align = "CENTER", weight = 10, minWidth = 20, sortable = true, title = L["Aucts."], order = 4};
		[vendor.InventoryItemModel.BID] = {type = "text", align = "RIGHT", weight = 20, minWidth = 70, sortable = true, title = L["Bid"], order = 5};
		[vendor.InventoryItemModel.BUYOUT] = {type = "text", align = "RIGHT", weight = 20, minWidth = 70, sortable = true, title = L["Buyout"], order = 6};
	}
end

--[[
	Update all auction statistics, if itemLinkKey is nil. Otherwise only
	corresponding items will be updated.
--]]
local function _UpdateAuctionStatistics(self, _, itemLinkKey)
	if (itemLinkKey and not self.itemLinkKeys[itemLinkKeys]) then
		return
	end
	log:Debug("_UpdateAuctionStatistics a: %s self: %s itemLinkKey: %s", a, self, itemLinkKey)
	local neutral = vendor.AuctionHouse:IsNeutral()
	for _,info in pairs(self.index) do
		if (not itemLinkKey or itemLinkKey == info.itemLinkKey) then
			local avgMinBid, avgBuyout, minMinBid, minBuyout, numAuctions = vendor.Statistic:GetCurrentAuctionInfo(info.itemLink, neutral)
		 	info.bid = avgMinBid
		 	info.buyout = avgBuyout
		 	info.currentAuctions = numAuctions
		 	self.sorted = false
		 	self.updateCount = self.updateCount + 1
		 end
	end 
	
	-- notify listeners
	for _,listener in pairs(self.updateListeners) do
		listener.func(listener.arg)
	end
end

--[[
	Updates the list of items in inventory.
--]]
local function _Update(self)

	if (self.itemTable and not self.itemTable:IsVisible()) then
		return
	end
	
	log:Debug("Update enter")
	-- we need it only, if auction house is open
	if (not vendor.AuctionHouse:IsOpen()) then
		return
	end
	
	-- aggregate all items
	log:Debug("aggregate items")
	local map = {}
	for bag = 0, 4 do
		for slot = 1, GetContainerNumSlots(bag) do
			local itemLink = GetContainerItemLink(bag, slot);
			if (itemLink) then
				local name, _, rarity, _, _, _, _, _, _, texture = GetItemInfo(itemLink);
				if (name) then
			 		local key = vendor.Items:GetItemLinkKey(itemLink);
					local _, count = GetContainerItemInfo(bag, slot);
					-- check whether it's already in inventory
					local info = map[key];
					if (info) then
						-- just increase count
						info.count = info.count + count;
					else
						map[key] = {itemLinkKey = key, itemLink = itemLink, name = name, texture = texture, count = count, rarity = rarity, bag = bag, slot = slot} 
					end
				end
			end
		end
	end
	
	-- insert the aggregated items into the index
	log:Debug("insert aggregated")
	self.index = wipe(self.index)
	self.itemLinkKeys = wipe(self.itemLinkKeys)
	local index = self.index
	local itemLinkKeys = self.itemLinkKeys
	for idx,value in pairs(map) do
		-- exclude soulbound and quest items
		if (not self:IsNotAuctionable(value.itemLinkKey, value.bag, value.slot)) then
			local colorizedName = vendor.Format.ColorizeQuality(value.name, value.rarity)
	 		table.insert(index, {itemLinkKey = value.itemLinkKey, itemLink = value.itemLink, name = value.name, colorizedName = colorizedName, texture = value.texture, count = value.count, rarity = value.rarity})
	 		itemLinkKeys[value.itemLinkKey] = true
	 	end
	end
	_UpdateAuctionStatistics(self) 
	self.sorted = false
	self.updateCount = self.updateCount + 1
	log:Debug("Finished Inventory Bag Update with size: %d", #index)
end

--[[
	Creates a new instance.
--]]
function vendor.InventoryItemModel:new()
	local instance = setmetatable({}, self.metatable)
	instance.selectedIndex = {}
	instance.index = {}
	instance.cache = {}
	instance.itemLinkKeys = {}
	instance.updateCount = 0
	instance:Update()
	_InitDescriptors(instance)
	instance:Sort(vendor.InventoryItemModel.BUYOUT, true)
	AceEvent:RegisterEvent("BAG_UPDATE", _Update, instance)
	AceEvent:RegisterMessage("AUCTION_STATISTIC_UPDATE", _UpdateAuctionStatistics, instance)
	instance.updateListeners = {}
	return instance
end

function vendor.InventoryItemModel.prototype:SetItemTable(itemTable)
	self.itemTable = itemTable
end

--[[
	ItemModel function for returning the desired descriptor.
--]]
function vendor.InventoryItemModel.prototype:GetColumnDescriptor(id)
	return self.descriptors[id]
end

--[[
	Returns the number of items available.
--]]
function vendor.InventoryItemModel.prototype:Size()
    log:Debug("Size: %d", #self.index)
	return #self.index
end

--[[
	Returns the Inventory data for the given row as
	itemLinkKey, itemLink, name, texture, count, bid, buyout
--]]
function vendor.InventoryItemModel.prototype:Get(row)
	_EnsureSorting(self)
	return _Unpack(self.index[row])
end

function vendor.InventoryItemModel.prototype:GetItemLink(row)
	_EnsureSorting(self)
	return self.index[row].itemLink
end

--[[
	Returns the value(s) for the given row and column id.
--]]
function vendor.InventoryItemModel.prototype:GetValues(row, id)
	_EnsureSorting(self)
	local index = self.index
	if (id == vendor.InventoryItemModel.TEXTURE) then
		return index[row].texture, index[row].itemLink, index[row].count
	elseif (id == vendor.InventoryItemModel.NAME) then
		return index[row].colorizedName
	elseif (id == vendor.InventoryItemModel.COUNT) then
		return index[row].count
	elseif (id == vendor.InventoryItemModel.CURRENT_AUCTIONS) then
		return index[row].currentAuctions
	elseif (id == vendor.InventoryItemModel.BID) then
		local bid = index[row].bid or 0
		local count = index[row].count
		local msg
		if (count > 1 and bid > 0) then
			msg = vendor.Format.FormatMoney(bid, bid * count, true)
		else
			msg = vendor.Format.FormatMoney(bid, true)
		end
		return msg
	elseif (id == vendor.InventoryItemModel.BUYOUT) then
		local buyout = index[row].buyout or 0
		local count = index[row].count
		local msg
		if (count > 1 and buyout > 0) then
			msg = vendor.Format.FormatMoneyValues(buyout, buyout * count, true)
		else
			msg = vendor.Format.FormatMoney(buyout, true)
		end
		return msg
	else
		error("unknown id: "..(id or "NA"));
	end
	return nil
end

--[[
	Sorts according to the given column.
--]]
function vendor.InventoryItemModel.prototype:Sort(id, ascending)
	vendor.Vendor:Debug("Sort id: %d ascending: %s", id, ascending)
	local sortable = self.descriptors[id].sortable
	if (sortable) then
		self.sortFunc = SORT_FUNCS[id][ascending]
		self.sorted = false
		self.sortId = id
		self.ascending = ascending
		_EnsureSorting(self)
	end
end

--[[
	Toggles the sort state for the given type. If it's currently not
	the sorting criteria, then it will be activated and set to ascending.
--]]
function vendor.InventoryItemModel.prototype:ToggleSort(id)
	vendor.Vendor:Debug("ToggleSort id: %d", id)
	if (id == self.sortId) then
		self:Sort(id, not self.ascending)
	else
		self:Sort(id, true)
	end
end

--[[
	Returns the sorted id and whether it's ascending.
--]]
function vendor.InventoryItemModel.prototype:GetSortInfo()
	return self.sortId, self.ascending
end

--[[
	Selects the given item.
--]]
function vendor.InventoryItemModel.prototype:SelectItem(row, isSelected)
	self.index[row].selected = isSelected
	self.updateCount = self.updateCount + 1
end

--[[
	Returns whether the given item was selected.
--]]
function vendor.InventoryItemModel.prototype:IsSelected(row)
	return self.index[row].selected
end

--[[
	Returns the map with the indices of the selected items.
--]]
function vendor.InventoryItemModel.prototype:GetSelectedItems()
	_EnsureSorting(self)
	if (self.updateCount ~= self.selectedUpdateCount) then
    	wipe(self.selectedIndex)
    	for i=1,#self.index do
    		if (self.index[i].selected) then
    			table.insert(self.selectedIndex, i)
    		end
    	end
    	self.selectedUpdateCount = self.updateCount
    end
	return self.selectedIndex
end

--[[
	Updates the list of items in inventory.
--]]
function vendor.InventoryItemModel.prototype:Update()
	_Update(self)
end

--[[
	Returns whether the given item can be auctioned
--]]
function vendor.InventoryItemModel.prototype:IsNotAuctionable(itemLinkKey, bag, slot)
	local rtn = self.cache[itemLinkKey]
	if (rtn == nil) then
		_CreateTooltip(self)
		self.tooltip:ClearLines()
    	self.tooltip:SetBagItem(bag, slot)
		_ScanTooltip(self)
		rtn = self.tooltip.isNotAuctionable
		self.cache[itemLinkKey] = rtn	
	end
	return rtn	
end

--[[
	Registers a function that will be called, if the model has been updated.
--]]
function vendor.InventoryItemModel.prototype:RegisterUpdateListener(func, arg)
	table.insert(self.updateListeners, {func = func, arg = arg})
end