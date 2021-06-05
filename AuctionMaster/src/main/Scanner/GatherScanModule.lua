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
	ScanModule to be integrated in a ScanTask for gathering statistics.
--]]
vendor.GatherScanModule = {}
vendor.GatherScanModule.prototype = {}
vendor.GatherScanModule.metatable = {__index = vendor.GatherScanModule.prototype}

local log = vendor.Debug:new("GatherScanModule")

--[[ 
	Creates a new instance.
--]]
function vendor.GatherScanModule:new()
	local instance = setmetatable({}, self.metatable)
	return instance
end

--[[
	Notifies the beginning of the scan. The info struct contains:
	itemLinkKey, name, minLevel, maxLevel, invTypeIndex, classIndex, subclassIndex, isUsable, qualityIndex
--]]
function vendor.GatherScanModule.prototype:StartScan(info)
	log:Debug("StartScan name [%s]", info.name)
	self.info = info
	vendor.Gatherer:StartScan(info)
end

--[[
	Notifies the termination of the scan.
--]]
function vendor.GatherScanModule.prototype:StopScan(complete)
	log:Debug("StopScan name [%s] complete [%s] itemLinkKey [%s]", self.info.name, complete, self.info.itemLinkKey)
	vendor.Gatherer:StopScan(self.info.itemLinkKey, complete)
end

--[[
	Notifies the ScanModule that a page is about to be read.
--]]
function vendor.GatherScanModule.prototype:StartPage(page)
end

--[[
	Notifies the ScanModule that a page is now finished.
--]]
function vendor.GatherScanModule.prototype:StopPage()
end

--[[
	Notifies about the given auction data read. The auctions will be notified once for each index.
--]]
function vendor.GatherScanModule.prototype:NotifyAuction(itemLinkKey, itemLink, index, name, texture, count, 
		quality, canUse, level, minBid, minIncrement, buyoutPrice, bidAmount, highBidder, owner, saleStatus, 
		timeLeft)
	if (quality >= vendor.Scanner.db.profile.minQuality) then
    	vendor.Gatherer:AddAuctionItemInfo(itemLinkKey, name, quality, level, count, minBid, buyoutPrice, 
    					bidAmount, minIncrement, timeLeft, highBidder, owner or "")
	end
end
