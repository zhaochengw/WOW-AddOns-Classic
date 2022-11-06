--[[--
	by ALA @ 163UI
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
MT.BuildEnv("TradeSkillMaster");
-->		****


local mod = {  };

local GetCustomPriceValue = nil;
function mod.F_QueryPriceByName(name, num)
	return nil;
end
function mod.F_QueryPriceByID(id, num)
	if not id then return nil; end
	num = num or 1;
	if GetCustomPriceValue == nil then
		local TSM_API = TSM_API;
		if TSM_API ~= nil and TSM_API.GetCustomPriceValue ~= nil then
			GetCustomPriceValue = TSM_API.GetCustomPriceValue;
		else
			return;
		end
	end
	local p = GetCustomPriceValue("dbminbuyout", "i:" .. id);
	if p ~= nil then
		return p * num;
	end
end


MT.RegsiterAuctionModOnLoad("TradeSkillMaster", function()
	MT.AddAuctionMod("TradeSkillMaster", mod);
end);
