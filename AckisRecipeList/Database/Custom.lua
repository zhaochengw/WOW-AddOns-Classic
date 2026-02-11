-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local FOLDER_NAME, private = ...

local LibStub = _G.LibStub
local addon = LibStub("AceAddon-3.0"):GetAddon(private.addon_name)
local L = LibStub("AceLocale-3.0"):GetLocale(private.addon_name)

-- ----------------------------------------------------------------------------
-- Imports.
-- ----------------------------------------------------------------------------
local Z = private.ZONE_NAMES

function addon:InitCustom()
	local function AddCustom(identifier, zoneName, coordX, coordY, faction)
		return private.AcquireTypes.Custom:AddEntity(addon, {
			coord_x = coordX,
			coord_y = coordY,
			faction = faction,
			identifier = identifier,
			item_list = {},
			locationName = zoneName,
			name = L[identifier],
		})
	end

	AddCustom("DAILY_COOKING_MEAT", 	Z.SHATTRATH_CITY)
	AddCustom("DAILY_COOKING_FISH", 	Z.SHATTRATH_CITY)
	AddCustom("DAILY_FISHING_SHATT", 	Z.SHATTRATH_CITY)
	AddCustom("DEFAULT_RECIPE")
	AddCustom("CRAFTED_ENGINEERS")
	AddCustom("ONYXIA_HEAD_QUEST", 		Z.ONYXIAS_LAIR)
	AddCustom("ENG_FLOOR_ITEM_BRD", 	Z.BLACKROCK_DEPTHS)
	AddCustom("BRD_MAIL",			Z.BLACKROCK_DEPTHS)
	AddCustom("BRD_SHOULDERS", 		Z.BLACKROCK_DEPTHS)
	AddCustom("STRATH_BS_PLANS", 		Z.STRATHOLME)
	AddCustom("DM_TRIBUTE", 		Z.DIRE_MAUL, 			59.0, 48.8)
	AddCustom("OGRI_DRAGONS", 		Z.BLADES_EDGE_MOUNTAINS)
	AddCustom("NORMAL")
	AddCustom("HEROIC")
	AddCustom("MYTHIC")
	AddCustom("MYTHIC_DUNGEON")
	AddCustom("KUNG")
	AddCustom("DAILY_COOKING_DAL", 		Z.DALARAN_NORTHREND)
	AddCustom("ARCH_DROP_ULD", 		Z.ULDUM)
	AddCustom("PREREQ")
	AddCustom("BANANA_INFUSED_RUM", 	Z.KRASARANG_WILDS, 		52.3, 88.7)
	AddCustom("FOUR_SENSES_BREW", 		Z.KUN_LAI_SUMMIT, 		44.7, 52.3)
	AddCustom("LEARNT_BY_ACCEPTING_QUEST")
	AddCustom("TIMELESS_ISLE_COOKING", 	Z.TIMELESS_ISLE, 		52.1, 46.1)
	AddCustom("ANCIENT_GUO-LAI_CACHE", 	Z.VALE_OF_ETERNAL_BLOSSOMS)
	AddCustom("DRAENOR_DEFAULT", 		Z.DRAENOR)
	AddCustom("RATED_PVP")
	AddCustom("WATERLOGGED_CACHE", 		Z.HELMOUTH_CLIFFS)
	AddCustom("SPOILS_OF_THE_WORTHY",	Z.HALLS_OF_VALOR)
	AddCustom("TRANQUIL_MIND",		Z.DALARAN_BROKENISLES,		41.1, 35.8)
	AddCustom("LEGION_BOSSES",		Z.BROKEN_ISLES)
	AddCustom("ARCHAEOLOGY_HIGHBORNE")
	AddCustom("WITHERED_ARMY")
	AddCustom("TIMELOSTCHEST",		Z.SEARING_GORGE)
	AddCustom("BOON_OF_THE_BUILDER",	Z.DALARAN_BROKENISLES,		38.6, 25.0)
	AddCustom("KISS_SYAITH",		Z.BROKEN_SHORE,			49.0, 55.8)
	AddCustom("HUMBLE_FLYER")
	AddCustom("HONEYBACK_HIVE",		Z.STORMSONG_VALLEY)
	AddCustom("CLOUDWALKERS_COFFER",	Z.BASTION,			61.0, 15.1)
	AddCustom("PRESENTS")
	AddCustom("INVASIVE_MAWSHROOM",		Z.KORTHIA)
	AddCustom("KORTHIA_TREASURES",		Z.KORTHIA)
	AddCustom("RELIC_CACHE",		Z.KORTHIA)
	AddCustom("RIFTBOUND_CACHE",		Z.KORTHIA)
	AddCustom("PROF_ARCH_HIGH",		Z.HIGHMOUNTAIN)
	AddCustom("PROF_FISH_AZSU",		Z.AZSUNA)
	AddCustom("PROF_FISH_SURA",		Z.SURAMAR)
	AddCustom("DROMAN",			Z.ARDENWEALD,			38.0, 36.8)

	self.InitCustom = nil
end

