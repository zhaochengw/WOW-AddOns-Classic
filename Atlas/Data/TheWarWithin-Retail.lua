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

private.addon_name = "Atlas_TheWarWithin"
private.module_name = "TheWarWithin"

local ALC = LibStub("AceLocale-3.0"):GetLocale("Atlas")
local Atlas = LibStub("AceAddon-3.0"):GetAddon("Atlas")
local TWW = Atlas:NewModule(private.module_name)

local db = {}
TWW.db = db

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
	TheRookery = {
		ZoneName = { i(1268) },
		Location = { z(14771) },
		DungeonID = 2637,
		DungeonHeroicID = 2658,
		DungeonMythicID = 2717,
		WorldMapID = 2315,
		JournalInstanceID = 1268,
		Module = "Atlas_TheWarWithin",
		{ WHIT.." 1) "..Atlas_GetBossName("Kyrioss", 2566),               2566 },
		{ WHIT.." 2) "..Atlas_GetBossName("Stormguard Gorren", 2567),     2567 },
		{ WHIT.." 3) "..Atlas_GetBossName("Voidstone Monstrosity", 2568), 2568 },
		{ WHIT..INDENT..Atlas_GetBossName("Voidstone Fragment", 2568, 2), 2568 },
		{ WHIT..INDENT..Atlas_GetBossName("Voidstone Awakened", 2568, 3), 2568 },
		{ WHIT..INDENT..Atlas_GetBossName("Stormrider Vokmar", 2568, 4),  2568 },
	},
	TheStonevault = {
		ZoneName = { i(1269) },
		Location = { z(14795) },
		DungeonID = 2693,
		DungeonHeroicID = 2694,
		DungeonMythicID = 2720,
		WorldMapID = 2341,
		JournalInstanceID = 1269,
		Module = "Atlas_TheWarWithin",
		{ WHIT.." 1) "..Atlas_GetBossName("E.D.N.A.", 2572),            2572 },
		{ WHIT.." 2) "..Atlas_GetBossName("Skarmorak", 2579),           2579 },
		{ WHIT..INDENT..Atlas_GetBossName("Crystal Shard", 2579, 2),    2579 },
		{ WHIT.." 3) "..Atlas_GetBossName("Master Machinists", 2590),   2590 },
		{ WHIT..INDENT..Atlas_GetBossName("Speaker Dorlita", 2590, 1),  2590 },
		{ WHIT..INDENT..Atlas_GetBossName("Speaker Brokk", 2590, 2),    2590 },
		{ WHIT.." 4) "..Atlas_GetBossName("Void Speaker Eirich", 2582), 2582 },
	},
	PrioryoftheSacredFlame = {
		ZoneName = { i(1267) },
		Location = { z(14838) },
		DungeonID = 2695,
		DungeonHeroicID = 2696,
		DungeonMythicID = 2697,
		WorldMapID = 2308,
		JournalInstanceID = 1267,
		Module = "Atlas_TheWarWithin",
		{ WHIT.." 1) "..Atlas_GetBossName("Captain Dailcry", 2571),        2571 },
		{ WHIT..INDENT..Atlas_GetBossName("Elaena Emberlanz", 2571, 2),    2571 },
		{ WHIT..INDENT..Atlas_GetBossName("Sergeant Shaynemail", 2571, 3), 2571 },
		{ WHIT..INDENT..Atlas_GetBossName("Taener Duelmal", 2571, 4),      2571 },
		{ WHIT.." 2) "..Atlas_GetBossName("Baron Braunpyke", 2570),        2570 },
		{ WHIT.." 3) "..Atlas_GetBossName("Prioress Murrpray", 2573),      2573 },
		{ WHIT..INDENT..Atlas_GetBossName("Arathi Neophyte", 2573, 2),     2573 },
	},
	AraKaraCityofEchoes = {
		ZoneName = { i(1271) },
		Location = { z(14752) },
		DungeonID = 2604,
		DungeonHeroicID = 2605,
		DungeonMythicID = 2606,
		WorldMapID = 2357,
		JournalInstanceID = 1271,
		Module = "Atlas_TheWarWithin",
		{ WHIT.." 1) "..Atlas_GetBossName("Avanoxx", 2583),                 2583 },
		{ WHIT..INDENT..Atlas_GetBossName("Starved Crawler", 2583, 2),      2583 },
		{ WHIT.." 2) "..Atlas_GetBossName("Anub'zekt", 2584),               2584 },
		{ WHIT..INDENT..Atlas_GetBossName("Bloodstained Webmage", 2584, 2), 2584 },
		{ WHIT.." 3) "..Atlas_GetBossName("Ki'katal the Harvester", 2585),  2585 },
	},
	CinderbrewMeadery = {
		ZoneName = { i(1272) },
		Location = { z(14717) },
		DungeonID = 2689,
		DungeonHeroicID = 2690,
		DungeonMythicID = 2691,
		WorldMapID = 2335,
		JournalInstanceID = 1272,
		Module = "Atlas_TheWarWithin",
		{ WHIT.." 1) "..Atlas_GetBossName("Brew Master Aldryr", 2586),    2586 },
		{ WHIT..INDENT..Atlas_GetBossName("Thirsty Patron", 2586, 2),     2586 },
		{ WHIT.." 2) "..Atlas_GetBossName("I'pa", 2587),                  2587 },
		{ WHIT..INDENT..Atlas_GetBossName("Brew Drop", 2587, 2),          2587 },
		{ WHIT.." 3) "..Atlas_GetBossName("Benk Buzzbee", 2588),          2588 },
		{ WHIT..INDENT..Atlas_GetBossName("Cindy", 2588, 2),              2588 },
		{ WHIT..INDENT..Atlas_GetBossName("Ravenous Cinderbee", 2588, 3), 2588 },
		{ WHIT.." 4) "..Atlas_GetBossName("Goldie Baronbottom", 2589),    2589 },
	},
	DarkflameCleft = {
		ZoneName = { i(1210) },
		Location = { z(14795) },
		DungeonID = 2518,
		DungeonHeroicID = 2519,
		DungeonMythicID = 2520,
		WorldMapID = 2303,
		JournalInstanceID = 1210,
		Module = "Atlas_TheWarWithin",
		{ WHIT.." 1) "..Atlas_GetBossName("Ol' Waxbeard", 2569),    2569 },
		{ WHIT..INDENT..Atlas_GetBossName("Wick", 2569, 2),         2569 },
		{ WHIT.." 2) "..Atlas_GetBossName("Blazikon", 2559),        2559 },
		{ WHIT.." 3) "..Atlas_GetBossName("The Candle King", 2560), 2560 },
		{ WHIT.." 4) "..Atlas_GetBossName("The Darkness", 2561),    2561 },
	},
	TheDawnbreaker = {
		ZoneName = { i(1270) },
		Location = { z(14838) },
		DungeonID = 2523,
		DungeonHeroicID = 2524,
		DungeonMythicID = 2525,
		WorldMapID = 2359,
		JournalInstanceID = 1270,
		Module = "Atlas_TheWarWithin",
		{ WHIT.." 1) "..Atlas_GetBossName("Speaker Shadowcrown", 2580), 2580 },
		{ WHIT.." 2) "..Atlas_GetBossName("Anub'ikkaj", 2581),          2581 },
		{ WHIT.." 3) "..Atlas_GetBossName("Rasha'nan", 2593),           2593 },
	},
	CityofThreads = {
		ZoneName = { i(1274) },
		Location = { z(14752) },
		DungeonID = 2642,
		DungeonHeroicID = 2643,
		DungeonMythicID = 2647,
		WorldMapID = 2343,
		JournalInstanceID = 1274,
		Module = "Atlas_TheWarWithin",
		{ WHIT.." 1) "..Atlas_GetBossName("Orator Krix'vizk", 2594),       2594 },
		{ WHIT.." 2) "..Atlas_GetBossName("Fangs of the Queen", 2595),     2595 },
		{ WHIT..INDENT..Atlas_GetBossName("Nx", 2595, 1),                  2595 },
		{ WHIT..INDENT..Atlas_GetBossName("Vx", 2595, 2),                  2595 },
		{ WHIT.." 3) "..Atlas_GetBossName("The Coaglamation", 2600),       2600 },
		{ WHIT.." 4) "..Atlas_GetBossName("Izo, the Grand Splicer", 2596), 2596 },
	},
	OperationFloodgateA = {
		ZoneName = { i(1298)..ALC["MapA"] },
		Location = { z(14795) },
		DungeonID = 2791,
		DungeonHeroicID = 2812,
		DungeonMythicID = 2793,
		WorldMapID = 2387,
		JournalInstanceID = 1298,
		Module = "Atlas_TheWarWithin",
		NextMap = "OperationFloodgateB",
		{ WHIT.." 1) "..Atlas_GetBossName("Big M.O.M.M.A.", 2648),         2648 },
		{ WHIT..INDENT..Atlas_GetBossName("Darkfuse Mechadrone", 2648, 2), 2648 },
		{ WHIT.." 2) "..Atlas_GetBossName("Demolition Duo", 2649),         2649 },
		{ WHIT..INDENT..Atlas_GetBossName("Keeza Quickfuse", 2649, 1),     2649 },
		{ WHIT..INDENT..Atlas_GetBossName("Bront", 2649, 2),               2649 },
		{ WHIT.." 3) "..Atlas_GetBossName("Swampface", 2650),              2650 },
	},
	OperationFloodgateB = {
		ZoneName = { i(1298)..ALC["MapB"] },
		Location = { z(14795) },
		DungeonID = 2791,
		DungeonHeroicID = 2812,
		DungeonMythicID = 2793,
		WorldMapID = 2388,
		JournalInstanceID = 1298,
		PrevMap = "OperationFloodgateA",
		Module = "Atlas_TheWarWithin",
		{ WHIT.." 4) "..Atlas_GetBossName("Geezle Gigazap", 2651), 2651 },
	},
	EcoDomeAldani = {
		ZoneName = { i(1303) },
		Location = { z(15336) },
		DungeonID = 2987,
		DungeonHeroicID = 2988,
		DungeonMythicID = 2989,
		WorldMapID = 2449,
		JournalInstanceID = 1303,
		Module = "Atlas_TheWarWithin",
		{ WHIT.." 1) "..Atlas_GetBossName("Azhiccar", 2675),            2675 },
		{ WHIT..INDENT..Atlas_GetBossName("Frenzied Mite", 2675, 2),    2675 },
		{ WHIT.." 2) "..Atlas_GetBossName("Taah'bat and A'wazj", 2676), 2676 },
		{ WHIT..INDENT..Atlas_GetBossName("Taah'bat", 2676, 1),         2676 },
		{ WHIT..INDENT..Atlas_GetBossName("A'wazj", 2676, 2),           2676 },
		{ WHIT.." 3) "..Atlas_GetBossName("Soul-Scribe", 2677),         2677 },
	},
	NerubarPalace = {
		ZoneName = { i(1273) },
		Location = { z(14752) },
		DungeonID = 2645,
		--DungeonHeroicID = ,
		--DungeonMythicID = ,
		WorldMapID = 2291,
		JournalInstanceID = 1273,
		Module = "Atlas_TheWarWithin",
		{ WHIT.." 1) "..Atlas_GetBossName("Ulgrax the Devourer", 2607),           2607 },
		{ WHIT..INDENT..Atlas_GetBossName("Ravenous Spawn", 2607, 2),             2607 },
		{ WHIT.." 2) "..Atlas_GetBossName("The Bloodbound Horror", 2611),         2611 },
		{ WHIT..INDENT..Atlas_GetBossName("Lost Watcher", 2611, 2),               2611 },
		{ WHIT..INDENT..Atlas_GetBossName("Forgotten Harbinger", 2611, 3),        2611 },
		{ WHIT..INDENT..Atlas_GetBossName("Blood Horror", 2611, 4),               2611 },
		{ WHIT.." 3) "..Atlas_GetBossName("Sikran, Captain of the Sureki", 2599), 2599 },
		{ WHIT.." 4) "..Atlas_GetBossName("Rasha'nan", 2609),                     2609 },
		{ WHIT..INDENT..Atlas_GetBossName("Infested Spawn", 2609, 2),             2609 },
		{ WHIT.." 5) "..Atlas_GetBossName("Broodtwister Ovi'nax", 2612),          2612 },
		{ WHIT..INDENT..Atlas_GetBossName("Colossal Spider", 2612, 2),            2612 },
		{ WHIT..INDENT..Atlas_GetBossName("Voracious Worm", 2612, 3),             2612 },
		{ WHIT..INDENT..Atlas_GetBossName("Blood Parasite", 2612, 4),             2612 },
		{ WHIT.." 6) "..Atlas_GetBossName("Nexus-Princess Ky'veza", 2601),        2601 },
		{ WHIT.." 7) "..Atlas_GetBossName("The Silken Court", 2608),              2608 },
		{ WHIT..INDENT..Atlas_GetBossName("Anub'arash", 2608, 1),                 2608 },
		{ WHIT..INDENT..Atlas_GetBossName("Skeinspinner Takazj", 2608, 2),        2608 },
		{ WHIT..INDENT..Atlas_GetBossName("Shattershell Scarab", 2608, 3),        2608 },
		{ WHIT.." 8) "..Atlas_GetBossName("Queen Ansurek", 2602),                 2602 },
		{ WHIT..INDENT..Atlas_GetBossName("Ascended Voidspeaker", 2602, 2),       2602 },
		{ WHIT..INDENT..Atlas_GetBossName("Devoted Worshipper", 2602, 3),         2602 },
		{ WHIT..INDENT..Atlas_GetBossName("Chamber Guardian", 2602, 4),           2602 },
		{ WHIT..INDENT..Atlas_GetBossName("Chamber Expeller", 2602, 5),           2602 },
		{ WHIT..INDENT..Atlas_GetBossName("Caustic Skitterer", 2602, 6),          2602 },
		{ WHIT..INDENT..Atlas_GetBossName("Summoned Acolyte", 2602, 7),           2602 },
		{ WHIT..INDENT..Atlas_GetBossName("Gloom Hatchling", 2602, 8),            2602 },
	},
	LiberationofUndermine = {
		ZoneName = { i(1296) },
		Location = { z(15347) },
		DungeonID = 2779,
		DungeonHeroicID = 2892,
		DungeonMythicID = 2893,
		WorldMapID = 2406,
		JournalInstanceID = 1296,
		Module = "Atlas_TheWarWithin",
		{ WHIT.." 1) "..Atlas_GetBossName("Vexie and the Geargrinders", 2639), 2639 },
		{ WHIT..INDENT..Atlas_GetBossName("The Geargrinder", 2639, 1),         2639 },
		{ WHIT..INDENT..Atlas_GetBossName("Vexie Fullthrottle", 2639, 2),      2639 },
		{ WHIT..INDENT..Atlas_GetBossName("Geargrinder Biker", 2639, 3),       2639 },
		{ WHIT..INDENT..Atlas_GetBossName("Pit Mechanic", 2639, 4),            2639 },
		{ WHIT..INDENT..Atlas_GetBossName("Support Rig", 2639, 5),             2639 },
		{ WHIT.." 2) "..Atlas_GetBossName("Cauldron of Carnage", 2640),        2640 },
		{ WHIT..INDENT..Atlas_GetBossName("Flarendo the Furious", 2640, 1),    2640 },
		{ WHIT..INDENT..Atlas_GetBossName("Torq the Tempest", 2640, 2),        2640 },
		{ WHIT.." 3) "..Atlas_GetBossName("Rik Reverb", 2641),                 2641 },
		{ WHIT..INDENT..Atlas_GetBossName("Amplifier", 2641, 2),               2641 },
		{ WHIT.." 4) "..Atlas_GetBossName("Stix Bunkjunker", 2642),            2642 },
		{ WHIT..INDENT..Atlas_GetBossName("Scrap Shooter", 2642, 2),           2642 },
		{ WHIT..INDENT..Atlas_GetBossName("Junkyard Hyena", 2642, 3),          2642 },
		{ WHIT..INDENT..Atlas_GetBossName("Territorial Bombshell", 2642, 4),   2642 },
		{ WHIT.." 5) "..Atlas_GetBossName("Sprocketmonger Lockenstock", 2653), 2653 },
		{ WHIT..INDENT..Atlas_GetBossName("Beam Turret", 2653, 2),             2653 },
		{ WHIT..INDENT..Atlas_GetBossName("Rocket Launcher", 2653, 3),         2653 },
		{ WHIT..INDENT..Atlas_GetBossName("Mega Magnet", 2653, 4),             2653 },
		{ WHIT..INDENT..Atlas_GetBossName("Void Turret", 2653, 5),             2653 },
		{ WHIT..INDENT..Atlas_GetBossName("Void Launcher", 2653, 6),           2653 },
		{ WHIT.." 6) "..Atlas_GetBossName("The One-Armed Bandit", 2644),       2644 },
		{ WHIT..INDENT..Atlas_GetBossName("Reel Assistant", 2644, 2),          2644 },
		{ WHIT.." 7) "..Atlas_GetBossName("Mug'Zee, Heads of Security", 2645), 2645 },
		{ WHIT..INDENT..Atlas_GetBossName("Unstable Crawler Mine", 2645, 2),   2645 },
		{ WHIT..INDENT..Atlas_GetBossName("Gallagio Goon", 2645, 3),           2645 },
		{ WHIT..INDENT..Atlas_GetBossName("Volunteer Rocketeer", 2645, 4),     2645 },
		{ WHIT..INDENT..Atlas_GetBossName("Mk II Electro Shocker", 2645, 5),   2645 },
		{ WHIT.." 8) "..Atlas_GetBossName("Chrome King Gallywix", 2646),       2646 },
	},
	ManaforgeOmegaA = {
		ZoneName = { i(1302)..ALC["MapA"] },
		Location = { z(15336) },
		DungeonID = 2805,
		DungeonHeroicID = 3073,
		DungeonMythicID = 3074,
		WorldMapID = 2460,
		JournalInstanceID = 1302,
		Module = "Atlas_TheWarWithin",
		NextMap = "ManaforgeOmegaB",
		{ WHIT.." 1) "..Atlas_GetBossName("Plexus Sentinel", 2684),              2684 },
		{ WHIT..INDENT..Atlas_GetBossName("Volatile Manifestation", 2684, 2),    2684 },
		{ WHIT.." 5) "..Atlas_GetBossName("The Soul Hunters", 2688),             2688 },
		{ WHIT..INDENT..Atlas_GetBossName("Adarus Duskblaze", 2688, 1),          2688 },
		{ WHIT..INDENT..Atlas_GetBossName("Velaryn Bloodwrath", 2688, 2),        2688 },
		{ WHIT..INDENT..Atlas_GetBossName("Ilyssa Darksorrow", 2688, 3),         2688 },
		{ WHIT.." 6) "..Atlas_GetBossName("Fractillus", 2747),                   2747 },
		{ WHIT.." 7) "..Atlas_GetBossName("Nexus-King Salhadaar", 2690),         2690 },
		{ WHIT..INDENT..Atlas_GetBossName("The Royal Voidwing", 2690, 2),        2690 },
		{ WHIT..INDENT..Atlas_GetBossName("Manaforged Titan", 2690, 3),          2690 },
		{ WHIT..INDENT..Atlas_GetBossName("Nexus-Prince Ky'vor", 2690, 4),       2690 },
		{ WHIT..INDENT..Atlas_GetBossName("Nexus-Prince Xevvos", 2690, 5),       2690 },
		{ WHIT..INDENT..Atlas_GetBossName("Shadowguard Reaper", 2690, 6),        2690 },
		{ WHIT.." 8) "..Atlas_GetBossName("Dimensius, the All-Devouring", 2691), 2691 },
		{ WHIT..INDENT..Atlas_GetBossName("Artoshion", 2691, 2),                 2691 },
		{ WHIT..INDENT..Atlas_GetBossName("Pargoth", 2691, 3),                   2691 },
	},
	ManaforgeOmegaB = {
		ZoneName = { i(1302)..ALC["MapB"] },
		Location = { z(15336) },
		DungeonID = 2805,
		DungeonHeroicID = 3073,
		DungeonMythicID = 3074,
		WorldMapID = 2460,
		JournalInstanceID = 1302,
		Module = "Atlas_TheWarWithin",
		PrevMap = "ManaforgeOmegaA",
		{ WHIT.." 2) "..Atlas_GetBossName("Loom'ithar", 2686),                2686 },
		{ WHIT.." 3) "..Atlas_GetBossName("Soulbinder Naazindhri", 2685),     2685 },
		{ WHIT..INDENT..Atlas_GetBossName("Shadowguard Mage", 2685, 2),       2685 },
		{ WHIT..INDENT..Atlas_GetBossName("Shadowguard Assassin", 2685, 3),   2685 },
		{ WHIT..INDENT..Atlas_GetBossName("Shadowguard Phaseblade", 2685, 4), 2685 },
		{ WHIT.." 4) "..Atlas_GetBossName("Forgeweaver Araz", 2687),          2687 },
		{ WHIT..INDENT..Atlas_GetBossName("Arcane Echo", 2687, 2),            2687 },
		{ WHIT..INDENT..Atlas_GetBossName("Arcane Collector", 2687, 3),       2687 },
		{ WHIT..INDENT..Atlas_GetBossName("Shielded Attendant", 2687, 4),     2687 },
		{ WHIT..INDENT..Atlas_GetBossName("Arcane Manifestation", 2687, 5),   2687 },
		{ WHIT..INDENT..Atlas_GetBossName("Void Manifestation", 2687, 6),     2687 },
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
	TheStonevault = {
		{ 1, 2572, 286, 229 },
		{ 2, 2579, 409, 201 },
		{ 3, 2590, 150, 320 },
		{ 4, 2582, 285, 316 },
	},
	PrioryoftheSacredFlame = {
		{ 1, 2571, 281, 278 },
		{ 2, 2570, 221, 285 },
		{ 3, 2573, 79,  300 },
	},
	AraKaraCityofEchoes = {
		{ 1, 2583, 373, 189 },
		{ 2, 2584, 157, 233 },
		{ 3, 2585, 35,  379 },
	},
	CinderbrewMeadery = {
		{ 1, 2586, 210, 289 },
		{ 2, 2587, 181, 151 },
		{ 3, 2588, 266, 399 },
		{ 4, 2589, 292, 288 },
	},
	DarkflameCleft = {
		{ 1, 2569, 81,  163 },
		{ 2, 2559, 194, 247 },
		{ 3, 2560, 194, 431 },
		{ 4, 2561, 412, 382 },
	},
	TheDawnbreaker = {
		{ 1, 2580, 284, 112 },
	},
	CityofThreads = {
		{ 1, 2594, 240, 162 },
		{ 2, 2595, 323, 291 },
		{ 3, 2600, 256, 424 },
		{ 4, 2596, 256, 457 },
	},
	OperationFloodgateA = {
		{ 1, 2648, 93,  309 },
		{ 2, 2649, 351, 349 },
		{ 3, 2650, 251, 373 },
	},
	OperationFloodgateB = {
		{ 4, 2651, 363, 408 },
	},
	EcoDomeAldani = {
		{ 1, 2675, 330, 387 },
		{ 2, 2676, 305, 240 },
		{ 3, 2677, 128, 203 },
	},
	NerubarPalace = {
		{ 1, 2607, 369, 142 },
		{ 2, 2611, 367, 314 },
		{ 3, 2599, 423, 297 },
		{ 4, 2609, 318, 192 },
		{ 5, 2612, 234, 372 },
		{ 6, 2601, 138, 313 },
		{ 7, 2608, 187, 323 },
		{ 8, 2602, 137, 376 },
	},
	LiberationofUndermine = {
		{ 1, 2639, 164, 228 },
		{ 2, 2640, 183, 141 },
		{ 3, 2641, 112, 142 },
		{ 4, 2642, 219, 339 },
		{ 5, 2653, 91,  335 },
		{ 6, 2644, 402, 226 },
		{ 7, 2645, 437, 287 },
		{ 8, 2646, 437, 374 },
	},
	ManaforgeOmegaA = {
		{ 1, 2684, 397, 227 },
		{ 5, 2688, 79,  296 },
		{ 6, 2747, 127, 235 },
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
	["OperationFloodgateA"] = { "OperationFloodgateA", "OperationFloodgateB" },
	["OperationFloodgateB"] = { "OperationFloodgateA", "OperationFloodgateB" },
	["ManaforgeOmegaA"] = { "ManaforgeOmegaA", "ManaforgeOmegaB" },
	["ManaforgeOmegaB"] = { "ManaforgeOmegaA", "ManaforgeOmegaB" },
}

db.SubZoneAssoc = {
	--	["BlackRookHoldA"] = 			BZ["Black Rook Hold"],
}

db.DropDownLayouts_Order = {
	[ATLAS_DDL_CONTINENT] = {
		ATLAS_DDL_CONTINENT_KHAZALGAR,
	},
	[ATLAS_DDL_LEVEL] = {
		ATLAS_DDL_LEVEL_70TO80,
	},
	[ATLAS_DDL_EXPANSION] = {
		ATLAS_DDL_EXPANSION_TWW,
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
		[ATLAS_DDL_CONTINENT_KHAZALGAR] = {
			"TheRookery",
			"TheStonevault",
			"PrioryoftheSacredFlame",
			"AraKaraCityofEchoes",
			"CinderbrewMeadery",
			"DarkflameCleft",
			"TheDawnbreaker",
			"CityofThreads",
			"OperationFloodgateA",
			"OperationFloodgateB",
			"EcoDomeAldani",
			"NerubarPalace",
			"LiberationofUndermine",
			"ManaforgeOmegaA",
			"ManaforgeOmegaB",
		}
	},
	[ATLAS_DDL_EXPANSION] = {
		[ATLAS_DDL_EXPANSION_TWW] = {
			"TheRookery",
			"TheStonevault",
			"PrioryoftheSacredFlame",
			"AraKaraCityofEchoes",
			"CinderbrewMeadery",
			"DarkflameCleft",
			"TheDawnbreaker",
			"CityofThreads",
			"OperationFloodgateA",
			"OperationFloodgateB",
			"EcoDomeAldani",
			"NerubarPalace",
			"LiberationofUndermine",
			"ManaforgeOmegaA",
			"ManaforgeOmegaB",
		},
	},
	[ATLAS_DDL_LEVEL] = {
		[ATLAS_DDL_LEVEL_70TO80] = {
			"TheRookery",
			"TheStonevault",
			"PrioryoftheSacredFlame",
			"AraKaraCityofEchoes",
			"CinderbrewMeadery",
			"DarkflameCleft",
			"TheDawnbreaker",
			"CityofThreads",
			"OperationFloodgateA",
			"OperationFloodgateB",
			"EcoDomeAldani",
			"NerubarPalace",
			"LiberationofUndermine",
			"ManaforgeOmegaA",
			"ManaforgeOmegaB",
		},
	},
	[ATLAS_DDL_PARTYSIZE] = {
		[ATLAS_DDL_PARTYSIZE_5] = {
			"TheRookery",
			"TheStonevault",
			"PrioryoftheSacredFlame",
			"AraKaraCityofEchoes",
			"CinderbrewMeadery",
			"DarkflameCleft",
			"TheDawnbreaker",
			"CityofThreads",
			"OperationFloodgateA",
			"OperationFloodgateB",
			"EcoDomeAldani",
		},
		[ATLAS_DDL_PARTYSIZE_10] = {
			"NerubarPalace",
			"LiberationofUndermine",
		},
		[ATLAS_DDL_PARTYSIZE_20TO40] = {
			"NerubarPalace",
			"LiberationofUndermine",
			"ManaforgeOmegaA",
			"ManaforgeOmegaB",
		},
	},
	[ATLAS_DDL_TYPE] = {
		[ATLAS_DDL_TYPE_INSTANCE] = {
			"TheRookery",
			"TheStonevault",
			"PrioryoftheSacredFlame",
			"AraKaraCityofEchoes",
			"CinderbrewMeadery",
			"DarkflameCleft",
			"TheDawnbreaker",
			"CityofThreads",
			"OperationFloodgateA",
			"OperationFloodgateB",
			"EcoDomeAldani",
			"NerubarPalace",
			"LiberationofUndermine",
			"ManaforgeOmegaA",
			"ManaforgeOmegaB",
		},
	},
}
