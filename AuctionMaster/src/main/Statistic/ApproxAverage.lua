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
	Stores average values by approximating a moving average
--]]
vendor.ApproxAverage = {}
vendor.ApproxAverage.prototype = {}
vendor.ApproxAverage.metatable = {__index = vendor.ApproxAverage.prototype}

local APPROX_AVG_TYPE = 1

--[[ 
	Creates a new instance.
--]]
function vendor.ApproxAverage:new(numMoving)
	local instance = setmetatable({}, self.metatable)
	instance.numMoving = math.min(numMoving, 365)
	return instance
end

--[[
	Adds a new value to the given string representation and return a new 
	string representation.
--]]
function vendor.ApproxAverage.prototype:AddValue(data, value)
	local num, old = self:GetInfo(data)
	local avg = value
	if (old) then
		if (num > self.numMoving) then
			avg = (old * self.numMoving + value) / (self.numMoving + 1)
		else
			avg = (old * num + value) / (num + 1)
		end
	end
	return string.char(APPROX_AVG_TYPE)..vendor.Strings.NumberToBytes(num + 1)..vendor.Strings.NumberToBytes(avg)
end

--[[
	Returns numValues, avgValue
--]]
function vendor.ApproxAverage.prototype:GetInfo(data)
	local num = 0
	local avg = nil 
	if (data and data:len() > 0) then
		assert(data:len() == 9)
		local avgType = data:byte(1)
		if (avgType == APPROX_AVG_TYPE) then
			num = vendor.Strings.GetNumber(data, 2)
			avg = vendor.Strings.GetNumber(data, 6)
		end
	end
	return num, avg
end
