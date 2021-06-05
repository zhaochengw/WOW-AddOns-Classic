--[[
	Informs the user about the scan process or asks to buy items.
	
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

vendor.CancelAuctionDialog = {}
vendor.CancelAuctionDialog.prototype = {}
vendor.CancelAuctionDialog.metatable = {__index = vendor.CancelAuctionDialog.prototype}

local log = vendor.Debug:new("CancelAuctionDialog")

local L = vendor.Locale.GetInstance()

local FRAME_HEIGHT = 170
local FRAME_WIDTH = 397
local BUTTON_GAP = 3
local BUTTON_WIDTH = 80
local SMALL_BUTTON_WIDTH = 65

--[[
	Wait until the user made a decison.
--]]
local function _WaitForDecision(self)
	while (not self.decisionMade) do
		coroutine.yield(); -- continue waiting
	end	
end

--[[
	Create the subframe for canceling auctions.
--]]
local function _InitCancelFrame(self)
	local frame = CreateFrame("Frame", nil, self.frame);
	frame:SetWidth(FRAME_WIDTH);
	frame:SetHeight(FRAME_HEIGHT);
	frame:SetPoint("TOPLEFT");
	self.cancelFrame = frame;
	
	-- create the item icon
	local frameName = self.frame:GetName();
	local itemIcon = CreateFrame("Button", frameName.."ItemIcon", frame);
	itemIcon:SetWidth(50);
	itemIcon:SetHeight(50);
	itemIcon:SetPoint("TOPLEFT", 10, -20);
	itemIcon.ctrl = self;
	itemIcon:SetScript("OnEnter", function(but)
		local self = but.ctrl;
		if (self.itemLink) then 
			GameTooltip:SetOwner(but, "ANCHOR_RIGHT");
			GameTooltip.itemCount = self.count;
			GameTooltip:SetHyperlink(self.itemLink);
		end
	end);
	itemIcon:SetScript("OnLeave", function() GameTooltip:Hide(); end);
	itemIcon:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square");
	self.itemIcon = itemIcon;
		
	-- and the item name
	local itemName = itemIcon:CreateFontString(frameName.."ItemName", "BACKGROUND", "GameFontNormalLarge");
	itemName:SetWidth(240);
	itemName:SetHeight(30);
	itemName:SetPoint("LEFT", itemIcon, "RIGHT", 5, 0);
	itemName:SetJustifyH("LEFT");
	self.itemName = itemName;
	
	-- and the item count
	local itemCount = itemIcon:CreateFontString(frameName.."ItemCount", "OVERLAY", "NumberFontNormal");
	itemCount:SetJustifyH("RIGHT");
	itemCount:SetPoint("BOTTOMRIGHT", -5, 2);
	self.itemCount = itemCount;
	
	local bidLabel = frame:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall");
	bidLabel:SetText(L["Bid"]);
	bidLabel:SetPoint("TOPLEFT", frame, "TOPLEFT", 10, -76);
	
	local bt = frame:CreateFontString(nil, "ARTWORK", "GameFontNormal");
	bt:SetPoint("LEFT", bidLabel, "RIGHT", 10, 0);
	self.bidBt = bt;
	
	local buyoutLabel = frame:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall");
	buyoutLabel:SetText(L["Buyout"]);
	if ( GetLocale() == "zhTW" or GetLocale() == "zhCN" ) then
		buyoutLabel:SetPoint("TOPLEFT", bidLabel, "BOTTOMLEFT", 0, -4);
	else
		buyoutLabel:SetPoint("TOPLEFT", bidLabel, "BOTTOMLEFT", 0, -8);
	end
	
	local bt = frame:CreateFontString(nil, "ARTWORK", "GameFontNormal");
	bt:SetPoint("LEFT", buyoutLabel, "RIGHT", 10, 0);
	self.buyoutBt = bt;
	
	local okBut = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate");
	okBut:SetText(L["Ok"]);
	okBut:SetWidth(BUTTON_WIDTH);
	okBut:SetHeight(22);
	okBut:SetPoint("BOTTOM", frame, "BOTTOM", -40, 10);
	okBut.ctrl = self;
	okBut:SetScript("OnClick", function(bt)
		log:Debug("cancel [%s]", bt.ctrl.index)
		vendor.AuctionHouse:AddAction(vendor.AuctionHouse.ACTION_CANCEL, bt.ctrl.itemLink)
		CancelAuction(bt.ctrl.index)
		bt.ctrl.decisionMade = true; 
	end);
	
	local cancelBut = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate");
	cancelBut.ctrl = self;
	cancelBut:SetText(L["Cancel"]);
	cancelBut:SetWidth(BUTTON_WIDTH);
	cancelBut:SetHeight(22);
	cancelBut:SetPoint("LEFT", okBut, "RIGHT", BUTTON_GAP, 0);
	cancelBut:SetScript("OnClick", function(bt)
		bt.ctrl.decisionMade = true;  
	end);
	
	vendor.Vendor:Debug("_InitBuyFrame exit")
end

--[[
	Initilaizes the frame.
--]]
local function _InitFrame(self)
	-- create the frame
	local frameName = "VendorCancelAuctionDialog";
	local frame = CreateFrame("Frame", frameName, UIParent, "VendorDialogTemplate");
	frame.ctrl = self;
	self.frame = frame;
	frame:SetWidth(FRAME_WIDTH);
	frame:SetHeight(FRAME_HEIGHT);
	frame:SetPoint("CENTER");
	frame:SetFrameStrata("DIALOG");
	frame:SetMovable(true);
	frame:EnableMouse(true);
	frame:SetToplevel(true);
	frame:SetClampedToScreen(true);
	frame:SetScript("OnMouseDown", function(this) this:StartMoving() end);
	frame:SetScript("OnMouseUp", function(this) this:StopMovingOrSizing() end);
				
	-- create the title string
	local text = frame:CreateFontString(nil, "OVERLAY")
	text:SetPoint("TOP", frame, "TOP", 0, -10)
	text:SetFontObject("GameFontHighlightLarge")
	text:SetText(L["Cancel Auction"])
	
	_InitCancelFrame(self);
	self.cancelFrame:Show();
end

--[[ 
	Creates a new instance.
--]]
function vendor.CancelAuctionDialog:new()
	local instance = setmetatable({}, self.metatable)
	_InitFrame(instance)
	instance.frame:Hide()
	return instance
end

--[[
	Asks the user to buy or bid the given item and performs it.
--]]
function vendor.CancelAuctionDialog.prototype:AskToCancel(itemLink, count, minBid, bidAmount, buyout, index)
	log:Debug("AskToCancel enter index [%s]", index)
	local isShown = self.frame:IsShown();
	local bid = math.max(minBid, bidAmount or 0)
	self.buyout = buyout;
	self.index = index;
	self.count = count;
	if (itemLink) then
		local itemName, itemTexture = vendor.Items:GetItemData(itemLink)
		if (itemName) then
			self.itemIcon:SetNormalTexture(itemTexture);
			self.itemName:SetText(itemName);
			if (count > 1) then
				self.itemCount:SetText(count);
				self.itemCount:Show();
			else
				self.itemCount:Hide();
			end
			self.itemLink = itemLink;
			if (bid and bid > 0) then
				if (count > 1) then
					self.bidBt:SetText(vendor.Format.FormatMoneyValues(bid / count, bid));
				else
					self.bidBt:SetText(vendor.Format.FormatMoney(bid));
				end
			else
				self.bidBt:SetText("")
			end
			if (buyout and buyout > 0) then
				if (count > 1) then
					self.buyoutBt:SetText(vendor.Format.FormatMoneyValues(buyout / count, buyout));
				else
					self.buyoutBt:SetText(vendor.Format.FormatMoney(buyout));
				end
			else
				self.buyoutBt:SetText("")
			end
			self.decisionMade = nil;
			self.name = itemName;
			self.frame:Show();
			_WaitForDecision(self);
			if (not isShown) then
				self.frame:Hide();
			end
		end
	end
	log:Debug("AskToCancel exit")
end

--[[
	Hides the dialog frame.
--]]
function vendor.CancelAuctionDialog.prototype:Hide()
	self.frame:Hide();
end

--[[
	Returns whether the dialog is visible
--]]
function vendor.CancelAuctionDialog.prototype:IsVisible()
	return self.frame:IsVisible()
end
