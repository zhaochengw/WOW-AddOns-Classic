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
			coord_x = coordX,
			coord_y = coordY,
			faction = nil,
			identifier = npcID,
			item_list = {},
			locationName = zoneName,
			name = npcName,
		})
	end

	AddMob(3444,	L["Dig Rat"],				Z.SOUTHERN_BARRENS,		47.8, 88.6)
	AddMob(14354,	L["Pusillin"],				Z.DIRE_MAUL,			59.04, 48.82)
	AddMob(81171,	L["Frostdeep Cavedweller"],		Z.FROSTWALL,			0.0, 0.0)
	AddMob(85715,	L["Lunarfall Cavedweller"],		Z.LUNARFALL,			0.0, 0.0)
	AddMob(96240,	L["Lok'goron Hashslinger"],		Z.TANAAN_JUNGLE,		39.8, 45.6)
	AddMob(99504,	L["Deepwater Spikeback"],		Z.SURAMAR,			78.2, 61.2)
	AddMob(110042,	L["Heartwood Stag"],			Z.SURAMAR,			64.6, 45.6)
	AddMob(110043,	L["Heartwood Doe"],			Z.SURAMAR,			64.6, 45.6)
	AddMob(110340,	L["Myonix"],				Z.SURAMAR,			40.8, 32.8)
	AddMob(133827,	L["Mordvigbjorn"],			Z.STORMHEIM,			72.6, 50.0)
	AddMob(131863,	BN.RAAL_THE_GLUTTONOUS,			Z.WAYCREST_MANOR,		0.0, 0.0)

	self.InitializeMobDrops = nil
end
