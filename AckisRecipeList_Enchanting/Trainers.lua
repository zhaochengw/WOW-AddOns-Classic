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

    AddTrainer(1317, "Lucan Cordell", Z.STORMWIND_CITY, 53.0, 74.3, "Alliance")
    AddTrainer(3011, "Teg Dawnstrider", Z.THUNDER_BLUFF, 45.3, 38.4, "Horde")
    AddTrainer(3345, "Godan", Z.ORGRIMMAR, 53.8, 38.5, "Horde")
    AddTrainer(3606, "Alanna Raveneye", Z.THUNDER_BLUFF, 36.8, 34.2, "Alliance") -- tmp another loc
    AddTrainer(4213, "Taladan", Z.DARNASSUS, 56.4, 31, "Alliance")
    AddTrainer(4616, "Lavinia Crowe", Z.UNDERCITY, 62.1, 60.5, "Horde")
    AddTrainer(5157, "Gimble Thistlefuzz", Z.IRONFORGE, 60.0, 45.4, "Alliance")
    AddTrainer(5695, "Vance Undergloom", Z.TIRISFAL_GLADES, 61.7, 51.6, "Horde")
    AddTrainer(7949, "Xylinnia Starshine", Z.FERALAS, 31.6, 44.3, "Alliance")
    AddTrainer(11072, "Kitta Firewind", Z.ELWYNN_FOREST, 64.9, 70.6, "Alliance")
    AddTrainer(11073, "Annora", Z.ULDAMAN, 0.0, 0.0, "Neutral")
    AddTrainer(11074, "Hgarth", Z.STONETALON_MOUNTAINS, 49.2, 57.2, "Horde")
    AddTrainer(16160, "Magistrix Eredania", Z.EVERSONG_WOODS, 38.2, 72.6, "Horde")
    AddTrainer(16633, "Sedana", Z.SILVERMOON_CITY, 70.0, 24.0, "Horde")
    AddTrainer(16725, "Nahogg", Z.THE_EXODAR, 40.5, 39.2, "Alliance")
    AddTrainer(18753, "Felannia", Z.HELLFIRE_PENINSULA, 52.3, 36.1, "Horde")
    AddTrainer(18773, "Johan Barnes", Z.HELLFIRE_PENINSULA, 53.7, 66.1, "Alliance")
    AddTrainer(19251, "Enchantress Volali", Z.SHATTRATH_CITY, 43.2, 92.3, "Neutral")
    AddTrainer(19252, "High Enchanter Bardolan", Z.SHATTRATH_CITY, 43.2, 92.2, "Neutral")
    AddTrainer(19540, "Asarnan", Z.NETHERSTORM, 44.2, 33.7, "Neutral")
    AddTrainer(26906, "Elizabeth Jackson", Z.HOWLING_FJORD, 58.6, 62.8, "Alliance")
    AddTrainer(26954, "Emil Autumn", Z.HOWLING_FJORD, 78.7, 28.3, "Horde")
    AddTrainer(26980, "Eorain Dawnstrike", Z.BOREAN_TUNDRA, 41.2, 53.9, "Horde")
    AddTrainer(26990, "Alexis Marlowe", Z.BOREAN_TUNDRA, 57.6, 71.6, "Alliance")
    AddTrainer(28693, "Enchanter Nalthanis", Z.DALARAN_NORTHREND, 39.1, 40.5, "Neutral")
    AddTrainer(33583, "Fael Morningsong", Z.ICECROWN, 73.0, 20.6, "Neutral")
    AddTrainer(33610, "Enchanting", Z.SHATTRATH_CITY, 43.6, 90.4, "Neutral")
    AddTrainer(33633, "Enchantress Andiala", Z.SHATTRATH_CITY, 55.6, 74.6, "Neutral")
    AddTrainer(33676, "Zurii", Z.SHATTRATH_CITY, 36.4, 44.6, "Neutral")
    AddTrainer(53410, "Lissah Spellwick", Z.DUSTWALLOW_MARSH, 66.0, 49.7, "Alliance")
    AddTrainer(65127, "Lai the Spellpaw", Z.THE_JADE_FOREST, 46.8, 42.9, "Neutral")
    AddTrainer(85914, "Bil Sparktonic", Z.STORMSHIELD, 56.7, 65.4, "Alliance")
    AddTrainer(86027, "Hane'ke", Z.WARSPEAR, 78.8, 52.4, "Horde")
    AddTrainer(93531, "Enchanter Nalthanis", Z.DALARAN_BROKENISLES, 38.3, 40.4, "Neutral")
    AddTrainer(98017, "Guron Twaintail", Z.THUNDER_TOTEM, 44.5, 45.5, "Neutral")
    AddTrainer(122702, "Enchantress Quinni", Z.DAZARALOR, 47.01, 35.78, "Horde")
    AddTrainer(136041, "Emily Fairweather", Z.BORALUS, 74.07, 11.44, "Alliance")
    AddTrainer(156683, "Imbuer Au'vresh", Z.ORIBOS, 48.31, 28.95, "Neutral")

    self.InitializeTrainers = nil
end
