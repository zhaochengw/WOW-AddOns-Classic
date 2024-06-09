-----------------------------------------------------------------------
-- AddOn namespace.
-----------------------------------------------------------------------
local ADDON_NAME, private = ...

local LibStub = _G.LibStub
local RareScanner = LibStub("AceAddon-3.0"):GetAddon("RareScanner")
local AL = LibStub("AceLocale-3.0"):GetLocale("RareScanner", false)

local RSDisplayOptions = private.NewLib("RareScannerDisplayOptions")

-- RareScanner database libraries
local RSConfigDB = private.ImportLib("RareScannerConfigDB")

-- RareScanner internal libraries
local RSConstants = private.ImportLib("RareScannerConstants")

-- RareScanner service libraries
local RSMinimap = private.ImportLib("RareScannerMinimap")
local RSMap = private.ImportLib("RareScannerMap")

local options

-----------------------------------------------------------------------
-- Options tab: Display
-----------------------------------------------------------------------

function RSDisplayOptions.GetDisplayOptions()	
	if (not options) then
		options = {
			type = "group",
			name = AL["DISPLAY"],
			handler = RareScanner,
			desc = AL["options"],
			args = {
				separatorMainButton = {
					order = 0,
					type = "header",
					name = AL["MAIN_BUTTON_OPTIONS"],
				},
				displayButton = {
					order = 1,
					type = "toggle",
					name = AL["DISPLAY_BUTTON"],
					desc = AL["DISPLAY_BUTTON_DESC"],
					get = function() return RSConfigDB.IsButtonDisplaying() end,
					set = function(_, value)
						RSConfigDB.SetButtonDisplaying(value)
					end,
					width = "full",
				},
				displayMiniature = {
					order = 2,
					type = "toggle",
					name = AL["DISPLAY_MINIATURE"],
					desc = AL["DISPLAY_MINIATURE_DESC"],
					get = function() return RSConfigDB.IsDisplayingModel() end,
					set = function(_, value)
						RSConfigDB.SetDisplayingModel(value)
					end,
					width = "full",
					disabled = function() return not RSConfigDB.IsButtonDisplaying() end,
				},
				displayButtonContainers = {
					order = 3,
					type = "toggle",
					name = AL["DISPLAY_BUTTON_CONTAINERS"],
					desc = AL["DISPLAY_BUTTON_CONTAINERS_DESC"],
					get = function() return RSConfigDB.IsButtonDisplayingForContainers() end,
					set = function(_, value)
						RSConfigDB.SetButtonDisplayingForContainers(value)
					end,
					width = "full",
					disabled = function() return not RSConfigDB.IsButtonDisplaying() end,
				},
				autoHideButton = {
					order = 4,
					type = "range",
					name = AL["AUTO_HIDE_BUTTON"],
					desc = AL["AUTO_HIDE_BUTTON_DESC"],
					min	= 0,
					max	= 60,
					step	= 5,
					bigStep = 5,
					get = function() return RSConfigDB.GetAutoHideButtonTime() end,
					set = function(_, value)
						RSConfigDB.SetAutoHideButtonTime(value)
					end,
					width = "full",
					disabled = function() return not RSConfigDB.IsButtonDisplaying() end,
				},
				separatorButtonPosition = {
					order = 5,
					type = "header",
					name = AL["DISPLAY_BUTTON_SCALE_POSITION"],
				},
				scale = {
					order = 6.1,
					type = "range",
					name = AL["DISPLAY_BUTTON_SCALE"],
					desc = AL["DISPLAY_BUTTON_SCALE_DESC"],
					min	= 0.4,
					max	= 1.1,
					step = 0.01,
					bigStep = 0.05,
					get = function() return RSConfigDB.GetButtonScale() end,
					set = function(_, value)
						RSConfigDB.SetButtonScale(value)
					end,
					width = "double",
					disabled = function() return not RSConfigDB.IsButtonDisplaying() end,
				},
				test = {
					order = 6.2,
					name = AL["TEST"],
					desc = AL["TEST_DESC"],
					type = "execute",
					func = function() RareScanner:Test() end,
					width = "normal",
				},
				lockPosition = {
					order = 7.1,
					type = "toggle",
					name = AL["LOCK_BUTTON_POSITION"],
					desc = AL["LOCK_BUTTON_POSITION_DESC"],
					get = function() return RSConfigDB.IsLockingPosition() end,
					set = function(_, value)
						RSConfigDB.SetLockingPosition(value)
					end,
					width = "double",
				},
				resetPosition = {
					order = 7.2,
					name = AL["RESET_POSITION"],
					desc = AL["RESET_POSITION_DESC"],
					type = "execute",
					func = function() RareScanner:ResetPosition() end,
					width = "normal",
				},
				separatorMessages = {
					order = 8,
					type = "header",
					name = AL["MESSAGE_OPTIONS"],
				},
				displayRaidWarning = {
					order = 9,
					type = "toggle",
					name = AL["SHOW_RAID_WARNING"],
					desc = AL["SHOW_RAID_WARNING_DESC"],
					get = function() return RSConfigDB.IsDisplayingRaidWarning() end,
					set = function(_, value)
						RSConfigDB.SetDisplayingRaidWarning(value)
					end,
					width = "full",
				},
				displayChatMessage = {
					order = 10,
					type = "toggle",
					name = AL["SHOW_CHAT_ALERT"],
					desc = AL["SHOW_CHAT_ALERT_DESC"],
					get = function() return RSConfigDB.IsDisplayingChatMessages() end,
					set = function(_, value)
						RSConfigDB.SetDisplayingChatMessages(value)
					end,
					width = "full",
				},
				displayChatTimestampMessage = {
					order = 11,
					type = "toggle",
					name = AL["SHOW_CHAT_TIMESTAMP_ALERT"],
					desc = AL["SHOW_CHAT_TIMESTAMP_ALERT_DESC"],
					get = function() return RSConfigDB.IsDisplayingTimestampChatMessages() end,
					set = function(_, value)
						RSConfigDB.SetDisplayingTimestampChatMessages(value)
					end,
					width = "full",
					disabled = function() return not RSConfigDB.IsDisplayingChatMessages() end,
				},
				separatorNavigation = {
					order = 12,
					type = "header",
					name = AL["NAVIGATION_OPTIONS"],
				},
				enableNavigation = {
					order = 13,
					type = "toggle",
					name = AL["NAVIGATION_ENABLE"],
					desc = AL["NAVIGATION_ENABLE_DESC"],
					get = function() return RSConfigDB.IsDisplayingNavigationArrows() end,
					set = function(_, value)
						RSConfigDB.SetDisplayingNavigationArrows(value)
					end,
					width = "full",
				},
				navigationLockEntity = {
					order = 14,
					type = "toggle",
					name = AL["NAVIGATION_LOCK_ENTITY"],
					desc = AL["NAVIGATION_LOCK_ENTITY_DESC"],
					get = function() return RSConfigDB.IsNavigationLockEnabled() end,
					set = function(_, value)
						RSConfigDB.SetNavigationLockEnabled(value)
					end,
					width = "full",
					disabled = function() return not RSConfigDB.IsDisplayingNavigationArrows() end,
				},
				separatorMap = {
					order = 15,
					type = "header",
					name = AL["MAP_OPTIONS"],
				},
				minimapButton = {
					order = 16,
					type = "toggle",
					name = AL["DISPLAY_MINIMAP_BUTTON"],
					desc = AL["DISPLAY_MINIMAP_BUTTON_DESC"],
					get = function() return RSConfigDB.IsShowingMinimapButton() end,
					set = function(_, value)
						RSConfigDB.SetShowingMinimapButton(value)
						RSMinimap.ToggleMinimapButton() 
					end,
					width = "full",
				},
				worldmapButton = {
					order = 17,
					type = "toggle",
					name = AL["DISPLAY_WORLDMAP_BUTTON"],
					desc = AL["DISPLAY_WORLDMAP_BUTTON_DESC"],
					get = function() return RSConfigDB.IsShowingWorldmapButton() end,
					set = function(_, value)
						RSConfigDB.SetShowingWorldmapButton(value)
						RSMap.ToggleWorldmapButton() 
					end,
					width = "full",
				},
			},
		}
	end

	return options
end
