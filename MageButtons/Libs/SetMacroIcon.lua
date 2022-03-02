-- Lib Name: SetMacroIcon
-- Version: 7.703
-- Author: Bank Norris
-- License: Public Domain
-- Warning: This file was written by a Brazilian
-------------------------------------------------
-- Usage:
-- In your .toc file have this line inserted before the .lua files that will use the API functions:
--|Libs\SetMacroIcon.lua
-------------------------------------------------
-- The API is:
--|SetMacroIcon(macro_name_or_index,icon_file)
--|ResetMacroIcon(macro_name_or_index)
--|GetMacroIcon(macro_name_or_index)
--|SetMacroSpell(macro_name_or_index,spell_name,target)
--|SetMacroItem(macro_name_or_index,item_name,target)
--|SetMacroStatus(macro_name_or_index,status) --status is either "enabled" or "disabled"
-------------------------------------------------
--|addon_table.fix_tooltip(macro_name,override_icon) --this is an optional user made addon-scope function that will be called (if it exists) to change the tooltip for override icons
--|		the function will be called with macro_name and override_icon parameters and should set the GameTooltip based on those informations (probably calling GameTooltip:SetSpellByID() or such)
-------------------------------------------------

if SetMacroIcon then return end

local _,addon_table = ...

-- local reference of Global functions
local pairs = pairs
local next = next
local type = type
local tonumber = tonumber
local string_upper = string.upper
local hooksecurefunc = hooksecurefunc
local GetActionInfo = GetActionInfo
local GetMacroIndexByName = GetMacroIndexByName
local GetMacroInfo = GetMacroInfo
local SetMacroSpell_original = SetMacroSpell
local SetMacroItem_original = SetMacroItem
local GameTooltip = GameTooltip

--local functions
local get_macro_name
local get_button_macro_name
local hook_all_actionbuttons
local SetTexture_hook --this function will be hooked on SetTexture method of all check buttons (only the first time SetMacroIcon is used with valid data)
local SetVertexColor_hook
local CreateFrame_hook --this functin will be hooked on CreateFrame (only the first time SetMacroIcon is used with valid data)

--local tables
local action_buttons = {} --this table contains the check button as the key and a table as a value (the table will be either empty or contain the original texture)
local macro_override_icon = {} --this table contains only macros whose icons should be overriden as the key and the override icon as the value
local macro_status = {}
local macro_by_button = {}
local buttons_by_macro = {}

--local boolean variables
local buttons_hooked --indicates the first (and normally the only) button scan has already been performed
local pending_new_buttons
local texture_hook_safe = true --only false inside the hook function to prevent infinite loop (since the hooked function calls the function it is hooked to)
local vertex_hook_safe = true

function get_macro_name(macro_name_or_index)
	--all macro api functions that accepts both a name or an index will consider the name "1" (just an example) as the index 1
	--and so does this function, to keep it consitent with the others, even though I dislike this behavior
	macro_name_or_index = tonumber(macro_name_or_index) or macro_name_or_index
	local macro_name
	if type(macro_name_or_index)=="string" then
		macro_name = GetMacroIndexByName(macro_name_or_index)>0 and macro_name_or_index
	elseif type(macro_name_or_index)=="number" then
		macro_name = GetMacroInfo(macro_name_or_index)
	end
	return macro_name
end

function get_button_macro_name(button)
	local action_index,macro_index
	local button_type = button:GetAttribute("type") --the relevant types are "action" (because an action can contain a macro) or "macro"
	if button_type=="action" then --if the button has an action, identify if it is a macro and in positive case gets its index
		action_index = button:GetAttribute("action") or button.action --standard UI will use button.action
		if action_index then --in Dominos at least this will be nil if its action button is empty (while in Bartender4 it will always point to an action), so this checking is necessary
			local action_type,id = GetActionInfo(action_index)
			if action_type=="macro" then
				macro_index = id
			end
		end --at this point, macro_index will be nil if the action does not contain a macro
	elseif button_type=="macro" then
		macro_index = button:GetAttribute("macro")
	end
	return GetMacroInfo(macro_index),action_index --action_index must be returned because SetTexture_hook will need it for tooltip
end

-- this function will make buttons show a specified override icon when they have the specified macro
-- if argument icon_file is nil the effect is cancelled
-- the very first call of SetMacroIcon will cause a small lag (caused by hook_all_actionbuttons(UIParent))
function SetMacroIcon(macro_name_or_index,icon_file)
	local macro_name = get_macro_name(macro_name_or_index)
	if macro_name and icon_file~=macro_override_icon[macro_name] then --to forbid setting the same icon more than once in row or to remove the override icon more than once in a row (for the same macro)
		if icon_file and not buttons_hooked then --the following block will only run the first time SetMacroIcon is called with valid data
			hook_all_actionbuttons() --scans all checkbuttons in the UI
			hooksecurefunc("CreateFrame",CreateFrame_hook) --if new checkbuttons are created after the first scan we need to know (to make another scan, which will be throttled)
			buttons_hooked = true --the button scan will not run again unless new checkbuttons are created (but in this case, buttons_hooked will not become false)
		end
		macro_override_icon[macro_name] = icon_file
		if buttons_by_macro[macro_name] then
			for k,v in pairs(buttons_by_macro[macro_name]) do
				SetTexture_hook(k.icon)
			end
		end
	end
end

function ResetMacroIcon(macro_name_or_index)
	return SetMacroIcon(macro_name_or_index,nil)
end

-- this function will return the override icon set for the specified macro
-- or nil if there is not override icon defined
function GetMacroIcon(macro_name_or_index)
	local macro_name = get_macro_name(macro_name_or_index)
	return macro_override_icon[macro_name]
end

-- this is function will cancel the override icon
-- and then call the original SetMacroSpell
function SetMacroSpell(macro_name_or_index,spell_name,target)
	local macro_name = get_macro_name(macro_name_or_index)
	if macro_name then
		ResetMacroIcon(macro_name) --disable the overriding icon
		macro_status[macro_name] = nil --disable the overriding status
	end
	return SetMacroSpell_original(macro_name_or_index,spell_name,target)
end

-- this is function will cancel the override icon
-- and then call the original SetMacroItem
function SetMacroItem(macro_name_or_index,item_name,target)
	local macro_name = get_macro_name(macro_name_or_index)
	if macro_name then
		ResetMacroIcon(macro_name) --disable the overriding icon
		macro_status[macro_name] = nil --disable the overriding status
	end
	return SetMacroItem_original(macro_name_or_index,item_name,target)
end

function SetMacroStatus(macro_name_or_index,status)
	local macro_name = get_macro_name(macro_name_or_index)
	if macro_name then
		macro_status[macro_name] = status
		if status and buttons_by_macro[macro_name] then
			for k,v in pairs(buttons_by_macro[macro_name]) do
				SetVertexColor_hook(k.icon)
			end
		end
	end
end

--if there is currently no macros with an override icon, this hook will just check a boolean and leave
function SetTexture_hook(self,texture)
	if texture_hook_safe then --if the hook is not being self called then
		texture_hook_safe = false -- to avoid infinite loop since SetTexture_hook calls SetTexture
		local button
		button = self:GetParent() --self is actually button.icon (see function hook_all_actionbuttons)
		--if the texture is not nil (it will be nil when SetTexture_hook is called from SetMacroIcon) then stores it as the original_texture of the button
		--if the texture is nil then keep the original_texture value if it exists or stores the current button texture as the original texture of the button
		if texture then
			action_buttons[button].original_texture = texture
		elseif not action_buttons[button].original_texture then
			action_buttons[button].original_texture = self:GetTexture()
		end
		local macro_name,action_index = get_button_macro_name(button)
		local old_macro_name = macro_by_button[button]
		if old_macro_name and old_macro_name~=macro_name then
			buttons_by_macro[old_macro_name][button] = nil
		end
		macro_by_button[button] = macro_name
		if macro_name then
			if buttons_by_macro[macro_name]==nil then
				buttons_by_macro[macro_name] = {}
			end
			buttons_by_macro[macro_name][button] = true
		end
		local override_icon = macro_override_icon[macro_name] --GetMacroInfo returns nil if the argument is nil
		if override_icon then -- if the the action button has a macro and that macro is marked to show another icon then
			--IMPORTANT: this will cause SetTexture_hook to be called but texture_hook_safe being false will prevent the infinite loop
			self:SetTexture(override_icon) --puts the override icon in place of the original macro icon in the button
			button.Border:SetAlpha(0) --makes the eventual original green border for equipped items not visible
			button.Count:SetAlpha(0) --makes the original count number not visible
		else
			--IMPORTANT: this will cause SetTexture_hook to be called but texture_hook_safe being false will prevent the infinite loop
			self:SetTexture(action_buttons[button].original_texture) --puts back the original texture if no override icon was found (this code does not check if the current texture was not already correct)
			button.Border:SetAlpha(0.35) --makes the eventual original green border for equipped items visible
			button.Count:SetAlpha(1) --makes the original count number visible (does not check if alpha was already 1)
		end
		if button==GameTooltip:GetOwner() then
			if macro_name and addon_table.fix_tooltip and override_icon then
				addon_table.fix_tooltip(macro_name,override_icon)
			elseif action_index then
				GameTooltip:SetAction(action_index)
			end
		end
		texture_hook_safe = true --flag indicationg that next call to SetTexture_hook is not from itself (since this function calls SetTexture)
	end
end

function SetVertexColor_hook(button_icon)
	if vertex_hook_safe then
		vertex_hook_safe = false
		local macro_name = macro_by_button[button_icon:GetParent()]
		if macro_name then
			if macro_status[macro_name]=="enabled" then
				button_icon:SetVertexColor(1.0,1.0,1.0)
			elseif macro_status[macro_name]=="disabled" then
				button_icon:SetVertexColor(0.4,0.4,0.4)
			end
		end
		vertex_hook_safe = true
	end
end

function CreateFrame_hook(frame_type,_,_,frame_template)
	if not pending_new_buttons then
		if string_upper(frame_type)=="CHECKBUTTON" and frame_template and string_upper(frame_template):match("ACTIONBUTTONTEMPLATE") then
			C_Timer.After(0,hook_all_actionbuttons) --to prevent hook_all_actionbuttons being called several times if several checkbuttons are created at once
			pending_new_buttons = true
		end
	end
end

do
local last_frame
function hook_all_actionbuttons()
	local frame = EnumerateFrames(last_frame)
	while frame do
		local frame_type = frame:GetObjectType()
		if frame_type=="CheckButton" and frame.GetAttribute and frame.icon and frame.Border and frame.Count then --checks if this button could contain a macro
			action_buttons[frame] = {} --original_texture of the button will be stored here
			SetTexture_hook(frame.icon) --probably needed to this so the first SetMacroIcon works imediately
			hooksecurefunc(frame.icon,"SetTexture",SetTexture_hook) --hooks the button.icon:SetTexture
			hooksecurefunc(frame.icon,"SetVertexColor",SetVertexColor_hook) --hooks the button.icon:SetVertexColor
		end
		last_frame = frame
		frame = EnumerateFrames(frame)
	end
	pending_new_buttons = false
end
end

hooksecurefunc("EditMacro",function(old_name_or_index,new_name)
	old_name_or_index = tonumber(old_name_or_index) or old_name_or_index
	if type(old_name_or_index)=="string" then
		local old_name = old_name_or_index
		if macro_override_icon[old_name] and new_name then
			if GetMacroIndexByName(old_name)==0 then
				if not macro_override_icon[new_name] then
					macro_override_icon[new_name] = macro_override_icon[old_name]
					if buttons_by_macro[new_name] then
						for k,v in pairs(buttons_by_macro[new_name]) do
							k.icon:SetTexture(macro_override_icon[new_name])
						end
					end
				end
				macro_override_icon[old_name] = nil
			end
		end
	elseif type(old_name_or_index)=="number" then
		if new_name then
			for k,v in pairs(macro_override_icon) do
				if GetMacroIndexByName(k)==0 then
					macro_override_icon[k] = nil
					if not macro_override_icon[new_name] then
						macro_override_icon[new_name] = v
						if buttons_by_macro[new_name] then
							for k,v in pairs(buttons_by_macro[new_name]) do
								k.icon:SetTexture(macro_override_icon[new_name])
							end
						end
						break
					end
				end
			end
		end
	end
end)

hooksecurefunc("DeleteMacro",function(old_name_or_index)
	old_name_or_index = tonumber(old_name_or_index) or old_name_or_index
	if type(old_name_or_index)=="string" then
		local old_name = old_name_or_index
		if macro_override_icon[old_name] and GetMacroIndexByName(old_name)==0 then
			macro_override_icon[old_name] = nil
		end
	elseif type(old_name_or_index)=="number" then
		for k,v in pairs(macro_override_icon) do
			if GetMacroIndexByName(k)==0 then
				macro_override_icon[k] = nil
				break
			end
		end
	end
end)

hooksecurefunc(GameTooltip,"SetAction",function(self,action)
	if addon_table.fix_tooltip then
		local button = self:GetOwner()
		if button then
			local macro_name = get_button_macro_name(button)
			if macro_name then
				local override_icon = macro_override_icon[macro_name]
				if override_icon then
					addon_table.fix_tooltip(macro_name,override_icon) --if macro has an override icon then call a custom function to show a tooltip based on that icon
				end
			end
		end
	end
end)