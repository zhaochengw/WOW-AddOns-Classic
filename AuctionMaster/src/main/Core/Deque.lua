--[[
	Organizes items in a double linked list.
	
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

vendor.Deque = {}
vendor.Deque.prototype = {}
vendor.Deque.metatable = {__index = vendor.Deque.prototype}

--[[ 
	Creates a new instance.
--]]
function vendor.Deque:new()
	local instance = setmetatable({}, self.metatable)
	return instance
end

--[[ 
	Adds the given element at the head of the queue.
--]]
function vendor.Deque.prototype:AddFirst(item)
	item.dequePrev = nil;
	item.dequeNext = self.first;
	self.first = item;
	if (not self.last) then
		self.last = item;
	end
end

--[[ 
	Returns the first element of the queue.
--]]
function vendor.Deque.prototype:GetFirst()
	assert(self.first);
	return self.first;
end

--[[ 
	Adds the given element at the end of the queue.
--]]
function vendor.Deque.prototype:AddLast(item)
	item.dequePrev = self.last;
	item.dequeNext = nil;
	self.last = item;
	if (not self.first) then
		self.first = item;
	end
end

--[[ 
	Removes the given element from the queue.
--]]
function vendor.Deque.prototype:Remove(item)
	if (item.dequePrev) then
		item.dequePrev.dequeNext = item.dequeNext;
	end
	if (item.dequeNext) then
		item.dequeNext.dequePrev = item.dequePrev;
	end
	if (self.first == item) then
		self.first = item.dequeNext;
	end
	if (self.last == item) then
		self.last = item.dequePrev;
	end
	item.dequeNext = nil;
	item.dequePrev = nil;
end

--[[ 
	Removes all elements.
--]]
function vendor.Deque.prototype:Clear()
	self.last = nil;
	self.first = nil;
end