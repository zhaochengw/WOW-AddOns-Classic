--[[
    Ackis Recipe List - Location Object
    
    Provides zone/location tracking for recipe sources:
    - Zone map ID constants for all WoW zones
    - Location object with parent/child relationships
    - HereBeDragons integration for map ID resolution
    - Instance entrance coordinates for waypoint navigation
    
    Copyright (c) 2009 - 2012 Ackis <John Pasula>
    All rights reserved by the original author Ackis.
]]

-- ============================================================================
-- Upvalued Lua API
-- ============================================================================
local string = _G.string
local pairs = _G.pairs
local ipairs = _G.ipairs
local tonumber = _G.tonumber
local type = _G.type

-- ============================================================================
-- AddOn Namespace
-- ============================================================================
local FOLDER_NAME, private = ...

local LibStub = _G.LibStub
local HBD = LibStub("HereBeDragons-2.0")

-- ============================================================================
-- Zone Map ID Constants
-- ============================================================================
local ZONE_MAP_IDS = {

	-------------------------------------------------------------------------------
	-- Continents
	-------------------------------------------------------------------------------
	KALIMDOR = 12,
	EASTERN_KINGDOMS = 13,
	OUTLAND = 101,
	NORTHREND = 113,
	PANDARIA = 424,
	DRAENOR = 572,
	BROKEN_ISLES = 619,
	ZANDALAR = 875,
	KUL_TIRAS = 876,
	ARGUS = 905,
	COSMIC = 946,
	AZEROTH = 947,
	THE_MAELSTROM = 948,
	THE_SHADOWLANDS = 1550,

	DUROTAR = 1,
	MULGORE = 7,
	NORTHERN_BARRENS = 10,
	ARATHI_HIGHLANDS = 14,
	BADLANDS = 15,
	BLASTED_LANDS = 17,
	TIRISFAL_GLADES = 18,
	SILVERPINE_FOREST = 21,
	WESTERN_PLAGUELANDS = 22,
	EASTERN_PLAGUELANDS = 23,
	HILLSBRAD_FOOTHILLS = 25,
	THE_HINTERLANDS = 26,
	DUN_MOROGH = 27,
	SEARING_GORGE = 32,
	BURNING_STEPPES = 36,
	ELWYNN_FOREST = 37,
	DEADWIND_PASS = 42,
	DUSKWOOD = 47,
	LOCH_MODAN = 48,
	REDRIDGE_MOUNTAINS = 49,
	NORTHERN_STRANGLETHORN = 50,
	SWAMP_OF_SORROWS = 51,
	WESTFALL = 52,
	WETLANDS = 56,
	TELDRASSIL = 57,
	DARKSHORE = 62,
	ASHENVALE = 63,
	THOUSAND_NEEDLES = 64,
	STONETALON_MOUNTAINS = 65,
	DESOLACE = 66,
	FERALAS = 69,
	DUSTWALLOW_MARSH = 70,
	TANARIS = 71,
	CAVERNS_OF_TIME = 75,
	AZSHARA = 76,
	FELWOOD = 77,
	UNGORO_CRATER = 78,
	MOONGLADE = 80,
	SILITHUS = 81,
	WINTERSPRING = 83,
	STORMWIND_CITY = 84,
	ORGRIMMAR = 85,
	IRONFORGE = 87,
	THUNDER_BLUFF = 88,
	DARNASSUS = 89,
	UNDERCITY = { 90, 998 },
	ALTERAC_VALLEY = 91,
	ARATHI_BASIN = 93,
	EVERSONG_WOODS = 94,
	GHOSTLANDS = 95,
	AZUREMYST_ISLE = 97,
	HELLFIRE_PENINSULA = 100,
	ZANGARMARSH = 102,
	THE_EXODAR = 103,
	SHADOWMOON_VALLEY_OUTLAND = 104,
	BLADES_EDGE_MOUNTAINS = 105,
	BLOODMYST_ISLE = 106,
	NAGRAND_OUTLAND = 107,
	TEROKKAR_FOREST = 108,
	NETHERSTORM = 109,
	SILVERMOON_CITY = 110,
	SHATTRATH_CITY = 111,
	BOREAN_TUNDRA = 114,
	DRAGONBLIGHT = 115,
	GRIZZLY_HILLS = 116,
	HOWLING_FJORD = 117,
	ICECROWN = 118,
	SHOLAZAR_BASIN = 119,
	THE_STORM_PEAKS = 120,
	ZULDRAK = 121,
	ISLE_OF_QUELDANAS = 122,
	WINTERGRASP = 123,
	PLAGUELANDS_THE_SCARLET_ENCLAVE = 124,
	DALARAN_NORTHREND = 125,
	CRYSTALSONG_FOREST = 127,
	THE_NEXUS = 129,
	THE_CULLING_OF_STRATHOLME = 130,
	AHNKAHET_THE_OLD_KINGDOM = 132,
	UTGARDE_KEEP = 133,
	UTGARDE_PINNACLE = 136,
	HALLS_OF_LIGHTNING = 138,
	HALLS_OF_STONE = 140,
	THE_EYE_OF_ETERNITY = 141,
	THE_OCULUS = 142,
	ULDUAR = 147,
	GUNDRAK = 154,
	THE_OBSIDIAN_SANCTUM = 155,
	VAULT_OF_ARCHAVON = 156,
	AZJOL_NERUB = 157,
	DRAKTHARON_KEEP = 160,
	NAXXRAMAS = 162,
	THE_VIOLET_HOLD = 168,
	TRIAL_OF_THE_CRUSADER = 172,
	THE_LOST_ISLES = 174,
	GILNEAS = 179,
	THE_FORGE_OF_SOULS = 183,
	ICECROWN_CITADEL = 186,
	KEZAN = 194,
	MOUNT_HYJAL = 198,
	SOUTHERN_BARRENS = 199,
	KELPTHAR_FOREST = 201,
	GILNEAS_CITY = 202,
	VASHJIR = 203,
	ABYSSAL_DEPTHS = 204,
	SHIMMERING_EXPANSE = 205,
	DEEPHOLM = 207,
	THE_CAPE_OF_STRANGLETHORN = 210,
	RUINS_OF_GILNEAS = 217,
	ZULFARRAK = 219,
	THE_TEMPLE_OF_ATALHAKKAR = 220,
	BLACKFATHOM_DEEPS = 221,
	STRANGLETHORN_VALE = 224, --Need for Cape of Stranglethorn
	GNOMEREGAN = 226,
	ULDAMAN = 230,
	MOLTEN_CORE = 232,
	DIRE_MAUL = 234,
	TWILIGHT_HIGHLANDS = 241,
	BLACKROCK_DEPTHS = 242,
	TOL_BARAD = 244,
	TOL_BARAD_PENINSULA = 245,
	THE_SHATTERED_HALLS = 246,
	RUINS_OF_AHNQIRAJ = 247,
	ONYXIAS_LAIR = 248,
	ULDUM = { 249, 1527, },
	BLACKROCK_SPIRE = 250,
	AUCHENAI_CRYPTS = 256,
	SETHEKK_HALLS = 258,
	SHADOW_LABYRINTH = 260,
	THE_BLOOD_FURNACE = 261,
	THE_UNDERBOG = 262,
	THE_STEAMVAULT = 263,
	THE_SLAVE_PENS = 265,
	THE_BOTANICA = 266,
	THE_MECHANAR = 267,
	THE_ARCATRAZ = 269,
	MANA_TOMBS = 272,
	THE_BLACK_MORASS = 273,
	OLD_HILLSBRAD_FOOTHILLS = 274,
	WAILING_CAVERNS = 279,
	BLACKWING_DESCENT = 285,
	BLACKWING_LAIR = 287,
	THE_DEADMINES = 291,
	THE_BASTION_OF_TWILIGHT = 294,
	RAZORFEN_DOWNS = 300,
	SCARLET_MONASTERY = 302,
	SHADOWFANG_KEEP = 310,
	STRATHOLME = 317,
	AHNQIRAJ = 319,
	THE_STONECORE = 324,
	THE_VORTEX_PINNACLE = 325,
	AHNQIRAJ_THE_FALLEN_KINGDOM = 327,
	THRONE_OF_THE_FOUR_WINDS = 328,
	GRUULS_LAIR = 330,
	MAGTHERIDONS_LAIR = 331,
	HYJAL_SUMMIT = 329,
	SERPENTSHRINE_CAVERN = 332,
	ZULAMAN = 333,
	TEMPEST_KEEP = 334,
	SUNWELL_PLATEAU = 335,
	ZULGURUB = 337,
	MOLTEN_FRONT = 338,
	BLACK_TEMPLE = 339,
	MAGISTERS_TERRACE = 348,
	HELLFIRE_RAMPARTS = 347,
	KARAZHAN = 350,
	FIRELANDS = 367,
	THE_JADE_FOREST = 371,
	VALLEY_OF_THE_FOUR_WINDS = 376,
	THE_WANDERING_ISLE = 378,
	KUN_LAI_SUMMIT = 379,
	TOWNLONG_STEPPES = 388,
	VALE_OF_ETERNAL_BLOSSOMS = { 1530, 390, },
	WELL_OF_ETERNITY = 398,
	END_TIME = 401,
	DARKMOON_ISLAND = 407,
	DRAGON_SOUL = 409,

	KRASARANG_WILDS = 418,
	DREAD_WASTES = 422,
	THE_VEILED_STAIR = 433,
	TERRACE_OF_ENDLESS_SPRING = 456,
	SUNSTRIDER_ISLE = 467,
	AMMEN_VALE = 468,
	NEW_TINKERTOWN = 469,
	MOGUSHAN_VAULTS = 471,
	HEART_OF_FEAR = 474,
	SCHOLOMANCE = 476,
	CRYPT_OF_FORGOTTEN_KINGS = 481,
	DEEPRUN_TRAM = 499,
	BRAWLGAR_ARENA = 503,
	ISLE_OF_GIANTS = 507,
	THRONE_OF_THUNDER = 508,
	ISLE_OF_THUNDER = 516,
	FROSTFIRE_RIDGE = 525,
	TANAAN_JUNGLE = 534,
	TALADOR = 535,
	SHADOWMOON_VALLEY_DRAENOR = 539,
	SPIRES_OF_ARAK = 542,
	GORGROND = 543,
	NAGRAND_DRAENOR = 550,
	TIMELESS_ISLE = 554,
	SIEGE_OF_ORGRIMMAR = 556,

	LUNARFALL = { 582, 579, 580, 581, },
	FROSTWALL = 590,
	ASHRAN = 588,
	IRON_DOCKS = 595,
	BLACKROCK_FOUNDRY = 596,
	SKYREACH = 601,
	UPPER_BLACKROCK_SPIRE = 616,
	STORMSHIELD = 622,
	WARSPEAR = 624,
	HELLFIRE_CITADEL = 661,

	DALARAN_BROKENISLES = 627,
	AZSUNA = 630,
	STORMHEIM = 634,
	VALSHARAH = 641,
	BROKEN_SHORE = 646,
	HELHEIM = 649,
	HIGHMOUNTAIN = 650,
	THUNDER_TOTEM = 652,
	VAULT_OF_THE_WARDENS = 677,
	SURAMAR = 680,
	HELMOUTH_CLIFFS = 706,
	EYE_OF_AZSHARA = 790,
	NELTHARIONS_LAIR = 731,
	VIOLET_HOLD = 723,
	DARKHEART_THICKET = 733,
	THE_ARCWAY = 749,
	BLACK_ROOK_HOLD  = 751,
	COURT_OF_STARS = 761,
	THE_NIGHTHOLD = 764,
	THE_EMERALD_NIGHTMARE = 777,
	TRIAL_OF_VALOR = 806,
	HALLS_OF_VALOR = 829,
	TOMB_OF_SARGERAS = 850,
	THE_DEATHS_OF_CHROMIE = 897,

	KROKUUN = 830,
	MACAREE = 882,
	ANTORAN_WASTES = 885,
	THE_SEAT_OF_THE_TRIUMVIRATE = 903,
	RUINS_OF_LORDAERON = 908,
	ANTORUS__THE_BURNING_THRONE = 909,

	-- BFA
	ZULDAZAR = 862,
	NAZMIR = 863,
	VOLDUN = 864,
	TIRAGARDE_SOUND = 895,
	DRUSTVAR = 896,
	FREEHOLD = 936,
	STORMSONG_VALLEY = 942,
	KINGS_REST = 1004,
	THE_MOTHERLODE = 1010,
	WAYCREST_MANOR = 1015,
	THE_UNDERROT = 1042,
	ULDIR = 1148,
	BORALUS = 1161,
	DAZARALOR = 1165,
	BATTLE_OF_DAZARALOR = 1352,
	NAZJATAR = 1355,
	CRUCIBLE_OF_STORMS = 1363,
	MECHAGON_ISLAND = 1462,
	OPERATION_MECHAGON = 1490,
	THE_ETERNAL_PALACE = 1512,
	NYALOTHA = 1580,

	-- SHADOWLANDS
	REVENDRETH = 1525,
	BASTION = 1533,
	MALDRAXXUS = 1536,
	THE_MAW = 1543,
	ARDENWEALD = 1565,
	ORIBOS = 1670,
	DE_OTHER_SIDE = 1680,
	CASTLE_NATHRIA = 1735,
	KORTHIA = 1961,
	ZERETH_MORTIS = 1970,
	SANCTUM_OF_DOMINATION = 1998,
	SEPULCHER_OF_THE_FIRST_ONES = 2047,
}

-- ============================================================================
-- Continent Data
-- Sequential continent IDs mapped to map IDs and names
-- Format: mapID, "Name" pairs for iteration
-- Note: Cosmic (946) and Azeroth (947) excluded to prevent UI display issues
-- ============================================================================
local mapContinentData = {
	12, "Kalimdor",
	13, "Eastern Kingdoms",
	101, "Outland",
	113, "Northrend",
	424, "Pandaria",
	572, "Draenor",
	619, "Broken Isles",
	875, "Zandalar",
	876, "Kul Tiras",
	905, "Argus",
	948, "The Maelstrom",
	1550, "The Shadowlands",
}

-- ============================================================================
-- Local Variables
-- ============================================================================
local ZONE_NAMES = {}
local ZONE_PARENTS = {}
local PARENS_TEMPLATE = _G.PARENS_TEMPLATE or "(%s)"
local UNKNOWN = _G.UNKNOWN or "Unknown"

-- ============================================================================
-- Helper Functions
-- ============================================================================

--- Convert a zone label to human-readable name
--- "SHADOWMOON_VALLEY_OUTLAND" -> "Shadowmoon Valley (Outland)"
--- @param label string The zone label from ZONE_MAP_IDS
--- @return string pretty The formatted zone name
local function PrettyNameFromLabel(label)
	if not label or type(label) ~= "string" then
		return UNKNOWN
	end

	local suffixToContinent = {
		_OUTLAND = "Outland",
		_DRAENOR = "Draenor",
		_NORTHREND = "Northrend",
		_BROKENISLES = "Broken Isles",
		_BROKEN_ISLES = "Broken Isles",
		_PANDARIA = "Pandaria",
	}

	local continentSuffix, continentPretty
	for suffix, pretty in pairs(suffixToContinent) do
		if label:sub(-#suffix) == suffix then
			continentSuffix = suffix
			continentPretty = pretty
			break
		end
	end

	local baseLabel = label
	if continentSuffix then
		baseLabel = label:sub(1, #label - #continentSuffix)
		if baseLabel:sub(-1) == "_" then
			baseLabel = baseLabel:sub(1, #baseLabel - 1)
		end
	end

	local smallWords = {
		of = true, the = true, ["and"] = true, ["in"] = true, on = true,
		at = true, to = true, ["for"] = true, ["with"] = true, ["by"] = true, from = true,
	}

	local words = {}
	for part in baseLabel:gmatch("[^_]+") do
		local lower = part:lower()
		local word
		if #words > 0 and smallWords[lower] then
			word = lower
		else
			word = lower:gsub("^%l", string.upper)
		end
		table.insert(words, word)
	end

	local pretty = table.concat(words, " ")
	if continentPretty then
		return ("%s %s"):format(pretty, PARENS_TEMPLATE:format(continentPretty))
	end
	return pretty
end

--- Get localized map name safely via HereBeDragons
--- @param mapID number The map ID to look up
--- @return string name The localized name or UNKNOWN
local function SafeMapName(mapID)
	if not mapID then
		return UNKNOWN
	end
	local name = HBD:GetLocalizedMap(mapID)
	return name or UNKNOWN
end

-- ============================================================================
-- Zone Name Initialization
-- Build ZONE_NAMES lookup table from ZONE_MAP_IDS using HBD for localization
-- ============================================================================

for zoneLabel, mapID in pairs(ZONE_MAP_IDS) do
	if type(mapID) == "table" then
		local name
		for i = 1, #mapID do
			name = SafeMapName(mapID[i])
			if name and name ~= UNKNOWN then break end
		end
		ZONE_NAMES[zoneLabel] = (name and name ~= UNKNOWN) and name or PrettyNameFromLabel(zoneLabel)
	else
		local name = SafeMapName(mapID)
		ZONE_NAMES[zoneLabel] = (name and name ~= UNKNOWN) and name or PrettyNameFromLabel(zoneLabel)
	end
end

-- Fallback names for continents/capitals when HBD returns no data
do
	local CONTINENT_FALLBACK_NAMES = {
		KALIMDOR = "Kalimdor",
		EASTERN_KINGDOMS = "Eastern Kingdoms",
		OUTLAND = "Outland",
		NORTHREND = "Northrend",
		PANDARIA = "Pandaria",
		DRAENOR = "Draenor",
		BROKEN_ISLES = "Broken Isles",
	}
	for label, fallback in pairs(CONTINENT_FALLBACK_NAMES) do
		if not ZONE_NAMES[label] or ZONE_NAMES[label] == UNKNOWN then
			ZONE_NAMES[label] = fallback
		end
	end

	local CAPITAL_FALLBACK_NAMES = {
		UNDERCITY = "Undercity",
		STORMWIND_CITY = "Stormwind City",
		ORGRIMMAR = "Orgrimmar",
		IRONFORGE = "Ironforge",
		DARNASSUS = "Darnassus",
		THUNDER_BLUFF = "Thunder Bluff",
		SILVERMOON_CITY = "Silvermoon City",
		THE_EXODAR = "The Exodar",
		WARSPEAR = "Warspear",
		STORMSHIELD = "Stormshield",
		KRASARANG_WILDS = "Krasarang Wilds",
	}
	for label, fallback in pairs(CAPITAL_FALLBACK_NAMES) do
		if not ZONE_NAMES[label] or ZONE_NAMES[label] == UNKNOWN then
			ZONE_NAMES[label] = fallback
		end
	end
end

private.ZONE_NAMES = ZONE_NAMES
private.constants.ZONE_NAMES = ZONE_NAMES

-- Disambiguated zones with multiple versions (e.g., Shadowmoon Valley Outland vs Draenor)
local specialLabels = {
	"SHADOWMOON_VALLEY_OUTLAND",
	"SHADOWMOON_VALLEY_DRAENOR",
	"NAGRAND_OUTLAND",
	"NAGRAND_DRAENOR",
	"DALARAN_NORTHREND",
	"DALARAN_BROKENISLES",
}
for i = 1, #specialLabels do
	local label = specialLabels[i]
	if not ZONE_NAMES[label] or ZONE_NAMES[label] == UNKNOWN then
		ZONE_NAMES[label] = PrettyNameFromLabel(label)
	end
end

-- Reverse lookup tables
local ZONE_LABELS_FROM_NAME = {}
private.ZONE_LABELS_FROM_NAME = ZONE_LABELS_FROM_NAME

local ZONE_LABELS_FROM_MAP_ID = {}

for label, name in pairs(ZONE_NAMES) do
	ZONE_LABELS_FROM_NAME[name] = label

	local mapIDValue = ZONE_MAP_IDS[label]
	if type(mapIDValue) == "table" then
		for mapIDIndex = 1, #mapIDValue do
			ZONE_LABELS_FROM_MAP_ID[mapIDValue[mapIDIndex]] = label
		end
	else
		ZONE_LABELS_FROM_MAP_ID[mapIDValue] = label
	end
end

-- ============================================================================
-- Cosmic Map IDs
-- Zones with parent=0 in HBD data that need explicit parent mapping
-- Required for proper waypoint placement and location hierarchy
-- ============================================================================
local COSMIC_MAP_IDS = {
	TELDRASSIL = 57,
	DARNASSUS = 89,
	UNDERCITY = 90,
	SHATTRATH_CITY = 111,
	ZANGARMARSH = 102,
	NAGRAND_OUTLAND = 107,
	SHADOWMOON_VALLEY_OUTLAND = 104,
	HELLFIRE_PENINSULA = 100,
	TEROKKAR_FOREST = 108,
	BLADES_EDGE_MOUNTAINS = 105,
	NETHERSTORM = 109,
	ULDUM = 249,
	THE_WANDERING_ISLE = 378,
	VALE_OF_ETERNAL_BLOSSOMS = 390,
	DARKMOON_ISLAND = 407,
	MOGUSHAN_VAULTS = 471,
	HELLFIRE_RAMPARTS = 347,
	THE_BOTANICA = 266,
	THE_MECHANAR = 267,
	THE_ARCATRAZ = 269,
	THE_BLOOD_FURNACE = 261,
	THE_SHATTERED_HALLS = 246,
	AUCHENAI_CRYPTS = 256,
	MANA_TOMBS = 272,
	SETHEKK_HALLS = 258,
	SHADOW_LABYRINTH = 260,
	THE_SLAVE_PENS = 265,
	THE_STEAMVAULT = 263,
	THE_UNDERBOG = 262,
	GRUULS_LAIR = 330,
	MAGTHERIDONS_LAIR = 331,
	SERPENTSHRINE_CAVERN = 332,
	TEMPEST_KEEP = 334,
	BLACK_TEMPLE = 339,
	SUNWELL_PLATEAU = 335,
	LUNARFALL = 582,
	FROSTWALL = 590,
	STORMSHIELD = 622,
	WARSPEAR = 624,
	NELTHARIONS_LAIR = 731,
	DARKHEART_THICKET = 733,
	NAZJATAR = 1355,
	THE_ETERNAL_PALACE = 1512,
	NYALOTHA = 1580,
	KORTHIA = 1961,
	SANCTUM_OF_DOMINATION = 1998,
	KRASARANG_WILDS = 418,
	STORMHEIM = 634,
}

-- Parent zone mapping for cosmic maps
local COSMIC_MAP_LOCATION_PARENT_MAPPING = {
	TELDRASSIL = ZONE_NAMES.KALIMDOR,
	DARNASSUS = ZONE_NAMES.KALIMDOR,
	UNDERCITY = ZONE_NAMES.EASTERN_KINGDOMS,
	SHATTRATH_CITY = ZONE_NAMES.OUTLAND,
	ZANGARMARSH = ZONE_NAMES.OUTLAND,
	NAGRAND_OUTLAND = ZONE_NAMES.OUTLAND,
	SHADOWMOON_VALLEY_OUTLAND = ZONE_NAMES.OUTLAND,
	HELLFIRE_PENINSULA = ZONE_NAMES.OUTLAND,
	TEROKKAR_FOREST = ZONE_NAMES.OUTLAND,
	BLADES_EDGE_MOUNTAINS = ZONE_NAMES.OUTLAND,
	NETHERSTORM = ZONE_NAMES.OUTLAND,
	THE_BLACK_MORASS = ZONE_NAMES.TANARIS,
	OLD_HILLSBRAD_FOOTHILLS = ZONE_NAMES.TANARIS,
	HYJAL_SUMMIT = ZONE_NAMES.TANARIS,
	THE_BOTANICA = ZONE_NAMES.NETHERSTORM,
	THE_MECHANAR = ZONE_NAMES.NETHERSTORM,
	THE_ARCATRAZ = ZONE_NAMES.NETHERSTORM,
	HELLFIRE_RAMPARTS = ZONE_NAMES.HELLFIRE_PENINSULA,
	THE_BLOOD_FURNACE = ZONE_NAMES.HELLFIRE_PENINSULA,
	THE_SHATTERED_HALLS = ZONE_NAMES.HELLFIRE_PENINSULA,
	AUCHENAI_CRYPTS = ZONE_NAMES.TEROKKAR_FOREST,
	MANA_TOMBS = ZONE_NAMES.TEROKKAR_FOREST,
	SETHEKK_HALLS = ZONE_NAMES.TEROKKAR_FOREST,
	SHADOW_LABYRINTH = ZONE_NAMES.TEROKKAR_FOREST,
	THE_SLAVE_PENS = ZONE_NAMES.ZANGARMARSH,
	THE_STEAMVAULT = ZONE_NAMES.ZANGARMARSH,
	THE_UNDERBOG = ZONE_NAMES.ZANGARMARSH,
	GRUULS_LAIR = ZONE_NAMES.BLADES_EDGE_MOUNTAINS,
	MAGTHERIDONS_LAIR = ZONE_NAMES.HELLFIRE_PENINSULA,
	SERPENTSHRINE_CAVERN = ZONE_NAMES.ZANGARMARSH,
	TEMPEST_KEEP = ZONE_NAMES.NETHERSTORM,
	BLACK_TEMPLE = ZONE_NAMES.SHADOWMOON_VALLEY_OUTLAND,
	SUNWELL_PLATEAU = ZONE_NAMES.ISLE_OF_QUELDANAS,
	THE_WANDERING_ISLE = ZONE_NAMES.THE_MAELSTROM,
	DARKMOON_ISLAND = ZONE_NAMES.THE_MAELSTROM,
	MOLTEN_CORE = ZONE_NAMES.BURNING_STEPPES,
	NORTHERN_BARRENS = ZONE_NAMES.KALIMDOR,
	SOUTHERN_BARRENS = ZONE_NAMES.KALIMDOR,
	LUNARFALL = ZONE_NAMES.SHADOWMOON_VALLEY_DRAENOR,
	FROSTWALL = ZONE_NAMES.FROSTFIRE_RIDGE,
	STORMSHIELD = ZONE_NAMES.ASHRAN,
	WARSPEAR = ZONE_NAMES.ASHRAN,
	NAZJATAR = ZONE_NAMES.KUL_TIRAS,
	MOGUSHAN_VAULTS = ZONE_NAMES.KUN_LAI_SUMMIT,
	NELTHARIONS_LAIR = ZONE_NAMES.HIGHMOUNTAIN,
	DARKHEART_THICKET = ZONE_NAMES.VALSHARAH,
	THE_ETERNAL_PALACE = ZONE_NAMES.KUL_TIRAS,
	NYALOTHA = ZONE_NAMES.ULDUM,
	KORTHIA = ZONE_NAMES.THE_SHADOWLANDS,
	THE_MAW = ZONE_NAMES.THE_SHADOWLANDS,
	SANCTUM_OF_DOMINATION = ZONE_NAMES.THE_SHADOWLANDS,
	KRASARANG_WILDS = ZONE_NAMES.PANDARIA,
	STORMHEIM = ZONE_NAMES.BROKEN_ISLES,
	VALE_OF_ETERNAL_BLOSSOMS = ZONE_NAMES.PANDARIA,
	ULDUM = ZONE_NAMES.KALIMDOR,
}

-- ============================================================================
-- Instance Entrance Coordinates
-- Format: "x:y" relative to parent zone (0-100 scale)
-- Used for waypoint placement at dungeon/raid entrances
-- ============================================================================
local INSTANCE_ENTRANCE_COORDINATES = {
	AHNKAHET_THE_OLD_KINGDOM = "28.49:51.73",
	AHNQIRAJ_THE_FALLEN_KINGDOM = "23.2:86.1",
	AUCHENAI_CRYPTS = "34.32:65.62",
	AZJOL_NERUB = "26.01:50.83",
	BLACK_ROOK_HOLD = "37.0:50.3",
	BLACKROCK_DEPTHS = "20.72:36.94", -- TODO: Double check BLACKROCK_DEPTHS, BLACKROCK_SPIRE, and BLACKWING_LAIR - their coordinates are identical.
	BLACKROCK_SPIRE = "20.72:36.94",
	BLACKWING_LAIR = "20.72:36.94",
	COURT_OF_STARS = "50.3:65.3",
	DE_OTHER_SIDE = "68.4:66.2",
	DIRE_MAUL = "61.36:31.78",
	DRAKTHARON_KEEP = "71.5:22.4",
	FIRELANDS = "46.5:79.8",
	GNOMEREGAN = "31.29:37.89",
	HALLS_OF_LIGHTNING = "45.40:21.37",
	HALLS_OF_STONE = "39.49:26.92",
	HELLFIRE_CITADEL = "46.5:53.2",
	KARAZHAN = "46.85:74.66",
	MAGISTERS_TERRACE = "61.20:30.89",
	MANA_TOMBS = "39.64:57.65",
	MOGUSHAN_VAULTS = "80.7:32.8",
	MOLTEN_CORE = "20.72:36.94",
	NYALOTHA = "55.2:43.9",
	OLD_HILLSBRAD_FOOTHILLS = "64.4:47.9",
	ONYXIAS_LAIR = "52.9:77.7",
	RUINS_OF_AHNQIRAJ = "36.2:93.8",
	SANCTUM_OF_DOMINATION = "69.6:31.7",
	SCHOLOMANCE = "70.7:70.7",
	SETHEKK_HALLS = "44.95:65.61",
	SHADOW_LABYRINTH = "39.64:73.58",
	SKYREACH = "36.0:33.9",
	STRATHOLME = "26.75:11.60",
	THE_ARCWAY = "43.0:61.7",
	THE_ARCATRAZ = "74.41:57.72",
	THE_BLACK_MORASS = "64.4:47.9",
	THE_BOTANICA = "71.77:54.92",
	THE_DEADMINES = "38.23:77.47",
	THE_ETERNAL_PALACE = "50.3:9.8", -- Needs updating
	THE_MECHANAR = "70.62:69.77",
	THE_NEXUS = "27.50:25.97",
	THE_OCULUS = "27.52:26.71",
	THE_SHATTERED_HALLS = "47.50:52.04",
	THE_SLAVE_PENS = "48.95:35.70",
	THE_STEAMVAULT = "50.29:33.32",
	THE_TEMPLE_OF_ATALHAKKAR = "76.03:45.23",
	THE_VIOLET_HOLD = "66.78:68.19",
	TRIAL_OF_THE_CRUSADER = "75.0:21.8",
	UTGARDE_KEEP = "57.28:46.73",
	UTGARDE_PINNACLE = "57.26:46.67"
}

-- ============================================================================
-- Location Object
-- Represents a zone/location with parent/child relationships
-- ============================================================================

local Location = {}
local LocationMetatable = {
	__index = Location,
}

-- Storage tables
local Locations = {}
private.Locations = Locations

local LocationsByLocalizedName = {}
private.LocationsByLocalizedName = LocationsByLocalizedName

local LocationsByMapID = {}
private.LocationsByMapID = LocationsByMapID

local ContinentLocationByID = {}
private.ContinentLocationByID = ContinentLocationByID

-- ============================================================================
-- Location Methods
-- ============================================================================

function Location:AssignRecipe(recipe, affiliation)
	self._recipes[recipe] = affiliation
end

function Location:ContinentID()
	return self._continentID
end

function Location:EntranceCoordinates()
	local coordinates = self._entranceCoordinates
	if coordinates then
		local x, y = (":"):split(coordinates)
		return tonumber(x), tonumber(y)
	end
	return 0, 0
end

function Location:GetRecipeAffiliation(recipe)
	return self._recipes[recipe]
end

function Location:GetSortedRecipes()
	return private.SortRecipePairs(self._recipes)
end

function Location:HasRecipe(recipe)
	return self._recipes[recipe]
end

function Location:Label()
	return self._label
end

function Location:LocalizedName()
	return self._localizedName
end

function Location:MapID()
	return self._mapID
end

--- Get a validated map ID, falling back to HBD lookup if stored ID is invalid
--- @return number|nil mapID A valid map ID or nil if not found
function Location:GetValidMapID()
	local mapID = self._mapID

	if mapID and mapID > 0 then
		local name = HBD:GetLocalizedMap(mapID)
		if name then
			return mapID
		end
	end

	if self._localizedName then
		local searchName = self._localizedName:lower()
		local allMapIDs = HBD:GetAllMapIDs()

		for _, id in ipairs(allMapIDs) do
			local mapName = HBD:GetLocalizedMap(id)
			if mapName and mapName:lower() == searchName then
				return id
			end
		end
	end

	local parent = self:Parent()
	if parent then
		return parent:GetValidMapID()
	end

	return nil
end

function Location:Name()
	return self._name
end

function Location:Parent()
	return self._parent
end

function Location:RecipePairs()
	return pairs(self._recipes)
end

-- ============================================================================
-- Location Instantiation
-- ============================================================================

--- Create a Location object from mapID
--- @param continentID number The sequential continent ID
--- @param mapID number The map ID
--- @param parentLocation table|nil Optional parent Location
--- @return table|nil location The created Location or nil
local function AddLocation(continentID, mapID, parentLocation)
	local zoneLabel = ZONE_LABELS_FROM_MAP_ID[mapID]
	if not zoneLabel then
		return nil
	end

	-- Generate TitleCase key for lookup: "SHADOWMOON_VALLEY_DRAENOR" -> "ShadowmoonValleyDraenor"
	local zoneName = zoneLabel:lower():gsub("^%l", string.upper):gsub("_%l", string.upper):gsub("_", "")
	local localizedName = ZONE_NAMES[zoneLabel]
	if not localizedName or localizedName == UNKNOWN then
		localizedName = PrettyNameFromLabel(zoneLabel)
		ZONE_NAMES[zoneLabel] = localizedName
	end

	local location = _G.setmetatable({
		_continentID = continentID,
		_entranceCoordinates = INSTANCE_ENTRANCE_COORDINATES[zoneLabel],
		_label = zoneLabel,
		_localizedName = localizedName,
		_mapID = mapID,
		_name = zoneName,
		_parent = parentLocation,
		_recipes = {},
	}, LocationMetatable)

	Locations[zoneName] = location
	LocationsByLocalizedName[localizedName] = location
	LocationsByMapID[mapID] = location

	if parentLocation then
		parentLocation._childLocations = parentLocation._childLocations or {}
		parentLocation._childLocations[zoneName] = location

		parentLocation._childLocationsByLocalizedName = parentLocation._childLocationsByLocalizedName or {}
		parentLocation._childLocationsByLocalizedName[localizedName] = location
	end

	return location
end

-- ============================================================================
-- Fallback Location Creation
-- Creates a minimal Location object when a zone name is referenced but not found
-- in the pre-built Locations tables. Uses HereBeDragons to resolve mapID.
-- ============================================================================

--- Convert a localized zone name to a Location key
--- "Stormwind City" -> "StormwindCity"
--- @param name string The localized zone name
--- @return string key The generated key
local function KeyFromLocalized(name)
	if not name or type(name) ~= "string" then
		return "Unknown"
	end
	local key = name:gsub("[^%w]+", " ")
	local buff = {}
	for word in key:gmatch("%S+") do
		buff[#buff + 1] = word:sub(1, 1):upper() .. word:sub(2):lower()
	end
	return table.concat(buff, "")
end

--- Ensure a Location exists for the given localized name
--- Called when recipe modules reference zones not in ZONE_MAP_IDS
--- Uses HereBeDragons database to resolve mapID for waypoint support
--- @param localizedName string The localized zone name
--- @return table location The existing or newly created Location
function private.EnsureLocationByLocalizedName(localizedName)
	if LocationsByLocalizedName[localizedName] then
		return LocationsByLocalizedName[localizedName]
	end

	local key = KeyFromLocalized(localizedName)

	-- Try to resolve mapID via HereBeDragons database
	local resolvedMapID
	local searchName = localizedName and localizedName:lower()
	if searchName then
		local allMapIDs = HBD:GetAllMapIDs()
		for _, mapID in ipairs(allMapIDs) do
			local mapName = HBD:GetLocalizedMap(mapID)
			if mapName and mapName:lower() == searchName then
				resolvedMapID = mapID
				break
			end
		end
	end

	local location = _G.setmetatable({
		_continentID = 0,
		_entranceCoordinates = nil,
		_label = nil,
		_localizedName = localizedName or UNKNOWN,
		_mapID = resolvedMapID or -1,
		_name = key,
		_parent = nil,
		_recipes = {},
	}, LocationMetatable)

	Locations[key] = location
	LocationsByLocalizedName[localizedName] = location
	return location
end

--- Recursively add child zones using HBD parent relationships
--- @param parentLocation table The parent Location to process
local function AddSubzoneLocations(parentLocation)
	if not parentLocation then
		return
	end
	local parentMapID = parentLocation._mapID
	if not parentMapID then
		return
	end
	local allMapIDs = HBD:GetAllMapIDs()
	local mapData = HBD.mapData
	for _, mapID in ipairs(allMapIDs) do
		local data = mapData[mapID]
		if data and data.parent == parentMapID then
			local zone = AddLocation(parentLocation._continentID, mapID, parentLocation)
			if zone then
				AddSubzoneLocations(zone)
			end
		end
	end
end

-- ============================================================================
-- Initialize Location Database
-- Build all Location objects from continent and cosmic map data
-- ============================================================================

-- Create continent locations and recursively add child zones
for dataIndex = 1, #mapContinentData do
	if dataIndex % 2 == 0 then
		local continentID = dataIndex / 2
		local continentMapID = mapContinentData[dataIndex - 1]
		local continent = AddLocation(continentID, continentMapID)

		if continent then
			ContinentLocationByID[continentID] = continent
			AddSubzoneLocations(continent)
		end
	end
end

-- Create cosmic map for zones without continent parent
local cosmicMap = AddLocation(946, 946)
if cosmicMap then
	ContinentLocationByID[946] = cosmicMap
end

-- Add cosmic zones with explicit parent mapping
for label, mapID in pairs(COSMIC_MAP_IDS) do
	local parentLocation = LocationsByLocalizedName[COSMIC_MAP_LOCATION_PARENT_MAPPING[label]] or cosmicMap
	local continentID = (parentLocation and parentLocation._continentID) or 946
	AddLocation(continentID, mapID, parentLocation)
end

-- Export ZONE_MAP_IDS for waypoint lookup
private.ZONE_MAP_IDS = ZONE_MAP_IDS
