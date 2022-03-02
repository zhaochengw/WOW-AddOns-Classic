--[[--
	by ALA @ 163UI
--]]--

local __addon__, __namespace__ = ...;

-->		upvalue
	local GetItemInfo = GetItemInfo;
-->


-->		****
__namespace__:BuildEnv("AuctionFaster");
-->		****


local mod = {  };

local GetItemFromCache = nil;
function mod.F_QueryPriceByName(name, num)
	return nil;
end
function mod.F_QueryPriceByID(id, num)
	if id == nil then return nil; end
	num = num or 1;
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
				return ap * num;
			end
		end
	end
end


__namespace__.F_AuctionModCallback("AuctionFaster", function()
	__namespace__.F_AddAuctionMod("AuctionFaster", mod);
end);
