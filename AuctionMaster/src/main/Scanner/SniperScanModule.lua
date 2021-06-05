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
	ScanModule to be integrated in a ScanTask for sniping auctions.
--]]
vendor.SniperScanModule = {}
vendor.SniperScanModule.prototype = {}
vendor.SniperScanModule.metatable = {__index = vendor.SniperScanModule.prototype}

local log = vendor.Debug:new("SniperScanModule")

--[[ 
	Creates a new instance.
--]]
function vendor.SniperScanModule:new(itemModel)
	local instance = setmetatable({}, self.metatable)
	instance.itemModel = itemModel-- or vendor.Scanner.scanFrame.itemModel
	return instance
end

--[[
	Notifies the beginning of the scan. The info struct contains:
	itemLinkKey, name, minLevel, maxLevel, invTypeIndex, classIndex, subclassIndex, isUsable, qualityIndex
--]]
function vendor.SniperScanModule.prototype:StartScan(info)
	log:Debug("StartScan name [%s]", info.name)
	self.info = info
end

--[[
	Notifies the termination of the scan.
--]]
function vendor.SniperScanModule.prototype:StopScan(complete)
	log:Debug("StopScan name [%s] complete [%s] itemLinkKey [%s]", self.info.name, complete, self.info.itemLinkKey)
end

--[[
	Notifies the ScanModule that a page is about to be read.
--]]
function vendor.SniperScanModule.prototype:StartPage(page)
end

--[[
	Notifies the ScanModule that a page is now finished.
--]]
function vendor.SniperScanModule.prototype:StopPage()
end

--[[
	Notifies about the given auction data read. The auctions will be notified once for each index.
--]]
function vendor.SniperScanModule.prototype:NotifyAuction(itemLinkKey, itemLink, index, name, texture, count, 
		quality, canUse, level, minBid, minIncrement, buyout, bidAmount, highBidder, owner, saleStatus, 
		timeLeft)
	local askForBuy, reason, sniperId, doBid, doBuyout, reasonSort = vendor.Sniper:ItemScanned(index, itemLink, name, highBidder)
	if (askForBuy) then
		log:Debug("askForBuy index [%s] minBid: %d bidAmount: %d buyout: %d", index, minBid or 777, bidAmount or 777, buyout or 777)
		local bid = minBid
		if (bidAmount and bidAmount > 0) then
			bid = bidAmount + minIncrement
		end
		log:Debug("add item to itemModel [%s]", self.itemModel)
		self.itemModel:AddItem(itemLink, itemLinkKey, name, texture, timeLeft, count, minBid, minIncrement, buyout or 0, bidAmount, owner, reason, sniperId, index, quality, highBidder, reasonSort)
		log:Debug("item was added")
	end
end
