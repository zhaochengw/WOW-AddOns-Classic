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

	AddVendor(2697,		L["Clyde Ranthal"],			Z.REDRIDGE_MOUNTAINS,			78.6,	63.6,	"Alliance")
	AddVendor(2698,		L["George Candarte"],		Z.HILLSBRAD_FOOTHILLS,			76.7,	58.5,	"Horde")
	AddVendor(2699,		L["Rikqiz"],				Z.THE_CAPE_OF_STRANGLETHORN,	43.2,	71.7,	"Neutral")
	AddVendor(2816,		L["Androd Fadran"],			Z.ARATHI_HIGHLANDS,				39.2,	48.2,	"Alliance")
	AddVendor(2819,		L["Tunkk"],					Z.ARATHI_HIGHLANDS,				70.0,	35.4,	"Horde")
	AddVendor(2846,		L["Blixrez Goodstitch"],	Z.THE_CAPE_OF_STRANGLETHORN,	42.8,	74.1,	"Neutral")
	AddVendor(3008,		L["Mak"],					Z.THUNDER_BLUFF,				42.0,	43.5,	"Horde")
	AddVendor(3366,		L["Tamar"],					Z.ORGRIMMAR,					60.3,	54.3,	"Horde")
	AddVendor(3958,		L["Lardan"],				Z.ASHENVALE,					34.8,	49.8,	"Alliance")
	AddVendor(4225,		L["Saenorion"],				Z.DARNASSUS,					60.0,	37.3,	"Alliance")
	AddVendor(4589,		L["Joseph Moore"],			Z.UNDERCITY,					70.0,	58.5,	"Horde")
	AddVendor(5128,		L["Bombus Finespindle"],	Z.IRONFORGE,					39.6,	34.5,	"Alliance")
	AddVendor(5565,		L["Jillian Tanner"],		Z.STORMWIND_CITY,				71.6,	62.8,	"Alliance")
	AddVendor(7854,		L["Jangdor Swiftstrider"],	Z.FERALAS,						52.8,	47.1,	"Horde")
	AddVendor(8160,		L["Nioma"],					Z.THE_HINTERLANDS,				13.4,	43.3,	"Alliance")
	AddVendor(12942,	L["Leonard Porter"],		Z.WESTERN_PLAGUELANDS,			43.0,	84.3,	"Alliance")
	AddVendor(12943,	L["Werg Thickblade"],		Z.TIRISFAL_GLADES,				83.2,	69.7,	"Horde")
	AddVendor(12956,	L["Zannok Hidepiercer"],	Z.SILITHUS,						81.9,	17.8,	"Neutral")
	AddVendor(12958,	L["Gigget Zipcoil"],		Z.THE_HINTERLANDS,				34.5,	38.5,	"Neutral")
	AddVendor(12959,	L["Nergal"],				Z.UNGORO_CRATER,				54.8,	62.5,	"Neutral")
	AddVendor(15293,	L["Aendel Windspear"],		Z.SILITHUS,						64.6,	45.8,	"Neutral")
	AddVendor(16689,	L["Zaralda"],				Z.SILVERMOON_CITY,				84.8,	78.6,	"Horde")
	AddVendor(16748,	L["Haferet"],				Z.THE_EXODAR,					66.6,	73.7,	"Alliance")
	AddVendor(18672,	L["Thomas Yance"],			Z.OLD_HILLSBRAD_FOOTHILLS,		0,		0,		"Neutral")
	AddVendor(32515,	L["Braeg Stoutbeard"],		Z.DALARAN_NORTHREND,			37.6,	29.5,	"Neutral")
	AddVendor(34601,	L["Harlown Darkweave"],		Z.ASHENVALE,					18.2,	60.0,	"Alliance")
	AddVendor(40226,	L["Pratt McGrubben"],		Z.FERALAS,						45.4,	41.2,	"Alliance")
	AddVendor(50172,	L["Threm Blackscalp"],		Z.TWILIGHT_HIGHLANDS,			75.2,	50.1,	"Horde")
	AddVendor(50381,	L["Misty Merriweather"],	Z.TWILIGHT_HIGHLANDS,			78.8,	76.2,	"Alliance")
	AddVendor(64054,	L["Krogo Darkhide"],		Z.VALE_OF_ETERNAL_BLOSSOMS,		31.2,	47.0,	"Horde") -- Needs updating
	AddVendor(64094,	L["Tanner Pang"],			Z.VALE_OF_ETERNAL_BLOSSOMS,		76.8, 	49.0,	"Alliance") -- Needs updating
	AddVendor(77383,	L["Anders Longstitch"],		Z.LUNARFALL,			 		0.0,	 0.0,	"Alliance") -- Alliance Garrison
	AddVendor(79834,	L["Murne Greenhoof"],		Z.FROSTWALL,			 		0.0,	 0.0,	"Horde") -- Horde Garrison
	AddVendor(87057,	L["Leara Moonsilk"],		Z.STORMSHIELD,					52.4,	42.2,	"Alliance") -- Alliance Ashran
	AddVendor(87549,	L["Garm Gladestride"],		Z.WARSPEAR,						50.6,	27.8,	"Horde") -- Horde Ashran
	AddVendor(91024,	L["Jake the Fox"],			Z.LUNARFALL,					34.6,	33.0,	"Alliance") -- Alliance Garrison
	AddVendor(91033,	L["Zeezu"],					Z.FROSTWALL,					40.8,	54.8,	"Horde") -- Horde Garrison
	AddVendor(93521,	L["Ranid Glowergold"],		Z.DALARAN_BROKENISLES,			34.4,	28.4,	"Neutral")
	AddVendor(97364,	L["Laura Malley"],			Z.DALARAN_BROKENISLES,			58.4,	57.5,	"Neutral")
	AddVendor(98969,	L["Stalriss Dawnrunner"],	Z.SURAMAR,						26.6,	71.6,	"Neutral")

	self.InitializeVendors = nil
end
