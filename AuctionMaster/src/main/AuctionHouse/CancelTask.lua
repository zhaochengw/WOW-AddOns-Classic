--[[
	Describes an auction scan task to be performed.
	
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
	Cancels one auction per tick. This prevents from error messages.
--]]
vendor.CancelTask = {}
vendor.CancelTask.prototype = {}
vendor.CancelTask.metatable = {__index = vendor.CancelTask.prototype}

--[[ 
	Creates a new instance.
--]]
function vendor.CancelTask:new(auctions)
	local instance = setmetatable({}, self.metatable)
	instance.auctions = auctions
	return instance
end

--[[
	Run function of the task.
--]]
function vendor.CancelTask.prototype:Run()
	vendor.Vendor:Debug("CancelTask run enter")
	for _,auction in pairs(self.auctions) do
		vendor.Vendor:Debug("CancelTask start loop")
		vendor.AuctionHouse:ChatWait(self.waitId)
		vendor.Vendor:Debug("CancelTask left waiting")
		if (not auction.cancelled) then
			local batch, count = GetNumAuctionItems("owner")
			vendor.Vendor:Debug("CancelAuction batch: %d count: %d", batch, count)
			for i=1,batch do
				local name, _, count, _, _, _, unknown, minBid, _, buyout = GetAuctionItemInfo("owner", i)
				local itemLink = GetAuctionItemLink("owner", i)
				if (not name or not itemLink) then
					auction.cancelled = true
				else
					local itemLinkKey = vendor.Items:GetItemLinkKey(itemLink)
        			if (itemLinkKey == auction.itemLinkKey and count == auction.count and minBid == auction.minBid and buyout == auction.buyout) then
        				vendor.Vendor:Debug("FOUND auction")
        				auction.cancelled = true
        				vendor.AuctionHouse:AddAction(vendor.AuctionHouse.ACTION_CANCEL, itemLink)
        				CancelAuction(i)
        				vendor.Vendor:Debug("waiting for message")
        				self.waitId = vendor.AuctionHouse:RegisterChatWait()
        				break
        			end
        		end
        	end
		end
	end
	vendor.Vendor:Debug("CancelTask run exit")
end

--[[
	Cancels the task and leaves it as soon as possible. 
--]]
function vendor.CancelTask.prototype:Cancel()
	self.isCancelled = true
	self.isRunning = false
	vendor.AuctionHouse:UnregisterChatWait(self.waitId)
end

--[[
	Returns whether the task was canecelled.
--]]
function vendor.CancelTask.prototype:IsCancelled()
	return self.isCancelled
end

--[[
	Will be called by the TaskQueue, if the task has failed with an 
	unexpected error.
--]]
function vendor.CancelTask.prototype:Failed()
	self:Cancel()
end
