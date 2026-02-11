-------------------------------------------------------------------------------
-- Module namespace.
-------------------------------------------------------------------------------
local FOLDER_NAME, private = ...

local addon = private.addon
if not addon then
	return
end

local constants = addon.constants
local module = addon:GetModule(private.module_name)
local L = _G.LibStub("AceLocale-3.0"):GetLocale(addon.constants.addon_name)

local BN = constants.BOSS_NAMES
local Z = constants.ZONE_NAMES

-----------------------------------------------------------------------
-- What we _really_ came here to see...
-----------------------------------------------------------------------
function module:InitializeMobDrops()
	local function AddMob(npcID, npcName, zoneName, coordX, coordY)
		addon.AcquireTypes.MobDrop:AddEntity(module, {
			coord_x = coordX or 0,
			coord_y = coordY or 0,
			faction = nil,
			identifier = npcID,
			item_list = {},
			locationName = zoneName,
			name = npcName,
		})
	end

	AddMob(1844,	L["Foreman Marcrid"],		Z.EASTERN_PLAGUELANDS,		54.0, 68.0)
	AddMob(9028,	L["Grizzle"],			Z.BLACKROCK_DEPTHS)
	AddMob(9543,	BN.RIBBLY_SCREWSPIGOT,		Z.BLACKROCK_DEPTHS)
	AddMob(9554,	L["Hammered Patron"],		Z.BLACKROCK_DEPTHS)
	AddMob(9568,	BN.OVERLORD_WYRMTHALAK,		Z.BLACKROCK_SPIRE)
	AddMob(9596,	L["Bannok Grimaxe"],		Z.BLACKROCK_SPIRE)
	AddMob(10043,	L["Ribbly's Crony"],		Z.BLACKROCK_DEPTHS)
	AddMob(10119,	L["Volchan"],			Z.BURNING_STEPPES,		22.0, 41.0)
	AddMob(10438,	BN.MALEKI_THE_PALLID,		Z.STRATHOLME)
	AddMob(10997,	BN.WILLEY_HOPEBREAKER,		Z.STRATHOLME)
	AddMob(15263,	BN.THE_PROPHET_SKERAM,		Z.AHNQIRAJ_THE_FALLEN_KINGDOM)
	AddMob(15340,	BN.MOAM,			Z.RUINS_OF_AHNQIRAJ)
	AddMob(16952,	L["Anger Guard"],		Z.BLADES_EDGE_MOUNTAINS,	72.0, 40.5)
	AddMob(17136,	L["Boulderfist Warrior"],	Z.NAGRAND_OUTLAND,		51.0, 57.0)
	AddMob(17975,	BN.HIGH_BOTANIST_FREYWINN,	Z.THE_BOTANICA)
	AddMob(18203,	L["Murkblood Raider"],		Z.NAGRAND_OUTLAND,		31.5, 43.5)
	AddMob(18314,	L["Nexus Stalker"],		Z.MANA_TOMBS)
	AddMob(18497,	L["Auchenai Monk"],		Z.AUCHENAI_CRYPTS)
	AddMob(18830,	L["Cabal Fanatic"],		Z.SHADOW_LABYRINTH)
	AddMob(18853,	L["Sunfury Bloodwarder"],	Z.NETHERSTORM,			27.0, 72.0)
	AddMob(18873,	L["Disembodied Protector"],	Z.NETHERSTORM,			31.8, 52.7)
	AddMob(20900,	L["Unchained Doombringer"],	Z.THE_ARCATRAZ)
	AddMob(21050,	L["Enraged Earth Spirit"],	Z.SHADOWMOON_VALLEY_OUTLAND,	46.5, 45.0)
	AddMob(21059,	L["Enraged Water Spirit"],	Z.SHADOWMOON_VALLEY_OUTLAND,	51.0, 25.5)
	AddMob(21060,	L["Enraged Air Spirit"],	Z.SHADOWMOON_VALLEY_OUTLAND,	70.5, 28.5)
	AddMob(21061,	L["Enraged Fire Spirit"],	Z.SHADOWMOON_VALLEY_OUTLAND,	48.0, 43.5)
	AddMob(21454,	L["Ashtongue Warrior"],		Z.SHADOWMOON_VALLEY_OUTLAND,	57.0, 36.0)
	AddMob(23305,	L["Crazed Murkblood Foreman"],	Z.SHADOWMOON_VALLEY_OUTLAND,	72.3, 90.0)
	AddMob(23324,	L["Crazed Murkblood Miner"],	Z.SHADOWMOON_VALLEY_OUTLAND,	73.5, 88.5)
	AddMob(26270,	L["Iron Rune-Shaper"],		Z.GRIZZLY_HILLS,		67.8, 16.3)
	AddMob(27333,	L["Onslaught Mason"],		Z.DRAGONBLIGHT,			85.8, 36.0)
	AddMob(28123,	L["Venture Co. Excavator"],	Z.SHOLAZAR_BASIN,		35.8, 45.5)
	AddMob(29235,	L["Gundrak Savage"],		Z.ZULDRAK,			66.8, 42.4)
	AddMob(69461,	L["Itoka"],			Z.ISLE_OF_THUNDER)
	AddMob(123371,	BN.GAROTHI_WORLDBREAKER,	Z.ANTORUS__THE_BURNING_THRONE)

	self.InitializeMobDrops = nil
end
