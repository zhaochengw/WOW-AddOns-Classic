--[[
  MoLib (Auction House part) -- (c) 2019 moorea@ymail.com (MooreaTv)
  Covered by the GNU Lesser General Public License v3.0 (LGPLv3)
  NO WARRANTY
  (contact the author if you need a different license)

  "doc" for GetAuctionItemInfo
  name, texture, count, quality, canUse, level, levelColHeader, minBid, minIncrement, buyoutPrice,
  bidAmount, highBidder, bidderFullName, owner, ownerFullName, saleStatus, itemId, hasAllInfo =  GetAuctionItemInfo("list", i)

]] --
-- our name, our empty default (and unused) anonymous ns
local addonName, _ns = ...

local ML = _G[addonName]

-- In bfa at least, only 2 types of AH items seen so far:
-- ["link"] = "|cff1eff00|Hitem:24767::::::::29:70:512:36:2:1679:3850:112:::|h[Clefthoof Hidemantle of the Quickblade]|h|r",
-- ["link"] = "|cff0070dd|Hbattlepet:1061:1:3:152:10:13:0000000000000000|h[Darkmoon Hatchling]|h|r",
-- |cffa335ee|Hitem:169929::::::::20:70::6:4:4800:1517:5855:4783:::|h[Cuffs of Soothing Currents]|h|r
-- item:itemID:enchID:gemdid1:g2:g3:g4:suffixID:uniqueID:linkLevel:specializationID:upgradeTypeID:instanceDifID:numBonusIDs
-- item:169929:      :       :  :  :  :        :        :       20:              70:             :   6        :4:4800:1517:5855:4783
-- lets shorten those:
function ML:ItemLinkToId(link)
  if type(link) ~= "string" then
    self:DebugStack("Bad ItemLinkToId(%) call", link)
    return
  end
  local idStr = link:match("^|[^|]+|H([^|]+)|")
  if not idStr then
    self:Error("Unexpected item link format %", link)
    return
  end
  local short = idStr
  short = string.gsub(short, "^(.)[^:]+:", "%1")
  -- get rid of :uid:linklevel:specid:upgradetype:instancedif section
  short = string.gsub(short,
                      "^(i[-%d]+:[-%d]*:[-%d]*:[-%d]*:[-%d]*:[-%d]*:[-%d]*):[-%d]*:[-%d]*:[-%d]*:[-%d]*:[-%d]*(.*)$",
                      "%1%2")
  -- remove trailing ::::: and 00000 (battlepet)
  short = string.gsub(short, ":[:0]*$", "")
  -- run length encode :s  1":" is :, 2 is ; (:+1 in ascii), 3 is < etc
  short = string.gsub(short, "::+", function(match)
    return string.format("%c", 57 + #match)
  end)
  self:Debug(5, "ItemLinkToId % -> %", idStr, short)
  return short
end

-- is it just the link or info+link (v'5'ish)
function ML:HasItemInfo(link)
  -- link starts with |
  return link:sub(1, 1) ~= "|"
end

function ML:AddItemInfo(link)
  local _, _, itemRarity, _, itemMinLevel, _, _, itemStackCount, _, _,
    itemSellPrice, itemClassID, itemSubClassID = GetItemInfo(link)
  if not itemRarity then
    -- not yet avail
    return link, 0
  end
  return string.format("%d,%d,%d,%d,%d,%d%s",itemSellPrice, itemStackCount, itemClassID,
    itemSubClassID, itemRarity, itemMinLevel, link), 1
end

-- when called form batch conversion, price is nil/not specified
function ML:AddToItemDB(link, price)
  local key = self:ItemLinkToId(link)
  local idb = self.savedVar[self.itemDBKey]
  local existing = idb[key]
  local added
  if existing then
    if not self:HasItemInfo(existing) then
      idb[key], added = self:AddItemInfo(link)
      idb._infoCount_ = idb._infoCount_ + added
      self:Debug("item key %: % had no info, added %", idb._count_, key, link, added)
    end
    -- instance difficulty id changes (without non cosmetic impact) and so does the linklevel/specid
    -- depending on which character scans... so only for dev/debug mode
    if ((price == nil) or (self.debug and self.debug > 3)) and link ~= existing then
      self:Warning(
        "key % for link % value mismatch with previous % (could be just the specid, difficultyId or a real issue)", key,
        link, existing)
      idb[key] = link
    end
    return key -- already in there
  end
  idb._count_ = idb._count_ + 1 -- lua doesn't expose the number of entries (!)
  idb[key], added = self:AddItemInfo(link)
  idb._infoCount_ = idb._infoCount_ + added
  self:Debug("New item #% key %: %  info %", idb._count_, key, link, added)
  if price and self.showNewItems then
    local newIdx = idb._count_ - self.itemDBStartingCount
    if newIdx <= self.showNewItems then
      local extra = ""
      if newIdx == self.showNewItems then
        extra = self.L[" (maximum reached, won't show more for this scan)"]
      end
      self:PrintDefault(
        self.name .. " " .. self.L["New item #% (%): "] .. idb[key] .. " " .. GetCoinTextureString(price) .. extra, newIdx,
        idb._count_)
      self:Yield(0) -- if we print stuff we (seem to) need to yield
    end
  end
  return key
end

ML.ahAuctionInfoCache = {resCache = {}, ahKeyedResult = {}}

function ML:AHGetAuctionInfoByLink(itemLink)
  local ikey = self:ItemLinkToId(itemLink)
  if not ikey then
    return {error = "INVALID_ITEM_LINK"}
  end
  local idb = self.savedVar[self.itemDBKey]
  self:Debug(8, "AHGetAuctionInfoByLink for " .. itemLink .. " (%) itemDBkey %", ikey, self.itemDBKey)
  if not idb or not idb[ikey] then
    return {error = "UNKNOWN_ITEM"}
  end
  local resCache = self.ahAuctionInfoCache.resCache
  if resCache[ikey] then
    return resCache[ikey]
  end
  local ahKeyedResult = self.ahAuctionInfoCache.ahKeyedResult
  local ts = self.ahAuctionInfoCache.ts
  local res = {found = true, ts = ts}
  if ahKeyedResult[ikey] then
    res.rawData = ahKeyedResult[ikey]
    res.quantity = 0
    res.minBid = nil
    res.minBuyout = nil
    res.numAuctions = 0
    res.numSellers = 0
    for seller, auctionsBySeller in pairs(res.rawData) do
      res.numSellers = res.numSellers + 1
      if #seller == 0 then
        res.hasUnknownSellers = true
      end
      for _, auction in ipairs(auctionsBySeller) do
        local _timeLeft, itemCount, minBid, buyoutPrice, bidAmount = self:extractAuctionData(auction)
        res.quantity = res.quantity + itemCount
        res.numAuctions = res.numAuctions + 1
        local bid = bidAmount or minBid
        if bid then
          local rBidPerItem = self:round(bid / itemCount, .1)
          if not res.minBid then
            res.minBid = rBidPerItem
          else
            res.minBid = math.min(res.minBid, rBidPerItem)
          end
        end
        if buyoutPrice then
          local rBuyPerItem = self:round(buyoutPrice / itemCount, .1)
          if not res.minBuyout then
            res.minBuyout = rBuyPerItem
          else
            res.minBuyout = math.min(res.minBuyout, rBuyPerItem)
          end
        end
      end
    end
  else
    res.found = false
  end
  resCache[ikey] = res
  self:Debug(1, "AHGetAuctionInfoByLink for " .. itemLink .. " (%) is %", ikey, res)
  return res
end

function ML:AHContext()
  self:InitRealms()
  local context = {}
  context.classic = self.isClassic
  context.char, context.shortChar, context.realm, context.region = self:GetMyInfo()
  context.faction = UnitFactionGroup("target") or "Neutral" -- Not needed in BfA
  self:PrintInfo(self.L["Scan context info: "] .. context.faction .. self.L[" auction house on "] .. context.region ..
                   " / " .. context.realm)
  return context
end

ML.ahResult = {}
ML.ahKeyedResult = {}

function ML:AHfullScanPossible()
  local normalQueryOk, dumpOk = CanSendAuctionQuery()
  return dumpOk and normalQueryOk
end

function ML:InitItemDB(clearAHtoo)
  self.savedVar[self.itemDBKey] = {}
  local itemDB = self.savedVar[self.itemDBKey]
  itemDB._formatVersion_ = 5 -- shorterKey4 = fullLink associative array + iteminfo prefixed
  itemDB._locale_ = GetLocale()
  itemDB._count_ = 0
  itemDB._infoCount_ = 0
  itemDB._created_ = GetServerTime()
  -- also clear the ah array itself
  if clearAHtoo and self.savedVar.ah then
    self.savedVar.ah = wipe(self.savedVar.ah)
  end
  return itemDB
end

function ML:CheckAndConvertItemDB()
  local itemDB = self.savedVar[self.itemDBKey]
  if not itemDB._formatVersion_ then
    self:Error("Erasing unknown/past Item DB format %", itemDB._formatVersion_)
    return self:InitItemDB(true)
  end
  if itemDB._formatVersion_ == 5 then
    local locale = GetLocale()
    if itemDB._locale_ ~= locale then
      self:Error(
        "Item DB Locale mismatch! % vs %. item names will be wrong/there will be errors... consider resetting the addon...",
        itemDB._locale_, locale)
      itemDB._locale_ = locale
    end
    -- good current version
    return itemDB
  end
  if itemDB._formatVersion_ == 4 then
    local locale = GetLocale()
    if not itemDB._infoCount_  then
      itemDB._infoCount_ = 0
    end
    if not itemDB._locale_ then
      itemDB._locale_ = locale -- can be removed at version5
    elseif itemDB._locale_ ~= locale then
      self:Error(
        "Item DB Locale mismatch! % vs %. item names will be wrong/there will be errors... consider resetting the addon...",
        itemDB._locale_, locale)
      itemDB._locale_ = locale
    end
    -- good current version
    self:Warning("Upgraded item db v% to v5 - % items", itemDB._formatVersion_, itemDB._count_)
    itemDB._formatVersion_ = 5
    return itemDB
  end
  -- version 1: convert to v2
  self:Warning("Converting item db v% to current - % items", itemDB._formatVersion_, itemDB._count_)
  local newDB = self:InitItemDB()
  local oldKeySizes = 0
  local newKeySizes = 0
  local valueSizes = 0
  for k, v in pairs(itemDB) do
    if k:sub(1, 1) ~= "_" then
      oldKeySizes = oldKeySizes + #k
      valueSizes = valueSizes + #v
      local newKey = self:AddToItemDB(v)
      newKeySizes = newKeySizes + #newKey
    end
  end
  local percent = self:round(100 * (oldKeySizes / newKeySizes - 1), .1)
  self:Warning("Done converting now v% itemDB - % items\n" ..
                 "Size reduction % original to old key sizes %, to now % (% percent improvement)",
               newDB._formatVersion_, newDB._count_, valueSizes, oldKeySizes, newKeySizes, percent)
  return newDB
end

function ML:AHSetupEnv()
  self.itemDBKey = "itemDB_" .. _G.WOW_PROJECT_ID -- split classic and bfa, even though they should never end up in same saved vars
  local itemDB = self.savedVar[self.itemDBKey]
  if not itemDB then
    -- create/init itemDB for each wow type (currently BfA vs Classic)
    return self:InitItemDB()
  end
  return self:CheckAndConvertItemDB()
end

function ML:AHOpenCB()
  self:Debug("Default AH open cb")
end
function ML:AHCloseCB()
  self:Debug("Default AH close cb")
end

ML.EventHdlrs.AUCTION_HOUSE_SHOW = function(frame)
  local addonP = frame.addonPtr
  if addonP.ahShown then
    return -- remove duplicate events
  end
  addonP.ahShown = true
  addonP:AHOpenCB()
end

ML.EventHdlrs.AUCTION_HOUSE_CLOSED = function(frame)
  local addonP = frame.addonPtr
  if addonP.ahShown then -- drop dup events
    addonP.ahShown = nil
    addonP:AHCloseCB()
  end
end

-- Main entry point for this file/feature: does a full AH query and scan/parse the results into
-- the addon saved variable.
-- Debug/test mode:
function ML:AHSaveAll(dontActuallyQuery)
  if not self:AHfullScanPossible() and not dontActuallyQuery then
    self:Warning(self.L["Can't query ALL at AH, try again later..."])
    return
  end
  if self.waitingForAH then
    self:Warning("Already doing a scan (%), try a new one later...", self.ahResumeAt)
    self:coroutineRunDump() -- in case previous one got error/got stuck
    return
  end
  if not self.ahShown then
    self:Warning(self.L["Not at the AH, can't scan..."])
    return
  end
  local itemDB = self:AHSetupEnv()
  self:Debug("Starting itemDB has % items, % with info (was %)", itemDB._count_, itemDB._infoCount_, self.itemDBStartingCount)
  self.itemDBStartingCount = itemDB._count_
  self.ahStartTS = debugprofilestop()
  self.ahResult = wipe(self.ahResult)
  if dontActuallyQuery then
    self:Warning("Running with existing last AH results instead of a real scan")
    self.ahIsStale = true
    -- we won't get the first event so schedule the dump for just after this, simulating the event:
    C_Timer.After(0, function()
      self:coroutineRunDump(true)
    end)
  else
    self.ahIsStale = false
    QueryAuctionItems("", nil, nil, 0, 0, 0, true)
  end
  self.waitingForAH = true
  self.ahResumeAt = nil
  if AuctionFrameBrowse then
    AuctionFrameBrowse:UnregisterEvent("AUCTION_ITEM_LIST_UPDATE")
    AuctionFrameBrowse.isSearching = 1
  end
  -- AHdump called through the first event
  self:PrintInfo(self.L["AH Scan started... please wait..."])
end

ML.ahCoroutineCounter = 0
function ML:coroutineRunDump(fromEvent)
  self.ahCoroutineCounter = self.ahCoroutineCounter + 1
  local id = self.ahCoroutineCounter
  if self.ahCoroutine then
    self:Warning("Bug? coroutine already existing...")
  end
  self.ahCoroutine = coroutine.create(function()
    self:Debug(3, "coroutine % started for dump %", id, fromEvent)
    self:AHdump(fromEvent)
    self:Debug(3, "coroutine % about to end for dump %", id, fromEvent)
    self.ahCoroutine = nil
  end)
  self:Debug(3, "coroutine % created for dump %", id, fromEvent)
  coroutine.resume(self.ahCoroutine)
end

ML.EventHdlrs.AUCTION_ITEM_LIST_UPDATE = function(frame, _event, _name)
  local addonP = frame.addonPtr
  addonP:Debug(5, "AUCTION_ITEM_LIST_UPDATE Event received - in ah wait %", addonP.waitingForAH)
  if addonP.waitingForAH then
    addonP:Debug(3, "Event received, waiting for items for AH, at % got % - already in is %", addonP.ahResumeAt,
                 #addonP.ahResult, addonP.AHinDump)
    if not addonP.AHinDump then
      addonP:coroutineRunDump(true)
    else
      addonP:Debug(3, "Skipping item list even because we already are inside AHdump... %", addonP.ahResumeAt)
    end
  end
end

ML.ahUpdateBrowse = not ML.isClassic

function ML:AHrestoreNormal()
  self.waitingForAH = nil
  self.ahRetries = 0
  self.ahResumeAt = nil
  self.ahRestarts = 0
  if self.ahTimer then
    self:Debug(3, "cancelling previous timer, from restore normal")
    self.ahTimer:Cancel()
    self.ahTimer = nil
  end
  if AuctionFrameBrowse then
    if self.ahUpdateBrowse then
      AuctionFrameBrowse:RegisterEvent("AUCTION_ITEM_LIST_UPDATE")
    else
      -- TODO: how to hide the older  results?? it's not BrowseScrollFrame:Hide()
      -- AuctionFrameBrowse_Search
      if not _G.BrowseSearchButton then
        self:Error("Unexpected to not find BrowseSearchButton !")
        return
      end
      local restore = function()
        self:Debug("Restoring auction frame as search button is pressed")
        AuctionFrameBrowse:RegisterEvent("AUCTION_ITEM_LIST_UPDATE")
      end
      _G.BrowseSearchButton:HookScript("OnClick", restore)
      _G.BrowseName:HookScript("OnEnterPressed", restore)
      _G.BrowseNoResultsText:SetText(_G.BROWSE_SEARCH_TEXT)
      _G.BrowseNoResultsText:Show()
    end
    AuctionFrameBrowse.isSearching = nil
  end
end

-- (default) page size is NUM_AUCTION_ITEMS_PER_PAGE (50) which
-- we don't to prefetch as that's way too slow, there is a number after
-- which we loose data because asking for later data erases earlier unfetched data
-- we should consider halving the batch size at each retry or similar
ML.ahPrefetch = 2500
ML.ahMaxRetries = 10 -- how many retries without making progress (ie 1sec)
ML.ahBaseTimerInterval = 0.1
ML.ahMaxRestarts = 10 -- how many times to restart the scan when stepping on an expired auction
ML.ahWaitForSellers = false -- used to work but they broke it in bcc and back ported the breakage to som...
ML.ahSkipOverErrors = false

function ML:AHscheduleNextDump(msg)
  if self.ahTimer then
    self:Debug(4, "cancelling previous timer, from " .. msg)
    self.ahTimer:Cancel()
  end
  self:Debug(5, "scheduling retry in %s", self.ahRetryTimerInterval)
  self.ahTimer = C_Timer.NewTimer(self.ahCurrentTimerInterval, function()
    self.ahTimer = nil
    self:coroutineRunDump()
  end)
end

ML.yieldFrequency = 2500
ML.operationsCount = 1 -- start at 1 so scan doesn't start with yield yet serialize does
ML.yieldDelay = 0 -- ie "next frame" seems to work and keep a good rate without DC/hanging

function ML:Yield(forHowLong)
  local co = coroutine.running()
  C_Timer.After(forHowLong or self.yieldDelay, function()
    coroutine.resume(co)
  end)
  coroutine.yield()
end

function ML:ShouldYield()
  local shouldYield = (self.yieldFrequency > 0) and (self.operationsCount % self.yieldFrequency == 0)
  self.operationsCount = self.operationsCount + 1 -- change it before we yield in case we reenter
  if shouldYield then
    self:Debug(3, "yielding after % operations", self.operationsCount)
    self:Yield()
    self:Debug(3, "resuming after yield")
  end
end

function ML:ahSerializeScanResult()
  local temp = {}
  local itemsForSale = 0
  self.operationsCount = 0 -- reset so we start with a yield
  for k, v in pairs(self.ahKeyedResult) do
    itemsForSale = itemsForSale + 1
    local tt = {k}
    if type(v) ~= "table" then
      self:ErrorAndThrow("bug: for key % v is %", k, v)
    end
    for s, a in pairs(v) do
      self:ShouldYield()
      table.insert(tt, s .. "/" .. table.concat(a, "&"))
    end
    table.insert(temp, table.concat(tt, "!"))
  end
  return itemsForSale, table.concat(temp, " ") -- \n gets escaped into '\' + 'n' so might as well use 1 byte instead
end

function ML:ahDeserializeScanResult(data)
  local kr = {}
  self:Debug("Deserializing data %", #data)
  local numItems = 0
  for itemEntry in string.gmatch(data, "[^ ]+") do
    numItems = numItems + 1
    local item, rest = itemEntry:match("^([^!]+)!(.*)$")
    kr[item] = {}
    local entry = kr[item]
    self:Debug(8, "for % rest is '%'", item, rest)
    for sellerAuctions in string.gmatch(rest, "([^!]+)") do
      local seller, auctions = sellerAuctions:match("^([^/]*)/(.*)$")
      self:Debug(8, "seller % auctions are '%'", seller, auctions)
      entry[seller] = {}
      for a in string.gmatch(auctions, "[^&]+") do
        table.insert(entry[seller], a)
      end
    end
  end
  self:Debug("Recreated % items results", numItems)
  return numItems, kr
end

function ML:addToResult(key, seller, auction)
  if not self.ahKeyedResult[key] then
    self.ahKeyedResult[key] = {}
  end
  local entry = self.ahKeyedResult[key]
  if not entry[seller] then
    entry[seller] = {}
  end
  -- TODO: delta encode the amounts (and possibly the itemId too)
  table.insert(entry[seller], auction)
end

function ML:zeroToEmpty(num)
  if not num or num == 0 then
    return ""
  end
  return tostring(num)
end

-- coma separated 0s are empty/skipped to shorten the string
-- last 3 arguments are here only for overriding functions that want to do something with the item/auction
-- (like AHDB's)
function ML:auctionEntry(timeLeft, itemCount, minBid, buyoutPrice, bidAmount, _minIncrement, _highBidder, _itemLink,
                         _auctionIndex)
  -- we could use our map/apply and/or ... but this is important to self document the order etc
  return table.concat({
    self:zeroToEmpty(timeLeft), self:zeroToEmpty(itemCount), self:zeroToEmpty(minBid), self:zeroToEmpty(buyoutPrice),
    self:zeroToEmpty(bidAmount)
  }, ",")
end

function ML:ahStrToNum(numS)
  if not numS or #numS == 0 then
    return nil
  end
  return tonumber(numS)
end

-- reverse of auctionEntry
function ML:extractAuctionData(auction)
  local timeLeftS, itemCountS, minBidS, buyoutPriceS, curBidS = auction:match("^(.*),(.*),(.*),(.*),(.*)$")
  return self:ahStrToNum(timeLeftS), self:ahStrToNum(itemCountS), self:ahStrToNum(minBidS),
         self:ahStrToNum(buyoutPriceS), self:ahStrToNum(curBidS)
end

function ML:AHdump(fromEvent)
  self:Debug(3, "AHdump call, fromEvent = %", fromEvent)
  if not self.waitingForAH then
    self:Warning("Not expecting AHdump() call...")
    return
  end
  if self.AHinDump then
    self:Warning("AHdump unexpected reentrance chkpoint %", self.ahResumeAt)
    self.ahCurrentTimerInterval = math.min(2 * self.ahCurrentTimerInterval + 0.1, 1) -- slow down but only up to 1 sec
    ML:AHscheduleNextDump("reentered too soon")
    return
  end
  self.AHinDump = true -- where is 'finally' when you need it - must check every return path below
  self.ahCurrentTimerInterval = self.ahBaseTimerInterval -- (back to) initial speed
  if fromEvent then
    self.ahRetries = 0
    if self.ahTimer then
      self:Debug(4, "cancelling previous timer, from event")
      self.ahTimer:Cancel()
      self.ahTimer = nil
    end
  end
  self.ahPrefetch = self.ahPrefetch or _G.NUM_AUCTION_ITEMS_PER_PAGE
  local batch, count = GetNumAuctionItems("list")
  if batch ~= count then
    self:Error("Unexpected mismatch between batch % and count % for a dump all of AH", batch, count)
    self:AHrestoreNormal()
    self.AHinDump = false
    return
  end
  if count == 0 then
    self:PrintDefault("Result not ready, will try :AHdump() again shortly")
    self.AHinDump = false
    return
  end
  if not self.ahResumeAt then
    self:PrintDefault(self.name .. self.L[": Getting % items from AH all dump. (initial list took % sec to get)"],
                      count, self:round((debugprofilestop() - self.ahStartTS) / 1000, 0.01))
    self.ahResumeAt = 1
    self.expectedCount = count
    self.currentCount = nil
    self.unknownOwners = 0
    self.skippedItems = 0
  else
    if count ~= self.expectedCount and count ~= self.currentCount then
      self.ahRestarts = (self.ahRestarts or 0) + 1
      if count < self.expectedCount * 0.9 then
        self:Warning(self.name .. self.L[" Auction list shrink too much from % to %"] .. "\n" ..
                       self.L["Did you do a search (don't)? report otherwise - starting over (restart #%)!"],
                     self.currentCount or self.expectedCount, count, self.ahRestarts)
      else
        -- probably ok/normal
        self:PrintDefault(self.name ..
                            self.L[" Auction list count changed during scan from % to % - starting over (restart #%)!"],
                          self.currentCount or self.expectedCount, count, self.ahRestarts)
      end
      self.currentCount = count
      -- start over
      if self.ahRestarts > self.ahMaxRestarts then
        self:Error("Too many (%) restarts of scan for % -> % auctions, aborting, please report!", self.ahRestarts,
                   self.expectedCount, self.currentCount)
        self:AHrestoreNormal()
        self.AHinDump = false
        return
      end
      self.ahResult = wipe(self.ahResult)
      self.ahKeyedResult = wipe(self.ahKeyedResult)
      self.ahResumeAt = 1
      self.ahIsStale = true
      self.unknownOwners = 0
      self.skippedItems = 0
      self:AHscheduleNextDump("restart from auction change")
      self.AHinDump = false
      return
    end
  end
  local itemDB = self.savedVar[self.itemDBKey]
  ML.operationsCount = 1 -- reset operations counter for this starting batch
  -- prefetch/request at least .ahPrefetch then reschedule
  local i = self.ahResumeAt
  while (i <= count) do
    local firstIncomplete = nil
    local firstSellerMissing = nil
    local numIncomplete = 0
    local j = i
    local missingSeller = 0
    repeat
      self:ShouldYield()
      if not self.ahResult[j] then
        local linkRes = GetAuctionItemLink("list", j)
        if not linkRes then
          numIncomplete = numIncomplete + 1
          if not firstIncomplete then
            firstIncomplete = j
          end
        else
          -- TODO: add the option to wait for seller information
          local timeLeft = GetAuctionItemTimeLeft("list", j)
          local _name, _texture, itemCount, _quality, _canUse, _level, _levelColHeader, minBid, minIncrement,
                buyoutPrice, bidAmount, highBidder, _bidderFullName, owner, ownerFullName, _saleStatus, _itemId,
                _hasAllInfo = GetAuctionItemInfo("list", j)
          local key = self:AddToItemDB(linkRes, math.max(buyoutPrice, minBid, bidAmount))
          local o = ownerFullName or owner or ""
          local done = true
          if o == "" then
            missingSeller = missingSeller + 1
            self:Debug(3, "Missing seller #% for % % " .. linkRes, missingSeller, j, key)
            if self.ahWaitForSellers then
              done = false
              if not firstSellerMissing then
                firstSellerMissing = j
              end
              -- fixme: copy pasta from above...
              numIncomplete = numIncomplete + 1
              if not firstIncomplete then
                firstIncomplete = j
              end
            else
              self.unknownOwners = self.unknownOwners + 1
            end
          end
          if done then
            self.ahResult[j] = true
            self:addToResult(key, o, self:auctionEntry(timeLeft, itemCount, minBid, buyoutPrice, bidAmount,
                                                       minIncrement, highBidder, linkRes, j))
          end
        end
      end
      j = j + 1
    until (j > count) or (numIncomplete == self.ahPrefetch)
    if numIncomplete > 0 then
      self:Debug(3, "ni % fi % ahR % missingSellers % firstSellerMissing %", numIncomplete, firstIncomplete,
                 self.ahResumeAt, self.unknownOwners, firstSellerMissing)
      local progressMade = (firstIncomplete > self.ahResumeAt)
      if progressMade then
        self:Debug("We made progress from % to %, so resetting retries", self.ahResumeAt, firstIncomplete)
        self.ahRetries = 0
      end
      self.ahRetries = self.ahRetries + 1
      local retriesMsg = ""
      if self.ahRetries > 1 then
        retriesMsg = string.format(self.L[" retry #%d"], self.ahRetries)
      end
      if not fromEvent or progressMade then
        self:PrintDefault(self.L["AH progress: % auctions missing info or seller, first one at % / %"] .. retriesMsg,
                          numIncomplete, firstIncomplete, count, self.ahRetries)
      end
      if self.ahRetries > self.ahMaxRetries then
        if self.ahWaitForSellers and self.firstSellerMissing == self.ahResumeAt then
          self:Warning("Too many retries (%) without getting seller info for item %, skipping " ..
                         GetAuctionItemLink("list", firstSellerMissing), self.ahRetries, firstSellerMissing)
          self.unknownOwners = self.unknownOwners + 1
          self.ahResumeAt = firstSellerMissing + 1
        else
          if self.ahSkipOverErrors then
            self:Warning("Too many retries (%) without progress when trying to get to full AH of %, " ..
              "stuck on item % skipping it", self.ahRetries, count, firstIncomplete)
            self.ahResumeAt = firstIncomplete + 1
            self.skippedItems = self.skippedItems + 1
            self.ahResult[firstIncomplete] = true
            self.ahRetries = 0
          else
            self:Error("Too many retries (%) without progress when trying to get to full AH of % with page size %, " ..
              "stuck on item % (seller missing at %)", self.ahRetries, count, self.ahPrefetch, firstIncomplete,
              firstSellerMissing)
            if self.ahWaitForSellers then
              self:Warning("Blizzard broke getting Seller info since BCC, turn of that option in /ahdb config")
            end
            self:AHrestoreNormal()
            self.AHinDump = false
            return
          end
        end
      else
        self.ahResumeAt = firstIncomplete
      end
      -- we would prefer entirely event based... but it seems like we need more than just events but also keep retrying
      self:AHscheduleNextDump("retry loop")
      self.AHinDump = false
      return
    end
    self.ahResumeAt = j
    self:Debug(1, "Got complete (last) page up to %/%", self.ahResumeAt - 1, count)
    self.ahRetries = 0
    i = j
  end
  self.waitingForAH = nil
  self.ahResumeAt = nil
  if not self.savedVar.ah then
    self.savedVar.ah = {}
  end
  local entry = self:AHContext()
  entry.ts = GetServerTime()
  entry.dataFormatVersion = 6
  entry.dataFormatInfo =
    "v4key!seller1/timeleft,itemCount,minBid,buyoutPrice,curBid&auction2&auction3!seller2/a1&a2 ...\n" ..
      "(grouped by itemKey, seller) with auction units being timeleft,itemCount,minBid,buyoutPrice,curBid"
  entry.itemsCount, entry.data = self:ahSerializeScanResult()
  self:PrintInfo("MoLib " .. self.L["AH Scan data packed % auctions of % items to % Kbytes"], count, entry.itemsCount,
                 self:round(#entry.data / 1024, .1))
  self.ahResult = wipe(self.ahResult)
  wipe(self.ahAuctionInfoCache.ahKeyedResult) -- clear cache (we could update instead...)
  self.ahAuctionInfoCache.ahKeyedResult = self.ahKeyedResult -- transfer the last scan data into the cache
  self.ahKeyedResult = {} -- reset for next run (but not wipe, will be wiped n-1)
  self.ahAuctionInfoCache.resCache = wipe(self.ahAuctionInfoCache.resCache)
  self.ahAuctionInfoCache.ts = entry.ts
  entry.count = count
  entry.firstCount = self.expectedCount -- the two should be equal for good scans, probably shud just discard... keeping to study it
  entry.testScan = self.ahIsStale -- did we really do a query first
  self.ahEndTS = debugprofilestop()
  local elapsed = (self.ahEndTS - self.ahStartTS) / 1000 -- in seconds not ms
  entry.elapsed = elapsed
  table.insert(self.savedVar.ah, entry) -- result saved here
  local speed = self:round(count / elapsed, 0.1)
  elapsed = self:round(elapsed, 0.01)
  local newItems = itemDB._count_ - self.itemDBStartingCount
  entry.newItems = newItems
  entry.itemDBcount = itemDB._count_
  entry.missingSellers = self.unknownOwners
  entry.skippedItems = self.skippedItems
  self:PrintInfo(self.name .. self.L[": Auction scan complete and captured for % listings in % s (% auctions/sec)."] ..
                   "\n" .. self.L["% new items in DB, now % entries (% with info). % missing seller info. % skipped items."], count, elapsed, speed,
                 newItems, itemDB._count_, itemDB._infoCount_, self.unknownOwners, self.skippedItems)
  self:AHrestoreNormal()
  self:AHendOfScanCB()
  self.AHinDump = false
  return entry
end

-- called by addon after we call it with restored saved vars (!)
function ML:AHRestoreData()
  if not self.savedVar or not self.savedVar.ah or #self.savedVar.ah == 0 then
    return
  end
  local ah = self.savedVar.ah
  local entry = ah[#ah]
  if entry.dataFormatVersion ~= 6 then
    self:Warning("Unexpected latest AH scan data format %", entry.dataFormatVersion)
    return
  end
  -- TODO get the right faction one not just latest
  local count, kr = self:ahDeserializeScanResult(entry.data)
  if count ~= entry.itemsCount then
    self:Error("Error deserializing got % when expecting % items.", count, entry.itemsCount)
    return
  end
  self.ahAuctionInfoCache.ahKeyedResult = kr
  self.ahAuctionInfoCache.ts = entry.ts
  self:AHSetupEnv()
end

function ML:AHendOfScanCB()
  self:Debug("Default non overridden AHendOfScanCB()")
end
