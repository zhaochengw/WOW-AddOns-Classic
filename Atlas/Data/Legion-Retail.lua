--[[

	Atlas, a World of Warcraft instance map browser
	Copyright 2016 ~ 2023 - Arith Hsu, Atlas Team <atlas.addon at gmail dot com>

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

private.addon_name = "Atlas_Legion"
private.module_name = "Legion"

local BZ = Atlas_GetLocaleLibBabble("LibBabble-SubZone-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale(private.addon_name)
local ALC = LibStub("AceLocale-3.0"):GetLocale("Atlas")
local Atlas = LibStub("AceAddon-3.0"):GetAddon("Atlas")
local Legion = Atlas:NewModule(private.module_name)

local db = {}
Legion.db = db

local function Atlas_GetBossName(bossname, encounterID, creatureIndex)
	return Atlas:GetBossName(bossname, encounterID, creatureIndex, private.module_name)
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
	--    [1188] = { mapFile = "ArgusRaid", [1] = 910, [2] = 911, [3] = 912, [4] = 913, [5] = 914, [6] = 915, [7] = 916, [8] = 917, [9] = 918, [10] = 919, [11] = 920, [0] = 909},
	AntorustheBurningThroneA = {
		ZoneName = { BZ["Antorus, the Burning Throne"]..ALC["MapA"] },
		Location = { BZ["Antoran Wastes"] },
		DungeonID = 1640,
		DungeonHeroicID = 1641,
		DungeonMythicID = 1642,
		WorldMapID = 909,
		--DungeonLevel = 1,
		JournalInstanceID = 946,
		PlayerLimit = { 10, 30 },
		--MinGearLevel = "860",
		Module = "Atlas_Legion",
		NextMap = "AntorustheBurningThroneB",
		{ BLUE.." A) "..ALC["Entrance"],                                  10001 },
		{ WHIT.." 1) "..Atlas_GetBossName("Garothi Worldbreaker", 1992),  1992 },
		{ WHIT.." 2) "..Atlas_GetBossName("Felhounds of Sargeras", 1987), 1987 },
		{ WHIT.." 3) "..Atlas_GetBossName("Antoran High Command", 1997),  1997 },
	},
	AntorustheBurningThroneB = {
		ZoneName = { BZ["Antorus, the Burning Throne"]..ALC["MapB"] },
		Location = { BZ["Antoran Wastes"] },
		DungeonID = 1640,
		DungeonHeroicID = 1641,
		DungeonMythicID = 1642,
		WorldMapID = 910,
		--DungeonLevel = 2,
		JournalInstanceID = 946,
		PlayerLimit = { 10, 30 },
		--MinGearLevel = "860",
		Module = "Atlas_Legion",
		PrevMap = "AntorustheBurningThroneA",
		NextMap = "AntorustheBurningThroneC",
		{ WHIT.." 3) "..Atlas_GetBossName("Antoran High Command", 1997), 1997 },
	},
	AntorustheBurningThroneC = {
		ZoneName = { BZ["Antorus, the Burning Throne"]..ALC["MapC"] },
		Location = { BZ["Antoran Wastes"] },
		DungeonID = 1640,
		DungeonHeroicID = 1641,
		DungeonMythicID = 1642,
		WorldMapID = 911,
		--DungeonLevel = 3,
		JournalInstanceID = 946,
		PlayerLimit = { 10, 30 },
		--MinGearLevel = "860",
		Module = "Atlas_Legion",
		PrevMap = "AntorustheBurningThroneB",
		NextMap = "AntorustheBurningThroneD",
		{ WHIT.." 4) "..Atlas_GetBossName("Portal Keeper Hasabel", 1985), 1985 },
	},
	AntorustheBurningThroneD = {
		ZoneName = { BZ["Antorus, the Burning Throne"]..ALC["MapD"] },
		Location = { BZ["Antoran Wastes"] },
		DungeonID = 1640,
		DungeonHeroicID = 1641,
		DungeonMythicID = 1642,
		WorldMapID = 913,
		--DungeonLevel = 5,
		JournalInstanceID = 946,
		PlayerLimit = { 10, 30 },
		--MinGearLevel = "860",
		Module = "Atlas_Legion",
		PrevMap = "AntorustheBurningThroneC",
		NextMap = "AntorustheBurningThroneE",
		{ WHIT.." 5) "..Atlas_GetBossName("Eonar the Life-Binder", 2025), 2025 },
	},
	AntorustheBurningThroneE = {
		ZoneName = { BZ["Antorus, the Burning Throne"]..ALC["MapE"] },
		Location = { BZ["Antoran Wastes"] },
		DungeonID = 1640,
		DungeonHeroicID = 1641,
		DungeonMythicID = 1642,
		WorldMapID = 914,
		--DungeonLevel = 6,
		JournalInstanceID = 946,
		PlayerLimit = { 10, 30 },
		--MinGearLevel = "860",
		Module = "Atlas_Legion",
		PrevMap = "AntorustheBurningThroneD",
		NextMap = "AntorustheBurningThroneF",
		{ WHIT.." 6) "..Atlas_GetBossName("Imonar the Soulhunter", 2009), 2009 },
		{ WHIT.." 7) "..Atlas_GetBossName("Kin'garoth", 2004),            2004 },
	},
	AntorustheBurningThroneF = {
		ZoneName = { BZ["Antorus, the Burning Throne"]..ALC["MapF"] },
		Location = { BZ["Antoran Wastes"] },
		DungeonID = 1640,
		DungeonHeroicID = 1641,
		DungeonMythicID = 1642,
		WorldMapID = 915,
		--DungeonLevel = 7,
		JournalInstanceID = 946,
		PlayerLimit = { 10, 30 },
		--MinGearLevel = "860",
		Module = "Atlas_Legion",
		PrevMap = "AntorustheBurningThroneE",
		NextMap = "AntorustheBurningThroneG",
		{ WHIT.." 8) "..Atlas_GetBossName("The Coven of Shivarra", 1986), 1986 },
		{ WHIT.." 9) "..Atlas_GetBossName("Varimathras", 1983),           1983 },
		{ WHIT.."10) "..Atlas_GetBossName("Aggramar", 1984),              1984 },
	},
	AntorustheBurningThroneG = {
		ZoneName = { BZ["Antorus, the Burning Throne"]..ALC["MapG"] },
		Location = { BZ["Antoran Wastes"] },
		DungeonID = 1640,
		DungeonHeroicID = 1641,
		DungeonMythicID = 1642,
		WorldMapID = 918,
		--DungeonLevel = 10,
		JournalInstanceID = 946,
		PlayerLimit = { 10, 30 },
		--MinGearLevel = "860",
		Module = "Atlas_Legion",
		PrevMap = "AntorustheBurningThroneF",
		{ WHIT.."11) "..Atlas_GetBossName("Argus the Unmaker", 2031), 2031 },
	},
	AssaultonVioletHold = {
		ZoneName = { BZ["Assault on Violet Hold"] },
		Location = { BZ["Dalaran"] },
		DungeonID = 1208,
		DungeonHeroicID = 1209,
		WorldMapID = 732,
		JournalInstanceID = 777,
		Module = "Atlas_Legion",
		{ BLUE.." A) "..ALC["Entrance"],                                    10001 },
		{ WHIT.." 1) "..Atlas_GetBossName("Shivermaw", 1694),               1694 },
		{ WHIT.." 2) "..Atlas_GetBossName("Blood-Princess Thal'ena", 1702), 1702 },
		{ WHIT.." 3) "..Atlas_GetBossName("Festerface", 1693),              1693 },
		{ WHIT.." 4) "..Atlas_GetBossName("Millificent Manastorm", 1688),   1688 },
		{ WHIT.." 5) "..Atlas_GetBossName("Mindflayer Kaahrj", 1686),       1686 },
		{ WHIT.." 6) "..Atlas_GetBossName("Anub'esset", 1696),              1696 },
		{ WHIT.." 7) "..Atlas_GetBossName("Sael'orn", 1697),                1697 },
		{ WHIT.." 8) "..Atlas_GetBossName("Fel Lord Betrug", 1711),         1711 },
		{ "" },
		{ LBLU..ACHIEVEMENTS..ALC["Colon"] },
		{ "You're Just Making It WORSE!",                                   "ac=10553" },
		{ "I Made a Food",                                                  "ac=10554" },
		{ "Assault on Violet Hold",                                         "ac=10798" },
		{ "Heroic: Assault on Violet Hold",                                 "ac=10799" },
		{ "Mythic: Assault on Violet Hold",                                 "ac=10800" },
		{ "Mythic: Assault on Violet Hold Guild Run",                       "ac=10860" },
	},
	--    [1081] = { mapFile = "BlackRookHoldDungeon", [1] = 751, [2] = 752, [3] = 753, [4] = 754, [5] = 755, [6] = 756},
	BlackRookHoldA = {
		ZoneName = { BZ["Black Rook Hold"]..ALC["MapA"] },
		Location = { BZ["Val'sharah"] },
		DungeonID = 1204,
		DungeonHeroicID = 1205,
		WorldMapID = 751,
		--DungeonLevel = 1,
		JournalInstanceID = 740,
		Module = "Atlas_Legion",
		NextMap = "BlackRookHoldB",
		{ BLUE.." A) "..ALC["Entrance"],                                              10001 },
		{ BLUE.." B) "..ALC["Connection"],                                            10002 },
		{ WHIT.." 1) "..Atlas_GetBossName("The Amalgam of Souls", 1518),              1518 },
		{ ORNG.." 1) "..Atlas:GetCreatureName(L["Lady Velandras Ravencrest"], 98538), 98538 },
		{ ORNG.." 2) "..Atlas:GetCreatureName(L["Lord Etheldrin Ravencrest"], 98521), 98521 },
		{ ORNG.." 3) "..Atlas:GetCreatureName(L["General Tel'arn"], 110993),          110993 },
		{ INDENT..ORNG..Atlas:GetCreatureName(L["Ranger General Feleor"], 110995) },
		{ ORNG.." 4) "..Atlas:GetCreatureName(L["Ancient Widow"], 98637),             98637 },
		{ GREN.." 1') "..L["Torn Page"],                                              10003 },
		{ "" },
		{ LBLU..ACHIEVEMENTS..ALC["Colon"] },
		{ "Black Rook Moan",                                                          "ac=10710" },
		{ "You Used to Scrawl Me In Your Fel Tome",                                   "ac=10709" },
		{ "Black Rook Hold",                                                          "ac=10804" },
		{ "Heroic: Black Rook Hold",                                                  "ac=10805" },
		{ "Mythic: Black Rook Hold",                                                  "ac=10806" },
		{ "Mythic: Black Rook Hold Guild Run",                                        "ac=10862" },
	},
	BlackRookHoldB = {
		ZoneName = { BZ["Black Rook Hold"]..ALC["MapB"] },
		Location = { BZ["Val'sharah"] },
		DungeonID = 1204,
		DungeonHeroicID = 1205,
		WorldMapID = 752,
		--DungeonLevel = 2,
		JournalInstanceID = 740,
		Module = "Atlas_Legion",
		PrevMap = "BlackRookHoldA",
		NextMap = "BlackRookHoldC",
		{ BLUE.." B-D) "..ALC["Connection"],                                  10001 },
		{ WHIT.." 2) "..Atlas_GetBossName("Illysanna Ravencrest", 1653),      1653 },
		{ ORNG.." 5) "..Atlas:GetCreatureName(L["Archmage Galeorn"], 111068), 111068 },
		{ GREN.." 2') "..L["Worn-Edged Page"],                                10002 },
		{ GREN.." 3') "..L["Dog-Eared Page"],                                 10003 },
		{ "" },
		{ LBLU..ACHIEVEMENTS..ALC["Colon"] },
		{ "Black Rook Moan",                                                  "ac=10710" },
		{ "You Used to Scrawl Me In Your Fel Tome",                           "ac=10709" },
		{ "Black Rook Hold",                                                  "ac=10804" },
		{ "Heroic: Black Rook Hold",                                          "ac=10805" },
		{ "Mythic: Black Rook Hold",                                          "ac=10806" },
		{ "Mythic: Black Rook Hold Guild Run",                                "ac=10862" },
	},
	BlackRookHoldC = {
		ZoneName = { BZ["Black Rook Hold"]..ALC["MapC"] },
		Location = { BZ["Val'sharah"] },
		DungeonID = 1204,
		DungeonHeroicID = 1205,
		WorldMapID = 753,
		--DungeonLevel = 3,
		JournalInstanceID = 740,
		Module = "Atlas_Legion",
		PrevMap = "BlackRookHoldB",
		NextMap = "BlackRookHoldD",
		{ BLUE.." E-H) "..ALC["Connection"],                                                  10001 },
		{ ORNG.." 6) "..Atlas:GetCreatureName(L["Kalyndras <Rook's Quartermaster>"], 112725), 112725 },
		{ ORNG.." 7) "..Atlas:GetCreatureName(L["Braxas the Fleshcarver"], 111290),           111290 },
		{ ORNG.." 8) "..Atlas:GetCreatureName(L["Kelorn Nightblade"], 111361),                111361 },
		{ GREN.." 4') "..L["Singed Page"],                                                    10002 }, -- achievement=10709, object=252388
		{ GREN.." 5') ",                                                                      136812,    "item", "Sabelite Sulfate" },
		{ GREN.." 6') "..L["Ink-splattered Page"],                                            10003 },
		{ GREN.." 7') "..L["Hastily-Scrawled Page"],                                          10004 },
		{ "" },
		{ LBLU..ACHIEVEMENTS..ALC["Colon"] },
		{ "Adds? More Like Bads",                                                             "ac=10711" },
		{ "You Used to Scrawl Me In Your Fel Tome",                                           "ac=10709" },
		{ "Black Rook Hold",                                                                  "ac=10804" },
		{ "Heroic: Black Rook Hold",                                                          "ac=10805" },
		{ "Mythic: Black Rook Hold",                                                          "ac=10806" },
		{ "Mythic: Black Rook Hold Guild Run",                                                "ac=10862" },
	},
	BlackRookHoldD = {
		ZoneName = { BZ["Black Rook Hold"]..ALC["MapD"] },
		Location = { BZ["Val'sharah"] },
		DungeonID = 1204,
		DungeonHeroicID = 1205,
		WorldMapID = 754,
		--DungeonLevel = 4,
		JournalInstanceID = 740,
		Module = "Atlas_Legion",
		PrevMap = "BlackRookHoldC",
		{ BLUE.." F-G) "..ALC["Connection"],                                  10001 },
		{ WHIT.." 3) "..Atlas_GetBossName("Smashspite the Hateful", 1664),    1664 },
		{ WHIT.." 4) "..Atlas_GetBossName("Lord Kur'talos Ravencrest", 1672), 1672 },
		{ INDENT..WHIT..Atlas:GetCreatureName(L["Dantalionax"], 99611),       99611 },
		{ "" },
		{ LBLU..ACHIEVEMENTS..ALC["Colon"] },
		{ "You Used to Scrawl Me In Your Fel Tome",                           "ac=10709" },
		{ "Black Rook Hold",                                                  "ac=10804" },
		{ "Heroic: Black Rook Hold",                                          "ac=10805" },
		{ "Mythic: Black Rook Hold",                                          "ac=10806" },
		{ "Mythic: Black Rook Hold Guild Run",                                "ac=10862" },
	},
	--    [1146] = { mapFile = "TombofSargerasDungeon", [1] = 845, [2] = 846, [3] = 847, [4] = 848, [5] = 849},
	CathedralofEternalNightA = {
		ZoneName = { BZ["Cathedral of Eternal Night"]..ALC["MapA"] },
		Location = { BZ["Broken Shore"] },
		DungeonHeroicID = 1488,
		DungeonMythicID = 1488,
		WorldMapID = 845,
		--DungeonLevel = 1,
		JournalInstanceID = 900,
		Module = "Atlas_Legion",
		NextMap = "CathedralofEternalNightB",
		{ BLUE.." A) "..ALC["Entrance"],                              10001 },
		{ BLUE.." B) "..ALC["Stairs"],                                10002 },
		{ ORNG.." 1) "..Atlas:GetCreatureName(L["Raga'yut"], 120715), 120715 },
		{ "" },
		{ LBLU..ACHIEVEMENTS..ALC["Colon"] },
		{ "Boom Bloom",                                               "ac=11768" },
		{ "A Steamy Romance Saga",                                    "ac=11769" },
		{ "Master of Shadows",                                        "ac=11703" },
		{ "Cathedral of Eternal Night",                               "ac=11700" },
		{ "Heroic: Cathedral of Eternal Night",                       "ac=11701" },
		{ "Mythic: Cathedral of Eternal Night",                       "ac=11702" },
	},
	CathedralofEternalNightB = {
		ZoneName = { BZ["Cathedral of Eternal Night"]..ALC["MapB"] },
		Location = { BZ["Broken Shore"] },
		DungeonHeroicID = 1488,
		DungeonMythicID = 1488,
		WorldMapID = 846,
		--DungeonLevel = 2,
		JournalInstanceID = 900,
		Module = "Atlas_Legion",
		PrevMap = "CathedralofEternalNightA",
		NextMap = "CathedralofEternalNightC",
		{ BLUE.." B-C) "..ALC["Stairs"],                    10001 },
		{ WHIT.." 1) "..Atlas_GetBossName("Agronox", 1905), 1905 },
		{ "" },
		{ LBLU..ACHIEVEMENTS..ALC["Colon"] },
		{ "Boom Bloom",                                     "ac=11768" },
		{ "A Steamy Romance Saga",                          "ac=11769" },
		{ "Master of Shadows",                              "ac=11703" },
		{ "Cathedral of Eternal Night",                     "ac=11700" },
		{ "Heroic: Cathedral of Eternal Night",             "ac=11701" },
		{ "Mythic: Cathedral of Eternal Night",             "ac=11702" },
	},
	CathedralofEternalNightC = {
		ZoneName = { BZ["Cathedral of Eternal Night"]..ALC["MapC"] },
		Location = { BZ["Broken Shore"] },
		DungeonHeroicID = 1488,
		DungeonMythicID = 1488,
		WorldMapID = 847,
		--DungeonLevel = 3,
		JournalInstanceID = 900,
		Module = "Atlas_Legion",
		PrevMap = "CathedralofEternalNightB",
		NextMap = "CathedralofEternalNightD",
		{ BLUE.." C-E) "..ALC["Stairs"],                                    10001 },
		{ WHIT.." 2) "..Atlas_GetBossName("Thrashbite the Scornful", 1906), 1906 },
		{ "" },
		{ LBLU..ACHIEVEMENTS..ALC["Colon"] },
		{ "Boom Bloom",                                                     "ac=11768" },
		{ "A Steamy Romance Saga",                                          "ac=11769" },
		{ "Master of Shadows",                                              "ac=11703" },
		{ "Cathedral of Eternal Night",                                     "ac=11700" },
		{ "Heroic: Cathedral of Eternal Night",                             "ac=11701" },
		{ "Mythic: Cathedral of Eternal Night",                             "ac=11702" },
	},
	CathedralofEternalNightD = {
		ZoneName = { BZ["Cathedral of Eternal Night"]..ALC["MapD"] },
		Location = { BZ["Broken Shore"] },
		DungeonHeroicID = 1488,
		DungeonMythicID = 1488,
		WorldMapID = 849,
		--DungeonLevel = 5,
		JournalInstanceID = 900,
		Module = "Atlas_Legion",
		PrevMap = "CathedralofEternalNightC",
		{ BLUE.." E) "..ALC["Stairs"],                          10001 },
		{ GREN.." 1') ",                                        129207,    "item", "Aegis of Aggramar" }, -- Aegis of Aggramar
		{ WHIT.." 3) "..Atlas_GetBossName("Domatrax", 1904),    1904 },
		{ WHIT.." 4) "..Atlas_GetBossName("Mephistroth", 1878), 1878 },
		{ "" },
		{ LBLU..ACHIEVEMENTS..ALC["Colon"] },
		{ "Boom Bloom",                                         "ac=11768" },
		{ "A Steamy Romance Saga",                              "ac=11769" },
		{ "Master of Shadows",                                  "ac=11703" },
		{ "Cathedral of Eternal Night",                         "ac=11700" },
		{ "Heroic: Cathedral of Eternal Night",                 "ac=11701" },
		{ "Mythic: Cathedral of Eternal Night",                 "ac=11702" },
	},
	--    [1087] = { mapFile = "SuramarNoblesDistrict", [1] = 762, [2] = 763, [0] = 761},
	CourtofStarsA = {
		ZoneName = { BZ["Court of Stars"]..ALC["MapA"] },
		Location = { BZ["Suramar"] },
		--DungeonID = 1319,
		DungeonMythicID = 1318,
		WorldMapID = 761,
		--DungeonLevel = 1,
		JournalInstanceID = 800,
		Module = "Atlas_Legion",
		NextMap = "CourtofStarsB",
		{ BLUE.." A) "..ALC["Entrance"],                                      10001 },
		{ BLUE.." B-C) "..ALC["Connection"],                                  10002 },
		{ WHIT.." 1) "..Atlas_GetBossName("Patrol Captain Gerdo", 1718),      1718 },
		{ WHIT.." 2) "..Atlas_GetBossName("Talixae Flamewreath", 1719),       1719 },
		{ WHIT.." 3) "..Atlas_GetBossName("Advisor Melandrus", 1720),         1720 },
		{ GREN.." 1) "..Atlas:GetCreatureName(L["Ly'leth Lunastre"], 106468), 106468 },
		{ ORNG.." 1) "..Atlas:GetCreatureName(L["Arcanist Malrodi"], 108796), 108796 },
		{ ORNG.." 2) "..Atlas:GetCreatureName(L["Velimar"], 108740),          108740 },
		{ "" },
		{ LBLU..ACHIEVEMENTS..ALC["Colon"] },
		{ "Waiting for Gerdo",                                                "ac=10610" },
		{ "Dropping Some Eaves",                                              "ac=10611" },
		{ "Mythic: Court of Stars",                                           "ac=10816" },
		{ "Mythic: Court of Stars Guild Run",                                 "ac=10865" },
	},
	CourtofStarsB = {
		ZoneName = { BZ["Court of Stars"]..ALC["MapB"] },
		Location = { BZ["Suramar"] },
		--DungeonID = 1319,
		DungeonMythicID = 1318,
		WorldMapID = 762,
		--DungeonLevel = 2,
		JournalInstanceID = 800,
		Module = "Atlas_Legion",
		PrevMap = "CourtofStarsA",
		{ BLUE.." B-C) "..ALC["Connection"], 10002 },
	},
	DarkheartThicket = {
		ZoneName = { BZ["Darkheart Thicket"] },
		Location = { BZ["Val'sharah"] },
		DungeonID = 1201,
		DungeonHeroicID = 1202,
		WorldMapID = 733,
		JournalInstanceID = 762,
		Module = "Atlas_Legion",
		{ BLUE.." A) "..ALC["Entrance"],                                 10001 },
		{ BLUE.." B) "..ALC["Connection"],                               10002 },
		{ WHIT.." 1) "..Atlas_GetBossName("Arch-Druid Glaidalis", 1654), 1654 },
		{ WHIT.." 2) "..Atlas_GetBossName("Oakheart", 1655),             1655 },
		{ WHIT.." 3) "..Atlas_GetBossName("Dresaron", 1656),             1656 },
		{ WHIT.." 4) "..Atlas_GetBossName("Shade of Xavius", 1657),      1657 },
		{ ORNG.." 1) "..Atlas:GetCreatureName(L["Rage Rot"], 101660),    101660 },
		{ ORNG.." 2) "..Atlas:GetCreatureName(L["Mythana"], 101641),     101641 },
		{ ORNG.." 3) "..Atlas:GetCreatureName(L["Kudzilla"], 99362),     99362 },
		{ "" },
		{ LBLU..ACHIEVEMENTS..ALC["Colon"] },
		{ "Egg-cellent!",                                                "ac=10766" },
		{ "Burning Down the House",                                      "ac=10769" },
		{ "Darkheart Thicket",                                           "ac=10783" },
		{ "Heroic: Darkheart Thicket",                                   "ac=10784" },
		{ "Mythic: Darkheart Thicket",                                   "ac=10785" },
		{ "Mythic: Darkheart Thicket Guild Run",                         "ac=10857" },
	},
	EyeofAzshara = {
		ZoneName = { BZ["Eye of Azshara"] },
		Location = { BZ["Azsuna"] },
		DungeonID = 1174,
		DungeonHeroicID = 1175,
		WorldMapID = 713,
		JournalInstanceID = 716,
		Module = "Atlas_Legion",
		{ BLUE.." A) "..ALC["Entrance"],                                          10001 },
		{ WHIT.." 1) "..Atlas_GetBossName("Warlord Parjesh", 1480),               1480 },
		{ WHIT.." 2) "..Atlas_GetBossName("Lady Hatecoil", 1490),                 1490 },
		{ WHIT.." 3) "..Atlas_GetBossName("Serpentrix", 1479),                    1479 },
		{ WHIT.." 4) "..Atlas_GetBossName("King Deepbeard", 1491),                1491 },
		{ WHIT.." 5) "..Atlas_GetBossName("Wrath of Azshara", 1492),              1492 },
		{ GREN.."1') "..L["Crate of Corks"],                                      248930 }, -- object
		{ INDENT..GREY..QUESTS_COLON..L["Put a Cork in It"] },
		{ ORNG.." 1) "..Atlas:GetCreatureName(L["Shellmaw"], 91788),              91788 },
		{ ORNG.." 2) "..Atlas:GetCreatureName(L["Dread Captain Thedon"], 108543), 108543 },
		{ ORNG.." 3) "..Atlas:GetCreatureName(L["Gom Crabbar"], 101411),          101411 },
		{ ORNG.." 4) "..Atlas:GetCreatureName(L["Jaggen-Ra"], 101467),            101467 },
		{ "" },
		{ LBLU..ACHIEVEMENTS..ALC["Colon"] },
		{ "But You Say He's Just a Friend",                                       "ac=10456" },
		{ "Stay Salty",                                                           "ac=10457" },
		{ "Ready for Raiding V",                                                  "ac=10458" },
		{ "Eye of Azshara",                                                       "ac=10780" },
		{ "Heroic: Eye of Azshara",                                               "ac=10781" },
		{ "Mythic: Eye of Azshara",                                               "ac=10782" },
		{ "Mythic: Eye of Azshara Guild Run",                                     "ac=10856" },
	},
	--    [1041] = { mapFile = "HallsofValor", [1] = 704, [2] = 705, [0] = 703},
	HallsofValorA = {
		ZoneName = { BZ["Halls of Valor"]..ALC["MapA"] },
		Location = { BZ["Stormheim"] },
		DungeonID = 1193,
		DungeonHeroicID = 1194,
		WorldMapID = 704,
		--DungeonLevel = 2,
		JournalInstanceID = 721,
		Module = "Atlas_Legion",
		NextMap = "HallsofValorB",
		{ BLUE.." A) "..ALC["Entrance"],                                         10001 },
		{ BLUE.." B) "..ALC["Portal"],                                           10002 },
		{ BLUE.." C) "..ALC["Connection"],                                       10003 },
		{ WHIT.." 1) "..Atlas_GetBossName("Hymdall", 1485),                      1485 },
		{ WHIT.." 2) "..Atlas_GetBossName("Hyrja", 1486),                        1486 },
		{ ORNG.." 1) "..Atlas:GetCreatureName(L["Volynd Stormbringer"], 106320), 106320 },
		{ "" },
		{ LBLU..ACHIEVEMENTS..ALC["Colon"] },
		{ "Halls of Valor",                                                      "ac=10786" },
		{ "Heroic: Halls of Valor",                                              "ac=10788" },
		{ "Mythic: Halls of Valor",                                              "ac=10789" },
		{ "Mythic: Halls of Valor Guild Run",                                    "ac=10858" },
	},
	HallsofValorB = {
		ZoneName = { BZ["Halls of Valor"]..ALC["MapB"] },
		Location = { BZ["Stormheim"] },
		DungeonID = 1193,
		DungeonHeroicID = 1194,
		WorldMapID = 703,
		--DungeonLevel = 1,
		JournalInstanceID = 721,
		Module = "Atlas_Legion",
		PrevMap = "HallsofValorA",
		NextMap = "HallsofValorC",
		{ BLUE.." B) "..ALC["Portal"],                                               10002 },
		{ WHIT.." 3) "..Atlas_GetBossName("Fenryr", 1487),                           1487 },
		{ INDENT..WHIT.." 3') "..L["Fenryr's western spawn point"],                  10003 },
		{ INDENT..WHIT.." 3'') "..L["Fenryr's eastern spawn point"],                 10004 },
		{ ORNG.." 2) "..Atlas:GetCreatureName(L["Arthfael"], 99802),                 99802 },
		{ ORNG.." 3) "..Atlas:GetCreatureName(L["Earlnoc the Beastbreaker"], 96647), 96647 },
		{ "" },
		{ LBLU..ACHIEVEMENTS..ALC["Colon"] },
		{ "Halls of Valor",                                                          "ac=10786" },
		{ "Heroic: Halls of Valor",                                                  "ac=10788" },
		{ "Mythic: Halls of Valor",                                                  "ac=10789" },
		{ "Mythic: Halls of Valor Guild Run",                                        "ac=10858" },
	},
	HallsofValorC = {
		ZoneName = { BZ["Halls of Valor"]..ALC["MapC"] },
		Location = { BZ["Stormheim"] },
		DungeonID = 1193,
		DungeonHeroicID = 1194,
		WorldMapID = 705,
		--DungeonLevel = 3,
		JournalInstanceID = 721,
		Module = "Atlas_Legion",
		PrevMap = "HallsofValorB",
		{ BLUE.." C) "..ALC["Connection"],                              10003 },
		{ WHIT.." 4) "..Atlas_GetBossName("God-King Skovald", 1488),    1488 },
		{ WHIT.." 5) "..Atlas_GetBossName("Odyn", 1489),                1489 },
		{ ORNG.." 1) "..Atlas:GetCreatureName(L["King Tor"], 97084),    97084 },
		{ ORNG.." 2) "..Atlas:GetCreatureName(L["King Bjorn"], 97081),  97081 },
		{ ORNG.." 3) "..Atlas:GetCreatureName(L["King Haldor"], 95843), 95843 },
		{ ORNG.." 4) "..Atlas:GetCreatureName(L["King Ranulf"], 97083), 97083 },
		{ "" },
		{ LBLU..ACHIEVEMENTS..ALC["Colon"] },
		{ "I Got What You Mead",                                        "ac=10542" },
		{ "Halls of Valor",                                             "ac=10786" },
		{ "Surge Protector",                                            "ac=10543" },
		{ "Heroic: Halls of Valor",                                     "ac=10788" },
		{ "Mythic: Halls of Valor",                                     "ac=10789" },
		{ "Mythic: Halls of Valor Guild Run",                           "ac=10858" },
	},
	--    [1042] = { mapFile = "HelheimDungeonDock", [1] = 707, [2] = 708, [0] = 706},
	MawofSoulsA = {
		ZoneName = { BZ["Maw of Souls"]..ALC["MapA"] },
		Location = { BZ["Stormheim"] },
		DungeonID = 1191,
		DungeonHeroicID = 1192,
		WorldMapID = 706,
		--DungeonLevel = 1,
		JournalInstanceID = 727,
		Module = "Atlas_Legion",
		NextMap = "MawofSoulsB",
		{ BLUE.." A) "..ALC["Entrance"],                                                  10001 },
		{ BLUE.." B) "..ALC["Transport"]..ALC["Hyphen"]..L["Echoing Horn of the Damned"], 10002 },
		{ WHIT.." 1) "..Atlas_GetBossName("Ymiron, the Fallen King", 1502),               1502 },
		{ "" },
		{ LBLU..ACHIEVEMENTS..ALC["Colon"] },
		{ "Helheim Hath No Fury",                                                         "ac=10411" },
		{ "Instant Karma",                                                                "ac=10413" },
		{ "Maw of Souls",                                                                 "ac=10807" },
		{ "Heroic: Maw of Souls",                                                         "ac=10808" },
		{ "Mythic: Maw of Souls",                                                         "ac=10809" },
		{ "Mythic: Maw of Souls Guild Run",                                               "ac=10863" },
	},
	MawofSoulsB = {
		ZoneName = { BZ["Maw of Souls"]..ALC["MapB"] },
		Location = { BZ["Stormheim"] },
		DungeonID = 1191,
		DungeonHeroicID = 1192,
		WorldMapID = 708,
		--DungeonLevel = 3,
		JournalInstanceID = 727,
		Module = "Atlas_Legion",
		PrevMap = "MawofSoulsA",
		{ BLUE.." B-C) "..ALC["Connection"],                 10001 },
		{ WHIT.." 2) "..Atlas_GetBossName("Harbaron", 1512), 1512 },
		{ WHIT.." 3) "..Atlas_GetBossName("Helya", 1663),    1663 },
		{ "" },
		{ LBLU..ACHIEVEMENTS..ALC["Colon"] },
		{ "Helheim Hath No Fury",                            "ac=10411" },
		{ "Poor Unfortunate Souls",                          "ac=10412" },
		{ "Instant Karma",                                   "ac=10413" },
		{ "Maw of Souls",                                    "ac=10807" },
		{ "Heroic: Maw of Souls",                            "ac=10808" },
		{ "Mythic: Maw of Souls",                            "ac=10809" },
		{ "Mythic: Maw of Souls Guild Run",                  "ac=10863" },
	},
	NeltharionsLair = {
		ZoneName = { BZ["Neltharion's Lair"] },
		Location = { BZ["Highmountain"] },
		DungeonID = 1206,
		DungeonHeroicID = 1207,
		WorldMapID = 731,
		JournalInstanceID = 767,
		Module = "Atlas_Legion",
		{ BLUE.." A) "..ALC["Entrance"],                                                10001 },
		{ BLUE.." B) "..ALC["Exit"],                                                    10002 },
		{ WHIT.." 1) "..Atlas_GetBossName("Rokmora", 1662),                             1662 },
		{ WHIT.." 2) "..Atlas_GetBossName("Ularogg Cragshaper", 1665),                  1665 },
		{ WHIT.." 3) "..Atlas_GetBossName("Naraxas", 1673),                             1673 },
		{ WHIT.." 4) "..Atlas_GetBossName("Dargrul the Underking", 1687),               1687 },
		{ GREN.." 1') "..Atlas:GetCreatureName(L["Spiritwalker Ebonhorn"], 113526),     113526 },
		{ GREN.." 2') "..Atlas:GetCreatureName(L["Mushroom Merchant"], 111746),         111746 },
		{ ORNG.." 1) "..Atlas:GetCreatureName(L["Ultanok"], 103247),                    103247 },
		{ ORNG.." 2) "..Atlas:GetCreatureName(L["Understone Lasher"], 103597),          103597 },
		{ ORNG.." 3) "..Atlas:GetCreatureName(L["Ragoul"], 103199),                     103199 },
		{ ORNG.." 4) "..Atlas:GetCreatureName(L["Kraxa <Mother of Gnashers>"], 103271), 103271 },
		{ "" },
		{ LBLU..ACHIEVEMENTS..ALC["Colon"] },
		{ "Got to Ketchum All",                                                         "ac=10996" },
		{ "Can't Eat Just One",                                                         "ac=10875" },
		{ "Neltharion's Lair",                                                          "ac=10795" },
		{ "Heroic: Neltharion's Lair",                                                  "ac=10796" },
		{ "Mythic: Neltharion's Lair",                                                  "ac=10797" },
		{ "Mythic: Neltharion's Lair Guild Run",                                        "ac=10859" },
	},
	ReturntoKarazhanEnt = {
		ZoneName = { BZ["Return to Karazhan"]..ALC["L-Parenthesis"]..ALC["Entrance"]..ALC["R-Parenthesis"] },
		Location = { BZ["Deadwind Pass"] },
		DungeonHeroicID = 1475, -- 1474: Upper Return to Karazhan, 1475: Lower Return to Karazhan
		DungeonMythicID = 1475,
		WorldMapID = 42,  -- DeadwindPass
		JournalInstanceID = 860,
		LevelRange = "110",
		MinLevel = "110",
		PlayerLimit = { 5 },
		--MinGearLevel = "825",
		Module = "Atlas_Legion",
		NextMap = "ReturntoKarazhanA",
		{ BLUE.." A) "..BZ["Karazhan"]..ALC["L-Parenthesis"]..ALC["Front"]..ALC["R-Parenthesis"],           10001 },
		{ BLUE.." B) "..BZ["Karazhan"]..ALC["L-Parenthesis"]..ALC["Back"]..ALC["R-Parenthesis"],            10002 },
		{ BLUE.." C) "..BZ["Return to Karazhan"]..ALC["L-Parenthesis"]..ALC["Upper"]..ALC["R-Parenthesis"], 10003 },
		{ GREN.." 1') "..Atlas:GetCreatureName(L["Mage Darius"], 18255),                                    18255 },
		{ GREN.." 2') "..format(ALC["Stairs to %s"], BZ["The Master's Cellar"]),                            10004 },
		{ GREN.." 3') "..format(ALC["Stairs to %s"], BZ["The Master's Cellar"]),                            10005 },
		{ GREN.." 4') "..L["Charred Bone Fragment"],                                                        10006 },
		{ GREN.." 5') "..ALC["Meeting Stone"],                                                              10007 },
		{ GREN.." 6') "..ALC["Graveyard"],                                                                  10008 },
		{ GREN.." 7') "..Atlas:GetCreatureName(L["Lydia Accoste"], 66255),                                  66255 },
	},
	--    [1115] = { mapFile = "LegionKarazhanDungeon", [1] = 809, [2] = 810, [3] = 811, [4] = 812, [5] = 813, [6] = 814, [7] = 815, [8] = 816, [9] = 817, [10] = 818, [11] = 819, [12] = 820, [13] = 821, [14] = 822},
	ReturntoKarazhanA = {
		ZoneName = { BZ["Return to Karazhan"]..ALC["MapA"] },
		Location = { BZ["Deadwind Pass"] },
		DungeonHeroicID = 1475, -- 1474: Upper Return to Karazhan, 1475: Lower Return to Karazhan
		DungeonMythicID = 1475,
		--DungeonLevel = 6,
		WorldMapID = 814,
		LevelRange = "110",
		MinLevel = "110",
		PlayerLimit = { 5 },
		--MinGearLevel = "825",
		JournalInstanceID = 860,
		Module = "Atlas_Legion",
		NextMap = "ReturntoKarazhanB",
		{ BLUE.." A) "..ALC["Entrance"],                                        10001 },
		{ BLUE.." B-D) "..ALC["Connection"],                                    10002 },
		{ GREN.." 1') "..Atlas:GetCreatureName(L["Barnes"], 114339),            114339 },
		{ WHIT.." 1) "..Atlas_GetBossName("Opera Hall: Wikket", 1820),          1820 },
		{ WHIT.." 2) "..Atlas_GetBossName("Opera Hall: Westfall Story", 1826),  1826 },
		{ WHIT.." 3) "..Atlas_GetBossName("Opera Hall: Beautiful Beast", 1827), 1827 },
		{ GREN.." 2') "..Atlas:GetCreatureName(L["Soul Fragment"], 115105),     115105 },
	},
	ReturntoKarazhanB = {
		ZoneName = { BZ["Return to Karazhan"]..ALC["MapB"] },
		Location = { BZ["Deadwind Pass"] },
		DungeonHeroicID = 1475, -- 1474: Upper Return to Karazhan, 1475: Lower Return to Karazhan
		DungeonMythicID = 1475,
		--DungeonLevel = 4,
		WorldMapID = 812,
		JournalInstanceID = 860,
		LevelRange = "110",
		MinLevel = "110",
		PlayerLimit = { 5 },
		--MinGearLevel = "825",
		Module = "Atlas_Legion",
		PrevMap = "ReturntoKarazhanA",
		NextMap = "ReturntoKarazhanC",
		{ BLUE.." D-F) "..ALC["Connection"],                                10001 },
		{ GREN.." 3') "..Atlas:GetCreatureName(L["Soul Fragment"], 115013), 115013 },
		{ WHIT.." 4) "..Atlas_GetBossName("Maiden of Virtue", 1825),        1825 },
	},
	ReturntoKarazhanC = {
		ZoneName = { BZ["Return to Karazhan"]..ALC["MapC"] },
		Location = { BZ["Deadwind Pass"] },
		DungeonHeroicID = 1475, -- 1474: Upper Return to Karazhan, 1475: Lower Return to Karazhan
		DungeonMythicID = 1475,
		--DungeonLevel = 3,
		WorldMapID = 811,
		JournalInstanceID = 860,
		LevelRange = "110",
		MinLevel = "110",
		PlayerLimit = { 5 },
		--MinGearLevel = "825",
		Module = "Atlas_Legion",
		PrevMap = "ReturntoKarazhanB",
		NextMap = "ReturntoKarazhanD",
		{ BLUE.." E-H) "..ALC["Connection"],                                10001 },
		{ WHIT.." 5) "..Atlas_GetBossName("Moroes", 1837),                  1837 },
		{ GREN.." 4') "..Atlas:GetCreatureName(L["Soul Fragment"], 115103), 115103 },
	},
	ReturntoKarazhanD = {
		ZoneName = { BZ["Return to Karazhan"]..ALC["MapD"] },
		Location = { BZ["Deadwind Pass"] },
		DungeonHeroicID = 1475, -- 1474: Upper Return to Karazhan, 1475: Lower Return to Karazhan
		DungeonMythicID = 1475,
		--DungeonLevel = 1,
		WorldMapID = 809,
		JournalInstanceID = 860,
		LevelRange = "110",
		MinLevel = "110",
		PlayerLimit = { 5 },
		--MinGearLevel = "825",
		Module = "Atlas_Legion",
		PrevMap = "ReturntoKarazhanC",
		NextMap = "ReturntoKarazhanE",
		{ BLUE.." F-H) "..ALC["Connection"],                                10001 },
		{ BLUE.." I) "..format(ALC["Portal to %s"], ALC["Entrance"]),       10002 },
		{ GREN.." 5') "..Atlas:GetCreatureName(L["Koren"], 114815),         114815 },
		{ WHIT.." 6) "..Atlas_GetBossName("Attumen the Huntsman", 1835),    1835 },
		{ WHIT..INDENT..Atlas_GetBossName("Midnight", 1835, 2) },
		{ GREN.." 6') "..Atlas:GetCreatureName(L["Soul Fragment"], 115101), 115101 },
	},
	ReturntoKarazhanE = {
		ZoneName = { BZ["Return to Karazhan"]..ALC["MapE"] },
		Location = { BZ["Deadwind Pass"] },
		DungeonHeroicID = 1475, -- 1474: Upper Return to Karazhan, 1475: Lower Return to Karazhan
		DungeonMythicID = 1475,
		--DungeonLevel = 9,
		WorldMapID = 817,
		JournalInstanceID = 860,
		LevelRange = "110",
		MinLevel = "110",
		PlayerLimit = { 5 },
		--MinGearLevel = "825",
		Module = "Atlas_Legion",
		PrevMap = "ReturntoKarazhanD",
		NextMap = "ReturntoKarazhanF",
		{ BLUE.." C) "..ALC["Connection"],                                                                                  10001 },
		{ WHIT.." 7) "..Atlas_GetBossName("The Curator", 1836)..ALC["L-Parenthesis"]..ALC["Wanders"]..ALC["R-Parenthesis"], 1836 },
		{ GREN.." 7') "..Atlas:GetCreatureName(L["Soul Fragment"], 115113),                                                 115113 },
		{ BLUE.." J) "..format(ALC["Portal to %s"], BZ["Guardian's Library"]),                                              10003 },
	},
	ReturntoKarazhanF = {
		ZoneName = { BZ["Return to Karazhan"]..ALC["MapF"] },
		Location = { BZ["Deadwind Pass"] },
		DungeonHeroicID = 1474, -- 1474: Upper Return to Karazhan, 1475: Lower Return to Karazhan
		DungeonMythicID = 1474,
		--DungeonLevel = 10,
		WorldMapID = 818,
		JournalInstanceID = 860,
		LevelRange = "110",
		MinLevel = "110",
		PlayerLimit = { 5 },
		--MinGearLevel = "825",
		Module = "Atlas_Legion",
		PrevMap = "ReturntoKarazhanE",
		NextMap = "ReturntoKarazhanG",
		{ BLUE.." J) "..ALC["Portal"],                              10001 },
		{ WHIT.." 8) "..Atlas_GetBossName("Shade of Medivh", 1817), 1817 },
		{ BLUE.." K) "..ALC["Portal"],                              10002 },
	},
	ReturntoKarazhanG = {
		ZoneName = { BZ["Return to Karazhan"]..ALC["MapG"] },
		Location = { BZ["Deadwind Pass"] },
		DungeonHeroicID = 1474, -- 1474: Upper Return to Karazhan, 1475: Lower Return to Karazhan
		DungeonMythicID = 1474,
		--DungeonLevel = 11,
		WorldMapID = 819,
		JournalInstanceID = 860,
		LevelRange = "110",
		MinLevel = "110",
		PlayerLimit = { 5 },
		--MinGearLevel = "825",
		Module = "Atlas_Legion",
		PrevMap = "ReturntoKarazhanF",
		NextMap = "ReturntoKarazhanH",
		{ BLUE.." K) "..ALC["Entrance"],                          10001 },
		{ GREN.." 8') "..L["Medivh's Footlocker"],                266826 }, -- object
		{ WHIT.." 9) "..Atlas_GetBossName("Mana Devourer", 1818), 1818 },
	},
	ReturntoKarazhanH = {
		ZoneName = { BZ["Return to Karazhan"]..ALC["MapH"] },
		Location = { BZ["Deadwind Pass"] },
		DungeonHeroicID = 1474, -- 1474: Upper Return to Karazhan, 1475: Lower Return to Karazhan
		DungeonMythicID = 1474,
		--DungeonLevel = 12,
		WorldMapID = 820,
		JournalInstanceID = 860,
		LevelRange = "110",
		MinLevel = "110",
		PlayerLimit = { 5 },
		--MinGearLevel = "825",
		Module = "Atlas_Legion",
		PrevMap = "ReturntoKarazhanG",
		NextMap = "ReturntoKarazhanI",
		{ BLUE.." L) "..ALC["Entrance"],                                                                      10001 },
		{ GREN.." 9') ",                                                                                      143537, "item", "Mana Focus" }, -- quest of Return to Karazhan: Cubic Cynosure, 45238
		{ BLUE.." M) "..ALC["Connection"],                                                                    10002 },
		{ BLUE.." N) "..format(ALC["Portal to %s"], ALC["Entrance"]).."\n"..INDENT..GREY..ALC["Upper floor"], 10003 },
		{ INDENT..GREY..ALC["Upper floor"] },
	},
	ReturntoKarazhanI = {
		ZoneName = { BZ["Return to Karazhan"]..ALC["MapI"] },
		Location = { BZ["Deadwind Pass"] },
		DungeonHeroicID = 1474, -- 1474: Upper Return to Karazhan, 1475: Lower Return to Karazhan
		DungeonMythicID = 1474,
		--DungeonLevel = 14,
		WorldMapID = 822,
		JournalInstanceID = 860,
		LevelRange = "110",
		MinLevel = "110",
		PlayerLimit = { 5 },
		--MinGearLevel = "825",
		Module = "Atlas_Legion",
		PrevMap = "ReturntoKarazhanH",
		{ BLUE.." M) "..ALC["Connection"],                                                                                                     10001 },
		{ WHIT.."10) "..Atlas_GetBossName("Viz'aduum the Watcher", 1838),                                                                      1838 },
		{ GREN.." 9') "..Atlas:GetCreatureName(L["Archmage Khadgar"], 115497).."\n"..INDENT..WHIT..format(ALC["Portal to %s"], BZ["Dalaran"]), 115497 },
		{ INDENT..WHIT..format(ALC["Portal to %s"], BZ["Dalaran"]) },
	},
	TheArcwayEnt = {
		ZoneName = { BZ["The Arcway"]..ALC["L-Parenthesis"]..ALC["Entrance"]..ALC["R-Parenthesis"] },
		Location = { BZ["Sanctum of Order"] },
		DungeonHeroicID = 1190,
		DungeonMythicID = 1190,
		JournalInstanceID = 726,
		Module = "Atlas_Legion",
		NextMap = "TheArcway",
		{ WHIT..ALC["Upper"] },
		{ INDENT..BLUE.." A) "..BZ["The Grand Promenade"],                                                                                                 10001 },
		{ INDENT..PURP.." A) "..ALC["Transport"],                                                                                                          10005 },
		{ WHIT..ALC["Lower"] },
		{ INDENT..BLUE.." B) "..BZ["Terrace of Order"],                                                                                                    10002 },
		{ INDENT..BLUE.." C) "..BZ["The Arcway"],                                                                                                          10003 },
		{ INDENT..BLUE.." D) "..BZ["The Nighthold"],                                                                                                       10004 },
		{ INDENT..PURP.." A) "..ALC["Transport"],                                                                                                          10005 },
		{ INDENT..PURP.." B) "..L["Portal to Shal'Aran"],                                                                                                  10006 },
		{ INDENT..WHIT.." 1) "..ALC["Meeting Stone"],                                                                                                      10007 },
		{ INDENT..GREN.." 1') "..Atlas:GetCreatureName(L["First Arcanist Thalyssra"], 115366).."\n"..Atlas:GetCreatureName(L["Archmage Khadgar"], 115367), 115366 },
		{ INDENT..INDENT..GREN..Atlas:GetCreatureName(L["Archmage Khadgar"], 115367),                                                                      115367 },
	},
	TheArcway = {
		ZoneName = { BZ["The Arcway"] },
		Location = { BZ["Suramar"] },
		DungeonHeroicID = 1190,
		DungeonMythicID = 1190,
		WorldMapID = 749,
		JournalInstanceID = 726,
		Module = "Atlas_Legion",
		PrevMap = "TheArcwayEnt",
		{ BLUE.." A) "..ALC["Entrance"],                                  10001 },
		{ WHIT.." 1) "..Atlas_GetBossName("Ivanyr", 1497),                1497 },
		{ WHIT.." 2) "..Atlas_GetBossName("Corstilax", 1498),             1498 },
		{ WHIT.." 3) "..Atlas_GetBossName("General Xakal", 1499),         1499 },
		{ WHIT.." 4) "..Atlas_GetBossName("Nal'tira", 1500),              1500 },
		{ WHIT.." 5) "..Atlas_GetBossName("Advisor Vandros", 1501),       1501 },
		{ ORNG.." 1) "..Atlas:GetCreatureName(L["The Rat King"], 111057), 111057 },
		{ ORNG.." 2) "..Atlas:GetCreatureName(L["Sludge Face"], 111021),  111021 },
		{ GREN.." 1') ",                                                  138394,    "item", L["Suramar Leyline Map"] },
		{ "" },
		{ LBLU..ACHIEVEMENTS..ALC["Colon"] },
		{ "Arcanic Cling",                                                "ac=10773" },
		{ "Clean House",                                                  "ac=10775" },
		{ "No Time to Waste",                                             "ac=10776" },
		{ "Mythic: The Arcway",                                           "ac=10813" },
		{ "Mythic: The Arcway Guild Run",                                 "ac=10864" },
	},
	--    [1094] = { mapFile = "NightmareRaid", [1] = 777, [2] = 778, [3] = 779, [4] = 780, [5] = 781, [6] = 782, [7] = 783, [8] = 784, [9] = 785, [10] = 786, [11] = 787, [12] = 788, [13] = 789},
	TheEmeraldNightmareA = {
		ZoneName = { BZ["The Emerald Nightmare"]..ALC["MapA"] },
		Location = { BZ["Val'sharah"] },
		DungeonID = 1348,
		DungeonHeroicID = 1349,
		DungeonMythicID = 1350,
		WorldMapID = 777,
		--DungeonLevel = 1,
		JournalInstanceID = 768,
		PlayerLimit = { 10, 20, 25, 30 },
		--MinGearLevel = "825",
		Module = "Atlas_Legion",
		NextMap = "TheEmeraldNightmareB",
		{ BLUE.." A) "..ALC["Entrance"],                      10001 },
		{ BLUE.." B) "..ALC["Connection"],                    10002 },
		{ WHIT.." 1) "..Atlas_GetBossName("Nythendra", 1703), 1703 },
		{ GREN.." 1') "..L["Nightmare Watcher"],              10003 },
		{ "" },
		{ LBLU..ACHIEVEMENTS..ALC["Colon"] },
		{ "Darkbough",                                        "ac=10818" },
		{ "Buggy Fight",                                      "ac=10555" },
		{ "Mythic: Nythendra",                                "ac=10821" },
		{ "The Emerald Nightmare Guild Run",                  "ac=10866" },
	},
	TheEmeraldNightmareB = {
		ZoneName = { BZ["The Emerald Nightmare"]..ALC["MapB"] },
		Location = { BZ["Core of the Nightmare"] },
		DungeonID = 1348,
		DungeonHeroicID = 1349,
		DungeonMythicID = 1350,
		WorldMapID = 778,
		--DungeonLevel = 2,
		JournalInstanceID = 768,
		PlayerLimit = { 10, 20, 25, 30 },
		--MinGearLevel = "825",
		Module = "Atlas_Legion",
		PrevMap = "TheEmeraldNightmareA",
		NextMap = "TheEmeraldNightmareC",
		{ BLUE.." B) "..ALC["Connection"],                                        10002 },
		{ BLUE.." C) "..ALC["Portal"]..ALC["Colon"]..BZ["Un'Goro Crater"],        10003 },
		{ BLUE.." D) "..ALC["Portal"]..ALC["Colon"]..BZ["Mulgore"],               10004 },
		{ BLUE.." E) "..ALC["Portal"]..ALC["Colon"]..BZ["Grizzly Hills"],         10005 },
		{ BLUE.." F) "..ALC["Portal"]..ALC["Colon"]..BZ["The Emerald Dreamway"],  10006 },
		{ GREN.." 1') "..Atlas:GetCreatureName(L["Malfurion Stormrage"], 106482), 106482 },
		{ INDENT..GREY..L["Teleport to Moonglade"] },
	},
	TheEmeraldNightmareC = {
		ZoneName = { BZ["The Emerald Nightmare"]..ALC["MapC"] },
		Location = { BZ["Un'Goro Crater"] },
		DungeonID = 1348,
		DungeonHeroicID = 1349,
		DungeonMythicID = 1350,
		WorldMapID = 780,
		--DungeonLevel = 4,
		JournalInstanceID = 768,
		PlayerLimit = { 10, 20, 25, 30 },
		--MinGearLevel = "825",
		Module = "Atlas_Legion",
		PrevMap = "TheEmeraldNightmareB",
		NextMap = "TheEmeraldNightmareD",
		{ BLUE.." C) "..ALC["Portal"],                                             10003 },
		{ WHIT.." 2) "..Atlas_GetBossName("Il'gynoth, Heart of Corruption", 1738), 1738 },
		{ "" },
		{ LBLU..ACHIEVEMENTS..ALC["Colon"] },
		{ "Darkbough",                                                             "ac=10818" },
		{ "Took the Red Eye Down",                                                 "ac=10830" },
		{ "Mythic: Il'gynoth",                                                     "ac=10823" },
		{ "The Emerald Nightmare Guild Run",                                       "ac=10866" },
	},
	TheEmeraldNightmareD = {
		ZoneName = { BZ["The Emerald Nightmare"]..ALC["MapD"] },
		Location = { BZ["Mulgore"] },
		DungeonID = 1348,
		DungeonHeroicID = 1349,
		DungeonMythicID = 1350,
		WorldMapID = 779,
		--DungeonLevel = 3,
		JournalInstanceID = 768,
		PlayerLimit = { 10, 20, 25, 30 },
		--MinGearLevel = "825",
		Module = "Atlas_Legion",
		PrevMap = "TheEmeraldNightmareC",
		NextMap = "TheEmeraldNightmareE",
		{ BLUE.." D) "..ALC["Portal"],                                10004 },
		{ WHIT.." 3) "..Atlas_GetBossName("Elerethe Renferal", 1744), 1744 },
		{ "" },
		{ LBLU..ACHIEVEMENTS..ALC["Colon"] },
		{ "Darkbough",                                                "ac=10818" },
		{ "Webbing Crashers",                                         "ac=10771" },
		{ "Mythic: Elerethe Renferal",                                "ac=10822" },
		{ "The Emerald Nightmare Guild Run",                          "ac=10866" },
	},
	TheEmeraldNightmareE = {
		ZoneName = { BZ["The Emerald Nightmare"]..ALC["MapE"] },
		Location = { BZ["Grizzly Hills"] },
		DungeonID = 1348,
		DungeonHeroicID = 1349,
		DungeonMythicID = 1350,
		WorldMapID = 786,
		--DungeonLevel = 10,
		JournalInstanceID = 768,
		PlayerLimit = { 10, 20, 25, 30 },
		--MinGearLevel = "825",
		Module = "Atlas_Legion",
		PrevMap = "TheEmeraldNightmareD",
		NextMap = "TheEmeraldNightmareF",
		{ BLUE.." E) "..ALC["Portal"],                    10005 },
		{ WHIT.." 4) "..Atlas_GetBossName("Ursoc", 1667), 1667 },
		{ "" },
		{ LBLU..ACHIEVEMENTS..ALC["Colon"] },
		{ "Tormented Guardians",                          "ac=10819" },
		{ "Scare Bear",                                   "ac=10753" },
		{ "Mythic: Ursoc",                                "ac=10824" },
		{ "The Emerald Nightmare Guild Run",              "ac=10866" },
	},
	TheEmeraldNightmareF = {
		ZoneName = { BZ["The Emerald Nightmare"]..ALC["MapF"] },
		Location = { BZ["The Emerald Dreamway"] },
		DungeonID = 1348,
		DungeonHeroicID = 1349,
		DungeonMythicID = 1350,
		WorldMapID = 781,
		--DungeonLevel = 5,
		JournalInstanceID = 768,
		PlayerLimit = { 10, 20, 25, 30 },
		--MinGearLevel = "825",
		Module = "Atlas_Legion",
		PrevMap = "TheEmeraldNightmareE",
		NextMap = "TheEmeraldNightmareG",
		{ BLUE.." F) "..ALC["Portal"],                                   10006 },
		{ WHIT.." 5) "..Atlas_GetBossName("Dragons of Nightmare", 1704), 1704 },
		{ "" },
		{ LBLU..ACHIEVEMENTS..ALC["Colon"] },
		{ "Tormented Guardians",                                         "ac=10819" },
		{ "Imagined Dragons World Tour",                                 "ac=10663" },
		{ "Mythic: Dragons of Nightmare",                                "ac=10825" },
		{ "The Emerald Nightmare Guild Run",                             "ac=10866" },
	},
	TheEmeraldNightmareG = {
		ZoneName = { BZ["The Emerald Nightmare"]..ALC["MapG"] },
		Location = { BZ["Moonglade"] },
		DungeonID = 1348,
		DungeonHeroicID = 1349,
		DungeonMythicID = 1350,
		WorldMapID = 787,
		--DungeonLevel = 11,
		JournalInstanceID = 768,
		PlayerLimit = { 10, 20, 25, 30 },
		--MinGearLevel = "825",
		Module = "Atlas_Legion",
		PrevMap = "TheEmeraldNightmareF",
		NextMap = "TheEmeraldNightmareH",
		{ BLUE.." G) "..ALC["Portal"],                       10007 },
		{ WHIT.." 6) "..Atlas_GetBossName("Cenarius", 1750), 1750 },
		{ "" },
		{ LBLU..ACHIEVEMENTS..ALC["Colon"] },
		{ "Tormented Guardians",                             "ac=10819" },
		{ "Use the Force(s)",                                "ac=10772" },
		{ "I Attack the Darkness",                           "ac=10755" },
		{ "Mythic: Cenarius",                                "ac=10826" },
		{ "The Emerald Nightmare Guild Run",                 "ac=10866" },
	},
	TheEmeraldNightmareH = {
		ZoneName = { BZ["The Emerald Nightmare"]..ALC["MapH"] },
		Location = { BZ["Rift of Aln"] },
		DungeonID = 1348,
		DungeonHeroicID = 1349,
		DungeonMythicID = 1350,
		WorldMapID = 788,
		--DungeonLevel = 12,
		JournalInstanceID = 768,
		PlayerLimit = { 10, 20, 25, 30 },
		--MinGearLevel = "825",
		Module = "Atlas_Legion",
		PrevMap = "TheEmeraldNightmareG",
		{ WHIT.." 7) "..Atlas_GetBossName("Xavius", 1726), 1726 },
		{ "" },
		{ LBLU..ACHIEVEMENTS..ALC["Colon"] },
		{ "Rift of Aln",                                   "ac=10820" },
		{ "Ahead of the Curve: Xavius",                    "ac=11194" },
		{ "Cutting Edge: Xavius",                          "ac=11191" },
		{ "Mythic: Xavius",                                "ac=10827" },
		{ "Mythic: Xavius Guild Run",                      "ac=11238" },
		{ "The Emerald Nightmare Guild Run",               "ac=10866" },
	},
	TheNightholdEnt = {
		ZoneName = { BZ["The Nighthold"]..ALC["L-Parenthesis"]..ALC["Entrance"]..ALC["R-Parenthesis"] },
		Location = { BZ["Sanctum of Order"] },
		DungeonID = 1351,
		DungeonHeroicID = 1352,
		DungeonMythicID = 1353,
		JournalInstanceID = 786,
		PlayerLimit = { 10, 20, 25, 30 },
		Module = "Atlas_Legion",
		NextMap = "TheNightholdA",
		{ WHIT..ALC["Upper"] },
		{ INDENT..BLUE.." A) "..BZ["The Grand Promenade"],                                                                                                 10001 },
		{ INDENT..PURP.." A) "..ALC["Transport"],                                                                                                          10005 },
		{ WHIT..ALC["Lower"] },
		{ INDENT..BLUE.." B) "..BZ["Terrace of Order"],                                                                                                    10002 },
		{ INDENT..BLUE.." C) "..BZ["The Arcway"],                                                                                                          10003 },
		{ INDENT..BLUE.." D) "..BZ["The Nighthold"],                                                                                                       10004 },
		{ INDENT..PURP.." A) "..ALC["Transport"],                                                                                                          10005 },
		{ INDENT..PURP.." B) "..L["Portal to Shal'Aran"],                                                                                                  10006 },
		{ INDENT..WHIT.." 1) "..ALC["Meeting Stone"],                                                                                                      10007 },
		{ INDENT..GREN.." 1') "..Atlas:GetCreatureName(L["First Arcanist Thalyssra"], 115366).."\n"..Atlas:GetCreatureName(L["Archmage Khadgar"], 115367), 115366 },
		{ INDENT..INDENT..GREN..Atlas:GetCreatureName(L["Archmage Khadgar"], 115367),                                                                      115367 },
	},
	--    [1088] = { mapFile = "SuramarRaid", [1] = 764, [2] = 765, [3] = 766, [4] = 767, [5] = 768, [6] = 769, [7] = 770, [8] = 771, [9] = 772},
	TheNightholdA = {
		ZoneName = { BZ["The Nighthold"]..ALC["MapA"] },
		Location = { BZ["Suramar"] },
		DungeonID = 1351,
		DungeonHeroicID = 1352,
		DungeonMythicID = 1353,
		WorldMapID = 764,
		--DungeonLevel = 1,
		JournalInstanceID = 786,
		PlayerLimit = { 10, 20, 25, 30 },
		--MinGearLevel = "835",
		Module = "Atlas_Legion",
		PrevMap = "TheNightholdEnt",
		NextMap = "TheNightholdB",
		{ BLUE.." A) "..ALC["Entrance"],                                                                                                           10001 },
		{ BLUE.." B-C) "..ALC["Connection"],                                                                                                       10002 },
		{ WHIT.." 1) "..Atlas_GetBossName("Skorpyron", 1706),                                                                                      1706 },
		{ WHIT.." 2) "..Atlas_GetBossName("Chronomatic Anomaly", 1725)..ALC["L-Parenthesis"]..ALC["Wanders"]..ALC["R-Parenthesis"],                1725 },
		{ WHIT.." 3) "..Atlas_GetBossName("Trilliax", 1731),                                                                                       1731 },
		{ GREN.." 1') "..Atlas:GetCreatureName(L["First Arcanist Thalyssra"], 110791).."\n"..Atlas:GetCreatureName(L["Archmage Khadgar"], 110792), 110791 },
		{ INDENT..GREN..Atlas:GetCreatureName(L["Archmage Khadgar"], 110792) },
		--		{ GREY..INDENT..L["Teleport to Tichondrius / Grand Magistrix Elisande"] },
		{ "" },
		{ LBLU..ACHIEVEMENTS..ALC["Colon"] },
		{ "Cage Rematch",                                                                                                                          "ac=10678" },
		{ "Grand Opening",                                                                                                                         "ac=10697" },
		{ "Gluten Free",                                                                                                                           "ac=10742" },
		{ "Arcing Aqueducts",                                                                                                                      "ac=10829" },
		{ "Mythic: Skorpyron",                                                                                                                     "ac=10840" },
		{ "Mythic: Chronomatic Anomaly",                                                                                                           "ac=10842" },
		{ "Mythic: Trilliax",                                                                                                                      "ac=10843" },
		{ "The Nighthold Guild Run",                                                                                                               "ac=10868" },
	},
	TheNightholdB = {
		ZoneName = { BZ["The Nighthold"]..ALC["MapB"] },
		Location = { BZ["Suramar"] },
		DungeonID = 1351,
		DungeonHeroicID = 1352,
		DungeonMythicID = 1353,
		WorldMapID = 766,
		--DungeonLevel = 3,
		JournalInstanceID = 786,
		PlayerLimit = { 10, 20, 25, 30 },
		--MinGearLevel = "835",
		Module = "Atlas_Legion",
		PrevMap = "TheNightholdA",
		NextMap = "TheNightholdC",
		{ BLUE.." A) "..ALC["Entrance"],                                                                                                                                   10001 },
		{ BLUE.." C-J) "..ALC["Connection"],                                                                                                                               10002 },
		{ BLUE.." F/H) "..ALC["Connection"]..ALC["L-Parenthesis"]..ALC["Upper"]..ALC["R-Parenthesis"],                                                                     10002 },
		{ BLUE.." K) "..ALC["Portal"],                                                                                                                                     10003 },
		{ INDENT..GREY..format(ALC["Portal to %s"], BZ["The Nightspire"])..ALC["L-Parenthesis"]..Atlas_GetBossName("Grand Magistrix Elisande", 1743)..ALC["R-Parenthesis"] },
		{ INDENT..GREY..format(ALC["Portal to %s"], BZ["The Font of Night"])..ALC["L-Parenthesis"]..Atlas_GetBossName("Gul'dan", 1737)..ALC["R-Parenthesis"] },
		{ WHIT.." 4) "..Atlas_GetBossName("Spellblade Aluriel", 1751)..ALC["L-Parenthesis"]..ALC["Wanders"]..ALC["R-Parenthesis"],                                         1751 },
		{ WHIT.." 6) "..Atlas_GetBossName("High Botanist Tel'arn", 1761),                                                                                                  1761 },
		{ WHIT.." 8) "..Atlas_GetBossName("Krosus", 1713),                                                                                                                 1713 },
		{ WHIT.." 10) "..Atlas_GetBossName("Gul'dan", 1737)..ALC["L-Parenthesis"]..ALC["Upper"]..ALC["R-Parenthesis"],                                                     1737 },
		{ ORNG.." 1) "..Atlas:GetCreatureName(L["Gilded Guardian"], 112712),                                                                                               112712 },
		{ ORNG.." 2) "..Atlas:GetCreatureName(L["Flightmaster Volnath"], 116004),                                                                                          116004 },
		{ GREN.." 2') "..Atlas:GetCreatureName(L["Ly'leth Lunastre"], 117085),                                                                                             117085 },
		{ "" },
		{ LBLU..ACHIEVEMENTS..ALC["Colon"] },
		{ "A Change In Scenery",                                                                                                                                           "ac=10817" },
		{ "Burning Bridges",                                                                                                                                               "ac=10575" },
		{ "Fruit of All Evil",                                                                                                                                             "ac=10754" },
		{ "Nightspire",                                                                                                                                                    "ac=10838" },
		{ "Royal Athenaeum",                                                                                                                                               "ac=10837" },
		{ "Betrayer's Rise",                                                                                                                                               "ac=10839" },
		{ "I've Got My Eyes On You",                                                                                                                                       "ac=10696" },
		{ "Mythic: Spellblade Aluriel",                                                                                                                                    "ac=10844" },
		{ "Mythic: Krosus",                                                                                                                                                "ac=10848" },
		{ "Mythic: High Botanist Tel'arn",                                                                                                                                 "ac=10846" },
		{ "Mythic: Gul'dan",                                                                                                                                               "ac=10850" },
		{ "Mythic: Gul'dan Guild Run",                                                                                                                                     "ac=11239" },
		{ "Cutting Edge: Gul'dan",                                                                                                                                         "ac=11192" },
		{ "Ahead of the Curve: Gul'dan",                                                                                                                                   "ac=11195" },
		{ "The Nighthold Guild Run",                                                                                                                                       "ac=10868" },
	},
	TheNightholdC = {
		ZoneName = { BZ["The Nighthold"]..ALC["MapC"] },
		Location = { BZ["Suramar"] },
		DungeonID = 1351,
		DungeonHeroicID = 1352,
		DungeonMythicID = 1353,
		WorldMapID = 769,
		--DungeonLevel = 6,
		JournalInstanceID = 786,
		PlayerLimit = { 10, 20, 25, 30 },
		--MinGearLevel = "835",
		Module = "Atlas_Legion",
		PrevMap = "TheNightholdB",
		NextMap = "TheNightholdD",
		{ BLUE.." D-E) "..ALC["Connection"],                                                         10001 },
		{ BLUE.." F) "..ALC["Connection"]..ALC["L-Parenthesis"]..ALC["Upper"]..ALC["R-Parenthesis"], 10002 },
		{ WHIT.." 5) "..Atlas_GetBossName("Star Augur Etraeus", 1732),                               1732 },
		{ "" },
		{ LBLU..ACHIEVEMENTS..ALC["Colon"] },
		{ "Elementalry!",                                                                            "ac=10851" },
		{ "Royal Athenaeum",                                                                         "ac=10837" },
		{ "Mythic: Star Augur Etraeus",                                                              "ac=10845" },
		{ "The Nighthold Guild Run",                                                                 "ac=10868" },
	},
	TheNightholdD = {
		ZoneName = { BZ["The Nighthold"]..ALC["MapD"] },
		Location = { BZ["Suramar"] },
		DungeonID = 1351,
		DungeonHeroicID = 1352,
		DungeonMythicID = 1353,
		WorldMapID = 768,
		--DungeonLevel = 5,
		JournalInstanceID = 786,
		PlayerLimit = { 10, 20, 25, 30 },
		--MinGearLevel = "835",
		Module = "Atlas_Legion",
		PrevMap = "TheNightholdC",
		NextMap = "TheNightholdE",
		{ BLUE.." G-H) "..ALC["Connection"],                    10002 },
		{ WHIT.." 7) "..Atlas_GetBossName("Tichondrius", 1762), 1762 },
		{ "" },
		{ LBLU..ACHIEVEMENTS..ALC["Colon"] },
		{ "Not For You",                                        "ac=10704" },
		{ "Nightspire",                                         "ac=10838" },
		{ "Mythic: Tichondrius",                                "ac=10847" },
		{ "The Nighthold Guild Run",                            "ac=10868" },
	},
	TheNightholdE = {
		ZoneName = { BZ["The Nighthold"]..ALC["MapE"] },
		Location = { BZ["Suramar"] },
		DungeonID = 1351,
		DungeonHeroicID = 1352,
		DungeonMythicID = 1353,
		WorldMapID = 766,
		--DungeonLevel = 3,
		JournalInstanceID = 786,
		PlayerLimit = { 10, 20, 25, 30 },
		--MinGearLevel = "835",
		Module = "Atlas_Legion",
		PrevMap = "TheNightholdD",
		NextMap = "TheNightholdF",
		{ BLUE.." I-J) "..ALC["Connection"],                                                                                                                               10001 },
		{ BLUE.." K) "..ALC["Portal"],                                                                                                                                     10002 },
		{ INDENT..GREY..format(ALC["Portal to %s"], BZ["The Nightspire"])..ALC["L-Parenthesis"]..Atlas_GetBossName("Grand Magistrix Elisande", 1743)..ALC["R-Parenthesis"] },
		{ INDENT..GREY..format(ALC["Portal to %s"], BZ["The Font of Night"])..ALC["L-Parenthesis"]..Atlas_GetBossName("Gul'dan", 1737)..ALC["R-Parenthesis"] },
	},
	TheNightholdF = {
		ZoneName = { BZ["The Nighthold"]..ALC["MapF"] },
		Location = { BZ["Suramar"] },
		DungeonID = 1351,
		DungeonHeroicID = 1352,
		DungeonMythicID = 1353,
		WorldMapID = 770,
		--DungeonLevel = 7,
		JournalInstanceID = 786,
		PlayerLimit = { 10, 20, 25, 30 },
		--MinGearLevel = "835",
		Module = "Atlas_Legion",
		PrevMap = "TheNightholdE",
		NextMap = "TheNightholdG",
		{ WHIT.." 9) "..Atlas_GetBossName("Grand Magistrix Elisande", 1743),                                                                                 1743 },
		{ BLUE.." K) "..ALC["Portal"],                                                                                                                       10002 },
		{ INDENT..GREY..format(ALC["Portal to %s"], ALC["Entrance"]) },
		{ INDENT..GREY..format(ALC["Portal to %s"], BZ["The Font of Night"])..ALC["L-Parenthesis"]..Atlas_GetBossName("Gul'dan", 1737)..ALC["R-Parenthesis"] },
		{ "" },
		{ LBLU..ACHIEVEMENTS..ALC["Colon"] },
		{ "Infinitesimal",                                                                                                                                   "ac=10699" },
		{ "Nightspire",                                                                                                                                      "ac=10838" },
		{ "Mythic: Grand Magistrix Elisande",                                                                                                                "ac=10849" },
		{ "The Nighthold Guild Run",                                                                                                                         "ac=10868" },
	},
	TheNightholdG = {
		ZoneName = { BZ["The Nighthold"]..ALC["MapG"] },
		Location = { BZ["Suramar"] },
		DungeonID = 1351,
		DungeonHeroicID = 1352,
		DungeonMythicID = 1353,
		WorldMapID = 772,
		--DungeonLevel = 9,
		JournalInstanceID = 786,
		PlayerLimit = { 10, 20, 25, 30 },
		--MinGearLevel = "835",
		Module = "Atlas_Legion",
		PrevMap = "TheNightholdF",
		{ WHIT.." 10) "..Atlas_GetBossName("Gul'dan", 1737), 1737 },
		{ "" },
		{ LBLU..ACHIEVEMENTS..ALC["Colon"] },
		{ "Mythic: Gul'dan",                                 "ac=10850" },
		{ "Mythic: Gul'dan Guild Run",                       "ac=11239" },
		{ "Cutting Edge: Gul'dan",                           "ac=11192" },
		{ "Ahead of the Curve: Gul'dan",                     "ac=11195" },
		{ "The Nighthold Guild Run",                         "ac=10868" },
	},
	TheSeatoftheTriumvirate = {
		ZoneName = { BZ["The Seat of the Triumvirate"] },
		Location = { BZ["Mac'Aree"] },
		DungeonHeroicID = 1535,
		DungeonMythicID = 1535,
		WorldMapID = 903,
		JournalInstanceID = 945,
		Module = "Atlas_Legion",
		{ BLUE.." A) "..ALC["Entrance"],                                10001 },
		{ WHIT.." 1) "..Atlas_GetBossName("Zuraal the Ascended", 1979), 1979 },
		{ WHIT.." 1) "..Atlas_GetBossName("Saprish", 1980),             1980 },
		{ WHIT.." 1) "..Atlas_GetBossName("Viceroy Nezhar", 1981),      1981 },
		{ WHIT.." 1) "..Atlas_GetBossName("L'ura", 1982),               1982 },
	},
	--    [1147] = { mapFile = "TombRaid", [1] = 850, [2] = 851, [3] = 852, [4] = 853, [5] = 854, [6] = 855, [7] = 856},
	TombofSargerasA = {
		ZoneName = { BZ["Tomb of Sargeras"]..ALC["MapA"], BZ["Tomb of Sargeras"] },
		Location = { BZ["Broken Shore"] },
		DungeonID = 1525,
		DungeonHeroicID = 1526,
		DungeonMythicID = 1527,
		WorldMapID = 850,
		--DungeonLevel = 1,
		JournalInstanceID = 875,
		Module = "Atlas_Legion",
		PlayerLimit = { 10, 20, 25, 30 },
		--MinGearLevel = "840",
		NextMap = "TombofSargerasB",
		{ BLUE.." A) "..ALC["Entrance"],                                10001 },
		{ BLUE.." B) "..ALC["Connection"],                              10002 },
		{ WHIT.." 1) "..Atlas_GetBossName("Goroth", 1862),              1862 },
		{ WHIT.." 2) "..Atlas_GetBossName("Demonic Inquisition", 1867), 1867 },
		{ "" },
		{ LBLU..ACHIEVEMENTS..ALC["Colon"] },
		{ "The Gates of Hell",                                          "ac=11787" },
		{ "Wailing Halls",                                              "ac=11788" },
		{ "Mythic: Goroth",                                             "ac=11767" },
		{ "Mythic: Demonic Inquisition",                                "ac=11774" },
		{ "Tomb of Sargeras Guild Run",                                 "ac=11782" },
		{ "Mythic: Kil'jaeden Guild Run",                               "ac=11784" },
	},
	TombofSargerasB = {
		ZoneName = { BZ["Tomb of Sargeras"]..ALC["MapB"], BZ["Tomb of Sargeras"] },
		Location = { BZ["Broken Shore"] },
		DungeonID = 1525,
		DungeonHeroicID = 1526,
		DungeonMythicID = 1527,
		WorldMapID = 852,
		--DungeonLevel = 3,
		JournalInstanceID = 875,
		Module = "Atlas_Legion",
		PrevMap = "TombofSargerasA",
		PlayerLimit = { 10, 20, 25, 30 },
		--MinGearLevel = "840",
		NextMap = "TombofSargerasC",
		{ BLUE.." B-C) "..ALC["Connection"],                            10001 },
		{ WHIT.." 4) "..Atlas_GetBossName("Sisters of the Moon", 1903), 1903 },
		{ WHIT.." 6) "..Atlas_GetBossName("The Desolate Host", 1896),   1896 },
		{ "" },
		{ LBLU..ACHIEVEMENTS..ALC["Colon"] },
		{ "Wailing Halls",                                              "ac=11788" },
		{ "Mythic: Sisters of the Moon",                                "ac=11777" },
		{ "Mythic: The Desolate Host",                                  "ac=11778" },
		{ "Tomb of Sargeras Guild Run",                                 "ac=11782" },
		{ "Mythic: Kil'jaeden Guild Run",                               "ac=11784" },
	},
	TombofSargerasC = {
		ZoneName = { BZ["Tomb of Sargeras"]..ALC["MapC"], BZ["Tomb of Sargeras"] },
		Location = { BZ["Broken Shore"] },
		DungeonID = 1525,
		DungeonHeroicID = 1526,
		DungeonMythicID = 1527,
		WorldMapID = 851,
		--DungeonLevel = 2,
		JournalInstanceID = 875,
		Module = "Atlas_Legion",
		PrevMap = "TombofSargerasB",
		PlayerLimit = { 10, 20, 25, 30 },
		--MinGearLevel = "840",
		NextMap = "TombofSargerasD",
		{ BLUE.." C-D) "..ALC["Connection"],                 10001 },
		{ WHIT.." 3) "..Atlas_GetBossName("Harjatan", 1856), 1856 },
		{ "" },
		{ LBLU..ACHIEVEMENTS..ALC["Colon"] },
		{ "The Gates of Hell",                               "ac=11787" },
		{ "Grand Fin-ale",                                   "ac=11699" },
		{ "Mythic: Harjatan",                                "ac=11775" },
		{ "Tomb of Sargeras Guild Run",                      "ac=11782" },
		{ "Mythic: Kil'jaeden Guild Run",                    "ac=11784" },
	},
	TombofSargerasD = {
		ZoneName = { BZ["Tomb of Sargeras"]..ALC["MapD"], BZ["Tomb of Sargeras"] },
		Location = { BZ["Broken Shore"] },
		DungeonID = 1525,
		DungeonHeroicID = 1526,
		DungeonMythicID = 1527,
		WorldMapID = 851,
		--DungeonLevel = 2,
		JournalInstanceID = 875,
		Module = "Atlas_Legion",
		PrevMap = "TombofSargerasC",
		PlayerLimit = { 10, 20, 25, 30 },
		--MinGearLevel = "840",
		NextMap = "TombofSargerasE",
		{ BLUE.." D) "..ALC["Connection"],                             10001 },
		{ WHIT.." 5) "..Atlas_GetBossName("Mistress Sassz'ine", 1861), 1861 },
		{ "" },
		{ LBLU..ACHIEVEMENTS..ALC["Colon"] },
		{ "The Gates of Hell",                                         "ac=11787" },
		{ "Mythic: Mistress Sassz'ine",                                "ac=11776" },
		{ "Tomb of Sargeras Guild Run",                                "ac=11782" },
		{ "Mythic: Kil'jaeden Guild Run",                              "ac=11784" },
	},
	TombofSargerasE = {
		ZoneName = { BZ["Tomb of Sargeras"]..ALC["MapE"], BZ["Tomb of Sargeras"] },
		Location = { BZ["Broken Shore"] },
		DungeonID = 1525,
		DungeonHeroicID = 1526,
		DungeonMythicID = 1527,
		WorldMapID = 853,
		--DungeonLevel = 4,
		JournalInstanceID = 875,
		Module = "Atlas_Legion",
		PrevMap = "TombofSargerasD",
		PlayerLimit = { 10, 20, 25, 30 },
		--MinGearLevel = "840",
		NextMap = "TombofSargerasF",
		{ WHIT.." 7) "..Atlas_GetBossName("Maiden of Vigilance", 1897), 1897 },
		{ "" },
		{ LBLU..ACHIEVEMENTS..ALC["Colon"] },
		{ "Chamber of the Avatar",                                      "ac=11789" },
		{ "Mythic: Maiden of Vigilance",                                "ac=11779" },
		{ "Tomb of Sargeras Guild Run",                                 "ac=11782" },
		{ "Mythic: Kil'jaeden Guild Run",                               "ac=11784" },
	},
	TombofSargerasF = {
		ZoneName = { BZ["Tomb of Sargeras"]..ALC["MapF"], BZ["Tomb of Sargeras"] },
		Location = { BZ["Broken Shore"] },
		DungeonID = 1525,
		DungeonHeroicID = 1526,
		DungeonMythicID = 1527,
		WorldMapID = 854,
		--DungeonLevel = 5,
		JournalInstanceID = 875,
		Module = "Atlas_Legion",
		PrevMap = "TombofSargerasE",
		PlayerLimit = { 10, 20, 25, 30 },
		--MinGearLevel = "840",
		NextMap = "TombofSargerasG",
		{ WHIT.." 8) "..Atlas_GetBossName("Fallen Avatar", 1873), 1873 },
		{ "" },
		{ LBLU..ACHIEVEMENTS..ALC["Colon"] },
		{ "Chamber of the Avatar",                                "ac=11789" },
		{ "Mythic: Fallen Avatar",                                "ac=11780" },
		{ "Tomb of Sargeras Guild Run",                           "ac=11782" },
		{ "Mythic: Kil'jaeden Guild Run",                         "ac=11784" },
	},
	TombofSargerasG = {
		ZoneName = { BZ["Tomb of Sargeras"]..ALC["MapG"], BZ["Tomb of Sargeras"] },
		Location = { BZ["Broken Shore"] },
		DungeonID = 1525,
		DungeonHeroicID = 1526,
		DungeonMythicID = 1527,
		WorldMapID = 856,
		--DungeonLevel = 7,
		JournalInstanceID = 875,
		Module = "Atlas_Legion",
		PlayerLimit = { 10, 20, 25, 30 },
		--MinGearLevel = "840",
		PrevMap = "TombofSargerasF",
		{ WHIT.." 9) "..Atlas_GetBossName("Kil'jaeden", 1898), 1898 },
		{ "" },
		{ LBLU..ACHIEVEMENTS..ALC["Colon"] },
		{ "Deceiver's Fall",                                   "ac=11790" },
		{ "Dark Souls",                                        "ac=11770" },
		{ "Mythic: Kil'jaeden",                                "ac=11781" },
		{ "Tomb of Sargeras Guild Run",                        "ac=11782" },
		{ "Mythic: Kil'jaeden Guild Run",                      "ac=11784" },
	},
	--    [1114] = { mapFile = "HelheimRaid", [1] = 807, [2] = 808, [0] = 806},
	TrialofValorA = {
		ZoneName = { BZ["Trial of Valor"]..ALC["MapA"] },
		Location = { BZ["Stormheim"] },
		DungeonID = 1411,
		WorldMapID = 807,
		--DungeonLevel = 2,
		JournalInstanceID = 861,
		PlayerLimit = { 10, 20, 25, 30 },
		Module = "Atlas_Legion",
		NextMap = "TrialofValorB",
		{ BLUE.." A) "..ALC["Entrance"],                    10101 },
		{ WHIT.." 1) "..Atlas_GetBossName("Hymdall", 1485), 10001 },
		{ WHIT.." 2) "..Atlas_GetBossName("Hyrja", 1486),   10002 },
		{ WHIT.." 3) "..Atlas_GetBossName("Odyn", 1819),    1819 },
		{ "" },
		{ LBLU..ACHIEVEMENTS..ALC["Colon"] },
		{ "You Runed Everything!",                          "ac=11337" },
		{ "Mythic: Odyn",                                   "ac=11396" },
		{ "Trial of Valor",                                 "ac=11394" },
		{ "Trial of Valor Guild Run",                       "ac=11403" },
		{ "Heroic: Trial of Valor",                         "ac=11426" },
	},
	TrialofValorB = {
		ZoneName = { BZ["Trial of Valor"]..ALC["MapB"] },
		Location = { BZ["Stormheim"] },
		DungeonID = 1411,
		WorldMapID = 808,
		--DungeonLevel = 3,
		JournalInstanceID = 861,
		PlayerLimit = { 10, 20, 25, 30 },
		Module = "Atlas_Legion",
		PrevMap = "TrialofValorA",
		{ BLUE.." A) "..ALC["Entrance"],                  10101 },
		{ WHIT.." 4) "..Atlas_GetBossName("Guarm", 1830), 1830 },
		{ WHIT.." 5) "..Atlas_GetBossName("Helya", 1829), 1829 },
		{ "" },
		{ LBLU..ACHIEVEMENTS..ALC["Colon"] },
		{ "Cutting Edge: Helya",                          "ac=11580" },
		{ "Ahead of the Curve: Helya",                    "ac=11581" },
		{ "Patient Zero",                                 "ac=11377" },
		{ "The Chosen",                                   "ac=11387" },
		{ "Boneafide Tri Tip",                            "ac=11386" },
		{ "Mythic: Guarm",                                "ac=11397" },
		{ "Mythic: Helya",                                "ac=11398" },
		{ "Realm First! Helya",                           "ac=11405" },
		{ "Mythic: Helya Guild Run",                      "ac=11404" },
		{ "Trial of Valor",                               "ac=11394" },
		{ "Trial of Valor Guild Run",                     "ac=11403" },
		{ "Heroic: Trial of Valor",                       "ac=11426" },
	},
	--    [1045] = { mapFile = "VaultOfTheWardens", [1] = 710, [2] = 711, [3] = 712},
	VaultoftheWardensA = {
		ZoneName = { BZ["Vault of the Wardens"]..ALC["MapA"] },
		Location = { BZ["Azsuna"] },
		DungeonID = 1043,
		DungeonHeroicID = 1044,
		WorldMapID = 710,
		--DungeonLevel = 1,
		JournalInstanceID = 707,
		Module = "Atlas_Legion",
		NextMap = "VaultoftheWardensB",
		{ BLUE.." A) "..ALC["Entrance"],                               10001 },
		{ BLUE.." B) "..ALC["Connection"],                             10002 },
		{ BLUE.." C) "..ALC["Elevator"],                               10003 },
		{ WHIT.." 1) "..Atlas_GetBossName("Tirathon Saltheril", 1467), 1467 },
		{ "" },
		{ LBLU..ACHIEVEMENTS..ALC["Colon"] },
		{ "Vault of the Wardens",                                      "ac=10801" },
		{ "Heroic: Vault of the Wardens",                              "ac=10802" },
		{ "Mythic: Vault of the Wardens",                              "ac=10803" },
		{ "Mythic: Vault of the Wardens Guild Run",                    "ac=10861" },
	},
	VaultoftheWardensB = {
		ZoneName = { BZ["Vault of the Wardens"]..ALC["MapB"] },
		Location = { BZ["Azsuna"] },
		DungeonID = 1043,
		DungeonHeroicID = 1044,
		WorldMapID = 711,
		--DungeonLevel = 2,
		JournalInstanceID = 707,
		Module = "Atlas_Legion",
		PrevMap = "VaultoftheWardensA",
		NextMap = "VaultoftheWardensC",
		{ BLUE.." C-D) "..ALC["Elevator"],                                                    10003 },
		{ WHIT.." 2) "..Atlas_GetBossName("Inquisitor Tormentorum", 1695),                    1695 },
		{ WHIT.." 3) "..Atlas_GetBossName("Ash'golm", 1468),                                  1468 },
		{ WHIT.." 4) "..Atlas_GetBossName("Glazer", 1469),                                    1469 },
		{ ORNG.." 1) "..Atlas:GetCreatureName(L["Grimoira"], 105824),                         105824 },
		{ INDENT..GREY..ALC["L-Parenthesis"]..L["Requires Skaggldrynk"]..ALC["R-Parenthesis"] },
		{ "" },
		{ LBLU..ACHIEVEMENTS..ALC["Colon"] },
		{ "I Ain't Even Cold",                                                                "ac=10679" },
		{ "Vault of the Wardens",                                                             "ac=10801" },
		{ "Heroic: Vault of the Wardens",                                                     "ac=10802" },
		{ "Mythic: Vault of the Wardens",                                                     "ac=10803" },
		{ "Mythic: Vault of the Wardens Guild Run",                                           "ac=10861" },
	},
	VaultoftheWardensC = {
		ZoneName = { BZ["Vault of the Wardens"]..ALC["MapC"] },
		Location = { BZ["Azsuna"] },
		DungeonID = 1043,
		DungeonHeroicID = 1044,
		--Acronym = "";
		WorldMapID = 712,
		--DungeonLevel = 3,
		JournalInstanceID = 707,
		Module = "Atlas_Legion",
		PrevMap = "VaultoftheWardensB",
		{ BLUE.." D) "..ALC["Elevator"],                                           10004 },
		{ WHIT.." 5) "..Atlas_GetBossName("Cordana Felsong", 1470),                1470 },
		{ GREN.." 1') "..L["Fel-Ravaged Tome"],                                    258979 }, -- object
		{ GREN.." 2') "..Atlas:GetCreatureName(L["Drelanim Whisperwind"], 103860), 103860 },
		{ "" },
		{ LBLU..ACHIEVEMENTS..ALC["Colon"] },
		{ "Who's Afraid of the Dark?",                                             "ac=10680" },
		{ "A Specter, Illuminated",                                                "ac=10707" },
		{ "Vault of the Wardens",                                                  "ac=10801" },
		{ "Heroic: Vault of the Wardens",                                          "ac=10802" },
		{ "Mythic: Vault of the Wardens",                                          "ac=10803" },
		{ "Mythic: Vault of the Wardens Guild Run",                                "ac=10861" },
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
	AntorustheBurningThroneA = {
		{ "A", 10001, 476, 414 }, -- Entrance
		{ 1,   1992,  388, 388 }, -- Garothi Worldbreaker
		{ 2,   1987,  189, 364 }, -- Felhounds of Sargeras
		{ 3,   1997,  40,  232 }, -- Antoran High Command
	},
	AntorustheBurningThroneB = {
		{ 3, 1997, 192, 212 }, -- Antoran High Command
	},
	AntorustheBurningThroneC = {
		{ 4, 1985, 202, 250 }, -- Portal Keeper Hasabel
	},
	AntorustheBurningThroneD = {
		{ 5, 2025, 141, 230 }, -- Eonar the Life-Binder
	},
	AntorustheBurningThroneE = {
		{ 6, 2009, 39,  251 }, -- Imonar the Soulhunter
		{ 7, 2004, 414, 250 }, -- Kin'garoth
	},
	AntorustheBurningThroneF = {
		{ 8,  1986, 292, 251 }, -- The Coven of Shivarra
		{ 9,  1983, 291, 300 }, -- Varimathras
		{ 10, 1984, 115, 249 }, -- Aggramar
	},
	AntorustheBurningThroneG = {
		{ 11, 2031, 250, 286 }, -- Argus the Unmaker
	},
	AssaultonVioletHold = {
		{ "A", 10001, 241, 460 }, -- Entrance
		{ 1,   1694,  373, 339 }, -- Shivermaw
		{ 2,   1702,  105, 265 }, -- Blood-Princess Thal'ena
		{ 3,   1693,  123, 141 }, -- Festerface
		{ 4,   1688,  161, 194 }, -- Millificent Manastorm
		{ 5,   1686,  408, 217 }, -- Mindflayer Kaahrj
		{ 6,   1696,  356, 121 }, -- Anub'esset
		{ 7,   1697,  206, 78 }, -- Sael'orn
		{ 8,   1711,  244, 73 }, -- Fel Lord Betrug
	},
	BlackRookHoldA = {
		{ "A",  10001,  130, 34 }, -- Entrance
		{ "B",  10002,  420, 448 }, -- Connection
		{ 1,    1518,   215, 326 }, -- The Amalgam of Souls
		{ 1,    98538,  47,  201 }, -- Lady Velandras Ravencrest
		{ 2,    98521,  308, 188 }, -- Lord Etheldrin Ravencrest
		{ 3,    110993, 351, 423 }, -- Lord Etheldrin Ravencrest
		{ 4,    98637,  466, 439 }, -- Ancient Widow
		{ "1'", 10003,  329, 447 }, -- Torn Page
	},
	BlackRookHoldB = {
		{ "B",  10001,  99,  190 }, -- Connection
		{ "C",  10001,  279, 413 }, -- Connection
		{ "C",  10001,  412, 423 }, -- Connection
		{ "D",  10001,  275, 171 }, -- Connection
		{ 2,    1653,   351, 319 }, -- Illysanna Ravencrest
		{ 5,    111068, 189, 351 }, -- Archmage Galeorn
		{ "2'", 10002,  339, 242 }, -- Worn-Edged Page
		{ "3'", 10003,  151, 296 }, -- Dog-Eared Page
	},
	BlackRookHoldC = {
		{ "D",  10001,  356, 443 }, -- Connection
		{ "E",  10001,  232, 386 }, -- Connection
		{ "E",  10001,  315, 159 }, -- Connection
		{ "F",  10001,  475, 25 }, -- Connection
		{ "G",  10001,  289, 142 }, -- Connection
		{ "G",  10001,  63,  142 }, -- Connection
		{ "H",  10001,  123, 174 }, -- Connection
		{ 6,    112725, 304, 294 }, -- Kalyndras <Rook's Quartermaster>
		{ 7,    111290, 200, 429 }, -- Braxas the Fleshcarver
		{ 8,    111361, 180, 202 }, -- Braxas the Fleshcarver
		{ "4'", 10002,  289, 379 }, -- Singed Page
		{ "5'", 136812, 132, 394 }, -- Dog-Eared Page
		{ "6'", 10003,  342, 176 }, -- Ink-splattered Page
		{ "7'", 10004,  198, 212 }, -- Hastily-Scrawled Page
	},
	BlackRookHoldD = {
		{ "F", 10001, 300, 107 }, -- Connection
		{ "H", 10001, 203, 191 }, -- Connection
		{ 3,   1664,  351, 60 }, -- Smashspite the Hateful
		{ 4,   1672,  158, 171 }, -- Lord Kur'talos Ravencrest
	},
	CathedralofEternalNightA = {
		{ "A", 10001,  249, 487 }, -- Entrance
		{ "B", 10002,  249, 106 }, -- Stairs
		{ "1", 120715, 358, 78 }, -- Raga'yut
	},
	CathedralofEternalNightB = {
		{ "B", 10001, 249, 89 }, -- Stairs
		{ "C", 10001, 249, 390 }, -- Stairs
		{ 1,   1905,  342, 250 }, -- Agronox
	},
	CathedralofEternalNightC = {
		{ "C", 10001, 130, 385 }, -- Stairs
		{ "D", 10001, 130, 141 }, -- Stairs
		{ "D", 10001, 372, 123 }, -- Stairs
		{ "E", 10001, 372, 361 }, -- Stairs
		{ 2,   1906,  130, 249 }, -- Thrashbite the Scornful
	},
	CathedralofEternalNightD = {
		{ "E",  10001,  250, 442 }, -- Stairs
		{ "1'", 129207, 250, 251 }, -- Aegis of Aggramar
		{ 3,    1904,   235, 205 }, -- Domatrax
		{ 4,    1878,   264, 205 }, -- Mephistroth
	},
	CourtofStarsA = {
		{ "A", 10001,  198, 377 }, -- Entrance
		{ "B", 10002,  300, 319 }, -- Connection
		{ "C", 10002,  411, 429 }, -- Connection
		{ 1,   1718,   109, 152 }, -- Patrol Captain Gerdo
		{ 2,   1719,   277, 294 }, -- Talixae Flamewreath
		{ 3,   1720,   429, 446 }, -- Advisor Melandrus
		{ "1", 106468, 292, 310 }, -- Ly'leth Lunastre
		{ 1,   108796, 186, 200 }, -- Arcanist Malrodi
		{ 2,   108740, 286, 392 }, -- Velimar
	},
	CourtofStarsB = {
		{ "B", 10002, 170, 157 }, -- Connection
		{ "C", 10002, 345, 366 }, -- Connection
	},
	DarkheartThicket = {
		{ "A", 10001,  171, 104 }, -- Entrance
		{ "B", 10002,  309, 282 }, -- Connection
		{ "B", 10002,  323, 297 }, -- Connection
		{ 1,   1654,   103, 256 }, -- Arch-Druid Glaidalis
		{ 2,   1655,   209, 201 }, -- Oakheart
		{ 3,   1656,   326, 196 }, -- Dresaron
		{ 4,   1657,   418, 357 }, -- Shade of Xavius
		{ 1,   101660, 70,  111 }, -- Rage Rot
		{ 2,   101641, 127, 175 }, -- Mythana
		{ 3,   99362,  179, 349 }, -- Kudzilla
	},
	EyeofAzshara = {
		{ "A",  10001,  172, 432 }, -- Entrance
		{ 1,    1480,   222, 322 }, -- Warlord Parjesh
		{ 2,    1490,   148, 228 }, -- Lady Hatecoil
		{ 3,    1479,   226, 153 }, -- Serpentrix
		{ 4,    1491,   322, 236 }, -- King Deepbeard
		{ 5,    1492,   232, 250 }, -- Wrath of Azshara
		{ "1'", 248930, 285, 270 }, -- Crate of Corks, Alchemy quest - Put a Cork in It (39331)
		{ 1,    91788,  70,  220 }, -- Shellmaw
		{ 2,    108543, 41,  190 }, -- Dread Captain Thedon
		{ 3,    101411, 108, 120 }, -- Gom Crabbar
		{ 4,    101467, 489, 150 }, -- Jaggen-Ra
	},
	HallsofValorA = {
		{ "A", 10001,  249, 12 }, -- Entrance
		{ "B", 10002,  178, 239 }, -- Portal
		{ "C", 10003,  249, 489 }, -- Connection
		{ 1,   1485,   249, 87 }, -- Hymdall
		{ 2,   1486,   343, 272 }, -- Hyrja
		{ 1,   106320, 248, 209 }, -- Volynd Stormbringer
	},
	HallsofValorB = {
		{ "B",   10002, 435, 104 }, -- Portal
		{ 3,     1487,  109, 345 }, -- Fenryr
		{ "3'",  10003, 175, 144 }, -- Fenryr's western spawn point
		{ "3''", 10004, 344, 287 }, -- Fenryr's eastern spawn point
		{ 2,     99802, 372, 271 }, -- Arthfael
		{ 3,     96647, 71,  309 }, -- Earlnoc the Beastbreaker
	},
	HallsofValorC = {
		{ "C", 10003, 250, 36 }, -- Connection
		{ 4,   1488,  251, 300 }, -- God-King Skovald
		{ 5,   1489,  251, 425 }, -- Odyn
		{ "1", 97084, 201, 275 }, -- King Tor
		{ "2", 97081, 220, 309 }, -- King Bjorn
		{ "3", 95843, 282, 308 }, -- King Haldor
		{ "4", 97083, 299, 276 }, -- King Ranulf
	},
	MawofSoulsA = {
		{ "A", 10001, 201, 233 }, -- Entrance
		{ "B", 10002, 234, 121 }, -- Transport
		{ 1,   1502,  210, 141 }, -- Ymiron, the Fallen King
	},
	MawofSoulsB = {
		{ "B", 10001, 133, 400 }, -- Connection
		{ "C", 10001, 400, 400 }, -- Connection
		{ "C", 10001, 402, 250 }, -- Connection
		{ 2,   1512,  340, 251 }, -- Harbaron
		{ 3,   1663,  80,  245 }, -- Helya
	},
	NeltharionsLair = {
		{ "A",  10001,  496, 255 }, -- Entrance
		{ "B",  10002,  13,  274 }, -- Exit
		{ 1,    1662,   356, 232 }, -- Rokmora
		{ 2,    1665,   227, 269 }, -- Ularogg Cragshaper
		{ 3,    1673,   150, 200 }, -- Naraxas
		{ 4,    1687,   48,  327 }, -- Dargrul the Underking
		{ "1'", 113526, 486, 224 }, -- Spiritwalker Ebonhorn
		{ "2'", 111746, 489, 201 }, -- Mushroom Merchant
		{ 1,    103247, 374, 404 }, -- Ultanok
		{ 2,    103597, 284, 381 }, -- Understone Lasher
		{ 3,    103199, 165, 376 }, -- Ragoul
		{ 4,    103271, 221, 89 }, -- Kraxa <Mother of Gnashers>
	},
	ReturntoKarazhanEnt = {
		{ "A",  10001, 279, 289 }, -- Karazhan, Front
		{ "B",  10002, 327, 192 }, -- Karazhan, Back
		{ "C",  10003, 266, 220 }, -- Return to Karazhan
		{ "1'", 18255, 290, 304 }, -- Archmage Leryda
		{ "2'", 10004, 300, 355 }, -- Stairs to The Master's Cellar
		{ "3'", 10005, 325, 365 }, -- Stairs to The Master's Cellar
		{ "4'", 10006, 226, 364 }, -- Charred Bone Fragment
		{ "5'", 10007, 274, 315 }, -- Meeting Stone
		{ "6'", 10008, 94,  288 }, -- Graveyard
		{ "7'", 66255, 93,  328 }, -- Lydia Accoste
	},
	ReturntoKarazhanA = {
		{ "A",  10001,  425, 321 }, -- Entrance
		{ "B",  10002,  228, 25 }, -- Connection
		{ "C",  10002,  462, 348 }, -- Connection
		{ "B",  10002,  231, 303 }, -- Connection
		{ "D",  10002,  306, 397 }, -- Connection
		{ 1,    1820,   80,  346 }, -- Opera Hall: Wikket
		{ 2,    1826,   74,  370 }, -- Opera Hall: Westfall Story
		{ 3,    1827,   70,  388 }, -- Opera Hall: Beautiful Beast
		{ "1'", 114339, 100, 369 }, -- Barnes
		{ "2'", 115105, 152, 373 }, -- Soul Fragment
	},
	ReturntoKarazhanB = {
		{ "D",  10001,  23,  216 }, -- Connection
		{ "E",  10001,  270, 268 }, -- Connection
		{ "F",  10001,  33,  152 }, -- Connection
		{ 4,    1825,   410, 289 }, -- Maiden of Virtue
		{ "3'", 115013, 397, 117 }, -- Soul Fragment
	},
	ReturntoKarazhanC = {
		{ "E",  10001,  352, 99 }, -- Connection
		{ "H",  10001,  278, 249 }, -- Connection
		{ "G",  10001,  170, 436 }, -- Connection
		{ 5,    1837,   142, 177 }, -- Moroes
		{ "4'", 115103, 118, 172 }, -- Soul Fragment
	},
	ReturntoKarazhanD = {
		{ "F",  10001,  116, 15 }, -- Connection
		{ "G",  10001,  111, 456 }, -- Connection
		{ "H",  10001,  231, 304 }, -- Connection
		{ "I",  10002,  431, 63 }, -- Connection
		{ 6,    1835,   158, 416 }, -- Attumen the Huntsman
		{ "5'", 114815, 154, 359 }, -- Koren
		{ "6'", 115101, 418, 58 }, -- Soul Fragment
	},
	ReturntoKarazhanE = {
		{ "C",  10001,  349, 162 }, -- Connection
		{ "J",  10003,  275, 398 }, -- Portal
		{ 7,    1836,   249, 363 }, -- The Curator
		{ "7'", 115113, 229, 401 }, -- Soul Fragment
	},
	ReturntoKarazhanF = {
		{ "J", 10001, 56,  102 }, -- Portal
		{ "K", 10002, 449, 342 }, -- Portal
		{ 8,   1817,  451, 250 }, -- Shade of Medivh
	},
	ReturntoKarazhanG = {
		{ "K",  10001,  22, 334 }, -- Entrance
		{ 9,    1818,   83, 107 }, -- Mana Devourer
		{ "8'", 266826, 27, 251 }, -- Medivh's Footlocker
	},
	ReturntoKarazhanH = {
		{ "L",  10001,  21,  41 }, -- Entrance
		{ "M",  10002,  192, 487 }, -- Connection
		{ "N",  10003,  29,  65 }, -- Portal
		{ "9'", 143537, 34,  43 }, -- Mana Focus
	},
	ReturntoKarazhanI = {
		{ "M",  10001,  282, 271 }, -- Connection
		{ 10,   1838,   248, 291 }, -- Viz'aduum the Watcher
		{ "9'", 115497, 196, 375 }, -- Archmage Khadgar
	},
	TombofSargerasA = {
		{ "A", 10001, 200, 492 }, -- Entrance
		{ "B", 10002, 283, 263 }, -- Connection
		{ 1,   1862,  202, 297 }, -- Goroth
		{ 2,   1867,  200, 26 }, -- Demonic Inquisition
	},
	TombofSargerasB = {
		{ "B", 10001, 159, 323 }, -- Connection
		{ "C", 10001, 303, 492 }, -- Connection
		{ 4,   1903,  250, 288 }, -- Sisters of the Moon
		{ 6,   1896,  304, 100 }, -- The Desolate Host
	},
	TombofSargerasC = {
		{ "C", 10001, 313, 230 }, -- Connection
		{ "D", 10001, 373, 281 }, -- Connection
		{ 3,   1856,  195, 267 }, -- Harjatan
	},
	TombofSargerasD = {
		{ "D", 10001, 79,  101 }, -- Connection
		{ 5,   1861,  235, 231 }, -- Mistress Sassz'ine
	},
	TombofSargerasE = {
		{ 7, 1897, 250, 157 }, -- Maiden of Vigilance
	},
	TombofSargerasF = {
		{ 8, 1873, 250, 182 }, -- Fallen Avatar
	},
	TombofSargerasG = {
		{ 9, 1898, 378, 249 },
	},
	TheArcwayEnt = {
		{ " A", 10001,  382, 50 }, -- The Grand Promenade
		{ " B", 10002,  470, 460 }, -- Terrace of Order
		{ " C", 10003,  126, 297 }, -- The Arcway
		{ " D", 10004,  350, 219 }, -- The Nighthold
		{ " A", 10005,  471, 36 }, -- Transport
		{ " A", 10005,  415, 136 }, -- Transport
		{ " A", 10005,  383, 345 }, -- Transport
		{ " A", 10005,  325, 444 }, -- Transport
		{ " B", 10006,  292, 267 }, -- Portal to Shal'Aran
		{ " 1", 10007,  220, 295 }, -- Meeting Stone
		{ "1'", 115366, 348, 240 }, -- First Arcanist Thalyssra
	},
	TheArcway = {
		{ "A",  10001,  267, 81 }, -- Entrance
		{ 1,    1497,   61,  350 }, -- Ivanyr
		{ 2,    1498,   211, 360 }, -- Corstilax
		{ 3,    1499,   455, 234 }, -- General Xakal
		{ 4,    1500,   363, 349 }, -- Nal'tira
		{ 5,    1501,   270, 178 }, -- Advisor Vandros
		{ "1",  111057, 203, 232 }, -- The Rat King
		{ "2",  111021, 270, 395 }, -- Sludge Face
		{ "1'", 138394, 92,  304 }, -- Suramar Leyline Map
	},
	TheEmeraldNightmareA = {
		{ "A",  10001, 122, 344 }, -- Entrance
		{ "B",  10002, 50,  446 }, -- Entrance
		{ 1,    1703,  284, 239 }, -- Nythendra
		{ "1'", 10003, 160, 281 }, -- Nightmare Watcher
	},
	TheEmeraldNightmareB = {
		{ "B",  10002,  55,  344 }, -- Connection
		{ "C",  10003,  348, 242 }, -- Un'Goro Crater
		{ "D",  10004,  399, 225 }, -- Mulgore
		{ "E",  10005,  343, 158 }, -- Grizzly Hills
		{ "F",  10006,  396, 159 }, -- The Emerald Dreamway
		{ "1'", 106482, 366, 202 }, -- Malfurion Stormrage
	},
	TheEmeraldNightmareC = {
		{ "C", 10003, 424, 464 }, -- Entrance
		{ 2,   1738,  234, 206 }, -- Il'gynoth, Heart of Corruption
	},
	TheEmeraldNightmareD = {
		{ "D", 10004, 418, 327 }, -- Entrance
		{ 3,   1744,  146, 251 }, -- Elerethe Renferal
	},
	TheEmeraldNightmareE = {
		{ "E", 10005, 96,  303 }, -- Entrance
		{ 4,   1667,  253, 155 }, -- Ursoc
	},
	TheEmeraldNightmareF = {
		{ "F", 10006, 97,  382 }, -- Entrance
		{ 5,   1704,  180, 252 }, -- Dragons of Nightmare
	},
	TheEmeraldNightmareG = {
		{ "G", 10007, 194, 407 }, -- Entrance
		{ 6,   1750,  297, 228 }, -- Cenarius
	},
	TheEmeraldNightmareH = {
		{ 7, 1726, 250, 250 }, -- Xavius
	},
	TheNightholdEnt = {
		{ " A", 10001,  382, 50 }, -- The Grand Promenade
		{ " B", 10002,  470, 460 }, -- Terrace of Order
		{ " C", 10003,  126, 297 }, -- The Arcway
		{ " D", 10004,  350, 219 }, -- The Nighthold
		{ " A", 10005,  471, 36 }, -- Transport
		{ " A", 10005,  415, 136 }, -- Transport
		{ " A", 10005,  383, 345 }, -- Transport
		{ " A", 10005,  325, 444 }, -- Transport
		{ " B", 10006,  292, 267 }, -- Portal to Shal'Aran
		{ " 1", 10007,  220, 295 }, -- Meeting Stone
		{ "1'", 115366, 348, 240 }, -- First Arcanist Thalyssra
	},
	TheNightholdA = {
		{ "A",  10001,  147, 442 }, -- Portal
		{ "B",  10002,  228, 51 }, -- Connection
		{ "B",  10002,  64,  91 }, -- Connection
		{ "C",  10002,  160, 21 }, -- Connection
		{ 1,    1706,   188, 290 }, -- Skorpyron
		{ 2,    1725,   356, 204 }, -- Chronomatic Anomaly
		{ 3,    1731,   264, 70 }, -- Trilliax
		{ "1'", 110791, 136, 434 }, -- First Arcanist Thalyssra
	},
	TheNightholdB = {
		{ 4,    1751,   155, 233 }, -- Spellblade Aluriel
		{ 6,    1761,   408, 64 }, -- High Botanist Tel'arn
		{ 8,    1713,   387, 487 }, -- Krosus
		{ 10,   1737,   203, 279 }, -- Gul'dan
		{ "A",  10001,  50,  129 }, -- Portal
		{ "C",  10002,  163, 150 }, -- Connection
		{ "D",  10002,  180, 179 }, -- Connection
		{ "E",  10002,  228, 128 }, -- Connection
		{ "F",  10002,  215, 180 }, -- Connection
		{ "G",  10002,  82,  267 }, -- Connection
		{ "G",  10002,  94,  281 }, -- Connection
		{ "H",  10002,  106, 290 }, -- Connection
		{ "I",  10002,  177, 251 }, -- Connection
		{ "J",  10002,  229, 300 }, -- Connection
		{ "K",  10003,  147, 331 }, -- Portal
		{ "K",  10003,  257, 221 }, -- Portal
		{ "1",  112712, 89,  126 }, -- Gilded Guardian
		{ "2",  116004, 47,  309 }, -- Flightmaster Volnath
		{ "2'", 117085, 80,  280 }, -- Ly'leth Lunastre
	},
	TheNightholdC = {
		{ 5,   1732,  152, 95 }, -- Star Augur Etraeus
		{ "D", 10001, 169, 466 }, -- Connection
		{ "E", 10001, 412, 221 }, -- Connection
		{ "F", 10002, 346, 453 }, -- Connection
	},
	TheNightholdD = {
		{ "G", 10002, 146, 177 }, -- Connection
		{ "G", 10002, 325, 353 }, -- Connection
		{ "H", 10002, 406, 256 }, -- Connection
		{ 7,   1762,  175, 320 }, -- Tichondrius
	},
	TheNightholdE = {
		{ "I", 10001, 152, 150 }, -- Connection
		{ "J", 10001, 349, 348 }, -- Connection
		{ "K", 10002, 319, 181 }, -- Portal
		{ "K", 10002, 184, 318 }, -- Portal
	},
	TheNightholdF = {
		{ "K", 10002, 48,  446 }, -- Portal
		{ "K", 10002, 464, 48 }, -- Portal
		{ "K", 10002, 142, 144 }, -- Portal
		{ 9,   1743,  251, 249 }, -- Grand Magistrix Elisande
	},
	TheNightholdG = {
		{ 10, 1737, 250, 251 }, -- Gul'dan
	},
	TheSeatoftheTriumvirate = {
		{ "A", 10001, 52,  434 }, -- Entrance
		{ 1,   1979,  67,  368 }, -- Zuraal the Ascended
		{ 2,   1980,  117, 206 }, -- Saprish
		{ 3,   1981,  269, 100 }, -- Viceroy Nezhar
		{ 4,   1982,  338, 162 }, -- L'ura
	},
	TrialofValorA = {
		{ "A", 10101, 249, 39 }, -- Entrance
		{ 1,   10001, 291, 321 }, -- Hymdall
		{ 2,   10002, 212, 321 }, -- Hyrja
		{ 3,   1819,  251, 427 }, -- Odyn
	},
	TrialofValorB = {
		{ "A", 10101, 348, 244 }, -- Entrance
		{ 4,   1830,  278, 196 }, -- Guarm
		{ 5,   1829,  172, 190 }, -- Helya
	},
	VaultoftheWardensA = {
		{ "A", 10001, 480, 384 }, -- Entrance
		{ "B", 10002, 68,  206 }, -- Connection
		{ "B", 10002, 137, 206 }, -- Connection
		{ "C", 10003, 104, 116 }, -- Elevator
		{ 1,   1467,  103, 283 }, -- Tirathon Saltheril
	},
	VaultoftheWardensB = {
		{ "C", 10003,  197, 241 }, -- Elevator
		{ "D", 10003,  91,  241 }, -- Elevator
		{ 2,   1695,   139, 241 }, -- Inquisitor Tormentorum
		{ 3,   1468,   191, 412 }, -- Ash'golm
		{ 4,   1469,   373, 239 }, -- Glazer
		{ "1", 105824, 197, 73 }, -- Grimoira
	},
	VaultoftheWardensC = {
		{ "D",  10004,  271, 25 }, -- Connection
		{ 5,    1470,   246, 426 }, -- Cordana Felsong
		{ "1'", 258979, 306, 150 }, -- Fel-Ravaged Tome
		{ "2'", 103860, 228, 441 }, -- Drelanim Whisperwind
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
	[BZ["Black Rook Hold"]] = "BlackRookHoldA",
	[BZ["Court of Stars"]] = "CourtofStarsA",
	[BZ["Halls of Valor"]] = "HallsofValorA",
	[BZ["Maw of Souls"]] = "MawofSoulsA",
	[BZ["The Emerald Nightmare"]] = "TheEmeraldNightmareA",
	[BZ["The Nighthold"]] = "TheNightholdA",
	[BZ["Vault of the Wardens"]] = "VaultoftheWardensA",
	[BZ["Trial of Valor"]] = "TrialofValorA",
	[BZ["Karazhan"]] = "ReturntoKarazhanEnt", -- not sure if we should use "Return to Karazhan"
	[BZ["Cathedral of Eternal Night"]] = "CathedralofEternalNightA",
	[BZ["Antorus, the Burning Throne"]] = "AntorustheBurningThroneA",
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
	[BZ["Black Rook Hold"]] = {
		["BlackRookHoldA"] = {
			BZ["The Ravenscrypt"],
			BZ["The Grand Sepulcher"],
			BZ["The Mausoleum of Lady Velandras"],
			BZ["The Mausoleum of Lord Etheldrin"],
			BZ["The Chamber of War"],
			BZ["Hidden Passageway"],
		},
		["BlackRookHoldB"] = {
			BZ["The Grand Hall"],
			BZ["Ravenswatch"],
		},
		["BlackRookHoldC"] = {
			BZ["Ravenshold"],
			BZ["Rook's Rise"],
			BZ["Lord Ravencrest's Chamber"],
		},
		["BlackRookHoldD"] = {
			BZ["The Rook's Roost"],
			BZ["The Raven's Crown"],
		},
	},
	[BZ["Court of Stars"]] = {
		["CourtofStarsA"] = {
			BZ["Moonlit Landing"],
			BZ["Midnight Court"],
			BZ["The Gilded Market"],
		},
		["CourtofStarsB"] = {
			BZ["The Jeweled Estate"],
		},
	},
	[BZ["Halls of Valor"]] = {
		["HallsofValorA"] = {
			BZ["The High Gate"],
			BZ["Hearth of Revelry"],
			BZ["Seat of Ascension"],
			BZ["The Ephemeral Way"],
		},
		["HallsofValorB"] = {
			BZ["Fields of the Eternal Hunt"],
		},
		["HallsofValorC"] = {
			BZ["Hall of Glory"],
			BZ["Halls of Valor"],
		},
	},
	[BZ["Maw of Souls"]] = {
		["MawofSoulsA"] = {
			BZ["Helmouth Cliffs"],
		},
		["MawofSoulsB"] = {
			BZ["The Naglfar"],
		},
	},
	[BZ["The Emerald Nightmare"]] = {
		["TheEmeraldNightmareA"] = {
			BZ["Clutch of Corruption"],
		},
		["TheEmeraldNightmareB"] = {
			BZ["Core of the Nightmare"],
		},
		["TheEmeraldNightmareC"] = {
			BZ["Un'goro Crater"],
		},
		["TheEmeraldNightmareD"] = {
			BZ["Mulgore"],
		},
		["TheEmeraldNightmareE"] = {
			BZ["Grizzly Hills"],
		},
		["TheEmeraldNightmareF"] = {
			BZ["The Emerald Dreamway"],
		},
		["TheEmeraldNightmareG"] = {
			BZ["Moonglade"],
		},
		["TheEmeraldNightmareH"] = {
			BZ["Rift of Aln"],
		},
		-- BZ["The Emerald Dream"],
		-- BZ["Bough Shadow"],
		-- BZ["Seradane"],
		-- BZ["Twilight Grove"],
		-- BZ["Dream Bough"],
	},
	[BZ["The Nighthold"]] = {
		-- Skorpyron, Chronomatic Anomaly, Trilliax
		["TheNightholdA"] = {
			BZ["Arcing Depths"],
			BZ["Crystal Breach"],
			BZ["The Nightwell"],
		},
		-- Spellblade Aluriel, Krosus, High Botanist Tel'arn, Gul'dan
		["TheNightholdB"] = {
			BZ["Shal'dorei Terrace"],
			BZ["The Shattered Walkway"],
			BZ["Elisande's Reach"],
		},
		-- Star Augur Etraeus
		["TheNightholdC"] = {
			BZ["Astromancer's Rise"],
			BZ["Eternal Observatory"],
		},
		-- Tichondrius
		["TheNightholdD"] = {
			BZ["Captain's Quarters"],
		},
		--		["TheNightholdE"] = {
		--		},
		-- Grand Magistrix Elisande
		["TheNightholdF"] = {
			BZ["Elisande's Secret Quarters"],
			BZ["The Nightspire"], -- upper floor
		},
		["TheNightholdG"] = { --
			BZ["The Font of Night"],
		},
	},
	[BZ["Vault of the Wardens"]] = {
		["VaultoftheWardensA"] = {
			BZ["Chamber of Night"],
			BZ["The Warden's Court"],
		},
		["VaultoftheWardensB"] = {
			BZ["The Demon Ward"],
			BZ["Vault of Law"], -- though we did not show this room as there is nothing
			BZ["Fallen Passage"],
			BZ["Vault of Mirrors"],
			BZ["Vault of Ice"],
		},
		["VaultoftheWardensC"] = {
			BZ["Tomb of the Penitent"],
			BZ["Vault of the Betrayer"],
		},
	},
	[BZ["Cathedral of Eternal Night"]] = {
		["CathedralofEternalNightA"] = {
			BZ["Hall of the Moon"],
		},
		["CathedralofEternalNightB"] = {
			BZ["Twilight Grove"],
		},
		["CathedralofEternalNightC"] = {
			BZ["The Emerald Archives"],
			BZ["Path of Illumination"],
		},
		["CathedralofEternalNightD"] = {
			BZ["Sacristy of Elune"],
		},
		--			BZ["Chapel of Tranquil Song"],
		--			BZ["Chapel of Moonlight"],
		--			BZ["Chapel of Sentinels"],
		--			BZ["Chapel of Tears"],
	},
	[BZ["Tomb of Sargeras"]] = {
		["TombofSargerasA"] = {
			BZ["Conclave of Torment"],
			BZ["Chamber of the Moon"],
			BZ["Apostate's Reach"],
			BZ["The Breach"],
		},
		["TombofSargerasB"] = {
			BZ["Terrace of the Moon"],
			BZ["Befouled Sanctum"],
			BZ["Wailing Halls"],
		},
		["TombofSargerasC"] = {
			BZ["Lair of Harjatan"],
			BZ["The Collapse"],
			BZ["The Abyssal Approach"],
		},
		["TombofSargerasD"] = {
			BZ["The Abyssal Throne"],
		},
		["TombofSargerasE"] = {
			BZ["The Guardian's Sanctum"],
		},
		["TombofSargerasF"] = {
			BZ["Chamber of the Avatar"],
		},
		["TombofSargerasG"] = {
			BZ["The Twisting Nether"],
		},
		--			BZ["Sunken Stair"],
		--			BZ["Belac's Cells"],
		--			BZ["Forgotten Approach"],

	},
	--	[BZ["Trial of Valor"]] = {
	--		["TrialofValorA"] = {
	--
	--		},
	--		["TrialofValorB"] = {
	--
	--		},
	--	},
	[BZ["Antorus, the Burning Throne"]] = {
		["AntorustheBurningThroneA"] = {
		},
		["AntorustheBurningThroneB"] = {
		},
		["AntorustheBurningThroneC"] = {
		},
		["AntorustheBurningThroneD"] = {
		},
		["AntorustheBurningThroneE"] = {
		},
		["AntorustheBurningThroneF"] = {
		},
		["AntorustheBurningThroneG"] = {
		},
	},
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
	[BZ["Dalaran"]] = "AssaultonVioletHold",
	[BZ["Azsuna"]] = "VaultoftheWardensA",
	[BZ["Val'sharah"]] = "BlackRookHoldA",
	[BZ["Highmountain"]] = "NeltharionsLair",
	[BZ["Stormheim"]] = "HallsofValorA",
	[BZ["Suramar"]] = "TheNightholdEnt",
	[BZ["Deadwind Pass"]] = "ReturntoKarazhanEnt",
	[BZ["Broken Shore"]] = "CathedralofEternalNightA",
	[BZ["Mac'Aree"]] = "TheSeatoftheTriumvirate",
	--"AntorustheBurningThroneA",
}

db.EntToInstMatches = {
	["TheArcwayEnt"] = { "TheArcway" },
	["TheNightholdEnt"] = { "TheNightholdA", "TheNightholdB", "TheNightholdC", "TheNightholdD", "TheNightholdE", "TheNightholdF", "TheNightholdG" },
	["ReturntoKarazhanEnt"] = { "ReturntoKarazhanA", "ReturntoKarazhanB", "ReturntoKarazhanC", "ReturntoKarazhanD", "ReturntoKarazhanE", "ReturntoKarazhanF", "ReturntoKarazhanG", "ReturntoKarazhanH", "ReturntoKarazhanI" },
}

db.InstToEntMatches = {
	["TheArcway"] = { "TheArcwayEnt" },
	["TheNightholdA"] = { "TheNightholdEnt" },
	["TheNightholdB"] = { "TheNightholdEnt" },
	["TheNightholdC"] = { "TheNightholdEnt" },
	["TheNightholdD"] = { "TheNightholdEnt" },
	["TheNightholdE"] = { "TheNightholdEnt" },
	["TheNightholdF"] = { "TheNightholdEnt" },
	["TheNightholdG"] = { "TheNightholdEnt" },
	["ReturntoKarazhanA"] = { "ReturntoKarazhanEnt" },
	["ReturntoKarazhanB"] = { "ReturntoKarazhanEnt" },
	["ReturntoKarazhanC"] = { "ReturntoKarazhanEnt" },
	["ReturntoKarazhanD"] = { "ReturntoKarazhanEnt" },
	["ReturntoKarazhanE"] = { "ReturntoKarazhanEnt" },
	["ReturntoKarazhanF"] = { "ReturntoKarazhanEnt" },
	["ReturntoKarazhanG"] = { "ReturntoKarazhanEnt" },
	["ReturntoKarazhanH"] = { "ReturntoKarazhanEnt" },
	["ReturntoKarazhanI"] = { "ReturntoKarazhanEnt" },
}

db.MapSeries = {
	["BlackRookHoldA"] = { "BlackRookHoldA", "BlackRookHoldB", "BlackRookHoldC", "BlackRookHoldD" },
	["BlackRookHoldB"] = { "BlackRookHoldA", "BlackRookHoldB", "BlackRookHoldC", "BlackRookHoldD" },
	["BlackRookHoldC"] = { "BlackRookHoldA", "BlackRookHoldB", "BlackRookHoldC", "BlackRookHoldD" },
	["BlackRookHoldD"] = { "BlackRookHoldA", "BlackRookHoldB", "BlackRookHoldC", "BlackRookHoldD" },
	["CourtofStarsA"] = { "CourtofStarsA", "CourtofStarsB" },
	["CourtofStarsB"] = { "CourtofStarsA", "CourtofStarsB" },
	["HallsofValorA"] = { "HallsofValorA", "HallsofValorB", "HallsofValorC" },
	["HallsofValorB"] = { "HallsofValorA", "HallsofValorB", "HallsofValorC" },
	["HallsofValorC"] = { "HallsofValorA", "HallsofValorB", "HallsofValorC" },
	["MawofSoulsA"] = { "MawofSoulsA", "MawofSoulsB" },
	["MawofSoulsB"] = { "MawofSoulsA", "MawofSoulsB" },
	["TheEmeraldNightmareA"] = { "TheEmeraldNightmareA", "TheEmeraldNightmareB", "TheEmeraldNightmareC", "TheEmeraldNightmareD", "TheEmeraldNightmareE", "TheEmeraldNightmareF", "TheEmeraldNightmareG", "TheEmeraldNightmareH" },
	["TheEmeraldNightmareB"] = { "TheEmeraldNightmareA", "TheEmeraldNightmareB", "TheEmeraldNightmareC", "TheEmeraldNightmareD", "TheEmeraldNightmareE", "TheEmeraldNightmareF", "TheEmeraldNightmareG", "TheEmeraldNightmareH" },
	["TheEmeraldNightmareC"] = { "TheEmeraldNightmareA", "TheEmeraldNightmareB", "TheEmeraldNightmareC", "TheEmeraldNightmareD", "TheEmeraldNightmareE", "TheEmeraldNightmareF", "TheEmeraldNightmareG", "TheEmeraldNightmareH" },
	["TheEmeraldNightmareD"] = { "TheEmeraldNightmareA", "TheEmeraldNightmareB", "TheEmeraldNightmareC", "TheEmeraldNightmareD", "TheEmeraldNightmareE", "TheEmeraldNightmareF", "TheEmeraldNightmareG", "TheEmeraldNightmareH" },
	["TheEmeraldNightmareE"] = { "TheEmeraldNightmareA", "TheEmeraldNightmareB", "TheEmeraldNightmareC", "TheEmeraldNightmareD", "TheEmeraldNightmareE", "TheEmeraldNightmareF", "TheEmeraldNightmareG", "TheEmeraldNightmareH" },
	["TheEmeraldNightmareF"] = { "TheEmeraldNightmareA", "TheEmeraldNightmareB", "TheEmeraldNightmareC", "TheEmeraldNightmareD", "TheEmeraldNightmareE", "TheEmeraldNightmareF", "TheEmeraldNightmareG", "TheEmeraldNightmareH" },
	["TheEmeraldNightmareG"] = { "TheEmeraldNightmareA", "TheEmeraldNightmareB", "TheEmeraldNightmareC", "TheEmeraldNightmareD", "TheEmeraldNightmareE", "TheEmeraldNightmareF", "TheEmeraldNightmareG", "TheEmeraldNightmareH" },
	["TheEmeraldNightmareH"] = { "TheEmeraldNightmareA", "TheEmeraldNightmareB", "TheEmeraldNightmareC", "TheEmeraldNightmareD", "TheEmeraldNightmareE", "TheEmeraldNightmareF", "TheEmeraldNightmareG", "TheEmeraldNightmareH" },
	["TheNightholdA"] = { "TheNightholdA", "TheNightholdB", "TheNightholdC", "TheNightholdD", "TheNightholdE", "TheNightholdF", "TheNightHoldG" },
	["TheNightholdB"] = { "TheNightholdA", "TheNightholdB", "TheNightholdC", "TheNightholdD", "TheNightholdE", "TheNightholdF", "TheNightHoldG" },
	["TheNightholdC"] = { "TheNightholdA", "TheNightholdB", "TheNightholdC", "TheNightholdD", "TheNightholdE", "TheNightholdF", "TheNightHoldG" },
	["TheNightholdD"] = { "TheNightholdA", "TheNightholdB", "TheNightholdC", "TheNightholdD", "TheNightholdE", "TheNightholdF", "TheNightHoldG" },
	["TheNightholdE"] = { "TheNightholdA", "TheNightholdB", "TheNightholdC", "TheNightholdD", "TheNightholdE", "TheNightholdF", "TheNightHoldG" },
	["TheNightholdF"] = { "TheNightholdA", "TheNightholdB", "TheNightholdC", "TheNightholdD", "TheNightholdE", "TheNightholdF", "TheNightHoldG" },
	["TheNightholdG"] = { "TheNightholdA", "TheNightholdB", "TheNightholdC", "TheNightholdD", "TheNightholdE", "TheNightholdF", "TheNightHoldG" },
	["TrialofValorA"] = { "TrialofValorA", "TrialofValorB" },
	["TrialofValorB"] = { "TrialofValorA", "TrialofValorB" },
	["VaultoftheWardensA"] = { "VaultoftheWardensA", "VaultoftheWardensB", "VaultoftheWardensC" },
	["VaultoftheWardensB"] = { "VaultoftheWardensA", "VaultoftheWardensB", "VaultoftheWardensC" },
	["VaultoftheWardensC"] = { "VaultoftheWardensA", "VaultoftheWardensB", "VaultoftheWardensC" },
	["ReturntoKarazhanA"] = { "ReturntoKarazhanA", "ReturntoKarazhanB", "ReturntoKarazhanC", "ReturntoKarazhanD", "ReturntoKarazhanE", "ReturntoKarazhanF", "ReturntoKarazhanG", "ReturntoKarazhanH", "ReturntoKarazhanI" },
	["ReturntoKarazhanB"] = { "ReturntoKarazhanA", "ReturntoKarazhanB", "ReturntoKarazhanC", "ReturntoKarazhanD", "ReturntoKarazhanE", "ReturntoKarazhanF", "ReturntoKarazhanG", "ReturntoKarazhanH", "ReturntoKarazhanI" },
	["ReturntoKarazhanC"] = { "ReturntoKarazhanA", "ReturntoKarazhanB", "ReturntoKarazhanC", "ReturntoKarazhanD", "ReturntoKarazhanE", "ReturntoKarazhanF", "ReturntoKarazhanG", "ReturntoKarazhanH", "ReturntoKarazhanI" },
	["ReturntoKarazhanD"] = { "ReturntoKarazhanA", "ReturntoKarazhanB", "ReturntoKarazhanC", "ReturntoKarazhanD", "ReturntoKarazhanE", "ReturntoKarazhanF", "ReturntoKarazhanG", "ReturntoKarazhanH", "ReturntoKarazhanI" },
	["ReturntoKarazhanE"] = { "ReturntoKarazhanA", "ReturntoKarazhanB", "ReturntoKarazhanC", "ReturntoKarazhanD", "ReturntoKarazhanE", "ReturntoKarazhanF", "ReturntoKarazhanG", "ReturntoKarazhanH", "ReturntoKarazhanI" },
	["ReturntoKarazhanF"] = { "ReturntoKarazhanA", "ReturntoKarazhanB", "ReturntoKarazhanC", "ReturntoKarazhanD", "ReturntoKarazhanE", "ReturntoKarazhanF", "ReturntoKarazhanG", "ReturntoKarazhanH", "ReturntoKarazhanI" },
	["ReturntoKarazhanG"] = { "ReturntoKarazhanA", "ReturntoKarazhanB", "ReturntoKarazhanC", "ReturntoKarazhanD", "ReturntoKarazhanE", "ReturntoKarazhanF", "ReturntoKarazhanG", "ReturntoKarazhanH", "ReturntoKarazhanI" },
	["ReturntoKarazhanH"] = { "ReturntoKarazhanA", "ReturntoKarazhanB", "ReturntoKarazhanC", "ReturntoKarazhanD", "ReturntoKarazhanE", "ReturntoKarazhanF", "ReturntoKarazhanG", "ReturntoKarazhanH", "ReturntoKarazhanI" },
	["ReturntoKarazhanI"] = { "ReturntoKarazhanA", "ReturntoKarazhanB", "ReturntoKarazhanC", "ReturntoKarazhanD", "ReturntoKarazhanE", "ReturntoKarazhanF", "ReturntoKarazhanG", "ReturntoKarazhanH", "ReturntoKarazhanI" },
	["CathedralofEternalNightA"] = { "CathedralofEternalNightA", "CathedralofEternalNightB", "CathedralofEternalNightC", "CathedralofEternalNightD" },
	["CathedralofEternalNightB"] = { "CathedralofEternalNightA", "CathedralofEternalNightB", "CathedralofEternalNightC", "CathedralofEternalNightD" },
	["CathedralofEternalNightC"] = { "CathedralofEternalNightA", "CathedralofEternalNightB", "CathedralofEternalNightC", "CathedralofEternalNightD" },
	["CathedralofEternalNightD"] = { "CathedralofEternalNightA", "CathedralofEternalNightB", "CathedralofEternalNightC", "CathedralofEternalNightD" },
	["TombofSargerasA"] = { "TombofSargerasA", "TombofSargerasB", "TombofSargerasC", "TombofSargerasD", "TombofSargerasE", "TombofSargerasF", "TombofSargerasG" },
	["TombofSargerasB"] = { "TombofSargerasA", "TombofSargerasB", "TombofSargerasC", "TombofSargerasD", "TombofSargerasE", "TombofSargerasF", "TombofSargerasG" },
	["TombofSargerasC"] = { "TombofSargerasA", "TombofSargerasB", "TombofSargerasC", "TombofSargerasD", "TombofSargerasE", "TombofSargerasF", "TombofSargerasG" },
	["TombofSargerasD"] = { "TombofSargerasA", "TombofSargerasB", "TombofSargerasC", "TombofSargerasD", "TombofSargerasE", "TombofSargerasF", "TombofSargerasG" },
	["TombofSargerasE"] = { "TombofSargerasA", "TombofSargerasB", "TombofSargerasC", "TombofSargerasD", "TombofSargerasE", "TombofSargerasF", "TombofSargerasG" },
	["TombofSargerasF"] = { "TombofSargerasA", "TombofSargerasB", "TombofSargerasC", "TombofSargerasD", "TombofSargerasE", "TombofSargerasF", "TombofSargerasG" },
	["TombofSargerasG"] = { "TombofSargerasA", "TombofSargerasB", "TombofSargerasC", "TombofSargerasD", "TombofSargerasE", "TombofSargerasF", "TombofSargerasG" },
	["AntorustheBurningThroneA"] = { "AntorustheBurningThroneA", "AntorustheBurningThroneB", "AntorustheBurningThroneC", "AntorustheBurningThroneD", "AntorustheBurningThroneE", "AntorustheBurningThroneF", "AntorustheBurningThroneG" },
	["AntorustheBurningThroneB"] = { "AntorustheBurningThroneA", "AntorustheBurningThroneB", "AntorustheBurningThroneC", "AntorustheBurningThroneD", "AntorustheBurningThroneE", "AntorustheBurningThroneF", "AntorustheBurningThroneG" },
	["AntorustheBurningThroneC"] = { "AntorustheBurningThroneA", "AntorustheBurningThroneB", "AntorustheBurningThroneC", "AntorustheBurningThroneD", "AntorustheBurningThroneE", "AntorustheBurningThroneF", "AntorustheBurningThroneG" },
	["AntorustheBurningThroneD"] = { "AntorustheBurningThroneA", "AntorustheBurningThroneB", "AntorustheBurningThroneC", "AntorustheBurningThroneD", "AntorustheBurningThroneE", "AntorustheBurningThroneF", "AntorustheBurningThroneG" },
	["AntorustheBurningThroneE"] = { "AntorustheBurningThroneA", "AntorustheBurningThroneB", "AntorustheBurningThroneC", "AntorustheBurningThroneD", "AntorustheBurningThroneE", "AntorustheBurningThroneF", "AntorustheBurningThroneG" },
	["AntorustheBurningThroneF"] = { "AntorustheBurningThroneA", "AntorustheBurningThroneB", "AntorustheBurningThroneC", "AntorustheBurningThroneD", "AntorustheBurningThroneE", "AntorustheBurningThroneF", "AntorustheBurningThroneG" },
	["AntorustheBurningThroneG"] = { "AntorustheBurningThroneA", "AntorustheBurningThroneB", "AntorustheBurningThroneC", "AntorustheBurningThroneD", "AntorustheBurningThroneE", "AntorustheBurningThroneF", "AntorustheBurningThroneG" },
}

db.SubZoneAssoc = {
	["BlackRookHoldA"] = BZ["Black Rook Hold"],
	["BlackRookHoldB"] = BZ["Black Rook Hold"],
	["BlackRookHoldC"] = BZ["Black Rook Hold"],
	["BlackRookHoldD"] = BZ["Black Rook Hold"],
	["CourtofStarsA"] = BZ["Court of Stars"],
	["CourtofStarsB"] = BZ["Court of Stars"],
	["HallsofValorA"] = BZ["Halls of Valor"],
	["HallsofValorB"] = BZ["Halls of Valor"],
	["HallsofValorC"] = BZ["Halls of Valor"],
	["MawofSoulsA"] = BZ["Maw of Souls"],
	["MawofSoulsB"] = BZ["Maw of Souls"],
	["TheEmeraldNightmareA"] = BZ["The Emerald Nightmare"],
	["TheEmeraldNightmareB"] = BZ["The Emerald Nightmare"],
	["TheEmeraldNightmareC"] = BZ["The Emerald Nightmare"],
	["TheEmeraldNightmareD"] = BZ["The Emerald Nightmare"],
	["TheEmeraldNightmareE"] = BZ["The Emerald Nightmare"],
	["TheEmeraldNightmareF"] = BZ["The Emerald Nightmare"],
	["TheEmeraldNightmareG"] = BZ["The Emerald Nightmare"],
	["TheEmeraldNightmareH"] = BZ["The Emerald Nightmare"],
	["TheNightholdEnt"] = BZ["The Nighthold"],
	["TheNightholdA"] = BZ["The Nighthold"],
	["TheNightholdB"] = BZ["The Nighthold"],
	["TheNightholdC"] = BZ["The Nighthold"],
	["TheNightholdD"] = BZ["The Nighthold"],
	["TheNightholdE"] = BZ["The Nighthold"],
	["TheNightholdF"] = BZ["The Nighthold"],
	["TrialofValorA"] = BZ["Trial of Valor"],
	["TrialofValorB"] = BZ["Trial of Valor"],
	["VaultoftheWardensA"] = BZ["Vault of the Wardens"],
	["VaultoftheWardensB"] = BZ["Vault of the Wardens"],
	["VaultoftheWardensC"] = BZ["Vault of the Wardens"],
	["ReturntoKarazhanA"] = BZ["Return to Karazhan"],
	["ReturntoKarazhanB"] = BZ["Return to Karazhan"],
	["ReturntoKarazhanC"] = BZ["Return to Karazhan"],
	["ReturntoKarazhanD"] = BZ["Return to Karazhan"],
	["ReturntoKarazhanE"] = BZ["Return to Karazhan"],
	["ReturntoKarazhanF"] = BZ["Return to Karazhan"],
	["ReturntoKarazhanG"] = BZ["Return to Karazhan"],
	["ReturntoKarazhanH"] = BZ["Return to Karazhan"],
	["ReturntoKarazhanI"] = BZ["Return to Karazhan"],
	["CathedralofEternalNightA"] = BZ["Cathedral of Eternal Night"],
	["CathedralofEternalNightB"] = BZ["Cathedral of Eternal Night"],
	["CathedralofEternalNightC"] = BZ["Cathedral of Eternal Night"],
	["CathedralofEternalNightD"] = BZ["Cathedral of Eternal Night"],
	["TombofSargerasA"] = BZ["Tomb of Sargeras"],
	["TombofSargerasB"] = BZ["Tomb of Sargeras"],
	["TombofSargerasC"] = BZ["Tomb of Sargeras"],
	["TombofSargerasD"] = BZ["Tomb of Sargeras"],
	["TombofSargerasE"] = BZ["Tomb of Sargeras"],
	["TombofSargerasF"] = BZ["Tomb of Sargeras"],
	["TombofSargerasG"] = BZ["Tomb of Sargeras"],
	["AntorustheBurningThroneA"] = BZ["Antorus, the Burning Throne"],
	["AntorustheBurningThroneB"] = BZ["Antorus, the Burning Throne"],
	["AntorustheBurningThroneC"] = BZ["Antorus, the Burning Throne"],
	["AntorustheBurningThroneD"] = BZ["Antorus, the Burning Throne"],
	["AntorustheBurningThroneE"] = BZ["Antorus, the Burning Throne"],
	["AntorustheBurningThroneF"] = BZ["Antorus, the Burning Throne"],
	["AntorustheBurningThroneG"] = BZ["Antorus, the Burning Throne"],
}

db.DropDownLayouts_Order = {
	[ATLAS_DDL_CONTINENT] = {
		ATLAS_DDL_CONTINENT_EASTERN,
		ATLAS_DDL_CONTINENT_BROKENISLES1,
		ATLAS_DDL_CONTINENT_BROKENISLES2,
	},
	[ATLAS_DDL_LEVEL] = {
		ATLAS_DDL_LEVEL_40TO45,
	},
	[ATLAS_DDL_EXPANSION] = {
		ATLAS_DDL_EXPANSION_LEGION1,
		ATLAS_DDL_EXPANSION_LEGION2,
	},
	[ATLAS_DDL_PARTYSIZE] = {
		ATLAS_DDL_PARTYSIZE_5,
		ATLAS_DDL_PARTYSIZE_10,
		ATLAS_DDL_PARTYSIZE_20TO40,
	},
	[ATLAS_DDL_TYPE] = {
		ATLAS_DDL_TYPE_INSTANCE,
		ATLAS_DDL_TYPE_ENTRANCE,
	},
}
db.DropDownLayouts = {
	[ATLAS_DDL_CONTINENT] = {
		[ATLAS_DDL_CONTINENT_EASTERN] = {
			"ReturntoKarazhanEnt",       -- Legion
			"ReturntoKarazhanA",         -- Legion
			"ReturntoKarazhanB",         -- Legion
			"ReturntoKarazhanC",         -- Legion
			"ReturntoKarazhanD",         -- Legion
			"ReturntoKarazhanE",         -- Legion
			"ReturntoKarazhanF",         -- Legion
			"ReturntoKarazhanG",         -- Legion
			"ReturntoKarazhanH",         -- Legion
			"ReturntoKarazhanI",         -- Legion
		},
		[ATLAS_DDL_CONTINENT_BROKENISLES1] = { -- dungeons
			"TheArcwayEnt",
			"TheArcway",
			"AssaultonVioletHold",
			"BlackRookHoldA",
			"BlackRookHoldB",
			"BlackRookHoldC",
			"BlackRookHoldD",
			"CathedralofEternalNightA",
			"CathedralofEternalNightB",
			"CathedralofEternalNightC",
			"CathedralofEternalNightD",
			"CourtofStarsA",
			"CourtofStarsB",
			"DarkheartThicket",
			"EyeofAzshara",
			"HallsofValorA",
			"HallsofValorB",
			"HallsofValorC",
			"MawofSoulsA",
			"MawofSoulsB",
			"NeltharionsLair",
			"TheSeatoftheTriumvirate",
			"VaultoftheWardensA",
			"VaultoftheWardensB",
			"VaultoftheWardensC",
		},
		[ATLAS_DDL_CONTINENT_BROKENISLES2] = { -- raids
			"AntorustheBurningThroneA",
			"AntorustheBurningThroneB",
			"AntorustheBurningThroneC",
			"AntorustheBurningThroneD",
			"AntorustheBurningThroneE",
			"AntorustheBurningThroneF",
			"AntorustheBurningThroneG",
			"TheEmeraldNightmareA",
			"TheEmeraldNightmareB",
			"TheEmeraldNightmareC",
			"TheEmeraldNightmareD",
			"TheEmeraldNightmareE",
			"TheEmeraldNightmareF",
			"TheEmeraldNightmareG",
			"TheEmeraldNightmareH",
			"TheNightholdEnt",
			"TheNightholdA",
			"TheNightholdB",
			"TheNightholdC",
			"TheNightholdD",
			"TheNightholdE",
			"TheNightholdF",
			"TheNightholdG",
			"TrialofValorA",
			"TrialofValorB",
			"TombofSargerasA",
			"TombofSargerasB",
			"TombofSargerasC",
			"TombofSargerasD",
			"TombofSargerasE",
			"TombofSargerasF",
			"TombofSargerasG",
		},
	},
	[ATLAS_DDL_EXPANSION] = {
		[ATLAS_DDL_EXPANSION_LEGION1] = { -- dungeons
			"TheArcwayEnt",
			"TheArcway",
			"AssaultonVioletHold",
			"BlackRookHoldA",
			"BlackRookHoldB",
			"BlackRookHoldC",
			"BlackRookHoldD",
			"CathedralofEternalNightA",
			"CathedralofEternalNightB",
			"CathedralofEternalNightC",
			"CathedralofEternalNightD",
			"CourtofStarsA",
			"CourtofStarsB",
			"DarkheartThicket",
			"EyeofAzshara",
			"HallsofValorA",
			"HallsofValorB",
			"HallsofValorC",
			"MawofSoulsA",
			"MawofSoulsB",
			"NeltharionsLair",
			"ReturntoKarazhanEnt", -- Legion
			"ReturntoKarazhanA", -- Legion
			"ReturntoKarazhanB", -- Legion
			"ReturntoKarazhanC", -- Legion
			"ReturntoKarazhanD", -- Legion
			"ReturntoKarazhanE", -- Legion
			"ReturntoKarazhanF", -- Legion
			"ReturntoKarazhanG", -- Legion
			"ReturntoKarazhanH", -- Legion
			"ReturntoKarazhanI", -- Legion
			"TheSeatoftheTriumvirate",
			"VaultoftheWardensA",
			"VaultoftheWardensB",
			"VaultoftheWardensC",
		},
		[ATLAS_DDL_EXPANSION_LEGION2] = { -- raids
			"AntorustheBurningThroneA",
			"AntorustheBurningThroneB",
			"AntorustheBurningThroneC",
			"AntorustheBurningThroneD",
			"AntorustheBurningThroneE",
			"AntorustheBurningThroneF",
			"AntorustheBurningThroneG",
			"TheEmeraldNightmareA",
			"TheEmeraldNightmareB",
			"TheEmeraldNightmareC",
			"TheEmeraldNightmareD",
			"TheEmeraldNightmareE",
			"TheEmeraldNightmareF",
			"TheEmeraldNightmareG",
			"TheEmeraldNightmareH",
			"TheNightholdEnt",
			"TheNightholdA",
			"TheNightholdB",
			"TheNightholdC",
			"TheNightholdD",
			"TheNightholdE",
			"TheNightholdF",
			"TheNightholdG",
			"TrialofValorA",
			"TrialofValorB",
			"TombofSargerasA",
			"TombofSargerasB",
			"TombofSargerasC",
			"TombofSargerasD",
			"TombofSargerasE",
			"TombofSargerasF",
			"TombofSargerasG",
		},
	},
	[ATLAS_DDL_LEVEL] = {
		[ATLAS_DDL_LEVEL_40TO45] = {
			"AssaultonVioletHold", -- Legion
			"DarkheartThicket", -- Legion
			"EyeofAzshara", -- Legion
			"HallsofValorA", -- Legion
			"HallsofValorB", -- Legion
			"HallsofValorC", -- Legion
			"NeltharionsLair", -- Legion
			"AntorustheBurningThroneA",
			"AntorustheBurningThroneB",
			"AntorustheBurningThroneC",
			"AntorustheBurningThroneD",
			"AntorustheBurningThroneE",
			"AntorustheBurningThroneF",
			"AntorustheBurningThroneG",
			"BlackRookHoldA",
			"BlackRookHoldB",
			"BlackRookHoldC",
			"BlackRookHoldD",
			"VaultoftheWardensA",
			"VaultoftheWardensB",
			"VaultoftheWardensC",
			"MawofSoulsA",
			"MawofSoulsB",
			"TheArcwayEnt",
			"TheArcway",
			"CathedralofEternalNightA",
			"CathedralofEternalNightB",
			"CathedralofEternalNightC",
			"CathedralofEternalNightD",
			"CourtofStarsA",
			"CourtofStarsB",
			"TheEmeraldNightmareA",
			"TheEmeraldNightmareB",
			"TheEmeraldNightmareC",
			"TheEmeraldNightmareD",
			"TheEmeraldNightmareE",
			"TheEmeraldNightmareF",
			"TheEmeraldNightmareG",
			"TheEmeraldNightmareH",
			"TheNightholdEnt",
			"TheNightholdA",
			"TheNightholdB",
			"TheNightholdC",
			"TheNightholdD",
			"TheNightholdE",
			"TheNightholdF",
			"TheNightholdG",
			"ReturntoKarazhanEnt", -- Legion
			"ReturntoKarazhanA", -- Legion
			"ReturntoKarazhanB", -- Legion
			"ReturntoKarazhanC", -- Legion
			"ReturntoKarazhanD", -- Legion
			"ReturntoKarazhanE", -- Legion
			"ReturntoKarazhanF", -- Legion
			"ReturntoKarazhanG", -- Legion
			"ReturntoKarazhanH", -- Legion
			"ReturntoKarazhanI", -- Legion
			"TheSeatoftheTriumvirate",
			"TrialofValorA",
			"TrialofValorB",
			"TombofSargerasA",
			"TombofSargerasB",
			"TombofSargerasC",
			"TombofSargerasD",
			"TombofSargerasE",
			"TombofSargerasF",
			"TombofSargerasG",
		},
	},
	[ATLAS_DDL_PARTYSIZE] = {
		[ATLAS_DDL_PARTYSIZE_5] = {
			"TheArcway",       -- Legion
			"TheArcwayEnt",    -- Legion
			"AssaultonVioletHold", -- Legion
			"BlackRookHoldA",  -- Legion
			"BlackRookHoldB",  -- Legion
			"BlackRookHoldC",  -- Legion
			"BlackRookHoldD",  -- Legion
			"CathedralofEternalNightA", -- Legion
			"CathedralofEternalNightB", -- Legion
			"CathedralofEternalNightC", -- Legion
			"CathedralofEternalNightD", -- Legion
			"CourtofStarsA",   -- Legion
			"CourtofStarsB",   -- Legion
			"DarkheartThicket", -- Legion
			"EyeofAzshara",    -- Legion
			"HallsofValorA",   -- Legion
			"HallsofValorB",   -- Legion
			"HallsofValorC",   -- Legion
			"MawofSoulsA",     -- Legion
			"MawofSoulsB",     -- Legion
			"NeltharionsLair", -- Legion
			"ReturntoKarazhanEnt", -- Legion
			"ReturntoKarazhanA", -- Legion
			"ReturntoKarazhanB", -- Legion
			"ReturntoKarazhanC", -- Legion
			"ReturntoKarazhanD", -- Legion
			"ReturntoKarazhanE", -- Legion
			"ReturntoKarazhanF", -- Legion
			"ReturntoKarazhanG", -- Legion
			"ReturntoKarazhanH", -- Legion
			"ReturntoKarazhanI", -- Legion
			"TheSeatoftheTriumvirate",
			"VaultoftheWardensA", -- Legion
			"VaultoftheWardensB", -- Legion
			"VaultoftheWardensC", -- Legion
		},
		[ATLAS_DDL_PARTYSIZE_10] = {
			"AntorustheBurningThroneA",
			"AntorustheBurningThroneB",
			"AntorustheBurningThroneC",
			"AntorustheBurningThroneD",
			"AntorustheBurningThroneE",
			"AntorustheBurningThroneF",
			"AntorustheBurningThroneG",
			"TheEmeraldNightmareA", -- Legion
			"TheEmeraldNightmareB", -- Legion
			"TheEmeraldNightmareC", -- Legion
			"TheEmeraldNightmareD", -- Legion
			"TheEmeraldNightmareE", -- Legion
			"TheEmeraldNightmareF", -- Legion
			"TheEmeraldNightmareG", -- Legion
			"TheEmeraldNightmareH", -- Legion
			"TheNightholdEnt", -- Legion
			"TheNightholdA", -- Legion
			"TheNightholdB", -- Legion
			"TheNightholdC", -- Legion
			"TheNightholdD", -- Legion
			"TheNightholdE", -- Legion
			"TheNightholdF", -- Legion
			"TheNightholdG", -- Legion
			"TombofSargerasA", -- Legion
			"TombofSargerasB", -- Legion
			"TombofSargerasC", -- Legion
			"TombofSargerasD", -- Legion
			"TombofSargerasE", -- Legion
			"TombofSargerasF", -- Legion
			"TombofSargerasG", -- Legion
		},
		[ATLAS_DDL_PARTYSIZE_20TO40] = {
			"AntorustheBurningThroneA",
			"AntorustheBurningThroneB",
			"AntorustheBurningThroneC",
			"AntorustheBurningThroneD",
			"AntorustheBurningThroneE",
			"AntorustheBurningThroneF",
			"AntorustheBurningThroneG",
			"TheEmeraldNightmareA", -- Legion
			"TheEmeraldNightmareB", -- Legion
			"TheEmeraldNightmareC", -- Legion
			"TheEmeraldNightmareD", -- Legion
			"TheEmeraldNightmareE", -- Legion
			"TheEmeraldNightmareF", -- Legion
			"TheEmeraldNightmareG", -- Legion
			"TheEmeraldNightmareH", -- Legion
			"TheNightholdEnt", -- Legion
			"TheNightholdA", -- Legion
			"TheNightholdB", -- Legion
			"TheNightholdC", -- Legion
			"TheNightholdD", -- Legion
			"TheNightholdE", -- Legion
			"TheNightholdF", -- Legion
			"TheNightholdG", -- Legion
			"TombofSargerasA", -- Legion
			"TombofSargerasB", -- Legion
			"TombofSargerasC", -- Legion
			"TombofSargerasD", -- Legion
			"TombofSargerasE", -- Legion
			"TombofSargerasF", -- Legion
			"TombofSargerasG", -- Legion
			"TrialofValorA", -- Legion
			"TrialofValorB", -- Legion
		},
	},
	[ATLAS_DDL_TYPE] = {
		[ATLAS_DDL_TYPE_INSTANCE] = {
			"AntorustheBurningThroneA",
			"AntorustheBurningThroneB",
			"AntorustheBurningThroneC",
			"AntorustheBurningThroneD",
			"AntorustheBurningThroneE",
			"AntorustheBurningThroneF",
			"AntorustheBurningThroneG",
			"TheArcway",       -- Legion
			"AssaultonVioletHold", -- Legion
			"BlackRookHoldA",  -- Legion
			"BlackRookHoldB",  -- Legion
			"BlackRookHoldC",  -- Legion
			"BlackRookHoldD",  -- Legion
			"CathedralofEternalNightA", -- Legion
			"CathedralofEternalNightB", -- Legion
			"CathedralofEternalNightC", -- Legion
			"CathedralofEternalNightD", -- Legion
			"CourtofStarsA",   -- Legion
			"CourtofStarsB",   -- Legion
			"DarkheartThicket", -- Legion
			"TheEmeraldNightmareA", -- Legion
			"TheEmeraldNightmareB", -- Legion
			"TheEmeraldNightmareC", -- Legion
			"TheEmeraldNightmareD", -- Legion
			"TheEmeraldNightmareE", -- Legion
			"TheEmeraldNightmareF", -- Legion
			"TheEmeraldNightmareG", -- Legion
			"TheEmeraldNightmareH", -- Legion
			"EyeofAzshara",    -- Legion
			"HallsofValorA",   -- Legion
			"HallsofValorB",   -- Legion
			"HallsofValorC",   -- Legion
			"MawofSoulsA",     -- Legion
			"MawofSoulsB",     -- Legion
			"NeltharionsLair", -- Legion
			"TheNightholdA",   -- Legion
			"TheNightholdB",   -- Legion
			"TheNightholdC",   -- Legion
			"TheNightholdD",   -- Legion
			"TheNightholdE",   -- Legion
			"TheNightholdF",   -- Legion
			"TheNightholdG",   -- Legion
			"ReturntoKarazhanEnt", -- Legion
			"ReturntoKarazhanA", -- Legion
			"ReturntoKarazhanB", -- Legion
			"ReturntoKarazhanC", -- Legion
			"ReturntoKarazhanD", -- Legion
			"ReturntoKarazhanE", -- Legion
			"ReturntoKarazhanF", -- Legion
			"ReturntoKarazhanG", -- Legion
			"ReturntoKarazhanH", -- Legion
			"ReturntoKarazhanI", -- Legion
			"VaultoftheWardensA", -- Legion
			"VaultoftheWardensB", -- Legion
			"VaultoftheWardensC", -- Legion
			"TheSeatoftheTriumvirate",
			"TrialofValorA",   -- Legion
			"TrialofValorB",   -- Legion
			"TombofSargerasA", -- Legion
			"TombofSargerasB", -- Legion
			"TombofSargerasC", -- Legion
			"TombofSargerasD", -- Legion
			"TombofSargerasE", -- Legion
			"TombofSargerasF", -- Legion
			"TombofSargerasG", -- Legion
		},
		[ATLAS_DDL_TYPE_ENTRANCE] = {
			"TheArcwayEnt", -- Legion
			"TheNightholdEnt", -- Legion
			"ReturntoKarazhanEnt", -- Legion
		},
	},
}
