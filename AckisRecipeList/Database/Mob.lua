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
local BN = private.BOSS_NAMES
local Z = private.ZONE_NAMES

function addon:InitMob()
	local function AddMob(npcID, npcName, zoneName, coordX, coordY)
		private.AcquireTypes.MobDrop:AddEntity(addon, {
			coord_x = coordX,
			coord_y = coordY,
			faction = nil,
			identifier = npcID,
			item_list = {},
			locationName = zoneName,
			name = npcName,
		})
	end

	AddMob(9264,	L["Firebrand Pyromancer"],	Z.BLACKROCK_SPIRE,				0, 0) -- Alchemy, Tailoring
	AddMob(9736,	BN.QUARTERMASTER_ZIGRIS,	Z.BLACKROCK_SPIRE,				0, 0) -- Blacksmithing, Jewelcrafting
	AddMob(10813,	BN.BALNAZZAR,			Z.STRATHOLME,					0, 0) -- Alchemy, Tailoring
	AddMob(19168,	L["Sunseeker Astromage"],	Z.THE_MECHANAR,					0, 0) -- Alchemy, Blacksmithing
	AddMob(19755,	L["Mo'arg Weaponsmith"],	Z.SHADOWMOON_VALLEY_OUTLAND,			25.5, 31.5) -- Alchemy, Engineering
	AddMob(20878,	L["Deathforge Guardian"],	Z.SHADOWMOON_VALLEY_OUTLAND,			39.0, 47.0) -- Alchemy, Blacksmithing
	AddMob(23385,	L["Simon Unit"],		Z.BLADES_EDGE_MOUNTAINS,			33.5, 51.5) -- Enchanting, Engineering
	AddMob(24664,	BN.KAELTHAS_SUNSTRIDER,		Z.MAGISTERS_TERRACE,				0, 0) -- Alchemy, Blacksmithing, Enchanting, Engineering, Jewelcrafting, Leatherworking, Tailoring
	AddMob(50005,	L["Poseidus"],			Z.SHIMMERING_EXPANSE,				46.5, 50.0) -- Tailoring, Jewelcrafting
	AddMob(50009,	L["Mobus"],			Z.ABYSSAL_DEPTHS,				73.2, 19.2) -- Tailoring, Jewelcrafting
	AddMob(50056,	L["Garr"],			Z.MOUNT_HYJAL,					37.8, 77.2) -- Tailoring, Jewelcrafting
	AddMob(50061,	L["Xariona"],			Z.DEEPHOLM,					57.3, 62.6) -- Tailoring, Jewelcrafting
	AddMob(50063,	L["Akma'hat"],			Z.ULDUM,					38.0, 60.2) -- Tailoring, Jewelcrafting
	AddMob(50089,	L["Julak-Doom"],		Z.TWILIGHT_HIGHLANDS,				55.0, 11.4) -- Tailoring, Jewelcrafting
	AddMob(91007,	BN.DARGRUL_THE_UNDERKING,	Z.NELTHARIONS_LAIR,				17.0, 70.0) -- Alchemy, Jewelcrafting, Leatherworking
	AddMob(94923,	BN.LORD_KURTALOS_RAVENCREST,	Z.BLACK_ROOK_HOLD,				0, 0) -- Alchemy, Jewelcrafting, Leatherworking
	AddMob(95888,	BN.CORDANA_FELSONG,		Z.VAULT_OF_THE_WARDENS,				0, 0) -- Enchanting, Jewelcrafting
	AddMob(96028,	BN.WRATH_OF_AZSHARA,		Z.EYE_OF_AZSHARA,				57.7, 53.6) -- Alchemy, Inscription
	AddMob(98208,	BN.ADVISOR_VANDROS,		Z.THE_ARCWAY,					0, 0) -- Engineering, Leatherworking, Jewelcrafting
	AddMob(100497,	BN.URSOC,			Z.THE_EMERALD_NIGHTMARE,			0, 0) -- Enchanting, Inscription
	AddMob(101403,	BN.SHADE_OF_XAVIUS,		Z.DARKHEART_THICKET,				0, 0) -- Enchanting, Jewelcrafting
	AddMob(102387,	BN.SAELORN,			Z.VIOLET_HOLD,					0, 0) -- Engineering, Inscription, Leatherworking, Jewelcrafting
	AddMob(103685,	BN.TICHONDRIUS,			Z.THE_NIGHTHOLD,				0, 0) -- Blacksmithing
	AddMob(103758,	BN.STAR_AUGUR_ETRAEUS,		Z.THE_NIGHTHOLD,				0, 0) -- Tailoring, Inscription
	AddMob(103769,	BN.XAVIUS,			Z.THE_EMERALD_NIGHTMARE,			0, 0) -- Enchanting, Inscription
	AddMob(104218,	BN.ADVISOR_MELANDRUS,		Z.COURT_OF_STARS,				0, 0) -- Alchemy, Enchanting, Jewelcrafting, Leatherworking
	AddMob(104636,	BN.CENARIUS,			Z.THE_EMERALD_NIGHTMARE,			0.0, 0.0) -- Alchemy, Inscription
	AddMob(105503,	BN.GULDAN,			Z.THE_NIGHTHOLD,				0.0, 0.0) -- Inscription, Leatherworking
	AddMob(107544,	BN.NITHOGG,			Z.STORMHEIM,					0, 0) -- Inscription
	AddMob(108829,	BN.LEVANTUS,			Z.AZSUNA,					42.7, 66.0) -- Inscription
	AddMob(110321,	BN.NAZAK_THE_FIEND,		Z.SURAMAR,					18.0, 46.0)
	AddMob(110378,	BN.DRUGON_THE_FROSTBLOOD,	Z.HIGHMOUNTAIN,					59.0, 73.0) -- Inscription
	AddMob(110962,	BN.ODYN,			Z.HALLS_OF_VALOR,				0.0,  0.0) -- Jewelcrafting, Leatherworking
	AddMob(111000,	BN.ELERETHE_RENFERAL,		Z.THE_EMERALD_NIGHTMARE,			0, 0) -- Enchanting, Inscription
	AddMob(114263,	BN.ODYN,			Z.TRIAL_OF_VALOR,				0, 0) -- Inscription
	AddMob(114344,	BN.GUARM,			Z.TRIAL_OF_VALOR,				0, 0) -- Inscription
	AddMob(114537, 	BN.HELYA,			Z.TRIAL_OF_VALOR,				0, 0) -- Inscription
	AddMob(138967,	BN.ZUL_REBORN,			Z.ULDIR,					0, 0) -- Inscription & Tailoring
	AddMob(144246,	BN.KUJ0,			Z.OPERATION_MECHAGON,				0, 0) -- Blacksmithing & Engineering
	AddMob(153910,	L["Cultist of N'Zoth"],		Z.ULDUM,					0, 0) -- All professions
	AddMob(162245,	L["Cultist of N'Zoth"],		Z.VALE_OF_ETERNAL_BLOSSOMS,			0, 0) -- All professions

	self.InitMob = nil
end
