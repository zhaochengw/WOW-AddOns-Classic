--[[
	Copyright (C) Udorn (Blackhand)
	
	This program is free software; you can redistribute it and/or
	modify it under the terms of the GNU General Public License
	as published by the Free Software Foundation; either version 2
	of the License, or (at your option) any later version.

	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with this program; if not, write to the Free Software
	Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.	
--]]

--[[
	Snipe using bookmarks.
--]]
vendor.DisenchantSniper = {}
vendor.DisenchantSniper.prototype = {}
vendor.DisenchantSniper.metatable = {__index = vendor.DisenchantSniper.prototype}

local L = vendor.Locale.GetInstance()

local CFG_NAME = vendor.SniperConfig.DISENCHANT_SNIPER

--[[ 
	Creates a new instance.
--]]
function vendor.DisenchantSniper:new(auctions)
	local instance = setmetatable({}, self.metatable)
	instance.auctions = auctions
	instance.config = vendor.SniperConfig:new(instance, CFG_NAME)
	return instance
end

--[[
	Checks whether to snipe for the item and returns doBuy, reason
--]]
function vendor.DisenchantSniper.prototype:Snipe(itemLink, itemName, count, bid, buyout, highBidder)
	--local minProf = vendor.Scanner.db.profile.minimumProfit * 100
	local cfg = vendor.Sniper.db.profile[CFG_NAME]
	local minProf = cfg.minProfit
	local value = vendor.Disenchant:GetDisenchantValue(itemLink)
	if (value and value > 0) then
		local money = GetMoney()
		if (cfg.buyout and buyout and buyout > 0 and buyout <= money and value > (buyout + minProf)) then
			local profit = vendor.Format.FormatMoney(value - buyout, true)
			local percent = math.floor(100.0 * (value - buyout) / buyout + 0.5)
			local reason = L["Disenchant %s < buyout (%d%%)"]:format(profit, percent)
			local reasonSort = vendor.Sniper:CreateReasonSort(value - buyout, true, self:GetId())
			return true, reason, reasonSort
		elseif (cfg.bid and bid and bid <= money and value > (bid + minProf) and not highBidder) then
			local profit = vendor.Format.FormatMoney(value - bid, true)
			local percent = math.floor(100.0 * (value - bid) / bid + 0.5)
			local reason = L["Disenchant %s < bid (%d%%)"]:format(profit, percent)
			local reasonSort = vendor.Sniper:CreateReasonSort(value - bid, false, self:GetId())
			return true, reason, reasonSort
		end		
	end
	return false
end

--[[
	Returns the unique identifier of the sniper.
--]]
function vendor.DisenchantSniper.prototype:GetId()
	return "DisenchantSniper"
end

--[[
	Returns the name to be displayed for this sniper module.
--]]
function vendor.DisenchantSniper.prototype:GetDisplayName()
	return L["Disenchant"]
end

--[[
	Returns an ordering information for the sniper. Lower numbers will be executed first.
--]]
function vendor.DisenchantSniper.prototype:GetOrder()
	return 3
end

function vendor.DisenchantSniper.prototype:GetDescription()
	return L["DISENCHANT_SNIPER_DESC"]
end
