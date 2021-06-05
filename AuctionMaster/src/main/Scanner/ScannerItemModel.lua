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

vendor.ScannerItemModel = {}
vendor.ScannerItemModel.prototype = {}
vendor.ScannerItemModel.metatable = {__index = vendor.ScannerItemModel.prototype}

local L = vendor.Locale.GetInstance()

local log = vendor.Debug:new("ScannerItemModel")

-- the identifiers of the supported columns
vendor.ScannerItemModel.TEXTURE = 1
vendor.ScannerItemModel.NAME = 2
vendor.ScannerItemModel.COUNT = 3
vendor.ScannerItemModel.BID = 5
vendor.ScannerItemModel.BUYOUT = 6
vendor.ScannerItemModel.REASON = 7
vendor.ScannerItemModel.ITEM_LEVEL = 8

-- the several sort functions
local SORT_FUNCS = {
	[vendor.ScannerItemModel.COUNT] = {
		[true] = function(a, b) 
			return a.count < b.count
		end,
		[false] = function(a, b)
			return a.count > b.count
		end
	},
	[vendor.ScannerItemModel.NAME] = {
		[true] = function(a, b)
			return a.name < b.name
		end,
		[false] = function(a, b)
			return a.name > b.name
		end
	},
	[vendor.ScannerItemModel.ITEM_LEVEL] = {
		[true] = function(a, b)
			return a.itemLevel < b.itemLevel
		end,
		[false] = function(a, b)
			return a.itemLevel > b.itemLevel
		end
	},
	[vendor.ScannerItemModel.BID] = {
		[true] = function(a, b)
			return (math.max(a.minBid, a.bidAmount) / a.count) < (math.max(b.minBid, b.bidAmount) / b.count)
		end,
		[false] = function(a, b)
			return (math.max(a.minBid, a.bidAmount) / a.count) > (math.max(b.minBid, b.bidAmount) / b.count)
		end
	},
	[vendor.ScannerItemModel.BUYOUT] = {
		[true] = function(a, b)
			local ab = a.buyout / a.count
			if (ab == 0) then
				ab = 999999999
			end
			local bb = b.buyout / b.count
			if (bb == 0) then
				bb = 999999999
			end
			return (ab < bb)
		end,
		[false] = function(a, b)
			local ab = a.buyout / a.count
			if (ab == 0) then
				ab = 999999999
			end
			local bb = b.buyout / b.count
			if (bb == 0) then
				bb = 999999999
			end
			return (ab > bb)
		end
	},
	[vendor.ScannerItemModel.REASON] = {
		[true] = function(a, b)
			return a.reasonSort < b.reasonSort
		end,
		[false] = function(a, b)
			return a.reasonSort > b.reasonSort
		end
	}

}

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
		[vendor.ScannerItemModel.TEXTURE] = {type = "texture", title = L["Texture"], order = 1},
		[vendor.ScannerItemModel.NAME] = {type = "text", align = "LEFT", weight = 35, minWidth = 60, sortable = true, title = L["Name"], order = 2},
		[vendor.ScannerItemModel.COUNT] = {type = "number", align = "CENTER", weight = 10, minWidth = 20, sortable = true, title = L["Itms."], order = 4},
		[vendor.ScannerItemModel.BID] = {type = "text", align = "RIGHT", weight = 20, minWidth = 70, sortable = true, title = L["Bid"], order = 6},
		[vendor.ScannerItemModel.BUYOUT] = {type = "text", align = "RIGHT", weight = 20, minWidth = 70, sortable = true, title = L["Buyout"], order = 7},
		[vendor.ScannerItemModel.REASON] = {type = "text", align = "LEFT", weight = 60, minWidth = 100, sortable = true, title = L["Reason"], order = 5},
		[vendor.ScannerItemModel.ITEM_LEVEL] = {type = "text", align = "CENTER", weight = 10, minWidth = 50, sortable = true, title = L["ItmLev"], order = 3}
	}
end

local function _Updated(self)
	log:Debug("_Updated")
	self.sorted = false
	self.updateCount = self.updateCount + 1
	log:Debug("notify")
	for _,listener in pairs(self.updateListeners) do
    	listener.func(listener.arg)
    end
    log:Debug("_Updated exit")
end

--[[
	Creates a new instance.
--]]
function vendor.ScannerItemModel:new(ignoreSnipers)
	local instance = setmetatable({}, self.metatable)
	instance.selectedIndex = {}
	instance.index = {}
	instance.rejected = {}
	instance.updateCount = 0
	instance.updateListeners = {}
	instance.sniperIds = {}
	instance.ignoreSnipers = ignoreSnipers
	instance.player = UnitName("player")
	_InitDescriptors(instance)
	instance:Sort(vendor.ScannerItemModel.BUYOUT, true)
	return instance
end

--[[
	Adds a new item to the model.
--]]
function vendor.ScannerItemModel.prototype:AddItem(itemLink, itemLinkKey, name, texture, timeLeft, count, minBid, minIncrement, buyout, bidAmount, owner, reason, sniperId, index, quality, highBidder, reasonSort)
	log:Debug("AddItem enter reason [%s] sniperId [%s] buyout [%s] quality [%s] ignoreSnipers [%s]", reason, sniperId, buyout, quality, self.ignoreSnipers)
	local colorizedName = vendor.Format.ColorizeQuality(name, quality)
	local info = {itemLinkKey = itemLinkKey, itemLink = itemLink, texture = texture, name = name, timeLeft = timeLeft, count = count, minBid = minBid, minIncrement = minIncrement, buyout = buyout or 0, bidAmount = bidAmount or 0, reason = reason or "", sniperId = sniperId, index = index, colorizedName = colorizedName, highBidder = highBidder, reasonSort = reasonSort or reason or "", owner = owner}
	info.itemLevel = select(4, GetItemInfo(itemLink)) or 0
	if (self.ignoreSnipers or (not sniperId or self.sniperIds[sniperId])) then
		table.insert(self.index, info)		
		_Updated(self)
    else
    	table.insert(self.rejected, info)
    end
end

--[[
	ItemModel function for returning the desired descriptor.
--]]
function vendor.ScannerItemModel.prototype:GetColumnDescriptor(id)
	return self.descriptors[id]
end

--[[
	Returns the number of items available.
--]]
function vendor.ScannerItemModel.prototype:Size()
	return #self.index
end

function vendor.ScannerItemModel.prototype:GetItemLink(row)
	_EnsureSorting(self)
	if (row > #self.index) then
		return
	end
	local info = self.index[row]
	return info.itemLink
end

--[[
	Returns the value(s) for the given row and column id.
--]]
function vendor.ScannerItemModel.prototype:GetValues(row, id)
	_EnsureSorting(self)
	if (row > #self.index) then
		return
	end
	local info = self.index[row]
	if (id == vendor.ScannerItemModel.TEXTURE) then
		return info.texture, info.itemLink, info.count
	elseif (id == vendor.ScannerItemModel.NAME) then
		return info.colorizedName
	elseif (id == vendor.ScannerItemModel.ITEM_LEVEL) then
		return info.itemLevel
	elseif (id == vendor.ScannerItemModel.COUNT) then
		return info.count
	elseif (id == vendor.ScannerItemModel.REASON) then
		return info.reason
	elseif (id == vendor.ScannerItemModel.BID) then
		local bid = math.max(info.minBid, info.bidAmount)
		local msg 
		if (info.count > 1) then
			msg = vendor.Format.FormatMoneyValues(bid / info.count, bid, true)
		else
			msg = vendor.Format.FormatMoney(bid / info.count, true)
		end
		if (info.highBidder) then
			msg = YOU.." "..msg
		end
		return msg
	elseif (id == vendor.ScannerItemModel.BUYOUT) then
		local msg
		if (info.buyout > 0) then
			if (info.count > 1) then
				msg = vendor.Format.FormatMoneyValues(info.buyout / info.count, info.buyout, true)
			else
				msg = vendor.Format.FormatMoney(info.buyout / info.count, true)
			end
		end
		return msg
	else
		error("unknown id: "..(id or "NA"));
	end
	return nil
end

--[[
	Returns the auction data for the given row as
	itemLinkKey, itemLink, texture, name, timeLeft, count, minBid, minIncrement, buyout, bidAmount, reason, sniperId, index
--]]
function vendor.ScannerItemModel.prototype:Get(row)
	local info = self.index[row]
	return info.itemLinkKey, info.itemLink, info.texture, info.name, info.timeLeft, info.count, info.minBid, info.minIncrement, info.buyout, info.bidAmount, info.reason, info.sniperId, info.index
end

--[[
	Sorts according to the given column.
--]]
function vendor.ScannerItemModel.prototype:Sort(id, ascending)
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
function vendor.ScannerItemModel.prototype:ToggleSort(id)
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
function vendor.ScannerItemModel.prototype:GetSortInfo()
	return self.sortId, self.ascending
end

--[[
	Selects the given item.
--]]
function vendor.ScannerItemModel.prototype:SelectItem(row, isSelected)
	_EnsureSorting(self)
	if (row <= #self.index) then
		self.index[row].selected = isSelected
		self.updateCount = self.updateCount + 1
	end
end

--[[
	Returns whether the given item was selected.
--]]
function vendor.ScannerItemModel.prototype:IsSelected(row)
	if (row <= #self.index) then
		return self.index[row].selected
	end
	return false
end

--[[
	Returns the map with the indices of the selected items.
--]]
function vendor.ScannerItemModel.prototype:GetSelectedItems()
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
	Registers a function that will be called, if the model has been updated.
--]]
function vendor.ScannerItemModel.prototype:RegisterUpdateListener(func, arg)
	table.insert(self.updateListeners, {func = func, arg = arg})
end

--[[
	Remove all known items.
--]]
function vendor.ScannerItemModel.prototype:Clear()
	wipe(self.index)
	wipe(self.rejected)
	_Updated(self)
end

--[[
	Selects whether auctions of the given sniper should be visible. By default
	a sniper is estimated to be invisible.
--]] 
function vendor.ScannerItemModel.prototype:SetSniperVisibility(sniperId, isVisible)
	log:Debug("SetSniperVisibility sniperId [%s] isVisible [%s]", sniperId, isVisible)
	if (isVisible and not self.sniperIds[sniperId]) then
		log:Debug("go visbible rejected [%s]", #self.rejected)
		-- sniper switches to visible
		self.sniperIds[sniperId] = true
		for i=#self.rejected, 1, -1 do
			local info = self.rejected[i]
			if (sniperId == info.sniperId) then
				table.remove(self.rejected, i)
				table.insert(self.index, info)
				_Updated(self)
			end
		end
	elseif (not isVisible and self.sniperIds[sniperId]) then
		log:Debug("go invisbible items [%s]", #self.index)
		-- sniper switches to not visible
		self.sniperIds[sniperId] = nil
		for i=#self.index, 1, -1 do
			local info = self.index[i]
			if (sniperId == info.sniperId) then
				table.remove(self.index, i)
				table.insert(self.rejected, info)
				_Updated(self)
			end
		end
	end
end

--[[
	Removes the given rows from the model
--]]
function vendor.ScannerItemModel.prototype:RemoveRows(rows)
	table.sort(rows)
	for i=#rows,1,-1 do
		table.remove(self.index, rows[i])
	end
	_Updated(self)
end

--[[
	Returns any highlight id for the given row.
--]]
function vendor.ScannerItemModel.prototype:GetHighlight(row)
	local highlight
	if (self.index) then
    	_EnsureSorting(self)
    	--local idx = self.index[row].idx
    	local info = self.index[row]
    	--local key, time, timeLeft, count, minBid, minIncrement, buyoutPrice, bidAmount, owner, highBidder = self.scanSet:Get(idx)
    	log:Debug("GetHighlight highBidder [%s] owner [%s]", info.highBidder, info.owner)
    	if (info.owner == self.player) then
    		log:Debug("owner highlight")
    		highlight = self.ownerHighlight
    	elseif (info.highBidder and (info.highBidder == true or info.highBidder == "1" or info.highBidder == 1)) then
    		log:Debug("return highlight [%s]", self.playerHasBidHighlight)
    		highlight = self.playerHasBidHighlight
    	end
    end
	log:Debug("return highlight [%s]", highlight)
	return highlight
end

function vendor.ScannerItemModel.prototype:MakeUnique()
	log:Debug("MakeUnique")
	-- sort by buyout
	local oldSortFunc = self.sortFunc
	self.sortFunc = SORT_FUNCS[vendor.ScannerItemModel.BUYOUT][true]
	self.sorted = nil
	_EnsureSorting(self)
	
	-- make table unique
	local index = self.index
	local n = #index
	log:Debug("n [%s]", n)
	for i=n,1,-1 do
		local info = index[i]
		local key = info.itemLinkKey
		for j=i-1,1,-1 do
			if (vendor.Items:MatchItemLinkKeys(key, index[j].itemLinkKey)) then
				info = nil
				break
			end
		end
		if (not info) then
			log:Debug("remove [%s]", i)
			tremove(index, i)
		end 
	end
	
	-- restore previous sorting
	self.sorted = nil
	self.sortFunc = oldSortFunc
	
	_Updated(self)
end