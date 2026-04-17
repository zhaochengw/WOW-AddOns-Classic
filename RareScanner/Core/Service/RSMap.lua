-----------------------------------------------------------------------
-- AddOn namespace.
-----------------------------------------------------------------------
local ADDON_NAME, private = ...

local LibStub = _G.LibStub
local AL = LibStub("AceLocale-3.0"):GetLocale("RareScanner", false)

local RSMap = private.NewLib("RareScannerMap")

-- RareScanner database libraries
local RSNpcDB = private.ImportLib("RareScannerNpcDB")
local RSContainerDB = private.ImportLib("RareScannerContainerDB")
local RSEventDB = private.ImportLib("RareScannerEventDB")
local RSGeneralDB = private.ImportLib("RareScannerGeneralDB")
local RSMapDB = private.ImportLib("RareScannerMapDB")
local RSConfigDB = private.ImportLib("RareScannerConfigDB")

-- RareScanner internal libraries
local RSConstants = private.ImportLib("RareScannerConstants")
local RSLogger = private.ImportLib("RareScannerLogger")
local RSTimeUtils = private.ImportLib("RareScannerTimeUtils")
local RSUtils = private.ImportLib("RareScannerUtils")

-- RareScanner services
local RSNpcPOI = private.ImportLib("RareScannerNpcPOI")
local RSContainerPOI = private.ImportLib("RareScannerContainerPOI")
local RSEventPOI = private.ImportLib("RareScannerEventPOI")
local RSGroupPOI = private.ImportLib("RareScannerGroupPOI")
local RSRecentlySeenTracker = private.ImportLib("RareScannerRecentlySeenTracker")


---============================================================================
-- Groups of POIs
---============================================================================

local function CreateGroups(POIs)
	local checkedPOIs = {}

	for _, POI in ipairs (POIs) do
		local POIchecked = false;
		
		-- Skip POIs that are shown in the worldmap and POIs that shouldnt group up
		if (not POI.worldmap and POI.grouping) then
			for _, checkedPOI in ipairs (checkedPOIs) do
				if (POI.entityID ~= checkedPOI.entityID and not checkedPOI.worldmap) then
					local distance = RSUtils.Distance(POI, checkedPOI)
					if (distance >= 0 and distance <= RSConstants.MINIMUM_DISTANCE_PINS_WORLD_MAP) then
						RSLogger:PrintDebugMessageEntityID(POI.entityID, string.format("NPC [%s]: Cerca de [%s], distancia [%s].", POI.entityID, checkedPOI.entityID, distance))
						RSLogger:PrintDebugMessageEntityID(POI.entityID, string.format("NPC [%s]: Coordenadas [%s,%s].", POI.entityID, POI.x, POI.y))
						RSLogger:PrintDebugMessageEntityID(POI.entityID, string.format("NPC [%s]: Coordenadas [%s,%s].", checkedPOI.entityID, checkedPOI.x, checkedPOI.y))
						if (not checkedPOI.POIs) then
							checkedPOI.POIs = {}
						end
	
						tinsert(checkedPOI.POIs, POI)
						POIchecked = true;
						break;
					end
				end
			end
		end
	
		if (not POIchecked) then
			tinsert(checkedPOIs, POI)
		end
	end

	local resultPOIs = {}

	for _, checkedPOI in ipairs(checkedPOIs) do
		-- If the POI doesnt have a group
		if (not checkedPOI.POIs) then
			tinsert(resultPOIs, checkedPOI)
			-- If it does, create a group including the parent
		else
			local tempTable = checkedPOI.POIs
			--checkedPOIs.POIs = nil
			tinsert(tempTable, checkedPOI)
			tinsert(resultPOIs, RSGroupPOI.GetGroupPOI(tempTable))
		end
	end

	return resultPOIs;
end

---============================================================================
-- Map POIs
---- Manage adding icons to the world map and minimap
---============================================================================

local MapPOIs = {}

function RSMap.GetMapPOIs(mapID, onWorldMap, onMiniMap)
	-- Clear previous list
	MapPOIs = {}

	-- Skip if zone filtered
	if (RSConfigDB.IsZoneFiltered(mapID) or RSConfigDB.IsZoneFilteredOnlyWorldmap(mapID)) then
		return
	end

	-- Extract world quests in the area.
	local questsOnMap = C_TaskQuest.GetQuestsOnMap(mapID)
	local questTitles = {}
	if (questsOnMap) then
		for _, info in ipairs (questsOnMap) do
			if (info.questID and HaveQuestData(info.questID)) then
				local title, _, _ = C_TaskQuest.GetQuestInfoByQuestID(info.questID)
				table.insert(questTitles, title)
			end
		end
	end
	
	-- Add NPCs POIs
	local npcIDs = RSNpcDB.GetNpcIDsByMapID(mapID)
	if (RSUtils.GetTableLength(npcIDs) > 0) then
		for _, npcID in ipairs(npcIDs) do
			local POI = RSNpcPOI.GetMapNpcPOI(npcID, mapID, questTitles, onWorldMap, onMiniMap)
			if (POI) then
				tinsert(MapPOIs,POI)
			end
		end
	end
	
	-- Add containers POIs
	local containerIDs = RSContainerDB.GetContainerIDsByMapID(mapID)
	if (RSUtils.GetTableLength(containerIDs) > 0) then
		for _, containerID in ipairs(containerIDs) do
			local POI = RSContainerPOI.GetMapContainerPOI(containerID, mapID, onWorldMap, onMiniMap)
			if (POI) then
				tinsert(MapPOIs,POI)
			end
		end
	end
	
	-- Add event POIs
	local eventIDs = RSEventDB.GetEventIDsByMapID(mapID)
	if (RSUtils.GetTableLength(eventIDs) > 0) then
		for _, eventID in ipairs(eventIDs) do
			local POI = RSEventPOI.GetMapEventPOI(eventID, mapID, onWorldMap, onMiniMap)
			if (POI) then
				tinsert(MapPOIs,POI)
			end
		end
	end
	
	-- Add points not included in the database
	local entitiesNodb = RSGeneralDB.GetAlreadyFoundEntitiesNoDB()
	if (entitiesNodb and entitiesNodb[mapID] and entitiesNodb[mapID][C_Map.GetMapArtID(mapID)]) then
		for _, entityID in ipairs(entitiesNodb[mapID][C_Map.GetMapArtID(mapID)]) do
			local POI
			
			local entityInfo = RSGeneralDB.GetAlreadyFoundEntity(entityID)
			if (entityInfo) then
				if (RSConstants.IsNpcAtlas(entityInfo.atlasName)) then
					POI = RSNpcPOI.GetMapNpcPOI(entityID, mapID, questTitles, onWorldMap, onMiniMap)
				elseif (RSConstants.IsContainerAtlas(entityInfo.atlasName)) then
					POI = RSContainerPOI.GetMapContainerPOI(entityID, mapID, onWorldMap, onMiniMap)
				elseif (RSConstants.IsEventAtlas(entityInfo.atlasName)) then
					POI = RSEventPOI.GetMapEventPOI(entityID, mapID, onWorldMap, onMiniMap)
				end
				
				if (POI) then
					tinsert(MapPOIs,POI)
				end
			end
		end
	end
	
	-- Add POIs from recently seen entities (multi spawn)
	local recentlySeenEntities = RSRecentlySeenTracker.GetAllRecentlySeenSpots()
	if (RSUtils.GetTableLength(recentlySeenEntities) > 0) then
		for entityID, entityInfo in pairs (recentlySeenEntities) do
			if (type(entityInfo) == "table") then
				for xy, info in pairs (entityInfo) do
					if (info.mapID == mapID) then
						local recentlySeenInfo = {}
						recentlySeenInfo.mapID = mapID
						recentlySeenInfo.coordX = info.x
						recentlySeenInfo.coordY = info.y
						recentlySeenInfo.foundTime = info.time
					
						local POI = nil
						if (RSConstants.IsNpcAtlas(info.atlasName)) then
							RSNpcDB.DeleteNpcKilled(entityID)
							POI = RSNpcPOI.GetMapNpcPOI(entityID, mapID, questTitles, onWorldMap, onMiniMap, recentlySeenInfo)
						elseif (RSConstants.IsContainerAtlas(info.atlasName)) then
							RSContainerDB.DeleteContainerOpened(entityID)
							POI = RSContainerPOI.GetMapContainerPOI(entityID, mapID, onWorldMap, onMiniMap, recentlySeenInfo)
						elseif (RSConstants.IsEventAtlas(info.atlasName)) then
							RSEventDB.DeleteEventCompleted(entityID)
							POI = RSEventPOI.GetMapEventPOI(entityID, mapID, onWorldMap, onMiniMap, recentlySeenInfo)
						end
		
						if (POI) then						
							-- Ignore if added by already found entitites
							local alreadyAdded = false
							for _, MapPOI in ipairs (MapPOIs) do
								if (POI.entityID == MapPOI.entityID and POI.x == MapPOI.x and POI.y == MapPOI.y) then
									alreadyAdded = true
									break
								end
							end
							
							if (not alreadyAdded) then
								tinsert(MapPOIs,POI)
							end
						end
					end
				end
			end
		end
	end

	-- Create groups if the pins go in the worldmap
	if (onWorldMap) then
		return CreateGroups(MapPOIs)
	end

	return MapPOIs
end

function RSMap.GetWorldMapPOI(objectGUID, vignetteInfo, mapID)
	if (not objectGUID or not mapID) then
		return nil
	end
	
	local _, _, _, _, _, vignetteObjectID = strsplit("-", objectGUID)
		
	if (vignetteInfo.type == Enum.VignetteType.Treasure or RSConstants.IsContainerAtlas(vignetteInfo.atlasName)) then
		local containerID = tonumber(vignetteObjectID)
		
		-- If pre-event, sets the container ID
		if (RSConstants.CONTAINERS_WITH_PRE_EVENT[containerID]) then
			containerID = RSContainerDB.GetFinalContainerID(containerID)
		end
		
		local containerInfo = RSContainerDB.GetInternalContainerInfo(containerID)
		local alreadyFoundInfo = RSGeneralDB.GetAlreadyFoundEntity(containerID)
		
		if (containerInfo or alreadyFoundInfo) then
			return RSContainerPOI.GetContainerPOI(containerID, mapID, containerInfo, alreadyFoundInfo)
		end
	elseif ((vignetteInfo.type == Enum.VignetteType.Torghast and not RSUtils.Contains(RSConstants.EVENTS_WITH_NPC_VIGNETTE, tonumber(vignetteObjectID)))
		or RSConstants.IsNpcAtlas(vignetteInfo.atlasName) 
		or (RSConstants.IsEventAtlas(vignetteInfo.atlasName) and RSConstants.NPCS_WITH_PRE_EVENT[tonumber(vignetteObjectID)])) then
		local npcID = tonumber(vignetteObjectID)

		-- If pre-event, sets the NPC ID
		if (RSConstants.NPCS_WITH_PRE_EVENT[npcID]) then
			npcID = RSNpcDB.GetFinalNpcID(npcID)
		end
		
		local npcInfo = RSNpcDB.GetInternalNpcInfo(npcID)
		local alreadyFoundInfo = RSGeneralDB.GetAlreadyFoundEntity(npcID)
		
		if (npcInfo or alreadyFoundInfo) then
			return RSNpcPOI.GetNpcPOI(npcID, mapID, npcInfo, alreadyFoundInfo)
		end
	elseif (RSConstants.IsEventAtlas(vignetteInfo.atlasName)) then
		local eventID = tonumber(vignetteObjectID)
		
		local eventInfo = RSEventDB.GetInternalEventInfo(eventID)
		local alreadyFoundInfo = RSGeneralDB.GetAlreadyFoundEntity(eventID)
	
		if (eventInfo or alreadyFoundInfo) then
			return RSEventPOI.GetEventPOI(eventID, mapID, eventInfo, alreadyFoundInfo)
		end
	end
	
	return nil
end

---============================================================================
-- Map options button
---============================================================================

local worldMapButton
function RSMap.LoadWorldMapButton()
	if (RSConfigDB.IsShowingWorldmapButton()) then 
		local rwm = LibStub('Krowi_WorldMapButtons-1.4')
		worldMapButton = rwm:Add("RSWorldMapButtonTemplate", 'DROPDOWNBUTTON')
	end
end

function RSMap.ToggleWorldmapButton() 
	if (worldMapButton) then
		if (RSConfigDB.IsShowingWorldmapButton()) then 
			worldMapButton:Show() 
		else 
			worldMapButton:Hide() 
		end 
	else
		RSMap.LoadWorldMapButton()
	end
end
