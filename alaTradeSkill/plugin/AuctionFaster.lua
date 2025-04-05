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
MT.BuildEnv("AuctionFaster");
-->		****


local mod = {  };

local GetItemFromCache = nil;
function mod.F_QueryPriceByName(name, num)
	return nil;
end
function mod.F_QueryPriceByID(id, num)
	if id == nil then return nil; end
	if GetItemFromCache == nil then
		if AuctionFaster ~= nil
			and AuctionFaster.modules ~= nil
			and AuctionFaster.modules.ItemCache ~= nil
			and AuctionFaster.modules.ItemCache.GetItemFromCache ~= nil then
			GetItemFromCache = AuctionFaster.modules.ItemCache.GetItemFromCache;
		else
			return;
		end
	end
	local name = GetItemInfo(id);
	if name ~= nil then
		local cacheItem = GetItemFromCache(nil, id, name, true);
		if cacheItem ~= nil then
			local ap = cacheItem.buy;
			if ap ~= nil and ap > 0 then
				num = num or 1;
				return ap * num;
			end
		end
	end
end


MT.RegsiterAuctionModOnLoad("AuctionFaster", function()
	MT.AddAuctionMod("AuctionFaster", mod);
end);
