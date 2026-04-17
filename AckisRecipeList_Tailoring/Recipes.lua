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
	-- Brown Linen Vest -- 2385
	recipe = AddRecipe(2385, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(10, 10, 45, 57, 70)
	recipe:SetCraftedItem(2568, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 3704, 4159, 4576, 5153, 9584, 11052, 11557, 16366, 16640, 16729, 17487, 18749, 18772, 26914, 26964, 26969, 27001, 28699, 33580, 33613, 33636, 33684, 43428, 44783, 45559, 47384, 47396, 47400, 47418, 47419, 47420, 47431, 48619, 57405, 57620, 65043)

	-- Linen Boots -- 2386
	recipe = AddRecipe(2386, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(65, 65, 90, 107, 125)
	recipe:SetCraftedItem(2569, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_FEET")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 3704, 4159, 4576, 5153, 9584, 11052, 11557, 16366, 16640, 16729, 17487, 18749, 18772, 26914, 26964, 26969, 27001, 28699, 33580, 33613, 33636, 33684, 43428, 44783, 45559, 47384, 47396, 47400, 47418, 47419, 47420, 47431, 48619, 57405, 57620, 65043)

	-- Linen Cloak -- 2387
	recipe = AddRecipe(2387, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 35, 47, 60)
	recipe:SetCraftedItem(2570, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BACK")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MISC1)
	recipe:AddCustom("DEFAULT_RECIPE")

	-- Red Linen Robe -- 2389
	recipe = AddRecipe(2389, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(40, 40, 65, 82, 100)
	recipe:SetRecipeItem(2598, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(2572, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Red Linen Shirt -- 2392
	recipe = AddRecipe(2392, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(40, 40, 65, 82, 100)
	recipe:SetCraftedItem(2575, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_SHIRT")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 3704, 4159, 4576, 5153, 9584, 11052, 11557, 16366, 16640, 16729, 17487, 18749, 18772, 26914, 26964, 26969, 27001, 28699, 33580, 33613, 33636, 33684, 43428, 44783, 45559, 47384, 47396, 47400, 47418, 47419, 47420, 47431, 48619, 57405, 57620, 65043)

	-- White Linen Shirt -- 2393
	recipe = AddRecipe(2393, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 35, 47, 60)
	recipe:SetCraftedItem(2576, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_SHIRT")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 3704, 4159, 4576, 5153, 9584, 11052, 11557, 16366, 16640, 16729, 17487, 18749, 18772, 26914, 26964, 26969, 27001, 28699, 33580, 33613, 33636, 33684, 43428, 44783, 45559, 47384, 47396, 47400, 47418, 47419, 47420, 47431, 48619, 57405, 57620, 65043)

	-- Blue Linen Shirt -- 2394
	recipe = AddRecipe(2394, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(40, 40, 65, 82, 100)
	recipe:SetCraftedItem(2577, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_SHIRT")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 3704, 4159, 4576, 5153, 9584, 11052, 11557, 16366, 16640, 16729, 17487, 18749, 18772, 26914, 26964, 26969, 27001, 28699, 33580, 33613, 33636, 33684, 43428, 44783, 45559, 47384, 47396, 47400, 47418, 47419, 47420, 47431, 48619, 57405, 57620, 65043)

	-- Barbaric Linen Vest -- 2395
	recipe = AddRecipe(2395, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(70, 70, 95, 112, 130)
	recipe:SetCraftedItem(2578, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 3704, 4159, 4576, 5153, 9584, 11052, 11557, 16366, 16640, 16729, 17487, 18749, 18772, 26914, 26964, 26969, 27001, 28699, 33580, 33613, 33636, 33684, 43428, 44783, 45559, 47384, 47396, 47400, 47418, 47419, 47420, 47431, 48619, 57405, 57620, 65043)

	-- Green Linen Shirt -- 2396
	recipe = AddRecipe(2396, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(70, 70, 95, 112, 130)
	recipe:SetCraftedItem(2579, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_SHIRT")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 3704, 4159, 4576, 5153, 9584, 11052, 11557, 16366, 16640, 16729, 17487, 18749, 18772, 26914, 26964, 26969, 27001, 28699, 33580, 33613, 33636, 33684, 43428, 44783, 45559, 47384, 47396, 47400, 47418, 47419, 47420, 47431, 48619, 57405, 57620, 65043)

	-- Reinforced Linen Cape -- 2397
	recipe = AddRecipe(2397, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(60, 60, 85, 102, 120)
	recipe:SetCraftedItem(2580, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BACK")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 3704, 4159, 4576, 5153, 9584, 11052, 11557, 16366, 16640, 16729, 17487, 18749, 18772, 26914, 26964, 26969, 27001, 28699, 33580, 33613, 33636, 33684, 43428, 44783, 45559, 47384, 47396, 47400, 47418, 47419, 47420, 47431, 48619, 57405, 57620, 65043)

	-- Green Woolen Vest -- 2399
	recipe = AddRecipe(2399, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(85, 85, 110, 127, 145)
	recipe:SetCraftedItem(2582, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 3704, 4159, 4576, 5153, 9584, 11052, 11557, 16366, 16640, 16729, 17487, 18749, 18772, 26914, 26964, 26969, 27001, 28699, 33580, 33613, 33636, 33684, 43428, 44783, 45559, 57405)

	-- Woolen Boots -- 2401
	recipe = AddRecipe(2401, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(95, 95, 120, 137, 155)
	recipe:SetCraftedItem(2583, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_FEET")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 3704, 4159, 4576, 5153, 9584, 11052, 11557, 16366, 16640, 16729, 17487, 18749, 18772, 26914, 26964, 26969, 27001, 28699, 33580, 33613, 33636, 33684, 43428, 44783, 45559, 57405)

	-- Woolen Cape -- 2402
	recipe = AddRecipe(2402, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 100, 117, 135)
	recipe:SetCraftedItem(2584, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BACK")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 3704, 4159, 4576, 5153, 9584, 11052, 11557, 16366, 16640, 16729, 17487, 18749, 18772, 26914, 26964, 26969, 27001, 28699, 33580, 33613, 33636, 33684, 43428, 44783, 45559, 47384, 47396, 47400, 47418, 47419, 47420, 47431, 48619, 57405, 57620, 65043)

	-- Gray Woolen Robe -- 2403
	recipe = AddRecipe(2403, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(105, 105, 130, 147, 165)
	recipe:SetRecipeItem(2601, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(2585, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Gray Woolen Shirt -- 2406
	recipe = AddRecipe(2406, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 110, 120, 130)
	recipe:SetCraftedItem(2587, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_SHIRT")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 3704, 4159, 4576, 5153, 9584, 11052, 11557, 16366, 16640, 16729, 17487, 18749, 18772, 26914, 26964, 26969, 27001, 28699, 33580, 33613, 33636, 33684, 43428, 44783, 45559, 57405)

	-- Bolt of Linen Cloth -- 2963
	recipe = AddRecipe(2963, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 25, 37, 50)
	recipe:SetCraftedItem(2996, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_MATERIALS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MISC1)
	recipe:AddCustom("DEFAULT_RECIPE")

	-- Bolt of Woolen Cloth -- 2964
	recipe = AddRecipe(2964, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 90, 97, 105)
	recipe:SetCraftedItem(2997, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_MATERIALS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 3704, 4159, 4576, 5153, 9584, 11052, 11557, 16366, 16640, 16729, 17487, 18749, 18772, 26914, 26964, 26969, 27001, 28699, 33580, 33613, 33636, 33684, 43428, 44783, 45559, 47384, 47396, 47400, 47418, 47419, 47420, 47431, 48619, 57405, 57620, 65043)

	-- Linen Bag -- 3755
	recipe = AddRecipe(3755, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(45, 45, 70, 87, 105)
	recipe:SetCraftedItem(4238, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BAG")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 3704, 4159, 4576, 5153, 9584, 11052, 11557, 16366, 16640, 16729, 17487, 18749, 18772, 26914, 26964, 26969, 27001, 28699, 33580, 33613, 33636, 33684, 43428, 44783, 45559, 47384, 47396, 47400, 47418, 47419, 47420, 47431, 48619, 57405, 57620, 65043)

	-- Woolen Bag -- 3757
	recipe = AddRecipe(3757, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(80, 80, 105, 122, 140)
	recipe:SetCraftedItem(4240, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BAG")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 3704, 4159, 4576, 5153, 9584, 11052, 11557, 16366, 16640, 16729, 17487, 18749, 18772, 26914, 26964, 26969, 27001, 28699, 33580, 33613, 33636, 33684, 43428, 44783, 45559, 57405)

	-- Green Woolen Bag -- 3758
	recipe = AddRecipe(3758, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(95, 95, 120, 137, 155)
	recipe:SetRecipeItem(4292, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(4241, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BAG")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Small Silk Pack -- 3813
	recipe = AddRecipe(3813, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(150, 150, 170, 185, 200)
	recipe:SetCraftedItem(4245, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BAG")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 3704, 4159, 4576, 5153, 9584, 11052, 11557, 16366, 16640, 16729, 17487, 18749, 18772, 26914, 26964, 26969, 27001, 28699, 33580, 33613, 33636, 33684, 43428, 44783, 45559, 57405)

	-- Bolt of Silk Cloth -- 3839
	recipe = AddRecipe(3839, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(125, 125, 135, 140, 145)
	recipe:SetCraftedItem(4305, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_MATERIALS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 3704, 4159, 4576, 5153, 9584, 11052, 11557, 16366, 16640, 16729, 17487, 18749, 18772, 26914, 26964, 26969, 27001, 28699, 33580, 33613, 33636, 33684, 43428, 44783, 45559, 57405)

	-- Heavy Linen Gloves -- 3840
	recipe = AddRecipe(3840, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(35, 35, 60, 77, 95)
	recipe:SetCraftedItem(4307, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HANDS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 3704, 4159, 4576, 5153, 9584, 11052, 11557, 16366, 16640, 16729, 17487, 18749, 18772, 26914, 26964, 26969, 27001, 28699, 33580, 33613, 33636, 33684, 43428, 44783, 45559, 47384, 47396, 47400, 47418, 47419, 47420, 47431, 48619, 57405, 57620, 65043)

	-- Green Linen Bracers -- 3841
	recipe = AddRecipe(3841, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(60, 60, 85, 102, 120)
	recipe:SetCraftedItem(4308, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WRIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 3704, 4159, 4576, 5153, 9584, 11052, 11557, 16366, 16640, 16729, 17487, 18749, 18772, 26914, 26964, 26969, 27001, 28699, 33580, 33613, 33636, 33684, 43428, 44783, 45559, 47384, 47396, 47400, 47418, 47419, 47420, 47431, 48619, 57405, 57620, 65043)

	-- Handstitched Linen Britches -- 3842
	recipe = AddRecipe(3842, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(70, 70, 95, 112, 130)
	recipe:SetCraftedItem(4309, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_LEGS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 3704, 4159, 4576, 5153, 9584, 11052, 11557, 16366, 16640, 16729, 17487, 18749, 18772, 26914, 26964, 26969, 27001, 28699, 33580, 33613, 33636, 33684, 43428, 44783, 45559, 47384, 47396, 47400, 47418, 47419, 47420, 47431, 48619, 57405, 57620, 65043)

	-- Heavy Woolen Gloves -- 3843
	recipe = AddRecipe(3843, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(85, 85, 110, 127, 145)
	recipe:SetCraftedItem(4310, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HANDS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 3704, 4159, 4576, 5153, 9584, 11052, 11557, 16366, 16640, 16729, 17487, 18749, 18772, 26914, 26964, 26969, 27001, 28699, 33580, 33613, 33636, 33684, 43428, 44783, 45559, 57405)

	-- Heavy Woolen Cloak -- 3844
	recipe = AddRecipe(3844, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(100, 100, 125, 142, 160)
	recipe:SetRecipeItem(4346, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(4311, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BACK")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Soft-soled Linen Boots -- 3845
	recipe = AddRecipe(3845, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(80, 80, 105, 122, 140)
	recipe:SetCraftedItem(4312, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_FEET")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 3704, 4159, 4576, 5153, 9584, 11052, 11557, 16366, 16640, 16729, 17487, 18749, 18772, 26914, 26964, 26969, 27001, 28699, 33580, 33613, 33636, 33684, 43428, 44783, 45559, 57405)

	-- Red Woolen Boots -- 3847
	recipe = AddRecipe(3847, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(95, 95, 120, 137, 155)
	recipe:SetRecipeItem(4345, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(4313, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_FEET")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Double-stitched Woolen Shoulders -- 3848
	recipe = AddRecipe(3848, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(110, 110, 135, 152, 170)
	recipe:SetCraftedItem(4314, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_SHOULDER")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 3704, 4159, 4576, 5153, 9584, 11052, 11557, 16366, 16640, 16729, 17487, 18749, 18772, 26914, 26964, 26969, 27001, 28699, 33580, 33613, 33636, 33684, 43428, 44783, 45559, 57405)

	-- Reinforced Woolen Shoulders -- 3849
	recipe = AddRecipe(3849, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(120, 120, 145, 162, 180)
	recipe:SetRecipeItem(4347, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(4315, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_SHOULDER")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Heavy Woolen Pants -- 3850
	recipe = AddRecipe(3850, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(110, 110, 135, 152, 170)
	recipe:SetCraftedItem(4316, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_LEGS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 3704, 4159, 4576, 5153, 9584, 11052, 11557, 16366, 16640, 16729, 17487, 18749, 18772, 26914, 26964, 26969, 27001, 28699, 33580, 33613, 33636, 33684, 43428, 44783, 45559, 57405)

	-- Phoenix Pants -- 3851
	recipe = AddRecipe(3851, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(125, 125, 150, 167, 185)
	recipe:SetRecipeItem(4349, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(4317, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_LEGS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Gloves of Meditation -- 3852
	recipe = AddRecipe(3852, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(130, 130, 150, 165, 180)
	recipe:SetCraftedItem(4318, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HANDS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 3704, 4159, 4576, 5153, 9584, 11052, 11557, 16366, 16640, 16729, 17487, 18749, 18772, 26914, 26964, 26969, 27001, 28699, 33580, 33613, 33636, 33684, 43428, 44783, 45559, 57405)

	-- Azure Silk Gloves -- 3854
	recipe = AddRecipe(3854, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(145, 145, 165, 180, 195)
	recipe:SetRecipeItem(7114, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(4319, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HANDS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddLimitedVendor(2679, 1, 9636, 1)

	-- Spidersilk Boots -- 3855
	recipe = AddRecipe(3855, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(125, 125, 150, 167, 185)
	recipe:SetCraftedItem(4320, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_FEET")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 3704, 4159, 4576, 5153, 9584, 11052, 11557, 16366, 16640, 16729, 17487, 18749, 18772, 26914, 26964, 26969, 27001, 28699, 33580, 33613, 33636, 33684, 43428, 44783, 45559, 57405)

	-- Spider Silk Slippers -- 3856
	recipe = AddRecipe(3856, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(140, 140, 160, 175, 190)
	recipe:SetRecipeItem(4350, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(4321, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_FEET")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Enchanter's Cowl -- 3857
	recipe = AddRecipe(3857, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(165, 165, 185, 200, 215)
	recipe:SetRecipeItem(14630, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(4322, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HEAD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddLimitedVendor(2670, 1)

	-- Shadow Hood -- 3858
	recipe = AddRecipe(3858, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(170, 170, 190, 205, 220)
	recipe:SetRecipeItem(4351, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(4323, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HEAD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Azure Silk Vest -- 3859
	recipe = AddRecipe(3859, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(150, 150, 170, 185, 200)
	recipe:SetCraftedItem(4324, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 3704, 4159, 4576, 5153, 9584, 11052, 11557, 16366, 16640, 16729, 17487, 18749, 18772, 26914, 26964, 26969, 27001, 28699, 33580, 33613, 33636, 33684, 43428, 44783, 45559, 57405)

	-- Boots of the Enchanter -- 3860
	recipe = AddRecipe(3860, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(175, 175, 195, 210, 225)
	recipe:SetRecipeItem(4352, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(4325, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_FEET")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Long Silken Cloak -- 3861
	recipe = AddRecipe(3861, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(185, 185, 205, 220, 235)
	recipe:SetCraftedItem(4326, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BACK")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 3704, 4159, 4576, 5153, 9584, 11052, 11557, 16366, 16640, 16729, 17487, 18749, 18772, 26914, 26964, 26969, 27001, 28699, 33580, 33613, 33636, 33684, 44783, 45559, 57405)

	-- Icy Cloak -- 3862
	recipe = AddRecipe(3862, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(200, 200, 220, 235, 250)
	recipe:SetRecipeItem(4355, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(4327, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BACK")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddLimitedVendor(6567, 1)

	-- Spider Belt -- 3863
	recipe = AddRecipe(3863, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(180, 180, 200, 215, 230)
	recipe:SetRecipeItem(4353, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(4328, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WAIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Star Belt -- 3864
	recipe = AddRecipe(3864, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(200, 200, 220, 235, 250)
	recipe:SetRecipeItem(4356, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(4329, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WAIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Bolt of Mageweave -- 3865
	recipe = AddRecipe(3865, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(175, 175, 180, 182, 185)
	recipe:SetCraftedItem(4339, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_MATERIALS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 3704, 4159, 4576, 5153, 9584, 11052, 11557, 16366, 16640, 16729, 17487, 18749, 18772, 26914, 26964, 26969, 27001, 28699, 33580, 33613, 33636, 33684, 44783, 45559, 57405)

	-- Stylish Red Shirt -- 3866
	recipe = AddRecipe(3866, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(110, 110, 135, 152, 170)
	recipe:SetCraftedItem(4330, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_SHIRT")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 3704, 4159, 4576, 5153, 9584, 11052, 11557, 16366, 16640, 16729, 17487, 18749, 18772, 26914, 26964, 26969, 27001, 28699, 33580, 33613, 33636, 33684, 43428, 44783, 45559, 57405)

	-- Phoenix Gloves -- 3868
	recipe = AddRecipe(3868, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(125, 125, 150, 167, 185)
	recipe:SetRecipeItem(4348, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(4331, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HANDS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Bright Yellow Shirt -- 3869
	recipe = AddRecipe(3869, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(135, 135, 145, 150, 155)
	recipe:SetRecipeItem(14627, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(4332, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_SHIRT")
	recipe:AddFilters(F.ALLIANCE)
	recipe:AddLimitedVendor(2668, 1)

	-- Dark Silk Shirt -- 3870
	recipe = AddRecipe(3870, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(155, 155, 165, 170, 175)
	recipe:SetRecipeItem(6401, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(4333, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_SHIRT")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddLimitedVendor(2394, 1, 2669, 1)

	-- Formal White Shirt -- 3871
	recipe = AddRecipe(3871, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(170, 170, 180, 185, 190)
	recipe:SetCraftedItem(4334, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_SHIRT")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 3704, 4159, 4576, 5153, 9584, 11052, 11557, 16366, 16640, 16729, 17487, 18749, 18772, 26914, 26964, 26969, 27001, 28699, 33580, 33613, 33636, 33684, 44783, 45559, 57405)

	-- Rich Purple Silk Shirt -- 3872
	recipe = AddRecipe(3872, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(185, 185, 195, 200, 205)
	recipe:SetRecipeItem(4354, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(4335, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_SHIRT")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Black Swashbuckler's Shirt -- 3873
	recipe = AddRecipe(3873, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(200, 200, 210, 215, 220)
	recipe:SetRecipeItem(10728, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(4336, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_SHIRT")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddVendor(2663)

	-- Brown Linen Pants -- 3914
	recipe = AddRecipe(3914, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(30, 30, 55, 72, 90)
	recipe:SetCraftedItem(4343, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_LEGS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 3704, 4159, 4576, 5153, 9584, 11052, 11557, 16366, 16640, 16729, 17487, 18749, 18772, 26914, 26964, 26969, 27001, 28699, 33580, 33613, 33636, 33684, 43428, 44783, 45559, 47384, 47396, 47400, 47418, 47419, 47420, 47431, 48619, 57405, 57620, 65043)

	-- Brown Linen Shirt -- 3915
	recipe = AddRecipe(3915, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 35, 47, 60)
	recipe:SetCraftedItem(4344, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_SHIRT")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MISC1)
	recipe:AddCustom("DEFAULT_RECIPE")

	-- Pearl-clasped Cloak -- 6521
	recipe = AddRecipe(6521, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(90, 90, 115, 132, 150)
	recipe:SetCraftedItem(5542, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BACK")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 3704, 4159, 4576, 5153, 9584, 11052, 11557, 16366, 16640, 16729, 17487, 18749, 18772, 26914, 26964, 26969, 27001, 28699, 33580, 33613, 33636, 33684, 43428, 44783, 45559, 57405)

	-- Red Linen Bag -- 6686
	recipe = AddRecipe(6686, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(70, 70, 95, 112, 130)
	recipe:SetRecipeItem(5771, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(5762, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BAG")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.INSTANCE)
	recipe:AddMobDrop(590, 3530, 3531)
	recipe:AddLimitedVendor(843, 1, 3005, 1, 3556, 1, 16224, 1)

	-- Red Woolen Bag -- 6688
	recipe = AddRecipe(6688, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(115, 115, 140, 157, 175)
	recipe:SetRecipeItem(5772, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(5763, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BAG")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddLimitedVendor(777, 1, 1454, 1, 1474, 1, 3005, 1, 3364, 1, 3485, 1, 3537, 1, 4577, 1, 45558, 1)

	-- Lesser Wizard's Robe -- 6690
	recipe = AddRecipe(6690, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(135, 135, 155, 170, 185)
	recipe:SetCraftedItem(5766, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 3704, 4159, 4576, 5153, 9584, 11052, 11557, 16366, 16640, 16729, 17487, 18749, 18772, 26914, 26964, 26969, 27001, 28699, 33580, 33613, 33636, 33684, 43428, 44783, 45559, 57405)

	-- Robes of Arcana -- 6692
	recipe = AddRecipe(6692, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(150, 150, 170, 185, 200)
	recipe:SetRecipeItem(5773, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(5770, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:Retire()

	-- Green Silk Pack -- 6693
	recipe = AddRecipe(6693, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(175, 175, 195, 210, 225)
	recipe:SetRecipeItem(5774, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(5764, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BAG")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Black Silk Pack -- 6695
	recipe = AddRecipe(6695, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(185, 185, 205, 220, 235)
	recipe:SetRecipeItem(5775, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(5765, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BAG")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddMobDrop(2242, 4834)

	-- Brown Linen Robe -- 7623
	recipe = AddRecipe(7623, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(30, 30, 55, 72, 90)
	recipe:SetCraftedItem(6238, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 3704, 4159, 4576, 5153, 9584, 11052, 11557, 16366, 16640, 16729, 17487, 18749, 18772, 26914, 26964, 26969, 27001, 28699, 33580, 33613, 33636, 33684, 43428, 44783, 45559, 47384, 47396, 47400, 47418, 47419, 47420, 47431, 48619, 57405, 57620, 65043)

	-- White Linen Robe -- 7624
	recipe = AddRecipe(7624, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(30, 30, 55, 72, 90)
	recipe:SetCraftedItem(6241, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 3704, 4159, 4576, 5153, 9584, 11052, 11557, 16366, 16640, 16729, 17487, 18749, 18772, 26914, 26964, 26969, 27001, 28699, 33580, 33613, 33636, 33684, 43428, 44783, 45559, 47384, 47396, 47400, 47418, 47419, 47420, 47431, 48619, 57405, 57620, 65043)

	-- Red Linen Vest -- 7629
	recipe = AddRecipe(7629, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(55, 55, 80, 97, 115)
	recipe:SetRecipeItem(6271, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(6239, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Blue Linen Vest -- 7630
	recipe = AddRecipe(7630, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(55, 55, 80, 97, 115)
	recipe:SetRecipeItem(6270, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(6240, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddLimitedVendor(66, 1, 3364, 1, 3485, 1, 3522, 1)

	-- Blue Linen Robe -- 7633
	recipe = AddRecipe(7633, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(70, 70, 95, 112, 130)
	recipe:SetRecipeItem(6272, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(6242, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddLimitedVendor(1250, 1, 3485, 1, 3499, 1, 3556, 1, 4168, 1)

	-- Blue Overalls -- 7639
	recipe = AddRecipe(7639, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 125, 142, 160)
	recipe:SetRecipeItem(6274, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(6263, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddLimitedVendor(843, 1, 1347, 1, 2394, 1, 3364, 1, 45558, 1)

	-- Greater Adept's Robe -- 7643
	recipe = AddRecipe(7643, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(115, 115, 140, 157, 175)
	recipe:SetRecipeItem(6275, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(6264, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddLimitedVendor(1454, 1, 1474, 1, 2669, 1, 3499, 1, 4168, 1, 4577, 1)

	-- Stylish Blue Shirt -- 7892
	recipe = AddRecipe(7892, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(120, 120, 145, 162, 180)
	recipe:SetRecipeItem(6390, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(6384, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_SHIRT")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Stylish Green Shirt -- 7893
	recipe = AddRecipe(7893, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(120, 120, 145, 162, 180)
	recipe:SetRecipeItem(6391, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(6385, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_SHIRT")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Simple Dress -- 8465
	recipe = AddRecipe(8465, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(40, 40, 65, 82, 100)
	recipe:SetCraftedItem(6786, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 3704, 4159, 4576, 5153, 9584, 11052, 11557, 16366, 16640, 16729, 17487, 18749, 18772, 26914, 26964, 26969, 27001, 28699, 33580, 33613, 33636, 33684, 43428, 44783, 45559, 47384, 47396, 47400, 47418, 47419, 47420, 47431, 48619, 57405, 57620, 65043)

	-- White Woolen Dress -- 8467
	recipe = AddRecipe(8467, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(110, 110, 135, 152, 170)
	recipe:SetCraftedItem(6787, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 3704, 4159, 4576, 5153, 9584, 11052, 11557, 16366, 16640, 16729, 17487, 18749, 18772, 26914, 26964, 26969, 27001, 28699, 33580, 33613, 33636, 33684, 43428, 44783, 45559, 57405)

	-- White Swashbuckler's Shirt -- 8483
	recipe = AddRecipe(8483, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(160, 160, 170, 175, 180)
	recipe:SetCraftedItem(6795, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_SHIRT")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 3704, 4159, 4576, 5153, 9584, 11052, 11557, 16366, 16640, 16729, 17487, 18749, 18772, 26914, 26964, 26969, 27001, 28699, 33580, 33613, 33636, 33684, 44783, 45559, 57405)

	-- Red Swashbuckler's Shirt -- 8489
	recipe = AddRecipe(8489, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(175, 175, 185, 190, 195)
	recipe:SetCraftedItem(6796, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_SHIRT")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 3704, 4159, 4576, 5153, 9584, 11052, 11557, 16366, 16640, 16729, 17487, 18749, 18772, 26914, 26964, 26969, 27001, 28699, 33580, 33613, 33636, 33684, 44783, 45559, 57405)

	-- Azure Silk Pants -- 8758
	recipe = AddRecipe(8758, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(140, 140, 160, 175, 190)
	recipe:SetCraftedItem(7046, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_LEGS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 3704, 4159, 4576, 5153, 9584, 11052, 11557, 16366, 16640, 16729, 17487, 18749, 18772, 26914, 26964, 26969, 27001, 28699, 33580, 33613, 33636, 33684, 43428, 44783, 45559, 57405)

	-- Azure Silk Hood -- 8760
	recipe = AddRecipe(8760, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(145, 145, 155, 160, 165)
	recipe:SetCraftedItem(7048, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HEAD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 3704, 4159, 4576, 5153, 9584, 11052, 11557, 16366, 16640, 16729, 17487, 18749, 18772, 26914, 26964, 26969, 27001, 28699, 33580, 33613, 33636, 33684, 43428, 44783, 45559, 57405)

	-- Silk Headband -- 8762
	recipe = AddRecipe(8762, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(160, 160, 170, 175, 180)
	recipe:SetCraftedItem(7050, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HEAD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 3704, 4159, 4576, 5153, 9584, 11052, 11557, 16366, 16640, 16729, 17487, 18749, 18772, 26914, 26964, 26969, 27001, 28699, 33580, 33613, 33636, 33684, 44783, 45559, 57405)

	-- Earthen Vest -- 8764
	recipe = AddRecipe(8764, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(170, 170, 190, 205, 220)
	recipe:SetCraftedItem(7051, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 3704, 4159, 4576, 5153, 9584, 11052, 11557, 16366, 16640, 16729, 17487, 18749, 18772, 26914, 26964, 26969, 27001, 28699, 33580, 33613, 33636, 33684, 44783, 45559, 57405)

	-- Azure Silk Belt -- 8766
	recipe = AddRecipe(8766, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(175, 175, 195, 210, 225)
	recipe:SetCraftedItem(7052, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WAIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 3704, 4159, 4576, 5153, 9584, 11052, 11557, 16366, 16640, 16729, 17487, 18749, 18772, 26914, 26964, 26969, 27001, 28699, 33580, 33613, 33636, 33684, 44783, 45559, 57405)

	-- Robe of Power -- 8770
	recipe = AddRecipe(8770, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(190, 190, 210, 225, 240)
	recipe:SetCraftedItem(7054, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 3704, 4159, 4576, 5153, 9584, 11052, 11557, 16366, 16640, 16729, 17487, 18749, 18772, 26914, 26964, 26969, 27001, 28699, 33580, 33613, 33636, 33684, 44783, 45559, 57405)

	-- Crimson Silk Belt -- 8772
	recipe = AddRecipe(8772, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(175, 175, 195, 210, 225)
	recipe:SetCraftedItem(7055, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WAIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 3704, 4159, 4576, 5153, 9584, 11052, 11557, 16366, 16640, 16729, 17487, 18749, 18772, 26914, 26964, 26969, 27001, 28699, 33580, 33613, 33636, 33684, 44783, 45559, 57405)

	-- Green Silken Shoulders -- 8774
	recipe = AddRecipe(8774, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(180, 180, 200, 215, 230)
	recipe:SetCraftedItem(7057, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_SHOULDER")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 3704, 4159, 4576, 5153, 9584, 11052, 11557, 16366, 16640, 16729, 17487, 18749, 18772, 26914, 26964, 26969, 27001, 28699, 33580, 33613, 33636, 33684, 44783, 45559, 57405)

	-- Linen Belt -- 8776
	recipe = AddRecipe(8776, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(15, 15, 50, 67, 85)
	recipe:SetCraftedItem(7026, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WAIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 3704, 4159, 4576, 5153, 9584, 11052, 11557, 16366, 16640, 16729, 17487, 18749, 18772, 26914, 26964, 26969, 27001, 28699, 33580, 33613, 33636, 33684, 43428, 44783, 45559, 47384, 47396, 47400, 47418, 47419, 47420, 47431, 48619, 57405, 57620, 65043)

	-- Hands of Darkness -- 8780
	recipe = AddRecipe(8780, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(145, 145, 165, 180, 195)
	recipe:SetRecipeItem(7092, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(7047, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HANDS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Truefaith Gloves -- 8782
	recipe = AddRecipe(8782, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(150, 150, 170, 185, 200)
	recipe:SetRecipeItem(7091, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(7049, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HANDS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Green Silk Armor -- 8784
	recipe = AddRecipe(8784, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(165, 165, 185, 200, 215)
	recipe:SetRecipeItem(7090, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(7065, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Azure Silk Cloak -- 8786
	recipe = AddRecipe(8786, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(175, 175, 195, 210, 225)
	recipe:SetRecipeItem(7089, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(7053, "BIND_ON_EQUIP")
	recipe:SetRequiredFaction("Horde")
	recipe:SetItemFilterType("TAILORING_BACK")
	recipe:AddFilters(F.HORDE, F.HEALER, F.CASTER)
	recipe:AddLimitedVendor(6574, 1)

	-- Crimson Silk Cloak -- 8789
	recipe = AddRecipe(8789, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(180, 180, 200, 215, 230)
	recipe:SetRecipeItem(7087, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(7056, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BACK")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddLimitedVendor(2670, 1)

	-- Crimson Silk Vest -- 8791
	recipe = AddRecipe(8791, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(185, 185, 205, 215, 225)
	recipe:SetCraftedItem(7058, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 3704, 4159, 4576, 5153, 9584, 11052, 11557, 16366, 16640, 16729, 17487, 18749, 18772, 26914, 26964, 26969, 27001, 28699, 33580, 33613, 33636, 33684, 44783, 45559, 57405)

	-- Crimson Silk Shoulders -- 8793
	recipe = AddRecipe(8793, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(190, 190, 210, 225, 240)
	recipe:SetRecipeItem(7084, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(7059, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_SHOULDER")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Azure Shoulders -- 8795
	recipe = AddRecipe(8795, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(190, 190, 210, 225, 240)
	recipe:SetRecipeItem(7085, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(7060, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_SHOULDER")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Earthen Silk Belt -- 8797
	recipe = AddRecipe(8797, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(195, 195, 215, 230, 245)
	recipe:SetRecipeItem(7086, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(7061, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WAIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Crimson Silk Pantaloons -- 8799
	recipe = AddRecipe(8799, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(195, 195, 215, 225, 235)
	recipe:SetCraftedItem(7062, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_LEGS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 3704, 4159, 4576, 5153, 9584, 11052, 11557, 16366, 16640, 16729, 17487, 18749, 18772, 26914, 26964, 26969, 27001, 28699, 33580, 33613, 33636, 33684, 44783, 45559, 57405)

	-- Crimson Silk Robe -- 8802
	recipe = AddRecipe(8802, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(205, 205, 220, 235, 250)
	recipe:SetRecipeItem(7088, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(7063, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddLimitedVendor(6568, 1)

	-- Crimson Silk Gloves -- 8804
	recipe = AddRecipe(8804, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(210, 210, 225, 240, 255)
	recipe:SetCraftedItem(7064, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HANDS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 3704, 4159, 4576, 5153, 9584, 11052, 11557, 16366, 16640, 16729, 17487, 18749, 18772, 26914, 26964, 26969, 27001, 28699, 33580, 33613, 33636, 33684, 44783, 45559, 57405)

	-- Simple Linen Pants -- 12044
	recipe = AddRecipe(12044, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 35, 47, 60)
	recipe:SetCraftedItem(10045, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_LEGS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MISC1)
	recipe:AddCustom("DEFAULT_RECIPE")

	-- Simple Linen Boots -- 12045
	recipe = AddRecipe(12045, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(20, 20, 50, 67, 85)
	recipe:SetCraftedItem(10046, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_FEET")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 3704, 4159, 4576, 5153, 9584, 11052, 11557, 16366, 16640, 16729, 17487, 18749, 18772, 26914, 26964, 26969, 27001, 28699, 33580, 33613, 33636, 33684, 43428, 44783, 45559, 47384, 47396, 47400, 47418, 47419, 47420, 47431, 48619, 57405, 57620, 65043)

	-- Simple Kilt -- 12046
	recipe = AddRecipe(12046, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 100, 117, 135)
	recipe:SetCraftedItem(10047, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_LEGS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 3704, 4159, 4576, 5153, 9584, 11052, 11557, 16366, 16640, 16729, 17487, 18749, 18772, 26914, 26964, 26969, 27001, 28699, 33580, 33613, 33636, 33684, 43428, 44783, 45559, 47384, 47396, 47400, 47418, 47419, 47420, 47431, 48619, 57405, 57620, 65043)

	-- Colorful Kilt -- 12047
	recipe = AddRecipe(12047, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(120, 120, 145, 162, 180)
	recipe:SetRecipeItem(10316, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(10048, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_LEGS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Black Mageweave Vest -- 12048
	recipe = AddRecipe(12048, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(205, 205, 220, 235, 250)
	recipe:SetCraftedItem(9998, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 3704, 4159, 4576, 5153, 9584, 11052, 11557, 16366, 16640, 16729, 17487, 18749, 18772, 26914, 26964, 26969, 27001, 28699, 33580, 33613, 33636, 33684, 44783, 45559, 57405)

	-- Black Mageweave Leggings -- 12049
	recipe = AddRecipe(12049, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(205, 205, 220, 235, 250)
	recipe:SetCraftedItem(9999, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_LEGS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 3704, 4159, 4576, 5153, 9584, 11052, 11557, 16366, 16640, 16729, 17487, 18749, 18772, 26914, 26964, 26969, 27001, 28699, 33580, 33613, 33636, 33684, 44783, 45559, 57405)

	-- Black Mageweave Robe -- 12050
	recipe = AddRecipe(12050, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(210, 210, 225, 240, 255)
	recipe:SetCraftedItem(10001, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 3704, 4159, 4576, 5153, 9584, 11052, 11557, 16366, 16640, 16729, 17487, 18749, 18772, 26914, 26964, 26969, 27001, 28699, 33580, 33613, 33636, 33684, 44783, 45559, 57405)

	-- Shadoweave Pants -- 12052
	recipe = AddRecipe(12052, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(210, 210, 225, 240, 255)
	recipe:SetCraftedItem(10002, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_LEGS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddTrainer(1346, 2399, 3004, 3363, 3523, 4159, 4576, 4578, 5153, 9584, 11052, 16729, 17487, 18772, 26914, 27001, 33580, 33613, 33636, 44783, 45559, 57405)

	-- Black Mageweave Gloves -- 12053
	recipe = AddRecipe(12053, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(215, 215, 230, 245, 260)
	recipe:SetCraftedItem(10003, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HANDS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 3704, 4159, 4576, 5153, 9584, 11052, 11557, 16366, 16640, 16729, 17487, 18749, 18772, 26914, 26964, 26969, 27001, 28699, 33580, 33613, 33636, 33684, 44783, 45559, 57405)

	-- Shadoweave Robe -- 12055
	recipe = AddRecipe(12055, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(215, 215, 230, 245, 260)
	recipe:SetCraftedItem(10004, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddTrainer(1346, 2399, 3004, 3363, 3523, 4159, 4576, 4578, 5153, 9584, 11052, 16729, 17487, 18772, 26914, 27001, 33580, 33613, 33636, 44783, 45559, 57405)

	-- Red Mageweave Vest -- 12056
	recipe = AddRecipe(12056, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(215, 215, 230, 245, 260)
	recipe:SetRecipeItem(10300, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(10007, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- White Bandit Mask -- 12059
	recipe = AddRecipe(12059, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(215, 215, 220, 225, 230)
	recipe:SetRecipeItem(10301, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(10008, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HEAD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Red Mageweave Pants -- 12060
	recipe = AddRecipe(12060, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(215, 215, 230, 245, 260)
	recipe:SetRecipeItem(10302, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(10009, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_LEGS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Orange Mageweave Shirt -- 12061
	recipe = AddRecipe(12061, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(215, 215, 220, 225, 230)
	recipe:SetCraftedItem(10056, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_SHIRT")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 3704, 4159, 4576, 5153, 9584, 11052, 11557, 16366, 16640, 16729, 17487, 18749, 18772, 26914, 26964, 26969, 27001, 28699, 33580, 33613, 33636, 33684, 44783, 45559, 57405)

	-- Orange Martial Shirt -- 12064
	recipe = AddRecipe(12064, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(220, 220, 225, 230, 235)
	recipe:SetRecipeItem(10311, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(10052, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_SHIRT")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddLimitedVendor(3005, 1, 4168, 1)

	-- Mageweave Bag -- 12065
	recipe = AddRecipe(12065, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(225, 225, 240, 255, 270)
	recipe:SetCraftedItem(10050, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BAG")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 3704, 4159, 4576, 5153, 9584, 11052, 11557, 16366, 16640, 16729, 17487, 18749, 18772, 26914, 26964, 26969, 27001, 28699, 33580, 33613, 33636, 33684, 44783, 45559, 57405)

	-- Red Mageweave Gloves -- 12066
	recipe = AddRecipe(12066, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(225, 225, 240, 255, 270)
	recipe:SetRecipeItem(10312, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(10018, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HANDS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Dreamweave Gloves -- 12067
	recipe = AddRecipe(12067, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(225, 225, 240, 255, 270)
	recipe:SetCraftedItem(10019, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HANDS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 3704, 4159, 4576, 5153, 9584, 11052, 11557, 16366, 16640, 16729, 17487, 18749, 18772, 26914, 26964, 26969, 27001, 28699, 33580, 33613, 33636, 33684, 44783, 45559, 57405)

	-- Cindercloth Robe -- 12069
	recipe = AddRecipe(12069, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(225, 225, 240, 255, 270)
	recipe:SetCraftedItem(10042, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 3704, 4159, 4576, 5153, 9584, 11052, 11557, 16366, 16640, 16729, 17487, 18749, 18772, 26914, 26964, 26969, 27001, 28699, 33580, 33613, 33636, 33684, 44783, 45559, 57405)

	-- Dreamweave Vest -- 12070
	recipe = AddRecipe(12070, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(225, 225, 240, 255, 270)
	recipe:SetCraftedItem(10021, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 3704, 4159, 4576, 5153, 9584, 11052, 11557, 16366, 16640, 16729, 17487, 18749, 18772, 26914, 26964, 26969, 27001, 28699, 33580, 33613, 33636, 33684, 44783, 45559, 57405)

	-- Shadoweave Gloves -- 12071
	recipe = AddRecipe(12071, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(225, 225, 240, 255, 270)
	recipe:SetCraftedItem(10023, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HANDS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddTrainer(1346, 2399, 3004, 3363, 3523, 4159, 4576, 4578, 5153, 9584, 11052, 16729, 17487, 18772, 26914, 27001, 33580, 33613, 33636, 44783, 45559, 57405)

	-- Black Mageweave Headband -- 12072
	recipe = AddRecipe(12072, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(230, 230, 245, 260, 275)
	recipe:SetCraftedItem(10024, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HEAD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 3704, 4159, 4576, 5153, 9584, 11052, 11557, 16366, 16640, 16729, 17487, 18749, 18772, 26914, 26964, 26969, 27001, 28699, 33580, 33613, 33636, 33684, 44783, 45559, 57405)

	-- Black Mageweave Boots -- 12073
	recipe = AddRecipe(12073, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(230, 230, 245, 260, 275)
	recipe:SetCraftedItem(10026, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_FEET")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 3704, 4159, 4576, 5153, 9584, 11052, 11557, 16366, 16640, 16729, 17487, 18749, 18772, 26914, 26964, 26969, 27001, 28699, 33580, 33613, 33636, 33684, 44783, 45559, 57405)

	-- Black Mageweave Shoulders -- 12074
	recipe = AddRecipe(12074, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(230, 230, 245, 260, 275)
	recipe:SetCraftedItem(10027, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_SHOULDER")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 3704, 4159, 4576, 5153, 9584, 11052, 11557, 16366, 16640, 16729, 17487, 18749, 18772, 26914, 26964, 26969, 27001, 28699, 33580, 33613, 33636, 33684, 44783, 45559, 57405)

	-- Lavender Mageweave Shirt -- 12075
	recipe = AddRecipe(12075, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(230, 230, 235, 240, 245)
	recipe:SetRecipeItem(10314, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(10054, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_SHIRT")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddLimitedVendor(3364, 1, 8681, 1, 45558, 1)

	-- Shadoweave Shoulders -- 12076
	recipe = AddRecipe(12076, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(235, 235, 250, 265, 280)
	recipe:SetCraftedItem(10028, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_SHOULDER")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddTrainer(1346, 2399, 3004, 3363, 3523, 4159, 4576, 4578, 5153, 9584, 11052, 16729, 17487, 18772, 26914, 27001, 33580, 33613, 33636, 44783, 45559, 57405)

	-- Simple Black Dress -- 12077
	recipe = AddRecipe(12077, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(235, 235, 240, 245, 250)
	recipe:SetCraftedItem(10053, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 3704, 4159, 4576, 5153, 9584, 11052, 11557, 16366, 16640, 16729, 17487, 18749, 18772, 26914, 26964, 26969, 27001, 28699, 33580, 33613, 33636, 33684, 44783, 45559, 57405)

	-- Red Mageweave Shoulders -- 12078
	recipe = AddRecipe(12078, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(235, 235, 250, 265, 280)
	recipe:SetRecipeItem(10315, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(10029, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_SHOULDER")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Red Mageweave Bag -- 12079
	recipe = AddRecipe(12079, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(235, 235, 250, 265, 280)
	recipe:SetCraftedItem(10051, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BAG")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 3704, 4159, 4576, 5153, 9584, 11052, 11557, 16366, 16640, 16729, 17487, 18749, 18772, 26914, 26964, 26969, 27001, 28699, 33580, 33613, 33636, 44783, 45559, 57405)

	-- Pink Mageweave Shirt -- 12080
	recipe = AddRecipe(12080, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(235, 235, 240, 245, 250)
	recipe:SetRecipeItem(10317, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(10055, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_SHIRT")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddLimitedVendor(3364, 1, 8681, 1, 45558, 1)

	-- Admiral's Hat -- 12081
	recipe = AddRecipe(12081, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(240, 240, 255, 270, 285)
	recipe:SetRecipeItem(10318, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(10030, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HEAD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
	recipe:AddLimitedVendor(2672, 1)

	-- Shadoweave Boots -- 12082
	recipe = AddRecipe(12082, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(240, 240, 255, 270, 285)
	recipe:SetCraftedItem(10031, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_FEET")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddTrainer(1346, 2399, 3004, 3363, 3523, 4159, 4576, 4578, 5153, 9584, 11052, 16729, 17487, 18772, 26914, 27001, 33580, 33613, 33636, 44783, 45559, 57405)

	-- Red Mageweave Headband -- 12084
	recipe = AddRecipe(12084, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(240, 240, 255, 270, 285)
	recipe:SetRecipeItem(10320, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(10033, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HEAD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Tuxedo Shirt -- 12085
	recipe = AddRecipe(12085, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(240, 240, 245, 250, 255)
	recipe:SetRecipeItem(10321, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(10034, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_SHIRT")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddLimitedVendor(4577, 1, 8681, 1)

	-- Shadoweave Mask -- 12086
	recipe = AddRecipe(12086, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(245, 245, 260, 275, 290)
	recipe:SetRecipeItem(10463, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(10025, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HEAD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:Retire()

	-- Cindercloth Boots -- 12088
	recipe = AddRecipe(12088, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(245, 245, 260, 275, 290)
	recipe:SetCraftedItem(10044, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_FEET")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 3704, 4159, 4576, 5153, 9584, 11052, 11557, 16366, 16640, 16729, 17487, 18749, 18772, 26914, 26964, 26969, 27001, 28699, 33580, 33613, 33636, 33684, 44783, 45559, 57405)

	-- Tuxedo Pants -- 12089
	recipe = AddRecipe(12089, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(245, 245, 250, 255, 260)
	recipe:SetRecipeItem(10323, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(10035, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_LEGS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddLimitedVendor(4577, 1, 8681, 1)

	-- White Wedding Dress -- 12091
	recipe = AddRecipe(12091, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(250, 250, 255, 260, 265)
	recipe:SetRecipeItem(10325, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(10040, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddLimitedVendor(1347, 1, 3005, 1)

	-- Dreamweave Circlet -- 12092
	recipe = AddRecipe(12092, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(250, 250, 265, 280, 295)
	recipe:SetCraftedItem(10041, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HEAD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 3704, 4159, 4576, 5153, 9584, 11052, 11557, 16366, 16640, 16729, 17487, 18749, 18772, 26914, 26964, 26969, 27001, 28699, 33580, 33613, 33636, 33684, 44783, 45559, 57405)

	-- Tuxedo Jacket -- 12093
	recipe = AddRecipe(12093, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(250, 250, 265, 280, 295)
	recipe:SetRecipeItem(10326, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(10036, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddLimitedVendor(4577, 1, 8681, 1)

	-- Bolt of Runecloth -- 18401
	recipe = AddRecipe(18401, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(250, 250, 255, 257, 260)
	recipe:SetCraftedItem(14048, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_MATERIALS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 3704, 4159, 4576, 5153, 9584, 11052, 11557, 16366, 16640, 16729, 17487, 18749, 18772, 26914, 26964, 26969, 27001, 28699, 33580, 33613, 33636, 33684, 44783, 45559, 57405)

	-- Runecloth Belt -- 18402
	recipe = AddRecipe(18402, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(255, 255, 270, 285, 300)
	recipe:SetCraftedItem(13856, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WAIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 3704, 4159, 4576, 5153, 9584, 11052, 11557, 16366, 16640, 16729, 17487, 18749, 18772, 26914, 26964, 26969, 27001, 28699, 33580, 33613, 33636, 33684, 44783, 45559, 57405)

	-- Frostweave Tunic -- 18403
	recipe = AddRecipe(18403, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(255, 255, 270, 285, 300)
	recipe:SetCraftedItem(13869, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 3704, 4159, 4576, 5153, 9584, 11052, 11557, 16366, 16640, 16729, 17487, 18749, 18772, 26914, 26964, 26969, 27001, 28699, 33580, 33613, 33636, 33684, 44783, 45559, 57405)

	-- Frostweave Robe -- 18404
	recipe = AddRecipe(18404, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(255, 255, 270, 285, 300)
	recipe:SetRecipeItem(14467, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(13868, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Runecloth Bag -- 18405
	recipe = AddRecipe(18405, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(260, 260, 275, 290, 305)
	recipe:SetRecipeItem(14468, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(14046, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BAG")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddVendor(11189)

	-- Runecloth Robe -- 18406
	recipe = AddRecipe(18406, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(260, 260, 275, 290, 305)
	recipe:SetRecipeItem(14469, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(13858, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 3704, 4159, 4576, 5153, 9584, 11052, 11557, 16366, 16640, 16729, 17487, 18749, 18772, 26914, 26964, 26969, 27001, 28699, 33580, 33613, 33636, 33684, 44783, 45559, 57405)
	recipe:AddLimitedVendor(7940, 1)

	-- Runecloth Tunic -- 18407
	recipe = AddRecipe(18407, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(260, 260, 275, 290, 305)
	recipe:SetCraftedItem(13857, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 3704, 4159, 4576, 5153, 9584, 11052, 11557, 16366, 16640, 16729, 17487, 18749, 18772, 26914, 26964, 26969, 27001, 28699, 33580, 33613, 33636, 33684, 44783, 45559, 57405)

	-- Cindercloth Vest -- 18408
	recipe = AddRecipe(18408, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(260, 260, 275, 290, 305)
	recipe:SetRecipeItem(14471, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(14042, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddMobDrop(5861)

	-- Runecloth Cloak -- 18409
	recipe = AddRecipe(18409, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(265, 265, 280, 295, 310)
	recipe:SetRecipeItem(14472, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(13860, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BACK")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 3704, 4159, 4576, 5153, 9584, 11052, 11557, 16366, 16640, 16729, 17487, 18749, 18772, 26914, 26964, 26969, 27001, 28699, 33580, 33613, 33636, 33684, 44783, 45559, 57405)
	recipe:AddLimitedVendor(7940, 1)

	-- Ghostweave Belt -- 18410
	recipe = AddRecipe(18410, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(265, 265, 280, 295, 310)
	recipe:SetCraftedItem(14143, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WAIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 3704, 4159, 4576, 5153, 9584, 11052, 11557, 16366, 16640, 16729, 17487, 18749, 18772, 26914, 26964, 26969, 27001, 28699, 33580, 33613, 33636, 33684, 44783, 45559, 57405)

	-- Frostweave Gloves -- 18411
	recipe = AddRecipe(18411, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(265, 265, 280, 295, 310)
	recipe:SetCraftedItem(13870, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HANDS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 3704, 4159, 4576, 5153, 9584, 11052, 11557, 16366, 16640, 16729, 17487, 18749, 18772, 26914, 26964, 26969, 27001, 28699, 33580, 33613, 33636, 33684, 44783, 45559, 57405)

	-- Cindercloth Gloves -- 18412
	recipe = AddRecipe(18412, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(270, 270, 285, 300, 315)
	recipe:SetRecipeItem(14476, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(14043, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HANDS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddMobDrop(5861)

	-- Ghostweave Gloves -- 18413
	recipe = AddRecipe(18413, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(270, 270, 285, 300, 315)
	recipe:SetCraftedItem(14142, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HANDS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 3704, 4159, 4576, 5153, 9584, 11052, 11557, 16366, 16640, 16729, 17487, 18749, 18772, 26914, 26964, 26969, 27001, 28699, 33580, 33613, 33636, 33684, 44783, 45559, 57405)

	-- Brightcloth Robe -- 18414
	recipe = AddRecipe(18414, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(270, 270, 285, 300, 315)
	recipe:SetCraftedItem(14100, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 3704, 4159, 4576, 5153, 9584, 11052, 11557, 16366, 16640, 16729, 17487, 18749, 18772, 26914, 26964, 26969, 27001, 28699, 33580, 33613, 33636, 33684, 44783, 45559, 57405)

	-- Brightcloth Gloves -- 18415
	recipe = AddRecipe(18415, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(270, 270, 285, 300, 315)
	recipe:SetCraftedItem(14101, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HANDS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 3704, 4159, 4576, 5153, 9584, 11052, 11557, 16366, 16640, 16729, 17487, 18749, 18772, 26914, 26964, 26969, 27001, 28699, 33580, 33613, 33636, 33684, 44783, 45559, 57405)

	-- Ghostweave Vest -- 18416
	recipe = AddRecipe(18416, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(275, 275, 290, 305, 320)
	recipe:SetCraftedItem(14141, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 3704, 4159, 4576, 5153, 9584, 11052, 11557, 16366, 16640, 16729, 17487, 18749, 18772, 26914, 26964, 26969, 27001, 28699, 33580, 33613, 33636, 33684, 44783, 45559, 57405)

	-- Runecloth Gloves -- 18417
	recipe = AddRecipe(18417, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(275, 275, 290, 305, 320)
	recipe:SetCraftedItem(13863, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HANDS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 3704, 4159, 4576, 5153, 9584, 11052, 11557, 16366, 16640, 16729, 17487, 18749, 18772, 26914, 26964, 26969, 27001, 28699, 33580, 33613, 33636, 33684, 44783, 45559, 57405)

	-- Cindercloth Cloak -- 18418
	recipe = AddRecipe(18418, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(275, 275, 290, 305, 320)
	recipe:SetRecipeItem(14482, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(14044, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BACK")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddMobDrop(7037)

	-- Felcloth Pants -- 18419
	recipe = AddRecipe(18419, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(275, 275, 290, 305, 320)
	recipe:SetRecipeItem(14483, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(14107, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_LEGS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddLimitedVendor(12022, 1)

	-- Brightcloth Cloak -- 18420
	recipe = AddRecipe(18420, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(275, 275, 290, 305, 320)
	recipe:SetCraftedItem(14103, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BACK")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 3704, 4159, 4576, 5153, 9584, 11052, 11557, 16366, 16640, 16729, 17487, 18749, 18772, 26914, 26964, 26969, 27001, 28699, 33580, 33613, 33636, 33684, 44783, 45559, 57405)

	-- Wizardweave Leggings -- 18421
	recipe = AddRecipe(18421, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(275, 275, 290, 305, 320)
	recipe:SetCraftedItem(14132, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_LEGS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 3704, 4159, 4576, 5153, 9584, 11052, 11557, 16366, 16640, 16729, 17487, 18749, 18772, 26914, 26964, 26969, 27001, 28699, 33580, 33613, 33636, 33684, 44783, 45559, 57405)

	-- Cloak of Fire -- 18422
	recipe = AddRecipe(18422, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(275, 275, 290, 305, 320)
	recipe:SetRecipeItem(14486, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(14134, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BACK")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.INSTANCE)
	recipe:AddMobDrop(9026)

	-- Runecloth Boots -- 18423
	recipe = AddRecipe(18423, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(280, 280, 295, 310, 325)
	recipe:SetCraftedItem(13864, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_FEET")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 3704, 4159, 4576, 5153, 9584, 11052, 11557, 16366, 16640, 16729, 17487, 18749, 18772, 26914, 26964, 26969, 27001, 28699, 33580, 33613, 33636, 33684, 44783, 45559, 57405)

	-- Frostweave Pants -- 18424
	recipe = AddRecipe(18424, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(280, 280, 295, 310, 325)
	recipe:SetCraftedItem(13871, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_LEGS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 3704, 4159, 4576, 5153, 9584, 11052, 11557, 16366, 16640, 16729, 17487, 18749, 18772, 26914, 26964, 26969, 27001, 28699, 33580, 33613, 33636, 33684, 44783, 45559, 57405)

	-- Cindercloth Pants -- 18434
	recipe = AddRecipe(18434, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(280, 280, 295, 310, 325)
	recipe:SetRecipeItem(14490, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(14045, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_LEGS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddMobDrop(7037)

	-- Robe of Winter Night -- 18436
	recipe = AddRecipe(18436, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(285, 285, 300, 315, 330)
	recipe:SetRecipeItem(14493, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(14136, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:Retire()

	-- Felcloth Boots -- 18437
	recipe = AddRecipe(18437, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(285, 285, 300, 315, 330)
	recipe:SetCraftedItem(14108, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_FEET")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 3704, 4159, 4576, 5153, 9584, 11052, 11557, 16366, 16640, 16729, 17487, 18749, 18772, 26914, 26964, 26969, 27001, 28699, 33580, 33613, 33636, 33684, 44783, 45559, 57405)

	-- Runecloth Pants -- 18438
	recipe = AddRecipe(18438, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(285, 285, 300, 315, 330)
	recipe:SetRecipeItem(14491, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(13865, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_LEGS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 3704, 4159, 4576, 5153, 9584, 11052, 11557, 16366, 16640, 16729, 17487, 18749, 18772, 26914, 26964, 26969, 27001, 28699, 33580, 33613, 33636, 33684, 44783, 45559, 57405)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Brightcloth Pants -- 18439
	recipe = AddRecipe(18439, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(290, 290, 305, 320, 335)
	recipe:SetRecipeItem(14494, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(14104, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_LEGS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Mooncloth Leggings -- 18440
	recipe = AddRecipe(18440, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(290, 290, 305, 320, 335)
	recipe:SetRecipeItem(14497, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(14137, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_LEGS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Ghostweave Pants -- 18441
	recipe = AddRecipe(18441, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(290, 290, 305, 320, 335)
	recipe:SetCraftedItem(14144, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_LEGS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 3704, 4159, 4576, 5153, 9584, 11052, 11557, 16366, 16640, 16729, 17487, 18749, 18772, 26914, 26964, 26969, 27001, 28699, 33580, 33613, 33636, 33684, 44783, 45559, 57405)

	-- Felcloth Hood -- 18442
	recipe = AddRecipe(18442, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(290, 290, 305, 320, 335)
	recipe:SetCraftedItem(14111, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HEAD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 3704, 4159, 4576, 5153, 9584, 11052, 11557, 16366, 16640, 16729, 17487, 18749, 18772, 26914, 26964, 26969, 27001, 28699, 33580, 33613, 33636, 33684, 44783, 45559, 57405)

	-- Runecloth Headband -- 18444
	recipe = AddRecipe(18444, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(295, 295, 310, 325, 340)
	recipe:SetCraftedItem(13866, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HEAD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 3704, 4159, 4576, 5153, 9584, 11052, 11557, 16366, 16640, 16729, 17487, 18749, 18772, 26914, 26964, 26969, 27001, 28699, 33580, 33613, 33636, 33684, 44783, 45559, 57405)

	-- Mooncloth Bag -- 18445
	recipe = AddRecipe(18445, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(300, 300, 315, 330, 345)
	recipe:SetRecipeItem(14499, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(14155, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BAG")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Wizardweave Robe -- 18446
	recipe = AddRecipe(18446, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 315, 330, 345)
	recipe:SetCraftedItem(14128, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 3704, 4159, 4576, 5153, 9584, 11052, 11557, 16366, 16640, 16729, 17487, 18749, 18772, 26914, 26964, 26969, 27001, 28699, 33580, 33613, 33636, 33684, 44783, 45559, 57405)

	-- Mooncloth Vest -- 18447
	recipe = AddRecipe(18447, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(300, 300, 315, 330, 345)
	recipe:SetRecipeItem(14501, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(14138, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Mooncloth Shoulders -- 18448
	recipe = AddRecipe(18448, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(300, 300, 315, 330, 345)
	recipe:SetRecipeItem(14507, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(14139, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_SHOULDER")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Runecloth Shoulders -- 18449
	recipe = AddRecipe(18449, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 315, 330, 345)
	recipe:SetCraftedItem(13867, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_SHOULDER")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 3704, 4159, 4576, 5153, 9584, 11052, 11557, 16366, 16640, 16729, 17487, 18749, 18772, 26914, 26964, 26969, 27001, 28699, 33580, 33613, 33636, 33684, 44783, 45559, 57405)

	-- Wizardweave Turban -- 18450
	recipe = AddRecipe(18450, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 315, 330, 345)
	recipe:SetCraftedItem(14130, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HEAD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 3704, 4159, 4576, 5153, 9584, 11052, 11557, 16366, 16640, 16729, 17487, 18749, 18772, 26914, 26964, 26969, 27001, 28699, 33580, 33613, 33636, 33684, 44783, 45559, 57405)

	-- Felcloth Robe -- 18451
	recipe = AddRecipe(18451, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 315, 330, 345)
	recipe:SetCraftedItem(14106, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 3704, 4159, 4576, 5153, 9584, 11052, 11557, 16366, 16640, 16729, 17487, 18749, 18772, 26914, 26964, 26969, 27001, 28699, 33580, 33613, 33636, 33684, 44783, 45559, 57405)

	-- Mooncloth Circlet -- 18452
	recipe = AddRecipe(18452, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(300, 300, 315, 330, 345)
	recipe:SetRecipeItem(14509, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(14140, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HEAD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Felcloth Shoulders -- 18453
	recipe = AddRecipe(18453, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 315, 330, 345)
	recipe:SetCraftedItem(14112, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_SHOULDER")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 3704, 4159, 4576, 5153, 9584, 11052, 11557, 16366, 16640, 16729, 17487, 18749, 18772, 26914, 26964, 26969, 27001, 28699, 33580, 33613, 33636, 33684, 44783, 45559, 57405)

	-- Gloves of Spell Mastery -- 18454
	recipe = AddRecipe(18454, V.ORIG, Q.EPIC)
	recipe:SetSkillLevels(300, 300, 315, 330, 345)
	recipe:SetRecipeItem(14511, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(14146, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HANDS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER, F.MAGE, F.PRIEST, F.WARLOCK)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Bottomless Bag -- 18455
	recipe = AddRecipe(18455, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(300, 300, 315, 330, 345)
	recipe:SetRecipeItem(14510, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(14156, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BAG")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Truefaith Vestments -- 18456
	recipe = AddRecipe(18456, V.ORIG, Q.EPIC)
	recipe:SetSkillLevels(300, 300, 315, 330, 345)
	recipe:SetRecipeItem(14512, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(14154, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.INSTANCE, F.HEALER, F.CASTER, F.PRIEST)
	recipe:AddMobDrop(10813)

	-- Robe of the Archmage -- 18457
	recipe = AddRecipe(18457, V.ORIG, Q.EPIC)
	recipe:SetSkillLevels(300, 300, 315, 330, 345)
	recipe:SetRecipeItem(14513, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(14152, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.INSTANCE, F.DPS, F.HEALER, F.CASTER)
	recipe:AddMobDrop(9264)

	-- Robe of the Void -- 18458
	recipe = AddRecipe(18458, V.ORIG, Q.EPIC)
	recipe:SetSkillLevels(300, 300, 315, 330, 345)
	recipe:SetRecipeItem(14514, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(14153, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:Retire()

	-- Mooncloth -- 18560
	recipe = AddRecipe(18560, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(250, 250, 290, 305, 320)
	recipe:SetRecipeItem(14526, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(14342, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_MATERIALS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddVendor(11189)

	-- Mooncloth Boots -- 19435
	recipe = AddRecipe(19435, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(290, 290, 295, 310, 325)
	recipe:SetCraftedItem(15802, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_FEET")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddQuest(6032)

	-- Flarecore Mantle -- 20848
	recipe = AddRecipe(20848, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 315, 330, 345)
	recipe:SetRecipeItem(17017, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(16980, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_SHOULDER")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER, F.THORIUM_BROTHERHOOD)
	recipe:AddRepVendor(FAC.THORIUM_BROTHERHOOD, REP.HONORED, 12944)

	-- Flarecore Gloves -- 20849
	recipe = AddRecipe(20849, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 315, 330, 345)
	recipe:SetRecipeItem(17018, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(16979, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HANDS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER, F.MAGE, F.PRIEST, F.WARLOCK, F.THORIUM_BROTHERHOOD)
	recipe:AddRepVendor(FAC.THORIUM_BROTHERHOOD, REP.FRIENDLY, 12944)

	-- Green Holiday Shirt -- 21945
	recipe = AddRecipe(21945, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(190, 190, 200, 205, 210)
	recipe:SetRecipeItem(17724, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(17723, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_SHIRT")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddWorldEvent("WINTER_VEIL")

	-- Flarecore Wraps -- 22759
	recipe = AddRecipe(22759, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(300, 300, 320, 335, 350)
	recipe:SetRecipeItem(18265, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(18263, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WRIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.RAID, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.MOLTEN_CORE)

	-- Gordok Ogre Suit -- 22813
	recipe = AddRecipe(22813, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(275, 275, 285, 290, 295)
	recipe:SetCraftedItem(18258, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_MISC")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:Retire()

	-- Belt of the Archmage -- 22866
	recipe = AddRecipe(22866, V.ORIG, Q.EPIC)
	recipe:SetSkillLevels(300, 300, 315, 330, 345)
	recipe:SetRecipeItem(18414, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(18405, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WAIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
	recipe:Retire()

	-- Felcloth Gloves -- 22867
	recipe = AddRecipe(22867, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(300, 300, 315, 330, 345)
	recipe:SetRecipeItem(18415, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(18407, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HANDS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:Retire()

	-- Inferno Gloves -- 22868
	recipe = AddRecipe(22868, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(300, 300, 315, 330, 345)
	recipe:SetRecipeItem(18416, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(18408, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HANDS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:Retire()

	-- Mooncloth Gloves -- 22869
	recipe = AddRecipe(22869, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(300, 300, 315, 330, 345)
	recipe:SetRecipeItem(18417, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(18409, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HANDS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:Retire()

	-- Cloak of Warding -- 22870
	recipe = AddRecipe(22870, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(300, 300, 315, 330, 345)
	recipe:SetRecipeItem(18418, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(18413, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BACK")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.TANK)
	recipe:Retire()

	-- Mooncloth Robe -- 22902
	recipe = AddRecipe(22902, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 315, 330, 345)
	recipe:SetRecipeItem(18487, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(18486, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddLimitedVendor(14371, 1)

	-- Wisdom of the Timbermaw -- 23662
	recipe = AddRecipe(23662, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(290, 290, 305, 320, 335)
	recipe:SetRecipeItem(19215, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(19047, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WAIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER, F.TIMBERMAW_HOLD)
	recipe:AddRepVendor(FAC.TIMBERMAW_HOLD, REP.HONORED, 11557)

	-- Mantle of the Timbermaw -- 23663
	recipe = AddRecipe(23663, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 315, 330, 345)
	recipe:SetRecipeItem(19218, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(19050, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_SHOULDER")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER, F.TIMBERMAW_HOLD)
	recipe:AddRepVendor(FAC.TIMBERMAW_HOLD, REP.REVERED, 11557)

	-- Argent Boots -- 23664
	recipe = AddRecipe(23664, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(290, 290, 305, 320, 335)
	recipe:SetRecipeItem(19216, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(19056, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_FEET")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER, F.ARGENTDAWN)
	recipe:AddRepVendor(FAC.ARGENT_DAWN, REP.HONORED, 10856, 10857, 11536)

	-- Argent Shoulders -- 23665
	recipe = AddRecipe(23665, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 315, 330, 345)
	recipe:SetRecipeItem(19217, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(19059, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_SHOULDER")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER, F.ARGENTDAWN)
	recipe:AddRepVendor(FAC.ARGENT_DAWN, REP.REVERED, 10856, 10857, 11536)

	-- Flarecore Robe -- 23666
	recipe = AddRecipe(23666, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 315, 330, 345)
	recipe:SetRecipeItem(19219, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(19156, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER, F.THORIUM_BROTHERHOOD)
	recipe:AddRepVendor(FAC.THORIUM_BROTHERHOOD, REP.HONORED, 12944)

	-- Flarecore Leggings -- 23667
	recipe = AddRecipe(23667, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 315, 330, 345)
	recipe:SetRecipeItem(19220, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(19165, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_LEGS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER, F.THORIUM_BROTHERHOOD)
	recipe:AddRepVendor(FAC.THORIUM_BROTHERHOOD, REP.REVERED, 12944)

	-- Bloodvine Vest -- 24091
	recipe = AddRecipe(24091, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 315, 330, 345)
	recipe:SetRecipeItem(19764, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(19682, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
	recipe:Retire()

	-- Bloodvine Leggings -- 24092
	recipe = AddRecipe(24092, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 315, 330, 345)
	recipe:SetRecipeItem(19765, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(19683, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_LEGS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
	recipe:Retire()

	-- Bloodvine Boots -- 24093
	recipe = AddRecipe(24093, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 315, 330, 345)
	recipe:SetRecipeItem(19766, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(19684, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_FEET")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
	recipe:Retire()

	-- Runed Stygian Leggings -- 24901
	recipe = AddRecipe(24901, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(300, 300, 315, 330, 345)
	recipe:SetRecipeItem(20546, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(20538, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_LEGS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddQuest(8323)

	-- Runed Stygian Belt -- 24902
	recipe = AddRecipe(24902, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(300, 300, 315, 330, 345)
	recipe:SetRecipeItem(20548, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(20539, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WAIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddQuest(8323)

	-- Runed Stygian Boots -- 24903
	recipe = AddRecipe(24903, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(300, 300, 315, 330, 345)
	recipe:SetRecipeItem(20547, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(20537, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_FEET")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddQuest(8323)

	-- Soul Pouch -- 26085
	recipe = AddRecipe(26085, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(260, 260, 275, 290, 305)
	recipe:SetRecipeItem(21358, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(21340, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BAG")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddVendor(6568)

	-- Felcloth Bag -- 26086
	recipe = AddRecipe(26086, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(280, 280, 300, 315, 330)
	recipe:SetCraftedItem(21341, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BAG")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARLOCK)
	recipe:Retire()

	-- Core Felcloth Bag -- 26087
	recipe = AddRecipe(26087, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(300, 300, 315, 330, 345)
	recipe:SetRecipeItem(21371, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(21342, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BAG")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.RAID, F.WARLOCK)
	recipe:AddWorldDrop(Z.MOLTEN_CORE)

	-- Festival Dress -- 26403
	recipe = AddRecipe(26403, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(250, 250, 265, 280, 295)
	recipe:SetRecipeItem(44916, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(21154, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddVendor(15909)
	recipe:AddWorldEvent("LUNAR_FESTIVAL")

	-- Festival Suit -- 26407
	recipe = AddRecipe(26407, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(250, 250, 265, 280, 295)
	recipe:SetRecipeItem(44917, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(21542, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddVendor(15909)
	recipe:AddWorldEvent("LUNAR_FESTIVAL")

	-- Enchanted Runecloth Bag -- 27659
	recipe = AddRecipe(27659, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(275, 275, 290, 305, 320)
	recipe:SetRecipeItem(22308, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(22248, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BAG")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddVendor(15419)

	-- Big Bag of Enchantment -- 27660
	recipe = AddRecipe(27660, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(300, 300, 315, 330, 345)
	recipe:SetRecipeItem(22309, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(22249, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BAG")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.INSTANCE)
	recipe:AddMobDrop(11487)

	-- Cenarion Herb Bag -- 27724
	recipe = AddRecipe(27724, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(275, 275, 290, 305, 320)
	recipe:SetRecipeItem(22310, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(22251, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BAG")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.CENARION_CIRCLE)
	recipe:AddRepVendor(FAC.CENARION_CIRCLE, REP.FRIENDLY, 15179)

	-- Satchel of Cenarius -- 27725
	recipe = AddRecipe(27725, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 315, 330, 345)
	recipe:SetRecipeItem(22312, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(22252, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BAG")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.CENARION_CIRCLE)
	recipe:AddRepVendor(FAC.CENARION_CIRCLE, REP.REVERED, 15179)

	-- Glacial Gloves -- 28205
	recipe = AddRecipe(28205, V.ORIG, Q.EPIC)
	recipe:SetSkillLevels(300, 300, 315, 330, 345)
	recipe:SetCraftedItem(22654, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HANDS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:Retire()

	-- Glacial Vest -- 28207
	recipe = AddRecipe(28207, V.ORIG, Q.EPIC)
	recipe:SetSkillLevels(300, 300, 315, 330, 345)
	recipe:SetCraftedItem(22652, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:Retire()

	-- Glacial Cloak -- 28208
	recipe = AddRecipe(28208, V.ORIG, Q.EPIC)
	recipe:SetSkillLevels(300, 300, 315, 330, 345)
	recipe:SetCraftedItem(22658, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BACK")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:Retire()

	-- Glacial Wrists -- 28209
	recipe = AddRecipe(28209, V.ORIG, Q.EPIC)
	recipe:SetSkillLevels(300, 300, 315, 330, 345)
	recipe:SetCraftedItem(22655, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WRIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:Retire()

	-- Gaea's Embrace -- 28210
	recipe = AddRecipe(28210, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 315, 330, 345)
	recipe:SetRecipeItem(22683, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(22660, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BACK")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.CENARION_CIRCLE)
	recipe:AddRepVendor(FAC.CENARION_CIRCLE, REP.REVERED, 15179)

	-- Sylvan Vest -- 28480
	recipe = AddRecipe(28480, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 315, 330, 345)
	recipe:SetRecipeItem(22774, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(22756, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER, F.CENARION_CIRCLE)
	recipe:AddRepVendor(FAC.CENARION_CIRCLE, REP.REVERED, 15179)

	-- Sylvan Crown -- 28481
	recipe = AddRecipe(28481, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 315, 330, 345)
	recipe:SetRecipeItem(22773, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(22757, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HEAD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER, F.CENARION_CIRCLE)
	recipe:AddRepVendor(FAC.CENARION_CIRCLE, REP.HONORED, 15179)

	-- Sylvan Shoulders -- 28482
	recipe = AddRecipe(28482, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 315, 330, 345)
	recipe:SetRecipeItem(22772, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(22758, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_SHOULDER")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER, F.CENARION_CIRCLE)
	recipe:AddRepVendor(FAC.CENARION_CIRCLE, REP.FRIENDLY, 15179)

	-------------------------------------------------------------------------------
	-- The Burning Crusade.
	-------------------------------------------------------------------------------
	-- Bolt of Netherweave -- 26745
	recipe = AddRecipe(26745, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 305, 315, 325)
	recipe:SetCraftedItem(21840, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_MATERIALS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(1346, 2399, 3004, 3363, 3523, 4159, 4576, 5153, 9584, 11052, 16729, 17487, 18749, 18772, 26914, 26964, 26969, 27001, 28699, 33580, 33613, 33636, 33684, 44783, 45559, 57405)

	-- Netherweave Bag -- 26746
	recipe = AddRecipe(26746, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(315, 315, 320, 330, 340)
	recipe:SetCraftedItem(21841, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BAG")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(1346, 2399, 3004, 3363, 3523, 4159, 4576, 5153, 9584, 11052, 16729, 17487, 18749, 18772, 26914, 26964, 26969, 27001, 28699, 33580, 33613, 33636, 33684, 44783, 45559, 57405)

	-- Bolt of Imbued Netherweave -- 26747
	recipe = AddRecipe(26747, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(325, 325, 330, 335, 340)
	recipe:SetRecipeItem(21892, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(21842, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_MATERIALS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddVendor(16638, 16767, 19213)

	-- Imbued Netherweave Bag -- 26749
	recipe = AddRecipe(26749, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(340, 340, 340, 345, 350)
	recipe:SetRecipeItem(21893, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(21843, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BAG")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddVendor(19015, 19213)

	-- Bolt of Soulcloth -- 26750
	recipe = AddRecipe(26750, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(345, 345, 345, 350, 355)
	recipe:SetRecipeItem(21894, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(21844, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_MATERIALS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddLimitedVendor(16638, 1, 16767, 1, 19015, 1, 19017, 1)

	-- Primal Mooncloth -- 26751
	recipe = AddRecipe(26751, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(350, 350, 350, 355, 360)
	recipe:SetRecipeItem(21895, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(21845, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_MATERIALS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddVendor(22208, 29512)

	-- Spellfire Belt -- 26752
	recipe = AddRecipe(26752, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(355, 355, 365, 370, 375)
	recipe:SetRecipeItem(21908, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(21846, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WAIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
	recipe:AddVendor(22213, 29511)

	-- Spellfire Gloves -- 26753
	recipe = AddRecipe(26753, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(365, 365, 375, 380, 385)
	recipe:SetRecipeItem(21909, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(21847, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HANDS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
	recipe:AddVendor(22213, 29511)

	-- Spellfire Robe -- 26754
	recipe = AddRecipe(26754, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 385, 390, 395)
	recipe:SetRecipeItem(21910, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(21848, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
	recipe:AddVendor(22213, 29511)

	-- Spellfire Bag -- 26755
	recipe = AddRecipe(26755, V.TBC, Q.RARE)
	recipe:SetSkillLevels(375, 375, 385, 390, 395)
	recipe:SetRecipeItem(21911, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(21858, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BAG")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddMobDrop(20134, 20135)
	recipe:AddVendor(22213, 29511)

	-- Frozen Shadoweave Shoulders -- 26756
	recipe = AddRecipe(26756, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(355, 355, 365, 370, 375)
	recipe:SetRecipeItem(21912, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(21869, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_SHOULDER")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
	recipe:AddVendor(22212, 29510)

	-- Frozen Shadoweave Boots -- 26757
	recipe = AddRecipe(26757, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(365, 365, 375, 380, 385)
	recipe:SetRecipeItem(21914, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(21870, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_FEET")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
	recipe:AddVendor(22212, 29510)

	-- Frozen Shadoweave Robe -- 26758
	recipe = AddRecipe(26758, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 385, 390, 395)
	recipe:SetRecipeItem(21913, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(21871, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
	recipe:AddVendor(22212, 29510)

	-- Ebon Shadowbag -- 26759
	recipe = AddRecipe(26759, V.TBC, Q.RARE)
	recipe:SetSkillLevels(375, 375, 385, 390, 395)
	recipe:SetRecipeItem(21915, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(21872, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BAG")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddVendor(22212, 29510)

	-- Primal Mooncloth Belt -- 26760
	recipe = AddRecipe(26760, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(355, 355, 365, 370, 375)
	recipe:SetRecipeItem(21916, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(21873, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WAIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddVendor(22208, 29512)

	-- Primal Mooncloth Shoulders -- 26761
	recipe = AddRecipe(26761, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(365, 365, 375, 380, 385)
	recipe:SetRecipeItem(21918, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(21874, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_SHOULDER")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddVendor(22208, 29512)

	-- Primal Mooncloth Robe -- 26762
	recipe = AddRecipe(26762, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 385, 390, 395)
	recipe:SetRecipeItem(21917, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(21875, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddVendor(22208, 29512)

	-- Primal Mooncloth Bag -- 26763
	recipe = AddRecipe(26763, V.TBC, Q.RARE)
	recipe:SetSkillLevels(375, 375, 385, 390, 395)
	recipe:SetRecipeItem(21919, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(21876, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BAG")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddMobDrop(18872)
	recipe:AddVendor(22208, 29512)

	-- Netherweave Bracers -- 26764
	recipe = AddRecipe(26764, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(310, 310, 320, 325, 330)
	recipe:SetCraftedItem(21849, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WRIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddTrainer(1346, 2399, 3004, 3363, 3523, 4159, 4576, 5153, 9584, 11052, 16729, 17487, 18749, 18772, 26914, 26964, 26969, 27001, 28699, 33580, 33613, 33636, 33684, 44783, 45559, 57405)

	-- Netherweave Belt -- 26765
	recipe = AddRecipe(26765, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(310, 310, 320, 325, 330)
	recipe:SetCraftedItem(21850, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WAIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddTrainer(1346, 2399, 3004, 3363, 3523, 4159, 4576, 5153, 9584, 11052, 16729, 17487, 18749, 18772, 26914, 26964, 26969, 27001, 28699, 33580, 33613, 33636, 33684, 44783, 45559, 57405)

	-- Netherweave Gloves -- 26770
	recipe = AddRecipe(26770, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(320, 320, 330, 335, 340)
	recipe:SetCraftedItem(21851, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HANDS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddTrainer(1346, 2399, 3004, 3363, 3523, 4159, 4576, 5153, 9584, 11052, 16729, 17487, 18749, 18772, 26914, 26964, 26969, 27001, 28699, 33580, 33613, 33636, 33684, 44783, 45559, 57405)

	-- Netherweave Pants -- 26771
	recipe = AddRecipe(26771, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(325, 325, 335, 340, 345)
	recipe:SetCraftedItem(21852, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_LEGS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddTrainer(1346, 2399, 3004, 3363, 3523, 4159, 4576, 5153, 9584, 11052, 16729, 17487, 18749, 18772, 26914, 26964, 26969, 27001, 28699, 33580, 33613, 33636, 33684, 44783, 45559, 57405)

	-- Netherweave Boots -- 26772
	recipe = AddRecipe(26772, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(335, 335, 345, 350, 355)
	recipe:SetCraftedItem(21853, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_FEET")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddTrainer(1346, 2399, 3004, 3363, 3523, 4159, 4576, 5153, 9584, 11052, 16729, 17487, 18749, 18772, 26914, 26964, 26969, 27001, 28699, 33580, 33613, 33636, 33684, 44783, 45559, 57405)

	-- Netherweave Robe -- 26773
	recipe = AddRecipe(26773, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(340, 340, 350, 355, 360)
	recipe:SetRecipeItem(21896, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(21854, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
	recipe:AddVendor(16638, 16767, 19213)

	-- Netherweave Tunic -- 26774
	recipe = AddRecipe(26774, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(345, 345, 355, 360, 365)
	recipe:SetRecipeItem(21897, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(21855, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
	recipe:AddVendor(16638, 16767, 19213)

	-- Imbued Netherweave Pants -- 26775
	recipe = AddRecipe(26775, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(340, 340, 350, 355, 360)
	recipe:SetRecipeItem(21898, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(21859, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_LEGS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
	recipe:AddLimitedVendor(18011, 1, 19722, 1)

	-- Imbued Netherweave Boots -- 26776
	recipe = AddRecipe(26776, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(350, 350, 360, 365, 370)
	recipe:SetRecipeItem(21899, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(21860, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_FEET")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
	recipe:AddLimitedVendor(18011, 1, 19722, 1)

	-- Imbued Netherweave Robe -- 26777
	recipe = AddRecipe(26777, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(360, 360, 370, 375, 380)
	recipe:SetRecipeItem(21900, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(21861, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
	recipe:AddLimitedVendor(19521, 1)

	-- Imbued Netherweave Tunic -- 26778
	recipe = AddRecipe(26778, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(360, 360, 370, 375, 380)
	recipe:SetRecipeItem(21901, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(21862, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
	recipe:AddLimitedVendor(19521, 1)

	-- Soulcloth Gloves -- 26779
	recipe = AddRecipe(26779, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(355, 355, 365, 370, 375)
	recipe:SetRecipeItem(21902, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(21863, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HANDS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
	recipe:AddLimitedVendor(19015, 1, 19017, 1)

	-- Soulcloth Shoulders -- 26780
	recipe = AddRecipe(26780, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(365, 365, 375, 380, 385)
	recipe:SetRecipeItem(21903, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(21864, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_SHOULDER")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.RAID, F.DPS, F.HEALER, F.CASTER)
	recipe:AddMobDrop(16406)

	-- Soulcloth Vest -- 26781
	recipe = AddRecipe(26781, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(375, 375, 380, 382, 385)
	recipe:SetRecipeItem(21904, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(21865, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.RAID, F.DPS, F.HEALER, F.CASTER)
	recipe:AddMobDrop(16408)

	-- Arcanoweave Bracers -- 26782
	recipe = AddRecipe(26782, V.TBC, Q.UNCOMMON)
	recipe:SetSkillLevels(350, 350, 360, 365, 370)
	recipe:SetRecipeItem(21905, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(21866, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WRIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.INSTANCE, F.DPS, F.CASTER)
	recipe:AddMobDrop(20869)

	-- Arcanoweave Boots -- 26783
	recipe = AddRecipe(26783, V.TBC, Q.UNCOMMON)
	recipe:SetSkillLevels(360, 360, 370, 375, 380)
	recipe:SetRecipeItem(21906, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(21867, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_FEET")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.INSTANCE, F.DPS, F.CASTER)
	recipe:AddMobDrop(19168)

	-- Arcanoweave Robe -- 26784
	recipe = AddRecipe(26784, V.TBC, Q.UNCOMMON)
	recipe:SetSkillLevels(370, 370, 380, 385, 390)
	recipe:SetRecipeItem(21907, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(21868, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.INSTANCE, F.DPS, F.HEALER, F.CASTER)
	recipe:AddMobDrop(19220)

	-- Enchanted Mageweave Pouch -- 27658
	recipe = AddRecipe(27658, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(225, 225, 240, 255, 270)
	recipe:SetRecipeItem(22307, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(22246, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BAG")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddVendor(1318, 3012, 3346, 4228, 4617, 5158, 5757, 5758, 15419, 16635, 16722, 18753, 18773, 18951, 19234, 19537, 19540, 19663, 26569, 27030, 27054, 27147, 28714, 53410)

	-- Spellcloth -- 31373
	recipe = AddRecipe(31373, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(350, 350, 350, 355, 360)
	recipe:SetRecipeItem(24316, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(24271, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_MATERIALS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddVendor(22213, 29511)

	-- Mystic Spellthread -- 31430
	recipe = AddRecipe(31430, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(335, 335, 345, 350, 355)
	recipe:SetRecipeItem(24292, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(24273, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER, F.SCRYER)
	recipe:AddRepVendor(FAC.THE_SCRYERS, REP.HONORED, 19331)

	-- Silver Spellthread -- 31431
	recipe = AddRecipe(31431, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(335, 335, 345, 350, 355)
	recipe:SetRecipeItem(24293, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(24275, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.ALLIANCE, F.HEALER, F.CASTER, F.ALDOR)
	recipe:AddRepVendor(FAC.THE_ALDOR, REP.HONORED, 19321)

	-- Runic Spellthread -- 31432
	recipe = AddRecipe(31432, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 385, 390, 395)
	recipe:SetRecipeItem(24294, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(24274, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER, F.SCRYER)
	recipe:AddRepVendor(FAC.THE_SCRYERS, REP.EXALTED, 19331)

	-- Golden Spellthread -- 31433
	recipe = AddRecipe(31433, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 385, 390, 395)
	recipe:SetRecipeItem(24295, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(24276, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER, F.ALDOR)
	recipe:AddRepVendor(FAC.THE_ALDOR, REP.EXALTED, 19321)

	-- Unyielding Bracers -- 31434
	recipe = AddRecipe(31434, V.TBC, Q.RARE)
	recipe:SetSkillLevels(350, 350, 360, 365, 370)
	recipe:SetRecipeItem(35308, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(24249, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WRIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.CASTER)
	recipe:AddMobDrop(24664)

	-- Bracers of Havok -- 31435
	recipe = AddRecipe(31435, V.TBC, Q.RARE)
	recipe:SetSkillLevels(350, 350, 360, 365, 370)
	recipe:SetRecipeItem(24297, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(24250, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WRIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.OUTLAND)

	-- Blackstrike Bracers -- 31437
	recipe = AddRecipe(31437, V.TBC, Q.RARE)
	recipe:SetSkillLevels(350, 350, 360, 365, 370)
	recipe:SetRecipeItem(24298, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(24251, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WRIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.OUTLAND)

	-- Cloak of the Black Void -- 31438
	recipe = AddRecipe(31438, V.TBC, Q.RARE)
	recipe:SetSkillLevels(350, 350, 360, 365, 370)
	recipe:SetRecipeItem(24299, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(24252, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BACK")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.OUTLAND)

	-- Cloak of Eternity -- 31440
	recipe = AddRecipe(31440, V.TBC, Q.RARE)
	recipe:SetSkillLevels(350, 350, 360, 365, 370)
	recipe:SetRecipeItem(24300, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(24253, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BACK")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.TANK)
	recipe:AddWorldDrop(Z.OUTLAND)

	-- White Remedy Cape -- 31441
	recipe = AddRecipe(31441, V.TBC, Q.RARE)
	recipe:SetSkillLevels(350, 350, 360, 365, 370)
	recipe:SetRecipeItem(24301, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(24254, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BACK")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.OUTLAND)

	-- Unyielding Girdle -- 31442
	recipe = AddRecipe(31442, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(365, 365, 375, 380, 385)
	recipe:SetRecipeItem(35309, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(24255, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WAIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddMobDrop(24664)

	-- Girdle of Ruination -- 31443
	recipe = AddRecipe(31443, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(365, 365, 375, 380, 385)
	recipe:SetRecipeItem(24303, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(24256, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WAIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.OUTLAND)

	-- Black Belt of Knowledge -- 31444
	recipe = AddRecipe(31444, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(365, 365, 375, 380, 385)
	recipe:SetRecipeItem(24304, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(24257, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WAIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.OUTLAND)

	-- Resolute Cape -- 31448
	recipe = AddRecipe(31448, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(365, 365, 375, 380, 385)
	recipe:SetRecipeItem(24305, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(24258, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BACK")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddWorldDrop(Z.OUTLAND)

	-- Vengeance Wrap -- 31449
	recipe = AddRecipe(31449, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(365, 365, 375, 380, 385)
	recipe:SetRecipeItem(24306, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(24259, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BACK")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.OUTLAND)

	-- Manaweave Cloak -- 31450
	recipe = AddRecipe(31450, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(365, 365, 375, 380, 385)
	recipe:SetRecipeItem(24307, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(24260, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BACK")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.OUTLAND)

	-- Whitemend Pants -- 31451
	recipe = AddRecipe(31451, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(375, 375, 385, 390, 395)
	recipe:SetRecipeItem(24308, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(24261, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_LEGS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.INSTANCE, F.HEALER, F.CASTER)
	recipe:AddMobDrop(20885)

	-- Spellstrike Pants -- 31452
	recipe = AddRecipe(31452, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(375, 375, 385, 390, 395)
	recipe:SetRecipeItem(24309, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(24262, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_LEGS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.INSTANCE, F.DPS, F.HEALER, F.CASTER)
	recipe:AddMobDrop(18708)

	-- Battlecast Pants -- 31453
	recipe = AddRecipe(31453, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(375, 375, 385, 390, 395)
	recipe:SetRecipeItem(24310, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(24263, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_LEGS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.INSTANCE, F.DPS, F.HEALER, F.CASTER)
	recipe:AddMobDrop(17978)

	-- Whitemend Hood -- 31454
	recipe = AddRecipe(31454, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(375, 375, 385, 390, 395)
	recipe:SetRecipeItem(24311, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(24264, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HEAD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.INSTANCE, F.HEALER, F.CASTER)
	recipe:AddMobDrop(17977)

	-- Spellstrike Hood -- 31455
	recipe = AddRecipe(31455, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(375, 375, 385, 390, 395)
	recipe:SetRecipeItem(24312, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(24266, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HEAD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.INSTANCE, F.DPS, F.HEALER, F.CASTER)
	recipe:AddMobDrop(16807)

	-- Battlecast Hood -- 31456
	recipe = AddRecipe(31456, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(375, 375, 385, 390, 395)
	recipe:SetRecipeItem(24313, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(24267, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HEAD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.INSTANCE, F.DPS, F.HEALER, F.CASTER)
	recipe:AddMobDrop(17798)

	-- Bag of Jewels -- 31459
	recipe = AddRecipe(31459, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(340, 340, 350, 355, 360)
	recipe:SetRecipeItem(24314, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(24270, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BAG")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.CONSORTIUM)
	recipe:AddRepVendor(FAC.THE_CONSORTIUM, REP.HONORED, 20242, 23007)

	-- Netherweave Net -- 31460
	recipe = AddRecipe(31460, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 300, 310, 320)
	recipe:SetCraftedItem(24268, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_MISC")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(1346, 2399, 3004, 3363, 3523, 4159, 4576, 5153, 9584, 11052, 16729, 17487, 18749, 18772, 26914, 26964, 26969, 27001, 28699, 33580, 33613, 33636, 33684, 44783, 45559, 57405)

	-- Belt of Blasting -- 36315
	recipe = AddRecipe(36315, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(375, 375, 385, 390, 395)
	recipe:SetRecipeItem(30280, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(30038, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WAIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.RAID, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.SERPENTSHRINE_CAVERN, Z.TEMPEST_KEEP)

	-- Belt of the Long Road -- 36316
	recipe = AddRecipe(36316, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(375, 375, 385, 390, 395)
	recipe:SetRecipeItem(30281, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(30036, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WAIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.RAID, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.SERPENTSHRINE_CAVERN, Z.TEMPEST_KEEP)

	-- Boots of Blasting -- 36317
	recipe = AddRecipe(36317, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(375, 375, 385, 390, 395)
	recipe:SetRecipeItem(30282, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(30037, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("TAILORING_FEET")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.RAID, F.DPS, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.SERPENTSHRINE_CAVERN, Z.TEMPEST_KEEP)

	-- Boots of the Long Road -- 36318
	recipe = AddRecipe(36318, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(375, 375, 385, 390, 395)
	recipe:SetRecipeItem(30283, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(30035, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("TAILORING_FEET")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.RAID, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.SERPENTSHRINE_CAVERN, Z.TEMPEST_KEEP)

	-- Shadowcloth -- 36686
	recipe = AddRecipe(36686, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(350, 350, 350, 355, 360)
	recipe:SetRecipeItem(30483, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(24272, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_MATERIALS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddVendor(22212, 29510)

	-- Cloak of Arcane Evasion -- 37873
	recipe = AddRecipe(37873, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(350, 350, 360, 365, 370)
	recipe:SetRecipeItem(30833, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(30831, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BACK")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.LOWERCITY)
	recipe:AddRepVendor(FAC.LOWER_CITY, REP.HONORED, 21655)

	-- Flameheart Bracers -- 37882
	recipe = AddRecipe(37882, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(350, 350, 360, 365, 370)
	recipe:SetRecipeItem(30842, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(30837, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WRIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER, F.ALDOR)
	recipe:AddRepVendor(FAC.THE_ALDOR, REP.FRIENDLY, 19321)

	-- Flameheart Gloves -- 37883
	recipe = AddRecipe(37883, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(360, 360, 370, 375, 380)
	recipe:SetRecipeItem(30843, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(30838, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HANDS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER, F.ALDOR)
	recipe:AddRepVendor(FAC.THE_ALDOR, REP.HONORED, 19321)

	-- Flameheart Vest -- 37884
	recipe = AddRecipe(37884, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(370, 370, 380, 385, 390)
	recipe:SetRecipeItem(30844, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(30839, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER, F.ALDOR)
	recipe:AddRepVendor(FAC.THE_ALDOR, REP.EXALTED, 19321)

	-- Soulguard Slippers -- 40020
	recipe = AddRecipe(40020, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 385, 390, 395)
	recipe:SetRecipeItem(32437, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(32391, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_FEET")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.ASHTONGUE)
	recipe:AddRepVendor(FAC.ASHTONGUE_DEATHSWORN, REP.HONORED, 23159)

	-- Soulguard Bracers -- 40021
	recipe = AddRecipe(40021, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 385, 390, 395)
	recipe:SetRecipeItem(32438, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(32392, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WRIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.ASHTONGUE)
	recipe:AddRepVendor(FAC.ASHTONGUE_DEATHSWORN, REP.FRIENDLY, 23159)

	-- Soulguard Leggings -- 40023
	recipe = AddRecipe(40023, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 385, 390, 395)
	recipe:SetRecipeItem(32439, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(32389, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_LEGS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.ASHTONGUE)
	recipe:AddRepVendor(FAC.ASHTONGUE_DEATHSWORN, REP.HONORED, 23159)

	-- Soulguard Girdle -- 40024
	recipe = AddRecipe(40024, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 385, 390, 395)
	recipe:SetRecipeItem(32440, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(32390, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WAIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.ASHTONGUE)
	recipe:AddRepVendor(FAC.ASHTONGUE_DEATHSWORN, REP.FRIENDLY, 23159)

	-- Night's End -- 40060
	recipe = AddRecipe(40060, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 385, 390, 395)
	recipe:SetRecipeItem(32447, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(32420, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BACK")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.ASHTONGUE)
	recipe:AddRepVendor(FAC.ASHTONGUE_DEATHSWORN, REP.HONORED, 23159)

	-- Bracers of Nimble Thought -- 41205
	recipe = AddRecipe(41205, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(375, 375, 385, 390, 395)
	recipe:SetRecipeItem(32754, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(32586, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WRIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.RAID, F.DPS, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.BLACK_TEMPLE)

	-- Mantle of Nimble Thought -- 41206
	recipe = AddRecipe(41206, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(375, 375, 385, 390, 395)
	recipe:SetRecipeItem(32755, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(32587, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("TAILORING_SHOULDER")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.RAID, F.DPS, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.BLACK_TEMPLE, Z.MOUNT_HYJAL)

	-- Swiftheal Wraps -- 41207
	recipe = AddRecipe(41207, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(375, 375, 385, 390, 395)
	recipe:SetRecipeItem(32752, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(32584, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WRIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.RAID, F.DPS, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.BLACK_TEMPLE, Z.MOUNT_HYJAL)

	-- Swiftheal Mantle -- 41208
	recipe = AddRecipe(41208, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(375, 375, 385, 390, 395)
	recipe:SetRecipeItem(32753, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(32585, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("TAILORING_SHOULDER")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.RAID, F.DPS, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.BLACK_TEMPLE)

	-- Green Winter Clothes -- 44950
	recipe = AddRecipe(44950, V.TBC, Q.UNCOMMON)
	recipe:SetSkillLevels(250, 250, 250, 250, 250)
	recipe:SetRecipeItem(34261, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(34087, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddVendor(13420)
	recipe:AddWorldEvent("WINTER_VEIL")

	-- Red Winter Clothes -- 44958
	recipe = AddRecipe(44958, V.TBC, Q.UNCOMMON)
	recipe:SetSkillLevels(250, 250, 250, 250, 250)
	recipe:SetRecipeItem(34319, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(34085, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddVendor(13433)
	recipe:AddWorldEvent("WINTER_VEIL")

	-- Sunfire Handwraps -- 46128
	recipe = AddRecipe(46128, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(365, 365, 375, 392, 410)
	recipe:SetRecipeItem(35204, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(34366, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HANDS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.RAID, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.SUNWELL_PLATEAU)

	-- Hands of Eternal Light -- 46129
	recipe = AddRecipe(46129, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(365, 365, 375, 392, 410)
	recipe:SetRecipeItem(35205, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(34367, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HANDS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.RAID, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.SUNWELL_PLATEAU)

	-- Sunfire Robe -- 46130
	recipe = AddRecipe(46130, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(365, 365, 375, 392, 410)
	recipe:SetRecipeItem(35206, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(34364, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.RAID, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.SUNWELL_PLATEAU)

	-- Robe of Eternal Light -- 46131
	recipe = AddRecipe(46131, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(365, 365, 375, 392, 410)
	recipe:SetRecipeItem(35207, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(34365, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.RAID, F.DPS, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.SUNWELL_PLATEAU)

	-- Dress Shoes -- 49677
	recipe = AddRecipe(49677, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(250, 250, 255, 270, 285)
	recipe:SetRecipeItem(37915, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(6836, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_FEET")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddLimitedVendor(40572, 1)

	-- Mycah's Botanical Bag -- 50194
	recipe = AddRecipe(50194, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 385, 390, 395)
	recipe:SetRecipeItem(38229, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(38225, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BAG")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.SPOREGGAR)
	recipe:AddRepVendor(FAC.SPOREGGAR, REP.REVERED, 18382)

	-- Haliscan Jacket -- 50644
	recipe = AddRecipe(50644, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(250, 250, 265, 280, 295)
	recipe:SetRecipeItem(38327, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(38277, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddVendor(40572)

	-- Haliscan Pantaloons -- 50647
	recipe = AddRecipe(50647, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(245, 245, 250, 255, 260)
	recipe:SetRecipeItem(38328, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(38278, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_LEGS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddVendor(40572)

	-- ----------------------------------------------------------------------------
	-- Wrath of the Lich King.
	-- ----------------------------------------------------------------------------
	-- Frostweave Net -- 55898
	recipe = AddRecipe(55898, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(41509, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_MISC")
	recipe:AddTrainer(2399, 3363, 3484, 3523, 4159, 4578, 11557, 26914, 26964, 26969, 27001, 28699, 33580, 44783)

	-- Bolt of Frostweave -- 55899
	recipe = AddRecipe(55899, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(41510, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_MATERIALS")
	recipe:AddTrainer(2399, 3363, 3484, 3523, 4159, 4578, 11557, 26914, 26964, 26969, 27001, 28699, 33580, 44783)

	-- Bolt of Imbued Frostweave -- 55900
	recipe = AddRecipe(55900, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(41511, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_MATERIALS")
	recipe:AddTrainer(2399, 3363, 3484, 3523, 4159, 4578, 11557, 26914, 26964, 26969, 27001, 28699, 33580, 44783)

	-- Duskweave Leggings -- 55901
	recipe = AddRecipe(55901, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(20, 20, 30, 35, 40)
	recipe:SetCraftedItem(41548, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(2399, 3363, 3484, 3523, 4159, 4578, 11557, 26914, 26964, 26969, 27001, 28699, 33580, 44783)

	-- Frostwoven Shoulders -- 55902
	recipe = AddRecipe(55902, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(41513, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(2399, 3363, 3484, 3523, 4159, 4578, 11557, 26914, 26964, 26969, 27001, 28699, 33580, 44783)

	-- Frostwoven Robe -- 55903
	recipe = AddRecipe(55903, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(41515, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(2399, 3363, 3484, 3523, 4159, 4578, 11557, 26914, 26964, 26969, 27001, 28699, 33580, 44783)

	-- Frostwoven Gloves -- 55904
	recipe = AddRecipe(55904, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(44211, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HANDS")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(2399, 3363, 3484, 3523, 4159, 4578, 11557, 26914, 26964, 26969, 27001, 28699, 33580, 44783)

	-- Frostwoven Boots -- 55906
	recipe = AddRecipe(55906, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(41520, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_FEET")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(2399, 3363, 3484, 3523, 4159, 4578, 11557, 26914, 26964, 26969, 27001, 28699, 33580, 44783)

	-- Frostwoven Cowl -- 55907
	recipe = AddRecipe(55907, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(5, 5, 15, 20, 25)
	recipe:SetCraftedItem(41521, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HEAD")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(2399, 3363, 3484, 3523, 4159, 4578, 11557, 26914, 26964, 26969, 27001, 28699, 33580, 44783)

	-- Frostwoven Belt -- 55908
	recipe = AddRecipe(55908, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(41522, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WAIST")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(2399, 3363, 3484, 3523, 4159, 4578, 11557, 26914, 26964, 26969, 27001, 28699, 33580, 44783)

	-- Mystic Frostwoven Shoulders -- 55910
	recipe = AddRecipe(55910, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(10, 10, 20, 25, 30)
	recipe:SetCraftedItem(41523, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(2399, 3363, 3484, 3523, 4159, 4578, 11557, 26914, 26964, 26969, 27001, 28699, 33580, 44783)

	-- Mystic Frostwoven Robe -- 55911
	recipe = AddRecipe(55911, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(15, 15, 25, 30, 35)
	recipe:SetCraftedItem(41525, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(2399, 3363, 3484, 3523, 4159, 4578, 11557, 26914, 26964, 26969, 27001, 28699, 33580, 44783)

	-- Mystic Frostwoven Wristwraps -- 55913
	recipe = AddRecipe(55913, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(10, 10, 20, 25, 30)
	recipe:SetCraftedItem(41528, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(2399, 3363, 3484, 3523, 4159, 4578, 11557, 26914, 26964, 26969, 27001, 28699, 33580, 44783)

	-- Duskweave Belt -- 55914
	recipe = AddRecipe(55914, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(20, 20, 30, 35, 40)
	recipe:SetCraftedItem(41543, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(2399, 3363, 3484, 3523, 4159, 4578, 11557, 26914, 26964, 26969, 27001, 28699, 33580, 44783)

	-- Duskweave Cowl -- 55919
	recipe = AddRecipe(55919, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(20, 20, 30, 35, 40)
	recipe:SetCraftedItem(41546, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(2399, 3363, 3484, 3523, 4159, 4578, 11557, 26914, 26964, 26969, 27001, 28699, 33580, 44783)

	-- Duskweave Wristwraps -- 55920
	recipe = AddRecipe(55920, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(41551, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(2399, 3363, 3484, 3523, 4159, 4578, 11557, 26914, 26964, 26969, 27001, 28699, 33580, 44783)

	-- Duskweave Robe -- 55921
	recipe = AddRecipe(55921, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(30, 30, 40, 45, 50)
	recipe:SetCraftedItem(41549, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(2399, 3363, 3484, 3523, 4159, 4578, 11557, 26914, 26964, 26969, 27001, 28699, 33580, 44783)

	-- Duskweave Gloves -- 55922
	recipe = AddRecipe(55922, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(30, 30, 40, 45, 50)
	recipe:SetCraftedItem(41545, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(2399, 3363, 3484, 3523, 4159, 4578, 11557, 26914, 26964, 26969, 27001, 28699, 33580, 44783)

	-- Duskweave Shoulders -- 55923
	recipe = AddRecipe(55923, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(35, 35, 45, 50, 55)
	recipe:SetCraftedItem(41550, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(2399, 3363, 3484, 3523, 4159, 4578, 11557, 26914, 26964, 26969, 27001, 28699, 33580, 44783)

	-- Duskweave Boots -- 55924
	recipe = AddRecipe(55924, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(35, 35, 45, 50, 55)
	recipe:SetCraftedItem(41544, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(2399, 3363, 3484, 3523, 4159, 4578, 11557, 26914, 26964, 26969, 27001, 28699, 33580, 44783)

	-- Black Duskweave Leggings -- 55925
	recipe = AddRecipe(55925, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(40, 40, 50, 55, 60)
	recipe:SetCraftedItem(41553, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(2399, 3363, 3484, 3523, 4159, 4578, 11557, 26914, 26964, 26969, 27001, 28699, 33580, 44783)

	-- Black Duskweave Robe -- 55941
	recipe = AddRecipe(55941, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(45, 45, 55, 60, 65)
	recipe:SetCraftedItem(41554, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(2399, 3363, 3484, 3523, 4159, 4578, 11557, 26914, 26964, 26969, 27001, 28699, 33580, 44783)

	-- Black Duskweave Wristwraps -- 55943
	recipe = AddRecipe(55943, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(40, 40, 50, 55, 60)
	recipe:SetCraftedItem(41555, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(2399, 3363, 3484, 3523, 4159, 4578, 11557, 26914, 26964, 26969, 27001, 28699, 33580, 44783)

	-- Red Lumberjack Shirt -- 55993
	recipe = AddRecipe(55993, V.WOTLK, Q.UNCOMMON)
	recipe:SetSkillLevels(400, 400, 400, 405, 410)
	recipe:SetRecipeItem(42172, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(41248, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_SHIRT")
	recipe:AddWorldDrop(Z.NORTHREND)

	-- Blue Lumberjack Shirt -- 55994
	recipe = AddRecipe(55994, V.WOTLK, Q.UNCOMMON)
	recipe:SetSkillLevels(400, 400, 400, 405, 410)
	recipe:SetRecipeItem(42173, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(41249, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_SHIRT")
	recipe:AddWorldDrop(Z.NORTHREND)

	-- Yellow Lumberjack Shirt -- 55995
	recipe = AddRecipe(55995, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(41251, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_SHIRT")
	recipe:AddTrainer(2399, 3363, 3484, 3523, 4159, 4578, 11557, 26914, 26964, 26969, 27001, 28699, 33580, 44783)

	-- Green Lumberjack Shirt -- 55996
	recipe = AddRecipe(55996, V.WOTLK, Q.UNCOMMON)
	recipe:SetSkillLevels(400, 400, 400, 405, 410)
	recipe:SetRecipeItem(42175, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(41250, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_SHIRT")
	recipe:AddWorldDrop(Z.NORTHREND)

	-- Red Workman's Shirt -- 55997
	recipe = AddRecipe(55997, V.WOTLK, Q.UNCOMMON)
	recipe:SetSkillLevels(400, 400, 400, 405, 410)
	recipe:SetRecipeItem(42177, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(41252, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_SHIRT")
	recipe:AddWorldDrop(Z.NORTHREND)

	-- Blue Workman's Shirt -- 55998
	recipe = AddRecipe(55998, V.WOTLK, Q.UNCOMMON)
	recipe:SetSkillLevels(400, 400, 400, 405, 410)
	recipe:SetRecipeItem(42176, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(41253, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_SHIRT")
	recipe:AddWorldDrop(Z.NORTHREND)

	-- Rustic Workman's Shirt -- 55999
	recipe = AddRecipe(55999, V.WOTLK, Q.UNCOMMON)
	recipe:SetSkillLevels(400, 400, 400, 405, 410)
	recipe:SetRecipeItem(42178, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(41254, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_SHIRT")
	recipe:AddWorldDrop(Z.NORTHREND)

	-- Green Workman's Shirt -- 56000
	recipe = AddRecipe(56000, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(41255, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_SHIRT")
	recipe:AddTrainer(2399, 3363, 3484, 3523, 4159, 4578, 11557, 26914, 26964, 26969, 27001, 28699, 33580, 44783)

	-- Moonshroud -- 56001
	recipe = AddRecipe(56001, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(40, 40, 50, 55, 60)
	recipe:SetCraftedItem(41594, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_MATERIALS")
	recipe:AddTrainer(2399, 3363, 3484, 3523, 4159, 4578, 11557, 26914, 26964, 26969, 27001, 28699, 33580, 44783)

	-- Ebonweave -- 56002
	recipe = AddRecipe(56002, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(40, 40, 50, 55, 60)
	recipe:SetCraftedItem(41593, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_MATERIALS")
	recipe:AddTrainer(2399, 3363, 3484, 3523, 4159, 4578, 11557, 26914, 26964, 26969, 27001, 28699, 33580, 44783)

	-- Spellweave -- 56003
	recipe = AddRecipe(56003, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(40, 40, 50, 55, 60)
	recipe:SetCraftedItem(41595, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_MATERIALS")
	recipe:AddTrainer(2399, 3363, 3484, 3523, 4159, 4578, 11557, 26914, 26964, 26969, 27001, 28699, 33580, 44783)

	-- Abyssal Bag -- 56004
	recipe = AddRecipe(56004, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(435, 435, 440, 445, 450)
	recipe:SetRecipeItem(42183, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(41597, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BAG")
	recipe:AddRepVendor(FAC.KNIGHTS_OF_THE_EBON_BLADE, REP.REVERED, 32538)

	-- Glacial Bag -- 56005
	recipe = AddRecipe(56005, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(445, 445, 450, 455, 460)
	recipe:SetRecipeItem(42184, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(41600, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BAG")
	recipe:AddRepVendor(FAC.THE_SONS_OF_HODIR, REP.EXALTED, 32540)

	-- Mysterious Bag -- 56006
	recipe = AddRecipe(56006, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(440, 440, 445, 450, 455)
	recipe:SetRecipeItem(42185, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(41598, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BAG")
	recipe:AddRepVendor(FAC.THE_WYRMREST_ACCORD, REP.REVERED, 32533)

	-- Frostweave Bag -- 56007
	recipe = AddRecipe(56007, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(35, 35, 45, 50, 55)
	recipe:SetCraftedItem(41599, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BAG")
	recipe:AddTrainer(2399, 3363, 3484, 3523, 4159, 4578, 11557, 26914, 26964, 26969, 27001, 28699, 33580, 44783)

	-- Shining Spellthread -- 56008
	recipe = AddRecipe(56008, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(41601, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(2399, 3363, 3484, 3523, 4159, 4578, 11557, 26914, 26964, 26969, 27001, 28699, 33580, 44783)

	-- Brilliant Spellthread -- 56009
	recipe = AddRecipe(56009, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(430, 430, 435, 440, 445)
	recipe:SetRecipeItem(42187, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(41602, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddRepVendor(FAC.ARGENT_CRUSADE, REP.EXALTED, 30431)

	-- Azure Spellthread -- 56010
	recipe = AddRecipe(56010, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(41603, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(2399, 3363, 3484, 3523, 4159, 4578, 11557, 26914, 26964, 26969, 27001, 28699, 33580, 44783)

	-- Sapphire Spellthread -- 56011
	recipe = AddRecipe(56011, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(430, 430, 435, 440, 445)
	recipe:SetRecipeItem(42188, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(41604, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddRepVendor(FAC.KIRIN_TOR, REP.EXALTED, 32287)

	-- Cloak of the Moon -- 56014
	recipe = AddRecipe(56014, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(15, 15, 25, 30, 35)
	recipe:SetCraftedItem(41607, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BACK")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(2399, 3363, 3484, 3523, 4159, 4578, 11557, 26914, 26964, 26969, 27001, 28699, 33580, 44783)

	-- Cloak of Frozen Spirits -- 56015
	recipe = AddRecipe(56015, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(20, 20, 30, 35, 40)
	recipe:SetCraftedItem(41608, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BACK")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(2399, 3363, 3484, 3523, 4159, 4578, 11557, 26914, 26964, 26969, 27001, 28699, 33580, 44783)

	-- Wispcloak -- 56016
	recipe = AddRecipe(56016, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(420, 420, 435, 445, 455)
	recipe:SetCraftedItem(41609, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BACK")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddAchievement(1288)

	-- Deathchill Cloak -- 56017
	recipe = AddRecipe(56017, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(420, 420, 435, 445, 455)
	recipe:SetCraftedItem(41610, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BACK")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddAchievement(41)

	-- Hat of Wintry Doom -- 56018
	recipe = AddRecipe(56018, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(41984, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(2399, 3363, 3484, 3523, 4159, 4578, 11557, 26914, 26964, 26969, 27001, 28699, 33580, 44783)

	-- Silky Iceshard Boots -- 56019
	recipe = AddRecipe(56019, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(45, 45, 55, 60, 65)
	recipe:SetCraftedItem(41985, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(2399, 3363, 3484, 3523, 4159, 4578, 11557, 26914, 26964, 26969, 27001, 28699, 33580, 44783)

	-- Deep Frozen Cord -- 56020
	recipe = AddRecipe(56020, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(45, 45, 55, 60, 65)
	recipe:SetCraftedItem(41986, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(2399, 3363, 3484, 3523, 4159, 4578, 11557, 26914, 26964, 26969, 27001, 28699, 33580, 44783)

	-- Frostmoon Pants -- 56021
	recipe = AddRecipe(56021, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(42093, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_LEGS")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(2399, 3363, 3484, 3523, 4159, 4578, 11557, 26914, 26964, 26969, 27001, 28699, 33580, 44783)

	-- Light Blessed Mittens -- 56022
	recipe = AddRecipe(56022, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(45, 45, 55, 60, 65)
	recipe:SetCraftedItem(42095, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HANDS")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(2399, 3363, 3484, 3523, 4159, 4578, 11557, 26914, 26964, 26969, 27001, 28699, 33580, 44783)

	-- Aurora Slippers -- 56023
	recipe = AddRecipe(56023, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(45, 45, 55, 60, 65)
	recipe:SetCraftedItem(42096, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_FEET")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(2399, 3363, 3484, 3523, 4159, 4578, 11557, 26914, 26964, 26969, 27001, 28699, 33580, 44783)

	-- Moonshroud Robe -- 56024
	recipe = AddRecipe(56024, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(65, 65, 75, 80, 85)
	recipe:SetCraftedItem(42100, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(2399, 3363, 3484, 3523, 4159, 4578, 11557, 26914, 26964, 26969, 27001, 28699, 33580, 44783)

	-- Moonshroud Gloves -- 56025
	recipe = AddRecipe(56025, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(60, 60, 70, 75, 80)
	recipe:SetCraftedItem(42103, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HANDS")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(2399, 3363, 3484, 3523, 4159, 4578, 11557, 26914, 26964, 26969, 27001, 28699, 33580, 44783)

	-- Ebonweave Robe -- 56026
	recipe = AddRecipe(56026, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(65, 65, 75, 80, 85)
	recipe:SetCraftedItem(42101, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(2399, 3363, 3484, 3523, 4159, 4578, 11557, 26914, 26964, 26969, 27001, 28699, 33580, 44783)

	-- Ebonweave Gloves -- 56027
	recipe = AddRecipe(56027, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(60, 60, 70, 75, 80)
	recipe:SetCraftedItem(42111, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(2399, 3363, 3484, 3523, 4159, 4578, 11557, 26914, 26964, 26969, 27001, 28699, 33580, 44783)

	-- Spellweave Robe -- 56028
	recipe = AddRecipe(56028, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(65, 65, 75, 80, 85)
	recipe:SetCraftedItem(42102, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(2399, 3363, 3484, 3523, 4159, 4578, 11557, 26914, 26964, 26969, 27001, 28699, 33580, 44783)

	-- Spellweave Gloves -- 56029
	recipe = AddRecipe(56029, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(60, 60, 70, 75, 80)
	recipe:SetCraftedItem(42113, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(2399, 3363, 3484, 3523, 4159, 4578, 11557, 26914, 26964, 26969, 27001, 28699, 33580, 44783)

	-- Frostwoven Leggings -- 56030
	recipe = AddRecipe(56030, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(5, 5, 15, 20, 25)
	recipe:SetCraftedItem(41519, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_LEGS")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(2399, 3363, 3484, 3523, 4159, 4578, 11557, 26914, 26964, 26969, 27001, 28699, 33580, 44783)

	-- Frostwoven Wristwraps -- 56031
	recipe = AddRecipe(56031, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(41512, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WRIST")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(2399, 3363, 3484, 3523, 4159, 4578, 11557, 26914, 26964, 26969, 27001, 28699, 33580, 44783)

	-- Frostsavage Belt -- 59582
	recipe = AddRecipe(59582, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(40, 40, 50, 55, 60)
	recipe:SetCraftedItem(43969, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(2399, 3363, 3484, 3523, 4159, 4578, 11557, 26914, 26964, 26969, 27001, 28699, 33580, 44783)

	-- Frostsavage Bracers -- 59583
	recipe = AddRecipe(59583, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(40, 40, 50, 55, 60)
	recipe:SetCraftedItem(43974, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(2399, 3363, 3484, 3523, 4159, 4578, 11557, 26914, 26964, 26969, 27001, 28699, 33580, 44783)

	-- Frostsavage Shoulders -- 59584
	recipe = AddRecipe(59584, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(45, 45, 55, 60, 65)
	recipe:SetCraftedItem(43973, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(2399, 3363, 3484, 3523, 4159, 4578, 11557, 26914, 26964, 26969, 27001, 28699, 33580, 44783)

	-- Frostsavage Boots -- 59585
	recipe = AddRecipe(59585, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(45, 45, 55, 60, 65)
	recipe:SetCraftedItem(43970, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(2399, 3363, 3484, 3523, 4159, 4578, 11557, 26914, 26964, 26969, 27001, 28699, 33580, 44783)

	-- Frostsavage Gloves -- 59586
	recipe = AddRecipe(59586, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(45, 45, 55, 60, 65)
	recipe:SetCraftedItem(41516, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(2399, 3363, 3484, 3523, 4159, 4578, 11557, 26914, 26964, 26969, 27001, 28699, 33580, 44783)

	-- Frostsavage Robe -- 59587
	recipe = AddRecipe(59587, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(45, 45, 55, 60, 65)
	recipe:SetCraftedItem(43972, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(2399, 3363, 3484, 3523, 4159, 4578, 11557, 26914, 26964, 26969, 27001, 28699, 33580, 44783)

	-- Frostsavage Leggings -- 59588
	recipe = AddRecipe(59588, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(45, 45, 55, 60, 65)
	recipe:SetCraftedItem(43975, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(2399, 3363, 3484, 3523, 4159, 4578, 11557, 26914, 26964, 26969, 27001, 28699, 33580, 44783)

	-- Frostsavage Cowl -- 59589
	recipe = AddRecipe(59589, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(45, 45, 55, 60, 65)
	recipe:SetCraftedItem(43971, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(2399, 3363, 3484, 3523, 4159, 4578, 11557, 26914, 26964, 26969, 27001, 28699, 33580, 44783)

	-- Flying Carpet -- 60969
	recipe = AddRecipe(60969, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(44554, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_MISC")
	recipe:AddTrainer(2399, 3363, 3484, 3523, 4159, 4578, 11557, 26914, 26964, 26969, 27001, 28699, 33580, 44783)

	-- Magnificent Flying Carpet -- 60971
	recipe = AddRecipe(60971, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(44558, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("TAILORING_MISC")
	recipe:AddTrainer(2399, 3363, 3484, 3523, 4159, 4578, 11557, 26914, 26964, 26969, 27001, 28699, 33580, 44783)

	-- Glacial Waistband -- 60990
	recipe = AddRecipe(60990, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(45, 45, 55, 60, 65)
	recipe:SetCraftedItem(43584, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WAIST")
	recipe:AddTrainer(2399, 3363, 3484, 3523, 4159, 4578, 11557, 26914, 26964, 26969, 27001, 28699, 33580, 44783)

	-- Glacial Robe -- 60993
	recipe = AddRecipe(60993, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(43583, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddTrainer(2399, 3363, 3484, 3523, 4159, 4578, 11557, 26914, 26964, 26969, 27001, 28699, 33580, 44783)

	-- Glacial Slippers -- 60994
	recipe = AddRecipe(60994, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(45, 45, 55, 60, 65)
	recipe:SetCraftedItem(43585, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_FEET")
	recipe:AddTrainer(2399, 3363, 3484, 3523, 4159, 4578, 11557, 26914, 26964, 26969, 27001, 28699, 33580, 44783)

	-- Sash of Ancient Power -- 63203
	recipe = AddRecipe(63203, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(450, 450, 455, 460, 465)
	recipe:SetRecipeItem(45102, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(45102, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.ULDUAR)

	-- Spellslinger's Slippers -- 63204
	recipe = AddRecipe(63204, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(450, 450, 455, 460, 465)
	recipe:SetRecipeItem(45103, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(45566, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.ULDUAR)

	-- Cord of the White Dawn -- 63205
	recipe = AddRecipe(63205, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(450, 450, 455, 460, 465)
	recipe:SetRecipeItem(45104, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(45104, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.ULDUAR)

	-- Savior's Slippers -- 63206
	recipe = AddRecipe(63206, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(450, 450, 455, 460, 465)
	recipe:SetRecipeItem(45105, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(45567, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.ULDUAR)

	-- Spidersilk Drape -- 63742
	recipe = AddRecipe(63742, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(125, 125, 150, 167, 185)
	recipe:SetCraftedItem(45626, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BACK")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 3704, 4159, 4576, 4578, 5153, 9584, 11052, 11557, 16366, 16640, 16729, 17487, 43428, 44783, 45559, 49885)

	-- Emerald Bag -- 63924
	recipe = AddRecipe(63924, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(435, 435, 440, 445, 450)
	recipe:SetRecipeItem(45774, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(45773, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BAG")
	recipe:AddRepVendor(FAC.THE_KALUAK, REP.REVERED, 31916, 32763)

	-- Frostguard Drape -- 64729
	recipe = AddRecipe(64729, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(45811, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BACK")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(2399, 3363, 3484, 3523, 4159, 4578, 11557, 26914, 26964, 26969, 27001, 28699, 33580, 44783)

	-- Cloak of Crimson Snow -- 64730
	recipe = AddRecipe(64730, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(30, 30, 40, 45, 50)
	recipe:SetCraftedItem(45810, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BACK")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(2399, 3363, 3484, 3523, 4159, 4578, 11557, 26914, 26964, 26969, 27001, 28699, 33580, 44783)

	-- Royal Moonshroud Robe -- 67064
	recipe = AddRecipe(67064, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(450, 450, 460, 467, 475)
	recipe:SetRecipeItem(47657, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(47605, "BIND_ON_EQUIP")
	recipe:SetRequiredFaction("Alliance")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.TRIAL_OF_THE_CRUSADER)
	recipe:AddCustom("NORMAL")

	-- Royal Moonshroud Bracers -- 67065
	recipe = AddRecipe(67065, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(450, 450, 460, 467, 475)
	recipe:SetRecipeItem(47656, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(47587, "BIND_ON_EQUIP")
	recipe:SetRequiredFaction("Alliance")
	recipe:SetItemFilterType("TAILORING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.TRIAL_OF_THE_CRUSADER)
	recipe:AddCustom("NORMAL")

	-- Merlin's Robe -- 67066
	recipe = AddRecipe(67066, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(450, 450, 460, 467, 475)
	recipe:SetRecipeItem(47655, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(47603, "BIND_ON_EQUIP")
	recipe:SetRequiredFaction("Alliance")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.TRIAL_OF_THE_CRUSADER)
	recipe:AddCustom("NORMAL")

	-- Bejeweled Wizard's Bracers -- 67079
	recipe = AddRecipe(67079, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(450, 450, 460, 467, 475)
	recipe:SetRecipeItem(47654, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(47585, "BIND_ON_EQUIP")
	recipe:SetRequiredFaction("Alliance")
	recipe:SetItemFilterType("TAILORING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.TRIAL_OF_THE_CRUSADER)
	recipe:AddCustom("NORMAL")

	-- Royal Moonshroud Robe -- 67144
	recipe = AddRecipe(67144, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(450, 450, 460, 467, 475)
	recipe:SetRecipeItem(47636, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(47606, "BIND_ON_EQUIP")
	recipe:SetRequiredFaction("Horde")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.TRIAL_OF_THE_CRUSADER)
	recipe:AddCustom("NORMAL")

	-- Bejeweled Wizard's Bracers -- 67145
	recipe = AddRecipe(67145, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(450, 450, 460, 467, 475)
	recipe:SetRecipeItem(47639, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(47586, "BIND_ON_EQUIP")
	recipe:SetRequiredFaction("Horde")
	recipe:SetItemFilterType("TAILORING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.TRIAL_OF_THE_CRUSADER)
	recipe:AddCustom("NORMAL")

	-- Merlin's Robe -- 67146
	recipe = AddRecipe(67146, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(450, 450, 460, 467, 475)
	recipe:SetRecipeItem(47638, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(47604, "BIND_ON_EQUIP")
	recipe:SetRequiredFaction("Horde")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.TRIAL_OF_THE_CRUSADER)
	recipe:AddCustom("NORMAL")

	-- Royal Moonshroud Bracers -- 67147
	recipe = AddRecipe(67147, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(450, 450, 460, 467, 475)
	recipe:SetRecipeItem(47637, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(47588, "BIND_ON_EQUIP")
	recipe:SetRequiredFaction("Horde")
	recipe:SetItemFilterType("TAILORING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.TRIAL_OF_THE_CRUSADER)
	recipe:AddCustom("NORMAL")

	-- Leggings of Woven Death -- 70550
	recipe = AddRecipe(70550, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(450, 450, 475, 487, 500)
	recipe:SetRecipeItem(49953, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(49891, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddRepVendor(FAC.THE_ASHEN_VERDICT, REP.REVERED, 37687)

	-- Deathfrost Boots -- 70551
	recipe = AddRecipe(70551, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(450, 450, 475, 487, 500)
	recipe:SetRecipeItem(49954, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(49890, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddRepVendor(FAC.THE_ASHEN_VERDICT, REP.HONORED, 37687)

	-- Lightweave Leggings -- 70552
	recipe = AddRecipe(70552, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(450, 450, 475, 487, 500)
	recipe:SetRecipeItem(49955, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(49892, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddRepVendor(FAC.THE_ASHEN_VERDICT, REP.REVERED, 37687)

	-- Sandals of Consecration -- 70553
	recipe = AddRecipe(70553, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(450, 450, 475, 487, 500)
	recipe:SetRecipeItem(49956, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(49893, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddRepVendor(FAC.THE_ASHEN_VERDICT, REP.HONORED, 37687)

	-- Frosty Flying Carpet -- 75597
	recipe = AddRecipe(75597, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(425, 425, 435, 445, 455)
	recipe:SetRecipeItem(54798, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(54797, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("TAILORING_MISC")
	recipe:AddVendor(40160)

	-- Relic of the Past I -- 330232
	recipe = AddRecipe(330232, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(180055, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_MATERIALS")
	recipe:AddTrainer(28699)

	-- Relic of the Past II -- 330233
	recipe = AddRecipe(330233, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(180057, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_MATERIALS")
	recipe:AddTrainer(28699)

	-- Relic of the Past III -- 330234
	recipe = AddRecipe(330234, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(180058, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_MATERIALS")
	recipe:AddTrainer(28699)

	-- Relic of the Past IV -- 330235
	recipe = AddRecipe(330235, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(180059, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_MATERIALS")
	recipe:AddTrainer(28699)

	-- Relic of the Past V -- 330236
	recipe = AddRecipe(330236, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(180060, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_MATERIALS")
	recipe:AddTrainer(28699)

	-- ----------------------------------------------------------------------------
	-- Cataclysm.
	-- ----------------------------------------------------------------------------
	-- Bolt of Embersilk Cloth -- 74964
	recipe = AddRecipe(74964, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(53643, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_MATERIALS")
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 4159, 4576, 4578, 5153, 9584, 11052, 11557, 16640, 16729, 17487, 27001, 44783, 45559)

	-- Dream of Skywall -- 75141
	recipe = AddRecipe(75141, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(65, 65, 75, 80, 85)
	recipe:SetCraftedItem(54440, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_MATERIALS")
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 4159, 4576, 4578, 5153, 9584, 11052, 11557, 16640, 16729, 17487, 27001, 44783, 45559)

	-- Dream of Deepholm -- 75142
	recipe = AddRecipe(75142, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(55, 55, 65, 70, 75)
	recipe:SetCraftedItem(54440, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_MATERIALS")
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 4159, 4576, 4578, 5153, 9584, 11052, 11557, 16640, 16729, 17487, 27001, 44783, 45559)

	-- Dream of Hyjal -- 75144
	recipe = AddRecipe(75144, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(54440, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_MATERIALS")
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 4159, 4576, 4578, 5153, 9584, 11052, 11557, 16640, 16729, 17487, 27001, 44783, 45559)

	-- Dream of Ragnaros -- 75145
	recipe = AddRecipe(75145, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(60, 60, 70, 75, 80)
	recipe:SetCraftedItem(54440, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_MATERIALS")
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 4159, 4576, 4578, 5153, 9584, 11052, 11557, 16640, 16729, 17487, 27001, 44783, 45559)

	-- Dream of Azshara -- 75146
	recipe = AddRecipe(75146, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(54440, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_MATERIALS")
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 4159, 4576, 4578, 5153, 9584, 11052, 11557, 16640, 16729, 17487, 27001, 44783, 45559)

	-- Embersilk Net -- 75247
	recipe = AddRecipe(75247, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(54442, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_MISC")
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 4159, 4576, 4578, 5153, 9584, 11052, 11557, 16640, 16729, 17487, 27001, 44783, 45559)

	-- Deathsilk Belt -- 75248
	recipe = AddRecipe(75248, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(54471, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 4159, 4576, 4578, 5153, 9584, 11052, 11557, 16640, 16729, 17487, 27001, 44783, 45559)

	-- Deathsilk Bracers -- 75249
	recipe = AddRecipe(75249, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(54473, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 4159, 4576, 4578, 5153, 9584, 11052, 11557, 16640, 16729, 17487, 27001, 44783, 45559)

	-- Enchanted Spellthread -- 75250
	recipe = AddRecipe(75250, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(54447, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 4159, 4576, 4578, 5153, 9584, 11052, 11557, 16640, 16729, 17487, 27001, 44783, 45559)

	-- Deathsilk Shoulders -- 75251
	recipe = AddRecipe(75251, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(5, 5, 15, 20, 25)
	recipe:SetCraftedItem(54474, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 4159, 4576, 4578, 5153, 9584, 11052, 11557, 16640, 16729, 17487, 27001, 44783, 45559)

	-- Deathsilk Boots -- 75252
	recipe = AddRecipe(75252, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(5, 5, 15, 20, 25)
	recipe:SetCraftedItem(54477, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 4159, 4576, 4578, 5153, 9584, 11052, 11557, 16640, 16729, 17487, 27001, 44783, 45559)

	-- Deathsilk Gloves -- 75253
	recipe = AddRecipe(75253, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(10, 10, 20, 25, 30)
	recipe:SetCraftedItem(54478, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 4159, 4576, 4578, 5153, 9584, 11052, 11557, 16640, 16729, 17487, 27001, 44783, 45559)

	-- Deathsilk Leggings -- 75254
	recipe = AddRecipe(75254, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(10, 10, 20, 25, 30)
	recipe:SetCraftedItem(54472, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 4159, 4576, 4578, 5153, 9584, 11052, 11557, 16640, 16729, 17487, 27001, 44783, 45559)

	-- Ghostly Spellthread -- 75255
	recipe = AddRecipe(75255, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(10, 10, 20, 25, 30)
	recipe:SetCraftedItem(54449, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 4159, 4576, 4578, 5153, 9584, 11052, 11557, 16640, 16729, 17487, 27001, 44783, 45559)

	-- Deathsilk Cowl -- 75256
	recipe = AddRecipe(75256, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(15, 15, 25, 30, 35)
	recipe:SetCraftedItem(54476, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 4159, 4576, 4578, 5153, 9584, 11052, 11557, 16640, 16729, 17487, 27001, 44783, 45559)

	-- Deathsilk Robe -- 75257
	recipe = AddRecipe(75257, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(15, 15, 25, 30, 35)
	recipe:SetCraftedItem(54475, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 4159, 4576, 4578, 5153, 9584, 11052, 11557, 16640, 16729, 17487, 27001, 44783, 45559)

	-- Spiritmend Belt -- 75258
	recipe = AddRecipe(75258, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(20, 20, 30, 35, 40)
	recipe:SetCraftedItem(54481, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 4159, 4576, 4578, 5153, 9584, 11052, 11557, 16640, 16729, 17487, 27001, 44783, 45559)

	-- Spiritmend Bracers -- 75259
	recipe = AddRecipe(75259, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(20, 20, 30, 35, 40)
	recipe:SetCraftedItem(54480, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 4159, 4576, 4578, 5153, 9584, 11052, 11557, 16640, 16729, 17487, 27001, 44783, 45559)

	-- Spiritmend Shoulders -- 75260
	recipe = AddRecipe(75260, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(54479, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 4159, 4576, 4578, 5153, 9584, 11052, 11557, 16640, 16729, 17487, 27001, 44783, 45559)

	-- Spiritmend Boots -- 75261
	recipe = AddRecipe(75261, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(54482, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 4159, 4576, 4578, 5153, 9584, 11052, 11557, 16640, 16729, 17487, 27001, 44783, 45559)

	-- Spiritmend Gloves -- 75262
	recipe = AddRecipe(75262, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(30, 30, 40, 45, 50)
	recipe:SetCraftedItem(54484, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HANDS")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 4159, 4576, 4578, 5153, 9584, 11052, 11557, 16640, 16729, 17487, 27001, 44783, 45559)

	-- Spiritmend Leggings -- 75263
	recipe = AddRecipe(75263, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(30, 30, 40, 45, 50)
	recipe:SetCraftedItem(54483, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 4159, 4576, 4578, 5153, 9584, 11052, 11557, 16640, 16729, 17487, 27001, 44783, 45559)

	-- Embersilk Bag -- 75264
	recipe = AddRecipe(75264, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(30, 30, 40, 45, 50)
	recipe:SetCraftedItem(54443, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BAG")
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 4159, 4576, 4578, 5153, 9584, 11052, 11557, 16640, 16729, 17487, 27001, 44783, 45559)

	-- Otherworldly Bag -- 75265
	recipe = AddRecipe(75265, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(30, 30, 40, 45, 50)
	recipe:SetCraftedItem(54445, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BAG")
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 4159, 4576, 4578, 5153, 9584, 11052, 11557, 16640, 16729, 17487, 27001, 44783, 45559)

	-- Spiritmend Cowl -- 75266
	recipe = AddRecipe(75266, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(35, 35, 45, 50, 55)
	recipe:SetCraftedItem(54485, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 4159, 4576, 4578, 5153, 9584, 11052, 11557, 16640, 16729, 17487, 27001, 44783, 45559)

	-- Spiritmend Robe -- 75267
	recipe = AddRecipe(75267, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(35, 35, 45, 50, 55)
	recipe:SetCraftedItem(54486, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 4159, 4576, 4578, 5153, 9584, 11052, 11557, 16640, 16729, 17487, 27001, 44783, 45559)

	-- Hyjal Expedition Bag -- 75268
	recipe = AddRecipe(75268, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(40, 40, 50, 55, 60)
	recipe:SetCraftedItem(54446, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BAG")
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 4159, 4576, 4578, 5153, 9584, 11052, 11557, 16640, 16729, 17487, 27001, 44783, 45559)

	-- Vicious Fireweave Belt -- 75269
	recipe = AddRecipe(75269, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(60, 60, 70, 75, 80)
	recipe:SetCraftedItem(75086, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 4159, 4576, 4578, 5153, 9584, 11052, 11557, 16640, 16729, 17487, 44783, 45559)

	-- Vicious Embersilk Bracers -- 75270
	recipe = AddRecipe(75270, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(75098, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 4159, 4576, 4578, 5153, 9584, 11052, 11557, 16640, 16729, 17487, 44783, 45559)

	-- Black Embersilk Gown -- 75288
	recipe = AddRecipe(75288, V.CATA, Q.RARE)
	recipe:SetSkillLevels(500, 500, 505, 510, 515)
	recipe:SetRecipeItem(68199, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(54441, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddVendor(1347, 3005, 3364, 4168, 4577, 5154, 16638, 16767, 45558, 50386, 50433)

	-- High Society Top Hat -- 75289
	recipe = AddRecipe(75289, V.CATA, Q.RARE)
	recipe:SetSkillLevels(500, 500, 530, 535, 540)
	recipe:SetRecipeItem(67541, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(54451, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HEAD")
	recipe:AddMobDrop(50005, 50009, 50056, 50061, 50063, 50089)

	-- Vicious Fireweave Bracers -- 75290
	recipe = AddRecipe(75290, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(75089, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WRIST")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 4159, 4576, 4578, 5153, 9584, 11052, 11557, 16640, 16729, 17487, 44783, 45559)

	-- Vicious Embersilk Shoulders -- 75291
	recipe = AddRecipe(75291, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(55, 55, 65, 70, 75)
	recipe:SetCraftedItem(75064, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 4159, 4576, 4578, 5153, 9584, 11052, 11557, 16640, 16729, 17487, 44783, 45559)

	-- Vicious Fireweave Shoulders -- 75292
	recipe = AddRecipe(75292, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(60, 60, 70, 75, 80)
	recipe:SetCraftedItem(75091, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 4159, 4576, 4578, 5153, 9584, 11052, 11557, 16640, 16729, 17487, 44783, 45559)

	-- Vicious Embersilk Belt -- 75293
	recipe = AddRecipe(75293, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(60, 60, 70, 75, 80)
	recipe:SetCraftedItem(75096, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WAIST")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 4159, 4576, 4578, 5153, 9584, 11052, 11557, 16640, 16729, 17487, 44783, 45559)

	-- Vicious Fireweave Boots -- 75294
	recipe = AddRecipe(75294, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(65, 65, 75, 80, 85)
	recipe:SetCraftedItem(75087, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_FEET")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 4159, 4576, 4578, 5153, 9584, 11052, 11557, 16640, 16729, 17487, 44783, 45559)

	-- Vicious Embersilk Gloves -- 75295
	recipe = AddRecipe(75295, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(65, 65, 75, 80, 85)
	recipe:SetCraftedItem(75070, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 4159, 4576, 4578, 5153, 9584, 11052, 11557, 16640, 16729, 17487, 44783, 45559)

	-- Vicious Fireweave Gloves -- 75296
	recipe = AddRecipe(75296, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(70, 70, 80, 85, 90)
	recipe:SetCraftedItem(75063, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HANDS")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 4159, 4576, 4578, 5153, 9584, 11052, 11557, 16640, 16729, 17487, 44783, 45559)

	-- Vicious Embersilk Boots -- 75297
	recipe = AddRecipe(75297, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(70, 70, 80, 85, 90)
	recipe:SetCraftedItem(75095, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 4159, 4576, 4578, 5153, 9584, 11052, 11557, 16640, 16729, 17487, 44783, 45559)

	-- Belt of the Depths -- 75298
	recipe = AddRecipe(75298, V.CATA, Q.RARE)
	recipe:SetSkillLevels(525, 525, 525, 530, 535)
	recipe:SetRecipeItem(54601, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(54504, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WAIST")
	recipe:AddVendor(1347, 3005, 3364, 4168, 4577, 5154, 16638, 16767, 45558, 50386, 50433)

	-- Dreamless Belt -- 75299
	recipe = AddRecipe(75299, V.CATA, Q.RARE)
	recipe:SetSkillLevels(525, 525, 525, 530, 535)
	recipe:SetRecipeItem(54602, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(54503, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WAIST")
	recipe:AddVendor(1347, 3005, 3364, 4168, 4577, 5154, 16638, 16767, 45558, 50386, 50433)

	-- Breeches of Mended Nightmares -- 75300
	recipe = AddRecipe(75300, V.CATA, Q.RARE)
	recipe:SetSkillLevels(525, 525, 525, 530, 535)
	recipe:SetRecipeItem(54603, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(54505, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_LEGS")
	recipe:AddVendor(1347, 3005, 3364, 4168, 4577, 5154, 16638, 16767, 45558, 50386, 50433)

	-- Flame-Ascended Pantaloons -- 75301
	recipe = AddRecipe(75301, V.CATA, Q.RARE)
	recipe:SetSkillLevels(525, 525, 525, 530, 535)
	recipe:SetRecipeItem(54604, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(54506, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_LEGS")
	recipe:AddVendor(1347, 3005, 3364, 4168, 4577, 5154, 16638, 16767, 45558, 50386, 50433)

	-- Vicious Fireweave Pants -- 75302
	recipe = AddRecipe(75302, V.CATA, Q.RARE)
	recipe:SetSkillLevels(525, 525, 525, 530, 535)
	recipe:SetRecipeItem(54597, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(54491, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_LEGS")
	recipe:AddVendor(1347, 3005, 3364, 4168, 4577, 5154, 16638, 16767, 45558, 50386, 50433)

	-- Vicious Fireweave Robe -- 75303
	recipe = AddRecipe(75303, V.CATA, Q.RARE)
	recipe:SetSkillLevels(525, 525, 525, 530, 535)
	recipe:SetRecipeItem(54598, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(54494, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddVendor(1347, 3005, 3364, 4168, 4577, 5154, 16638, 16767, 45558, 50386, 50433)

	-- Vicious Fireweave Cowl -- 75304
	recipe = AddRecipe(75304, V.CATA, Q.RARE)
	recipe:SetSkillLevels(525, 525, 525, 530, 535)
	recipe:SetRecipeItem(54596, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(54493, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HEAD")
	recipe:AddVendor(1347, 3005, 3364, 4168, 4577, 5154, 16638, 16767, 45558, 50386, 50433)

	-- Vicious Embersilk Robe -- 75305
	recipe = AddRecipe(75305, V.CATA, Q.RARE)
	recipe:SetSkillLevels(525, 525, 525, 530, 535)
	recipe:SetRecipeItem(54595, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(54495, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddVendor(1347, 3005, 3364, 4168, 4577, 5154, 16638, 16767, 45558, 50386, 50433)

	-- Vicious Embersilk Cowl -- 75306
	recipe = AddRecipe(75306, V.CATA, Q.RARE)
	recipe:SetSkillLevels(525, 525, 525, 530, 535)
	recipe:SetRecipeItem(54593, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(54496, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HEAD")
	recipe:AddVendor(1347, 3005, 3364, 4168, 4577, 5154, 16638, 16767, 45558, 50386, 50433)

	-- Vicious Embersilk Pants -- 75307
	recipe = AddRecipe(75307, V.CATA, Q.RARE)
	recipe:SetSkillLevels(525, 525, 525, 530, 535)
	recipe:SetRecipeItem(54594, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(54498, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_LEGS")
	recipe:AddVendor(1347, 3005, 3364, 4168, 4577, 5154, 16638, 16767, 45558, 50386, 50433)

	-- Illusionary Bag -- 75308
	recipe = AddRecipe(75308, V.CATA, Q.RARE)
	recipe:SetSkillLevels(525, 525, 525, 530, 535)
	recipe:SetRecipeItem(54605, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(54444, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BAG")
	recipe:AddVendor(1347, 3005, 3364, 4168, 4577, 5154, 16638, 16767, 45558, 50386, 50433)

	-- Powerful Enchanted Spellthread -- 75309
	recipe = AddRecipe(75309, V.CATA, Q.RARE)
	recipe:SetSkillLevels(525, 525, 525, 530, 535)
	recipe:SetRecipeItem(54599, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(54448, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_ITEM_ENHANCEMENT")
	recipe:AddVendor(1347, 3005, 3364, 4168, 4577, 5154, 16638, 16767, 45558, 50386, 50433)

	-- Powerful Ghostly Spellthread -- 75310
	recipe = AddRecipe(75310, V.CATA, Q.RARE)
	recipe:SetSkillLevels(525, 525, 525, 530, 535)
	recipe:SetRecipeItem(54600, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(54450, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_ITEM_ENHANCEMENT")
	recipe:AddVendor(1347, 3005, 3364, 4168, 4577, 5154, 16638, 16767, 45558, 50386, 50433)

	-- Dream of Destruction -- 94743
	recipe = AddRecipe(94743, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 85, 90, 95)
	recipe:SetCraftedItem(54440, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_MATERIALS")
	recipe:AddTrainer(1103, 1346, 2399, 2627, 3004, 3363, 3484, 3523, 4159, 4576, 4578, 5153, 9584, 11052, 11557, 16640, 16729, 17487, 27001, 44783, 45559)

	-- Grips of Altered Reality -- 99448
	recipe = AddRecipe(99448, V.CATA, Q.EPIC)
	recipe:SetSkillLevels(525, 525, 525, 527, 530)
	recipe:SetRecipeItem(69965, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(69944, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.FIRELANDS)

	-- Don Tayo's Inferno Mittens -- 99449
	recipe = AddRecipe(99449, V.CATA, Q.EPIC)
	recipe:SetSkillLevels(525, 525, 525, 527, 530)
	recipe:SetRecipeItem(69966, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(69945, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.FIRELANDS)

	-- Endless Dream Walkers -- 99459
	recipe = AddRecipe(99459, V.CATA, Q.EPIC)
	recipe:SetSkillLevels(525, 525, 525, 527, 530)
	recipe:SetRecipeItem(69975, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(69953, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.FIRELANDS)

	-- Boots of the Black Flame -- 99460
	recipe = AddRecipe(99460, V.CATA, Q.EPIC)
	recipe:SetSkillLevels(525, 525, 525, 527, 530)
	recipe:SetRecipeItem(69976, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(69954, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.FIRELANDS)

	-- Vicious Embersilk Cape -- 99537
	recipe = AddRecipe(99537, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(40, 40, 50, 55, 60)
	recipe:SetCraftedItem(75065, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BACK")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(1103, 1346, 2627, 3004, 3363, 3484, 3523, 4159, 4576, 4578, 5153, 9584, 11052, 11557, 16640, 16729, 17487, 45559)

	-- Luxurious Silk Gem Bag -- 100585
	recipe = AddRecipe(100585, V.CATA, Q.RARE)
	recipe:SetSkillLevels(515, 515, 515, 515, 515)
	recipe:SetRecipeItem(70176, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(70138, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BAG")
	recipe:AddVendor(53881)

	-- World Mender's Pants -- 101920
	recipe = AddRecipe(101920, V.CATA, Q.EPIC)
	recipe:SetSkillLevels(525, 525, 525, 527, 530)
	recipe:SetRecipeItem(72000, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(71981, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_LEGS")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddWorldDrop(Z.DRAGON_SOUL)

	-- Lavaquake Legwraps -- 101921
	recipe = AddRecipe(101921, V.CATA, Q.EPIC)
	recipe:SetSkillLevels(525, 525, 525, 527, 530)
	recipe:SetRecipeItem(72002, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(71980, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.DRAGON_SOUL)

	-- Dreamwraps of the Light -- 101922
	recipe = AddRecipe(101922, V.CATA, Q.EPIC)
	recipe:SetSkillLevels(525, 525, 525, 527, 530)
	recipe:SetRecipeItem(72003, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(71990, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.DRAGON_SOUL)

	-- Bracers of Unconquered Power -- 101923
	recipe = AddRecipe(101923, V.CATA, Q.EPIC)
	recipe:SetSkillLevels(525, 525, 525, 527, 530)
	recipe:SetRecipeItem(72004, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(71989, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.DRAGON_SOUL)

	-- Relic of the Past I -- 330237
	recipe = AddRecipe(330237, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(180055, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_MATERIALS")
	recipe:AddTrainer(1346, 3004, 4576, 5153, 16640, 45559)

	-- Relic of the Past II -- 330238
	recipe = AddRecipe(330238, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(180057, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_MATERIALS")
	recipe:AddTrainer(1346, 3004, 4576, 5153, 16640, 45559)

	-- Relic of the Past III -- 330239
	recipe = AddRecipe(330239, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(180058, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_MATERIALS")
	recipe:AddTrainer(1346, 3004, 4576, 5153, 16640, 45559)

	-- Relic of the Past IV -- 330240
	recipe = AddRecipe(330240, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(180059, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_MATERIALS")
	recipe:AddTrainer(1346, 3004, 4576, 5153, 16640, 45559)

	-- Relic of the Past V -- 330241
	recipe = AddRecipe(330241, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(180060, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_MATERIALS")
	recipe:AddTrainer(1346, 3004, 4576, 5153, 16640, 45559)

	-- ----------------------------------------------------------------------------
	-- Mists of Pandaria.
	-- ----------------------------------------------------------------------------
	-- Master's Spellthread -- 125496
	recipe = AddRecipe(125496, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(550, 550, 550, 550, 550)
	recipe:SetItemFilterType("TAILORING_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddDiscovery("DISCOVERY_AUTOLEARN")

	-- Sanctified Spellthread -- 125497
	recipe = AddRecipe(125497, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(550, 550, 550, 550, 550)
	recipe:SetItemFilterType("TAILORING_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddDiscovery("DISCOVERY_AUTOLEARN")

	-- Windwool Hood -- 125523
	recipe = AddRecipe(125523, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(30, 30, 40, 45, 50)
	recipe:SetCraftedItem(82397, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HEAD")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(2399, 3363, 3484, 3523, 4159, 4578, 11557, 44783, 57405)

	-- Windwool Shoulders -- 125524
	recipe = AddRecipe(125524, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(10, 10, 20, 25, 30)
	recipe:SetCraftedItem(82398, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(2399, 3363, 3484, 3523, 4159, 4578, 11557, 44783, 57405)

	-- Windwool Tunic -- 125525
	recipe = AddRecipe(125525, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(30, 30, 40, 45, 50)
	recipe:SetCraftedItem(82399, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(2399, 3363, 3484, 3523, 4159, 4578, 11557, 44783, 57405)

	-- Windwool Gloves -- 125526
	recipe = AddRecipe(125526, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(82400, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HANDS")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(2399, 3363, 3484, 3523, 4159, 4578, 11557, 44783, 57405)

	-- Windwool Pants -- 125527
	recipe = AddRecipe(125527, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(20, 20, 30, 35, 40)
	recipe:SetCraftedItem(82401, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_LEGS")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(2399, 3363, 3484, 3523, 4159, 4578, 11557, 44783, 57405)

	-- Windwool Bracers -- 125528
	recipe = AddRecipe(125528, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(82402, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WRIST")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(2399, 3363, 3484, 3523, 4159, 4578, 11557, 44783, 57405)

	-- Windwool Boots -- 125529
	recipe = AddRecipe(125529, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(20, 20, 30, 35, 40)
	recipe:SetCraftedItem(82403, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_FEET")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(2399, 3363, 3484, 3523, 4159, 4578, 11557, 44783, 57405)

	-- Windwool Belt -- 125530
	recipe = AddRecipe(125530, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(10, 10, 20, 25, 30)
	recipe:SetCraftedItem(82404, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WAIST")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(2399, 3363, 3484, 3523, 4159, 4578, 11557, 44783, 57405)

	-- Contender's Silk Cowl -- 125531
	recipe = AddRecipe(125531, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(590, 590, 590, 590, 600)
	recipe:SetRecipeItem(86352, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(82421, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(64051, 64052)

	-- Contender's Silk Amice -- 125532
	recipe = AddRecipe(125532, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(575, 575, 575, 575, 600)
	recipe:SetRecipeItem(86353, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(82422, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(64051, 64052)

	-- Contender's Silk Raiment -- 125533
	recipe = AddRecipe(125533, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(590, 590, 590, 590, 600)
	recipe:SetRecipeItem(86354, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(82423, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(64051, 64052)

	-- Contender's Silk Handwraps -- 125534
	recipe = AddRecipe(125534, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(565, 565, 565, 565, 600)
	recipe:SetRecipeItem(86355, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(82424, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(64051, 64052)

	-- Contender's Silk Pants -- 125535
	recipe = AddRecipe(125535, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(565, 565, 565, 565, 600)
	recipe:SetRecipeItem(86356, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(82425, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(64051, 64052)

	-- Contender's Silk Cuffs -- 125536
	recipe = AddRecipe(125536, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(555, 555, 555, 555, 600)
	recipe:SetRecipeItem(86357, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(82426, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(64051, 64052)

	-- Contender's Silk Footwraps -- 125537
	recipe = AddRecipe(125537, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(565, 565, 565, 565, 600)
	recipe:SetRecipeItem(86358, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(82427, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(64051, 64052)

	-- Contender's Silk Belt -- 125538
	recipe = AddRecipe(125538, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(565, 565, 565, 565, 600)
	recipe:SetRecipeItem(86359, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(82428, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(64051, 64052)

	-- Contender's Satin Cowl -- 125539
	recipe = AddRecipe(125539, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(590, 590, 590, 590, 600)
	recipe:SetRecipeItem(86360, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(82429, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(64051, 64052)

	-- Contender's Satin Amice -- 125540
	recipe = AddRecipe(125540, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(575, 575, 575, 575, 600)
	recipe:SetRecipeItem(86361, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(82430, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(64051, 64052)

	-- Contender's Satin Raiment -- 125541
	recipe = AddRecipe(125541, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(590, 590, 590, 590, 600)
	recipe:SetRecipeItem(86362, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(82431, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(64051, 64052)

	-- Contender's Satin Handwraps -- 125542
	recipe = AddRecipe(125542, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(565, 565, 565, 565, 600)
	recipe:SetRecipeItem(86363, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(82432, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(64051, 64052)

	-- Contender's Satin Pants -- 125543
	recipe = AddRecipe(125543, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(565, 565, 565, 565, 600)
	recipe:SetRecipeItem(86364, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(82433, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(64051, 64052)

	-- Contender's Satin Cuffs -- 125544
	recipe = AddRecipe(125544, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(555, 555, 555, 555, 600)
	recipe:SetRecipeItem(86365, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(82434, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(64051, 64052)

	-- Contender's Satin Footwraps -- 125545
	recipe = AddRecipe(125545, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(565, 565, 565, 565, 600)
	recipe:SetRecipeItem(86366, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(82435, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(64051, 64052)

	-- Contender's Satin Belt -- 125546
	recipe = AddRecipe(125546, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(565, 565, 565, 565, 600)
	recipe:SetRecipeItem(86367, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(82436, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(64051, 64052)

	-- Spelltwister's Grand Robe -- 125547
	recipe = AddRecipe(125547, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 600, 600)
	recipe:SetRecipeItem(86368, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(82437, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddRepVendor(FAC.GOLDEN_LOTUS, REP.HONORED, 59908)

	-- Spelltwister's Gloves -- 125548
	recipe = AddRecipe(125548, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 600, 600)
	recipe:SetRecipeItem(86369, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(82438, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddRepVendor(FAC.GOLDEN_LOTUS, REP.HONORED, 59908)

	-- Robes of Creation -- 125549
	recipe = AddRecipe(125549, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 600, 600)
	recipe:SetRecipeItem(86370, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(82439, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddRepVendor(FAC.GOLDEN_LOTUS, REP.HONORED, 59908)

	-- Gloves of Creation -- 125550
	recipe = AddRecipe(125550, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 600, 600)
	recipe:SetRecipeItem(86371, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(82440, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddRepVendor(FAC.GOLDEN_LOTUS, REP.HONORED, 59908)

	-- Bolt of Windwool Cloth -- 125551
	recipe = AddRecipe(125551, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(82441, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_MATERIALS")
	recipe:AddTrainer(2399, 3363, 3484, 3523, 4159, 4578, 11557, 44783, 57405)

	-- Pearlescent Spellthread -- 125552
	recipe = AddRecipe(125552, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(5, 5, 15, 20, 25)
	recipe:SetCraftedItem(82442, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(2399, 3363, 3484, 3523, 4159, 4578, 11557, 44783, 57405)

	-- Cerulean Spellthread -- 125553
	recipe = AddRecipe(125553, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(15, 15, 25, 30, 35)
	recipe:SetCraftedItem(82443, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(2399, 3363, 3484, 3523, 4159, 4578, 11557, 44783, 57405)

	-- Greater Pearlescent Spellthread -- 125554
	recipe = AddRecipe(125554, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(575, 575, 575, 575, 600)
	recipe:SetRecipeItem(86375, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(82444, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddRepVendor(FAC.GOLDEN_LOTUS, REP.HONORED, 59908)

	-- Greater Cerulean Spellthread -- 125555
	recipe = AddRecipe(125555, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(575, 575, 575, 575, 600)
	recipe:SetRecipeItem(86376, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(82445, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddRepVendor(FAC.GOLDEN_LOTUS, REP.HONORED, 59908)

	-- Royal Satchel -- 125556
	recipe = AddRecipe(125556, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 600, 600)
	recipe:SetRecipeItem(86377, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(82446, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BAG")
	recipe:AddRepVendor(FAC.THE_AUGUST_CELESTIALS, REP.EXALTED, 64001, 64032)

	-- Imperial Silk -- 125557
	recipe = AddRecipe(125557, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(92960, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("TAILORING_MATERIALS")
	recipe:AddTrainer(2399, 3363, 3484, 3523, 4159, 4578, 11557, 44783, 57405)

	-- Robe of Eternal Rule -- 125558
	recipe = AddRecipe(125558, V.MOP, Q.EPIC)
	recipe:SetSkillLevels(600, 600, 600, 600, 600)
	recipe:SetRecipeItem(86379, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(86311, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.HEART_OF_FEAR, Z.MOGUSHAN_VAULTS, Z.TERRACE_OF_ENDLESS_SPRING)

	-- Imperial Silk Gloves -- 125559
	recipe = AddRecipe(125559, V.MOP, Q.EPIC)
	recipe:SetSkillLevels(600, 600, 600, 600, 600)
	recipe:SetRecipeItem(86380, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(86313, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.HEART_OF_FEAR, Z.MOGUSHAN_VAULTS, Z.TERRACE_OF_ENDLESS_SPRING)

	-- Legacy of the Emperor -- 125560
	recipe = AddRecipe(125560, V.MOP, Q.EPIC)
	recipe:SetSkillLevels(600, 600, 600, 600, 600)
	recipe:SetRecipeItem(86381, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(86312, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.HEART_OF_FEAR, Z.MOGUSHAN_VAULTS, Z.TERRACE_OF_ENDLESS_SPRING)

	-- Touch of the Light -- 125561
	recipe = AddRecipe(125561, V.MOP, Q.EPIC)
	recipe:SetSkillLevels(600, 600, 600, 600, 600)
	recipe:SetRecipeItem(86382, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(86314, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.HEART_OF_FEAR, Z.MOGUSHAN_VAULTS, Z.TERRACE_OF_ENDLESS_SPRING)

	-- Song of Harmony -- 130325
	recipe = AddRecipe(130325, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(35, 35, 45, 50, 55)
	recipe:SetCraftedItem(82447, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("TAILORING_MATERIALS")
	recipe:AddTrainer(2399, 3363, 3484, 3523, 4159, 4578, 11557, 44783, 57405)

	-- Bipsi's Gloves -- 134585
	recipe = AddRecipe(134585, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(65, 65, 75, 80, 85)
	recipe:SetCraftedItem(92726, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(1103, 1346, 2627, 3004, 3363, 3484, 3523, 4159, 4576, 4578, 5153, 9584, 11052, 11557, 16640, 16729, 17487, 45559)

	-- Crafted Dreadful Gladiator's Cape of Cruelty -- 137907
	recipe = AddRecipe(137907, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetCraftedItem(93420, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BACK")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.DRUID, F.HUNTER, F.SHAMAN, F.ROGUE, F.MONK)
	recipe:AddDiscovery("DISCOVERY_TAILOR_PANDARIA")

	-- Crafted Dreadful Gladiator's Cape of Prowess -- 137908
	recipe = AddRecipe(137908, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetCraftedItem(93421, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BACK")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.DRUID, F.HUNTER, F.SHAMAN, F.ROGUE, F.MONK)
	recipe:AddDiscovery("DISCOVERY_TAILOR_PANDARIA")

	-- Crafted Dreadful Gladiator's Cord of Cruelty -- 137909
	recipe = AddRecipe(137909, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetCraftedItem(93428, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.MAGE, F.PRIEST, F.WARLOCK)
	recipe:AddDiscovery("DISCOVERY_TAILOR_PANDARIA")

	-- Crafted Dreadful Gladiator's Cord of Accuracy -- 137910
	recipe = AddRecipe(137910, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetCraftedItem(93429, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.MAGE, F.PRIEST, F.WARLOCK)
	recipe:AddDiscovery("DISCOVERY_TAILOR_PANDARIA")

	-- Crafted Dreadful Gladiator's Cord of Meditation -- 137911
	recipe = AddRecipe(137911, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetCraftedItem(93430, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.MAGE, F.PRIEST, F.WARLOCK)
	recipe:AddDiscovery("DISCOVERY_TAILOR_PANDARIA")

	-- Crafted Dreadful Gladiator's Treads of Cruelty -- 137912
	recipe = AddRecipe(137912, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetCraftedItem(93431, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.MAGE, F.PRIEST, F.WARLOCK)
	recipe:AddDiscovery("DISCOVERY_TAILOR_PANDARIA")

	-- Crafted Dreadful Gladiator's Treads of Alacrity -- 137913
	recipe = AddRecipe(137913, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetCraftedItem(93432, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.MAGE, F.PRIEST, F.WARLOCK)
	recipe:AddDiscovery("DISCOVERY_TAILOR_PANDARIA")

	-- Crafted Dreadful Gladiator's Treads of Meditation -- 137914
	recipe = AddRecipe(137914, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetCraftedItem(93433, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.MAGE, F.PRIEST, F.WARLOCK)
	recipe:AddDiscovery("DISCOVERY_TAILOR_PANDARIA")

	-- Crafted Dreadful Gladiator's Cuffs of Accuracy -- 137915
	recipe = AddRecipe(137915, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetCraftedItem(93434, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.MAGE, F.PRIEST, F.WARLOCK)
	recipe:AddDiscovery("DISCOVERY_TAILOR_PANDARIA")

	-- Crafted Dreadful Gladiator's Cuffs of Prowess -- 137916
	recipe = AddRecipe(137916, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetCraftedItem(93435, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.MAGE, F.PRIEST, F.WARLOCK)
	recipe:AddDiscovery("DISCOVERY_TAILOR_PANDARIA")

	-- Crafted Dreadful Gladiator's Cuffs of Meditation -- 137917
	recipe = AddRecipe(137917, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetCraftedItem(93436, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.MAGE, F.PRIEST, F.WARLOCK)
	recipe:AddDiscovery("DISCOVERY_TAILOR_PANDARIA")

	-- Crafted Dreadful Gladiator's Drape of Cruelty -- 137918
	recipe = AddRecipe(137918, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetCraftedItem(93437, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BACK")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.DRUID, F.MAGE, F.PALADIN, F.PRIEST, F.SHAMAN, F.WARLOCK, F.MONK)
	recipe:AddDiscovery("DISCOVERY_TAILOR_PANDARIA")

	-- Crafted Dreadful Gladiator's Drape of Prowess -- 137919
	recipe = AddRecipe(137919, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetCraftedItem(93438, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BACK")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.DRUID, F.MAGE, F.PALADIN, F.PRIEST, F.SHAMAN, F.WARLOCK, F.MONK)
	recipe:AddDiscovery("DISCOVERY_TAILOR_PANDARIA")

	-- Crafted Dreadful Gladiator's Drape of Meditation -- 137920
	recipe = AddRecipe(137920, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetCraftedItem(93439, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BACK")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.DRUID, F.PALADIN, F.PRIEST, F.SHAMAN, F.MONK)
	recipe:AddDiscovery("DISCOVERY_TAILOR_PANDARIA")

	-- Crafted Dreadful Gladiator's Silk Handguards -- 137921
	recipe = AddRecipe(137921, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetCraftedItem(93499, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.MAGE)
	recipe:AddDiscovery("DISCOVERY_TAILOR_PANDARIA")

	-- Crafted Dreadful Gladiator's Silk Cowl -- 137922
	recipe = AddRecipe(137922, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetCraftedItem(93500, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.MAGE)
	recipe:AddDiscovery("DISCOVERY_TAILOR_PANDARIA")

	-- Crafted Dreadful Gladiator's Silk Trousers -- 137923
	recipe = AddRecipe(137923, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetCraftedItem(93501, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.MAGE)
	recipe:AddDiscovery("DISCOVERY_TAILOR_PANDARIA")

	-- Crafted Dreadful Gladiator's Silk Robe -- 137924
	recipe = AddRecipe(137924, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetCraftedItem(93502, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.MAGE)
	recipe:AddDiscovery("DISCOVERY_TAILOR_PANDARIA")

	-- Crafted Dreadful Gladiator's Silk Amice -- 137925
	recipe = AddRecipe(137925, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetCraftedItem(93500, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.MAGE)
	recipe:AddDiscovery("DISCOVERY_TAILOR_PANDARIA")

	-- Crafted Dreadful Gladiator's Mooncloth Gloves -- 137926
	recipe = AddRecipe(137926, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetCraftedItem(93550, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.PRIEST)
	recipe:AddDiscovery("DISCOVERY_TAILOR_PANDARIA")

	-- Crafted Dreadful Gladiator's Mooncloth Helm -- 137927
	recipe = AddRecipe(137927, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetCraftedItem(93551, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.PRIEST)
	recipe:AddDiscovery("DISCOVERY_TAILOR_PANDARIA")

	-- Crafted Dreadful Gladiator's Mooncloth Leggings -- 137928
	recipe = AddRecipe(137928, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetCraftedItem(93552, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.PRIEST)
	recipe:AddDiscovery("DISCOVERY_TAILOR_PANDARIA")

	-- Crafted Dreadful Gladiator's Mooncloth Robe -- 137929
	recipe = AddRecipe(137929, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetCraftedItem(93553, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.PRIEST)
	recipe:AddDiscovery("DISCOVERY_TAILOR_PANDARIA")

	-- Crafted Dreadful Gladiator's Mooncloth Mantle -- 137930
	recipe = AddRecipe(137930, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetCraftedItem(93554, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.PRIEST)
	recipe:AddDiscovery("DISCOVERY_TAILOR_PANDARIA")

	-- Crafted Dreadful Gladiator's Satin Gloves -- 137931
	recipe = AddRecipe(137931, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetCraftedItem(93555, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.PRIEST)
	recipe:AddDiscovery("DISCOVERY_TAILOR_PANDARIA")

	-- Crafted Dreadful Gladiator's Satin Hood -- 137932
	recipe = AddRecipe(137932, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetCraftedItem(93556, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.PRIEST)
	recipe:AddDiscovery("DISCOVERY_TAILOR_PANDARIA")

	-- Crafted Dreadful Gladiator's Satin Leggings -- 137933
	recipe = AddRecipe(137933, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetCraftedItem(93557, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.PRIEST)
	recipe:AddDiscovery("DISCOVERY_TAILOR_PANDARIA")

	-- Crafted Dreadful Gladiator's Satin Robe -- 137934
	recipe = AddRecipe(137934, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetCraftedItem(93558, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.PRIEST)
	recipe:AddDiscovery("DISCOVERY_TAILOR_PANDARIA")

	-- Crafted Dreadful Gladiator's Satin Mantle -- 137935
	recipe = AddRecipe(137935, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetCraftedItem(93559, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.PRIEST)
	recipe:AddDiscovery("DISCOVERY_TAILOR_PANDARIA")

	-- Crafted Dreadful Gladiator's Cloak of Alacrity -- 137936
	recipe = AddRecipe(137936, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetCraftedItem(93607, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BACK")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.DK, F.PALADIN, F.WARRIOR)
	recipe:AddDiscovery("DISCOVERY_TAILOR_PANDARIA")

	-- Crafted Dreadful Gladiator's Cloak of Prowess -- 137937
	recipe = AddRecipe(137937, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetCraftedItem(93608, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BACK")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.DK, F.PALADIN, F.WARRIOR)
	recipe:AddDiscovery("DISCOVERY_TAILOR_PANDARIA")

	-- Crafted Dreadful Gladiator's Felweave Handguards -- 137938
	recipe = AddRecipe(137938, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetCraftedItem(93615, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.WARLOCK)
	recipe:AddDiscovery("DISCOVERY_TAILOR_PANDARIA")

	-- Crafted Dreadful Gladiator's Felweave Cowl -- 137939
	recipe = AddRecipe(137939, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetCraftedItem(93616, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.WARLOCK)
	recipe:AddDiscovery("DISCOVERY_TAILOR_PANDARIA")

	-- Crafted Dreadful Gladiator's Felweave Trousers -- 137940
	recipe = AddRecipe(137940, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetCraftedItem(93617, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.WARLOCK)
	recipe:AddDiscovery("DISCOVERY_TAILOR_PANDARIA")

	-- Crafted Dreadful Gladiator's Felweave Raiment -- 137941
	recipe = AddRecipe(137941, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetCraftedItem(93618, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.WARLOCK)
	recipe:AddDiscovery("DISCOVERY_TAILOR_PANDARIA")

	-- Crafted Dreadful Gladiator's Felweave Amice -- 137942
	recipe = AddRecipe(137942, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetCraftedItem(93619, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.WARLOCK)
	recipe:AddDiscovery("DISCOVERY_TAILOR_PANDARIA")

	-- Falling Blossom Treads -- 138597
	recipe = AddRecipe(138597, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetCraftedItem(94277, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddDiscovery("DISCOVERY_TAILOR_PANDARIA")

	-- Falling Blossom Cowl -- 138598
	recipe = AddRecipe(138598, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetCraftedItem(94278, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddDiscovery("DISCOVERY_TAILOR_PANDARIA")

	-- Falling Blossom Sandals -- 138599
	recipe = AddRecipe(138599, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetCraftedItem(94278, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddDiscovery("DISCOVERY_TAILOR_PANDARIA")

	-- Falling Blossom Hood -- 138600
	recipe = AddRecipe(138600, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetCraftedItem(94280, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddDiscovery("DISCOVERY_TAILOR_PANDARIA")

	-- White Cloud Leggings -- 142951
	recipe = AddRecipe(142951, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 604, 608)
	recipe:SetCraftedItem(98599, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddDiscovery("DISCOVERY_TAILOR_CELESTIAL_PANDARIA")

	-- Leggings of the Night Sky -- 142955
	recipe = AddRecipe(142955, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 604, 608)
	recipe:SetCraftedItem(98603, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddDiscovery("DISCOVERY_TAILOR_CELESTIAL_PANDARIA")

	-- White Cloud Belt -- 142960
	recipe = AddRecipe(142960, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 604, 608)
	recipe:SetCraftedItem(98608, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddDiscovery("DISCOVERY_TAILOR_CELESTIAL_PANDARIA")

	-- Belt of the Night Sky -- 142964
	recipe = AddRecipe(142964, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 604, 608)
	recipe:SetCraftedItem(98612, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddDiscovery("DISCOVERY_TAILOR_CELESTIAL_PANDARIA")

	-- Celestial Cloth -- 143011
	recipe = AddRecipe(143011, V.MOP, Q.RARE)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetRecipeItem(100863, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(98619, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("TAILORING_MATERIALS")
	recipe:AddWorldDrop(Z.PANDARIA)

	-- Crafted Malevolent Gladiator's Cape of Cruelty -- 143053
	recipe = AddRecipe(143053, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 603, 606)
	recipe:SetCraftedItem(98756, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BACK")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.DRUID, F.HUNTER, F.SHAMAN, F.ROGUE, F.MONK)
	recipe:AddDiscovery("DISCOVERY_TAILOR_CELESTIAL_PANDARIA")

	-- Crafted Malevolent Gladiator's Cape of Prowess -- 143054
	recipe = AddRecipe(143054, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 603, 606)
	recipe:SetCraftedItem(98757, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BACK")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.DRUID, F.HUNTER, F.SHAMAN, F.ROGUE, F.MONK)
	recipe:AddDiscovery("DISCOVERY_TAILOR_CELESTIAL_PANDARIA")

	-- Crafted Malevolent Gladiator's Cord of Cruelty -- 143055
	recipe = AddRecipe(143055, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 603, 606)
	recipe:SetCraftedItem(98763, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.MAGE, F.PRIEST, F.WARLOCK)
	recipe:AddDiscovery("DISCOVERY_TAILOR_CELESTIAL_PANDARIA")

	-- Crafted Malevolent Gladiator's Cord of Accuracy -- 143056
	recipe = AddRecipe(143056, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 603, 606)
	recipe:SetCraftedItem(98764, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.MAGE, F.PRIEST, F.WARLOCK)
	recipe:AddDiscovery("DISCOVERY_TAILOR_CELESTIAL_PANDARIA")

	-- Crafted Malevolent Gladiator's Cord of Meditation -- 143057
	recipe = AddRecipe(143057, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 603, 606)
	recipe:SetCraftedItem(98765, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.MAGE, F.PRIEST, F.WARLOCK)
	recipe:AddDiscovery("DISCOVERY_TAILOR_CELESTIAL_PANDARIA")

	-- Crafted Malevolent Gladiator's Treads of Cruelty -- 143058
	recipe = AddRecipe(143058, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 603, 606)
	recipe:SetCraftedItem(98766, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.MAGE, F.PRIEST, F.WARLOCK)
	recipe:AddDiscovery("DISCOVERY_TAILOR_CELESTIAL_PANDARIA")

	-- Crafted Malevolent Gladiator's Treads of Alacrity -- 143059
	recipe = AddRecipe(143059, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 603, 606)
	recipe:SetCraftedItem(98767, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.MAGE, F.PRIEST, F.WARLOCK)
	recipe:AddDiscovery("DISCOVERY_TAILOR_CELESTIAL_PANDARIA")

	-- Crafted Malevolent Gladiator's Treads of Meditation -- 143060
	recipe = AddRecipe(143060, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 603, 606)
	recipe:SetCraftedItem(98768, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.MAGE, F.PRIEST, F.WARLOCK)
	recipe:AddDiscovery("DISCOVERY_TAILOR_CELESTIAL_PANDARIA")

	-- Crafted Malevolent Gladiator's Cuffs of Accuracy -- 143061
	recipe = AddRecipe(143061, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 603, 606)
	recipe:SetCraftedItem(98769, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.MAGE, F.PRIEST, F.WARLOCK)
	recipe:AddDiscovery("DISCOVERY_TAILOR_CELESTIAL_PANDARIA")

	-- Crafted Malevolent Gladiator's Cuffs of Prowess -- 143062
	recipe = AddRecipe(143062, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 603, 606)
	recipe:SetCraftedItem(98770, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.MAGE, F.PRIEST, F.WARLOCK)
	recipe:AddDiscovery("DISCOVERY_TAILOR_CELESTIAL_PANDARIA")

	-- Crafted Malevolent Gladiator's Cuffs of Meditation -- 143063
	recipe = AddRecipe(143063, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 603, 606)
	recipe:SetCraftedItem(98771, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.MAGE, F.PRIEST, F.WARLOCK)
	recipe:AddDiscovery("DISCOVERY_TAILOR_CELESTIAL_PANDARIA")

	-- Crafted Malevolent Gladiator's Drape of Cruelty -- 143064
	recipe = AddRecipe(143064, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 603, 606)
	recipe:SetCraftedItem(98772, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BACK")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.DRUID, F.MAGE, F.PALADIN, F.PRIEST, F.SHAMAN, F.WARLOCK, F.MONK)
	recipe:AddDiscovery("DISCOVERY_TAILOR_CELESTIAL_PANDARIA")

	-- Crafted Malevolent Gladiator's Drape of Prowess -- 143065
	recipe = AddRecipe(143065, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 603, 606)
	recipe:SetCraftedItem(98773, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BACK")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.DRUID, F.MAGE, F.PALADIN, F.PRIEST, F.SHAMAN, F.WARLOCK, F.MONK)
	recipe:AddDiscovery("DISCOVERY_TAILOR_CELESTIAL_PANDARIA")

	-- Crafted Malevolent Gladiator's Drape of Meditation -- 143066
	recipe = AddRecipe(143066, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 603, 606)
	recipe:SetCraftedItem(98774, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BACK")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.DRUID, F.PALADIN, F.PRIEST, F.SHAMAN, F.MONK)
	recipe:AddDiscovery("DISCOVERY_TAILOR_CELESTIAL_PANDARIA")

	-- Crafted Malevolent Gladiator's Silk Handguards -- 143067
	recipe = AddRecipe(143067, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 603, 606)
	recipe:SetCraftedItem(98825, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.MAGE)
	recipe:AddDiscovery("DISCOVERY_TAILOR_CELESTIAL_PANDARIA")

	-- Crafted Malevolent Gladiator's Silk Cowl -- 143068
	recipe = AddRecipe(143068, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 603, 606)
	recipe:SetCraftedItem(98826, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.MAGE)
	recipe:AddDiscovery("DISCOVERY_TAILOR_CELESTIAL_PANDARIA")

	-- Crafted Malevolent Gladiator's Silk Trousers -- 143069
	recipe = AddRecipe(143069, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 603, 606)
	recipe:SetCraftedItem(98827, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.MAGE)
	recipe:AddDiscovery("DISCOVERY_TAILOR_CELESTIAL_PANDARIA")

	-- Crafted Malevolent Gladiator's Silk Robe -- 143070
	recipe = AddRecipe(143070, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 603, 606)
	recipe:SetCraftedItem(98828, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.MAGE)
	recipe:AddDiscovery("DISCOVERY_TAILOR_CELESTIAL_PANDARIA")

	-- Crafted Malevolent Gladiator's Silk Amice -- 143071
	recipe = AddRecipe(143071, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 603, 606)
	recipe:SetCraftedItem(98829, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.MAGE)
	recipe:AddDiscovery("DISCOVERY_TAILOR_CELESTIAL_PANDARIA")

	-- Crafted Malevolent Gladiator's Mooncloth Gloves -- 143072
	recipe = AddRecipe(143072, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 603, 606)
	recipe:SetCraftedItem(98865, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.PRIEST)
	recipe:AddDiscovery("DISCOVERY_TAILOR_CELESTIAL_PANDARIA")

	-- Crafted Malevolent Gladiator's Mooncloth Helm -- 143073
	recipe = AddRecipe(143073, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 603, 606)
	recipe:SetCraftedItem(98866, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.PRIEST)
	recipe:AddDiscovery("DISCOVERY_TAILOR_CELESTIAL_PANDARIA")

	-- Crafted Malevolent Gladiator's Mooncloth Leggings -- 143074
	recipe = AddRecipe(143074, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 603, 606)
	recipe:SetCraftedItem(98867, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.PRIEST)
	recipe:AddDiscovery("DISCOVERY_TAILOR_CELESTIAL_PANDARIA")

	-- Crafted Malevolent Gladiator's Mooncloth Robe -- 143075
	recipe = AddRecipe(143075, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 603, 606)
	recipe:SetCraftedItem(98868, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.PRIEST)
	recipe:AddDiscovery("DISCOVERY_TAILOR_CELESTIAL_PANDARIA")

	-- Crafted Malevolent Gladiator's Mooncloth Mantle -- 143076
	recipe = AddRecipe(143076, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 603, 606)
	recipe:SetCraftedItem(98869, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.PRIEST)
	recipe:AddDiscovery("DISCOVERY_TAILOR_CELESTIAL_PANDARIA")

	-- Crafted Malevolent Gladiator's Satin Gloves -- 143077
	recipe = AddRecipe(143077, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 603, 606)
	recipe:SetCraftedItem(98870, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.PRIEST)
	recipe:AddDiscovery("DISCOVERY_TAILOR_CELESTIAL_PANDARIA")

	-- Crafted Malevolent Gladiator's Satin Hood -- 143078
	recipe = AddRecipe(143078, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 603, 606)
	recipe:SetCraftedItem(98871, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.PRIEST)
	recipe:AddDiscovery("DISCOVERY_TAILOR_CELESTIAL_PANDARIA")

	-- Crafted Malevolent Gladiator's Satin Leggings -- 143079
	recipe = AddRecipe(143079, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 603, 606)
	recipe:SetCraftedItem(98872, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.PRIEST)
	recipe:AddDiscovery("DISCOVERY_TAILOR_CELESTIAL_PANDARIA")

	-- Crafted Malevolent Gladiator's Satin Robe -- 143080
	recipe = AddRecipe(143080, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 603, 606)
	recipe:SetCraftedItem(98873, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.PRIEST)
	recipe:AddDiscovery("DISCOVERY_TAILOR_CELESTIAL_PANDARIA")

	-- Crafted Malevolent Gladiator's Satin Mantle -- 143081
	recipe = AddRecipe(143081, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 603, 606)
	recipe:SetCraftedItem(98874, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.PRIEST)
	recipe:AddDiscovery("DISCOVERY_TAILOR_CELESTIAL_PANDARIA")

	-- Crafted Malevolent Gladiator's Cloak of Alacrity -- 143082
	recipe = AddRecipe(143082, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 603, 606)
	recipe:SetCraftedItem(98913, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BACK")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.DK, F.PALADIN, F.WARRIOR)
	recipe:AddDiscovery("DISCOVERY_TAILOR_CELESTIAL_PANDARIA")

	-- Crafted Malevolent Gladiator's Cloak of Prowess -- 143083
	recipe = AddRecipe(143083, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 603, 606)
	recipe:SetCraftedItem(98914, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BACK")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.DK, F.PALADIN, F.WARRIOR)
	recipe:AddDiscovery("DISCOVERY_TAILOR_CELESTIAL_PANDARIA")

	-- Crafted Malevolent Gladiator's Felweave Handguards -- 143084
	recipe = AddRecipe(143084, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 603, 606)
	recipe:SetCraftedItem(98921, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.WARLOCK)
	recipe:AddDiscovery("DISCOVERY_TAILOR_CELESTIAL_PANDARIA")

	-- Crafted Malevolent Gladiator's Felweave Cowl -- 143085
	recipe = AddRecipe(143085, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 603, 606)
	recipe:SetCraftedItem(98922, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.WARLOCK)
	recipe:AddDiscovery("DISCOVERY_TAILOR_CELESTIAL_PANDARIA")

	-- Crafted Malevolent Gladiator's Felweave Trousers -- 143086
	recipe = AddRecipe(143086, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 603, 606)
	recipe:SetCraftedItem(98923, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.WARLOCK)
	recipe:AddDiscovery("DISCOVERY_TAILOR_CELESTIAL_PANDARIA")

	-- Crafted Malevolent Gladiator's Felweave Raiment -- 143087
	recipe = AddRecipe(143087, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 603, 606)
	recipe:SetCraftedItem(98924, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.WARLOCK)
	recipe:AddDiscovery("DISCOVERY_TAILOR_CELESTIAL_PANDARIA")

	-- Crafted Malevolent Gladiator's Felweave Amice -- 143088
	recipe = AddRecipe(143088, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 603, 606)
	recipe:SetCraftedItem(98925, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.WARLOCK)
	recipe:AddDiscovery("DISCOVERY_TAILOR_CELESTIAL_PANDARIA")

	-- Accelerated Celestial Cloth -- 146925
	recipe = AddRecipe(146925, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetCraftedItem(98619, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("TAILORING_MATERIALS")
	recipe:AddDiscovery("DISCOVERY_TAILOR_CELESTIAL_PANDARIA")

	-- Relic of the Past I -- 330242
	recipe = AddRecipe(330242, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(180055, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_MATERIALS")
	recipe:AddTrainer(57405)

	-- Relic of the Past II -- 330243
	recipe = AddRecipe(330243, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(180057, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_MATERIALS")
	recipe:AddTrainer(57405)

	-- Relic of the Past III -- 330244
	recipe = AddRecipe(330244, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(180058, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_MATERIALS")
	recipe:AddTrainer(57405)

	-- Relic of the Past IV -- 330245
	recipe = AddRecipe(330245, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(180059, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_MATERIALS")
	recipe:AddTrainer(57405)

	-- Relic of the Past V -- 330246
	recipe = AddRecipe(330246, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(180060, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_MATERIALS")
	recipe:AddTrainer(57405)

	-- ----------------------------------------------------------------------------
	-- Warlords of Draenor.
	-- ----------------------------------------------------------------------------
	-- Hexweave Cloth -- 168835
	recipe = AddRecipe(168835, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 600, 800, 1000)
	recipe:SetRecipeItem(114851, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(111556, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("TAILORING_MATERIALS")
	recipe:AddCustom("DRAENOR_DEFAULT")

	-- Hexweave Embroidery -- 168836
	recipe = AddRecipe(168836, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 700, 700)
	recipe:SetRecipeItem(114852, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(114836, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_ITEM_ENHANCEMENT")
	recipe:AddVendor(77382, 79864, 87049, 87543)

	-- Hexweave Mantle -- 168837
	recipe = AddRecipe(168837, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 700, 700)
	recipe:SetRecipeItem(114853, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(114809, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(77382, 79864, 87049, 87543)

	-- Hexweave Cowl -- 168838
	recipe = AddRecipe(168838, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 700, 700)
	recipe:SetRecipeItem(114854, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(114810, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HEAD")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(77382, 79864, 87049, 87543)

	-- Hexweave Leggings -- 168839
	recipe = AddRecipe(168839, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 700, 701)
	recipe:SetRecipeItem(114855, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(114811, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_LEGS")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(77382, 79864, 87049, 87543)

	-- Hexweave Gloves -- 168840
	recipe = AddRecipe(168840, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 700, 701)
	recipe:SetRecipeItem(114856, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(114812, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HANDS")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(77382, 79864, 87049, 87543)

	-- Hexweave Robe -- 168841
	recipe = AddRecipe(168841, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 700, 701)
	recipe:SetRecipeItem(114857, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(114813, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(77382, 79864, 87049, 87543)

	-- Hexweave Bracers -- 168842
	recipe = AddRecipe(168842, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 700, 701)
	recipe:SetRecipeItem(114858, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(114814, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WRIST")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(77382, 79864, 87049, 87543)

	-- Hexweave Slippers -- 168843
	recipe = AddRecipe(168843, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 700, 701)
	recipe:SetRecipeItem(114859, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(114815, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_FEET")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(77382, 79864, 87049, 87543)

	-- Hexweave Belt -- 168844
	recipe = AddRecipe(168844, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 700, 701)
	recipe:SetRecipeItem(114860, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(114816, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WAIST")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(77382, 79864, 87049, 87543)

	-- Powerful Hexweave Cloak -- 168845
	recipe = AddRecipe(168845, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 700, 700)
	recipe:SetRecipeItem(114861, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(114817, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BACK")
	recipe:AddFilters(F.DPS)
	recipe:AddVendor(77382, 79864, 87049, 87543)

	-- Nimble Hexweave Cloak -- 168846
	recipe = AddRecipe(168846, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 700, 700)
	recipe:SetRecipeItem(114862, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(114818, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BACK")
	recipe:AddFilters(F.DPS)
	recipe:AddVendor(77382, 79864, 87049, 87543)

	-- Brilliant Hexweave Cloak -- 168847
	recipe = AddRecipe(168847, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 700, 700)
	recipe:SetRecipeItem(114863, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(114819, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BACK")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(77382, 79864, 87049, 87543)

	-- Hexweave Bag -- 168848
	recipe = AddRecipe(168848, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 700, 700)
	recipe:SetRecipeItem(114864, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(114821, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BAG")
	recipe:AddVendor(77382, 79864, 87049, 87543)

	-- Elekk Plushie -- 168849
	recipe = AddRecipe(168849, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 700, 700)
	recipe:SetRecipeItem(114865, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(113216, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_MISC")
	recipe:AddVendor(77382, 79864, 87049, 87543)

	-- Creeping Carpet -- 168850
	recipe = AddRecipe(168850, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 700, 700)
	recipe:SetRecipeItem(114866, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(115363, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_MISC")
	recipe:AddVendor(77382, 79864, 87049, 87543)

	-- Sumptuous Cowl -- 168852
	recipe = AddRecipe(168852, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 600, 600, 600)
	recipe:SetCraftedItem(114828, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("TAILORING_HEAD")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddCustom("DRAENOR_DEFAULT")

	-- Sumptuous Robes -- 168853
	recipe = AddRecipe(168853, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 600, 600, 600)
	recipe:SetCraftedItem(114829, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddCustom("DRAENOR_DEFAULT")

	-- Sumptuous Leggings -- 168854
	recipe = AddRecipe(168854, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 600, 600, 600)
	recipe:SetCraftedItem(114831, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("TAILORING_LEGS")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddCustom("DRAENOR_DEFAULT")

	-- Secrets of Draenor Tailoring -- 176058
	recipe = AddRecipe(176058, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 600, 650, 700)
	recipe:SetCraftedItem(118722, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("TAILORING_MISC")
	recipe:AddCustom("DRAENOR_DEFAULT")

	-- Primal Weaving -- 182123
	recipe = AddRecipe(182123, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 700, 700)
	recipe:SetRecipeItem(122716, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(111556, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("TAILORING_MATERIALS")
	recipe:AddVendor(91025, 91034)

	-- Relic of the Past I -- 330247
	recipe = AddRecipe(330247, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(180055, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_MATERIALS")
	recipe:AddCustom("DRAENOR_DEFAULT")

	-- Relic of the Past II -- 330248
	recipe = AddRecipe(330248, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(180057, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_MATERIALS")
	recipe:AddCustom("DRAENOR_DEFAULT")

	-- Relic of the Past III -- 330249
	recipe = AddRecipe(330249, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(180058, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_MATERIALS")
	recipe:AddCustom("DRAENOR_DEFAULT")

	-- Relic of the Past IV -- 330250
	recipe = AddRecipe(330250, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(180059, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_MATERIALS")
	recipe:AddCustom("DRAENOR_DEFAULT")

	-- Relic of the Past V -- 330251
	recipe = AddRecipe(330251, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(180060, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_MATERIALS")
	recipe:AddCustom("DRAENOR_DEFAULT")

	-- ----------------------------------------------------------------------------
	-- Legion.
	-- ----------------------------------------------------------------------------
	-- Silkweave Bracers -- 185918
	recipe = AddRecipe(185918, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 710, 720)
	recipe:SetCraftedItem(126994, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WRIST")
	recipe:AddQuest(38949)

	-- Silkweave Cinch -- 185919
	recipe = AddRecipe(185919, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 710, 720)
	recipe:SetCraftedItem(126993, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WAIST")
	recipe:AddQuest(38945)

	-- Silkweave Epaulets -- 185920
	recipe = AddRecipe(185920, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 710, 720)
	recipe:SetCraftedItem(126992, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_SHOULDER")
	recipe:AddQuest(38945)

	-- Silkweave Pantaloons -- 185921
	recipe = AddRecipe(185921, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 710, 720)
	recipe:SetCraftedItem(126991, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_LEGS")
	recipe:AddQuest(38957)

	-- Silkweave Hood -- 185922
	recipe = AddRecipe(185922, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 710, 720)
	recipe:SetCraftedItem(126990, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HEAD")
	recipe:AddQuest(38963)

	-- Silkweave Gloves -- 185923
	recipe = AddRecipe(185923, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 710, 720)
	recipe:SetCraftedItem(126989, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HANDS")
	recipe:AddQuest(38961)

	-- Silkweave Slippers -- 185924
	recipe = AddRecipe(185924, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 710, 720)
	recipe:SetCraftedItem(126988, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_FEET")
	recipe:AddQuest(38958)

	-- Silkweave Robe -- 185925
	recipe = AddRecipe(185925, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 710, 720)
	recipe:SetCraftedItem(126987, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddQuest(38949)

	-- Imbued Silkweave Bracers -- 185926
	recipe = AddRecipe(185926, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 740, 750, 760)
	recipe:SetCraftedItem(127002, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WRIST")
	recipe:AddQuest(38970)

	-- Imbued Silkweave Cinch -- 185927
	recipe = AddRecipe(185927, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 740, 750, 760)
	recipe:SetRecipeItem(127022, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(127001, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WAIST")
	recipe:AddVendor(93974)

	-- Imbued Silkweave Epaulets -- 185928
	recipe = AddRecipe(185928, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 740, 750, 760)
	recipe:SetRecipeItem(127023, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(127000, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_SHOULDER")
	recipe:AddVendor(93973)

	-- Imbued Silkweave Pantaloons -- 185929
	recipe = AddRecipe(185929, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 740, 750, 760)
	recipe:SetRecipeItem(127024, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(126999, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_LEGS")
	recipe:AddQuest(38974)

	-- Imbued Silkweave Hood -- 185930
	recipe = AddRecipe(185930, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 740, 750, 760)
	recipe:SetRecipeItem(127025, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(126998, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HEAD")
	recipe:AddVendor(93979)

	-- Imbued Silkweave Gloves -- 185931
	recipe = AddRecipe(185931, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 740, 750, 760)
	recipe:SetCraftedItem(126997, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HANDS")
	recipe:AddQuest(38971)

	-- Imbued Silkweave Slippers -- 185932
	recipe = AddRecipe(185932, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 740, 750, 760)
	recipe:SetRecipeItem(127027, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(126996, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_FEET")
	recipe:AddVendor(93975)

	-- Imbued Silkweave Robe -- 185933
	recipe = AddRecipe(185933, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 740, 750, 760)
	recipe:SetCraftedItem(126995, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddQuest(38975)

	-- Silkweave Bracers -- 185934
	recipe = AddRecipe(185934, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 720, 730, 740)
	recipe:SetRecipeItem(137953, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(126994, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WRIST")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(93524)

	-- Silkweave Cinch -- 185935
	recipe = AddRecipe(185935, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 720, 730, 740)
	recipe:SetRecipeItem(137954, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(126993, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WAIST")
	recipe:AddVendor(107760)

	-- Silkweave Epaulets -- 185936
	recipe = AddRecipe(185936, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 720, 730, 740)
	recipe:SetRecipeItem(137955, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(126992, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(93524)

	-- Silkweave Pantaloons -- 185937
	recipe = AddRecipe(185937, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 720, 730, 740)
	recipe:SetRecipeItem(137956, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(126991, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_LEGS")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddQuest(38966)
	recipe:AddVendor(93524)

	-- Silkweave Hood -- 185938
	recipe = AddRecipe(185938, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 720, 730, 740)
	recipe:SetRecipeItem(137957, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(126990, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HEAD")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(93524)

	-- Silkweave Gloves -- 185939
	recipe = AddRecipe(185939, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 720, 730, 740)
	recipe:SetRecipeItem(137958, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(126989, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HANDS")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddQuest(38966)
	recipe:AddVendor(93524)

	-- Silkweave Slippers -- 185940
	recipe = AddRecipe(185940, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 720, 730, 740)
	recipe:SetRecipeItem(137959, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(126988, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_FEET")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddQuest(38966)
	recipe:AddVendor(93524)

	-- Silkweave Robe -- 185941
	recipe = AddRecipe(185941, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 720, 730, 740)
	recipe:SetRecipeItem(137960, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(126987, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(93524)

	-- Silkweave Bracers -- 185942
	recipe = AddRecipe(185942, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 740, 750, 760)
	recipe:SetRecipeItem(137961, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(126994, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WRIST")
	recipe:AddQuest(41648)

	-- Silkweave Cinch -- 185943
	recipe = AddRecipe(185943, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 740, 750, 760)
	recipe:SetRecipeItem(137962, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(126993, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WAIST")
	recipe:AddVendor(107760)

	-- Silkweave Epaulets -- 185944
	recipe = AddRecipe(185944, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 740, 750, 760)
	recipe:SetRecipeItem(137963, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(126992, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_SHOULDER")
	recipe:AddQuest(41645)

	-- Silkweave Robe -- 185945
	recipe = AddRecipe(185945, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 740, 750, 760)
	recipe:SetRecipeItem(137964, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(126987, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddQuest(41647)

	-- Imbued Silkweave Bracers -- 185946
	recipe = AddRecipe(185946, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 760, 770, 780)
	recipe:SetRecipeItem(137965, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(127002, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WRIST")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(93524)

	-- Imbued Silkweave Cinch -- 185947
	recipe = AddRecipe(185947, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 760, 770, 780)
	recipe:SetRecipeItem(137966, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(127001, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WAIST")
	recipe:AddVendor(107760)

	-- Imbued Silkweave Epaulets -- 185948
	recipe = AddRecipe(185948, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 760, 770, 780)
	recipe:SetRecipeItem(137967, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(127000, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(93524)

	-- Imbued Silkweave Pantaloons -- 185949
	recipe = AddRecipe(185949, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 760, 770, 780)
	recipe:SetRecipeItem(137968, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(126999, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_LEGS")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(93524)

	-- Imbued Silkweave Hood -- 185950
	recipe = AddRecipe(185950, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 760, 770, 780)
	recipe:SetRecipeItem(137969, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(126998, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HEAD")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(93524)

	-- Imbued Silkweave Gloves -- 185951
	recipe = AddRecipe(185951, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 760, 770, 780)
	recipe:SetRecipeItem(137970, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(126997, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HANDS")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(93524)

	-- Imbued Silkweave Slippers -- 185952
	recipe = AddRecipe(185952, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 760, 770, 780)
	recipe:SetRecipeItem(137971, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(126996, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_FEET")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(93524)

	-- Imbued Silkweave Robe -- 185953
	recipe = AddRecipe(185953, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 760, 770, 780)
	recipe:SetRecipeItem(137972, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(126995, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(93524)

	-- Imbued Silkweave Bracers -- 185954
	recipe = AddRecipe(185954, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 760, 770, 780)
	recipe:SetRecipeItem(137973, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(127002, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WRIST")
	recipe:AddRepVendor(FAC.THE_NIGHTFALLEN, REP.EXALTED, 97140, 115736)

	-- Imbued Silkweave Cinch -- 185955
	recipe = AddRecipe(185955, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 780, 790, 800)
	recipe:SetRecipeItem(137974, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(127001, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WAIST")
	recipe:AddVendor(107760)

	-- Imbued Silkweave Epaulets -- 185956
	recipe = AddRecipe(185956, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 780, 790, 800)
	recipe:SetRecipeItem(137975, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(127000, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_SHOULDER")
	recipe:AddCustom("RATED_PVP")

	-- Imbued Silkweave Pantaloons -- 185957
	recipe = AddRecipe(185957, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 780, 790, 800)
	recipe:SetRecipeItem(137976, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(126999, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_LEGS")
	recipe:AddRepVendor(FAC.THE_NIGHTFALLEN, REP.EXALTED, 97140, 115736)

	-- Imbued Silkweave Hood -- 185958
	recipe = AddRecipe(185958, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 780, 790, 800)
	recipe:SetRecipeItem(137977, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(126998, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HEAD")
	recipe:AddRepVendor(FAC.COURT_OF_FARONDIS, REP.EXALTED, 107376)

	-- Imbued Silkweave Gloves -- 185959
	recipe = AddRecipe(185959, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 780, 790, 800)
	recipe:SetRecipeItem(137978, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(126997, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HANDS")
	recipe:AddRepVendor(FAC.COURT_OF_FARONDIS, REP.EXALTED, 107376)

	-- Imbued Silkweave Slippers -- 185960
	recipe = AddRecipe(185960, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 780, 790, 800)
	recipe:SetRecipeItem(137979, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(126996, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_FEET")
	recipe:AddRepVendor(FAC.THE_NIGHTFALLEN, REP.EXALTED, 97140, 115736)

	-- Imbued Silkweave Robe -- 185961
	recipe = AddRecipe(185961, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 780, 790, 800)
	recipe:SetRecipeItem(137980, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(126995, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_FEET")
	recipe:AddRepVendor(FAC.COURT_OF_FARONDIS, REP.EXALTED, 107376)

	-- Imbued Silkweave -- 185962
	recipe = AddRecipe(185962, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 740, 747, 755)
	recipe:SetCraftedItem(127004, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_MATERIALS")
	recipe:AddQuest(38970)

	-- Silkweave Shade -- 186091
	recipe = AddRecipe(186091, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 720, 740)
	recipe:SetCraftedItem(127031, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BACK")
	recipe:AddTrainer(93525, 93542)

	-- Silkweave Flourish -- 186094
	recipe = AddRecipe(186094, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 720, 740)
	recipe:SetCraftedItem(127032, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BACK")
	recipe:AddTrainer(93525, 93542)

	-- Silkweave Cover -- 186097
	recipe = AddRecipe(186097, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 720, 740)
	recipe:SetCraftedItem(127016, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BACK")
	recipe:AddTrainer(93525, 93542)

	-- Silkweave Drape -- 186100
	recipe = AddRecipe(186100, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 720, 740)
	recipe:SetCraftedItem(127017, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BACK")
	recipe:AddTrainer(93525, 93542)

	-- Imbued Silkweave Shade -- 186106
	recipe = AddRecipe(186106, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 740, 750, 760)
	recipe:SetRecipeItem(127279, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(127033, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BACK")
	recipe:AddVendor(93971)

	-- Imbued Silkweave Shade -- 186107
	recipe = AddRecipe(186107, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 760, 770, 780)
	recipe:SetRecipeItem(138000, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(127033, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("TAILORING_BACK")
	recipe:AddWorldDrop(Z.BROKEN_ISLES)

	-- Imbued Silkweave Shade -- 186108
	recipe = AddRecipe(186108, V.LEGION, Q.RARE)
	recipe:SetSkillLevels(1, 1, 780, 790, 800)
	recipe:SetRecipeItem(138001, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(127033, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BACK")
	recipe:AddWorldDrop(Z.BROKEN_ISLES)

	-- Imbued Silkweave Flourish -- 186109
	recipe = AddRecipe(186109, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 740, 750, 760)
	recipe:SetRecipeItem(127280, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(127034, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BACK")
	recipe:AddVendor(93971)

	-- Imbued Silkweave Flourish -- 186110
	recipe = AddRecipe(186110, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 760, 770, 780)
	recipe:SetRecipeItem(138003, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(127034, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BACK")
	recipe:AddWorldDrop(Z.BROKEN_ISLES)

	-- Imbued Silkweave Flourish -- 186111
	recipe = AddRecipe(186111, V.LEGION, Q.RARE)
	recipe:SetSkillLevels(1, 1, 780, 790, 800)
	recipe:SetRecipeItem(138004, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(127034, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BACK")
	recipe:AddWorldDrop(Z.BROKEN_ISLES)

	-- Imbued Silkweave Cover -- 186112
	recipe = AddRecipe(186112, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 740, 750, 760)
	recipe:SetRecipeItem(127277, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(127019, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BACK")
	recipe:AddVendor(93971)

	-- Imbued Silkweave Cover -- 186113
	recipe = AddRecipe(186113, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 760, 770, 780)
	recipe:SetRecipeItem(138006, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(127019, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BACK")
	recipe:AddWorldDrop(Z.BROKEN_ISLES)

	-- Imbued Silkweave Cover -- 186114
	recipe = AddRecipe(186114, V.LEGION, Q.RARE)
	recipe:SetSkillLevels(1, 1, 780, 790, 800)
	recipe:SetRecipeItem(138007, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(127019, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BACK")
	recipe:AddWorldDrop(Z.BROKEN_ISLES)

	-- Imbued Silkweave Drape -- 186115
	recipe = AddRecipe(186115, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 740, 750, 760)
	recipe:SetRecipeItem(127278, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(127020, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BACK")
	recipe:AddVendor(93971)

	-- Imbued Silkweave Drape -- 186116
	recipe = AddRecipe(186116, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 760, 770, 780)
	recipe:SetRecipeItem(138009, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(127020, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BACK")
	recipe:AddWorldDrop(Z.BROKEN_ISLES)

	-- Imbued Silkweave Drape -- 186117
	recipe = AddRecipe(186117, V.LEGION, Q.RARE)
	recipe:SetSkillLevels(1, 1, 780, 790, 800)
	recipe:SetRecipeItem(138010, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(127020, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BACK")
	recipe:AddWorldDrop(Z.BROKEN_ISLES)

	-- Silkweave Satchel -- 186388
	recipe = AddRecipe(186388, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 720, 740)
	recipe:SetRecipeItem(138011, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(127035, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BAG")
	recipe:AddQuest(38955)
	recipe:AddVendor(93524)

	-- Silkweave Gloves -- 208350
	recipe = AddRecipe(208350, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 740, 750, 760)
	recipe:SetRecipeItem(138012, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(126989, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HANDS")
	recipe:AddQuest(41646)

	-- Silkweave Hood -- 208351
	recipe = AddRecipe(208351, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 740, 750, 760)
	recipe:SetRecipeItem(138013, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(126990, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HEAD")
	recipe:AddQuest(41650)

	-- Silkweave Slippers -- 208352
	recipe = AddRecipe(208352, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 740, 750, 760)
	recipe:SetRecipeItem(138014, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(126988, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_FEET")
	recipe:AddQuest(41649)

	-- Silkweave Pantaloons -- 208353
	recipe = AddRecipe(208353, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 740, 750, 760)
	recipe:SetRecipeItem(138015, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(126991, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_LEGS")
	recipe:AddRepVendor(FAC.COURT_OF_FARONDIS, REP.HONORED, 107376)

	-- Clothes Chest: Dalaran Citizens -- 213035
	recipe = AddRecipe(213035, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 720, 740)
	recipe:SetRecipeItem(138016, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(137553, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_TRANSMOG")
	recipe:AddVendor(97362)

	-- Clothes Chest: Karazhan Opera House -- 213036
	recipe = AddRecipe(213036, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 720, 740)
	recipe:SetRecipeItem(138017, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(137557, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_TRANSMOG")
	recipe:AddMobDrop(17521)

	-- Clothes Chest: Molten Core -- 213037
	recipe = AddRecipe(213037, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 720, 740)
	recipe:SetRecipeItem(138018, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(137558, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_TRANSMOG")
	recipe:AddMobDrop(11502)

	-- Bloodtotem Saddle Blanket -- 220511
	recipe = AddRecipe(220511, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 800, 800, 800)
	recipe:SetRecipeItem(137681, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(139503, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_MISC")
	recipe:AddWorldDrop(Z.HIGHMOUNTAIN)

	-- Imbued Silkweave Bag -- 229041
	recipe = AddRecipe(229041, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 780, 790, 800)
	recipe:SetRecipeItem(142076, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(142075, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BAG")
	recipe:AddQuest(44741)

	-- Imbued Silkweave Bag -- 229043
	recipe = AddRecipe(229043, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 780, 790, 800)
	recipe:SetRecipeItem(142077, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(142075, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BAG")
	recipe:AddWorldDrop(Z.BROKEN_ISLES)

	-- Imbued Silkweave Bag -- 229045
	recipe = AddRecipe(229045, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 780, 790, 800)
	recipe:SetRecipeItem(142078, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(142075, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BAG")
	recipe:AddMobDrop(103758)

	-- Celumbra, the Night's Dichotomy -- 239412
	recipe = AddRecipe(239412, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 110, 115, 120)
	recipe:SetCraftedItem(146666, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_SHOULDER")
	recipe:AddTrainer(3363, 4159, 11557, 16366, 93525, 93542)

	-- Lightweave Breeches -- 247807
	recipe = AddRecipe(247807, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 790, 795, 800)
	recipe:SetRecipeItem(151746, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(151571, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_LEGS")
	recipe:AddQuest(48074)

	-- Lightweave Breeches -- 247808
	recipe = AddRecipe(247808, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 790, 795, 800)
	recipe:SetRecipeItem(151747, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(151571, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_LEGS")
	recipe:AddRepVendor(FAC.ARMY_OF_THE_LIGHT, REP.REVERED, 127120)

	-- Lightweave Breeches -- 247809
	recipe = AddRecipe(247809, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 790, 795, 800)
	recipe:SetRecipeItem(151748, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(151571, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_LEGS")
	recipe:AddMobDrop(124393)

	-- Relic of the Past I -- 330252
	recipe = AddRecipe(330252, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(180055, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_MATERIALS")
	recipe:AddCustom("DEFAULT_RECIPE")

	-- Relic of the Past II -- 330253
	recipe = AddRecipe(330253, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(180057, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_MATERIALS")
	recipe:AddCustom("DEFAULT_RECIPE")

	-- Relic of the Past III -- 330254
	recipe = AddRecipe(330254, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(180058, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_MATERIALS")
	recipe:AddCustom("DEFAULT_RECIPE")

	-- Relic of the Past IV -- 330255
	recipe = AddRecipe(330255, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(180059, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_MATERIALS")
	recipe:AddCustom("DEFAULT_RECIPE")

	-- Relic of the Past V -- 330256
	recipe = AddRecipe(330256, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(180060, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_MATERIALS")
	recipe:AddCustom("DEFAULT_RECIPE")

	-- ----------------------------------------------------------------------------
	-- Battle for Azeroth.
	-- ----------------------------------------------------------------------------
	-- Linen Bandage -- 3275
	recipe = AddRecipe(3275, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(40, 40, 40, 50, 60)
	recipe:SetCraftedItem(3275, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BANDAGES")
	recipe:AddCustom("DEFAULT_RECIPE")

	-- Heavy Linen Bandage -- 3276
	recipe = AddRecipe(3276, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(40, 40, 50, 55, 60)
	recipe:SetCraftedItem(2581, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BANDAGES")
	recipe:AddTrainer(2329, 4591, 5150, 5759, 5943, 16662, 23734, 26956, 26992, 28706, 29233, 33621, 45540, 65862, 66222, 85930, 86034, 93529)

	-- Wool Bandage -- 3277
	recipe = AddRecipe(3277, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(80, 80, 90, 95, 100)
	recipe:SetCraftedItem(3530, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BANDAGES")
	recipe:AddTrainer(2329, 4591, 5150, 5759, 5943, 16662, 23734, 26956, 26992, 28706, 29233, 33621, 45540, 65862, 66222, 85930, 86034, 93529)

	-- Heavy Wool Bandage -- 3278
	recipe = AddRecipe(3278, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(115, 115, 125, 130, 135)
	recipe:SetCraftedItem(3531, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BANDAGES")
	recipe:AddTrainer(2329, 4591, 5150, 5759, 5943, 16662, 23734, 26956, 26992, 28706, 29233, 33621, 45540, 65862, 66222, 85930, 86034, 93529)

	-- Silk Bandage -- 7928
	recipe = AddRecipe(7928, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(150, 150, 160, 165, 170)
	recipe:SetCraftedItem(6450, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BANDAGES")
	recipe:AddTrainer(2329, 4591, 5150, 5759, 5943, 16662, 23734, 26956, 26992, 28706, 29233, 33621, 45540, 65862, 66222, 85930, 86034, 93529)

	-- Heavy Silk Bandage -- 7929
	recipe = AddRecipe(7929, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(180, 180, 190, 195, 200)
	recipe:SetCraftedItem(6451, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BANDAGES")
	recipe:AddTrainer(2329, 4591, 5150, 5759, 5943, 16662, 23734, 26956, 26992, 28706, 29233, 33621, 45540, 65862, 66222, 85930, 86034, 93529)

	-- Mageweave Bandage -- 10840
	recipe = AddRecipe(10840, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(210, 210, 220, 225, 230)
	recipe:SetCraftedItem(8544, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BANDAGES")
	recipe:AddTrainer(2329, 4591, 5150, 5759, 5943, 16662, 23734, 26956, 26992, 28706, 29233, 33621, 45540, 65862, 66222, 85930, 86034, 93529)

	-- Heavy Mageweave Bandage -- 10841
	recipe = AddRecipe(10841, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(240, 240, 250, 255, 260)
	recipe:SetCraftedItem(8545, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BANDAGES")
	recipe:AddTrainer(2329, 4591, 5150, 5759, 5943, 16662, 23734, 26956, 26992, 28706, 29233, 33621, 45540, 65862, 66222, 85930, 86034, 93529)

	-- Runecloth Bandage -- 18629
	recipe = AddRecipe(18629, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(260, 260, 270, 275, 280)
	recipe:SetCraftedItem(14529, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BANDAGES")
	recipe:AddTrainer(2329, 4591, 5150, 5759, 5943, 16662, 23734, 26956, 26992, 28706, 29233, 33621, 45540, 65862, 66222, 85930, 86034, 93529)

	-- Heavy Runecloth Bandage -- 18630
	recipe = AddRecipe(18630, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(290, 290, 300, 305, 310)
	recipe:SetCraftedItem(14530, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BANDAGES")
	recipe:AddTrainer(2329, 4591, 5150, 5759, 5943, 16662, 23734, 26956, 26992, 28706, 29233, 33621, 45540, 65862, 66222, 85930, 86034, 93529)

	-- Netherweave Bandage -- 27032
	recipe = AddRecipe(27032, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(21990, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BANDAGES")
	recipe:AddTrainer(4591, 5150, 16662, 23734, 26956, 26992, 28706, 29233, 33621, 45540, 65862, 66222, 85930, 86034, 93529)

	-- Heavy Netherweave Bandage -- 27033
	recipe = AddRecipe(27033, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(30, 30, 40, 45, 50)
	recipe:SetCraftedItem(21991, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BANDAGES")
	recipe:AddTrainer(4591, 5150, 16662, 23734, 26956, 26992, 28706, 29233, 33621, 45540, 65862, 66222, 85930, 86034, 93529)

	-- Frostweave Bandage -- 45545
	recipe = AddRecipe(45545, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(34721, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BANDAGES")
	recipe:AddTrainer(4591, 5150, 16662, 23734, 26956, 26992, 28706, 29233, 45540, 65862, 66222, 85930, 86034, 93529)

	-- Heavy Frostweave Bandage -- 45546
	recipe = AddRecipe(45546, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(15, 15, 25, 30, 35)
	recipe:SetCraftedItem(34722, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BANDAGES")
	recipe:AddTrainer(4591, 5150, 16662, 23734, 26956, 26992, 28706, 29233, 45540, 65862, 66222, 85930, 86034, 93529)

	-- Embersilk Bandage -- 74556
	recipe = AddRecipe(74556, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(53049, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BANDAGES")
	recipe:AddTrainer(4591, 5150, 16662, 45540, 65862, 66222, 85930, 86034, 93529)

	-- Heavy Embersilk Bandage -- 74557
	recipe = AddRecipe(74557, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(53050, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BANDAGES")
	recipe:AddTrainer(4591, 5150, 16662, 45540, 65862, 66222, 85930, 86034, 93529)

	-- Field Bandage: Dense Embersilk -- 74558
	recipe = AddRecipe(74558, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 85, 90, 95)
	recipe:SetCraftedItem(53051, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BANDAGES")
	recipe:AddTrainer(4591, 5150, 16662, 45540, 65862, 66222, 85930, 86034, 93529)

	-- Dense Embersilk Bandage -- 88893
	recipe = AddRecipe(88893, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 85, 90, 95)
	recipe:SetCraftedItem(53051, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BANDAGES")
	recipe:AddTrainer(4591, 5150, 16662, 45540, 65862, 66222, 85930, 86034, 93529)

	-- Windwool Bandage -- 102697
	recipe = AddRecipe(102697, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(72985, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BANDAGES")
	recipe:AddTrainer(65862, 66222, 85930, 86034, 93529)

	-- Heavy Windwool Bandage -- 102698
	recipe = AddRecipe(102698, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(72986, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BANDAGES")
	recipe:AddTrainer(65862, 66222, 85930, 86034, 93529)

	-- Antiseptic Bandage -- 172539
	recipe = AddRecipe(172539, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 1, 25, 50)
	recipe:SetCraftedItem(111603, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BANDAGES")
	recipe:AddCustom("DEFAULT_RECIPE")

	-- Silkweave Bandage -- 202853
	recipe = AddRecipe(202853, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(133940, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BANDAGES")
	recipe:AddTrainer(93529)

	-- Silkweave Splint -- 202854
	recipe = AddRecipe(202854, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(60, 60, 70, 75, 80)
	recipe:SetCraftedItem(133942, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BANDAGES")
	recipe:AddTrainer(93529)

	-- Feathered Luffa -- 230047
	recipe = AddRecipe(230047, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 40, 50, 60)
	recipe:SetCraftedItem(142332, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BANDAGES")
	recipe:AddRepVendor(FAC.THE_WARDENS, REP.HONORED, 107379)

	-- Tidespray Linen Sandals -- 257095
	recipe = AddRecipe(257095, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(154686, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_FEET")
	recipe:AddTrainer(122700, 136071, 153817, 154321)

	-- Tidespray Linen Mittens -- 257096
	recipe = AddRecipe(257096, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 15, 50, 85)
	recipe:SetCraftedItem(154687, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HANDS")
	recipe:AddCustom("DEFAULT_RECIPE")

	-- Tidespray Linen Hood -- 257097
	recipe = AddRecipe(257097, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(154688, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HEAD")
	recipe:AddTrainer(122700, 136071, 153817, 154321)

	-- Tidespray Linen Pants -- 257099
	recipe = AddRecipe(257099, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(154689, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_LEGS")
	recipe:AddTrainer(122700, 136071, 153817, 154321)

	-- Tidespray Linen Spaulders -- 257101
	recipe = AddRecipe(257101, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(154690, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_SHOULDER")
	recipe:AddTrainer(122700, 136071, 153817, 154321)

	-- Tidespray Linen Belt -- 257102
	recipe = AddRecipe(257102, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(154691, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WAIST")
	recipe:AddTrainer(122700, 136071, 153817, 154321)

	-- Tidespray Linen Bracers -- 257103
	recipe = AddRecipe(257103, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 10, 47, 85)
	recipe:SetCraftedItem(154692, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WRIST")
	recipe:AddCustom("DEFAULT_RECIPE")

	-- Tidespray Linen Robe -- 257104
	recipe = AddRecipe(257104, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(154685, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddTrainer(122700, 136071, 153817, 154321)

	-- Tidespray Linen Cloak -- 257107
	recipe = AddRecipe(257107, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(154697, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BACK")
	recipe:AddTrainer(122700, 136071, 153817, 154321)

	-- Embroidered Deep Sea Cloak -- 257114
	recipe = AddRecipe(257114, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(85, 85, 95, 100, 105)
	recipe:SetCraftedItem(154700, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BACK")
	recipe:AddTrainer(122700, 136071, 153817, 154321)

	-- Embroidered Deep Sea Cloak -- 257115
	recipe = AddRecipe(257115, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(110, 110, 120, 125, 130)
	recipe:SetCraftedItem(154700, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BACK")
	recipe:AddTrainer(122700, 136071, 153817, 154321)

	-- Embroidered Deep Sea Cloak -- 257116
	recipe = AddRecipe(257116, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 150, 150, 150)
	recipe:SetRecipeItem(162427, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(154700, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BACK")
	recipe:AddRepVendor(FAC.ORDER_OF_EMBERS, REP.REVERED, 135815)
	recipe:AddRepVendor(FAC.VOLDUNAI, REP.REVERED, 135804)

	-- Embroidered Deep Sea Gloves -- 257118
	recipe = AddRecipe(257118, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(110, 110, 120, 125, 130)
	recipe:SetCraftedItem(161985, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HANDS")
	recipe:AddTrainer(122700, 136071, 153817, 154321)

	-- Imbued Deep Sea Gloves -- 257120
	recipe = AddRecipe(257120, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(150, 150, 150, 150, 150)
	recipe:SetCraftedItem(162487, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HANDS")
	recipe:AddDiscovery("DISCOVERY_TAILOR_BFA")

	-- Emblazoned Deep Sea Gloves -- 257121
	recipe = AddRecipe(257121, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(150, 150, 150, 150, 150)
	recipe:SetCraftedItem(162476, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("TAILORING_HANDS")
	recipe:AddDiscovery("DISCOVERY_TAILOR_BFA")

	-- Embroidered Deep Sea Breeches -- 257122
	recipe = AddRecipe(257122, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(110, 110, 120, 125, 130)
	recipe:SetCraftedItem(161986, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_LEGS")
	recipe:AddTrainer(122700, 136071, 153817, 154321)

	-- Imbued Deep Sea Breeches -- 257123
	recipe = AddRecipe(257123, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(150, 150, 150, 150, 150)
	recipe:SetCraftedItem(162488, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("TAILORING_LEGS")
	recipe:AddDiscovery("DISCOVERY_TAILOR_BFA")

	-- Emblazoned Deep Sea Breeches -- 257124
	recipe = AddRecipe(257124, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(150, 150, 150, 150, 150)
	recipe:SetCraftedItem(162478, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("TAILORING_LEGS")
	recipe:AddDiscovery("DISCOVERY_TAILOR_BFA")

	-- Deep Sea Bag -- 257125
	recipe = AddRecipe(257125, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(154695, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BAG")
	recipe:AddTrainer(122700, 136071, 153817, 154321)

	-- Deep Sea Bag -- 257126
	recipe = AddRecipe(257126, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(85, 85, 95, 100, 105)
	recipe:SetCraftedItem(154695, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BAG")
	recipe:AddTrainer(122700, 136071, 153817, 154321)

	-- Deep Sea Bag -- 257127
	recipe = AddRecipe(257127, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(85, 85, 95, 100, 105)
	recipe:SetRecipeItem(162421, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(154695, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BAG")
	recipe:AddRepVendor(FAC.ORDER_OF_EMBERS, REP.REVERED, 135815)
	recipe:AddRepVendor(FAC.VOLDUNAI, REP.REVERED, 135804)

	-- Embroidered Deep Sea Bag -- 257128
	recipe = AddRecipe(257128, V.BFA, Q.UNCOMMON)
	recipe:SetSkillLevels(150, 150, 150, 150, 150)
	recipe:SetRecipeItem(163027, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(154696, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BAG")
	recipe:AddWorldDrop(Z.KUL_TIRAS, Z.ZANDALAR)

	-- Embroidered Deep Sea Bag -- 257129
	recipe = AddRecipe(257129, V.BFA, Q.UNCOMMON)
	recipe:SetSkillLevels(150, 150, 150, 150, 150)
	recipe:SetRecipeItem(163026, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(154696, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BAG")
	recipe:AddRepVendor(FAC.TORTOLLAN_SEEKERS, REP.REVERED, 134345, 135793)

	-- Embroidered Deep Sea Bag -- 257130
	recipe = AddRecipe(257130, V.BFA, Q.UNCOMMON)
	recipe:SetSkillLevels(150, 150, 150, 150, 150)
	recipe:SetRecipeItem(162422, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(154696, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BAG")
	recipe:AddMobDrop(138967)

	-- Battle Flag: Spirit of Freedom -- 257131
	recipe = AddRecipe(257131, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 85, 90, 95)
	recipe:SetCraftedItem(154707, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_MISC")
	recipe:AddTrainer(122700, 136071, 153817, 154321)

	-- Battle Flag: Spirit of Freedom -- 257132
	recipe = AddRecipe(257132, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 110, 115, 120)
	recipe:SetCraftedItem(154707, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_MISC")
	recipe:AddTrainer(122700, 136071, 153817, 154321)

	-- Battle Flag: Spirit of Freedom -- 257133
	recipe = AddRecipe(257133, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 150, 150, 150)
	recipe:SetRecipeItem(162443, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(154707, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_MISC")
	recipe:AddQuest(52422, 52425)

	-- Battle Flag: Phalanx Defense -- 257134
	recipe = AddRecipe(257134, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 85, 90, 95)
	recipe:SetCraftedItem(154706, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_MISC")
	recipe:AddTrainer(122700, 136071, 153817, 154321)

	-- Battle Flag: Phalanx Defense -- 257135
	recipe = AddRecipe(257135, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 110, 115, 120)
	recipe:SetCraftedItem(154706, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_MISC")
	recipe:AddTrainer(122700, 136071, 153817, 154321)

	-- Battle Flag: Phalanx Defense -- 257136
	recipe = AddRecipe(257136, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 150, 150, 150)
	recipe:SetCraftedItem(154706, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_MISC")
	recipe:AddQuest(52423, 52426)

	-- Battle Flag: Rallying Swiftness -- 257137
	recipe = AddRecipe(257137, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 85, 90, 95)
	recipe:SetCraftedItem(154705, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_MISC")
	recipe:AddTrainer(122700, 136071, 153817, 154321)

	-- Battle Flag: Rallying Swiftness -- 257138
	recipe = AddRecipe(257138, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 110, 115, 120)
	recipe:SetCraftedItem(154705, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_MISC")
	recipe:AddTrainer(122700, 136071, 153817, 154321)

	-- Battle Flag: Rallying Swiftness -- 257139
	recipe = AddRecipe(257139, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 150, 150, 150)
	recipe:SetRecipeItem(162445, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(154705, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_MISC")
	recipe:AddQuest(52424, 52427)

	-- Tidespray Linen Bandage -- 267201
	recipe = AddRecipe(267201, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(158381, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BANDAGES")
	recipe:AddTrainer(122700, 136071, 153817, 154321)

	-- Deep Sea Bandage -- 267202
	recipe = AddRecipe(267202, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(158382, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BANDAGES")
	recipe:AddTrainer(122700, 136071, 153817, 154321)

	-- Tidespray Linen Net -- 268982
	recipe = AddRecipe(268982, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(159791, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_MISC")
	recipe:AddTrainer(122700, 136071, 153817, 154321)

	-- Hooked Deep Sea Net -- 268983
	recipe = AddRecipe(268983, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(159792, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_MISC")
	recipe:AddTrainer(122700, 136071, 153817, 154321)

	-- Honorable Combatant's Satin Cloak -- 269596
	recipe = AddRecipe(269596, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(85, 85, 95, 100, 105)
	recipe:SetCraftedItem(159917, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BACK")
	recipe:AddTrainer(122700, 136071, 153817, 154321)

	-- Honorable Combatant's Satin Cloak -- 269597
	recipe = AddRecipe(269597, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 110, 127, 145)
	recipe:SetRecipeItem(162431, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(159917, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BACK")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(142552, 142564)

	-- Honorable Combatant's Satin Cloak -- 269598
	recipe = AddRecipe(269598, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 125, 137, 150)
	recipe:SetRecipeItem(162432, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(159917, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BACK")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(142552, 142564)

	-- Honorable Combatant's Satin Boots -- 269599
	recipe = AddRecipe(269599, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(85, 85, 95, 100, 105)
	recipe:SetCraftedItem(159912, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_FEET")
	recipe:AddTrainer(122700, 136071, 153817, 154321)

	-- Honorable Combatant's Satin Boots -- 269600
	recipe = AddRecipe(269600, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 110, 127, 145)
	recipe:SetRecipeItem(162433, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(159912, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_FEET")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(142552, 142564)

	-- Honorable Combatant's Satin Boots -- 269601
	recipe = AddRecipe(269601, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 125, 137, 150)
	recipe:SetRecipeItem(162434, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(159912, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_FEET")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(142552, 142564)

	-- Honorable Combatant's Satin Mittens -- 269602
	recipe = AddRecipe(269602, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(85, 85, 95, 100, 105)
	recipe:SetCraftedItem(159913, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HANDS")
	recipe:AddTrainer(122700, 136071, 153817, 154321)

	-- Honorable Combatant's Satin Mittens -- 269603
	recipe = AddRecipe(269603, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 110, 127, 145)
	recipe:SetRecipeItem(162435, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(159913, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HANDS")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(142552, 142564)

	-- Honorable Combatant's Satin Mittens -- 269604
	recipe = AddRecipe(269604, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 125, 137, 150)
	recipe:SetRecipeItem(162436, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(159913, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HANDS")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(142552, 142564)

	-- Honorable Combatant's Satin Pants -- 269605
	recipe = AddRecipe(269605, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(85, 85, 95, 100, 105)
	recipe:SetCraftedItem(159914, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_LEGS")
	recipe:AddTrainer(122700, 136071, 153817, 154321)

	-- Honorable Combatant's Satin Pants -- 269606
	recipe = AddRecipe(269606, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 110, 127, 145)
	recipe:SetRecipeItem(162437, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(159914, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_LEGS")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(142552, 142564)

	-- Honorable Combatant's Satin Pants -- 269607
	recipe = AddRecipe(269607, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 125, 137, 150)
	recipe:SetRecipeItem(162438, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(159914, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_LEGS")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(142552, 142564)

	-- Honorable Combatant's Satin Belt -- 269608
	recipe = AddRecipe(269608, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(85, 85, 95, 100, 105)
	recipe:SetCraftedItem(159915, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WAIST")
	recipe:AddTrainer(122700, 136071, 153817, 154321)

	-- Honorable Combatant's Satin Belt -- 269609
	recipe = AddRecipe(269609, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 110, 127, 145)
	recipe:SetRecipeItem(162439, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(159915, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WAIST")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(142552, 142564)

	-- Honorable Combatant's Satin Belt -- 269610
	recipe = AddRecipe(269610, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 125, 137, 150)
	recipe:SetRecipeItem(162440, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(159915, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WAIST")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(142552, 142564)

	-- Honorable Combatant's Satin Bracers -- 269611
	recipe = AddRecipe(269611, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(85, 85, 95, 100, 105)
	recipe:SetCraftedItem(159916, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WRIST")
	recipe:AddTrainer(122700, 136071, 153817, 154321)

	-- Honorable Combatant's Satin Bracers -- 269612
	recipe = AddRecipe(269612, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 110, 127, 145)
	recipe:SetRecipeItem(162441, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(159916, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WRIST")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(142552, 142564)

	-- Honorable Combatant's Satin Bracers -- 269613
	recipe = AddRecipe(269613, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 125, 137, 150)
	recipe:SetRecipeItem(162442, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(159916, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WRIST")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(142552, 142564)

	-- Embroidered Deep Sea Satin -- 272440
	recipe = AddRecipe(272440, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 85, 90, 95)
	recipe:SetCraftedItem(158378, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_MATERIALS")
	recipe:AddTrainer(122700, 136071, 153817, 154321)

	-- Rough-hooked Tidespray Linen -- 278414
	recipe = AddRecipe(278414, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 85, 90, 95)
	recipe:SetCraftedItem(165739, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_MISC")
	recipe:AddTrainer(122700, 136071, 153817, 154321)

	-- Resilient Spellthread -- 279182
	recipe = AddRecipe(279182, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 85, 90, 95)
	recipe:SetItemFilterType("TAILORING_ITEM_ENHANCEMENT")
	recipe:AddTrainer(122700, 136071, 153817, 154321)

	-- Discreet Spellthread -- 279183
	recipe = AddRecipe(279183, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 85, 90, 95)
	recipe:SetItemFilterType("TAILORING_ITEM_ENHANCEMENT")
	recipe:AddTrainer(122700, 136071, 153817, 154321)

	-- Feathery Spellthread -- 279184
	recipe = AddRecipe(279184, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 85, 90, 95)
	recipe:SetItemFilterType("TAILORING_ITEM_ENHANCEMENT")
	recipe:AddTrainer(122700, 136071, 153817, 154321)

	-- Sinister Combatant's Satin Bracers -- 282164
	recipe = AddRecipe(282164, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(115, 115, 125, 130, 135)
	recipe:SetCraftedItem(164675, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WRIST")
	recipe:AddTrainer(122700, 136071, 153817, 154321)

	-- Sinister Combatant's Satin Bracers -- 282165
	recipe = AddRecipe(282165, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 125, 137, 150)
	recipe:SetRecipeItem(165342, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(164675, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WRIST")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(142552, 142564)

	-- Sinister Combatant's Satin Bracers -- 282166
	recipe = AddRecipe(282166, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 145, 147, 150)
	recipe:SetRecipeItem(165343, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(164675, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WRIST")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(142552, 142564)

	-- Sinister Combatant's Satin Belt -- 282168
	recipe = AddRecipe(282168, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(115, 115, 125, 130, 135)
	recipe:SetCraftedItem(164674, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WAIST")
	recipe:AddTrainer(122700, 136071, 153817, 154321)

	-- Sinister Combatant's Satin Belt -- 282169
	recipe = AddRecipe(282169, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 140, 145, 150)
	recipe:SetRecipeItem(165340, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(164674, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WAIST")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(142552, 142564)

	-- Sinister Combatant's Satin Belt -- 282170
	recipe = AddRecipe(282170, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 145, 147, 150)
	recipe:SetRecipeItem(165341, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(164674, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WAIST")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(142552, 142564)

	-- Sinister Combatant's Satin Pants -- 282175
	recipe = AddRecipe(282175, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(115, 115, 125, 130, 135)
	recipe:SetCraftedItem(164673, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_LEGS")
	recipe:AddTrainer(122700, 136071, 153817, 154321)

	-- Sinister Combatant's Satin Pants -- 282176
	recipe = AddRecipe(282176, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 140, 145, 150)
	recipe:SetRecipeItem(165338, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(164673, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_LEGS")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(142552, 142564)

	-- Sinister Combatant's Satin Pants -- 282177
	recipe = AddRecipe(282177, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 145, 147, 150)
	recipe:SetRecipeItem(165339, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(164673, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_LEGS")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(142552, 142564)

	-- Sinister Combatant's Satin Mittens -- 282191
	recipe = AddRecipe(282191, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(115, 115, 125, 130, 135)
	recipe:SetCraftedItem(164672, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HANDS")
	recipe:AddTrainer(122700, 136071, 153817, 154321)

	-- Sinister Combatant's Satin Mittens -- 282192
	recipe = AddRecipe(282192, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 140, 145, 150)
	recipe:SetRecipeItem(165336, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(164672, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HANDS")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(142552, 142564)

	-- Sinister Combatant's Satin Mittens -- 282193
	recipe = AddRecipe(282193, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 145, 147, 150)
	recipe:SetRecipeItem(165337, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(164672, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HANDS")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(142552, 142564)

	-- Sinister Combatant's Satin Boots -- 282194
	recipe = AddRecipe(282194, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(115, 115, 125, 130, 135)
	recipe:SetCraftedItem(164671, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_FEET")
	recipe:AddTrainer(122700, 136071, 153817, 154321)

	-- Sinister Combatant's Satin Boots -- 282195
	recipe = AddRecipe(282195, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 140, 145, 150)
	recipe:SetRecipeItem(165334, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(164671, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_FEET")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(142552, 142564)

	-- Sinister Combatant's Satin Boots -- 282196
	recipe = AddRecipe(282196, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 145, 147, 150)
	recipe:SetRecipeItem(165335, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(164671, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_FEET")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(142552, 142564)

	-- Sinister Combatant's Satin Cloak -- 282204
	recipe = AddRecipe(282204, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(115, 115, 125, 130, 135)
	recipe:SetCraftedItem(164676, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BACK")
	recipe:AddTrainer(122700, 136071, 153817, 154321)

	-- Sinister Combatant's Satin Cloak -- 282275
	recipe = AddRecipe(282275, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 140, 145, 150)
	recipe:SetRecipeItem(165332, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(164676, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BACK")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(142552, 142564)

	-- Sinister Combatant's Satin Cloak -- 282276
	recipe = AddRecipe(282276, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 145, 147, 150)
	recipe:SetRecipeItem(165333, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(164676, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BACK")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(142552, 142564)

	-- Enhanced Deep Sea Breeches -- 285077
	recipe = AddRecipe(285077, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(115, 115, 125, 130, 135)
	recipe:SetCraftedItem(165377, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_LEGS")
	recipe:AddTrainer(122700, 136071, 153817, 154321)

	-- Enhanced Deep Sea Gloves -- 285078
	recipe = AddRecipe(285078, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(115, 115, 125, 130, 135)
	recipe:SetCraftedItem(165402, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HANDS")
	recipe:AddTrainer(122700, 136071, 153817, 154321)

	-- Fortified Deep Sea Breeches -- 285085
	recipe = AddRecipe(285085, V.BFA, Q.EPIC)
	recipe:SetSkillLevels(150, 150, 150, 150, 150)
	recipe:SetRecipeItem(165655, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(165385, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("TAILORING_LEGS")
	recipe:AddDiscovery("DISCOVERY_TAILOR_BFA")

	-- Fortified Deep Sea Gloves -- 285086
	recipe = AddRecipe(285086, V.BFA, Q.EPIC)
	recipe:SetSkillLevels(150, 150, 150, 150, 150)
	recipe:SetRecipeItem(165655, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(165385, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("TAILORING_LEGS")
	recipe:AddDiscovery("DISCOVERY_TAILOR_BFA")

	-- Tempered Deep Sea Breeches -- 285093
	recipe = AddRecipe(285093, V.BFA, Q.EPIC)
	recipe:SetSkillLevels(150, 150, 150, 150, 150)
	recipe:SetRecipeItem(165654, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(165393, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("TAILORING_LEGS")
	recipe:AddDiscovery("DISCOVERY_TAILOR_BFA")

	-- Tempered Deep Sea Gloves -- 285094
	recipe = AddRecipe(285094, V.BFA, Q.EPIC)
	recipe:SetSkillLevels(150, 150, 150, 150, 150)
	recipe:SetRecipeItem(165654, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(165393, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("TAILORING_LEGS")
	recipe:AddDiscovery("DISCOVERY_TAILOR_BFA")

	-- Sanguinated Alteration -- 286654
	recipe = AddRecipe(286654, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(162461, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_MATERIALS")
	recipe:AddTrainer(122700, 136071, 153817, 154321)

	-- Aqueous Alteration -- 287274
	recipe = AddRecipe(287274, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(162460, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_MATERIALS")
	recipe:AddTrainer(122700, 136071, 153817, 154321)

	-- Synchronous Thread -- 292946
	recipe = AddRecipe(292946, V.BFA, Q.RARE)
	recipe:SetSkillLevels(150, 150, 150, 150, 150)
	recipe:SetRecipeItem(168029, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(164733, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("TAILORING_MISC")
	recipe:AddQuest(53881, 53962)

	-- Notorious Combatant's Satin Cloak -- 294829
	recipe = AddRecipe(294829, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(145, 145, 155, 160, 165)
	recipe:SetCraftedItem(167983, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BACK")
	recipe:AddTrainer(153817, 154321)

	-- Notorious Combatant's Satin Cloak -- 294830
	recipe = AddRecipe(294830, V.BFA, Q.EPIC)
	recipe:SetSkillLevels(160, 160, 170, 172, 175)
	recipe:SetRecipeItem(169586, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(167983, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BACK")
	recipe:AddVendor(154652, 154653)

	-- Notorious Combatant's Satin Cloak -- 294831
	recipe = AddRecipe(294831, V.BFA, Q.EPIC)
	recipe:SetSkillLevels(170, 170, 175, 175, 175)
	recipe:SetRecipeItem(169587, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(167983, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BACK")
	recipe:AddVendor(154652, 154653)

	-- Notorious Combatant's Satin Boots -- 294832
	recipe = AddRecipe(294832, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(150, 150, 160, 165, 170)
	recipe:SetCraftedItem(167979, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_FEET")
	recipe:AddTrainer(153817, 154321)

	-- Notorious Combatant's Satin Boots -- 294833
	recipe = AddRecipe(294833, V.BFA, Q.EPIC)
	recipe:SetSkillLevels(165, 165, 170, 172, 175)
	recipe:SetRecipeItem(169578, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(167979, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_FEET")
	recipe:AddVendor(154652, 154653)

	-- Notorious Combatant's Satin Boots -- 294834
	recipe = AddRecipe(294834, V.BFA, Q.EPIC)
	recipe:SetSkillLevels(165, 165, 170, 172, 175)
	recipe:SetRecipeItem(169579, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(167979, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_FEET")
	recipe:AddVendor(154652, 154653)

	-- Notorious Combatant's Satin Mittens -- 294835
	recipe = AddRecipe(294835, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(145, 145, 155, 160, 165)
	recipe:SetCraftedItem(167985, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HANDS")
	recipe:AddTrainer(153817, 154321)

	-- Notorious Combatant's Satin Mittens -- 294836
	recipe = AddRecipe(294836, V.BFA, Q.EPIC)
	recipe:SetSkillLevels(160, 160, 170, 172, 175)
	recipe:SetRecipeItem(169580, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(167985, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HANDS")
	recipe:AddVendor(154652, 154653)

	-- Notorious Combatant's Satin Mittens -- 294837
	recipe = AddRecipe(294837, V.BFA, Q.EPIC)
	recipe:SetSkillLevels(170, 170, 175, 175, 175)
	recipe:SetRecipeItem(169581, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(167985, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HANDS")
	recipe:AddVendor(154652, 154653)

	-- Notorious Combatant's Satin Pants -- 294838
	recipe = AddRecipe(294838, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(155, 155, 165, 170, 175)
	recipe:SetCraftedItem(167987, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_LEGS")
	recipe:AddTrainer(153817, 154321)

	-- Notorious Combatant's Satin Pants -- 294839
	recipe = AddRecipe(294839, V.BFA, Q.EPIC)
	recipe:SetSkillLevels(170, 170, 175, 175, 175)
	recipe:SetRecipeItem(169584, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(167987, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_LEGS")
	recipe:AddVendor(154652, 154653)

	-- Notorious Combatant's Satin Pants -- 294840
	recipe = AddRecipe(294840, V.BFA, Q.EPIC)
	recipe:SetSkillLevels(175, 175, 175, 175, 175)
	recipe:SetRecipeItem(169585, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(167987, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_LEGS")
	recipe:AddVendor(154652, 154653)

	-- Notorious Combatant's Satin Belt -- 294841
	recipe = AddRecipe(294841, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(150, 150, 160, 165, 170)
	recipe:SetCraftedItem(167977, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WAIST")
	recipe:AddTrainer(153817, 154321)

	-- Notorious Combatant's Satin Belt -- 294842
	recipe = AddRecipe(294842, V.BFA, Q.EPIC)
	recipe:SetSkillLevels(165, 165, 170, 172, 175)
	recipe:SetRecipeItem(169576, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(167977, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WAIST")
	recipe:AddVendor(154652, 154653)

	-- Notorious Combatant's Satin Belt -- 294843
	recipe = AddRecipe(294843, V.BFA, Q.EPIC)
	recipe:SetSkillLevels(175, 175, 175, 175, 175)
	recipe:SetRecipeItem(169577, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(167977, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WAIST")
	recipe:AddVendor(154652, 154653)

	-- Notorious Combatant's Satin Bracers -- 294844
	recipe = AddRecipe(294844, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(145, 145, 155, 160, 165)
	recipe:SetCraftedItem(167981, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WRIST")
	recipe:AddTrainer(153817, 154321)

	-- Notorious Combatant's Satin Bracers -- 294845
	recipe = AddRecipe(294845, V.BFA, Q.EPIC)
	recipe:SetSkillLevels(160, 160, 170, 172, 175)
	recipe:SetRecipeItem(169582, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(167981, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WRIST")
	recipe:AddVendor(154652, 154653)

	-- Notorious Combatant's Satin Bracers -- 294846
	recipe = AddRecipe(294846, V.BFA, Q.EPIC)
	recipe:SetSkillLevels(170, 170, 175, 175, 175)
	recipe:SetRecipeItem(169583, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(167981, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WRIST")
	recipe:AddVendor(154652, 154653)

	-- Gilded Seaweave Gloves -- 299031
	recipe = AddRecipe(299031, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(165, 165, 175, 180, 185)
	recipe:SetCraftedItem(168728, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("TAILORING_HANDS")
	recipe:AddTrainer(153817, 154321)

	-- Reinforced Seaweave Gloves -- 299032
	recipe = AddRecipe(299032, V.BFA, Q.EPIC)
	recipe:SetSkillLevels(165, 165, 175, 175, 175)
	recipe:SetRecipeItem(168781, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(168729, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("TAILORING_HANDS")
	recipe:AddDiscovery("DISCOVERY_TAILOR_BFA")

	-- Banded Seaweave Gloves -- 299033
	recipe = AddRecipe(299033, V.BFA, Q.EPIC)
	recipe:SetSkillLevels(165, 165, 175, 175, 175)
	recipe:SetRecipeItem(168782, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(168730, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("TAILORING_HANDS")
	recipe:AddDiscovery("DISCOVERY_TAILOR_BFA")

	-- Gilded Seaweave Breeches -- 299034
	recipe = AddRecipe(299034, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(170, 170, 180, 185, 190)
	recipe:SetCraftedItem(168731, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_LEGS")
	recipe:AddTrainer(153817, 154321)

	-- Reinforced Seaweave Breeches -- 299035
	recipe = AddRecipe(299035, V.BFA, Q.EPIC)
	recipe:SetSkillLevels(170, 170, 180, 185, 190)
	recipe:SetRecipeItem(168783, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(168732, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("TAILORING_HANDS")
	recipe:AddDiscovery("DISCOVERY_TAILOR_BFA")

	-- Banded Seaweave Breeches -- 299036
	recipe = AddRecipe(299036, V.BFA, Q.EPIC)
	recipe:SetSkillLevels(170, 170, 180, 185, 190)
	recipe:SetRecipeItem(168784, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(168733, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("TAILORING_HANDS")
	recipe:AddDiscovery("DISCOVERY_TAILOR_BFA")

	-- Seabreeze Saddle Blanket -- 301403
	recipe = AddRecipe(301403, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(145, 145, 155, 160, 165)
	recipe:SetCraftedItem(169456, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_MISC")
	recipe:AddTrainer(153817, 154321)

	-- Saddlechute -- 301409
	recipe = AddRecipe(301409, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(150, 150, 160, 165, 170)
	recipe:SetCraftedItem(168427, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_MISC")
	recipe:AddTrainer(153817, 154321)

	-- Unsettling Seaweave Gloves -- 304559
	recipe = AddRecipe(304559, V.BFA, Q.RARE)
	recipe:SetSkillLevels(165, 165, 175, 178, 175)
	recipe:SetRecipeItem(174370, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(170456, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("TAILORING_HANDS")
	recipe:AddMobDrop(153910, 162245)

	-- Maddening Seaweave Gloves -- 304560
	recipe = AddRecipe(304560, V.BFA, Q.EPIC)
	recipe:SetSkillLevels(170, 170, 175, 178, 175)
	recipe:SetRecipeItem(171150, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(170457, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("TAILORING_HANDS")
	recipe:AddDiscovery("DISCOVERY_TAILOR_BFA")

	-- Eldritch Seaweave Gloves -- 304561
	recipe = AddRecipe(304561, V.BFA, Q.EPIC)
	recipe:SetSkillLevels(175, 175, 175, 178, 175)
	recipe:SetRecipeItem(171149, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(170458, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("TAILORING_HANDS")
	recipe:AddDiscovery("DISCOVERY_TAILOR_BFA")

	-- Unsettling Seaweave Breeches -- 304562
	recipe = AddRecipe(304562, V.BFA, Q.RARE)
	recipe:SetSkillLevels(165, 165, 175, 178, 175)
	recipe:SetRecipeItem(174371, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(170459, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("TAILORING_LEGS")
	recipe:AddMobDrop(153910, 162245)

	-- Maddening Seaweave Breeches -- 304563
	recipe = AddRecipe(304563, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(170, 170, 175, 178, 175)
	recipe:SetRecipeItem(171148, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(170460, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("TAILORING_LEGS")
	recipe:AddDiscovery("DISCOVERY_TAILOR_BFA")

	-- Eldritch Seaweave Breeches -- 304564
	recipe = AddRecipe(304564, V.BFA, Q.EPIC)
	recipe:SetSkillLevels(175, 175, 175, 178, 175)
	recipe:SetRecipeItem(171147, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(170461, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("TAILORING_LEGS")
	recipe:AddDiscovery("DISCOVERY_TAILOR_BFA")

	-- Uncanny Combatant's Satin Cloak -- 304565
	recipe = AddRecipe(304565, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(170, 170, 180, 185, 190)
	recipe:SetCraftedItem(170320, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BACK")
	recipe:AddTrainer(122700, 136071)

	-- Uncanny Combatant's Satin Cloak -- 304566
	recipe = AddRecipe(304566, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 165, 170, 175)
	recipe:SetRecipeItem(170444, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(170320, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BACK")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(142552, 142564, 161565)

	-- Uncanny Combatant's Satin Cloak -- 304567
	recipe = AddRecipe(304567, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 165, 170, 175)
	recipe:SetRecipeItem(170447, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(170320, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BACK")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(142552, 142564, 161565)

	-- Uncanny Combatant's Satin Boots -- 304568
	recipe = AddRecipe(304568, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(170, 170, 180, 185, 190)
	recipe:SetCraftedItem(170327, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_FEET")
	recipe:AddTrainer(122700, 136071)

	-- Uncanny Combatant's Satin Boots -- 304569
	recipe = AddRecipe(304569, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 165, 170, 175)
	recipe:SetRecipeItem(170448, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(170327, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_FEET")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(142552, 142564, 161565)

	-- Uncanny Combatant's Satin Boots -- 304570
	recipe = AddRecipe(304570, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 165, 170, 175)
	recipe:SetRecipeItem(170449, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(170327, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_FEET")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(142552, 142564, 161565)

	-- Uncanny Combatant's Satin Mittens -- 304571
	recipe = AddRecipe(304571, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(170, 170, 180, 185, 190)
	recipe:SetCraftedItem(170340, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HANDS")
	recipe:AddTrainer(122700, 136071)

	-- Uncanny Combatant's Satin Mittens -- 304572
	recipe = AddRecipe(304572, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 165, 170, 175)
	recipe:SetRecipeItem(170450, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(170340, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HANDS")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(142552, 142564, 161565)

	-- Uncanny Combatant's Satin Mittens -- 304573
	recipe = AddRecipe(304573, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 165, 170, 175)
	recipe:SetRecipeItem(170451, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(170340, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HANDS")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(142552, 142564, 161565)

	-- Uncanny Combatant's Satin Pants -- 304574
	recipe = AddRecipe(304574, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(170, 170, 180, 185, 190)
	recipe:SetCraftedItem(170325, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_LEGS")
	recipe:AddTrainer(122700, 136071)

	-- Uncanny Combatant's Satin Pants -- 304575
	recipe = AddRecipe(304575, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 165, 170, 175)
	recipe:SetRecipeItem(170452, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(170325, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_LEGS")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(142552, 142564, 161565)

	-- Uncanny Combatant's Satin Pants -- 304576
	recipe = AddRecipe(304576, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 165, 170, 175)
	recipe:SetRecipeItem(170453, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(170325, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_LEGS")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(142552, 142564, 161565)

	-- Uncanny Combatant's Satin Belt -- 304577
	recipe = AddRecipe(304577, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(170, 170, 180, 185, 190)
	recipe:SetCraftedItem(170324, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WAIST")
	recipe:AddTrainer(122700, 136071)

	-- Uncanny Combatant's Satin Belt -- 304578
	recipe = AddRecipe(304578, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 165, 170, 175)
	recipe:SetRecipeItem(170445, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(170324, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WAIST")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(142552, 142564, 161565)

	-- Uncanny Combatant's Satin Belt -- 304579
	recipe = AddRecipe(304579, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 165, 170, 175)
	recipe:SetRecipeItem(170446, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(170324, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WAIST")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(142552, 142564, 161565)

	-- Uncanny Combatant's Satin Bracers -- 304580
	recipe = AddRecipe(304580, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(170, 170, 180, 185, 190)
	recipe:SetCraftedItem(170323, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WRIST")
	recipe:AddTrainer(122700, 136071)

	-- Uncanny Combatant's Satin Bracers -- 304581
	recipe = AddRecipe(304581, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 165, 170, 175)
	recipe:SetRecipeItem(170454, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(170323, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WRIST")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(142552, 142564, 161565)

	-- Uncanny Combatant's Satin Bracers -- 304582
	recipe = AddRecipe(304582, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 165, 170, 175)
	recipe:SetRecipeItem(170455, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(170323, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WRIST")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(142552, 142564, 161565)

	-- Void Focus -- 307175
	recipe = AddRecipe(307175, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 165, 170, 175)
	recipe:SetRecipeItem(171312, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(171320, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("TAILORING_MISC")
	recipe:AddMobDrop(153910, 162245)

	-- ----------------------------------------------------------------------------
	-- Shadowlands.
	-- ----------------------------------------------------------------------------
	-- Shrouded Cloth Sandals -- 310869
	recipe = AddRecipe(310869, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(5, 5, 15, 20, 25)
	recipe:SetCraftedItem(173195, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_FEET")
	recipe:AddCustom("DEFAULT_RECIPE")

	-- Shrouded Cloth Robe -- 310870
	recipe = AddRecipe(310870, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(173193, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddTrainer(156681)

	-- Shrouded Cloth Cape -- 310871
	recipe = AddRecipe(310871, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(15, 15, 25, 30, 35)
	recipe:SetCraftedItem(173194, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BACK")
	recipe:AddTrainer(156681)

	-- Shrouded Cloth Mittens -- 310872
	recipe = AddRecipe(310872, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(10, 10, 20, 25, 30)
	recipe:SetCraftedItem(173196, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HANDS")
	recipe:AddTrainer(156681)

	-- Shrouded Cloth Hood -- 310873
	recipe = AddRecipe(310873, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(20, 20, 30, 35, 40)
	recipe:SetCraftedItem(173197, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HEAD")
	recipe:AddTrainer(156681)

	-- Shrouded Cloth Pants -- 310874
	recipe = AddRecipe(310874, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(30, 30, 40, 45, 50)
	recipe:SetCraftedItem(173198, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_LEGS")
	recipe:AddTrainer(156681)

	-- Shrouded Cloth Spaulders -- 310875
	recipe = AddRecipe(310875, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(35, 35, 45, 50, 55)
	recipe:SetCraftedItem(173199, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_SHOULDER")
	recipe:AddTrainer(156681)

	-- Shrouded Cloth Belt -- 310876
	recipe = AddRecipe(310876, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(5, 5, 15, 20, 25)
	recipe:SetCraftedItem(173200, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WAIST")
	recipe:AddTrainer(156681)

	-- Shrouded Cloth Bracers -- 310877
	recipe = AddRecipe(310877, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(10, 10, 10, 15, 20)
	recipe:SetCraftedItem(173201, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WRIST")
	recipe:AddCustom("DEFAULT_RECIPE")

	-- Grim-Veiled Sandals -- 310878
	recipe = AddRecipe(310878, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 100, 100, 100)
	recipe:SetCraftedItem(173243, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_FEET")
	recipe:AddTrainer(156681)

	-- Grim-Veiled Robe -- 310879
	recipe = AddRecipe(310879, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 100, 100, 100)
	recipe:SetCraftedItem(173241, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddTrainer(156681)

	-- Grim-Veiled Cape -- 310880
	recipe = AddRecipe(310880, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 100, 100, 100)
	recipe:SetCraftedItem(173242, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BACK")
	recipe:AddTrainer(156681)

	-- Grim-Veiled Mittens -- 310881
	recipe = AddRecipe(310881, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 100, 100, 100)
	recipe:SetCraftedItem(173244, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HANDS")
	recipe:AddTrainer(156681)

	-- Grim-Veiled Hood -- 310882
	recipe = AddRecipe(310882, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 100, 100, 100)
	recipe:SetCraftedItem(173245, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HEAD")
	recipe:AddTrainer(156681)

	-- Grim-Veiled Pants -- 310883
	recipe = AddRecipe(310883, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 100, 100, 100)
	recipe:SetCraftedItem(173246, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_LEGS")
	recipe:AddTrainer(156681)

	-- Grim-Veiled Spaulders -- 310884
	recipe = AddRecipe(310884, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 100, 100, 100)
	recipe:SetCraftedItem(173247, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_SHOULDER")
	recipe:AddTrainer(156681)

	-- Grim-Veiled Belt -- 310885
	recipe = AddRecipe(310885, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 100, 100, 100)
	recipe:SetCraftedItem(173248, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WAIST")
	recipe:AddTrainer(156681)

	-- Grim-Veiled Bracers -- 310886
	recipe = AddRecipe(310886, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 100, 100, 100)
	recipe:SetCraftedItem(173249, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WRIST")
	recipe:AddTrainer(156681)

	-- Shadowlace Footwraps -- 310896
	recipe = AddRecipe(310896, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(55, 55, 65, 70, 75)
	recipe:SetCraftedItem(173216, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_FEET")
	recipe:AddTrainer(156681)

	-- Shadowlace Tunic -- 310897
	recipe = AddRecipe(310897, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(80, 80, 90, 95, 100)
	recipe:SetCraftedItem(173214, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddTrainer(156681)

	-- Shadowlace Cloak -- 310898
	recipe = AddRecipe(310898, V.SHA, Q.RARE)
	recipe:SetSkillLevels(75, 75, 85, 90, 95)
	recipe:SetRecipeItem(183101, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(173215, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BACK")
	recipe:AddRepVendor(FAC.THE_UNDYING_ARMY, REP.HONORED, 173003, 176067)

	-- Shadowlace Handwraps -- 310899
	recipe = AddRecipe(310899, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(65, 65, 75, 80, 85)
	recipe:SetCraftedItem(173217, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HANDS")
	recipe:AddTrainer(156681)

	-- Shadowlace Cowl -- 310900
	recipe = AddRecipe(310900, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 85, 90, 95)
	recipe:SetCraftedItem(173218, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HEAD")
	recipe:AddTrainer(156681)

	-- Shadowlace Trousers -- 310901
	recipe = AddRecipe(310901, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(90, 90, 100, 105, 110)
	recipe:SetCraftedItem(173219, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_LEGS")
	recipe:AddTrainer(156681)

	-- Shadowlace Mantle -- 310902
	recipe = AddRecipe(310902, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(95, 95, 105, 110, 115)
	recipe:SetCraftedItem(173220, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BACK")
	recipe:AddTrainer(156681)

	-- Shadowlace Cord -- 310903
	recipe = AddRecipe(310903, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(60, 60, 70, 75, 80)
	recipe:SetCraftedItem(173221, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WAIST")
	recipe:AddTrainer(156681)

	-- Shadowlace Cuffs -- 310904
	recipe = AddRecipe(310904, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(173222, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WRIST")
	recipe:AddTrainer(156681)

	-- Heavy Shrouded Cloth Bandage -- 310923
	recipe = AddRecipe(310923, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(40, 40, 50, 55, 60)
	recipe:SetCraftedItem(173191, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BANDAGES")
	recipe:AddTrainer(156681)

	-- Shrouded Cloth Bandage -- 310924
	recipe = AddRecipe(310924, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 10, 15, 20)
	recipe:SetCraftedItem(173192, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BANDAGES")
	recipe:AddCustom("DEFAULT_RECIPE")

	-- Relic of the Past I -- 330257
	recipe = AddRecipe(330257, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(180055, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_MATERIALS")
	recipe:AddTrainer(136071, 153817, 154321)

	-- Relic of the Past II -- 330258
	recipe = AddRecipe(330258, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(180057, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_MATERIALS")
	recipe:AddTrainer(136071, 153817, 154321)

	-- Relic of the Past III -- 330259
	recipe = AddRecipe(330259, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(180058, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_MATERIALS")
	recipe:AddTrainer(136071, 153817, 154321)

	-- Relic of the Past IV -- 330260
	recipe = AddRecipe(330260, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(180059, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_MATERIALS")
	recipe:AddTrainer(136071, 153817, 154321)

	-- Relic of the Past V -- 330261
	recipe = AddRecipe(330261, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(180060, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_MATERIALS")
	recipe:AddTrainer(136071, 153817, 154321)

	-- Grim-Veiled Sandals -- 332030
	recipe = AddRecipe(332030, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 100, 100, 100)
	recipe:SetCraftedItem(173243, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_FEET")
	recipe:AddDiscovery("DISCOVERY_SHADOWLANDS")

	-- Grim-Veiled Robe -- 332031
	recipe = AddRecipe(332031, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 100, 100, 100)
	recipe:SetCraftedItem(173241, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddDiscovery("DISCOVERY_SHADOWLANDS")

	-- Grim-Veiled Cape -- 332032
	recipe = AddRecipe(332032, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 100, 100, 100)
	recipe:SetCraftedItem(173242, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BACK")
	recipe:AddDiscovery("DISCOVERY_SHADOWLANDS")

	-- Grim-Veiled Mittens -- 332033
	recipe = AddRecipe(332033, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 100, 100, 100)
	recipe:SetCraftedItem(173244, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HANDS")
	recipe:AddDiscovery("DISCOVERY_SHADOWLANDS")

	-- Grim-Veiled Hood -- 332034
	recipe = AddRecipe(332034, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 100, 100, 100)
	recipe:SetCraftedItem(173245, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HEAD")
	recipe:AddDiscovery("DISCOVERY_SHADOWLANDS")

	-- Grim-Veiled Pants -- 332035
	recipe = AddRecipe(332035, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 100, 100, 100)
	recipe:SetCraftedItem(173246, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_LEGS")
	recipe:AddDiscovery("DISCOVERY_SHADOWLANDS")

	-- Grim-Veiled Spaulders -- 332036
	recipe = AddRecipe(332036, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 100, 100, 100)
	recipe:SetCraftedItem(173247, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_SHOULDER")
	recipe:AddDiscovery("DISCOVERY_SHADOWLANDS")

	-- Grim-Veiled Belt -- 332037
	recipe = AddRecipe(332037, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 100, 100, 100)
	recipe:SetCraftedItem(173248, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WAIST")
	recipe:AddDiscovery("DISCOVERY_SHADOWLANDS")

	-- Grim-Veiled Bracers -- 332038
	recipe = AddRecipe(332038, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 100, 100, 100)
	recipe:SetCraftedItem(173249, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WRIST")
	recipe:AddDiscovery("DISCOVERY_SHADOWLANDS")

	-- Grim-Veiled Sandals -- 332065
	recipe = AddRecipe(332065, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 100, 100, 100)
	recipe:SetCraftedItem(173243, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_FEET")
	recipe:AddDiscovery("DISCOVERY_SHADOWLANDS")

	-- Grim-Veiled Robe -- 332066
	recipe = AddRecipe(332066, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 100, 100, 100)
	recipe:SetCraftedItem(173241, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddDiscovery("DISCOVERY_SHADOWLANDS")

	-- Grim-Veiled Cape -- 332067
	recipe = AddRecipe(332067, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 100, 100, 100)
	recipe:SetCraftedItem(173242, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BACK")
	recipe:AddDiscovery("DISCOVERY_SHADOWLANDS")

	-- Grim-Veiled Mittens -- 332068
	recipe = AddRecipe(332068, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 100, 100, 100)
	recipe:SetCraftedItem(173244, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HANDS")
	recipe:AddDiscovery("DISCOVERY_SHADOWLANDS")

	-- Grim-Veiled Hood -- 332069
	recipe = AddRecipe(332069, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 100, 100, 100)
	recipe:SetCraftedItem(173245, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HEAD")
	recipe:AddDiscovery("DISCOVERY_SHADOWLANDS")

	-- Grim-Veiled Pants -- 332070
	recipe = AddRecipe(332070, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 100, 100, 100)
	recipe:SetCraftedItem(173246, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_LEGS")
	recipe:AddDiscovery("DISCOVERY_SHADOWLANDS")

	-- Grim-Veiled Spaulders -- 332071
	recipe = AddRecipe(332071, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 100, 100, 100)
	recipe:SetCraftedItem(173247, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_SHOULDER")
	recipe:AddDiscovery("DISCOVERY_SHADOWLANDS")

	-- Grim-Veiled Belt -- 332072
	recipe = AddRecipe(332072, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 100, 100, 100)
	recipe:SetCraftedItem(173248, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WAIST")
	recipe:AddDiscovery("DISCOVERY_SHADOWLANDS")

	-- Grim-Veiled Bracers -- 332073
	recipe = AddRecipe(332073, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 100, 100, 100)
	recipe:SetCraftedItem(173249, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WRIST")
	recipe:AddDiscovery("DISCOVERY_SHADOWLANDS")

	-- Pink Party Hat -- 334499
	recipe = AddRecipe(334499, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 15, 20, 25)
	recipe:SetRecipeItem(180781, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(180752, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HEAD")
	recipe:AddWorldDrop(Z.MALDRAXXUS)

	-- Grim-Veiled Cape -- 338995
	recipe = AddRecipe(338995, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 100, 100, 100)
	recipe:SetCraftedItem(173242, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BACK")
	recipe:AddDiscovery("DISCOVERY_SHADOWLANDS")

	-- Grim-Veiled Robe -- 338996
	recipe = AddRecipe(338996, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 100, 100, 100)
	recipe:SetCraftedItem(173241, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_CHEST")
	recipe:AddDiscovery("DISCOVERY_SHADOWLANDS")

	-- Grim-Veiled Sandals -- 338997
	recipe = AddRecipe(338997, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 100, 100, 100)
	recipe:SetCraftedItem(173243, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_FEET")
	recipe:AddDiscovery("DISCOVERY_SHADOWLANDS")

	-- Grim-Veiled Mittens -- 338998
	recipe = AddRecipe(338998, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 100, 100, 100)
	recipe:SetCraftedItem(173244, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HANDS")
	recipe:AddDiscovery("DISCOVERY_SHADOWLANDS")

	-- Grim-Veiled Hood -- 339000
	recipe = AddRecipe(339000, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 100, 100, 100)
	recipe:SetCraftedItem(173245, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_HEAD")
	recipe:AddDiscovery("DISCOVERY_SHADOWLANDS")

	-- Grim-Veiled Pants -- 339001
	recipe = AddRecipe(339001, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 100, 100, 100)
	recipe:SetCraftedItem(173246, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_LEGS")
	recipe:AddDiscovery("DISCOVERY_SHADOWLANDS")

	-- Grim-Veiled Spaulders -- 339002
	recipe = AddRecipe(339002, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 100, 100, 100)
	recipe:SetCraftedItem(173247, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_SHOULDER")
	recipe:AddDiscovery("DISCOVERY_SHADOWLANDS")

	-- Grim-Veiled Belt -- 339003
	recipe = AddRecipe(339003, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 100, 100, 100)
	recipe:SetCraftedItem(173248, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WAIST")
	recipe:AddDiscovery("DISCOVERY_SHADOWLANDS")

	-- Grim-Veiled Bracers -- 339004
	recipe = AddRecipe(339004, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 100, 100, 100)
	recipe:SetCraftedItem(173249, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_WRIST")
	recipe:AddDiscovery("DISCOVERY_SHADOWLANDS")

	-- Crafter's Mark of the Chained Isle -- 343200
	recipe = AddRecipe(343200, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(200, 200, 200, 200, 200)
	recipe:SetRecipeItem(186470, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(173384, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("TAILORING_MATERIALS")
	recipe:AddRepVendor(FAC.THE_ARCHIVISTS_CODEX, REP.REVERED, 178257)

	-- Crafter's Mark III -- 343201
	recipe = AddRecipe(343201, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 190, 192, 195)
	recipe:SetRecipeItem(183868, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(173383, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("TAILORING_MATERIALS")
	recipe:AddRepVendor(FAC.DEATHS_ADVANCE, REP.HONORED, 179321)

	-- Crafter's Mark II -- 343202
	recipe = AddRecipe(343202, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 75, 80, 85)
	recipe:SetCraftedItem(173382, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("TAILORING_MATERIALS")
	recipe:AddVendor(162804)

	-- Crafter's Mark I -- 343204
	recipe = AddRecipe(343204, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(45, 45, 55, 60, 65)
	recipe:SetRecipeItem(183870, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(173381, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_MATERIALS")
	recipe:AddTrainer(156681)

	-- Novice Crafter's Mark -- 343659
	recipe = AddRecipe(343659, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(183942, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_MATERIALS")
	recipe:AddTrainer(156681)

	-- Shrouded Cloth Bag -- 345985
	recipe = AddRecipe(345985, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(15, 15, 25, 30, 35)
	recipe:SetCraftedItem(184479, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BAG")
	recipe:AddTrainer(156681)

	-- Lightless Silk Pouch -- 345986
	recipe = AddRecipe(345986, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(65, 65, 75, 80, 85)
	recipe:SetCraftedItem(184480, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_BAG")
	recipe:AddTrainer(156681)

	-- Vestige of Origins -- 352445
	recipe = AddRecipe(352445, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 190, 192, 195)
	recipe:SetCraftedItem(185960, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("TAILORING_MISC")
	recipe:AddRepVendor(FAC.DEATHS_ADVANCE, REP.HONORED, 179321)

	-- Shrouded Hand Towel -- 355183
	recipe = AddRecipe(355183, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(15, 15, 15, 20, 25)
	recipe:SetRecipeItem(186995, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(186975, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("TAILORING_MISC")
	recipe:AddWorldDrop(Z.THE_SHADOWLANDS)

-- 9.2 Recipes

	-- Crafter's Mark IV -- 359661
	recipe = AddRecipe(359661, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(201, 201, 201, 201, 201)
	recipe:SetRecipeItem(187750, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(187741, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("TAILORING_MISC")
	recipe:AddRepVendor(FAC.THE_ENLIGHTENED, REP.HONORED, 182257)

	-- Crafter's Mark of the First Ones -- 359670
	recipe = AddRecipe(359670, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(201, 201, 201, 201, 201)
	recipe:SetRecipeItem(187749, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(187742, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("TAILORING_MISC")
	recipe:AddRepVendor(FAC.THE_ENLIGHTENED, REP.HONORED, 182257)

	-- Vestige of the Eternal -- 359703
	recipe = AddRecipe(359703, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 203, 203, 203)
	recipe:SetRecipeItem(187785, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(187784, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("TAILORING_MISC")
	recipe:AddRepVendor(FAC.THE_ENLIGHTENED, REP.HONORED, 182257)

	self.InitializeRecipes = nil
end
