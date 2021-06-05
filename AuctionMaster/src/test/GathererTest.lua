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

local EPS = 0.0001

--[[
	Runs the test method
--]]
local function _Test()
	local bidAvg = vendor.ApproxAverage:new(30)
	local backup = {}
	local itemInfo = {}
	local itemLinkKey = "2592:0:0:0:0:0"
	if (not vendor.Items:GetItemInfo(itemLinkKey, itemInfo, false)) then
		log:Debug("init itemInfo")
		vendor.Items:InitItemInfo(itemInfo)
		vendor.Items:InitItemInfo(backup)
	else
		log:Debug("itemInfo found avgMinBid: %d", itemInfo.avgMinBid or 777)
		vendor.Items:GetItemInfo(itemLinkKey, backup, false)
	end
	
	-- set new avgBid
	itemInfo.avgBidData = bidAvg:AddValue(nil, 1000)
	assert(9 == itemInfo.avgBidData:len())
	vendor.Items:PutItemInfo(itemLinkKey, false, itemInfo)
	
	-- read back value
	assert(vendor.Items:GetItemInfo(itemLinkKey, itemInfo, false))
	assert(9 == itemInfo.avgBidData:len())
	local num, value = bidAvg:GetInfo(itemInfo.avgBidData)
	assert(1 == num)
	assert(math.abs(1000 - value) <= EPS)
	
	-- check approx moving average
	local data = bidAvg:AddValue(itemInfo.avgBidData, 100)
	-- result is (1000 + 100) / 2 = 550
	num, value = bidAvg:GetInfo(data)
	assert(2 == num)
	assert(math.abs(value - 550) <= EPS)
	
	-- revert changes
	vendor.Items:PutItemInfo(itemLinkKey, false, backup)
	
	-- check cleanup
	log:Debug("test cleanup by standard deviation")
	local vals = {}
	table.insert(vals, 4000)
	for i=1,20 do
		table.insert(vals, 4200)
	end
	vendor.Math.CleanupByStandardDeviation(vals, 2, 2)
	assert(21 == #vals)
	
	-- test local functions of StatisticDb
	vendor.Gatherer.statisticDb:Test()
end

-- registers the test method
vendor.Test.AddTest(_Test, "GathererTest")
