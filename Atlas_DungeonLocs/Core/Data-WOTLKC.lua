-- $Id: Data-WOTLKC.lua 102 2022-08-27 09:58:37Z arithmandar $
--[[

	Atlas, a World of Warcraft instance map browser
	Copyright 2005 ~ 2010 - Dan Gilbert <dan.b.gilbertat gmail dot com>
	Copyright 2010 - Lothaer <lothayerat gmail dot com>, Atlas Team
	Copyright 2011 ~ 2022 - Arith Hsu, Atlas Team <atlas.addon at gmail dot com>

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
local _G = getfenv(0)

-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local FOLDER_NAME, private = ...

local LibStub = _G.LibStub

local BZ = Atlas_GetLocaleLibBabble("LibBabble-SubZone-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale(private.addon_name)
local ALC = LibStub("AceLocale-3.0"):GetLocale("Atlas")

local data = {}
local alliance = {}
local horde = {}
private.data = data
private.alliance = alliance
private.horde = horde

local BLUE = "|cff6666ff"
local GREN = "|cff66cc33"
local LBLU = "|cff33cccc"
local _RED = "|cffcc3333"
local ORNG = "|cffcc9933"
local PINK = "|ccfcc33cc"
local PURP = "|cff9900ff"
local WHIT = "|cffffffff"
local GREY = "|cff999999"
local YLOW = "|cffcccc33"
local ALAN = "|cff7babe0" -- Alliance
local HRDE = "|cffda6955" -- Horde
local INDENT = "      "

alliance.maps = {}
alliance.coords = {}
horde.maps = {}
horde.coords = {}

data.maps = {
	DLEast_BCC = {
		ZoneName = { BZ["Eastern Kingdoms"] },
		{ BLUE.." A) "..BZ["Alterac Valley"]..ALC["Comma"].._RED..BZ["Hillsbrad Foothills"], 20001 },
		{ BLUE.." B) "..BZ["Arathi Basin"]..ALC["Comma"].._RED..BZ["Arathi Highlands"], 20002 },
		{ WHIT.." 1) "..BZ["Magisters' Terrace"]..ALC["Comma"].._RED..BZ["Isle of Quel'Danas"], 10001 },
		{ WHIT..INDENT..BZ["Sunwell Plateau"]..ALC["Comma"].._RED..BZ["Isle of Quel'Danas"] },
		{ WHIT.." 2) "..BZ["Zul'Aman"]..ALC["Comma"].._RED..BZ["Ghostlands"], 10002 },
		{ WHIT.." 3) "..BZ["Scarlet Monastery"]..ALC["Comma"].._RED..BZ["Tirisfal Glades"], 10003 },
		{ WHIT.." 4) "..BZ["Stratholme"]..ALC["Comma"].._RED..BZ["Eastern Plaguelands"], 10004 },
		{ WHIT.." 5) "..BZ["Scholomance"]..ALC["Comma"].._RED..BZ["Western Plaguelands"], 10005 },
		{ WHIT.." 6) "..BZ["Shadowfang Keep"]..ALC["Comma"].._RED..BZ["Silverpine Forest"], 10006 },
		{ WHIT.." 7) "..BZ["Gnomeregan"]..ALC["Comma"].._RED..BZ["Dun Morogh"], 10007 },
		{ WHIT.." 8) "..BZ["Uldaman"]..ALC["Comma"].._RED..BZ["Badlands"], 10008 },
		{ WHIT.." 9) "..BZ["Blackrock Mountain"]..ALC["Comma"].._RED..BZ["Searing Gorge"]..ALC["Slash"]..BZ["Burning Steppes"], 10009 },
		{ WHIT..INDENT..BZ["Blackrock Depths"] },
		{ WHIT..INDENT..BZ["Blackrock Spire"] },
		{ WHIT..INDENT..BZ["The Molten Core"] },
		{ WHIT..INDENT..BZ["Blackwing Lair"] },
		{ WHIT.."10) "..BZ["The Stockade"]..ALC["Comma"].._RED..BZ["Stormwind City"], 10010 },
		{ WHIT.."11) "..BZ["The Deadmines"]..ALC["Comma"].._RED..BZ["Westfall"], 10011 },
		{ WHIT.."12) "..BZ["Zul'Gurub"]..ALC["Comma"].._RED..BZ["Northern Stranglethorn"], 10012 },
		{ WHIT.."13) "..BZ["Sunken Temple"]..ALC["Comma"].._RED..BZ["Swamp of Sorrows"], 10013 },
		{ WHIT.."14) "..BZ["Karazhan"]..ALC["Comma"].._RED..BZ["Deadwind Pass"], 10014 },
		{ "" },
		{ BLUE..L["Blue"]..ALC["Colon"]..ORNG..BATTLEGROUNDS },
		{ WHIT..L["White"]..ALC["Colon"]..ORNG..L["Instances"] },
	},
	DLWest_BCC = {
		ZoneName = { BZ["Kalimdor"] },
		{ BLUE.." A) "..BZ["Warsong Gulch"]..ALC["Comma"].._RED..BZ["Ashenvale"], 20001 },
		{ WHIT.." 1) "..BZ["Blackfathom Deeps"]..ALC["Comma"].._RED..BZ["Ashenvale"], 10001 },
		{ WHIT.." 2) "..BZ["Ragefire Chasm"]..ALC["Comma"].._RED..BZ["Orgrimmar"], 10002 },
		{ WHIT.." 3) "..BZ["Wailing Caverns"]..ALC["Comma"].._RED..BZ["Northern Barrens"], 10003 },
		{ WHIT.." 4) "..BZ["Maraudon"]..ALC["Comma"].._RED..BZ["Desolace"], 10004 },
		{ WHIT.." 5) "..BZ["Dire Maul"]..ALC["Comma"].._RED..BZ["Feralas"], 10005 },
		{ WHIT.." 6) "..BZ["Razorfen Kraul"]..ALC["Comma"].._RED..BZ["Southern Barrens"], 10006 },
		{ WHIT.." 7) "..BZ["Razorfen Downs"]..ALC["Comma"].._RED..BZ["Thousand Needles"], 10007 },
		{ WHIT.." 8) "..BZ["Onyxia's Lair"]..ALC["Comma"].._RED..BZ["Dustwallow Marsh"], 10008 },
		{ WHIT.." 9) "..BZ["Zul'Farrak"]..ALC["Comma"].._RED..BZ["Tanaris"], 10009 },
		{ WHIT.."10) "..BZ["Temple of Ahn'Qiraj"]..ALC["Comma"].._RED..BZ["Silithus"], 10010 },
		{ WHIT.."11) "..BZ["Ruins of Ahn'Qiraj"]..ALC["Comma"].._RED..BZ["Silithus"], 10011 },
		{ WHIT.."12) "..BZ["Caverns of Time"]..", ".._RED..BZ["Tanaris"], 10012 };
		{ WHIT..INDENT..BZ["Old Hillsbrad Foothills"] };
		{ WHIT..INDENT..BZ["The Black Morass"] };
		{ WHIT..INDENT..BZ["Hyjal Summit"] };
		{ WHIT..INDENT..BZ["The Culling of Stratholme"] },
		{ "" },
		{ BLUE..L["Blue"]..ALC["Colon"]..ORNG..BATTLEGROUNDS },
		{ WHIT..L["White"]..ALC["Colon"]..ORNG..L["Instances"] },
	},
	DLOutland_BCC = {
		ZoneName = { BZ["Outland"] },
		{ WHIT.." 1) "..BZ["Gruul's Lair"]..ALC["Comma"].._RED..BZ["Blade's Edge Mountains"], 10001 },
		{ WHIT.." 2) "..BZ["Tempest Keep"]..ALC["Comma"].._RED..BZ["Netherstorm"], 10002 },
		{ WHIT..INDENT..BZ["The Mechanar"] },
		{ WHIT..INDENT..BZ["The Botanica"] },
		{ WHIT..INDENT..BZ["The Arcatraz"] },
		{ WHIT..INDENT..BZ["Tempest Keep"] },
		{ WHIT.." 3) "..BZ["Coilfang Reservoir"]..ALC["Comma"].._RED..BZ["Zangarmarsh"], 10003 },
		{ WHIT..INDENT..BZ["The Slave Pens"] },
		{ WHIT..INDENT..BZ["The Underbog"] },
		{ WHIT..INDENT..BZ["The Steamvault"] },
		{ WHIT..INDENT..BZ["Serpentshrine Cavern"] },
		{ WHIT.." 4) "..BZ["Hellfire Citadel"]..ALC["Comma"].._RED..BZ["Hellfire Peninsula"], 10004 },
		{ WHIT..INDENT..BZ["Hellfire Ramparts"] },
		{ WHIT..INDENT..BZ["The Blood Furnace"] },
		{ WHIT..INDENT..BZ["The Shattered Halls"] },
		{ WHIT..INDENT..BZ["Magtheridon's Lair"] },
		{ WHIT.." 5) "..BZ["Auchindoun"]..ALC["Comma"].._RED..BZ["Terokkar Forest"], 10005 },
		{ WHIT..INDENT..BZ["Mana-Tombs"] },
		{ WHIT..INDENT..BZ["Auchenai Crypts"] },
		{ WHIT..INDENT..BZ["Sethekk Halls"] },
		{ WHIT..INDENT..BZ["Shadow Labyrinth"] },
		{ WHIT.." 6) "..BZ["Black Temple"]..ALC["Comma"].._RED..BZ["Shadowmoon Valley"], 10006 },
	},
	DLNorthrend = {
		ZoneName = { BZ["Northrend"] },
		LargeMap = "DLNorthrend",
		{ WHIT.." 1) "..BZ["Ulduar"]..ALC["Comma"].._RED..BZ["The Storm Peaks"], 10001 },
		{ WHIT..INDENT..BZ["Ulduar"] },
		{ WHIT..INDENT..BZ["Halls of Stone"] },
		{ WHIT..INDENT..BZ["Halls of Lightning"] },
		{ WHIT.." 2) "..ALC["Crusaders' Coliseum"]..ALC["Comma"].._RED..BZ["Icecrown"], 10002 },
		{ WHIT..INDENT..BZ["Trial of the Crusader"] },
		{ WHIT..INDENT..BZ["Trial of the Champion"] },
		{ WHIT.." 3) "..BZ["Gundrak"]..ALC["Comma"].._RED..BZ["Zul'Drak"], 10003 },
		{ WHIT.." 4) "..BZ["Icecrown Citadel"]..ALC["Comma"].._RED..BZ["Icecrown"], 10004 },
		{ WHIT..INDENT..BZ["Icecrown Citadel"] },
		{ WHIT..INDENT..BZ["The Frozen Halls"] },		
		{ WHIT..INDENT..INDENT..BZ["The Forge of Souls"] },
		{ WHIT..INDENT..INDENT..BZ["Pit of Saron"] },
		{ WHIT..INDENT..INDENT..BZ["Halls of Reflection"] },
		{ WHIT.." 5) "..BZ["The Violet Hold"]..ALC["Comma"].._RED..BZ["Dalaran"], 10005 },
		{ WHIT.." 6) "..BZ["Vault of Archavon"]..ALC["Comma"].._RED..BZ["Wintergrasp"], 10006 },
		{ WHIT.." 7) "..BZ["Drak'Tharon Keep"]..ALC["Comma"].._RED..BZ["Grizzly Hills"], 10007 },
		{ WHIT.." 8) "..BZ["The Nexus"]..ALC["Comma"].._RED..BZ["Coldarra"], 10008 },
		{ WHIT..INDENT..BZ["The Nexus"] },
		{ WHIT..INDENT..BZ["The Oculus"] },
		{ WHIT..INDENT..BZ["The Eye of Eternity"] },
		{ WHIT.." 9) "..BZ["Azjol-Nerub"]..ALC["Comma"].._RED..BZ["Dragonblight"], 10009 },
		{ WHIT..INDENT..BZ["Azjol-Nerub"] },
		{ WHIT..INDENT..BZ["Ahn'kahet: The Old Kingdom"] },
		{ WHIT.."10) "..BZ["Wyrmrest Temple"]..ALC["Comma"].._RED..BZ["Dragonblight"], 10010 },
		{ WHIT..INDENT..BZ["The Obsidian Sanctum"] },
		{ WHIT..INDENT..BZ["The Ruby Sanctum"] },
		{ WHIT.."11) "..BZ["Naxxramas"]..ALC["Comma"].._RED..BZ["Dragonblight"], 10011 },
		{ WHIT.."12) "..BZ["Utgarde Keep"]..ALC["Comma"].._RED..BZ["Howling Fjord"], 10012 },
		{ WHIT..INDENT..BZ["Utgarde Keep"] },
		{ WHIT..INDENT..BZ["Utgarde Pinnacle"] },
		{ GREN.." 1') "..BZ["Wintergrasp"]..ALC["Comma"].._RED..BZ["Wintergrasp"], 10013 },
		{ "" },
		{ WHIT..L["White"]..ALC["Colon"]..ORNG..L["Instances"] },
		{ GREN..L["Green"]..ALC["Colon"]..ORNG..BATTLEGROUNDS },
	}
}

data.coords = {
	DLEast_BCC = {
		{ "A", 20001, 227, 201 },
		{ "B", 20002, 268, 236 },
		{ 1, 10001, 293, 33 },
		{ 2, 10002, 308, 128 },
		{ 3, 10003, 227, 159 },
		{ 4, 10004, 278, 150 },
		{ 5, 10005, 258, 186 },
		{ 6, 10006, 184, 212 },
		{ 7, 10007, 197, 303 },
		{ 8, 10008, 274, 325 },
		{ 9, 10009, 241, 350 },
		{ 10, 10010, 195, 371 },
		{ 11, 10011, 183, 417 },
		{ 12, 10012, 239, 425 },
		{ 13, 10013, 276, 400 },
		{ 14, 10014, 256, 409 },
	},
	DLOutland = {
		{ "1", 10001, 224,  78, 424, 116, "Raid" }, -- Gruul's Lair
		{ "2", 10002, 410, 102, 659, 148, "Raid" }, -- Tempest Keep
		{ "3", 10003, 146, 219, 336, 292, "Raid" }, -- Coilfang Reservoir
		{ "4", 10004, 324, 259, 555, 340, "Raid" }, -- Hellfire Citadel
		{ "5", 10005, 239, 400, 448, 515, "Raid" }, -- Auchindoun
		{ "6", 10006, 449, 411, 714, 529, "Raid" }, -- Black Temple
	},
}
