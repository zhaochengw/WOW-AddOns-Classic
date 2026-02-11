local addonName, addon = ...

--[[ namespace:Print(_..._) ![](https://img.shields.io/badge/function-blue)
Prints out a message in the chat frame, prefixed with the addon name in color.
--]]
function addon:Print(...)
	-- can't use string join, it fails on nil values
	local msg = ''
	for index = 1, select('#', ...) do
		local arg = select(index, ...)
		-- add some colors
		if arg == nil then
			msg = msg .. '|cffbd0605nil|r '
		elseif type(arg) == 'boolean' then
			if not not arg then
				msg = msg .. '|cff08bc06' .. tostring(arg) .. '|r' .. ' '
			else
				msg = msg .. '|cffff0000' .. tostring(arg) .. '|r' .. ' ' -- TODO: find a new color
			end
		elseif type(arg) == 'number' then
			msg = msg .. '|cff53c9ff' .. tostring(arg) .. '|r' .. ' '
		else
			msg = msg .. tostring(arg) .. ' '
		end
	end

	DEFAULT_CHAT_FRAME:AddMessage('|cff33ff99' .. addonName .. '|r: ' .. msg:trim())
end

--[[ namespace:Printf(_fmt_, _..._) ![](https://img.shields.io/badge/function-blue)
Wrapper for `namespace:Print(...)` and `string.format`.
--]]
function addon:Printf(fmt, ...)
	self:Print(fmt:format(...))
end

--[[ namespace:Dump(_object_[, _startKey_]) ![](https://img.shields.io/badge/function-blue)
Wrapper for `DevTools_Dump`.
--]]
function addon:Dump(value, startKey)
	DevTools_Dump(value, startKey)
end

--[[ namespace:DumpUI(_object_) ![](https://img.shields.io/badge/function-blue)
Similar to `namespace:Dump(object)`; a wrapper for the graphical version.
--]]
function addon:DumpUI(value)
	UIParentLoadAddOn('Blizzard_DebugTools')
	DisplayTableInspectorWindow(value)
end
