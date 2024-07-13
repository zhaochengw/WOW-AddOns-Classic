--[[--
	by ALA 
--]]--
----------------------------------------------------------------------------------------------------
local __addon, __private = ...;
local MT = __private.MT;
local CT = __private.CT;
local VT = __private.VT;
local DT = __private.DT;


-->		upvalue
	local GetItemInfo = GetItemInfo;
-->


-->		****
MT.BuildEnv("Auctipus");
-->		****


local mod = {  };

local GetAuctionBuyoutRange = nil;
function mod.F_QueryPriceByName(name, num)
	return nil;
end
function mod.F_QueryPriceByID(id, num)
	if id == nil then return nil; end
	num = num or 1;
	if GetAuctionBuyoutRange == nil then
		local Auctipus = Auctipus;
		if Auctipus ~= nil and Auctipus.API ~= nil and Auctipus.API.GetAuctionBuyoutRange ~= nil then
			GetAuctionBuyoutRange = Auctipus.API.GetAuctionBuyoutRange;
		else
			return;
		end
	end
	local minBuyout, maxBuyout, daysElapsed = GetAuctionBuyoutRange(id)
	if minBuyout ~= nil then
		return minBuyout * num;
	end
end


MT.RegsiterAuctionModOnLoad("Auctipus", function()
	MT.AddAuctionMod("Auctipus", mod);
end);
