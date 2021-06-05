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
	Immutable list of auctions which may be sorted in several ways.
--]]
vendor.ScanSet = {}
vendor.ScanSet.prototype = {}
vendor.ScanSet.metatable = {__index = vendor.ScanSet.prototype}

vendor.ScanSet.NAME_SORT = "name"
vendor.ScanSet.COUNT_SORT = "count"
vendor.ScanSet.OWNER_SORT = "owner"
vendor.ScanSet.BID_SORT = "bidPerItem"
vendor.ScanSet.BUYOUT_SORT = "buyoutPerItem"

-- the several sort functions
local SORT_FUNCS = {
	[vendor.ScanSet.COUNT_SORT] = {
		[true] = function(a, b) 
			local _, _, _, acount = vendor.ScanResults.Unpack(a);
			local _, _, _, bcount = vendor.ScanResults.Unpack(b);
			return acount < bcount;
		end,
		[false] = function(a, b)
			local _, _, _, acount = vendor.ScanResults.Unpack(a);
			local _, _, _, bcount = vendor.ScanResults.Unpack(b);
			return acount > bcount;
		end
	},
	[vendor.ScanSet.NAME_SORT] = {
		[true] = function(a, b)
				local aKey = vendor.ScanResults.Unpack(a)
				local bKey = vendor.ScanResults.Unpack(b)
				return GetItemInfo(vendor.Items.GetItemLink(aKey)) < GetItemInfo(vendor.Items.GetItemLink(bKey))
			end,
		[false] = function(a, b)
			local aKey = vendor.ScanResults.Unpack(a)
			local bKey = vendor.ScanResults.Unpack(b)
			return GetItemInfo(vendor.Items.GetItemLink(aKey)) > GetItemInfo(vendor.Items.GetItemLink(bKey))
		end
	},
	[vendor.ScanSet.OWNER_SORT] = {
		[true] = function(a, b)
				local _, _, _, _, _, _, _, _, aowner = vendor.ScanResults.Unpack(a);
				local _, _, _, _, _, _, _, _, bowner = vendor.ScanResults.Unpack(b);
				return aowner < bowner;
			end,
		[false] = function(a, b)
			local _, _, _, _, _, _, _, _, aowner = vendor.ScanResults.Unpack(a);
			local _, _, _, _, _, _, _, _, bowner = vendor.ScanResults.Unpack(b);
			return aowner > bowner;
		end
	},
	[vendor.ScanSet.BID_SORT] = {
		[true] = function(a, b)
				local _, _, _, acount, aminBid, _, _, abidAmount = vendor.ScanResults.Unpack(a);
				local _, _, _, bcount, bminBid, _, _, bbidAmount = vendor.ScanResults.Unpack(b);
				return (math.max(aminBid, abidAmount) / acount) < (math.max(bminBid, bbidAmount) / bcount);
			end,
		[false] = function(a, b)
				local _, _, _, acount, aminBid, _, _, abidAmount = vendor.ScanResults.Unpack(a);
				local _, _, _, bcount, bminBid, _, _, bbidAmount = vendor.ScanResults.Unpack(b);
				return (math.max(aminBid, abidAmount) / acount) > (math.max(bminBid, bbidAmount) / bcount);
			end
	},
	[vendor.ScanSet.BUYOUT_SORT] = {
		[true] = function(a, b)
				local _, _, _, acount, _, _, abuyoutPrice = vendor.ScanResults.Unpack(a);
				local _, _, _, bcount, _, _, bbuyoutPrice = vendor.ScanResults.Unpack(b);
				return (abuyoutPrice / acount) < (bbuyoutPrice / bcount);
			end,
		[false] = function(a, b)
					local _, _, _, acount, _, _, abuyoutPrice = vendor.ScanResults.Unpack(a);
					local _, _, _, bcount, _, _, bbuyoutPrice = vendor.ScanResults.Unpack(b);
					return (abuyoutPrice / acount) > (bbuyoutPrice / bcount);
				end
	}
};

--[[
	Checks whether the list has to be sorted and does it in case.
--]]
local function _EnsureSorting(self)
	if (not self.sorted) then
		table.sort(self.index, self.sortFunc);
	end
	self.sorted = true;
end

--[[ 
	Creates a ScanSet instance with the given list of auctions.
--]]
function vendor.ScanSet:new(index, isNeutral, itemLinkKey)
	local instance = setmetatable({}, self.metatable)
	instance.index = index;
	instance.sortFunc = SORT_FUNCS["owner"][true];
	instance.isNeutral = isNeutral;
	instance.itemLinkKey = itemLinkKey
	-- search for eldest entry
	instance.eldestEntry = nil;
	for i,v in pairs(instance.index) do
		local key, time = vendor.ScanResults.Unpack(v);
		if (not instance.eldestEntry or time < instance.eldestEntry) then
			instance.eldestEntry = time;
		end
	end
	return instance
end

--[[
	Returns the total number of entries.
--]]
function vendor.ScanSet.prototype:Size()
	return table.getn(self.index);
end

--[[ 
	Returns the n'th entry starting from 1.
	@return itemLinkKey, time, timeLeft, count, minBid, minIncrement, buyoutPrice, bidAmount, owner, highBidder, index
--]]
function vendor.ScanSet.prototype:Get(n)
	_EnsureSorting(self);
	local data = self.index[n];
	return vendor.ScanResults.Unpack(data);
end

--[[
	Selects the attribute for sorting, possible values are:
	"count", "owner", "bidPerItem" and "buyoutPerItem".
	Should never be called for the original snapshot, only 
	for copies of it! 
--]]
function vendor.ScanSet.prototype:Sort(sortType, ascending)
	self.sortFunc = SORT_FUNCS[sortType][ascending];
	self.sorted = false;
end

--[[
	Returns whether the auction set is for a neutral auction house.
--]] 
function vendor.ScanSet.prototype:IsNeutral()
	return self.isNeutral;
end

--[[
	Returns the selected item for the auctions.
--]]
function vendor.ScanSet.prototype:GetItemLinkKey()
	return self.itemLinkKey
end

--[[
	Returns the up-to-dateness of the scan set. This is the age of the eldest
	entry in seconds or nil if no entries.
--]]
function vendor.ScanSet.prototype:GetUpToDateness()
	if (self.eldestEntry) then
		return time() - self.eldestEntry;
	end
	return nil;
end

--[[
	Deletes all own auctions and rereads them.
--]]
function vendor.ScanSet.prototype:UpdateOwnAuctions()
	local index = self.index
	local data, owner
	local playerName = UnitName("player")
	-- delete own auctions
	if (#index > 0) then
		for i=#index,1,-1 do 
			data = index[i]
			owner = select(9, vendor.ScanResults.Unpack(data))
			if (playerName == owner) then
				table.remove(index, i)
			end
		end
	end
	-- reinsert them
	local batch, count = GetNumAuctionItems("owner")
	local itemLinkKey
	for i=1,batch do
		local name, _, count, _, _, _, unknown, minBid, minIncrement, buyoutPrice, bidAmount, highBidder, bidderFullName, owner, ownerFullName = GetAuctionItemInfo("owner", i)
		local timeLeft = GetAuctionItemTimeLeft("owner", i)
		local itemLink = GetAuctionItemLink("owner", i)
		if (name and itemLink) then
			itemLinkKey = vendor.Items:GetItemLinkKey(itemLink)
			if (itemLinkKey == self.itemLinkKey) then
				data = vendor.ScanResults.Pack(itemLinkKey, GetTime(), timeLeft, count, minBid, minIncrement, buyoutPrice, bidAmount, owner, highBidder or "", i)
				table.insert(index, data)
			end
		end
	end
	self.sorted = false
end

function vendor.ScanSet.prototype:Add(itemLinkKey, timeLeft, count, minBid, minIncrement, buyoutPrice, bidAmount, owner, highBidder)
	local idx = #self.index + 1
	local data = vendor.ScanResults.Pack(itemLinkKey, GetTime(), timeLeft, count, minBid, minIncrement, buyoutPrice, bidAmount, owner, highBidder or "", idx)
	tinsert(self.index, data)
	self.sorted = false
end

function vendor.ScanSet.prototype:Remove(itemLinkKey, minBid, buyout, bidAmount, owner)
	local index = self.index
	local n = #index
	for i=1,n do
		local key, time, timeLeft, count, entryMinBid, minIncrement, entryBuyout, entryBidAmount, entryOwner = vendor.ScanResults.Unpack(index[i])
		if (key == itemLinkKey and owner == owner and minBid == entryMinBid and buyout == entryBuyout and bidAmount == entryBidAmount) then
			tremove(index, i)
			break
		end 
	end
end