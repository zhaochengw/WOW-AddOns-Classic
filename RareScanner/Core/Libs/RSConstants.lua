-----------------------------------------------------------------------
-- AddOn namespace.
-----------------------------------------------------------------------
local ADDON_NAME, private = ...

local RSConstants = private.NewLib("RareScannerConstants")

-- Locales
local AL = LibStub("AceLocale-3.0"):GetLocale("RareScanner");

---============================================================================
-- DEBUG MODE
---============================================================================

RSConstants.DEBUG_MODE = false
RSConstants.DEBUG_ATLAS_VIGNETTE = false

-- Use this constant to logger information about an specific entity while
-- displaying on the map. This is handy to find bugs in the POI filters
RSConstants.MAP_ENTITY_ID = nil

-- Use this constant to logger information about an specific item whie
-- displaying on the loot bar under the main button or the map. This is handy to find bugs
-- with the loot filters
RSConstants.LOOT_ITEM_ID = nil

---============================================================================
-- Current versions
---============================================================================

RSConstants.CURRENT_DB_VERSION = 7
RSConstants.CURRENT_LOOT_DB_VERSION = 5

---============================================================================
-- Current maps (newer)
---============================================================================

RSConstants.CURRENT_MAP_ID = 424 --Pandaria
RSConstants.CURRENT_SUBMAP_ID = 390 --Vale of Eternal Blossoms

---============================================================================
-- Default filtered entities by version
---============================================================================

RSConstants.DEFAULT_FILTERED_ENTITIES = {
	version = 67,
	containers = {382029, 383733, 383734, 383735, 376386, 376587}
}

---============================================================================
-- Special events
---============================================================================

RSConstants.NPCS_ADDED_IN_5_1_0 = 1
RSConstants.NPCS_ADDED_IN_5_1_1 = 6
RSConstants.NPCS_ADDED_IN_5_2_0 = 2
RSConstants.NPCS_ADDED_IN_5_2_1 = 5
RSConstants.NPCS_ADDED_IN_5_3_0 = 3
RSConstants.NPCS_ADDED_IN_5_3_1 = 7
RSConstants.NPCS_ADDED_IN_5_4_0 = 4

RSConstants.EVENTS = {
	[RSConstants.NPCS_ADDED_IN_5_1_0] = true;
	[RSConstants.NPCS_ADDED_IN_5_1_1] = true;
	[RSConstants.NPCS_ADDED_IN_5_2_0] = true;
	[RSConstants.NPCS_ADDED_IN_5_2_1] = true;
	[RSConstants.NPCS_ADDED_IN_5_3_0] = true;
	[RSConstants.NPCS_ADDED_IN_5_4_0] = false;
}

---============================================================================
-- Mini events
---============================================================================

RSConstants.PANDARIA_IS_ANOTHER_MANS_TREASURE_MINIEVENT = 26
RSConstants.PANDARIA_RICHES_OF_PANDARIA_MINIEVENT = 27
RSConstants.PANDARIA_HOZEN_IN_THE_MIST_MINIEVENT = 28
RSConstants.PANDARIA_WHAT_WORTH_FIGHITING_MINIEVENT = 29
RSConstants.PANDARIA_LEGEND_BREWFATHERS_MINIEVENT = 30
RSConstants.PANDARIA_DARK_HEART_MOGU_MINIEVENT = 31
RSConstants.PANDARIA_BETWEEN_SAUROK_HARD_PLACE_MINIEVENT = 32
RSConstants.PANDARIA_SEVEN_BUDENS_SHAOHAO_MINIEVENT = 33
RSConstants.PANDARIA_FISH_TALES_MINIEVENT = 34
RSConstants.PANDARIA_BALLAD_LIU_LANG_MINIEVENT = 35
RSConstants.PANDARIA_SONG_YAUNGOL_MINIEVENT = 36
RSConstants.PANDARIA_HEART_MANTID_SWARM_MINIEVENT = 37
RSConstants.PANDARIA_ZANDALARI_PROFECY_MINIEVENT = 38
RSConstants.PANDARIA_RUMBLES_THUNDER_MINIEVENT = 39
RSConstants.PANDARIA_GODS_MONSTERS_MINIEVENT = 40

-- Minievents that will have an option to filter/unfilter the icons from the worldmap
RSConstants.MINIEVENTS_WORLDMAP_FILTERS = {
	[RSConstants.PANDARIA_IS_ANOTHER_MANS_TREASURE_MINIEVENT] = { active = true, containers = true, mapIDs = { 371, 379, 422, 418, 376, 388 }, atlas = "Auctioneer", text = AL["MAP_MENU_SHOW_IS_ANOTHER_MANS_TREASURE_CONTAINERS"] };
	[RSConstants.PANDARIA_RICHES_OF_PANDARIA_MINIEVENT] = { active = true, containers = true, mapIDs = { 371, 379, 418, 376, 388, 433 }, atlas = "Banker", text = AL["MAP_MENU_SHOW_RICHES_OF_PANDARIA_CONTAINERS"] };
	[RSConstants.PANDARIA_HOZEN_IN_THE_MIST_MINIEVENT] = { active = true, containers = true, mapIDs = { 371, 379, 418, 376 }, atlas = "Vehicle-TempleofKotmogu-CyanBall", text = AL["MAP_MENU_SHOW_HOZEN_IN_THE_MIST_CONTAINERS"] };
	[RSConstants.PANDARIA_WHAT_WORTH_FIGHITING_MINIEVENT] = { active = true, containers = true, mapIDs = { 371, 379, 390, 418, 376 }, atlas = "Vehicle-TempleofKotmogu-GreenBall", text = AL["MAP_MENU_SHOW_WHAT_WORTH_FIGHITING_CONTAINERS"] };
	[RSConstants.PANDARIA_LEGEND_BREWFATHERS_MINIEVENT] = { active = true, containers = true, mapIDs = { 371, 379, 418 }, atlas = "Class", text = AL["MAP_MENU_SHOW_LEGEND_BREWFATHERS_CONTAINERS"] };
	[RSConstants.PANDARIA_DARK_HEART_MOGU_MINIEVENT] = { active = true, containers = true, mapIDs = { 371, 379, 390, 418 }, atlas = "Vehicle-TempleofKotmogu-PurpleBall", text = AL["MAP_MENU_SHOW_DARK_HEART_MOGU_CONTAINERS"] };
	[RSConstants.PANDARIA_BETWEEN_SAUROK_HARD_PLACE_MINIEVENT] = { active = true, containers = true, mapIDs = { 371, 418, 422, 433 }, atlas = "Profession", text = AL["MAP_MENU_SHOW_BETWEEN_SAUROK_HARD_PLACE_CONTAINERS"] };
	[RSConstants.PANDARIA_SEVEN_BUDENS_SHAOHAO_MINIEVENT] = { active = true, containers = true, mapIDs = { 371, 379, 390, 376, 388, 418 }, atlas = "poi-workorders", text = AL["MAP_MENU_SHOW_SEVEN_BUDENS_SHAOHAO_CONTAINERS"] };
	[RSConstants.PANDARIA_FISH_TALES_MINIEVENT] = { active = true, containers = true, mapIDs = { 371, 379, 376, 418 }, atlas = "AncientMana", text = AL["MAP_MENU_SHOW_FISH_TALES_CONTAINERS"] };
	[RSConstants.PANDARIA_BALLAD_LIU_LANG_MINIEVENT] = { active = true, containers = true, mapIDs = { 376, 418 }, atlas = "Mailbox", text = AL["MAP_MENU_SHOW_BALLAD_LIU_LANG_CONTAINERS"] };
	[RSConstants.PANDARIA_SONG_YAUNGOL_MINIEVENT] = { active = true, containers = true, mapIDs = { 379, 388 }, atlas = "MagePortalAlliance", text = AL["MAP_MENU_SHOW_SONG_YAUNGOL_CONTAINERS"] };
	[RSConstants.PANDARIA_HEART_MANTID_SWARM_MINIEVENT] = { active = true, containers = true, mapIDs = { 422 }, atlas = "MagePortalHorde", text = AL["MAP_MENU_SHOW_HEART_MANTID_SWARM_CONTAINERS"] };
	[RSConstants.PANDARIA_ZANDALARI_PROFECY_MINIEVENT] = { active = true, containers = true, mapIDs = { 504 }, atlas = "Profession", text = AL["MAP_MENU_SHOW_ZANDALARI_PROFECY_CONTAINERS"] };
	[RSConstants.PANDARIA_RUMBLES_THUNDER_MINIEVENT] = { active = true, containers = true, mapIDs = { 504 }, atlas = "Class", text = AL["MAP_MENU_SHOW_RUMBLES_THUNDER_CONTAINERS"] };
	[RSConstants.PANDARIA_GODS_MONSTERS_MINIEVENT] = { active = true, containers = true, mapIDs = { 504 }, atlas = "Vehicle-Mogu", text = AL["MAP_MENU_SHOW_GODS_MONSTERS_CONTAINERS"] };
}

---============================================================================
-- Timers
---============================================================================

RSConstants.CHECK_RESET_RECENTLY_SEEN_TIMER = 5 --5 seconds
RSConstants.RECENTLY_SEEN_RESET_TIMER = 120 --2 minutes
RSConstants.RECENTLY_SEEN_INSTANCE_RESET_TIMER = 120 * 15 --30 minutes
RSConstants.RECENTLY_SEEN_PING_ANIMATION_TIMER = 5 --5 seconds
RSConstants.CACHE_ALL_COMPLETED_QUEST_IDS_TIMER = 60 --1 minute
RSConstants.FIND_HIDDEN_QUESTS_TIMER = 5 --5 seconds after killing a NPC or opening a container
RSConstants.CHECK_RESPAWN_THRESHOLD = 150 --2.5 minutes
RSConstants.CHECK_RESPAWN_TIMER = 60 --1 minute
RSConstants.CHECK_RESET_NOTIFICATIONS_TIMER = 10 --10 seconds
RSConstants.CHECK_TARGETS_TIMER = 1 --1 seconds
RSConstants.BUTTON_TIMER = 1 --1 seconds
RSConstants.PREFOUND_TIMER = 5 --5 seconds

---============================================================================
-- Collections enumerators
---============================================================================

RSConstants.ITEM_SOURCE = {
	NPC = 1,
	CONTAINER = 2
}

RSConstants.ITEM_TYPE = {
	UNKNOWN = 0,
	APPEARANCE = 1,
	TOY = 2,
	PET = 3,
	MOUNT = 4,
	CUSTOM = "c%s"
}

---============================================================================
-- Types of entity by map (used in MapEntitiesTables)
---============================================================================

RSConstants.MAP_ENTITY_NPC = 1
RSConstants.MAP_ENTITY_CONTAINER = 2
RSConstants.MAP_ENTITY_EVENT = 3

---============================================================================
-- Types of entity filters
---============================================================================

RSConstants.ENTITY_FILTER_ALL = 1
RSConstants.ENTITY_FILTER_WORLDMAP = 2
RSConstants.ENTITY_FILTER_ALERTS = 3

---============================================================================
-- Events when adding animations to the world map
---============================================================================

RSConstants.MAP_ANIMATIONS_ON_FOUND = 1
RSConstants.MAP_ANIMATIONS_ON_CLICK = 2
RSConstants.MAP_ANIMATIONS_ON_BOTH = 3

---============================================================================
-- Tracking systems
---============================================================================

RSConstants.TRACKING_SYSTEM = {
	VIGNETTE = 1,
	NAMEPLATE_MOUSEOVER = 2,
	UNIT_TARGET = 3,
	CHAT_EMOTE = 4
}

---============================================================================
-- Addons default settings
---============================================================================

RSConstants.PROFILE_DEFAULTS = {
	profile = {
		general = {
			rescanTimer = 5,
			scanRares = true,
			scanContainers = true,
			scanEvents = true,
			scanChatAlerts = true,
			scanInstances = false,
			scanOnTaxi = true,
			scanOnPetBattle = true,
			scanWorldmapVignette = true,
			scanWithMacro = false,
			autoHideButtonInstances = false,
			ignoreCompletedEntities = true,
			showMaker = true,
			marker = 8,
			enableTomtomSupport = false,
			autoTomtomWaypoints = false,
			showTomtomMinimapIcon = false,
			showTomtomWorldmapIcon = false
		},
		sound = {
			soundDisabled = false,
			soundObjectDisabled = false,
			soundChannel = "Master",
			soundVolume = 4,
			soundPlayed = "Horn",
			soundObjectPlayed = "PVP Horde",
			soundCustomFolder = "RareScannerSounds"
		},
		display = {
			displayButton = true,
			displayMiniature = true,
			displayButtonContainers = true,
			autoHideButton = 0,
			scale = 0.8,
			lockPosition = false,
			displayRaidWarning = true,
			flashWindowsTaskBar = true,
			displayChatMessage = true,
			chatWindowName = nil,
			displayTimestampChatMessage = true,
			enableNavigation = true,
			navigationLockEntity = false,
			minimapButton = {
				hide = false
			},
			worldmapButton = true
		},
		rareFilters = {
			defaultNpcFilterType = RSConstants.ENTITY_FILTER_ALL,
			filterWeeklyRep = false
		},
		containerFilters = {
			defaultContainerFilterType = RSConstants.ENTITY_FILTER_ALL,
			filterAchievements = false
		},
		eventFilters = {
			defaultEventFilterType = RSConstants.ENTITY_FILTER_ALL
		},
		zoneFilters = {
			defaultZoneFilterType = RSConstants.ENTITY_FILTER_ALL
		},
		collections = {
			filteredOnlyOnWorldMap = false,
			autoFilteringOnCollect = false,
			createProfileBackup = true,
			searchingPets = true,
			searchingMounts = true,
			searchingToys = true,
			searchingAppearances = true,
			searchingClassAppearances = true,
			searchingMissingAchievementCriteria = true,
			showFiltered = true,
			showDead = true,
			showWithoutCollectibles = false,
			lockingMap = false
		},
		map = {
			displayNpcIcons = true,
			displayNotDiscoveredNpcIcons = true,
			displayAlreadyKilledNpcIcons = false,
			displayAlreadyKilledNpcIconsReseteable = false,
			displayWeeklyRepNpcIcons = true,
			displayAchievementRaresNpcIcons = true,
			displayMinieventsNpcIcons = { true, true, true, true, true, true, true, true, true, true, false, false, true, true, true, false, false, true, true, true },
			displayCustomGroupNpcIcons = {},
			displayOtherRaresNpcIcons = true,
			displayContainerIcons = true,
			displayAlreadyOpenedContainersIcons = false,
			displayNotDiscoveredContainerIcons = true,
			displayAchievementContainerIcons = true,
			displayOtherContainerIcons = true,
			displayEventIcons = true,
			displayNotDiscoveredEventIcons = true,
			disableLastSeenFilter = false,
			displayFriendlyNpcIcons = false,
			displayOldNotDiscoveredMapIcons = true,
			displayAlreadyCompletedEventIcons = false,
			maxSeenTime = 0,
			maxSeenTimeContainer = 0,
			maxSeenTimeEvent = 5,
			scale = 0.55,
			minimapscale = 0.55,
			showingWorldMapSearcher = true,
			cleanWorldMapSearcherOnChange = true,
			displayMinimapIcons = true,
			waypointTomtom = false,
			tooltipsScale = 0.8,
			tooltipsAchievements = true,
			tooltipsNotes = true,
			tooltipsState = true,
			tooltipsSeen = true,
			tooltipsCommands = true,
			tooltipsFilterState = true,
			lootAchievTooltipsScale = 0.6,
			lootAchievementsPosition = "ANCHOR_LEFT",
			overlayMaxColours = 10,
			overlayColour1 = { 1, 0.2, 1 },
			overlayColour2 = { 0.23, 0.943, 1 },
			overlayColour3 = { 0.98, 0.99, 0.19 },
			overlayColour4 = { 0, 0.12, 1 },
			overlayColour5 = { 0.317, 1, 0.1 },
			overlayColour6 = { 1, 0.35, 0.11 },
			overlayColour7 = { 0.08, 0.55, 1 },
			overlayColour8 = { 0.18, 1, 0.42 },
			overlayColour9 = { 1, 0.04, 0.4 },
			overlayColour10 = { 0.4, 0.007, 1 },
			animationNpcs = true,
			animationNpcsType = RSConstants.MAP_ANIMATIONS_ON_BOTH,
			animationContainers = true,
			animationContainersType = RSConstants.MAP_ANIMATIONS_ON_CLICK,
			animationEvents = true,
			animationEventsType = RSConstants.MAP_ANIMATIONS_ON_CLICK,
			autoGuidanceIcons = true
		},
		loot = {
			filteredLootCategories = {},
			filteredItems = {},
			displayLoot = true,
			displayLootOnMap = true,
			lootTooltipPosition = "ANCHOR_LEFT",
			lootMinQuality = 0,
			filterItemsCompletedQuest = true,
			filterNotEquipableItems = false,
			filterNotMatchingClass = false,
			filterNotMatchingFaction = true,
			filterByExplorerResults = false,
			showingMissingMounts = true,
			showingMissingPets = true,
			showingMissingToys = true,
			showingMissingAppearances = true,
			showingMissingClassAppearances = true,
			numItems = 10,
			numItemsPerRow = 10,
			tooltipsCommands = true,
			tooltipsCanImogit = false,
			tooltipsTSM = true
		},
		chat = {
			waypointTomtom = false,
			tooltipsScale = 1,
			tooltipsAchievements = true,
			tooltipsNotes = true,
			tooltipsLoot = true,
			tooltipsSeen = true,
			tooltipsCommands = true,
			tooltipsFilterScale = 0.75,
			colorNpc = "85c1e9",
			colorContainer = "d7dbdd",
			colorEvent = "f7dc6f",
		}
	}
}

---============================================================================
-- Macro settings
---============================================================================

RSConstants.RARESCANNER_MACRO_NAME = "RS_MACRO"
RSConstants.RARESCANNER_MACRO_ICON = "Interface/Icons/Icon_upgradestone_rare"
RSConstants.RARESCANNER_MACRO_TARGET_MAX_DISTANCE = 0.1 --map distance
RSConstants.RARESCANNER_MACRO_UPDATE_NPCS_DISTANCE = 0.05 --map distance
RSConstants.RARESCANNER_MACRO_REFRESH_TIMER = 5 --seconds

---============================================================================
-- Name of the RareScanner's button
---============================================================================

RSConstants.RS_BUTTON_NAME = "RARESCANNER_BUTTON"

---============================================================================
-- Sounds
---============================================================================

RSConstants.DEFAULT_SOUNDS = {
	["Achievement Sound"] = "Interface\\AddOns\\RareScanner\\Media\\achievmentsound1-4.ogg",
	["Alarm Clock"] = "Interface\\AddOns\\RareScanner\\Media\\alarmclockwarning2-4.ogg",
	["Boat Docking"] = "Interface\\AddOns\\RareScanner\\Media\\boatdockedwarning-4.ogg",
	["Siege Engineer Weapon"] = "Interface\\AddOns\\RareScanner\\Media\\fx_ograid_siege_weaponmachine_warning-4.ogg",
	["PVP Alliance"] = "Interface\\AddOns\\RareScanner\\Media\\pvpwarningalliance-4.ogg",
	["PVP Horde"] = "Interface\\AddOns\\RareScanner\\Media\\pvpwarninghorde-4.ogg",
	["Ready Check"] = "Interface\\AddOns\\RareScanner\\Media\\readycheck-4.ogg",
	["Horn"] = "Interface\\AddOns\\RareScanner\\Media\\gruntling_horn_bb-4.ogg",
	["Event Wardrum Ogre"] = "Interface\\AddOns\\RareScanner\\Media\\Event_wardrum_ogre-4.ogg",
	["Level Up"] = "Interface\\AddOns\\RareScanner\\Media\\levelup2-4.ogg",
}

RSConstants.EXTERNAL_SOUND_FOLDER = "Interface\\AddOns\\%s\\%s"
RSConstants.ERROR_SOUND_CLOSE_ID = 567464 --(close), 567490 (open)
RSConstants.ERROR_SOUND_OPEN_ID = 567490 --(close), 567490 (open)

---============================================================================
-- CMD commands
---============================================================================

RSConstants.CMD_HELP = "help"
RSConstants.CMD_TOGGLE_MAP_ICONS = "tmi"
RSConstants.CMD_TOGGLE_ALERTS = "ta"
RSConstants.CMD_TOGGLE_RARES = "tr"
RSConstants.CMD_TOGGLE_RARES_ALERTS = "tra"
RSConstants.CMD_TOGGLE_EVENTS = "te"
RSConstants.CMD_TOGGLE_EVENTS_ALERTS = "tea"
RSConstants.CMD_TOGGLE_TREASURES = "tt"
RSConstants.CMD_TOGGLE_TREASURES_ALERTS = "tta"
RSConstants.CMD_TOMTOM_WAYPOINT = "waypoint"
RSConstants.CMD_OPEN_EXPLORER = "explorer"
RSConstants.CMD_RECENTLY_SEEN = "rseen"
RSConstants.CMD_IMPORT = "import"

---============================================================================
-- AtlasNames
---============================================================================

RSConstants.NPC_VIGNETTE = "VignetteKill"
RSConstants.NPC_VIGNETTE_ELITE = "VignetteKillElite"
RSConstants.NPC_VIGNETTE_BOSS = "vignettekillboss"

RSConstants.CONTAINER_VIGNETTE = "VignetteLoot"
RSConstants.CONTAINER_ELITE_VIGNETTE = "VignetteLootElite"
RSConstants.CONTAINER_LOCKED_VIGNETTE = "vignetteloot-locked"
RSConstants.CONTAINER_ELITE_LOCKED_VIGNETTE = "vignettelootelite-locked"
RSConstants.CONTAINER_LORE_OBJECT = "loreobject-32x32"

RSConstants.EVENT_VIGNETTE = "VignetteEvent"
RSConstants.EVENT_ELITE_VIGNETTE = "VignetteEventElite"

---============================================================================
-- MapIDS
---============================================================================

RSConstants.ALL_ZONES_CUSTOM_NPC = 0
RSConstants.ALL_ZONES = "all"
RSConstants.UNKNOWN_ZONE_ID = 0
RSConstants.COSMIC = 946
RSConstants.AZEROTH = 947

---============================================================================
-- Entity IDs
---============================================================================

RSConstants.CONTAINERS_DESPAWN = { 213749, 64004, 64191, 213962, 213968, 65552, 213969, 213972, 213966, 213964, 213960, 213842 }

-- NPCs that spawn after completing an event
RSConstants.NPCS_WITH_PRE_EVENT = {
	-- EVENTID = NPCID
}

-- Contains that spawn after completing an event
RSConstants.CONTAINERS_WITH_PRE_EVENT = {
	-- EVENTID = CONTAINERID
}

-- NPCs that spawn after killing another NPC
RSConstants.NPCS_WITH_PRE_NPCS = {}

RSConstants.CONTAINER_WITH_NPC_VIGNETTE = {}
RSConstants.IGNORED_VIGNETTES = {}
RSConstants.IGNORED_FRIENDLY_NPCS = {}
RSConstants.NPCS_WITH_EVENT_VIGNETTE = {}
RSConstants.NPCS_WITH_CONTAINER_VIGNETTE = {}
RSConstants.CONTAINERS_WITH_NPC_VIGNETTE = {}
RSConstants.CONTAINERS_WITH_EVENT_VIGNETTE = {}
RSConstants.EVENTS_WITH_NPC_VIGNETTE = {}
RSConstants.NPCS_WITH_MULTIPLE_SPAWNS = { 69768, 69769, 69841, 69842, 70323 }
RSConstants.CONTAINERS_WITH_MULTIPLE_SPAWNS = {}
RSConstants.IGNORED_TRACKING_SYSTEMS_NOT_VIGNETTE = {}

---============================================================================
-- Custom NPCs
---============================================================================

RSConstants.DEFAULT_GROUP = 0

---============================================================================
-- TSM
---============================================================================

RSConstants.TSM_SOURCES = { "DBMinBuyout", "DBMarket", "DBRegionMarketAvg" }

---============================================================================
-- Tooltips
---============================================================================

RSConstants.TOOLTIPS_SCALE = 0.65

---============================================================================
-- Eternal states
---============================================================================

RSConstants.ETERNAL_DEATH = -1
RSConstants.ETERNAL_OPENED = -1
RSConstants.ETERNAL_COMPLETED = -1
RSConstants.ETERNAL_COLLECTED = -1

---============================================================================
-- Textures
---============================================================================

RSConstants.TEXTURE_PATH = "Interface\\AddOns\\RareScanner\\Media\\Icons\\%s.blp"
RSConstants.GROUP_TOP_TEXTURE_FILE = "GroupT"
RSConstants.GROUP_RIGHT_TEXTURE_FILE = "GroupR"
RSConstants.GROUP_LEFT_TEXTURE_FILE = "GroupL"
RSConstants.NORMAL_NPC_TEXTURE_FILE = "OriginalSkull"
RSConstants.RED_NPC_TEXTURE_FILE = "RedSkullDark"
RSConstants.PINK_NPC_TEXTURE_FILE = "PinkSkullDark"
RSConstants.BLUE_NPC_TEXTURE_FILE = "BlueSkullDark"
RSConstants.PURPLE_NPC_TEXTURE_FILE = "CustomSkull"
RSConstants.LIGHT_BLUE_NPC_TEXTURE_FILE = "BlueSkullLight"
RSConstants.NORMAL_CONTAINER_TEXTURE_FILE = "OriginalChest"
RSConstants.RED_CONTAINER_TEXTURE_FILE = "RedChest"
RSConstants.PINK_CONTAINER_TEXTURE_FILE = "PinkChest"
RSConstants.BLUE_CONTAINER_TEXTURE_FILE = "BlueChest"
RSConstants.NORMAL_EVENT_TEXTURE_FILE = "OriginalStar"
RSConstants.RED_EVENT_TEXTURE_FILE = "RedStar"
RSConstants.PINK_EVENT_TEXTURE_FILE = "PinkStar"
RSConstants.BLUE_EVENT_TEXTURE_FILE = "BlueStar"
RSConstants.OVERLAY_SPOT_TEXTURE_FILE = "Overlay"
RSConstants.GUIDE_TRANSPORT_FILE = "Transport"
RSConstants.GUIDE_ENTRANCE_FILE = "Entrance"
RSConstants.GUIDE_FLAG_FILE = "Flag"
RSConstants.GUIDE_DOT_FILE = "Dot"
RSConstants.GUIDE_STEP1_FILE = "Number1"
RSConstants.GUIDE_STEP2_FILE = "Number2"
RSConstants.GUIDE_STEP3_FILE = "Number3"
RSConstants.GUIDE_STEP4_FILE = "Number4"
RSConstants.GUIDE_STEP5_FILE = "Number5"
RSConstants.GUIDE_STEP6_FILE = "Number6"
RSConstants.GUIDE_STEP7_FILE = "Number7"
RSConstants.GUIDE_STEP8_FILE = "Number8"
RSConstants.GUIDE_STEP9_FILE = "Number9"
RSConstants.ACHIEVEMENT_ICON_ATLAS = "StoryHeader-CheevoIcon"

RSConstants.NORMAL_NPC_TEXTURE = string.format(RSConstants.TEXTURE_PATH, RSConstants.NORMAL_NPC_TEXTURE_FILE);
RSConstants.GROUP_NORMAL_NPC_T_TEXTURE = string.format(RSConstants.TEXTURE_PATH, string.format("%s%s", RSConstants.NORMAL_NPC_TEXTURE_FILE, RSConstants.GROUP_TOP_TEXTURE_FILE));
RSConstants.GROUP_NORMAL_NPC_L_TEXTURE = string.format(RSConstants.TEXTURE_PATH, string.format("%s%s", RSConstants.NORMAL_NPC_TEXTURE_FILE, RSConstants.GROUP_LEFT_TEXTURE_FILE));
RSConstants.GROUP_NORMAL_NPC_R_TEXTURE = string.format(RSConstants.TEXTURE_PATH, string.format("%s%s", RSConstants.NORMAL_NPC_TEXTURE_FILE, RSConstants.GROUP_RIGHT_TEXTURE_FILE));
RSConstants.RED_NPC_TEXTURE = string.format(RSConstants.TEXTURE_PATH, RSConstants.RED_NPC_TEXTURE_FILE);
RSConstants.GROUP_RED_NPC_T_TEXTURE = string.format(RSConstants.TEXTURE_PATH, string.format("%s%s", RSConstants.RED_NPC_TEXTURE_FILE, RSConstants.GROUP_TOP_TEXTURE_FILE));
RSConstants.GROUP_RED_NPC_L_TEXTURE = string.format(RSConstants.TEXTURE_PATH, string.format("%s%s", RSConstants.RED_NPC_TEXTURE_FILE, RSConstants.GROUP_LEFT_TEXTURE_FILE));
RSConstants.GROUP_RED_NPC_R_TEXTURE = string.format(RSConstants.TEXTURE_PATH, string.format("%s%s", RSConstants.RED_NPC_TEXTURE_FILE, RSConstants.GROUP_RIGHT_TEXTURE_FILE));
RSConstants.PINK_NPC_TEXTURE = string.format(RSConstants.TEXTURE_PATH, RSConstants.PINK_NPC_TEXTURE_FILE);
RSConstants.GROUP_PINK_NPC_T_TEXTURE = string.format(RSConstants.TEXTURE_PATH, string.format("%s%s", RSConstants.PINK_NPC_TEXTURE_FILE, RSConstants.GROUP_TOP_TEXTURE_FILE));
RSConstants.GROUP_PINK_NPC_L_TEXTURE = string.format(RSConstants.TEXTURE_PATH, string.format("%s%s", RSConstants.PINK_NPC_TEXTURE_FILE, RSConstants.GROUP_LEFT_TEXTURE_FILE));
RSConstants.GROUP_PINK_NPC_R_TEXTURE = string.format(RSConstants.TEXTURE_PATH, string.format("%s%s", RSConstants.PINK_NPC_TEXTURE_FILE, RSConstants.GROUP_RIGHT_TEXTURE_FILE));
RSConstants.BLUE_NPC_TEXTURE = string.format(RSConstants.TEXTURE_PATH, RSConstants.BLUE_NPC_TEXTURE_FILE);
RSConstants.GROUP_BLUE_NPC_T_TEXTURE = string.format(RSConstants.TEXTURE_PATH, string.format("%s%s", RSConstants.BLUE_NPC_TEXTURE_FILE, RSConstants.GROUP_TOP_TEXTURE_FILE));
RSConstants.GROUP_BLUE_NPC_L_TEXTURE = string.format(RSConstants.TEXTURE_PATH, string.format("%s%s", RSConstants.BLUE_NPC_TEXTURE_FILE, RSConstants.GROUP_LEFT_TEXTURE_FILE));
RSConstants.GROUP_BLUE_NPC_R_TEXTURE = string.format(RSConstants.TEXTURE_PATH, string.format("%s%s", RSConstants.BLUE_NPC_TEXTURE_FILE, RSConstants.GROUP_RIGHT_TEXTURE_FILE));
RSConstants.LIGHT_BLUE_NPC_TEXTURE = string.format(RSConstants.TEXTURE_PATH, RSConstants.LIGHT_BLUE_NPC_TEXTURE_FILE);
RSConstants.GROUP_LIGHT_BLUE_NPC_T_TEXTURE = string.format(RSConstants.TEXTURE_PATH, string.format("%s%s", RSConstants.LIGHT_BLUE_NPC_TEXTURE_FILE, RSConstants.GROUP_TOP_TEXTURE_FILE));
RSConstants.GROUP_LIGHT_BLUE_NPC_L_TEXTURE = string.format(RSConstants.TEXTURE_PATH, string.format("%s%s", RSConstants.LIGHT_BLUE_NPC_TEXTURE_FILE, RSConstants.GROUP_LEFT_TEXTURE_FILE));
RSConstants.GROUP_LIGHT_BLUE_NPC_R_TEXTURE = string.format(RSConstants.TEXTURE_PATH, string.format("%s%s", RSConstants.LIGHT_BLUE_NPC_TEXTURE_FILE, RSConstants.GROUP_RIGHT_TEXTURE_FILE));
RSConstants.PURPLE_NPC_TEXTURE = string.format(RSConstants.TEXTURE_PATH, RSConstants.PURPLE_NPC_TEXTURE_FILE);
RSConstants.GROUP_PURPLE_NPC_T_TEXTURE = string.format(RSConstants.TEXTURE_PATH, string.format("%s%s", RSConstants.PURPLE_NPC_TEXTURE_FILE, RSConstants.GROUP_TOP_TEXTURE_FILE));
RSConstants.GROUP_PURPLE_NPC_L_TEXTURE = string.format(RSConstants.TEXTURE_PATH, string.format("%s%s", RSConstants.PURPLE_NPC_TEXTURE_FILE, RSConstants.GROUP_LEFT_TEXTURE_FILE));
RSConstants.GROUP_PURPLE_NPC_R_TEXTURE = string.format(RSConstants.TEXTURE_PATH, string.format("%s%s", RSConstants.PURPLE_NPC_TEXTURE_FILE, RSConstants.GROUP_RIGHT_TEXTURE_FILE));
RSConstants.NORMAL_CONTAINER_TEXTURE = string.format(RSConstants.TEXTURE_PATH, RSConstants.NORMAL_CONTAINER_TEXTURE_FILE);
RSConstants.GROUP_NORMAL_CONTAINER_T_TEXTURE = string.format(RSConstants.TEXTURE_PATH, string.format("%s%s", RSConstants.NORMAL_CONTAINER_TEXTURE_FILE, RSConstants.GROUP_TOP_TEXTURE_FILE));
RSConstants.GROUP_NORMAL_CONTAINER_L_TEXTURE = string.format(RSConstants.TEXTURE_PATH, string.format("%s%s", RSConstants.NORMAL_CONTAINER_TEXTURE_FILE, RSConstants.GROUP_LEFT_TEXTURE_FILE));
RSConstants.GROUP_NORMAL_CONTAINER_R_TEXTURE = string.format(RSConstants.TEXTURE_PATH, string.format("%s%s", RSConstants.NORMAL_CONTAINER_TEXTURE_FILE, RSConstants.GROUP_RIGHT_TEXTURE_FILE));
RSConstants.RED_CONTAINER_TEXTURE = string.format(RSConstants.TEXTURE_PATH, RSConstants.RED_CONTAINER_TEXTURE_FILE);
RSConstants.GROUP_RED_CONTAINER_T_TEXTURE = string.format(RSConstants.TEXTURE_PATH, string.format("%s%s", RSConstants.RED_CONTAINER_TEXTURE_FILE, RSConstants.GROUP_TOP_TEXTURE_FILE));
RSConstants.GROUP_RED_CONTAINER_L_TEXTURE = string.format(RSConstants.TEXTURE_PATH, string.format("%s%s", RSConstants.RED_CONTAINER_TEXTURE_FILE, RSConstants.GROUP_LEFT_TEXTURE_FILE));
RSConstants.GROUP_RED_CONTAINER_R_TEXTURE = string.format(RSConstants.TEXTURE_PATH, string.format("%s%s", RSConstants.RED_CONTAINER_TEXTURE_FILE, RSConstants.GROUP_RIGHT_TEXTURE_FILE));
RSConstants.PINK_CONTAINER_TEXTURE = string.format(RSConstants.TEXTURE_PATH, RSConstants.PINK_CONTAINER_TEXTURE_FILE);
RSConstants.GROUP_PINK_CONTAINER_T_TEXTURE = string.format(RSConstants.TEXTURE_PATH, string.format("%s%s", RSConstants.PINK_CONTAINER_TEXTURE_FILE, RSConstants.GROUP_TOP_TEXTURE_FILE));
RSConstants.GROUP_PINK_CONTAINER_L_TEXTURE = string.format(RSConstants.TEXTURE_PATH, string.format("%s%s", RSConstants.PINK_CONTAINER_TEXTURE_FILE, RSConstants.GROUP_LEFT_TEXTURE_FILE));
RSConstants.GROUP_PINK_CONTAINER_R_TEXTURE = string.format(RSConstants.TEXTURE_PATH, string.format("%s%s", RSConstants.PINK_CONTAINER_TEXTURE_FILE, RSConstants.GROUP_RIGHT_TEXTURE_FILE));
RSConstants.BLUE_CONTAINER_TEXTURE = string.format(RSConstants.TEXTURE_PATH, RSConstants.BLUE_CONTAINER_TEXTURE_FILE);
RSConstants.GROUP_BLUE_CONTAINER_T_TEXTURE = string.format(RSConstants.TEXTURE_PATH, string.format("%s%s", RSConstants.BLUE_CONTAINER_TEXTURE_FILE, RSConstants.GROUP_TOP_TEXTURE_FILE));
RSConstants.GROUP_BLUE_CONTAINER_L_TEXTURE = string.format(RSConstants.TEXTURE_PATH, string.format("%s%s", RSConstants.BLUE_CONTAINER_TEXTURE_FILE, RSConstants.GROUP_LEFT_TEXTURE_FILE));
RSConstants.GROUP_BLUE_CONTAINER_R_TEXTURE = string.format(RSConstants.TEXTURE_PATH, string.format("%s%s", RSConstants.BLUE_CONTAINER_TEXTURE_FILE, RSConstants.GROUP_RIGHT_TEXTURE_FILE));
RSConstants.NORMAL_EVENT_TEXTURE = string.format(RSConstants.TEXTURE_PATH, RSConstants.NORMAL_EVENT_TEXTURE_FILE);
RSConstants.GROUP_NORMAL_EVENT_T_TEXTURE = string.format(RSConstants.TEXTURE_PATH, string.format("%s%s", RSConstants.NORMAL_EVENT_TEXTURE_FILE, RSConstants.GROUP_TOP_TEXTURE_FILE));
RSConstants.GROUP_NORMAL_EVENT_L_TEXTURE = string.format(RSConstants.TEXTURE_PATH, string.format("%s%s", RSConstants.NORMAL_EVENT_TEXTURE_FILE, RSConstants.GROUP_LEFT_TEXTURE_FILE));
RSConstants.GROUP_NORMAL_EVENT_R_TEXTURE = string.format(RSConstants.TEXTURE_PATH, string.format("%s%s", RSConstants.NORMAL_EVENT_TEXTURE_FILE, RSConstants.GROUP_RIGHT_TEXTURE_FILE));
RSConstants.RED_EVENT_TEXTURE = string.format(RSConstants.TEXTURE_PATH, RSConstants.RED_EVENT_TEXTURE_FILE);
RSConstants.GROUP_RED_EVENT_T_TEXTURE = string.format(RSConstants.TEXTURE_PATH, string.format("%s%s", RSConstants.RED_EVENT_TEXTURE_FILE, RSConstants.GROUP_TOP_TEXTURE_FILE));
RSConstants.GROUP_RED_EVENT_L_TEXTURE = string.format(RSConstants.TEXTURE_PATH, string.format("%s%s", RSConstants.RED_EVENT_TEXTURE_FILE, RSConstants.GROUP_LEFT_TEXTURE_FILE));
RSConstants.GROUP_RED_EVENT_R_TEXTURE = string.format(RSConstants.TEXTURE_PATH, string.format("%s%s", RSConstants.RED_EVENT_TEXTURE_FILE, RSConstants.GROUP_RIGHT_TEXTURE_FILE));
RSConstants.PINK_EVENT_TEXTURE = string.format(RSConstants.TEXTURE_PATH, RSConstants.PINK_EVENT_TEXTURE_FILE);
RSConstants.GROUP_PINK_EVENT_T_TEXTURE = string.format(RSConstants.TEXTURE_PATH, string.format("%s%s", RSConstants.PINK_EVENT_TEXTURE_FILE, RSConstants.GROUP_TOP_TEXTURE_FILE));
RSConstants.GROUP_PINK_EVENT_L_TEXTURE = string.format(RSConstants.TEXTURE_PATH, string.format("%s%s", RSConstants.PINK_EVENT_TEXTURE_FILE, RSConstants.GROUP_LEFT_TEXTURE_FILE));
RSConstants.GROUP_PINK_EVENT_R_TEXTURE = string.format(RSConstants.TEXTURE_PATH, string.format("%s%s", RSConstants.PINK_EVENT_TEXTURE_FILE, RSConstants.GROUP_RIGHT_TEXTURE_FILE));
RSConstants.BLUE_EVENT_TEXTURE = string.format(RSConstants.TEXTURE_PATH, RSConstants.BLUE_EVENT_TEXTURE_FILE);
RSConstants.GROUP_BLUE_EVENT_T_TEXTURE = string.format(RSConstants.TEXTURE_PATH, string.format("%s%s", RSConstants.BLUE_EVENT_TEXTURE_FILE, RSConstants.GROUP_TOP_TEXTURE_FILE));
RSConstants.GROUP_BLUE_EVENT_L_TEXTURE = string.format(RSConstants.TEXTURE_PATH, string.format("%s%s", RSConstants.BLUE_EVENT_TEXTURE_FILE, RSConstants.GROUP_LEFT_TEXTURE_FILE));
RSConstants.GROUP_BLUE_EVENT_R_TEXTURE = string.format(RSConstants.TEXTURE_PATH, string.format("%s%s", RSConstants.BLUE_EVENT_TEXTURE_FILE, RSConstants.GROUP_RIGHT_TEXTURE_FILE));
RSConstants.OVERLAY_SPOT_TEXTURE = string.format(RSConstants.TEXTURE_PATH, RSConstants.OVERLAY_SPOT_TEXTURE_FILE);
RSConstants.GUIDE_TRANSPORT_TEXTURE = string.format(RSConstants.TEXTURE_PATH, RSConstants.GUIDE_TRANSPORT_FILE);
RSConstants.GUIDE_ENTRANCE_TEXTURE = string.format(RSConstants.TEXTURE_PATH, RSConstants.GUIDE_ENTRANCE_FILE);
RSConstants.GUIDE_FLAG_TEXTURE = string.format(RSConstants.TEXTURE_PATH, RSConstants.GUIDE_FLAG_FILE);
RSConstants.GUIDE_DOT_TEXTURE = string.format(RSConstants.TEXTURE_PATH, RSConstants.GUIDE_DOT_FILE);
RSConstants.GUIDE_STEP1_TEXTURE = string.format(RSConstants.TEXTURE_PATH, RSConstants.GUIDE_STEP1_FILE);
RSConstants.GUIDE_STEP2_TEXTURE = string.format(RSConstants.TEXTURE_PATH, RSConstants.GUIDE_STEP2_FILE);
RSConstants.GUIDE_STEP3_TEXTURE = string.format(RSConstants.TEXTURE_PATH, RSConstants.GUIDE_STEP3_FILE);
RSConstants.GUIDE_STEP4_TEXTURE = string.format(RSConstants.TEXTURE_PATH, RSConstants.GUIDE_STEP4_FILE);
RSConstants.GUIDE_STEP5_TEXTURE = string.format(RSConstants.TEXTURE_PATH, RSConstants.GUIDE_STEP5_FILE);
RSConstants.GUIDE_STEP6_TEXTURE = string.format(RSConstants.TEXTURE_PATH, RSConstants.GUIDE_STEP6_FILE);
RSConstants.GUIDE_STEP7_TEXTURE = string.format(RSConstants.TEXTURE_PATH, RSConstants.GUIDE_STEP7_FILE);
RSConstants.GUIDE_STEP8_TEXTURE = string.format(RSConstants.TEXTURE_PATH, RSConstants.GUIDE_STEP8_FILE);
RSConstants.GUIDE_STEP9_TEXTURE = string.format(RSConstants.TEXTURE_PATH, RSConstants.GUIDE_STEP9_FILE);

---============================================================================
-- Guide constants
---============================================================================

RSConstants.TRANSPORT = "T"
RSConstants.ENTRANCE = "E"
RSConstants.PATH_START = "P"
RSConstants.FLAG = "F"
RSConstants.DOT = "D"
RSConstants.STEP1 = "1"
RSConstants.STEP2 = "2"
RSConstants.STEP3 = "3"
RSConstants.STEP4 = "4"
RSConstants.STEP5 = "5"
RSConstants.STEP6 = "6"
RSConstants.STEP7 = "7"

---============================================================================
-- Dialogs
---============================================================================

RSConstants.APPLY_COLLECTIONS_LOOT_FILTERS = "RARESCANNER_APPLY_COLLECTIONS_LOOT_FILTERS"
RSConstants.EXPLORER_FILTERING_DIALOG = "RARESCANNER_EXPLORER_FILTERING_DIALOG"
RSConstants.EXPLORER_SCAN_NOT_DONE = "RARESCANNER_EXPLORER_SCAN_NOT_DONE"
RSConstants.ITEM_LIST_VALIDATION_ERROR = "RARESCANNER_INFO_DIALOG"
RSConstants.ITEM_LIST_WRONG_IDS_ERROR = "RARESCANNER_ITEM_LIST_WRONG_IDS_ERROR"
RSConstants.DELETE_GROUP_CONFIRMATION = "RARESCANNER_DELETE_GROUP_CONFIRMATION"

---============================================================================
-- Explorer filters
---============================================================================

RSConstants.EXPLORER_FILTER_DROP_MOUNTS = 1
RSConstants.EXPLORER_FILTER_DROP_PETS = 2
RSConstants.EXPLORER_FILTER_DROP_TOYS = 3
RSConstants.EXPLORER_FILTER_DROP_APPEARANCES = 4
RSConstants.EXPLORER_FILTER_DROP_CUSTOM = "c%s"
RSConstants.EXPLORER_FILTER_ACHIEVEMENT_CRITERIA = 5
RSConstants.EXPLORER_FILTER_DEAD = 6
RSConstants.EXPLORER_FILTER_FILTERED = 7
RSConstants.EXPLORER_FILTER_WITHOUT_COLLECTIBLES = 8

---============================================================================
-- Others
---============================================================================

RSConstants.RAID_WARNING_SHOWING_TIME = 3
RSConstants.MINIMUM_DISTANCE_PINS_WORLD_MAP = 0.005
RSConstants.TOOLTIP_MAX_WIDTH = 300
RSConstants.TOOLTIP_MIN_WIDTH = 100

---============================================================================
-- Auxiliar functions
---============================================================================

function RSConstants.IsScanneableAtlas(atlasName)
	return RSConstants.IsEventAtlas(atlasName) or RSConstants.IsNpcAtlas(atlasName) or RSConstants.IsContainerAtlas(atlasName)
end

function RSConstants.IsEventAtlas(atlasName)
	return atlasName == RSConstants.EVENT_VIGNETTE or atlasName == RSConstants.EVENT_ELITE_VIGNETTE
end

function RSConstants.IsNpcAtlas(atlasName)
	return atlasName == RSConstants.NPC_VIGNETTE or atlasName == RSConstants.NPC_VIGNETTE_ELITE
end

function RSConstants.IsContainerAtlas(atlasName)
	return atlasName == RSConstants.CONTAINER_VIGNETTE or atlasName == RSConstants.CONTAINER_ELITE_VIGNETTE or atlasName == RSConstants.CONTAINER_LOCKED_VIGNETTE or atlasName == RSConstants.CONTAINER_ELITE_LOCKED_VIGNETTE or atlasName == RSConstants.CONTAINER_LORE_OBJECT
end