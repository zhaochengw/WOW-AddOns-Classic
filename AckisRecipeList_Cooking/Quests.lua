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

	AddQuest(384,	Z.DUN_MOROGH,			46.8,	52.5,	"Alliance")
	AddQuest(4161,	Z.TELDRASSIL,			57.0,	61.2,	"Alliance")
	AddQuest(6610,	Z.TANARIS,			52.6,	29.0,	"Neutral")
	AddQuest(8313,	Z.SILITHUS,			43.6,	42.0,	"Neutral")
	AddQuest(9171,	Z.GHOSTLANDS,			48.3,	30.9,	"Horde")
	AddQuest(9356,	Z.HELLFIRE_PENINSULA,		49.2,	74.8,	"Neutral")
	AddQuest(9454,	Z.AZUREMYST_ISLE,		49.8,	51.9,	"Alliance")
	AddQuest(10860,	Z.BLADES_EDGE_MOUNTAINS,	76.1,	60.3,	"Horde")
	AddQuest(11377,	Z.SHATTRATH_CITY,		61.6,	16.5,	"Neutral")
	AddQuest(11379,	Z.SHATTRATH_CITY,		61.6,	16.5,	"Neutral")
	AddQuest(11380,	Z.SHATTRATH_CITY,		61.6,	16.5,	"Neutral")
	AddQuest(11381,	Z.SHATTRATH_CITY,		61.6,	16.5,	"Neutral")
	AddQuest(11666,	Z.TEROKKAR_FOREST,		38.7,	12.8,	"Neutral")
	AddQuest(11667,	Z.TEROKKAR_FOREST,		38.7,	12.8,	"Neutral")
	AddQuest(11668,	Z.TEROKKAR_FOREST,		38.7,	12.8,	"Neutral")
	AddQuest(11669,	Z.TEROKKAR_FOREST,		38.7,	12.8,	"Neutral")
	AddQuest(13087,	Z.HOWLING_FJORD,		58.2,	62.1,	"Alliance")
	AddQuest(13088,	Z.BOREAN_TUNDRA,		57.9,	71.5,	"Alliance")
	AddQuest(13089,	Z.HOWLING_FJORD,		78.7,	29.5,	"Horde")
	AddQuest(13090,	Z.BOREAN_TUNDRA,		42.0,	54.2,	"Horde")
	AddQuest(13100,	Z.DALARAN_NORTHREND,		40.5,	65.8,	"Alliance")
	AddQuest(13101,	Z.DALARAN_NORTHREND,		40.5,	65.8,	"Alliance")
	AddQuest(13102,	Z.DALARAN_NORTHREND,		40.5,	65.8,	"Alliance")
	AddQuest(13103,	Z.DALARAN_NORTHREND,		40.5,	65.8,	"Alliance")
	AddQuest(13107,	Z.DALARAN_NORTHREND,		40.5,	65.8,	"Alliance")
	AddQuest(13112,	Z.DALARAN_NORTHREND,		70.0,	38.6,	"Horde")
	AddQuest(13113,	Z.DALARAN_NORTHREND,		70.0,	38.6,	"Horde")
	AddQuest(13114,	Z.DALARAN_NORTHREND,		70.0,	38.6,	"Horde")
	AddQuest(13115,	Z.DALARAN_NORTHREND,		70.0,	38.6,	"Horde")
	AddQuest(13116,	Z.DALARAN_NORTHREND,		70.0,	38.6,	"Horde")
	AddQuest(13571,	Z.DALARAN_NORTHREND,		0.0,	0.0,	"Neutral")
	AddQuest(26620,	Z.DUSKWOOD,			73.8,	43.6,	"Alliance")
	AddQuest(26623,	Z.DUSKWOOD,			73.8,	43.6,	"Alliance")
	AddQuest(26860,	Z.LOCH_MODAN,			34.9,	49.1,	"Alliance")
	AddQuest(33022, Z.VALLEY_OF_THE_FOUR_WINDS,	53.6,	51.2,	"Neutral")
	AddQuest(33024, Z.VALLEY_OF_THE_FOUR_WINDS,	53.6,	51.2,	"Neutral")
	AddQuest(33027, Z.VALLEY_OF_THE_FOUR_WINDS,	53.6,	51.2,	"Neutral")
	AddQuest(37536,	Z.AZSUNA,			48.0,	48.6,	"Neutral")
	AddQuest(37727,	Z.AZSUNA,			47.0,	41.4,	"Neutral")
	AddQuest(39117,	Z.VALSHARAH,			37.0,	58.4,	"Neutral")
	AddQuest(39867,	Z.HIGHMOUNTAIN,			40.0,	52.4,	"Neutral")
	AddQuest(40078,	Z.STORMHEIM,			60.2,	50.8,	"Neutral")
	AddQuest(40102,	Z.HIGHMOUNTAIN,			42.6,	10.8,	"Neutral")
	AddQuest(40988,	Z.BROKEN_ISLES,			0.0,	0.0,	"Neutral")
	AddQuest(40989,	Z.BROKEN_ISLES,			0.0,	0.0,	"Neutral")
	AddQuest(43331,	Z.STORMHEIM,			69.2,	28.0,	"Neutral")
	AddQuest(44581,	Z.DALARAN_BROKENISLES,		40.2,	65.8,	"Neutral")
	AddQuest(52344, Z.STORMSONG_VALLEY,		40.4,	36.4,	"Neutral")
	AddQuest(52345, Z.STORMSONG_VALLEY,		40.4,	36.4,	"Neutral")
	AddQuest(52346, Z.STORMSONG_VALLEY,		40.4,	36.4,	"Neutral")
	AddQuest(52347,	Z.STORMSONG_VALLEY,		40.4,	36.4,	"Neutral")
	AddQuest(52348, Z.ZULDAZAR,			71.4,	30.2,	"Neutral")
	AddQuest(52349, Z.ZULDAZAR,			71.4,	30.2,	"Neutral")
	AddQuest(52350,	Z.ZULDAZAR,			71.4,	30.2,	"Neutral")
	AddQuest(52351,	Z.ZULDAZAR,			71.4,	30.2,	"Neutral")
	AddQuest(54451, Z.STORMSONG_VALLEY,		40.4,	36.4,	"Neutral")
	AddQuest(56793,	Z.NAZJATAR,			38.0,	55.6,	"Alliance")
	AddQuest(56794,	Z.NAZJATAR,			38.0,	55.6,	"Alliance")
	AddQuest(56795, Z.NAZJATAR,			38.0,	55.6,	"Alliance")
	AddQuest(56796, Z.NAZJATAR,			38.0,	55.6,	"Alliance")
	AddQuest(56797,	Z.NAZJATAR,			38.0,	55.6,	"Alliance")
	AddQuest(56798,	Z.NAZJATAR,			50.8,	65.2,	"Horde")
	AddQuest(56799,	Z.NAZJATAR,			50.8,	65.2,	"Horde")
	AddQuest(56800,	Z.NAZJATAR,			50.8,	65.2,	"Horde")
	AddQuest(56801,	Z.NAZJATAR,			50.8,	65.2,	"Horde")
	AddQuest(56802,	Z.NAZJATAR,			50.8,	65.2,	"Horde")

	self.InitializeQuests = nil
end
