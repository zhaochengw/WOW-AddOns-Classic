-- $Id: Data.lua 102 2022-08-27 09:58:37Z arithmandar $
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
local Atlas = LibStub("AceAddon-3.0"):GetAddon("Atlas")

local WoWClassicEra, WoWClassicTBC, WoWRetail
local wowtocversion  = select(4, GetBuildInfo())
if wowtocversion < 20000 then
	WoWClassicEra = true
elseif wowtocversion > 19999 and wowtocversion < 90000 then 
	WoWClassicTBC = true
else
	WoWRetail = true
end

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

alliance.maps = {
	DLKulTiras_Alliance = {
		ZoneName = { BZ["Kul Tiras"]..ALAN..ALC["L-Parenthesis"]..FACTION_ALLIANCE..ALC["R-Parenthesis"] },
		{ WHIT.." 1) "..BZ["Tol Dagor"]..GREY..ALC["Comma"].._RED..BZ["Tol Dagor"], 10001 },
		{ WHIT.." 2) "..BZ["Freehold"]..GREY..ALC["Comma"].._RED..BZ["Tiragarde Sound"], 10002 },
		{ WHIT.." 3) "..BZ["Siege of Boralus"]..GREY..ALC["Comma"].._RED..BZ["Tiragarde Sound"], 10003 },
		{ WHIT.." 4) "..BZ["Battle of Dazar'alor"]..GREY..ALC["Comma"].._RED..BZ["Tiragarde Sound"], 10004 },
		{ WHIT.." 5) "..BZ["Waycrest Manor"]..GREY..ALC["Comma"].._RED..BZ["Drustvar"], 10005 },
		{ WHIT.." 6) "..BZ["Operation: Mechagon"]..GREY..ALC["Comma"].._RED..BZ["Mechagon"], 10006 },
		{ WHIT.." 7) "..BZ["Shrine of the Storm"]..GREY..ALC["Comma"].._RED..BZ["Stormsong Valley"], 10007 },
		{ WHIT.." 8) "..BZ["Crucible of Storms"]..GREY..ALC["Comma"].._RED..BZ["Stormsong Valley"], 10008 },
	},
	DLZandalar_Alliance = {
		ZoneName = { BZ["Zandalar"]..ALAN..ALC["L-Parenthesis"]..FACTION_ALLIANCE..ALC["R-Parenthesis"] },
		{ WHIT.." 1) "..BZ["The MOTHERLODE!!"]..GREY..ALC["Comma"].._RED..BZ["Zuldazar"], 10001 },
		{ WHIT.." 2) "..BZ["Atal'Dazar"]..GREY..ALC["Comma"].._RED..BZ["Zuldazar"], 10002 },
		{ WHIT.." 3) "..BZ["Kings' Rest"]..GREY..ALC["Comma"].._RED..BZ["Zuldazar"], 10003 },
		{ WHIT.." 4) "..BZ["Temple of Sethraliss"]..GREY..ALC["Comma"].._RED..BZ["Vol'dun"], 10004 },
		{ WHIT.." 5) "..BZ["The Underrot"]..GREY..ALC["Comma"].._RED..BZ["Nazmir"], 10005 },
		{ WHIT.." 6) "..BZ["Uldir"]..GREY..ALC["Comma"].._RED..BZ["Nazmir"], 10006 },
	},
}

alliance.coords = {
	DLKulTiras_Alliance = {
		{ 1, 10001, 477, 307 },
		{ 2, 10002, 406, 395 },
		{ 3, 10003, 369, 248 },
		{ 4, 10004, 363, 267 },
		{ 5, 10005, 146, 277 },
		{ 6, 10006, 64, 149 },
		{ 7, 10007, 389, 86 },
		{ 8, 10008, 411, 124 },
	},
	DLZandalar_Alliance = {
		{ 1, 10001, 223, 416 },
		{ 2, 10002, 271, 316 },
		{ 3, 10003, 234, 312 },
		{ 4, 10004, 175, 81 },
		{ 5, 10005, 299, 192 },
		{ 6, 10006, 313, 174 },
	},
}

horde.maps = {
	DLKulTiras_Horde = {
		ZoneName = { BZ["Kul Tiras"]..HRDE..ALC["L-Parenthesis"]..FACTION_HORDE..ALC["R-Parenthesis"] },
		{ WHIT.." 1) "..BZ["Tol Dagor"]..GREY..ALC["Comma"].._RED..BZ["Tol Dagor"], 10001 },
		{ WHIT.." 2) "..BZ["Freehold"]..GREY..ALC["Comma"].._RED..BZ["Tiragarde Sound"], 10002 },
		{ WHIT.." 3) "..BZ["Siege of Boralus"]..GREY..ALC["Comma"].._RED..BZ["Tiragarde Sound"], 10003 },
		{ WHIT.." 4) "..BZ["Waycrest Manor"]..GREY..ALC["Comma"].._RED..BZ["Drustvar"], 10004 },
		{ WHIT.." 5) "..BZ["Operation: Mechagon"]..GREY..ALC["Comma"].._RED..BZ["Mechagon"], 10005 },
		{ WHIT.." 6) "..BZ["Shrine of the Storm"]..GREY..ALC["Comma"].._RED..BZ["Stormsong Valley"], 10006 },
		{ WHIT.." 7) "..BZ["Crucible of Storms"]..GREY..ALC["Comma"].._RED..BZ["Stormsong Valley"], 10007 },
	},
	DLZandalar_Horde = {
		ZoneName = { BZ["Zandalar"]..HRDE..ALC["L-Parenthesis"]..FACTION_HORDE..ALC["R-Parenthesis"] },
		{ WHIT.." 1) "..BZ["The MOTHERLODE!!"]..GREY..ALC["Comma"].._RED..BZ["Zuldazar"], 10001 },
		{ WHIT.." 2) "..BZ["Atal'Dazar"]..GREY..ALC["Comma"].._RED..BZ["Zuldazar"], 10002 },
		{ WHIT.." 3) "..BZ["Kings' Rest"]..GREY..ALC["Comma"].._RED..BZ["Zuldazar"], 10003 },
		{ WHIT.." 4) "..BZ["Battle of Dazar'alor"]..GREY..ALC["Comma"].._RED..BZ["Zuldazar"], 10004 },
		{ WHIT.." 5) "..BZ["Temple of Sethraliss"]..GREY..ALC["Comma"].._RED..BZ["Vol'dun"], 10005 },
		{ WHIT.." 6) "..BZ["The Underrot"]..GREY..ALC["Comma"].._RED..BZ["Nazmir"], 10006 },
		{ WHIT.." 7) "..BZ["Uldir"]..GREY..ALC["Comma"].._RED..BZ["Nazmir"], 10007 },
	},
}

horde.coords = {
	DLKulTiras_Horde = {
		{ 1, 10001, 477, 307 },
		{ 2, 10002, 406, 395 },
		{ 3, 10003, 413, 324 },
		{ 4, 10004, 158, 274 },
		{ 5, 10005, 64, 149 },
		{ 6, 10006, 389, 86 },
		{ 7, 10007, 411, 124 },
	},
	DLZandalar_Horde = {
		{ 1, 10001, 303, 378 },
		{ 2, 10002, 258, 312 },
		{ 3, 10003, 234, 312 },
		{ 4, 10004, 293, 276 },
		{ 5, 10005, 175, 81 },
		{ 6, 10006, 299, 192 },
		{ 7, 10007, 313, 174 },
	},
}

data.maps = {
	DLEast = {
		ZoneName = { BZ["Eastern Kingdoms"] },
		LargeMap = "DLEast",
		{ WHIT.." 1) "..BZ["Sunwell Plateau"]..ALC["Comma"].._RED..BZ["Isle of Quel'Danas"], 10001 },
		{ WHIT.." 2) "..BZ["Magisters' Terrace"]..ALC["Comma"].._RED..BZ["Isle of Quel'Danas"], 10002 },
		{ WHIT.." 3) "..BZ["Zul'Aman"]..ALC["Comma"].._RED..BZ["Ghostlands"], 10003 },
		{ WHIT.." 4) "..BZ["Stratholme"]..ALC["Comma"].._RED..BZ["Eastern Plaguelands"], 10004 },
		{ WHIT..INDENT..BZ["Stratholme"]..ALC["Hyphen"]..BZ["Crusaders' Square"] },
		{ WHIT..INDENT..BZ["Stratholme"]..ALC["Hyphen"]..BZ["The Gauntlet"] },
		{ WHIT.." 5) "..BZ["Scarlet Monastery"]..ALC["Comma"].._RED..BZ["Tirisfal Glades"], 10005 },
		{ WHIT..INDENT..BZ["Scarlet Halls"] },
		{ WHIT..INDENT..BZ["Scarlet Monastery"] },
		{ WHIT.." 6) "..BZ["Scholomance"]..ALC["Comma"].._RED..BZ["Western Plaguelands"], 10006 },
		{ WHIT.." 7) "..BZ["Shadowfang Keep"]..ALC["Comma"].._RED..BZ["Silverpine Forest"], 10007 },
		{ WHIT.." 8) "..BZ["Baradin Hold"]..ALC["Comma"].._RED..BZ["Tol Barad"], 10008 },
		{ WHIT.." 9) "..BZ["Grim Batol"]..ALC["Comma"].._RED..BZ["Twilight Highlands"], 10009 },
		{ WHIT.."10) "..BZ["The Bastion of Twilight"]..ALC["Comma"].._RED..BZ["Twilight Highlands"], 10010 },
		{ WHIT.."11) "..BZ["Gnomeregan"]..ALC["Comma"].._RED..BZ["Dun Morogh"], 10011 },
		{ WHIT.."12) "..BZ["The Abyssal Maw"]..ALC["Comma"].._RED..BZ["Abyssal Depths"], 10012 },
		{ WHIT.."13) "..BZ["Uldaman"]..ALC["Comma"].._RED..BZ["Badlands"], 10013 },
		{ WHIT.."14) "..BZ["Blackrock Mountain"]..ALC["Comma"].._RED..BZ["Searing Gorge"]..ALC["Slash"]..BZ["Burning Steppes"], 10014 },
		{ WHIT..INDENT..BZ["Blackrock Caverns"] },
		{ WHIT..INDENT..BZ["Blackrock Depths"] },
		{ WHIT..INDENT..BZ["Blackwing Descent"] },
		{ WHIT..INDENT..BZ["Blackwing Lair"]..ALC["Comma"].._RED..BZ["Upper Blackrock Spire"] },
		{ WHIT..INDENT..BZ["Lower Blackrock Spire"] },
		{ WHIT..INDENT..BZ["The Molten Core"]..ALC["Comma"].._RED..BZ["Blackrock Depths"] },
		{ WHIT..INDENT..BZ["Upper Blackrock Spire"] },
		{ WHIT.."15) "..BZ["The Stockade"]..ALC["Comma"].._RED..BZ["Stormwind City"], 10015 },
		{ WHIT.."16) "..BZ["Sunken Temple"]..ALC["Comma"].._RED..BZ["Swamp of Sorrows"], 10016 },
		{ WHIT.."17) "..BZ["The Deadmines"]..ALC["Comma"].._RED..BZ["Westfall"], 10017 },
		{ WHIT.."18) "..BZ["Karazhan"]..ALC["Comma"].._RED..BZ["Deadwind Pass"], 10018 },
		{ WHIT.."19) "..BZ["Zul'Gurub"]..ALC["Comma"].._RED..BZ["Northern Stranglethorn"], 10019 },
		{ GREN.." 1') "..BZ["Alterac Valley"]..ALC["Comma"].._RED..BZ["Hillsbrad Foothills"], 10020 },
		{ GREN.." 2') "..BZ["Arathi Basin"]..ALC["Comma"].._RED..BZ["Arathi Highlands"], 10021 },
		{ GREN.." 3') "..BZ["Tol Barad"]..ALC["Comma"].._RED..BZ["Tol Barad"], 10022 },
		{ "" },
		{ WHIT..L["White"]..ALC["Colon"]..ORNG..L["Instances"] },
		{ GREN..L["Green"]..ALC["Colon"]..ORNG..BATTLEGROUNDS },
	},
	DLWest = {
		ZoneName = { BZ["Kalimdor"] },
		LargeMap = "DLWest",
		{ WHIT.." 1) "..BZ["Firelands"]..ALC["Comma"].._RED..BZ["Mount Hyjal"], 10001 },
		{ WHIT.." 2) "..BZ["Blackfathom Deeps"]..ALC["Comma"].._RED..BZ["Ashenvale"], 10002 },
		{ WHIT.." 3) "..BZ["Ragefire Chasm"]..ALC["Comma"].._RED..BZ["Orgrimmar"], 10003 },
		{ WHIT.." 4) "..BZ["Wailing Caverns"]..ALC["Comma"].._RED..BZ["Northern Barrens"], 10004 },
		{ WHIT.." 5) "..BZ["Maraudon"]..ALC["Comma"].._RED..BZ["Desolace"], 10005 },
		{ WHIT.." 6) "..BZ["Dire Maul"]..ALC["Comma"].._RED..BZ["Feralas"], 10006 },
		{ WHIT.." 7) "..BZ["Razorfen Kraul"]..ALC["Comma"].._RED..BZ["Southern Barrens"], 10007 },
		{ WHIT.." 8) "..BZ["Razorfen Downs"]..ALC["Comma"].._RED..BZ["Thousand Needles"], 10008 },
		{ WHIT.." 9) "..BZ["Onyxia's Lair"]..ALC["Comma"].._RED..BZ["Dustwallow Marsh"], 10009 },
		{ WHIT.."10) "..BZ["Zul'Farrak"]..ALC["Comma"].._RED..BZ["Tanaris"], 10010 },
		{ WHIT.."11) "..BZ["Caverns of Time"]..ALC["Comma"].._RED..BZ["Tanaris"], 10011 },
		{ WHIT..INDENT..BZ["Old Hillsbrad Foothills"] },
		{ WHIT..INDENT..BZ["The Black Morass"] },
		{ WHIT..INDENT..BZ["Hyjal Summit"] },
		{ WHIT..INDENT..BZ["The Culling of Stratholme"] },
		{ WHIT..INDENT..BZ["End Time"] },
		{ WHIT..INDENT..BZ["Well of Eternity"] },
		{ WHIT..INDENT..BZ["Hour of Twilight"] },
		{ WHIT..INDENT..BZ["Dragon Soul"] },
		{ WHIT.."12) "..BZ["Ahn'Qiraj"]..ALC["Comma"].._RED..BZ["Ahn'Qiraj: The Fallen Kingdom"], 10012 },
		{ WHIT..INDENT..BZ["Ruins of Ahn'Qiraj"] },
		{ WHIT..INDENT..BZ["Temple of Ahn'Qiraj"] },
		{ WHIT.."13) "..BZ["Halls of Origination"]..ALC["Comma"].._RED..BZ["Uldum"], 10013 },
		{ WHIT.."14) "..BZ["Lost City of the Tol'vir"]..ALC["Comma"].._RED..BZ["Uldum"], 10014 },
		{ WHIT.."15) "..BZ["Throne of the Four Winds"]..ALC["Comma"].._RED..BZ["Uldum"], 10015 },
		{ WHIT.."16) "..BZ["The Vortex Pinnacle"]..ALC["Comma"].._RED..BZ["Uldum"], 10016 },
		{ GREN.." 1') "..BZ["Warsong Gulch"]..ALC["Comma"].._RED..BZ["Ashenvale"], 10017 },
		{ "" },
		{ WHIT..L["White"]..ALC["Colon"]..ORNG..L["Instances"] },
		{ GREN..L["Green"]..ALC["Colon"]..ORNG..BATTLEGROUNDS },
	},
	DLOutland = {
		ZoneName = { BZ["Outland"] },
		LargeMap = "DLOutland",
		{ WHIT.." 1) "..BZ["Hellfire Citadel"]..ALC["Comma"].._RED..BZ["Hellfire Peninsula"], 10001 },
		{ WHIT..INDENT..BZ["Hellfire Ramparts"] },
		{ WHIT..INDENT..BZ["The Blood Furnace"] },
		{ WHIT..INDENT..BZ["The Shattered Halls"] },
		{ WHIT..INDENT..BZ["Magtheridon's Lair"] },
		{ WHIT.." 2) "..BZ["Coilfang Reservoir"]..ALC["Comma"].._RED..BZ["Zangarmarsh"], 10002 },
		{ WHIT..INDENT..BZ["The Slave Pens"] },
		{ WHIT..INDENT..BZ["The Underbog"] },
		{ WHIT..INDENT..BZ["The Steamvault"] },
		{ WHIT..INDENT..BZ["Serpentshrine Cavern"] },
		{ WHIT.." 3) "..BZ["Auchindoun"]..ALC["Comma"].._RED..BZ["Terokkar Forest"], 10003 },
		{ WHIT..INDENT..BZ["Mana-Tombs"] },
		{ WHIT..INDENT..BZ["Auchenai Crypts"] },
		{ WHIT..INDENT..BZ["Sethekk Halls"] },
		{ WHIT..INDENT..BZ["Shadow Labyrinth"] },
		{ WHIT.." 4) "..BZ["Gruul's Lair"]..ALC["Comma"].._RED..BZ["Blade's Edge Mountains"], 10004 },
		{ WHIT.." 5) "..BZ["Tempest Keep"]..ALC["Comma"].._RED..BZ["Netherstorm"], 10005 },
		{ WHIT..INDENT..BZ["The Mechanar"] },
		{ WHIT..INDENT..BZ["The Botanica"] },
		{ WHIT..INDENT..BZ["The Arcatraz"] },
		{ WHIT..INDENT..BZ["Tempest Keep"] },
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
	},
	DLDeepholm = {
		ZoneName = { BZ["Deepholm"] },
		{ WHIT.." 1) "..BZ["The Stonecore"], 10001 },
	},
	DLPandaria = {
		ZoneName = { BZ["Pandaria"] },
		LargeMap = "DLPandaria",
		{ WHIT.." 1) "..BZ["Throne of Thunder"]..ALC["Comma"].._RED..BZ["Isle of Thunder"], 10001 },
		{ WHIT.." 2) "..BZ["Shado-Pan Monastery"]..ALC["Comma"].._RED..BZ["Kun-Lai Summit"], 10002 },
		{ WHIT.." 3) "..BZ["Mogu'shan Vaults"]..ALC["Comma"].._RED..BZ["Kun-Lai Summit"], 10003 },
		{ WHIT.." 4) "..BZ["Siege of Niuzao Temple"]..ALC["Comma"].._RED..BZ["Townlong Steppes"], 10004 },
		{ WHIT.." 5) "..BZ["Gate of the Setting Sun"]..ALC["Comma"].._RED..BZ["Dread Wastes"]..ALC["Slash"].._RED..BZ["Vale of Eternal Blossoms"], 10005 },
		{ WHIT.." 6) "..BZ["Siege of Orgrimmar"]..ALC["Comma"].._RED..BZ["Vale of Eternal Blossoms"], 10006 },
		{ WHIT.." 7) "..BZ["Mogu'shan Palace"]..ALC["Comma"].._RED..BZ["Vale of Eternal Blossoms"], 10007 },
		{ WHIT.." 8) "..BZ["Terrace of Endless Spring"]..ALC["Comma"].._RED..BZ["The Veiled Stair"], 10008 },
		{ WHIT.." 9) "..BZ["Temple of the Jade Serpent"]..ALC["Comma"].._RED..BZ["The Jade Forest"], 10009 },
		{ WHIT.."10) "..BZ["Heart of Fear"]..ALC["Comma"].._RED..BZ["Dread Wastes"], 10010 },
		{ WHIT.."11) "..BZ["Stormstout Brewery"]..ALC["Comma"].._RED..BZ["Valley of the Four Winds"], 10011 },
		{ GREN.." 1') "..BZ["Deepwind Gorge"]..ALC["Comma"].._RED..BZ["Valley of the Four Winds"], 10012 },
		{ "" },
		{ "" },
		{ "" },
		{ "" },
		{ "" },
		{ "" },
		{ "" },
		{ "" },
		{ "" },
		{ "" },
		{ "" },
		{ "" },
		{ WHIT..L["White"]..ALC["Colon"]..ORNG..L["Instances"] },
		{ GREN..L["Green"]..ALC["Colon"]..ORNG..BATTLEGROUNDS },
	},
	DLDraenor = {
		ZoneName = { BZ["Draenor"] },
		LargeMap = "DLDraenor",
		{ WHIT.." 1) "..BZ["Iron Docks"]..ALC["Comma"].._RED..BZ["Gorgrond"], 10001 },
		{ WHIT.." 2) "..BZ["Blackrock Foundry"]..ALC["Comma"].._RED..BZ["Gorgrond"], 10002 },
		{ WHIT.." 3) "..BZ["Grimrail Depot"]..ALC["Comma"].._RED..BZ["Gorgrond"], 10003 },
		{ WHIT.." 4) "..BZ["Bloodmaul Slag Mines"]..ALC["Comma"].._RED..BZ["Frostfire Ridge"], 10004 },
		{ WHIT.." 5) "..BZ["The Everbloom"]..ALC["Comma"].._RED..BZ["Gorgrond"], 10005 },
		{ WHIT.." 6) "..BZ["Highmaul"]..ALC["Comma"].._RED..BZ["Nagrand"], 10006 },
		{ WHIT.." 7) "..BZ["Auchindoun"]..ALC["Comma"].._RED..BZ["Talador"], 10007 },
		{ WHIT.." 8) "..BZ["Shadowmoon Burial Grounds"]..ALC["Comma"].._RED..BZ["Shadowmoon Valley"], 10008 },
		{ WHIT.." 9) "..BZ["Skyreach"]..ALC["Comma"].._RED..BZ["Spires of Arak"], 10009 },
		{ WHIT.."10) "..BZ["Hellfire Citadel"]..ALC["Comma"].._RED..BZ["Tanaan Jungle"], 10010 },
		{ GREN.." 1') "..BZ["Ashran"]..ALC["Comma"].._RED..BZ["Ashran"], 10011 },
		{ "" },
		{ "" },
		{ "" },
		{ "" },
		{ "" },
		{ "" },
		{ "" },
		{ "" },
		{ "" },
		{ "" },
		{ "" },
		{ "" },
		{ "" },
		{ WHIT..L["White"]..ALC["Colon"]..ORNG..L["Instances"] },
		{ GREN..L["Green"]..ALC["Colon"]..ORNG..BATTLEGROUNDS },
	},
	DLBrokenIsles = {
		ZoneName = { BZ["Broken Isles"] },
		LargeMap = "DLBrokenIsles",
		{ WHIT.." 1) "..BZ["Assault on Violet Hold"]..ALC["Comma"].._RED..BZ["Dalaran"]..GREY.." (66.7, 68.3)", 10001 },
		{ WHIT.." 2) "..BZ["Vault of the Wardens"]..ALC["Comma"].._RED..BZ["Azsuna"]..GREY.." (48.2, 82.7)", 10002 },
		{ WHIT.." 3) "..BZ["Eye of Azshara"]..ALC["Comma"].._RED..BZ["Azsuna"], 10003 },
		{ INDENT.." 3') "..BZ["Eye of Azshara"]..ALC["Hyphen"]..ALC["Meeting Stone"]..ALC["Comma"].._RED..BZ["Hatecoil Warcamp"]..GREY.." (61.2, 41.1)", 100031 }, -- Eye of Azshara's meeting stone is a bit far away from the dungeon's actual location
		{ WHIT.." 4) "..BZ["Black Rook Hold"]..ALC["Comma"].._RED..BZ["Val'sharah"]..GREY.." (38.6, 51.3)", 10004 },
		{ WHIT.." 5) "..BZ["The Emerald Nightmare"]..ALC["Comma"].._RED..BZ["Val'sharah"]..GREY.." (55.6, 38.0)", 10005 },
		{ WHIT.." 6) "..BZ["Darkheart Thicket"]..ALC["Comma"].._RED..BZ["Val'sharah"]..GREY.." (59.0, 32.4)", 10006 },
		{ WHIT.." 7) "..BZ["Neltharion's Lair"]..ALC["Comma"].._RED..BZ["Highmountain"]..GREY.." (49.7, 68.5)", 10007 },
		{ WHIT.." 8) "..BZ["Maw of Souls"]..ALC["Comma"].._RED..BZ["Stormheim"]..GREY.." (52.7, 46.3)", 10008 },
		{ WHIT.." 9) "..BZ["Halls of Valor"]..ALC["Comma"].._RED..BZ["Stormheim"]..GREY.." (71.9, 71.7)", 10009 },
		{ WHIT.."10) "..BZ["The Arcway"]..ALC["Comma"].._RED..BZ["Suramar"]..GREY.." (42.6, 61.4)", 10010 },
		{ INDENT..GREY..ALC["L-Parenthesis"]..L["Meeting stone is inside the Sanctum of Order"]..ALC["R-Parenthesis"].." (45.9, 64.5)" },
		{ WHIT.."11) "..BZ["Court of Stars"]..ALC["Comma"].._RED..BZ["Suramar"]..GREY.." (50.4, 65.9)", 10011 },
		{ WHIT.."12) "..BZ["The Nighthold"]..ALC["Comma"].._RED..BZ["Suramar"]..GREY.." (44.1, 59.8)", 10012 },
		{ INDENT..GREY..ALC["L-Parenthesis"]..L["Raid entrance is inside the Sanctum Depths of Sanctum of Order"]..ALC["R-Parenthesis"].." (45.9, 64.5)" },
		{ WHIT.."13) "..BZ["Cathedral of Eternal Night"]..ALC["Comma"].._RED..BZ["Broken Shore"]..GREY.." (63.1, 18.5)", 10013 },
		{ WHIT.."14) "..BZ["Tomb of Sargeras"]..ALC["Comma"].._RED..BZ["Broken Shore"]..GREY.." (63.8, 21.1)", 10014 },
		{ "" },
		{ GREN.." 1) "..BZ["Darkfollow's Spire"]..GREY..ALC["Comma"].._RED..BZ["Val'sharah"]..GREY.." (37.7, 73.2)", 10101 },
		{ GREN.." 2) "..BZ["Starstalker's Point"]..GREY..ALC["Comma"].._RED..BZ["Val'sharah"]..GREY.." (33.6, 40.7)", 10102 },
		{ GREN.." 3) "..BZ["Black Rook Hold Arena"]..GREY..ALC["Comma"].._RED..BZ["Val'sharah"]..GREY.." (42.4, 48.8)", 10103 },
		{ GREN.." 4) "..BZ["Nightwatcher's Perch"]..GREY..ALC["Comma"].._RED..BZ["Highmountain"]..GREY.." (25.6, 54.2)", 10104 },
		{ GREN.." 5) "..BZ["Cordana's Apex"]..GREY..ALC["Comma"].._RED..BZ["Stormheim"]..GREY.." (61.2, 56.4)", 10105 },
		{ GREN.." 6) "..BZ["Whisperwind's Citadel"]..GREY..ALC["Comma"].._RED..BZ["Stormheim"]..GREY.." (48.4, 20.7)", 10106 },
		{ GREN.." 7) "..BZ["Blackhawk's Bulwark"]..GREY..ALC["Comma"].._RED..BZ["Stormheim"]..GREY.." (61.2, 89.7)", 10107 },
		{ "" },
		{ WHIT..L["White"]..ALC["Colon"]..ORNG..L["Instances"] },
		{ GREN..L["Green"]..ALC["Colon"]..ORNG..PVP },
	},
	DLArgus = {
		ZoneName = { BZ["Argus"] },
		LargeMap = "DLArgus",
		{ WHIT.." 1) "..BZ["The Seat of the Triumvirate"]..ALC["Comma"].._RED..BZ["Mac'Aree"], 10001 },
		{ WHIT.." 2) "..BZ["Antorus, the Burning Throne"]..ALC["Comma"].._RED..BZ["Antoran Wastes"], 10002 },
	},
	DLNazjatar = {
		ZoneName = { BZ["Nazjatar"] },
		{ WHIT.." 1) "..BZ["The Eternal Palace"]..GREY..ALC["Comma"].._RED..BZ["Nazjatar"], 10001 },
	},
	DLShadowlands = {
		ZoneName = { BZ["The Shadowlands"] },
		{ WHIT.." 1) "..BZ["Spires of Ascension"]..GREY..ALC["Comma"].._RED..BZ["Bastion"], 10001 },
		{ WHIT.." 2) "..BZ["The Necrotic Wake"]..GREY..ALC["Comma"].._RED..BZ["Bastion"], 10002 },
		{ WHIT.." 3) "..BZ["Plaguefall"]..GREY..ALC["Comma"].._RED..BZ["Maldraxxus"], 10003 },
		{ WHIT.." 4) "..BZ["Theater of Pain"]..GREY..ALC["Comma"].._RED..BZ["Maldraxxus"], 10004 },
		{ WHIT.." 5) "..BZ["De Other Side"]..GREY..ALC["Comma"].._RED..BZ["Ardenweald"], 10005 },
		{ WHIT.." 6) "..BZ["Mists of Tirna Scithe"]..GREY..ALC["Comma"].._RED..BZ["Ardenweald"], 10006 },
		{ WHIT.." 7) "..BZ["Halls of Atonement"]..GREY..ALC["Comma"].._RED..BZ["Revendreth"], 10007 },
		{ WHIT.." 8) "..BZ["Sanguine Depths"]..GREY..ALC["Comma"].._RED..BZ["Revendreth"], 10008 },
		{ WHIT.." 9) "..BZ["Castle Nathria"]..GREY..ALC["Comma"].._RED..BZ["Revendreth"], 10009 },
	},
	DLZerethMortis = {
		ZoneName = { BZ["Zereth Mortis"] },
		{ WHIT.." 1) "..BZ["Sepulcher of the First Ones"]..GREY..ALC["Comma"].._RED..BZ["Zereth Mortis"], 10001 },
	},
}

--[[ /////////////////////////////////////////
 Atlas Map NPC Description Data
 zoneID = {
	{ ID or letter mark, encounterID or customizedID, x, y, x_largeMap, y_largeMap, color of the letter mark },
	{ "A", 10001, 241, 460 },
	{ 1, 1694, 373, 339 },
 }
/////////////////////////////////////////////]]
data.coords = {
	DLEast = {
		{  "1",  10001, 342, 20, 559,  17, "Raid" }, -- Sunwell Plateau
		{  "2",  10002, 330, 27, 541,  27, "Dungeon" }, -- Magisters' Terrace
		{  "3",  10003, 355, 128, 601, 162, "Dungeon" }, -- Zul'Aman
		{  "4",  10004, 321, 146, 521, 175, "Dungeon" }, -- Stratholme
		{  "5",  10005, 265, 158, 458, 196, "Dungeon" }, -- Scarlet Monastery
		{  "6",  10006, 300, 183, 501, 235, "Dungeon" }, -- Scholomance
		{  "7",  10007, 222, 215, 403, 276, "Dungeon" }, -- Shadowfang Keep
		{  "8",  10008, 182, 263, 345, 338, "Raid" }, -- Baradin Hold
		{  "9",  10009, 317, 282, 523, 364, "Dungeon" }, -- Grim Batol
		{ "10",  10010, 330, 300, 551, 389, "Raid" }, -- The Bastion of Twilight
		{ "11",  10011, 240, 306, 428, 397, "Dungeon" }, -- Gnomeregan
		{ "12",  10012, 154, 318, 307, 407, "Dungeon" }, -- The Abyssal Maw
		{ "13",  10013, 310, 320, 520, 420, "Dungeon" }, -- Uldaman
		{ "14",  10014, 271, 351, 465, 456, "Raid" }, -- Blackrock Mountain
		{ "15",  10015, 235, 369, 424, 474, "Dungeon" }, -- The Stockade
		{ "16",  10016, 319, 400, 534, 523, "Dungeon" }, -- Sunken Temple
		{ "17",  10017, 224, 413, 400, 541, "Dungeon" }, -- The Deadmines
		{ "18",  10018, 285, 414, 484, 539, "Raid" }, -- Karazhan
		{ "19",  10019, 276, 430, 475, 554, "Dungeon" }, -- Zul'Gurub
		{ "1'",  10020, 256, 208, 448, 260, "Battlegrounds" }, -- Alterac Valley
		{ "2'",  10021, 293, 230, 528, 283, "Battlegrounds" }, -- Arathi Basin
		{ "2'",  10021, 316, 223, 507, 291, "Battlegrounds" }, -- Arathi Basin
		{ "3'",  10022, 178, 252, 336, 319, "Battlegrounds" }, -- Tol Barad
	},
	DLWest = {
		{  "1",  10001, 280, 183, 523, 224, "Raid" }, -- Firelands
		{  "2",  10002, 216, 183, 431, 220, "Dungeon" }, -- Blackfathom Deeps
		{  "3",  10003, 312, 225, 566, 281, "Dungeon" }, -- Ragefire Chasm
		{  "4",  10004, 265, 282, 505, 357, "Dungeon" }, -- Wailing Caverns
		{  "5",  10005, 167, 291, 370, 371, "Dungeon" }, -- Maraudon
		{  "6",  10006, 201, 339, 422, 432, "Dungeon" }, -- Dire Maul
		{  "7",  10007, 257, 346, 494, 449, "Dungeon" }, -- Razorfen Kraul
		{  "8",  10008, 274, 355, 516, 480, "Dungeon" }, -- Razorfen Downs
		{  "9",  10009, 298, 354, 551, 457, "Raid" }, -- Onyxia's Lair
		{ "10",  10010, 279, 386, 527, 501, "Dungeon" }, -- Zul'Farrak
		{ "11",  10011, 315, 422, 577, 551, "Raid" }, -- Caverns of Time
		{ "12",  10012, 194, 425, 408, 555, "Raid" }, -- Ahn'Qiraj
		{ "13",  10013, 263, 459, 500, 604, "Dungeon" }, -- Halls of Origination
		{ "14",  10014, 254, 471, 486, 623, "Dungeon" }, -- Lost City of the Tol'vir
		{ "15",  10015, 223, 483, 446, 635, "Raid" }, -- Throne of the Four Winds
		{ "16",  10016, 271, 485, 509, 638, "Dungeon" }, -- The Vortex Pinnacle
		{ "1'",  10017, 269, 234, 507, 297, "Battlegrounds" }, -- Warsong Gulch
	},
	DLOutland = {
		{ "1", 10001, 324, 259, 555, 340, "Raid" }, -- Hellfire Citadel
		{ "2", 10002, 146, 219, 336, 292, "Raid" }, -- Coilfang Reservoir
		{ "3", 10003, 239, 400, 448, 515, "Raid" }, -- Auchindoun
		{ "4", 10004, 224,  78, 424, 116, "Raid" }, -- Gruul's Lair
		{ "5", 10005, 410, 102, 659, 148, "Raid" }, -- Tempest Keep
		{ "6", 10006, 449, 411, 714, 529, "Raid" }, -- Black Temple
	},
	DLNorthrend = {
		{ "1",   10001, 303, 127, 577, 107, "Raid" }, -- Ulduar
		{ "2",   10002, 244, 146, 470, 131, "Raid" }, -- Crusaders' Coliseum
		{ "3",   10003, 404, 194, 778, 220, "Dungeon" }, -- Gundrak
		{ "4",   10004, 208, 230, 403, 290, "Raid" }, -- Icecrown Citadel
		{ "5",   10005, 254, 230, 479, 287, "Dungeon" }, -- The Violet Hold
		{ "6",   10006, 186, 241, 355, 307, "Raid" }, -- Vault of Archavon
		{ "7",   10007, 333, 260, 628, 345, "Dungeon" }, -- Drak'Tharon Keep
		{ "8",   10008,  60, 284, 126, 392, "Raid" }, -- The Nexus
		{ "9",   10009, 204, 289, 389, 401, "Dungeon" }, -- Azjol-Nerub
		{ "10",  10010, 260, 292, 500, 407, "Raid" }, -- Wyrmrest Temple
		{ "11",  10011, 304, 284, 586, 399, "Raid" }, -- Naxxramas
		{ "12",  10012, 413, 363, 786, 546, "Dungeon" }, -- Utgarde Keep
		{ "1'",  10013, 184, 260, 356, 340, "Battlegrounds" }, -- Wintergrasp
	},
	DLDeepholm = {
		{ "1", 10001, 298, 311  }, -- The Stonecore
	},
	DLPandaria = {
		{ "1",  10001,  67,  80, 219,  68, "Raid" }, -- Throne of Thunder
		{ "2",  10002, 167, 157, 378, 207, "Dungeon" }, -- Shado-Pan Monastery
		{ "3",  10003, 222, 154, 467, 200, "Raid" }, -- Mogu'shan Vaults
		{ "4",  10004,  90, 217, 248, 304, "Dungeon" }, -- Siege of Niuzao Temple
		{ "5",  10005, 180, 266, 401, 384, "Dungeon" }, -- Gate of the Setting Sun
		{ "6",  10006, 242, 253, 496, 368, "Raid" }, -- Siege of Orgrimmar
		{ "7",  10007, 254, 250, 510, 358, "Dungeon" }, -- Mogu'shan Palace
		{ "8",  10008, 278, 263, 554, 384, "Raid" }, -- Terrace of Endless Spring
		{ "9",  10009, 365, 267, 702, 385, "Dungeon" }, -- Temple of the Jade Serpent
		{ "10", 10010, 116, 298, 300, 435, "Raid" }, -- Heart of Fear
		{ "11", 10011, 221, 329, 461, 488, "Dungeon" }, -- Stormstout Brewery
		{ "1'", 10012, 246, 312, 513, 457, "Battlegrounds" }, -- Deepwind Gorge
	},
	DLDraenor = {
		{ "1",  10001, 293, 72, 544, 87, "Dungeon" }, -- Iron Docks
		{ "2",  10002, 298, 89, 551, 108, "Raid" }, -- Blackrock Foundry
		{ "3",  10003, 308, 101, 566, 124, "Dungeon" }, -- Grimrail Depot
		{ "4",  10004, 174, 125, 365, 157, "Dungeon" }, -- Bloodmaul Slag Mines
		{ "5",  10005, 317, 128, 582, 179, "Dungeon" }, -- The Everbloom
		{ "6",  10006,  80, 254, 239, 350, "Raid" }, -- Highmaul
		{ "7",  10007, 216, 316, 443, 438, "Dungeon" }, -- Auchindoun
		{ "8",  10008, 322, 343, 586, 479, "Dungeon" }, -- Shadowmoon Burial Grounds
		{ "9",  10009, 240, 363, 480, 512, "Dungeon" }, -- Skyreach
		{ "10", 10010, 336, 235, 610, 323, "Raid" }, -- Hellfire Citadel
		{ "1'", 10011, 460, 195, 799, 300, "Battlegrounds" }, -- Ashran
		{ "1'", 10011, 460, 240 }, -- Ashran
	},
	DLBrokenIsles = {
		{ "1",  10001, 238, 338, 490, 438, "Dungeon" }, -- Assault on Violet Hold
		{ "2",  10002, 142, 373, 361, 493, "Dungeon" }, -- Vault of the Wardens
		{ "3",  10003, 235, 443, 479, 580, "Dungeon" }, -- Eye of Azshara
		{ "3'", 100031, 181, 299, 412, 393, "White" }, -- Eye of Azshara meeting stone
		{ "4",  10004, 109, 170, 323, 227, "Dungeon" }, -- Black Rook Hold
		{ "5",  10005, 147, 150, 369, 207, "Raid" }, -- The Emerald Nightmare
		{ "6",  10006, 155, 141, 378, 190, "Dungeon" }, -- Darkheart Thicket
		{ "7",  10007, 257, 146, 511, 193, "Dungeon" }, -- Neltharion's Lair
		{ "8",  10008, 335, 162, 613, 211, "Dungeon" }, -- Maw of Souls
		{ "9",  10009, 383, 199, 675, 265, "Dungeon" }, -- Halls of Valor
		{ "10", 10010, 235, 259, 491, 342, "Dungeon" }, -- The Arcway
		{ "11", 10011, 255, 256, 515, 343, "Dungeon" }, -- Court of Stars
		{ "12", 10012, 245, 244, 512, 320, "Raid" }, -- The Nighthold
		{ "13", 10013, 317, 317, 587, 414, "Dungeon" }, -- Cathedral of Eternal Night
		{ "14", 10014, 321, 330, 587, 429, "Raid" }, -- Tomb of Sargeras
		{ "1",  10101, 106, 213, 318, 289, "PvP" }, 
		{ "2",  10102,  97, 156, 308, 217, "PvP" }, 
		{ "3",  10103, 121, 170, 336, 230, "PvP" }, 
		{ "4",  10104, 173, 120, 405, 171, "PvP" }, 
		{ "5",  10105, 281, 121, 543, 174, "PvP" }, 
		{ "6",  10106, 329, 120, 608, 167, "PvP" }, 
		{ "7",  10107, 368, 235, 649, 318, "PvP" }, 
	},
	DLArgus = {
		{ 1, 10001, 136, 102, 663, 190, "Dungeon" },
		{ 2, 10002, 162, 350, 280, 305, "Raid" },
	},
	DLNazjatar = {
		{ 1, 10001, 211, 60 },
	},
	DLShadowlands = {
		{ 1, 10001, 423, 266 },
		{ 2, 10002, 390, 305 },
		{ 3, 10003, 364, 147 },
		{ 4, 10004, 355, 127 },
		{ 5, 10005, 289, 426 },
		{ 6, 10006, 218, 411 },
		{ 7, 10007, 123, 272 },
		{ 8, 10008, 82, 256 },
		{ 9, 10009, 73, 268 },
	},
	DLZerethMortis = {
		{ 1, 10001, 424, 236 },
	},
}
