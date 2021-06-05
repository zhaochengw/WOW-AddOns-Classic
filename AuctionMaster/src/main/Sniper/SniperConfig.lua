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

vendor.SniperConfig = {}
vendor.SniperConfig.prototype = {}
vendor.SniperConfig.metatable = {__index = vendor.SniperConfig.prototype}

local L = vendor.Locale.GetInstance()

vendor.SniperConfig.BOOKMARK_SNIPER = "bookmarkSniper"
vendor.SniperConfig.SELL_PRICE_SNIPER = "sellPriceSniper"
vendor.SniperConfig.DISENCHANT_SNIPER = "disenchantSniper"

local WIDTH = 368
local HEIGHT = 256
local SMALL_HEIGHT = 192
local CHECK_SIZE = 22

local function _Update(self)
	if (self.configName) then
		local cfg = vendor.Sniper.db.profile[self.configName]
		MoneyInputFrame_SetCopper(self.minProfit, cfg.minProfit or 0)
		self.bid:SetChecked(cfg.bid)
		self.buyout:SetChecked(cfg.buyout)
	end
end

local function _Save(self)
	if (self.configName) then
		local cfg = vendor.Sniper.db.profile[self.configName]
		local bid = false
		if (self.bid:GetChecked()) then
			bid = true
		end
		cfg.bid = bid 
		local buyout = false
		if (self.buyout:GetChecked()) then
			buyout = true
		end
		cfg.buyout = buyout
		cfg.minProfit = MoneyInputFrame_GetCopper(self.minProfit) or 0
	end
end

local function _InitConfig(self)
	local frame = self.frame
	
	local minProfitLabel = frame:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
	minProfitLabel:SetText(L["Min. profit"])
    minProfitLabel:SetPoint("TOPLEFT", self.descriptionFrame, "BOTTOMLEFT", 6, -24)

	local minProfit = CreateFrame("Frame", frame:GetName().."MinProfit", frame, "MoneyInputFrameTemplate")
	minProfit:SetPoint("TOPLEFT", self.descriptionFrame, "BOTTOMLEFT", 75, -20)
	
    local bid = vendor.GuiTools.CreateCheckButton(nil, frame, "UICheckButtonTemplate", CHECK_SIZE, CHECK_SIZE)
	bid.obj = self
	bid:SetPoint("TOPLEFT", minProfitLabel, "BOTTOMLEFT", -4, -12)

	local bidLabel = frame:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
	bidLabel:SetText(L["Bid"])
    bidLabel:SetPoint("LEFT", bid, "RIGHT", 4, 0)

    local buyout = vendor.GuiTools.CreateCheckButton(nil, frame, "UICheckButtonTemplate", CHECK_SIZE, CHECK_SIZE)
	buyout.obj = self
	buyout:SetPoint("LEFT", bidLabel, "RIGHT", 10, 0)

	local buyoutLabel = frame:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
	buyoutLabel:SetText(L["Buyout"])
    buyoutLabel:SetPoint("LEFT", buyout, "RIGHT", 4, 0)
	
	self.minProfit = minProfit
	self.bid = bid
	self.buyout = buyout
end

local function _InitFrame(self)
	local frame = CreateFrame("Frame", "AMSniperConfig"..self.sniper:GetDisplayName(), UIParent, "VendorDialogTemplate")
	frame.obj = self
	frame:SetWidth(WIDTH)
	frame:SetHeight(HEIGHT)
	frame:SetPoint("CENTER")
	frame:SetFrameStrata("DIALOG")
	frame:SetMovable(true)
	frame:EnableMouse(true)
	frame:SetToplevel(true)
	frame:SetClampedToScreen(true)
	frame:Hide()
	frame:SetScript("OnMouseDown", function(frame) frame:StartMoving() end)
	frame:SetScript("OnMouseUp", function(frame) frame:StopMovingOrSizing() end)
	
	local title = frame:CreateFontString(nil, "OVERLAY")
	title:SetPoint("TOP", frame, "TOP", 0, -10)
	title:SetFontObject("GameFontHighlightLarge")
	title:SetText(self.sniper:GetDisplayName())
	
	local descriptionFrame = CreateFrame("Frame", nil, frame)
	descriptionFrame:SetWidth(WIDTH - 24)
	descriptionFrame:SetHeight(100)
	descriptionFrame:SetPoint("TOPLEFT", 12, -40)
	local descriptionBack = descriptionFrame:CreateTexture(nil, "ARTWORK")
	descriptionBack:SetTexture(0, 0, 0, 0.5)
	descriptionBack:SetAllPoints(descriptionFrame)
	local description = descriptionFrame:CreateFontString(nil, "OVERLAY")
	description:SetPoint("TOPLEFT", 4, -4)
	description:SetFontObject("GameFontWhite")
	description:SetWidth(descriptionFrame:GetWidth() - 8)
	description:SetJustifyH("LEFT")
	if (self.sniper.GetDescription) then
		description:SetText(self.sniper:GetDescription())
	end
	
	local ok = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
	ok.obj = self
	ok:SetText(OKAY)
	ok:SetWidth(100)
	ok:SetHeight(22)
	ok:SetPoint("BOTTOMLEFT", 10, 10)
	ok:SetScript("OnClick", function(button) _Save(button.obj); button.obj.frame:Hide() end)

	local cancel = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
	cancel.obj = self
	cancel:SetText(CANCEL)
	cancel:SetWidth(100)
	cancel:SetHeight(22)
	cancel:SetPoint("BOTTOMRIGHT", -10, 10)
	cancel:SetScript("OnClick", function(button) button.obj.frame:Hide() end)	
	
	self.frame = frame
	self.descriptionFrame = descriptionFrame
end

function vendor.SniperConfig:new(sniper, configName)
	local instance = setmetatable({}, self.metatable)
	instance.sniper = sniper
	_InitFrame(instance)
	if (configName) then
		instance.configName = configName
		_InitConfig(instance)
	else
		instance.frame:SetHeight(SMALL_HEIGHT)
	end
--	instance.frame:Hide()
	return instance
end

function vendor.SniperConfig.prototype:Show()
	self.frame:Show()
end

function vendor.SniperConfig.prototype:Toggle()
	if (self.frame:IsShown()) then
		self.frame:Hide()
	else
		_Update(self)
		self.frame:Show()
	end
end
