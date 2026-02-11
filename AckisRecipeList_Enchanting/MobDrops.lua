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

local BN = constants.BOSS_NAMES
local Z = constants.ZONE_NAMES

-----------------------------------------------------------------------
-- What we _really_ came here to see...
-----------------------------------------------------------------------
function module:InitializeMobDrops()
    local function AddMob(npcID, npcName, zoneName, coordX, coordY)
        addon.AcquireTypes.MobDrop:AddEntity(module, {
            coord_x = coordX or 0,
            coord_y = coordY or 0,
            faction = nil,
            identifier = npcID,
            item_list = {},
            locationName = zoneName,
            name = npcName,
        })
    end

    AddMob(2374, L["Torn Fin Muckdweller"], Z.HILLSBRAD_FOOTHILLS, 31.5, 72.1)
    AddMob(2375, L["Torn Fin Coastrunner"], Z.HILLSBRAD_FOOTHILLS, 25.1, 70.5)
    AddMob(2376, L["Torn Fin Oracle"], Z.HILLSBRAD_FOOTHILLS, 42.0, 68.0)
    AddMob(2377, L["Torn Fin Tidehunter"], Z.HILLSBRAD_FOOTHILLS, 39.0, 69.0)
    AddMob(2556, L["Witherbark Headhunter"], Z.ARATHI_HIGHLANDS, 70.5, 70.4)
    AddMob(2557, L["Witherbark Shadow Hunter"], Z.ARATHI_HIGHLANDS, 70.3, 78.9)
    AddMob(2558, L["Witherbark Berserker"], Z.ARATHI_HIGHLANDS, 24.2, 66.2)
    AddMob(7372, L["Deadwind Warlock"], Z.DEADWIND_PASS, 59.8, 74.4)
    AddMob(7524, L["Anguished Highborne"], Z.WINTERSPRING, 50.6, 53.2)
    AddMob(9024, BN.PYROMANCER_LOREGRAIN, Z.BLACKROCK_DEPTHS)
    AddMob(9025, BN.LORD_ROCCOR, Z.BLACKROCK_DEPTHS)
    AddMob(9216, L["Spirestone Warlord"], Z.BLACKROCK_SPIRE)
    AddMob(9451, L["Scarlet Archmage"], Z.EASTERN_PLAGUELANDS, 81.5, 75.4)
    AddMob(10317, L["Blackhand Elite"], Z.BLACKROCK_SPIRE)
    AddMob(10398, L["Thuzadin Shadowcaster"], Z.STRATHOLME)
    AddMob(10422, L["Risen Sorcerer"], Z.STRATHOLME)
    AddMob(10469, L["Scholomance Adept"], Z.SCHOLOMANCE)
    AddMob(10499, L["Spectral Researcher"], Z.SCHOLOMANCE)
    AddMob(14276, L["Scargil"], Z.HILLSBRAD_FOOTHILLS, 26.6, 71.2)
    AddMob(15275, BN.THE_TWIN_EMPERORS, Z.AHNQIRAJ_THE_FALLEN_KINGDOM)
    AddMob(15276, L["Emperor Vek'lor"], Z.AHNQIRAJ_THE_FALLEN_KINGDOM)

    AddMob(15687, BN.MOROES, Z.KARAZHAN)
    AddMob(15688, BN.TERESTIAN_ILLHOOF, Z.KARAZHAN)
    AddMob(16472, L["Phantom Stagehand"], Z.KARAZHAN)
    AddMob(16524, BN.SHADE_OF_ARAN, Z.KARAZHAN)
    AddMob(16810, L["Bonechewer Backbreaker"], Z.TEROKKAR_FOREST, 66.0, 55.2)
    AddMob(17465, L["Shattered Hand Centurion"], Z.THE_SHATTERED_HALLS)
    AddMob(17803, L["Coilfang Oracle"], Z.THE_STEAMVAULT)
    AddMob(18317, L["Ethereal Priest"], Z.MANA_TOMBS)
    AddMob(18521, L["Raging Skeleton"], Z.AUCHENAI_CRYPTS)
    AddMob(19952, L["Bloodmaul Geomancer"], Z.BLADES_EDGE_MOUNTAINS, 45.0, 68.5)
    AddMob(20136, L["Sunfury Researcher"], Z.NETHERSTORM, 48.2, 82.5)
    AddMob(20880, L["Eredar Deathbringer"], Z.THE_ARCATRAZ)
    AddMob(22242, L["Bash'ir Spell-Thief"], Z.BLADES_EDGE_MOUNTAINS, 51.0, 16.5)
    AddMob(22243, L["Bash'ir Arcanist"], Z.BLADES_EDGE_MOUNTAINS, 52.2, 13.2)
    AddMob(22822, L["Ethereum Nullifier"], Z.NETHERSTORM, 66.0, 49.5)
    AddMob(23008, L["Ethereum Jailor"], Z.NETHERSTORM, 58.8, 35.6)
    AddMob(24560, BN.PRIESTESS_DELRISSA, Z.MAGISTERS_TERRACE)
    AddMob(26336, L["Indu'le Mystic"], Z.DRAGONBLIGHT, 40.2, 65.5)
    AddMob(26343, L["Indu'le Fisherman"], Z.DRAGONBLIGHT, 40.2, 65.5)
    AddMob(26344, L["Indu'le Warrior"], Z.DRAGONBLIGHT, 40.2, 65.5)
    AddMob(145616, BN.KING_RASTAKHAN, Z.BATTLE_OF_DAZARALOR, 0.0, 0.0)
    AddMob(183722, L["Sorranos"], Z.ZERETH_MORTIS, 35.6, 70.6)

    self.InitializeMobDrops = nil
end
