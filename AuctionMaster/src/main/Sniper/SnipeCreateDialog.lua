--[[
	Dialog for genereting new auction snipes.
	
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

vendor.SnipeCreateDialog = {}
vendor.SnipeCreateDialog.prototype = {}
vendor.SnipeCreateDialog.metatable = {__index = vendor.SnipeCreateDialog.prototype}

local L = vendor.Locale.GetInstance()

--[[
	Sets the given name and lookup for already known prizes.
--]]
local function _SetName(self, name)
	self.deleteBt:Disable();
	MoneyInputFrame_SetCopper(self.bid, 0);
	MoneyInputFrame_SetCopper(self.buyout, 0);
	if (name) then
		self.itemName:SetText(name);
		local maxBid, maxBuyout = vendor.Sniper:GetWanted(name);
		MoneyInputFrame_SetCopper(self.bid, maxBid);
		MoneyInputFrame_SetCopper(self.buyout, maxBuyout);
		if (maxBid > 0 or maxBuyout > 0) then
			self.deleteBt:Enable();
		end
	end
end

--[[
	Picks an item from the cursor in the given edit box.
--]]
local function _PickItem(bt)
	local self = bt.ctrl;
	local infoType, itemId, itemLink = GetCursorInfo();
	if (infoType == "item") then
		local name = GetItemInfo(itemLink);
		_SetName(self, name);
		ClearCursor();
	end
end

--[[
	Initilaizes the frame.
--]]
local function _InitFrame(self)
	local frameName = "VendorSnipeCreateDialog";
	local frame = CreateFrame("Frame", frameName, UIParent, "VendorDialogTemplate");
	self.frame = frame;
	frame:SetWidth(292);
	frame:SetHeight(175);
	frame:SetPoint("CENTER");
	frame:SetFrameStrata("DIALOG");
	frame:SetMovable(true);
	frame:EnableMouse(true);
	frame:SetToplevel(true);
	frame:SetClampedToScreen(true);
	frame:SetScript("OnMouseDown", function(self) self:StartMoving() end);
	frame:SetScript("OnMouseUp", function(self) self:StopMovingOrSizing() end);
		
	-- create the title string
	local text = frame:CreateFontString(nil, "OVERLAY");
	text:SetPoint("TOP", frame, "TOP", 0, -10);
	text:SetFontObject("GameFontHighlightLarge");
	text:SetText(L["Set snipe"]);
	
	local nameLabel = frame:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall");
	nameLabel:SetText(L["Name:"]);
	if ( GetLocale() == "zhTW" or GetLocale() == "zhCN" ) then
		nameLabel:SetPoint("TOPLEFT", 10, -36);
	else
	    nameLabel:SetPoint("TOPLEFT", 10, -39);
	end
		
	local bt = CreateFrame("EditBox", nil, frame, "InputBoxTemplate");
	bt.ctrl = self;
	bt:SetMaxLetters(256);
	bt:SetFontObject(ChatFontNormal)
	bt:SetWidth(225);
	bt:SetHeight(22);
	bt:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -10, -35);
	bt:SetAutoFocus(true);
	bt:SetScript("OnEscapePressed", function(this) this:ClearFocus(); end);
	bt:SetScript("OnChar", function(this)
		local self = this.ctrl;
		local maxBid, maxBuyout = vendor.Sniper:GetWanted(this:GetText());
		if (maxBid > 0 or maxBuyout > 0) then
			MoneyInputFrame_SetCopper(self.bid, maxBid);
			MoneyInputFrame_SetCopper(self.buyout, maxBuyout);
		end			
	end);
	bt:SetScript("OnDragStart", function(this) _PickItem(this);	end);
	bt:SetScript("OnReceiveDrag", function(this) _PickItem(this); end);
	vendor.GuiTools.AddTooltip(bt, L["Type in name of the item here,/nor just drop it in."]);
	self.itemName = bt;
	
	local bidLabel = frame:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall");
	bidLabel:SetText(L["Bid:"]);
	if ( GetLocale() == "zhTW" or GetLocale() == "zhCN" ) then
		bidLabel:SetPoint("TOPLEFT", nameLabel, "BOTTOMLEFT", 0, -20);
	else
	    bidLabel:SetPoint("TOPLEFT", nameLabel, "BOTTOMLEFT", 0, -26);
	end

	bt = CreateFrame("Frame", frameName.."Bid", frame, "MoneyInputFrameTemplate");
	bt:SetPoint("TOPRIGHT", self.itemName, "BOTTOMRIGHT", 10, -14);
	local gold = getglobal(bt:GetName().."Gold");
	gold:SetMaxLetters(6);
	self.bid = bt;
	
	local buyoutLabel = frame:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall");
	buyoutLabel:SetText(L["Buyout:"]);
	if ( GetLocale() == "zhTW" or GetLocale() == "zhCN" ) then
		buyoutLabel:SetPoint("TOPLEFT", bidLabel, "BOTTOMLEFT", 0, -20);
	else
	    buyoutLabel:SetPoint("TOPLEFT", bidLabel, "BOTTOMLEFT", 0, -24);
	end

	bt = CreateFrame("Frame", frameName.."Buyout", frame, "MoneyInputFrameTemplate");
	bt:SetPoint("TOPRIGHT", self.bid, "BOTTOMRIGHT", 0, -14);
	local gold = getglobal(bt:GetName().."Gold");
	gold:SetMaxLetters(6);
	self.buyout = bt;
	
	bt = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate");
	bt:SetText(L["Set"]);
	bt:SetWidth(86);
	bt:SetHeight(22);
	bt:SetPoint("BOTTOMLEFT", 10, 10);
	bt.ctrl = self;
	bt:SetScript("OnClick", function(but)
		local self = but.ctrl;
		local bid = MoneyInputFrame_GetCopper(self.bid) or 0;
		local buyout = MoneyInputFrame_GetCopper(self.buyout) or 0;
		local name = self.itemName:GetText() or "";
		vendor.Sniper:SetSnipeInfo(name, bid, buyout);
		frame:Hide();
	end);	

	bt = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate");
	bt:SetText(L["Delete"]);
	bt:SetWidth(86);
	bt:SetHeight(22);
	bt:SetPoint("BOTTOM", 0, 10);
	bt:SetScript("OnClick", function()
		local name = self.itemName:GetText() or "";
		vendor.Sniper:SetSnipeInfo(name, 0, 0);	
		MoneyInputFrame_SetCopper(self.bid, 0);
		MoneyInputFrame_SetCopper(self.buyout, 0);
	end);	
	self.deleteBt = bt;
	
	bt = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate");
	bt:SetText(L["Cancel"]);
	bt:SetWidth(86);
	bt:SetHeight(22);
	bt:SetPoint("BOTTOMRIGHT", -10, 10);
	bt:SetScript("OnClick", function() frame:Hide(); end);	
		
	-- focus rules
	MoneyInputFrame_SetPreviousFocus(self.bid, getglobal(self.buyout:GetName().."Copper"));
	MoneyInputFrame_SetNextFocus(self.bid, getglobal(self.buyout:GetName().."Gold"));
	MoneyInputFrame_SetPreviousFocus(self.buyout, getglobal(self.bid:GetName().."Copper"));
	MoneyInputFrame_SetNextFocus(self.buyout, getglobal(self.bid:GetName().."Gold"));
end

--[[ 
	Creates a new instance.
--]]
function vendor.SnipeCreateDialog:new()
	local instance = setmetatable({}, self.metatable)
	_InitFrame(instance)
	instance.frame:Hide()
	return instance
end

--[[
	Shows the dialog and empties all input fields. The name is optional
--]]
function vendor.SnipeCreateDialog.prototype:Show(name)
	self.frame:Show()
	self.itemName:SetText("")
	if (not name) then
		local tabType = vendor.AuctionHouse:GetCurrentAuctionHouseTab()
		if (tabType == "list" or tabType == "bidder" or tabType == "owner") then
			if (tabType == "owner") then
				name = vendor.OwnAuctions:GetSingleSelected()
			end
			if (not name) then
    			local index = GetSelectedAuctionItem(tabType)
    			if (index and index > 0) then
    				name = GetAuctionItemInfo(tabType, index)
    			end
    		end
		elseif (tabType == "seller") then
			name = vendor.Seller:GetSelectedItemInfo()
		elseif (tabType == "scan") then
			name = vendor.SearchTab:GetSingleSelected() 
		end
	end
	_SetName(self, name)
end
