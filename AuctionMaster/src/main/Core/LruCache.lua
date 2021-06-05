--[[
	Offsers a least recently used cache.
	
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

vendor.LruCache = {}
vendor.LruCache.prototype = {}
vendor.LruCache.metatable = {__index = vendor.LruCache.prototype}

--[[
	Creates an empty cache with the given maximal size. 
--]]
function vendor.LruCache:new(maxElems)
	local instance = setmetatable({}, self.metatable)
	assert(maxElems > 0)
	instance.maxElems = maxElems
	instance.map = {}
	instance.deque = vendor.Deque:new()
	instance.size = 0
	return instance
end

--[[ 
	Adds the given element, removing one if the maximal size has been reached.
--]]
function vendor.LruCache.prototype:Put(key, val)
	local oldVal = self.map[key];
	if (oldVal) then
		self.deque:Remove(val);
		self.deque:AddLast(val);
		self.map[key] = val;
	else
		if (self.size >= self.maxElems) then
			local del = self.deque:GetFirst();
			self.deque:Remove(del);
			self.map[del.lruKey] = nil;
			self.size = self.size - 1;
		end
		self.deque:AddLast(val);
		val.lruKey = key;
		self.map[key] = val;
		self.size = self.size + 1;
	end
end

--[[ 
	Returns the element with the given key, if any.
--]]
function vendor.LruCache.prototype:Get(key)
	local val = self.map[key];
	if (val) then
		self.deque:Remove(val);
		self.deque:AddLast(val);
	end
	return val;
end

--[[ 
	Removes the given element.
--]]
function vendor.LruCache.prototype:Remove(key)
	local val = self.map[key];
	if (val) then
		self.deque:Remove(val);
		self.map[key] = nil;
		self.size = self.size - 1;
	end
end

--[[ 
	Removes all elements.
--]]
function vendor.LruCache.prototype:Clear()
	self.map = {};
	self.deque:Clear();
	self.size = 0;
end
