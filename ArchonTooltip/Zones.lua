---@class Private
local Private = select(2, ...)

Private.Zones[44] = {
    id = 44,
    name = "Manaforge",
    hasMultipleDifficulties = true,
    hasMultipleSizes = false,
    encounters = {
        { id = 3129, },
        { id = 3131, },
        { id = 3130, },
        { id = 3132, },
        { id = 3122, },
        { id = 3133, },
        { id = 3134, },
        { id = 3135, },
    },
    difficultyIconMap = nil,
}

Private.Zones[1040] = {
    id = 1040,
    name = "HoF / ToES",
    hasMultipleDifficulties = true,
    hasMultipleSizes = true,
    encounters = {
        { id = 1507, },
        { id = 1504, },
        { id = 1463, },
        { id = 1498, },
        { id = 1499, },
        { id = 1501, },
        { id = 1409, },
        { id = 1505, },
        { id = 1506, },
        { id = 1431, },
    },
    difficultyIconMap = nil,
}

Private.Zones[1037] = {
    id = 1037,
    name = "Icecrown Citadel",
    hasMultipleDifficulties = true,
    hasMultipleSizes = true,
    encounters = {
        { id = 50845, },
        { id = 50846, },
        { id = 50847, },
        { id = 50848, },
        { id = 50849, },
        { id = 50850, },
        { id = 50851, },
        { id = 50852, },
        { id = 50853, },
        { id = 50854, },
        { id = 50855, },
        { id = 50856, },
    },
    difficultyIconMap = nil,
}

Private.Zones[2018] = {
    id = 2018,
    name = "Scarlet Enclave",
    hasMultipleDifficulties = false,
    hasMultipleSizes = true,
    encounters = {
        { id = 3185, },
        { id = 3187, },
        { id = 3186, },
        { id = 3197, },
        { id = 3196, },
        { id = 3188, },
        { id = 3190, },
        { id = 3189, },
    },
    difficultyIconMap = nil,
}

Private.Zones[1036] = {
    id = 1036,
    name = "Naxxramas",
    hasMultipleDifficulties = false,
    hasMultipleSizes = false,
    encounters = {
        { id = 251118, },
        { id = 251111, },
        { id = 251108, },
        { id = 251120, },
        { id = 251117, },
        { id = 251112, },
        { id = 251115, },
        { id = 251107, },
        { id = 251110, },
        { id = 251116, },
        { id = 251113, },
        { id = 251109, },
        { id = 251121, },
        { id = 251119, },
        { id = 251114, },
    },
    difficultyIconMap = nil,
}

for _, zone in pairs(Private.Zones) do
    for _, encounter in pairs(zone.encounters) do
        Private.EncounterZoneIdMap[encounter.id] = zone.id
    end
end