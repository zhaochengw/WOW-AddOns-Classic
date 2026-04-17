--[[
    Ackis Recipe List - Constants
    Global constants, filters, and API compatibility wrappers
    
    Provides:
    - API compatibility wrappers (C_AddOns, C_CVar, C_Spell fallbacks)
    - Profession constants and localized names
    - Filter definitions and quality colors
    - Expansion and category mappings
    
    NOTE: This file must be loaded first as other files depend on
    the API compatibility wrappers defined here.
]]

-- ============================================================================
-- Upvalued Lua API
-- ============================================================================
local pairs = _G.pairs
local ipairs = _G.ipairs
local pcall = _G.pcall
local string = _G.string
local table = _G.table
local tostring = _G.tostring
local tonumber = _G.tonumber
local select = _G.select
local type = _G.type

-- ============================================================================
-- AddOn Namespace
-- ============================================================================
local FOLDER_NAME, private = ...
private.addon_name = "Ackis Recipe List"
private.addon_display_name = "Ackis Recipe List Classic"

-- ============================================================================
-- API COMPATIBILITY WRAPPERS
-- These provide forward-compatible APIs that work on all WoW clients.
-- Modern clients use C_* APIs, classic clients fall back to global functions.
-- ============================================================================

--- Get addon metadata (version, author, etc.)
--- @param addonName string The addon name
--- @param field string The metadata field to retrieve
--- @return string|nil The metadata value
function private.GetAddOnMetadata(addonName, field)
    if _G.C_AddOns and _G.C_AddOns.GetAddOnMetadata then
        return _G.C_AddOns.GetAddOnMetadata(addonName, field)
    end
    return _G.GetAddOnMetadata(addonName, field)
end

--- Get information about an addon
--- @param addonNameOrIndex string|number The addon name or index
--- @return string name, string title, string notes, boolean loadable, string reason, string security, number|nil newVersion
function private.GetAddOnInfo(addonNameOrIndex)
    if _G.C_AddOns and _G.C_AddOns.GetAddOnInfo then
        local name, title, notes, loadable, reason, security, newVersion = _G.C_AddOns.GetAddOnInfo(addonNameOrIndex)
        return name, title, notes, loadable, reason, security, newVersion
    end
    local name, title, notes, loadable, reason, security = _G.GetAddOnInfo(addonNameOrIndex)
    return name, title, notes, loadable, reason, security, nil
end

--- Load an addon by name or index
--- @param addonNameOrIndex string|number The addon name or index
--- @return boolean success
function private.LoadAddOn(addonNameOrIndex)
    if _G.C_AddOns and _G.C_AddOns.LoadAddOn then
        return _G.C_AddOns.LoadAddOn(addonNameOrIndex)
    end
    return _G.LoadAddOn(addonNameOrIndex)
end

--- Check if an addon is loaded
--- @param addonNameOrIndex string|number The addon name or index
--- @return boolean loaded
function private.IsAddOnLoaded(addonNameOrIndex)
    if _G.C_AddOns and _G.C_AddOns.IsAddOnLoaded then
        return _G.C_AddOns.IsAddOnLoaded(addonNameOrIndex)
    end
    return _G.IsAddOnLoaded(addonNameOrIndex)
end

--- Get a console variable value
--- @param name string The CVar name
--- @return string|nil value
function private.GetCVar(name)
    if _G.C_CVar and _G.C_CVar.GetCVar then
        return _G.C_CVar.GetCVar(name)
    end
    return _G.GetCVar(name)
end

--- Set a console variable value
--- @param name string The CVar name
--- @param value string|number|boolean The value to set
--- @return boolean success
function private.SetCVar(name, value)
    if _G.C_CVar and _G.C_CVar.SetCVar then
        local ok = pcall(_G.C_CVar.SetCVar, name, tostring(value))
        return ok
    end
    local ok = pcall(_G.SetCVar, name, tostring(value))
    return ok
end

--- Check if the player is in combat lockdown
--- @return boolean inCombat
function private.InCombatLockdown()
    return _G.InCombatLockdown and _G.InCombatLockdown() or false
end

--- Get the game client build information
--- @return string version, string build, string date, number uiVersion
function private.GetBuildInfo()
    local version, build, date, uiVersion = _G.GetBuildInfo()
    return version or "0.0.0", build or "0", date or "", uiVersion or 0
end

--- Get spell information (works with C_Spell or legacy API)
--- @param spellId number The spell ID
--- @return string|nil name, string|nil rank, number|nil icon, number|nil castTime, number|nil minRange, number|nil maxRange, number|nil spellId
function private.GetSpellInfo(spellId)
    if _G.C_Spell and _G.C_Spell.GetSpellInfo then
        local info = _G.C_Spell.GetSpellInfo(spellId)
        if info then
            return info.name, nil, info.iconID, info.castTime, info.minRange, info.maxRange, info.spellID
        end
    end
    return _G.GetSpellInfo(spellId)
end

--- Get the name of a spell by ID
--- @param spellId number The spell ID
--- @return string|nil name
function private.GetSpellName(spellId)
    if _G.C_Spell and _G.C_Spell.GetSpellName then
        return _G.C_Spell.GetSpellName(spellId)
    end
    local name = _G.GetSpellInfo(spellId)
    return name
end

local LibStub = _G.LibStub

-- Required so constants can be assigned to the AddOn object in Core.lua in order to be accessible from profession modules
local constants = {}
private.constants = constants

-- Simple debug function (disabled by default)
function private.Debug(...)
	-- Debug disabled - no output for end users
	return
end




-- ----------------------------------------------------------------------------
-- General constants.
-- ----------------------------------------------------------------------------
private.PLAYER_NAME = _G.UnitName("player")
private.REALM_NAME = _G.GetRealmName()

private.COORDINATES_FORMAT = "(%.2f, %.2f)"

-- Fallbacks for clients missing some UI globals (Classic Era analysis environment)
local BATTLE_PET_SOURCE_3 = rawget(_G, "BATTLE_PET_SOURCE_3") or "Vendor"
local PARENS_TEMPLATE = rawget(_G, "PARENS_TEMPLATE") or "(%s)"
private.VENDOR_TYPE_FORMAT = BATTLE_PET_SOURCE_3 .. " " .. PARENS_TEMPLATE

-- ----------------------------------------------------------------------------
-- Item qualities.
-- ----------------------------------------------------------------------------
private.ITEM_QUALITY_NAMES = {
	"COMMON",
	"UNCOMMON",
	"RARE",
	"EPIC",
	"LEGENDARY",
	"ARTIFACT",
}

private.ITEM_QUALITIES = {}
constants.ITEM_QUALITIES = private.ITEM_QUALITIES

for index = 1, #private.ITEM_QUALITY_NAMES do
	private.ITEM_QUALITIES[private.ITEM_QUALITY_NAMES[index]] = index
end

-- ----------------------------------------------------------------------------
-- Game/expansion versions.
-- ----------------------------------------------------------------------------
private.GAME_VERSION_NAMES = {
	"ORIG",
	"TBC",
	"WOTLK",
	"CATA",
	"MOP",
	"WOD",
	"LEGION",
	"BFA",
	"SHA",
}

constants.GAME_VERSION_NAMES = private.GAME_VERSION_NAMES

private.GAME_VERSIONS = {}
constants.GAME_VERSIONS = private.GAME_VERSIONS

for index = 1, #private.GAME_VERSION_NAMES do
	private.GAME_VERSIONS[private.GAME_VERSION_NAMES[index]] = index
end

private.EXPANSION_FILTERS = {}

for index = 1, #private.GAME_VERSION_NAMES do
	private.EXPANSION_FILTERS[index] = ("expansion%d"):format(index - 1)
end

-- Define expansion constants locally if missing (for static analysis friendliness)
local LE_EXPANSION_CLASSIC = rawget(_G, "LE_EXPANSION_CLASSIC") or 0
local LE_EXPANSION_BURNING_CRUSADE = rawget(_G, "LE_EXPANSION_BURNING_CRUSADE") or 1
local LE_EXPANSION_WRATH_OF_THE_LICH_KING = rawget(_G, "LE_EXPANSION_WRATH_OF_THE_LICH_KING") or 2
local LE_EXPANSION_CATACLYSM = rawget(_G, "LE_EXPANSION_CATACLYSM") or 3
local LE_EXPANSION_MISTS_OF_PANDARIA = rawget(_G, "LE_EXPANSION_MISTS_OF_PANDARIA") or 4
local LE_EXPANSION_WARLORDS_OF_DRAENOR = rawget(_G, "LE_EXPANSION_WARLORDS_OF_DRAENOR") or 5
local LE_EXPANSION_LEGION = rawget(_G, "LE_EXPANSION_LEGION") or 6
local LE_EXPANSION_BATTLE_FOR_AZEROTH = rawget(_G, "LE_EXPANSION_BATTLE_FOR_AZEROTH") or 7
local LE_EXPANSION_SHADOWLANDS = rawget(_G, "LE_EXPANSION_SHADOWLANDS") or 8

private.EXPANSION_LOGOS = {
	[LE_EXPANSION_CLASSIC] = { texture = [[Interface\Glues\Common\Glues-WoW-ClassicLogo]] },
	[LE_EXPANSION_BURNING_CRUSADE] = { texture = [[Interface\Glues\Common\Glues-WoW-BCLogo]] },
	[LE_EXPANSION_WRATH_OF_THE_LICH_KING] = { texture = [[Interface\Glues\Common\Glues-WoW-WotLKLogo]] },
	[LE_EXPANSION_CATACLYSM] = { texture = [[Interface\Glues\Common\Glues-WoW-CCLogo]] },
	[LE_EXPANSION_MISTS_OF_PANDARIA] = { texture = [[Interface\Glues\Common\Glues-WoW-MPLogo]] },
	[LE_EXPANSION_WARLORDS_OF_DRAENOR] = { texture = [[Interface\Glues\Common\GLUES-WOW-WODLOGO]] },
	[LE_EXPANSION_LEGION] = { atlas = "Glues-WoW-LegionLogo" },
	[LE_EXPANSION_BATTLE_FOR_AZEROTH] = { texture = [[Interface\Glues\Common\Glues-WoW-BattleforAzerothLogo]] },
	[LE_EXPANSION_SHADOWLANDS] = { texture = [[Interface\Glues\Common\Glues-WoW-ShadowlandsLogo]] },
}

-- ----------------------------------------------------------------------------
-- Common filter bitfield word 1.
-- ----------------------------------------------------------------------------
private.COMMON_FLAGS_WORD1 = {
	ALLIANCE		= 0x00000001,	-- 1
	ACHIEVEMENT		= 0x00000002,	-- 2
	CASTER			= 0x00000004,	-- 3
	DISC			= 0x00000008,	-- 4
	DPS				= 0x00000010,	-- 5
	HEALER			= 0x00000020,	-- 6
	HORDE			= 0x00000040,	-- 7
	INSTANCE		= 0x00000080,	-- 8
	CUSTOM			= 0x00000100,	-- 9
	MOB_DROP		= 0x00000200,	-- 10
	PVP				= 0x00000400,	-- 11
	QUEST			= 0x00000800,	-- 12
	RAID			= 0x00001000,	-- 13
	REPUTATION		= 0x00002000,	-- 14
	RETIRED			= 0x00004000,	-- 15
	TANK			= 0x00008000,	-- 16
	TRAINER			= 0x00010000,	-- 17
	VENDOR			= 0x00020000,	-- 18
	WORLD_DROP		= 0x00040000,	-- 19
	WORLD_EVENT		= 0x00080000,	-- 20
	TRADE_SKILL		= 0x00100000,	-- 21
	MIXED 			= 0x00200000,	-- 22
}

-- ----------------------------------------------------------------------------
-- Class filter bitfield word 1.
-- ----------------------------------------------------------------------------
private.CLASS_FLAGS_WORD1 = {
	DK				= 0x00000001,	-- 1
	DRUID			= 0x00000002,	-- 2
	HUNTER			= 0x00000004,	-- 3
	MAGE			= 0x00000008,	-- 4
	PALADIN			= 0x00000010,	-- 5
	PRIEST			= 0x00000020,	-- 6
	SHAMAN			= 0x00000040,	-- 7
	ROGUE			= 0x00000080,	-- 8
	WARLOCK			= 0x00000100,	-- 9
	WARRIOR			= 0x00000200,	-- 10
	MONK			= 0x00000400,	-- 11
	DEMONHUNTER		= 0x00000800,	-- 12
}

private.FLAG_WORDS = {
	private.COMMON_FLAGS_WORD1,
	private.CLASS_FLAGS_WORD1,
}

-- Member names within a recipe's flags table.
private.FLAG_MEMBERS = {
	"common1",
	"class1",
}

-- ----------------------------------------------------------------------------
-- Item filter types.
-- ----------------------------------------------------------------------------
constants.ITEM_FILTER_TYPES = {} -- Populated via profession modules.

-- ----------------------------------------------------------------------------
-- Reputation levels.
-- ----------------------------------------------------------------------------
private.REP_LEVEL_STRINGS = {
	[1]	= "FRIENDLY",
	[2]	= "HONORED",
	[3]	= "REVERED",
	[4]	= "EXALTED",
}

private.REP_LEVELS = {}
constants.REP_LEVELS = private.REP_LEVELS

for index = 1, #private.REP_LEVEL_STRINGS do
	private.REP_LEVELS[private.REP_LEVEL_STRINGS[index]] = index
end

-- ----------------------------------------------------------------------------
-- Factions.
-- ----------------------------------------------------------------------------
private.FACTION_LABELS_FROM_ID = {
	-- ----------------------------------------------------------------------------
	-- Classic
	-- ----------------------------------------------------------------------------
	[59]	= "THORIUM_BROTHERHOOD",
	[529]	= "ARGENT_DAWN",
	[576]	= "TIMBERMAW_HOLD",
	[609]	= "CENARION_CIRCLE",
	-- ----------------------------------------------------------------------------
	-- The Burning Crusade
	-- ----------------------------------------------------------------------------
	[932]	= "THE_ALDOR",
	[933]	= "THE_CONSORTIUM",
	[934]	= "THE_SCRYERS",
	[935]	= "THE_SHATAR",
	[941]	= "THE_MAGHAR",
	[942]	= "CENARION_EXPEDITION",
	[946]	= "HONOR_HOLD",
	[947]	= "THRALLMAR",
	[967]	= "THE_VIOLET_EYE",
	[970]	= "SPOREGGAR",
	[978]	= "KURENAI",
	[989]	= "KEEPERS_OF_TIME",
	[990]	= "THE_SCALE_OF_THE_SANDS",
	[1011]	= "LOWER_CITY",
	[1012]	= "ASHTONGUE_DEATHSWORN",
	[1077]	= "SHATTERED_SUN_OFFENSIVE",
	-- ----------------------------------------------------------------------------
	-- Wrath of the Lich King
	-- ----------------------------------------------------------------------------
	[1037]	= "ALLIANCE_VANGUARD",
	[1052]	= "HORDE_EXPEDITION",
	[1073]	= "THE_KALUAK",
	[1090]	= "KIRIN_TOR",
	[1091]	= "THE_WYRMREST_ACCORD",
	[1098]	= "KNIGHTS_OF_THE_EBON_BLADE",
	[1104]	= "FRENZYHEART_TRIBE",
	[1105]	= "THE_ORACLES",
	[1106]	= "ARGENT_CRUSADE",
	[1119]	= "THE_SONS_OF_HODIR",
	[1156]	= "THE_ASHEN_VERDICT",
	-- ----------------------------------------------------------------------------
	-- Mists of Pandaria
	-- ----------------------------------------------------------------------------
	[1269]	= "GOLDEN_LOTUS",
	[1270]	= "SHADO_PAN",
	[1271]	= "ORDER_OF_THE_CLOUD_SERPENT",
	[1272]	= "THE_TILLERS",
	[1302]	= "THE_ANGLERS",
	[1337]	= "THE_KLAXXI",
	[1341]	= "THE_AUGUST_CELESTIALS",
	-- ----------------------------------------------------------------------------
	-- Warlords of Draenor
	-- ----------------------------------------------------------------------------

	-- ----------------------------------------------------------------------------
	-- Legion
	-- ----------------------------------------------------------------------------
	[1828]	= "HIGHMOUNTAIN_TRIBE",
	[1859]	= "THE_NIGHTFALLEN",
	[1883]	= "DREAMWEAVERS",
	[1894]	= "THE_WARDENS",
	[1900]	= "COURT_OF_FARONDIS",
	[1948]	= "VALARJAR",
	[2165]	= "ARMY_OF_THE_LIGHT",
	[2170]	= "ARGUSSIAN_REACH",

	-- ----------------------------------------------------------------------------
	-- Battle for Azeroth
	-- ----------------------------------------------------------------------------
	[2103]  = "ZANDALARI_EMPIRE",
	[2156]  = "TALANJIS_EXPEDITION",
	[2157]	= "THE_HONORBOUND",
	[2158]  = "VOLDUNAI",
	[2159]	= "SEVENTH_LEGION",
	[2160]  = "PROUDMOORE_ADMIRALTY",
	[2161]  = "ORDER_OF_EMBERS",
	[2162]  = "STORMS_WAKE",
	[2163]  = "TORTOLLAN_SEEKERS",
	[2164]	= "CHAMPIONS_OF_AZEROTH",
	[2373]  = "THE_UNSHACKLED",
	[2391]  = "RUSTBOLT_RESISTANCE",
	[2400]  = "ANKOAN",
	[2415]	= "RAJANI",
	[2417]	= "ULDUM_ACCORD",

	-- ----------------------------------------------------------------------------
	-- Shadowlands
	-- ----------------------------------------------------------------------------
	[2407]  = "THE_ASCENDED",
	[2410]	= "THE_UNDYING_ARMY",
	[2413]	= "COURT_OF_HARVESTERS",
	[2432]	= "THE_VENARI",
	[2439]	= "THE_AVOWED",
	[2464]  = "COURT_OF_NIGHT",
	[2465]	= "THE_WILD_HUNT",
	[2470]  = "DEATHS_ADVANCE",
	[2472]  = "THE_ARCHIVISTS_CODEX",
	[2478]  = "THE_ENLIGHTENED",

}

-- The expansionX_reputations tables are ordered alphabetically (ignoring leading "THE"). These are used for
-- populating the reputation menus and their toggles.
private.EXPANSION0_REPUTATIONS = {
	"ARGENT_DAWN",
	"CENARION_CIRCLE",
	"THORIUM_BROTHERHOOD",
	"TIMBERMAW_HOLD",
}

private.EXPANSION1_REPUTATIONS = {
	"THE_ALDOR",
	"ASHTONGUE_DEATHSWORN",
	"CENARION_EXPEDITION",
	"THE_CONSORTIUM",
	"HONOR_HOLD",
	"KEEPERS_OF_TIME",
	"KURENAI",
	"LOWER_CITY",
	"THE_MAGHAR",
	"THE_SCALE_OF_THE_SANDS",
	"THE_SCRYERS",
	"THE_SHATAR",
	"SHATTERED_SUN_OFFENSIVE",
	"SPOREGGAR",
	"THRALLMAR",
	"THE_VIOLET_EYE",
}

private.EXPANSION2_REPUTATIONS = {
	"ALLIANCE_VANGUARD",
	"ARGENT_CRUSADE",
	"THE_ASHEN_VERDICT",
	"FRENZYHEART_TRIBE",
	"HORDE_EXPEDITION",
	"THE_KALUAK",
	"KIRIN_TOR",
	"KNIGHTS_OF_THE_EBON_BLADE",
	"THE_ORACLES",
	"THE_SONS_OF_HODIR",
	"THE_WYRMREST_ACCORD",
}

private.EXPANSION3_REPUTATIONS = {}

private.EXPANSION4_REPUTATIONS = {
	"THE_ANGLERS",
	"THE_AUGUST_CELESTIALS",
	"GOLDEN_LOTUS",
	"THE_KLAXXI",
	"ORDER_OF_THE_CLOUD_SERPENT",
	"SHADO_PAN",
	"THE_TILLERS",
}

private.EXPANSION5_REPUTATIONS = {}

private.EXPANSION6_REPUTATIONS = {
	"HIGHMOUNTAIN_TRIBE",
	"THE_NIGHTFALLEN",
	"DREAMWEAVERS",
	"THE_WARDENS",
	"COURT_OF_FARONDIS",
	"VALARJAR",
	"ARMY_OF_THE_LIGHT",
	"ARGUSSIAN_REACH",
}

private.EXPANSION7_REPUTATIONS = {
	"ZANDALARI_EMPIRE",
	"TALANJIS_EXPEDITION",
	"THE_HONORBOUND",
	"VOLDUNAI",
	"SEVENTH_LEGION",
	"PROUDMOORE_ADMIRALTY",
	"ORDER_OF_EMBERS",
	"STORMS_WAKE",
	"TORTOLLAN_SEEKERS",
	"CHAMPIONS_OF_AZEROTH",
	"THE_UNSHACKLED",
	"RUSTBOLT_RESISTANCE",
	"ANKOAN",
	"RAJANI",
	"ULDUM_ACCORD",
}

private.EXPANSION8_REPUTATIONS = {
	"THE_ARCHIVISTS_CODEX",
	"THE_ASCENDED",
	"THE_AVOWED",
	"COURT_OF_HARVESTERS",
	"COURT_OF_NIGHT",
	"DEATHS_ADVANCE",
	"THE_ENLIGHTENED",
	"THE_UNDYING_ARMY",
	"THE_VENARI",
	"THE_WILD_HUNT",
}


local FACTION_STANDING_LABEL4 = rawget(_G, "FACTION_STANDING_LABEL4") or "Neutral"
local FACTION_STANDING_LABEL5 = rawget(_G, "FACTION_STANDING_LABEL5") or "Friendly"
local FACTION_STANDING_LABEL6 = rawget(_G, "FACTION_STANDING_LABEL6") or "Honored"
local FACTION_STANDING_LABEL7 = rawget(_G, "FACTION_STANDING_LABEL7") or "Revered"
local FACTION_STANDING_LABEL8 = rawget(_G, "FACTION_STANDING_LABEL8") or "Exalted"
local function SafeGetFactionInfoByID(id)
	local fn = rawget(_G, "GetFactionInfoByID")
	if type(fn) == "function" then
		local ok, name = pcall(fn, id)
		if ok and name then return name end
	end
end
private.LOCALIZED_FACTION_STRINGS_FROM_LABEL = {
	NEUTRAL	= FACTION_STANDING_LABEL4,
	FRIENDLY = FACTION_STANDING_LABEL5,
	HONORED	= FACTION_STANDING_LABEL6,
	REVERED	= FACTION_STANDING_LABEL7,
	EXALTED	= FACTION_STANDING_LABEL8,
	HORDE = SafeGetFactionInfoByID(67),
	ALLIANCE = SafeGetFactionInfoByID(469),
}

private.FACTION_IDS_FROM_LABEL = {}
constants.FACTION_IDS = private.FACTION_IDS_FROM_LABEL

for id, label in pairs(private.FACTION_LABELS_FROM_ID) do
	private.FACTION_IDS_FROM_LABEL[label] = id
	local fname = SafeGetFactionInfoByID(id)
	private.LOCALIZED_FACTION_STRINGS_FROM_LABEL[label] = fname or ("Unknown_%d"):format(id)
end

-- Fallbacks for clients where some legacy factions may not be returned by GetFactionInfoByID
-- Keeps UI clean instead of showing "Unknown_<id>" (e.g., Unknown_941)
do
	private.FALLBACK_FACTION_NAMES = private.FALLBACK_FACTION_NAMES or {
		[941] = "The Mag'har",
		[978] = "Kurenai",
	}

	-- Replace any "Unknown_<id>" entries we just populated with human-friendly fallbacks
	for id, label in pairs(private.FACTION_LABELS_FROM_ID) do
		local current = private.LOCALIZED_FACTION_STRINGS_FROM_LABEL[label]
		local fallback = private.FALLBACK_FACTION_NAMES[id]
		-- Detect placeholder values like "Unknown_<id>" regardless of locale by suffix match
		if fallback and type(current) == "string" and current:match("_" .. id .. "$") then
			private.LOCALIZED_FACTION_STRINGS_FROM_LABEL[label] = fallback
		end
	end

	-- Provide alias access for MAGHAR to support older references in code
	if private.FACTION_IDS_FROM_LABEL["THE_MAGHAR"] then
		private.FACTION_IDS_FROM_LABEL.MAGHAR = private.FACTION_IDS_FROM_LABEL["THE_MAGHAR"]
		private.LOCALIZED_FACTION_STRINGS_FROM_LABEL.MAGHAR = private.LOCALIZED_FACTION_STRINGS_FROM_LABEL["THE_MAGHAR"]
	end
end

-- This is far from elegant, and could be done using math instead of the BITS table. I was, however,
-- simply wanting to Make It Work(™) and this is what we have for the moment.
do
	local BITS = {
		0x00000001,	-- 1
		0x00000002,	-- 2
		0x00000004,	-- 3
		0x00000008,	-- 4
		0x00000010,	-- 5
		0x00000020,	-- 6
		0x00000040,	-- 7
		0x00000080,	-- 8
		0x00000100,	-- 9
		0x00000200,	-- 10
		0x00000400,	-- 11
		0x00000800,	-- 12
		0x00001000,	-- 13
		0x00002000,	-- 14
		0x00004000,	-- 15
		0x00008000,	-- 16
		0x00010000,	-- 17
		0x00020000,	-- 18
		0x00040000,	-- 19
		0x00080000,	-- 20
		0x00100000,	-- 21
		0x00200000,	-- 22
		0x00400000,	-- 23
		0x00800000,	-- 24
		0x01000000,	-- 25
		0x02000000,	-- 26
		0x04000000,	-- 27
		0x08000000,	-- 28
		0x10000000,	-- 29
		0x20000000,	-- 30
		0x40000000,	-- 31
		0x80000000,	-- 32
	}

	local flags = {
		{}, -- First word added preemptively.
	}

	local flag_word = 1
	local flag_index = 1

	for name in pairs(private.FACTION_IDS_FROM_LABEL) do
		flags[flag_word][name] = BITS[flag_index]

		flag_index = flag_index + 1
		if flag_index > #BITS then
			flags[#flags + 1] = {}
			flag_word = flag_word + 1
			flag_index = 1
		end
	end

	for index = 1, #flags do
		private.FLAG_WORDS[#private.FLAG_WORDS + 1] = flags[index]
		private.FLAG_MEMBERS[#private.FLAG_MEMBERS + 1] = ("reputation%d"):format(index)
	end

	private.REP_FLAGS = flags
end

-- ----------------------------------------------------------------------------
-- This has to be done here, after every other flag definition.
-- ----------------------------------------------------------------------------
private.FILTER_STRINGS = {}
for index = 1, #private.FLAG_WORDS do
	for flag_name in pairs(private.FLAG_WORDS[index]) do
		private.FILTER_STRINGS[#private.FILTER_STRINGS + 1] = flag_name
	end
end

private.FILTER_IDS = {}
constants.FILTER_IDS = private.FILTER_IDS

for index = 1, #private.FILTER_STRINGS do
	private.FILTER_IDS[private.FILTER_STRINGS[index]] = index
end

-- ----------------------------------------------------------------------------
-- Boss names.
-- ----------------------------------------------------------------------------
-- Classic Era clients may not have the Encounter Journal APIs. Provide a safe fallback.
-- Curated fallback names for Encounter IDs commonly referenced by the database, used on clients without EJ.
local FALLBACK_ENCOUNTER_NAMES = {
	-- Classic dungeons/raids
	[198] = "Ragnaros",
	[370] = "Lord Roccor",
	[373] = "Pyromancer Loregrain",
	[379] = "Golem Lord Argelmach",
	[382] = "Ribbly Screwspigot",
	[383] = "Plugger Spazzring",
	[393] = "Quartermaster Zigris",
	[396] = "Overlord Wyrmthalak",
	[398] = "Solakar Flamewreath",
	[401] = "General Drakkisath",
	[408] = "Magister Kalendris",
	[422] = "Mekgineer Thermaplugg",
	[446] = "Willey Hopebreaker",
	[449] = "Balnazzar",
	[453] = "Maleki the Pallid",
	-- Wrath/Cata/MoP classics remastered (appear in some data; harmless on Era)
	[663] = "Jandice Barov",
	[684] = "Darkmaster Gandling",
	-- Outland/Northrend basics used by some recipes; safe fallbacks
	[537] = "Nexus-Prince Shaffar",
	[539] = "Captain Skarloc",
	[540] = "Epoch Hunter",
	[541] = "Darkweaver Syth",
	[545] = "Blackheart the Inciter",
	[547] = "Murmur",
	[549] = "Dalliah the Doomsayer",
	[556] = "Broggok",
	[559] = "High Botanist Freywinn",
	[560] = "Thorngrin the Tender",
	[562] = "Warp Splinter",
	[563] = "Mechano-Lord Capacitus",
	[564] = "Nethermancer Sepethrea",
	[565] = "Pathaleon the Calculator",
	-- AQ40 core encounters
	[1522] = "Garr",            -- Actually MC, included for coverage
	[1539] = "Moam",
	[1543] = "The Prophet Skeram",
	[1549] = "The Twin Emperors",
}

local function SafeEJEncounterInfo(id)
	local ej = _G.EJ_GetEncounterInfo
	if type(ej) == "function" then
		local ok, name = pcall(ej, id)
		if ok and name then
			return name
		end
	end
	-- Fallback to curated names on clients without EJ
	local fallback = FALLBACK_ENCOUNTER_NAMES[id]
	if fallback then
		return fallback
	end
	-- Final placeholder keeps UI stable on clients without EJ and unknown IDs
	return ("Encounter %d"):format(id)
end

private.BOSS_NAMES = {
	RAGNAROS = SafeEJEncounterInfo(198),
	LORD_ROCCOR = SafeEJEncounterInfo(370),
	PYROMANCER_LOREGRAIN = SafeEJEncounterInfo(373),
	GOLEM_LORD_ARGELMACH = SafeEJEncounterInfo(379),
	RIBBLY_SCREWSPIGOT = SafeEJEncounterInfo(382),
	PLUGGER_SPAZZRING = SafeEJEncounterInfo(383),
	QUARTERMASTER_ZIGRIS = SafeEJEncounterInfo(393),
	OVERLORD_WYRMTHALAK = SafeEJEncounterInfo(396),
	SOLAKAR_FLAMEWREATH = SafeEJEncounterInfo(398),
	GENERAL_DRAKKISATH = SafeEJEncounterInfo(401),
	MAGISTER_KALENDRIS = SafeEJEncounterInfo(408),
	MEKGINEER_THERMAPLUGG = SafeEJEncounterInfo(422),
	WILLEY_HOPEBREAKER = SafeEJEncounterInfo(446),
	BALNAZZAR = SafeEJEncounterInfo(449),
	MALEKI_THE_PALLID = SafeEJEncounterInfo(453),
	PRIESTESS_DELRISSA = SafeEJEncounterInfo(532),
	KAELTHAS_SUNSTRIDER = SafeEJEncounterInfo(533),
	NEXUS_PRINCE_SHAFFAR = SafeEJEncounterInfo(537),
	CAPTAIN_SKARLOC = SafeEJEncounterInfo(539),
	EPOCH_HUNTER = SafeEJEncounterInfo(540),
	DARKWEAVER_SYTH = SafeEJEncounterInfo(541),
	BLACKHEART_THE_INCITER = SafeEJEncounterInfo(545),
	MURMUR = SafeEJEncounterInfo(547),
	DALLIAH_THE_DOOMSAYER = SafeEJEncounterInfo(549),
	BROGGOK = SafeEJEncounterInfo(556),
	HIGH_BOTANIST_FREYWINN = SafeEJEncounterInfo(559),
	THORNGRIN_THE_TENDER = SafeEJEncounterInfo(560),
	WARP_SPLINTER = SafeEJEncounterInfo(562),
	MECHANO_LORD_CAPACITUS = SafeEJEncounterInfo(563),
	NETHERMANCER_SEPETHREA = SafeEJEncounterInfo(564),
	PATHALEON_THE_CALCULATOR = SafeEJEncounterInfo(565),
	GRAND_WARLOCK_NETHEKURSE = SafeEJEncounterInfo(566),
	MEKGINEER_STEAMRIGGER = SafeEJEncounterInfo(574),
	WARLORD_KALITHRESH = SafeEJEncounterInfo(575),
	HERALD_VOLAZJ = SafeEJEncounterInfo(584),
	LOKEN = SafeEJEncounterInfo(600),
	LEY_GUARDIAN_EREGOS = SafeEJEncounterInfo(625),
	INGVAR_THE_PLUNDERER = SafeEJEncounterInfo(640),
	KING_YMIRON = SafeEJEncounterInfo(644),
	JANDICE_BAROV = SafeEJEncounterInfo(663),
	DARKMASTER_GANDLING = SafeEJEncounterInfo(684),
	HIGH_SAGE_VIRYX = SafeEJEncounterInfo(968),
	RUKHMAR = SafeEJEncounterInfo(1262),
	SHADOW_LORD_ISKAR = SafeEJEncounterInfo(1433),
	CORDANA_FELSONG = SafeEJEncounterInfo(1470),
	ODYN = SafeEJEncounterInfo(1489),
	WRATH_OF_AZSHARA = SafeEJEncounterInfo(1492),
	ADVISOR_VANDROS = SafeEJEncounterInfo(1501),
	GARR = SafeEJEncounterInfo(1522),
	MOAM = SafeEJEncounterInfo(1539),
	THE_PROPHET_SKERAM = SafeEJEncounterInfo(1543),
	THE_TWIN_EMPERORS = SafeEJEncounterInfo(1549),
	ATTUMEN_THE_HUNTSMAN = SafeEJEncounterInfo(1553),
	MOROES = SafeEJEncounterInfo(1554),
	SHADE_OF_ARAN = SafeEJEncounterInfo(1559),
	TERESTIAN_ILLHOOF = SafeEJEncounterInfo(1560),
	OPERA_HALL = SafeEJEncounterInfo(1556),
	SHADE_OF_XAVIUS = SafeEJEncounterInfo(1657),
	HELYA = SafeEJEncounterInfo(1663),
	URSOC = SafeEJEncounterInfo(1667),
	LORD_KURTALOS_RAVENCREST = SafeEJEncounterInfo(1672),
	DARGRUL_THE_UNDERKING = SafeEJEncounterInfo(1687),
	SAELORN = SafeEJEncounterInfo(1697),
	NYTHENDRA = SafeEJEncounterInfo(1703),
	DRAGONS_OF_NIGHTMARE = SafeEJEncounterInfo(1704),
	SKORPYRON = SafeEJEncounterInfo(1706),
	KROSUS = SafeEJEncounterInfo(1713),
	ADVISOR_MELANDRUS = SafeEJEncounterInfo(1720),
	CHRONOMATIC_ANOMALY = SafeEJEncounterInfo(1725),
	XAVIUS = SafeEJEncounterInfo(1726),
	TRILLIAX = SafeEJEncounterInfo(1731),
	STAR_AUGUR_ETRAEUS = SafeEJEncounterInfo(1732),
	GULDAN = SafeEJEncounterInfo(1737),
	ILGYNOTH__HEART_OF_CORRUPTION = SafeEJEncounterInfo(1738),
	GRAND_MAGISTRIX_ELISANDE = SafeEJEncounterInfo(1743),
	ELERETHE_RENFERAL = SafeEJEncounterInfo(1744),
	NITHOGG = SafeEJEncounterInfo(1749),
	CENARIUS = SafeEJEncounterInfo(1750),
	SPELLBLADE_ALURIEL = SafeEJEncounterInfo(1751),
	HIGH_BOTANIST_TELARN = SafeEJEncounterInfo(1761),
	TICHONDRIUS = SafeEJEncounterInfo(1762),
	LEVANTUS = SafeEJEncounterInfo(1769),
	CALAMIR = SafeEJEncounterInfo(1774),
	NAZAK_THE_FIEND = SafeEJEncounterInfo(1783),
	DRUGON_THE_FROSTBLOOD = SafeEJEncounterInfo(1789),
	ANA_MOUZ = SafeEJEncounterInfo(1790),
	GUARM = SafeEJEncounterInfo(1830),
	KILJAEDEN = SafeEJEncounterInfo(1898),
	PORTAL_KEEPER_HASABEL = SafeEJEncounterInfo(1985),
	FELHOUNDS_OF_SARGERAS = SafeEJEncounterInfo(1987),
	GAROTHI_WORLDBREAKER = SafeEJEncounterInfo(1992),
	ANTORAN_HIGH_COMMAND = SafeEJEncounterInfo(1997),
	RAAL_THE_GLUTTONOUS = SafeEJEncounterInfo(2127),
	MOTHER = SafeEJEncounterInfo(2167),
	ZUL_REBORN = SafeEJEncounterInfo(2195),
	DOOMS_HOWL = SafeEJEncounterInfo(2213),
	HIGH_TINKER_MEKKATORQUE = SafeEJEncounterInfo(2334),
	KING_RASTAKHAN = SafeEJEncounterInfo(2335),
	KUJ0 = SafeEJEncounterInfo(2339),
	LADY_JAINA_PROUDMOORE = SafeEJEncounterInfo(2343),
	NZOTH_THE_CORRUPTOR = SafeEJEncounterInfo(2375),
}

constants.BOSS_NAMES = private.BOSS_NAMES

-- ----------------------------------------------------------------------------
-- Colors.
-- ----------------------------------------------------------------------------
local function CreateColorTable(dict)
	local r, g, b = dict.r, dict.g, dict.b
	return { hex = ("%02x%02x%02x"):format(r * 255, g * 255, b * 255), r = r, g = g, b = b }
end

local FACTION_BAR_COLORS = rawget(_G, "FACTION_BAR_COLORS") or {
	[1] = { r = 0.8, g = 0.1, b = 0.1 },
	[2] = { r = 1.0, g = 0.0, b = 0.0 },
	[3] = { r = 1.0, g = 0.5, b = 0.0 },
	[4] = { r = 1.0, g = 1.0, b = 0.0 },
	[5] = { r = 0.0, g = 1.0, b = 0.0 },
	[6] = { r = 0.0, g = 0.6, b = 0.1 },
	[7] = { r = 0.0, g = 0.4, b = 0.8 },
	[8] = { r = 0.6, g = 0.2, b = 1.0 },
}
private.REPUTATION_COLORS = {
	exalted		= CreateColorTable(FACTION_BAR_COLORS[8]),
	revered		= CreateColorTable(FACTION_BAR_COLORS[7]),
	honored		= CreateColorTable(FACTION_BAR_COLORS[6]),
	friendly	= CreateColorTable(FACTION_BAR_COLORS[5]),
	neutral		= CreateColorTable(FACTION_BAR_COLORS[4]),
	unfriendly	= CreateColorTable(FACTION_BAR_COLORS[3]),
	hostile		= CreateColorTable(FACTION_BAR_COLORS[2]),
	hated		= CreateColorTable(FACTION_BAR_COLORS[1]),
}

-- Recipe difficulty colors.
private.DIFFICULTY_COLORS = {
	trivial		= { hex = "808080",	r = 0.50,	g = 0.50,	b = 0.50 },
	easy		= { hex = "40bf40",	r = 0.25,	g = 0.75,	b = 0.25 },
	medium		= { hex = "ffff00",	r = 1,		g = 1,		b = 0 },
	optimal		= { hex = "ff8040",	r = 1,		g = 0.50,	b = 0.25 },
	impossible	= { hex = "ff0000",	r = 1,		g = 0,		b = 0 },
}

private.BASIC_COLORS = {
	grey	= { hex = "666666",	r = 0.40,	g = 0.40,	b = 0.40 },
	white	= { hex = "ffffff",	r = 1,		g = 1,		b = 1 },
	yellow	= { hex = "ffff00",	r = 1,		g = 1,		b = 0 },
	normal	= { hex = "ffd100",	r = 1,		g = 0.81,	b = 0 },
}

-- Colors used in tooltips and the recipe list.
private.CATEGORY_COLORS = {
	-- Miscellaneous
	coords		= { hex = "d1ce6f",	r = 0.82,	g = 0.81,	b = 0.44 },
	hint		= { hex = "c9c781",	r = 0.79,	g = 0.78,	b = 0.51 },
	location	= { hex = "ffecc1",	r = 1,		g = 0.93,	b = 0.76 },
	repname		= { hex = "6a9ad9",	r = 0.42,	g = 0.60,	b = 0.85 },
}
