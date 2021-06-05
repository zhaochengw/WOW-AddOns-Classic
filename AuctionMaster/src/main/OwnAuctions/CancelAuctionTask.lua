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
vendor.CancelAuctionTask = {}
vendor.CancelAuctionTask.prototype = {}
vendor.CancelAuctionTask.metatable = {__index = vendor.CancelAuctionTask.prototype}

local log = vendor.Debug:new("CancelAuctionTask")

--[[ 
	Creates a new instance.
--]]
function vendor.CancelAuctionTask:new(auctions)
	local instance = setmetatable({}, self.metatable)
	instance.auctions = auctions
	instance.doScan = doScan
	return instance
end

--[[
	Run function of the task.
--]]
function vendor.CancelAuctionTask.prototype:Run()
	log:Debug("Run enter")
	self.isRunning = true
	
	-- highest index first
	table.sort(self.auctions, function(a,b) return a.index > b.index end)
	
	for _,info in pairs(self.auctions) do
    	if (not self.dialog) then
    		self.dialog = vendor.CancelAuctionDialog:new()
    	end
   		self.dialog:AskToCancel(info.itemLink, info.count, info.minBid, info.bidAmount, info.buyout, 
    				info.index)
	end
	log:Debug("Run exit")
end

--[[
	Cancels the task and leaves it as soon as possible. 
--]]
function vendor.CancelAuctionTask.prototype:Cancel()
	self.isCancelled = true
	self.isRunning = false
end

--[[
	Returns whether the task was canecelled.
--]]
function vendor.CancelAuctionTask.prototype:IsCancelled()
	return self.isCancelled
end

--[[
	Will be called by the TaskQueue, if the task has failed with an 
	unexpected error.
--]]
function vendor.CancelAuctionTask.prototype:Failed()
	self:Cancel()
end
