local NAME, ns = ...

local CONSTANTS = {
    VERSION = "1.9.27",
    NAME = "Butter Quest Tracker",
    NAME_SQUASHED = "ButterQuestTracker",
    CURSEFORGE_SLUG = "butter-quest-tracker",
    BRAND_COLOR = "|c00FF9696",
    PATHS = {}
};

CONSTANTS.PATHS.MEDIA = "Interface\\AddOns\\" .. NAME .. "\\Media\\";
CONSTANTS.PATHS.LOGO = "|T" .. CONSTANTS.PATHS.MEDIA .. "BQT_logo:24:24:0:-8" .. "|t";

CONSTANTS.DB_DEFAULTS = {
    global = {
        DisplayDummyData = false,

        -- Filters & Sorting

        DisableFilters = false,
        Sorting = "Disabled",
        CurrentZoneOnly = false,
        HideCompletedQuests = false,
        QuestLimit = 20,
        AutoTrackUpdatedQuests = false,
        AutoHideQuestHelperIcons = false,

        -- Visuals

        BackgroundAlwaysVisible = false,
        BackgroundColor = "7F000000",

        QuestPadding = 10,

        -- Visuals > Tracker Header Font Settings

        TrackerHeaderEnabled = true,
        TrackerHeaderFormat = "QuestsNumberVisible",
        TrackerHeaderFontSize = 12,
        TrackerHeaderFontColor = "FFD100",

        -- Visuals > Zone Header Font Settings

        ZoneHeaderEnabled = false,
        ZoneHeaderFontSize = 12,
        ZoneHeaderFontColor = "FFD100",

        -- Visuals > Quest Header Font Settings

        ColorHeadersByDifficultyLevel = false,
        QuestHeaderFormat = "{{title}}",
        QuestHeaderFontSize = 12,
        QuestHeaderFontColor = "FFD100",

        -- Visuals > Objective Font Settings

        ObjectiveFontSize = 12,
        ObjectiveFontColor = "CCCCCC",

        -- Frame Settings

        LockFrame = false,
        PositionX = 0,
        PositionY = -240,
        Width = 250,
        MaxHeight = 450,

        -- Advanced

        DeveloperMode = false,
        DebugLevel = 3
    },

    char = {
        -- Backend

        MANUALLY_TRACKED_QUESTS = {},
        QUESTS_LAST_UPDATED = {}
    }
};

CONSTANTS.LOGGER = {
    PREFIX = "|r[" .. CONSTANTS.BRAND_COLOR .. CONSTANTS.NAME_SQUASHED .. "|r]: |r",
    TYPES = {
        ERROR = {
            COLOR = "|c00FF0000",
            LEVEL = 1
        },
        WARN = {
            COLOR = "|c00FF7F00",
            LEVEL = 2
        },
        INFO = {
            COLOR = "|r",
            LEVEL = 3
        },
        TRACE = {
            COLOR = "|c00ADD8E6",
            LEVEL = 4
        }
    }
};

ns.CONSTANTS = CONSTANTS
