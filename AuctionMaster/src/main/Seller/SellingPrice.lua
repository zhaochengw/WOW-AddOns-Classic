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
	Encapsulates a selling price with minBid and buyout.
--]]
vendor.SellingPrice = {}
vendor.SellingPrice.prototype = {}
vendor.SellingPrice.metatable = {__index = vendor.SellingPrice.prototype}

vendor.SellingPrice.BID_TYPE_PER_ITEM = 1
vendor.SellingPrice.BID_TYPE_PER_STACK = 2
vendor.SellingPrice.BID_TYPE_ALL = 3

local log = vendor.Debug:new("SellingPrice")

--[[ 
	Creates a new instance.
--]]
function vendor.SellingPrice:new()
	local instance = setmetatable({}, self.metatable)
	return instance
end

--[[
	Sets a new value.
--]]
function vendor.SellingPrice.prototype:SetPrices(minBid, buyout, bidType, userDefined)
	self.minBid = minBid
	self.buyout = buyout or 0
	self.bidType = bidType
	self.userDefined = userDefined
	if (not bidType or (bidType ~= vendor.SellingPrice.BID_TYPE_PER_ITEM and 
		bidType ~= vendor.SellingPrice.BID_TYPE_PER_STACK and 
		bidType ~= vendor.SellingPrice.BID_TYPE_ALL)) then
		error("unknown bidType: "..(bidType or "null"))
	end
end

--[[
	Resets the information known.
--]]
function vendor.SellingPrice.prototype:Clear()
	self.minBid = nil
	self.buyout = nil
	self.deposit = nil
	self.bidType = nil
	self.userDefined = nil
end

--[[
	Returns the prices for the given type.
	Returns: minBid, buyout, deposit
--]]
function vendor.SellingPrice.prototype:GetPrices(bidType)
	log:Debug("GetPrices numStacks: %d stackSize: %d backlog: %d", self.numStacks or 0, self.stackSize or 0, backlog or 0)
	bidType = bidType or self.bidType
	local minBid, buyout
	if (bidType == vendor.SellingPrice.BID_TYPE_PER_ITEM) then
		if (self.bidType == vendor.SellingPrice.BID_TYPE_PER_STACK) then
			minBid = self.minBid / self.stackSize
			buyout = self.buyout / self.stackSize
		elseif (self.bidType == vendor.SellingPrice.BID_TYPE_ALL) then
			local numItems = self.stackSize * self.numStacks + self.backlog
			minBid = self.minBid / numItems
			buyout = self.buyout / numItems
		else
			minBid, buyout = self.minBid, self.buyout
		end
	elseif (bidType == vendor.SellingPrice.BID_TYPE_PER_STACK) then
		if (self.bidType == vendor.SellingPrice.BID_TYPE_PER_ITEM) then
			minBid = self.minBid * self.stackSize
			buyout = self.buyout * self.stackSize
		elseif (self.bidType == vendor.SellingPrice.BID_TYPE_ALL) then
			local numItems = self.stackSize * self.numStacks + self.backlog
			minBid = (self.minBid / numItems) * self.stackSize
			buyout = (self.buyout / numItems) * self.stackSize
		else
			minBid, buyout = self.minBid, self.buyout
		end
	elseif (bidType == vendor.SellingPrice.BID_TYPE_ALL) then
		if (self.bidType == vendor.SellingPrice.BID_TYPE_PER_ITEM) then
			local numItems = self.stackSize * self.numStacks + self.backlog
			minBid = self.minBid * numItems
			buyout = self.buyout * numItems
		elseif (self.bidType == vendor.SellingPrice.BID_TYPE_PER_STACK) then
			local numItems = self.stackSize * self.numStacks + self.backlog
			minBid = (self.minBid / self.stackSize) * numItems
			buyout = (self.buyout / self.stackSize) * numItems
		else
			minBid, buyout = self.minBid, self.buyout
		end
	else
		error("unknown bidType: "..(bidType or "null"))
	end
	return minBid, buyout, self.deposit
end

--[[
	Returns whether the prices are user defined.
--]]
function vendor.SellingPrice.prototype:IsUserDefined()
	return self.userDefined
end

--[[
	Clears the user defined flag.
--]]
function vendor.SellingPrice.prototype:ClearUserDefined()
	self.userDefined = nil
end

--[[
	Sets the deposit costs.
--]]
function vendor.SellingPrice.prototype:SetDeposit(deposit)
	self.deposit = deposit
end

--[[
	Sets the size of the stacks to be sold.
--]]
function vendor.SellingPrice.prototype:SetStackSize(stackSize)
	self.stackSize = stackSize
end

--[[
	Sets the number of stacks to be sold.
--]]
function vendor.SellingPrice.prototype:SetNumStacks(numStacks)
	self.numStacks = numStacks
end

--[[
	Sets the backlog, the remaining after all stacks.
--]]
function vendor.SellingPrice.prototype:SetBacklog(backlog)
	self.backlog = backlog
end
