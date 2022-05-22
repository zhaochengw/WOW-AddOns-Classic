local addon_name, addon_data = ...

addon_data.debug_counter = 0

addon_data.utils = {}
-- Sends the given message to the chat frame with the addon name in front.
addon_data.utils.print_msg = function(msg)
	-- print(type(msg))
	addon_data.debug_counter = addon_data.debug_counter + 1
	if type(msg) == "table" then
		-- print('found a table')
		addon_data.utils.TablePrinter(msg)
		return
	end
	-- elseif type(msg) == "boolean" then
	msg = tostring(msg)
	-- end
	local chat_msg = "|cFFF58CBA" .. addon_name .. ": [" .. addon_data.debug_counter .. "] |r" .. msg
	DEFAULT_CHAT_FRAME:AddMessage(chat_msg)
end


addon_data.utils.SimpleRound = function(num, step)
    return floor(num / step) * step
end

addon_data.utils.TablePrinter = function(table)
	for key, value in pairs(table) do
        print('key ' .. key)
        print(value)
    end
end

--=======================================================================================
-- a switch to control debug statements in module parsing
-- NOTE: this does not incur any additional CPU usage in the addon's
--       typical operation, just in parsing the code.
addon_data.debug = false

if addon_data.debug then addon_data.utils.print_msg('-- Parsed util.lua module correctly') end
