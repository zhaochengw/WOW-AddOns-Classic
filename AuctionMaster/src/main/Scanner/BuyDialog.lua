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
	Asks the user for confirmation to buy a list of auctions.
--]]
vendor.BuyDialog = {}
vendor.BuyDialog.prototype = {}
vendor.BuyDialog.metatable = {__index = vendor.BuyDialog.prototype}

local log = vendor.Debug:new("BuyDialog")

local L = vendor.Locale.GetInstance()

local FRAME_HEIGHT = 300
local FRAME_WIDTH = 450
local TABLE_WIDTH = FRAME_WIDTH - 10
local TABLE_HEIGHT = FRAME_HEIGHT - 45
local TABLE_X_OFF = 5
local TABLE_Y_OFF = -40

--[[
	Wait until the user made a decison.
--]]
local function _WaitForDecision(self)
	while (not self.decisionMade) do
		coroutine.yield()
	end	
end

local function _OnOk(self)
	vendor.Scanner:PlaceAuctionBid(self.ahType, self.auctions)
	self.decisionMade = 1
	self:Hide()
end

local function _OnCancel(self)
	self.decisionMade = 0
	self:Hide()
end

--[[
	Initilaizes the frame.
--]]
local function _InitFrame(self)
	local frame = CreateFrame("Frame", nil, UIParent, "VendorDialogTemplate")
	frame.obj = self
	self.frame = frame
	frame:SetWidth(FRAME_WIDTH)
	frame:SetHeight(FRAME_HEIGHT)
	frame:SetPoint("CENTER")
	frame:SetFrameStrata("DIALOG")
	frame:SetMovable(true)
	frame:EnableMouse(true)
	frame:SetToplevel(true)
	frame:SetClampedToScreen(true)
	frame:SetScript("OnMouseDown", function() this:StartMoving() end)
	frame:SetScript("OnMouseUp", function() this:StopMovingOrSizing() end)
				
	-- intro text
	local text = frame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	text:SetPoint("TOPLEFT", 5, -10)
	text:SetText(L["Do you want to bid on the following auctions?"])
	
	-- auctions table
	local itemModel = vendor.ScannerItemModel:new(true)
	self.itemModel = itemModel
	itemModel.descriptors[vendor.ScannerItemModel.REASON].minWidth = 70
	itemModel.descriptors[vendor.ScannerItemModel.REASON].weight = 15
	local itemTableCfg = {
		rowHeight = 20,
		selected = {
			[1] = vendor.ScannerItemModel.TEXTURE,
			[2] = vendor.ScannerItemModel.NAME,
			[3] = vendor.ScannerItemModel.REASON,
			[4] = vendor.ScannerItemModel.BID,
			[5] = vendor.ScannerItemModel.BUYOUT
		},
	}
	
	local cmds = {
		[1] = {
			title = L["Ok"],
    		arg1 = self,
    		func = _OnOk,
    	},
    	[2] = {
    		title = L["Cancel"],
    		arg1 = self,
    		func = _OnCancel,
    	},
	}
	local cfg = {
		name = "AMBuyDialogAuctions",
		parent = frame,
		itemModel = itemModel,
		cmds = cmds,
		config = itemTableCfg,
		width = TABLE_WIDTH,
		height = TABLE_HEIGHT,
		xOff = TABLE_X_OFF,
		yOff = TABLE_Y_OFF,
		sortButtonBackground = true,
	}
	local itemTable = vendor.ItemTable:new(cfg)
	self.itemTable = itemTable
end

--[[ 
	Creates a new instance.
--]]
function vendor.BuyDialog:new()
	local instance = setmetatable({}, self.metatable)
	_InitFrame(instance)
	instance.frame:Hide()
	return instance
end

--[[
	Opens the dialog and shows the given auctions. Returns true, if the user bought them.
--]]
function vendor.BuyDialog.prototype:AskToBuy(ahType, auctions)
	log:Debug("AskToBuy enter")
	self.decisionMade = nil
	self.ahType = ahType
	self.auctions = auctions
	local itemModel = self.itemModel
	itemModel:Clear()
	log:Debug("AskToBuy 1")
	for i=1,#auctions do
		local info = auctions[i]
		itemModel:AddItem(info.itemLink, info.itemLinkKey, info.name, info.texture, info.timeLeft, info.count, 
			info.minBid, 0, info.buyout, info.bidAmount, "", info.reason, "", 0, info.quality)
	end
	log:Debug("AskToBuy 2")
	self.frame:Show()
	self.itemTable:Show()
	log:Debug("AskToBuy 3")
	_WaitForDecision(self)
	log:Debug("AskToBuy 4")
	return (self.decisionMade and (1 == self.decisionMade)) 
end

--[[
	Hides the dialog frame.
--]]
function vendor.BuyDialog.prototype:Hide()
	self.frame:Hide();
end

--[[
	Returns whether the dialog is visible
--]]
function vendor.BuyDialog.prototype:IsVisible()
	return self.frame:IsVisible()
end
