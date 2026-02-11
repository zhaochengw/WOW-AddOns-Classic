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

    -- ----------------------------------------------------------------------------
    -- Classic.
    -- ----------------------------------------------------------------------------
    -- Elixir of Lion's Strength -- 2329
    recipe = AddRecipe(2329, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 55, 75, 95)
    recipe:SetCraftedItem(2454, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddFilters(F.DPS)
    recipe:AddCustom("DEFAULT_RECIPE")

    -- Minor Healing Potion -- 2330
    recipe = AddRecipe(2330, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 55, 75, 95)
    recipe:SetCraftedItem(118, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddCustom("DEFAULT_RECIPE")

    -- Minor Mana Potion -- 2331
    recipe = AddRecipe(2331, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(25, 25, 65, 85, 105)
    recipe:SetCraftedItem(2455, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddFilters(F.CASTER, F.HEALER)
    recipe:AddTrainer(1386, 2837, 4900, 4160, 3184, 2132, 27029, 3347, 5499, 16723, 1246, 3603, 16642, 1215, 4611, 2391,
        33608, 19052, 16588, 7948, 33674, 3964, 16161, 18802, 3009, 27023, 1470, 5177, 17215)

    -- Minor Rejuvenation Potion -- 2332
    recipe = AddRecipe(2332, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(40, 40, 70, 90, 110)
    recipe:SetCraftedItem(2456, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddFilters(F.CASTER, F.HEALER)
    recipe:AddTrainer(1386, 2837, 4900, 4160, 3184, 2132, 27029, 3347, 5499, 16723, 1246, 3603, 16642, 1215, 4611, 2391,
        33608, 19052, 16588, 7948, 33674, 3964, 16161, 18802, 3009, 27023, 1470, 5177, 17215)

    -- Elixir of Lesser Agility -- 2333
    recipe = AddRecipe(2333, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(140, 140, 165, 185, 205)
    recipe:SetRecipeItem(3396, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(3390, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddFilters(F.DPS)
    recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

    -- Elixir of Minor Fortitude -- 2334
    recipe = AddRecipe(2334, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(50, 50, 80, 100, 120)
    recipe:SetCraftedItem(2458, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddTrainer(1386, 2837, 4900, 4160, 3184, 2132, 27029, 3347, 5499, 16723, 1246, 3603, 16642, 1215, 4611, 2391,
        33608, 19052, 16588, 7948, 33674, 3964, 16161, 18802, 3009, 27023, 1470, 5177, 17215)

    -- Swiftness Potion -- 2335
    recipe = AddRecipe(2335, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(60, 60, 90, 110, 130)
    recipe:SetRecipeItem(2555, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(2459, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

    -- Lesser Healing Potion -- 2337
    recipe = AddRecipe(2337, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(55, 55, 85, 105, 125)
    recipe:SetCraftedItem(858, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(1386, 2837, 4900, 4160, 3184, 2132, 27029, 3347, 5499, 16723, 1246, 3603, 16642, 1215, 4611, 2391,
        33608, 19052, 16588, 7948, 33674, 3964, 16161, 18802, 3009, 27023, 1470, 5177, 17215)

    -- Weak Troll's Blood Elixir -- 3170
    recipe = AddRecipe(3170, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(15, 15, 60, 80, 100)
    recipe:SetCraftedItem(3382, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddTrainer(1386, 2837, 4900, 4160, 3184, 2132, 27029, 3347, 5499, 16723, 1246, 3603, 16642, 1215, 4611, 2391,
        33608, 19052, 16588, 7948, 33674, 3964, 16161, 18802, 3009, 27023, 1470, 5177, 17215)

    -- Elixir of Wisdom -- 3171
    recipe = AddRecipe(3171, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(90, 90, 120, 140, 160)
    recipe:SetCraftedItem(3383, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddFilters(F.CASTER, F.HEALER)
    recipe:AddTrainer(1386, 2837, 4900, 16642, 3184, 2132, 27029, 3347, 16723, 3603, 5499, 18802, 4611, 4160, 5177, 19052,
        16588, 7948, 1470, 3964, 16161, 33608, 3009, 27023, 2391, 33674, 1215)

    -- Lesser Mana Potion -- 3173
    recipe = AddRecipe(3173, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(120, 120, 145, 165, 185)
    recipe:SetCraftedItem(3385, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddFilters(F.CASTER, F.HEALER)
    recipe:AddTrainer(1386, 2837, 4900, 16642, 3184, 2132, 27029, 3347, 16723, 3603, 5499, 18802, 4611, 4160, 5177, 19052,
        16588, 7948, 1470, 3964, 16161, 33608, 3009, 27023, 2391, 33674, 1215)

    -- Potion of Curing -- 3174
    recipe = AddRecipe(3174, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(120, 120, 145, 165, 185)
    recipe:SetRecipeItem(3394, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(3386, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

    -- Limited Invulnerability Potion -- 3175
    recipe = AddRecipe(3175, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(250, 250, 275, 295, 315)
    recipe:SetRecipeItem(3395, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(3387, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

    -- Strong Troll's Blood Elixir -- 3176
    recipe = AddRecipe(3176, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(125, 125, 150, 170, 190)
    recipe:SetCraftedItem(3388, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddTrainer(1386, 2837, 4900, 16642, 3184, 2132, 27029, 3347, 16723, 3603, 5499, 18802, 4611, 4160, 5177, 19052,
        16588, 7948, 1470, 3964, 16161, 33608, 3009, 27023, 2391, 33674, 1215)

    -- Elixir of Defense -- 3177
    recipe = AddRecipe(3177, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(130, 130, 155, 175, 195)
    recipe:SetCraftedItem(3389, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddFilters(F.TANK)
    recipe:AddTrainer(1386, 2837, 4900, 16642, 3184, 2132, 27029, 3347, 16723, 3603, 5499, 18802, 4611, 4160, 5177, 19052,
        16588, 7948, 1470, 3964, 16161, 33608, 3009, 27023, 2391, 33674, 1215)

    -- Elixir of Ogre's Strength -- 3188
    recipe = AddRecipe(3188, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(150, 150, 175, 195, 215)
    recipe:SetRecipeItem(6211, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(3391, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddFilters(F.DPS)
    recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

    -- Elixir of Minor Agility -- 3230
    recipe = AddRecipe(3230, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(50, 50, 80, 100, 120)
    recipe:SetRecipeItem(2553, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(2457, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddFilters(F.DPS)
    recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

    -- Healing Potion -- 3447
    recipe = AddRecipe(3447, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(110, 110, 135, 155, 175)
    recipe:SetCraftedItem(929, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(1386, 2837, 4900, 16642, 3184, 2132, 27029, 3347, 16723, 3603, 5499, 18802, 4611, 4160, 5177, 19052,
        16588, 7948, 1470, 3964, 16161, 33608, 3009, 27023, 2391, 33674, 1215)

    -- Lesser Invisibility Potion -- 3448
    recipe = AddRecipe(3448, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(165, 165, 185, 205, 225)
    recipe:SetCraftedItem(3823, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(1386, 2837, 4900, 16642, 3184, 2132, 27029, 3347, 16723, 3603, 4160, 1215, 4611, 33608, 5177, 19052,
        16588, 5499, 1470, 3964, 16161, 33674, 3009, 27023, 2391, 7948, 18802)

    -- Shadow Oil -- 3449
    recipe = AddRecipe(3449, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(165, 165, 190, 210, 230)
    recipe:SetCraftedItem(3824, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_OIL")
    recipe:AddTrainer(1386, 2132, 3009, 3184, 3347, 4160, 4900, 5177, 5499, 16588, 16642, 16723, 18802, 56777)

    -- Elixir of Fortitude -- 3450
    recipe = AddRecipe(3450, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(175, 175, 195, 215, 235)
    recipe:SetRecipeItem(3830, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(3825, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddTrainer(1386, 2837, 4900, 16642, 3184, 2132, 27029, 3347, 16723, 3603, 4160, 1215, 4611, 33608, 5177, 19052,
        16588, 5499, 1470, 3964, 16161, 33674, 3009, 27023, 2391, 7948, 18802)
    recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

    -- Major Troll's Blood Elixir -- 3451
    recipe = AddRecipe(3451, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(180, 180, 200, 220, 240)
    recipe:SetRecipeItem(3831, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(3826, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

    -- Mana Potion -- 3452
    recipe = AddRecipe(3452, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(160, 160, 180, 200, 220)
    recipe:SetCraftedItem(3827, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(1386, 2837, 4900, 16642, 3184, 2132, 27029, 3347, 16723, 3603, 4160, 1215, 4611, 33608, 5177, 19052,
        16588, 5499, 1470, 3964, 16161, 33674, 3009, 27023, 2391, 7948, 18802)

    -- Elixir of Detect Lesser Invisibility -- 3453
    recipe = AddRecipe(3453, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(195, 195, 215, 235, 255)
    recipe:SetRecipeItem(3832, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(3828, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

    -- Frost Oil -- 3454
    recipe = AddRecipe(3454, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(200, 200, 220, 240, 260)
    recipe:SetRecipeItem(14634, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(3829, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_OIL")
    recipe:AddLimitedVendor(2480, 1)

    -- Discolored Healing Potion -- 4508
    recipe = AddRecipe(4508, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(50, 50, 80, 100, 120)
    recipe:SetRecipeItem(4597, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(4596, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:Retire()

    -- Lesser Stoneshield Potion -- 4942
    recipe = AddRecipe(4942, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(215, 215, 230, 250, 270)
    recipe:SetRecipeItem(4624, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(4623, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddFilters(F.TANK)
    recipe:Retire()

    -- Rage Potion -- 6617
    recipe = AddRecipe(6617, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(60, 60, 90, 110, 130)
    recipe:SetRecipeItem(5640, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(5631, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddFilters(F.DPS, F.TANK, F.DRUID, F.WARRIOR)
    recipe:AddVendor(1685, 3499)
    recipe:AddLimitedVendor(3335, 2)

    -- Great Rage Potion -- 6618
    recipe = AddRecipe(6618, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(175, 175, 195, 215, 235)
    recipe:SetRecipeItem(5643, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(5633, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddFilters(F.DPS, F.TANK, F.DRUID, F.WARRIOR)
    recipe:AddLimitedVendor(3335, 2, 4226, 1)

    -- Free Action Potion -- 6624
    recipe = AddRecipe(6624, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(150, 150, 175, 195, 215)
    recipe:SetRecipeItem(5642, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(5634, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddLimitedVendor(3348, 1, 4226, 1, 5178, 1)

    -- Elixir of Water Breathing -- 7179
    recipe = AddRecipe(7179, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(90, 90, 120, 140, 160)
    recipe:SetCraftedItem(5996, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddTrainer(1386, 2837, 4900, 16642, 3184, 2132, 27029, 3347, 16723, 3603, 5499, 18802, 4611, 4160, 5177, 19052,
        16588, 7948, 1470, 3964, 16161, 33608, 3009, 27023, 2391, 33674, 1215)

    -- Greater Healing Potion -- 7181
    recipe = AddRecipe(7181, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(155, 155, 175, 195, 215)
    recipe:SetCraftedItem(1710, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(1386, 2837, 4900, 16642, 3184, 2132, 27029, 3347, 16723, 3603, 4160, 1215, 4611, 33608, 5177, 19052,
        16588, 5499, 1470, 3964, 16161, 33674, 3009, 27023, 2391, 7948, 18802)

    -- Elixir of Minor Defense -- 7183
    recipe = AddRecipe(7183, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 55, 75, 95)
    recipe:SetCraftedItem(5997, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddFilters(F.TANK)
    recipe:AddCustom("DEFAULT_RECIPE")

    -- Holy Protection Potion -- 7255
    recipe = AddRecipe(7255, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(100, 100, 130, 150, 170)
    recipe:SetRecipeItem(6053, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(6051, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddLimitedVendor(1685, 1, 3134, 1, 3490, 1)

    -- Shadow Protection Potion -- 7256
    recipe = AddRecipe(7256, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(135, 135, 160, 180, 200)
    recipe:SetRecipeItem(6054, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(6048, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddLimitedVendor(2393, 1, 3956, 1)

    -- Fire Protection Potion -- 7257
    recipe = AddRecipe(7257, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(165, 165, 210, 230, 250)
    recipe:SetRecipeItem(6055, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(6049, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddLimitedVendor(2380, 1, 4083, 1)

    -- Frost Protection Potion -- 7258
    recipe = AddRecipe(7258, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(190, 190, 205, 225, 245)
    recipe:SetRecipeItem(6056, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(6050, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddLimitedVendor(2812, 1, 2848, 1)

    -- Nature Protection Potion -- 7259
    recipe = AddRecipe(7259, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(190, 190, 210, 230, 250)
    recipe:SetRecipeItem(6057, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(6052, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddLimitedVendor(2848, 1, 5594, 1, 8157, 1, 8158, 1)

    -- Blackmouth Oil -- 7836
    recipe = AddRecipe(7836, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(80, 80, 80, 90, 100)
    recipe:SetCraftedItem(6370, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_OIL")
    recipe:AddTrainer(1386, 2837, 4900, 16642, 3184, 2132, 27029, 3347, 16723, 3603, 5499, 18802, 4611, 4160, 5177, 19052,
        16588, 7948, 1470, 3964, 16161, 33608, 3009, 27023, 2391, 33674, 1215)

    -- Fire Oil -- 7837
    recipe = AddRecipe(7837, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(130, 130, 150, 160, 170)
    recipe:SetCraftedItem(6371, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_OIL")
    recipe:AddTrainer(1386, 2837, 4900, 16642, 3184, 2132, 27029, 3347, 16723, 3603, 5499, 18802, 4611, 4160, 5177, 19052,
        16588, 7948, 1470, 3964, 16161, 33608, 3009, 27023, 2391, 33674, 1215)

    -- Swim Speed Potion -- 7841
    recipe = AddRecipe(7841, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(100, 100, 130, 150, 170)
    recipe:SetCraftedItem(6372, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(1386, 2837, 4900, 16642, 3184, 2132, 27029, 3347, 16723, 3603, 5499, 18802, 4611, 4160, 5177, 19052,
        16588, 7948, 1470, 3964, 16161, 33608, 3009, 27023, 2391, 33674, 1215)

    -- Elixir of Firepower -- 7845
    recipe = AddRecipe(7845, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(140, 140, 165, 185, 205)
    recipe:SetCraftedItem(6373, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddFilters(F.CASTER, F.HEALER)
    recipe:AddTrainer(1386, 2837, 4900, 16642, 3184, 2132, 27029, 3347, 16723, 3603, 5499, 18802, 4611, 4160, 5177, 19052,
        16588, 7948, 1470, 3964, 16161, 33608, 3009, 27023, 2391, 33674, 1215)

    -- Elixir of Giant Growth -- 8240
    recipe = AddRecipe(8240, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(90, 90, 120, 140, 160)
    recipe:SetRecipeItem(6663, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(6662, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddFilters(F.DPS)
    recipe:AddWorldDrop(Z.NORTHERN_BARRENS, Z.SOUTHERN_BARRENS)

    -- Greater Mana Potion -- 11448
    recipe = AddRecipe(11448, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(205, 205, 220, 240, 260)
    recipe:SetCraftedItem(6149, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(1386, 2837, 4900, 16642, 3184, 2132, 27029, 3347, 16723, 3603, 4160, 1215, 4611, 33608, 5177, 19052,
        16588, 5499, 1470, 3964, 16161, 33674, 3009, 27023, 2391, 7948, 18802)

    -- Elixir of Agility -- 11449
    recipe = AddRecipe(11449, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(185, 185, 205, 225, 245)
    recipe:SetCraftedItem(8949, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddFilters(F.DPS)
    recipe:AddTrainer(1386, 2837, 4900, 16642, 3184, 2132, 27029, 3347, 16723, 3603, 4160, 1215, 4611, 33608, 5177, 19052,
        16588, 5499, 1470, 3964, 16161, 33674, 3009, 27023, 2391, 7948, 18802)

    -- Elixir of Greater Defense -- 11450
    recipe = AddRecipe(11450, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(195, 195, 215, 235, 255)
    recipe:SetCraftedItem(8951, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddFilters(F.TANK)
    recipe:AddTrainer(1386, 2837, 4900, 16642, 3184, 2132, 27029, 3347, 16723, 3603, 4160, 1215, 4611, 33608, 5177, 19052,
        16588, 5499, 1470, 3964, 16161, 33674, 3009, 27023, 2391, 7948, 18802)

    -- Oil of Immolation -- 11451
    recipe = AddRecipe(11451, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(205, 205, 220, 240, 260)
    recipe:SetCraftedItem(8956, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_OIL")
    recipe:AddTrainer(1386, 2837, 4900, 16642, 3184, 2132, 27029, 3347, 16723, 3603, 4160, 1215, 4611, 33608, 5177, 19052,
        16588, 5499, 1470, 3964, 16161, 33674, 3009, 27023, 2391, 7948, 18802)

    -- Restorative Potion -- 11452
    recipe = AddRecipe(11452, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(210, 210, 225, 245, 265)
    recipe:SetCraftedItem(9030, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:Retire()

    -- Goblin Rocket Fuel -- 11456
    recipe = AddRecipe(11456, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(210, 210, 225, 245, 265)
    recipe:SetRecipeItem(10644, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(9061, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_MISC")
    recipe:AddCustom("CRAFTED_ENGINEERS")

    -- Superior Healing Potion -- 11457
    recipe = AddRecipe(11457, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(215, 215, 230, 250, 270)
    recipe:SetCraftedItem(3928, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(1386, 2837, 4900, 16642, 3184, 2132, 27029, 3347, 16723, 3603, 4160, 1215, 4611, 33608, 5177, 19052,
        16588, 5499, 1470, 3964, 16161, 33674, 3009, 27023, 2391, 7948, 18802)

    -- Wildvine Potion -- 11458
    recipe = AddRecipe(11458, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(225, 225, 240, 260, 280)
    recipe:SetRecipeItem(9294, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(9144, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddWorldDrop(Z.EASTERN_KINGDOMS)

    -- Philosopher's Stone -- 11459
    recipe = AddRecipe(11459, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(225, 225, 240, 260, 280)
    recipe:SetRecipeItem(9303, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(9149, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ALCHEMY_TRINKET")
    recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
    recipe:AddVendor(5594)

    -- Elixir of Detect Undead -- 11460
    recipe = AddRecipe(11460, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(230, 230, 245, 265, 285)
    recipe:SetCraftedItem(9154, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddTrainer(1386, 2837, 4900, 4160, 3184, 2132, 27029, 3347, 16723, 3603, 33608, 1215, 4611, 16642, 5177, 19052,
        16588, 5499, 1470, 3964, 16161, 33674, 3009, 27023, 2391, 7948, 18802)

    -- Arcane Elixir -- 11461
    recipe = AddRecipe(11461, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(235, 235, 250, 270, 290)
    recipe:SetCraftedItem(9155, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
    recipe:AddTrainer(1386, 2837, 4900, 4160, 3184, 2132, 27029, 3347, 16723, 3603, 33608, 1215, 4611, 16642, 5177, 19052,
        16588, 5499, 1470, 3964, 16161, 33674, 3009, 27023, 2391, 7948, 18802)

    -- Invisibility Potion -- 11464
    recipe = AddRecipe(11464, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(235, 235, 250, 270, 290)
    recipe:SetRecipeItem(9295, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(9172, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

    -- Elixir of Greater Intellect -- 11465
    recipe = AddRecipe(11465, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(235, 235, 250, 270, 290)
    recipe:SetCraftedItem(9179, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddFilters(F.CASTER, F.HEALER)
    recipe:AddTrainer(1386, 2837, 4900, 4160, 3184, 2132, 27029, 3347, 16723, 3603, 33608, 1215, 4611, 16642, 5177, 19052,
        16588, 5499, 1470, 3964, 16161, 33674, 3009, 27023, 2391, 7948, 18802)

    -- Gift of Arthas -- 11466
    recipe = AddRecipe(11466, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(240, 240, 255, 275, 295)
    recipe:SetRecipeItem(9296, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(9088, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:Retire()

    -- Elixir of Greater Agility -- 11467
    recipe = AddRecipe(11467, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(240, 240, 255, 275, 295)
    recipe:SetCraftedItem(9187, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddFilters(F.DPS)
    recipe:AddTrainer(1386, 2837, 4900, 4160, 3184, 2132, 27029, 3347, 16723, 3603, 33608, 1215, 4611, 16642, 5177, 19052,
        16588, 5499, 1470, 3964, 16161, 33674, 3009, 27023, 2391, 7948, 18802)

    -- Elixir of Dream Vision -- 11468
    recipe = AddRecipe(11468, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(240, 240, 255, 275, 295)
    recipe:SetRecipeItem(9297, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(9197, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

    -- Elixir of Giants -- 11472
    recipe = AddRecipe(11472, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(245, 245, 260, 280, 300)
    recipe:SetRecipeItem(9298, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(9206, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddFilters(F.DPS)
    recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

    -- Ghost Dye -- 11473
    recipe = AddRecipe(11473, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(245, 245, 260, 280, 300)
    recipe:SetRecipeItem(9302, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(9210, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_MISC")
    recipe:AddLimitedVendor(8157, 1, 8158, 1)

    -- Elixir of Shadow Power -- 11476
    recipe = AddRecipe(11476, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(250, 250, 265, 285, 305)
    recipe:SetRecipeItem(9301, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(9264, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddFilters(F.CASTER, F.HEALER)
    recipe:AddLimitedVendor(1313, 1, 4610, 1)

    -- Elixir of Demonslaying -- 11477
    recipe = AddRecipe(11477, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(250, 250, 265, 285, 305)
    recipe:SetRecipeItem(9300, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(9224, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddFilters(F.DPS)
    recipe:AddLimitedVendor(8177, 1, 8178, 1)

    -- Elixir of Detect Demon -- 11478
    recipe = AddRecipe(11478, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(250, 250, 265, 285, 305)
    recipe:SetCraftedItem(9233, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddTrainer(1386, 2837, 4900, 4160, 3184, 2132, 27029, 3347, 16723, 3603, 33608, 1215, 4611, 16642, 5177, 19052,
        16588, 5499, 1470, 3964, 16161, 33674, 3009, 27023, 2391, 7948, 18802)

    -- Transmute: Iron to Gold -- 11479
    recipe = AddRecipe(11479, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(225, 225, 240, 260, 280)
    recipe:SetRecipeItem(9304, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(3577, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddVendor(5594)

    -- Transmute: Mithril to Truesilver -- 11480
    recipe = AddRecipe(11480, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(225, 225, 240, 260, 280)
    recipe:SetRecipeItem(9305, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(6037, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddLimitedVendor(5594, 1)

    -- Catseye Elixir -- 12609
    recipe = AddRecipe(12609, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(200, 200, 220, 240, 260)
    recipe:SetCraftedItem(10592, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddTrainer(1386, 2837, 4900, 16642, 3184, 2132, 27029, 3347, 16723, 3603, 4160, 1215, 4611, 33608, 5177, 19052,
        16588, 5499, 1470, 3964, 16161, 33674, 3009, 27023, 2391, 7948, 18802)

    -- Dreamless Sleep Potion -- 15833
    recipe = AddRecipe(15833, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(230, 230, 245, 265, 285)
    recipe:SetCraftedItem(12190, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(1386, 2837, 4900, 4160, 3184, 2132, 27029, 3347, 16723, 3603, 33608, 1215, 4611, 16642, 5177, 19052,
        16588, 5499, 1470, 3964, 16161, 33674, 3009, 27023, 2391, 7948, 18802)

    -- Transmute: Arcanite -- 17187
    recipe = AddRecipe(17187, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(275, 275, 275, 282, 290)
    recipe:SetRecipeItem(12958, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(12360, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddVendor(5594)

    -- Stonescale Oil -- 17551
    recipe = AddRecipe(17551, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(250, 250, 250, 255, 260)
    recipe:SetCraftedItem(13423, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_OIL")
    recipe:AddTrainer(1386, 2837, 4900, 4160, 3184, 2132, 27029, 3347, 16723, 3603, 33608, 1215, 4611, 16642, 5177, 19052,
        16588, 5499, 1470, 3964, 16161, 33674, 3009, 27023, 2391, 7948, 18802)

    -- Mighty Rage Potion -- 17552
    recipe = AddRecipe(17552, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(255, 255, 270, 290, 310)
    recipe:SetCraftedItem(13442, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddFilters(F.DPS, F.TANK, F.DRUID, F.WARRIOR)
    recipe:AddTrainer(1386, 2837, 4900, 4160, 3184, 2132, 27029, 3347, 16723, 3603, 33608, 1215, 4611, 16642, 5177, 19052,
        16588, 5499, 1470, 3964, 16161, 33674, 3009, 27023, 2391, 7948, 18802)

    -- Superior Mana Potion -- 17553
    recipe = AddRecipe(17553, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(260, 260, 275, 295, 315)
    recipe:SetCraftedItem(13443, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(1386, 2837, 4900, 4160, 3184, 2132, 27029, 3347, 16723, 3603, 33608, 1215, 4611, 16642, 5177, 19052,
        16588, 5499, 1470, 3964, 16161, 33674, 3009, 27023, 2391, 7948, 18802)

    -- Elixir of Superior Defense -- 17554
    recipe = AddRecipe(17554, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(265, 265, 280, 300, 320)
    recipe:SetRecipeItem(13478, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(13445, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddFilters(F.TANK)
    recipe:AddLimitedVendor(3348, 1, 5178, 1)

    -- Elixir of the Sages -- 17555
    recipe = AddRecipe(17555, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(270, 270, 285, 305, 325)
    recipe:SetCraftedItem(13447, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddFilters(F.CASTER, F.HEALER)
    recipe:AddTrainer(1386, 2837, 4900, 4160, 3184, 2132, 27029, 3347, 16723, 3603, 33608, 1215, 4611, 16642, 5177, 19052,
        16588, 5499, 1470, 3964, 16161, 33674, 3009, 27023, 2391, 7948, 18802)

    -- Major Healing Potion -- 17556
    recipe = AddRecipe(17556, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(275, 275, 290, 310, 330)
    recipe:SetCraftedItem(13446, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(1386, 2837, 4900, 4160, 3184, 2132, 27029, 3347, 16723, 3603, 33608, 1215, 4611, 16642, 5177, 19052,
        16588, 5499, 1470, 3964, 16161, 33674, 3009, 27023, 2391, 7948, 18802)

    -- Elixir of Brute Force -- 17557
    recipe = AddRecipe(17557, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(275, 275, 290, 310, 330)
    recipe:SetCraftedItem(13453, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddTrainer(1386, 2837, 4900, 4160, 3184, 2132, 27029, 3347, 16723, 3603, 33608, 1215, 4611, 16642, 5177, 19052,
        16588, 5499, 1470, 3964, 16161, 33674, 3009, 27023, 2391, 7948, 18802)

    -- Transmute: Air to Fire -- 17559
    recipe = AddRecipe(17559, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(275, 275, 275, 282, 290)
    recipe:SetRecipeItem(13482, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(7078, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddRepVendor(FAC.ARGENT_DAWN, REP.HONORED, 10856, 10857, 11536)

    -- Transmute: Fire to Earth -- 17560
    recipe = AddRecipe(17560, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(275, 275, 275, 282, 290)
    recipe:SetRecipeItem(13483, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(7076, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddVendor(9499)

    -- Transmute: Earth to Water -- 17561
    recipe = AddRecipe(17561, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(275, 275, 275, 282, 290)
    recipe:SetRecipeItem(13484, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(7080, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddRepVendor(FAC.TIMBERMAW_HOLD, REP.FRIENDLY, 11557)

    -- Transmute: Water to Air -- 17562
    recipe = AddRecipe(17562, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(275, 275, 275, 282, 290)
    recipe:SetRecipeItem(13485, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(7082, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddVendor(11278)

    -- Transmute: Undeath to Water -- 17563
    recipe = AddRecipe(17563, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(275, 275, 275, 282, 290)
    recipe:SetRecipeItem(13486, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(7080, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

    -- Transmute: Water to Undeath -- 17564
    recipe = AddRecipe(17564, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(275, 275, 275, 282, 290)
    recipe:SetRecipeItem(13487, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(12808, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

    -- Transmute: Life to Earth -- 17565
    recipe = AddRecipe(17565, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(275, 275, 275, 282, 290)
    recipe:SetRecipeItem(13488, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(7076, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

    -- Transmute: Earth to Life -- 17566
    recipe = AddRecipe(17566, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(275, 275, 275, 282, 290)
    recipe:SetRecipeItem(13489, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(12803, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

    -- Greater Stoneshield Potion -- 17570
    recipe = AddRecipe(17570, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(280, 280, 295, 315, 335)
    recipe:SetRecipeItem(13490, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(13455, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddFilters(F.TANK)
    recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

    -- Elixir of the Mongoose -- 17571
    recipe = AddRecipe(17571, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(280, 280, 295, 315, 335)
    recipe:SetRecipeItem(13491, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(13452, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
    recipe:Retire()

    -- Purification Potion -- 17572
    recipe = AddRecipe(17572, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(285, 285, 300, 320, 340)
    recipe:SetCraftedItem(13462, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(1386, 2837, 4900, 4160, 3184, 2132, 27029, 3347, 16723, 3603, 33608, 1215, 4611, 16642, 5177, 19052,
        16588, 5499, 1470, 3964, 16161, 33674, 3009, 27023, 2391, 7948, 18802)

    -- Greater Arcane Elixir -- 17573
    recipe = AddRecipe(17573, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(285, 285, 300, 320, 340)
    recipe:SetCraftedItem(13454, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
    recipe:AddTrainer(1386, 2837, 4900, 4160, 3184, 2132, 27029, 3347, 16723, 3603, 33608, 1215, 4611, 16642, 5177, 19052,
        16588, 5499, 1470, 3964, 16161, 33674, 3009, 27023, 2391, 7948, 18802)

    -- Greater Fire Protection Potion -- 17574
    recipe = AddRecipe(17574, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(290, 290, 305, 325, 345)
    recipe:SetRecipeItem(13494, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(13457, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddMobDrop(9262, 9264)

    -- Greater Frost Protection Potion -- 17575
    recipe = AddRecipe(17575, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(290, 290, 305, 325, 345)
    recipe:SetRecipeItem(13495, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(13456, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:Retire()

    -- Greater Nature Protection Potion -- 17576
    recipe = AddRecipe(17576, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(290, 290, 305, 325, 345)
    recipe:SetRecipeItem(13496, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(13458, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddLimitedVendor(15174, 1)

    -- Greater Arcane Protection Potion -- 17577
    recipe = AddRecipe(17577, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(290, 290, 305, 325, 345)
    recipe:SetRecipeItem(13497, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(13461, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:Retire()

    -- Greater Shadow Protection Potion -- 17578
    recipe = AddRecipe(17578, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(290, 290, 305, 325, 345)
    recipe:SetRecipeItem(13499, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(13459, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:Retire()

    -- Major Mana Potion -- 17580
    recipe = AddRecipe(17580, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(295, 295, 310, 330, 350)
    recipe:SetRecipeItem(13501, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(13444, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddMobDrop(1853)
    recipe:AddVendor(11278)

    -- Alchemist Stone -- 17632
    recipe = AddRecipe(17632, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(350, 350, 365, 372, 380)
    recipe:SetRecipeItem(13517, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(13503, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ALCHEMY_TRINKET")
    recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
    recipe:AddRepVendor(FAC.THE_SHATAR, REP.REVERED, 21432)

    -- Potion of Petrification -- 17634
    recipe = AddRecipe(17634, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(300, 300, 315, 322, 330)
    recipe:SetRecipeItem(13518, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(13506, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

    -- Flask of the Titans -- 17635
    recipe = AddRecipe(17635, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(300, 300, 315, 322, 330)
    recipe:SetRecipeItem(31354, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(13510, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_FLASK")
    recipe:AddRepVendor(FAC.THE_SHATAR, REP.EXALTED, 21432)

    -- Flask of Distilled Wisdom -- 17636
    recipe = AddRecipe(17636, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(300, 300, 315, 322, 330)
    recipe:SetRecipeItem(31356, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(13511, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_FLASK")
    recipe:AddFilters(F.CASTER, F.HEALER)
    recipe:AddRepVendor(FAC.CENARION_EXPEDITION, REP.EXALTED, 17904)
    recipe:AddMobDrop(10813)

    -- Flask of Supreme Power -- 17637
    recipe = AddRecipe(17637, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(300, 300, 315, 322, 330)
    recipe:SetRecipeItem(31355, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(13512, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_FLASK")
    recipe:AddFilters(F.CASTER, F.HEALER)
    recipe:AddRepVendor(FAC.KEEPERS_OF_TIME, REP.EXALTED, 21643)

    -- Elixir of Frost Power -- 21923
    recipe = AddRecipe(21923, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(190, 190, 210, 230, 250)
    recipe:SetRecipeItem(17709, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(17708, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddFilters(F.CASTER, F.HEALER)
    recipe:AddWorldEvent("WINTER_VEIL")

    -- Major Rejuvenation Potion -- 22732
    recipe = AddRecipe(22732, V.ORIG, Q.RARE)
    recipe:SetSkillLevels(300, 300, 310, 320, 330)
    recipe:SetRecipeItem(18257, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(18253, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddWorldDrop(Z.MOLTEN_CORE)

    -- Elixir of Greater Water Breathing -- 22808
    recipe = AddRecipe(22808, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(215, 215, 230, 250, 270)
    recipe:SetCraftedItem(18294, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddTrainer(1386, 2837, 4900, 16642, 3184, 2132, 27029, 3347, 16723, 3603, 18802, 4611, 4160, 5177, 19052,
        16588, 7948, 1470, 3964, 16161, 33608, 3009, 27023, 33674, 2391, 1215)

    -- Gurubashi Mojo Madness -- 24266
    recipe = AddRecipe(24266, V.ORIG, Q.RARE)
    recipe:SetSkillLevels(300, 300, 315, 322, 330)
    recipe:SetCraftedItem(19931, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_MISC")
    recipe:Retire()

    -- Mageblood Elixir -- 24365
    recipe = AddRecipe(24365, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(275, 275, 290, 310, 330)
    recipe:SetRecipeItem(20011, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(20007, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddFilters(F.CASTER, F.HEALER)
    recipe:Retire()

    -- Greater Dreamless Sleep Potion -- 24366
    recipe = AddRecipe(24366, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(275, 275, 290, 310, 330)
    recipe:SetRecipeItem(20012, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(20002, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:Retire()

    -- Living Action Potion -- 24367
    recipe = AddRecipe(24367, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(285, 285, 300, 320, 340)
    recipe:SetRecipeItem(20013, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(20008, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddVendor(11188)

    -- Mighty Troll's Blood Elixir -- 24368
    recipe = AddRecipe(24368, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(290, 290, 305, 325, 345)
    recipe:SetRecipeItem(20014, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(20004, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:Retire()

    -- Transmute: Elemental Fire -- 25146
    recipe = AddRecipe(25146, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(300, 300, 301, 305, 310)
    recipe:SetRecipeItem(20761, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(7068, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddRepVendor(FAC.THORIUM_BROTHERHOOD, REP.FRIENDLY, 12944)

    -- Elixir of Greater Firepower -- 26277
    recipe = AddRecipe(26277, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(250, 250, 265, 285, 305)
    recipe:SetRecipeItem(21547, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(21546, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddFilters(F.CASTER, F.HEALER)
    recipe:Retire()

    -- ----------------------------------------------------------------------------
    -- The Burning Crusade.
    -- ----------------------------------------------------------------------------
    -- Elixir of Camouflage -- 28543
    recipe = AddRecipe(28543, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(305, 305, 320, 327, 335)
    recipe:SetRecipeItem(22900, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(22823, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddLimitedVendor(16588, 1, 16641, 1, 16705, 1, 18802, 1)

    -- Elixir of Major Strength -- 28544
    recipe = AddRecipe(28544, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(5, 5, 15, 20, 25)
    recipe:SetCraftedItem(22824, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddFilters(F.DPS)
    recipe:AddTrainer(18802, 19052, 33674, 27023, 33608, 16588, 27029)

    -- Elixir of Healing Power -- 28545
    recipe = AddRecipe(28545, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(10, 10, 20, 25, 30)
    recipe:SetCraftedItem(22825, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddFilters(F.CASTER, F.HEALER)
    recipe:AddTrainer(18802, 19052, 33674, 27023, 33608, 16588, 27029)

    -- Sneaking Potion -- 28546
    recipe = AddRecipe(28546, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(315, 315, 330, 337, 345)
    recipe:SetRecipeItem(22901, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(22826, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddLimitedVendor(18017, 1, 19042, 1)

    -- Elixir of Major Frost Power -- 28549
    recipe = AddRecipe(28549, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(320, 320, 335, 342, 350)
    recipe:SetRecipeItem(22902, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(22827, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddFilters(F.CASTER, F.HEALER)
    recipe:AddLimitedVendor(18005, 1, 18017, 1)

    -- Insane Strength Potion -- 28550
    recipe = AddRecipe(28550, V.TBC, Q.UNCOMMON)
    recipe:SetSkillLevels(320, 320, 335, 342, 350)
    recipe:SetRecipeItem(22903, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(22828, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddFilters(F.DPS, F.TANK)
    recipe:AddWorldDrop(Z.OUTLAND)

    -- Super Healing Potion -- 28551
    recipe = AddRecipe(28551, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(25, 25, 35, 40, 45)
    recipe:SetCraftedItem(22829, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(18802, 19052, 33674, 27023, 33608, 16588, 27029)

    -- Elixir of the Searching Eye -- 28552
    recipe = AddRecipe(28552, V.TBC, Q.UNCOMMON)
    recipe:SetSkillLevels(325, 325, 340, 347, 355)
    recipe:SetRecipeItem(22904, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(22830, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddWorldDrop(Z.OUTLAND)

    -- Elixir of Major Agility -- 28553
    recipe = AddRecipe(28553, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(330, 330, 345, 352, 360)
    recipe:SetRecipeItem(22905, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(22831, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
    recipe:AddRepVendor(FAC.HONOR_HOLD, REP.HONORED, 17657)
    recipe:AddRepVendor(FAC.THRALLMAR, REP.HONORED, 17585)

    -- Shrouding Potion -- 28554
    recipe = AddRecipe(28554, V.TBC, Q.UNCOMMON)
    recipe:SetSkillLevels(335, 335, 350, 357, 365)
    recipe:SetRecipeItem(22906, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(22871, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddRepVendor(FAC.SPOREGGAR, REP.EXALTED, 18382)

    -- Super Mana Potion -- 28555
    recipe = AddRecipe(28555, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(340, 340, 355, 362, 370)
    recipe:SetRecipeItem(22907, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(22832, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddLimitedVendor(18005, 1, 19837, 1)

    -- Elixir of Major Firepower -- 28556
    recipe = AddRecipe(28556, V.TBC, Q.UNCOMMON)
    recipe:SetSkillLevels(345, 345, 360, 367, 375)
    recipe:SetRecipeItem(22908, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(22833, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddFilters(F.CASTER, F.HEALER)
    recipe:AddRepVendor(FAC.THE_SCRYERS, REP.REVERED, 19331)

    -- Elixir of Major Defense -- 28557
    recipe = AddRecipe(28557, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(345, 345, 360, 367, 375)
    recipe:SetRecipeItem(22909, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(22834, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddFilters(F.TANK)
    recipe:AddLimitedVendor(18005, 1, 19837, 1)

    -- Elixir of Major Shadow Power -- 28558
    recipe = AddRecipe(28558, V.TBC, Q.UNCOMMON)
    recipe:SetSkillLevels(50, 50, 65, 70, 75)
    recipe:SetRecipeItem(22910, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(22835, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddFilters(F.CASTER, F.HEALER)
    recipe:AddRepVendor(FAC.LOWER_CITY, REP.REVERED, 21655)

    -- Major Dreamless Sleep Potion -- 28562
    recipe = AddRecipe(28562, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(50, 50, 65, 70, 75)
    recipe:SetRecipeItem(22911, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(22836, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddLimitedVendor(19042, 1, 19837, 1)

    -- Heroic Potion -- 28563
    recipe = AddRecipe(28563, V.TBC, Q.UNCOMMON)
    recipe:SetSkillLevels(50, 50, 65, 70, 75)
    recipe:SetRecipeItem(22912, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(22837, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddFilters(F.DPS)
    recipe:AddWorldDrop(Z.OUTLAND)

    -- Haste Potion -- 28564
    recipe = AddRecipe(28564, V.TBC, Q.UNCOMMON)
    recipe:SetSkillLevels(50, 50, 65, 70, 75)
    recipe:SetRecipeItem(35295, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(22838, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
    recipe:AddMobDrop(24664)

    -- Destruction Potion -- 28565
    recipe = AddRecipe(28565, V.TBC, Q.UNCOMMON)
    recipe:SetSkillLevels(50, 50, 65, 70, 75)
    recipe:SetRecipeItem(22914, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(22839, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddFilters(F.CASTER, F.HEALER)
    recipe:AddWorldDrop(Z.OUTLAND)

    -- Transmute: Primal Air to Fire -- 28566
    recipe = AddRecipe(28566, V.TBC, Q.UNCOMMON)
    recipe:SetSkillLevels(50, 50, 65, 70, 75)
    recipe:SetRecipeItem(22915, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(21884, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddRepVendor(FAC.THE_SHATAR, REP.REVERED, 21432)

    -- Transmute: Primal Earth to Water -- 28567
    recipe = AddRecipe(28567, V.TBC, Q.UNCOMMON)
    recipe:SetSkillLevels(50, 50, 65, 70, 75)
    recipe:SetRecipeItem(22916, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(21885, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddRepVendor(FAC.SPOREGGAR, REP.REVERED, 18382)

    -- Transmute: Primal Fire to Earth -- 28568
    recipe = AddRecipe(28568, V.TBC, Q.UNCOMMON)
    recipe:SetSkillLevels(50, 50, 65, 70, 75)
    recipe:SetRecipeItem(30443, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(22452, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddRepVendor(FAC.KURENAI, REP.REVERED, 20240)
    recipe:AddRepVendor(FAC.THE_MAGHAR, REP.REVERED, 20241)

    -- Transmute: Primal Water to Air -- 28569
    recipe = AddRecipe(28569, V.TBC, Q.UNCOMMON)
    recipe:SetSkillLevels(50, 50, 65, 70, 75)
    recipe:SetRecipeItem(22918, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(22451, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddRepVendor(FAC.CENARION_EXPEDITION, REP.REVERED, 17904)

    -- Elixir of Major Mageblood -- 28570
    recipe = AddRecipe(28570, V.TBC, Q.UNCOMMON)
    recipe:SetSkillLevels(50, 50, 65, 70, 75)
    recipe:SetRecipeItem(22919, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(22840, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddFilters(F.CASTER, F.HEALER)
    recipe:AddWorldDrop(Z.OUTLAND)

    -- Major Fire Protection Potion -- 28571
    recipe = AddRecipe(28571, V.TBC, Q.UNCOMMON)
    recipe:SetSkillLevels(50, 50, 65, 70, 75)
    recipe:SetRecipeItem(22920, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(22841, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddMobDrop(19168, 19221)

    -- Major Frost Protection Potion -- 28572
    recipe = AddRecipe(28572, V.TBC, Q.UNCOMMON)
    recipe:SetSkillLevels(50, 50, 65, 70, 75)
    recipe:SetRecipeItem(22921, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(22842, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddMobDrop(18344)

    -- Major Nature Protection Potion -- 28573
    recipe = AddRecipe(28573, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(50, 50, 65, 70, 75)
    recipe:SetRecipeItem(22922, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(22844, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddRepVendor(FAC.CENARION_EXPEDITION, REP.EXALTED, 17904)

    -- Major Arcane Protection Potion -- 28575
    recipe = AddRecipe(28575, V.TBC, Q.UNCOMMON)
    recipe:SetSkillLevels(50, 50, 65, 70, 75)
    recipe:SetRecipeItem(22923, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(22845, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddMobDrop(17150)

    -- Major Shadow Protection Potion -- 28576
    recipe = AddRecipe(28576, V.TBC, Q.UNCOMMON)
    recipe:SetSkillLevels(50, 50, 65, 70, 75)
    recipe:SetRecipeItem(22924, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(22846, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddMobDrop(21302)

    -- Major Holy Protection Potion -- 28577
    recipe = AddRecipe(28577, V.TBC, Q.UNCOMMON)
    recipe:SetSkillLevels(50, 50, 65, 70, 75)
    recipe:SetRecipeItem(22925, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(22847, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddMobDrop(19973)

    -- Elixir of Empowerment -- 28578
    recipe = AddRecipe(28578, V.TBC, Q.UNCOMMON)
    recipe:SetSkillLevels(50, 50, 65, 70, 75)
    recipe:SetRecipeItem(35294, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(22848, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddMobDrop(24664)
    recipe:AddWorldDrop(Z.OUTLAND)

    -- Ironshield Potion -- 28579
    recipe = AddRecipe(28579, V.TBC, Q.UNCOMMON)
    recipe:SetSkillLevels(50, 50, 65, 70, 75)
    recipe:SetRecipeItem(22927, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(22849, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddFilters(F.TANK)
    recipe:AddMobDrop(17862)

    -- Transmute: Primal Shadow to Water -- 28580
    recipe = AddRecipe(28580, V.TBC, Q.UNCOMMON)
    recipe:SetSkillLevels(75, 75, 75, 75, 75)
    recipe:SetCraftedItem(21885, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddDiscovery("DISCOVERY_ALCH_BC_XMUTE")

    -- Transmute: Primal Water to Shadow -- 28581
    recipe = AddRecipe(28581, V.TBC, Q.UNCOMMON)
    recipe:SetSkillLevels(75, 75, 75, 75, 75)
    recipe:SetCraftedItem(22456, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddDiscovery("DISCOVERY_ALCH_BC_XMUTE")

    -- Transmute: Primal Mana to Fire -- 28582
    recipe = AddRecipe(28582, V.TBC, Q.UNCOMMON)
    recipe:SetSkillLevels(75, 75, 75, 75, 75)
    recipe:SetCraftedItem(21884, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddDiscovery("DISCOVERY_ALCH_BC_XMUTE")

    -- Transmute: Primal Fire to Mana -- 28583
    recipe = AddRecipe(28583, V.TBC, Q.UNCOMMON)
    recipe:SetSkillLevels(75, 75, 75, 75, 75)
    recipe:SetCraftedItem(22457, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddDiscovery("DISCOVERY_ALCH_BC_XMUTE")

    -- Transmute: Primal Life to Earth -- 28584
    recipe = AddRecipe(28584, V.TBC, Q.UNCOMMON)
    recipe:SetSkillLevels(75, 75, 75, 75, 75)
    recipe:SetCraftedItem(22452, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddDiscovery("DISCOVERY_ALCH_BC_XMUTE")

    -- Transmute: Primal Earth to Life -- 28585
    recipe = AddRecipe(28585, V.TBC, Q.UNCOMMON)
    recipe:SetSkillLevels(75, 75, 75, 75, 75)
    recipe:SetCraftedItem(21886, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddDiscovery("DISCOVERY_ALCH_BC_XMUTE")

    -- Super Rejuvenation Potion -- 28586
    recipe = AddRecipe(28586, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(75, 75, 75, 75, 75)
    recipe:SetCraftedItem(22850, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddDiscovery("DISCOVERY_ALCH_POTION")

    -- Flask of Fortification -- 28587
    recipe = AddRecipe(28587, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(75, 75, 75, 75, 75)
    recipe:SetCraftedItem(22851, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_FLASK")
    recipe:AddFilters(F.TANK)
    recipe:AddDiscovery("DISCOVERY_ALCH_ELIXIRFLASK")

    -- Flask of Mighty Versatility -- 28588
    recipe = AddRecipe(28588, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(75, 75, 75, 75, 75)
    recipe:SetCraftedItem(22853, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_FLASK")
    recipe:AddFilters(F.CASTER, F.HEALER)
    recipe:AddDiscovery("DISCOVERY_ALCH_ELIXIRFLASK")

    -- Flask of Relentless Assault -- 28589
    recipe = AddRecipe(28589, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(75, 75, 75, 75, 75)
    recipe:SetCraftedItem(22854, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_FLASK")
    recipe:AddFilters(F.DPS)
    recipe:AddDiscovery("DISCOVERY_ALCH_ELIXIRFLASK")

    -- Flask of Blinding Light -- 28590
    recipe = AddRecipe(28590, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(75, 75, 75, 75, 75)
    recipe:SetCraftedItem(22861, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_FLASK")
    recipe:AddFilters(F.CASTER, F.HEALER)
    recipe:AddDiscovery("DISCOVERY_ALCH_ELIXIRFLASK")

    -- Flask of Pure Death -- 28591
    recipe = AddRecipe(28591, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(75, 75, 75, 75, 75)
    recipe:SetCraftedItem(22866, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_FLASK")
    recipe:AddFilters(F.CASTER, F.HEALER)
    recipe:AddDiscovery("DISCOVERY_ALCH_ELIXIRFLASK")

    -- Transmute: Primal Might -- 29688
    recipe = AddRecipe(29688, V.TBC, Q.UNCOMMON)
    recipe:SetSkillLevels(75, 75, 75, 75, 75)
    recipe:SetRecipeItem(23574, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(23571, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddLimitedVendor(16641, 1, 16705, 1, 19074, 1)

    -- Transmute: Earthstorm Diamond -- 32765
    recipe = AddRecipe(32765, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(75, 75, 75, 75, 75)
    recipe:SetRecipeItem(25869, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(25867, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddRepVendor(FAC.CENARION_EXPEDITION, REP.HONORED, 17904)

    -- Transmute: Skyfire Diamond -- 32766
    recipe = AddRecipe(32766, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(75, 75, 75, 75, 75)
    recipe:SetRecipeItem(29232, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(25868, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddRepVendor(FAC.HONOR_HOLD, REP.HONORED, 17657)
    recipe:AddRepVendor(FAC.THRALLMAR, REP.HONORED, 17585)

    -- Volatile Healing Potion -- 33732
    recipe = AddRecipe(33732, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 11, 16, 21)
    recipe:SetCraftedItem(28100, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(18802, 19052, 33674, 27023, 33608, 16588, 27029)

    -- Unstable Mana Potion -- 33733
    recipe = AddRecipe(33733, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(10, 10, 20, 25, 30)
    recipe:SetCraftedItem(28101, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(18802, 19052, 33674, 27023, 33608, 16588, 27029)

    -- Onslaught Elixir -- 33738
    recipe = AddRecipe(33738, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 11, 16, 21)
    recipe:SetCraftedItem(28102, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddFilters(F.DPS)
    recipe:AddTrainer(18802, 19052, 33674, 27023, 33608, 16588, 27029)

    -- Adept's Elixir -- 33740
    recipe = AddRecipe(33740, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 11, 16, 21)
    recipe:SetCraftedItem(28103, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
    recipe:AddTrainer(18802, 19052, 33674, 27023, 33608, 16588, 27029)

    -- Elixir of Mastery -- 33741
    recipe = AddRecipe(33741, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(15, 15, 25, 30, 35)
    recipe:SetCraftedItem(28104, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddTrainer(18802, 19052, 33674, 27023, 33608, 16588, 27029)

    -- Mercurial Stone -- 38070
    recipe = AddRecipe(38070, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(25, 25, 35, 40, 45)
    recipe:SetCraftedItem(31080, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRINKET")
    recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
    recipe:AddTrainer(18802, 19052, 33674, 27023, 33608, 16588, 27029)

    -- Fel Strength Elixir -- 38960
    recipe = AddRecipe(38960, V.TBC, Q.RARE)
    recipe:SetSkillLevels(335, 335, 350, 357, 365)
    recipe:SetRecipeItem(31680, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(31679, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddFilters(F.DPS)
    recipe:AddMobDrop(19740, 19755, 21302, 21314)

    -- Fel Mana Potion -- 38961
    recipe = AddRecipe(38961, V.TBC, Q.RARE)
    recipe:SetSkillLevels(360, 360, 375, 377, 380)
    recipe:SetRecipeItem(31682, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(31677, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddFilters(F.CASTER, F.HEALER)
    recipe:AddMobDrop(19792, 19795, 19796, 19806, 22016, 22017, 22018, 22076, 22093)

    -- Fel Regeneration Potion -- 38962
    recipe = AddRecipe(38962, V.TBC, Q.RARE)
    recipe:SetSkillLevels(345, 345, 360, 367, 375)
    recipe:SetRecipeItem(31681, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(31676, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddMobDrop(19754, 19756, 20878, 20887)

    -- Elixir of Major Fortitude -- 39636
    recipe = AddRecipe(39636, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(10, 10, 20, 25, 30)
    recipe:SetCraftedItem(32062, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddFilters(F.TANK)
    recipe:AddTrainer(18802, 19052, 33674, 27023, 33608, 16588, 27029)

    -- Earthen Elixir -- 39637
    recipe = AddRecipe(39637, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(320, 320, 335, 342, 350)
    recipe:SetRecipeItem(32070, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(32063, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddRepVendor(FAC.CENARION_EXPEDITION, REP.HONORED, 17904)

    -- Elixir of Draenic Wisdom -- 39638
    recipe = AddRecipe(39638, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(20, 20, 30, 35, 40)
    recipe:SetCraftedItem(32067, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddFilters(F.CASTER, F.HEALER)
    recipe:AddTrainer(18802, 19052, 33674, 27023, 33608, 16588, 27029)

    -- Elixir of Ironskin -- 39639
    recipe = AddRecipe(39639, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(330, 330, 345, 352, 360)
    recipe:SetRecipeItem(32071, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(32068, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddVendor(18821, 18822)

    -- Cauldron of Major Arcane Protection -- 41458
    recipe = AddRecipe(41458, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(360, 360, 360, 370, 380)
    recipe:SetCraftedItem(32839, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_CAULDRON")
    recipe:AddDiscovery("DISCOVERY_ALCH_PROT")

    -- Cauldron of Major Fire Protection -- 41500
    recipe = AddRecipe(41500, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(360, 360, 360, 370, 380)
    recipe:SetCraftedItem(32849, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_CAULDRON")
    recipe:AddDiscovery("DISCOVERY_ALCH_PROT")

    -- Cauldron of Major Frost Protection -- 41501
    recipe = AddRecipe(41501, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(360, 360, 360, 370, 380)
    recipe:SetCraftedItem(32850, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_CAULDRON")
    recipe:AddDiscovery("DISCOVERY_ALCH_PROT")

    -- Cauldron of Major Nature Protection -- 41502
    recipe = AddRecipe(41502, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(360, 360, 360, 370, 380)
    recipe:SetCraftedItem(32851, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_CAULDRON")
    recipe:AddDiscovery("DISCOVERY_ALCH_PROT")

    -- Cauldron of Major Shadow Protection -- 41503
    recipe = AddRecipe(41503, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(360, 360, 360, 370, 380)
    recipe:SetCraftedItem(32852, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_CAULDRON")
    recipe:AddDiscovery("DISCOVERY_ALCH_PROT")

    -- Mad Alchemist's Potion -- 45061
    recipe = AddRecipe(45061, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(25, 25, 35, 40, 45)
    recipe:SetCraftedItem(34440, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(18802, 19052, 33674, 27023, 33608, 16588, 27029)

    -- Guardian's Alchemist Stone -- 47046
    recipe = AddRecipe(47046, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(375, 375, 380, 385, 390)
    recipe:SetRecipeItem(35752, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(35748, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ALCHEMY_TRINKET")
    recipe:AddFilters(F.TANK)
    recipe:AddRepVendor(FAC.SHATTERED_SUN_OFFENSIVE, REP.EXALTED, 25032)

    -- Sorcerer's Alchemist Stone -- 47048
    recipe = AddRecipe(47048, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(375, 375, 380, 385, 390)
    recipe:SetRecipeItem(35753, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(35749, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ALCHEMY_TRINKET")
    recipe:AddFilters(F.CASTER, F.HEALER)
    recipe:AddRepVendor(FAC.SHATTERED_SUN_OFFENSIVE, REP.EXALTED, 25032)

    -- Redeemer's Alchemist Stone -- 47049
    recipe = AddRecipe(47049, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(375, 375, 380, 385, 390)
    recipe:SetRecipeItem(35754, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(35750, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ALCHEMY_TRINKET")
    recipe:AddFilters(F.CASTER, F.HEALER)
    recipe:AddRepVendor(FAC.SHATTERED_SUN_OFFENSIVE, REP.EXALTED, 25032)

    -- Assassin's Alchemist Stone -- 47050
    recipe = AddRecipe(47050, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(375, 375, 380, 385, 390)
    recipe:SetRecipeItem(35755, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(35751, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ALCHEMY_TRINKET")
    recipe:AddFilters(F.DPS)
    recipe:AddRepVendor(FAC.SHATTERED_SUN_OFFENSIVE, REP.EXALTED, 25032)

    -- ----------------------------------------------------------------------------
    -- Wrath of the Lich King.
    -- ----------------------------------------------------------------------------
    -- Transmute: Eternal Life to Shadow -- 53771
    recipe = AddRecipe(53771, V.WOTLK, Q.UNCOMMON)
    recipe:SetSkillLevels(405, 405, 405, 415, 425)
    recipe:SetCraftedItem(35627, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddDiscovery("DISCOVERY_ALCH_NORTHREND_XMUTE")

    -- Transmute: Eternal Life to Fire -- 53773
    recipe = AddRecipe(53773, V.WOTLK, Q.UNCOMMON)
    recipe:SetSkillLevels(405, 405, 405, 415, 425)
    recipe:SetCraftedItem(36860, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddDiscovery("DISCOVERY_ALCH_NORTHREND_XMUTE")

    -- Transmute: Eternal Fire to Water -- 53774
    recipe = AddRecipe(53774, V.WOTLK, Q.UNCOMMON)
    recipe:SetSkillLevels(405, 405, 405, 415, 425)
    recipe:SetCraftedItem(35622, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddDiscovery("DISCOVERY_ALCH_NORTHREND_XMUTE")

    -- Transmute: Eternal Fire to Life -- 53775
    recipe = AddRecipe(53775, V.WOTLK, Q.UNCOMMON)
    recipe:SetSkillLevels(405, 405, 405, 415, 425)
    recipe:SetCraftedItem(35625, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddDiscovery("DISCOVERY_ALCH_NORTHREND_XMUTE")

    -- Transmute: Eternal Air to Water -- 53776
    recipe = AddRecipe(53776, V.WOTLK, Q.UNCOMMON)
    recipe:SetSkillLevels(405, 405, 405, 415, 425)
    recipe:SetCraftedItem(35622, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddDiscovery("DISCOVERY_ALCH_NORTHREND_XMUTE")

    -- Transmute: Eternal Air to Earth -- 53777
    recipe = AddRecipe(53777, V.WOTLK, Q.UNCOMMON)
    recipe:SetSkillLevels(405, 405, 405, 415, 425)
    recipe:SetCraftedItem(35624, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddDiscovery("DISCOVERY_ALCH_NORTHREND_XMUTE")

    -- Transmute: Eternal Shadow to Earth -- 53779
    recipe = AddRecipe(53779, V.WOTLK, Q.UNCOMMON)
    recipe:SetSkillLevels(405, 405, 405, 415, 425)
    recipe:SetCraftedItem(35624, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddDiscovery("DISCOVERY_ALCH_NORTHREND_XMUTE")

    -- Transmute: Eternal Shadow to Life -- 53780
    recipe = AddRecipe(53780, V.WOTLK, Q.UNCOMMON)
    recipe:SetSkillLevels(405, 405, 405, 415, 425)
    recipe:SetCraftedItem(35625, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddDiscovery("DISCOVERY_ALCH_NORTHREND_XMUTE")

    -- Transmute: Eternal Earth to Air -- 53781
    recipe = AddRecipe(53781, V.WOTLK, Q.UNCOMMON)
    recipe:SetSkillLevels(405, 405, 405, 415, 425)
    recipe:SetCraftedItem(35623, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddDiscovery("DISCOVERY_ALCH_NORTHREND_XMUTE")

    -- Transmute: Eternal Earth to Shadow -- 53782
    recipe = AddRecipe(53782, V.WOTLK, Q.UNCOMMON)
    recipe:SetSkillLevels(405, 405, 405, 415, 425)
    recipe:SetCraftedItem(35627, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddDiscovery("DISCOVERY_ALCH_NORTHREND_XMUTE")

    -- Transmute: Eternal Water to Air -- 53783
    recipe = AddRecipe(53783, V.WOTLK, Q.UNCOMMON)
    recipe:SetSkillLevels(405, 405, 405, 415, 425)
    recipe:SetCraftedItem(35623, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddDiscovery("DISCOVERY_ALCH_NORTHREND_XMUTE")

    -- Transmute: Eternal Water to Fire -- 53784
    recipe = AddRecipe(53784, V.WOTLK, Q.UNCOMMON)
    recipe:SetSkillLevels(405, 405, 405, 415, 425)
    recipe:SetCraftedItem(36860, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddDiscovery("DISCOVERY_ALCH_NORTHREND_XMUTE")

    -- Pygmy Oil -- 53812
    recipe = AddRecipe(53812, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 11, 16, 21)
    recipe:SetCraftedItem(40195, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_OIL")
    recipe:AddTrainer(26951, 26903, 28703, 26975, 26987, 33588)

    -- Runic Healing Potion -- 53836
    recipe = AddRecipe(53836, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(30, 30, 40, 45, 50)
    recipe:SetCraftedItem(33447, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(26951, 26903, 28703, 26975, 26987, 33588)

    -- Runic Mana Potion -- 53837
    recipe = AddRecipe(53837, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(35, 35, 45, 50, 55)
    recipe:SetCraftedItem(33448, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(26951, 26903, 28703, 26975, 26987, 33588)

    -- Resurgent Healing Potion -- 53838
    recipe = AddRecipe(53838, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 11, 16, 21)
    recipe:SetCraftedItem(39671, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(26951, 26903, 28703, 26975, 26987, 33588)

    -- Icy Mana Potion -- 53839
    recipe = AddRecipe(53839, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 11, 16, 21)
    recipe:SetCraftedItem(40067, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(26951, 26903, 28703, 26975, 26987, 33588)

    -- Elixir of Mighty Agility -- 53840
    recipe = AddRecipe(53840, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(20, 20, 30, 35, 40)
    recipe:SetCraftedItem(39666, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddFilters(F.DPS)
    recipe:AddTrainer(26951, 26903, 28703, 26975, 26987, 33588)

    -- Wrath Elixir -- 53841
    recipe = AddRecipe(53841, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 11, 16, 21)
    recipe:SetCraftedItem(40068, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddFilters(F.DPS)
    recipe:AddTrainer(26951, 26903, 28703, 26975, 26987, 33588)

    -- Spellpower Elixir -- 53842
    recipe = AddRecipe(53842, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 11, 16, 21)
    recipe:SetCraftedItem(40070, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddFilters(F.CASTER, F.HEALER)
    recipe:AddTrainer(26951, 26903, 28703, 26975, 26987, 33588)

    -- Elixir of Spirit -- 53847
    recipe = AddRecipe(53847, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(10, 10, 20, 25, 30)
    recipe:SetCraftedItem(40072, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddFilters(F.CASTER, F.HEALER)
    recipe:AddTrainer(26951, 26903, 28703, 26975, 26987, 33588)

    -- Guru's Elixir -- 53848
    recipe = AddRecipe(53848, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 11, 16, 21)
    recipe:SetCraftedItem(40076, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddTrainer(26951, 26903, 28703, 26975, 26987, 33588)

    -- Crazy Alchemist's Potion -- 53895
    recipe = AddRecipe(53895, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(400, 400, 410, 415, 420)
    recipe:SetCraftedItem(40077, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddDiscovery("DISCOVERY_ALCH_NORTHREND_RESEARCH")

    -- Elixir of Mighty Fortitude -- 53898
    recipe = AddRecipe(53898, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(15, 15, 25, 30, 35)
    recipe:SetCraftedItem(40078, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddFilters(F.TANK)
    recipe:AddTrainer(26951, 26903, 28703, 26975, 26987, 33588)

    -- Lesser Flask of Toughness -- 53899
    recipe = AddRecipe(53899, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 11, 16, 21)
    recipe:SetCraftedItem(40079, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_FLASK")
    recipe:AddTrainer(26951, 26903, 28703, 26975, 26987, 33588)

    -- Potion of Nightmares -- 53900
    recipe = AddRecipe(53900, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(5, 5, 15, 20, 25)
    recipe:SetCraftedItem(40081, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(26951, 26903, 28703, 26975, 26987, 33588)

    -- Flask of the Frost Wyrm -- 53901
    recipe = AddRecipe(53901, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(60, 60, 70, 75, 80)
    recipe:SetCraftedItem(46376, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_FLASK")
    recipe:AddFilters(F.CASTER, F.HEALER)
    recipe:AddTrainer(26951, 26903, 28703, 26975, 26987, 33588)

    -- Flask of Stoneblood -- 53902
    recipe = AddRecipe(53902, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(60, 60, 70, 75, 80)
    recipe:SetCraftedItem(46379, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_FLASK")
    recipe:AddFilters(F.TANK)
    recipe:AddTrainer(26951, 26903, 28703, 26975, 26987, 33588)

    -- Flask of Endless Rage -- 53903
    recipe = AddRecipe(53903, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(60, 60, 70, 75, 80)
    recipe:SetCraftedItem(46377, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_FLASK")
    recipe:AddFilters(F.DPS)
    recipe:AddTrainer(26951, 26903, 28703, 26975, 26987, 33588)

    -- Powerful Rejuvenation Potion -- 53904
    recipe = AddRecipe(53904, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(400, 400, 410, 415, 420)
    recipe:SetCraftedItem(40087, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddDiscovery("DISCOVERY_ALCH_NORTHREND_RESEARCH")

    -- Indestructible Potion -- 53905
    recipe = AddRecipe(53905, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(20, 20, 30, 35, 40)
    recipe:SetCraftedItem(40093, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddFilters(F.TANK)
    recipe:AddTrainer(26951, 26903, 28703, 26975, 26987, 33588)

    -- Mighty Arcane Protection Potion -- 53936
    recipe = AddRecipe(53936, V.WOTLK, Q.UNCOMMON)
    recipe:SetSkillLevels(400, 400, 410, 415, 420)
    recipe:SetRecipeItem(44564, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(40213, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddMobDrop(31702, 32297)

    -- Mighty Frost Protection Potion -- 53937
    recipe = AddRecipe(53937, V.WOTLK, Q.UNCOMMON)
    recipe:SetSkillLevels(400, 400, 410, 415, 420)
    recipe:SetRecipeItem(44566, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(40215, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddMobDrop(32289)

    -- Mighty Shadow Protection Potion -- 53938
    recipe = AddRecipe(53938, V.WOTLK, Q.UNCOMMON)
    recipe:SetSkillLevels(400, 400, 410, 415, 420)
    recipe:SetRecipeItem(44568, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(40217, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddMobDrop(32349)

    -- Mighty Fire Protection Potion -- 53939
    recipe = AddRecipe(53939, V.WOTLK, Q.UNCOMMON)
    recipe:SetSkillLevels(400, 400, 410, 415, 420)
    recipe:SetRecipeItem(44565, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(40214, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddMobDrop(30921)

    -- Mighty Nature Protection Potion -- 53942
    recipe = AddRecipe(53942, V.WOTLK, Q.UNCOMMON)
    recipe:SetSkillLevels(400, 400, 410, 415, 420)
    recipe:SetRecipeItem(44567, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(40216, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddMobDrop(32290)

    -- Flask of Pure Mojo -- 54213
    recipe = AddRecipe(54213, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(60, 60, 70, 75, 80)
    recipe:SetCraftedItem(46378, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_FLASK")
    recipe:AddFilters(F.CASTER, F.HEALER)
    recipe:AddTrainer(26951, 26903, 28703, 26975, 26987, 33588)

    -- Elixir of Mighty Strength -- 54218
    recipe = AddRecipe(54218, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(10, 10, 20, 25, 30)
    recipe:SetCraftedItem(40073, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddFilters(F.DPS)
    recipe:AddTrainer(26951, 26903, 28703, 26975, 26987, 33588)

    -- Elixir of Protection -- 54220
    recipe = AddRecipe(54220, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(400, 400, 410, 415, 420)
    recipe:SetCraftedItem(40097, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddFilters(F.TANK)
    recipe:AddDiscovery("DISCOVERY_ALCH_NORTHREND_RESEARCH")

    -- Potion of Speed -- 54221
    recipe = AddRecipe(54221, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(400, 400, 410, 415, 420)
    recipe:SetCraftedItem(40211, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
    recipe:AddDiscovery("DISCOVERY_ALCH_NORTHREND_RESEARCH")

    -- Potion of Wild Magic -- 54222
    recipe = AddRecipe(54222, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(400, 400, 410, 415, 420)
    recipe:SetCraftedItem(40212, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
    recipe:AddDiscovery("DISCOVERY_ALCH_NORTHREND_RESEARCH")

    -- Elixir of Mighty Mageblood -- 56519
    recipe = AddRecipe(56519, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(400, 400, 410, 415, 420)
    recipe:SetCraftedItem(40109, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddFilters(F.CASTER, F.HEALER)
    recipe:AddDiscovery("DISCOVERY_ALCH_NORTHREND_RESEARCH")

    -- Transmute: Skyflare Diamond -- 57425
    recipe = AddRecipe(57425, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(55, 55, 65, 70, 75)
    recipe:SetCraftedItem(41266, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddTrainer(26951, 26903, 28703, 26975, 26987, 33588)

    -- Transmute: Earthsiege Diamond -- 57427
    recipe = AddRecipe(57427, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(50, 50, 60, 65, 70)
    recipe:SetCraftedItem(41334, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddTrainer(26951, 26903, 28703, 26975, 26987, 33588)

    -- Endless Mana Potion -- 58868
    recipe = AddRecipe(58868, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(35, 35, 45, 50, 55)
    recipe:SetCraftedItem(43570, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(26951, 26903, 28703, 26975, 26987, 33588)

    -- Endless Healing Potion -- 58871
    recipe = AddRecipe(58871, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(35, 35, 45, 50, 55)
    recipe:SetCraftedItem(43569, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(26951, 26903, 28703, 26975, 26987, 33588)

    -- Transmute: Titanium -- 60350
    recipe = AddRecipe(60350, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(20, 20, 30, 35, 40)
    recipe:SetCraftedItem(41163, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddTrainer(26951, 26903, 28703, 26975, 26987, 33588)

    -- Elixir of Accuracy -- 60354
    recipe = AddRecipe(60354, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(400, 400, 415, 422, 430)
    recipe:SetCraftedItem(44325, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
    recipe:AddDiscovery("DISCOVERY_ALCH_NORTHREND_RESEARCH")

    -- Elixir of Deadly Strikes -- 60355
    recipe = AddRecipe(60355, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(400, 400, 410, 415, 420)
    recipe:SetCraftedItem(44327, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
    recipe:AddDiscovery("DISCOVERY_ALCH_NORTHREND_RESEARCH")

    -- Elixir of Mighty Defense -- 60356
    recipe = AddRecipe(60356, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(400, 400, 410, 415, 420)
    recipe:SetCraftedItem(44328, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddFilters(F.TANK)
    recipe:AddDiscovery("DISCOVERY_ALCH_NORTHREND_RESEARCH")

    -- Elixir of Expertise -- 60357
    recipe = AddRecipe(60357, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(400, 400, 410, 415, 420)
    recipe:SetCraftedItem(44329, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
    recipe:AddDiscovery("DISCOVERY_ALCH_NORTHREND_RESEARCH")

    -- Elixir of Armor Piercing -- 60365
    recipe = AddRecipe(60365, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(400, 400, 410, 415, 420)
    recipe:SetCraftedItem(44330, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
    recipe:AddDiscovery("DISCOVERY_ALCH_NORTHREND_RESEARCH")

    -- Elixir of Lightning Speed -- 60366
    recipe = AddRecipe(60366, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(400, 400, 410, 415, 420)
    recipe:SetCraftedItem(44331, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
    recipe:AddDiscovery("DISCOVERY_ALCH_NORTHREND_RESEARCH")

    -- Elixir of Mighty Thoughts -- 60367
    recipe = AddRecipe(60367, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(20, 20, 30, 35, 40)
    recipe:SetCraftedItem(44332, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddFilters(F.CASTER, F.HEALER)
    recipe:AddTrainer(26951, 26903, 28703, 26975, 26987, 33588)

    -- Mercurial Alchemist Stone -- 60396
    recipe = AddRecipe(60396, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(25, 25, 35, 40, 45)
    recipe:SetCraftedItem(44322, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ALCHEMY_TRINKET")
    recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
    recipe:AddTrainer(26951, 26903, 28703, 26975, 26987, 33588)

    -- Indestructible Alchemist Stone -- 60403
    recipe = AddRecipe(60403, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(25, 25, 35, 40, 45)
    recipe:SetCraftedItem(44323, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ALCHEMY_TRINKET")
    recipe:AddFilters(F.TANK)
    recipe:AddTrainer(26951, 26903, 28703, 26975, 26987, 33588)

    -- Mighty Alchemist Stone -- 60405
    recipe = AddRecipe(60405, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(25, 25, 35, 40, 45)
    recipe:SetCraftedItem(44324, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ALCHEMY_TRINKET")
    recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
    recipe:AddTrainer(26951, 26903, 28703, 26975, 26987, 33588)

    -- Northrend Alchemy Research -- 60893
    recipe = AddRecipe(60893, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(25, 25, 35, 40, 45)
    recipe:SetCraftedItem(115460, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_MISC")
    recipe:AddTrainer(26951, 26903, 28703, 26975, 26987, 33588)

    -- Ethereal Oil -- 62409
    recipe = AddRecipe(62409, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 11, 16, 21)
    recipe:SetCraftedItem(44958, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_OIL")
    recipe:AddTrainer(26951, 26903, 28703, 26975, 26987, 33588)

    -- Elixir of Water Walking -- 62410
    recipe = AddRecipe(62410, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(400, 400, 410, 415, 420)
    recipe:SetCraftedItem(8827, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddDiscovery("DISCOVERY_ALCH_NORTHREND_RESEARCH")

    -- Elixir of Minor Accuracy -- 63732
    recipe = AddRecipe(63732, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(135, 135, 160, 180, 200)
    recipe:SetCraftedItem(45621, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
    recipe:AddTrainer(1386, 2837, 4900, 16642, 3184, 2132, 27029, 3347, 16723, 3603, 5499, 18802, 4611, 4160, 5177, 19052,
        16588, 7948, 1470, 3964, 16161, 33608, 3009, 27023, 2391, 33674, 1215)

    -- Transmute: Ametrine -- 66658
    recipe = AddRecipe(66658, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(75, 75, 85, 90, 95)
    recipe:SetCraftedItem(36931, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddTrainer(26951, 26903, 28703, 26975, 26987, 33588)

    -- Transmute: Cardinal Ruby -- 66659
    recipe = AddRecipe(66659, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(450, 450, 450, 452, 465)
    recipe:SetCraftedItem(36919, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddQuest(14151)

    -- Transmute: King's Amber -- 66660
    recipe = AddRecipe(66660, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(75, 75, 85, 90, 95)
    recipe:SetCraftedItem(36922, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddTrainer(26951, 26903, 28703, 26975, 26987, 33588)

    -- Transmute: Dreadstone -- 66662
    recipe = AddRecipe(66662, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(75, 75, 85, 90, 95)
    recipe:SetCraftedItem(36928, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddTrainer(26951, 26903, 28703, 26975, 26987, 33588)

    -- Transmute: Majestic Zircon -- 66663
    recipe = AddRecipe(66663, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(75, 75, 85, 90, 95)
    recipe:SetCraftedItem(36925, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddTrainer(26951, 26903, 28703, 26975, 26987, 33588)

    -- Transmute: Eye of Zul -- 66664
    recipe = AddRecipe(66664, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(75, 75, 85, 90, 95)
    recipe:SetCraftedItem(36934, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddTrainer(26951, 26903, 28703, 26975, 26987, 33588)

    self.InitializeRecipes = nil
end
