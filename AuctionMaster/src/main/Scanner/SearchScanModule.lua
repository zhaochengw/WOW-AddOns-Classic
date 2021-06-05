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
	ScanModule for the search scans in the ScanFrame. Will accept all items, unless a price
	or other not searchable attrinute has been set.
--]]
vendor.SearchScanModule = {}
vendor.SearchScanModule.prototype = {}
vendor.SearchScanModule.metatable = {__index = vendor.SearchScanModule.prototype}

local log = vendor.Debug:new("SearchScanModule")

--[[ 
	Creates a new instance.
--]]
function vendor.SearchScanModule:new(searchInfo, itemModel)
	local instance = setmetatable({}, self.metatable)
	instance.searchInfo = searchInfo
	instance.itemModel = itemModel-- or vendor.Scanner.scanFrame.itemModel
	return instance
end

--[[
	Notifies the beginning of the scan. The info struct contains:
	itemLinkKey, name, minLevel, maxLevel, invTypeIndex, classIndex, subclassIndex, isUsable, qualityIndex
--]]
function vendor.SearchScanModule.prototype:StartScan(info)
	log:Debug("StartScan name [%s]", info.name)
	self.info = info
end

--[[
	Notifies the termination of the scan.
--]]
function vendor.SearchScanModule.prototype:StopScan(complete)
	--log:Debug("StopScan name [%s] complete [%s] itemLinkKey [%s]", self.info.name, complete, self.info.itemLinkKey)
end

--[[
	Notifies the ScanModule that a page is about to be read.
--]]
function vendor.SearchScanModule.prototype:StartPage(page)
end

--[[
	Notifies the ScanModule that a page is now finished.
--]]
function vendor.SearchScanModule.prototype:StopPage()
	if (self.info.unique == 1 and self.itemModel.MakeUnique) then
		self.itemModel:MakeUnique()
	end
end

--[[
	Notifies about the given auction data read. The auctions will be notified once for each index.
--]]
function vendor.SearchScanModule.prototype:NotifyAuction(itemLinkKey, itemLink, index, name, texture, count, 
		quality, canUse, level, minBid, minIncrement, buyout, bidAmount, highBidder, owner, saleStatus, 
		timeLeft)
	local bid = minBid
	if (bidAmount and bidAmount > 0) then
		bid = bidAmount + minIncrement
	end
	
	local maxPrice = 0
	if (self.searchInfo) then
		maxPrice = self.searchInfo.maxPrice or 0
	end
	local maxRarity = self.searchInfo.maxRarity or 10
	local add = (quality <= maxRarity) or (maxRarity == 0)
	if (add) then 
		add = maxPrice == 0
		if (maxPrice > 0) then
			if (self.searchInfo.bid and not highBidder) then
				add = bid / count <= maxPrice
				log:Debug("check bid add [%s] bid [%s] count [%s] maxPrice [%s]", add, bid, count, maxPrice)
			elseif (self.searchInfo.buyout and buyout and buyout > 0) then
				add = buyout / count <= maxPrice
				log:Debug("check buyout add [%s] buyout [%s] count [%s] maxPrice [%s]", add, buyout, count, maxPrice)
			end
		end
	end
	if (add) then
		self.itemModel:AddItem(itemLink, itemLinkKey, name, texture, timeLeft, count, minBid, minIncrement, buyout or 0, bidAmount, owner, reason, sniperId, index, quality, highBidder)
	end
end
