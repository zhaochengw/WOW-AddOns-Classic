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

    AddTrainer(26916, "Mindri Dinkles", Z.HOWLING_FJORD, 58.6, 62.8, "Alliance")
    AddTrainer(26959, "Booker Kells", Z.HOWLING_FJORD, 79.4, 29.3, "Horde")
    AddTrainer(26977, "Adelene Sunlance", Z.BOREAN_TUNDRA, 41.2, 53.9, "Horde")
    AddTrainer(26995, "Tink Brightbolt", Z.BOREAN_TUNDRA, 57.6, 71.7, "Alliance")
    AddTrainer(28702, "Professor Pallin", Z.DALARAN_NORTHREND, 41.8, 36.9, "Neutral")
    AddTrainer(30706, "Jo'mah", Z.ORGRIMMAR, 56.2, 46.5, "Horde")
    AddTrainer(30709, "Poshken Hardbinder", Z.THUNDER_BLUFF, 28.7, 20.9, "Horde")
    AddTrainer(30710, "Zantasia", Z.SILVERMOON_CITY, 69.5, 24.0, "Horde")
    AddTrainer(30711, "Margaux Parchley", Z.UNDERCITY, 61.0, 58.5, "Horde")
    AddTrainer(30713, "Catarina Stanford", Z.STORMWIND_CITY, 49.8, 74.7, "Alliance")
    AddTrainer(30715, "Feyden Darkin", Z.DARNASSUS, 56.8, 31.6, "Alliance")
    AddTrainer(30716, "Thoth", Z.THE_EXODAR, 40.5, 39.1, "Alliance")
    AddTrainer(30717, "Elise Brightletter", Z.IRONFORGE, 60.7, 44.9, "Alliance")
    AddTrainer(30721, "Michael Schwan", Z.HELLFIRE_PENINSULA, 53.9, 65.5, "Alliance")
    AddTrainer(30722, "Neferatti", Z.HELLFIRE_PENINSULA, 52.3, 36.1, "Horde")
    AddTrainer(33603, "Arthur Denny", Z.ICECROWN, 71.7, 20.9, "Neutral")
    AddTrainer(33615, "Inscription", Z.SHATTRATH_CITY, 43.5, 90.7, "Neutral")
    AddTrainer(33638, "Scribe Lanloer", Z.SHATTRATH_CITY, 56.0, 74.4, "Neutral")
    AddTrainer(33679, "Recorder Lidio", Z.SHATTRATH_CITY, 36.2, 44.0, "Neutral")
    AddTrainer(46716, "Nerog", Z.ORGRIMMAR, 55.2, 56.7, "Horde")
    AddTrainer(53415, "Theoden Manners", Z.DUSTWALLOW_MARSH, 66.2, 49.7, "Alliance")
    AddTrainer(56065, "Inkmaster Wei", Z.THE_JADE_FOREST, 54.8, 45.0, "Neutral")
    AddTrainer(62327, "Scribe Rinji", Z.THE_JADE_FOREST, 47.6, 35.0, "Neutral")
    AddTrainer(64691, "Lorewalker Huynh", Z.VALE_OF_ETERNAL_BLOSSOMS, 81.9, 29.3, "Neutral")
    AddTrainer(66355, "Master Marshall", Z.KUN_LAI_SUMMIT, 50.6, 42.2, "Neutral")

    self.InitializeTrainers = nil
end
