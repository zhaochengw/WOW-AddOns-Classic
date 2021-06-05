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
	Asynchronously archives a scan.
--]]
vendor.ArchiveTask = {}
vendor.ArchiveTask.prototype = {}
vendor.ArchiveTask.metatable = {__index = vendor.ArchiveTask.prototype}

local log = vendor.Debug:new("ArchiveTask")

--[[ 
	Creates a new instance.
--]]
function vendor.ArchiveTask:new(scan)
	local instance = setmetatable({}, self.metatable)
	instance.scan = scan
	return instance
end

--[[
	Run function of the task.
--]]
function vendor.ArchiveTask.prototype:Run()
	vendor.Gatherer:ArchiveScan(self.scan)
end

--[[
	Cancels the task and leaves it as soon as possible. 
--]]
function vendor.ArchiveTask.prototype:Cancel()
	self.isCancelled = true
	self.isRunning = false
end

--[[
	Returns whether the task was canecelled.
--]]
function vendor.ArchiveTask.prototype:IsCancelled()
	return self.isCancelled
end

--[[
	Will be called by the TaskQueue, if the task has failed with an 
	unexpected error.
--]]
function vendor.ArchiveTask.prototype:Failed()
	log:Debug("failed")
	self:Cancel()
end
