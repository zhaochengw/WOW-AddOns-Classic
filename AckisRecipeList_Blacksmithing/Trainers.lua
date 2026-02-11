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
function module:InitializeTrainers()
	local function AddTrainer(trainerID, trainerName, zoneName, coordX, coordY, faction)
		return addon:AddTrainer(module, {
			coord_x = coordX,
			coord_y = coordY,
			faction = faction,
			identifier = trainerID,
			item_list = {},
			locationName = zoneName,
			name = trainerName,
		})
	end


	AddTrainer(514,  "Smith Argus", 			Z.ELWYNN_FOREST, 				41.7,	65.6,	"Alliance")
	AddTrainer(1241, "Tognus Flintfire", 		Z.DUN_MOROGH, 					45.3,	52.0,	"Alliance")
	AddTrainer(2836, "Brikk Keencraft", 		Z.THE_CAPE_OF_STRANGLETHORN,	44.1,	70.9,	"Neutral")
	AddTrainer(2998, "Karn Stonehoof", 			Z.THUNDER_BLUFF,				39.4,	55.1,	"Horde")
	AddTrainer(3136, "Clarise Gnarltree", 		Z.DUSKWOOD, 					74.0,	48.5,	"Alliance")
	AddTrainer(3174, "Dwukk", 					Z.DUROTAR,						52.0,	40.7,	"Horde")
	AddTrainer(3355, "Saru Steelfury", 			Z.ORGRIMMAR,					76.5,	34.5,	"Horde")
	AddTrainer(3478, "Traugh", 					Z.NORTHERN_BARRENS,				48.3,	56.2,	"Horde")
	AddTrainer(3557, "Guillaume Sorouy", 		Z.SILVERPINE_FOREST,			43.2,	41.0,	"Horde")
	AddTrainer(4258, "Bengus Deepforge", 		Z.IRONFORGE, 					51.0,	43.0,	"Alliance")
	AddTrainer(4596, "James Van Brunt", 		Z.UNDERCITY, 					61.2,	29.9,	"Horde")
	AddTrainer(4888, "Marie Holdston", 			Z.DUSTWALLOW_MARSH,				64.6,	50.1,	"Alliance")
	AddTrainer(5164, "Grumnus Steelshaper", 	Z.IRONFORGE,					50.2,	42.8,	"Alliance")
	AddTrainer(5511, "Therum Deepforge", 		Z.STORMWIND_CITY,				63.7,	37.0,	"Alliance")
	AddTrainer(6299, "Delfrum Flintbeard", 		Z.DARKSHORE,					38.2,	41.0,	"Alliance")
	AddTrainer(7230, "Shayis Steelfury", 		Z.ORGRIMMAR, 					75.9,	37.1,	"Horde")
	AddTrainer(7231, "Kelgruk Bloodaxe", 		Z.ORGRIMMAR,					76.3,	37.1,	"Horde")
	AddTrainer(11146, "Ironus Coldsteel", 		Z.IRONFORGE,					50.5,	43.3,	"Alliance")
	AddTrainer(11177, "Okothos Ironrager", 		Z.ORGRIMMAR,					75.3,	34.0,	"Horde")
	AddTrainer(11178, "Borgosh Corebender", 	Z.ORGRIMMAR,					75.9,	33.6,	"Horde")
	AddTrainer(15400, "Arathel Sunforge", 		Z.EVERSONG_WOODS,				59.6,	62.6,	"Horde")
	AddTrainer(16583, "Rohok", 					Z.HELLFIRE_PENINSULA,			53.2,	38.2,	"Horde")
	AddTrainer(16669, "Bemarrin", 				Z.SILVERMOON_CITY,				79.5,	39.0,	"Horde")
	AddTrainer(16724, "Miall", 					Z.THE_EXODAR,					60.0,	89.6,	"Alliance")
	AddTrainer(16823, "Humphry", 				Z.HELLFIRE_PENINSULA,			56.8,	63.8,	"Alliance")
	AddTrainer(17245, "Blacksmith Calypso", 	Z.AZUREMYST_ISLE,				46.4,	71.1,	"Alliance")
	AddTrainer(19341, "Grutah", 				Z.SHADOWMOON_VALLEY_OUTLAND,	29.7,	31.5,	"Horde")
	AddTrainer(20124, "Kradu Grimblade", 		Z.SHATTRATH_CITY,				69.2,	44.8,	"Neutral")
	AddTrainer(20125, "Zula Slagfury", 			Z.SHATTRATH_CITY,				70.1,	42.0,	"Neutral")
	AddTrainer(26564, "Borus Ironbender", 		Z.DRAGONBLIGHT,					36.6,	47.1,	"Horde")
	AddTrainer(26904, "Rosina Rivet", 			Z.HOWLING_FJORD,				59.6,	63.7,	"Alliance")
	AddTrainer(26952, "Kristen Smythe", 		Z.HOWLING_FJORD,				79.2,	29.0,	"Horde")
	AddTrainer(26981, "Crog Steelspine", 		Z.BOREAN_TUNDRA,				40.8,	55.3,	"Horde")
	AddTrainer(26988, "Argo Strongstout", 		Z.BOREAN_TUNDRA,				57.2,	66.6,	"Alliance")
	AddTrainer(27034, "Josric Fame", 			Z.DRAGONBLIGHT,					75.9,	63.2, 	"Horde")
	AddTrainer(28694, "Alard Schmied", 			Z.DALARAN_NORTHREND,			45.5,	28.5,	"Neutral")
	AddTrainer(29505, "Imindril Spearsong", 	Z.DALARAN_NORTHREND,			45.5,	28.6,	"Neutral")
	AddTrainer(29506, "Orland Schaeffer", 		Z.DALARAN_NORTHREND,			45.0,	28.4,	"Neutral")
	AddTrainer(29924, "Brandig", 				Z.THE_STORM_PEAKS,				28.9,	74.9,	"Alliance")
	AddTrainer(33591, "Rekka the Hammer", 		Z.ICECROWN,						71.9,	20.9,	"Neutral")
	AddTrainer(33609, "Blacksmithing", 			Z.SHATTRATH_CITY,				43.9,	90.5,	"Neutral")
	AddTrainer(33631, "Barien",					Z.SHATTRATH_CITY,				43.5,	65.1,	"Neutral")
	AddTrainer(33675, "Onodo", 					Z.SHATTRATH_CITY,				37.7,	30.3,	"Neutral")
	AddTrainer(37072, "Rogg", 					Z.ORGRIMMAR,					44.5,	78.0,	"Horde")
	AddTrainer(43429, "Taryel Firestrike", 		Z.DARKSHORE,					50.8,	19.2,	"Alliance")
	AddTrainer(44781, "Opuno Ironhorn", 		Z.ORGRIMMAR,					40.6,	49.4,	"Horde")
	AddTrainer(45548, "Kark Helmbreaker", 		Z.ORGRIMMAR,					36.0,	83.0,	"Horde")
	AddTrainer(52640, "Rolf Karner", 			Z.DARNASSUS,					56.8,	52.8,	"Alliance")
	AddTrainer(65114, "Len the Hammer", 		Z.THE_JADE_FOREST,				48.5,	36.8,	"Neutral")
	AddTrainer(65129, "Zen Master Lao", 		Z.VALE_OF_ETERNAL_BLOSSOMS,		21.6,	72.2,	"Neutral")
	AddTrainer(85917, "Aimee Goldforge", 		Z.STORMSHIELD,					43.8,	33.9,	"Alliance")
	AddTrainer(86048, "Mazdon Bizratchet", 		Z.WARSPEAR,						75.0,	37.4,	"Horde")
	AddTrainer(92183, "Alard Schmied",			Z.DALARAN_BROKENISLES,			44.2,	28.7,	"Neutral")
	AddTrainer(92264, "Felsmith Nal'ryssa",		Z.SURAMAR,						29.9,	53.2,	"Neutral")
	AddTrainer(92265, "Urael",					Z.SURAMAR,						30.1,	53.3,	"Neutral")
	AddTrainer(106655, "Arcanomancer Vridiel",	Z.DALARAN_BROKENISLES,			45.2,	29.0,	"Neutral")
	AddTrainer(127112, "Forgemaster Zak'aal", 	Z.DAZARALOR, 					43.66, 	38.04, 	"Horde")
	AddTrainer(133536, "Grix \"Ironfists\" Barlow", Z.BORALUS, 					73.56, 	8.56, 	"Alliance")
	AddTrainer(156666, "Smith Au'berk",			Z.ORIBOS, 						40.74,	32.19, 	"Neutral")

	self.InitializeTrainers = nil
end
