--[[
	Handle for accessing the inventory.
	
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

vendor.InventoryHandle = {}
vendor.InventoryHandle.prototype = {}
vendor.InventoryHandle.metatable = {__index = vendor.InventoryHandle.prototype}

local L = vendor.Locale.GetInstance()

local log = vendor.Debug:new("InventoryHandle")

--[[ 
	Creates a new instance.
--]]
function vendor.InventoryHandle:new()
	local instance = setmetatable({}, self.metatable)
	return instance
end

--[[
	Updates the list of inventory items.
--]]
function vendor.InventoryHandle.prototype:Update()
	self.inventory = {};
	for bag = 0, 4 do
		for slot = 1, GetContainerNumSlots(bag) do
			local itemLink = GetContainerItemLink(bag, slot);
			if (itemLink) then
				log:Debug("found itemLink [%s]", vendor.Items:PrintItemLink(itemLink))
				local name, texture, stackCount = vendor.Items:GetItemData(itemLink)
				if (name) then
			 		local key = self:CreateItemKey(itemLink);
					local _, count = GetContainerItemInfo(bag, slot);
					-- check whether it's already in inventory
					local info = self.inventory[key];
					if (info) then
						-- just increase count
						info.count = info.count + count;
					else
						self.inventory[key] = {name = name, link = itemLink, stackCount = stackCount, texture = texture, count = count};
					end
				 end
			 end
		 end
	 end
end

--[[
	Retrieves information for the inventory item with the given item link.
	@Return name, link, stackCount, texture, count. name is nil if not found.
--]]
function vendor.InventoryHandle.prototype:GetItemInfo(itemLink)
	if (itemLink) then
		local key = self:CreateItemKey(itemLink);
		local info = self.inventory[key];
		if (info) then
			return info.name, info.link, info.stackCount, info.texture, info.count;
		end
	end	
	return nil;
end

--[[
	Creates a key for the given item link.
--]]
function vendor.InventoryHandle.prototype:CreateItemKey(itemLink)
	return vendor.Items:GetItemLinkKey(itemLink);
end

--[[
	Picksup a stack of the given size. Returns false if not possible and shows an
	error message for the user. Otherwise true will be returned.
--]]
function vendor.InventoryHandle.prototype:PickupItemStack(itemLink, stackCount)
	local stacks = {};
	local itemKey = self:CreateItemKey(itemLink);
	local sum = 0;
	-- create a table with all corresponding stacks available
	for bag = 0, 4 do
   		for slot = 1, GetContainerNumSlots(bag) do
	   		local slotLink = GetContainerItemLink(bag, slot);
	   		if (slotLink) then
		   		local slotKey = self:CreateItemKey(slotLink);
				if (itemKey == slotKey) then
					local _, count = GetContainerItemInfo(bag, slot);
					if (count == stackCount) then
						return self:Pickup(bag, slot);
					end
					table.insert(stacks, {bag = bag, slot = slot, count = count});
					sum = sum + count;
				end
			end
		end
	end
	-- if we are still here, we have to build a stack
	if (sum < stackCount) then
		vendor.Vendor:Error(L["Can't create stack of %d items, not enough available in inventory."]:format(stackCount));
		return nil;
	end
	-- try to fill a smaller stack up
	local bag, slot = self:FillSmallerStack(stacks, stackCount);
	if (not bag) then
		-- try to shrink a bigger one
		bag, slot = self:ShrinkBiggerStack(stacks, stackCount);
	end
	if (bag) then
		return self:Pickup(bag, slot);
	end
end

--[[
	Returns "bag, slot" for a newly created stack, that was build from a bigger
	one. Will return "nil" if not possible.
--]]
function vendor.InventoryHandle.prototype:ShrinkBiggerStack(stacks, stackCount)
	-- seach for an empty slot
	local empty = nil;
	local usableBagType = GetAuctionItemSubClasses(3);
	for bag = 0, 4 do
		if (empty) then
			break;
		end
		local isUsableBag = true;
		if (bag > 0) then
			local bagName = GetBagName(bag);
			local _, _, _, _, _, _, bagType = GetItemInfo(bagName);
			isUsableBag = bagType == usableBagType;
		end
		if (isUsableBag) then
 			for slot = 1, GetContainerNumSlots(bag) do
				local slotLink = GetContainerItemLink(bag, slot);
				if (not slotLink) then
					empty = {bag = bag, slot = slot};
					break;
				end
			end
		end
	end
	if (not empty) then
		vendor.Vendor:Error(L["Found no empty bag place for building a new stack."]);
	else
		-- move the surplus items to the empty slot
		local info = stacks[1];
		self:CheckLocked(info.bag, info.slot, empty.bag, empty.slot);
		SplitContainerItem(info.bag, info.slot, stackCount);
		if (not CursorHasItem()) then
			vendor.Vendor:Error(L["Error while picking up item."]);
			return nil;
		end
		PickupContainerItem(empty.bag, empty.slot);
		if (not self:WaitMove(empty.bag, empty.slot, stackCount, GetTime() + 7)) then
			vendor.Vendor:Error(L["Failed to create stack of %d items."]:format(stackCount));
			return nil;
		end
		return empty.bag, empty.slot;
	end
	return nil;
end

--[[
	Returns "bag, slot" for a newly created stack, that was build from a smaller
	one. Will return "nil" if not possible.
--]]
function vendor.InventoryHandle.prototype:FillSmallerStack(stacks, stackCount)
	-- seach for a smaller stack
	local smaller = nil;
	for key, info in ipairs(stacks) do
		if (info.count < stackCount) then
			smaller = info;
		end
	end
	if (smaller) then
		-- fill up smaller with other stacks
		for key, info in ipairs(stacks) do
			if (info.bag ~= smaller.bag or info.slot ~= smaller.slot) then
				local count = math.min(info.count, stackCount - smaller.count);
				self:CheckLocked(info.bag, info.slot, smaller.bag, smaller.slot);
				SplitContainerItem(info.bag, info.slot, count);
				if (not CursorHasItem()) then
					vendor.Vendor:Error(L["Error while picking up item."]);
					return nil;
				end
				PickupContainerItem(smaller.bag, smaller.slot);
				smaller.count = smaller.count + count;
				if (not self:WaitMove(smaller.bag, smaller.slot, smaller.count, GetTime() + 7)) then
					vendor.Vendor:Error(L["Failed to create stack of %d items."]:format(stackCount));
					return nil;					
				elseif (smaller.count == stackCount) then
					return smaller.bag, smaller.slot;
				end
			end
		end
	end
	return nil;
end

--[[
	Pickups the given item, waiting for it to be unlocked.
--]]
function vendor.InventoryHandle.prototype:Pickup(bag, slot)
	self:CheckLocked(bag, slot);
	PickupContainerItem(bag, slot);
	if CursorHasItem() then
		return bag, slot;
	end
	return nil;
end

--[[
	Waits for the given slot(s) to become available. Will only functions inside
	of coroutines. The second pair of bag coords is optional.
--]]
function vendor.InventoryHandle.prototype:CheckLocked(bag1, slot1, bag2, slot2)
	ClearCursor();
	while true do
		local _, _, locked1 = GetContainerItemInfo(bag1, slot1);
		local doWait = locked1;
		if (not doWait and bag2) then
			local _, _, locked2 = GetContainerItemInfo(bag2, slot2);
			doWait = locked2;
		end
		if doWait then
			coroutine.yield(); -- wait until the items are not locked
		else
			break; -- the items are not locked
		end
	end
end

--[[
	Waits for a move operation to be finished. Returns true if the items has moved,
	otherwise false.
--]]
function vendor.InventoryHandle.prototype:WaitMove(bag, slot, count, timeoutTime)
	while true do
		local _, itemCount, locked = GetContainerItemInfo(bag, slot);
		if (not locked and itemCount == count) then
			return true;
		end
		if (GetTime() >= timeoutTime) then
			return false;
		end
		coroutine.yield(); -- continue waiting
	end
end

--[[
	Waits a while for the slot to become empty. The method will block, but let
	other "threads" work with a call to coroutine.yield().
--]]
function vendor.InventoryHandle.prototype:WaitForEmptySlot(bag, slot, timeoutTime)
	while true do
		local itemLink = GetContainerItemInfo(bag, slot);
		if (not itemLink) then
			return true;
		end
		if (GetTime() >= timeoutTime) then
			return false;
		end
		coroutine.yield(); -- continue waiting
	end
end
