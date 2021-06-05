--[[
	Scans the auction house with configurable requests.
	
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
   
vendor.Scanner = vendor.Vendor:NewModule("Scanner", "AceEvent-3.0", "AceHook-3.0");
local L = vendor.Locale.GetInstance()
local self = vendor.Scanner;
local log = vendor.Debug:new("Scanner")

local SCANNER_VERSION = 8
vendor.Scanner.QUALITY_INDEX = {
	[0] = vendor.Format.ColorizeQuality(L["Poor"], 0), 
	[1] = vendor.Format.ColorizeQuality(L["Common"], 1),
	[2] = vendor.Format.ColorizeQuality(L["Uncommon"], 2),
	[3] = vendor.Format.ColorizeQuality(L["Rare"], 3),
	[4] = vendor.Format.ColorizeQuality(L["Epic"], 4),
	[5] = vendor.Format.ColorizeQuality(L["Legendary"], 5),
	[6] = vendor.Format.ColorizeQuality(L["Artifact"], 6),
} 
vendor.Scanner.MIN_QUALITIES = {
	[vendor.Scanner.QUALITY_INDEX[0]] = 0,
	[vendor.Scanner.QUALITY_INDEX[1]] = 1,
	[vendor.Scanner.QUALITY_INDEX[2]] = 2,
	[vendor.Scanner.QUALITY_INDEX[3]] = 3,
	[vendor.Scanner.QUALITY_INDEX[4]] = 4,
	[vendor.Scanner.QUALITY_INDEX[5]] = 5,
	[vendor.Scanner.QUALITY_INDEX[6]] = 6,
}

vendor.Scanner.SCAN_SPEED_OFF = 0
vendor.Scanner.SCAN_SPEED_SLOW = 1
vendor.Scanner.SCAN_SPEED_MEDIUM = 2
vendor.Scanner.SCAN_SPEED_FAST = 3
vendor.Scanner.SCAN_SPEED_HURRY = 4

-- not needed anymore
vendor.Scanner.SPEEDS = {
	[vendor.Scanner.SCAN_SPEED_OFF] = 0,
	[vendor.Scanner.SCAN_SPEED_SLOW] = 200,
	[vendor.Scanner.SCAN_SPEED_MEDIUM] = 400,
	[vendor.Scanner.SCAN_SPEED_FAST] = 700,
	[vendor.Scanner.SCAN_SPEED_HURRY] = 1200
}

vendor.Scanner.DELAYS = {
	[vendor.Scanner.SCAN_SPEED_OFF] = 0,
	[vendor.Scanner.SCAN_SPEED_SLOW] = 0.4,
	[vendor.Scanner.SCAN_SPEED_MEDIUM] = 0.2,
	[vendor.Scanner.SCAN_SPEED_FAST] = 0.075,
	[vendor.Scanner.SCAN_SPEED_HURRY] = 0
}

--[[
	Migrates the database.
--]]
local function _MigrateDb(self)
	local oldDb = vendor.Vendor.oldDb:AcquireDBNamespace("Scanner")
	if (not self.db.factionrealm.version or self.db.factionrealm.version < 7) then
		-- migrate old "realm" to "factionrealm"
		self.db.factionrealm.snapshot = oldDb.realm.snapshot or {}
		oldDb.realm.snapshot = nil
	end	
	if (not self.db.realm.version or self.db.realm.version < 7) then
		-- migrate old "server" to "realm"
		self.db.realm.snapshot = oldDb.server.snapshot or {}
		oldDb.server.snapshot = nil
	end	
	if (not self.db.profile.version or self.db.profile.version < 7) then
		self.db.profile.minQuality = vendor.Scanner.MIN_QUALITIES[self.db.profile.minQuality] or 1
	end
	if (not self.db.factionrealm.version or self.db.factionrealm.version < 8) then
		self.db.factionrealm.snapshot = nil
	end
	if (not self.db.realm.version or self.db.realm.version < 8) then
		self.db.realm.snapshot = nil
	end
	self.db.factionrealm.version = SCANNER_VERSION
	self.db.realm.version = SCANNER_VERSION
	self.db.profile.version = SCANNER_VERSION
end

--[[
	Sorts the scnasnaphot listeners according their order.
--]]
local function _SortScanSnapshotListeners(a, b)
	return a.order < b.order;
end

--[[
	Informs any listener about the abortion of a scan.
--]]
local function _NotifySnapshotAborted(self)
	if (self.scanResultListeners) then
		for _, listener in ipairs(self.scanResultListeners) do
			if (listener.listener.ScanAborted) then
				vendor.Vendor:Debug("inform listener about abortion");
				listener.listener:ScanAborted();
			end
		end
	end
end

--[[
	Cleanup code at the end of a scan.
--]]
local function _StopScan(self, complete)
	log:Debug("StopScan complete [%s]", complete)
	local itemLinkKey
	local scanId
	if (self.scanTask) then
		itemLinkKey = self.scanTask.itemLinkKey
		scanId = self.scanTask:GetScanId()
	end
	self.scanTask = nil
	_NotifySnapshotAborted(self)
	if (self.scanDialog:IsVisible()) then
		self.scanDialog:Hide()
		if (not self.scanDialog.avoidBell) then
			PlaySound(SOUNDKIT.AUCTION_WINDOW_CLOSE)
		end
	end
--	self.scanFrame:SetProgress("", 0)
	self:SendMessage("AUCTION_MASTER_STOP_SCAN", complete, itemLinkKey, scanId)
end

--[[
	Scans for the next item.
--]]
local function _BuyScanProgress(self)
	if (#self.scanList == 0) then
		log:Debug("_BuyScanProgress finished")
		if (self.buyScanFunc) then
			self.buyScanFunc(self.buyScanArg)
			self.buyScanFunc = nil
			self.buyScanArg = nil
		end
	else
		local itemLink = self.scanList[#self.scanList]
		table.remove(self.scanList, #self.scanList)
		log:Debug("_BuyScanProgress scan for itemLink [%s]", itemLink)
		local buyModule = vendor.BuyScanModule:new(self.auctionsToBuy)
		self:Scan(itemLink, true, _BuyScanProgress, self, {buyModule})
	end
end

--[[
	Initializes the module.
--]]
function vendor.Scanner:OnInitialize()
	log:Debug("OnInitialize")
	self.db = vendor.Vendor.db:RegisterNamespace("Scanner2", {
		factionrealm = {
			snapshot = {},
			searchInfos = {},
		},
		realm = {
			snapshot = {}		
		},
		profile = {
			minQuality = 1,
    		scannerItemTableCfg = {
    			size = 100,
    			rowHeight = 20,
				selected = {
					[1] = vendor.ScannerItemModel.TEXTURE,
					[2] = vendor.ScannerItemModel.NAME,
					[3] = vendor.ScannerItemModel.REASON,
					[4] = vendor.ScannerItemModel.BID,
					[5] = vendor.ScannerItemModel.BUYOUT,
				},
    		},
    		snipers = {
    			bookmarkSniper = true,
    			sellPriceSniper = true,
    		},
    		snipeAverage = 3.0,
    		snipeAverageMinCount = 100,
    		getAll = true,
    		scanSpeed = vendor.Scanner.SCAN_SPEED_HURRY
		}
	});
	_MigrateDb(self)
	self.lru = vendor.LruCache:new(25);
	self.nextScanId = 0
	self.scanSet = {}
	self.scanList = {}
end

--[[
	Initializes the scanner at startup and registers for the needed events.
--]]
function vendor.Scanner:OnEnable()
	self.scanDialog = vendor.ScanDialog:new()
	self.buyDialog = vendor.BuyDialog:new()
	self:RegisterEvent("AUCTION_HOUSE_CLOSED")
	self:RegisterEvent("CHAT_MSG_SYSTEM")
	self:RegisterEvent("AUCTION_ITEM_LIST_UPDATE")
	self:RawHook("AuctionFrameBrowse_OnEvent", true)
	self:Hook("CanSendAuctionQuery", true)
	self:RawHook("ContainerFrameItemButton_OnModifiedClick", true)
--	self.scanFrame = vendor.ScanFrame:new()
	self.modules = {}
	self.gatherModule = vendor.GatherScanModule:new()
	self.sniperModule = vendor.SniperScanModule:new()
	table.insert(self.modules, self.gatherModule)
	table.insert(self.modules, self.sniperModule)
end

--[[
	Performs a scan for the given item. nil will trigger a complete scan.
	@param func the optional function will be called with the optional arg parameter, 
	and the result. See ScanTask:GetResult()
	@return Returns an id for the scan, which will be passed to the callback function 
--]]
function vendor.Scanner:Scan(itemLink, silent, func, arg, modules, waitForOwners, scanSetCallback, scanSetCallbackArg)
	log:Debug("Scan itemLink [%s] waitForOwners [%s] func [%s]", itemLink, waitForOwners, func)
	if (self.scanTask) then
		vendor.Vendor:Error(L["There is already a running scan."])
	else
		self.nextScanId = self.nextScanId + 1
		local name
		local itemLinkKey
		local exactMatch = 0
		if (itemLink) then
			name = vendor.Items:GetItemData(itemLink)
			itemLinkKey = vendor.Items:GetItemLinkKey(itemLink)
			exactMatch = true
		end
		local queryInfo = {itemLinkKey = itemLinkKey, name = name, minLevel = "", maxLevel = "", 
			invTypeIndex = 0, classIndex = 0, subclassIndex = 0, isUsable = nil, unique = 0, qualityIndex = nil,
			scanSetCallback = scanSetCallback, scanSetCallbackArg = scanSetCallbackArg, exactMatch = exactMatch}
		if (not itemLink) then
			log:Debug("sniper: [%s]", self.sniperModule)
			self.scanTask = vendor.ScanTask:new(self.nextScanId, queryInfo, self.sniperModule, self.gatherModule)
			--self.scanFrame:Show()
			--vendor.AuctionHouse:SelectTab(self.scanFrame:GetTabId())
		elseif (modules) then
			self.scanTask = vendor.ScanTask:new(self.nextScanId, queryInfo, unpack(modules))
		else
			self.scanTask = vendor.ScanTask:new(self.nextScanId, queryInfo, self.gatherModule)
		end
		self.scanTask.silent = silent
		self.scanTask.waitForOwners = waitForOwners
		vendor.TaskQueue:AddTask(self.scanTask, func, arg)
		return self.nextScanId
	end	
end

function vendor.Scanner:FullScan(modules, func, arg, observer)
	if (self.scanTask) then
		vendor.Vendor:Error(L["There is already a running scan."])
	else
		self.nextScanId = self.nextScanId + 1
    	if (modules) then
    		self.scanTask = vendor.ScanTask:new(self.nextScanId, {getAll = true, observer = observer}, self.gatherModule, unpack(modules))
    	else
    		self.scanTask = vendor.ScanTask:new(self.nextScanId, {getAll = true, observer = observer}, self.sniperModule, self.gatherModule)
    	end
		vendor.TaskQueue:AddTask(self.scanTask, func, arg)
		return self.nextScanId
    end
end

function vendor.Scanner:ModulesScan(itemLink, silent, func, arg)
	return self:Scan(itemLink, silent, func, arg, self.modules)
end

function vendor.Scanner:SearchScan(info, silent, modules, func, arg)
	if (self.scanTask) then
		vendor.Vendor:Error(L["There is already a running scan."])
	else
		self.nextScanId = self.nextScanId + 1
		
		local itemLinkKey = info.itemLinkKey
		local exactName
		local name = info.name
		if (name) then
			if (strbyte(name, 1) == 0x3d) then
				-- name starts with "="
				name = strsub(name, 2)
				if (not itemLinkKey) then
					local itemName, itemLink = GetItemInfo(name)
					if (itemLink) then
						itemLinkKey = vendor.Items:GetItemLinkKey(itemLink)
					else
						-- will only succeed, if the item is equipped, in bag or in bank
						exactName = true
					end
				end
			end
		end
		
		local queryInfo = {name = name, minLevel = info.minLevel or "", maxLevel = info.maxLevel or "", 
			invTypeIndex = 0, classIndex = info.classIndex or 0, subclassIndex = info.subclassIndex or 0, 
			isUsable = info.usable or 0, unique = info.unique or 0, qualityIndex = info.rarity or 0, observer = info.observer,
			itemLinkKey = itemLinkKey, exactName = exactName, exactMatch = info.exactMatch}
		log:Debug("sniper: [%s]", self.sniperModule)
		if (modules) then
			self.scanTask = vendor.ScanTask:new(self.nextScanId, queryInfo, self.gatherModule, unpack(modules))
		else
			self.scanTask = vendor.ScanTask:new(self.nextScanId, queryInfo, self.sniperModule, self.gatherModule)
		end
		self.scanTask.silent = silent
		vendor.TaskQueue:AddTask(self.scanTask, func, arg)
		return self.nextScanId
	end	
end

--[[
	Starts a scan for buying the given auctions.
--]]
function vendor.Scanner:BuyScan(auctions, func, arg)
	log:Debug("BuyScan auctions [%s]", #auctions)
	if (#auctions == 0) then
		vendor.Vendor:Print(L["There are no auctions to be scanned."])
		return
	end
	self.auctionsToBuy = auctions
	local scanSet = wipe(self.scanSet) 
	local scanList = wipe(self.scanList)
	-- get list of unique names
	for i=1,#auctions do
		local info = auctions[i]
		self.scanSet[info.name] = info.itemLink
	end
	-- convert set to a sorted list
	for k,v in pairs(scanSet) do
		log:Debug("append to ScanList [%s]", v)
		table.insert(scanList, v)
	end
	self.buyScanFunc = func
	self.buyScanArg = arg
	_BuyScanProgress(self)
end

--[[
	Hides the auction house browse buttons, used during scans.
--]]
function vendor.Scanner:HideAuctionHouseBrowseButtons()
   	for i=1, NUM_BROWSE_TO_DISPLAY do
      	local button = getglobal("BrowseButton"..i);
      	button:Hide();
   	end
   	BrowsePrevPageButton:Disable();
   	BrowseNextPageButton:Disable();
   	BrowseSearchCountText:Hide();
end

--[[
	Events triggered if the auction item list was updated. Will
	inform any current ScanTask about it.
--]]
function vendor.Scanner:AUCTION_ITEM_LIST_UPDATE()
	log:Debug("AUCTION_ITEM_LIST_UPDATE")
	if (self.scanTask) then
		self.scanTask:AuctionListUpdate()
		self:HideAuctionHouseBrowseButtons()
	end
end

--[[
	Events for auction house closes. Will cancel any running scan task.
--]]
function vendor.Scanner:AUCTION_HOUSE_CLOSED()
	log:Debug("Scanner:AUCTION_HOUSE_CLOSED")
	if (self.scanTask) then
		log:Debug("cancel scan task")
		self.scanTask:Cancel()
		self.scanTask = nil
		self:AbandonScan()
	end
--	self.scanFrame:Hide()
	self.scanDialog:Hide();
end

--[[
	Handles chat events to recognize auction actions.
--]]
function vendor.Scanner:CHAT_MSG_SYSTEM(event, message)
	vendor.Vendor:Debug("received cmessage: %s", message)
	if (message == ERR_AUCTION_WON_S) then
		if (self.pendingBuy) then
			local i = self.pendingBuy
			vendor.Gatherer:AuctionBought(i.itemLinkKey, i.minBid, i.buyout, i.count)
			self.pendingBuy = nil
		end
	end
end

--[[
	Hook to prevent blizzard seeing the auctions while we are scanning.
--]]
function vendor.Scanner:AuctionFrameBrowse_OnEvent(...)
	self.hooks["AuctionFrameBrowse_OnEvent"](...)
	if (self.scanTask) then
		self:HideAuctionHouseBrowseButtons()
	end
end

--[[
	Hook to prevent blizzard to flicker the "Search" button.
--]]
function vendor.Scanner:CanSendAuctionQuery()
	if (not self.scanTask) then
		return self.hooks.CanSendAuctionQuery()
   	end
	return nil
end

--[[
	Returns the result of "CandSendQuery" bypassing the own hook.
--]]
function vendor.Scanner:MaySendAuctionQuery()
	return self.hooks.CanSendAuctionQuery()
end

--[[
	Stops the current scan, if any.
--]]
function vendor.Scanner:StopScan()
	log:Debug("StopScan")
	if (self.scanTask) then
		self.scanTask:Cancel()
	end	
end

--[[
	Returns true, if the scanner is currently performing a scan. The second argument determines whether
	it's a getAll scan
--]]
function vendor.Scanner:IsScanning()
	if (self.scanTask) then
		return true, self.scanTask.getAll
	end
	return nil
end

--[[
	Lets the scan task inform the scanner, that it has abandoned the scan.
--]]
function vendor.Scanner:AbandonScan(complete)
	log:Debug("AbandonScan complete: %s", complete)
	_StopScan(self, complete)
end

--[[
	Bids/buyouts the given auctions on the current page of the given type. 
	The structs in the list have to conatin the fields:
	index, name, count, minBid, buyout, bid (the actual bid that will be placed)
	@param possibleGap optional parameter to select the possible gap between given and 
	real index. The gap may be caused by bought auctions.
--]]
function vendor.Scanner:PlaceAuctionBid(ahType, auctions, possibleGap)
	log:Debug("PlaceBid on [%s] auctions in type [%s] possibleGap [%s]", #auctions, ahType, possibleGap)
	local gap = possibleGap or 0
	table.sort(auctions, function(a, b) return (a.index or 0) > (b.index or 0) end)
	for i=#auctions,1,-1 do
		local info = auctions[i]
		if (info.index and info.index > 0) then
			local firstIdx = math.max(1, info.index - gap)
			local bid, bought, name, _, count, minBid, minIncrement, buyout, bidAmount, unknown
			for idx=info.index,firstIdx,-1 do
				name, _, count, _, _, _, unknown, minBid, minIncrement, buyout, bidAmount = GetAuctionItemInfo(ahType, idx)
				bid = minBid
				if (bidAmount and bidAmount > 0) then
					bid = bidAmount + (minIncrement or 0)
				end
				if (info.name == name and info.count == count and info.minBid == minBid and 
						info.buyout == buyout and info.bid >= bid) then
					vendor.Vendor:Print(L["Placing bid with %s on %s x \"%s\""]:format(vendor.Format.FormatMoney(info.bid, true), count, name))
					vendor.AuctionHouse:AddAction(vendor.AuctionHouse.ACTION_BID, GetAuctionItemLink(ahType, idx))
					PlaceAuctionBid(ahType, idx, info.bid)
					bought = true
					break
				end
			end
			if (not bought) then
				log:Debug("PlaceAuctionBid index [%s] searching name [%s] count [%s] minBid [%s] buyout [%s] found name [%s] count [%s] minBid [%s] buyout [%s] minIncrement [%s] bid [%s]",
					info.index, info.name, info.count, info.minBid, info.buyout, name, count, minBid, buyout, minIncrement, bid)
				vendor.Vendor:Error(L["Couldn't find auction \"%s\""]:format(info.name))
			end
		else
			log:Debug("missing index")
		end
	end
end

--function vendor.Scanner:SnipeItem(name)
--	self.scanFrame:SnipeItem(name)
--end

function vendor.Scanner:ContainerFrameItemButton_OnModifiedClick(frame, button, ...)
	log:Debug("ContainerFrameItemButton_OnModifiedClick enter")
	-- some addons forget to pass the button parameter :-(
	local but = button or "LeftButton"
	if (((but == "RightButton") or (but == "LeftButton" and IsShiftKeyDown())) and 
		vendor.AuctionHouse:IsAuctionHouseTabShown(vendor.SearchTab:GetTabType())) then
		local itemLink = GetContainerItemLink(frame:GetParent():GetID(), frame:GetID())
		if (itemLink) then
			log:Debug("found itemLink")
			vendor.SearchTab:PickItem(itemLink, true)
		end
	else
		self.hooks["ContainerFrameItemButton_OnModifiedClick"](frame, button, ...)
	end
	log:Debug("ContainerFrameItemButton_OnModifiedClick exit")
end

