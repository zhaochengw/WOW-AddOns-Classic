-----------------------------------------
-- Creates all global variables for UI --
-----------------------------------------

-- holds all info about the addon itself
MTSLUI_ADDON = {
    AUTHOR = "Thumbkin",
    NAME = "Missing TradeSkills List (TBC)",
    VERSION = "2.5.08",
    PATCH_TEXT =
'* Optimised the way the addon scans for missing skills\n' ..
'* Optimised code for scanning skills when swapping TradeSkillFrame & CraftFrame and rehooking MTSL button\n' ..
'* Added all upcoming patches as filter possibility to the regular MTSL window as well\n' ..
'* Fixed data:\n' ..
'     * All professions should now have their correct localised name\n' ..
'     * Cooking recipe "Ravager dogs" is now also sold by Alliance vendor\n' ..
'     * All skills should now have the correct phase \n' ..
'* Added data:\n' ..
'     * Added item_id for each skill that represents the id of the item that is created when executing the spell',

    SERVER_VERSION_PHASES = {
        -- max build number from server for phase 1,
        {
            ["id"] = 1,
            ["max_tocversion"] = 20501,
        },
        {
            ["id"] = 2,
            ["max_tocversion"] = 20502,
        },
        {
            ["id"] = 3,
            ["max_tocversion"] = 20503,
        },
        {
            ["id"] = 4,
            ["max_tocversion"] = 20504,
        },
        {
            ["id"] = 5,
            ["max_tocversion"] = 20505,
        }
    }
}

MTSL_CURRENT_OPENED_CRAFT = nil
MTSL_CURRENT_OPENED_TRADESKILL = nil
MTSL_CURRENT_OPENED_PROFESSION = nil

-- holds the icons of the professions
MTSLUI_ICONS_PROFESSION = {
    -- Primary professions
    ["Alchemy"] = "136240",
    ["Blacksmithing"] = "136241",
    ["Enchanting"] = "136244", -- craft
    ["Engineering"] = "136243",
    ["Herbalism"] = "136065",
    ["Jewelcrafting"] = "134071", -- New for TBC
    ["Leatherworking"] = "133611",
    ["Mining"] = "136248",
    ["Skinning"] = "134366",
    ["Tailoring"] = "136249",
    -- Secondary professions
    ["Cooking"] = "133971",
    ["First Aid"] = "135966",
    ["Fishing"] = "136245",
    -- Rogue only
    ["Poisons"] = "136242",
}

MTSLUI_ADDON_PATH = "Interface\\AddOns\\MissingTradeSkillsList_TBC"