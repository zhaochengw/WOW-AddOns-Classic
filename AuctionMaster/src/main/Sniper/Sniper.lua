--[[
	Listens to auction house scans and snipes for good oppurtunities.
	
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

vendor.Sniper = vendor.Vendor:NewModule("Sniper", "AceHook-3.0", "AceEvent-3.0")

local log = vendor.Debug:new("Sniper")

local L = vendor.Locale.GetInstance()
local self = vendor.Sniper;
local SNIPER_VERSION = 3

StaticPopupDialogs["SNIPER_DB_RESET"] = {
	text = L["Do you really want to reset the database?"];
	button1 = L["Yes"],
	button2 = L["No"],
	OnAccept = function()
		self.db.factionrealm.wanted = {}
		vendor.Vendor:Print(L["Database of snipes for current realm where reset."])
	 end,
	 timeout = 0,
	 whileDead = 1,
	 hideOnEscape = 1,
	 preferredIndex = 3,  -- avoid some UI taint, see http://www.wowace.com/announcements/how-to-avoid-some-ui-taint/
}
	
--[[
	Migrates the database.
--]]
local function _MigrateDb(self)
	local oldDb = vendor.Vendor.oldDb:AcquireDBNamespace("Sniper")
	if (not self.db.factionrealm.version or self.db.factionrealm.version < 3) then
		-- migrate old "realm" to "factionrealm"
		self.db.factionrealm.wanted = oldDb.realm.wanted or {}
		oldDb.realm.wanted = nil
	end	
	self.db.factionrealm.version = SNIPER_VERSION
	self.db.profile.version = SNIPER_VERSION
end

--[[
	Sets the given value in the profile.
--]]
local function _SetValue(info, value)
	self.db.profile[info.arg] = value;
end

--[[
	Returns the given value from the profile.
--]]
local function _GetValue(info)
	return self.db.profile[info.arg]
end

local function _StopWait(self)
	vendor.AuctionHouse:UnregisterChatWait(self.waitId)
end

--[[
	Returns true, if the given prices matches the snipe prices.
--]]
local function _MatchesPrices(minBid, minIncrement, bidAmount, buyoutPrice, snipeBid, snipeBuyout)
	if (snipeBid and snipeBid > 0) then
		if (bidAmount and bidAmount > 0 and snipeBid >= (bidAmount + minIncrement)) then
			return true
		end
		return snipeBid >= (minBid + minIncrement)
	end
	if (snipeBuyout and snipeBuyout > 0 and buyoutPrice and buyoutPrice > 0) then
		return snipeBuyout >= buyoutPrice
	end
	return false
end

--[[
	Searches the given auction item to be bought. Seems to have moved a bit.
	Returns the corresponding index or nil. 
--]]
local function _SearchItem(auctionType, index, bid, buyout, name, count)
	local itemName, itemCount, minBid, minIncrement, buyoutPrice, bidAmount, _, unknown
	for i=index,1,-1 do
		itemName, _, itemCount, _, _, _, unknown, minBid, minIncrement, buyoutPrice, 
			bidAmount = GetAuctionItemInfo(auctionType, i)
		if (itemName and itemName == name and itemCount == count and
				_MatchesPrices(minBid, minIncrement, bidAmount, buyoutPrice, bid, buyout)) then
				return i
		end
	end
	for i=index+1,50 do
		itemName, _, itemCount, _, _, _, unknown, minBid, minIncrement, buyoutPrice, 
			bidAmount = GetAuctionItemInfo(auctionType, i)
		if (itemName and itemName == name and itemCount == count and
				_MatchesPrices(minBid, minIncrement, bidAmount, buyoutPrice, bid, buyout)) then
				return i
		end
	end
end

--[[
	Returns true, if the item may be bought depending from earlier decisions
	resp. the amount of money the player currently has.
--]]
local function _MayBuy(name, count, bid, buyout)
	local rtn = true;
	local money = GetMoney();
	if (bid and bid > 0 and bid > money) then
		rtn = false;
	elseif (buyout and buyout > 0 and buyout > money) then
		rtn = false;
	else
		if (count > 1) then
			if (bid) then
				bid = bid / count;
			end
			if (buyout) then
				buyout = buyout / count;
			end
		end
		local old = self.maxValues[name];
		if (old) then
			if (old.bid and old.bid > 0) then
				if (bid and bid > 0 and bid >= old.bid) then
					if (not buyout or buyout == 0 or buyout >= old.buyout) then
						rtn = false;
					end
				end
			end
		end
	end
	return rtn;
end

--[[
	Initializes the addon.
--]]
function vendor.Sniper:OnInitialize()
	self.db = vendor.Vendor.db:RegisterNamespace("Sniper", {
		factionrealm = {
			wanted = {},
		},
		profile = {
			bookmarkSniper = {},
			sellPriceSniper = {bid = true, buyout = true, minProfit = 10000},
			disenchantSniper = {bid = true, buyout = true, minProfit = 40000},
		}
	});
	self.itemInfo = {} -- reusing the table
	_MigrateDb(self)
	self.snipers = {}
	self:AddSniper(vendor.BookmarkSniper:new())
	self:AddSniper(vendor.SellPriceSniper:new())
	self:AddSniper(vendor.DisenchantSniper:new())
	--self:AddSniper(vendor.MarketPriceSniper:new())
end

--[[
	Initializes the addon.
--]]
function vendor.Sniper:OnEnable()
	self.maxValues = {}
	self.playerName = UnitName("player")
	self.snipeCreateDialog = vendor.SnipeCreateDialog:new()
	vendor.TooltipHook:AddAppender(self, 11)
	self:RegisterMessage("AUCTION_MASTER_STOP_SCAN")
end

--[[
	Informs the listener about the scan of the given item.
	Interface method of ScanItemListener.
 	@param index the current auction house index
	@param itemLink the link of the scanned item.
	@return askForBuy (bool), reason (string)
--]]
function vendor.Sniper:ItemScanned(index, itemLink, itemName)
	if (not self.paused) then
		local auctionName, _, count, _, _, _, unknown, minBid, minIncrement, buyout, bidAmount, highBidder, bidderFullName, owner, ownerFullName  = GetAuctionItemInfo("list", index);
		if (auctionName == itemName and self.playerName ~= owner) then
			local bid = minBid;
			if (bidAmount > 0) then
				bid = bidAmount + minIncrement;
			end
			local rtn = false
			local reason
			local reasonSort
			local doBid
			local doBuyout
			local sniperId
			if (_MayBuy(itemName, count, bid, buyout)) then
				if (self.exclusiveSniper) then
					doBid, doBuyout = self.exclusiveSniper(itemLink, itemName, count, minBid, bidAmount, minIncrement, buyout, highBidder, self.exclusiveSniperArg1)
					if (doBid or doBuyout) then
						log:Debug("doBid: %s doBuyout: %s", doBid, doBuyout)
						rtn = true
						if (doBid) then
							reason = L["Do you really want to bid on this item?"]
						else
							reason = L["Do you really want to buy this item?"]
						end
					end
				else
					for i=1,#self.snipers do
						local sniper = self.snipers[i]
						rtn, reason, reasonSort = sniper:Snipe(itemLink, itemName, count, bid, buyout, highBidder)
						if (rtn) then
							sniperId = sniper:GetId()
							break
						end
					end
    			end
			end
			return rtn, reason, sniperId, doBid, doBuyout, reasonSort
		end
	end
	return nil
end

--[[
	Updates the snipe information for the given item. If both prizes are zero, any
	existing snipe information will be removed for this item.
	@param name the name of the item to be sniped.
	@param maxBid the maximal bid to be accepted. Zero won't accept any bid.
	@param maxBuyout the maximal buyout to be accepted. Zero won't accept any buyout.
--]]
function vendor.Sniper:SetSnipeInfo(name, maxBid, maxBuyout)
	log:Debug("SetSnipeInfo name: "..name.." maxBid: "..maxBid.." maxBuyout: "..maxBuyout);
	if (maxBid == 0 and maxBuyout == 0) then
		self.db.factionrealm.wanted[name] = nil;
	else
		self.db.factionrealm.wanted[name] = strjoin(":", maxBid, maxBuyout);
	end
end

--[[
	Returns maxBid and maxBuyout for the given item. 0 will be returned,
	if nothing is wanted for this item.
--]]
function vendor.Sniper:GetWanted(name)
	local data = self.db.factionrealm.wanted[name];
	if (data) then
		local maxBidStr, maxBuyoutStr = strsplit(":", data);
		return tonumber(maxBidStr), tonumber(maxBuyoutStr);
	end
	return 0, 0;
end

--[[
	Places a snipe for the given item.
	Will only run inside of coroutines.
	@param auctionType should be "list".
	@param index the index in the auction list.
	@param bid will place a bid, if greater zero.
	@param buyout will buy the item, if greater zero.
	@param name for the final check, whether this is the correct item.
--]]
function vendor.Sniper:SnipeForItem(auctionType, index, bid, buyout, name, count)
	log:Debug("SnipeForItem bid: %d buyout: %d count: %d", bid or 777, buyout or 777, count);
	local idx = _SearchItem(auctionType, index, bid, buyout, name, count)
	if (not idx) then
		log:Debug("item not found index: %d name [%s] auctionType [%s]", index, name, auctionType)
		vendor.Vendor:Print(L["Item not found"]);
		_StopWait(self)
	elseif (bid and bid > 0) then
		log:Debug("do bid");
		AuctionFrame.buyoutPrice = nil;
		vendor.AuctionHouse:AddAction(vendor.AuctionHouse.ACTION_BID, GetAuctionItemLink(auctionType, idx))
		PlaceAuctionBid(auctionType, idx, bid);
	elseif (buyout and buyout > 0) then
		log:Debug("do buy index: "..idx.." buyout: "..buyout);
		AuctionFrame.buyoutPrice = buyout;
		vendor.AuctionHouse:AddAction(vendor.AuctionHouse.ACTION_BID, GetAuctionItemLink(auctionType, idx))
		PlaceAuctionBid(auctionType, idx, AuctionFrame.buyoutPrice);
	end
end

--[[
	Waits for a pending item to be bought from auction house.
--]]
function vendor.Sniper:WaitForPendingBuy()
	vendor.AuctionHouse:ChatWait(self.waitId)
end

--[[
	Signals the sniper, that we soon will try to buy an item.
--]]
function vendor.Sniper:StartPendingBuy(itemName, count, bid, buyout)
	log:Debug("Sniper:StartPendingBuy bid: %d buyout: %d", bid or 777, buyout or 777)
	if (count > 1) then
		if (bid) then
			bid = bid / count;
		end
		if (buyout) then
			buyout = buyout / count;
		end
	end
	self.pendingBuy = {name = itemName, bid = bid, buyout = buyout};
	self.waitId = vendor.AuctionHouse:RegisterChatWait()
end

--[[
	Signals the sniper, that we won't buy an item.
--]]
function vendor.Sniper:StopPendingBuy()
	_StopWait(self)
	if (self.pendingBuy) then
		-- remember the name and values, so we don't ask again the same items in the current scan
		local old = self.maxValues[self.pendingBuy.name];
		local bid = self.pendingBuy.bid;
		local buyout = self.pendingBuy.buyout;
		if (old) then
			if (bid and (not old.bid or bid < old.bid)) then
				old.bid = bid;
			end
			if (buyout and (not old.buyout or buyout < old.buyout)) then
				old.buyout = buyout;
			end
		else
			self.maxValues[self.pendingBuy.name] = {bid = bid, buyout = buyout};
		end
		self.pendingBuy = nil;
	end
end

--[[
	Opens the snipe dialog. The name is optional.
--]]
function vendor.Sniper:OpenSnipeDialog(name)
	self.snipeCreateDialog:Show(name);
end

--[[
	Callback for Tooltip integration
--]]
function vendor.Sniper:AppendToGameTooltip(tooltip, itemLink, itemName, count)
	if (vendor.TooltipHook.db.profile.showSnipes) then
		local maxBid, maxBuyout = self:GetWanted(itemName);
		if (maxBid > 0) then
			local msg1;
			local msg2;
			if (count > 1) then
				msg1 = L["Snipe bid (%d)"]:format(count);
				msg2 = vendor.Format.FormatMoney(maxBid, true).."("..vendor.Format.FormatMoney(maxBid * count, true)..")";
			else
				msg1 = L["Snipe bid"];
				msg2 = vendor.Format.FormatMoney(maxBid, true);			
			end
			tooltip:AddDoubleLine(msg1, msg2);
		end
		if (maxBuyout > 0) then
			local msg1;
			local msg2;
			if (count > 1) then
				msg1 = L["Snipe buyout (%d)"]:format(count);
				msg2 = vendor.Format.FormatMoney(maxBuyout, true).."("..vendor.Format.FormatMoney(maxBuyout * count, true)..")";
			else
				msg1 = L["Snipe buyout"];
				msg2 = vendor.Format.FormatMoney(maxBuyout, true);			
			end
			tooltip:AddDoubleLine(msg1, msg2);
		end
	end
end

--[[
	Pauses any snipes for the current scan.
--]]
function vendor.Sniper:PauseThisScan()
	self.paused = true;
end

--[[
	Scan has finished.
--]]
function vendor.Sniper:AUCTION_MASTER_STOP_SCAN()
	self.paused = nil;
	self.maxValues = {};
end

--[[
	ScanResultListener interface method for aborted scans.
--]]
function vendor.Sniper:ScanAborted()
	self.paused = nil;
	self.maxValues = {};
end

--[[
	Registers an exclusive sniper that will be asked to buy all items found. If func is nil,
	any previous sniper will be deregistered.
	The func gets the arguments "itemLink, itemName, count, bid, bidAmount, minIncrement, buyout, highBidder, arg1", it should
	return two booleans "doBid" and "doBuyout".
--]]
function vendor.Sniper:RegisterExclusiveSniper(func, arg1)
	self.exclusiveSniper = func
	self.exclusiveSniperArg1 = arg1
end

--[[
	Adds the given sniper to be used during scans.
--]]
function vendor.Sniper:AddSniper(sniper)
	table.insert(self.snipers, sniper)
	table.sort(self.snipers, function(a, b)
			local o1, o2 = 1000000, 1000000
			if (a.GetOrder) then
				o1 = a:GetOrder()
			end
			if (b.GetOrder) then
				o2 = b:GetOrder()
			end
			return o1 < o2
		end
	)
end

--[[
	Returns the list of snipers.
--]]
function vendor.Sniper:GetSnipers()
	return self.snipers
end

function vendor.Sniper:GetSnipes()
	return self.db.factionrealm.wanted
end

function vendor.Sniper:CreateReasonSort(price, buyout, id)
	log:Debug("CreateResonSort")
	local buyoutStr = "z"
	if (not buyout) then
		buyoutStr = "a"
	end
	local rtn = buyoutStr..string.format("%014d", price)..id
	log:Debug("rtn %s", rtn)
	return rtn
end