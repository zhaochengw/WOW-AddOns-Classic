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
    recipe:AddTrainer(1215, 1246, 1386, 1470, 2132, 2391, 2837, 3009, 3184, 3347, 4160, 4900, 5177, 5499, 7948, 16161,
        16588, 16642, 16723, 17215, 18802, 47384, 47396, 47400, 47418, 47419, 47421, 47431, 48619, 49885, 56777, 57620,
        65043, 85905, 86009, 92456, 92458)

    -- Minor Rejuvenation Potion -- 2332
    recipe = AddRecipe(2332, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(40, 40, 70, 90, 110)
    recipe:SetCraftedItem(2456, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddFilters(F.CASTER, F.HEALER)
    recipe:AddTrainer(1215, 1246, 1386, 1470, 2132, 2391, 2837, 3009, 3184, 3347, 4160, 4900, 5177, 5499, 7948, 16161,
        16588, 16642, 16723, 17215, 18802, 47384, 47396, 47400, 47418, 47419, 47421, 47431, 48619, 49885, 56777, 57620,
        65043, 85905, 86009, 92456, 92458)

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
    recipe:AddTrainer(1215, 1246, 1386, 1470, 2132, 2391, 2837, 3009, 3184, 3347, 4160, 4900, 5177, 5499, 7948, 16161,
        16588, 16642, 16723, 17215, 18802, 47384, 47396, 47400, 47418, 47419, 47421, 47431, 48619, 49885, 56777, 57620,
        65043, 85905, 86009, 92456, 92458)

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
    recipe:AddTrainer(1215, 1246, 1386, 1470, 2132, 2391, 2837, 3009, 3184, 3347, 4160, 4900, 5177, 5499, 7948, 16161,
        16588, 16642, 16723, 17215, 18802, 47384, 47396, 47400, 47418, 47419, 47421, 47431, 48619, 49885, 56777, 57620,
        65043, 85905, 86009, 92456, 92458)

    -- Weak Troll's Blood Elixir -- 3170
    recipe = AddRecipe(3170, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(15, 15, 60, 80, 100)
    recipe:SetCraftedItem(3382, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddTrainer(1215, 1246, 1386, 1470, 2132, 2391, 2837, 3009, 3184, 3347, 4160, 4900, 5177, 5499, 7948, 16161,
        16588, 16642, 16723, 17215, 18802, 47384, 47396, 47400, 47418, 47419, 47421, 47431, 48619, 49885, 56777, 57620,
        65043, 85905, 86009, 92456, 92458)

    -- Elixir of Wisdom -- 3171
    recipe = AddRecipe(3171, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(90, 90, 120, 140, 160)
    recipe:SetCraftedItem(3383, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddFilters(F.CASTER, F.HEALER)
    recipe:AddTrainer(1215, 1386, 1470, 2132, 2391, 2837, 3009, 3184, 3347, 4160, 4900, 5177, 5499, 7948, 16161, 16588,
        16642, 16723, 17215, 18802, 49885, 56777)

    -- Lesser Mana Potion -- 3173
    recipe = AddRecipe(3173, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(120, 120, 145, 165, 185)
    recipe:SetCraftedItem(3385, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddFilters(F.CASTER, F.HEALER)
    recipe:AddTrainer(1215, 1386, 1470, 2132, 2391, 2837, 3009, 3184, 3347, 4160, 4900, 5177, 5499, 7948, 16161, 16588,
        16642, 16723, 17215, 18802, 49885, 56777)

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
    recipe:AddTrainer(1215, 1386, 1470, 2132, 2391, 2837, 3009, 3184, 3347, 4160, 4900, 5177, 5499, 7948, 16161, 16588,
        16642, 16723, 17215, 18802, 49885, 56777)

    -- Elixir of Defense -- 3177
    recipe = AddRecipe(3177, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(130, 130, 155, 175, 195)
    recipe:SetCraftedItem(3389, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddFilters(F.TANK)
    recipe:AddTrainer(1215, 1386, 1470, 2132, 2391, 2837, 3009, 3184, 3347, 4160, 4900, 5177, 5499, 7948, 16161, 16588,
        16642, 16723, 17215, 18802, 49885, 56777)

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
    recipe:AddTrainer(1215, 1386, 1470, 2132, 2391, 2837, 3009, 3184, 3347, 4160, 4900, 5177, 5499, 7948, 16161, 16588,
        16642, 16723, 17215, 18802, 49885, 56777)

    -- Lesser Invisibility Potion -- 3448
    recipe = AddRecipe(3448, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(165, 165, 185, 205, 225)
    recipe:SetCraftedItem(3823, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(1215, 1386, 1470, 2132, 2391, 2837, 3009, 3184, 3347, 4160, 4900, 5177, 5499, 7948, 16161, 16588,
        16642, 16723, 18802, 56777)

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
    recipe:AddTrainer(1215, 1386, 1470, 2132, 2391, 2837, 3009, 3184, 3347, 4160, 4900, 5177, 5499, 7948, 16161, 16588,
        16642, 16723, 18802, 56777)
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
    recipe:AddTrainer(1215, 1386, 1470, 2132, 2391, 2837, 3009, 3184, 3347, 4160, 4900, 5177, 5499, 7948, 16161, 16588,
        16642, 16723, 18802, 56777)

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
    recipe:AddTrainer(1215, 1386, 1470, 2132, 2391, 2837, 3009, 3184, 3347, 4160, 4900, 5177, 5499, 7948, 16161, 16588,
        16642, 16723, 17215, 18802, 49885, 56777)

    -- Greater Healing Potion -- 7181
    recipe = AddRecipe(7181, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(155, 155, 175, 195, 215)
    recipe:SetCraftedItem(1710, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(1215, 1386, 1470, 2132, 2391, 2837, 3009, 3184, 3347, 4160, 4900, 5177, 5499, 7948, 16161, 16588,
        16642, 16723, 18802, 56777)

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
    recipe:AddTrainer(1215, 1386, 1470, 2132, 2391, 2837, 3009, 3184, 3347, 4160, 4900, 5177, 5499, 7948, 16161, 16588,
        16642, 16723, 17215, 18802, 49885, 56777)

    -- Fire Oil -- 7837
    recipe = AddRecipe(7837, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(130, 130, 150, 160, 170)
    recipe:SetCraftedItem(6371, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_OIL")
    recipe:AddTrainer(1215, 1386, 1470, 2132, 2391, 2837, 3009, 3184, 3347, 4160, 4900, 5177, 5499, 7948, 16161, 16588,
        16642, 16723, 17215, 18802, 49885, 56777)

    -- Swim Speed Potion -- 7841
    recipe = AddRecipe(7841, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(100, 100, 130, 150, 170)
    recipe:SetCraftedItem(6372, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(1215, 1386, 1470, 2132, 2391, 2837, 3009, 3184, 3347, 4160, 4900, 5177, 5499, 7948, 16161, 16588,
        16642, 16723, 17215, 18802, 49885, 56777)

    -- Elixir of Firepower -- 7845
    recipe = AddRecipe(7845, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(140, 140, 165, 185, 205)
    recipe:SetCraftedItem(6373, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddFilters(F.CASTER, F.HEALER)
    recipe:AddTrainer(1215, 1386, 1470, 2132, 2391, 2837, 3009, 3184, 3347, 4160, 4900, 5177, 5499, 7948, 16161, 16588,
        16642, 16723, 17215, 18802, 49885, 56777)

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
    recipe:AddTrainer(1215, 1386, 1470, 2132, 2391, 2837, 3009, 3184, 3347, 4160, 4900, 5177, 5499, 7948, 16161, 16588,
        16642, 16723, 18802, 56777)

    -- Elixir of Agility -- 11449
    recipe = AddRecipe(11449, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(185, 185, 205, 225, 245)
    recipe:SetCraftedItem(8949, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddFilters(F.DPS)
    recipe:AddTrainer(1215, 1386, 1470, 2132, 2391, 2837, 3009, 3184, 3347, 4160, 4900, 5177, 5499, 7948, 16161, 16588,
        16642, 16723, 18802, 56777)

    -- Elixir of Greater Defense -- 11450
    recipe = AddRecipe(11450, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(195, 195, 215, 235, 255)
    recipe:SetCraftedItem(8951, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddFilters(F.TANK)
    recipe:AddTrainer(1215, 1386, 1470, 2132, 2391, 2837, 3009, 3184, 3347, 4160, 4900, 5177, 5499, 7948, 16161, 16588,
        16642, 16723, 18802, 56777)

    -- Oil of Immolation -- 11451
    recipe = AddRecipe(11451, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(205, 205, 220, 240, 260)
    recipe:SetCraftedItem(8956, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_OIL")
    recipe:AddTrainer(1215, 1386, 1470, 2132, 2391, 2837, 3009, 3184, 3347, 4160, 4900, 5177, 5499, 7948, 16161, 16588,
        16642, 16723, 18802, 56777)

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
    recipe:AddTrainer(1215, 1386, 1470, 2132, 2391, 2837, 3009, 3184, 3347, 4160, 4900, 5177, 5499, 7948, 16161, 16588,
        16642, 16723, 18802, 56777)

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
    recipe:AddTrainer(1215, 1386, 1470, 2132, 2391, 2837, 3009, 3184, 3347, 4160, 4900, 5177, 5499, 7948, 16161, 16588,
        16642, 16723, 18802, 56777)

    -- Arcane Elixir -- 11461
    recipe = AddRecipe(11461, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(235, 235, 250, 270, 290)
    recipe:SetCraftedItem(9155, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
    recipe:AddTrainer(1215, 1386, 1470, 2132, 2391, 2837, 3009, 3184, 3347, 4160, 4900, 5177, 5499, 7948, 16161, 16588,
        16642, 16723, 18802, 56777)

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
    recipe:AddTrainer(1215, 1386, 1470, 2132, 2391, 2837, 3009, 3184, 3347, 4160, 4900, 5177, 5499, 7948, 16161, 16588,
        16642, 16723, 18802, 56777)

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
    recipe:AddTrainer(1215, 1386, 1470, 2132, 2391, 2837, 3009, 3184, 3347, 4160, 4900, 5177, 5499, 7948, 16161, 16588,
        16642, 16723, 18802, 56777)

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
    recipe:AddTrainer(1215, 1386, 1470, 2132, 2391, 2837, 3009, 3184, 3347, 4160, 4900, 5177, 5499, 7948, 16161, 16588,
        16642, 16723, 18802, 56777)

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
    recipe:AddTrainer(1215, 1386, 1470, 2132, 2391, 2837, 3009, 3184, 3347, 4160, 4900, 5177, 5499, 7948, 16161, 16588,
        16642, 16723, 18802, 56777)

    -- Dreamless Sleep Potion -- 15833
    recipe = AddRecipe(15833, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(230, 230, 245, 265, 285)
    recipe:SetCraftedItem(12190, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(1215, 1386, 1470, 2132, 2391, 2837, 3009, 3184, 3347, 4160, 4900, 5177, 5499, 7948, 16161, 16588,
        16642, 16723, 18802, 56777)

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
    recipe:AddTrainer(1215, 1386, 1470, 2132, 2391, 2837, 3009, 3184, 3347, 4160, 4900, 5177, 5499, 7948, 16161, 16588,
        16642, 16723, 18802, 56777)

    -- Mighty Rage Potion -- 17552
    recipe = AddRecipe(17552, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(255, 255, 270, 290, 310)
    recipe:SetCraftedItem(13442, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddFilters(F.DPS, F.TANK, F.DRUID, F.WARRIOR)
    recipe:AddTrainer(1215, 1386, 1470, 2132, 2391, 2837, 3009, 3184, 3347, 4160, 4900, 5177, 5499, 7948, 16161, 16588,
        16642, 16723, 18802, 56777)

    -- Superior Mana Potion -- 17553
    recipe = AddRecipe(17553, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(260, 260, 275, 295, 315)
    recipe:SetCraftedItem(13443, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(1215, 1386, 1470, 2132, 2391, 2837, 3009, 3184, 3347, 4160, 4900, 5177, 5499, 7948, 16161, 16588,
        16642, 16723, 18802, 56777)

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
    recipe:AddTrainer(1215, 1386, 1470, 2132, 2391, 2837, 3009, 3184, 3347, 4160, 4900, 5177, 5499, 7948, 16161, 16588,
        16642, 16723, 18802, 56777)

    -- Major Healing Potion -- 17556
    recipe = AddRecipe(17556, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(275, 275, 290, 310, 330)
    recipe:SetCraftedItem(13446, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(1215, 1386, 1470, 2132, 2391, 2837, 3009, 3184, 3347, 4160, 4900, 5177, 5499, 7948, 16161, 16588,
        16642, 16723, 18802, 56777)

    -- Elixir of Brute Force -- 17557
    recipe = AddRecipe(17557, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(275, 275, 290, 310, 330)
    recipe:SetCraftedItem(13453, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddTrainer(1215, 1386, 1470, 2132, 2391, 2837, 3009, 3184, 3347, 4160, 4900, 5177, 5499, 7948, 16161, 16588,
        16642, 16723, 18802, 56777)

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
    recipe:AddTrainer(1215, 1386, 1470, 2132, 2391, 2837, 3009, 3184, 3347, 4160, 4900, 5177, 5499, 7948, 16161, 16588,
        16642, 16723, 18802, 56777)

    -- Greater Arcane Elixir -- 17573
    recipe = AddRecipe(17573, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(285, 285, 300, 320, 340)
    recipe:SetCraftedItem(13454, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
    recipe:AddTrainer(1215, 1386, 1470, 2132, 2391, 2837, 3009, 3184, 3347, 4160, 4900, 5177, 5499, 7948, 16161, 16588,
        16642, 16723, 18802, 56777)

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
    recipe:AddTrainer(1215, 1386, 1470, 2132, 2391, 2837, 3009, 3184, 3347, 4160, 4900, 5177, 5499, 7948, 16161, 16588,
        16642, 16723, 18802, 56777)

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
    recipe:AddTrainer(2391, 3184, 5177, 16588, 16723, 18802, 19052, 33608, 33674, 56777)

    -- Elixir of Healing Power -- 28545
    recipe = AddRecipe(28545, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(10, 10, 20, 25, 30)
    recipe:SetCraftedItem(22825, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddFilters(F.CASTER, F.HEALER)
    recipe:AddTrainer(2391, 3184, 5177, 16588, 16723, 18802, 19052, 33608, 33674, 56777)

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
    recipe:AddTrainer(2391, 3184, 5177, 16588, 16723, 18802, 19052, 33608, 33674, 56777)

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
    recipe:AddTrainer(2391, 3184, 5177, 16588, 16723, 18802, 19052, 33608, 33674, 56777)

    -- Unstable Mana Potion -- 33733
    recipe = AddRecipe(33733, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(10, 10, 20, 25, 30)
    recipe:SetCraftedItem(28101, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(2391, 3184, 5177, 16588, 16723, 18802, 19052, 33608, 33674, 56777)

    -- Onslaught Elixir -- 33738
    recipe = AddRecipe(33738, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 11, 16, 21)
    recipe:SetCraftedItem(28102, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddFilters(F.DPS)
    recipe:AddTrainer(2391, 3184, 5177, 16588, 16723, 18802, 19052, 33608, 33674, 56777)

    -- Adept's Elixir -- 33740
    recipe = AddRecipe(33740, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 11, 16, 21)
    recipe:SetCraftedItem(28103, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
    recipe:AddTrainer(2391, 3184, 5177, 16588, 16723, 18802, 19052, 33608, 33674, 56777)

    -- Elixir of Mastery -- 33741
    recipe = AddRecipe(33741, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(15, 15, 25, 30, 35)
    recipe:SetCraftedItem(28104, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddTrainer(2391, 3184, 5177, 16588, 16723, 18802, 19052, 33608, 33674, 56777)

    -- Mercurial Stone -- 38070
    recipe = AddRecipe(38070, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(25, 25, 35, 40, 45)
    recipe:SetCraftedItem(31080, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRINKET")
    recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
    recipe:AddTrainer(2391, 3184, 5177, 16588, 16723, 18802, 19052, 33608, 33674, 56777)

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
    recipe:AddTrainer(2391, 3184, 5177, 16588, 16723, 18802, 19052, 33608, 33674, 56777)

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
    recipe:AddTrainer(2391, 3184, 5177, 16588, 16723, 18802, 19052, 33608, 33674, 56777)

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
    recipe:AddTrainer(2391, 3184, 5177, 16588, 16723, 18802, 19052, 33608, 33674, 56777)

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
    recipe:AddTrainer(1386, 2391, 3184, 5177, 16588, 16723, 18802, 26903, 26951, 26975, 26987, 27023, 27029, 28703, 33588,
        33630, 56777)

    -- Runic Healing Potion -- 53836
    recipe = AddRecipe(53836, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(30, 30, 40, 45, 50)
    recipe:SetCraftedItem(33447, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(1386, 2391, 3184, 5177, 16588, 16723, 18802, 26903, 26951, 26975, 26987, 27023, 27029, 28703, 33588,
        33630, 56777)

    -- Runic Mana Potion -- 53837
    recipe = AddRecipe(53837, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(35, 35, 45, 50, 55)
    recipe:SetCraftedItem(33448, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(1386, 2391, 3184, 5177, 16588, 16723, 18802, 26903, 26951, 26975, 26987, 27023, 27029, 28703, 33588,
        33630, 56777)

    -- Resurgent Healing Potion -- 53838
    recipe = AddRecipe(53838, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 11, 16, 21)
    recipe:SetCraftedItem(39671, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(1386, 2391, 3184, 5177, 16588, 16723, 18802, 26903, 26951, 26975, 26987, 27023, 27029, 28703, 33588,
        33630, 56777)

    -- Icy Mana Potion -- 53839
    recipe = AddRecipe(53839, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 11, 16, 21)
    recipe:SetCraftedItem(40067, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(1386, 2391, 3184, 5177, 16588, 16723, 18802, 26903, 26951, 26975, 26987, 27023, 27029, 28703, 33588,
        33630, 56777)

    -- Elixir of Mighty Agility -- 53840
    recipe = AddRecipe(53840, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(20, 20, 30, 35, 40)
    recipe:SetCraftedItem(39666, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddFilters(F.DPS)
    recipe:AddTrainer(1386, 2391, 3184, 5177, 16588, 16723, 18802, 26903, 26951, 26975, 26987, 27023, 27029, 28703, 33588,
        33630, 56777)

    -- Wrath Elixir -- 53841
    recipe = AddRecipe(53841, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 11, 16, 21)
    recipe:SetCraftedItem(40068, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddFilters(F.DPS)
    recipe:AddTrainer(1386, 2391, 3184, 5177, 16588, 16723, 18802, 26903, 26951, 26975, 26987, 27023, 27029, 28703, 33588,
        33630, 56777)

    -- Spellpower Elixir -- 53842
    recipe = AddRecipe(53842, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 11, 16, 21)
    recipe:SetCraftedItem(40070, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddFilters(F.CASTER, F.HEALER)
    recipe:AddTrainer(1386, 2391, 3184, 5177, 16588, 16723, 18802, 26903, 26951, 26975, 26987, 27023, 27029, 28703, 33588,
        33630, 56777)

    -- Elixir of Spirit -- 53847
    recipe = AddRecipe(53847, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(10, 10, 20, 25, 30)
    recipe:SetCraftedItem(40072, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddFilters(F.CASTER, F.HEALER)
    recipe:AddTrainer(1386, 2391, 3184, 5177, 16588, 16723, 18802, 26903, 26951, 26975, 26987, 27023, 27029, 28703, 33588,
        33630, 56777)

    -- Guru's Elixir -- 53848
    recipe = AddRecipe(53848, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 11, 16, 21)
    recipe:SetCraftedItem(40076, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddTrainer(1386, 2391, 3184, 5177, 16588, 16723, 18802, 26903, 26951, 26975, 26987, 27023, 27029, 28703, 33588,
        33630, 56777)

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
    recipe:AddTrainer(1386, 2391, 3184, 5177, 16588, 16723, 18802, 26903, 26951, 26975, 26987, 27023, 27029, 28703, 33588,
        33630, 56777)

    -- Lesser Flask of Toughness -- 53899
    recipe = AddRecipe(53899, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 11, 16, 21)
    recipe:SetCraftedItem(40079, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_FLASK")
    recipe:AddTrainer(1386, 2391, 3184, 5177, 16588, 16723, 18802, 26903, 26951, 26975, 26987, 27023, 27029, 28703, 33588,
        33630, 56777)

    -- Potion of Nightmares -- 53900
    recipe = AddRecipe(53900, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(5, 5, 15, 20, 25)
    recipe:SetCraftedItem(40081, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(1386, 2391, 3184, 5177, 16588, 16723, 18802, 26903, 26951, 26975, 26987, 27023, 27029, 28703, 33588,
        33630, 56777)

    -- Flask of the Frost Wyrm -- 53901
    recipe = AddRecipe(53901, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(60, 60, 70, 75, 80)
    recipe:SetCraftedItem(46376, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_FLASK")
    recipe:AddFilters(F.CASTER, F.HEALER)
    recipe:AddTrainer(1386, 2391, 3184, 5177, 16588, 16723, 18802, 26903, 26951, 26975, 26987, 27023, 27029, 28703, 33588,
        33630, 56777)

    -- Flask of Stoneblood -- 53902
    recipe = AddRecipe(53902, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(60, 60, 70, 75, 80)
    recipe:SetCraftedItem(46379, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_FLASK")
    recipe:AddFilters(F.TANK)
    recipe:AddTrainer(1386, 2391, 3184, 5177, 16588, 16723, 18802, 26903, 26951, 26975, 26987, 27023, 27029, 28703, 33588,
        33630, 56777)

    -- Flask of Endless Rage -- 53903
    recipe = AddRecipe(53903, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(60, 60, 70, 75, 80)
    recipe:SetCraftedItem(46377, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_FLASK")
    recipe:AddFilters(F.DPS)
    recipe:AddTrainer(1386, 2391, 3184, 5177, 16588, 16723, 18802, 26903, 26951, 26975, 26987, 27023, 27029, 28703, 33588,
        33630, 56777)

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
    recipe:AddTrainer(1386, 2391, 3184, 5177, 16588, 16723, 18802, 26903, 26951, 26975, 26987, 27023, 27029, 28703, 33588,
        33630, 56777)

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
    recipe:AddTrainer(1386, 2391, 3184, 5177, 16588, 16723, 18802, 26903, 26951, 26975, 26987, 27023, 27029, 28703, 33588,
        33630, 56777)

    -- Elixir of Mighty Strength -- 54218
    recipe = AddRecipe(54218, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(10, 10, 20, 25, 30)
    recipe:SetCraftedItem(40073, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddFilters(F.DPS)
    recipe:AddTrainer(1386, 2391, 3184, 5177, 16588, 16723, 18802, 26903, 26951, 26975, 26987, 27023, 27029, 28703, 33588,
        33630, 56777)

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
    recipe:AddTrainer(1386, 2391, 3184, 5177, 16588, 16723, 18802, 26903, 26951, 26975, 26987, 27023, 27029, 28703, 33588,
        33630, 56777)

    -- Transmute: Earthsiege Diamond -- 57427
    recipe = AddRecipe(57427, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(50, 50, 60, 65, 70)
    recipe:SetCraftedItem(41334, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddTrainer(1386, 2391, 3184, 5177, 16588, 16723, 18802, 26903, 26951, 26975, 26987, 27023, 27029, 28703, 33588,
        33630, 56777)

    -- Endless Mana Potion -- 58868
    recipe = AddRecipe(58868, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(35, 35, 45, 50, 55)
    recipe:SetCraftedItem(43570, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(1386, 2391, 3184, 5177, 16588, 16723, 18802, 26903, 26951, 26975, 26987, 27023, 27029, 28703, 33588,
        33630, 56777)

    -- Endless Healing Potion -- 58871
    recipe = AddRecipe(58871, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(35, 35, 45, 50, 55)
    recipe:SetCraftedItem(43569, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(1386, 2391, 3184, 5177, 16588, 16723, 18802, 26903, 26951, 26975, 26987, 27023, 27029, 28703, 33588,
        33630, 56777)

    -- Transmute: Titanium -- 60350
    recipe = AddRecipe(60350, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(20, 20, 30, 35, 40)
    recipe:SetCraftedItem(41163, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddTrainer(1386, 2391, 3184, 5177, 16588, 16723, 18802, 26903, 26951, 26975, 26987, 27023, 27029, 28703, 33588,
        33630, 56777)

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
    recipe:AddTrainer(1386, 2391, 3184, 5177, 16588, 16723, 18802, 26903, 26951, 26975, 26987, 27023, 27029, 28703, 33588,
        33630, 56777)

    -- Mercurial Alchemist Stone -- 60396
    recipe = AddRecipe(60396, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(25, 25, 35, 40, 45)
    recipe:SetCraftedItem(44322, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ALCHEMY_TRINKET")
    recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
    recipe:AddTrainer(1386, 2391, 3184, 5177, 16588, 16723, 18802, 26903, 26951, 26975, 26987, 27023, 27029, 28703, 33588,
        33630, 56777)

    -- Indestructible Alchemist Stone -- 60403
    recipe = AddRecipe(60403, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(25, 25, 35, 40, 45)
    recipe:SetCraftedItem(44323, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ALCHEMY_TRINKET")
    recipe:AddFilters(F.TANK)
    recipe:AddTrainer(1386, 2391, 3184, 5177, 16588, 16723, 18802, 26903, 26951, 26975, 26987, 27023, 27029, 28703, 33588,
        33630, 56777)

    -- Mighty Alchemist Stone -- 60405
    recipe = AddRecipe(60405, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(25, 25, 35, 40, 45)
    recipe:SetCraftedItem(44324, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ALCHEMY_TRINKET")
    recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
    recipe:AddTrainer(1386, 2391, 3184, 5177, 16588, 16723, 18802, 26903, 26951, 26975, 26987, 27023, 27029, 28703, 33588,
        33630, 56777)

    -- Northrend Alchemy Research -- 60893
    recipe = AddRecipe(60893, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(25, 25, 35, 40, 45)
    recipe:SetCraftedItem(115460, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_MISC")
    recipe:AddTrainer(1386, 2391, 3184, 5177, 16588, 16723, 18802, 26903, 26951, 26975, 26987, 27023, 27029, 28703, 33588,
        33630, 56777)

    -- Ethereal Oil -- 62409
    recipe = AddRecipe(62409, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 11, 16, 21)
    recipe:SetCraftedItem(44958, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_OIL")
    recipe:AddTrainer(1386, 2391, 3184, 5177, 16588, 16723, 18802, 26903, 26951, 26975, 26987, 27023, 27029, 28703, 33588,
        33630, 56777)

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
    recipe:AddTrainer(1215, 1386, 1470, 2132, 2391, 2837, 3009, 3184, 3347, 4160, 4900, 5177, 5499, 7948, 16161, 16588,
        16642, 16723, 17215, 18802, 33630, 49885, 56777)

    -- Transmute: Ametrine -- 66658
    recipe = AddRecipe(66658, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(75, 75, 85, 90, 95)
    recipe:SetCraftedItem(36931, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddTrainer(1386, 2391, 3184, 5177, 16588, 16723, 18802, 26903, 26951, 26975, 26987, 27023, 27029, 28703, 33588,
        33630, 56777)

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
    recipe:AddTrainer(1386, 2391, 3184, 5177, 16588, 16723, 18802, 26903, 26951, 26975, 26987, 27023, 27029, 28703, 33588,
        33630, 56777)

    -- Transmute: Dreadstone -- 66662
    recipe = AddRecipe(66662, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(75, 75, 85, 90, 95)
    recipe:SetCraftedItem(36928, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddTrainer(1386, 2391, 3184, 5177, 16588, 16723, 18802, 26903, 26951, 26975, 26987, 27023, 27029, 28703, 33588,
        33630, 56777)

    -- Transmute: Majestic Zircon -- 66663
    recipe = AddRecipe(66663, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(75, 75, 85, 90, 95)
    recipe:SetCraftedItem(36925, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddTrainer(1386, 2391, 3184, 5177, 16588, 16723, 18802, 26903, 26951, 26975, 26987, 27023, 27029, 28703, 33588,
        33630, 56777)

    -- Transmute: Eye of Zul -- 66664
    recipe = AddRecipe(66664, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(75, 75, 85, 90, 95)
    recipe:SetCraftedItem(36934, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddTrainer(1386, 2391, 3184, 5177, 16588, 16723, 18802, 26903, 26951, 26975, 26987, 27023, 27029, 28703, 33588,
        33630, 56777)

    -- ----------------------------------------------------------------------------
    -- Cataclysm.
    -- ----------------------------------------------------------------------------
    -- Transmute: Living Elements -- 78866
    recipe = AddRecipe(78866, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(35, 35, 45, 50, 55)
    recipe:SetCraftedItem(54464, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddTrainer(1386, 2132, 2391, 3009, 3184, 3347, 4160, 4900, 5177, 5499, 16588, 16642, 16723, 18802, 33630,
        56777)

    -- Transmute: Shadowspirit Diamond -- 80237
    recipe = AddRecipe(80237, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(75, 75, 85, 90, 95)
    recipe:SetCraftedItem(52303, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddTrainer(1386, 2132, 2391, 3009, 3184, 3347, 4160, 4900, 5177, 5499, 16588, 16642, 16723, 18802, 33630,
        56777)

    -- Transmute: Truegold -- 80243
    recipe = AddRecipe(80243, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(75, 75, 85, 90, 95)
    recipe:SetCraftedItem(58480, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddTrainer(1386, 2132, 2391, 3009, 3184, 3347, 4160, 4900, 5177, 5499, 16588, 16642, 16723, 18802, 33630,
        56777)

    -- Transmute: Pyrium Bar -- 80244
    recipe = AddRecipe(80244, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(70, 70, 80, 85, 90)
    recipe:SetCraftedItem(51950, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddTrainer(1386, 2132, 2391, 3009, 3184, 3347, 4160, 4900, 5177, 5499, 16588, 16642, 16723, 18802, 33630,
        56777)

    -- Transmute: Inferno Ruby -- 80245
    recipe = AddRecipe(80245, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(75, 75, 85, 90, 95)
    recipe:SetCraftedItem(52190, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddTrainer(1386, 2132, 2391, 3009, 3184, 3347, 4160, 4900, 5177, 5499, 16588, 16642, 16723, 18802, 33630,
        56777)

    -- Transmute: Ocean Sapphire -- 80246
    recipe = AddRecipe(80246, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(65, 65, 75, 80, 85)
    recipe:SetCraftedItem(52191, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddTrainer(1386, 2132, 2391, 3009, 3184, 3347, 4160, 4900, 5177, 5499, 16588, 16642, 16723, 18802, 33630,
        56777)

    -- Transmute: Amberjewel -- 80247
    recipe = AddRecipe(80247, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(70, 70, 80, 85, 90)
    recipe:SetCraftedItem(52195, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddTrainer(1386, 2132, 2391, 3009, 3184, 3347, 4160, 4900, 5177, 5499, 16588, 16642, 16723, 18802, 33630,
        56777)

    -- Transmute: Demonseye -- 80248
    recipe = AddRecipe(80248, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(65, 65, 75, 80, 85)
    recipe:SetCraftedItem(52194, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddTrainer(1386, 2132, 2391, 3009, 3184, 3347, 4160, 4900, 5177, 5499, 16588, 16642, 16723, 18802, 33630,
        56777)

    -- Transmute: Ember Topaz -- 80250
    recipe = AddRecipe(80250, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(60, 60, 70, 75, 80)
    recipe:SetCraftedItem(52193, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddTrainer(1386, 2132, 2391, 3009, 3184, 3347, 4160, 4900, 5177, 5499, 16588, 16642, 16723, 18802, 33630,
        56777)

    -- Transmute: Dream Emerald -- 80251
    recipe = AddRecipe(80251, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(55, 55, 65, 70, 75)
    recipe:SetCraftedItem(52192, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddTrainer(1386, 2132, 2391, 3009, 3184, 3347, 4160, 4900, 5177, 5499, 16588, 16642, 16723, 18802, 33630,
        56777)

    -- Potion of Illusion -- 80269
    recipe = AddRecipe(80269, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(10, 10, 20, 25, 30)
    recipe:SetCraftedItem(58489, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(1386, 2132, 2391, 3009, 3184, 3347, 4160, 4900, 5177, 5499, 16588, 16642, 16723, 18802, 33630,
        56777)

    -- Ghost Elixir -- 80477
    recipe = AddRecipe(80477, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 11, 16, 21)
    recipe:SetCraftedItem(58084, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddFilters(F.CASTER, F.HEALER)
    recipe:AddTrainer(1386, 2132, 2391, 3009, 3184, 3347, 4160, 4900, 5177, 5499, 16588, 16642, 16723, 18802, 33630,
        56777)

    -- Earthen Potion -- 80478
    recipe = AddRecipe(80478, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 11, 16, 21)
    recipe:SetCraftedItem(58090, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddFilters(F.TANK)
    recipe:AddTrainer(1386, 2132, 2391, 3009, 3184, 3347, 4160, 4900, 5177, 5499, 16588, 16642, 16723, 18802, 33630,
        56777)

    -- Deathblood Venom -- 80479
    recipe = AddRecipe(80479, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(5, 5, 15, 20, 25)
    recipe:SetCraftedItem(58142, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_MISC")
    recipe:AddTrainer(1386, 2132, 2391, 3009, 3184, 3347, 4160, 4900, 5177, 5499, 16588, 16642, 16723, 18802, 33630,
        56777)

    -- Elixir of the Naga -- 80480
    recipe = AddRecipe(80480, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(5, 5, 15, 20, 25)
    recipe:SetCraftedItem(58089, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
    recipe:AddTrainer(1386, 2132, 2391, 3009, 3184, 3347, 4160, 4900, 5177, 5499, 16588, 16642, 16723, 18802, 33630,
        56777)

    -- Volcanic Potion -- 80481
    recipe = AddRecipe(80481, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(10, 10, 20, 25, 30)
    recipe:SetCraftedItem(58091, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddFilters(F.CASTER, F.HEALER)
    recipe:AddTrainer(1386, 2132, 2391, 3009, 3184, 3347, 4160, 4900, 5177, 5499, 16588, 16642, 16723, 18802, 33630,
        56777)

    -- Potion of Concentration -- 80482
    recipe = AddRecipe(80482, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(15, 15, 25, 30, 35)
    recipe:SetCraftedItem(57194, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(1386, 2132, 2391, 3009, 3184, 3347, 4160, 4900, 5177, 5499, 16588, 16642, 16723, 18802, 33630,
        56777)

    -- Elixir of the Cobra -- 80484
    recipe = AddRecipe(80484, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(15, 15, 25, 30, 35)
    recipe:SetCraftedItem(58092, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
    recipe:AddTrainer(1386, 2132, 2391, 3009, 3184, 3347, 4160, 4900, 5177, 5499, 16588, 16642, 16723, 18802, 33630,
        56777)

    -- Deepstone Oil -- 80486
    recipe = AddRecipe(80486, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(20, 20, 30, 35, 40)
    recipe:SetCraftedItem(56850, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_OIL")
    recipe:AddTrainer(1386, 2132, 2391, 3009, 3184, 3347, 4160, 4900, 5177, 5499, 16588, 16642, 16723, 18802, 33630,
        56777)

    -- Mysterious Potion -- 80487
    recipe = AddRecipe(80487, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(20, 20, 30, 35, 40)
    recipe:SetCraftedItem(57099, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(1386, 2132, 2391, 3009, 3184, 3347, 4160, 4900, 5177, 5499, 16588, 16642, 16723, 18802, 33630,
        56777)

    -- Elixir of Deep Earth -- 80488
    recipe = AddRecipe(80488, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(25, 25, 35, 40, 45)
    recipe:SetCraftedItem(58093, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddFilters(F.TANK)
    recipe:AddTrainer(1386, 2132, 2391, 3009, 3184, 3347, 4160, 4900, 5177, 5499, 16588, 16642, 16723, 18802, 33630,
        56777)

    -- Mighty Rejuvenation Potion -- 80490
    recipe = AddRecipe(80490, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(25, 25, 35, 40, 45)
    recipe:SetCraftedItem(57193, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(1386, 2132, 2391, 3009, 3184, 3347, 4160, 4900, 5177, 5499, 16588, 16642, 16723, 18802, 33630,
        56777)

    -- Elixir of Impossible Accuracy -- 80491
    recipe = AddRecipe(80491, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(30, 30, 40, 45, 50)
    recipe:SetCraftedItem(58094, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
    recipe:AddTrainer(1386, 2132, 2391, 3009, 3184, 3347, 4160, 4900, 5177, 5499, 16588, 16642, 16723, 18802, 33630,
        56777)

    -- Prismatic Elixir -- 80492
    recipe = AddRecipe(80492, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(30, 30, 40, 45, 50)
    recipe:SetCraftedItem(58143, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddTrainer(1386, 2132, 2391, 3009, 3184, 3347, 4160, 4900, 5177, 5499, 16588, 16642, 16723, 18802, 33630,
        56777)

    -- Elixir of Mighty Speed -- 80493
    recipe = AddRecipe(80493, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(40, 40, 50, 55, 60)
    recipe:SetCraftedItem(58144, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
    recipe:AddTrainer(1386, 2132, 2391, 3009, 3184, 3347, 4160, 4900, 5177, 5499, 16588, 16642, 16723, 18802, 33630,
        56777)

    -- Mythical Mana Potion -- 80494
    recipe = AddRecipe(80494, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(35, 35, 45, 50, 55)
    recipe:SetCraftedItem(57192, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(1386, 2132, 2391, 3009, 3184, 3347, 4160, 4900, 5177, 5499, 16588, 16642, 16723, 18802, 33630,
        56777)

    -- Potion of the Tol'vir -- 80495
    recipe = AddRecipe(80495, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(35, 35, 45, 50, 55)
    recipe:SetCraftedItem(58145, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddFilters(F.DPS)
    recipe:AddTrainer(1386, 2132, 2391, 3009, 3184, 3347, 4160, 4900, 5177, 5499, 16588, 16642, 16723, 18802, 33630,
        56777)

    -- Golemblood Potion -- 80496
    recipe = AddRecipe(80496, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(40, 40, 50, 55, 60)
    recipe:SetCraftedItem(58146, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddFilters(F.DPS)
    recipe:AddTrainer(1386, 2132, 2391, 3009, 3184, 3347, 4160, 4900, 5177, 5499, 16588, 16642, 16723, 18802, 33630,
        56777)

    -- Elixir of the Master -- 80497
    recipe = AddRecipe(80497, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(45, 45, 55, 60, 65)
    recipe:SetCraftedItem(58148, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddTrainer(1386, 2132, 2391, 3009, 3184, 3347, 4160, 4900, 5177, 5499, 16588, 16642, 16723, 18802, 33630,
        56777)

    -- Mythical Healing Potion -- 80498
    recipe = AddRecipe(80498, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(45, 45, 55, 60, 65)
    recipe:SetCraftedItem(57191, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(1386, 2132, 2391, 3009, 3184, 3347, 4160, 4900, 5177, 5499, 16588, 16642, 16723, 18802, 33630,
        56777)

    -- Lifebound Alchemist Stone -- 80508
    recipe = AddRecipe(80508, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(50, 50, 60, 65, 70)
    recipe:SetCraftedItem(58483, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRINKET")
    recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
    recipe:AddTrainer(1386, 2132, 2391, 3009, 3184, 3347, 4160, 4900, 5177, 5499, 16588, 16642, 16723, 18802, 33630,
        56777)

    -- Flask of Steelskin -- 80719
    recipe = AddRecipe(80719, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(50, 50, 60, 65, 70)
    recipe:SetCraftedItem(58085, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_FLASK")
    recipe:AddTrainer(1386, 2132, 2391, 3009, 3184, 3347, 4160, 4900, 5177, 5499, 16588, 16642, 16723, 18802, 33630,
        56777)

    -- Flask of the Draconic Mind -- 80720
    recipe = AddRecipe(80720, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(55, 55, 65, 70, 75)
    recipe:SetCraftedItem(58086, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_FLASK")
    recipe:AddFilters(F.CASTER, F.HEALER)
    recipe:AddTrainer(1386, 2132, 2391, 3009, 3184, 3347, 4160, 4900, 5177, 5499, 16588, 16642, 16723, 18802, 33630,
        56777)

    -- Flask of the Winds -- 80721
    recipe = AddRecipe(80721, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(60, 60, 70, 75, 80)
    recipe:SetCraftedItem(58087, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_FLASK")
    recipe:AddFilters(F.DPS)
    recipe:AddTrainer(1386, 2132, 2391, 3009, 3184, 3347, 4160, 4900, 5177, 5499, 16588, 16642, 16723, 18802, 33630,
        56777)

    -- Flask of Titanic Strength -- 80723
    recipe = AddRecipe(80723, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(60, 60, 70, 75, 80)
    recipe:SetCraftedItem(58088, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_FLASK")
    recipe:AddFilters(F.DPS)
    recipe:AddTrainer(1386, 2132, 2391, 3009, 3184, 3347, 4160, 4900, 5177, 5499, 16588, 16642, 16723, 18802, 33630,
        56777)

    -- Potion of Deepholm -- 80725
    recipe = AddRecipe(80725, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(75, 75, 85, 90, 95)
    recipe:SetCraftedItem(58487, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(1386, 2132, 2391, 3009, 3184, 3347, 4160, 4900, 5177, 5499, 16588, 16642, 16723, 18802, 33630,
        56777)

    -- Potion of Treasure Finding -- 80726
    recipe = AddRecipe(80726, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(75, 75, 85, 90, 95)
    recipe:SetCraftedItem(58488, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(1386, 2132, 2391, 3009, 3184, 3347, 4160, 4900, 5177, 5499, 16588, 16642, 16723, 18802, 33630,
        56777)

    -- Cauldron of Battle -- 92643
    recipe = AddRecipe(92643, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(525, 525, 525, 525, 525)
    recipe:SetRecipeItem(65435, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(62288, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_CAULDRON")
    recipe:AddAchievement(5465)
    recipe:AddVendor(46572, 46602, 51495, 51496, 51512)

    -- Big Cauldron of Battle -- 92688
    recipe = AddRecipe(92688, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(525, 525, 525, 525, 525)
    recipe:SetRecipeItem(65498, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(65460, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_CAULDRON")
    recipe:AddAchievement(5024)
    recipe:AddVendor(46572, 46602, 51495, 51496, 51512)

    -- Vial of the Sands -- 93328
    recipe = AddRecipe(93328, V.CATA, Q.EPIC)
    recipe:SetSkillLevels(525, 525, 525, 530, 535)
    recipe:SetRecipeItem(67538, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(65891, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_MOUNT")
    recipe:AddCustom("ARCH_DROP_ULD")

    -- Draught of War -- 93935
    recipe = AddRecipe(93935, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 11, 16, 21)
    recipe:SetCraftedItem(67415, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_MISC")
    recipe:AddTrainer(1386, 2132, 2391, 3009, 3184, 3347, 4160, 4900, 5177, 5499, 16588, 16642, 16723, 18802, 56777)

    -- Flask of Flowing Water -- 94162
    recipe = AddRecipe(94162, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(50, 50, 60, 65, 70)
    recipe:SetCraftedItem(67438, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_FLASK")
    recipe:AddFilters(F.CASTER, F.HEALER)
    recipe:AddTrainer(1386, 2132, 2391, 3009, 3184, 3347, 4160, 4900, 5177, 5499, 16588, 16642, 16723, 18802, 56777)

    -- Volatile Alchemist Stone -- 96252
    recipe = AddRecipe(96252, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(50, 50, 60, 65, 70)
    recipe:SetCraftedItem(68775, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ALCHEMY_TRINKET")
    recipe:AddFilters(F.DPS)
    recipe:AddTrainer(1386, 2132, 2391, 3009, 3184, 3347, 4160, 4900, 5177, 5499, 16588, 16642, 16723, 18802, 56777)

    -- Quicksilver Alchemist Stone -- 96253
    recipe = AddRecipe(96253, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(50, 50, 60, 65, 70)
    recipe:SetCraftedItem(68776, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ALCHEMY_TRINKET")
    recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
    recipe:AddTrainer(1386, 2132, 2391, 3009, 3184, 3347, 4160, 4900, 5177, 5499, 16588, 16642, 16723, 18802, 56777)

    -- Vibrant Alchemist Stone -- 96254
    recipe = AddRecipe(96254, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(50, 50, 60, 65, 70)
    recipe:SetCraftedItem(68777, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ALCHEMY_TRINKET")
    recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
    recipe:AddTrainer(1386, 2132, 2391, 3009, 3184, 3347, 4160, 4900, 5177, 5499, 16588, 16642, 16723, 18802, 56777)

    -- ----------------------------------------------------------------------------
    -- Mists of Pandaria.
    -- ----------------------------------------------------------------------------
    -- Alchemist's Rejuvenation -- 114751
    recipe = AddRecipe(114751, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 11, 16, 21)
    recipe:SetCraftedItem(76094, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(3184, 5177, 16588, 18802, 65186)

    -- Master Healing Potion -- 114752
    recipe = AddRecipe(114752, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 11, 16, 21)
    recipe:SetCraftedItem(76097, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(3184, 5177, 16588, 18802, 65186)

    -- Potion of the Mountains -- 114753
    recipe = AddRecipe(114753, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(525, 525, 540, 552, 565)
    recipe:SetCraftedItem(76090, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddFilters(F.TANK)
    recipe:AddDiscovery("DISCOVERY_ALCH_PANDARIA")

    -- Mad Hozen Elixir -- 114754
    recipe = AddRecipe(114754, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(525, 525, 540, 552, 565)
    recipe:SetCraftedItem(76076, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
    recipe:AddDiscovery("DISCOVERY_ALCH_PANDARIA")

    -- Mantid Elixir -- 114755
    recipe = AddRecipe(114755, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(525, 525, 540, 552, 565)
    recipe:SetCraftedItem(76075, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddFilters(F.TANK)
    recipe:AddDiscovery("DISCOVERY_ALCH_PANDARIA")

    -- Elixir of Weaponry -- 114756
    recipe = AddRecipe(114756, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(525, 525, 540, 552, 565)
    recipe:SetCraftedItem(76077, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
    recipe:AddDiscovery("DISCOVERY_ALCH_PANDARIA")

    -- Potion of the Jade Serpent -- 114757
    recipe = AddRecipe(114757, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(525, 525, 540, 552, 565)
    recipe:SetCraftedItem(76093, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddFilters(F.CASTER, F.HEALER)
    recipe:AddDiscovery("DISCOVERY_ALCH_PANDARIA")

    -- Monk's Elixir -- 114758
    recipe = AddRecipe(114758, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(525, 525, 540, 552, 565)
    recipe:SetCraftedItem(76083, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddDiscovery("DISCOVERY_ALCH_PANDARIA")

    -- Elixir of the Rapids -- 114759
    recipe = AddRecipe(114759, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(550, 550, 565, 577, 590)
    recipe:SetCraftedItem(76078, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
    recipe:AddDiscovery("DISCOVERY_ALCH_PANDARIA")

    -- Potion of Mogu Power -- 114760
    recipe = AddRecipe(114760, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(550, 550, 565, 577, 590)
    recipe:SetCraftedItem(76095, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddFilters(F.DPS)
    recipe:AddDiscovery("DISCOVERY_ALCH_PANDARIA")

    -- Desecrated Oil -- 114761
    recipe = AddRecipe(114761, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(550, 550, 550, 552, 565)
    recipe:SetCraftedItem(87872, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_OIL")
    recipe:AddDiscovery("DISCOVERY_ALCH_PANDARIA")

    -- Elixir of Perfection -- 114762
    recipe = AddRecipe(114762, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(550, 550, 565, 577, 590)
    recipe:SetCraftedItem(76080, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
    recipe:AddDiscovery("DISCOVERY_ALCH_PANDARIA")

    -- Elixir of Mirrors -- 114763
    recipe = AddRecipe(114763, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(550, 550, 565, 577, 590)
    recipe:SetCraftedItem(76079, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddFilters(F.TANK)
    recipe:AddDiscovery("DISCOVERY_ALCH_PANDARIA")

    -- Elixir of Peace -- 114764
    recipe = AddRecipe(114764, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(550, 550, 565, 577, 590)
    recipe:SetCraftedItem(76089, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddFilters(F.CASTER, F.HEALER)
    recipe:AddDiscovery("DISCOVERY_ALCH_PANDARIA")

    -- Virmen's Bite -- 114765
    recipe = AddRecipe(114765, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(550, 550, 565, 577, 590)
    recipe:SetCraftedItem(76081, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddFilters(F.DPS)
    recipe:AddDiscovery("DISCOVERY_ALCH_PANDARIA")

    -- Transmute: River's Heart -- 114766
    recipe = AddRecipe(114766, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(550, 550, 600, 605, 610)
    recipe:SetCraftedItem(76138, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddDiscovery("DISCOVERY_ALCH_PANDARIA")

    -- Transmute: Wild Jade -- 114767
    recipe = AddRecipe(114767, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(550, 550, 600, 605, 610)
    recipe:SetCraftedItem(76139, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddDiscovery("DISCOVERY_ALCH_PANDARIA")

    -- Flask of Spring Blossoms -- 114769
    recipe = AddRecipe(114769, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(550, 550, 600, 602, 605)
    recipe:SetCraftedItem(76084, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_FLASK")
    recipe:AddFilters(F.DPS)
    recipe:AddDiscovery("DISCOVERY_ALCH_PANDARIA")

    -- Flask of the Earth -- 114770
    recipe = AddRecipe(114770, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(550, 550, 600, 602, 605)
    recipe:SetCraftedItem(76087, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_FLASK")
    recipe:AddDiscovery("DISCOVERY_ALCH_PANDARIA")

    -- Flask of the Warm Sun -- 114771
    recipe = AddRecipe(114771, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(550, 550, 600, 602, 605)
    recipe:SetCraftedItem(76085, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_FLASK")
    recipe:AddFilters(F.CASTER, F.HEALER)
    recipe:AddDiscovery("DISCOVERY_ALCH_PANDARIA")

    -- Flask of Falling Leaves -- 114772
    recipe = AddRecipe(114772, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(550, 550, 600, 602, 605)
    recipe:SetCraftedItem(76088, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_FLASK")
    recipe:AddFilters(F.CASTER, F.HEALER)
    recipe:AddDiscovery("DISCOVERY_ALCH_PANDARIA")

    -- Flask of Winter's Bite -- 114773
    recipe = AddRecipe(114773, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(550, 550, 600, 602, 605)
    recipe:SetCraftedItem(76086, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_FLASK")
    recipe:AddFilters(F.DPS)
    recipe:AddDiscovery("DISCOVERY_ALCH_PANDARIA")

    -- Darkwater Potion -- 114774
    recipe = AddRecipe(114774, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(575, 575, 575, 577, 590)
    recipe:SetCraftedItem(76096, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddDiscovery("DISCOVERY_ALCH_PANDARIA")

    -- Master Mana Potion -- 114775
    recipe = AddRecipe(114775, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(575, 575, 600, 602, 605)
    recipe:SetCraftedItem(76098, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddDiscovery("DISCOVERY_ALCH_PANDARIA")

    -- Transmute: Vermilion Onyx -- 114776
    recipe = AddRecipe(114776, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(575, 575, 600, 605, 610)
    recipe:SetCraftedItem(76140, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddDiscovery("DISCOVERY_ALCH_PANDARIA")

    -- Transmute: Imperial Amethyst -- 114777
    recipe = AddRecipe(114777, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(575, 575, 600, 605, 610)
    recipe:SetCraftedItem(76141, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddDiscovery("DISCOVERY_ALCH_PANDARIA")

    -- Transmute: Sun's Radiance -- 114778
    recipe = AddRecipe(114778, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(575, 575, 600, 605, 610)
    recipe:SetCraftedItem(76141, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddDiscovery("DISCOVERY_ALCH_PANDARIA")

    -- Potion of Luck -- 114779
    recipe = AddRecipe(114779, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(600, 600, 605, 610, 615)
    recipe:SetCraftedItem(76091, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddDiscovery("DISCOVERY_ALCH_PANDARIA")

    -- Transmute: Living Steel -- 114780
    recipe = AddRecipe(114780, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(600, 600, 605, 610, 615)
    recipe:SetCraftedItem(72104, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddDiscovery("DISCOVERY_ALCH_PANDARIA")

    -- Transmute: Primal Diamond -- 114781
    recipe = AddRecipe(114781, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(600, 600, 600, 605, 610)
    recipe:SetCraftedItem(76132, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddDiscovery("DISCOVERY_ALCH_PANDARIA")

    -- Potion of Focus -- 114782
    recipe = AddRecipe(114782, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(600, 600, 600, 600, 600)
    recipe:SetCraftedItem(76092, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddDiscovery("DISCOVERY_ALCH_PANDARIA")

    -- Transmute: Trillium Bar -- 114783
    recipe = AddRecipe(114783, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(600, 600, 600, 605, 610)
    recipe:SetCraftedItem(72095, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddDiscovery("DISCOVERY_ALCH_PANDARIA")

    -- Transmute: Primordial Ruby -- 114784
    recipe = AddRecipe(114784, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(600, 600, 600, 605, 610)
    recipe:SetCraftedItem(76131, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddDiscovery("DISCOVERY_ALCH_PANDARIA")

    -- Alchemist's Flask -- 114786
    recipe = AddRecipe(114786, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(300, 300, 310, 315, 320)
    recipe:SetCraftedItem(75525, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_FLASK")
    recipe:AddFilters(F.CASTER, F.HEALER)
    recipe:AddTrainer(1386, 2132, 3009, 3184, 3347, 4160, 4900, 5177, 5499, 16588, 16642, 16723, 18802, 56777)

    -- Riddle of Steel -- 130326
    recipe = AddRecipe(130326, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(600, 600, 605, 610, 615)
    recipe:SetCraftedItem(72104, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddDiscovery("DISCOVERY_ALCH_PANDARIA")

    -- Zen Alchemist Stone -- 136197
    recipe = AddRecipe(136197, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 11, 16, 21)
    recipe:SetCraftedItem(75274, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ALCHEMY_TRINKET")
    recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
    recipe:AddTrainer(2391, 3184, 5177, 16588, 16723, 18802, 56777, 65186)

    -- ----------------------------------------------------------------------------
    -- Warlords of Draenor.
    -- ----------------------------------------------------------------------------
    -- Draenic Philosopher's Stone -- 156560
    recipe = AddRecipe(156560, V.WOD, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 600, 600, 600)
    recipe:SetRecipeItem(112023, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(109262, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ALCHEMY_TRINKET")
    recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
    recipe:AddVendor(77363, 79813, 87048, 87542)

    -- Draenic Agility Flask -- 156561
    recipe = AddRecipe(156561, V.WOD, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 700, 705, 710)
    recipe:SetRecipeItem(112024, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(109145, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_FLASK")
    recipe:AddVendor(77363, 79813, 87048, 87542)

    -- Draenic Intellect Flask -- 156563
    recipe = AddRecipe(156563, V.WOD, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 700, 705, 710)
    recipe:SetRecipeItem(112026, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(109147, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_FLASK")
    recipe:AddFilters(F.CASTER, F.HEALER)
    recipe:AddVendor(77363, 79813, 87048, 87542)

    -- Draenic Strength Flask -- 156564
    recipe = AddRecipe(156564, V.WOD, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 700, 705, 710)
    recipe:SetRecipeItem(112027, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(109148, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_FLASK")
    recipe:AddFilters(F.DPS)
    recipe:AddVendor(77363, 79813, 87048, 87542)

    -- Draenic Stamina Flask -- 156568
    recipe = AddRecipe(156568, V.WOD, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 700, 705, 710)
    recipe:SetRecipeItem(112030, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(109152, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_FLASK")
    recipe:AddVendor(77363, 79813, 87048, 87542)

    -- Greater Draenic Agility Flask -- 156569
    recipe = AddRecipe(156569, V.WOD, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 700, 705, 710)
    recipe:SetRecipeItem(112031, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(109153, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_FLASK")
    recipe:AddFilters(F.DPS)
    recipe:AddVendor(77363, 79813, 87048, 87542)

    -- Greater Draenic Intellect Flask -- 156571
    recipe = AddRecipe(156571, V.WOD, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 700, 705, 710)
    recipe:SetRecipeItem(112033, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(109155, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_FLASK")
    recipe:AddFilters(F.CASTER, F.HEALER)
    recipe:AddVendor(77363, 79813, 87048, 87542)

    -- Greater Draenic Strength Flask -- 156572
    recipe = AddRecipe(156572, V.WOD, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 700, 705, 710)
    recipe:SetRecipeItem(112034, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(109156, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_FLASK")
    recipe:AddFilters(F.DPS)
    recipe:AddVendor(77363, 79813, 87048, 87542)

    -- Greater Draenic Stamina Flask -- 156576
    recipe = AddRecipe(156576, V.WOD, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 700, 705, 710)
    recipe:SetRecipeItem(112037, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(109160, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_FLASK")
    recipe:AddVendor(77363, 79813, 87048, 87542)

    -- Draenic Agility Potion -- 156577
    recipe = AddRecipe(156577, V.WOD, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 600, 600, 600)
    recipe:SetRecipeItem(112038, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(109217, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddFilters(F.DPS)
    recipe:AddVendor(77363, 79813, 87048, 87542)

    -- Draenic Intellect Potion -- 156578
    recipe = AddRecipe(156578, V.WOD, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 600, 600, 600)
    recipe:SetRecipeItem(112039, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(109218, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddFilters(F.CASTER, F.HEALER)
    recipe:AddVendor(77363, 79813, 87048, 87542)

    -- Draenic Strength Potion -- 156579
    recipe = AddRecipe(156579, V.WOD, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 600, 600, 600)
    recipe:SetRecipeItem(112040, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(109219, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddFilters(F.DPS)
    recipe:AddVendor(77363, 79813, 87048, 87542)

    -- Draenic Versatility Potion -- 156580
    recipe = AddRecipe(156580, V.WOD, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 600, 600, 600)
    recipe:SetRecipeItem(112041, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(109220, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddFilters(F.TANK)
    recipe:AddVendor(77363, 79813, 87048, 87542)

    -- Draenic Channeled Mana Potion -- 156581
    recipe = AddRecipe(156581, V.WOD, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 600, 600, 600)
    recipe:SetRecipeItem(112042, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(109221, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddVendor(77363, 79813, 87048, 87542)

    -- Draenic Mana Potion -- 156582
    recipe = AddRecipe(156582, V.WOD, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 600, 600, 600)
    recipe:SetCraftedItem(109222, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddCustom("DRAENOR_DEFAULT")

    -- Draenic Rejuvenation Potion -- 156584
    recipe = AddRecipe(156584, V.WOD, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 600, 600, 600)
    recipe:SetRecipeItem(112045, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(109226, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddVendor(77363, 79813, 87048, 87542)

    -- Crescent Oil -- 156585
    recipe = AddRecipe(156585, V.WOD, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 600, 600, 600)
    recipe:SetCraftedItem(109123, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_OIL")
    recipe:AddCustom("DRAENOR_DEFAULT")

    -- Alchemical Catalyst -- 156587
    recipe = AddRecipe(156587, V.WOD, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 600, 800, 1000)
    recipe:SetCraftedItem(108996, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ALCHEMY_MISC")
    recipe:AddCustom("DRAENOR_DEFAULT")

    -- Primal Alchemy -- 156591
    recipe = AddRecipe(156591, V.WOD, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 600, 800, 1000)
    recipe:SetRecipeItem(122710, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(108996, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ALCHEMY_MISC")
    recipe:AddVendor(91031, 91404)

    -- Transmorphic Tincture -- 162403
    recipe = AddRecipe(162403, V.WOD, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 600, 600, 600)
    recipe:SetRecipeItem(112047, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(112090, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_MISC")
    recipe:AddVendor(77363, 79813, 87048, 87542)

    -- Healing Tonic -- 172540
    recipe = AddRecipe(172540, V.WOD, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 1, 25, 50)
    recipe:SetRecipeItem(160663, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(109223, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_MISC")
    recipe:AddVendor(77363, 79813, 87048, 87542)

    -- Blackwater Anti-Venom -- 172541
    recipe = AddRecipe(172541, V.WOD, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 25, 75, 100)
    recipe:SetRecipeItem(160662, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(116979, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_MISC")
    recipe:AddVendor(77363, 79813, 87048, 87542)

    -- Fire Ammonite Oil -- 172542
    recipe = AddRecipe(172542, V.WOD, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 75, 87, 100)
    recipe:SetRecipeItem(160661, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(116981, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_MISC")
    recipe:AddVendor(77363, 79813, 87048, 87542)

    -- Draenic Swiftness Potion -- 175853
    recipe = AddRecipe(175853, V.WOD, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 600, 600, 600)
    recipe:SetCraftedItem(116266, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddCustom("DRAENOR_DEFAULT")

    -- Draenic Invisibility Potion -- 175865
    recipe = AddRecipe(175865, V.WOD, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 600, 600, 600)
    recipe:SetCraftedItem(116268, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddCustom("DRAENOR_DEFAULT")

    -- Draenic Water Breathing Elixir -- 175866
    recipe = AddRecipe(175866, V.WOD, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 600, 600, 600)
    recipe:SetCraftedItem(116271, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddCustom("DRAENOR_DEFAULT")

    -- Draenic Living Action Potion -- 175867
    recipe = AddRecipe(175867, V.WOD, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 600, 600, 600)
    recipe:SetCraftedItem(116276, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddCustom("DRAENOR_DEFAULT")

    -- Pure Rage Potion -- 175868
    recipe = AddRecipe(175868, V.WOD, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 600, 600, 600)
    recipe:SetCraftedItem(118704, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddFilters(F.DRUID, F.WARRIOR)
    recipe:AddCustom("DRAENOR_DEFAULT")

    -- Draenic Water Walking Elixir -- 175869
    recipe = AddRecipe(175869, V.WOD, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 600, 600, 600)
    recipe:SetCraftedItem(118711, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddCustom("DRAENOR_DEFAULT")

    -- Secrets of Draenor Alchemy -- 175880
    recipe = AddRecipe(175880, V.WOD, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 600, 650, 700)
    recipe:SetCraftedItem(118700, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ALCHEMY_MISC")
    recipe:AddCustom("DRAENOR_DEFAULT")

    -- Transmute: Sorcerous Fire to Earth -- 181625
    recipe = AddRecipe(181625, V.WOD, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 700, 702, 705)
    recipe:SetRecipeItem(122599, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(113263, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddVendor(91031, 91404)

    -- Transmute: Sorcerous Fire to Air -- 181627
    recipe = AddRecipe(181627, V.WOD, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 700, 702, 705)
    recipe:SetRecipeItem(122599, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(113264, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddVendor(91031, 91404)

    -- Transmute: Sorcerous Fire to Water -- 181628
    recipe = AddRecipe(181628, V.WOD, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 700, 702, 705)
    recipe:SetRecipeItem(122599, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(113262, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddVendor(91031, 91404)

    -- Transmute: Sorcerous Water to Earth -- 181629
    recipe = AddRecipe(181629, V.WOD, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 700, 702, 705)
    recipe:SetRecipeItem(122599, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(113263, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddVendor(91031, 91404)

    -- Transmute: Sorcerous Water to Air -- 181630
    recipe = AddRecipe(181630, V.WOD, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 700, 702, 705)
    recipe:SetRecipeItem(122599, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(113264, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddVendor(91031, 91404)

    -- Transmute: Sorcerous Earth to Air -- 181631
    recipe = AddRecipe(181631, V.WOD, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 700, 702, 705)
    recipe:SetRecipeItem(122599, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(113264, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddVendor(91031, 91404)

    -- Transmute: Sorcerous Earth to Fire -- 181632
    recipe = AddRecipe(181632, V.WOD, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 700, 702, 705)
    recipe:SetRecipeItem(122599, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(113261, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddVendor(91031, 91404)

    -- Transmute: Sorcerous Air to Fire -- 181633
    recipe = AddRecipe(181633, V.WOD, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 700, 702, 705)
    recipe:SetRecipeItem(122599, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(113261, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddVendor(91031, 91404)

    -- Transmute: Sorcerous Water to Fire -- 181634
    recipe = AddRecipe(181634, V.WOD, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 700, 702, 705)
    recipe:SetRecipeItem(122599, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(113261, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddVendor(91031, 91404)

    -- Transmute: Sorcerous Earth to Water -- 181635
    recipe = AddRecipe(181635, V.WOD, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 700, 702, 705)
    recipe:SetRecipeItem(122599, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(113262, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddVendor(91031, 91404)

    -- Transmute: Sorcerous Air to Water -- 181636
    recipe = AddRecipe(181636, V.WOD, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 700, 702, 705)
    recipe:SetRecipeItem(122599, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(113262, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddVendor(91031, 91404)

    -- Transmute: Sorcerous Air to Earth -- 181637
    recipe = AddRecipe(181637, V.WOD, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 700, 702, 705)
    recipe:SetRecipeItem(122599, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(113263, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddVendor(91031, 91404)

    -- Transmute: Savage Blood -- 181643
    recipe = AddRecipe(181643, V.WOD, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 700, 702, 705)
    recipe:SetRecipeItem(122600, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(118472, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddVendor(91031, 91404)

    -- Stone of Wind -- 181647
    recipe = AddRecipe(181647, V.WOD, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 700, 702, 705)
    recipe:SetRecipeItem(122605, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(122601, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ALCHEMY_TRINKET")
    recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
    recipe:AddVendor(91031, 91404)

    -- Stone of the Earth -- 181648
    recipe = AddRecipe(181648, V.WOD, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 700, 702, 705)
    recipe:SetRecipeItem(122605, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(122602, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ALCHEMY_TRINKET")
    recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
    recipe:AddVendor(91031, 91404)

    -- Stone of the Waters -- 181649
    recipe = AddRecipe(181649, V.WOD, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 700, 702, 705)
    recipe:SetRecipeItem(122605, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(122603, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ALCHEMY_TRINKET")
    recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
    recipe:AddVendor(91031, 91404)

    -- Stone of Fire -- 181650
    recipe = AddRecipe(181650, V.WOD, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 700, 702, 705)
    recipe:SetRecipeItem(122605, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(122604, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRINKET")
    recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
    recipe:AddVendor(91031, 91404)

    -- ----------------------------------------------------------------------------
    -- Legion.
    -- ----------------------------------------------------------------------------
    -- Ancient Healing Potion -- 188297
    recipe = AddRecipe(188297, V.LEGION, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 700, 710, 720)
    recipe:SetRecipeItem(127898, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(127834, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddVendor(92457)

    -- Ancient Healing Potion -- 188299
    recipe = AddRecipe(188299, V.LEGION, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 720, 730, 740)
    recipe:SetRecipeItem(127917, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(127834, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddVendor(92457)

    -- Ancient Healing Potion -- 188300
    recipe = AddRecipe(188300, V.LEGION, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 740, 750, 760)
    recipe:SetRecipeItem(127935, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(127834, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddDiscovery("DISCOVERY_ALCH_LEGION_PREV")

    -- Ancient Mana Potion -- 188301
    recipe = AddRecipe(188301, V.LEGION, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 700, 710, 720)
    recipe:SetRecipeItem(127899, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(127835, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddVendor(92457)

    -- Ancient Mana Potion -- 188302
    recipe = AddRecipe(188302, V.LEGION, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 720, 730, 740)
    recipe:SetRecipeItem(127918, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(127835, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddDiscovery("DISCOVERY_ALCH_LEGION_PREV")

    -- Ancient Mana Potion -- 188303
    recipe = AddRecipe(188303, V.LEGION, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 740, 750, 760)
    recipe:SetRecipeItem(127936, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(127835, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddDiscovery("DISCOVERY_ALCH_LEGION_PREV")

    -- Ancient Rejuvenation Potion -- 188304
    recipe = AddRecipe(188304, V.LEGION, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 700, 710, 720)
    recipe:SetRecipeItem(127900, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(127836, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddVendor(92457)

    -- Ancient Rejuvenation Potion -- 188305
    recipe = AddRecipe(188305, V.LEGION, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 720, 730, 740)
    recipe:SetRecipeItem(127919, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(127836, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddDiscovery("DISCOVERY_ALCH_LEGION_PREV")

    -- Ancient Rejuvenation Potion -- 188306
    recipe = AddRecipe(188306, V.LEGION, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 740, 750, 760)
    recipe:SetRecipeItem(127937, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(127836, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddDiscovery("DISCOVERY_ALCH_LEGION_PREV")

    -- Draught of Raw Magic -- 188307
    recipe = AddRecipe(188307, V.LEGION, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 700, 710, 720)
    recipe:SetRecipeItem(127901, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(127837, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddVendor(92457)

    -- Draught of Raw Magic -- 188308
    recipe = AddRecipe(188308, V.LEGION, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 720, 730, 740)
    recipe:SetRecipeItem(127920, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(127837, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddQuest(41657, 41662)

    -- Draught of Raw Magic -- 188309
    recipe = AddRecipe(188309, V.LEGION, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 740, 750, 760)
    recipe:SetRecipeItem(127938, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(127837, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddDiscovery("DISCOVERY_ALCH_LEGION_PREV")

    -- Sylvan Elixir -- 188310
    recipe = AddRecipe(188310, V.LEGION, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 700, 710, 720)
    recipe:SetRecipeItem(127902, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(127838, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddVendor(92457)

    -- Sylvan Elixir -- 188311
    recipe = AddRecipe(188311, V.LEGION, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 720, 730, 740)
    recipe:SetRecipeItem(127921, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(127838, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddQuest(41658)

    -- Sylvan Elixir -- 188312
    recipe = AddRecipe(188312, V.LEGION, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 740, 750, 760)
    recipe:SetRecipeItem(127939, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(127838, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddDiscovery("DISCOVERY_ALCH_LEGION_PREV")

    -- Avalanche Elixir -- 188313
    recipe = AddRecipe(188313, V.LEGION, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 700, 710, 720)
    recipe:SetRecipeItem(127903, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(127839, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddVendor(92457)

    -- Avalanche Elixir -- 188314
    recipe = AddRecipe(188314, V.LEGION, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 720, 730, 740)
    recipe:SetRecipeItem(127922, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(127839, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddQuest(41659)

    -- Avalanche Elixir -- 188315
    recipe = AddRecipe(188315, V.LEGION, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 740, 750, 760)
    recipe:SetRecipeItem(127940, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(127839, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_ELIXIR")
    recipe:AddDiscovery("DISCOVERY_ALCH_LEGION_PREV")

    -- Skaggldrynk -- 188316
    recipe = AddRecipe(188316, V.LEGION, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 700, 710, 720)
    recipe:SetRecipeItem(127904, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(127840, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddVendor(92457)

    -- Skaggldrynk -- 188317
    recipe = AddRecipe(188317, V.LEGION, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 720, 730, 740)
    recipe:SetRecipeItem(127923, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(127840, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddDiscovery("DISCOVERY_ALCH_LEGION_PREV")

    -- Skaggldrynk -- 188318
    recipe = AddRecipe(188318, V.LEGION, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 740, 750, 760)
    recipe:SetRecipeItem(127941, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(127840, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddDiscovery("DISCOVERY_ALCH_LEGION_PREV")

    -- Skystep Potion -- 188319
    recipe = AddRecipe(188319, V.LEGION, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 700, 710, 720)
    recipe:SetRecipeItem(127905, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(127841, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddVendor(92457)

    -- Skystep Potion -- 188320
    recipe = AddRecipe(188320, V.LEGION, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 720, 730, 740)
    recipe:SetRecipeItem(127924, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(127841, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddQuest(41661)

    -- Skystep Potion -- 188321
    recipe = AddRecipe(188321, V.LEGION, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 740, 750, 760)
    recipe:SetRecipeItem(127942, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(127841, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddDiscovery("DISCOVERY_ALCH_LEGION_PREV")

    -- Infernal Alchemist Stone -- 188322
    recipe = AddRecipe(188322, V.LEGION, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 700, 710, 720)
    recipe:SetRecipeItem(127906, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(127842, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRINKET")
    recipe:AddVendor(92457)

    -- Infernal Alchemist Stone -- 188323
    recipe = AddRecipe(188323, V.LEGION, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 720, 730, 740)
    recipe:SetRecipeItem(127925, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(127842, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRINKET")
    recipe:AddWorldDrop(Z.BROKEN_ISLES)

    -- Infernal Alchemist Stone -- 188324
    recipe = AddRecipe(188324, V.LEGION, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 740, 750, 760)
    recipe:SetRecipeItem(127943, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(127842, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRINKET")
    recipe:AddDiscovery("DISCOVERY_ALCH_LEGION_PREV")

    -- Potion of Deadly Grace -- 188325
    recipe = AddRecipe(188325, V.LEGION, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 700, 710, 720)
    recipe:SetRecipeItem(127907, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(127843, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddVendor(92457)

    -- Potion of Deadly Grace -- 188326
    recipe = AddRecipe(188326, V.LEGION, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 720, 730, 740)
    recipe:SetRecipeItem(127926, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(127843, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddFilters(F.INSTANCE)
    recipe:AddMobDrop(104218)
    recipe:AddCustom("MYTHIC")

    -- Potion of Deadly Grace -- 188327
    recipe = AddRecipe(188327, V.LEGION, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 740, 750, 760)
    recipe:SetRecipeItem(127944, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(127843, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddDiscovery("DISCOVERY_ALCH_LEGION_PREV")

    -- Potion of the Old War -- 188328
    recipe = AddRecipe(188328, V.LEGION, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 700, 710, 720)
    recipe:SetRecipeItem(127908, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(127844, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddVendor(92457)

    -- Potion of the Old War -- 188329
    recipe = AddRecipe(188329, V.LEGION, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 720, 730, 740)
    recipe:SetRecipeItem(127927, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(127844, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddFilters(F.INSTANCE)
    recipe:AddMobDrop(98208)
    recipe:AddCustom("MYTHIC")

    -- Potion of the Old War -- 188330
    recipe = AddRecipe(188330, V.LEGION, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 740, 750, 760)
    recipe:SetRecipeItem(127945, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(127844, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddDiscovery("DISCOVERY_ALCH_LEGION_PREV")

    -- Unbending Potion -- 188331
    recipe = AddRecipe(188331, V.LEGION, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 700, 710, 720)
    recipe:SetRecipeItem(127909, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(127845, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddVendor(92457)

    -- Unbending Potion -- 188332
    recipe = AddRecipe(188332, V.LEGION, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 720, 730, 740)
    recipe:SetRecipeItem(127928, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(127845, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddFilters(F.INSTANCE)
    recipe:AddMobDrop(91007)

    -- Unbending Potion -- 188333
    recipe = AddRecipe(188333, V.LEGION, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 740, 750, 760)
    recipe:SetRecipeItem(127946, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(127845, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddDiscovery("DISCOVERY_ALCH_LEGION_PREV")

    -- Leytorrent Potion -- 188334
    recipe = AddRecipe(188334, V.LEGION, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 700, 710, 720)
    recipe:SetRecipeItem(127910, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(127846, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddVendor(92457)

    -- Leytorrent Potion -- 188335
    recipe = AddRecipe(188335, V.LEGION, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 720, 730, 740)
    recipe:SetRecipeItem(127929, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(127846, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddFilters(F.INSTANCE)
    recipe:AddMobDrop(96028)

    -- Leytorrent Potion -- 188336
    recipe = AddRecipe(188336, V.LEGION, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 740, 750, 760)
    recipe:SetRecipeItem(127947, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(127846, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddDiscovery("DISCOVERY_ALCH_LEGION_PREV")

    -- Flask of the Whispered Pact -- 188337
    recipe = AddRecipe(188337, V.LEGION, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 700, 710, 720)
    recipe:SetRecipeItem(127911, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(127847, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_FLASK")
    recipe:AddVendor(92457)

    -- Flask of the Whispered Pact -- 188338
    recipe = AddRecipe(188338, V.LEGION, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 720, 730, 740)
    recipe:SetRecipeItem(127930, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(127847, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_FLASK")
    recipe:AddMobDrop(94923)
    recipe:AddCustom("HEROIC")

    -- Flask of the Whispered Pact -- 188339
    recipe = AddRecipe(188339, V.LEGION, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 740, 750, 760)
    recipe:SetRecipeItem(127948, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(127847, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_FLASK")
    recipe:AddDiscovery("DISCOVERY_ALCH_LEGION_PREV")

    -- Flask of the Seventh Demon -- 188340
    recipe = AddRecipe(188340, V.LEGION, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 700, 710, 720)
    recipe:SetRecipeItem(127912, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(127848, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_FLASK")
    recipe:AddVendor(92457)

    -- Flask of the Seventh Demon -- 188341
    recipe = AddRecipe(188341, V.LEGION, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 720, 730, 740)
    recipe:SetRecipeItem(127931, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(127848, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_FLASK")
    recipe:AddMobDrop(95888)
    recipe:AddCustom("HEROIC")

    -- Flask of the Seventh Demon -- 188342
    recipe = AddRecipe(188342, V.LEGION, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 740, 750, 760)
    recipe:SetRecipeItem(127949, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(127848, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_FLASK")
    recipe:AddDiscovery("DISCOVERY_ALCH_LEGION_PREV")

    -- Flask of the Countless Armies -- 188343
    recipe = AddRecipe(188343, V.LEGION, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 700, 710, 720)
    recipe:SetRecipeItem(127913, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(127849, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_FLASK")
    recipe:AddVendor(92457)

    -- Flask of the Countless Armies -- 188344
    recipe = AddRecipe(188344, V.LEGION, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 720, 730, 740)
    recipe:SetRecipeItem(127932, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(127849, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_FLASK")
    recipe:AddMobDrop(96759)
    recipe:AddCustom("HEROIC")

    -- Flask of the Countless Armies -- 188345
    recipe = AddRecipe(188345, V.LEGION, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 740, 750, 760)
    recipe:SetRecipeItem(127950, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(127849, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_FLASK")
    recipe:AddDiscovery("DISCOVERY_ALCH_LEGION_PREV")

    -- Flask of Ten Thousand Scars -- 188346
    recipe = AddRecipe(188346, V.LEGION, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 700, 710, 720)
    recipe:SetRecipeItem(127914, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(127850, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_FLASK")
    recipe:AddVendor(92457)

    -- Flask of Ten Thousand Scars -- 188347
    recipe = AddRecipe(188347, V.LEGION, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 720, 730, 740)
    recipe:SetRecipeItem(127933, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(127850, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_FLASK")
    recipe:AddMobDrop(110962)
    recipe:AddCustom("HEROIC")

    -- Flask of Ten Thousand Scars -- 188348
    recipe = AddRecipe(188348, V.LEGION, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 740, 750, 760)
    recipe:SetRecipeItem(127951, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(127850, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_FLASK")
    recipe:AddDiscovery("DISCOVERY_ALCH_LEGION_PREV")

    -- Spirit Cauldron -- 188349
    recipe = AddRecipe(188349, V.LEGION, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 700, 710, 720)
    recipe:SetRecipeItem(127915, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(127851, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_CAULDRON")
    recipe:AddVendor(92457)

    -- Spirit Cauldron -- 188350
    recipe = AddRecipe(188350, V.LEGION, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 720, 730, 740)
    recipe:SetRecipeItem(127934, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(127851, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_CAULDRON")
    recipe:AddFilters(F.RAID)
    recipe:AddMobDrop(104636)

    -- Spirit Cauldron -- 188351
    recipe = AddRecipe(188351, V.LEGION, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 740, 750, 760)
    recipe:SetRecipeItem(127952, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(127851, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_CAULDRON")
    recipe:AddDiscovery("DISCOVERY_ALCH_LEGION_PREV")

    -- Wild Transmutation -- 188800
    recipe = AddRecipe(188800, V.LEGION, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 700, 710, 720)
    recipe:SetRecipeItem(128209, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddVendor(92457)

    -- Wild Transmutation -- 188801
    recipe = AddRecipe(188801, V.LEGION, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 720, 730, 740)
    recipe:SetRecipeItem(128210, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddDiscovery("DISCOVERY_ALCH_LEGION_PREV")

    -- Wild Transmutation -- 188802
    recipe = AddRecipe(188802, V.LEGION, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 740, 750, 760)
    recipe:SetRecipeItem(128211, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddDiscovery("DISCOVERY_ALCH_LEGION_PREV")

    -- Transmute: Ore to Cloth -- 213248
    recipe = AddRecipe(213248, V.LEGION, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 700, 730, 760)
    recipe:SetCraftedItem(137590, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddDiscovery("DISCOVERY_ALCH_LEGION")

    -- Transmute: Cloth to Skins -- 213249
    recipe = AddRecipe(213249, V.LEGION, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 700, 730, 760)
    recipe:SetCraftedItem(137591, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddDiscovery("DISCOVERY_ALCH_LEGION")

    -- Transmute: Skins to Ore -- 213250
    recipe = AddRecipe(213250, V.LEGION, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 700, 730, 760)
    recipe:SetCraftedItem(137592, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddDiscovery("DISCOVERY_ALCH_LEGION")

    -- Transmute: Ore to Herbs -- 213251
    recipe = AddRecipe(213251, V.LEGION, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 700, 730, 760)
    recipe:SetCraftedItem(137593, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddDiscovery("DISCOVERY_ALCH_LEGION")

    -- Transmute: Cloth to Herbs -- 213252
    recipe = AddRecipe(213252, V.LEGION, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 700, 730, 760)
    recipe:SetCraftedItem(137593, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddDiscovery("DISCOVERY_ALCH_LEGION")

    -- Transmute: Skins to Herbs -- 213253
    recipe = AddRecipe(213253, V.LEGION, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 700, 730, 760)
    recipe:SetCraftedItem(137593, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddDiscovery("DISCOVERY_ALCH_LEGION")

    -- Transmute: Fish to Gems -- 213254
    recipe = AddRecipe(213254, V.LEGION, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 700, 730, 760)
    recipe:SetCraftedItem(137594, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddDiscovery("DISCOVERY_ALCH_LEGION")

    -- Transmute: Meat to Pants -- 213255
    recipe = AddRecipe(213255, V.LEGION, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 700, 730, 760)
    recipe:SetCraftedItem(137600, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddDiscovery("DISCOVERY_ALCH_LEGION")

    -- Transmute: Meat to Pet -- 213256
    recipe = AddRecipe(213256, V.LEGION, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 700, 730, 760)
    recipe:SetCraftedItem(137599, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddDiscovery("DISCOVERY_ALCH_LEGION")

    -- Transmute: Blood of Sargeras -- 213257
    recipe = AddRecipe(213257, V.LEGION, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 700, 730, 760)
    recipe:SetCraftedItem(124124, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddDiscovery("DISCOVERY_ALCH_LEGION")

    -- Silvery Salve -- 221690
    recipe = AddRecipe(221690, V.LEGION, Q.COMMON)
    recipe:SetSkillLevels(30, 30, 40, 500, 60)
    recipe:SetRecipeItem(160664, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(136653, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ALCHEMY_MISC")
    recipe:AddVendor(92457)

    -- Potion of Prolonged Power -- 229217
    recipe = AddRecipe(229217, V.LEGION, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 740, 750, 760)
    recipe:SetRecipeItem(142119, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(142117, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddWorldDrop(Z.BROKEN_ISLES)

    -- Potion of Prolonged Power -- 229218
    recipe = AddRecipe(229218, V.LEGION, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 760, 770, 780)
    recipe:SetRecipeItem(142120, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(142117, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddRepVendor(FAC.THE_NIGHTFALLEN, REP.REVERED, 115736)

    -- Potion of Prolonged Power -- 229220
    recipe = AddRecipe(229220, V.LEGION, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 780, 790, 800)
    recipe:SetRecipeItem(142121, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(142117, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddMobDrop(110321)

    -- Lightblood Elixir -- 247619
    recipe = AddRecipe(247619, V.LEGION, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 780, 790, 800)
    recipe:SetRecipeItem(151657, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(142117, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddQuest(48002)

    -- Lightblood Elixir -- 247620
    recipe = AddRecipe(247620, V.LEGION, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 780, 790, 800)
    recipe:SetRecipeItem(151658, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(142117, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddQuest(48318)

    -- Lightblood Elixir -- 247622
    recipe = AddRecipe(247622, V.LEGION, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 780, 790, 800)
    recipe:SetRecipeItem(151659, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(142117, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddDiscovery("DISCOVERY_ALCH_LEGION_PREV")

    -- Tears of the Naaru -- 247688
    recipe = AddRecipe(247688, V.LEGION, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 780, 790, 800)
    recipe:SetRecipeItem(151703, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(151930, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddQuest(48013)

    -- Tears of the Naaru -- 247690
    recipe = AddRecipe(247690, V.LEGION, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 780, 790, 800)
    recipe:SetRecipeItem(151704, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(151930, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddQuest(48323)

    -- Tears of the Naaru -- 247691
    recipe = AddRecipe(247691, V.LEGION, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 780, 790, 800)
    recipe:SetRecipeItem(151705, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(151930, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddDiscovery("DISCOVERY_ALCH_LEGION_PREV")

    -- Astral Alchemist Stone -- 247694
    recipe = AddRecipe(247694, V.LEGION, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 790, 795, 800)
    recipe:SetRecipeItem(151706, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(151607, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRINKET")
    recipe:AddQuest(48016)

    -- Astral Alchemist Stone -- 247695
    recipe = AddRecipe(247695, V.LEGION, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 790, 795, 800)
    recipe:SetRecipeItem(151707, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(151607, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRINKET")
    recipe:AddRepVendor(FAC.ARGUSSIAN_REACH, REP.REVERED, 127151)

    -- Astral Alchemist Stone -- 247696
    recipe = AddRecipe(247696, V.LEGION, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 790, 795, 800)
    recipe:SetRecipeItem(151708, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(151607, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRINKET")
    recipe:AddRepVendor(FAC.ARGUSSIAN_REACH, REP.EXALTED, 127151)

    -- Transmute: Primal Sargerite -- 247701
    recipe = AddRecipe(247701, V.LEGION, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 720, 750, 780)
    recipe:SetRecipeItem(151710, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(151568, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddVendor(125346)

    -- Astral Healing Potion -- 251646
    recipe = AddRecipe(251646, V.LEGION, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 740, 750, 760)
    recipe:SetRecipeItem(152616, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(152615, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddVendor(125346)

    -- Astral Healing Potion -- 251651
    recipe = AddRecipe(251651, V.LEGION, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 760, 770, 780)
    recipe:SetRecipeItem(152617, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(152615, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddDiscovery("DISCOVERY_ALCH_LEGION_PREV")

    -- Astral Healing Potion -- 251658
    recipe = AddRecipe(251658, V.LEGION, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 780, 790, 800)
    recipe:SetRecipeItem(152618, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(152615, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddRepVendor(FAC.ARGUSSIAN_REACH, REP.EXALTED, 127151)

    -- ----------------------------------------------------------------------------
    -- Battle for Azeroth.
    -- ----------------------------------------------------------------------------
    -- Transmute: Herbs to Ore -- 251305
    recipe = AddRecipe(251305, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(50, 50, 60, 65, 70)
    recipe:SetCraftedItem(160322, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddTrainer(122703, 132228, 153811, 154393)

    -- Transmute: Herbs to Cloth -- 251306
    recipe = AddRecipe(251306, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(50, 50, 60, 65, 70)
    recipe:SetCraftedItem(152580, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddTrainer(122703, 132228, 153811, 154393)

    -- Transmute: Ore to Herbs -- 251309
    recipe = AddRecipe(251309, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(50, 50, 60, 65, 70)
    recipe:SetCraftedItem(152578, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddTrainer(122703, 132228, 153811, 154393)

    -- Transmute: Ore to Cloth -- 251310
    recipe = AddRecipe(251310, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(50, 50, 60, 65, 70)
    recipe:SetCraftedItem(152580, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddTrainer(122703, 132228, 153811, 154393)

    -- Transmute: Ore to Gems -- 251311
    recipe = AddRecipe(251311, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(50, 50, 60, 65, 70)
    recipe:SetCraftedItem(152581, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddTrainer(122703, 132228, 153811, 154393)

    -- Transmute: Cloth to Skins -- 251314
    recipe = AddRecipe(251314, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(50, 50, 60, 65, 70)
    recipe:SetCraftedItem(152582, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddTrainer(122703, 132228, 153811, 154393)

    -- Transmute: Meat to Pet -- 251808
    recipe = AddRecipe(251808, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(50, 50, 60, 65, 70)
    recipe:SetCraftedItem(160325, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddTrainer(122703, 132228, 153811, 154393)

    -- Transmute: Fish to Gems -- 251822
    recipe = AddRecipe(251822, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(50, 50, 60, 65, 70)
    recipe:SetCraftedItem(152581, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddTrainer(122703, 132228, 153811, 154393)

    -- Transmute: Expulsom -- 251832
    recipe = AddRecipe(251832, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(110, 110, 120, 125, 130)
    recipe:SetCraftedItem(152668, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddTrainer(122703, 132228, 153811, 154393)

    -- Steelskin Potion -- 252334
    recipe = AddRecipe(252334, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(40, 40, 50, 55, 60)
    recipe:SetCraftedItem(152557, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddFilters(F.TANK)
    recipe:AddTrainer(122703, 132228, 153811, 154393)

    -- Steelskin Potion -- 252335
    recipe = AddRecipe(252335, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(60, 60, 70, 75, 80)
    recipe:SetCraftedItem(152557, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddFilters(F.TANK)
    recipe:AddTrainer(122703, 132228, 153811, 154393)

    -- Steelskin Potion -- 252336
    recipe = AddRecipe(252336, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 100, 117, 135)
    recipe:SetRecipeItem(162128, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(152557, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddFilters(F.TANK)
    recipe:AddRepVendor(FAC.SEVENTH_LEGION, REP.REVERED, 135446)
    recipe:AddRepVendor(FAC.THE_HONORBOUND, REP.REVERED, 135447)

    -- Potion of Replenishment -- 252337
    recipe = AddRecipe(252337, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(40, 40, 50, 55, 60)
    recipe:SetCraftedItem(152561, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(122703, 132228, 153811, 154393)

    -- Potion of Replenishment -- 252339
    recipe = AddRecipe(252339, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(60, 60, 70, 75, 80)
    recipe:SetCraftedItem(152561, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(122703, 132228, 153811, 154393)

    -- Potion of Replenishment -- 252340
    recipe = AddRecipe(252340, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 100, 117, 135)
    recipe:SetRecipeItem(162129, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(152561, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddRepVendor(FAC.ZANDALARI_EMPIRE, REP.REVERED, 131287)
    recipe:AddRepVendor(FAC.STORMS_WAKE, REP.REVERED, 135800)

    -- Potion of Bursting Blood -- 252341
    recipe = AddRecipe(252341, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(40, 40, 50, 55, 60)
    recipe:SetCraftedItem(152560, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(122703, 132228, 153811, 154393)

    -- Potion of Bursting Blood -- 252342
    recipe = AddRecipe(252342, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(60, 60, 70, 75, 80)
    recipe:SetCraftedItem(152560, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(122703, 132228, 153811, 154393)

    -- Potion of Bursting Blood -- 252343
    recipe = AddRecipe(252343, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 100, 117, 135)
    recipe:SetRecipeItem(162130, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(152560, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddRepVendor(FAC.PROUDMOORE_ADMIRALTY, REP.REVERED, 135808)
    recipe:AddRepVendor(FAC.TALANJIS_EXPEDITION, REP.REVERED, 135459)

    -- Potion of Rising Death -- 252344
    recipe = AddRecipe(252344, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(40, 40, 50, 55, 60)
    recipe:SetCraftedItem(152559, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(122703, 132228, 153811, 154393)

    -- Potion of Rising Death -- 252345
    recipe = AddRecipe(252345, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(60, 60, 70, 75, 80)
    recipe:SetCraftedItem(152559, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(122703, 132228, 153811, 154393)

    -- Potion of Rising Death -- 252346
    recipe = AddRecipe(252346, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 100, 117, 135)
    recipe:SetRecipeItem(162131, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(152559, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddRepVendor(FAC.ORDER_OF_EMBERS, REP.REVERED, 135815)
    recipe:AddRepVendor(FAC.VOLDUNAI, REP.REVERED, 135804)

    -- Flask of the Currents -- 252348
    recipe = AddRecipe(252348, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(90, 90, 100, 105, 110)
    recipe:SetCraftedItem(152638, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_FLASK")
    recipe:AddFilters(F.DPS)
    recipe:AddTrainer(122703, 132228, 153811, 154393)

    -- Flask of the Currents -- 252349
    recipe = AddRecipe(252349, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(115, 115, 125, 130, 135)
    recipe:SetCraftedItem(152638, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_FLASK")
    recipe:AddFilters(F.DPS)
    recipe:AddTrainer(122703, 132228, 153811, 154393)

    -- Flask of the Currents -- 252350
    recipe = AddRecipe(252350, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 100, 117, 135)
    recipe:SetRecipeItem(162132, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(152638, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_FLASK")
    recipe:AddFilters(F.DPS)
    recipe:AddRepVendor(FAC.SEVENTH_LEGION, REP.REVERED, 135446)
    recipe:AddRepVendor(FAC.THE_HONORBOUND, REP.REVERED, 135447)

    -- Flask of Endless Fathoms -- 252351
    recipe = AddRecipe(252351, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(90, 90, 100, 105, 110)
    recipe:SetCraftedItem(152639, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_FLASK")
    recipe:AddTrainer(122703, 132228, 153811, 154393)

    -- Flask of Endless Fathoms -- 252352
    recipe = AddRecipe(252352, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(115, 115, 125, 130, 135)
    recipe:SetCraftedItem(152639, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_FLASK")
    recipe:AddTrainer(122703, 132228, 153811, 154393)

    -- Flask of Endless Fathoms -- 252353
    recipe = AddRecipe(252353, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 150, 150, 150)
    recipe:SetRecipeItem(162133, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(152639, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_FLASK")
    recipe:AddRepVendor(FAC.ZANDALARI_EMPIRE, REP.REVERED, 131287)
    recipe:AddRepVendor(FAC.STORMS_WAKE, REP.REVERED, 135800)

    -- Flask of the Vast Horizon -- 252354
    recipe = AddRecipe(252354, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(90, 90, 100, 105, 110)
    recipe:SetCraftedItem(152640, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_FLASK")
    recipe:AddTrainer(122703, 132228, 153811, 154393)

    -- Flask of the Vast Horizon -- 252355
    recipe = AddRecipe(252355, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(115, 115, 125, 130, 135)
    recipe:SetCraftedItem(152640, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_FLASK")
    recipe:AddTrainer(122703, 132228, 153811, 154393)

    -- Flask of the Vast Horizon -- 252356
    recipe = AddRecipe(252356, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 150, 150, 150)
    recipe:SetRecipeItem(162134, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(152640, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_FLASK")
    recipe:AddRepVendor(FAC.PROUDMOORE_ADMIRALTY, REP.REVERED, 135808)
    recipe:AddRepVendor(FAC.TALANJIS_EXPEDITION, REP.REVERED, 135459)

    -- Flask of the Undertow -- 252357
    recipe = AddRecipe(252357, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(90, 90, 100, 105, 110)
    recipe:SetCraftedItem(152641, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_FLASK")
    recipe:AddTrainer(122703, 132228, 153811, 154393)

    -- Flask of the Undertow -- 252358
    recipe = AddRecipe(252358, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(115, 115, 125, 130, 135)
    recipe:SetCraftedItem(152641, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_FLASK")
    recipe:AddTrainer(122703, 132228, 153811, 154393)

    -- Flask of the Undertow -- 252359
    recipe = AddRecipe(252359, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 150, 150, 150)
    recipe:SetRecipeItem(162135, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(152641, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_FLASK")
    recipe:AddRepVendor(FAC.ORDER_OF_EMBERS, REP.REVERED, 135815)
    recipe:AddRepVendor(FAC.VOLDUNAI, REP.REVERED, 135804)

    -- Endless Tincture of Renewed Combat -- 252361
    recipe = AddRecipe(252361, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(25, 25, 35, 40, 45)
    recipe:SetCraftedItem(152634, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRINKET")
    recipe:AddTrainer(122703, 132228, 153811, 154393)

    -- Endless Tincture of Renewed Combat -- 252362
    recipe = AddRecipe(252362, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(60, 60, 70, 75, 80)
    recipe:SetCraftedItem(152634, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRINKET")
    recipe:AddTrainer(122703, 132228, 153811, 154393)

    -- Endless Tincture of Renewed Combat -- 252363
    recipe = AddRecipe(252363, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(60, 60, 70, 75, 80)
    recipe:SetRecipeItem(162136, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(152634, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRINKET")
    recipe:AddRepVendor(FAC.TORTOLLAN_SEEKERS, REP.REVERED, 134345, 135793)

    -- Siren's Alchemist Stone -- 252368
    recipe = AddRecipe(252368, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(25, 25, 35, 40, 45)
    recipe:SetCraftedItem(152637, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRINKET")
    recipe:AddTrainer(122703, 132228, 153811, 154393)

    -- Siren's Alchemist Stone -- 252369
    recipe = AddRecipe(252369, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(60, 60, 70, 75, 80)
    recipe:SetCraftedItem(152637, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRINKET")
    recipe:AddTrainer(122703, 132228, 153811, 154393)

    -- Siren's Alchemist Stone -- 252370
    recipe = AddRecipe(252370, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 90, 110, 130)
    recipe:SetRecipeItem(162137, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(152637, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRINKET")
    recipe:AddRepVendor(FAC.TORTOLLAN_SEEKERS, REP.REVERED, 134345, 135793)

    -- Endless Tincture of Fractional Power -- 252376
    recipe = AddRecipe(252376, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(80, 80, 90, 95, 100)
    recipe:SetCraftedItem(152636, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRINKET")
    recipe:AddTrainer(122703, 132228, 153811, 154393)

    -- Endless Tincture of Fractional Power -- 252377
    recipe = AddRecipe(252377, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(100, 100, 110, 115, 120)
    recipe:SetCraftedItem(152636, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRINKET")
    recipe:AddTrainer(122703, 132228, 153811, 154393)

    -- Endless Tincture of Fractional Power -- 252378
    recipe = AddRecipe(252378, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 150, 150, 150)
    recipe:SetRecipeItem(162138, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(152636, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRINKET")
    recipe:AddRepVendor(FAC.SEVENTH_LEGION, REP.REVERED, 135446)
    recipe:AddRepVendor(FAC.THE_HONORBOUND, REP.REVERED, 135447)

    -- Surging Alchemist Stone -- 252379
    recipe = AddRecipe(252379, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(80, 80, 90, 95, 100)
    recipe:SetCraftedItem(152632, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRINKET")
    recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
    recipe:AddTrainer(122703, 132228, 153811, 154393)

    -- Surging Alchemist Stone -- 252380
    recipe = AddRecipe(252380, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(100, 100, 110, 115, 120)
    recipe:SetCraftedItem(152632, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRINKET")
    recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
    recipe:AddTrainer(122703, 132228, 153811, 154393)

    -- Surging Alchemist Stone -- 252381
    recipe = AddRecipe(252381, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 150, 150, 150)
    recipe:SetRecipeItem(162139, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(152632, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRINKET")
    recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
    recipe:AddRepVendor(FAC.SEVENTH_LEGION, REP.REVERED, 135446)
    recipe:AddRepVendor(FAC.THE_HONORBOUND, REP.REVERED, 135447)

    -- Coastal Healing Potion -- 252382
    recipe = AddRecipe(252382, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 25, 37, 50)
    recipe:SetCraftedItem(152494, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddCustom("DEFAULT_RECIPE")

    -- Coastal Healing Potion -- 252383
    recipe = AddRecipe(252383, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(40, 40, 50, 55, 60)
    recipe:SetCraftedItem(152494, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(122703, 132228, 153811, 154393)

    -- Coastal Healing Potion -- 252384
    recipe = AddRecipe(252384, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(40, 40, 75, 87, 100)
    recipe:SetRecipeItem(162255, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(152494, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddRepVendor(FAC.ZANDALARI_EMPIRE, REP.REVERED, 131287)
    recipe:AddRepVendor(FAC.STORMS_WAKE, REP.REVERED, 135800)

    -- Coastal Mana Potion -- 252385
    recipe = AddRecipe(252385, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 25, 37, 50)
    recipe:SetCraftedItem(152495, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddCustom("DEFAULT_RECIPE")

    -- Coastal Mana Potion -- 252386
    recipe = AddRecipe(252386, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(40, 40, 50, 55, 60)
    recipe:SetCraftedItem(152495, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(122703, 132228, 153811, 154393)

    -- Coastal Mana Potion -- 252387
    recipe = AddRecipe(252387, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(40, 40, 75, 87, 100)
    recipe:SetRecipeItem(162254, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(152495, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddRepVendor(FAC.PROUDMOORE_ADMIRALTY, REP.REVERED, 135808)
    recipe:AddRepVendor(FAC.TALANJIS_EXPEDITION, REP.REVERED, 135459)

    -- Coastal Rejuvenation Potion -- 252388
    recipe = AddRecipe(252388, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 11, 16, 21)
    recipe:SetCraftedItem(163082, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(122703, 132228, 153811, 154393)

    -- Coastal Rejuvenation Potion -- 252389
    recipe = AddRecipe(252389, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(40, 40, 50, 55, 60)
    recipe:SetCraftedItem(163082, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(122703, 132228, 153811, 154393)

    -- Coastal Rejuvenation Potion -- 252390
    recipe = AddRecipe(252390, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(40, 40, 75, 87, 100)
    recipe:SetRecipeItem(162254, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(163082, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddRepVendor(FAC.ORDER_OF_EMBERS, REP.REVERED, 135815)
    recipe:AddRepVendor(FAC.VOLDUNAI, REP.REVERED, 135804)

    -- Demitri's Draught of Deception -- 252391
    recipe = AddRecipe(252391, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(25, 25, 35, 40, 45)
    recipe:SetCraftedItem(152496, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(122703, 132228, 153811, 154393)

    -- Demitri's Draught of Deception -- 252392
    recipe = AddRecipe(252392, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(50, 50, 60, 65, 70)
    recipe:SetCraftedItem(152496, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(122703, 132228, 153811, 154393)

    -- Demitri's Draught of Deception -- 252393
    recipe = AddRecipe(252393, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(70, 70, 85, 105, 125)
    recipe:SetCraftedItem(152496, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddQuest(52331, 52335)

    -- Lightfoot Potion -- 252394
    recipe = AddRecipe(252394, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(25, 25, 35, 40, 45)
    recipe:SetCraftedItem(152497, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(122703, 132228, 153811, 154393)

    -- Lightfoot Potion -- 252395
    recipe = AddRecipe(252395, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(50, 50, 60, 65, 70)
    recipe:SetCraftedItem(152497, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(122703, 132228, 153811, 154393)

    -- Lightfoot Potion -- 252396
    recipe = AddRecipe(252396, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(70, 70, 85, 105, 125)
    recipe:SetCraftedItem(152497, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddQuest(52332, 52336)

    -- Sea Mist Potion -- 252397
    recipe = AddRecipe(252397, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(25, 25, 35, 40, 45)
    recipe:SetCraftedItem(152550, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(122703, 132228, 153811, 154393)

    -- Sea Mist Potion -- 252398
    recipe = AddRecipe(252398, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(50, 50, 60, 65, 70)
    recipe:SetCraftedItem(152550, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(122703, 132228, 153811, 154393)

    -- Sea Mist Potion -- 252399
    recipe = AddRecipe(252399, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(70, 70, 85, 105, 125)
    recipe:SetCraftedItem(152550, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddQuest(52333, 52337)

    -- Potion of Concealment -- 252400
    recipe = AddRecipe(252400, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(25, 25, 35, 40, 45)
    recipe:SetCraftedItem(152503, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(122703, 132228, 153811, 154393)

    -- Potion of Concealment -- 252401
    recipe = AddRecipe(252401, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(50, 50, 60, 65, 70)
    recipe:SetCraftedItem(152503, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(122703, 132228, 153811, 154393)

    -- Potion of Concealment -- 252402
    recipe = AddRecipe(252402, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(70, 70, 85, 105, 125)
    recipe:SetCraftedItem(152503, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddQuest(52334, 52338)

    -- Silas' Sphere of Transmutation -- 260403
    recipe = AddRecipe(260403, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(150, 150, 150, 150, 150)
    recipe:SetRecipeItem(166422, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(156631, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddVendor(122703, 132228)

    -- Mystical Cauldron -- 276975
    recipe = AddRecipe(276975, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(145, 145, 155, 160, 165)
    recipe:SetCraftedItem(162519, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_CAULDRON")
    recipe:AddTrainer(122703, 132228, 153811, 154393)

    -- Mystical Cauldron -- 276976
    recipe = AddRecipe(276976, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 150, 150, 150)
    recipe:SetRecipeItem(162520, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(162519, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_CAULDRON")
    recipe:AddCustom("MYTHIC_DUNGEON")

    -- Mystical Cauldron -- 276977
    recipe = AddRecipe(276977, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 150, 150, 150)
    recipe:SetRecipeItem(162521, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(162519, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_CAULDRON")
    recipe:AddWorldDrop(Z.ULDIR)

    -- Potion of Herb Tracking -- 278420
    recipe = AddRecipe(278420, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(60, 60, 70, 75, 80)
    recipe:SetCraftedItem(165744, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(122703, 132228, 153811, 154393)

    -- Battle Potion of Agility -- 279159
    recipe = AddRecipe(279159, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(50, 50, 60, 65, 70)
    recipe:SetCraftedItem(163223, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(122703, 132228, 153811, 154393)

    -- Battle Potion of Agility -- 279160
    recipe = AddRecipe(279160, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(75, 75, 85, 90, 95)
    recipe:SetCraftedItem(163223, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(122703, 132228, 153811, 154393)

    -- Battle Potion of Agility -- 279161
    recipe = AddRecipe(279161, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 100, 117, 135)
    recipe:SetRecipeItem(163313, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(163223, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddRepVendor(FAC.ORDER_OF_EMBERS, REP.REVERED, 135815)
    recipe:AddRepVendor(FAC.VOLDUNAI, REP.REVERED, 135804)

    -- Battle Potion of Intellect -- 279162
    recipe = AddRecipe(279162, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(50, 50, 60, 65, 70)
    recipe:SetCraftedItem(163222, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(122703, 132228, 153811, 154393)

    -- Battle Potion of Intellect -- 279163
    recipe = AddRecipe(279163, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(75, 75, 85, 90, 95)
    recipe:SetCraftedItem(163222, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(122703, 132228, 153811, 154393)

    -- Battle Potion of Intellect -- 279164
    recipe = AddRecipe(279164, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 100, 117, 135)
    recipe:SetRecipeItem(163316, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(163222, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddRepVendor(FAC.PROUDMOORE_ADMIRALTY, REP.REVERED, 135808)
    recipe:AddRepVendor(FAC.TALANJIS_EXPEDITION, REP.REVERED, 135459)

    -- Battle Potion of Stamina -- 279165
    recipe = AddRecipe(279165, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(50, 50, 60, 65, 70)
    recipe:SetCraftedItem(163225, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(122703, 132228, 153811, 154393)

    -- Battle Potion of Stamina -- 279166
    recipe = AddRecipe(279166, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(75, 75, 85, 90, 95)
    recipe:SetCraftedItem(163225, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(122703, 132228, 153811, 154393)

    -- Battle Potion of Stamina -- 279167
    recipe = AddRecipe(279167, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 100, 117, 135)
    recipe:SetRecipeItem(163318, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(163225, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddRepVendor(FAC.ZANDALARI_EMPIRE, REP.REVERED, 131287)
    recipe:AddRepVendor(FAC.STORMS_WAKE, REP.REVERED, 135800)

    -- Battle Potion of Strength -- 279168
    recipe = AddRecipe(279168, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(50, 50, 60, 65, 70)
    recipe:SetCraftedItem(163224, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddFilters(F.DPS)
    recipe:AddTrainer(122703, 132228, 153811, 154393)

    -- Battle Potion of Strength -- 279169
    recipe = AddRecipe(279169, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(75, 75, 85, 90, 95)
    recipe:SetCraftedItem(163224, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddFilters(F.DPS)
    recipe:AddTrainer(122703, 132228, 153811, 154393)

    -- Battle Potion of Strength -- 279170
    recipe = AddRecipe(279170, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 100, 117, 135)
    recipe:SetRecipeItem(163320, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(163224, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddFilters(F.DPS)
    recipe:AddRepVendor(FAC.SEVENTH_LEGION, REP.REVERED, 135446)
    recipe:AddRepVendor(FAC.THE_HONORBOUND, REP.REVERED, 135447)

    -- Transmute: Herbs to Anchors -- 286547
    recipe = AddRecipe(286547, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(50, 50, 60, 65, 70)
    recipe:SetCraftedItem(165851, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddTrainer(122703, 132228, 153811, 154393)

    -- Sanguinated Dilution -- 286630
    recipe = AddRecipe(286630, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 11, 16, 21)
    recipe:SetCraftedItem(162461, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddTrainer(122703, 132228, 153811, 154393)

    -- Tidal Alchemist Stone -- 286921
    recipe = AddRecipe(286921, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(130, 130, 140, 145, 150)
    recipe:SetCraftedItem(165926, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRINKET")
    recipe:AddTrainer(122703, 132228, 153811, 154393)

    -- Spirited Alchemist Stone -- 286922
    recipe = AddRecipe(286922, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 150, 15, 150)
    recipe:SetCraftedItem(165927, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ALCHEMY_TRINKET")
    recipe:AddDiscovery("DISCOVERY_ALCH_BFA")

    -- Eternal Alchemist Stone -- 286923
    recipe = AddRecipe(286923, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 150, 15, 150)
    recipe:SetCraftedItem(165928, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ALCHEMY_TRINKET")
    recipe:AddDiscovery("DISCOVERY_ALCH_BFA")

    -- Aqueous Dilution -- 287234
    recipe = AddRecipe(287234, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 11, 16, 21)
    recipe:SetCraftedItem(162460, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddTrainer(122703, 132228, 153811, 154393)

    -- Vial of Obfuscation -- 287288
    recipe = AddRecipe(287288, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(60, 60, 70, 75, 80)
    recipe:SetCraftedItem(165721, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_MISC")
    recipe:AddTrainer(122703, 132228, 153811, 154393)

    -- Potion of the Unveiling Eye -- 287447
    recipe = AddRecipe(287447, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(50, 50, 60, 65, 70)
    recipe:SetCraftedItem(166270, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(122703, 132228, 153811, 154393)

    -- Potion of the Unveiling Eye -- 287448
    recipe = AddRecipe(287448, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 65, 82, 100)
    recipe:SetCraftedItem(166270, "BIND_ON_EQUIP")
    recipe:SetRecipeItem(166272, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddVendor(142552, 142564)

    -- Potion of the Unveiling Eye -- 287449
    recipe = AddRecipe(287449, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 85, 105, 125)
    recipe:SetCraftedItem(166270, "BIND_ON_EQUIP")
    recipe:SetRecipeItem(166271, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddVendor(142552, 142564)

    -- Potion of Shifting States -- 288176
    recipe = AddRecipe(288176, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(0, 0, 0, 0, 0)

    -- Potion of Durability -- 288182
    recipe = AddRecipe(288182, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(0, 0, 0, 0, 0)

    -- Sanguinated Alchemist Stone -- 291084
    recipe = AddRecipe(291084, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(100, 100, 110, 115, 120)
    recipe:SetCraftedItem(166974, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRINKET")
    recipe:AddTrainer(122703, 132228, 153811, 154393)

    -- Imbued Alchemist Stone -- 291085
    recipe = AddRecipe(291085, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 130, 140, 150)
    recipe:SetCraftedItem(166975, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRINKET")
    recipe:AddDiscovery("DISCOVERY_ALCH_BFA")

    -- Emblazoned Alchemist Stone -- 291086
    recipe = AddRecipe(291086, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 135, 142, 150)
    recipe:SetCraftedItem(166965, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRINKET")
    recipe:AddDiscovery("DISCOVERY_ALCH_BFA")

    -- Potion of Empowered Proximity -- 298726
    recipe = AddRecipe(298726, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(145, 145, 155, 160, 165)
    recipe:SetRecipeItem(169492, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(168529, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(153811, 154393)

    -- Potion of Empowered Proximity -- 298727
    recipe = AddRecipe(298727, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(160, 160, 170, 175, 180)
    recipe:SetRecipeItem(169492, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(168529, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(153811, 154393)

    -- Potion of Empowered Proximity -- 298728
    recipe = AddRecipe(298728, V.BFA, Q.EPIC)
    recipe:SetSkillLevels(155, 155, 175, 175, 175)
    recipe:SetRecipeItem(169492, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(168529, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddRepVendor(FAC.ANKOAN, REP.REVERED, 154140)
    recipe:AddRepVendor(FAC.THE_UNSHACKLED, REP.REVERED, 153512)

    -- Superior Battle Potion of Agility -- 298729
    recipe = AddRecipe(298729, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(150, 150, 160, 165, 170)
    recipe:SetCraftedItem(168489, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(153811, 154393)

    -- Superior Battle Potion of Agility -- 298730
    recipe = AddRecipe(298730, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(165, 165, 175, 180, 185)
    recipe:SetCraftedItem(168489, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(153811, 154393)

    -- Superior Battle Potion of Agility -- 298731
    recipe = AddRecipe(298731, V.BFA, Q.EPIC)
    recipe:SetSkillLevels(155, 155, 175, 175, 175)
    recipe:SetRecipeItem(169495, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(168489, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddWorldDrop(Z.NAZJATAR)

    -- Superior Steelskin Potion -- 298734
    recipe = AddRecipe(298734, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(150, 150, 160, 165, 170)
    recipe:SetCraftedItem(168501, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(153811, 154393)

    -- Superior Steelskin Potion -- 298735
    recipe = AddRecipe(298735, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(165, 165, 175, 180, 185)
    recipe:SetCraftedItem(168501, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(153811, 154393)

    -- Superior Steelskin Potion -- 298736
    recipe = AddRecipe(298736, V.BFA, Q.EPIC)
    recipe:SetSkillLevels(155, 155, 175, 175, 175)
    recipe:SetRecipeItem(169496, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(168501, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddWorldDrop(Z.NAZJATAR)

    -- Superior Battle Potion of Intellect -- 298741
    recipe = AddRecipe(298741, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(150, 150, 160, 165, 170)
    recipe:SetCraftedItem(168498, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(153811, 154393)

    -- Superior Battle Potion of Intellect -- 298742
    recipe = AddRecipe(298742, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(165, 165, 175, 180, 185)
    recipe:SetCraftedItem(168498, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(153811, 154393)

    -- Superior Battle Potion of Intellect -- 298743
    recipe = AddRecipe(298743, V.BFA, Q.EPIC)
    recipe:SetSkillLevels(155, 155, 175, 175, 175)
    recipe:SetRecipeItem(169493, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(168498, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddWorldDrop(Z.NAZJATAR)

    -- Potion of Focused Resolve -- 298744
    recipe = AddRecipe(298744, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(145, 145, 155, 160, 165)
    recipe:SetCraftedItem(168506, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(153811, 154393)

    -- Potion of Focused Resolve -- 298745
    recipe = AddRecipe(298745, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(160, 160, 170, 175, 180)
    recipe:SetCraftedItem(168506, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(153811, 154393)

    -- Potion of Focused Resolve -- 298746
    recipe = AddRecipe(298746, V.BFA, Q.EPIC)
    recipe:SetSkillLevels(155, 155, 175, 175, 175)
    recipe:SetRecipeItem(169494, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddRepVendor(FAC.ANKOAN, REP.REVERED, 154140)
    recipe:AddRepVendor(FAC.THE_UNSHACKLED, REP.REVERED, 153512)

    -- Superior Battle Potion of Stamina -- 298747
    recipe = AddRecipe(298747, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(150, 150, 160, 165, 170)
    recipe:SetCraftedItem(168499, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(153811, 154393)

    -- Superior Battle Potion of Stamina -- 298748
    recipe = AddRecipe(298748, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(165, 165, 175, 180, 185)
    recipe:SetCraftedItem(168499, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(153811, 154393)

    -- Superior Battle Potion of Stamina -- 298749
    recipe = AddRecipe(298749, V.BFA, Q.EPIC)
    recipe:SetSkillLevels(155, 155, 175, 175, 175)
    recipe:SetRecipeItem(169498, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(168499, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddWorldDrop(Z.NAZJATAR)

    -- Superior Battle Potion of Strength -- 298750
    recipe = AddRecipe(298750, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(150, 150, 160, 165, 170)
    recipe:SetCraftedItem(168500, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(153811, 154393)

    -- Superior Battle Potion of Strength -- 298751
    recipe = AddRecipe(298751, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(165, 165, 175, 180, 185)
    recipe:SetCraftedItem(168500, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(153811, 154393)

    -- Superior Battle Potion of Strength -- 298752
    recipe = AddRecipe(298752, V.BFA, Q.EPIC)
    recipe:SetSkillLevels(155, 155, 175, 175, 175)
    recipe:SetRecipeItem(169499, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(168500, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddWorldDrop(Z.NAZJATAR)

    -- Greater Flask of the Currents -- 298842
    recipe = AddRecipe(298842, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(155, 155, 165, 170, 175)
    recipe:SetCraftedItem(168651, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_FLASK")
    recipe:AddTrainer(153811, 154393)

    -- Greater Flask of the Currents -- 298843
    recipe = AddRecipe(298843, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(170, 170, 180, 185, 190)
    recipe:SetCraftedItem(168651, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_FLASK")
    recipe:AddTrainer(153811, 154393)

    -- Greater Flask of the Currents -- 298845
    recipe = AddRecipe(298845, V.BFA, Q.EPIC)
    recipe:SetSkillLevels(155, 155, 175, 175, 175)
    recipe:SetRecipeItem(169500, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(168651, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_FLASK")
    recipe:AddQuest(56570, 56770)

    -- Greater Flask of Endless Fathoms -- 298846
    recipe = AddRecipe(298846, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(155, 155, 165, 170, 175)
    recipe:SetCraftedItem(168652, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_FLASK")
    recipe:AddTrainer(153811, 154393)

    -- Greater Flask of Endless Fathoms -- 298847
    recipe = AddRecipe(298847, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(170, 170, 180, 185, 190)
    recipe:SetCraftedItem(168652, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_FLASK")
    recipe:AddTrainer(153811, 154393)

    -- Greater Flask of Endless Fathoms -- 298848
    recipe = AddRecipe(298848, V.BFA, Q.EPIC)
    recipe:SetSkillLevels(155, 155, 175, 175, 175)
    recipe:SetRecipeItem(169501, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(168652, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_FLASK")
    recipe:AddQuest(56767, 56772)

    -- Greater Flask of the Vast Horizon -- 298850
    recipe = AddRecipe(298850, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(155, 155, 165, 170, 175)
    recipe:SetCraftedItem(168653, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_FLASK")
    recipe:AddTrainer(153811, 154393)

    -- Greater Flask of the Vast Horizon -- 298851
    recipe = AddRecipe(298851, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(170, 170, 180, 185, 190)
    recipe:SetCraftedItem(168653, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_FLASK")
    recipe:AddTrainer(153811, 154393)

    -- Greater Flask of the Vast Horizon -- 298852
    recipe = AddRecipe(298852, V.BFA, Q.EPIC)
    recipe:SetSkillLevels(155, 155, 175, 175, 175)
    recipe:SetRecipeItem(169502, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(168653, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_FLASK")
    recipe:AddQuest(56769, 56773)

    -- Greater Flask of the Undertow -- 298853
    recipe = AddRecipe(298853, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(155, 155, 165, 170, 175)
    recipe:SetCraftedItem(168654, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_FLASK")
    recipe:AddTrainer(153811, 154393)

    -- Greater Flask of the Undertow -- 298854
    recipe = AddRecipe(298854, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(170, 170, 180, 185, 190)
    recipe:SetCraftedItem(168654, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_FLASK")
    recipe:AddTrainer(153811, 154393)

    -- Greater Flask of the Undertow -- 298855
    recipe = AddRecipe(298855, V.BFA, Q.EPIC)
    recipe:SetSkillLevels(155, 155, 175, 175, 175)
    recipe:SetRecipeItem(169503, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(168654, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_FLASK")
    recipe:AddQuest(56768, 56774)

    -- Greater Mystical Cauldron -- 298862
    recipe = AddRecipe(298862, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(165, 165, 175, 180, 185)
    recipe:SetRecipeItem(169504, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(168656, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_CAULDRON")
    recipe:AddTrainer(153811, 154393)

    -- Greater Mystical Cauldron -- 298863
    recipe = AddRecipe(298863, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(175, 175, 185, 190, 195)
    recipe:SetRecipeItem(169504, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(168656, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_CAULDRON")
    recipe:AddTrainer(153811, 154393)

    -- Greater Mystical Cauldron -- 298864
    recipe = AddRecipe(298864, V.BFA, Q.EPIC)
    recipe:SetSkillLevels(155, 155, 175, 175, 175)
    recipe:SetRecipeItem(169504, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_CAULDRON")
    recipe:AddRepVendor(FAC.ANKOAN, REP.EXALTED, 154140)
    recipe:AddRepVendor(FAC.THE_UNSHACKLED, REP.EXALTED, 153512)

    -- Abyssal Alchemist Stone -- 298995
    recipe = AddRecipe(298995, V.BFA, Q.EPIC)
    recipe:SetSkillLevels(165, 165, 175, 180, 185)
    recipe:SetCraftedItem(168674, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRINKET")
    recipe:AddTrainer(153811, 154393)

    -- Crushing Alchemist Stone -- 298996
    recipe = AddRecipe(298996, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(165, 165, 180, 185, 190)
    recipe:SetRecipeItem(168757, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(168675, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ALCHEMY_TRINKET")
    recipe:AddDiscovery("DISCOVERY_ALCH_BFA")

    -- Ascended Alchemist Stone -- 298997
    recipe = AddRecipe(298997, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(165, 165, 180, 185, 190)
    recipe:SetRecipeItem(168758, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(168676, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ALCHEMY_TRINKET")
    recipe:AddDiscovery("DISCOVERY_ALCH_BFA")

    -- Potion of Unbridled Fury -- 300749
    recipe = AddRecipe(300749, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(145, 145, 155, 160, 165)
    recipe:SetCraftedItem(169299, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(153811, 154393)

    -- Potion of Unbridled Fury -- 300750
    recipe = AddRecipe(300750, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(160, 160, 170, 175, 180)
    recipe:SetCraftedItem(169299, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(153811, 154393)

    -- Potion of Unbridled Fury -- 300751
    recipe = AddRecipe(300751, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(140, 140, 175, 175, 175)
    recipe:SetRecipeItem(170208, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(169299, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddWorldDrop(Z.OPERATION_MECHAGON)

    -- Potion of Wild Mending -- 300752
    recipe = AddRecipe(300752, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(145, 145, 155, 160, 165)
    recipe:SetCraftedItem(169300, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(153811, 154393)

    -- Potion of Wild Mending -- 300753
    recipe = AddRecipe(300753, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(160, 160, 170, 175, 180)
    recipe:SetCraftedItem(169300, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(153811, 154393)

    -- Potion of Wild Mending -- 300754
    recipe = AddRecipe(300754, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(140, 140, 175, 175, 175)
    recipe:SetRecipeItem(170209, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(169300, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddWorldDrop(Z.OPERATION_MECHAGON)

    -- Abyssal Healing Potion -- 301310
    recipe = AddRecipe(301310, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(145, 145, 155, 160, 165)
    recipe:SetCraftedItem(169451, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(153811, 154393)

    -- Abyssal Healing Potion -- 301311
    recipe = AddRecipe(301311, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(160, 160, 170, 175, 180)
    recipe:SetCraftedItem(169451, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(153811, 154393)

    -- Abyssal Healing Potion -- 301312
    recipe = AddRecipe(301312, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(145, 145, 175, 175, 175)
    recipe:SetRecipeItem(170210, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(169451, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddWorldDrop(Z.OPERATION_MECHAGON)

    -- Peerless Alchemist Stone -- 305992
    recipe = AddRecipe(305992, V.BFA, Q.EPIC)
    recipe:SetSkillLevels(165, 165, 180, 185, 190)
    recipe:SetRecipeItem(171084, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(171085, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ALCHEMY_TRINKET")
    recipe:AddDiscovery("DISCOVERY_ALCH_BFA")

    -- Awakened Alchemist Stone -- 305993
    recipe = AddRecipe(305993, V.BFA, Q.EPIC)
    recipe:SetSkillLevels(165, 165, 180, 185, 190)
    recipe:SetRecipeItem(171086, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(171087, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ALCHEMY_TRINKET")
    recipe:AddDiscovery("DISCOVERY_ALCH_BFA")

    -- Unbound Alchemist Stone -- 305994
    recipe = AddRecipe(305994, V.BFA, Q.RARE)
    recipe:SetSkillLevels(165, 165, 180, 185, 190)
    recipe:SetRecipeItem(171318, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(171088, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ALCHEMY_TRINKET")
    recipe:AddMobDrop(153910, 162245)

    -- Void Focus -- 307172
    recipe = AddRecipe(307172, V.BFA, Q.COMMON)
    recipe:SetSkillLevels(175, 175, 200, 200, 200)
    recipe:SetRecipeItem(171312, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(171320, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ALCHEMY_MISC")
    recipe:AddMobDrop(153910, 162245)

    -- ----------------------------------------------------------------------------
    -- Shadowlands.
    -- ----------------------------------------------------------------------------
    -- Potion of Specter Swiftness -- 256133
    recipe = AddRecipe(256133, V.SHA, Q.COMMON)
    recipe:SetSkillLevels(60, 60, 70, 75, 80)
    recipe:SetCraftedItem(171370, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(156687)

    -- Potion of Soul Purity -- 256134
    recipe = AddRecipe(256134, V.SHA, Q.COMMON)
    recipe:SetSkillLevels(50, 50, 60, 65, 70)
    recipe:SetCraftedItem(171263, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(156687)

    -- Spiritual Rejuvenation Potion -- 261423
    recipe = AddRecipe(261423, V.SHA, Q.COMMON)
    recipe:SetSkillLevels(5, 5, 15, 20, 25)
    recipe:SetCraftedItem(171269, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(156687)

    -- Potion of the Hidden Spirit -- 261424
    recipe = AddRecipe(261424, V.SHA, Q.COMMON)
    recipe:SetSkillLevels(30, 30, 40, 45, 50)
    recipe:SetCraftedItem(171266, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(156687)

    -- Potion of Shaded Sight -- 295084
    recipe = AddRecipe(295084, V.SHA, Q.COMMON)
    recipe:SetSkillLevels(45, 45, 55, 60, 65)
    recipe:SetCraftedItem(171264, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(156687)

    -- Spiritual Healing Potion -- 301578
    recipe = AddRecipe(301578, V.SHA, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 10, 15, 20)
    recipe:SetCraftedItem(171267, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddCustom("DEFAULT_RECIPE")

    -- Spiritual Mana Potion -- 301683
    recipe = AddRecipe(301683, V.SHA, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 10, 15, 20)
    recipe:SetCraftedItem(171268, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddCustom("DEFAULT_RECIPE")

    -- Eternal Cauldron -- 307087
    recipe = AddRecipe(307087, V.SHA, Q.EPIC)
    recipe:SetSkillLevels(175, 175, 185, 190, 195)
    recipe:SetRecipeItem(183106, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(171284, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_CAULDRON")
    recipe:AddRepVendor(FAC.THE_WILD_HUNT, REP.REVERED, 158556, 176065)

    -- Potion of Spectral Agility -- 307093
    recipe = AddRecipe(307093, V.SHA, Q.COMMON)
    recipe:SetSkillLevels(150, 150, 160, 165, 170)
    recipe:SetCraftedItem(171270, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(156687)

    -- Potion of Hardened Shadows -- 307094
    recipe = AddRecipe(307094, V.SHA, Q.COMMON)
    recipe:SetSkillLevels(100, 100, 110, 115, 120)
    recipe:SetCraftedItem(171271, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(156687)

    -- Potion of Spiritual Clarity -- 307095
    recipe = AddRecipe(307095, V.SHA, Q.COMMON)
    recipe:SetSkillLevels(100, 100, 110, 115, 120)
    recipe:SetCraftedItem(171272, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(156687)

    -- Potion of Spectral Intellect -- 307096
    recipe = AddRecipe(307096, V.SHA, Q.COMMON)
    recipe:SetSkillLevels(150, 150, 160, 165, 170)
    recipe:SetCraftedItem(171273, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(156687)

    -- Potion of Spectral Stamina -- 307097
    recipe = AddRecipe(307097, V.SHA, Q.COMMON)
    recipe:SetSkillLevels(150, 150, 160, 165, 170)
    recipe:SetCraftedItem(171274, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(156687)

    -- Potion of Spectral Strength -- 307098
    recipe = AddRecipe(307098, V.SHA, Q.COMMON)
    recipe:SetSkillLevels(150, 150, 160, 165, 170)
    recipe:SetCraftedItem(171275, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(156687)

    -- Spiritual Anti-Venom -- 307100
    recipe = AddRecipe(307100, V.SHA, Q.COMMON)
    recipe:SetSkillLevels(5, 5, 15, 20, 25)
    recipe:SetCraftedItem(171301, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_MISC")
    recipe:AddTrainer(156687)

    -- Spectral Flask of Power -- 307101
    recipe = AddRecipe(307101, V.SHA, Q.COMMON)
    recipe:SetSkillLevels(160, 160, 170, 175, 180)
    recipe:SetCraftedItem(171276, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_FLASK")
    recipe:AddTrainer(156687)

    -- Spectral Flask of Stamina -- 307103
    recipe = AddRecipe(307103, V.SHA, Q.COMMON)
    recipe:SetSkillLevels(160, 160, 170, 175, 180)
    recipe:SetCraftedItem(171278, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_FLASK")
    recipe:AddTrainer(156687)

    -- Shadowcore Oil -- 307118
    recipe = AddRecipe(307118, V.SHA, Q.COMMON)
    recipe:SetSkillLevels(10, 10, 20, 25, 30)
    recipe:SetCraftedItem(171285, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_OIL")
    recipe:AddTrainer(156687)

    -- Embalmer's Oil -- 307119
    recipe = AddRecipe(307119, V.SHA, Q.COMMON)
    recipe:SetSkillLevels(10, 10, 20, 25, 30)
    recipe:SetCraftedItem(171286, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_OIL")
    recipe:AddTrainer(156687)

    -- Ground Death Blossom -- 307120
    recipe = AddRecipe(307120, V.SHA, Q.COMMON)
    recipe:SetSkillLevels(15, 15, 25, 30, 35)
    recipe:SetCraftedItem(171287, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_MISC")
    recipe:AddTrainer(156687)

    -- Ground Vigil's Torch -- 307121
    recipe = AddRecipe(307121, V.SHA, Q.COMMON)
    recipe:SetSkillLevels(80, 80, 90, 95, 100)
    recipe:SetCraftedItem(171288, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_MISC")
    recipe:AddTrainer(156687)

    -- Ground Widowbloom -- 307122
    recipe = AddRecipe(307122, V.SHA, Q.COMMON)
    recipe:SetSkillLevels(105, 105, 115, 120, 125)
    recipe:SetCraftedItem(171289, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_MISC")
    recipe:AddTrainer(156687)

    -- Ground Marrowroot -- 307123
    recipe = AddRecipe(307123, V.SHA, Q.COMMON)
    recipe:SetSkillLevels(45, 45, 55, 60, 65)
    recipe:SetCraftedItem(171290, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_MISC")
    recipe:AddTrainer(156687)

    -- Ground Rising Glory -- 307124
    recipe = AddRecipe(307124, V.SHA, Q.COMMON)
    recipe:SetSkillLevels(20, 20, 30, 35, 40)
    recipe:SetCraftedItem(171291, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_MISC")
    recipe:AddTrainer(156687)

    -- Ground Nightshade -- 307125
    recipe = AddRecipe(307125, V.SHA, Q.COMMON)
    recipe:SetSkillLevels(75, 75, 85, 90, 95)
    recipe:SetCraftedItem(171292, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_MISC")
    recipe:AddTrainer(156687)

    -- Shadowghast Ingot -- 307142
    recipe = AddRecipe(307142, V.SHA, Q.COMMON)
    recipe:SetSkillLevels(165, 165, 175, 180, 185)
    recipe:SetCraftedItem(171428, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_MISC")
    recipe:AddTrainer(156687)

    -- Shadestone -- 307143
    recipe = AddRecipe(307143, V.SHA, Q.UNCOMMON)
    recipe:SetSkillLevels(170, 170, 180, 185, 190)
    recipe:SetRecipeItem(182660, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(180457, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_MISC")
    recipe:AddRepVendor(FAC.THE_AVOWED, REP.HONORED, 173705, 176368)

    -- Stones to Ore -- 307144
    recipe = AddRecipe(307144, V.SHA, Q.COMMON)
    recipe:SetSkillLevels(170, 170, 180, 185, 190)
    recipe:SetRecipeItem(186991, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(186694, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ALCHEMY_TRANSMUTE")
    recipe:AddRepVendor(FAC.THE_ARCHIVISTS_CODEX, REP.REVERED, 178257)

    -- Spiritual Alchemy Stone -- 307200
    recipe = AddRecipe(307200, V.SHA, Q.COMMON)
    recipe:SetSkillLevels(170, 170, 180, 185, 190)
    recipe:SetCraftedItem(171323, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_TRINKET")
    recipe:AddTrainer(156687)

    -- Potion of Empowered Exorcisms -- 307381
    recipe = AddRecipe(307381, V.SHA, Q.COMMON)
    recipe:SetSkillLevels(135, 135, 145, 150, 155)
    recipe:SetCraftedItem(171352, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(156687)

    -- Potion of Phantom Fire -- 307382
    recipe = AddRecipe(307382, V.SHA, Q.COMMON)
    recipe:SetSkillLevels(125, 125, 135, 140, 145)
    recipe:SetCraftedItem(171349, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(156687)

    -- Potion of Divine Awakening -- 307383
    recipe = AddRecipe(307383, V.SHA, Q.COMMON)
    recipe:SetSkillLevels(125, 125, 135, 140, 145)
    recipe:SetCraftedItem(171350, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(156687)

    -- Potion of Deathly Fixation -- 307384
    recipe = AddRecipe(307384, V.SHA, Q.COMMON)
    recipe:SetSkillLevels(135, 135, 145, 150, 155)
    recipe:SetCraftedItem(171351, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(156687)

    -- Potion of Sacrificial Anima -- 322301
    recipe = AddRecipe(322301, V.SHA, Q.COMMON)
    recipe:SetSkillLevels(110, 110, 120, 125, 130)
    recipe:SetCraftedItem(176811, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(156687)

    -- Red Noggin Candle -- 334413
    recipe = AddRecipe(334413, V.SHA, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 10, 15, 20)
    recipe:SetRecipeItem(180780, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(180751, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")

    -- Potion of Unhindered Passing -- 342887
    recipe = AddRecipe(342887, V.SHA, Q.COMMON)
    recipe:SetSkillLevels(50, 50, 60, 65, 70)
    recipe:SetCraftedItem(183823, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(156687)

    -- Novice Crafter's Mark -- 343675
    recipe = AddRecipe(343675, V.SHA, Q.COMMON)
    recipe:SetSkillLevels(150, 150, 135, 140, 145)
    recipe:SetCraftedItem(183942, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_MISC")
    recipe:AddTrainer(156687)

    -- Crafter's Mark of the Chained Isle -- 343676
    recipe = AddRecipe(343676, V.SHA, Q.RARE)
    recipe:SetSkillLevels(200, 200, 200, 200, 200)
    recipe:SetCraftedItem(173384, "BIND_ON_PICKUP")
    recipe:SetRecipeItem(186470, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ALCHEMY_MISC")
    recipe:AddRepVendor(FAC.THE_ARCHIVISTS_CODEX, REP.REVERED, 178257)

    -- Crafter's Mark III -- 343677
    recipe = AddRecipe(343677, V.SHA, Q.COMMON)
    recipe:SetSkillLevels(100, 100, 190, 192, 195)
    recipe:SetCraftedItem(173383, "BIND_ON_PICKUP")
    recipe:SetRecipeItem(183868, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ALCHEMY_MISC")
    recipe:AddRepVendor(FAC.DEATHS_ADVANCE, REP.HONORED, 179321)

    -- Crafter's Mark II -- 343678
    recipe = AddRecipe(343678, V.SHA, Q.COMMON)
    recipe:SetSkillLevels(0, 0, 0, 0, 0)
    recipe:SetRecipeItem(183870, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(173382, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ALCHEMY_MISC")
    recipe:AddRepVendor(FAC.THE_AVOWED, REP.REVERED, 173705)

    -- Crafter's Mark I -- 343679
    recipe = AddRecipe(343679, V.SHA, Q.COMMON)
    recipe:SetSkillLevels(125, 125, 160, 165, 170)
    recipe:SetCraftedItem(173381, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_MISC")
    recipe:AddTrainer(156687)

    -- Potion of the Psychopomp's Speed -- 344316
    recipe = AddRecipe(344316, V.SHA, Q.COMMON)
    recipe:SetSkillLevels(90, 90, 100, 105, 110)
    recipe:SetCraftedItem(184090, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(156687)

    -- Marrow Burst -- 354880
    recipe = AddRecipe(354880, V.SHA, Q.COMMON)
    recipe:SetSkillLevels(95, 95, 100, 112, 125)
    recipe:SetRecipeItem(186989, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(186700, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_MISC")
    recipe:AddCustom("INVASIVE_MAWSHROOM")

    -- Glory Burst -- 354881
    recipe = AddRecipe(354881, V.SHA, Q.COMMON)
    recipe:SetSkillLevels(95, 95, 100, 112, 125)
    recipe:SetRecipeItem(186988, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(186701, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_MISC")
    recipe:AddCustom("INVASIVE_MAWSHROOM")

    -- Widow Burst -- 354882
    recipe = AddRecipe(354882, V.SHA, Q.COMMON)
    recipe:SetSkillLevels(95, 95, 100, 112, 125)
    recipe:SetRecipeItem(186986, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(186699, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_MISC")
    recipe:AddCustom("INVASIVE_MAWSHROOM")

    -- Torch Burst -- 354884
    recipe = AddRecipe(354884, V.SHA, Q.COMMON)
    recipe:SetSkillLevels(95, 95, 100, 112, 125)
    recipe:SetRecipeItem(186987, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(186698, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_MISC")
    recipe:AddCustom("INVASIVE_MAWSHROOM")

    -- Blossom Burst -- 354885
    recipe = AddRecipe(354885, V.SHA, Q.COMMON)
    recipe:SetSkillLevels(95, 95, 100, 112, 125)
    recipe:SetRecipeItem(186697, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(186990, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_MISC")
    recipe:AddCustom("INVASIVE_MAWSHROOM")

    -- 9.2 Recipes

    -- Crafter's Mark IV -- 359666
    recipe = AddRecipe(359666, V.SHA, Q.EPIC)
    recipe:SetSkillLevels(201, 201, 201, 201, 201)
    recipe:SetRecipeItem(187750, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(187741, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ALCHEMY_MISC")
    recipe:AddRepVendor(FAC.THE_ENLIGHTENED, REP.HONORED, 182257)

    -- Crafter's Mark of the First Ones -- 359673
    recipe = AddRecipe(359673, V.SHA, Q.EPIC)
    recipe:SetSkillLevels(201, 201, 201, 201, 201)
    recipe:SetRecipeItem(187749, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(187742, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ALCHEMY_MISC")
    recipe:AddRepVendor(FAC.THE_ENLIGHTENED, REP.HONORED, 182257)

    -- Cosmic Healing Potion -- 359870
    recipe = AddRecipe(359870, V.SHA, Q.COMMON)
    recipe:SetSkillLevels(160, 160, 170, 175, 180)
    recipe:SetCraftedItem(187802, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_POTION")
    recipe:AddTrainer(156687)

    -- Infusion: Corpse Purification -- 360014
    recipe = AddRecipe(360014, V.SHA, Q.COMMON)
    recipe:SetSkillLevels(100, 100, 100, 110, 120)
    recipe:SetRecipeItem(187828, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(187827, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_MISC")
    recipe:AddMobDrop(183737)

    -- Sustaining Armor Polish -- 360318
    recipe = AddRecipe(360318, V.SHA, Q.COMMON)
    recipe:SetSkillLevels(100, 100, 100, 110, 120)
    recipe:SetRecipeItem(187848, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(187850, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ALCHEMY_MISC")
    recipe:AddMobDrop(178229, 183764)

    self.InitializeRecipes = nil
end
