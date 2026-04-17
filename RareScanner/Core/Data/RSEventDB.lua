-----------------------------------------------------------------------
-- AddOn namespace.
-----------------------------------------------------------------------
local ADDON_NAME, private = ...

local RSEventDB = private.NewLib("RareScannerEventDB")

-- RareScanner database libraries
local RSMapDB = private.ImportLib("RareScannerMapDB")
local RSProfessionDB = private.ImportLib("RareScannerProfessionDB")

-- Locales
local AL = LibStub("AceLocale-3.0"):GetLocale("RareScanner");

-- RareScanner libraries
local RSLogger = private.ImportLib("RareScannerLogger")
local RSConstants = private.ImportLib("RareScannerConstants")
local RSUtils = private.ImportLib("RareScannerUtils")
local RSTimeUtils = private.ImportLib("RareScannerTimeUtils")

---============================================================================
-- Completed events database
---============================================================================

function RSEventDB.InitEventCompletedDB()
	if (not private.dbchar.events_completed) then
		private.dbchar.events_completed = {}
	end
end

function RSEventDB.IsEventCompleted(eventID)
	if (eventID and private.dbchar.events_completed[eventID]) then
		return true;
	end

	return false
end

function RSEventDB.GetAllEventsCompletedRespawnTimes()
	return private.dbchar.events_completed
end

function RSEventDB.GetEventCompletedRespawnTime(eventID)
	if (RSEventDB.IsEventCompleted(eventID)) then
		return private.dbchar.events_completed[eventID]
	end

	return 0
end

function RSEventDB.SetEventCompleted(eventID, respawnTime)
	if (eventID) then
		if (not respawnTime) then
			private.dbchar.events_completed[eventID] = RSConstants.ETERNAL_COMPLETED
		else
			private.dbchar.events_completed[eventID] = respawnTime
		end
	end
end

function RSEventDB.DeleteEventCompleted(eventID)
	if (eventID) then
		private.dbchar.events_completed[eventID] = nil
	end
end

---============================================================================
-- Event internal database
----- Stores events information included with the addon
---============================================================================

function RSEventDB.GetAllInternalEventInfo()
	return private.EVENT_INFO
end

function RSEventDB.GetEventIDsByMapID(mapID)
	return RSMapDB.GetEntitiesByMapID(mapID, RSConstants.MAP_ENTITY_EVENT, true)
end

function RSEventDB.GetInternalEventInfo(eventID)
	if (eventID) then
		return private.EVENT_INFO[eventID]
	end

	return nil
end

function RSEventDB.GetInternalEventInfoByMapID(eventID, mapID)
	if (eventID and mapID) then
		if (RSEventDB.IsInternalEventMultiZone(eventID)) then
			for internalMapID, eventInfo in pairs (RSEventDB.GetInternalEventInfo(eventID).zoneID) do
				if (internalMapID == mapID) then
					return eventInfo
				end
			end
		elseif (RSEventDB.IsInternalEventMonoZone(eventID)) then
			local eventInfo = RSEventDB.GetInternalEventInfo(eventID)
			return eventInfo
		end
	end

	return nil
end

function RSEventDB.GetInternalEventCoordinates(eventID, mapID)
	if (eventID and mapID) then
		local eventInfo = RSEventDB.GetInternalEventInfoByMapID(eventID, mapID)
		if (eventInfo) then
			return RSUtils.Lpad(eventInfo.x, 4, '0'), RSUtils.Lpad(eventInfo.y, 4, '0')
		end
	end

	return nil
end

function RSEventDB.GetInternalEventOverlay(eventID, mapID)
	if (eventID and mapID) then
		local eventInfo = RSEventDB.GetInternalEventInfoByMapID(eventID, mapID)
		if (eventInfo) then
			return eventInfo.overlay
		end
	end

	return nil
end

function RSEventDB.IsInternalEventMultiZone(eventID)
	local eventInfo = RSEventDB.GetInternalEventInfo(eventID)
	return eventInfo and type(eventInfo.zoneID) == "table"
end

function RSEventDB.IsInternalEventMonoZone(eventID)
	local eventInfo = RSEventDB.GetInternalEventInfo(eventID)
	return eventInfo and type(eventInfo.zoneID) ~= "table"
end

function RSEventDB.IsInternalEventInMap(eventID, mapID)
	if (eventID and mapID) then
		if (RSEventDB.IsInternalEventMultiZone(eventID)) then
			for internalMapID, internalEventInfo in pairs(RSEventDB.GetInternalEventInfo(eventID).zoneID) do
				if (internalMapID == mapID and (not internalEventInfo.artID or RSUtils.Contains(internalEventInfo.artID, C_Map.GetMapArtID(mapID)))) then
					return true;
				end
			end
		elseif (RSEventDB.IsInternalEventMonoZone(eventID)) then
			local eventInfo = RSEventDB.GetInternalEventInfo(eventID)
			if (eventInfo.zoneID == mapID and (not eventInfo.artID or RSUtils.Contains(eventInfo.artID, C_Map.GetMapArtID(mapID)))) then
				return true;
			end
		end
	end

	return false;
end

function RSEventDB.IsWorldMap(eventID)
	if (eventID) then
		local eventInfo = RSEventDB.GetInternalEventInfo(eventID)
		return eventInfo and eventInfo.worldmap
	end
end

function RSEventDB.IsDisabledEvent(eventID)
	if (eventID) then
		local eventInfo = RSEventDB.GetInternalEventInfo(eventID)
		return eventInfo and eventInfo.event and not RSTimeUtils.IsHolidayEventActive(eventInfo.event)
	end
	
	return false
end

---============================================================================
-- Event quest IDs database
----- Stores Events hidden quest IDs
---============================================================================

function RSEventDB.InitEventQuestIdFoundDB()
	if (RSConstants.DEBUG_MODE and not private.dbglobal.event_quest_ids) then
		private.dbglobal.event_quest_ids = {}
	end
end

function RSEventDB.ResetEventQuestIdFoundDB()
	if (private.dbglobal.event_quest_ids) then
		if (RSConstants.DEBUG_MODE) then
			private.dbglobal.event_quest_ids = {}
		else
			private.dbglobal.event_quest_ids = nil
		end
	end
end

function RSEventDB.SetEventQuestIdFound(eventID, questID)
	if (eventID and questID) then
		private.dbglobal.event_quest_ids[eventID] = { questID }
		RSLogger:PrintDebugMessage(string.format("Evento [%s]. Calculado questID [%s]", eventID, questID))
	end
end

function RSEventDB.GetEventQuestIdFound(eventID)
	if (eventID and private.dbglobal.event_quest_ids[eventID]) then
		return private.dbglobal.event_quest_ids[eventID]
	end

	return nil
end

function RSEventDB.RemoveEventQuestIdFound(eventID)
	if (eventID) then
		private.dbglobal.event_quest_ids[eventID] = nil
	end
end

---============================================================================
-- Events names database
----- Stores names of events included with the addon
---============================================================================

function RSEventDB.InitEventNamesDB()
	if (not private.dbglobal.event_names) then
		private.dbglobal.event_names = {}
	end

	if (not private.dbglobal.event_names[GetLocale()]) then
		private.dbglobal.event_names[GetLocale()] = {}
	end
end

function RSEventDB.GetAllEventNames()
	return private.dbglobal.event_names[GetLocale()]
end

function RSEventDB.SetEventName(eventID, name)
	if (eventID and name) then
		private.dbglobal.event_names[GetLocale()][eventID] = name
	end
end

function RSEventDB.GetEventName(eventID)
	if (eventID) then
		if (private.dbglobal.event_names[GetLocale()][eventID]) then
			return private.dbglobal.event_names[GetLocale()][eventID]
		elseif (private.dbglobal.rare_names[GetLocale()][eventID]) then
			local eventName = private.dbglobal.rare_names[GetLocale()][eventID]
			RSEventDB.SetEventName(eventID, eventName)
			return eventName
		elseif (AL[string.format("EVENT_%s", eventID)] ~= string.format("EVENT_%s", eventID)) then
			return AL[string.format("EVENT_%s", eventID)]
		elseif (RSUtils.Contains(RSConstants.EVENTS_SCRAP_HEAP, eventID)) then
			private.dbglobal.object_names[GetLocale()][eventID] = AL["EVENTS_SCRAP_HEAP"]
			return AL["EVENTS_SCRAP_HEAP"]
		end
	end

	return nil
end

function RSEventDB.GetActiveEventIDsWithNamesByMapID(mapID)
	local eventIDs = RSEventDB.GetEventIDsByMapID(mapID)
	local eventIDsWithNames = nil
	
	if (RSUtils.GetTableLength(eventIDs) > 0) then
		eventIDsWithNames = {}
		for _, eventID in ipairs(eventIDs) do
			local eventInfo = RSEventDB.GetInternalEventInfo(eventID)
			if (eventInfo and eventInfo.prof and not RSProfessionDB.HasPlayerProfession(eventInfo.prof)) then
				-- Wrong profession
			elseif (RSEventDB.IsDisabledEvent(eventID)) then
				-- World event disabled
			else
				local eventName = RSEventDB.GetEventName(eventID)
				if (eventName) then
					eventIDsWithNames[eventID] = string.format("%s (%s)", eventName, eventID)
				else
					eventIDsWithNames[eventID] = tostring(eventID)
				end
			end
		end
		
		return eventIDsWithNames
	end
	
	return eventIDsWithNames
end
