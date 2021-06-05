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
	Base type for all item table cells.
--]]
vendor.ItemTableCell = {}
vendor.ItemTableCell.prototype = {}
vendor.ItemTableCell.metatable = {__index = vendor.ItemTableCell.prototype}

--[[ 
	Creates a new instance.
--]]
function vendor.ItemTableCell:new()
	local instance = setmetatable({}, self.metatable)
	return instance
end

--[[
	Sets the given new width of the cell.
--]]
function vendor.ItemTableCell.prototype:SetWidth(width)
	self.width = width
	self.frame:SetWidth(width)
end

function vendor.ItemTableCell.prototype:Show()
	self.frame:Show()
end

function vendor.ItemTableCell.prototype:Hide()
	self.frame:Hide()
end
