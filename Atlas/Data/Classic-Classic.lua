--[[

	Atlas, a World of Warcraft instance map browser
	Copyright 2011 ~ 2023 - Arith Hsu, Atlas Team <atlas.addon at gmail dot com>

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

private.addon_name         = "Atlas_ClassicWoW"
private.module_name        = "ClassicWoW"

local BZ                   = Atlas_GetLocaleLibBabble("LibBabble-SubZone-3.0")
local BF                   = Atlas_GetLocaleLibBabble("LibBabble-Faction-3.0")
local L                    = LibStub("AceLocale-3.0"):GetLocale(private.addon_name)
local ALC                  = LibStub("AceLocale-3.0"):GetLocale("Atlas")
local ALIL                 = Atlas_IngameLocales
local Atlas                = LibStub("AceAddon-3.0"):GetAddon("Atlas")
local addon                = Atlas:NewModule(private.module_name)

local function Atlas_GetBossName(bossname, encounterID, creatureIndex)
	return Atlas:GetBossName(bossname, encounterID, creatureIndex, private.module_name)
end

local db = {}
addon.db = db

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
	--************************************************
	-- Eastern Kingdoms Instances (Classic)
	--************************************************
	BlackrockMountainEnt = {
		ZoneName = { BZ["Blackrock Mountain"]..ALC["L-Parenthesis"]..ALC["Entrance"]..ALC["R-Parenthesis"] },
		Location = { BZ["Searing Gorge"]..ALC["Slash"]..BZ["Burning Steppes"] },
		MinLevel = "47",
		PlayerLimit = { 5, 10, 25, 40 },
		Acronym = L["BRM"],
		Module = "Atlas_ClassicWoW",
		{ BLUE.." A) "..BZ["Searing Gorge"],                                                                                                                     10001 },
		{ BLUE.." B) "..BZ["Burning Steppes"],                                                                                                                   10002 },
		{ BLUE.." C) "..BZ["Blackrock Depths"],                                                                                                                  10003 },
		{ BLUE.." D) "..BZ["Lower Blackrock Spire"],                                                                                                             10004 },
		{ BLUE..INDENT..BZ["Upper Blackrock Spire"] },
		{ GREN..INDENT..L["Bodley"]..ALC["L-Parenthesis"]..ALC["Ghost"]..ALC["R-Parenthesis"] },
		{ BLUE.." E) "..BZ["The Molten Core"],                                                                                                                   10005 },
		{ GREN..INDENT..L["Lothos Riftwaker"] },
		{ BLUE.." F) "..BZ["Blackwing Lair"],                                                                                                                    10006 },
		{ GREN..INDENT..L["Orb of Command"] },
		{ BLUE.." G) "..BZ["Blackrock Caverns"],                                                                                                                 10007 },
		{ ORNG.." 1) "..L["Scarshield Quartermaster <Scarshield Legion>"]..ALC["L-Parenthesis"]..ALC["Upper"]..ALC["R-Parenthesis"],                             10008 },
		{ ORNG.." 2) "..L["The Behemoth"]..ALC["L-Parenthesis"]..ALC["Rare"]..ALC["Comma"]..ALC["Wanders"]..ALC["R-Parenthesis"],                                10009 },
		{ ORNG.." 3) "..Atlas_GetBossName("Overmaster Pyron")..ALC["L-Parenthesis"]..ALC["Wanders"]..ALC["R-Parenthesis"],                                       10010 },
		{ GREN.." 1') "..L["Meeting Stone"]..ALC["L-Parenthesis"]..BZ["Blackrock Depths"]..ALC["R-Parenthesis"],                                                 10011 },
		{ GREN.." 2') "..L["Meeting Stone"]..ALC["L-Parenthesis"]..BZ["Lower Blackrock Spire"]..ALC["Comma"]..BZ["Upper Blackrock Spire"]..ALC["R-Parenthesis"], 10012 },
	},
	BlackrockDepths = {
		ZoneName = { BZ["Blackrock Mountain"]..ALC["Colon"]..BZ["Blackrock Depths"] },
		Location = { BZ["Searing Gorge"]..ALC["Slash"]..BZ["Burning Steppes"] },
		MinLevel = "47",
		PlayerLimit = { 5 },
		Acronym = L["BRD"],
		WorldMapID = 242,
		JournalInstanceID = 228,
		Module = "Atlas_ClassicWoW",
		{ ORNG..ALC["Key"]..ALC["Colon"]..ALIL["Relic Coffer Key"] },
		{ ORNG..ALC["Key"]..ALC["Colon"]..ALIL["Dark Keeper Key"] },
		{ BLUE.." A) "..ALC["Entrance"],                                                                                                                   10001 },
		{ BLUE.." B-D) "..ALC["Connection"],                                                                                                               10002 },
		{ BLUE.." E) "..BZ["The Molten Core"],                                                                                                             10003 },
		{ WHIT.." 1) "..Atlas_GetBossName("High Interrogator Gerstahn", 369),                                                                              369 },
		{ WHIT.." 2) "..Atlas_GetBossName("Lord Roccor", 370)..ALC["L-Parenthesis"]..ALC["Wanders"]..ALC["R-Parenthesis"],                                 370 },
		{ WHIT.." 3) "..Atlas_GetBossName("Houndmaster Grebmar", 371),                                                                                     371 },
		{ WHIT.." 4) "..Atlas_GetBossName("Bael'Gar", 377),                                                                                                377 },
		{ WHIT.." 5) "..Atlas_GetBossName("Lord Incendius", 374),                                                                                          374 },
		{ GREN..INDENT..L["The Black Anvil"] },
		{ WHIT.." 6) "..Atlas_GetBossName("Fineous Darkvire", 376)..ALC["L-Parenthesis"]..ALC["Wanders"]..ALC["R-Parenthesis"],                            376 },
		{ WHIT.." 7) "..L["The Vault"] },
		{ WHIT..INDENT..Atlas_GetBossName("Warder Stilgiss", 375),                                                                                         375 },
		{ WHIT..INDENT..Atlas_GetBossName("Verek") },
		{ WHIT..INDENT..L["Watchman Doomgrip"] },
		{ WHIT.." 8) "..Atlas_GetBossName("Pyromancer Loregrain", 373),                                                                                    373 },
		{ WHIT.." 9) "..Atlas_GetBossName("Ring of Law", 372),                                                                                             372 },
		{ ORNG..INDENT..Atlas_GetBossName("High Justice Grimstone", 372, 1),                                                                               372 },
		{ WHIT..INDENT..Atlas_GetBossName("Anub'shiah")..ALC["L-Parenthesis"]..ALC["Random"]..ALC["R-Parenthesis"] },
		{ WHIT..INDENT..Atlas_GetBossName("Eviscerator")..ALC["L-Parenthesis"]..ALC["Random"]..ALC["R-Parenthesis"] },
		{ WHIT..INDENT..Atlas_GetBossName("Gorosh the Dervish")..ALC["L-Parenthesis"]..ALC["Random"]..ALC["R-Parenthesis"] },
		{ WHIT..INDENT..Atlas_GetBossName("Grizzle")..ALC["L-Parenthesis"]..ALC["Random"]..ALC["R-Parenthesis"] },
		{ WHIT..INDENT..Atlas_GetBossName("Hedrum the Creeper")..ALC["L-Parenthesis"]..ALC["Random"]..ALC["R-Parenthesis"] },
		{ WHIT..INDENT..Atlas_GetBossName("Ok'thor the Breaker")..ALC["L-Parenthesis"]..ALC["Random"]..ALC["R-Parenthesis"] },
		{ GREN..INDENT..L["Elder Morndeep"]..ALC["L-Parenthesis"]..ALC["Lunar Festival"]..ALC["R-Parenthesis"] },
		{ WHIT.."10) "..Atlas_GetBossName("General Angerforge", 378),                                                                                      378 },
		{ WHIT.."11) "..Atlas_GetBossName("Golem Lord Argelmach", 379),                                                                                    379 },
		{ GREN..INDENT..L["Schematic: Field Repair Bot 74A"] },
		{ GREN..INDENT..ALC["Blacksmithing Plans"] },
		{ WHIT.."12) "..Atlas_GetBossName("Hurley Blackbreath", 380),                                                                                      380 },
		{ ORNG..INDENT..Atlas_GetBossName("Coren Direbrew")..ALC["L-Parenthesis"]..ALC["Brewfest"]..ALC["R-Parenthesis"] },
		{ WHIT.."13) "..Atlas_GetBossName("Ribbly Screwspigot", 382),                                                                                      382 },
		{ WHIT.."14) "..Atlas_GetBossName("Phalanx", 381),                                                                                                 381 },
		{ WHIT..INDENT..Atlas_GetBossName("Plugger Spazzring", 383),                                                                                       383 },
		{ GREN..INDENT..L["Private Rocknot"] },
		{ GREN..INDENT..L["Mistress Nagmara"] },
		{ WHIT.."15) "..Atlas_GetBossName("Ambassador Flamelash", 384),                                                                                    384 },
		{ WHIT.."16) "..Atlas_GetBossName("The Seven", 385),                                                                                               385 },
		{ WHIT.."17) "..Atlas_GetBossName("Magmus", 386),                                                                                                  386 },
		{ WHIT.."18) "..Atlas_GetBossName("Emperor Dagran Thaurissan", 387),                                                                               387 },
		{ WHIT..INDENT..Atlas_GetBossName("Princess Moira Bronzebeard") },
		{ WHIT..INDENT..Atlas_GetBossName("High Priestess of Thaurissan") },
		{ ORNG.." 1) "..Atlas_GetBossName("Panzor the Invincible")..ALC["L-Parenthesis"]..ALC["Rare"]..ALC["Comma"]..ALC["Wanders"]..ALC["R-Parenthesis"], 10004 },
		{ GREN.." 1') "..L["Jalinda Sprig <Morgan's Militia>"]..ALC["L-Parenthesis"]..FACTION_ALLIANCE..ALC["R-Parenthesis"],                              10005 },
		{ GREN..INDENT..L["Oralius <Morgan's Militia>"]..ALC["L-Parenthesis"]..FACTION_ALLIANCE..ALC["R-Parenthesis"] },
		{ GREN..INDENT..L["Thal'trak Proudtusk <Kargath Expeditionary Force>"]..ALC["L-Parenthesis"]..FACTION_HORDE..ALC["R-Parenthesis"] },
		{ GREN..INDENT..L["Galamav the Marksman <Kargath Expeditionary Force>"]..ALC["L-Parenthesis"]..FACTION_HORDE..ALC["R-Parenthesis"] },
		{ GREN..INDENT..L["Maxwort Uberglint"] },
		{ GREN..INDENT..L["Tinkee Steamboil"] },
		{ GREN..INDENT..L["Yuka Screwspigot <Engineering Supplies>"] },
		{ GREN..INDENT..L["Abandonded Mole Machine"] },
		{ GREN.." 2') "..L["Kevin Dawson <Morgan's Militia>"]..ALC["L-Parenthesis"]..FACTION_ALLIANCE..ALC["R-Parenthesis"],                               10006 },
		{ GREN..INDENT..L["Lexlort <Kargath Expeditionary Force>"]..ALC["L-Parenthesis"]..FACTION_HORDE..ALC["R-Parenthesis"] },
		{ GREN.." 3') "..L["Prospector Seymour <Morgan's Militia>"]..ALC["L-Parenthesis"]..FACTION_ALLIANCE..ALC["R-Parenthesis"],                         10007 },
		{ GREN..INDENT..L["Razal'blade <Kargath Expeditionary Force>"]..ALC["L-Parenthesis"]..FACTION_HORDE..ALC["R-Parenthesis"] },
		{ GREN.." 4') "..L["Abandonded Mole Machine"],                                                                                                     10008 },
		{ GREN.." 5') "..L["The Shadowforge Lock"],                                                                                                        10009 },
		{ GREN.." 6') "..ALC["Blacksmithing Plans"],                                                                                                       10010 },
		{ GREN.." 7') "..L["Mayara Brightwing <Morgan's Militia>"]..ALC["L-Parenthesis"]..FACTION_ALLIANCE..ALC["R-Parenthesis"],                          10011 },
		{ GREN..INDENT..L["Hierophant Theodora Mulvadania <Kargath Expeditionary Force>"]..ALC["L-Parenthesis"]..FACTION_HORDE..ALC["R-Parenthesis"] },
		{ GREN.." 8') "..L["Lokhtos Darkbargainer <The Thorium Brotherhood>"],                                                                             10012 },
		{ GREN.." 9') "..L["Abandonded Mole Machine"],                                                                                                     10013 },
		{ GREN.."10') "..L["Mountaineer Orfus <Morgan's Militia>"]..ALC["L-Parenthesis"]..FACTION_ALLIANCE..ALC["R-Parenthesis"],                          10014 },
		{ GREN..INDENT..L["Thunderheart <Kargath Expeditionary Force>"]..ALC["L-Parenthesis"]..FACTION_HORDE..ALC["R-Parenthesis"] },
		{ GREN.."11') "..L["Marshal Maxwell <Morgan's Militia>"]..ALC["L-Parenthesis"]..FACTION_ALLIANCE..ALC["R-Parenthesis"],                            10015 },
		{ GREN..INDENT..L["Warlord Goretooth <Kargath Expeditionary Force>"]..ALC["L-Parenthesis"]..FACTION_HORDE..ALC["R-Parenthesis"] },
		{ GREN.."12') "..L["The Black Forge"],                                                                                                             10016 },
		{ GREN.."13') "..L["Core Fragment"],                                                                                                               10017 },
		{ GREN.."14') "..L["Shadowforge Brazier"],                                                                                                         10018 },
	},
	BlackwingLair = {
		ZoneName = { BZ["Blackrock Mountain"]..ALC["Colon"]..BZ["Blackwing Lair"] },
		Location = { BZ["Searing Gorge"]..ALC["Slash"]..BZ["Burning Steppes"] },
		DungeonID = 50,
		PlayerLimit = { 40 },
		WorldMapID = 287,
		-- JournalInstanceID = 742,
		Acronym = L["BWL"],
		Module = "Atlas_ClassicWoW",
		{ ORNG..ALC["Attunement Required"] },
		{ BLUE.." A) "..ALC["Entrance"],                             10001 },
		{ BLUE.." B-C) "..ALC["Connection"],                         10002 },
		{ WHIT.." 1) "..Atlas_GetBossName("Grethok the Controller"), 10003 },
		{ GREN..INDENT..L["Orb of Domination"] },
		{ WHIT.." 2) "..Atlas_GetBossName("Razorgore the Untamed") },
		{ WHIT.." 3) "..Atlas_GetBossName("Vaelastrasz the Corrupt") },
		{ WHIT.." 4) "..Atlas_GetBossName("Broodlord Lashlayer") },
		{ WHIT.." 5) "..Atlas_GetBossName("Firemaw") },
		{ WHIT.." 6) "..Atlas_GetBossName("Ebonroc") },
		{ WHIT..INDENT..L["Master Elemental Shaper Krixix"] },
		{ WHIT.." 7) "..Atlas_GetBossName("Flamegor") },
		{ WHIT.." 8) "..Atlas_GetBossName("Chromaggus") },
		{ WHIT.." 9) "..Atlas_GetBossName("Nefarian") },
	},
	GnomereganEnt = {
		ZoneName = { BZ["Gnomeregan"]..ALC["L-Parenthesis"]..ALC["Entrance"]..ALC["R-Parenthesis"] },
		Location = { BZ["Dun Morogh"] },
		DungeonID = 14,
		Acronym = L["Gnome"],
		WorldMapID = 226,
		JournalInstanceID = 231,
		Module = "Atlas_ClassicWoW",
		NextMap = "Gnomeregan",
		{ BLUE.." A) "..ALC["Entrance"],                                                            10001 },
		{ GREN..INDENT..ALC["Meeting Stone"] },
		{ BLUE.." B) "..BZ["Gnomeregan"]..ALC["L-Parenthesis"]..ALC["Front"]..ALC["R-Parenthesis"], 10002 },
		{ BLUE.." C) "..BZ["Gnomeregan"]..ALC["L-Parenthesis"]..ALC["Back"]..ALC["R-Parenthesis"],  10003 },
		{ GREN.." 1') "..ALC["Elevator"],                                                           10004 },
		{ GREN..INDENT..L["Torben Zapblast <Teleportation Specialist>"] },
		{ GREN.." 2') "..L["Mail Box"],                                                             10005 },
	},
	Gnomeregan = {
		ZoneName = { BZ["Gnomeregan"] },
		Location = { BZ["Dun Morogh"] },
		DungeonID = 14,
		Acronym = L["Gnome"],
		WorldMapID = 226,
		JournalInstanceID = 231,
		Module = "Atlas_ClassicWoW",
		PrevMap = "GnomereganEnt",
		{ BLUE.." A) "..ALC["Entrance"]..ALC["L-Parenthesis"]..ALC["Front"]..ALC["R-Parenthesis"],                             10001 },
		{ BLUE.." B) "..ALC["Entrance"]..ALC["L-Parenthesis"]..ALC["Back"]..ALC["R-Parenthesis"],                              10002 },
		{ BLUE.." C-F) "..ALC["Connection"],                                                                                   10003 },
		{ WHIT.." 1) "..Atlas_GetBossName("Grubbis", 419),                                                                     419 },
		{ WHIT..INDENT..L["Chomper"] },
		{ GREN..INDENT..L["Blastmaster Emi Shortfuse"] },
		{ WHIT.." 2) "..Atlas_GetBossName("Viscous Fallout", 420)..ALC["L-Parenthesis"]..ALC["Wanders"]..ALC["R-Parenthesis"], 420 },
		{ WHIT.." 3) "..Atlas_GetBossName("Electrocutioner 6000", 421),                                                        421 },
		{ WHIT.." 4) "..Atlas_GetBossName("Crowd Pummeler 9-60", 418),                                                         418 },
		{ WHIT.." 5) "..Atlas_GetBossName("Mekgineer Thermaplugg", 422),                                                       422 },
		{ GREN.." 1') "..L["Murd Doc <S.A.F.E.>"]..ALC["L-Parenthesis"]..FACTION_ALLIANCE..ALC["R-Parenthesis"],               10004 },
		{ GREN.." 2') "..BZ["The Clean Zone"],                                                                                 10005 },
		{ GREN..INDENT..L["Tink Sprocketwhistle <Engineering Supplies>"] },
		{ GREN..INDENT..L["The Sparklematic 5200"] },
		{ GREN..INDENT..ALC["Mail Box"] },
		{ GREN.." 3') "..L["B.E Barechus <S.A.F.E.>"]..ALC["L-Parenthesis"]..FACTION_ALLIANCE..ALC["R-Parenthesis"],           10006 },
		{ GREN.." 4') "..L["Face <S.A.F.E.>"]..ALC["L-Parenthesis"]..FACTION_ALLIANCE..ALC["R-Parenthesis"],                   10007 },
		{ GREN.." 5') "..L["Hann Ibal <S.A.F.E.>"]..ALC["L-Parenthesis"]..FACTION_ALLIANCE..ALC["R-Parenthesis"],              10008 },
	},
	LowerBlackrockSpire = {
		ZoneName = { BZ["Blackrock Mountain"]..ALC["Colon"]..BZ["Lower Blackrock Spire"] },
		Location = { BZ["Searing Gorge"]..ALC["Slash"]..BZ["Burning Steppes"] },
		DungeonID = 32,
		Acronym = L["LBRS"],
		WorldMapID = 252,
		JournalInstanceID = 229,
		Module = "Atlas_ClassicWoW",
		{ BLUE.." A) "..ALC["Entrance"],                                                                                                             10001 },
		{ BLUE.." B) "..BZ["Blackrock Mountain"],                                                                                                    10002 },
		{ BLUE.." C) "..BZ["Upper Blackrock Spire"],                                                                                                 10003 },
		{ BLUE.." D-G) "..ALC["Connection"],                                                                                                         10004 },
		{ WHIT.." 1) "..Atlas_GetBossName("Highlord Omokk", 388),                                                                                    388 },
		{ WHIT.." 2) "..Atlas_GetBossName("Shadow Hunter Vosh'gajin", 389),                                                                          389 },
		{ WHIT.." 3) "..Atlas_GetBossName("War Master Voone", 390),                                                                                  390 },
		{ WHIT.." 4) "..Atlas_GetBossName("Mother Smolderweb", 391),                                                                                 391 },
		{ WHIT.." 5) "..Atlas_GetBossName("Urok Doomhowl", 392)..ALC["L-Parenthesis"]..ALC["Summon"]..ALC["R-Parenthesis"],                          392 },
		{ GREN..INDENT..L["Urok's Tribute Pile"] },
		{ WHIT.." 6) "..Atlas_GetBossName("Quartermaster Zigris", 393),                                                                              393 },
		{ WHIT.." 7) "..Atlas_GetBossName("Halycon", 394),                                                                                           394 },
		{ WHIT..INDENT..Atlas_GetBossName("Gizrul the Slavener", 395),                                                                               395 },
		{ WHIT.." 8) "..Atlas_GetBossName("Overlord Wyrmthalak", 396),                                                                               396 },
		{ ORNG.." 1) "..Atlas_GetBossName("Burning Felguard")..ALC["L-Parenthesis"]..ALC["Rare"]..ALC["Comma"]..ALC["Summon"]..ALC["R-Parenthesis"], 10005 },
		{ ORNG.." 2) "..Atlas_GetBossName("Spirestone Butcher")..ALC["L-Parenthesis"]..ALC["Rare"]..ALC["R-Parenthesis"],                            10006 },
		{ ORNG.." 3) "..Atlas_GetBossName("Spirestone Battle Lord")..ALC["L-Parenthesis"]..ALC["Rare"]..ALC["R-Parenthesis"],                        10007 },
		{ ORNG..INDENT..Atlas_GetBossName("Spirestone Lord Magus")..ALC["L-Parenthesis"]..ALC["Rare"]..ALC["R-Parenthesis"] },
		{ ORNG.." 4) "..Atlas_GetBossName("Bannok Grimaxe")..ALC["L-Parenthesis"]..ALC["Rare"]..ALC["R-Parenthesis"],                                10008 },
		{ ORNG.." 5) "..Atlas_GetBossName("Crystal Fang")..ALC["L-Parenthesis"]..ALC["Rare"]..ALC["R-Parenthesis"],                                  10009 },
		{ ORNG.." 6) "..Atlas_GetBossName("Ghok Bashguud")..ALC["L-Parenthesis"]..ALC["Rare"]..ALC["R-Parenthesis"],                                 10010 },
		{ GREN.." 1') "..L["Acride <Scarshield Legion>"],                                                                                            10011 },
		{ GREN.." 2') "..L["Elder Stonefort"]..ALC["L-Parenthesis"]..ALC["Lunar Festival"]..ALC["R-Parenthesis"],                                    10012 },
		{ GREN.." 3') "..L["Roughshod Pike"],                                                                                                        10013 },
	},
	MoltenCore = {
		ZoneName = { BZ["Blackrock Mountain"]..ALC["Colon"]..BZ["The Molten Core"] },
		Location = { BZ["Searing Gorge"]..ALC["Slash"]..BZ["Burning Steppes"] },
		DungeonID = 48,
		Acronym = L["MC"],
		PlayerLimit = { 40 },
		WorldMapID = 232,
		-- JournalInstanceID = 741,
		Module = "Atlas_ClassicWoW",
		{ ORNG..ALC["Attunement Required"] },
		{ ORNG..REPUTATION..ALC["Colon"]..BF["Hydraxian Waterlords"] },
		{ BLUE.." A) "..ALC["Entrance"],                              10001 },
		{ WHIT.." 1) "..Atlas_GetBossName("Lucifron") },
		{ WHIT.." 2) "..Atlas_GetBossName("Magmadar") },
		{ WHIT.." 3) "..Atlas_GetBossName("Gehennas") },
		{ WHIT.." 4) "..Atlas_GetBossName("Garr") },
		{ WHIT.." 5) "..Atlas_GetBossName("Shazzrah") },
		{ WHIT.." 6) "..Atlas_GetBossName("Baron Geddon") },
		{ WHIT.." 7) "..Atlas_GetBossName("Golemagg the Incinerator") },
		{ WHIT.." 8) "..Atlas_GetBossName("Sulfuron Harbinger") },
		{ WHIT.." 9) "..Atlas_GetBossName("Majordomo Executus") },
		{ WHIT.."10) "..Atlas_GetBossName("Ragnaros") },
	},
	ScarletMonasteryEnt = {
		ZoneName = { BZ["Scarlet Monastery"]..ALC["L-Parenthesis"]..ALC["Entrance"]..ALC["R-Parenthesis"] },
		Location = { BZ["Tirisfal Glades"] },
		MinLevel = "26",
		PlayerLimit = { 5 },
		Acronym = L["SM"],
		Module = "Atlas_ClassicWoW",
		PrevMap = "ScarletMonastery",
		NextMap = "ScarletHalls",
		{ BLUE.." A) "..ALC["Entrance"],         10001 },
		{ BLUE.." B) "..BZ["Scarlet Monastery"], 10002 },
		{ BLUE.." C) "..BZ["Scarlet Halls"],     10003 },
		{ "" },
		{ LBLU..ACHIEVEMENTS..ALC["Colon"] },
	},
	ScarletHalls = {
		ZoneName = { BZ["Scarlet Monastery"]..ALC["Colon"]..BZ["Scarlet Halls"] },
		Location = { BZ["Tirisfal Glades"] },
		DungeonID = 163,
		DungeonHeroicID = 473,
		Acronym = L["Halls"],
		WorldMapID = 435,
		JournalInstanceID = 311,
		Module = "Atlas_ClassicWoW",
		PrevMap = "ScarletMonasteryEnt",
		NextMap = "ScarletMonastery",
		{ BLUE.." A) "..ALC["Entrance"],                               10001 },
		{ WHIT.." 1) "..L["Commander Lindon"],                         10002 },
		{ WHIT.." 2) "..Atlas_GetBossName("Houndmaster Braun", 660),   660 },
		{ WHIT.." 3) "..Atlas_GetBossName("Armsmaster Harlan", 654),   654 },
		{ WHIT.." 4) "..Atlas_GetBossName("Flameweaver Koegler", 656), 656 },
		{ GREN.." 1') "..L["Hooded Crusader"],                         10003 },
		{ INDENT..GREN..L["Bucket of Meaty Dog Food"] },
		{ GREN.." 2') "..L["Reinforced Archery Target"],               10004 },
		{ GREN.." 3') "..L["Bucket of Meaty Dog Food"],                10005 },
		{ "" },
		{ LBLU..ACHIEVEMENTS..ALC["Colon"] },
	},
	ScarletMonastery = {
		ZoneName = { BZ["Scarlet Monastery"]..ALC["Colon"]..BZ["Scarlet Monastery"] },
		Location = { BZ["Tirisfal Glades"] },
		DungeonID = 164,
		DungeonHeroicID = 474,
		Acronym = L["SM"],
		WorldMapID = 436,
		JournalInstanceID = 316,
		Module = "Atlas_ClassicWoW",
		PrevMap = "ScarletHalls",
		NextMap = "ScarletMonasteryEnt",
		{ BLUE.." A) "..ALC["Entrance"],                                                                                         10001 },
		{ GREN.." 1') "..L["Hooded Crusader"],                                                                                   10002 },
		{ WHIT.." 1) "..Atlas_GetBossName("Thalnos the Soulrender", 688),                                                        688 },
		{ WHIT.." 2) "..Atlas_GetBossName("Brother Korloff", 671),                                                               671 },
		{ WHIT.." 3) "..Atlas_GetBossName("High Inquisitor Whitemane", 674),                                                     674 },
		{ WHIT..INDENT..Atlas_GetBossName("Commander Durand", 674, 2),                                                           674 },
		{ ORNG.." 1) "..Atlas_GetBossName("Headless Horseman")..ALC["L-Parenthesis"]..ALC["Hallow's End"]..ALC["R-Parenthesis"], 10003 },
		{ "" },
		{ LBLU..ACHIEVEMENTS..ALC["Colon"] },
	},
	Scholomance = {
		ZoneName = { BZ["Scholomance"] },
		Location = { BZ["Western Plaguelands"] },
		DungeonID = 2,
		DungeonHeroicID = 472,
		Acronym = L["Scholo"],
		WorldMapID = 476,
		JournalInstanceID = 246,
		Module = "Atlas_ClassicWoW",
		{ BLUE.." A) "..ALC["Entrance"],                                     10001 },
		{ BLUE.." B-D) "..ALC["Connection"],                                 10002 },
		{ WHIT.." 1) "..Atlas_GetBossName("Instructor Chillheart", 659),     659 },
		{ WHIT..INDENT..L["Instructor Chillheart's Phylactery"] },
		{ WHIT.." 2) "..Atlas_GetBossName("Jandice Barov", 663),             663 },
		{ WHIT.." 3) "..Atlas_GetBossName("Rattlegore", 665),                665 },
		{ WHIT.." 4) "..Atlas_GetBossName("Lilian Voss", 666),               666 },
		{ WHIT.." 5) "..L["Professor Slate"],                                10003 },
		{ GREN..INDENT..L["Polyformic Acid Potion"] },
		{ WHIT.." 6) "..Atlas_GetBossName("Darkmaster Gandling", 684),       684 },
		{ GREN.." 1') "..L["Talking Skull"],                                 10004 },
		{ GREN.." 2') "..L["In the Shadow of the Light"],                    10005 },
		{ GREN.." 3') "..L["Kel'Thuzad's Deep Knowledge"],                   10006 },
		{ GREN.." 4') "..L["Forbidden Rites and other Rituals Necromantic"], 10007 },
		{ GREN.." 5') "..L["Coffer of Forgotten Souls"],                     10008 },
		{ GREN.." 6') "..L["The Dark Grimoire"],                             10009 },
		{ "" },
		{ LBLU..ACHIEVEMENTS..ALC["Colon"] },
	},
	ShadowfangKeep = {
		ZoneName = { BZ["Shadowfang Keep"] },
		Location = { BZ["Silverpine Forest"] },
		DungeonID = 8,
		DungeonHeroicID = 327,
		Acronym = L["SFK"],
		WorldMapID = 310,
		JournalInstanceID = 64,
		Module = "Atlas_ClassicWoW",
		{ BLUE.." A) "..ALC["Entrance"],                                                                                                                   10001 },
		{ BLUE.." B-C) "..ALC["Connection"],                                                                                                               10002 },
		{ WHIT.." 1) "..Atlas_GetBossName("Baron Ashbury", 96),                                                                                            96 },
		{ WHIT.." 2) "..Atlas_GetBossName("Baron Silverlaine", 97),                                                                                        97 },
		{ WHIT..INDENT..Atlas_GetBossName("Odo the Blindwatcher")..ALC["L-Parenthesis"]..ALC["Random"]..ALC["Comma"]..ALC["Summon"]..ALC["R-Parenthesis"] },
		{ WHIT..INDENT..Atlas_GetBossName("Razorclaw the Butcher")..ALC["L-Parenthesis"]..ALC["Random"]..ALC["Comma"]..ALC["Summon"]..ALC["R-Parenthesis"] },
		{ WHIT..INDENT..Atlas_GetBossName("Rethilgore")..ALC["L-Parenthesis"]..ALC["Random"]..ALC["Comma"]..ALC["Summon"]..ALC["R-Parenthesis"] },
		{ WHIT..INDENT..Atlas_GetBossName("Wolf Master Nandos")..ALC["L-Parenthesis"]..ALC["Random"]..ALC["Comma"]..ALC["Summon"]..ALC["R-Parenthesis"] },
		{ WHIT.." 3) "..Atlas_GetBossName("Commander Springvale", 98),                                                                                     98 },
		{ WHIT.." 4) "..Atlas_GetBossName("Lord Walden", 99),                                                                                              99 },
		{ WHIT.." 5) "..Atlas_GetBossName("Lord Godfrey", 100),                                                                                            100 },
		{ ORNG.." 1) "..L["Apothecary Trio"]..ALC["L-Parenthesis"]..ALC["Love is in the Air"]..ALC["R-Parenthesis"],                                       10003 },
		{ ORNG..INDENT..L["Apothecary Hummel <Crown Chemical Co.>"] },
		{ ORNG..INDENT..L["Apothecary Baxter <Crown Chemical Co.>"] },
		{ ORNG..INDENT..L["Apothecary Frye <Crown Chemical Co.>"] },
		{ GREN.." 1') "..L["Packleader Ivar Bloodfang"]..ALC["L-Parenthesis"]..FACTION_ALLIANCE..ALC["R-Parenthesis"],                                     10004 },
		{ GREN..INDENT..L["Deathstalker Commander Belmont"]..ALC["L-Parenthesis"]..FACTION_HORDE..ALC["R-Parenthesis"] },
		{ GREN.." 2') "..L["Haunted Stable Hand"]..ALC["L-Parenthesis"]..ALC["Teleporter"]..ALC["R-Parenthesis"],                                          10005 },
		{ GREN.." 3') "..L["Investigator Fezzen Brasstacks"]..ALC["L-Parenthesis"]..ALC["Love is in the Air"]..ALC["R-Parenthesis"],                       10006 },
		{ "" },
		{ LBLU..ACHIEVEMENTS..ALC["Colon"] },
		{ "Pardon Denied",                                                                                                                                 "ac=5503" },
		{ "To the Ground!",                                                                                                                                "ac=5504" },
		{ "Bullet Time",                                                                                                                                   "ac=5505" },
		{ "Shadowfang Keep",                                                                                                                               "ac=631" },
		{ "Heroic: Shadowfang Keep",                                                                                                                       "ac=5093" },
		{ "Heroic: Shadowfang Keep Guild Run",                                                                                                             "ac=5142" },
	},
	StratholmeCrusader = {
		ZoneName = { BZ["Stratholme"]..ALC["Hyphen"]..BZ["Crusaders' Square"] },
		Location = { BZ["Eastern Plaguelands"] },
		DungeonID = 40,
		Acronym = L["Strat"],
		WorldMapID = 317,
		DungeonLevel = 1,
		JournalInstanceID = 236,
		Module = "Atlas_ClassicWoW",
		NextMap = "StratholmeGauntlet",
		{ BLUE.." A) "..ALC["Entrance"]..ALC["L-Parenthesis"]..ALC["Front"]..ALC["R-Parenthesis"],                         10001 },
		{ GREN..INDENT..L["Crusade Commander Eligor Dawnbringer <Brotherhood of the Light>"] },
		{ GREN..INDENT..L["Master Craftsman Wilhelm <Brotherhood of the Light>"] },
		{ GREN..INDENT..L["Packmaster Stonebruiser <Brotherhood of the Light>"] },
		{ WHIT.." 1) "..Atlas_GetBossName("Hearthsinger Forresten", 443),                                                  443 },
		{ WHIT.." 2) "..Atlas_GetBossName("The Unforgiven", 450),                                                          450 },
		{ WHIT.." 3) "..Atlas_GetBossName("Timmy the Cruel", 445),                                                         445 },
		{ WHIT.." 4) "..Atlas_GetBossName("Commander Malor", 749),                                                         749 },
		{ WHIT.." 5) "..Atlas_GetBossName("Willey Hopebreaker", 446),                                                      446 },
		{ WHIT.." 5) "..Atlas_GetBossName("Instructor Galford", 448),                                                      448 },
		{ WHIT.." 7) "..Atlas_GetBossName("Balnazzar", 449),                                                               449 },
		{ ORNG.." 1) "..L["Stratholme Courier"],                                                                           10002 },
		{ ORNG..INDENT..Atlas_GetBossName("Skul")..ALC["L-Parenthesis"]..ALC["Rare"]..ALC["R-Parenthesis"] },
		{ GREN..INDENT..L["Ezra Grimm's Postbox"] },
		{ ORNG.." 3) "..Atlas_GetBossName("Risen Hammersmith")..ALC["L-Parenthesis"]..ALC["Summon"]..ALC["R-Parenthesis"], 10004 },
		{ GREN..INDENT..ALC["Blacksmithing Plans"] },
		{ GREN.." 1') "..L["King's Square Postbox"],                                                                       10005 },
		{ GREN.." 2') "..L["Festival Lane Postbox"],                                                                       10006 },
		{ GREN.." 3') "..L["Elder Farwhisper"]..ALC["L-Parenthesis"]..ALC["Lunar Festival"]..ALC["R-Parenthesis"],         10007 },
		{ GREN.." 4') "..L["Market Row Postbox"],                                                                          10008 },
		{ GREN..INDENT..Atlas_GetBossName("Postmaster Malown")..ALC["L-Parenthesis"]..ALC["Varies"]..ALC["R-Parenthesis"] },
	},
	StratholmeGauntlet = {
		ZoneName = { BZ["Stratholme"]..ALC["Hyphen"]..BZ["The Gauntlet"] },
		Location = { BZ["Eastern Plaguelands"] },
		DungeonID = 274,
		Acronym = L["Strat"],
		WorldMapID = 318,
		DungeonLevel = 2,
		JournalInstanceID = 236,
		Module = "Atlas_ClassicWoW",
		PrevMap = "StratholmeCrusader",
		{ BLUE.." A) "..ALC["Entrance"]..ALC["L-Parenthesis"]..ALC["Front"]..ALC["R-Parenthesis"],                                 10001 },
		{ GREN..INDENT..L["Packmaster Stonebruiser <Brotherhood of the Light>"] },
		{ WHIT.." 1) "..Atlas_GetBossName("Baroness Anastari", 451),                                                               451 },
		{ WHIT.." 2) "..Atlas_GetBossName("Nerub'enkan", 452),                                                                     452 },
		{ WHIT.." 3) "..Atlas_GetBossName("Maleki the Pallid", 453),                                                               453 },
		{ WHIT.." 4) "..Atlas_GetBossName("Magistrate Barthilas", 454)..ALC["L-Parenthesis"]..ALC["Varies"]..ALC["R-Parenthesis"], 454 },
		{ WHIT.." 5) "..Atlas_GetBossName("Ramstein the Gorger", 455),                                                             455 },
		{ WHIT.." 6) "..Atlas_GetBossName("Lord Aurius Rivendare", 456),                                                           456 },
		{ ORNG.." 1) "..Atlas_GetBossName("Black Guard Swordsmith")..ALC["L-Parenthesis"]..ALC["Summon"]..ALC["R-Parenthesis"],    10003 },
		{ GREN..INDENT..ALC["Blacksmithing Plans"] },
		{ GREN.." 1') "..L["Archmage Angela Dosantos <Brotherhood of the Light>"],                                                 10002 },
		{ GREN..INDENT..L["Crusade Commander Eligor Dawnbringer <Brotherhood of the Light>"] },
		{ GREN..INDENT..L["Crusade Commander Korfax <Brotherhood of the Light>"] },
		{ GREN..INDENT..L["Master Craftsman Wilhelm <Brotherhood of the Light>"] },
	},
	TheDeadminesEnt = {
		ZoneName = { BZ["The Deadmines"]..ALC["L-Parenthesis"]..ALC["Entrance"]..ALC["R-Parenthesis"] },
		Location = { BZ["Westfall"] },
		MinLevel = "15",
		PlayerLimit = { 5 },
		Acronym = L["VC"],
		WorldMapID = 291,
		JournalInstanceID = 63,
		Module = "Atlas_ClassicWoW",
		NextMap = "TheDeadminesA",
		{ BLUE.." A) "..ALC["Entrance"],                                                                                                            10001 },
		{ GREN..INDENT..ALC["Meeting Stone"] },
		{ BLUE.." B) "..BZ["The Deadmines"],                                                                                                        10002 },
		{ ORNG.." 1) "..Atlas_GetBossName("Marisa du'Paige")..ALC["L-Parenthesis"]..ALC["Rare"]..ALC["Comma"]..ALC["Varies"]..ALC["R-Parenthesis"], 10003 },
		{ ORNG.." 2) "..Atlas_GetBossName("Brainwashed Noble")..ALC["L-Parenthesis"]..ALC["Rare"]..ALC["R-Parenthesis"],                            10004 },
		{ ORNG.." 3) "..Atlas_GetBossName("Foreman Thistlenettle"),                                                                                 10005 },
	},
	TheDeadminesA = {
		ZoneName = { BZ["The Deadmines"]..ALC["MapA"] },
		Location = { BZ["Westfall"] },
		DungeonID = 6,
		DungeonHeroicID = 326,
		Acronym = L["VC"],
		WorldMapID = 291,
		DungeonLevel = 1,
		JournalInstanceID = 63,
		Module = "Atlas_ClassicWoW",
		PrevMap = "TheDeadminesEnt",
		NextMap = "TheDeadminesB",
		{ BLUE.." A) "..ALC["Entrance"],                                                                                                                   10001 },
		{ BLUE.." B) "..ALC["Connection"],                                                                                                                 10002 },
		{ WHIT.." 1) "..Atlas_GetBossName("Glubtok", 89),                                                                                                  89 },
		{ WHIT.." 2) "..Atlas_GetBossName("Lumbering Oaf", 90, 2),                                                                                         90 },
		{ WHIT..INDENT..Atlas_GetBossName("Helix Gearbreaker", 90),                                                                                        90 },
		{ WHIT.." 3) "..Atlas_GetBossName("Foe Reaper 5000", 91),                                                                                          91 },
		{ GREN.." 1') "..L["Goblin Teleporter"],                                                                                                           10004 },
		{ GREN.." 2') "..Atlas:GetCreatureName(L["Lieutenant Horatio Laine"], 46612)..ALC["L-Parenthesis"]..FACTION_ALLIANCE..ALC["R-Parenthesis"],        10003 },
		{ GREN..INDENT..Atlas:GetCreatureName(L["Quartermaster Lewis <Quartermaster>"], 491)..ALC["L-Parenthesis"]..FACTION_ALLIANCE..ALC["R-Parenthesis"] },
		{ GREN..INDENT..Atlas:GetCreatureName(L["Slinky Sharpshiv"], 46906)..ALC["L-Parenthesis"]..FACTION_HORDE..ALC["R-Parenthesis"] },
		{ GREN..INDENT..Atlas:GetCreatureName(L["Kagtha"], 46889)..ALC["L-Parenthesis"]..FACTION_HORDE..ALC["R-Parenthesis"] },
		{ GREN..INDENT..Atlas:GetCreatureName(L["Miss Mayhem"], 46902)..ALC["L-Parenthesis"]..FACTION_HORDE..ALC["R-Parenthesis"] },
		{ GREN..INDENT..Atlas:GetCreatureName(L["Vend-O-Tron D-Luxe"], 24935)..ALC["L-Parenthesis"]..FACTION_HORDE..ALC["R-Parenthesis"] },
		{ "" },
		{ LBLU..ACHIEVEMENTS..ALC["Colon"] },
		{ "Ready for Raiding",                                                                                                                             "ac=5366" },
		{ "Rat Pack",                                                                                                                                      "ac=5367" },
		{ "Prototype Prodigy",                                                                                                                             "ac=5368" },
		{ "It's Frost Damage",                                                                                                                             "ac=5369" },
		{ "I'm on a Diet",                                                                                                                                 "ac=5370" },
		{ "Vigorous VanCleef Vindicator",                                                                                                                  "ac=5371" },
		{ "Deadmines",                                                                                                                                     "ac=628" },
		{ "Heroic: Deadmines",                                                                                                                             "ac=5083" },
		{ "Heroic: Deadmines Guild Run",                                                                                                                   "ac=5141" },
	},
	TheDeadminesB = {
		ZoneName = { BZ["The Deadmines"]..ALC["MapB"] },
		Location = { BZ["Westfall"] },
		DungeonID = 6,
		DungeonHeroicID = 326,
		Acronym = L["VC"],
		WorldMapID = 292,
		DungeonLevel = 2,
		JournalInstanceID = 63,
		Module = "Atlas_ClassicWoW",
		PrevMap = "TheDeadminesA",
		{ BLUE.." B) "..ALC["Connection"],                                                                                    10002 },
		{ BLUE.." C) "..ALC["Exit"],                                                                                          10003 },
		{ WHIT.." 4) "..Atlas_GetBossName("Admiral Ripsnarl", 92),                                                            92 },
		{ WHIT..INDENT..Atlas_GetBossName("\"Captain\" Cookie", 93),                                                          93 },
		{ WHIT..INDENT..Atlas_GetBossName("Vanessa VanCleef", 95)..ALC["L-Parenthesis"]..ALC["Heroic"]..ALC["R-Parenthesis"], 95 },
		{ GREN.." 1') "..L["Goblin Teleporter"],                                                                              10004 },
		{ "" },
		{ LBLU..ACHIEVEMENTS..ALC["Colon"] },
		{ "Ready for Raiding",                                                                                                "ac=5366" },
		{ "Rat Pack",                                                                                                         "ac=5367" },
		{ "Prototype Prodigy",                                                                                                "ac=5368" },
		{ "It's Frost Damage",                                                                                                "ac=5369" },
		{ "I'm on a Diet",                                                                                                    "ac=5370" },
		{ "Vigorous VanCleef Vindicator",                                                                                     "ac=5371" },
		{ "Deadmines",                                                                                                        "ac=628" },
		{ "Heroic: Deadmines",                                                                                                "ac=5083" },
		{ "Heroic: Deadmines Guild Run",                                                                                      "ac=5141" },
	},
	TheStockade = {
		ZoneName = { BZ["The Stockade"] },
		Location = { BZ["Stormwind City"] },
		DungeonID = 12,
		Acronym = L["Stocks"],
		WorldMapID = 225,
		JournalInstanceID = 238,
		Module = "Atlas_ClassicWoW",
		{ BLUE.." A) "..ALC["Entrance"],                                                                         10001 },
		{ WHIT.." 1) "..Atlas_GetBossName("Randolph Moloch", 466),                                               466 },
		{ WHIT.." 2) "..Atlas_GetBossName("Hogger", 464),                                                        464 },
		{ WHIT.." 3) "..Atlas_GetBossName("Lord Overheat", 465),                                                 465 },
		{ GREN.." 1') "..L["Rifle Commander Coe"]..ALC["L-Parenthesis"]..FACTION_ALLIANCE..ALC["R-Parenthesis"], 10002 },
		{ GREN.." 2') "..L["Warden Thelwater"]..ALC["L-Parenthesis"]..FACTION_ALLIANCE..ALC["R-Parenthesis"],    10003 },
		{ GREN.." 3') "..L["Nurse Lillian"]..ALC["L-Parenthesis"]..FACTION_ALLIANCE..ALC["R-Parenthesis"],       10004 },
	},
	TheSunkenTempleEnt = {
		ZoneName = { BZ["Sunken Temple"]..ALC["L-Parenthesis"]..ALC["Entrance"]..ALC["R-Parenthesis"] },
		Location = { BZ["Swamp of Sorrows"] },
		DungeonID = 28,
		Acronym = L["ST"],
		WorldMapID = 220,
		JournalInstanceID = 237,
		Module = "Atlas_ClassicWoW",
		NextMap = "TheSunkenTemple",
		{ BLUE.." A) "..ALC["Entrance"],                                                              10001 },
		{ GREN..INDENT..ALC["Meeting Stone"] },
		{ GREN..INDENT..L["Lord Itharius"] },
		{ BLUE.." B) "..BZ["Sunken Temple"],                                                          10002 },
		{ WHIT.." 1) "..L["Priestess Udum'bra"],                                                      10003 },
		{ WHIT.." 2) "..L["Gomora the Bloodletter"],                                                  10004 },
		{ WHIT.." 3) "..Atlas_GetBossName("Jammal'an the Prophet", 458),                              10005, 458 },
		{ ORNG.." 1) "..L["Captain Wyrmak"]..ALC["L-Parenthesis"]..ALC["Rare"]..ALC["R-Parenthesis"], 10006 },
	},
	TheSunkenTemple = {
		ZoneName = { BZ["Sunken Temple"] },
		Location = { BZ["Swamp of Sorrows"] },
		DungeonID = 28,
		Acronym = L["ST"],
		WorldMapID = 220,
		JournalInstanceID = 237,
		Module = "Atlas_ClassicWoW",
		PrevMap = "TheSunkenTempleEnt",
		{ ORNG.." "..ALC["AKA"]..ALC["Colon"]..BZ["The Temple of Atal'Hakkar"] },
		{ BLUE.." A) "..ALC["Entrance"],                                                                                      10001 },
		{ WHIT.." 1) "..Atlas_GetBossName("Avatar of Hakkar", 457),                                                           457 },
		{ WHIT.." 2) "..Atlas_GetBossName("Jammal'an the Prophet", 458),                                                      458 },
		{ WHIT..INDENT..Atlas_GetBossName("Ogom the Wretched") },
		{ WHIT.." 3) "..Atlas_GetBossName("Dreamscythe", 459, 1)..ALC["L-Parenthesis"]..ALC["Wanders"]..ALC["R-Parenthesis"], 459 },
		{ WHIT..INDENT..Atlas_GetBossName("Weaver", 459, 2)..ALC["L-Parenthesis"]..ALC["Wanders"]..ALC["R-Parenthesis"],      459 },
		{ WHIT.." 4) "..Atlas_GetBossName("Hazzas", 459, 4)..ALC["L-Parenthesis"]..ALC["Wanders"]..ALC["R-Parenthesis"],      459 },
		{ WHIT..INDENT..Atlas_GetBossName("Morphaz", 459, 3)..ALC["L-Parenthesis"]..ALC["Wanders"]..ALC["R-Parenthesis"],     459 },
		{ WHIT.." 5) "..Atlas_GetBossName("Shade of Eranikus", 463),                                                          463 },
		{ GREN.." 1') "..L["Lord Itharius"],                                                                                  10002 },
		{ GREN.." 2') "..L["Elder Starsong"]..ALC["L-Parenthesis"]..ALC["Lunar Festival"]..ALC["R-Parenthesis"],              10003 },
	},
	UldamanEnt = {
		ZoneName = { BZ["Uldaman"]..ALC["L-Parenthesis"]..ALC["Entrance"]..ALC["R-Parenthesis"] },
		Location = { BZ["Badlands"] },
		DungeonID = 22,
		Acronym = L["Ulda"],
		WorldMapID = 230,
		JournalInstanceID = 239,
		Module = "Atlas_ClassicWoW",
		NextMap = "Uldaman",
		{ BLUE.." A) "..ALC["Entrance"], 10001 },
		{ BLUE.." B) "..BZ["Uldaman"],   10002 },
	},
	Uldaman = {
		ZoneName = { BZ["Uldaman"] },
		Location = { BZ["Badlands"] },
		DungeonID = 22,
		Acronym = L["Ulda"],
		WorldMapID = 230,
		JournalInstanceID = 239,
		Module = "Atlas_ClassicWoW",
		PrevMap = "UldamanEnt",
		{ BLUE.." A) "..ALC["Entrance"]..ALC["L-Parenthesis"]..ALC["Front"]..ALC["R-Parenthesis"],                                            10001 },
		{ BLUE.." B) "..ALC["Entrance"]..ALC["L-Parenthesis"]..ALC["Back"]..ALC["R-Parenthesis"],                                             10002 },
		{ BLUE.." C) "..ALC["Connection"],                                                                                                    10003 },
		{ WHIT.." 1) "..Atlas_GetBossName("The Lost Dwarves", 468)..ALC["L-Parenthesis"]..FACTION_HORDE..ALC["R-Parenthesis"],                468 },
		{ WHIT..INDENT..Atlas_GetBossName("Olaf", 468, 3),                                                                                    468 },
		{ WHIT..INDENT..Atlas_GetBossName("Eric \"The Swift\"", 468, 2),                                                                      468 },
		{ WHIT..INDENT..Atlas_GetBossName("Baelog", 468, 1),                                                                                  468 },
		{ GREN..INDENT..L["Baelog's Chest"] },
		{ WHIT.." 2) "..Atlas_GetBossName("Revelosh", 467),                                                                                   467 },
		{ WHIT.." 3) "..Atlas_GetBossName("Ironaya", 469),                                                                                    469 },
		{ WHIT.." 4) "..Atlas_GetBossName("Obsidian Sentinel", 748),                                                                          748 },
		{ WHIT.." 5) "..Atlas_GetBossName("Ancient Stone Keeper", 470),                                                                       470 },
		{ WHIT.." 6) "..Atlas_GetBossName("Galgann Firehammer", 471),                                                                         471 },
		{ WHIT.." 7) "..Atlas_GetBossName("Grimlok", 472),                                                                                    472 },
		{ WHIT.." 8) "..Atlas_GetBossName("Archaedas", 473),                                                                                  473 },
		{ GREN.." 1') "..L["Kand Sandseeker <Explorer's League>"]..ALC["L-Parenthesis"]..FACTION_ALLIANCE..ALC["R-Parenthesis"],              10004 },
		{ GREN..INDENT..L["Lead Prospector Durdin <Explorer's League>"]..ALC["L-Parenthesis"]..FACTION_ALLIANCE..ALC["R-Parenthesis"] },
		{ GREN..INDENT..L["Olga Runesworn <Explorer's League>"]..ALC["L-Parenthesis"]..FACTION_ALLIANCE..ALC["R-Parenthesis"] },
		{ GREN..INDENT..L["Aoren Sunglow <The Reliquary>"]..ALC["L-Parenthesis"]..FACTION_HORDE..ALC["R-Parenthesis"] },
		{ GREN..INDENT..L["High Examiner Tae'thelan Bloodwatcher <The Reliquary>"]..ALC["L-Parenthesis"]..FACTION_HORDE..ALC["R-Parenthesis"] },
		{ GREN..INDENT..L["Lidia Sunglow <The Reliquary>"]..ALC["L-Parenthesis"]..FACTION_HORDE..ALC["R-Parenthesis"] },
		{ GREN.." 2') "..L["Ancient Treasure"],                                                                                               10005 },
		{ GREN..INDENT..L["The Discs of Norgannon"] },
	},
	--************************************************
	-- Kalimdor Instances (Classic)
	--************************************************
	BlackfathomDeepsEnt = {
		ZoneName = { BZ["Blackfathom Deeps"]..ALC["L-Parenthesis"]..ALC["Entrance"]..ALC["R-Parenthesis"] },
		Location = { BZ["Ashenvale"] },
		MinLevel = "20",
		PlayerLimit = { 5 },
		Acronym = L["BFD"],
		WorldMapID = 221,
		JournalInstanceID = 227,
		Module = "Atlas_ClassicWoW",
		NextMap = "CL_BlackfathomDeepsA",
		{ BLUE.." A) "..ALC["Entrance"],         10001 },
		{ BLUE.." B) "..BZ["Blackfathom Deeps"], 10002 },
	},
	CL_BlackfathomDeepsA = {
		ZoneName = { BZ["Blackfathom Deeps"]..ALC["MapA"] },
		Location = { BZ["Ashenvale"] },
		DungeonID = 10,
		LevelRange = "20-34",
		PlayerLimit = { 5 },
		Acronym = L["BFD"],
		WorldMapID = 221,
		JournalInstanceID = 227,
		Module = "Atlas_ClassicWoW",
		PrevMap = "BlackfathomDeepsEnt",
		NextMap = "CL_BlackfathomDeepsB",
		{ BLUE.." A) "..ALC["Entrance"] },
		{ WHIT.." 1) "..Atlas_GetBossName("Ghamoo-ra", 368),                                                        368 },
		{ WHIT.." 2) "..L["Lorgalis Manuscript"] },
		{ WHIT.." 3) "..Atlas_GetBossName("Lady Sarevess", 436),                                                    436 },
		{ WHIT.." 4) "..L["Argent Guard Thaelrid"] },
		{ WHIT.." 5) "..Atlas_GetBossName("Gelihast", 426),                                                         426 },
		{ WHIT.." 6) "..Atlas_GetBossName("Lorgus Jett")..ALC["L-Parenthesis"]..ALC["Varies"]..ALC["R-Parenthesis"] },
	},
	CL_BlackfathomDeepsB = {
		ZoneName = { BZ["Blackfathom Deeps"]..ALC["MapB"] },
		Location = { BZ["Ashenvale"] },
		DungeonID = 10,
		LevelRange = "20-34",
		PlayerLimit = { 5 },
		Acronym = L["BFD"],
		WorldMapID = 221,
		JournalInstanceID = 227,
		Module = "Atlas_ClassicWoW",
		PrevMap = "CL_BlackfathomDeepsA",
		NextMap = "CL_BlackfathomDeepsC",
		{ WHIT.." 6) "..Atlas_GetBossName("Lorgus Jett")..ALC["L-Parenthesis"]..ALC["Varies"]..ALC["R-Parenthesis"] },
		{ WHIT.." 7) "..Atlas_GetBossName("Baron Aquanis")..ALC["L-Parenthesis"]..ALC["Summon"]..ALC["R-Parenthesis"] },
		{ WHIT..INDENT..L["Fathom Core"] },
		{ WHIT.." 8) "..Atlas_GetBossName("Twilight Lord Kelris", 437),                                               437 },
		{ WHIT.."10) "..Atlas_GetBossName("Aku'mai", 444),                                                            444 },
	},
	CL_BlackfathomDeepsC = {
		ZoneName = { BZ["Blackfathom Deeps"]..ALC["MapC"] },
		Location = { BZ["Ashenvale"] },
		DungeonID = 10,
		LevelRange = "20-34",
		PlayerLimit = { 5 },
		Acronym = L["BFD"],
		WorldMapID = 221,
		JournalInstanceID = 227,
		Module = "Atlas_ClassicWoW",
		PrevMap = "CL_BlackfathomDeepsB",
		{ WHIT.." 9) "..Atlas_GetBossName("Old Serra'kis", 447), 447 },
	},
	DireMaulEnt = {
		ZoneName = { BZ["Dire Maul"]..ALC["L-Parenthesis"]..ALC["Entrance"]..ALC["R-Parenthesis"] },
		Location = { BZ["Feralas"] },
		LevelRange = "38-47",
		MinLevel = "36",
		PlayerLimit = { 5 },
		Acronym = L["DM"],
		WorldMapID = 235,
		JournalInstanceID = 230,
		Module = "Atlas_ClassicWoW",
		NextMap = "DireMaulEast",
		{ BLUE.." A) "..ALC["Entrance"],                                                                         10001 },
		{ BLUE.." B) "..BZ["Dire Maul"]..ALC["L-Parenthesis"]..ALC["East"]..ALC["R-Parenthesis"],                10002 },
		{ BLUE.." C) "..BZ["Dire Maul"]..ALC["L-Parenthesis"]..ALC["North"]..ALC["R-Parenthesis"],               10003 },
		{ BLUE.." D) "..BZ["Dire Maul"]..ALC["L-Parenthesis"]..ALC["West"]..ALC["R-Parenthesis"],                10004 },
		{ GREN.." 1') "..L["Dire Pool"],                                                                         10005 },
		{ GREN.." 2') "..L["Dire Maul Arena"],                                                                   10006 },
		{ GREN..INDENT..L["Elder Mistwalker"]..ALC["L-Parenthesis"]..ALC["Lunar Festival"]..ALC["R-Parenthesis"] },
	},
	DireMaulEast = {
		ZoneName = { BZ["Dire Maul"]..ALC["L-Parenthesis"]..ALC["East"]..ALC["R-Parenthesis"] },
		Location = { BZ["Feralas"] },
		DungeonID = 34,
		Acronym = L["DM"],
		WorldMapID = 239,
		DungeonLevel = 6,
		JournalInstanceID = 230,
		Module = "Atlas_ClassicWoW",
		PrevMap = "DireMaulEnt",
		NextMap = "DireMaulNorth",
		{ BLUE.." A) "..ALC["Entrance"],                                                                                      10001 },
		{ GREN..INDENT..L["\"Ambassador\" Dagg'thol"] },
		{ GREN..INDENT..L["Furgus Warpwood"] },
		{ BLUE.." B) "..ALC["Entrance"],                                                                                      10002 },
		{ BLUE.." C) "..ALC["Entrance"],                                                                                      10003 },
		{ BLUE.." D) "..ALC["Connection"],                                                                                    10004 },
		{ BLUE.." E) "..ALC["Exit"],                                                                                          10005 },
		{ WHIT.." 1) "..Atlas_GetBossName("Lethtendris", 404),                                                                404 },
		{ WHIT..INDENT..Atlas_GetBossName("Pimgib") },
		{ WHIT.." 2) "..Atlas_GetBossName("Hydrospawn", 403),                                                                 403 },
		{ WHIT.." 3) "..Atlas_GetBossName("Zevrim Thornhoof", 402)..ALC["L-Parenthesis"]..ALC["Upper"]..ALC["R-Parenthesis"], 402 },
		{ WHIT.." 4) "..Atlas_GetBossName("Alzzin the Wildshaper", 405),                                                      405 },
		{ GREN.." 1') "..Atlas_GetBossName("Pusillin")..ALC["L-Parenthesis"]..L["Chase Begins"]..ALC["R-Parenthesis"],        10006 },
		{ GREN.." 2') "..Atlas_GetBossName("Pusillin")..ALC["L-Parenthesis"]..L["Chase Ends"]..ALC["R-Parenthesis"],          10007 },
		{ GREN.." 3') "..L["Old Ironbark"]..ALC["Slash"]..L["Ironbark the Redeemed"],                                         10008 },
	},
	DireMaulNorth = {
		ZoneName = { BZ["Dire Maul"]..ALC["L-Parenthesis"]..ALC["North"]..ALC["R-Parenthesis"] },
		Location = { BZ["Feralas"] },
		DungeonID = 36,
		Acronym = L["DM"],
		WorldMapID = 234,
		DungeonLevel = 1,
		JournalInstanceID = 230,
		Module = "Atlas_ClassicWoW",
		PrevMap = "DireMaulEast",
		NextMap = "DireMaulWest",
		{ BLUE.." A) "..ALC["Entrance"],                                                                      10001 },
		{ GREN..INDENT..L["Druid of the Talon"]..ALC["L-Parenthesis"]..FACTION_ALLIANCE..ALC["R-Parenthesis"] },
		{ GREN..INDENT..L["Stonemaul Ogre"]..ALC["L-Parenthesis"]..FACTION_HORDE..ALC["R-Parenthesis"] },
		{ WHIT.." 1) "..Atlas_GetBossName("Guard Mol'dar", 411),                                              411 },
		{ WHIT.." 2) "..Atlas_GetBossName("Stomper Kreeg", 412),                                              412 },
		{ WHIT.." 3) "..Atlas_GetBossName("Guard Fengus", 413),                                               413 },
		{ WHIT.." 4) "..Atlas_GetBossName("Guard Slip'kik", 414),                                             414 },
		{ GREN..INDENT..L["Knot Thimblejack"] },
		{ WHIT.." 5) "..Atlas_GetBossName("Captain Kromcrush", 415),                                          415 },
		{ WHIT.." 6) "..Atlas_GetBossName("King Gordok", 417),                                                417 },
		{ WHIT..INDENT..Atlas_GetBossName("Cho'Rush the Observer", 416),                                      416 },
	},
	DireMaulWest = {
		ZoneName = { BZ["Dire Maul"]..ALC["L-Parenthesis"]..ALC["West"]..ALC["R-Parenthesis"] },
		Location = { BZ["Feralas"] },
		DungeonID = 38,
		Acronym = L["DM"],
		WorldMapID = 237,
		DungeonLevel = 4,
		JournalInstanceID = 230,
		Module = "Atlas_ClassicWoW",
		PrevMap = "DireMaulNorth",
		{ ORNG.." "..ALC["Key"]..ALC["Colon"]..L["J'eevee's Jar"]..ALC["L-Parenthesis"]..Atlas_GetBossName("Lord Hel'nurath")..ALC["R-Parenthesis"] },
		{ BLUE.." A) "..ALC["Entrance"],                                                                                                            10001 },
		{ BLUE.." B-E) "..ALC["Connection"],                                                                                                        10002 },
		{ WHIT.." 1) "..Atlas_GetBossName("Tendris Warpwood", 406),                                                                                 406 },
		{ WHIT.." 2) "..Atlas_GetBossName("Magister Kalendris", 408),                                                                               408 },
		{ WHIT.." 3) "..Atlas_GetBossName("Illyanna Ravenoak", 407),                                                                                407 },
		{ WHIT..INDENT..L["Ferra"] },
		{ WHIT.." 4) "..Atlas_GetBossName("Immol'thar", 409),                                                                                       409 },
		{ ORNG..INDENT..Atlas_GetBossName("Lord Hel'nurath")..ALC["L-Parenthesis"]..ALC["Summon"]..ALC["R-Parenthesis"] },
		{ WHIT.." 5) "..Atlas_GetBossName("Prince Tortheldrin", 410),                                                                               410 },
		{ ORNG.." 1) "..Atlas_GetBossName("Tsu'zee")..ALC["L-Parenthesis"]..ALC["Rare"]..ALC["R-Parenthesis"],                                      10008 },
		{ GREN.." 1') "..L["Estulan <The Highborne>"],                                                                                              10003 },
		{ GREN..INDENT..L["Shen'dralar Watcher"] },
		{ GREN.." 2') "..L["Pylons"],                                                                                                               10004 },
		{ GREN.." 3') "..L["Ancient Equine Spirit"],                                                                                                10005 },
		{ GREN.." 4') "..L["Shen'dralar Ancient"],                                                                                                  10006 },
		{ GREN.." 5') "..BZ["The Athenaeum"],                                                                                                       10007 },
		{ GREN..INDENT..L["Falrin Treeshaper"] },
		{ GREN..INDENT..L["Lorekeeper Lydros"] },
		{ GREN..INDENT..L["Lorekeeper Javon"] },
		{ GREN..INDENT..L["Lorekeeper Kildrath"] },
		{ GREN..INDENT..L["Lorekeeper Mykos"] },
		{ GREN..INDENT..L["Shen'dralar Provisioner"] },
	},
	MaraudonEnt = {
		ZoneName = { BZ["Maraudon"]..ALC["L-Parenthesis"]..ALC["Entrance"]..ALC["R-Parenthesis"] },
		Location = { BZ["Desolace"] },
		MinLevel = "30",
		PlayerLimit = { 5 },
		Acronym = L["Mara"],
		WorldMapID = 280,
		JournalInstanceID = 232,
		Module = "Atlas_ClassicWoW",
		NextMap = "Maraudon",
		{ BLUE.." A) "..ALC["Entrance"],                                                                                           10001 },
		{ ORNG..INDENT..L["Cursed Centaur"]..ALC["L-Parenthesis"]..ALC["Rare"]..ALC["Comma"]..ALC["Wanders"]..ALC["R-Parenthesis"] },
		{ WHIT..INDENT..L["The Nameless Prophet"]..ALC["L-Parenthesis"]..ALC["Lower"]..ALC["R-Parenthesis"] },
		{ BLUE.." B) "..BZ["Maraudon"]..ALC["L-Parenthesis"]..ALC["Purple"]..ALC["R-Parenthesis"],                                 10002 },
		{ BLUE.." C) "..BZ["Maraudon"]..ALC["L-Parenthesis"]..ALC["Orange"]..ALC["R-Parenthesis"],                                 10003 },
		{ BLUE.." D) "..BZ["Maraudon"]..ALC["L-Parenthesis"]..ALC["Portal"]..ALC["Comma"]..ALC["Lower"]..ALC["R-Parenthesis"],     10004 },
		{ GREN.." 1') "..L["Kherrah"]..ALC["L-Parenthesis"]..ALC["Lower"]..ALC["R-Parenthesis"],                                   10005 },
	},
	Maraudon = {
		ZoneName = { BZ["Maraudon"] },
		Location = { BZ["Desolace"] },
		MinLevel = "30",
		PlayerLimit = { 5 },
		Acronym = L["Mara"],
		WorldMapID = 280,
		JournalInstanceID = 232,
		Module = "Atlas_ClassicWoW",
		PrevMap = "MaraudonEnt",
		{ BLUE.." A) "..ALC["Entrance"]..ALC["L-Parenthesis"]..ALC["Orange"]..ALC["R-Parenthesis"],                                                        10001 },
		{ BLUE.." B) "..ALC["Entrance"]..ALC["L-Parenthesis"]..ALC["Purple"]..ALC["R-Parenthesis"],                                                        10002 },
		{ BLUE.." C) "..ALC["Entrance"]..ALC["L-Parenthesis"]..ALC["Portal"]..ALC["R-Parenthesis"],                                                        10003 },
		{ WHIT.." 1) "..Atlas_GetBossName("Noxxion", 423),                                                                                                 423 },
		{ WHIT.." 2) "..Atlas_GetBossName("Razorlash", 424),                                                                                               424 },
		{ WHIT.." 3) "..Atlas_GetBossName("Lord Vyletongue", 427),                                                                                         427 },
		{ WHIT.." 4) "..Atlas_GetBossName("Tinkerer Gizlock", 425),                                                                                        425 },
		{ WHIT.." 5) "..Atlas_GetBossName("Celebras the Cursed", 428),                                                                                     428 },
		{ GREN..INDENT..L["Celebras the Redeemed"] },
		{ WHIT.." 6) "..Atlas_GetBossName("Landslide", 429),                                                                                               429 },
		{ WHIT.." 7) "..Atlas_GetBossName("Rotgrip", 430),                                                                                                 430 },
		{ WHIT.." 8) "..Atlas_GetBossName("Princess Theradras", 431),                                                                                      431 },
		{ ORNG.." 1) "..Atlas_GetBossName("Meshlok the Harvester")..ALC["L-Parenthesis"]..ALC["Rare"]..ALC["Comma"]..ALC["Wanders"]..ALC["R-Parenthesis"], 10004 },
		{ GREN.." 1') "..L["Elder Splitrock"]..ALC["L-Parenthesis"]..ALC["Lunar Festival"]..ALC["R-Parenthesis"],                                          10005 },
	},
	RagefireChasm = {
		ZoneName = { BZ["Ragefire Chasm"] },
		Location = { BZ["Orgrimmar"] },
		DungeonID = 4,
		Acronym = L["RFC"],
		WorldMapID = 213,
		JournalInstanceID = 226,
		Module = "Atlas_ClassicWoW",
		{ BLUE.." A) "..ALC["Entrance"],                                                                   10001 },
		{ WHIT.." 1) "..Atlas_GetBossName("Adarogg", 694),                                                 694 },
		{ WHIT.." 2) "..Atlas_GetBossName("Dark Shaman Koranthal", 695),                                   695 },
		{ WHIT.." 3) "..Atlas_GetBossName("Slagmaw", 696),                                                 696 },
		{ WHIT.." 4) "..Atlas_GetBossName("Lava Guard Gordoth", 697),                                      697 },
		{ GREN.." 1') "..L["Commander Bagran"]..ALC["L-Parenthesis"]..FACTION_HORDE..ALC["R-Parenthesis"], 10002 },
		{ GREN..INDENT..L["Invoker Xorenth"]..ALC["L-Parenthesis"]..FACTION_HORDE..ALC["R-Parenthesis"] },
		{ GREN.." 2') "..L["Scout Cage"],                                                                  10003 },
	},
	CL_RazorfenDowns = {
		ZoneName = { BZ["Razorfen Downs"] },
		Location = { BZ["Thousand Needles"] },
		DungeonID = 20,
		PlayerLimit = { 5 },
		Acronym = L["RFD"],
		WorldMapID = 300,
		JournalInstanceID = 233,
		ActivityID = { 2, 806 },
		Module = "Atlas_ClassicWoW",
		{ BLUE.." A) "..ALC["Entrance"],                                                                                                       10001 },
		{ WHIT.." 1) "..Atlas_GetBossName("Tuten'kash", 432),                                                                                  432 },
		{ WHIT.." 2) "..Atlas_GetBossName("Henry Stern") },
		{ WHIT..INDENT..L["Belnistrasz"] },
		{ WHIT.." 3) "..Atlas_GetBossName("Mordresh Fire Eye", 433),                                                                           433 },
		{ WHIT.." 4) "..Atlas_GetBossName("Glutton", 434),                                                                                     434 },
		{ WHIT.." 5) "..Atlas_GetBossName("Ragglesnout")..ALC["L-Parenthesis"]..ALC["Rare"]..ALC["Comma"]..ALC["Varies"]..ALC["R-Parenthesis"] },
		{ WHIT.." 6) "..Atlas_GetBossName("Amnennar the Coldbringer", 435),                                                                    435 },
		{ WHIT.." 7) "..Atlas_GetBossName("Plaguemaw the Rotting") },
	},
	CL_RazorfenKraul = {
		ZoneName = { BZ["Razorfen Kraul"] },
		Location = { BZ["Southern Barrens"] },
		DungeonID = 16,
		PlayerLimit = { 5 },
		Acronym = L["RFK"],
		WorldMapID = 301,
		JournalInstanceID = 234,
		Module = "Atlas_ClassicWoW",
		{ BLUE.." A) "..ALC["Entrance"],                                                                                  10001 },
		{ WHIT.." 1) "..Atlas_GetBossName("Roogug") },
		{ WHIT.." 2) "..Atlas_GetBossName("Aggem Thorncurse", 439),                                                       439 },
		{ WHIT.." 3) "..Atlas_GetBossName("Death Speaker Jargba", 438),                                                   438 },
		{ WHIT.." 4) "..Atlas_GetBossName("Overlord Ramtusk", 440),                                                       440 },
		{ WHIT.." 5) "..Atlas_GetBossName("Agathelos the Raging", 441),                                                   441 },
		{ WHIT.." 6) "..Atlas_GetBossName("Blind Hunter")..ALC["L-Parenthesis"]..ALC["Rare"]..ALC["R-Parenthesis"] },
		{ WHIT.." 7) "..Atlas_GetBossName("Charlga Razorflank", 442),                                                     442 },
		{ WHIT.." 8) "..L["Willix the Importer"] },
		{ WHIT..INDENT..L["Heralath Fallowbrook"] },
		{ WHIT.." 9) "..Atlas_GetBossName("Earthcaller Halmgar")..ALC["L-Parenthesis"]..ALC["Rare"]..ALC["R-Parenthesis"] },
	},
	TheRuinsofAhnQiraj = {
		ZoneName = { BZ["Ahn'Qiraj"]..ALC["Colon"]..BZ["Ruins of Ahn'Qiraj"] },
		Location = { BZ["Ahn'Qiraj: The Fallen Kingdom"] },
		DungeonID = 160,
		Acronym = L["AQ10"],
		PlayerLimit = { 10 },
		WorldMapID = 247,
		-- JournalInstanceID = 743,
		Module = "Atlas_ClassicWoW",
		{ ORNG..REPUTATION..ALC["Colon"]..BF["Cenarion Circle"] },
		{ BLUE.." A) "..ALC["Entrance"],                                                                                     10001 },
		{ WHIT.." 1) "..Atlas_GetBossName("Kurinnaxx") },
		{ GREN..INDENT..Atlas_GetBossName("Lieutenant General Andorov") },
		{ GREN..INDENT..L["Four Kaldorei Elites"] },
		{ WHIT.." 2) "..Atlas_GetBossName("General Rajaxx") },
		{ WHIT..INDENT..L["Captain Qeez"] },
		{ WHIT..INDENT..L["Captain Tuubid"] },
		{ WHIT..INDENT..L["Captain Drenn"] },
		{ WHIT..INDENT..L["Captain Xurrem"] },
		{ WHIT..INDENT..L["Major Yeggeth"] },
		{ WHIT..INDENT..L["Major Pakkon"] },
		{ WHIT..INDENT..L["Colonel Zerran"] },
		{ WHIT.." 3) "..Atlas_GetBossName("Moam")..ALC["L-Parenthesis"]..ALC["Optional"]..ALC["R-Parenthesis"] },
		{ WHIT.." 4) "..Atlas_GetBossName("Buru the Gorger")..ALC["L-Parenthesis"]..ALC["Optional"]..ALC["R-Parenthesis"] },
		{ WHIT.." 5) "..Atlas_GetBossName("Ayamiss the Hunter")..ALC["L-Parenthesis"]..ALC["Optional"]..ALC["R-Parenthesis"] },
		{ WHIT.." 6) "..Atlas_GetBossName("Ossirian the Unscarred") },
		{ GREN.." 1') "..L["Safe Room"],                                                                                     10008 },
	},
	TheTempleofAhnQiraj = {
		ZoneName = { BZ["Ahn'Qiraj"]..ALC["Colon"]..BZ["Temple of Ahn'Qiraj"] },
		Location = { BZ["Ahn'Qiraj: The Fallen Kingdom"] },
		DungeonID = 161,
		Acronym = L["AQ40"],
		PlayerLimit = { 40 },
		WorldMapID = 319,
		-- JournalInstanceID = 744,
		Module = "Atlas_ClassicWoW",
		{ ORNG..REPUTATION..ALC["Colon"]..BF["Brood of Nozdormu"] },
		{ BLUE.." A) "..ALC["Entrance"],                                                                                    10001 },
		{ BLUE.." B-D) "..ALC["Connection"],                                                                                10002 },
		{ WHIT.." 1) "..Atlas_GetBossName("The Prophet Skeram")..ALC["L-Parenthesis"]..ALC["Outside"]..ALC["R-Parenthesis"] },
		{ WHIT.." 2) "..Atlas_GetBossName("The Bug Family")..ALC["L-Parenthesis"]..ALC["Optional"]..ALC["R-Parenthesis"],   10004 },
		{ WHIT..INDENT..Atlas_GetBossName("Vem") },
		{ WHIT..INDENT..Atlas_GetBossName("Lord Kri") },
		{ WHIT..INDENT..Atlas_GetBossName("Princess Yauj") },
		{ WHIT.." 3) "..Atlas_GetBossName("Battleguard Sartura") },
		{ WHIT.." 4) "..Atlas_GetBossName("Fankriss the Unyielding") },
		{ WHIT.." 5) "..Atlas_GetBossName("Viscidus")..ALC["L-Parenthesis"]..ALC["Optional"]..ALC["R-Parenthesis"] },
		{ WHIT.." 6) "..Atlas_GetBossName("Princess Huhuran") },
		{ WHIT.." 7) "..Atlas_GetBossName("The Twin Emperors") },
		{ WHIT..INDENT..Atlas_GetBossName("Emperor Vek'lor") },
		{ WHIT..INDENT..Atlas_GetBossName("Emperor Vek'nilash") },
		{ GREN..INDENT..ALC["Teleporter destination"] },
		{ WHIT.." 8) "..Atlas_GetBossName("Ouro")..ALC["L-Parenthesis"]..ALC["Optional"]..ALC["R-Parenthesis"] },
		{ WHIT.." 9) "..Atlas_GetBossName("C'Thun") },
		{ GREN.." 1') "..L["Andorgos <Brood of Malygos>"]..ALC["L-Parenthesis"]..ALC["Teleporter"]..ALC["R-Parenthesis"],   10012 },
		{ GREN..INDENT..L["Vethsera <Brood of Ysera>"] },
		{ GREN..INDENT..L["Kandrostrasz <Brood of Alexstrasza>"] },
		{ GREN.." 2') "..L["Arygos"],                                                                                       10013 },
		{ GREN..INDENT..L["Caelestrasz"] },
		{ GREN..INDENT..L["Merithra of the Dream"] },
		{ GREN..INDENT..ALC["Teleporter destination"] },
		--Atlas_GetBossName("Silithid Royalty", 1547)
	},
	WailingCavernsEnt = {
		ZoneName = { BZ["Wailing Caverns"]..ALC["L-Parenthesis"]..ALC["Entrance"]..ALC["R-Parenthesis"] },
		Location = { BZ["Northern Barrens"] },
		DungeonID = 1,
		Acronym = L["WC"],
		WorldMapID = 279,
		JournalInstanceID = 240,
		Module = "Atlas_ClassicWoW",
		NextMap = "WailingCaverns",
		{ BLUE.." A) "..ALC["Entrance"],                                                                                  10001 },
		{ BLUE.." B) "..BZ["Wailing Caverns"],                                                                            10002 },
		{ ORNG.." 1) "..Atlas_GetBossName("Trigore the Lasher")..ALC["L-Parenthesis"]..ALC["Rare"]..ALC["R-Parenthesis"], 10003 },
		{ ORNG..INDENT..Atlas_GetBossName("Boahn")..ALC["L-Parenthesis"]..ALC["Rare"]..ALC["R-Parenthesis"] },
	},
	WailingCaverns = {
		ZoneName = { BZ["Wailing Caverns"] },
		Location = { BZ["Northern Barrens"] },
		DungeonID = 1,
		Acronym = L["WC"],
		WorldMapID = 279,
		DungeonLevel = 1,
		JournalInstanceID = 240,
		Module = "Atlas_ClassicWoW",
		PrevMap = "WailingCavernsEnt",
		{ BLUE.." A) "..ALC["Entrance"],                                                                                                                  10001 },
		{ WHIT.." 1) "..Atlas_GetBossName("Lady Anacondra", 474),                                                                                         474 },
		{ WHIT.." 2) "..Atlas_GetBossName("Lord Pythas", 476),                                                                                            476 },
		{ WHIT.." 3) "..Atlas_GetBossName("Lord Cobrahn", 475),                                                                                           475 },
		{ WHIT.." 4) "..Atlas_GetBossName("Skum", 478),                                                                                                   478 },
		{ WHIT.." 5) "..Atlas_GetBossName("Lord Serpentis", 479)..ALC["L-Parenthesis"]..ALC["Upper"]..ALC["R-Parenthesis"],                               479 },
		{ WHIT.." 6) "..Atlas_GetBossName("Verdan the Everliving", 480)..ALC["L-Parenthesis"]..ALC["Upper"]..ALC["R-Parenthesis"],                        480 },
		{ WHIT.." 7) "..Atlas_GetBossName("Mutanus the Devourer", 481),                                                                                   481 },
		{ GREN..INDENT..L["Naralex"] },
		{ ORNG.." 1) "..Atlas_GetBossName("Kresh", 477)..ALC["L-Parenthesis"]..ALC["Varies"]..ALC["R-Parenthesis"],                                       477 },
		{ ORNG.." 2) "..Atlas_GetBossName("Deviate Faerie Dragon")..ALC["L-Parenthesis"]..ALC["Rare"]..ALC["Comma"]..ALC["Varies"]..ALC["R-Parenthesis"], 10002 },
		{ GREN.." 1') "..L["Ebru <Disciple of Naralex>"],                                                                                                 10003 },
		{ GREN..INDENT..L["Nalpak <Disciple of Naralex>"] },
		{ GREN..INDENT..L["Muyoh <Disciple of Naralex>"] },
	},
	ZulFarrak = {
		ZoneName = { BZ["Zul'Farrak"] },
		Location = { BZ["Tanaris"] },
		DungeonID = 24,
		Acronym = L["ZF"],
		WorldMapID = 219,
		JournalInstanceID = 241,
		Module = "Atlas_ClassicWoW",
		{ BLUE.." A) "..ALC["Entrance"],                                                                                                       10001 },
		{ GREN..INDENT..L["Chief Engineer Bilgewhizzle <Gadgetzan Water Co.>"] },
		{ GREN..INDENT..L["Mazoga's Spirit"] },
		{ GREN..INDENT..L["Tran'rek"] },
		{ WHIT.." 1) "..Atlas_GetBossName("Gahz'rilla", 483)..ALC["L-Parenthesis"]..ALC["Summon"]..ALC["R-Parenthesis"],                       483 },
		{ WHIT.." 2) "..Atlas_GetBossName("Sandfury Executioner") },
		{ WHIT..INDENT..L["Weegli Blastfuse"] },
		{ WHIT..INDENT..Atlas_GetBossName("Sergeant Bly") },
		{ WHIT..INDENT..L["Raven"] },
		{ WHIT..INDENT..Atlas_GetBossName("Oro Eyegouge") },
		{ WHIT..INDENT..Atlas_GetBossName("Murta Grimgut") },
		{ WHIT.." 3) "..Atlas_GetBossName("Nekrum Gutchewer and Shadow Priest Sezz'ziz", 487),                                                 487 },
		{ WHIT.." 4) "..Atlas_GetBossName("Chief Ukorz Sandscalp", 489),                                                                       489 },
		{ WHIT..INDENT..Atlas_GetBossName("Ruuzlu") },
		{ WHIT.." 5) "..Atlas_GetBossName("Witch Doctor Zum'rah", 486),                                                                        486 },
		{ WHIT.." 6) "..Atlas_GetBossName("Antu'sul", 484),                                                                                    484 },
		{ ORNG.." 1) "..Atlas_GetBossName("Sandarr Dunereaver")..ALC["L-Parenthesis"]..ALC["Rare"]..ALC["R-Parenthesis"],                      10002 },
		{ ORNG.." 2) "..Atlas_GetBossName("Hydromancer Velratha", 482),                                                                        482 },
		{ ORNG.." 3) "..Atlas_GetBossName("Theka the Martyr", 485),                                                                            485 },
		{ ORNG.." 4) "..Atlas_GetBossName("Dustwraith")..ALC["L-Parenthesis"]..ALC["Rare"]..ALC["Comma"]..ALC["Varies"]..ALC["R-Parenthesis"], 10003 },
		{ ORNG.." 5) "..Atlas_GetBossName("Zerillis")..ALC["L-Parenthesis"]..ALC["Rare"]..ALC["Comma"]..ALC["Wanders"]..ALC["R-Parenthesis"],  10004 },
		{ GREN.." 1') "..L["Elder Wildmane"]..ALC["L-Parenthesis"]..ALC["Lunar Festival"]..ALC["R-Parenthesis"],                               10005 },
	},
	-- Add Classic UBRS for Cataclysm and Mists
	CL_BlackrockSpireUpper = {
		ZoneName = { BZ["Blackrock Mountain"]..ALC["Colon"]..BZ["Upper Blackrock Spire"] },
		Location = { BZ["Searing Gorge"]..ALC["Slash"]..BZ["Burning Steppes"] },
		DungeonID = 43,
		LevelRange = "56-60",
		PlayerLimit = { 5 },
		Acronym = L["UBRS"],
		WorldMapID = 255,
		JournalInstanceID = 229,
		Module = "Atlas_ClassicWoW",
		{ BLUE.." A) "..ALC["Entrance"] },
		{ BLUE.." B) "..BZ["Blackrock Spire"]..ALC["L-Parenthesis"]..ALC["Lower"]..ALC["R-Parenthesis"] },
		{ BLUE.." C-E) "..ALC["Connection"] },
		{ WHIT.." 1) "..Atlas_GetBossName("Pyroguard Emberseer", 397),                                                 397 },
		{ WHIT.." 2) "..Atlas_GetBossName("Solakar Flamewreath", 398),                                                 398 },
		{ WHIT..INDENT..L["Father Flame"] },
		{ WHIT.." 3) "..L["Darkstone Tablet"] },
		{ WHIT..INDENT..L["Doomrigger's Coffer"] },
		{ WHIT.." 4) "..Atlas_GetBossName("Jed Runewatcher")..ALC["L-Parenthesis"]..ALC["Rare"]..ALC["R-Parenthesis"] },
		{ WHIT.." 5) "..Atlas_GetBossName("Goraluk Anvilcrack") },
		{ WHIT.." 6) "..Atlas_GetBossName("Warchief Rend Blackhand", 399),                                             399 },
		{ WHIT..INDENT..Atlas_GetBossName("Gyth") },
		{ WHIT.." 7) "..L["Awbee"] },
		{ WHIT.." 8) "..Atlas_GetBossName("The Beast", 400),                                                           400 },
		{ WHIT..INDENT..Atlas_GetBossName("Lord Valthalak")..ALC["L-Parenthesis"]..ALC["Summon"]..ALC["R-Parenthesis"] },
		{ WHIT..INDENT..L["Finkle Einhorn"] },
		{ WHIT.." 9) "..Atlas_GetBossName("General Drakkisath", 401),                                                  401 },
		{ WHIT..INDENT..L["Drakkisath's Brand"] },
		{ WHIT.."10) "..BZ["Blackwing Lair"] },
	},
}


-- Atlas Map NPC Description Data
db.AtlasMaps_NPC_DB = {
	--************************************************
	-- Eastern Kingdoms Instances (Classic)
	--************************************************
	BlackrockMountainEnt = {
		{ "A",  10001, 271, 182 },
		{ "B",  10002, 255, 498 },
		{ "C",  10003, 158, 12 },
		{ "D",  10004, 362, 308 },
		{ "E",  10005, 220, 286 },
		{ "F",  10006, 334, 419 },
		{ "G",  10007, 432, 357 },
		{ "1",  10008, 405, 356 },
		{ "2",  10009, 136, 191 },
		{ "3",  10010, 130, 33 },
		{ "1'", 10011, 281, 350 },
		{ "2'", 10012, 341, 391 },
	},
	BlackrockDepths = {
		{ 1,     369,   360, 407 }, -- High Interrogator Gerstahn
		{ 2,     370,   411, 263 }, -- Lord Roccor
		{ 3,     371,   381, 279 }, -- Houndmaster Grebmar
		{ 4,     377,   216, 234 }, -- Bael'Gar
		{ 5,     374,   419, 142 }, -- Lord Incendius
		{ 6,     376,   462, 97 }, -- Fineous Darkvire
		{ 7,     375,   202, 327 }, -- Warder Stilgiss
		{ 8,     373,   152, 464 }, -- Pyromancer Loregrain
		{ 9,     372,   123, 433 }, -- Ring of Law
		{ 10,    378,   20,  399 }, -- General Angerforge
		{ 11,    379,   21,  309 }, -- Golem Lord Argelmach
		{ 12,    380,   105, 283 }, -- Hurley Blackbreath
		{ 13,    382,   111, 301 }, -- Ribbly Screwspigot
		{ 14,    381,   131, 300 }, -- Phalanx
		{ 15,    384,   151, 230 }, -- Ambassador Flamelash
		{ 16,    385,   160, 107 }, -- The Seven
		{ 17,    386,   340, 50 }, -- Magmus
		{ 18,    387,   429, 49 }, -- Emperor Dagran Thaurissan
		{ "A",   10001, 274, 350 },
		{ "B",   10002, 388, 307 },
		{ "B",   10002, 121, 466 },
		{ "C",   10002, 60,  454 },
		{ "C",   10002, 310, 295 },
		{ "D",   10002, 225, 287 },
		{ "D",   10002, 472, 144 },
		{ "E",   10003, 264, 195 },
		{ "1'",  10004, 110, 171 },
		{ "1'",  10005, 291, 348 },
		{ "2'",  10006, 340, 354 },
		{ "3'",  10007, 321, 301 },
		{ "4'",  10008, 158, 338 },
		{ "5'",  10009, 63,  429 },
		{ "6'",  10010, 10,  383 },
		{ "7'",  10011, 102, 317 },
		{ "8'",  10012, 126, 283 },
		{ "9'",  10013, 172, 271 },
		{ "10'", 10014, 136, 253 },
		{ "11'", 10015, 194, 95 },
		{ "12'", 10016, 240, 126 },
		{ "13'", 10017, 259, 172 },
		{ "14'", 10018, 284, 31 },
		{ "14'", 10018, 284, 79 },
	},
	GnomereganEnt = {
		{ "A",  10001, 500, 436 }, -- Entrance
		{ "B",  10002, 26,  413 }, -- Gnomeregan, Front
		{ "C",  10003, 129, 21 }, -- Gnomeregan, Back
		{ "1'", 10004, 403, 435 }, -- Elevator
		{ "2'", 10005, 86,  132 }, -- Mail Box
	},
	Gnomeregan = {
		{ 1,    419,   196, 175 }, -- Grubbis
		{ 2,    420,   454, 53 }, -- Viscous Fallout
		{ 3,    421,   260, 109 }, -- Electrocutioner 6000
		{ 4,    418,   110, 483 }, -- Crowd Pummeler 9-60
		{ 5,    422,   291, 229 }, -- Mekgineer Thermaplugg
		{ "A",  10001, 140, 70 },
		{ "B",  10002, 310, 371 },
		{ "C",  10003, 17,  174 },
		{ "C",  10003, 404, 95 },
		{ "D",  10003, 74,  228 },
		{ "D",  10003, 450, 148 },
		{ "E",  10003, 333, 156 },
		{ "E",  10003, 127, 351 },
		{ "F",  10003, 36,  353 },
		{ "F",  10003, 375, 286 },
		{ "1'", 10004, 134, 88 },
		{ "2'", 10005, 420, 102 },
		{ "3'", 10006, 421, 55 },
		{ "4'", 10007, 30,  340 },
		{ "5'", 10008, 311, 195 },
	},
	LowerBlackrockSpire = {
		{ 1,    388,   111, 143 }, -- Highlord Omokk
		{ 2,    389,   297, 321 }, -- Shadow Hunter Vosh'gajin
		{ 3,    390,   368, 354 }, -- War Master Voone
		{ 4,    391,   444, 472 }, -- Mother Smolderweb
		{ 5,    392,   251, 366 }, -- Urok Doomhowl
		{ 6,    393,   196, 392 }, -- Quartermaster Zigris
		{ 7,    394,   43,  387 }, -- Halycon
		{ 8,    396,   202, 223 }, -- Overlord Wyrmthalak
		{ "A",  10001, 127, 61 },
		{ "B",  10002, 15,  48 },
		{ "C",  10003, 128, 6 },
		{ "D",  10004, 271, 125 },
		{ "D",  10004, 279, 208 },
		{ "E",  10004, 333, 277 },
		{ "E",  10004, 434, 412 },
		{ "F",  10004, 356, 477 },
		{ "F",  10004, 297, 480 },
		{ "G",  10004, 231, 495 },
		{ "G",  10004, 90,  347 },
		{ "1",  10005, 387, 61 },
		{ "2",  10006, 267, 153 },
		{ "3",  10007, 139, 161 },
		{ "4",  10008, 324, 406 },
		{ "5",  10009, 475, 464 },
		{ "6",  10010, 25,  327 },
		{ "1'", 10011, 135, 106 },
		{ "2'", 10012, 345, 45 },
		{ "3'", 10013, 396, 152 },
	},
	CL_BlackrockSpireUpper = {
		{ 1, 397, 37,  319 }, -- Pyroguard Emberseer
		{ 2, 398, 112, 390 }, -- Solakar Flamewreath
		{ 3, 399, 405, 90 }, -- Warchief Rend Blackhand
		{ 4, 400, 470, 350 }, -- The Beast
		{ 5, 401, 185, 430 }, -- General Drakkisath
	},
	ScarletHalls = {
		{ 1,    10002, 230, 384 }, -- Commander Lindon
		{ 2,    660,   260, 308 }, -- Houndmaster Braun
		{ 3,    654,   326, 113 }, -- Armsmaster Harlan
		{ 4,    656,   223, 21 }, -- Flameweaver Koegler
		{ "A",  10001, 153, 496 },
		{ "1'", 10003, 158, 477 },
		{ "2'", 10004, 241, 453 },
		{ "3'", 10005, 269, 287 },
	},
	ScarletMonastery = {
		{ 1,    688,   131, 61 }, -- Thalnos the Soulrender
		{ 2,    671,   231, 332 }, -- Brother Korloff
		{ 3,    674,   226, 439 }, -- High Inquisitor Whitemane
		{ "A",  10001, 382, 62 },
		{ "1'", 10002, 304, 62 },
		{ "1",  10003, 227, 87 },
	},
	ScarletMonasteryEnt = {
		{ "A", 10001, 93,  359 }, -- Entrance
		{ "B", 10002, 286, 176 }, -- Scarlet Monastery
		{ "C", 10003, 350, 285 }, -- Scarlet Halls
	},
	Scholomance = {
		{ 1,    659,   140, 133 }, -- Instructor Chillheart
		{ 2,    663,   394, 57 }, -- Jandice Barov
		{ 3,    665,   329, 90 }, -- Rattlegore
		{ 4,    666,   356, 165 }, -- Lilian Voss
		{ 5,    10003, 360, 291 }, --Professor Slate
		{ 6,    684,   286, 391 }, -- Darkmaster Gandling
		{ "A",  10001, 6,   165 },
		{ "B",  10002, 201, 61 },
		{ "B",  10002, 500, 90 },
		{ "C",  10002, 136, 213 },
		{ "C",  10002, 393, 344 },
		{ "D",  10002, 136, 243 },
		{ "D",  10002, 287, 372 },
		{ "1'", 10004, 36,  130 },
		{ "2'", 10005, 111, 125 },
		{ "3'", 10006, 463, 96 },
		{ "4'", 10007, 317, 153 },
		{ "5'", 10008, 343, 203 },
		{ "6'", 10009, 344, 226 },

	},
	ShadowfangKeep = {
		{ 1,    96,    363, 408 }, -- Baron Ashbury
		{ 2,    97,    54,  339 }, -- Baron Silverlaine
		{ 3,    98,    171, 353 }, -- Commander Springvale
		{ 4,    99,    290, 173 }, -- Lord Walden
		{ 5,    100,   207, 51 }, -- Lord Godfrey
		{ "A",  10001, 383, 368 },
		{ "B",  10002, 163, 214 },
		{ "B",  10002, 219, 288 },
		{ "C",  10002, 43,  364 },
		{ "C",  10002, 106, 438 },
		{ "1",  10003, 226, 333 },
		{ "1'", 10004, 359, 361 },
		{ "2'", 10005, 392, 340 },
		{ "3'", 10006, 318, 372 },
	},
	StratholmeCrusader = {
		{ 1,    443,   310, 196 }, -- Hearthsinger Forresten
		{ 2,    450,   387, 151 }, -- The Unforgiven
		{ 3,    445,   257, 151 }, -- Timmy the Cruel
		{ 4,    749,   151, 228 }, -- Commander Malor
		{ 5,    446,   11,  268 }, -- Willey Hopebreaker
		{ 6,    448,   137, 352 }, -- Instructor Galford
		{ 7,    449,   99,  378 }, -- Balnazzar
		{ "A",  10001, 353, 405 },
		{ "1",  10002, 289, 335 },
		{ "3",  10004, 54,  259 },
		{ "1'", 10005, 337, 272 },
		{ "2'", 10006, 425, 193 },
		{ "3'", 10007, 425, 141 },
		{ "4'", 10008, 372, 181 },
	},
	StratholmeGauntlet = {
		{ 1,    451,   400, 248 }, -- Baroness Anastari
		{ 2,    452,   241, 247 }, -- Nerub'enkan
		{ 3,    453,   340, 96 }, -- Maleki the Pallid
		{ 4,    454,   316, 414 }, -- Magistrate Barthilas
		{ 5,    455,   144, 96 }, -- Ramstein the Gorger
		{ 6,    456,   91,  96 }, -- Lord Aurius Rivendare
		{ "A",  10001, 321, 485 },
		{ "1'", 10002, 339, 398 },
		{ "1",  10003, 378, 274 },
	},
	TheDeadminesA = {
		{ 1,    89,    186, 307 }, -- Glubtok
		{ 2,    90,    262, 454 }, -- Helix Gearbreaker
		{ 3,    91,    333, 333 }, -- Foe Reaper 5000
		{ "A",  10001, 87,  66 },
		{ "B",  10002, 472, 175 },
		{ "1'", 10004, 89,  139 }, -- Goblin Teleporter
		{ "1'", 10004, 231, 466 }, -- Goblin Teleporter
		{ "1'", 10004, 385, 320 }, -- Goblin Teleporter
		{ "2'", 10003, 108, 149 },
	},
	TheDeadminesB = {
		{ 4,    92,    324, 179 }, -- Admiral Ripsnarl
		{ 4,    93,    306, 179 }, -- "Captain"Cookie
		{ 4,    95,    304, 185 }, -- Vanessa VanCleef
		{ "B",  10002, 192, 208 },
		{ "C",  10003, 400, 193 },
		{ "1'", 10004, 286, 225 }, -- Goblin Teleporter
	},
	TheDeadminesEnt = {
		{ "A", 10001, 334, 20 }, -- Entrance
		{ "B", 10002, 79,  249 }, -- The Deadmines
		{ "1", 10003, 439, 204 }, -- Marisa du'Paige
		{ "1", 10003, 319, 324 }, -- Marisa du'Paige
		{ "2", 10004, 361, 363 }, -- Brainwashed Noble
		{ "3", 10005, 319, 449 }, -- Foreman Thistlenettle
	},
	TheStockade = {
		{ 1,    466,   257, 182 }, -- Randolph Moloch
		{ 2,    464,   58,  198 }, -- Hogger
		{ 3,    465,   443, 298 }, -- Lord Overheat
		{ "A",  10001, 252, 366 },
		{ "1'", 10002, 250, 350 },
		{ "2'", 10003, 211, 323 },
		{ "3'", 10004, 294, 323 },
	},
	TheSunkenTemple = {
		{ 1,    457,   52,  220 }, -- Avatar of Hakkar
		{ 2,    458,   448, 176 }, -- Jammal'an the Prophet
		{ 3,    459,   252, 221 }, -- Dreamscythe
		{ 4,    459,   254, 430 }, -- Hazzas
		{ 5,    463,   408, 429 }, -- Shade of Eranikus
		{ "A",  10001, 252, 50 },
		{ "1'", 10002, 251, 78 },
		{ "2'", 10003, 356, 162 },
	},
	TheSunkenTempleEnt = {
		{ "A", 10001, 87,  447 }, -- Entrance
		{ "B", 10002, 304, 166 }, -- Sunken Temple
		{ "1", 10003, 253, 282 }, -- Priestess Udum'bra
		{ "2", 10004, 354, 176 }, -- Gomora the Bloodletter
		{ 3,   458,   304, 62 }, -- Jammal'an the Prophet
		{ "1", 10006, 248, 179 }, -- Captain Wyrmak
	},
	Uldaman = {
		{ 1,    468,   370, 485 }, -- The Lost Dwarves
		{ 2,    467,   323, 368 }, -- Revelosh
		{ 3,    469,   193, 376 }, -- Ironaya
		{ 4,    748,   126, 309 }, -- Obsidian Sentinel
		{ 5,    470,   277, 208 }, -- Ancient Stone Keeper
		{ 6,    471,   104, 169 }, -- Galgann Firehammer
		{ 7,    472,   68,  112 }, -- Grimlok
		{ 8,    473,   343, 65 }, -- Archaedas
		{ "A",  10001, 442, 370 },
		{ "B",  10002, 146, 357 },
		{ "C",  10003, 395, 59 },
		{ "C",  10003, 280, 64 },
		{ "1'", 10004, 410, 369 },
		{ "2'", 10005, 324, 21 },
	},
	UldamanEnt = {
		{ "A", 10001, 494, 167 }, -- Entrance
		{ "B", 10002, 163, 117 }, -- Uldaman
	},
	--************************************************
	-- Kalimdor Instances (Classic)
	--************************************************
	CL_BlackfathomDeepsA = {
		{ 1, 368, 205, 310 }, -- Ghamoo-ra
		{ 3, 436, 31,  201 }, -- Lady Sarevess
		{ 5, 426, 365, 295 }, -- Gelihast
	},
	CL_BlackfathomDeepsB = {
		{ 8,  437, 180, 365 }, -- Twilight Lord Kelris
		{ 10, 444, 445, 389 }, -- Aku'mai
	},
	CL_BlackfathomDeepsC = {
		{ 9, 447, 435, 235 }, -- Old Serra'kis
	},
	BlackfathomDeepsEnt = {
		{ "A", 10001, 176, 395 }, -- Entrance
		{ "B", 10002, 358, 227 }, -- Blackfathom Deeps
	},
	DireMaulEnt = {
		{ "A",  10001, 131, 495 }, -- Entrance
		{ "B",  10002, 348, 360 }, -- Dire Maul, East
		{ "B",  10002, 324, 228 }, -- Dire Maul, East
		{ "C",  10003, 255, 124 }, -- Dire Maul, North
		{ "D",  10004, 169, 244 }, -- Dire Maul, West
		{ "D",  10004, 169, 278 }, -- Dire Maul, West
		{ "1'", 10005, 131, 377 }, -- Dire Pool
		{ "2'", 10006, 246, 238 }, -- Dire Maul Arena
	},
	DireMaulEast = {
		{ 1,    404,   212, 109 }, -- Lethtendris
		{ 2,    403,   352, 401 }, -- Hydrospawn
		{ 3,    402,   384, 415 }, -- Zevrim Thornhoof
		{ 4,    405,   376, 213 }, -- Alzzin the Wildshaper
		{ "A",  10001, 12,  86 },
		{ "B",  10002, 43,  260 },
		{ "C",  10003, 495, 119 },
		{ "D",  10004, 234, 165 },
		{ "D",  10004, 402, 452 },
		{ "E",  10005, 190, 330 },
		{ "1'", 10006, 45,  60 },
		{ "2'", 10007, 387, 101 },
		{ "3'", 10008, 265, 427 },
	},
	DireMaulNorth = {
		{ 1,   411,   406, 365 }, -- Guard Mol'dar
		{ 2,   412,   348, 318 }, -- Stomper Kreeg
		{ 3,   413,   240, 383 }, -- Guard Fengus
		{ 4,   414,   50,  253 }, -- Guard Slip'kik
		{ 5,   415,   88,  225 }, -- Captain Kromcrush
		{ 6,   417,   88,  91 }, -- King Gordok
		{ "A", 10001, 418, 471 },
	},
	DireMaulWest = {
		{ 1,    406,   287, 347 }, -- Tendris Warpwood
		{ 2,    408,   386, 127 }, -- Magister Kalendris
		{ 3,    407,   245, 410 }, -- Illyanna Ravenoak
		{ 4,    409,   102, 218 }, -- Immol'thar
		{ 5,    410,   231, 111 }, -- Prince Tortheldrin
		{ "A",  10001, 495, 340 },
		{ "A",  10001, 495, 378 },
		{ "B",  10002, 299, 162 },
		{ "B",  10002, 280, 323 },
		{ "C",  10002, 288, 391 },
		{ "C",  10002, 441, 198 },
		{ "D",  10002, 467, 104 },
		{ "D",  10002, 327, 300 },
		{ "E",  10002, 411, 75 },
		{ "E",  10002, 261, 270 },
		{ "1",  10008, 393, 85 },
		{ "1'", 10003, 475, 337 },
		{ "2'", 10004, 422, 350 },
		{ "2'", 10004, 320, 280 },
		{ "2'", 10004, 320, 413 },
		{ "2'", 10004, 150, 146 },
		{ "2'", 10004, 150, 296 },
		{ "3'", 10005, 408, 364 },
		{ "4'", 10006, 346, 345 },
		{ "5'", 10007, 327, 115 },
	},
	Maraudon = {
		{ 1,    423,   264, 13 }, -- Noxxion
		{ 2,    424,   193, 73 }, -- Razorlash
		{ 3,    427,   271, 159 }, -- Lord Vyletongue
		{ 4,    425,   316, 124 }, -- Tinkerer Gizlock
		{ 5,    428,   160, 164 }, -- Celebras the Cursed
		{ 6,    429,   262, 306 }, -- Landslide
		{ 7,    430,   266, 440 }, -- Rotgrip
		{ 8,    431,   169, 430 }, -- Princess Theradras
		{ "A",  10001, 362, 65 },
		{ "B",  10002, 425, 157 },
		{ "C",  10003, 182, 285 },
		{ "1",  10004, 223, 183 },
		{ "1'", 10005, 327, 487 },
	},
	MaraudonEnt = {
		{ "A",  10001, 126, 291 }, -- Entrance
		{ "B",  10002, 223, 63 }, -- Maraudon, Purple
		{ "C",  10003, 429, 387 }, -- Maraudon, Orange
		{ "D",  10004, 135, 238 }, -- Maraudon, Portal, Lower
		{ "1'", 10005, 57,  298 }, -- Kherrah, Lower
	},
	RagefireChasm = {
		{ 1,    694,   429, 342 }, -- Adarogg
		{ 2,    695,   277, 151 }, -- Dark Shaman Koranthal
		{ 3,    696,   182, 299 }, -- Slagmaw
		{ 4,    697,   153, 444 }, -- Lava Guard Gordoth
		{ "A",  10001, 352, 10 },
		{ "1'", 10002, 436, 39 },
		{ "2'", 10003, 132, 425 },
	},
	CL_RazorfenDowns = {
		{ 1, 432, 260, 184 }, -- Tuten'kash
		{ 3, 433, 430, 241 }, -- Mordresh Fire Eye
		{ 4, 434, 93,  328 }, -- Glutton
		{ 6, 435, 165, 290 }, -- Amnennar the Coldbringer
	},
	CL_RazorfenKraul = {
		{ 2, 439, 432, 260 }, -- Aggem Thorncurse
		{ 3, 438, 471, 213 }, -- Death Speaker Jargba
		{ 4, 440, 301, 165 }, -- Warlord Ramtusk
		{ 5, 441, 58,  320 }, -- Agathelos the Raging
		{ 7, 442, 129, 165 }, -- Charlga Razorflank
	},
	WailingCaverns = {
		{ 1,    474,   196, 229 }, -- Lady Anacondra
		{ 2,    476,   121, 225 }, -- Lord Pythas
		{ 3,    475,   99,  306 }, -- Lord Cobrahn
		{ 4,    478,   395, 335 }, -- Skum
		{ 5,    479,   424, 255 }, -- Lord Serpentis
		{ 6,    480,   370, 231 }, -- Verdan the Everliving
		{ 7,    481,   212, 116 }, -- Mutanus the Devourer
		{ "1",  477,   234, 194 },
		{ "A",  10001, 297, 301 },
		{ "2",  10002, 359, 316 },
		{ "1'", 10003, 306, 281 },

	},
	WailingCavernsEnt = {
		{ "A", 10001, 52,  394 }, -- Entrance
		{ "B", 10002, 263, 325 }, -- Wailing Caverns
		{ "1", 10003, 332, 190 }, -- Trigore the Lasher
	},
	ZulFarrak = {
		{ 1,    483,   178, 218 }, -- Gahz'rilla
		{ 3,    487,   166, 112 }, -- Nekrum Gutchewer and Shadow Priest Sezz'ziz
		{ 4,    489,   260, 190 }, -- Chief Ukorz Sandscalp
		{ 5,    486,   259, 101 }, -- Witch Doctor Zum'rah
		{ 6,    484,   399, 147 }, -- Antu'sul
		{ 2,    482,   160, 197 }, -- Hydromancer Velratha
		{ 3,    485,   324, 150 }, -- Theka the Martyr
		{ "A",  10001, 338, 424 },
		{ "1",  10002, 264, 261 },
		{ "4",  10003, 183, 114 },
		{ "5",  10004, 296, 219 },
		{ "1'", 10005, 197, 206 },
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
	[BZ["Blackrock Mountain"]] = "BlackrockMountainEnt",
	[BZ["Blackrock Spire"]] = "LowerBlackrockSpire",
	[BZ["Hall of Blackhand"]] = "LowerBlackrockSpire",
	[BZ["Dire Maul"]] = "DireMaulNorth",
	[BZ["Stratholme"]] = "StratholmeGauntlet",
	[BZ["The Deadmines"]] = "TheDeadminesA",
	[BZ["The Wailing Caverns"]] = "WailingCavernsEnt",
	[BZ["Sunken Temple"]] = "TheSunkenTemple",
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
	-- Blackrock Spire
	[BZ["Hall of Blackhand"]] = {
		-- Lower Blackrock Spire
		["LowerBlackrockSpire"] = {
			BZ["Hordemar City"],
			BZ["Mok'Doom"],
			BZ["Tazz'Alor"],
			BZ["Skitterweb Tunnels"],
			BZ["The Storehouse"],
			BZ["Halycon's Lair"],
			BZ["Chamber of Battle"],
		},
	},
	-- Dire Maul
	[BZ["Dire Maul"]] = {
		-- Dire Maul, Entrance
		["DireMaulEnt"] = {
			BZ["Broken Commons"],
			-- Comment out below as they are currently redundant due to the Zone is Feralas
			--BZ["Eldreth Row"],
			--BZ["The Maul"],
		},
		-- Dire Maul, North
		["DireMaulNorth"] = {
			BZ["Halls of Destruction"],
			BZ["Gordok's Seat"],
		},
		-- Dire Maul, East
		["DireMaulEast"] = {
			BZ["Warpwood Quarter"],
			BZ["The Hidden Reach"],
			BZ["The Conservatory"],
			BZ["The Shrine of Eldretharr"],
		},
		-- Dire Maul, West
		["DireMaulWest"] = {
			BZ["Capital Gardens"],
			BZ["Court of the Highborne"],
			BZ["Prison of Immol'thar"],
			BZ["The Athenaeum"],
		},
	},
	-- Stratholme
	[BZ["Stratholme"]] = {
		-- Stratholme - Crusader's Square
		["StratholmeCrusader"] = {
			BZ["King's Square"],
			BZ["Festival Lane"],
			BZ["Market Row"],
			BZ["Crusaders' Square"],
			BZ["The Scarlet Bastion"],
			BZ["The Hall of Lights"],
			BZ["The Hoard"],
			BZ["The Crimson Throne"],
		},
		-- Stratholme - The Gauntlet
		["StratholmeGauntlet"] = {
			BZ["Elders' Square"],
			BZ["The Gauntlet"],
			BZ["Slaughter Square"],
			BZ["The Slaughter House"],
		},
	},
	-- The Deadmines
	[BZ["The Deadmines"]] = {
		["TheDeadminesA"] = {
			BZ["Goblin Foundry"],
			BZ["Mast Room"],
		},
		["TheDeadminesB"] = {
			BZ["Ironclad Cove"],
		},
	},
	-- The Stockade
	[BZ["The Stockade"]] = {
		-- The Stockade
		["TheStockade"] = {
			BZ["Stormwind Stockade"],
		},
	},
	-- Wailing Caverns
	[BZ["Wailing Caverns"]] = {
		-- Wailing Caverns, Entrance
		["WailingCavernsEnt"] = {
			BZ["Cavern of Mists"],
		},
		-- Wailing Caverns
		["WailingCaverns"] = {
			BZ["Screaming Gully"],
			BZ["Dreamer's Rock"],
			BZ["Pit of Fangs"],
			BZ["Crag of the Everliving"],
			BZ["Pit of Fangs"],
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
	[BZ["Burning Steppes"]] = "BlackrockMountainEnt", -- Classic WoW, Catalysm, Draenor
	[BZ["Searing Gorge"]] = "BlackrockMountainEnt", -- Classic WoW, Catalysm, Draenor
	[BZ["Ashenvale"]] = "BlackfathomDeepsEnt",
	[BZ["Feralas"]] = "DireMaulEnt",
	[BZ["Dun Morogh"]] = "GnomereganEnt",
	[BZ["Desolace"]] = "MaraudonEnt",
	[BZ["Orgrimmar"]] = "RagefireChasm",
	[BZ["Thousand Needles"]] = "CL_RazorfenDowns",
	[BZ["Southern Barrens"]] = "CL_RazorfenKraul",
	[BZ["Silverpine Forest"]] = "ShadowfangKeep", -- also in Catalysm
	[BZ["Tirisfal Glades"]] = "ScarletMonasteryEnt", -- also in MoP
	[BZ["Western Plaguelands"]] = "Scholomance",  -- also in MoP
	[BZ["Eastern Plaguelands"]] = "StratholmeGauntlet",
	[BZ["Westfall"]] = "TheDeadminesEnt",
	[BZ["Stormwind City"]] = "TheStockade",
	[BZ["Swamp of Sorrows"]] = "TheSunkenTempleEnt",
	[BZ["Ahn'Qiraj: The Fallen Kingdom"]] = "TheTempleofAhnQiraj",
	[BZ["Silithus"]] = "TheTempleofAhnQiraj",
	[BZ["Badlands"]] = "UldamanEnt",
	[BZ["Northern Barrens"]] = "WailingCavernsEnt",
	[BZ["Tanaris"]] = "ZulFarrak",
}

-- Yes, the following two tables are redundant, but they're both here in case there's ever more than one entrance map for an instance
-- Entrance maps to instance maps
db.EntToInstMatches = {
	["BlackfathomDeepsEnt"] = { "CL_BlackfathomDeepsA", "CL_BlackfathomDeepsB", "CL_BlackfathomDeepsC" },
	["BlackrockMountainEnt"] = { "BlackrockDepths", "BlackwingLair", "LowerBlackrockSpire", "MoltenCore" },
	["DireMaulEnt"] = { "DireMaulEast", "DireMaulNorth", "DireMaulWest" },
	["GnomereganEnt"] = { "Gnomeregan" },
	["MaraudonEnt"] = { "Maraudon" },
	["TheDeadminesEnt"] = { "TheDeadminesA", "TheDeadminesB" },
	["TheSunkenTempleEnt"] = { "TheSunkenTemple" },
	["UldamanEnt"] = { "Uldaman" },
	["WailingCavernsEnt"] = { "WailingCaverns" },
}

-- Instance maps to entrance maps
db.InstToEntMatches = {
	["CL_BlackfathomDeepsA"] = { "BlackfathomDeepsEnt" },
	["CL_BlackfathomDeepsB"] = { "BlackfathomDeepsEnt" },
	["CL_BlackfathomDeepsC"] = { "BlackfathomDeepsEnt" },
	["BlackrockDepths"] = { "BlackrockMountainEnt" },
	["BlackwingLair"] = { "BlackrockMountainEnt" },
	["LowerBlackrockSpire"] = { "BlackrockMountainEnt" },
	["MoltenCore"] = { "BlackrockMountainEnt" },
	["DireMaulEast"] = { "DireMaulEnt" },
	["DireMaulNorth"] = { "DireMaulEnt" },
	["DireMaulWest"] = { "DireMaulEnt" },
	["Gnomeregan"] = { "GnomereganEnt" },
	["TheDeadminesA"] = { "TheDeadminesEnt" },
	["TheDeadminesB"] = { "TheDeadminesEnt" },
	["TheSunkenTemple"] = { "TheSunkenTempleEnt" },
	["Uldaman"] = { "UldamanEnt" },
	["WailingCaverns"] = { "WailingCavernsEnt" },
}

db.MapSeries = {
	["CL_BlackfathomDeepsA"] = { "CL_BlackfathomDeepsA", "CL_BlackfathomDeepsB", "CL_BlackfathomDeepsC" },
	["CL_BlackfathomDeepsB"] = { "CL_BlackfathomDeepsA", "CL_BlackfathomDeepsB", "CL_BlackfathomDeepsC" },
	["CL_BlackfathomDeepsC"] = { "CL_BlackfathomDeepsA", "CL_BlackfathomDeepsB", "CL_BlackfathomDeepsC" },
}

-- Links maps together that are part of the same instance
db.SubZoneAssoc = {
	["DireMaulNorth"] = BZ["Dire Maul"],
	["DireMaulEast"] = BZ["Dire Maul"],
	["DireMaulWest"] = BZ["Dire Maul"],
	["DireMaulEnt"] = BZ["Dire Maul"],
	["StratholmeCrusader"] = BZ["Stratholme"],
	["StratholmeGauntlet"] = BZ["Stratholme"],
	["TheDeadminesA"] = BZ["The Deadmines"],
	["TheDeadminesB"] = BZ["The Deadmines"],
	["CL_BlackfathomDeepsA"] = BZ["Blackfathom Deeps"],
	["CL_BlackfathomDeepsB"] = BZ["Blackfathom Deeps"],
	["CL_BlackfathomDeepsC"] = BZ["Blackfathom Deeps"],
}

db.DropDownLayouts_Order = {
	[ATLAS_DDL_CONTINENT] = {
		ATLAS_DDL_CONTINENT_EASTERN,
		ATLAS_DDL_CONTINENT_KALIMDOR,
	},
	[ATLAS_DDL_LEVEL] = {
		ATLAS_DDL_LEVEL_10TO20,
		ATLAS_DDL_LEVEL_20TO40,
		ATLAS_DDL_LEVEL_40TO60,
	},
	[ATLAS_DDL_EXPANSION] = {
		ATLAS_DDL_EXPANSION_OLD,
	},
}

db.DropDownLayouts = {
	[ATLAS_DDL_CONTINENT] = {
		[ATLAS_DDL_CONTINENT_EASTERN] = {
			"BlackrockMountainEnt", -- Classic WoW, Catalysm, Draenor
			"BlackrockDepths", -- Classic WoW
			"BlackwingLair", -- Classic WoW
			"TheDeadminesA", -- Classic WoW, Catalysm
			"TheDeadminesB", -- Classic WoW, Catalysm
			"TheDeadminesEnt", -- Classic WoW, Catalysm
			"Gnomeregan",  -- Classic WoW
			"GnomereganEnt", -- Classic WoW
			"LowerBlackrockSpire", -- Classic WoW
			"MoltenCore",  -- Classic WoW
			"ShadowfangKeep", -- Classic WoW, Catalysm
			"StratholmeCrusader", -- Classic WoW
			"StratholmeGauntlet", -- Classic WoW
			"TheStockade", -- Classic WoW
			"TheSunkenTemple", -- Classic WoW
			"TheSunkenTempleEnt", -- Classic WoW
			"Uldaman",     -- Classic WoW
			"UldamanEnt",  -- Classic WoW
			"CL_BlackrockSpireUpper",
			"Scholomance", -- Mop, Classic WoW
			"ScarletMonasteryEnt", -- Mop, Classic WoW
			"ScarletHalls", -- Mop, Classic WoW
			"ScarletMonastery", -- Mop, Classic WoW
		},
		[ATLAS_DDL_CONTINENT_KALIMDOR] = {
			"CL_BlackfathomDeepsA",
			"CL_BlackfathomDeepsB",
			"CL_BlackfathomDeepsC",
			"BlackfathomDeepsEnt", -- Classic WoW
			"DireMaulEast", -- Classic WoW
			"DireMaulEnt", -- Classic WoW
			"DireMaulNorth", -- Classic WoW
			"DireMaulWest", -- Classic WoW
			"Maraudon",   -- Classic WoW
			"MaraudonEnt", -- Classic WoW
			"RagefireChasm", -- Classic WoW
			"CL_RazorfenDowns", -- Classic WoW
			"CL_RazorfenKraul", -- Classic WoW
			"TheRuinsofAhnQiraj", -- Classic WoW
			"TheTempleofAhnQiraj", -- Classic WoW
			"WailingCaverns", -- Classic WoW
			"WailingCavernsEnt", -- Classic WoW
			"ZulFarrak",  -- Classic WoW
		},
	},
	[ATLAS_DDL_EXPANSION] = {
		[ATLAS_DDL_EXPANSION_OLD] = {
			"CL_BlackfathomDeepsA",
			"CL_BlackfathomDeepsB",
			"CL_BlackfathomDeepsC",
			"BlackfathomDeepsEnt",
			"BlackrockMountainEnt",
			"BlackrockDepths",
			"BlackwingLair",
			"DireMaulEast",
			"DireMaulEnt",
			"DireMaulNorth",
			"DireMaulWest",
			"Gnomeregan",
			"GnomereganEnt",
			"LowerBlackrockSpire",
			"Maraudon",
			"MaraudonEnt",
			"MoltenCore",
			"TheDeadminesA", -- Classic WoW, Catalysm
			"TheDeadminesB", -- Classic WoW, Catalysm
			"TheDeadminesEnt",
			"TheTempleofAhnQiraj",
			"TheRuinsofAhnQiraj",
			"RagefireChasm",
			"CL_RazorfenDowns",
			"CL_RazorfenKraul",
			"Scholomance",
			"ShadowfangKeep",
			"ScarletMonasteryEnt",
			"ScarletHalls",
			"ScarletMonastery",
			"StratholmeCrusader",
			"StratholmeGauntlet",
			"TheStockade",
			"TheSunkenTemple",
			"TheSunkenTempleEnt",
			"Uldaman",
			"UldamanEnt",
			"CL_BlackrockSpireUpper",
			"WailingCaverns",
			"WailingCavernsEnt",
			"ZulFarrak",
		},
	},
	[ATLAS_DDL_LEVEL] = {
		[ATLAS_DDL_LEVEL_10TO20] = {
			"RagefireChasm",
			"TheDeadminesA",
			"TheDeadminesB",
			"TheDeadminesEnt",
			"WailingCaverns",
			"WailingCavernsEnt",
		},
		[ATLAS_DDL_LEVEL_20TO40] = {
			"CL_BlackfathomDeepsA",
			"CL_BlackfathomDeepsB",
			"CL_BlackfathomDeepsC",
			"BlackfathomDeepsEnt",
			"Gnomeregan",
			"GnomereganEnt",
			"RagefireChasm",
			"ShadowfangKeep",
			"TheDeadminesA",
			"TheDeadminesB",
			"TheDeadminesEnt",
			"TheStockade",
			"WailingCaverns",
			"WailingCavernsEnt",
			"CL_RazorfenDowns",
			"CL_RazorfenKraul",
			"ScarletMonasteryEnt",
			"ScarletHalls",
			"ScarletMonastery",
		},
		[ATLAS_DDL_LEVEL_40TO60] = {
			"CL_RazorfenDowns",
			"CL_RazorfenKraul",
			"ScarletMonasteryEnt",
			"ScarletHalls",
			"ScarletMonastery",
			"BlackrockMountainEnt",
			"BlackrockDepths",
			"LowerBlackrockSpire",
			"DireMaulEast",
			"DireMaulEnt",
			"DireMaulNorth",
			"DireMaulWest",
			"Maraudon",
			"MaraudonEnt",
			"Scholomance",
			"StratholmeCrusader",
			"StratholmeGauntlet",
			"TheSunkenTemple",
			"TheSunkenTempleEnt",
			"Uldaman",
			"UldamanEnt",
			"CL_BlackrockSpireUpper",
			"ZulFarrak",
			"BlackwingLair",
			"MoltenCore",
			"TheRuinsofAhnQiraj",
			"TheTempleofAhnQiraj",
		},
	},
	[ATLAS_DDL_PARTYSIZE] = {
		[ATLAS_DDL_PARTYSIZE_5] = {
			"BlackrockMountainEnt", -- Classic WoW
			"CL_BlackfathomDeepsA",
			"CL_BlackfathomDeepsB",
			"CL_BlackfathomDeepsC",
			"BlackfathomDeepsEnt", -- Classic WoW
			"BlackrockDepths", -- Classic WoW
			"LowerBlackrockSpire", -- Classic WoW
			"TheDeadminesA", -- Classic WoW
			"TheDeadminesB", -- Classic WoW
			"TheDeadminesEnt", -- Classic WoW
			"DireMaulEast", -- Classic WoW
			"DireMaulEnt", -- Classic WoW
			"DireMaulNorth", -- Classic WoW
			"DireMaulWest", -- Classic WoW
			"Gnomeregan", -- Classic WoW
			"GnomereganEnt", -- Classic WoW
			"Maraudon",   -- Classic WoW
			"MaraudonEnt", -- Classic WoW
			"RagefireChasm", -- Classic WoW
			"CL_RazorfenDowns", -- Classic WoW
			"CL_RazorfenKraul", -- Classic WoW
			"ScarletHalls", -- Classic WoW
			"ScarletMonastery", -- Classic WoW
			"ScarletMonasteryEnt", -- Classic WoW
			"Scholomance", -- Classic WoW
			"ShadowfangKeep", -- Classic WoW
			"TheStockade", -- Classic WoW
			"StratholmeCrusader", -- Classic WoW
			"StratholmeGauntlet", -- Classic WoW
			"TheSunkenTemple", -- Classic WoW
			"TheSunkenTempleEnt", -- Classic WoW
			"Uldaman",    -- Classic WoW
			"UldamanEnt", -- Classic WoW
			"CL_BlackrockSpireUpper",
			"WailingCaverns", -- Classic WoW
			"WailingCavernsEnt", -- Classic WoW
			"ZulFarrak",  -- Classic WoW
		},
		[ATLAS_DDL_PARTYSIZE_10] = {
			"TheRuinsofAhnQiraj", -- Classic WoW
		},
		[ATLAS_DDL_PARTYSIZE_20TO40] = {
			"BlackrockMountainEnt", -- Classic WoW
			"BlackwingLair", -- Classic WoW
			"MoltenCore",  -- Classic WoW
			"TheTempleofAhnQiraj", -- Classic WoW
		},
	},
	[ATLAS_DDL_TYPE] = {
		[ATLAS_DDL_TYPE_INSTANCE] = {
			"CL_BlackfathomDeepsA",
			"CL_BlackfathomDeepsB",
			"CL_BlackfathomDeepsC",
			"BlackrockDepths", -- Classic WoW
			"BlackwingLair", -- Classic WoW
			"LowerBlackrockSpire", -- Classic WoW
			"TheRuinsofAhnQiraj", -- Classic WoW
			"TheTempleofAhnQiraj", -- Classic WoW
			"TheDeadminesA", -- Classic WoW
			"TheDeadminesB", -- Classic WoW
			"DireMaulEast", -- Classic WoW
			"DireMaulNorth", -- Classic WoW
			"DireMaulWest", -- Classic WoW
			"Gnomeregan", -- Classic WoW
			"Maraudon",   -- Classic WoW
			"MoltenCore", -- Classic WoW
			"RagefireChasm", -- Classic WoW
			"CL_RazorfenDowns", -- Classic WoW
			"CL_RazorfenKraul", -- Classic WoW
			"ScarletHalls", -- Classic WoW
			"ScarletMonastery", -- Classic WoW
			"Scholomance", -- Classic WoW
			"ShadowfangKeep", -- Classic WoW
			"StratholmeCrusader", -- Classic WoW
			"StratholmeGauntlet", -- Classic WoW
			"TheStockade", -- Classic WoW
			"TheSunkenTemple", -- Classic WoW
			"Uldaman",    -- Classic WoW
			"CL_BlackrockSpireUpper",
			"WailingCaverns", -- Classic WoW
			"ZulFarrak",  -- Classic WoW
		},
		[ATLAS_DDL_TYPE_ENTRANCE] = {
			"BlackrockMountainEnt", -- Classic WoW
			"TheDeadminesEnt", -- Classic WoW
			"ScarletMonasteryEnt", -- Classic WoW
			"BlackfathomDeepsEnt", -- Classic WoW
			"DireMaulEnt", -- Classic WoW
			"GnomereganEnt", -- Classic WoW
			"MaraudonEnt", -- Classic WoW
			"TheSunkenTempleEnt", -- Classic WoW
			"UldamanEnt",  -- Classic WoW
			"WailingCavernsEnt", -- Classic WoW
		},
	},
}
