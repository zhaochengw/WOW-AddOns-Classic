--[[--
	provided by @GF_Auction
	alaTradeSkill - GF_Auction adapter
--]]--
----------------------------------------------------------------------------------------------------
local __addon, __private = ...;
local MT = __private.MT;
local CT = __private.CT;
local VT = __private.VT;
local DT = __private.DT;

-->		upvalue
	local GetItemInfo = GetItemInfo;

-->		****
MT.BuildEnv("GF_Auction");
-->		****

local mod = {  };

function mod.F_QueryPriceByID(id, num)
	id = tonumber(id);
	if not id or id <= 0 then return nil; end
	num = tonumber(num) or 1;
	if num <= 0 then num = 1; end

	local gf = _G.GF_Auction;
	if not gf or not gf.GetModule then return nil; end
	local Database = gf:GetModule("Database");
	if not Database or not Database.GetPriceStats then return nil; end

	local stats = Database:GetPriceStats(id);
	local unit = stats and tonumber(stats.minUnit) or nil;
	if unit and unit > 0 then
		return unit * num;
	end
	return nil;
end

function mod.F_QueryNameByID(id)
	id = tonumber(id);
	if not id or id <= 0 then return nil; end
	local name = GetItemInfo(id);
	return name;
end
function mod.F_QueryQualityByID(id)
	id = tonumber(id);
	if not id or id <= 0 then return nil; end
	local _, _, quality = GetItemInfo(id);
	return quality;
end

MT.RegsiterAuctionModOnLoad("GF_Auction", function()
	MT.AddAuctionMod("GF_Auction", mod);
end);


