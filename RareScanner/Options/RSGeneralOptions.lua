-----------------------------------------------------------------------
-- AddOn namespace.
-----------------------------------------------------------------------
local ADDON_NAME, private = ...

local LibStub = _G.LibStub
local RareScanner = LibStub("AceAddon-3.0"):GetAddon("RareScanner")
local AL = LibStub("AceLocale-3.0"):GetLocale("RareScanner", false)
local LibDialog = LibStub("LibDialog-1.0RS")

local RSGeneralOptions = private.NewLib("RareScannerGeneralOptions")

-- RareScanner database libraries
local RSConfigDB = private.ImportLib("RareScannerConfigDB")

-- RareScanner services
local RSMacro = private.ImportLib("RareScannerMacro")

-- RareScanner internal libraries
local RSConstants = private.ImportLib("RareScannerConstants")

local options

-----------------------------------------------------------------------
-- Target markers
-----------------------------------------------------------------------

private.TARGET_MARKERS = {
	["Star"] = "Interface\\TARGETINGFRAME\\UI-RaidTargetingIcon_1",
	["Circle"] = "Interface\\TARGETINGFRAME\\UI-RaidTargetingIcon_2",
	["Diamond"] = "Interface\\TARGETINGFRAME\\UI-RaidTargetingIcon_3",
	["Triangle"] = "Interface\\TARGETINGFRAME\\UI-RaidTargetingIcon_4",
	["Moon"] = "Interface\\TARGETINGFRAME\\UI-RaidTargetingIcon_5",
	["Square"] = "Interface\\TARGETINGFRAME\\UI-RaidTargetingIcon_6",
	["Cross"] = "Interface\\TARGETINGFRAME\\UI-RaidTargetingIcon_7",
	["Skull"] = "Interface\\TARGETINGFRAME\\UI-RaidTargetingIcon_8",
}

-----------------------------------------------------------------------
-- Functions
-----------------------------------------------------------------------

local orderedMarkers

local function GetOrderedMarkers()
	if (not orderedMarkers) then
		orderedMarkers = {}
	
		for _, v in pairs(private.TARGET_MARKERS) do
			orderedMarkers[#orderedMarkers+1] = v
		end
		table.sort(orderedMarkers, function(a,b) return string.upper(a) < string.upper(b) end)
	end
	
	return orderedMarkers
end

local function SetMarker(key)
	if (key) then
		for k, m in pairs (private.TARGET_MARKERS) do
			if (k == key) then
				for index, v in ipairs(GetOrderedMarkers()) do
					if (m == v) then
						RSConfigDB.SetMarkerOnTarget(index)
					end
				end
			end
		end
	end
end

local function GetMarker()
	for index, v in ipairs(GetOrderedMarkers()) do
		if (private.db.general.marker == index) then
			for key, m in pairs (private.TARGET_MARKERS) do
				if (m == v) then
					return key
				end
			end
		end
	end
end

-----------------------------------------------------------------------
-- Options tab: General
-----------------------------------------------------------------------

function RSGeneralOptions.GetGeneralOptions()
	if (not options) then
		options = {
			type = "group",
			name = _G.GENERAL_LABEL,
			handler = RareScanner,
			desc = AL["options"],
			args = {
				rescanTimer = {
					order = 0,
					type = "range",
					name = AL["RESCAN_TIMER"],
					desc = AL["RESCAN_TIMER_DESC"],
					min	= 1,
					max	= 60,
					step = 1,
					bigStep = 1,
					get = function() return RSConfigDB.GetRescanTimer() end,
					set = function(_, value)
						RSConfigDB.SetRescanTimer(value)
					end,
					width = "full",
				},
				scanRares = {
					order = 1,
					name = AL["ENABLE_SCAN_RARES"],
					desc = AL["ENABLE_SCAN_RARES_DESC"],
					type = "toggle",
					get = function() return RSConfigDB.IsScanningForNpcs() end,
					set = function(_, value)
						RSConfigDB.SetScanningForNpcs(value)
					end,
					width = "full",
				},
				scanContainers = {
					order = 2,
					name = AL["ENABLE_SCAN_CONTAINERS"],
					desc = AL["ENABLE_SCAN_CONTAINERS_DESC"],
					type = "toggle",
					get = function() return RSConfigDB.IsScanningForContainers() end,
					set = function(_, value)
						RSConfigDB.SetScanningForContainers(value)
					end,
					width = "full",
				},
				scanEvents = {
					order = 3,
					name = AL["ENABLE_SCAN_EVENTS"],
					desc = AL["ENABLE_SCAN_EVENTS_DESC"],
					type = "toggle",
					get = function() return RSConfigDB.IsScanningForEvents() end,
					set = function(_, value)
						RSConfigDB.SetScanningForEvents(value)
					end,
					width = "full",
				},
				scanChatAlerts = {
					order = 4,
					name = AL["ENABLE_SCAN_CHAT"],
					desc = AL["ENABLE_SCAN_CHAT_DESC"],
					type = "toggle",
					get = function() return RSConfigDB.IsScanningChatAlerts() end,
					set = function(_, value)
						RSConfigDB.SetScanningChatAlerts(value)
					end,
					width = "full",
				},
				scanInstances = {
					order = 5,
					name = AL["ENABLE_SCAN_IN_INSTANCE"],
					desc = AL["ENABLE_SCAN_IN_INSTANCE_DESC"],
					type = "toggle",
					get = function() return RSConfigDB.IsScanningInInstances() end,
					set = function(_, value)
						RSConfigDB.SetScanningInInstance(value)
					end,
					width = "full",
				},
				scanOnTaxi = {
					order = 6,
					name = AL["ENABLE_SCAN_ON_TAXI"],
					desc = AL["ENABLE_SCAN_ON_TAXI_DESC"],
					type = "toggle",
					get = function() return RSConfigDB.IsScanningWhileOnTaxi() end,
					set = function(_, value)
						RSConfigDB.SetScanningWhileOnTaxi(value)
					end,
					width = "full",
				},
				scanOnPetBattle = {
					order = 7,
					name = AL["ENABLE_SCAN_ON_PET_BATTLE"],
					desc = AL["ENABLE_SCAN_ON_PET_BATTLE_DESC"],
					type = "toggle",
					get = function() return RSConfigDB.IsScanningWhileOnPetBattle() end,
					set = function(_, value)
						RSConfigDB.SetScanningWhileOnPetBattle(value)
					end,
					width = "full",
				},
				scanWorldMapVignettes = {
					order = 8,
					name = AL["ENABLE_SCAN_WORLDMAP_VIGNETTES"],
					desc = AL["ENABLE_SCAN_WORLDMAP_VIGNETTES_DESC"],
					type = "toggle",
					get = function() return RSConfigDB.IsScanningWorldMapVignettes() end,
					set = function(_, value)
						RSConfigDB.SetScanningWorldMapVignettes(value)
					end,
					width = "full",
				},
				ignoreCompletedEntities = {
					order = 9,
					name = AL["IGNORE_SCAN_COMPLETED_ENTITIES"],
					desc = AL["IGNORE_SCAN_COMPLETED_ENTITIES_DESC"],
					type = "toggle",
					get = function() return RSConfigDB.IsIgnoringCompletedEntities() end,
					set = function(_, value)
						RSConfigDB.SetIgnoringCompletedEntities(value)
					end,
					width = "full",
				},
				scanWithMacro = {
					order = 10,
					name = AL["ENABLE_SCAN_MACRO"],
					desc = AL["ENABLE_SCAN_MACRO_DESC"],
					type = "toggle",
					get = function() return RSConfigDB.IsScanningWithMacro() end,
					set = function(_, value)
						RSConfigDB.SetScanningWithMacro(value)
						if (value) then
							RSMacro.CreateMacro()
						else
							RSMacro.DeleteMacro()
						end
					end,
					validate = function(_, value)
						-- Check numer of macros
						if (not RSMacro.IsAvailableMacroSlot()) then
							return AL["ENABLE_SCAN_MACRO_ERROR"]
						end
						
						return true
					end,
					width = "full",
				},
				showMaker = {
					order = 11,
					name = AL["ENABLE_MARKER"],
					desc = AL["ENABLE_MARKER_DESC"],
					type = "toggle",
					get = function() return RSConfigDB.IsDisplayingMarkerOnTarget() end,
					set = function(_, value)
						RSConfigDB.SetDisplayingMarkerOnTarget(value)
					end,
					width = "full",
				},
				marker = {
					order = 12,
					type = "select",
					dialogControl = 'RS_Markers',
					name = AL["MARKER"],
					desc = AL["MARKER_DESC"],
					values = private.TARGET_MARKERS,
					get = function() return GetMarker() end,
					set = function(_, value)
						SetMarker(value)
					end,
					width = "normal",
					disabled = function() return not RSConfigDB.IsDisplayingMarkerOnTarget() end,
				},
				separatorTomtomWaypoints = {
					order = 13,
					type = "header",
					name = AL["TOMTOM_WAYPOINTS"],
				},
				enableTomtomSupport = {
					order = 14,
					name = AL["ENABLE_TOMTOM_SUPPORT"],
					desc = AL["ENABLE_TOMTOM_SUPPORT_DESC"],
					type = "toggle",
					get = function() return RSConfigDB.IsTomtomSupportEnabled() end,
					set = function(_, value)
						RSConfigDB.SetTomtomSupportEnabled(value)
						if (not value) then
							RSConfigDB.SetAddingTomtomWaypointsAutomatically(false)
						end
					end,
					width = "full",
					disabled = function() return not TomTom end,
				},
				autoTomtomWaypoints = {
					order = 15,
					name = AL["ENABLE_AUTO_TOMTOM_WAYPOINTS"],
					desc = AL["ENABLE_AUTO_TOMTOM_WAYPOINTS_DESC"],
					type = "toggle",
					get = function() return RSConfigDB.IsAddingTomtomWaypointsAutomatically() end,
					set = function(_, value)
						RSConfigDB.SetAddingTomtomWaypointsAutomatically(value)
					end,
					width = "full",
					disabled = function() return not RSConfigDB.IsTomtomSupportEnabled() end,
				}
			},
		}
	end

	return options
end