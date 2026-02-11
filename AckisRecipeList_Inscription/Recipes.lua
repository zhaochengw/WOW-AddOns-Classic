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

-------------------------------------------------------------------------------
-- Filter flags. Acquire types, and Reputation levels.
-------------------------------------------------------------------------------
local A = constants.ACQUIRE_TYPE_IDS
local F = constants.FILTER_IDS
local Q = constants.ITEM_QUALITIES
local V = constants.GAME_VERSIONS
local Z = constants.ZONE_NAMES

local FAC = constants.FACTION_IDS
local REP = constants.REP_LEVELS
local PROF = constants.PROFESSION_SPELL_IDS

module.Recipes = {}

--------------------------------------------------------------------------------------------------------------------
-- Initialize!
--------------------------------------------------------------------------------------------------------------------
function module:InitializeRecipes()
    local function AddRecipe(spellID, expansionID, quality)
        return addon:AddRecipe(module, {
            _acquireTypeData = {},
            _bitflags = {},
            _expansionID = expansionID,
            _localizedName = _G.GetSpellInfo(spellID),
            _qualityID = quality,
            _spellID = spellID,
        })
    end

    local recipe

    -------------------------------------------------------------------------------
    -- Wrath of the Lich King.
    -------------------------------------------------------------------------------
    -- Scroll of Stamina -- 45382
    recipe = AddRecipe(45382, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 35, 40, 45)
    recipe:SetCraftedItem(1180, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_SCROLL")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MISC1)
    recipe:AddCustom("DEFAULT_RECIPE")

    -- Scroll of Intellect -- 48114
    recipe = AddRecipe(48114, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 35, 40, 45)
    recipe:SetCraftedItem(955, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_SCROLL")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MISC1)
    recipe:AddCustom("DEFAULT_RECIPE")

    -- Scroll of Spirit -- 48116
    recipe = AddRecipe(48116, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 35, 40, 45)
    recipe:SetCraftedItem(1181, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_SCROLL")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MISC1, F.HEALER, F.CASTER)
    recipe:AddCustom("DEFAULT_RECIPE")

    -- Glyph of Entangling Roots -- 48121
    recipe = AddRecipe(48121, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(100, 100, 105, 110, 115)
    recipe:SetCraftedItem(40924, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DRUID)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Mysterious Tarot -- 48247
    recipe = AddRecipe(48247, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(85, 85, 95, 100, 105)
    recipe:SetCraftedItem(37168, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_CREATED_ITEM")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Scroll of Recall -- 48248
    recipe = AddRecipe(48248, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(35, 35, 60, 67, 75)
    recipe:SetCraftedItem(37118, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_SCROLL")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 47384, 47396, 47400, 47418, 47419, 47420, 47431, 48619, 53415, 56065,
        57620, 62327, 64691, 65043, 66355)

    -- Scroll of Intellect II -- 50598
    recipe = AddRecipe(50598, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(75, 75, 75, 80, 85)
    recipe:SetCraftedItem(2290, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_SCROLL")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 47384, 47396, 47400, 47418, 47419, 47420, 47431, 48619, 53415, 56065,
        57620, 62327, 64691, 65043, 66355)

    -- Scroll of Intellect III -- 50599
    recipe = AddRecipe(50599, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(165, 165, 170, 175, 180)
    recipe:SetCraftedItem(4419, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_SCROLL")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Scroll of Intellect IV -- 50600
    recipe = AddRecipe(50600, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(215, 215, 220, 225, 230)
    recipe:SetCraftedItem(10308, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_SCROLL")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Scroll of Intellect V -- 50601
    recipe = AddRecipe(50601, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(260, 260, 265, 270, 275)
    recipe:SetCraftedItem(27499, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_SCROLL")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Scroll of Intellect VI -- 50602
    recipe = AddRecipe(50602, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(300, 300, 310, 315, 320)
    recipe:SetCraftedItem(33458, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_SCROLL")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Scroll of Intellect VII -- 50603
    recipe = AddRecipe(50603, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(360, 360, 365, 370, 375)
    recipe:SetCraftedItem(37091, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_SCROLL")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30713, 30715, 30716, 30717, 30721, 33603, 33615,
        33638, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Scroll of Intellect VIII -- 50604
    recipe = AddRecipe(50604, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(410, 410, 415, 420, 425)
    recipe:SetCraftedItem(37092, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_SCROLL")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30713, 30715, 30716, 30717, 30721, 33603, 33615,
        33638, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Scroll of Spirit II -- 50605
    recipe = AddRecipe(50605, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(75, 75, 75, 80, 85)
    recipe:SetCraftedItem(1712, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_SCROLL")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 47384, 47396, 47400, 47418, 47419, 47420, 47431, 48619, 53415, 56065,
        57620, 62327, 64691, 65043, 66355)

    -- Scroll of Spirit III -- 50606
    recipe = AddRecipe(50606, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(160, 160, 165, 170, 175)
    recipe:SetCraftedItem(4424, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_SCROLL")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Scroll of Spirit IV -- 50607
    recipe = AddRecipe(50607, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(210, 210, 215, 220, 225)
    recipe:SetCraftedItem(10306, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_SCROLL")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Scroll of Spirit V -- 50608
    recipe = AddRecipe(50608, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(255, 255, 260, 265, 270)
    recipe:SetCraftedItem(27501, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_SCROLL")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Scroll of Spirit VI -- 50609
    recipe = AddRecipe(50609, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(295, 295, 305, 310, 315)
    recipe:SetCraftedItem(33460, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_SCROLL")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Scroll of Spirit VII -- 50610
    recipe = AddRecipe(50610, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(355, 355, 360, 365, 370)
    recipe:SetCraftedItem(37097, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_SCROLL")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30713, 30715, 30716, 30717, 30721, 33603, 33615,
        33638, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Scroll of Spirit VIII -- 50611
    recipe = AddRecipe(50611, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(405, 405, 410, 415, 420)
    recipe:SetCraftedItem(37098, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_SCROLL")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30713, 30715, 30716, 30717, 30721, 33603, 33615,
        33638, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Scroll of Stamina II -- 50612
    recipe = AddRecipe(50612, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(75, 75, 75, 80, 85)
    recipe:SetCraftedItem(1711, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_SCROLL")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 47384, 47396, 47400, 47418, 47419, 47420, 47431, 48619, 53415, 56065,
        57620, 62327, 64691, 65043, 66355)

    -- Scroll of Stamina III -- 50614
    recipe = AddRecipe(50614, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(155, 155, 160, 165, 170)
    recipe:SetCraftedItem(4422, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_SCROLL")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Scroll of Stamina IV -- 50616
    recipe = AddRecipe(50616, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(205, 205, 210, 215, 220)
    recipe:SetCraftedItem(10307, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_SCROLL")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Scroll of Stamina V -- 50617
    recipe = AddRecipe(50617, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(250, 250, 255, 260, 265)
    recipe:SetCraftedItem(27502, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_SCROLL")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Scroll of Stamina VI -- 50618
    recipe = AddRecipe(50618, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(290, 290, 300, 305, 310)
    recipe:SetCraftedItem(33461, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_SCROLL")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Scroll of Stamina VII -- 50619
    recipe = AddRecipe(50619, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(350, 350, 355, 360, 365)
    recipe:SetCraftedItem(37093, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_SCROLL")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30713, 30715, 30716, 30717, 30721, 33603, 33615,
        33638, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Scroll of Stamina VIII -- 50620
    recipe = AddRecipe(50620, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(400, 400, 405, 410, 415)
    recipe:SetCraftedItem(37094, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_SCROLL")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30713, 30715, 30716, 30717, 30721, 33603, 33615,
        33638, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Ivory Ink -- 52738
    recipe = AddRecipe(52738, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 15, 22, 30)
    recipe:SetCraftedItem(37101, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MATERIALS")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MISC1)
    recipe:AddCustom("DEFAULT_RECIPE")

    -- Enchanting Vellum -- 52739
    recipe = AddRecipe(52739, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(35, 35, 75, 87, 100)
    recipe:SetCraftedItem(38682, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MATERIALS")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 47384, 47396, 47400, 47418, 47419, 47420, 47431, 48619, 53415, 56065,
        57620, 62327, 64691, 65043, 66355)

    -- Moonglow Ink -- 52843
    recipe = AddRecipe(52843, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(35, 35, 45, 60, 75)
    recipe:SetCraftedItem(39469, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MATERIALS")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 47384, 47396, 47400, 47418, 47419, 47420, 47431, 48619, 53415, 56065,
        57620, 62327, 64691, 65043, 66355)

    -- Midnight Ink -- 53462
    recipe = AddRecipe(53462, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(75, 75, 75, 77, 80)
    recipe:SetCraftedItem(39774, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MATERIALS")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 47384, 47396, 47400, 47418, 47419, 47420, 47431, 48619, 53415, 56065,
        57620, 62327, 64691, 65043, 66355)

    -- Glyph of Frenzied Regeneration -- 56943
    recipe = AddRecipe(56943, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(350, 350, 355, 360, 365)
    recipe:SetCraftedItem(40896, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DRUID)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30713, 30715, 30716, 30717, 30721, 30722, 33603,
        33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Omens -- 56944
    recipe = AddRecipe(56944, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(385, 385, 390, 397, 405)
    recipe:SetCraftedItem(40899, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DRUID)
    recipe:AddDiscovery("DISCOVERY_INSC_NORTHREND", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Healing Touch -- 56945
    recipe = AddRecipe(56945, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(115, 115, 120, 125, 130)
    recipe:SetCraftedItem(40914, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.DRUID)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Hurricane -- 56946
    recipe = AddRecipe(56946, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(385, 385, 390, 397, 405)
    recipe:SetCraftedItem(40920, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DRUID)
    recipe:AddDiscovery("DISCOVERY_INSC_NORTHREND", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Innervate -- 56947
    recipe = AddRecipe(56947, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(385, 385, 390, 397, 405)
    recipe:SetCraftedItem(40908, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DRUID)
    recipe:AddDiscovery("DISCOVERY_INSC_NORTHREND", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of the Orca -- 56948
    recipe = AddRecipe(56948, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(150, 150, 155, 160, 165)
    recipe:SetCraftedItem(40919, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.CASTER, F.DRUID)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Efflorescence -- 56949
    recipe = AddRecipe(56949, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(385, 385, 390, 397, 405)
    recipe:SetCraftedItem(40915, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.DRUID)
    recipe:AddDiscovery("DISCOVERY_INSC_NORTHREND", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of the Stag -- 56950
    recipe = AddRecipe(56950, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(385, 385, 390, 397, 405)
    recipe:SetCraftedItem(40900, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DRUID)
    recipe:AddDiscovery("DISCOVERY_INSC_NORTHREND", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Savagery -- 56951
    recipe = AddRecipe(56951, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(130, 130, 135, 140, 145)
    recipe:SetCraftedItem(40923, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.CASTER, F.DRUID)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Pounce -- 56952
    recipe = AddRecipe(56952, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(310, 310, 315, 320, 325)
    recipe:SetCraftedItem(40903, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DRUID)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30713, 30715, 30716, 30717, 30721, 30722, 33603,
        33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Rebirth -- 56953
    recipe = AddRecipe(56953, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(170, 170, 175, 180, 185)
    recipe:SetCraftedItem(40909, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DRUID)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Regrowth -- 56954
    recipe = AddRecipe(56954, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(385, 385, 390, 397, 405)
    recipe:SetCraftedItem(40912, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.DRUID)
    recipe:AddDiscovery("DISCOVERY_INSC_NORTHREND", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Rejuvenation -- 56955
    recipe = AddRecipe(56955, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(80, 80, 90, 100, 110)
    recipe:SetCraftedItem(40913, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.DRUID)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Prowl -- 56956
    recipe = AddRecipe(56956, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(200, 200, 205, 210, 215)
    recipe:SetCraftedItem(40902, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DRUID)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Shred -- 56957
    recipe = AddRecipe(56957, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(260, 260, 265, 270, 275)
    recipe:SetCraftedItem(40901, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DRUID)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Skull Bash -- 56958
    recipe = AddRecipe(56958, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(385, 385, 390, 397, 405)
    recipe:SetCraftedItem(40921, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.CASTER, F.DRUID)
    recipe:AddDiscovery("DISCOVERY_INSC_NORTHREND", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Guided Stars -- 56959
    recipe = AddRecipe(56959, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(220, 220, 225, 230, 235)
    recipe:SetCraftedItem(40916, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.CASTER, F.DRUID)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Stampede -- 56960
    recipe = AddRecipe(56960, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(385, 385, 390, 397, 405)
    recipe:SetCraftedItem(40906, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.DRUID)
    recipe:AddDiscovery("DISCOVERY_INSC_NORTHREND", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Maul -- 56961
    recipe = AddRecipe(56961, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(90, 90, 100, 110, 120)
    recipe:SetCraftedItem(40897, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DRUID)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Nature's Grasp -- 56963
    recipe = AddRecipe(56963, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(85, 85, 95, 105, 115)
    recipe:SetCraftedItem(40922, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.CASTER, F.DRUID)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Stars -- 56965
    recipe = AddRecipe(56965, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(310, 310, 320, 325, 330)
    recipe:SetCraftedItem(44922, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DRUID)
    recipe:AddDiscovery("DISCOVERY_INSC_MINOR")

    -- Glyph of Loose Mana -- 56971
    recipe = AddRecipe(56971, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(115, 115, 120, 125, 130)
    recipe:SetCraftedItem(42735, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.CASTER, F.MAGE)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Arcane Explosion -- 56972
    recipe = AddRecipe(56972, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(335, 335, 340, 345, 350)
    recipe:SetCraftedItem(42736, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.CASTER, F.MAGE)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30713, 30715, 30716, 30717, 30721, 30722, 33603,
        33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Blink -- 56973
    recipe = AddRecipe(56973, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(130, 130, 135, 140, 145)
    recipe:SetCraftedItem(42737, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.CASTER, F.MAGE)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Evocation -- 56974
    recipe = AddRecipe(56974, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(155, 155, 160, 165, 170)
    recipe:SetCraftedItem(42738, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.CASTER, F.MAGE)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Combustion -- 56975
    recipe = AddRecipe(56975, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(385, 385, 390, 397, 405)
    recipe:SetCraftedItem(42739, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.CASTER, F.MAGE)
    recipe:AddDiscovery("DISCOVERY_INSC_NORTHREND", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Frost Nova -- 56976
    recipe = AddRecipe(56976, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(80, 80, 90, 100, 110)
    recipe:SetCraftedItem(42741, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.CASTER, F.MAGE)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Momentum -- 56978
    recipe = AddRecipe(56978, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(90, 90, 100, 110, 120)
    recipe:SetCraftedItem(42743, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.CASTER, F.MAGE)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Ice Block -- 56979
    recipe = AddRecipe(56979, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(225, 225, 230, 235, 240)
    recipe:SetCraftedItem(42744, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.CASTER, F.MAGE)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Splitting Ice -- 56980
    recipe = AddRecipe(56980, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(375, 375, 380, 385, 390)
    recipe:SetCraftedItem(42745, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.CASTER, F.MAGE)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30713, 30715, 30716, 30717, 30721, 33603, 33615,
        33638, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Cone of Cold -- 56981
    recipe = AddRecipe(56981, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(175, 175, 180, 185, 190)
    recipe:SetCraftedItem(42746, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.CASTER, F.MAGE)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Rapid Displacement -- 56983
    recipe = AddRecipe(56983, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(385, 385, 390, 397, 405)
    recipe:SetCraftedItem(42748, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.CASTER, F.MAGE)
    recipe:AddDiscovery("DISCOVERY_INSC_NORTHREND", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Mana Gem -- 56984
    recipe = AddRecipe(56984, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(325, 325, 330, 335, 340)
    recipe:SetCraftedItem(42749, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.CASTER, F.MAGE)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30713, 30715, 30716, 30717, 30721, 30722, 33603,
        33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Crittermorph -- 56986
    recipe = AddRecipe(56986, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(385, 385, 390, 397, 405)
    recipe:SetCraftedItem(42751, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.CASTER, F.MAGE)
    recipe:AddDiscovery("DISCOVERY_INSC_NORTHREND", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Polymorph -- 56987
    recipe = AddRecipe(56987, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(400, 400, 400, 400, 405)
    recipe:SetCraftedItem(42752, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.CASTER, F.MAGE)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30713, 30715, 30716, 30717, 30721, 33603, 33615,
        33638, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Icy Veins -- 56988
    recipe = AddRecipe(56988, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(385, 385, 390, 397, 405)
    recipe:SetCraftedItem(42753, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.CASTER, F.MAGE)
    recipe:AddDiscovery("DISCOVERY_INSC_NORTHREND", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Spellsteal -- 56989
    recipe = AddRecipe(56989, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(385, 385, 390, 397, 405)
    recipe:SetCraftedItem(42754, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.CASTER, F.MAGE)
    recipe:AddDiscovery("DISCOVERY_INSC_NORTHREND", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Remove Curse -- 56990
    recipe = AddRecipe(56990, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(310, 310, 355, 360, 365)
    recipe:SetCraftedItem(44920, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MAGE)
    recipe:AddDiscovery("DISCOVERY_INSC_MINOR")

    -- Glyph of Arcane Power -- 56991
    recipe = AddRecipe(56991, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(315, 315, 320, 325, 330)
    recipe:SetCraftedItem(44955, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MAGE)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30713, 30715, 30716, 30717, 30721, 30722, 33603,
        33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Aspects -- 56994
    recipe = AddRecipe(56994, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(175, 175, 180, 185, 190)
    recipe:SetCraftedItem(42897, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HUNTER)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Camouflage -- 56995
    recipe = AddRecipe(56995, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(100, 100, 105, 110, 115)
    recipe:SetCraftedItem(42898, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HUNTER)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Liberation -- 56996
    recipe = AddRecipe(56996, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(385, 385, 390, 397, 405)
    recipe:SetCraftedItem(42899, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HUNTER)
    recipe:AddDiscovery("DISCOVERY_INSC_NORTHREND", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Mending -- 56997
    recipe = AddRecipe(56997, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(115, 115, 120, 125, 130)
    recipe:SetCraftedItem(42900, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HUNTER)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Distracting Shot -- 56998
    recipe = AddRecipe(56998, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(385, 385, 390, 397, 405)
    recipe:SetCraftedItem(42901, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HUNTER)
    recipe:AddDiscovery("DISCOVERY_INSC_NORTHREND", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Endless Wrath -- 56999
    recipe = AddRecipe(56999, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(385, 385, 390, 397, 405)
    recipe:SetCraftedItem(42902, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HUNTER)
    recipe:AddDiscovery("DISCOVERY_INSC_NORTHREND", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Deterrence -- 57000
    recipe = AddRecipe(57000, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(200, 200, 205, 210, 215)
    recipe:SetCraftedItem(42903, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HUNTER)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Disengage -- 57001
    recipe = AddRecipe(57001, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(225, 225, 230, 235, 240)
    recipe:SetCraftedItem(42904, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HUNTER)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Freezing Trap -- 57002
    recipe = AddRecipe(57002, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(260, 260, 265, 270, 275)
    recipe:SetCraftedItem(42905, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HUNTER)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Ice Trap -- 57003
    recipe = AddRecipe(57003, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(350, 350, 355, 360, 365)
    recipe:SetCraftedItem(42906, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HUNTER)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30713, 30715, 30716, 30717, 30721, 30722, 33603,
        33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Misdirection -- 57004
    recipe = AddRecipe(57004, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(80, 80, 90, 100, 110)
    recipe:SetCraftedItem(42907, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HUNTER)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Explosive Trap -- 57005
    recipe = AddRecipe(57005, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(130, 130, 135, 140, 145)
    recipe:SetCraftedItem(42908, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HUNTER)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Animal Bond -- 57006
    recipe = AddRecipe(57006, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(375, 375, 380, 385, 390)
    recipe:SetCraftedItem(42909, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HUNTER)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30713, 30715, 30716, 30717, 30721, 33603, 33615,
        33638, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of No Escape -- 57007
    recipe = AddRecipe(57007, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(150, 150, 155, 160, 165)
    recipe:SetCraftedItem(42910, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HUNTER)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Pathfinding -- 57008
    recipe = AddRecipe(57008, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(315, 315, 320, 325, 330)
    recipe:SetCraftedItem(42911, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HUNTER)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30713, 30715, 30716, 30717, 30721, 30722, 33603,
        33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Tame Beast -- 57009
    recipe = AddRecipe(57009, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(90, 90, 100, 110, 120)
    recipe:SetCraftedItem(42912, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HUNTER)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Snake Trap -- 57010
    recipe = AddRecipe(57010, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(385, 385, 390, 397, 405)
    recipe:SetCraftedItem(42913, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HUNTER)
    recipe:AddDiscovery("DISCOVERY_INSC_NORTHREND", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Aimed Shot -- 57011
    recipe = AddRecipe(57011, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(385, 385, 390, 397, 405)
    recipe:SetCraftedItem(42914, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HUNTER)
    recipe:AddDiscovery("DISCOVERY_INSC_NORTHREND", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Mend Pet -- 57012
    recipe = AddRecipe(57012, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(385, 385, 390, 397, 405)
    recipe:SetCraftedItem(42915, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HUNTER)
    recipe:AddDiscovery("DISCOVERY_INSC_NORTHREND", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Solace -- 57014
    recipe = AddRecipe(57014, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(385, 385, 390, 397, 405)
    recipe:SetCraftedItem(42917, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HUNTER)
    recipe:AddDiscovery("DISCOVERY_INSC_NORTHREND", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Focused Shield -- 57019
    recipe = AddRecipe(57019, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(385, 385, 390, 397, 405)
    recipe:SetCraftedItem(41101, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PALADIN)
    recipe:AddDiscovery("DISCOVERY_INSC_NORTHREND", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Final Wrath -- 57020
    recipe = AddRecipe(57020, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(180, 180, 185, 190, 195)
    recipe:SetCraftedItem(41104, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PALADIN)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of the Harsh Word -- 57021
    recipe = AddRecipe(57021, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(385, 385, 390, 397, 405)
    recipe:SetCraftedItem(41107, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PALADIN)
    recipe:AddDiscovery("DISCOVERY_INSC_NORTHREND", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Divine Protection -- 57022
    recipe = AddRecipe(57022, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(80, 80, 90, 100, 110)
    recipe:SetCraftedItem(41096, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER, F.PALADIN)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Consecration -- 57023
    recipe = AddRecipe(57023, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(205, 205, 210, 215, 220)
    recipe:SetCraftedItem(41099, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PALADIN)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Avenging Wrath -- 57024
    recipe = AddRecipe(57024, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(230, 230, 235, 240, 245)
    recipe:SetCraftedItem(41098, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PALADIN)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Blinding Light -- 57025
    recipe = AddRecipe(57025, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(265, 265, 270, 275, 280)
    recipe:SetCraftedItem(41103, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PALADIN)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Word of Glory -- 57026
    recipe = AddRecipe(57026, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(300, 300, 305, 310, 315)
    recipe:SetCraftedItem(41105, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.PALADIN)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30713, 30715, 30716, 30717, 30721, 30722, 33603,
        33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Holy Wrath -- 57027
    recipe = AddRecipe(57027, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(90, 90, 100, 110, 120)
    recipe:SetCraftedItem(41095, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PALADIN)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Templar's Verdict -- 57028
    recipe = AddRecipe(57028, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(385, 385, 390, 397, 405)
    recipe:SetCraftedItem(41097, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PALADIN)
    recipe:AddDiscovery("DISCOVERY_INSC_NORTHREND", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Illumination -- 57029
    recipe = AddRecipe(57029, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(105, 105, 110, 115, 120)
    recipe:SetCraftedItem(41106, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.PALADIN)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Double Jeopardy -- 57030
    recipe = AddRecipe(57030, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(120, 120, 125, 130, 135)
    recipe:SetCraftedItem(41092, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PALADIN)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Divinity -- 57031
    recipe = AddRecipe(57031, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(135, 135, 140, 145, 150)
    recipe:SetCraftedItem(41108, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PALADIN)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of the Luminous Charger -- 57032
    recipe = AddRecipe(57032, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(155, 155, 160, 165, 170)
    recipe:SetCraftedItem(41100, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.TANK, F.PALADIN)
    recipe:AddDiscovery("DISCOVERY_INSC_MINOR")

    -- Glyph of Devotion Aura -- 57033
    recipe = AddRecipe(57033, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(335, 335, 340, 345, 350)
    recipe:SetCraftedItem(41094, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PALADIN)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30713, 30715, 30716, 30717, 30721, 30722, 33603,
        33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Blessed Life -- 57034
    recipe = AddRecipe(57034, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(385, 385, 390, 397, 405)
    recipe:SetCraftedItem(41110, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PALADIN)
    recipe:AddDiscovery("DISCOVERY_INSC_NORTHREND", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Light of Dawn -- 57035
    recipe = AddRecipe(57035, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(385, 385, 390, 397, 405)
    recipe:SetCraftedItem(41109, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PALADIN)
    recipe:AddDiscovery("DISCOVERY_INSC_NORTHREND", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Turn Evil -- 57036
    recipe = AddRecipe(57036, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(375, 375, 380, 385, 390)
    recipe:SetCraftedItem(41102, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PALADIN)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30713, 30715, 30716, 30717, 30721, 33603, 33615,
        33638, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Shadow Walk -- 57112
    recipe = AddRecipe(57112, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(385, 385, 390, 397, 405)
    recipe:SetCraftedItem(42954, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.ROGUE)
    recipe:AddDiscovery("DISCOVERY_INSC_NORTHREND", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Ambush -- 57113
    recipe = AddRecipe(57113, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(340, 340, 345, 350, 355)
    recipe:SetCraftedItem(42955, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.ROGUE)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30713, 30715, 30716, 30717, 30721, 30722, 33603,
        33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Decoy -- 57114
    recipe = AddRecipe(57114, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(80, 80, 90, 100, 110)
    recipe:SetCraftedItem(42956, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.ROGUE)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Blade Flurry -- 57115
    recipe = AddRecipe(57115, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(385, 385, 390, 397, 405)
    recipe:SetCraftedItem(42957, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.ROGUE)
    recipe:AddDiscovery("DISCOVERY_INSC_NORTHREND", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Sharp Knives -- 57116
    recipe = AddRecipe(57116, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(385, 385, 390, 397, 405)
    recipe:SetCraftedItem(42958, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.ROGUE)
    recipe:AddDiscovery("DISCOVERY_INSC_NORTHREND", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Recuperate -- 57117
    recipe = AddRecipe(57117, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(385, 385, 390, 397, 405)
    recipe:SetCraftedItem(42959, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.ROGUE)
    recipe:AddDiscovery("DISCOVERY_INSC_NORTHREND", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Evasion -- 57119
    recipe = AddRecipe(57119, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(95, 95, 105, 115, 125)
    recipe:SetCraftedItem(42960, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.ROGUE)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Recovery -- 57120
    recipe = AddRecipe(57120, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(105, 105, 110, 115, 120)
    recipe:SetCraftedItem(42961, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.ROGUE)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Expose Armor -- 57121
    recipe = AddRecipe(57121, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(120, 120, 125, 130, 135)
    recipe:SetCraftedItem(42962, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.ROGUE)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Feint -- 57122
    recipe = AddRecipe(57122, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(305, 305, 310, 315, 320)
    recipe:SetCraftedItem(42963, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.ROGUE)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30713, 30715, 30716, 30717, 30721, 30722, 33603,
        33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Garrote -- 57123
    recipe = AddRecipe(57123, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(135, 135, 140, 145, 150)
    recipe:SetCraftedItem(42964, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.ROGUE)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Detection -- 57124
    recipe = AddRecipe(57124, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(385, 385, 390, 397, 405)
    recipe:SetCraftedItem(42965, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.ROGUE)
    recipe:AddDiscovery("DISCOVERY_INSC_NORTHREND", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Gouge -- 57125
    recipe = AddRecipe(57125, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(160, 160, 165, 170, 175)
    recipe:SetCraftedItem(42966, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.ROGUE)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Hemorrhage -- 57126
    recipe = AddRecipe(57126, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(385, 385, 390, 397, 405)
    recipe:SetCraftedItem(42967, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.ROGUE)
    recipe:AddDiscovery("DISCOVERY_INSC_NORTHREND", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Smoke Bomb -- 57127
    recipe = AddRecipe(57127, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(385, 385, 390, 397, 405)
    recipe:SetCraftedItem(42968, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.ROGUE)
    recipe:AddDiscovery("DISCOVERY_INSC_NORTHREND", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Cheap Shot -- 57128
    recipe = AddRecipe(57128, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(385, 385, 390, 397, 405)
    recipe:SetCraftedItem(42969, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.ROGUE)
    recipe:AddDiscovery("DISCOVERY_INSC_NORTHREND", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Hemorraghing Veins -- 57129
    recipe = AddRecipe(57129, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(185, 185, 190, 195, 200)
    recipe:SetCraftedItem(42970, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.ROGUE)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Kick -- 57130
    recipe = AddRecipe(57130, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(385, 385, 390, 397, 405)
    recipe:SetCraftedItem(42971, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.ROGUE)
    recipe:AddDiscovery("DISCOVERY_INSC_NORTHREND", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Redirect -- 57131
    recipe = AddRecipe(57131, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(210, 210, 215, 220, 225)
    recipe:SetCraftedItem(42972, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.ROGUE)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Shiv -- 57132
    recipe = AddRecipe(57132, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(235, 235, 240, 245, 250)
    recipe:SetCraftedItem(42973, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.ROGUE)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Sprint -- 57133
    recipe = AddRecipe(57133, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(285, 285, 290, 295, 300)
    recipe:SetCraftedItem(42974, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.ROGUE)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Shield Slam -- 57152
    recipe = AddRecipe(57152, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(385, 385, 390, 397, 405)
    recipe:SetCraftedItem(43425, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.TANK, F.WARRIOR)
    recipe:AddDiscovery("DISCOVERY_INSC_NORTHREND", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Bloody Healing -- 57153
    recipe = AddRecipe(57153, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(385, 385, 390, 397, 405)
    recipe:SetCraftedItem(43412, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARRIOR)
    recipe:AddDiscovery("DISCOVERY_INSC_MINOR")

    -- Glyph of Hindering Strikes -- 57154
    recipe = AddRecipe(57154, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(240, 240, 245, 250, 255)
    recipe:SetCraftedItem(43414, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARRIOR)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Heavy Repercussions -- 57155
    recipe = AddRecipe(57155, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(385, 385, 390, 397, 405)
    recipe:SetCraftedItem(43415, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARRIOR)
    recipe:AddDiscovery("DISCOVERY_INSC_NORTHREND", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Bloodthirst -- 57156
    recipe = AddRecipe(57156, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(285, 285, 290, 295, 300)
    recipe:SetCraftedItem(43416, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARRIOR)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Rude Interruption -- 57157
    recipe = AddRecipe(57157, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(125, 125, 130, 135, 140)
    recipe:SetCraftedItem(43417, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARRIOR)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Gag Order -- 57158
    recipe = AddRecipe(57158, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(95, 95, 105, 115, 125)
    recipe:SetCraftedItem(43418, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARRIOR)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Blitz -- 57159
    recipe = AddRecipe(57159, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(385, 385, 390, 397, 405)
    recipe:SetCraftedItem(43419, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARRIOR)
    recipe:AddDiscovery("DISCOVERY_INSC_NORTHREND", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Mortal Strike -- 57160
    recipe = AddRecipe(57160, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(385, 385, 390, 397, 405)
    recipe:SetCraftedItem(43421, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARRIOR)
    recipe:AddDiscovery("DISCOVERY_INSC_NORTHREND", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Die by the Sword -- 57161
    recipe = AddRecipe(57161, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(170, 170, 175, 180, 185)
    recipe:SetCraftedItem(43422, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARRIOR)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Enraged Speed -- 57162
    recipe = AddRecipe(57162, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(85, 85, 95, 105, 115)
    recipe:SetCraftedItem(43413, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARRIOR)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Hamstring -- 57163
    recipe = AddRecipe(57163, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(110, 110, 115, 120, 125)
    recipe:SetCraftedItem(43423, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARRIOR)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Resonating Power -- 57164
    recipe = AddRecipe(57164, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(385, 385, 390, 397, 405)
    recipe:SetCraftedItem(43430, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARRIOR)
    recipe:AddDiscovery("DISCOVERY_INSC_NORTHREND", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Hold the Line -- 57165
    recipe = AddRecipe(57165, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(190, 190, 195, 200, 205)
    recipe:SetCraftedItem(43424, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARRIOR)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Hoarse Voice -- 57167
    recipe = AddRecipe(57167, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(140, 140, 145, 150, 155)
    recipe:SetCraftedItem(43427, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.TANK, F.WARRIOR)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Sweeping Strikes -- 57168
    recipe = AddRecipe(57168, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(320, 320, 325, 330, 335)
    recipe:SetCraftedItem(43428, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARRIOR)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30713, 30715, 30716, 30717, 30721, 30722, 33603,
        33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Victory Rush -- 57170
    recipe = AddRecipe(57170, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(385, 385, 390, 397, 405)
    recipe:SetCraftedItem(43431, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARRIOR)
    recipe:AddDiscovery("DISCOVERY_INSC_NORTHREND", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Raging Wind -- 57172
    recipe = AddRecipe(57172, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(345, 345, 350, 355, 360)
    recipe:SetCraftedItem(43432, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARRIOR)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30713, 30715, 30716, 30717, 30721, 30722, 33603,
        33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Circle of Healing -- 57181
    recipe = AddRecipe(57181, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(385, 385, 390, 397, 405)
    recipe:SetCraftedItem(42396, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.PRIEST)
    recipe:AddDiscovery("DISCOVERY_INSC_NORTHREND", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Purify -- 57183
    recipe = AddRecipe(57183, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(230, 230, 235, 240, 245)
    recipe:SetCraftedItem(42397, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER, F.PRIEST)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Fade -- 57184
    recipe = AddRecipe(57184, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(105, 105, 110, 115, 120)
    recipe:SetCraftedItem(42398, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER, F.PRIEST)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Fear Ward -- 57185
    recipe = AddRecipe(57185, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(270, 270, 275, 280, 285)
    recipe:SetCraftedItem(42399, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER, F.PRIEST)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Inner Sanctum -- 57186
    recipe = AddRecipe(57186, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(120, 120, 125, 130, 135)
    recipe:SetCraftedItem(42400, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.PRIEST)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Holy Nova -- 57187
    recipe = AddRecipe(57187, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(315, 315, 320, 325, 330)
    recipe:SetCraftedItem(42401, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.PRIEST)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30713, 30715, 30716, 30717, 30721, 30722, 33603,
        33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Inner Fire -- 57188
    recipe = AddRecipe(57188, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(135, 135, 140, 145, 150)
    recipe:SetCraftedItem(42402, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER, F.PRIEST)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Lightwell -- 57189
    recipe = AddRecipe(57189, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(385, 385, 390, 397, 405)
    recipe:SetCraftedItem(42403, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.PRIEST)
    recipe:AddDiscovery("DISCOVERY_INSC_NORTHREND", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Mass Dispel -- 57190
    recipe = AddRecipe(57190, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(385, 385, 390, 397, 405)
    recipe:SetCraftedItem(42404, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER, F.PRIEST)
    recipe:AddDiscovery("DISCOVERY_INSC_NORTHREND", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Psychic Horror -- 57191
    recipe = AddRecipe(57191, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(385, 385, 390, 397, 405)
    recipe:SetCraftedItem(42405, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER, F.PRIEST)
    recipe:AddDiscovery("DISCOVERY_INSC_NORTHREND", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Holy Fire -- 57192
    recipe = AddRecipe(57192, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(350, 350, 355, 360, 365)
    recipe:SetCraftedItem(42406, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.CASTER, F.PRIEST)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30713, 30715, 30716, 30717, 30721, 30722, 33603,
        33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Weakened Soul -- 57193
    recipe = AddRecipe(57193, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(385, 385, 390, 397, 405)
    recipe:SetCraftedItem(42407, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER, F.PRIEST)
    recipe:AddDiscovery("DISCOVERY_INSC_NORTHREND", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Power Word: Shield -- 57194
    recipe = AddRecipe(57194, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(80, 80, 90, 100, 110)
    recipe:SetCraftedItem(42408, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.PRIEST)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Spirit of Redemption -- 57195
    recipe = AddRecipe(57195, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(385, 385, 390, 397, 405)
    recipe:SetCraftedItem(42409, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.PRIEST)
    recipe:AddDiscovery("DISCOVERY_INSC_NORTHREND", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Psychic Scream -- 57196
    recipe = AddRecipe(57196, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(95, 95, 105, 115, 125)
    recipe:SetCraftedItem(42410, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER, F.PRIEST)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Renew -- 57197
    recipe = AddRecipe(57197, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(160, 160, 165, 170, 175)
    recipe:SetCraftedItem(42411, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.PRIEST)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Scourge Imprisonment -- 57198
    recipe = AddRecipe(57198, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(375, 375, 380, 385, 390)
    recipe:SetCraftedItem(42412, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER, F.PRIEST)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30713, 30715, 30716, 30717, 30721, 33603, 33615,
        33638, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Mind Blast -- 57199
    recipe = AddRecipe(57199, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(385, 385, 390, 397, 405)
    recipe:SetCraftedItem(42414, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.CASTER, F.PRIEST)
    recipe:AddDiscovery("DISCOVERY_INSC_NORTHREND", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Dispel Magic -- 57200
    recipe = AddRecipe(57200, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(180, 180, 185, 190, 195)
    recipe:SetCraftedItem(42415, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.CASTER, F.PRIEST)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Smite -- 57201
    recipe = AddRecipe(57201, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(210, 210, 215, 220, 225)
    recipe:SetCraftedItem(42416, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.CASTER, F.PRIEST)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Prayer of Mending -- 57202
    recipe = AddRecipe(57202, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(385, 385, 390, 397, 405)
    recipe:SetCraftedItem(42417, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.PRIEST)
    recipe:AddDiscovery("DISCOVERY_INSC_NORTHREND", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Anti-Magic Shell -- 57207
    recipe = AddRecipe(57207, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(385, 385, 390, 397, 405)
    recipe:SetCraftedItem(43533, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DK)
    recipe:AddDiscovery("DISCOVERY_INSC_NORTHREND", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Unholy Frenzy -- 57208
    recipe = AddRecipe(57208, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(385, 385, 390, 397, 405)
    recipe:SetCraftedItem(43534, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DK)
    recipe:AddDiscovery("DISCOVERY_INSC_NORTHREND", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of the Geist -- 57209
    recipe = AddRecipe(57209, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(320, 320, 330, 335, 340)
    recipe:SetCraftedItem(43535, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DK)
    recipe:AddDiscovery("DISCOVERY_INSC_MINOR")

    -- Glyph of Icebound Fortitude -- 57210
    recipe = AddRecipe(57210, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(265, 265, 270, 275, 280)
    recipe:SetCraftedItem(43536, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DK)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Chains of Ice -- 57211
    recipe = AddRecipe(57211, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(385, 385, 390, 397, 405)
    recipe:SetCraftedItem(43537, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DK)
    recipe:AddDiscovery("DISCOVERY_INSC_NORTHREND", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Death Grip -- 57213
    recipe = AddRecipe(57213, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(285, 285, 290, 295, 300)
    recipe:SetCraftedItem(43541, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DK)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Death and Decay -- 57214
    recipe = AddRecipe(57214, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(385, 385, 390, 397, 405)
    recipe:SetCraftedItem(43542, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DK)
    recipe:AddDiscovery("DISCOVERY_INSC_NORTHREND", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Death's Embrace -- 57215
    recipe = AddRecipe(57215, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(300, 300, 305, 310, 315)
    recipe:SetCraftedItem(43539, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DK)
    recipe:AddDiscovery("DISCOVERY_INSC_MINOR")

    -- Glyph of Shifting Presences -- 57216
    recipe = AddRecipe(57216, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(270, 270, 275, 280, 285)
    recipe:SetCraftedItem(43543, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DK)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Horn of Winter -- 57217
    recipe = AddRecipe(57217, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(320, 320, 330, 335, 340)
    recipe:SetCraftedItem(43544, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DK)
    recipe:AddDiscovery("DISCOVERY_INSC_MINOR")

    -- Glyph of Icy Touch -- 57219
    recipe = AddRecipe(57219, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(280, 280, 285, 290, 295)
    recipe:SetCraftedItem(43546, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DK)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Enduring Infection -- 57220
    recipe = AddRecipe(57220, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(385, 385, 390, 397, 405)
    recipe:SetCraftedItem(43547, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DK)
    recipe:AddDiscovery("DISCOVERY_INSC_NORTHREND", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Pestilence -- 57221
    recipe = AddRecipe(57221, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(300, 300, 305, 310, 315)
    recipe:SetCraftedItem(43548, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DK)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30713, 30715, 30716, 30717, 30721, 30722, 33603,
        33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Mind Freeze -- 57222
    recipe = AddRecipe(57222, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(350, 350, 355, 360, 365)
    recipe:SetCraftedItem(43549, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.DK)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30713, 30715, 30716, 30717, 30721, 30722, 33603,
        33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Army of the Dead -- 57223
    recipe = AddRecipe(57223, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(385, 385, 390, 397, 405)
    recipe:SetCraftedItem(43550, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DK)
    recipe:AddDiscovery("DISCOVERY_INSC_NORTHREND", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Foul Menagerie -- 57224
    recipe = AddRecipe(57224, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(330, 330, 335, 340, 345)
    recipe:SetCraftedItem(43551, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DK)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30713, 30715, 30716, 30717, 30721, 30722, 33603,
        33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Strangulate -- 57225
    recipe = AddRecipe(57225, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(375, 375, 380, 385, 390)
    recipe:SetCraftedItem(43552, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DK)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30713, 30715, 30716, 30717, 30721, 33603, 33615,
        33638, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Pillar of Frost -- 57226
    recipe = AddRecipe(57226, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(305, 305, 310, 315, 320)
    recipe:SetCraftedItem(43553, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DK)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30713, 30715, 30716, 30717, 30721, 30722, 33603,
        33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Vampiric Blood -- 57227
    recipe = AddRecipe(57227, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(345, 345, 350, 355, 360)
    recipe:SetCraftedItem(43554, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DK)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30713, 30715, 30716, 30717, 30721, 30722, 33603,
        33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Death Gate -- 57228
    recipe = AddRecipe(57228, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(300, 300, 305, 310, 315)
    recipe:SetCraftedItem(43673, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DK)
    recipe:AddDiscovery("DISCOVERY_INSC_MINOR")

    -- Glyph of Path of Frost -- 57229
    recipe = AddRecipe(57229, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(300, 300, 305, 310, 315)
    recipe:SetCraftedItem(43671, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DK)
    recipe:AddDiscovery("DISCOVERY_INSC_MINOR")

    -- Glyph of Resilient Grip -- 57230
    recipe = AddRecipe(57230, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(300, 300, 305, 310, 315)
    recipe:SetCraftedItem(43672, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DK)
    recipe:AddDiscovery("DISCOVERY_INSC_MINOR")

    -- Glyph of Unstable Earth -- 57232
    recipe = AddRecipe(57232, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(385, 385, 390, 397, 405)
    recipe:SetCraftedItem(41517, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.SHAMAN)
    recipe:AddDiscovery("DISCOVERY_INSC_NORTHREND", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Chain Lightning -- 57233
    recipe = AddRecipe(57233, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(385, 385, 390, 397, 405)
    recipe:SetCraftedItem(41518, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.CASTER, F.SHAMAN)
    recipe:AddDiscovery("DISCOVERY_INSC_NORTHREND", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Spirit Walk -- 57234
    recipe = AddRecipe(57234, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(385, 385, 390, 395, 400)
    recipe:SetCraftedItem(41524, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.SHAMAN)
    recipe:AddDiscovery("DISCOVERY_INSC_NORTHREND", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Capacitor Totem -- 57235
    recipe = AddRecipe(57235, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(385, 385, 390, 397, 405)
    recipe:SetCraftedItem(41526, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.SHAMAN)
    recipe:AddDiscovery("DISCOVERY_INSC_NORTHREND", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Purge -- 57236
    recipe = AddRecipe(57236, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(300, 300, 305, 310, 315)
    recipe:SetCraftedItem(41527, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.SHAMAN)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30713, 30715, 30716, 30717, 30721, 30722, 33603,
        33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Fire Elemental Totem -- 57237
    recipe = AddRecipe(57237, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(385, 385, 390, 397, 405)
    recipe:SetCraftedItem(41529, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.SHAMAN)
    recipe:AddDiscovery("DISCOVERY_INSC_NORTHREND", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Fire Nova -- 57238
    recipe = AddRecipe(57238, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(110, 110, 115, 120, 125)
    recipe:SetCraftedItem(41530, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.SHAMAN)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Flame Shock -- 57239
    recipe = AddRecipe(57239, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(85, 85, 95, 105, 115)
    recipe:SetCraftedItem(41531, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.SHAMAN)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Wind Shear -- 57240
    recipe = AddRecipe(57240, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(125, 125, 130, 135, 140)
    recipe:SetCraftedItem(41532, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.SHAMAN)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Frost Shock -- 57241
    recipe = AddRecipe(57241, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(185, 185, 190, 195, 200)
    recipe:SetCraftedItem(41547, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.SHAMAN)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Healing Stream Totem -- 57242
    recipe = AddRecipe(57242, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(215, 215, 220, 225, 230)
    recipe:SetCraftedItem(41533, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.SHAMAN)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Healing Wave -- 57243
    recipe = AddRecipe(57243, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(385, 385, 390, 397, 405)
    recipe:SetCraftedItem(41534, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.SHAMAN)
    recipe:AddDiscovery("DISCOVERY_INSC_NORTHREND", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Totemic Recall -- 57244
    recipe = AddRecipe(57244, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(235, 235, 240, 245, 250)
    recipe:SetCraftedItem(41535, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.SHAMAN)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Telluric Currents -- 57245
    recipe = AddRecipe(57245, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(140, 140, 145, 150, 155)
    recipe:SetCraftedItem(41536, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.CASTER, F.SHAMAN)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of the Lakestrider -- 57246
    recipe = AddRecipe(57246, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(95, 95, 105, 115, 125)
    recipe:SetCraftedItem(41537, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.SHAMAN)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Grounding Totem -- 57247
    recipe = AddRecipe(57247, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(385, 385, 390, 397, 405)
    recipe:SetCraftedItem(41538, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.SHAMAN)
    recipe:AddDiscovery("DISCOVERY_INSC_NORTHREND", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Spiritwalker's Grace -- 57248
    recipe = AddRecipe(57248, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(375, 375, 380, 385, 390)
    recipe:SetCraftedItem(41539, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.SHAMAN)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30713, 30715, 30716, 30717, 30721, 33603, 33615,
        33638, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Lava Lash -- 57249
    recipe = AddRecipe(57249, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(165, 165, 170, 175, 180)
    recipe:SetCraftedItem(41540, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.SHAMAN)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Chaining -- 57250
    recipe = AddRecipe(57250, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(385, 385, 390, 397, 405)
    recipe:SetCraftedItem(41552, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.SHAMAN)
    recipe:AddDiscovery("DISCOVERY_INSC_NORTHREND", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Water Shield -- 57251
    recipe = AddRecipe(57251, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(275, 275, 280, 285, 290)
    recipe:SetCraftedItem(41541, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.SHAMAN)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Cleansing Waters -- 57252
    recipe = AddRecipe(57252, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(330, 330, 335, 340, 345)
    recipe:SetCraftedItem(41542, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.SHAMAN)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30713, 30715, 30716, 30717, 30721, 30722, 33603,
        33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Thunderstorm -- 57253
    recipe = AddRecipe(57253, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(355, 355, 355, 360, 365)
    recipe:SetCraftedItem(44923, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.SHAMAN)
    recipe:AddDiscovery("DISCOVERY_INSC_MINOR")

    -- Glyph of Hand of Gul'dan -- 57257
    recipe = AddRecipe(57257, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(350, 350, 355, 360, 365)
    recipe:SetCraftedItem(42453, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.CASTER, F.WARLOCK)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30713, 30715, 30716, 30717, 30721, 30722, 33603,
        33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Conflagrate -- 57258
    recipe = AddRecipe(57258, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(385, 385, 390, 397, 405)
    recipe:SetCraftedItem(42454, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.CASTER, F.WARLOCK)
    recipe:AddDiscovery("DISCOVERY_INSC_NORTHREND", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Siphon Life -- 57259
    recipe = AddRecipe(57259, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(85, 85, 95, 105, 115)
    recipe:SetCraftedItem(42455, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.CASTER, F.WARLOCK)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Verdant Spheres -- 57260
    recipe = AddRecipe(57260, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(385, 385, 390, 397, 405)
    recipe:SetCraftedItem(42456, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.CASTER, F.WARLOCK)
    recipe:AddDiscovery("DISCOVERY_INSC_NORTHREND", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Nightmares -- 57261
    recipe = AddRecipe(57261, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(275, 275, 285, 290, 295)
    recipe:SetCraftedItem(42457, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.CASTER, F.WARLOCK)
    recipe:AddDiscovery("DISCOVERY_INSC_NORTHREND", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Fear -- 57262
    recipe = AddRecipe(57262, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(125, 125, 130, 135, 140)
    recipe:SetCraftedItem(42458, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.CASTER, F.WARLOCK)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Felguard -- 57263
    recipe = AddRecipe(57263, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(385, 385, 390, 397, 405)
    recipe:SetCraftedItem(42459, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.CASTER, F.WARLOCK)
    recipe:AddDiscovery("DISCOVERY_INSC_NORTHREND", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Demon Training -- 57264
    recipe = AddRecipe(57264, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(385, 385, 390, 397, 405)
    recipe:SetCraftedItem(42460, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.CASTER, F.WARLOCK)
    recipe:AddDiscovery("DISCOVERY_INSC_NORTHREND", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Health Funnel -- 57265
    recipe = AddRecipe(57265, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(110, 110, 115, 120, 125)
    recipe:SetCraftedItem(42461, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.CASTER, F.WARLOCK)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Healthstone -- 57266
    recipe = AddRecipe(57266, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(95, 95, 105, 115, 125)
    recipe:SetCraftedItem(42462, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.CASTER, F.WARLOCK)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Subtlety -- 57267
    recipe = AddRecipe(57267, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(385, 385, 390, 397, 405)
    recipe:SetCraftedItem(42463, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.CASTER, F.WARLOCK)
    recipe:AddDiscovery("DISCOVERY_INSC_NORTHREND", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Curse of the Elements -- 57268
    recipe = AddRecipe(57268, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(385, 385, 390, 397, 405)
    recipe:SetCraftedItem(42464, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.CASTER, F.WARLOCK)
    recipe:AddDiscovery("DISCOVERY_INSC_NORTHREND", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Imp Swarm -- 57269
    recipe = AddRecipe(57269, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(140, 140, 145, 150, 155)
    recipe:SetCraftedItem(42465, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.CASTER, F.WARLOCK)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Havoc -- 57270
    recipe = AddRecipe(57270, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(215, 215, 220, 225, 230)
    recipe:SetCraftedItem(42466, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.CASTER, F.WARLOCK)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Shadow Bolt -- 57271
    recipe = AddRecipe(57271, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(165, 165, 170, 175, 180)
    recipe:SetCraftedItem(42467, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.CASTER, F.WARLOCK)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Soulstone -- 57274
    recipe = AddRecipe(57274, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(240, 240, 245, 250, 255)
    recipe:SetCraftedItem(42470, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.CASTER, F.WARLOCK)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Carrion Swarm -- 57275
    recipe = AddRecipe(57275, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(325, 325, 330, 335, 340)
    recipe:SetCraftedItem(42471, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.CASTER, F.WARLOCK)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30713, 30715, 30716, 30717, 30721, 30722, 33603,
        33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Unstable Affliction -- 57276
    recipe = AddRecipe(57276, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(385, 385, 390, 397, 405)
    recipe:SetCraftedItem(42472, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.CASTER, F.WARLOCK)
    recipe:AddDiscovery("DISCOVERY_INSC_NORTHREND", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Falling Meteor -- 57277
    recipe = AddRecipe(57277, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(190, 190, 195, 200, 205)
    recipe:SetCraftedItem(42473, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.CASTER, F.WARLOCK)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Hunter's Ink -- 57703
    recipe = AddRecipe(57703, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(85, 85, 85, 90, 95)
    recipe:SetCraftedItem(43115, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MATERIALS")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Lion's Ink -- 57704
    recipe = AddRecipe(57704, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(100, 100, 100, 100, 105)
    recipe:SetCraftedItem(43116, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MATERIALS")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Dawnstar Ink -- 57706
    recipe = AddRecipe(57706, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(125, 125, 125, 130, 135)
    recipe:SetCraftedItem(43117, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MATERIALS")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Jadefire Ink -- 57707
    recipe = AddRecipe(57707, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(150, 150, 150, 150, 155)
    recipe:SetCraftedItem(43118, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MATERIALS")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Royal Ink -- 57708
    recipe = AddRecipe(57708, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(175, 175, 175, 175, 180)
    recipe:SetCraftedItem(43119, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MATERIALS")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Celestial Ink -- 57709
    recipe = AddRecipe(57709, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(200, 200, 200, 200, 205)
    recipe:SetCraftedItem(43120, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MATERIALS")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Fiery Ink -- 57710
    recipe = AddRecipe(57710, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(225, 225, 225, 225, 230)
    recipe:SetCraftedItem(43121, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MATERIALS")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Shimmering Ink -- 57711
    recipe = AddRecipe(57711, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(250, 250, 250, 250, 255)
    recipe:SetCraftedItem(43122, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MATERIALS")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Ink of the Sky -- 57712
    recipe = AddRecipe(57712, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(275, 275, 290, 295, 300)
    recipe:SetCraftedItem(43123, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MATERIALS")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Ethereal Ink -- 57713
    recipe = AddRecipe(57713, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(290, 290, 295, 300, 305)
    recipe:SetCraftedItem(43124, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MATERIALS")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Darkflame Ink -- 57714
    recipe = AddRecipe(57714, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(325, 325, 325, 325, 330)
    recipe:SetCraftedItem(43125, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MATERIALS")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30713, 30715, 30716, 30717, 30721, 30722, 33603,
        33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Ink of the Sea -- 57715
    recipe = AddRecipe(57715, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(350, 350, 350, 350, 355)
    recipe:SetCraftedItem(43126, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MATERIALS")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30713, 30715, 30716, 30717, 30721, 33603, 33615,
        33638, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Snowfall Ink -- 57716
    recipe = AddRecipe(57716, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(375, 375, 375, 375, 380)
    recipe:SetCraftedItem(43127, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MATERIALS")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30713, 30715, 30716, 30717, 30721, 33603, 33615,
        33638, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Aquatic Form -- 58286
    recipe = AddRecipe(58286, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(75, 75, 105, 110, 115)
    recipe:SetCraftedItem(43316, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DRUID)
    recipe:AddDiscovery("DISCOVERY_INSC_MINOR")

    -- Glyph of the Chameleon -- 58287
    recipe = AddRecipe(58287, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(150, 150, 155, 160, 165)
    recipe:SetCraftedItem(43334, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DRUID)
    recipe:AddDiscovery("DISCOVERY_INSC_MINOR")

    -- Glyph of Blooming -- 58288
    recipe = AddRecipe(58288, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(95, 95, 105, 110, 115)
    recipe:SetCraftedItem(43331, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DRUID)
    recipe:AddDiscovery("DISCOVERY_INSC_MINOR")

    -- Glyph of Grace -- 58289
    recipe = AddRecipe(58289, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(75, 75, 80, 85, 90)
    recipe:SetCraftedItem(43332, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DRUID)
    recipe:AddDiscovery("DISCOVERY_INSC_MINOR")

    -- Glyph of Charm Woodland Creature -- 58296
    recipe = AddRecipe(58296, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(75, 75, 80, 85, 90)
    recipe:SetCraftedItem(43335, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DRUID)
    recipe:AddDiscovery("DISCOVERY_INSC_MINOR")

    -- Glyph of Aspect of the Pack -- 58297
    recipe = AddRecipe(58297, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(195, 195, 205, 210, 215)
    recipe:SetCraftedItem(43355, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HUNTER)
    recipe:AddDiscovery("DISCOVERY_INSC_MINOR")

    -- Glyph of Stampede -- 58298
    recipe = AddRecipe(58298, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(75, 75, 80, 85, 90)
    recipe:SetCraftedItem(43356, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HUNTER)
    recipe:AddDiscovery("DISCOVERY_INSC_MINOR")

    -- Glyph of Revive Pet -- 58299
    recipe = AddRecipe(58299, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(75, 75, 80, 85, 90)
    recipe:SetCraftedItem(43338, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HUNTER)
    recipe:AddDiscovery("DISCOVERY_INSC_MINOR")

    -- Glyph of Lesser Proportion -- 58301
    recipe = AddRecipe(58301, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(75, 75, 80, 85, 90)
    recipe:SetCraftedItem(43350, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HUNTER)
    recipe:AddDiscovery("DISCOVERY_INSC_MINOR")

    -- Glyph of Fireworks -- 58302
    recipe = AddRecipe(58302, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(150, 150, 155, 160, 165)
    recipe:SetCraftedItem(43351, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HUNTER)
    recipe:AddDiscovery("DISCOVERY_INSC_MINOR")

    -- Glyph of the Porcupine -- 58303
    recipe = AddRecipe(58303, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(75, 75, 80, 85, 90)
    recipe:SetCraftedItem(43339, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.CASTER, F.MAGE)
    recipe:AddDiscovery("DISCOVERY_INSC_MINOR")

    -- Glyph of Conjure Familiar -- 58306
    recipe = AddRecipe(58306, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(75, 75, 80, 85, 90)
    recipe:SetCraftedItem(43359, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.CASTER, F.MAGE)
    recipe:AddDiscovery("DISCOVERY_INSC_MINOR")

    -- Glyph of the Monkey -- 58307
    recipe = AddRecipe(58307, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(120, 120, 130, 135, 140)
    recipe:SetCraftedItem(43360, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.CASTER, F.MAGE)
    recipe:AddDiscovery("DISCOVERY_INSC_MINOR")

    -- Glyph of Arcane Language -- 58308
    recipe = AddRecipe(58308, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(75, 75, 80, 85, 90)
    recipe:SetCraftedItem(43364, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.CASTER, F.MAGE)
    recipe:AddDiscovery("DISCOVERY_INSC_MINOR")

    -- Glyph of the Bear Cub -- 58309
    recipe = AddRecipe(58309, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(75, 75, 85, 90, 95)
    recipe:SetCraftedItem(43362, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MAGE)
    recipe:AddTrainer(30709, 30713, 30715, 30717, 33603, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of the Penguin -- 58310
    recipe = AddRecipe(58310, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(75, 75, 80, 85, 90)
    recipe:SetCraftedItem(43361, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.CASTER, F.MAGE)
    recipe:AddDiscovery("DISCOVERY_INSC_MINOR")

    -- Glyph of Contemplation -- 58311
    recipe = AddRecipe(58311, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(95, 95, 105, 110, 115)
    recipe:SetCraftedItem(43365, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PALADIN)
    recipe:AddDiscovery("DISCOVERY_INSC_MINOR")

    -- Glyph of Winged Vengeance -- 58312
    recipe = AddRecipe(58312, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(75, 75, 80, 85, 90)
    recipe:SetCraftedItem(43366, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PALADIN)
    recipe:AddDiscovery("DISCOVERY_INSC_MINOR")

    -- Glyph of Flash of Light -- 58313
    recipe = AddRecipe(58313, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(75, 75, 80, 85, 90)
    recipe:SetCraftedItem(43367, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PALADIN)
    recipe:AddTrainer(26916, 26977, 26995, 28702, 30706, 30709, 30713, 30715, 30716, 30717, 30721, 33603, 33615, 33638,
        46716, 53415, 56065, 62327, 64691, 66355)
    recipe:AddDiscovery("DISCOVERY_INSC_NORTHREND", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of the Mounted King -- 58314
    recipe = AddRecipe(58314, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(75, 75, 80, 85, 90)
    recipe:SetCraftedItem(43340, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PALADIN)
    recipe:AddDiscovery("DISCOVERY_INSC_MINOR")

    -- Glyph of Seal of Blood -- 58315
    recipe = AddRecipe(58315, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(95, 95, 105, 110, 115)
    recipe:SetCraftedItem(43368, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PALADIN)
    recipe:AddDiscovery("DISCOVERY_INSC_MINOR")

    -- Glyph of Fire From the Heavens -- 58316
    recipe = AddRecipe(58316, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(150, 150, 155, 160, 165)
    recipe:SetCraftedItem(43369, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PALADIN)
    recipe:AddDiscovery("DISCOVERY_INSC_MINOR")

    -- Glyph of Shadow Ravens -- 58317
    recipe = AddRecipe(58317, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(75, 75, 80, 85, 90)
    recipe:SetCraftedItem(43342, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER, F.PRIEST)
    recipe:AddDiscovery("DISCOVERY_INSC_MINOR")

    -- Glyph of Borrowed Time -- 58318
    recipe = AddRecipe(58318, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(75, 75, 80, 85, 90)
    recipe:SetCraftedItem(43371, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER, F.PRIEST)
    recipe:AddDiscovery("DISCOVERY_INSC_MINOR")

    -- Glyph of Levitate -- 58319
    recipe = AddRecipe(58319, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(175, 175, 180, 185, 190)
    recipe:SetCraftedItem(43370, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER, F.PRIEST)
    recipe:AddDiscovery("DISCOVERY_INSC_MINOR")

    -- Glyph of Shackle Undead -- 58320
    recipe = AddRecipe(58320, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(95, 95, 105, 110, 115)
    recipe:SetCraftedItem(43373, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER, F.PRIEST)
    recipe:AddDiscovery("DISCOVERY_INSC_MINOR")

    -- Glyph of Reflective Shield -- 58321
    recipe = AddRecipe(58321, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(150, 150, 155, 160, 165)
    recipe:SetCraftedItem(43372, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER, F.PRIEST)
    recipe:AddDiscovery("DISCOVERY_INSC_MINOR")

    -- Glyph of Dark Archangel -- 58322
    recipe = AddRecipe(58322, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(345, 345, 355, 360, 365)
    recipe:SetCraftedItem(43374, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER, F.PRIEST)
    recipe:AddDiscovery("DISCOVERY_INSC_MINOR")

    -- Glyph of Blurred Speed -- 58323
    recipe = AddRecipe(58323, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(75, 75, 80, 85, 90)
    recipe:SetCraftedItem(43379, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.ROGUE)
    recipe:AddDiscovery("DISCOVERY_INSC_MINOR")

    -- Glyph of Distract -- 58324
    recipe = AddRecipe(58324, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(120, 120, 130, 135, 140)
    recipe:SetCraftedItem(43376, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.ROGUE)
    recipe:AddDiscovery("DISCOVERY_INSC_MINOR")

    -- Glyph of Pick Lock -- 58325
    recipe = AddRecipe(58325, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(95, 95, 105, 110, 115)
    recipe:SetCraftedItem(43377, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.ROGUE)
    recipe:AddDiscovery("DISCOVERY_INSC_MINOR")

    -- Glyph of Pick Pocket -- 58326
    recipe = AddRecipe(58326, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(75, 75, 80, 85, 90)
    recipe:SetCraftedItem(43343, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.ROGUE)
    recipe:AddDiscovery("DISCOVERY_INSC_MINOR")

    -- Glyph of Safe Fall -- 58327
    recipe = AddRecipe(58327, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(195, 195, 205, 210, 215)
    recipe:SetCraftedItem(43378, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.ROGUE)
    recipe:AddDiscovery("DISCOVERY_INSC_MINOR")

    -- Glyph of Poisons -- 58328
    recipe = AddRecipe(58328, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(120, 120, 130, 135, 140)
    recipe:SetCraftedItem(43380, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.ROGUE)
    recipe:AddDiscovery("DISCOVERY_INSC_MINOR")

    -- Glyph of Astral Recall -- 58329
    recipe = AddRecipe(58329, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(150, 150, 155, 160, 165)
    recipe:SetCraftedItem(43381, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER, F.SHAMAN)
    recipe:AddDiscovery("DISCOVERY_INSC_MINOR")

    -- Glyph of Far Sight -- 58330
    recipe = AddRecipe(58330, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(150, 150, 155, 160, 165)
    recipe:SetCraftedItem(43385, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.SHAMAN)
    recipe:AddDiscovery("DISCOVERY_INSC_MINOR")

    -- Glyph of Healing Storm -- 58331
    recipe = AddRecipe(58331, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(120, 120, 130, 135, 140)
    recipe:SetCraftedItem(43344, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.SHAMAN)
    recipe:AddDiscovery("DISCOVERY_INSC_MINOR")

    -- Glyph of the Spectral Wolf -- 58332
    recipe = AddRecipe(58332, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(95, 95, 105, 110, 115)
    recipe:SetCraftedItem(43386, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.SHAMAN)
    recipe:AddDiscovery("DISCOVERY_INSC_MINOR")

    -- Glyph of Totemic Encirclement -- 58333
    recipe = AddRecipe(58333, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(150, 150, 155, 160, 165)
    recipe:SetCraftedItem(43388, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.SHAMAN)
    recipe:AddDiscovery("DISCOVERY_INSC_MINOR")

    -- Glyph of Unending Breath -- 58336
    recipe = AddRecipe(58336, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(95, 95, 105, 110, 115)
    recipe:SetCraftedItem(43389, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARLOCK)
    recipe:AddDiscovery("DISCOVERY_INSC_MINOR")

    -- Glyph of Soul Consumption -- 58337
    recipe = AddRecipe(58337, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(75, 75, 80, 85, 90)
    recipe:SetCraftedItem(43390, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.CASTER, F.WARLOCK)
    recipe:AddDiscovery("DISCOVERY_INSC_MINOR")

    -- Glyph of Curse of Exhaustion -- 58338
    recipe = AddRecipe(58338, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(150, 150, 155, 160, 165)
    recipe:SetCraftedItem(43392, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.CASTER, F.WARLOCK)
    recipe:AddDiscovery("DISCOVERY_INSC_MINOR")

    -- Glyph of Enslave Demon -- 58339
    recipe = AddRecipe(58339, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(150, 150, 155, 160, 165)
    recipe:SetCraftedItem(43393, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.CASTER, F.WARLOCK)
    recipe:AddDiscovery("DISCOVERY_INSC_MINOR")

    -- Glyph of Eye of Kilrogg -- 58340
    recipe = AddRecipe(58340, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(120, 120, 130, 135, 140)
    recipe:SetCraftedItem(43391, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.CASTER, F.WARLOCK)
    recipe:AddDiscovery("DISCOVERY_INSC_MINOR")

    -- Glyph of Soulwell -- 58341
    recipe = AddRecipe(58341, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(345, 345, 355, 360, 365)
    recipe:SetCraftedItem(43394, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.CASTER, F.WARLOCK)
    recipe:AddDiscovery("DISCOVERY_INSC_MINOR")

    -- Glyph of Mystic Shout -- 58342
    recipe = AddRecipe(58342, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(75, 75, 80, 85, 90)
    recipe:SetCraftedItem(43395, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARRIOR)
    recipe:AddDiscovery("DISCOVERY_INSC_MINOR")

    -- Glyph of Bloodcurdling Shout -- 58343
    recipe = AddRecipe(58343, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(75, 75, 80, 85, 90)
    recipe:SetCraftedItem(43396, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARRIOR)
    recipe:AddDiscovery("DISCOVERY_INSC_MINOR")

    -- Glyph of Long Charge -- 58344
    recipe = AddRecipe(58344, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(80, 80, 90, 95, 100)
    recipe:SetCraftedItem(43397, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARRIOR)
    recipe:AddTrainer(26916, 26977, 26995, 28702, 30706, 30709, 30713, 30715, 30716, 30717, 30721, 33603, 33615, 33638,
        46716, 53415, 56065, 62327, 64691, 66355)
    recipe:AddDiscovery("DISCOVERY_INSC_MINOR")

    -- Glyph of Gushing Wound -- 58345
    recipe = AddRecipe(58345, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(95, 95, 105, 110, 115)
    recipe:SetCraftedItem(43398, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARRIOR)
    recipe:AddDiscovery("DISCOVERY_INSC_MINOR")

    -- Glyph of Unending Rage -- 58346
    recipe = AddRecipe(58346, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(80, 80, 90, 95, 100)
    recipe:SetCraftedItem(43399, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARRIOR)
    recipe:AddTrainer(26916, 26977, 26995, 28702, 30706, 30709, 30713, 30715, 30716, 30717, 30721, 33603, 33615, 33638,
        46716, 53415, 56065, 62327, 64691, 66355)
    recipe:AddDiscovery("DISCOVERY_INSC_MINOR")

    -- Glyph of Mighty Victory -- 58347
    recipe = AddRecipe(58347, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(320, 320, 330, 335, 340)
    recipe:SetCraftedItem(43400, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARRIOR)
    recipe:AddDiscovery("DISCOVERY_INSC_MINOR")

    -- Scroll of Agility -- 58472
    recipe = AddRecipe(58472, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(15, 15, 35, 40, 45)
    recipe:SetCraftedItem(3012, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_SCROLL")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.TANK)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 47384, 47396, 47400, 47418, 47419, 47420, 47431, 48619, 53415, 56065,
        57620, 62327, 64691, 65043, 66355)

    -- Scroll of Agility II -- 58473
    recipe = AddRecipe(58473, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(85, 85, 85, 90, 95)
    recipe:SetCraftedItem(1477, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_SCROLL")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.TANK)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Scroll of Agility III -- 58476
    recipe = AddRecipe(58476, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(175, 175, 180, 185, 190)
    recipe:SetCraftedItem(4425, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_SCROLL")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.TANK)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Scroll of Agility IV -- 58478
    recipe = AddRecipe(58478, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(225, 225, 230, 235, 240)
    recipe:SetCraftedItem(10309, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_SCROLL")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.TANK)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Scroll of Agility V -- 58480
    recipe = AddRecipe(58480, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(270, 270, 275, 280, 285)
    recipe:SetCraftedItem(27498, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_SCROLL")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.TANK)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Scroll of Agility VI -- 58481
    recipe = AddRecipe(58481, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(310, 310, 320, 325, 330)
    recipe:SetCraftedItem(33457, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_SCROLL")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.TANK)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Scroll of Agility VII -- 58482
    recipe = AddRecipe(58482, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(370, 370, 375, 380, 385)
    recipe:SetCraftedItem(43463, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_SCROLL")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.TANK)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30713, 30715, 30716, 30717, 30721, 33603, 33615,
        33638, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Scroll of Agility VIII -- 58483
    recipe = AddRecipe(58483, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(420, 420, 425, 430, 435)
    recipe:SetCraftedItem(43464, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_SCROLL")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.TANK)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30713, 30715, 30716, 30717, 30721, 33603, 33615,
        33638, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Scroll of Strength -- 58484
    recipe = AddRecipe(58484, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(15, 15, 35, 40, 45)
    recipe:SetCraftedItem(954, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_SCROLL")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.TANK)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 47384, 47396, 47400, 47418, 47419, 47420, 47431, 48619, 53415, 56065,
        57620, 62327, 64691, 65043, 66355)

    -- Scroll of Strength II -- 58485
    recipe = AddRecipe(58485, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(80, 80, 80, 85, 90)
    recipe:SetCraftedItem(2289, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_SCROLL")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.TANK)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Scroll of Strength III -- 58486
    recipe = AddRecipe(58486, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(170, 170, 175, 180, 185)
    recipe:SetCraftedItem(4426, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_SCROLL")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.TANK)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Scroll of Strength IV -- 58487
    recipe = AddRecipe(58487, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(220, 220, 225, 230, 235)
    recipe:SetCraftedItem(10310, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_SCROLL")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.TANK)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Scroll of Strength V -- 58488
    recipe = AddRecipe(58488, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(265, 265, 270, 275, 280)
    recipe:SetCraftedItem(27503, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_SCROLL")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.TANK)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Scroll of Strength VI -- 58489
    recipe = AddRecipe(58489, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(305, 305, 315, 320, 325)
    recipe:SetCraftedItem(33462, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_SCROLL")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.TANK)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Scroll of Strength VII -- 58490
    recipe = AddRecipe(58490, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(365, 365, 370, 375, 380)
    recipe:SetCraftedItem(43465, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_SCROLL")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.TANK)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30713, 30715, 30716, 30717, 30721, 33603, 33615,
        33638, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Scroll of Strength VIII -- 58491
    recipe = AddRecipe(58491, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(415, 415, 420, 425, 430)
    recipe:SetCraftedItem(43466, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_SCROLL")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.TANK)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30713, 30715, 30716, 30717, 30721, 33603, 33615,
        33638, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Mystic Tome -- 58565
    recipe = AddRecipe(58565, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(85, 85, 95, 100, 105)
    recipe:SetCraftedItem(43515, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_OFF_HAND")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Dash -- 59315
    recipe = AddRecipe(59315, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(150, 150, 155, 160, 165)
    recipe:SetCraftedItem(43674, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DRUID)
    recipe:AddDiscovery("DISCOVERY_INSC_MINOR")

    -- Glyph of Ghost Wolf -- 59326
    recipe = AddRecipe(59326, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(100, 100, 110, 115, 120)
    recipe:SetCraftedItem(43725, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.SHAMAN)
    recipe:AddTrainer(26916, 26977, 26995, 28702, 30706, 30709, 30713, 30715, 30716, 30717, 30721, 33603, 33615, 33638,
        46716, 53415, 56065, 62327, 64691, 66355)
    recipe:AddDiscovery("DISCOVERY_INSC_MINOR")

    -- Glyph of Unholy Command -- 59338
    recipe = AddRecipe(59338, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(310, 310, 315, 320, 325)
    recipe:SetCraftedItem(43825, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DK)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30713, 30715, 30716, 30717, 30721, 30722, 33603,
        33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Outbreak -- 59339
    recipe = AddRecipe(59339, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(320, 320, 325, 330, 335)
    recipe:SetCraftedItem(43826, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DK)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30713, 30715, 30716, 30717, 30721, 30722, 33603,
        33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Corpse Explosion -- 59340
    recipe = AddRecipe(59340, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(340, 340, 345, 350, 355)
    recipe:SetCraftedItem(43827, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DK)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30713, 30715, 30716, 30717, 30721, 30722, 33603,
        33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Certificate of Ownership -- 59387
    recipe = AddRecipe(59387, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(200, 200, 205, 210, 215)
    recipe:SetCraftedItem(43850, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_CREATED_ITEM")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HUNTER)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Tome of the Dawn -- 59475
    recipe = AddRecipe(59475, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(125, 125, 150, 162, 175)
    recipe:SetCraftedItem(43654, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_OFF_HAND")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Book of Survival -- 59478
    recipe = AddRecipe(59478, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(125, 125, 150, 162, 175)
    recipe:SetCraftedItem(43655, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_OFF_HAND")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Strange Tarot -- 59480
    recipe = AddRecipe(59480, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(125, 125, 150, 162, 175)
    recipe:SetCraftedItem(44142, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_CREATED_ITEM")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Tome of Kings -- 59484
    recipe = AddRecipe(59484, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(175, 175, 200, 205, 210)
    recipe:SetCraftedItem(43656, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_OFF_HAND")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Royal Guide of Escape Routes -- 59486
    recipe = AddRecipe(59486, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(175, 175, 200, 205, 210)
    recipe:SetCraftedItem(43657, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_OFF_HAND")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Arcane Tarot -- 59487
    recipe = AddRecipe(59487, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(175, 175, 200, 205, 210)
    recipe:SetCraftedItem(44161, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_CREATED_ITEM")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Fire Eater's Guide -- 59489
    recipe = AddRecipe(59489, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(225, 225, 240, 245, 250)
    recipe:SetCraftedItem(43660, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_OFF_HAND")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Book of Stars -- 59490
    recipe = AddRecipe(59490, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(225, 225, 240, 245, 250)
    recipe:SetCraftedItem(43661, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_OFF_HAND")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Shadowy Tarot -- 59491
    recipe = AddRecipe(59491, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(225, 225, 240, 245, 250)
    recipe:SetCraftedItem(44163, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_CREATED_ITEM")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Stormbound Tome -- 59493
    recipe = AddRecipe(59493, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(275, 275, 290, 295, 300)
    recipe:SetCraftedItem(43663, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_OFF_HAND")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Manual of Clouds -- 59494
    recipe = AddRecipe(59494, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(275, 275, 290, 295, 300)
    recipe:SetCraftedItem(43664, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_OFF_HAND")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Hellfire Tome -- 59495
    recipe = AddRecipe(59495, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(325, 325, 340, 345, 350)
    recipe:SetCraftedItem(43666, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_OFF_HAND")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30713, 30715, 30716, 30717, 30721, 30722, 33603,
        33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Book of Clever Tricks -- 59496
    recipe = AddRecipe(59496, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(325, 325, 340, 345, 350)
    recipe:SetCraftedItem(43667, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_OFF_HAND")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30713, 30715, 30716, 30717, 30721, 30722, 33603,
        33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Iron-bound Tome -- 59497
    recipe = AddRecipe(59497, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(400, 400, 425, 437, 450)
    recipe:SetCraftedItem(38322, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_OFF_HAND")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30713, 30715, 30716, 30717, 30721, 33603, 33615,
        33638, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Faces of Doom -- 59498
    recipe = AddRecipe(59498, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(400, 400, 425, 437, 450)
    recipe:SetCraftedItem(44210, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_OFF_HAND")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30713, 30715, 30716, 30717, 30721, 33603, 33615,
        33638, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Darkmoon Card -- 59502
    recipe = AddRecipe(59502, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(275, 275, 290, 295, 300)
    recipe:SetCraftedItem(44316, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_CREATED_ITEM")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Greater Darkmoon Card -- 59503
    recipe = AddRecipe(59503, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(325, 325, 340, 345, 350)
    recipe:SetCraftedItem(44317, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_CREATED_ITEM")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30713, 30715, 30716, 30717, 30721, 30722, 33603,
        33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Darkmoon Card of the North -- 59504
    recipe = AddRecipe(59504, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(400, 400, 425, 450, 475)
    recipe:SetCraftedItem(44318, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_CREATED_ITEM")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30713, 30715, 30716, 30717, 30721, 33603, 33615,
        33638, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Denounce -- 59559
    recipe = AddRecipe(59559, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(385, 385, 390, 397, 405)
    recipe:SetCraftedItem(43867, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PALADIN)
    recipe:AddDiscovery("DISCOVERY_INSC_NORTHREND", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Dazing Shield -- 59560
    recipe = AddRecipe(59560, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(385, 385, 390, 397, 405)
    recipe:SetCraftedItem(43868, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PALADIN)
    recipe:AddDiscovery("DISCOVERY_INSC_NORTHREND", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Immediate Truth -- 59561
    recipe = AddRecipe(59561, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(385, 385, 390, 397, 405)
    recipe:SetCraftedItem(43869, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.PALADIN)
    recipe:AddDiscovery("DISCOVERY_INSC_NORTHREND", "DISCOVERY_INSC_PANDARIA")

    -- Scroll of Recall II -- 60336
    recipe = AddRecipe(60336, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(200, 200, 215, 220, 225)
    recipe:SetCraftedItem(44314, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_SCROLL")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Scroll of Recall III -- 60337
    recipe = AddRecipe(60337, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(350, 350, 350, 350, 355)
    recipe:SetCraftedItem(44315, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_SCROLL")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30713, 30715, 30716, 30717, 30721, 33603, 33615,
        33638, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Master's Inscription of the Axe -- 61117
    recipe = AddRecipe(61117, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(400, 400, 400, 400, 405)
    recipe:SetItemFilterType("INSCRIPTION_ITEM_ENHANCEMENT")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30713, 30715, 30716, 30717, 30721, 33603, 33615,
        33638, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Master's Inscription of the Crag -- 61118
    recipe = AddRecipe(61118, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(400, 400, 400, 400, 405)
    recipe:SetItemFilterType("INSCRIPTION_ITEM_ENHANCEMENT")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30713, 30715, 30716, 30717, 30721, 33603, 33615,
        33638, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Master's Inscription of the Pinnacle -- 61119
    recipe = AddRecipe(61119, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(400, 400, 400, 400, 405)
    recipe:SetItemFilterType("INSCRIPTION_ITEM_ENHANCEMENT")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.TANK)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30713, 30715, 30716, 30717, 30721, 33603, 33615,
        33638, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Master's Inscription of the Storm -- 61120
    recipe = AddRecipe(61120, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(400, 400, 400, 400, 405)
    recipe:SetItemFilterType("INSCRIPTION_ITEM_ENHANCEMENT")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30713, 30715, 30716, 30717, 30721, 33603, 33615,
        33638, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Northrend Inscription Research -- 61177
    recipe = AddRecipe(61177, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(385, 385, 425, 437, 450)
    recipe:SetItemFilterType("INSCRIPTION_CREATED_ITEM")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30713, 30715, 30716, 30717, 30721, 33603, 33615,
        33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Minor Inscription Research -- 61288
    recipe = AddRecipe(61288, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(75, 75, 125, 137, 150)
    recipe:SetItemFilterType("INSCRIPTION_CREATED_ITEM")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 47384, 47396, 47400, 47418, 47419, 47420, 47431, 48619, 53415, 56065,
        57620, 62327, 64691, 65043, 66355)

    -- Glyph of Frostfire Bolt -- 61677
    recipe = AddRecipe(61677, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(385, 385, 390, 397, 405)
    recipe:SetCraftedItem(44684, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MAGE)
    recipe:AddDiscovery("DISCOVERY_INSC_NORTHREND", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of the Master Shapeshifter -- 62162
    recipe = AddRecipe(62162, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(375, 375, 380, 385, 390)
    recipe:SetCraftedItem(44928, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DRUID)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30713, 30715, 30716, 30717, 30721, 33603, 33615,
        33638, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Rituals of the New Moon -- 64051
    recipe = AddRecipe(64051, V.WOTLK, Q.UNCOMMON)
    recipe:SetSkillLevels(350, 350, 375, 387, 400)
    recipe:SetRecipeItem(46108, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(46108, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_OFF_HAND")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
    recipe:AddMobDrop(26679, 26708, 27546, 27676)

    -- Twilight Tome -- 64053
    recipe = AddRecipe(64053, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(350, 350, 375, 387, 400)
    recipe:SetCraftedItem(45849, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_OFF_HAND")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30713, 30715, 30716, 30717, 30721, 33603, 33615,
        33638, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Mirrored Blades -- 64246
    recipe = AddRecipe(64246, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(425, 425, 430, 435, 440)
    recipe:SetCraftedItem(45735, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HUNTER)
    recipe:AddDiscovery("DISCOVERY_INSC_BOOK", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Totemic Vigor -- 64247
    recipe = AddRecipe(64247, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(425, 425, 430, 435, 440)
    recipe:SetCraftedItem(45778, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.SHAMAN)
    recipe:AddDiscovery("DISCOVERY_INSC_BOOK", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Life Tap -- 64248
    recipe = AddRecipe(64248, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(425, 425, 430, 435, 440)
    recipe:SetCraftedItem(45785, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.CASTER, F.WARLOCK)
    recipe:AddDiscovery("DISCOVERY_INSC_BOOK", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Scatter Shot -- 64249
    recipe = AddRecipe(64249, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(425, 425, 430, 435, 440)
    recipe:SetCraftedItem(45734, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HUNTER)
    recipe:AddDiscovery("DISCOVERY_INSC_BOOK", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Crimson Banish -- 64250
    recipe = AddRecipe(64250, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(425, 425, 430, 435, 440)
    recipe:SetCraftedItem(45789, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARLOCK)
    recipe:AddDiscovery("DISCOVERY_INSC_BOOK", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Inquisition -- 64251
    recipe = AddRecipe(64251, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(425, 425, 430, 435, 440)
    recipe:SetCraftedItem(45747, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PALADIN)
    recipe:AddDiscovery("DISCOVERY_INSC_BOOK", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Shield Wall -- 64252
    recipe = AddRecipe(64252, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(425, 425, 430, 435, 440)
    recipe:SetCraftedItem(45797, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARRIOR)
    recipe:AddDiscovery("DISCOVERY_INSC_BOOK", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Master's Call -- 64253
    recipe = AddRecipe(64253, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(425, 425, 430, 435, 440)
    recipe:SetCraftedItem(45733, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HUNTER)
    recipe:AddDiscovery("DISCOVERY_INSC_BOOK", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Holy Shock -- 64254
    recipe = AddRecipe(64254, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(425, 425, 430, 435, 440)
    recipe:SetCraftedItem(45746, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PALADIN)
    recipe:AddDiscovery("DISCOVERY_INSC_BOOK", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Victorious Throw -- 64255
    recipe = AddRecipe(64255, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(425, 425, 430, 435, 440)
    recipe:SetCraftedItem(45793, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARRIOR)
    recipe:AddDiscovery("DISCOVERY_INSC_MINOR")

    -- Glyph of Barkskin -- 64256
    recipe = AddRecipe(64256, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(425, 425, 430, 435, 440)
    recipe:SetCraftedItem(45623, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DRUID)
    recipe:AddDiscovery("DISCOVERY_INSC_BOOK", "DISCOVERY_INSC_NORTHREND", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Deep Freeze -- 64257
    recipe = AddRecipe(64257, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(425, 425, 430, 435, 440)
    recipe:SetCraftedItem(45740, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MAGE)
    recipe:AddDiscovery("DISCOVERY_INSC_BOOK", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Cyclone -- 64258
    recipe = AddRecipe(64258, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(250, 250, 255, 262, 270)
    recipe:SetCraftedItem(45622, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DRUID)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Binding Heal -- 64259
    recipe = AddRecipe(64259, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(255, 255, 255, 262, 270)
    recipe:SetCraftedItem(45760, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PRIEST)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Disguise -- 64260
    recipe = AddRecipe(64260, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(255, 255, 255, 262, 270)
    recipe:SetCraftedItem(45768, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.ROGUE)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Deluge -- 64261
    recipe = AddRecipe(64261, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(250, 250, 255, 262, 270)
    recipe:SetCraftedItem(45775, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.SHAMAN)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Shamanistic Rage -- 64262
    recipe = AddRecipe(64262, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(255, 255, 255, 262, 270)
    recipe:SetCraftedItem(45776, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.SHAMAN)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Death Coil -- 64266
    recipe = AddRecipe(64266, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(275, 275, 280, 287, 295)
    recipe:SetCraftedItem(45804, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DK)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Survival Instincts -- 64268
    recipe = AddRecipe(64268, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(425, 425, 430, 435, 440)
    recipe:SetCraftedItem(45601, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DRUID)
    recipe:AddDiscovery("DISCOVERY_INSC_BOOK", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Wild Growth -- 64270
    recipe = AddRecipe(64270, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(425, 425, 430, 435, 440)
    recipe:SetCraftedItem(45602, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DRUID)
    recipe:AddDiscovery("DISCOVERY_INSC_BOOK", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Chimera Shot -- 64271
    recipe = AddRecipe(64271, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(425, 425, 430, 435, 440)
    recipe:SetCraftedItem(45625, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HUNTER)
    recipe:AddDiscovery("DISCOVERY_INSC_BOOK", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Tranquilizing Shot -- 64273
    recipe = AddRecipe(64273, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(425, 425, 430, 435, 440)
    recipe:SetCraftedItem(45731, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HUNTER)
    recipe:AddDiscovery("DISCOVERY_INSC_BOOK", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Water Elemental -- 64274
    recipe = AddRecipe(64274, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(425, 425, 430, 435, 440)
    recipe:SetCraftedItem(45736, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MAGE)
    recipe:AddDiscovery("DISCOVERY_INSC_BOOK", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Slow -- 64275
    recipe = AddRecipe(64275, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(425, 425, 430, 435, 440)
    recipe:SetCraftedItem(45737, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MAGE)
    recipe:AddDiscovery("DISCOVERY_INSC_BOOK", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Illusion -- 64276
    recipe = AddRecipe(64276, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(425, 425, 430, 435, 440)
    recipe:SetCraftedItem(45738, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MAGE)
    recipe:AddDiscovery("DISCOVERY_INSC_BOOK", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Beacon of Light -- 64277
    recipe = AddRecipe(64277, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(425, 425, 430, 435, 440)
    recipe:SetCraftedItem(45741, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PALADIN)
    recipe:AddDiscovery("DISCOVERY_INSC_BOOK", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Hammer of the Righteous -- 64278
    recipe = AddRecipe(64278, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(425, 425, 430, 435, 440)
    recipe:SetCraftedItem(45742, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PALADIN)
    recipe:AddDiscovery("DISCOVERY_INSC_BOOK", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Divine Storm -- 64279
    recipe = AddRecipe(64279, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(425, 425, 430, 435, 440)
    recipe:SetCraftedItem(45743, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PALADIN)
    recipe:AddDiscovery("DISCOVERY_INSC_BOOK", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Dispersion -- 64280
    recipe = AddRecipe(64280, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(425, 425, 430, 435, 440)
    recipe:SetCraftedItem(45753, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PRIEST)
    recipe:AddDiscovery("DISCOVERY_INSC_BOOK", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Leap of Faith -- 64281
    recipe = AddRecipe(64281, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(425, 425, 430, 435, 440)
    recipe:SetCraftedItem(45755, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER, F.PRIEST)
    recipe:AddDiscovery("DISCOVERY_INSC_BOOK", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Penance -- 64282
    recipe = AddRecipe(64282, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(425, 425, 430, 435, 440)
    recipe:SetCraftedItem(45756, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PRIEST)
    recipe:AddDiscovery("DISCOVERY_INSC_BOOK", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Mind Spike -- 64283
    recipe = AddRecipe(64283, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(425, 425, 430, 435, 440)
    recipe:SetCraftedItem(45758, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PRIEST)
    recipe:AddDiscovery("DISCOVERY_INSC_BOOK", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Vendetta -- 64284
    recipe = AddRecipe(64284, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(425, 425, 430, 435, 440)
    recipe:SetCraftedItem(45761, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.ROGUE)
    recipe:AddDiscovery("DISCOVERY_INSC_BOOK", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Killing Spree -- 64285
    recipe = AddRecipe(64285, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(425, 425, 430, 435, 440)
    recipe:SetCraftedItem(45762, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.ROGUE)
    recipe:AddDiscovery("DISCOVERY_INSC_BOOK", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Stealth -- 64286
    recipe = AddRecipe(64286, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(425, 425, 430, 435, 440)
    recipe:SetCraftedItem(45764, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.ROGUE)
    recipe:AddDiscovery("DISCOVERY_INSC_BOOK", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Thunder -- 64287
    recipe = AddRecipe(64287, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(425, 425, 430, 435, 440)
    recipe:SetCraftedItem(45770, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.SHAMAN)
    recipe:AddDiscovery("DISCOVERY_INSC_BOOK", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Feral Spirit -- 64288
    recipe = AddRecipe(64288, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(425, 425, 430, 435, 440)
    recipe:SetCraftedItem(45771, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER, F.SHAMAN)
    recipe:AddDiscovery("DISCOVERY_INSC_BOOK", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Riptide -- 64289
    recipe = AddRecipe(64289, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(425, 425, 430, 435, 440)
    recipe:SetCraftedItem(45772, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.SHAMAN)
    recipe:AddDiscovery("DISCOVERY_INSC_BOOK", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Drain Life -- 64291
    recipe = AddRecipe(64291, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(425, 425, 430, 435, 440)
    recipe:SetCraftedItem(45779, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARLOCK)
    recipe:AddDiscovery("DISCOVERY_INSC_BOOK", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Ember Tap -- 64294
    recipe = AddRecipe(64294, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(425, 425, 430, 435, 440)
    recipe:SetCraftedItem(45781, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARLOCK)
    recipe:AddDiscovery("DISCOVERY_INSC_BOOK", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Whirlwind -- 64295
    recipe = AddRecipe(64295, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(425, 425, 430, 435, 440)
    recipe:SetCraftedItem(45790, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARRIOR)
    recipe:AddDiscovery("DISCOVERY_INSC_BOOK", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Death From Above -- 64296
    recipe = AddRecipe(64296, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(425, 425, 430, 435, 440)
    recipe:SetCraftedItem(45792, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARRIOR)
    recipe:AddDiscovery("DISCOVERY_INSC_BOOK", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Dancing Rune Weapon -- 64297
    recipe = AddRecipe(64297, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(425, 425, 430, 435, 440)
    recipe:SetCraftedItem(45799, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DK)
    recipe:AddDiscovery("DISCOVERY_INSC_BOOK", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Dark Simulacrum -- 64298
    recipe = AddRecipe(64298, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(425, 425, 430, 435, 440)
    recipe:SetCraftedItem(45800, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DK)
    recipe:AddDiscovery("DISCOVERY_INSC_BOOK", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Tranquil Grip -- 64300
    recipe = AddRecipe(64300, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(425, 425, 430, 435, 440)
    recipe:SetCraftedItem(45806, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DK)
    recipe:AddDiscovery("DISCOVERY_INSC_BOOK", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Spell Reflection -- 64302
    recipe = AddRecipe(64302, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(425, 425, 430, 435, 440)
    recipe:SetCraftedItem(45795, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARRIOR)
    recipe:AddDiscovery("DISCOVERY_INSC_BOOK", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Cloak of Shadows -- 64303
    recipe = AddRecipe(64303, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(425, 425, 430, 435, 440)
    recipe:SetCraftedItem(45769, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.ROGUE)
    recipe:AddDiscovery("DISCOVERY_INSC_BOOK", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Aspect of the Cheetah -- 64304
    recipe = AddRecipe(64304, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(425, 425, 430, 435, 440)
    recipe:SetCraftedItem(45732, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HUNTER)
    recipe:AddDiscovery("DISCOVERY_INSC_BOOK", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Divine Plea -- 64305
    recipe = AddRecipe(64305, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(425, 425, 430, 435, 440)
    recipe:SetCraftedItem(45745, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PALADIN)
    recipe:AddDiscovery("DISCOVERY_INSC_BOOK", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Stampeding Roar -- 64307
    recipe = AddRecipe(64307, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(425, 425, 430, 435, 440)
    recipe:SetCraftedItem(45604, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DRUID)
    recipe:AddDiscovery("DISCOVERY_INSC_BOOK", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of the Alabaster Shield -- 64308
    recipe = AddRecipe(64308, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(425, 425, 430, 435, 440)
    recipe:SetCraftedItem(45744, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PALADIN)
    recipe:AddDiscovery("DISCOVERY_INSC_BOOK", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Focused Mending -- 64309
    recipe = AddRecipe(64309, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(425, 425, 430, 435, 440)
    recipe:SetCraftedItem(45757, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PRIEST)
    recipe:AddDiscovery("DISCOVERY_INSC_BOOK", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Tricks of the Trade -- 64310
    recipe = AddRecipe(64310, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(425, 425, 430, 435, 440)
    recipe:SetCraftedItem(45767, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.ROGUE)
    recipe:AddDiscovery("DISCOVERY_INSC_BOOK", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Unending Resolve -- 64311
    recipe = AddRecipe(64311, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(425, 425, 430, 435, 440)
    recipe:SetCraftedItem(45783, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARLOCK)
    recipe:AddDiscovery("DISCOVERY_INSC_BOOK", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Intimidating Shout -- 64312
    recipe = AddRecipe(64312, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(425, 425, 430, 435, 440)
    recipe:SetCraftedItem(45794, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARRIOR)
    recipe:AddDiscovery("DISCOVERY_INSC_MINOR")

    -- Glyph of Might of Ursoc -- 64313
    recipe = AddRecipe(64313, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(425, 425, 430, 435, 440)
    recipe:SetCraftedItem(45603, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DRUID)
    recipe:AddDiscovery("DISCOVERY_INSC_BOOK", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Mirror Image -- 64314
    recipe = AddRecipe(64314, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(425, 425, 430, 435, 440)
    recipe:SetCraftedItem(45739, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MAGE)
    recipe:AddDiscovery("DISCOVERY_INSC_BOOK", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Deadly Momentum -- 64315
    recipe = AddRecipe(64315, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(425, 425, 430, 435, 440)
    recipe:SetCraftedItem(45766, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.ROGUE)
    recipe:AddDiscovery("DISCOVERY_INSC_BOOK", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Hex -- 64316
    recipe = AddRecipe(64316, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(425, 425, 430, 435, 440)
    recipe:SetCraftedItem(45777, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.SHAMAN)
    recipe:AddDiscovery("DISCOVERY_INSC_BOOK", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Demonic Circle -- 64317
    recipe = AddRecipe(64317, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(425, 425, 430, 435, 440)
    recipe:SetCraftedItem(45782, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARLOCK)
    recipe:AddDiscovery("DISCOVERY_INSC_BOOK", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Demon Hunting -- 64318
    recipe = AddRecipe(64318, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(425, 425, 430, 435, 440)
    recipe:SetCraftedItem(45780, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARLOCK)
    recipe:AddDiscovery("DISCOVERY_INSC_BOOK", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Ferocious Bite -- 67600
    recipe = AddRecipe(67600, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(100, 100, 105, 110, 115)
    recipe:SetCraftedItem(48720, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DRUID)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30713, 30715, 30716, 30717, 30721, 30722,
        33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Thunder Strike -- 68166
    recipe = AddRecipe(68166, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(355, 355, 355, 360, 365)
    recipe:SetCraftedItem(49084, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARRIOR)
    recipe:AddDiscovery("DISCOVERY_INSC_MINOR")

    -- Runescroll of Fortitude -- 69385
    recipe = AddRecipe(69385, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(440, 440, 440, 442, 460)
    recipe:SetCraftedItem(49632, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_SCROLL")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30713, 30715, 30716, 30717, 30721, 33603, 33615,
        33638, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Counterspell -- 71101
    recipe = AddRecipe(71101, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(250, 250, 255, 260, 265)
    recipe:SetRecipeItem(50166, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(50045, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MAGE)
    recipe:AddTrainer(26916, 26977, 26995, 28702, 30706, 30709, 30713, 30715, 30716, 30717, 30721, 33603, 33615, 33638,
        46716, 53415, 56065, 62327, 64691, 66355)
    recipe:AddVendor(28723, 30735)
    recipe:AddLimitedVendor(30734, 2)

    -- Glyph of Eternal Resolve -- 71102
    recipe = AddRecipe(71102, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(375, 375, 380, 382, 385)
    recipe:SetRecipeItem(50168, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(50077, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARLOCK)
    recipe:AddTrainer(26916, 26977, 26995, 28702, 30706, 30709, 30713, 30715, 30716, 30717, 30721, 33603, 33615, 33638,
        46716, 53415, 56065, 62327, 64691, 66355)
    recipe:AddVendor(28723)

    -- Glyph of Inferno Blast -- 94000
    recipe = AddRecipe(94000, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(390, 390, 390, 397, 405)
    recipe:SetCraftedItem(63539, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.CASTER, F.MAGE)
    recipe:AddDiscovery("DISCOVERY_INSC_NORTHREND", "DISCOVERY_INSC_PANDARIA")

    -------------------------------------------------------------------------------
    -- Cataclysm.
    -------------------------------------------------------------------------------
    -- Runescroll of Fortitude II -- 85785
    recipe = AddRecipe(85785, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(500, 500, 505, 510, 515)
    recipe:SetCraftedItem(62251, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_SCROLL")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(26916, 26977, 26995, 28702, 30706, 30709, 30711, 30713, 30715, 30716, 30717, 30721, 33603, 33615,
        33638, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Blackfallow Ink -- 86004
    recipe = AddRecipe(86004, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(425, 425, 440, 445, 450)
    recipe:SetCraftedItem(61978, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MATERIALS")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(26916, 26977, 26995, 28702, 30706, 30709, 30711, 30713, 30715, 30716, 30717, 30721, 33603, 33615,
        33638, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Inferno Ink -- 86005
    recipe = AddRecipe(86005, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(475, 475, 480, 482, 485)
    recipe:SetCraftedItem(61981, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MATERIALS")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(26916, 26977, 26995, 28702, 30706, 30709, 30711, 30713, 30715, 30716, 30717, 30721, 33603, 33615,
        33638, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Swiftsteel Inscription -- 86375
    recipe = AddRecipe(86375, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(500, 500, 500, 500, 505)
    recipe:SetItemFilterType("INSCRIPTION_ITEM_ENHANCEMENT")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(26916, 26977, 26995, 28702, 30706, 30709, 30711, 30713, 30715, 30716, 30717, 30721, 33603, 33615,
        33638, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Lionsmane Inscription -- 86401
    recipe = AddRecipe(86401, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(500, 500, 500, 500, 505)
    recipe:SetItemFilterType("INSCRIPTION_ITEM_ENHANCEMENT")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(26916, 26977, 26995, 28702, 30706, 30709, 30711, 30713, 30715, 30716, 30717, 30721, 33603, 33615,
        33638, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Inscription of the Earth Prince -- 86402
    recipe = AddRecipe(86402, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(500, 500, 500, 500, 505)
    recipe:SetItemFilterType("INSCRIPTION_ITEM_ENHANCEMENT")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(26916, 26977, 26995, 28702, 30706, 30709, 30711, 30713, 30715, 30716, 30717, 30721, 33603, 33615,
        33638, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Felfire Inscription -- 86403
    recipe = AddRecipe(86403, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(500, 500, 500, 500, 505)
    recipe:SetItemFilterType("INSCRIPTION_ITEM_ENHANCEMENT")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(26916, 26977, 26995, 28702, 30706, 30709, 30711, 30713, 30715, 30716, 30717, 30721, 33603, 33615,
        33638, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Mysterious Fortune Card -- 86609
    recipe = AddRecipe(86609, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(450, 450, 460, 467, 475)
    recipe:SetCraftedItem(60838, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_CREATED_ITEM")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(26916, 26977, 26995, 28702, 30706, 30709, 30711, 30713, 30715, 30716, 30717, 30721, 33603, 33615,
        33638, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Darkmoon Card of Destruction -- 86615
    recipe = AddRecipe(86615, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(525, 525, 525, 530, 535)
    recipe:SetCraftedItem(61987, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_CREATED_ITEM")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(26916, 26977, 26995, 28702, 30706, 30709, 30711, 30713, 30715, 30716, 30717, 30721, 33603, 33615,
        33638, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Book of Blood -- 86616
    recipe = AddRecipe(86616, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(475, 475, 485, 487, 490)
    recipe:SetCraftedItem(62231, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_OFF_HAND")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(26916, 26977, 26995, 28702, 30706, 30709, 30711, 30713, 30715, 30716, 30717, 30721, 33603, 33615,
        33638, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Lord Rottington's Pressed Wisp Book -- 86640
    recipe = AddRecipe(86640, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(475, 475, 485, 487, 490)
    recipe:SetCraftedItem(62233, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_OFF_HAND")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(26916, 26977, 26995, 28702, 30706, 30709, 30711, 30713, 30715, 30716, 30717, 30721, 33603, 33615,
        33638, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Dungeoneering Guide -- 86641
    recipe = AddRecipe(86641, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(510, 510, 520, 525, 530)
    recipe:SetCraftedItem(62234, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_OFF_HAND")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(26916, 26977, 26995, 28702, 30706, 30709, 30711, 30713, 30715, 30716, 30717, 30721, 33603, 33615,
        33638, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Divine Companion -- 86642
    recipe = AddRecipe(86642, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(510, 510, 520, 525, 530)
    recipe:SetCraftedItem(62235, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_OFF_HAND")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(26916, 26977, 26995, 28702, 30706, 30709, 30711, 30713, 30715, 30716, 30717, 30721, 33603, 33615,
        33638, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Battle Tome -- 86643
    recipe = AddRecipe(86643, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(510, 510, 520, 525, 530)
    recipe:SetCraftedItem(62236, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_OFF_HAND")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(26916, 26977, 26995, 28702, 30706, 30709, 30711, 30713, 30715, 30716, 30717, 30721, 33603, 33615,
        33638, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Origami Slime -- 86644
    recipe = AddRecipe(86644, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(480, 480, 480, 480, 490)
    recipe:SetRecipeItem(65649, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(62239, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_CREATED_ITEM")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddWorldDrop(Z.VASHJIR)

    -- Origami Rock -- 86645
    recipe = AddRecipe(86645, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(490, 490, 490, 490, 500)
    recipe:SetRecipeItem(65650, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(62238, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_CREATED_ITEM")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddWorldDrop(Z.DEEPHOLM)

    -- Origami Beetle -- 86646
    recipe = AddRecipe(86646, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(500, 500, 500, 500, 510)
    recipe:SetRecipeItem(65651, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(63246, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_CREATED_ITEM")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddWorldDrop(Z.ULDUM)

    -- Key to the Planes -- 86648
    recipe = AddRecipe(86648, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(480, 480, 500, 502, 505)
    recipe:SetCraftedItem(87565, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_STAFF")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(26916, 26995, 28702, 30706, 30709, 30711, 30713, 30715, 30716, 30717, 30721, 33603, 33615, 33638,
        46716, 53415, 56065, 62327, 64691, 66355)

    -- Runed Staff -- 86649
    recipe = AddRecipe(86649, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(505, 505, 515, 520, 525)
    recipe:SetCraftedItem(87566, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_STAFF")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(26916, 26995, 28702, 30706, 30709, 30711, 30713, 30715, 30716, 30717, 30721, 33603, 33615, 33638,
        46716, 53415, 56065, 62327, 64691, 66355)

    -- Rosethorn Staff -- 86652
    recipe = AddRecipe(86652, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(515, 515, 525, 530, 535)
    recipe:SetCraftedItem(87562, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_STAFF")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(26916, 26995, 28702, 30706, 30709, 30711, 30713, 30715, 30716, 30717, 30721, 33603, 33615, 33638,
        46716, 53415, 56065, 62327, 64691, 66355)

    -- Silver Inlaid Staff -- 86653
    recipe = AddRecipe(86653, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(515, 515, 525, 530, 535)
    recipe:SetCraftedItem(87561, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_STAFF")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(26916, 26995, 28702, 30706, 30709, 30711, 30713, 30715, 30716, 30717, 30721, 33603, 33615, 33638,
        46716, 53415, 56065, 62327, 64691, 66355)

    -- Forged Documents -- 86654
    recipe = AddRecipe(86654, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(500, 500, 510, 522, 535)
    recipe:SetCraftedItem(63276, "BIND_ON_EQUIP")
    recipe:SetRequiredFaction("Horde")
    recipe:SetItemFilterType("INSCRIPTION_CREATED_ITEM")
    recipe:AddFilters(F.HORDE)
    recipe:AddTrainer(30709, 30715, 30717, 33603, 53415, 66355)

    -- Forged Documents -- 89244
    recipe = AddRecipe(89244, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(500, 500, 510, 522, 535)
    recipe:SetCraftedItem(62056, "BIND_ON_EQUIP")
    recipe:SetRequiredFaction("Alliance")
    recipe:SetItemFilterType("INSCRIPTION_CREATED_ITEM")
    recipe:AddFilters(F.ALLIANCE)
    recipe:AddTrainer(30709, 30713, 30715, 30717, 33603, 53415, 66355)

    -- Scroll of Intellect IX -- 89368
    recipe = AddRecipe(89368, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(445, 445, 450, 455, 460)
    recipe:SetCraftedItem(63305, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_SCROLL")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(26916, 26977, 26995, 28702, 30706, 30709, 30711, 30713, 30715, 30716, 30717, 30721, 33603, 33615,
        33638, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Scroll of Strength IX -- 89369
    recipe = AddRecipe(89369, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(465, 465, 470, 475, 480)
    recipe:SetCraftedItem(63304, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_SCROLL")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(26916, 26977, 26995, 28702, 30706, 30709, 30711, 30713, 30715, 30716, 30717, 30721, 33603, 33615,
        33638, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Scroll of Agility IX -- 89370
    recipe = AddRecipe(89370, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(470, 470, 475, 480, 485)
    recipe:SetCraftedItem(63303, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_SCROLL")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(26916, 26977, 26995, 28702, 30706, 30709, 30711, 30713, 30715, 30716, 30717, 30721, 33603, 33615,
        33638, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Scroll of Spirit IX -- 89371
    recipe = AddRecipe(89371, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(455, 455, 460, 465, 470)
    recipe:SetCraftedItem(63307, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_SCROLL")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(26916, 26977, 26995, 28702, 30706, 30709, 30711, 30713, 30715, 30716, 30717, 30721, 33603, 33615,
        33638, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Scroll of Stamina IX -- 89372
    recipe = AddRecipe(89372, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(460, 460, 465, 470, 475)
    recipe:SetCraftedItem(63306, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_SCROLL")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(26916, 26977, 26995, 28702, 30706, 30709, 30711, 30713, 30715, 30716, 30717, 30721, 33603, 33615,
        33638, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Scroll of Protection IX -- 89373
    recipe = AddRecipe(89373, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(450, 450, 455, 460, 465)
    recipe:SetCraftedItem(63308, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_SCROLL")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(26916, 26977, 26995, 28702, 30706, 30709, 30711, 30713, 30715, 30716, 30717, 30721, 33603, 33615,
        33638, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Colossus Smash -- 89815
    recipe = AddRecipe(89815, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(465, 465, 470, 477, 485)
    recipe:SetRecipeItem(68810, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(63481, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARRIOR)
    recipe:AddTrainer(26916, 26977, 26995, 28702, 30706, 30709, 30713, 30715, 30716, 30717, 30721, 33603, 33615, 33638,
        46716, 53415, 56065, 62327, 64691, 66355)
    recipe:AddVendor(49703, 50248)

    -- Vanishing Powder -- 92026
    recipe = AddRecipe(92026, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(75, 75, 90, 100, 110)
    recipe:SetCraftedItem(64670, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MATERIALS")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(26916, 26977, 26995, 28702, 30706, 30709, 30713, 30715, 30716, 30717, 30721, 33603, 33615, 33638,
        46716, 53415, 56065, 62327, 64691, 66355)

    -- Dust of Disappearance -- 92027
    recipe = AddRecipe(92027, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(475, 475, 475, 487, 500)
    recipe:SetCraftedItem(63388, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MATERIALS")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(26916, 26977, 26995, 28702, 30706, 30709, 30711, 30713, 30715, 30716, 30717, 30721, 33603, 33615,
        33638, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Blind -- 92579
    recipe = AddRecipe(92579, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(180, 180, 185, 190, 195)
    recipe:SetCraftedItem(64493, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.ROGUE)
    recipe:AddTrainer(26916, 26977, 26995, 28702, 30706, 30709, 30713, 30715, 30716, 30717, 30721, 33603, 33615, 33638,
        46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Cat Form -- 94401
    recipe = AddRecipe(94401, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(120, 120, 125, 130, 135)
    recipe:SetCraftedItem(67487, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DRUID)
    recipe:AddTrainer(26916, 26977, 26995, 28702, 30706, 30709, 30713, 30715, 30716, 30717, 30721, 33603, 33615, 33638,
        46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Fae Silence -- 94402
    recipe = AddRecipe(94402, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(330, 330, 335, 340, 345)
    recipe:SetCraftedItem(67484, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DRUID)
    recipe:AddTrainer(26916, 26977, 26995, 28702, 30706, 30709, 30713, 30715, 30716, 30717, 30721, 33603, 33615, 33638,
        46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Faerie Fire -- 94403
    recipe = AddRecipe(94403, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(120, 120, 125, 130, 135)
    recipe:SetCraftedItem(67485, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DRUID)
    recipe:AddTrainer(26916, 26977, 26995, 28702, 30706, 30709, 30713, 30715, 30716, 30717, 30721, 33603, 33615, 33638,
        46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of the Predator -- 94404
    recipe = AddRecipe(94404, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(150, 150, 155, 160, 165)
    recipe:SetCraftedItem(67486, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DRUID)
    recipe:AddTrainer(26916, 26977, 26995, 28702, 30706, 30709, 30713, 30715, 30716, 30717, 30721, 33603, 33615, 33638,
        46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Recklessness -- 94405
    recipe = AddRecipe(94405, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(150, 150, 155, 160, 165)
    recipe:SetCraftedItem(67483, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARRIOR)
    recipe:AddTrainer(26916, 26977, 26995, 28702, 30706, 30709, 30713, 30715, 30716, 30717, 30721, 33603, 33615, 33638,
        46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Bull Rush -- 94406
    recipe = AddRecipe(94406, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(250, 250, 255, 260, 265)
    recipe:SetCraftedItem(67482, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARRIOR)
    recipe:AddTrainer(26916, 26977, 26995, 28702, 30706, 30709, 30713, 30715, 30716, 30717, 30721, 33603, 33615, 33638,
        46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Vanish -- 94711
    recipe = AddRecipe(94711, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(430, 430, 430, 435, 440)
    recipe:SetCraftedItem(63420, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.ROGUE)
    recipe:AddDiscovery("DISCOVERY_INSC_BOOK", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of the Treant -- 95215
    recipe = AddRecipe(95215, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(155, 155, 155, 160, 165)
    recipe:SetCraftedItem(68039, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DRUID)
    recipe:AddDiscovery("DISCOVERY_INSC_MINOR")

    -- Glyph of Rapid Teleportation -- 95710
    recipe = AddRecipe(95710, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(155, 155, 155, 160, 165)
    recipe:SetCraftedItem(63416, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MAGE)
    recipe:AddDiscovery("DISCOVERY_INSC_MINOR")

    -- Glyph of Protector of the Innocent -- 95825
    recipe = AddRecipe(95825, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(390, 390, 390, 397, 405)
    recipe:SetCraftedItem(66918, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PALADIN)
    recipe:AddDiscovery("DISCOVERY_INSC_NORTHREND", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Dark Succor -- 96284
    recipe = AddRecipe(96284, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(275, 275, 280, 287, 295)
    recipe:SetCraftedItem(68793, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(26916, 26977, 26995, 28702, 30706, 30709, 30711, 30713, 30715, 30716, 30717, 30721, 33603, 33615,
        33638, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Armors -- 98398
    recipe = AddRecipe(98398, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(430, 430, 430, 435, 440)
    recipe:SetCraftedItem(69773, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MAGE)
    recipe:AddDiscovery("DISCOVERY_INSC_NORTHREND", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Lightning Shield -- 101057
    recipe = AddRecipe(101057, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(430, 430, 430, 435, 440)
    recipe:SetCraftedItem(71155, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.SHAMAN)
    recipe:AddDiscovery("DISCOVERY_INSC_NORTHREND", "DISCOVERY_INSC_PANDARIA")

    -- Glyph of Shadow -- 107907
    recipe = AddRecipe(107907, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(105, 105, 105, 110, 115)
    recipe:SetCraftedItem(77101, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PRIEST)
    recipe:AddDiscovery("DISCOVERY_INSC_MINOR")

    -------------------------------------------------------------------------------
    -- Mists of Pandaria.
    -------------------------------------------------------------------------------
    -- Glyph of Focused Wrath -- 57037
    recipe = AddRecipe(57037, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(525, 525, 595, 600, 605)
    recipe:SetCraftedItem(80581, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PALADIN)
    recipe:AddDiscovery("DISCOVERY_INSC_PANDARIA")

    -- Ink of Dreams -- 111645
    recipe = AddRecipe(111645, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(500, 500, 510, 515, 520)
    recipe:SetCraftedItem(79254, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MATERIALS")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(26916, 26977, 26995, 28702, 30706, 30709, 30711, 30713, 30715, 30716, 30717, 30721, 33603, 33615,
        33638, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Starlight Ink -- 111646
    recipe = AddRecipe(111646, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(500, 500, 510, 515, 520)
    recipe:SetCraftedItem(79255, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MATERIALS")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(26916, 26977, 26995, 28702, 30706, 30709, 30711, 30713, 30715, 30716, 30717, 30721, 33603, 33615,
        33638, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Darkmoon Card of Mists -- 111830
    recipe = AddRecipe(111830, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(600, 600, 610, 615, 620)
    recipe:SetItemFilterType("INSCRIPTION_CREATED_ITEM")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(26916, 26977, 26995, 28702, 30706, 30709, 30711, 30713, 30715, 30716, 30717, 30721, 33603, 33615,
        33638, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Inscribed Fan -- 111908
    recipe = AddRecipe(111908, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(560, 560, 570, 575, 580)
    recipe:SetCraftedItem(79333, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_OFF_HAND")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER)
    recipe:AddTrainer(26916, 26977, 26995, 28702, 30706, 30709, 30711, 30713, 30715, 30716, 30717, 30721, 33603, 33615,
        33638, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Inscribed Jade Fan -- 111909
    recipe = AddRecipe(111909, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(560, 560, 570, 575, 580)
    recipe:SetCraftedItem(79334, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_OFF_HAND")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER)
    recipe:AddTrainer(26916, 26977, 26995, 28702, 30706, 30709, 30711, 30713, 30715, 30716, 30717, 30721, 33603, 33615,
        33638, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Inscribed Red Fan -- 111910
    recipe = AddRecipe(111910, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(560, 560, 570, 575, 580)
    recipe:SetCraftedItem(79335, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_OFF_HAND")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER)
    recipe:AddTrainer(26916, 26977, 26995, 28702, 30706, 30709, 30711, 30713, 30715, 30716, 30717, 30721, 33603, 33615,
        33638, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Rain Poppy Staff -- 111917
    recipe = AddRecipe(111917, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(560, 560, 570, 575, 580)
    recipe:SetCraftedItem(79339, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_STAFF")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER)
    recipe:AddTrainer(26916, 26977, 26995, 28702, 30706, 30709, 30711, 30713, 30715, 30716, 30717, 30721, 33603, 33615,
        33638, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Inscribed Crane Staff -- 111918
    recipe = AddRecipe(111918, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(560, 560, 570, 575, 580)
    recipe:SetCraftedItem(79340, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("INSCRIPTION_STAFF")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(26916, 26977, 26995, 28702, 30706, 30709, 30711, 30713, 30715, 30716, 30717, 30721, 33603, 33615,
        33638, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Inscribed Serpent Staff -- 111919
    recipe = AddRecipe(111919, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(560, 560, 570, 575, 580)
    recipe:SetCraftedItem(79341, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_STAFF")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
    recipe:AddTrainer(26916, 26977, 26995, 28702, 30706, 30709, 30711, 30713, 30715, 30716, 30717, 30721, 33603, 33615,
        33638, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Ghost Iron Staff -- 111920
    recipe = AddRecipe(111920, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(560, 560, 570, 575, 580)
    recipe:SetCraftedItem(79342, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_STAFF")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
    recipe:AddTrainer(26916, 26977, 26995, 28702, 30706, 30709, 30711, 30713, 30715, 30716, 30717, 30721, 33603, 33615,
        33638, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Inscribed Tiger Staff -- 111921
    recipe = AddRecipe(111921, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(560, 560, 570, 575, 580)
    recipe:SetCraftedItem(79343, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_STAFF")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
    recipe:AddTrainer(26916, 26977, 26995, 28702, 30706, 30709, 30711, 30713, 30715, 30716, 30717, 30721, 33603, 33615,
        33638, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Runescroll of Fortitude III -- 112045
    recipe = AddRecipe(112045, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(580, 580, 590, 595, 600)
    recipe:SetCraftedItem(79257, "BIND_ON_PICKUP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of the Falling Avenger -- 112264
    recipe = AddRecipe(112264, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(525, 525, 595, 600, 605)
    recipe:SetCraftedItem(80584, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PALADIN)
    recipe:AddDiscovery("DISCOVERY_INSC_PANDARIA")

    -- Glyph of Righteous Retreat -- 112265
    recipe = AddRecipe(112265, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(525, 525, 595, 600, 605)
    recipe:SetCraftedItem(80585, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PALADIN)
    recipe:AddDiscovery("DISCOVERY_INSC_PANDARIA")

    -- Glyph of Bladed Judgment -- 112266
    recipe = AddRecipe(112266, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(525, 525, 595, 600, 605)
    recipe:SetCraftedItem(80586, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PALADIN)
    recipe:AddDiscovery("DISCOVERY_INSC_PANDARIA")

    -- Glyph of Crow Feast -- 112429
    recipe = AddRecipe(112429, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(525, 525, 595, 600, 605)
    recipe:SetCraftedItem(80587, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARRIOR)
    recipe:AddDiscovery("DISCOVERY_INSC_PANDARIA")

    -- Glyph of Burning Anger -- 112430
    recipe = AddRecipe(112430, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(525, 525, 595, 600, 605)
    recipe:SetCraftedItem(80588, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARRIOR)
    recipe:AddDiscovery("DISCOVERY_INSC_PANDARIA")

    -- Glyph of Nimble Brew -- 112437
    recipe = AddRecipe(112437, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(220, 220, 230, 235, 240)
    recipe:SetCraftedItem(87880, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MONK)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Paralysis -- 112440
    recipe = AddRecipe(112440, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(355, 355, 365, 370, 375)
    recipe:SetCraftedItem(87897, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MONK)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Life Cocoon -- 112442
    recipe = AddRecipe(112442, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(320, 320, 330, 335, 340)
    recipe:SetCraftedItem(87895, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MONK)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Touch of Karma -- 112444
    recipe = AddRecipe(112444, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(370, 370, 380, 385, 390)
    recipe:SetCraftedItem(87900, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MONK)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Leer of the Ox -- 112450
    recipe = AddRecipe(112450, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(295, 295, 305, 310, 315)
    recipe:SetCraftedItem(87894, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MONK)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Afterlife -- 112451
    recipe = AddRecipe(112451, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(155, 155, 165, 170, 175)
    recipe:SetCraftedItem(87891, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MONK)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Sparring -- 112452
    recipe = AddRecipe(112452, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(360, 360, 370, 375, 380)
    recipe:SetCraftedItem(87898, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MONK)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Detox -- 112454
    recipe = AddRecipe(112454, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(365, 365, 375, 380, 385)
    recipe:SetCraftedItem(87899, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MONK)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Fortifying Brew -- 112457
    recipe = AddRecipe(112457, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(255, 255, 265, 270, 275)
    recipe:SetCraftedItem(87893, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MONK)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Targeted Expulsion -- 112458
    recipe = AddRecipe(112458, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(380, 380, 390, 395, 400)
    recipe:SetCraftedItem(87901, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MONK)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Zen Flight -- 112460
    recipe = AddRecipe(112460, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(525, 525, 595, 600, 605)
    recipe:SetCraftedItem(87890, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MONK)
    recipe:AddDiscovery("DISCOVERY_INSC_PANDARIA")

    -- Glyph of Water Roll -- 112461
    recipe = AddRecipe(112461, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(525, 525, 595, 600, 605)
    recipe:SetCraftedItem(87889, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MONK)
    recipe:AddDiscovery("DISCOVERY_INSC_PANDARIA")

    -- Glyph of Crackling Tiger Lightning -- 112462
    recipe = AddRecipe(112462, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(485, 485, 495, 500, 505)
    recipe:SetCraftedItem(87881, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MONK)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Flying Serpent Kick -- 112463
    recipe = AddRecipe(112463, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(495, 495, 505, 510, 515)
    recipe:SetCraftedItem(87882, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MONK)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Honor -- 112464
    recipe = AddRecipe(112464, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(525, 525, 595, 600, 605)
    recipe:SetCraftedItem(87883, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MONK)
    recipe:AddDiscovery("DISCOVERY_INSC_PANDARIA")

    -- Glyph of Jab -- 112465
    recipe = AddRecipe(112465, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(525, 525, 595, 600, 605)
    recipe:SetCraftedItem(87884, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.TANK, F.MONK)
    recipe:AddDiscovery("DISCOVERY_INSC_PANDARIA")

    -- Glyph of Rising Tiger Kick -- 112466
    recipe = AddRecipe(112466, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(525, 525, 595, 600, 605)
    recipe:SetCraftedItem(87885, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MONK)
    recipe:AddDiscovery("DISCOVERY_INSC_PANDARIA")

    -- Glyph of Spirit Roll -- 112468
    recipe = AddRecipe(112468, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(525, 525, 595, 600, 605)
    recipe:SetCraftedItem(87887, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MONK)
    recipe:AddDiscovery("DISCOVERY_INSC_PANDARIA")

    -- Glyph of Fighting Pose -- 112469
    recipe = AddRecipe(112469, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(490, 490, 500, 505, 510)
    recipe:SetCraftedItem(87888, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MONK)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Tome of the Clear Mind -- 112883
    recipe = AddRecipe(112883, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(500, 500, 510, 515, 520)
    recipe:SetCraftedItem(79249, "BIND_ON_PICKUP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Scroll of Wisdom -- 112996
    recipe = AddRecipe(112996, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(525, 525, 535, 540, 545)
    recipe:SetCraftedItem(79731, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("INSCRIPTION_SCROLL")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of the Battle Healer -- 119481
    recipe = AddRecipe(119481, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(525, 525, 595, 600, 605)
    recipe:SetCraftedItem(81956, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PALADIN)
    recipe:AddDiscovery("DISCOVERY_INSC_PANDARIA")

    -- Glyph of Incite -- 122015
    recipe = AddRecipe(122015, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(525, 525, 595, 600, 605)
    recipe:SetCraftedItem(83096, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARRIOR)
    recipe:AddDiscovery("DISCOVERY_INSC_PANDARIA")

    -- Glyph of Mass Exorcism -- 122030
    recipe = AddRecipe(122030, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(525, 525, 595, 600, 605)
    recipe:SetCraftedItem(83107, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PALADIN)
    recipe:AddDiscovery("DISCOVERY_INSC_PANDARIA")

    -- Glyph of the Blazing Trail -- 123781
    recipe = AddRecipe(123781, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(525, 525, 595, 600, 605)
    recipe:SetCraftedItem(85221, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARRIOR)
    recipe:AddDiscovery("DISCOVERY_INSC_PANDARIA")

    -- Glyph of Aspect of the Beast -- 124442
    recipe = AddRecipe(124442, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(450, 450, 460, 465, 470)
    recipe:SetCraftedItem(85683, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HUNTER)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Black Ice -- 124443
    recipe = AddRecipe(124443, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(525, 525, 595, 600, 605)
    recipe:SetCraftedItem(85684, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HUNTER)
    recipe:AddDiscovery("DISCOVERY_INSC_PANDARIA")

    -- Glyph of Breath of Fire -- 124444
    recipe = AddRecipe(124444, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(525, 525, 595, 600, 605)
    recipe:SetCraftedItem(85685, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MONK)
    recipe:AddDiscovery("DISCOVERY_INSC_PANDARIA")

    -- Glyph of Fists of Fury -- 124445
    recipe = AddRecipe(124445, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(460, 460, 470, 475, 480)
    recipe:SetCraftedItem(87892, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MONK)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Clash -- 124446
    recipe = AddRecipe(124446, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(525, 525, 595, 600, 605)
    recipe:SetCraftedItem(85687, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MONK)
    recipe:AddDiscovery("DISCOVERY_INSC_PANDARIA")

    -- Glyph of Enduring Healing Sphere -- 124447
    recipe = AddRecipe(124447, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(525, 525, 595, 600, 605)
    recipe:SetCraftedItem(85689, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MONK)
    recipe:AddDiscovery("DISCOVERY_INSC_PANDARIA")

    -- Glyph of Rapid Rolling -- 124448
    recipe = AddRecipe(124448, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(525, 525, 595, 600, 605)
    recipe:SetCraftedItem(82345, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MONK)
    recipe:AddDiscovery("DISCOVERY_INSC_PANDARIA")

    -- Glyph of Guard -- 124449
    recipe = AddRecipe(124449, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(525, 525, 595, 600, 605)
    recipe:SetCraftedItem(85691, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MONK)
    recipe:AddDiscovery("DISCOVERY_INSC_PANDARIA")

    -- Glyph of Mana Tea -- 124450
    recipe = AddRecipe(124450, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(525, 525, 595, 600, 605)
    recipe:SetCraftedItem(85692, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MONK)
    recipe:AddDiscovery("DISCOVERY_INSC_PANDARIA")

    -- Glyph of Zen Meditation -- 124451
    recipe = AddRecipe(124451, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(380, 380, 390, 395, 400)
    recipe:SetCraftedItem(85695, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MONK)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Renewing Mists -- 124452
    recipe = AddRecipe(124452, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(440, 440, 450, 455, 460)
    recipe:SetCraftedItem(85696, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MONK)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Spinning Crane Kick -- 124453
    recipe = AddRecipe(124453, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(445, 445, 455, 460, 465)
    recipe:SetCraftedItem(85697, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MONK)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Spinning Fire Blossom -- 124454
    recipe = AddRecipe(124454, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(525, 525, 595, 600, 605)
    recipe:SetCraftedItem(85698, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MONK)
    recipe:AddDiscovery("DISCOVERY_INSC_PANDARIA")

    -- Glyph of Surging Mist -- 124455
    recipe = AddRecipe(124455, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(465, 465, 475, 480, 485)
    recipe:SetCraftedItem(85699, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MONK)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Touch of Death -- 124456
    recipe = AddRecipe(124456, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(470, 470, 480, 485, 490)
    recipe:SetCraftedItem(85700, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MONK)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Transcendence -- 124457
    recipe = AddRecipe(124457, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(525, 525, 595, 600, 605)
    recipe:SetCraftedItem(84652, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MONK)
    recipe:AddDiscovery("DISCOVERY_INSC_PANDARIA")

    -- Glyph of Mind Flay -- 124459
    recipe = AddRecipe(124459, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(455, 455, 465, 470, 475)
    recipe:SetCraftedItem(79513, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PRIEST)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of Vampiric Embrace -- 124460
    recipe = AddRecipe(124460, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(525, 525, 595, 600, 605)
    recipe:SetCraftedItem(79515, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.PRIEST)
    recipe:AddDiscovery("DISCOVERY_INSC_PANDARIA")

    -- Glyph of Shadow Word: Death -- 124461
    recipe = AddRecipe(124461, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(525, 525, 595, 600, 605)
    recipe:SetCraftedItem(79514, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PRIEST)
    recipe:AddDiscovery("DISCOVERY_INSC_PANDARIA")

    -- Glyph of Fortuitous Spheres -- 124463
    recipe = AddRecipe(124463, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(380, 380, 390, 395, 400)
    recipe:SetCraftedItem(87896, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MONK)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of the Heavens -- 124466
    recipe = AddRecipe(124466, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(525, 525, 595, 600, 605)
    recipe:SetCraftedItem(79538, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PRIEST)
    recipe:AddDiscovery("DISCOVERY_INSC_PANDARIA")

    -- Glyph of Confession -- 126153
    recipe = AddRecipe(126153, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(525, 525, 595, 600, 605)
    recipe:SetCraftedItem(86541, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PRIEST)
    recipe:AddDiscovery("DISCOVERY_INSC_PANDARIA")

    -- Glyph of Holy Resurrection -- 126687
    recipe = AddRecipe(126687, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(525, 525, 595, 600, 605)
    recipe:SetCraftedItem(87276, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PRIEST)
    recipe:AddDiscovery("DISCOVERY_INSC_PANDARIA")

    -- Glyph of the Val'kyr -- 126696
    recipe = AddRecipe(126696, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(525, 525, 595, 600, 605)
    recipe:SetCraftedItem(87277, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PRIEST)
    recipe:AddDiscovery("DISCOVERY_INSC_PANDARIA")

    -- Glyph of Direction -- 126701
    recipe = AddRecipe(126701, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(525, 525, 595, 600, 605)
    recipe:SetCraftedItem(87278, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HUNTER)
    recipe:AddDiscovery("DISCOVERY_INSC_PANDARIA")

    -- Glyph of Marking -- 126704
    recipe = AddRecipe(126704, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(525, 525, 595, 600, 605)
    recipe:SetCraftedItem(87279, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HUNTER)
    recipe:AddDiscovery("DISCOVERY_INSC_PANDARIA")

    -- Glyph of Shadowy Friends -- 126800
    recipe = AddRecipe(126800, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(525, 525, 595, 600, 605)
    recipe:SetCraftedItem(87392, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PRIEST)
    recipe:AddDiscovery("DISCOVERY_INSC_PANDARIA")

    -- Glyph of Fetch -- 126801
    recipe = AddRecipe(126801, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(440, 440, 450, 455, 460)
    recipe:SetCraftedItem(87393, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HUNTER)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Origami Crane -- 126988
    recipe = AddRecipe(126988, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(600, 600, 610, 615, 620)
    recipe:SetCraftedItem(87647, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_CREATED_ITEM")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Origami Frog -- 126989
    recipe = AddRecipe(126989, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(600, 600, 610, 615, 620)
    recipe:SetCraftedItem(87648, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_CREATED_ITEM")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Greater Ox Horn Inscription -- 126994
    recipe = AddRecipe(126994, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(570, 570, 580, 585, 590)
    recipe:SetCraftedItem(87560, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_ITEM_ENHANCEMENT")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Greater Crane Wing Inscription -- 126995
    recipe = AddRecipe(126995, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(570, 570, 580, 585, 590)
    recipe:SetCraftedItem(87559, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_ITEM_ENHANCEMENT")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Greater Tiger Claw Inscription -- 126996
    recipe = AddRecipe(126996, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(570, 570, 580, 585, 590)
    recipe:SetCraftedItem(83007, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_ITEM_ENHANCEMENT")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Greater Tiger Fang Inscription -- 126997
    recipe = AddRecipe(126997, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(570, 570, 580, 585, 590)
    recipe:SetCraftedItem(83006, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_ITEM_ENHANCEMENT")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Yu'lon Kite -- 127007
    recipe = AddRecipe(127007, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(600, 600, 610, 615, 620)
    recipe:SetCraftedItem(89367, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_PET")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Chi-ji Kite -- 127009
    recipe = AddRecipe(127009, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(600, 600, 610, 615, 620)
    recipe:SetCraftedItem(89368, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_PET")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Tiger Fang Inscription -- 127016
    recipe = AddRecipe(127016, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(540, 540, 550, 555, 560)
    recipe:SetCraftedItem(87580, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_ITEM_ENHANCEMENT")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Tiger Claw Inscription -- 127017
    recipe = AddRecipe(127017, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(540, 540, 550, 555, 560)
    recipe:SetCraftedItem(87579, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_ITEM_ENHANCEMENT")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Crane Wing Inscription -- 127018
    recipe = AddRecipe(127018, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(540, 540, 550, 555, 560)
    recipe:SetCraftedItem(87578, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_ITEM_ENHANCEMENT")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Ox Horn Inscription -- 127019
    recipe = AddRecipe(127019, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(540, 540, 550, 555, 560)
    recipe:SetCraftedItem(87577, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_ITEM_ENHANCEMENT")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Secret Tiger Fang Inscription -- 127020
    recipe = AddRecipe(127020, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(575, 575, 585, 590, 595)
    recipe:SetCraftedItem(87580, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_ITEM_ENHANCEMENT")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Secret Tiger Claw Inscription -- 127021
    recipe = AddRecipe(127021, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(575, 575, 585, 590, 595)
    recipe:SetCraftedItem(87580, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_ITEM_ENHANCEMENT")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Secret Crane Wing Inscription -- 127023
    recipe = AddRecipe(127023, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(575, 575, 585, 590, 595)
    recipe:SetCraftedItem(87582, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("INSCRIPTION_ITEM_ENHANCEMENT")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Secret Ox Horn Inscription -- 127024
    recipe = AddRecipe(127024, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(575, 575, 585, 590, 595)
    recipe:SetCraftedItem(87581, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("INSCRIPTION_ITEM_ENHANCEMENT")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Commissioned Painting -- 127378
    recipe = AddRecipe(127378, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(600, 600, 600, 602, 605)
    recipe:SetCraftedItem(87811, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("INSCRIPTION_CREATED_ITEM")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddQuest(31539)
    recipe:AddCustom("LEARNT_BY_ACCEPTING_QUEST")

    -- Glyph of Lightspring -- 127625
    recipe = AddRecipe(127625, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(255, 255, 265, 270, 275)
    recipe:SetCraftedItem(87902, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PRIEST)
    recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721,
        30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355)

    -- Glyph of the Cheetah -- 131152
    recipe = AddRecipe(131152, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(525, 525, 595, 600, 605)
    recipe:SetCraftedItem(89868, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DRUID)
    recipe:AddDiscovery("DISCOVERY_INSC_PANDARIA")

    -- Glyph of Blackout Kick -- 132167
    recipe = AddRecipe(132167, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(525, 525, 595, 600, 605)
    recipe:SetCraftedItem(90715, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MONK)
    recipe:AddDiscovery("DISCOVERY_INSC_PANDARIA")

    -- Glyph of Gateway Attunement -- 135561
    recipe = AddRecipe(135561, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(595, 595, 595, 600, 605)
    recipe:SetCraftedItem(93202, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARLOCK)
    recipe:AddDiscovery("DISCOVERY_INSC_PANDARIA")

    -- Crafted Malevolent Gladiator's Medallion of Tenacity -- 146638
    recipe = AddRecipe(146638, V.MOP, Q.UNCOMMON)
    recipe:SetSkillLevels(600, 600, 600, 600, 605)
    recipe:SetRecipeItem(102534, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(102483, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_TRINKET")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PALADIN)
    recipe:AddWorldDrop(Z.PANDARIA)

    -- Glyph of Swift Death -- 148255
    recipe = AddRecipe(148255, V.MOP, Q.UNCOMMON)
    recipe:SetSkillLevels(500, 500, 595, 600, 605)
    recipe:SetRecipeItem(104197, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(104046, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DK)
    recipe:AddWorldDrop(Z.PANDARIA)

    -- Glyph of Loud Horn -- 148256
    recipe = AddRecipe(148256, V.MOP, Q.UNCOMMON)
    recipe:SetSkillLevels(500, 500, 595, 600, 605)
    recipe:SetRecipeItem(104209, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(104047, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DK)
    recipe:AddMobDrop(72875)

    -- Glyph of Regenerative Magic -- 148257
    recipe = AddRecipe(148257, V.MOP, Q.UNCOMMON)
    recipe:SetSkillLevels(500, 500, 595, 600, 605)
    recipe:SetRecipeItem(104210, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(104048, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DK)
    recipe:AddMobDrop(72771, 73157)

    -- Glyph of Festering Blood -- 148258
    recipe = AddRecipe(148258, V.MOP, Q.UNCOMMON)
    recipe:SetSkillLevels(500, 500, 595, 600, 605)
    recipe:SetRecipeItem(104211, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(104049, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DK)
    recipe:AddWorldDrop(Z.PANDARIA)

    -- Glyph of Divine Shield -- 148259
    recipe = AddRecipe(148259, V.MOP, Q.UNCOMMON)
    recipe:SetSkillLevels(500, 500, 595, 600, 605)
    recipe:SetRecipeItem(104212, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(104050, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PALADIN)
    recipe:AddWorldDrop(Z.PANDARIA)

    -- Glyph of Hand of Sacrifice -- 148260
    recipe = AddRecipe(148260, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(500, 500, 595, 600, 605)
    recipe:SetRecipeItem(104213, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(104051, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PALADIN)
    recipe:AddWorldDrop(Z.PANDARIA)

    -- Glyph of Purging -- 148261
    recipe = AddRecipe(148261, V.MOP, Q.UNCOMMON)
    recipe:SetSkillLevels(500, 500, 595, 600, 605)
    recipe:SetRecipeItem(104214, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(104052, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.SHAMAN)
    recipe:AddWorldDrop(Z.PANDARIA)

    -- Glyph of Eternal Earth -- 148262
    recipe = AddRecipe(148262, V.MOP, Q.UNCOMMON)
    recipe:SetSkillLevels(500, 500, 595, 600, 605)
    recipe:SetRecipeItem(104215, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(104053, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.SHAMAN)
    recipe:AddWorldDrop(Z.PANDARIA)

    -- Glyph of Impaling Throws -- 148264
    recipe = AddRecipe(148264, V.MOP, Q.UNCOMMON)
    recipe:SetSkillLevels(500, 500, 595, 600, 605)
    recipe:SetRecipeItem(104217, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(104055, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARRIOR)
    recipe:AddMobDrop(72896)

    -- Glyph of the Executor -- 148265
    recipe = AddRecipe(148265, V.MOP, Q.UNCOMMON)
    recipe:SetSkillLevels(500, 500, 595, 600, 605)
    recipe:SetRecipeItem(104218, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(104056, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARRIOR)
    recipe:AddWorldDrop(Z.PANDARIA)

    -- Glyph of the Skeleton -- 148266
    recipe = AddRecipe(148266, V.MOP, Q.UNCOMMON)
    recipe:SetSkillLevels(500, 500, 595, 600, 605)
    recipe:SetRecipeItem(104219, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(104099, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DK)
    recipe:AddMobDrop(72048)

    -- Glyph of the Long Winter -- 148267
    recipe = AddRecipe(148267, V.MOP, Q.UNCOMMON)
    recipe:SetSkillLevels(500, 500, 595, 600, 605)
    recipe:SetRecipeItem(104220, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(104101, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DK)
    recipe:AddWorldDrop(Z.PANDARIA)

    -- Glyph of the Sprouting Mushroom -- 148268
    recipe = AddRecipe(148268, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(500, 500, 595, 600, 605)
    recipe:SetRecipeItem(104221, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(104102, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DRUID)
    recipe:AddWorldDrop(Z.PANDARIA)

    -- Glyph of One with Nature -- 148269
    recipe = AddRecipe(148269, V.MOP, Q.UNCOMMON)
    recipe:SetSkillLevels(500, 500, 595, 600, 605)
    recipe:SetRecipeItem(104222, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(104103, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DRUID)
    recipe:AddMobDrop(72877, 73277)

    -- Glyph of the Unbound Elemental -- 148270
    recipe = AddRecipe(148270, V.MOP, Q.UNCOMMON)
    recipe:SetSkillLevels(500, 500, 595, 600, 605)
    recipe:SetRecipeItem(104223, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(104104, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MAGE)
    recipe:AddWorldDrop(Z.PANDARIA)

    -- Glyph of Evaporation -- 148271
    recipe = AddRecipe(148271, V.MOP, Q.UNCOMMON)
    recipe:SetSkillLevels(500, 500, 595, 600, 605)
    recipe:SetRecipeItem(104224, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(104105, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MAGE)
    recipe:AddMobDrop(72767)

    -- Glyph of Condensation -- 148272
    recipe = AddRecipe(148272, V.MOP, Q.UNCOMMON)
    recipe:SetSkillLevels(500, 500, 595, 600, 605)
    recipe:SetRecipeItem(104225, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(104106, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MAGE)
    recipe:AddMobDrop(72245)

    -- Glyph of the Exorcist -- 148273
    recipe = AddRecipe(148273, V.MOP, Q.UNCOMMON)
    recipe:SetSkillLevels(500, 500, 595, 600, 605)
    recipe:SetRecipeItem(104226, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(104107, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PALADIN)
    recipe:AddWorldDrop(Z.PANDARIA)

    -- Glyph of Pillar of Light -- 148274
    recipe = AddRecipe(148274, V.MOP, Q.UNCOMMON)
    recipe:SetSkillLevels(500, 500, 595, 600, 605)
    recipe:SetRecipeItem(104227, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(104108, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PALADIN)
    recipe:AddMobDrop(72769, 73162)

    -- Glyph of Angels -- 148275
    recipe = AddRecipe(148275, V.MOP, Q.UNCOMMON)
    recipe:SetSkillLevels(500, 500, 595, 600, 605)
    recipe:SetRecipeItem(104228, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(104109, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PRIEST)
    recipe:AddWorldDrop(Z.PANDARIA)

    -- Glyph of the Sha -- 148276
    recipe = AddRecipe(148276, V.MOP, Q.UNCOMMON)
    recipe:SetSkillLevels(500, 500, 595, 600, 605)
    recipe:SetRecipeItem(104229, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(104120, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PRIEST)
    recipe:AddWorldDrop(Z.PANDARIA)

    -- Glyph of Shifted Appearances -- 148277
    recipe = AddRecipe(148277, V.MOP, Q.UNCOMMON)
    recipe:SetSkillLevels(500, 500, 595, 600, 605)
    recipe:SetRecipeItem(104230, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(104121, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PRIEST)
    recipe:AddVendor(73293)

    -- Glyph of Inspired Hymns -- 148278
    recipe = AddRecipe(148278, V.MOP, Q.UNCOMMON)
    recipe:SetSkillLevels(500, 500, 595, 600, 605)
    recipe:SetRecipeItem(104231, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(104122, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PRIEST)
    recipe:AddMobDrop(72761)

    -- Glyph of Headhunting -- 148279
    recipe = AddRecipe(148279, V.MOP, Q.UNCOMMON)
    recipe:SetSkillLevels(500, 500, 595, 600, 605)
    recipe:SetRecipeItem(104232, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(104123, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.ROGUE)
    recipe:AddMobDrop(72895)

    -- Glyph of Improved Distraction -- 148280
    recipe = AddRecipe(148280, V.MOP, Q.UNCOMMON)
    recipe:SetSkillLevels(500, 500, 595, 600, 605)
    recipe:SetRecipeItem(104233, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(104124, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.ROGUE)
    recipe:AddWorldDrop(Z.PANDARIA)

    -- Glyph of Spirit Raptors -- 148281
    recipe = AddRecipe(148281, V.MOP, Q.UNCOMMON)
    recipe:SetSkillLevels(500, 500, 595, 600, 605)
    recipe:SetRecipeItem(104234, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(104126, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.SHAMAN)
    recipe:AddWorldDrop(Z.PANDARIA)

    -- Glyph of Lingering Ancestors -- 148282
    recipe = AddRecipe(148282, V.MOP, Q.UNCOMMON)
    recipe:SetSkillLevels(500, 500, 595, 600, 605)
    recipe:SetRecipeItem(104235, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(104127, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.SHAMAN)
    recipe:AddMobDrop(73018, 73021, 73025)

    -- Glyph of Spirit Wolf -- 148283
    recipe = AddRecipe(148283, V.MOP, Q.UNCOMMON)
    recipe:SetSkillLevels(500, 500, 595, 600, 605)
    recipe:SetRecipeItem(104236, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(104127, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.SHAMAN)
    recipe:AddWorldDrop(Z.PANDARIA)

    -- Glyph of Flaming Serpent -- 148284
    recipe = AddRecipe(148284, V.MOP, Q.UNCOMMON)
    recipe:SetSkillLevels(500, 500, 595, 600, 605)
    recipe:SetRecipeItem(104237, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(104129, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.SHAMAN)
    recipe:AddWorldDrop(Z.PANDARIA)

    -- Glyph of the Compy -- 148285
    recipe = AddRecipe(148285, V.MOP, Q.UNCOMMON)
    recipe:SetSkillLevels(500, 500, 595, 600, 605)
    recipe:SetRecipeItem(104238, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(104130, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.SHAMAN)
    recipe:AddWorldDrop(Z.PANDARIA)

    -- Glyph of Elemental Familiars -- 148286
    recipe = AddRecipe(148286, V.MOP, Q.UNCOMMON)
    recipe:SetSkillLevels(500, 500, 595, 600, 605)
    recipe:SetRecipeItem(104239, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(104131, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.SHAMAN)
    recipe:AddWorldDrop(Z.PANDARIA)

    -- Glyph of Astral Fixation -- 148287
    recipe = AddRecipe(148287, V.MOP, Q.UNCOMMON)
    recipe:SetSkillLevels(500, 500, 595, 600, 605)
    recipe:SetRecipeItem(104240, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(104133, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.SHAMAN)
    recipe:AddMobDrop(72875)

    -- Glyph of Rain of Frogs -- 148288
    recipe = AddRecipe(148288, V.MOP, Q.UNCOMMON)
    recipe:SetSkillLevels(500, 500, 595, 600, 605)
    recipe:SetRecipeItem(104241, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(104134, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.SHAMAN)
    recipe:AddMobDrop(72775, 72777)

    -- Glyph of the Raging Whirlwind -- 148289
    recipe = AddRecipe(148289, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(500, 500, 595, 600, 605)
    recipe:SetRecipeItem(104242, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(104135, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARRIOR)
    recipe:AddWorldDrop(Z.PANDARIA)

    -- Glyph of the Subtle Defender -- 148290
    recipe = AddRecipe(148290, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(500, 500, 595, 600, 605)
    recipe:SetRecipeItem(104243, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(104136, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARRIOR)
    recipe:AddWorldDrop(Z.PANDARIA)

    -- Glyph of the Watchful Eye -- 148291
    recipe = AddRecipe(148291, V.MOP, Q.UNCOMMON)
    recipe:SetSkillLevels(500, 500, 595, 600, 605)
    recipe:SetRecipeItem(104244, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(104137, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARRIOR)
    recipe:AddMobDrop(72892)

    -- Glyph of the Weaponmaster -- 148292
    recipe = AddRecipe(148292, V.MOP, Q.UNCOMMON)
    recipe:SetSkillLevels(500, 500, 595, 600, 605)
    recipe:SetRecipeItem(104245, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(104138, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARRIOR)
    recipe:AddMobDrop(73169)

    -- Glyph of the Lean Pack -- 148487
    recipe = AddRecipe(148487, V.MOP, Q.UNCOMMON)
    recipe:SetSkillLevels(500, 500, 595, 600, 605)
    recipe:SetRecipeItem(104279, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(104270, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HUNTER)
    recipe:AddMobDrop(72805, 72807)

    -- Glyph of Enduring Deceit -- 148489
    recipe = AddRecipe(148489, V.MOP, Q.UNCOMMON)
    recipe:SetSkillLevels(500, 500, 595, 600, 605)
    recipe:SetRecipeItem(104281, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(104276, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HUNTER)
    recipe:AddWorldDrop(Z.PANDARIA)

    self.InitializeRecipes = nil
end
