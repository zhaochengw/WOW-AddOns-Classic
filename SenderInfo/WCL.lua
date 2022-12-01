local __addon, __private = ...;
local WCL = {};
__private.WCL = WCL;


local function expand(name)

    local switch = {
        ["X"] = function()
            return "NAX"
        end,
        ["A"] = function()
            return "|cFFE5CC80"  --黄色
        end,
        ["L"] = function()
            return "|cFFFF8000"  --橙色
        end,
        ["S"] = function()
            return "|cFFE26880"  --粉红
        end,
        ["N"] = function()
            return "|cFFBE8200"  --深黄
        end,
        ["E"] = function()
            return "|cFFA335EE"  --紫色
        end,
        ["R"] = function()
            return "|cFF0070FF"  --蓝色
        end,
        ["U"] = function()
            return "|cFF1EFF00"  --绿色
        end,
        ["C"] = function()
            return "|cFF666666"  --灰色
        end,
        ["%"] = function()
            return "% "
        end
    }

    local out = ""
	local max = strlen(name)
    for j=1,max do
            ts = strsub(name,j,j)
            local f = switch[ts]
            if f  then
                out = out .. f()
            else
                out = out .. ts
            end
    end
    return out
end

local function cut_str(str)
	if str ~= nil then
		local s1,s2,s3 = strsplit("%",str);
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
		return {strsplit(',' , STOP_Database[tname])}
		-- return '本服全明星第' .. STOP_Database[tname]
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
		return {strsplit(',' , CTOP_Database[name])}
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
		return {strsplit(',' , TOP_Database[name])}
		-- return '世界全明星第' .. TOP_Database[tname]
	else
		return nil
	end
end


local function load_data(tname)
	if type(WP_Database) ~= "table" then
		return nil
	end
	local info = WP_Database[tname]
	if info then
		local data = strsplit("|", info);
		return expand(data)
	end
	return nil
end


local function GetWclScore(name)
    local dstr;
    local str = "";
    local guildName = GetGuildInfo(name)
    if (guildName ~= nil and guildName ~= "") then
        dstr = load_stopg(guildName)
        if dstr then
            str = str .. " "..dstr;
        end
    end
    dstr = load_top(name)
    if dstr then
        for i, title in ipairs(dstr) do
            str = str .. ' 世界全明星第' .. title;
        end			end
    dstr = load_ctop(name)
    if dstr then
        for i, title in ipairs(dstr) do
            str = str .. ' 国服全明星第' .. title;
        end
    end
    dstr = load_stop(name)
    if dstr then
        for i, title in ipairs(dstr) do
            str = str .. ' 本服全明星第' .. title;
        end
    end
    local data = load_data(name)
    dstr = cut_str(data)
    if dstr then
        str = str .. " "..dstr;
    end
    return str
end


WCL.GetWclScore = function (name)
    return GetWclScore(name)
end