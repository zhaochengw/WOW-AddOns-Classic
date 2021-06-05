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

local log = vendor.Test.log

local function _StatisticCallback(arg)
	log:Debug("_StatisticCallback arg: [%s]", arg)
end

--[[
	Runs the test method
--]]
local function _Test()
	local itemName, itemLink = GetItemInfo(33470)
	local avgBid, avgBuyout, lowerBid, lowerBuyout, upperBid, upperBuyout, numAuctions, numBuyouts
		= AucMasGetCurrentAuctionInfo(itemLink, false, true)
	log:Debug("Frostweave current stats: avgBid: %s avgBuyout: %s lowerBid: %s lowerBuyout: %s upperBid: %s upperBuyout: %s numAuctions: %s numBuyouts: %s", avgBid, avgBuyout, lowerBid, lowerBuyout, upperBid, upperBuyout, numAuctions, numBuyouts)
	local avgBid, avgBuyout, numAuctions, numBuyouts
		= AucMasGetAuctionInfo(itemLink, false)
	log:Debug("Frostweave all time stats: avgBid: %s avgBuyout: %s numAuctions: %s numBuyouts: %s", avgBid, avgBuyout, numAuctions, numBuyouts)
	AucMasRegisterStatisticCallback(_StatisticCallback, "this is what I want to see")
end

-- registers the test method
vendor.Test.AddTest(_Test, "ApiTest")
