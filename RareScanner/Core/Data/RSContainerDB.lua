-- AddOn namespace.
-----------------------------------------------------------------------
local ADDON_NAME, private = ...
local LibStub = _G.LibStub

local RSContainerDB = private.NewLib("RareScannerContainerDB")

-- RareScanner database libraries
local RSMapDB = private.ImportLib("RareScannerMapDB")
local RSProfessionDB = private.ImportLib("RareScannerProfessionDB")

-- Locales
local AL = LibStub("AceLocale-3.0"):GetLocale("RareScanner");

-- RareScanner libraries
local RSLogger = private.ImportLib("RareScannerLogger")
local RSUtils = private.ImportLib("RareScannerUtils")
local RSConstants = private.ImportLib("RareScannerConstants")
local RSTimeUtils = private.ImportLib("RareScannerTimeUtils")

---============================================================================
-- Opened containers database
---============================================================================

function RSContainerDB.InitContainerOpenedDB()
	if (not private.dbchar.containers_opened) then
		private.dbchar.containers_opened = {}
	end
end

function RSContainerDB.GetAllContainersOpenedRespawnTimes()
	return private.dbchar.containers_opened
end

function RSContainerDB.IsContainerOpened(containerID)
	if (containerID and private.dbchar.containers_opened[containerID]) then
		return true;
	end

	return false
end

function RSContainerDB.GetContainerOpenedRespawnTime(containerID)
	if (RSContainerDB.IsContainerOpened(containerID)) then
		return private.dbchar.containers_opened[containerID]
	end

	return 0
end

function RSContainerDB.SetContainerOpened(containerID, respawnTime)
	if (containerID) then
		if (not respawnTime) then
			private.dbchar.containers_opened[containerID] = RSConstants.ETERNAL_OPENED
		else
			private.dbchar.containers_opened[containerID] = respawnTime
		end
	end
end

function RSContainerDB.DeleteContainerOpened(containerID)
	if (containerID) then
		private.dbchar.containers_opened[containerID] = nil
	end
end

---============================================================================
-- Container internal database
----- Stores containers information included with the addon
---============================================================================

function RSContainerDB.GetAllInternalContainerInfo()
	return private.CONTAINER_INFO
end

function RSContainerDB.GetContainerIDsByMapID(mapID)
	local containerIDs = {}
	for containerID, containerInfo in pairs(RSContainerDB.GetAllInternalContainerInfo()) do
		if (RSContainerDB.IsInternalContainerMultiZone(containerID)) then
			-- First check if there is a matching mapID in the database
			for internalMapID, _ in pairs (containerInfo.zoneID) do
				if (internalMapID == mapID) then
					tinsert(containerIDs,containerID)
				end
			end
			
			-- Then check if there is a matching subMapID in the database
			for internalMapID, _ in pairs (containerInfo.zoneID) do
				if (RSMapDB.IsMapInParentMap(mapID, internalMapID)) then
					tinsert(containerIDs,containerID)
				end
			end
		elseif (RSContainerDB.IsInternalContainerMonoZone(containerID)) then
			if (containerInfo.zoneID == mapID or (containerInfo.noVignette and containerInfo.zoneID == 0)) then
				tinsert(containerIDs,containerID)
			end
		end
	end
	
	return containerIDs
end

function RSContainerDB.GetInternalContainerInfo(containerID)
	if (containerID) then
		return private.CONTAINER_INFO[containerID]
	end

	return nil
end

function RSContainerDB.GetInternalContainerInfoByMapID(containerID, mapID)
	if (containerID and mapID) then
		if (RSContainerDB.IsInternalContainerMultiZone(containerID)) then
			for internalMapID, zoneInfo in pairs (RSContainerDB.GetInternalContainerInfo(containerID).zoneID) do
				if (internalMapID == mapID) then
					local containerInfo = {}
					RSUtils.CloneTable(RSContainerDB.GetInternalContainerInfo(containerID), containerInfo)
					containerInfo.zoneID = internalMapID
					containerInfo.x = zoneInfo.x
					containerInfo.y = zoneInfo.y
					containerInfo.artID = zoneInfo.artID
					containerInfo.overlay = zoneInfo.overlay
					return containerInfo
				end
			end
			
			-- Then check if there is a matching subMapID in the database
			for internalMapID, zoneInfo in pairs (RSContainerDB.GetInternalContainerInfo(containerID).zoneID) do
				if (RSMapDB.IsMapInParentMap(mapID, internalMapID)) then
					local containerInfo = {}
					RSUtils.CloneTable(RSContainerDB.GetInternalContainerInfo(containerID), containerInfo)
					containerInfo.zoneID = internalMapID
					containerInfo.x = zoneInfo.x
					containerInfo.y = zoneInfo.y
					containerInfo.artID = zoneInfo.artID
					containerInfo.overlay = zoneInfo.overlay
					return containerInfo
				end
			end
		elseif (RSContainerDB.IsInternalContainerMonoZone(containerID)) then
			local containerInfo = RSContainerDB.GetInternalContainerInfo(containerID)
			return containerInfo
		end
	end

	return nil
end

function RSContainerDB.GetInternalContainerArtID(containerID, mapID)
	if (containerID and mapID) then
		local containerInfo = RSContainerDB.GetInternalContainerInfoByMapID(containerID, mapID)
		if (containerInfo) then
			return containerInfo.artID
		end
	end

	return nil
end

function RSContainerDB.GetInternalContainerCoordinates(containerID, mapID)
	if (containerID and mapID) then
		local containerInfo = RSContainerDB.GetInternalContainerInfoByMapID(containerID, mapID)
		if (containerInfo) then
			return RSUtils.FixCoord(containerInfo.x), RSUtils.FixCoord(containerInfo.y)
		end
	end

	return nil
end

function RSContainerDB.GetInternalContainerOverlay(containerID, mapID)
	if (containerID and mapID) then
		local containerInfo = RSContainerDB.GetInternalContainerInfoByMapID(containerID, mapID)
		if (containerInfo) then
			return containerInfo.overlay
		end
	end

	return nil
end

function RSContainerDB.IsInternalContainerMultiZone(containerID)
	local containerInfo = RSContainerDB.GetInternalContainerInfo(containerID)
	return containerInfo and type(containerInfo.zoneID) == "table"
end

function RSContainerDB.IsInternalContainerMonoZone(containerID)
	local containerInfo = RSContainerDB.GetInternalContainerInfo(containerID)
	return containerInfo and type(containerInfo.zoneID) ~= "table"
end

function RSContainerDB.IsInternalContainerInMap(containerID, mapID, checkSubzones, ignoreAtlas)
	if (containerID and mapID) then
		if (RSContainerDB.IsInternalContainerMultiZone(containerID)) then
			for internalMapID, internalContainerInfo in pairs(RSContainerDB.GetInternalContainerInfo(containerID).zoneID) do
				if (internalMapID == mapID and (ignoreAtlas or not internalContainerInfo.artID or RSUtils.Contains(internalContainerInfo.artID, C_Map.GetMapArtID(mapID)))) then
					return true;
				elseif (checkSubzones and RSMapDB.IsMapInParentMap(mapID, internalMapID)) then
					return true;
				end
			end
		elseif (RSContainerDB.IsInternalContainerMonoZone(containerID)) then
			local containerInfo = RSContainerDB.GetInternalContainerInfo(containerID)
			if (containerInfo.zoneID == mapID and (ignoreAtlas or not containerInfo.artID or RSUtils.Contains(containerInfo.artID, C_Map.GetMapArtID(mapID)))) then
				return true;
			elseif (checkSubzones and RSMapDB.IsMapInParentMap(mapID, containerInfo.zoneID)) then
				return true;
			end
		end
	end

	return false;
end

function RSContainerDB.IsWorldMap(containerID)
	if (containerID) then
		local containerInfo = RSContainerDB.GetInternalContainerInfo(containerID)
		return containerInfo and containerInfo.worldmap
	end
end

function RSContainerDB.IsDisabledEvent(containerID)
	if (containerID) then
		local containerInfo = RSContainerDB.GetInternalContainerInfo(containerID)
		return containerInfo and containerInfo.event and not RSTimeUtils.IsHolidayEventActive(containerInfo.event)
	end
	
	return false
end

---============================================================================
-- Container Loot internal database
----- Stores Container loot included with the addon
---============================================================================

function RSContainerDB.GetContainerLoot(containerID)
	if (containerID) then
		return RSUtils.JoinTables(RSContainerDB.GetInteralContainerLoot(containerID), RSContainerDB.GetContainerLootFound(containerID))
	end

	return nil
end

function RSContainerDB.GetAllInteralContainerLoot()
	return private.CONTAINER_LOOT
end

function RSContainerDB.GetInteralContainerLoot(containerID)
	if (containerID) then
		return RSContainerDB.GetAllInteralContainerLoot()[containerID]
	end

	return nil
end

---============================================================================
-- Container Loot database
----- Stores Container loot found while playing
---============================================================================

function RSContainerDB.InitContainerLootFoundDB()
	if (not private.dbglobal.containers_loot) then
		private.dbglobal.containers_loot = {}
	end
end

function RSContainerDB.GetAllContainersLootFound()
	return private.dbglobal.containers_loot
end

function RSContainerDB.GetContainerLootFound(containerID)
	if (containerID and private.dbglobal.containers_loot[containerID]) then
		return private.dbglobal.containers_loot[containerID]
	end

	return nil
end

function RSContainerDB.SetContainerLootFound(containerID, loot)
	if (containerID and loot) then
		private.dbglobal.containers_loot[containerID] = loot
	end
end

function RSContainerDB.AddItemToContainerLootFound(containerID, itemID)
	if (containerID and itemID) then
		if (not private.dbglobal.containers_loot[containerID]) then
			private.dbglobal.containers_loot[containerID] = {}
		end

		-- If its in the internal database ignore it
		local internalLoot = RSContainerDB.GetInteralContainerLoot(containerID)
		if (internalLoot and RSUtils.Contains(internalLoot, itemID)) then
			return
		end

		-- If its not in the loot found DB adds it
		if (not RSUtils.Contains(private.dbglobal.containers_loot[containerID], itemID)) then
			tinsert(private.dbglobal.containers_loot[containerID], itemID)
			RSLogger:PrintDebugMessage(string.format("AddItemToContainerLootFound[%s]: Añadido nuevo loot [%s]", containerID, itemID))
		end
	end
end

function RSContainerDB.RemoveContainerLootFound(containerID)
	if (containerID) then
		private.dbglobal.containers_loot[containerID] = nil
	end
end

---============================================================================
-- Container quest IDs database
----- Stores Containers hidden quest IDs
---============================================================================

function RSContainerDB.InitContainerQuestIdFoundDB()
	if (RSConstants.DEBUG_MODE and not private.dbglobal.container_quest_ids) then
		private.dbglobal.container_quest_ids = {}
	end
end

function RSContainerDB.ResetContainerQuestIdFoundDB()
	if (private.dbglobal.container_quest_ids) then
		if (RSConstants.DEBUG_MODE) then
			private.dbglobal.container_quest_ids = {}
		else
			private.dbglobal.container_quest_ids = nil
		end
	end
end

function RSContainerDB.SetContainerQuestIdFound(containerID, questID)
	if (containerID and questID) then
		private.dbglobal.container_quest_ids[containerID] = { questID }
		RSLogger:PrintDebugMessage(string.format("Contenedor [%s]. Calculado questID [%s]", containerID, questID))
	end
end

function RSContainerDB.GetContainerQuestIdFound(containerID)
	if (containerID and private.dbglobal.container_quest_ids[containerID]) then
		return private.dbglobal.container_quest_ids[containerID]
	end

	return nil
end

function RSContainerDB.RemoveContainerQuestIdFound(containerID)
	if (containerID) then
		private.dbglobal.container_quest_ids[containerID] = nil
	end
end

---============================================================================
-- Containers names database
----- Stores names of containers included with the addon
---============================================================================

function RSContainerDB.InitContainerNamesDB()
	if (not private.dbglobal.object_names) then
		private.dbglobal.object_names = {}
	end

	if (not private.dbglobal.object_names[GetLocale()]) then
		private.dbglobal.object_names[GetLocale()] = {}
	end
end

function RSContainerDB.GetAllContainerNames()
	return private.dbglobal.object_names[GetLocale()]
end

function RSContainerDB.SetContainerName(containerID, name)
	if (containerID and name) then
		private.dbglobal.object_names[GetLocale()][containerID] = name
	end
end

function RSContainerDB.GetContainerName(containerID)
	if (containerID) then
		if (private.dbglobal.object_names[GetLocale()][containerID] and private.dbglobal.object_names[GetLocale()][containerID] ~= AL["CONTAINER"]) then
			return private.dbglobal.object_names[GetLocale()][containerID]
		elseif (AL[string.format("CONTAINER_%s", containerID)] ~= string.format("CONTAINER_%s", containerID)) then
			return AL[string.format("CONTAINER_%s", containerID)]
		end
	end

	return nil
end

function RSContainerDB.GetActiveContainerIDsWithNamesByMapID(mapID)
	local containerIDs =  RSContainerDB.GetContainerIDsByMapID(mapID)
	local containerIDsWithNames = nil
	
	if (RSUtils.GetTableLength(containerIDs)) then
		containerIDsWithNames = {}
		for _, containerID in ipairs(containerIDs) do
			local containerInfo = RSContainerDB.GetInternalContainerInfo(containerID)
			if (containerInfo and containerInfo.prof and not RSProfessionDB.HasPlayerProfession(containerInfo.prof)) then
				-- Wrong profession
			elseif (RSContainerDB.IsDisabledEvent(containerID)) then
				-- World event disabled
			else
				local containerName = RSContainerDB.GetContainerName(containerID)
				if (containerName) then
					containerIDsWithNames[containerID] = string.format("%s (%s)", containerName, containerID)
				else
					containerIDsWithNames[containerID] = tostring(containerID)
				end
			end
		end
		
		return containerIDsWithNames
	end
	
	return containerIDsWithNames
end

---============================================================================
-- Reseteable containers database
---- Stores containers that in theory cannot be opened again, but that they are
---- detected again
---============================================================================

function RSContainerDB.InitReseteableContainersDB()
	if (not private.dbglobal.containers_reseteable) then
		private.dbglobal.containers_reseteable = {}
	end
end

function RSContainerDB.IsContainerReseteable(containerID)
	return containerID and private.dbglobal.containers_reseteable[containerID]
end

function RSContainerDB.SetContainerReseteable(containerID)
	if (containerID) then
		private.dbglobal.containers_reseteable[containerID] = true
	end
end

---============================================================================
-- Containers with multi spawn spots
---============================================================================

function RSContainerDB.IsMultiZoneSpawn(containerID)
	if (RSUtils.Contains(RSConstants.CONTAINERS_WITH_MULTIPLE_SPAWNS, containerID)) then
		return true
	end
	
	return false
end

---============================================================================
-- Containers with pre-events
----- Obtains the latest containerID in a chain of pre-events
---============================================================================

function RSContainerDB.GetFinalContainerID(containerPreEventID)
	local containerID = tonumber(containerPreEventID)
	
	-- Container with pre-event
	while (RSConstants.CONTAINERS_WITH_PRE_EVENT[containerID]) do
		containerID = RSConstants.CONTAINERS_WITH_PRE_EVENT[containerID]
	end
	
	return containerID
end