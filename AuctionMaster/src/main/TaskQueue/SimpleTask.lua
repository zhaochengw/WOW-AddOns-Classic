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
	A simple task, that just performs the given function in it's run method.
--]]
vendor.SimpleTask = {}
vendor.SimpleTask.prototype = {}
vendor.SimpleTask.metatable = {__index = vendor.SimpleTask.prototype}

--[[ 
	Creates a new instance.
--]]
function vendor.SimpleTask:new(func, arg)
	local instance = setmetatable({}, self.metatable)
	instance.func = func
	instance.arg = arg
	return instance
end

--[[
	Run function of the task, performs the scan.
--]]
function vendor.SimpleTask.prototype:Run()
	self.func(self.arg)
end

--[[
	Cancels the task and leaves it as soon as possible. 
--]]
function vendor.SimpleTask.prototype:Cancel()
	-- nothing to be done
end

--[[
	Returns whether the task was canecelled.
--]]
function vendor.SimpleTask.prototype:IsCancelled()
	return false
end

--[[
	Will be called by the TaskQueue, if the task has failed with an 
	unexpected error.
--]]
function vendor.SimpleTask.prototype:Failed()
	-- nothing to be done 
end
