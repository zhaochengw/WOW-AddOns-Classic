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

    -------------------------------------------------------------------------------
    -- Classic.
    -------------------------------------------------------------------------------
    -- Enchant Bracer - Minor Health -- 7418
    recipe = AddRecipe(7418, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 70, 90, 110)
    recipe:SetItemFilterType("ENCHANTING_BRACER")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MISC1)
    recipe:AddCustom("DEFAULT_RECIPE")

    -- Enchant Chest - Minor Health -- 7420
    recipe = AddRecipe(7420, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(15, 15, 70, 90, 110)
    recipe:SetItemFilterType("ENCHANTING_CHEST")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 7949, 11072, 11073, 11074, 16160, 16633, 16725,
        18753, 18773, 19251, 19252, 19540, 26906, 26990, 28693, 33583, 33610, 33633, 33676, 47384, 47396, 47400, 47418,
        47419, 47420, 47431, 48619, 53410, 57620, 65043, 65127)

    -- Runed Copper Rod -- 7421
    recipe = AddRecipe(7421, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 5, 7, 10)
    recipe:SetCraftedItem(6218, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENCHANTING_ROD")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MISC1)
    recipe:AddCustom("DEFAULT_RECIPE")

    -- Enchant Chest - Minor Absorption -- 7426
    recipe = AddRecipe(7426, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(40, 40, 90, 110, 130)
    recipe:SetItemFilterType("ENCHANTING_CHEST")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 7949, 11072, 11073, 11074, 16160, 16633, 16725,
        18753, 18773, 19251, 19252, 19540, 26906, 26990, 28693, 33583, 33610, 33633, 33676, 47384, 47396, 47400, 47418,
        47419, 47420, 47431, 48619, 53410, 57620, 65043, 65127)

    -- Enchant Bracer - Minor Dodge -- 7428
    recipe = AddRecipe(7428, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 80, 100, 120)
    recipe:SetItemFilterType("ENCHANTING_BRACER")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MISC1, F.TANK)
    recipe:AddCustom("DEFAULT_RECIPE")

    -- Enchant Chest - Minor Mana -- 7443
    recipe = AddRecipe(7443, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(20, 20, 80, 100, 120)
    recipe:SetRecipeItem(6342, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENCHANTING_CHEST")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

    -- Enchant Bracer - Minor Stamina -- 7457
    recipe = AddRecipe(7457, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(50, 50, 100, 120, 140)
    recipe:SetItemFilterType("ENCHANTING_BRACER")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 7949, 11072, 11073, 11074, 16160, 16633, 16725,
        18753, 18773, 19251, 19252, 19540, 26906, 26990, 28693, 33583, 33610, 33633, 33676, 47384, 47396, 47400, 47418,
        47419, 47420, 47431, 48619, 53410, 57620, 65043, 65127)

    -- Enchant 2H Weapon - Minor Impact -- 7745
    recipe = AddRecipe(7745, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(100, 100, 130, 150, 170)
    recipe:SetItemFilterType("ENCHANTING_2H_WEAPON")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 7949, 11072, 11073, 11074, 16160, 16633, 16725,
        18753, 18773, 19251, 19252, 19540, 26906, 26990, 28693, 33583, 33610, 33633, 33676, 53410, 65127)

    -- Enchant Chest - Lesser Health -- 7748
    recipe = AddRecipe(7748, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(60, 60, 105, 125, 145)
    recipe:SetItemFilterType("ENCHANTING_CHEST")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 7949, 11072, 11073, 11074, 16160, 16633, 16725,
        18753, 18773, 19251, 19252, 19540, 26906, 26990, 28693, 33583, 33610, 33633, 33676, 47384, 47396, 47400, 47418,
        47419, 47420, 47431, 48619, 53410, 57620, 65043, 65127)

    -- Enchant Bracer - Minor Spirit -- 7766
    recipe = AddRecipe(7766, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(60, 60, 105, 125, 145)
    recipe:SetRecipeItem(6344, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENCHANTING_BRACER")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

    -- Enchant Cloak - Minor Protection -- 7771
    recipe = AddRecipe(7771, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(70, 70, 110, 130, 150)
    recipe:SetItemFilterType("ENCHANTING_CLOAK")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 7949, 11072, 11073, 11074, 16160, 16633, 16725,
        18753, 18773, 19251, 19252, 19540, 26906, 26990, 28693, 33583, 33610, 33633, 33676, 47384, 47396, 47400, 47418,
        47419, 47420, 47431, 48619, 53410, 57620, 65043, 65127)

    -- Enchant Chest - Lesser Mana -- 7776
    recipe = AddRecipe(7776, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(80, 80, 115, 135, 155)
    recipe:SetRecipeItem(6346, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENCHANTING_CHEST")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddVendor(5757)
    recipe:AddLimitedVendor(3346, 1)

    -- Enchant Bracer - Minor Agility -- 7779
    recipe = AddRecipe(7779, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(80, 80, 115, 135, 155)
    recipe:SetItemFilterType("ENCHANTING_BRACER")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 7949, 11072, 11073, 11074, 16160, 16633, 16725,
        18753, 18773, 19251, 19252, 19540, 26906, 26990, 28693, 33583, 33610, 33633, 33676, 53410, 65127)

    -- Enchant Bracer - Minor Strength -- 7782
    recipe = AddRecipe(7782, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(80, 80, 115, 135, 155)
    recipe:SetRecipeItem(6347, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENCHANTING_BRACER")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
    recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

    -- Enchant Weapon - Minor Beastslayer -- 7786
    recipe = AddRecipe(7786, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(90, 90, 120, 140, 160)
    recipe:SetRecipeItem(6348, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENCHANTING_WEAPON")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

    -- Enchant Weapon - Minor Striking -- 7788
    recipe = AddRecipe(7788, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(90, 90, 120, 140, 160)
    recipe:SetItemFilterType("ENCHANTING_WEAPON")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 7949, 11072, 11073, 11074, 16160, 16633, 16725,
        18753, 18773, 19251, 19252, 19540, 26906, 26990, 28693, 33583, 33610, 33633, 33676, 53410, 65127)

    -- Enchant 2H Weapon - Lesser Intellect -- 7793
    recipe = AddRecipe(7793, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(100, 100, 130, 150, 170)
    recipe:SetRecipeItem(6349, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENCHANTING_2H_WEAPON")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddVendor(5758)
    recipe:AddLimitedVendor(3012, 1, 3346, 1, 5158, 1)

    -- Enchant Chest - Health -- 7857
    recipe = AddRecipe(7857, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(120, 120, 145, 165, 185)
    recipe:SetItemFilterType("ENCHANTING_CHEST")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 7949, 11072, 11073, 11074, 16160, 16633, 16725,
        18753, 18773, 19251, 19252, 19540, 26906, 26990, 28693, 33583, 33610, 33633, 33676, 53410, 65127)

    -- Enchant Bracer - Lesser Spirit -- 7859
    recipe = AddRecipe(7859, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(120, 120, 145, 165, 185)
    recipe:SetRecipeItem(6375, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENCHANTING_BRACER")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

    -- Enchant Boots - Minor Stamina -- 7863
    recipe = AddRecipe(7863, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(125, 125, 150, 170, 190)
    recipe:SetItemFilterType("ENCHANTING_BOOTS")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 7949, 11072, 11073, 11074, 16160, 16633, 16725,
        18753, 18773, 19251, 19252, 19540, 26906, 26990, 28693, 33583, 33610, 33633, 33676, 53410, 65127)

    -- Enchant Boots - Minor Agility -- 7867
    recipe = AddRecipe(7867, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(125, 125, 150, 170, 190)
    recipe:SetRecipeItem(6377, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENCHANTING_BOOTS")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
    recipe:AddLimitedVendor(3012, 1, 3537, 1)

    -- Enchant Shield - Minor Stamina -- 13378
    recipe = AddRecipe(13378, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(105, 105, 130, 150, 170)
    recipe:SetItemFilterType("ENCHANTING_SHIELD")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 7949, 11072, 11073, 11074, 16160, 16633, 16725,
        18753, 18773, 19251, 19252, 19540, 26906, 26990, 28693, 33583, 33610, 33633, 33676, 53410, 65127)

    -- Enchant 2H Weapon - Lesser Spirit -- 13380
    recipe = AddRecipe(13380, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(110, 110, 135, 155, 175)
    recipe:SetRecipeItem(11038, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENCHANTING_2H_WEAPON")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

    -- Enchant Cloak - Minor Agility -- 13419
    recipe = AddRecipe(13419, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(110, 110, 135, 155, 175)
    recipe:SetRecipeItem(11039, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENCHANTING_CLOAK")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
    recipe:AddVendor(3954, 12043)
    recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

    -- Enchant Cloak - Lesser Protection -- 13421
    recipe = AddRecipe(13421, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(115, 115, 140, 160, 180)
    recipe:SetItemFilterType("ENCHANTING_CLOAK")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 7949, 11072, 11073, 11074, 16160, 16633, 16725,
        18753, 18773, 19251, 19252, 19540, 26906, 26990, 28693, 33583, 33610, 33633, 33676, 53410, 65127)

    -- Enchant Shield - Lesser Protection -- 13464
    recipe = AddRecipe(13464, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(115, 115, 140, 160, 180)
    recipe:SetRecipeItem(11081, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENCHANTING_SHIELD")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.TANK)
    recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

    -- Enchant Shield - Lesser Spirit -- 13485
    recipe = AddRecipe(13485, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(130, 130, 155, 175, 195)
    recipe:SetItemFilterType("ENCHANTING_SHIELD")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 7949, 11072, 11073, 11074, 16160, 16633, 16725,
        18753, 18773, 19251, 19252, 19540, 26906, 26990, 28693, 33583, 33610, 33633, 33676, 53410, 65127)

    -- Enchant Bracer - Lesser Stamina -- 13501
    recipe = AddRecipe(13501, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(130, 130, 155, 175, 195)
    recipe:SetItemFilterType("ENCHANTING_BRACER")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 7949, 11072, 11073, 11074, 16160, 16633, 16725,
        18753, 18773, 19251, 19252, 19540, 26906, 26990, 28693, 33583, 33610, 33633, 33676, 53410, 65127)

    -- Enchant Weapon - Lesser Striking -- 13503
    recipe = AddRecipe(13503, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(140, 140, 165, 185, 205)
    recipe:SetItemFilterType("ENCHANTING_WEAPON")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 7949, 11072, 11073, 11074, 16160, 16633, 16725,
        18753, 18773, 19251, 19252, 19540, 26906, 26990, 28693, 33583, 33610, 33633, 33676, 53410, 65127)

    -- Enchant 2H Weapon - Lesser Impact -- 13529
    recipe = AddRecipe(13529, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(145, 145, 170, 190, 210)
    recipe:SetItemFilterType("ENCHANTING_2H_WEAPON")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 7949, 11072, 11073, 11074, 16160, 16633, 16725,
        18753, 18773, 19251, 19252, 19540, 26906, 26990, 28693, 33583, 33610, 33633, 33676, 53410, 65127)

    -- Enchant Bracer - Lesser Strength -- 13536
    recipe = AddRecipe(13536, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(140, 140, 165, 185, 205)
    recipe:SetRecipeItem(11101, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENCHANTING_BRACER")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
    recipe:AddVendor(3954, 12043)

    -- Enchant Chest - Lesser Absorption -- 13538
    recipe = AddRecipe(13538, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(140, 140, 165, 185, 205)
    recipe:SetItemFilterType("ENCHANTING_CHEST")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 7949, 11072, 11073, 11074, 16160, 16633, 16725,
        18753, 18773, 19251, 19252, 19540, 26906, 26990, 28693, 33583, 33610, 33633, 33676, 53410, 65127)

    -- Enchant Chest - Mana -- 13607
    recipe = AddRecipe(13607, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(145, 145, 170, 190, 210)
    recipe:SetItemFilterType("ENCHANTING_CHEST")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 7949, 11072, 11073, 11074, 16160, 16633, 16725,
        18753, 18773, 19251, 19252, 19540, 26906, 26990, 28693, 33583, 33610, 33633, 33676, 53410, 65127)

    -- Enchant Gloves - Mining -- 13612
    recipe = AddRecipe(13612, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(145, 145, 170, 190, 210)
    recipe:SetRecipeItem(11150, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENCHANTING_GLOVES")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:Retire()

    -- Enchant Gloves - Herbalism -- 13617
    recipe = AddRecipe(13617, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(145, 145, 170, 190, 210)
    recipe:SetRecipeItem(78343, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENCHANTING_GLOVES")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddWorldDrop(Z.ASHENVALE)

    -- Enchant Gloves - Fishing -- 13620
    recipe = AddRecipe(13620, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(145, 145, 170, 190, 210)
    recipe:SetRecipeItem(11152, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENCHANTING_GLOVES")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddMobDrop(2374, 2375, 2376, 2377, 14276)

    -- Enchant Bracer - Lesser Intellect -- 13622
    recipe = AddRecipe(13622, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(150, 150, 175, 195, 215)
    recipe:SetItemFilterType("ENCHANTING_BRACER")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 7949, 11072, 11073, 11074, 16160, 16633, 16725,
        18753, 18773, 19251, 19252, 19540, 26906, 26990, 28693, 33583, 33610, 33633, 33676, 53410, 65127)

    -- Enchant Chest - Minor Stats -- 13626
    recipe = AddRecipe(13626, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(150, 150, 175, 195, 215)
    recipe:SetItemFilterType("ENCHANTING_CHEST")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 7949, 11072, 11073, 11074, 16160, 16633, 16725,
        18753, 18773, 19251, 19252, 19540, 26906, 26990, 28693, 33583, 33610, 33633, 33676, 53410, 65127)

    -- Enchant Shield - Lesser Stamina -- 13631
    recipe = AddRecipe(13631, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(155, 155, 175, 195, 215)
    recipe:SetItemFilterType("ENCHANTING_SHIELD")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 7949, 11072, 11073, 11074, 16160, 16633, 16725,
        18753, 18773, 19251, 19252, 19540, 26906, 26990, 28693, 33583, 33610, 33633, 33676, 53410, 65127)

    -- Enchant Cloak - Defense -- 13635
    recipe = AddRecipe(13635, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(155, 155, 175, 195, 215)
    recipe:SetItemFilterType("ENCHANTING_CLOAK")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.TANK)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 7949, 11072, 11073, 11074, 16160, 16633, 16725,
        18753, 18773, 19251, 19252, 19540, 26906, 26990, 28693, 33583, 33610, 33633, 33676, 53410, 65127)

    -- Enchant Boots - Lesser Agility -- 13637
    recipe = AddRecipe(13637, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(160, 160, 180, 200, 220)
    recipe:SetItemFilterType("ENCHANTING_BOOTS")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 7949, 11072, 11073, 11074, 16160, 16633, 16725,
        18753, 18773, 19251, 19252, 19540, 26906, 26990, 28693, 33583, 33610, 33633, 33676, 53410, 65127)

    -- Enchant Chest - Greater Health -- 13640
    recipe = AddRecipe(13640, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(160, 160, 180, 200, 220)
    recipe:SetItemFilterType("ENCHANTING_CHEST")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 7949, 11072, 11073, 11074, 16160, 16633, 16725,
        18753, 18773, 19251, 19252, 19540, 26906, 26990, 28693, 33583, 33610, 33633, 33676, 53410, 65127)

    -- Enchant Bracer - Spirit -- 13642
    recipe = AddRecipe(13642, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(165, 165, 185, 205, 225)
    recipe:SetItemFilterType("ENCHANTING_BRACER")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 7949, 11072, 11073, 11074, 16160, 16633, 16725,
        18753, 18773, 19251, 19252, 19540, 26906, 26990, 28693, 33583, 33610, 33633, 33676, 53410, 65127)

    -- Enchant Boots - Lesser Stamina -- 13644
    recipe = AddRecipe(13644, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(170, 170, 190, 210, 230)
    recipe:SetItemFilterType("ENCHANTING_BOOTS")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 7949, 11072, 11073, 11074, 16160, 16633, 16725,
        18753, 18773, 19251, 19252, 19540, 26906, 26990, 28693, 33583, 33610, 33633, 33676, 53410, 65127)

    -- Enchant Bracer - Lesser Dodge -- 13646
    recipe = AddRecipe(13646, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(170, 170, 190, 210, 230)
    recipe:SetItemFilterType("ENCHANTING_BRACER")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.TANK)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 5157, 5695, 16725, 18773, 26906, 26990, 28693, 33583, 33610, 53410,
        65127)

    -- Enchant Bracer - Stamina -- 13648
    recipe = AddRecipe(13648, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(170, 170, 190, 210, 230)
    recipe:SetItemFilterType("ENCHANTING_BRACER")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 7949, 11072, 11073, 11074, 16160, 16633, 16725,
        18753, 18773, 19251, 19252, 19540, 26906, 26990, 28693, 33583, 33610, 33633, 33676, 53410, 65127)

    -- Enchant Weapon - Lesser Beastslayer -- 13653
    recipe = AddRecipe(13653, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(175, 175, 195, 215, 235)
    recipe:SetRecipeItem(11164, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENCHANTING_WEAPON")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

    -- Enchant Weapon - Lesser Elemental Slayer -- 13655
    recipe = AddRecipe(13655, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(175, 175, 195, 215, 235)
    recipe:SetRecipeItem(11165, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENCHANTING_WEAPON")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

    -- Enchant Shield - Spirit -- 13659
    recipe = AddRecipe(13659, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(180, 180, 200, 220, 240)
    recipe:SetItemFilterType("ENCHANTING_SHIELD")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 7949, 11072, 11073, 11074, 16160, 16633, 16725,
        18753, 18773, 19251, 19252, 19540, 26906, 26990, 28693, 33583, 33610, 33633, 33676, 53410, 65127)

    -- Enchant Bracer - Strength -- 13661
    recipe = AddRecipe(13661, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(180, 180, 200, 220, 240)
    recipe:SetItemFilterType("ENCHANTING_BRACER")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 7949, 11072, 11073, 11074, 16160, 16633, 16725,
        18753, 18773, 19251, 19252, 19540, 26906, 26990, 28693, 33583, 33610, 33633, 33676, 53410, 65127)

    -- Enchant Chest - Greater Mana -- 13663
    recipe = AddRecipe(13663, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(185, 185, 205, 225, 245)
    recipe:SetItemFilterType("ENCHANTING_CHEST")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 7949, 11072, 11073, 11074, 16160, 16633, 16725,
        18753, 18773, 19251, 19252, 19540, 26906, 26990, 28693, 33583, 33610, 33633, 33676, 53410, 65127)

    -- Enchant Boots - Lesser Spirit -- 13687
    recipe = AddRecipe(13687, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(190, 190, 210, 230, 250)
    recipe:SetRecipeItem(11167, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENCHANTING_BOOTS")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

    -- Enchant Shield - Lesser Parry -- 13689
    recipe = AddRecipe(13689, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(195, 195, 215, 235, 255)
    recipe:SetRecipeItem(11168, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENCHANTING_SHIELD")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.TANK)
    recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

    -- Enchant Weapon - Striking -- 13693
    recipe = AddRecipe(13693, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(195, 195, 215, 235, 255)
    recipe:SetItemFilterType("ENCHANTING_WEAPON")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 7949, 11072, 11073, 11074, 16160, 16633, 16725,
        18753, 18773, 19251, 19252, 19540, 26906, 26990, 28693, 33583, 33610, 33633, 33676, 53410, 65127)

    -- Enchant 2H Weapon - Impact -- 13695
    recipe = AddRecipe(13695, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(200, 200, 220, 240, 260)
    recipe:SetItemFilterType("ENCHANTING_2H_WEAPON")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 7949, 11072, 11073, 11074, 16160, 16633, 16725,
        18753, 18773, 19251, 19252, 19540, 26906, 26990, 28693, 33583, 33610, 33633, 33676, 53410, 65127)

    -- Enchant Gloves - Skinning -- 13698
    recipe = AddRecipe(13698, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(200, 200, 220, 240, 260)
    recipe:SetRecipeItem(11166, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENCHANTING_GLOVES")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddMobDrop(2556, 2557, 2558)

    -- Enchant Chest - Lesser Stats -- 13700
    recipe = AddRecipe(13700, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(200, 200, 220, 240, 260)
    recipe:SetItemFilterType("ENCHANTING_CHEST")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 7949, 11072, 11073, 11074, 16160, 16633, 16725,
        18753, 18773, 19251, 19252, 19540, 26906, 26990, 28693, 33583, 33610, 33633, 33676, 53410, 65127)

    -- Enchant Cloak - Greater Defense -- 13746
    recipe = AddRecipe(13746, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(205, 205, 225, 245, 265)
    recipe:SetItemFilterType("ENCHANTING_CLOAK")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.TANK)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 7949, 11072, 11073, 11074, 16160, 16633, 16725,
        18753, 18773, 19251, 19252, 19540, 26906, 26990, 28693, 33583, 33610, 33633, 33676, 53410, 65127)

    -- Enchant Gloves - Agility -- 13815
    recipe = AddRecipe(13815, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(210, 210, 230, 250, 270)
    recipe:SetItemFilterType("ENCHANTING_GLOVES")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 7949, 11072, 11073, 11074, 16160, 16633, 16725,
        18753, 18773, 19251, 19252, 19540, 26906, 26990, 28693, 33583, 33610, 33633, 33676, 53410, 65127)

    -- Enchant Shield - Stamina -- 13817
    recipe = AddRecipe(13817, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(210, 210, 230, 250, 270)
    recipe:SetRecipeItem(11202, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENCHANTING_SHIELD")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

    -- Enchant Bracer - Intellect -- 13822
    recipe = AddRecipe(13822, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(210, 210, 230, 250, 270)
    recipe:SetItemFilterType("ENCHANTING_BRACER")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 7949, 11072, 11073, 11074, 16160, 16633, 16725,
        18753, 18773, 19251, 19252, 19540, 26906, 26990, 28693, 33583, 33610, 33633, 33676, 53410, 65127)

    -- Enchant Boots - Stamina -- 13836
    recipe = AddRecipe(13836, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(215, 215, 235, 255, 275)
    recipe:SetItemFilterType("ENCHANTING_BOOTS")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 7949, 11072, 11073, 11074, 16160, 16633, 16725,
        18753, 18773, 19251, 19252, 19540, 26906, 26990, 28693, 33583, 33610, 33633, 33676, 53410, 65127)

    -- Enchant Gloves - Advanced Mining -- 13841
    recipe = AddRecipe(13841, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(215, 215, 235, 255, 275)
    recipe:SetRecipeItem(11203, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENCHANTING_GLOVES")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:Retire()

    -- Enchant Bracer - Greater Spirit -- 13846
    recipe = AddRecipe(13846, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(220, 220, 240, 260, 280)
    recipe:SetRecipeItem(11204, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENCHANTING_BRACER")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

    -- Enchant Chest - Superior Health -- 13858
    recipe = AddRecipe(13858, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(220, 220, 240, 260, 280)
    recipe:SetItemFilterType("ENCHANTING_CHEST")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 7949, 11072, 11073, 11074, 16160, 16633, 16725,
        18753, 18773, 19251, 19252, 19540, 26906, 26990, 28693, 33583, 33610, 33633, 33676, 53410, 65127)

    -- Enchant Gloves - Advanced Herbalism -- 13868
    recipe = AddRecipe(13868, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(225, 225, 245, 265, 285)
    recipe:SetRecipeItem(11205, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENCHANTING_GLOVES")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:Retire()

    -- Enchant Cloak - Lesser Agility -- 13882
    recipe = AddRecipe(13882, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(225, 225, 245, 265, 285)
    recipe:SetRecipeItem(71714, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENCHANTING_CLOAK")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
    recipe:AddWorldDrop(Z.TANARIS)

    -- Enchant Gloves - Strength -- 13887
    recipe = AddRecipe(13887, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(225, 225, 245, 265, 285)
    recipe:SetItemFilterType("ENCHANTING_GLOVES")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 7949, 11072, 11073, 11074, 16160, 16633, 16725,
        18753, 18773, 19251, 19252, 19540, 26906, 26990, 28693, 33583, 33610, 33633, 33676, 53410, 65127)

    -- Enchant Boots - Minor Speed -- 13890
    recipe = AddRecipe(13890, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(225, 225, 245, 265, 285)
    recipe:SetItemFilterType("ENCHANTING_BOOTS")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 7949, 11072, 11073, 11074, 16160, 16633, 16725,
        18753, 18773, 19251, 19252, 19540, 26906, 26990, 28693, 33583, 33610, 33633, 33676, 53410, 65127)

    -- Enchant Weapon - Fiery Weapon -- 13898
    recipe = AddRecipe(13898, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(265, 265, 285, 305, 325)
    recipe:SetRecipeItem(11207, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENCHANTING_WEAPON")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.INSTANCE)
    recipe:AddMobDrop(9024)

    -- Enchant Shield - Greater Spirit -- 13905
    recipe = AddRecipe(13905, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(230, 230, 250, 270, 290)
    recipe:SetItemFilterType("ENCHANTING_SHIELD")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 7949, 11072, 11073, 11074, 16160, 16633, 16725,
        18753, 18773, 19251, 19252, 19540, 26906, 26990, 28693, 33583, 33610, 33633, 33676, 53410, 65127)

    -- Enchant Weapon - Demonslaying -- 13915
    recipe = AddRecipe(13915, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(230, 230, 250, 270, 290)
    recipe:SetRecipeItem(11208, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENCHANTING_WEAPON")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

    -- Enchant Chest - Superior Mana -- 13917
    recipe = AddRecipe(13917, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(230, 230, 250, 270, 290)
    recipe:SetItemFilterType("ENCHANTING_CHEST")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 7949, 11072, 11073, 11074, 16160, 16633, 16725,
        18753, 18773, 19251, 19252, 19540, 26906, 26990, 28693, 33583, 33610, 33633, 33676, 53410, 65127)

    -- Enchant Bracer - Dodge -- 13931
    recipe = AddRecipe(13931, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(235, 235, 255, 275, 295)
    recipe:SetRecipeItem(11223, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENCHANTING_BRACER")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.TANK)
    recipe:AddLimitedVendor(989, 1, 4229, 1)

    -- Enchant Boots - Agility -- 13935
    recipe = AddRecipe(13935, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(235, 235, 255, 275, 295)
    recipe:SetItemFilterType("ENCHANTING_BOOTS")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 7949, 11072, 11073, 11074, 16160, 16633, 16725,
        18753, 18773, 19251, 19252, 19540, 26906, 26990, 28693, 33583, 33610, 33633, 33676, 53410, 65127)

    -- Enchant 2H Weapon - Greater Impact -- 13937
    recipe = AddRecipe(13937, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(240, 240, 260, 280, 300)
    recipe:SetItemFilterType("ENCHANTING_2H_WEAPON")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 7949, 11072, 11073, 11074, 16160, 16633, 16725,
        18753, 18773, 19251, 19252, 19540, 26906, 26990, 28693, 33583, 33610, 33633, 33676, 53410, 65127)

    -- Enchant Bracer - Greater Strength -- 13939
    recipe = AddRecipe(13939, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(240, 240, 260, 280, 300)
    recipe:SetItemFilterType("ENCHANTING_BRACER")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 7949, 11072, 11073, 11074, 16160, 16633, 16725,
        18753, 18773, 19251, 19252, 19540, 26906, 26990, 28693, 33583, 33610, 33633, 33676, 53410, 65127)

    -- Enchant Chest - Stats -- 13941
    recipe = AddRecipe(13941, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(245, 245, 265, 285, 305)
    recipe:SetItemFilterType("ENCHANTING_CHEST")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 7949, 11072, 11073, 11074, 16160, 16633, 16725,
        18753, 18773, 19251, 19252, 19540, 26906, 26990, 28693, 33583, 33610, 33633, 33676, 53410, 65127)

    -- Enchant Weapon - Greater Striking -- 13943
    recipe = AddRecipe(13943, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(245, 245, 265, 285, 305)
    recipe:SetItemFilterType("ENCHANTING_WEAPON")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 7949, 11072, 11073, 11074, 16160, 16633, 16725,
        18753, 18773, 19251, 19252, 19540, 26906, 26990, 28693, 33583, 33610, 33633, 33676, 53410, 65127)

    -- Enchant Bracer - Greater Stamina -- 13945
    recipe = AddRecipe(13945, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(245, 245, 265, 285, 305)
    recipe:SetRecipeItem(11225, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENCHANTING_BRACER")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

    -- Enchant Gloves - Riding Skill -- 13947
    recipe = AddRecipe(13947, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(250, 250, 270, 290, 310)
    recipe:SetRecipeItem(11226, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENCHANTING_GLOVES")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

    -- Enchant Gloves - Minor Haste -- 13948
    recipe = AddRecipe(13948, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(250, 250, 270, 290, 310)
    recipe:SetItemFilterType("ENCHANTING_GLOVES")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 7949, 11072, 11073, 11074, 16160, 16633, 16725,
        18753, 18773, 19251, 19252, 19540, 26906, 26990, 28693, 33583, 33610, 33633, 33676, 53410, 65127)

    -- Lesser Magic Wand -- 14293
    recipe = AddRecipe(14293, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(10, 10, 75, 95, 115)
    recipe:SetCraftedItem(11287, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENCHANTING_WAND")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 7949, 11072, 11073, 11074, 16160, 16633, 16725,
        18753, 18773, 19251, 19252, 19540, 26906, 26990, 28693, 33583, 33610, 33633, 33676, 47384, 47396, 47400, 47418,
        47419, 47420, 47431, 48619, 53410, 57620, 65043, 65127)

    -- Greater Magic Wand -- 14807
    recipe = AddRecipe(14807, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(70, 70, 110, 130, 150)
    recipe:SetCraftedItem(11288, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENCHANTING_WAND")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 7949, 11072, 11073, 11074, 16160, 16633, 16725,
        18753, 18773, 19251, 19252, 19540, 26906, 26990, 28693, 33583, 33610, 33633, 33676, 47384, 47396, 47400, 47418,
        47419, 47420, 47431, 48619, 53410, 57620, 65043, 65127)

    -- Lesser Mystic Wand -- 14809
    recipe = AddRecipe(14809, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(155, 155, 175, 195, 215)
    recipe:SetCraftedItem(11289, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENCHANTING_WAND")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 7949, 11072, 11073, 11074, 16160, 16633, 16725,
        18753, 18773, 19251, 19252, 19540, 26906, 26990, 28693, 33583, 33610, 33633, 33676, 53410, 65127)

    -- Greater Mystic Wand -- 14810
    recipe = AddRecipe(14810, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(175, 175, 195, 215, 235)
    recipe:SetCraftedItem(11290, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENCHANTING_WAND")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 7949, 11072, 11073, 11074, 16160, 16633, 16725,
        18753, 18773, 19251, 19252, 19540, 26906, 26990, 28693, 33583, 33610, 33633, 33676, 53410, 65127)

    -- Smoking Heart of the Mountain -- 15596
    recipe = AddRecipe(15596, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(265, 265, 285, 305, 325)
    recipe:SetRecipeItem(45050, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(45050, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENCHANTING_MISC")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.INSTANCE, F.DPS, F.HEALER, F.CASTER)
    recipe:AddMobDrop(9025)

    -- Enchanted Thorium Bar -- 17180
    recipe = AddRecipe(17180, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(250, 250, 250, 255, 260)
    recipe:SetCraftedItem(12655, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENCHANTING_MISC")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 7949, 11072, 11073, 11074, 16160, 16633, 16725,
        18753, 18773, 19251, 19252, 19540, 26906, 26990, 28693, 33583, 33610, 33633, 33676, 53410, 65127)

    -- Enchanted Leather -- 17181
    recipe = AddRecipe(17181, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(250, 250, 250, 255, 260)
    recipe:SetCraftedItem(12810, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENCHANTING_MISC")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 7949, 11072, 11073, 11074, 16160, 16633, 16725,
        18753, 18773, 19251, 19252, 19540, 26906, 26990, 28693, 33583, 33610, 33633, 33676, 53410, 65127)

    -- Enchant Bracer - Greater Intellect -- 20008
    recipe = AddRecipe(20008, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(255, 255, 275, 295, 315)
    recipe:SetItemFilterType("ENCHANTING_BRACER")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 7949, 11072, 11073, 11074, 16160, 16633, 16725,
        18753, 18773, 19251, 19252, 19540, 26906, 26990, 28693, 33583, 33610, 33633, 33676, 53410, 65127)

    -- Enchant Bracer - Superior Spirit -- 20009
    recipe = AddRecipe(20009, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(270, 270, 290, 310, 330)
    recipe:SetRecipeItem(16218, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENCHANTING_BRACER")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

    -- Enchant Bracer - Superior Strength -- 20010
    recipe = AddRecipe(20010, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(295, 295, 310, 325, 340)
    recipe:SetRecipeItem(16246, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENCHANTING_BRACER")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
    recipe:AddMobDrop(7372)

    -- Enchant Bracer - Superior Stamina -- 20011
    recipe = AddRecipe(20011, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(300, 300, 310, 325, 340)
    recipe:SetRecipeItem(16251, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENCHANTING_BRACER")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

    -- Enchant Gloves - Greater Agility -- 20012
    recipe = AddRecipe(20012, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(270, 270, 290, 310, 330)
    recipe:SetItemFilterType("ENCHANTING_GLOVES")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 7949, 11072, 11073, 11074, 16160, 16633, 16725,
        18753, 18773, 19251, 19252, 19540, 26906, 26990, 28693, 33583, 33610, 33633, 33676, 53410, 65127)

    -- Enchant Gloves - Greater Strength -- 20013
    recipe = AddRecipe(20013, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(295, 295, 310, 325, 340)
    recipe:SetItemFilterType("ENCHANTING_GLOVES")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 7949, 11072, 11073, 11074, 16160, 16633, 16725,
        18753, 18773, 19251, 19252, 19540, 26906, 26990, 28693, 33583, 33610, 33633, 33676, 53410, 65127)

    -- Enchant Cloak - Superior Defense -- 20015
    recipe = AddRecipe(20015, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(285, 285, 300, 317, 335)
    recipe:SetRecipeItem(16224, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENCHANTING_CLOAK")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.TANK)
    recipe:AddLimitedVendor(12022, 1)

    -- Enchant Shield - Vitality -- 20016
    recipe = AddRecipe(20016, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(280, 280, 300, 320, 340)
    recipe:SetItemFilterType("ENCHANTING_SHIELD")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 7949, 11072, 11073, 11074, 16160, 16633, 16725,
        18753, 18773, 19251, 19252, 19540, 26906, 26990, 28693, 33583, 33610, 33633, 33676, 53410, 65127)

    -- Enchant Shield - Greater Stamina -- 20017
    recipe = AddRecipe(20017, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(265, 265, 285, 305, 325)
    recipe:SetRecipeItem(16217, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENCHANTING_SHIELD")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddVendor(4561)
    recipe:AddLimitedVendor(4229, 1)

    -- Enchant Boots - Greater Stamina -- 20020
    recipe = AddRecipe(20020, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(260, 260, 280, 300, 320)
    recipe:SetRecipeItem(16215, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENCHANTING_BOOTS")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

    -- Enchant Boots - Greater Agility -- 20023
    recipe = AddRecipe(20023, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(295, 295, 310, 325, 340)
    recipe:SetItemFilterType("ENCHANTING_BOOTS")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 7949, 11072, 11073, 11074, 16160, 16633, 16725,
        18753, 18773, 19251, 19252, 19540, 26906, 26990, 28693, 33583, 33610, 33633, 33676, 53410, 65127)

    -- Enchant Boots - Spirit -- 20024
    recipe = AddRecipe(20024, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(275, 275, 295, 315, 335)
    recipe:SetRecipeItem(16220, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENCHANTING_BOOTS")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

    -- Enchant Chest - Greater Stats -- 20025
    recipe = AddRecipe(20025, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(300, 300, 310, 325, 340)
    recipe:SetRecipeItem(16253, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENCHANTING_CHEST")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddWorldDrop(Z.OUTLAND)

    -- Enchant Chest - Major Health -- 20026
    recipe = AddRecipe(20026, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(275, 275, 295, 315, 335)
    recipe:SetRecipeItem(16221, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENCHANTING_CHEST")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddVendor(11189)

    -- Enchant Chest - Major Mana -- 20028
    recipe = AddRecipe(20028, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(290, 290, 305, 322, 340)
    recipe:SetItemFilterType("ENCHANTING_CHEST")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 7949, 11072, 11073, 11074, 16160, 16633, 16725,
        18753, 18773, 19251, 19252, 19540, 26906, 26990, 28693, 33583, 33610, 33633, 33676, 53410, 65127)

    -- Enchant Weapon - Icy Chill -- 20029
    recipe = AddRecipe(20029, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(285, 285, 300, 317, 335)
    recipe:SetRecipeItem(16223, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENCHANTING_WEAPON")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddMobDrop(7524)

    -- Enchant 2H Weapon - Superior Impact -- 20030
    recipe = AddRecipe(20030, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(295, 295, 310, 325, 340)
    recipe:SetRecipeItem(16247, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENCHANTING_2H_WEAPON")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.INSTANCE)
    recipe:AddMobDrop(10317)

    -- Enchant Weapon - Superior Striking -- 20031
    recipe = AddRecipe(20031, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(300, 300, 310, 325, 340)
    recipe:SetRecipeItem(16250, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENCHANTING_WEAPON")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.INSTANCE)
    recipe:AddMobDrop(9216)

    -- Enchant Weapon - Lifestealing -- 20032
    recipe = AddRecipe(20032, V.ORIG, Q.RARE)
    recipe:SetSkillLevels(300, 300, 310, 325, 340)
    recipe:SetRecipeItem(16254, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENCHANTING_WEAPON")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.INSTANCE)
    recipe:AddMobDrop(10499)

    -- Enchant Weapon - Unholy Weapon -- 20033
    recipe = AddRecipe(20033, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(295, 295, 310, 325, 340)
    recipe:SetRecipeItem(16248, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENCHANTING_WEAPON")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.INSTANCE)
    recipe:AddMobDrop(10398, 16810)

    -- Enchant Weapon - Crusader -- 20034
    recipe = AddRecipe(20034, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(300, 300, 310, 325, 340)
    recipe:SetRecipeItem(16252, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENCHANTING_WEAPON")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
    recipe:AddMobDrop(9451)

    -- Enchant 2H Weapon - Major Spirit -- 20035
    recipe = AddRecipe(20035, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(300, 300, 310, 325, 340)
    recipe:SetRecipeItem(16255, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENCHANTING_2H_WEAPON")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.INSTANCE, F.HEALER, F.CASTER)
    recipe:AddMobDrop(10469)

    -- Enchant 2H Weapon - Major Intellect -- 20036
    recipe = AddRecipe(20036, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(300, 300, 310, 325, 340)
    recipe:SetRecipeItem(16249, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENCHANTING_2H_WEAPON")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.INSTANCE, F.HEALER, F.CASTER)
    recipe:AddMobDrop(10422)

    -- Enchant Weapon - Winter's Might -- 21931
    recipe = AddRecipe(21931, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(190, 190, 210, 230, 250)
    recipe:SetRecipeItem(17725, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENCHANTING_WEAPON")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddWorldEvent("WINTER_VEIL")

    -- Enchant Weapon - Spellpower -- 22749
    recipe = AddRecipe(22749, V.ORIG, Q.RARE)
    recipe:SetSkillLevels(300, 300, 310, 325, 340)
    recipe:SetRecipeItem(18259, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENCHANTING_WEAPON")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.RAID, F.HEALER, F.CASTER)
    recipe:AddWorldDrop(Z.MOLTEN_CORE)

    -- Enchant Weapon - Healing Power -- 22750
    recipe = AddRecipe(22750, V.ORIG, Q.RARE)
    recipe:SetSkillLevels(300, 300, 310, 325, 340)
    recipe:SetRecipeItem(18260, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENCHANTING_WEAPON")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.RAID, F.HEALER, F.CASTER)
    recipe:AddWorldDrop(Z.MOLTEN_CORE)

    -- Enchant Weapon - Strength -- 23799
    recipe = AddRecipe(23799, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(290, 290, 305, 322, 340)
    recipe:SetRecipeItem(19444, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENCHANTING_WEAPON")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.THORIUM_BROTHERHOOD)
    recipe:AddRepVendor(FAC.THORIUM_BROTHERHOOD, REP.FRIENDLY, 12944)

    -- Enchant Weapon - Agility -- 23800
    recipe = AddRecipe(23800, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(290, 290, 305, 322, 340)
    recipe:SetRecipeItem(19445, "BIND_ON_PICKUP")
    recipe:SetRequiredFaction("Horde")
    recipe:SetItemFilterType("ENCHANTING_WEAPON")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.TIMBERMAW_HOLD)
    recipe:AddRepVendor(FAC.TIMBERMAW_HOLD, REP.HONORED, 11557)

    -- Enchant Bracer - Mana Regeneration -- 23801
    recipe = AddRecipe(23801, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(290, 290, 305, 322, 340)
    recipe:SetRecipeItem(19446, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENCHANTING_BRACER")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER, F.ARGENTDAWN)
    recipe:AddRepVendor(FAC.ARGENT_DAWN, REP.HONORED, 10856, 10857, 11536)

    -- Enchant Bracer - Healing Power -- 23802
    recipe = AddRecipe(23802, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(300, 300, 310, 325, 340)
    recipe:SetRecipeItem(19447, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENCHANTING_BRACER")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER, F.ARGENTDAWN)
    recipe:AddRepVendor(FAC.ARGENT_DAWN, REP.REVERED, 10856, 10857, 11536)

    -- Enchant Weapon - Mighty Spirit -- 23803
    recipe = AddRecipe(23803, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(300, 300, 310, 325, 340)
    recipe:SetRecipeItem(19448, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENCHANTING_WEAPON")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER, F.THORIUM_BROTHERHOOD)
    recipe:AddRepVendor(FAC.THORIUM_BROTHERHOOD, REP.HONORED, 12944)

    -- Enchant Weapon - Mighty Intellect -- 23804
    recipe = AddRecipe(23804, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(300, 300, 310, 325, 340)
    recipe:SetRecipeItem(19449, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENCHANTING_WEAPON")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER, F.THORIUM_BROTHERHOOD)
    recipe:AddRepVendor(FAC.THORIUM_BROTHERHOOD, REP.REVERED, 12944)

    -- Enchant Gloves - Threat -- 25072
    recipe = AddRecipe(25072, V.ORIG, Q.RARE)
    recipe:SetSkillLevels(300, 300, 310, 325, 340)
    recipe:SetRecipeItem(20726, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENCHANTING_GLOVES")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.RAID, F.TANK, F.SHATAR)
    recipe:AddMobDrop(15275)
    recipe:AddRepVendor(FAC.THE_SHATAR, REP.EXALTED, 21432)

    -- Enchant Gloves - Shadow Power -- 25073
    recipe = AddRecipe(25073, V.ORIG, Q.RARE)
    recipe:SetSkillLevels(300, 300, 310, 325, 340)
    recipe:SetRecipeItem(20727, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENCHANTING_GLOVES")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.RAID, F.HEALER, F.CASTER)
    recipe:AddWorldDrop(Z.AHNQIRAJ)

    -- Enchant Gloves - Frost Power -- 25074
    recipe = AddRecipe(25074, V.ORIG, Q.RARE)
    recipe:SetSkillLevels(300, 300, 310, 325, 340)
    recipe:SetRecipeItem(20728, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENCHANTING_GLOVES")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.RAID, F.HEALER, F.CASTER)
    recipe:AddWorldDrop(Z.AHNQIRAJ)

    -- Enchant Gloves - Fire Power -- 25078
    recipe = AddRecipe(25078, V.ORIG, Q.RARE)
    recipe:SetSkillLevels(300, 300, 310, 325, 340)
    recipe:SetRecipeItem(20729, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENCHANTING_GLOVES")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.RAID, F.HEALER, F.CASTER)
    recipe:AddWorldDrop(Z.AHNQIRAJ)

    -- Enchant Gloves - Healing Power -- 25079
    recipe = AddRecipe(25079, V.ORIG, Q.RARE)
    recipe:SetSkillLevels(300, 300, 310, 325, 340)
    recipe:SetRecipeItem(20730, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENCHANTING_GLOVES")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.RAID, F.HEALER, F.CASTER)
    recipe:AddWorldDrop(Z.AHNQIRAJ)

    -- Enchant Gloves - Superior Agility -- 25080
    recipe = AddRecipe(25080, V.ORIG, Q.RARE)
    recipe:SetSkillLevels(300, 300, 310, 325, 340)
    recipe:SetRecipeItem(20731, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENCHANTING_GLOVES")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.RAID, F.DPS, F.KOT)
    recipe:AddRepVendor(FAC.KEEPERS_OF_TIME, REP.EXALTED, 21643)
    recipe:AddWorldDrop(Z.AHNQIRAJ)

    -- Enchant Cloak - Stealth -- 25083
    recipe = AddRecipe(25083, V.ORIG, Q.RARE)
    recipe:SetSkillLevels(300, 300, 310, 325, 340)
    recipe:SetRecipeItem(33149, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENCHANTING_CLOAK")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.RAID, F.TANK, F.CENARION_EXPEDITION)
    recipe:AddRepVendor(FAC.CENARION_EXPEDITION, REP.EXALTED, 17904)
    recipe:AddWorldDrop(Z.AHNQIRAJ)

    -- Enchant Cloak - Dodge -- 25086
    recipe = AddRecipe(25086, V.ORIG, Q.RARE)
    recipe:SetSkillLevels(300, 300, 310, 325, 340)
    recipe:SetRecipeItem(33148, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENCHANTING_CLOAK")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.RAID, F.TANK, F.LOWERCITY)
    recipe:AddRepVendor(FAC.LOWER_CITY, REP.EXALTED, 21655)
    recipe:AddWorldDrop(Z.AHNQIRAJ)

    -- Minor Wizard Oil -- 25124
    recipe = AddRecipe(25124, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(45, 45, 55, 65, 75)
    recipe:SetRecipeItem(20758, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(20744, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENCHANTING_OIL")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddVendor(1318, 3012, 3346, 4228, 4617, 5158, 5757, 5758, 15419, 16635, 16722, 18753, 18773, 18951, 19234,
        19537, 19540, 19663, 26569, 27030, 27054, 27147, 28714, 44030, 53410)

    -- Minor Mana Oil -- 25125
    recipe = AddRecipe(25125, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(150, 150, 160, 170, 180)
    recipe:SetRecipeItem(20752, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(20745, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENCHANTING_OIL")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddVendor(1318, 3012, 3346, 4228, 4617, 5158, 5757, 5758, 15419, 16635, 16722, 18753, 18773, 18951, 19234,
        19537, 19540, 19663, 26569, 27030, 27054, 27147, 28714, 53410)

    -- Lesser Wizard Oil -- 25126
    recipe = AddRecipe(25126, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(200, 200, 210, 220, 230)
    recipe:SetRecipeItem(20753, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(20746, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENCHANTING_OIL")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddVendor(1318, 3012, 3346, 4228, 4617, 5158, 5757, 5758, 15419, 16635, 16722, 18753, 18773, 18951, 19234,
        19537, 19540, 19663, 26569, 27030, 27054, 27147, 28714, 53410)

    -- Lesser Mana Oil -- 25127
    recipe = AddRecipe(25127, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(250, 250, 260, 270, 280)
    recipe:SetRecipeItem(20754, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(20747, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENCHANTING_OIL")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddVendor(15419)

    -- Wizard Oil -- 25128
    recipe = AddRecipe(25128, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(275, 275, 285, 295, 305)
    recipe:SetRecipeItem(20755, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(20750, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENCHANTING_OIL")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddVendor(15419)

    -- Brilliant Wizard Oil -- 25129
    recipe = AddRecipe(25129, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(300, 300, 310, 320, 330)
    recipe:SetRecipeItem(20756, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(20749, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENCHANTING_OIL")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
    recipe:Retire()

    -- Brilliant Mana Oil -- 25130
    recipe = AddRecipe(25130, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(300, 300, 310, 320, 330)
    recipe:SetRecipeItem(20757, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(20748, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENCHANTING_OIL")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:Retire()

    -- Enchant 2H Weapon - Agility -- 27837
    recipe = AddRecipe(27837, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(290, 290, 305, 322, 340)
    recipe:SetRecipeItem(22392, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENCHANTING_2H_WEAPON")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.TIMBERMAW_HOLD)
    recipe:AddRepVendor(FAC.TIMBERMAW_HOLD, REP.FRIENDLY, 11557)

    -------------------------------------------------------------------------------
    -- The Burning Crusade.
    -------------------------------------------------------------------------------
    -- Enchant Cloak - Subtlety -- 25084
    recipe = AddRecipe(25084, V.TBC, Q.RARE)
    recipe:SetSkillLevels(300, 300, 310, 325, 340)
    recipe:SetRecipeItem(33150, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENCHANTING_CLOAK")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.RAID, F.TANK, F.HELLFIRE)
    recipe:AddMobDrop(15276)
    recipe:AddRepVendor(FAC.HONOR_HOLD, REP.EXALTED, 17657)
    recipe:AddRepVendor(FAC.THRALLMAR, REP.EXALTED, 17585)

    -- Enchant Bracer - Brawn -- 27899
    recipe = AddRecipe(27899, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(305, 305, 315, 330, 345)
    recipe:SetItemFilterType("ENCHANTING_BRACER")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 5157, 5695, 16725, 18753, 18773, 19251, 19252, 19540, 26906, 26990,
        28693, 33583, 33610, 33633, 33676, 53410, 65127)

    -- Enchant Bracer - Stats -- 27905
    recipe = AddRecipe(27905, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(315, 315, 325, 340, 355)
    recipe:SetItemFilterType("ENCHANTING_BRACER")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 5157, 5695, 16725, 18753, 18773, 19251, 19252, 19540, 26906, 26990,
        28693, 33583, 33610, 33633, 33676, 53410, 65127)

    -- Enchant Bracer - Greater Dodge -- 27906
    recipe = AddRecipe(27906, V.TBC, Q.UNCOMMON)
    recipe:SetSkillLevels(320, 320, 330, 345, 360)
    recipe:SetRecipeItem(22530, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENCHANTING_BRACER")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.TANK)
    recipe:AddMobDrop(22822, 23008)

    -- Enchant Bracer - Superior Healing -- 27911
    recipe = AddRecipe(27911, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(325, 325, 335, 350, 365)
    recipe:SetRecipeItem(22531, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENCHANTING_BRACER")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER, F.HELLFIRE)
    recipe:AddRepVendor(FAC.HONOR_HOLD, REP.FRIENDLY, 17657)
    recipe:AddRepVendor(FAC.THRALLMAR, REP.FRIENDLY, 17585)

    -- Enchant Bracer - Restore Mana Prime -- 27913
    recipe = AddRecipe(27913, V.TBC, Q.UNCOMMON)
    recipe:SetSkillLevels(335, 335, 345, 360, 375)
    recipe:SetRecipeItem(22532, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENCHANTING_BRACER")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddWorldDrop(Z.OUTLAND)

    -- Enchant Bracer - Fortitude -- 27914
    recipe = AddRecipe(27914, V.TBC, Q.UNCOMMON)
    recipe:SetSkillLevels(350, 350, 370, 375, 380)
    recipe:SetRecipeItem(22533, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENCHANTING_BRACER")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.INSTANCE)
    recipe:AddMobDrop(17803)

    -- Enchant Bracer - Spellpower -- 27917
    recipe = AddRecipe(27917, V.TBC, Q.UNCOMMON)
    recipe:SetSkillLevels(360, 360, 370, 385, 400)
    recipe:SetRecipeItem(22534, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENCHANTING_BRACER")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddMobDrop(19952)

    -- Enchant Ring - Striking -- 27920
    recipe = AddRecipe(27920, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(360, 360, 370, 377, 385)
    recipe:SetRecipeItem(22535, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENCHANTING_RING")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.CONSORTIUM)
    recipe:AddRepVendor(FAC.THE_CONSORTIUM, REP.REVERED, 20242, 23007)

    -- Enchant Ring - Minor Intellect -- 27924
    recipe = AddRecipe(27924, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(360, 360, 370, 377, 385)
    recipe:SetRecipeItem(22536, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENCHANTING_RING")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER, F.KOT)
    recipe:AddRepVendor(FAC.KEEPERS_OF_TIME, REP.HONORED, 21643)

    -- Enchant Ring - Stats -- 27927
    recipe = AddRecipe(27927, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(375, 375, 380, 385, 390)
    recipe:SetRecipeItem(22538, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENCHANTING_RING")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.LOWERCITY)
    recipe:AddRepVendor(FAC.LOWER_CITY, REP.HONORED, 21655)

    -- Enchant Shield - Lesser Dodge -- 27944
    recipe = AddRecipe(27944, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(310, 310, 320, 335, 350)
    recipe:SetItemFilterType("ENCHANTING_SHIELD")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.TANK)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 5157, 5695, 16725, 18753, 18773, 19251, 19252, 19540, 26906, 26990,
        28693, 33583, 33610, 33633, 33676, 53410, 65127)

    -- Enchant Shield - Intellect -- 27945
    recipe = AddRecipe(27945, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(325, 325, 335, 350, 365)
    recipe:SetRecipeItem(22539, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENCHANTING_SHIELD")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddVendor(18664)

    -- Enchant Shield - Parry -- 27946
    recipe = AddRecipe(27946, V.TBC, Q.UNCOMMON)
    recipe:SetSkillLevels(340, 340, 350, 365, 380)
    recipe:SetRecipeItem(22540, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENCHANTING_SHIELD")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.TANK)
    recipe:AddWorldDrop(Z.OUTLAND)

    -- Enchant Boots - Vitality -- 27948
    recipe = AddRecipe(27948, V.TBC, Q.UNCOMMON)
    recipe:SetSkillLevels(305, 305, 315, 330, 345)
    recipe:SetRecipeItem(22542, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENCHANTING_BOOTS")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddMobDrop(24664)

    -- Enchant Boots - Fortitude -- 27950
    recipe = AddRecipe(27950, V.TBC, Q.UNCOMMON)
    recipe:SetSkillLevels(320, 320, 330, 345, 360)
    recipe:SetRecipeItem(22543, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENCHANTING_BOOTS")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.INSTANCE)
    recipe:AddMobDrop(18317)

    -- Enchant Boots - Dexterity -- 27951
    recipe = AddRecipe(27951, V.TBC, Q.UNCOMMON)
    recipe:SetSkillLevels(340, 340, 350, 365, 380)
    recipe:SetRecipeItem(22544, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENCHANTING_BOOTS")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.INSTANCE, F.DPS)
    recipe:AddMobDrop(18521)

    -- Enchant Boots - Surefooted -- 27954
    recipe = AddRecipe(27954, V.TBC, Q.UNCOMMON)
    recipe:SetSkillLevels(370, 370, 380, 385, 390)
    recipe:SetRecipeItem(22545, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENCHANTING_BOOTS")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.RAID, F.DPS, F.HEALER, F.CASTER)
    recipe:AddMobDrop(16472)

    -- Enchant Chest - Exceptional Health -- 27957
    recipe = AddRecipe(27957, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(315, 315, 325, 340, 355)
    recipe:SetItemFilterType("ENCHANTING_CHEST")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 5157, 5695, 16725, 18753, 18773, 19251, 19252, 19540, 26906, 26990,
        28693, 33583, 33610, 33633, 33676, 53410, 65127)

    -- Enchant Chest - Exceptional Stats -- 27960
    recipe = AddRecipe(27960, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(345, 345, 355, 367, 380)
    recipe:SetRecipeItem(22547, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENCHANTING_CHEST")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HELLFIRE)
    recipe:AddRepVendor(FAC.HONOR_HOLD, REP.REVERED, 17657)
    recipe:AddRepVendor(FAC.THRALLMAR, REP.REVERED, 17585)

    -- Enchant Cloak - Major Armor -- 27961
    recipe = AddRecipe(27961, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(310, 310, 320, 335, 350)
    recipe:SetItemFilterType("ENCHANTING_CLOAK")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 5157, 5695, 16725, 18753, 18773, 19251, 19252, 19540, 26906, 26990,
        28693, 33583, 33610, 33633, 33676, 53410, 65127)

    -- Enchant Weapon - Major Striking -- 27967
    recipe = AddRecipe(27967, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(340, 340, 350, 365, 380)
    recipe:SetRecipeItem(22552, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENCHANTING_WEAPON")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.CONSORTIUM)
    recipe:AddRepVendor(FAC.THE_CONSORTIUM, REP.HONORED, 20242, 23007)

    -- Enchant Weapon - Major Intellect -- 27968
    recipe = AddRecipe(27968, V.TBC, Q.UNCOMMON)
    recipe:SetSkillLevels(340, 340, 350, 365, 380)
    recipe:SetRecipeItem(22551, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENCHANTING_WEAPON")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddMobDrop(20136)

    -- Enchant 2H Weapon - Savagery -- 27971
    recipe = AddRecipe(27971, V.TBC, Q.UNCOMMON)
    recipe:SetSkillLevels(350, 350, 370, 375, 380)
    recipe:SetRecipeItem(22554, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENCHANTING_2H_WEAPON")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.INSTANCE, F.DPS)
    recipe:AddMobDrop(17465)

    -- Enchant Weapon - Potency -- 27972
    recipe = AddRecipe(27972, V.TBC, Q.UNCOMMON)
    recipe:SetSkillLevels(350, 350, 370, 375, 380)
    recipe:SetRecipeItem(22553, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENCHANTING_WEAPON")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
    recipe:AddWorldDrop(Z.OUTLAND)

    -- Enchant Weapon - Major Spellpower -- 27975
    recipe = AddRecipe(27975, V.TBC, Q.UNCOMMON)
    recipe:SetSkillLevels(350, 350, 370, 375, 380)
    recipe:SetRecipeItem(22555, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENCHANTING_WEAPON")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddMobDrop(22242, 22243, 23385)

    -- Enchant 2H Weapon - Major Agility -- 27977
    recipe = AddRecipe(27977, V.TBC, Q.UNCOMMON)
    recipe:SetSkillLevels(360, 360, 370, 377, 385)
    recipe:SetRecipeItem(22556, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENCHANTING_2H_WEAPON")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.INSTANCE, F.DPS)
    recipe:AddMobDrop(20880)

    -- Enchant Weapon - Sunfire -- 27981
    recipe = AddRecipe(27981, V.TBC, Q.RARE)
    recipe:SetSkillLevels(375, 375, 375, 375, 390)
    recipe:SetRecipeItem(22560, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENCHANTING_WEAPON")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.RAID, F.HEALER, F.CASTER)
    recipe:AddMobDrop(16524)

    -- Enchant Weapon - Soulfrost -- 27982
    recipe = AddRecipe(27982, V.TBC, Q.RARE)
    recipe:SetSkillLevels(375, 375, 380, 385, 390)
    recipe:SetRecipeItem(22561, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENCHANTING_WEAPON")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.RAID, F.HEALER, F.CASTER)
    recipe:AddMobDrop(15688)

    -- Enchant Weapon - Mongoose -- 27984
    recipe = AddRecipe(27984, V.TBC, Q.RARE)
    recipe:SetSkillLevels(375, 375, 380, 385, 390)
    recipe:SetRecipeItem(22559, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENCHANTING_WEAPON")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.RAID, F.DPS, F.HEALER, F.CASTER)
    recipe:AddMobDrop(15687)

    -- Enchant Weapon - Spellsurge -- 28003
    recipe = AddRecipe(28003, V.TBC, Q.UNCOMMON)
    recipe:SetSkillLevels(360, 360, 370, 377, 385)
    recipe:SetRecipeItem(22558, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENCHANTING_WEAPON")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddWorldDrop(Z.OUTLAND)

    -- Enchant Weapon - Battlemaster -- 28004
    recipe = AddRecipe(28004, V.TBC, Q.UNCOMMON)
    recipe:SetSkillLevels(360, 360, 370, 377, 385)
    recipe:SetRecipeItem(22557, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENCHANTING_WEAPON")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddWorldDrop(Z.OUTLAND)

    -- Superior Mana Oil -- 28016
    recipe = AddRecipe(28016, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(310, 310, 310, 320, 330)
    recipe:SetRecipeItem(22562, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(22521, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENCHANTING_OIL")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddLimitedVendor(16635, 1, 16722, 1, 19663, 1)

    -- Superior Wizard Oil -- 28019
    recipe = AddRecipe(28019, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(340, 340, 340, 350, 360)
    recipe:SetRecipeItem(22563, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(22522, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENCHANTING_OIL")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddLimitedVendor(16635, 1, 16722, 1, 19663, 1)

    -- Large Prismatic Shard -- 28022
    recipe = AddRecipe(28022, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(335, 335, 335, 335, 335)
    recipe:SetRecipeItem(22565, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(22449, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENCHANTING_MISC")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddLimitedVendor(16635, 1, 16722, 1, 19663, 1)

    -- Prismatic Sphere -- 28027
    recipe = AddRecipe(28027, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(325, 325, 325, 330, 335)
    recipe:SetCraftedItem(22460, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENCHANTING_MISC")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 5157, 5695, 16725, 18753, 18773, 19251, 19252, 19540, 26906, 26990,
        28693, 33583, 33610, 33633, 33676, 53410, 65127)

    -- Void Sphere -- 28028
    recipe = AddRecipe(28028, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(350, 350, 370, 375, 380)
    recipe:SetCraftedItem(22459, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENCHANTING_MISC")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 5157, 5695, 16725, 18753, 18773, 19251, 19252, 19540, 26906, 26990,
        28693, 33583, 33610, 33633, 33676, 53410, 65127)

    -- Enchant Chest - Major Spirit -- 33990
    recipe = AddRecipe(33990, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(320, 320, 330, 345, 360)
    recipe:SetItemFilterType("ENCHANTING_CHEST")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 5157, 5695, 16725, 18753, 18773, 19251, 19252, 19540, 26906, 26990,
        28693, 33583, 33610, 33633, 33676, 53410, 65127)

    -- Enchant Chest - Restore Mana Prime -- 33991
    recipe = AddRecipe(33991, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(300, 300, 310, 325, 340)
    recipe:SetItemFilterType("ENCHANTING_CHEST")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 5157, 5695, 16725, 18753, 18773, 19251, 19252, 19540, 26906, 26990,
        28693, 33583, 33610, 33633, 33676, 53410, 65127)

    -- Enchant Chest - Major Resilience -- 33992
    recipe = AddRecipe(33992, V.TBC, Q.UNCOMMON)
    recipe:SetSkillLevels(345, 345, 355, 367, 380)
    recipe:SetRecipeItem(28270, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENCHANTING_CHEST")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddWorldDrop(Z.OUTLAND)

    -- Enchant Gloves - Blasting -- 33993
    recipe = AddRecipe(33993, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(305, 305, 315, 330, 345)
    recipe:SetItemFilterType("ENCHANTING_GLOVES")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 5157, 5695, 16725, 18753, 18773, 19251, 19252, 19540, 26906, 26990,
        28693, 33583, 33610, 33633, 33676, 53410, 65127)

    -- Enchant Gloves - Precise Strikes -- 33994
    recipe = AddRecipe(33994, V.TBC, Q.UNCOMMON)
    recipe:SetSkillLevels(360, 360, 370, 377, 385)
    recipe:SetRecipeItem(28271, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENCHANTING_GLOVES")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.CASTER, F.CENARION_EXPEDITION)
    recipe:AddRepVendor(FAC.CENARION_EXPEDITION, REP.REVERED, 17904)

    -- Enchant Gloves - Major Strength -- 33995
    recipe = AddRecipe(33995, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(340, 340, 350, 365, 380)
    recipe:SetItemFilterType("ENCHANTING_GLOVES")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 5157, 5695, 16725, 18753, 18773, 19251, 19252, 19540, 26906, 26990,
        28693, 33583, 33610, 33633, 33676, 53410, 65127)

    -- Enchant Gloves - Assault -- 33996
    recipe = AddRecipe(33996, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(310, 310, 320, 335, 350)
    recipe:SetItemFilterType("ENCHANTING_GLOVES")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 5157, 5695, 16725, 18753, 18773, 19251, 19252, 19540, 26906, 26990,
        28693, 33583, 33610, 33633, 33676, 53410, 65127)

    -- Enchant Gloves - Major Spellpower -- 33997
    recipe = AddRecipe(33997, V.TBC, Q.UNCOMMON)
    recipe:SetSkillLevels(360, 360, 370, 377, 385)
    recipe:SetRecipeItem(28272, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENCHANTING_GLOVES")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER, F.KOT)
    recipe:AddRepVendor(FAC.KEEPERS_OF_TIME, REP.HONORED, 21643)

    -- Enchant Gloves - Major Healing -- 33999
    recipe = AddRecipe(33999, V.TBC, Q.UNCOMMON)
    recipe:SetSkillLevels(350, 350, 370, 375, 380)
    recipe:SetRecipeItem(28273, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENCHANTING_GLOVES")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER, F.SHATAR)
    recipe:AddRepVendor(FAC.THE_SHATAR, REP.HONORED, 21432)

    -- Enchant Bracer - Major Intellect -- 34001
    recipe = AddRecipe(34001, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(305, 305, 315, 330, 345)
    recipe:SetItemFilterType("ENCHANTING_BRACER")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 5157, 5695, 16725, 18753, 18773, 19251, 19252, 19540, 26906, 26990,
        28693, 33583, 33610, 33633, 33676, 53410, 65127)

    -- Enchant Bracer - Lesser Assault -- 34002
    recipe = AddRecipe(34002, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(300, 300, 310, 325, 340)
    recipe:SetItemFilterType("ENCHANTING_BRACER")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 5157, 5695, 16725, 18753, 18773, 19251, 19252, 19540, 26906, 26990,
        28693, 33583, 33610, 33633, 33676, 53410, 65127)

    -- Enchant Cloak - PvP Power -- 34003
    recipe = AddRecipe(34003, V.TBC, Q.UNCOMMON)
    recipe:SetSkillLevels(325, 325, 335, 350, 365)
    recipe:SetRecipeItem(28274, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENCHANTING_CLOAK")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.CONSORTIUM)
    recipe:AddRepVendor(FAC.THE_CONSORTIUM, REP.FRIENDLY, 20242, 23007)

    -- Enchant Cloak - Greater Agility -- 34004
    recipe = AddRecipe(34004, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(310, 310, 320, 335, 350)
    recipe:SetItemFilterType("ENCHANTING_CLOAK")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 5157, 5695, 16725, 18753, 18773, 19251, 19252, 19540, 26906, 26990,
        28693, 33583, 33610, 33633, 33676, 53410, 65127)

    -- Enchant Boots - Cat's Swiftness -- 34007
    recipe = AddRecipe(34007, V.TBC, Q.RARE)
    recipe:SetSkillLevels(360, 360, 370, 377, 385)
    recipe:SetRecipeItem(28279, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENCHANTING_BOOTS")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
    recipe:AddMobDrop(24664)

    -- Enchant Boots - Boar's Speed -- 34008
    recipe = AddRecipe(34008, V.TBC, Q.RARE)
    recipe:SetSkillLevels(360, 360, 370, 377, 385)
    recipe:SetRecipeItem(28280, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENCHANTING_BOOTS")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddMobDrop(24664)

    -- Enchant Shield - Major Stamina -- 34009
    recipe = AddRecipe(34009, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(325, 325, 335, 350, 365)
    recipe:SetRecipeItem(28282, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENCHANTING_SHIELD")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddLimitedVendor(19663, 1)

    -- Enchant Weapon - Major Healing -- 34010
    recipe = AddRecipe(34010, V.TBC, Q.UNCOMMON)
    recipe:SetSkillLevels(350, 350, 370, 375, 380)
    recipe:SetRecipeItem(28281, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENCHANTING_WEAPON")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER, F.SHATAR)
    recipe:AddRepVendor(FAC.THE_SHATAR, REP.REVERED, 21432)

    -- Nexus Transformation -- 42613
    recipe = AddRecipe(42613, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(300, 300, 310, 315, 320)
    recipe:SetCraftedItem(22448, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENCHANTING_MISC")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 5157, 5695, 16725, 18753, 18773, 19251, 19252, 19540, 26906, 26990,
        28693, 33583, 33610, 33633, 33676, 53410, 65127)

    -- Small Prismatic Shard -- 42615
    recipe = AddRecipe(42615, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(335, 335, 335, 335, 335)
    recipe:SetCraftedItem(22448, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENCHANTING_MISC")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 5157, 5695, 16725, 18753, 18773, 19251, 19252, 19540, 26906, 26990,
        28693, 33583, 33610, 33633, 33676, 53410, 65127)

    -- Enchant Weapon - Greater Agility -- 42620
    recipe = AddRecipe(42620, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(350, 350, 360, 367, 375)
    recipe:SetRecipeItem(33165, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENCHANTING_WEAPON")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.VIOLETEYE)
    recipe:AddRepVendor(FAC.THE_VIOLET_EYE, REP.EXALTED, 18255)

    -- Enchant Weapon - Executioner -- 42974
    recipe = AddRecipe(42974, V.TBC, Q.RARE)
    recipe:SetSkillLevels(375, 375, 380, 385, 390)
    recipe:SetRecipeItem(78348, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(78348, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENCHANTING_WEAPON")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
    recipe:AddVendor(19536)

    -- Enchant Shield - Resilience -- 44383
    recipe = AddRecipe(44383, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(330, 330, 340, 355, 370)
    recipe:SetItemFilterType("ENCHANTING_SHIELD")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 5157, 5695, 16725, 18753, 18773, 19251, 19252, 19540, 26906, 26990,
        28693, 33583, 33610, 33633, 33676, 53410, 65127)

    -- Void Shatter -- 45765
    recipe = AddRecipe(45765, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(375, 375, 375, 375, 375)
    recipe:SetRecipeItem(34872, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(22449, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENCHANTING_MISC")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.SHATTEREDSUN)
    recipe:AddRepVendor(FAC.SHATTERED_SUN_OFFENSIVE, REP.HONORED, 25032)

    -- Enchant Weapon - Deathfrost -- 46578
    recipe = AddRecipe(46578, V.TBC, Q.RARE)
    recipe:SetSkillLevels(350, 350, 350, 357, 365)
    recipe:SetRecipeItem(35498, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(35498, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENCHANTING_WEAPON")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddWorldEvent("MIDSUMMER")

    -- Enchant Cloak - Greater Dodge -- 47051
    recipe = AddRecipe(47051, V.TBC, Q.RARE)
    recipe:SetSkillLevels(375, 375, 380, 385, 390)
    recipe:SetRecipeItem(35756, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENCHANTING_CLOAK")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.INSTANCE, F.TANK)
    recipe:AddMobDrop(24560)

    -------------------------------------------------------------------------------
    -- Wrath of the Lich King.
    -------------------------------------------------------------------------------
    -- Enchant Chest - Exceptional Mana -- 27958
    recipe = AddRecipe(27958, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(350, 350, 360, 370, 380)
    recipe:SetItemFilterType("ENCHANTING_CHEST")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 5157, 5695, 16725, 18773, 19251, 19252, 19540, 26906, 26954, 26980,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Enchant Gloves - Expertise -- 44484
    recipe = AddRecipe(44484, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(405, 405, 415, 425, 435)
    recipe:SetItemFilterType("ENCHANTING_GLOVES")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.TANK)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 5157, 5695, 16725, 18773, 19251, 19252, 19540, 26906, 26954, 26980,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Enchant Gloves - Precision -- 44488
    recipe = AddRecipe(44488, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(410, 410, 420, 430, 440)
    recipe:SetItemFilterType("ENCHANTING_GLOVES")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 5157, 5695, 16725, 18773, 19251, 19252, 19540, 26906, 26954, 26980,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Enchant Shield - Dodge -- 44489
    recipe = AddRecipe(44489, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(420, 420, 430, 440, 450)
    recipe:SetItemFilterType("ENCHANTING_SHIELD")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.TANK)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 5157, 5695, 16725, 18773, 19251, 19252, 19540, 26906, 26954, 26980,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Enchant Chest - Mighty Health -- 44492
    recipe = AddRecipe(44492, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(395, 395, 405, 415, 425)
    recipe:SetItemFilterType("ENCHANTING_CHEST")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 5157, 5695, 16725, 18773, 19251, 19252, 19540, 26906, 26954, 26980,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Enchant Cloak - Superior Agility -- 44500
    recipe = AddRecipe(44500, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(395, 395, 405, 415, 425)
    recipe:SetItemFilterType("ENCHANTING_CLOAK")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 5157, 5695, 16725, 18773, 19251, 19252, 19540, 26906, 26954, 26980,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Enchant Gloves - Gatherer -- 44506
    recipe = AddRecipe(44506, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(375, 375, 375, 380, 390)
    recipe:SetItemFilterType("ENCHANTING_GLOVES")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 5157, 5695, 16725, 18773, 19251, 19252, 19540, 26906, 26954, 26980,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Enchant Boots - Greater Spirit -- 44508
    recipe = AddRecipe(44508, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(410, 410, 420, 430, 440)
    recipe:SetItemFilterType("ENCHANTING_BOOTS")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 5157, 5695, 16725, 18773, 19251, 19252, 19540, 26906, 26954, 26980,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Enchant Chest - Greater Mana Restoration -- 44509
    recipe = AddRecipe(44509, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(420, 420, 430, 440, 450)
    recipe:SetItemFilterType("ENCHANTING_CHEST")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 5157, 5695, 16725, 18773, 19251, 19252, 19540, 26906, 26954, 26980,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Enchant Weapon - Exceptional Spirit -- 44510
    recipe = AddRecipe(44510, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(410, 410, 420, 430, 440)
    recipe:SetItemFilterType("ENCHANTING_WEAPON")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 5157, 5695, 16725, 18773, 19251, 19252, 19540, 26906, 26954, 26980,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Enchant Gloves - Greater Assault -- 44513
    recipe = AddRecipe(44513, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(395, 395, 405, 415, 425)
    recipe:SetItemFilterType("ENCHANTING_GLOVES")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 5157, 5695, 16725, 18773, 19251, 19252, 19540, 26906, 26954, 26980,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Enchant Weapon - Icebreaker -- 44524
    recipe = AddRecipe(44524, V.WOTLK, Q.RARE)
    recipe:SetSkillLevels(425, 425, 435, 445, 455)
    recipe:SetRecipeItem(37344, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENCHANTING_WEAPON")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddVendor(32514)

    -- Enchant Boots - Greater Fortitude -- 44528
    recipe = AddRecipe(44528, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(385, 385, 385, 390, 400)
    recipe:SetItemFilterType("ENCHANTING_BOOTS")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 5157, 5695, 16725, 18773, 19251, 19252, 19540, 26906, 26954, 26980,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Enchant Gloves - Major Agility -- 44529
    recipe = AddRecipe(44529, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(415, 415, 425, 435, 445)
    recipe:SetItemFilterType("ENCHANTING_GLOVES")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 5157, 5695, 16725, 18773, 19251, 19252, 19540, 26906, 26954, 26980,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Enchant Bracer - Exceptional Intellect -- 44555
    recipe = AddRecipe(44555, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(375, 375, 385, 392, 400)
    recipe:SetItemFilterType("ENCHANTING_BRACER")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 5157, 5695, 16725, 18773, 19251, 19252, 19540, 26906, 26954, 26980,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Enchant Bracer - Greater Assault -- 44575
    recipe = AddRecipe(44575, V.WOTLK, Q.UNCOMMON)
    recipe:SetSkillLevels(430, 430, 440, 450, 460)
    recipe:SetRecipeItem(44484, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENCHANTING_BRACER")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
    recipe:AddVendor(32514)

    -- Enchant Weapon - Lifeward -- 44576
    recipe = AddRecipe(44576, V.WOTLK, Q.RARE)
    recipe:SetSkillLevels(425, 425, 435, 445, 455)
    recipe:SetRecipeItem(44494, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENCHANTING_WEAPON")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddVendor(32514)

    -- Enchant Cloak - Minor Power -- 44582
    recipe = AddRecipe(44582, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(395, 395, 395, 402, 410)
    recipe:SetItemFilterType("ENCHANTING_CLOAK")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.CASTER)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 5157, 5695, 16725, 18773, 19251, 19252, 19540, 26906, 26954, 26980,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Enchant Boots - Greater Vitality -- 44584
    recipe = AddRecipe(44584, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(405, 405, 415, 425, 435)
    recipe:SetItemFilterType("ENCHANTING_BOOTS")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 5157, 5695, 16725, 18773, 19251, 19252, 19540, 26906, 26954, 26980,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Enchant Chest - Exceptional Resilience -- 44588
    recipe = AddRecipe(44588, V.WOTLK, Q.UNCOMMON)
    recipe:SetSkillLevels(410, 410, 435, 445, 455)
    recipe:SetRecipeItem(37340, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENCHANTING_CHEST")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddVendor(32514)

    -- Enchant Boots - Superior Agility -- 44589
    recipe = AddRecipe(44589, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(415, 415, 425, 435, 445)
    recipe:SetItemFilterType("ENCHANTING_BOOTS")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 5157, 5695, 16725, 18773, 19251, 19252, 19540, 26906, 26954, 26980,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Enchant Cloak - Superior Dodge -- 44591
    recipe = AddRecipe(44591, V.WOTLK, Q.UNCOMMON)
    recipe:SetSkillLevels(435, 435, 445, 455, 465)
    recipe:SetRecipeItem(37347, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENCHANTING_CLOAK")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.TANK)
    recipe:AddVendor(32514)

    -- Enchant Gloves - Exceptional Spellpower -- 44592
    recipe = AddRecipe(44592, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(360, 360, 370, 380, 390)
    recipe:SetItemFilterType("ENCHANTING_GLOVES")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 5157, 5695, 16725, 18773, 19251, 19252, 19540, 26906, 26954, 26980,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Enchant Bracer - Major Spirit -- 44593
    recipe = AddRecipe(44593, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(420, 420, 430, 440, 450)
    recipe:SetItemFilterType("ENCHANTING_BRACER")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 5157, 5695, 16725, 18773, 19251, 19252, 19540, 26906, 26954, 26980,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Enchant 2H Weapon - Scourgebane -- 44595
    recipe = AddRecipe(44595, V.WOTLK, Q.RARE)
    recipe:SetSkillLevels(430, 430, 440, 450, 460)
    recipe:SetRecipeItem(44473, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(44473, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENCHANTING_2H_WEAPON")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddVendor(32514)

    -- Enchant Bracer - Expertise -- 44598
    recipe = AddRecipe(44598, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(415, 415, 425, 435, 445)
    recipe:SetItemFilterType("ENCHANTING_BRACER")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.TANK)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 5157, 5695, 16725, 18773, 19251, 19252, 19540, 26906, 26954, 26980,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Enchant Bracer - Greater Stats -- 44616
    recipe = AddRecipe(44616, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(400, 400, 410, 420, 430)
    recipe:SetItemFilterType("ENCHANTING_BRACER")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 5157, 5695, 16725, 18773, 19251, 19252, 19540, 26906, 26954, 26980,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Enchant Weapon - Giant Slayer -- 44621
    recipe = AddRecipe(44621, V.WOTLK, Q.RARE)
    recipe:SetSkillLevels(430, 430, 440, 450, 460)
    recipe:SetRecipeItem(37339, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENCHANTING_WEAPON")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddVendor(32514)

    -- Enchant Chest - Super Stats -- 44623
    recipe = AddRecipe(44623, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(370, 370, 380, 390, 400)
    recipe:SetItemFilterType("ENCHANTING_CHEST")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 5157, 5695, 16725, 18773, 19251, 19252, 19540, 26906, 26954, 26980,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Enchant Gloves - Armsman -- 44625
    recipe = AddRecipe(44625, V.WOTLK, Q.UNCOMMON)
    recipe:SetSkillLevels(435, 435, 445, 455, 465)
    recipe:SetRecipeItem(44485, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENCHANTING_GLOVES")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.TANK)
    recipe:AddVendor(32514)

    -- Enchant Weapon - Exceptional Spellpower -- 44629
    recipe = AddRecipe(44629, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(395, 395, 405, 415, 425)
    recipe:SetItemFilterType("ENCHANTING_WEAPON")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 5157, 5695, 16725, 18773, 19251, 19252, 19540, 26906, 26954, 26980,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Enchant 2H Weapon - Greater Savagery -- 44630
    recipe = AddRecipe(44630, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(390, 390, 400, 410, 420)
    recipe:SetItemFilterType("ENCHANTING_2H_WEAPON")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 5157, 5695, 16725, 18773, 19251, 19252, 19540, 26906, 26954, 26980,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Enchant Cloak - Shadow Armor -- 44631
    recipe = AddRecipe(44631, V.WOTLK, Q.UNCOMMON)
    recipe:SetSkillLevels(440, 440, 450, 460, 470)
    recipe:SetRecipeItem(37349, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENCHANTING_CLOAK")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.TANK)
    recipe:AddVendor(32514)

    -- Enchant Weapon - Exceptional Agility -- 44633
    recipe = AddRecipe(44633, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(410, 410, 420, 430, 440)
    recipe:SetItemFilterType("ENCHANTING_WEAPON")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 5157, 5695, 16725, 18773, 19251, 19252, 19540, 26906, 26954, 26980,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Enchant Bracer - Greater Spellpower -- 44635
    recipe = AddRecipe(44635, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(395, 395, 405, 415, 425)
    recipe:SetItemFilterType("ENCHANTING_BRACER")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 5157, 5695, 16725, 18773, 19251, 19252, 19540, 26906, 26954, 26980,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Enchant Ring - Lesser Intellect -- 44636
    recipe = AddRecipe(44636, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(400, 400, 400, 407, 415)
    recipe:SetItemFilterType("ENCHANTING_RING")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 5157, 5695, 16725, 18773, 19251, 19252, 19540, 26906, 26954, 26980,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Enchant Ring - Assault -- 44645
    recipe = AddRecipe(44645, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(400, 400, 400, 407, 415)
    recipe:SetItemFilterType("ENCHANTING_RING")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 5157, 5695, 16725, 18773, 19251, 19252, 19540, 26906, 26954, 26980,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Enchant Chest - Dodge -- 46594
    recipe = AddRecipe(46594, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(360, 360, 370, 385, 400)
    recipe:SetRecipeItem(35500, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENCHANTING_CHEST")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.TANK, F.SHATTEREDSUN)
    recipe:AddRepVendor(FAC.SHATTERED_SUN_OFFENSIVE, REP.HONORED, 25032)

    -- Enchant Cloak - Mighty Stamina -- 47672
    recipe = AddRecipe(47672, V.WOTLK, Q.UNCOMMON)
    recipe:SetSkillLevels(430, 430, 440, 450, 460)
    recipe:SetRecipeItem(44471, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENCHANTING_CLOAK")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddVendor(32514)

    -- Enchant Chest - Greater Dodge -- 47766
    recipe = AddRecipe(47766, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(400, 400, 410, 420, 430)
    recipe:SetItemFilterType("ENCHANTING_CHEST")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.TANK)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 5157, 5695, 16725, 18773, 19251, 19252, 19540, 26906, 26954, 26980,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Enchant Cloak - Greater Speed -- 47898
    recipe = AddRecipe(47898, V.WOTLK, Q.UNCOMMON)
    recipe:SetSkillLevels(430, 430, 440, 450, 460)
    recipe:SetRecipeItem(44472, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENCHANTING_CLOAK")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
    recipe:AddVendor(32514)

    -- Enchant Cloak - Wisdom -- 47899
    recipe = AddRecipe(47899, V.WOTLK, Q.UNCOMMON)
    recipe:SetSkillLevels(440, 440, 450, 460, 470)
    recipe:SetRecipeItem(44488, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENCHANTING_CLOAK")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddVendor(32514)

    -- Enchant Chest - Super Health -- 47900
    recipe = AddRecipe(47900, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(425, 425, 435, 445, 455)
    recipe:SetItemFilterType("ENCHANTING_CHEST")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 5157, 5695, 16725, 18773, 19251, 19252, 19540, 26906, 26954, 26980,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Enchant Boots - Tuskarr's Vitality -- 47901
    recipe = AddRecipe(47901, V.WOTLK, Q.UNCOMMON)
    recipe:SetSkillLevels(440, 440, 450, 460, 470)
    recipe:SetRecipeItem(44491, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENCHANTING_BOOTS")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddVendor(32514)

    -- Enchant Weapon - Accuracy -- 59619
    recipe = AddRecipe(59619, V.WOTLK, Q.RARE)
    recipe:SetSkillLevels(440, 440, 450, 460, 470)
    recipe:SetRecipeItem(44496, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENCHANTING_WEAPON")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.CASTER)
    recipe:AddVendor(32514)

    -- Enchant Weapon - Berserking -- 59621
    recipe = AddRecipe(59621, V.WOTLK, Q.RARE)
    recipe:SetSkillLevels(440, 440, 450, 460, 470)
    recipe:SetRecipeItem(44492, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENCHANTING_WEAPON")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
    recipe:AddVendor(32514)

    -- Enchant Weapon - Black Magic -- 59625
    recipe = AddRecipe(59625, V.WOTLK, Q.RARE)
    recipe:SetSkillLevels(440, 440, 450, 460, 470)
    recipe:SetRecipeItem(44495, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENCHANTING_WEAPON")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddVendor(32514)

    -- Enchant Ring - Lesser Stamina -- 59636
    recipe = AddRecipe(59636, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(400, 400, 400, 407, 415)
    recipe:SetItemFilterType("ENCHANTING_RING")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 5157, 5695, 16725, 18773, 19251, 19252, 19540, 26906, 26954, 26980,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Enchant Boots - Assault -- 60606
    recipe = AddRecipe(60606, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(375, 375, 385, 395, 405)
    recipe:SetItemFilterType("ENCHANTING_BOOTS")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 5157, 5695, 16725, 18773, 19251, 19252, 19540, 26906, 26954, 26980,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Enchant Cloak - Speed -- 60609
    recipe = AddRecipe(60609, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(350, 350, 360, 370, 380)
    recipe:SetItemFilterType("ENCHANTING_CLOAK")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 5157, 5695, 16725, 18773, 19251, 19252, 19540, 26906, 26954, 26980,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Enchant Bracer - Assault -- 60616
    recipe = AddRecipe(60616, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(360, 360, 370, 380, 390)
    recipe:SetItemFilterType("ENCHANTING_BRACER")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 5157, 5695, 16725, 18773, 19251, 19252, 19540, 26906, 26954, 26980,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Enchant Weapon - Greater Potency -- 60621
    recipe = AddRecipe(60621, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(380, 380, 390, 400, 410)
    recipe:SetItemFilterType("ENCHANTING_WEAPON")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 5157, 5695, 16725, 18773, 19251, 19252, 19540, 26906, 26954, 26980,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Enchant Boots - Icewalker -- 60623
    recipe = AddRecipe(60623, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(385, 385, 395, 405, 415)
    recipe:SetItemFilterType("ENCHANTING_BOOTS")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 5157, 5695, 16725, 18773, 19251, 19252, 19540, 26906, 26954, 26980,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Enchant Shield - Greater Intellect -- 60653
    recipe = AddRecipe(60653, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(395, 395, 405, 415, 425)
    recipe:SetItemFilterType("ENCHANTING_SHIELD")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 5157, 5695, 16725, 18773, 19251, 19252, 19540, 26906, 26954, 26980,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Enchant Cloak - Major Agility -- 60663
    recipe = AddRecipe(60663, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(420, 420, 430, 440, 450)
    recipe:SetItemFilterType("ENCHANTING_CLOAK")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 5157, 5695, 16725, 18773, 19251, 19252, 19540, 26906, 26954, 26980,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Enchant Gloves - Crusher -- 60668
    recipe = AddRecipe(60668, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(425, 425, 435, 445, 455)
    recipe:SetItemFilterType("ENCHANTING_GLOVES")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 5157, 5695, 16725, 18773, 19251, 19252, 19540, 26906, 26954, 26980,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Enchant 2H Weapon - Massacre -- 60691
    recipe = AddRecipe(60691, V.WOTLK, Q.RARE)
    recipe:SetSkillLevels(430, 430, 440, 450, 460)
    recipe:SetRecipeItem(44483, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENCHANTING_2H_WEAPON")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
    recipe:AddVendor(32514)

    -- Enchant Chest - Powerful Stats -- 60692
    recipe = AddRecipe(60692, V.WOTLK, Q.UNCOMMON)
    recipe:SetSkillLevels(440, 440, 450, 460, 470)
    recipe:SetRecipeItem(44489, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENCHANTING_CHEST")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddVendor(32514)

    -- Enchant Weapon - Superior Potency -- 60707
    recipe = AddRecipe(60707, V.WOTLK, Q.RARE)
    recipe:SetSkillLevels(435, 435, 445, 455, 465)
    recipe:SetRecipeItem(44486, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENCHANTING_WEAPON")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
    recipe:AddVendor(32514)

    -- Enchant Weapon - Mighty Spellpower -- 60714
    recipe = AddRecipe(60714, V.WOTLK, Q.RARE)
    recipe:SetSkillLevels(435, 435, 445, 455, 465)
    recipe:SetRecipeItem(44487, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENCHANTING_WEAPON")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddVendor(32514)

    -- Enchant Boots - Greater Assault -- 60763
    recipe = AddRecipe(60763, V.WOTLK, Q.UNCOMMON)
    recipe:SetSkillLevels(440, 440, 450, 460, 470)
    recipe:SetRecipeItem(44490, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENCHANTING_BOOTS")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
    recipe:AddVendor(32514)

    -- Enchant Bracer - Superior Spellpower -- 60767
    recipe = AddRecipe(60767, V.WOTLK, Q.UNCOMMON)
    recipe:SetSkillLevels(440, 440, 450, 460, 470)
    recipe:SetRecipeItem(44498, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(44498, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENCHANTING_BRACER")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddVendor(32514)

    -- Enchant Bracer - Major Stamina -- 62256
    recipe = AddRecipe(62256, V.WOTLK, Q.RARE)
    recipe:SetSkillLevels(450, 450, 460, 470, 480)
    recipe:SetRecipeItem(44944, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(44944, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENCHANTING_BRACER")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddVendor(32514)

    -- Enchant Staff - Greater Spellpower -- 62948
    recipe = AddRecipe(62948, V.WOTLK, Q.RARE)
    recipe:SetSkillLevels(450, 450, 455, 460, 465)
    recipe:SetRecipeItem(45059, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENCHANTING_STAFF")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddVendor(32514)

    -- Enchant Staff - Spellpower -- 62959
    recipe = AddRecipe(62959, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(385, 385, 395, 405, 415)
    recipe:SetItemFilterType("ENCHANTING_STAFF")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 5157, 5695, 16725, 18773, 19251, 19252, 19540, 26906, 26954, 26980,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Enchant Boots - Lesser Accuracy -- 63746
    recipe = AddRecipe(63746, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(225, 225, 245, 265, 285)
    recipe:SetItemFilterType("ENCHANTING_BOOTS")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 7949, 11072, 11073, 11074, 16160, 16633, 16725,
        18753, 18773, 19251, 19252, 19540, 26906, 26990, 28693, 33583, 33610, 33633, 33676, 53410, 65127)

    -- Enchant Weapon - Blade Ward -- 64441
    recipe = AddRecipe(64441, V.WOTLK, Q.EPIC)
    recipe:SetSkillLevels(450, 450, 455, 460, 465)
    recipe:SetRecipeItem(46027, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENCHANTING_WEAPON")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.RAID, F.TANK)
    recipe:AddWorldDrop(Z.ULDUAR)

    -- Enchant Weapon - Blood Draining -- 64579
    recipe = AddRecipe(64579, V.WOTLK, Q.EPIC)
    recipe:SetSkillLevels(450, 450, 455, 460, 465)
    recipe:SetRecipeItem(46348, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENCHANTING_WEAPON")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.RAID)
    recipe:AddWorldDrop(Z.ULDUAR)

    -- Abyssal Shatter -- 69412
    recipe = AddRecipe(69412, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(390, 390, 400, 405, 410)
    recipe:SetCraftedItem(89738, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENCHANTING_MISC")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 4213, 5695, 16725, 18773, 26906, 26954, 26980, 28693, 33583, 33610, 33633, 53410,
        65127)

    -- Enchant Gloves - Angler -- 71692
    recipe = AddRecipe(71692, V.WOTLK, Q.UNCOMMON)
    recipe:SetSkillLevels(375, 375, 385, 392, 400)
    recipe:SetRecipeItem(50406, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENCHANTING_GLOVES")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddMobDrop(26336, 26343, 26344)

    -------------------------------------------------------------------------------
    -- Cataclysm.
    -------------------------------------------------------------------------------
    -- Enchant Gloves - Mastery -- 74132
    recipe = AddRecipe(74132, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(425, 425, 440, 450, 460)
    recipe:SetItemFilterType("ENCHANTING_GLOVES")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 16633, 16725, 18773, 19251, 19252, 19540, 26906,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Enchant Boots - Earthen Vitality -- 74189
    recipe = AddRecipe(74189, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(425, 425, 440, 450, 460)
    recipe:SetItemFilterType("ENCHANTING_BOOTS")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 16633, 16725, 18773, 19251, 19252, 19540, 26906,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Enchant Chest - Mighty Stats -- 74191
    recipe = AddRecipe(74191, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(425, 425, 440, 450, 460)
    recipe:SetItemFilterType("ENCHANTING_CHEST")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 16633, 16725, 18773, 19251, 19252, 19540, 26906,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Enchant Cloak - Lesser Power -- 74192
    recipe = AddRecipe(74192, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(435, 435, 450, 460, 470)
    recipe:SetItemFilterType("ENCHANTING_CLOAK")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 16633, 16725, 18773, 19251, 19252, 19540, 26906,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Enchant Bracer - Speed -- 74193
    recipe = AddRecipe(74193, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(435, 435, 450, 460, 470)
    recipe:SetItemFilterType("ENCHANTING_BRACER")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 16633, 16725, 18773, 19251, 19252, 19540, 26906,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Enchant Weapon - Mending -- 74195
    recipe = AddRecipe(74195, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(450, 450, 460, 462, 465)
    recipe:SetItemFilterType("ENCHANTING_WEAPON")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 16633, 16725, 18773, 19251, 19252, 19540, 26906,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Enchant Weapon - Avalanche -- 74197
    recipe = AddRecipe(74197, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(450, 450, 460, 462, 465)
    recipe:SetItemFilterType("ENCHANTING_WEAPON")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 16633, 16725, 18773, 19251, 19252, 19540, 26906,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Enchant Gloves - Haste -- 74198
    recipe = AddRecipe(74198, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(455, 455, 465, 475, 485)
    recipe:SetItemFilterType("ENCHANTING_GLOVES")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 16633, 16725, 18773, 19251, 19252, 19540, 26906,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Enchant Boots - Haste -- 74199
    recipe = AddRecipe(74199, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(455, 455, 465, 475, 485)
    recipe:SetItemFilterType("ENCHANTING_BOOTS")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 16633, 16725, 18773, 19251, 19252, 19540, 26906,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Enchant Chest - Stamina -- 74200
    recipe = AddRecipe(74200, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(460, 460, 470, 480, 490)
    recipe:SetItemFilterType("ENCHANTING_CHEST")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 16633, 16725, 18773, 19251, 19252, 19540, 26906,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Enchant Bracer - Critical Strike -- 74201
    recipe = AddRecipe(74201, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(460, 460, 470, 480, 490)
    recipe:SetItemFilterType("ENCHANTING_BRACER")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 16633, 16725, 18773, 19251, 19252, 19540, 26906,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Enchant Cloak - Intellect -- 74202
    recipe = AddRecipe(74202, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(465, 465, 475, 485, 495)
    recipe:SetItemFilterType("ENCHANTING_CLOAK")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 16633, 16725, 18773, 19251, 19252, 19540, 26906,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Enchant Shield - Protection -- 74207
    recipe = AddRecipe(74207, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(465, 465, 475, 485, 495)
    recipe:SetItemFilterType("ENCHANTING_SHIELD")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 16633, 16725, 18773, 19251, 19252, 19540, 26906,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Enchant Weapon - Elemental Slayer -- 74211
    recipe = AddRecipe(74211, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(470, 470, 480, 490, 500)
    recipe:SetItemFilterType("ENCHANTING_WEAPON")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 16633, 16725, 18773, 19251, 19252, 19540, 26906,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Enchant Gloves - Exceptional Strength -- 74212
    recipe = AddRecipe(74212, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(470, 470, 480, 490, 500)
    recipe:SetItemFilterType("ENCHANTING_GLOVES")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 16633, 16725, 18773, 19251, 19252, 19540, 26906,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Enchant Boots - Major Agility -- 74213
    recipe = AddRecipe(74213, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(475, 475, 485, 495, 505)
    recipe:SetItemFilterType("ENCHANTING_BOOTS")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 16633, 16725, 18773, 19251, 19252, 19540, 26906,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Enchant Chest - Mighty Resilience -- 74214
    recipe = AddRecipe(74214, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(475, 475, 485, 495, 505)
    recipe:SetItemFilterType("ENCHANTING_CHEST")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 16633, 16725, 18773, 19251, 19252, 19540, 26906,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Enchant Ring - Strength -- 74215
    recipe = AddRecipe(74215, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(475, 475, 475, 475, 495)
    recipe:SetItemFilterType("ENCHANTING_RING")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 16633, 16725, 18773, 19251, 19252, 19540, 26906,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Enchant Ring - Agility -- 74216
    recipe = AddRecipe(74216, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(475, 475, 475, 475, 495)
    recipe:SetItemFilterType("ENCHANTING_RING")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 16633, 16725, 18773, 19251, 19252, 19540, 26906,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Enchant Ring - Intellect -- 74217
    recipe = AddRecipe(74217, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(475, 475, 475, 475, 495)
    recipe:SetItemFilterType("ENCHANTING_RING")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 16633, 16725, 18773, 19251, 19252, 19540, 26906,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Enchant Ring - Stamina -- 74218
    recipe = AddRecipe(74218, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(475, 475, 475, 475, 495)
    recipe:SetItemFilterType("ENCHANTING_RING")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 16633, 16725, 18773, 19251, 19252, 19540, 26906,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Enchant Gloves - Greater Expertise -- 74220
    recipe = AddRecipe(74220, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(480, 480, 490, 500, 510)
    recipe:SetItemFilterType("ENCHANTING_GLOVES")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 16633, 16725, 18773, 19251, 19252, 19540, 26906,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Enchant Weapon - Hurricane -- 74223
    recipe = AddRecipe(74223, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(480, 480, 490, 500, 510)
    recipe:SetItemFilterType("ENCHANTING_WEAPON")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 16633, 16725, 18773, 19251, 19252, 19540, 26906,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Enchant Weapon - Heartsong -- 74225
    recipe = AddRecipe(74225, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(485, 485, 495, 505, 515)
    recipe:SetItemFilterType("ENCHANTING_WEAPON")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 16633, 16725, 18773, 19251, 19252, 19540, 26906,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Enchant Shield - Mastery -- 74226
    recipe = AddRecipe(74226, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(485, 485, 495, 505, 515)
    recipe:SetItemFilterType("ENCHANTING_SHIELD")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 16633, 16725, 18773, 19251, 19252, 19540, 26906,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Enchant Bracer - Superior Dodge -- 74229
    recipe = AddRecipe(74229, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(490, 490, 500, 510, 520)
    recipe:SetItemFilterType("ENCHANTING_BRACER")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 16633, 16725, 18773, 19251, 19252, 19540, 26906,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Enchant Cloak - Critical Strike -- 74230
    recipe = AddRecipe(74230, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(490, 490, 500, 510, 520)
    recipe:SetItemFilterType("ENCHANTING_CLOAK")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 16633, 16725, 18773, 19251, 19252, 19540, 26906,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Enchant Chest - Exceptional Spirit -- 74231
    recipe = AddRecipe(74231, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(495, 495, 505, 515, 525)
    recipe:SetItemFilterType("ENCHANTING_CHEST")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 16633, 16725, 18773, 19251, 19252, 19540, 26906,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Enchant Bracer - Precision -- 74232
    recipe = AddRecipe(74232, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(495, 495, 505, 515, 525)
    recipe:SetItemFilterType("ENCHANTING_BRACER")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 16633, 16725, 18773, 19251, 19252, 19540, 26906,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Enchant Cloak - Protection -- 74234
    recipe = AddRecipe(74234, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(500, 500, 510, 520, 530)
    recipe:SetItemFilterType("ENCHANTING_CLOAK")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 16633, 16725, 18773, 19251, 19252, 19540, 26906,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Enchant Off-Hand - Superior Intellect -- 74235
    recipe = AddRecipe(74235, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(500, 500, 510, 520, 530)
    recipe:SetItemFilterType("ENCHANTING_MISC")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 16633, 16725, 18773, 19251, 19252, 19540, 26906,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Enchant Boots - Precision -- 74236
    recipe = AddRecipe(74236, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(505, 505, 510, 512, 515)
    recipe:SetItemFilterType("ENCHANTING_BOOTS")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 16633, 16725, 18773, 19251, 19252, 19540, 26906,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Enchant Bracer - Exceptional Spirit -- 74237
    recipe = AddRecipe(74237, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(505, 505, 515, 525, 535)
    recipe:SetItemFilterType("ENCHANTING_BRACER")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 16633, 16725, 18773, 19251, 19252, 19540, 26906,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Enchant Boots - Mastery -- 74238
    recipe = AddRecipe(74238, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(510, 510, 520, 530, 540)
    recipe:SetItemFilterType("ENCHANTING_BOOTS")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 16633, 16725, 18773, 19251, 19252, 19540, 26906,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Enchant Bracer - Greater Expertise -- 74239
    recipe = AddRecipe(74239, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(510, 510, 520, 530, 540)
    recipe:SetItemFilterType("ENCHANTING_BRACER")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 16633, 16725, 18773, 19251, 19252, 19540, 26906,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Enchant Cloak - Greater Intellect -- 74240
    recipe = AddRecipe(74240, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(510, 510, 520, 530, 540)
    recipe:SetItemFilterType("ENCHANTING_CLOAK")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 16633, 16725, 18773, 19251, 19252, 19540, 26906,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Enchant Weapon - Power Torrent -- 74242
    recipe = AddRecipe(74242, V.CATA, Q.RARE)
    recipe:SetSkillLevels(525, 525, 525, 532, 540)
    recipe:SetRecipeItem(52733, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENCHANTING_WEAPON")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddVendor(1318, 3012, 3346, 4228, 4617, 5158, 16635, 16722, 50134, 50146)

    -- Enchant Weapon - Windwalk -- 74244
    recipe = AddRecipe(74244, V.CATA, Q.RARE)
    recipe:SetSkillLevels(525, 525, 525, 532, 540)
    recipe:SetRecipeItem(52735, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENCHANTING_WEAPON")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddVendor(1318, 3012, 3346, 4228, 4617, 5158, 16635, 16722, 50134, 50146)

    -- Enchant Weapon - Landslide -- 74246
    recipe = AddRecipe(74246, V.CATA, Q.RARE)
    recipe:SetSkillLevels(525, 525, 525, 532, 540)
    recipe:SetRecipeItem(52736, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENCHANTING_WEAPON")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddVendor(1318, 3012, 3346, 4228, 4617, 5158, 16635, 16722, 50134, 50146)

    -- Enchant Cloak - Greater Critical Strike -- 74247
    recipe = AddRecipe(74247, V.CATA, Q.UNCOMMON)
    recipe:SetSkillLevels(525, 525, 525, 532, 540)
    recipe:SetRecipeItem(52737, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENCHANTING_CLOAK")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
    recipe:AddVendor(1318, 3012, 3346, 4228, 4617, 5158, 16635, 16722, 50134, 50146)

    -- Enchant Bracer - Greater Critical Strike -- 74248
    recipe = AddRecipe(74248, V.CATA, Q.UNCOMMON)
    recipe:SetSkillLevels(525, 525, 525, 532, 540)
    recipe:SetRecipeItem(52738, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENCHANTING_BRACER")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
    recipe:AddVendor(1318, 3012, 3346, 4228, 4617, 5158, 16635, 16722, 50134, 50146)

    -- Enchant Chest - Peerless Stats -- 74250
    recipe = AddRecipe(74250, V.CATA, Q.UNCOMMON)
    recipe:SetSkillLevels(525, 525, 525, 532, 540)
    recipe:SetRecipeItem(52739, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENCHANTING_CHEST")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddVendor(1318, 3012, 3346, 4228, 4617, 5158, 16635, 16722, 50134, 50146)

    -- Enchant Chest - Greater Stamina -- 74251
    recipe = AddRecipe(74251, V.CATA, Q.UNCOMMON)
    recipe:SetSkillLevels(525, 525, 525, 532, 540)
    recipe:SetRecipeItem(52740, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENCHANTING_CHEST")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddVendor(1318, 3012, 3346, 4228, 4617, 5158, 16635, 16722, 50134, 50146)

    -- Enchant Boots - Assassin's Step -- 74252
    recipe = AddRecipe(74252, V.CATA, Q.UNCOMMON)
    recipe:SetSkillLevels(525, 525, 525, 532, 540)
    recipe:SetRecipeItem(64411, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENCHANTING_BOOTS")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
    recipe:AddVendor(1318, 3012, 3346, 4228, 4617, 5158, 16635, 16722, 50134, 50146)

    -- Enchant Boots - Lavawalker -- 74253
    recipe = AddRecipe(74253, V.CATA, Q.UNCOMMON)
    recipe:SetSkillLevels(525, 525, 525, 532, 540)
    recipe:SetRecipeItem(64412, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENCHANTING_BOOTS")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddVendor(1318, 3012, 3346, 4228, 4617, 5158, 16635, 16722, 50134, 50146)

    -- Enchant Gloves - Mighty Strength -- 74254
    recipe = AddRecipe(74254, V.CATA, Q.UNCOMMON)
    recipe:SetSkillLevels(525, 525, 525, 532, 540)
    recipe:SetRecipeItem(64415, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(64415, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENCHANTING_GLOVES")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
    recipe:AddVendor(1318, 3012, 3346, 4228, 4617, 5158, 16635, 16722, 50134, 50146)

    -- Enchant Gloves - Greater Mastery -- 74255
    recipe = AddRecipe(74255, V.CATA, Q.UNCOMMON)
    recipe:SetSkillLevels(525, 525, 525, 532, 540)
    recipe:SetRecipeItem(64414, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENCHANTING_GLOVES")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddVendor(1318, 3012, 3346, 4228, 4617, 5158, 16635, 16722, 50134, 50146)

    -- Enchant Bracer - Greater Speed -- 74256
    recipe = AddRecipe(74256, V.CATA, Q.UNCOMMON)
    recipe:SetSkillLevels(525, 525, 525, 532, 540)
    recipe:SetRecipeItem(64413, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENCHANTING_BRACER")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
    recipe:AddVendor(1318, 3012, 3346, 4228, 4617, 5158, 16635, 16722, 50134, 50146)

    -- Enchanted Lantern -- 93841
    recipe = AddRecipe(93841, V.CATA, Q.RARE)
    recipe:SetSkillLevels(525, 525, 525, 525, 525)
    recipe:SetRecipeItem(67308, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(67308, "BIND_ON_EQUIP")
    recipe:SetRequiredFaction("Horde")
    recipe:SetItemFilterType("ENCHANTING_MISC")
    recipe:AddFilters(F.HORDE)
    recipe:AddVendor(3012, 3346, 4617, 16635, 50146)

    -- Magic Lamp -- 93843
    recipe = AddRecipe(93843, V.CATA, Q.RARE)
    recipe:SetSkillLevels(525, 525, 525, 525, 525)
    recipe:SetRecipeItem(67312, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(67312, "BIND_ON_EQUIP")
    recipe:SetRequiredFaction("Alliance")
    recipe:SetItemFilterType("ENCHANTING_MISC")
    recipe:AddFilters(F.ALLIANCE)
    recipe:AddVendor(1318, 4228, 5158, 16722, 50134)

    -- Enchant 2H Weapon - Mighty Agility -- 95471
    recipe = AddRecipe(95471, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(470, 470, 480, 490, 500)
    recipe:SetItemFilterType("ENCHANTING_2H_WEAPON")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 16633, 16725, 18773, 19251, 19252, 19540, 26906,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Enchant Bracer - Major Strength -- 96261
    recipe = AddRecipe(96261, V.CATA, Q.RARE)
    recipe:SetSkillLevels(515, 515, 525, 532, 540)
    recipe:SetRecipeItem(68788, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENCHANTING_BRACER")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
    recipe:AddWorldDrop(Z.DEEPHOLM, Z.EASTERN_KINGDOMS, Z.KALIMDOR)

    -- Enchant Bracer - Mighty Intellect -- 96262
    recipe = AddRecipe(96262, V.CATA, Q.RARE)
    recipe:SetSkillLevels(515, 515, 525, 532, 540)
    recipe:SetRecipeItem(68789, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENCHANTING_BRACER")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddWorldDrop(Z.DEEPHOLM, Z.EASTERN_KINGDOMS, Z.KALIMDOR)

    -- Enchant Bracer - Agility -- 96264
    recipe = AddRecipe(96264, V.CATA, Q.RARE)
    recipe:SetSkillLevels(515, 515, 525, 532, 540)
    recipe:SetRecipeItem(68787, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENCHANTING_BRACER")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
    recipe:AddWorldDrop(Z.DEEPHOLM, Z.EASTERN_KINGDOMS, Z.KALIMDOR)

    -- Maelstrom Shatter -- 104698
    recipe = AddRecipe(104698, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(515, 515, 525, 530, 535)
    recipe:SetItemFilterType("ENCHANTING_MISC")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 4213, 5695, 33583, 53410, 65127)

    -------------------------------------------------------------------------------
    -- Mists of Pandaria.
    -------------------------------------------------------------------------------
    -- Enchant Ring - Greater Agility -- 103461
    recipe = AddRecipe(103461, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(550, 550, 560, 565, 570)
    recipe:SetItemFilterType("ENCHANTING_RING")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 16633, 16725, 18773, 19251, 19252, 19540, 26906,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Enchant Ring - Greater Intellect -- 103462
    recipe = AddRecipe(103462, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(550, 550, 560, 565, 570)
    recipe:SetItemFilterType("ENCHANTING_RING")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 16633, 16725, 18773, 19251, 19252, 19540, 26906,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Enchant Ring - Greater Stamina -- 103463
    recipe = AddRecipe(103463, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(550, 550, 560, 565, 570)
    recipe:SetItemFilterType("ENCHANTING_RING")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 16633, 16725, 18773, 19251, 19252, 19540, 26906,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Enchant Ring - Greater Strength -- 103465
    recipe = AddRecipe(103465, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(550, 550, 560, 565, 570)
    recipe:SetItemFilterType("ENCHANTING_RING")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 16633, 16725, 18773, 19251, 19252, 19540, 26906,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Enchant Bracer - Mastery -- 104338
    recipe = AddRecipe(104338, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(500, 500, 510, 515, 520)
    recipe:SetItemFilterType("ENCHANTING_BRACER")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 16633, 16725, 18773, 19251, 19252, 19540, 26906,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Enchant Bracer - Major Dodge -- 104385
    recipe = AddRecipe(104385, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(525, 525, 535, 540, 545)
    recipe:SetItemFilterType("ENCHANTING_BRACER")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 16633, 16725, 18773, 19251, 19252, 19540, 26906,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Enchant Bracer - Super Intellect -- 104389
    recipe = AddRecipe(104389, V.MOP, Q.RARE)
    recipe:SetSkillLevels(600, 600, 600, 600, 615)
    recipe:SetRecipeItem(84559, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENCHANTING_BRACER")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER, F.AUGUSTCELESTIALS)
    recipe:AddRepVendor(FAC.THE_AUGUST_CELESTIALS, REP.REVERED, 64001, 64032)

    -- Enchant Bracer - Exceptional Strength -- 104390
    recipe = AddRecipe(104390, V.MOP, Q.RARE)
    recipe:SetSkillLevels(600, 600, 600, 600, 615)
    recipe:SetRecipeItem(84561, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENCHANTING_BRACER")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.AUGUSTCELESTIALS)
    recipe:AddRepVendor(FAC.THE_AUGUST_CELESTIALS, REP.REVERED, 64001, 64032)

    -- Enchant Bracer - Greater Agility -- 104391
    recipe = AddRecipe(104391, V.MOP, Q.RARE)
    recipe:SetSkillLevels(600, 600, 600, 600, 615)
    recipe:SetRecipeItem(84557, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENCHANTING_BRACER")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.AUGUSTCELESTIALS)
    recipe:AddRepVendor(FAC.THE_AUGUST_CELESTIALS, REP.REVERED, 64001, 64032)

    -- Enchant Chest - Super Resilience -- 104392
    recipe = AddRecipe(104392, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(525, 525, 535, 540, 545)
    recipe:SetItemFilterType("ENCHANTING_CHEST")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 16633, 16725, 18773, 19251, 19252, 19540, 26906,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Enchant Chest - Mighty Spirit -- 104393
    recipe = AddRecipe(104393, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(525, 525, 535, 540, 545)
    recipe:SetItemFilterType("ENCHANTING_CHEST")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 16633, 16725, 18773, 19251, 19252, 19540, 26906,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Enchant Chest - Glorious Stats -- 104395
    recipe = AddRecipe(104395, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(575, 575, 585, 590, 595)
    recipe:SetItemFilterType("ENCHANTING_CHEST")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 16633, 16725, 18773, 19251, 19252, 19540, 26906,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Enchant Chest - Superior Stamina -- 104397
    recipe = AddRecipe(104397, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(550, 550, 560, 565, 570)
    recipe:SetItemFilterType("ENCHANTING_CHEST")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 16633, 16725, 18773, 19251, 19252, 19540, 26906,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Enchant Cloak - Accuracy -- 104398
    recipe = AddRecipe(104398, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(550, 550, 560, 565, 570)
    recipe:SetItemFilterType("ENCHANTING_CLOAK")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 16633, 16725, 18773, 19251, 19252, 19540, 26906,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Enchant Cloak - Greater Protection -- 104401
    recipe = AddRecipe(104401, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(575, 575, 585, 590, 595)
    recipe:SetItemFilterType("ENCHANTING_CLOAK")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 16633, 16725, 18773, 19251, 19252, 19540, 26906,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Enchant Cloak - Superior Intellect -- 104403
    recipe = AddRecipe(104403, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(525, 525, 535, 540, 545)
    recipe:SetItemFilterType("ENCHANTING_CLOAK")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 16633, 16725, 18773, 19251, 19252, 19540, 26906,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Enchant Cloak - Superior Critical Strike -- 104404
    recipe = AddRecipe(104404, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(500, 500, 510, 515, 520)
    recipe:SetItemFilterType("ENCHANTING_CLOAK")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 16633, 16725, 18773, 19251, 19252, 19540, 26906,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Enchant Boots - Greater Haste -- 104407
    recipe = AddRecipe(104407, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(550, 550, 560, 565, 570)
    recipe:SetItemFilterType("ENCHANTING_BOOTS")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 16633, 16725, 18773, 19251, 19252, 19540, 26906,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Enchant Boots - Greater Precision -- 104408
    recipe = AddRecipe(104408, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(525, 525, 535, 540, 545)
    recipe:SetItemFilterType("ENCHANTING_BOOTS")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 16633, 16725, 18773, 19251, 19252, 19540, 26906,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Enchant Boots - Blurred Speed -- 104409
    recipe = AddRecipe(104409, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(550, 550, 560, 565, 570)
    recipe:SetItemFilterType("ENCHANTING_BOOTS")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 16633, 16725, 18773, 19251, 19252, 19540, 26906,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Enchant Boots - Pandaren's Step -- 104414
    recipe = AddRecipe(104414, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(575, 575, 585, 590, 595)
    recipe:SetItemFilterType("ENCHANTING_BOOTS")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 16633, 16725, 18773, 19251, 19252, 19540, 26906,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Enchant Gloves - Greater Haste -- 104416
    recipe = AddRecipe(104416, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(525, 525, 535, 540, 545)
    recipe:SetItemFilterType("ENCHANTING_GLOVES")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 16633, 16725, 18773, 19251, 19252, 19540, 26906,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Enchant Gloves - Superior Expertise -- 104417
    recipe = AddRecipe(104417, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(550, 550, 560, 565, 570)
    recipe:SetItemFilterType("ENCHANTING_GLOVES")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 16633, 16725, 18773, 19251, 19252, 19540, 26906,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Enchant Gloves - Super Strength -- 104419
    recipe = AddRecipe(104419, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(575, 575, 585, 590, 595)
    recipe:SetItemFilterType("ENCHANTING_GLOVES")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 16633, 16725, 18773, 19251, 19252, 19540, 26906,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Enchant Gloves - Superior Mastery -- 104420
    recipe = AddRecipe(104420, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(575, 575, 585, 590, 595)
    recipe:SetItemFilterType("ENCHANTING_GLOVES")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 16633, 16725, 18773, 19251, 19252, 19540, 26906,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Enchant Weapon - Windsong -- 104425
    recipe = AddRecipe(104425, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(550, 550, 560, 565, 570)
    recipe:SetItemFilterType("ENCHANTING_WEAPON")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 16633, 16725, 18773, 19251, 19252, 19540, 26906,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Enchant Weapon - Jade Spirit -- 104427
    recipe = AddRecipe(104427, V.MOP, Q.RARE)
    recipe:SetSkillLevels(600, 600, 600, 600, 615)
    recipe:SetRecipeItem(84583, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENCHANTING_WEAPON")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.SHADOPAN)
    recipe:AddRepVendor(FAC.SHADO_PAN, REP.REVERED, 64595)

    -- Enchant Weapon - Elemental Force -- 104430
    recipe = AddRecipe(104430, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(525, 525, 535, 540, 545)
    recipe:SetItemFilterType("ENCHANTING_WEAPON")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 16633, 16725, 18773, 19251, 19252, 19540, 26906,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Enchant Weapon - Dancing Steel -- 104434
    recipe = AddRecipe(104434, V.MOP, Q.RARE)
    recipe:SetSkillLevels(600, 600, 600, 600, 615)
    recipe:SetRecipeItem(84584, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENCHANTING_WEAPON")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.SHADOPAN)
    recipe:AddRepVendor(FAC.SHADO_PAN, REP.REVERED, 64595)

    -- Enchant Weapon - Colossus -- 104440
    recipe = AddRecipe(104440, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(575, 575, 585, 590, 595)
    recipe:SetItemFilterType("ENCHANTING_WEAPON")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 16633, 16725, 18773, 19251, 19252, 19540, 26906,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Enchant Weapon - River's Song -- 104442
    recipe = AddRecipe(104442, V.MOP, Q.RARE)
    recipe:SetSkillLevels(600, 600, 600, 600, 615)
    recipe:SetRecipeItem(84580, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENCHANTING_WEAPON")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.TANK, F.SHADOPAN)
    recipe:AddRepVendor(FAC.SHADO_PAN, REP.REVERED, 64595)

    -- Enchant Off-Hand - Major Intellect -- 104445
    recipe = AddRecipe(104445, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(575, 575, 585, 590, 595)
    recipe:SetItemFilterType("ENCHANTING_MISC")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 16633, 16725, 18773, 19251, 19252, 19540, 26906,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Mysterious Essence -- 116497
    recipe = AddRecipe(116497, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(500, 500, 510, 515, 520)
    recipe:SetItemFilterType("ENCHANTING_MISC")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 16633, 16725, 18773, 19251, 19252, 19540, 26906,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Ethereal Shard -- 116498
    recipe = AddRecipe(116498, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(550, 550, 560, 565, 570)
    recipe:SetItemFilterType("ENCHANTING_MISC")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 16633, 16725, 18773, 19251, 19252, 19540, 26906,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Sha Crystal -- 116499
    recipe = AddRecipe(116499, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(600, 600, 610, 615, 620)
    recipe:SetItemFilterType("ENCHANTING_MISC")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 16633, 16725, 18773, 19251, 19252, 19540, 26906,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Mysterious Diffusion -- 118237
    recipe = AddRecipe(118237, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(535, 535, 545, 550, 555)
    recipe:SetItemFilterType("ENCHANTING_MISC")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 16633, 16725, 18773, 19251, 19252, 19540, 26906,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Ethereal Shatter -- 118238
    recipe = AddRecipe(118238, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(585, 585, 595, 600, 605)
    recipe:SetItemFilterType("ENCHANTING_MISC")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 16633, 16725, 18773, 19251, 19252, 19540, 26906,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Sha Shatter -- 118239
    recipe = AddRecipe(118239, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(600, 600, 610, 615, 620)
    recipe:SetItemFilterType("ENCHANTING_MISC")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 16633, 16725, 18773, 19251, 19252, 19540, 26906,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    -- Enchant Shield - Greater Parry -- 130758
    recipe = AddRecipe(130758, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(575, 575, 585, 590, 595)
    recipe:SetItemFilterType("ENCHANTING_SHIELD")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1317, 3011, 3345, 3606, 4213, 4616, 5157, 5695, 16633, 16725, 18773, 19251, 19252, 19540, 26906,
        26990, 28693, 33583, 33610, 33633, 53410, 65127)

    self.InitializeRecipes = nil
end
