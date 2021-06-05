--[[
	Adds a new tab to the auction house for more convinient selling of items.
	Enables the selling of many items at once, prefills the desired prizes and
	remembers them.
	
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

vendor.Seller = vendor.Vendor:NewModule("Seller", "AceEvent-3.0", "AceHook-3.0")
vendor.Seller:SetEnabledState(true)

local L = vendor.Locale.GetInstance()
local self = vendor.Seller;
local log = vendor.Debug:new("Seller")

vendor.Seller.PRIZE_MODEL_FIX = 1
vendor.Seller.PRIZE_MODEL_MARKET = 2
vendor.Seller.PRIZE_MODEL_CURRENT = 3
vendor.Seller.PRIZE_MODEL_UNDERCUT = 4
vendor.Seller.PRIZE_MODEL_MULTIPLIER = 5
vendor.Seller.PRIZE_MODEL_LOWER = 6

local SELLER_TAB = "seller"
local INVENTORY_LINE_HEIGHT = 27
local INVENTORY_LINES = 11
local DURATIONS = { 1, 2, 3 }
local MARKET_PERCENT = 2
local SELLER_VERSION = 5
vendor.Seller.BID_TYPES = { L["Per item"], L["Stack"], L["Overall"] }
local UPDATE_INTERVAL = 1

--[[
	Migrates the database.
--]]
local function _MigrateDb(self)
    if (not self.db.profile.version or self.db.profile.version < 5) then
        self.db.profile.buyoutMod = {}
        self.db.profile.buyoutMod[self.PRIZE_MODEL_MARKET] = { percent = self.db.profile.marketBuyoutMul or 150, modType = 1 }
        self.db.profile.buyoutMod[self.PRIZE_MODEL_CURRENT] = { percent = self.db.profile.currentBuyoutMul or 100, modType = 1 }
        self.db.profile.buyoutMod[self.PRIZE_MODEL_UNDERCUT] = { percent = self.db.profile.undercutBuyoutMul or 99, modType = 1 }
        self.db.profile.buyoutMod[self.PRIZE_MODEL_LOWER] = { percent = self.db.profile.lowerBuyoutMul or 99, modType = 1 }
        self.db.profile.buyoutMod[self.PRIZE_MODEL_MULTIPLIER] = { percent = self.db.profile.multiplierBuyoutMul or 250, modType = 1 }
        self.db.profile.defaultDuration = 3
        self.db.profile.marketBuyoutMul = nil
        self.db.profile.currentBuyoutMul = nil
        self.db.profile.undercutBuyoutMul = nil
        self.db.profile.lowerBuyoutMul = nil
        self.db.profile.multiplierBuyoutMul = nil
    end
    self.db.profile.version = SELLER_VERSION
end

--[[
	Updates some fonts.
--]]
local function _UpdateFonts(self)
    if (self.buyoutFont) then
        self.buyoutFont:SetText(L["Buyout Price"] .. " |cff808080(" .. vendor.Seller.BID_TYPES[self.db.profile.bidType] .. ")|r")
    end
    if (self.minBidFont) then
        self.minBidFont:SetText(L["Starting Price"] .. " |cff808080(" .. vendor.Seller.BID_TYPES[self.db.profile.bidType] .. ")|r")
    end
end

local function _FindItemInBag(itemLink)
    local itemKey = vendor.Items:GetItemLinkKey(itemLink)
    for bag = 0, 4 do
        for slot = 1, GetContainerNumSlots(bag) do
            local slotLink = GetContainerItemLink(bag, slot);
            if (slotLink) then
                local slotKey = vendor.Items:GetItemLinkKey(slotLink);
                if (itemKey == slotKey) then
                    return bag, slot
                end
            end
        end
    end
    return nil
end

local function _Sell(itemLink, minBid, buyout, runTime, stackSize, stackCount)
    log:Debug("_Sell minBid [%s] buyout [%s] runTime [%s] stackSize [%s] stackCount [%s]", minBid, buyout, runTime, stackSize, stackCount)
    ClearCursor()
    vendor.clickAuctionSellItemButton()
    ClearCursor()

    local bag, slot = _FindItemInBag(itemLink, reverse)
    if (bag and slot) then
        PickupContainerItem(bag, slot)
        vendor.clickAuctionSellItemButton()
        local name, texture, count, quality, canUse, price = GetAuctionSellItemInfo()
        local itemName = vendor.Items:GetItemData(itemLink)
        log:Debug("_Sell itemName [%s] name [%s] count [%s]", itemName, name, count)
        if (not itemName or not name or itemName ~= name) then
            vendor.Vendor:Error(L["Failed to create stack of %d items."]:format(stackSize))
        else
            vendor.AuctionHouse:AddAction(vendor.AuctionHouse.ACTION_SELL, itemLink)
            self.sellItemInfo = { minBid = minBid * stackSize, buyout = buyout * stackSize, runTime = runTime, stackSize = stackSize, stackCount = stackCount, itemLink = itemLink, timeLeft = runTime }
            PostAuction(minBid * stackSize, buyout * stackSize, runTime, stackSize, stackCount)
            vendor.clickAuctionSellItemButton()
        end
        ClearCursor()
    end
end

--[[
	Checks whether the current auction is valid and shows an error messages
	or enables the sell button accordingly.
--]]
local function _ValidateAuction(self)
    log:Debug("_ValidateAuction enter")
    self.createBut:Show()
    self.createBut:Disable()
    self.buyoutErrorText:Hide()
    if (self.item) then
        local startPrize = MoneyInputFrame_GetCopper(self.startPriceBut)
        local buyoutPrize = MoneyInputFrame_GetCopper(self.buyoutPriceBut)
        log:Debug("_ValidateAuction startPrize [%s] buyoutPrize [%s]", startPrize, buyoutPrize)
        -- Buyout price is less than the start price
        if (buyoutPrize > 0 and startPrize > buyoutPrize) then
            log:Debug("_ValidateAuction disable")
            self.createBut:Hide()
            self.buyoutErrorText:Show()
        else
            -- Start price is 0 or greater than the max allowed
            if (not (startPrize < 1 or startPrize > MAXIMUM_BID_PRICE)) then
                log:Debug("_ValidateAuction enable")
                self.createBut:Enable()
            else
                log:Debug("_ValidateAuction startPrize illegal")
            end
        end
    end
    log:Debug("_ValidateAuction exit")
end

--[[
	New ScanSet has arrived.
--]]
local function _ScanSetUpdate(scanSet, self)
    if (scanSet) then
        log:Debug("_ScanSetUpdate")
        if (scanSet:Size() == 0) then
            self.itemTable:SetFadingText(L["No matching auctions found."])
        end
        local key
        if (self.item) then
            key = self.item.itemLinkKey
        elseif (self.lastItem) then
            key = self.lastItem.itemLinkKey
        end
        log:Debug("_ScanSetUpdate our key: %s scanSetKey: %s", key or "na", scanSet:GetItemLinkKey())
        if (key and key == scanSet:GetItemLinkKey()) then
            log:Debug("set new scanset of size [%s]", scanSet:Size())
            self.itemModel:SetScanSet(scanSet)
            self.itemTable:Show()
        end
        local prizeModel = self.prizingDropDown:GetValue()
        if (prizeModel ~= self.PRIZE_MODEL_FIX) then
            --self.auto:Update()
            self:RefreshPrices()
        end
    end
    log:Debug("_ScanSetUpdate exit");
    _ValidateAuction(self);
end

--[[
	The refresh button has been clicked. A scan will be triggered.
--]]
local function _RefreshClicked(self)
    log:Debug("_RefreshClicked enter")
    local waitForOwners
    for _, id in pairs(self.db.profile.itemTableCfg.selected) do
        if (id == vendor.ScanSetItemModel.OWNER) then
            waitForOwners = true
            break
        end
    end
    if (self.item) then
        log:Debug("_RefreshClicked key1: %s link [%s]", self.item.itemLinkKey, vendor.Items:PrintItemLink(self.item.link))
        --self.itemModel:SetScanSet(vendor.ScanSet:new({}, vendor.AuctionHouse:IsNeutral(), self.item.itemLinkKey))
        vendor.Scanner:Scan(self.item.link, false, nil, nil, nil, waitForOwners, _ScanSetUpdate, self)
    elseif (self.lastItem) then
        log:Debug("_RefreshClicked key2: %s", self.lastItem.itemLinkKey)
        self.itemModel:SetScanSet(vendor.ScanSet:new({}, vendor.AuctionHouse:IsNeutral(), self.lastItem.itemLinkKey))
        vendor.Scanner:Scan(self.lastItem.link, false, nil, nil, nil, waitForOwners, _ScanSetUpdate, self)
    end
    self.itemTable:Show()
    log:Debug("_RefreshClicked exit")
end

--[[
	Cancels the selected list of items.
--]]
local function _CancelAuctions(self)
    local cancelAuctions = wipe(self.cancelAuctions)
    local auctions = {}
    for _, row in pairs(self.itemModel:GetSelectedItems()) do
        local itemLinkKey, itemLink, _, count, minBid, _, buyout, bidAmount = self.itemModel:Get(row)
        log:Debug("_CancelAuctions itemLinkKey [%s]", itemLinkKey)
        local info = { itemLinkKey = itemLinkKey, itemLink = itemLink, count = count, minBid = minBid, buyout = buyout, bidAmount = bidAmount }
        tinsert(auctions, info)
        tinsert(cancelAuctions, info)
    end
    vendor.OwnAuctions:CancelAuctions(auctions)
end

--[[
	Bids on the selected list of items.
--]]
local function _Bid(self)
    local auctions = {}
    for _, row in pairs(self.itemModel:GetSelectedItems()) do
        local itemLinkKey, itemLink, _, count, minBid, minIncrement, buyout, bidAmount = self.itemModel:Get(row)
        local bid = minBid
        if (bidAmount and bidAmount > 0) then
            bid = bidAmount + (minIncrement or 0)
        end
        local itemLink = vendor.Items:GetItemLink(itemLinkKey)
        local name = GetItemInfo(itemLink)
        local info = { itemLink = itemLink, name = name, count = count, bidAmount = bidAmount, minBid = minBid, buyout = buyout, bid = bid, doBid = true, reason = L["Bid"] }
        table.insert(auctions, info)
    end
    vendor.Scanner:BuyScan(auctions, _RefreshClicked, self)
end

--[[
	Buys the selected list of items.
--]]
local function _Buyout(self)
    local auctions = {}
    local rows = {}
    for _, row in pairs(self.itemModel:GetSelectedItems()) do
        table.insert(rows, row)
        local itemLinkKey, _, _, count, minBid, _, buyout, bidAmount, owner = self.itemModel:Get(row)
        if (buyout and buyout > 0 and self.playerName ~= owner) then
            local itemLink = vendor.Items:GetItemLink(itemLinkKey)
            local name = vendor.Items:GetItemData(itemLink)
            local info = { itemLink = itemLink, name = name, count = count, bidAmount = bidAmount, minBid = minBid, buyout = buyout, bid = buyout, doBuyout = true, reason = L["Buy"] }
            table.insert(auctions, info)
        end
    end
    vendor.Scanner:BuyScan(auctions, _RefreshClicked, self)
end

local CMDS = {
    refresh = {
        title = L["Refresh"],
        tooltip = L["Scans the auction house for the item to be sold."],
        alignLeft = true,
        arg1 = vendor.Seller,
        func = function(arg1) _RefreshClicked(arg1) end,
        enabledFunc = function(self)
            return self.itemModel:GetScanSet()
        end,
        order = 9
    },
    bid = {
        title = L["Bid"],
        tooltip = L["Bids on all selected items."] .. " " .. L["Auctions may be selected with left clicks. Press the ctrl button, if you want to select multiple auctions. Press the shift button, if you want to select a range of auctions."],
        arg1 = vendor.Seller,
        func = function(arg1) _Bid(arg1) end,
        enabledFunc = function(self)
            local rtn = false
            for _, row in pairs(self.itemModel:GetSelectedItems()) do
                rtn = true
                local _, _, _, _, _, _, _, _, owner = self.itemModel:Get(row)
                if (self.playerName == owner) then
                    rtn = false
                    break
                end
            end
            return rtn
        end,
        order = 10
    },
    buy = {
        title = L["Buyout"],
        tooltip = L["Buys all selected items."] .. " " .. L["Auctions may be selected with left clicks. Press the ctrl button, if you want to select multiple auctions. Press the shift button, if you want to select a range of auctions."],
        arg1 = vendor.Seller,
        func = function(arg1) _Buyout(arg1) end,
        enabledFunc = function(self)
            -- enable buyout if one of the results has buyout
            local rtn = false
            for _, row in pairs(self.itemModel:GetSelectedItems()) do
                local _, _, _, _, _, _, buyoutPrice, _, owner = self.itemModel:Get(row)
                if (buyoutPrice and buyoutPrice > 0 and self.playerName ~= owner) then
                    rtn = true
                    break
                end
            end
            return rtn
        end,
        order = 11
    },
    cancel = {
        title = L["Cancel Auctions"],
        tooltip = L["Cancels all own auctions that has been selected."] .. " " .. L["Auctions may be selected with left clicks. Press the ctrl button, if you want to select multiple auctions. Press the shift button, if you want to select a range of auctions."],
        arg1 = vendor.Seller,
        width = 125,
        func = function(arg1) _CancelAuctions(self) end,
        enabledFunc = function(self)
            local rtn = false
            for _, row in pairs(self.itemModel:GetSelectedItems()) do
                rtn = true
                local _, _, _, _, _, _, _, _, owner = self.itemModel:Get(row)
                if (not owner or owner ~= self.playerName) then
                    rtn = false
                    break
                end
            end
            return rtn
        end,
        order = 12
    }
}

--[[
	Tries to retrieve a link for an item with the given name in the inventory.
--]]
local function _FindInventoryItemLink(name)
    for bag = 0, 4 do
        for slot = 1, GetContainerNumSlots(bag) do
            local itemLink = GetContainerItemLink(bag, slot);
            if (itemLink) then
                local itemName = GetItemInfo(itemLink);
                if (name and name == itemName) then
                    return itemLink; -- don't like this, but we need to get out of two loops
                end
            end
        end
    end
    return nil;
end

--[[
	Returns "minBid, buyOut" for the given item, if known.
--]]
local function _GetItemAuctionSellValues(itemLink)
    local itemLinkKey = vendor.Items:GetItemLinkKey(itemLink)
    if (vendor.Items:GetItemInfo(itemLinkKey, self.itemInfo, vendor.AuctionHouse:IsNeutral())) then
        return self.itemInfo.minBid, self.itemInfo.buyout
    end
    return nil;
end

--[[
	Returns "avgBid, avgBuyout" for the given item, if known.
--]]
local function _GetItemAuctionAvgValues(itemLink)
    return vendor.Gatherer:GetAuctionInfo(itemLink, vendor.AuctionHouse:IsNeutral())
end

local function _ModifyMinBid(minBid, buyout)
    if (not self.db.profile.bidCalc and buyout and buyout > 0) then
        minBid = math.floor(buyout * (self.db.profile.bidMul / 100.0) + 0.5)
        minBid = math.max(1, minBid)
    end
    if (self.startPrize and (not minBid or (self.startPrize > minBid))) then
        minBid = self.startPrize
    end
    return minBid
end

--[[
	Modifies the given minBid and buyout prices by the given modifier.
--]]
local function _ModifyPrices(minBid, buyout)
    --log:Debug("ModifyPrices minBid: %d buyout: %d", minBid or 0, buyout or 0)
    if (minBid and minBid > 0) then
        minBid = math.max(1, minBid)
        if (self.db.profile.bidCalc) then
            minBid = self.buyoutMul:ModifyBuyout(minBid, self.item.itemSettings)
        end
        if (buyout and buyout > 0) then
            buyout = self.buyoutMul:ModifyBuyout(buyout, self.item.itemSettings)
        end
    end
    minBid = _ModifyMinBid(minBid, buyout)
    if (minBid and buyout and buyout > 0 and minBid > buyout) then
        minBid = buyout
    end
    --log:Debug("ModifyPrices exit minBid: %d buyout: %d", minBid or 0, buyout or 0)
    return minBid, buyout;
end

--[[
	Returns item's current price calculation for current auctions.
--]]
local function _GetCurrentPrice(self, itemLink)
    local minBid, buyout = vendor.Statistic:GetCurrentAuctionInfo(itemLink, vendor.AuctionHouse:IsNeutral())
    return _ModifyPrices(minBid, buyout)
end

--[[
	Returns item's undercut calculation for current auctions.
--]]
local function _GetUndercutPrice(self, itemLink)

    local minBid, buyout
    local lowerBuyoutOwner
    local key = vendor.Items:GetItemLinkKey(itemLink)
    local scanSet = self.itemModel:GetScanSet()

    if (scanSet) then
        local n = scanSet:Size()
        for i = 1, n do
            local itemLinkKey, time, timeLeft, count, minBidPrice, minIncrement, buyoutPrice, bidAmount, owner, highBidder, index = scanSet:Get(i)
            if (itemLinkKey == key) then
                buyoutPrice = (buyoutPrice or 0) / count
                bidAmount = (bidAmount or 0) / count
                minBidPrice = (minBidPrice or 0) / count
                if (buyoutPrice > 0 and (not buyout or buyoutPrice < buyout)) then
                    lowerBuyoutOwner = owner
                    buyout = buyoutPrice
                    if (bidAmount and bidAmount > 0) then
                        minBid = bidAmount
                    else
                        minBid = minBidPrice
                    end
                end
            end
        end
    end

    --	local _, _, minBid, buyout, _, lowerBuyoutOwner = vendor.Statistic:GetCurrentAuctionInfo(itemLink, vendor.AuctionHouse:IsNeutral(), true)
    log:Debug("lowerBuyoutOwner [%s] buyout [%s] minBid [%s]", lowerBuyoutOwner, buyout, minBid)
    if (self.playerName ~= lowerBuyoutOwner) then
        return _ModifyPrices(minBid, buyout)
    end
    log:Debug("Don't modify prices for self-undercut")
    minBid = _ModifyMinBid(minBid, buyout)
    return minBid, buyout
end

--[[
	Returns item's mulltiplier calculation for current auctions.
--]]
local function _GetMultiplierPrice(self, itemLink)
    local minBid = self.startPrize
    local buyout = self.startPrize
    return _ModifyPrices(minBid, buyout)
end

--[[
	Returns item's market price calculation for current auctions.
--]]
local function _GetMarketPrice(self, itemLink)
    local minBid, buyout = _GetItemAuctionAvgValues(itemLink)
    return _ModifyPrices(minBid, buyout)
end

--[[
	Returns item's lower market price calculation for current auctions.
--]]
local function _GetLowerPrice(self, itemLink)
    local itemLinkKey = vendor.Items:GetItemLinkKey(itemLink)
    local result = vendor.Gatherer:GetCurrentAuctions(itemLinkKey, vendor.AuctionHouse:IsNeutral())
    --log:Debug("_GetLowerPrice size: %d", result:Size())
    local minBid = nil
    local buyout = nil
    if (result:Size() > 0) then
        -- search for first auction above lower market threshold
        local avgMinBid, avgBuyout = _GetItemAuctionAvgValues(itemLink)
        --log:Debug("_GetLowerPrice avgMinBid: %d avgBuyout: %d", avgMinBid or 0, avgBuyout or 0)
        if (avgBuyout and avgBuyout > 0) then
            local limit = avgBuyout * (self.db.profile.lowerMarketThreshold / 100.0)
            --log:Debug("_GetLowerPrice limit: %d", limit)
            minBid = limit
            for i = 1, result:Size() do
                local _, time, timeLeft, count, m, minIncrement, b = result:Get(i)
                --log:Debug("_GetLowerPrice minBid: %d buyout: %d", m or 777, b or 777)
                if (b and b > 0) then
                    b = b / count
                    if (b > limit and (not buyout or buyout > b)) then
                        buyout = b
                    end
                end
            end
        end
    end
    return _ModifyPrices(minBid, buyout)
end

--[[
	Refreshes the deposit.
--]]
local function _UpdateDeposit(self)
    log:Debug("_UpdateDeposit")
    local deposit
    if (self.item) then
        deposit = self.deposits[self.duration]
        local stackCount = self.countDropDown:GetValue() or 1
        if (type(stackCount) == "string") then
            deposit = deposit * self.item.count
        else
            local stackSize = self.stackDropDown:GetValue()
            deposit = deposit * stackSize * stackCount
        end
    end
    self.sellingPrice:SetDeposit(deposit)
    self.sellInfo:Update()
end

--[[
	Returns current values for:
	local stackSize, numStacks, backlog = _GetCounts(self)
--]]
local function _GetCounts(self)
    local stackSize = self.stackDropDown:GetValue()
    local stackCount = self.countDropDown:GetValue()
    local backlog = 0
    return stackSize, stackCount, backlog
end

local function _InitSellInfo(self)
    if (not self.item) then
        log:Debug("_InitSellInfo not item!")
        self.sellInfo:Clear()
    else
        local stackSize, numStacks, backlog = _GetCounts(self)
        log:Debug("_InitSellInfo stackSize [%s] numStacks [%s] backlog [%s]", stackSize, numStacks, backlog)
        self.sellingPrice:SetStackSize(stackSize)
        self.sellingPrice:SetNumStacks(numStacks)
        self.sellingPrice:SetBacklog(backlog)
    end
end

--[[
	Update the prices and sell info display.
--]]
local function _UpdatePrices(self)
    if (not self.item) then
        self.sellInfo:Clear()
    else
        _InitSellInfo(self)
        local minBid, buyout = self.sellingPrice:GetPrices(vendor.Seller.db.profile.bidType)
        minBid = math.floor(minBid + 0.5)
        buyout = math.floor(buyout + 0.5)
        self.lastMinBid = minBid
        self.lastBuyout = buyout
        log:Debug("_UpdatePrices minBid: %d buyout: %s", minBid, buyout or 0)
        MoneyInputFrame_SetCopper(self.startPriceBut, minBid)
        MoneyInputFrame_SetCopper(self.buyoutPriceBut, buyout)
        _UpdateDeposit(self)
        self.sellInfo:Update()
    end
end

--[[
	Updates the count dropdown button
--]]
local function _UpdateCountDropDown(self)
    log:Debug("_UpdateCountDropDown enter")
    if (not self.item) then
        log:Debug("_UpdateCountDropDown not item!")
        return;
    end
    local counts = {}
    local stackSize = self.stackDropDown:GetValue();
    local n = math.max(1, math.floor(self.item.count / stackSize))
    --	local hasAdd = self.item.count > n * stackSize;
    local select = n
    if (self.item.preferedAmount > 0 and self.item.preferedAmount < select) then
        select = self.item.preferedAmount
    end


    -- add all integral stack sizes
    local hasSelect
    local hasN
    local i = 1
    local prev = nil
    while i <= n do
        -- the dropdown has to contain "select" !
        if (not hasSelect and i == select) then
            hasSelect = true
        end
        if (not hasSelect and i > select) then
            log:Debug("add [%s] to counts", select)
            counts[select] = select
            hasSelect = true
        end
        if (i == n) then
            hasN = true
        end
        counts[i] = i
        prev = i
        i = i * 2
    end
    if (not hasSelect) then
        counts[select] = select
    end
    if (not hasN and n ~= select) then
        counts[n] = n
    end

    log:Debug("_UpdateCountDropDown select [%s] n [%s]", select, n)
    self.countDropDown:SetRange(1, n)
    --log:Debug("_UpdateCountDropDown reset count dropdown")
    self.lastCount = select
    self.countDropDown:SetList(counts)
    self.countDropDown:SetValue(select)
    self.sellingPrice:SetStackSize(stackSize)
    self.sellingPrice:SetNumStacks(n)
    self.sellingPrice:SetBacklog(0)
    log:Debug("_UpdateCountDropDown exit")
end

--[[
	Updates the dropdown buttons accoring to the selected item
--]]
local function _UpdateDropDowns(self)
    log:Debug("_UpdateDropDowns enter")
    -- stacksize
    local stackSize = math.min(self.item.stackCount, self.item.count);

    local selectValue
    if (self.item.preferedStackSize > 0 and self.item.preferedStackSize <= stackSize) then
        selectValue = self.item.preferedStackSize
    else
        selectValue = stackSize
    end
    local hasSelectValue

    local stackSizes = {}
    local i = 1
    local prev = nil
    while i <= stackSize do

        if (not hasSelectValue) then
            if (i == selectValue) then
                hasSelectValue = true
            elseif (i > selectValue) then
                stackSizes[selectValue] = selectValue
                hasSelectValue = true
            end
        end

        stackSizes[i] = i
        prev = i
        if (i < 5) then
            i = i + 1
        else
            i = i * 2
        end
    end
    if (not hasSelectValue and selectValue ~= stackSize) then
        stackSizes[selectValue] = selectValue
    end
    if (prev and prev < stackSize) then
        stackSizes[stackSize] = stackSize
    end

    self.stackDropDown:SetList(stackSizes)
    self.stackDropDown:SetValue(selectValue)
    self.stackDropDown:SetRange(1, stackSize)
    self.sellingPrice:SetStackSize(stackSize)
    -- stack count
    _UpdateCountDropDown(self);
    --log:Debug("_UpdateDropDowns exit")
end

--[[
	Shows information if mouse is over the selected item
--]]
local function _OnEnterItem(self, motion)
    GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
    if (self.ctrl.item) then
        -- check if we have a battle pet here
        local name, speciesId, level, breedQuality, maxHealth, power, speed = vendor.Items:GetBattlePetStats(self.ctrl.item.link)
        if (BattlePetTooltip and speciesId) then
            BattlePetToolTip_Show(speciesId, level, breedQuality, maxHealth, power, speed, name)
            BattlePetTooltip:ClearAllPoints()
            BattlePetTooltip:SetPoint("TOPLEFT", self, "TOPRIGHT", 0, 0)
        else
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip.itemCount = self.ctrl.item.count
            GameTooltip:SetHyperlink(self.ctrl.item.link)
        end
    else
        GameTooltip:SetText(L["Drag an item here to auction it"])
    end
end

--[[
	Prizing model was selected.
--]]
local function _PrizingSelected(self, value, keepPrices)
    --log:Debug("_PrizingSelected enter")
    self.sellingPrice:ClearUserDefined()
    if (self.PRIZE_MODEL_CURRENT == value) then
        self.buyoutMul:SelectPriceModel(value)
        --		self.buyoutMul:Show()
    elseif (self.PRIZE_MODEL_MARKET == value) then
        self.buyoutMul:SelectPriceModel(value)
        --		self.buyoutMul:Show()
    elseif (self.PRIZE_MODEL_UNDERCUT == value) then
        self.buyoutMul:SelectPriceModel(value)
        --		self.buyoutMul:Show()
    elseif (self.PRIZE_MODEL_MULTIPLIER == value) then
        self.buyoutMul:SelectPriceModel(value)
        --		self.buyoutMul:Show()
    elseif (self.PRIZE_MODEL_LOWER == value) then
        self.buyoutMul:SelectPriceModel(value)
        --		self.buyoutMul:Show()
        --	else
        --		self.buyoutMul:Hide()
    end
    self:RefreshPrices()
end

--[[
	A money field has been changed (by user or programatically)
--]]
local function _OnMoneyChange()
    local minBid = MoneyInputFrame_GetCopper(self.startPriceBut) or 0
    local buyout = MoneyInputFrame_GetCopper(self.buyoutPriceBut) or 0
    if (self.item and (minBid ~= self.lastMinBid or buyout ~= self.lastBuyout)) then
        -- user has selected a new value
        log:Debug("_OnMoneyChange user typed new selling price")
        --self:SelectPricingModel(self.PRIZE_MODEL_FIX, true)
        self.sellingPrice:SetPrices(minBid, buyout, self.db.profile.bidType, true)
        _UpdatePrices(self)
        _ValidateAuction(self)
    end
end

--[[
	Auction duration radio button has been clicked
--]]
local function _DurationSelected(self, id)
    log:Debug("duration selected");
    PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON);
    if (id == 1) then
        self.duration = DURATIONS[1];
        log:Debug("short");
    elseif (id == 2) then
        self.duration = DURATIONS[2];
        log:Debug("medium duration");
    else
        self.duration = DURATIONS[3];
        log:Debug("long duration");
    end
    _UpdateDeposit(self)
end

local function _UpdateSalesFrame(name, texture, count)
    SalesFrameItem:SetNormalTexture(texture)
    SalesFrameItemName:SetText(name)
    if (count > 1) then
        SalesFrameItemCount:SetText(count)
        SalesFrameItemCount:Show()
    else
        SalesFrameItemCount:Hide()
    end
end

--[[
	Selects the given itemLink for selling
--]]
local function _SelectItem(self, itemLink)
    log:Debug("_SelectItem enter [%s]", vendor.Items:PrintItemLink(itemLink))
    self.sellingPrice:Clear()
    if (not itemLink) then
        log:Debug("_SelectItem no item available!?")
        _UpdateSalesFrame("", nil, 0)
        self.lastItem = self.item;
        self.item = nil;
        self.stackDropDown:SetValidating(false)
        self.countDropDown:SetValidating(false)
    else
        self.stackDropDown:SetValidating(true)
        self.countDropDown:SetValidating(true)
        local name, link, stackCount, texture, count = self.inventory:GetItemInfo(itemLink)
        if (vendor.Items:IsBattlePetLink(itemLink)) then
            -- we may only sell one pet at once
            count = 1
            stackCount = 1
        end
        if (name) then
            _UpdateSalesFrame(name, texture, count)
            local itemLinkKey = vendor.Items:GetItemLinkKey(itemLink);
            local preferedStackSize = 0
            local preferedAmount = 0
            local itemInfo = self.itemInfo
            local itemSettings = self.itemSettings
            vendor.ItemSettings:GetItemSettings(itemLink, itemSettings)
            if (not vendor.Items:GetItemInfo(itemLinkKey, itemInfo, vendor.AuctionHouse:IsNeutral())) then
                log:Debug("Failed to get ItemInfo")
                itemInfo = nil
            end
            if (itemSettings.general.rememberStacksize and itemInfo and itemInfo.stackSize <= count) then
                preferedStackSize = itemInfo.stackSize;
            elseif (itemSettings.general.stacksize) then
                preferedStackSize = itemSettings.general.stacksize
            end
            if (itemSettings.general.rememberAmount and itemInfo and itemInfo.amount > 0 and itemInfo.amount <= count) then
                log:Debug("take remembered amount [%s]", itemInfo.amount)
                preferedAmount = itemInfo.amount
            elseif (itemSettings.general.amount and itemSettings.general.amount > 0) then
                log:Debug("take prefered amount [%s]", itemSettings.general.amount)
                preferedAmount = itemSettings.general.amount
            end
            if (itemSettings.general.rememberDuration and itemInfo and itemInfo.duration and itemInfo.duration > 0) then
                log:Debug("select duration: " .. itemInfo.duration)
                self.durationDropDown:SetValue(itemInfo.duration)
                _DurationSelected(self, itemInfo.duration)
            elseif (itemSettings.general.duration) then
                self.durationDropDown:SetValue(itemSettings.general.duration)
                _DurationSelected(self, itemSettings.general.duration)
            else
                log:Debug("select default duration: %s", self.db.profile.defaultDuration)
                log:Debug("id: %d", self.db.profile.defaultDuration)
                self.durationDropDown:SetValue(self.db.profile.defaultDuration)
                _DurationSelected(self, self.db.profile.defaultDuration)
            end
            if (itemSettings.pricingModel.rememberPricingModel and itemInfo and itemInfo.priceModel and itemInfo.priceModel > 0) then
                log:Debug("select priceModel: " .. itemInfo.priceModel)
                self.prizingDropDown:SetValue(itemInfo.priceModel)
                _PrizingSelected(self, itemInfo.priceModel)
            elseif (itemSettings.pricingModel.pricingModel) then
                self.prizingDropDown:SetValue(itemSettings.pricingModel.pricingModel)
                _PrizingSelected(self, itemSettings.pricingModel.pricingModel)
            end
            self.item = { name = name, link = link, stackCount = stackCount, texture = texture, count = count, preferedStackSize = preferedStackSize, preferedAmount = preferedAmount, itemLinkKey = itemLinkKey, itemSettings = itemSettings };
            _UpdateDropDowns(self);
            --self.auto:SetItem(itemLink)
        else
            -- item disappaered after it had been selected
            log:Debug("item seems to have disappeared")
            _SelectItem(self, nil);
        end
    end
    self:RefreshPrices()
    _ValidateAuction(self);
    log:Debug("_SelectItem exit")
end

local function _HandleWoWToken(self, itemLink)
    log:Debug("_HandleWoWToken")
    local name, link, stackCount, texture, count = self.inventory:GetItemInfo(itemLink)
    if (name) then
        --_UpdateSalesFrame(name, texture, count)
        --AuctionsItemButton:SetNormalTexture(texture)
        --AuctionsItemButtonName:SetText(name)
        ClickAuctionSellItemButton()
        vendor.AuctionHouse:ShowBlizzardAuctionTabOnce()
    end
    ClearCursor()
end

local function GetPrices()
    local startPrice = MoneyInputFrame_GetCopper(StartPrice);
    local buyoutPrice = MoneyInputFrame_GetCopper(BuyoutPrice);
    if ( AuctionFrameAuctions.priceType == PRICE_TYPE_UNIT) then
        startPrice =  startPrice * AuctionsStackSizeEntry:GetNumber();
        buyoutPrice = buyoutPrice * AuctionsStackSizeEntry:GetNumber();
    end
    return startPrice,buyoutPrice;
end

--[[
	Picks the given item for selling.
--]]
local function _PickItem(self, itemLink)
    log:Debug("_PickItem enter")
    if (itemLink) then
        local itemId = vendor.Items:GetItemLinkId(itemLink)
        log:Debug("itemId [%s]", itemId)
        if (itemId == "122270") then
            return _HandleWoWToken(self, itemLink)
        else
            -- use blizzard's auction slot to calculate deposit and start prize
            vendor.clickAuctionSellItemButton()
            local _, _, count, _, _, price = GetAuctionSellItemInfo();
            self.deposits = {};
            local startPrice, buyoutPrice = GetPrices()
            for _, duration in ipairs(DURATIONS) do
                local deposit = GetAuctionDeposit(duration, startPrice, buyoutPrice);
                if (deposit) then
                    deposit = deposit / count
                end
                self.deposits[duration] = deposit or 1
            end;
            self.startPrize = math.max(1, price / count)
            log:Debug("_PickItem stratPrize [%s]", self.startPrize)
            _SelectItem(self, itemLink);
            -- now free blizzard's auction slot
            vendor.clickAuctionSellItemButton()
        end
    end
    ClearCursor();
    _RefreshClicked(self)
end

--[[
	Picks the currently dragged item for selling.
--]]
local function _PickItemFromCursor(self)
    local type, _, itemLink = GetCursorInfo();
    if (type and type == "item" and itemLink) then
        _PickItem(self, itemLink)
    end
end

--[[
	Updates the list of inventory items.
--]]
local function _UpdateInventory(self)
    if (self.frame and self.frame:IsVisible()) then
        self.inventory:Update();
        if (self.item) then
            _SelectItem(self, self.item.link);
        end
    end
end

--[[
	Creates an auction with the currently selected item.
--]]
local function _CreateAuction(self)
    log:Debug("CreateAuction")
    if (self.item) then
        local itemLink = self.item.link;
        local runTime = self.duration;
        local stackSize = self.stackDropDown:GetValue();
        if (not self.stackDropDown:IsValid() or not self.countDropDown:IsValid()) then
            vendor.Vendor:Error(L["Please correct the drop downs first!"])
            return nil
        end
        -- remember several dropdown button values for next time
        local itemInfo = self.itemInfo
        if (not vendor.Items:GetItemInfo(self.item.itemLinkKey, itemInfo, vendor.AuctionHouse:IsNeutral())) then
            vendor.Items:InitItemInfo(itemInfo)
        end
        if (self.selectedStackSize) then
            -- a stackSize was selected manually, remember it
            itemInfo.stackSize = self.selectedStackSize;
        end
        local stackCount = self.countDropDown:GetValue()
        if (type(stackCount) ~= "string") then
            itemInfo.amount = stackCount
        end
        itemInfo.priceModel = self.prizingDropDown:GetValue()
        itemInfo.duration = self.durationDropDown:GetValue()
        vendor.Items:PutItemInfo(self.item.itemLinkKey, vendor.AuctionHouse:IsNeutral(), itemInfo);
        self.selectedStackSize = nil;
        -- create sell task
        self:RefreshPrices()
        local minBid, buyout = self.sellingPrice:GetPrices(vendor.SellingPrice.BID_TYPE_PER_ITEM)
        local stackSize, stackCount, backlog = _GetCounts(self)

        _Sell(itemLink, minBid, buyout, runTime, stackSize, stackCount)

        -- clear focus of edit boxes
        self.stackDropDown:ClearFocus()
        self.countDropDown:ClearFocus()
    end
end

local function _Edit(but)
    local self = but.obj
    if (self.item) then
        vendor.ItemSettings:SelectItem(self.item.link)
    else
        vendor.ItemSettings:SelectItem(nil)
    end
    vendor.ItemSettings:Toggle("TOPLEFT", but, "BOTTOMRIGHT", 0, 90)
end

--[[
	Creates the auction buttons.
--]]
local function _CreateAuctionButtons(self)
    -- edit
    local but = CreateFrame("Button", nil, self.frame, "UIPanelButtonTemplate")
    but.obj = self
    but:SetText(L["Edit"])
    but:SetWidth(80)
    but:SetHeight(20)
    but:SetPoint("TOPLEFT", 120, -137)
    --but:SetNormalTexture("Interface\\Addons\\AuctionMaster\\src\\resources\\UI-Panel-Button-Up-green")
    but:SetScript("OnClick", _Edit)
    --vendor.GuiTools.AddTooltip(but, L["Scans the auction house for updating statistics and sniping items. Uses a fast \"GetAll\" scan, if the scan button is displayed with a green background. This is only possible each 15 minutes."])

    -- item to be sold
    local texture = vendor.GuiTools.CreateTexture(nil, self.frame, "ARTWORK", "Interface\\Addons\\AuctionMaster\\src\\resources\\ItemContainer", 256, 64)
    texture:SetPoint("TOPLEFT", 27, -92)
    local f = self.frame:CreateFontString("SalesFrameItemText", "ARTWORK", "GameFontHighlightSmall");
    f:SetText(L["Auction Item"]);
    f:SetPoint("TOPLEFT", 28, -79);
    self.itemBut = CreateFrame("Button", "SalesFrameItem", self.frame);
    self.itemBut.ctrl = self;
    self.itemBut:SetWidth(37);
    self.itemBut:SetHeight(37);
    self.itemBut:SetPoint("TOPLEFT", 28, -94);
    local f = self.itemBut:CreateFontString("SalesFrameItemName", "BACKGROUND", "GameFontNormal");
    f:SetWidth(124);
    f:SetHeight(30);
    f:SetPoint("TOPLEFT", self.itemBut, "TOPRIGHT", 5, 0);
    local f = self.itemBut:CreateFontString("SalesFrameItemCount", "OVERLAY", "NumberFontNormal");
    f:SetJustifyH("RIGHT");
    f:SetPoint("BOTTOMRIGHT", -5, 2);
    self.itemBut:RegisterForDrag("LeftButton");
    self.itemBut:SetScript("OnClick", function(but) _PickItemFromCursor(but.ctrl); _ValidateAuction(but.ctrl); end);
    self.itemBut:SetScript("OnDragStart", function(but) _PickItemFromCursor(but.ctrl); _ValidateAuction(but.ctrl); end);
    self.itemBut:SetScript("OnReceiveDrag", function(but) _PickItemFromCursor(but.ctrl); end);
    self.itemBut:SetScript("OnEnter", _OnEnterItem);
    self.itemBut:SetScript("OnLeave", function() GameTooltip:Hide(); if (BattlePetTooltip) then BattlePetTooltip:Hide() end end)
    self.itemBut:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square");

    -- duration of auction
    log:Debug("create durations")
    local durations = {}
    durations[1] = "12 " .. GetText("HOURS", nil, 12)
    durations[2] = "24 " .. GetText("HOURS", nil, 24)
    durations[3] = "48 " .. GetText("HOURS", nil, 48)
    --	self.durationDropDown = vendor.DropDownButton:new("SalesFrameDuration", self.frame, 85, L["Auction Duration"], "");
    --	self.durationDropDown:SetPoint("TOPLEFT", 10, -174);
    -- 	self.durationDropDown:SetId(DURATION_DROPDOWN_ID);
    --	self.durationDropDown:SetListener(self);
    --	self.durationDropDown:SetItems(durations, self.db.profile.defaultDuration)
    self.duration = DURATIONS[self.db.profile.defaultDuration]
    self.durationDropDown = vendor.GuiTools.CreateDropDown(self.frame, 105, L["Auction Duration"])
    self.durationDropDown.obj = self
    self.durationDropDown:SetPoint("TOPLEFT", 22, -174)
    self.durationDropDown:SetList(durations)
    self.durationDropDown:SetValue(self.db.profile.defaultDuration)
    self.durationDropDown:SetCallback("OnValueChanged", function(widget, event, value)
        log:Debug("duration selected");
        _DurationSelected(widget.obj, value)
    end)

    -- stacksize
    --	self.stackDropDown = vendor.DropDownButton:new("SalesFrameStackSize", self.frame, 50, L["Stack size"], L["Selects the size of the stacks to be sold."]);
    --	self.stackDropDown:SetPoint("TOPLEFT", 118, -174);
    --	self.stackDropDown:SetId(STACK_DROPDOWN_ID);
    --	self.stackDropDown:SetListener(self);
    --	self.stackDropDown:SetEditable(true)
    --	self.stackDropDown:SetNumeric(true)
    self.stackDropDown = vendor.GuiTools.CreateEditDropDown(self.frame, 55, L["Stack size"], L["Selects the size of the stacks to be sold."])
    self.stackDropDown.obj = self
    self.stackDropDown:SetPoint("TOPLEFT", 130, -175)
    self.stackDropDown:SetNumeric(true)
    self.stackDropDown:SetCallback("OnValueChanged", function(widget, event, value)
        local self = widget.obj
        if (self.item) then
            local stackSize = self.stackDropDown:GetValue()
            log:Debug("DropDownButtonSelected stackSize: %d", stackSize)
            _UpdateCountDropDown(self)
            self.selectedStackSize = stackSize
            self:RefreshPrices()
        end
    end)

    -- count of "stacks"
    --	self.countDropDown = vendor.DropDownButton:new("SalesFrameCount", self.frame, 50, L["Amount"], L["Selects the number of stacks to be sold.\nThe number with the +-suffix sells\nalso any remaining items."]);
    --	self.countDropDown:SetPoint("TOPLEFT", SalesFrameStackSize, "BOTTOMLEFT", 0, -16);
    -- 	self.countDropDown:SetId(COUNT_DROPDOWN_ID);
    --	self.countDropDown:SetListener(self);
    --	self.countDropDown:SetEditable(true)
    --	self.countDropDown:SetNumeric(true)
    self.countDropDown = vendor.GuiTools.CreateEditDropDown(self.frame, 55, L["Amount"], L["Selects the number of stacks to be sold.\nThe number with the +-suffix sells\nalso any remaining items."])
    self.countDropDown.obj = self
    self.countDropDown:SetPoint("TOPLEFT", self.stackDropDown.frame, "BOTTOMLEFT", 0, -16)
    self.countDropDown:SetNumeric(true)
    self.countDropDown:SetCallback("OnValueChanged", function(widget, event, value)
        local self = widget.obj
        if (self.item) then
            self:RefreshPrices()
        end
    end)

    -- prizing model
    local prizeModels = {}
    prizeModels[self.PRIZE_MODEL_FIX] = L["Fixed price"]
    prizeModels[self.PRIZE_MODEL_CURRENT] = L["Current price"]
    prizeModels[self.PRIZE_MODEL_UNDERCUT] = L["Undercut"]
    prizeModels[self.PRIZE_MODEL_LOWER] = L["Lower market threshold"]
    prizeModels[self.PRIZE_MODEL_MULTIPLIER] = L["Selling price"]
    prizeModels[self.PRIZE_MODEL_MARKET] = L["Market price"]
    --	self.prizingDropDown = vendor.DropDownButton:new("SalesFramePrizing", self.frame, 85, L["Price calculation"], L["Selects the mode for calculating the sell prices.\nThe default mode Fixed price just select the last sell price."]);
    --	self.prizingDropDown:SetPoint("TOPLEFT", SalesFrameDuration, "BOTTOMLEFT", 0, -16);
    -- 	self.prizingDropDown:SetId(PRIZING_DROPDOWN_ID);
    --	self.prizingDropDown:SetListener(self);
    --	self.prizingDropDown:SetItems(prizeModels, self.PRIZE_MODEL_FIX);
    self.prizingDropDown = vendor.GuiTools.CreateDropDown(self.frame, 105, L["Price calculation"], L["Selects the mode for calculating the sell prices.\nThe default mode Fixed price just select the last sell price."])
    self.prizingDropDown.obj = self
    self.prizingDropDown:SetPoint("TOPLEFT", self.durationDropDown.frame, "BOTTOMLEFT", 0, -16)
    self.prizingDropDown:SetList(prizeModels)
    self.prizingDropDown:SetValue(self.PRIZE_MODEL_FIX)
    self.prizingDropDown:SetCallback("OnValueChanged", function(widget, event, value)
        _PrizingSelected(widget.obj, value)
    end)

    self.buyoutMul = vendor.BuyoutModifier:new()
    --self.buyoutMul:SetPoint("TOPLEFT", SalesFramePrizing, "BOTTOMLEFT", 24, -6)

    --self.auto:CreateFrame(self.frame)

    -- hrule to separate the sections
    local texture = vendor.GuiTools.CreateTexture(nil, self.frame, "ARTWORK", "Interface\\Addons\\AuctionMaster\\src\\resources\\HRule", 256, 16)
    texture:SetPoint("TOPLEFT", 23, -255)

    -- starting prize
    f = self.frame:CreateFontString("SalesFramePriceText", "ARTWORK", "GameFontHighlightSmall");
    f:SetPoint("TOPLEFT", 28, -268);
    self.minBidFont = f
    self.startPriceBut = CreateFrame("Frame", "SalesFrameStartPrice", self.frame, "MoneyInputFrameTemplate");
    self.startPriceBut:SetPoint("TOPLEFT", SalesFramePriceText, "BOTTOMLEFT", 3, -2);
    self.startPriceBut.controller = self;
    MoneyInputFrame_SetOnValueChangedFunc(self.startPriceBut, _OnMoneyChange)
    local frameName = self.startPriceBut:GetName();
    local goldBut = getglobal(frameName .. "GoldButton");
    SalesFrameStartPriceGold:SetMaxLetters(6);

    -- buyout prize
    f = self.frame:CreateFontString("SalesFrameBuyoutText", "ARTWORK", "GameFontHighlightSmall");
    self.buyoutFont = f
    f:SetPoint("TOPLEFT", SalesFramePriceText, 0, -35);
    self.buyoutPriceBut = CreateFrame("Frame", "SalesFrameBuyoutPrice", self.frame, "MoneyInputFrameTemplate");
    self.buyoutPriceBut:SetPoint("TOPLEFT", 31, -317);
    self.buyoutPriceBut.controller = self;
    MoneyInputFrame_SetOnValueChangedFunc(self.buyoutPriceBut, _OnMoneyChange)
    SalesFrameBuyoutPriceGold:SetMaxLetters(6);

    -- hrule to separate the sections
    local texture = vendor.GuiTools.CreateTexture(nil, self.frame, "ARTWORK", "Interface\\Addons\\AuctionMaster\\src\\resources\\HRule", 256, 16)
    texture:SetPoint("TOPLEFT", 23, -338)

    -- area for sell information
    self.sellInfo = vendor.SellInfo:new(self.frame, self.sellingPrice)
    self.sellInfo:SetPoint("TOPLEFT", 25, -347)

    -- Set focus rules
    self.stackDropDown:SetPrevFocus(SalesFrameBuyoutPriceCopper)
    self.stackDropDown:SetNextFocus(self.countDropDown.editBox)
    self.countDropDown:SetPrevFocus(self.stackDropDown.editBox)
    self.countDropDown:SetNextFocus(SalesFrameStartPriceGold)
    MoneyInputFrame_SetPreviousFocus(SalesFrameStartPrice, self.countDropDown.editBox)
    MoneyInputFrame_SetNextFocus(SalesFrameStartPrice, SalesFrameBuyoutPriceGold)
    MoneyInputFrame_SetPreviousFocus(SalesFrameBuyoutPrice, SalesFrameStartPriceCopper)
    MoneyInputFrame_SetNextFocus(SalesFrameBuyoutPrice, self.stackDropDown.editBox)

    -- total deposit
    f = self.frame:CreateFontString("SalesFrameDepositText", "ARTWORK", "GameFontNormal");
    f:SetText(L["Deposit:"]);
    f:SetPoint("TOPLEFT", 28, -364);
    f:Hide()
    self.depositBut = CreateFrame("Frame", "SalesFrameDeposit", self.frame, "DepositFrameTemplate");
    self.depositBut:SetPoint("LEFT", SalesFrameDepositText, "RIGHT", 5, 0);
    self.depositBut.controller = self;
    self.depositBut:Hide()

    -- up-to-dateness of the item list
    --	f = self.frame:CreateFontString("SalesFrameUpToDatenessText", "ARTWORK", "GameFontNormal");
    --	f:SetText("");
    --	f:SetPoint("BOTTOMLEFT", 300, 20);
    --	self.statusText = f;

    -- auction creation
    self.createBut = CreateFrame("Button", "SalesFrameCreate", self.frame, "UIPanelButtonTemplate");
    self.createBut:SetText(L["Create Auction"]);
    self.createBut:SetWidth(191);
    self.createBut:SetHeight(20);
    self.createBut:SetPoint("BOTTOMLEFT", 18, 39);
    self.createBut.ctrl = self;
    self.createBut:SetScript("OnClick", function(but) _CreateAuction(but.ctrl) end);

    -- auction creation not possible error text
    self.buyoutErrorText = self.frame:CreateFontString("SalesFrameBuyoutErrorText", "ARTWORK", "GameFontRedSmall");
    self.buyoutErrorText:SetText(L["Buyout < bid"]);
    self.buyoutErrorText:SetPoint("TOPLEFT", self.createBut, "TOPLEFT", 15, -5);

    -- scan progress
    -- status bar
    local statusBar = CreateFrame("StatusBar", nil, self.frame, "TextStatusBar")
    self.statusBar = statusBar
    statusBar.obj = self
    statusBar:SetHeight(14)
    statusBar:SetWidth(622)
    statusBar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
    statusBar:SetPoint("TOPLEFT", 70, -17)
    statusBar:SetMinMaxValues(0, 1)
    statusBar:SetValue(1)
    statusBar:SetStatusBarColor(0, 1, 0)

    -- status bar text
    local text = statusBar:CreateFontString(nil, "ARTWORK")
    self.statusBarText = text
    text:SetPoint("CENTER", statusBar)
    text:SetFontObject("GameFontHighlight")
    self:SetProgress("", 0)

    _UpdateFonts(self)
end

--[[
	Creates the central close etc. buttons.
--]]
local function _CreateFrameButtons(self)
    self.closeBut = vendor.AuctionHouse:CreateCloseButton(self.frame, "SalesFrameClose");
end

local function _OnUndercutClick(self, minBid, buyout, owner)
    -- TODO : get owner of auction
    if (self.playerName ~= owner) then
        log:Debug("buyout before: %s", buyout)
        self.buyoutMul:SelectPriceModel(self.PRIZE_MODEL_UNDERCUT)
        minBid, buyout = _ModifyPrices(minBid, buyout)
        log:Debug("buyout after: %s", buyout)
    else
        log:Debug("Don't undercut own auction")
        minBid = _ModifyMinBid(minBid, buyout)
    end
    self.sellingPrice:SetPrices(minBid, buyout, vendor.SellingPrice.BID_TYPE_PER_ITEM, true)
    _UpdatePrices(self)
end

--[[
	One of the item tables should be resized.
--]]
local function _ItemTableResize(itemTable, self, value)
    if (self.itemTable.name == itemTable.name) then
        log:Debug("resize auctions itemTable")
        self.inventorySeller:SetSize(100 - value)
    else
        log:Debug("resize inventory itemTable")
        self.itemTable:SetSize(100 - value)
    end
end

--[[
	Initializes the module.
--]]
function vendor.Seller:OnInitialize()
    self.db = vendor.Vendor.db:RegisterNamespace("Seller", {
        profile = {
            pickupByClick = true,
            rememberStackSize = true,
            rememberDuration = true,
            rememberPriceModel = true,
            upperMarketThreshold = 200,
            lowerMarketThreshold = 30,
            --autoPriceModel = true,
            defaultDuration = 3,
            bidType = 1,
            itemTableCfg = {
                size = 100,
                rowHeight = 14,
                selected = {
                    [1] = vendor.ScanSetItemModel.NAME,
                    [2] = vendor.ScanSetItemModel.COUNT,
                    [3] = vendor.ScanSetItemModel.BID,
                    [4] = vendor.ScanSetItemModel.BUYOUT,
                    [5] = vendor.ScanSetItemModel.UNDERCUT,
                },
            },
            inventoryTableCfg = {
                size = 0,
                rowHeight = 26,
                selected = {
                    [1] = vendor.InventoryItemModel.TEXTURE,
                    [2] = vendor.InventoryItemModel.NAME,
                    [3] = vendor.InventoryItemModel.CURRENT_AUCTIONS,
                    [4] = vendor.InventoryItemModel.BID,
                    [5] = vendor.InventoryItemModel.BUYOUT,
                },
            },
            bidCalc = false,
            bidMul = 90,
        }
    });
    _MigrateDb(self)
    self.updateCountdown = UPDATE_INTERVAL
    self.itemInfo = {} -- prevent too much garbage
    self.itemSettings = {} -- prevent too much garbage
    --self.auto = vendor.AutomaticPriceModel:new()
    self.sellingPrice = vendor.SellingPrice:new()
end

--[[
	Initializes the module.
--]]
function vendor.Seller:InitTab()
    self:UpdateConfig()
    self.playerName = UnitName("player")
    self.isScanning = false
    self.cancelAuctions = {}
    self.inventory = vendor.InventoryHandle:new()
    self.lastItem = nil
    self:RegisterEvent("BAG_UPDATE")
    self:RegisterEvent("AUCTION_HOUSE_CLOSED")
    self:RegisterEvent("NEW_AUCTION_UPDATE")
    --	self:RegisterMessage("AUCTION_STATISTIC_UPDATE")
    self:RegisterMessage("ITEM_SETTINGS_UPDATED")
    self:RegisterMessage("AUCTION_ACTION")
    self:Hook("PostAuction", true);
    -- register for new ScanResults
    self.frame = vendor.AuctionHouse:CreateTabFrame("AuctionFrameVendor", "AuctionMaster", L["Sell"], self);
    self.frame.obj = self
    --self.vendorTabButton = vendor.AuctionHouse:CreateTabButton(L["Seller"], 4);
    _CreateFrameButtons(self);
    _CreateAuctionButtons(self);
    local itemModel = vendor.ScanSetItemModel:new()
    itemModel:SetUndercutCallback(_OnUndercutClick, self)
    self.itemModel = itemModel
    local cmds = vendor.Vendor:OrderTable(CMDS)
    local cfg = {
        name = "AMSellerAuctions",
        parent = self.frame,
        itemModel = itemModel,
        cmds = cmds,
        config = self.db.profile.itemTableCfg,
        width = 609,
        height = 358,
        xOff = 214,
        yOff = -51,
        upperList = true,
        sortButtonBackground = false,
        resizeFunc = _ItemTableResize,
        resizeArg = self,
        sizable = true
    }
    local itemTable = vendor.ItemTable:new(cfg)
    self.itemTable = itemTable
    self.inventorySeller = vendor.InventorySeller:new(self.frame, self.db.profile.inventoryTableCfg, _ItemTableResize, self)
    self.itemModel.ownerHighlight = self.itemTable:AddHighlight(0.6, 1, 1, 0.8)
    self.itemModel.playerHasBidHighlight = self.itemTable:AddHighlight(1, 0.6, 0.6, 0.8)
end

--[[
	Updates the gui for displaying the frame (Interface method).
--]]
function vendor.Seller:UpdateTabFrame()
    log:Debug("Seller:UpdateTabFrame enter")
    --	AuctionFrameTopLeft:SetTexture("Interface\\Addons\\AuctionMaster\\src\\resources\\UI-AuctionFrame-Auction-TopLeft")
    --	--AuctionFrameTop:SetTexture("Interface\\AuctionFrame\\UI-AuctionFrame-Auction-Top")
    --	AuctionFrameTop:SetTexture("Interface\\Addons\\AuctionMaster\\src\\resources\\UI-AuctionFrame-Auction-Top")
    --	--AuctionFrameTopRight:SetTexture("Interface\\AuctionFrame\\UI-AuctionFrame-Auction-TopRight")
    --	AuctionFrameTopRight:SetTexture("Interface\\Addons\\AuctionMaster\\src\\resources\\UI-AuctionFrame-Auction-TopRight")
    --	AuctionFrameBotLeft:SetTexture("Interface\\Addons\\AuctionMaster\\src\\resources\\UI-AuctionFrame-Auction-BotLeft")
    --	--AuctionFrameBot:SetTexture("Interface\\AuctionFrame\\UI-AuctionFrame-Auction-Bot")
    --	AuctionFrameBot:SetTexture("Interface\\Addons\\AuctionMaster\\src\\resources\\UI-AuctionFrame-Auction-Bot")
    --	AuctionFrameBotRight:SetTexture("Interface\\Addons\\AuctionMaster\\src\\resources\\UI-AuctionFrame-Auction-BotRight")

    --AuctionFrameTopLeft:SetTexture("Interface\\AuctionFrame\\UI-AuctionFrame-Auction-TopLeft")
    AuctionFrameTopLeft:SetTexture("Interface\\Addons\\AuctionMaster\\src\\resources\\Seller-TopLeft")
    AuctionFrameTop:SetTexture("Interface\\Addons\\AuctionMaster\\src\\resources\\SearchScanFrame-Top")
    AuctionFrameTopRight:SetTexture("Interface\\Addons\\AuctionMaster\\src\\resources\\SearchScanFrame-TopRight")
    AuctionFrameBotLeft:SetTexture("Interface\\Addons\\AuctionMaster\\src\\resources\\Seller-BotLeft")
    --AuctionFrameBotLeft:SetTexture("Interface\\AuctionFrame\\UI-AuctionFrame-Auction-BotLeft")
    AuctionFrameBot:SetTexture("Interface\\Addons\\AuctionMaster\\src\\resources\\SearchScanFrame-Bot")
    AuctionFrameBotRight:SetTexture("Interface\\Addons\\AuctionMaster\\src\\resources\\SearchScanFrame-BotRight")

    --self.auto:SetItem(nil)
    log:Debug("Seller:UpdateTabFrame exit")
end

--[[
	Returns the type of this auction house tab.
--]]
function vendor.Seller:GetTabType()
    return SELLER_TAB;
end

--[[
	Shows the tabbed frame (Interface method).
--]]
function vendor.Seller:ShowTabFrame()
    log:Debug("Seller:ShowTabFrame enter")
    self.frame:Show();
    _UpdateInventory(self);
    self.inventorySeller:UpdateInventory()
    self.itemTable:Show()
    self.inventorySeller:Show()
    log:Debug("Seller:ShowTabFrame exit")
end

--[[
	Hides the tabbed frame (Interface method).
--]]
function vendor.Seller:HideTabFrame()
    log:Debug("Seller:HideTabFrame enter")
    self.frame:Hide();
    log:Debug("Seller:HideTabFrame exit")
end

--[[
	BAG_UPDATe event has been triggered.
--]]
function vendor.Seller:BAG_UPDATE()
    _UpdateInventory(self)
end

--[[
	Auction house has been closed
--]]
function vendor.Seller:AUCTION_HOUSE_CLOSED()
    _SelectItem(self, nil);
    self.item = nil
    self.lastItem = nil
    self.itemModel:SetScanSet(nil)
end

--[[
	Hooks the PostAuction function to remember the prizes.
--]]
function vendor.Seller:PostAuction(minBid, buyoutPrize, runTime, stackSize, numStacks)
    -- we want to remember the "minBid" and "buyoutPrice" for the next time
    local name, texture, count, quality, canUse, price, pricePerUnit, stackCount, totalCount = GetAuctionSellItemInfo()
    log:Debug("PostAuction stackSize [%s] numStacks [%s] minBid [%s]", stackSize, numStacks, minBid)
    if (name) then
        -- unfortunately we need the itemLink, we have to scan the inventory
        local itemLink = _FindInventoryItemLink(name);
        if (itemLink) then
            local itemLinkKey = vendor.Items:GetItemLinkKey(itemLink);
            local itemInfo = self.itemInfo
            if (not vendor.Items:GetItemInfo(itemLinkKey, itemInfo, vendor.AuctionHouse:IsNeutral())) then
                vendor.Items:InitItemInfo(itemInfo)
            end
            itemInfo.minBid = math.floor(minBid / stackSize);
            itemInfo.buyout = math.floor(buyoutPrize / stackSize);
            log:Debug("remember minBid [%s] buyout [%s]", itemInfo.minBid, itemInfo.buyout)
            vendor.Items:PutItemInfo(itemLinkKey, vendor.AuctionHouse:IsNeutral(), itemInfo);
        end
    end
end

--[[
	Event callback for filling in last auction prizes for the given item.
--]]
function vendor.Seller:NEW_AUCTION_UPDATE()
    MoneyInputFrame_SetCopper(StartPrice, 0);
    MoneyInputFrame_SetCopper(BuyoutPrice, 0);
    -- we want to fill in old "minBid" and "buyoutPrice"
    local name, texture, count, quality, canUse, price = GetAuctionSellItemInfo();
    if (name) then
        -- unfortunately we need the itemLink, we have to scan the inventory
        local itemLink = _FindInventoryItemLink(name);
        if (itemLink) then
            local itemInfo = self.itemInfo
            if (vendor.Items:GetItemInfo(itemLinkKey, itemInfo, vendor.AuctionHouse:IsNeutral())) then
                if (itemInfo.minBid > 0) then
                    MoneyInputFrame_SetCopper(StartPrice, itemInfo.minBid * count);
                end
                if (itemInfo.buyout > 0) then
                    MoneyInputFrame_SetCopper(BuyoutPrice, itemInfo.buyout * count);
                end
            end
        end
    end
end

function vendor.Seller:ITEM_SETTINGS_UPDATED()
    log:Debug("ITEM_SETTINGS_UPDATED")
    if (self.item and self.item.link) then
        _SelectItem(self, self.item.link)
    end
end

--[[
	Returns information about the currently selected item, if any.
	@return itemName, itemLink
--]]
function vendor.Seller:GetSelectedItemInfo()
    if (self.item) then
        return self.item.name, self.item.link;
    end
    return nil;
end

--[[
	Returns whether the seller frame is currently visible.
--]]
function vendor.Seller:IsSellerFrameVisible()
    return vendor.AuctionHouse:IsAuctionHouseTabShown(SELLER_TAB)
end

--[[
	Inventory item was clicked, we pick it up for the seller frame, if appropriate. 
--]]
function vendor.Seller:ContainerFrameItemButton_OnModifiedClick(frame, button, ...)
    -- some addons forget to pass the button parameter :-(
    log:Debug("OnModifiedClick")
    local but = button or "LeftButton"
    if (((but == "RightButton") or (but == "LeftButton" and IsShiftKeyDown())) and self:IsSellerFrameVisible() and not CursorHasItem()) then
        local itemLink = GetContainerItemLink(frame:GetParent():GetID(), frame:GetID())
        if (itemLink) then
            -- we have to pickup for deposit calculation
            PickupContainerItem(frame:GetParent():GetID(), frame:GetID())
            _PickItem(self, itemLink)
        end
    else
        self.hooks["ContainerFrameItemButton_OnModifiedClick"](frame, button, ...)
    end
end

--[[
	Selects the given pricing model.
--]]
function vendor.Seller:SelectPricingModel(id, keepPrices)
    log:Debug("Seller:SelectPricingModel enter id: " .. (id or "NA"))
    self.prizingDropDown:SetValue(id)
    _PrizingSelected(self, id, keepPrices)
    log:Debug("Seller:SelectPricingModel exit")
end

--[[
	Refreshes the prices for minbid resp. buyout. 
--]]
function vendor.Seller:RefreshPrices()
    log:Debug("RefreshPrizes")
    if (not self.sellingPrice:IsUserDefined()) then
        local minBid = 0
        local buyout = 0
        if (not self.stackDropDown:IsValid()) then
            --log:Debug("RefreshPrizes exit because of invalid stack drop down")
            return nil
        end
        if (not self.countDropDown:IsValid()) then
            --log:Debug("RefreshPrizes exit because of invalid count drop down")
            return nil
        end
        if (self.item) then
            _InitSellInfo(self)
            -- determine prizing model
            local prizeModel = self.prizingDropDown:GetValue()
            if (prizeModel == self.PRIZE_MODEL_FIX) then
                minBid, buyout = _GetItemAuctionSellValues(self.item.link)
            elseif (prizeModel == self.PRIZE_MODEL_MARKET) then
                minBid, buyout = _GetMarketPrice(self, self.item.link)
            elseif (prizeModel == self.PRIZE_MODEL_CURRENT) then
                minBid, buyout = _GetCurrentPrice(self, self.item.link)
            elseif (prizeModel == self.PRIZE_MODEL_UNDERCUT) then
                minBid, buyout = _GetUndercutPrice(self, self.item.link)
            elseif (prizeModel == self.PRIZE_MODEL_MULTIPLIER) then
                minBid, buyout = _GetMultiplierPrice(self, self.item.link)
            elseif (prizeModel == self.PRIZE_MODEL_LOWER) then
                minBid, buyout = _GetLowerPrice(self, self.item.link)
            end
            if (not minBid or minBid <= 0) then
                minBid = self.startPrize
            end
            if (not buyout or buyout <= 0) then
                buyout = minBid * 2
            end
        end
        self.sellingPrice:SetPrices(minBid, buyout, vendor.SellingPrice.BID_TYPE_PER_ITEM, false)
        --log:Debug("RefreshPrizes minBidPerItem [%s] buyoutPerItem [%s] item [%s] startPrice [%s]", minBid, buyout or 0, self.item, self.startPrize)
    end
    _UpdatePrices(self)
end

--[[
	Selects the given inventory item for selling.
--]]
function vendor.Seller:SelectInventoryItem(itemLink)
    _PickItem(self, itemLink)
end

--[[
	Sets the progress together with the given message.
--]]
function vendor.Seller:SetProgress(msg, percent)
    --log:Debug("SetProgress msg [%s] percent [%s]", msg, percent)
    --	self:Show()
    if (msg and strlen(msg) > 0) then
        self.title:Hide()
        self.statusBar:Show()
        self.statusBarText:Show()
        self.statusBar:SetValue(percent)
        self.statusBarText:SetText(msg)
    else
        self.title:Show()
        self.statusBar:Hide()
        self.statusBarText:Hide()
    end
end

function vendor.Seller:UpdateConfig()
    if (self.db.profile.pickupByClick and not self:IsHooked("ContainerFrameItemButton_OnModifiedClick")) then
        self:RawHook("ContainerFrameItemButton_OnModifiedClick", true)
    end
    if (not self.db.profile.pickupByClick and self:IsHooked("ContainerFrameItemButton_OnModifiedClick")) then
        self:Unhook("ContainerFrameItemButton_OnModifiedClick")
    end
    if (self.item) then
        _UpdatePrices(self)
    end
    _UpdateFonts(self)
    if (self.item) then
        self:RefreshPrices()
    end
end

function vendor.Seller:AUCTION_ACTION(msg, action, itemLink, success)
    log:Debug("AUCTION_ACTION action [%s] itemLink [%s] success [%s]", action, itemLink, success)
    local info = self.sellItemInfo
    local scanSet = self.itemModel:GetScanSet()
    log:Debug("scanSet [%s] info [%s]", scanSet, info)
    if (scanSet and info and success and action == vendor.AuctionHouse.ACTION_SELL) then
        log:Debug("1")
        local key1 = vendor.Items:GetItemLinkKey(itemLink)
        local key2 = vendor.Items:GetItemLinkKey(info.itemLink)
        if (key1 == key2) then
            log:Debug("stackCount [%s] stackSize [%s]", info.stackCount, info.stackSize)
            scanSet:Add(key2, info.timeLeft, info.stackSize, info.minBid, 0, info.buyout, 0, self.playerName, nil)
            self.itemModel:SetScanSet(scanSet)
            self.itemTable:Show()
            info.stackCount = info.stackCount - 1
            if (info.stackCount > 0) then
                vendor.AuctionHouse:AddAction(vendor.AuctionHouse.ACTION_SELL, itemLink)
            else
                self.sellItemInfo = nil
            end
        end
    elseif (scanSet and #self.cancelAuctions > 0 and success and action == vendor.AuctionHouse.ACTION_CANCEL) then
        local itemLinkKey = vendor.Items:GetItemLinkKey(itemLink)
        local n = #self.cancelAuctions
        for i = 1, n do
            local cancelInfo = self.cancelAuctions[i]
            if (itemLinkKey == cancelInfo.itemLinkKey) then
                -- is the sorting enough to recognize item?
                scanSet:Remove(itemLinkKey, cancelInfo.minBid or 0, cancelInfo.buyout or 0, 0, self.playerName)
                self.itemModel:SetScanSet(scanSet)
                self.itemTable:Show()
                break
            end
        end
    end
end