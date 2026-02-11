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

    AddTrainer(1355, "Cook Ghilm", Z.DUN_MOROGH, 75.6, 52.9, "Alliance")
    AddTrainer(1382, "Mudduk", Z.NORTHERN_STRANGLETHORN, 37.2, 49.2, "Horde")
    AddTrainer(1430, "Tomas", Z.ELWYNN_FOREST, 44.3, 66.0, "Alliance")
    AddTrainer(1699, "Gremlock Pilsnor", Z.DUN_MOROGH, 54.7, 50.6, "Alliance")
    AddTrainer(2818, "Slagg", Z.ARATHI_HIGHLANDS, 69.2, 34.6, "Horde")
    AddTrainer(3026, "Aska Mistrunner", Z.THUNDER_BLUFF, 50.7, 53.1, "Horde")
    AddTrainer(3067, "Pyall Silentstride", Z.MULGORE, 45.5, 58.1, "Horde")
    AddTrainer(3087, "Crystal Boughman", Z.REDRIDGE_MOUNTAINS, 22.8, 43.6, "Alliance")
    AddTrainer(3399, "Zamja", Z.ORGRIMMAR, 57.5, 53.7, "Horde")
    AddTrainer(4210, "Alegorn", Z.DARNASSUS, 49.9, 36.6, "Alliance")
    AddTrainer(4552, "Eunice Burch", Z.UNDERCITY, 62.3, 44.6, "Horde")
    AddTrainer(4894, "Craig Nollward", Z.DUSTWALLOW_MARSH, 66.9, 45.2, "Alliance")
    AddTrainer(5159, "Daryl Riknussun", Z.IRONFORGE, 60.1, 36.8, "Alliance")
    AddTrainer(5482, "Stephen Ryback", Z.STORMWIND_CITY, 77.2, 53.2, "Alliance")
    AddTrainer(6286, "Zarrin", Z.TELDRASSIL, 56.6, 53.6, "Alliance")
    AddTrainer(8306, "Duhng", Z.NORTHERN_BARRENS, 55.4, 61.3, "Horde")
    AddTrainer(8696, "Henry Stern", Z.RAZORFEN_DOWNS, 80.6, 17, "Neutral")
    AddTrainer(16253, "Master Chef Mouldier", Z.GHOSTLANDS, 48.3, 30.9, "Horde")
    AddTrainer(16277, "Quarelestra", Z.EVERSONG_WOODS, 48.6, 47.1, "Horde")
    AddTrainer(16676, "Sylann", Z.SILVERMOON_CITY, 69.5, 71.5, "Horde")
    AddTrainer(16719, "Mumman", Z.THE_EXODAR, 55.6, 27.1, "Alliance")
    AddTrainer(17246, "\"Cookie\" McWeaksauce", Z.AZUREMYST_ISLE, 46.7, 70.5, "Alliance")
    AddTrainer(18987, "Gaston", Z.HELLFIRE_PENINSULA, 54.1, 63.5, "Alliance")
    AddTrainer(18988, "Baxter", Z.HELLFIRE_PENINSULA, 56.8, 37.5, "Horde")
    AddTrainer(18993, "Naka", Z.ZANGARMARSH, 78.5, 63.0, "Neutral")
    AddTrainer(19185, "Jack Trapper", Z.SHATTRATH_CITY, 63.0, 68.5, "Neutral")
    AddTrainer(19186, "Kylene", Z.SHATTRATH_CITY, 76.5, 33.0, "Neutral")
    AddTrainer(19369, "Celie Steelwing", Z.SHADOWMOON_VALLEY_OUTLAND, 37.2, 58.5, "Alliance")
    AddTrainer(26905, "Brom Brewbaster", Z.HOWLING_FJORD, 58.2, 62.1, "Alliance")
    AddTrainer(26953, "Thomas Kolichio", Z.HOWLING_FJORD, 78.6, 29.4, "Horde")
    AddTrainer(26972, "Orn Tenderhoof", Z.BOREAN_TUNDRA, 42.0, 54.2, "Horde")
    AddTrainer(26989, "Rollick MacKreel", Z.BOREAN_TUNDRA, 57.9, 71.5, "Alliance")
    AddTrainer(28705, "Katherine Lee", Z.DALARAN_NORTHREND, 40.8, 65.2, "Alliance")
    AddTrainer(29631, "Awilo Lon'gomba", Z.DALARAN_NORTHREND, 70.0, 38.6, "Horde")
    AddTrainer(33587, "Bethany Cromwell", Z.ICECROWN, 72.4, 20.8, "Neutral")
    AddTrainer(33619, "Cooking", Z.SHATTRATH_CITY, 43.6, 91.1, "Neutral")
    AddTrainer(42288, "Robby Flay", Z.STORMWIND_CITY, 50.4, 71.8, "Alliance")
    AddTrainer(42506, "Marogg", Z.ORGRIMMAR, 56.5, 62.6, "Horde")
    AddTrainer(45550, "Zarbo Porkpatty", Z.ORGRIMMAR, 39.0, 85.8, "Neutral")
    AddTrainer(46709, "Arugi", Z.ORGRIMMAR, 56.5, 61.5, "Horde")
    AddTrainer(47405, "The Chef", Z.TIRISFAL_GLADES, 61.2, 52.6, "Horde")
    AddTrainer(49789, "Allison", Z.HELLFIRE_PENINSULA, 56.8, 37.4, "Horde")
    AddTrainer(54232, "Mrs. Gant", Z.THE_CAPE_OF_STRANGLETHORN, 42.6, 72.8, "Neutral")
    AddTrainer(56707, "Chin", Z.THE_JADE_FOREST, 46.2, 45.4, "Neutral")
    AddTrainer(58712, "Kol Ironpaw", Z.VALLEY_OF_THE_FOUR_WINDS, 53.0, 51.3, "Neutral")
    AddTrainer(58713, "Anthea Ironpaw", Z.VALLEY_OF_THE_FOUR_WINDS, 52.7, 52.0, "Neutral")
    AddTrainer(58714, "Mei Mei Ironpaw", Z.VALLEY_OF_THE_FOUR_WINDS, 52.6, 51.5, "Neutral")
    AddTrainer(58715, "Yan Ironpaw", Z.VALLEY_OF_THE_FOUR_WINDS, 52.5, 51.7, "Neutral")
    AddTrainer(58716, "Jian Ironpaw", Z.VALLEY_OF_THE_FOUR_WINDS, 53.3, 51.6, "Neutral")
    AddTrainer(58717, "Bobo Ironpaw", Z.VALLEY_OF_THE_FOUR_WINDS, 53.2, 52.2, "Neutral")
    AddTrainer(64231, "Sungshin Ironpaw", Z.VALLEY_OF_THE_FOUR_WINDS, 53.6, 51.2, "Neutral")
    AddTrainer(66353, "Master Chang", Z.KUN_LAI_SUMMIT, 50.6, 41.8, "Neutral")
    AddTrainer(85925, "Elton Black", Z.STORMSHIELD, 35.3, 76.3, "Alliance")
    AddTrainer(86029, "Guy Fireeye", Z.WARSPEAR, 46.0, 44.2, "Horde")
    AddTrainer(93534, "Katherine Lee", Z.DALARAN_BROKENISLES, 39.7, 66.5, "Alliance")
    AddTrainer(129014, "Hessir", Z.VOLDUN, 27.64, 53.23, "Neutral")
    AddTrainer(136052, "\"Cap'n\" Byron Mehlsack", Z.BORALUS, 71.3, 10.9, "Alliance")
    AddTrainer(141549, "T'sarah the Royal Chef", Z.DAZARALOR, 28.7, 47.4, "Horde")
    AddTrainer(150632, "Stacks", Z.MECHAGON_ISLAND, 71.18, 35.99, "Neutral")
    AddTrainer(156672, "Chef Au'krut", Z.ORIBOS, 46.79, 26.25, "Neutral")

    self.InitializeTrainers = nil
end
