-----------------------------------------------------------------------
-- AddOn namespace.
-----------------------------------------------------------------------
local ADDON_NAME, private = ...

local LibStub = _G.LibStub
local RareScanner = LibStub("AceAddon-3.0"):GetAddon("RareScanner")
local AL = LibStub("AceLocale-3.0"):GetLocale("RareScanner", false)

local RSEventFiltersOptions = private.NewLib("RareScannerEventFiltersOptions")

-- RareScanner database libraries
local RSConfigDB = private.ImportLib("RareScannerConfigDB")
local RSMapDB = private.ImportLib("RareScannerMapDB")
local RSEventDB = private.ImportLib("RareScannerEventDB")

-- RareScanner internal libraries
local RSUtils = private.ImportLib("RareScannerUtils")
local RSConstants = private.ImportLib("RareScannerConstants")

-- RareScanner service libraries
local RSMinimap = private.ImportLib("RareScannerMinimap")
local RSMap = private.ImportLib("RareScannerMap")

local options

-----------------------------------------------------------------------
-- Filters types
-----------------------------------------------------------------------

local FILTERS_TYPE = {}
FILTERS_TYPE[RSConstants.ENTITY_FILTER_ALL] = AL["FILTER_TYPE_ALL"];
FILTERS_TYPE[RSConstants.ENTITY_FILTER_WORLDMAP] = AL["FILTER_TYPE_WORLDMAP"];
FILTERS_TYPE[RSConstants.ENTITY_FILTER_ALERTS] = AL["FILTER_TYPE_ALERTS"];

-----------------------------------------------------------------------
-- Functions
-----------------------------------------------------------------------

local continent_map_ids

local function GetContinentMapIds()
	if (not continent_map_ids) then
		continent_map_ids = {}
		
		for k, v in pairs(RSMapDB.GetContinents()) do
			if (v.zonefilter) then
				if (v.id) then
					continent_map_ids[k] = RSMapDB.GetMapName(k)
				else
					continent_map_ids[k] = AL["ZONES_CONTINENT_LIST"][k]
				end
			end
		end
	end
	
	return continent_map_ids
end

local function LoadSubmapCombo(continentID)
	if (continentID) then
		options.args.subzones.values = {}
		private.filter_events_subzones = nil
		table.foreach(RSMapDB.GetContinents()[continentID].zones, function(index, mapID)
			local mapName = RSMapDB.GetMapName(mapID)
			if (mapName) then
				options.args.subzones.values[mapID] = mapName
			end
		end)
	end
end
			
local currentOrder
local events = {}

local filterLine = "line_%s_filter"
local filterTypeLine = "line_%s_filtertype"

local function ResetResults()
	-- Remove current results
	for eventID, _ in pairs (events) do
		options.args[string.format(filterLine, eventID)] = nil
		options.args[string.format(filterTypeLine, eventID)] = nil
	end
	
	-- Remove current events
	events = {}
	
	-- Resets order
	currentOrder = 6
end

local function AddEvent(name, eventID)
	currentOrder = currentOrder + 1;
	options.args[string.format(filterLine, eventID)] = {
		order = currentOrder + 0.1,
		type = "toggle",
		name = name,
		desc = string.format(AL["FILTER_DESC"], AL["FILTER_TYPE_ALL"], AL["FILTER_TYPE_WORLDMAP"], AL["FILTER_TYPE_ALERTS"]),
		get = function() 
			if (RSConfigDB.GetEventFiltered(eventID) ~= nil) then
				return false
			else
				return true
			end
		end,
		set = function(_, value)
			if (value) then
				RSConfigDB.DeleteEventFiltered(eventID)
			else
				RSConfigDB.SetEventFiltered(eventID)
			end
			RSMinimap.RefreshAllData(true)
		end,
		width = 2.15
	}
	options.args[string.format(filterTypeLine, eventID)] = {
		order = currentOrder + 0.2,
		type = "select",
		name = "",
		values = FILTERS_TYPE,
		get = function(_, key)
			return RSConfigDB.GetEventFiltered(eventID)
		end,
		set = function(_, key, value)
			RSConfigDB.SetEventFiltered(eventID, key)
			RSMinimap.RefreshAllData(true)
		end,
		width = 1.5,
		disabled = function()
			if (RSConfigDB.GetEventFiltered(eventID) == nil) then
				return true
			else
				return false
			end
		end
	}
end

local function SearchEventByZoneID(mapID, eventName, isContinentZone)
	if (not isContinentZone) then
		ResetResults();
	end
	
	if (mapID) then
		local eventIDsWithNames = RSEventDB.GetActiveEventIDsWithNamesByMapID(mapID)
		if (RSUtils.GetTableLength(eventIDsWithNames) > 0) then
			for eventID, name in pairs(eventIDsWithNames) do
				if (not eventName or RSUtils.Contains(name, eventName)) then
					events[eventID] = name
				end
			end
		end
	end
	
	if (not isContinentZone) then
		-- Sort list by name
		for _, eventID in ipairs (RSUtils.GetSortedKeysByValue(events, function(a, b) return a < b end)) do
			AddEvent(events[eventID], eventID)
		end
	end
end

local function SearchEventByContinentID(continentID, eventName)
	ResetResults();
	
	if (continentID) then
		table.foreach(RSMapDB.GetContinents()[continentID].zones, function(index, zoneID)
			-- filter checkboxes
			SearchEventByZoneID(zoneID, eventName, true)
		end)
	
		-- Sort list by name
		for _, eventID in ipairs (RSUtils.GetSortedKeysByValue(events, function(a, b) return a < b end)) do
			AddEvent(events[eventID], eventID)
		end
	end
end

-----------------------------------------------------------------------
-- Options tab: Events filters
-----------------------------------------------------------------------

function RSEventFiltersOptions.GetEventFiltersOptions()
	if (not options) then	
		options = {
			type = "group",
			name = AL["EVENT_FILTER"],
			handler = RareScanner,
			desc = AL["EVENT_FILTER"],
			args = {
				eventFiltersSearch = {
					order = 0,
					type = "input",
					name = AL["FILTERS_SEARCH"],
					desc = AL["FILTERS_EVENTS_SEARCH_DESC"],
					get = function(_, value) return private.filter_events_input end,
					set = function(_, value)
						private.filter_events_input = value
						
						-- search
						if (private.filter_events_subzones) then
							if (not value or string.len(value) < 3) then
								SearchEventByZoneID(private.filter_events_subzones, value)
							else
								SearchEventByContinentID(private.filter_events_continents, value)
							end
						else
							SearchEventByContinentID(private.filter_events_continents, value)
						end
					end,
					width = "full",
				},
				continents = {
					order = 1.1,
					type = "select",
					name = AL["FILTER_CONTINENT"],
					desc = AL["FILTER_CONTINENT_DESC"],
					values = GetContinentMapIds(),
					sorting = function()
						return RSUtils.GetSortedKeysByValue(options.args.continents.values, function(a, b) return a < b end)
					end,
					get = function(_, key)
						-- initialize
						if (not private.filter_events_continents) then
							private.filter_events_continents = RSConstants.CURRENT_MAP_ID
						end

						return private.filter_events_continents
					end,
					set = function(_, key, value)
						private.filter_events_continents = key

						-- load subzones combo
						LoadSubmapCombo(key)

						-- autoselect first element and search
						if (RSUtils.GetTableLength(options.args.subzones.values) > 0) then
							local sortedKeys = RSUtils.GetSortedKeysByValue(options.args.subzones.values, function(a, b) return a < b end)
							for _, zoneID in pairs(sortedKeys) do
								private.filter_events_subzones = zoneID
								SearchEventByZoneID(zoneID, private.filter_events_input)
								break
							end
						end
					end,
					width = 1.0,
				},
				subzones = {
					order = 1.2,
					type = "select",
					name = AL["FILTER_ZONE"],
					desc = AL["FILTER_ZONE_DESC"],
					values = {},
					sorting = function()
						return RSUtils.GetSortedKeysByValue(options.args.subzones.values, function(a, b) return a < b end)
					end,
					get = function(_, key)
						-- initialize
						if (not private.filter_events_subzones) then
							private.filter_events_subzones = RSConstants.CURRENT_SUBMAP_ID
						end

						return private.filter_events_subzones
					end,
					set = function(_, key, value)
						private.filter_events_subzones = key

						-- search
						SearchEventByZoneID(key, private.filter_events_input)
					end,
					width = 1.925,
					disabled = function() return (next(options.args.subzones.values) == nil) end,
				},
				eventFiltersClear = {
					order = 1.3,
					name = AL["CLEAR_FILTERS_SEARCH"],
					desc = AL["CLEAR_FILTERS_SEARCH_DESC"],
					type = "execute",
					func = function()
						private.filter_events_input = nil
						options.args.subzones.values = {}
						private.filter_events_subzones = RSConstants.CURRENT_SUBMAP_ID
						private.filter_events_continents = RSConstants.CURRENT_MAP_ID
						-- load subzones combo
						LoadSubmapCombo(RSConstants.CURRENT_MAP_ID)
						-- search
						SearchEventByZoneID(RSConstants.CURRENT_SUBMAP_ID)
					end,
					width = 0.5,
				},
				separator = {
					order = 2,
					type = "header",
					name = AL["EVENT_FILTER"],
				},
				defaultFilter = {
					order = 3.1,
					type = "select",
					name = AL["FILTER_DEFAULT"],
					desc = string.format(AL["FILTER_DEFAULT_DESC"], AL["FILTERS_FILTER_ALL"]),
					values = FILTERS_TYPE,
					get = function(_, key) return RSConfigDB.GetDefaultEventFilter() end,
					set = function(_, key, value)
						RSConfigDB.SetDefaultEventFilter(key)
					end,
					width = 1.65,
				},
				filterAllButton = {
					order = 3.2,
					name = AL["FILTERS_FILTER_ALL"],
					desc = AL["FILTERS_FILTER_ALL_DESC"],
					type = "execute",
					func = function()
						for eventID, _ in pairs(events) do
							if (RSConfigDB.GetEventFiltered(eventID) == nil) then
								RSConfigDB.SetEventFiltered(eventID)
							end
						end
						
						RSMinimap.RefreshAllData(true)
					end,
					width = 1,
				},
				unfilterAllButton = {
					order = 3.3,
					name = AL["FILTERS_UNFILTER_ALL"],
					desc = AL["FILTERS_UNFILTER_ALL_DESC"],
					type = "execute",
					func = function()
						for eventID, _ in pairs(events) do
							RSConfigDB.DeleteEventFiltered(eventID)
						end
						
						RSMinimap.RefreshAllData(true)
					end,
					width = 1,
				},
			},
		}
		
		-- load submaps combo
		LoadSubmapCombo(RSConstants.CURRENT_MAP_ID)

		-- launch first search zone filters
		SearchEventByZoneID(RSConstants.CURRENT_SUBMAP_ID)
	end

	return options
end