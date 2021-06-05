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
	Test framework.
--]]
vendor.Test = {}
vendor.Test.log = vendor.Debug:new("Test")

local log = vendor.Test.log
local tests = {}

--[[
	Adds a new test function.
--]]
function vendor.Test.AddTest(func, name)
	table.insert(tests, {func = func, name = name})
end

--[[
	Executes all test funcs.
--]]
function vendor.Test.Test()
	for i=1,#tests do
		log:Debug("Run [%s]...", tests[i].name)
		tests[i].func()
		log:Debug("Done [%s]", tests[i].name)
	end
end
