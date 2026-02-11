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

	AddTrainer(5388,  "Ingo Woolybush", 		Z.DUSTWALLOW_MARSH, 	66.3, 45.1, "Alliance")
	AddTrainer(15501, "Aleinia", 			Z.EVERSONG_WOODS, 	48.5, 47.5, "Horde")
	AddTrainer(18751, "Kalaen", 			Z.HELLFIRE_PENINSULA, 	56.8, 37.7, "Horde")
	AddTrainer(18774, "Tatiana", 			Z.HELLFIRE_PENINSULA, 	54.6, 63.6, "Alliance")
	AddTrainer(19063, "Hamanar", 			Z.SHATTRATH_CITY, 	35.7, 20.5, "Neutral")
	AddTrainer(19539, "Jazdalaad", 			Z.NETHERSTORM, 		44.5, 34.0, "Neutral")
	AddTrainer(19775, "Kalinda", 			Z.SILVERMOON_CITY, 	90.5, 74.1, "Horde")
	AddTrainer(19778, "Farii", 			Z.THE_EXODAR, 		45.0, 24.0, "Alliance")
	AddTrainer(26915, "Ounhulo", 			Z.HOWLING_FJORD, 	59.9, 63.8, "Alliance")
	AddTrainer(26960, "Carter Tiffens", 		Z.HOWLING_FJORD, 	79.3, 28.8, "Horde")
	AddTrainer(26982, "Geba'li", 			Z.BOREAN_TUNDRA, 	41.6, 53.4, "Horde")
	AddTrainer(26997, "Alestos", 			Z.BOREAN_TUNDRA, 	57.5, 72.3, "Alliance")
	AddTrainer(28701, "Timothy Jones", 		Z.DALARAN_NORTHREND, 	40.5, 35.2, "Neutral")
	AddTrainer(33590, "Oluros", 			Z.ICECROWN, 		71.5, 20.8, "Neutral")
	AddTrainer(33614, "Jewelcrafting", 		Z.SHATTRATH_CITY, 	43.6, 90.8, "Neutral")
	AddTrainer(33637, "Kirembri Silvermane", 	Z.SHATTRATH_CITY, 	58.1, 75.0, "Neutral")
	AddTrainer(33680, "Nemiha", 			Z.SHATTRATH_CITY, 	36.1, 47.7, "Neutral")
	AddTrainer(44582, "Theresa Denman", 		Z.STORMWIND_CITY, 	63.5, 61.6, "Alliance")
	AddTrainer(46675, "Lugrah", 			Z.ORGRIMMAR, 		72.5, 34.3, "Horde")
	AddTrainer(52586, "Hanner Gembold", 		Z.IRONFORGE, 		51.0, 25.4, "Alliance")
	AddTrainer(52587, "Neller Fayne", 		Z.UNDERCITY, 		56.2, 36.6, "Horde")
	AddTrainer(52645, "Aessa Silverdew", 		Z.DARNASSUS, 		54.2, 30.4, "Alliance")
	AddTrainer(52657, "Nahari Cloudchaser", 	Z.THUNDER_BLUFF, 	35.0, 54.0, "Horde")
	AddTrainer(65098, "Mai the Jade Shaper",	Z.THE_JADE_FOREST, 	48.1, 35.0, "Neutral")
	AddTrainer(85916, "Artificer Nissea",		Z.STORMSHIELD, 		43.5, 33.9, "Alliance")
	AddTrainer(86010, "Alixander Swiftsteel", 	Z.WARSPEAR, 		60.0, 40.6, "Horde")
	AddTrainer(93527, "Timothy Jones",		Z.DALARAN_BROKENISLES,	40.0, 35.2, "Neutral")
	AddTrainer(100538, "Timothy Jones",		Z.AZSUNA,		46.7, 41.4, "Neutral")
	AddTrainer(122695, "Seshuli", 			Z.DAZARALOR, 		47.02, 37.88, "Horde")
	AddTrainer(130368, "Samuel D. Colton III",	Z.BORALUS,		75.0, 10.0, "Alliance")
	AddTrainer(156670, "Appraiser Au'vesk", 	Z.ORIBOS, 		35.7, 41.9, "Neutral")


	self.InitializeTrainers = nil
end
