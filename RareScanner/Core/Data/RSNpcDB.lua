-----------------------------------------------------------------------
-- AddOn namespace.
-----------------------------------------------------------------------
local ADDON_NAME, private = ...

local RSNpcDB = private.NewLib("RareScannerNpcDB")

-- RareScanner database libraries
local RSMapDB = private.ImportLib("RareScannerMapDB")
local RSProfessionDB = private.ImportLib("RareScannerProfessionDB")

-- RareScanner libraries
local RSConstants = private.ImportLib("RareScannerConstants")
local RSLogger = private.ImportLib("RareScannerLogger")
local RSUtils = private.ImportLib("RareScannerUtils")
local RSTooltipScanners = private.ImportLib("RareScannerTooltipScanners")
local RSTimeUtils = private.ImportLib("RareScannerTimeUtils")

---============================================================================
-- Killed NPCs database
---============================================================================

function RSNpcDB.InitNpcKilledDB()
	if (not private.dbchar.rares_killed) then
		private.dbchar.rares_killed = {}
	end
end

function RSNpcDB.IsNpcKilled(npcID)
	if (npcID and private.dbchar.rares_killed[npcID]) then
		return true;
	end

	return false
end

function RSNpcDB.GetAllNpcsKilledRespawnTimes()
	return private.dbchar.rares_killed
end

function RSNpcDB.GetNpcKilledRespawnTime(npcID)
	if (RSNpcDB.IsNpcKilled(npcID)) then
		return private.dbchar.rares_killed[npcID]
	end

	return 0
end

function RSNpcDB.SetNpcKilled(npcID, respawnTime)
	if (npcID) then
		if (not respawnTime) then
			private.dbchar.rares_killed[npcID] = RSConstants.ETERNAL_DEATH
		else
			private.dbchar.rares_killed[npcID] = respawnTime
		end
		
		if (RSConstants.DEBUG_MODE) then
			local npcInfo = RSNpcDB.GetInternalNpcInfo(npcID)
			if (npcInfo and npcInfo.questID) then
				for _, id in ipairs(npcInfo.questID) do
					RSLogger:PrintDebugMessage(string.format("SetNpcKilled[%s]: Con questID [%s]", npcID, id))
				end
			end
		end
	end
end

function RSNpcDB.DeleteNpcKilled(npcID)
	if (npcID) then
		private.dbchar.rares_killed[npcID] = nil
	end
end

---============================================================================
-- Custom NPC database
----- Stores custom NPCs information
---============================================================================

function RSNpcDB.InitCustomNpcDB()
	if (not private.dbglobal.custom_npcs) then
		private.dbglobal.custom_npcs = {}
	end
	if (not private.dbglobal.custom_npcs_groups) then
		private.dbglobal.custom_npcs_groups = {}
	end
end

function RSNpcDB.GetAllCustomNpcInfo()
	return private.dbglobal.custom_npcs
end

function RSNpcDB.GetCustomNpcInfo(npcID)
	if (npcID) then
		return private.dbglobal.custom_npcs[npcID]
	end

	return nil
end

function RSNpcDB.SetCustomNpcInfo(npcID, info)
	if (not npcID or not info or not info.zones or next(info.zones) == nil) then
		RSLogger:PrintDebugMessage(string.format("SetCustomNpcInfo[%s]: Ignorado por no tener todos los datos rellenos", npcID))
		return
	end
	
	local zones = {}
	local completedZonesCounter = 0
	for zoneID, _ in pairs (info.zones) do
		if (info.coordinates and info.coordinates[zoneID] and info.coordinates[zoneID] ~= "") then
			local mapID = tonumber(zoneID)
			zones[mapID] = {}
			zones[mapID].artID = { C_Map.GetMapArtID(mapID) }
			zones[mapID].overlay = {}
			
			local index = 1
			for coordinatePair in string.gmatch(info.coordinates[zoneID], '([^,]+)') do
				local coordx, coordy = 	strsplit("-", coordinatePair, 2)
				if (index == 1) then
					zones[mapID].x = coordx
					zones[mapID].y = coordy
				end
				
				index = index + 1
				table.insert(zones[mapID].overlay, string.format("%s-%s", coordx, coordy))
			end
			
			completedZonesCounter = completedZonesCounter + 1
		else
			local mapID = tonumber(zoneID)
			zones[mapID] = {}			
			completedZonesCounter = completedZonesCounter + 1
		end
	end
	
	local npcIDnumber = tonumber(npcID)
	private.dbglobal.custom_npcs[npcIDnumber] = {}
	private.dbglobal.custom_npcs[npcIDnumber].displayID = tonumber(info.displayID or "0")
	private.dbglobal.custom_npcs[npcIDnumber].reset = true
	private.dbglobal.custom_npcs[npcIDnumber].noVignette = true
	private.dbglobal.custom_npcs[npcIDnumber].group = info.group
	private.dbglobal.custom_npcs[npcIDnumber].custom = true
	
	-- If it spawns in several zones
	if (completedZonesCounter > 1) then
		private.dbglobal.custom_npcs[npcIDnumber].zoneID = zones
		
		for mapID, zoneInfo in pairs (zones) do
			local artID = ""
			if (type(zoneInfo.artID) == "table") then
				artID = unpack(zoneInfo.artID)
			else
				artID = zoneInfo.artID
			end
			RSLogger:PrintDebugMessage(string.format("SetCustomNpcInfo[%s]: %s", npcIDnumber, string.format("zoneID:%s,artID:%s,x:%s,y:%s,displayID:%s", mapID or "", artID or "", zoneInfo.x or "", zoneInfo.y or "", private.dbglobal.custom_npcs[npcIDnumber].displayID or "")))
		end
	-- If it spawns in one zone
	else
		for mapID, zoneInfo in pairs (zones) do
			private.dbglobal.custom_npcs[npcIDnumber].zoneID = mapID
			private.dbglobal.custom_npcs[npcIDnumber].artID = zoneInfo.artID
			private.dbglobal.custom_npcs[npcIDnumber].x = zoneInfo.x
			private.dbglobal.custom_npcs[npcIDnumber].y = zoneInfo.y
			private.dbglobal.custom_npcs[npcIDnumber].overlay = zoneInfo.overlay
		end
		
		RSLogger:PrintDebugMessage(string.format("SetCustomNpcInfo[%s]: %s", npcIDnumber, string.format("zoneID:%s,artID:%s,x:%s,y:%s,displayID:%s", private.dbglobal.custom_npcs[npcIDnumber].zoneID or "", ((type(private.dbglobal.custom_npcs[npcIDnumber].artID) == "table" and unpack(private.dbglobal.custom_npcs[npcIDnumber].artID)) or private.dbglobal.custom_npcs[npcIDnumber].artID or "") or "", private.dbglobal.custom_npcs[npcIDnumber].x or "", private.dbglobal.custom_npcs[npcIDnumber].y or "", private.dbglobal.custom_npcs[npcIDnumber].displayID or "")))
	end
	
	-- Merge internal database with custom
	private.NPC_INFO[npcIDnumber] = private.dbglobal.custom_npcs[npcIDnumber]
	
	-- Just in case is tagged as dead for whatever reason
	RSNpcDB.DeleteNpcKilled(npcIDnumber)
end

function RSNpcDB.SetCustomNpcGroup(npcID, group)
	if (npcID and group) then
		local npcIDnumber = tonumber(npcID)
		private.dbglobal.custom_npcs[npcIDnumber].group = group
	end
end

function RSNpcDB.DeleteCustomNpcInfo(npcID)
	if (not npcID) then
		return
	end
	
	private.dbglobal.custom_npcs[tonumber(npcID)] = nil
	private.NPC_INFO[tonumber(npcID)] = nil
	private.dbglobal.rares_found[tonumber(npcID)] = nil
	
	RSNpcDB.DeleteCustomNpcLoot(npcID)
end

function RSNpcDB.DeleteCustomNpcZone(npcID, zoneID)
	if (not npcID or not zoneID) then
		return false
	end
	
	local npcIDnumber = tonumber(npcID)
	local mapID = tonumber(zoneID)
	
	if (not private.dbglobal.custom_npcs[npcIDnumber]) then
		return false
	else
		-- If it has multiple zones
		if (type(private.dbglobal.custom_npcs[npcIDnumber].zoneID) == "table") then
			private.dbglobal.custom_npcs[npcIDnumber].zoneID[mapID] = nil
			
			-- If after removing it only contains one zone, transform to unimap
			if (RSUtils.GetTableLength(private.dbglobal.custom_npcs[npcIDnumber].zoneID) == 1) then
				for lastMapID, zoneInfo in pairs (private.dbglobal.custom_npcs[npcIDnumber].zoneID) do
					private.dbglobal.custom_npcs[npcIDnumber].zoneID = lastMapID
					private.dbglobal.custom_npcs[npcIDnumber].artID = zoneInfo.artID
					private.dbglobal.custom_npcs[npcIDnumber].x = zoneInfo.x
					private.dbglobal.custom_npcs[npcIDnumber].y = zoneInfo.y
					private.dbglobal.custom_npcs[npcIDnumber].overlay = zoneInfo.overlay
					
					-- Merge internal database with custom
					private.NPC_INFO[npcIDnumber] = private.dbglobal.custom_npcs[npcIDnumber]
					
					RSLogger:PrintDebugMessage(string.format("RSNpcDB.DeleteCustomNpcZone[%s]: Eliminada zona %s", npcIDnumber, mapID))
					return false
				end
			end
		-- If it has only one zone then remove it from the NPC custom database
		else
			RSNpcDB.DeleteCustomNpcInfo(npcID)
			RSLogger:PrintDebugMessage(string.format("RSNpcDB.DeleteCustomNpcZone[%s]: Eliminado NPC por no contener mas zonas", npcIDnumber))
			return true
		end
	end
end

function RSNpcDB.GetCustomNpcGroups()
	return private.dbglobal.custom_npcs_groups
end

function RSNpcDB.AddCustomNpcGroup(value)
	if (value) then
		local key = 1
		if (RSUtils.GetTableLength(private.dbglobal.custom_npcs_groups) > 0) then
			local keys = {}
			for k, _ in pairs (private.dbglobal.custom_npcs_groups) do
				tinsert(keys, k)
			end
			
			key = math.max(unpack(keys)) + 1
		end
		
		private.dbglobal.custom_npcs_groups[key] = value
		return key
	end
end

function RSNpcDB.DeleteCustomNpcGroup(key)
	if (key) then
		private.dbglobal.custom_npcs_groups[key] = nil
	end
end

function RSNpcDB.GetCustomNpcGroupByKey(key)
	return private.dbglobal.custom_npcs_groups[key]
end

function RSNpcDB.SetCustomNpcGroupByKey(key, value)
	if (key and value) then
		private.dbglobal.custom_npcs_groups[key] = value
	end
end

function RSNpcDB.GetCustomNpcGroupByValue(value)
	if (value) then
		for key, val in pairs (private.dbglobal.custom_npcs_groups) do
			if (string.upper(val) == string.upper(value)) then
				return key
			end
		end
	end
end

function RSNpcDB.GetCustomGroupsByMapID(mapID)
	local groups = {}
	for npcID, npcInfo in pairs(RSNpcDB.GetAllCustomNpcInfo()) do
		if (RSNpcDB.IsInternalNpcMultiZone(npcID)) then
			-- First check if there is a matching mapID in the database
			for internalMapID, _ in pairs (npcInfo.zoneID) do
				if (internalMapID == mapID and not RSUtils.Contains(groups, npcInfo.group)) then
					tinsert(groups,npcInfo.group)
				end
			end
			
			-- Then check if there is a matching subMapID in the database
			for internalMapID, _ in pairs (npcInfo.zoneID) do
				if (RSMapDB.IsMapInParentMap(mapID, internalMapID) and not RSUtils.Contains(groups, npcInfo.group)) then
					tinsert(groups,npcInfo.group)
				end
			end
		elseif (RSNpcDB.IsInternalNpcMonoZone(npcID)) then
			if (npcInfo.zoneID == mapID and not RSUtils.Contains(groups, npcInfo.group)) then
				tinsert(groups,npcInfo.group)
			end
		end
	end
	
	return groups
end

function RSNpcDB.IsCustomNpcInGroup(npcID, group)
	if (not group or not npcID) then
		return false
	end
	
	local npcInfo = RSNpcDB.GetInternalNpcInfo(npcID)
	if (not npcInfo) then
		return false
	elseif (not npcInfo.group) then
		return false
	elseif (npcInfo.group == group) then
		return true
	end
	
	return false
end

---============================================================================
-- NPC internal database (included with the addon and custom NPCs)
----- Stores NPCs information included with the addon and custom NPCs
---============================================================================

local internalNpcsMerged = false
function RSNpcDB.GetAllInternalNpcInfo()
	-- Merge internal database with custom
	if (not internalNpcsMerged) then
		for npcID, customNpcID in pairs(RSNpcDB.GetAllCustomNpcInfo()) do
			private.NPC_INFO[npcID] = customNpcID
		end
		internalNpcsMerged = true
		RSLogger:PrintDebugMessage("GetAllInternalNpcInfo: Mezclada la tabla de NPCs internos con la de personalizados.")
	end
	
	return private.NPC_INFO
end

function RSNpcDB.GetNpcIDsByMapID(mapID, onlyCustom, onlyWithoutVignette)
	local npcIDs = {}
	for npcID, npcInfo in pairs((onlyCustom and RSNpcDB.GetAllCustomNpcInfo() or RSNpcDB.GetAllInternalNpcInfo())) do
		if (RSNpcDB.IsInternalNpcMultiZone(npcID)) then
			-- First check if there is a matching mapID in the database
			for internalMapID, _ in pairs (npcInfo.zoneID) do
				if (internalMapID == mapID) then
					if (not onlyWithoutVignette) then
						tinsert(npcIDs,npcID)
					elseif (npcInfo.noVignette == nil or npcInfo.noVignette) then
						tinsert(npcIDs,npcID)
					end
				end
			end
			
			-- Then check if there is a matching subMapID in the database
			for internalMapID, _ in pairs (npcInfo.zoneID) do
				if (RSMapDB.IsMapInParentMap(mapID, internalMapID)) then
					if (not onlyWithoutVignette) then
						tinsert(npcIDs,npcID)
					elseif (npcInfo.noVignette == nil or npcInfo.noVignette) then
						tinsert(npcIDs,npcID)
					end
				end
			end
		elseif (RSNpcDB.IsInternalNpcMonoZone(npcID)) then
			if (npcInfo.zoneID == mapID) then
				if (not onlyWithoutVignette) then
					tinsert(npcIDs,npcID)
				elseif (npcInfo.noVignette == nil or npcInfo.noVignette) then
					tinsert(npcIDs,npcID)
				end
			end
			
			-- Then check if there is a matching subMapID in the database
			if (RSMapDB.IsMapInParentMap(mapID, npcInfo.zoneID)) then
				if (not onlyWithoutVignette) then
					tinsert(npcIDs,npcID)
				elseif (npcInfo.noVignette == nil or npcInfo.noVignette) then
					tinsert(npcIDs,npcID)
				end
			end
		end
	end
	
	return npcIDs
end

function RSNpcDB.GetInternalNpcInfo(npcID)
	if (npcID) then
		return private.NPC_INFO[npcID]
	end

	return nil
end

function RSNpcDB.GetInternalNpcInfoByMapID(npcID, mapID)
	if (npcID and mapID) then
		if (RSNpcDB.IsInternalNpcMultiZone(npcID)) then
			-- First check if there is a matching mapID in the database
			for internalMapID, zoneInfo in pairs (RSNpcDB.GetInternalNpcInfo(npcID).zoneID) do
				if (internalMapID == mapID) then
					local npcInfo = {}
					RSUtils.CloneTable(RSNpcDB.GetInternalNpcInfo(npcID), npcInfo)
					npcInfo.zoneID = internalMapID
					npcInfo.x = zoneInfo.x
					npcInfo.y = zoneInfo.y
					npcInfo.artID = zoneInfo.artID
					npcInfo.overlay = zoneInfo.overlay
					return npcInfo
				end
			end
			
			-- Then check if there is a matching subMapID in the database
			for internalMapID, zoneInfo in pairs (RSNpcDB.GetInternalNpcInfo(npcID).zoneID) do
				if (RSMapDB.IsMapInParentMap(mapID, internalMapID)) then
					local npcInfo = {}
					RSUtils.CloneTable(RSNpcDB.GetInternalNpcInfo(npcID), npcInfo)
					npcInfo.zoneID = internalMapID
					npcInfo.x = zoneInfo.x
					npcInfo.y = zoneInfo.y
					npcInfo.artID = zoneInfo.artID
					npcInfo.overlay = zoneInfo.overlay
					return npcInfo
				end
			end
		elseif (RSNpcDB.IsInternalNpcMonoZone(npcID)) then
			local npcInfo = RSNpcDB.GetInternalNpcInfo(npcID)
			if (npcInfo and npcInfo.zoneID == mapID) then
				return npcInfo
			end
		end
	end

	return nil
end

function RSNpcDB.GetInternalNpcArtID(npcID, mapID)
	if (npcID and mapID) then
		local npcInfo = RSNpcDB.GetInternalNpcInfoByMapID(npcID, mapID)
		if (npcInfo) then
			return npcInfo.artID
		end
	end

	return nil
end

function RSNpcDB.GetInternalNpcCoordinates(npcID, mapID)
	if (npcID and mapID) then
		local npcInfo = RSNpcDB.GetInternalNpcInfoByMapID(npcID, mapID)
		if (npcInfo and npcInfo.x and npcInfo.y) then
			if (npcInfo.custom) then
				return RSUtils.FixCoord(npcInfo.x), RSUtils.FixCoord(npcInfo.y)
			end
			
			return RSUtils.FixCoord(RSUtils.Lpad(npcInfo.x, 4, '0')), RSUtils.FixCoord(RSUtils.Lpad(npcInfo.y, 4, '0'))
		end
	end

	return nil
end

function RSNpcDB.GetBestInternalNpcCoordinates(npcID, mapID)
	-- Locates players coordinates based in the mapID where it was found
	local playerMapPosition = C_Map.GetPlayerMapPosition(mapID, "player")
	local playerx, playery
	if (playerMapPosition) then
		playerx, playery = playerMapPosition:GetXY()
		
		-- Locates players coordinates based in the best map
		if (not playerx or not playery) then
			local playerMapID = C_Map.GetBestMapForUnit("player")
			playerMapPosition = C_Map.GetPlayerMapPosition(playerMapID, "player")
			if (playerMapPosition) then
				playerx, playery = playerMapPosition:GetXY()
				mapID = playerMapID
			end
		end
	end
	
	-- Locates closest NPC coordinates to the players
	if (playerx and playery) then
		local overlay = RSNpcDB.GetInternalNpcOverlay(npcID, mapID)
		if (overlay) then
			local distances = {}
			local coords = {}
			for _, coordinates in ipairs (overlay) do
				local xo, yo = strsplit("-", coordinates)
				local distance = RSUtils.DistanceBetweenCoords(playerx, RSUtils.FixCoord(xo), playery, RSUtils.FixCoord(yo));
				if (distance >= 0 and distance <= 0.02) then
					tinsert(distances, distance)
					coords[distance] = {}
					coords[distance].x = xo
					coords[distance].y = yo
				end
			end
			
			-- Get the smallest
			if (RSUtils.GetTableLength(distances) > 0) then
				local minDistance = min(unpack(distances))
				return coords[minDistance].x, coords[minDistance].y
			end
		end
	end
	
	-- Locates internal coordinates
	local x, y = RSNpcDB.GetInternalNpcCoordinates(npcID, mapID)
	if (x and y) then
		return x, y
	-- Otherwise returns players coordinates
	else
		return playerx, playery
	end
end

function RSNpcDB.GetInternalNpcOverlay(npcID, mapID)
	if (npcID and mapID) then
		local npcInfo = RSNpcDB.GetInternalNpcInfoByMapID(npcID, mapID)
		if (npcInfo) then
			return npcInfo.overlay
		end
	end

	return nil
end

function RSNpcDB.IsInternalNpcMultiZone(npcID)
	local npcInfo = RSNpcDB.GetInternalNpcInfo(npcID)
	return npcInfo and type(npcInfo.zoneID) == "table"
end

function RSNpcDB.IsInternalNpcMonoZone(npcID)
	local npcInfo = RSNpcDB.GetInternalNpcInfo(npcID)
	return npcInfo and type(npcInfo.zoneID) ~= "table"
end

function RSNpcDB.IsInternalNpcInMap(npcID, mapID, checkSubzones, ignoreAtlas)
	if (npcID and mapID) then
		if (RSNpcDB.IsInternalNpcMultiZone(npcID)) then
			for internalMapID, internalNpcInfo in pairs(RSNpcDB.GetInternalNpcInfo(npcID).zoneID) do
				if (internalMapID == mapID and (ignoreAtlas or not internalNpcInfo.artID or RSUtils.Contains(internalNpcInfo.artID, C_Map.GetMapArtID(mapID)))) then
					return true;
				elseif (checkSubzones and RSMapDB.IsMapInParentMap(mapID, internalMapID)) then
					return true;
				end
			end
		elseif (RSNpcDB.IsInternalNpcMonoZone(npcID)) then
			local npcInfo = RSNpcDB.GetInternalNpcInfo(npcID)
			if (npcInfo.zoneID == mapID and (ignoreAtlas or not npcInfo.artID or RSUtils.Contains(npcInfo.artID, C_Map.GetMapArtID(mapID)))) then
				return true;
			elseif (checkSubzones and RSMapDB.IsMapInParentMap(mapID, npcInfo.zoneID)) then
				return true;
			end
		end
	end

	return false;
end

function RSNpcDB.IsInternalNpcFriendly(npcID)
	if (npcID and RSNpcDB.GetInternalNpcInfo(npcID)) then
		local faction, _ = UnitFactionGroup("player")
		if (RSUtils.Contains(RSNpcDB.GetInternalNpcInfo(npcID).friendly, string.sub(faction, 1, 1))) then
			return true
		end
	end

	return false
end

function RSNpcDB.IsWorldMap(npcID)
	if (npcID) then
		local npcInfo = RSNpcDB.GetInternalNpcInfo(npcID)
		return npcInfo and npcInfo.worldmap
	end
	
	return false
end

function RSNpcDB.IsDisabledEvent(npcID)
	if (npcID) then
		local npcInfo = RSNpcDB.GetInternalNpcInfo(npcID)
		return npcInfo and npcInfo.event and not RSTimeUtils.IsHolidayEventActive(npcInfo.event)
	end
	
	return false
end

---============================================================================
-- NPC Loot internal database
----- Stores NPC loot included with the addon
---============================================================================

function RSNpcDB.GetAllInteralNpcLoot()
	local internalNpcLoot = private.NPC_LOOT
	local customNpcLoot = RSNpcDB.GetAllCustomNpcLoot()
	if (customNpcLoot) then
		for npcID, items in pairs(customNpcLoot) do
			internalNpcLoot[npcID] = items
		end
	end
	
	return internalNpcLoot
end

function RSNpcDB.GetInteralNpcLoot(npcID)
	if (npcID) then
		return private.NPC_LOOT[npcID]
	end

	return nil
end

function RSNpcDB.GetNpcLoot(npcID)
	if (npcID) then
		RSLogger:PrintDebugMessageEntityID(npcID, string.format("NPC [%s]: Obeniendo su loot.", npcID))
		return RSUtils.JoinTables(RSUtils.JoinTables(private.NPC_LOOT[npcID], RSNpcDB.GetNpcLootFound(npcID)), RSNpcDB.GetCustomNpcLoot(npcID))
	end

	return nil
end

---============================================================================
-- Custom NPC loot database
----- Stores custom NPC loot
---============================================================================

function RSNpcDB.GetAllCustomNpcLoot()
	return private.dbglobal.custom_loot
end

function RSNpcDB.GetCustomNpcLoot(npcID)
	if (npcID and private.dbglobal.custom_loot) then
		return private.dbglobal.custom_loot[npcID]
	end

	return nil
end

function RSNpcDB.SetCustomNpcLoot(npcID, loot)
	if (not private.dbglobal.custom_loot) then
		private.dbglobal.custom_loot = {}
	end
	
	private.dbglobal.custom_loot[tonumber(npcID)] = loot
	RSLogger:PrintDebugMessage(string.format("RSNpcDB.SetCustomNpcLoot[%s]: Añadido loot", npcID))
end

function RSNpcDB.DeleteCustomNpcLoot(npcID)
	if (npcID and private.dbglobal.custom_loot) then
		private.dbglobal.custom_loot[tonumber(npcID)] = nil
		RSLogger:PrintDebugMessage(string.format("RSNpcDB.DeleteCustomNpcLoot[%s]: Eliminado loot", npcID))
	end
end

---============================================================================
-- NPC Loot database
----- Stores NPC loot found while playing
---============================================================================

function RSNpcDB.InitNpcLootFoundDB()
	if (not private.dbglobal.rares_loot) then
		private.dbglobal.rares_loot = {}
	end
end

function RSNpcDB.GetAllNpcsLootFound()
	return private.dbglobal.rares_loot
end

function RSNpcDB.GetNpcLootFound(npcID)
	if (npcID and private.dbglobal.rares_loot[containerID]) then
		return private.dbglobal.rares_loot[npcID]
	end

	return nil
end

function RSNpcDB.SetNpcLootFound(npcID, loot)
	if (npcID and loot) then
		private.dbglobal.rares_loot[npcID] = loot
	end
end

function RSNpcDB.AddItemToNpcLootFound(npcID, itemID)
	if (npcID and itemID) then
		if (not private.dbglobal.rares_loot[npcID]) then
			private.dbglobal.rares_loot[npcID] = {}
		end

		-- If its in the internal database ignore it
		local internalLoot = RSNpcDB.GetInteralNpcLoot(npcID)
		if (internalLoot and RSUtils.Contains(internalLoot, itemID)) then
			return
		end

		-- If its not in the loot found DB adds it
		if (not RSUtils.Contains(private.dbglobal.rares_loot[npcID], itemID)) then
			tinsert(private.dbglobal.rares_loot[npcID], itemID)
			RSLogger:PrintDebugMessage(string.format("AddItemToNpcLootFound[%s]: Añadido nuevo loot [%s]", npcID, itemID))
		end
	end
end

function RSNpcDB.RemoveNpcLootFound(npcID)
	if (npcID) then
		private.dbglobal.rares_loot[npcID] = nil
	end
end

---============================================================================
-- NPC quest IDs database
----- Stores NPC hidden quest IDs
---============================================================================

function RSNpcDB.InitNpcQuestIdFoundDB()
	if (RSConstants.DEBUG_MODE and not private.dbglobal.npc_quest_ids) then
		private.dbglobal.npc_quest_ids = {}
	end
end

function RSNpcDB.ResetNpcQuestIdFoundDB()
	if (private.dbglobal.npc_quest_ids) then
		if (RSConstants.DEBUG_MODE) then
			private.dbglobal.npc_quest_ids = {}
		else
			private.dbglobal.npc_quest_ids = nil
		end
	end
end

function RSNpcDB.SetNpcQuestIdFound(npcID, questID)
	if (npcID and questID) then
		private.dbglobal.npc_quest_ids[npcID] = { questID }
		RSLogger:PrintDebugMessage(string.format("NPC [%s]. Calculado questID [%s]", npcID, questID))
	end
end

function RSNpcDB.GetNpcQuestIdFound(npcID)
	if (npcID and private.dbglobal.npc_quest_ids[npcID]) then
		return private.dbglobal.npc_quest_ids[npcID]
	end

	return nil
end

function RSNpcDB.RemoveNpcQuestIdFound(npcID)
	if (npcID) then
		private.dbglobal.npc_quest_ids[npcID] = nil
	end
end

---============================================================================
-- NPC names database
----- Stores names of NPCs included with the addon
---============================================================================

function RSNpcDB.InitNpcNamesDB(reset)
	if (not private.dbglobal.rare_names) then
		private.dbglobal.rare_names = {}
	end

	if (not private.dbglobal.rare_names[GetLocale()] or reset) then
		private.dbglobal.rare_names[GetLocale()] = {}
	end
end

function RSNpcDB.GetAllNpcNames()
	return private.dbglobal.rare_names[GetLocale()]
end

function RSNpcDB.SetNpcName(npcID, name)
	if (npcID) then
		private.dbglobal.rare_names[GetLocale()][npcID] = name
	end
end

function RSNpcDB.GetNpcName(npcID, refresh)
	if (npcID) then
		if (private.dbglobal.rare_names[GetLocale()][npcID] and not refresh) then
			return private.dbglobal.rare_names[GetLocale()][npcID]
		else
			RSTooltipScanners.ScanNpcName(npcID)
		end
	end

	return nil
end

function RSNpcDB.GetActiveNpcIDsWithNamesByMapID(mapID)
	local npcIDs =  RSNpcDB.GetNpcIDsByMapID(mapID)
	local npcIDsWithNames = nil
	
	if (RSUtils.GetTableLength(npcIDs)) then
		npcIDsWithNames = {}
		for _, npcID in ipairs(npcIDs) do
			local npcInfo = RSNpcDB.GetInternalNpcInfo(npcID)
			if (npcInfo and npcInfo.prof and not RSProfessionDB.HasPlayerProfession(npcInfo.prof)) then
				-- Wrong profession
			elseif (RSNpcDB.IsDisabledEvent(npcID)) then
				-- World event disabled
			else
				local npcName = RSNpcDB.GetNpcName(npcID)
				if (npcName) then
					npcIDsWithNames[npcID] = string.format("%s (%s)", npcName, npcID)
				else
					npcIDsWithNames[npcID] = tostring(npcID)
				end
			end
		end
		
		return npcIDsWithNames
	end
	
	return npcIDsWithNames
end

function RSNpcDB.GetNpcId(name, mapID)
	if (name and mapID) then
		for npcID, npcName in pairs(RSNpcDB.GetAllNpcNames()) do
			if (RSUtils.Contains(npcName, name) and RSNpcDB.IsInternalNpcInMap(npcID, mapID, true)) then
				return npcID;
			end
		end
	end
	
	return nil
end

---============================================================================
-- NPCs with multi spawn spots
---============================================================================

function RSNpcDB.IsMultiZoneSpawn(npcID)
	if (RSUtils.Contains(RSConstants.NPCS_WITH_MULTIPLE_SPAWNS, npcID)) then
		return true
	elseif (RSNpcDB.GetCustomNpcInfo(npcID)) then
		return true
	end
	
	return false
end

---============================================================================
-- NPCs with pre-events
----- Obtains the latest npcID in a chain of pre-events
---============================================================================

function RSNpcDB.GetFinalNpcID(npcPreEventID)
	local npcID = tonumber(npcPreEventID)
	
	-- NPC with pre-event
	while (RSConstants.NPCS_WITH_PRE_EVENT[npcID]) do
		npcID = RSConstants.NPCS_WITH_PRE_EVENT[npcID]
	end
	
	return npcID
end