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
    -- Charred Wolf Meat -- 2538
    recipe = AddRecipe(2538, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 45, 65, 85)
    recipe:SetCraftedItem(2679, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MISC1)
    recipe:AddCustom("DEFAULT_RECIPE")

    -- Spiced Wolf Meat -- 2539
    recipe = AddRecipe(2539, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(10, 10, 50, 70, 90)
    recipe:SetCraftedItem(2680, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddTrainer(1355, 1382, 1430, 1699, 2818, 3026, 3067, 3087, 3399, 4210, 4552, 4894, 5159, 5482, 6286, 8306,
        16253, 16277, 16676, 16719, 17246, 18987, 18988, 18993, 19185, 19369, 26905, 26953, 26972, 26989, 28705, 29631,
        33587, 33619, 42288, 42506, 45550, 46709, 47405, 49789, 54232, 66353)

    -- Roasted Boar Meat -- 2540
    recipe = AddRecipe(2540, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 45, 65, 85)
    recipe:SetCraftedItem(2681, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MISC1)
    recipe:AddCustom("DEFAULT_RECIPE")

    -- Coyote Steak -- 2541
    recipe = AddRecipe(2541, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(50, 50, 90, 110, 130)
    recipe:SetCraftedItem(2684, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddTrainer(1355, 1382, 1430, 1699, 2818, 3026, 3067, 3087, 3399, 4210, 4552, 4894, 5159, 5482, 6286, 8306,
        16253, 16277, 16676, 16719, 17246, 18987, 18988, 18993, 19185, 19369, 26905, 26953, 26972, 26989, 28705, 29631,
        33587, 33619, 42288, 42506, 45550, 46709, 47405, 49789, 54232, 66353)

    -- Goretusk Liver Pie -- 2542
    recipe = AddRecipe(2542, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(50, 50, 90, 110, 130)
    recipe:SetRecipeItem(2697, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(724, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HEALER, F.CASTER)
    recipe:AddVendor(340)

    -- Westfall Stew -- 2543
    recipe = AddRecipe(2543, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(50, 50, 115, 135, 155)
    recipe:SetRecipeItem(728, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(733, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE)
    recipe:AddVendor(340)
    recipe:AddWorldDrop(Z.WESTFALL)

    -- Crab Cake -- 2544
    recipe = AddRecipe(2544, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(75, 75, 115, 135, 155)
    recipe:SetCraftedItem(2683, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddTrainer(1355, 1382, 1430, 1699, 2818, 3026, 3067, 3087, 3399, 4210, 4552, 4894, 5159, 5482, 6286, 8306,
        16253, 16277, 16676, 16719, 17246, 18987, 18988, 18993, 19185, 19369, 26905, 26953, 26972, 26989, 28705, 29631,
        33587, 33619, 42288, 42506, 45550, 46709, 47405, 49789, 54232, 66353)

    -- Cooked Crab Claw -- 2545
    recipe = AddRecipe(2545, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(85, 85, 125, 145, 165)
    recipe:SetRecipeItem(2698, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(2682, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddVendor(340)
    recipe:AddWorldDrop(Z.DARKSHORE, Z.WESTFALL)

    -- Dry Pork Ribs -- 2546
    recipe = AddRecipe(2546, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(80, 80, 120, 140, 160)
    recipe:SetCraftedItem(2687, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddTrainer(1355, 1382, 1430, 1699, 2818, 3026, 3067, 3087, 3399, 4210, 4552, 4894, 5159, 5482, 6286, 8306,
        16253, 16277, 16676, 16719, 17246, 18987, 18988, 18993, 19185, 19369, 26905, 26953, 26972, 26989, 28705, 29631,
        33587, 33619, 42288, 42506, 45550, 46709, 47405, 49789, 54232, 66353)

    -- Redridge Goulash -- 2547
    recipe = AddRecipe(2547, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(100, 100, 135, 155, 175)
    recipe:SetRecipeItem(2699, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(1082, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HEALER, F.CASTER)
    recipe:AddVendor(340)

    -- Succulent Pork Ribs -- 2548
    recipe = AddRecipe(2548, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(110, 110, 130, 150, 170)
    recipe:SetRecipeItem(2700, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(2685, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddVendor(340)
    recipe:AddWorldDrop(Z.LOCH_MODAN, Z.REDRIDGE_MOUNTAINS)

    -- Seasoned Wolf Kabob -- 2549
    recipe = AddRecipe(2549, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(100, 100, 140, 160, 180)
    recipe:SetRecipeItem(2701, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(1017, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HEALER, F.CASTER)
    recipe:AddVendor(340)
    recipe:AddQuest(26620)

    -- Beer Basted Boar Ribs -- 2795
    recipe = AddRecipe(2795, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(10, 10, 60, 80, 100)
    recipe:SetRecipeItem(2889, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(2888, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE)
    recipe:AddVendor(340)
    recipe:AddQuest(384)

    -- Crocolisk Steak -- 3370
    recipe = AddRecipe(3370, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(80, 80, 120, 140, 160)
    recipe:SetRecipeItem(3678, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(3662, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HEALER, F.CASTER)
    recipe:AddVendor(340)

    -- Blood Sausage -- 3371
    recipe = AddRecipe(3371, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(60, 60, 100, 120, 140)
    recipe:SetRecipeItem(3679, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(3220, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HEALER, F.CASTER)
    recipe:AddVendor(340)
    recipe:AddQuest(26860)

    -- Murloc Fin Soup -- 3372
    recipe = AddRecipe(3372, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(90, 90, 130, 150, 170)
    recipe:SetRecipeItem(3680, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(3663, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HEALER, F.CASTER)
    recipe:AddVendor(340)

    -- Crocolisk Gumbo -- 3373
    recipe = AddRecipe(3373, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(120, 120, 160, 180, 200)
    recipe:SetRecipeItem(3681, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(3664, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HEALER, F.CASTER)
    recipe:AddVendor(340)

    -- Curiously Tasty Omelet -- 3376
    recipe = AddRecipe(3376, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(130, 130, 170, 190, 210)
    recipe:SetRecipeItem(3682, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(3665, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddVendor(340, 1148, 2821)

    -- Gooey Spider Cake -- 3377
    recipe = AddRecipe(3377, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(110, 110, 150, 170, 190)
    recipe:SetRecipeItem(3683, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(3666, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HEALER, F.CASTER)
    recipe:AddVendor(340)
    recipe:AddQuest(26623)

    -- Big Bear Steak -- 3397
    recipe = AddRecipe(3397, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(110, 110, 150, 170, 190)
    recipe:SetRecipeItem(3734, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(3726, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:Retire()

    -- Hot Lion Chops -- 3398
    recipe = AddRecipe(3398, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(125, 125, 175, 195, 215)
    recipe:SetRecipeItem(3735, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(3727, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddVendor(3489)

    -- Tasty Lion Steak -- 3399
    recipe = AddRecipe(3399, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(150, 150, 190, 210, 230)
    recipe:SetRecipeItem(3736, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(3728, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddTrainer(1355, 1382, 1430, 1699, 2818, 3026, 3067, 3399, 4210, 4552, 4894, 5159, 5482, 6286, 16253, 16719,
        17246, 18987, 18993, 19185, 19369, 26905, 26953, 26972, 26989, 28705, 29631, 33587, 33619, 42288, 42506, 45550,
        46709, 47405, 49789, 54232, 66353)

    -- Soothing Turtle Bisque -- 3400
    recipe = AddRecipe(3400, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(175, 175, 215, 235, 255)
    recipe:SetRecipeItem(3737, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(3729, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddTrainer(1355, 1382, 1430, 1699, 2818, 3026, 3067, 3399, 4210, 4552, 4894, 5159, 5482, 6286, 16253, 16719,
        17246, 18987, 18993, 19185, 19369, 26905, 26953, 26972, 26989, 28705, 29631, 33587, 33619, 42288, 42506, 45550,
        46709, 47405, 49789, 54232, 66353)

    -- Barbecued Buzzard Wing -- 4094
    recipe = AddRecipe(4094, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(175, 175, 215, 235, 255)
    recipe:SetRecipeItem(4609, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(4457, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddTrainer(1355, 1382, 1430, 1699, 2818, 3026, 3067, 3399, 4210, 4552, 4894, 5159, 5482, 6286, 16253, 16719,
        17246, 18987, 18993, 19185, 19369, 26905, 26953, 26972, 26989, 28705, 29631, 33587, 33619, 42288, 42506, 45550,
        46709, 47405, 49789, 54232, 66353)
    recipe:AddVendor(2814)

    -- Kaldorei Spider Kabob -- 6412
    recipe = AddRecipe(6412, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(10, 10, 50, 70, 90)
    recipe:SetRecipeItem(5482, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(5472, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddTrainer(1355, 1382, 1430, 1699, 2818, 3026, 3067, 3399, 4210, 4552, 4894, 5159, 5482, 6286, 16253, 16719,
        17246, 18987, 18993, 19185, 19369, 26905, 26953, 26972, 26989, 28705, 29631, 33587, 33619, 42288, 42506, 45550,
        46709, 47405, 49789, 54232, 66353)

    -- Scorpid Surprise -- 6413
    recipe = AddRecipe(6413, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(20, 20, 60, 80, 100)
    recipe:SetRecipeItem(5483, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(5473, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddVendor(3881)

    -- Roasted Kodo Meat -- 6414
    recipe = AddRecipe(6414, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(35, 35, 75, 95, 115)
    recipe:SetRecipeItem(5484, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(5474, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddVendor(3081)

    -- Fillet of Frenzy -- 6415
    recipe = AddRecipe(6415, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(50, 50, 90, 110, 130)
    recipe:SetRecipeItem(5485, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(5476, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddTrainer(1355, 1382, 1430, 1699, 2818, 3026, 3067, 3399, 4210, 4552, 4894, 5159, 5482, 6286, 16253, 16719,
        17246, 18987, 18993, 19185, 19369, 26905, 26953, 26972, 26989, 28705, 29631, 33587, 33619, 42288, 42506, 45550,
        46709, 47405, 49789, 54232, 66353)

    -- Strider Stew -- 6416
    recipe = AddRecipe(6416, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(50, 50, 90, 110, 130)
    recipe:SetRecipeItem(5486, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(5477, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddVendor(3482)

    -- Dig Rat Stew -- 6417
    recipe = AddRecipe(6417, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(90, 90, 130, 150, 170)
    recipe:SetRecipeItem(78342, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(5478, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddMobDrop(3444)

    -- Crispy Lizard Tail -- 6418
    recipe = AddRecipe(6418, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(100, 100, 140, 160, 180)
    recipe:SetRecipeItem(5488, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(5479, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddVendor(3482)

    -- Lean Venison -- 6419
    recipe = AddRecipe(6419, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(110, 110, 150, 170, 190)
    recipe:SetRecipeItem(5489, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(5480, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:Retire()

    -- Boiled Clams -- 6499
    recipe = AddRecipe(6499, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(50, 50, 90, 110, 130)
    recipe:SetCraftedItem(5525, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddTrainer(1355, 1382, 1430, 1699, 2818, 3026, 3067, 3087, 3399, 4210, 4552, 4894, 5159, 5482, 6286, 8306,
        16253, 16277, 16676, 16719, 17246, 18987, 18988, 18993, 19185, 19369, 26905, 26953, 26972, 26989, 28705, 29631,
        33587, 33619, 42288, 42506, 45550, 46709, 47405, 49789, 54232, 66353)

    -- Goblin Deviled Clams -- 6500
    recipe = AddRecipe(6500, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(125, 125, 165, 185, 205)
    recipe:SetCraftedItem(5527, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddTrainer(1355, 1382, 1430, 1699, 2818, 3026, 3067, 3087, 3399, 4210, 4552, 4894, 5159, 5482, 6286, 8306,
        16253, 16277, 16676, 16719, 17246, 18987, 18988, 18993, 19185, 19369, 26905, 26953, 26972, 26989, 28705, 29631,
        33587, 33619, 42288, 42506, 45550, 46709, 47405, 49789, 54232, 66353)

    -- Clam Chowder -- 6501
    recipe = AddRecipe(6501, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(90, 90, 130, 150, 170)
    recipe:SetRecipeItem(5528, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(5526, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddVendor(4305)

    -- Giant Clam Scorcho -- 7213
    recipe = AddRecipe(7213, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(175, 175, 215, 235, 255)
    recipe:SetRecipeItem(6039, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(6038, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddVendor(2664)

    -- Brilliant Smallfish -- 7751
    recipe = AddRecipe(7751, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 45, 65, 85)
    recipe:SetRecipeItem(6325, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(6290, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddVendor(66, 1684, 3029, 3550, 4265, 4574, 5494, 5940, 8508, 56069)

    -- Slitherskin Mackerel -- 7752
    recipe = AddRecipe(7752, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 45, 65, 85)
    recipe:SetRecipeItem(6326, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(787, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddVendor(3550, 4305, 5162, 5942, 10118)

    -- Longjaw Mud Snapper -- 7753
    recipe = AddRecipe(7753, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(50, 50, 90, 110, 130)
    recipe:SetRecipeItem(6328, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(4592, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddVendor(66, 1684, 3027, 4265, 4574, 5162, 5748, 5940)

    -- Loch Frenzy Delight -- 7754
    recipe = AddRecipe(7754, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(50, 50, 90, 110, 130)
    recipe:SetRecipeItem(6329, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(6316, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddVendor(1684)

    -- Bristle Whisker Catfish -- 7755
    recipe = AddRecipe(7755, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(100, 100, 140, 160, 180)
    recipe:SetRecipeItem(6330, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(4593, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddVendor(2397, 3027, 3029, 3497, 4553, 5494, 56069)

    -- Rainbow Fin Albacore -- 7827
    recipe = AddRecipe(7827, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(50, 50, 90, 110, 130)
    recipe:SetRecipeItem(6368, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(5095, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddVendor(3178, 3333, 3497, 4305, 4553, 5494, 5748, 5942, 10118)

    -- Rockscale Cod -- 7828
    recipe = AddRecipe(7828, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(175, 175, 190, 210, 230)
    recipe:SetRecipeItem(6369, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(4594, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddVendor(2664, 3178, 3333, 4574, 5162, 12033, 12962)

    -- Savory Deviate Delight -- 8238
    recipe = AddRecipe(8238, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(85, 85, 125, 145, 165)
    recipe:SetRecipeItem(6661, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(6657, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddWorldDrop(Z.NORTHERN_BARRENS, Z.SOUTHERN_BARRENS)

    -- Herb Baked Egg -- 8604
    recipe = AddRecipe(8604, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 45, 65, 85)
    recipe:SetCraftedItem(6888, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MISC1, F.HEALER, F.CASTER)
    recipe:AddCustom("DEFAULT_RECIPE")

    -- Smoked Bear Meat -- 8607
    recipe = AddRecipe(8607, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(40, 40, 80, 100, 120)
    recipe:SetRecipeItem(6892, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(6890, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddVendor(1465, 3556)

    -- Thistle Tea -- 9513
    recipe = AddRecipe(9513, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(60, 60, 100, 120, 140)
    recipe:SetRecipeItem(18160, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(7676, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.ROGUE)
    recipe:AddVendor(6779)

    -- Goldthorn Tea -- 13028
    recipe = AddRecipe(13028, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(175, 175, 175, 190, 205)
    recipe:SetCraftedItem(10841, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.INSTANCE)
    recipe:AddTrainer(8696)

    -- Lean Wolf Steak -- 15853
    recipe = AddRecipe(15853, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(125, 125, 165, 185, 205)
    recipe:SetRecipeItem(12227, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(12209, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:Retire()

    -- Roast Raptor -- 15855
    recipe = AddRecipe(15855, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(175, 175, 215, 235, 255)
    recipe:SetRecipeItem(12228, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(12210, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddVendor(734, 1148, 2810, 2821, 4879, 4897)

    -- Hot Wolf Ribs -- 15856
    recipe = AddRecipe(15856, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(175, 175, 215, 235, 255)
    recipe:SetRecipeItem(12229, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(13851, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddVendor(7947, 8145)

    -- Jungle Stew -- 15861
    recipe = AddRecipe(15861, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(175, 175, 215, 235, 255)
    recipe:SetRecipeItem(12231, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(12212, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddVendor(734, 1148)

    -- Carrion Surprise -- 15863
    recipe = AddRecipe(15863, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(175, 175, 215, 235, 255)
    recipe:SetRecipeItem(12232, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(12213, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddVendor(989, 4879, 9636)

    -- Mystery Stew -- 15865
    recipe = AddRecipe(15865, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(175, 175, 215, 235, 255)
    recipe:SetRecipeItem(12233, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(12214, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddVendor(4897, 8150)

    -- Dragonbreath Chili -- 15906
    recipe = AddRecipe(15906, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(200, 200, 225, 237, 250)
    recipe:SetRecipeItem(12239, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(12217, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddVendor(4879, 4897)

    -- Heavy Kodo Stew -- 15910
    recipe = AddRecipe(15910, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(200, 200, 225, 237, 250)
    recipe:SetRecipeItem(12240, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(12215, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddVendor(8150, 9636)

    -- Spiced Chili Crab -- 15915
    recipe = AddRecipe(15915, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(225, 225, 250, 262, 275)
    recipe:SetRecipeItem(16111, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(12216, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddVendor(989, 1149, 4305)

    -- Monster Omelet -- 15933
    recipe = AddRecipe(15933, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(225, 225, 250, 262, 275)
    recipe:SetRecipeItem(16110, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(12218, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddVendor(2803, 11187)

    -- Crispy Bat Wing -- 15935
    recipe = AddRecipe(15935, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 45, 65, 85)
    recipe:SetRecipeItem(12226, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(12224, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddVendor(2118)

    -- Spotted Yellowtail -- 18238
    recipe = AddRecipe(18238, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(225, 225, 250, 262, 275)
    recipe:SetRecipeItem(13939, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(6887, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1355, 1382, 1430, 1699, 2818, 3026, 3067, 3087, 3399, 4210, 4552, 4894, 5159, 5482, 6286, 8306,
        16253, 16277, 16676, 16719, 17246, 18987, 18988, 18993, 19185, 19369, 26905, 26953, 26972, 26989, 28705, 29631,
        33587, 33619, 42288, 42506, 45550, 46709, 47405, 49789, 54232, 66353)

    -- Cooked Glossy Mightfish -- 18239
    recipe = AddRecipe(18239, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(225, 225, 250, 262, 275)
    recipe:SetRecipeItem(13940, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(13927, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddVendor(2664)

    -- Grilled Squid -- 18240
    recipe = AddRecipe(18240, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(240, 240, 265, 277, 290)
    recipe:SetRecipeItem(13942, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(13928, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
    recipe:AddTrainer(1355, 1382, 1430, 1699, 2818, 3026, 3067, 3087, 3399, 4210, 4552, 4894, 5159, 5482, 6286, 8306,
        16253, 16277, 16676, 16719, 17246, 18987, 18988, 18993, 19185, 19369, 26905, 26953, 26972, 26989, 28705, 29631,
        33587, 33619, 42288, 42506, 45550, 46709, 47405, 49789, 54232, 66353)

    -- Filet of Redgill -- 18241
    recipe = AddRecipe(18241, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(225, 225, 250, 262, 275)
    recipe:SetRecipeItem(13941, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(13930, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddVendor(2664)

    -- Hot Smoked Bass -- 18242
    recipe = AddRecipe(18242, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(240, 240, 265, 277, 290)
    recipe:SetRecipeItem(13943, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(13929, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddVendor(2664)

    -- Nightfin Soup -- 18243
    recipe = AddRecipe(18243, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(250, 250, 275, 285, 295)
    recipe:SetRecipeItem(13945, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(13931, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddTrainer(1355, 1382, 1430, 1699, 2818, 3026, 3067, 3087, 3399, 4210, 4552, 4894, 5159, 5482, 6286, 8306,
        16253, 16277, 16676, 16719, 17246, 18987, 18988, 18993, 19185, 19369, 26905, 26953, 26972, 26989, 28705, 29631,
        33587, 33619, 42288, 42506, 45550, 46709, 47405, 49789, 54232, 66353)

    -- Poached Sunscale Salmon -- 18244
    recipe = AddRecipe(18244, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(250, 250, 275, 285, 295)
    recipe:SetRecipeItem(13946, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(13932, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1355, 1382, 1430, 1699, 2818, 3026, 3067, 3087, 3399, 4210, 4552, 4894, 5159, 5482, 6286, 8306,
        16253, 16277, 16676, 16719, 17246, 18987, 18988, 18993, 19185, 19369, 26905, 26953, 26972, 26989, 28705, 29631,
        33587, 33619, 42288, 42506, 45550, 46709, 47405, 49789, 54232, 66353)

    -- Lobster Stew -- 18245
    recipe = AddRecipe(18245, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(275, 275, 300, 312, 325)
    recipe:SetRecipeItem(13947, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(13933, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddVendor(7947, 8145)

    -- Mightfish Steak -- 18246
    recipe = AddRecipe(18246, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(275, 275, 300, 312, 325)
    recipe:SetRecipeItem(13948, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(13934, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddVendor(2664, 7947, 8145)

    -- Baked Salmon -- 18247
    recipe = AddRecipe(18247, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(275, 275, 300, 312, 325)
    recipe:SetRecipeItem(13949, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(13935, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddVendor(7947, 8145)

    -- Undermine Clam Chowder -- 20626
    recipe = AddRecipe(20626, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(225, 225, 250, 262, 275)
    recipe:SetRecipeItem(16767, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(16766, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddLimitedVendor(48060, 3, 54232, 1)

    -- Mithril Head Trout -- 20916
    recipe = AddRecipe(20916, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(175, 175, 215, 235, 255)
    recipe:SetRecipeItem(17062, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(8364, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddVendor(2664, 3178, 3333, 4574, 5162, 12033, 12962)

    -- Gingerbread Cookie -- 21143
    recipe = AddRecipe(21143, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 45, 65, 85)
    recipe:SetRecipeItem(17200, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(17197, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddVendor(13420, 13429, 13432, 13433, 13435, 23010, 23012, 23064)
    recipe:AddWorldEvent("WINTER_VEIL")

    -- Winter Veil Egg Nog -- 21144
    recipe = AddRecipe(21144, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(35, 35, 75, 95, 115)
    recipe:SetRecipeItem(17201, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(17198, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddVendor(13420, 13429, 13432, 13433, 13435, 23010, 23012, 23064)
    recipe:AddWorldEvent("WINTER_VEIL")

    -- Spider Sausage -- 21175
    recipe = AddRecipe(21175, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(200, 200, 225, 237, 250)
    recipe:SetCraftedItem(17222, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddTrainer(1355, 1382, 1430, 1699, 2818, 3026, 3067, 3087, 3399, 4210, 4552, 4894, 5159, 5482, 6286, 8306,
        16253, 16277, 16676, 16719, 17246, 18987, 18988, 18993, 19185, 19369, 26905, 26953, 26972, 26989, 28705, 29631,
        33587, 33619, 42288, 42506, 45550, 46709, 47405, 49789, 54232, 66353)

    -- Tender Wolf Steak -- 22480
    recipe = AddRecipe(22480, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(225, 225, 250, 262, 275)
    recipe:SetRecipeItem(18046, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(18045, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddVendor(4782, 7733, 40589)

    -- Runn Tum Tuber Surprise -- 22761
    recipe = AddRecipe(22761, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(275, 275, 300, 312, 325)
    recipe:SetRecipeItem(18267, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(18254, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.INSTANCE, F.HEALER, F.CASTER)
    recipe:AddMobDrop(14354)

    -- Heavy Crocolisk Stew -- 24418
    recipe = AddRecipe(24418, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(150, 150, 160, 180, 200)
    recipe:SetRecipeItem(20075, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(20074, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddVendor(4879)

    -- Smoked Desert Dumplings -- 24801
    recipe = AddRecipe(24801, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(285, 285, 310, 322, 335)
    recipe:SetCraftedItem(20452, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
    recipe:AddQuest(8313)

    -- Dirge's Kickin' Chimaerok Chops -- 25659
    recipe = AddRecipe(25659, V.ORIG, Q.EPIC)
    recipe:SetSkillLevels(300, 300, 325, 337, 350)
    recipe:SetRecipeItem(21025, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(21023, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:Retire()

    -- Smoked Sagefish -- 25704
    recipe = AddRecipe(25704, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(80, 80, 120, 140, 160)
    recipe:SetRecipeItem(21099, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(21072, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddVendor(2397, 2664, 3027, 3085, 3400, 4223, 4265, 4553, 4894, 5160, 5483, 8307, 12033, 14738, 16253, 16677,
        16718, 17246, 19195, 26868, 46708, 48060, 54232, 64084, 64465)

    -- Sagefish Delight -- 25954
    recipe = AddRecipe(25954, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(175, 175, 215, 235, 255)
    recipe:SetRecipeItem(21219, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(21217, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddVendor(2397, 2664, 3027, 3085, 3400, 4223, 4265, 4553, 4894, 5160, 5483, 8307, 12033, 14738, 16253, 16677,
        16718, 17246, 19195, 26868, 46708, 48060, 54232, 64084, 64465)

    -------------------------------------------------------------------------------
    -- The Burning Crusade.
    -------------------------------------------------------------------------------
    -- Crunchy Spider Surprise -- 28267
    recipe = AddRecipe(28267, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(60, 60, 100, 120, 140)
    recipe:SetRecipeItem(22647, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(22645, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddVendor(16253, 18427)
    recipe:AddQuest(9171)

    -- Lynx Steak -- 33276
    recipe = AddRecipe(33276, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 45, 65, 85)
    recipe:SetRecipeItem(27685, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(27635, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddVendor(16262)

    -- Roasted Moongraze Tenderloin -- 33277
    recipe = AddRecipe(33277, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 45, 65, 85)
    recipe:SetRecipeItem(27686, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(24105, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddQuest(9454)

    -- Bat Bites -- 33278
    recipe = AddRecipe(33278, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(50, 50, 90, 110, 130)
    recipe:SetRecipeItem(27687, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(27636, "BIND_ON_EQUIP")
    recipe:AddFilters(F.HORDE, F.HEALER, F.CASTER)
    recipe:AddVendor(16253)

    -- Buzzard Bites -- 33279
    recipe = AddRecipe(33279, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(300, 300, 320, 330, 340)
    recipe:SetRecipeItem(27684, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(27651, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddQuest(9356)

    -- Ravager Dog -- 33284
    recipe = AddRecipe(33284, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(300, 300, 320, 330, 340)
    recipe:SetRecipeItem(27688, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(27655, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
    recipe:AddVendor(16585, 16826)

    -- Blackened Basilisk -- 33286
    recipe = AddRecipe(33286, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(315, 315, 335, 345, 355)
    recipe:SetRecipeItem(27690, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(27657, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddVendor(18957, 19038)

    -- Roasted Clefthoof -- 33287
    recipe = AddRecipe(33287, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(325, 325, 345, 355, 365)
    recipe:SetRecipeItem(27691, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(27658, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
    recipe:AddVendor(20096, 20097)

    -- Warp Burger -- 33288
    recipe = AddRecipe(33288, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(325, 325, 345, 355, 365)
    recipe:SetRecipeItem(27692, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(27659, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
    recipe:AddVendor(18957, 19038)

    -- Talbuk Steak -- 33289
    recipe = AddRecipe(33289, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(325, 325, 345, 355, 365)
    recipe:SetRecipeItem(27693, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(27660, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddVendor(20096, 20097)

    -- Blackened Trout -- 33290
    recipe = AddRecipe(33290, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(300, 300, 320, 330, 340)
    recipe:SetRecipeItem(27694, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(27661, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddVendor(18015, 20028)

    -- Feltail Delight -- 33291
    recipe = AddRecipe(33291, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(300, 300, 320, 330, 340)
    recipe:SetRecipeItem(27695, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(27662, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddVendor(18011, 20028)

    -- Blackened Sporefish -- 33292
    recipe = AddRecipe(33292, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(310, 310, 330, 340, 350)
    recipe:SetRecipeItem(27696, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(27663, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddVendor(18911)

    -- Grilled Mudfish -- 33293
    recipe = AddRecipe(33293, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(320, 320, 340, 350, 360)
    recipe:SetRecipeItem(27697, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(27664, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
    recipe:AddVendor(20096, 20097)

    -- Poached Bluefish -- 33294
    recipe = AddRecipe(33294, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(320, 320, 340, 350, 360)
    recipe:SetRecipeItem(27698, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(27665, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddVendor(20096, 20097)

    -- Golden Fish Sticks -- 33295
    recipe = AddRecipe(33295, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(325, 325, 345, 355, 365)
    recipe:SetRecipeItem(27699, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(27666, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddVendor(18960, 19296)

    -- Spicy Crawdad -- 33296
    recipe = AddRecipe(33296, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(350, 350, 370, 375, 380)
    recipe:SetRecipeItem(27700, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(27667, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddVendor(18960, 19296)

    -- Clam Bar -- 36210
    recipe = AddRecipe(36210, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(300, 300, 320, 330, 340)
    recipe:SetRecipeItem(30156, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(30155, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddVendor(18382)

    -- Spice Bread -- 37836
    recipe = AddRecipe(37836, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 30, 35, 38)
    recipe:SetCraftedItem(30816, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1355, 1382, 1430, 1699, 2818, 3026, 3067, 3087, 3399, 4210, 4552, 4894, 5159, 5482, 6286, 8306,
        16253, 16277, 16676, 16719, 17246, 18987, 18988, 18993, 19185, 19369, 26905, 26953, 26972, 26989, 28705, 29631,
        33587, 33619, 42288, 42506, 45550, 46709, 47405, 49789, 54232, 66353)

    -- Mok'Nathal Shortribs -- 38867
    recipe = AddRecipe(38867, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(335, 335, 355, 365, 375)
    recipe:SetRecipeItem(31675, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(31672, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddVendor(21113)
    recipe:AddLimitedVendor(20916, 1)
    recipe:AddQuest(10860)

    -- Crunchy Serpent -- 38868
    recipe = AddRecipe(38868, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(335, 335, 355, 365, 375)
    recipe:SetRecipeItem(31674, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(31673, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddVendor(21113)
    recipe:AddLimitedVendor(20916, 1)
    recipe:AddQuest(10860)

    -- Stewed Trout -- 42296
    recipe = AddRecipe(42296, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(320, 320, 335, 345, 355)
    recipe:SetCraftedItem(33048, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1355, 1382, 1430, 1699, 2818, 3026, 3067, 3399, 4210, 4552, 4894, 5159, 5482, 6286, 16253, 16719,
        17246, 18987, 18993, 19185, 19186, 19369, 26905, 26953, 26972, 26989, 28705, 29631, 33587, 33619, 42288, 42506,
        45550, 46709, 47405, 49789, 54232, 66353)

    -- Fisherman's Feast -- 42302
    recipe = AddRecipe(42302, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(350, 350, 375, 380, 385)
    recipe:SetCraftedItem(33052, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddTrainer(1355, 1382, 1430, 1699, 2818, 3026, 3067, 3399, 4210, 4552, 4894, 5159, 5482, 6286, 16253, 16719,
        17246, 18987, 18993, 19185, 19186, 19369, 26905, 26953, 26972, 26989, 28705, 29631, 33587, 33619, 42288, 42506,
        45550, 46709, 47405, 49789, 54232, 66353)

    -- Hot Buttered Trout -- 42305
    recipe = AddRecipe(42305, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(350, 350, 375, 380, 385)
    recipe:SetCraftedItem(33053, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1355, 1382, 1430, 1699, 2818, 3026, 3067, 3399, 4210, 4552, 4894, 5159, 5482, 6286, 16253, 16719,
        17246, 18987, 18993, 19185, 19186, 19369, 26905, 26953, 26972, 26989, 28705, 29631, 33587, 33619, 42288, 42506,
        45550, 46709, 47405, 49789, 54232, 66353)

    -- Skullfish Soup -- 43707
    recipe = AddRecipe(43707, V.TBC, Q.UNCOMMON)
    recipe:SetSkillLevels(325, 325, 335, 345, 355)
    recipe:SetRecipeItem(33870, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(33825, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
    recipe:AddQuest(11377, 11379, 11380, 11381)
    recipe:AddCustom("DAILY_COOKING_FISH")

    -- Stormchops -- 43758
    recipe = AddRecipe(43758, V.TBC, Q.RARE)
    recipe:SetSkillLevels(300, 300, 320, 330, 340)
    recipe:SetRecipeItem(33871, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(33866, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddQuest(11377, 11379, 11380, 11381, 13100, 13101, 13102, 13103, 13107, 13112, 13113, 13114, 13115, 13116)
    recipe:AddCustom("DAILY_COOKING_DAL", "DAILY_COOKING_FISH", "DAILY_COOKING_MEAT")

    -- Broiled Bloodfin -- 43761
    recipe = AddRecipe(43761, V.TBC, Q.UNCOMMON)
    recipe:SetSkillLevels(300, 300, 320, 330, 340)
    recipe:SetRecipeItem(33869, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(33867, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddQuest(11377, 11379, 11380, 11381)
    recipe:AddCustom("DAILY_COOKING_FISH")

    -- Spicy Hot Talbuk -- 43765
    recipe = AddRecipe(43765, V.TBC, Q.UNCOMMON)
    recipe:SetSkillLevels(325, 325, 335, 345, 355)
    recipe:SetRecipeItem(33873, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(33872, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
    recipe:AddQuest(11377, 11379, 11380, 11381)
    recipe:AddCustom("DAILY_COOKING_MEAT")

    -- Kibler's Bits -- 43772
    recipe = AddRecipe(43772, V.TBC, Q.UNCOMMON)
    recipe:SetSkillLevels(300, 300, 345, 355, 365)
    recipe:SetRecipeItem(33875, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(33874, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddQuest(11377, 11379, 11380, 11381)
    recipe:AddCustom("DAILY_COOKING_FISH", "DAILY_COOKING_MEAT")

    -- Delicious Chocolate Cake -- 43779
    recipe = AddRecipe(43779, V.TBC, Q.RARE)
    recipe:SetSkillLevels(1, 1, 50, 62, 75)
    recipe:SetRecipeItem(33925, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(33924, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddQuest(11377, 11379, 11380, 11381, 13100, 13101, 13102, 13103, 13107, 13112, 13113, 13114, 13115, 13116)
    recipe:AddCustom("DAILY_COOKING_DAL", "DAILY_COOKING_FISH", "DAILY_COOKING_MEAT")

    -------------------------------------------------------------------------------
    -- Wrath of the Lich King.
    -------------------------------------------------------------------------------
    -- Hot Apple Cider -- 45022
    recipe = AddRecipe(45022, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(325, 325, 325, 325, 325)
    recipe:SetRecipeItem(34413, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(34411, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddVendor(13420, 13433)
    recipe:AddWorldEvent("WINTER_VEIL")

    -- Mammoth Meal -- 45549
    recipe = AddRecipe(45549, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(350, 350, 350, 382, 415)
    recipe:SetCraftedItem(34748, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
    recipe:AddTrainer(1355, 1382, 1430, 1699, 2818, 3026, 3067, 3399, 4210, 4552, 4894, 5159, 5482, 6286, 16253, 16719,
        17246, 18987, 18993, 19185, 19369, 26905, 26953, 26972, 26989, 28705, 29631, 33587, 33619, 42288, 42506, 45550,
        46709, 47405, 49789, 54232, 66353)

    -- Shoveltusk Steak -- 45550
    recipe = AddRecipe(45550, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(350, 350, 350, 382, 415)
    recipe:SetCraftedItem(34749, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddTrainer(1355, 1382, 1430, 1699, 2818, 3026, 3067, 3399, 4210, 4552, 4894, 5159, 5482, 6286, 16253, 16719,
        17246, 18987, 18993, 19185, 19369, 26905, 26953, 26972, 26989, 28705, 29631, 33587, 33619, 42288, 42506, 45550,
        46709, 47405, 49789, 54232, 66353)

    -- Worm Delight -- 45551
    recipe = AddRecipe(45551, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(350, 350, 350, 382, 415)
    recipe:SetCraftedItem(34750, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1355, 1382, 1430, 1699, 2818, 3026, 3067, 3399, 4210, 4552, 4894, 5159, 5482, 6286, 16253, 16719,
        17246, 18987, 18993, 19185, 19369, 26905, 26953, 26972, 26989, 28705, 29631, 33587, 33619, 42288, 42506, 45550,
        46709, 47405, 49789, 54232, 66353)

    -- Roasted Worg -- 45552
    recipe = AddRecipe(45552, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(350, 350, 350, 382, 415)
    recipe:SetCraftedItem(34751, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1355, 1382, 1430, 1699, 2818, 3026, 3067, 3399, 4210, 4552, 4894, 5159, 5482, 6286, 16253, 16719,
        17246, 18987, 18993, 19185, 19369, 26905, 26953, 26972, 26989, 28705, 29631, 33587, 33619, 42288, 42506, 45550,
        46709, 47405, 49789, 54232, 66353)

    -- Rhino Dogs -- 45553
    recipe = AddRecipe(45553, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(350, 350, 350, 382, 415)
    recipe:SetCraftedItem(34752, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1355, 1382, 1430, 1699, 2818, 3026, 3067, 3399, 4210, 4552, 4894, 5159, 5482, 6286, 16253, 16719,
        17246, 18987, 18993, 19185, 19369, 26905, 26953, 26972, 26989, 28705, 29631, 33587, 33619, 42288, 42506, 45550,
        46709, 47405, 49789, 54232, 66353)

    -- Great Feast -- 45554
    recipe = AddRecipe(45554, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(375, 375, 375, 400, 425)
    recipe:SetCraftedItem(34753, "BIND_ON_PICKUP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddTrainer(1355, 1382, 1430, 1699, 2818, 3026, 3067, 3399, 4210, 4552, 4894, 5159, 5482, 6286, 16253, 16719,
        17246, 18987, 18993, 19185, 19369, 26905, 26953, 26972, 26989, 28705, 29631, 33587, 33619, 42288, 42506, 45550,
        46709, 47405, 49789, 54232, 66353)

    -- Mega Mammoth Meal -- 45555
    recipe = AddRecipe(45555, V.WOTLK, Q.UNCOMMON)
    recipe:SetSkillLevels(400, 400, 425, 450, 475)
    recipe:SetRecipeItem(43018, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(34754, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
    recipe:AddVendor(31031, 31032, 33595)

    -- Tender Shoveltusk Steak -- 45556
    recipe = AddRecipe(45556, V.WOTLK, Q.UNCOMMON)
    recipe:SetSkillLevels(400, 400, 425, 450, 475)
    recipe:SetRecipeItem(43019, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(34755, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddVendor(31031, 31032, 33595)

    -- Spiced Worm Burger -- 45557
    recipe = AddRecipe(45557, V.WOTLK, Q.UNCOMMON)
    recipe:SetSkillLevels(400, 400, 425, 450, 475)
    recipe:SetRecipeItem(43020, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(34756, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
    recipe:AddVendor(31031, 31032, 33595)

    -- Very Burnt Worg -- 45558
    recipe = AddRecipe(45558, V.WOTLK, Q.UNCOMMON)
    recipe:SetSkillLevels(400, 400, 425, 450, 475)
    recipe:SetRecipeItem(43021, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(34757, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
    recipe:AddVendor(31031, 31032, 33595)

    -- Mighty Rhino Dogs -- 45559
    recipe = AddRecipe(45559, V.WOTLK, Q.UNCOMMON)
    recipe:SetSkillLevels(400, 400, 425, 450, 475)
    recipe:SetRecipeItem(43022, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(34758, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddVendor(31031, 31032, 33595)

    -- Smoked Rockfin -- 45560
    recipe = AddRecipe(45560, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(350, 350, 350, 365, 380)
    recipe:SetCraftedItem(34759, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1355, 1382, 1430, 1699, 2818, 3026, 3067, 3399, 4210, 4552, 4894, 5159, 5482, 6286, 16253, 16719,
        17246, 18987, 18993, 19185, 19369, 26905, 26953, 26972, 26989, 28705, 29631, 33587, 33619, 42288, 42506, 45550,
        46709, 47405, 49789, 54232, 66353)

    -- Grilled Bonescale -- 45561
    recipe = AddRecipe(45561, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(350, 350, 350, 365, 380)
    recipe:SetCraftedItem(34760, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1355, 1382, 1430, 1699, 2818, 3026, 3067, 3399, 4210, 4552, 4894, 5159, 5482, 6286, 16253, 16719,
        17246, 18987, 18993, 19185, 19369, 26905, 26953, 26972, 26989, 28705, 29631, 33587, 33619, 42288, 42506, 45550,
        46709, 47405, 49789, 54232, 66353)

    -- Sauteed Goby -- 45562
    recipe = AddRecipe(45562, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(350, 350, 350, 365, 380)
    recipe:SetCraftedItem(34761, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1355, 1382, 1430, 1699, 2818, 3026, 3067, 3399, 4210, 4552, 4894, 5159, 5482, 6286, 16253, 16719,
        17246, 18987, 18993, 19185, 19369, 26905, 26953, 26972, 26989, 28705, 29631, 33587, 33619, 42288, 42506, 45550,
        46709, 47405, 49789, 54232, 66353)

    -- Grilled Sculpin -- 45563
    recipe = AddRecipe(45563, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(350, 350, 350, 382, 415)
    recipe:SetCraftedItem(34762, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
    recipe:AddTrainer(1355, 1382, 1430, 1699, 2818, 3026, 3067, 3399, 4210, 4552, 4894, 5159, 5482, 6286, 16253, 16719,
        17246, 18987, 18993, 19185, 19369, 26905, 26953, 26972, 26989, 28705, 29631, 33587, 33619, 42288, 42506, 45550,
        46709, 47405, 49789, 54232, 66353)

    -- Smoked Salmon -- 45564
    recipe = AddRecipe(45564, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(350, 350, 350, 382, 415)
    recipe:SetCraftedItem(34763, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddTrainer(1355, 1382, 1430, 1699, 2818, 3026, 3067, 3399, 4210, 4552, 4894, 5159, 5482, 6286, 16253, 16719,
        17246, 18987, 18993, 19185, 19369, 26905, 26953, 26972, 26989, 28705, 29631, 33587, 33619, 42288, 42506, 45550,
        46709, 47405, 49789, 54232, 66353)

    -- Poached Nettlefish -- 45565
    recipe = AddRecipe(45565, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(350, 350, 350, 382, 415)
    recipe:SetCraftedItem(34764, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1355, 1382, 1430, 1699, 2818, 3026, 3067, 3399, 4210, 4552, 4894, 5159, 5482, 6286, 16253, 16719,
        17246, 18987, 18993, 19185, 19369, 26905, 26953, 26972, 26989, 28705, 29631, 33587, 33619, 42288, 42506, 45550,
        46709, 47405, 49789, 54232, 66353)

    -- Pickled Fangtooth -- 45566
    recipe = AddRecipe(45566, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(350, 350, 350, 382, 415)
    recipe:SetCraftedItem(34765, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1355, 1382, 1430, 1699, 2818, 3026, 3067, 3399, 4210, 4552, 4894, 5159, 5482, 6286, 16253, 16719,
        17246, 18987, 18993, 19185, 19369, 26905, 26953, 26972, 26989, 28705, 29631, 33587, 33619, 42288, 42506, 45550,
        46709, 47405, 49789, 54232, 66353)

    -- Poached Northern Sculpin -- 45567
    recipe = AddRecipe(45567, V.WOTLK, Q.UNCOMMON)
    recipe:SetSkillLevels(400, 400, 425, 450, 475)
    recipe:SetRecipeItem(43023, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(34766, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
    recipe:AddVendor(31031, 31032, 33595)

    -- Firecracker Salmon -- 45568
    recipe = AddRecipe(45568, V.WOTLK, Q.UNCOMMON)
    recipe:SetSkillLevels(400, 400, 425, 450, 475)
    recipe:SetRecipeItem(43024, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(34767, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddVendor(31031, 31032, 33595)

    -- Baked Manta Ray -- 45569
    recipe = AddRecipe(45569, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(350, 350, 350, 382, 415)
    recipe:SetCraftedItem(42942, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1355, 1382, 1430, 1699, 2818, 3026, 3067, 3399, 4210, 4552, 4894, 5159, 5482, 6286, 16253, 16719,
        17246, 18987, 18993, 19185, 19369, 26905, 26953, 26972, 26989, 28705, 29631, 33587, 33619, 42288, 42506, 45550,
        46709, 47405, 49789, 54232, 66353)

    -- Imperial Manta Steak -- 45570
    recipe = AddRecipe(45570, V.WOTLK, Q.UNCOMMON)
    recipe:SetSkillLevels(400, 400, 425, 450, 475)
    recipe:SetRecipeItem(43026, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(34769, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
    recipe:AddVendor(31031, 31032, 33595)

    -- Spicy Blue Nettlefish -- 45571
    recipe = AddRecipe(45571, V.WOTLK, Q.UNCOMMON)
    recipe:SetSkillLevels(400, 400, 425, 450, 475)
    recipe:SetRecipeItem(43025, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(34768, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
    recipe:AddVendor(31031, 31032, 33595)

    -- Captain Rumsey's Lager -- 45695
    recipe = AddRecipe(45695, V.WOTLK, Q.UNCOMMON)
    recipe:SetSkillLevels(100, 100, 100, 105, 110)
    recipe:SetRecipeItem(34834, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(34832, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddQuest(11666, 11667, 11668, 11669, 13100, 13101, 13102, 13103, 13107, 13112, 13113, 13114, 13115, 13116)
    recipe:AddCustom("DAILY_COOKING_DAL", "DAILY_FISHING_SHATT")

    -- Charred Bear Kabobs -- 46684
    recipe = AddRecipe(46684, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(250, 250, 275, 285, 295)
    recipe:SetRecipeItem(35564, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(35563, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
    recipe:AddTrainer(1355, 1382, 1430, 1699, 2818, 3026, 3067, 3399, 4210, 4552, 4894, 5159, 5482, 6286, 16253, 16719,
        17246, 18987, 18993, 19185, 19369, 26905, 26953, 26972, 26989, 28705, 29631, 33587, 33619, 42288, 42506, 45550,
        46709, 47405, 49789, 54232, 66353)

    -- Juicy Bear Burger -- 46688
    recipe = AddRecipe(46688, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(250, 250, 275, 285, 295)
    recipe:SetRecipeItem(35566, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(35565, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddTrainer(1355, 1382, 1430, 1699, 2818, 3026, 3067, 3399, 4210, 4552, 4894, 5159, 5482, 6286, 16253, 16719,
        17246, 18987, 18993, 19185, 19369, 26905, 26953, 26972, 26989, 28705, 29631, 33587, 33619, 42288, 42506, 45550,
        46709, 47405, 49789, 54232, 66353)

    -- Kungaloosh -- 53056
    recipe = AddRecipe(53056, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(375, 375, 375, 387, 400)
    recipe:SetRecipeItem(39644, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(39520, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddQuest(13571)
    recipe:AddCustom("KUNG")

    -- Northern Stew -- 57421
    recipe = AddRecipe(57421, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(350, 350, 350, 362, 365)
    recipe:SetCraftedItem(34747, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddQuest(13087, 13088, 13089, 13090)

    -- Fish Feast -- 57423
    recipe = AddRecipe(57423, V.WOTLK, Q.UNCOMMON)
    recipe:SetSkillLevels(450, 450, 455, 460, 465)
    recipe:SetRecipeItem(43017, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(43015, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
    recipe:AddVendor(31031, 31032, 33595)

    -- Spicy Fried Herring -- 57433
    recipe = AddRecipe(57433, V.WOTLK, Q.UNCOMMON)
    recipe:SetSkillLevels(400, 400, 425, 450, 475)
    recipe:SetRecipeItem(43027, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(42993, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddVendor(31031, 31032, 33595)

    -- Rhinolicious Wormsteak -- 57434
    recipe = AddRecipe(57434, V.WOTLK, Q.UNCOMMON)
    recipe:SetSkillLevels(400, 400, 425, 450, 475)
    recipe:SetRecipeItem(43028, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(42994, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.TANK)
    recipe:AddVendor(31031, 31032, 33595)

    -- Critter Bites -- 57435
    recipe = AddRecipe(57435, V.WOTLK, Q.UNCOMMON)
    recipe:SetSkillLevels(400, 400, 425, 450, 475)
    recipe:SetRecipeItem(43029, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(43004, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddVendor(31031, 31032, 33595)

    -- Hearty Rhino -- 57436
    recipe = AddRecipe(57436, V.WOTLK, Q.UNCOMMON)
    recipe:SetSkillLevels(400, 400, 425, 450, 475)
    recipe:SetRecipeItem(43030, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(42995, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
    recipe:AddVendor(31031, 31032, 33595)

    -- Snapper Extreme -- 57437
    recipe = AddRecipe(57437, V.WOTLK, Q.UNCOMMON)
    recipe:SetSkillLevels(400, 400, 425, 450, 475)
    recipe:SetRecipeItem(43031, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(42996, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.CASTER)
    recipe:AddVendor(31031, 31032, 33595)

    -- Blackened Worg Steak -- 57438
    recipe = AddRecipe(57438, V.WOTLK, Q.UNCOMMON)
    recipe:SetSkillLevels(400, 400, 425, 450, 475)
    recipe:SetRecipeItem(43032, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(42997, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddVendor(31031, 31032, 33595)

    -- Cuttlesteak -- 57439
    recipe = AddRecipe(57439, V.WOTLK, Q.UNCOMMON)
    recipe:SetSkillLevels(400, 400, 425, 450, 475)
    recipe:SetRecipeItem(43033, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(42998, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddVendor(31031, 31032, 33595)

    -- Spiced Mammoth Treats -- 57440
    recipe = AddRecipe(57440, V.WOTLK, Q.UNCOMMON)
    recipe:SetSkillLevels(400, 400, 425, 450, 475)
    recipe:SetRecipeItem(43034, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(43005, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddVendor(31031, 31032, 33595)

    -- Blackened Dragonfin -- 57441
    recipe = AddRecipe(57441, V.WOTLK, Q.UNCOMMON)
    recipe:SetSkillLevels(400, 400, 425, 450, 475)
    recipe:SetRecipeItem(43035, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(42999, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
    recipe:AddVendor(31031, 31032, 33595)

    -- Dragonfin Filet -- 57442
    recipe = AddRecipe(57442, V.WOTLK, Q.UNCOMMON)
    recipe:SetSkillLevels(400, 400, 425, 450, 475)
    recipe:SetRecipeItem(43036, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(43000, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
    recipe:AddVendor(31031, 31032, 33595)

    -- Tracker Snacks -- 57443
    recipe = AddRecipe(57443, V.WOTLK, Q.UNCOMMON)
    recipe:SetSkillLevels(400, 400, 425, 450, 475)
    recipe:SetRecipeItem(43037, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(43001, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddVendor(31031, 31032, 33595)

    -- Dalaran Clam Chowder -- 58065
    recipe = AddRecipe(58065, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(350, 350, 350, 382, 415)
    recipe:SetCraftedItem(43268, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddTrainer(1355, 1382, 1430, 1699, 2818, 3026, 3067, 3399, 4210, 4552, 4894, 5159, 5482, 6286, 16253, 16719,
        17246, 18987, 18993, 19185, 19369, 26905, 26953, 26972, 26989, 28705, 29631, 33587, 33619, 42288, 42506, 45550,
        46709, 47405, 49789, 54232, 66353)

    -- Tasty Cupcake -- 58512
    recipe = AddRecipe(58512, V.WOTLK, Q.UNCOMMON)
    recipe:SetSkillLevels(350, 350, 350, 357, 365)
    recipe:SetRecipeItem(43507, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(43490, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddWorldDrop(Z.NORTHREND)

    -- Last Week's Mammoth -- 58521
    recipe = AddRecipe(58521, V.WOTLK, Q.UNCOMMON)
    recipe:SetSkillLevels(350, 350, 350, 357, 365)
    recipe:SetRecipeItem(43508, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(43488, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddWorldDrop(Z.NORTHREND)

    -- Bad Clams -- 58523
    recipe = AddRecipe(58523, V.WOTLK, Q.UNCOMMON)
    recipe:SetSkillLevels(350, 350, 350, 357, 365)
    recipe:SetRecipeItem(43509, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(43491, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddWorldDrop(Z.NORTHREND)

    -- Haunted Herring -- 58525
    recipe = AddRecipe(58525, V.WOTLK, Q.UNCOMMON)
    recipe:SetSkillLevels(350, 350, 350, 357, 365)
    recipe:SetRecipeItem(43510, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(43492, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddWorldDrop(Z.NORTHREND)

    -- Gigantic Feast -- 58527
    recipe = AddRecipe(58527, V.WOTLK, Q.UNCOMMON)
    recipe:SetSkillLevels(425, 425, 435, 455, 475)
    recipe:SetRecipeItem(43505, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(43478, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddVendor(31031, 31032, 33595)

    -- Small Feast -- 58528
    recipe = AddRecipe(58528, V.WOTLK, Q.UNCOMMON)
    recipe:SetSkillLevels(425, 425, 435, 455, 475)
    recipe:SetRecipeItem(43506, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(43480, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddVendor(31031, 31032, 33595)

    -- Pumpkin Pie -- 62044
    recipe = AddRecipe(62044, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(100, 100, 150, 162, 175)
    recipe:SetCraftedItem(44836, "BIND_ON_EQUIP")
    recipe:SetRequiredFaction("Alliance")
    recipe:AddFilters(F.ALLIANCE, F.HEALER, F.CASTER)
    recipe:AddWorldEvent("PILGRIMS_BOUNTY")

    -- Slow-Roasted Turkey -- 62045
    recipe = AddRecipe(62045, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(330, 330, 330, 342, 355)
    recipe:SetCraftedItem(44839, "BIND_ON_EQUIP")
    recipe:SetRequiredFaction("Alliance")
    recipe:AddFilters(F.ALLIANCE, F.DPS)
    recipe:AddWorldEvent("PILGRIMS_BOUNTY")

    -- Cranberry Chutney -- 62049
    recipe = AddRecipe(62049, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(210, 210, 210, 222, 235)
    recipe:SetCraftedItem(44840, "BIND_ON_EQUIP")
    recipe:SetRequiredFaction("Alliance")
    recipe:AddFilters(F.ALLIANCE, F.HEALER, F.CASTER)
    recipe:AddWorldEvent("PILGRIMS_BOUNTY")

    -- Spice Bread Stuffing -- 62050
    recipe = AddRecipe(62050, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(90, 90, 90, 102, 115)
    recipe:SetCraftedItem(44837, "BIND_ON_EQUIP")
    recipe:SetRequiredFaction("Alliance")
    recipe:AddFilters(F.ALLIANCE)
    recipe:AddWorldEvent("PILGRIMS_BOUNTY")

    -- Candied Sweet Potato -- 62051
    recipe = AddRecipe(62051, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(270, 270, 270, 282, 295)
    recipe:SetCraftedItem(44839, "BIND_ON_EQUIP")
    recipe:SetRequiredFaction("Alliance")
    recipe:AddFilters(F.ALLIANCE)
    recipe:AddWorldEvent("PILGRIMS_BOUNTY")

    -- Worg Tartare -- 62350
    recipe = AddRecipe(62350, V.WOTLK, Q.UNCOMMON)
    recipe:SetSkillLevels(400, 400, 400, 420, 460)
    recipe:SetRecipeItem(44954, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(44953, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.CASTER)
    recipe:AddVendor(31031, 31032, 33595)

    -- Clamlette Magnifique -- 64054
    recipe = AddRecipe(64054, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(250, 250, 250, 275, 300)
    recipe:SetCraftedItem(33004, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddQuest(6610)

    -- Black Jelly -- 64358
    recipe = AddRecipe(64358, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(400, 400, 400, 412, 425)
    recipe:SetCraftedItem(45932, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1355, 1382, 1430, 1699, 2818, 3026, 3067, 3399, 4210, 4552, 4894, 5159, 5482, 6286, 16253, 16719,
        17246, 18987, 18993, 19185, 19369, 26905, 26953, 26972, 26989, 28705, 29631, 33587, 33619, 42288, 42506, 45550,
        46709, 47405, 49789, 54232, 66353)

    -- Bread of the Dead -- 65454
    recipe = AddRecipe(65454, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(45, 45, 55, 60, 65)
    recipe:SetCraftedItem(46691, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddWorldEvent("DAY_OF_THE_DEAD")
    recipe:AddVendor(34382)

    -- Candied Sweet Potato -- 66034
    recipe = AddRecipe(66034, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(270, 270, 270, 282, 295)
    recipe:SetCraftedItem(44839, "BIND_ON_EQUIP")
    recipe:SetRequiredFaction("Horde")
    recipe:AddFilters(F.HORDE)
    recipe:AddWorldEvent("PILGRIMS_BOUNTY")

    -- Cranberry Chutney -- 66035
    recipe = AddRecipe(66035, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(210, 210, 210, 222, 235)
    recipe:SetCraftedItem(44840, "BIND_ON_EQUIP")
    recipe:SetRequiredFaction("Horde")
    recipe:AddFilters(F.HORDE, F.HEALER, F.CASTER)
    recipe:AddWorldEvent("PILGRIMS_BOUNTY")

    -- Pumpkin Pie -- 66036
    recipe = AddRecipe(66036, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(100, 100, 150, 162, 175)
    recipe:SetCraftedItem(44836, "BIND_ON_EQUIP")
    recipe:SetRequiredFaction("Horde")
    recipe:AddFilters(F.HORDE, F.HEALER, F.CASTER)
    recipe:AddWorldEvent("PILGRIMS_BOUNTY")

    -- Slow-Roasted Turkey -- 66037
    recipe = AddRecipe(66037, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(330, 330, 330, 342, 355)
    recipe:SetCraftedItem(44839, "BIND_ON_EQUIP")
    recipe:SetRequiredFaction("Horde")
    recipe:AddFilters(F.HORDE, F.DPS)
    recipe:AddWorldEvent("PILGRIMS_BOUNTY")

    -- Spice Bread Stuffing -- 66038
    recipe = AddRecipe(66038, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(90, 90, 90, 102, 115)
    recipe:SetCraftedItem(44837, "BIND_ON_EQUIP")
    recipe:SetRequiredFaction("Horde")
    recipe:AddFilters(F.HORDE)
    recipe:AddWorldEvent("PILGRIMS_BOUNTY")

    -------------------------------------------------------------------------------
    -- Cataclysm.
    -------------------------------------------------------------------------------
    -- Baked Rockfish -- 88003
    recipe = AddRecipe(88003, V.CATA, Q.UNCOMMON)
    recipe:SetSkillLevels(500, 500, 515, 520, 525)
    recipe:SetRecipeItem(65426, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(62661, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
    recipe:AddVendor(3027, 4223, 4553, 5160, 49701, 49737)

    -- Basilisk Liverdog -- 88004
    recipe = AddRecipe(88004, V.CATA, Q.UNCOMMON)
    recipe:SetSkillLevels(500, 500, 515, 520, 525)
    recipe:SetRecipeItem(65427, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(62665, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
    recipe:AddVendor(3027, 4223, 4553, 5160, 49701, 49737)

    -- Beer-Basted Crocolisk -- 88005
    recipe = AddRecipe(88005, V.CATA, Q.UNCOMMON)
    recipe:SetSkillLevels(500, 500, 515, 520, 525)
    recipe:SetRecipeItem(65429, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(62670, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
    recipe:AddVendor(3027, 4223, 4553, 5160, 49701, 49737)

    -- Blackened Surprise -- 88006
    recipe = AddRecipe(88006, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(425, 425, 450, 457, 465)
    recipe:SetCraftedItem(62676, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1355, 1382, 1430, 1699, 2818, 3026, 3067, 3399, 4210, 4552, 4894, 5159, 5482, 6286, 16253, 16719,
        17246, 18987, 18993, 19185, 19369, 26905, 26953, 26972, 26989, 28705, 29631, 33587, 33619, 42288, 42506, 45550,
        46709, 47405, 49789, 54232, 66353)

    -- Broiled Dragon Feast -- 88011
    recipe = AddRecipe(88011, V.CATA, Q.RARE)
    recipe:SetSkillLevels(500, 500, 500, 500, 525)
    recipe:SetRecipeItem(62799, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(62289, "BIND_ON_PICKUP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddAchievement(5467)
    recipe:AddVendor(46572, 46602, 51495, 51512)

    -- Broiled Mountain Trout -- 88012
    recipe = AddRecipe(88012, V.CATA, Q.UNCOMMON)
    recipe:SetSkillLevels(450, 450, 465, 477, 490)
    recipe:SetRecipeItem(65411, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(62655, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
    recipe:AddVendor(3027, 4223, 4553, 5160, 49701, 49737)

    -- Chocolate Cookie -- 88013
    recipe = AddRecipe(88013, V.CATA, Q.UNCOMMON)
    recipe:SetSkillLevels(505, 505, 510, 512, 515)
    recipe:SetRecipeItem(65431, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(62680, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddVendor(3027, 4223, 4553, 5160, 49701, 49737)

    -- Crocolisk Au Gratin -- 88014
    recipe = AddRecipe(88014, V.CATA, Q.UNCOMMON)
    recipe:SetSkillLevels(500, 500, 515, 520, 525)
    recipe:SetRecipeItem(65430, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(62664, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.TANK)
    recipe:AddVendor(3027, 4223, 4553, 5160, 49701, 49737)

    -- Darkbrew Lager -- 88015
    recipe = AddRecipe(88015, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(415, 415, 430, 435, 440)
    recipe:SetCraftedItem(62790, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1355, 1382, 1430, 1699, 2818, 3026, 3067, 3399, 4210, 4552, 4894, 5159, 5482, 6286, 16253, 16719,
        17246, 18987, 18993, 19185, 19369, 26905, 26953, 26972, 26989, 28705, 29631, 33587, 33619, 42288, 42506, 45550,
        46709, 47405, 49789, 54232, 66353)

    -- Delicious Sagefish Tail -- 88016
    recipe = AddRecipe(88016, V.CATA, Q.UNCOMMON)
    recipe:SetSkillLevels(500, 500, 515, 520, 525)
    recipe:SetRecipeItem(65422, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(62666, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddVendor(3027, 4223, 4553, 5160, 49701, 49737)

    -- Feathered Lure -- 88017
    recipe = AddRecipe(88017, V.CATA, Q.UNCOMMON)
    recipe:SetSkillLevels(450, 450, 450, 455, 470)
    recipe:SetRecipeItem(65408, "BIND_ON_PICKUP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddVendor(3027, 4223, 4553, 5160, 49701, 49737)

    -- Fish Fry -- 88018
    recipe = AddRecipe(88018, V.CATA, Q.UNCOMMON)
    recipe:SetSkillLevels(475, 475, 490, 500, 510)
    recipe:SetRecipeItem(65423, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(62677, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddVendor(3027, 4223, 4553, 5160, 49701, 49737)

    -- Fortune Cookie -- 88019
    recipe = AddRecipe(88019, V.CATA, Q.UNCOMMON)
    recipe:SetSkillLevels(525, 525, 525, 525, 525)
    recipe:SetRecipeItem(65432, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(62649, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddVendor(3027, 4223, 4553, 5160, 49701, 49737)

    -- Grilled Dragon -- 88020
    recipe = AddRecipe(88020, V.CATA, Q.UNCOMMON)
    recipe:SetSkillLevels(500, 500, 515, 520, 525)
    recipe:SetRecipeItem(65428, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(62662, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.CASTER)
    recipe:AddVendor(3027, 4223, 4553, 5160, 49701, 49737)

    -- Hearty Seafood Soup -- 88021
    recipe = AddRecipe(88021, V.CATA, Q.UNCOMMON)
    recipe:SetSkillLevels(475, 475, 490, 497, 505)
    recipe:SetRecipeItem(65418, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(62659, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
    recipe:AddVendor(3027, 4223, 4553, 5160, 49701, 49737)

    -- Highland Spirits -- 88022
    recipe = AddRecipe(88022, V.CATA, Q.UNCOMMON)
    recipe:SetSkillLevels(450, 450, 455, 460, 465)
    recipe:SetRecipeItem(65415, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(62674, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddVendor(3027, 4223, 4553, 5160, 49701, 49737)

    -- Lavascale Fillet -- 88024
    recipe = AddRecipe(88024, V.CATA, Q.UNCOMMON)
    recipe:SetSkillLevels(450, 450, 465, 477, 490)
    recipe:SetRecipeItem(65407, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(62654, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.TANK)
    recipe:AddVendor(3027, 4223, 4553, 5160, 49701, 49737)

    -- Lavascale Minestrone -- 88025
    recipe = AddRecipe(88025, V.CATA, Q.UNCOMMON)
    recipe:SetSkillLevels(500, 500, 515, 520, 525)
    recipe:SetRecipeItem(65409, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(62663, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddVendor(3027, 4223, 4553, 5160, 49701, 49737)

    -- Lightly Fried Lurker -- 88028
    recipe = AddRecipe(88028, V.CATA, Q.UNCOMMON)
    recipe:SetSkillLevels(450, 450, 465, 477, 490)
    recipe:SetRecipeItem(65412, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(62651, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
    recipe:AddVendor(3027, 4223, 4553, 5160, 49701, 49737)

    -- Lurker Lunch -- 88030
    recipe = AddRecipe(88030, V.CATA, Q.UNCOMMON)
    recipe:SetSkillLevels(450, 450, 465, 477, 490)
    recipe:SetRecipeItem(65416, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(62657, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.TANK)
    recipe:AddVendor(3027, 4223, 4553, 5160, 49701, 49737)

    -- Mushroom Sauce Mudfish -- 88031
    recipe = AddRecipe(88031, V.CATA, Q.UNCOMMON)
    recipe:SetSkillLevels(500, 500, 515, 520, 525)
    recipe:SetRecipeItem(65420, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(62667, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.TANK)
    recipe:AddVendor(3027, 4223, 4553, 5160, 49701, 49737)

    -- Pickled Guppy -- 88033
    recipe = AddRecipe(88033, V.CATA, Q.UNCOMMON)
    recipe:SetSkillLevels(475, 475, 490, 497, 505)
    recipe:SetRecipeItem(65417, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(62660, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddVendor(3027, 4223, 4553, 5160, 49701, 49737)

    -- Blackbelly Sushi -- 88034
    recipe = AddRecipe(88034, V.CATA, Q.UNCOMMON)
    recipe:SetSkillLevels(500, 500, 515, 520, 525)
    recipe:SetRecipeItem(65424, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(62668, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.TANK)
    recipe:AddVendor(3027, 4223, 4553, 5160, 49701, 49737)

    -- Salted Eye -- 88035
    recipe = AddRecipe(88035, V.CATA, Q.UNCOMMON)
    recipe:SetSkillLevels(450, 450, 465, 477, 490)
    recipe:SetRecipeItem(65410, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(62653, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddVendor(3027, 4223, 4553, 5160, 49701, 49737)

    -- Seafood Magnifique Feast -- 88036
    recipe = AddRecipe(88036, V.CATA, Q.RARE)
    recipe:SetSkillLevels(525, 525, 525, 525, 525)
    recipe:SetRecipeItem(62800, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(62290, "BIND_ON_PICKUP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddAchievement(5036)
    recipe:AddVendor(46572, 46602, 51495, 51504, 51512)

    -- Seasoned Crab -- 88037
    recipe = AddRecipe(88037, V.CATA, Q.UNCOMMON)
    recipe:SetSkillLevels(450, 450, 465, 477, 490)
    recipe:SetRecipeItem(65413, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(62652, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.CASTER)
    recipe:AddVendor(3027, 4223, 4553, 5160, 49701, 49737)

    -- Severed Sagefish Head -- 88039
    recipe = AddRecipe(88039, V.CATA, Q.UNCOMMON)
    recipe:SetSkillLevels(500, 500, 515, 520, 525)
    recipe:SetRecipeItem(65421, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(62671, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddVendor(3027, 4223, 4553, 5160, 49701, 49737)

    -- Skewered Eel -- 88042
    recipe = AddRecipe(88042, V.CATA, Q.UNCOMMON)
    recipe:SetSkillLevels(500, 500, 515, 520, 525)
    recipe:SetRecipeItem(65425, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(62669, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
    recipe:AddVendor(3027, 4223, 4553, 5160, 49701, 49737)

    -- South Island Iced Tea -- 88044
    recipe = AddRecipe(88044, V.CATA, Q.UNCOMMON)
    recipe:SetSkillLevels(525, 525, 525, 525, 525)
    recipe:SetRecipeItem(65433, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(62672, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddVendor(3027, 4223, 4553, 5160, 49701, 49737)

    -- Starfire Espresso -- 88045
    recipe = AddRecipe(88045, V.CATA, Q.UNCOMMON)
    recipe:SetSkillLevels(450, 450, 455, 460, 465)
    recipe:SetRecipeItem(65414, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(62675, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddVendor(3027, 4223, 4553, 5160, 49701, 49737)

    -- Tender Baked Turtle -- 88046
    recipe = AddRecipe(88046, V.CATA, Q.UNCOMMON)
    recipe:SetSkillLevels(475, 475, 490, 497, 505)
    recipe:SetRecipeItem(65419, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(62658, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
    recipe:AddVendor(3027, 4223, 4553, 5160, 49701, 49737)

    -- Whitecrest Gumbo -- 88047
    recipe = AddRecipe(88047, V.CATA, Q.UNCOMMON)
    recipe:SetSkillLevels(450, 450, 465, 477, 490)
    recipe:SetRecipeItem(65406, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(62656, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
    recipe:AddVendor(3027, 4223, 4553, 5160, 49701, 49737)

    -- Venison Jerky -- 93741
    recipe = AddRecipe(93741, V.CATA, Q.COMMON)
    recipe:SetSkillLevels(40, 40, 80, 100, 120)
    recipe:SetCraftedItem(67230, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1355, 1382, 1430, 1699, 2818, 3026, 3067, 3399, 4210, 4552, 4894, 5159, 5482, 6286, 16253, 16719,
        17246, 18987, 18993, 19185, 19369, 26905, 26953, 26972, 26989, 28705, 29631, 33587, 33619, 42288, 42506, 45550,
        46709, 47405, 49789, 54232, 66353)

    -- Scalding Murglesnout -- 96133
    recipe = AddRecipe(96133, V.CATA, Q.UNCOMMON)
    recipe:SetSkillLevels(500, 500, 500, 500, 510)
    recipe:SetRecipeItem(68688, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(68687, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddVendor(3027, 4223, 4553, 5160, 49701, 49737)

    -------------------------------------------------------------------------------
    -- Mists of Pandaria.
    -------------------------------------------------------------------------------
    -- Golden Carp Consomme -- 104237
    recipe = AddRecipe(104237, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(500, 500, 510, 515, 520)
    recipe:SetCraftedItem(74636, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1355, 1699, 3026, 3067, 3399, 4210, 4894, 5159, 6286, 16719, 17246, 33587, 42288, 42506, 45550,
        46709, 47405, 56707, 64231, 66353)

    -- Fish Cake -- 104297
    recipe = AddRecipe(104297, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(500, 500, 510, 515, 520)
    recipe:SetCraftedItem(74641, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(1355, 1699, 3026, 3067, 3399, 4210, 4894, 5159, 6286, 16719, 17246, 33587, 42288, 42506, 45550,
        46709, 47405, 56707, 64231, 66353)

    -- Charbroiled Tiger Steak -- 104298
    recipe = AddRecipe(104298, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(525, 525, 535, 540, 545)
    recipe:SetCraftedItem(74642, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(58712)

    -- Eternal Blossom Fish -- 104299
    recipe = AddRecipe(104299, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(550, 550, 560, 565, 570)
    recipe:SetCraftedItem(74645, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(58712)

    -- Black Pepper Ribs and Shrimp -- 104300
    recipe = AddRecipe(104300, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(600, 600, 610, 615, 620)
    recipe:SetCraftedItem(74646, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(58712)

    -- Sauteed Carrots -- 104301
    recipe = AddRecipe(104301, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(525, 525, 535, 540, 545)
    recipe:SetCraftedItem(74643, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(58713)

    -- Valley Stir Fry -- 104302
    recipe = AddRecipe(104302, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(550, 550, 560, 565, 570)
    recipe:SetCraftedItem(74647, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(58713)

    -- Sea Mist Rice Noodles -- 104303
    recipe = AddRecipe(104303, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(600, 600, 610, 615, 620)
    recipe:SetCraftedItem(74648, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(58713)

    -- Swirling Mist Soup -- 104304
    recipe = AddRecipe(104304, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(525, 525, 535, 540, 545)
    recipe:SetCraftedItem(74644, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(58714)

    -- Braised Turtle -- 104305
    recipe = AddRecipe(104305, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(550, 550, 560, 565, 570)
    recipe:SetCraftedItem(74649, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(58714)

    -- Mogu Fish Stew -- 104306
    recipe = AddRecipe(104306, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(600, 600, 610, 615, 620)
    recipe:SetCraftedItem(74650, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(58714)

    -- Shrimp Dumplings -- 104307
    recipe = AddRecipe(104307, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(525, 525, 535, 540, 545)
    recipe:SetCraftedItem(74651, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(58715)

    -- Fire Spirit Salmon -- 104308
    recipe = AddRecipe(104308, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(550, 550, 560, 565, 570)
    recipe:SetCraftedItem(74652, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(58715)

    -- Steamed Crab Surprise -- 104309
    recipe = AddRecipe(104309, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(600, 600, 610, 615, 620)
    recipe:SetCraftedItem(74653, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(58715)

    -- Wildfowl Roast -- 104310
    recipe = AddRecipe(104310, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(525, 525, 535, 540, 545)
    recipe:SetCraftedItem(74654, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(58716)

    -- Twin Fish Platter -- 104311
    recipe = AddRecipe(104311, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(550, 550, 560, 565, 570)
    recipe:SetCraftedItem(74655, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(58716)

    -- Chun Tian Spring Rolls -- 104312
    recipe = AddRecipe(104312, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(600, 600, 610, 615, 620)
    recipe:SetCraftedItem(74656, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(58716)

    -- Pandaren Banquet -- 105190
    recipe = AddRecipe(105190, V.MOP, Q.UNCOMMON)
    recipe:SetSkillLevels(600, 600, 600, 600, 600)
    recipe:SetRecipeItem(75013, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(74919, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddVendor(64395)

    -- Great Pandaren Banquet -- 105194
    recipe = AddRecipe(105194, V.MOP, Q.UNCOMMON)
    recipe:SetSkillLevels(600, 600, 600, 600, 600)
    recipe:SetRecipeItem(75017, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(75016, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddVendor(64395)

    -- Viseclaw Soup -- 124029
    recipe = AddRecipe(124029, V.MOP, Q.UNCOMMON)
    recipe:SetSkillLevels(525, 525, 525, 525, 530)
    recipe:SetRecipeItem(85502, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(85501, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddRepVendor(FAC.ANGLERS, REP.FRIENDLY, 63721)

    -- Krasarang Fritters -- 124032
    recipe = AddRecipe(124032, V.MOP, Q.UNCOMMON)
    recipe:SetSkillLevels(525, 525, 525, 525, 530)
    recipe:SetRecipeItem(85505, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(85504, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddRepVendor(FAC.ANGLERS, REP.FRIENDLY, 63721)

    -- Ginseng Tea -- 124052
    recipe = AddRecipe(124052, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(525, 525, 535, 540, 545)
    recipe:SetCraftedItem(75026, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(58717)

    -- Jade Witch Brew -- 124053
    recipe = AddRecipe(124053, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(550, 550, 560, 565, 570)
    recipe:SetCraftedItem(75037, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(58717)

    -- Mad Brewer's Breakfast -- 124054
    recipe = AddRecipe(124054, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(600, 600, 610, 615, 620)
    recipe:SetCraftedItem(75038, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(58717)

    -- Pounded Rice Cake -- 124223
    recipe = AddRecipe(124223, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(120, 120, 130, 135, 140)
    recipe:SetCraftedItem(81400, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(56707, 64231)

    -- Yak Cheese Curds -- 124224
    recipe = AddRecipe(124224, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(150, 150, 160, 165, 170)
    recipe:SetCraftedItem(81401, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(56707, 64231)

    -- Toasted Fish Jerky -- 124225
    recipe = AddRecipe(124225, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(60, 60, 70, 75, 80)
    recipe:SetCraftedItem(81402, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(56707, 64231)

    -- Dried Peaches -- 124226
    recipe = AddRecipe(124226, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(180, 180, 190, 195, 200)
    recipe:SetCraftedItem(81403, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(56707, 64231)

    -- Dried Needle Mushrooms -- 124227
    recipe = AddRecipe(124227, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(90, 90, 100, 105, 110)
    recipe:SetCraftedItem(81404, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(56707, 64231)

    -- Boiled Silkworm Pupa -- 124228
    recipe = AddRecipe(124228, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(210, 210, 220, 225, 230)
    recipe:SetCraftedItem(81405, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(56707, 64231)

    -- Red Bean Bun -- 124229
    recipe = AddRecipe(124229, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(360, 360, 370, 375, 380)
    recipe:SetCraftedItem(81408, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(56707, 64231)

    -- Tangy Yogurt -- 124230
    recipe = AddRecipe(124230, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(480, 480, 490, 495, 500)
    recipe:SetCraftedItem(81409, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(56707, 64231)

    -- Green Curry Fish -- 124231
    recipe = AddRecipe(124231, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(420, 420, 430, 435, 440)
    recipe:SetCraftedItem(81410, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(56707, 64231)

    -- Peach Pie -- 124232
    recipe = AddRecipe(124232, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(450, 450, 460, 465, 470)
    recipe:SetCraftedItem(81411, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(56707, 64231)

    -- Blanched Needle Mushrooms -- 124233
    recipe = AddRecipe(124233, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(330, 330, 340, 345, 350)
    recipe:SetCraftedItem(81412, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(56707, 64231)

    -- Skewered Peanut Chicken -- 124234
    recipe = AddRecipe(124234, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(390, 390, 400, 405, 410)
    recipe:SetCraftedItem(81413, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(56707, 64231)

    -- Perfectly Cooked Instant Noodles -- 125067
    recipe = AddRecipe(125067, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(30, 30, 40, 45, 50)
    recipe:SetCraftedItem(86026, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(56707, 64231)

    -- Roasted Barley Tea -- 125078
    recipe = AddRecipe(125078, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(240, 240, 250, 255, 260)
    recipe:SetCraftedItem(81406, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(56707, 64231)

    -- Pearl Milk Tea -- 125080
    recipe = AddRecipe(125080, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(495, 495, 505, 510, 515)
    recipe:SetCraftedItem(81414, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(56707, 64231)

    -- Sliced Peaches -- 125117
    recipe = AddRecipe(125117, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 11, 16, 21)
    recipe:SetCraftedItem(86057, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(56707, 64231)

    -- Spicy Salmon -- 125120
    recipe = AddRecipe(125120, V.MOP, Q.UNCOMMON)
    recipe:SetSkillLevels(500, 500, 500, 500, 600)
    recipe:SetRecipeItem(74657, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(86073, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.CASTER)
    recipe:AddRepVendor(FAC.TILLERS, REP.EXALTED, 58706)

    -- Wildfowl Ginseng Soup -- 125121
    recipe = AddRecipe(125121, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(510, 510, 520, 525, 530)
    recipe:SetCraftedItem(86070, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(56707, 64231)

    -- Rice Pudding -- 125122
    recipe = AddRecipe(125122, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(520, 520, 530, 535, 540)
    recipe:SetCraftedItem(86069, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(56707, 64231)

    -- Spicy Vegetable Chips -- 125123
    recipe = AddRecipe(125123, V.MOP, Q.UNCOMMON)
    recipe:SetSkillLevels(500, 500, 500, 500, 600)
    recipe:SetRecipeItem(74658, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(86074, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.TANK)
    recipe:AddRepVendor(FAC.TILLERS, REP.EXALTED, 58706)

    -- Banquet of the Grill -- 125141
    recipe = AddRecipe(125141, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(575, 575, 585, 590, 595)
    recipe:SetCraftedItem(87226, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(58712)

    -- Great Banquet of the Grill -- 125142
    recipe = AddRecipe(125142, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(575, 575, 585, 590, 595)
    recipe:SetCraftedItem(87228, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(58712)

    -- Banquet of the Wok -- 125594
    recipe = AddRecipe(125594, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(575, 575, 585, 590, 595)
    recipe:SetCraftedItem(87230, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(58713)

    -- Great Banquet of the Wok -- 125595
    recipe = AddRecipe(125595, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(575, 575, 585, 590, 595)
    recipe:SetCraftedItem(87232, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(58713)

    -- Banquet of the Pot -- 125596
    recipe = AddRecipe(125596, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(575, 575, 585, 590, 595)
    recipe:SetCraftedItem(87234, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(58714)

    -- Great Banquet of the Pot -- 125597
    recipe = AddRecipe(125597, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(575, 575, 585, 590, 595)
    recipe:SetCraftedItem(87236, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(58714)

    -- Banquet of the Steamer -- 125598
    recipe = AddRecipe(125598, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(575, 575, 585, 590, 595)
    recipe:SetCraftedItem(87238, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(58715)

    -- Great Banquet of the Steamer -- 125599
    recipe = AddRecipe(125599, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(575, 575, 585, 590, 595)
    recipe:SetCraftedItem(87240, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(58715)

    -- Banquet of the Oven -- 125600
    recipe = AddRecipe(125600, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(575, 575, 585, 590, 595)
    recipe:SetCraftedItem(87242, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(58716)

    -- Great Banquet of the Oven -- 125601
    recipe = AddRecipe(125601, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(575, 575, 585, 590, 595)
    recipe:SetCraftedItem(87244, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(58716)

    -- Banquet of the Brew -- 125602
    recipe = AddRecipe(125602, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(575, 575, 585, 590, 595)
    recipe:SetCraftedItem(87246, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(58717)

    -- Great Banquet of the Brew -- 125603
    recipe = AddRecipe(125603, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(575, 575, 585, 590, 595)
    recipe:SetCraftedItem(87248, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddTrainer(58717)

    -- Four Senses Brew -- 126654
    recipe = AddRecipe(126654, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(600, 600, 600, 602, 605)
    recipe:SetRecipeItem(86393, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(87264, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MISC1)
    recipe:AddCustom("FOUR_SENSES_BREW")

    -- Banana Infused Rum -- 126655
    recipe = AddRecipe(126655, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(600, 600, 600, 602, 605)
    recipe:SetRecipeItem(87266, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(86432, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MISC1)
    recipe:AddCustom("BANANA_INFUSED_RUM")

    -- Noodle Cart Kit -- 145038
    recipe = AddRecipe(145038, V.MOP, Q.UNCOMMON)
    recipe:SetSkillLevels(600, 600, 600, 600, 600)
    recipe:SetRecipeItem(101631, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(101630, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddQuest(33022)
    recipe:AddCustom("TIMELESS_ISLE_COOKING")

    -- Deluxe Noodle Cart Kit -- 145061
    recipe = AddRecipe(145061, V.MOP, Q.UNCOMMON)
    recipe:SetSkillLevels(600, 600, 600, 600, 600)
    recipe:SetRecipeItem(101664, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(101661, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddQuest(33024)
    recipe:AddCustom("TIMELESS_ISLE_COOKING")

    -- Pandaren Treasure Noodle Cart Kit -- 145062
    recipe = AddRecipe(145062, V.MOP, Q.UNCOMMON)
    recipe:SetSkillLevels(600, 600, 600, 600, 611)
    recipe:SetRecipeItem(101663, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(101662, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE)
    recipe:AddQuest(33027)
    recipe:AddCustom("TIMELESS_ISLE_COOKING")

    -- Seasoned Pomfruit Slices -- 145305
    recipe = AddRecipe(145305, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(600, 600, 600, 600, 600)
    recipe:SetRecipeItem(101765, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(101746, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MISC1)
    recipe:AddCustom("ANCIENT_GUO-LAI_CACHE")

    -- Spiced Blossom Soup -- 145307
    recipe = AddRecipe(145307, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(600, 600, 600, 600, 600)
    recipe:SetRecipeItem(101766, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(101748, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MISC1)
    recipe:AddCustom("ANCIENT_GUO-LAI_CACHE")

    -- Mango Ice -- 145308
    recipe = AddRecipe(145308, V.MOP, Q.UNCOMMON)
    recipe:SetSkillLevels(600, 600, 600, 600, 600)
    recipe:SetRecipeItem(101767, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(101745, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MISC1)
    recipe:AddCustom("ANCIENT_GUO-LAI_CACHE")

    -- Farmer's Delight -- 145309
    recipe = AddRecipe(145309, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(600, 600, 600, 600, 600)
    recipe:SetRecipeItem(101768, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(101747, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MISC1)
    recipe:AddCustom("ANCIENT_GUO-LAI_CACHE")

    -- Stuffed Lushrooms -- 145310
    recipe = AddRecipe(145310, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(600, 600, 600, 600, 600)
    recipe:SetRecipeItem(101769, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(101749, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MISC1)
    recipe:AddCustom("ANCIENT_GUO-LAI_CACHE")

    -- Fluffy Silkfeather Omelet -- 145311
    recipe = AddRecipe(145311, V.MOP, Q.COMMON)
    recipe:SetSkillLevels(600, 600, 600, 600, 600)
    recipe:SetRecipeItem(101770, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(101750, "BIND_ON_EQUIP")
    recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MISC1)
    recipe:AddCustom("ANCIENT_GUO-LAI_CACHE")

    self.InitializeRecipes = nil
end
