-- MerfinPlus Options & Media Registration
-- Comments in English as requested.

local _, MerfinPlus = ...

local AceDB = LibStub("AceDB-3.0")
local AceDBOptions = LibStub("AceDBOptions-3.0")
local AceConfig = LibStub("AceConfig-3.0")
local AceConfigDialog = LibStub("AceConfigDialog-3.0")
local AceConfigRegistry = LibStub("AceConfigRegistry-3.0")
local AceConsole = LibStub("AceConsole-3.0")
local LSM = LibStub("LibSharedMedia-3.0")
local Locale = GetLocale()
local L = MerfinPlus.L

local GetAddOnMetadata = C_AddOns.GetAddOnMetadata

local isTitan = WOW_PROJECT_ID == WOW_PROJECT_WRATH_CLASSIC

MerfinPlus.GetDefaultFont = function(type)
  return (Locale == "zhTW" or Locale == "zhCN" or isTitan) and "CN Merged (SF-Yahee)"
    or (type == "bold" and "SFUIDisplayCondensed-Bold" or "SFUIDisplayCondensed-Semibold")
end

MerfinPlus.GetDefaultRaidFont = function(type)
  return (Locale == "zhTW" or Locale == "zhCN" or isTitan) and "CN Merged (SF-Yahee)"
    or (type == "bold" and "PT Sans Narrow Bold" or "PT Sans Narrow")
end

Merfin.GetDefaultFont = MerfinPlus.GetDefaultFont
Merfin.GetDefaultRaidFont = MerfinPlus.GetDefaultRaidFont

local function IsWrath()
  local build = MerfinPlus.BuildInfo or select(4, GetBuildInfo())
  return build > 33000 and build < 40000
end

local function IsMoP()
  local build = MerfinPlus.BuildInfo or select(4, GetBuildInfo())
  return build > 50500 and build < 60000
end

local function IsTBC()
  local build = MerfinPlus.BuildInfo or select(4, GetBuildInfo())
  return build > 20504 and build < 30000
end

Merfin.IsTBC = IsTBC

MerfinPlus.defaults = {
  profile = {
    pullStartTime = 0,
    pullExpTime = 0,
    pullTotalTime = 0,
    pullSenderName = "Unknown",
    breakStartTime = 0,
    breakExpTime = 0,
    breakTotalTime = 0,
    breakSenderName = "Unknown",
    lfgStartTimer = 0,
    lfgExpTimer = 0,

    font1 = MerfinPlus.GetDefaultFont(),
    font2 = MerfinPlus.GetDefaultFont("bold"),
    font3 = MerfinPlus.GetDefaultRaidFont(),
    font4 = MerfinPlus.GetDefaultRaidFont("bold"),
    bar1 = "MerfinMainDark",
    bar2 = "MerfinMain",
    bar3 = "MerfinMainDark",

    simImports = {},
  },
  global = {
    wowSims = {
      profiles = {},
      assigned = {},
      defaultsVersion = -1,
      defaults = nil,
    },
  },
}

do
  if IsTBC() then
    function MerfinPlus:InitializeWoWSimDefaults()
      if not MerfinPlus.db or not MerfinPlus.db.global then
        return
      end

      local wowSims = MerfinPlus.db.global.wowSims
      wowSims.profiles = wowSims.profiles or {}
      wowSims.assigned = wowSims.assigned or {}

      local profiles = wowSims.profiles

      local function AddProfile(key, data)
        data.key = key
        profiles[key] = data
      end

      local installedVersion = wowSims.defaultsVersion or -1

      if installedVersion < 0 then
        -- WARRIOR
        AddProfile("WarriorProtection-PreRaidBIS-2", {
          class = "WARRIOR",
          specKey = "WarriorProtection",
          specID = 163,
          icon = 134952,
          importedAt = 0,
          items = {
            [1] = 28180,
            [2] = 29386,
            [3] = 27803,
            [5] = 28205,
            [6] = 28995,
            [7] = 29184,
            [8] = 29239,
            [9] = 28996,
            [10] = 27475,
            [11] = 30834,
            [12] = 28553,
            [13] = 23836,
            [14] = 28121,
            [15] = 27804,
            [16] = 28189,
            [17] = 29266,
          },
          itemSuffixes = {},
        })
        AddProfile("WarriorArms-PreRaidBIS-2", {
          class = "WARRIOR",
          specKey = "WarriorArms",
          specID = 161,
          icon = 132292,
          importedAt = 0,
          items = {
            [1] = 32087,
            [2] = 29381,
            [3] = 33173,
            [5] = 23522,
            [6] = 27985,
            [7] = 30538,
            [8] = 25686,
            [9] = 23537,
            [10] = 25685,
            [11] = 23038,
            [12] = 29379,
            [13] = 29383,
            [14] = 21670,
            [15] = 24259,
            [16] = 28438,
            [17] = 23542,
          },
          itemSuffixes = {},
        })
        AddProfile("WarriorFury-PreRaidBIS-2", {
          class = "WARRIOR",
          specKey = "WarriorFury",
          specID = 164,
          icon = 132347,
          importedAt = 0,
          items = {
            [1] = 32087,
            [2] = 29381,
            [3] = 33173,
            [5] = 23522,
            [6] = 27985,
            [7] = 30538,
            [8] = 25686,
            [9] = 23537,
            [10] = 25685,
            [11] = 23038,
            [12] = 29379,
            [13] = 29383,
            [14] = 21670,
            [15] = 24259,
            [16] = 28438,
            [17] = 23542,
          },
          itemSuffixes = {},
        })

        -- PALADIN
        AddProfile("PaladinProtection-PreRaidBIS-2", {
          class = "PALADIN",
          specKey = "PaladinProtection",
          specID = 383,
          icon = 135893,
          importedAt = 0,
          items = {
            [1] = 32083,
            [2] = 28245,
            [3] = 27706,
            [5] = 28203,
            [6] = 29253,
            [7] = 29184,
            [8] = 29254,
            [9] = 29252,
            [10] = 30741,
            [11] = 28407,
            [12] = 29172,
            [13] = 27529,
            [14] = 29370,
            [15] = 27804,
            [16] = 32450,
            [17] = 29176,
          },
          itemSuffixes = {},
        })
        AddProfile("PaladinHoly-PreRaidBIS-2", {
          class = "PALADIN",
          specKey = "PaladinHoly",
          specID = 382,
          icon = 135920,
          importedAt = 0,
          items = {
            [1] = 32472,
            [2] = 31691,
            [3] = 21874,
            [5] = 21875,
            [6] = 21873,
            [7] = 24261,
            [8] = 27411,
            [9] = 29523,
            [10] = 29506,
            [11] = 27780,
            [12] = 29169,
            [13] = 29168,
            [14] = 29376,
            [15] = 31329,
            [16] = 23047,
            [17] = 23556,
            [18] = 29274,
          },
          itemSuffixes = {},
        })
        AddProfile("PaladinRetribution-PreRaidBIS-2", {
          class = "PALADIN",
          specKey = "PaladinRetribution",
          specID = 381,
          icon = 135873,
          importedAt = 0,
          items = {
            [1] = 32087,
            [2] = 29381,
            [3] = 33173,
            [5] = 23522,
            [6] = 29247,
            [7] = 30257,
            [8] = 25686,
            [9] = 23537,
            [10] = 30341,
            [11] = 30834,
            [12] = 29177,
            [13] = 29383,
            [14] = 28034,
            [15] = 33122,
            [16] = 28429,
          },
          itemSuffixes = {},
        })

        -- HUNTER
        AddProfile("HunterBeastMastery-PreRaidBIS-2", {
          class = "HUNTER",
          specKey = "HunterBeastMastery",
          specID = 361,
          icon = 132164,
          importedAt = 0,
          items = {
            [1] = 28275,
            [2] = 29381,
            [3] = 27801,
            [5] = 28228,
            [6] = 29526,
            [7] = 27874,
            [8] = 25686,
            [9] = 29527,
            [10] = 27474,
            [11] = 30860,
            [12] = 31077,
            [13] = 29383,
            [14] = 28288,
            [15] = 24259,
            [16] = 27846,
            [17] = 28435,
          },
          itemSuffixes = {},
        })
        AddProfile("HunterMarksmanship-PreRaidBIS-2", {
          class = "HUNTER",
          specKey = "HunterMarksmanship",
          specID = 363,
          icon = 132222,
          importedAt = 0,
          items = {
            [1] = 28275,
            [2] = 29381,
            [3] = 27801,
            [5] = 28228,
            [6] = 29526,
            [7] = 27874,
            [8] = 25686,
            [9] = 29527,
            [10] = 27474,
            [11] = 30860,
            [12] = 31077,
            [13] = 29383,
            [14] = 28288,
            [15] = 24259,
            [16] = 27846,
            [17] = 28315,
          },
          itemSuffixes = {},
        })
        AddProfile("HunterSurvival-PreRaidBIS-2", {
          class = "HUNTER",
          specKey = "HunterSurvival",
          specID = 362,
          icon = 132215,
          importedAt = 0,
          items = {
            [1] = 28275,
            [2] = 28343,
            [3] = 27801,
            [5] = 28228,
            [6] = 27760,
            [7] = 27837,
            [8] = 29262,
            [9] = 25697,
            [10] = 27474,
            [11] = 31326,
            [12] = 22961,
            [13] = 29383,
            [14] = 28034,
            [15] = 29382,
            [16] = 27846,
            [17] = 28263,
          },
          itemSuffixes = {},
        })

        -- ROGUE
        AddProfile("RogueCombat-PreRaidBIS-2", {
          class = "ROGUE",
          specKey = "RogueCombat",
          specID = 181,
          icon = 132090,
          importedAt = 0,
          items = {
            [1] = 28224,
            [2] = 29381,
            [3] = 27797,
            [5] = 28264,
            [6] = 29247,
            [7] = 27837,
            [8] = 25686,
            [9] = 29246,
            [10] = 25685,
            [11] = 31920,
            [12] = 30834,
            [13] = 23206,
            [14] = 29383,
            [15] = 24259,
            [16] = 28438,
            [17] = 28189,
          },
          itemSuffixes = {},
        })
        AddProfile("RogueAssassination-PreRaidBIS-2", {
          class = "ROGUE",
          specKey = "RogueAssassination",
          specID = 182,
          icon = 132292,
          importedAt = 0,
          items = {
            [1] = 28224,
            [2] = 29381,
            [3] = 27797,
            [5] = 28264,
            [6] = 29247,
            [7] = 27837,
            [8] = 25686,
            [9] = 29246,
            [10] = 25685,
            [11] = 31920,
            [12] = 30834,
            [13] = 23206,
            [14] = 29383,
            [15] = 24259,
            [16] = 28438,
            [17] = 28189,
          },
          itemSuffixes = {},
        })
        AddProfile("RogueSubtlety-PreRaidBIS-2", {
          class = "ROGUE",
          specKey = "RogueSubtlety",
          specID = 183,
          icon = 132320,
          importedAt = 0,
          items = {
            [1] = 28224,
            [2] = 29381,
            [3] = 27797,
            [5] = 28264,
            [6] = 29247,
            [7] = 27837,
            [8] = 25686,
            [9] = 29246,
            [10] = 25685,
            [11] = 31920,
            [12] = 30834,
            [13] = 23206,
            [14] = 29383,
            [15] = 24259,
            [16] = 28438,
            [17] = 28189,
          },
          itemSuffixes = {},
        })

        -- PRIEST
        AddProfile("PriestHoly-PreRaidBIS-2", {
          class = "PRIEST",
          specKey = "PriestHoly",
          specID = 202,
          icon = 237542,
          importedAt = 0,
          items = {
            [1] = 32090,
            [2] = 29374,
            [3] = 21874,
            [5] = 21875,
            [6] = 21873,
            [7] = 24261,
            [8] = 29251,
            [9] = 29183,
            [10] = 27536,
            [11] = 29373,
            [12] = 32535,
            [13] = 29376,
            [14] = 21625,
            [15] = 29354,
            [16] = 23556,
            [17] = 29170,
          },
          itemSuffixes = {},
        })
        AddProfile("PriestDiscipline-PreRaidBIS-2", {
          class = "PRIEST",
          specKey = "PriestDiscipline",
          specID = 201,
          icon = 135987,
          importedAt = 0,
          items = {
            [1] = 32090,
            [2] = 29374,
            [3] = 21874,
            [5] = 21875,
            [6] = 21873,
            [7] = 24261,
            [8] = 29251,
            [9] = 29183,
            [10] = 27536,
            [11] = 29373,
            [12] = 32535,
            [13] = 29376,
            [14] = 21625,
            [15] = 29354,
            [16] = 23556,
            [17] = 29170,
          },
          itemSuffixes = {},
        })
        AddProfile("PriestShadow-PreRaidBIS-2", {
          class = "PRIEST",
          specKey = "PriestShadow",
          specID = 203,
          icon = 136207,
          importedAt = 0,
          items = {
            [1] = 24266,
            [2] = 18814,
            [3] = 21869,
            [5] = 21871,
            [6] = 31199,
            [7] = 24262,
            [8] = 21870,
            [9] = 31225,
            [10] = 31166,
            [11] = 21709,
            [12] = 23031,
            [13] = 29370,
            [14] = 27683,
            [15] = 31201,
            [16] = 30832,
            [17] = 29272,
          },
          itemSuffixes = {},
        })

        -- SHAMAN
        AddProfile("ShamanRestoration-PreRaidBIS-2", {
          class = "SHAMAN",
          specKey = "ShamanRestoration",
          specID = 262,
          icon = 136052,
          importedAt = 0,
          items = {
            [1] = 32475,
            [2] = 32531,
            [3] = 27826,
            [5] = 29522,
            [6] = 29524,
            [7] = 24261,
            [8] = 27411,
            [9] = 29523,
            [10] = 27806,
            [11] = 29169,
            [12] = 32535,
            [13] = 29376,
            [14] = 38288,
            [15] = 31329,
            [16] = 32451,
            [17] = 29267,
          },
          itemSuffixes = {},
        })
        AddProfile("ShamanElemental-PreRaidBIS-2", {
          class = "SHAMAN",
          specKey = "ShamanElemental",
          specID = 261,
          icon = 136048,
          importedAt = 0,
          items = {
            [1] = 32086,
            [2] = 28134,
            [3] = 32078,
            [5] = 29519,
            [6] = 29520,
            [7] = 24262,
            [8] = 28406,
            [9] = 29521,
            [10] = 27465,
            [11] = 29126,
            [12] = 29367,
            [13] = 29370,
            [14] = 27683,
            [15] = 29369,
            [16] = 32450,
            [17] = 29273,
          },
          itemSuffixes = {},
        })
        AddProfile("ShamanEnhancement-PreRaidBIS-2", {
          class = "SHAMAN",
          specKey = "ShamanEnhancement",
          specID = 263,
          icon = 136051,
          importedAt = 0,
          items = {
            [1] = 28224,
            [2] = 29381,
            [3] = 27797,
            [5] = 29525,
            [6] = 29526,
            [7] = 31544,
            [8] = 25686,
            [9] = 29527,
            [10] = 25685,
            [11] = 30834,
            [12] = 31920,
            [13] = 29383,
            [14] = 23206,
            [15] = 33122,
            [16] = 28438,
            [17] = 29348,
          },
          itemSuffixes = {},
        })

        -- MAGE
        AddProfile("MageArcane-PreRaidBIS-2", {
          class = "MAGE",
          specKey = "MageArcane",
          specID = 81,
          icon = 135932,
          importedAt = 0,
          items = {
            [1] = 24266,
            [2] = 28134,
            [3] = 27994,
            [5] = 21848,
            [6] = 21846,
            [7] = 24262,
            [8] = 27821,
            [9] = 27462,
            [10] = 21847,
            [11] = 28227,
            [12] = 31339,
            [13] = 23207,
            [14] = 29132,
            [15] = 23050,
            [16] = 23554,
            [17] = 29271,
          },
          itemSuffixes = {},
        })
        AddProfile("MageFire-PreRaidBIS-2", {
          class = "MAGE",
          specKey = "MageFire",
          specID = 41,
          icon = 135810,
          importedAt = 0,
          items = {
            [1] = 24266,
            [2] = 28134,
            [3] = 30925,
            [5] = 21848,
            [6] = 21846,
            [7] = 24262,
            [8] = 27821,
            [9] = 24250,
            [10] = 21847,
            [11] = 29172,
            [12] = 21709,
            [13] = 23207,
            [14] = 29132,
            [15] = 23050,
            [16] = 23554,
            [17] = 29270,
          },
          itemSuffixes = {},
        })
        AddProfile("MageFrost-PreRaidBIS-2", {
          class = "MAGE",
          specKey = "MageFrost",
          specID = 61,
          icon = 135846,
          importedAt = 0,
          items = {
            [1] = 24266,
            [2] = 28134,
            [3] = 21869,
            [5] = 21871,
            [6] = 24256,
            [7] = 24262,
            [8] = 21870,
            [9] = 24250,
            [10] = 27493,
            [11] = 29172,
            [12] = 21709,
            [13] = 23207,
            [14] = 29132,
            [15] = 23050,
            [16] = 23554,
            [17] = 29269,
          },
          itemSuffixes = {},
        })

        -- WARLOCK
        AddProfile("WarlockAffliction-PreRaidBIS-2", {
          class = "WARLOCK",
          specKey = "WarlockAffliction",
          specID = 302,
          icon = 136145,
          importedAt = 0,
          items = {
            [1] = 24266,
            [2] = 28134,
            [3] = 21869,
            [5] = 21871,
            [6] = 24256,
            [7] = 24262,
            [8] = 21870,
            [9] = 21186,
            [10] = 21585,
            [11] = 29172,
            [12] = 29126,
            [13] = 29370,
            [14] = 27683,
            [15] = 23050,
            [16] = 31336,
            [17] = 29273,
          },
          itemSuffixes = {},
        })
        AddProfile("WarlockDemonology-PreRaidBIS-2", {
          class = "WARLOCK",
          specKey = "WarlockDemonology",
          specID = 303,
          icon = 136172,
          importedAt = 0,
          items = {
            [1] = 24266,
            [2] = 28134,
            [3] = 21869,
            [5] = 21871,
            [6] = 24256,
            [7] = 24262,
            [8] = 21870,
            [9] = 21186,
            [10] = 21585,
            [11] = 29172,
            [12] = 29126,
            [13] = 29370,
            [14] = 27683,
            [15] = 23050,
            [16] = 31336,
            [17] = 29273,
          },
          itemSuffixes = {},
        })
        AddProfile("WarlockDestruction-PreRaidBIS-2", {
          class = "WARLOCK",
          specKey = "WarlockDestruction",
          specID = 301,
          icon = 136186,
          importedAt = 0,
          items = {
            [1] = 24266,
            [2] = 28134,
            [3] = 21869,
            [5] = 21871,
            [6] = 24256,
            [7] = 24262,
            [8] = 21870,
            [9] = 21186,
            [10] = 21585,
            [11] = 29172,
            [12] = 29126,
            [13] = 29370,
            [14] = 27683,
            [15] = 23050,
            [16] = 31336,
            [17] = 29273,
          },
          itemSuffixes = {},
        })

        -- DRUID
        AddProfile("DruidRestoration-PreRaidBIS-2", {
          class = "DRUID",
          specKey = "DruidRestoration",
          specID = 282,
          icon = 136041,
          importedAt = 0,
          items = {
            [1] = 24264,
            [2] = 30377,
            [3] = 21874,
            [5] = 21875,
            [6] = 21873,
            [7] = 24261,
            [8] = 27411,
            [9] = 29183,
            [10] = 29506,
            [11] = 27780,
            [12] = 31383,
            [13] = 29376,
            [14] = 19395,
            [15] = 31329,
            [16] = 32451,
            [17] = 29274,
          },
          itemSuffixes = {},
        })
        AddProfile("DruidFeralDPS-PreRaidBIS-2", {
          class = "DRUID",
          specKey = "DruidFeralCombat",
          specID = 281,
          icon = 132276,
          importedAt = 0,
          items = {
            [1] = 8345,
            [2] = 24114,
            [3] = 27797,
            [5] = 29525,
            [6] = 29247,
            [7] = 31544,
            [8] = 25686,
            [9] = 29246,
            [10] = 28396,
            [11] = 30834,
            [12] = 31920,
            [13] = 29383,
            [14] = 23206,
            [15] = 31255,
            [16] = 31334,
          },
          itemSuffixes = {},
        })
        AddProfile("DruidFeralTank-PreRaidBIS-2", {
          class = "DRUID",
          specKey = "DruidFeralCombat",
          specID = 281,
          icon = 132276,
          importedAt = 0,
          items = {
            [1] = 29502,
            [2] = 29815,
            [3] = 27434,
            [5] = 25689,
            [6] = 30942,
            [7] = 25690,
            [8] = 28987,
            [9] = 30944,
            [10] = 30943,
            [11] = 30834,
            [12] = 29384,
            [13] = 29383,
            [14] = 23206,
            [15] = 28256,
            [16] = 29171,
          },
          itemSuffixes = {},
        })
        AddProfile("DruidBalance-PreRaidBIS-2", {
          class = "DRUID",
          specKey = "DruidBalance",
          specID = 283,
          icon = 136096,
          importedAt = 0,
          items = {
            [1] = 24266,
            [2] = 28134,
            [3] = 27796,
            [5] = 21848,
            [6] = 21846,
            [7] = 24262,
            [8] = 27821,
            [9] = 29523,
            [10] = 21847,
            [11] = 29172,
            [12] = 28227,
            [13] = 29370,
            [14] = 29132,
            [15] = 27981,
            [16] = 23554,
            [17] = 29271,
          },
          itemSuffixes = {},
        })
        AddProfile("RogueCombat-PreRaidBIS", {
          class = "ROGUE",
          specKey = "RogueCombat",
          specID = 181,
          icon = 132090,
          importedAt = 0,
          items = {
            [1] = 28224,
            [2] = 29381,
            [3] = 27797,
            [5] = 28264,
            [6] = 29247,
            [7] = 27837,
            [8] = 25686,
            [9] = 29246,
            [10] = 25685,
            [11] = 31077,
            [12] = 30834,
            [13] = 29383,
            [14] = 28288,
            [15] = 27878,
            [16] = 28438,
            [17] = 28189,
            [18] = 29152,
          },
          itemSuffixes = {},
        })

        AddProfile("RogueSubtlety-PreRaidBIS", {
          class = "ROGUE",
          specKey = "RogueSubtlety",
          specID = 183,
          icon = 132320,
          importedAt = 0,
          items = {
            [1] = 28224,
            [2] = 29381,
            [3] = 27797,
            [5] = 28264,
            [6] = 29247,
            [7] = 27837,
            [8] = 25686,
            [9] = 29246,
            [10] = 25685,
            [11] = 31077,
            [12] = 30834,
            [13] = 29383,
            [14] = 28288,
            [15] = 27878,
            [16] = 28438,
            [17] = 28189,
            [18] = 29152,
          },
          itemSuffixes = {},
        })

        AddProfile("PriestShadow-PreRaidBIS", {
          class = "PRIEST",
          specKey = "PriestShadow",
          specID = 203,
          icon = 136207,
          importedAt = 0,
          items = {
            [1] = 24266,
            [2] = 28245,
            [3] = 21869,
            [5] = 21871,
            [6] = 24256,
            [7] = 24262,
            [8] = 21870,
            [9] = 24250,
            [10] = 29317,
            [11] = 31075,
            [12] = 29352,
            [13] = 29370,
            [14] = 27683,
            [15] = 24252,
            [16] = 30832,
            [17] = 29272,
            [18] = 29350,
          },
          itemSuffixes = {},
        })

        AddProfile("MageFrost-PreRaidBIS", {
          class = "MAGE",
          specKey = "MageFrost",
          specID = 61,
          icon = 135846,
          importedAt = 0,
          items = {
            [1] = 28193,
            [2] = 28134,
            [3] = 21869,
            [5] = 21871,
            [6] = 24256,
            [7] = 24262,
            [8] = 21870,
            [9] = 24250,
            [10] = 27465,
            [11] = 28227,
            [12] = 32779,
            [13] = 29370,
            [14] = 27683,
            [15] = 29369,
            [16] = 29155,
            [17] = 29269,
            [18] = 29350,
          },
          itemSuffixes = {},
        })

        AddProfile("DruidRestoration-PreRaidBIS", {
          class = "DRUID",
          specKey = "DruidRestoration",
          specID = 282,
          icon = 136041,
          importedAt = 0,
          items = {
            [1] = 32090,
            [2] = 30377,
            [3] = 21874,
            [5] = 21875,
            [6] = 21873,
            [7] = 30543,
            [8] = 27411,
            [9] = 29183,
            [10] = 29506,
            [11] = 31383,
            [12] = 27780,
            [13] = 29376,
            [14] = 30841,
            [15] = 29354,
            [16] = 29353,
            [17] = 29274,
            [18] = 27886,
          },
          itemSuffixes = {},
        })

        AddProfile("MageArcane-PreRaidBIS", {
          class = "MAGE",
          specKey = "MageArcane",
          specID = 81,
          icon = 135932,
          importedAt = 0,
          items = {
            [1] = 28278,
            [2] = 28134,
            [3] = 27738,
            [5] = 21848,
            [6] = 21846,
            [7] = 30532,
            [8] = 29258,
            [9] = 28411,
            [10] = 21847,
            [11] = 29367,
            [12] = 29352,
            [13] = 29370,
            [14] = 27683,
            [15] = 25777,
            [16] = 29155,
            [17] = 29271,
            [18] = 28386,
          },
          itemSuffixes = {},
        })

        AddProfile("WarlockDestruction-PreRaidBIS", {
          class = "WARLOCK",
          specKey = "WarlockDestruction",
          specID = 301,
          icon = 136186,
          importedAt = 0,
          items = {
            [1] = 28193,
            [2] = 28134,
            [3] = 21869,
            [5] = 21871,
            [6] = 24256,
            [7] = 24262,
            [8] = 21870,
            [9] = 24250,
            [10] = 27465,
            [11] = 28227,
            [12] = 29367,
            [13] = 27683,
            [14] = 29370,
            [15] = 27981,
            [16] = 29155,
            [17] = 29273,
            [18] = 29350,
          },
          itemSuffixes = {},
        })

        AddProfile("HunterMarksmanship-PreRaidBIS", {
          class = "HUNTER",
          specKey = "HunterMarksmanship",
          specID = 363,
          icon = 132222,
          importedAt = 0,
          items = {
            [1] = 28275,
            [2] = 29381,
            [3] = 27801,
            [5] = 28228,
            [6] = 27760,
            [7] = 30538,
            [8] = 25686,
            [9] = 29246,
            [10] = 27474,
            [11] = 30860,
            [12] = 31077,
            [13] = 29383,
            [14] = 28288,
            [15] = 24259,
            [16] = 28435,
            [18] = 29351,
          },
          itemSuffixes = {},
        })

        AddProfile("ShamanEnhancement-PreRaidBIS", {
          class = "SHAMAN",
          specKey = "ShamanEnhancement",
          specID = 263,
          icon = 136051,
          importedAt = 0,
          items = {
            [1] = 28224,
            [2] = 29381,
            [3] = 27797,
            [5] = 29515,
            [6] = 29516,
            [7] = 30538,
            [8] = 25686,
            [9] = 29517,
            [10] = 25685,
            [11] = 30834,
            [12] = 30365,
            [13] = 29383,
            [14] = 28288,
            [15] = 24259,
            [16] = 29348,
            [17] = 27872,
            [18] = 27815,
          },
          itemSuffixes = {},
        })

        AddProfile("ShamanRestoration-PreRaidBIS", {
          class = "SHAMAN",
          specKey = "ShamanRestoration",
          specID = 262,
          icon = 136052,
          importedAt = 0,
          items = {
            [1] = 32090,
            [2] = 31691,
            [3] = 21874,
            [5] = 21875,
            [6] = 21873,
            [7] = 30543,
            [8] = 27411,
            [9] = 29183,
            [10] = 28304,
            [11] = 29168,
            [12] = 29814,
            [13] = 29376,
            [14] = 28190,
            [15] = 24254,
            [16] = 23556,
            [17] = 29274,
            [18] = 27544,
          },
          itemSuffixes = {},
        })

        AddProfile("MageFire-PreRaidBIS", {
          class = "MAGE",
          specKey = "MageFire",
          specID = 41,
          icon = 135810,
          importedAt = 0,
          items = {
            [1] = 28193,
            [2] = 28134,
            [3] = 27796,
            [5] = 21848,
            [6] = 21846,
            [7] = 24262,
            [8] = 28406,
            [9] = 28411,
            [10] = 21847,
            [11] = 28227,
            [12] = 29367,
            [13] = 29370,
            [14] = 27683,
            [15] = 29369,
            [16] = 29155,
            [17] = 29270,
            [18] = 29350,
          },
          itemSuffixes = {},
        })

        AddProfile("WarriorArms-PreRaidBIS", {
          class = "WARRIOR",
          specKey = "WarriorArms",
          specID = 161,
          icon = 132292,
          importedAt = 0,
          items = {
            [1] = 32087,
            [2] = 29349,
            [3] = 33173,
            [5] = 23522,
            [6] = 27985,
            [7] = 30257,
            [8] = 25686,
            [9] = 28381,
            [10] = 25685,
            [11] = 30834,
            [12] = 29379,
            [13] = 29383,
            [14] = 28034,
            [15] = 24259,
            [16] = 28429,
            [18] = 30279,
          },
          itemSuffixes = {},
        })

        AddProfile("WarlockAffliction-PreRaidBIS", {
          class = "WARLOCK",
          specKey = "WarlockAffliction",
          specID = 302,
          icon = 136145,
          importedAt = 0,
          items = {
            [1] = 28193,
            [2] = 28134,
            [3] = 21869,
            [5] = 21871,
            [6] = 24256,
            [7] = 24262,
            [8] = 21870,
            [9] = 24250,
            [10] = 27465,
            [11] = 28227,
            [12] = 29367,
            [13] = 27683,
            [14] = 29370,
            [15] = 27981,
            [16] = 29155,
            [17] = 29273,
            [18] = 29350,
          },
          itemSuffixes = {},
        })

        AddProfile("PriestHoly-PreRaidBIS", {
          class = "PRIEST",
          specKey = "PriestHoly",
          specID = 202,
          icon = 237542,
          importedAt = 0,
          items = {
            [1] = 32090,
            [2] = 30377,
            [3] = 21874,
            [5] = 21875,
            [6] = 21873,
            [7] = 30543,
            [8] = 27411,
            [9] = 29183,
            [10] = 24393,
            [11] = 27780,
            [12] = 29168,
            [13] = 29376,
            [14] = 28190,
            [15] = 29354,
            [16] = 29353,
            [17] = 29170,
            [18] = 27885,
          },
          itemSuffixes = {},
        })

        AddProfile("WarlockDemonology-PreRaidBIS", {
          class = "WARLOCK",
          specKey = "WarlockDemonology",
          specID = 303,
          icon = 136172,
          importedAt = 0,
          items = {
            [1] = 28193,
            [2] = 28134,
            [3] = 21869,
            [5] = 21871,
            [6] = 24256,
            [7] = 24262,
            [8] = 21870,
            [9] = 24250,
            [10] = 27465,
            [11] = 28227,
            [12] = 29367,
            [13] = 27683,
            [14] = 29370,
            [15] = 27981,
            [16] = 29155,
            [17] = 29273,
            [18] = 29350,
          },
          itemSuffixes = {},
        })

        AddProfile("WarriorFury-PreRaidBIS", {
          class = "WARRIOR",
          specKey = "WarriorFury",
          specID = 164,
          icon = 132347,
          importedAt = 0,
          items = {
            [1] = 32087,
            [2] = 29381,
            [3] = 33173,
            [5] = 23522,
            [6] = 27985,
            [7] = 30538,
            [8] = 25686,
            [9] = 28381,
            [10] = 25685,
            [11] = 30834,
            [12] = 29379,
            [13] = 29383,
            [14] = 28034,
            [15] = 24259,
            [16] = 28438,
            [17] = 29124,
            [18] = 30279,
          },
          itemSuffixes = {},
        })

        AddProfile("WarriorProtection-PreRaidBIS", {
          class = "WARRIOR",
          specKey = "WarriorProtection",
          specID = 163,
          icon = 134952,
          importedAt = 0,
          items = {
            [1] = 32083,
            [2] = 28244,
            [3] = 32073,
            [5] = 28205,
            [6] = 28385,
            [7] = 29184,
            [8] = 28383,
            [9] = 28381,
            [10] = 30341,
            [11] = 30834,
            [12] = 28553,
            [13] = 28121,
            [14] = 29383,
            [15] = 28377,
            [16] = 28189,
            [17] = 29266,
            [18] = 29152,
          },
          itemSuffixes = {},
        })

        AddProfile("ShamanElemental-PreRaidBIS", {
          class = "SHAMAN",
          specKey = "ShamanElemental",
          specID = 261,
          icon = 136048,
          importedAt = 0,
          items = {
            [1] = 32086,
            [2] = 31692,
            [3] = 27796,
            [5] = 29519,
            [6] = 29520,
            [7] = 24262,
            [8] = 28406,
            [9] = 29521,
            [10] = 27465,
            [11] = 32779,
            [12] = 29367,
            [13] = 27683,
            [14] = 29370,
            [15] = 29369,
            [16] = 30832,
            [17] = 29268,
            [18] = 28248,
          },
          itemSuffixes = {},
        })

        AddProfile("HunterSurvival-PreRaidBIS", {
          class = "HUNTER",
          specKey = "HunterSurvival",
          specID = 362,
          icon = 132215,
          importedAt = 0,
          items = {
            [1] = 28275,
            [2] = 28343,
            [3] = 27801,
            [5] = 28228,
            [6] = 27760,
            [7] = 27837,
            [8] = 29248,
            [9] = 25697,
            [10] = 27474,
            [11] = 31277,
            [12] = 27453,
            [13] = 29383,
            [14] = 28288,
            [15] = 29382,
            [16] = 29329,
            [18] = 29351,
          },
          itemSuffixes = {},
        })

        AddProfile("RogueAssassination-PreRaidBIS", {
          class = "ROGUE",
          specKey = "RogueAssassination",
          specID = 182,
          icon = 132292,
          importedAt = 0,
          items = {
            [1] = 28224,
            [2] = 29381,
            [3] = 27797,
            [5] = 28264,
            [6] = 29247,
            [7] = 27837,
            [8] = 25686,
            [9] = 29246,
            [10] = 25685,
            [11] = 31077,
            [12] = 30834,
            [13] = 29383,
            [14] = 28288,
            [15] = 27878,
            [16] = 29360,
            [17] = 29346,
            [18] = 29152,
          },
          itemSuffixes = {},
        })

        AddProfile("PaladinHoly-PreRaidBIS", {
          class = "PALADIN",
          specKey = "PaladinHoly",
          specID = 382,
          icon = 135920,
          importedAt = 0,
          items = {
            [1] = 32084,
            [2] = 31691,
            [3] = 27775,
            [5] = 28230,
            [6] = 29250,
            [7] = 30543,
            [8] = 27411,
            [9] = 23539,
            [10] = 27457,
            [11] = 29168,
            [12] = 27780,
            [13] = 29376,
            [14] = 28190,
            [15] = 29354,
            [16] = 29353,
            [17] = 29274,
            [18] = 25644,
          },
          itemSuffixes = {},
        })

        AddProfile("HunterBeastMastery-PreRaidBIS", {
          class = "HUNTER",
          specKey = "HunterBeastMastery",
          specID = 361,
          icon = 132164,
          importedAt = 0,
          items = {
            [1] = 28275,
            [2] = 29381,
            [3] = 27801,
            [5] = 28228,
            [6] = 27760,
            [7] = 30538,
            [8] = 25686,
            [9] = 29246,
            [10] = 27474,
            [11] = 30860,
            [12] = 31077,
            [13] = 29383,
            [14] = 28288,
            [15] = 24259,
            [16] = 28435,
            [18] = 29351,
          },
          itemSuffixes = {},
        })

        AddProfile("PaladinRetribution-PreRaidBIS", {
          class = "PALADIN",
          specKey = "PaladinRetribution",
          specID = 381,
          icon = 135873,
          importedAt = 0,
          items = {
            [1] = 32087,
            [2] = 29119,
            [3] = 33173,
            [5] = 23522,
            [6] = 27985,
            [7] = 30257,
            [8] = 28176,
            [9] = 23537,
            [10] = 30341,
            [11] = 30834,
            [12] = 29177,
            [13] = 29383,
            [14] = 28288,
            [15] = 24259,
            [16] = 28429,
            [18] = 27484,
          },
          itemSuffixes = {},
        })

        AddProfile("PaladinProtection-PreRaidBIS", {
          class = "PALADIN",
          specKey = "PaladinProtection",
          specID = 383,
          icon = 135893,
          importedAt = 0,
          items = {
            [1] = 32083,
            [2] = 29173,
            [3] = 27739,
            [5] = 28203,
            [6] = 29253,
            [7] = 29184,
            [8] = 29254,
            [9] = 29252,
            [10] = 23517,
            [11] = 28407,
            [12] = 29323,
            [13] = 29370,
            [14] = 27529,
            [15] = 27804,
            [16] = 30832,
            [17] = 29266,
            [18] = 29388,
          },
          itemSuffixes = {},
        })

        AddProfile("DruidBalance-PreRaidBIS", {
          class = "DRUID",
          specKey = "DruidBalance",
          specID = 283,
          icon = 136096,
          importedAt = 0,
          items = {
            [1] = 28278,
            [2] = 28134,
            [3] = 27796,
            [5] = 21848,
            [6] = 21846,
            [7] = 24262,
            [8] = 28406,
            [9] = 24250,
            [10] = 21847,
            [11] = 28227,
            [12] = 29367,
            [13] = 29370,
            [14] = 27683,
            [15] = 27981,
            [16] = 30832,
            [17] = 29271,
            [18] = 27518,
          },
          itemSuffixes = {},
        })

        wowSims.defaultsVersion = 0
        installedVersion = 0
      end
      if installedVersion < 2 then
        -- Phase 1
        -- DRUID
        AddProfile("DruidBalance-Phase1BIS", {
          class = "DRUID",
          specKey = "DruidBalance",
          specID = 283,
          icon = 136096,
          importedAt = 0,
          items = {
            [1] = 29093,
            [2] = 28762,
            [3] = 29095,
            [5] = 21848,
            [6] = 21846,
            [7] = 24262,
            [8] = 28517,
            [9] = 24250,
            [10] = 21847,
            [11] = 29287,
            [12] = 28753,
            [13] = 29370,
            [14] = 27683,
            [15] = 28766,
            [16] = 28770,
            [17] = 29271,
            [18] = 27518,
          },
          itemSuffixes = {},
        })
        AddProfile("DruidFeralDps-Phase1BIS", {
          class = "DRUID",
          specKey = "DruidFeralCombat",
          specID = 281,
          icon = 132276,
          importedAt = 0,
          items = {
            [1] = 8345,
            [2] = 29381,
            [3] = 29100,
            [5] = 29096,
            [6] = 28750,
            [7] = 28741,
            [8] = 28545,
            [9] = 29246,
            [10] = 28506,
            [11] = 30834,
            [12] = 28791,
            [13] = 29383,
            [14] = 28830,
            [15] = 24259,
            [16] = 28658,
            [18] = 29390,
          },
          itemSuffixes = {},
        })
        AddProfile("DruidFeralTank-Phase1BIS", {
          class = "DRUID",
          specKey = "DruidFeralCombat",
          specID = 281,
          icon = 132276,
          importedAt = 0,
          items = {
            [1] = 29098,
            [2] = 28509,
            [3] = 29100,
            [5] = 29096,
            [6] = 28423,
            [7] = 29099,
            [8] = 28422,
            [9] = 28445,
            [10] = 30644,
            [11] = 29279,
            [12] = 30834,
            [13] = 28579,
            [14] = 29383,
            [15] = 28660,
            [16] = 28658,
            [18] = 23198,
          },
          itemSuffixes = {},
        })
        AddProfile("DruidRestoration-Phase1BIS", {
          class = "DRUID",
          specKey = "DruidRestoration",
          specID = 282,
          icon = 136041,
          importedAt = 0,
          items = {
            [1] = 29086,
            [2] = 28609,
            [3] = 29089,
            [5] = 21875,
            [6] = 21873,
            [7] = 28591,
            [8] = 28752,
            [9] = 29183,
            [10] = 28521,
            [11] = 28763,
            [12] = 29290,
            [13] = 29376,
            [14] = 30841,
            [15] = 28765,
            [16] = 28771,
            [17] = 29274,
            [18] = 27886,
          },
          itemSuffixes = {},
        })
        -- HUNTER
        AddProfile("HunterBeastMastery-Phase1BIS", {
          class = "HUNTER",
          specKey = "HunterBeastMastery",
          specID = 361,
          icon = 132164,
          importedAt = 0,
          items = {
            [1] = 28275,
            [2] = 29381,
            [3] = 27801,
            [5] = 28228,
            [6] = 28828,
            [7] = 28741,
            [8] = 28545,
            [9] = 29246,
            [10] = 27474,
            [11] = 28757,
            [12] = 28791,
            [13] = 28830,
            [14] = 29383,
            [15] = 24259,
            [16] = 28435,
            [18] = 28772,
          },
          itemSuffixes = {},
        })
        AddProfile("HunterMarksmanship-Phase1BIS", {
          class = "HUNTER",
          specKey = "HunterMarksmanship",
          specID = 363,
          icon = 132222,
          importedAt = 0,
          items = {
            [1] = 28275,
            [2] = 29381,
            [3] = 27801,
            [5] = 28228,
            [6] = 28828,
            [7] = 28741,
            [8] = 28545,
            [9] = 29246,
            [10] = 27474,
            [11] = 28757,
            [12] = 28791,
            [13] = 28830,
            [14] = 29383,
            [15] = 24259,
            [16] = 28435,
            [18] = 28772,
          },
          itemSuffixes = {},
        })
        AddProfile("HunterSurvival-Phase1BIS", {
          class = "HUNTER",
          specKey = "HunterSurvival",
          specID = 362,
          icon = 132215,
          importedAt = 0,
          items = {
            [1] = 28275,
            [2] = 28343,
            [3] = 27801,
            [5] = 28228,
            [6] = 27760,
            [7] = 28741,
            [8] = 28545,
            [9] = 25697,
            [10] = 27474,
            [11] = 31277,
            [12] = 28791,
            [13] = 28830,
            [14] = 29383,
            [15] = 28672,
            [16] = 28587,
            [18] = 28772,
          },
          itemSuffixes = {},
        })
        -- MAGE
        AddProfile("MageArcane-Phase1BIS", {
          class = "MAGE",
          specKey = "MageArcane",
          specID = 81,
          icon = 135932,
          importedAt = 0,
          items = {
            [1] = 29076,
            [2] = 28762,
            [3] = 29079,
            [5] = 21848,
            [6] = 21846,
            [7] = 28594,
            [8] = 28517,
            [9] = 28411,
            [10] = 21847,
            [11] = 29287,
            [12] = 28793,
            [13] = 29370,
            [14] = 28785,
            [15] = 28797,
            [16] = 28770,
            [17] = 29271,
            [18] = 28783,
          },
          itemSuffixes = {},
        })
        AddProfile("MageFire-Phase1BIS", {
          class = "MAGE",
          specKey = "MageFire",
          specID = 41,
          icon = 135810,
          importedAt = 0,
          items = {
            [1] = 29076,
            [2] = 28762,
            [3] = 29079,
            [5] = 21848,
            [6] = 21846,
            [7] = 24262,
            [8] = 28517,
            [9] = 28411,
            [10] = 21847,
            [11] = 28793,
            [12] = 28753,
            [13] = 29370,
            [14] = 27683,
            [15] = 28766,
            [16] = 28770,
            [17] = 29270,
            [18] = 28673,
          },
          itemSuffixes = {},
        })
        AddProfile("MageFrost-Phase1BIS", {
          class = "MAGE",
          specKey = "MageFrost",
          specID = 61,
          icon = 135846,
          importedAt = 0,
          items = {
            [1] = 29076,
            [2] = 28762,
            [3] = 21869,
            [5] = 21871,
            [6] = 24256,
            [7] = 24262,
            [8] = 21870,
            [9] = 24250,
            [10] = 28780,
            [11] = 28793,
            [12] = 28753,
            [13] = 29370,
            [14] = 27683,
            [15] = 28766,
            [16] = 28770,
            [17] = 29269,
            [18] = 28673,
          },
          itemSuffixes = {},
        })
        -- PALADIN
        AddProfile("PaladinHoly-Phase1BIS", {
          class = "PALADIN",
          specKey = "PaladinHoly",
          specID = 382,
          icon = 135920,
          importedAt = 0,
          items = {
            [1] = 29061,
            [2] = 28609,
            [3] = 29064,
            [5] = 29062,
            [6] = 28733,
            [7] = 28748,
            [8] = 28752,
            [9] = 23539,
            [10] = 28505,
            [11] = 28763,
            [12] = 28790,
            [13] = 29376,
            [14] = 28590,
            [15] = 28765,
            [16] = 28771,
            [17] = 29458,
            [18] = 25644,
          },
          itemSuffixes = {},
        })
        AddProfile("PaladinProtection-Phase1BIS", {
          class = "PALADIN",
          specKey = "PaladinProtection",
          specID = 383,
          icon = 135893,
          importedAt = 0,
          items = {
            [1] = 29068,
            [2] = 28516,
            [3] = 29070,
            [5] = 29066,
            [6] = 28566,
            [7] = 29069,
            [8] = 30641,
            [9] = 29252,
            [10] = 28518,
            [11] = 29279,
            [12] = 29172,
            [13] = 29370,
            [14] = 28789,
            [15] = 27804,
            [16] = 28802,
            [17] = 28825,
            [18] = 29388,
          },
          itemSuffixes = {},
        })
        AddProfile("PaladinRetribution-Phase1BIS", {
          class = "PALADIN",
          specKey = "PaladinRetribution",
          specID = 381,
          icon = 135873,
          importedAt = 0,
          items = {
            [1] = 29073,
            [2] = 28745,
            [3] = 29075,
            [5] = 29071,
            [6] = 28779,
            [7] = 30257,
            [8] = 28608,
            [9] = 28795,
            [10] = 30644,
            [11] = 30834,
            [12] = 28730,
            [13] = 28830,
            [14] = 29383,
            [15] = 24259,
            [16] = 28429,
            [18] = 27484,
          },
          itemSuffixes = {},
        })
        -- PRIEST
        AddProfile("PriestHoly-Phase1BIS", {
          class = "PRIEST",
          specKey = "PriestHoly",
          specID = 202,
          icon = 237542,
          importedAt = 0,
          items = {
            [1] = 29049,
            [2] = 28822,
            [3] = 21874,
            [5] = 21875,
            [6] = 21873,
            [7] = 28742,
            [8] = 28663,
            [9] = 29183,
            [10] = 28508,
            [11] = 28763,
            [12] = 29290,
            [13] = 29376,
            [14] = 28823,
            [15] = 28765,
            [16] = 28771,
            [17] = 29170,
            [18] = 28588,
          },
          itemSuffixes = {},
        })
        AddProfile("PriestShadow-Phase1BIS", {
          class = "PRIEST",
          specKey = "PriestShadow",
          specID = 203,
          icon = 136207,
          importedAt = 0,
          items = {
            [1] = 24266,
            [2] = 30666,
            [3] = 21869,
            [5] = 21871,
            [6] = 28799,
            [7] = 24262,
            [8] = 21870,
            [9] = 24250,
            [10] = 28780,
            [11] = 28753,
            [12] = 29352,
            [13] = 29370,
            [14] = 27683,
            [15] = 28570,
            [16] = 28770,
            [17] = 29272,
            [18] = 29350,
          },
          itemSuffixes = {},
        })
        AddProfile("PriestSmite-Phase1BIS", {
          class = "PRIEST",
          specKey = "PriestShadow",
          specID = 203,
          icon = 136207,
          importedAt = 0,
          items = {
            [1] = 24266,
            [2] = 28530,
            [3] = 29060,
            [5] = 29056,
            [6] = 24256,
            [7] = 30734,
            [8] = 28517,
            [9] = 24250,
            [10] = 30725,
            [11] = 28793,
            [12] = 29172,
            [13] = 27683,
            [14] = 29370,
            [15] = 28766,
            [16] = 30723,
            [17] = 28734,
            [18] = 28673,
          },
          itemSuffixes = {},
        })
        -- ROGUE
        AddProfile("RogueAssassination-Phase1BIS", {
          class = "ROGUE",
          specKey = "RogueAssassination",
          specID = 182,
          icon = 132292,
          importedAt = 0,
          items = {
            [1] = 29044,
            [2] = 29381,
            [3] = 27797,
            [5] = 29045,
            [6] = 29247,
            [7] = 28741,
            [8] = 28545,
            [9] = 29246,
            [10] = 27531,
            [11] = 28757,
            [12] = 28649,
            [13] = 28830,
            [14] = 29383,
            [15] = 28672,
            [16] = 28768,
            [17] = 28572,
            [18] = 28772,
          },
          itemSuffixes = {},
        })
        AddProfile("RogueCombat-Phase1BIS", {
          class = "ROGUE",
          specKey = "RogueCombat",
          specID = 181,
          icon = 132090,
          importedAt = 0,
          items = {
            [1] = 29044,
            [2] = 29381,
            [3] = 27797,
            [5] = 29045,
            [6] = 29247,
            [7] = 28741,
            [8] = 28545,
            [9] = 29246,
            [10] = 27531,
            [11] = 28757,
            [12] = 28649,
            [13] = 28830,
            [14] = 29383,
            [15] = 28672,
            [16] = 28438,
            [17] = 28189,
            [18] = 28772,
          },
          itemSuffixes = {},
        })
        AddProfile("RogueSubtlety-Phase1BIS", {
          class = "ROGUE",
          specKey = "RogueSubtlety",
          specID = 183,
          icon = 132320,
          importedAt = 0,
          items = {
            [1] = 29044,
            [2] = 29381,
            [3] = 27797,
            [5] = 29045,
            [6] = 29247,
            [7] = 28741,
            [8] = 28545,
            [9] = 29246,
            [10] = 27531,
            [11] = 28757,
            [12] = 28649,
            [13] = 28830,
            [14] = 29383,
            [15] = 28672,
            [16] = 28438,
            [17] = 28189,
            [18] = 28772,
          },
          itemSuffixes = {},
        })
        -- SHAMAN
        AddProfile("ShamanElemental-Phase1BIS", {
          class = "SHAMAN",
          specKey = "ShamanElemental",
          specID = 261,
          icon = 136048,
          importedAt = 0,
          items = {
            [1] = 29035,
            [2] = 28762,
            [3] = 29037,
            [5] = 29519,
            [6] = 29520,
            [7] = 24262,
            [8] = 28517,
            [9] = 29521,
            [10] = 28780,
            [11] = 30667,
            [12] = 28753,
            [13] = 28785,
            [14] = 29370,
            [15] = 28797,
            [16] = 28770,
            [17] = 29268,
            [18] = 28248,
          },
          itemSuffixes = {},
        })
        AddProfile("ShamanEnhancement-Phase1BIS", {
          class = "SHAMAN",
          specKey = "ShamanEnhancement",
          specID = 263,
          icon = 136051,
          importedAt = 0,
          items = {
            [1] = 29040,
            [2] = 29381,
            [3] = 29043,
            [5] = 29515,
            [6] = 29516,
            [7] = 28741,
            [8] = 28545,
            [9] = 29517,
            [10] = 28776,
            [11] = 28757,
            [12] = 28649,
            [13] = 28830,
            [14] = 29383,
            [15] = 24259,
            [16] = 28767,
            [17] = 27872,
            [18] = 27815,
          },
          itemSuffixes = {},
        })
        AddProfile("ShamanRestoration-Phase1BIS", {
          class = "SHAMAN",
          specKey = "ShamanRestoration",
          specID = 262,
          icon = 136052,
          importedAt = 0,
          items = {
            [1] = 29028,
            [2] = 28609,
            [3] = 29031,
            [5] = 21875,
            [6] = 21873,
            [7] = 28751,
            [8] = 28752,
            [9] = 29183,
            [10] = 28520,
            [11] = 28763,
            [12] = 28790,
            [13] = 29376,
            [14] = 28190,
            [15] = 28765,
            [16] = 28771,
            [17] = 29458,
            [18] = 28523,
          },
          itemSuffixes = {},
        })
        -- WARLOCK
        AddProfile("WarlockAffliction-Phase1BIS", {
          class = "WARLOCK",
          specKey = "WarlockAffliction",
          specID = 302,
          icon = 136145,
          importedAt = 0,
          items = {
            [1] = 28963,
            [2] = 28762,
            [3] = 28967,
            [5] = 28964,
            [6] = 24256,
            [7] = 24262,
            [8] = 21870,
            [9] = 24250,
            [10] = 28968,
            [11] = 28793,
            [12] = 28753,
            [13] = 27683,
            [14] = 29370,
            [15] = 28766,
            [16] = 28802,
            [17] = 29273,
            [18] = 28673,
          },
          itemSuffixes = {},
        })
        AddProfile("WarlockDestructionFire-Phase1BIS", {
          class = "WARLOCK",
          specKey = "WarlockDestruction",
          specID = 301,
          icon = 136186,
          importedAt = 0,
          items = {
            [1] = 28963,
            [2] = 28530,
            [3] = 28967,
            [5] = 21848,
            [6] = 21846,
            [7] = 24262,
            [8] = 28517,
            [9] = 24250,
            [10] = 21847,
            [11] = 28793,
            [12] = 28753,
            [13] = 27683,
            [14] = 29370,
            [15] = 28766,
            [16] = 28802,
            [17] = 29270,
            [18] = 28673,
          },
          itemSuffixes = {},
        })
        AddProfile("WarlockDemonology-Phase1BIS", {
          class = "WARLOCK",
          specKey = "WarlockDemonology",
          specID = 303,
          icon = 136172,
          importedAt = 0,
          items = {
            [1] = 28963,
            [2] = 28762,
            [3] = 28967,
            [5] = 28964,
            [6] = 24256,
            [7] = 24262,
            [8] = 21870,
            [9] = 24250,
            [10] = 28968,
            [11] = 28793,
            [12] = 28753,
            [13] = 27683,
            [14] = 29370,
            [15] = 28766,
            [16] = 28802,
            [17] = 29273,
            [18] = 28673,
          },
          itemSuffixes = {},
        })
        -- WARRIOR
        AddProfile("WarriorArms-Phase1BIS", {
          class = "WARRIOR",
          specKey = "WarriorArms",
          specID = 161,
          icon = 132292,
          importedAt = 0,
          items = {
            [1] = 29021,
            [2] = 28745,
            [3] = 29023,
            [5] = 29019,
            [6] = 28779,
            [7] = 28741,
            [8] = 28608,
            [9] = 28795,
            [10] = 28824,
            [11] = 28757,
            [12] = 28730,
            [13] = 28830,
            [14] = 29383,
            [15] = 24259,
            [16] = 28429,
            [18] = 28772,
          },
          itemSuffixes = {},
        })
        AddProfile("WarriorFury-Phase1BIS", {
          class = "WARRIOR",
          specKey = "WarriorFury",
          specID = 164,
          icon = 132347,
          importedAt = 0,
          items = {
            [1] = 29021,
            [2] = 28745,
            [3] = 29023,
            [5] = 29019,
            [6] = 28779,
            [7] = 28741,
            [8] = 28608,
            [9] = 28795,
            [10] = 28824,
            [11] = 28757,
            [12] = 28730,
            [13] = 28830,
            [14] = 29383,
            [15] = 24259,
            [16] = 28438,
            [17] = 28729,
            [18] = 28772,
          },
          itemSuffixes = {},
        })
        AddProfile("WarriorProtection-Phase1BIS", {
          class = "WARRIOR",
          specKey = "WarriorProtection",
          specID = 163,
          icon = 134952,
          importedAt = 0,
          items = {
            [1] = 29011,
            [2] = 28244,
            [3] = 29023,
            [5] = 29012,
            [6] = 28385,
            [7] = 28621,
            [8] = 28383,
            [9] = 28381,
            [10] = 30644,
            [11] = 30834,
            [12] = 29279,
            [13] = 28121,
            [14] = 29383,
            [15] = 28377,
            [16] = 28749,
            [17] = 28825,
            [18] = 28826,
          },
          itemSuffixes = {},
        })
        wowSims.defaultsVersion = 2
        installedVersion = 2
      end
    end
    local function AutoAssignWoWSimsProfileIfMissing()
      if not MerfinPlus.db or not MerfinPlus.db.global then
        return
      end

      local wowSims = MerfinPlus.db.global.wowSims

      wowSims.profiles = wowSims.profiles or {}
      wowSims.assigned = wowSims.assigned or {}

      local profiles = wowSims.profiles
      local assigned = wowSims.assigned

      local name, realm = UnitName("player")
      if not name then
        return
      end
      realm = realm or GetNormalizedRealmName() or "UNKNOWN"
      local charKey = name .. "-" .. realm

      assigned[charKey] = assigned[charKey] or {}

      local class = select(2, UnitClass("player"))
      if not class then
        return
      end

      local bestTab, bestPoints = nil, -1
      for tab = 1, GetNumTalentTabs() do
        local points = select(5, GetTalentTabInfo(tab))
        if points and points > bestPoints then
          bestPoints = points
          bestTab = tab
        end
      end
      if not bestTab then
        return
      end

      local SPEC_ID_BY_CLASS_AND_TAB = {
        WARRIOR = { [1] = 161, [2] = 164, [3] = 163 },
        PALADIN = { [1] = 382, [2] = 383, [3] = 381 },
        HUNTER = { [1] = 361, [2] = 363, [3] = 362 },
        ROGUE = { [1] = 182, [2] = 181, [3] = 183 },
        PRIEST = { [1] = 201, [2] = 202, [3] = 203 },
        SHAMAN = { [1] = 261, [2] = 263, [3] = 262 },
        MAGE = { [1] = 81, [2] = 41, [3] = 61 },
        WARLOCK = { [1] = 302, [2] = 303, [3] = 301 },
        DRUID = { [1] = 283, [2] = 281, [3] = 282 },
      }

      local specID = SPEC_ID_BY_CLASS_AND_TAB[class] and SPEC_ID_BY_CLASS_AND_TAB[class][bestTab]

      if not specID then
        return
      end

      if assigned[charKey][specID] then
        return
      end

      for key, profile in pairs(profiles) do
        if
          profile
          and profile.class == class
          and profile.specID == specID
          and key
          and key:match("%-PreRaidBIS$")
          and not key:match("FeralTank")
        then
          assigned[charKey][specID] = key
          if WeakAuras and WeakAuras.ScanEvents then
            WeakAuras.ScanEvents("MERFIN_WOWSIM_CHANGED")
          end
          return
        end
      end
    end
    local f = CreateFrame("Frame")
    f:RegisterEvent("PLAYER_ENTERING_WORLD")
    f:SetScript("OnEvent", function()
      C_Timer.After(1, function()
        f:UnregisterEvent("PLAYER_ENTERING_WORLD")
        AutoAssignWoWSimsProfileIfMissing()
      end)
    end)
  end
end

-- Helper to access the active profile table safely
function MerfinPlus:GetDB()
  return (self.db and self.db.profile) or MerfinPlus.defaults.profile
end

local function GetEffectiveSpecID()
  if IsWrath() or IsTBC() then
    return select(2, Merfin.GetPlayerRole())
  end

  if IsMoP() then
    local classID = select(3, UnitClass("player"))
    return GetSpecializationInfoForClassID(classID, C_SpecializationInfo.GetSpecialization())
  end
end

local function GetCharKey()
  local name = UnitName("player") or "Unknown"
  local realm = GetNormalizedRealmName() or GetRealmName() or "UnknownRealm"
  return name .. "-" .. realm
end

function Merfin.GetActiveSimProfile()
  local db = MerfinPlus.db
  if not (db and db.global and db.global.wowSims) then
    return nil
  end

  local charKey = GetCharKey()
  local assigned = db.global.wowSims.assigned[charKey]
  if not assigned then
    return nil
  end

  local specID = GetEffectiveSpecID()
  if not specID then
    return nil
  end

  local profileKey = assigned[specID]
  if not profileKey then
    return nil
  end

  return db.global.wowSims.profiles[profileKey]
end

function Merfin.GetActiveItemSuffix()
  local profile = Merfin.GetActiveSimProfile()
  if not profile or not profile.itemSuffixes then
    return nil
  end

  return profile.itemSuffixes
end

-- Build and register all options (Blizzard panels + standalone window + slash commands)
function MerfinPlus:SetupOptions()
  local version = GetAddOnMetadata("MerfinPlus", "Version") or "?"
  local wowSimOptions

  -- ==== Media lists (LSM) ====
  local function GetFontList()
    local fonts = {}
    local excluded = {
      ["Merfin Font 1"] = true,
      ["Merfin Font 2"] = true,
      ["Merfin Raid Font"] = true,
      ["Merfin Raid Font (Bold)"] = true,
    }
    for name in pairs(LSM:HashTable("font")) do
      if not excluded[name] then
        fonts[name] = name
      end
    end
    return fonts
  end

  local function GetStatusBarList()
    local bars = {}
    local excluded = {
      ["Merfin Status Bar 1"] = true,
      ["Merfin Status Bar 2"] = true,
      ["Merfin Raid Status Bar"] = true,
    }
    for name in pairs(LSM:HashTable("statusbar")) do
      if not excluded[name] then
        bars[name] = name
      end
    end
    return bars
  end

  -- ==== UI reload popup ====
  local function ConfirmReload()
    StaticPopupDialogs["MERFINPLUS_RELOAD_UI"] = {
      text = L["A reload of the interface is required for this change to take effect.\n\nReload now?"],
      button1 = YES,
      button2 = NO,
      OnAccept = function()
        ReloadUI()
      end,
      timeout = 0,
      whileDead = true,
      hideOnEscape = true,
      preferredIndex = 3,
    }
    StaticPopup_Show("MERFINPLUS_RELOAD_UI")
  end

  -- ==== Root (Blizzard top-level) ====
  local mainOptions = {
    type = "group",
    name = "MerfinPlus v" .. version,
    args = {
      version = {
        type = "description",
        name = "|cff00ccff" .. L["Version:"] .. "|r" .. version,
        fontSize = "medium",
        order = 1,
      },
      author = {
        type = "description",
        name = L["Author: "] .. "Merfin",
        fontSize = "medium",
        order = 2,
      },
      spacer = { type = "description", name = " ", order = 3 },
      description = {
        type = "description",
        name = L["MerfinPlus provides custom fonts, textures, and utilities that enhance or support WeakAuras and other Merfin UI components."],
        fontSize = "large",
        order = 4,
      },
      spacer2 = { type = "description", name = " ", order = 5 },
    },
  }

  -- ==== Media ====
  local mediaOptions = {
    type = "group",
    name = L["Media"],
    args = {
      description = {
        type = "description",
        name = L["Change primary fonts and status bar textures used by Merfin features. A UI reload is required."],
        fontSize = "medium",
        order = 0,
      },
    },
  }

  local fontNames = { "Merfin Font 1", "Merfin Font 2", "Merfin Raid Font", "Merfin Raid Font (Bold)" }
  local barNames = { "Merfin Status Bar 1", "Merfin Status Bar 2", "Merfin Raid Status Bar" }

  for i = 1, #fontNames do
    mediaOptions.args["font" .. i] = {
      type = "select",
      name = fontNames[i],
      desc = L["Select font for element "] .. i,
      values = GetFontList,
      get = function()
        return self.db.profile["font" .. i]
      end,
      set = function(_, v)
        self.db.profile["font" .. i] = v
        ConfirmReload()
      end,
      dialogControl = "LSM30_Font",
      order = i + 1,
    }
  end
  for i = 1, #barNames do
    mediaOptions.args["bar" .. i] = {
      type = "select",
      name = barNames[i],
      desc = L["Select status bar texture for element "] .. i,
      values = GetStatusBarList,
      get = function()
        return self.db.profile["bar" .. i]
      end,
      set = function(_, v)
        self.db.profile["bar" .. i] = v
        ConfirmReload()
      end,
      dialogControl = "LSM30_Statusbar",
      order = i + 10,
    }
  end

  -- ==== WoW Sim Importer ====
  local WOWSIM_INDEX_TO_SLOT = {
    [1] = 1, -- Head
    [2] = 2, -- Neck
    [3] = 3, -- Shoulder
    [4] = 15, -- Back
    [5] = 5, -- Chest
    [6] = 9, -- Wrist
    [7] = 10, -- Hands
    [8] = 6, -- Waist
    [9] = 7, -- Legs
    [10] = 8, -- Feet
    [11] = 11, -- Ring 1
    [12] = 12, -- Ring 2
    [13] = 13, -- Trinket 1
    [14] = 14, -- Trinket 2
    [15] = 16, -- Mainhand
    [16] = 17, -- Offhand
    [17] = (IsWrath() or IsTBC() and 18) or nil, -- Relic/Ranged
  }

  local SLOT_NAMES = {
    [1] = _G.INVTYPE_HEAD,
    [2] = _G.INVTYPE_NECK,
    [3] = _G.INVTYPE_SHOULDER,
    [5] = _G.INVTYPE_CHEST,
    [6] = _G.INVTYPE_WAIST,
    [7] = _G.INVTYPE_LEGS,
    [8] = _G.INVTYPE_FEET,
    [9] = _G.INVTYPE_WRIST,
    [10] = _G.INVTYPE_HAND,
    [11] = _G.INVTYPE_FINGER,
    [12] = _G.INVTYPE_FINGER,
    [13] = _G.INVTYPE_TRINKET,
    [14] = _G.INVTYPE_TRINKET,
    [15] = _G.INVTYPE_CLOAK,
    [16] = _G.INVTYPE_WEAPONMAINHAND,
    [17] = _G.INVTYPE_WEAPONOFFHAND,
    [18] = (IsWrath() or IsTBC()) and _G.INVTYPE_RELIC or nil,
  }

  -- -------------------------
  -- Helpers
  -- -------------------------
  local function NormalizeSimClass(simClass)
    if type(simClass) ~= "string" then
      return nil
    end
    --return "PALADIN"
    return strupper(simClass:gsub("^Class", "")) -- "ClassDruid" -> "DRUID"
  end

  local function ExtractSlotItemsFromSim(simData)
    local items = {}
    local suffixes = {}
    local equip = simData and simData.player and simData.player.equipment
    local list = equip and equip.items
    if type(list) ~= "table" then
      return items, suffixes
    end

    for idx, entry in ipairs(list) do
      local slotID = WOWSIM_INDEX_TO_SLOT[idx]
      local itemID = entry and entry.id

      if slotID and type(itemID) == "number" and itemID > 0 then
        items[slotID] = itemID

        if entry.randomSuffix then
          suffixes[slotID] = entry.randomSuffix
        end

        C_Item.RequestLoadItemDataByID(itemID)
      end
    end
    return items, suffixes
  end

  -- SAFE: user can type anything, GetItemInfo might be nil (cache), request load and return nil safely
  local function SafeItemInfo(itemID)
    if type(itemID) ~= "number" or itemID <= 0 then
      return nil
    end
    local name, link, _, _, _, _, _, _, _, icon = GetItemInfo(itemID)
    if not name then
      C_Item.RequestLoadItemDataByID(itemID)
      return nil
    end
    return name, icon
  end

  local function FindNextFreeProfileIndex(db, spec, class)
    local used = {}
    for k in pairs(db.global.wowSims.profiles) do
      local n = k:match("^" .. spec .. class .. "(%d+)$")
      if n then
        used[tonumber(n)] = true
      end
    end

    local i = 1
    while used[i] do
      i = i + 1
    end
    return i
  end

  local function MakeProfileKey(spec, class)
    local n = FindNextFreeProfileIndex(MerfinPlus.db, spec, class)
    return spec .. class .. n -- FeralDRUID1
  end

  local function PlayerClassMatches(profile)
    local _, playerClass = UnitClass("player") -- playerClass is uppercase token like "DRUID"
    return profile and profile.class == playerClass
  end

  -- -------------------------
  -- Spec lists
  -- -------------------------
  local specsByClassID = {
    [0] = { 74, 81, 79 },
    [1] = { 71, 72, 73, 1446 },
    [2] = { 65, 66, 70, 1451 },
    [3] = { 253, 254, 255, 1448 },
    [4] = { 259, 260, 261, 1453 },
    [5] = { 256, 257, 258, 1452 },
    [6] = { 250, 251, 252, 1455 },
    [7] = { 262, 263, 264, 1444 },
    [8] = { 62, 63, 64, 1449 },
    [9] = { 265, 266, 267, 1454 },
    [10] = { 268, 270, 269, 1450 },
    [11] = { 102, 103, 104, 105, 1447 },
  }

  local classFileByID = {
    [0] = "PET",
    [1] = "WARRIOR",
    [2] = "PALADIN",
    [3] = "HUNTER",
    [4] = "ROGUE",
    [5] = "PRIEST",
    [6] = "DEATHKNIGHT",
    [7] = "SHAMAN",
    [8] = "MAGE",
    [9] = "WARLOCK",
    [10] = "MONK",
    [11] = "DRUID",
  }

  local function GetClassPrefixFromFile(classFile)
    if classFile == "DEATHKNIGHT" then
      return "DeathKnight"
    end
    if classFile == "DEMONHUNTER" then
      return "DemonHunter"
    end
    if type(classFile) ~= "string" or classFile == "" then
      return "Class"
    end
    local lower = classFile:lower()
    return lower:sub(1, 1):upper() .. lower:sub(2)
  end

  local function BuildClassSpecIDs_MoP()
    local CLASS_SPEC_IDS = {}

    for classID, list in pairs(specsByClassID) do
      local classFile = classFileByID[classID]
      if classFile then
        local wanted = {}
        for i = 1, (#list - 1) do
          wanted[list[i]] = true
        end

        local out = {}
        local prefix = GetClassPrefixFromFile(classFile)

        for specIndex = 1, 10 do
          local specID, specName, _, icon = GetSpecializationInfoForClassID(classID, specIndex)
          if not specID then
            break
          end

          if wanted[specID] then
            local cleanName = (specName and specName:gsub("%s+", "")) or tostring(specID)
            local specKey = prefix .. cleanName
            out[#out + 1] = { specID = specID, specKey = specKey, icon = icon }
          end
        end

        CLASS_SPEC_IDS[classFile] = out
      end
    end

    return CLASS_SPEC_IDS
  end

  local CLASS_SPEC_IDS = IsWrath()
      and {

        DRUID = {
          { specID = 283, specKey = "DruidBalance", icon = 136096 }, -- Balance
          { specID = 281, specKey = "DruidFeralCombat", icon = 132276 }, -- Feral
          { specID = 282, specKey = "DruidRestoration", icon = 136041 }, -- Restoration
        },

        WARRIOR = {
          { specID = 161, specKey = "WarriorArms", icon = 132292 },
          { specID = 164, specKey = "WarriorFury", icon = 132347 },
          { specID = 163, specKey = "WarriorProtection", icon = 134952 },
        },

        PALADIN = {
          { specID = 381, specKey = "PaladinRetribution", icon = 135873 },
          { specID = 382, specKey = "PaladinHoly", icon = 135920 },
          { specID = 383, specKey = "PaladinProtection", icon = 135893 },
        },

        HUNTER = {
          { specID = 361, specKey = "HunterBeastMastery", icon = 132164 },
          { specID = 363, specKey = "HunterMarksmanship", icon = 132222 },
          { specID = 362, specKey = "HunterSurvival", icon = 132215 },
        },

        ROGUE = {
          { specID = 182, specKey = "RogueAssassination", icon = 132292 },
          { specID = 181, specKey = "RogueCombat", icon = 132090 },
          { specID = 183, specKey = "RogueSubtlety", icon = 132320 },
        },

        PRIEST = {
          { specID = 201, specKey = "PriestDiscipline", icon = 135987 },
          { specID = 202, specKey = "PriestHoly", icon = 237542 },
          { specID = 203, specKey = "PriestShadow", icon = 136207 },
        },

        SHAMAN = {
          { specID = 261, specKey = "ShamanElemental", icon = 136048 },
          { specID = 263, specKey = "ShamanEnhancement", icon = 136051 },
          { specID = 262, specKey = "ShamanRestoration", icon = 136052 },
        },

        MAGE = {
          { specID = 81, specKey = "MageArcane", icon = 135932 },
          { specID = 41, specKey = "MageFire", icon = 135810 },
          { specID = 61, specKey = "MageFrost", icon = 135846 },
        },

        WARLOCK = {
          { specID = 302, specKey = "WarlockAffliction", icon = 136145 },
          { specID = 303, specKey = "WarlockDemonology", icon = 136172 },
          { specID = 301, specKey = "WarlockDestruction", icon = 136186 },
        },

        DEATHKNIGHT = {
          { specID = 250, specKey = "DeathKnightBlood", icon = 135770 },
          { specID = 251, specKey = "DeathKnightFrost", icon = 135773 },
          { specID = 252, specKey = "DeathKnightUnholy", icon = 135775 },
        },
      }
    or IsTBC()
      and {
        DRUID = {
          { specID = 283, specKey = "DruidBalance", icon = 136096 }, -- Balance
          { specID = 281, specKey = "DruidFeralCombat", icon = 132276 }, -- Feral
          { specID = 282, specKey = "DruidRestoration", icon = 136041 }, -- Restoration
        },

        WARRIOR = {
          { specID = 161, specKey = "WarriorArms", icon = 132292 },
          { specID = 164, specKey = "WarriorFury", icon = 132347 },
          { specID = 163, specKey = "WarriorProtection", icon = 134952 },
        },

        PALADIN = {
          { specID = 381, specKey = "PaladinRetribution", icon = 135873 },
          { specID = 382, specKey = "PaladinHoly", icon = 135920 },
          { specID = 383, specKey = "PaladinProtection", icon = 135893 },
        },

        HUNTER = {
          { specID = 361, specKey = "HunterBeastMastery", icon = 132164 },
          { specID = 363, specKey = "HunterMarksmanship", icon = 132222 },
          { specID = 362, specKey = "HunterSurvival", icon = 132215 },
        },

        ROGUE = {
          { specID = 182, specKey = "RogueAssassination", icon = 132292 },
          { specID = 181, specKey = "RogueCombat", icon = 132090 },
          { specID = 183, specKey = "RogueSubtlety", icon = 132320 },
        },

        PRIEST = {
          { specID = 201, specKey = "PriestDiscipline", icon = 135987 },
          { specID = 202, specKey = "PriestHoly", icon = 237542 },
          { specID = 203, specKey = "PriestShadow", icon = 136207 },
        },

        SHAMAN = {
          { specID = 261, specKey = "ShamanElemental", icon = 136048 },
          { specID = 263, specKey = "ShamanEnhancement", icon = 136051 },
          { specID = 262, specKey = "ShamanRestoration", icon = 136052 },
        },

        MAGE = {
          { specID = 81, specKey = "MageArcane", icon = 135932 },
          { specID = 41, specKey = "MageFire", icon = 135810 },
          { specID = 61, specKey = "MageFrost", icon = 135846 },
        },

        WARLOCK = {
          { specID = 302, specKey = "WarlockAffliction", icon = 136145 },
          { specID = 303, specKey = "WarlockDemonology", icon = 136172 },
          { specID = 301, specKey = "WarlockDestruction", icon = 136186 },
        },
      }
    or IsMoP() and (function()
      return BuildClassSpecIDs_MoP()
    end)()
    or {}

  -- -------------------------
  -- Manager: dropdown + rename + items + assign
  -- -------------------------

  local selectedProfileKey = nil

  local function GetAllProfilesSorted(db)
    local out = {}
    local t = db.global.wowSims.profiles or {}
    for k, v in pairs(t) do
      if type(v) == "table" then
        v.key = v.key or k
        table.insert(out, v)
      end
    end
    table.sort(out, function(a, b)
      local an = a.displayName or a.key or ""
      local bn = b.displayName or b.key or ""
      return an < bn
    end)
    return out
  end

  local function BuildProfileDropdownValues(db)
    local vals = {}
    for _, p in ipairs(GetAllProfilesSorted(db)) do
      vals[p.key] = p.displayName or p.key
    end
    return vals
  end

  local wowSimImportBuffer = ""
  local wowSimParsedData = nil
  local wowSimImportStatus = nil

  local selectedSpec = nil
  local previewProfileKey = nil

  local importMode = "json" -- "json" | "empty"
  local selectedClass = nil

  local function NotifySimChanged()
    if WeakAuras and WeakAuras.ScanEvents then
      WeakAuras.ScanEvents("MERFIN_WOWSIM_CHANGED")
    end
  end

  local STAT_BY_ID = {
    [336] = _G.ITEM_MOD_CRIT_RATING_SHORT,
    [337] = _G.ITEM_MOD_HIT_RATING_SHORT,
    [338] = _G.ITEM_MOD_EXPERTISE_RATING_SHORT,
    [339] = _G.ITEM_MOD_MASTERY_RATING_SHORT,
    [340] = _G.ITEM_MOD_HASTE_RATING_SHORT,
    [341] = _G.ITEM_MOD_PARRY_RATING_SHORT,
    [342] = _G.ITEM_MOD_DODGE_RATING_SHORT,
    [343] = _G.ITEM_MOD_SPIRIT_SHORT,
  }

  function Merfin:GetSuffixName(suffixID)
    if not suffixID then
      return nil
    end
    return STAT_BY_ID[math.abs(suffixID)]
  end

  local function BuildWowSimManagerArgsV2()
    local args = {}
    local db = MerfinPlus.db

    -- auto select active profile into dropdown
    if not selectedProfileKey then
      local active = Merfin.GetActiveSimProfile()
      if active and active.key then
        selectedProfileKey = active.key
      end
    end

    args.header = { type = "header", name = L["Import WoWSim JSON"], order = 0 }

    args.profileSelect = {
      type = "select",
      name = L["Profiles"],
      order = 1,
      width = "full",
      values = function()
        return BuildProfileDropdownValues(MerfinPlus.db)
      end,
      get = function()
        return selectedProfileKey
      end,
      set = function(_, v)
        selectedProfileKey = v
        AceConfigRegistry:NotifyChange("MerfinPlus_WoWSim")
        AceConfigRegistry:NotifyChange("MerfinPlus_Standalone")
      end,
    }

    args.assignedInfo = {
      type = "description",
      order = 2,
      name = function()
        local charKey = GetCharKey()
        local assigned = db.global.wowSims.assigned[charKey]
        if not assigned then
          return "|cffff8800" .. L["This character has no assigned profiles."] .. "|r"
        end

        local lines = {}
        for specID, key in pairs(assigned) do
          local p = db.global.wowSims.profiles[key]
          local label = p and p.specKey or tostring(specID)
          table.insert(lines, label .. ": " .. (p.displayName or key))
        end

        table.sort(lines)
        return "|cff00ff00" .. L["Assigned profiles:"] .. "|r\n" .. table.concat(lines, "\n")
      end,
    }

    args.assign = {
      type = "execute",
      name = function()
        if not selectedProfileKey then
          return L["Assign to Current Character"]
        end

        local charKey = GetCharKey()
        local assigned = MerfinPlus.db.global.wowSims.assigned[charKey]
        local p = MerfinPlus.db.global.wowSims.profiles[selectedProfileKey]

        if assigned and p and assigned[p.specID] == selectedProfileKey then
          return L["Assigned "] .. "(" .. (p.specKey or p.specID) .. ")"
        end

        return L["Assign to Current Character"]
      end,
      order = 3,
      disabled = function()
        if not selectedProfileKey then
          return true
        end
        local p = db.global.wowSims.profiles[selectedProfileKey]
        if not p then
          return true
        end
        if not PlayerClassMatches(p) then
          return true
        end
        return false
      end,
      func = function()
        local charKey = GetCharKey()
        local p = db.global.wowSims.profiles[selectedProfileKey]
        db.global.wowSims.assigned[charKey] = db.global.wowSims.assigned[charKey] or {}

        db.global.wowSims.assigned[charKey][p.specID] = selectedProfileKey

        NotifySimChanged()

        AceConfigRegistry:NotifyChange("MerfinPlus_WoWSim")
        AceConfigRegistry:NotifyChange("MerfinPlus_Standalone")
      end,
    }

    args.rename = {
      type = "input",
      name = L["Rename (display only)"],
      order = 4,
      width = "full",
      disabled = function()
        return not selectedProfileKey
      end,
      get = function()
        local p = db.global.wowSims.profiles[selectedProfileKey]
        return p and (p.displayName or p.key) or ""
      end,
      set = function(_, v)
        local p = db.global.wowSims.profiles[selectedProfileKey]
        if p and v and v ~= "" then
          p.displayName = v
        end

        NotifySimChanged()

        AceConfigRegistry:NotifyChange("MerfinPlus_WoWSim")
        AceConfigRegistry:NotifyChange("MerfinPlus_Standalone")
      end,
    }

    args.itemsGroup = {
      type = "group",
      name = "Items",
      order = 10,
      inline = true,
      args = {},
      disabled = function()
        return not selectedProfileKey
      end,
    }

    local p = selectedProfileKey and db.global.wowSims.profiles[selectedProfileKey]

    local slotIDs = {}
    for slotID in pairs(SLOT_NAMES) do
      table.insert(slotIDs, slotID)
    end
    table.sort(slotIDs)

    local o = 1
    for _, slotID in ipairs(slotIDs) do
      args.itemsGroup.args["slot_" .. slotID] = {
        type = "input",
        width = "full",
        order = o,
        name = function()
          local label = SLOT_NAMES[slotID]
          local p = selectedProfileKey and db.global.wowSims.profiles[selectedProfileKey]
          local id = p and p.items and p.items[slotID]

          if not id then
            return label .. " - (" .. L["Empty"] .. ")"
          end

          local name, icon = SafeItemInfo(id)
          if name and icon then
            return ("|T%d:18|t %s - %s (ID: %d)"):format(icon, label, name, id)
          end

          return label .. " - (ID: " .. id .. " - " .. L["loading"] .. "...)"
        end,
        desc = L["Set itemID for "] .. (SLOT_NAMES[slotID] or (L["slot "] .. slotID)),
        get = function()
          local pp = db.global.wowSims.profiles[selectedProfileKey]
          local id = pp and pp.items and pp.items[slotID]
          return id and tostring(id) or ""
        end,
        set = function(_, v)
          local pp = db.global.wowSims.profiles[selectedProfileKey]
          if not pp then
            return
          end
          pp.items = pp.items or {}

          local n = tonumber(v)
          if n and n > 0 then
            pp.items[slotID] = n
            C_Item.RequestLoadItemDataByID(n)
          else
            pp.items[slotID] = nil
          end

          if n and n > 0 then
            pp.items[slotID] = n
            pp.itemSuffixes = pp.itemSuffixes or {}
            pp.itemSuffixes[slotID] = nil
          else
            pp.items[slotID] = nil
            if pp.itemSuffixes then
              pp.itemSuffixes[slotID] = nil
            end
          end

          NotifySimChanged()

          AceConfigRegistry:NotifyChange("MerfinPlus_WoWSim")
          AceConfigRegistry:NotifyChange("MerfinPlus_Standalone")
        end,
      }
      args.itemsGroup.args["slot_" .. slotID .. "_suffix"] = {
        type = "select",
        name = L["Suffix"],
        order = o + 0.1,
        width = "half",

        hidden = IsMoP() and function()
          local p = selectedProfileKey and db.global.wowSims.profiles[selectedProfileKey]
          return not p or not p.itemSuffixes or p.itemSuffixes[slotID] == nil
        end or true,

        values = function()
          local vals = {}
          for id, name in pairs(STAT_BY_ID) do
            vals[-id] = name
          end
          return vals
        end,

        get = function()
          local p = db.global.wowSims.profiles[selectedProfileKey]
          return p.itemSuffixes[slotID]
        end,

        set = function(_, v)
          local p = db.global.wowSims.profiles[selectedProfileKey]
          p.itemSuffixes[slotID] = v
          NotifySimChanged()
        end,
      }
      args.itemsGroup.args["slot_" .. slotID .. "_addsuffix"] = {
        type = "execute",
        name = "+ Suffix",
        order = o + 0.05,
        width = 0.8,
        hidden = IsMoP() and function()
          local p = selectedProfileKey and db.global.wowSims.profiles[selectedProfileKey]
          return not p or not p.items or not p.items[slotID] or (p.itemSuffixes and p.itemSuffixes[slotID])
        end or true,
        func = function()
          local p = db.global.wowSims.profiles[selectedProfileKey]
          p.itemSuffixes = p.itemSuffixes or {}

          p.itemSuffixes[slotID] = -336 -- crit

          NotifySimChanged()
          AceConfigRegistry:NotifyChange("MerfinPlus_WoWSim")
        end,
      }
      args.itemsGroup.args["slot_" .. slotID .. "_suffix_remove"] = {
        type = "execute",
        name = "|cffff4040X|r",
        desc = "|cffff4040" .. L["Delete this item entry."] .. "|r",
        order = o + 0.15,
        width = 0.3,
        hidden = IsMoP() and function()
          local p = selectedProfileKey and db.global.wowSims.profiles[selectedProfileKey]
          return not p or not p.itemSuffixes or p.itemSuffixes[slotID] == nil
        end or true,
        func = function()
          local p = db.global.wowSims.profiles[selectedProfileKey]
          p.itemSuffixes[slotID] = nil
          NotifySimChanged()
          AceConfigRegistry:NotifyChange("MerfinPlus_WoWSim")
        end,
      }
      o = o + 1
    end

    args.delete = {
      type = "execute",
      name = L["Delete Profile"],
      order = 999,
      confirm = true,
      confirmText = L["Delete this profile?"],
      disabled = function()
        return not selectedProfileKey
      end,
      func = function()
        db.global.wowSims.profiles[selectedProfileKey] = nil

        -- cleanup assignments
        for ck, specs in pairs(db.global.wowSims.assigned) do
          if type(specs) == "table" then
            for spec, key in pairs(specs) do
              if key == selectedProfileKey then
                specs[spec] = nil
              end
            end
            if next(specs) == nil then
              db.global.wowSims.assigned[ck] = nil
            end
          end
        end

        selectedProfileKey = nil

        NotifySimChanged()

        AceConfigRegistry:NotifyChange("MerfinPlus_WoWSim")
        AceConfigRegistry:NotifyChange("MerfinPlus_Standalone")
      end,
    }

    return args
  end

  local CLASS_ICONS = {
    WARRIOR = 626008,
    PALADIN = 626003,
    HUNTER = 626000,
    ROGUE = 626005,
    PRIEST = 626004,
    DEATHKNIGHT = 135771,
    SHAMAN = 626006,
    MAGE = 626001,
    WARLOCK = 626007,
    MONK = 626002,
    DRUID = 625999,
  }

  local function BuildSpecSelectArgs()
    local args = {}

    local class = importMode == "json"
        and wowSimParsedData
        and wowSimParsedData.player
        and NormalizeSimClass(wowSimParsedData.player.class)
      or selectedClass

    local specs = class and CLASS_SPEC_IDS[class]
    if not specs then
      return args
    end

    for _, s in ipairs(specs) do
      args["spec_" .. s.specKey] = {
        type = "execute",
        name = "",
        image = s.icon,
        imageWidth = 32,
        imageHeight = 32,
        func = function()
          selectedSpec = s
          previewProfileKey = MakeProfileKey(s.specKey, class)
          AceConfigRegistry:NotifyChange("MerfinPlus_WoWSim")
        end,
      }
    end
    return args
  end
  -- -------------------------
  -- Import state + UI
  -- -------------------------
  -- WoW Sim
  wowSimOptions = {
    type = "group",
    name = "WoW Sim",
    childGroups = "tab",
    hidden = function()
      return not IsWrath() and not IsTBC() and not IsMoP()
    end,
    args = {

      -- =====================
      -- TAB 1: IMPORT
      -- =====================
      Import = {
        type = "group",
        name = L["Import"],
        order = 1,
        args = {

          header = {
            type = "header",
            name = L["Import WoWSim JSON"],
            order = 1,
          },

          description = {
            type = "description",
            order = 2,
            width = 1.5,
            name = function()
              if importMode == "empty" then
                return L["Create an empty WoWSim profile.\nSelect a class, choose a specialization, then click Import."]
              end
              return L["Paste a WoWSim JSON export below.\nClick Accept, select a specialization icon, then click Import."]
            end,
          },

          emptyProfileBtn = {
            type = "execute",
            name = L["Empty Profile"],
            order = 3,
            width = 0.5,
            func = function()
              importMode = "empty"
              wowSimImportBuffer = ""
              wowSimParsedData = nil
              selectedSpec = nil
              previewProfileKey = nil
              selectedClass = nil

              wowSimOptions.args.Import.args.specSelect.args = {}
              AceConfigRegistry:NotifyChange("MerfinPlus_WoWSim")
            end,
          },

          jsonInput = {
            type = "input",
            name = "JSON",
            multiline = 18,
            width = "full",
            order = 10,
            get = function()
              return wowSimImportBuffer
            end,
            set = function(_, v)
              importMode = "json"
              wowSimImportBuffer = v

              wowSimParsedData = nil
              selectedSpec = nil
              previewProfileKey = nil

              if not v or v == "" then
                wowSimImportStatus = "empty"
                wowSimOptions.args.Import.args.specSelect.args = {}
                AceConfigRegistry:NotifyChange("MerfinPlus_WoWSim")
                return
              end

              if not C_EncodingUtil then
                wowSimImportStatus = "EncodingUtil"
                return
              end
              local ok, data = pcall(C_EncodingUtil.DeserializeJSON, v)
              if not ok or type(data) ~= "table" then
                wowSimImportStatus = "error"
                AceConfigRegistry:NotifyChange("MerfinPlus_WoWSim")
                return
              end

              local class = data and data.player and NormalizeSimClass(data.player.class)
              if not class or not CLASS_SPEC_IDS[class] then
                wowSimImportStatus = "unknown_class"
                wowSimParsedData = data -- keep for display
                AceConfigRegistry:NotifyChange("MerfinPlus_WoWSim")
                return
              end

              wowSimParsedData = data
              wowSimImportStatus = "ready"

              wowSimOptions.args.Import.args.specSelect.args = BuildSpecSelectArgs()

              AceConfigRegistry:NotifyChange("MerfinPlus_WoWSim")
              AceConfigRegistry:NotifyChange("MerfinPlus_Standalone")
            end,
          },

          classSelect = {
            type = "group",
            name = L["Class"],
            order = 12,
            inline = true,
            hidden = function()
              return importMode ~= "empty"
            end,
            args = (function()
              local args = {}

              for classFile, specs in pairs(CLASS_SPEC_IDS) do
                local icon = CLASS_ICONS[classFile]
                if icon then
                  args["class_" .. classFile] = {
                    type = "execute",
                    name = "",
                    image = icon,
                    imageWidth = 32,
                    imageHeight = 32,
                    func = function()
                      selectedClass = classFile
                      selectedSpec = nil
                      previewProfileKey = nil

                      wowSimOptions.args.Import.args.specSelect.args = BuildSpecSelectArgs()
                      AceConfigRegistry:NotifyChange("MerfinPlus_WoWSim")
                    end,
                  }
                end
              end

              return args
            end)(),
          },

          specSelect = {
            type = "group",
            name = L["Specialization"],
            order = 15,
            inline = true,
            hidden = function()
              if importMode == "empty" then
                return not selectedClass
              end
              return not wowSimParsedData or wowSimImportStatus ~= "ready"
            end,
            args = {},
          },

          profileName = {
            type = "description",
            order = 16,
            name = function()
              if previewProfileKey then
                return "|cff00ff00" .. L["Profile: "] .. "|r " .. previewProfileKey
              end
              if wowSimImportStatus == "ready" then
                return "|cffff8800" .. L["Select a specialization."] .. "|r"
              end
              return " "
            end,
          },

          importBtn = {
            type = "execute",
            name = L["Import"],
            order = 20,
            disabled = function()
              if importMode == "empty" then
                return not (selectedClass and selectedSpec)
              end
              return not (wowSimParsedData and selectedSpec and previewProfileKey and wowSimImportStatus == "ready")
            end,
            func = function()
              if importMode == "empty" then
                local class = selectedClass
                local finalKey = MakeProfileKey(selectedSpec.specKey, class)

                MerfinPlus.db.global.wowSims.profiles[finalKey] = {
                  key = finalKey,
                  class = class,
                  specID = selectedSpec.specID,
                  specKey = selectedSpec.specKey,
                  icon = selectedSpec.icon,
                  items = {},
                  importedAt = time(),
                }

                selectedProfileKey = finalKey
                importMode = "json"

                NotifySimChanged()

                AceConfigRegistry:NotifyChange("MerfinPlus_WoWSim")
                AceConfigRegistry:NotifyChange("MerfinPlus_Standalone")
                return
              end

              local data = wowSimParsedData
              if not data then
                return
              end

              local class = NormalizeSimClass(data.player.class)
              if not class then
                return
              end

              local finalKey = MakeProfileKey(selectedSpec.specKey, class)

              local items, suffixes = ExtractSlotItemsFromSim(data)
              MerfinPlus.db.global.wowSims.profiles[finalKey] = {
                key = finalKey,
                class = class,
                specID = selectedSpec.specID,
                specKey = selectedSpec.specKey,
                icon = selectedSpec.icon,
                items = items,
                itemSuffixes = suffixes,
                importedAt = time(),
              }

              -- AUTO-ASSIGN if same class
              local _, playerClass = UnitClass("player")
              if playerClass == class then
                local charKey = GetCharKey()
                MerfinPlus.db.global.wowSims.assigned[charKey] = MerfinPlus.db.global.wowSims.assigned[charKey] or {}

                MerfinPlus.db.global.wowSims.assigned[charKey][selectedSpec.specID] = finalKey
              end

              wowSimImportBuffer = ""
              wowSimParsedData = nil
              selectedSpec = nil
              previewProfileKey = nil
              wowSimImportStatus = "ok"

              wowSimOptions.args.Manager.args = BuildWowSimManagerArgsV2()

              NotifySimChanged()

              AceConfigRegistry:NotifyChange("MerfinPlus_WoWSim")
              AceConfigRegistry:NotifyChange("MerfinPlus_Standalone")
            end,
          },

          importStatus = {
            type = "description",
            order = 21,
            name = function()
              if wowSimImportStatus == "ok" then
                return "|cff00ff00" .. L["Import successful."] .. "|r"
              elseif wowSimImportStatus == "ready" then
                return "|cff00ff00 " .. L["Ready."] .. "|r"
              elseif wowSimImportStatus == "unknown_class" then
                return "|cffff0000 " .. L["Unknown / unsupported class in JSON."] .. "|r"
              elseif wowSimImportStatus == "error" then
                return "|cffff0000" .. L["Invalid JSON."] .. "|r"
              elseif wowSimImportStatus == "empty" then
                return "|cffff8800" .. L["No JSON provided."] .. "|r"
              elseif wowSimImportStatus == "EncodingUtil" then
                return "|cffff8800 " .. L["C_EncodingUtil not available in this WoW version."] .. "|r"
              end
              return " "
            end,
          },
        },
      },

      -- =====================
      -- TAB 2: IMPORT MANAGER
      -- =====================
      Manager = {
        type = "group",
        name = L["Import Manager"],
        order = 2,
        args = BuildWowSimManagerArgsV2(),
      },
    },
  }

  -- ==== Profiles (AceDB) ====
  local profilesOptions = AceDBOptions:GetOptionsTable(self.db)
  profilesOptions.name = L["Profiles"] or "Profiles" -- ensure the node has a name

  -- ==== Register Blizzard panels (left AddOns pane) ====
  AceConfigRegistry:RegisterOptionsTable("MerfinPlus", mainOptions)
  self.optionsFrame = AceConfigDialog:AddToBlizOptions("MerfinPlus", "MerfinPlus v" .. version)

  AceConfigRegistry:RegisterOptionsTable("MerfinPlus_Media", mediaOptions)
  AceConfigDialog:AddToBlizOptions("MerfinPlus_Media", "Media", "MerfinPlus v" .. version)

  if IsWrath() or IsTBC() or IsMoP() then
    AceConfigRegistry:RegisterOptionsTable("MerfinPlus_WoWSim", wowSimOptions)
    AceConfigDialog:AddToBlizOptions("MerfinPlus_WoWSim", "WoW Sim", "MerfinPlus v" .. version)
  end

  AceConfigRegistry:RegisterOptionsTable("MerfinPlus_Profiles", profilesOptions)
  AceConfigDialog:AddToBlizOptions("MerfinPlus_Profiles", "Profiles", "MerfinPlus v" .. version)

  -- ==== Standalone window (own AceConfigDialog frame) ====
  -- IMPORTANT: include whole profilesOptions object, not just .args, to keep its handler intact.
  local standaloneOptions = {
    type = "group",
    name = "MerfinPlus v" .. version,
    childGroups = "tree",
    args = {
      media = (function()
        mediaOptions.order = 10
        mediaOptions.childGroups = nil
        return mediaOptions
      end)(),
      profiles = (function()
        profilesOptions.order = 100
        return profilesOptions
      end)(),
    },
  }
  if IsWrath() or IsTBC() or IsMoP() then
    standaloneOptions.args.wowSim = (function()
      wowSimOptions.order = 30
      return wowSimOptions
    end)()
  end

  AceConfigRegistry:RegisterOptionsTable("MerfinPlus_Standalone", standaloneOptions)
  AceConfigDialog:SetDefaultSize("MerfinPlus_Standalone", 700, 500)

  -- Toggle standalone and optionally preselect section/subtab
  function MerfinPlus:ToggleStandalone(which, sub)
    local ACD = AceConfigDialog
    if ACD.OpenFrames and ACD.OpenFrames["MerfinPlus_Standalone"] then
      ACD:Close("MerfinPlus_Standalone")
    else
      ACD:Open("MerfinPlus_Standalone")
    end
    if which == "media" or which == "raid" or which == "profiles" then
      if which == "raid" and sub then
        ACD:SelectGroup("MerfinPlus_Standalone", "raid", sub)
      else
        ACD:SelectGroup("MerfinPlus_Standalone", which)
      end
    end

    if which == "media" or which == "profiles" then
      ACD:SelectGroup("MerfinPlus_Standalone", which)
    end
  end

  -- ==== Slash commands ====
  local function _norm(msg)
    return strlower(strtrim(msg or ""))
  end

  -- /merfinplus [media|profiles]
  AceConsole:RegisterChatCommand("merfinplus", function(msg)
    msg = _norm(msg)
    local which, sub = strmatch(msg, "^(%S+)%s+(%S+)$")
    which = which or msg
    if which == "media" or which == "profiles" then
      MerfinPlus:ToggleStandalone(which)
    else
      MerfinPlus:ToggleStandalone(nil)
    end
  end)

  AceConsole:RegisterChatCommand("mp", function(msg)
    msg = _norm(msg)
    local which, sub = strmatch(msg, "^(%S+)%s+(%S+)$")
    which = which or msg
    if which == "media" or which == "profiles" then
      MerfinPlus:ToggleStandalone(which)
    else
      MerfinPlus:ToggleStandalone(nil)
    end
  end)
end

-- ==== Media registration ====
function MerfinPlus:RegisterCustomFonts()
  local db = self:GetDB()
  local fonts = {
    { key = "font1", name = "Merfin Font 1" },
    { key = "font2", name = "Merfin Font 2" },
    { key = "font3", name = "Merfin Raid Font" },
    { key = "font4", name = "Merfin Raid Font (Bold)" },
  }
  for _, f in ipairs(fonts) do
    local path = LSM:Fetch("font", db[f.key], true)
    if path then
      LSM:Register(
        "font",
        f.name,
        path,
        LSM.LOCALE_BIT_western + LSM.LOCALE_BIT_ruRU + LSM.LOCALE_BIT_koKR + LSM.LOCALE_BIT_zhCN + LSM.LOCALE_BIT_zhTW
      )
    else
      -- print(string.format("|cffff0000[MerfinPlus]|r Failed to register %s - invalid font path", f.name))
    end
  end
end

function MerfinPlus:RegisterCustomBars()
  local db = self:GetDB()
  local bars = {
    { key = "bar1", name = "Merfin Status Bar 1" },
    { key = "bar2", name = "Merfin Status Bar 2" },
    { key = "bar3", name = "Merfin Raid Status Bar" },
  }
  for _, b in ipairs(bars) do
    local path = LSM:Fetch("statusbar", db[b.key], true)
    if path then
      LSM:Register("statusbar", b.name, path)
    else
      -- print(string.format("|cffff0000[MerfinPlus]|r Failed to register %s - invalid status bar path", b.name))
    end
  end
end

-- Mirror current selection under alias names for other addons/WA to consume
function MerfinPlus:RegisterMediaAliasesFromCallback()
  local db = self:GetDB()

  local fontMap = {
    { key = db.font1, alias = "Merfin Font 1" },
    { key = db.font2, alias = "Merfin Font 2" },
    { key = db.font3, alias = "Merfin Raid Font" },
    { key = db.font4, alias = "Merfin Raid Font (Bold)" },
  }
  local barMap = {
    { key = db.bar1, alias = "Merfin Status Bar 1" },
    { key = db.bar2, alias = "Merfin Status Bar 2" },
    { key = db.bar3, alias = "Merfin Raid Status Bar" },
  }

  LSM.RegisterCallback(self, "LibSharedMedia_Registered", function(_, mediatype, key)
    if mediatype == "font" then
      for _, e in ipairs(fontMap) do
        if e.key == key then
          local path = LSM:Fetch("font", e.key)
          if path then
            LSM:Register(
              "font",
              e.alias,
              path,
              LSM.LOCALE_BIT_western
                + LSM.LOCALE_BIT_ruRU
                + LSM.LOCALE_BIT_koKR
                + LSM.LOCALE_BIT_zhCN
                + LSM.LOCALE_BIT_zhTW
            )
          end
        end
      end
    elseif mediatype == "statusbar" or mediatype == "statusbar_atlas" then
      for _, e in ipairs(barMap) do
        if e.key == key then
          local path = LSM:Fetch("statusbar", e.key)
          if path then
            LSM:Register("statusbar", e.alias, path)
          end
        end
      end
    end
  end)
end
