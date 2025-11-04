-----------------------------------------------------------------------
-- AddOn namespace.
-----------------------------------------------------------------------
local ADDON_NAME, private = ...

local LibStub = _G.LibStub
local RareScanner = LibStub("AceAddon-3.0"):GetAddon("RareScanner")
local AL = LibStub("AceLocale-3.0"):GetLocale("RareScanner", false)

local RSMapOptions = private.NewLib("RareScannerMapOptions")

-- RareScanner database libraries
local RSConfigDB = private.ImportLib("RareScannerConfigDB")

-- RareScanner internal libraries
local RSConstants = private.ImportLib("RareScannerConstants")

-- RareScanner service libraries
local RSMinimap = private.ImportLib("RareScannerMinimap")

local options

-----------------------------------------------------------------------
-- Types of animations
-----------------------------------------------------------------------

local ANIMATIONS_TYPE = {}
ANIMATIONS_TYPE[RSConstants.MAP_ANIMATIONS_ON_FOUND] = AL["MAP_ANIMATIONS_ON_FOUND"];
ANIMATIONS_TYPE[RSConstants.MAP_ANIMATIONS_ON_CLICK] = AL["MAP_ANIMATIONS_ON_CLICK"];
ANIMATIONS_TYPE[RSConstants.MAP_ANIMATIONS_ON_BOTH] = AL["MAP_ANIMATIONS_ON_BOTH"];

-----------------------------------------------------------------------
-- Options tab: Map options
-----------------------------------------------------------------------

function RSMapOptions.GetMapOptions()	
	if (not options) then
		options = {
			type = "group",
			name = AL["MAP_OPTIONS"],
			handler = RareScanner,
			desc = AL["MAP_OPTIONS"],
			args = {
				minimap = {
					order = 0,
					type = "toggle",
					name = AL["DISPLAY_MINIMAP_ICONS"],
					desc = AL["DISPLAY_MINIMAP_ICONS_DESC"],
					get = function() return RSConfigDB.IsShowingMinimapIcons() end,
					set = function(_, value)
						RSConfigDB.SetShowingMinimapIcons(value)
						RSMinimap.RefreshAllData(true)
					end,
					width = "full",
				},
				scale = {
					order = 1,
					type = "range",
					name = AL["MAP_SCALE_ICONS"],
					desc = AL["MAP_SCALE_ICONS_DESC"],
					min	= 0.3,
					max	= 1.4,
					step = 0.01,
					bigStep = 0.05,
					get = function() return RSConfigDB.GetIconsWorldMapScale() end,
					set = function(_, value)
						RSConfigDB.SetIconsWorldMapScale(value)
					end,
					width = "full",
					disabled = function() return (not RSConfigDB.IsShowingNpcs() and not RSConfigDB.IsShowingContainers() and not RSConfigDB.IsShowingEvents()) end,
				},
				minimapscale = {
					order = 2,
					type = "range",
					name = AL["MINIMAP_SCALE_ICONS"],
					desc = AL["MINIMAP_SCALE_ICONS_DESC"],
					min	= 0.3,
					max	= 1.4,
					step = 0.01,
					bigStep = 0.05,
					get = function() return private.db.map.minimapscale end,
					set = function(_, value)
						private.db.map.minimapscale = value
						RSMinimap.RefreshAllData(true)
					end,
					width = "full",
					disabled = function() return (not RSConfigDB.IsShowingMinimapIcons() or (not RSConfigDB.IsShowingNpcs() and not RSConfigDB.IsShowingContainers() and not RSConfigDB.IsShowingEvents())) end,
				},
				icons = {
					type = "group",
					order = 3,
					name = AL["MAP_ICONS"],
					handler = RareScanner,
					desc = AL["MAP_ICONS_DESC"],
					args = {
						separatorNpcs = {
							order = 0,
							type = "header",
							name = AL["MAP_NPCS_ICONS"],
						},
						displayNpcIcons = {
							order = 1,
							type = "toggle",
							name = AL["DISPLAY_NPC_ICONS"],
							desc = AL["DISPLAY_NPC_ICONS_DESC"],
							get = function() return RSConfigDB.IsShowingNpcs() end,
							set = function(_, value)
								RSConfigDB.SetShowingNpcs(value)
								RSMinimap.RefreshAllData(true)
							end,
							width = "full",
						},
						displayFriendlyNpcIcons = {
							order = 2,
							type = "toggle",
							name = AL["DISPLAY_FRIENDLY_NPC_ICONS"],
							desc = AL["DISPLAY_FRIENDLY_NPC_ICONS_DESC"],
							get = function() return RSConfigDB.IsShowingFriendlyNpcs() end,
							set = function(_, value)
								RSConfigDB.SetShowingFriendlyNpcs(value)
								RSMinimap.RefreshAllData(true)
							end,
							width = "full",
							disabled = function() return not RSConfigDB.IsShowingNpcs() end,
						},
						displayNotDiscoveredNpcIcons = {
							order = 3,
							type = "toggle",
							name = AL["MAP_SHOW_ICON_NOT_DISCOVERED"],
							desc = AL["MAP_SHOW_ICON_NOT_DISCOVERED_DESC"],
							get = function() return RSConfigDB.IsShowingNotDiscoveredNpcs() end,
							set = function(_, value)
								RSConfigDB.SetShowingNotDiscoveredNpcs(value)
								RSMinimap.RefreshAllData(true)
							end,
							width = "full",
							disabled = function() return not RSConfigDB.IsShowingNpcs() end,
						},
						displayAlreadyKilledNpcIcons = {
							order = 4,
							type = "toggle",
							name = AL["MAP_SHOW_ICON_ALREADY_KILLED"],
							desc = AL["MAP_SHOW_ICON_ALREADY_KILLED_DESC"],
							get = function() return RSConfigDB.IsShowingAlreadyKilledNpcs() end,
							set = function(_, value)
								RSConfigDB.SetShowingAlreadyKilledNpcs(value)
								RSConfigDB.SetShowingAlreadyKilledNpcsInReseteableZones(false)
								RSMinimap.RefreshAllData(true)
							end,
							width = "full",
							disabled = function() return not RSConfigDB.IsShowingNpcs() end,
						},
						displayAlreadyKilledReseteable = {
							order = 5,
							type = "toggle",
							name = AL["MAP_SHOW_ICON_ALREADY_KILLED_RESETEABLE"],
							desc = AL["MAP_SHOW_ICON_ALREADY_KILLED_RESETEABLE_DESC"],
							get = function() return RSConfigDB.IsShowingAlreadyKilledNpcsInReseteableZones() end,
							set = function(_, value)
								RSConfigDB.SetShowingAlreadyKilledNpcsInReseteableZones(value)
								RSMinimap.RefreshAllData(true)
							end,
							width = "full",
							disabled = function() return not RSConfigDB.IsShowingNpcs() or not RSConfigDB.IsShowingAlreadyKilledNpcs() end,
						},
						separatorContainers = {
							order = 6,
							type = "header",
							name = AL["MAP_CONTAINERS_ICONS"],
						},
						displayContainerIcons = {
							order = 7,
							type = "toggle",
							name = AL["DISPLAY_CONTAINER_ICONS"],
							desc = AL["DISPLAY_CONTAINER_ICONS_DESC"],
							get = function() return RSConfigDB.IsShowingContainers() end,
							set = function(_, value)
								RSConfigDB.SetShowingContainers(value)
								RSMinimap.RefreshAllData(true)
							end,
							width = "full",
						},
						displayNotDiscoveredContainerIcons = {
							order = 8,
							type = "toggle",
							name = AL["MAP_SHOW_ICON_NOT_DISCOVERED_CONTAINER"],
							desc = AL["MAP_SHOW_ICON_NOT_DISCOVERED_CONTAINER_DESC"],
							get = function() return RSConfigDB.IsShowingNotDiscoveredContainers() end,
							set = function(_, value)
								RSConfigDB.SetShowingNotDiscoveredContainers(value)
								RSMinimap.RefreshAllData(true)
							end,
							width = "full",
							disabled = function() return not RSConfigDB.IsShowingContainers() end,
						},
						displayAlreadyOpenedContainersIcons = {
							order = 9,
							type = "toggle",
							name = AL["MAP_SHOW_ICON_ALREADY_OPENED"],
							desc = AL["MAP_SHOW_ICON_ALREADY_OPENED_DESC"],
							get = function() return RSConfigDB.IsShowingAlreadyOpenedContainers() end,
							set = function(_, value)
								RSConfigDB.SetShowingAlreadyOpenedContainers(value)
								RSMinimap.RefreshAllData(true)
							end,
							width = "full",
							disabled = function() return not RSConfigDB.IsShowingContainers() end,
						},
						separatorEvents = {
							order = 10,
							type = "header",
							name = AL["MAP_EVENTS_ICONS"],
						},
						displayEventIcons = {
							order = 11,
							type = "toggle",
							name = AL["DISPLAY_EVENT_ICONS"],
							desc = AL["DISPLAY_EVENT_ICONS_DESC"],
							get = function() return RSConfigDB.IsShowingEvents() end,
							set = function(_, value)
								RSConfigDB.SetShowingEvents(value)
								RSMinimap.RefreshAllData(true)
							end,
							width = "full",
						},
						displayNotDiscoveredEventIcons = {
							order = 12,
							type = "toggle",
							name = AL["MAP_SHOW_ICON_NOT_DISCOVERED_EVENT"],
							desc = AL["MAP_SHOW_ICON_NOT_DISCOVERED_EVENT_DESC"],
							get = function() return RSConfigDB.IsShowingNotDiscoveredEvents() end,
							set = function(_, value)
								RSConfigDB.SetShowingNotDiscoveredEvents(value)
								RSMinimap.RefreshAllData(true)
							end,
							width = "full",
							disabled = function() return not RSConfigDB.IsShowingEvents() end,
						},
						displayAlreadyCompletedEventIcons = {
							order = 13,
							type = "toggle",
							name = AL["MAP_SHOW_ICON_ALREADY_COMPLETED"],
							desc = AL["MAP_SHOW_ICON_ALREADY_COMPLETED_DESC"],
							get = function() return RSConfigDB.IsShowingCompletedEvents() end,
							set = function(_, value)
								RSConfigDB.SetShowingCompletedEvents(value)
								RSMinimap.RefreshAllData(true)
							end,
							width = "full",
							disabled = function() return not RSConfigDB.IsShowingEvents() end,
						},
						separatorOthers = {
							order = 14,
							type = "header",
							name = AL["MAP_OTHER_ICONS"],
						},
						separatorNotDiscovered = {
							order = 15,
							type = "header",
							name = AL["MAP_NOT_DISCOVERED_ICONS"],
						},
						displayOldNotDiscoveredMapIcons = {
							order = 16,
							type = "toggle",
							name = AL["DISPLAY_MAP_OLD_NOT_DISCOVERED_ICONS"],
							desc = AL["DISPLAY_MAP_OLD_NOT_DISCOVERED_ICONS_DESC"],
							get = function() return RSConfigDB.IsShowingOldNotDiscoveredMapIcons() end,
							set = function(_, value)
								RSConfigDB.SetShowingOldNotDiscoveredMapIcons(value)
								RSMinimap.RefreshAllData(true)
							end,
							width = "full",
							disabled = function() return (not RSConfigDB.IsShowingNpcs() and not RSConfigDB.IsShowingContainers() and not RSConfigDB.IsShowingEvents()) or (not RSConfigDB.IsShowingNotDiscoveredNpcs() and not RSConfigDB.IsShowingNotDiscoveredContainers() and not RSConfigDB.IsShowingNotDiscoveredEvents()) end,
						},
						separatorIngame = {
							order = 18,
							type = "header",
							name = AL["MAP_INGAME_ICONS"],
						},
						displayFilteredIngameIcons = {
							order = 19,
							type = "toggle",
							name = AL["DISPLAY_MAP_FILTERED_INGAME_ICONS"],
							desc = AL["DISPLAY_MAP_FILTERED_INGAME_ICONS_DESC"],
							get = function() return RSConfigDB.IsShowingFilteredIngameMapIcons() end,
							set = function(_, value)
								RSConfigDB.SetShowingFilteredIngameMapIcons(value)
							end,
							width = "full",
						},
					},
				},
				timers = {
					type = "group",
					order = 4,
					name = AL["MAP_TIMERS"],
					handler = RareScanner,
					desc = AL["MAP_TIMERS_DESC"],
					args = {
						maxSeenTime = {
							order = 0,
							type = "range",
							name = AL["MAP_SHOW_ICON_MAX_SEEN_TIME"],
							desc = AL["MAP_SHOW_ICON_MAX_SEEN_TIME_DESC"],
							min	= 0,
							max	= 30,
							step = 1,
							bigStep = 1,
							get = function() return RSConfigDB.GetMaxSeenTimeFilter() end,
							set = function(_, value)
								RSConfigDB.SetMaxSeenTimeFilter(value, true)
								RSMinimap.RefreshAllData(true)
							end,
							width = "full",
							disabled = function() return (not RSConfigDB.IsShowingNpcs()) end,
						},
						maxSeenTimeContainer = {
							order = 1,
							type = "range",
							name = AL["MAP_SHOW_ICON_CONTAINER_MAX_SEEN_TIME"],
							desc = AL["MAP_SHOW_ICON_CONTAINER_MAX_SEEN_TIME_DESC"],
							min	= 0,
							max	= 15,
							step = 1,
							bigStep = 1,
							get = function() return RSConfigDB.GetMaxSeenContainerTimeFilter() end,
							set = function(_, value)
								RSConfigDB.SetMaxSeenContainerTimeFilter(value, true)
								RSMinimap.RefreshAllData(true)
							end,
							width = "full",
							disabled = function() return (not RSConfigDB.IsShowingContainers()) end,
						},
						maxSeenTimeEvent = {
							order = 2,
							type = "range",
							name = AL["MAP_SHOW_ICON_EVENT_MAX_SEEN_TIME"],
							desc = AL["MAP_SHOW_ICON_EVENT_MAX_SEEN_TIME_DESC"],
							min	= 0,
							max	= 15,
							step = 1,
							bigStep = 1,
							get = function() return RSConfigDB.GetMaxSeenEventTimeFilter() end,
							set = function(_, value)
								RSConfigDB.SetMaxSeenEventTimeFilter(value, true)
								RSMinimap.RefreshAllData(true)
							end,
							width = "full",
							disabled = function() return (not RSConfigDB.IsShowingEvents()) end,
						}
					}
				},
				searcher = {
					type = "group",
					order = 5,
					name = AL["MAP_SEARCHER"],
					handler = RareScanner,
					desc = AL["MAP_SEARCHER_DESC"],
					args = {
						displaySearch = {
							order = 0,
							type = "toggle",
							name = AL["MAP_SEARCHER_DISPLAY"],
							desc = AL["MAP_SEARCHER_DISPLAY_DESC"],
							get = function() return RSConfigDB.IsShowingWorldMapSearcher() end,
							set = function(_, value)
								RSConfigDB.SetShowingWorldMapSearcher(value)
							end,
							width = "double",
						},
						clearValueOnChange = {
							order = 1,
							type = "toggle",
							name = AL["MAP_SEARCHER_CLEAR"],
							desc = AL["MAP_SEARCHER_CLEAR_DESC"],
							get = function() return RSConfigDB.IsClearingWorldMapSearcher() end,
							set = function(_, value)
								RSConfigDB.SetClearingWorldMapSearcher(value)
							end,
							width = "double",
						},
					}
				}, 
				waypoints = {
					type = "group",
					order = 6,
					name = AL["MAP_WAYPOINTS"],
					handler = RareScanner,
					desc = AL["MAP_WAYPOINTS_DESC"],
					args = {
						tomtom = {
							order = 0,
							type = "toggle",
							name = AL["MAP_WAYPOINT_TOMTOM"],
							desc = AL["MAP_WAYPOINT_TOMTOM_DESC"],
							get = function() return RSConfigDB.IsAddingWorldMapTomtomWaypoints() end,
							set = function(_, value)
								RSConfigDB.SetAddingWorldMapTomtomWaypoints(value)
							end,
							width = "double",
							disabled = function() return not TomTom end,
						},
					}
				},
				tooltips = {
					type = "group",
					order = 7,
					name = AL["MAP_TOOLTIPS"],
					handler = RareScanner,
					desc = AL["MAP_TOOLTIPS_DESC"],
					args = {
						scale = {
							order = 0,
							type = "range",
							name = AL["MAP_TOOLTIPS_SCALE"],
							desc = AL["MAP_TOOLTIPS_SCALE_DESC"],
							min	= 0.1,
							max	= 1.5,
							step = 0.05,
							get = function() return RSConfigDB.GetWorldMapTooltipsScale() end,
							set = function(_, value)
								RSConfigDB.SetWorldMapTooltipsScale(value)
							end,
							width = "full",
						},
						achievementsInfo = {
							order = 1,
							type = "toggle",
							name = AL["MAP_TOOLTIPS_ACHIEVEMENT"],
							desc = AL["MAP_TOOLTIPS_ACHIEVEMENT_DESC"],
							get = function() return RSConfigDB.IsShowingTooltipsAchievements() end,
							set = function(_, value)
								RSConfigDB.SetShowingTooltipsAchievements(value)
							end,
							width = "full",
						},
						notes = {
							order = 2,
							type = "toggle",
							name = AL["MAP_TOOLTIPS_NOTES"],
							desc = AL["MAP_TOOLTIPS_NOTES_DESC"],
							get = function() return RSConfigDB.IsShowingTooltipsNotes() end,
							set = function(_, value)
								RSConfigDB.SetShowingTooltipsNotes(value)
							end,
							width = "full",
						},
						loot = {
							order = 3,
							type = "toggle",
							name = AL["MAP_TOOLTIPS_LOOT"],
							desc = AL["MAP_TOOLTIPS_LOOT_DESC"],
							get = function() return RSConfigDB.IsShowingLootOnWorldMap() end,
							set = function(_, value)
								RSConfigDB.SetShowingLootOnWorldMap(value)
							end,
							width = "full",
						},
						lastTimeSeen = {
							order = 4,
							type = "toggle",
							name = AL["MAP_TOOLTIPS_SEEN"],
							desc = AL["MAP_TOOLTIPS_SEEN_DESC"],
							get = function() return RSConfigDB.IsShowingTooltipsSeen() end,
							set = function(_, value)
								RSConfigDB.SetShowingTooltipsSeen(value)
							end,
							width = "full",
						},
						state = {
							order = 5,
							type = "toggle",
							name = AL["MAP_TOOLTIPS_STATE"],
							desc = AL["MAP_TOOLTIPS_STATE_DESC"],
							get = function() return RSConfigDB.IsShowingTooltipsState() end,
							set = function(_, value)
								RSConfigDB.SetShowingTooltipsState(value)
							end,
							width = "full",
						},
						commands = {
							order = 6,
							type = "toggle",
							name = AL["MAP_TOOLTIPS_COMMANDS"],
							desc = AL["MAP_TOOLTIPS_COMMANDS_DESC"],
							get = function() return RSConfigDB.IsShowingTooltipsCommands() end,
							set = function(_, value)
								RSConfigDB.SetShowingTooltipsCommands(value)
							end,
							width = "full",
						},
						filterState = {
							order = 7,
							type = "toggle",
							name = AL["MAP_TOOLTIPS_FILTER_STATE"],
							desc = AL["MAP_TOOLTIPS_FILTER_STATE_DESC"],
							get = function() return RSConfigDB.IsShowingTooltipsFilterState() end,
							set = function(_, value)
								RSConfigDB.SetShowingTooltipsFilterState(value)
							end,
							width = "full",
						},
						separatorLootAchievements = {
							order = 8,
							type = "header",
							name = AL["MAP_TOOLTIPS_LOOT_ACHIEVEMENT"],
						},
						lootAchievementsScale = {
							order = 9,
							type = "range",
							name = AL["MAP_TOOLTIPS_LOOT_ACHIEVEMENT_SCALE"],
							desc = AL["MAP_TOOLTIPS_LOOT_ACHIEVEMENT_SCALE_DESC"],
							min	= 0.1,
							max	= 1.5,
							step = 0.05,
							get = function() return RSConfigDB.GetWorldMapLootAchievTooltipsScale() end,
							set = function(_, value)
								RSConfigDB.SetWorldMapLootAchievTooltipsScale(value)
							end,
							width = "full"
						},
						lootAchievementsPosition = {
							order = 10,
							type = "select",
							name = AL["MAP_TOOLTIPS_LOOT_ACHIEVEMENT_POSITION"],
							desc = AL["MAP_TOOLTIPS_LOOT_ACHIEVEMENT_POSITION_DESC"],
							values = private.TOOLTIP_POSITIONS,
							get = function() return RSConfigDB.GetWorldMapLootAchievTooltipPosition() end,
							set = function(_, value)
								RSConfigDB.SetWorldMapLootAchievTooltipPosition(value)
							end,
							width = "double"
						},
					},
				},
				spawnSpots = {
					type = "group",
					order = 8,
					name = AL["MAP_SPAWN_SPOTS"],
					handler = RareScanner,
					desc = AL["MAP_SPAWN_SPOTS_DESC"],
					args = {
					}
				},
				animations = {
					type = "group",
					order = 9,
					name = AL["MAP_ANIMATIONS"],
					handler = RareScanner,
					desc = AL["MAP_ANIMATIONS_DESC"],
					args = {
						separatorNpcs = {
							order = 0,
							type = "header",
							name = AL["MAP_ANIMATIONS_NPCS_SEPARATOR"],
						},
						npcs = {
							order = 1,
							type = "toggle",
							name = AL["MAP_ANIMATIONS_NPCS"],
							desc = AL["MAP_ANIMATIONS_NPCS_DESC"],
							get = function() return RSConfigDB.IsShowingAnimationForNpcs() end,
							set = function(_, value)
								RSConfigDB.SetShowingAnimationForNpcs(value)
								if (not value and not RSConfigDB.IsShowingAnimationForContainers() and not RSConfigDB.IsShowingAnimationForEvents()) then
									RSConfigDB.SetShowingAnimationForVignettes(false)
								end
							end,
							width = "full",
						},
						npcsBehaviour = {
							order = 2,
							type = "select",
							name = AL["MAP_ANIMATIONS_WHEN"],
							values = ANIMATIONS_TYPE,
							get = function() return RSConfigDB.GetAnimationForNpcs() end,
							set = function(_, value)
								RSConfigDB.SetAnimationForNpcs(value)
							end,
							width = "full",
							disabled = function() return not RSConfigDB.IsShowingAnimationForNpcs() end,
						},
						separatorContainers = {
							order = 3,
							type = "header",
							name = AL["MAP_ANIMATIONS_CONTAINERS_SEPARATOR"],
						},
						containers = {
							order = 4,
							type = "toggle",
							name = AL["MAP_ANIMATIONS_CONTAINERS"],
							desc = AL["MAP_ANIMATIONS_CONTAINERS_DESC"],
							get = function() return RSConfigDB.IsShowingAnimationForContainers() end,
							set = function(_, value)
								RSConfigDB.SetShowingAnimationForContainers(value)
								if (not value and not RSConfigDB.IsShowingAnimationForNpcs() and not RSConfigDB.IsShowingAnimationForEvents()) then
									RSConfigDB.SetShowingAnimationForVignettes(false)
								end
							end,
							width = "full",
						},
						containersBehaviour = {
							order = 5,
							type = "select",
							name = AL["MAP_ANIMATIONS_WHEN"],
							values = ANIMATIONS_TYPE,
							get = function() return RSConfigDB.GetAnimationForContainers() end,
							set = function(_, value)
								RSConfigDB.SetAnimationForContainers(value)
							end,
							width = "full",
							disabled = function() return not RSConfigDB.IsShowingAnimationForContainers() end,
						},
						separatorEvents = {
							order = 6,
							type = "header",
							name = AL["MAP_ANIMATIONS_EVENTS_SEPARATOR"],
						},
						events = {
							order = 7,
							type = "toggle",
							name = AL["MAP_ANIMATIONS_EVENTS"],
							desc = AL["MAP_ANIMATIONS_EVENTS_DESC"],
							get = function() return RSConfigDB.IsShowingAnimationForEvents() end,
							set = function(_, value)
								RSConfigDB.SetShowingAnimationForEvents(value)
								if (not value and not RSConfigDB.IsShowingAnimationForNpcs() and not RSConfigDB.IsShowingAnimationForContainers()) then
									RSConfigDB.SetShowingAnimationForVignettes(false)
								end
							end,
							width = "full",
						},
						eventsBehaviour = {
							order = 8,
							type = "select",
							name = AL["MAP_ANIMATIONS_WHEN"],
							values = ANIMATIONS_TYPE,
							get = function() return RSConfigDB.GetAnimationForEvents() end,
							set = function(_, value)
								RSConfigDB.SetAnimationForEvents(value)
							end,
							width = "full",
							disabled = function() return not RSConfigDB.IsShowingAnimationForEvents() end,
						},
					}
				},
				guidance = {
					type = "group",
					order = 10,
					name = AL["MAP_GUIDE"],
					handler = RareScanner,
					desc = AL["MAP_GUIDE_DESC"],
					args = {
						support = {
							order = 0,
							type = "toggle",
							name = AL["MAP_GUIDE_AUTOMATIC"],
							desc = AL["MAP_GUIDE_AUTOMATIC_DESC"],
							get = function() return RSConfigDB.IsShowingAutoGuidanceIcons() end,
							set = function(_, value)
								RSConfigDB.SetShowingAutoGuidanceIcons(value)
							end,
							width = "full",
						},
					}
				}
			}
		}
		
		-- load spawning spots panel
		for i = 1, private.db.map.overlayMaxColours, 1 do
			options.args.spawnSpots.args["colour"..i] = {}
			options.args.spawnSpots.args["colour"..i].name = string.format(AL["MAP_SPAWN_SPOTS_COLOUR"], i)
			options.args.spawnSpots.args["colour"..i].desc = string.format(AL["MAP_SPAWN_SPOTS_COLOUR"], i)
			options.args.spawnSpots.args["colour"..i].order = i
			options.args.spawnSpots.args["colour"..i].type = "color"
			options.args.spawnSpots.args["colour"..i].get = function() 
				return RSConfigDB.GetWorldMapOverlayColour(i) 
			end
			options.args.spawnSpots.args["colour"..i].set = function(_, r, g, b)
				RSConfigDB.SetWorldMapOverlayColour(i, r, g, b)
			end
			options.args.spawnSpots.args["colour"..i].width = "full"
		end
	end

	return options
end