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

Private.Zones[1046] = {
    id = 1046,
    name = "Throne of Thunder",
    hasMultipleDifficulties = true,
    hasMultipleSizes = true,
    encounters = {
        { id = 51577, },
        { id = 51575, },
        { id = 51570, },
        { id = 51565, },
        { id = 51578, },
        { id = 51573, },
        { id = 51572, },
        { id = 51574, },
        { id = 51576, },
        { id = 51559, },
        { id = 51560, },
        { id = 51579, },
        { id = 51580, },
    },
    difficultyIconMap = nil,
}

Private.Zones[1051] = {
    id = 1051,
    name = "HoF / ToES",
    hasMultipleDifficulties = true,
    hasMultipleSizes = true,
    encounters = {
        { id = 51507, },
        { id = 51504, },
        { id = 51463, },
        { id = 51498, },
        { id = 51499, },
        { id = 51501, },
        { id = 51409, },
        { id = 51505, },
        { id = 51506, },
        { id = 51431, },
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

Private.Zones[1052] = {
    id = 1052,
    name = "SSC / TK",
    hasMultipleDifficulties = false,
    hasMultipleSizes = false,
    encounters = {
        { id = 50623, },
        { id = 50624, },
        { id = 50625, },
        { id = 50626, },
        { id = 50627, },
        { id = 50628, },
        { id = 50730, },
        { id = 50731, },
        { id = 50732, },
        { id = 50733, },
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