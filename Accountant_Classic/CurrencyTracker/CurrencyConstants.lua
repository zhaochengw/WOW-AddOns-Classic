--[[
    CurrencyConstants.lua
    
    Defines supported currencies, their metadata, and version comparison utilities
    for the Accountant Classic Currency Tracker module.
]]

local addonName, addonTable = ...

-- Create the CurrencyConstants namespace
local CurrencyConstants = {}

-- Version comparison utilities
CurrencyConstants.VersionUtils = {
    -- Convert version string (e.g., "11.0.0") to comparable number (e.g., 110000)
    ParseVersion = function(versionString)
        if not versionString or type(versionString) ~= "string" then
            return 0
        end
        
        local major, minor, patch = versionString:match("(%d+)%.(%d+)%.(%d+)")
        if not major or not minor or not patch then
            return 0
        end
        
        return tonumber(major) * 10000 + tonumber(minor) * 100 + tonumber(patch)
    end,
    
    -- Compare two version numbers (returns -1, 0, or 1)
    CompareVersions = function(version1, version2)
        local v1 = type(version1) == "string" and CurrencyConstants.VersionUtils.ParseVersion(version1) or version1
        local v2 = type(version2) == "string" and CurrencyConstants.VersionUtils.ParseVersion(version2) or version2
        
        if v1 < v2 then
            return -1
        elseif v1 > v2 then
            return 1
        else
            return 0
        end
    end,
    
    -- Get current WoW version as comparable number
    GetCurrentWoWVersion = function()
        local version = GetBuildInfo()
        if version then
            return CurrencyConstants.VersionUtils.ParseVersion(version)
        end
        return 0
    end,
    
    -- Check if current client supports a minimum version
    IsVersionSupported = function(minVersion)
        local currentVersion = CurrencyConstants.VersionUtils.GetCurrentWoWVersion()
        local requiredVersion = type(minVersion) == "string" and CurrencyConstants.VersionUtils.ParseVersion(minVersion) or minVersion
        return currentVersion >= requiredVersion
    end
}

-- Expansion definitions for grouping currencies
CurrencyConstants.Expansions = {
    CLASSIC = {
        name = "Classic",
        minVersion = 10000, -- 1.0.0
        order = 1
    },
    TBC = {
        name = "The Burning Crusade",
        minVersion = 20000, -- 2.0.0
        order = 2
    },
    WOTLK = {
        name = "Wrath of the Lich King",
        minVersion = 30000, -- 3.0.0
        order = 3
    },
    CATACLYSM = {
        name = "Cataclysm",
        minVersion = 40000, -- 4.0.0
        order = 4
    },
    MOP = {
        name = "Mists of Pandaria",
        minVersion = 50000, -- 5.0.0
        order = 5
    },
    WOD = {
        name = "Warlords of Draenor",
        minVersion = 60000, -- 6.0.0
        order = 6
    },
    LEGION = {
        name = "Legion",
        minVersion = 70000, -- 7.0.0
        order = 7
    },
    BFA = {
        name = "Battle for Azeroth",
        minVersion = 80000, -- 8.0.0
        order = 8
    },
    SHADOWLANDS = {
        name = "Shadowlands",
        minVersion = 90000, -- 9.0.0
        order = 9
    },
    DRAGONFLIGHT = {
        name = "Dragonflight",
        minVersion = 100000, -- 10.0.0
        order = 10
    },
    TWW = {
        name = "The War Within",
        minVersion = 110000, -- 11.0.0
        order = 11
    }
}

-- Supported currencies with metadata (seed set)
-- Keep this list minimal and long-lived to remain stable across expansions.
-- Other currencies will be added dynamically at runtime when discovered.
CurrencyConstants.SupportedCurrencies = {
    -- Timewarped Badge (introduced in Warlords of Draenor; still used across many versions)
    [1166] = {
        id = 1166,
        name = "Timewarped Badge",
        icon = "Interface\\Icons\\pvecurrency-justice", -- generic fallback icon; live API will override
        expansion = "WOD",
        expansionName = "Warlords of Draenor",
        patch = "6.2.0",
        minVersion = 60000, -- 6.0.0 and above
        maxQuantity = 0, -- no practical cap
        isTracked = true,
        description = "Earned from Timewalking activities; persists across expansions",
        category = "Special"
    },
}

-- Currency categories for organization
CurrencyConstants.Categories = {
    UPGRADE_MATERIALS = "Upgrade Materials",
    FACTION = "Faction",
    SPECIAL = "Special",
    COLLECTIBLE = "Collectible",
    SEASONAL = "Seasonal"
}

-- Utility functions for currency management
CurrencyConstants.Utils = {
    -- Get all currencies for a specific expansion
    GetCurrenciesByExpansion = function(expansionKey)
        local currencies = {}
        for id, currency in pairs(CurrencyConstants.SupportedCurrencies) do
            if currency.expansion == expansionKey then
                currencies[id] = currency
            end
        end
        return currencies
    end,
    
    -- Get currencies available for current WoW version
    GetCurrenciesForCurrentVersion = function()
        local currentVersion = CurrencyConstants.VersionUtils.GetCurrentWoWVersion()
        local availableCurrencies = {}
        
        for id, currency in pairs(CurrencyConstants.SupportedCurrencies) do
            if currentVersion >= currency.minVersion then
                availableCurrencies[id] = currency
            end
        end
        
        return availableCurrencies
    end,
    
    -- Get currencies by patch version
    GetCurrenciesByPatch = function(patchVersion)
        local currencies = {}
        for id, currency in pairs(CurrencyConstants.SupportedCurrencies) do
            if currency.patch == patchVersion then
                currencies[id] = currency
            end
        end
        return currencies
    end,
    
    -- Check if a currency is supported
    IsCurrencySupported = function(currencyID)
        return CurrencyConstants.SupportedCurrencies[currencyID] ~= nil
    end,
    
    -- Get currency info by ID
    GetCurrencyInfo = function(currencyID)
        return CurrencyConstants.SupportedCurrencies[currencyID]
    end,
    
    -- Get all tracked currencies (enabled by default)
    GetTrackedCurrencies = function()
        local trackedCurrencies = {}
        for id, currency in pairs(CurrencyConstants.SupportedCurrencies) do
            if currency.isTracked then
                trackedCurrencies[id] = currency
            end
        end
        return trackedCurrencies
    end,
    
    -- Get currencies grouped by expansion for dropdown display
    GetCurrenciesGroupedByExpansion = function()
        local grouped = {}
        local currentVersion = CurrencyConstants.VersionUtils.GetCurrentWoWVersion()
        
        -- Initialize expansion groups
        for expKey, expData in pairs(CurrencyConstants.Expansions) do
            if currentVersion >= expData.minVersion then
                grouped[expKey] = {
                    expansion = expData,
                    patches = {}
                }
            end
        end
        
        -- Group currencies by expansion and patch
        for id, currency in pairs(CurrencyConstants.SupportedCurrencies) do
            if currentVersion >= currency.minVersion and grouped[currency.expansion] then
                local patch = currency.patch
                if not grouped[currency.expansion].patches[patch] then
                    grouped[currency.expansion].patches[patch] = {}
                end
                table.insert(grouped[currency.expansion].patches[patch], currency)
            end
        end
        
        return grouped
    end
}

-- UI Constants
CurrencyConstants.UI = {
    GOLD_TAB_INDEX = 1,
    CURRENCY_TAB_INDEX = 2
}

-- Default currency settings
CurrencyConstants.Defaults = {
    PRIMARY_CURRENCY = 1166, -- Timewarped Badge as stable, long-lived default
    TRACKING_ENABLED = true,
    MAX_HISTORY_DAYS = 365, -- Keep 1 year of history by default
    UPDATE_THROTTLE_MS = 100 -- Minimum time between updates in milliseconds
}

-- Curated currency allowlist (mirrored from SavedInstances/Modules/Currency.lua)
-- This list is used for optional display filtering to avoid internal/duplicate IDs.
-- Note: Keep comments to preserve human-readable labels; live API data will supersede names/icons.
CurrencyConstants.CurrencyWhitelist = {
    81,   -- Epicurean Award
    515,  -- Darkmoon Prize Ticket
    2588, -- Riders of Azeroth Badge

    -- Wrath of the Lich King
    241,  -- Champion's Seal

    -- Cataclysm
    391,  -- Tol Barad Commendation
    416,  -- Mark of the World Tree

    -- Mists of Pandaria
    402,  -- Ironpaw Token
    697,  -- Elder Charm of Good Fortune
    738,  -- Lesser Charm of Good Fortune
    752,  -- Mogu Rune of Fate
    776,  -- Warforged Seal
    777,  -- Timeless Coin
    789,  -- Bloody Coin

    -- Warlords of Draenor
    823,  -- Apexis Crystal
    824,  -- Garrison Resources
    994,  -- Seal of Tempered Fate
    1101, -- Oil
    1129, -- Seal of Inevitable Fate
    1149, -- Sightless Eye
    1155, -- Ancient Mana
    1166, -- Timewarped Badge

    -- Legion
    1220, -- Order Resources
    1226, -- Nethershards
    1273, -- Seal of Broken Fate
    1275, -- Curious Coin
    1299, -- Brawler's Gold
    1314, -- Lingering Soul Fragment
    1342, -- Legionfall War Supplies
    1501, -- Writhing Essence
    1508, -- Veiled Argunite
    1533, -- Wakening Essence

    -- Battle for Azeroth
    1710, -- Seafarer's Dubloon
    1580, -- Seal of Wartorn Fate
    1560, -- War Resources
    1587, -- War Supplies
    1716, -- Honorbound Service Medal
    1717, -- 7th Legion Service Medal
    1718, -- Titan Residuum
    1721, -- Prismatic Manapearl
    1719, -- Corrupted Memento
    1755, -- Coalescing Visions
    1803, -- Echoes of Ny'alotha

    -- Shadowlands
    1754, -- Argent Commendation
    1191, -- Valor
    1602, -- Conquest
    1792, -- Honor
    1822, -- Renown
    1767, -- Stygia
    1828, -- Soul Ash
    1810, -- Redeemed Soul
    1813, -- Reservoir Anima
    1816, -- Sinstone Fragments
    1819, -- Medallion of Service
    1820, -- Infused Ruby
    1885, -- Grateful Offering
    1889, -- Adventure Campaign Progress
    1904, -- Tower Knowledge
    1906, -- Soul Cinders
    1931, -- Cataloged Research
    1977, -- Stygian Ember
    1979, -- Cyphers of the First Ones
    2009, -- Cosmic Flux
    2000, -- Motes of Fate

    -- Dragonflight
    2003, -- Dragon Isles Supplies
    2245, -- Flightstones
    2123, -- Bloody Tokens
    2797, -- Trophy of Strife
    2045, -- Dragon Glyph Embers
    2118, -- Elemental Overflow
    2122, -- Storm Sigil
    2409, -- Whelpling Crest Fragment Tracker [DNT]
    2410, -- Drake Crest Fragment Tracker [DNT]
    2411, -- Wyrm Crest Fragment Tracker [DNT]
    2412, -- Aspect Crest Fragment Tracker [DNT]
    2413, -- 10.1 Professions - Personal Tracker - S2 Spark Drops (Hidden)
    2533, -- Renascent Shadowflame
    2594, -- Paracausal Flakes
    2650, -- Emerald Dewdrop
    2651, -- Seedbloom
    2777, -- Dream Infusion
    2796, -- Renascent Dream
    2706, -- Whelpling's Dreaming Crest
    2707, -- Drake's Dreaming Crest
    2708, -- Wyrm's Dreaming Crest
    2709, -- Aspect's Dreaming Crest
    2774, -- 10.2 Professions - Personal Tracker - S3 Spark Drops (Hidden)
    2657, -- Mysterious Fragment
    2912, -- Renascent Awakening
    2806, -- Whelpling's Awakened Crest
    2807, -- Drake's Awakened Crest
    2809, -- Wyrm's Awakened Crest
    2812, -- Aspect's Awakened Crest
    2800, -- 10.2.6 Professions - Personal Tracker - S4 Spark Drops (Hidden)
    3010, -- 10.2.6 Rewards - Personal Tracker - S4 Dinar Drops (Hidden)
    2778, -- Bronze

    -- The War Within
    3089, -- Residual Memories
    2803, -- Undercoin
    2815, -- Resonance Crystals
    3028, -- Restored Coffer Key
    3056, -- Kej
    3008, -- Valorstones
    2813, -- Harmonized Silk
    2914, -- Weathered Harbinger Crest
    2915, -- Carved Harbinger Crest
    2916, -- Runed Harbinger Crest
    2917, -- Gilded Harbinger Crest
    3023, -- 11.0 Professions - Personal Tracker - S1 Spark Drops (Hidden)
    3100, -- Bronze Celebration Token
    3090, -- Flame-Blessed Iron
    3218, -- Empty Kaja'Cola Can
    3220, -- Vintage Kaja'Cola Can
    3226, -- Market Research
    3116, -- Essence of Kaja'mite
    3107, -- Weathered Undermine Crest
    3108, -- Carved Undermine Crest
    3109, -- Runed Undermine Crest
    3110, -- Gilded Undermine Crest
    3132, -- 11.1 Professions - Personal Tracker - S2 Spark Drops (Hidden)
    3149, -- Displaced Corrupted Mementos
    3278, -- Ethereal Strands
    3303, -- Untethered Coin
    3356, -- Untainted Mana-Crystals
    3269, -- Ethereal Voidsplinter
    3284, -- Weathered Ethereal Crest
    3286, -- Carved Ethereal Crest
    3288, -- Runed Ethereal Crest
    3290, -- Gilded Ethereal Crest
    3141, -- Starlight Spark Dust
}

-- Additional metadata derived from SavedInstances for special handling and display overrides
CurrencyConstants.SpecialCurrency = {
    [1129] = { -- WoD - Seal of Tempered Fate
        weeklyMax = 3,
        earnByQuest = {
            36058, 36054, 37454, 37455, 36056, 37456, 37457, 36057, 37458, 37459, 36055, 37452, 37453,
        },
    },
    [1273] = { -- LEG - Seal of Broken Fate
        weeklyMax = 3,
        earnByQuest = { 43895, 43896, 43897, 43892, 43893, 43894, 43510, 47851, 47864, 47865 },
    },
    [1580] = { -- BfA - Seal of Wartorn Fate
        weeklyMax = 2,
        earnByQuest = { 52834, 52838, 52835, 52839, 52837, 52840 },
    },
    [1755] = { -- BfA - Coalescing Visions
        relatedItem = { id = 173363 }, -- Vessel of Horrific Visions
    },
    [3028] = { -- Restored Coffer Key
        relatedItem = { id = 245653 }, -- Coffer Key Shard
    },
}

-- Optional name and texture overrides for tracker/UI (values in English)
CurrencyConstants.OverrideName = {
    [2409] = "Loot Whelpling Crest Fragment",
    [2410] = "Loot Drake Crest Fragment",
    [2411] = "Loot Wyrm Crest Fragment",
    [2412] = "Loot Aspect Crest Fragment",
    [2413] = "Loot Spark of Shadowflame",
    [2774] = "Loot Spark of Dreams",
    [2800] = "Loot Spark of Awakening",
    [3010] = "Loot Antique Bronze Bullion",
    [3023] = "Loot Spark of Omens",
    [3132] = "Loot Spark of Fortunes",
}

CurrencyConstants.OverrideTexture = {
    [2413] = 5088829,
    [2774] = 5341573,
    [2800] = 4693222,
    [3010] = 4555657,
    [3023] = 5929759,
    [3132] = 5929757,
}

-- Export the module to CurrencyTracker namespace
CurrencyTracker = CurrencyTracker or {}
CurrencyTracker.Constants = CurrencyConstants

-- Source code tokens map
-- Numeric codes from CURRENCY_DISPLAY_UPDATE mapped to stable tokens.
-- Keys should be absolute values; direction is represented by sign at usage site.
CurrencyTracker.SourceCodeTokens = CurrencyTracker.SourceCodeTokens or {
    -- Official names mirrored from Enum.CurrencySource
    [0]  = "ConvertOldItem",
    [1]  = "ConvertOldPvPCurrency",
    [2]  = "ItemRefund",
    [3]  = "QuestReward",
    [4]  = "Cheat",
    [5]  = "Vendor",
    [6]  = "PvPKillCredit",
    [7]  = "PvPMetaCredit",
    [8]  = "PvPScriptedAward",
    [9]  = "Loot",
    [10] = "UpdatingVersion",
    [11] = "LFGReward",
    [12] = "Trade",
    [13] = "Spell",
    [14] = "ItemDeletion",
    [15] = "RatedBattleground",
    [16] = "RandomBattleground",
    [17] = "Arena",
    [18] = "ExceededMaxQty",
    [19] = "PvPCompletionBonus",
    [20] = "Script",
    [21] = "GuildBankWithdrawal",
    [22] = "Pushloot",
    [23] = "GarrisonBuilding",
    [24] = "PvPDrop",
    [25] = "GarrisonFollowerActivation",
    [26] = "GarrisonBuildingRefund",
    [27] = "GarrisonMissionReward",
    [28] = "GarrisonResourceOverTime",
    [29] = "QuestRewardIgnoreCapsDeprecated",
    [30] = "GarrisonTalent",
    [31] = "GarrisonWorldQuestBonus",
    [32] = "PvPHonorReward",
    [33] = "BonusRoll",
    [34] = "AzeriteRespec",
    [35] = "WorldQuestReward",
    [36] = "WorldQuestRewardIgnoreCapsDeprecated",
    [37] = "FactionConversion",
    [38] = "DailyQuestReward",
    [39] = "DailyQuestWarModeReward",
    [40] = "WeeklyQuestReward",
    [41] = "WeeklyQuestWarModeReward",
    [42] = "AccountCopy",
    [43] = "WeeklyRewardChest",
    [44] = "GarrisonTalentTreeReset",
    [45] = "DailyReset",
    [46] = "AddConduitToCollection",
    [47] = "Barbershop",
    [48] = "ConvertItemsToCurrencyValue",
    [49] = "PvPTeamContribution",
    [50] = "Transmogrify",
    [51] = "AuctionDeposit",
    [52] = "PlayerTrait",
    [53] = "PhBuffer_53",
    [54] = "PhBuffer_54",
    [55] = "RenownRepGain",
    [56] = "CraftingOrder",
    [57] = "CatalystBalancing",
    [58] = "CatalystCraft",
    [59] = "ProfessionInitialAward",
    [60] = "PlayerTraitRefund",
    [61] = "AccountHwmUpdate",
    [62] = "ConvertItemsToCurrencyAndReputation",
    [63] = "PhBuffer_63",
    [64] = "SpellSkipLinkedCurrency",
    [65] = "AccountTransfer",
}

-- Destroy reason tokens map (loss side)
-- Official names mirrored from Enum.CurrencyDestroyReason (WoW 11.0.2+)
-- Keys are absolute enum values; direction is represented by sign at usage site (negative for loss)
CurrencyTracker.DestroyReasonTokens = CurrencyTracker.DestroyReasonTokens or {
    [0]  = "Cheat",
    [1]  = "Spell",
    [2]  = "VersionUpdate",
    [3]  = "QuestTurnin",
    [4]  = "Vendor",
    [5]  = "Trade",
    [6]  = "Capped",
    [7]  = "Garrison",
    [8]  = "DroppedToCorpse",
    [9]  = "BonusRoll",
    [10] = "FactionConversion",
    [11] = "FulfillCraftingOrder",
    [12] = "Script",
    [13] = "ConcentrationCast",
    [14] = "AccountTransfer",
}

-- Also export to addon table and global if available
if addonTable then
    addonTable.CurrencyConstants = CurrencyConstants
else
    _G.CurrencyConstants = CurrencyConstants
end

return CurrencyConstants
