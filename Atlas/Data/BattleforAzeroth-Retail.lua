--[[

	Atlas, a World of Warcraft instance map browser
	Copyright 2020 ~ 2023 - Arith Hsu, Atlas Team <atlas.addon at gmail dot com>

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

private.addon_name         = "Atlas_BattleforAzeroth"
private.module_name        = "BattleforAzeroth"

local BZ                   = Atlas_GetLocaleLibBabble("LibBabble-SubZone-3.0")
local L                    = LibStub("AceLocale-3.0"):GetLocale(private.addon_name)
local ALC                  = LibStub("AceLocale-3.0"):GetLocale("Atlas")
local Atlas                = LibStub("AceAddon-3.0"):GetAddon("Atlas")
local BfA                  = Atlas:NewModule(private.module_name)

local db                   = {}
BfA.db                     = db

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
	-- /////////////////////////////////
	-- Kul Tiras instances
	-- /////////////////////////////////
	-- Battle of Dazar'alor, Raid
	BattleofDazaralorA = { -- The Zocalo, Horde
		ZoneName = { BZ["Battle of Dazar'alor"]..ALC["MapA"] },
		Location = { BZ["Tiragarde Sound"] },
		DungeonID = 1942,
		DungeonHeroicID = 1943,
		DungeonMythicID = 1944,
		PlayerLimit = { 10, 30 },
		WorldMapID = 1358,
		JournalInstanceID = 1176,
		ZoneID = 0,
		Module = "Atlas_BattleforAzeroth",
		NextMap = "BattleofDazaralorB",
		{ BLUE.." A) "..ALC["Entrance"]..ALC["L-Parenthesis"]..FACTION_HORDE..ALC["R-Parenthesis"], 10001 },
		{ BLUE.." B-G) "..ALC["Connection"],                                                        10002 },
		{ WHIT.." 1) "..Atlas_GetBossName("Champion of the Light", 2333),                           2333 },
		{ WHIT..INDENT..Atlas_GetBossName("Frida Ironbellows", 2333, 1), },
		{ WHIT..INDENT..Atlas_GetBossName("Anointed Disciple", 2333, 2), },
		{ WHIT..INDENT..Atlas_GetBossName("Darkforged Crusader", 2333, 3), },
		{ WHIT.." 2) "..Atlas_GetBossName("Grong, the Jungle Lord", 2325),                          2325 },
		{ WHIT..INDENT..Atlas_GetBossName("Grong", 2325, 1), },
		{ WHIT..INDENT..Atlas_GetBossName("Flying Ape Wranglers", 2325, 2), },
		{ WHIT..INDENT..Atlas_GetBossName("Apetagonizer 3000", 2325, 3), },
		{ WHIT.." 3) "..Atlas_GetBossName("Jadefire Masters", 2341),                                2341 },
		{ WHIT..INDENT..Atlas_GetBossName("Manceroy Flamefist", 2341, 1), },
		{ WHIT..INDENT..Atlas_GetBossName("Mestrah", 2341, 2), },
	},
	BattleofDazaralorB = { -- Port of Zandalar, Alliance
		ZoneName = { BZ["Battle of Dazar'alor"]..ALC["MapB"] },
		Location = { BZ["Tiragarde Sound"] },
		DungeonID = 1942,
		DungeonHeroicID = 1943,
		DungeonMythicID = 1944,
		PlayerLimit = { 10, 30 },
		WorldMapID = 1352,
		JournalInstanceID = 1176,
		ZoneID = 0,
		Module = "Atlas_BattleforAzeroth",
		PrevMap = "BattleofDazaralorA",
		NextMap = "BattleofDazaralorC",
		{ BLUE.." A) "..ALC["Entrance"]..ALC["L-Parenthesis"]..FACTION_ALLIANCE..ALC["R-Parenthesis"], 10001 },
		{ BLUE.." B-G) "..ALC["Connection"],                                                           10002 },
		{ WHIT.." 1) "..Atlas_GetBossName("Champion of the Light", 2334),                              2334 },
		{ WHIT..INDENT..Atlas_GetBossName("High Tinker Mekkatorque", 2334, 1), },
		{ WHIT..INDENT..Atlas_GetBossName("Spark Bot", 2334, 2), },
		{ WHIT..INDENT..Atlas_GetBossName("Explosive Sheep", 2334, 3), },
		{ WHIT.." 2) "..Atlas_GetBossName("Jadefire Masters", 2323),                                   2323 },
		{ WHIT..INDENT..Atlas_GetBossName("Ma'ra Grimfang", 2323, 1), },
		{ WHIT..INDENT..Atlas_GetBossName("Anathos Firecaller", 2323, 2), },
		{ WHIT.." 3) "..Atlas_GetBossName("Grong, the Revenant", 2340),                                2340 }, -- Alliance
		{ WHIT..INDENT..Atlas_GetBossName("Death Specter", 2340, 2), },
	},
	BattleofDazaralorC = { -- Halls of Opulence
		ZoneName = { BZ["Battle of Dazar'alor"]..ALC["MapC"] },
		Location = { BZ["Tiragarde Sound"] },
		DungeonID = 1942,
		DungeonHeroicID = 1943,
		DungeonMythicID = 1944,
		PlayerLimit = { 10, 30 },
		WorldMapID = 1353,
		JournalInstanceID = 1176,
		ZoneID = 0,
		Module = "Atlas_BattleforAzeroth",
		PrevMap = "BattleofDazaralorB",
		NextMap = "BattleofDazaralorD",
		{ BLUE.." B-G) "..ALC["Connection"],                 10002 },
		{ WHIT.." 5) "..Atlas_GetBossName("Opulence", 2342), 2342 },
	},
	BattleofDazaralorD = { -- Loa's Sanctum
		ZoneName = { BZ["Battle of Dazar'alor"]..ALC["MapD"] },
		Location = { BZ["Tiragarde Sound"] },
		DungeonID = 1942,
		DungeonHeroicID = 1943,
		DungeonMythicID = 1944,
		PlayerLimit = { 10, 30 },
		WorldMapID = 1354,
		JournalInstanceID = 1176,
		ZoneID = 0,
		Module = "Atlas_BattleforAzeroth",
		PrevMap = "BattleofDazaralorC",
		NextMap = "BattleofDazaralorE",
		{ BLUE.." B-G) "..ALC["Connection"],                               10002 },
		{ WHIT.." 6) "..Atlas_GetBossName("Conclave of the Chosen", 2330), 2330 },
		{ WHIT..INDENT..Atlas_GetBossName("Pa'ku's Aspect", 2330, 1), },
		{ WHIT..INDENT..Atlas_GetBossName("Gonk's Aspect", 2330, 2), },
		{ WHIT..INDENT..Atlas_GetBossName("Kimbul's Aspect", 2330, 3), },
		{ WHIT..INDENT..Atlas_GetBossName("Akunda's Aspect", 2330, 4), },

	},
	BattleofDazaralorE = { -- Heart of the Empire
		ZoneName = { BZ["Battle of Dazar'alor"]..ALC["MapE"] },
		Location = { BZ["Tiragarde Sound"] },
		DungeonID = 1942,
		DungeonHeroicID = 1943,
		DungeonMythicID = 1944,
		PlayerLimit = { 10, 30 },
		WorldMapID = 1357,
		JournalInstanceID = 1176,
		ZoneID = 0,
		Module = "Atlas_BattleforAzeroth",
		PrevMap = "BattleofDazaralorD",
		NextMap = "BattleofDazaralorF",
		{ BLUE.." B-G) "..ALC["Connection"],                               10002 },
		{ WHIT.." 4) "..Atlas_GetBossName("King Rastakhan", 2335),         2335 },
		{ WHIT..INDENT..Atlas_GetBossName("Bwonsamdi", 2335, 2), },
		{ WHIT..INDENT..Atlas_GetBossName("Prelate Za'lan", 2335, 3), },
		{ WHIT..INDENT..Atlas_GetBossName("Headhunter Gal'wana", 2335, 4), },
		{ WHIT..INDENT..Atlas_GetBossName("Siegebreaker Roka", 2335, 5), },
		{ WHIT..INDENT..Atlas_GetBossName("Rastari Honorguard", 2335, 6), },
	},
	BattleofDazaralorF = {
		ZoneName = { BZ["Battle of Dazar'alor"]..ALC["MapF"] },
		Location = { BZ["Tiragarde Sound"] },
		DungeonID = 1942,
		DungeonHeroicID = 1943,
		DungeonMythicID = 1944,
		PlayerLimit = { 10, 30 },
		WorldMapID = 1352,
		JournalInstanceID = 1176,
		ZoneID = 0,
		Module = "Atlas_BattleforAzeroth",
		PrevMap = "BattleofDazaralorE",
		--		{ WHIT.." 8) "..Atlas_GetBossName("Stormwall Blockade", 2337), 2337},
		--		{ WHIT..INDENT..Atlas_GetBossName("Laminaria", 2337, 1), },
		--		{ WHIT..INDENT..Atlas_GetBossName("Sister Katherine", 2337, 2), },
		{ WHIT.." 7) "..Atlas_GetBossName("Lady Jaina Proudmoore", 2343), 2343 },
	},
	-- Crucible of Storms, Raid
	CrucibleofStormsA = {
		ZoneName = { BZ["Crucible of Storms"]..ALC["MapA"] },
		Location = { BZ["Stormsong Valley"] },
		DungeonID = 1952,
		DungeonHeroicID = 1953,
		DungeonMythicID = 1954,
		PlayerLimit = { 10, 30 },
		WorldMapID = 1345,
		JournalInstanceID = 1177,
		ZoneID = 10057,
		Module = "Atlas_BattleforAzeroth",
		NextMap = "CrucibleofStormsB",
		{ BLUE.." A) "..ALC["Entrance"],                                  10001 },
		{ BLUE.." B) "..ALC["Connection"],                                10002 },
		{ WHIT.." 1) "..Atlas_GetBossName("The Restless Cabal", 2328),    2328 },
		{ WHIT..INDENT..Atlas_GetBossName("Zaxasj the Speaker", 2328, 1) },
		{ WHIT..INDENT..Atlas_GetBossName("Fa'thuul the Feared", 2328, 2) },
	},
	CrucibleofStormsB = {
		ZoneName = { BZ["Crucible of Storms"]..ALC["MapB"] },
		Location = { BZ["Stormsong Valley"] },
		DungeonID = 1952,
		DungeonHeroicID = 1953,
		DungeonMythicID = 1954,
		PlayerLimit = { 10, 30 },
		WorldMapID = 1346,
		JournalInstanceID = 1177,
		ZoneID = 10057,
		Module = "Atlas_BattleforAzeroth",
		PrevMap = "CrucibleofStormsA",
		{ BLUE.." B) "..ALC["Connection"],                                        10002 },
		{ WHIT.." 2) "..Atlas_GetBossName("Uu'nat, Harbinger of the Void", 2332), 2332 },
	},
	-- Freehold
	Freehold = {
		ZoneName = { BZ["Freehold"] },
		Location = { BZ["Tiragarde Sound"] },
		DungeonID = 1672,
		DungeonHeroicID = 1704,
		--		DungeonMythicID = 1704,
		WorldMapID = 936,
		JournalInstanceID = 1001,
		Module = "Atlas_BattleforAzeroth",
		{ WHIT.." 1) "..Atlas_GetBossName("Skycap'n Kragg", 2102),      2102 },
		{ WHIT..INDENT..Atlas_GetBossName("Shark Bait", 2012, 2), },
		{ WHIT.." 2) "..Atlas_GetBossName("Council o' Captains", 2093), 2093 },
		{ WHIT..INDENT..Atlas_GetBossName("Captain Eudora", 2093, 1), },
		{ WHIT..INDENT..Atlas_GetBossName("Captain Jolly", 2093, 2), },
		{ WHIT..INDENT..Atlas_GetBossName("Captain Raoul", 2093, 3), },
		{ WHIT.." 3) "..Atlas_GetBossName("Ring of Booty", 2094),       2094 },
		{ WHIT.." 4) "..Atlas_GetBossName("Harlan Sweete", 2095),       2095 },
	},
	-- Operation: Mechagon
	OperationMechagonA = {
		ZoneName = { BZ["Operation: Mechagon"]..ALC["MapA"] },
		Location = { BZ["Mechagon"] },
		DungeonMythicID = 2006,
		WorldMapID = 1490,
		JournalInstanceID = 1178,
		Module = "Atlas_BattleforAzeroth",
		--		NextMap = "OperationMechagonB",
		{ WHIT.." 1) "..Atlas_GetBossName("King Gobbamak", 2357),               2357 }, -- MapID: 1490
		{ WHIT..INDENT..Atlas_GetBossName("Scrapbone Scavenger", 2357, 2),      2357 },
		{ WHIT..INDENT..Atlas_GetBossName("Stolen Scrap Bot", 2357, 3),         2357 },
		{ WHIT..INDENT..Atlas_GetBossName("Stolen Shock Coil", 2357, 4),        2357 },
		{ WHIT.." 2) "..Atlas_GetBossName("Trixie & Naeno", 2360),              2360 }, -- MapID: 1490
		{ WHIT..INDENT..Atlas_GetBossName("Trixie Tazer", 2360, 1),             2360 },
		{ WHIT..INDENT..Atlas_GetBossName("Naeno Megacrash", 2360, 2),          2360 },
		{ WHIT..INDENT..Atlas_GetBossName("Mechacycle", 2360, 3),               2360 },
		{ WHIT.." 3) "..Atlas_GetBossName("Gunker", 2358),                      2358 }, -- MapID: 1490
		{ WHIT..INDENT..Atlas_GetBossName("Squirt Bot", 2358, 2),               2358 },
		{ WHIT.." 4) "..Atlas_GetBossName("HK-8 Aerial Oppression Unit", 2355), 2355 }, -- MapID: 1490
	},
	OperationMechagonB = {
		ZoneName = { BZ["Operation: Mechagon"]..ALC["MapB"] },
		Location = { BZ["Mechagon"] },
		DungeonMythicID = 2006,
		WorldMapID = 1490,
		JournalInstanceID = 1178,
		Module = "Atlas_BattleforAzeroth",
		PrevMap = "OperationMechagonA",
		{ WHIT.." 5) "..Atlas_GetBossName("Tussle Tonks", 2336),             2336 }, -- MapID: 1491
		{ WHIT..INDENT..Atlas_GetBossName("The Platinum Pummeler", 2336, 1), 2336 },
		{ WHIT..INDENT..Atlas_GetBossName("Gnomercy 4.U.", 2336, 2),         2336 },
		{ WHIT.." 6) "..Atlas_GetBossName("K.U.-J.0.", 2339),                2339 }, -- MapID: 1494
		{ WHIT.." 7) "..Atlas_GetBossName("Machinist's Garden", 2348),       2348 }, -- MapID: 1497
		{ WHIT.." 8) "..Atlas_GetBossName("King Mechagon", 2331),            2331 }, -- MapID: 1497
	},
	-- Shrine of the Storm
	ShrineoftheStormA = {
		ZoneName = { BZ["Shrine of the Storm"]..ALC["MapA"] },
		Location = { BZ["Stormsong Valley"] },
		DungeonID = 1774,
		DungeonHeroicID = 1710,
		--		DungeonMythicID = 1710,
		WorldMapID = 1039,
		JournalInstanceID = 1036,
		ZoneID = 9525,
		Module = "Atlas_BattleforAzeroth",
		NextMap = "ShrineoftheStormB",
		{ BLUE.." A) "..ALC["Entrance"],                                   10001 },
		{ BLUE.." B) "..ALC["Connection"],                                 10002 },
		{ WHIT.." 1) "..Atlas_GetBossName("Aqu'sirr", 2153),               2153 },
		{ WHIT.." 2) "..Atlas_GetBossName("Tidesage Council", 2154),       2154 },
		{ WHIT..INDENT..Atlas_GetBossName("Brother Ironhull", 2154, 1) },
		{ WHIT..INDENT..Atlas_GetBossName("Galecaller Faye", 2154, 2) },
		{ WHIT.." 4) "..Atlas_GetBossName("Vol'zith the Whisperer", 2156), 2156 },
	},
	ShrineoftheStormB = {
		ZoneName = { BZ["Shrine of the Storm"]..ALC["MapB"] },
		Location = { BZ["Stormsong Valley"] },
		DungeonID = 1774,
		DungeonHeroicID = 1710,
		--		DungeonMythicID = 1710,
		WorldMapID = 1040,
		JournalInstanceID = 1036,
		ZoneID = 9525,
		Module = "Atlas_BattleforAzeroth",
		PrevMap = "ShrineoftheStormA",
		{ BLUE.." B) "..ALC["Connection"],                         10002 },
		{ WHIT.." 3) "..Atlas_GetBossName("Lord Stormsong", 2155), 2155 },
	},
	-- Siege of Boralus
	SiegeofBoralus = {
		ZoneName = { BZ["Siege of Boralus"] },
		Location = { BZ["Tiragarde Sound"] },
		--		DungeonID = 0,
		DungeonHeroicID = 1700,
		--		DungeonMythicID = 0,
		WorldMapID = 1162,
		JournalInstanceID = 1023,
		ZoneID = 9354,
		Module = "Atlas_BattleforAzeroth",
		{ BLUE.." A) "..ALC["Entrance"],                                   10001 },
		{ WHIT.." 1) "..Atlas_GetBossName("Chopper Redhook", 2132),        2132 },
		{ WHIT..INDENT..Atlas_GetBossName("Sergeant Bainbridge", 2133),    2133 },
		{ WHIT.." 2) "..Atlas_GetBossName("Dread Captain Lockwood", 2173), 2173 },
		{ WHIT.." 3) "..Atlas_GetBossName("Hadal Darkfathom", 2134),       2134 },
		{ WHIT.." 4) "..Atlas_GetBossName("Viq'Goth", 2140),               2140 },
	},
	-- Tol Dagor
	TolDagorA = {
		ZoneName = { BZ["Tol Dagor"]..ALC["MapA"] },
		Location = { BZ["Tol Dagor"] },
		DungeonID = 1713,
		DungeonHeroicID = 1714,
		--		DungeonMythicID = 1714,
		WorldMapID = 974,
		JournalInstanceID = 1002,
		Module = "Atlas_BattleforAzeroth",
		NextMap = "TolDagorB",
		{ WHIT.." 1) "..Atlas_GetBossName("The Sand Queen", 2097),        2097 },
		{ WHIT.." 3) "..Atlas_GetBossName("Knight Captain Valyri", 2099), 2099 },
		{ WHIT.." 4) "..Atlas_GetBossName("Overseer Korgus", 2096),       2096 },
	},
	TolDagorB = {
		ZoneName = { BZ["Tol Dagor"]..ALC["MapB"] },
		Location = { BZ["Tol Dagor"] },
		DungeonID = 1713,
		DungeonHeroicID = 1714,
		--		DungeonMythicID = 1714,
		WorldMapID = 977,
		JournalInstanceID = 1002,
		Module = "Atlas_BattleforAzeroth",
		PrevMap = "TolDagorA",
		{ BLUE.." B-E) "..ALC["Connection"],                   10002 },
		{ WHIT.." 2) "..Atlas_GetBossName("Jes Howlis", 2098), 2098 },
	},
	-- Waycrest Manor
	WaycrestManorA = {
		ZoneName = { BZ["Waycrest Manor"]..ALC["MapA"] },
		Location = { BZ["Drustvar"] },
		DungeonID = 1705,
		DungeonHeroicID = 1706,
		--		DungeonMythicID = 1706,
		WorldMapID = 1015,
		JournalInstanceID = 1021,
		Module = "Atlas_BattleforAzeroth",
		NextMap = "WaycrestManorB",
		{ BLUE.." A) "..ALC["Entrance"],                                10001 },
		{ BLUE.." B) "..ALC["Connection"],                              10002 },
		{ WHIT.." 1) "..Atlas_GetBossName("Heartsbane Triad", 2125),    2125 },
		{ WHIT..INDENT..Atlas_GetBossName("Sister Briar", 2125, 1),     2125 },
		{ WHIT..INDENT..Atlas_GetBossName("Sister Malady", 2125, 2),    2125 },
		{ WHIT..INDENT..Atlas_GetBossName("Sister Solena", 2125, 3),    2125 },
		{ WHIT.." 2) "..Atlas_GetBossName("Soulbound Goliath", 2126),   2126 },
		{ WHIT.." 3) "..Atlas_GetBossName("Raal the Gluttonous", 2127), 2127 },
		{ WHIT..INDENT..Atlas_GetBossName("Wasting Servant", 2127, 2),  2127 },
		{ WHIT..INDENT..Atlas_GetBossName("Bile Oozeling", 2127, 3),    2127 },
	},
	WaycrestManorB = {
		ZoneName = { BZ["Waycrest Manor"]..ALC["MapB"] },
		Location = { BZ["Drustvar"] },
		DungeonID = 1705,
		DungeonHeroicID = 1706,
		--		DungeonMythicID = 1706,
		WorldMapID = 1018,
		JournalInstanceID = 1021,
		Module = "Atlas_BattleforAzeroth",
		PrevMap = "WaycrestManorA",
		{ BLUE.." B-D) "..ALC["Connection"],                               10002 },
		{ WHIT.." 4) "..Atlas_GetBossName("Lord and Lady Waycrest", 2128), 2128 },
		{ WHIT..INDENT..Atlas_GetBossName("Lord Waycrest", 2128, 1),       2128 },
		{ WHIT..INDENT..Atlas_GetBossName("Lady Waycrest", 2128, 2),       2128 },
		{ WHIT.." 5) "..Atlas_GetBossName("Gorak Tul", 2129),              2129 },
		{ WHIT..INDENT..Atlas_GetBossName("Deathtouched Slaver", 2129, 2), 2129 },
	},

	-- /////////////////////////////////
	-- Zuldazar instances
	-- /////////////////////////////////
	-- Atal'Dazar
	AtalDazar = {
		ZoneName = { BZ["Atal'Dazar"] },
		Location = { BZ["Zuldazar"] },
		DungeonID = 1668,
		DungeonHeroicID = 1772,
		DungeonMythicID = 1669,
		WorldMapID = 934,
		JournalInstanceID = 968,
		ZoneID = 9028,
		Module = "Atlas_BattleforAzeroth",
		{ BLUE.." A) "..ALC["Entrance"],                              10001 },
		{ WHIT.." 1) "..Atlas_GetBossName("Priestess Alun'za", 2082), 2082 },
		{ WHIT.." 2) "..Atlas_GetBossName("Vol'kaal", 2036),          2036 },
		{ WHIT.." 3) "..Atlas_GetBossName("Rezan", 2083),             2083 },
		{ WHIT..INDENT..Atlas_GetBossName("Ancient Bones", 2083, 2), },
		{ WHIT.." 4) "..Atlas_GetBossName("Yazma", 2030),             2030 },
	},
	-- Kings' Rest
	KingsRest = {
		ZoneName = { BZ["Kings' Rest"] },
		Location = { BZ["Zuldazar"] },
		DungeonID = 1784,
		DungeonHeroicID = 1785,
		--		DungeonMythicID = 1785,
		WorldMapID = 1004,
		JournalInstanceID = 1041,
		Module = "Atlas_BattleforAzeroth",
		{ BLUE.." A) "..ALC["Entrance"],                                     10001 },
		{ WHIT.." 1) "..Atlas_GetBossName("The Golden Serpent", 2165),       2165 },
		{ WHIT.." 2) "..Atlas_GetBossName("Mchimba the Embalmer", 2171),     2171 },
		{ WHIT.." 3) "..Atlas_GetBossName("The Council of Tribes", 2170),    2170 },
		{ WHIT..INDENT..Atlas_GetBossName("Aka'ali the Conqueror", 2170, 1), },
		{ WHIT..INDENT..Atlas_GetBossName("Zanazal the Wise", 2170, 2), },
		{ WHIT..INDENT..Atlas_GetBossName("Kula the Butcher", 2170, 3), },
		{ WHIT.." 4) "..Atlas_GetBossName("Dazar, The First King", 2172),    2172 },
	},
	-- The MOTHERLODE!!
	TheMOTHERLODE = {
		ZoneName = { BZ["The MOTHERLODE!!"] },
		Location = { BZ["Zuldazar"] },
		DungeonID = 1707,
		DungeonHeroicID = 1776,
		DungeonMythicID = 1708,
		WorldMapID = 1010,
		JournalInstanceID = 1012,
		Module = "Atlas_BattleforAzeroth",
		{ WHIT.." 1) "..Atlas_GetBossName("Coin-Operated Crowd Pummeler", 2109), 2109 },
		{ WHIT.." 2) "..Atlas_GetBossName("Azerokk", 2114),                      2114 },
		{ WHIT.." 3) "..Atlas_GetBossName("Rixxa Fluxflame", 2115),              2115 },
		{ WHIT.." 4) "..Atlas_GetBossName("Mogul Razdunk", 2116),                2116 },
	},
	-- Temple of Sethraliss
	TempleofSethraliss = {
		ZoneName = { BZ["Temple of Sethraliss"] },
		Location = { BZ["Vol'dun"] },
		DungeonID = 1694,
		DungeonHeroicID = 1775,
		DungeonMythicID = 1695,
		WorldMapID = 1038,
		JournalInstanceID = 1030,
		Module = "Atlas_BattleforAzeroth",
		{ BLUE.." A) "..ALC["Entrance"],                                    10001 },
		{ WHIT.." 1) "..Atlas_GetBossName("Adderis and Aspix", 2142),       2142 },
		{ WHIT.." 2) "..Atlas_GetBossName("Merektha", 2143),                2143 },
		{ WHIT..INDENT..Atlas_GetBossName("Venomous Ophidian", 2143, 2), },
		{ WHIT..INDENT..Atlas_GetBossName("Sand-crusted Striker", 2143, 3), },
		{ WHIT.." 3) "..Atlas_GetBossName("Galvazzt", 2144),                2144 },
		{ WHIT.." 4) "..Atlas_GetBossName("Avatar of Sethraliss", 2145),    2145 },
		{ WHIT..INDENT..Atlas_GetBossName("Hoodoo Hexxer", 2145, 2), },
		{ WHIT..INDENT..Atlas_GetBossName("Heart Guardian", 2145, 3), },
		{ WHIT..INDENT..Atlas_GetBossName("Plague Doctor", 2145, 4), },
	},
	-- Uldir
	UldirA = {
		ZoneName = { BZ["Uldir"]..ALC["MapA"] },
		Location = { BZ["Nazmir"] },
		DungeonID = 1887,
		DungeonHeroicID = 1888,
		DungeonMythicID = 1889,
		PlayerLimit = { 10, 30 },
		WorldMapID = 1148,
		JournalInstanceID = 1031,
		Module = "Atlas_BattleforAzeroth",
		NextMap = "UldirB",
		{ BLUE.." A) "..ALC["Entrance"],                                      10001 },
		{ BLUE.." B-G) "..ALC["Connection"],                                  10002 },
		{ WHIT.." 1) "..Atlas_GetBossName("Taloc", 2168),                     2168 },
		{ WHIT..INDENT..Atlas_GetBossName("Volatile Droplet", 2168, 2), },
		{ WHIT..INDENT..Atlas_GetBossName("Coalesced Blood", 2168, 3), },
		{ WHIT.." 2) "..Atlas_GetBossName("MOTHER", 2167),                    2167 },
		{ WHIT..INDENT..Atlas_GetBossName("Remnant of Corruption", 2167, 2), },
		{ WHIT..INDENT..Atlas_GetBossName("Resistant Bacterium", 2167, 3), },
		{ WHIT..INDENT..Atlas_GetBossName("Viral Contagion", 2167, 4), },
		{ WHIT.." 3) "..Atlas_GetBossName("Fetid Devourer", 2146),            2146 },
		{ WHIT..INDENT..Atlas_GetBossName("Corruption Corpuscle", 2146, 2), },
		{ WHIT.." 4) "..Atlas_GetBossName("Zek'voz, Herald of N'zoth", 2169), 2169 },
		{ WHIT..INDENT..Atlas_GetBossName("Zek'voz", 2169, 1), },
		{ WHIT..INDENT..Atlas_GetBossName("Silithid Warrior", 2169, 2), },
		{ WHIT..INDENT..Atlas_GetBossName("Nerubian Voidweaver", 2169, 3), },
		{ WHIT.." 5) "..Atlas_GetBossName("Vectis", 2166),                    2166 },
		{ WHIT.." 6) "..Atlas_GetBossName("Zul, Reborn", 2195),               2195 },
		{ WHIT..INDENT..Atlas_GetBossName("Zul", 2195, 1), },
		{ WHIT..INDENT..Atlas_GetBossName("Nazmani Crusher", 2195, 2), },
		{ WHIT..INDENT..Atlas_GetBossName("Nazmani Bloodhexer", 2195, 3), },
		{ WHIT..INDENT..Atlas_GetBossName("Bloodthirsty Crawg", 2195, 4), },
	},
	UldirB = {
		ZoneName = { BZ["Uldir"]..ALC["MapB"] },
		Location = { BZ["Nazmir"] },
		DungeonID = 1887,
		DungeonHeroicID = 1888,
		DungeonMythicID = 1889,
		PlayerLimit = { 10, 30 },
		WorldMapID = 1148,
		JournalInstanceID = 1031,
		Module = "Atlas_BattleforAzeroth",
		PrevMap = "UldirA",
		NextMap = "UldirC",
		{ BLUE.." A) "..ALC["Entrance"],                                10001 },
		{ BLUE.." B-G) "..ALC["Connection"],                            10002 },
		{ WHIT.." 1) "..Atlas_GetBossName("Taloc", 2168),               2168 },
		{ WHIT..INDENT..Atlas_GetBossName("Volatile Droplet", 2168, 2), },
		{ WHIT..INDENT..Atlas_GetBossName("Coalesced Blood", 2168, 3), },
	},
	UldirC = {
		ZoneName = { BZ["Uldir"]..ALC["MapC"] },
		Location = { BZ["Nazmir"] },
		DungeonID = 1887,
		DungeonHeroicID = 1888,
		DungeonMythicID = 1889,
		PlayerLimit = { 10, 30 },
		WorldMapID = 1149,
		JournalInstanceID = 1031,
		Module = "Atlas_BattleforAzeroth",
		PrevMap = "UldirB",
		NextMap = "UldirD",
		{ BLUE.." B-G) "..ALC["Connection"],                                 10002 },
		{ WHIT.." 2) "..Atlas_GetBossName("MOTHER", 2167),                   2167 },
		{ WHIT..INDENT..Atlas_GetBossName("Remnant of Corruption", 2167, 2), },
		{ WHIT..INDENT..Atlas_GetBossName("Resistant Bacterium", 2167, 3), },
		{ WHIT..INDENT..Atlas_GetBossName("Viral Contagion", 2167, 4), },
	},
	UldirD = {
		ZoneName = { BZ["Uldir"]..ALC["MapD"] },
		Location = { BZ["Nazmir"] },
		DungeonID = 1887,
		DungeonHeroicID = 1888,
		DungeonMythicID = 1889,
		PlayerLimit = { 10, 30 },
		WorldMapID = 1153,
		JournalInstanceID = 1031,
		Module = "Atlas_BattleforAzeroth",
		PrevMap = "UldirC",
		NextMap = "UldirE",
		{ BLUE.." B-G) "..ALC["Connection"],                                10002 },
		{ WHIT.." 3) "..Atlas_GetBossName("Fetid Devourer", 2146),          2146 },
		{ WHIT..INDENT..Atlas_GetBossName("Corruption Corpuscle", 2146, 2), },
	},
	UldirE = {
		ZoneName = { BZ["Uldir"]..ALC["MapE"] },
		Location = { BZ["Nazmir"] },
		DungeonID = 1887,
		DungeonHeroicID = 1888,
		DungeonMythicID = 1889,
		PlayerLimit = { 10, 30 },
		WorldMapID = 1151,
		JournalInstanceID = 1031,
		Module = "Atlas_BattleforAzeroth",
		PrevMap = "UldirD",
		NextMap = "UldirF",
		{ BLUE.." B-G) "..ALC["Connection"],                                  10002 },
		{ WHIT.." 4) "..Atlas_GetBossName("Zek'voz, Herald of N'zoth", 2169), 2169 },
		{ WHIT..INDENT..Atlas_GetBossName("Zek'voz", 2169, 1), },
		{ WHIT..INDENT..Atlas_GetBossName("Silithid Warrior", 2169, 2), },
		{ WHIT..INDENT..Atlas_GetBossName("Nerubian Voidweaver", 2169, 3), },
	},
	UldirF = {
		ZoneName = { BZ["Uldir"]..ALC["MapF"] },
		Location = { BZ["Nazmir"] },
		DungeonID = 1887,
		DungeonHeroicID = 1888,
		DungeonMythicID = 1889,
		PlayerLimit = { 10, 30 },
		WorldMapID = 1152,
		JournalInstanceID = 1031,
		Module = "Atlas_BattleforAzeroth",
		PrevMap = "UldirE",
		NextMap = "UldirG",
		{ BLUE.." B-G) "..ALC["Connection"],               10002 },
		{ WHIT.." 5) "..Atlas_GetBossName("Vectis", 2166), 2166 },
	},
	UldirG = {
		ZoneName = { BZ["Uldir"]..ALC["MapG"] },
		Location = { BZ["Nazmir"] },
		DungeonID = 1887,
		DungeonHeroicID = 1888,
		DungeonMythicID = 1889,
		PlayerLimit = { 10, 30 },
		WorldMapID = 1155,
		JournalInstanceID = 1031,
		Module = "Atlas_BattleforAzeroth",
		PrevMap = "UldirF",
		{ BLUE.." B-G) "..ALC["Connection"],                                  10002 },
		{ WHIT.." 7) "..Atlas_GetBossName("Mythrax the Unraveler", 2194),     2194 },
		{ WHIT.." 8) "..Atlas_GetBossName("G'huun", 2147),                    2147 },
		{ WHIT..INDENT..Atlas_GetBossName("Blightspreader Tendril", 2147, 2), },
		{ WHIT..INDENT..Atlas_GetBossName("Cyclopean Terror", 2147, 3), },
		{ WHIT..INDENT..Atlas_GetBossName("Dark Young", 2147, 4), },
	},
	-- The Underrot
	TheUnderrot = {
		ZoneName = { BZ["The Underrot"] },
		Location = { BZ["Nazmir"] },
		DungeonID = 1711,
		DungeonHeroicID = 1777,
		DungeonMythicID = 1712,
		WorldMapID = 1041,
		JournalInstanceID = 1022,
		Module = "Atlas_BattleforAzeroth",
		{ BLUE.." A) "..ALC["Entrance"],                                 10001 },
		{ WHIT.." 1) "..Atlas_GetBossName("Elder Leaxa", 2157),          2157 },
		{ WHIT.." 2) "..Atlas_GetBossName("Cragmaw the Infested", 2131), 2131 },
		{ WHIT.." 3) "..Atlas_GetBossName("Sporecaller Zancha", 2130),   2130 },
		{ WHIT.." 4) "..Atlas_GetBossName("Unbound Abomination", 2158),  2158 },
	},

	-- The Eternal Palace
	TheEternalPalaceA = {
		ZoneName = { BZ["The Eternal Palace"]..ALC["MapA"] },
		Location = { BZ["Nazjatar"] },
		DungeonID = 2014,
		DungeonHeroicID = 2014,
		DungeonMythicID = 2016,
		WorldMapID = 1512,
		JournalInstanceID = 1179,
		PlayerLimit = { 10, 30 },
		Module = "Atlas_BattleforAzeroth",
		{ BLUE.." A) "..ALC["Entrance"],                                     10001 },
		{ WHIT.." 1) "..Atlas_GetBossName("Abyssal Commander Sivara", 2352), 2352 }, -- uiMap: 1512
		{ BLUE.." B) "..ALC["Connection"],                                   10002 },
	},
	TheEternalPalaceB = {
		ZoneName = { BZ["The Eternal Palace"]..ALC["MapB"] },
		Location = { BZ["Nazjatar"] },
		DungeonID = 2014,
		DungeonHeroicID = 2014,
		DungeonMythicID = 2016,
		WorldMapID = 1513,
		JournalInstanceID = 1179,
		PlayerLimit = { 10, 30 },
		Module = "Atlas_BattleforAzeroth",
		{ WHIT.." 2) "..Atlas_GetBossName("Radiance of Azshara", 2353),            2353 }, -- uiMap: 1513
		{ WHIT.." 3) "..Atlas_GetBossName("Lady Ashvane", 2354),                   2354 }, -- uiMap: 1513
		{ WHIT.." 4) "..Atlas_GetBossName("Blackwater Behemoth", 2347),            2347 }, -- uiMap: 1514
		{ WHIT.." 5) "..Atlas_GetBossName("Orgozoa", 2351),                        2351 }, -- uiMap: 1517
		{ WHIT..INDENT..Atlas_GetBossName("Zoatroid", 2351, 2),                    2351 },
		{ WHIT..INDENT..Atlas_GetBossName("Zanj'ir Myrmidon", 2351, 3),            2351 },
		{ WHIT..INDENT..Atlas_GetBossName("Azsh'ari Witch", 2351, 4),              2351 },
		{ WHIT..INDENT..Atlas_GetBossName("Dreadcoil Hulk", 2351, 5),              2351 },
		{ WHIT.." 6) "..Atlas_GetBossName("The Queen's Court", 2359),              2359 }, -- uiMap: 1518
		{ WHIT..INDENT..Atlas_GetBossName("Silivaz the Zealous", 2359, 1),         2359 },
		{ WHIT..INDENT..Atlas_GetBossName("Pashmar the Fanatical", 2359, 2),       2359 },
		{ WHIT.." 7) "..Atlas_GetBossName("Za'qul, Harbinger of Ny'alotha", 2349), 2349 }, -- uiMap: 1519
		{ WHIT..INDENT..Atlas_GetBossName("Horrific Summoner", 2349, 2),           2349 },
		{ WHIT..INDENT..Atlas_GetBossName("Horrific Vision", 2349, 3),             2349 },
		{ WHIT..INDENT..Atlas_GetBossName("Unleashed Nightmare", 2349, 4),         2349 },
		{ WHIT..INDENT..Atlas_GetBossName("First Arcanist Thalyssra", 2349, 5),    2349 },
		{ WHIT.." 8) "..Atlas_GetBossName("Queen Azshara", 2361),                  2361 }, -- uiMap: 1520
		{ WHIT..INDENT..Atlas_GetBossName("Queen Azshara", 2361, 1),               2361 },
		{ WHIT..INDENT..Atlas_GetBossName("Aethanel", 2361, 2),                    2361 },
		{ WHIT..INDENT..Atlas_GetBossName("Cyranus", 2361, 3),                     2361 },
		{ WHIT..INDENT..Atlas_GetBossName("Overzealous Hulk", 2361, 4),            2361 },
		{ WHIT..INDENT..Atlas_GetBossName("Azshara's Devoted", 2361, 5),           2361 },
		{ WHIT..INDENT..Atlas_GetBossName("Azshara's Indomitable", 2361, 6),       2361 },
		{ WHIT..INDENT..Atlas_GetBossName("Tidemistress", 2361, 7),                2361 },
		{ WHIT..INDENT..Atlas_GetBossName("Loyal Myrmidon", 2361, 8),              2361 },
	},

	-- Ny'alotha
	NyalothaA = {
		ZoneName = { BZ["Ny'alotha, the Waking City"]..ALC["MapA"] },
		Location = { BZ["Uldum"]..L["Slash"]..BZ["Vale of Eternal Blossoms"] },
		DungeonID = 2033,
		DungeonHeroicID = 2034,
		DungeonMythicID = 2035,
		WorldMapID = 1581,
		JournalInstanceID = 1180,
		PlayerLimit = { 10, 30 },
		Module = "Atlas_BattleforAzeroth",
		NextMap = "NyalothaB",
		{ BLUE.." B-H) "..ALC["Connection"],                                    10002 },
		{ WHIT.." 1) "..Atlas_GetBossName("Wrathion, the Black Emperor", 2368), 2368 }, -- MapID: 1581
		{ WHIT.." 2) "..Atlas_GetBossName("Maut", 2365),                        2365 }, -- MapID: 1581
		{ WHIT..INDENT..Atlas_GetBossName("Dark Manifestation", 2365, 2),       2365 },
		{ WHIT.." 3) "..Atlas_GetBossName("The Prophet Skitra", 2369),          2369 }, -- MapID: 1581
		{ WHIT..INDENT..Atlas_GetBossName("Image of Absolution", 2369, 2),      2369 },
		{ WHIT.." 4) "..Atlas_GetBossName("Dark Inquisitor Xanesh", 2377),      2377 }, -- MapID: 1592
		{ WHIT..INDENT..Atlas_GetBossName("Queen Azshara", 2377, 2),            2377 },
		{ WHIT.." 5) "..Atlas_GetBossName("The Hivemind", 2372),                2372 }, -- MapID: 1590
		{ WHIT..INDENT..Atlas_GetBossName("Ka'zir", 2372, 1),                   2372 },
		{ WHIT..INDENT..Atlas_GetBossName("Tek'ris", 2372, 2),                  2372 },
		{ WHIT..INDENT..Atlas_GetBossName("Aqir Darter", 2372, 3),              2372 },
		{ WHIT..INDENT..Atlas_GetBossName("Aqir Drone", 2372, 4),               2372 },
		{ WHIT..INDENT..Atlas_GetBossName("Aqir Ravager", 2372, 5),             2372 },
		{ WHIT.." 9) "..Atlas_GetBossName("Vexiona", 2370),                     2370 }, -- MapID: 1593
		{ WHIT..INDENT..Atlas_GetBossName("Fanatical Cultist", 2370, 2),        2370 },
		{ WHIT..INDENT..Atlas_GetBossName("Spellbound Ritualist", 2370, 3),     2370 },
		{ WHIT..INDENT..Atlas_GetBossName("Sinister Soulcarver", 2370, 4),      2370 },
		{ WHIT..INDENT..Atlas_GetBossName("Iron-Willed Enforcer", 2370, 5),     2370 },
		{ WHIT..INDENT..Atlas_GetBossName("Void Ascendant", 2370, 6),           2370 },
		{ WHIT.."10) "..Atlas_GetBossName("Ra-den the Despoiled", 2364),        2364 }, -- MapID: 1591
		{ WHIT..INDENT..Atlas_GetBossName("Crackling Stalker", 2364, 2),        2364 },
		{ WHIT..INDENT..Atlas_GetBossName("Void Hunter", 2364, 3),              2364 },
	},
	NyalothaB = {
		ZoneName = { BZ["Ny'alotha, the Waking City"]..ALC["MapB"] },
		Location = { BZ["Uldum"]..L["Slash"]..BZ["Vale of Eternal Blossoms"] },
		DungeonID = 2033,
		DungeonHeroicID = 2034,
		DungeonMythicID = 2035,
		WorldMapID = 1584,
		JournalInstanceID = 1180,
		PlayerLimit = { 10, 30 },
		Module = "Atlas_BattleforAzeroth",
		PrevMap = "NyalothaA",
		NextMap = "NyalothaC",
		{ BLUE.." E-G) "..ALC["Connection"],                                     10002 },
		{ WHIT.." 6) "..Atlas_GetBossName("Shad'har the Insatiable", 2367),      2367 }, -- MapID: 1594
		{ WHIT.." 7) "..Atlas_GetBossName("Drest'agath", 2373),                  2373 }, -- MapID: 1595
		{ WHIT..INDENT..Atlas_GetBossName("Tentacle of Drest'agath", 2373, 2),   2373 },
		{ WHIT..INDENT..Atlas_GetBossName("Maw of Drest'agath", 2373, 3),        2373 },
		{ WHIT..INDENT..Atlas_GetBossName("Eye of Drest'agath", 2373, 4),        2373 },
		{ WHIT.." 8) "..Atlas_GetBossName("Il'gynoth, Corruption Reborn", 2374), 2374 }, -- MapID: 1596
		{ WHIT..INDENT..Atlas_GetBossName("Organ of Corruption", 2374, 2),       2374 },
		{ WHIT..INDENT..Atlas_GetBossName("Blood of Ny'alotha", 2374, 3),        2374 },
	},
	NyalothaC = {
		ZoneName = { BZ["Ny'alotha, the Waking City"]..ALC["MapC"] },
		Location = { BZ["Uldum"]..L["Slash"]..BZ["Vale of Eternal Blossoms"] },
		DungeonID = 2033,
		DungeonHeroicID = 2034,
		DungeonMythicID = 2035,
		WorldMapID = 1597,
		JournalInstanceID = 1180,
		PlayerLimit = { 10, 30 },
		Module = "Atlas_BattleforAzeroth",
		PrevMap = "NyalothaB",
		{ BLUE.." H) "..ALC["Connection"],                                     10002 },
		{ WHIT.."11) "..Atlas_GetBossName("Carapace of N'Zoth", 2366),         2366 }, -- MapID: 1597
		{ WHIT..INDENT..Atlas_GetBossName("Fury of N'Zoth", 2366, 1),          2366 },
		{ WHIT..INDENT..Atlas_GetBossName("Gaze of Madness", 2366, 2),         2366 },
		{ WHIT..INDENT..Atlas_GetBossName("Growth-Covered Tentacle", 2366, 3), 2366 },
		{ WHIT..INDENT..Atlas_GetBossName("Horrific Hemorrhage", 2366, 4),     2366 },
		{ WHIT..INDENT..Atlas_GetBossName("Nightmare Antigen", 2366, 5),       2366 },
		{ WHIT..INDENT..Atlas_GetBossName("Synthesis Growth", 2366, 6),        2366 },
		{ WHIT..INDENT..Atlas_GetBossName("Mycelial Cyst", 2366, 7),           2366 },
		{ WHIT..INDENT..Atlas_GetBossName("Thrashing Tentacle", 2366, 8),      2366 },
		{ WHIT.."12) "..Atlas_GetBossName("N'Zoth the Corruptor", 2375),       2375 }, -- MapID: 1597
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
	CrucibleofStormsA = {
		{ "A", 10001, 312, 451 },
		{ "B", 10002, 245, 273 },
		{ 1,   2328,  227, 302 },
	},
	CrucibleofStormsB = {
		{ "B", 10002, 452, 191 },
		{ 2,   2332,  94,  265 },
	},
	BattleofDazaralorA = {
		{ "A", 10001, 58,  53 },
		{ "B", 10002, 293, 393 },
		{ 1,   2333,  111, 173 },
		{ 2,   2325,  219, 332 },
		{ 3,   2341,  294, 360 },
	},
	BattleofDazaralorB = {
		{ "A", 10001, 276, 479 },
		{ "C", 10001, 276, 53 },
		{ 1,   2334,  276, 373 },
		{ 2,   2323,  276, 277 },
		{ 3,   2340,  276, 173 },
	},
	BattleofDazaralorC = {
		{ "C", 10002, 248, 457 },
		{ "D", 10002, 174, 27 },
		{ 5,   2342,  248, 276 },
	},
	BattleofDazaralorD = {
		{ "D", 10002, 320, 115 },
		{ "E", 10002, 438, 434 },
		{ "E", 10002, 192, 172 },
		{ "F", 10002, 59,  124 },
		{ 6,   2330,  320, 357 },
	},
	BattleofDazaralorE = {
		{ "B", 10002, 286, 16 },
		{ "F", 10002, 286, 218 },
		{ "G", 10002, 286, 479 },
		{ 4,   2335,  286, 315 },
	},
	BattleofDazaralorF = {
		{ 7, 2343, 231, 232 },
	},
	Freehold = {
		{ 1, 2102, 458, 276 },
		{ 2, 2093, 238, 302 },
		{ 3, 2094, 112, 306 },
		{ 4, 2095, 176, 147 },
	},
	SiegeofBoralus = {
		{ "A", 10001, 364, 80 },
		{ 1,   2132,  248, 131 },
		{ 2,   2173,  200, 286 },
		{ 3,   2134,  147, 384 },
		{ 4,   2140,  202, 465 },
	},
	ShrineoftheStormA = {
		{ "A", 10001, 188, 103 },
		{ "B", 10002, 217, 399 },
		{ 1,   2153,  154, 228 },
		{ 2,   2154,  25,  226 },
		{ 4,   2156,  435, 385 },
	},
	ShrineoftheStormB = {
		{ "B", 10002, 90,  179 },
		{ 3,   2155,  371, 339 },
	},
	TolDagorA = {
		{ 1, 2097, 258, 252 },
		{ 3, 2099, 209, 304 },
		{ 4, 2096, 180, 234 },
	},
	TolDagorB = {
		{ "B", 10002, 405, 37 },
		{ "B", 10002, 213, 59 },
		{ "C", 10002, 69,  193 },
		{ "C", 10002, 81,  461 },
		{ "D", 10002, 48,  434 },
		{ "D", 10002, 293, 452 },
		{ "E", 10002, 428, 280 },
		{ 2,   2098,  107, 434 },
	},
	WaycrestManorA = {
		{ "A", 10001, 256, 500 },
		{ "B", 10002, 196, 335 },
		{ "B", 10002, 316, 294 },
		{ 1,   2125,  116, 450 },
		{ 2,   2126,  250, 240 },
		{ 3,   2127,  375, 341 }
	},
	WaycrestManorB = {
		{ "B", 10002, 335,   44 },
		{ "B", 10002, 15094, 44 },
		{ "C", 10002, 256,   146 },
		{ "C", 10002, 480,   264 },
		{ "D", 10002, 326,   442 },
		{ "D", 10002, 89,    372 },
		{ 4,   2128,  349,   289 },
		{ 5,   2129,  121,   256 },
	},
	AtalDazar = {
		{ "A", 10001, 458, 256 },
		{ 1,   2082,  247, 435 },
		{ 2,   2036,  247, 78 },
		{ 3,   2083,  247, 247 },
		{ 4,   2030,  91,  247 },
	},
	KingsRest = {
		{ "A", 10001, 500, 256 },
		{ 1,   2165,  436, 328 },
		{ 2,   2171,  287, 151 },
		{ 3,   2170,  225, 389 },
		{ 4,   2172,  39,  246 },
	},
	TheMOTHERLODE = {
		{ 1, 2109, 206, 201 },
		{ 2, 2114, 83,  84 },
		{ 3, 2115, 282, 53 },
		{ 4, 2116, 396, 149 },
	},
	TempleofSethraliss = {
		{ "A", 10001, 357, 497 },
		{ 1,   2109,  351, 403 },
		{ 2,   2114,  220, 311 },
		{ 3,   2115,  232, 232 },
		{ 4,   2116,  108, 29 },
	},
	TheUnderrot = {
		{ "A", 10001, 246, 497 },
		{ 1,   2157,  256, 300 },
		{ 2,   2131,  447, 310 },
		{ 3,   2130,  382, 175 },
		{ 4,   2158,  65,  44 },
	},
	UldirA = {
		{ "A", 10001, 236, 489 },
		{ "B", 10002, 236, 455 },
		{ "C", 10002, 236, 312 },
		{ "D", 10002, 327, 217 },
		{ "E", 10002, 133, 217 },
		{ "F", 10002, 236, 127 },
		{ "G", 10002, 236, 252 },
		{ 1,   2168,  236, 430 },
		{ 2,   2167,  236, 381 },
		{ 3,   2146,  418, 217 },
		{ 4,   2169,  54,  217 },
		{ 5,   2166,  236, 36 },
		{ 6,   2195,  236, 217 },
	},
	UldirB = {
		{ "A", 10001, 252, 483 },
		{ "B", 10002, 252, 252 },
		{ 1,   2168,  252, 167 },
	},
	UldirC = {
		{ "B", 10002, 252, 466 },
		{ "C", 10002, 252, 39 },
		{ 2,   2167,  252, 270 },
	},
	UldirD = {
		{ "D", 10002, 26,  252 },
		{ 3,   2146,  353, 252 },
	},
	UldirE = {
		{ "E", 10002, 493, 252 },
		{ 4,   2169,  175, 252 },
	},
	UldirF = {
		{ "F", 10002, 252, 484 },
		{ 5,   2166,  252, 158 },
	},
	UldirG = {
		{ "G", 10002, 252, 474 },
		{ 7,   2195,  252, 409 },
		{ 8,   2195,  252, 93 },
	},
	TheEternalPalaceA = {
		{ "A", 10001, 478, 249 },
		{ "B", 10002, 24,  249 },
		{ 1,   2352,  246, 249 },
	},
	TheEternalPalaceB = {
		{ "B", 10002, 317, 294 },
		{ "C", 10003, 218, 426 },
		{ 2,   2353,  252, 61 },
		{ 3,   2354,  252, 294 },
	},
	NyalothaA = {
		{ "B", 10002, 249, 203 },
		{ "C", 10002, 111, 133 },
		{ "D", 10002, 213, 101 },
		{ "E", 10002, 243, 133 },
		{ "H", 10002, 249, 12 },
		{ 1,   2368,  250, 415 },
		{ 2,   2365,  391, 356 },
		{ 3,   2369,  103, 356 },
		{ 4,   2377,  344, 124 },
		{ 5,   2372,  157, 56 },
		{ 9,   2370,  298, 134 },
		{ 10,  2364,  189, 88 },
	},
	NyalothaB = {
		{ "E", 10002, 444, 271 },
		{ "F", 10002, 431, 228 },
		{ "F", 10002, 227, 228 },
		{ "G", 10002, 240, 295 },
		{ 6,   2367,  415, 435 },
		{ 7,   2373,  93,  273 },
		{ 8,   2374,  230, 98 },
	},
	NyalothaC = {
		{ "H", 10002, 270, 483 },
		{ 11,  2366,  240, 341 },
		{ 12,  2375,  244, 96 },
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
	[BZ["Battle of Dazar'alor"]] = "BattleofDazaralorA",
	[BZ["Crucible of Storms"]] = "CrucibleofStormsA",
	[BZ["Shrine of the Storm"]] = "ShrineoftheStormA",
	[BZ["Tol Dagor"]] = "TolDagorA",
	[BZ["Waycrest Manor"]] = "WaycrestManorA",
	[BZ["Uldir"]] = "UldirA",
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
	[BZ["Battle of Dazar'alor"]] = {
		["BattleofDazaralorA"] = {
			BZ["The Zocalo"],
			BZ["Dazar'alor"],
			BZ["Terrace of the Speakers"],
			BZ["Grand Bazaar"],
			BZ["Bay of Kings"],
			BZ["Path of the Ancestors"],
		},
		["BattleofDazaralorB"] = {
			BZ["Port of Zandalar"],
		},
		["BattleofDazaralorC"] = {
			BZ["Halls of Opulence"],
		},
		["BattleofDazaralorD"] = {
			BZ["Loa's Sanctum"],
			BZ["Walk of Kings"],
		},
		["BattleofDazaralorE"] = {
			BZ["The Heart of the Empire"],
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
	[BZ["Tiragarde Sound"]] = "Freehold",
	[BZ["Tol Dagor"]] = "TolDagorA",
	[BZ["Stormsong Valley"]] = "ShrineoftheStormA",
	--	[BZ["Mechagon"]] = 				"OperationMechagon",
	[BZ["Drustvar"]] = "WaycrestManorA",
	[BZ["Zuldazar"]] = "AtalDazar",
	[BZ["Vol'dun"]] = "TempleofSethraliss",
	[BZ["Nazmir"]] = "TheUnderrot",
	--	[BZ["Nazjatar"]] = 				"TheEternalPalace",
	[BZ["Boralus Harbor"]] = "SiegeofBoralus",
}

db.EntToInstMatches = {
	--	["TheNightholdEnt"] = 			{"TheNightholdA", "TheNightholdB", "TheNightholdC", "TheNightholdD", "TheNightholdE", "TheNightholdF", "TheNightholdG" },
}

db.InstToEntMatches = {
	--	["TheArcway"] = 			{"TheArcwayEnt"},
}

db.MapSeries = {
	["CrucibleofStormsA"] = { "CrucibleofStormsA", "CrucibleofStormsB" },
	["CrucibleofStormsB"] = { "CrucibleofStormsA", "CrucibleofStormsB" },
	["BattleofDazaralorA"] = { "BattleofDazaralorA", "BattleofDazaralorB", "BattleofDazaralorC", "BattleofDazaralorD", "BattleofDazaralorE", "BattleofDazaralorF" },
	["BattleofDazaralorB"] = { "BattleofDazaralorA", "BattleofDazaralorB", "BattleofDazaralorC", "BattleofDazaralorD", "BattleofDazaralorE", "BattleofDazaralorF" },
	["BattleofDazaralorC"] = { "BattleofDazaralorA", "BattleofDazaralorB", "BattleofDazaralorC", "BattleofDazaralorD", "BattleofDazaralorE", "BattleofDazaralorF" },
	["BattleofDazaralorD"] = { "BattleofDazaralorA", "BattleofDazaralorB", "BattleofDazaralorC", "BattleofDazaralorD", "BattleofDazaralorE", "BattleofDazaralorF" },
	["BattleofDazaralorE"] = { "BattleofDazaralorA", "BattleofDazaralorB", "BattleofDazaralorC", "BattleofDazaralorD", "BattleofDazaralorE", "BattleofDazaralorF" },
	["BattleofDazaralorF"] = { "BattleofDazaralorA", "BattleofDazaralorB", "BattleofDazaralorC", "BattleofDazaralorD", "BattleofDazaralorE", "BattleofDazaralorF" },
	["ShrineoftheStormA"] = { "ShrineoftheStormA", "ShrineoftheStormB" },
	["ShrineoftheStormB"] = { "ShrineoftheStormA", "ShrineoftheStormB" },
	["TolDagorA"] = { "TolDagorA", "TolDagorB" },
	["TolDagorB"] = { "TolDagorA", "TolDagorB" },
	["WaycrestManorA"] = { "WaycrestManorA", "WaycrestManorB" },
	["WaycrestManorB"] = { "WaycrestManorA", "WaycrestManorB" },
	["UldirA"] = { "UldirA", "UldirB", "UldirC", "UldirD", "UldirE", "UldirF", "UldirG" },
	["UldirB"] = { "UldirA", "UldirB", "UldirC", "UldirD", "UldirE", "UldirF", "UldirG" },
	["UldirC"] = { "UldirA", "UldirB", "UldirC", "UldirD", "UldirE", "UldirF", "UldirG" },
	["UldirD"] = { "UldirA", "UldirB", "UldirC", "UldirD", "UldirE", "UldirF", "UldirG" },
	["UldirE"] = { "UldirA", "UldirB", "UldirC", "UldirD", "UldirE", "UldirF", "UldirG" },
	["UldirF"] = { "UldirA", "UldirB", "UldirC", "UldirD", "UldirE", "UldirF", "UldirG" },
	["UldirG"] = { "UldirA", "UldirB", "UldirC", "UldirD", "UldirE", "UldirF", "UldirG" },
	["NyalothaA"] = { "NyalothaA", "NyalothaB", "NyalothaC" },
}

db.SubZoneAssoc = {
	--	["BlackRookHoldA"] = 			BZ["Black Rook Hold"],
}

db.DropDownLayouts_Order = {
	[ATLAS_DDL_CONTINENT] = {
		ATLAS_DDL_CONTINENT_KULTIRAS,
		ATLAS_DDL_CONTINENT_ZANDALAR,
		ATLAS_DDL_CONTINENT_PANDARIA,
		ATLAS_DDL_CONTINENT_KALIMDOR,
	},
	[ATLAS_DDL_LEVEL] = {
		ATLAS_DDL_LEVEL_45TO50,
		ATLAS_DDL_LEVEL_50TO60,
	},
	[ATLAS_DDL_EXPANSION] = {
		ATLAS_DDL_EXPANSION_BFA,
		ATLAS_DDL_EXPANSION_BFA2,
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
		[ATLAS_DDL_CONTINENT_KULTIRAS] = {
			"CrucibleofStormsA",
			"CrucibleofStormsB",
			"BattleofDazaralorA",
			"BattleofDazaralorB",
			"BattleofDazaralorC",
			"BattleofDazaralorD",
			"BattleofDazaralorE",
			"BattleofDazaralorF",
			"Freehold",
			"SiegeofBoralus",
			"ShrineoftheStormA",
			"ShrineoftheStormB",
			"TolDagorA",
			"TolDagorB",
			"WaycrestManorA",
			"WaycrestManorB",
		},
		[ATLAS_DDL_CONTINENT_ZANDALAR] = {
			"AtalDazar",
			"KingsRest",
			--			"TheEternalPalace",
			"TheMOTHERLODE",
			"TempleofSethraliss",
			"UldirA",
			"UldirB",
			"UldirC",
			"UldirD",
			"UldirE",
			"UldirF",
			"UldirG",
			"TheUnderrot",
		},
		[ATLAS_DDL_CONTINENT_PANDARIA] = {
			"NyalothaA",
			"NyalothaB",
			"NyalothaC",
		},
		[ATLAS_DDL_CONTINENT_KALIMDOR] = {
			"NyalothaA",
			"NyalothaB",
			"NyalothaC",
		},
	},
	[ATLAS_DDL_EXPANSION] = {
		[ATLAS_DDL_EXPANSION_BFA] = {
			"AtalDazar",
			"SiegeofBoralus",
			"Freehold",
			"ShrineoftheStormA",
			"ShrineoftheStormB",
			"TolDagorA",
			"TolDagorB",
			"WaycrestManorA",
			"WaycrestManorB",
			"KingsRest",
			"TheMOTHERLODE",
			"TempleofSethraliss",
			"TheUnderrot",
			"OperationMechagonA",
		},
		[ATLAS_DDL_EXPANSION_BFA2] = { -- Raids
			"BattleofDazaralorA",
			"BattleofDazaralorB",
			"BattleofDazaralorC",
			"BattleofDazaralorD",
			"BattleofDazaralorE",
			"BattleofDazaralorF",
			"CrucibleofStormsA",
			"CrucibleofStormsB",
			"UldirA",
			"UldirB",
			"UldirC",
			"UldirD",
			"UldirE",
			"UldirF",
			"UldirG",
			--			"TheEternalPalace",
			"NyalothaA",
			"NyalothaB",
			"NyalothaC",
		},
	},
	[ATLAS_DDL_LEVEL] = {
		[ATLAS_DDL_LEVEL_45TO50] = {
			"AtalDazar",
			"SiegeofBoralus",
			"Freehold",
			"ShrineoftheStormA",
			"ShrineoftheStormB",
			"TolDagorA",
			"TolDagorB",
			"WaycrestManorA",
			"WaycrestManorB",
			"TheMOTHERLODE",
			"TempleofSethraliss",
			"TheUnderrot",
			"OperationMechagonA",
		},
		[ATLAS_DDL_LEVEL_50TO60] = {
			"BattleofDazaralorA",
			"BattleofDazaralorB",
			"BattleofDazaralorC",
			"BattleofDazaralorD",
			"BattleofDazaralorE",
			"BattleofDazaralorF",
			"CrucibleofStormsA",
			"CrucibleofStormsB",
			--			"TheEternalPalace",
			"KingsRest",
			"UldirA",
			"UldirB",
			"UldirC",
			"UldirD",
			"UldirE",
			"UldirF",
			"UldirG",
			"NyalothaA",
			"NyalothaB",
			"NyalothaC",
		},
	},
	[ATLAS_DDL_PARTYSIZE] = {
		[ATLAS_DDL_PARTYSIZE_5] = {
			"AtalDazar",
			"SiegeofBoralus",
			"Freehold",
			"ShrineoftheStormA",
			"ShrineoftheStormB",
			"TolDagorA",
			"TolDagorB",
			"WaycrestManorA",
			"WaycrestManorB",
			"KingsRest",
			"TheMOTHERLODE",
			"TempleofSethraliss",
			"TheUnderrot",
			"OperationMechagonA",
		},
		[ATLAS_DDL_PARTYSIZE_10] = {
			"BattleofDazaralorA",
			"BattleofDazaralorB",
			"BattleofDazaralorC",
			"BattleofDazaralorD",
			"BattleofDazaralorE",
			"BattleofDazaralorF",
			"CrucibleofStormsA",
			"CrucibleofStormsB",
			--			"TheEternalPalace",
			"UldirA",
			"UldirB",
			"UldirC",
			"UldirD",
			"UldirE",
			"UldirF",
			"UldirG",
			"NyalothaA",
			"NyalothaB",
			"NyalothaC",
		},
		[ATLAS_DDL_PARTYSIZE_20TO40] = {
			"BattleofDazaralorA",
			"BattleofDazaralorB",
			"BattleofDazaralorC",
			"BattleofDazaralorD",
			"BattleofDazaralorE",
			"BattleofDazaralorF",
			"CrucibleofStormsA",
			"CrucibleofStormsB",
			--			"TheEternalPalace",
			"UldirA",
			"UldirB",
			"UldirC",
			"UldirD",
			"UldirE",
			"UldirF",
			"UldirG",
			"NyalothaA",
			"NyalothaB",
			"NyalothaC",
		},
	},
	[ATLAS_DDL_TYPE] = {
		[ATLAS_DDL_TYPE_INSTANCE] = {
			"AtalDazar",
			"SiegeofBoralus",
			"BattleofDazaralorA",
			"BattleofDazaralorB",
			"BattleofDazaralorC",
			"BattleofDazaralorD",
			"BattleofDazaralorE",
			"BattleofDazaralorF",
			"CrucibleofStormsA",
			"CrucibleofStormsB",
			"Freehold",
			"ShrineoftheStormA",
			"ShrineoftheStormB",
			"TolDagorA",
			"TolDagorB",
			"WaycrestManorA",
			"WaycrestManorB",
			"KingsRest",
			--			"TheEternalPalace",
			"TheMOTHERLODE",
			"TempleofSethraliss",
			"UldirA",
			"UldirB",
			"UldirC",
			"UldirD",
			"UldirE",
			"UldirF",
			"UldirG",
			"TheUnderrot",
			"OperationMechagonA",
			"NyalothaA",
			"NyalothaB",
			"NyalothaC",
		},
		[ATLAS_DDL_TYPE_ENTRANCE] = {
		},
	},
}
