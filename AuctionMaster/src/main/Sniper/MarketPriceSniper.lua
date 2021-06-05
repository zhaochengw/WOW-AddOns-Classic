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
	Snipe using bookmarks.
--]]
vendor.MarketPriceSniper = {}
vendor.MarketPriceSniper.prototype = {}
vendor.MarketPriceSniper.metatable = {__index = vendor.MarketPriceSniper.prototype}

local L = vendor.Locale.GetInstance()

--[[ 
	Creates a new instance.
--]]
function vendor.MarketPriceSniper:new(auctions)
	local instance = setmetatable({}, self.metatable)
	instance.auctions = auctions
	return instance
end

--[[
	Checks whether to snipe for the item and returns doBuy, reason
--]]
function vendor.MarketPriceSniper.prototype:Snipe(itemLink, itemName, count, bid, buyout, highBidder)
	local snipeAverage = vendor.Scanner.db.profile.snipeAverage * 100.0
	local minProf = vendor.Scanner.db.profile.minimumProfit * 100.0
	local minCount = vendor.Scanner.db.profile.snipeAverageMinCount
	if (snipeAverage > 0) then
		local neutralAh = vendor.AuctionHouse:IsNeutral()
		local itemLinkKey = vendor.Items:GetItemLinkKey(itemLink)
		local avgBid, avgBuyout, numAuctions, numBuyouts = vendor.Gatherer:GetAuctionInfo(itemLink, neutralAh, true)
		if (avgBuyout and avgBuyout > 0 and buyout and buyout > 0 and numAuctions >= minCount) then
			local avg = avgBuyout * count
			local profit = avg - buyout
			if (profit >= minProf) then
				local percent = math.floor(100.0 * profit / buyout + 0.5)
				if (percent >= snipeAverage) then
					local reason = L["Buyout for %s possible profit (%d%%)."]:format(vendor.Format.FormatMoney(profit, true), percent)
					return true, reason
				end
			end
		end		
		if (bid and bid > 0 and avgMinBid and avgMinBid > 0 and not highBidder and numAuctions >= minCount) then
			local avg = avgMinBid * count
			local profit = avg - bid
			if (profit >= minProf) then
				local percent = math.floor(100.0 * profit / bid + 0.5)
				if (percent >= snipeAverage) then
					local reason = L["Bid for %s possible profit (%d%%)."]:format(vendor.Format.FormatMoney(profit, true), percent)
					return true, reason
				end
			end
		end
	end
	return false
end

--[[
	Returns the unique identifier of the sniper.
--]]
function vendor.MarketPriceSniper.prototype:GetId()
	return "marketPriceSniper"
end

--[[
	Returns the name to be displayed for this sniper module.
--]]
function vendor.MarketPriceSniper.prototype:GetDisplayName()
	return L["Market prices"]
end

--[[
	Returns an ordering information for the sniper. Lower numbers will be executed first.
--]]
function vendor.MarketPriceSniper.prototype:GetOrder()
	return 3
end
