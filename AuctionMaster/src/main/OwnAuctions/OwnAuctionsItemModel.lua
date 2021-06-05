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
vendor.OwnAuctionsItemModel = {}
vendor.OwnAuctionsItemModel.prototype = {}
vendor.OwnAuctionsItemModel.metatable = {__index = vendor.OwnAuctionsItemModel.prototype}

local L = vendor.Locale.GetInstance()

-- the identifiers of the supported columns
vendor.OwnAuctionsItemModel.TEXTURE = 1
vendor.OwnAuctionsItemModel.NAME = 2
vendor.OwnAuctionsItemModel.COUNT = 3
vendor.OwnAuctionsItemModel.BID = 4
vendor.OwnAuctionsItemModel.BUYOUT = 5
vendor.OwnAuctionsItemModel.CURRENT_AUCTIONS = 6
vendor.OwnAuctionsItemModel.LOWER_BUYOUT = 7
vendor.OwnAuctionsItemModel.AVG_BUYOUT = 8
vendor.OwnAuctionsItemModel.UPPER_BUYOUT = 9
vendor.OwnAuctionsItemModel.TIME_LEFT = 10

local log = vendor.Debug:new("OwnAuctionsItemModel")

--[[
	Sorts according to a and b, taking into account heire names, if both are equal
	to avoid "hopping".
--]]
local function _SortHelper(a, b, na, nb)
	if (a == b) then
		return na < nb
	end
	return a < b
end

-- several sort functions
local SORT_FUNCS = {
	[vendor.OwnAuctionsItemModel.COUNT] = {
		[true] = function(a, b)
			return _SortHelper(a.count, b.count, a.name, b.name) 
		end,
		[false] = function(a, b)
			return _SortHelper(b.count, a.count, b.name, a.name)
		end
	},
	[vendor.OwnAuctionsItemModel.CURRENT_AUCTIONS] = {
		[true] = function(a, b)
			return _SortHelper((a.currentAuctions or -1), (b.currentAuctions or -1), a.name, b.name) 
		end,
		[false] = function(a, b)
			return _SortHelper((b.currentAuctions or -1), (a.currentAuctions or -1), b.name, a.name)
		end
	},
	[vendor.OwnAuctionsItemModel.NAME] = {
		[true] = function(a, b)
			return a.name < b.name
		end,
		[false] = function(a, b)
			return a.name > b.name
		end
	},
	[vendor.OwnAuctionsItemModel.BID] = {
		[true] = function(a, b)
			return _SortHelper((a.bid or 0) / a.count, (b.bid or 0) / b.count, a.name, b.name)
		end,
		[false] = function(a, b)
			return _SortHelper((b.bid or 0) / a.count, (a.bid or 0) / b.count, b.name, a.name)
		end
	},
	[vendor.OwnAuctionsItemModel.BUYOUT] = {
		[true] = function(a, b)
			return _SortHelper((a.buyout or 0) / a.count, (b.buyout or 0) / b.count, a.name, b.name)
		end,
		[false] = function(a, b)
			return _SortHelper((b.buyout or 0) / a.count, (a.buyout or 0) / b.count, b.name, a.name)
		end
	},
	[vendor.OwnAuctionsItemModel.LOWER_BUYOUT] = {
		[true] = function(a, b)
			return _SortHelper((a.lowerBuyout or 0), (b.lowerBuyout or 0), a.name, b.name)
		end,
		[false] = function(a, b)
			return _SortHelper((b.lowerBuyout or 0), (a.lowerBuyout or 0), b.name, a.name)
		end
	},
	[vendor.OwnAuctionsItemModel.AVG_BUYOUT] = {
		[true] = function(a, b)
			return _SortHelper((a.avgBuyout or 0), (b.avgBuyout or 0), a.name, b.name)
		end,
		[false] = function(a, b)
			return _SortHelper((b.avgBuyout or 0), (a.avgBuyout or 0), b.name, a.name)
		end
	},
	[vendor.OwnAuctionsItemModel.UPPER_BUYOUT] = {
		[true] = function(a, b)
			return _SortHelper((a.upperBuyout or 0), (b.upperBuyout or 0), a.name, b.name)
		end,
		[false] = function(a, b)
			return _SortHelper((b.upperBuyout or 0), (a.upperBuyout or 0), b.name, a.name)
		end
	},
	[vendor.OwnAuctionsItemModel.TEXTURE] = {
		[true] = function(a, b)
			return _SortHelper(a.rarity, b.rarity, a.name, b.name) 
		end,
		[false] = function(a, b)
			return _SortHelper(b.rarity, a.rarity, b.name, a.name)
		end
	},
	[vendor.OwnAuctionsItemModel.TIME_LEFT] = {
		[true] = function(a, b) 
			return _SortHelper(a.timeLeft, b.timeLeft, a.name, b.name)
		end,
		[false] = function(a, b)
			return _SortHelper(b.timeLeft, a.timeLeft, b.name, a.name)
		end
	}
};

local function _IsOutDated(info)
	local time = info.leastCurrentTime or 0
--	log:Debug("_IsOutDated name [%s] now [%s] time [%s] diff [%s]", info.name, GetTime(), time, GetTime() - time)
	return GetTime() - time > vendor.OwnAuctions.db.profile.outDatedTimeout
end

--[[
	Checks whether the list has to be sorted and does it in case.
--]]
local function _EnsureSorting(self)
	if (not self.sorted and self.index) then
		self.updateCount = self.updateCount + 1
		table.sort(self.index, self.sortFunc)
		self.sorted = true
	end
end

--[[
	Inits the table of descriptors.
--]]
local function _InitDescriptors(self)
	self.descriptors = {
		[vendor.OwnAuctionsItemModel.TEXTURE] = {type = "texture", title = L["Texture"], align = "LEFT", order = 1};
		[vendor.OwnAuctionsItemModel.NAME] = {type = "text", align = "LEFT", weight = 35, minWidth = 60, sortable = true, title = L["Name"], order = 2};
		[vendor.OwnAuctionsItemModel.COUNT] = {type = "number", align = "CENTER", weight = 10, minWidth = 20, sortable = true, title = L["Itms."], order = 3};
		[vendor.OwnAuctionsItemModel.CURRENT_AUCTIONS] = {type = "text", align = "CENTER", weight = 10, minWidth = 40, sortable = true, title = L["Aucts."], order = 7};
		[vendor.OwnAuctionsItemModel.TIME_LEFT] = {type = "text", align = "CENTER", weight = 10, minWidth = 40, sortable = true, title = L["Time Left"], order = 4};
		[vendor.OwnAuctionsItemModel.BID] = {type = "text", align = "RIGHT", weight = 20, minWidth = 70, sortable = true, title = L["Bid"], order = 5};
		[vendor.OwnAuctionsItemModel.BUYOUT] = {type = "text", align = "RIGHT", weight = 20, minWidth = 70, sortable = true, title = L["Buyout"], order = 6};
		[vendor.OwnAuctionsItemModel.LOWER_BUYOUT] = {type = "text", align = "RIGHT", weight = 20, minWidth = 70, sortable = true, title = L["Lower"], order = 7};
		[vendor.OwnAuctionsItemModel.AVG_BUYOUT] = {type = "text", align = "RIGHT", weight = 20, minWidth = 70, sortable = true, title = L["Average"], order = 8};
		[vendor.OwnAuctionsItemModel.UPPER_BUYOUT] = {type = "text", align = "RIGHT", weight = 20, minWidth = 70, sortable = true, title = L["Upper"], order = 9};
	}
end

local function _IsChange(a, b)
	local rtn = false
	if (not a) then
		rtn = b ~= nil
	elseif (not b) then
		rtn = a ~= nil
	else
		rtn = a ~= b
	end
	return rtn
end

--[[
	Update all auction statistics, if itemLinkKey is nil. Otherwise only
	corresponding items will be updated.
--]]
local function _UpdateAuctionStatistics(self, itemLinkKey, ignoreNotifer)
	log:Debug("_UpdateAuctionStatistics enter itemLinkKey [%s]", itemLinkKey)
	if (itemLinkKey and not self.itemLinkKeys[itemLinkKey]) then
		log:Debug("ignore itemLinkKey [%s]", itemLinkKey)
		return
	end
--	log:Debug("_UpdateAuctionStatistics self: %s itemLinkKey: %s", self, itemLinkKey)
	local neutralAh = vendor.AuctionHouse:IsNeutral()
	local hasChanged = false
	for _,info in pairs(self.index) do
		if (not itemLinkKey or itemLinkKey == info.itemLinkKey) then
			local avgBid, avgBuyout, lowerBid, lowerBuyout, upperBid, upperBuyout, numAuctions, 
				numBuyouts, leastCurrentTime =
				vendor.Gatherer:GetCurrentAuctionInfo(info.itemLink, neutralAh, true)
		 	if (not avgBuyout) then
		 		local _, oldAvgBuyout = vendor.Gatherer:GetAuctionInfo(info.itemLink, neutralAh, true)
		 		avgBuyout = oldAvgBuyout
		 	end
		 	
		 	hasChanged = hasChanged or _IsChange(info.avgBid, avgBid) or _IsChange(info.avgBuyout, avgBuyout) or
		 		_IsChange(info.lowerBuyout, lowerBuyout) or _IsChange(info.upperBuyout, upperBuyout) or
		 		_IsChange(info.avgBuyout, avgBuyout) or _IsChange(info.currentAuctions, numAuctions) or
		 		_IsChange(info.leastCurrentTime, leastCurrentTime)
		 		
		 	info.avgBid = avgBid
		 	info.avgBuyout = avgBuyout
		 	info.lowerBuyout = lowerBuyout
		 	info.upperBuyout = upperBuyout
		 	info.currentAuctions = numAuctions
		 	info.leastCurrentTime = leastCurrentTime
		 end
	end
	if (hasChanged) then
		log:Debug("has changed")
		self.sorted = false 
		if (not ignoreNotifer) then
    		for _,listener in pairs(self.updateListeners) do
    			listener.func(listener.arg)
    		end
    	end
	end
	log:Debug("_UpdateAuctionStatistics exit")
end

--[[
	Updates the list of own auctions.
--]]
local function _Update(self)
	-- we need it only, if auction house is open
	if (not vendor.AuctionHouse:IsOpen()) then
		log:Debug("ah is closed")
		return
	end
	GetOwnerAuctionItems(0)
	self.updateCount = self.updateCount + 1
	log:Debug("Update enter")
	self.index = wipe(self.index)
	self.itemLinkKeys = wipe(self.itemLinkKeys)
	for i=1,GetNumAuctionItems("owner") do
		local name, texture, count, quality, _, level, unknown, minBid, minIncrement, buyoutPrice, bidAmount, highBidder, bidderFullName, owner, ownerFullName, saleStatus = GetAuctionItemInfo("owner", i)
		local itemLink = GetAuctionItemLink("owner", i)
		if (name and itemLink) then
    		local itemLinkKey = vendor.Items:GetItemLinkKey(itemLink)
    		local timeLeft = GetAuctionItemTimeLeft("owner", i)
    		if (saleStatus == 1) then
    			-- we have no count and no minBid :-(
    			count = 1
    			minBid = 0
    		end
    		local info = {name = name, texture = texture, count = count or 1, minBid = minBid, 
    			buyout = buyoutPrice or 0, bidAmount = bidAmount or 0, 
    			bid = math.max(minBid, bidAmount or 0),
    			itemLink = itemLink, itemLinkKey = itemLinkKey, index = i, saleStatus = saleStatus,
    			highBidder = highBidder, minIncrement = minIncrement or 0, quality = quality, level = level,
    		    timeLeft = timeLeft, coloredName = vendor.Format.ColorizeQuality(name, quality)}
    		table.insert(self.index, info)
    		self.itemLinkKeys[itemLinkKey] = true
    	end
	end
	_UpdateAuctionStatistics(self, nil, true) 
	self.sorted = false
	_EnsureSorting(self)
	for _,listener in pairs(self.updateListeners) do
    	listener.func(listener.arg)
    end
	log:Debug("_Update leave size: %s", #self.index)
end

local function _GetMoney(money, count, outdated)
	local msg
	if (count > 1 and money > 0) then
		if (outdated) then
			return vendor.Format.FormatMoneyValuesGrayedOut(money, money * count, true)
		else
			return vendor.Format.FormatMoneyValues(money, money * count, true)
		end
	elseif (outdated) then
		return vendor.Format.FormatMoneyGrayedOut(money, true)
	else
		return vendor.Format.FormatMoney(money, true)
	end
end

--[[
	Creates a new instance.
--]]
function vendor.OwnAuctionsItemModel:new()
	log:Debug("new")
	local instance = setmetatable({}, self.metatable)
	instance.index = {}
	instance.itemLinkKeys = {}
	instance.selectedIndex = {}
	instance.updateCount = 0
	instance:Update()
	_InitDescriptors(instance)
	instance:Sort(vendor.OwnAuctionsItemModel.BUYOUT, true)
	instance.updateListeners = {}
	return instance
end


--[[
	ItemModel function for returning the desired descriptor.
--]]
function vendor.OwnAuctionsItemModel.prototype:GetColumnDescriptor(id)
	return self.descriptors[id]
end

--[[
	Returns the number of items available.
--]]
function vendor.OwnAuctionsItemModel.prototype:Size()
	return #self.index
end

function vendor.OwnAuctionsItemModel.prototype:GetItemLink(row)
	_EnsureSorting(self)
	local info = self.index[row]
	return info.itemLink
end

--[[
	Returns the value(s) for the given row and column id.
--]]
function vendor.OwnAuctionsItemModel.prototype:GetValues(row, id)
	_EnsureSorting(self)
	local rtn1, rtn2, rtn3
	local info = self.index[row]
	local outdated = _IsOutDated(info)
	if (id == vendor.OwnAuctionsItemModel.TEXTURE) then
		rtn1, rtn2, rtn3 = info.texture, info.itemLink, info.count
	elseif (id == vendor.OwnAuctionsItemModel.NAME) then
		if (info.saleStatus == 1) then
			if (info.highBidder) then
				rtn1 = L["%s - %s"]:format(info.coloredName, info.highBidder)
			else
				rtn1 = L["%s - Sold"]:format(info.coloredName)
			end
		elseif (info.bidAmount and info.bidAmount > 0 and info.saleStatus ~= 1 and info.highBidder) then
			rtn1 = L["%s - %s"]:format(info.coloredName, info.highBidder)
		else
			rtn1 = info.coloredName
		end
	elseif (id == vendor.OwnAuctionsItemModel.COUNT) then
		rtn1 = info.count
	elseif (id == vendor.OwnAuctionsItemModel.CURRENT_AUCTIONS) then
		if (outdated and info.currentAuctions) then
			rtn1 = vendor.OUTDATED_FONT_COLOR_CODE..info.currentAuctions..FONT_COLOR_CODE_CLOSE
		else
			rtn1 = info.currentAuctions
		end
	elseif (id == vendor.OwnAuctionsItemModel.BID) then
		rtn1 = _GetMoney(info.bid / info.count, info.count)
	elseif (id == vendor.OwnAuctionsItemModel.BUYOUT) then
		rtn1 = _GetMoney(info.buyout / info.count, info.count)
	elseif (id == vendor.OwnAuctionsItemModel.LOWER_BUYOUT) then
		rtn1 = _GetMoney(info.lowerBuyout or 0, info.count, outdated)
	elseif (id == vendor.OwnAuctionsItemModel.AVG_BUYOUT) then
		rtn1 = _GetMoney(info.avgBuyout or 0, info.count, outdated)
	elseif (id == vendor.OwnAuctionsItemModel.UPPER_BUYOUT) then
		rtn1 = _GetMoney(info.upperBuyout or 0, info.count, outdated)
	elseif (id == vendor.OwnAuctionsItemModel.TIME_LEFT) then
		if (info.saleStatus == 1 and info.timeLeft and info.timeLeft > 0) then
			rtn1 = AUCTION_ITEM_TIME_UNTIL_DELIVERY:format(SecondsToTime(info.timeLeft))
			rtn2 = AUCTION_ITEM_TIME_UNTIL_DELIVERY:format(SecondsToTime(info.timeLeft))
		elseif (info.timeLeft and info.timeLeft >= 1 and info.timeLeft <= 4) then
			rtn1 = AuctionFrame_GetTimeLeftText(info.timeLeft)
			rtn2 = AuctionFrame_GetTimeLeftTooltipText(info.timeLeft)
		else
			rtn1 = "???"
		end
	else
		error("unknown id: "..(id or "NA"));
	end
--	log:Debug("GetValues row [%s] id [%s] rtn1 [%s] rtn2 [%s] rtn3 [%s]", row, id, rtn1, rtn2, rtn3)
	return rtn1, rtn2, rtn3
end

function vendor.OwnAuctionsItemModel.prototype:GetHighlight(row)
	local highlight = nil
	_EnsureSorting(self)
	local info = self.index[row]
	if (info.saleStatus == 1) then
		highlight = self.soldHighlight
	elseif (info.lowerBuyout and info.lowerBuyout > 0 and info.lowerBuyout < (info.buyout / info.count)) then
		highlight = self.undercutHighlight
	elseif (not highlight and info.bidAmount and info.bidAmount > 0) then
		highlight = self.withBidHighlight
	end
	return highlight
end

--[[
	Returns the auction data for the given row as
	index, itemLinkKey, itemLink, name, texture, count, bid, buyout, lowerBuyout, saleStatus, 
	outdated, minBid, bidAmount, minIncrement, timeLeft, quality, level
--]]
function vendor.OwnAuctionsItemModel.prototype:Get(row)
	local info = self.index[row]
	return info.index, info.itemLinkKey, info.itemLink, info.name, info.texture, info.count, 
		info.bid, info.buyout, info.lowerBuyout, info.saleStatus, _IsOutDated(info), info.minBid, 
		info.bidAmount, info.minIncrement, info.timeLeft, info.quality, info.level
end

--[[
	Sorts according to the given column.
--]]
function vendor.OwnAuctionsItemModel.prototype:Sort(id, ascending)
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
function vendor.OwnAuctionsItemModel.prototype:ToggleSort(id)
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
function vendor.OwnAuctionsItemModel.prototype:GetSortInfo()
	return self.sortId, self.ascending
end

--[[
	Selects the given item.
--]]
function vendor.OwnAuctionsItemModel.prototype:SelectItem(row, selected)
	self.index[row].selected = selected
	self.updateCount = self.updateCount + 1
end

--[[
	Returns whether the given item was selected.
--]]
function vendor.OwnAuctionsItemModel.prototype:IsSelected(row)
	_EnsureSorting(self)
	return self.index[row].selected
end

--[[
	Returns the map with the indices of the selected items.
--]]
function vendor.OwnAuctionsItemModel.prototype:GetSelectedItems()
	_EnsureSorting(self)
	if (self.updateCount ~= self.selectedUpdateCount) then
    	self.selectedIndex = wipe(self.selectedIndex)
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
function vendor.OwnAuctionsItemModel.prototype:Update()
	_Update(self)
end

--[[
	Updates the auction statistics of the own auctions.
--]]
function vendor.OwnAuctionsItemModel.prototype:UpdateAuctionStatistics(itemLinkKey)
	_UpdateAuctionStatistics(self, itemLinkKey)
end

function vendor.OwnAuctionsItemModel.prototype:SetWithBidHighlight(id)
	self.withBidHighlight = id
end

function vendor.OwnAuctionsItemModel.prototype:SetUndercutHighlight(id)
	self.undercutHighlight = id
end

function vendor.OwnAuctionsItemModel.prototype:SetSoldHighlight(id)
	self.soldHighlight = id
end

--[[
	Registers a function that will be called, if the model has been updated.
--]]
function vendor.OwnAuctionsItemModel.prototype:RegisterUpdateListener(func, arg)
	table.insert(self.updateListeners, {func = func, arg = arg})
end