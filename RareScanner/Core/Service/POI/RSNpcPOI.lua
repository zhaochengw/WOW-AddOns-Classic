-----------------------------------------------------------------------
-- AddOn namespace.
-----------------------------------------------------------------------
local ADDON_NAME, private = ...

local RSNpcPOI = private.NewLib("RareScannerNpcPOI")

-- RareScanner database libraries
local RSNpcDB = private.ImportLib("RareScannerNpcDB")
local RSGeneralDB = private.ImportLib("RareScannerGeneralDB")
local RSAchievementDB = private.ImportLib("RareScannerAchievementDB")
local RSConfigDB = private.ImportLib("RareScannerConfigDB")
local RSMapDB = private.ImportLib("RareScannerMapDB")

-- RareScanner internal libraries
local RSConstants = private.ImportLib("RareScannerConstants")
local RSLogger = private.ImportLib("RareScannerLogger")
local RSTimeUtils = private.ImportLib("RareScannerTimeUtils")
local RSUtils = private.ImportLib("RareScannerUtils")

-- RareScanner services
local RSRecentlySeenTracker = private.ImportLib("RareScannerRecentlySeenTracker")

---============================================================================
-- Not discovered entities
--- In order to avoid long process time, it caches these list on load
---============================================================================

local notDiscoveredNpcIDs = {}

function RSNpcPOI.InitializeNotDiscoveredNpcs()
	for npcID, _ in pairs (RSNpcDB.GetAllInternalNpcInfo()) do
		if (not RSGeneralDB.GetAlreadyFoundEntity(npcID)) then
			notDiscoveredNpcIDs[npcID] = true
		end
	end
end

local function RefreshNotDiscoveredNpcs(npcID)
	if (not RSGeneralDB.GetAlreadyFoundEntity(npcID) and not notDiscoveredNpcIDs[npcID]) then
		notDiscoveredNpcIDs[npcID] = true
	end
end

local function RemoveNotDiscoveredNpc(npcID)
	if (npcID) then
		RSLogger:PrintDebugMessageEntityID(npcID, string.format("RemoveNotDiscoveredNpc. NPC [%s] pasa a estar 'descubierto'", npcID))
		notDiscoveredNpcIDs[npcID] = nil
	end
end

---============================================================================
-- NPC Map POIs
---- Manage adding NPC icons to the world map and minimap
---============================================================================

function RSNpcPOI.GetNpcPOI(npcID, mapID, npcInfo, alreadyFoundInfo)
	local POI = {}
	POI.entityID = npcID
	POI.isNpc = true
	POI.grouping = true
	POI.name = RSNpcDB.GetNpcName(npcID)
	POI.mapID = mapID
	if (alreadyFoundInfo and alreadyFoundInfo.mapID == mapID) then
		POI.x = alreadyFoundInfo.coordX
		POI.y = alreadyFoundInfo.coordY
  	else
	  	POI.x, POI.y = RSNpcDB.GetInternalNpcCoordinates(npcID, mapID)
	end
	
	POI.foundTime = alreadyFoundInfo and alreadyFoundInfo.foundTime
	POI.isDiscovered = POI.isDead or alreadyFoundInfo ~= nil
	POI.isFriendly = RSNpcDB.IsInternalNpcFriendly(npcID)
	POI.achievementIDs = RSAchievementDB.GetNotCompletedAchievementIDsByMap(npcID, mapID)
	
	if (npcInfo) then
		POI.worldmap = npcInfo.worldmap
		POI.custom = npcInfo.custom
	end
	
	-- Textures
	if (RSRecentlySeenTracker.IsRecentlySeen(npcID, POI.x, POI.y)) then
		POI.Texture = RSConstants.PINK_NPC_TEXTURE
	elseif (POI.custom) then
		POI.Texture = RSConstants.PURPLE_NPC_TEXTURE
	elseif (not POI.isDiscovered) then
		POI.Texture = RSConstants.RED_NPC_TEXTURE
	else
		POI.Texture = RSConstants.NORMAL_NPC_TEXTURE
	end
	
	-- Mini icons
	if (RSUtils.GetTableLength(POI.achievementIDs) > 0) then
		POI.iconAtlas = RSConstants.ACHIEVEMENT_ICON_ATLAS
	end
	
	return POI
end

local function IsNpcPOIFiltered(npcID, mapID, artID, zoneQuestID, group, onWorldMap, onMinimap)
	local name = RSNpcDB.GetNpcName(npcID)
	
	-- Skip if part of a disabled event
	if (RSNpcDB.IsDisabledEvent(npcID)) then
		RSLogger:PrintDebugMessageEntityID(npcID, string.format("Saltado NPC [%s]: Parte de un evento desactivado.", npcID))
		return true
	end

	-- Skip if the entity is filtered
	if (RSConfigDB.IsNpcFiltered(npcID) or RSConfigDB.IsNpcFilteredOnlyWorldmap(npcID)) then
		RSLogger:PrintDebugMessageEntityID(npcID, string.format("Saltado NPC [%s]: Filtrado en opciones (filtro completo o mapa del mundo).", npcID))
		return true
	end

	-- Skip if custom NPC group filtered
	if (group and RSConfigDB.IsCustomNpcGroupFiltered(group)) then
		RSLogger:PrintDebugMessageEntityID(npcID, string.format("Saltado NPC [%s]: Filtrado grupo.", npcID))
		return true
	end
	
	-- Skip if achievement rare and is filtered
	local isAchievement = RSUtils.GetTableLength(RSAchievementDB.GetNotCompletedAchievementIDsByMap(npcID, mapID)) > 0;
	if (not RSConfigDB.IsShowingAchievementRareNPCs() and isAchievement) then
		RSLogger:PrintDebugMessageEntityID(npcID, string.format("Saltado NPC [%s]: Filtrado NPC con logro.", npcID))
		return true
	end
	
	-- Skip if other filtered
	if (not RSConfigDB.IsShowingOtherRareNPCs() and not isAchievement) then
		RSLogger:PrintDebugMessageEntityID(npcID, string.format("Saltado NPC [%s]: Filtrado otro NPC.", npcID))
		return true
	end

	-- Skip if not showing friendly NPCs and this one is friendly
	if (not RSConfigDB.IsShowingFriendlyNpcs() and RSNpcDB.IsInternalNpcFriendly(npcID)) then
		RSLogger:PrintDebugMessageEntityID(npcID, string.format("Saltado NPC [%s]: Es amistoso.", npcID))
		return true
	end

	-- Skip if the entity appears only while a quest event is going on and it isnt active
	if (zoneQuestID) then
		local active = false
		for _, questID in ipairs(zoneQuestID) do
			if (C_TaskQuest.IsActive(questID) or C_QuestLog.IsQuestFlaggedCompleted(questID)) then
				active = true
				break
			end
		end

		if (not active) then
			RSLogger:PrintDebugMessageEntityID(npcID, string.format("Saltado NPC [%s]: Evento asociado no esta activo.", npcID))
			return true
		end
	end

	-- Skip if for whatever reason we don't have its name (this shouldnt happend)
	local npcName = RSNpcDB.GetNpcName(npcID)
	if (not npcName) then
		RSLogger:PrintDebugMessageEntityID(npcID, string.format("Saltado NPC [%s]: Le falta el nombre!.", npcID))
		return true
	end

	return false
end

function RSNpcPOI.GetMapNotDiscoveredNpcPOIs(mapID, onWorldMap, onMinimap)
	-- Skip if not showing NPC icons
	if (not RSConfigDB.IsShowingNpcs()) then
		return
	end
	
	-- Skip if not showing not discovered NPC icons
	if (not RSConfigDB.IsShowingNotDiscoveredNpcs()) then
		return
	end
	
	-- Refresh custom NPCs, just in case they were added after the list of not discovered was loaded
	for npcID, _ in pairs (RSNpcDB.GetAllCustomNpcInfo()) do
		RefreshNotDiscoveredNpcs(npcID)
	end

	local POIs = {}
	for npcID, _ in pairs(notDiscoveredNpcIDs) do
		local filtered = false
		local npcInfo = RSNpcDB.GetInternalNpcInfo(npcID)
		
		-- It it was a custom NPC and has being deleted it could be unsynchronized
		if (npcInfo == nil) then
			RemoveNotDiscoveredNpc(npcID)
			RSLogger:PrintDebugMessageEntityID(npcID, string.format("Saltado NPC N/D [%s]: Era un NPC personalizado y ya no existe.", npcID))
			filtered = true
		end

		-- Skip if it was discovered in this session
		if (not filtered and RSGeneralDB.GetAlreadyFoundEntity(npcID)) then
			RemoveNotDiscoveredNpc(npcID)
			RSLogger:PrintDebugMessageEntityID(npcID, string.format("Saltado NPC N/D [%s]: Ya no es 'no descubierto'.", npcID))
			filtered = true
		end

		-- Skip if the entity belong to a different mapID/artID that the one displaying
		if (not filtered and not RSNpcDB.IsInternalNpcInMap(npcID, mapID)) then
			RSLogger:PrintDebugMessageEntityID(npcID, string.format("Saltado NPC N/D [%s]: En distinta zona.", npcID))
			filtered = true
		end
		
		-- Skip if it doesnt have coordinates. This could happend if it is a custom NPC
		if (not filtered and (not npcInfo.x or not npcInfo.y)) then
			local x, y = RSNpcDB.GetInternalNpcCoordinates(npcID, mapID)
			if (not x or not y) then
				RSLogger:PrintDebugMessageEntityID(npcID, string.format("Saltado NPC N/D [%s]: No disponía de coordenadas.", npcID))
				filtered = true
			end
		end

		-- Skip if common filters
		if (not filtered and not IsNpcPOIFiltered(npcID, mapID, RSNpcDB.GetInternalNpcArtID(npcID, mapID), npcInfo.zoneQuestId, npcInfo.group, onWorldMap, onMinimap)) then
			tinsert(POIs, RSNpcPOI.GetNpcPOI(npcID, mapID, npcInfo))
		end
	end

	return POIs
end

function RSNpcPOI.GetMapAlreadyFoundNpcPOI(npcID, alreadyFoundInfo, mapID, onWorldMap, onMinimap)
	-- Skip if not showing NPC icons
	if (not RSConfigDB.IsShowingNpcs()) then
		RSLogger:PrintDebugMessageEntityID(npcID, string.format("Saltado NPC [%s]: Iconos de NPCs deshabilitado.", npcID))
		return
	end

	local npcInfo = RSNpcDB.GetInternalNpcInfo(npcID)

	-- Skip if the entity belongs to a different map that the one displaying
	-- First checks with the already found information
	local correctMap = false
	if (RSGeneralDB.IsAlreadyFoundEntityInZone(npcID, mapID)) then
		RSLogger:PrintDebugMessageEntityID(npcID, string.format("GetMapAlreadyFoundNpcPOI. NPC [%s] en zona correcta [alreadyFound].", npcID))
		correctMap = true
	end

	-- Then checks with the internal found information just in case its a multizone
	-- Its possible that the player is opening a map where this NPC can show up, but the last time seen was in a different map
	if (not correctMap) then
		if (not npcInfo or not RSNpcDB.IsInternalNpcInMap(npcID, mapID)) then
			RSLogger:PrintDebugMessageEntityID(npcID, string.format("Saltando NPC [%s]: En distinta zona.", npcID))
			return
		-- Skip if it doesnt have coordinates. This could happend if it is a custom NPC
		elseif (not npcInfo.x or not npcInfo.y) then
			local x, y = RSNpcDB.GetInternalNpcCoordinates(npcID, mapID)
			if (not x or not y) then
				RSLogger:PrintDebugMessageEntityID(npcID, string.format("Saltado NPC [%s]: No disponía de coordenadas.", npcID))
				return
			end
		end
	end

	-- Skip if common filters
	local zoneQuestID
	local group
	if (npcInfo) then
		zoneQuestID = npcInfo.zoneQuestId
		group = npcInfo.group
	end

	if (not IsNpcPOIFiltered(npcID, mapID, alreadyFoundInfo.artID, zoneQuestID, group, onWorldMap, onMinimap)) then
		return RSNpcPOI.GetNpcPOI(npcID, mapID, npcInfo, alreadyFoundInfo)
	end
end
