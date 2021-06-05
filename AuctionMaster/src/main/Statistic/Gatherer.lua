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
	Gathers statistics by hooking auction functions.
--]]
vendor.Gatherer = vendor.Vendor:NewModule("Gatherer", "AceTimer-3.0", "AceEvent-3.0")
local L = vendor.Locale.GetInstance()
local log = vendor.Debug:new("Gatherer")
--local GATHERER_VERSION = 2
local TIME_LEFT = {1800, 7200, 43200, 172800}

--[[
	Migrates the database.
--]]
--local function _MigrateDb(self)
--	if (not self.db.factionrealm.version or self.db.factionrealm.version < 2) then
--		-- reinitialize the snapshot for the new ownAuctionItemLinkKeys table
--		self.db.factionrealm.snapshot = {}
--	end
--	if (not self.db.realm.version or self.db.realm.version < 2) then
--		-- reinitialize the snapshot for the new ownAuctionItemLinkKeys table
--		self.db.realm.snapshot = {}
--	end
--	-- set the versions robustly to downgrades
--	if (not self.db.factionrealm.version or self.db.factionrealm.version < GATHERER_VERSION) then	
--		self.db.factionrealm.version = GATHERER_VERSION
--	end
--	if (not self.db.realm.version or self.db.realm.version < GATHERER_VERSION) then	
--		self.db.realm.version = GATHERER_VERSION
--	end
--end

--[[
	Sets the given value in the profile.
--]]
local function _SetValue(info, value)
	self.db.profile[info.arg] = value
end

--[[
	Returns the given value from the profile.
--]]
local function _GetValue(info)
	return self.db.profile[info.arg]
end

--[[
	Packs the following information to a compact string:
	itemLinkKey, count, minBid, buyoutPrice, time, timeLeft, name, quality, level, minIncrement, bidAmount, 
	highBidder, owner, saleStatus
--]]
local function _Pack(itemLinkKey, count, minBid, buyoutPrice, time, timeLeft, name, quality, level, minIncrement, bidAmount, 
	highBidder, owner, saleStatus)
	return strjoin(";", itemLinkKey, count, minBid, buyoutPrice or "0").."|"..strjoin(";", 
			GetTime(), timeLeft).."|"..strjoin(";", string.lower(name), quality, level or "0", minIncrement or "0", bidAmount or "0", highBidder or "", owner or "", 
			saleStatus or "")
end

--[[
	Unpacks the information contained in the auction data represantation.
	itemLinkKey, count, minBid, buyout, name, quality, level, minIncrement, bidAmount, 
		highBidder, owner, saleStatus, time, timeLeft
--]]
local function _Unpack(data)
	local part1, part2, part3 = strsplit("|", data)
	local itemLinkKey, count, minBid, buyout = strsplit(";", part1)
	local time, timeLeft = strsplit(";", part2)
	local name, quality, level, minIncrement, bidAmount, highBidder, owner, saleStatus = strsplit(";", part3)
	return itemLinkKey, tonumber(count or 1), tonumber(minBid), tonumber(buyout or 0), name, quality, 
		tonumber(level), tonumber(minIncrement or 0), tonumber(bidAmount or 0), highBidder, owner, saleStatus, tonumber(time), tonumber(timeLeft or 4)
end

--[[
	Starts a new scan.
--]]
local function _StartScan(self, scanInfo)
	self.scan = {
		name = scanInfo.name, 
		minLevel = tonumber(scanInfo.minLevel), 
		maxLevel = tonumber(scanInfo.maxLevel), 
		invTypeIndex = scanInfo.invTypeIndex or 0, 
		classIndex = scanInfo.classIndex or 0, 
		subclassIndex = scanInfo.subclassIndex or 0, 
		isUsable = scanInfo.isUsable, 
		qualityIndex = scanInfo.qualityIndex or 0, 
		index = {},
		neutralAh = vendor.AuctionHouse:IsNeutral()
	}
	local scan = self.scan
  	if (scan.name) then
  		scan.name = string.lower(scan.name)
  	end
	if (scan.classIndex > 0) then
		scan.class = select(scan.classIndex, GetAuctionItemClasses())
	end
	if (scan.classIndex > 0 and scan.subclassIndex > 0) then
		scan.subclass = select(scan.subclassIndex, GetAuctionItemSubClasses(scan.classIndex))
	end
	if (scan.invTypeIndex > 0 and scan.classIndex > 0 and scan.subclassIndex > 0) then
		scan.invType = select(scan.invTypeIndex, GetAuctionInvTypes(scan.classIndex, scan.subclassIndex))
	end
end

--[[
	Extracts the itemLinkKey from the given data line.
--]]
local function _ExtractItemLinkKey(data)
	-- returns the part before the first ";"
	local idx = string.find(data, ";", 1, true)
	return string.sub(data, 1, idx - 1)
end

-- FIXME this is shit
-- shortens battle pet keys
local function _SimpleItemLinkKey(key)
	if (strbyte(key, 1) == 0x62) then
		-- match speciesId (and quality?)
		local _, speciesId, level, breedQuality = strsplit(":", key)
		return "bp:"..speciesId
	end
	return key
end

-- FIXME
local function _ExtractSimpleItemLinkKey(data)
	return _SimpleItemLinkKey( _ExtractItemLinkKey(data))
end

--[[
	Returns startPos, endPos in snapshot or nil for the given key.
--]]
local function _SearchAuctions(self, snapshot, itemLinkKey)
	local startPos = vendor.Tables.BinarySearch(snapshot, itemLinkKey, _ExtractItemLinkKey)
	local endPos = startPos
	if (startPos) then
		-- select the leftmost entry
		while (true) do
			if (startPos > 1 and _ExtractItemLinkKey(snapshot[startPos - 1]) == itemLinkKey) then
				startPos = startPos - 1
			else
				break
			end
		end
		-- select the rightmost entry
		while (true) do
			if (endPos < #snapshot and _ExtractItemLinkKey(snapshot[endPos + 1]) == itemLinkKey) then
				endPos = endPos + 1
			else
				break
			end
		end
	end
	return startPos, endPos
end

--[[
	Retrieves the snapshot corrresponding the current auctionshouse.
--]]
local function _GetSnapshot(self)
	if (vendor.AuctionHouse:IsNeutral()) then
		return self.db.realm.snapshot
	end
	return self.db.factionrealm.snapshot
end

--[[
	Returns true, if the given auction matches the current scan.
--]]
local function _MatchesScan(self, scan, auction)
	local data1, _, data3 = strsplit("|", auction)
	local itemLinkKey = _ExtractItemLinkKey(data1)
	local doLog = false
	local name, _, level = strsplit(";", data3)
	level = tonumber(level)
	local rtn = false
	local lastExit = 0
	while (true) do
		if (scan.name and not (string.sub(name, 1, string.len(scan.name)) == scan.name)) then
			--log:Debug("_MatchesScan exit because of name (scan: %s auctionb: %s", scan.name or "", name or "")
			lastExit = 1
			break
		end
		if (scan.minLevel and level < scan.minLevel) then
			if (doLog) then
				log:Debug("_MatchesScan exit because of minLevel")
			end
			lastExit = 2
			break
		end
		if (scan.maxLevel and scan.maxLevel > 0 and level > 0 and level > scan.maxLevel) then
			if (doLog) then
				log:Debug("_MatchesScan exit because of maxLevel (scan: %d auction: %d)", scan.maxLevel or 777, level or 777)
			end
			lastExit = 3
			break
		end
		if (scan.invType or scan.class or scan.subclass or scan.qualityIndex > 0) then
			if (doLog) then
				log:Debug("check inv class %s index: %d subclass %s index: %d", scan.class, scan.classIndex or 777, scan.subclass, scan.subclassIndex or 777)
			end
			local itemLink = vendor.Items:GetItemLink(itemLinkKey)
			local itemName, _, itemRarity, _, _, itemType, itemSubType, _,
				itemEquipLoc = GetItemInfo(itemLink) 
			if (not itemName) then
				if (doLog) then
					log:Debug("_MatchesScan exit because of missing itemName")
				end
				lastExit = 4
				break
			else
				if (scan.qualityIndex > 0 and itemRarity < scan.qualityIndex) then
					if (doLog) then
						log:Debug("_MatchesScan exit because of quality")
					end
					lastExit = 5
					break
				end
				if (doLog) then
					log:Debug("invTypeIndex: %d invType: %s", scan.invTypeIndex or 777, scan.invType)
				end
				if (scan.invType and scan.invType ~= itemEquipLoc) then
					if (doLog) then
						log:Debug("compare invType %s with %s", scan.invType, itemEquipLoc)
					end
					lastExit = 6
					break
				end
				if (scan.class and scan.class ~= itemType) then
					if (doLog) then
						log:Debug("exist because of class [%s] [%s]", scan.class, itemType)
					end
					lastExit = 7
					break
				end
				if (scan.subclass and scan.subclass ~= itemSubType) then
					if (doLog) then
						log:Debug("exist because of subclass [%s] [%s]", scan.subclass, itemSubType)
					end
					lastExit = 8
					break
				end
			end
		end
		rtn = true
		break
	end
--	if (name == "silberblatt") then
--		log:Debug("_MatchesScan exit: %s for %s lastExit [%s] level [%s] scan.maxLevel [%s]", rtn, name, lastExit, level, scan.maxLevel)
--	end
	return rtn
end

--[[
	Extracts the auctions from the snapshot corresponding to the current scan.
--]]
local function _ExtractOldAuctions(self, scan, snapshot, auctions)
	log:Debug("_ExtractOldAuctions enter with %d auctions in snapshot", #snapshot)
	debugprofilestart()
	-- move matching auctions to other table
	if (#snapshot > 0) then
    	for i=#snapshot,1,-1 do
    		local data = snapshot[i]
    		if (_MatchesScan(self, scan, data)) then
    			table.insert(auctions, data)
    			table.remove(snapshot, i)
    		end
    	end
    end
    table.sort(auctions)
	log:Debug("_ExtractOldAuctions exit with %d extracted auctions and %d auctions in snapshot in %d millis", #auctions, #snapshot, debugprofilestop())
end

--[[
	Returns true, if the tow auctions match.
--]]
local function _MatchItems(data1, data2)
	local idx1 = string.find(data1, "|", 1, true)	
	local idx2 = string.find(data2, "|", 1, true)
	return string.sub(data1, 1, idx1 - 1) == string.sub(data2, 1, idx2 - 1)
end

--[[
	Remove all auctions in the given table, which are also contained
	in the current scan.
--]]
local function _RemoveDuplicates(self, index, auctions)
	log:Debug("_RemoveDuplicates enter with %d auctions", #auctions)
	debugprofilestart()
	local indexLen = #index
	local auctionsLen = #auctions
	-- FIXME don't use the extra table ??
	local duplicateRemove = {}
	local auctionsOff = 0
	local indexOff = 0
	local auctionData, indexData, data, idx
	while (true) do
		-- get data to compare
		if (not auctionData) then
			auctionsOff = auctionsOff + 1
			if (auctionsOff > auctionsLen) then
				-- not further matches possible
				log:Debug("exit with auctionsOff %d", auctionsOff)
				break
			end
			data = auctions[auctionsOff]
			idx = string.find(data, "|", 1, true)
			auctionData = string.sub(data, 1, idx - 1)
		end
		if (not indexData) then
			indexOff = indexOff + 1
			if (indexOff > indexLen) then
				-- no further matches possible
				log:Debug("exit with indexOff %d", indexOff)
				break
			end
			data = index[indexOff]
			idx = string.find(data, "|", 1, true)
			indexData = string.sub(data, 1, idx - 1)
		end
		-- compare the data
		if (auctionData == indexData) then
			-- we have a match, current auction won't be added
			auctionData = nil
			indexData = nil
		elseif (auctionData < indexData) then
			-- we can't find a match for current auction
			table.insert(duplicateRemove, auctions[auctionsOff])
			auctionData = nil
		else
			-- perhaps the next index entry will match
			indexData = nil
		end	
	end
	log:Debug("_RemoveDuplicates exit with %d auctions in %d millis", #duplicateRemove, debugprofilestop())
	return duplicateRemove
end

--[[
	Reinsert the auction of the given table to the snapshot.
--]]
local function _ReinsertAuctions(self, snapshot, oldAuctions)
	log:Debug("_ReinsertAuctions enter")
	debugprofilestart()
	for i=1,#oldAuctions do
		table.insert(snapshot, oldAuctions[i])
	end
	log:Debug("_ReinsertAuctions exit with %d in snapshot in %d millis", #snapshot or 0, debugprofilestop())
end

--[[
	Insert the auction of the current scan to the snapshot.
--]]
local function _InsertScan(self, index, snapshot)
	log:Debug("_InsertScan enter with %d auction in scan", #index or 0)
	debugprofilestart()
	for i=1,#index do
		table.insert(snapshot, index[i])
	end
	log:Debug("_InsertScan exit with %d in snapshot in %d millis", #snapshot or 0, debugprofilestop())
end

local function _ClearCaches(self)
	log:Debug("_ClearCaches")
	self.currentAuctionCache = wipe(self.currentAuctionCache)
	self.auctionCache = wipe(self.auctionCache)
end

local function _ArchiveValues(self, itemLinkKey, bids, buyouts, neutralAh)
	if (strbyte(itemLinkKey, 1) == 0x62) then -- 'b'
		-- currently no history values for pets
		return
	end

	local itemInfo = self.itemInfo
	if (not vendor.Items:GetItemInfo(itemLinkKey, itemInfo, neutralAh)) then
		vendor.Items:InitItemInfo(itemInfo)
	end
	if (#bids > 0) then
		if (#bids > 1) then
			table.sort(bids)
			vendor.Math.CleanupByStandardDeviation(bids, vendor.Statistic.db.profile.smallerStdDevMul, vendor.Statistic.db.profile.largerStdDevMul)
		end
		itemInfo.avgBidData = self.bidAvg:AddValue(itemInfo.avgBidData, vendor.Math.GetMedian(bids))
	end
	if (#buyouts > 0) then
		if (#buyouts > 1) then
			table.sort(buyouts)
			vendor.Math.CleanupByStandardDeviation(buyouts, vendor.Statistic.db.profile.smallerStdDevMul, vendor.Statistic.db.profile.largerStdDevMul)
		end
		itemInfo.avgBuyoutData = self.buyoutAvg:AddValue(itemInfo.avgBuyoutData, vendor.Math.GetMedian(buyouts))
	end
	vendor.Items:PutItemInfo(itemLinkKey, neutralAh, itemInfo)
end

--[[
	Adds the given auctions to the archive.
--]]
local function _ArchiveAuctions(self, auctions, neutralAh)
	local itemLinkKey, count, minBid, buyout, data, bidAmount, _
	table.sort(auctions) -- just to be sure
	local prevKey
	local bids = {}
	local buyouts = {}
	for i=1,#auctions do
		itemLinkKey, count, minBid, buyout, _, _, _, _, bidAmount = vendor.Gatherer:Unpack(auctions[i])
		if (prevKey and prevKey ~= itemLinkKey) then
			_ArchiveValues(self, prevKey, bids, buyouts, neutralAh)
			bids = wipe(bids)
			buyouts = wipe(buyouts)
		end
		if (bidAmount > 0) then
			table.insert(bids, bidAmount / count)
		else
			table.insert(bids, minBid / count)
		end
		if (buyout > 0) then
			table.insert(buyouts, buyout / count)
		end
		prevKey = itemLinkKey
	end
	if (prevKey and #bids > 0) then
		_ArchiveValues(self, prevKey, bids, buyouts, neutralAh)
	end
end

--[[
	Moves the outdated auctions in the snapshot to the archive.
--]]
local function _CleanupSnapshot(self, snapshot, neutralAh)
	log:Debug("_CleanupSnapshot enter with %d auctions in snapshot", #snapshot)
	debugprofilestart()
	local removed = 0
	if (#snapshot > 0) then
		local auctions = {} 
		local now = GetTime()
		for i=#snapshot,1,-1 do
			local data1, data2, data3 = strsplit("|", snapshot[i])
			local time, timeLeft = strsplit(";", data2)
			if (now > (tonumber(time) + TIME_LEFT[tonumber(timeLeft or 4)])) then
				table.insert(auctions, snapshot[i])
				table.remove(snapshot, i)
			end
		end
		removed = #auctions
		_ArchiveAuctions(self, auctions, neutralAh)
	end
	log:Debug("_CleanupSnapshot exit with %d in snapshot removed %d in %d millis", #snapshot, removed, debugprofilestop())
end

--[[
	Starts a task for archiving the current scan asynchronously.
--]]
local function _RememberScan(self, complete)
	self.scan.complete = complete
	local task = vendor.ArchiveTask:new(self.scan)
	self.scan = nil -- FIXME recycle scan
	vendor.TaskQueue:AddTask(task)
end

--[[
	The auction statistics has been updated. Notify any listeners and clear the caches.
--]]
local function _NotifyUpdate(self, itemLinkKey)
	log:Debug("NotifyUpdate")
	_ClearCaches(self)
	self:SendMessage("AUCTION_STATISTIC_UPDATE", itemLinkKey)
	if (self.statCallbacks) then
    	for i=1,#self.statCallbacks do
    		local callback = self.statCallbacks[i] 
    		callback.func(callback.arg)
    	end
    end
end

--[[
	Remembers the auctions found in the current scan.
--]]
local function _ArchiveScan(self, scan)
	local removed = 0
	local added = 0
	local index = scan.index
	log:Debug("_ArchiveScan enter with %d auctions in index", #index)
	table.sort(index)
	local extractedAuctions = {}
	local snapshot = self.db.factionrealm.snapshot
	if (scan.neutralAh) then
		snapshot = self.db.realm.snapshot
	end
	log:Debug("_ArchiveScan %d auctions in snapshot", #snapshot)
	_CleanupSnapshot(self, snapshot, neutralAh)
	_ExtractOldAuctions(self, scan, snapshot, extractedAuctions)
	local extracted = _RemoveDuplicates(self, index, extractedAuctions)
	if (not scan.complete) then
		-- readd the old auctions not matched
		_ReinsertAuctions(self, snapshot, extracted)
	else
		-- we are sure, that the auctions in "extracted" are not existing anymore
		_ArchiveAuctions(self, extracted, neutralAh)
		removed = removed + #extracted
	end
	_InsertScan(self, index, snapshot)
	table.sort(snapshot)
	added = #index - #extracted
	--wipe(extracted)
	_NotifyUpdate(self, self.scanItemLinkKey)
	log:Debug("_ArchiveScan exit removed: %d added: %d snapshot: %d", removed, added, #snapshot)
end

--[[
	Copies the own auctions to be guared against changes.
--]]
local function _CopyOwnAuctions(self, auctions)
	local itemModel = vendor.OwnAuctions.itemModel
	for i=1,itemModel:Size() do
		local index, itemLinkKey, itemLink, name, _, count, bid, buyout, _, saleStatus, _, minBid, 
				bidAmount, minIncrement, timeLeft, quality, level = itemModel:Get(i)
		if (saleStatus ~= 1) then
    		local info = {index = index, itemLinkKey = itemLinkKey, name = name, count = count, bid = bid, 
    			buyout = buyout, saleStatus = saleStatus, minBid = minBid, bidAmount = bidAmount, 
    			timeLeft = timeLeft, quality = quality, level = level, minIncrement = minIncrement}
    		table.insert(auctions, info)
    	end
	end
end

--[[
	Searches for all own auctions in the snapshot.
--]]
local function _SearchOwnAuctions(self, auctions, snapshot, owner) 
	log:Debug("_SearchOwnAuctions enter with %d auctions in snapshot", #snapshot)
	debugprofilestart()
	for i=1,#snapshot,1 do
		local itemLinkKey, count, minBid, buyout, _, _, _, _, bidAmount, _, owner2 = _Unpack(snapshot[i])
		if (owner == owner2) then
			local info = {itemLinkKey = itemLinkKey, minBid = minBid, buyout = buyout, bidAmount = bidAmount,
							count = count, index = i}	
			table.insert(auctions, info)
		end
	end
	log:Debug("_SearchOwnAuctions exit in %s millis", debugprofilestop())
end
 
local function _PackOwnAuctionInfo(info, owner)
--	log:Debug("_PackOwnAuctionInfo [%s] [%s] [%s] [%s] [%s] [%s] [%s] [%s] [%s] [%s] [%s] [%s] [%s] [%s]", info.itemLinkKey, info.count, info.minBid, info.buyout, GetTime(), info.timeLeft, 
--		info.name, info.quality, info.level, info.minIncrement, info.bidAmount, 0, owner, 0)
	return _Pack(info.itemLinkKey, info.count or 1, info.minBid, info.buyout or 0, GetTime(), info.timeLeft, 
		info.name, info.quality, info.level, info.minIncrement or 0, info.bidAmount or 0, 0, owner or "", 0)
end

--[[
	Subtracts subtrahent from minuend.
--]]
local function _SubtractAuctions(minuend, substrahent)
	for s=1,#substrahent do
		local sub = substrahent[s]
		for m=1,#minuend do
			local min = minuend[m]
--			log:Debug("compare [%s] [%s] [%s] [%s] [%s] [%s] [%s] [%s]", sub.itemLinkKey, min.itemLinkKey, sub.minBid, min.minBid, sub.buyout, min.buyout, sub.count, min.count)
			if (sub.itemLinkKey == min.itemLinkKey and sub.minBid == min.minBid and 
					sub.buyout == min.buyout and sub.count == min.count)  then
--					log:Debug("remove")
				table.remove(minuend, m)
				break
			end
		end
	end
end

--[[
	Returns the current auction information known about the given item. See GetCurrentAuctionInfo
	for details.
--]]
local function _GetCurrentAuctionInfo(self, itemLinkKey, neutralAh, adjustPrices)
	local suffix = "-f"
	if (adjustPrices) then
		suffix = string.format("_%g_%g", vendor.Statistic.db.profile.smallerStdDevMul, vendor.Statistic.db.profile.largerStdDevMul)
	end
	local cacheKey = itemLinkKey..suffix
	local minBuyout
	local info = self.currentAuctionCache[cacheKey]
	if (not info) then
		local bids = wipe(self.bids)
		local buyouts = wipe(self.buyouts)
		info = {}
   		info.numAuctions = 0
   		info.numBuyouts = 0
   		info.avgBid = 0
   		info.avgBuyout = 0
   		info.lowerBuyoutOwner = nil
   		info.leastCurrentTime = nil
    	local snapshot = self.db.factionrealm.snapshot
    	if (neutralAh) then
    		snapshot = self.db.realm.snapshot
    	end
    	
    	local idx = vendor.Tables.BinarySearch(snapshot, itemLinkKey, _ExtractItemLinkKey)
    	if (idx) then
    		-- select the leftmost entry
    		while (true) do
    			if (idx > 1 and _ExtractItemLinkKey(snapshot[idx - 1]) == itemLinkKey) then
    				idx = idx - 1
    			else
    				break
    			end
    		end
    		-- collect the values
    		for i=idx,#snapshot do
    			local key, count, minBid, buyout, name, _, _, _, bidAmount, _, owner, _, time = _Unpack(snapshot[i]) 
				if (key ~= itemLinkKey) then
    				break
    			end
--    			log:Debug("unpacked %s at pos %s", name, i)
    			info.numAuctions = info.numAuctions + 1
    			if (not info.leastCurrentTime or time < info.leastCurrentTime) then
    				info.leastCurrentTime = time
    			end
    			if (bidAmount > 0) then
    				minBid = bidAmount
    			end
    			if (count > 1) then
    				minBid = minBid / count
    				buyout = buyout / count
    			end
				if (buyout and buyout > 0 and (not minBuyout or (minBuyout > buyout))) then
					minBuyout = buyout
					info.lowerBuyoutOwner = owner
					log:Debug("Select lowerBuyoutOwner [%s] for [%s]", owner, buyout)
				end
    			table.insert(bids, minBid)
    			if (buyout > 0) then
    				table.insert(buyouts, buyout)
    				info.numBuyouts = info.numBuyouts + 1
    			end
    		end
    		table.sort(bids)
    		table.sort(buyouts)
			-- cleanup values
			if (adjustPrices) then
    			if (#bids > 1) then
    				vendor.Math.CleanupByStandardDeviation(bids, vendor.Statistic.db.profile.smallerStdDevMul, vendor.Statistic.db.profile.largerStdDevMul)
    			end
    			if (#buyouts > 1) then
    				log:Debug("smallest buyout before cleanup [%s]", buyouts[1])
    				vendor.Math.CleanupByStandardDeviation(buyouts, vendor.Statistic.db.profile.smallerStdDevMul, vendor.Statistic.db.profile.largerStdDevMul)
    				log:Debug("smallest buyout after cleanup [%s]", buyouts[1])
    			end
    		end
--    		local values = ""
--    		for i=1,#buyouts do
--    			values = values..buyouts[i].." "
--    		end
--    		log:Debug("adjustPrices [%s] buyouts [%s] values [%s]", adjustPrices, #buyouts, values)
    		-- now calculate the return values
    		if (#bids > 0) then
    			info.lowerBid = bids[1]
    			info.upperBid = bids[#bids]
    			info.avgBid = math.floor(vendor.Math.GetAverage(bids) + 0.5)
    		end
    		if (#buyouts > 0) then
    			info.lowerBuyout = buyouts[1]
    			info.upperBuyout = buyouts[#buyouts]
    			info.avgBuyout = math.floor(vendor.Math.GetAverage(buyouts) + 0.5)
    			info.medianBuyout = vendor.Math.GetMedian(buyouts)
    		end
    	end
    	self.currentAuctionCache[cacheKey] = info
	end
	log:Debug("_GetCurrentAuctionInfo exit avgBuyout [%s] lowerBuyout [%s]", info.avgBuyout, info.lowerBuyout)
	return info.avgBid, info.avgBuyout, info.lowerBid, info.lowerBuyout, info.upperBid, 
    	info.upperBuyout, info.numAuctions, info.numBuyouts, info.leastCurrentTime, info.lowerBuyoutOwner, info.medianBuyout
end

-- archive not possible this way
--local function _CleanupSnapshots(self)
--	log:Debug("_CleanupSnapshots enter")
--	-- calculate databases, which could be deleted
--	if (VendorDb and VendorDb.namespaces and VendorDb.namespaces and VendorDb.namespaces.Gatherer and VendorDb.namespaces.Gatherer.factionrealm) then
--		local k,v
--		for k,v in pairs(VendorDb.namespaces.Gatherer.factionrealm) do
--			local size = 0
--			if (v.snapshot) then
--				_CleanupSnapshot(self, v.snapshot, false)
--			end
--		end
--	end
--	log:Debug("_CleanupSnapshots exit")
--end

--[[
	Initializes the module.
--]]
function vendor.Gatherer:OnInitialize()
	self.db = vendor.Vendor.db:RegisterNamespace("Gatherer", {
		profile = {
    	},
    	factionrealm = {
			snapshot = {},
		},
		realm = {
			snapshot = {},
		},
		global = {
			statisticDb = {
				realms = {
				}
			}
		}
	})
--	_MigrateDb(self)
	self.itemInfo = {} -- reusing the table
	self.currentAuctionCache = {}
	self.auctionCache = {}
	self.bidAvg = vendor.ApproxAverage:new(30)
	self.buyoutAvg = vendor.ApproxAverage:new(30)
	self.ownAuctionUpdate = 0
	self.ownAuctionDone = 0
	self.bids = {}
	self.buyouts = {}
	self.ownAuctionItemLinkKeys = {}
	self.tmpList1 = {}
	self.tmpList2 = {}
	self.tmpList3 = {}
	self.tmpList4 = {}
	self.tmpList5 = {}
end

--[[
	Initializes the module.
--]]
function vendor.Gatherer:OnEnable()
	self.canUseEval = vendor.CanUseEval:new()
--	self:ScheduleRepeatingTimer(_TriggerUpdateOwnAuctions, 1, self)
--	self:RegisterMessage("OWN_AUCTIONS_UPDATE")
	self.statisticDb = vendor.StatisticDb:new(self.db.global.statisticDb)
--	vendor.TaskQueue:Execute(_CleanupSnapshots, self)
end

--[[
	Deinitializes the module.
--]]
function vendor.Gatherer:OnDisable()
	self.canUseEval = nil
--	self:UnregisterMessage("OWN_AUCTIONS_UPDATE")
end

--[[
	Starts a new scan. The auctions has to be added via AddAuctionItemInfo. The scan
	has to be stopped via StopScan. The info object may contain:
	name, minLevel, maxLevel, invTypeIndex, classIndex, subclassIndex, page, isUsable, qualityIndex
--]]
function vendor.Gatherer:StartScan(scanInfo)
  	log:Debug("StartScan")
	_StartScan(self, scanInfo) 
end

--[[
	Stops any executing scan.
--]]
function vendor.Gatherer:StopScan(itemLinkKey, complete)
	if (self.scan) then
		log:Debug("StopScan itemLinkKey [%s] complete [%s] isUsable [%s]", itemLinkKey, complete, self.scan.isUsable)
		self.scanItemLinkKey = itemLinkKey
		if (complete and (not self.scan.isUsable or self.scan.isUsable == 0)) then
			_RememberScan(self, complete)
		else
		 -- TODO remember partial scans
		end
	end
end

--[[
	Adds the given scanned auction. The Gatherer has to be in scan-mode.
--]]
function vendor.Gatherer:AddAuctionItemInfo(itemLinkKey, name, quality, level, count, minBid, buyout, bidAmount, 
		minIncrement, timeLeft, highBidder, owner)
	-- the first part is meant for fast comparisson
	local data = _Pack(itemLinkKey, count, minBid, buyout, GetTime(), timeLeft, name, quality, level, 
		minIncrement, bidAmount, highBidder, owner,	0)
	table.insert(self.scan.index, data)
end

--[[
	Retrieves a ScanSet for the given item.
--]]
function vendor.Gatherer:GetCurrentAuctions(itemLinkKeyIn, neutralAh)
	log:Debug("GetCurrentAuctions enter")
	local index = {}
	local snapshot = self.db.factionrealm.snapshot
    if (neutralAh) then
    	snapshot = self.db.realm.snapshot
    end
    -- FIXME this is all shit with the battle pets :-(
    local itemLinkKey = _SimpleItemLinkKey(itemLinkKeyIn)
	local idx = vendor.Tables.BinarySearch(snapshot, itemLinkKey, _ExtractSimpleItemLinkKey)
    if (idx) then
		-- select the leftmost entry
		while (true) do
			if (idx > 1 and _ExtractSimpleItemLinkKey(snapshot[idx - 1]) == itemLinkKey) then
				idx = idx - 1
			else
				break
			end
		end
		-- now get all entries
		for i=idx,#snapshot do
			local key, count, minBid, buyout, name, quality, level, minIncrement, bidAmount, 
			highBidder, owner, saleStatus, time, timeLeft = _Unpack(snapshot[i]) 
			if (_SimpleItemLinkKey(key) ~= itemLinkKey) then
				break
			end
			local data = vendor.ScanResults.Pack(key, time or GetTime(), timeLeft, count or 1, minBid or 0, minIncrement or 0, buyout or 0, bidAmount or 0, owner or "", highBidder or "", 0)
			table.insert(index, data) 
		end
	end
	log:Debug("GetCurrentAuctions exit [%s] auctions", #index)
	return vendor.ScanSet:new(index, neutralAh, itemLinkKeyIn)
end

--[[
	Returns the below described information for current auctions of the specified item.
    avgBid, avgBuyout, lowerBid, lowerBuyout, upperBid, upperBuyout, numAuctions, numBuyouts, leastCurrentTime, lowerBuyoutOwner
--]]
function vendor.Gatherer:GetCurrentAuctionInfo(itemLink, neutralAh, adjustPrices)
	local itemLinkKey = vendor.Items:GetItemLinkKey(itemLink)
	return _GetCurrentAuctionInfo(self, itemLinkKey, neutralAh, adjustPrices)	
end

--[[
	Returns the below described all-time information for auctions of the specified item.
    avgBid, avgBuyout, numAuctions, numBuyouts
--]]
function vendor.Gatherer:GetAuctionInfo(itemLink, neutralAh, adjustPrices)
	local itemLinkKey = vendor.Items:GetItemLinkKey(itemLink)	
	local info = self.auctionCache[itemLinkKey]
	local _
	if (not info) then
		info = {}
		-- first the current information about the item
		info.avgBid, info.avgBuyout, _, _, _, _, info.numAuctions, info.numBuyouts = _GetCurrentAuctionInfo(self, itemLinkKey, neutralAh, adjustPrices)
		
		-- now the all-time information
		local itemInfo = self.itemInfo
		if (vendor.Items:GetItemInfo(itemLinkKey, itemInfo, neutralAh)) then
			-- TODO without mult
			local numValues, avgValue = self.bidAvg:GetInfo(itemInfo.avgBidData)
			if (numValues > 0) then
				info.avgBid = math.floor(((info.avgBid * info.numAuctions) + (numValues * avgValue)) / (numValues + info.numAuctions) + 0.5)
				info.numAuctions = info.numAuctions + numValues
			end
			numValues, avgValue = self.buyoutAvg:GetInfo(itemInfo.avgBuyoutData)
			if (numValues > 0) then
				info.avgBuyout = math.floor(((info.avgBuyout * info.numBuyouts) + (numValues * avgValue)) / (numValues + info.numBuyouts) + 0.5)
				info.numBuyouts = info.numBuyouts + numValues
			end
		end
    	self.auctionCache[itemLinkKey] = info
	end
	return info.avgBid, info.avgBuyout, info.numAuctions, info.numBuyouts
end

--[[
	Cleanup the snapshot from outdated auctions.
--]]
function vendor.Gatherer:CleanupSnapshot()
	local snapshot = _GetSnapshot(self)
	_CleanupSnapshot(self, snapshot, neutralAh)
end

--[[
	Unpacks the information contained in the auction data represantation.
	itemLinkKey, count, minBid, buyout, name, quality, level, minIncrement, bidAmount, 
		highBidder, owner, saleStatus, time, timeLeft
--]]
function vendor.Gatherer:Unpack(data)
	return _Unpack(data)
end

--[[
	Will be called asynchronously from a task and will archive the given scan.
--]]
function vendor.Gatherer:ArchiveScan(scan)
	_ArchiveScan(self, scan)
end

--[[
	Removes the given auction from the snapshot and archives it.
--]]
function vendor.Gatherer:AuctionBought(itemLinkKey, minBid, buyout, count)
	log:Debug("AuctionBought itemLinkKey [%s] minBid [%s] buyout [%s] count [%s]", itemLinkKey, minBid, buyout, count)
	local snapshot = _GetSnapshot(self)
	local player = UnitName("player")
	local neutralAh = vendor.AuctionHouse:IsNeutral()
	_CleanupSnapshot(self, snapshot, neutralAh)
	local auctions = wipe(self.tmpList1)
	local startPos, endPos = _SearchAuctions(self, snapshot, itemLinkKey)
	for i=startPos,endPos do
		local data = snapshot[i]
		local _, scount, sminBid, sbuyout, _, _, _, _, _, _, sowner = _Unpack(data)
		if (player ~= sowner) then
			if (count == scount and minBid == sminBid and (buyout or 0) == (sbuyout or 0)) then
				table.remove(snapshot, i)
				table.insert(auctions, data)
				break;
			end
		end
	end
	if (#auctions > 0) then
   		_ArchiveAuctions(self, auctions, neutralAh)
   		_NotifyUpdate(self)
    end

end


--[[
	Registers the given callback function for being informed each time AuctionMaster updates
	it's internal statistics for an item. The callback function will be called with the
	arg parameter as first argument.
--]]
function vendor.Gatherer:RegisterStatisticCallback(func, arg)
	self.statCallbacks = self.statCallbacks or {}
	table.insert(self.statCallbacks, {func = func, arg = arg})
end

--[[
	Resets the snapshot for debugging.
--]]
function vendor.Gatherer:ResetSnapshot()
	self.db.realm.snapshot = {}
	self.db.factionrealm.snapshot = {}
	_ClearCaches(self)
end
