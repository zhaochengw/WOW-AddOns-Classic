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
	Cell object for rendering texts. Input for the cell is:
	text
--]]
vendor.TextCell = {}
vendor.TextCell.prototype = {}
vendor.TextCell.metatable = {__index = vendor.TextCell.prototype}
setmetatable(vendor.TextCell.prototype, {__index = vendor.ItemTableCell.prototype})

--[[
	Shows information if mouse is over the selected item
--]]
local function _OnEnterItem(but)
	local self = but.obj
	if (self.tooltip) then
		GameTooltip:SetOwner(but, "ANCHOR_RIGHT")
		GameTooltip:SetText(self.tooltip, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, 1, true)
	end
end

--[[
	Initializes the cell.
--]]
local function _Init(self)
	local frame = CreateFrame("Button", nil, self.parent)
	frame.obj = self
	frame:EnableMouse(true)
	frame:SetWidth(self.width)
	frame:SetHeight(self.height)
	frame:SetScript("OnEnter", _OnEnterItem)
	frame:SetScript("OnLeave", function() GameTooltip:Hide() end)
	local f = self.parent:CreateFontString(nil, "BACKGROUND", "GameFontHighlightSmall")
	f:SetAllPoints(frame)
	if (self.align) then
		f:SetJustifyH(self.align)
	end
	self.frame = frame
	self.fontString = f
end

--[[ 
	Creates a new instance.
--]]
function vendor.TextCell:new(parent, width, height, align)
	local instance = setmetatable({}, self.metatable)
	instance.parent = parent
	instance.width = width
	instance.height = height
	instance.align = align
	_Init(instance)
	return instance
end

--[[
	Updates the cell with the required input parameters of the cell.
--]]
function vendor.TextCell.prototype:Update(text, tooltip)
	if (text and self.align == "LEFT") then
		text = " "..text
	end	
	self.fontString:SetText(text or "")
	self.tooltip = tooltip
end
