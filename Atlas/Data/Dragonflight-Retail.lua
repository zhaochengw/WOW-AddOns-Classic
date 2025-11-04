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

private.addon_name = "Atlas_Dragonflight"
private.module_name = "Dragonflight"

local BZ = Atlas_GetLocaleLibBabble("LibBabble-SubZone-3.0")
local ALC = LibStub("AceLocale-3.0"):GetLocale("Atlas")
local Atlas = LibStub("AceAddon-3.0"):GetAddon("Atlas")
local DF = Atlas:NewModule(private.module_name)

local db = {}
DF.db = db

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
	AlgetharAcademy = {
		ZoneName = { BZ["Algeth'ar Academy"] },
		Location = { BZ["Thaldraszus"] },
		DungeonID = 2366,
		DungeonHeroicID = 2367,
		DungeonMythicID = 2383,
		WorldMapID = 2097,
		JournalInstanceID = 1201,
		Module = "Atlas_Dragonflight",
		{ WHIT.." 1) "..Atlas_GetBossName("Vexamus", 2509),           2509 },
		{ WHIT.." 2) "..Atlas_GetBossName("Overgrown Ancient", 2512), 2512 },
		{ WHIT..INDENT..Atlas_GetBossName("Ancient Branch", 2512, 2), 2512 },
		{ WHIT..INDENT..Atlas_GetBossName("Hungry Lasher", 2512, 3),  2512 },
		{ WHIT.." 3) "..Atlas_GetBossName("Crawth", 2495),            2495 },
		{ WHIT.." 4) "..Atlas_GetBossName("Echo of Doragosa", 2514),  2514 },
	},
	AzureVault = {
		ZoneName = { BZ["The Azure Vault"] },
		Location = { BZ["The Azure Span"] },
		DungeonID = 2332,
		DungeonHeroicID = 2333,
		DungeonMythicID = 2334,
		WorldMapID = 2073,
		JournalInstanceID = 1203,
		Module = "Atlas_Dragonflight",
		{ WHIT.." 1) "..Atlas_GetBossName("Leymor", 2492),               2492 },
		{ WHIT.." 2) "..Atlas_GetBossName("Azureblade", 2505),           2505 },
		{ WHIT..INDENT..Atlas_GetBossName("Draconic Illusion", 2505, 2), 2505 },
		{ WHIT..INDENT..Atlas_GetBossName("Draconic Image", 2505, 3),    2505 },
		{ WHIT.." 3) "..Atlas_GetBossName("Telash Greywing", 2483),      2483 },
		{ WHIT.." 4) "..Atlas_GetBossName("Umbrelskul", 2508),           2508 },
	},
	BrackenhideHollow = {
		ZoneName = { BZ["Brackenhide Hollow"] },
		Location = { BZ["The Azure Span"] },
		DungeonID = 2362,
		DungeonHeroicID = 2363,
		DungeonMythicID = 2379,
		WorldMapID = 2096,
		JournalInstanceID = 1196,
		Module = "Atlas_Dragonflight",
		{ WHIT.." 1) "..Atlas_GetBossName("Hackclaw's War-Band", 2471),  2471 },
		{ WHIT..INDENT..Atlas_GetBossName("Rira Hackclaw", 2471, 1),     2471 },
		{ WHIT..INDENT..Atlas_GetBossName("Gashtooth", 2471, 2),         2471 },
		{ WHIT..INDENT..Atlas_GetBossName("Tricktotem", 2471, 3),        2471 },
		{ WHIT.." 2) "..Atlas_GetBossName("Treemouth", 2473),            2473 },
		{ WHIT..INDENT..Atlas_GetBossName("Decaying Slime", 2473, 2),    2473 },
		{ WHIT.." 3) "..Atlas_GetBossName("Gutshot", 2472),              2472 },
		{ WHIT..INDENT..Atlas_GetBossName("Rotfang Hyena", 2472, 2),     2472 },
		{ WHIT.." 4) "..Atlas_GetBossName("Decatriarch Wratheye", 2474), 2474 },
	},
	DawnoftheInfinite = {
		ZoneName = { i(1209) },
		Location = { BZ["Thaldraszus"] },
		-- DungeonHeroicID = 1, -- TBD: DawnoftheInfinite gets split into two heroics
		DungeonMythicID = 2430,
		WorldMapID = 2190,
		JournalInstanceID = 1209,
		Module = "Atlas_Dragonflight",
		{ WHIT.." 1) "..Atlas_GetBossName("Chronikar", 2521),                 2521 },
		{ WHIT.." 2) "..Atlas_GetBossName("Manifested Timeways", 2528),       2528 },
		{ WHIT.." 3) "..Atlas_GetBossName("Blight of Galakrond", 2535),       2535 },
		{ WHIT..INDENT..Atlas_GetBossName("Ahnzon", 2535, 2),                 2535 },
		{ WHIT..INDENT..Atlas_GetBossName("Loszkeleth", 2535, 3),             2535 },
		{ WHIT..INDENT..Atlas_GetBossName("Dazhak", 2535, 4),                 2535 },
		{ WHIT.." 4) "..Atlas_GetBossName("Iridikron the Stonescaled", 2537), 2537 },
		{ WHIT..INDENT..Atlas_GetBossName("Stone Creation", 2537, 2),         2537 },
		{ WHIT.." 5) "..Atlas_GetBossName("Tyr, the Infinite Keeper", 2526),  2526 },
		{ WHIT.." 6) "..Atlas_GetBossName("Morchie", 2536),                   2536 },
		{ WHIT.." 7) "..Atlas_GetBossName("Time-Lost Battlefield", 2533),     2533 }, -- TODO: there is a horde version of this with ID 2534
		{ WHIT.." 8) "..Atlas_GetBossName("Chrono-Lord Deios", 2538),         2538 },
		{ WHIT..INDENT..Atlas_GetBossName("Infinite Keeper", 2538, 2),        2538 },
		{ WHIT..INDENT..Atlas_GetBossName("Time-Displaced Trooper", 2538, 3), 2538 },
	},
	HallsofInfusion = {
		ZoneName = { BZ["Halls of Infusion"] },
		Location = { BZ["Thaldraszus"] },
		DungeonID = 2364,
		DungeonHeroicID = 2365,
		DungeonMythicID = 2381,
		WorldMapID = 2082,
		JournalInstanceID = 1204,
		Module = "Atlas_Dragonflight",
		{ WHIT.." 1) "..Atlas_GetBossName("Watcher Irideus", 2504),       2504 },
		{ WHIT..INDENT..Atlas_GetBossName("Dampening Device", 2504, 2),   2504 },
		{ WHIT.." 2) "..Atlas_GetBossName("Gulping Goliath", 2507),       2507 },
		{ WHIT..INDENT..Atlas_GetBossName("Curious Swoglet", 2507, 2),    2507 },
		{ WHIT.." 3) "..Atlas_GetBossName("Khajin the Unyielding", 2510), 2510 },
		{ WHIT.." 4) "..Atlas_GetBossName("Primal Tsunami", 2511),        2511 },
		{ WHIT..INDENT..Atlas_GetBossName("Primalist Infuser", 2511, 2),  2511 },
	},
	Neltharus = {
		ZoneName = { BZ["Neltharus"] },
		Location = { BZ["The Waking Shores"] },
		DungeonID = 2356,
		DungeonHeroicID = 2357,
		DungeonMythicID = 2358,
		WorldMapID = 2080,
		JournalInstanceID = 1199,
		Module = "Atlas_Dragonflight",
		{ WHIT.." 1) "..Atlas_GetBossName("Chargath, Bane of Scales", 2490), 2490 },
		{ WHIT.." 2) "..Atlas_GetBossName("Forgemaster Gorek", 2489),        2489 },
		{ WHIT.." 3) "..Atlas_GetBossName("Magmatusk", 2494),                2494 },
		{ WHIT.." 4) "..Atlas_GetBossName("Warlord Sargha", 2501),           2501 },
	},
	NokhudOffensive = {
		ZoneName = { BZ["The Nokhud Offensive"] },
		Location = { BZ["Ohn'ahran Plains"] },
		DungeonID = 2368,
		DungeonHeroicID = 2369,
		DungeonMythicID = 2377,
		WorldMapID = 2093,
		JournalInstanceID = 1198,
		Module = "Atlas_Dragonflight",
		{ WHIT.." 1) "..Atlas_GetBossName("Granyth", 2498),               2498 },
		{ WHIT..INDENT..Atlas_GetBossName("Dragonkiller Lance", 2498, 2), 2498 },
		{ WHIT..INDENT..Atlas_GetBossName("Nokhud Saboteur", 2498, 3),    2498 },
		{ WHIT.." 2) "..Atlas_GetBossName("The Raging Tempest", 2497),    2497 },
		{ WHIT.." 3) "..Atlas_GetBossName("Teera and Maruuk", 2478),      2478 },
		{ WHIT..INDENT..Atlas_GetBossName("Teera", 2478, 1),              2478 },
		{ WHIT..INDENT..Atlas_GetBossName("Maruuk", 2478, 2),             2478 },
		{ WHIT.." 4) "..Atlas_GetBossName("Balakar Khan", 2477),          2477 },
		{ WHIT..INDENT..Atlas_GetBossName("Nokhud Stormcaster", 2477, 2), 2477 },
	},
	RubyLifePoolsA = {
		ZoneName = { BZ["Ruby Life Pools"]..ALC["MapA"] },
		Location = { BZ["The Waking Shores"] },
		DungeonID = 2361,
		DungeonHeroicID = 2360,
		DungeonMythicID = 2375,
		WorldMapID = 2095,
		JournalInstanceID = 1202,
		Module = "Atlas_Dragonflight",
		NextMap = "RubyLifePoolsB",
		{ WHIT.." 1) "..Atlas_GetBossName("Melidrussa Chillworn", 2488), 2488 },
		{ WHIT..INDENT..Atlas_GetBossName("Infused Whelp", 2488, 2),     2488 },
	},
	RubyLifePoolsB = {
		ZoneName = { BZ["Ruby Life Pools"]..ALC["MapB"] },
		Location = { BZ["The Waking Shores"] },
		DungeonID = 2361,
		DungeonHeroicID = 2360,
		DungeonMythicID = 2375,
		WorldMapID = 2094,
		JournalInstanceID = 1202,
		Module = "Atlas_Dragonflight",
		PrevMap = "RubyLifePoolsA",
		{ WHIT.." 2) "..Atlas_GetBossName("Kokia Blazehoof", 2485),               2485 },
		{ WHIT..INDENT..Atlas_GetBossName("Blazebound Firestorm", 2485, 2),       2485 },
		{ WHIT.." 3) "..Atlas_GetBossName("Kyrakka and Erkhart Stormvein", 2503), 2503 },
		{ WHIT..INDENT..Atlas_GetBossName("Kyrakka", 2503, 1),                    2503 },
		{ WHIT..INDENT..Atlas_GetBossName("Erkhart Stormvein", 2503, 2),          2503 },
	},
	UldamanLegacyofTyr = {
		ZoneName = { BZ["Uldaman: Legacy of Tyr"] },
		Location = { BZ["Badlands"] },
		DungeonID = 2352,
		DungeonHeroicID = 2353,
		DungeonMythicID = 2354,
		WorldMapID = 2071,
		JournalInstanceID = 1197,
		Module = "Atlas_Dragonflight",
		{ WHIT.." 1) "..Atlas_GetBossName("The Lost Dwarves", 2475),        2475 },
		{ WHIT..INDENT..Atlas_GetBossName("Baelog", 2475, 1),               2475 },
		{ WHIT..INDENT..Atlas_GetBossName("Eric \"The Swift\"", 2475, 2),   2475 },
		{ WHIT..INDENT..Atlas_GetBossName("Olaf", 2475, 3),                 2475 },
		{ WHIT.." 2) "..Atlas_GetBossName("Bromach", 2487),                 2487 },
		{ WHIT..INDENT..Atlas_GetBossName("Stonevault Ambusher", 2487, 2),  2487 },
		{ WHIT..INDENT..Atlas_GetBossName("Stonevault Geomancer", 2487, 3), 2487 },
		{ WHIT.." 3) "..Atlas_GetBossName("Sentinel Talondras", 2484),      2484 },
		{ WHIT.." 4) "..Atlas_GetBossName("Emberon", 2476),                 2476 },
		{ WHIT.." 5) "..Atlas_GetBossName("Chrono-Lord Deios", 2479),       2479 },
	},
	VaultoftheIncarnates = {
		ZoneName = { BZ["Vault of the Incarnates"] },
		Location = { BZ["Thaldraszus"] },
		DungeonID = 2390,
		DungeonHeroicID = 2389,
		DungeonMythicID = 2388,
		WorldMapID = 2119,
		JournalInstanceID = 1200,
		Module = "Atlas_Dragonflight",
		{ WHIT.." 1) "..Atlas_GetBossName("Eranog", 2480),                         2480 },
		{ WHIT..INDENT..Atlas_GetBossName("Flamescale Tarasek", 2480, 2),          2480 },
		{ WHIT..INDENT..Atlas_GetBossName("Flamescale Captain", 2480, 3),          2480 },
		{ WHIT..INDENT..Atlas_GetBossName("Primal Flame", 2480, 4),                2480 },
		{ WHIT.." 2) "..Atlas_GetBossName("Terros", 2500),                         2500 },
		{ WHIT.." 3) "..Atlas_GetBossName("The Primal Council", 2486),             2486 },
		{ WHIT..INDENT..Atlas_GetBossName("Kadros Icewrath", 2486, 1),             2486 },
		{ WHIT..INDENT..Atlas_GetBossName("Dathea Stormlash", 2486, 2),            2486 },
		{ WHIT..INDENT..Atlas_GetBossName("Opalfang", 2486, 3),                    2486 },
		{ WHIT..INDENT..Atlas_GetBossName("Embar Firepath", 2486, 4),              2486 },
		{ WHIT.." 4) "..Atlas_GetBossName("Sennarth, the Cold Breath", 2482),      2482 },
		{ WHIT..INDENT..Atlas_GetBossName("Frostbreath Arachnid", 2482, 2),        2482 },
		{ WHIT..INDENT..Atlas_GetBossName("Caustic Spiderling", 2482, 3),          2482 },
		{ WHIT.." 5) "..Atlas_GetBossName("Dathea, Ascended", 2502),               2502 },
		{ WHIT..INDENT..Atlas_GetBossName("Volatile Infuser", 2502, 2),            2502 },
		{ WHIT..INDENT..Atlas_GetBossName("Thunder Caller", 2502, 3),              2502 },
		{ WHIT.." 6) "..Atlas_GetBossName("Kurog Grimtotem", 2491),                2491 },
		{ WHIT..INDENT..Atlas_GetBossName("Tectonic Crusher", 2491, 2),            2491 },
		{ WHIT..INDENT..Atlas_GetBossName("Frozen Destroyer", 2491, 3),            2491 },
		{ WHIT..INDENT..Atlas_GetBossName("Blazing Fiend", 2491, 4),               2491 },
		{ WHIT..INDENT..Atlas_GetBossName("Thundering Ravager", 2491, 5),          2491 },
		{ WHIT..INDENT..Atlas_GetBossName("Earthwrought Smasher", 2491, 6),        2491 },
		{ WHIT..INDENT..Atlas_GetBossName("Frostwrought Dominator", 2491, 7),      2491 },
		{ WHIT..INDENT..Atlas_GetBossName("Flamewrought Eradicator", 2491, 8),     2491 },
		{ WHIT..INDENT..Atlas_GetBossName("Stormwrought Despoiler", 2491, 9),      2491 },
		{ WHIT.." 7) "..Atlas_GetBossName("Broodkeeper Diurna", 2493),             2493 },
		{ WHIT..INDENT..Atlas_GetBossName("Juvenile Frost Proto-Dragon", 2493, 2), 2493 },
		{ WHIT..INDENT..Atlas_GetBossName("Tarasek Earthreaver", 2493, 3),         2493 },
		{ WHIT..INDENT..Atlas_GetBossName("Dragonspawn Flamebender", 2493, 4),     2493 },
		{ WHIT..INDENT..Atlas_GetBossName("Drakonid Stormbringer", 2493, 5),       2493 },
		{ WHIT..INDENT..Atlas_GetBossName("Nascent Proto-Dragon", 2493, 6),        2493 },
		{ WHIT..INDENT..Atlas_GetBossName("Primalist Mage", 2493, 7),              2493 },
		{ WHIT..INDENT..Atlas_GetBossName("Tarasek Legionnaire", 2493, 8),         2493 },
		{ WHIT.." 8) "..Atlas_GetBossName("Raszageth the Storm-Eater", 2499),      2499 },
		{ WHIT..INDENT..Atlas_GetBossName("Volatile Spark", 2499, 2),              2499 },
		{ WHIT..INDENT..Atlas_GetBossName("Surging Ruiner", 2499, 3),              2499 },
		{ WHIT..INDENT..Atlas_GetBossName("Oathsworn Vanguard", 2499, 4),          2499 },
		{ WHIT..INDENT..Atlas_GetBossName("Stormseeker Acolyte", 2499, 5),         2499 },
		{ WHIT..INDENT..Atlas_GetBossName("Colossal Stormfiend", 2499, 6),         2499 },
		{ WHIT..INDENT..Atlas_GetBossName("Frostforged Zealot", 2499, 7),          2499 },
		{ WHIT..INDENT..Atlas_GetBossName("Flamesworn Herald", 2499, 8),           2499 },
	},
	Aberrus = {
		ZoneName = { i(1208) },
		Location = { z(14022) },
		DungeonID = 2403,
		DungeonHeroicID = 2404,
		DungeonMythicID = 2405,
		WorldMapID = 2166,
		JournalInstanceID = 1208,
		Module = "Atlas_Dragonflight",
		{ WHIT.." 1) "..Atlas_GetBossName("Kazzara, the Hellforged", 2522),      2522 },
		{ WHIT.." 2) "..Atlas_GetBossName("The Amalgamation Chamber", 2529),     2529 },
		{ WHIT..INDENT..Atlas_GetBossName("Essence of Shadow", 2529, 1),         2529 },
		{ WHIT..INDENT..Atlas_GetBossName("Eternal Blaze", 2529, 2),             2529 },
		{ WHIT..INDENT..Atlas_GetBossName("Shadowflame Amalgamation", 2529, 3),  2529 },
		{ WHIT.." 3) "..Atlas_GetBossName("The Forgotten Experiments", 2530),    2530 },
		{ WHIT..INDENT..Atlas_GetBossName("Neldris", 2530, 1),                   2530 },
		{ WHIT..INDENT..Atlas_GetBossName("Thadrion", 2530, 2),                  2530 },
		{ WHIT..INDENT..Atlas_GetBossName("Rionthus", 2530, 3),                  2530 },
		{ WHIT.." 4) "..Atlas_GetBossName("Assault of the Zaqali", 2524),        2524 },
		{ WHIT..INDENT..Atlas_GetBossName("Warlord Kagni", 2524, 1),             2524 },
		{ WHIT..INDENT..Atlas_GetBossName("Ignara", 2524, 2),                    2524 },
		{ WHIT..INDENT..Atlas_GetBossName("Zaqali Wallclimber", 2524, 3),        2524 },
		{ WHIT..INDENT..Atlas_GetBossName("Flamebound Huntsman", 2524, 4),       2524 },
		{ WHIT..INDENT..Atlas_GetBossName("Magma Mystic", 2524, 5),              2524 },
		{ WHIT..INDENT..Atlas_GetBossName("Obsidian Guard", 2524, 6),            2524 },
		{ WHIT.." 5) "..Atlas_GetBossName("Rashok, the Elder", 2525),            2525 },
		{ WHIT.." 6) "..Atlas_GetBossName("The Vigilant Steward, Zskarn", 2532), 2532 },
		{ WHIT..INDENT..Atlas_GetBossName("Dragonfire Golem", 2532, 2),          2532 },
		{ WHIT.." 7) "..Atlas_GetBossName("Magmorax", 2527),                     2527 },
		{ WHIT.." 8) "..Atlas_GetBossName("Echo of Neltharion", 2523),           2523 },
		{ WHIT..INDENT..Atlas_GetBossName("Voice From Beyond", 2523, 2),         2523 },
		{ WHIT..INDENT..Atlas_GetBossName("Twisted Aberration", 2523, 3),        2523 },
		{ WHIT.." 9) "..Atlas_GetBossName("Scalecommander Sarkareth", 2520),     2520 },
		{ WHIT..INDENT..Atlas_GetBossName("Empty Recollection", 2520, 2),        2520 },
		{ WHIT..INDENT..Atlas_GetBossName("Null Glimmer", 2520, 3),              2520 },
	},
	AmirdrassilA = {
		ZoneName = { i(1207)..ALC["MapA"] },
		Location = { BZ["Emerald Dream"] },
		DungeonID = 2502,
		DungeonHeroicID = 2503,
		DungeonMythicID = 2504,
		WorldMapID = 2232,
		JournalInstanceID = 1207,
		Module = "Atlas_Dragonflight",
		NextMap = "AmirdrassilB",
		{ WHIT.." 1) "..Atlas_GetBossName("Gnarlroot", 2564),                    2564 },
		{ WHIT..INDENT..Atlas_GetBossName("Flame-Tormented Ancient", 2564, 1),   2564 },
		{ WHIT..INDENT..Atlas_GetBossName("Tainted Lasher", 2564, 2),            2564 },
		{ WHIT..INDENT..Atlas_GetBossName("Tainted Treant", 2564, 3),            2564 },
		{ WHIT.." 2) "..Atlas_GetBossName("Igira the Cruel", 2554),              2554 },
		{ WHIT.." 3) "..Atlas_GetBossName("Volcoross", 2557),                    2557 },
		{ WHIT..INDENT..Atlas_GetBossName("Scorchtail", 2557, 2),                2557 },
		{ WHIT.." 4) "..Atlas_GetBossName("Council of Dreams", 2555),            2555 },
		{ WHIT..INDENT..Atlas_GetBossName("Urctos", 2555, 1),                    2555 },
		{ WHIT..INDENT..Atlas_GetBossName("Aerwynn", 2555, 2),                   2555 },
		{ WHIT..INDENT..Atlas_GetBossName("Pip", 2555, 3),                       2555 },
		{ WHIT.." 5) "..Atlas_GetBossName("Larodar, Keeper of the Flame", 2553), 2553 },
		{ WHIT..INDENT..Atlas_GetBossName("Seed of Life", 2553, 2),              2553 },
		{ WHIT..INDENT..Atlas_GetBossName("Fiery Treant", 2553, 3),              2553 },
		{ WHIT..INDENT..Atlas_GetBossName("Scorching Roots", 2553, 4),           2553 },
		{ WHIT.." 6) "..Atlas_GetBossName("Nymue, Weaver of the Cycle", 2556),   2556 },
		{ WHIT..INDENT..Atlas_GetBossName("Cycle Warden", 2556, 2),              2556 },
		{ WHIT.." 7) "..Atlas_GetBossName("Smolderon", 2563),                    2563 },
	},
	AmirdrassilB = {
		ZoneName = { i(1207)..ALC["MapB"] },
		Location = { BZ["Emerald Dream"] },
		DungeonID = 2502,
		DungeonHeroicID = 2503,
		DungeonMythicID = 2504,
		WorldMapID = 2234,
		JournalInstanceID = 1207,
		Module = "Atlas_Dragonflight",
		PrevMap = "AmirdrassilA",
		{ WHIT.." 8) "..Atlas_GetBossName("Tindral Sageswift, Seer of the Flame", 2565), 2565 },
		{ WHIT.." 9) "..Atlas_GetBossName("Fyrakk the Blazing", 2519),                   2519 },
		{ WHIT..INDENT..Atlas_GetBossName("Spirit of the Kaldorei", 2519, 2),            2519 },
		{ WHIT..INDENT..Atlas_GetBossName("Screaming Soul", 2519, 3),                    2519 },
		{ WHIT..INDENT..Atlas_GetBossName("Burning Colossus", 2519, 4),                  2519 },
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
	AlgetharAcademy = {
		{ 1, 2509, 161, 322 },
		{ 2, 2512, 283, 341 },
		{ 3, 2495, 268, 100 },
		{ 4, 2514, 330, 458 },
	},
	AzureVault = {
		{ 1, 2492, 80,  161 },
		{ 2, 2505, 406, 308 },
		{ 3, 2483, 178, 323 },
		{ 4, 2508, 213, 308 },
	},
	BrackenhideHollow = {
		{ 1, 2471, 215, 221 },
		{ 2, 2473, 347, 390 },
		{ 3, 2472, 345, 169 },
		{ 4, 2474, 449, 268 },
	},
	HallsofInfusion = {
		{ 1, 2504, 323, 251 },
		{ 2, 2507, 292, 429 },
		{ 3, 2510, 121, 414 },
		{ 4, 2511, 213, 251 },
	},
	Neltharus = {
		{ 1, 2490, 194, 327 },
		{ 2, 2489, 85,  346 },
		{ 3, 2494, 350, 306 },
		{ 4, 2501, 253, 410 },
	},
	NokhudOffensive = {
		{ 1, 2498, 429, 232 },
		{ 2, 2497, 248, 388 },
		{ 3, 2478, 12,  363 },
		{ 4, 2477, 54,  124 },
	},
	RubyLifePoolsB = {
		{ 2, 2485, 200, 220 },
		{ 3, 2503, 68,  108 },
	},
	UldamanLegacyofTyr = {
		{ 1, 2475, 369, 480 },
		{ 2, 2487, 302, 418 },
		{ 3, 2484, 172, 439 },
		{ 4, 2476, 134, 311 },
		{ 5, 2479, 131, 79 },
	},
	VaultoftheIncarnates = {
		{ 1, 2480, 271, 287 },
		{ 2, 2500, 188, 247 },
		{ 3, 2486, 203, 304 },
		{ 4, 2482, 196, 204 },
		{ 5, 2502, 248, 287 },
		{ 6, 2491, 240, 216 },
		{ 7, 2493, 255, 199 },
		{ 8, 2499, 191, 111 },
	},
	Aberrus = {
		{ 1, 2522, 230, 318 },
		{ 2, 2529, 86,  219 },
		{ 3, 2530, 154, 146 },
		{ 4, 2524, 342, 103 },
		{ 5, 2525, 301, 145 },
		{ 6, 2532, 229, 144 },
		{ 7, 2527, 229, 221 },
		{ 8, 2523, 229, 356 },
		{ 9, 2520, 228, 446 },
	},
	AmirdrassilA = {
		{ 1, 2564, 232, 366 },
		{ 2, 2554, 232, 342 },
		{ 3, 2557, 123, 253 },
		{ 4, 2555, 350, 245 },
		{ 5, 2553, 53,  184 },
		{ 6, 2556, 423, 168 },
		{ 7, 2563, 232, 244 },
	},
	AmirdrassilB = {
		{ 8, 2565, 205, 456 },
		{ 9, 2519, 395, 331 },
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
	["RubyLifePoolsA"] = { "RubyLifePoolsA", "RubyLifePoolsB" },
	["RubyLifePoolsB"] = { "RubyLifePoolsA", "RubyLifePoolsB" },
	["AmirdrassilA"] = { "AmirdrassilA", "AmirdrassilB" },
	["AmirdrassilB"] = { "AmirdrassilA", "AmirdrassilB" },
}

db.SubZoneAssoc = {
	--	["BlackRookHoldA"] = 			BZ["Black Rook Hold"],
}

db.DropDownLayouts_Order = {
	[ATLAS_DDL_CONTINENT] = {
		ATLAS_DDL_CONTINENT_DRAGONISLES,
		ATLAS_DDL_CONTINENT_EASTERN,
	},
	[ATLAS_DDL_LEVEL] = {
		ATLAS_DDL_LEVEL_60TO70,
	},
	[ATLAS_DDL_EXPANSION] = {
		ATLAS_DDL_EXPANSION_DRAGONFLIGHT,
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
		[ATLAS_DDL_CONTINENT_DRAGONISLES] = {
			"AlgetharAcademy",
			"AzureVault",
			"BrackenhideHollow",
			"DawnoftheInfinite",
			"HallsofInfusion",
			"Neltharus",
			"NokhudOffensive",
			"RubyLifePoolsA",
			"RubyLifePoolsB",
			"VaultoftheIncarnates",
			"Aberrus",
			"AmirdrassilA",
			"AmirdrassilB",
		},
		[ATLAS_DDL_CONTINENT_EASTERN] = {
			"UldamanLegacyofTyr",
		}
	},
	[ATLAS_DDL_EXPANSION] = {
		[ATLAS_DDL_EXPANSION_DRAGONFLIGHT] = {
			"AlgetharAcademy",
			"AzureVault",
			"BrackenhideHollow",
			"DawnoftheInfinite",
			"HallsofInfusion",
			"Neltharus",
			"NokhudOffensive",
			"RubyLifePoolsA",
			"RubyLifePoolsB",
			"UldamanLegacyofTyr",
			"VaultoftheIncarnates",
			"Aberrus",
			"AmirdrassilA",
			"AmirdrassilB",
		},
	},
	[ATLAS_DDL_LEVEL] = {
		[ATLAS_DDL_LEVEL_60TO70] = {
			"AlgetharAcademy",
			"AzureVault",
			"BrackenhideHollow",
			"DawnoftheInfinite",
			"HallsofInfusion",
			"Neltharus",
			"NokhudOffensive",
			"RubyLifePoolsA",
			"RubyLifePoolsB",
			"UldamanLegacyofTyr",
			"VaultoftheIncarnates",
			"Aberrus",
			"AmirdrassilA",
			"AmirdrassilB",
		},
	},
	[ATLAS_DDL_PARTYSIZE] = {
		[ATLAS_DDL_PARTYSIZE_5] = {
			"AlgetharAcademy",
			"AzureVault",
			"BrackenhideHollow",
			"DawnoftheInfinite",
			"HallsofInfusion",
			"Neltharus",
			"NokhudOffensive",
			"RubyLifePoolsA",
			"RubyLifePoolsB",
			"UldamanLegacyofTyr",
		},
		[ATLAS_DDL_PARTYSIZE_10] = {
			"VaultoftheIncarnates",
			"Aberrus",
			"AmirdrassilA",
			"AmirdrassilB",
		},
		[ATLAS_DDL_PARTYSIZE_20TO40] = {
			"VaultoftheIncarnates",
			"Aberrus",
			"AmirdrassilA",
			"AmirdrassilB",
		},
	},
	[ATLAS_DDL_TYPE] = {
		[ATLAS_DDL_TYPE_INSTANCE] = {
			"AlgetharAcademy",
			"AzureVault",
			"BrackenhideHollow",
			"DawnoftheInfinite",
			"HallsofInfusion",
			"Neltharus",
			"NokhudOffensive",
			"RubyLifePoolsA",
			"RubyLifePoolsB",
			"UldamanLegacyofTyr",
			"VaultoftheIncarnates",
			"Aberrus",
			"AmirdrassilA",
			"AmirdrassilB",
		},
	},
}
