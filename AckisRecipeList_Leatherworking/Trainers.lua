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

	AddTrainer(1385, "Brawn", 			Z.NORTHERN_STRANGLETHORN, 	37.8, 50.4, "Horde")
	AddTrainer(1632, "Adele Fielder", 		Z.ELWYNN_FOREST, 		46.4, 62.1, "Alliance")
	AddTrainer(3007, "Una", 			Z.THUNDER_BLUFF, 		41.5, 42.6, "Horde")
	AddTrainer(3069, "Chaw Stronghide", 		Z.MULGORE, 			45.5, 57.9, "Horde")
	AddTrainer(3365, "Karolek", 			Z.ORGRIMMAR, 			62.8, 44.5, "Horde")
	AddTrainer(3549, "Shelene Rhobart", 		Z.TIRISFAL_GLADES, 		65.5, 61.0, "Horde")
	AddTrainer(3605, "Nadyia Maneweaver", 		Z.TELDRASSIL, 			41.8, 49.5, "Alliance")
	AddTrainer(3967, "Aayndia Floralwind", 		Z.ASHENVALE, 			35.9, 52.1, "Alliance")
	AddTrainer(4212, "Telonis", 			Z.DARNASSUS, 			60.5, 36.8, "Alliance")
	AddTrainer(4588, "Arthur Moore", 		Z.UNDERCITY, 			70.3, 58.5, "Horde")
	AddTrainer(5127, "Fimble Finespindle", 		Z.IRONFORGE, 			39.8, 33.5, "Alliance")
	AddTrainer(5564, "Simon Tanner", 		Z.STORMWIND_CITY, 		71.8, 62.9, "Alliance")
	AddTrainer(5784, "Waldor", 			Z.WAILING_CAVERNS, 		32.6, 28.5, "Neutral")
	AddTrainer(7868, "Sarah Tanner", 		Z.SEARING_GORGE, 		63.7, 75.7, "Alliance")
	AddTrainer(7869, "Brumn Winterhoof", 		Z.ARATHI_HIGHLANDS, 		28.2, 45.0, "Horde")
	AddTrainer(7871, "Se'Jib", 			Z.NORTHERN_STRANGLETHORN, 	45.3, 58.7, "Horde")
	AddTrainer(8153, "Narv Hidecrafter", 		Z.DESOLACE, 			55.3, 56.3, "Horde")
	AddTrainer(11097, "Drakk Stonehand", 		Z.THE_HINTERLANDS, 		13.4, 43.4, "Alliance")
	AddTrainer(11098, "Hahrana Ironhide", 		Z.FERALAS, 			74.4, 43.1, "Horde")
	AddTrainer(16278, "Sathein", 			Z.EVERSONG_WOODS, 		53.5, 51.0, "Horde")
	AddTrainer(16688, "Lynalis", 			Z.SILVERMOON_CITY, 		84.0, 80.2, "Horde")
	AddTrainer(16728, "Akham", 			Z.THE_EXODAR, 			66.0, 74.6, "Alliance")
	AddTrainer(17442, "Moordo", 			Z.AZUREMYST_ISLE, 		44.8, 23.8, "Alliance")
	AddTrainer(18754, "Barim Spilthoof", 		Z.HELLFIRE_PENINSULA, 		56.2, 38.6, "Horde")
	AddTrainer(18771, "Brumman", 			Z.HELLFIRE_PENINSULA, 		54.1, 64.0, "Alliance")
	AddTrainer(19187, "Darmari", 			Z.SHATTRATH_CITY, 		66.8, 67.1, "Neutral")
	AddTrainer(21087, "Grikka", 			Z.BLADES_EDGE_MOUNTAINS, 	76.8, 65.5, "Horde")
	AddTrainer(26911, "Bernadette Dexter", 		Z.HOWLING_FJORD, 		59.9, 63.6, "Alliance")
	AddTrainer(26961, "Gunter Hansen", 		Z.HOWLING_FJORD, 		78.3, 28.2, "Horde")
	AddTrainer(26996, "Awan Iceborn", 		Z.BOREAN_TUNDRA,		76.3, 37.0, "Horde")
	AddTrainer(26998, "Rosemary Bovard", 		Z.BOREAN_TUNDRA, 		57.6, 71.9, "Alliance")
	AddTrainer(28700, "Diane Cannings", 		Z.DALARAN_NORTHREND,		35.7, 28.8, "Neutral")
	AddTrainer(29507, "Manfred Staller",	 	Z.DALARAN_NORTHREND,		34.2, 29.5, "Neutral")
	AddTrainer(29508, "Andellion", 			Z.DALARAN_NORTHREND, 		34.5, 27.1, "Neutral")
	AddTrainer(29509, "Namha Moonwater", 		Z.DALARAN_NORTHREND, 		36.3, 29.4, "Neutral")
	AddTrainer(33581, "Kul'de", 			Z.ICECROWN, 			71.8, 20.8, "Neutral")
	AddTrainer(33612, "Leatherworking", 		Z.SHATTRATH_CITY, 		43.8, 90.9, "Neutral")
	AddTrainer(33635, "Daenril", 			Z.SHATTRATH_CITY, 		41.9, 63.4, "Neutral")
	AddTrainer(33681, "Korim", 			Z.SHATTRATH_CITY, 		37.6, 28.0, "Neutral")
	AddTrainer(53436, "Eustace Tanwell", 		Z.DUSTWALLOW_MARSH, 		66.4, 45.1, "Alliance")
	AddTrainer(65121, "Clean Pelt", 		Z.KUN_LAI_SUMMIT, 		64.6, 60.9, "Neutral")
	AddTrainer(66354, "Master Cannon", 		Z.KUN_LAI_SUMMIT, 		50.6, 42.0, "Neutral")
	AddTrainer(85920, "Jistun Sharpfeather",	Z.STORMSHIELD, 			52.5, 42.1, "Alliance")
	AddTrainer(86032, "Burga Stronghide", 		Z.WARSPEAR, 			50.2, 28.8, "Horde")
	AddTrainer(93522, "Diane Cannings",		Z.DALARAN_BROKENISLES,		35.6, 29.8, "Neutral")
	AddTrainer(93523, "Namha Moonwater",		Z.DALARAN_BROKENISLES,		35.4, 29.6, "Neutral")
	AddTrainer(98931, "Thanid Glowergold",		Z.DALARAN_BROKENISLES,		34.6, 28.6, "Neutral")
	AddTrainer(98948, "Hrul Sharphoof",		Z.THUNDER_BLUFF,		36.8, 78.2, "Neutral")
	AddTrainer(98950, "Namha Moonwater",		Z.DEADWIND_PASS,		43.0, 68.4, "Neutral")
	AddTrainer(98964, "Celea",			Z.AZSUNA,			47.5, 44.2, "Neutral")
	AddTrainer(122698, "Xanjo", 			Z.DAZARALOR, 			44.05, 34.50, "Horde")
	AddTrainer(136063, "Cassandra Brennor",		Z.BORALUS, 			75.6, 12.6, "Alliance")
	AddTrainer(156669, "Tanner Au'qil", 		Z.ORIBOS, 			42.52, 26.91, "Neutral")

	self.InitializeTrainers = nil
end
