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
	Sceleton for performing auction scans. The processing is done in ScanModules.
--]]
vendor.ScanTask = {}
vendor.ScanTask.prototype = {}
vendor.ScanTask.metatable = { __index = vendor.ScanTask.prototype }

local log = vendor.Debug:new("ScanTask")

local L = vendor.Locale.GetInstance()

local SCAN_PAGE_NONE = 0 -- not interested in scanning pages
local SCAN_PAGE_WAIT = 1 -- waiting to scan next page
local SCAN_PAGE_PERFORM = 2 -- got permission to scan

local AUCTION_LIST_UPDATE_TIMEOUT = 20
local CAN_SEND_QUERY_TIMEOUT = 12

StaticPopupDialogs["AM_CAN_SEND_BUG"] = {
    text = L["AuctionHouse not ready, even after waiting for %s seconds. This is a Blizzard bug. You may fix it by closing and reopening the auction house."]:format(CAN_SEND_QUERY_TIMEOUT),
    button1 = L["Close AH"],
    button2 = L["Ok"],
    OnAccept = function()
        CloseAuctionHouse()
    end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3, -- avoid some UI taint, see http://www.wowace.com/announcements/how-to-avoid-some-ui-taint/
}

local function _normalizeName(self)
    local name = self.queryInfo.name
    if (name and strlen(name) > 63) then
        -- too long names may cause a disconnect

        -- taken from http://wowprogramming.com/snippets/UTF-8_aware_stringsub_7
        -- UTF-8 Reference:
        -- 0xxxxxxx - 1 byte UTF-8 codepoint (ASCII character)
        -- c0: 110yyyxx - First byte of a 2 byte UTF-8 codepoint
        -- e0: 1110yyyy - First byte of a 3 byte UTF-8 codepoint
        -- f0: 11110zzz - First byte of a 4 byte UTF-8 codepoint
        -- 10xxxxxx - Inner byte of a multi-byte UTF-8 codepoint

        if (strbyte(name, 63) >= 0xc0) then -- first of a 2byte
        name = strsub(name, 1, 62)
        elseif (strbyte(name, 62) >= 0xe0) then -- first of a 3byte
        name = strsub(name, 1, 61)
        elseif (strbyte(name, 61) >= 0xf0) then -- first of a 4byte
        name = strsub(name, 1, 60)
        else
            name = strsub(name, 1, 63)
        end
        self.queryInfo.name = name
    end
end

local function _StopScan(self, complete)
    log:Debug("_StopScan cancelled [%s] complete [%s]", self.cancelled, complete)
    if (not self.stopped) then
        vendor.Seller:SetProgress("", 0)
        if (not self.silent) then
            --			vendor.Scanner.scanFrame:ScanFinished()
            if (self.observer) then
                self.observer:ScanFinished()
            end
        end
        if (self.getAll) then
            vendor.Vendor:Print(L["Scan finished after %s"]:format(SecondsToTime(GetTime() - self.startedAt)))
        end
        for i = 1, #self.modules do
            self.modules[i]:StopScan(complete)
        end

        vendor.Scanner:AbandonScan(complete)

        if (self.scanSetCallback) then
            local neutralAh = vendor.AuctionHouse:IsNeutral()
            local scanSet = vendor.ScanSet:new(self.scanSetIndex, neutralAh, self.itemLinkKey)
            self.scanSetCallback(scanSet, self.scanSetCallbackArg)
        end

        self.stopped = true
    end
end

--[[
	Waits until the owner is available or the the timeout time is reached.
--]]
local function _WaitForOwners(self, timeoutTime)
    local doCheck, now, lastCheck, owner
    -- init the missing owner index
    local index = wipe(self.ownerIndex)
    local numBatchAuctions = GetNumAuctionItems("list")
    for i = 1, numBatchAuctions do
        owner = select(14, GetAuctionItemInfo("list", i))
        if (not owner) then
            tinsert(index, i)
        end
    end
    -- wait for missing owners
    while (#index > 0 and self.running) do
        now = GetTime()
        if (not lastCheck or (now - lastCheck) >= 0.2) then
            lastCheck = now
            for i = #index, 1, -1 do
                owner = select(14, GetAuctionItemInfo("list", index[i]))
                if (owner) then
                    tremove(index, i)
                end
            end
        end
        if (now >= timeoutTime) then
            break
        end
        if (#index > 0) then
            coroutine.yield(0.2)
        end
    end
    if (#index > 0) then
        log:Debug("[%s] owners not found", #index)
    end
    return #index == 0
end

local function _WaitForItemLink(self, index, timeoutTime)
    local itemLink = GetAuctionItemLink("list", index)
    while (not itemLink and self.running) do
        if (GetTime() >= timeoutTime) then
            break
        end
        coroutine.yield(0.2)
        itemLink = GetAuctionItemLink("list", index)
    end
    if (not itemLink) then
        log:Debug("ItemLink not found")
    end
    return itemLink
end

local function _UpdateStatus(self)
    if (not self.silent) then
        local now = GetTime()
        local passed = now - self.startedAt
        local t = (self.total * passed) / self.currentIndex
        local remaining = t - passed
        local restTime = SecondsToTime(math.max(1, remaining))
        local msg = L["Scan auction %s/%s - time left: %s"]:format(self.currentIndex, self.total, restTime)

        --   		log:Debug("_UpdateStatus silent [%s] started [%s] page [%s] maxPages [%s] currentIndex [%s] total [%s] percent [%s] msg [%s] remaining [%s] t[%s]",
        --		self.silent, self.startedAt, self.page, self.maxPages, self.currentIndex, self.total, self.currentIndex / self.total, msg, remaining, t)

        --    	vendor.Scanner.scanFrame:SetProgress(msg, self.currentIndex / self.total)
        if (self.observer) then
            self.observer:SetProgress(msg, self.currentIndex / self.total)
        end
        vendor.Seller:SetProgress(msg, self.currentIndex / self.total)
    end
end

--[[ 
	Reads in the list of auction items.
--]]
local function _ReadPage(self)
    log:Debug("_ReadPage")
    local info = self.queryInfo
    for i = 1, #self.modules do
        self.modules[i]:StartPage(self.page)
    end
    local numBatchAuctions, total = GetNumAuctionItems("list")
    log:Debug("numBatchAuction [%s] total [%s]", numBatchAuctions, total)
    self.total = total
    self.maxPages = math.ceil(total / NUM_AUCTION_ITEMS_PER_PAGE)

    local scanSetCallback = self.scanSetCallback
    local scanSetIndex = self.scanSetIndex
    local time = GetTime()

    self.currentIndex = 0
    log:Debug("Enter loop with numBatchAuctions [%s] total [%s]", numBatchAuctions, total)
    local ownerWaited
    for index = numBatchAuctions, 1, -1 do
        if (not self.running) then
            log:Debug("Exit loop")
            break
        end
        local itemLink = _WaitForItemLink(self, index, GetTime() + 10)
        if (itemLink) then
            local timeLeft = GetAuctionItemTimeLeft("list", index)
            local itemLinkKey = vendor.Items:GetItemLinkKey(itemLink)
            if (not (self.itemLinkKey and not vendor.Items:MatchItemLinkKeys(self.itemLinkKey, itemLinkKey))) then
                local name, texture, count, quality, canUse, level, unknown,
                minBid, minIncrement, buyoutPrice, bidAmount,
                highBidder, bidderFullName, owner, ownerFullName, saleStatus = GetAuctionItemInfo("list", index)
                if (not (info.exactName and self.lowerName ~= strlower(name))) then
                    if (not owner and self.waitForOwners and not ownerWaited) then
                        log:Debug("waitForOnwers")
                        _WaitForOwners(self, GetTime() + 7)
                        ownerWaited = true
                        owner = select(14, GetAuctionItemInfo("list", index))
                    end
                    for i = 1, #self.modules do
                        self.modules[i]:NotifyAuction(itemLinkKey, itemLink, index, name, texture, count,
                            quality, canUse, level, minBid, minIncrement, buyoutPrice, bidAmount, highBidder,
                            owner, saleStatus, timeLeft)
                    end

                    if (scanSetCallback) then
                        local data = vendor.ScanResults.Pack(itemLinkKey, time, timeLeft, count or 1, minBid or 0, minIncrement or 0, buyoutPrice or 0, bidAmount or 0, owner or "", highBidder or "", 0)
                        table.insert(scanSetIndex, data)
                    end
                end
            end
        end
        self.currentIndex = self.currentIndex + 1
    end
    log:Debug("Loop has finished")
    for i = 1, #self.modules do
        self.modules[i]:StopPage()
    end
    self.currentIndex = self.page * NUM_AUCTION_ITEMS_PER_PAGE + 1
    _UpdateStatus(self)
    -- return true, if we should continue reading the next page
    return numBatchAuctions >= NUM_AUCTION_ITEMS_PER_PAGE
end

local function _ReadGetAll(self)
    log:Debug("_ReadGetAll")
    local numBatchAuctions, total
    while (self.running) do
        numBatchAuctions, total = GetNumAuctionItems("list")
        log:Debug("numBatchAuctions [%s] total [%s]", numBatchAuctions, total)
        if (not numBatchAuctions or numBatchAuctions <= 0) then
            -- TODO some termination cond ?
            coroutine.yield(0.5)
        else
            break
        end
    end

    if (not total) then
        return
    end

    self.total = total
    self.maxPages = 1
    if (total > numBatchAuctions) then
        vendor.Vendor:Print(L["There are too many auction items for a \"getAll\" scan. The scan will be uncomplete."])
        self.total = numBatchAuctions
        self.getAllDamaged = true
    end

    local info = self.queryInfo
    for i = 1, #self.modules do
        self.modules[i]:StartPage(self.page)
    end

    local batch = 0
    self.currentIndex = 0
    log:Debug("Enter loop with [%s] auctions to read", numBatchAuctions)
    for index = numBatchAuctions, 1, -1 do
        if (not self.running) then
            log:Debug("Exit loop")
            break
        end
        local itemLink = _WaitForItemLink(self, index, GetTime() + 10)
        if (itemLink) then
            local timeLeft = GetAuctionItemTimeLeft("list", index)
            local itemLinkKey = vendor.Items:GetItemLinkKey(itemLink)
            if (not (self.itemLinkKey and not vendor.Items:MatchItemLinkKeys(self.itemLinkKey, itemLinkKey))) then
                local name, texture, count, quality, canUse, level, unknown,
                minBid, minIncrement, buyoutPrice, bidAmount,
                highBidder, bidderFullName, owner, ownerFullName, saleStatus = GetAuctionItemInfo("list", index)
                if (not (info.exactName and self.lowerName ~= strlower(name))) then
                    for i = 1, #self.modules do
                        self.modules[i]:NotifyAuction(itemLinkKey, itemLink, index, name, texture, count,
                            quality, canUse, level, minBid, minIncrement, buyoutPrice, bidAmount, highBidder,
                            owner, saleStatus, timeLeft)
                    end
                end
            end
        end
        self.currentIndex = self.currentIndex + 1
        batch = batch + 1
        if (batch >= 200) then
            log:Debug("finished batch, yield")
            _UpdateStatus(self)
            batch = 0
            coroutine.yield(self.delay)
        end
    end
    log:Debug("Loop has finished")

    for i = 1, #self.modules do
        self.modules[i]:StopPage()
    end
    self.currentIndex = math.max(1, total)
    _UpdateStatus(self)
end

local function _BlockForAuctionListUpdate(self)
    log:Debug("_BlockForAuctionListUpdate pendingAuctionListUpdate [%s]", self.pendingAuctionListUpdate)
    self.blockAuctionListUpdateTimeout = GetTime() + AUCTION_LIST_UPDATE_TIMEOUT
    while (self.pendingAuctionListUpdate and self.running) do
        if (GetTime() > self.blockAuctionListUpdateTimeout) then
            vendor.Vendor:Print(L["Didn't receive auction results, even after waiting for %s seconds"]:format(AUCTION_LIST_UPDATE_TIMEOUT))
            break;
        end
        coroutine.yield(0.2)
    end
    self.pendingAuctionListUpdate = nil
    self.blockAuctionListUpdateTimeout = nil
    log:Debug("_BlockForAuctionListUpdate exit pendingAuctionListUpdate [%s]", self.pendingAuctionListUpdate)
end

local function _BlockForCanSendAuctionQuery(self)
    log:Debug("_BlockForCanSendAuctionQuery enter")
    self.blockCanSendQueryTimeout = GetTime() + CAN_SEND_QUERY_TIMEOUT
    while (self.running) do
        local canQuery, canQueryAll = CanSendAuctionQuery()
        log:Debug("canQuery [%s] canQueryAll [%s]", canQuery, canQueryAll)
        if (canQuery) then
            break
        end
        if (GetTime() > self.blockCanSendQueryTimeout) then
            StaticPopup_Show("AM_CAN_SEND_BUG")
            break
        end
        coroutine.yield(0.2)
    end
    self.blockCanSendQueryTimeout = nil
    log:Debug("_BlockForCanSendAuctionQuery exit")
end

local function _GetAllScan(self)
    log:Debug("_GetAllScan")
    self.getAll = true
    self.pendingAuctionListUpdate = true
    --QueryAuctionItems("", 0, 0, 0, 0, 0, true);
	QueryAuctionItems("", 0, 0, 0, 0, 0, true);

    vendor.Scanner.db.profile.lastGetAll = GetTime()
    _BlockForAuctionListUpdate(self)
    _ReadGetAll(self)
end

local function _PagedScan(self, info)
    log:Debug("_PagedScan enter")
    self.batchScan = true
    self.page = 0
    local info = self.queryInfo

    -- loop all pages
    while (self.running) do

        _BlockForCanSendAuctionQuery(self)

        if (self.running) then

            self.pendingAuctionListUpdate = true
            log:Debug("QueryAuctions name [%s] exactMatch [%s]", name, info.exactMatch)

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

            QueryAuctionItems(info.name, tonumber(info.minLevel), tonumber(info.maxLevel), self.page, info.isUsable, info.qualityIndex, false, info.exactMatch, filterData);

            _BlockForAuctionListUpdate(self)
            _BlockForCanSendAuctionQuery(self)

            if (self.running) then
                if (not _ReadPage(self)) then
                    log:Debug("Exit loop")
                    -- all auctions has been read
                    break
                end

                -- prepare next page
                self.page = self.page + 1
                if (self.page > self.maxPages) then
                    break
                end
            end
        end
    end
    log:Debug("_PagedScan exit")
end

--[[ 
	Creates a new instance with the given name (scanId) and a query description containing the fields:
	itemLinkKey, name, minLevel, maxLevel, invTypeIndex, classIndex, subclassIndex, isUsable, qualityIndex
	At the end several ScanModules may be added. 
--]]
function vendor.ScanTask:new(scanId, queryInfo, ...)
    local instance = setmetatable({}, self.metatable)
    instance.queryInfo = queryInfo
    instance.itemLinkKey = queryInfo.itemLinkKey
    instance.running = true
    instance.scanId = scanId
    instance.ownerIndex = {}
    instance.modules = {}
    instance.observer = queryInfo.observer
    instance.scanSetCallback = queryInfo.scanSetCallback
    instance.scanSetCallbackArg = queryInfo.scanSetCallbackArg
    instance.scanSetIndex = {}
    instance.delay = vendor.Scanner.DELAYS[vendor.Scanner.db.profile.scanSpeed or vendor.Scanner.SCAN_SPEED_FAST]
    queryInfo.exactMatch = queryInfo.exactMatch or false
    if (queryInfo.name) then
        instance.lowerName = strlower(queryInfo.name)
    end
    for i = 1, select('#', ...) do
        local module = select(i, ...)
        table.insert(instance.modules, module)
    end
    _normalizeName(instance)
    return instance
end

--[[
	Run function of the task, performs the scan.
--]]
function vendor.ScanTask.prototype:Run()
    log:Debug("Run enter")
    self.getCalls = 0
    self.startedAt = GetTime()
    for i = 1, #self.modules do
        self.modules[i]:StartScan(self.queryInfo, "list")
    end

    if (self.running) then
        local _, getAll = CanSendAuctionQuery()
        local scanSpeedOff = vendor.Scanner.SCAN_SPEED_OFF == vendor.Scanner.db.profile.scanSpeed

        if (getAll and self.queryInfo.getAll and not scanSpeedOff) then
            _GetAllScan(self)
        else
            _PagedScan(self)
        end
    end

    log:Debug("exit name [%s] failed [%s] canceled [%s]", self.queryInfo.name, self.failed, self.cancelled)
    -- TODO currently we handle "damaged" getAll scans as complete, it's not correct
    -- but better than nothing, if it happens all the time
    _StopScan(self, not self.cancelled)
    --_StopScan(self, not self.cancelled and not self.getAllDamaged)
    log:Debug("Run exit")
end

--[[
	Cancels the task and leaves it as soon as possible. 
--]]
function vendor.ScanTask.prototype:Cancel()
    log:Debug("Cancel")
    self.cancelled = true
    self.running = nil
end

--[[
	Returns whether the task was canecelled.
--]]
function vendor.ScanTask.prototype:IsCancelled()
    return self.cancelled
end

--[[ 
	Reads in the list of auction items, will be called by the Scanner.
--]]
function vendor.ScanTask.prototype:AuctionListUpdate()
    log:Debug("AuctionListUpdate")
    self.pendingAuctionListUpdate = nil
end

--[[
	Will be called by the TaskQueue, if the task has failed with an 
	unexpected error.
--]]
function vendor.ScanTask.prototype:Failed()
    log:Debug("Failed")
    self.failed = true
    self:Cancel()
    _StopScan(self)
end

--[[
	Returns the unique scanId.
--]]
function vendor.ScanTask.prototype:GetScanId()
    return self.scanId
end

--[[
	Returns the result as a map with: scanId
--]]
function vendor.ScanTask.prototype:GetResult()
    return { scanId = self.scanId, cancelled = self.cancelled }
end