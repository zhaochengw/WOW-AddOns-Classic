-----------------------------------------------------------------------
-- AddOn namespace.
-----------------------------------------------------------------------
local ADDON_NAME, private = ...

local LibStub = _G.LibStub
local RareScanner = LibStub("AceAddon-3.0"):GetAddon("RareScanner")
local AL = LibStub("AceLocale-3.0"):GetLocale("RareScanner", false)

local RSZoneFiltersOptions = private.NewLib("RareScannerZoneFiltersOptions")

-- RareScanner database libraries
local RSConfigDB = private.ImportLib("RareScannerConfigDB")
local RSMapDB = private.ImportLib("RareScannerMapDB")

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
			
local currentOrder
local zones = {}

local filterLine = "line_%s_filter"
local filterTypeLine = "line_%s_filtertype"

local function ResetResults()
	-- Remove current results
	for zoneID, _ in pairs (zones) do
		options.args[string.format(filterLine, zoneID)] = nil
		options.args[string.format(filterTypeLine, zoneID)] = nil
	end
	
	-- Remove current npcs
	zones = {}
	
	-- Resets order
	currentOrder = 6
end

local function AddZone(name, zoneID)	
	currentOrder = currentOrder + 1;
	options.args[string.format(filterLine, zoneID)] = {
		order = currentOrder + 0.1,
		type = "toggle",
		name = name,
		desc = string.format(AL["FILTER_DESC"], AL["FILTER_TYPE_ALL"], AL["FILTER_TYPE_WORLDMAP"], AL["FILTER_TYPE_ALERTS"]),
		get = function() 
			if (RSConfigDB.GetZoneFiltered(zoneID) ~= nil) then
				return false
			else
				return true
			end
		end,
		set = function(_, value)
			if (value) then
				RSConfigDB.DeleteZoneFiltered(zoneID)
			else
				RSConfigDB.SetZoneFiltered(zoneID)
			end
			RSMinimap.RefreshAllData(true)
		end,
		width = 2.15
	}
	options.args[string.format(filterTypeLine, zoneID)] = {
		order = currentOrder + 0.2,
		type = "select",
		name = "",
		values = FILTERS_TYPE,
		get = function(_, key)
			return RSConfigDB.GetZoneFiltered(zoneID)
		end,
		set = function(_, key, value)
			RSConfigDB.SetZoneFiltered(zoneID, key)
			RSMinimap.RefreshAllData(true)
		end,
		width = 1.5,
		disabled = function()
			if (RSConfigDB.GetZoneFiltered(zoneID) == nil) then
				return true
			else
				return false
			end
		end
	}
end

local function SearchZoneByContinentID(continentID, zoneName)
	ResetResults();
	
	if (continentID) then
		for mapID, name in pairs(RSMapDB.GetActiveMapIDsWithNamesByMapID(continentID)) do
			if (not zoneName or RSUtils.Contains(name, zoneName)) then
				zones[mapID] = name
			end
		end
	
		-- Sort list by name
		for _, zoneID in ipairs (RSUtils.GetSortedKeysByValue(zones, function(a, b) return a < b end)) do
			AddZone(zones[zoneID], zoneID)
		end
	end
end
		
-----------------------------------------------------------------------
-- Options tab: Zone filters
-----------------------------------------------------------------------

function RSZoneFiltersOptions.GetZoneFiltersOptions()	
	if (not options) then
		options = {
			type = "group",
			name = AL["ZONES_FILTER"],
			handler = RareScanner,
			desc = AL["ZONES_FILTER"],
			args = {
				zoneFiltersSearch = {
					order = 0,
					type = "input",
					name = AL["FILTERS_SEARCH"],
					desc = AL["ZONES_FILTERS_SEARCH_DESC"],
					get = function(_, value) return private.filter_zones_input end,
					set = function(_, value)
						private.filter_zones_input = value
						-- search
						SearchZoneByContinentID(private.filter_zones_continents, value)
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
						if (not private.filter_zones_continents) then
							private.filter_zones_continents = RSConstants.CURRENT_MAP_ID
						end

						return private.filter_zones_continents
					end,
					set = function(_, key, value)
						private.filter_zones_continents = key

						-- search
						SearchZoneByContinentID(key, private.filter_zones_input)
					end,
					width = 1.0,
				},
				zoneFiltersClear = {
					order = 1.2,
					name = AL["CLEAR_FILTERS_SEARCH"],
					desc = AL["CLEAR_FILTERS_SEARCH_DESC"],
					type = "execute",
					func = function()
						private.filter_zones_input = nil
						private.filter_zones_continents = RSConstants.CURRENT_MAP_ID
						-- search
						SearchZoneByContinentID(RSConstants.CURRENT_MAP_ID)
					end,
					width = 0.5,
				},
				separator = {
					order = 2,
					type = "header",
					name = AL["ZONES_FILTER"],
				},
				defaultFilter = {
					order = 3.1,
					type = "select",
					name = AL["FILTER_DEFAULT"],
					desc = string.format(AL["FILTER_DEFAULT_DESC"], AL["FILTERS_FILTER_ALL"]),
					values = FILTERS_TYPE,
					get = function(_, key) return RSConfigDB.GetDefaultZoneFilter() end,
					set = function(_, key, value)
						RSConfigDB.SetDefaultZoneFilter(key)
					end,
					width = 1.65,
				},
				filterAllButton = {
					order = 3.2,
					name = AL["FILTERS_FILTER_ALL"],
					desc = AL["FILTERS_FILTER_ALL_DESC"],
					type = "execute",
					func = function()
						for zoneID, _ in pairs(zones) do
							if (RSConfigDB.GetZoneFiltered(zoneID) == nil) then
								RSConfigDB.SetZoneFiltered(zoneID)
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
						for zoneID, _ in pairs(zones) do
							RSConfigDB.DeleteZoneFiltered(zoneID)
						end
						
						RSMinimap.RefreshAllData(true)
					end,
					width = 1,
				},
			},
		}

		-- launch first search zone filters
		SearchZoneByContinentID(RSConstants.CURRENT_MAP_ID)
	end

	return options
end
