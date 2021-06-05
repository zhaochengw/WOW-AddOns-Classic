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
	Bid or buys a given list of auctions.
--]]
vendor.GetAllPlaceAuctionTask = {}
vendor.GetAllPlaceAuctionTask.prototype = {}
vendor.GetAllPlaceAuctionTask.metatable = {__index = vendor.GetAllPlaceAuctionTask.prototype}

local log = vendor.Debug:new("GetAllPlaceAuctionTask")

--[[
	Callback for the sniper.
--]]
local function _AskToBuy(itemLink, itemName, count, minBid, bidAmount, minIncrement, buyout, highBidder, self)
	log:Debug("_AskToBuy minBid: %d bidAmount: %d", minBid or 777, bidAmount or 777)
	for k,v in pairs(self.auctions) do
		if (not v.wasBought) then
			local itemLinkKey = vendor.Items:GetItemLinkKey(itemLink)
			if (v.itemLinkKey == itemLinkKey and v.count == count) then
				local bid = math.max(minBid, bidAmount or 0)
				local doBid = math.max(v.minBid or 0, v.bidAmount or 0)
				log:Debug("bid: %d doBid: %d", bid or 777, doBid or 777)
				if (bid == doBid and not highBidder) then
					log:Debug("bid it")
					v.wasBought = true
					return true, false
				end
				if (buyout and buyout > 0 and buyout == v.buyout) then
					log:Debug("buyout it")
					v.wasBought = true
					return false, true
				end
			end
		end
	end
	return false, false
end

local function _ScanFinished(self)
	log:Debug("_ScanFinished")
	self.scanFinished = true
end

--[[ 
	Creates a new instance.
--]]
function vendor.GetAllPlaceAuctionTask:new(auctions)
	local instance = setmetatable({}, self.metatable)
	instance.auctions = auctions
	table.sort(instance.auctions, function(a, b)
			return a.index > b.index
		end
	)
	return instance
end

--[[
	Run function of the task.
--]]
function vendor.GetAllPlaceAuctionTask.prototype:Run()
	log:Debug("Run enter")
	self.isRunning = true
	
	for _,info in pairs(self.auctions) do
    	if (not self.scanDialog) then
    		self.scanDialog = vendor.ScanDialog:new()
    	end
   		self.scanDialog:AskToBuy(info.itemLink, info.count, info.minBid, info.bidAmount, info.minIncrement, info.buyout, info.reason, 
    				info.index, info.doBid, info.doBuyout, false)
	end
	log:Debug("Run exit")
end

--[[
	Cancels the task and leaves it as soon as possible. 
--]]
function vendor.GetAllPlaceAuctionTask.prototype:Cancel()
	self.isCancelled = true
	self.isRunning = false
	vendor.Sniper:RegisterExclusiveSniper(nil)
end

--[[
	Returns whether the task was canecelled.
--]]
function vendor.GetAllPlaceAuctionTask.prototype:IsCancelled()
	return self.isCancelled
end

--[[
	Will be called by the TaskQueue, if the task has failed with an 
	unexpected error.
--]]
function vendor.GetAllPlaceAuctionTask.prototype:Failed()
	self:Cancel()
end
