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
	Tests Strings
--]]
local log = vendor.Test.log

local function _Test()
	local str = "a;b;c;d"
	local delimiter = ";"
	local a, b, c, d, e = vendor.Strings.StrSplit(delimiter, str)
	assert("a" == a)
	assert("b" == b)
	assert("c" == c)
	assert("d" == d)
	assert(not e)
	str = "a;;;"
	a, b, c, d, e = vendor.Strings.StrSplit(delimiter, str)
	assert("a" == a)
	assert("" == b)
	assert("" == c)
	assert("" == d)
	assert(not e)
end

vendor.Test.AddTest(_Test, "StringsTest")