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

vendor.ScanDialog = {}
vendor.ScanDialog.prototype = {}
vendor.ScanDialog.metatable = {__index = vendor.ScanDialog.prototype}

local log = vendor.Debug:new("ScanDialog")

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
		coroutine.yield(0.2) -- continue waiting
	end	
end

local function _CreateBuyButtons(self, frame)
	local butGrp = CreateFrame("Frame", nil, frame)
	butGrp:SetPoint("TOPLEFT")
	butGrp:SetWidth(FRAME_WIDTH)
	butGrp:SetHeight(FRAME_HEIGHT)
	
	local bidBt = CreateFrame("Button", nil, butGrp, "UIPanelButtonTemplate");
	bidBt:SetText(L["Bid"]);
	bidBt:SetWidth(SMALL_BUTTON_WIDTH);
	bidBt:SetHeight(22);
	bidBt:SetPoint("BOTTOMLEFT", 8, 10);
	bidBt.ctrl = self;
	bidBt:SetScript("OnClick", function(bt) 
		local self = bt.ctrl;
		log:Debug("snipe bid")
		vendor.Sniper:SnipeForItem("list", self.index, self.bid, 0, self.name, self.count);
		self.decisionMade = true; 
	end);
	self.doBidBt = bidBt
	
	local buyBt = CreateFrame("Button", nil, butGrp, "UIPanelButtonTemplate");
	buyBt.ctrl = self;
	buyBt:SetText(L["Buyout"]);
	buyBt:SetWidth(BUTTON_WIDTH);
	buyBt:SetHeight(22);
	buyBt:SetPoint("LEFT", bidBt, "RIGHT", BUTTON_GAP, 0);
	buyBt:SetScript("OnClick", function(bt) 
		local self = bt.ctrl;
		log:Debug("snipe buyout")
		vendor.Sniper:SnipeForItem("list", self.index, 0, self.buyout, self.name, self.count);
		self.decisionMade = true; 
	end);
	self.doBuyoutBt = buyBt;
	
	local pauseBt = vendor.GuiTools.CreateButton(butGrp, "UIPanelButtonTemplate", BUTTON_WIDTH, 22, L["Pause"], L["Pauses any snipes for the current scan."])
	pauseBt:SetPoint("LEFT", buyBt, "RIGHT", BUTTON_GAP, 0);
	pauseBt.ctrl = self;
	pauseBt:SetScript("OnClick", function(bt)
		vendor.Sniper:PauseThisScan();
		vendor.Sniper:StopPendingBuy();
		bt.ctrl.decisionMade = true;		
	end);

--	snipeBt = vendor.GuiTools.CreateButton(butGrp, "UIPanelButtonTemplate", BUTTON_WIDTH, 22, L["Snipe"], L["Opens the snipe dialog for this item."])
--	snipeBt:SetPoint("LEFT", pauseBt, "RIGHT", BUTTON_GAP, 0);
--	snipeBt.ctrl = self;
--	snipeBt:SetScript("OnClick", function(bt) vendor.Scanner.SnipeItem(bt.ctrl.name) end);				
	
	local contBt = CreateFrame("Button", nil, butGrp, "UIPanelButtonTemplate");
	contBt:SetText(L["Continue"]);
	contBt:SetWidth(SMALL_BUTTON_WIDTH);
	contBt:SetHeight(22);
	contBt:SetPoint("LEFT", pauseBt, "RIGHT", BUTTON_GAP, 0);
	contBt.ctrl = self;
	contBt:SetScript("OnClick", function(bt) 
		vendor.Sniper:StopPendingBuy();
		bt.ctrl.decisionMade = true; 
	end);
	self.buyGrp = butGrp
end

local function _CreateAckBuyButtons(self, frame)
	local butGrp = CreateFrame("Frame", nil, frame)
	butGrp:SetPoint("TOPLEFT")
	butGrp:SetWidth(FRAME_WIDTH)
	butGrp:SetHeight(FRAME_HEIGHT)
	
	local okBut = CreateFrame("Button", nil, butGrp, "UIPanelButtonTemplate");
	okBut:SetText(L["Ok"]);
	okBut:SetWidth(BUTTON_WIDTH);
	okBut:SetHeight(22);
	okBut:SetPoint("BOTTOM", -((BUTTON_WIDTH / 2) + (BUTTON_GAP / 2)), 10);
	okBut.ctrl = self;
	okBut:SetScript("OnClick", function(bt) 
		local self = bt.ctrl
		if (self.doBid and not self.doBuyout) then
			log:Debug("doBid")
			vendor.Sniper:SnipeForItem("list", self.index, self.bid, 0, self.name, self.count)
		elseif (self.doBuyout) then
			log:Debug("doBuyout")
			vendor.Sniper:SnipeForItem("list", self.index, 0, self.buyout, self.name, self.count)
		else
			vendor.Sniper:StopPendingBuy()
		end
		self.decisionMade = true; 
	end);
	
	local cancelBut = CreateFrame("Button", nil, butGrp, "UIPanelButtonTemplate");
	cancelBut.ctrl = self;
	cancelBut:SetText(L["Cancel"]);
	cancelBut:SetWidth(BUTTON_WIDTH);
	cancelBut:SetHeight(22);
	cancelBut:SetPoint("LEFT", okBut, "RIGHT", BUTTON_GAP, 0);
	cancelBut:SetScript("OnClick", function(bt)
		vendor.Sniper:StopPendingBuy();
		bt.ctrl.decisionMade = true;  
	end);
	
	self.ackBuyGrp = butGrp
end

--[[
	Create the subframe for buying items.
--]]
local function _InitBuyFrame(self)
	vendor.Vendor:Debug("_InitBuyFrame enter")
	local frame = CreateFrame("Frame", nil, self.frame);
	frame:SetWidth(FRAME_WIDTH);
	frame:SetHeight(FRAME_HEIGHT);
	frame:SetPoint("TOPLEFT");
	self.buyFrame = frame;
	
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
	
	local reason = frame:CreateFontString(nil, "ARTWORK", "GameFontGreen");
	if ( GetLocale() == "zhTW" or GetLocale() == "zhCN" ) then
		reason:SetPoint("TOPLEFT", buyoutLabel, "BOTTOMLEFT", 0, -6);
	else
		reason:SetPoint("TOPLEFT", buyoutLabel, "BOTTOMLEFT", 0, -10);
	end
	self.reasonTxt = reason;

	_CreateBuyButtons(self, frame)
	_CreateAckBuyButtons(self, frame)
	
	vendor.Vendor:Debug("_InitBuyFrame exit")
end

--[[
	Creates the subframe for the scan statistics.
--]]
local function _InitScanFrame(self)
	local frame = CreateFrame("Frame", nil, self.frame);
	frame:SetWidth(FRAME_WIDTH);
	frame:SetHeight(FRAME_HEIGHT);
	frame:SetPoint("TOPLEFT");
	self.scanFrame = frame;
	
	local txt = frame:CreateFontString(nil, "ARTWORK", "GameFontNormal");
	txt:SetPoint("TOP", 0, -35);
	self.scanTxt = txt;
	
	local bt = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate");
	bt.obj = self
	bt:SetText(L["Stop"]);
	bt:SetWidth(86);
	bt:SetHeight(22);
	bt:SetPoint("BOTTOM", 0, 10);
	bt:SetScript("OnClick", function(but) vendor.Scanner:StopScan(); end);
	self.scanBt = bt;
	
	local bt = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate");
	bt:SetText(L["Close"]);
	bt:SetWidth(86);
	bt:SetHeight(22);
	bt:SetPoint("BOTTOM", self.scanBt, "TOPLEFT", 0, 0);
	bt.ctrl = self;
	bt:SetScript("OnClick", function() self.frame:Hide(); end);
	self.closeBt = bt;	
end

--[[
	Initilaizes the frame.
--]]
local function _InitFrame(self)
	-- create the frame
	local frameName = "VendorScanDialog";
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
	text:SetText(L["Auction Scan"])
	
	_InitBuyFrame(self);
	_InitScanFrame(self);
	self.scanFrame:Show();
	self.buyFrame:Hide();	
end

--[[ 
	Creates a new instance.
--]]
function vendor.ScanDialog:new()
	local instance = setmetatable({}, self.metatable)
	_InitFrame(instance)
	instance.frame:Hide()
	return instance
end

--[[
	Asks the user to buy or bid the given item and performs it.
--]]
function vendor.ScanDialog.prototype:AskToBuy(itemLink, count, minBid, bidAmount, minIncrement, buyout, reason, index, doBid, doBuyout, highBidder)
	local isShown = self.frame:IsShown();
	local bid = math.max(minBid, bidAmount or 0)
	self.scanFrame:Hide();
	self.buyFrame:Show()
	if (doBid or doBuyout) then
		log:Debug("doBid: %s doBuyout: %s", doBid or "false", doBuyout or "false")
		self.buyGrp:Hide()
		self.ackBuyGrp:Show()
	else
		log:Debug("doBid and doBuyout where not set")
		self.buyGrp:Show()
		self.ackBuyGrp:Hide()
	end
	if (highBidder) then
		self.doBidBt:Disable()
	else
		self.doBidBt:Enable()
	end
	self.doBuyoutBt:Disable();
	self.bid = math.max(minBid, (bidAmount or 0) + (minIncrement or 0))
	self.buyout = buyout;
	self.doBid = doBid
	self.doBuyout = doBuyout
	self.index = index;
	self.count = count;
	if (itemLink) then
		local texture
		local name, speciesId, level, breedQuality, maxHealth, power, speed = vendor.Items:GetBattlePetStats(itemLink)
		if (name) then
			texture = select(2, C_PetJournal.GetPetInfoBySpeciesID(speciesId))
		else
			local itemName, _, _, _, _, _, _, _, _, itemTexture = GetItemInfo(itemLink)
			name = itemName
			texture = itemTexture
		end
		if (name) then
			self.itemIcon:SetNormalTexture(texture)
			self.itemName:SetText(name)
			if (count > 1) then
				self.itemCount:SetText(count)
				self.itemCount:Show()
			else
				self.itemCount:Hide()
			end
			self.itemLink = itemLink
			if (bid and bid > 0) then
				if (count > 1) then
					self.bidBt:SetText(vendor.Format.FormatMoneyValues(bid / count, bid))
				else
					self.bidBt:SetText(vendor.Format.FormatMoney(bid))
				end
			else
				self.bidBt:SetText("")
			end
			if (buyout and buyout > 0) then
				if (count > 1) then
					self.buyoutBt:SetText(vendor.Format.FormatMoneyValues(buyout / count, buyout))
				else
					self.buyoutBt:SetText(vendor.Format.FormatMoney(buyout))
				end
			else
				self.buyoutBt:SetText("")
			end
			self.reasonTxt:SetText(reason)
			self.decisionMade = nil
			self.name = name
			if (buyout and buyout > 0) then
				self.doBuyoutBt:Enable()
			end
			PlaySound(SOUNDKIT.AUCTION_WINDOW_OPEN)
			self.frame:Show()
			_WaitForDecision(self)
			if (not isShown) then
				self.frame:Hide()
			end
		end
	end
	self.scanFrame:Show()
	self.buyFrame:Hide()
end

--[[
	Shows the given scan progress message.
--]]
function vendor.ScanDialog.prototype:ShowProgress(msg)
	if (not self.frame:IsShown()) then
		self.frame:Show();
	end
	if (not self.scanBt:IsShown()) then
		self.scanBt:Show();
	end
	if (self.closeBt:IsShown()) then
		self.closeBt:Hide();
	end
	self.scanTxt:SetText(msg);
end

--[[
	Hides the dialog frame.
--]]
function vendor.ScanDialog.prototype:Hide()
	self.frame:Hide();
end

--[[
	Returns whether the dialog is visible
--]]
function vendor.ScanDialog.prototype:IsVisible()
	return self.frame:IsVisible()
end

--[[
	Converts the "Stop" to a "Close" button.
--]]
function vendor.ScanDialog.prototype:ShowCloseButton()
	self.closeBt:Show();
	self.scanBt:Hide();
end

--[[
	Hides the "Stop" button.
--]]
function vendor.ScanDialog.prototype:HideStopButton()
	self.scanBt:Hide();
end
