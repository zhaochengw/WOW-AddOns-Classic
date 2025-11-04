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

private.addon_name = "Atlas_Shadowlands"
private.module_name = "Shadowlands"

local BZ = Atlas_GetLocaleLibBabble("LibBabble-SubZone-3.0")
local ALC = LibStub("AceLocale-3.0"):GetLocale("Atlas")
local Atlas = LibStub("AceAddon-3.0"):GetAddon("Atlas")
local SDL = Atlas:NewModule(private.module_name)

local db = {}
SDL.db = db

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
	-- ///////////////////////////////////////
	-- Instances
	-- Plaguefall
	PlaguefallA = {
		ZoneName = { BZ["Plaguefall"]..ALC["MapA"] },
		Location = { BZ["Maldraxxus"] },
		DungeonID = 2069,
		DungeonHeroicID = 2062,
		DungeonMythicID = 2111,
		WorldMapID = 1674,
		JournalInstanceID = 1183,
		Module = "Atlas_Shadowlands",
		NextMap = "PlaguefallB",
		{ BLUE.." B) "..ALC["Connection"],                               10002 },
		{ WHIT.." 1) "..Atlas_GetBossName("Globgrog", 2419),             2419 },
		{ WHIT..INDENT..Atlas_GetBossName("Slimy Morsel", 2419, 2),      2419 },
		{ WHIT..INDENT..Atlas_GetBossName("Slimy Smorgasbord", 2419, 3), 2419 },
		{ WHIT.." 2) "..Atlas_GetBossName("Doctor Ickus", 2403),         2403 },
		{ WHIT.." 3) "..Atlas_GetBossName("Domina Venomblade", 2423),    2423 },
		{ WHIT..INDENT..Atlas_GetBossName("Brood Assassin", 2423, 2),    2423 },
	},
	PlaguefallB = {
		ZoneName = { BZ["Plaguefall"]..ALC["MapB"] },
		Location = { BZ["Maldraxxus"] },
		DungeonID = 2069,
		DungeonHeroicID = 2062,
		DungeonMythicID = 2111,
		WorldMapID = 1697,
		JournalInstanceID = 1183,
		Module = "Atlas_Shadowlands",
		PrevMap = "PlaguefallA",
		{ BLUE.." B) "..ALC["Connection"],                            10002 },
		{ WHIT.." 4) "..Atlas_GetBossName("Margrave Stradama", 2404), 2404 },
	},
	-- Mists of Tirna Scithe
	MistsofTirnaScithe = {
		ZoneName = { BZ["Mists of Tirna Scithe"] },
		Location = { BZ["Ardenweald"] },
		DungeonID = 2072,
		DungeonHeroicID = 2073,
		DungeonMythicID = 2110,
		WorldMapID = 1669,
		JournalInstanceID = 1184,
		Module = "Atlas_Shadowlands",
		{ WHIT.." 1) "..Atlas_GetBossName("Ingra Maloch", 2400),        2400 },
		{ WHIT..INDENT..Atlas_GetBossName("Droman Oulfarran", 2400, 2), 2400 },
		{ WHIT.." 2) "..Atlas_GetBossName("Mistcaller", 2402),          2402 },
		{ WHIT.." 3) "..Atlas_GetBossName("Tred'ova", 2405),            2405 },
	},
	-- Halls of Atonement
	HallsofAtonement = {
		ZoneName = { BZ["Halls of Atonement"] },
		Location = { BZ["Revendreth"] },
		DungeonID = 2074,
		DungeonHeroicID = 2075,
		DungeonMythicID = 2109,
		WorldMapID = 1663,
		JournalInstanceID = 1185,
		Module = "Atlas_Shadowlands",
		{ WHIT.." 1) "..Atlas_GetBossName("Halkias, the Sin-Stained Goliath", 2406), 2406 },
		{ WHIT.." 2) "..Atlas_GetBossName("Echelon", 2387),                          2387 },
		{ WHIT.." 3) "..Atlas_GetBossName("High Adjudicator Aleez", 2411),           2411 },
		{ WHIT..INDENT..Atlas_GetBossName("Ghastly Parishioner", 2411, 2),           2411 },
		{ WHIT..INDENT..Atlas_GetBossName("Vessel of Atonement", 2411, 3),           2411 },
		{ WHIT.." 4) "..Atlas_GetBossName("Lord Chamberlain", 2413),                 2413 },
	},
	-- De Other Side
	DeOtherSideA = {
		ZoneName = { BZ["De Other Side"]..ALC["MapA"] },
		Location = { BZ["Ardenweald"] },
		DungeonID = 2080,
		DungeonHeroicID = 2081,
		DungeonMythicID = 2108,
		WorldMapID = 1677,
		JournalInstanceID = 1188,
		Module = "Atlas_Shadowlands",
		NextMap = "DeOtherSideB",
		{ WHIT.." 1) "..Atlas_GetBossName("Dealer Xy'exa", 2398), 2398 },
	},
	DeOtherSideB = {
		ZoneName = { BZ["De Other Side"]..ALC["MapB"] },
		Location = { BZ["Ardenweald"] },
		DungeonID = 2080,
		DungeonHeroicID = 2081,
		DungeonMythicID = 2108,
		WorldMapID = 1679,
		JournalInstanceID = 1188,
		Module = "Atlas_Shadowlands",
		PrevMap = "DeOtherSideA",
		NextMap = "DeOtherSideC",
		{ WHIT.." 2) "..Atlas_GetBossName("Hakkar the Soulflayer", 2408), 2408 },
	},
	DeOtherSideC = {
		ZoneName = { BZ["De Other Side"]..ALC["MapC"] },
		Location = { BZ["Ardenweald"] },
		DungeonID = 2080,
		DungeonHeroicID = 2081,
		DungeonMythicID = 2108,
		WorldMapID = 1678,
		JournalInstanceID = 1188,
		Module = "Atlas_Shadowlands",
		PrevMap = "DeOtherSideB",
		NextMap = "DeOtherSideD",
		{ WHIT.." 3) "..Atlas_GetBossName("The Manastorms", 2409),           2409 },
		{ WHIT..INDENT..Atlas_GetBossName("Millificent Manastorm", 2409, 1), 2409 },
		{ WHIT..INDENT..Atlas_GetBossName("Millhouse Manastorm", 2409, 2),   2409 },
	},
	DeOtherSideD = {
		ZoneName = { BZ["De Other Side"]..ALC["MapD"] },
		Location = { BZ["Ardenweald"] },
		DungeonID = 2080,
		DungeonHeroicID = 2081,
		DungeonMythicID = 2108,
		WorldMapID = 1680,
		JournalInstanceID = 1188,
		Module = "Atlas_Shadowlands",
		PrevMap = "DeOtherSideC",
		{ WHIT.." 4) "..Atlas_GetBossName("Mueh'zala", 2410), 2410 },
	},
	-- Sanguine Depths
	SanguineDepthsA = {
		ZoneName = { BZ["Sanguine Depths"]..ALC["MapA"] },
		Location = { BZ["Revendreth"] },
		DungeonID = 2082,
		DungeonHeroicID = 2083,
		DungeonMythicID = 2112,
		WorldMapID = 1675,
		JournalInstanceID = 1189,
		Module = "Atlas_Shadowlands",
		NextMap = "SanguineDepthsB",
		{ WHIT.." 1) "..Atlas_GetBossName("Kryxis the Voracious", 2388),      2388 },
		{ WHIT.." 2) "..Atlas_GetBossName("Executor Tarvold", 2415),          2415 },
		{ WHIT..INDENT..Atlas_GetBossName("Fleeting Manifestation", 2415, 2), 2415 },
	},
	SanguineDepthsB = {
		ZoneName = { BZ["Sanguine Depths"]..ALC["MapB"] },
		Location = { BZ["Revendreth"] },
		DungeonID = 2082,
		DungeonHeroicID = 2083,
		DungeonMythicID = 2112,
		WorldMapID = 1676,
		JournalInstanceID = 1189,
		Module = "Atlas_Shadowlands",
		PrevMap = "SanguineDepthsA",
		{ WHIT.." 3) "..Atlas_GetBossName("General Kaal", 2407),           2407 },
		{ WHIT.." 4) "..Atlas_GetBossName("Grand Proctor Beryllia", 2421), 2421 },
	},
	-- Spires of Ascension
	SpiresofAscensionA = {
		ZoneName = { BZ["Spires of Ascension"]..ALC["MapA"] },
		Location = { BZ["Bastion"] },
		DungeonID = 2076,
		DungeonHeroicID = 2077,
		DungeonMythicID = 2113,
		WorldMapID = 1693,
		JournalInstanceID = 1186,
		Module = "Atlas_Shadowlands",
		NextMap = "SpiresofAscensionB",
		{ WHIT.." 1) "..Atlas_GetBossName("Kin-Tara", 2399),  2399 },
		{ WHIT..INDENT..Atlas_GetBossName("Azules", 2399, 1), 2399 },
		{ WHIT.." 2) "..Atlas_GetBossName("Ventunax", 2416),  2416 },
	},
	SpiresofAscensionB = {
		ZoneName = { BZ["Spires of Ascension"]..ALC["MapB"] },
		Location = { BZ["Bastion"] },
		DungeonID = 2076,
		DungeonHeroicID = 2077,
		DungeonMythicID = 2113,
		WorldMapID = 1694,
		JournalInstanceID = 1186,
		Module = "Atlas_Shadowlands",
		PrevMap = "SpiresofAscensionA",
		{ WHIT.." 3) "..Atlas_GetBossName("Oryphrion", 2414),               2414 },
		{ WHIT.." 4) "..Atlas_GetBossName("Devos, Paragon of Doubt", 2412), 2412 },
	},
	-- Tazavesh
	TazaveshA = {
		ZoneName = { BZ["Tazavesh, the Veiled Market"]..ALC["MapA"] },
		Location = { BZ["The In-Between"] },
		-- DungeonHeroicID = 1, -- TBD: Tazavesh gets split into two heroics
		DungeonMythicID = 2225,
		WorldMapID = 1989,
		JournalInstanceID = 1194,
		Module = "Atlas_Shadowlands",
		{ BLUE.." A) "..ALC["Entrance"],                                 10001 },
		{ WHIT.." 1) "..Atlas_GetBossName("Zo'phex the Sentinel", 2437), 2437 },
		{ WHIT.." 2) "..Atlas_GetBossName("The Grand Menagerie", 2454),  2454 },
		{ WHIT..INDENT..Atlas_GetBossName("Alcruux", 2454, 1),           2454 },
		{ WHIT..INDENT..Atlas_GetBossName("Achillite", 2454, 2),         2454 },
		{ WHIT..INDENT..Atlas_GetBossName("Venza Goldfuse", 2454, 3),    2454 },
		{ WHIT.." 3) "..Atlas_GetBossName("Mailroom Mayhem", 2436),      2436 },
		{ WHIT.." 4) "..Atlas_GetBossName("Myza's Oasis", 2452),         2452 },
		{ WHIT..INDENT..Atlas_GetBossName("Zo'gron", 2452, 1),           2452 },
		{ WHIT..INDENT..Atlas_GetBossName("Brawling Patron", 2452, 2),   2452 },
		{ WHIT..INDENT..Atlas_GetBossName("Disruptive Patron", 2452, 3), 2452 },
		{ WHIT..INDENT..Atlas_GetBossName("Oasis Security", 2452, 4),    2452 },
		{ WHIT.." 5) "..Atlas_GetBossName("So'azmi", 2451),              2451 },
		{ WHIT.." 8) "..Atlas_GetBossName("So'leah", 2455),              2455 },
	},
	TazaveshB = {
		ZoneName = { BZ["Tazavesh, the Veiled Market"]..ALC["MapB"] },
		Location = { BZ["The In-Between"] },
		-- DungeonHeroicID = 1, -- TBD: Tazavesh gets split into two heroics
		DungeonMythicID = 2225,
		WorldMapID = 1995,
		JournalInstanceID = 1194,
		Module = "Atlas_Shadowlands",
		{ WHIT.." 6) "..Atlas_GetBossName("Hylbrande", 2448),         2448 },
		{ WHIT..INDENT..Atlas_GetBossName("Vault Purifier", 2448, 2), 2448 },
	},
	TazaveshC = {
		ZoneName = { BZ["Tazavesh, the Veiled Market"]..ALC["MapC"] },
		Location = { BZ["The In-Between"] },
		-- DungeonHeroicID = 1, -- TBD: Tazavesh gets split into two heroics
		DungeonMythicID = 2225,
		WorldMapID = 1996,
		JournalInstanceID = 1194,
		Module = "Atlas_Shadowlands",
		{ WHIT.." 7) "..Atlas_GetBossName("Timecap'n Hooktail", 2449), 2449 },
		{ WHIT..INDENT..Atlas_GetBossName("Corsair Brute", 2449, 2),   2449 },
	},
	-- Theater of Pain
	TheaterofPainA = {
		ZoneName = { BZ["Theater of Pain"]..ALC["MapA"] },
		Location = { BZ["Maldraxxus"] },
		DungeonID = 2078,
		DungeonHeroicID = 2079,
		DungeonMythicID = 2115,
		WorldMapID = 1683,
		JournalInstanceID = 1187,
		Module = "Atlas_Shadowlands",
		NextMap = "TheaterofPainB",
		{ BLUE.." A) "..ALC["Entrance"],                                           10001 },
		{ WHIT.." 1) "..Atlas_GetBossName("An Affront of Challengers", 2397),      2397 },
		{ WHIT..INDENT..Atlas_GetBossName("Dessia the Decapitator", 2397, 1),      2397 },
		{ WHIT..INDENT..Atlas_GetBossName("Paceran the Virulent", 2397, 2),        2397 },
		{ WHIT..INDENT..Atlas_GetBossName("Sathel the Accursed", 2397, 3),         2397 },
		{ WHIT.." 2) "..Atlas_GetBossName("Mordretha, the Endless Empress", 2417), 2417 },
	},
	TheaterofPainB = {
		ZoneName = { BZ["Theater of Pain"]..ALC["MapB"] },
		Location = { BZ["Maldraxxus"] },
		DungeonID = 2078,
		DungeonHeroicID = 2079,
		DungeonMythicID = 2115,
		WorldMapID = 1684,
		JournalInstanceID = 1187,
		Module = "Atlas_Shadowlands",
		PrevMap = "TheaterofPainA",
		NextMap = "TheaterofPainC",
		{ WHIT.." 3) "..Atlas_GetBossName("Xav the Unfallen", 2390), 2390 },
	},
	TheaterofPainC = {
		ZoneName = { BZ["Theater of Pain"]..ALC["MapC"] },
		Location = { BZ["Maldraxxus"] },
		DungeonID = 2078,
		DungeonHeroicID = 2079,
		DungeonMythicID = 2115,
		WorldMapID = 1685,
		JournalInstanceID = 1187,
		Module = "Atlas_Shadowlands",
		PrevMap = "TheaterofPainB",
		NextMap = "TheaterofPainD",
		{ WHIT.." 4) "..Atlas_GetBossName("Kul'tharok", 2389), 2389 },
	},
	TheaterofPainD = {
		ZoneName = { BZ["Theater of Pain"]..ALC["MapD"] },
		Location = { BZ["Maldraxxus"] },
		DungeonID = 2078,
		DungeonHeroicID = 2079,
		DungeonMythicID = 2115,
		WorldMapID = 1687,
		JournalInstanceID = 1187,
		Module = "Atlas_Shadowlands",
		PrevMap = "TheaterofPainC",
		{ WHIT.." 5) "..Atlas_GetBossName("Gorechop", 2401),            2401 },
		{ WHIT..INDENT..Atlas_GetBossName("Oozing Leftovers", 2401, 2), 2401 },
	},
	-- The Necrotic Wake
	TheNecroticWakeA = {
		ZoneName = { BZ["The Necrotic Wake"]..ALC["MapA"] },
		Location = { BZ["Bastion"] },
		DungeonID = 2070,
		DungeonHeroicID = 2071,
		DungeonMythicID = 2114,
		PlayerLimit = 5,
		WorldMapID = 1666,
		JournalInstanceID = 1182,
		Module = "Atlas_Shadowlands",
		NextMap = "TheNecroticWakeB",
		{ BLUE.." B) "..ALC["Connection"],                                    10002 },
		{ WHIT.." 1) "..Atlas_GetBossName("Blightbone", 2395),                2395 },
		{ WHIT..INDENT..Atlas_GetBossName("Carrion Worm", 2395, 2),           2395 },
		{ WHIT.." 2) "..Atlas_GetBossName("Amarth, The Harvester", 2391),     2391 },
		{ WHIT..INDENT..Atlas_GetBossName("Bonefang", 2391, 2),               2391 },
		{ WHIT..INDENT..Atlas_GetBossName("Reanimated Warrior", 2391, 3),     2391 },
		{ WHIT..INDENT..Atlas_GetBossName("Reanimated Mage", 2391, 4),        2391 },
		{ WHIT..INDENT..Atlas_GetBossName("Reanimated Crossbowman", 2391, 5), 2391 },
	},
	TheNecroticWakeB = {
		ZoneName = { BZ["The Necrotic Wake"]..ALC["MapB"] },
		Location = { BZ["Bastion"] },
		DungeonID = 2070,
		DungeonHeroicID = 2071,
		DungeonMythicID = 2114,
		PlayerLimit = 5,
		WorldMapID = 1666,
		JournalInstanceID = 1182,
		Module = "Atlas_Shadowlands",
		PrevMap = "TheNecroticWakeA",
		{ WHIT.." 3) "..Atlas_GetBossName("Surgeon Stitchflesh", 2392),       2392 },
		{ WHIT..INDENT..Atlas_GetBossName("Stitchflesh's Creation", 2392, 2), 2392 },
		{ WHIT.." 4) "..Atlas_GetBossName("Nalthor the Rimebinder", 2396),    2396 },
		{ WHIT..INDENT..Atlas_GetBossName("Zolramus Siphoner", 2396, 2),      2396 },
	},

	-- ///////////////////////////////////////
	-- Raids
	-- Castle Nathria
	CastleNathria = {
		ZoneName = { BZ["Castle Nathria"] },
		Location = { BZ["Revendreth"] },
		DungeonID = 2095,
		DungeonHeroicID = 2094,
		DungeonMythicID = 2093,
		WorldMapID = 1735,
		JournalInstanceID = 1190,
		Module = "Atlas_Shadowlands",
		{ WHIT.."1) "..Atlas_GetBossName("Shriekwing", 2393),                 2393 }, -- MapID: 1735
		{ WHIT.."2) "..Atlas_GetBossName("Huntsman Altimor", 2429),           2429 }, -- MapID: 1735
		{ WHIT..INDENT..Atlas_GetBossName("Margore", 2429, 2),                2429 },
		{ WHIT..INDENT..Atlas_GetBossName("Bargast", 2429, 3),                2429 },
		{ WHIT..INDENT..Atlas_GetBossName("Hecutis", 2429, 4),                2429 },
		{ WHIT.."3) "..Atlas_GetBossName("Sun King's Salvation", 2422),       2422 }, -- MapID: 1746
		{ WHIT..INDENT..Atlas_GetBossName("Kael'thas Sunstrider", 2422, 1),   2422 },
		{ WHIT..INDENT..Atlas_GetBossName("Shade of Kael'thas", 2422, 2),     2422 },
		{ WHIT..INDENT..Atlas_GetBossName("High Torturor Darithos", 2422, 3), 2422 },
		{ WHIT..INDENT..Atlas_GetBossName("Rockbound Vanquisher", 2422, 4),   2422 },
		{ WHIT..INDENT..Atlas_GetBossName("Bleakwing Assassin", 2422, 5),     2422 },
		{ WHIT..INDENT..Atlas_GetBossName("Vile Occultist", 2422, 6),         2422 },
		{ WHIT..INDENT..Atlas_GetBossName("Soul Infuser", 2422, 7),           2422 },
		{ WHIT..INDENT..Atlas_GetBossName("Pestering Fiend", 2422, 8),        2422 },
		{ WHIT.."4) "..Atlas_GetBossName("Artificer Xy'mox", 2418),           2418 }, -- MapID: 1745
		{ WHIT.."5) "..Atlas_GetBossName("Hungering Destroyer", 2428),        2428 }, -- MapID: 1735
		{ WHIT.."6) "..Atlas_GetBossName("Lady Inerva Darkvein", 2420),       2420 }, -- MapID: 1744
		{ WHIT.."7) "..Atlas_GetBossName("The Council of Blood", 2426),       2426 }, -- MapID: 1750
		{ WHIT..INDENT..Atlas_GetBossName("Castellan Niklaus", 2426, 1),      2426 },
		{ WHIT..INDENT..Atlas_GetBossName("Baroness Frieda", 2426, 2),        2426 },
		{ WHIT..INDENT..Atlas_GetBossName("Lord Stavros", 2426, 3),           2426 },
		{ WHIT..INDENT..Atlas_GetBossName("Veteran Stoneguard", 2426, 4),     2426 },
		{ WHIT..INDENT..Atlas_GetBossName("Begrudging Waiter", 2426, 5),      2426 },
		{ WHIT.."8) "..Atlas_GetBossName("Sludgefist", 2394),                 2394 }, -- MapID: 1735
		{ WHIT.."9) "..Atlas_GetBossName("Stone Legion Generals", 2425),      2425 }, -- MapID: 1747
		{ WHIT.."10) "..Atlas_GetBossName("Sire Denathrius", 2424),           2424 }, -- MapID: 1747
		{ WHIT..INDENT..Atlas_GetBossName("Remornia", 2424, 2),               2424 },
		{ WHIT..INDENT..Atlas_GetBossName("Crimson Cabalist", 2424, 3),       2424 },
	},
	-- Sanctum of Domination
	SanctumofDomination = {
		ZoneName = { BZ["Sanctum of Domination"] },
		Location = { BZ["The Maw"] },
		DungeonID = 2226,
		DungeonHeroicID = 2227,
		DungeonMythicID = 2228,
		WorldMapID = 1998,
		JournalInstanceID = 1193,
		Module = "Atlas_Shadowlands",
		{ WHIT.."1) "..Atlas_GetBossName("The Tarragrue", 2435),              2435 }, -- MapID: 1998
		{ WHIT.."2) "..Atlas_GetBossName("The Eye of the Jailer", 2442),      2442 }, -- MapID: 1999
		{ WHIT.."3) "..Atlas_GetBossName("The Nine", 2439),                   2439 }, -- MapID: 1999
		{ WHIT..INDENT..Atlas_GetBossName("Kyra", 2439, 1),                   2439 },
		{ WHIT..INDENT..Atlas_GetBossName("Signe", 2439, 2),                  2439 },
		{ WHIT..INDENT..Atlas_GetBossName("Skyja", 2439, 3),                  2439 },
		{ WHIT.."4) "..Atlas_GetBossName("Remnant of Ner'zhul", 2444),        2444 }, -- MapID: 2000
		{ WHIT..INDENT..Atlas_GetBossName("Orb of Torment", 2444, 2),         2444 },
		{ WHIT..INDENT..Atlas_GetBossName("Helm of Dominion", 2444, 3),       2444 },
		{ WHIT..INDENT..Atlas_GetBossName("Malicious Gauntlets", 2444, 4),    2444 },
		{ WHIT..INDENT..Atlas_GetBossName("Helm of Blight", 2444, 5),         2444 },
		{ WHIT.."5) "..Atlas_GetBossName("Soulrender Dormazain", 2445),       2445 }, -- MapID: 2000
		{ WHIT..INDENT..Atlas_GetBossName("Mawsworn Agonizer", 2445, 2),      2445 },
		{ WHIT..INDENT..Atlas_GetBossName("Mawsworn Overlord", 2445, 3),      2445 },
		{ WHIT.."6) "..Atlas_GetBossName("Painsmith Raznal", 2443),           2443 }, -- MapID: 2000
		{ WHIT..INDENT..Atlas_GetBossName("Spiked Ball", 2443, 2),            2443 },
		{ WHIT..INDENT..Atlas_GetBossName("Shadowsteel Ember", 2443, 3),      2443 },
		{ WHIT.."7) "..Atlas_GetBossName("Guardian of the First Ones", 2446), 2446 }, -- MapID: 2001
		{ WHIT.."8) "..Atlas_GetBossName("Fatescribe Roh-Kalo", 2447),        2447 }, -- MapID: 2001
		{ WHIT..INDENT..Atlas_GetBossName("Fatespawn Monstrosity", 2447, 2),  2447 },
		{ WHIT..INDENT..Atlas_GetBossName("Fatespawn Anomaly", 2447, 3),      2447 },
		{ WHIT..INDENT..Atlas_GetBossName("Shade of Destiny", 2447, 4),       2447 },
		{ WHIT.."9) "..Atlas_GetBossName("Kel'Thuzad", 2440),                 2440 }, -- MapID: 2001
		{ WHIT.."10) "..Atlas_GetBossName("Sylvanas Windrunner", 2441),       2441 }, -- MapID: 2002
	},
	-- Sepulcher of the First Ones
	SepulcheroftheFirstOnesA = {
		ZoneName = { BZ["Sepulcher of the First Ones"]..ALC["MapA"] },
		Location = { BZ["Zereth Mortis"] },
		DungeonID = 2288,
		DungeonHeroicID = 2289,
		DungeonMythicID = 2290,
		WorldMapID = 2047,
		JournalInstanceID = 1195,
		Module = "Atlas_Shadowlands",
		NextMap = "SepulcheroftheFirstOnesB",
		{ BLUE.." A) "..ALC["Entrance"],                                        10001 },
		{ WHIT.." 1) "..Atlas_GetBossName("Vigilant Guardian", 2458),           2458 },
		{ WHIT..INDENT..Atlas_GetBossName("Automated Defense Matrix", 2458, 2), 2458 },
		{ WHIT..INDENT..Atlas_GetBossName("Pre-Fabricated Sentry", 2458, 3),    2458 },
		{ WHIT..INDENT..Atlas_GetBossName("Point Defense Drone", 2458, 4),      2458 },
		{ WHIT..INDENT..Atlas_GetBossName("Volatile Materium", 2458, 5),        2458 },
	},
	SepulcheroftheFirstOnesB = {
		ZoneName = { BZ["Sepulcher of the First Ones"]..ALC["MapB"] },
		Location = { BZ["Zereth Mortis"] },
		DungeonID = 2288,
		DungeonHeroicID = 2289,
		DungeonMythicID = 2290,
		WorldMapID = 2048,
		JournalInstanceID = 1195,
		Module = "Atlas_Shadowlands",
		PrevMap = "SepulcheroftheFirstOnesA",
		NextMap = "SepulcheroftheFirstOnesC",
		{ WHIT.." 2) "..Atlas_GetBossName("Dausegne, the Fallen Oracle", 2459), 2459 },
	},
	SepulcheroftheFirstOnesC = {
		ZoneName = { BZ["Sepulcher of the First Ones"]..ALC["MapC"] },
		Location = { BZ["Zereth Mortis"] },
		DungeonID = 2288,
		DungeonHeroicID = 2289,
		DungeonMythicID = 2290,
		WorldMapID = 2049,
		JournalInstanceID = 1195,
		Module = "Atlas_Shadowlands",
		PrevMap = "SepulcheroftheFirstOnesB",
		NextMap = "SepulcheroftheFirstOnesD",
		{ WHIT.." 3) "..Atlas_GetBossName("Prototype Pantheon", 2460),           2460 },
		{ WHIT..INDENT..Atlas_GetBossName("Prototype of War", 2460, 1),          2460 },
		{ WHIT..INDENT..Atlas_GetBossName("Prototype of Duty", 2460, 2),         2460 },
		{ WHIT..INDENT..Atlas_GetBossName("Prototype of Renewal", 2460, 3),      2460 },
		{ WHIT..INDENT..Atlas_GetBossName("Prototype of Absolution", 2460, 4),   2460 },
		{ WHIT.." 4) "..Atlas_GetBossName("Lihuvim, Principal Architect", 2461), 2461 },
		{ WHIT..INDENT..Atlas_GetBossName("Guardian Automa", 2461, 2),           2461 },
		{ WHIT..INDENT..Atlas_GetBossName("Degeneration Automa", 2461, 3),       2461 },
		{ WHIT..INDENT..Atlas_GetBossName("Acquisitions Automa", 2461, 4),       2461 },
		{ WHIT..INDENT..Atlas_GetBossName("Defense Matrix Automa", 2461, 5),     2461 },
	},
	SepulcheroftheFirstOnesD = {
		ZoneName = { BZ["Sepulcher of the First Ones"]..ALC["MapD"] },
		Location = { BZ["Zereth Mortis"] },
		DungeonID = 2288,
		DungeonHeroicID = 2289,
		DungeonMythicID = 2290,
		WorldMapID = 2061,
		JournalInstanceID = 1195,
		Module = "Atlas_Shadowlands",
		PrevMap = "SepulcheroftheFirstOnesC",
		NextMap = "SepulcheroftheFirstOnesE",
		{ WHIT.." 5) "..Atlas_GetBossName("Skolex, the Insatiable Ravener", 2465), 2465 },
		{ WHIT.." 6) "..Atlas_GetBossName("Artificer Xy'mox", 2470),               2470 },
		{ WHIT..INDENT..Atlas_GetBossName("Genesis Relic", 2470, 2),               2470 },
		{ WHIT.." 7) "..Atlas_GetBossName("Halondrus the Reclaimer", 2463),        2463 },
	},
	SepulcheroftheFirstOnesE = {
		ZoneName = { BZ["Sepulcher of the First Ones"]..ALC["MapE"] },
		Location = { BZ["Zereth Mortis"] },
		DungeonID = 2288,
		DungeonHeroicID = 2289,
		DungeonMythicID = 2290,
		WorldMapID = 2050,
		JournalInstanceID = 1195,
		Module = "Atlas_Shadowlands",
		PrevMap = "SepulcheroftheFirstOnesD",
		NextMap = "SepulcheroftheFirstOnesF",
		{ WHIT.." 8) "..Atlas_GetBossName("Anduin Wrynn", 2469), 2469 },
	},
	SepulcheroftheFirstOnesF = {
		ZoneName = { BZ["Sepulcher of the First Ones"]..ALC["MapF"] },
		Location = { BZ["Zereth Mortis"] },
		DungeonID = 2288,
		DungeonHeroicID = 2289,
		DungeonMythicID = 2290,
		WorldMapID = 2052,
		JournalInstanceID = 1195,
		Module = "Atlas_Shadowlands",
		PrevMap = "SepulcheroftheFirstOnesE",
		{ WHIT.." 9) "..Atlas_GetBossName("Lords of Dread", 2457),         2457 },
		{ WHIT..INDENT..Atlas_GetBossName("Mal'Ganis", 2457, 1),           2457 },
		{ WHIT..INDENT..Atlas_GetBossName("Kin'tessa", 2457, 2),           2457 },
		{ WHIT.."10) "..Atlas_GetBossName("Rygelon", 2467),                2467 },
		{ WHIT..INDENT..Atlas_GetBossName("Collapsing Quasar", 2467, 2),   2467 },
		{ WHIT..INDENT..Atlas_GetBossName("Unstable Matter", 2467, 3),     2467 },
		{ WHIT..INDENT..Atlas_GetBossName("Unstable Antimatter", 2467, 4), 2467 },
		{ WHIT..INDENT..Atlas_GetBossName("Cosmic Core", 2467, 5),         2467 },
		{ WHIT..INDENT..Atlas_GetBossName("Unstable Core", 2467, 6),       2467 },
		{ WHIT.."11) "..Atlas_GetBossName("The Jailer", 2464),             2464 },
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
	PlaguefallA = {
		{ "B", 10002, 330, 438 },
		{ 1,   2419,  299, 72 },
		{ 2,   2403,  375, 227 },
		{ 3,   2423,  324, 408 },
	},
	PlaguefallB = {
		{ "B", 10002, 295, 180 },
		{ 4,   2404,  240, 385 },
	},
	MistsofTirnaScithe = {
		{ 1, 2400, 437, 171 },
		{ 2, 2402, 303, 256 },
		{ 3, 2405, 100, 364 },
	},
	HallsofAtonement = {
		{ 1, 2406, 290, 250 },
		{ 2, 2387, 171, 250 },
		{ 3, 2411, 65,  250 },
		{ 4, 2413, 26,  250 },
	},
	DeOtherSideA = {
		{ 1, 2398, 445, 255 }
	},
	DeOtherSideB = {
		{ 1, 2408, 110, 260 }
	},
	SpiresofAscensionA = {
		{ 1, 2399, 157, 289 },
		{ 2, 2416, 309, 228 },
	},
	SpiresofAscensionB = {
		{ 3, 2414, 257, 263 },
		{ 4, 2412, 273, 230 },
	},
	TazaveshA = {
		{ 1, 2437, 400, 210 },
		{ 2, 2454, 241, 328 },
		{ 3, 2436, 190, 185 },
		{ 4, 2452, 165, 90 },
		{ 5, 2451, 150, 252 },
		{ 8, 2455, 23,  252 },
	},
	TazaveshB = {
		{ 6, 2448, 318, 260 },
	},
	TazaveshC = {
		{ 7, 2449, 218, 265 },
	},
	TheNecroticWakeA = {
		{ "B", 10002, 118, 244 },
		{ 1,   2395,  295, 240 },
		{ 2,   2391,  84,  240 },
	},
	TheaterofPainA = {
		{ "A", 10001, 250, 340 },
		{ 1,   2397,  246, 270 },
		{ 2,   2417,  220, 210 },
	},
	SepulcheroftheFirstOnesA = {
		{ 1, 2458, 278, 235 },
	},
	SepulcheroftheFirstOnesB = {
		{ 2, 2459, 253, 235 },
	},
	SepulcheroftheFirstOnesD = {
		{ 5, 2465, 50,  300 },
		{ 6, 2470, 187, 205 },
		{ 7, 2463, 210, 325 },
	},
	SepulcheroftheFirstOnesE = {
		{ 8, 2469, 202, 242 },
	},
	SepulcheroftheFirstOnesF = {
		{ 9,  2457, 288, 200 },
		{ 10, 2467, 146, 205 },
		{ 11, 2464, 323, 428 },
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
	["PlaguefallA"] = { "PlaguefallA", "PlaguefallB" },
	["PlaguefallB"] = { "PlaguefallA", "PlaguefallB" },
	["DeOtherSideA"] = { "DeOtherSideA", "DeOtherSideB", "DeOtherSideC", "DeOtherSideD" },
	["DeOtherSideB"] = { "DeOtherSideA", "DeOtherSideB", "DeOtherSideC", "DeOtherSideD" },
	["DeOtherSideC"] = { "DeOtherSideA", "DeOtherSideB", "DeOtherSideC", "DeOtherSideD" },
	["DeOtherSideD"] = { "DeOtherSideA", "DeOtherSideB", "DeOtherSideC", "DeOtherSideD" },
	["SanguineDepthsA"] = { "SanguineDepthsA", "SanguineDepthsB" },
	["SanguineDepthsB"] = { "SanguineDepthsA", "SanguineDepthsB" },
	["SpiresofAscensionA"] = { "SpiresofAscensionA", "SpiresofAscensionB" },
	["SpiresofAscensionB"] = { "SpiresofAscensionA", "SpiresofAscensionB" },
	["TheaterofPainA"] = { "TheaterofPainA", "TheaterofPainB", "TheaterofPainC", "TheaterofPainD" },
	["TheaterofPainB"] = { "TheaterofPainA", "TheaterofPainB", "TheaterofPainC", "TheaterofPainD" },
	["TheaterofPainC"] = { "TheaterofPainA", "TheaterofPainB", "TheaterofPainC", "TheaterofPainD" },
	["TheaterofPainD"] = { "TheaterofPainA", "TheaterofPainB", "TheaterofPainC", "TheaterofPainD" },
	["TheNecroticWakeA"] = { "TheNecroticWakeA", "TheNecroticWakeB" },
	["TheNecroticWakeB"] = { "TheNecroticWakeA", "TheNecroticWakeB" },
	["SepulcheroftheFirstOnesA"] = { "SepulcheroftheFirstOnesA", "SepulcheroftheFirstOnesB", "SepulcheroftheFirstOnesC", "SepulcheroftheFirstOnesD", "SepulcheroftheFirstOnesE", "SepulcheroftheFirstOnesF" },
	["SepulcheroftheFirstOnesB"] = { "SepulcheroftheFirstOnesA", "SepulcheroftheFirstOnesB", "SepulcheroftheFirstOnesC", "SepulcheroftheFirstOnesD", "SepulcheroftheFirstOnesE", "SepulcheroftheFirstOnesF" },
	["SepulcheroftheFirstOnesC"] = { "SepulcheroftheFirstOnesA", "SepulcheroftheFirstOnesB", "SepulcheroftheFirstOnesC", "SepulcheroftheFirstOnesD", "SepulcheroftheFirstOnesE", "SepulcheroftheFirstOnesF" },
	["SepulcheroftheFirstOnesD"] = { "SepulcheroftheFirstOnesA", "SepulcheroftheFirstOnesB", "SepulcheroftheFirstOnesC", "SepulcheroftheFirstOnesD", "SepulcheroftheFirstOnesE", "SepulcheroftheFirstOnesF" },
	["SepulcheroftheFirstOnesE"] = { "SepulcheroftheFirstOnesA", "SepulcheroftheFirstOnesB", "SepulcheroftheFirstOnesC", "SepulcheroftheFirstOnesD", "SepulcheroftheFirstOnesE", "SepulcheroftheFirstOnesF" },
	["SepulcheroftheFirstOnesF"] = { "SepulcheroftheFirstOnesA", "SepulcheroftheFirstOnesB", "SepulcheroftheFirstOnesC", "SepulcheroftheFirstOnesD", "SepulcheroftheFirstOnesE", "SepulcheroftheFirstOnesF" },
}

db.SubZoneAssoc = {
	--	["BlackRookHoldA"] = 			BZ["Black Rook Hold"],
}

db.DropDownLayouts_Order = {
	[ATLAS_DDL_CONTINENT] = {
		ATLAS_DDL_CONTINENT_SHADOWLANDS
	},
	[ATLAS_DDL_LEVEL] = {
		ATLAS_DDL_LEVEL_45TO60,
	},
	[ATLAS_DDL_EXPANSION] = {
		ATLAS_DDL_EXPANSION_SHADOWLANDS,
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
		[ATLAS_DDL_CONTINENT_SHADOWLANDS] = {
			"DeOtherSideA",
			"DeOtherSideB",
			"DeOtherSideC",
			"DeOtherSideD",
			"HallsofAtonement",
			"MistsofTirnaScithe",
			"TheNecroticWakeA",
			"TheNecroticWakeB",
			"PlaguefallA",
			"PlaguefallB",
			"SpiresofAscensionA",
			"SpiresofAscensionB",
			"TheaterofPainA",
			"TheaterofPainB",
			"TheaterofPainC",
			"TheaterofPainD",
			"TazaveshA",
			"TazaveshB",
			"TazaveshC",
			"CastleNathria",
			"SanctumofDomination",
			"SepulcheroftheFirstOnesA",
			"SepulcheroftheFirstOnesB",
			"SepulcheroftheFirstOnesC",
			"SepulcheroftheFirstOnesD",
			"SepulcheroftheFirstOnesE",
			"SepulcheroftheFirstOnesF",
		},
	},
	[ATLAS_DDL_EXPANSION] = {
		[ATLAS_DDL_EXPANSION_SHADOWLANDS] = {
			"DeOtherSideA",
			"DeOtherSideB",
			"DeOtherSideC",
			"DeOtherSideD",
			"HallsofAtonement",
			"MistsofTirnaScithe",
			"TheNecroticWakeA",
			"TheNecroticWakeB",
			"PlaguefallA",
			"PlaguefallB",
			"SpiresofAscensionA",
			"SpiresofAscensionB",
			"TheaterofPainA",
			"TheaterofPainB",
			"TheaterofPainC",
			"TheaterofPainD",
			"TazaveshA",
			"TazaveshB",
			"TazaveshC",
			"CastleNathria",
			"SanctumofDomination",
			"SepulcheroftheFirstOnesA",
			"SepulcheroftheFirstOnesB",
			"SepulcheroftheFirstOnesC",
			"SepulcheroftheFirstOnesD",
			"SepulcheroftheFirstOnesE",
			"SepulcheroftheFirstOnesF",
		},
	},
	[ATLAS_DDL_LEVEL] = {
		[ATLAS_DDL_LEVEL_45TO60] = {
			"DeOtherSideA",
			"DeOtherSideB",
			"DeOtherSideC",
			"DeOtherSideD",
			"HallsofAtonement",
			"MistsofTirnaScithe",
			"TheNecroticWakeA",
			"TheNecroticWakeB",
			"PlaguefallA",
			"PlaguefallB",
			"SpiresofAscensionA",
			"SpiresofAscensionB",
			"TheaterofPainA",
			"TheaterofPainB",
			"TheaterofPainC",
			"TheaterofPainD",
			"TazaveshA",
			"TazaveshB",
			"TazaveshC",
			"CastleNathria",
			"SanctumofDomination",
			"SepulcheroftheFirstOnesA",
			"SepulcheroftheFirstOnesB",
			"SepulcheroftheFirstOnesC",
			"SepulcheroftheFirstOnesD",
			"SepulcheroftheFirstOnesE",
			"SepulcheroftheFirstOnesF",
		},
	},
	[ATLAS_DDL_PARTYSIZE] = {
		[ATLAS_DDL_PARTYSIZE_5] = {
			"DeOtherSideA",
			"DeOtherSideB",
			"DeOtherSideC",
			"DeOtherSideD",
			"HallsofAtonement",
			"MistsofTirnaScithe",
			"TheNecroticWakeA",
			"TheNecroticWakeB",
			"PlaguefallA",
			"PlaguefallB",
			"SpiresofAscensionA",
			"SpiresofAscensionB",
			"TheaterofPainA",
			"TheaterofPainB",
			"TheaterofPainC",
			"TheaterofPainD",
			"TazaveshA",
			"TazaveshB",
			"TazaveshC",
		},
		[ATLAS_DDL_PARTYSIZE_10] = {
			"CastleNathria",
			"SanctumofDomination",
			"SepulcheroftheFirstOnesA",
			"SepulcheroftheFirstOnesB",
			"SepulcheroftheFirstOnesC",
			"SepulcheroftheFirstOnesD",
			"SepulcheroftheFirstOnesE",
			"SepulcheroftheFirstOnesF",
		},
		[ATLAS_DDL_PARTYSIZE_20TO40] = {
			"CastleNathria",
			"SanctumofDomination",
			"SepulcheroftheFirstOnesA",
			"SepulcheroftheFirstOnesB",
			"SepulcheroftheFirstOnesC",
			"SepulcheroftheFirstOnesD",
			"SepulcheroftheFirstOnesE",
			"SepulcheroftheFirstOnesF",
		},
	},
	[ATLAS_DDL_TYPE] = {
		[ATLAS_DDL_TYPE_INSTANCE] = {
			"DeOtherSideA",
			"DeOtherSideB",
			"DeOtherSideC",
			"DeOtherSideD",
			"HallsofAtonement",
			"MistsofTirnaScithe",
			"TheNecroticWakeA",
			"TheNecroticWakeB",
			"PlaguefallA",
			"PlaguefallB",
			"SpiresofAscensionA",
			"SpiresofAscensionB",
			"TheaterofPainA",
			"TheaterofPainB",
			"TheaterofPainC",
			"TheaterofPainD",
			"TazaveshA",
			"TazaveshB",
			"TazaveshC",
			"CastleNathria",
			"SanctumofDomination",
			"SepulcheroftheFirstOnesA",
			"SepulcheroftheFirstOnesB",
			"SepulcheroftheFirstOnesC",
			"SepulcheroftheFirstOnesD",
			"SepulcheroftheFirstOnesE",
			"SepulcheroftheFirstOnesF",
		},
	},
}
