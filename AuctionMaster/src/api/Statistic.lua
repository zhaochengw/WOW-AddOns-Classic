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

-- Current version of the AuctionMaster Statistic API
AucMasStatisticVersion = {major = 1, minor = 1, patch = 0} 
AucMasStatisticVersionString = "1.1.0"

--[[
	Asks AuctionMaster for all time auction statistics for the specified 
	item. Will return nil, if nothing is known about the given item.
	The information is cached internally, the function may be called high frequently.
	@param itemLink blizzard's item link for selecting the item in question.
	@param neutralAh set this to true, if the statistics should be given for the neutral auction house.
	@return avgBid, avgBuyout, numAuctions, numBuyouts
--]]
function AucMasGetAuctionInfo(itemLink, neutralAh)
	return vendor.Gatherer:GetAuctionInfo(itemLink, neutralAh)
end

--[[
	Asks AuctionMaster for current auction statistics (lately seen in auction house) for the specified 
	item. Will return nil, if nothing is known about the given item.
	The information is cached internally, the function may be called high frequently.
	@param itemLink blizzard's item link for selecting the item in question.
	@param neutralAh set this to true, if the statistics should be given for the neutral auction house.
	@param adjustPrices Adjusts the prices to get rid off extreme values, if set to true.
	@return avgBid, avgBuyout, lowerBid, lowerBuyout, upperBid, upperBuyout, numAuctions, numBuyouts
--]]
function AucMasGetCurrentAuctionInfo(itemLink, neutralAh, adjustPrices)
	return vendor.Gatherer:GetCurrentAuctionInfo(itemLink, neutralAh, adjustPrices)
end

--[[
	Registers the given callback function for being informed each time AuctionMaster updates
	it's internal statistics for an item. The callback function will be called with the
	arg parameter as first argument.
--]]
function AucMasRegisterStatisticCallback(func, arg)
	vendor.Gatherer:RegisterStatisticCallback(func, arg)
end

-- GetAuctionBuyout support. See http://www.wowwiki.com/GetAuctionBuyout
local origGetAuctionBuyout = GetAuctionBuyout
function GetAuctionBuyout(itemLink)
	local sellval
	if (type(itemLink) == "number") then
		itemLink = vendor.Items:GetItemLink(itemLink)
	end
    if (type(itemLink) == "string") then
		local _, _, _, lowerBuyout = vendor.Gatherer:GetCurrentAuctionInfo(itemLink, false, true)
		if (lowerBuyout) then	
			sellval = lowerBuyout
		else
			local _, avgBuyout = vendor.Gatherer:GetAuctionInfo(itemLink, false, true)
			sellval = avgBuyout
		end
     end
     if (not sellval and origGetAuctionBuyout) then
          sellval = origGetAuctionBuyout(item)
     end
     return sellval
end
