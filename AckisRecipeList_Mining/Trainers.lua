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


	AddTrainer(1443, "Stonebreaker Ruian",		Z.THE_JADE_FOREST, 		27.8, 14.8, "Horde")
	AddTrainer(1681, "Brock Stoneseeker",		Z.LOCH_MODAN, 			37.1, 47.8, "Alliance")
	AddTrainer(1701, "Dank Drizzlecut",			Z.DUN_MOROGH, 			76.6, 53.8, "Alliance")
	AddTrainer(3001, "Brek Stonehoof",			Z.THUNDER_BLUFF, 		34.4, 57.9, "Horde")
	AddTrainer(3137, "Matt Johnson",			Z.DUSKWOOD, 			74.0, 49.7, "Alliance")
	AddTrainer(3175, "Krunn",					Z.DUROTAR, 				51.9, 40.9, "Horde")
	AddTrainer(3357, "Makaru",					Z.ORGRIMMAR, 			72.3, 34.9, "Horde")
	AddTrainer(3555, "Johan Focht",				Z.SILVERPINE_FOREST, 	43.4, 40.5, "Horde")
	AddTrainer(4254, "Geofram Bouldertoe", 		Z.IRONFORGE, 			50.3, 26.0, "Alliance")
	AddTrainer(4598, "Brom Killian", 			Z.UNDERCITY, 			55.8, 37.0, "Horde")
	AddTrainer(5392, "Yarr Hammerstone", 		Z.DUN_MOROGH, 			50.0, 50.3, "Alliance")
	AddTrainer(5513, "Gelman Stonehand", 		Z.STORMWIND_CITY, 		59.5, 37.8, "Alliance")
	AddTrainer(6297, "Kurdram Stonehammer", 	Z.DARKSHORE, 			38.2, 41.1, "Alliance")
	AddTrainer(8128, "Pikkle", 					Z.TANARIS, 				51.0, 29.1, "Neutral")
	AddTrainer(16663, "Belil", 					Z.SILVERMOON_CITY, 		79.1, 42.9, "Horde")
	AddTrainer(16752, "Muaat", 					Z.THE_EXODAR, 			60.0, 87.9, "Alliance")
	AddTrainer(17488, "Dulvi", 					Z.AZUREMYST_ISLE, 		48.9, 51.1, "Alliance")
	AddTrainer(18747, "Krugosh", 				Z.HELLFIRE_PENINSULA, 	55.5, 37.6, "Horde")
	AddTrainer(18779, "Hurnak Grimmord", 		Z.HELLFIRE_PENINSULA, 	56.7, 63.8, "Alliance")
	AddTrainer(18804, "Prospector Nachlan", 	Z.BLOODMYST_ISLE, 		56.3, 54.3, "Alliance")
	AddTrainer(26912, "Grumbol Stoutpick", 		Z.HOWLING_FJORD, 		59.9, 63.9, "Alliance")
	AddTrainer(26962, "Jonathan Lewis", 		Z.HOWLING_FJORD, 		79.3, 29.0, "Horde")
	AddTrainer(26976, "Brunna Ironaxe", 		Z.BOREAN_TUNDRA, 		42.6, 53.2, "Horde")
	AddTrainer(26999, "Fendrig Redbeard", 		Z.BOREAN_TUNDRA, 		57.5, 66.2, "Alliance")
	AddTrainer(28698, "Jedidiah Handers", 		Z.DALARAN_NORTHREND, 	41.5, 26.0, "Neutral")
	AddTrainer(33617, "Smelting", 				Z.SHATTRATH_CITY, 		43.6, 90.9, "Neutral")
	AddTrainer(33640, "Hanlir", 				Z.SHATTRATH_CITY, 		58.0, 75.0, "Neutral")
	AddTrainer(33682, "Fono", 					Z.SHATTRATH_CITY, 		36.0, 48.5, "Neutral")
	AddTrainer(43431, "Periale", 				Z.DARKSHORE, 			51.3, 19.1, "Alliance")
	AddTrainer(46357, "Gonto", 					Z.ORGRIMMAR, 			44.5, 78.6, "Horde")
	AddTrainer(52170, "Gizzik Oregrab", 		Z.ORGRIMMAR, 			36.0, 82.6, "Horde")
	AddTrainer(52642, "Foreman Pernic", 		Z.DARNASSUS, 			50.6, 33.8, "Alliance")
	AddTrainer(53409, "\"Kobold\" Kerik", 		Z.DUSTWALLOW_MARSH, 	64.6, 49.8, "Alliance")
	AddTrainer(65092, "Smeltmaster Ashpaw", 	Z.THE_JADE_FOREST, 		46.1, 29.4, "Alliance")
	AddTrainer(66979, "Stonebreaker Ruian", 	Z.THE_JADE_FOREST,		27.8, 14.9, "Horde")
	AddTrainer(85919, "Jonath Chainfist", 		Z.STORMSHIELD, 			43.3, 35.0, "Alliance")
	AddTrainer(86014, "Murg Stonecrack",		Z.WARSPEAR, 			78.6, 37.8, "Horde")
	AddTrainer(93189, "Mama Diggs",				Z.DALARAN_BROKENISLES,	46.2, 26.6, "Neutral")
	AddTrainer(122694, "Secott the Goldsmith", 	Z.DAZARALOR, 			44.1, 39.1, "Horde")
	AddTrainer(133236, "Layla Stonebreaker", 	Z.ORGRIMMAR, 			39.0, 85.3, "Horde")
	AddTrainer(136091, "Myra Cabot", 			Z.BORALUS, 				75.1, 7.5, "Alliance")
	AddTrainer(156668, "Excavationist Au'fer", 	Z.ORIBOS, 				39.65, 33.36, "Neutral")


	self.InitializeTrainers = nil
end
