--[[
	Executes tasks with the help of coroutines. The tasks has to implement
	a Run method and should implement a Failed method.
	
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

vendor.TaskQueue = vendor.Vendor:NewModule("TaskQueue");

local log = vendor.Debug:new("TaskQueue")

local function _CallFunc(task)
	if (task.func) then
		local result
		if (task.task.GetResult) then
			log:Debug("get result")
			result = task.task:GetResult()
		end
		log:Debug("callfunc with result: %s", result)
		task.func(task.arg1, result)
	end
end

--[[
	Executes the next task, or a piece of it.
--]]
local function _Progress(frame, delta)

	local self = frame.obj
	local numTasks = #self.tasks
	
	if (numTasks <= 0) then
		return
	end
	
	if (self.index > numTasks) then
		self.index = 1
	end
	
	local currentTask = self.tasks[self.index]
	if (currentTask.delay) then
		currentTask.delay = currentTask.delay - delta
		if (currentTask.delay > 0) then
			return
		end
	end
	currentTask.delay = nil
	
	local failedTask
	local success, delay = coroutine.resume(currentTask.co)
	log:Debug("success [%s] delay [%s]", success, delay)
	if (not success) then
		if (currentTask.task.Failed) then
			-- defer the handling to ensure correct removal
			failedTask = currentTask
			log:Debug("Task failed: \n" .. debugstack(2, 3, 2))
		end
		tremove(self.tasks, self.index)
		if (not failedTask) then
			_CallFunc(currentTask)
		end
	elseif (coroutine.status(currentTask.co) == 'dead') then
		-- the task has finished or failed
		tremove(self.tasks, self.index)
		_CallFunc(currentTask)
	else
		currentTask.delay = delay
	end
	if (failedTask) then
		failedTask.task:Failed()
		_CallFunc(failedTask)
	end
	
	self.index = self.index + 1
end

--[[
	Initializes the task queue.
--]]
function vendor.TaskQueue:OnEnable()
	-- a custom linked list, because a FIFO table wouldn't be efficient
	self.tasks = {}
	self.index = 1
	-- create a frame for progress events
	self.frame = CreateFrame("Frame")
	self.frame.obj = self
	self.frame:SetScript("OnUpdate", _Progress)	
end

--[[
	Adds a task to the queue, it will be executed by calling Progress regularly.
	The task has to implement the method:
	Run: Executes the task. It should call coroutine.yield() if it's a lengthy operation.
--]]
function vendor.TaskQueue:AddTask(task, func, arg1)
	local co = coroutine.create(function() task:Run() end)
	table.insert(self.tasks, {task = task, co = co, func = func, arg1 = arg1})
end

--[[
	Executes the given function as a concurrent task. The first argument will be arg.
--]]
function vendor.TaskQueue:Execute(func, arg)
	local task = vendor.SimpleTask:new(func, arg)
	local co = coroutine.create(function() task:Run() end)
	table.insert(self.tasks, {task = task, co = co})
end
