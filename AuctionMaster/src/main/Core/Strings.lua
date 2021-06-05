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
	Some helpers for strings.
--]]
vendor.Strings = {}

--[[
	Returns the 4-byte number found in the string at index i.
--]]
function vendor.Strings.GetNumber(str, i)
	local a, b, c, d = str:byte(i, i + 3)
	return a * 16777216 + b * 65536 + c * 256 + d
end

--[[
	Returns a 4-byte string representation of the given number.
--]]
function vendor.Strings.NumberToBytes(num)
	local a = math.floor(num / 16777216)
    num = math.fmod(num, 16777216)
    local b = math.floor(num / 65536)
    num = math.fmod(num, 65536)
    local c = math.floor(num / 256)
    local d = math.floor(math.fmod(num, 256))
--    return ":"..a..":"..b..":"..c..":"..d
    return string.char(a, b, c, d)            
end

--[[
	Null-byte safe strsplit function.
--]]
function vendor.Strings.StrSplit(delimiter, str)
	vendor.Strings.splitCache = wipe(vendor.Strings.splitCache or {})
	local splitCache = vendor.Strings.splitCache
	local prev = 1
	local index = strfind(str, delimiter, 1, true)
	while index do
		table.insert(splitCache, strsub(str, prev, index - 1))
		prev = index + 1
		index = strfind(str, delimiter, prev, true)
	end
	table.insert(splitCache, strsub(str, prev))
	return unpack(splitCache)
end
