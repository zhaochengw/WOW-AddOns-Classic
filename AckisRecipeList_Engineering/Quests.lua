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

local Z = constants.ZONE_NAMES

-----------------------------------------------------------------------
-- What we _really_ came here to see...
-----------------------------------------------------------------------
function module:InitializeQuests()
	local function AddQuest(questID, zoneName, coordX, coordY, faction)
		addon.AcquireTypes.Quest:AddEntity(module, {
			coord_x = coordX,
			coord_y = coordY,
			faction = faction,
			identifier = questID,
			item_list = {},
			locationName = zoneName,
			name = nil, -- Handled by memoizing table in the core.
		})
	end

	AddQuest(9635,	Z.ZANGARMARSH,			34.0,	50.8,	"Horde")
	AddQuest(9636,	Z.ZANGARMARSH,			68.6,	50.2,	"Alliance")
	AddQuest(12889,	Z.THE_STORM_PEAKS,		37.7,	46.5,	"Neutral")
	AddQuest(40858,	Z.AZSUNA,			65.2,	24.8,	"Neutral")
	AddQuest(40859,	Z.AZSUNA,			65.2,	24.8,	"Neutral")
	AddQuest(40861,	Z.VALSHARAH,			59.8,	62.2,	"Neutral")
	AddQuest(40862,	Z.VALSHARAH,			59.8,	62.2,	"Neutral")
	AddQuest(40863,	Z.DALARAN_BROKENISLES,		38.6,	25.0,	"Neutral")
	AddQuest(40864,	Z.DALARAN_BROKENISLES,		38.6,	25.0,	"Neutral")
	AddQuest(40866,	Z.STORMHEIM,			78.2,	57.2,	"Neutral")
	AddQuest(40868,	Z.STORMHEIM,			78.2,	57.2,	"Neutral")
	AddQuest(40869,	Z.DALARAN_BROKENISLES,		38.6,	25.0,	"Neutral")
	AddQuest(40870,	Z.DALARAN_BROKENISLES,		38.6,	25.0,	"Neutral")
	AddQuest(40872,	Z.AZSUNA,			43.0,	62.8,	"Neutral")
	AddQuest(40873,	Z.AZSUNA,			43.0,	62.8,	"Neutral")
	AddQuest(40875,	Z.AZSUNA,			43.0,	62.8,	"Neutral")
	AddQuest(40876,	Z.AZSUNA,			43.0,	62.8,	"Neutral")
	AddQuest(40877,	Z.DALARAN_BROKENISLES,		38.6,	25.0,	"Neutral")
	AddQuest(40878,	Z.DALARAN_BROKENISLES,		38.6,	25.0,	"Neutral")
	AddQuest(40879,	Z.DALARAN_BROKENISLES,		38.6,	25.0,	"Neutral")
	AddQuest(40880,	Z.DALARAN_BROKENISLES,		38.6,	25.0,	"Neutral")
	AddQuest(40881,	Z.TANARIS,			69.5,	68.4,	"Neutral")
	AddQuest(41675,	Z.AZSUNA,			46.8,	41.4,	"Neutral")
	AddQuest(41676,	Z.VALSHARAH,			54.6,	73.2,	"Neutral")
	AddQuest(41677,	Z.THUNDER_TOTEM,		38.4,	46.0,	"Neutral")
	AddQuest(41678,	Z.STORMHEIM,			60.2,	51.2,	"Neutral")
	AddQuest(41679,	Z.SURAMAR,			36.4,	46.8,	"Neutral")
	AddQuest(41680,	Z.DALARAN_BROKENISLES,		33.4,	47.8,	"Neutral")
	AddQuest(46128,	Z.DALARAN_BROKENISLES,		38.6,	25.0,	"Neutral")
	AddQuest(48056,	Z.DALARAN_BROKENISLES,		38.6,	25.0,	"Neutral")
	AddQuest(48065,	Z.DALARAN_BROKENISLES,		38.6,	25.0,	"Neutral")
	AddQuest(52363,	Z.BORALUS,			73.2,	11.0,	"Alliance")
	AddQuest(52364,	Z.DRUSTVAR,			37.8,	49.0,	"Alliance")
	AddQuest(52365,	Z.DRUSTVAR,			37.8,	49.0,	"Alliance")
	AddQuest(52366, Z.BORALUS,			67.6,	21.8,	"Alliance")
	AddQuest(52367,	Z.STORMSONG_VALLEY,		59.2,	69.4,	"Alliance")
	AddQuest(52368,	Z.BORALUS,			73.2,	11.0,	"Alliance")
	AddQuest(52369,	Z.DAZARALOR,			44.2,	32.2,	"Horde")
	AddQuest(52370, Z.VOLDUN,			56.6,	49.8,	"Horde")
	AddQuest(52371,	Z.VOLDUN,			56.6,	49.8,	"Horde")
	AddQuest(52372,	Z.NAZMIR,			39.0,	79.4,	"Horde")
	AddQuest(52373,	Z.DAZARALOR,			44.2,	32.2,	"Horde")
	AddQuest(52374,	Z.DAZARALOR,			44.2,	32.2,	"Horde")
	AddQuest(53937,	Z.DAZARALOR,			44.2,	32.2,	"Horde")
	AddQuest(53949,	Z.BORALUS,			77.4,	14.2,	"Alliance")

	self.InitializeQuests = nil
end
