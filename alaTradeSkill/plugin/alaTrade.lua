--[[--
	by ALA @ 163UI
--]]--
----------------------------------------------------------------------------------------------------
local __addon, __private = ...;
local MT = __private.MT;
local CT = __private.CT;
local VT = __private.VT;
local DT = __private.DT;


-->		****
MT.BuildEnv("alaTrade");
-->		****


MT.RegsiterAuctionModOnLoad("alaTrade", function()
	local merc = VT.__super.merc;
	if merc ~= nil then
		local mod = {  };
		mod.F_QueryPriceByName = merc.F_QueryPriceByName or merc.query_ah_price_by_name;
		mod.F_QueryPriceByID = merc.F_QueryPriceByID or merc.query_ah_price_by_id;
		mod.F_OnDBUpdate = merc.F_OnDBUpdate or merc.add_cache_callback;
		MT.AddAuctionMod("alaTrade", mod);
	end
end);
