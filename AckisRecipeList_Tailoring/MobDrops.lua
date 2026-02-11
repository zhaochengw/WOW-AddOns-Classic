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
local L = _G.LibStub("AceLocale-3.0"):GetLocale(constants.addon_name)

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

	AddMob(590,	L["Defias Looter"],			Z.WESTFALL,			37.5, 58.4)
	AddMob(2242,	L["Syndicate Spy"],			Z.HILLSBRAD_FOOTHILLS,		56.0, 24.2)
	AddMob(3530,	L["Pyrewood Tailor"],			Z.SILVERPINE_FOREST,		45.7, 71.0)
	AddMob(3531,	L["Moonrage Tailor"],			Z.SILVERPINE_FOREST,		45.5, 73.3)
	AddMob(4834,	L["Theramore Infiltrator"],		Z.DUSTWALLOW_MARSH,		44.0, 27.3)
	AddMob(5861,	L["Twilight Fire Guard"],		Z.SEARING_GORGE,		25.5, 33.8)
	AddMob(7037,	L["Thaurissan Firewalker"],		Z.BURNING_STEPPES,		61.1, 42.0)
	AddMob(9026,	L["Overmaster Pyron"],			Z.SEARING_GORGE,		26.2, 74.9)
	AddMob(11502,	BN.RAGNAROS,				Z.MOLTEN_CORE)
	AddMob(11487,	BN.MAGISTER_KALENDRIS,			Z.DIRE_MAUL,			59.04, 48.82)
	AddMob(16406,	L["Phantom Attendant"],			Z.KARAZHAN)
	AddMob(16408,	L["Phantom Valet"],			Z.KARAZHAN)
	AddMob(16807,	BN.GRAND_WARLOCK_NETHEKURSE,		Z.THE_SHATTERED_HALLS)
	AddMob(17521,	BN.OPERA_HALL,				Z.KARAZHAN)
	AddMob(17798,	BN.WARLORD_KALITHRESH,			Z.THE_STEAMVAULT)
	AddMob(17977,	BN.WARP_SPLINTER,			Z.THE_BOTANICA)
	AddMob(17978,	BN.THORNGRIN_THE_TENDER,		Z.THE_BOTANICA)
	AddMob(18708,	BN.MURMUR,				Z.SHADOW_LABYRINTH)
	AddMob(18872,	L["Disembodied Vindicator"],		Z.NETHERSTORM,			36.0, 55.5)
	AddMob(19220,	BN.PATHALEON_THE_CALCULATOR,		Z.THE_MECHANAR)
	AddMob(20134,	L["Sunfury Arcanist"],			Z.NETHERSTORM,			51.0, 82.5)
	AddMob(20135,	L["Sunfury Arch Mage"],			Z.NETHERSTORM,			46.5, 81.0)
	AddMob(20869,	L["Arcatraz Sentinel"],			Z.THE_ARCATRAZ)
	AddMob(20885,	BN.DALLIAH_THE_DOOMSAYER,		Z.THE_ARCATRAZ)
	AddMob(124393,	BN.PORTAL_KEEPER_HASABEL,		Z.ANTORUS__THE_BURNING_THRONE)

	self.InitializeMobDrops = nil
end
