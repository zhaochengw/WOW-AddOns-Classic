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
	ItemModel implementation for displaying ScanSets.
--]]
vendor.ScanSetItemModel = {}
vendor.ScanSetItemModel.prototype = {}
vendor.ScanSetItemModel.metatable = {__index = vendor.ScanSetItemModel.prototype}

local L = vendor.Locale.GetInstance()
local log = vendor.Debug:new("ScanSetItemModel")

-- the identifiers of the supported columns
vendor.ScanSetItemModel.TEXTURE = 1
vendor.ScanSetItemModel.NAME = 2
vendor.ScanSetItemModel.COUNT = 3
vendor.ScanSetItemModel.OWNER = 4
vendor.ScanSetItemModel.BID = 5
vendor.ScanSetItemModel.BUYOUT = 6
vendor.ScanSetItemModel.UNDERCUT = 7

-- the several sort functions
local SORT_FUNCS = {
	[vendor.ScanSetItemModel.COUNT] = {
		[true] = function(a, b) 
			local _, _, _, acount = a.scanSet:Get(a.idx)
			local _, _, _, bcount = b.scanSet:Get(b.idx)
			return acount < bcount;
		end,
		[false] = function(a, b)
			local _, _, _, acount = a.scanSet:Get(a.idx)
			local _, _, _, bcount = b.scanSet:Get(b.idx)
			return acount > bcount;
		end
	},
	[vendor.ScanSetItemModel.NAME] = {
		[true] = function(a, b)
				local aKey = a.scanSet:Get(a.idx)
				local bKey = b.scanSet:Get(b.idx)
				return GetItemInfo(vendor.Items:GetItemLink(aKey)) < GetItemInfo(vendor.Items:GetItemLink(bKey))
			end,
		[false] = function(a, b)
			local aKey = a.scanSet:Get(a.idx)
			local bKey = b.scanSet:Get(b.idx)
			return GetItemInfo(vendor.Items:GetItemLink(aKey)) > GetItemInfo(vendor.Items:GetItemLink(bKey))
		end
	},
	[vendor.ScanSetItemModel.OWNER] = {
		[true] = function(a, b)
				local _, _, _, _, _, _, _, _, aowner = a.scanSet:Get(a.idx)
				local _, _, _, _, _, _, _, _, bowner = b.scanSet:Get(b.idx)
				return aowner < bowner;
			end,
		[false] = function(a, b)
			local _, _, _, _, _, _, _, _, aowner = a.scanSet:Get(a.idx)
			local _, _, _, _, _, _, _, _, bowner = b.scanSet:Get(b.idx)
			return aowner > bowner;
		end
	},
	[vendor.ScanSetItemModel.BID] = {
		[true] = function(a, b)
				local _, _, _, acount, aminBid, _, _, abidAmount = a.scanSet:Get(a.idx)
				local _, _, _, bcount, bminBid, _, _, bbidAmount = b.scanSet:Get(b.idx)
				return (math.max(aminBid, abidAmount) / acount) < (math.max(bminBid, bbidAmount) / bcount);
			end,
		[false] = function(a, b)
				local _, _, _, acount, aminBid, _, _, abidAmount = a.scanSet:Get(a.idx)
				local _, _, _, bcount, bminBid, _, _, bbidAmount = b.scanSet:Get(b.idx)
				return (math.max(aminBid, abidAmount) / acount) > (math.max(bminBid, bbidAmount) / bcount);
			end
	},
	[vendor.ScanSetItemModel.BUYOUT] = {
		[true] = function(a, b)
				local _, _, _, acount, aminBid, _, abuyoutPrice, abidAmount = a.scanSet:Get(a.idx)
				local _, _, _, bcount, bminBid, _, bbuyoutPrice, bbidAmount = b.scanSet:Get(b.idx)
				if (not abuyoutPrice or abuyoutPrice <= 0) then
					abuyoutPrice = math.max(aminBid, abidAmount)
				end
				if (not bbuyoutPrice or bbuyoutPrice <= 0) then
					bbuyoutPrice = math.max(bminBid, bbidAmount)
				end
				return (abuyoutPrice / acount) < (bbuyoutPrice / bcount);
			end,
		[false] = function(a, b)
				local _, _, _, acount, aminBid, _, abuyoutPrice, abidAmount = a.scanSet:Get(a.idx)
				local _, _, _, bcount, bminBid, _, bbuyoutPrice, bbidAmount = b.scanSet:Get(b.idx)
				if (not abuyoutPrice or abuyoutPrice <= 0) then
					abuyoutPrice = math.max(aminBid, abidAmount)
				end
				if (not bbuyoutPrice or bbuyoutPrice <= 0) then
					bbuyoutPrice = math.max(bminBid, bbidAmount)
				end
				return (abuyoutPrice / acount) > (bbuyoutPrice / bcount);
			end
	}
};

local function _TestSort(a, b)
	local _, _, _, acount, _, _, abuyoutPrice = a.scanSet:Get(a.idx)
	local _, _, _, bcount, _, _, bbuyoutPrice = b.scanSet:Get(b.idx)
	return (abuyoutPrice / acount) > (bbuyoutPrice / bcount);
end

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

local function _OnUndercutUpdate(textureCell, self, minBid, buyout, owner)
	log:Debug("OnUndercutUpdate %s", buyout)
	textureCell.scanSetItemModelMinBid = minBid
	textureCell.scanSetItemModelBuyout = buyout
	textureCell.scanSetItemModelOwner = owner
	if (not buyout or buyout <= 0) then
		textureCell:Hide()
	else
		textureCell:Show()
	end
end

local function _OnUndercutClick(textureCell, self)
	local minBid = textureCell.scanSetItemModelMinBid
	local buyout = textureCell.scanSetItemModelBuyout
	local owner = textureCell.scanSetItemModelOwner
	log:Debug("OnUndercutClick %s", buyout)
	if (buyout and buyout > 0 and self.undercutCallback) then
		self.undercutCallback(self.undercutCallbackArg, minBid, buyout, owner)
	end
end

--[[
	Inits the table of descriptors.
--]]
local function _InitDescriptors(self)
	self.descriptors = {
		[vendor.ScanSetItemModel.UNDERCUT] = {type = "texture", title = L["Undercut"], arg = self, order = 5, normalTexture = "Interface\\Addons\\AuctionMaster\\src\\resources\\Button-Undercut-Up", pushedTexture = "Interface\\Addons\\AuctionMaster\\src\\resources\\Button-Undercut-Down", normalTexCoord = {0, 0.5, 0, 0.5}, pushedTexCoord = {0, 0.5, 0, 0.5}, clickCallback = _OnUndercutClick, updateCallback = _OnUndercutUpdate, tooltip = L["Undercut the given auction"]};
		[vendor.ScanSetItemModel.TEXTURE] = {type = "texture", title = L["Texture"], order = 10};
		[vendor.ScanSetItemModel.NAME] = {type = "text", align = "LEFT", weight = 35, minWidth = 60, sortable = true, title = L["Name"], order = 12};
		[vendor.ScanSetItemModel.COUNT] = {type = "number", align = "CENTER", weight = 10, minWidth = 20, sortable = true, title = L["Itms."], order = 13};
		[vendor.ScanSetItemModel.OWNER] = {type = "text", align = "CENTER", weight = 15, minWidth = 60, sortable = true, title = L["Seller"], order = 14};
		[vendor.ScanSetItemModel.BID] = {type = "text", align = "RIGHT", weight = 20, minWidth = 70, sortable = true, title = L["Bid"], order = 15};
		[vendor.ScanSetItemModel.BUYOUT] = {type = "text", align = "RIGHT", weight = 20, minWidth = 70, sortable = true, title = L["Buyout"], order = 16};
	}
end

--[[
	Creates a new instance.
--]]
function vendor.ScanSetItemModel:new()
	local instance = setmetatable({}, self.metatable)
	instance.selectedIndex = {}
	instance.index = {}
	instance.updateCount = 0
	instance.player = UnitName("player")
	_InitDescriptors(instance)
	instance:Sort(vendor.ScanSetItemModel.BUYOUT, true)
	return instance
end

--[[
	Sets the given ScanSet to be used for this model.
--]]
function vendor.ScanSetItemModel.prototype:SetScanSet(scanSet)
	self.scanSet = scanSet
	wipe(self.index)
	self.updateCount = self.updateCount + 1
	if (scanSet) then
		for i=1,scanSet:Size() do
			table.insert(self.index, {idx = i, scanSet = scanSet})
		end
		self.sorted = false
	end
end

--[[
	Returns the underlying ScanSet.
--]]
function vendor.ScanSetItemModel.prototype:GetScanSet()
	return self.scanSet
end

--[[
	ItemModel function for returning the desired descriptor.
--]]
function vendor.ScanSetItemModel.prototype:GetColumnDescriptor(id)
	return self.descriptors[id]
end

--[[
	Returns the number of items available.
--]]
function vendor.ScanSetItemModel.prototype:Size()
	return #self.index
end

--[[
	Returns the ScanSet data for the given row.
--]]
function vendor.ScanSetItemModel.prototype:Get(row)
	_EnsureSorting(self)
	if (self.scanSet) then
		local idx = self.index[row].idx
		return self.scanSet:Get(idx)
	end
	return nil
end

function vendor.ScanSetItemModel.prototype:GetItemLink(row)
	_EnsureSorting(self)
	if (self.scanSet) then
		local idx = self.index[row].idx
		local key = self.scanSet:Get(idx)
	  	return vendor.Items:GetItemLink(key)
	end
end

--[[
	Returns the value(s) for the given row and column id.
--]]
function vendor.ScanSetItemModel.prototype:GetValues(row, id)
	_EnsureSorting(self)
	if (self.scanSet) then
		local idx = self.index[row].idx
		local key, time, timeLeft, count, minBid, minIncrement, buyoutPrice, bidAmount, owner, highBidder = self.scanSet:Get(idx)
		if (id == vendor.ScanSetItemModel.TEXTURE) then
			local itemLink = vendor.Items:GetItemLink(key)
			local itemName, itemTexture = vendor.Items:GetItemData(itemLink)
			assert(itemTexture, key)
			assert(count, key)
			return itemTexture, itemLink, count
		elseif (id == vendor.ScanSetItemModel.NAME) then
			local itemLink = vendor.Items:GetItemLink(key)
			local itemName = vendor.Items:GetItemData(itemLink)
			log:Debug("name [%s]", itemName)
			if (self.player == owner) then
				itemName = L["%s (My)"]:format(itemName)
			elseif (highBidder == "1") then
				itemName = L["%s (Bid)"]:format(itemName)
			end
			return itemName
		elseif (id == vendor.ScanSetItemModel.COUNT) then
			return count
		elseif (id == vendor.ScanSetItemModel.OWNER) then
			return owner
		elseif (id == vendor.ScanSetItemModel.BID) then
			local bid = math.max(minBid, bidAmount)
			local msg 
			if (count > 1) then
				msg = vendor.Format.FormatMoneyValues(bid / count, bid, true)
			else
				msg = vendor.Format.FormatMoney(bid / count, true)
			end
			return msg
		elseif (id == vendor.ScanSetItemModel.BUYOUT) then
			local msg
			if (buyoutPrice > 0) then
				if (count > 1) then
					msg = vendor.Format.FormatMoneyValues(buyoutPrice / count, buyoutPrice, true)
				else
					msg = vendor.Format.FormatMoney(buyoutPrice / count, true)
				end
			end
			return msg
		elseif (id == vendor.ScanSetItemModel.UNDERCUT) then
			if (buyoutPrice > 0) then
				if (count > 1) then
					return minBid / count, buyoutPrice / count, owner
				else
					return minBid, buyoutPrice, owner
				end
			end
			return 0, 0, owner
		else
			error("unknown id: "..(id or "NA"));
		end
	else
		log:Debug("no scanset available")
	end
	return nil
end

--[[
	Sorts according to the given column.
--]]
function vendor.ScanSetItemModel.prototype:Sort(id, ascending)
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
function vendor.ScanSetItemModel.prototype:ToggleSort(id)
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
function vendor.ScanSetItemModel.prototype:GetSortInfo()
	return self.sortId, self.ascending
end

--[[
	Selects the given item.
--]]
function vendor.ScanSetItemModel.prototype:SelectItem(row, isSelected)
	_EnsureSorting(self)
	self.index[row].selected = isSelected
	self.updateCount = self.updateCount + 1
end

--[[
	Returns whether the given item was selected.
--]]
function vendor.ScanSetItemModel.prototype:IsSelected(row)
	return self.index[row].selected
end

--[[
	Returns the map with the indices of the selected items.
--]]
function vendor.ScanSetItemModel.prototype:GetSelectedItems()
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
	Returns any highlight id for the given row.
--]]
function vendor.ScanSetItemModel.prototype:GetHighlight(row)
	local highlight
	if (self.scanSet) then
    	_EnsureSorting(self)
    	local idx = self.index[row].idx
    	local key, time, timeLeft, count, minBid, minIncrement, buyoutPrice, bidAmount, owner, highBidder = self.scanSet:Get(idx)
    	log:Debug("GetHighlight highBidder [%s] owner [%s]", highBidder, owner)
    	if (owner == self.player) then
    		log:Debug("owner highlight")
    		highlight = self.ownerHighlight
    	elseif (highBidder and (highBidder == true or highBidder == "1")) then
    		--log:Debug("return highlight [%s]", self.playerHasBidHighlight)
    		highlight = self.playerHasBidHighlight
    	end
    end
	log:Debug("return highlight [%s]", highlight)
	return highlight
end

function vendor.ScanSetItemModel.prototype:SetUndercutCallback(callback, arg)
	self.undercutCallback = callback
	self.undercutCallbackArg = arg
end