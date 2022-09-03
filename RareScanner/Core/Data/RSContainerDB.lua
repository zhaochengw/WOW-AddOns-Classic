-----------------------------------------------------------------------
-- AddOn namespace.
-----------------------------------------------------------------------
local ADDON_NAME, private = ...
local LibStub = _G.LibStub

local RSContainerDB = private.NewLib("RareScannerContainerDB")

-- Locales
local AL = LibStub("AceLocale-3.0"):GetLocale("RareScanner");

-- RareScanner libraries
local RSLogger = private.ImportLib("RareScannerLogger")
local RSUtils = private.ImportLib("RareScannerUtils")
local RSConstants = private.ImportLib("RareScannerConstants")

---============================================================================
-- Container internal database
----- Stores containers information included with the addon
---============================================================================

function RSContainerDB.GetAllInternalContainerInfo()
	return private.CONTAINER_INFO
end

function RSContainerDB.GetInternalContainerInfo(containerID)
	if (containerID) then
		return private.CONTAINER_INFO[containerID]
	end

	return nil
end



local function GetInternalContainerInfoByMapID(containerID, mapID)
	if (containerID and mapID) then
		if (RSContainerDB.IsInternalContainerMultiZone(containerID)) then
			for internalMapID, containerInfo in pairs (RSContainerDB.GetInternalContainerInfo(containerID).zoneID) do
				if (internalMapID == mapID) then
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
		local containerInfo = GetInternalContainerInfoByMapID(containerID, mapID)
		if (containerInfo) then
			return containerInfo.artID
		end
	end

	return nil
end

function RSContainerDB.GetInternalContainerCoordinates(containerID, mapID)
	if (containerID and mapID) then
		local containerInfo = GetInternalContainerInfoByMapID(containerID, mapID)
		if (containerInfo) then
			return RSUtils.Lpad(containerInfo.x, 4, '0'), RSUtils.Lpad(containerInfo.y, 4, '0')
		end
	end

	return nil
end

function RSContainerDB.GetInternalContainerOverlay(containerID, mapID)
	if (containerID and mapID) then
		local containerInfo = GetInternalContainerInfoByMapID(containerID, mapID)
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

function RSContainerDB.IsInternalContainerInMap(containerID, mapID)
	if (containerID and mapID) then
		if (RSContainerDB.IsInternalContainerMultiZone(containerID)) then
			for internalMapID, internalContainerInfo in pairs(RSContainerDB.GetInternalContainerInfo(containerID).zoneID) do
				if (internalMapID == mapID and (not internalContainerInfo.artID or RSUtils.Contains(internalContainerInfo.artID, C_Map.GetMapArtID(mapID)))) then
					return true;
				end
			end
		elseif (RSContainerDB.IsInternalContainerMonoZone(containerID)) then
			local containerInfo = RSContainerDB.GetInternalContainerInfo(containerID)
			if (containerInfo.zoneID == mapID and (not containerInfo.artID or RSUtils.Contains(containerInfo.artID, C_Map.GetMapArtID(mapID)))) then
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
		if (private.dbglobal.object_names[GetLocale()][containerID]) then
			return private.dbglobal.object_names[GetLocale()][containerID]
		end
	end

	return nil
end