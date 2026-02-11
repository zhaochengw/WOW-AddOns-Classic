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

	AddMob(7800,	BN.MEKGINEER_THERMAPLUGG,		Z.GNOMEREGAN)
	AddMob(8897,	L["Doomforge Craftsman"],		Z.BLACKROCK_DEPTHS)
	AddMob(8920,	L["Weapon Technician"],			Z.BLACKROCK_DEPTHS)
	AddMob(9499,	BN.PLUGGER_SPAZZRING,			Z.BLACKROCK_DEPTHS)
	AddMob(10264,	BN.SOLAKAR_FLAMEWREATH,			Z.BLACKROCK_SPIRE)
	AddMob(10426,	L["Risen Inquisitor"],			Z.STRATHOLME)
	AddMob(16152,	BN.ATTUMEN_THE_HUNTSMAN,		Z.KARAZHAN)
	AddMob(17796,	BN.MEKGINEER_STEAMRIGGER,		Z.THE_STEAMVAULT)
	AddMob(19219,	BN.MECHANO_LORD_CAPACITUS,		Z.THE_MECHANAR)
	AddMob(19960,	L["Doomforge Engineer"],		Z.BLADES_EDGE_MOUNTAINS,	75.1, 39.8)
	AddMob(20207,	L["Sunfury Bowman"],			Z.NETHERSTORM,			56.8, 64.6)
	AddMob(23386,	L["Gan'arg Analyzer"],			Z.BLADES_EDGE_MOUNTAINS,	33.0, 52.5)
	AddMob(138122,	BN.DOOMS_HOWL,				Z.ARATHI_HIGHLANDS,		38.6, 40.2)
	AddMob(144838,	BN.HIGH_TINKER_MEKKATORQUE,		Z.BATTLE_OF_DAZARALOR,		0.0, 0.0)
	AddMob(180917,	L["Destabilized Core"],			Z.ZERETH_MORTIS,		53.6, 44.6)
	AddMob(180924,	L["Garudeon"],				Z.ZERETH_MORTIS,		68.6, 37.0)
	AddMob(183925,	L["Tahkwitz"],				Z.ZERETH_MORTIS,		49.6, 39.8)

	self.InitializeMobDrops = nil
end
