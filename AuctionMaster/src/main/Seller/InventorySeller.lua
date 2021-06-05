--[[
	Copyright (C) Ordo Lunaris (Blackhand)
	
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
	Manages the inventory list.
--]]
vendor.InventorySeller = {}
vendor.InventorySeller.prototype = {}
vendor.InventorySeller.metatable = {__index = vendor.InventorySeller.prototype}

--[[
	Selects the item at the given row for selling.
--]]
local function _SelectItem(row, self)
	local itemLink = select(2, self.itemModel:Get(row))
	if (itemLink) then
		vendor.Seller:SelectInventoryItem(itemLink)
	end 
end

--[[
	Initialization of the Item Model
--]]
local function _Init(self)
	self.itemModel = vendor.InventoryItemModel:new()
	local cmds = {}
	local cfg = {
		name = self.name,
		parent = self.frame,
		itemModel = self.itemModel,
		cmds = cmds,
		config = self.config,
		width = 609,
		height = 358,
		xOff = 214,
		yOff = -51, 
		sizable = true,
		resizeFunc = self.resizeFunc, 
		resizeArg = self.resizeArg,
	}
	self.itemTable = vendor.ItemTable:new(cfg)
	self.itemModel:SetItemTable(self.itemTable)
	self.itemTable:SetDoubleClickCallback(_SelectItem, self)
end


--[[ 
	Creates a new instance.
--]]
function vendor.InventorySeller:new(frame, config, resizeFunc, resizeArg)
	local instance = setmetatable({}, self.metatable)
	instance.frame = frame
	instance.config = config
	instance.resizeFunc = resizeFunc
	instance.resizeArg = resizeArg
	instance.name = "AMSellerInventory"
	_Init(instance)
	return instance
end

--[[
	Show the item table
--]]
function vendor.InventorySeller.prototype:Show()
	self.itemTable:Show()
end

--[[
	Trigger an update of the inventory tab
--]]
function vendor.InventorySeller.prototype:UpdateInventory()
	self.itemModel:Update()
end

--[[
	Sets a new percentage size from 0 up to 100 for the table.
--]]
function vendor.InventorySeller.prototype:SetSize(size)
	self.itemTable:SetSize(size)
end
