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
	Encapsulates the automatic price model calculations.
--]]

local L = vendor.Locale.GetInstance()

vendor.AutomaticPriceModel = {}
vendor.AutomaticPriceModel.prototype = {}
vendor.AutomaticPriceModel.metatable = {__index = vendor.AutomaticPriceModel.prototype}

local NO_COMPETITION = 1 
local OTHERS_ABOVE_MARKET = 2 
local NO_MATCH = 3
local UNDERCUT = 4 

--[[
	Selects the given pricing mode.
--]]
local function _SelectPricingMode(self, mode, avgBuyout)
	vendor.Vendor:Debug("_SelectPricingMode enter mode: "..mode.." avgBuyout: "..(avgBuyout or "NA"))
	self.mode = mode
	if (mode == NO_COMPETITION) then
		self.autoIcon:SetNormalTexture("Interface/Icons/Ability_GolemThunderClap")
		self.tooltip = L["There are no other auctions for this item."]
		-- select market price or multiplier (conf)
		if (avgBuyout) then
			vendor.Seller:SelectPricingModel(vendor.Seller.PRIZE_MODEL_MARKET)
		else
			vendor.Seller:SelectPricingModel(vendor.Seller.PRIZE_MODEL_MULTIPLIER)
		end
	elseif (mode == OTHERS_ABOVE_MARKET) then
		self.autoIcon:SetNormalTexture("Interface/Icons/Ability_GhoulFrenzy")
		self.tooltip = L["All other auctions are considerably above the market price."]
--		vendor.Seller:SelectPricingModel(vendor.Seller.PRIZE_MODEL_MARKET)
		vendor.Seller:SelectPricingModel(vendor.Seller.PRIZE_MODEL_UNDERCUT)
	elseif (mode == NO_MATCH) then
		self.autoIcon:SetNormalTexture("Interface/Icons/INV_Mask_01")
		self.tooltip = L["Some other auctions are considerably under the market price."]
		vendor.Seller:SelectPricingModel(vendor.Seller.PRIZE_MODEL_LOWER)
	elseif (mode == UNDERCUT) then
		self.autoIcon:SetNormalTexture("Interface/Icons/INV_Misc_Food_66")
		self.tooltip = L["Other auctions have to be undercut."]
		vendor.Seller:SelectPricingModel(vendor.Seller.PRIZE_MODEL_UNDERCUT)
	else
		vendor.Vendor:Error("unknown automatic pricing mode: "..(mode or "NA"))
		vendor.Seller:SelectPricingModel(vendor.Seller.PRIZE_MODEL_MARKET)
	end
	vendor.Vendor:Debug("_SelectPricingMode exit")
end

--[[
	Displays the tooltip for the selected pricing model.
--]]
local function _ShowTooltip(but)
	if (but.ctrl.tooltip) then
		GameTooltip:SetOwner(but, "ANCHOR_RIGHT")
		GameTooltip:SetText(but.ctrl.tooltip)
	end
end

--[[
	Check button has been updated.
--]]
local function _CheckUpdate(but)
	if (but:GetChecked()) then
		but.ctrl.autoIcon:Show()
		but.ctrl:Update()
		vendor.Seller.db.profile.autoPriceModel = true
	else
		but.ctrl.autoIcon:Hide()
		vendor.Seller.db.profile.autoPriceModel = false
	end
end

--[[
	Creates a new instance.
--]]
function vendor.AutomaticPriceModel:new(...)
	local instance = setmetatable({}, self.metatable)
	return instance
end

--[[
	Sets the current item to be used for the calculations.
--]]
function vendor.AutomaticPriceModel.prototype:SetItem(itemLink)
	self.itemLink = itemLink
	self:Update()
end

--[[
	Updates the current item - a scan has been finished.
--]]
function vendor.AutomaticPriceModel.prototype:Update()
	vendor.Vendor:Debug("AutomaticPriceModel.prototype:Update enter")
	if (not self.autoCheck:GetChecked() or not self.itemLink) then
		self.autoIcon:Hide()
		return
	end
	self.autoIcon:Show()
	local avgMinBid, avgBuyout = vendor.Gatherer:GetAuctionInfo(self.itemLink, vendor.AuctionHouse:IsNeutral())
	local avgCurMinBid, avgCurBuyout, minCurMinBid, minCurBuyout = vendor.Statistic:GetCurrentAuctionInfo(self.itemLink, vendor.AuctionHouse:IsNeutral(), true)
	if (not minCurBuyout or not avgBuyout or not avgCurBuyout) then
		_SelectPricingMode(self, NO_COMPETITION, avgBuyout)
	else
		if (minCurBuyout > avgBuyout * (vendor.Seller.db.profile.upperMarketThreshold / 100.0)) then
			_SelectPricingMode(self, OTHERS_ABOVE_MARKET, avgBuyout)
		elseif (minCurBuyout < avgBuyout * (vendor.Seller.db.profile.lowerMarketThreshold / 100.0)) then
			_SelectPricingMode(self, NO_MATCH, avgBuyout)
		else
			_SelectPricingMode(self, UNDERCUT, avgBuyout)
		end
	end
	vendor.Vendor:Debug("AutomaticPriceModel.prototype:Update exit")
end

--[[
	Creates the sub frame for the automatic price model information.
--]]
function vendor.AutomaticPriceModel.prototype:CreateFrame(parent)
	vendor.Vendor:Debug("prototype:CreateFrame enter")
	self.autoCheck = vendor.GuiTools.CreateCheckButton("VendorAutomaticPriceModelFrameCheck", parent, "UICheckButtonTemplate", 24, 24, true, L["Activates the automatic selection mode for the appropriate pricing model."])
	self.autoCheck.ctrl = self
	self.autoCheck:SetPoint("TOPLEFT", 75, -53)
	self.autoCheck:SetScript("OnClick", function(but) _CheckUpdate(but) end)
	self.autoCheck:SetChecked(vendor.Seller.db.profile.autoPriceModel)
	local f = parent:CreateFontString("VendorAutomaticPriceModelFrameCheckText", "ARTWORK", "GameFontHighlightSmall");
	f:SetText(L["Automatic"]);
	f:SetPoint("LEFT", self.autoCheck, "RIGHT", 0, 0)

	self.autoIcon = CreateFrame("Button", "VendorAutomaticPriceModelFrameIcon", parent)
	self.autoIcon.ctrl = self
	self.autoIcon:SetWidth(33)
	self.autoIcon:SetHeight(33)
	self.autoIcon:SetPoint("TOPLEFT", 179, -37)
	self.autoIcon:SetNormalTexture("Interface/Icons/Ability_GolemThunderClap")
	self.autoIcon:SetScript("OnEnter", function(but) _ShowTooltip(but) end)
	self.autoIcon:SetScript("OnLeave", function() GameTooltip:Hide() end)
	vendor.Vendor:Debug("prototype:CreateFrame exit")
	
--	self.autoCheck:Hide()
--	self.autoIcon:Hide()
end
