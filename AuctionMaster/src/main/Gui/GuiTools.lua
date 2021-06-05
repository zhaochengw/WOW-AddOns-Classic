--[[
	Some helpers for handling the GUI.
	
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

vendor.GuiTools = {};
local nextId = 0

local AceGUI = LibStub("AceGUI-3.0", true)

local function _CreateDropDown(widgetType, parent, width, title, tooltipText)
	local dropDown = AceGUI:Create(widgetType)
	dropDown.frame:SetParent(parent)
	dropDown:SetWidth(width)
	
	if (title) then
		local f = parent:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
		f:SetText(title)
		f:SetPoint("BOTTOMLEFT", dropDown.frame, "TOPLEFT", 4, 0)
		dropDown.title = f
	end

	if (tooltipText) then
		vendor.GuiTools.AddTooltip(dropDown.frame, tooltipText)
	end
	
	dropDown.Enable = function(self)
		self:SetDisabled(false)
	end
	dropDown.Disable = function(self)
		self:SetDisabled(true)
	end
	
	return dropDown
end

--[[
	Shows the given frame as a modal dialog. The call will return after the frame
	has closed again. Will function for calls outside of coroutines. 
--]]
function vendor.GuiTools.ShowModal(frame)
	frame:Show();
	local co = coroutine.create(function() task:Run() end);
	while (true) do
		if (frame:IsShown()) then
			coroutine.yield(); -- continue waiting
		else
			return;
		end
	end	
end

--[[
	Creates the specified widget and sets the specified parameters accordingly.
--]]
function vendor.GuiTools.CreateWidget(widgetType, name, parent, template, width, height, tooltipText)
	name = vendor.GuiTools.EnsureName(name)
	local bt = CreateFrame(widgetType, name, parent, template);
	bt:SetWidth(width);
	bt:SetHeight(height);
	vendor.GuiTools.AddTooltip(bt, tooltipText);
	return bt;
end

--[[
	Creates a button and sets the specified parameters accordingly.
--]]
function vendor.GuiTools.CreateButton(parent, template, width, height, text, tooltipText)
	local name = vendor.GuiTools.EnsureName()
	local bt = CreateFrame("Button", name, parent, template);
	bt:SetText(text);
	bt:SetWidth(width);
	bt:SetHeight(height);
	vendor.GuiTools.AddTooltip(bt, tooltipText);
	return bt;
end

--[[
	Creates a checkbox and sets the specified parameters accordingly.
--]]
function vendor.GuiTools.CreateCheckButton(name, parent, template, width, height, checked, tooltipText)
	name = vendor.GuiTools.EnsureName(name)
	local bt = CreateFrame("CheckButton", name, parent, template)
	bt:SetWidth(width)
	bt:SetHeight(height)
	bt:SetChecked(checked)
	vendor.GuiTools.AddTooltip(bt, tooltipText)
	return bt
end

--[[
	Creates a texture and sets the specified parameters accordingly.
--]]
function vendor.GuiTools.CreateTexture(name, parent, layer, file, width, height)
	name = vendor.GuiTools.EnsureName(name)
	local texture = parent:CreateTexture(name, layer)
	texture:SetTexture(file)
	texture:SetWidth(width)
	texture:SetHeight(height)
	return texture
end

-- Creates a AceGUI DropDown. 
function vendor.GuiTools.CreateDropDown(parent, width, title, tooltipText)
	return _CreateDropDown("Dropdown", parent, width, title, tooltipText)
end

-- Creates a custom editable AceGUI DropDown. 
function vendor.GuiTools.CreateEditDropDown(parent, width, title, tooltipText)
	return _CreateDropDown("EditDropdown", parent, width, title, tooltipText)
end

--[[
	Adds a tooltip to the given gui elemnt.
--]]
function vendor.GuiTools.AddTooltip(obj, tooltipText)
	if (tooltipText) then
    	obj.tooltipText = tooltipText
    	obj:SetScript("OnEnter", function(but) 
    		GameTooltip_SetDefaultAnchor(GameTooltip, but) 
    		GameTooltip:SetText(but.tooltipText, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, 1, true)
    		GameTooltip:Show()
    	end)
    	obj:SetScript("OnLeave", function() GameTooltip:Hide() end)
    end	
end

--[[
	Sets the color of the given texture.
--]]
function vendor.GuiTools.SetColor(texture, col)
	texture:SetColorTexture(col.r, col.g, col.b, col.a)
end

--[[
	Tries to release the resources of the given frame.
--]]
function vendor.GuiTools.ReleaseFrame(frame)
	if (frame) then
		frame:ClearAllPoints()
		frame:Hide()
		frame:SetScale(0.000001) -- just in case...
	end
end

--[[
	Creates a name, if the given one is nil
--]]
function vendor.GuiTools.EnsureName(name)
	if (not name) then
		-- some widgets do need a name
		return "AucMasName"..vendor.GuiTools.GetNextId()
	end
	return name
end
	
--[[
	Returns an unique identifier since start.
--]]
function vendor.GuiTools.GetNextId()
	nextId = nextId + 1
	return nextId
end

