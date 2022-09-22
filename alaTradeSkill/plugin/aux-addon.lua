--[[--
	by ALA @ 163UI
--]]--

local __addon__, __namespace__ = ...;

-->		upvalue
	local strsplit = string.split;
	local tonumber = tonumber;
	local GetRealmName = GetRealmName;
	local UnitFactionGroup = UnitFactionGroup;
-->


-->		****
__namespace__:BuildEnv("aux-addon");
-->		****


local mod = {  };

local key = format('%s|%s', GetRealmName(), UnitFactionGroup('player'));
local history = nil;
function mod.F_QueryPriceByName(name, num)
	return nil;
end
function mod.F_QueryPriceByID(id, num)
	if id == nil then return nil; end
	num = num or 1;
	--[[	--	changed since v3.0
	if history == nil then
		if require ~= nil then
			history = require 'aux.core.history';
			if history == nil then
				return;
			end
		else
			return;
		end
	end
	local ap = history.market_value(id .. ":0");
	if ap ~= nil and ap > 0 then
		return ap * num;
	end
	--]]	--	so query it myself
	if history == nil then
		local aux = _G.aux;
		history = aux and aux.faction and aux.faction[key] and aux.faction[key].history;
		if history == nil then
			return;
		end
	end
	local val = history[id .. ":0"];
	if val ~= nil then
		local next_push, daily_min_buyout = strsplit("#", val);
		if daily_min_buyout ~= nil then
			daily_min_buyout = tonumber(daily_min_buyout);
			return daily_min_buyout ~= nil and daily_min_buyout * num or nil;
		end
	end
end


__namespace__.F_AuctionModCallback("aux-addon", function()
	__namespace__.F_AddAuctionMod("aux-addon", mod);
end);
