local __addon, __private = ...;
local WCL = {};
__private.WCL = WCL;



local function expand(name)

	local switch = {
		["r"] = function()
			return "RS"
		end,
		["V"] = function()
			return "VOA"
		end,
		["X"] = function()
			return "NAX"
		end,
		["D"] = function()
			return "ULD"
		end,
		["O"] = function()
			return "Onyxia"
		end,
		["T"] = function()
			return "TOC"
		end,
		["I"] = function()
			return "ICC"
		end,
		["A"] = function()
			return "|cFFE5CC80"
		end,
		["L"] = function()
			return "|cFFFF8000"
		end,
		["S"] = function()
			return "|cFFE26880"
		end,
		["N"] = function()
			return "|cFFBE8200"
		end,
		["E"] = function()
			return "|cFFA335EE"
		end,
		["R"] = function()
			return "|cFF0070FF"
		end,
		["U"] = function()
			return "|cFF1EFF00"
		end,
		["C"] = function()
			return "|cFF666666"
		end,
		["%"] = function()
			return "% "
		end
	}

	local out = ""
	local max = strlen(name)
	for j = 1, max do
		ts = strsub(name, j, j)
		local f = switch[ts]
		if f then
			out = out .. f()
		else
			out = out .. ts
		end
	end
	return out
end



local function cut_str(str)
	if str ~= nil then
		local s1, s2, s3 = strsplit("%", str);
		if s1 ~= nil then
			s1 = s1 .. "%"
			if s2 ~= nil and s2 ~= " " then
				s1 = s1 .. s2 .. "%"
			end
			return s1
		end
	end
	return nil
end

local function load_data(tname)
	if type(WP_Database) ~= "table" then
		return nil
	end
	local info = WP_Database[tname]
	if info then
		local data, uptime = strsplit("|", info);
		-- print(data,uptime)
		local y, m, d = strsplit("-", WP_Database["LASTUPDATE"], 3)
		local c = { year = tonumber(y), month = tonumber(m), day = tonumber(d), hour = 00, min = 00, sec = 00 }
		cc = time(c)
		cc = cc - tonumber(uptime) * 24 * 60 * 60
		--return expand(data), "更新日期:" .. date("%Y-%m-%d", cc)
        return expand(data)
	end
	return nil
end

local function load_stopg(tname)
	if type(CTOPG_Database) == "table" then
		sname = tname .. "_" .. GetRealmName()
		if CTOPG_Database[sname] then
			return CTOPG_Database[sname]
		end
	end

	if type(STOPG_Database) == "table" then
		if STOPG_Database[tname] then
			return STOPG_Database[tname]
		end
	end

	return nil
end

local function load_stop(tname)
	if type(STOP_Database) ~= "table" then
		return nil
	end
	if STOP_Database[tname] then
		return { strsplit(',', STOP_Database[tname]) }
		-- return '本服全明星第' .. STOP_Database[tname]
	else
		return nil
	end
end

local function load_ttop(tname)
	if type(TTOP_Database) ~= "table" then
		return nil
	end
	name = tname .. "_" .. GetRealmName()
	if TTOP_Database[name] then
		return { strsplit(',', TTOP_Database[name]) }
		-- return '国服全明星第' .. TTOP_Database[tname]
	else
		return nil
	end
end

local function load_ctop(tname)
	if type(CTOP_Database) ~= "table" then
		return nil
	end
	name = tname .. "_" .. GetRealmName()
	if CTOP_Database[name] then
		return { strsplit(',', CTOP_Database[name]) }
		-- return '国服全明星第' .. CTOP_Database[tname]
	else
		return nil
	end
end

local function load_top(tname)
	if type(TOP_Database) ~= "table" then
		return nil
	end
	local name = tname .. "_" .. GetRealmName()

	if TOP_Database[name] then
		return { strsplit(',', TOP_Database[name]) }
		-- return '世界全明星第' .. TOP_Database[tname]
	else
		return nil
	end
end

local function GetWclScore(WP_MouseoverName)
 
    local showStr = ""
    local dstr = ""

    local guildName = GetGuildInfo(WP_MouseoverName)
    if (guildName ~= nil and guildName ~= "") then
        dstr = load_stopg(guildName)
        if dstr then
            showStr = showStr .. dstr
        end
    end
    dstr = load_top(WP_MouseoverName)
    if dstr then
        for i, title in ipairs(dstr) do
            if string.find(title, "^%d") ~= nil then
                title = '世界全明星第' .. title
            else
                title = expand(title)
            end
            showStr = showStr .. title
        end
    end
    dstr = load_ctop(WP_MouseoverName)
    if dstr then
        for i, title in ipairs(dstr) do
            if string.find(title, "^%d") ~= nil then
                title = '国服全明星第' .. title
            else
                title = expand(title)
            end
            showStr = showStr .. title
        end
    end
    dstr = load_ttop(WP_MouseoverName)
    if dstr then
        for i, title in ipairs(dstr) do
            if string.find(title, "^%d") ~= nil then
                title = '台服全明星第' .. title
            else
                title = expand(title)
            end
            showStr = showStr .. title
        end
    end			
    dstr = load_stop(WP_MouseoverName)
    if dstr then
        for i, title in ipairs(dstr) do
            if string.find(title, "^%d") ~= nil then
                title = '本服全明星第' .. title
            else
                title = expand(title)
            end
            showStr = showStr .. title
        end
    end
    local data, ldate = load_data(WP_MouseoverName)
    dstr = cut_str(data)
    if dstr then
        showStr = showStr .. dstr
    end
    if ldate then
        showStr = showStr .. ldate
    end

    return showStr
end


WCL.GetWclScore = function (name)
    return GetWclScore(name)
end



-- a dictionary of format to match entity
local FORMAT_SEQUENCES = {
	["s"] = ".+",
	["c"] = ".",
	["%d*d"] = "%%-?%%d+",
	["[fg]"] = "%%-?%%d+%%.?%%d*",
	["%%%.%d[fg]"] = "%%-?%%d+%%.?%%d*",
}

-- a set of format sequences that are string-based, i.e. not numbers.
local STRING_BASED_SEQUENCES = {
	["s"] = true,
	["c"] = true,
}

local cache = setmetatable({}, { __mode = 'k' })
-- generate the deformat function for the pattern, or fetch from the cache.
local function get_deformat_function(pattern)
	local func = cache[pattern]
	if func then
		return func
	end

	-- escape the pattern, so that string.match can use it properly
	local unpattern = '^' .. pattern:gsub("([%(%)%.%*%+%-%[%]%?%^%$%%])", "%%%1") .. '$'

	-- a dictionary of index-to-boolean representing whether the index is a number rather than a string.
	local number_indexes = {}

	-- (if the pattern is a numbered format,) a dictionary of index-to-real index.
	local index_translation = nil

	-- the highest found index, also the number of indexes found.
	local highest_index
	if not pattern:find("%%1%$") then
		-- not a numbered format

		local i = 0
		while true do
			i = i + 1
			local first_index
			local first_sequence
			for sequence in pairs(FORMAT_SEQUENCES) do
				local index = unpattern:find("%%%%" .. sequence)
				if index and (not first_index or index < first_index) then
					first_index = index
					first_sequence = sequence
				end
			end
			if not first_index then
				break
			end
			unpattern = unpattern:gsub("%%%%" .. first_sequence, "(" .. FORMAT_SEQUENCES[first_sequence] .. ")", 1)
			number_indexes[i] = not STRING_BASED_SEQUENCES[first_sequence]
		end

		highest_index = i - 1
	else
		-- a numbered format

		local i = 0
		while true do
			i = i + 1
			local found_sequence
			for sequence in pairs(FORMAT_SEQUENCES) do
				if unpattern:find("%%%%" .. i .. "%%%$" .. sequence) then
					found_sequence = sequence
					break
				end
			end
			if not found_sequence then
				break
			end
			unpattern = unpattern:gsub("%%%%" .. i .. "%%%$" .. found_sequence, "(" .. FORMAT_SEQUENCES[found_sequence] .. ")", 1)
			number_indexes[i] = not STRING_BASED_SEQUENCES[found_sequence]
		end
		highest_index = i - 1

		i = 0
		index_translation = {}
		pattern:gsub("%%(%d)%$", function(w)
			i = i + 1
			index_translation[i] = tonumber(w)
		end)
	end

	if highest_index == 0 then
		cache[pattern] = do_nothing
	else
		--[=[
            -- resultant function looks something like this:
            local unpattern = ...
            return function(text)
                local a1, a2 = text:match(unpattern)
                if not a1 then
                    return nil, nil
                end
                return a1+0, a2
            end

            -- or if it were a numbered pattern,
            local unpattern = ...
            return function(text)
                local a2, a1 = text:match(unpattern)
                if not a1 then
                    return nil, nil
                end
                return a1+0, a2
            end
        ]=]

		local t = {}
		t[#t + 1] = [=[
            return function(text)
                local ]=]

		for i = 1, highest_index do
			if i ~= 1 then
				t[#t + 1] = ", "
			end
			t[#t + 1] = "a"
			if not index_translation then
				t[#t + 1] = i
			else
				t[#t + 1] = index_translation[i]
			end
		end

		t[#t + 1] = [=[ = text:match(]=]
		t[#t + 1] = ("%q"):format(unpattern)
		t[#t + 1] = [=[)
                if not a1 then
                    return ]=]

		for i = 1, highest_index do
			if i ~= 1 then
				t[#t + 1] = ", "
			end
			t[#t + 1] = "nil"
		end

		t[#t + 1] = "\n"
		t[#t + 1] = [=[
                end
                ]=]

		t[#t + 1] = "return "
		for i = 1, highest_index do
			if i ~= 1 then
				t[#t + 1] = ", "
			end
			t[#t + 1] = "a"
			t[#t + 1] = i
			if number_indexes[i] then
				t[#t + 1] = "+0"
			end
		end
		t[#t + 1] = "\n"
		t[#t + 1] = [=[
            end
        ]=]

		t = table.concat(t, "")

		-- print(t)

		cache[pattern] = assert(loadstring(t))()
	end

	return cache[pattern]
end

function Deformat(text, pattern)
	if type(text) ~= "string" then
		error(("Argument #1 to `Deformat' must be a string, got %s (%s)."):format(type(text), text), 2)
	elseif type(pattern) ~= "string" then
		error(("Argument #2 to `Deformat' must be a string, got %s (%s)."):format(type(pattern), pattern), 2)
	end

	return get_deformat_function(pattern)(text)
end
