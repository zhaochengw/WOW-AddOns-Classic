--[[--
	by ALA @ 163UI
--]]--

local __addon__, __namespace__ = ...;

-->		upvalue
	local GetItemInfo = GetItemInfo;
-->


-->		****
__namespace__:BuildEnv("Auctioneer");
-->		****


local mod = {  };

local GetItems = nil;
function mod.F_QueryPriceByName(name, num)
	return nil;
end
function mod.F_QueryPriceByID(id, num)
	if not id then return nil; end
	num = num or 1;
	if GetItems == nil then
		local AucAdvanced = AucAdvanced;
		if AucAdvanced ~= nil
			and AucAdvanced.Modules ~= nil
			and AucAdvanced.Modules.Util ~= nil
			and AucAdvanced.Modules.Util.SimpleAuction ~= nil
			and AucAdvanced.Modules.Util.SimpleAuction.Private ~= nil
			and AucAdvanced.Modules.Util.SimpleAuction.Private.GetItems ~= nil then
			GetItems = AucAdvanced.Modules.Util.SimpleAuction.Private.GetItems;
		else
			return;
		end
	end
	local name, link = GetItemInfo(id);
	if link ~= nil then
		local imgseen, image, matchBid, matchBuy, lowBid, lowBuy, aSeen, aveBuy = GetItems(link);
		if lowBuy ~= nil then
			return lowBuy * num;
		end
	end
end


__namespace__.F_AuctionModCallback("Auc-Advanced", function()
	__namespace__.F_AddAuctionMod("Auc-Advanced", mod);
end);
