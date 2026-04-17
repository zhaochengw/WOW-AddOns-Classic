-----------------------------------------------------------------------
-- AddOn namespace.
-----------------------------------------------------------------------
local LibStub = _G.LibStub
local ADDON_NAME, private = ...

local RSContainerPOI = private.NewLib("RareScannerContainerPOI")

-- Locales
local AL = LibStub("AceLocale-3.0"):GetLocale("RareScanner");

-- RareScanner database libraries
local RSContainerDB = private.ImportLib("RareScannerContainerDB")
local RSGeneralDB = private.ImportLib("RareScannerGeneralDB")
local RSAchievementDB = private.ImportLib("RareScannerAchievementDB")
local RSConfigDB = private.ImportLib("RareScannerConfigDB")
local RSProfessionDB = private.ImportLib("RareScannerProfessionDB")

-- RareScanner internal libraries
local RSConstants = private.ImportLib("RareScannerConstants")
local RSLogger = private.ImportLib("RareScannerLogger")
local RSTimeUtils = private.ImportLib("RareScannerTimeUtils")
local RSUtils = private.ImportLib("RareScannerUtils")

-- RareScanner services
local RSRecentlySeenTracker = private.ImportLib("RareScannerRecentlySeenTracker")


---============================================================================
-- Container Map POIs
---- Manage adding Container icons to the world map and minimap
---============================================================================

function RSContainerPOI.GetContainerPOI(containerID, mapID, containerInfo, alreadyFoundInfo)
	local POI = {}
	POI.entityID = containerID
	POI.isContainer = true
	POI.grouping = true
	POI.name = RSContainerDB.GetContainerName(containerID) or AL["CONTAINER"]
	POI.mapID = mapID
	POI.foundTime = alreadyFoundInfo and alreadyFoundInfo.foundTime
	POI.isOpened = RSContainerDB.IsContainerOpened(containerID)
	POI.isDiscovered = POI.isOpened or alreadyFoundInfo ~= nil
	
	if (containerInfo) then
		POI.worldmap = containerInfo.worldmap
		POI.factionID = containerInfo.factionID
		POI.minieventID = containerInfo.minieventID
		POI.achievementIDs = RSAchievementDB.GetNotCompletedAchievementIDsByMap(containerID, mapID, containerInfo.achievementID, containerInfo.questID, containerInfo.criteria, true)
	end
	
	-- Coordinates
	if (alreadyFoundInfo and alreadyFoundInfo.mapID == mapID) then
		POI.x = alreadyFoundInfo.coordX
		POI.y = alreadyFoundInfo.coordY
	else
		POI.x, POI.y = RSContainerDB.GetInternalContainerCoordinates(containerID, mapID)
	end

	-- Textures
	if (POI.isOpened) then
		POI.Texture = RSConstants.BLUE_CONTAINER_TEXTURE
	elseif (RSRecentlySeenTracker.IsRecentlySeen(containerID, POI.x, POI.y)) then
		POI.Texture = RSConstants.PINK_CONTAINER_TEXTURE
	elseif (not POI.isDiscovered) then
		POI.Texture = RSConstants.RED_CONTAINER_TEXTURE
	else
		POI.Texture = RSConstants.NORMAL_CONTAINER_TEXTURE
	end
	
	-- Mini icons
	if (POI.minieventID and RSConstants.MINIEVENTS_WORLDMAP_FILTERS[POI.minieventID] and RSConstants.MINIEVENTS_WORLDMAP_FILTERS[POI.minieventID].atlas) then
		POI.iconAtlas = RSConstants.MINIEVENTS_WORLDMAP_FILTERS[POI.minieventID].atlas
	elseif (RSUtils.GetTableLength(POI.achievementIDs) > 0) then
		POI.iconAtlas = RSConstants.ACHIEVEMENT_ICON_ATLAS
	end

	return POI
end

local function IsContainerPOIFiltered(containerID, mapID, containerInfo, onWorldMap, onMinimap)
	local name = RSContainerDB.GetContainerName(containerID) or AL["CONTAINER"]
	
	-- Skip if part of a disabled event
	if (RSContainerDB.IsDisabledEvent(containerID)) then
		RSLogger:PrintDebugMessageEntityID(containerID, string.format("Saltado Contenedor [%s]: Parte de un evento desactivado.", containerID))
		return true
	end
	
	-- Skip if filtering by name in the world map search box
	if (name and RSGeneralDB.GetWorldMapTextFilter() and not RSUtils.Contains(name, RSGeneralDB.GetWorldMapTextFilter())) then
		RSLogger:PrintDebugMessageEntityID(containerID, string.format("Saltado Contenedor [%s]: Filtrado por nombre [%s][%s].", containerID, name, RSGeneralDB.GetWorldMapTextFilter()))
		return true
	end

	-- Skip if the entity is filtered
	if (RSConfigDB.IsContainerFiltered(containerID) or RSConfigDB.IsContainerFilteredOnlyWorldmap(containerID)) then
		RSLogger:PrintDebugMessageEntityID(containerID, string.format("Saltado Contenedor [%s]: Filtrado en opciones (filtro completo o mapa del mundo).", containerID))
		return true
	end
	
	-- Skip if rare part of a filtered minievent
	local isMinieventWithFilter = false;
	if (containerInfo and containerInfo.minieventID) then
		isMinieventWithFilter = RSConstants.MINIEVENTS_WORLDMAP_FILTERS[containerInfo.minieventID].active
		
		-- Skip if minievent is filtered
		if (RSConfigDB.IsMinieventFiltered(containerInfo.minieventID)) then
			RSLogger:PrintDebugMessageEntityID(containerID, string.format("Saltado Contenedor [%s]: Filtrado minievento [%s].", containerID, containerInfo.minieventID))
			return true
		end
	end
	
	-- Skip if not completed achievement and is filtered
	local isNotCompletedAchievement = false
	if (containerInfo) then
		isNotCompletedAchievement = RSUtils.GetTableLength(RSAchievementDB.GetNotCompletedAchievementIDsByMap(containerID, mapID, containerInfo.achievementID, containerInfo.questID, containerInfo.criteria, true)) > 0;
		if (not RSConfigDB.IsShowingAchievementContainers() and isNotCompletedAchievement) then
			RSLogger:PrintDebugMessageEntityID(containerID, string.format("Saltado Contenedor [%s]: Filtrado contenedor con logro.", containerID))
			return true
		end
	end
	
	-- Skip if other filtered
	if (not RSConfigDB.IsShowingOtherContainers() and not isNotCompletedAchievement and not isMinieventWithFilter) then
		RSLogger:PrintDebugMessageEntityID(containerID, string.format("Saltado Contenedor [%s]: Filtrado otro contenedor.", containerID))
		return true
	end

	-- Skip if the entity appears only while a quest event is going on and it isnt active
	if (containerInfo and containerInfo.zoneQuestId) then
		local active = false
		for _, questID in ipairs(containerInfo.zoneQuestId) do
			if (C_TaskQuest.IsActive(questID) or C_QuestLog.IsQuestFlaggedCompleted(questID)) then
				active = true
				break
			end
		end

		if (not active) then
			RSLogger:PrintDebugMessageEntityID(containerID, string.format("Saltado Contenedor [%s]: Evento asociado no esta activo.", containerID))
			return true
		end
	end

	-- A 'not discovered' container will be setted as opened when the action is detected while loading the addon and its questID is completed
	local containerOpened = RSContainerDB.IsContainerOpened(containerID)

	-- Skip if opened and not showing opened entities
	if (containerOpened and not RSConfigDB.IsShowingAlreadyOpenedContainers()) then
		RSLogger:PrintDebugMessageEntityID(containerID, string.format("Saltado Contenedor [%s]: Esta abierto.", containerID))
		return true
	end
	
	-- Skip if wrong profession
	if (containerInfo and containerInfo.prof) then
		if (not RSProfessionDB.HasPlayerProfession(containerInfo.prof)) then
			RSLogger:PrintDebugMessageEntityID(containerID, string.format("Saltado Contenedor [%s]: Profesión incorrecta.", containerID))
			return true
		end
	end
	
	-- Skip if its a completed part of an achievement
	if (containerInfo and containerInfo.achievementID and RSConfigDB.IsAchievementContainerFilterEnabled() and RSUtils.GetTableLength(RSAchievementDB.GetNotCompletedAchievementIDsByMap(containerID, mapID, containerInfo.achievementID, containerInfo.questID, containerInfo.criteria, true)) == 0) then
		RSLogger:PrintDebugMessageEntityID(containerID, string.format("Saltado Contenedor [%s]: Parte de logro completa.", containerID))
		return true
	end

	return false
end

function RSContainerPOI.GetMapContainerPOI(containerID, mapID, onWorldMap, onMinimap, recentlySeenInfo)
	-- Skip if not showing container icons
	if (not RSConfigDB.IsShowingContainers()) then
		RSLogger:PrintDebugMessageEntityID(containerID, string.format("Saltado Contenedor [%s]: Iconos de contenedores deshabilitado.", containerID))
		return
	end
	
	local alreadyFoundInfo = recentlySeenInfo or RSGeneralDB.GetAlreadyFoundEntity(containerID)

	-- Skip if not showing not discovered icons
	if (not RSConfigDB.IsShowingNotDiscoveredContainers() and not alreadyFoundInfo) then
		return
	end

	-- Skip if the entity has been seen before the max amount of time that the player want to see the icon on the map
	-- This filter doesnt apply to opened entities
	if (RSConfigDB.IsMaxSeenTimeContainerFilterEnabled() and not RSContainerDB.IsContainerOpened(containerID) and alreadyFoundInfo and time() - alreadyFoundInfo.foundTime > RSTimeUtils.MinutesToSeconds(RSConfigDB.GetMaxSeenContainerTimeFilter())) then
		RSLogger:PrintDebugMessageEntityID(containerID, string.format("Saltado Contenedor [%s]: Visto hace demasiado tiempo.", containerID))
		return
	end
	
	-- Skip if common filters
	local containerInfo = RSContainerDB.GetInternalContainerInfo(containerID)
	if (not IsContainerPOIFiltered(containerID, mapID, containerInfo, onWorldMap, onMinimap)) then
		return RSContainerPOI.GetContainerPOI(containerID, mapID, containerInfo, alreadyFoundInfo)
	end
end
