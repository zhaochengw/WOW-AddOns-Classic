local _, ns = ...

if ns:IsSoD() then
    ns.RAIDS = {
        [48] = "Blackfathom Deeps",
        [90] = "Gnomeregan",
        [109] = "Sunken Temple",
        [509] = "AQ20",
        [531] = "AQ40",
        [469] = "Blackwing Lair",
        [409] = "Molten Core",
        [533] = "Naxxramas",
        [249] = "Onyxia's Lair",
        [309] = "Zul'Gurub"
    }
elseif ns:IsClassic() then
    ns.RAIDS = {
        [509] = "AQ20",
        [531] = "AQ40",
        [469] = "Blackwing Lair",
        [409] = "Molten Core",
        [533] = "Naxxramas",
        [249] = "Onyxia's Lair",
        [309] = "Zul'Gurub"
    }
elseif ns:IsTBC() then
    ns.RAIDS = {
        [509] = "AQ20",
        [531] = "AQ40",
        [469] = "Blackwing Lair",
        [409] = "Molten Core",
        [533] = "Naxxramas",
        [249] = "Onyxia's Lair",
        [309] = "Zul'Gurub",
        [532] = "Karazhan",
        [544] = "Magtheridon's Lair",
        [565] = "Gruul's Lair",
        [548] = "Serpentshrine Cavern",
        [550] = "Tempest Keep",
        [534] = "Battle for Mount Hyjal",
        [564] = "Black Temple",
        [568] = "Zul'Aman",
        [580] = "Sunwell Plateau"
    }
    ns.DUNGEONS = {
        [269] = "The Black Morass",
        [540] = "The Shattered Halls",
        [542] = "The Blood Furnace",
        [543] = "Hellfire Ramparts",
        [545] = "The Steamvault",
        [546] = "The Underbog",
        [547] = "The Slave Pens",
        [552] = "The Arcatraz",
        [553] = "The Botanica",
        [554] = "The Mechanar",
        [555] = "Shadow Labyrinth",
        [556] = "Sethekk Halls",
        [557] = "Mana-Tombs",
        [558] = "Auchenai Crypts",
        [560] = "Old Hillsbrad Foothills",
        [585] = "Magisters' Terrace"
    }
elseif ns:IsWOTLK() then
    ns.RAIDS = {
        [409] = "Molten Core",
        [309] = "Zul'Gurub",
        [469] = "Blackwing Lair",
        [509] = "AQ20",
        [531] = "AQ40",
        [532] = "Karazhan",
        [544] = "Magtheridon's Lair",
        [565] = "Gruul's Lair",
        [548] = "Serpentshrine Cavern",
        [550] = "Tempest Keep",
        [534] = "Battle for Mount Hyjal",
        [564] = "Black Temple",
        [568] = "Zul'Aman",
        [580] = "Sunwell Plateau",
        [533] = "Naxxramas",
        [615] = "The Obsidian Sanctum",
        [616] = "The Eye of Eternity",
        [624] = "Vault of Archavon",
        [603] = "Ulduar",
        [649] = "Trial of the Crusader",
        [249] = "Onyxia's Lair",
        [631] = "Icecrown Citadel",
        [724] = "Ruby Sanctum"
    }
    ns.DUNGEONS = {
        [269] = "The Black Morass",
        [540] = "The Shattered Halls",
        [542] = "The Blood Furnace",
        [543] = "Hellfire Ramparts",
        [545] = "The Steamvault",
        [546] = "The Underbog",
        [547] = "The Slave Pens",
        [552] = "The Arcatraz",
        [553] = "The Botanica",
        [554] = "The Mechanar",
        [555] = "Shadow Labyrinth",
        [556] = "Sethekk Halls",
        [557] = "Mana-Tombs",
        [558] = "Auchenai Crypts",
        [560] = "Old Hillsbrad Foothills",
        [585] = "Magisters' Terrace",
        [574] = "Utgarde Keep",
        [575] = "Utgarde Pinnacle",
        [576] = "The Nexus",
        [578] = "The Oculus",
        [595] = "The Culling of Stratholme",
        [599] = "Halls of Stone",
        [600] = "Drak'Tharon Keep",
        [601] = "Azjol-Nerub",
        [602] = "Halls of Lightning",
        [604] = "Gundrak",
        [608] = "The Violet Hold",
        [619] = "Ahn'kahet: The Old Kingdom",
        [632] = "The Forge of Souls",
        [650] = "Trial of the Champion",
        [658] = "Pit of Saron",
        [668] = "Halls of Reflection"
    }
end
