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

	AddMob(8983,	BN.GOLEM_LORD_ARGELMACH,			Z.BLACKROCK_DEPTHS)
	AddMob(17722,	L["Coilfang Sorceress"],			Z.THE_STEAMVAULT)
	AddMob(18096,	BN.EPOCH_HUNTER,				Z.OLD_HILLSBRAD_FOOTHILLS)
	AddMob(18422,	L["Sunseeker Botanist"],			Z.THE_BOTANICA)
	AddMob(18472,	BN.DARKWEAVER_SYTH,				Z.SETHEKK_HALLS)
	AddMob(18866,	L["Mageslayer"],				Z.NETHERSTORM,					55.5, 85.5)
	AddMob(19768,	L["Coilskar Siren"],				Z.SHADOWMOON_VALLEY_OUTLAND,			46.5, 30.0)
	AddMob(19826,	L["Dark Conclave Shadowmancer"],		Z.SHADOWMOON_VALLEY_OUTLAND,			37.5, 29.0)
	AddMob(19984,	L["Vekh'nir Dreadhawk"],			Z.BLADES_EDGE_MOUNTAINS,			78.0, 74.3)
	AddMob(23954,	BN.INGVAR_THE_PLUNDERER,			Z.UTGARDE_KEEP)
	AddMob(26861,	BN.KING_YMIRON,			        	Z.UTGARDE_PINNACLE)
	AddMob(27656,	BN.LEY_GUARDIAN_EREGOS,				Z.THE_OCULUS)
	AddMob(28379,	L["Shattertusk Mammoth"],			Z.SHOLAZAR_BASIN,				53.5, 24.4)
	AddMob(28851,	L["Enraged Mammoth"],				Z.ZULDRAK,					72.0, 41.1)
	AddMob(28923,	BN.LOKEN,					Z.HALLS_OF_LIGHTNING)
	AddMob(29311,	BN.HERALD_VOLAZJ,				Z.AHNKAHET_THE_OLD_KINGDOM)
	AddMob(29370,	L["Stormforged Champion"],			Z.THE_STORM_PEAKS,				26.1, 47.5)
	AddMob(29376,	L["Stormforged Artificer"],			Z.THE_STORM_PEAKS,				31.5, 44.2)
	AddMob(29402,	L["Ironwool Mammoth"],				Z.THE_STORM_PEAKS,				36.0, 83.5)
	AddMob(29792,	L["Frostfeather Screecher"],			Z.THE_STORM_PEAKS,				33.5, 65.5)
	AddMob(29793,	L["Frostfeather Witch"],			Z.THE_STORM_PEAKS,				33.0, 66.8)
	AddMob(30208,	L["Stormforged Ambusher"],			Z.THE_STORM_PEAKS,				70.3, 57.5)
	AddMob(30222,	L["Stormforged Infiltrator"],			Z.THE_STORM_PEAKS,				58.5, 63.2)
	AddMob(30260,	L["Stoic Mammoth"],				Z.THE_STORM_PEAKS,				54.8, 64.9)
	AddMob(30448,	L["Plains Mammoth"],				Z.THE_STORM_PEAKS,				66.1, 45.6)
	AddMob(76266,	BN.HIGH_SAGE_VIRYX,				Z.SKYREACH)
	AddMob(87493,	BN.RUKHMAR,					Z.SPIRES_OF_ARAK,				35.0, 32.0)
	AddMob(95067,	BN.SHADOW_LORD_ISKAR,				Z.HELLFIRE_CITADEL)
	AddMob(109331,	BN.CALAMIR,					Z.SURAMAR,					 0.0,  0.0)
	AddMob(126915,	BN.FELHOUNDS_OF_SARGERAS,			Z.ANTORUS__THE_BURNING_THRONE)
	AddMob(181249,	L["Tethos"],					Z.ZERETH_MORTIS,				54.6,	73.6)
	AddMob(183516,	L["The Engulfer"],				Z.ZERETH_MORTIS,				44.0,	75.2)
	AddMob(184413,	L["Shifting Stargorger"],			Z.ZERETH_MORTIS,				42.2,	21.6)

	self.InitializeMobDrops = nil
end
