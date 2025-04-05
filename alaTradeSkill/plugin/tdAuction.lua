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
	local _G = _G;
-->

-->		****
MT.BuildEnv("Auctioneer");
-->		****


local mod = {  };

local prices = nil;
function mod.F_QueryPriceByName(name, num)
	return nil;
end
function mod.F_QueryPriceByID(id, num)
	if not id then return nil; end
	if prices == nil then
		local TDDB_AUCTION = _G.TDDB_AUCTION;
		if TDDB_AUCTION ~= nil
			and TDDB_AUCTION.global ~= nil
			and TDDB_AUCTION.global.prices ~= nil
			and TDDB_AUCTION.global.prices[CT.SELFREALM] ~= nil then
			prices = TDDB_AUCTION.global.prices[CT.SELFREALM];
		else
			return;
		end
	end
	local price = prices[id .. ":0"];
	if price ~= nil then
		num = num or 1;
		return price * num;
	end
end


MT.RegsiterAuctionModOnLoad("tdAuction", function()
	MT.AddAuctionMod("tdAuction", mod);
end);
