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
   
vendor.OwnAuctions = vendor.Vendor:NewModule("OwnAuctions", "AceEvent-3.0")
local L = vendor.Locale.GetInstance()
local log = vendor.Debug:new("OwnAuctions")

local SMALL_WIDTH = 609
local LARGE_WIDTH = 609 + 200
local HEIGHT = 358
local SMALL_X_OFF = 218
local LARGE_X_OFF = 218 - 200
local Y_OFF = -51

local TAB_TYPE = "own_auctions"

local DEFAULT_SELECTED = {
	vendor.OwnAuctionsItemModel.TEXTURE,
	vendor.OwnAuctionsItemModel.NAME,
	vendor.OwnAuctionsItemModel.TIME_LEFT,
	vendor.OwnAuctionsItemModel.BID,
	vendor.OwnAuctionsItemModel.BUYOUT,
	vendor.OwnAuctionsItemModel.CURRENT_AUCTIONS,
	vendor.OwnAuctionsItemModel.LOWER_BUYOUT,
	vendor.OwnAuctionsItemModel.AVG_BUYOUT
}

local function _ApplyExtraLarge(self)
	log:Debug("_ApplyExtraLarge")
	if (self.db.profile.extraLarge) then
		self.itemTable:SetDimensions(LARGE_WIDTH, HEIGHT, LARGE_X_OFF, Y_OFF)
		AuctionFrameTopLeft:SetTexture("Interface\\AuctionFrame\\UI-AuctionFrame-Bid-TopLeft");
--		AuctionsItemButton:Hide()
--		PriceDropDown:Hide()
--		DurationDropDown:Hide()
--		StartPrice:Hide()
--		BuyoutPrice:Hide()
--		AuctionsDepositMoneyFrame:Hide()
--		AuctionsCreateAuctionButton:Hide()
--		AuctionsTabText:Hide()
	else
		self.itemTable:SetDimensions(SMALL_WIDTH, HEIGHT, SMALL_X_OFF, Y_OFF)
		AuctionFrameTopLeft:SetTexture("Interface\\AuctionFrame\\UI-AuctionFrame-Auction-TopLeft");
--		AuctionsItemButton:Show()
--		PriceDropDown:Show()
--		DurationDropDown:Show()
--		StartPrice:Show()
--		BuyoutPrice:Show()
--		AuctionsDepositMoneyFrame:Show()
--		AuctionsCreateAuctionButton:Show()
--		AuctionsTabText:Show()
	end
end

local function _ApplySettings(self)
	log:Debug("_ApplySettings")
	if (self.db.profile.itemTableActivated) then
		_ApplyExtraLarge(self)
		self:Update()
	end
end

local function _SetValue(info, value)
	vendor.OwnAuctions.db.profile[info.arg] = value
	_ApplySettings(vendor.OwnAuctions)
end

local function _GetValue(info)
	return vendor.OwnAuctions.db.profile[info.arg]
end

--[[
	An item was doubleclicked and will now be searched.
--]]
local function _SearchItem(idx, self)
	local index, itemLinkKey, itemLink, name = self.itemModel:Get(idx)
	vendor.AuctionHouse:SelectTab(1)
	if (name) then
		-- too long names may cause a disconnect
		name = string.sub(name, 1, 62)
	end
	local _, _, _, _, _, itemClass, itemSubClass = GetItemInfo(itemLink)
	local itemClassId = vendor.AuctionHouse:GetItemClassId(itemClass)
	--local itemSubClassId = vendor.AuctionHouse:GetItemSubClassId(itemSubClass)
	log:Debug("name [%s] itemClassId [%s] itemSubClassId [%s]", name, itemClassId, itemSubClassId)
	local filterData;
	--			if (info.classIndex and info.subclassIndex and subSubCategoryIndex) then
	--				filterData = AuctionCategories[info.classIndex].subCategories[info.subclassIndex].subCategories[subSubCategoryIndex].filters;
	-- FIXME
	--			if (info.classIndex and info.subclassIndex) then
	--				filterData = AuctionCategories[info.classIndex].subCategories[info.subclassIndex].filters;
	--			elseif (info.classIndex) then
	--				filterData = AuctionCategories[info.classIndex].filters;
	--			else
	--				-- not filtering by category, leave nil for all
	--			end
	QueryAuctionItems(name, 0, 0, 0, 0, 0, false, false, filterData);
	--QueryAuctionItems(name, "", "", 0, itemClassId or 0, 0, 0, 0, 0)
end

local function _CancelAuctionsTable(self, auctions)
	-- I want to cancel them backwards, just in case
	local task = vendor.CancelAuctionTask:new(auctions)
	vendor.TaskQueue:AddTask(task)
--		
--	table.sort(auctions, function(a, b) return a.index > b.index end)
--	for k,v in pairs(auctions) do
--		local origName, _, origCount, _, _, _, unknown, origMinBid, _, origBuyout, origBidAmount = GetAuctionItemInfo("owner", v.index)
--		log:Debug("origName: %s name: %s index: %s", origName, v.name, v.index)
--		if (v.name == origName and v.count == origCount) then
--			CancelAuction(v.index)
--		else
--			-- TODO and now?
--			log:Debug("auction doesn't match, name: %s origName: %s index: %s", v.name, v.origName, v.index)
--		end
--	end
end

local function _CancelAuctions(self)
	log:Debug("_CancelAuctions")
	local auctions = wipe(self.cancelAuctions)
	for _, row in pairs(self.itemModel:GetSelectedItems()) do
		local index, itemLinkKey, itemLink, name, _, count, bid, buyout, lowerBuyout, saleStatus, _, 
    					minBid, bidAmount = self.itemModel:Get(row)
		--local index, _, _, name, _, count, _, _, _, saleStatus = self.itemModel:Get(row)
		if (saleStatus ~= 1) then
			table.insert(auctions, {index = index, itemLink = itemLink, name = name, count = count, minBid = minBid, buyout = buyout, bidAmount = bidAmount})
			--table.insert(auctions, {index = index, name = name, count = count})
		else
			vendor.Vendor:Error(L["Can't cancel already sold auction"])
		end
	end
	if (#auctions == 1) then
		vendor.AuctionHouse:AddAction(vendor.AuctionHouse.ACTION_CANCEL, auctions[1].itemLink)
		CancelAuction(auctions[1].index)
	elseif (#auctions > 1) then
		_CancelAuctionsTable(self, auctions)
	end
end

local function _CancelUndercut(self)
	log:Debug("_CancelUndercut")
	local auctions = wipe(self.cancelAuctions)
	local hasOutDated = false
	for row=1,self.itemModel:Size() do
		local index, _, itemLink, name, _, count, bid, buyout, lowerBuyout, saleStatus, outDated, minBid, bidAmount, highBidder = self.itemModel:Get(row)
		if (lowerBuyout and lowerBuyout > 0 and lowerBuyout < (buyout / count) and 
			saleStatus ~= 1 and (highBidder == nil or highBidder == 0)) then
			if (not outDated) then
				table.insert(auctions, {index = index, itemLink = itemLink, name = name, count = count, buyout = buyout, minBid = minBid, bidAmount = bidAmount})
			else
				log:Debug("index [%s] name [%s] bid [%s] buyout [%s] count [%s] is outdated", index, name, bid, buyout, count)
				hasOutDated = true
			end
		end
	end
	if (hasOutDated) then
		vendor.Vendor:Print(L["There are out-dated statistics, you should press the scan-button first."])
	end
	_CancelAuctionsTable(self, auctions)
end

--[[
	Will be called after an item has been scanned.
--]]
local function _ScanAuctionsProgress(self, result)
	local scanId = result.scanId
	log:Debug("_ScanAuctionsProgress result: %s scanId: %s", result, scanId)
	if (scanId) then
		for i=1,#self.itemsToScan do
			if (self.itemsToScan[i].scanId and self.itemsToScan[i].scanId == scanId) then
				table.remove(self.itemsToScan, i)
				break
			end
		end
    	if (#self.itemsToScan > 0) then
    		local item = self.itemsToScan[1]
--    		vendor.Scanner:ShowScanStatus(L["Scanning auction %s/%s"]:format(item.index, self.numItemsToScan), true)
--    		vendor.Scanner.scanDialog:HideStopButton()
    		local scanId = vendor.Scanner:Scan(item.itemLink, true, _ScanAuctionsProgress, self)
    		self.itemsToScan[1].scanId = scanId
    		
    		local scanned = self.numItemsToScan - #self.itemsToScan
    		local msg = scanned.."/"..self.numItemsToScan
    		self:SetProgress(msg, scanned / self.numItemsToScan)
    	else
    		self:ScanFinished()
    	end
	else
		vendor.Vendor:Error("missing scanId for scan")
	end
end

local function _ScanAuctions(self)
	log:Debug("_ScanAuctions")
	self.itemsToScan = wipe(self.itemsToScan or {})
	self.scanNames = wipe(self.scanNames or {}) 
	for i=1,self.itemModel:Size() do
		local _, itemLinkKey, itemLink, name = self.itemModel:Get(i)
		if (not self.scanNames[name]) then
			table.insert(self.itemsToScan, {name = name, itemLinkKey = itemLinkKey, itemLink = itemLink, index = #self.itemsToScan + 1})
			self.scanNames[name] = true
		end
	end
	if (#self.itemsToScan > 0) then
		self.numItemsToScan = #self.itemsToScan
		local item = self.itemsToScan[1]
		log:Debug("Scan for: %s", item.name)
		--vendor.Scanner:ShowScanStatus(L["Scanning auction %s/%s"]:format(item.index, self.numItemsToScan), true)
		--vendor.Scanner.scanDialog:HideStopButton()
		local scanId = vendor.Scanner:Scan(item.itemLink, true, _ScanAuctionsProgress, self)
		log:Debug("created scanId: %s", scanId)
		self.itemsToScan[1].scanId = scanId
	else
		vendor.Vendor:Print(L["There are no auctions to be scanned."])
	end
end

local function _OnUpdate(frame)
	local self = frame.obj
end

local function _InitFrame(self)
	local frame = vendor.AuctionHouse:CreateTabFrame("AMOwnAuctions", L["Auctions"], L["Auctions"], self, 3)
	frame.obj = self
	frame:SetScript("OnUpdate", _OnUpdate)
	vendor.AuctionHouse:CreateCloseButton(frame, "AMOwnAuctionsClose")
	self.frame = frame
end

--[[
	Initializes the module.
--]]
function vendor.OwnAuctions:OnInitialize()
	self.db = vendor.Vendor.db:RegisterNamespace("OwnAuctions", {
		profile = {
    		itemTableCfg = {
    			size = 100,
    			rowHeight = 24,
    			selected = {}
--				selected = {
--					[1] = vendor.OwnAuctionsItemModel.TEXTURE,
--					[2] = vendor.OwnAuctionsItemModel.NAME,
--					[3] = vendor.OwnAuctionsItemModel.TIME_LEFT,
--					[4] = vendor.OwnAuctionsItemModel.BID,
--					[5] = vendor.OwnAuctionsItemModel.BUYOUT,
--					[6] = vendor.OwnAuctionsItemModel.CURRENT_AUCTIONS,
--					[7] = vendor.OwnAuctionsItemModel.LOWER_BUYOUT,
--					[8] = vendor.OwnAuctionsItemModel.AVG_BUYOUT,
--				},
    		},
    		itemTableActivated = true,
    		extraLarge = true,
    		outDatedTimeout = 300
    	}
	})
	self.cancelAuctions = {}
	self.tmpList1 = {}
end

--[[
	Initializes the scanner at startup and registers for the needed events.
--]]
function vendor.OwnAuctions:OnEnable()
end

function vendor.OwnAuctions:InitTab()

	-- won't be persisted otherwise, seems to be a bug
	if (#self.db.profile.itemTableCfg.selected == 0) then
		vendor.Tables.Copy(DEFAULT_SELECTED, self.db.profile.itemTableCfg.selected)
	end

	_InitFrame(self)

	self.itemModel = vendor.OwnAuctionsItemModel:new()
	self.updateFrame = CreateFrame("Frame", nil)
	self.updateFrame.obj = self
	self.updateFrame:SetScript("OnUpdate", _OnUpdate)
	local cfg = {
		name = "AMOwnAuctions",
		parent = self.frame,
		itemModel = self.itemModel,
		cmds = vendor.Vendor:OrderTable({
			cancel = {
				title = L["Cancel Auctions"],
				tooltip = L["Auctions may be selected with left clicks. Press the ctrl button, if you want to select multiple auctions. Press the shift button, if you want to select a range of auctions."].." "..L["Cancels the selected auctions with just one click."],
				arg1 = vendor.OwnAuctions,
				width = 125,
				func = function(arg1) _CancelAuctions(arg1) end,
				enabledFunc = function(arg1)
					local selectedItems = arg1.itemModel:GetSelectedItems()
					return #selectedItems > 0
				end,
				order = 12
			},
			cancelUndercut = {
				title = L["Cancel Undercut"],
				tooltip = L["Automatically cancels all auctions where you have been undercut. There is no need to select them. Out-dated (greyed-out) statistics won't be considered, you have to press the scan button to refresh them."],
				arg1 = vendor.OwnAuctions,
				width = 135,
				func = function(arg1) _CancelUndercut(arg1) end,
				order = 11
			},
			scan = {
				title = L["Scan Auctions"],
				tooltip = L["Scans the auction house for your own auctions to update the statistics. Afterwards you will be able to see, whether you have been undercut (lower buyouts do exist). "],
				arg1 = vendor.OwnAuctions,
				width = 125,
				func = function(arg1) _ScanAuctions(arg1) end,
				order = 10
			}
		}),
		config = self.db.profile.itemTableCfg,
		width = SMALL_WIDTH,
		height = HEIGHT,
		xOff = SMALL_X_OFF,
		yOff = Y_OFF,
		menuCmds = vendor.Vendor:OrderTable({
			extraLarge = {
				type = "toggle",
				text = L["Extra Large"],
				arg = "extraLarge",
				set = _SetValue,
				get = _GetValue,
				order = 2
			},
		})
	}
	self.itemTable = vendor.ItemTable:new(cfg)
	self.itemTable:SetDoubleClickCallback(_SearchItem, self)
	self.itemModel:SetWithBidHighlight(self.itemTable:AddHighlight(0.6, 0.6, 1, 0.8))
	self.itemModel:SetSoldHighlight(self.itemTable:AddHighlight(0.6, 1, 1, 0.8))
	self.itemModel:SetUndercutHighlight(self.itemTable:AddHighlight(1, 0.4, 0.4, 0.8))

	local statusBar = CreateFrame("StatusBar", nil, self.frame, "TextStatusBar")
	statusBar.obj = self
	statusBar:SetHeight(14)
	statusBar:SetWidth(622)
	statusBar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
	statusBar:SetPoint("TOPLEFT", 70, -17)
	statusBar:SetMinMaxValues(0, 1)
	statusBar:SetValue(1)
	statusBar:SetStatusBarColor(0, 1, 0)

	local statusBarText = statusBar:CreateFontString(nil, "ARTWORK")
	statusBarText:SetPoint("CENTER", statusBar)
	statusBarText:SetFontObject("GameFontHighlightSmall")

	_ApplySettings(self)
	self:RegisterEvent("AUCTION_OWNED_LIST_UPDATE")
	self:RegisterMessage("AUCTION_STATISTIC_UPDATE")

	self.statusBar = statusBar
	self.statusBarText = statusBarText
	--	self.title = AuctionsTitle

	self:SetProgress("", 0)
end

--[[
	Updates the auctions table.
--]]
function vendor.OwnAuctions:Update()
	log:Debug("Update")
	self.itemModel:Update()
	self.itemTable:Show()
end

--[[
	The auctions tab has been selected.
--]]
function vendor.OwnAuctions:Show()
	log:Debug("Show")
	self:SetProgress("", 0)
	_ApplySettings(self)
	--_SetBackground(self)
	if (self.db.profile.itemTableActivated) then
		GetOwnerAuctionItems()
		self:Update()
	end
end

--[[
	Signals that the own auctions are not shown currently. This may save some resources.
--]]  
function vendor.OwnAuctions:Hide()
	self.itemTable:Hide()
end

--[[
	Returns the name of the single selected item, if any. Returns nil, if no item is selected. 
--]]
function vendor.OwnAuctions:GetSingleSelected()
	local map = self.itemModel:GetSelectedItems()
	if (#map > 0) then
		local _, _, _, name = self.itemModel:Get(map[1])
		return name
	end
	return nil
end

--[[
	Handles updates to the auctions list.
--]]
function vendor.OwnAuctions:AUCTION_OWNED_LIST_UPDATE()
	log:Debug("AUCTION_OWNED_LIST_UPDATE enter")
	if (self:IsVisible()) then
		self:Update()
	end
	log:Debug("AUCTION_OWNED_LIST_UPDATE exit")
end

--[[
	Some auction statistics has been changed.
--]]
function vendor.OwnAuctions:AUCTION_STATISTIC_UPDATE(event, itemLinkKey)
	if (self:IsVisible()) then
		log:Debug("AUCTION_STATISTIC_UPDATE itemLinkKey [%s]", itemLinkKey)
		self.itemModel:UpdateAuctionStatistics(itemLinkKey)
	end
end

--[[
	Returns whether the own auctions tab is currently visible.
--]]
function vendor.OwnAuctions:IsVisible()
	local tabType = vendor.AuctionHouse:GetCurrentAuctionHouseTab()
	return tabType == TAB_TYPE and self.db.profile.itemTableActivated
end

--[[
	Cancels the given list of auctions. The given table has to contain entries with the following information:
	itemLinkKey, minBid, buyout, count 
--]]
function vendor.OwnAuctions:CancelAuctions(auctions)
	log:Debug("CancelAuctions auctions [%s]", #auctions)
	local cancelAuctions = wipe(self.cancelAuctions)
	local tmp = wipe(self.tmpList1)
	
	local numAuctions = GetNumAuctionItems("owner")
	local n = #auctions
	for index=1,numAuctions do
		local name, texture, count, quality, _, level, unknown, minBid, minIncrement, buyout, bidAmount, highBidder, bidderFullName, owner, ownerFullName, saleStatus = GetAuctionItemInfo("owner", index)
		local itemLink = GetAuctionItemLink("owner", index)
		local itemLinkKey = vendor.Items:GetItemLinkKey(itemLink)
		
		for i=1,n do
			local info = auctions[i]
			local saleStatusProblem = false
			if (not tmp[i]) then
    			log:Debug("cmp [%s] [%s] [%s] [%s] [%s] [%s] [%s] [%s]", itemLinkKey, info.itemLinkKey, minBid, info.minBid,
    					buyout, info.buyout, count, info.count)
    			if (itemLinkKey == info.itemLinkKey and minBid == info.minBid and
    					buyout == info.buyout and count == info.count) then
    				if (saleStatus == 1) then
    					saleStatusProblem = true
    				else
    					log:Debug("FOUND MATCH")
    					table.insert(cancelAuctions, {index = index, itemLink = itemLink, name = name, count = count, minBid = minBid, buyout = buyout, bidAmount = bidAmount})
    					saleStatusProblem = false
    					tmp[i] = true
    					break
    				end
    			end
    		end
		end
		if (saleStatusProblem) then
			vendor.Vendor:Error(L["Can't cancel already sold auction"])
		end
	end
	log:Debug("CancelAuctions size [%s]", #cancelAuctions)
	if (#cancelAuctions > 0) then
		--_CancelAuctionsTable(self, cancelAuctions)
		local task = vendor.CancelAuctionTask:new(cancelAuctions)
		vendor.TaskQueue:AddTask(task)
	end
end

function vendor.OwnAuctions:SetProgress(msg, percent)
	self.statusBar:SetValue(percent)
	self.statusBarText:SetText(msg)
	if (msg and strlen(msg) > 0) then
		self.title:Hide()
		self.statusBar:Show()
		self.statusBarText:Show()
	else
		self.title:Show()
		self.statusBar:Hide()
		self.statusBarText:Hide()
	end
end

function vendor.OwnAuctions:ScanFinished()
	if (self.frame:IsVisible()) then
		PlaySound(SOUNDKIT.AUCTION_WINDOW_CLOSE)
		self:SetProgress("", 0)
	end
end

function vendor.OwnAuctions:UpdateTabFrame()
	AuctionFrameTop:SetTexture("Interface\\AuctionFrame\\UI-AuctionFrame-Auction-Top")
	AuctionFrameTopRight:SetTexture("Interface\\AuctionFrame\\UI-AuctionFrame-Auction-TopRight")
	AuctionFrameBotLeft:SetTexture("Interface\\AuctionFrame\\UI-AuctionFrame-Bid-BotLeft")
	AuctionFrameBot:SetTexture("Interface\\AuctionFrame\\UI-AuctionFrame-Auction-Bot")
	AuctionFrameBotRight:SetTexture("Interface\\Addons\\AuctionMaster\\src\\resources\\UI-AuctionFrame-Auction-BotRight")
	if (self.db.profile.extraLarge) then
		AuctionFrameTopLeft:SetTexture("Interface\\AuctionFrame\\UI-AuctionFrame-Bid-TopLeft")
	else
		AuctionFrameTopLeft:SetTexture("Interface\\AuctionFrame\\UI-AuctionFrame-Auction-TopLeft")
	end

	self:Show()
end

function vendor.OwnAuctions:GetTabType()
	return TAB_TYPE
end

function vendor.OwnAuctions:ShowTabFrame()
	self.frame:Show()
	self:UpdateTabFrame()
end

function vendor.OwnAuctions:HideTabFrame()
	self.frame:Hide()
end

function vendor.OwnAuctions:GetTabId()
	return self.id
end