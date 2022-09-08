--[[--
	by ALA @ 163UI
--]]--

local __addon__, __namespace__ = ...;

-->		upvalue
	local GetItemInfo = GetItemInfo;
-->


-->		****
__namespace__:BuildEnv("Auctionator");
-->		****


local mod = {  };

local GetPrice = nil;
function mod.F_QueryPriceByName(name, num)
	if name == nil then return nil; end
	num = num or 1;
	if GetPrice == nil then
		if Atr_GetAuctionPrice ~= nil then
			GetPrice = Atr_GetAuctionPrice;
		else
			return;
		end
	end
	local ap = GetPrice(name);
	if ap ~= nil then
		return ap * num;
	end
	return nil;
end
function mod.F_QueryPriceByID(id, num)
	if id == nil then return nil; end
	num = num or 1;
	if GetPrice == nil then
		if Auctionator ~= nil and Auctionator.API ~= nil and Auctionator.API.v1 ~= nil then
			local Get = Auctionator.API.v1.GetAuctionPriceByItemID;
			if Get ~= nil then
				GetPrice = function(id)
					return Get("alaTradeSkill", id);
				end
			end
		elseif Atr_GetAuctionPrice ~= nil then
			local Get = Atr_GetAuctionPrice;
			if Get ~= nil then
				GetPrice = function(id)
					local name = GetItemInfo(id);
					if name ~= nil then
						return Get(name);
					end
				end
			end
		end
	end
	local ap = GetPrice(id);
	if ap ~= nil and ap > 0 then
		return ap * num;
	end
end


__namespace__.F_AuctionModCallback("Auctionator", function()
	if Auctionator ~= nil and Auctionator.API ~= nil and Auctionator.API.v1 ~= nil then
		local Get = Auctionator.API.v1.GetAuctionPriceByItemID;
		if Get ~= nil then
			GetPrice = function(id)
				return Get("alaTradeSkill", id);
			end
		end
		if Auctionator.API.v1.RegisterForDBUpdate ~= nil then
			local OnDBUpdate = Auctionator.API.v1.RegisterForDBUpdate;
			mod.F_OnDBUpdate = function(callback)
				OnDBUpdate("alaTradeSkill", callback);
			end;
		end
	else
		if Atr_GetAuctionPrice ~= nil then
			local Get = Atr_GetAuctionPrice;
			if Get ~= nil then
				GetPrice = function(id)
					local name = GetItemInfo(id);
					if name ~= nil then
						return Get(name);
					end
				end
			end
		end
		if Atr_RegisterFor_DBupdated ~= nil then
			mod.F_OnDBUpdate = Atr_RegisterFor_DBupdated;
		end
	end
	__namespace__.F_AddAuctionMod("Auctionator", mod);
end);
