-----------------------------------------------------------------------
-- AddOn namespace.
-----------------------------------------------------------------------
local ADDON_NAME, private = ...

local LibStub = _G.LibStub
local AL = LibStub("AceLocale-3.0"):GetLocale("RareScanner", false)
local LB = LibStub("LibBabble-Zone-3.0"):GetUnstrictLookupTable()

local RSMap = private.NewLib("RareScannerMap")

-- RareScanner database libraries
local RSNpcDB = private.ImportLib("RareScannerNpcDB")
local RSContainerDB = private.ImportLib("RareScannerContainerDB")
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
local RSGroupPOI = private.ImportLib("RareScannerGroupPOI")
local RSRecentlySeenTracker = private.ImportLib("RareScannerRecentlySeenTracker")


---============================================================================
-- Not discovered entities
---- Stores in a temporal list all the not discovered entities to help displaying them on the map
---============================================================================

function RSMap.InitializeNotDiscoveredLists()
	RSNpcPOI.InitializeNotDiscoveredNpcs()
	RSContainerPOI.InitializeNotDiscoveredContainers()
end

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

local function GetMapNotDiscoveredPOIs(mapID, onWorldMap, onMiniMap)
	-- Skip if not showing 'not discovered' icons in old expansions
	if (not RSConfigDB.IsShowingOldNotDiscoveredMapIcons() and not RSMapDB.IsMapInCurrentExpansion(mapID)) then
		return
	end

	-- Add icons
	local notDiscoveredNpcPOIs = RSNpcPOI.GetMapNotDiscoveredNpcPOIs(mapID, onWorldMap, onMiniMap)
	if (RSUtils.GetTableLength(notDiscoveredNpcPOIs) > 0) then
		for _, POI in ipairs (notDiscoveredNpcPOIs) do
			tinsert(MapPOIs,POI)
		end
	end
	local notDiscoveredContainerPOIs = RSContainerPOI.GetMapNotDiscoveredContainerPOIs(mapID, onWorldMap, onMiniMap)
	if (RSUtils.GetTableLength(notDiscoveredContainerPOIs) > 0) then
		for _, POI in ipairs (notDiscoveredContainerPOIs) do
			tinsert(MapPOIs,POI)
		end
	end
end

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

	-- Extract POIs from already found entities
	for entityID, entityInfo in pairs (RSGeneralDB.GetAlreadyFoundEntities()) do
		-- Extract POI from already found NPC
		local POI = nil
		if (RSConstants.IsNpcAtlas(entityInfo.atlasName)) then
			POI = RSNpcPOI.GetMapAlreadyFoundNpcPOI(entityID, entityInfo, mapID, onWorldMap, onMiniMap)
		elseif (RSConstants.IsContainerAtlas(entityInfo.atlasName)) then
			POI = RSContainerPOI.GetMapAlreadyFoundContainerPOI(entityID, entityInfo, mapID, onWorldMap, onMiniMap)
		end

		if (POI) then
			tinsert(MapPOIs,POI)
		end
	end
	
	-- extract POIs from recently seen entities (multi spawn)
	local recentlySeenEntities = RSRecentlySeenTracker.GetAllRecentlySeenSpots()
	if (RSUtils.GetTableLength(recentlySeenEntities) > 0) then
		for entityID, entityInfo in pairs (recentlySeenEntities) do
			if (type(entityInfo) == "table") then
				for xy, info in pairs (entityInfo) do
					if (info.mapID == mapID) then
						local entityInfo = {}
						entityInfo.mapID = mapID
						entityInfo.coordX = info.x
						entityInfo.coordY = info.y
						entityInfo.foundTime = info.time
					
						local POI = nil
						if (RSConstants.IsNpcAtlas(info.atlasName)) then
							POI = RSNpcPOI.GetMapAlreadyFoundNpcPOI(entityID, entityInfo, mapID, onWorldMap, onMiniMap)
						elseif (RSConstants.IsContainerAtlas(info.atlasName)) then
							POI = RSContainerPOI.GetMapAlreadyFoundContainerPOI(entityID, entityInfo, mapID, onWorldMap, onMiniMap)
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

	-- Extract POIs not discovered
	GetMapNotDiscoveredPOIs(mapID, onWorldMap, onMiniMap)

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
	
	if (RSConstants.IsContainerAtlas(vignetteInfo.atlasName)) then
		local _, _, _, _, _, vignetteObjectID = strsplit("-", objectGUID)
		local containerID = tonumber(vignetteObjectID)
		local containerInfo = RSContainerDB.GetInternalContainerInfo(containerID)
		local alreadyFoundInfo = RSGeneralDB.GetAlreadyFoundEntity(containerID)
		
		if (containerInfo or alreadyFoundInfo) then
			return RSContainerPOI.GetContainerPOI(containerID, mapID, containerInfo, alreadyFoundInfo)
		end
	elseif (RSConstants.IsNpcAtlas(vignetteInfo.atlasName)) then
		local _, _, _, _, _, vignetteObjectID = strsplit("-", objectGUID)
		local npcID = tonumber(vignetteObjectID)
		local npcInfo = RSNpcDB.GetInternalNpcInfo(npcID)
		local alreadyFoundInfo = RSGeneralDB.GetAlreadyFoundEntity(npcID)
		
		if (npcInfo or alreadyFoundInfo) then
			return RSNpcPOI.GetNpcPOI(npcID, mapID, npcInfo, alreadyFoundInfo)
		end
	end
	
	return nil
end

---============================================================================
-- Map names
---============================================================================

function RSMap.GetMapName(mapID)
	local mapInfo = C_Map.GetMapInfo(mapID)
	if (mapInfo) then
		-- For those zones with the same name, add a comment
		if (AL["ZONE_"..mapID] ~= "ZONE_"..mapID) then
			return string.format(AL["ZONE_"..mapID], mapInfo.name)
		else
			return mapInfo.name
		end
	elseif (private.DUNGEONS_IDS[mapID]) then
		return LB[private.DUNGEONS_IDS[mapID]]
	end
	
	return AL["ZONES_CONTINENT_LIST"][mapID]
end

---============================================================================
-- Map options button
---============================================================================

local worldMapButton
function RSMap.LoadWorldMapButton()
	if (RSConfigDB.IsShowingWorldmapButton()) then 
		local rwm = LibStub('Krowi_WorldMapButtons-1.4')
		worldMapButton = rwm:Add("RSWorldMapButtonTemplate", 'DROPDOWNTOGGLEBUTTON')
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
