
-------------------------------------------------------------------------------
-- AddOn namespace.
-------------------------------------------------------------------------------
local FOLDER_NAME, private = ...

private.CONTINENT_ZONE_IDS = {
	[13] = { zonefilter = true, npcfilter = true, id = 2, zones = {14,15,17,18,21,22,23,25,26,27,32,36,37,47,48,49,50,51,52,56,76,84,87,94,95,201,203,204,205,210,217,241,425,465,469} }; --Eastern Kingdoms
	[12] = { zonefilter = true, npcfilter = true, id = 1, zones = {1,7,10,57,62,63,64,65,66,69,70,71,76,77,78,80,81,83,85,88,97,103,106,198,199,249,327,338} }; --Kalimdor
	[113] = { zonefilter = true, npcfilter = true, id = 4, zones = {114,115,116,117,118,119,120,121,126,127} }; --Northrend
	[424] = { zonefilter = true, npcfilter = true, id = 6, zones = {371,376,379,388,390,418,422,433,507,504,554}, current = { "all" } }; --Pandaria
	[1467] = { zonefilter = true, npcfilter = true, id = 3, zones = {100,102,104,105,107,108,109} }; --Outland
	[948] = { zonefilter = true, npcfilter = true, id = 5, zones = {207} }; --The Maelstrom
	[9998] = { zonefilter = true, npcfilter = true, zones = {407}, current = { "all" } }; --Darkmoon Island
	[9997] = { zonefilter = true, npcfilter = true, zones = {35,219,229,237,243,251,274,279,280,301,302,306,316,317,318} }; --Dungeons or scenarios
	[9996] = { zonefilter = true, npcfilter = true, zones = {366,508} }; --Raids
	[9995] = { zonefilter = false, npcfilter = true, zones = {0} }; --Unknown
}

private.SUBZONES_IDS = {
	[1] = {5}; --Durotar minimaps
	[7] = {462}; --Mulgore minimaps
	[27] = {29,31}; --Dun Morogh minimaps
	[32] = {33,35}; --Searing Gorge minimaps
	[37] = {40}; --Elwynn forest minimaps
	[52] = {55}; --Westfall minimaps
	[66] = {67}; --Desolace minimaps
	[71] = {72,73}; --Tanaris minimaps
	[78] = {79}; --Un'goro crater minimaps
	[237] = {238}; --Diremaul
	[251] = {252, 253, 254, 255}; --Blackrock spire
	[302] = {303,304,305,314}; --Scarlet Monastery
	[306] = {307,308,309,476,477,478,479}; --Scholomance
	[366] = {350,351,352,353,354,355,356,357,358,359,360,361,362,363,364,365}; --Karazhan (Outland raid)
	[371] = { 372, 373 }; --The jade forest (Pandaria)
	[379] = { 380, 381, 382, 384, 385, 434 }; --Kun lai summit (Pandaria)
	[388] = { 389 }; --Townlong steppes (Pandaria)
	[390] = {395}; --Valley of Eternal Blossom minimaps
	[504] = {505}; --Isle of Thunder
	[508] = {509,510,511,512,513,514,515}; --Throne of Thunder
	[554] = {555}; --Timeless Isle
}

private.ZONES_WITHOUT_VIGNETTE = {
	----[zoneId] = { artID };
	[77] = { 82 }; --Felwood
	[10] = { 11 }; --Northern barrens
	[69] = { 74 }; --Feralas
	[210] = { 215 }; --The cape of stranglethorn
	[199] = { 204 }; --Southern barrens
	[62] = { 67 }; --Darkshore
	[47] = { 52 }; --Duskwood
	[15] = { 16 }; --Badlands
	[83] = { 88 }; --Winterspring
	[17] = { 18 }; --Blasted lands
	[52] = { 57 }; --Westfall
	[27] = { 28 }; --Dun morogh
	[7] = { 8 }; --Mulgore
	[84] = { 89 }; --Stormwind city
	[57] = { 62 }; --Teldrassil
	[76] = { 81 }; --Azshara
	[25] = { 26 }; --Hillsbrad foothills
	[66] = { 71 }; --Desolace
	[78] = { 83 }; --Ungoro crater
	[1] = { 2 }; --Durotar
	[469] = { 481 }; --New tinkertown
	[18] = { 19 }; --Tirisfal glades
	[14] = { 15 }; --Arathi highlands
	[26] = { 27 }; --The hinterlands
	[37] = { 41 }; --Elwynn forest
	[81] = { 962,86 }; --Silithus
	[48] = { 53 }; --Loch modan
	[23] = { 24 }; --Eastern plaguelands
	[63] = { 68 }; --Ashenvale
	[65] = { 70 }; --Stonetalon mountains
	[70] = { 498,75 }; --Dustwallow marsh
	[21] = { 22 }; --Silverpine forest
	[64] = { 69 }; --Thousand needles
	[36] = { 37 }; --Burning steppes
	[49] = { 54 }; --Redridge mountains
	[50] = { 55 }; --Northern stranglethorn
	[56] = { 61 }; --Wetlands
	[32] = { 33 }; --Searing gorge
	[22] = { 23 }; --Western plaguelands
	[51] = { 56 }; --Swamp of sorrows
	[71] = { 76 }; --Tanaris
	[80] = { 85 }; --Moonglade
	[465] = { 477 }; --Deathknell
	[327] = { 339 }; --Ahn qiraj the fallen kingdom
	[104] = { 109 }; --Shadowmoon valley
	[109] = { 114 }; --Netherstorm
	[100] = { 105 }; --Hellfire peninsula
	[105] = { 110 }; --Blades edge mountains
	[106] = { 111 }; --Bloodmyst isle
	[102] = { 107 }; --Zangarmarsh
	[108] = { 113 }; --Terokkar forest
	[107] = { 112 }; --Nagrand
	[95] = { 100 }; --Ghostlands
	[94] = { 99 }; --Eversong woods
	[114] = { 119 }; --Borean tundra
	[115] = { 120 }; --Dragonblight
	[116] = { 121 }; --Grizzly hills
	[117] = { 122 }; --Howling fjord
	[118] = { 123 }; --Icecrown
	[119] = { 124 }; --Sholazar basin
	[120] = { 125 }; --The storm peaks
	[121] = { 126 }; --Zul drak
	[125] = { 130 }; --Dalaran
	[126] = { 131 }; --Dalaran (underbelly)
	[127] = { 132 }; --Crystalsong Forest
	[207] = { 212 }; --Deepholm
	[198] = { 203,227 }; --Mount hyjal
	[241] = { 338,252 }; --Twilight highlands
	[205] = { 210 }; --Shimmering expanse
	[204] = { 209 }; --Abyssal depths
	[338] = { 350 }; --Molten front
	[249] = { 260,289 }; --Uldum
	[201] = { 206 }; --Kelp thar forest
	[203] = { 208 }; --Vashj ir
	[73] = { 77 }; --The gaping chasm
	[72] = { 78 }; --The noxious lair
	[29] = { 31 }; --The grizzled den
	[5] = { 7 }; --Skull rock
	[31] = { 30 }; --Golbolar quarry
	[79] = { 84 }; --The slithering scar
	[40] = { 42 }; --Jasperlode mine
	[280] = { 291 }; --Maraudon
	[67] = { 72 }; --Maraudon out1
	[316] = { 328 }; --Shadowfang keep7
	[55] = { 60 }; --Deadmines out
	[229] = { 240 }; --Gnomeregan
	[237] = { 248 }; --Dire maul3
	[238] = { 249 }; --Dire maul4
	[219] = { 230 }; --Zulfarrak
	[251] = { 262 }; --Blackrock spire2
	[252] = { 263 }; --Blackrock spire3
	[253] = { 264 }; --Blackrock spire4
	[255] = { 266 }; --Blackrock spire6
	[279] = { 290 }; --Wailing caverns
	[11] = { 12 }; --Wailing caverns
	[318] = { 330 }; --Stratholme undead
	[317] = { 329 }; --Stratholme human
	[243] = { 254 }; --Blackrock depths2
	[33] = { 34 }; --Searing gorge2
	[35] = { 36 }; --Searing gorge3
	[301] = { 313 }; --Razorfen kraul
	[351] = { 363 }; --Karazhan
	[274] = { 285 }; --Old hillsbrad foothills
	[462] = { 474 }; --Camp Narache
	[425] = { 437 }; --Northshire
	[371] = { 383 }; --The jade forest (Pandaria)
	[376] = { 388 }; --Valley of the Four Winds (Pandaria)
	[379] = { 391 }; --Kun lai summit (Pandaria)
	[388] = { 400 }; --Townlong steppes (Pandaria)
	[390] = { 1972,402 }; --Vale of Eternal Blossoms (Pandaria)
	[418] = { 430,499 }; --Krasarang Wilds (Pandaria)
	[422] = { 434 }; --Dread Wastes (Pandaria)
	[433] = { 445 }; --The Veiled Stair (Pandaria)
	[507] = { 524 }; --Isle of Gigants (Pandaria)
	[504] = { 521 }; --Isle of Thunder (Pandaria)
	[554] = { 571 }; --Timeless Isle (Pandaria)
}

private.RESETABLE_KILLS_ZONE_IDS = {
	----[zoneId] = { artID or "all"};
}

private.PERMANENT_KILLS_ZONE_IDS = {}

-- Monster emotes
private.MONSTER_EMOTE = {}