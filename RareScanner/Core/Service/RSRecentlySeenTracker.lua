-----------------------------------------------------------------------
-- AddOn namespace.
-----------------------------------------------------------------------
local ADDON_NAME, private = ...

local RSRecentlySeenTracker = private.NewLib("RareScannerRecentlySeenTracker")

-- RareScanner database libraries
local RSConfigDB = private.ImportLib("RareScannerConfigDB")
local RSGeneralDB = private.ImportLib("RareScannerGeneralDB")

-- RareScanner internal libraries
local RSConstants = private.ImportLib("RareScannerConstants")
local RSLogger = private.ImportLib("RareScannerLogger")
local RSUtils = private.ImportLib("RareScannerUtils")
local RSTimeUtils = private.ImportLib("RareScannerTimeUtils")

-- Timers
local RESET_RECENTLY_SEEN_TIMER

---============================================================================
-- Tracks notifications
---============================================================================

local recently_seen_entities = {}
local ping_animations = {}
local VIGNETTE_ID_SEPARATOR = "-"

local function InitResetRecentlySeenTimer()
	if (RESET_RECENTLY_SEEN_TIMER) then
		return
	end
	
	RESET_RECENTLY_SEEN_TIMER = C_Timer.NewTicker(RSConstants.CHECK_RESET_RECENTLY_SEEN_TIMER, function()
		for entityID, entityInfo in pairs (recently_seen_entities) do
			local currenTime = time()
			
			-- If its an entity that spawns only in one spot
			if (currenTime > (entityInfo + RSConstants.RECENTLY_SEEN_RESET_TIMER)) then
				--RSLogger:PrintDebugMessage(string.format("ResetRecentlySeen[%s] (mono)", entityID))
				recently_seen_entities[entityID] = nil
				RSGeneralDB.DeleteRecentlySeen(entityID)
			end
		end
	end)
end

function RSRecentlySeenTracker.AddRecentlySeen(entityID, atlasName, isNavigating)	
	if (not entityID) then
		return
	end
	
	if (isNavigating) then
		return
	end
	
	-- Initializes timer
	InitResetRecentlySeenTimer()
	
	local currentTime = time()
	
	-- Extracts info from internal database
	local entityInfo = RSGeneralDB.GetAlreadyFoundEntity(entityID)
	if (not entityInfo) then
		return
	end
	
	recently_seen_entities[entityID] = currentTime
	RSGeneralDB.SetRecentlySeen(entityID)
	
	-- Adds to the list to show ping animation
	if ((RSConstants.IsNpcAtlas(atlasName) and RSConfigDB.IsShowingAnimationForNpcs() and RSConfigDB.GetAnimationForNpcs() ~= RSConstants.MAP_ANIMATIONS_ON_CLICK) or 
			(RSConstants.IsContainerAtlas(atlasName) and RSConfigDB.IsShowingAnimationForContainers() and RSConfigDB.GetAnimationForContainers() ~= RSConstants.MAP_ANIMATIONS_ON_CLICK)) then
		RSRecentlySeenTracker.AddPendingAnimation(entityID, entityInfo.mapID, entityInfo.coordX, entityInfo.coordY)
	end
end

function RSRecentlySeenTracker.RemoveRecentlySeen(entityID)
	local entityInfo = recently_seen_entities[entityID]
	
	if (not entityInfo) then
		return nil
	end
	
	-- If its an entity that spawns only in one spot
	recently_seen_entities[entityID] = nil
	RSGeneralDB.DeleteRecentlySeen(entityID)
	return nil
end

function RSRecentlySeenTracker.IsRecentlySeen(entityID, x, y)
	if (not entityID) then
		return false
	end
	
	-- If it isnt cached in this session check database 
	local entityInfo = recently_seen_entities[entityID]
	if (not entityInfo) then
		return RSGeneralDB.IsRecentlySeen(entityID)
	end
	
	-- If its an entity that spawns only in one spot
	return true
end

function RSRecentlySeenTracker.GetAllRecentlySeenSpots()
	return recently_seen_entities
end

---============================================================================
-- World map animations for recently seen entities
---============================================================================

function RSRecentlySeenTracker.ShouldPlayAnimation(entityID, mapID, x, y)
	if (not entityID) then
		return false
	end
	
	--RSLogger:PrintDebugMessage(string.format("ShouldPlayAnimation[%s][%s][%s][%s]", entityID, mapID and mapID or "mapID", x and x or "x", y and y or "y"))
	
	local pingAnimationInfo = ping_animations[tonumber(entityID)]
	if (not pingAnimationInfo) then
		return false
	elseif (pingAnimationInfo == true) then
		return true
	end
	
	if (not mapID or not x or not y) then
		return true
	end

	for xy, info in pairs (pingAnimationInfo) do
		if (info.mapID == tostring(mapID) and info.x == tostring(x) and info.y == tostring(y)) then
			--RSLogger:PrintDebugMessage(string.format("ShouldPlayAnimation[%s] (multi) [%s]", entityID, xy))
			return true
		end
	end
	
	return false
end

function RSRecentlySeenTracker.AddPendingAnimation(entityID, mapID, x, y, refreshWorldMap)	
	if (not ping_animations[entityID]) then
		ping_animations[entityID] = {}
	end
	
	--RSLogger:PrintDebugMessage(string.format("AddPendingAnimation[%s][%s][%s][%s]", entityID, mapID and mapID or "mapID", x and x or "x", y and y or "y"))
	
	if (mapID and mapID ~= "" and x and y) then
		-- In case it couldn't get the map and coordinates the first time
		if (ping_animations[entityID] == true) then
			ping_animations[entityID] = {}
		end
		
		local xy = x.."_"..y		
		ping_animations[entityID][xy] = {}
		ping_animations[entityID][xy].x = RSUtils.tostring(x)
		ping_animations[entityID][xy].y = RSUtils.tostring(y)
		ping_animations[entityID][xy].mapID = RSUtils.tostring(mapID)
	else
		ping_animations[entityID] = true
	end
	
	if (refreshWorldMap and WorldMapFrame:IsShown()) then
		WorldMapFrame:RefreshAllDataProviders();
	end
end

function RSRecentlySeenTracker.DeletePendingAnimation(entityID, mapID, x, y, refreshWorldMap)
	if (not entityID) then
		return
	end
	
	--RSLogger:PrintDebugMessage(string.format("DeletePendingAnimation[%s]", entityID))
	
	local entityIDnumber = tonumber(entityID)
	if (x and y and type(ping_animations[entityIDnumber]) == "table") then
		local xy = x.."_"..y
		if (RSUtils.GetTableLength(ping_animations[entityIDnumber]) == 1) then
			ping_animations[entityIDnumber] = nil
		else
			ping_animations[entityIDnumber][xy] = nil
		end
	else
		ping_animations[entityIDnumber] = nil
	end
end