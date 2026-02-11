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
    -- Rough Blasting Powder -- 3918
    recipe = AddRecipe(3918, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 20, 30, 40)
    recipe:SetCraftedItem(4357, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_MATERIALS")
    recipe:AddCustom("DEFAULT_RECIPE")

    -- Rough Dynamite -- 3919
    recipe = AddRecipe(3919, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 30, 45, 60)
    recipe:SetCraftedItem(4358, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
    recipe:AddCustom("DEFAULT_RECIPE")

    -- Handful of Copper Bolts -- 3922
    recipe = AddRecipe(3922, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(30, 30, 45, 52, 60)
    recipe:SetCraftedItem(4359, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_MATERIALS")
    recipe:AddTrainer(11017, 11025, 17634, 3494, 1702, 25277, 18752, 17637, 1676, 26907, 19576, 26955, 17222, 16726, 5518,
        11037, 16667, 33611, 8736, 18775, 28697, 26991, 11031, 33586, 3290, 5174, 33634)

    -- Rough Copper Bomb -- 3923
    recipe = AddRecipe(3923, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(30, 30, 60, 75, 90)
    recipe:SetCraftedItem(4360, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
    recipe:AddTrainer(11017, 11025, 17634, 3494, 1702, 25277, 18752, 17637, 1676, 26907, 33634, 26955, 17222, 16726, 5518,
        11037, 16667, 33611, 8736, 18775, 28697, 26991, 11031, 33586, 3290, 5174, 19576)

    -- Rough Boomstick -- 3925
    recipe = AddRecipe(3925, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(50, 50, 80, 95, 110)
    recipe:SetCraftedItem(4362, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_GUN")
    recipe:AddTrainer(11017, 11025, 17634, 3494, 1702, 25277, 18752, 17637, 1676, 26907, 33634, 26955, 17222, 16726, 5518,
        11037, 16667, 33611, 8736, 18775, 28697, 26991, 11031, 33586, 3290, 5174, 19576)

    -- Mechanical Squirrel Box -- 3928
    recipe = AddRecipe(3928, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(75, 75, 105, 120, 135)
    recipe:SetRecipeItem(4408, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(4401, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_PET")
    recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

    -- Coarse Blasting Powder -- 3929
    recipe = AddRecipe(3929, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(65, 65, 75, 80, 85)
    recipe:SetCraftedItem(4364, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_MATERIALS")
    recipe:AddTrainer(11017, 11025, 17634, 3494, 1702, 25277, 18752, 17637, 1676, 26907, 33634, 26955, 17222, 16726, 5518,
        11037, 16667, 33611, 8736, 18775, 28697, 26991, 11031, 33586, 3290, 5174, 19576)

    -- Coarse Dynamite -- 3931
    recipe = AddRecipe(3931, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(65, 65, 75, 80, 85)
    recipe:SetCraftedItem(4365, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
    recipe:AddTrainer(11017, 11025, 17634, 3494, 1702, 25277, 18752, 17637, 1676, 26907, 33634, 26955, 17222, 16726, 5518,
        11037, 16667, 33611, 8736, 18775, 28697, 26991, 11031, 33586, 3290, 5174, 19576)

    -- Target Dummy -- 3932
    recipe = AddRecipe(3932, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(85, 85, 115, 130, 145)
    recipe:SetCraftedItem(4366, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
    recipe:AddTrainer(11017, 11025, 17634, 3494, 1702, 25277, 18752, 17637, 1676, 26907, 19576, 26955, 28697, 17222, 5518,
        11037, 18775, 33611, 8736, 16667, 3290, 26991, 11031, 33586, 5174, 33634, 16726)

    -- Small Seaforium Charge -- 3933
    recipe = AddRecipe(3933, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(100, 100, 130, 145, 160)
    recipe:SetRecipeItem(4409, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(4367, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
    recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

    -- Flying Tiger Goggles -- 3934
    recipe = AddRecipe(3934, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(100, 100, 130, 145, 160)
    recipe:SetCraftedItem(4368, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_HEAD")
    recipe:AddFilters(F.CASTER, F.HEALER)
    recipe:AddTrainer(11017, 11025, 17634, 3494, 1702, 25277, 18752, 17637, 1676, 26907, 19576, 26955, 28697, 17222, 5518,
        11037, 18775, 33611, 8736, 16667, 3290, 26991, 11031, 33586, 5174, 33634, 16726)

    -- Deadly Blunderbuss -- 3936
    recipe = AddRecipe(3936, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(105, 105, 130, 142, 155)
    recipe:SetCraftedItem(4369, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_GUN")
    recipe:AddTrainer(11017, 11025, 17634, 3494, 1702, 25277, 18752, 17637, 1676, 26907, 19576, 26955, 16667, 17222, 5518,
        11037, 28697, 33611, 8736, 18775, 3290, 26991, 11031, 33586, 5174, 33634, 16726)

    -- Large Copper Bomb -- 3937
    recipe = AddRecipe(3937, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(105, 105, 105, 130, 155)
    recipe:SetCraftedItem(4370, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
    recipe:AddTrainer(11017, 11025, 17634, 3494, 1702, 25277, 18752, 17637, 1676, 26907, 19576, 26955, 16667, 17222, 5518,
        11037, 28697, 33611, 8736, 18775, 3290, 26991, 11031, 33586, 5174, 33634, 16726)

    -- Bronze Tube -- 3938
    recipe = AddRecipe(3938, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(105, 105, 105, 130, 155)
    recipe:SetCraftedItem(4371, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_MATERIALS")
    recipe:AddTrainer(11017, 11025, 17634, 3494, 1702, 25277, 18752, 17637, 1676, 26907, 19576, 26955, 16667, 17222, 5518,
        11037, 28697, 33611, 8736, 18775, 3290, 26991, 11031, 33586, 5174, 33634, 16726)

    -- Lovingly Crafted Boomstick -- 3939
    recipe = AddRecipe(3939, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(120, 120, 145, 157, 170)
    recipe:SetCraftedItem(4372, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_GUN")
    recipe:AddTrainer(1702, 3494, 4941, 5174, 5518, 8736, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 25099, 45545)

    -- Shadow Goggles -- 3940
    recipe = AddRecipe(3940, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(120, 120, 145, 157, 170)
    recipe:SetRecipeItem(4410, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(4373, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_HEAD")
    recipe:AddFilters(F.CASTER, F.HEALER)
    recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

    -- Small Bronze Bomb -- 3941
    recipe = AddRecipe(3941, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(120, 120, 120, 145, 170)
    recipe:SetCraftedItem(4374, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
    recipe:AddTrainer(11017, 11025, 17634, 3494, 1702, 25277, 18752, 17637, 1676, 26907, 19576, 26955, 16667, 17222, 5518,
        11037, 28697, 33611, 8736, 18775, 3290, 26991, 11031, 33586, 5174, 33634, 16726)

    -- Whirring Bronze Gizmo -- 3942
    recipe = AddRecipe(3942, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(125, 125, 125, 150, 175)
    recipe:SetCraftedItem(4375, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_MATERIALS")
    recipe:AddTrainer(11017, 11025, 17634, 3494, 1702, 25277, 18752, 17637, 1676, 26907, 19576, 26955, 16667, 17222, 5518,
        11037, 28697, 33611, 8736, 18775, 3290, 26991, 11031, 33586, 5174, 33634, 16726)

    -- Flame Deflector -- 3944
    recipe = AddRecipe(3944, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(125, 125, 125, 150, 175)
    recipe:SetRecipeItem(4411, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(4376, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
    recipe:AddMobDrop(7800)

    -- Heavy Blasting Powder -- 3945
    recipe = AddRecipe(3945, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(125, 125, 125, 135, 145)
    recipe:SetCraftedItem(4377, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_MATERIALS")
    recipe:AddTrainer(11017, 11025, 17634, 3494, 1702, 25277, 18752, 17637, 1676, 26907, 19576, 26955, 16667, 17222, 5518,
        11037, 28697, 33611, 8736, 18775, 3290, 26991, 11031, 33586, 5174, 33634, 16726)

    -- Heavy Dynamite -- 3946
    recipe = AddRecipe(3946, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(125, 125, 125, 135, 145)
    recipe:SetCraftedItem(4378, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
    recipe:AddTrainer(11017, 11025, 17634, 3494, 1702, 25277, 18752, 17637, 1676, 26907, 19576, 26955, 16667, 17222, 5518,
        11037, 28697, 33611, 8736, 18775, 3290, 26991, 11031, 33586, 5174, 33634, 16726)

    -- Silver-plated Shotgun -- 3949
    recipe = AddRecipe(3949, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(130, 130, 155, 167, 180)
    recipe:SetCraftedItem(4379, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_GUN")
    recipe:AddTrainer(11017, 11025, 17634, 3494, 1702, 25277, 18752, 17637, 1676, 26907, 19576, 26955, 16667, 17222, 5518,
        11037, 28697, 33611, 8736, 18775, 3290, 26991, 11031, 33586, 5174, 33634, 16726)

    -- Big Bronze Bomb -- 3950
    recipe = AddRecipe(3950, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(140, 140, 140, 165, 190)
    recipe:SetCraftedItem(4380, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
    recipe:AddTrainer(11017, 11025, 17634, 3494, 1702, 25277, 18752, 17637, 1676, 26907, 19576, 26955, 16667, 17222, 5518,
        11037, 28697, 33611, 8736, 18775, 3290, 26991, 11031, 33586, 5174, 33634, 16726)

    -- Minor Recombobulator -- 3952
    recipe = AddRecipe(3952, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(140, 140, 165, 177, 190)
    recipe:SetRecipeItem(14639, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(4381, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_TRINKET")
    recipe:AddLimitedVendor(3495, 1, 41435, 1)

    -- Bronze Framework -- 3953
    recipe = AddRecipe(3953, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(145, 145, 145, 170, 195)
    recipe:SetCraftedItem(4382, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_MATERIALS")
    recipe:AddTrainer(11017, 11025, 17634, 3494, 1702, 25277, 18752, 17637, 1676, 26907, 19576, 26955, 16667, 17222, 5518,
        11037, 28697, 33611, 8736, 18775, 3290, 26991, 11031, 33586, 5174, 33634, 16726)

    -- Moonsight Rifle -- 3954
    recipe = AddRecipe(3954, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(145, 145, 170, 182, 195)
    recipe:SetRecipeItem(4412, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(4383, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_GUN")
    recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

    -- Explosive Sheep -- 3955
    recipe = AddRecipe(3955, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(150, 150, 175, 187, 200)
    recipe:SetCraftedItem(4384, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
    recipe:AddTrainer(11017, 11025, 17634, 3494, 1702, 25277, 18752, 17637, 1676, 26907, 19576, 26955, 16667, 17222, 5518,
        11037, 28697, 33611, 8736, 18775, 3290, 26991, 11031, 33586, 5174, 33634, 16726)

    -- Green Tinted Goggles -- 3956
    recipe = AddRecipe(3956, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(150, 150, 175, 187, 200)
    recipe:SetCraftedItem(4385, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_HEAD")
    recipe:AddFilters(F.CASTER, F.HEALER)
    recipe:AddTrainer(11017, 11025, 17634, 3494, 1702, 25277, 18752, 17637, 1676, 26907, 19576, 26955, 16667, 17222, 5518,
        11037, 28697, 33611, 8736, 18775, 3290, 26991, 11031, 33586, 5174, 33634, 16726)

    -- Ice Deflector -- 3957
    recipe = AddRecipe(3957, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(155, 155, 175, 185, 195)
    recipe:SetRecipeItem(13308, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(4386, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")


    -- Iron Strut -- 3958
    recipe = AddRecipe(3958, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(160, 160, 160, 170, 180)
    recipe:SetCraftedItem(4387, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_MATERIALS")
    recipe:AddTrainer(11017, 11025, 17634, 3494, 1702, 25277, 18752, 17637, 1676, 26907, 19576, 26955, 33586, 17222, 5518,
        11037, 28697, 33611, 8736, 16667, 18775, 26991, 11031, 3290, 5174, 33634, 16726)

    -- Discombobulator Ray -- 3959
    recipe = AddRecipe(3959, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(160, 160, 180, 190, 200)
    recipe:SetRecipeItem(4413, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(4388, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
    recipe:AddFilters(F.CASTER, F.HEALER)
    recipe:AddMobDrop(7800)

    -- Portable Bronze Mortar -- 3960
    recipe = AddRecipe(3960, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(165, 165, 185, 195, 210)
    recipe:SetRecipeItem(4414, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(4403, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
    recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

    -- Gyrochronatom -- 3961
    recipe = AddRecipe(3961, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(170, 170, 170, 190, 210)
    recipe:SetCraftedItem(4389, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_MATERIALS")
    recipe:AddTrainer(11017, 11025, 17634, 3494, 1702, 25277, 18752, 17637, 1676, 26907, 19576, 26955, 33586, 17222, 5518,
        11037, 28697, 33611, 8736, 16667, 18775, 26991, 11031, 3290, 5174, 33634, 16726)

    -- Iron Grenade -- 3962
    recipe = AddRecipe(3962, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(175, 175, 175, 195, 215)
    recipe:SetCraftedItem(4390, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
    recipe:AddTrainer(11017, 11025, 17634, 3494, 1702, 25277, 18752, 17637, 1676, 26907, 19576, 26955, 33586, 17222, 5518,
        11037, 28697, 33611, 8736, 16667, 18775, 26991, 11031, 3290, 5174, 33634, 16726)

    -- Compact Harvest Reaper Kit -- 3963
    recipe = AddRecipe(3963, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(175, 175, 175, 195, 215)
    recipe:SetCraftedItem(4391, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
    recipe:AddTrainer(11017, 11025, 17634, 3494, 1702, 25277, 18752, 17637, 1676, 26907, 19576, 26955, 33586, 17222, 5518,
        11037, 28697, 33611, 8736, 16667, 18775, 26991, 11031, 3290, 5174, 33634, 16726)

    -- Advanced Target Dummy -- 3965
    recipe = AddRecipe(3965, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(185, 185, 185, 205, 225)
    recipe:SetCraftedItem(4392, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
    recipe:AddTrainer(11017, 11025, 17634, 3494, 1702, 25277, 18752, 17637, 1676, 26907, 19576, 26955, 33586, 17222, 5518,
        11037, 28697, 33611, 8736, 16667, 18775, 26991, 11031, 3290, 5174, 33634, 16726)

    -- Craftsman's Monocle -- 3966
    recipe = AddRecipe(3966, V.ORIG, Q.RARE)
    recipe:SetSkillLevels(185, 185, 205, 215, 225)
    recipe:SetRecipeItem(4415, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(4393, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_HEAD")
    recipe:AddFilters(F.CASTER, F.HEALER)
    recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

    -- Big Iron Bomb -- 3967
    recipe = AddRecipe(3967, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(190, 190, 190, 210, 230)
    recipe:SetCraftedItem(4394, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
    recipe:AddTrainer(11017, 11025, 17634, 3494, 1702, 18752, 17637, 1676, 26907, 19576, 26955, 33586, 17222, 5518, 11037,
        28697, 33611, 8736, 16667, 18775, 26991, 11031, 3290, 5174, 33634, 16726)

    -- Goblin Land Mine -- 3968
    recipe = AddRecipe(3968, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(195, 195, 215, 225, 235)
    recipe:SetRecipeItem(4416, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(4395, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
    recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

    -- Mechanical Dragonling -- 3969
    recipe = AddRecipe(3969, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(200, 200, 220, 230, 240)
    recipe:SetRecipeItem(13311, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(4396, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_TRINKET")
    recipe:AddLimitedVendor(2687, 1, 35826, 1)

    -- Gnomish Cloaking Device -- 3971
    recipe = AddRecipe(3971, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(200, 200, 220, 230, 240)
    recipe:SetRecipeItem(7742, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(4397, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_TRINKET")
    recipe:AddMobDrop(7800)
    recipe:AddLimitedVendor(6777, 1)

    -- Large Seaforium Charge -- 3972
    recipe = AddRecipe(3972, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(200, 200, 200, 220, 240)
    recipe:SetRecipeItem(4417, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(4398, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
    recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

    -- Silver Contact -- 3973
    recipe = AddRecipe(3973, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(90, 90, 110, 125, 140)
    recipe:SetCraftedItem(4404, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_MATERIALS")
    recipe:AddTrainer(11017, 11025, 17634, 3494, 1702, 25277, 18752, 17637, 1676, 26907, 19576, 26955, 28697, 17222, 5518,
        11037, 18775, 33611, 8736, 16667, 3290, 26991, 11031, 33586, 5174, 33634, 16726)

    -- Crude Scope -- 3977
    recipe = AddRecipe(3977, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(60, 60, 90, 105, 120)
    recipe:SetCraftedItem(4405, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_ITEM_ENHANCEMENT")
    recipe:AddTrainer(11017, 11025, 17634, 3494, 1702, 25277, 18752, 17637, 1676, 26907, 33634, 26955, 17222, 16726, 5518,
        11037, 16667, 33611, 8736, 18775, 28697, 26991, 11031, 33586, 3290, 5174, 19576)

    -- Standard Scope -- 3978
    recipe = AddRecipe(3978, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(110, 110, 135, 147, 160)
    recipe:SetCraftedItem(4406, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_ITEM_ENHANCEMENT")
    recipe:AddTrainer(11017, 11025, 17634, 3494, 1702, 25277, 18752, 17637, 1676, 26907, 19576, 26955, 16667, 17222, 5518,
        11037, 28697, 33611, 8736, 18775, 3290, 26991, 11031, 33586, 5174, 33634, 16726)

    -- Accurate Scope -- 3979
    recipe = AddRecipe(3979, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(180, 180, 200, 210, 220)
    recipe:SetCraftedItem(4407, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_ITEM_ENHANCEMENT")
    recipe:AddTrainer(1702, 4941, 5174, 5518, 8736, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 25099, 45545, 52636,
        52651)

    -- Ornate Spyglass -- 6458
    recipe = AddRecipe(6458, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(135, 135, 160, 172, 185)
    recipe:SetCraftedItem(5507, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
    recipe:AddTrainer(11017, 11025, 17634, 3494, 1702, 25277, 18752, 17637, 1676, 26907, 19576, 26955, 16667, 17222, 5518,
        11037, 28697, 33611, 8736, 18775, 3290, 26991, 11031, 33586, 5174, 33634, 16726)

    -- Arclight Spanner -- 7430
    recipe = AddRecipe(7430, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(50, 50, 70, 80, 90)
    recipe:SetCraftedItem(6219, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_MAIN_HAND")
    recipe:AddTrainer(11017, 11025, 17634, 3494, 1702, 25277, 18752, 17637, 1676, 26907, 33634, 26955, 17222, 16726, 5518,
        11037, 16667, 33611, 8736, 18775, 28697, 26991, 11031, 33586, 3290, 5174, 19576)

    -- Flash Bomb -- 8243
    recipe = AddRecipe(8243, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(185, 185, 185, 205, 225)
    recipe:SetRecipeItem(6672, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(4852, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
    recipe:AddMobDrop(7800)

    -- Clockwork Box -- 8334
    recipe = AddRecipe(8334, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(100, 100, 115, 122, 130)
    recipe:SetCraftedItem(6712, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
    recipe:AddTrainer(11017, 11025, 17634, 3494, 1702, 25277, 18752, 17637, 1676, 26907, 19576, 26955, 28697, 17222, 5518,
        11037, 18775, 33611, 8736, 16667, 3290, 26991, 11031, 33586, 5174, 33634, 16726)

    -- EZ-Thro Dynamite -- 8339
    recipe = AddRecipe(8339, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(100, 100, 115, 122, 130)
    recipe:SetRecipeItem(6716, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(6714, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
    recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

    -- Goblin Rocket Boots -- 8895
    recipe = AddRecipe(8895, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(225, 225, 245, 255, 265)
    recipe:SetCraftedItem(7189, "BIND_ON_EQUIP")
    recipe:SetSpecialty(20222)
    recipe:SetItemFilterType("ENGINEERING_FEET")
    recipe:AddTrainer(8126, 29513)

    -- Gnomish Universal Remote -- 9269
    recipe = AddRecipe(9269, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(125, 125, 150, 162, 175)
    recipe:SetRecipeItem(7560, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(7506, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_TRINKET")
    recipe:AddMobDrop(7800)
    recipe:AddVendor(5175, 6730)

    -- Aquadynamic Fish Attractor -- 9271
    recipe = AddRecipe(9271, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(150, 150, 150, 160, 170)
    recipe:SetCraftedItem(6533, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
    recipe:AddTrainer(11017, 11025, 17634, 3494, 1702, 25277, 18752, 17637, 1676, 26907, 19576, 26955, 16667, 17222, 5518,
        11037, 28697, 33611, 8736, 18775, 3290, 26991, 11031, 33586, 5174, 33634, 16726)

    -- Goblin Jumper Cables -- 9273
    recipe = AddRecipe(9273, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(165, 165, 165, 180, 200)
    recipe:SetRecipeItem(7561, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(7148, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
    recipe:AddMobDrop(7800)
    recipe:AddLimitedVendor(3134, 1, 3537, 1)

    -- Gold Power Core -- 12584
    recipe = AddRecipe(12584, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(150, 150, 150, 170, 190)
    recipe:SetCraftedItem(10558, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_MATERIALS")
    recipe:AddTrainer(11017, 11025, 17634, 3494, 1702, 25277, 18752, 17637, 1676, 26907, 19576, 26955, 16667, 17222, 5518,
        11037, 28697, 33611, 8736, 18775, 3290, 26991, 11031, 33586, 5174, 33634, 16726)

    -- Solid Blasting Powder -- 12585
    recipe = AddRecipe(12585, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(175, 175, 175, 185, 195)
    recipe:SetCraftedItem(10505, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_MATERIALS")
    recipe:AddTrainer(11017, 11025, 17634, 3494, 1702, 25277, 18752, 17637, 1676, 26907, 19576, 26955, 33586, 17222, 5518,
        11037, 28697, 33611, 8736, 16667, 18775, 26991, 11031, 3290, 5174, 33634, 16726)

    -- Solid Dynamite -- 12586
    recipe = AddRecipe(12586, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(175, 175, 175, 185, 195)
    recipe:SetCraftedItem(10507, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
    recipe:AddTrainer(11017, 11025, 17634, 3494, 1702, 25277, 18752, 17637, 1676, 26907, 19576, 26955, 33586, 17222, 5518,
        11037, 28697, 33611, 8736, 16667, 18775, 26991, 11031, 3290, 5174, 33634, 16726)

    -- Bright-Eye Goggles -- 12587
    recipe = AddRecipe(12587, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(175, 175, 195, 205, 215)
    recipe:SetRecipeItem(10601, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(10499, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_HEAD")
    recipe:AddFilters(F.CASTER, F.HEALER)
    recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

    -- Mithril Tube -- 12589
    recipe = AddRecipe(12589, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(195, 195, 195, 215, 235)
    recipe:SetCraftedItem(10559, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_MATERIALS")
    recipe:AddTrainer(11017, 11025, 17634, 3494, 1702, 25277, 18752, 17637, 1676, 26907, 19576, 26955, 33586, 17222, 5518,
        11037, 28697, 33611, 8736, 16667, 18775, 26991, 11031, 3290, 5174, 33634, 16726)

    -- Gyromatic Micro-Adjustor -- 12590
    recipe = AddRecipe(12590, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(175, 175, 175, 195, 215)
    recipe:SetCraftedItem(10498, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_MATERIALS")
    recipe:AddTrainer(11017, 11025, 17634, 3494, 1702, 25277, 18752, 17637, 1676, 26907, 19576, 26955, 33586, 17222, 5518,
        11037, 28697, 33611, 8736, 16667, 18775, 26991, 11031, 3290, 5174, 33634, 16726)

    -- Unstable Trigger -- 12591
    recipe = AddRecipe(12591, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(200, 200, 200, 220, 240)
    recipe:SetCraftedItem(10560, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_MATERIALS")
    recipe:AddTrainer(11017, 11025, 17634, 3494, 1702, 25277, 18752, 17637, 1676, 26907, 19576, 26955, 33586, 17222, 5518,
        11037, 28697, 33611, 8736, 16667, 18775, 26991, 11031, 3290, 5174, 33634, 16726)

    -- Fire Goggles -- 12594
    recipe = AddRecipe(12594, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(205, 205, 225, 235, 245)
    recipe:SetCraftedItem(10500, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_HEAD")
    recipe:AddTrainer(11017, 11025, 17634, 3494, 1702, 25277, 18752, 17637, 1676, 26907, 19576, 26955, 33586, 17222, 5518,
        11037, 28697, 33611, 8736, 16667, 18775, 26991, 11031, 3290, 5174, 33634, 16726)

    -- Mithril Blunderbuss -- 12595
    recipe = AddRecipe(12595, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(205, 205, 225, 235, 245)
    recipe:SetCraftedItem(10508, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_GUN")
    recipe:AddTrainer(11017, 11025, 17634, 3494, 1702, 25277, 18752, 17637, 1676, 26907, 19576, 26955, 33586, 17222, 5518,
        11037, 28697, 33611, 8736, 16667, 18775, 26991, 11031, 3290, 5174, 33634, 16726)

    -- Deadly Scope -- 12597
    recipe = AddRecipe(12597, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(210, 210, 230, 240, 250)
    recipe:SetRecipeItem(10602, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(10546, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_ITEM_ENHANCEMENT")
    recipe:AddLimitedVendor(8679, 1, 45843, 1)

    -- Mithril Casing -- 12599
    recipe = AddRecipe(12599, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(215, 215, 215, 235, 255)
    recipe:SetCraftedItem(10561, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_MATERIALS")
    recipe:AddTrainer(11017, 11025, 17634, 3494, 1702, 25277, 18752, 17637, 1676, 26907, 19576, 26955, 33586, 17222, 5518,
        11037, 28697, 33611, 8736, 16667, 18775, 26991, 11031, 3290, 5174, 33634, 16726)

    -- Mithril Frag Bomb -- 12603
    recipe = AddRecipe(12603, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(215, 215, 215, 235, 255)
    recipe:SetCraftedItem(10514, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
    recipe:AddTrainer(11017, 11025, 17634, 3494, 1702, 25277, 18752, 17637, 1676, 26907, 19576, 26955, 33586, 17222, 5518,
        11037, 28697, 33611, 8736, 16667, 18775, 26991, 11031, 3290, 5174, 33634, 16726)

    -- Catseye Ultra Goggles -- 12607
    recipe = AddRecipe(12607, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(220, 220, 240, 250, 260)
    recipe:SetRecipeItem(10603, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(10501, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_HEAD")
    recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

    -- Mithril Heavy-bore Rifle -- 12614
    recipe = AddRecipe(12614, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(220, 220, 240, 250, 260)
    recipe:SetRecipeItem(10604, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(10510, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_GUN")
    recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

    -- Spellpower Goggles Xtreme -- 12615
    recipe = AddRecipe(12615, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(225, 225, 245, 255, 265)
    recipe:SetCraftedItem(10502, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_HEAD")
    recipe:AddFilters(F.CASTER, F.HEALER, F.MAGE, F.PRIEST, F.WARLOCK)
    recipe:AddTrainer(11017, 11025, 17634, 3494, 1702, 25277, 18752, 17637, 1676, 26907, 19576, 26955, 3290, 17222, 5518,
        11037, 33586, 33611, 8736, 16667, 18775, 26991, 11031, 28697, 5174, 33634, 16726)

    -- Parachute Cloak -- 12616
    recipe = AddRecipe(12616, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(225, 225, 245, 255, 265)
    recipe:SetRecipeItem(10606, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(10518, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_BACK")
    recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

    -- Deepdive Helmet -- 12617
    recipe = AddRecipe(12617, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(230, 230, 250, 260, 270)
    recipe:SetCraftedItem(10506, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_HEAD")
    recipe:AddTrainer(1702, 3494, 4941, 5174, 5518, 8736, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 25099, 45545,
        52636, 52651)

    -- Rose Colored Goggles -- 12618
    recipe = AddRecipe(12618, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(230, 230, 250, 260, 270)
    recipe:SetCraftedItem(10503, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_HEAD")
    recipe:AddFilters(F.CASTER, F.HEALER)
    recipe:AddTrainer(11017, 11025, 17634, 3494, 1702, 25277, 18752, 17637, 1676, 26907, 19576, 26955, 3290, 17222, 5518,
        11037, 33586, 33611, 8736, 16667, 18775, 26991, 11031, 28697, 5174, 33634, 16726)

    -- Hi-Explosive Bomb -- 12619
    recipe = AddRecipe(12619, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(235, 235, 235, 255, 275)
    recipe:SetCraftedItem(10562, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
    recipe:AddTrainer(11017, 11025, 17634, 3494, 1702, 25277, 18752, 17637, 1676, 26907, 19576, 26955, 3290, 17222, 5518,
        11037, 33586, 33611, 8736, 16667, 18775, 26991, 11031, 28697, 5174, 33634, 16726)

    -- Sniper Scope -- 12620
    recipe = AddRecipe(12620, V.ORIG, Q.RARE)
    recipe:SetSkillLevels(240, 240, 260, 270, 280)
    recipe:SetRecipeItem(10608, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(10548, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_ITEM_ENHANCEMENT")
    recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

    -- Green Lens -- 12622
    recipe = AddRecipe(12622, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(245, 245, 265, 275, 285)
    recipe:SetCraftedItem(10504, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_HEAD")
    recipe:AddTrainer(11017, 11025, 17634, 3494, 1702, 25277, 18752, 17637, 1676, 26907, 19576, 26955, 3290, 17222, 5518,
        11037, 33586, 33611, 8736, 16667, 18775, 26991, 11031, 28697, 5174, 33634, 16726)

    -- Mithril Mechanical Dragonling -- 12624
    recipe = AddRecipe(12624, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(250, 250, 270, 280, 290)
    recipe:SetRecipeItem(10609, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(10576, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_TRINKET")
    recipe:AddLimitedVendor(2688, 1, 35826, 1)

    -- Goblin Rocket Fuel Recipe -- 12715
    recipe = AddRecipe(12715, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(205, 205, 205, 205, 205)
    recipe:SetCraftedItem(10644, "BIND_ON_EQUIP")
    recipe:SetSpecialty(20222)
    recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
    recipe:AddTrainer(8126, 29513)

    -- Goblin Mortar -- 12716
    recipe = AddRecipe(12716, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(205, 205, 225, 235, 245)
    recipe:SetCraftedItem(10577, "BIND_ON_EQUIP")
    recipe:SetSpecialty(20222)
    recipe:SetItemFilterType("ENGINEERING_TRINKET")
    recipe:AddTrainer(8738, 29513, 8126)

    -- Goblin Mining Helmet -- 12717
    recipe = AddRecipe(12717, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(205, 205, 225, 235, 245)
    recipe:SetCraftedItem(10542, "BIND_ON_PICKUP")
    recipe:SetSpecialty(20222)
    recipe:SetItemFilterType("ENGINEERING_HEAD")
    recipe:AddFilters(F.HUNTER, F.SHAMAN)
    recipe:AddTrainer(8738, 29513, 8126)

    -- Goblin Construction Helmet -- 12718
    recipe = AddRecipe(12718, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(205, 205, 225, 235, 245)
    recipe:SetCraftedItem(10543, "BIND_ON_PICKUP")
    recipe:SetSpecialty(20222)
    recipe:SetItemFilterType("ENGINEERING_HEAD")
    recipe:AddTrainer(8738, 29513, 8126)

    -- The Big One -- 12754
    recipe = AddRecipe(12754, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(235, 235, 235, 255, 275)
    recipe:SetCraftedItem(10586, "BIND_ON_EQUIP")
    recipe:SetSpecialty(20222)
    recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
    recipe:AddTrainer(8738, 29513, 8126)

    -- Goblin Bomb Dispenser -- 12755
    recipe = AddRecipe(12755, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(230, 230, 230, 250, 270)
    recipe:SetCraftedItem(10587, "BIND_ON_PICKUP")
    recipe:SetSpecialty(20222)
    recipe:SetItemFilterType("ENGINEERING_TRINKET")
    recipe:AddTrainer(8738, 29513, 8126)

    -- Goblin Rocket Helmet -- 12758
    recipe = AddRecipe(12758, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(245, 245, 265, 275, 285)
    recipe:SetCraftedItem(10588, "BIND_ON_EQUIP")
    recipe:SetSpecialty(20222)
    recipe:SetItemFilterType("ENGINEERING_HEAD")
    recipe:AddTrainer(8738, 29513, 8126)

    -- Gnomish Death Ray -- 12759
    recipe = AddRecipe(12759, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(240, 240, 260, 270, 280)
    recipe:SetCraftedItem(10645, "BIND_ON_PICKUP")
    recipe:SetSpecialty(20219)
    recipe:SetItemFilterType("ENGINEERING_TRINKET")
    recipe:AddTrainer(7944, 7406, 29514)

    -- Goblin Sapper Charge -- 12760
    recipe = AddRecipe(12760, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(205, 205, 205, 225, 245)
    recipe:SetCraftedItem(10646, "BIND_ON_EQUIP")
    recipe:SetSpecialty(20222)
    recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
    recipe:AddTrainer(8126, 29513)

    -- Inlaid Mithril Cylinder Plans -- 12895
    recipe = AddRecipe(12895, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(205, 205, 205, 205, 205)
    recipe:SetCraftedItem(10713, "BIND_ON_EQUIP")
    recipe:SetSpecialty(20219)
    recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
    recipe:AddTrainer(7944, 7406, 29514)

    -- Gnomish Goggles -- 12897
    recipe = AddRecipe(12897, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(215, 215, 230, 240, 250)
    recipe:SetCraftedItem(10545, "BIND_ON_PICKUP")
    recipe:SetSpecialty(20219)
    recipe:SetItemFilterType("ENGINEERING_HEAD")
    recipe:AddFilters(F.CASTER, F.HEALER)
    recipe:AddTrainer(7944, 7406, 29514)

    -- Gnomish Shrink Ray -- 12899
    recipe = AddRecipe(12899, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(205, 205, 225, 235, 245)
    recipe:SetCraftedItem(10716, "BIND_ON_EQUIP")
    recipe:SetSpecialty(20219)
    recipe:SetItemFilterType("ENGINEERING_TRINKET")
    recipe:AddTrainer(7944, 7406, 29514)

    -- Gnomish Net-o-Matic Projector -- 12902
    recipe = AddRecipe(12902, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(210, 210, 230, 240, 250)
    recipe:SetCraftedItem(10720, "BIND_ON_EQUIP")
    recipe:SetSpecialty(20219)
    recipe:SetItemFilterType("ENGINEERING_TRINKET")
    recipe:AddTrainer(7944, 7406, 29514)

    -- Gnomish Harm Prevention Belt -- 12903
    recipe = AddRecipe(12903, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(215, 215, 235, 245, 255)
    recipe:SetCraftedItem(10721, "BIND_ON_EQUIP")
    recipe:SetSpecialty(20219)
    recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
    recipe:AddTrainer(7944, 7406, 29514)

    -- Gnomish Rocket Boots -- 12905
    recipe = AddRecipe(12905, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(210, 210, 245, 255, 265)
    recipe:SetCraftedItem(10724, "BIND_ON_EQUIP")
    recipe:SetSpecialty(20219)
    recipe:SetItemFilterType("ENGINEERING_FEET")
    recipe:AddTrainer(7944, 7406, 29514)

    -- Gnomish Battle Chicken -- 12906
    recipe = AddRecipe(12906, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(230, 230, 250, 260, 270)
    recipe:SetCraftedItem(10725, "BIND_ON_PICKUP")
    recipe:SetSpecialty(20219)
    recipe:SetItemFilterType("ENGINEERING_TRINKET")
    recipe:AddTrainer(7944, 7406, 29514)

    -- Gnomish Mind Control Cap -- 12907
    recipe = AddRecipe(12907, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(235, 235, 255, 265, 275)
    recipe:SetCraftedItem(10726, "BIND_ON_EQUIP")
    recipe:SetSpecialty(20219)
    recipe:SetItemFilterType("ENGINEERING_HEAD")
    recipe:AddFilters(F.CASTER, F.HEALER)
    recipe:AddTrainer(7944, 7406, 29514)

    -- Goblin Dragon Gun -- 12908
    recipe = AddRecipe(12908, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(240, 240, 260, 270, 280)
    recipe:SetCraftedItem(10727, "BIND_ON_PICKUP")
    recipe:SetSpecialty(20222)
    recipe:SetItemFilterType("ENGINEERING_TRINKET")
    recipe:AddTrainer(8738, 29513, 8126)

    -- The Mortar: Reloaded -- 13240
    recipe = AddRecipe(13240, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(205, 205, 205, 205, 205)
    recipe:SetSpecialty(20222)
    recipe:SetItemFilterType("ENGINEERING_TRINKET")


    -- Mechanical Repair Kit -- 15255
    recipe = AddRecipe(15255, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(200, 200, 200, 220, 240)
    recipe:SetCraftedItem(11590, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
    recipe:AddTrainer(8126, 8738)
    recipe:AddTrainer(11017, 11025, 17634, 3494, 1702, 25277, 18752, 17637, 1676, 26907, 19576, 26955, 33586, 17222, 5518,
        11037, 28697, 33611, 8736, 16667, 18775, 26991, 11031, 3290, 5174, 33634, 16726)

    -- Pet Bombling -- 15628
    recipe = AddRecipe(15628, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(205, 205, 205, 205, 205)
    recipe:SetRecipeItem(11828, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(11825, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_PET")
    recipe:AddWorldDrop(Z.GNOMEREGAN)

    -- Lil' Smoky -- 15633
    recipe = AddRecipe(15633, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(205, 205, 205, 205, 205)
    recipe:SetRecipeItem(11827, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(11826, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_PET")
    recipe:AddWorldDrop(Z.GNOMEREGAN)

    -- Dense Blasting Powder -- 19788
    recipe = AddRecipe(19788, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(250, 250, 250, 255, 260)
    recipe:SetCraftedItem(15992, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_MATERIALS")
    recipe:AddTrainer(11017, 11025, 17634, 3494, 1702, 25277, 18752, 17637, 1676, 26907, 19576, 26955, 3290, 17222, 5518,
        11037, 33586, 33611, 8736, 16667, 18775, 26991, 11031, 28697, 5174, 33634, 16726)

    -- Thorium Grenade -- 19790
    recipe = AddRecipe(19790, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(260, 260, 280, 290, 300)
    recipe:SetCraftedItem(15993, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
    recipe:AddTrainer(11017, 11025, 17634, 3494, 1702, 25277, 18752, 17637, 1676, 26907, 19576, 26955, 3290, 17222, 5518,
        11037, 33586, 33611, 8736, 16667, 18775, 26991, 11031, 28697, 5174, 33634, 16726)

    -- Thorium Widget -- 19791
    recipe = AddRecipe(19791, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(260, 260, 280, 290, 300)
    recipe:SetCraftedItem(15994, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_MATERIALS")
    recipe:AddTrainer(11017, 11025, 17634, 3494, 1702, 25277, 18752, 17637, 1676, 26907, 19576, 26955, 3290, 17222, 5518,
        11037, 33586, 33611, 8736, 16667, 18775, 26991, 11031, 28697, 5174, 33634, 16726)

    -- Thorium Rifle -- 19792
    recipe = AddRecipe(19792, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(260, 260, 280, 290, 300)
    recipe:SetCraftedItem(15995, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_GUN")
    recipe:AddTrainer(11017, 11025, 17634, 3494, 1702, 25277, 18752, 17637, 1676, 26907, 19576, 26955, 3290, 17222, 5518,
        11037, 33586, 33611, 8736, 16667, 18775, 26991, 11031, 28697, 5174, 33634, 16726)

    -- Lifelike Mechanical Toad -- 19793
    recipe = AddRecipe(19793, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(265, 265, 285, 295, 305)
    recipe:SetRecipeItem(16044, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(15996, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_PET")
    recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

    -- Spellpower Goggles Xtreme Plus -- 19794
    recipe = AddRecipe(19794, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(270, 270, 290, 300, 310)
    recipe:SetCraftedItem(15999, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_HEAD")
    recipe:AddFilters(F.CASTER, F.HEALER, F.MAGE, F.PRIEST, F.WARLOCK)
    recipe:AddTrainer(11017, 11025, 17634, 3494, 1702, 25277, 18752, 17637, 1676, 26907, 19576, 26955, 3290, 17222, 5518,
        11037, 33586, 33611, 8736, 16667, 18775, 26991, 11031, 28697, 5174, 33634, 16726)

    -- Thorium Tube -- 19795
    recipe = AddRecipe(19795, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(275, 275, 295, 305, 315)
    recipe:SetCraftedItem(16000, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_MATERIALS")
    recipe:AddTrainer(11017, 11025, 17634, 3494, 1702, 25277, 18752, 17637, 1676, 26907, 19576, 26955, 3290, 17222, 5518,
        11037, 33586, 33611, 8736, 16667, 18775, 26991, 11031, 28697, 5174, 33634, 16726)

    -- Dark Iron Rifle -- 19796
    recipe = AddRecipe(19796, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(275, 275, 295, 305, 315)
    recipe:SetRecipeItem(16048, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(16004, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_GUN")
    recipe:AddMobDrop(8897)

    -- Dark Iron Bomb -- 19799
    recipe = AddRecipe(19799, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(285, 285, 305, 315, 325)
    recipe:SetRecipeItem(16049, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(16005, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
    recipe:AddMobDrop(8920)

    -- Masterwork Target Dummy -- 19814
    recipe = AddRecipe(19814, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(275, 275, 295, 305, 315)
    recipe:SetRecipeItem(16046, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(16023, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
    recipe:AddVendor(11185)

    -- Delicate Arcanite Converter -- 19815
    recipe = AddRecipe(19815, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(285, 285, 305, 315, 325)
    recipe:SetRecipeItem(16050, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(16006, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_MATERIALS")
    recipe:AddVendor(11185)

    -- Voice Amplification Modulator -- 19819
    recipe = AddRecipe(19819, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(290, 290, 310, 320, 330)
    recipe:SetRecipeItem(16052, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(16009, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_NECK")
    recipe:AddMobDrop(10426)

    -- Master Engineer's Goggles -- 19825
    recipe = AddRecipe(19825, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(290, 290, 310, 320, 330)
    recipe:SetCraftedItem(16008, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_HEAD")
    recipe:AddFilters(F.CASTER, F.HEALER)
    recipe:AddTrainer(11017, 11025, 17634, 3494, 1702, 25277, 18752, 17637, 1676, 26907, 19576, 26955, 3290, 17222, 5518,
        11037, 33586, 33611, 8736, 16667, 18775, 26991, 11031, 28697, 5174, 33634, 16726)

    -- Arcanite Dragonling -- 19830
    recipe = AddRecipe(19830, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(300, 300, 320, 330, 340)
    recipe:SetRecipeItem(16054, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(16022, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_TRINKET")
    recipe:AddLimitedVendor(35826, 1)

    -- Arcane Bomb -- 19831
    recipe = AddRecipe(19831, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(300, 300, 320, 330, 340)
    recipe:SetRecipeItem(16055, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(16040, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
    recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

    -- Flawless Arcanite Rifle -- 19833
    recipe = AddRecipe(19833, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(300, 300, 320, 330, 340)
    recipe:SetRecipeItem(16056, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(16007, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_GUN")
    recipe:AddFilters(F.CASTER, F.HEALER)


    -- Field Repair Bot 74A -- 22704
    recipe = AddRecipe(22704, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(300, 300, 320, 330, 340)
    recipe:SetCraftedItem(18232, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
    recipe:AddCustom("ENG_FLOOR_ITEM_BRD")

    -- Biznicks 247x128 Accurascope -- 22793
    recipe = AddRecipe(22793, V.ORIG, Q.RARE)
    recipe:SetSkillLevels(300, 300, 320, 330, 340)
    recipe:SetRecipeItem(18290, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(18283, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_ITEM_ENHANCEMENT")
    recipe:AddFilters(F.CASTER)
    recipe:AddWorldDrop(Z.MOLTEN_CORE)

    -- Core Marksman Rifle -- 22795
    recipe = AddRecipe(22795, V.ORIG, Q.RARE)
    recipe:SetSkillLevels(300, 300, 320, 330, 340)
    recipe:SetRecipeItem(18292, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(18282, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_GUN")
    recipe:AddFilters(F.CASTER, F.HEALER)
    recipe:AddWorldDrop(Z.MOLTEN_CORE)

    -- Force Reactive Disk -- 22797
    recipe = AddRecipe(22797, V.ORIG, Q.RARE)
    recipe:SetSkillLevels(300, 300, 320, 330, 340)
    recipe:SetRecipeItem(18291, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(18168, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_SHIELD")
    recipe:AddWorldDrop(Z.MOLTEN_CORE)

    -- Red Firework -- 23066
    recipe = AddRecipe(23066, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(150, 150, 150, 162, 175)
    recipe:SetRecipeItem(18647, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(9318, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
    recipe:AddLimitedVendor(3413, 1, 45546, 1, 49918, 1, 52655, 1)

    -- Blue Firework -- 23067
    recipe = AddRecipe(23067, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(150, 150, 150, 162, 175)
    recipe:SetRecipeItem(18649, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(9312, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
    recipe:AddLimitedVendor(1304, 1, 5175, 1, 49918, 1)

    -- Green Firework -- 23068
    recipe = AddRecipe(23068, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(150, 150, 150, 162, 175)
    recipe:SetRecipeItem(18648, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(9313, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
    recipe:AddLimitedVendor(2838, 1, 3495, 1, 49918, 1)

    -- EZ-Thro Dynamite II -- 23069
    recipe = AddRecipe(23069, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(200, 200, 200, 210, 220)
    recipe:SetRecipeItem(18650, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(18588, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
    recipe:AddLimitedVendor(8131, 1, 49918, 1)

    -- Dense Dynamite -- 23070
    recipe = AddRecipe(23070, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(250, 250, 250, 260, 270)
    recipe:SetCraftedItem(18641, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
    recipe:AddTrainer(11017, 11025, 17634, 3494, 1702, 25277, 18752, 17637, 1676, 26907, 19576, 26955, 3290, 17222, 5518,
        11037, 33586, 33611, 8736, 16667, 18775, 26991, 11031, 28697, 5174, 33634, 16726)

    -- Truesilver Transformer -- 23071
    recipe = AddRecipe(23071, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(260, 260, 270, 275, 280)
    recipe:SetCraftedItem(18631, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_MATERIALS")
    recipe:AddTrainer(11017, 11025, 17634, 3494, 1702, 25277, 18752, 17637, 1676, 26907, 19576, 26955, 3290, 17222, 5518,
        11037, 33586, 33611, 8736, 16667, 18775, 26991, 11031, 28697, 5174, 33634, 16726)

    -- Gyrofreeze Ice Reflector -- 23077
    recipe = AddRecipe(23077, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(260, 260, 280, 290, 300)
    recipe:SetRecipeItem(18652, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(18634, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_TRINKET")
    recipe:AddVendor(11185)

    -- Goblin Jumper Cables XL -- 23078
    recipe = AddRecipe(23078, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(265, 265, 285, 295, 305)
    recipe:SetRecipeItem(18653, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(18587, "BIND_ON_EQUIP")
    recipe:SetSpecialty(20222)
    recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
    recipe:AddMobDrop(9499)

    -- Major Recombobulator -- 23079
    recipe = AddRecipe(23079, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(275, 275, 285, 290, 295)
    recipe:SetRecipeItem(18655, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(18637, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_TRINKET")
    recipe:AddCustom("DM_TRIBUTE")

    -- Powerful Seaforium Charge -- 23080
    recipe = AddRecipe(23080, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(275, 275, 275, 285, 295)
    recipe:SetRecipeItem(18656, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(18594, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
    recipe:AddVendor(11185)

    -- Hyper-Radiant Flame Reflector -- 23081
    recipe = AddRecipe(23081, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(290, 290, 310, 320, 330)
    recipe:SetRecipeItem(18657, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(18638, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_TRINKET")
    recipe:AddCustom("PREREQ")
    recipe:AddMobDrop(10264)

    -- Ultra-Flash Shadow Reflector -- 23082
    recipe = AddRecipe(23082, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(300, 300, 320, 330, 340)
    recipe:SetRecipeItem(18658, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(18639, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_TRINKET")
    recipe:AddMobDrop(10426)

    -- Gnomish Alarm-o-Bot -- 23096
    recipe = AddRecipe(23096, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(265, 265, 275, 280, 285)
    recipe:SetRecipeItem(18654, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(18645, "BIND_ON_EQUIP")
    recipe:SetSpecialty(20219)
    recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
    recipe:AddMobDrop(8920)

    -- World Enlarger -- 23129
    recipe = AddRecipe(23129, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(260, 260, 260, 265, 270)
    recipe:SetRecipeItem(18661, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(18660, "BIND_ON_EQUIP")
    recipe:SetSpecialty(20219)
    recipe:SetItemFilterType("ENGINEERING_TOY")
    recipe:AddMobDrop(8920)

    -- Dimensional Ripper - Everlook -- 23486
    recipe = AddRecipe(23486, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(260, 260, 285, 295, 305)
    recipe:SetCraftedItem(18984, "BIND_ON_EQUIP")
    recipe:SetSpecialty(20222)
    recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
    recipe:AddTrainer(14742)

    -- Ultrasafe Transporter - Gadgetzan -- 23489
    recipe = AddRecipe(23489, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(260, 260, 285, 295, 305)
    recipe:SetCraftedItem(18986, "BIND_ON_EQUIP")
    recipe:SetSpecialty(20219)
    recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
    recipe:AddTrainer(14743)

    -- Snake Burst Firework -- 23507
    recipe = AddRecipe(23507, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(250, 250, 250, 260, 270)
    recipe:SetRecipeItem(19027, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(19026, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
    recipe:AddCustom("PREREQ")
    recipe:AddVendor(14637)

    -- Bloodvine Goggles -- 24356
    recipe = AddRecipe(24356, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(300, 300, 320, 330, 340)
    recipe:SetRecipeItem(20000, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(19999, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_HEAD")
    recipe:AddFilters(F.CASTER, F.HEALER, F.MAGE, F.PRIEST, F.WARLOCK)


    -- Bloodvine Lens -- 24357
    recipe = AddRecipe(24357, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(300, 300, 320, 330, 340)
    recipe:SetRecipeItem(20001, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(19998, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_HEAD")
    recipe:AddFilters(F.CASTER, F.HEALER, F.DRUID, F.ROGUE, F.MONK)


    -- Tranquil Mechanical Yeti -- 26011
    recipe = AddRecipe(26011, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(250, 250, 320, 330, 340)
    recipe:SetCraftedItem(21277, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_PET")


    -- Small Blue Rocket -- 26416
    recipe = AddRecipe(26416, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(125, 125, 125, 137, 150)
    recipe:SetRecipeItem(21724, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(21558, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
    recipe:AddVendor(15909)


    -- Small Green Rocket -- 26417
    recipe = AddRecipe(26417, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(125, 125, 125, 137, 150)
    recipe:SetRecipeItem(21725, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(21559, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
    recipe:AddVendor(15909)


    -- Small Red Rocket -- 26418
    recipe = AddRecipe(26418, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(125, 125, 125, 137, 150)
    recipe:SetRecipeItem(21726, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(21557, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
    recipe:AddVendor(15909)


    -- Large Blue Rocket -- 26420
    recipe = AddRecipe(26420, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(175, 175, 175, 187, 200)
    recipe:SetRecipeItem(21727, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(21589, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
    recipe:AddVendor(15909)


    -- Large Green Rocket -- 26421
    recipe = AddRecipe(26421, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(175, 175, 175, 187, 200)
    recipe:SetRecipeItem(21728, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(21590, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
    recipe:AddVendor(15909)


    -- Large Red Rocket -- 26422
    recipe = AddRecipe(26422, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(175, 175, 175, 187, 200)
    recipe:SetRecipeItem(21729, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(21592, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
    recipe:AddVendor(15909)


    -- Blue Rocket Cluster -- 26423
    recipe = AddRecipe(26423, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(225, 225, 225, 237, 250)
    recipe:SetRecipeItem(21730, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(21571, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
    recipe:AddVendor(15909)


    -- Green Rocket Cluster -- 26424
    recipe = AddRecipe(26424, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(225, 225, 225, 237, 250)
    recipe:SetRecipeItem(21731, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(21574, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
    recipe:AddVendor(15909)


    -- Red Rocket Cluster -- 26425
    recipe = AddRecipe(26425, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(225, 225, 225, 237, 250)
    recipe:SetRecipeItem(21732, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(21576, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
    recipe:AddVendor(15909)


    -- Large Blue Rocket Cluster -- 26426
    recipe = AddRecipe(26426, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(275, 275, 275, 280, 285)
    recipe:SetRecipeItem(21733, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(21714, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
    recipe:AddVendor(15909)


    -- Large Green Rocket Cluster -- 26427
    recipe = AddRecipe(26427, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(275, 275, 275, 280, 285)
    recipe:SetRecipeItem(21734, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(21716, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
    recipe:AddVendor(15909)


    -- Large Red Rocket Cluster -- 26428
    recipe = AddRecipe(26428, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(275, 275, 275, 280, 285)
    recipe:SetRecipeItem(21735, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(21718, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
    recipe:AddVendor(15909)


    -- Firework Launcher -- 26442
    recipe = AddRecipe(26442, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(225, 225, 245, 255, 265)
    recipe:SetRecipeItem(44919, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(21569, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
    recipe:AddVendor(15909)


    -- Cluster Launcher -- 26443
    recipe = AddRecipe(26443, V.ORIG, Q.UNCOMMON)
    recipe:SetSkillLevels(275, 275, 295, 305, 315)
    recipe:SetRecipeItem(44918, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(21570, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
    recipe:AddVendor(15909)


    -- Steam Tonk Controller -- 28327
    recipe = AddRecipe(28327, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(275, 275, 275, 280, 285)
    recipe:SetRecipeItem(22729, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(22728, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
    recipe:AddLimitedVendor(3413, 1, 5175, 1, 45546, 1, 52655, 1)

    -- Fused Wiring -- 39895
    recipe = AddRecipe(39895, V.ORIG, Q.COMMON)
    recipe:SetSkillLevels(275, 275, 275, 280, 285)
    recipe:SetCraftedItem(7191, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_MATERIALS")
    recipe:AddTrainer(1702, 4941, 5174, 5518, 8736, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 25099, 45545, 52636,
        52651)

    -- ----------------------------------------------------------------------------
    -- The Burning Crusade.
    -- ----------------------------------------------------------------------------
    -- Elemental Blasting Powder -- 30303
    recipe = AddRecipe(30303, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 11, 16, 21)
    recipe:SetCraftedItem(23781, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_MATERIALS")
    recipe:AddTrainer(18775, 18752, 26955, 33586, 17634, 17637, 19576, 28697, 33611, 33634, 25277, 26991, 26907)

    -- Fel Iron Casing -- 30304
    recipe = AddRecipe(30304, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 11, 16, 21)
    recipe:SetCraftedItem(23782, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_MATERIALS")
    recipe:AddTrainer(18775, 18752, 26955, 33586, 17634, 17637, 19576, 28697, 33611, 33634, 25277, 26991, 26907)

    -- Handful of Fel Iron Bolts -- 30305
    recipe = AddRecipe(30305, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 11, 16, 21)
    recipe:SetCraftedItem(23783, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_MATERIALS")
    recipe:AddTrainer(18775, 18752, 26955, 33586, 17634, 17637, 19576, 28697, 33611, 33634, 25277, 26991, 26907)

    -- Adamantite Frame -- 30306
    recipe = AddRecipe(30306, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(25, 25, 35, 40, 45)
    recipe:SetCraftedItem(23784, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_MATERIALS")
    recipe:AddTrainer(18775, 18752, 26955, 33586, 17634, 17637, 19576, 28697, 33611, 33634, 25277, 26991, 26907)

    -- Hardened Adamantite Tube -- 30307
    recipe = AddRecipe(30307, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(40, 40, 50, 55, 60)
    recipe:SetCraftedItem(23785, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_MATERIALS")
    recipe:AddTrainer(18775, 18752, 26955, 33586, 17634, 17637, 19576, 28697, 33611, 33634, 25277, 26991, 26907)

    -- Khorium Power Core -- 30308
    recipe = AddRecipe(30308, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(40, 40, 50, 55, 60)
    recipe:SetCraftedItem(23786, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_MATERIALS")
    recipe:AddTrainer(18775, 18752, 26955, 33586, 17634, 17637, 19576, 28697, 33611, 33634, 25277, 26991, 26907)

    -- Felsteel Stabilizer -- 30309
    recipe = AddRecipe(30309, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(40, 40, 50, 55, 60)
    recipe:SetCraftedItem(23787, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_MATERIALS")
    recipe:AddTrainer(18775, 18752, 26955, 33586, 17634, 17637, 19576, 28697, 33611, 33634, 25277, 26991, 26907)

    -- Fel Iron Bomb -- 30310
    recipe = AddRecipe(30310, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 11, 16, 21)
    recipe:SetCraftedItem(23736, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
    recipe:AddTrainer(18775, 18752, 26955, 33586, 17634, 17637, 19576, 28697, 33611, 33634, 25277, 26991, 26907)

    -- Adamantite Grenade -- 30311
    recipe = AddRecipe(30311, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(25, 25, 35, 40, 45)
    recipe:SetCraftedItem(23737, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
    recipe:AddTrainer(18775, 18752, 26955, 33586, 17634, 17637, 19576, 28697, 33611, 33634, 25277, 26991, 26907)

    -- Fel Iron Musket -- 30312
    recipe = AddRecipe(30312, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(20, 20, 30, 35, 40)
    recipe:SetCraftedItem(23742, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_GUN")
    recipe:AddTrainer(18775, 18752, 26955, 33586, 17634, 17637, 19576, 28697, 33611, 33634, 25277, 26991, 26907)

    -- Adamantite Rifle -- 30313
    recipe = AddRecipe(30313, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(350, 350, 360, 370, 380)
    recipe:SetRecipeItem(23799, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(23746, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_GUN")
    recipe:AddLimitedVendor(16657, 1, 16782, 1, 19661, 1)

    -- Felsteel Boomstick -- 30314
    recipe = AddRecipe(30314, V.TBC, Q.RARE)
    recipe:SetSkillLevels(360, 360, 370, 380, 390)
    recipe:SetRecipeItem(23800, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(23747, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_GUN")
    recipe:AddFilters(F.CASTER, F.HEALER)
    recipe:AddMobDrop(19960)

    -- Ornate Khorium Rifle -- 30315
    recipe = AddRecipe(30315, V.TBC, Q.RARE)
    recipe:SetSkillLevels(375, 375, 385, 395, 405)
    recipe:SetRecipeItem(23802, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(23748, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_GUN")
    recipe:AddFilters(F.CASTER, F.HEALER)
    recipe:AddWorldDrop(Z.OUTLAND)

    -- Cogspinner Goggles -- 30316
    recipe = AddRecipe(30316, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(340, 340, 350, 360, 370)
    recipe:SetRecipeItem(23803, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(23758, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_HEAD")
    recipe:AddFilters(F.DRUID, F.ROGUE, F.MONK)
    recipe:AddLimitedVendor(18775, 1, 19836, 1)

    -- Power Amplification Goggles -- 30317
    recipe = AddRecipe(30317, V.TBC, Q.RARE)
    recipe:SetSkillLevels(340, 340, 350, 360, 370)
    recipe:SetRecipeItem(23804, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(23761, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_HEAD")
    recipe:AddFilters(F.CASTER, F.HEALER)
    recipe:AddWorldDrop(Z.OUTLAND)

    -- Ultra-Spectropic Detection Goggles -- 30318
    recipe = AddRecipe(30318, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(350, 350, 360, 370, 380)
    recipe:SetRecipeItem(23805, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(23762, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_HEAD")
    recipe:AddFilters(F.CASTER, F.HEALER)
    recipe:AddLimitedVendor(18775, 1, 19383, 1)

    -- Hyper-Vision Goggles -- 30325
    recipe = AddRecipe(30325, V.TBC, Q.RARE)
    recipe:SetSkillLevels(360, 360, 370, 380, 390)
    recipe:SetRecipeItem(23806, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(23763, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_HEAD")
    recipe:AddFilters(F.CASTER, F.HEALER, F.DRUID, F.ROGUE, F.MONK)
    recipe:AddMobDrop(19755)

    -- Adamantite Scope -- 30329
    recipe = AddRecipe(30329, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(335, 335, 345, 355, 365)
    recipe:SetRecipeItem(23807, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(23764, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_ITEM_ENHANCEMENT")
    recipe:AddVendor(19351)
    recipe:AddLimitedVendor(19836, 1)

    -- Khorium Scope -- 30332
    recipe = AddRecipe(30332, V.TBC, Q.RARE)
    recipe:SetSkillLevels(360, 360, 370, 380, 390)
    recipe:SetRecipeItem(23808, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(23765, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_ITEM_ENHANCEMENT")
    recipe:AddMobDrop(20207)

    -- Stabilized Eternium Scope -- 30334
    recipe = AddRecipe(30334, V.TBC, Q.RARE)
    recipe:SetSkillLevels(375, 375, 385, 395, 405)
    recipe:SetRecipeItem(23809, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(23766, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_ITEM_ENHANCEMENT")
    recipe:AddFilters(F.CASTER, F.HEALER)
    recipe:AddMobDrop(16152)

    -- Crashin' Thrashin' Robot -- 30337
    recipe = AddRecipe(30337, V.TBC, Q.UNCOMMON)
    recipe:SetSkillLevels(325, 325, 335, 345, 355)
    recipe:SetRecipeItem(23810, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(23767, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_TOY")
    recipe:AddWorldDrop(Z.OUTLAND)

    -- White Smoke Flare -- 30341
    recipe = AddRecipe(30341, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(335, 335, 335, 345, 355)
    recipe:SetRecipeItem(23811, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(23768, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
    recipe:AddLimitedVendor(16657, 1, 16782, 1, 18484, 1, 19383, 1)

    -- Green Smoke Flare -- 30344
    recipe = AddRecipe(30344, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(335, 335, 335, 345, 355)
    recipe:SetRecipeItem(23814, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(23771, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
    recipe:AddRepVendor(FAC.CENARION_EXPEDITION, REP.FRIENDLY, 17904)

    -- Fel Iron Toolbox -- 30348
    recipe = AddRecipe(30348, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(325, 325, 325, 335, 345)
    recipe:SetRecipeItem(23816, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(23774, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_BAG")
    recipe:AddLimitedVendor(16657, 1, 16782, 1, 18484, 1)

    -- Elemental Seaforium Charge -- 30547
    recipe = AddRecipe(30547, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(350, 350, 350, 355, 360)
    recipe:SetRecipeItem(23874, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(23819, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
    recipe:AddRepVendor(FAC.THE_CONSORTIUM, REP.REVERED, 20242, 23007)

    -- Zapthrottle Mote Extractor -- 30548
    recipe = AddRecipe(30548, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(305, 305, 305, 315, 325)
    recipe:SetRecipeItem(23888, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(23821, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
    recipe:AddQuest(9635, 9636)

    -- Healing Potion Injector -- 30551
    recipe = AddRecipe(30551, V.TBC, Q.RARE)
    recipe:SetSkillLevels(330, 330, 330, 340, 350)
    recipe:SetRecipeItem(35310, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(33092, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
    recipe:AddMobDrop(24664)

    -- Mana Potion Injector -- 30552
    recipe = AddRecipe(30552, V.TBC, Q.RARE)
    recipe:SetSkillLevels(345, 345, 345, 355, 365)
    recipe:SetRecipeItem(35311, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(33093, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
    recipe:AddMobDrop(24664)

    -- Rocket Boots Xtreme -- 30556
    recipe = AddRecipe(30556, V.TBC, Q.RARE)
    recipe:SetSkillLevels(355, 355, 365, 375, 385)
    recipe:SetRecipeItem(23887, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(23824, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_FEET")
    recipe:AddMobDrop(17796)

    -- The Bigger One -- 30558
    recipe = AddRecipe(30558, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(25, 25, 35, 40, 45)
    recipe:SetCraftedItem(23826, "BIND_ON_EQUIP")
    recipe:SetSpecialty(20222)
    recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
    recipe:AddTrainer(8738, 29513, 8126)

    -- Super Sapper Charge -- 30560
    recipe = AddRecipe(30560, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(40, 40, 50, 55, 60)
    recipe:SetCraftedItem(23827, "BIND_ON_EQUIP")
    recipe:SetSpecialty(20222)
    recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
    recipe:AddTrainer(8738, 29513, 8126)

    -- Goblin Rocket Launcher -- 30563
    recipe = AddRecipe(30563, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(50, 50, 60, 65, 70)
    recipe:SetCraftedItem(23836, "BIND_ON_EQUIP")
    recipe:SetSpecialty(20222)
    recipe:SetItemFilterType("ENGINEERING_TRINKET")
    recipe:AddTrainer(8738, 29513, 8126)

    -- Foreman's Enchanted Helmet -- 30565
    recipe = AddRecipe(30565, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(75, 75, 85, 90, 95)
    recipe:SetCraftedItem(23838, "BIND_ON_PICKUP")
    recipe:SetSpecialty(20222)
    recipe:SetItemFilterType("ENGINEERING_HEAD")
    recipe:AddFilters(F.CASTER, F.HEALER, F.MAGE, F.PRIEST, F.WARLOCK)
    recipe:AddTrainer(8738, 29513, 8126)

    -- Foreman's Reinforced Helmet -- 30566
    recipe = AddRecipe(30566, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(75, 75, 85, 90, 95)
    recipe:SetCraftedItem(23839, "BIND_ON_PICKUP")
    recipe:SetSpecialty(20222)
    recipe:SetItemFilterType("ENGINEERING_HEAD")
    recipe:AddFilters(F.HUNTER, F.SHAMAN)
    recipe:AddTrainer(8738, 29513, 8126)

    -- Gnomish Flame Turret -- 30568
    recipe = AddRecipe(30568, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(25, 25, 35, 40, 45)
    recipe:SetCraftedItem(23841, "BIND_ON_EQUIP")
    recipe:SetSpecialty(20219)
    recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
    recipe:AddTrainer(7944, 7406, 29514)

    -- Gnomish Poultryizer -- 30569
    recipe = AddRecipe(30569, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(40, 40, 50, 55, 60)
    recipe:SetCraftedItem(23835, "BIND_ON_EQUIP")
    recipe:SetSpecialty(20219)
    recipe:SetItemFilterType("ENGINEERING_TRINKET")
    recipe:AddTrainer(7944, 7406, 29514)

    -- Nigh-Invulnerability Belt -- 30570
    recipe = AddRecipe(30570, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(50, 50, 60, 65, 70)
    recipe:SetCraftedItem(23825, "BIND_ON_EQUIP")
    recipe:SetSpecialty(20219)
    recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
    recipe:AddTrainer(7944, 7406, 29514)

    -- Gnomish Power Goggles -- 30574
    recipe = AddRecipe(30574, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(75, 75, 85, 90, 95)
    recipe:SetCraftedItem(23828, "BIND_ON_PICKUP")
    recipe:SetSpecialty(20219)
    recipe:SetItemFilterType("ENGINEERING_HEAD")
    recipe:AddFilters(F.CASTER, F.HEALER, F.MAGE, F.PRIEST, F.WARLOCK)
    recipe:AddTrainer(7944, 7406, 29514)

    -- Gnomish Battle Goggles -- 30575
    recipe = AddRecipe(30575, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(75, 75, 85, 90, 95)
    recipe:SetCraftedItem(23829, "BIND_ON_PICKUP")
    recipe:SetSpecialty(20219)
    recipe:SetItemFilterType("ENGINEERING_HEAD")
    recipe:AddFilters(F.CASTER, F.HEALER, F.DRUID, F.ROGUE, F.MONK)
    recipe:AddTrainer(7944, 7406, 29514)

    -- Purple Smoke Flare -- 32814
    recipe = AddRecipe(32814, V.TBC, Q.UNCOMMON)
    recipe:SetSkillLevels(335, 335, 335, 345, 355)
    recipe:SetRecipeItem(25887, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(25886, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
    recipe:AddWorldDrop(Z.OUTLAND)

    -- Dimensional Ripper - Area 52 -- 36954
    recipe = AddRecipe(36954, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(350, 350, 350, 360, 370)
    recipe:SetCraftedItem(30542, "BIND_ON_EQUIP")
    recipe:SetSpecialty(20222)
    recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
    recipe:AddTrainer(21493)

    -- Ultrasafe Transporter - Toshley's Station -- 36955
    recipe = AddRecipe(36955, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(350, 350, 350, 360, 370)
    recipe:SetCraftedItem(30544, "BIND_ON_EQUIP")
    recipe:SetSpecialty(20219)
    recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
    recipe:AddTrainer(21494)

    -- Icy Blasting Primers -- 39971
    recipe = AddRecipe(39971, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(35, 35, 45, 50, 55)
    recipe:SetCraftedItem(32423, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_MATERIALS")
    recipe:AddTrainer(18775, 18752, 26955, 33586, 17634, 17637, 19576, 28697, 33611, 33634, 25277, 26991, 26907)

    -- Frost Grenade -- 39973
    recipe = AddRecipe(39973, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(35, 35, 45, 50, 55)
    recipe:SetCraftedItem(32413, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
    recipe:AddTrainer(18775, 18752, 26955, 33586, 17634, 17637, 19576, 28697, 33611, 33634, 25277, 26991, 26907)

    -- Furious Gizmatic Goggles -- 40274
    recipe = AddRecipe(40274, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(50, 50, 60, 65, 70)
    recipe:SetCraftedItem(32461, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENGINEERING_HEAD")
    recipe:AddFilters(F.CASTER, F.HEALER, F.DK, F.PALADIN, F.WARRIOR)
    recipe:AddTrainer(18775, 26955, 33586, 17637, 19576, 17634, 28697, 25277, 18752)

    -- Gyro-balanced Khorium Destroyer -- 41307
    recipe = AddRecipe(41307, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(75, 75, 85, 90, 95)
    recipe:SetCraftedItem(32756, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_GUN")
    recipe:AddTrainer(18775, 18752, 26955, 33586, 17634, 17637, 19576, 28697, 33611, 33634, 25277, 26991, 26907)

    -- Justicebringer 2000 Specs -- 41311
    recipe = AddRecipe(41311, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(50, 50, 60, 65, 70)
    recipe:SetCraftedItem(32472, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENGINEERING_HEAD")
    recipe:AddFilters(F.CASTER, F.HEALER, F.PALADIN)
    recipe:AddTrainer(18775, 26955, 33586, 17637, 19576, 26907, 17634, 25277, 28697, 26991, 18752)

    -- Tankatronic Goggles -- 41312
    recipe = AddRecipe(41312, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(50, 50, 60, 65, 70)
    recipe:SetCraftedItem(32473, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENGINEERING_HEAD")
    recipe:AddFilters(F.CASTER, F.HEALER, F.TANK, F.DK, F.PALADIN, F.WARRIOR)
    recipe:AddTrainer(18775, 26955, 33586, 17637, 19576, 26907, 17634, 25277, 28697, 26991, 18752)

    -- Surestrike Goggles v2.0 -- 41314
    recipe = AddRecipe(41314, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(50, 50, 60, 65, 70)
    recipe:SetCraftedItem(32474, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENGINEERING_HEAD")
    recipe:AddFilters(F.HUNTER, F.SHAMAN)
    recipe:AddTrainer(18775, 26955, 33586, 17637, 19576, 26907, 17634, 25277, 28697, 26991, 18752)

    -- Gadgetstorm Goggles -- 41315
    recipe = AddRecipe(41315, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(50, 50, 60, 65, 70)
    recipe:SetCraftedItem(32476, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENGINEERING_HEAD")
    recipe:AddFilters(F.CASTER, F.SHAMAN)
    recipe:AddTrainer(18775, 26955, 33586, 17637, 19576, 26907, 17634, 25277, 28697, 26991, 18752)

    -- Living Replicator Specs -- 41316
    recipe = AddRecipe(41316, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(50, 50, 60, 65, 70)
    recipe:SetCraftedItem(32475, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENGINEERING_HEAD")
    recipe:AddFilters(F.CASTER, F.HEALER, F.SHAMAN)
    recipe:AddTrainer(18775, 26955, 33586, 17637, 19576, 26907, 17634, 25277, 28697, 26991, 18752)

    -- Deathblow X11 Goggles -- 41317
    recipe = AddRecipe(41317, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(50, 50, 60, 65, 70)
    recipe:SetCraftedItem(32478, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENGINEERING_HEAD")
    recipe:AddFilters(F.DRUID, F.ROGUE, F.MONK)
    recipe:AddTrainer(18775, 26955, 33586, 17637, 19576, 26907, 17634, 25277, 28697, 26991, 18752)

    -- Wonderheal XT40 Shades -- 41318
    recipe = AddRecipe(41318, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(50, 50, 60, 65, 70)
    recipe:SetCraftedItem(32479, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENGINEERING_HEAD")
    recipe:AddFilters(F.DRUID)
    recipe:AddTrainer(18775, 26955, 33586, 17637, 19576, 26907, 17634, 25277, 28697, 26991, 18752)

    -- Magnified Moon Specs -- 41319
    recipe = AddRecipe(41319, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(50, 50, 60, 65, 70)
    recipe:SetCraftedItem(32480, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENGINEERING_HEAD")
    recipe:AddFilters(F.CASTER, F.HEALER, F.DRUID, F.MONK)
    recipe:AddTrainer(18775, 26955, 33586, 17637, 19576, 26907, 17634, 25277, 28697, 26991, 18752)

    -- Destruction Holo-gogs -- 41320
    recipe = AddRecipe(41320, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(50, 50, 60, 65, 70)
    recipe:SetCraftedItem(32494, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENGINEERING_HEAD")
    recipe:AddFilters(F.CASTER, F.HEALER, F.MAGE, F.PRIEST, F.WARLOCK)
    recipe:AddTrainer(18775, 26955, 33586, 17637, 19576, 26907, 17634, 25277, 28697, 26991, 18752)

    -- Powerheal 4000 Lens -- 41321
    recipe = AddRecipe(41321, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(50, 50, 60, 65, 70)
    recipe:SetCraftedItem(32495, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENGINEERING_HEAD")
    recipe:AddFilters(F.CASTER, F.HEALER, F.PRIEST)
    recipe:AddTrainer(18775, 26955, 33586, 17637, 19576, 26907, 17634, 25277, 28697, 26991, 18752)

    -- Flying Machine -- 44155
    recipe = AddRecipe(44155, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 11, 16, 21)
    recipe:SetCraftedItem(34060, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_MOUNT")
    recipe:AddTrainer(25277, 28697, 33586, 25099, 26955, 24868)

    -- Turbo-Charged Flying Machine -- 44157
    recipe = AddRecipe(44157, V.TBC, Q.COMMON)
    recipe:SetSkillLevels(75, 75, 85, 90, 95)
    recipe:SetCraftedItem(34061, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_MOUNT")
    recipe:AddTrainer(24868, 25099)

    -- Field Repair Bot 110G -- 44391
    recipe = AddRecipe(44391, V.TBC, Q.UNCOMMON)
    recipe:SetSkillLevels(360, 360, 370, 380, 390)
    recipe:SetRecipeItem(34114, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(34113, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
    recipe:AddMobDrop(23385, 23386)

    -- Wonderheal XT68 Shades -- 46106
    recipe = AddRecipe(46106, V.TBC, Q.EPIC)
    recipe:SetSkillLevels(375, 375, 390, 410, 430)
    recipe:SetRecipeItem(35191, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(35183, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENGINEERING_HEAD")
    recipe:AddFilters(F.DRUID)
    recipe:AddWorldDrop(Z.SUNWELL_PLATEAU)

    -- Justicebringer 3000 Specs -- 46107
    recipe = AddRecipe(46107, V.TBC, Q.EPIC)
    recipe:SetSkillLevels(375, 375, 390, 410, 430)
    recipe:SetRecipeItem(35187, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(35185, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENGINEERING_HEAD")
    recipe:AddFilters(F.CASTER, F.HEALER, F.PALADIN)
    recipe:AddWorldDrop(Z.SUNWELL_PLATEAU)

    -- Powerheal 9000 Lens -- 46108
    recipe = AddRecipe(46108, V.TBC, Q.EPIC)
    recipe:SetSkillLevels(375, 375, 390, 410, 430)
    recipe:SetRecipeItem(35189, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(35181, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENGINEERING_HEAD")
    recipe:AddFilters(F.CASTER, F.HEALER, F.PRIEST)
    recipe:AddWorldDrop(Z.SUNWELL_PLATEAU)

    -- Hyper-Magnified Moon Specs -- 46109
    recipe = AddRecipe(46109, V.TBC, Q.EPIC)
    recipe:SetSkillLevels(375, 375, 390, 410, 430)
    recipe:SetRecipeItem(35190, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(35182, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENGINEERING_HEAD")
    recipe:AddFilters(F.CASTER, F.HEALER, F.DRUID, F.MONK)
    recipe:AddWorldDrop(Z.SUNWELL_PLATEAU)

    -- Primal-Attuned Goggles -- 46110
    recipe = AddRecipe(46110, V.TBC, Q.EPIC)
    recipe:SetSkillLevels(375, 375, 390, 410, 430)
    recipe:SetRecipeItem(35192, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(35184, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENGINEERING_HEAD")
    recipe:AddFilters(F.CASTER, F.HEALER, F.SHAMAN)
    recipe:AddWorldDrop(Z.SUNWELL_PLATEAU)

    -- Annihilator Holo-Gogs -- 46111
    recipe = AddRecipe(46111, V.TBC, Q.EPIC)
    recipe:SetSkillLevels(375, 375, 390, 410, 430)
    recipe:SetRecipeItem(35186, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(34847, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENGINEERING_HEAD")
    recipe:AddFilters(F.CASTER, F.HEALER, F.MAGE, F.PRIEST, F.WARLOCK)
    recipe:AddWorldDrop(Z.SUNWELL_PLATEAU)

    -- Lightning Etched Specs -- 46112
    recipe = AddRecipe(46112, V.TBC, Q.EPIC)
    recipe:SetSkillLevels(375, 375, 390, 410, 430)
    recipe:SetRecipeItem(35193, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(34355, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENGINEERING_HEAD")
    recipe:AddFilters(F.CASTER, F.MONK)
    recipe:AddWorldDrop(Z.SUNWELL_PLATEAU)

    -- Surestrike Goggles v3.0 -- 46113
    recipe = AddRecipe(46113, V.TBC, Q.EPIC)
    recipe:SetSkillLevels(375, 375, 390, 410, 430)
    recipe:SetRecipeItem(35194, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(34356, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENGINEERING_HEAD")
    recipe:AddFilters(F.HUNTER, F.SHAMAN)
    recipe:AddWorldDrop(Z.SUNWELL_PLATEAU)

    -- Mayhem Projection Goggles -- 46114
    recipe = AddRecipe(46114, V.TBC, Q.EPIC)
    recipe:SetSkillLevels(375, 375, 390, 410, 430)
    recipe:SetRecipeItem(35195, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(34354, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENGINEERING_HEAD")
    recipe:AddFilters(F.CASTER, F.HEALER, F.DK, F.PALADIN, F.WARRIOR)
    recipe:AddWorldDrop(Z.SUNWELL_PLATEAU)

    -- Hard Khorium Goggles -- 46115
    recipe = AddRecipe(46115, V.TBC, Q.EPIC)
    recipe:SetSkillLevels(375, 375, 390, 410, 430)
    recipe:SetRecipeItem(35196, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(34357, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENGINEERING_HEAD")
    recipe:AddFilters(F.CASTER, F.HEALER, F.TANK, F.DK, F.PALADIN, F.WARRIOR)
    recipe:AddWorldDrop(Z.SUNWELL_PLATEAU)

    -- Quad Deathblow X44 Goggles -- 46116
    recipe = AddRecipe(46116, V.TBC, Q.EPIC)
    recipe:SetSkillLevels(375, 375, 390, 410, 430)
    recipe:SetRecipeItem(35197, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(34353, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENGINEERING_HEAD")
    recipe:AddFilters(F.DRUID, F.ROGUE, F.MONK)
    recipe:AddWorldDrop(Z.SUNWELL_PLATEAU)

    -- Rocket Boots Xtreme Lite -- 46697
    recipe = AddRecipe(46697, V.TBC, Q.RARE)
    recipe:SetSkillLevels(355, 355, 365, 375, 385)
    recipe:SetRecipeItem(35582, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(35581, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_FEET")
    recipe:AddFilters(F.CASTER, F.HEALER)
    recipe:AddMobDrop(19219)

    -- ----------------------------------------------------------------------------
    -- Wrath of the Lich King.
    -- ----------------------------------------------------------------------------
    -- Titanium Toolbox -- 30349
    recipe = AddRecipe(30349, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(405, 405, 425, 432, 440)
    recipe:SetRecipeItem(23817, "BIND_ON_EQUIP")
    recipe:SetCraftedItem(23775, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_BAG")
    recipe:AddLimitedVendor(28722, 5, 33594, 5, 93539, 5)

    -- Volatile Blasting Trigger -- 53281
    recipe = AddRecipe(53281, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 11, 16, 21)
    recipe:SetCraftedItem(39690, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_MATERIALS")
    recipe:AddTrainer(26907, 25277, 26991, 28697, 26955, 33586)

    -- Mark "S" Boomstick -- 54353
    recipe = AddRecipe(54353, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(25, 25, 35, 40, 45)
    recipe:SetCraftedItem(39688, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENGINEERING_GUN")
    recipe:AddFilters(F.CASTER, F.HEALER)
    recipe:AddTrainer(26907, 25277, 26991, 28697, 26955, 33586)

    -- EMP Generator -- 54736
    recipe = AddRecipe(54736, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(15, 15, 25, 30, 35)
    recipe:SetItemFilterType("ENGINEERING_ITEM_ENHANCEMENT")
    recipe:AddTrainer(26907, 25277, 26991, 28697, 26955, 33586)

    -- Frag Belt -- 54793
    recipe = AddRecipe(54793, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(5, 5, 15, 20, 25)
    recipe:SetItemFilterType("ENGINEERING_ITEM_ENHANCEMENT")
    recipe:AddTrainer(26907, 25277, 26991, 28697, 26955, 33586)

    -- Flexweave Underlay -- 55002
    recipe = AddRecipe(55002, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(5, 5, 15, 20, 25)
    recipe:SetItemFilterType("ENGINEERING_ITEM_ENHANCEMENT")
    recipe:AddTrainer(26907, 25277, 26991, 28697, 26955, 33586)

    -- Nitro Boosts -- 55016
    recipe = AddRecipe(55016, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(30, 30, 40, 45, 50)
    recipe:SetItemFilterType("ENGINEERING_ITEM_ENHANCEMENT")
    recipe:AddTrainer(26907, 25277, 26991, 28697, 26955, 33586)

    -- Scrapbot Construction Kit -- 55252
    recipe = AddRecipe(55252, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(415, 415, 415, 417, 420)
    recipe:SetCraftedItem(40769, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
    recipe:AddQuest(12889)

    -- Handful of Cobalt Bolts -- 56349
    recipe = AddRecipe(56349, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 11, 16, 21)
    recipe:SetCraftedItem(39681, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_MATERIALS")
    recipe:AddTrainer(26907, 25277, 26991, 28697, 26955, 33586)

    -- Hammer Pick -- 56459
    recipe = AddRecipe(56459, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 11, 16, 21)
    recipe:SetCraftedItem(40892, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
    recipe:AddTrainer(26907, 25277, 26991, 28697, 26955, 33586)

    -- Cobalt Frag Bomb -- 56460
    recipe = AddRecipe(56460, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 11, 16, 21)
    recipe:SetCraftedItem(40771, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
    recipe:AddTrainer(26907, 25277, 26991, 28697, 26955, 33586)

    -- Bladed Pickaxe -- 56461
    recipe = AddRecipe(56461, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 11, 16, 21)
    recipe:SetCraftedItem(40893, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
    recipe:AddTrainer(26907, 25277, 26991, 28697, 26955, 33586)

    -- Gnomish Army Knife -- 56462
    recipe = AddRecipe(56462, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(60, 60, 70, 75, 80)
    recipe:SetCraftedItem(40772, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
    recipe:AddTrainer(26907, 25277, 26991, 28697, 26955, 33586)

    -- Explosive Decoy -- 56463
    recipe = AddRecipe(56463, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 11, 16, 21)
    recipe:SetCraftedItem(40536, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
    recipe:AddTrainer(26907, 25277, 26991, 28697, 26955, 33586)

    -- Overcharged Capacitor -- 56464
    recipe = AddRecipe(56464, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 11, 16, 21)
    recipe:SetCraftedItem(39682, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_MATERIALS")
    recipe:AddTrainer(26907, 25277, 26991, 28697, 26955, 33586)

    -- Mechanized Snow Goggles -- 56465
    recipe = AddRecipe(56465, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(45, 45, 55, 60, 65)
    recipe:SetCraftedItem(41112, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_HEAD")
    recipe:AddFilters(F.MAGE, F.PRIEST, F.WARLOCK)
    recipe:AddTrainer(26907, 25277, 26991, 28697, 26955, 33586)

    -- Sonic Booster -- 56466
    recipe = AddRecipe(56466, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(45, 45, 55, 60, 65)
    recipe:SetCraftedItem(40767, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_TRINKET")
    recipe:AddTrainer(26907, 25277, 26991, 28697, 26955, 33586)

    -- Noise Machine -- 56467
    recipe = AddRecipe(56467, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(45, 45, 55, 60, 65)
    recipe:SetCraftedItem(40865, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_TRINKET")
    recipe:AddFilters(F.CASTER, F.HEALER)
    recipe:AddTrainer(26907, 25277, 26991, 28697, 26955, 33586)

    -- Box of Bombs -- 56468
    recipe = AddRecipe(56468, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(30, 30, 40, 45, 50)
    recipe:SetCraftedItem(44951, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
    recipe:AddTrainer(26907, 25277, 26991, 28697, 26955, 33586)

    -- Gnomish Lightning Generator -- 56469
    recipe = AddRecipe(56469, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(50, 50, 60, 65, 70)
    recipe:SetCraftedItem(41121, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENGINEERING_TRINKET")
    recipe:AddFilters(F.CASTER, F.HEALER)
    recipe:AddTrainer(26907, 25277, 26991, 28697, 26955, 33586)

    -- Sun Scope -- 56470
    recipe = AddRecipe(56470, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(50, 50, 60, 65, 70)
    recipe:SetCraftedItem(41146, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_ITEM_ENHANCEMENT")
    recipe:AddFilters(F.CASTER, F.HEALER)
    recipe:AddTrainer(26907, 25277, 26991, 28697, 26955, 33586)

    -- Froststeel Tube -- 56471
    recipe = AddRecipe(56471, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(15, 15, 25, 30, 35)
    recipe:SetCraftedItem(39683, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_MATERIALS")
    recipe:AddTrainer(26907, 25277, 26991, 28697, 26955, 33586)

    -- MOLL-E -- 56472
    recipe = AddRecipe(56472, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(50, 50, 60, 65, 70)
    recipe:SetCraftedItem(40768, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_TOY")
    recipe:AddTrainer(26907, 25277, 26991, 28697, 26955, 33586)

    -- Gnomish X-Ray Specs -- 56473
    recipe = AddRecipe(56473, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 11, 16, 21)
    recipe:SetCraftedItem(40895, "BIND_ON_EQUIP")
    recipe:SetSpecialty(20219)
    recipe:SetItemFilterType("ENGINEERING_TOY")
    recipe:AddTrainer(26907, 26955, 29514)

    -- Healing Injector Kit -- 56476
    recipe = AddRecipe(56476, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(35, 35, 45, 50, 55)
    recipe:SetCraftedItem(37567, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
    recipe:AddTrainer(26907, 25277, 26991, 28697, 26955, 33586)

    -- Mana Injector Kit -- 56477
    recipe = AddRecipe(56477, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(40, 40, 50, 55, 60)
    recipe:SetCraftedItem(42546, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
    recipe:AddTrainer(26907, 25277, 26991, 28697, 26955, 33586)

    -- Heartseeker Scope -- 56478
    recipe = AddRecipe(56478, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(55, 55, 65, 70, 75)
    recipe:SetCraftedItem(41167, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_ITEM_ENHANCEMENT")
    recipe:AddFilters(F.CASTER, F.HEALER)
    recipe:AddTrainer(26907, 25277, 26991, 28697, 26955, 33586)

    -- Armor Plated Combat Shotgun -- 56479
    recipe = AddRecipe(56479, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(75, 75, 85, 90, 95)
    recipe:SetCraftedItem(41168, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_GUN")
    recipe:AddFilters(F.CASTER, F.HEALER, F.TANK)
    recipe:AddTrainer(26907, 25277, 26991, 28697, 26955, 33586)

    -- Armored Titanium Goggles -- 56480
    recipe = AddRecipe(56480, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(65, 65, 75, 80, 85)
    recipe:SetCraftedItem(42549, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENGINEERING_HEAD")
    recipe:AddFilters(F.CASTER, F.HEALER, F.TANK, F.DK, F.PALADIN, F.WARRIOR)
    recipe:AddTrainer(26907, 25277, 26991, 28697, 26955, 33586)

    -- Weakness Spectralizers -- 56481
    recipe = AddRecipe(56481, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(65, 65, 75, 80, 85)
    recipe:SetCraftedItem(42550, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENGINEERING_HEAD")
    recipe:AddFilters(F.DRUID, F.ROGUE, F.MONK)
    recipe:AddTrainer(26907, 25277, 26991, 28697, 26955, 33586)

    -- Charged Titanium Specs -- 56483
    recipe = AddRecipe(56483, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(65, 65, 75, 80, 85)
    recipe:SetCraftedItem(42552, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENGINEERING_HEAD")
    recipe:AddFilters(F.CASTER, F.HEALER, F.DK, F.PALADIN, F.WARRIOR)
    recipe:AddTrainer(26907, 25277, 26991, 28697, 26955, 33586)

    -- Visage Liquification Goggles -- 56484
    recipe = AddRecipe(56484, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(65, 65, 75, 80, 85)
    recipe:SetCraftedItem(42553, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENGINEERING_HEAD")
    recipe:AddFilters(F.CASTER, F.HEALER, F.MAGE, F.PRIEST, F.WARLOCK)
    recipe:AddTrainer(26907, 25277, 26991, 28697, 26955, 33586)

    -- Greensight Gogs -- 56486
    recipe = AddRecipe(56486, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(65, 65, 75, 80, 85)
    recipe:SetCraftedItem(42554, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENGINEERING_HEAD")
    recipe:AddFilters(F.DRUID)
    recipe:AddTrainer(26907, 25277, 26991, 28697, 26955, 33586)

    -- Electroflux Sight Enhancers -- 56487
    recipe = AddRecipe(56487, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(65, 65, 75, 80, 85)
    recipe:SetCraftedItem(42555, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENGINEERING_HEAD")
    recipe:AddFilters(F.HEALER, F.MONK)
    recipe:AddTrainer(26907, 25277, 26991, 28697, 26955, 33586)

    -- Global Thermal Sapper Charge -- 56514
    recipe = AddRecipe(56514, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(1, 1, 11, 16, 21)
    recipe:SetCraftedItem(42641, "BIND_ON_EQUIP")
    recipe:SetSpecialty(20222)
    recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
    recipe:AddTrainer(25277, 29513)

    -- Truesight Ice Blinders -- 56574
    recipe = AddRecipe(56574, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(65, 65, 75, 80, 85)
    recipe:SetCraftedItem(42551, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENGINEERING_HEAD")
    recipe:AddFilters(F.HUNTER, F.SHAMAN)
    recipe:AddTrainer(26907, 25277, 26991, 28697, 26955, 33586)

    -- Mechano-Hog -- 60866
    recipe = AddRecipe(60866, V.WOTLK, Q.EPIC)
    recipe:SetSkillLevels(450, 450, 480, 485, 490)
    recipe:SetRecipeItem(44502, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(41508, "BIND_ON_EQUIP")
    recipe:SetRequiredFaction("Horde")
    recipe:SetItemFilterType("ENGINEERING_MOUNT")
    recipe:AddRepVendor(FAC.HORDE_EXPEDITION, REP.EXALTED, 32565, 32774)

    -- Mekgineer's Chopper -- 60867
    recipe = AddRecipe(60867, V.WOTLK, Q.EPIC)
    recipe:SetSkillLevels(450, 450, 480, 485, 490)
    recipe:SetRecipeItem(44503, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(44413, "BIND_ON_EQUIP")
    recipe:SetRequiredFaction("Alliance")
    recipe:SetItemFilterType("ENGINEERING_MOUNT")
    recipe:AddRepVendor(FAC.ALLIANCE_VANGUARD, REP.EXALTED, 32564, 32773)

    -- Nesingwary 4000 -- 60874
    recipe = AddRecipe(60874, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(75, 75, 85, 90, 95)
    recipe:SetCraftedItem(44504, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_GUN")
    recipe:AddFilters(F.CASTER, F.HEALER)
    recipe:AddTrainer(26907, 25277, 26991, 28697, 26955, 33586)

    -- Diamond-cut Refractor Scope -- 61471
    recipe = AddRecipe(61471, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(15, 15, 25, 30, 35)
    recipe:SetCraftedItem(44739, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_ITEM_ENHANCEMENT")
    recipe:AddTrainer(26907, 25277, 26991, 28697, 26955, 33586)

    -- Mechanized Snow Goggles -- 61481
    recipe = AddRecipe(61481, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(45, 45, 55, 60, 65)
    recipe:SetCraftedItem(44740, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_HEAD")
    recipe:AddFilters(F.DRUID, F.ROGUE, F.MONK)
    recipe:AddTrainer(26907, 25277, 26991, 28697, 26955, 33586)

    -- Mechanized Snow Goggles -- 61482
    recipe = AddRecipe(61482, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(45, 45, 55, 60, 65)
    recipe:SetCraftedItem(44741, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_HEAD")
    recipe:AddFilters(F.HUNTER, F.SHAMAN)
    recipe:AddTrainer(26907, 25277, 26991, 28697, 26955, 33586)

    -- Mechanized Snow Goggles -- 61483
    recipe = AddRecipe(61483, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(45, 45, 55, 60, 65)
    recipe:SetCraftedItem(44742, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_HEAD")
    recipe:AddFilters(F.DK, F.PALADIN, F.WARRIOR)
    recipe:AddTrainer(26907, 25277, 26991, 28697, 26955, 33586)

    -- Unbreakable Healing Amplifiers -- 62271
    recipe = AddRecipe(62271, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(65, 65, 75, 80, 85)
    recipe:SetCraftedItem(44949, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENGINEERING_HEAD")
    recipe:AddFilters(F.CASTER, F.HEALER, F.PALADIN)
    recipe:AddTrainer(25277, 26907, 26955)

    -- High-powered Flashlight -- 63750
    recipe = AddRecipe(63750, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(250, 250, 270, 280, 290)
    recipe:SetCraftedItem(45631, "BIND_ON_EQUIP")
    recipe:SetItemFilterType("ENGINEERING_TRINKET")
    recipe:AddFilters(F.CASTER, F.HEALER)
    recipe:AddTrainer(11017, 11025, 17634, 3494, 1702, 25277, 17637, 1676, 26907, 33634, 26955, 16726, 5518, 11037, 33611,
        8736, 16667, 3290, 26991, 11031, 28697, 5174, 33586, 17222)

    -- Goblin Beam Welder -- 67326
    recipe = AddRecipe(67326, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(35, 35, 45, 50, 55)
    recipe:SetCraftedItem(47828, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
    recipe:AddTrainer(33586, 28697, 26955, 25277)

    -- Mind Amplification Dish -- 67839
    recipe = AddRecipe(67839, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(35, 35, 45, 50, 55)
    recipe:SetItemFilterType("ENGINEERING_ITEM_ENHANCEMENT")
    recipe:AddTrainer(33586, 28697, 26955, 25277)

    -- Wormhole Generator: Northrend -- 67920
    recipe = AddRecipe(67920, V.WOTLK, Q.COMMON)
    recipe:SetSkillLevels(60, 60, 70, 75, 80)
    recipe:SetCraftedItem(48933, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENGINEERING_TOY")
    recipe:AddTrainer(33586, 28697, 26955, 25277)

    -- Jeeves -- 68067
    recipe = AddRecipe(68067, V.WOTLK, Q.RARE)
    recipe:SetSkillLevels(450, 450, 480, 485, 490)
    recipe:SetRecipeItem(49050, "BIND_ON_PICKUP")
    recipe:SetCraftedItem(49040, "BIND_ON_PICKUP")
    recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
    recipe:AddWorldDrop(Z.NORTHREND)

    self.InitializeRecipes = nil
end
