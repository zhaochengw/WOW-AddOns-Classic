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

function addon:InitVendor()
	local function AddVendor(identifier, name, location, coord_x, coord_y, faction)
		return private.AcquireTypes.Vendor:AddEntity(addon, {
			coord_x = coord_x,
			coord_y = coord_y,
			faction = faction,
			identifier = identifier,
			item_list = {},
			locationName = location,
			name = name,
		})
	end

	AddVendor(66,		L["Tharynn Bouden"],			Z.ELWYNN_FOREST,		41.9,	67.1,	"Alliance") -- Cooking, Tailoring
	AddVendor(777,		L["Amy Davenport"],			Z.REDRIDGE_MOUNTAINS,		28.2,	43.6,	"Alliance") -- Leatherworking, Tailoring
	AddVendor(843,		L["Gina MacGregor"],			Z.WESTFALL,			57.6,	54.0,	"Alliance") -- Leatherworking, Tailoring
	AddVendor(989,		L["Banalash"],				Z.SWAMP_OF_SORROWS,		46.6,	56.9,	"Horde") -- Cooking, Enchanting, Jewelcrafting
	AddVendor(1148,		L["Nerrist"],				Z.NORTHERN_STRANGLETHORN,	39.2,	51.0,	"Horde") -- Cooking, Jewelcrafting
	AddVendor(1313,		L["Maria Lumere"],			Z.STORMWIND_CITY,		55.7,	85.5,	"Alliance") -- Alchemy, Enchanting, Engineering
	AddVendor(1318,		L["Jessara Cordell"],			Z.STORMWIND_CITY,		53.0,	74.2,	"Alliance") -- Enchanting, Tailoring
	AddVendor(2393,		L["Christoph Jeffcoat"],		Z.HILLSBRAD_FOOTHILLS,		57.5,	47.8,	"Horde") -- Alchemy, Jewelcrafting, Leatherworking, Tailoring
	AddVendor(2679,		L["Wenna Silkbeard"],			Z.WETLANDS,			25.7,	25.8,	"Alliance") -- Leatherworking, Tailoring
	AddVendor(2810,		L["Hammon Karwn"],			Z.ARATHI_HIGHLANDS,		46.5,	47.3,	"Alliance") -- Cooking, Jewelcrafting, Leatherworking
	AddVendor(2821,		L["Keena"],				Z.ARATHI_HIGHLANDS,		69.2,	33.6,	"Horde") -- Cooking, Jewelcrafting, Leatherworking
	AddVendor(3012,		L["Nata Dawnstrider"],			Z.THUNDER_BLUFF,		44.9,	37.7,	"Horde") -- Enchanting, Tailoring
	AddVendor(3134,		L["Kzixx"],				Z.DUSKWOOD,			81.9,	19.9,	"Neutral") -- Alchemy, Engineering
	AddVendor(3346,		L["Kithas"],				Z.ORGRIMMAR,			53.3,	48.9,	"Horde") -- Enchanting, Tailoring
	AddVendor(3499,		L["Ranik"],				Z.NORTHERN_BARRENS,		67.1,	73.5,	"Neutral") -- Alchemy, Jewelcrafting, Tailoring
	AddVendor(3537,		L["Zixil"],				Z.HILLSBRAD_FOOTHILLS,		49.8,	60.8,	"Neutral") -- Enchanting, Engineering, Leatherworking, Tailoring
	AddVendor(3556,		L["Andrew Hilbert"],			Z.SILVERPINE_FOREST,		43.2,	40.7,	"Horde") -- Cooking, Leatherworking, Tailoring
	AddVendor(3954,		L["Dalria"],				Z.ASHENVALE,			35.1,	52.1,	"Alliance") -- Enchanting, Jewelcrafting
	AddVendor(4228,		L["Vaean"],				Z.DARNASSUS,			56.4,	32.2,	"Alliance") -- Enchanting, Tailoring
	AddVendor(4229,		L["Mythrin'dir"],			Z.DARNASSUS,			58.1,	34.2,	"Alliance") -- Enchanting, Jewelcrafting
	AddVendor(4561,		L["Daniel Bartlett"],			Z.UNDERCITY,			64.1,	37.4,	"Horde") -- Enchanting, Jewelcrafting
	AddVendor(4617,		L["Thaddeus Webb"],			Z.UNDERCITY,			62.4,	61.0,	"Horde") -- Enchanting, Tailoring
	AddVendor(4897,		L["Helenia Olden"],			Z.DUSTWALLOW_MARSH,		66.4,	51.5,	"Alliance") -- Cooking, Jewelcrafting, Leatherworking
	AddVendor(5158,		L["Tilli Thistlefuzz"],			Z.IRONFORGE,			61.0,	44.0,	"Alliance") -- Enchanting, Tailoring
	AddVendor(5757,		L["Lilly"],				Z.SILVERPINE_FOREST,		43.1,	50.8,	"Horde") -- Enchanting, Tailoring
	AddVendor(5758,		L["Leo Sarn"],				Z.SILVERPINE_FOREST,		53.9,	82.3,	"Horde") -- Enchanting, Tailoring
	AddVendor(9499,		BN.PLUGGER_SPAZZRING,			Z.BLACKROCK_DEPTHS,		0,	0,	"Neutral") -- Alchemy, Leatherworking
	AddVendor(9636,		L["Kireena"],				Z.DESOLACE,			51.0,	53.5,	"Horde") -- Cooking, Jewelcrafting, Tailoring
	AddVendor(10856,	L["Argent Quartermaster Hasana"],	Z.TIRISFAL_GLADES,		83.2,	68.1,	"Neutral") -- Alchemy, Blacksmithing, Enchanting, Leatherworking, Tailoring
	AddVendor(10857,	L["Argent Quartermaster Lightspark"],	Z.WESTERN_PLAGUELANDS,		42.8,	83.8,	"Neutral") -- Alchemy, Blacksmithing, Enchanting, Leatherworking, Tailoring
	AddVendor(11189,	L["Qia"],				Z.WINTERSPRING,			59.6,	49.2,	"Neutral") -- Enchanting, Jewelcrafting, Leatherworking, Tailoring
	AddVendor(11278,	L["Magnus Frostwake"],			Z.WESTERN_PLAGUELANDS,		68.1,	77.6,	"Neutral") -- Alchemy, Blacksmithing
	AddVendor(11536,	L["Quartermaster Miranda Breechlock"],	Z.EASTERN_PLAGUELANDS,		75.8,	54.1,	"Neutral") -- Alchemy, Blacksmithing, Enchanting, Leatherworking, Tailoring
	AddVendor(11557,	L["Meilosh"],				Z.FELWOOD,			65.7,	2.9, 	"Neutral") -- Alchemy, Blacksmithing, Enchanting, Leatherworking, Tailoring
	AddVendor(12022,	L["Lorelae Wintersong"],		Z.MOONGLADE,			48.3,	40.1,	"Neutral") -- Enchanting, Tailoring
	AddVendor(12944,	L["Lokhtos Darkbargainer"],		Z.BLACKROCK_DEPTHS,		0,	0,	"Neutral") -- Alchemy, Blacksmithing, Enchanting, Leatherworking, Tailoring
	AddVendor(13420,	L["Penney Copperpinch"],		Z.ORGRIMMAR,			53.5,	66.1,	"Neutral") -- Cooking, Leatherworking, Tailoring
	AddVendor(13433,	L["Wulmort Jinglepocket"],		Z.IRONFORGE,			33.0,	67.6,	"Neutral") -- Cooking, Leatherworking, Tailoring
	AddVendor(15179,	L["Mishta"],				Z.SILITHUS,			53.8,	34.4,	"Neutral") -- Jewelcrafting, Tailoring
	AddVendor(15419,	L["Kania"],				Z.SILITHUS,			55.6,	37.2,	"Neutral") -- Enchanting, Tailoring
	AddVendor(15909,	L["Fariel Starsong"],			Z.MOONGLADE,			54.0,	35.4,	"Neutral") -- Engineering, Tailoring
	AddVendor(16635,	L["Lyna"],				Z.SILVERMOON_CITY,		70.3,	24.9,	"Horde") -- Enchanting, Tailoring
	AddVendor(16722,	L["Egomis"],				Z.THE_EXODAR,			39.9,	40.2,	"Alliance") -- Enchanting, Tailoring
	AddVendor(17585,	L["Quartermaster Urgronn"],		Z.HELLFIRE_PENINSULA,		54.9,	37.9,	"Horde") -- Alchemy, Blacksmithing, Enchanting, Jewelcrafting, Leatherworking
	AddVendor(17657,	L["Logistics Officer Ulrike"],		Z.HELLFIRE_PENINSULA,		56.7,	62.6,	"Alliance") -- Alchemy, Blacksmithing, Enchanting, Jewelcrafting, Leatherworking
	AddVendor(17904,	L["Fedryen Swiftspear"],		Z.ZANGARMARSH,			79.3,	63.8,	"Neutral") -- Alchemy, Blacksmithing, Enchanting, Engineering, Jewelcrafting, Leatherworking
	AddVendor(18011,	L["Zurai"],				Z.ZANGARMARSH,			85.3,	54.8,	"Horde") -- Cooking, Tailoring
	AddVendor(18255,	L["Apprentice Darius"],			Z.DEADWIND_PASS,		47.0,	75.3,	"Neutral") -- Enchanting, Jewelcrafting, Leatherworking
	AddVendor(18382,	L["Mycah"],				Z.ZANGARMARSH,			17.9,	51.2,	"Neutral") -- Alchemy, Cooking, Tailoring
	AddVendor(18753,	L["Felannia"],				Z.HELLFIRE_PENINSULA,		52.3,	36.1,	"Horde") -- Enchanting, Tailoring
	AddVendor(18773,	L["Johan Barnes"],			Z.HELLFIRE_PENINSULA,		53.7,	66.1,	"Alliance") -- Enchanting, Tailoring
	AddVendor(18821,	L["Quartermaster Jaffrey Noreliqe"],	Z.NAGRAND_OUTLAND,		41.2,	44.3,	"Horde") -- Alchemy, Jewelcrafting
	AddVendor(18822,	L["Quartermaster Davian Vaclav"],	Z.NAGRAND_OUTLAND,		41.2,	44.3,	"Alliance") -- Alchemy, Jewelcrafting
	AddVendor(18951,	L["Erilia"],				Z.EVERSONG_WOODS,		55.5,	54.0,	"Horde") -- Enchanting, Tailoring
	AddVendor(19234,	L["Yurial Soulwater"],			Z.SHATTRATH_CITY,		43.5,	96.9,	"Neutral") -- Enchanting, Tailoring
	AddVendor(19321,	L["Quartermaster Endarin"],		Z.SHATTRATH_CITY,		47.9,	26.1,	"Neutral") -- Blacksmithing, Jewelcrafting, Leatherworking, Tailoring
	AddVendor(19331,	L["Quartermaster Enuril"],		Z.SHATTRATH_CITY,		60.5,	64.2,	"Neutral") -- Alchemy, Blacksmithing, Jewelcrafting, Leatherworking, Tailoring
	AddVendor(19537,	L["Dealer Malij"],			Z.NETHERSTORM,			44.2,	34.0,	"Neutral") -- Enchanting, Tailoring
	AddVendor(19540,	L["Asarnan"],				Z.NETHERSTORM,			44.2,	33.7,	"Neutral") -- Enchanting, Tailoring
	AddVendor(19663,	L["Madame Ruby"],			Z.SHATTRATH_CITY,		63.1,	69.3,	"Neutral") -- Enchanting, Tailoring
	AddVendor(20240,	L["Trader Narasu"],			Z.NAGRAND_OUTLAND,		54.6,	75.2,	"Alliance") -- Alchemy, Leatherworking
	AddVendor(20241,	L["Provisioner Nasela"],		Z.NAGRAND_OUTLAND,		53.5,	36.9,	"Horde") -- Alchemy, Leatherworking
	AddVendor(20242,	L["Karaaz"],				Z.NETHERSTORM,			43.6,	34.3,	"Neutral") -- Enchanting, Engineering, Jewelcrafting, Leatherworking, Tailoring
	AddVendor(21432,	L["Almaador"],				Z.SHATTRATH_CITY,		51.0,	41.9,	"Neutral") -- Alchemy, Enchanting, Jewelcrafting, Leatherworking
	AddVendor(21643,	L["Alurmi"],				Z.TANARIS,			63.0,	57.3,	"Neutral") -- Alchemy, Enchanting, Jewelcrafting, Leatherworking
	AddVendor(21655,	L["Nakodu"],				Z.SHATTRATH_CITY,		62.1,	69.0,	"Neutral") -- Alchemy, Enchanting, Jewelcrafting, Tailoring
	AddVendor(23007,	L["Paulsta'ats"],			Z.NAGRAND_OUTLAND,		30.6,	57.0,	"Neutral") -- Enchanting, Engineering, Jewelcrafting, Leatherworking, Tailoring
	AddVendor(23159,	L["Okuno"],				Z.BLACK_TEMPLE,			0,	0,	"Neutral") -- Blacksmithing, Leatherworking, Tailoring
	AddVendor(25032,	L["Eldara Dawnrunner"],			Z.ISLE_OF_QUELDANAS,		47.1,	30.0,	"Neutral") -- Alchemy, Enchanting, Jewelcrafting
	AddVendor(26569,	L["Alys Vol'tyr"],			Z.DRAGONBLIGHT,			36.3,	46.5,	"Horde") -- Enchanting, Tailoring
	AddVendor(27030,	L["Bradley Towns"],			Z.DRAGONBLIGHT,			76.9,	62.2,	"Horde") -- Enchanting, Tailoring
	AddVendor(27054,	L["Modoru"],				Z.DRAGONBLIGHT,			28.9,	55.9,	"Alliance") -- Enchanting, Tailoring
	AddVendor(27147,	L["Librarian Erickson"],		Z.BOREAN_TUNDRA,		46.7,	32.5,	"Neutral") -- Enchanting, Tailoring
	AddVendor(28714,	L["Ildine Sorrowspear"],		Z.DALARAN_NORTHREND,		39.1,	41.5,	"Neutral") -- Enchanting, Tailoring
	AddVendor(30431,	L["Veteran Crusader Aliocha Segard"],	Z.ICECROWN,			87.6,	75.6,	"Neutral") -- Jewelcrafting, Tailoring
	AddVendor(31916,	L["Tanaika"],				Z.HOWLING_FJORD,		25.5,	58.7,	"Neutral") -- Jewelcrafting, Leatherworking, Tailoring
	AddVendor(32287,	L["Archmage Alvareaux"],		Z.DALARAN_NORTHREND,		25.5,	47.4,	"Neutral") -- Jewelcrafting, Tailoring
	AddVendor(32533,	L["Cielstrasza"],			Z.DRAGONBLIGHT,			59.9,	53.1,	"Neutral") -- Jewelcrafting, Tailoring
	AddVendor(32538,	L["Duchess Mynx"],			Z.ICECROWN,			43.5,	20.6,	"Neutral") -- Jewelcrafting, Tailoring
	AddVendor(32540,	L["Lillehoff"],				Z.THE_STORM_PEAKS,		66.2,	61.4,	"Neutral") -- Jewelcrafting, Leatherworking, Tailoring
	AddVendor(32564,	L["Logistics Officer Silverstone"],	Z.BOREAN_TUNDRA,		57.7,	66.5,	"Alliance") -- Blacksmithing, Engineering
	AddVendor(32565,	L["Gara Skullcrush"],			Z.BOREAN_TUNDRA,		41.4,	53.6,	"Horde") -- Blacksmithing, Engineering
	AddVendor(32763,	L["Sairuk"],				Z.DRAGONBLIGHT,			48.5,	75.7,	"Neutral") -- Jewelcrafting, Leatherworking, Tailoring
	AddVendor(32773,	L["Logistics Officer Brighton"],	Z.HOWLING_FJORD,		59.7,	63.9,	"Alliance") -- Blacksmithing, Engineering
	AddVendor(32774,	L["Sebastian Crane"],			Z.HOWLING_FJORD,		79.6,	30.7,	"Horde") -- Blacksmithing, Engineering
	AddVendor(37687,	L["Alchemist Finklestein"],		Z.ICECROWN_CITADEL,		0,	0,	"Neutral") -- Blacksmithing, Leatherworking, Tailoring
	AddVendor(46572,	L["Goram"],				Z.ORGRIMMAR,			48.2,	75.6,	"Horde") -- Alchemy, Cooking
	AddVendor(46602,	L["Shay Pressler"],			Z.STORMWIND_CITY,		64.6,	76.8,	"Alliance") -- Alchemy, Cooking
	AddVendor(51495,	L["Steeg Haskell"],			Z.IRONFORGE,			36.3,	85.8,	"Alliance") -- Alchemy, Cooking
	AddVendor(51496,	L["Kim Horn"],				Z.UNDERCITY,			69.6,	43.8,	"Horde") -- Alchemy, Cooking
	AddVendor(51503,	L["Randah Songhorn"],			Z.THUNDER_BLUFF,		37.6,	62.8,	"Horde") -- Alchemy, Cooking
	AddVendor(51512,	L["Mirla Silverblaze"],			Z.DALARAN_NORTHREND,		52.6,	56.6,	"Neutral") -- Alchemy, Cooking
	AddVendor(53214,	L["Damek Bloombeard"],			Z.MOLTEN_FRONT,			47.0,	90.6,	"Neutral") -- Blacksmithing, Engineering
	AddVendor(53410,	L["Lissah Spellwick"],			Z.DUSTWALLOW_MARSH,		66.0,	49.7,	"Alliance") -- Enchanting, Tailoring
	AddVendor(53881,	L["Ayla Shadowstorm"],			Z.MOLTEN_FRONT,			44.8,	86.6,	"Neutral") -- Leatherworking, Tailoring
	AddVendor(59908,	L["Jaluu the Generous"],		Z.VALE_OF_ETERNAL_BLOSSOMS,	74.2,	42.6,	"Neutral") -- Leatherworking, Tailoring
	AddVendor(64001,	L["Sage Lotusbloom"],			Z.VALE_OF_ETERNAL_BLOSSOMS,	62.6,	23.2,	"Horde") -- Needs updating
	AddVendor(64032,	L["Sage Whiteheart"],			Z.VALE_OF_ETERNAL_BLOSSOMS,	0.0,	0.0,	"Alliance") -- Enchanting, Tailoring  -- Needs updating
	AddVendor(90894,	L["Alexi Hackercam"],			Z.LUNARFALL,			34.6,	33.0,	"Alliance") -- Blacksmithing, Engineering, Jewelcrafting
	AddVendor(91030,	L["Trixxy Volt"],			Z.FROSTWALL,			40.8,	54.8,	"Horde") -- Blacksmithing, Engineering, Jewelcrafting
	AddVendor(91031,	L["Nicholas Mitrik"],			Z.FROSTWALL,			40.8,	54.8,	"Horde") -- Alchemy, Inscription
	AddVendor(91404,	L["Samantha Scarlet"],			Z.LUNARFALL,			34.6,	33.0,	"Alliance") -- Alchemy, Inscription
	AddVendor(93530,	L["Ildine Sorrowspear"],		Z.DALARAN_BROKENISLES,		38.3,	41.5,	"Neutral") -- Enchanting, Tailoring
	AddVendor(93539,	L["Hobart Grapplehammer"],		Z.DALARAN_BROKENISLES,		38.6,	25.2,	"Neutral") -- Jewelcrafting, Engineering, Inscription
	AddVendor(97360,	L["Matthew Rabis"],			Z.DALARAN_BROKENISLES,		46.0,	56.4,	"Neutral") -- Jewelcrafting, Skinning, Inscription
	AddVendor(97361,	L["Oxana Demonslay"],			Z.DALARAN_BROKENISLES,		67.0,	17.7,	"Neutral") -- Jewelcrafting, Inscription
	AddVendor(97362,	L["Dazzik \"Proudmoore\""],		Z.DALARAN_BROKENISLES,		66.2,	74.1,	"Neutral") -- Jewelcrafting, Tailoring
	AddVendor(97363,	L["K'huta"],				Z.DALARAN_BROKENISLES,		65.7,	80.3,	"Neutral") -- Enchanting, Inscription
	AddVendor(97366,	L["The Widow"],				Z.DALARAN_BROKENISLES,		71.8,	73.8,	"Neutral") -- Jewelcrafting, Engineering, Inscription
	AddVendor(97140,	L["First Arcanist Thalyssra"],		Z.SURAMAR,			36.8,	46.6,	"Neutral") -- Enchanting, Tailoring, Alchemy
	AddVendor(106901,	L["Sylvia Hartshorn"],			Z.VALSHARAH,			54.7,	73.2,	"Neutral") -- Enchanting, Leatherworking
	AddVendor(106902,	L["Ransa Greyfeather"],			Z.THUNDER_TOTEM,		38.8,	45.4,	"Neutral") -- Jewelcrafting, Blacksmithing
	AddVendor(106904,	L["Valdemar Stormseeker"],		Z.STORMHEIM,			60.2,	51.2,	"Neutral") -- Leatherworking, Blacksmithing
	AddVendor(107109,	L["Xur'ios"],				Z.DALARAN_BROKENISLES,		48.8,	13.5,	"Neutral") -- Leatherworking, Engineering, Blacksmithing, Enchanting, Inscription
	AddVendor(107376,	L["Veridis Fallon"],			Z.AZSUNA,			46.9,	41.4,	"Neutral") -- Inscriptions, Tailoring
	AddVendor(107379,	L["Marin Bladewing"],			Z.AZSUNA,			48.2,	73.8,	"Neutral") -- Inscription, Jewelcrafting, Engineering
	AddVendor(107760,	L["Strap Bucklebolt"],			Z.DALARAN_BROKENISLES,		66.4,	81.4,	"Neutral") -- Blacksmithing, Leatherworking, Tailoring
	AddVendor(115736,	L["First Arcanist Thalyssra"],		Z.SURAMAR,			36.8,	46.6,	"Neutral") -- Enchanting, Tailoring, Alchemy
	AddVendor(127120,	L["Vindicator Jaelaana"],		Z.ARGUS,			0.0,	0.0,	"Neutral") --Needs updating  -- Jewelcrafting, Blacksmithing, Tailoring
	AddVendor(127151,	L["Toraan the Revered"],		Z.ANTORAN_WASTES,		0.0,	0.0,	"Neutral") --Needs updating  -- Inscription, Alchemy, Enchanting
	AddVendor(131287,	L["Natal'hakata"],			Z.DAZARALOR,			65.2,	71.2,	"Horde")
	AddVendor(134345,	L["Collector Kojo"],			Z.ZULDAZAR,			71.4,	30.2,	"Neutral")
	AddVendor(135446,	L["Vindicator Jaelaana"],		Z.BORALUS,			69.0,	24.7,	"Alliance") -- Alchemy, Blacksmithing, Enchanting, Engineering, Jewelcrafting)
	AddVendor(135447,	L["Ransa Greyfeather"],			Z.ZULDAZAR,			58.0,	62.6,	"Horde") -- Alchemy, Blacksmithing, Enchanting, Engineering, Jewelcrafting)
	AddVendor(135459,	L["Provisioner Lija"],			Z.NAZMIR,			39.0,	79.4,	"Horde")
	AddVendor(135793,	L["Collector Kojo"],			Z.STORMSONG_VALLEY,		40.4,	36.4,	"Neutral")
	AddVendor(135800,	L["Sister Lilyana"],			Z.STORMSONG_VALLEY,		59.2,	69.4,	"Alliance")
	AddVendor(135804,	L["Hoarder Jena"],			Z.VOLDUN,			56.6,	49.8,	"Horde")
	AddVendor(135808,	L["Provisioner Fray"],			Z.BORALUS,			67.6,	21.9,	"Alliance") -- Alchemy,
	AddVendor(135815,	L["Quartermaster Alcorn"],		Z.DRUSTVAR,			37.8,	49.0,	"Alliance")
	AddVendor(142552,	L["Ozgrom Ragefang"],			Z.ZULDAZAR,			52.6,	58.2,	"Horde") -- PvP vendor with plans for all professions
	AddVendor(142564,	L["Leedan Gustaf"],			Z.BORALUS,			56.3,	27.2,	"Alliance") -- PvP vendor with plans for all professions
	AddVendor(153512,	L["Finder Pruc"],			Z.NAZJATAR,			49.0,	62.2,	"Horde") -- Alchemy, Cooking, Enchanting, Inscription
	AddVendor(153514,	L["Finder Palta"],			Z.NAZJATAR,			49.2,	62.0,	"Horde")
	AddVendor(154140,	L["Speaker Utia"],			Z.NAZJATAR,			38.0,	55.7,	"Alliance") -- Alchemy, Cooking, Enchanting, Inscription
	AddVendor(154652,	L["Dazzerian"],				Z.NAZJATAR,			48.6,	60.8,	"Horde") -- PvP vendor
	AddVendor(154653,	L["Crafticus Mindbender"],		Z.NAZJATAR,			38.1,	55.4,	"Alliance") -- PvP vendor
	AddVendor(150716,	L["Stolen Royal Vendorbot"],		Z.MECHAGON_ISLAND,		73.7,	36.9,	"Neutral")
	AddVendor(156822,	L["Mistress Mihaela"],			Z.REVENDRETH,			61.4,	63.8,	"Neutral")
	AddVendor(158556,	L["Aithlyn"],				Z.ARDENWEALD,			60.2,	35.2,	"Neutral") --Wild Hunt Quartermaster
	AddVendor(160470,	L["Adjutant Nikos"],			Z.BASTION,			52.2,	47.1,	"Neutral") --Ascended Quartermaster
	AddVendor(161565,	L["Bragni"],				Z.BORALUS,			56.4,	27.0,	"Neutral")
	AddVendor(162804,	L["Ve'nari"],				Z.THE_MAW,			46.8,	41.6,	"Neutral")
	AddVendor(173003,	L["Nalcorn Talsen"],			Z.MALDRAXXUS,			50.6,	53.4,	"Neutral") --Undying Army Quartermaster
	AddVendor(173705,	L["Archivist Janeera"],			Z.REVENDRETH,			73.0,	52.0,	"Neutral") --Avowed Quartermaster
	AddVendor(174914,	L["Elwyn"],				Z.ARDENWEALD,			59.4,	33.0,	"Neutral") --Renown Quartermaster in Ardenweald
	AddVendor(176064,	L["Adjutant Mikaros"],			Z.ORIBOS,			47.6,	77.6,	"Neutral") -- Ascended Quartermaster
	AddVendor(176065,	L["Liawyn"],				Z.ORIBOS,			47.0,	76.8,	"Neutral") -- Wild Hunt Quartermaster
	AddVendor(176066,	L["Darvel the Frugal"],			Z.ORBIOS,			46.6,	77.6,	"Neutral") -- Court of Harvesters Quartermaster
	AddVendor(176067,	L["Dar Vattish"],			Z.ORBIOS,			47.6,	77.6,	"Neutral") -- Undying Army Quartermaster
	AddVendor(176368,	L["Archivist Leonara"],			Z.ORBIOS,			46.6,	77.6,	"Neutral") -- Avowed Quartermaster
	AddVendor(178257,	L["Archivist Roh-Suir"],		Z.KORTHIA,			62.8,	22.6,	"Neutral")
	AddVendor(179321,	L["Duchess Mynx"],			Z.KORTHIA,			63.4,	23.4,	"Neutral")  -- Death's Advance Quartermaster
	AddVendor(182257,	L["Vilo"],				Z.ZERETH_MORTIS,		34.8,	64.2,	"Neutral")  --Enlightened Quartermaster
	AddVendor(183962,	L["Olea Manu"],				Z.ZERETH_MORTIS,		37.0,	44.6,	"Neutral")

	self.InitVendor = nil
end
