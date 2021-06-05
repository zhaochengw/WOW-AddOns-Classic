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

vendor.StatisticDb = {}
vendor.StatisticDb.prototype = {}
vendor.StatisticDb.metatable = {__index = vendor.StatisticDb.prototype}

local log = vendor.Debug:new("StatisticDb")

local SEC_PER_DAY = 86400
local HIST_DAYS = 45

local function _GetStatisticIndex(self)
	local realmIndex = self.db.realms[self.realm]
	if (not realmIndex) then
		realmIndex = {}
		self.db.realms[self.realm] = realmIndex
	end
	local statIndex = realmIndex[self.faction]
	if (not statIndex) then
		statIndex = {}
		realmIndex[self.faction] = statIndex
	end
	return statIndex
end

local function _DecompressValues(valueStr, values)
	table.wipe(values)
	if (not valueStr) then
		return
	end
	
	local value
	local prevValue
	local idx = 0
	local prevIdx = 0
	while (idx ~= nil) do
		idx = string.find(valueStr, ":", idx + 1, true)
		log:Debug("decomp idx [%s] prevIdx [%s]", idx, prevIdx)
		-- all values has to be followed by a ":"
		if (idx ~= nil) then
			if (idx - prevIdx > 1) then
				log:Debug("extract [%s]",string.sub(valueStr, prevIdx + 1, idx - 1))
				value = tonumber(string.sub(valueStr, prevIdx + 1, idx - 1))
				if (prevValue ~= nil) then
					value = prevValue + value
				end
				log:Debug("value [%s]", value)
				tinsert(values, value)
				prevValue = value
			else
				tinsert(values, 0)			
			end
		end
		prevIdx = idx
	end
end

local function _CompressValues(values, startIdx)
	local rtn = ""
	local n = #values
	local value
	local prevValue = 0
	if (startIdx > n) then
		log:Debug("Compress failed: startIdx [%s] > n [%s]", startIdx, n)
	else
		for i=startIdx,n do
			value = values[i]
			if (value > 0) then
				rtn = rtn..(value - prevValue)..":"
			else
				rtn = rtn..":"
			end
			if (value ~= 0) then
				prevValue = value
			end
		end
	end
	return rtn;
end

local function _MoveCurrentValuesToHistory(info)
	local values = self.values
	if (#info.currentValues == 0) then
		-- no value for this day, this should never happen
		log:Debug("Error: found empty list")
	else
		table.sort(info.currentValues)
		local median = vendor.Math.GetMedian(info.currentValues)
		_DecompressValues(info.histValues, values)
		local lastDay = info.firstHistDay + #values - 1
		local startIdx = 1
		if (info.currentDay - lastDay >= HIST_DAYS) then
			-- too outdated, just remove all
			table.wipe(values)
			tinsert(values, median)
			info.firstHistDay = info.currentDay
		else
			-- add new values
			for d=lastDay+1,info.currentDay do
				tinsert(values, 0)
			end
			tinsert(values, median)
			-- cut off, if too long
			if (#values > HIST_DAYS) then
				startIdx = #values - HIST_DAYS + 1
				info.firstHistDay = info.firstHistDay + startIdx - 1
			end
		end
		info.histValues = _CompressValues(self.values, startIdx)
	end
	info.currentDay = vendor.currentDay()
	table.wipe(info.currentValues)
end

--[[ 
	Creates a new instance.
--]]
function vendor.StatisticDb:new(db)
	local instance = setmetatable({}, self.metatable)
	instance.db = db
	instance.realm = GetRealmName()
	instance.faction = UnitFactionGroup("player")
	instance.statIndex = _GetStatisticIndex(instance)
	instance.values = {}
	return instance
end

-- Adds a new value for TODAY
function vendor.StatisticDb.prototype:AddValue(itemLinkKey, value)
	local day = vendor.currentDay()
	local info = self.statIndex[itemLinkKey]
	if (not info) then
		info = {currentDay = day, currentValues = {}}
		self.statIndex[itemLinkKey] = info
	end
	if (info.currentDay ~= day) then
		_MoveCurrentValuesToHistory(info)
	end
end

function vendor.StatisticDb.prototype:Test()
	log:Debug("Test")
	local info = {currentDay = day, currentValues = {}}
	local values = self.values
	local str
	
	-- decompress empty hist value
	_DecompressValues(info.histValues, values)
	assert(0 == #values)
	
	-- test some values
	local vals = {}
	tinsert(vals, 10)
	tinsert(vals, 0)
	tinsert(vals, 17)
	tinsert(vals, 0)
	tinsert(vals, 1000)
	tinsert(vals, 1000)
	tinsert(vals, 0)
	str = _CompressValues(vals, 1)
	assert("10::7::983:0::" == str)
	_DecompressValues(str, values)
	assert(7 == #values)
	for i=1,7 do
		assert(vals[i] == values[i])
	end
	
	-- test with offset
	str = _CompressValues(vals, 2)
	log:Debug("compressed [%s]", str)
	assert(":17::983:0::" == str)
	_DecompressValues(str, values)
	assert(6 == #values)
	for i=1,6 do
		assert(vals[i + 1] == values[i])
	end
end