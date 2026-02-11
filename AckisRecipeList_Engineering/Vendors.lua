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

	AddVendor(1304,		L["Darian Singh"],					Z.STORMWIND_CITY,				42.6,	76.8,	"Alliance")
	AddVendor(2687,		L["Gnaz Blunderflame"],				Z.NORTHERN_STRANGLETHORN,		67.5,	61.5,	"Neutral")
	AddVendor(2688,		L["Ruppo Zipcoil"],					Z.THE_HINTERLANDS,				34.3,	37.9,	"Neutral")
	AddVendor(2838,		L["Crazk Sparks"],					Z.THE_CAPE_OF_STRANGLETHORN,	43.0,	72.8,	"Neutral")
	AddVendor(3413,		L["Sovik"],							Z.ORGRIMMAR,					56.8,	56.3,	"Horde")
	AddVendor(3495,		L["Gagsprocket"],					Z.NORTHERN_BARRENS,				68.4,	69.2,	"Neutral")
	AddVendor(5175,		L["Gearcutter Cogspinner"],			Z.IRONFORGE,					68.0,	43.1,	"Alliance")
	AddVendor(6730,		L["Jinky Twizzlefixxit"],			Z.THOUSAND_NEEDLES,				77.7,	77.8,	"Alliance")
	AddVendor(6777,		L["Zan Shivsproket"],				Z.HILLSBRAD_FOOTHILLS,			71.5,	45.5,	"Neutral")
	AddVendor(8131,		L["Blizrik Buckshot"],				Z.TANARIS,						50.7,	28.5,	"Neutral")
	AddVendor(8679,		L["Knaz Blunderflame"],				Z.NORTHERN_STRANGLETHORN,		67.7,	61.1,	"Neutral")
	AddVendor(11185,	L["Xizzer Fizzbolt"],				Z.WINTERSPRING,					59.2,	50.9,	"Neutral")
	AddVendor(14637,	L["Zorbin Fandazzle"],				Z.FERALAS,						48.7,	44.8,	"Neutral")
	AddVendor(16657,	L["Feera"],							Z.THE_EXODAR,		        	54.0,	90.5,	"Alliance")
	AddVendor(16782,	L["Yatheon"],						Z.SILVERMOON_CITY,				75.6,	40.7,	"Horde")
	AddVendor(18484,	L["Wind Trader Lathrai"],			Z.SHATTRATH_CITY,				72.3,	31.0,	"Neutral")
	AddVendor(18775,	L["Lebowski"],						Z.HELLFIRE_PENINSULA,			55.7,	65.5,	"Alliance")
	AddVendor(19351,	L["Daggle Ironshaper"],				Z.SHADOWMOON_VALLEY_OUTLAND,	36.8,	54.4,	"Alliance")
	AddVendor(19383,	L["Captured Gnome"],				Z.ZANGARMARSH,					32.5,	48.1,	"Horde")
	AddVendor(19661,	L["Viggz Shinesparked"],			Z.SHATTRATH_CITY,				64.9,	69.1,	"Neutral")
	AddVendor(19836,	L["Mixie Farshot"],					Z.HELLFIRE_PENINSULA,			61.1,	81.5,	"Horde")
	AddVendor(28722,	L["Bryan Landers"],					Z.DALARAN_NORTHREND,			39.1,	26.5,	"Neutral")
	AddVendor(33594,	L["Fizzix Blastbolt"],				Z.ICECROWN,						72.2,	20.9,	"Neutral")
	AddVendor(35826,	L["Kaye Toogie"],					Z.DALARAN_NORTHREND,			34.0,	35.6,	"Neutral")
	AddVendor(41435,	L["Fradd Swiftgear"],				Z.WETLANDS,						26.8,	26.0,	"Alliance")
	AddVendor(45546,	L["Vizna Bangwrench"],				Z.ORGRIMMAR,					36.4,	86.4,	"Horde")
	AddVendor(45843,	L["Yuka Screwspigot"],				Z.BLACKROCK_DEPTHS,				37.0,	79.0,	"Neutral")
	AddVendor(49918,	L["Buckslappy"],					Z.BADLANDS,						90.9,	38.8,	"Neutral")
	AddVendor(52655,	L["Palehoof's Big Bag of Parts"],	Z.THUNDER_BLUFF,				36.2,	60.2,	"Horde")
	AddVendor(67976,	L["Tinkmaster Overspark"],			Z.KRASARANG_WILDS,				16.5,	79.3,	"Alliance")
	AddVendor(77365,	L["Zaren Hoffle"],					Z.LUNARFALL,					0.0,	0.0,	"Alliance") -- Alliance Garrison
	AddVendor(79826,	L["Pozzlow"],						Z.FROSTWALL,					0.0,	0.0,	"Horde") -- Horde Garrison
	AddVendor(87065,	L["Sean Catchpole"],				Z.STORMSHIELD,					47.8,	40.6,	"Alliance") -- Alliance Ashran
	AddVendor(87552,	L["Nik Steelrings"],				Z.WARSPEAR,						70.6,	39.6,	"Horde") -- Alliance Ashran
	AddVendor(90866,	L["Tinkmaster Overspark"],			Z.STORMHEIM,					33.6,	50.8,	"Neutral")
	AddVendor(102196,	L["Fargo Flintlocke"],				Z.AZSUNA,						43.0,	62.8,	"Neutral")
	AddVendor(147070,	L["Micro Zoox"],					Z.DUN_MOROGH,					34.0,	37.6,	"Neutral")

	self.InitializeVendors = nil
end
