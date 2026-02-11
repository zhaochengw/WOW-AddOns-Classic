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

	AddVendor(1286,		L["Edna Mullby"],			Z.STORMWIND_CITY,		64.7,	71.2,	"Alliance")
	AddVendor(1448,		L["Neal Allen"],			Z.WETLANDS,				11.8,	52.6,	"Alliance")
	AddVendor(3367,		L["Felika"],				Z.ORGRIMMAR,			60.5,	50.7,	"Horde")
	AddVendor(4775,		L["Felicia Doan"],			Z.UNDERCITY,			64.1,	50.6,	"Horde")
	AddVendor(5163,		L["Burbik Gearspanner"],	Z.IRONFORGE,			46.5,	27.1,	"Alliance")
	AddVendor(8363,		L["Shadi Mistrunner"],		Z.THUNDER_BLUFF,		40.6,	64.0,	"Horde")
	AddVendor(12941,	L["Jase Farlane"],			Z.EASTERN_PLAGUELANDS,	74.8,	51.8,	"Neutral")
	AddVendor(16624,	L["Gelanthis"],				Z.SILVERMOON_CITY,		90.9,	73.3,	"Horde")
	AddVendor(17512,	L["Arred"],					Z.THE_EXODAR,			45.9,	24.9,	"Alliance")
	AddVendor(17518,	L["Ythyar"],				Z.KARAZHAN,				0,		0,		"Neutral")
	AddVendor(19065,	L["Inessera"],				Z.SHATTRATH_CITY,		34.5,	20.2,	"Neutral")
	AddVendor(21474,	L["Coreiel"],				Z.NAGRAND_OUTLAND,		42.8,	42.6,	"Horde")
	AddVendor(21485,	L["Aldraan"],				Z.NAGRAND_OUTLAND,		42.9,	42.5,	"Alliance")
	AddVendor(23437,	L["Indormi"],				Z.HYJAL_SUMMIT,			0,		0,		"Neutral")
	AddVendor(25950,	L["Shaani"],				Z.ISLE_OF_QUELDANAS,	51.5,	32.6,	"Neutral")
	AddVendor(27666,	L["Ontuvo"],				Z.SHATTRATH_CITY,		48.7,	41.3,	"Neutral")
	AddVendor(28701,	L["Timothy Jones"],			Z.DALARAN_NORTHREND,	40.5,	35.2,	"Neutral")
	AddVendor(28721,	L["Tiffany Cartier"],		Z.DALARAN_NORTHREND,	40.5,	34.4,	"Neutral")
	AddVendor(30489,	L["Morgan Day"],			Z.WINTERGRASP,			49.0,	17.1,	"Alliance")
	AddVendor(31910,	L["Geen"],					Z.SHOLAZAR_BASIN,		54.5,	56.2,	"Neutral")
	AddVendor(31911,	L["Tanak"],					Z.SHOLAZAR_BASIN,		55.1,	69.1,	"Neutral")
	AddVendor(32294,	L["Knight Dameron"],		Z.WINTERGRASP,			51.7,	17.5,	"Alliance")
	AddVendor(32296,	L["Stone Guard Mukar"],		Z.WINTERGRASP,			51.7,	17.5,	"Horde")
	AddVendor(33602,	L["Anuur"],					Z.ICECROWN,				71.4,	20.8,	"Neutral")
	AddVendor(33637,	L["Kirembri Silvermane"],	Z.SHATTRATH_CITY,		58.1,	75.0,	"Neutral")
	AddVendor(33680,	L["Nemiha"],				Z.SHATTRATH_CITY,		36.1,	47.7,	"Neutral")
	AddVendor(44583,	L["Terrance Denman"],		Z.STORMWIND_CITY, 		63.2,	61.7,	"Alliance")
	AddVendor(50480,	L["Isabel Jones"],			Z.STORMWIND_CITY,		63.7,	61.3,	"Alliance")
	AddVendor(50482,	L["Marith Lazuria"],		Z.ORGRIMMAR,			72.5,	34.4,	"Horde")
	AddVendor(52584,	L["Laida Gembold"],			Z.IRONFORGE,			50.6,	27.5,	"Alliance")
	AddVendor(52588,	L["Sara Lanner"],			Z.UNDERCITY,			56.7,	36.9,	"Horde")
	AddVendor(52644,	L["Tarien Silverdew"],		Z.DARNASSUS,			54.4,	30.7,	"Alliance")
	AddVendor(52658,	L["Paku Cloudchaser"],		Z.THUNDER_BLUFF,		34.7,	53.5,	"Horde")
	AddVendor(56925,	L["Farrah Facet"],			Z.STORMWIND_CITY,		63.8,	61.6,	"Alliance")
	AddVendor(57922,	L["Taryssa Lazuria"],		Z.ORGRIMMAR,			72.4,	34.6,	"Horde")
	AddVendor(58414,	L["San Redscale"],			Z.THE_JADE_FOREST,		56.6,	44.4,	"Neutral")
	AddVendor(68363, 	L["Quackenbush"],			Z.DEEPRUN_TRAM,			54.4,	29.8,	"Alliance")
	AddVendor(68364,	L["Paul North"],			Z.BRAWLGAR_ARENA,		51.4,	27.4,	"Horde")
	AddVendor(77356,	L["Costan Highwall"],		Z.LUNARFALL,			0,		0,		"Alliance") -- Alliance Garrison
	AddVendor(79832,	L["Dorogarr"],				Z.FROSTWALL,			0,		0,		"Horde") -- Horde Garrison
	AddVendor(86379,	L["Dawn-Seeker Rikks"],		Z.WARSPEAR,				65.8,	64.6,	"Horde")
	AddVendor(86389,	L["Dawn-Seeker Verroak"],	Z.STORMSHIELD,			49.6,	61.6,	"Alliance")
	AddVendor(86387,	L["Dawn-Seeker Rilak"],		Z.STORMSHIELD,			50.0,	61.8,	"Alliance")
	AddVendor(86391,	L["Dawn-Seeker Krek"],		Z.STORMSHIELD,			50.6,	61.6,	"Alliance")
	AddVendor(87052,	L["Artificer Harlaan"],		Z.STORMSHIELD,			44.1,	37.5,	"Alliance") -- Alliance Ashran
	AddVendor(87548,	L["Kaevan Highwit"],		Z.WARSPEAR,				60.0,	40.4,	"Horde") -- Horde Ashran
	AddVendor(91322,	L["Dawn-Seeker Kayrek"],	Z.WARSPEAR,				65.6,	64.6,	"Horde")
	AddVendor(92501,	L["Dawn-Seeker Kasrek"],	Z.WARSPEAR,				51.6,	61.8,	"Horde")
	AddVendor(92503,	L["Dawn-Seeker Skariss"],	Z.WARSPEAR,				66.2,	62.8,	"Alliance")
	AddVendor(93526,	L["Tiffany Cartier"],		Z.DALARAN_BROKENISLES,	40.3,	34.7,	"Neutral")
	AddVendor(93527,	L["Timothy Jones"],			Z.DALARAN_BROKENISLES,	40.0,	35.2,	"Neutral")
	AddVendor(95424,	L["Dawn-Seeker Krisek"],	Z.TANAAN_JUNGLE,		57.8,	59.4,	"Alliance")
	AddVendor(95425,	L["Dawn-Seeker Krisek"],	Z.TANAAN_JUNGLE,		60.4,	46.6,	"Horde")   -- Blizzard needs to stop having the same NPC id in multiple places
	AddVendor(100500,	L["Jabrul"],				Z.DALARAN_BROKENISLES,	39.6,	34.8,	"Neutral")

	self.InitializeVendors = nil
end
