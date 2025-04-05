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
-->

-->		****
MT.BuildEnv("Auctionator");
-->		****


MT.RegisterOnAddOnLoaded("Auctionator", function()
	if AuctionatorCraftingInfo then
		AuctionatorCraftingInfo.ShowIfRelevant = function() end
		AuctionatorCraftingInfo.UpdateTotal = function() end
		AuctionatorCraftingInfo.AdjustPosition = function() end
	elseif Auctionator and Auctionator.CraftingInfo then
		Auctionator.CraftingInfo.Initialize = function() end
	end
end);
