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
MT.BuildEnv("!Pig");
-->		****


MT.RegsiterAuctionModOnLoad("!Pig", function()
	local mod = {  };
	mod.F_QueryPriceByName = function(name, num)
		local PIGA = _G.PIGA;
		if PIGA and PIGA["AHPlus"] then
			local info = PIGA["AHPlus"]["CacheData"][CT.SELFREALM][name];
			if info then
				num = num or 1;
				return info[2][#info[2]][1] * num;
			end
		end
	end
	mod.F_QueryPriceByID = function(id, num)
		local name = GetItemInfo(id);
		if name then
			return mod.F_QueryPriceByName(name, num);
		end
	end
	-- mod.F_OnDBUpdate = function() end
	MT.AddAuctionMod("!Pig", mod);
end);
