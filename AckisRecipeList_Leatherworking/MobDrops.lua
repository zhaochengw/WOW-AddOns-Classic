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

	AddMob(657,	L["Defias Pirate"],			Z.THE_DEADMINES,		0, 0)
	AddMob(938,	L["Kurzen Commando"],			Z.NORTHERN_STRANGLETHORN,	60.9, 16.3)
	AddMob(1160,	L["Captain Halyndor"],			Z.WETLANDS,			15.0, 24.0)
	AddMob(1561,	L["Bloodsail Raider"],			Z.THE_CAPE_OF_STRANGLETHORN,	44.0, 63.8)
	AddMob(1732,	L["Defias Squallshaper"],		Z.THE_DEADMINES,		0, 0)
	AddMob(2644,	L["Vilebranch Hideskinner"],		Z.THE_HINTERLANDS,		62.2, 69.2)
	AddMob(3385,	L["Theramore Marine"],			Z.NORTHERN_BARRENS,		71.5, 86.6)
	AddMob(3386,	L["Theramore Preserver"],		Z.NORTHERN_BARRENS,		71.5, 86.6)
	AddMob(6557,	L["Primal Ooze"],			Z.UNGORO_CRATER,		51.8, 34.9)
	AddMob(6559,	L["Glutinous Ooze"],			Z.UNGORO_CRATER,		39.0, 37.7)
	AddMob(7035,	L["Firegut Brute"],			Z.BURNING_STEPPES,		82.5, 48.1)
	AddMob(7158,	L["Deadwood Shaman"],			Z.FELWOOD,			62.5, 10.3)
	AddMob(7438,	L["Winterfall Ursa"],			Z.WINTERSPRING,			67.5, 36.3)
	AddMob(7440,	L["Winterfall Den Watcher"],		Z.WINTERSPRING,			68.0, 35.5)
	AddMob(7441,	L["Winterfall Totemic"],		Z.WINTERSPRING,			24.2, 50.4)
	AddMob(8898,	L["Anvilrage Marshal"],			Z.BLACKROCK_DEPTHS,		0, 0)
	AddMob(8903,	L["Anvilrage Captain"],			Z.BLACKROCK_DEPTHS,		0, 0)
	AddMob(9259,	L["Firebrand Grunt"],			Z.BLACKROCK_SPIRE,		0, 0)
	AddMob(9260,	L["Firebrand Legionnaire"],		Z.BLACKROCK_SPIRE,		0, 0)
	AddMob(17820,	L["Durnholde Rifleman"],		Z.OLD_HILLSBRAD_FOOTHILLS,	0, 0)
	AddMob(17839,	L["Rift Lord"],				Z.THE_BLACK_MORASS,		0, 0)
	AddMob(18322,	L["Sethekk Ravenguard"],		Z.SETHEKK_HALLS,		0, 0)
	AddMob(18667,	BN.BLACKHEART_THE_INCITER,		Z.SHADOW_LABYRINTH,		0, 0)
	AddMob(21104,	L["Rift Keeper"],			Z.THE_BLACK_MORASS,		0, 0)
	AddMob(22143,	L["Gordunni Back-Breaker"],		Z.TEROKKAR_FOREST,		21.2, 8.1)
	AddMob(22144,	L["Gordunni Elementalist"],		Z.TEROKKAR_FOREST,		21.3, 12.0)
	AddMob(22148,	L["Gordunni Head-Splitter"],		Z.TEROKKAR_FOREST,		22.5, 8.3)
	AddMob(23022,	L["Gordunni Soulreaper"],		Z.TEROKKAR_FOREST,		22.9, 8.8)
	AddMob(28132,	L["Don Carlos"],			Z.OLD_HILLSBRAD_FOOTHILLS,	0, 0)
	AddMob(122367,	BN.ANTORAN_HIGH_COMMAND,		Z.ANTORUS__THE_BURNING_THRONE)

	self.InitializeMobDrops = nil
end
