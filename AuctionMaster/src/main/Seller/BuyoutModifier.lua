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
	Widget for editing the buyout multiplier for auctions.
--]]
vendor.BuyoutModifier = {}
vendor.BuyoutModifier.prototype = {}
vendor.BuyoutModifier.metatable = {__index = vendor.BuyoutModifier.prototype}

local L = vendor.Locale.GetInstance()
local log = vendor.Debug:new("BuyoutModifier")

vendor.BuyoutModifier.NONE = 0
vendor.BuyoutModifier.SUBTRACT_MONEY = 1
vendor.BuyoutModifier.SUBTRACT_PERCENT = 2
vendor.BuyoutModifier.ADD_MONEY = 3
vendor.BuyoutModifier.ADD_PERCENT = 4

local PERCENT_TYPE = 1
local MINUS_TYPE = 2
local PLUS_TYPE = 3

--[[ 
	Creates a new instance.
--]]
function vendor.BuyoutModifier:new()
	local instance = setmetatable({}, self.metatable)
	return instance
end

--[[
	Selects the setting for the given price model.
--]]
function vendor.BuyoutModifier.prototype:SelectPriceModel(priceModel)
	self.priceModel = priceModel
end

--[[
	Returns an altered buyout according to the current settings.
--]]
function vendor.BuyoutModifier.prototype:ModifyBuyout(buyout, itemSettings)
	local rtn = buyout
	if (self.priceModel and itemSettings and itemSettings.pricingModel.pricingModifier) then
		log:Debug("ModifyBuyout priceModel [%s]", self.priceModel)
		local pmod = itemSettings.pricingModel.pricingModifier[tostring(self.priceModel)]
		if (pmod) then
			log:Debug("ModifyBuyout copper [%s] percent [%s]", pmod.copper, pmod.percent)
			if (pmod.modifier == vendor.BuyoutModifier.SUBTRACT_MONEY) then
				rtn = buyout - (pmod.copper or 0)
			elseif (pmod.modifier == vendor.BuyoutModifier.SUBTRACT_PERCENT) then
				rtn = buyout - (buyout * ((pmod.percent or 0) / 100))
			elseif (pmod.modifier == vendor.BuyoutModifier.ADD_MONEY) then
				rtn = buyout + (pmod.copper or 0)
			elseif (pmod.modifier == vendor.BuyoutModifier.ADD_PERCENT) then
				rtn = buyout + (buyout * ((pmod.percent or 0) / 100))
			end
		end
	end 
	return math.max(1, rtn or 0)
end
