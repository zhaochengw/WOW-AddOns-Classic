--[[

	Atlas, a World of Warcraft instance map browser
	Copyright 2005 ~ 2010 - Dan Gilbert <dan.b.gilbert at gmail dot com>
	Copyright 2010 - Lothaer <lothayer at gmail dot com>, Atlas Team
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

local L          = LibStub("AceLocale-3.0"):GetLocale("Atlas")

-- Determine WoW TOC Version
local WoWClassicEra, WoWClassic, WoWRetail
local wowversion = select(4, GetBuildInfo())
if wowversion < 20000 then
	WoWClassicEra = true
elseif wowversion > 20000 and wowversion < 90000 then
	WoWClassic = true
elseif wowversion > 90000 then
	WoWRetail = true
end

-- Expansion Icons
local icon_E0 = "Interface\\ICONS\\expansionicon_classic"                  -- Classic
local icon_E1 = "Interface\\ICONS\\expansionicon_burningcrusade"           -- BC
local icon_E2 = "Interface\\ICONS\\expansionicon_wrathofthelichking"       -- WoLTK
local icon_E3 = "Interface\\ICONS\\expansionicon_cataclysm"                -- Cata
local icon_E4 = "Interface\\ICONS\\expansionicon_mistsofpandaria"          -- MoP
local icon_E5 = "Interface\\ICONS\\expansionicon_draenor"                  -- Draenor
local icon_E6 = "Interface\\ICONS\\Achievements_Zone_BrokenShore"          -- Legion
local icon_E7 = "Interface\\ICONS\\ability_racial_cityofgold"              -- BfA
local icon_E8 = "Interface\\ICONS\\achievement_mythicdungeons_shadowlands" -- Shadowlands
local icon_E9 = "Interface\\ICONS\\flightstone-dragonflight"               -- Dragonflight
local icon_E10 = "Interface\\ICONS\\ui_delves"                             -- TWW

-- Continent Icons
local icon_EasternKingdom = "Interface\\ICONS\\Achievement_Zone_EasternKingdoms_01" -- Eastern Kingdom
local icon_Kalimdor = "Interface\\ICONS\\Achievement_Zone_Kalimdor_01"              -- Kalimdor
local icon_Outland = "Interface\\ICONS\\Achievement_Zone_Outland_01"                -- Outland
local icon_Northrend = "Interface\\ICONS\\Achievement_Zone_Northrend_01"            -- Northrend
local icon_Deepholm = "Interface\\ICONS\\Achievement_Zone_DeepHolm"                 -- Deepholm
local icon_Pandaria = "Interface\\ICONS\\INV_Pet_Achievement_Pandaria"              -- Pandaria
local icon_Draenor = "Interface\\ICONS\\Achievement_Zone_Draenor_01"                -- Draenor
local icon_BrokenIsles = "Interface\\ICONS\\Achievements_Zone_BrokenShore"          -- Broken Isles
local icon_KulTiras = "Interface\\ICONS\\spell_arcane_portalkultiras"               -- Kul Tiras
local icon_Zandalar = "Interface\\ICONS\\spell_arcane_portalzandalar"               -- Zandalar
--local icon_Nazjatar = "Interface\\ICONS\\spell_arcane_portalzandalar"             -- Nazjatar
local icon_Shadowlands = "Interface\\ICONS\\spell_arcane_teleportoribos"            -- Shadowlands
local icon_DragonIsles = "Interface\\ICONS\\spell_arcane_teleportvaldrakken"        -- Dragon Isles
local icon_KhazAlgar = "Interface\\ICONS\\inv_spell_arcane_telepotdornogal"         -- Khaz Algar

--[[
************************************************************************************************
Global Atlas Strings

    Define the string IDs hear so that we can easily use them in UI XML.
    Translation should still be kept in translation file.
************************************************************************************************
--]]
ATLAS_TITLE                        = L["ATLAS_TITLE"]
ATLAS_TITLE_VERSION                = ATLAS_TITLE.." "..ATLAS_VERSION

BINDING_HEADER_ATLAS_TITLE         = L["BINDING_HEADER_ATLAS_TITLE"]
BINDING_NAME_ATLAS_TOGGLE          = L["BINDING_NAME_ATLAS_TOGGLE"]
BINDING_NAME_ATLAS_OPTIONS         = L["BINDING_NAME_ATLAS_OPTIONS"]
BINDING_NAME_ATLAS_AUTOSEL         = L["BINDING_NAME_ATLAS_AUTOSEL"]

ATLAS_SLASH                        = L["ATLAS_SLASH"]
ATLAS_SLASH_OPTIONS                = L["ATLAS_SLASH_OPTIONS"]

ATLAS_STRING_LOCATION              = L["ATLAS_STRING_LOCATION"]
ATLAS_STRING_LEVELRANGE            = L["ATLAS_STRING_LEVELRANGE"]
ATLAS_STRING_RECLEVELRANGE         = L["ATLAS_STRING_RECLEVELRANGE"]
ATLAS_STRING_PLAYERLIMIT           = L["ATLAS_STRING_PLAYERLIMIT"]
ATLAS_STRING_SELECT_CAT            = L["ATLAS_STRING_SELECT_CAT"]
ATLAS_STRING_SELECT_MAP            = L["ATLAS_STRING_SELECT_MAP"]
ATLAS_STRING_MINLEVEL              = L["ATLAS_STRING_MINLEVEL"]

ATLAS_OPTIONS_BUTTON               = L["ATLAS_OPTIONS_BUTTON"]
ATLAS_OPTIONS_SHOWBUT              = L["ATLAS_OPTIONS_SHOWBUT"]
ATLAS_OPTIONS_SHOWBUT_TIP          = L["ATLAS_OPTIONS_SHOWBUT_TIP"]
ATLAS_OPTIONS_SHOWWMBUT            = L["ATLAS_OPTIONS_SHOWWMBUT"]
ATLAS_OPTIONS_AUTOSEL              = L["ATLAS_OPTIONS_AUTOSEL"]
ATLAS_OPTIONS_AUTOSEL_TIP          = L["ATLAS_OPTIONS_AUTOSEL_TIP"]
ATLAS_OPTIONS_LOCK                 = L["ATLAS_OPTIONS_LOCK"]
ATLAS_OPTIONS_LOCK_TIP             = L["ATLAS_OPTIONS_LOCK_TIP"]
ATLAS_OPTIONS_TRANS                = L["ATLAS_OPTIONS_TRANS"]
ATLAS_OPTIONS_RCLICK               = L["ATLAS_OPTIONS_RCLICK"]
ATLAS_OPTIONS_RCLICK_TIP           = L["ATLAS_OPTIONS_RCLICK_TIP"]
ATLAS_OPTIONS_ACRONYMS             = L["ATLAS_OPTIONS_ACRONYMS"]
ATLAS_OPTIONS_ACRONYMS_TIP         = L["ATLAS_OPTIONS_ACRONYMS_TIP"]
ATLAS_OPTIONS_SCALE                = L["ATLAS_OPTIONS_SCALE"]
ATLAS_OPTIONS_BOSS_POTRAIT         = L["ATLAS_OPTIONS_BOSS_POTRAIT"]
ATLAS_OPTIONS_CLAMPED              = L["ATLAS_OPTIONS_CLAMPED"]
ATLAS_OPTIONS_CLAMPED_TIP          = L["ATLAS_OPTIONS_CLAMPED_TIP"]
ATLAS_OPTIONS_COLORINGDROPDOWN     = L["ATLAS_OPTIONS_COLORINGDROPDOWN"]
ATLAS_OPTIONS_COLORINGDROPDOWN_TIP = L["ATLAS_OPTIONS_COLORINGDROPDOWN_TIP"]

ATLAS_BUTTON_TOOLTIP_TITLE         = L["ATLAS_BUTTON_TOOLTIP_TITLE"]
ATLAS_BUTTON_TOOLTIP_HINT          = L["ATLAS_BUTTON_TOOLTIP_HINT"]
ATLAS_LDB_HINT                     = L["ATLAS_LDB_HINT"]

ATLAS_OPTIONS_CATDD                = L["ATLAS_OPTIONS_CATDD"] -- Sort Instance Maps by
-- Continent
ATLAS_DDL_CONTINENT                = L["ATLAS_DDL_CONTINENT"]
if (WoWClassicEra) then
	ATLAS_DDL_CONTINENT_EASTERN = L["ATLAS_DDL_CONTINENT_EASTERN"]
	ATLAS_DDL_CONTINENT_KALIMDOR = L["ATLAS_DDL_CONTINENT_KALIMDOR"]
	ATLAS_DDL_CONTINENT_OUTLAND = L["ATLAS_DDL_CONTINENT_OUTLAND"]
	ATLAS_DDL_CONTINENT_NORTHREND = L["ATLAS_DDL_CONTINENT_NORTHREND"]
else
	ATLAS_DDL_CONTINENT_EASTERN = format("|T%s:0:0|t %s", icon_EasternKingdom, L["ATLAS_DDL_CONTINENT_EASTERN"])
	ATLAS_DDL_CONTINENT_KALIMDOR = format("|T%s:0:0|t %s", icon_Kalimdor, L["ATLAS_DDL_CONTINENT_KALIMDOR"])
	ATLAS_DDL_CONTINENT_OUTLAND = format("|T%s:0:0|t %s", icon_Outland, L["ATLAS_DDL_CONTINENT_OUTLAND"])
	ATLAS_DDL_CONTINENT_NORTHREND = format("|T%s:0:0|t %s", icon_Northrend, L["ATLAS_DDL_CONTINENT_NORTHREND"])
	ATLAS_DDL_CONTINENT_DEEPHOLM = format("|T%s:0:0|t %s", icon_Deepholm, L["ATLAS_DDL_CONTINENT_DEEPHOLM"])
	ATLAS_DDL_CONTINENT_PANDARIA = format("|T%s:0:0|t %s", icon_Pandaria, L["ATLAS_DDL_CONTINENT_PANDARIA"])
	ATLAS_DDL_CONTINENT_DRAENOR = format("|T%s:0:0|t %s", icon_Draenor, L["ATLAS_DDL_CONTINENT_DRAENOR"])
	ATLAS_DDL_CONTINENT_BROKENISLES1 = format("|T%s:0:0|t %s", icon_BrokenIsles, L["ATLAS_DDL_CONTINENT_BROKENISLES1"])
	ATLAS_DDL_CONTINENT_BROKENISLES2 = format("|T%s:0:0|t %s", icon_BrokenIsles, L["ATLAS_DDL_CONTINENT_BROKENISLES2"])
	ATLAS_DDL_CONTINENT_KULTIRAS = format("|T%s:0:0|t %s", icon_KulTiras, L["ATLAS_DDL_CONTINENT_KULTIRAS"])
	ATLAS_DDL_CONTINENT_ZANDALAR = format("|T%s:0:0|t %s", icon_Zandalar, L["ATLAS_DDL_CONTINENT_ZANDALAR"])
	ATLAS_DDL_CONTINENT_NAZJATAR = L["ATLAS_DDL_CONTINENT_NAZJATAR"]
	ATLAS_DDL_CONTINENT_SHADOWLANDS = format("|T%s:0:0|t %s", icon_Shadowlands, L["ATLAS_DDL_CONTINENT_SHADOWLANDS"])
	ATLAS_DDL_CONTINENT_DRAGONISLES = format("|T%s:0:0|t %s", icon_DragonIsles, L["ATLAS_DDL_CONTINENT_DRAGONISLES"])
	ATLAS_DDL_CONTINENT_KHAZALGAR = format("|T%s:0:0|t %s", icon_KhazAlgar, L["ATLAS_DDL_CONTINENT_KHAZALGAR"])
end
-- Level
ATLAS_DDL_LEVEL            = L["ATLAS_DDL_LEVEL"]
-- BCC / prior to new level range
ATLAS_DDL_LEVEL_10TO20     = L["ATLAS_DDL_LEVEL_10TO20"]
ATLAS_DDL_LEVEL_20TO40     = L["ATLAS_DDL_LEVEL_20TO40"]
ATLAS_DDL_LEVEL_40TO60     = L["ATLAS_DDL_LEVEL_40TO60"]
ATLAS_DDL_LEVEL_60TO70     = L["ATLAS_DDL_LEVEL_60TO70"]
ATLAS_DDL_LEVEL_70TO80     = L["ATLAS_DDL_LEVEL_70TO80"]
ATLAS_DDL_LEVEL_80TO85     = L["ATLAS_DDL_LEVEL_80TO85"]
ATLAS_DDL_LEVEL_85TO90     = L["ATLAS_DDL_LEVEL_85TO90"]
ATLAS_DDL_LEVEL_90TO100    = L["ATLAS_DDL_LEVEL_90TO100"]
ATLAS_DDL_LEVEL_100PLUS    = L["ATLAS_DDL_LEVEL_100PLUS"]
ATLAS_DDL_LEVEL_100TO110   = L["ATLAS_DDL_LEVEL_100TO110"]
ATLAS_DDL_LEVEL_110PLUS    = L["ATLAS_DDL_LEVEL_110PLUS"]
ATLAS_DDL_LEVEL_110TO120   = L["ATLAS_DDL_LEVEL_110TO120"]
ATLAS_DDL_LEVEL_120PLUS    = L["ATLAS_DDL_LEVEL_120PLUS"]
ATLAS_DDL_LEVEL_120TO130   = L["ATLAS_DDL_LEVEL_120TO130"]
ATLAS_DDL_LEVEL_130PLUS    = L["ATLAS_DDL_LEVEL_130PLUS"]
-- Retail / new level range
ATLAS_DDL_LEVEL_UNDER30    = L["ATLAS_DDL_LEVEL_UNDER30"]
ATLAS_DDL_LEVEL_UNDER45    = L["ATLAS_DDL_LEVEL_UNDER45"]
ATLAS_DDL_LEVEL_10TO30     = L["ATLAS_DDL_LEVEL_10TO30"]
ATLAS_DDL_LEVEL_30TO35     = L["ATLAS_DDL_LEVEL_30TO35"]
ATLAS_DDL_LEVEL_35TO40     = L["ATLAS_DDL_LEVEL_35TO40"]
ATLAS_DDL_LEVEL_40TO45     = L["ATLAS_DDL_LEVEL_40TO45"]
ATLAS_DDL_LEVEL_45TO50     = L["ATLAS_DDL_LEVEL_45TO50"]
ATLAS_DDL_LEVEL_45TO60     = L["ATLAS_DDL_LEVEL_45TO60"]
ATLAS_DDL_LEVEL_50TO60     = L["ATLAS_DDL_LEVEL_50TO60"]
ATLAS_DDL_LEVEL_60PLUS     = L["ATLAS_DDL_LEVEL_60PLUS"]

ATLAS_DDL_PARTYSIZE        = L["ATLAS_DDL_PARTYSIZE"]
ATLAS_DDL_PARTYSIZE_5      = L["ATLAS_DDL_PARTYSIZE_5"]
ATLAS_DDL_PARTYSIZE_10     = L["ATLAS_DDL_PARTYSIZE_10"]
ATLAS_DDL_PARTYSIZE_20TO40 = L["ATLAS_DDL_PARTYSIZE_20TO40"]
ATLAS_DDL_EXPANSION        = L["ATLAS_DDL_EXPANSION"]
-- Expansion
if (WoWClassicEra) then
	ATLAS_DDL_EXPANSION_OLD   = L["ATLAS_DDL_EXPANSION_OLD"]
	ATLAS_DDL_EXPANSION_BC    = L["ATLAS_DDL_EXPANSION_BC"]
	ATLAS_DDL_EXPANSION_WOTLK = L["ATLAS_DDL_EXPANSION_WOTLK"]
else
	ATLAS_DDL_EXPANSION_OLD          = format("|T%s:0:0|t %s", icon_E0, L["ATLAS_DDL_EXPANSION_OLD"])
	ATLAS_DDL_EXPANSION_BC           = format("|T%s:0:0|t %s", icon_E1, L["ATLAS_DDL_EXPANSION_BC"])
	ATLAS_DDL_EXPANSION_WOTLK        = format("|T%s:0:0|t %s", icon_E2, L["ATLAS_DDL_EXPANSION_WOTLK"])
	ATLAS_DDL_EXPANSION_CATA         = format("|T%s:0:0|t %s", icon_E3, L["ATLAS_DDL_EXPANSION_CATA"])
	ATLAS_DDL_EXPANSION_MOP          = format("|T%s:0:0|t %s", icon_E4, L["ATLAS_DDL_EXPANSION_MOP"])
	ATLAS_DDL_EXPANSION_WOD          = format("|T%s:0:0|t %s", icon_E5, L["ATLAS_DDL_EXPANSION_WOD"])
	ATLAS_DDL_EXPANSION_LEGION1      = format("|T%s:0:0|t %s", icon_E6, L["ATLAS_DDL_EXPANSION_LEGION1"])
	ATLAS_DDL_EXPANSION_LEGION2      = format("|T%s:0:0|t %s", icon_E6, L["ATLAS_DDL_EXPANSION_LEGION2"])
	ATLAS_DDL_EXPANSION_BFA          = format("|T%s:0:0|t %s", icon_E7, L["ATLAS_DDL_EXPANSION_BFA"])
	ATLAS_DDL_EXPANSION_BFA2         = format("|T%s:0:0|t %s", icon_E7, L["ATLAS_DDL_EXPANSION_BFA2"])
	ATLAS_DDL_EXPANSION_SHADOWLANDS  = format("|T%s:0:0|t %s", icon_E8, L["ATLAS_DDL_EXPANSION_SHADOWLANDS"])
	ATLAS_DDL_EXPANSION_DRAGONFLIGHT = format("|T%s:0:0|t %s", icon_E9, L["ATLAS_DDL_EXPANSION_DRAGONFLIGHT"])
	ATLAS_DDL_EXPANSION_TWW          = format("|T%s:0:0|t %s", icon_E10, L["ATLAS_DDL_EXPANSION_TWW"])
end
ATLAS_DDL_TYPE               = L["ATLAS_DDL_TYPE"]
ATLAS_DDL_TYPE_INSTANCE      = L["ATLAS_DDL_TYPE_INSTANCE"]
ATLAS_DDL_TYPE_ENTRANCE      = L["ATLAS_DDL_TYPE_ENTRANCE"]

ATLAS_INSTANCE_BUTTON        = L["ATLAS_INSTANCE_BUTTON"]
ATLAS_ENTRANCE_BUTTON        = L["ATLAS_ENTRANCE_BUTTON"]

ATLAS_OPEN_ADVENTURE         = L["ATLAS_OPEN_ADVENTURE"]
ATLAS_CLICK_TO_OPEN          = L["ATLAS_CLICK_TO_OPEN"]
ATLAS_OPEN_WOWMAP_WINDOW     = L["ATLAS_OPEN_WOWMAP_WINDOW"]
ATLAS_OPEN_ATLASLOOT_WINDOW  = L["ATLAS_OPEN_ATLASLOOT_WINDOW"]
ATLAS_ROPEN_ATLASLOOT_WINDOW = L["ATLAS_ROPEN_ATLASLOOT_WINDOW"]
ATLAS_CLOSE_ATLASLOOT_WINDOW = L["ATLAS_CLOSE_ATLASLOOT_WINDOW"]
ATLAS_COLLAPSE_BUTTON        = L["ATLAS_COLLAPSE_BUTTON"]
ATLAS_EXPAND_BUTTON          = L["ATLAS_EXPAND_BUTTON"]
ATLAS_TOGGLE_LOOT            = L["ATLAS_TOGGLE_LOOT"]
