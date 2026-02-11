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

local Z = constants.ZONE_NAMES

-----------------------------------------------------------------------
-- What we _really_ came here to see...
-----------------------------------------------------------------------
function module:InitializeVendors()
	local function AddVendor(vendorID, vendorName, zoneName, coordX, coordY, faction)
		addon.AcquireTypes.Vendor:AddEntity(module, {
			coord_x = coordX,
			coord_y = coordY,
			faction = faction,
			identifier = vendorID,
			item_list = {},
			locationName = zoneName,
			name = vendorName,
		})
	end

	AddVendor(1685,		L["Xandar Goodbeard"],			Z.LOCH_MODAN,					82.5,	63.5,	"Alliance")
	AddVendor(2380,		L["Nandar Branson"],			Z.HILLSBRAD_FOOTHILLS,			50.8,	57.0,	"Alliance")
	AddVendor(2480,		L["Bro'kin"],					Z.HILLSBRAD_FOOTHILLS,			44.0,	21.8,	"Neutral")
	AddVendor(2812,		L["Drovnar Strongbrew"],		Z.ARATHI_HIGHLANDS,				46.4,	47.1,	"Alliance")
	AddVendor(2848,		L["Glyx Brewright"],			Z.THE_CAPE_OF_STRANGLETHORN,	42.6,	74.9,	"Neutral")
	AddVendor(3335,		L["Hagrus"],					Z.ORGRIMMAR,					46.0,	45.9,	"Horde")
	AddVendor(3348,		L["Kor'geld"],					Z.ORGRIMMAR,					55.23,	45.83,	"Horde")
	AddVendor(3490,		L["Hula'mahi"],					Z.NORTHERN_BARRENS,				48.6,	58.4,	"Horde")
	AddVendor(3956,		L["Harklan Moongrove"],			Z.ASHENVALE,					50.8,	67.0,	"Alliance")
	AddVendor(4083,		L["Jeeda"],						Z.STONETALON_MOUNTAINS,			50.5,	63.4,	"Horde")
	AddVendor(4226,		L["Ulthir"],					Z.DARNASSUS,					54.6,	38.9,	"Alliance")
	AddVendor(4610,		L["Algernon"],					Z.UNDERCITY,					51.7,	74.7,	"Horde")
	AddVendor(5178,		L["Soolie Berryfizz"],			Z.IRONFORGE,					66.6,	54.5,	"Alliance")
	AddVendor(5594,		L["Alchemist Pestlezugg"],		Z.TANARIS,						50.8,	28.0,	"Neutral")
	AddVendor(8157,		L["Logannas"],					Z.FERALAS,						46.6,	43.0,	"Alliance")
	AddVendor(8158,		L["Bronk"],						Z.FERALAS,						76.1,	43.3,	"Horde")
	AddVendor(8177,		L["Rartar"],					Z.SWAMP_OF_SORROWS,				47.2,	57.1,	"Horde")
	AddVendor(8178,		L["Nina Lightbrew"],			Z.BLASTED_LANDS,				62.4,	16.0,	"Alliance")
	AddVendor(11188,	L["Evie Whirlbrew"],			Z.WINTERSPRING,					59.2,	50.0,	"Neutral")
	AddVendor(15174,	L["Calandrath"],				Z.SILITHUS,						55.4,	36.6,	"Neutral")
	AddVendor(16588,	L["Apothecary Antonivich"],		Z.HELLFIRE_PENINSULA,			52.4,	36.5,	"Horde")
	AddVendor(16641,	L["Melaris"],					Z.SILVERMOON_CITY,				67.1,	19.5,	"Horde")
	AddVendor(16705,	L["Altaa"],						Z.THE_EXODAR,					27.5,	62.1,	"Alliance")
	AddVendor(18005,	L["Haalrun"],					Z.ZANGARMARSH,					67.8,	48.0,	"Alliance")
	AddVendor(18017,	L["Seer Janidi"],				Z.ZANGARMARSH,					32.4,	51.9,	"Horde")
	AddVendor(18802,	L["Alchemist Gribble"],			Z.HELLFIRE_PENINSULA,			53.8,	65.8,	"Alliance")
	AddVendor(19042,	L["Leeli Longhaggle"],			Z.TEROKKAR_FOREST,				57.7,	53.4,	"Alliance")
	AddVendor(19074,	L["Skreah"],					Z.SHATTRATH_CITY,				46.0,	20.1,	"Neutral")
	AddVendor(19837,	L["Daga Ramba"],				Z.BLADES_EDGE_MOUNTAINS,		51.1,	57.7,	"Horde")
	AddVendor(77363,	L["Mary Kearie"],				Z.LUNARFALL,					51.6,	63.6,	"Alliance") -- In Garrison
	AddVendor(79813,	L["Albert de Hyde"],			Z.FROSTWALL,					52.70,	41.92,	"Horde") -- In Garrison
	AddVendor(87048,	L["Katherine Joplin"],			Z.STORMSHIELD,					36.4,	69.0,	"Alliance") -- In Ashran
	AddVendor(87542,	L["Joshua Alvarez"],			Z.WARSPEAR,						60.8,	27.4,	"Horde") -- In Ashran
	AddVendor(92457,	L["Patricia Egan"],				Z.DALARAN_BROKENISLES,			42.1,	32.5,	"Neutral")
	AddVendor(122703,	L["Clever Kumali"], 			Z.DAZARALOR,					42.27,	38.13,	"Horde")
	AddVendor(125346,	L["Alchemist Funen"],			Z.KROKUUN,						56.2,	66.8,	"Neutral") --Needs updating
	AddVendor(132228,	L["Elric Whalgrene"],			Z.BORALUS,						74.6,	6.6,	"Alliance")

	self.InitializeVendors = nil
end
