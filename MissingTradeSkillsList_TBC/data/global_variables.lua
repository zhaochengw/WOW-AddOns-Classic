-------------------------------------------
-- Creates all global variables for DATA --
-------------------------------------------

-- Holds all the data filled by the data luas
MTSL_DATA = {
    -- Extra rank in TBC 300 - 375
    -- Each profession has 5 ranks to learn (1-75, 75-150, 150-225, 225-300, 300-375), except poisons (only 1)
    ["AMOUNT_RANKS"] = {
        ["Alchemy"] = 5,
        ["Blacksmithing"] = 5,
        ["Cooking"] = 5,
        ["Enchanting"] = 5,
        ["Engineering"] = 5,
        ["First Aid"] = 5,
        ["Fishing"] = 5,
        ["Herbalism"] = 5,
        ["Jewelcrafting"] = 5,
        ["Leatherworking"] = 5,
        ["Mining"] = 5,
        ["Poisons"] = 1,
        ["Skinning"] = 5,
        ["Tailoring"] = 5,
    },
    -- Counters keeping track of total amount of skill (this includes AMOUNT_RANKS)
    ["AMOUNT_SKILLS"] = {},
    MIN_PATCH_LEVEL = 1,
    MAX_PATCH_LEVEL = 5,
    CURRENT_PATCH_LEVEL = 1,
    -- Phases by id: Karazhan, Tempest Keep, Black Temple, Zul'Aman, Sunwell Plateau
    PHASE_IDS = { 3457, 3845, 3959 ,3805, 4075 },
    -- Current expansion = TBC (2)
    CURRENT_EXPANSION_ID = 2,

    ["item_qualities"] = {
        {
            ["id"] = 0,
            ["name"] = "poor",
        },
        {
            ["id"] = 1,
            ["name"] = "common",
        },
        {
            ["id"] = 2,
            ["name"] = "uncommon",
        },
        {
            ["id"] = 3,
            ["name"] = "rare",
        },
        {
            ["id"] = 4,
            ["name"] = "epic",
        },
        {
            ["id"] = 5,
            ["name"] = "legendary",
        },
    },

    ["items"] = {},
    ["levels"] = {},
    ["skills"] = {},
    ["specialisations"] = {},
}