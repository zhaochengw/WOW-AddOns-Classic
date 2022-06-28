local addon_name, st = ...
st.debug_counter = 0
st.utils = {}

-- Sends the given message to the chat frame with the addon name in front.
st.utils.print_msg = function(msg)
	-- print(type(msg))
	st.debug_counter = st.debug_counter + 1
	if type(msg) == "table" then
		-- print('found a table')
		st.utils.table_printer(msg)
		return
	end
	-- elseif type(msg) == "boolean" then
	msg = tostring(msg)
	-- end
	local chat_msg = "|cFFF58CBA" .. addon_name .. ": [" .. st.debug_counter .. "] |r" .. msg
	DEFAULT_CHAT_FRAME:AddMessage(chat_msg)
end

-- Rounds down, e.g. if step=0.1 will round down to 1dp.
st.utils.simple_round = function(num, step)
    return floor(num / step) * step
end

st.utils.table_printer = function(table)
	for key, value in pairs(table) do
        st.utils.print_msg('key ' .. key)
        st.utils.print_msg(value)
    end
end

-- Converts a list to a lookup table.
st.utils.convert_lookup_table = function(list)
	local my_table = {}
	for _, id in ipairs(list) do my_table[id] = true end
	return my_table
end


-- Detect if two numbers are within a given tolerance of each other
st.utils.test_tolerance = function(n1, n2, tolerance)
	diff = math.abs(n1 - n2)
	if diff < tolerance then
		return true
	else 
		return false
	end
end

-- Detect if the player is a paladin
st.utils.player_is_paladin = function()
	local english_class = select(2, UnitClass("player")) -- same in all locales
	if english_class == "PALADIN" then
		 return true
	end
	return false
end


--=======================================================================================
-- a switch to control debug statements in module parsing
-- NOTE: this does not incur any additional CPU usage in the addon's
--       typical operation, just in parsing the code.
st.debug = false

if st.debug then st.utils.print_msg('-- Parsed util.lua module correctly') end
