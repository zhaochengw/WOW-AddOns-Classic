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

	AddTrainer(1103, "Eldrin", 			Z.ELWYNN_FOREST, 		79.3, 69.0, "Alliance")
	AddTrainer(1346, "Georgio Bolero", 		Z.STORMWIND_CITY, 		53.2, 81.5, "Alliance")
	AddTrainer(2329, "Michelle Belle",		Z.ELWYNN_FOREST,		43.4, 65.6, "Alliance")
	AddTrainer(2399, "Daryl Stack", 		Z.HILLSBRAD_FOOTHILLS, 		58.1, 48.0, "Horde")
	AddTrainer(2627, "Grarnik Goodstitch",	 	Z.THE_CAPE_OF_STRANGLETHORN, 	43.6, 73.0, "Neutral")
	AddTrainer(3004, "Tepa", 			Z.THUNDER_BLUFF, 		44.5, 45.3, "Horde")
	AddTrainer(3363, "Magar", 			Z.ORGRIMMAR, 			63.5, 50.0, "Horde")
	AddTrainer(3484, "Kil'hala", 			Z.NORTHERN_BARRENS, 		49.9, 61.2, "Horde")
	AddTrainer(3523, "Bowen Brisboise", 		Z.TIRISFAL_GLADES, 		52.6, 55.6, "Horde")
	AddTrainer(3704, "Mahani", 			Z.SOUTHERN_BARRENS, 		41.5, 46.9, "Horde")
	AddTrainer(4159, "Me'lynn", 			Z.DARNASSUS, 			59.8, 37.4, "Alliance")
	AddTrainer(4576, "Josef Gregorian", 		Z.UNDERCITY, 			70.7, 30.3, "Horde")
	AddTrainer(4578, "Josephine Lister", 		Z.UNDERCITY, 			86.5, 22.3, "Horde")
	AddTrainer(4591, "Mary Edras", 			Z.UNDERCITY, 			73.6, 55.5, "Horde")
	AddTrainer(5150, "Nissa Firestone", 		Z.IRONFORGE,			54.8, 58.6, "Alliance")
	AddTrainer(5153, "Jormund Stonebrow", 		Z.IRONFORGE, 			43.2, 29.0, "Alliance")
	AddTrainer(5759, "Nurse Neela", 		Z.TIRISFAL_GLADES,		59.8, 52.2, "Horde")
	AddTrainer(5943, "Rawrk", 			Z.DUROTAR, 			54.1, 41.9, "Horde")
	AddTrainer(9584, "Jalane Ayrole", 		Z.STORMWIND_CITY, 		40.4, 84.6, "Alliance")
	AddTrainer(11052, "Timothy Worthington", 	Z.DUSTWALLOW_MARSH, 		66.2, 51.7, "Alliance")
	AddTrainer(11557, "Meilosh", 			Z.FELWOOD, 			65.7, 02.9, "Neutral")
	AddTrainer(12939, "Doctor Gustaf VanHowzen", 	Z.DUSTWALLOW_MARSH, 		67.7, 48.9, "Alliance")
	AddTrainer(16366, "Sempstress Ambershine", 	Z.EVERSONG_WOODS, 		37.4, 71.9, "Horde")
	AddTrainer(16640, "Keelen Sheets", 		Z.SILVERMOON_CITY, 		57.0, 50.1, "Horde")
	AddTrainer(16662, "Alestus",			Z.SILVERMOON_CITY, 		77.9, 70.7, "Horde")
	AddTrainer(16729, "Refik", 			Z.THE_EXODAR, 			63.0, 67.9, "Alliance")
	AddTrainer(17487, "Erin Kelly", 		Z.AZUREMYST_ISLE, 		46.2, 70.5, "Alliance")
	AddTrainer(18749, "Dalinna", 			Z.HELLFIRE_PENINSULA, 		56.6, 37.1, "Horde")
	AddTrainer(18772, "Hama", 			Z.HELLFIRE_PENINSULA, 		54.1, 63.6, "Alliance")
	AddTrainer(23734, "Anchorite Yazmina", 		Z.HOWLING_FJORD,		59.8, 62.2, "Alliance")
	AddTrainer(26914, "Benjamin Clegg", 		Z.HOWLING_FJORD, 		58.6, 62.8, "Alliance")
	AddTrainer(26956, "Sally Tompkins",		Z.HOWLING_FJORD,		79.4, 29.4, "Horde")
	AddTrainer(26964, "Alexandra McQueen", 		Z.HOWLING_FJORD, 		79.4, 30.7, "Horde")
	AddTrainer(26969, "Raenah", 			Z.BOREAN_TUNDRA, 		41.6, 53.5, "Horde")
	AddTrainer(26992, "Brynna Wilson", 		Z.BOREAN_TUNDRA, 		57.8, 66.4, "Alliance")
	AddTrainer(27001, "Darin Goodstitch", 		Z.BOREAN_TUNDRA, 		57.5, 72.3, "Alliance")
	AddTrainer(28699, "Charles Worth", 		Z.DALARAN_NORTHREND, 		36.5, 33.5, "Neutral")
	AddTrainer(28706, "Olisarra the Kind", 		Z.DALARAN_NORTHREND, 		36.7, 37.3, "Neutral")
	AddTrainer(29233, "Nurse Applewood", 		Z.BOREAN_TUNDRA,		41.7, 54.4, "Horde")
	AddTrainer(33580, "Dustin Vail", 		Z.ICECROWN, 			73.0, 20.8, "Neutral")
	AddTrainer(33613, "Tailoring", 			Z.SHATTRATH_CITY, 		44.0, 91.1, "Neutral")
	AddTrainer(33621, "Bandage Recipes", 		Z.SHATTRATH_CITY, 		43.60, 91.38, "Neutral")
	AddTrainer(33636, "Miralisse", 			Z.SHATTRATH_CITY, 		41.6, 63.5, "Neutral")
	AddTrainer(33684, "Weaver Aoa", 		Z.SHATTRATH_CITY, 		37.6, 27.2, "Neutral")
	AddTrainer(43428, "Faeyrin Willowmoon", 	Z.DARKSHORE, 			50.6, 20.8, "Alliance")
	AddTrainer(44783, "Hiwahi Three-Feathers", 	Z.ORGRIMMAR, 			38.8, 50.5, "Horde")
	AddTrainer(45540, "Krenk Choplimb", 		Z.ORGRIMMAR, 			38.4, 86.2, "Horde")
	AddTrainer(45559, "Nivi Weavewell", 		Z.ORGRIMMAR, 			41.1, 79.7, "Horde")
	AddTrainer(57405, "Silkmaster Tsai", 		Z.VALLEY_OF_THE_FOUR_WINDS, 	62.6, 59.8, "Alliance")
	AddTrainer(65862, "Ala'thinel", 		Z.VALE_OF_ETERNAL_BLOSSOMS,	28.6, 73.5, "Horde") -- Needs updating
	AddTrainer(66222, "Elder Muur", 		Z.THE_JADE_FOREST,		28.3, 15.3, "Horde")
	AddTrainer(85910, "Joshua Fuesting", 		Z.STORMSHIELD, 			51.9, 37.4, "Alliance")
	AddTrainer(85930, "Telys Vinemender", 		Z.STORMSHIELD, 			47.0, 31.2, "Alliance")
	AddTrainer(86004, "Saesha Silverblood", 	Z.WARSPEAR, 			59.2, 41.4, "Horde")
	AddTrainer(86034, "Wei Suremend", 		Z.WARSPEAR, 			65.38, 51.44, "Horde")
	AddTrainer(93525, "Ainderu Summerleaf",		Z.DALARAN_BROKENISLES,		36.2, 33.8, "Neutral")
	AddTrainer(93529, "Olisarra the Kind", 		Z.DALARAN_BROKENISLES, 		36.1, 37.3, "Neutral")
	AddTrainer(93542, "Tanithria",			Z.DALARAN_BROKENISLES,		35.8, 33.4, "Neutral")
	AddTrainer(122700, "Pin'jin the Patient", 	Z.DAZARALOR, 			44.41, 33.81, "Horde")
	AddTrainer(136071, "Daniel Brineweaver",	Z.BORALUS,			76.9, 11.2, "Alliance")
	AddTrainer(156681, "Stitcher Au'phes", 		Z.ORIBOS,			45.17, 32.05, "Neutral")

	self.InitializeTrainers = nil
end
