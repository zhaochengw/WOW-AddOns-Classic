-----------------------------------------------------------------------
-- AddOn namespace.
-----------------------------------------------------------------------
local LibStub = _G.LibStub
local ADDON_NAME, private = ...

local RSEventPOI = private.NewLib("RareScannerEventPOI")

-- Locales
local AL = LibStub("AceLocale-3.0"):GetLocale("RareScanner");

-- RareScanner database libraries
local RSEventDB = private.ImportLib("RareScannerEventDB")
local RSGeneralDB = private.ImportLib("RareScannerGeneralDB")
local RSAchievementDB = private.ImportLib("RareScannerAchievementDB")
local RSConfigDB = private.ImportLib("RareScannerConfigDB")

-- RareScanner internal libraries
local RSConstants = private.ImportLib("RareScannerConstants")
local RSLogger = private.ImportLib("RareScannerLogger")
local RSTimeUtils = private.ImportLib("RareScannerTimeUtils")
local RSUtils = private.ImportLib("RareScannerUtils")

-- RareScanner services
local RSRecentlySeenTracker = private.ImportLib("RareScannerRecentlySeenTracker")


---============================================================================
-- Event POIs
---- Manage adding Event icons to the world map and minimap
---============================================================================

function RSEventPOI.GetEventPOI(eventID, mapID, eventInfo, alreadyFoundInfo)
	local POI = {}
	POI.entityID = eventID
	POI.isEvent = true
	POI.grouping = true
	POI.name = RSEventDB.GetEventName(eventID) or AL["EVENT"]
	POI.mapID = mapID
	POI.foundTime = alreadyFoundInfo and alreadyFoundInfo.foundTime
	POI.isCompleted = RSEventDB.IsEventCompleted(eventID)
	POI.isDiscovered = POI.isCompleted or alreadyFoundInfo ~= nil
	
	if (eventInfo) then
		POI.worldmap = eventInfo.worldmap
		POI.achievementIDs = RSAchievementDB.GetNotCompletedAchievementIDsByMap(eventID, mapID, eventInfo.achievementID, eventInfo.questID, eventInfo.criteria)
	end
	
	-- Coordinates
	if (alreadyFoundInfo and alreadyFoundInfo.mapID == mapID) then
		POI.x = alreadyFoundInfo.coordX
		POI.y = alreadyFoundInfo.coordY
	else
		POI.x, POI.y = RSEventDB.GetInternalEventCoordinates(eventID, mapID)
	end
	
	-- Textures
	if (POI.isCompleted) then
		POI.Texture = RSConstants.BLUE_EVENT_TEXTURE
	elseif (RSRecentlySeenTracker.IsRecentlySeen(eventID, POI.x, POI.y)) then
		POI.Texture = RSConstants.PINK_EVENT_TEXTURE
	elseif (not POI.isDiscovered) then
		POI.Texture = RSConstants.RED_EVENT_TEXTURE
	else
		POI.Texture = RSConstants.NORMAL_EVENT_TEXTURE
	end
	
	-- Mini icons
	if (RSUtils.GetTableLength(POI.achievementIDs) > 0) then
		POI.iconAtlas = RSConstants.ACHIEVEMENT_ICON_ATLAS
	end
	
	return POI
end

local function IsEventPOIFiltered(eventID, mapID, eventInfo, onWorldMap, onMinimap)
	local name = RSEventDB.GetEventName(eventID) or AL["EVENT"]
	
	-- Skip if filtering by name in the world map search box
	if (name and RSGeneralDB.GetWorldMapTextFilter() and not RSUtils.Contains(name, RSGeneralDB.GetWorldMapTextFilter())) then
		RSLogger:PrintDebugMessageEntityID(eventID, string.format("Saltado Evento [%s]: Filtrado por nombre [%s][%s].", eventID, name, RSGeneralDB.GetWorldMapTextFilter()))
		return true
	end	
	
	-- Skip if part of a disabled event
	if (RSEventDB.IsDisabledEvent(eventID)) then
		RSLogger:PrintDebugMessageEntityID(eventID, string.format("Saltado Evento [%s]: Parte de un evento (mundial) desactivado.", eventID))
		return true
	end

	-- Skip if the entity appears only while a quest event is going on and it isnt active
	if (eventInfo and eventInfo.zoneQuestId) then
		local active = false
		for _, questID in ipairs(eventInfo.zoneQuestId) do
			if (C_TaskQuest.IsActive(questID) or C_QuestLog.IsQuestFlaggedCompleted(questID)) then
				active = true
				break
			end
		end

		if (not active) then
			RSLogger:PrintDebugMessageEntityID(eventID, string.format("Saltado Evento [%s]: Evento asociado no esta activo.", eventID))
			return true
		end
	end

	-- Skip if the entity is filtered
	if (RSConfigDB.IsEventFiltered(eventID) or RSConfigDB.IsEventFilteredOnlyWorldmap(eventID)) then
		RSLogger:PrintDebugMessageEntityID(eventID, string.format("Saltado Evento [%s]: Filtrado en opciones (filtro completo o mapa del mundo).", eventID))
		return true
	end

	-- A 'not discovered' event will be setted as completed when the action is detected while loading the addon and its questID is completed
	local eventCompleted = RSEventDB.IsEventCompleted(eventID)

	-- Skip if completed and not showing completed entities
	if (eventCompleted and not RSConfigDB.IsShowingCompletedEvents()) then
		RSLogger:PrintDebugMessageEntityID(eventID, string.format("Saltado Evento [%s]: Esta completado.", eventID))
		return true
	end

	return false
end

function RSEventPOI.GetMapEventPOI(eventID, mapID, onWorldMap, onMinimap, recentlySeenInfo)
	-- Skip if not showing events icons
	if (not RSConfigDB.IsShowingEvents()) then
		RSLogger:PrintDebugMessageEntityID(eventID, string.format("Saltado Evento [%s]: Iconos de eventos deshabilitado.", eventID))
		return
	end
	
	local alreadyFoundInfo = recentlySeenInfo or RSGeneralDB.GetAlreadyFoundEntity(eventID)
	
	-- Skip if not showing not discovered icons
	if (not RSConfigDB.IsShowingNotDiscoveredEvents() and not alreadyFoundInfo) then
		return
	end

	-- Skip if the entity has been seen before the max amount of time that the player want to see the icon on the map
	-- This filter doesnt apply to completed entities
	if (RSConfigDB.IsMaxSeenTimeEventFilterEnabled() and not RSEventDB.IsEventCompleted(eventID) and alreadyFoundInfo and time() - alreadyFoundInfo.foundTime > RSTimeUtils.MinutesToSeconds(RSConfigDB.GetMaxSeenEventTimeFilter())) then
		RSLogger:PrintDebugMessageEntityID(eventID, string.format("Saltado Evento [%s]: Visto hace demasiado tiempo.", eventID))
		return
	end

	-- Skip if common filters
	local eventInfo = RSEventDB.GetInternalEventInfo(eventID)
	if (not IsEventPOIFiltered(eventID, mapID, eventInfo, onWorldMap, onMinimap)) then
		return RSEventPOI.GetEventPOI(eventID, mapID, eventInfo, alreadyFoundInfo)
	end
end
