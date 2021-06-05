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
	Widget for displaying a popup menu.
--]]

vendor.PopupMenu = {}
vendor.PopupMenu.prototype = {}
vendor.PopupMenu.metatable = {__index = vendor.PopupMenu.prototype}

--[[ 
	Sorts according to order value.
--]]
local function _SortEntries(a, b)
	return (a.order or 0) < (b.order or 0)
end

--[[
	Calls a setter func.
--]]
local function _CallSet(item, val, key)
	item.set({arg=item.arg, passValue=item.passValue}, val, key)
end

--[[
	Calls a getter func.
--]]
local function _CallGet(item, key)
	return item.get({arg=item.arg, passValue=item.passValue}, key)
end

--[[
	Toggle button callback.
--]]
local function _ToggleClicked(but, arg1, arg2, checked)
	local item = arg1
	-- we have to toggle the checked value
	local checked = not checked
	if (item.type == "multiselect") then
		if (checked) then
			-- deselect all others
			for k, v in pairs(item.values) do
				if (k ~= arg2 and _CallGet(item, k)) then
					_CallSet(item, false, k)
				end
			end
		else
			-- ensure that at least one other item is selected
			local hasOther = false
			for k, v in pairs(item.values) do
				if (k ~= arg2 and _CallGet(item, k)) then
					hasOther = true
					break
				end
			end
			if (not hasOther) then
				-- select first other
				for k, v in pairs(item.values) do
					if (k ~= arg2) then
						_CallSet(item, true, k)
						break
					end
				end
			end
		end
	end
	_CallSet(item, checked, arg2)
	-- hide the parent popup
	for i=1,LIB_UIDROPDOWNMENU_MENU_LEVEL-1 do
		getglobal("Lib_DropDownList"..i):Hide()
	end
end

local function _AddButton(info, text, value, disabled, func, notCheckable, checked, hasArrow, level, menuList, arg1, arg2)
	info.text = text
	info.value = value
	info.disabled = disabled
	info.func = func
	info.notCheckable = notCheckable
	info.checked = checked
	info.hasArrow = hasArrow
	info.arg1 = arg1
	info.arg2 = arg2
	info.menuList = menuList
	UIDropDownMenu_AddButton(info, level)
end

local function _InitItem(self, item, level)
	local info = self.info
	local disabled
	if (item.disabledFunc) then
  		disabled = item.disabledFunc()
   	end
	if (item.type == "execute") then
		_AddButton(info, item.text, nil, disabled, item.func, true, false, false, level, nil, item.arg, nil)
	elseif (item.type == "toggle") then
		local checked = _CallGet(item)
		_AddButton(info, item.text, item.value, disabled, _ToggleClicked, false, checked, false, level, nil, item, nil)
	elseif (item.type == "multiselect") then
		local values = {}
		for k, v in pairs(item.values) do
			table.insert(values, {k = k, v = v})
		end
		table.sort(values, function(a, b) return a.k < b.k end)
		for _, v in pairs(values) do
			local checked = _CallGet(item, v.k)
			_AddButton(info, v.v, item.value, disabled, _ToggleClicked, false, checked, false, level, nil, item, v.k)
		 end
	elseif (item.type == "group") then
     	local menuList = {}
   		for k,v in pairs(item.args) do
			table.insert(menuList, v)
		end
		table.sort(menuList, _SortEntries)
		_AddButton(info, item.text, item.text, disabled, item.func, true, false, true, level, menuList, item, nil)
	else
		assert(false)
	end
end

--[[
	Init function for blizzard's dropdown menu.
--]]
local function _DropDown_Initialize(frame, level, menuList, parentKey)
	level = level or 1
	local self = frame.obj
   	if (level == 1) then
    	for key, item in pairs(menuList) do
   			_InitItem(self, item, level)
     	end
    elseif (level == 2 and menuList ~= nil) then
    	for key, item in pairs(menuList) do
   			_InitItem(self, item, level)
     	end
	else
		assert(false)
   	end
end

--[[
	Adds the cmds to the frame.
--]]
local function _InitMenu(self)
	-- sort cmds
	local cmds = {}
	self.info = UIDropDownMenu_CreateInfo()
	for k,v in pairs(self.cmds) do
		v.arg1 = self.arg1
		table.insert(cmds, v)
	end
	table.sort(cmds, _SortEntries)
	-- create menu
 	self.frame = CreateFrame("Frame", self.frameName, UIParent, "UIDropDownMenuTemplate")
 	self.frame.obj = self
 	self.cmds = cmds
	UIDropDownMenu_Initialize(self.frame, _DropDown_Initialize, "MENU", 1, self.cmds)
end

--[[
	Creates a new instance. The command table has to have the following form:
	{
    	scan = {
    		type = "execute"
    		text = L["Scan"],
    		func = function() vendor.Scanner:Scan() end,
    		disabledFunc = function() return not vendor.Scanner:IsScanning() end,
    		order = 1
    	},
    	fast = {
    		type = "toggle"
    		text = L["Enable fast scan"],
    		func = function() vendor.Sniper:ToggleFast() end,
    		checked = true -- function returning boolean is also ok
    		get = function(name) => value
    		set = function(name, value)
    		passValue = name (string) 
    		order = 2
    	},
    	rows = {
    		type ="group"
    		text = "Rows"
    		args = {
            	fast = {
            		type = "toggle"
            		text = L["Enable fast scan"],
            		func = function() vendor.Sniper:ToggleFast() end,
            		checked = true -- function returning boolean is also ok
            		get = function(name) => value
            		set = function(name, value)
            		passValue = name (string) 
            		order = 2
            	},
    		}
    	}
    }
--]]
function vendor.PopupMenu:new(frameName, cmds, arg1)
	local instance = setmetatable({}, self.metatable)
	instance.nesting = 0
	instance.frameName = frameName
	instance.dropDownInitialize = _DropDown_Initialize
	instance.cmds = cmds
	instance.arg1 = arg1
	_InitMenu(instance)
	return instance
end

--[[
	Shows the popup menu
--]]
function vendor.PopupMenu.prototype:Show()
	ToggleDropDownMenu(nil, nil, self.frame, "cursor", -20, 0, self.cmds)
end
