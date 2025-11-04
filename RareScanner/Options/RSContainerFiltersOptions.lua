-----------------------------------------------------------------------
-- AddOn namespace.
-----------------------------------------------------------------------
local ADDON_NAME, private = ...

local LibStub = _G.LibStub
local RareScanner = LibStub("AceAddon-3.0"):GetAddon("RareScanner")
local AL = LibStub("AceLocale-3.0"):GetLocale("RareScanner", false)

local RSContainerFiltersOptions = private.NewLib("RareScannerContainerFiltersOptions")

-- RareScanner database libraries
local RSConfigDB = private.ImportLib("RareScannerConfigDB")
local RSMapDB = private.ImportLib("RareScannerMapDB")
local RSContainerDB = private.ImportLib("RareScannerContainerDB")

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
		private.filter_options_subzones = nil
		table.foreach(RSMapDB.GetContinents()[continentID].zones, function(index, mapID)
			local mapName = RSMapDB.GetMapName(mapID)
			if (mapName) then
				options.args.subzones.values[mapID] = mapName
			end
		end)
	end
end
			
local currentOrder
local containers = {}

local filterLine = "line_%s_filter"
local filterTypeLine = "line_%s_filtertype"

local function ResetResults()
	-- Remove current results
	for containerID, _ in pairs (containers) do
		options.args[string.format(filterLine, containerID)] = nil
		options.args[string.format(filterTypeLine, containerID)] = nil
	end
	
	-- Remove current containers
	containers = {}
	
	-- Resets order
	currentOrder = 6
end

local function AddContainer(name, containerID)	
	currentOrder = currentOrder + 1;
	options.args[string.format(filterLine, containerID)] = {
		order = currentOrder + 0.1,
		type = "toggle",
		name = name,
		desc = string.format(AL["FILTER_DESC"], AL["FILTER_TYPE_ALL"], AL["FILTER_TYPE_WORLDMAP"], AL["FILTER_TYPE_ALERTS"]),
		get = function() 
			if (RSConfigDB.GetContainerFiltered(containerID) ~= nil) then
				return false
			else
				return true
			end
		end,
		set = function(_, value)
			if (value) then
				RSConfigDB.DeleteContainerFiltered(containerID)
			else
				RSConfigDB.SetContainerFiltered(containerID)
			end
			RSMinimap.RefreshAllData(true)
		end,
		width = 2.15
	}
	options.args[string.format(filterTypeLine, containerID)] = {
		order = currentOrder + 0.2,
		type = "select",
		name = "",
		values = FILTERS_TYPE,
		get = function(_, key)
			return RSConfigDB.GetContainerFiltered(containerID)
		end,
		set = function(_, key, value)
			RSConfigDB.SetContainerFiltered(containerID, key)
			RSMinimap.RefreshAllData(true)
		end,
		width = 1.5,
		disabled = function()
			if (RSConfigDB.GetContainerFiltered(containerID) == nil) then
				return true
			else
				return false
			end
		end
	}
end

local function SearchContainerByZoneID(mapID, containerName, isContinentZone)
	if (not isContinentZone) then
		ResetResults();
	end
	
	if (mapID) then
		local containerIDsWithNames = RSContainerDB.GetActiveContainerIDsWithNamesByMapID(mapID)
		if (RSUtils.GetTableLength(containerIDsWithNames) > 0) then
			for containerID, name in pairs(containerIDsWithNames) do
				if (not containerName or RSUtils.Contains(name, containerName)) then
					containers[containerID] = name
				end
			end
		end
	end
	
	if (not isContinentZone) then
		-- Sort list by name
		for _, containerID in ipairs (RSUtils.GetSortedKeysByValue(containers, function(a, b) return a < b end)) do
			AddContainer(containers[containerID], containerID)
		end
	end
end

local function SearchContainerByContinentID(continentID, containerName)
	ResetResults();
		
	if (continentID) then
		table.foreach(RSMapDB.GetContinents()[continentID].zones, function(index, zoneID)
			SearchContainerByZoneID(zoneID, containerName, true)
		end)
	
		-- Sort list by name
		for _, containerID in ipairs (RSUtils.GetSortedKeysByValue(containers, function(a, b) return a < b end)) do
			AddContainer(containers[containerID], containerID)
		end
	end
end

-----------------------------------------------------------------------
-- Options tab: Container filters
-----------------------------------------------------------------------

function RSContainerFiltersOptions.GetContainerFiltersOptions()
	if (not options) then	
		options = {
			type = "group",
			name = AL["CONTAINER_FILTER"],
			handler = RareScanner,
			desc = AL["CONTAINER_FILTER"],
			args = {
				containerFiltersSearch = {
					order = 0,
					type = "input",
					name = AL["FILTERS_SEARCH"],
					desc = AL["FILTERS_CONTAINERS_SEARCH_DESC"],
					get = function(_, value) return private.filter_containers_input end,
					set = function(_, value)
						private.filter_containers_input = value
						-- search
						if (private.filter_containers_subzones) then
							if (not value or string.len(value) < 3) then
								SearchContainerByZoneID(private.filter_containers_subzones, value)
							else
								SearchContainerByContinentID(private.filter_containers_continents, value)
							end
						else
							SearchContainerByContinentID(private.filter_containers_continents, value)
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
						if (not private.filter_containers_continents) then
							private.filter_containers_continents = RSConstants.CURRENT_MAP_ID
						end

						return private.filter_containers_continents
					end,
					set = function(_, key, value)
						private.filter_containers_continents = key

						-- load subzones combo
						LoadSubmapCombo(key)

						-- autoselect first element and search
						if (RSUtils.GetTableLength(options.args.subzones.values) > 0) then
							local sortedKeys = RSUtils.GetSortedKeysByValue(options.args.subzones.values, function(a, b) return a < b end)
							for _, zoneID in pairs(sortedKeys) do
								private.filter_containers_subzones = zoneID
								SearchContainerByZoneID(zoneID, private.filter_containers_input)
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
						if (not private.filter_containers_subzones) then
							private.filter_containers_subzones = RSConstants.CURRENT_SUBMAP_ID
						end

						return private.filter_containers_subzones
					end,
					set = function(_, key, value)
						private.filter_containers_subzones = key

						-- search
						SearchContainerByZoneID(key, private.filter_containers_input)
					end,
					width = 1.925,
					disabled = function() return (next(options.args.subzones.values) == nil) end,
				},
				containerFiltersClear = {
					order = 1.3,
					name = AL["CLEAR_FILTERS_SEARCH"],
					desc = AL["CLEAR_FILTERS_SEARCH_DESC"],
					type = "execute",
					func = function()
						private.filter_containers_input = nil
						options.args.subzones.values = {}
						private.filter_containers_subzones = RSConstants.CURRENT_SUBMAP_ID
						private.filter_containers_continents = RSConstants.CURRENT_MAP_ID
						-- load subzones combo
						LoadSubmapCombo(RSConstants.CURRENT_MAP_ID)
						-- search
						SearchContainerByZoneID(RSConstants.CURRENT_SUBMAP_ID)
					end,
					width = 0.5,
				},
				separator = {
					order = 2,
					type = "header",
					name = AL["CONTAINER_FILTER"],
				},
				defaultFilter = {
					order = 3.1,
					type = "select",
					name = AL["FILTER_DEFAULT"],
					desc = string.format(AL["FILTER_DEFAULT_DESC"], AL["FILTERS_FILTER_ALL"]),
					values = FILTERS_TYPE,
					get = function(_, key) return RSConfigDB.GetDefaultContainerFilter() end,
					set = function(_, key, value)
						RSConfigDB.SetDefaultContainerFilter(key)
					end,
					width = 1.65,
				},
				filterAllButton = {
					order = 3.2,
					name = AL["FILTERS_FILTER_ALL"],
					desc = AL["FILTERS_FILTER_ALL_DESC"],
					type = "execute",
					func = function()
						for containerID, containerName in pairs(containers) do
							if (RSConfigDB.GetContainerFiltered(containerID) == nil) then
								RSConfigDB.SetContainerFiltered(containerID)
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
						for containerID, containerName in pairs(containers) do
							RSConfigDB.DeleteContainerFiltered(containerID)
						end
						
						RSMinimap.RefreshAllData(true)
					end,
					width = 1,
				},
			}
		}
		
		-- load submaps combo
		LoadSubmapCombo(RSConstants.CURRENT_MAP_ID)

		-- launch first search zone filters
		SearchContainerByZoneID(RSConstants.CURRENT_SUBMAP_ID)
	end

	return options
end
