-----------------------------------------------------------------------
-- AddOn namespace.
-----------------------------------------------------------------------
local ADDON_NAME, private = ...

local LibStub = _G.LibStub
local RareScanner = LibStub("AceAddon-3.0"):GetAddon("RareScanner")
local AL = LibStub("AceLocale-3.0"):GetLocale("RareScanner", false)

local RSChatOptions = private.NewLib("RareScannerChatOptions")

-- RareScanner database libraries
local RSConfigDB = private.ImportLib("RareScannerConfigDB")

-- RareScanner internal libraries
local RSConstants = private.ImportLib("RareScannerConstants")
local RSLogger = private.ImportLib("RareScannerLogger")
local RSUtils = private.ImportLib("RareScannerUtils")

-- RareScanner service libraries
local RSMinimap = private.ImportLib("RareScannerMinimap")

local options

-----------------------------------------------------------------------
-- Options tab: Chat options
-----------------------------------------------------------------------

function RSChatOptions.GetChatOptions()	
	if (not options) then
		options = {
			type = "group",
			name = AL["CHAT_OPTIONS"],
			handler = RareScanner,
			desc = AL["CHAT_OPTIONS"],
			args = {
				displayChatMessage = {
					order = 1.1,
					type = "toggle",
					name = AL["SHOW_CHAT_ALERT"],
					desc = AL["SHOW_CHAT_ALERT_DESC"],
					get = function() return RSConfigDB.IsDisplayingChatMessages() end,
					set = function(_, value)
						RSConfigDB.SetDisplayingChatMessages(value)
						if (not value) then
							RSConfigDB.SetChatWindowName()
							RSLogger:CreateChatFrame()
						end
					end,
					width = 3,
				},
				chatWindowName = {
					order = 1.2,
					type = "input",
					name = AL["SHOW_CHAT_WINDOW_NAME"],
					desc = AL["SHOW_CHAT_WINDOW_NAME_DESC"],
					get = function() return RSConfigDB.GetChatWindowName() end,
					set = function(_, value)
						if (value and strtrim(value) == '') then
							value = nil
						end
						
						-- Creates a new one
						RSConfigDB.SetChatWindowName(value)
						RSLogger:CreateChatFrame(value)
					end,
					width = 0.7,
					disabled = function() return not RSConfigDB.IsDisplayingChatMessages() end,
				},
				displayChatTimestampMessage = {
					order = 2,
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
				waypoints = {
					type = "group",
					order = 3,
					name = AL["CHAT_WAYPOINTS"],
					handler = RareScanner,
					desc = AL["CHAT_WAYPOINTS_DESC"],
					args = {
						tomtom = {
							order = 0,
							type = "toggle",
							name = AL["CHAT_WAYPOINT_TOMTOM"],
							desc = AL["CHAT_WAYPOINT_TOMTOM_DESC"],
							get = function() return RSConfigDB.IsAddingchatTomtomWaypoints() end,
							set = function(_, value)
								RSConfigDB.SetAddingchatTomtomWaypoints(value)
							end,
							width = "double",
							disabled = function() return not TomTom or not RSConfigDB.IsDisplayingChatMessages() end,
						},
					}
				},
				tooltips = {
					type = "group",
					order = 4,
					name = AL["CHAT_TOOLTIPS"],
					handler = RareScanner,
					desc = AL["CHAT_TOOLTIPS_DESC"],
					args = {
						scale = {
							order = 0,
							type = "range",
							name = AL["CHAT_TOOLTIPS_SCALE"],
							desc = AL["CHAT_TOOLTIPS_SCALE_DESC"],
							min	= 0.1,
							max	= 1.5,
							step = 0.05,
							get = function() return RSConfigDB.GetChatTooltipsScale() end,
							set = function(_, value)
								RSConfigDB.SetChatTooltipsScale(value)
							end,
							width = "full",
							disabled = function() return not RSConfigDB.IsDisplayingChatMessages() end,
						},
						achievementsInfo = {
							order = 1,
							type = "toggle",
							name = AL["CHAT_TOOLTIPS_ACHIEVEMENT"],
							desc = AL["CHAT_TOOLTIPS_ACHIEVEMENT_DESC"],
							get = function() return RSConfigDB.IsShowingChatTooltipsAchievements() end,
							set = function(_, value)
								RSConfigDB.SetShowingChatTooltipsAchievements(value)
							end,
							width = "full",
							disabled = function() return not RSConfigDB.IsDisplayingChatMessages() end,
						},
						notes = {
							order = 2,
							type = "toggle",
							name = AL["CHAT_TOOLTIPS_NOTES"],
							desc = AL["CHAT_TOOLTIPS_NOTES_DESC"],
							get = function() return RSConfigDB.IsShowingChatTooltipsNotes() end,
							set = function(_, value)
								RSConfigDB.SetShowingChatTooltipsNotes(value)
							end,
							width = "full",
							disabled = function() return not RSConfigDB.IsDisplayingChatMessages() end,
						},
						loot = {
							order = 3,
							type = "toggle",
							name = AL["CHAT_TOOLTIPS_LOOT"],
							desc = AL["CHAT_TOOLTIPS_LOOT_DESC"],
							get = function() return RSConfigDB.IsShowingChatTooltipsLoot() end,
							set = function(_, value)
								RSConfigDB.SetShowingChatTooltipsLoot(value)
							end,
							width = "full",
							disabled = function() return not RSConfigDB.IsDisplayingChatMessages() end,
						},
						lastTimeSeen = {
							order = 4,
							type = "toggle",
							name = AL["CHAT_TOOLTIPS_SEEN"],
							desc = AL["CHAT_TOOLTIPS_SEEN_DESC"],
							get = function() return RSConfigDB.IsShowingChatTooltipsSeen() end,
							set = function(_, value)
								RSConfigDB.SetShowingChatTooltipsSeen(value)
							end,
							width = "full",
							disabled = function() return not RSConfigDB.IsDisplayingChatMessages() end,
						},
						commands = {
							order = 5,
							type = "toggle",
							name = AL["CHAT_TOOLTIPS_COMMANDS"],
							desc = AL["CHAT_TOOLTIPS_COMMANDS_DESC"],
							get = function() return RSConfigDB.IsShowingChatTooltipsCommands() end,
							set = function(_, value)
								RSConfigDB.SetShowingChatTooltipsCommands(value)
							end,
							width = "full",
							disabled = function() return not RSConfigDB.IsDisplayingChatMessages() end,
						},
						separatorLootAchievements = {
							order = 6,
							type = "header",
							name = AL["CHAT_TOOLTIPS_LOOT_ACHIEVEMENT"],
						},
						lootAchievementsScale = {
							order = 7,
							type = "range",
							name = AL["CHAT_TOOLTIPS_LOOT_ACHIEVEMENT_SCALE"],
							desc = AL["CHAT_TOOLTIPS_LOOT_ACHIEVEMENT_SCALE_DESC"],
							min	= 0.1,
							max	= 1.5,
							step = 0.05,
							get = function() return RSConfigDB.GetChatLootAchievTooltipsScale() end,
							set = function(_, value)
								RSConfigDB.SetChatLootAchievTooltipsScale(value)
							end,
							width = "full",
							disabled = function() return not RSConfigDB.IsDisplayingChatMessages() end,
						},
					},
				},
				linkColors = {
					type = "group",
					order = 5,
					name = AL["CHAT_LINK_COLORS"],
					handler = RareScanner,
					desc = AL["CHAT_LINK_COLORS_DESC"],
					args = {
						npc = {
							order = 0,
							type = "color",
							name = AL["CHAT_LINK_COLORS_NPC"],
							desc = AL["CHAT_LINK_COLORS_NPC_DESC"],
							get = function() 
								return RSUtils.HexToRGB(RSConfigDB.GetChatLinkColorNpc()) 
							end,
							set = function(_, r, g, b)
								if (r and g and b) then
									RSConfigDB.SetChatLinkColorNpc(RSUtils.RGBToHex(r, g, b))
								end
							end,
							width = "full",
						},
						container = {
							order = 1,
							type = "color",
							name = AL["CHAT_LINK_COLORS_CONTAINER"],
							desc = AL["CHAT_LINK_COLORS_CONTAINER_DESC"],
							get = function() return RSUtils.HexToRGB(RSConfigDB.GetChatLinkColorContainer()) end,
							set = function(_, r, g, b)
								if (r and g and b) then
									RSConfigDB.SetChatLinkColorContainer(RSUtils.RGBToHex(r, g, b))
								end
							end,
							width = "full",
						},
						event = {
							order = 2,
							type = "color",
							name = AL["CHAT_LINK_COLORS_EVENT"],
							desc = AL["CHAT_LINK_COLORS_EVENT_DESC"],
							get = function() return RSUtils.HexToRGB(RSConfigDB.GetChatLinkColorEvent()) end,
							set = function(_, r, g, b)
								if (r and g and b) then
									RSConfigDB.SetChatLinkColorEvent(RSUtils.RGBToHex(r, g, b))
								end
							end,
							width = "full",
						},
					}
				},
			}
		}
	end

	return options
end