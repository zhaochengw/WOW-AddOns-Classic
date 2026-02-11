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
	recipe:AddTrainer(1676, 1702, 3290, 3494, 4941, 5174, 5518, 8736, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 17637, 18752, 18775, 19576, 25099, 29513, 29514, 45545, 47384, 47396, 47400, 47418, 47419, 47421, 47431, 48619, 49885, 52636, 52651, 57620, 65043, 85918, 86012, 92194, 93520)

	-- Rough Copper Bomb -- 3923
	recipe = AddRecipe(3923, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(30, 30, 60, 75, 90)
	recipe:SetCraftedItem(4360, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddTrainer(1676, 1702, 3290, 3494, 4941, 5174, 5518, 8736, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 17637, 18752, 18775, 19576, 25099, 29513, 29514, 45545, 47384, 47396, 47400, 47418, 47419, 47421, 47431, 48619, 49885, 52636, 52651, 57620, 65043, 85918, 86012, 92194, 93520)

	-- Rough Boomstick -- 3925
	recipe = AddRecipe(3925, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 80, 95, 110)
	recipe:SetCraftedItem(4362, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_GUN")
	recipe:AddTrainer(1676, 1702, 3290, 3494, 4941, 5174, 5518, 8736, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 17637, 18752, 18775, 19576, 25099, 29513, 29514, 45545, 47384, 47396, 47400, 47418, 47419, 47421, 47431, 48619, 49885, 52636, 52651, 57620, 65043, 85918, 86012, 92194, 93520)

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
	recipe:AddTrainer(1676, 1702, 3290, 3494, 4941, 5174, 5518, 8736, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 17637, 18752, 18775, 19576, 25099, 29513, 29514, 45545, 47384, 47396, 47400, 47418, 47419, 47421, 47431, 48619, 49885, 52636, 52651, 57620, 65043, 85918, 86012, 92194, 93520)

	-- Coarse Dynamite -- 3931
	recipe = AddRecipe(3931, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(65, 65, 75, 80, 85)
	recipe:SetCraftedItem(4365, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddTrainer(1676, 1702, 3290, 3494, 4941, 5174, 5518, 8736, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 17637, 18752, 18775, 19576, 25099, 29513, 29514, 45545, 47384, 47396, 47400, 47418, 47419, 47421, 47431, 48619, 49885, 52636, 52651, 57620, 65043, 85918, 86012, 92194, 93520)

	-- Target Dummy -- 3932
	recipe = AddRecipe(3932, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(85, 85, 115, 130, 145)
	recipe:SetCraftedItem(4366, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddTrainer(1676, 1702, 3290, 3494, 4941, 5174, 5518, 8736, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 17637, 18752, 18775, 19576, 25099, 45545, 49885, 52636, 52651)

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
	recipe:AddTrainer(1676, 1702, 3290, 3494, 4941, 5174, 5518, 8736, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 17637, 18752, 18775, 19576, 25099, 45545, 49885, 52636, 52651)

	-- Deadly Blunderbuss -- 3936
	recipe = AddRecipe(3936, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(105, 105, 130, 142, 155)
	recipe:SetCraftedItem(4369, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_GUN")
	recipe:AddTrainer(1676, 1702, 3290, 3494, 4941, 5174, 5518, 8736, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 17637, 18752, 18775, 19576, 25099, 45545, 49885, 52636, 52651)

	-- Large Copper Bomb -- 3937
	recipe = AddRecipe(3937, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(105, 105, 105, 130, 155)
	recipe:SetCraftedItem(4370, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddTrainer(1676, 1702, 3290, 3494, 4941, 5174, 5518, 8736, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 17637, 18752, 18775, 19576, 25099, 45545, 49885, 52636, 52651)

	-- Bronze Tube -- 3938
	recipe = AddRecipe(3938, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(105, 105, 105, 130, 155)
	recipe:SetCraftedItem(4371, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_MATERIALS")
	recipe:AddTrainer(1676, 1702, 3290, 3494, 4941, 5174, 5518, 8736, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 17637, 18752, 18775, 19576, 25099, 45545, 49885, 52636, 52651)

	-- Lovingly Crafted Boomstick -- 3939
	recipe = AddRecipe(3939, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(120, 120, 145, 157, 170)
	recipe:SetCraftedItem(4372, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_GUN")
	recipe:AddTrainer(1702, 3494, 4941, 5174, 5518, 8736, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 25099, 45545, 49885, 52636, 52651)

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
	recipe:AddTrainer(1676, 1702, 3290, 3494, 4941, 5174, 5518, 8736, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 17637, 18752, 18775, 19576, 25099, 45545, 49885, 52636, 52651)

	-- Whirring Bronze Gizmo -- 3942
	recipe = AddRecipe(3942, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(125, 125, 125, 150, 175)
	recipe:SetCraftedItem(4375, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_MATERIALS")
	recipe:AddTrainer(1676, 1702, 3290, 3494, 4941, 5174, 5518, 8736, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 17637, 18752, 18775, 19576, 25099, 45545, 49885, 52636, 52651)

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
	recipe:AddTrainer(1676, 1702, 3290, 3494, 4941, 5174, 5518, 8736, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 17637, 18752, 18775, 19576, 25099, 45545, 49885, 52636, 52651)

	-- Heavy Dynamite -- 3946
	recipe = AddRecipe(3946, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(125, 125, 125, 135, 145)
	recipe:SetCraftedItem(4378, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddTrainer(1676, 1702, 3290, 3494, 4941, 5174, 5518, 8736, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 17637, 18752, 18775, 19576, 25099, 45545, 49885, 52636, 52651)

	-- Silver-plated Shotgun -- 3949
	recipe = AddRecipe(3949, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(130, 130, 155, 167, 180)
	recipe:SetCraftedItem(4379, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_GUN")
	recipe:AddTrainer(1676, 1702, 3290, 3494, 4941, 5174, 5518, 8736, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 17637, 18752, 18775, 19576, 25099, 45545, 49885, 52636, 52651)

	-- Big Bronze Bomb -- 3950
	recipe = AddRecipe(3950, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(140, 140, 140, 165, 190)
	recipe:SetCraftedItem(4380, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddTrainer(1676, 1702, 3290, 3494, 4941, 5174, 5518, 8736, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 17637, 18752, 18775, 19576, 25099, 45545, 49885, 52636, 52651)

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
	recipe:AddTrainer(1676, 1702, 3290, 3494, 4941, 5174, 5518, 8736, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 17637, 18752, 18775, 19576, 25099, 45545, 49885, 52636, 52651)

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
	recipe:AddTrainer(1676, 1702, 3290, 3494, 4941, 5174, 5518, 8736, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 17637, 18752, 18775, 19576, 25099, 45545, 49885, 52636, 52651)

	-- Green Tinted Goggles -- 3956
	recipe = AddRecipe(3956, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(150, 150, 175, 187, 200)
	recipe:SetCraftedItem(4385, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(1676, 1702, 3290, 3494, 4941, 5174, 5518, 8736, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 17637, 18752, 18775, 19576, 25099, 45545, 49885, 52636, 52651)

	-- Ice Deflector -- 3957
	recipe = AddRecipe(3957, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(155, 155, 175, 185, 195)
	recipe:SetRecipeItem(13308, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(4386, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:Retire()

	-- Iron Strut -- 3958
	recipe = AddRecipe(3958, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(160, 160, 160, 170, 180)
	recipe:SetCraftedItem(4387, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_MATERIALS")
	recipe:AddTrainer(1676, 1702, 3290, 3494, 4941, 5174, 5518, 8736, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 17637, 18752, 18775, 19576, 25099, 45545, 52636, 52651)

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
	recipe:AddTrainer(1676, 1702, 3290, 3494, 4941, 5174, 5518, 8736, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 17637, 18752, 18775, 19576, 25099, 45545, 52636, 52651)

	-- Iron Grenade -- 3962
	recipe = AddRecipe(3962, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(175, 175, 175, 195, 215)
	recipe:SetCraftedItem(4390, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddTrainer(1676, 1702, 3290, 3494, 4941, 5174, 5518, 8736, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 17637, 18752, 18775, 19576, 25099, 45545, 52636, 52651)

	-- Compact Harvest Reaper Kit -- 3963
	recipe = AddRecipe(3963, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(175, 175, 175, 195, 215)
	recipe:SetCraftedItem(4391, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddTrainer(1676, 1702, 3290, 3494, 4941, 5174, 5518, 8736, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 17637, 18752, 18775, 19576, 25099, 45545, 52636, 52651)

	-- Advanced Target Dummy -- 3965
	recipe = AddRecipe(3965, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(185, 185, 185, 205, 225)
	recipe:SetCraftedItem(4392, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddTrainer(1676, 1702, 3290, 3494, 4941, 5174, 5518, 8736, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 17637, 18752, 18775, 19576, 25099, 45545, 52636, 52651)

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
	recipe:AddTrainer(1676, 1702, 3290, 3494, 4941, 5174, 5518, 8736, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 17637, 18752, 18775, 19576, 25099, 45545, 52636, 52651)

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
	recipe:AddTrainer(1676, 1702, 3290, 3494, 4941, 5174, 5518, 8736, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 17637, 18752, 18775, 19576, 25099, 45545, 49885, 52636, 52651)

	-- Crude Scope -- 3977
	recipe = AddRecipe(3977, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(60, 60, 90, 105, 120)
	recipe:SetCraftedItem(4405, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_ITEM_ENHANCEMENT")
	recipe:AddTrainer(1676, 1702, 3290, 3494, 4941, 5174, 5518, 8736, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 17637, 18752, 18775, 19576, 25099, 29513, 29514, 45545, 47384, 47396, 47400, 47418, 47419, 47421, 47431, 48619, 49885, 52636, 52651, 57620, 65043, 85918, 86012, 92194, 93520)

	-- Standard Scope -- 3978
	recipe = AddRecipe(3978, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(110, 110, 135, 147, 160)
	recipe:SetCraftedItem(4406, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_ITEM_ENHANCEMENT")
	recipe:AddTrainer(1676, 1702, 3290, 3494, 4941, 5174, 5518, 8736, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 17637, 18752, 18775, 19576, 25099, 45545, 49885, 52636, 52651)

	-- Accurate Scope -- 3979
	recipe = AddRecipe(3979, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(180, 180, 200, 210, 220)
	recipe:SetCraftedItem(4407, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_ITEM_ENHANCEMENT")
	recipe:AddTrainer(1702, 4941, 5174, 5518, 8736, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 25099, 45545, 52636, 52651)

	-- Ornate Spyglass -- 6458
	recipe = AddRecipe(6458, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(135, 135, 160, 172, 185)
	recipe:SetCraftedItem(5507, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddTrainer(1676, 1702, 3290, 3494, 4941, 5174, 5518, 8736, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 17637, 18752, 18775, 19576, 25099, 45545, 49885, 52636, 52651)

	-- Arclight Spanner -- 7430
	recipe = AddRecipe(7430, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 70, 80, 90)
	recipe:SetCraftedItem(6219, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_MAIN_HAND")
	recipe:AddTrainer(1676, 1702, 3290, 3494, 4941, 5174, 5518, 8736, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 17637, 18752, 18775, 19576, 25099, 29513, 29514, 45545, 47384, 47396, 47400, 47418, 47419, 47421, 47431, 48619, 49885, 52636, 52651, 57620, 65043, 85918, 86012, 92194, 93520)

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
	recipe:AddTrainer(1676, 1702, 3290, 3494, 4941, 5174, 5518, 8736, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 17637, 18752, 18775, 19576, 25099, 45545, 49885, 52636, 52651)

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
	recipe:AddTrainer(1702, 4941, 5174, 5518, 8126, 8736, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 25099, 29513, 45545, 52636, 52651, 86012, 93520)

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
	recipe:AddTrainer(1676, 1702, 3290, 3494, 4941, 5174, 5518, 8736, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 17637, 18752, 18775, 19576, 25099, 45545, 49885, 52636, 52651)

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
	recipe:AddTrainer(1676, 1702, 3290, 3494, 4941, 5174, 5518, 8736, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 17637, 18752, 18775, 19576, 25099, 45545, 49885, 52636, 52651)

	-- Solid Blasting Powder -- 12585
	recipe = AddRecipe(12585, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(175, 175, 175, 185, 195)
	recipe:SetCraftedItem(10505, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_MATERIALS")
	recipe:AddTrainer(1676, 1702, 3290, 3494, 4941, 5174, 5518, 8736, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 17637, 18752, 18775, 19576, 25099, 45545, 52636, 52651)

	-- Solid Dynamite -- 12586
	recipe = AddRecipe(12586, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(175, 175, 175, 185, 195)
	recipe:SetCraftedItem(10507, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddTrainer(1676, 1702, 3290, 3494, 4941, 5174, 5518, 8736, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 17637, 18752, 18775, 19576, 25099, 45545, 52636, 52651)

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
	recipe:AddTrainer(1676, 1702, 3290, 3494, 4941, 5174, 5518, 8736, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 17637, 18752, 18775, 19576, 25099, 45545, 52636, 52651)

	-- Gyromatic Micro-Adjustor -- 12590
	recipe = AddRecipe(12590, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(175, 175, 175, 195, 215)
	recipe:SetCraftedItem(10498, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_MATERIALS")
	recipe:AddTrainer(1676, 1702, 3290, 3494, 4941, 5174, 5518, 8736, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 17637, 18752, 18775, 19576, 25099, 45545, 52636, 52651)

	-- Unstable Trigger -- 12591
	recipe = AddRecipe(12591, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(200, 200, 200, 220, 240)
	recipe:SetCraftedItem(10560, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_MATERIALS")
	recipe:AddTrainer(1676, 1702, 3290, 3494, 4941, 5174, 5518, 8736, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 17637, 18752, 18775, 19576, 25099, 45545, 52636, 52651)

	-- Fire Goggles -- 12594
	recipe = AddRecipe(12594, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(205, 205, 225, 235, 245)
	recipe:SetCraftedItem(10500, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddTrainer(1676, 1702, 3290, 3494, 4941, 5174, 5518, 8736, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 17637, 18752, 18775, 19576, 25099, 45545, 52636, 52651)

	-- Mithril Blunderbuss -- 12595
	recipe = AddRecipe(12595, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(205, 205, 225, 235, 245)
	recipe:SetCraftedItem(10508, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_GUN")
	recipe:AddTrainer(1676, 1702, 3290, 3494, 4941, 5174, 5518, 8736, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 17637, 18752, 18775, 19576, 25099, 45545, 52636, 52651)

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
	recipe:AddTrainer(1676, 1702, 3290, 3494, 4941, 5174, 5518, 8736, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 17637, 18752, 18775, 19576, 25099, 45545, 52636, 52651)

	-- Mithril Frag Bomb -- 12603
	recipe = AddRecipe(12603, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(215, 215, 215, 235, 255)
	recipe:SetCraftedItem(10514, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddTrainer(1676, 1702, 3290, 3494, 4941, 5174, 5518, 8736, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 17637, 18752, 18775, 19576, 25099, 45545, 52636, 52651)

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
	recipe:AddTrainer(1676, 1702, 3290, 3494, 4941, 5174, 5518, 8736, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 17637, 18752, 18775, 19576, 25099, 45545, 52636, 52651)

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
	recipe:AddTrainer(1702, 3494, 4941, 5174, 5518, 8736, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 25099, 45545, 52636, 52651)

	-- Rose Colored Goggles -- 12618
	recipe = AddRecipe(12618, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(230, 230, 250, 260, 270)
	recipe:SetCraftedItem(10503, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(1676, 1702, 3290, 3494, 4941, 5174, 5518, 8736, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 17637, 18752, 18775, 19576, 25099, 45545, 52636, 52651)

	-- Hi-Explosive Bomb -- 12619
	recipe = AddRecipe(12619, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(235, 235, 235, 255, 275)
	recipe:SetCraftedItem(10562, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddTrainer(1676, 1702, 3290, 3494, 4941, 5174, 5518, 8736, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 17637, 18752, 18775, 19576, 25099, 45545, 52636, 52651)

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
	recipe:AddTrainer(1676, 1702, 3290, 3494, 4941, 5174, 5518, 8736, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 17637, 18752, 18775, 19576, 25099, 45545, 52636, 52651)

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
	recipe:AddTrainer(1702, 4941, 5174, 5518, 8126, 8736, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 25099, 29513, 45545, 52636, 52651, 86012, 93520)

	-- Goblin Mortar -- 12716
	recipe = AddRecipe(12716, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(205, 205, 225, 235, 245)
	recipe:SetCraftedItem(10577, "BIND_ON_EQUIP")
	recipe:SetSpecialty(20222)
	recipe:SetItemFilterType("ENGINEERING_TRINKET")
	recipe:AddTrainer(1702, 4941, 5174, 5518, 8126, 8736, 8738, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 25099, 29513, 45545, 52636, 52651, 86012, 93520)

	-- Goblin Mining Helmet -- 12717
	recipe = AddRecipe(12717, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(205, 205, 225, 235, 245)
	recipe:SetCraftedItem(10542, "BIND_ON_PICKUP")
	recipe:SetSpecialty(20222)
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddFilters(F.HUNTER, F.SHAMAN)
	recipe:AddTrainer(1702, 4941, 5174, 5518, 8126, 8736, 8738, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 25099, 29513, 45545, 52636, 52651, 86012, 93520)

	-- Goblin Construction Helmet -- 12718
	recipe = AddRecipe(12718, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(205, 205, 225, 235, 245)
	recipe:SetCraftedItem(10543, "BIND_ON_PICKUP")
	recipe:SetSpecialty(20222)
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddTrainer(1702, 4941, 5174, 5518, 8126, 8736, 8738, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 25099, 29513, 45545, 52636, 52651, 86012, 93520)

	-- The Big One -- 12754
	recipe = AddRecipe(12754, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(235, 235, 235, 255, 275)
	recipe:SetCraftedItem(10586, "BIND_ON_EQUIP")
	recipe:SetSpecialty(20222)
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddTrainer(1702, 4941, 5174, 5518, 8126, 8736, 8738, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 25099, 29513, 45545, 52636, 52651, 86012, 93520)

	-- Goblin Bomb Dispenser -- 12755
	recipe = AddRecipe(12755, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(230, 230, 230, 250, 270)
	recipe:SetCraftedItem(10587, "BIND_ON_PICKUP")
	recipe:SetSpecialty(20222)
	recipe:SetItemFilterType("ENGINEERING_TRINKET")
	recipe:AddTrainer(1702, 4941, 5174, 5518, 8126, 8736, 8738, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 25099, 29513, 45545, 52636, 52651, 86012, 93520)

	-- Goblin Rocket Helmet -- 12758
	recipe = AddRecipe(12758, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(245, 245, 265, 275, 285)
	recipe:SetCraftedItem(10588, "BIND_ON_EQUIP")
	recipe:SetSpecialty(20222)
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddTrainer(1702, 4941, 5174, 5518, 8126, 8736, 8738, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 25099, 29513, 45545, 52636, 52651, 86012, 93520)

	-- Gnomish Death Ray -- 12759
	recipe = AddRecipe(12759, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(240, 240, 260, 270, 280)
	recipe:SetCraftedItem(10645, "BIND_ON_PICKUP")
	recipe:SetSpecialty(20219)
	recipe:SetItemFilterType("ENGINEERING_TRINKET")
	recipe:AddTrainer(1702, 4941, 5174, 5518, 7406, 7944, 8736, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 25099, 29514, 45545, 52636, 52651, 85918, 92194)

	-- Goblin Sapper Charge -- 12760
	recipe = AddRecipe(12760, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(205, 205, 205, 225, 245)
	recipe:SetCraftedItem(10646, "BIND_ON_EQUIP")
	recipe:SetSpecialty(20222)
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddTrainer(1702, 4941, 5174, 5518, 8126, 8736, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 25099, 29513, 45545, 52636, 52651, 86012, 93520)

	-- Inlaid Mithril Cylinder Plans -- 12895
	recipe = AddRecipe(12895, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(205, 205, 205, 205, 205)
	recipe:SetCraftedItem(10713, "BIND_ON_EQUIP")
	recipe:SetSpecialty(20219)
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddTrainer(1702, 4941, 5174, 5518, 7406, 7944, 8736, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 25099, 29514, 45545, 52636, 52651, 85918, 92194)

	-- Gnomish Goggles -- 12897
	recipe = AddRecipe(12897, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(215, 215, 230, 240, 250)
	recipe:SetCraftedItem(10545, "BIND_ON_PICKUP")
	recipe:SetSpecialty(20219)
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(1702, 4941, 5174, 5518, 7406, 7944, 8736, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 25099, 29514, 45545, 52636, 52651, 85918, 92194)

	-- Gnomish Shrink Ray -- 12899
	recipe = AddRecipe(12899, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(205, 205, 225, 235, 245)
	recipe:SetCraftedItem(10716, "BIND_ON_EQUIP")
	recipe:SetSpecialty(20219)
	recipe:SetItemFilterType("ENGINEERING_TRINKET")
	recipe:AddTrainer(1702, 4941, 5174, 5518, 7406, 7944, 8736, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 25099, 29514, 45545, 52636, 52651, 85918, 92194)

	-- Gnomish Net-o-Matic Projector -- 12902
	recipe = AddRecipe(12902, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(210, 210, 230, 240, 250)
	recipe:SetCraftedItem(10720, "BIND_ON_EQUIP")
	recipe:SetSpecialty(20219)
	recipe:SetItemFilterType("ENGINEERING_TRINKET")
	recipe:AddTrainer(1702, 4941, 5174, 5518, 7406, 7944, 8736, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 25099, 29514, 45545, 52636, 52651, 85918, 92194)

	-- Gnomish Harm Prevention Belt -- 12903
	recipe = AddRecipe(12903, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(215, 215, 235, 245, 255)
	recipe:SetCraftedItem(10721, "BIND_ON_EQUIP")
	recipe:SetSpecialty(20219)
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddTrainer(1702, 4941, 5174, 5518, 7406, 7944, 8736, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 25099, 29514, 45545, 52636, 52651, 85918, 92194)

	-- Gnomish Rocket Boots -- 12905
	recipe = AddRecipe(12905, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(210, 210, 245, 255, 265)
	recipe:SetCraftedItem(10724, "BIND_ON_EQUIP")
	recipe:SetSpecialty(20219)
	recipe:SetItemFilterType("ENGINEERING_FEET")
	recipe:AddTrainer(1702, 4941, 5174, 5518, 7406, 7944, 8736, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 25099, 29514, 45545, 52636, 52651, 85918, 92194)

	-- Gnomish Battle Chicken -- 12906
	recipe = AddRecipe(12906, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(230, 230, 250, 260, 270)
	recipe:SetCraftedItem(10725, "BIND_ON_PICKUP")
	recipe:SetSpecialty(20219)
	recipe:SetItemFilterType("ENGINEERING_TRINKET")
	recipe:AddTrainer(1702, 4941, 5174, 5518, 7406, 7944, 8736, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 25099, 29514, 45545, 52636, 52651, 85918, 92194)

	-- Gnomish Mind Control Cap -- 12907
	recipe = AddRecipe(12907, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(235, 235, 255, 265, 275)
	recipe:SetCraftedItem(10726, "BIND_ON_EQUIP")
	recipe:SetSpecialty(20219)
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(1702, 4941, 5174, 5518, 7406, 7944, 8736, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 25099, 29514, 45545, 52636, 52651, 85918, 92194)

	-- Goblin Dragon Gun -- 12908
	recipe = AddRecipe(12908, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(240, 240, 260, 270, 280)
	recipe:SetCraftedItem(10727, "BIND_ON_PICKUP")
	recipe:SetSpecialty(20222)
	recipe:SetItemFilterType("ENGINEERING_TRINKET")
	recipe:AddTrainer(1702, 4941, 5174, 5518, 8126, 8736, 8738, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 25099, 29513, 45545, 52636, 52651, 86012, 93520)

	-- The Mortar: Reloaded -- 13240
	recipe = AddRecipe(13240, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(205, 205, 205, 205, 205)
	recipe:SetSpecialty(20222)
	recipe:SetItemFilterType("ENGINEERING_TRINKET")
	recipe:Retire()

	-- Mechanical Repair Kit -- 15255
	recipe = AddRecipe(15255, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(200, 200, 200, 220, 240)
	recipe:SetCraftedItem(11590, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddTrainer(1676, 1702, 3290, 3494, 4941, 5174, 5518, 8736, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 17637, 18752, 18775, 19576, 25099, 45545, 52636, 52651)

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
	recipe:AddTrainer(1676, 1702, 3290, 3494, 4941, 5174, 5518, 8736, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 17637, 18752, 18775, 19576, 25099, 45545, 52636, 52651)

	-- Thorium Grenade -- 19790
	recipe = AddRecipe(19790, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(260, 260, 280, 290, 300)
	recipe:SetCraftedItem(15993, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddTrainer(1676, 1702, 3290, 3494, 4941, 5174, 5518, 8736, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 17637, 18752, 18775, 19576, 25099, 45545, 52636, 52651)

	-- Thorium Widget -- 19791
	recipe = AddRecipe(19791, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(260, 260, 280, 290, 300)
	recipe:SetCraftedItem(15994, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_MATERIALS")
	recipe:AddTrainer(1676, 1702, 3290, 3494, 4941, 5174, 5518, 8736, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 17637, 18752, 18775, 19576, 25099, 45545, 52636, 52651)

	-- Thorium Rifle -- 19792
	recipe = AddRecipe(19792, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(260, 260, 280, 290, 300)
	recipe:SetCraftedItem(15995, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_GUN")
	recipe:AddTrainer(1676, 1702, 3290, 3494, 4941, 5174, 5518, 8736, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 17637, 18752, 18775, 19576, 25099, 45545, 52636, 52651)

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
	recipe:AddTrainer(1676, 1702, 3290, 3494, 4941, 5174, 5518, 8736, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 17637, 18752, 18775, 19576, 25099, 45545, 52636, 52651)

	-- Thorium Tube -- 19795
	recipe = AddRecipe(19795, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(275, 275, 295, 305, 315)
	recipe:SetCraftedItem(16000, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_MATERIALS")
	recipe:AddTrainer(1676, 1702, 3290, 3494, 4941, 5174, 5518, 8736, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 17637, 18752, 18775, 19576, 25099, 45545, 52636, 52651)

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
	recipe:AddTrainer(1676, 1702, 3290, 3494, 4941, 5174, 5518, 8736, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 17637, 18752, 18775, 19576, 25099, 45545, 52636, 52651)

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
	recipe:Retire()

	-- Snowmaster 9000 -- 21940
	recipe = AddRecipe(21940, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(190, 190, 190, 210, 230)
	recipe:SetRecipeItem(17720, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(17716, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_TOY")
	recipe:AddWorldEvent("WINTER_VEIL")
	recipe:AddCustom("PRESENTS")

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
	recipe:AddTrainer(1676, 1702, 3290, 3494, 4941, 5174, 5518, 8736, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 17637, 18752, 18775, 19576, 25099, 45545, 52636, 52651)

	-- Truesilver Transformer -- 23071
	recipe = AddRecipe(23071, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(260, 260, 270, 275, 280)
	recipe:SetCraftedItem(18631, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_MATERIALS")
	recipe:AddTrainer(1676, 1702, 3290, 3494, 4941, 5174, 5518, 8736, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 17637, 18752, 18775, 19576, 25099, 45545, 52636, 52651)

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
	recipe:Retire()

	-- Bloodvine Lens -- 24357
	recipe = AddRecipe(24357, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(20001, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(19998, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddFilters(F.CASTER, F.HEALER, F.DRUID, F.ROGUE, F.MONK)
	recipe:Retire()

	-- Tranquil Mechanical Yeti -- 26011
	recipe = AddRecipe(26011, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(250, 250, 320, 330, 340)
	recipe:SetCraftedItem(21277, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_PET")
	recipe:Retire()

	-- Small Blue Rocket -- 26416
	recipe = AddRecipe(26416, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(125, 125, 125, 137, 150)
	recipe:SetRecipeItem(21724, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(21558, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddVendor(15909)
	recipe:AddWorldEvent("LUNAR_FESTIVAL")

	-- Small Green Rocket -- 26417
	recipe = AddRecipe(26417, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(125, 125, 125, 137, 150)
	recipe:SetRecipeItem(21725, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(21559, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddVendor(15909)
	recipe:AddWorldEvent("LUNAR_FESTIVAL")

	-- Small Red Rocket -- 26418
	recipe = AddRecipe(26418, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(125, 125, 125, 137, 150)
	recipe:SetRecipeItem(21726, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(21557, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddVendor(15909)
	recipe:AddWorldEvent("LUNAR_FESTIVAL")

	-- Large Blue Rocket -- 26420
	recipe = AddRecipe(26420, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(175, 175, 175, 187, 200)
	recipe:SetRecipeItem(21727, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(21589, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddVendor(15909)
	recipe:AddWorldEvent("LUNAR_FESTIVAL")

	-- Large Green Rocket -- 26421
	recipe = AddRecipe(26421, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(175, 175, 175, 187, 200)
	recipe:SetRecipeItem(21728, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(21590, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddVendor(15909)
	recipe:AddWorldEvent("LUNAR_FESTIVAL")

	-- Large Red Rocket -- 26422
	recipe = AddRecipe(26422, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(175, 175, 175, 187, 200)
	recipe:SetRecipeItem(21729, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(21592, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddVendor(15909)
	recipe:AddWorldEvent("LUNAR_FESTIVAL")

	-- Blue Rocket Cluster -- 26423
	recipe = AddRecipe(26423, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(225, 225, 225, 237, 250)
	recipe:SetRecipeItem(21730, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(21571, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddVendor(15909)
	recipe:AddWorldEvent("LUNAR_FESTIVAL")

	-- Green Rocket Cluster -- 26424
	recipe = AddRecipe(26424, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(225, 225, 225, 237, 250)
	recipe:SetRecipeItem(21731, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(21574, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddVendor(15909)
	recipe:AddWorldEvent("LUNAR_FESTIVAL")

	-- Red Rocket Cluster -- 26425
	recipe = AddRecipe(26425, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(225, 225, 225, 237, 250)
	recipe:SetRecipeItem(21732, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(21576, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddVendor(15909)
	recipe:AddWorldEvent("LUNAR_FESTIVAL")

	-- Large Blue Rocket Cluster -- 26426
	recipe = AddRecipe(26426, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(275, 275, 275, 280, 285)
	recipe:SetRecipeItem(21733, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(21714, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddVendor(15909)
	recipe:AddWorldEvent("LUNAR_FESTIVAL")

	-- Large Green Rocket Cluster -- 26427
	recipe = AddRecipe(26427, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(275, 275, 275, 280, 285)
	recipe:SetRecipeItem(21734, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(21716, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddVendor(15909)
	recipe:AddWorldEvent("LUNAR_FESTIVAL")

	-- Large Red Rocket Cluster -- 26428
	recipe = AddRecipe(26428, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(275, 275, 275, 280, 285)
	recipe:SetRecipeItem(21735, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(21718, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddVendor(15909)
	recipe:AddWorldEvent("LUNAR_FESTIVAL")

	-- Firework Launcher -- 26442
	recipe = AddRecipe(26442, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(225, 225, 245, 255, 265)
	recipe:SetRecipeItem(44919, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(21569, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddVendor(15909)
	recipe:AddWorldEvent("LUNAR_FESTIVAL")

	-- Cluster Launcher -- 26443
	recipe = AddRecipe(26443, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(275, 275, 295, 305, 315)
	recipe:SetRecipeItem(44918, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(21570, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddVendor(15909)
	recipe:AddWorldEvent("LUNAR_FESTIVAL")

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
	recipe:AddTrainer(1702, 4941, 5174, 5518, 8736, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 25099, 45545, 52636, 52651)

	-- ----------------------------------------------------------------------------
	-- The Burning Crusade.
	-- ----------------------------------------------------------------------------
	-- Elemental Blasting Powder -- 30303
	recipe = AddRecipe(30303, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(23781, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_MATERIALS")
	recipe:AddTrainer(1702, 3494, 5174, 11031, 17634, 17637, 18752, 18775, 19576, 25099, 33611, 33634, 33677)

	-- Fel Iron Casing -- 30304
	recipe = AddRecipe(30304, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(23782, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_MATERIALS")
	recipe:AddTrainer(1702, 3494, 5174, 11031, 17634, 17637, 18752, 18775, 19576, 25099, 33611, 33634, 33677)

	-- Handful of Fel Iron Bolts -- 30305
	recipe = AddRecipe(30305, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(23783, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_MATERIALS")
	recipe:AddTrainer(1702, 3494, 5174, 11031, 17634, 17637, 18752, 18775, 19576, 25099, 33611, 33634, 33677)

	-- Adamantite Frame -- 30306
	recipe = AddRecipe(30306, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(23784, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_MATERIALS")
	recipe:AddTrainer(1702, 3494, 5174, 11031, 17634, 17637, 18752, 18775, 19576, 25099, 33611, 33634, 33677)

	-- Hardened Adamantite Tube -- 30307
	recipe = AddRecipe(30307, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(40, 40, 50, 55, 60)
	recipe:SetCraftedItem(23785, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_MATERIALS")
	recipe:AddTrainer(1702, 3494, 5174, 11031, 17634, 17637, 18752, 18775, 19576, 25099, 33611, 33634, 33677)

	-- Khorium Power Core -- 30308
	recipe = AddRecipe(30308, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(40, 40, 50, 55, 60)
	recipe:SetCraftedItem(23786, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_MATERIALS")
	recipe:AddTrainer(1702, 3494, 5174, 11031, 17634, 17637, 18752, 18775, 19576, 25099, 33611, 33634, 33677)

	-- Felsteel Stabilizer -- 30309
	recipe = AddRecipe(30309, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(40, 40, 50, 55, 60)
	recipe:SetCraftedItem(23787, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_MATERIALS")
	recipe:AddTrainer(1702, 3494, 5174, 11031, 17634, 17637, 18752, 18775, 19576, 25099, 33611, 33634, 33677)

	-- Fel Iron Bomb -- 30310
	recipe = AddRecipe(30310, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(23736, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddTrainer(1702, 3494, 5174, 11031, 17634, 17637, 18752, 18775, 19576, 25099, 33611, 33634, 33677)

	-- Adamantite Grenade -- 30311
	recipe = AddRecipe(30311, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(23737, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddTrainer(1702, 3494, 5174, 11031, 17634, 17637, 18752, 18775, 19576, 25099, 33611, 33634, 33677)

	-- Fel Iron Musket -- 30312
	recipe = AddRecipe(30312, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(20, 20, 30, 35, 40)
	recipe:SetCraftedItem(23742, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_GUN")
	recipe:AddTrainer(1702, 3494, 5174, 11031, 17634, 17637, 18752, 18775, 19576, 25099, 33611, 33634, 33677)

	-- Adamantite Rifle -- 30313
	recipe = AddRecipe(30313, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(350, 350, 360, 370, 380)
	recipe:SetRecipeItem(23799, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(23746, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_GUN")
	recipe:AddLimitedVendor(16657, 1, 16782, 1, 19661, 1, 67976, 1, 90866, 1)

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
	recipe:AddVendor(67976, 90866)
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
	recipe:AddVendor(67976, 90866)
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
	recipe:AddVendor(19351, 67976, 90866)
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
	recipe:AddVendor(67976, 90866)
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
	recipe:AddTrainer(1702, 5174, 8126, 8738, 11031, 17634, 25099, 29513, 33611, 33634, 33677, 86012, 93520)

	-- Super Sapper Charge -- 30560
	recipe = AddRecipe(30560, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(40, 40, 50, 55, 60)
	recipe:SetCraftedItem(23827, "BIND_ON_EQUIP")
	recipe:SetSpecialty(20222)
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddTrainer(1702, 5174, 8126, 8738, 11031, 17634, 25099, 29513, 33611, 33634, 33677, 86012, 93520)

	-- Goblin Rocket Launcher -- 30563
	recipe = AddRecipe(30563, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(23836, "BIND_ON_EQUIP")
	recipe:SetSpecialty(20222)
	recipe:SetItemFilterType("ENGINEERING_TRINKET")
	recipe:AddTrainer(1702, 5174, 8126, 8738, 11031, 17634, 25099, 29513, 33611, 33634, 33677, 86012, 93520)

	-- Foreman's Enchanted Helmet -- 30565
	recipe = AddRecipe(30565, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 85, 90, 95)
	recipe:SetCraftedItem(23838, "BIND_ON_PICKUP")
	recipe:SetSpecialty(20222)
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddFilters(F.CASTER, F.HEALER, F.MAGE, F.PRIEST, F.WARLOCK)
	recipe:AddTrainer(1702, 5174, 8126, 8738, 11031, 17634, 25099, 29513, 33611, 33634, 33677, 86012, 93520)

	-- Foreman's Reinforced Helmet -- 30566
	recipe = AddRecipe(30566, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 85, 90, 95)
	recipe:SetCraftedItem(23839, "BIND_ON_PICKUP")
	recipe:SetSpecialty(20222)
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddFilters(F.HUNTER, F.SHAMAN)
	recipe:AddTrainer(1702, 5174, 8126, 8738, 11031, 17634, 25099, 29513, 33611, 33634, 33677, 86012, 93520)

	-- Gnomish Flame Turret -- 30568
	recipe = AddRecipe(30568, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(23841, "BIND_ON_EQUIP")
	recipe:SetSpecialty(20219)
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddTrainer(1702, 5174, 7406, 7944, 11031, 17634, 25099, 29514, 33611, 33634, 33677, 85918, 92194)

	-- Gnomish Poultryizer -- 30569
	recipe = AddRecipe(30569, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(40, 40, 50, 55, 60)
	recipe:SetCraftedItem(23835, "BIND_ON_EQUIP")
	recipe:SetSpecialty(20219)
	recipe:SetItemFilterType("ENGINEERING_TRINKET")
	recipe:AddTrainer(1702, 5174, 7406, 7944, 11031, 17634, 25099, 29514, 33611, 33634, 33677, 85918, 92194)

	-- Nigh-Invulnerability Belt -- 30570
	recipe = AddRecipe(30570, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(23825, "BIND_ON_EQUIP")
	recipe:SetSpecialty(20219)
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddTrainer(1702, 5174, 7406, 7944, 11031, 17634, 25099, 29514, 33611, 33634, 33677, 85918, 92194)

	-- Gnomish Power Goggles -- 30574
	recipe = AddRecipe(30574, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 85, 90, 95)
	recipe:SetCraftedItem(23828, "BIND_ON_PICKUP")
	recipe:SetSpecialty(20219)
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddFilters(F.CASTER, F.HEALER, F.MAGE, F.PRIEST, F.WARLOCK)
	recipe:AddTrainer(1702, 5174, 7406, 7944, 11031, 17634, 25099, 29514, 33611, 33634, 33677, 85918, 92194)

	-- Gnomish Battle Goggles -- 30575
	recipe = AddRecipe(30575, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 85, 90, 95)
	recipe:SetCraftedItem(23829, "BIND_ON_PICKUP")
	recipe:SetSpecialty(20219)
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddFilters(F.CASTER, F.HEALER, F.DRUID, F.ROGUE, F.MONK)
	recipe:AddTrainer(1702, 5174, 7406, 7944, 11031, 17634, 25099, 29514, 33611, 33634, 33677, 85918, 92194)

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
	recipe:AddTrainer(1702, 3494, 5174, 11031, 17634, 17637, 18752, 18775, 19576, 25099, 33611, 33634, 33677)

	-- Frost Grenade -- 39973
	recipe = AddRecipe(39973, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(35, 35, 45, 50, 55)
	recipe:SetCraftedItem(32413, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddTrainer(1702, 3494, 5174, 11031, 17634, 17637, 18752, 18775, 19576, 25099, 33611, 33634, 33677)

	-- Furious Gizmatic Goggles -- 40274
	recipe = AddRecipe(40274, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(32461, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddFilters(F.CASTER, F.HEALER, F.DK, F.PALADIN, F.WARRIOR)
	recipe:AddTrainer(1702, 5174, 11031, 17634, 17637, 18752, 18775, 19576, 25099, 33611, 33634, 33677)

	-- Gyro-balanced Khorium Destroyer -- 41307
	recipe = AddRecipe(41307, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 85, 90, 95)
	recipe:SetCraftedItem(32756, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_GUN")
	recipe:AddTrainer(1702, 3494, 5174, 11031, 17634, 17637, 18752, 18775, 19576, 25099, 33611, 33634, 33677)

	-- Justicebringer 2000 Specs -- 41311
	recipe = AddRecipe(41311, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(32472, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddFilters(F.CASTER, F.HEALER, F.PALADIN)
	recipe:AddTrainer(1702, 5174, 11031, 17634, 17637, 18752, 18775, 19576, 25099, 33611, 33634, 33677)

	-- Tankatronic Goggles -- 41312
	recipe = AddRecipe(41312, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(32473, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddFilters(F.CASTER, F.HEALER, F.TANK, F.DK, F.PALADIN, F.WARRIOR)
	recipe:AddTrainer(1702, 5174, 11031, 17634, 17637, 18752, 18775, 19576, 25099, 33611, 33634, 33677)

	-- Surestrike Goggles v2.0 -- 41314
	recipe = AddRecipe(41314, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(32474, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddFilters(F.HUNTER, F.SHAMAN)
	recipe:AddTrainer(4941, 17634, 17637, 18752, 18775, 19576, 33611, 33634, 33677)

	-- Gadgetstorm Goggles -- 41315
	recipe = AddRecipe(41315, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(32476, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddFilters(F.CASTER, F.SHAMAN)
	recipe:AddTrainer(4941, 17634, 17637, 18752, 18775, 19576, 33611, 33634, 33677)

	-- Living Replicator Specs -- 41316
	recipe = AddRecipe(41316, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(32475, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddFilters(F.CASTER, F.HEALER, F.SHAMAN)
	recipe:AddTrainer(4941, 17634, 17637, 18752, 18775, 19576, 33611, 33634, 33677)

	-- Deathblow X11 Goggles -- 41317
	recipe = AddRecipe(41317, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(32478, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddFilters(F.DRUID, F.ROGUE, F.MONK)
	recipe:AddTrainer(5174, 17634, 17637, 18752, 18775, 19576, 33611, 33634, 33677, 85918)

	-- Wonderheal XT40 Shades -- 41318
	recipe = AddRecipe(41318, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(32479, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddFilters(F.DRUID)
	recipe:AddTrainer(5174, 17634, 17637, 18752, 18775, 19576, 33611, 33634, 33677, 85918)

	-- Magnified Moon Specs -- 41319
	recipe = AddRecipe(41319, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(32480, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddFilters(F.CASTER, F.HEALER, F.DRUID, F.MONK)
	recipe:AddTrainer(5174, 17634, 17637, 18752, 18775, 19576, 33611, 33634, 33677, 85918)

	-- Destruction Holo-gogs -- 41320
	recipe = AddRecipe(41320, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(32494, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddFilters(F.CASTER, F.HEALER, F.MAGE, F.PRIEST, F.WARLOCK)
	recipe:AddTrainer(3494, 5174, 17634, 17637, 18752, 18775, 19576, 33611, 33634, 33677)

	-- Powerheal 4000 Lens -- 41321
	recipe = AddRecipe(41321, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(32495, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddFilters(F.CASTER, F.HEALER, F.PRIEST)
	recipe:AddTrainer(5174, 17634, 17637, 18752, 18775, 19576, 33611, 33634, 33677)

	-- Flying Machine -- 44155
	recipe = AddRecipe(44155, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(34060, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_MOUNT")
	recipe:AddTrainer(1702, 3494, 5174, 11031, 17634, 17637, 24868, 25099, 33611, 33634, 33677)

	-- Turbo-Charged Flying Machine -- 44157
	recipe = AddRecipe(44157, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 85, 90, 95)
	recipe:SetCraftedItem(34061, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_MOUNT")
	recipe:AddTrainer(1702, 3494, 5174, 11031, 17634, 17637, 24868, 25099, 33611, 33634, 33677)

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
	recipe:AddTrainer(1702, 3494, 5174, 11031, 17637, 25099, 25277, 26907, 26955, 26991, 28697, 33586)

	-- Mark "S" Boomstick -- 54353
	recipe = AddRecipe(54353, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(39688, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_GUN")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(1702, 3494, 5174, 11031, 17637, 25099, 25277, 26907, 26955, 26991, 28697, 33586)

	-- EMP Generator -- 54736
	recipe = AddRecipe(54736, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(15, 15, 25, 30, 35)
	recipe:SetItemFilterType("ENGINEERING_ITEM_ENHANCEMENT")
	recipe:AddTrainer(1702, 3494, 5174, 11031, 17637, 25099, 25277, 26907, 26955, 26991, 28697, 33586)

	-- Frag Belt -- 54793
	recipe = AddRecipe(54793, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(5, 5, 15, 20, 25)
	recipe:SetItemFilterType("ENGINEERING_ITEM_ENHANCEMENT")
	recipe:AddTrainer(1702, 3494, 5174, 11031, 17637, 25099, 25277, 26907, 26955, 26991, 28697, 33586)

	-- Flexweave Underlay -- 55002
	recipe = AddRecipe(55002, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(5, 5, 15, 20, 25)
	recipe:SetItemFilterType("ENGINEERING_ITEM_ENHANCEMENT")
	recipe:AddTrainer(1702, 3494, 5174, 11031, 17637, 25099, 25277, 26907, 26955, 26991, 28697, 33586)

	-- Nitro Boosts -- 55016
	recipe = AddRecipe(55016, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(30, 30, 40, 45, 50)
	recipe:SetItemFilterType("ENGINEERING_ITEM_ENHANCEMENT")
	recipe:AddTrainer(1702, 3494, 5174, 11031, 17637, 25099, 25277, 26907, 26955, 26991, 28697, 33586)

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
	recipe:AddTrainer(1702, 3494, 5174, 11031, 17637, 25099, 25277, 26907, 26955, 26991, 28697, 33586)

	-- Hammer Pick -- 56459
	recipe = AddRecipe(56459, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(40892, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddTrainer(1702, 3494, 5174, 11031, 17637, 25099, 25277, 26907, 26955, 26991, 28697, 33586)

	-- Cobalt Frag Bomb -- 56460
	recipe = AddRecipe(56460, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(40771, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddTrainer(1702, 3494, 5174, 11031, 17637, 25099, 25277, 26907, 26955, 26991, 28697, 33586)

	-- Bladed Pickaxe -- 56461
	recipe = AddRecipe(56461, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(40893, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddTrainer(1702, 3494, 5174, 11031, 17637, 25099, 25277, 26907, 26955, 26991, 28697, 33586)

	-- Gnomish Army Knife -- 56462
	recipe = AddRecipe(56462, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(60, 60, 70, 75, 80)
	recipe:SetCraftedItem(40772, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddTrainer(1702, 3494, 5174, 11031, 17637, 25099, 25277, 26907, 26955, 26991, 28697, 33586)

	-- Explosive Decoy -- 56463
	recipe = AddRecipe(56463, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(40536, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddTrainer(1702, 3494, 5174, 11031, 17637, 25099, 25277, 26907, 26955, 26991, 28697, 33586)

	-- Overcharged Capacitor -- 56464
	recipe = AddRecipe(56464, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(39682, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_MATERIALS")
	recipe:AddTrainer(1702, 3494, 5174, 11031, 17637, 25099, 25277, 26907, 26955, 26991, 28697, 33586)

	-- Mechanized Snow Goggles -- 56465
	recipe = AddRecipe(56465, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(45, 45, 55, 60, 65)
	recipe:SetCraftedItem(41112, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddFilters(F.MAGE, F.PRIEST, F.WARLOCK)
	recipe:AddTrainer(3494, 5174, 17637, 25277, 26907, 26955, 26991, 28697, 33586)

	-- Sonic Booster -- 56466
	recipe = AddRecipe(56466, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(45, 45, 55, 60, 65)
	recipe:SetCraftedItem(40767, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_TRINKET")
	recipe:AddTrainer(1702, 3494, 5174, 11031, 17637, 25099, 25277, 26907, 26955, 26991, 28697, 33586)

	-- Noise Machine -- 56467
	recipe = AddRecipe(56467, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(45, 45, 55, 60, 65)
	recipe:SetCraftedItem(40865, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_TRINKET")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(1702, 3494, 5174, 11031, 17637, 25099, 25277, 26907, 26955, 26991, 28697, 33586)

	-- Box of Bombs -- 56468
	recipe = AddRecipe(56468, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(30, 30, 40, 45, 50)
	recipe:SetCraftedItem(44951, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddTrainer(4941, 5174, 11031, 25099, 25277, 26907, 26955, 26991, 28697, 33586)

	-- Gnomish Lightning Generator -- 56469
	recipe = AddRecipe(56469, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(41121, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_TRINKET")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(1702, 3494, 5174, 11031, 17637, 25099, 25277, 26907, 26955, 26991, 28697, 33586)

	-- Sun Scope -- 56470
	recipe = AddRecipe(56470, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(41146, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(1702, 3494, 5174, 11031, 17637, 25099, 25277, 26907, 26955, 26991, 28697, 33586)

	-- Froststeel Tube -- 56471
	recipe = AddRecipe(56471, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(15, 15, 25, 30, 35)
	recipe:SetCraftedItem(39683, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_MATERIALS")
	recipe:AddTrainer(1702, 3494, 5174, 11031, 17637, 25099, 25277, 26907, 26955, 26991, 28697, 33586)

	-- MOLL-E -- 56472
	recipe = AddRecipe(56472, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(40768, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_TOY")
	recipe:AddTrainer(1702, 3494, 5174, 11031, 17637, 25099, 25277, 26907, 26955, 26991, 28697, 33586)

	-- Gnomish X-Ray Specs -- 56473
	recipe = AddRecipe(56473, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(40895, "BIND_ON_EQUIP")
	recipe:SetSpecialty(20219)
	recipe:SetItemFilterType("ENGINEERING_TOY")
	recipe:AddTrainer(1702, 5174, 11031, 25099, 25277, 26907, 26955, 26991, 28697, 29514, 33586, 85918, 92194)

	-- Healing Injector Kit -- 56476
	recipe = AddRecipe(56476, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(35, 35, 45, 50, 55)
	recipe:SetCraftedItem(37567, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddTrainer(1702, 3494, 5174, 11031, 17637, 25099, 25277, 26907, 26955, 26991, 28697, 33586)

	-- Mana Injector Kit -- 56477
	recipe = AddRecipe(56477, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(40, 40, 50, 55, 60)
	recipe:SetCraftedItem(42546, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddTrainer(1702, 3494, 5174, 11031, 17637, 25099, 25277, 26907, 26955, 26991, 28697, 33586)

	-- Heartseeker Scope -- 56478
	recipe = AddRecipe(56478, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(55, 55, 65, 70, 75)
	recipe:SetCraftedItem(41167, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(1702, 3494, 5174, 11031, 17637, 25099, 25277, 26907, 26955, 26991, 28697, 33586)

	-- Armor Plated Combat Shotgun -- 56479
	recipe = AddRecipe(56479, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 85, 90, 95)
	recipe:SetCraftedItem(41168, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_GUN")
	recipe:AddFilters(F.CASTER, F.HEALER, F.TANK)
	recipe:AddTrainer(1702, 3494, 5174, 11031, 17637, 25099, 25277, 26907, 26955, 26991, 28697, 33586)

	-- Armored Titanium Goggles -- 56480
	recipe = AddRecipe(56480, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(65, 65, 75, 80, 85)
	recipe:SetCraftedItem(42549, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddFilters(F.CASTER, F.HEALER, F.TANK, F.DK, F.PALADIN, F.WARRIOR)
	recipe:AddTrainer(1702, 5174, 11031, 25099, 25277, 26907, 26955, 26991, 28697, 33586)

	-- Weakness Spectralizers -- 56481
	recipe = AddRecipe(56481, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(65, 65, 75, 80, 85)
	recipe:SetCraftedItem(42550, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddFilters(F.DRUID, F.ROGUE, F.MONK)
	recipe:AddTrainer(5174, 25277, 26907, 26955, 26991, 28697, 33586, 85918)

	-- Charged Titanium Specs -- 56483
	recipe = AddRecipe(56483, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(65, 65, 75, 80, 85)
	recipe:SetCraftedItem(42552, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddFilters(F.CASTER, F.HEALER, F.DK, F.PALADIN, F.WARRIOR)
	recipe:AddTrainer(1702, 5174, 11031, 25099, 25277, 26907, 26955, 26991, 28697, 33586)

	-- Visage Liquification Goggles -- 56484
	recipe = AddRecipe(56484, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(65, 65, 75, 80, 85)
	recipe:SetCraftedItem(42553, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddFilters(F.CASTER, F.HEALER, F.MAGE, F.PRIEST, F.WARLOCK)
	recipe:AddTrainer(3494, 5174, 17637, 25277, 26907, 26955, 26991, 28697, 33586)

	-- Greensight Gogs -- 56486
	recipe = AddRecipe(56486, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(65, 65, 75, 80, 85)
	recipe:SetCraftedItem(42554, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddFilters(F.DRUID)
	recipe:AddTrainer(5174, 25277, 26907, 26955, 26991, 28697, 33586, 85918)

	-- Electroflux Sight Enhancers -- 56487
	recipe = AddRecipe(56487, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(65, 65, 75, 80, 85)
	recipe:SetCraftedItem(42555, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddFilters(F.HEALER, F.MONK)
	recipe:AddTrainer(4941, 25277, 26907, 26955, 26991, 28697, 33586)

	-- Global Thermal Sapper Charge -- 56514
	recipe = AddRecipe(56514, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(42641, "BIND_ON_EQUIP")
	recipe:SetSpecialty(20222)
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddTrainer(1702, 5174, 11031, 25099, 25277, 26907, 26955, 26991, 28697, 29513, 33586, 86012, 93520)

	-- Truesight Ice Blinders -- 56574
	recipe = AddRecipe(56574, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(65, 65, 75, 80, 85)
	recipe:SetCraftedItem(42551, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddFilters(F.HUNTER, F.SHAMAN)
	recipe:AddTrainer(4941, 25277, 26907, 26955, 26991, 28697, 33586)

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
	recipe:AddTrainer(1702, 3494, 5174, 11031, 17637, 25099, 25277, 26907, 26955, 26991, 28697, 33586)

	-- Diamond-cut Refractor Scope -- 61471
	recipe = AddRecipe(61471, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(15, 15, 25, 30, 35)
	recipe:SetCraftedItem(44739, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_ITEM_ENHANCEMENT")
	recipe:AddTrainer(1702, 3494, 5174, 11031, 17637, 25099, 25277, 26907, 26955, 26991, 28697, 33586)

	-- Mechanized Snow Goggles -- 61481
	recipe = AddRecipe(61481, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(45, 45, 55, 60, 65)
	recipe:SetCraftedItem(44740, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddFilters(F.DRUID, F.ROGUE, F.MONK)
	recipe:AddTrainer(1702, 5174, 25277, 26907, 26955, 26991, 28697, 33586)

	-- Mechanized Snow Goggles -- 61482
	recipe = AddRecipe(61482, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(45, 45, 55, 60, 65)
	recipe:SetCraftedItem(44741, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddFilters(F.HUNTER, F.SHAMAN)
	recipe:AddTrainer(1702, 5174, 25277, 26907, 26955, 26991, 28697, 33586)

	-- Mechanized Snow Goggles -- 61483
	recipe = AddRecipe(61483, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(45, 45, 55, 60, 65)
	recipe:SetCraftedItem(44742, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddFilters(F.DK, F.PALADIN, F.WARRIOR)
	recipe:AddTrainer(1702, 5174, 11031, 25099, 25277, 26907, 26955, 26991, 28697, 33586)

	-- Unbreakable Healing Amplifiers -- 62271
	recipe = AddRecipe(62271, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(65, 65, 75, 80, 85)
	recipe:SetCraftedItem(44949, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddFilters(F.CASTER, F.HEALER, F.PALADIN)
	recipe:AddTrainer(1702, 5174, 11031, 25099, 25277, 26907, 26955, 26991, 28697, 33586)

	-- High-powered Flashlight -- 63750
	recipe = AddRecipe(63750, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(250, 250, 270, 280, 290)
	recipe:SetCraftedItem(45631, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_TRINKET")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(1676, 1702, 3290, 3494, 4941, 5174, 5518, 8736, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 17637, 25099, 45545, 52636, 52651)

	-- Goblin Beam Welder -- 67326
	recipe = AddRecipe(67326, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(35, 35, 45, 50, 55)
	recipe:SetCraftedItem(47828, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddTrainer(1702, 3494, 5174, 11031, 17637, 25099, 25277, 26907, 26955, 26991, 28697, 33586)

	-- Mind Amplification Dish -- 67839
	recipe = AddRecipe(67839, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(35, 35, 45, 50, 55)
	recipe:SetItemFilterType("ENGINEERING_ITEM_ENHANCEMENT")
	recipe:AddTrainer(1702, 3494, 5174, 11031, 17637, 25099, 25277, 26907, 26955, 26991, 28697, 33586)

	-- Wormhole Generator: Northrend -- 67920
	recipe = AddRecipe(67920, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(60, 60, 70, 75, 80)
	recipe:SetCraftedItem(48933, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_TOY")
	recipe:AddTrainer(1702, 3494, 5174, 11031, 17637, 25099, 25277, 26907, 26955, 26991, 28697, 33586)

	-- Jeeves -- 68067
	recipe = AddRecipe(68067, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(450, 450, 480, 485, 490)
	recipe:SetRecipeItem(49050, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(49040, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddWorldDrop(Z.NORTHREND)

	-- ----------------------------------------------------------------------------
	-- Cataclysm.
	-- ----------------------------------------------------------------------------
	-- Reinforced Bio-Optic Killshades -- 81714
	recipe = AddRecipe(81714, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 85, 90, 95)
	recipe:SetCraftedItem(59359, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddFilters(F.DK, F.PALADIN, F.WARRIOR)
	recipe:AddTrainer(1702, 4941, 5174, 5518, 8736, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 25099, 45545, 52636, 52651)

	-- Specialized Bio-Optic Killshades -- 81715
	recipe = AddRecipe(81715, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 85, 90, 95)
	recipe:SetCraftedItem(59448, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddFilters(F.CASTER, F.HEALER, F.DK, F.PALADIN, F.WARRIOR)
	recipe:AddTrainer(1702, 4941, 5174, 5518, 8736, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 25099, 45545, 52636, 52651)

	-- Deadly Bio-Optic Killshades -- 81716
	recipe = AddRecipe(81716, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 85, 90, 95)
	recipe:SetCraftedItem(59456, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddFilters(F.HUNTER, F.SHAMAN)
	recipe:AddTrainer(4941, 5518, 8736, 11017, 11025, 11037, 16667, 16726, 17222, 45545, 52636, 52651)

	-- Energized Bio-Optic Killshades -- 81720
	recipe = AddRecipe(81720, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 85, 90, 95)
	recipe:SetCraftedItem(59458, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddFilters(F.HEALER, F.MONK)
	recipe:AddTrainer(4941, 5518, 8736, 11017, 11025, 11037, 16667, 16726, 17222, 45545, 52636, 52651)

	-- Agile Bio-Optic Killshades -- 81722
	recipe = AddRecipe(81722, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 85, 90, 95)
	recipe:SetCraftedItem(59455, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddFilters(F.DRUID, F.ROGUE, F.MONK)
	recipe:AddTrainer(4941, 5174, 5518, 8736, 11017, 11025, 11037, 16667, 16726, 17222, 45545, 52636, 52651, 85918)

	-- Camouflage Bio-Optic Killshades -- 81724
	recipe = AddRecipe(81724, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 85, 90, 95)
	recipe:SetCraftedItem(59453, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddFilters(F.CASTER, F.HEALER, F.DRUID)
	recipe:AddTrainer(4941, 5174, 5518, 8736, 11017, 11025, 11037, 16667, 16726, 17222, 45545, 52636, 52651, 85918)

	-- Lightweight Bio-Optic Killshades -- 81725
	recipe = AddRecipe(81725, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 85, 90, 95)
	recipe:SetCraftedItem(59449, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddFilters(F.CASTER, F.HEALER, F.MAGE, F.PRIEST, F.WARLOCK)
	recipe:AddTrainer(3494, 4941, 5174, 5518, 8736, 11017, 11025, 11037, 16667, 16726, 17222, 17637, 45545, 52636, 52651)

	-- Spinal Healing Injector -- 82200
	recipe = AddRecipe(82200, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 1, 13, 25)
	recipe:SetItemFilterType("ENGINEERING_ITEM_ENHANCEMENT")
	recipe:AddDiscovery("ENG_DISC")

	-- Handful of Obsidium Bolts -- 84403
	recipe = AddRecipe(84403, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(60224, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_MATERIALS")
	recipe:AddTrainer(1702, 3494, 4941, 5174, 5518, 8736, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 17637, 25099, 45545, 52636, 52651)

	-- Authentic Jr. Engineer Goggles -- 84406
	recipe = AddRecipe(84406, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(60222, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddTrainer(1702, 3494, 4941, 5174, 5518, 8736, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 17637, 25099, 45545, 52636, 52651)

	-- R19 Threatfinder -- 84408
	recipe = AddRecipe(84408, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(59595, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.CASTER)
	recipe:AddTrainer(1702, 3494, 4941, 5174, 5518, 8736, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 17637, 25099, 45545, 52636, 52651)

	-- Volatile Seaforium Blastpack -- 84409
	recipe = AddRecipe(84409, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(5, 5, 15, 20, 25)
	recipe:SetCraftedItem(60853, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddTrainer(1702, 3494, 4941, 5174, 5518, 8736, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 17637, 25099, 45545, 52636, 52651)

	-- Safety Catch Removal Kit -- 84410
	recipe = AddRecipe(84410, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(59596, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(1702, 3494, 4941, 5174, 5518, 8736, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 17637, 25099, 45545, 52636, 52651)

	-- High-Powered Bolt Gun -- 84411
	recipe = AddRecipe(84411, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(15, 15, 25, 30, 35)
	recipe:SetCraftedItem(60223, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddTrainer(1702, 3494, 4941, 5174, 5518, 8736, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 17637, 25099, 45545, 52636, 52651)

	-- Personal World Destroyer -- 84412
	recipe = AddRecipe(84412, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(59597, "BIND_ON_EQUIP")
	recipe:SetSpecialty(20222)
	recipe:SetItemFilterType("ENGINEERING_PET")
	recipe:AddTrainer(1702, 4941, 5174, 5518, 8736, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 25099, 29513, 45545, 52636, 52651, 86012, 93520)

	-- De-Weaponized Mechanical Companion -- 84413
	recipe = AddRecipe(84413, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(60216, "BIND_ON_EQUIP")
	recipe:SetSpecialty(20219)
	recipe:SetItemFilterType("ENGINEERING_PET")
	recipe:AddTrainer(1702, 4941, 5174, 5518, 7944, 8736, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 25099, 29514, 45545, 52636, 52651, 85918, 92194)

	-- Lure Master Tackle Box -- 84415
	recipe = AddRecipe(84415, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(60218, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_BAG")
	recipe:AddTrainer(1702, 3494, 4941, 5174, 5518, 8736, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 17637, 25099, 45545, 52636, 52651)

	-- Elementium Toolbox -- 84416
	recipe = AddRecipe(84416, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(60217, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_BAG")
	recipe:AddTrainer(1702, 3494, 4941, 5174, 5518, 8736, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 17637, 25099, 45545, 52636, 52651)

	-- Volatile Thunderstick -- 84417
	recipe = AddRecipe(84417, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(45, 45, 55, 60, 65)
	recipe:SetCraftedItem(59599, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_GUN")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(1702, 3494, 4941, 5174, 5518, 8736, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 17637, 25099, 45545, 52636, 52651)

	-- Elementium Dragonling -- 84418
	recipe = AddRecipe(84418, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(60403, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_TRINKET")
	recipe:AddTrainer(1702, 3494, 4941, 5174, 5518, 8736, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 17637, 25099, 45545, 52636, 52651)

	-- Finely-Tuned Throat Needler -- 84420
	recipe = AddRecipe(84420, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(40, 40, 50, 55, 60)
	recipe:SetCraftedItem(59598, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CROSSBOW")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(1702, 3494, 4941, 5174, 5518, 8736, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 17637, 25099, 45545, 52636, 52651)

	-- Loot-a-Rang -- 84421
	recipe = AddRecipe(84421, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(40, 40, 50, 55, 60)
	recipe:SetCraftedItem(60854, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_TOY")
	recipe:AddTrainer(1702, 3494, 4941, 5174, 5518, 8736, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 17637, 25099, 45545, 52636, 52651)

	-- Invisibility Field -- 84424
	recipe = AddRecipe(84424, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 1, 13, 25)
	recipe:SetItemFilterType("ENGINEERING_ITEM_ENHANCEMENT")
	recipe:AddDiscovery("ENG_DISC")

	-- Cardboard Assassin -- 84425
	recipe = AddRecipe(84425, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 1, 13, 25)
	recipe:SetItemFilterType("ENGINEERING_ITEM_ENHANCEMENT")
	recipe:AddDiscovery("ENG_DISC")

	-- Grounded Plasma Shield -- 84427
	recipe = AddRecipe(84427, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 1, 13, 25)
	recipe:SetItemFilterType("ENGINEERING_ITEM_ENHANCEMENT")
	recipe:AddDiscovery("ENG_DISC")

	-- Gnomish X-Ray Scope -- 84428
	recipe = AddRecipe(84428, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(65, 65, 75, 80, 85)
	recipe:SetCraftedItem(59594, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_ITEM_ENHANCEMENT")
	recipe:AddTrainer(1702, 3494, 4941, 5174, 5518, 8736, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 17637, 25099, 45545, 52636, 52651)

	-- Goblin Barbecue -- 84429
	recipe = AddRecipe(84429, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(55, 55, 65, 70, 75)
	recipe:SetCraftedItem(60858, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddTrainer(1702, 3494, 4941, 5174, 5518, 8736, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 17637, 25099, 45545, 52636, 52651)

	-- Heat-Treated Spinning Lure -- 84430
	recipe = AddRecipe(84430, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(60, 60, 70, 75, 80)
	recipe:SetCraftedItem(68049, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddTrainer(1702, 3494, 4941, 5174, 5518, 8736, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 17637, 25099, 45545, 52636, 52651)

	-- Overpowered Chicken Splitter -- 84431
	recipe = AddRecipe(84431, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 85, 90, 95)
	recipe:SetCraftedItem(59364, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_BOW")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(1702, 3494, 4941, 5174, 5518, 8736, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 17637, 25099, 45545, 52636, 52651)

	-- Kickback 5000 -- 84432
	recipe = AddRecipe(84432, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 85, 90, 95)
	recipe:SetCraftedItem(59367, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_GUN")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(1702, 3494, 4941, 5174, 5518, 8736, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 17637, 25099, 45545, 52636, 52651)

	-- Electrified Ether -- 94748
	recipe = AddRecipe(94748, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(67749, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_MATERIALS")
	recipe:AddTrainer(1702, 3494, 4941, 5174, 5518, 8736, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 17637, 25099, 45545, 52636, 52651)

	-- Electrostatic Condenser -- 95703
	recipe = AddRecipe(95703, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(67494, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddTrainer(1702, 3494, 4941, 5174, 5518, 8736, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 17637, 25099, 45545, 52636, 52651)

	-- Gnomish Gravity Well -- 95705
	recipe = AddRecipe(95705, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(40727, "BIND_ON_EQUIP")
	recipe:SetSpecialty(20219)
	recipe:SetItemFilterType("ENGINEERING_TOY")
	recipe:AddTrainer(1702, 4941, 5174, 5518, 7406, 7944, 8736, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 25099, 29514, 45545, 52636, 52651, 85918, 92194)

	-- Big Daddy -- 95707
	recipe = AddRecipe(95707, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(63396, "BIND_ON_EQUIP")
	recipe:SetSpecialty(20222)
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddTrainer(1702, 4941, 5174, 5518, 8126, 8736, 8738, 11017, 11025, 11031, 11037, 16667, 16726, 17222, 25099, 29513, 45545, 52636, 52651, 86012, 93520)

	-- Flintlocke's Woodchucker -- 100587
	recipe = AddRecipe(100587, V.CATA, Q.RARE)
	recipe:SetSkillLevels(515, 515, 525, 530, 535)
	recipe:SetRecipeItem(70177, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(70139, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.HUNTER)
	recipe:AddVendor(53214)

	-- Extreme-Impact Hole Puncher -- 100687
	recipe = AddRecipe(100687, V.CATA, Q.RARE)
	recipe:SetSkillLevels(525, 525, 525, 525, 525)
	recipe:SetRecipeItem(71078, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(71077, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_GUN")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(53214)

	-- ----------------------------------------------------------------------------
	-- Mists of Pandaria.
	-- ----------------------------------------------------------------------------
	-- Watergliding Jets -- 109099
	recipe = AddRecipe(109099, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetItemFilterType("ENGINEERING_ITEM_ENHANCEMENT")
	recipe:AddTrainer(4941, 5174, 11031, 25099, 55143, 64924)

	-- Goblin Glider -- 126392
	recipe = AddRecipe(126392, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetItemFilterType("ENGINEERING_ITEM_ENHANCEMENT")
	recipe:AddTrainer(4941, 5174, 11031, 25099, 55143, 64924)

	-- Ghost Iron Bolts -- 127113
	recipe = AddRecipe(127113, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(77467, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_MATERIALS")
	recipe:AddTrainer(4941, 5174, 11031, 25099, 55143, 64924)

	-- High-Explosive Gunpowder -- 127114
	recipe = AddRecipe(127114, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(77468, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_MATERIALS")
	recipe:AddTrainer(4941, 5174, 11031, 25099, 55143, 64924)

	-- Lord Blastington's Scope of Doom -- 127115
	recipe = AddRecipe(127115, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(35, 35, 45, 50, 55)
	recipe:SetCraftedItem(77529, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_ITEM_ENHANCEMENT")
	recipe:AddTrainer(4941, 5174, 11031, 25099, 55143, 64924)

	-- Mirror Scope -- 127116
	recipe = AddRecipe(127116, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(77531, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(4941, 5174, 11031, 25099, 55143, 64924)

	-- Lightweight Retinal Armor -- 127117
	recipe = AddRecipe(127117, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 85, 90, 95)
	recipe:SetCraftedItem(77533, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddFilters(F.CASTER, F.HEALER, F.MAGE, F.PRIEST, F.WARLOCK)
	recipe:AddTrainer(5174, 55143, 64924)

	-- Agile Retinal Armor -- 127118
	recipe = AddRecipe(127118, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 85, 90, 95)
	recipe:SetCraftedItem(77534, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddFilters(F.DRUID, F.ROGUE, F.MONK)
	recipe:AddTrainer(5174, 55143, 64924, 85918)

	-- Camouflage Retinal Armor -- 127119
	recipe = AddRecipe(127119, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 85, 90, 95)
	recipe:SetCraftedItem(77535, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddFilters(F.CASTER, F.HEALER, F.DRUID)
	recipe:AddTrainer(5174, 55143, 64924, 85918)

	-- Deadly Retinal Armor -- 127120
	recipe = AddRecipe(127120, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 85, 90, 95)
	recipe:SetCraftedItem(77536, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddFilters(F.HUNTER, F.SHAMAN)
	recipe:AddTrainer(4941, 55143, 64924)

	-- Energized Retinal Armor -- 127121
	recipe = AddRecipe(127121, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 85, 90, 95)
	recipe:SetCraftedItem(77537, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddFilters(F.HEALER, F.MONK)
	recipe:AddTrainer(4941, 55143, 64924)

	-- Specialized Retinal Armor -- 127122
	recipe = AddRecipe(127122, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 85, 90, 95)
	recipe:SetCraftedItem(77538, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddFilters(F.CASTER, F.HEALER, F.DK, F.PALADIN, F.WARRIOR)
	recipe:AddTrainer(5518, 11031, 25099, 55143, 64924)

	-- Reinforced Retinal Armor -- 127123
	recipe = AddRecipe(127123, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 85, 90, 95)
	recipe:SetCraftedItem(77539, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddFilters(F.DK, F.PALADIN, F.WARRIOR)
	recipe:AddTrainer(5518, 11031, 25099, 55143, 64924)

	-- Locksmith's Powderkeg -- 127124
	recipe = AddRecipe(127124, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(77532, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddTrainer(4941, 5174, 11031, 25099, 55143, 64924)

	-- G91 Landshark -- 127127
	recipe = AddRecipe(127127, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(77589, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddTrainer(4941, 5174, 11031, 25099, 55143, 64924)

	-- Goblin Dragon Gun, Mark II -- 127128
	recipe = AddRecipe(127128, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(86607, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddTrainer(4941, 5174, 11031, 25099, 55143, 64924)

	-- Blingtron 4000 -- 127129
	recipe = AddRecipe(127129, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 85, 90, 95)
	recipe:SetCraftedItem(87214, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_TOY")
	recipe:AddTrainer(4941, 5174, 11031, 25099, 55143, 64924)

	-- Mist-Piercing Goggles -- 127130
	recipe = AddRecipe(127130, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(87213, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddTrainer(4941, 5174, 11031, 25099, 55143, 64924)

	-- Thermal Anvil -- 127131
	recipe = AddRecipe(127131, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(87216, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddTrainer(4941, 5174, 11031, 25099, 55143, 64924)

	-- Wormhole Generator: Pandaria -- 127132
	recipe = AddRecipe(127132, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(45, 45, 55, 60, 65)
	recipe:SetCraftedItem(87215, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_TOY")
	recipe:AddTrainer(4941, 5174, 11031, 25099, 55143, 64924)

	-- Ghost Iron Dragonling -- 127134
	recipe = AddRecipe(127134, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(77530, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_TRINKET")
	recipe:AddTrainer(4941, 5174, 11031, 25099, 55143, 64924)

	-- Mechanical Pandaren Dragonling -- 127135
	recipe = AddRecipe(127135, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(87526, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_PET")
	recipe:AddTrainer(4941, 5174, 11031, 25099, 55143, 64924)

	-- Big Game Hunter -- 127136
	recipe = AddRecipe(127136, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(77527, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_GUN")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(4941, 5174, 11031, 25099, 55143, 64924)

	-- Long-Range Trillium Sniper -- 127137
	recipe = AddRecipe(127137, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(40, 40, 50, 55, 60)
	recipe:SetCraftedItem(77528, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_GUN")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(4941, 5174, 11031, 25099, 55143, 64924)

	-- Depleted-Kyparium Rocket -- 127138
	recipe = AddRecipe(127138, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 85, 90, 95)
	recipe:SetCraftedItem(87250, "BIND_ON_EQUIP")
	recipe:SetSpecialty(20222)
	recipe:SetItemFilterType("ENGINEERING_MOUNT")
	recipe:AddTrainer(4941, 5174, 11031, 25099, 29513, 55143, 64924, 86012, 93520)

	-- Geosynchronous World Spinner -- 127139
	recipe = AddRecipe(127139, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 85, 90, 95)
	recipe:SetCraftedItem(87251, "BIND_ON_EQUIP")
	recipe:SetSpecialty(20219)
	recipe:SetItemFilterType("ENGINEERING_MOUNT")
	recipe:AddTrainer(4941, 5174, 11031, 25099, 29514, 55143, 64924, 85918, 92194)

	-- Celestial Firework -- 128260
	recipe = AddRecipe(128260, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(500, 500, 525, 537, 550)
	recipe:SetCraftedItem(89493, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddDiscovery("ENG_DISC_FIREWORKS")

	-- Grand Celebration Firework -- 128261
	recipe = AddRecipe(128261, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(500, 500, 525, 537, 550)
	recipe:SetCraftedItem(89491, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddDiscovery("ENG_DISC_FIREWORKS")

	-- Serpent's Heart Firework -- 128262
	recipe = AddRecipe(128262, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(500, 500, 525, 537, 550)
	recipe:SetCraftedItem(87764, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddDiscovery("ENG_DISC_FIREWORKS")

	-- Flashing Tinker's Gear -- 131211
	recipe = AddRecipe(131211, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(77544, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddFilters(F.TANK)
	recipe:AddTrainer(4941, 5174, 11031, 25099, 55143, 64924)

	-- Fractured Tinker's Gear -- 131212
	recipe = AddRecipe(131212, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(77547, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddTrainer(4941, 5174, 11031, 25099, 55143, 64924)

	-- Precise Tinker's Gear -- 131213
	recipe = AddRecipe(131213, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(77543, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(4941, 5174, 11031, 25099, 55143, 64924)

	-- Quick Tinker's Gear -- 131214
	recipe = AddRecipe(131214, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(77542, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(4941, 5174, 11031, 25099, 55143, 64924)

	-- Rigid Tinker's Gear -- 131215
	recipe = AddRecipe(131215, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(77545, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(4941, 5174, 11031, 25099, 55143, 64924)

	-- Smooth Tinker's Gear -- 131216
	recipe = AddRecipe(131216, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(77541, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(4941, 5174, 11031, 25099, 55143, 64924)

	-- Sparkling Tinker's Gear -- 131217
	recipe = AddRecipe(131217, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(77546, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(4941, 5174, 11031, 25099, 55143, 64924)

	-- Subtle Tinker's Gear -- 131218
	recipe = AddRecipe(131218, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(77540, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddFilters(F.TANK)
	recipe:AddTrainer(4941, 5174, 11031, 25099, 55143, 64924)

	-- Autumn Flower Firework -- 131256
	recipe = AddRecipe(131256, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(500, 500, 525, 537, 550)
	recipe:SetCraftedItem(89893, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddDiscovery("ENG_DISC_FIREWORKS")

	-- Jade Blossom Firework -- 131258
	recipe = AddRecipe(131258, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(500, 500, 525, 537, 550)
	recipe:SetCraftedItem(89888, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddDiscovery("ENG_DISC_FIREWORKS")

	-- Pandaria Fireworks -- 131353
	recipe = AddRecipe(131353, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(89991, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddTrainer(4941, 5174, 11031, 25099, 55143, 64924)

	-- Tinker's Kit -- 131563
	recipe = AddRecipe(131563, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(90146, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddTrainer(4941, 5174, 11031, 25099, 55143, 64924)

	-- Jard's Peculiar Energy Source -- 139176
	recipe = AddRecipe(139176, V.MOP, Q.RARE)
	recipe:SetSkillLevels(500, 500, 605, 610, 615)
	recipe:SetRecipeItem(100910, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(94113, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_MATERIALS")
	recipe:AddWorldDrop(Z.PANDARIA)

	-- Sky Golem -- 139192
	recipe = AddRecipe(139192, V.MOP, Q.RARE)
	recipe:SetSkillLevels(500, 500, 605, 610, 615)
	recipe:SetRecipeItem(100910, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(95416, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_MOUNT")
	recipe:AddWorldDrop(Z.PANDARIA)

	-- Pierre -- 139196
	recipe = AddRecipe(139196, V.MOP, Q.RARE)
	recipe:SetSkillLevels(500, 500, 605, 610, 615)
	recipe:SetRecipeItem(100910, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(94903, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_PET")
	recipe:AddWorldDrop(Z.PANDARIA)

	-- Advanced Refrigeration Unit -- 139197
	recipe = AddRecipe(139197, V.MOP, Q.RARE)
	recipe:SetSkillLevels(500, 500, 600, 602, 605)
	recipe:SetRecipeItem(100910, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(92747, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_BAG")
	recipe:AddWorldDrop(Z.PANDARIA)

	-- Rascal-Bot -- 143714
	recipe = AddRecipe(143714, V.MOP, Q.RARE)
	recipe:SetSkillLevels(500, 500, 605, 610, 615)
	recipe:SetRecipeItem(100910, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(100905, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_PET")
	recipe:AddWorldDrop(Z.PANDARIA)

	-- ----------------------------------------------------------------------------
	-- Warlords of Draenor.
	-- ----------------------------------------------------------------------------
	-- Cybergenetic Mechshades -- 162195
	recipe = AddRecipe(162195, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 702, 705)
	recipe:SetRecipeItem(118497, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(109173, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddFilters(F.CASTER, F.HEALER, F.HUNTER, F.SHAMAN)
	recipe:AddVendor(77365, 79826, 87065, 87552)

	-- Night-Vision Mechshades -- 162196
	recipe = AddRecipe(162196, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 702, 705)
	recipe:SetRecipeItem(118498, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(109171, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(77365, 79826, 87065, 87552)

	-- Plasma Mechshades -- 162197
	recipe = AddRecipe(162197, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 702, 705)
	recipe:SetRecipeItem(118499, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(109172, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(77365, 79826, 87065, 87552)

	-- Razorguard Mechshades -- 162198
	recipe = AddRecipe(162198, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 702, 705)
	recipe:SetRecipeItem(118500, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(109174, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(77365, 79826, 87065, 87552)

	-- Shrediron's Shredder -- 162199
	recipe = AddRecipe(162199, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 702, 705)
	recipe:SetRecipeItem(118476, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(109168, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_GUN")
	recipe:AddVendor(77365, 79826, 87065, 87552)

	-- Oglethorpe's Missile Splitter -- 162202
	recipe = AddRecipe(162202, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 702, 705)
	recipe:SetRecipeItem(118477, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(109120, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_ITEM_ENHANCEMENT")
	recipe:AddVendor(77365, 79826, 87065, 87552)

	-- Megawatt Filament -- 162203
	recipe = AddRecipe(162203, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 702, 705)
	recipe:SetRecipeItem(118478, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(109122, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(77365, 79826, 87065, 87552)

	-- Goblin Glider Kit -- 162204
	recipe = AddRecipe(162204, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 625, 627, 630)
	recipe:SetCraftedItem(109076, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddCustom("DRAENOR_DEFAULT")

	-- Findle's Loot-a-Rang -- 162205
	recipe = AddRecipe(162205, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 702, 705)
	recipe:SetRecipeItem(118480, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(109167, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_TOY")
	recipe:AddVendor(77365, 79826, 87065, 87552)

	-- World Shrinker -- 162206
	recipe = AddRecipe(162206, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 702, 705)
	recipe:SetRecipeItem(118481, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(109183, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_TOY")
	recipe:AddVendor(77365, 79826, 87065, 87552)

	-- Stealthman 54 -- 162207
	recipe = AddRecipe(162207, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 25, 27, 30)
	recipe:SetCraftedItem(109184, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddCustom("DRAENOR_DEFAULT")

	-- Ultimate Gnomish Army Knife -- 162208
	recipe = AddRecipe(162208, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 100, 100, 100)
	recipe:SetCraftedItem(109253, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddDiscovery("DISCOVERY_ENG_ULT")

	-- Mechanical Axebeak -- 162209
	recipe = AddRecipe(162209, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 702, 705)
	recipe:SetRecipeItem(118484, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(111402, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_PET")
	recipe:AddVendor(77365, 79826, 87065, 87552)

	-- Lifelike Mechanical Frostboar -- 162210
	recipe = AddRecipe(162210, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 702, 705)
	recipe:SetRecipeItem(118485, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(112057, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_PET")
	recipe:AddVendor(77365, 79826, 87065, 87552)

	-- Personal Hologram -- 162214
	recipe = AddRecipe(162214, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 702, 705)
	recipe:SetRecipeItem(118487, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(108745, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_TOY")
	recipe:AddVendor(77365, 79826, 87065, 87552)

	-- Wormhole Centrifuge -- 162216
	recipe = AddRecipe(162216, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 702, 705)
	recipe:SetRecipeItem(118488, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(112059, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_TOY")
	recipe:AddVendor(77365, 79826, 87065, 87552)

	-- Swapblaster -- 162217
	recipe = AddRecipe(162217, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 702, 705)
	recipe:SetRecipeItem(118489, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(111820, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddVendor(77365, 79826, 87065, 87552)

	-- Blingtron 5000 -- 162218
	recipe = AddRecipe(162218, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 702, 705)
	recipe:SetRecipeItem(118490, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(111821, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_TOY")
	recipe:AddVendor(77365, 79826, 87065, 87552)

	-- Didi's Delicate Assembly -- 169078
	recipe = AddRecipe(169078, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 702, 705)
	recipe:SetRecipeItem(118493, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(114056, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_ITEM_ENHANCEMENT")
	recipe:AddVendor(77365, 79826, 87065, 87552)

	-- Gearspring Parts -- 169080
	recipe = AddRecipe(169080, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 1, 50, 100)
	recipe:SetCraftedItem(111366, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_MATERIALS")
	recipe:AddCustom("DRAENOR_DEFAULT")

	-- Ultimate Gnomish Army Knife -- 169140
	recipe = AddRecipe(169140, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 100, 100, 100)
	recipe:SetCraftedItem(111366, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddCustom("DRAENOR_DEFAULT")

	-- Alliance Firework -- 171072
	recipe = AddRecipe(171072, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(500, 500, 525, 537, 550)
	recipe:SetRecipeItem(116142, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(116147, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddVendor(15909)
	recipe:AddWorldEvent("LUNAR_FESTIVAL")

	-- Horde Firework -- 171073
	recipe = AddRecipe(171073, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(500, 500, 525, 537, 550)
	recipe:SetRecipeItem(116144, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(116148, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddVendor(15909)
	recipe:AddWorldEvent("LUNAR_FESTIVAL")

	-- Snake Firework -- 171074
	recipe = AddRecipe(171074, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(500, 500, 525, 537, 550)
	recipe:SetRecipeItem(116146, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(116149, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddVendor(15909)
	recipe:AddWorldEvent("LUNAR_FESTIVAL")

	-- Hemet's Heartseeker -- 173289
	recipe = AddRecipe(173289, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 700, 700)
	recipe:SetRecipeItem(118495, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(118008, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_ITEM_ENHANCEMENT")
	recipe:AddVendor(77365, 79826, 87065, 87552)

	-- Mecha-Blast Rocket -- 173308
	recipe = AddRecipe(173308, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 625, 627, 630)
	recipe:SetCraftedItem(118007, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddCustom("DRAENOR_DEFAULT")

	-- Shieldtronic Shield -- 173309
	recipe = AddRecipe(173309, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 625, 627, 630)
	recipe:SetCraftedItem(118006, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddCustom("DRAENOR_DEFAULT")

	-- Mechanical Scorpid -- 176732
	recipe = AddRecipe(176732, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 700, 700)
	recipe:SetRecipeItem(119177, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(118741, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_PET")
	recipe:AddVendor(77365, 79826, 87065, 87552)

	-- Secrets of Draenor Engineering -- 177054
	recipe = AddRecipe(177054, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 600, 650, 700)
	recipe:SetCraftedItem(119299, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddCustom("DRAENOR_DEFAULT")

	-- Primal Welding -- 182120
	recipe = AddRecipe(182120, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 702, 705)
	recipe:SetRecipeItem(122712, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(111366, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_MATERIALS")
	recipe:AddVendor(90894, 91030)

	-- ----------------------------------------------------------------------------
	-- Legion.
	-- ----------------------------------------------------------------------------
	-- Blink-Trigger Headgun -- 198939
	recipe = AddRecipe(198939, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 710, 720)
	recipe:SetCraftedItem(132500, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddQuest(40859)

	-- Tactical Headgun -- 198965
	recipe = AddRecipe(198965, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 710, 720)
	recipe:SetCraftedItem(132501, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddQuest(40859)

	-- Bolt-Action Headgun -- 198966
	recipe = AddRecipe(198966, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 710, 720)
	recipe:SetCraftedItem(132502, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddQuest(40859)

	-- Reinforced Headgun -- 198967
	recipe = AddRecipe(198967, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 710, 720)
	recipe:SetCraftedItem(132503, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddQuest(40859)

	-- Semi-Automagic Cranial Cannon -- 198968
	recipe = AddRecipe(198968, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 740, 750, 760)
	recipe:SetRecipeItem(133671, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(132504, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddVendor(93539)

	-- Sawed-Off Cranial Cannon -- 198969
	recipe = AddRecipe(198969, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 740, 750, 760)
	recipe:SetRecipeItem(133672, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(132505, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddVendor(93539)

	-- Double-Barreled Cranial Cannon -- 198970
	recipe = AddRecipe(198970, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(60, 60, 60, 70, 70)
	recipe:SetRecipeItem(133673, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(132506, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddVendor(93539)

	-- Ironsight Cranial Cannon -- 198971
	recipe = AddRecipe(198971, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 740, 750, 760)
	recipe:SetRecipeItem(133674, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(132507, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddVendor(93539)

	-- Deployable Bullet Dispenser -- 198972
	recipe = AddRecipe(198972, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 720, 730, 740)
	recipe:SetCraftedItem(132509, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddQuest(40861)

	-- Gunpowder Charge -- 198973
	recipe = AddRecipe(198973, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 720, 730, 740)
	recipe:SetCraftedItem(132510, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddQuest(40862)

	-- Pump-Action Bandage Gun -- 198974
	recipe = AddRecipe(198974, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 720, 730, 740)
	recipe:SetCraftedItem(132511, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddQuest(40869)

	-- Gunpack -- 198975
	recipe = AddRecipe(198975, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 720, 730, 740)
	recipe:SetCraftedItem(132513, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddQuest(40873)

	-- Auto-Hammer -- 198976
	recipe = AddRecipe(198976, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 720, 730, 740)
	recipe:SetCraftedItem(132514, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddQuest(40858)

	-- Failure Detection Pylon -- 198977
	recipe = AddRecipe(198977, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 720, 730, 740)
	recipe:SetCraftedItem(132515, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddQuest(40875)

	-- Gunshoes -- 198978
	recipe = AddRecipe(198978, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 720, 730, 740)
	recipe:SetCraftedItem(132516, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddQuest(40872)

	-- Intra-Dalaran Wormhole Generator -- 198979
	recipe = AddRecipe(198979, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 720, 730, 740)
	recipe:SetRecipeItem(137691, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(132517, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddQuest(40868)
	recipe:AddVendor(93539)

	-- Blingtron's Circuit Design Tutorial -- 198980
	recipe = AddRecipe(198980, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 730, 760)
	recipe:SetRecipeItem(137692, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(132518, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_PET")
	recipe:AddQuest(40880)

	-- Trigger -- 198981
	recipe = AddRecipe(198981, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 720, 740)
	recipe:SetCraftedItem(132519, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_PET")
	recipe:AddQuest(40877)

	-- Reaves Battery -- 198982
	recipe = AddRecipe(198982, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 710, 720)
	recipe:SetCraftedItem(132523, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddQuest(40863)

	-- Reaves Module: Wormhole Generator Mode -- 198983
	recipe = AddRecipe(198983, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 720, 740)
	recipe:SetCraftedItem(132524, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddQuest(40878)

	-- Reaves Module: Repair Mode -- 198984
	recipe = AddRecipe(198984, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 720, 740)
	recipe:SetCraftedItem(132525, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddQuest(40864)

	-- Reaves Module: Failure Detection Mode -- 198985
	recipe = AddRecipe(198985, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 720, 740)
	recipe:SetCraftedItem(132526, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddQuest(40878)

	-- Reaves Module: Fireworks Display Mode -- 198987
	recipe = AddRecipe(198987, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 720, 740)
	recipe:SetCraftedItem(132528, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddQuest(40870)

	-- Reaves Module: Snack Distribution Mode -- 198988
	recipe = AddRecipe(198988, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 720, 740)
	recipe:SetCraftedItem(132529, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddQuest(40864)

	-- Reaves Module: Bling Mode -- 198989
	recipe = AddRecipe(198989, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 800, 800, 800)
	recipe:SetCraftedItem(132530, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddQuest(40881)

	-- Reaves Module: Piloted Combat Mode -- 198990
	recipe = AddRecipe(198990, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 720, 740)
	recipe:SetCraftedItem(132531, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddQuest(40879)

	-- Blink-Trigger Headgun -- 198991
	recipe = AddRecipe(198991, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 720, 730, 740)
	recipe:SetRecipeItem(137697, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(132500, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddQuest(40876)

	-- Tactical Headgun -- 198992
	recipe = AddRecipe(198992, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 720, 730, 740)
	recipe:SetRecipeItem(137698, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(132501, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddQuest(40876)

	-- Bolt-Action Headgun -- 198993
	recipe = AddRecipe(198993, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 720, 730, 740)
	recipe:SetRecipeItem(137699, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(132502, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddQuest(40876)

	-- Reinforced Headgun -- 198994
	recipe = AddRecipe(198994, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 720, 730, 740)
	recipe:SetRecipeItem(137700, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(132503, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddQuest(40876)

	-- Semi-Automagic Cranial Cannon -- 198995
	recipe = AddRecipe(198995, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 746, 770, 780)
	recipe:SetRecipeItem(137701, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(132504, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddVendor(102196)

	-- Sawed-Off Cranial Cannon -- 198996
	recipe = AddRecipe(198996, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 746, 770, 780)
	recipe:SetRecipeItem(137702, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(132505, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddVendor(102196)

	-- Double-Barreled Cranial Cannon -- 198997
	recipe = AddRecipe(198997, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 100, 100, 100)
	recipe:SetRecipeItem(137703, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(132506, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddVendor(102196)

	-- Ironsight Cranial Cannon -- 198998
	recipe = AddRecipe(198998, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 746, 770, 780)
	recipe:SetRecipeItem(137704, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(132507, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddVendor(102196)

	-- Deployable Bullet Dispenser -- 198999
	recipe = AddRecipe(198999, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 740, 750, 760)
	recipe:SetRecipeItem(137705, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(132509, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddVendor(93539)

	-- Gunpowder Charge -- 199000
	recipe = AddRecipe(199000, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 740, 750, 760)
	recipe:SetRecipeItem(137706, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(132510, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddVendor(97366)

	-- Pump-Action Bandage Gun -- 199001
	recipe = AddRecipe(199001, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 740, 750, 760)
	recipe:SetRecipeItem(137707, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(132511, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddVendor(93539)

	-- Gunpack -- 199002
	recipe = AddRecipe(199002, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 740, 750, 760)
	recipe:SetRecipeItem(137708, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(132513, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddVendor(93539)

	-- Auto-Hammer -- 199003
	recipe = AddRecipe(199003, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 740, 750, 760)
	recipe:SetRecipeItem(137709, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(132514, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddVendor(93539)

	-- Failure Detection Pylon -- 199004
	recipe = AddRecipe(199004, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 740, 750, 760)
	recipe:SetRecipeItem(137710, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(132515, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddVendor(93539)

	-- Blink-Trigger Headgun -- 199005
	recipe = AddRecipe(199005, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 740, 750, 760)
	recipe:SetRecipeItem(137711, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(132500, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddQuest(41675)

	-- Tactical Headgun -- 199006
	recipe = AddRecipe(199006, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 740, 750, 760)
	recipe:SetRecipeItem(137712, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(132501, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddMobDrop(98208)

	-- Bolt-Action Headgun -- 199007
	recipe = AddRecipe(199007, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 740, 750, 760)
	recipe:SetRecipeItem(137713, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(132502, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddRepVendor(FAC.THE_WARDENS, REP.HONORED, 107379)

	-- Reinforced Headgun -- 199008
	recipe = AddRecipe(199008, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 740, 750, 760)
	recipe:SetRecipeItem(137714, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(132503, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddRepVendor(FAC.THE_WARDENS, REP.HONORED, 107379)

	-- Semi-Automagic Cranial Cannon -- 199009
	recipe = AddRecipe(199009, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 780, 790, 800)
	recipe:SetRecipeItem(137715, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(132504, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddRepVendor(FAC.THE_WARDENS, REP.EXALTED, 107379)

	-- Sawed-Off Cranial Cannon -- 199010
	recipe = AddRecipe(199010, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 780, 790, 800)
	recipe:SetRecipeItem(137716, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(132505, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddRepVendor(FAC.THE_WARDENS, REP.EXALTED, 107379)

	-- Double-Barreled Cranial Cannon -- 199011
	recipe = AddRecipe(199011, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 90, 95, 100)
	recipe:SetRecipeItem(137717, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(132506, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddWorldDrop(Z.BROKEN_ISLES)

	-- Ironsight Cranial Cannon -- 199012
	recipe = AddRecipe(199012, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 780, 790, 800)
	recipe:SetRecipeItem(137718, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(132507, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddCustom("WITHERED_ARMY")

	-- Deployable Bullet Dispenser -- 199013
	recipe = AddRecipe(199013, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 760, 770, 780)
	recipe:SetRecipeItem(137719, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(132509, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddQuest(41679)

	-- Gunpowder Charge -- 199014
	recipe = AddRecipe(199014, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 760, 770, 780)
	recipe:SetRecipeItem(137720, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(132510, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddVendor(97366)

	-- Pump-Action Bandage Gun -- 199015
	recipe = AddRecipe(199015, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 760, 770, 780)
	recipe:SetRecipeItem(137721, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(132511, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddQuest(41676)

	-- Gunpack -- 199016
	recipe = AddRecipe(199016, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 760, 770, 780)
	recipe:SetRecipeItem(137722, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(132513, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddQuest(41678)

	-- Auto-Hammer -- 199017
	recipe = AddRecipe(199017, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 760, 770, 780)
	recipe:SetRecipeItem(137723, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(132514, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddQuest(41677)

	-- Failure Detection Pylon -- 199018
	recipe = AddRecipe(199018, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 760, 770, 780)
	recipe:SetRecipeItem(137724, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(132515, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddQuest(41680)

	-- Sonic Environment Enhancer -- 200466
	recipe = AddRecipe(200466, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 720, 730, 740)
	recipe:SetRecipeItem(137725, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(132982, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddQuest(40866)

	-- "The Felic" -- 209501
	recipe = AddRecipe(209501, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 730, 740, 750)
	recipe:SetRecipeItem(136700, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(136687, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_RELIC")
	recipe:AddWorldDrop(Z.THE_VIOLET_HOLD)

	-- Shockinator -- 209502
	recipe = AddRecipe(209502, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 730, 740, 750)
	recipe:SetRecipeItem(136701, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(136688, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_RELIC")
	recipe:AddWorldDrop(Z.BROKEN_ISLES)

	-- Leystone Buoy -- 209645
	recipe = AddRecipe(209645, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 720, 730, 740)
	recipe:SetRecipeItem(137726, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(136606, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddWorldDrop(Z.BROKEN_ISLES)

	-- Mecha-Bond Imprint Matrix -- 209646
	recipe = AddRecipe(209646, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 720, 730, 740)
	recipe:SetRecipeItem(137727, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(134125, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddVendor(107109)

	-- Tailored Skullblasters -- 235753
	recipe = AddRecipe(235753, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 800, 800, 800)
	recipe:SetRecipeItem(144335, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(144331, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddCustom("BOON_OF_THE_BUILDER")

	-- Rugged Skullblasters -- 235754
	recipe = AddRecipe(235754, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 800, 800, 800)
	recipe:SetRecipeItem(144336, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(144332, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddCustom("BOON_OF_THE_BUILDER")

	-- Chain Skullblasters -- 235755
	recipe = AddRecipe(235755, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 800, 800, 800)
	recipe:SetRecipeItem(144337, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(144333, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddCustom("BOON_OF_THE_BUILDER")

	-- Heavy Skullblasters -- 235756
	recipe = AddRecipe(235756, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 800, 800, 800)
	recipe:SetRecipeItem(144338, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(144334, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddCustom("BOON_OF_THE_BUILDER")

	-- Rechargeable Reaves Battery -- 235775
	recipe = AddRecipe(235775, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 740, 780)
	recipe:SetRecipeItem(144343, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(144341, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddQuest(46128)

	-- Gravitational Reduction Slippers -- 247717
	recipe = AddRecipe(247717, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 720, 740, 760)
	recipe:SetRecipeItem(151714, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(151651, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddQuest(48056)

	-- Wormhole Generator: Argus -- 247744
	recipe = AddRecipe(247744, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 775, 787, 800)
	recipe:SetRecipeItem(151717, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(151652, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_TOY")
	recipe:AddQuest(48065)

	-- ----------------------------------------------------------------------------
	-- Battle for Azeroth.
	-- ----------------------------------------------------------------------------
	-- Magnetic Discombobulator -- 253122
	recipe = AddRecipe(253122, V.BFA, Q.RARE)
	recipe:SetSkillLevels(1, 1, 25, 60, 95)
	recipe:SetCraftedItem(152830, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_ONE_HAND_MACE")
	recipe:AddCustom("DEFAULT_RECIPE")

	-- Precision Attitude Adjuster -- 253150
	recipe = AddRecipe(253150, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 110, 115, 120)
	recipe:SetCraftedItem(152837, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_ONE_HAND_MACE")
	recipe:AddTrainer(131840, 136059, 150630, 150631, 153817, 154321)

	-- Precision Attitude Adjuster -- 253151
	recipe = AddRecipe(253151, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(110, 110, 120, 125, 130)
	recipe:SetCraftedItem(152837, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_ONE_HAND_MACE")
	recipe:AddTrainer(131840, 136059, 150630, 150631, 153817, 154321)

	-- Precision Attitude Adjuster -- 253152
	recipe = AddRecipe(253152, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(110, 110, 145, 147, 150)
	recipe:SetRecipeItem(162345, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(152837, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_ONE_HAND_MACE")
	recipe:AddRepVendor(FAC.SEVENTH_LEGION, REP.REVERED, 135446)
	recipe:AddRepVendor(FAC.THE_HONORBOUND, REP.REVERED, 135447)

	-- F.R.I.E.D. -- 255392
	recipe = AddRecipe(255392, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 25, 37, 50)
	recipe:SetCraftedItem(153490, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddCustom("DEFAULT_RECIPE")

	-- F.R.I.E.D. -- 255393
	recipe = AddRecipe(255393, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(35, 35, 45, 50, 55)
	recipe:SetCraftedItem(153490, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddTrainer(131840, 136059, 150630, 150631, 153817, 154321)

	-- F.R.I.E.D. -- 255394
	recipe = AddRecipe(255394, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(35, 35, 75, 87, 100)
	recipe:SetRecipeItem(162331, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(153490, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddQuest(52365, 52371)

	-- Thermo-Accelerated Plague Spreader -- 255395
	recipe = AddRecipe(255395, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(153494, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddTrainer(131840, 136059, 150630, 150631, 153817, 154321)

	-- Thermo-Accelerated Plague Spreader -- 255396
	recipe = AddRecipe(255396, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(35, 35, 45, 50, 55)
	recipe:SetCraftedItem(153494, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddTrainer(131840, 136059, 150630, 150631, 153817, 154321)

	-- Thermo-Accelerated Plague Spreader -- 255397
	recipe = AddRecipe(255397, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(35, 35, 75, 87, 100)
	recipe:SetCraftedItem(153494, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddQuest(52364, 52370)

	-- Organic Discombobulation Grenade -- 255407
	recipe = AddRecipe(255407, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(153487, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddTrainer(131840, 136059, 150630, 150631, 153817, 154321)

	-- Organic Discombobulation Grenade -- 255408
	recipe = AddRecipe(255408, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(35, 35, 45, 50, 55)
	recipe:SetCraftedItem(153487, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddTrainer(131840, 136059, 150630, 150631, 153817, 154321)

	-- Organic Discombobulation Grenade -- 255409
	recipe = AddRecipe(255409, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(35, 35, 75, 87, 100)
	recipe:SetRecipeItem(162337, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(153487, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddRepVendor(FAC.ZANDALARI_EMPIRE, REP.REVERED, 131287)
	recipe:AddRepVendor(FAC.STORMS_WAKE, REP.REVERED, 135800)

	-- Finely-Tuned Stormsteel Destroyer -- 255457
	recipe = AddRecipe(255457, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 110, 115, 120)
	recipe:SetCraftedItem(153506, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_GUN")
	recipe:AddTrainer(131840, 136059, 150630, 150631, 153817, 154321)

	-- Finely-Tuned Stormsteel Destroyer -- 255458
	recipe = AddRecipe(255458, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(110, 110, 120, 125, 130)
	recipe:SetCraftedItem(153506, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_GUN")
	recipe:AddTrainer(131840, 136059, 150630, 150631, 153817, 154321)

	-- Finely-Tuned Stormsteel Destroyer -- 255459
	recipe = AddRecipe(255459, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(110, 110, 145, 147, 150)
	recipe:SetRecipeItem(162346, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(153506, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_GUN")
	recipe:AddRepVendor(FAC.SEVENTH_LEGION, REP.REVERED, 135446)
	recipe:AddRepVendor(FAC.THE_HONORBOUND, REP.REVERED, 135447)

	-- Belt Enchant: Holographic Horror Projector -- 255936
	recipe = AddRecipe(255936, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(85, 85, 95, 100, 105)
	recipe:SetCraftedItem(153591, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_ITEM_ENHANCEMENT")
	recipe:AddTrainer(131840, 136059, 150630, 150631, 153817, 154321)

	-- Belt Enchant: Personal Space Amplifier -- 255940
	recipe = AddRecipe(255940, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(85, 85, 95, 100, 105)
	recipe:SetCraftedItem(153591, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_ITEM_ENHANCEMENT")
	recipe:AddTrainer(131840, 136059, 150630, 150631, 153817, 154321)

	-- Electroshock Mount Motivator -- 256070
	recipe = AddRecipe(256070, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(153573, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddTrainer(131840, 136059, 150630, 150631, 153817, 154321)

	-- Electroshock Mount Motivator -- 256071
	recipe = AddRecipe(256071, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(153573, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddTrainer(131840, 136059, 150630, 150631, 153817, 154321)

	-- Electroshock Mount Motivator -- 256072
	recipe = AddRecipe(256072, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 95, 110, 125)
	recipe:SetCraftedItem(153573, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddQuest(52367, 52373)

	-- XA-1000 Surface Skimmer -- 256073
	recipe = AddRecipe(256073, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(153512, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddTrainer(131840, 136059, 150630, 150631, 153817, 154321)

	-- XA-1000 Surface Skimmer -- 256074
	recipe = AddRecipe(256074, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(153512, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddTrainer(131840, 136059, 150630, 150631, 153817, 154321)

	-- XA-1000 Surface Skimmer -- 256075
	recipe = AddRecipe(256075, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 95, 110, 125)
	recipe:SetRecipeItem(162339, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(153512, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddQuest(52366, 52372)

	-- Interdimensional Companion Repository -- 256080
	recipe = AddRecipe(256080, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(153510, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddTrainer(131840, 136059, 150630, 150631, 153817, 154321)

	-- Interdimensional Companion Repository -- 256082
	recipe = AddRecipe(256082, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(153510, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddTrainer(131840, 136059, 150630, 150631, 153817, 154321)

	-- Interdimensional Companion Repository -- 256084
	recipe = AddRecipe(256084, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 95, 110, 125)
	recipe:SetRecipeItem(162341, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(153510, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddRepVendor(FAC.ZANDALARI_EMPIRE, REP.REVERED, 131287)
	recipe:AddRepVendor(FAC.STORMS_WAKE, REP.REVERED, 135800)

	-- Super-Charged Engine -- 256132
	recipe = AddRecipe(256132, V.BFA, Q.RARE)
	recipe:SetSkillLevels(160, 160, 170, 172, 175)
	recipe:SetRecipeItem(169609, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(158886, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_MOUNT")
	recipe:AddMobDrop(144246)

	-- Deployable Attire Rearranger -- 256154
	recipe = AddRecipe(256154, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(153597, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddTrainer(131840, 136059, 150630, 150631, 153817, 154321)

	-- Deployable Attire Rearranger -- 256155
	recipe = AddRecipe(256155, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(153597, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddTrainer(131840, 136059, 150630, 150631, 153817, 154321)

	-- Deployable Attire Rearranger -- 256156
	recipe = AddRecipe(256156, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 95, 110, 125)
	recipe:SetRecipeItem(162342, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(153597, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddRepVendor(FAC.ZANDALARI_EMPIRE, REP.REVERED, 131287)
	recipe:AddRepVendor(FAC.STORMS_WAKE, REP.REVERED, 135800)

	-- Crow's Nest Scope -- 264960
	recipe = AddRecipe(264960, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(35, 35, 45, 50, 55)
	recipe:SetCraftedItem(158212, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_ITEM_ENHANCEMENT")
	recipe:AddTrainer(131840, 136059, 150630, 150631, 153817, 154321)

	-- Crow's Nest Scope -- 264961
	recipe = AddRecipe(264961, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(85, 85, 95, 100, 105)
	recipe:SetCraftedItem(158212, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_ITEM_ENHANCEMENT")
	recipe:AddTrainer(131840, 136059, 150630, 150631, 153817, 154321)

	-- Crow's Nest Scope -- 264962
	recipe = AddRecipe(264962, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(85, 85, 115, 125, 135)
	recipe:SetCraftedItem(158212, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_ITEM_ENHANCEMENT")
	recipe:AddQuest(52368, 52374)

	-- Monelite Scope of Alacrity -- 264964
	recipe = AddRecipe(264964, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(35, 35, 45, 50, 55)
	recipe:SetCraftedItem(158327, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_ITEM_ENHANCEMENT")
	recipe:AddTrainer(131840, 136059, 150630, 150631, 153817, 154321)

	-- Monelite Scope of Alacrity -- 264966
	recipe = AddRecipe(264966, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(85, 85, 95, 100, 105)
	recipe:SetCraftedItem(158327, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_ITEM_ENHANCEMENT")
	recipe:AddTrainer(131840, 136059, 150630, 150631, 153817, 154321)

	-- Monelite Scope of Alacrity -- 264967
	recipe = AddRecipe(264967, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(85, 85, 115, 125, 135)
	recipe:SetRecipeItem(162344, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(158327, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_ITEM_ENHANCEMENT")
	recipe:AddRepVendor(FAC.SEVENTH_LEGION, REP.REVERED, 135446)
	recipe:AddRepVendor(FAC.THE_HONORBOUND, REP.REVERED, 135447)

	-- Incendiary Ammunition -- 265097
	recipe = AddRecipe(265097, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(35, 35, 45, 50, 55)
	recipe:SetCraftedItem(158203, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_ITEM_ENHANCEMENT")
	recipe:AddTrainer(131840, 136059, 150630, 150631, 153817, 154321)

	-- Incendiary Ammunition -- 265098
	recipe = AddRecipe(265098, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(85, 85, 95, 100, 105)
	recipe:SetCraftedItem(158203, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_ITEM_ENHANCEMENT")
	recipe:AddTrainer(131840, 136059, 150630, 150631, 153817, 154321)

	-- Incendiary Ammunition -- 265099
	recipe = AddRecipe(265099, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(85, 85, 115, 125, 135)
	recipe:SetRecipeItem(162321, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(158203, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_ITEM_ENHANCEMENT")
	recipe:AddQuest(52363, 52369)

	-- Frost-Laced Ammunition -- 265100
	recipe = AddRecipe(265100, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(35, 35, 45, 50, 55)
	recipe:SetCraftedItem(158377, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_ITEM_ENHANCEMENT")
	recipe:AddTrainer(131840, 136059, 150630, 150631, 153817, 154321)

	-- Frost-Laced Ammunition -- 265101
	recipe = AddRecipe(265101, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(85, 85, 95, 100, 105)
	recipe:SetCraftedItem(158377, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_ITEM_ENHANCEMENT")
	recipe:AddTrainer(131840, 136059, 150630, 150631, 153817, 154321)

	-- Frost-Laced Ammunition -- 265102
	recipe = AddRecipe(265102, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(85, 85, 115, 125, 135)
	recipe:SetRecipeItem(162322, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(158377, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_ITEM_ENHANCEMENT")
	recipe:AddRepVendor(FAC.ORDER_OF_EMBERS, REP.REVERED, 135815)
	recipe:AddRepVendor(FAC.VOLDUNAI, REP.REVERED, 135804)

	-- Belt Enchant: Miniaturized Plasma Shield -- 269123
	recipe = AddRecipe(269123, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(85, 85, 95, 100, 105)
	recipe:SetCraftedItem(159829, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_ITEM_ENHANCEMENT")
	recipe:AddTrainer(131840, 136059, 150630, 150631, 153817, 154321)

	-- Honorable Combatant's Discombobulator -- 269724
	recipe = AddRecipe(269724, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 110, 115, 120)
	recipe:SetCraftedItem(159937, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_ONE_HAND_MACE")
	recipe:AddTrainer(131840, 136059, 150630, 150631, 153817, 154321)

	-- Honorable Combatant's Discombobulator -- 269725
	recipe = AddRecipe(269725, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 125, 137, 150)
	recipe:SetRecipeItem(163020, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(159937, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_ONE_HAND_MACE")
	recipe:AddFilters(F.DPS)
	recipe:AddVendor(142552, 142564)

	-- Honorable Combatant's Discombobulator -- 269726
	recipe = AddRecipe(269726, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 135, 142, 150)
	recipe:SetRecipeItem(163021, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(159937, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_ONE_HAND_MACE")
	recipe:AddVendor(142552, 142564)

	-- Honorable Combatant's Stormsteel Destroyer -- 269727
	recipe = AddRecipe(269727, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 110, 115, 120)
	recipe:SetCraftedItem(159936, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_GUN")
	recipe:AddTrainer(131840, 136059, 150630, 150631, 153817, 154321)

	-- Honorable Combatant's Stormsteel Destroyer -- 269728
	recipe = AddRecipe(269728, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 125, 137, 150)
	recipe:SetRecipeItem(163022, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(159936, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_GUN")
	recipe:AddFilters(F.DPS)
	recipe:AddVendor(142552, 142564)

	-- Honorable Combatant's Stormsteel Destroyer -- 269729
	recipe = AddRecipe(269729, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 135, 142, 150)
	recipe:SetRecipeItem(163023, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(159936, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_GUN")
	recipe:AddFilters(F.DPS)
	recipe:AddVendor(142552, 142564)

	-- AZ3-R1-T3 Synthetic Specs -- 272056
	recipe = AddRecipe(272056, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(115, 115, 125, 130, 135)
	recipe:SetCraftedItem(160488, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddTrainer(131840, 136059, 150630, 150631, 153817, 154321)

	-- AZ3-R1-T3 Synthetic Specs -- 272057
	recipe = AddRecipe(272057, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(115, 115, 130, 140, 150)
	recipe:SetRecipeItem(162323, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(160488, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddRepVendor(FAC.SEVENTH_LEGION, REP.HONORED, 135446)
	recipe:AddRepVendor(FAC.THE_HONORBOUND, REP.HONORED, 135447)

	-- AZ3-R1-T3 Synthetic Specs -- 272058
	recipe = AddRecipe(272058, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(115, 115, 150, 150, 150)
	recipe:SetRecipeItem(162324, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(160488, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddRepVendor(FAC.SEVENTH_LEGION, REP.REVERED, 135446)
	recipe:AddRepVendor(FAC.THE_HONORBOUND, REP.REVERED, 135447)

	-- AZ3-R1-T3 Gearspun Goggles -- 272059
	recipe = AddRecipe(272059, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(115, 115, 125, 130, 135)
	recipe:SetCraftedItem(160489, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddTrainer(131840, 136059, 150630, 150631, 153817, 154321)

	-- AZ3-R1-T3 Gearspun Goggles -- 272060
	recipe = AddRecipe(272060, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(115, 115, 140, 145, 150)
	recipe:SetRecipeItem(162325, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(160489, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddRepVendor(FAC.ZANDALARI_EMPIRE, REP.HONORED, 131287)
	recipe:AddRepVendor(FAC.STORMS_WAKE, REP.HONORED, 135800)

	-- AZ3-R1-T3 Gearspun Goggles -- 272061
	recipe = AddRecipe(272061, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(115, 115, 150, 150, 150)
	recipe:SetRecipeItem(162326, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(160489, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddRepVendor(FAC.STORMS_WAKE, REP.REVERED, 135800)
	recipe:AddRepVendor(FAC.ZANDALARI_EMPIRE, REP.REVERED, 131287)

	-- AZ3-R1-T3 Bionic Bifocals -- 272062
	recipe = AddRecipe(272062, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(115, 115, 125, 130, 135)
	recipe:SetCraftedItem(160490, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddTrainer(131840, 136059, 150630, 150631, 153817, 154321)

	-- AZ3-R1-T3 Bionic Bifocals -- 272063
	recipe = AddRecipe(272063, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(115, 115, 140, 145, 150)
	recipe:SetRecipeItem(162327, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(160490, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddRepVendor(FAC.PROUDMOORE_ADMIRALTY, REP.HONORED, 135808)
	recipe:AddRepVendor(FAC.TALANJIS_EXPEDITION, REP.HONORED, 135459)

	-- AZ3-R1-T3 Bionic Bifocals -- 272064
	recipe = AddRecipe(272064, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(115, 115, 150, 150, 150)
	recipe:SetRecipeItem(162328, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(160490, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddRepVendor(FAC.PROUDMOORE_ADMIRALTY, REP.REVERED, 135808)
	recipe:AddRepVendor(FAC.TALANJIS_EXPEDITION, REP.REVERED, 135459)

	-- AZ3-R1-T3 Orthogonal Optics -- 272065
	recipe = AddRecipe(272065, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(115, 115, 125, 130, 135)
	recipe:SetCraftedItem(160491, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddTrainer(131840, 136059, 150630, 150631, 153817, 154321)

	-- AZ3-R1-T3 Orthogonal Optics -- 272066
	recipe = AddRecipe(272066, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(115, 115, 140, 145, 150)
	recipe:SetRecipeItem(162329, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(160491, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddRepVendor(FAC.ORDER_OF_EMBERS, REP.HONORED, 135815)
	recipe:AddRepVendor(FAC.VOLDUNAI, REP.HONORED, 135804)

	-- AZ3-R1-T3 Orthogonal Optics -- 272067
	recipe = AddRecipe(272067, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(115, 115, 150, 150, 150)
	recipe:SetRecipeItem(162330, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(160491, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddRepVendor(FAC.ORDER_OF_EMBERS, REP.REVERED, 135815)
	recipe:AddRepVendor(FAC.VOLDUNAI, REP.REVERED, 135804)

	-- Mecha-Mogul Mk2 -- 274621
	recipe = AddRecipe(274621, V.BFA, Q.EPIC)
	recipe:SetSkillLevels(150, 150, 150, 150, 150)
	recipe:SetRecipeItem(161135, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(161134, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_MOUNT")
	recipe:AddWorldDrop(Z.THE_MOTHERLODE)

	-- Makeshift Azerite Detector -- 278411
	recipe = AddRecipe(278411, V.BFA, Q.UNCOMMON)
	recipe:SetSkillLevels(50, 50, 95, 110, 125)
	recipe:SetRecipeItem(163195, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(165738, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddMobDrop(138122)

	-- Monelite Fish Finder -- 278413
	recipe = AddRecipe(278413, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(165742, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddTrainer(131840, 136059, 150630, 150631, 153817, 154321)

	-- Magical Intrusion Dampener -- 280732
	recipe = AddRecipe(280732, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(158380, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddTrainer(131840, 136059, 150630, 150631, 153817, 154321)

	-- Magical Intrusion Dampener -- 280733
	recipe = AddRecipe(280733, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(158380, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddTrainer(131840, 136059, 150630, 150631, 153817, 154321)

	-- Magical Intrusion Dampener -- 280734
	recipe = AddRecipe(280734, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(85, 85, 95, 100, 105)
	recipe:SetCraftedItem(158380, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddTrainer(131840, 136059, 150630, 150631, 153817, 154321)

	-- Sinister Combatant's Discombobulator -- 282806
	recipe = AddRecipe(282806, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 110, 115, 120)
	recipe:SetCraftedItem(164680, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_ONE_HAND_MACE")
	recipe:AddTrainer(131840, 136059, 150630, 150631, 153817, 154321)

	-- Sinister Combatant's Discombobulator -- 282807
	recipe = AddRecipe(282807, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 140, 145, 150)
	recipe:SetRecipeItem(165302, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(164680, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_ONE_HAND_MACE")
	recipe:AddFilters(F.DPS)
	recipe:AddVendor(142552, 142564)

	-- Sinister Combatant's Discombobulator -- 282808
	recipe = AddRecipe(282808, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 145, 147, 150)
	recipe:SetRecipeItem(165303, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(164680, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_ONE_HAND_MACE")
	recipe:AddFilters(F.DPS)
	recipe:AddVendor(142552, 142564)

	-- Sinister Combatant's Stormsteel Destroyer -- 282809
	recipe = AddRecipe(282809, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 110, 115, 120)
	recipe:SetCraftedItem(164679, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_GUN")
	recipe:AddTrainer(131840, 136059, 150630, 150631, 153817, 154321)

	-- Sinister Combatant's Stormsteel Destroyer -- 282810
	recipe = AddRecipe(282810, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 140, 145, 150)
	recipe:SetRecipeItem(165304, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(164679, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_GUN")
	recipe:AddFilters(F.DPS)
	recipe:AddVendor(142552, 142564)

	-- Sinister Combatant's Stormsteel Destroyer -- 282811
	recipe = AddRecipe(282811, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 145, 147, 150)
	recipe:SetRecipeItem(165305, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(164679, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_GUN")
	recipe:AddFilters(F.DPS)
	recipe:AddVendor(142552, 142564)

	-- The Ub3r-Spanner -- 282975
	recipe = AddRecipe(282975, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(150, 150, 150, 150, 150)
	recipe:SetCraftedItem(164740, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddQuest(53937, 53949)

	-- Ub3r-Module: Short-Fused Bomb Bots -- 283399
	recipe = AddRecipe(283399, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(150, 150, 150, 150, 150)
	recipe:SetCraftedItem(164740, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddQuest(53937, 53949)

	-- Ub3r-Module: Ub3r S3ntry Mk. X8.0 -- 283401
	recipe = AddRecipe(283401, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(150, 150, 150, 150, 150)
	recipe:SetCraftedItem(164915, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddQuest(53937, 53949)

	-- Ub3r-Module: Ub3r-Improved Target Dummy -- 283403
	recipe = AddRecipe(283403, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(150, 150, 150, 150, 150)
	recipe:SetCraftedItem(164914, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddQuest(53937, 53949)

	-- Unstable Temporal Time Shifter -- 283914
	recipe = AddRecipe(283914, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(85, 85, 95, 100, 105)
	recipe:SetCraftedItem(158379, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddTrainer(131840, 136059, 150630, 150631, 153817, 154321)

	-- Unstable Temporal Time Shifter -- 283915
	recipe = AddRecipe(283915, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(85, 85, 125, 137, 150)
	recipe:SetRecipeItem(166277, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(158379, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddRepVendor(FAC.ZANDALARI_EMPIRE, REP.EXALTED, 131287)
	recipe:AddRepVendor(FAC.STORMS_WAKE, REP.EXALTED, 135800)

	-- Unstable Temporal Time Shifter -- 283916
	recipe = AddRecipe(283916, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(85, 85, 145, 147, 150)
	recipe:SetRecipeItem(166276, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(158379, "BIND_ON_EQUIP")
	recipe:AddMobDrop(144838)

	-- Mechantula -- 286478
	recipe = AddRecipe(286478, V.BFA, Q.UNCOMMON)
	recipe:SetSkillLevels(125, 125, 135, 140, 145)
	recipe:SetRecipeItem(165844, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(165849, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_PET")
	recipe:AddVendor(147070)

	-- Sanguinated Thermo-Degradation -- 286647
	recipe = AddRecipe(286647, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(162461, "286647")
	recipe:SetItemFilterType("ENGINEERING_MATERIALS")
	recipe:AddTrainer(131840, 136059, 150630, 150631, 153817, 154321)

	-- Surging Bionic Bifocals -- 286864
	recipe = AddRecipe(286864, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(130, 130, 140, 145, 150)
	recipe:SetCraftedItem(165887, "286864")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddTrainer(131840, 136059, 150630, 150631, 153817, 154321)

	-- SP1-R1-73D Bionic Bifocals -- 286865
	recipe = AddRecipe(286865, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(130, 130, 150, 150, 150)
	recipe:SetCraftedItem(165892, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddDiscovery("DISCOVERY_ENG_BFA")

	-- Charged SP1-R1-73D Bionic Bifocals -- 286866
	recipe = AddRecipe(286866, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(130, 130, 150, 150, 150)
	recipe:SetCraftedItem(165897, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddDiscovery("DISCOVERY_ENG_BFA")

	-- Surging Gearspun Goggles -- 286867
	recipe = AddRecipe(286867, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(130, 130, 140, 145, 150)
	recipe:SetCraftedItem(165886, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddTrainer(131840, 136059, 150630, 150631, 153817, 154321)

	-- SP1-R1-73D Gearspun Goggles -- 286868
	recipe = AddRecipe(286868, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(130, 130, 150, 150, 150)
	recipe:SetCraftedItem(165891, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddDiscovery("DISCOVERY_ENG_BFA")

	-- Charged SP1-R1-73D Gearspun Goggles -- 286869
	recipe = AddRecipe(286869, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(130, 130, 150, 150, 150)
	recipe:SetCraftedItem(165896, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddDiscovery("DISCOVERY_ENG_BFA")

	-- Surging Orthogonal Optics -- 286870
	recipe = AddRecipe(286870, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(130, 130, 140, 145, 150)
	recipe:SetCraftedItem(165888, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddTrainer(131840, 136059, 150630, 150631, 153817, 154321)

	-- SP1-R1-73D Orthogonal Optics -- 286871
	recipe = AddRecipe(286871, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(130, 130, 150, 150, 150)
	recipe:SetCraftedItem(165893, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddDiscovery("DISCOVERY_ENG_BFA")

	-- Charged SP1-R1-73D Orthogonal Optics -- 286872
	recipe = AddRecipe(286872, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(130, 130, 150, 150, 150)
	recipe:SetCraftedItem(165898, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddDiscovery("DISCOVERY_ENG_BFA")

	-- Surging Synthetic Specs -- 286873
	recipe = AddRecipe(286873, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(130, 130, 140, 145, 150)
	recipe:SetCraftedItem(165885, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddTrainer(131840, 136059, 150630, 150631, 153817, 154321)

	-- SP1-R1-73D Synthetic Specs -- 286874
	recipe = AddRecipe(286874, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(130, 130, 150, 150, 150)
	recipe:SetCraftedItem(165890, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddDiscovery("DISCOVERY_ENG_BFA")

	-- Charged SP1-R1-73D Synthetic Specs -- 286875
	recipe = AddRecipe(286875, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(130, 130, 150, 150, 150)
	recipe:SetCraftedItem(165895, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddDiscovery("DISCOVERY_ENG_BFA")

	-- Aqueous Thermo-Degradation -- 287279
	recipe = AddRecipe(287279, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(162460, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_MATERIALS")
	recipe:AddTrainer(131840, 136059, 150630, 150631, 153817, 154321)

	-- Imbued Synthetic Specs -- 291089
	recipe = AddRecipe(291089, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(120, 120, 130, 135, 140)
	recipe:SetCraftedItem(166979, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddTrainer(131840, 136059, 150630, 150631, 153817, 154321)

	-- Emblazoned Synthetic Specs -- 291090
	recipe = AddRecipe(291090, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(120, 120, 130, 140, 150)
	recipe:SetCraftedItem(166980, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddDiscovery("DISCOVERY_ENG_BFA")

	-- Imbued Gearspun Goggles -- 291091
	recipe = AddRecipe(291091, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(120, 120, 130, 135, 140)
	recipe:SetCraftedItem(166981, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddTrainer(131840, 136059, 150630, 150631, 153817, 154321)

	-- Emblazoned Gearspun Goggles -- 291092
	recipe = AddRecipe(291092, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(120, 120, 130, 140, 150)
	recipe:SetCraftedItem(166892, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddDiscovery("DISCOVERY_ENG_BFA")

	-- Imbued Bionic Bifocals -- 291093
	recipe = AddRecipe(291093, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(120, 120, 130, 135, 140)
	recipe:SetCraftedItem(166983, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddTrainer(131840, 136059, 150630, 150631, 153817, 154321)

	-- Emblazoned Bionic Bifocals -- 291094
	recipe = AddRecipe(291094, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(120, 120, 125, 137, 150)
	recipe:SetCraftedItem(166983, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddDiscovery("DISCOVERY_ENG_BFA")

	-- Imbued Orthogonal Optics -- 291095
	recipe = AddRecipe(291095, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(120, 120, 130, 135, 140)
	recipe:SetCraftedItem(166985, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddTrainer(131840, 136059, 150630, 150631, 153817, 154321)

	-- Emblazoned Orthogonal Optics -- 291096
	recipe = AddRecipe(291096, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(120, 120, 130, 140, 150)
	recipe:SetCraftedItem(166986, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddDiscovery("DISCOVERY_ENG_BFA")

	-- Notorious Combatant's Discombobulator -- 294784
	recipe = AddRecipe(294784, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(135, 135, 145, 150, 155)
	recipe:SetCraftedItem(167940, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_ONE_HAND_MACE")
	recipe:AddTrainer(153817, 154321)

	-- Notorious Combatant's Discombobulator -- 294785
	recipe = AddRecipe(294785, V.BFA, Q.EPIC)
	recipe:SetSkillLevels(150, 150, 170, 172, 175)
	recipe:SetRecipeItem(169541, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(167940, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_ONE_HAND_MACE")
	recipe:AddVendor(154652, 154653)

	-- Notorious Combatant's Discombobulator -- 294786
	recipe = AddRecipe(294786, V.BFA, Q.EPIC)
	recipe:SetSkillLevels(165, 165, 175, 175, 175)
	recipe:SetRecipeItem(169542, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(167940, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_ONE_HAND_MACE")
	recipe:AddVendor(154652, 154653)

	-- Notorious Combatant's Stormsteel Destroyer -- 294787
	recipe = AddRecipe(294787, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(135, 135, 145, 150, 155)
	recipe:SetCraftedItem(167997, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_GUN")
	recipe:AddTrainer(153817, 154321)

	-- Notorious Combatant's Stormsteel Destroyer -- 294788
	recipe = AddRecipe(294788, V.BFA, Q.EPIC)
	recipe:SetSkillLevels(150, 150, 170, 172, 175)
	recipe:SetRecipeItem(169543, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(167997, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_GUN")
	recipe:AddVendor(154652, 154653)

	-- Notorious Combatant's Stormsteel Destroyer -- 294789
	recipe = AddRecipe(294789, V.BFA, Q.EPIC)
	recipe:SetSkillLevels(165, 165, 175, 175, 175)
	recipe:SetRecipeItem(169544, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(167997, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_GUN")
	recipe:AddVendor(154652, 154653)

	-- Ub3r-Module: P.O.G.O. -- 298255
	recipe = AddRecipe(298255, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(150, 150, 150, 162, 175)
	recipe:SetRecipeItem(168533, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(168521, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddRepVendor(FAC.RUSTBOLT_RESISTANCE, REP.REVERED, 150716)

	-- Ub3r-Module: Scrap Cannon -- 298256
	recipe = AddRecipe(298256, V.BFA, Q.RARE)
	recipe:SetSkillLevels(150, 150, 150, 162, 175)
	recipe:SetRecipeItem(168535, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(168523, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddRepVendor(FAC.RUSTBOLT_RESISTANCE, REP.REVERED, 150716)

	-- Ub3r-Module: Ub3r-Coil -- 298257
	recipe = AddRecipe(298257, V.BFA, Q.RARE)
	recipe:SetSkillLevels(150, 150, 150, 162, 175)
	recipe:SetRecipeItem(168533, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(168522, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddRepVendor(FAC.RUSTBOLT_RESISTANCE, REP.REVERED, 150716)

	-- Blingtron 7000 -- 298930
	recipe = AddRecipe(298930, V.BFA, Q.EPIC)
	recipe:SetSkillLevels(175, 175, 185, 190, 195)
	recipe:SetRecipeItem(168660, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(168667, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_TOY")
	recipe:AddRepVendor(FAC.RUSTBOLT_RESISTANCE, REP.EXALTED, 150716)

	-- Abyssal Synthetic Specs -- 299004
	recipe = AddRecipe(299004, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(170, 170, 180, 185, 190)
	recipe:SetCraftedItem(168689, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddTrainer(153817, 154321)

	-- A5C-3N-D3D Synthetic Specs -- 299005
	recipe = AddRecipe(299005, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(170, 170, 175, 175, 175)
	recipe:SetRecipeItem(168763, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(168690, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddDiscovery("DISCOVERY_ENG_BFA")

	-- Charged A5C-3N-D3D Synthetic Specs -- 299006
	recipe = AddRecipe(299006, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(170, 170, 175, 175, 175)
	recipe:SetRecipeItem(168764, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(168691, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddDiscovery("DISCOVERY_ENG_BFA")

	-- Abyssal Gearspun Goggles -- 299007
	recipe = AddRecipe(299007, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(170, 170, 180, 185, 190)
	recipe:SetCraftedItem(168692, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddTrainer(153817, 154321)

	-- A5C-3N-D3D Gearspun Goggles -- 299008
	recipe = AddRecipe(299008, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(170, 170, 180, 185, 190)
	recipe:SetRecipeItem(168765, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(168693, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddDiscovery("DISCOVERY_ENG_BFA")

	-- Charged A5C-3N-D3D Gearspun Goggles -- 299009
	recipe = AddRecipe(299009, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(170, 170, 180, 185, 190)
	recipe:SetRecipeItem(168766, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(168694, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddDiscovery("DISCOVERY_ENG_BFA")

	-- Abyssal Bionic Bifocals -- 299010
	recipe = AddRecipe(299010, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(170, 170, 180, 185, 190)
	recipe:SetCraftedItem(168695, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddTrainer(153817, 154321)

	-- A5C-3N-D3D Bionic Bifocals -- 299011
	recipe = AddRecipe(299011, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(170, 170, 180, 185, 190)
	recipe:SetRecipeItem(168767, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(168696, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddDiscovery("DISCOVERY_ENG_BFA")

	-- Charged A5C-3N-D3D Bionic Bifocals -- 299012
	recipe = AddRecipe(299012, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(170, 170, 180, 185, 190)
	recipe:SetRecipeItem(168768, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(168697, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddDiscovery("DISCOVERY_ENG_BFA")

	-- Abyssal Orthogonal Optics -- 299013
	recipe = AddRecipe(299013, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(170, 170, 180, 185, 190)
	recipe:SetCraftedItem(168698, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddTrainer(153817, 154321)

	-- A5C-3N-D3D Orthogonal Optics -- 299014
	recipe = AddRecipe(299014, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(170, 170, 180, 185, 190)
	recipe:SetRecipeItem(168769, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(168699, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddDiscovery("DISCOVERY_ENG_BFA")

	-- Charged A5C-3N-D3D Orthogonal Optics -- 299015
	recipe = AddRecipe(299015, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(170, 170, 180, 185, 190)
	recipe:SetRecipeItem(168770, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(168700, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddDiscovery("DISCOVERY_ENG_BFA")

	-- Wormhole Generator: Kul Tiras -- 299105
	recipe = AddRecipe(299105, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(150, 150, 160, 165, 170)
	recipe:SetCraftedItem(168807, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_TOY")
	recipe:AddTrainer(153817, 154321)

	-- Wormhole Generator: Zandalar -- 299106
	recipe = AddRecipe(299106, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(150, 150, 160, 165, 170)
	recipe:SetCraftedItem(168808, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_TOY")
	recipe:AddTrainer(153817, 154321)

	-- Uncanny Combatant's Stormsteel Destroyer -- 305858
	recipe = AddRecipe(305858, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 165, 170, 175)
	recipe:SetRecipeItem(174272, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(170314, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_GUN")
	recipe:AddFilters(F.DPS)
	recipe:AddVendor(142552, 142564, 161565)

	-- Uncanny Combatant's Stormsteel Destroyer -- 305859
	recipe = AddRecipe(305859, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 165, 170, 175)
	recipe:SetRecipeItem(174271, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(170314, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_GUN")
	recipe:AddFilters(F.DPS)
	recipe:AddVendor(142552, 142564, 161565)

	-- Uncanny Combatant's Stormsteel Destroyer -- 305860
	recipe = AddRecipe(305860, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(170, 170, 180, 185, 190)
	recipe:SetCraftedItem(170314, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_GUN")
	recipe:AddTrainer(131840, 136059)

	-- Uncanny Combatant's Discombobulator -- 305861
	recipe = AddRecipe(305861, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 165, 170, 175)
	recipe:SetRecipeItem(174274, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(170313, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_ONE_HAND_MACE")
	recipe:AddFilters(F.DPS)
	recipe:AddVendor(142552, 142564, 161565)

	-- Uncanny Combatant's Discombobulator -- 305862
	recipe = AddRecipe(305862, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 165, 170, 175)
	recipe:SetRecipeItem(174273, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(170313, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_ONE_HAND_MACE")
	recipe:AddFilters(F.DPS)
	recipe:AddVendor(142552, 142564, 161565)

	-- Uncanny Combatant's Discombobulator -- 305863
	recipe = AddRecipe(305863, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(170, 170, 180, 185, 190)
	recipe:SetCraftedItem(170313, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_ONE_HAND_MACE")
	recipe:AddTrainer(131840, 136059)

	-- Paramount Gearspun Goggles -- 305940
	recipe = AddRecipe(305940, V.BFA, Q.EPIC)
	recipe:SetSkillLevels(175, 175, 175, 175, 175)
	recipe:SetRecipeItem(170407, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(171003, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddDiscovery("DISCOVERY_ENG_BFA")

	-- Superior Gearspun Goggles -- 305941
	recipe = AddRecipe(305941, V.BFA, Q.EPIC)
	recipe:SetSkillLevels(170, 170, 175, 175, 175)
	recipe:SetRecipeItem(170406, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(171004, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddDiscovery("DISCOVERY_ENG_BFA")

	-- A-N0M-A-L0U5 Gearspun Goggles -- 305942
	recipe = AddRecipe(305942, V.BFA, Q.RARE)
	recipe:SetSkillLevels(170, 170, 175, 175, 175)
	recipe:SetRecipeItem(171313, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(171004, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddMobDrop(153910, 162245)

	-- Paramount Synthetic Specs -- 305943
	recipe = AddRecipe(305943, V.BFA, Q.EPIC)
	recipe:SetSkillLevels(175, 175, 175, 175, 175)
	recipe:SetRecipeItem(170405, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(171006, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddDiscovery("DISCOVERY_ENG_BFA")

	-- Superior Synthetic Specs -- 305944
	recipe = AddRecipe(305944, V.BFA, Q.EPIC)
	recipe:SetSkillLevels(170, 170, 175, 175, 175)
	recipe:SetRecipeItem(170404, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(171007, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddDiscovery("DISCOVERY_ENG_BFA")

	-- A-N0M-A-L0U5 Synthetic Specs -- 305945
	recipe = AddRecipe(305945, V.BFA, Q.RARE)
	recipe:SetSkillLevels(165, 165, 175, 175, 175)
	recipe:SetRecipeItem(171314, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(171008, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddMobDrop(153910, 162245)

	-- Paramount Orthogonal Optics -- 305946
	recipe = AddRecipe(305946, V.BFA, Q.EPIC)
	recipe:SetSkillLevels(175, 175, 175, 175, 175)
	recipe:SetRecipeItem(170411, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(171009, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddDiscovery("DISCOVERY_ENG_BFA")

	-- Superior Orthogonal Optics -- 305947
	recipe = AddRecipe(305947, V.BFA, Q.EPIC)
	recipe:SetSkillLevels(170, 170, 175, 175, 175)
	recipe:SetRecipeItem(170410, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(171010, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddDiscovery("DISCOVERY_ENG_BFA")

	-- A-N0M-A-L0U5 Orthogonal Optics -- 305948
	recipe = AddRecipe(305948, V.BFA, Q.RARE)
	recipe:SetSkillLevels(165, 165, 175, 175, 175)
	recipe:SetRecipeItem(174364, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(171011, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddMobDrop(153910, 162245)

	-- Paramount Bionic Bifocals -- 305949
	recipe = AddRecipe(305949, V.BFA, Q.EPIC)
	recipe:SetSkillLevels(170, 170, 175, 175, 175)
	recipe:SetRecipeItem(170409, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(171012, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddDiscovery("DISCOVERY_ENG_BFA")

	-- Superior Bionic Bifocals -- 305950
	recipe = AddRecipe(305950, V.BFA, Q.EPIC)
	recipe:SetSkillLevels(170, 170, 175, 175, 175)
	recipe:SetRecipeItem(170408, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(171013, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddDiscovery("DISCOVERY_ENG_BFA")

	-- A-N0M-A-L0U5 Bionic Bifocals -- 305951
	recipe = AddRecipe(305951, V.BFA, Q.RARE)
	recipe:SetSkillLevels(165, 165, 175, 175, 175)
	recipe:SetRecipeItem(174362, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(171014, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddMobDrop(153910, 162245)

	-- Void Focus -- 307220
	recipe = AddRecipe(307220, V.BFA, Q.RARE)
	recipe:SetSkillLevels(1, 1, 165, 170, 175)
	recipe:SetRecipeItem(171312, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(171320, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddMobDrop(153910, 162245)

	-- ----------------------------------------------------------------------------
	-- Shadowlands.
	-- ----------------------------------------------------------------------------
	-- Nutcracker Grenade -- 310484
	recipe = AddRecipe(310484, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(10, 10, 20, 25, 30)
	recipe:SetCraftedItem(172903, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddTrainer(156691)

	-- Shadow Land Mine -- 310485
	recipe = AddRecipe(310485, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(20, 20, 30, 35, 40)
	recipe:SetCraftedItem(172904, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddTrainer(156691)

	-- Bomb Bola Launcher -- 310486
	recipe = AddRecipe(310486, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(30, 30, 40, 45, 50)
	recipe:SetCraftedItem(172902, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddTrainer(156691)

	-- Momentum Redistributor Boots -- 310490
	recipe = AddRecipe(310490, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(65, 65, 75, 80, 85)
	recipe:SetCraftedItem(172912, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddTrainer(156691)

	-- Gravimetric Scrambler Cannon -- 310492
	recipe = AddRecipe(310492, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(60, 60, 70, 75, 80)
	recipe:SetCraftedItem(172914, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddTrainer(156691)

	-- 50UL-TR4P -- 310493
	recipe = AddRecipe(310493, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(172915, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddTrainer(156691)

	-- Dimensional Shifter -- 310495
	recipe = AddRecipe(310495, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(45, 45, 55, 60, 65)
	recipe:SetItemFilterType("ENGINEERING_ITEM_ENHANCEMENT")
	recipe:AddTrainer(156691)

	-- Electro-Jump -- 310496
	recipe = AddRecipe(310496, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(45, 45, 55, 60, 65)
	recipe:SetItemFilterType("ENGINEERING_ITEM_ENHANCEMENT")
	recipe:AddTrainer(156691)

	-- Damage Retaliator -- 310497
	recipe = AddRecipe(310497, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(45, 45, 55, 60, 65)
	recipe:SetItemFilterType("ENGINEERING_ITEM_ENHANCEMENT")
	recipe:AddTrainer(156691)

	-- Flexible Ectoplasmic Specs -- 310501
	recipe = AddRecipe(310501, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(85, 85, 95, 100, 105)
	recipe:SetCraftedItem(172905, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddTrainer(156691)

	-- Grounded Ectoplasmic Specs -- 310504
	recipe = AddRecipe(310504, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(85, 85, 95, 100, 105)
	recipe:SetCraftedItem(172906, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddTrainer(156691)

	-- Articulated Ectoplasmic Specs -- 310507
	recipe = AddRecipe(310507, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(85, 85, 95, 100, 105)
	recipe:SetCraftedItem(172907, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddTrainer(156691)

	-- Reinforced Ectoplasmic Specs -- 310509
	recipe = AddRecipe(310509, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(85, 85, 95, 100, 105)
	recipe:SetCraftedItem(172908, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_HEAD")
	recipe:AddTrainer(156691)

	-- Handful of Laestrite Bolts -- 310522
	recipe = AddRecipe(310522, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(10, 10, 10, 17, 25)
	recipe:SetCraftedItem(172934, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_MATERIALS")
	recipe:AddCustom("DEFAULT_RECIPE")

	-- Porous Polishing Abrasive -- 310524
	recipe = AddRecipe(310524, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(10, 10, 10, 17, 25)
	recipe:SetCraftedItem(172935, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_MATERIALS")
	recipe:AddCustom("DEFAULT_RECIPE")

	-- Mortal Coiled Spring -- 310525
	recipe = AddRecipe(310525, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(15, 15, 25, 30, 35)
	recipe:SetCraftedItem(172936, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_MATERIALS")
	recipe:AddTrainer(156691)

	-- Wormfed Gear Assembly -- 310526
	recipe = AddRecipe(310526, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(172937, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_MATERIALS")
	recipe:AddTrainer(156691)

	-- Optical Target Embiggener -- 310533
	recipe = AddRecipe(310533, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 85, 90, 95)
	recipe:SetCraftedItem(172920, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_ITEM_ENHANCEMENT")
	recipe:AddTrainer(156691)

	-- Infra-green Reflex Sight -- 310534
	recipe = AddRecipe(310534, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 85, 90, 95)
	recipe:SetCraftedItem(172921, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_ITEM_ENHANCEMENT")
	recipe:AddTrainer(156691)

	-- Wormhole Generator: Shadowlands -- 310535
	recipe = AddRecipe(310535, V.SHA, Q.EPIC)
	recipe:SetSkillLevels(70, 70, 80, 85, 90)
	recipe:SetRecipeItem(183858, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(172924, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_TOY")
	recipe:AddRepVendor(FAC.THE_UNDYING_ARMY, REP.HONORED, 173003, 176067)

	-- Precision Lifeforce Inverter -- 310536
	recipe = AddRecipe(310536, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(35, 35, 45, 50, 55)
	recipe:SetCraftedItem(172923, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_GUN")
	recipe:AddTrainer(156691)

	-- PHA7-YNX -- 331007
	recipe = AddRecipe(331007, V.SHA, Q.EPIC)
	recipe:SetSkillLevels(100, 100, 110, 115, 120)
	recipe:SetRecipeItem(183097, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(180208, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_PET")
	recipe:AddRepVendor(FAC.THE_ASCENDED, REP.EXALTED, 160470, 176064)

	-- Crafter's Mark I -- 343099
	recipe = AddRecipe(343099, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(45, 45, 55, 60, 65)
	recipe:SetCraftedItem(173381, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_MATERIALS")
	recipe:AddTrainer(156691)

	-- Crafter's Mark II -- 343100
	recipe = AddRecipe(343100, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 75, 80, 85)
	recipe:SetRecipeItem(183870, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(173382, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_MATERIALS")
	recipe:AddRepVendor(FAC.THE_AVOWED, REP.REVERED, 173705)

	-- Crafter's Mark III -- 343102
	recipe = AddRecipe(343102, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 190, 192, 195)
	recipe:SetRecipeItem(183868, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(173383, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_MATERIALS")
	recipe:AddRepVendor(FAC.DEATHS_ADVANCE, REP.HONORED, 179321)

	-- Crafter's Mark of the Chained Isle -- 343103
	recipe = AddRecipe(343103, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(200, 200, 200, 200, 200)
	recipe:SetRecipeItem(186470, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(173384, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_MATERIALS")
	recipe:AddRepVendor(FAC.THE_ARCHIVISTS_CODEX, REP.REVERED, 178257)

	-- Novice Crafter's Mark -- 343661
	recipe = AddRecipe(343661, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(85, 85, 95, 100, 105)
	recipe:SetCraftedItem(183942, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_MATERIALS")
	recipe:AddTrainer(156691)

	-- Disposable Spectrophasic Reanimator -- 345179
	recipe = AddRecipe(345179, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(184308, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddTrainer(156691)

-- 9.2 Recipes

	-- Crafter's Mark IV -- 359664
	recipe = AddRecipe(359664, V.SHA, Q.EPIC)
	recipe:SetSkillLevels(201, 201, 201, 201, 201)
	recipe:SetRecipeItem(187750, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(187741, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddRepVendor(FAC.THE_ENLIGHTENED, REP.HONORED, 182257)

	-- Crafter's Mark of the First Ones -- 359674
	recipe = AddRecipe(359674, V.SHA, Q.EPIC)
	recipe:SetSkillLevels(201, 201, 201, 201, 201)
	recipe:SetRecipeItem(187749, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(187742, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddRepVendor(FAC.THE_ENLIGHTENED, REP.HONORED, 182257)

	-- Pure-Air Sail Extensions -- 360088
	recipe = AddRecipe(360088, V.SHA, Q.RARE)
	recipe:SetSkillLevels(100, 100, 100, 110, 120)
	recipe:SetRecipeItem(187832, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(187831, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddMobDrop(180924, 183925)

	-- Erratic Genesis Matrix -- 360126
	recipe = AddRecipe(360126, V.SHA, Q.RARE)
	recipe:SetSkillLevels(100, 100, 100, 110, 120)
	recipe:SetRecipeItem(187837, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(187836, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("ENGINEERING_CREATED_ITEM")
	recipe:AddMobDrop(180917)


	self.InitializeRecipes = nil
end
