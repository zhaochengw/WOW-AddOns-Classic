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
local VIGNETTE_ID_SEPARATOR = "-"

local function InitResetRecentlySeenTimer()
	if (RESET_RECENTLY_SEEN_TIMER) then
		return
	end
	
	RESET_RECENTLY_SEEN_TIMER = C_Timer.NewTicker(RSConstants.CHECK_RESET_RECENTLY_SEEN_TMER, function()
		for entityID, entityInfo in pairs (recently_seen_entities) do
			local currenTime = time()
			
			-- If its an entity that spawns only in one spot
			if (currenTime > (entityInfo + RSConstants.RECENTLY_SEEN_RESET_TIMER)) then
				RSLogger:PrintDebugMessage(string.format("ResetRecentlySeen[%s] (mono)", entityID))
				recently_seen_entities[entityID] = nil
				RSGeneralDB.DeleteRecentlySeen(entityID)
			end
		end
	end)
end

function RSRecentlySeenTracker.AddRecentlySeen(entityID, atlasName, isNavigating)
	if (isNavigating) then
		return
	end
	
	-- Initializes timer
	InitResetRecentlySeenTimer()
	
	-- Adds recently seen
	recently_seen_entities[entityID] = time()
	RSGeneralDB.SetRecentlySeen(entityID)
	RSLogger:PrintDebugMessage(string.format("AddRecentlySeen[%s] (mono) [%s]", entityID, RSTimeUtils.TimeStampToClock(currentTime)))
end

function RSRecentlySeenTracker.RemoveRecentlySeen(entityID)
	local entityInfo = recently_seen_entities[entityID]
	
	if (not entityInfo) then
		return
	end
	
	-- If its an entity that spawns only in one spot
	RSLogger:PrintDebugMessage(string.format("RemoveRecentlySeen[%s] (mono)", entityID))
	recently_seen_entities[entityID] = nil
	RSGeneralDB.DeleteRecentlySeen(entityID)
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