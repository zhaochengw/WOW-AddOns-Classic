--[[

	Atlas, a World of Warcraft instance map browser
	Copyright 2022 - Arith Hsu, Atlas Team <atlas.addon at gmail dot com>

	This file is part of Atlas.

	Atlas is free software; you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation; either version 2 of the License, or
	(at your option) any later version.

	Atlas is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with Atlas; if not, write to the Free Software
	Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

--]]

local FOLDER_NAME, private = ...

private.addon_name = "Atlas_Midnight"
private.module_name = "Midnight"

local ALC = LibStub("AceLocale-3.0"):GetLocale("Atlas")
local Atlas = LibStub("AceAddon-3.0"):GetAddon("Atlas")
local Midnight = Atlas:NewModule(private.module_name)

local db = {}
Midnight.db = db

local function Atlas_GetBossName(bossname, encounterID, creatureIndex)
	return Atlas:GetBossName(bossname, encounterID, creatureIndex, private.module_name)
end

-- Use https://wago.tools/db2/areatable for ids
local z = C_Map.GetAreaInfo
-- Use https://wago.tools/db2/JournalInstance for ids
local function i(id)
	local temp = EJ_GetInstanceInfo(id)
	return temp
end

local BLUE = "|cff6666ff"
local GREN = "|cff66cc33"
local GREY = "|cff999999"
local LBLU = "|cff33cccc"
local _RED = "|cffcc3333"
local ORNG = "|cffcc9933"
local PINK = "|ccfcc33cc"
local PURP = "|cff9900ff"
local WHIT = "|cffffffff"
local YLOW = "|cffcccc33"
local INDENT = "      "

db.AtlasMaps = {
	-- ///////////////////////////////////////
	-- Instances
	WindrunnerSpire = {
		ZoneName = { i(1299) },
		Location = { z(15968) },
		DungeonID = 2739,
		DungeonHeroicID = 2740,
		DungeonMythicID = 2743,
		WorldMapID = 2492,
		JournalInstanceID = 1299,
		Module = "Atlas_Midnight",
		{ WHIT.." 1) "..Atlas_GetBossName("Emberdawn", 2655),              2655 },
		{ WHIT.." 2) "..Atlas_GetBossName("Derelict Duo", 2656),           2656 },
		{ WHIT..INDENT..Atlas_GetBossName("Kalis", 2656, 1),               2656 },
		{ WHIT..INDENT..Atlas_GetBossName("Latch", 2656, 2),               2656 },
		{ WHIT.." 3) "..Atlas_GetBossName("Commander Kroluk", 2657),       2657 },
		{ WHIT..INDENT..Atlas_GetBossName("Phantasmal Mystic", 2657, 2),   2657 },
		{ WHIT..INDENT..Atlas_GetBossName("Spectral Axethrower", 2657, 3), 2657 },
		{ WHIT..INDENT..Atlas_GetBossName("Haunting Grunt", 2657, 4),      2657 },
		{ WHIT.." 4) "..Atlas_GetBossName("The Restless Heart", 2658),     2658 },
	},
	MagistersTerraceMidnight = {
		ZoneName = { i(1300) },
		Location = { z(15968) },
		DungeonID = 3085,
		DungeonHeroicID = 3086,
		DungeonMythicID = 3087,
		WorldMapID = 2511,
		JournalInstanceID = 1300,
		Module = "Atlas_Midnight",
		{ WHIT.." 1) "..Atlas_GetBossName("Arcanotron Custos", 2659), 2659 },
		{ WHIT.." 2) "..Atlas_GetBossName("Seranel Sunlash", 2661),   2661 },
		{ WHIT.." 3) "..Atlas_GetBossName("Gemellus", 2660),          2660 },
		{ WHIT.." 4) "..Atlas_GetBossName("Degentrius", 2662),        2662 },
	},
	MurderRow = {
		ZoneName = { i(1304) },
		Location = { z(15969) },
		DungeonID = 3090,
		DungeonHeroicID = 3091,
		DungeonMythicID = 3092,
		WorldMapID = 2433,
		JournalInstanceID = 1304,
		Module = "Atlas_Midnight",
		{ WHIT.." 1) "..Atlas_GetBossName("Kystia Manaheart", 2679),        2679 },
		{ WHIT..INDENT..Atlas_GetBossName("Nibbles", 2679, 2),              2679 },
		{ WHIT.." 2) "..Atlas_GetBossName("Zaen Bladesorrow", 2680),        2680 },
		{ WHIT..INDENT..Atlas_GetBossName("Forbidden Freight", 2680, 2),    2680 },
		{ WHIT.." 3) "..Atlas_GetBossName("Xathuux the Annihilator", 2681), 2681 },
		{ WHIT.." 4) "..Atlas_GetBossName("Lithiel Cinderfury", 2682),      2682 },
		{ WHIT..INDENT..Atlas_GetBossName("Furious Vilefiend", 2682, 2),    2682 },
		{ WHIT..INDENT..Atlas_GetBossName("Wild Imp", 2682, 3),             2682 },
		{ WHIT..INDENT..Atlas_GetBossName("Infernal", 2682, 4),             2682 },
	},
	DenOfNalorakk = {
		ZoneName = { i(1311) },
		Location = { z(15947) },
		DungeonID = 3051,
		DungeonHeroicID = 3052,
		DungeonMythicID = 3053,
		WorldMapID = 2513,
		JournalInstanceID = 1311,
		Module = "Atlas_Midnight",
		{ WHIT.." 1) "..Atlas_GetBossName("The Hoardmonger", 2776),         2776 },
		{ WHIT..INDENT..Atlas_GetBossName("Rotten Mushroom", 2776, 2),      2776 },
		{ WHIT.." 2) "..Atlas_GetBossName("Sentinel of Winter", 2777),      2777 },
		{ WHIT..INDENT..Atlas_GetBossName("Fractured Shivercore", 2777, 2), 2777 },
		{ WHIT.." 3) "..Atlas_GetBossName("Nalorakk", 2778),                2778 },
		{ WHIT..INDENT..Atlas_GetBossName("Zul'jarra", 2778, 2),            2778 },
	},
	MaisaraCaverns = {
		ZoneName = { i(1315) },
		Location = { z(15947) },
		DungeonID = 3097,
		DungeonHeroicID = 3100,
		DungeonMythicID = 3099,
		WorldMapID = 2501,
		JournalInstanceID = 1315,
		Module = "Atlas_Midnight",
		{ WHIT.." 1) "..Atlas_GetBossName("Muro'jin and Nekraxx", 2810),     2810 },
		{ WHIT..INDENT..Atlas_GetBossName("Muro'jin", 2810, 1),              2810 },
		{ WHIT..INDENT..Atlas_GetBossName("Nekraxx", 2810, 2),               2810 },
		{ WHIT.." 2) "..Atlas_GetBossName("Vordaza", 2811),                  2811 },
		{ WHIT..INDENT..Atlas_GetBossName("Unstable Phantom", 2811, 2),      2811 },
		{ WHIT.." 3) "..Atlas_GetBossName("Rak'tul, Vessel of Souls", 2812), 2812 },
		{ WHIT..INDENT..Atlas_GetBossName("Soulbind Totem", 2812, 2),        2812 },
		{ WHIT..INDENT..Atlas_GetBossName("Lost Soul", 2812, 3),             2812 },
		{ WHIT..INDENT..Atlas_GetBossName("Malignant Soul", 2812, 4),        2812 },
	},
	BlindingVale = {
		ZoneName = { i(1309) },
		Location = { z(15355) },
		DungeonID = 3102,
		DungeonHeroicID = 3105,
		DungeonMythicID = 3104,
		WorldMapID = 2500,
		JournalInstanceID = 1309,
		Module = "Atlas_Midnight",
		{ WHIT.." 1) "..Atlas_GetBossName("Lightblossom Trinity", 2769),   2769 },
		{ WHIT..INDENT..Atlas_GetBossName("Meittik", 2769, 1),             2769 },
		{ WHIT..INDENT..Atlas_GetBossName("Lekshi", 2769, 2),              2769 },
		{ WHIT..INDENT..Atlas_GetBossName("Kezkitt", 2769, 3),             2769 },
		{ WHIT..INDENT..Atlas_GetBossName("Lightblossom", 2769, 4),        2769 },
		{ WHIT.." 2) "..Atlas_GetBossName("Ikuzz the Light Hunter", 2770), 2770 },
		{ WHIT..INDENT..Atlas_GetBossName("Bloodthorn Roots", 2770, 2),    2770 },
		{ WHIT.." 3) "..Atlas_GetBossName("Lightwarden Ruia", 2771),       2771 },
		{ WHIT.." 4) "..Atlas_GetBossName("Ziekket", 2772),                2772 },
		{ WHIT..INDENT..Atlas_GetBossName("Lightspawn Lasher", 2772, 2),   2772 },
	},
	NexusPointXenas = {
		ZoneName = { i(1316) },
		Location = { z(15458) },
		DungeonID = 3056,
		DungeonHeroicID = 3057,
		DungeonMythicID = 3058,
		WorldMapID = 2556,
		JournalInstanceID = 1316,
		Module = "Atlas_Midnight",
		{ WHIT.." 1) "..Atlas_GetBossName("Chief Corewright Kasreth", 2813), 2813 },
		{ WHIT.." 2) "..Atlas_GetBossName("Corewarden Nysarra", 2814),       2814 },
		{ WHIT..INDENT..Atlas_GetBossName("Grand Nullifier", 2814, 2),       2814 },
		{ WHIT..INDENT..Atlas_GetBossName("Dreadflail", 2814, 3),            2814 },
		{ WHIT.." 3) "..Atlas_GetBossName("Lothraxion", 2815),               2815 },
		{ WHIT..INDENT..Atlas_GetBossName("Fractured Image", 2815, 2),       2815 },
	},
	VoidscarArena = {
		ZoneName = { i(1313) },
		Location = { z(15458) },
		DungeonID = 3106,
		DungeonHeroicID = 3109,
		DungeonMythicID = 3108,
		WorldMapID = 2572,
		JournalInstanceID = 1313,
		Module = "Atlas_Midnight",
		{ WHIT.." 1) "..Atlas_GetBossName("Taz'Rah", 2791),  2791 },
		{ WHIT.." 2) "..Atlas_GetBossName("Atroxus", 2792),  2792 },
		{ WHIT.." 3) "..Atlas_GetBossName("Charonus", 2793), 2793 },
	},
	VoidspireA = {
		ZoneName = { i(1307)..ALC["MapA"] },
		Location = { z(15458) },
		DungeonID = 3094,
		DungeonHeroicID = 3161,
		DungeonMythicID = 3162,
		WorldMapID = 2529,
		JournalInstanceID = 1307,
		Module = "Atlas_Midnight",
		NextMap = "VoidspireB",
		{ WHIT.." 1) "..Atlas_GetBossName("Imperator Averzian", 2733),            2733 },
		{ WHIT..INDENT..Atlas_GetBossName("Abyssal Voidshaper", 2733, 2),         2733 },
		{ WHIT..INDENT..Atlas_GetBossName("Voidmaw", 2733, 3),                    2733 },
		{ WHIT..INDENT..Atlas_GetBossName("Shadowguard Stalwart", 2733, 4),       2733 },
		{ WHIT..INDENT..Atlas_GetBossName("Obscurion Endwalker", 2733, 5),        2733 },
		{ WHIT..INDENT..Atlas_GetBossName("Abyssal Malus", 2733, 6),              2733 },
		{ WHIT..INDENT..Atlas_GetBossName("Voidbound Annihilator", 2733, 7),      2733 },
		{ WHIT.." 2) "..Atlas_GetBossName("Vorasius", 2734),                      2734 },
		{ WHIT..INDENT..Atlas_GetBossName("Blistercreep", 2734, 2),               2734 },
		{ WHIT.." 3) "..Atlas_GetBossName("Fallen-King Salhadaar", 2736),         2736 },
		{ WHIT..INDENT..Atlas_GetBossName("Concentrated Void", 2736, 2),          2736 },
		{ WHIT..INDENT..Atlas_GetBossName("Fractured Image", 2736, 3),            2736 },
		{ WHIT..INDENT..Atlas_GetBossName("Enduring Void", 2736, 4),              2736 },
		{ WHIT.." 4) "..Atlas_GetBossName("Vaelgor & Ezzorak", 2735),             2735 },
		{ WHIT..INDENT..Atlas_GetBossName("Vaelgor", 2735, 1),                    2735 },
		{ WHIT..INDENT..Atlas_GetBossName("Ezzorak", 2735, 2),                    2735 },
		{ WHIT.." 5) "..Atlas_GetBossName("Lightblinded Vanguard", 2737),         2737 },
		{ WHIT..INDENT..Atlas_GetBossName("War Chaplain Senn", 2737, 1),          2737 },
		{ WHIT..INDENT..Atlas_GetBossName("General Amias Bellamy", 2737, 2),      2737 },
		{ WHIT..INDENT..Atlas_GetBossName("Commander Venel Lightblood", 2737, 3), 2737 },
	},
	VoidspireB = {
		ZoneName = { i(1307)..ALC["MapB"] },
		Location = { z(15458) },
		DungeonID = 3094,
		DungeonHeroicID = 3161,
		DungeonMythicID = 3162,
		-- WorldMapID = 2539, -- Causes an error for some reason
		JournalInstanceID = 1307,
		Module = "Atlas_Midnight",
		PrevMap = "VoidspireA",
		{ WHIT.." 6) "..Atlas_GetBossName("Crown of the Cosmos", 2738),   2738 },
		{ WHIT..INDENT..Atlas_GetBossName("Alleria Windrunner", 2738, 1), 2738 },
		{ WHIT..INDENT..Atlas_GetBossName("Morium", 2738, 2),             2738 },
		{ WHIT..INDENT..Atlas_GetBossName("Demiar", 2738, 3),             2738 },
		{ WHIT..INDENT..Atlas_GetBossName("Vorelus", 2738, 4),            2738 },
	},
	Dreamrift = {
		ZoneName = { i(1314) },
		Location = { z(15355) },
		DungeonID = 3165,
		DungeonHeroicID = 3166,
		DungeonMythicID = 3167,
		WorldMapID = 2531,
		JournalInstanceID = 1314,
		Module = "Atlas_Midnight",
		{ WHIT.." 1) "..Atlas_GetBossName("Chimaerus the Undreamt God", 2795), 2795 },
		{ WHIT..INDENT..Atlas_GetBossName("Colossal Horror", 2795, 2),         2795 },
		{ WHIT..INDENT..Atlas_GetBossName("Haunting Essence", 2795, 3),        2795 },
		{ WHIT..INDENT..Atlas_GetBossName("Swarming Shade", 2795, 4),          2795 },
	},
	MarchOnQuelDanas = {
		ZoneName = { i(1308) },
		Location = { z(15968) },
		DungeonID = 3095,
		DungeonHeroicID = 3163,
		DungeonMythicID = 3164,
		WorldMapID = 2533,
		JournalInstanceID = 1308,
		Module = "Atlas_Midnight",
		{ WHIT.." 1) "..Atlas_GetBossName("Belo'ren, Child of Al'ar", 2739), 2739 },
		{ WHIT..INDENT..Atlas_GetBossName("Light Ember", 2739, 2),           2739 },
		{ WHIT..INDENT..Atlas_GetBossName("Void Ember", 2739, 3),            2739 },
		{ WHIT.." 2) "..Atlas_GetBossName("Midnight Falls", 2740),           2740 },
		{ WHIT..INDENT..Atlas_GetBossName("L'ura", 2740, 1),                 2740 },
		{ WHIT..INDENT..Atlas_GetBossName("Midnight Crystal", 2740, 2),      2740 },
		{ WHIT..INDENT..Atlas_GetBossName("Dusk Crystal", 2740, 3),          2740 },
		{ WHIT..INDENT..Atlas_GetBossName("Dawn Crystal", 2740, 4),          2740 },
	},
}

--[[ /////////////////////////////////////////
 Atlas Map NPC Description Data
 zoneID = {
	{ ID or letter mark, encounterID or customizedID, x, y, color of the letter mark };
	{ "A", 10001, 241, 460 };
	{ 1, 1694, 373, 339 };
 };
/////////////////////////////////////////////]]
db.AtlasMaps_NPC_DB = {
	--[[ WindrunnerSpire = {
		{ 1, 2655, 0, 0 },
		{ 2, 2656, 0, 0 },
		{ 3, 2657, 0, 0 },
		{ 4, 2658, 0, 0 },
	}, ]]
	MagistersTerraceMidnight = {
		{ 1, 2659, 252, 244 },
		{ 2, 2661, 281, 180 },
		{ 3, 2660, 202, 319 },
		{ 4, 2662, 184, 352 },
	},
	MurderRow = {
		{ 1, 2679, 158, 280 },
		{ 2, 2680, 83,  238 },
		{ 3, 2681, 319, 471 },
		{ 4, 2682, 246, 76 },
	},
	DenOfNalorakk = {
		{ 1, 2776, 242, 407 },
		{ 2, 2777, 231, 251 },
		{ 3, 2778, 62,  58 },
	},
	MaisaraCaverns = {
		{ 1, 2810, 210, 373 },
		{ 2, 2811, 407, 320 },
		{ 3, 2812, 407, 60 },
	},
	BlindingVale = {
		{ 1, 2769, 220, 159 },
		{ 2, 2770, 221, 300 },
		{ 3, 2771, 441, 236 },
		{ 4, 2772, 151, 265 },
	},
	NexusPointXenas = {
		{ 1, 2813, 72,  192 },
		{ 2, 2814, 426, 197 },
		{ 3, 2815, 247, 165 },
	},
	VoidscarArena = {
		{ 1, 2791, 249, 351 },
		{ 2, 2792, 247, 240 },
		{ 3, 2793, 247, 94 },
	},
	VoidspireA = {
		{ 1, 2733, 153, 358 },
		{ 2, 2734, 175, 185 },
		{ 3, 2736, 357, 402 },
		{ 4, 2735, 277, 240 },
		{ 5, 2737, 441, 85 },
	},
	--[[ VoidspireB = {
		{ 6, 2738, 0,   0 },
	}, ]]
	Dreamrift = {
		{ 1, 2795, 258, 348 },
	},
	MarchOnQuelDanas = {
		{ 1, 2739, 265, 232 },
		{ 2, 2740, 264, 99 },
	},
}

--[[
	AssocDefaults{}

	Default map to be auto-selected when no SubZone data is available.

	For example, "Dire Maul" has a subzone called "Warpwood Quarter" located in East Dirl Maul, however, there are also
	some areas which have not been named with any subzone, and we would like to pick a proper default map in this condition.

	Define this table entries only when the instance has multiple maps.

	Table index is zone name, it need to be localized value, but we will handle the localization with BabbleSubZone library.
	The table value is map's key-name.
]]
db.AssocDefaults = {
	--	[BZ["Black Rook Hold"]] = 		"BlackRookHoldA",
}

--[[
	SubZoneData{}

	Define SubZone data for default map to be selected for instance which has multiple maps.
	Subzone data should be able to be pulled out from WMOAreaTable for indoor areas, or from AreaTable for outdoor areas.

	Array Syntax:
	["localized zone name"] = {
		["atlas map name"] = {
			["localized subzone name 1"],
			["localized subzone name 2"],
		},
	},
]]
db.SubZoneData = {
	--	[BZ["Trial of Valor"]] = {
	--		["TrialofValorA"] = {
	--
	--		},
	--		["TrialofValorB"] = {
	--
	--		},
	--	},
}

--[[
	OutdoorZoneToAtlas{}

	Maps to auto-select to from outdoor zones.

	Table index is sub-zone name, it need to be localized value, but we will handle
	the localization with BabbleSubZone library.
	The table value is map's key-name.

	Duplicates are commented out.
	Not for localization.
]]
db.OutdoorZoneToAtlas = {
	--	[BZ["Dalaran"]] = 			"AssaultonVioletHold",
}

db.EntToInstMatches = {
	--	["TheNightholdEnt"] = 			{"TheNightholdA", "TheNightholdB", "TheNightholdC", "TheNightholdD", "TheNightholdE", "TheNightholdF", "TheNightholdG" },
}

db.InstToEntMatches = {
	--	["TheArcway"] = 			{"TheArcwayEnt"},
}

db.MapSeries = {
	["VoidspireA"] = { "VoidspireA", "VoidspireB" },
	["VoidspireB"] = { "VoidspireA", "VoidspireB" },
}

db.SubZoneAssoc = {
	--	["BlackRookHoldA"] = 			BZ["Black Rook Hold"],
}

db.DropDownLayouts_Order = {
	[ATLAS_DDL_CONTINENT] = {
		ATLAS_DDL_CONTINENT_QUELTHALAS,
	},
	[ATLAS_DDL_LEVEL] = {
		ATLAS_DDL_LEVEL_80TO90,
	},
	[ATLAS_DDL_EXPANSION] = {
		ATLAS_DDL_EXPANSION_MIDNIGHT,
	},
	[ATLAS_DDL_PARTYSIZE] = {
		ATLAS_DDL_PARTYSIZE_5,
		ATLAS_DDL_PARTYSIZE_10,
		ATLAS_DDL_PARTYSIZE_20TO40,
	},
	[ATLAS_DDL_TYPE] = {
		ATLAS_DDL_TYPE_INSTANCE,
	},
}
db.DropDownLayouts = {
	[ATLAS_DDL_CONTINENT] = {
		[ATLAS_DDL_CONTINENT_QUELTHALAS] = {
			"WindrunnerSpire",
			"MagistersTerraceMidnight",
			"MurderRow",
			"DenOfNalorakk",
			"MaisaraCaverns",
			"BlindingVale",
			"NexusPointXenas",
			"VoidscarArena",
			"VoidspireA",
			"VoidspireB",
			"Dreamrift",
			"MarchOnQuelDanas",
		}
	},
	[ATLAS_DDL_EXPANSION] = {
		[ATLAS_DDL_EXPANSION_MIDNIGHT] = {
			"WindrunnerSpire",
			"MagistersTerraceMidnight",
			"MurderRow",
			"DenOfNalorakk",
			"MaisaraCaverns",
			"BlindingVale",
			"NexusPointXenas",
			"VoidscarArena",
			"VoidspireA",
			"VoidspireB",
			"Dreamrift",
			"MarchOnQuelDanas",
		},
	},
	[ATLAS_DDL_LEVEL] = {
		[ATLAS_DDL_LEVEL_80TO90] = {
			"WindrunnerSpire",
			"MagistersTerraceMidnight",
			"MurderRow",
			"DenOfNalorakk",
			"MaisaraCaverns",
			"BlindingVale",
			"NexusPointXenas",
			"VoidscarArena",
			"VoidspireA",
			"VoidspireB",
			"Dreamrift",
			"MarchOnQuelDanas",
		},
	},
	[ATLAS_DDL_PARTYSIZE] = {
		[ATLAS_DDL_PARTYSIZE_5] = {
			"WindrunnerSpire",
			"MagistersTerraceMidnight",
			"MurderRow",
			"DenOfNalorakk",
			"MaisaraCaverns",
			"BlindingVale",
			"NexusPointXenas",
			"VoidscarArena",
		},
		[ATLAS_DDL_PARTYSIZE_10] = {
			"VoidspireA",
			"VoidspireB",
			"Dreamrift",
			"MarchOnQuelDanas",
		},
		[ATLAS_DDL_PARTYSIZE_20TO40] = {
			"VoidspireA",
			"VoidspireB",
			"Dreamrift",
			"MarchOnQuelDanas",
		},
	},
	[ATLAS_DDL_TYPE] = {
		[ATLAS_DDL_TYPE_INSTANCE] = {
			"WindrunnerSpire",
			"MagistersTerraceMidnight",
			"MurderRow",
			"DenOfNalorakk",
			"MaisaraCaverns",
			"BlindingVale",
			"NexusPointXenas",
			"VoidscarArena",
			"VoidspireA",
			"VoidspireB",
			"Dreamrift",
			"MarchOnQuelDanas",
		},
	},
}
