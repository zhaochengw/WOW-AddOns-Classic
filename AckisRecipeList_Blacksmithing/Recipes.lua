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
	-- Rough Sharpening Stone -- 2660
	recipe = AddRecipe(2660, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 15, 35, 55)
	recipe:SetCraftedItem(2862, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ITEM_ENHANCEMENT")
	recipe:AddCustom("DEFAULT_RECIPE")

	-- Copper Chain Belt -- 2661
	recipe = AddRecipe(2661, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(35, 35, 75, 95, 115)
	recipe:SetCraftedItem(2851, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 29924, 37072, 43429, 44781, 45548, 47384, 47396, 47400, 47418, 47419, 47421, 47431, 48619, 49885, 57620, 65043, 85917, 86048, 92183, 92264, 92265, 106655)

	-- Copper Chain Pants -- 2662
	recipe = AddRecipe(2662, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 50, 70, 90)
	recipe:SetCraftedItem(2852, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 29924, 37072, 43429, 44781, 45548, 47384, 47396, 47400, 47418, 47419, 47421, 47431, 48619, 49885, 57620, 65043, 85917, 86048, 92183, 92264, 92265, 106655)

	-- Copper Bracers -- 2663
	recipe = AddRecipe(2663, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 20, 40, 60)
	recipe:SetCraftedItem(2853, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddCustom("DEFAULT_RECIPE")

	-- Runed Copper Bracers -- 2664
	recipe = AddRecipe(2664, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(90, 90, 115, 127, 140)
	recipe:SetCraftedItem(2854, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 29924, 37072, 43429, 44781, 45548, 49885, 92264, 92265)

	-- Coarse Sharpening Stone -- 2665
	recipe = AddRecipe(2665, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(65, 65, 65, 72, 80)
	recipe:SetCraftedItem(2863, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 29924, 37072, 43429, 44781, 45548, 47384, 47396, 47400, 47418, 47419, 47421, 47431, 48619, 49885, 57620, 65043, 85917, 86048, 92183, 92264, 92265, 106655)

	-- Runed Copper Belt -- 2666
	recipe = AddRecipe(2666, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(70, 70, 110, 130, 150)
	recipe:SetCraftedItem(2857, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 29924, 37072, 43429, 44781, 45548, 47384, 47396, 47400, 47418, 47419, 47421, 47431, 48619, 49885, 57620, 65043, 85917, 86048, 92183, 92264, 92265, 106655)

	-- Runed Copper Breastplate -- 2667
	recipe = AddRecipe(2667, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(80, 80, 120, 140, 160)
	recipe:SetRecipeItem(2881, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(2864, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.DPS)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Rough Bronze Leggings -- 2668
	recipe = AddRecipe(2668, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(105, 105, 145, 160, 175)
	recipe:SetCraftedItem(2865, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 29924, 37072, 43429, 44781, 45548, 49885, 92264, 92265)

	-- Rough Bronze Cuirass -- 2670
	recipe = AddRecipe(2670, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(105, 105, 145, 160, 175)
	recipe:SetCraftedItem(2866, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 29924, 37072, 43429, 44781, 45548, 49885, 92264, 92265)

	-- Patterned Bronze Bracers -- 2672
	recipe = AddRecipe(2672, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(120, 120, 150, 165, 180)
	recipe:SetCraftedItem(2868, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 29924, 37072, 43429, 44781, 45548, 49885, 92264, 92265)

	-- Silvered Bronze Breastplate -- 2673
	recipe = AddRecipe(2673, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(130, 130, 160, 175, 190)
	recipe:SetRecipeItem(5578, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(2869, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Heavy Sharpening Stone -- 2674
	recipe = AddRecipe(2674, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(125, 125, 125, 132, 140)
	recipe:SetCraftedItem(2871, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 29924, 37072, 43429, 44781, 45548, 49885, 92264, 92265)

	-- Shining Silver Breastplate -- 2675
	recipe = AddRecipe(2675, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(145, 145, 175, 190, 205)
	recipe:SetCraftedItem(2870, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 29924, 37072, 43429, 44781, 45548, 49885, 92264, 92265)

	-- Copper Mace -- 2737
	recipe = AddRecipe(2737, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(15, 15, 55, 75, 95)
	recipe:SetCraftedItem(2844, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_MACE")
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 29924, 37072, 43429, 44781, 45548, 47384, 47396, 47400, 47418, 47419, 47421, 47431, 48619, 49885, 57620, 65043, 85917, 86048, 92183, 92264, 92265, 106655)

	-- Copper Axe -- 2738
	recipe = AddRecipe(2738, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(20, 20, 60, 80, 100)
	recipe:SetCraftedItem(2845, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_AXE")
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 29924, 37072, 43429, 44781, 45548, 47384, 47396, 47400, 47418, 47419, 47421, 47431, 48619, 49885, 57620, 65043, 85917, 86048, 92183, 92264, 92265, 106655)

	-- Copper Shortsword -- 2739
	recipe = AddRecipe(2739, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 65, 85, 105)
	recipe:SetCraftedItem(2847, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_SWORD")
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 29924, 37072, 43429, 44781, 45548, 47384, 47396, 47400, 47418, 47419, 47421, 47431, 48619, 49885, 57620, 65043, 85917, 86048, 92183, 92264, 92265, 106655)

	-- Bronze Mace -- 2740
	recipe = AddRecipe(2740, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(110, 110, 140, 155, 170)
	recipe:SetCraftedItem(2848, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_MACE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 29924, 37072, 43429, 44781, 45548, 49885, 92264, 92265)

	-- Bronze Axe -- 2741
	recipe = AddRecipe(2741, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(115, 115, 145, 160, 175)
	recipe:SetCraftedItem(2849, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_AXE")
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 29924, 37072, 43429, 44781, 45548, 49885, 92264, 92265)

	-- Bronze Shortsword -- 2742
	recipe = AddRecipe(2742, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(120, 120, 150, 165, 180)
	recipe:SetCraftedItem(2850, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_SWORD")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 29924, 37072, 43429, 44781, 45548, 49885, 92264, 92265)

	-- Rough Weightstone -- 3115
	recipe = AddRecipe(3115, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 15, 35, 55)
	recipe:SetCraftedItem(3239, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.DPS)
	recipe:AddCustom("DEFAULT_RECIPE")

	-- Coarse Weightstone -- 3116
	recipe = AddRecipe(3116, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(65, 65, 65, 72, 80)
	recipe:SetCraftedItem(3240, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 29924, 37072, 43429, 44781, 45548, 47384, 47396, 47400, 47418, 47419, 47421, 47431, 48619, 49885, 57620, 65043, 85917, 86048, 92183, 92264, 92265, 106655)

	-- Heavy Weightstone -- 3117
	recipe = AddRecipe(3117, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(125, 125, 125, 132, 140)
	recipe:SetCraftedItem(3241, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 29924, 37072, 43429, 44781, 45548, 49885, 92264, 92265)

	-- Heavy Copper Broadsword -- 3292
	recipe = AddRecipe(3292, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(95, 95, 135, 155, 175)
	recipe:SetCraftedItem(3487, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_SWORD")
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 29924, 37072, 43429, 44781, 45548, 49885, 92264, 92265)

	-- Copper Battle Axe -- 3293
	recipe = AddRecipe(3293, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(35, 35, 75, 95, 115)
	recipe:SetCraftedItem(3488, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_AXE")
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 29924, 37072, 43429, 44781, 45548, 47384, 47396, 47400, 47418, 47419, 47421, 47431, 48619, 49885, 57620, 65043, 85917, 86048, 92183, 92264, 92265, 106655)

	-- Thick War Axe -- 3294
	recipe = AddRecipe(3294, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(70, 70, 110, 130, 150)
	recipe:SetCraftedItem(3489, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_AXE")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 29924, 37072, 43429, 44781, 45548, 47384, 47396, 47400, 47418, 47419, 47421, 47431, 48619, 49885, 57620, 65043, 85917, 86048, 92183, 92264, 92265, 106655)

	-- Deadly Bronze Poniard -- 3295
	recipe = AddRecipe(3295, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(125, 125, 155, 170, 195)
	recipe:SetRecipeItem(2883, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(3490, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_DAGGER")
	recipe:AddFilters(F.DPS)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Heavy Bronze Mace -- 3296
	recipe = AddRecipe(3296, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(130, 130, 160, 175, 190)
	recipe:SetCraftedItem(3491, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_MACE")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 29924, 37072, 43429, 44781, 45548, 49885, 92264, 92265)

	-- Mighty Iron Hammer -- 3297
	recipe = AddRecipe(3297, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(145, 145, 175, 190, 205)
	recipe:SetRecipeItem(3608, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(3492, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_MACE")
	recipe:AddFilters(F.DPS)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Copper Chain Boots -- 3319
	recipe = AddRecipe(3319, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(20, 20, 60, 80, 100)
	recipe:SetCraftedItem(3469, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 29924, 37072, 43429, 44781, 45548, 47384, 47396, 47400, 47418, 47419, 47421, 47431, 48619, 49885, 57620, 65043, 85917, 86048, 92183, 92264, 92265, 106655)

	-- Rough Grinding Stone -- 3320
	recipe = AddRecipe(3320, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 45, 65, 85)
	recipe:SetCraftedItem(3470, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_MATERIALS")
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 29924, 37072, 43429, 44781, 45548, 47384, 47396, 47400, 47418, 47419, 47421, 47431, 48619, 49885, 57620, 65043, 85917, 86048, 92183, 92264, 92265, 106655)

	-- Copper Chain Vest -- 3321
	recipe = AddRecipe(3321, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(35, 35, 75, 95, 115)
	recipe:SetRecipeItem(3609, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(3471, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.DPS)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Runed Copper Gauntlets -- 3323
	recipe = AddRecipe(3323, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(40, 40, 80, 100, 120)
	recipe:SetCraftedItem(3472, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 29924, 37072, 43429, 44781, 45548, 47384, 47396, 47400, 47418, 47419, 47421, 47431, 48619, 49885, 57620, 65043, 85917, 86048, 92183, 92264, 92265, 106655)

	-- Runed Copper Pants -- 3324
	recipe = AddRecipe(3324, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(45, 45, 85, 105, 125)
	recipe:SetCraftedItem(3473, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 29924, 37072, 43429, 44781, 45548, 47384, 47396, 47400, 47418, 47419, 47421, 47431, 48619, 49885, 57620, 65043, 85917, 86048, 92183, 92264, 92265, 106655)

	-- Gemmed Copper Gauntlets -- 3325
	recipe = AddRecipe(3325, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(60, 60, 100, 120, 140)
	recipe:SetRecipeItem(3610, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(3474, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Coarse Grinding Stone -- 3326
	recipe = AddRecipe(3326, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 75, 87, 100)
	recipe:SetCraftedItem(3478, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_MATERIALS")
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 29924, 37072, 43429, 44781, 45548, 47384, 47396, 47400, 47418, 47419, 47421, 47431, 48619, 49885, 57620, 65043, 85917, 86048, 92183, 92264, 92265, 106655)

	-- Rough Bronze Shoulders -- 3328
	recipe = AddRecipe(3328, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(110, 110, 140, 155, 170)
	recipe:SetCraftedItem(3480, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHOULDER")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 29924, 37072, 43429, 44781, 45548, 49885, 92264, 92265)

	-- Silvered Bronze Shoulders -- 3330
	recipe = AddRecipe(3330, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(125, 125, 155, 170, 185)
	recipe:SetRecipeItem(2882, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(3481, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Silvered Bronze Boots -- 3331
	recipe = AddRecipe(3331, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(130, 130, 160, 175, 190)
	recipe:SetCraftedItem(3482, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 29924, 37072, 43429, 44781, 45548, 49885, 92264, 92265)

	-- Silvered Bronze Gauntlets -- 3333
	recipe = AddRecipe(3333, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(135, 135, 165, 180, 195)
	recipe:SetCraftedItem(3483, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 29924, 37072, 43429, 44781, 45548, 49885, 92264, 92265)

	-- Green Iron Boots -- 3334
	recipe = AddRecipe(3334, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(145, 145, 175, 190, 205)
	recipe:SetRecipeItem(3611, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(3484, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.DPS)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Green Iron Gauntlets -- 3336
	recipe = AddRecipe(3336, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(150, 150, 180, 195, 210)
	recipe:SetRecipeItem(3612, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(3485, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.DPS)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Heavy Grinding Stone -- 3337
	recipe = AddRecipe(3337, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(125, 125, 125, 137, 150)
	recipe:SetCraftedItem(3486, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_MATERIALS")
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 29924, 37072, 43429, 44781, 45548, 49885, 92264, 92265)

	-- Big Bronze Knife -- 3491
	recipe = AddRecipe(3491, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(105, 105, 135, 150, 165)
	recipe:SetCraftedItem(3848, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_DAGGER")
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 29924, 37072, 43429, 44781, 45548, 49885, 92264, 92265)

	-- Hardened Iron Shortsword -- 3492
	recipe = AddRecipe(3492, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(160, 160, 185, 197, 210)
	recipe:SetRecipeItem(12162, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(3849, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_SWORD")
	recipe:AddFilters(F.DPS)
	recipe:AddLimitedVendor(2843, 1, 3356, 1, 5512, 1, 45549, 1, 46359, 1)

	-- Jade Serpentblade -- 3493
	recipe = AddRecipe(3493, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(175, 175, 200, 212, 225)
	recipe:SetRecipeItem(3866, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(3850, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_SWORD")
	recipe:AddFilters(F.DPS)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Solid Iron Maul -- 3494
	recipe = AddRecipe(3494, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(155, 155, 180, 192, 205)
	recipe:SetRecipeItem(10858, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(3851, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_MACE")
	recipe:AddLimitedVendor(1471, 1, 8878, 1, 26081, 1)

	-- Golden Iron Destroyer -- 3495
	recipe = AddRecipe(3495, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(170, 170, 195, 207, 220)
	recipe:SetRecipeItem(3867, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(3852, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_MACE")
	recipe:AddFilters(F.DPS)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Moonsteel Broadsword -- 3496
	recipe = AddRecipe(3496, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(180, 180, 205, 217, 230)
	recipe:SetRecipeItem(12163, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(3853, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_SWORD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddLimitedVendor(2482, 1)

	-- Frost Tiger Blade -- 3497
	recipe = AddRecipe(3497, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(200, 200, 210, 215, 220)
	recipe:SetRecipeItem(3868, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(3854, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_SWORD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Massive Iron Axe -- 3498
	recipe = AddRecipe(3498, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(185, 185, 210, 222, 235)
	recipe:SetRecipeItem(12164, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(3855, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_AXE")
	recipe:AddFilters(F.DPS)
	recipe:AddLimitedVendor(1146, 1, 2483, 1)

	-- Shadow Crescent Axe -- 3500
	recipe = AddRecipe(3500, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(200, 200, 225, 237, 250)
	recipe:SetRecipeItem(3869, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(3856, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_AXE")
	recipe:AddFilters(F.DPS)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Green Iron Bracers -- 3501
	recipe = AddRecipe(3501, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(165, 165, 190, 202, 215)
	recipe:SetCraftedItem(3835, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 29924, 37072, 44781, 45548, 92264, 92265)

	-- Green Iron Helm -- 3502
	recipe = AddRecipe(3502, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(170, 170, 195, 207, 220)
	recipe:SetCraftedItem(3836, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 29924, 37072, 44781, 45548, 92264, 92265)

	-- Golden Scale Coif -- 3503
	recipe = AddRecipe(3503, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(190, 190, 215, 227, 240)
	recipe:SetRecipeItem(6047, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(3837, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.DPS)
	recipe:AddLimitedVendor(5411, 1)

	-- Green Iron Shoulders -- 3504
	recipe = AddRecipe(3504, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(160, 160, 185, 197, 210)
	recipe:SetRecipeItem(3870, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(3840, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHOULDER")
	recipe:AddFilters(F.DPS)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Golden Scale Shoulders -- 3505
	recipe = AddRecipe(3505, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(175, 175, 200, 212, 225)
	recipe:SetRecipeItem(3871, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(3841, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHOULDER")
	recipe:AddFilters(F.DPS)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Green Iron Leggings -- 3506
	recipe = AddRecipe(3506, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(155, 155, 180, 192, 205)
	recipe:SetCraftedItem(3842, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 29924, 37072, 44781, 45548, 92264, 92265)

	-- Golden Scale Leggings -- 3507
	recipe = AddRecipe(3507, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(170, 170, 195, 207, 220)
	recipe:SetRecipeItem(3872, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(3843, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.DPS)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Green Iron Hauberk -- 3508
	recipe = AddRecipe(3508, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(180, 180, 205, 217, 230)
	recipe:SetCraftedItem(3844, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 29924, 37072, 44781, 45548, 92264, 92265)

	-- Golden Scale Cuirass -- 3511
	recipe = AddRecipe(3511, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(195, 195, 220, 232, 245)
	recipe:SetRecipeItem(3873, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(3845, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.DPS)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Polished Steel Boots -- 3513
	recipe = AddRecipe(3513, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(185, 185, 210, 222, 235)
	recipe:SetRecipeItem(3874, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(3846, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Golden Scale Boots -- 3515
	recipe = AddRecipe(3515, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(200, 200, 210, 215, 220)
	recipe:SetRecipeItem(3875, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(3847, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Pearl-handled Dagger -- 6517
	recipe = AddRecipe(6517, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(110, 110, 140, 155, 170)
	recipe:SetCraftedItem(5540, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_DAGGER")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 29924, 37072, 43429, 44781, 45548, 49885, 92264, 92265)

	-- Iridescent Hammer -- 6518
	recipe = AddRecipe(6518, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(140, 140, 170, 185, 200)
	recipe:SetRecipeItem(5543, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(5541, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_MACE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Iron Shield Spike -- 7221
	recipe = AddRecipe(7221, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(150, 150, 180, 195, 210)
	recipe:SetRecipeItem(6044, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(6042, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ITEM_ENHANCEMENT")
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Iron Counterweight -- 7222
	recipe = AddRecipe(7222, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(165, 165, 190, 202, 215)
	recipe:SetRecipeItem(6045, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(6043, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Golden Scale Bracers -- 7223
	recipe = AddRecipe(7223, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(185, 185, 210, 222, 235)
	recipe:SetCraftedItem(6040, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 29924, 37072, 44781, 45548, 92264, 92265)

	-- Steel Weapon Chain -- 7224
	recipe = AddRecipe(7224, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(190, 190, 215, 227, 240)
	recipe:SetRecipeItem(6046, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(6041, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ITEM_ENHANCEMENT")
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Heavy Copper Maul -- 7408
	recipe = AddRecipe(7408, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(65, 65, 105, 125, 145)
	recipe:SetCraftedItem(6214, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_MACE")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 29924, 37072, 43429, 44781, 45548, 47384, 47396, 47400, 47418, 47419, 47421, 47431, 48619, 49885, 57620, 65043, 85917, 86048, 92183, 92264, 92265, 106655)

	-- Rough Bronze Boots -- 7817
	recipe = AddRecipe(7817, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(95, 95, 125, 140, 155)
	recipe:SetCraftedItem(6350, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 29924, 37072, 43429, 44781, 45548, 49885, 92264, 92265)

	-- Ironforge Breastplate -- 8367
	recipe = AddRecipe(8367, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(100, 100, 140, 160, 180)
	recipe:SetRecipeItem(6735, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(6731, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.DPS)
	recipe:AddQuest(1618)

	-- Iron Buckle -- 8768
	recipe = AddRecipe(8768, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(150, 150, 150, 152, 155)
	recipe:SetCraftedItem(7071, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_MATERIALS")
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 29924, 37072, 43429, 44781, 45548, 49885, 92264, 92265)

	-- Copper Dagger -- 8880
	recipe = AddRecipe(8880, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(30, 30, 70, 90, 110)
	recipe:SetCraftedItem(7166, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_DAGGER")
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 29924, 37072, 43429, 44781, 45548, 47384, 47396, 47400, 47418, 47419, 47421, 47431, 48619, 49885, 57620, 65043, 85917, 86048, 92183, 92264, 92265, 106655)

	-- Barbaric Iron Shoulders -- 9811
	recipe = AddRecipe(9811, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(160, 160, 185, 197, 210)
	recipe:SetRecipeItem(7978, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(7913, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddQuest(2752)

	-- Barbaric Iron Breastplate -- 9813
	recipe = AddRecipe(9813, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(160, 160, 185, 197, 210)
	recipe:SetRecipeItem(7979, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(7914, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.DPS)
	recipe:AddQuest(2751)

	-- Barbaric Iron Helm -- 9814
	recipe = AddRecipe(9814, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(175, 175, 200, 212, 225)
	recipe:SetRecipeItem(7980, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(7915, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddQuest(2754)

	-- Barbaric Iron Boots -- 9818
	recipe = AddRecipe(9818, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(180, 180, 205, 217, 230)
	recipe:SetRecipeItem(7981, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(7916, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddQuest(2753)

	-- Barbaric Iron Gloves -- 9820
	recipe = AddRecipe(9820, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(185, 185, 210, 222, 235)
	recipe:SetRecipeItem(7982, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(7917, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.DPS)
	recipe:AddQuest(2755)

	-- Steel Breastplate -- 9916
	recipe = AddRecipe(9916, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(200, 200, 225, 237, 250)
	recipe:SetCraftedItem(7963, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 29924, 37072, 44781, 45548, 92264, 92265)

	-- Solid Sharpening Stone -- 9918
	recipe = AddRecipe(9918, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(200, 200, 200, 205, 210)
	recipe:SetCraftedItem(7964, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16583, 16669, 16724, 16823, 17245, 19341, 29924, 37072, 44781, 45548, 92264, 92265)

	-- Solid Grinding Stone -- 9920
	recipe = AddRecipe(9920, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(200, 200, 200, 205, 210)
	recipe:SetCraftedItem(7966, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_MATERIALS")
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16583, 16669, 16724, 16823, 17245, 19341, 29924, 37072, 44781, 45548, 92264, 92265)

	-- Solid Weightstone -- 9921
	recipe = AddRecipe(9921, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(200, 200, 200, 205, 210)
	recipe:SetCraftedItem(7965, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16583, 16669, 16724, 16823, 17245, 19341, 29924, 37072, 44781, 45548, 92264, 92265)

	-- Heavy Mithril Shoulder -- 9926
	recipe = AddRecipe(9926, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(205, 205, 225, 235, 245)
	recipe:SetCraftedItem(7918, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16583, 16669, 16724, 16823, 17245, 19341, 29924, 37072, 44781, 45548, 92264, 92265)

	-- Heavy Mithril Gauntlet -- 9928
	recipe = AddRecipe(9928, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(205, 205, 225, 235, 245)
	recipe:SetCraftedItem(7919, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16583, 16669, 16724, 16823, 17245, 19341, 29924, 37072, 44781, 45548, 92264, 92265)

	-- Mithril Scale Pants -- 9931
	recipe = AddRecipe(9931, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(210, 210, 230, 240, 250)
	recipe:SetCraftedItem(7920, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16583, 16669, 16724, 16823, 17245, 19341, 29924, 37072, 44781, 45548, 92264, 92265)

	-- Heavy Mithril Pants -- 9933
	recipe = AddRecipe(9933, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(210, 210, 230, 240, 250)
	recipe:SetRecipeItem(7975, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(7921, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Steel Plate Helm -- 9935
	recipe = AddRecipe(9935, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(215, 215, 235, 245, 255)
	recipe:SetCraftedItem(7922, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16583, 16669, 16724, 16823, 17245, 19341, 29924, 37072, 44781, 45548, 92264, 92265)

	-- Mithril Scale Bracers -- 9937
	recipe = AddRecipe(9937, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(215, 215, 235, 245, 255)
	recipe:SetRecipeItem(7995, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(7924, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.DPS)
	recipe:AddLimitedVendor(8161, 1, 8176, 1)

	-- Mithril Shield Spike -- 9939
	recipe = AddRecipe(9939, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(215, 215, 235, 245, 255)
	recipe:SetRecipeItem(7976, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(7967, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ITEM_ENHANCEMENT")
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Ornate Mithril Pants -- 9945
	recipe = AddRecipe(9945, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(220, 220, 240, 250, 260)
	recipe:SetRecipeItem(7983, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(7926, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.DPS, F.TANK)
	recipe:Retire()

	-- Ornate Mithril Gloves -- 9950
	recipe = AddRecipe(9950, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(220, 220, 240, 250, 260)
	recipe:SetRecipeItem(7984, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(7927, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:Retire()

	-- Ornate Mithril Shoulder -- 9952
	recipe = AddRecipe(9952, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(225, 225, 245, 255, 265)
	recipe:SetRecipeItem(7985, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(7928, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHOULDER")
	recipe:AddFilters(F.DPS, F.TANK)
	recipe:Retire()

	-- Truesilver Gauntlets -- 9954
	recipe = AddRecipe(9954, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(225, 225, 245, 255, 265)
	recipe:SetCraftedItem(7938, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.DPS)
	recipe:Retire()

	-- Orcish War Leggings -- 9957
	recipe = AddRecipe(9957, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(250, 250, 250, 260, 270)
	recipe:SetCraftedItem(7929, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.DPS)
	recipe:Retire()

	-- Heavy Mithril Breastplate -- 9959
	recipe = AddRecipe(9959, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(230, 230, 250, 260, 270)
	recipe:SetCraftedItem(7930, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 29924, 37072, 44781, 45548, 92264, 92265)

	-- Mithril Coif -- 9961
	recipe = AddRecipe(9961, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(230, 230, 250, 260, 270)
	recipe:SetCraftedItem(7931, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 29924, 37072, 44781, 45548, 92264, 92265)

	-- Mithril Spurs -- 9964
	recipe = AddRecipe(9964, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(235, 235, 255, 265, 275)
	recipe:SetRecipeItem(7989, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(7969, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ITEM_ENHANCEMENT")
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Mithril Scale Shoulders -- 9966
	recipe = AddRecipe(9966, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(235, 235, 255, 265, 275)
	recipe:SetRecipeItem(7991, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(7932, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHOULDER")
	recipe:AddFilters(F.DPS)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Heavy Mithril Boots -- 9968
	recipe = AddRecipe(9968, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(235, 235, 255, 265, 275)
	recipe:SetCraftedItem(7933, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 29924, 37072, 44781, 45548, 92264, 92265)

	-- Heavy Mithril Helm -- 9970
	recipe = AddRecipe(9970, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(245, 245, 255, 265, 275)
	recipe:SetRecipeItem(7990, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(7934, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.DPS)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Ornate Mithril Breastplate -- 9972
	recipe = AddRecipe(9972, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(260, 260, 260, 270, 280)
	recipe:SetCraftedItem(7935, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.TANK)
	recipe:Retire()

	-- Truesilver Breastplate -- 9974
	recipe = AddRecipe(9974, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(245, 245, 265, 275, 285)
	recipe:SetCraftedItem(7939, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:Retire()

	-- Ornate Mithril Boots -- 9979
	recipe = AddRecipe(9979, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(265, 265, 265, 275, 285)
	recipe:SetCraftedItem(7936, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.TANK)
	recipe:Retire()

	-- Ornate Mithril Helm -- 9980
	recipe = AddRecipe(9980, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(265, 265, 265, 275, 285)
	recipe:SetCraftedItem(7937, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:Retire()

	-- Copper Claymore -- 9983
	recipe = AddRecipe(9983, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(30, 30, 70, 90, 110)
	recipe:SetCraftedItem(7955, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_SWORD")
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 29924, 37072, 43429, 44781, 45548, 47384, 47396, 47400, 47418, 47419, 47421, 47431, 48619, 49885, 57620, 65043, 85917, 86048, 92183, 92264, 92265, 106655)

	-- Bronze Warhammer -- 9985
	recipe = AddRecipe(9985, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(125, 125, 155, 170, 185)
	recipe:SetCraftedItem(7956, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_MACE")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 29924, 37072, 43429, 44781, 45548, 49885, 92264, 92265)

	-- Bronze Greatsword -- 9986
	recipe = AddRecipe(9986, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(130, 130, 160, 175, 190)
	recipe:SetCraftedItem(7957, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_SWORD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 29924, 37072, 43429, 44781, 45548, 49885, 92264, 92265)

	-- Bronze Battle Axe -- 9987
	recipe = AddRecipe(9987, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(135, 135, 165, 180, 195)
	recipe:SetCraftedItem(7958, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_AXE")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 29924, 37072, 43429, 44781, 45548, 49885, 92264, 92265)

	-- Heavy Mithril Axe -- 9993
	recipe = AddRecipe(9993, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(210, 210, 235, 247, 260)
	recipe:SetCraftedItem(7941, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_AXE")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 29924, 37072, 44781, 45548, 92264, 92265)

	-- Blue Glittering Axe -- 9995
	recipe = AddRecipe(9995, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(220, 220, 245, 257, 270)
	recipe:SetRecipeItem(7992, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(7942, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_AXE")
	recipe:AddFilters(F.DPS)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Wicked Mithril Blade -- 9997
	recipe = AddRecipe(9997, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(225, 225, 250, 262, 275)
	recipe:SetRecipeItem(8029, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(7943, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_SWORD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Big Black Mace -- 10001
	recipe = AddRecipe(10001, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(230, 230, 255, 267, 280)
	recipe:SetCraftedItem(7945, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_MACE")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 29924, 37072, 44781, 45548, 92264, 92265)

	-- The Shatterer -- 10003
	recipe = AddRecipe(10003, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(235, 235, 260, 272, 285)
	recipe:SetCraftedItem(7954, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_MACE")
	recipe:Retire()

	-- Dazzling Mithril Rapier -- 10005
	recipe = AddRecipe(10005, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(240, 240, 265, 277, 290)
	recipe:SetRecipeItem(7993, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(7944, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_SWORD")
	recipe:AddFilters(F.DPS)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Phantom Blade -- 10007
	recipe = AddRecipe(10007, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(270, 270, 270, 282, 295)
	recipe:SetRecipeItem(74274, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(7961, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_SWORD")
	recipe:AddWorldDrop(Z.STRATHOLME)

	-- Runed Mithril Hammer -- 10009
	recipe = AddRecipe(10009, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(245, 245, 270, 282, 295)
	recipe:SetRecipeItem(8028, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(7946, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_MACE")
	recipe:AddFilters(F.DPS)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Blight -- 10011
	recipe = AddRecipe(10011, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(250, 250, 275, 287, 300)
	recipe:SetRecipeItem(142337, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(7959, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_POLEARM")
	recipe:AddWorldDrop(Z.STRATHOLME)

	-- Ebon Shiv -- 10013
	recipe = AddRecipe(10013, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(255, 255, 280, 292, 305)
	recipe:SetRecipeItem(8030, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(7947, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_DAGGER")
	recipe:AddFilters(F.DPS)
	recipe:AddVendor(11278)

	-- Truesilver Champion -- 10015
	recipe = AddRecipe(10015, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(260, 260, 285, 297, 310)
	recipe:SetCraftedItem(7960, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_SWORD")
	recipe:Retire()

	-- Inlaid Mithril Cylinder -- 11454
	recipe = AddRecipe(11454, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(200, 200, 225, 237, 250)
	recipe:SetRecipeItem(10713, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(9060, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_MATERIALS")
	recipe:AddCustom("CRAFTED_ENGINEERS")

	-- Golden Scale Gauntlets -- 11643
	recipe = AddRecipe(11643, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(205, 205, 225, 235, 245)
	recipe:SetRecipeItem(9367, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(9366, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.DPS)
	recipe:Retire()

	-- Silvered Bronze Leggings -- 12259
	recipe = AddRecipe(12259, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(155, 155, 180, 192, 205)
	recipe:SetRecipeItem(10424, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(10423, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Rough Copper Vest -- 12260
	recipe = AddRecipe(12260, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 15, 35, 55)
	recipe:SetCraftedItem(10421, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddCustom("DEFAULT_RECIPE")

	-- Dark Iron Pulverizer -- 15292
	recipe = AddRecipe(15292, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(265, 265, 285, 295, 305)
	recipe:SetRecipeItem(11610, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(11608, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_MACE")
	recipe:AddMobDrop(9028)

	-- Dark Iron Mail -- 15293
	recipe = AddRecipe(15293, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(270, 270, 290, 300, 310)
	recipe:SetRecipeItem(11614, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(11606, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.BLACKROCK_DEPTHS)
	recipe:AddCustom("BRD_MAIL")

	-- Dark Iron Sunderer -- 15294
	recipe = AddRecipe(15294, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(275, 275, 295, 305, 315)
	recipe:SetRecipeItem(11611, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(11607, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_AXE")
	recipe:AddFilters(F.TANK)
	recipe:AddMobDrop(9554, 10043)

	-- Dark Iron Shoulders -- 15295
	recipe = AddRecipe(15295, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(280, 280, 300, 310, 320)
	recipe:SetRecipeItem(11615, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(11605, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHOULDER")
	recipe:AddFilters(F.DPS, F.TANK)
	recipe:AddWorldDrop(Z.BLACKROCK_DEPTHS)
	recipe:AddCustom("BRD_SHOULDERS")

	-- Dark Iron Plate -- 15296
	recipe = AddRecipe(15296, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(285, 285, 305, 315, 325)
	recipe:SetRecipeItem(11612, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(11604, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddMobDrop(9543)

	-- Glinting Steel Dagger -- 15972
	recipe = AddRecipe(15972, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(180, 180, 205, 217, 230)
	recipe:SetCraftedItem(12259, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_DAGGER")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 29924, 37072, 44781, 45548, 92264, 92265)

	-- Searing Golden Blade -- 15973
	recipe = AddRecipe(15973, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(190, 190, 215, 227, 240)
	recipe:SetRecipeItem(12261, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(12260, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_DAGGER")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Dense Grinding Stone -- 16639
	recipe = AddRecipe(16639, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(250, 250, 255, 257, 260)
	recipe:SetCraftedItem(12644, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_MATERIALS")
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 29924, 37072, 44781, 45548, 92264, 92265)

	-- Dense Weightstone -- 16640
	recipe = AddRecipe(16640, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(250, 250, 255, 257, 260)
	recipe:SetCraftedItem(12643, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 29924, 37072, 44781, 45548, 92264, 92265)

	-- Dense Sharpening Stone -- 16641
	recipe = AddRecipe(16641, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(250, 250, 255, 257, 260)
	recipe:SetCraftedItem(12404, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 29924, 37072, 44781, 45548, 92264, 92265)

	-- Thorium Armor -- 16642
	recipe = AddRecipe(16642, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(250, 250, 270, 280, 290)
	recipe:SetCraftedItem(12405, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16669, 16724, 16823, 17245, 19341, 37072, 44781, 45548, 92264, 92265)

	-- Thorium Belt -- 16643
	recipe = AddRecipe(16643, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(250, 250, 270, 280, 290)
	recipe:SetCraftedItem(12406, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16669, 16724, 16823, 17245, 19341, 37072, 44781, 45548, 92264, 92265)

	-- Thorium Bracers -- 16644
	recipe = AddRecipe(16644, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(255, 255, 275, 285, 295)
	recipe:SetCraftedItem(12408, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16669, 16724, 16823, 17245, 19341, 37072, 44781, 45548, 92264, 92265)

	-- Radiant Belt -- 16645
	recipe = AddRecipe(16645, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(260, 260, 280, 290, 300)
	recipe:SetRecipeItem(12685, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(12416, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Imperial Plate Shoulders -- 16646
	recipe = AddRecipe(16646, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(265, 265, 285, 295, 305)
	recipe:SetCraftedItem(12428, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHOULDER")
	recipe:AddFilters(F.DPS, F.TANK)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16583, 16669, 16724, 16823, 17245, 19341, 29924, 37072, 44781, 45548, 92264, 92265)

	-- Imperial Plate Belt -- 16647
	recipe = AddRecipe(16647, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(265, 265, 285, 295, 305)
	recipe:SetCraftedItem(12424, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddFilters(F.DPS, F.TANK)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16583, 16669, 16724, 16823, 17245, 19341, 29924, 37072, 44781, 45548, 92264, 92265)

	-- Radiant Breastplate -- 16648
	recipe = AddRecipe(16648, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(270, 270, 290, 300, 310)
	recipe:SetRecipeItem(12689, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(12415, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Imperial Plate Bracers -- 16649
	recipe = AddRecipe(16649, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(270, 270, 290, 300, 310)
	recipe:SetCraftedItem(12425, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.DPS, F.TANK)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16583, 16669, 16724, 16823, 17245, 19341, 29924, 37072, 44781, 45548, 92264, 92265)

	-- Wildthorn Mail -- 16650
	recipe = AddRecipe(16650, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(270, 270, 290, 300, 310)
	recipe:SetRecipeItem(12691, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(12624, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Thorium Shield Spike -- 16651
	recipe = AddRecipe(16651, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(275, 275, 295, 305, 315)
	recipe:SetRecipeItem(12692, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(12645, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ITEM_ENHANCEMENT")
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Thorium Boots -- 16652
	recipe = AddRecipe(16652, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(280, 280, 300, 310, 320)
	recipe:SetCraftedItem(12409, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16669, 16724, 16823, 17245, 19341, 37072, 44781, 45548, 92264, 92265)

	-- Thorium Helm -- 16653
	recipe = AddRecipe(16653, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(280, 280, 300, 310, 320)
	recipe:SetCraftedItem(12410, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16669, 16724, 16823, 17245, 19341, 37072, 44781, 45548, 92264, 92265)

	-- Radiant Gloves -- 16654
	recipe = AddRecipe(16654, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(285, 285, 305, 315, 325)
	recipe:SetRecipeItem(12695, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(12418, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.DPS)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Fiery Plate Gauntlets -- 16655
	recipe = AddRecipe(16655, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(290, 290, 310, 320, 330)
	recipe:SetRecipeItem(12699, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(12631, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:Retire()

	-- Radiant Boots -- 16656
	recipe = AddRecipe(16656, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(290, 290, 310, 320, 330)
	recipe:SetRecipeItem(12697, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(12419, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.DPS)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Imperial Plate Boots -- 16657
	recipe = AddRecipe(16657, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(295, 295, 315, 325, 335)
	recipe:SetCraftedItem(12426, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.DPS, F.TANK)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16583, 16669, 16724, 16823, 17245, 19341, 29924, 37072, 44781, 45548, 92264, 92265)

	-- Imperial Plate Helm -- 16658
	recipe = AddRecipe(16658, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(295, 295, 315, 325, 335)
	recipe:SetCraftedItem(12427, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.DPS, F.TANK)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16583, 16669, 16724, 16823, 17245, 19341, 29924, 37072, 44781, 45548, 92264, 92265)

	-- Radiant Circlet -- 16659
	recipe = AddRecipe(16659, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(295, 295, 315, 325, 335)
	recipe:SetRecipeItem(12702, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(12417, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.DPS)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Dawnbringer Shoulders -- 16660
	recipe = AddRecipe(16660, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(290, 290, 310, 320, 330)
	recipe:SetRecipeItem(12698, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(12625, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Storm Gauntlets -- 16661
	recipe = AddRecipe(16661, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(295, 295, 315, 325, 335)
	recipe:SetRecipeItem(12703, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(12632, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(11278)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Thorium Leggings -- 16662
	recipe = AddRecipe(16662, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetCraftedItem(12414, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16669, 16724, 16823, 17245, 19341, 37072, 44781, 45548, 92264, 92265)

	-- Imperial Plate Chest -- 16663
	recipe = AddRecipe(16663, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetCraftedItem(12422, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.DPS, F.TANK)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16583, 16669, 16724, 16823, 17245, 19341, 29924, 37072, 44781, 45548, 92264, 92265)

	-- Runic Plate Shoulders -- 16664
	recipe = AddRecipe(16664, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(12706, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(12610, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHOULDER")
	recipe:AddVendor(38561)

	-- Runic Plate Boots -- 16665
	recipe = AddRecipe(16665, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(12707, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(12611, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddVendor(38561)

	-- Demon Forged Breastplate -- 16667
	recipe = AddRecipe(16667, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(285, 285, 305, 315, 325)
	recipe:SetRecipeItem(12696, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(12628, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:Retire()

	-- Whitesoul Helm -- 16724
	recipe = AddRecipe(16724, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(12711, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(12633, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Radiant Leggings -- 16725
	recipe = AddRecipe(16725, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(12713, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(12420, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.DPS)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Runic Plate Helm -- 16726
	recipe = AddRecipe(16726, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(12714, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(12612, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddVendor(38561)

	-- Helm of the Great Chief -- 16728
	recipe = AddRecipe(16728, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(12716, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(12636, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Lionheart Helm -- 16729
	recipe = AddRecipe(16729, V.ORIG, Q.EPIC)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(12717, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(12640, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Imperial Plate Leggings -- 16730
	recipe = AddRecipe(16730, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetCraftedItem(12429, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.DPS, F.TANK)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16583, 16669, 16724, 16823, 17245, 19341, 29924, 37072, 44781, 45548, 92264, 92265)

	-- Runic Breastplate -- 16731
	recipe = AddRecipe(16731, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(12718, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(12613, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:Retire()

	-- Runic Plate Leggings -- 16732
	recipe = AddRecipe(16732, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(12719, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(12614, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddVendor(38561)

	-- Stronghold Gauntlets -- 16741
	recipe = AddRecipe(16741, V.ORIG, Q.EPIC)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(12720, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(12639, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.TANK)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Enchanted Thorium Helm -- 16742
	recipe = AddRecipe(16742, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(12725, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(12620, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.DPS, F.TANK)
	recipe:Retire()

	-- Enchanted Thorium Leggings -- 16744
	recipe = AddRecipe(16744, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(12726, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(12619, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.DPS, F.TANK)
	recipe:Retire()

	-- Enchanted Thorium Breastplate -- 16745
	recipe = AddRecipe(16745, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(12727, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(12618, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.DPS, F.TANK)
	recipe:Retire()

	-- Invulnerable Mail -- 16746
	recipe = AddRecipe(16746, V.ORIG, Q.EPIC)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(12728, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(12641, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.TANK)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Ornate Thorium Handaxe -- 16969
	recipe = AddRecipe(16969, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(275, 275, 300, 312, 325)
	recipe:SetRecipeItem(12819, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(12773, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_AXE")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16669, 16724, 16823, 17245, 19341, 37072, 44781, 45548, 92264, 92265)
	recipe:AddVendor(11278)

	-- Dawn's Edge -- 16970
	recipe = AddRecipe(16970, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(275, 275, 300, 312, 325)
	recipe:SetRecipeItem(142357, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(12774, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_AXE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddQuest(44952)

	-- Huge Thorium Battleaxe -- 16971
	recipe = AddRecipe(16971, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(280, 280, 305, 317, 330)
	recipe:SetRecipeItem(12823, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(12775, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_AXE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16669, 16724, 16823, 17245, 19341, 37072, 44781, 45548, 92264, 92265)
	recipe:AddVendor(11278)

	-- Enchanted Battlehammer -- 16973
	recipe = AddRecipe(16973, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(280, 280, 305, 317, 330)
	recipe:SetRecipeItem(12824, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(12776, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_MACE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.TANK)
	recipe:Retire()

	-- Blazing Rapier -- 16978
	recipe = AddRecipe(16978, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(280, 280, 305, 317, 330)
	recipe:SetRecipeItem(142358, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(12777, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_SWORD")
	recipe:AddCustom("TIMELOSTCHEST")

	-- Serenity -- 16983
	recipe = AddRecipe(16983, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(285, 285, 310, 322, 335)
	recipe:SetRecipeItem(12827, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(12781, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_MACE")
	recipe:AddWorldDrop(Z.STRATHOLME)
	recipe:AddCustom("STRATH_BS_PLANS")

	-- Volcanic Hammer -- 16984
	recipe = AddRecipe(16984, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(290, 290, 315, 327, 340)
	recipe:SetRecipeItem(12828, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(12792, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_MACE")
	recipe:AddMobDrop(10119)

	-- Corruption -- 16985
	recipe = AddRecipe(16985, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(290, 290, 315, 327, 340)
	recipe:SetRecipeItem(12830, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(12782, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_SWORD")
	recipe:AddFilters(F.DPS)
	recipe:AddWorldDrop(Z.STRATHOLME)
	recipe:AddCustom("STRATH_BS_PLANS")

	-- Hammer of the Titans -- 16988
	recipe = AddRecipe(16988, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(12833, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(12796, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_MACE")
	recipe:AddFilters(F.DPS)
	recipe:AddMobDrop(10438)

	-- Arcanite Champion -- 16990
	recipe = AddRecipe(16990, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(142370, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(12790, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_SWORD")
	recipe:AddMobDrop(9568)

	-- Annihilator -- 16991
	recipe = AddRecipe(16991, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(12835, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(12798, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_AXE")
	recipe:AddFilters(F.TANK)
	recipe:AddMobDrop(9736)

	-- Frostguard -- 16992
	recipe = AddRecipe(16992, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(12836, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(12797, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_SWORD")
	recipe:AddMobDrop(1844)
	recipe:AddLimitedVendor(50129, 1)

	-- Masterwork Stormhammer -- 16993
	recipe = AddRecipe(16993, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(12837, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(12794, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_MACE")
	recipe:Retire()

	-- Arcanite Reaper -- 16994
	recipe = AddRecipe(16994, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(12838, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(12784, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_AXE")
	recipe:AddFilters(F.DPS)
	recipe:AddMobDrop(9596)

	-- Heartseeker -- 16995
	recipe = AddRecipe(16995, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(12839, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(12783, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_DAGGER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddMobDrop(10997)

	-- Silver Skeleton Key -- 19666
	recipe = AddRecipe(19666, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 100, 110, 120)
	recipe:SetCraftedItem(15869, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SKELETON_KEY")
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 29924, 37072, 43429, 44781, 45548, 49885, 92264, 92265)

	-- Golden Skeleton Key -- 19667
	recipe = AddRecipe(19667, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(150, 150, 150, 160, 170)
	recipe:SetCraftedItem(15870, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SKELETON_KEY")
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 29924, 37072, 43429, 44781, 45548, 49885, 92264, 92265)

	-- Truesilver Skeleton Key -- 19668
	recipe = AddRecipe(19668, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(200, 200, 200, 210, 220)
	recipe:SetCraftedItem(15871, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SKELETON_KEY")
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 29924, 37072, 44781, 45548, 92264, 92265)

	-- Arcanite Skeleton Key -- 19669
	recipe = AddRecipe(19669, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(275, 275, 275, 280, 285)
	recipe:SetCraftedItem(15872, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SKELETON_KEY")
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 29924, 37072, 44781, 45548, 92264, 92265)

	-- Fiery Chain Girdle -- 20872
	recipe = AddRecipe(20872, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(295, 295, 315, 325, 335)
	recipe:SetRecipeItem(17049, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(16989, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddRepVendor(FAC.THORIUM_BROTHERHOOD, REP.HONORED, 12944)

	-- Fiery Chain Shoulders -- 20873
	recipe = AddRecipe(20873, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(17053, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(16988, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddRepVendor(FAC.THORIUM_BROTHERHOOD, REP.REVERED, 12944)

	-- Dark Iron Bracers -- 20874
	recipe = AddRecipe(20874, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(295, 295, 315, 325, 335)
	recipe:SetRecipeItem(17051, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(17014, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddRepVendor(FAC.THORIUM_BROTHERHOOD, REP.FRIENDLY, 12944)

	-- Dark Iron Leggings -- 20876
	recipe = AddRecipe(20876, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(17052, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(17013, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddRepVendor(FAC.THORIUM_BROTHERHOOD, REP.REVERED, 12944)

	-- Dark Iron Reaver -- 20890
	recipe = AddRecipe(20890, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(17059, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(17015, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_SWORD")
	recipe:AddRepVendor(FAC.THORIUM_BROTHERHOOD, REP.HONORED, 12944)

	-- Dark Iron Destroyer -- 20897
	recipe = AddRecipe(20897, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(17060, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(17016, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_AXE")
	recipe:AddFilters(F.DPS)
	recipe:AddRepVendor(FAC.THORIUM_BROTHERHOOD, REP.HONORED, 12944)

	-- Sulfuron Hammer -- 21161
	recipe = AddRecipe(21161, V.ORIG, Q.EPIC)
	recipe:SetSkillLevels(300, 300, 325, 337, 350)
	recipe:SetRecipeItem(18592, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(17193, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_MACE")
	recipe:AddQuest(7604)

	-- Edge of Winter -- 21913
	recipe = AddRecipe(21913, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(190, 190, 215, 227, 240)
	recipe:SetRecipeItem(17706, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(17704, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_AXE")
	recipe:AddWorldEvent("WINTER_VEIL")

	-- Elemental Sharpening Stone -- 22757
	recipe = AddRecipe(22757, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(300, 300, 300, 310, 320)
	recipe:SetRecipeItem(18264, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(18262, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.MOLTEN_CORE)

	-- Heavy Timbermaw Belt -- 23628
	recipe = AddRecipe(23628, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(290, 290, 310, 320, 330)
	recipe:SetRecipeItem(19202, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(19043, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddFilters(F.DPS)
	recipe:AddRepVendor(FAC.TIMBERMAW_HOLD, REP.HONORED, 11557)

	-- Heavy Timbermaw Boots -- 23629
	recipe = AddRecipe(23629, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(19204, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(19048, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.DPS)
	recipe:AddRepVendor(FAC.TIMBERMAW_HOLD, REP.REVERED, 11557)

	-- Girdle of the Dawn -- 23632
	recipe = AddRecipe(23632, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(290, 290, 310, 320, 330)
	recipe:SetRecipeItem(19203, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(19051, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddFilters(F.DPS)
	recipe:AddRepVendor(FAC.ARGENT_DAWN, REP.HONORED, 10856, 10857, 11536)

	-- Gloves of the Dawn -- 23633
	recipe = AddRecipe(23633, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(19205, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(19057, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.DPS)
	recipe:AddRepVendor(FAC.ARGENT_DAWN, REP.REVERED, 10856, 10857, 11536)

	-- Dark Iron Helm -- 23636
	recipe = AddRecipe(23636, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(19206, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(19148, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddRepVendor(FAC.THORIUM_BROTHERHOOD, REP.HONORED, 12944)

	-- Dark Iron Gauntlets -- 23637
	recipe = AddRecipe(23637, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(19207, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(19164, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.DPS)
	recipe:AddRepVendor(FAC.THORIUM_BROTHERHOOD, REP.REVERED, 12944)

	-- Black Amnesty -- 23638
	recipe = AddRecipe(23638, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(19208, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(19166, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_DAGGER")
	recipe:AddRepVendor(FAC.THORIUM_BROTHERHOOD, REP.REVERED, 12944)

	-- Blackfury -- 23639
	recipe = AddRecipe(23639, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(19209, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(19167, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_POLEARM")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddRepVendor(FAC.THORIUM_BROTHERHOOD, REP.REVERED, 12944)

	-- Ebon Hand -- 23650
	recipe = AddRecipe(23650, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(19210, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(19170, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_MACE")
	recipe:AddRepVendor(FAC.THORIUM_BROTHERHOOD, REP.EXALTED, 12944)

	-- Blackguard -- 23652
	recipe = AddRecipe(23652, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(19211, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(19168, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_SWORD")
	recipe:AddFilters(F.TANK)
	recipe:AddRepVendor(FAC.THORIUM_BROTHERHOOD, REP.EXALTED, 12944)

	-- Nightfall -- 23653
	recipe = AddRecipe(23653, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(19212, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(19169, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_AXE")
	recipe:AddRepVendor(FAC.THORIUM_BROTHERHOOD, REP.EXALTED, 12944)

	-- Bloodsoul Breastplate -- 24136
	recipe = AddRecipe(24136, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(19776, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(19690, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:Retire()

	-- Bloodsoul Shoulders -- 24137
	recipe = AddRecipe(24137, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(19777, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(19691, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:Retire()

	-- Bloodsoul Gauntlets -- 24138
	recipe = AddRecipe(24138, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(19778, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(19692, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:Retire()

	-- Darksoul Breastplate -- 24139
	recipe = AddRecipe(24139, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(19779, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(19693, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.TANK)
	recipe:Retire()

	-- Darksoul Leggings -- 24140
	recipe = AddRecipe(24140, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(19780, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(19694, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.TANK)
	recipe:Retire()

	-- Darksoul Shoulders -- 24141
	recipe = AddRecipe(24141, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(19781, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(19695, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.TANK)
	recipe:Retire()

	-- Dark Iron Boots -- 24399
	recipe = AddRecipe(24399, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(20040, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(20039, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddRepVendor(FAC.THORIUM_BROTHERHOOD, REP.EXALTED, 12944)

	-- Darkrune Gauntlets -- 24912
	recipe = AddRecipe(24912, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(20553, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(20549, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.TANK)
	recipe:AddQuest(8323)

	-- Darkrune Helm -- 24913
	recipe = AddRecipe(24913, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(20555, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(20551, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddQuest(8323)

	-- Darkrune Breastplate -- 24914
	recipe = AddRecipe(24914, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(20554, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(20550, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.TANK)
	recipe:AddQuest(8323)

	-- Heavy Obsidian Belt -- 27585
	recipe = AddRecipe(27585, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(22209, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(22197, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddFilters(F.DPS)
	recipe:AddRepVendor(FAC.CENARION_CIRCLE, REP.FRIENDLY, 15176)

	-- Jagged Obsidian Shield -- 27586
	recipe = AddRecipe(27586, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(22219, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(22198, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHIELD")
	recipe:AddFilters(F.TANK)
	recipe:AddRepVendor(FAC.CENARION_CIRCLE, REP.REVERED, 15471)

	-- Thick Obsidian Breastplate -- 27587
	recipe = AddRecipe(27587, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(22222, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(22196, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.DPS)
	recipe:AddMobDrop(15263)

	-- Light Obsidian Belt -- 27588
	recipe = AddRecipe(27588, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(22214, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(22195, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddRepVendor(FAC.CENARION_CIRCLE, REP.HONORED, 15176)

	-- Black Grasp of the Destroyer -- 27589
	recipe = AddRecipe(27589, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(22220, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(22194, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddMobDrop(15340)

	-- Obsidian Mail Tunic -- 27590
	recipe = AddRecipe(27590, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(22221, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(22191, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddRepVendor(FAC.CENARION_CIRCLE, REP.EXALTED, 15471)

	-- Titanic Leggings -- 27829
	recipe = AddRecipe(27829, V.ORIG, Q.EPIC)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(22388, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(22385, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Persuader -- 27830
	recipe = AddRecipe(27830, V.ORIG, Q.EPIC)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(22390, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(22384, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_MACE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Sageblade -- 27832
	recipe = AddRecipe(27832, V.ORIG, Q.EPIC)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(22389, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(22383, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_SWORD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Icebane Breastplate -- 28242
	recipe = AddRecipe(28242, V.ORIG, Q.EPIC)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetCraftedItem(22669, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.DPS, F.TANK)
	recipe:Retire()

	-- Icebane Gauntlets -- 28243
	recipe = AddRecipe(28243, V.ORIG, Q.EPIC)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetCraftedItem(22670, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.DPS, F.TANK)
	recipe:Retire()

	-- Icebane Bracers -- 28244
	recipe = AddRecipe(28244, V.ORIG, Q.EPIC)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetCraftedItem(22671, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.DPS, F.TANK)
	recipe:Retire()

	-- Ironvine Breastplate -- 28461
	recipe = AddRecipe(28461, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(22766, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(22762, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.TANK)
	recipe:AddRepVendor(FAC.CENARION_CIRCLE, REP.REVERED, 15176)

	-- Ironvine Gloves -- 28462
	recipe = AddRecipe(28462, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(22767, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(22763, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.TANK)
	recipe:AddRepVendor(FAC.CENARION_CIRCLE, REP.HONORED, 15176)

	-- Ironvine Belt -- 28463
	recipe = AddRecipe(28463, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(22768, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(22764, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddFilters(F.TANK)
	recipe:AddRepVendor(FAC.CENARION_CIRCLE, REP.FRIENDLY, 15176)

	-- Relic of the Past I -- 330134
	recipe = AddRecipe(330134, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(180055, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_MATERIALS")
	recipe:AddTrainer(2998, 4258, 4596, 5511, 11146, 16669, 45548, 85917, 86048, 92183, 106655)

	-- Relic of the Past II -- 330140
	recipe = AddRecipe(330140, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(180057, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_MATERIALS")
	recipe:AddTrainer(2998, 4258, 4596, 5511, 11146, 16669, 45548, 85917, 86048, 92183, 106655)

	-- Relic of the Past III -- 330141
	recipe = AddRecipe(330141, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(180058, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_MATERIALS")
	recipe:AddTrainer(2998, 4258, 4596, 5511, 11146, 16669, 45548, 85917, 86048, 92183, 106655)

	-- Relic of the Past IV -- 330142
	recipe = AddRecipe(330142, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(180059, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_MATERIALS")
	recipe:AddTrainer(2998, 4258, 4596, 5511, 11146, 16669, 45548, 85917, 86048, 92183, 106655)

	-- Relic of the Past V -- 330143
	recipe = AddRecipe(330143, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(180060, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_MATERIALS")
	recipe:AddTrainer(2998, 4258, 4596, 5511, 11146, 16669, 45548, 85917, 86048, 92183, 106655)

	-- ----------------------------------------------------------------------------
	-- The Burning Crusade.
	-- ----------------------------------------------------------------------------
	-- Fel Iron Plate Gloves -- 29545
	recipe = AddRecipe(29545, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(23482, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(1241, 16583, 16823, 19341, 20124, 20125, 29924, 33609, 33631, 33675, 92264, 92265)

	-- Fel Iron Plate Belt -- 29547
	recipe = AddRecipe(29547, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(5, 5, 15, 20, 25)
	recipe:SetCraftedItem(23484, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(1241, 16583, 16823, 19341, 20124, 20125, 29924, 33609, 33631, 33675, 92264, 92265)

	-- Fel Iron Plate Boots -- 29548
	recipe = AddRecipe(29548, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(15, 15, 25, 30, 35)
	recipe:SetCraftedItem(23487, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(1241, 16583, 16823, 19341, 20124, 20125, 29924, 33609, 33631, 33675, 92264, 92265)

	-- Fel Iron Plate Pants -- 29549
	recipe = AddRecipe(29549, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(15, 15, 25, 30, 35)
	recipe:SetCraftedItem(23488, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(1241, 16583, 16823, 19341, 20124, 20125, 29924, 33609, 33631, 33675, 92264, 92265)

	-- Fel Iron Breastplate -- 29550
	recipe = AddRecipe(29550, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(23489, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(1241, 16583, 16823, 19341, 20124, 20125, 29924, 33609, 33631, 33675, 92264, 92265)

	-- Fel Iron Chain Coif -- 29551
	recipe = AddRecipe(29551, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(23493, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(1241, 16583, 16823, 19341, 20124, 20125, 29924, 33609, 33631, 33675, 92264, 92265)

	-- Fel Iron Chain Gloves -- 29552
	recipe = AddRecipe(29552, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(10, 10, 20, 25, 30)
	recipe:SetCraftedItem(23491, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(1241, 16583, 16823, 19341, 20124, 20125, 29924, 33609, 33631, 33675, 92264, 92265)

	-- Fel Iron Chain Bracers -- 29553
	recipe = AddRecipe(29553, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(15, 15, 25, 30, 35)
	recipe:SetCraftedItem(23494, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(1241, 16583, 16823, 19341, 20124, 20125, 29924, 33609, 33631, 33675, 92264, 92265)

	-- Fel Iron Chain Tunic -- 29556
	recipe = AddRecipe(29556, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(20, 20, 30, 35, 40)
	recipe:SetCraftedItem(23490, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(1241, 16583, 16823, 19341, 20124, 20125, 29924, 33609, 33631, 33675, 92264, 92265)

	-- Fel Iron Hatchet -- 29557
	recipe = AddRecipe(29557, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(10, 10, 20, 25, 30)
	recipe:SetCraftedItem(23497, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_AXE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(1241, 16583, 16823, 19341, 20124, 20125, 29924, 33609, 33631, 33675, 92264, 92265)

	-- Fel Iron Hammer -- 29558
	recipe = AddRecipe(29558, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(15, 15, 25, 30, 35)
	recipe:SetCraftedItem(23498, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_MACE")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(1241, 16583, 16823, 19341, 20124, 20125, 29924, 33609, 33631, 33675, 92264, 92265)

	-- Fel Iron Greatsword -- 29565
	recipe = AddRecipe(29565, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(20, 20, 30, 35, 40)
	recipe:SetCraftedItem(23499, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_SWORD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(1241, 16583, 16823, 19341, 20124, 20125, 29924, 33609, 33631, 33675, 92264, 92265)

	-- Adamantite Maul -- 29566
	recipe = AddRecipe(29566, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(325, 325, 335, 345, 355)
	recipe:SetRecipeItem(23590, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(23502, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_MACE")
	recipe:AddFilters(F.DPS)
	recipe:AddLimitedVendor(16670, 1, 16713, 1, 19662, 1)

	-- Adamantite Cleaver -- 29568
	recipe = AddRecipe(29568, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(330, 330, 340, 350, 360)
	recipe:SetRecipeItem(23591, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(23503, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_AXE")
	recipe:AddFilters(F.DPS)
	recipe:AddLimitedVendor(16670, 1, 16713, 1, 19662, 1)

	-- Adamantite Dagger -- 29569
	recipe = AddRecipe(29569, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(330, 330, 340, 350, 360)
	recipe:SetRecipeItem(23592, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(23504, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_DAGGER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddLimitedVendor(16670, 1, 16713, 1, 19662, 1)

	-- Adamantite Rapier -- 29571
	recipe = AddRecipe(29571, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(335, 335, 345, 355, 365)
	recipe:SetRecipeItem(23593, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(23505, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_SWORD")
	recipe:AddFilters(F.TANK)
	recipe:AddLimitedVendor(16670, 1, 16713, 1, 19662, 1)

	-- Adamantite Plate Bracers -- 29603
	recipe = AddRecipe(29603, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(335, 335, 345, 355, 365)
	recipe:SetRecipeItem(23594, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(23506, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.DPS)
	recipe:AddVendor(19694)
	recipe:AddLimitedVendor(19342, 1)

	-- Adamantite Plate Gloves -- 29605
	recipe = AddRecipe(29605, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(335, 335, 345, 355, 365)
	recipe:SetRecipeItem(23595, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(23508, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.DPS)
	recipe:AddVendor(19694)
	recipe:AddLimitedVendor(19342, 1)

	-- Adamantite Breastplate -- 29606
	recipe = AddRecipe(29606, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(340, 340, 350, 360, 370)
	recipe:SetRecipeItem(23596, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(23507, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.DPS)
	recipe:AddVendor(19694)
	recipe:AddLimitedVendor(19342, 1)

	-- Enchanted Adamantite Belt -- 29608
	recipe = AddRecipe(29608, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(355, 355, 365, 375, 385)
	recipe:SetRecipeItem(23597, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(23510, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddFilters(F.TANK)
	recipe:AddRepVendor(FAC.THE_SCRYERS, REP.FRIENDLY, 19331)

	-- Enchanted Adamantite Breastplate -- 29610
	recipe = AddRecipe(29610, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(360, 360, 370, 380, 390)
	recipe:SetRecipeItem(23599, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(23509, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.TANK)
	recipe:AddRepVendor(FAC.THE_SCRYERS, REP.REVERED, 19331)

	-- Enchanted Adamantite Boots -- 29611
	recipe = AddRecipe(29611, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(355, 355, 365, 375, 385)
	recipe:SetRecipeItem(23598, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(23511, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.TANK)
	recipe:AddRepVendor(FAC.THE_SCRYERS, REP.HONORED, 19331)

	-- Enchanted Adamantite Leggings -- 29613
	recipe = AddRecipe(29613, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(365, 365, 375, 385, 395)
	recipe:SetRecipeItem(23600, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(23512, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.TANK)
	recipe:AddRepVendor(FAC.THE_SCRYERS, REP.EXALTED, 19331)

	-- Flamebane Bracers -- 29614
	recipe = AddRecipe(29614, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(350, 350, 360, 370, 380)
	recipe:SetRecipeItem(23601, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(23515, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.TANK)
	recipe:AddRepVendor(FAC.THE_ALDOR, REP.FRIENDLY, 19321)

	-- Flamebane Helm -- 29615
	recipe = AddRecipe(29615, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(355, 355, 365, 375, 385)
	recipe:SetRecipeItem(23602, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(23516, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.TANK)
	recipe:AddRepVendor(FAC.THE_ALDOR, REP.EXALTED, 19321)

	-- Flamebane Gloves -- 29616
	recipe = AddRecipe(29616, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(360, 360, 370, 380, 390)
	recipe:SetRecipeItem(23603, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(23514, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.TANK)
	recipe:AddRepVendor(FAC.THE_ALDOR, REP.HONORED, 19321)

	-- Flamebane Breastplate -- 29617
	recipe = AddRecipe(29617, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(365, 365, 375, 385, 395)
	recipe:SetRecipeItem(23604, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(23513, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.TANK)
	recipe:AddRepVendor(FAC.THE_ALDOR, REP.REVERED, 19321)

	-- Felsteel Gloves -- 29619
	recipe = AddRecipe(29619, V.TBC, Q.RARE)
	recipe:SetSkillLevels(360, 360, 370, 380, 390)
	recipe:SetRecipeItem(23605, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(23517, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.DPS, F.TANK)
	recipe:AddMobDrop(18497)

	-- Felsteel Leggings -- 29620
	recipe = AddRecipe(29620, V.TBC, Q.RARE)
	recipe:SetSkillLevels(360, 360, 370, 380, 390)
	recipe:SetRecipeItem(23606, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(23518, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.DPS, F.TANK)
	recipe:AddMobDrop(20900)

	-- Felsteel Helm -- 29621
	recipe = AddRecipe(29621, V.TBC, Q.RARE)
	recipe:SetSkillLevels(365, 365, 375, 385, 395)
	recipe:SetRecipeItem(23607, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(23519, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.TANK)
	recipe:AddMobDrop(18830)

	-- Gauntlets of the Iron Tower -- 29622
	recipe = AddRecipe(29622, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(365, 365, 375, 385, 395)
	recipe:SetRecipeItem(23621, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(23532, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.DPS, F.TANK)
	recipe:AddWorldDrop(Z.OUTLAND)

	-- Khorium Belt -- 29628
	recipe = AddRecipe(29628, V.TBC, Q.RARE)
	recipe:SetSkillLevels(360, 360, 370, 380, 390)
	recipe:SetRecipeItem(23608, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(23524, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddMobDrop(18203)

	-- Khorium Pants -- 29629
	recipe = AddRecipe(29629, V.TBC, Q.RARE)
	recipe:SetSkillLevels(360, 360, 370, 380, 390)
	recipe:SetRecipeItem(23609, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(23523, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddMobDrop(20878)

	-- Khorium Boots -- 29630
	recipe = AddRecipe(29630, V.TBC, Q.RARE)
	recipe:SetSkillLevels(365, 365, 375, 385, 395)
	recipe:SetRecipeItem(23610, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(23525, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddMobDrop(18873)

	-- Ragesteel Gloves -- 29642
	recipe = AddRecipe(29642, V.TBC, Q.RARE)
	recipe:SetSkillLevels(365, 365, 375, 385, 395)
	recipe:SetRecipeItem(23611, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(23520, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddMobDrop(17136)

	-- Ragesteel Helm -- 29643
	recipe = AddRecipe(29643, V.TBC, Q.RARE)
	recipe:SetSkillLevels(365, 365, 375, 385, 395)
	recipe:SetRecipeItem(23612, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(23521, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddMobDrop(16952)

	-- Ragesteel Breastplate -- 29645
	recipe = AddRecipe(29645, V.TBC, Q.RARE)
	recipe:SetSkillLevels(370, 370, 380, 390, 400)
	recipe:SetRecipeItem(23613, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(23522, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddMobDrop(21454, 23305, 23324)

	-- Swiftsteel Gloves -- 29648
	recipe = AddRecipe(29648, V.TBC, Q.RARE)
	recipe:SetSkillLevels(370, 370, 380, 390, 400)
	recipe:SetRecipeItem(23615, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(23526, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddMobDrop(18314)

	-- Earthpeace Breastplate -- 29649
	recipe = AddRecipe(29649, V.TBC, Q.RARE)
	recipe:SetSkillLevels(370, 370, 380, 390, 400)
	recipe:SetRecipeItem(23617, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(23527, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddMobDrop(17975)

	-- Fel Sharpening Stone -- 29654
	recipe = AddRecipe(29654, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(23528, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(1241, 16583, 16823, 19341, 20124, 20125, 29924, 33609, 33631, 33675, 92264, 92265)

	-- Adamantite Sharpening Stone -- 29656
	recipe = AddRecipe(29656, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(350, 350, 350, 355, 360)
	recipe:SetRecipeItem(23618, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(23529, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddRepVendor(FAC.CENARION_EXPEDITION, REP.HONORED, 17904)

	-- Felsteel Shield Spike -- 29657
	recipe = AddRecipe(29657, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(360, 360, 370, 380, 390)
	recipe:SetRecipeItem(23619, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(23530, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ITEM_ENHANCEMENT")
	recipe:AddRepVendor(FAC.HONOR_HOLD, REP.EXALTED, 17657)
	recipe:AddRepVendor(FAC.THRALLMAR, REP.EXALTED, 17585)

	-- Felfury Gauntlets -- 29658
	recipe = AddRecipe(29658, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(365, 365, 375, 385, 395)
	recipe:SetRecipeItem(23620, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(23531, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.OUTLAND)

	-- Steelgrip Gauntlets -- 29662
	recipe = AddRecipe(29662, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(365, 365, 375, 385, 395)
	recipe:SetRecipeItem(23622, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(23533, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.OUTLAND)

	-- Storm Helm -- 29663
	recipe = AddRecipe(29663, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(365, 365, 375, 385, 395)
	recipe:SetRecipeItem(23623, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(23534, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.OUTLAND)

	-- Helm of the Stalwart Defender -- 29664
	recipe = AddRecipe(29664, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(365, 365, 375, 385, 395)
	recipe:SetRecipeItem(23624, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(23535, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.DPS, F.TANK)
	recipe:AddWorldDrop(Z.OUTLAND)

	-- Oathkeeper's Helm -- 29668
	recipe = AddRecipe(29668, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(365, 365, 375, 385, 395)
	recipe:SetRecipeItem(23625, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(23536, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.TANK)
	recipe:AddWorldDrop(Z.OUTLAND)

	-- Black Felsteel Bracers -- 29669
	recipe = AddRecipe(29669, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(365, 365, 375, 385, 395)
	recipe:SetRecipeItem(23626, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(23537, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.OUTLAND)

	-- Bracers of the Green Fortress -- 29671
	recipe = AddRecipe(29671, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(365, 365, 375, 385, 395)
	recipe:SetRecipeItem(23627, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(23538, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.TANK)
	recipe:AddWorldDrop(Z.OUTLAND)

	-- Blessed Bracers -- 29672
	recipe = AddRecipe(29672, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(365, 365, 375, 385, 395)
	recipe:SetRecipeItem(23628, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(23539, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.OUTLAND)

	-- Felsteel Longblade -- 29692
	recipe = AddRecipe(29692, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(365, 365, 375, 385, 395)
	recipe:SetRecipeItem(23629, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(23540, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_SWORD")
	recipe:AddFilters(F.DPS)
	recipe:AddWorldDrop(Z.OUTLAND)

	-- Khorium Champion -- 29693
	recipe = AddRecipe(29693, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(365, 365, 375, 385, 395)
	recipe:SetRecipeItem(23630, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(23541, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_SWORD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.OUTLAND)

	-- Fel Edged Battleaxe -- 29694
	recipe = AddRecipe(29694, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(365, 365, 375, 385, 395)
	recipe:SetRecipeItem(23631, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(23542, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_AXE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.OUTLAND)

	-- Felsteel Reaper -- 29695
	recipe = AddRecipe(29695, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(365, 365, 375, 385, 395)
	recipe:SetRecipeItem(23632, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(23543, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_AXE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.OUTLAND)

	-- Runic Hammer -- 29696
	recipe = AddRecipe(29696, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(365, 365, 375, 385, 395)
	recipe:SetRecipeItem(23633, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(23544, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_MACE")
	recipe:AddFilters(F.DPS)
	recipe:AddWorldDrop(Z.OUTLAND)

	-- Fel Hardened Maul -- 29697
	recipe = AddRecipe(29697, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(365, 365, 375, 385, 395)
	recipe:SetRecipeItem(23634, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(23546, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_MACE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.OUTLAND)

	-- Eternium Runed Blade -- 29698
	recipe = AddRecipe(29698, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(365, 365, 375, 385, 395)
	recipe:SetRecipeItem(23635, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(23554, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_DAGGER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.OUTLAND)

	-- Dirge -- 29699
	recipe = AddRecipe(29699, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(365, 365, 375, 385, 395)
	recipe:SetRecipeItem(23636, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(23555, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_DAGGER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.OUTLAND)

	-- Hand of Eternity -- 29700
	recipe = AddRecipe(29700, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(365, 365, 375, 385, 395)
	recipe:SetRecipeItem(23637, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(23556, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_MACE")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddWorldDrop(Z.OUTLAND)

	-- Lesser Ward of Shielding -- 29728
	recipe = AddRecipe(29728, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(340, 340, 340, 345, 350)
	recipe:SetRecipeItem(23638, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(23575, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ITEM_ENHANCEMENT")
	recipe:AddVendor(19373)
	recipe:AddLimitedVendor(16583, 1)

	-- Greater Ward of Shielding -- 29729
	recipe = AddRecipe(29729, V.TBC, Q.RARE)
	recipe:SetSkillLevels(375, 375, 375, 375, 375)
	recipe:SetRecipeItem(23639, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(23576, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ITEM_ENHANCEMENT")
	recipe:AddMobDrop(18853)

	-- Lesser Rune of Warding -- 32284
	recipe = AddRecipe(32284, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(23559, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ITEM_ENHANCEMENT")
	recipe:AddTrainer(1241, 16583, 16823, 19341, 20124, 20125, 29924, 33609, 33631, 33675, 92264, 92265)

	-- Greater Rune of Warding -- 32285
	recipe = AddRecipe(32285, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(350, 350, 350, 355, 360)
	recipe:SetRecipeItem(25526, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(25521, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ITEM_ENHANCEMENT")
	recipe:AddRepVendor(FAC.CENARION_EXPEDITION, REP.HONORED, 17904)

	-- Nether Chain Shirt -- 34529
	recipe = AddRecipe(34529, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(350, 350, 360, 370, 380)
	recipe:SetCraftedItem(23563, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:Retire()

	-- Twisting Nether Chain Shirt -- 34530
	recipe = AddRecipe(34530, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 385, 395, 405)
	recipe:SetCraftedItem(23564, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:Retire()

	-- Breastplate of Kings -- 34533
	recipe = AddRecipe(34533, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(350, 350, 360, 370, 380)
	recipe:SetCraftedItem(28483, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:Retire()

	-- Bulwark of Kings -- 34534
	recipe = AddRecipe(34534, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 385, 395, 405)
	recipe:SetCraftedItem(28484, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:Retire()

	-- Fireguard -- 34535
	recipe = AddRecipe(34535, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(350, 350, 360, 370, 380)
	recipe:SetCraftedItem(28425, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_SWORD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:Retire()

	-- Blazeguard -- 34537
	recipe = AddRecipe(34537, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 385, 395, 405)
	recipe:SetCraftedItem(28426, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_SWORD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:Retire()

	-- Lionheart Blade -- 34538
	recipe = AddRecipe(34538, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(350, 350, 360, 370, 380)
	recipe:SetCraftedItem(28428, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_SWORD")
	recipe:AddFilters(F.DPS)
	recipe:Retire()

	-- Lionheart Champion -- 34540
	recipe = AddRecipe(34540, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 385, 395, 405)
	recipe:SetCraftedItem(28429, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_SWORD")
	recipe:AddFilters(F.DPS)
	recipe:Retire()

	-- The Planar Edge -- 34541
	recipe = AddRecipe(34541, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(350, 350, 360, 370, 380)
	recipe:SetCraftedItem(28431, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_AXE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:Retire()

	-- Black Planar Edge -- 34542
	recipe = AddRecipe(34542, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 385, 395, 405)
	recipe:SetCraftedItem(28432, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_AXE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:Retire()

	-- Lunar Crescent -- 34543
	recipe = AddRecipe(34543, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(350, 350, 360, 370, 380)
	recipe:SetCraftedItem(28434, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_AXE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:Retire()

	-- Mooncleaver -- 34544
	recipe = AddRecipe(34544, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 385, 395, 405)
	recipe:SetCraftedItem(28435, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_AXE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:Retire()

	-- Drakefist Hammer -- 34545
	recipe = AddRecipe(34545, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(350, 350, 360, 370, 380)
	recipe:SetCraftedItem(28437, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_MACE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:Retire()

	-- Dragonmaw -- 34546
	recipe = AddRecipe(34546, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 385, 395, 405)
	recipe:SetCraftedItem(28438, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_MACE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:Retire()

	-- Thunder -- 34547
	recipe = AddRecipe(34547, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(350, 350, 360, 370, 380)
	recipe:SetCraftedItem(28440, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_MACE")
	recipe:AddFilters(F.DPS)
	recipe:Retire()

	-- Deep Thunder -- 34548
	recipe = AddRecipe(34548, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 385, 395, 405)
	recipe:SetCraftedItem(28441, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_MACE")
	recipe:AddFilters(F.DPS)
	recipe:Retire()

	-- Fel Weightstone -- 34607
	recipe = AddRecipe(34607, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(28420, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(1241, 16583, 16823, 19341, 20124, 20125, 29924, 33609, 33631, 33675, 92264, 92265)

	-- Adamantite Weightstone -- 34608
	recipe = AddRecipe(34608, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(350, 350, 350, 355, 360)
	recipe:SetRecipeItem(28632, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(28421, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddRepVendor(FAC.CENARION_EXPEDITION, REP.HONORED, 17904)

	-- Earthforged Leggings -- 36122
	recipe = AddRecipe(36122, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(260, 260, 280, 290, 300)
	recipe:SetCraftedItem(30069, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:Retire()

	-- Windforged Leggings -- 36124
	recipe = AddRecipe(36124, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(260, 260, 280, 290, 300)
	recipe:SetCraftedItem(30070, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:Retire()

	-- Light Earthforged Blade -- 36125
	recipe = AddRecipe(36125, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(260, 260, 280, 290, 300)
	recipe:SetCraftedItem(30071, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_SWORD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.ZULFARRAK)

	-- Light Skyforged Axe -- 36126
	recipe = AddRecipe(36126, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(260, 260, 280, 290, 300)
	recipe:SetCraftedItem(30072, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_AXE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:Retire()

	-- Light Emberforged Hammer -- 36128
	recipe = AddRecipe(36128, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(260, 260, 280, 290, 300)
	recipe:SetCraftedItem(30073, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_MACE")
	recipe:AddFilters(F.DPS)
	recipe:Retire()

	-- Heavy Earthforged Breastplate -- 36129
	recipe = AddRecipe(36129, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(330, 330, 340, 350, 360)
	recipe:SetCraftedItem(30074, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.TANK)
	recipe:Retire()

	-- Stormforged Hauberk -- 36130
	recipe = AddRecipe(36130, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(330, 330, 340, 350, 360)
	recipe:SetCraftedItem(30076, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:Retire()

	-- Windforged Rapier -- 36131
	recipe = AddRecipe(36131, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(330, 330, 340, 350, 360)
	recipe:SetRecipeItem(142279, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(30077, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_SWORD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddQuest(44863)

	-- Stoneforged Claymore -- 36133
	recipe = AddRecipe(36133, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(330, 330, 340, 350, 360)
	recipe:SetRecipeItem(142284, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(30086, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_SWORD")
	recipe:AddFilters(F.DPS)
	recipe:AddQuest(41160)

	-- Stormforged Axe -- 36134
	recipe = AddRecipe(36134, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(330, 330, 340, 350, 360)
	recipe:SetRecipeItem(142282, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(30087, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_AXE")
	recipe:AddFilters(F.DPS)
	recipe:AddQuest(44863)

	-- Skyforged Great Axe -- 36135
	recipe = AddRecipe(36135, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(330, 330, 340, 350, 360)
	recipe:SetRecipeItem(142283, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(30088, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_AXE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddQuest(44863)

	-- Lavaforged Warhammer -- 36136
	recipe = AddRecipe(36136, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(330, 330, 340, 350, 360)
	recipe:SetRecipeItem(142286, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(30089, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_MACE")
	recipe:AddFilters(F.DPS)
	recipe:AddQuest(41160)

	-- Great Earthforged Hammer -- 36137
	recipe = AddRecipe(36137, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(330, 330, 340, 350, 360)
	recipe:SetRecipeItem(142287, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(30093, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_MACE")
	recipe:AddFilters(F.DPS)
	recipe:AddQuest(41160)

	-- Embrace of the Twisting Nether -- 36256
	recipe = AddRecipe(36256, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 385, 395, 405)
	recipe:SetCraftedItem(23565, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:Retire()

	-- Bulwark of the Ancient Kings -- 36257
	recipe = AddRecipe(36257, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 385, 395, 405)
	recipe:SetCraftedItem(28485, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:Retire()

	-- Blazefury -- 36258
	recipe = AddRecipe(36258, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 385, 395, 405)
	recipe:SetCraftedItem(28427, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_SWORD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:Retire()

	-- Lionheart Executioner -- 36259
	recipe = AddRecipe(36259, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 385, 395, 405)
	recipe:SetCraftedItem(28430, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_SWORD")
	recipe:AddFilters(F.DPS)
	recipe:Retire()

	-- Wicked Edge of the Planes -- 36260
	recipe = AddRecipe(36260, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 385, 395, 405)
	recipe:SetCraftedItem(28433, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_AXE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:Retire()

	-- Bloodmoon -- 36261
	recipe = AddRecipe(36261, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 385, 395, 405)
	recipe:SetCraftedItem(28436, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_AXE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:Retire()

	-- Dragonstrike -- 36262
	recipe = AddRecipe(36262, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 385, 395, 405)
	recipe:SetCraftedItem(28439, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_MACE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:Retire()

	-- Stormherald -- 36263
	recipe = AddRecipe(36263, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 385, 395, 405)
	recipe:SetCraftedItem(28442, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_MACE")
	recipe:AddFilters(F.DPS)
	recipe:Retire()

	-- Belt of the Guardian -- 36389
	recipe = AddRecipe(36389, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(375, 375, 385, 395, 405)
	recipe:SetRecipeItem(30321, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(30034, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddFilters(F.DPS, F.TANK)
	recipe:AddWorldDrop(Z.SERPENTSHRINE_CAVERN, Z.TEMPEST_KEEP)

	-- Red Belt of Battle -- 36390
	recipe = AddRecipe(36390, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(375, 375, 385, 395, 405)
	recipe:SetRecipeItem(30322, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(30032, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.SERPENTSHRINE_CAVERN, Z.TEMPEST_KEEP)

	-- Boots of the Protector -- 36391
	recipe = AddRecipe(36391, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(375, 375, 385, 395, 405)
	recipe:SetRecipeItem(30323, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(30033, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.DPS, F.TANK)
	recipe:AddWorldDrop(Z.SERPENTSHRINE_CAVERN, Z.TEMPEST_KEEP)

	-- Red Havoc Boots -- 36392
	recipe = AddRecipe(36392, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(375, 375, 385, 395, 405)
	recipe:SetRecipeItem(30324, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(30031, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.TANK)
	recipe:AddWorldDrop(Z.SERPENTSHRINE_CAVERN, Z.TEMPEST_KEEP)

	-- Wildguard Breastplate -- 38473
	recipe = AddRecipe(38473, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(375, 375, 385, 395, 405)
	recipe:SetRecipeItem(31390, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(31364, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.TANK)
	recipe:AddRepVendor(FAC.CENARION_EXPEDITION, REP.EXALTED, 17904)

	-- Wildguard Leggings -- 38475
	recipe = AddRecipe(38475, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(375, 375, 385, 395, 405)
	recipe:SetRecipeItem(31391, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(31367, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddRepVendor(FAC.CENARION_EXPEDITION, REP.REVERED, 17904)

	-- Wildguard Helm -- 38476
	recipe = AddRecipe(38476, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(375, 375, 385, 395, 405)
	recipe:SetRecipeItem(31392, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(31368, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.TANK)
	recipe:AddRepVendor(FAC.CENARION_EXPEDITION, REP.REVERED, 17904)

	-- Iceguard Breastplate -- 38477
	recipe = AddRecipe(38477, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(375, 375, 385, 395, 405)
	recipe:SetRecipeItem(31393, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(31369, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.TANK)
	recipe:AddRepVendor(FAC.THE_VIOLET_EYE, REP.HONORED, 16388)

	-- Iceguard Leggings -- 38478
	recipe = AddRecipe(38478, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(375, 375, 385, 395, 405)
	recipe:SetRecipeItem(31394, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(31370, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddRepVendor(FAC.THE_VIOLET_EYE, REP.REVERED, 16388)

	-- Iceguard Helm -- 38479
	recipe = AddRecipe(38479, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(375, 375, 385, 395, 405)
	recipe:SetRecipeItem(31395, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(31371, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.TANK)
	recipe:AddRepVendor(FAC.THE_VIOLET_EYE, REP.HONORED, 16388)

	-- Shadesteel Sabots -- 40033
	recipe = AddRecipe(40033, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 385, 395, 405)
	recipe:SetRecipeItem(32441, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(32402, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddRepVendor(FAC.ASHTONGUE_DEATHSWORN, REP.HONORED, 23159)

	-- Shadesteel Bracers -- 40034
	recipe = AddRecipe(40034, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 385, 395, 405)
	recipe:SetRecipeItem(32442, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(32403, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddRepVendor(FAC.ASHTONGUE_DEATHSWORN, REP.FRIENDLY, 23159)

	-- Shadesteel Greaves -- 40035
	recipe = AddRecipe(40035, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 385, 395, 405)
	recipe:SetRecipeItem(32443, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(32404, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddRepVendor(FAC.ASHTONGUE_DEATHSWORN, REP.HONORED, 23159)

	-- Shadesteel Girdle -- 40036
	recipe = AddRecipe(40036, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 385, 395, 405)
	recipe:SetRecipeItem(32444, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(32401, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddRepVendor(FAC.ASHTONGUE_DEATHSWORN, REP.FRIENDLY, 23159)

	-- Swiftsteel Bracers -- 41132
	recipe = AddRecipe(41132, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(375, 375, 385, 395, 405)
	recipe:SetRecipeItem(32736, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(32568, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.MOUNT_HYJAL)

	-- Swiftsteel Shoulders -- 41133
	recipe = AddRecipe(41133, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(375, 375, 385, 395, 405)
	recipe:SetRecipeItem(32737, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(32570, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.BLACK_TEMPLE)

	-- Dawnsteel Bracers -- 41134
	recipe = AddRecipe(41134, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(375, 375, 385, 395, 405)
	recipe:SetRecipeItem(32738, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(32571, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.BLACK_TEMPLE)

	-- Dawnsteel Shoulders -- 41135
	recipe = AddRecipe(41135, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(375, 375, 385, 395, 405)
	recipe:SetRecipeItem(32739, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(32573, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.MOUNT_HYJAL)

	-- Ragesteel Shoulders -- 42662
	recipe = AddRecipe(42662, V.TBC, Q.RARE)
	recipe:SetSkillLevels(365, 365, 375, 385, 395)
	recipe:SetRecipeItem(33174, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(33173, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddMobDrop(21050, 21059, 21060, 21061)

	-- Adamantite Weapon Chain -- 42688
	recipe = AddRecipe(42688, V.TBC, Q.UNCOMMON)
	recipe:SetSkillLevels(335, 335, 345, 350, 355)
	recipe:SetRecipeItem(35296, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(33185, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.TANK)
	recipe:AddMobDrop(24664)

	-- Heavy Copper Longsword -- 43549
	recipe = AddRecipe(43549, V.TBC, Q.UNCOMMON)
	recipe:SetSkillLevels(35, 35, 75, 95, 115)
	recipe:SetRecipeItem(33792, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(33791, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_SWORD")
	recipe:AddFilters(F.DPS)
	recipe:AddQuest(1578)

	-- Hammer of Righteous Might -- 43846
	recipe = AddRecipe(43846, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(365, 365, 375, 385, 395)
	recipe:SetRecipeItem(33954, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(32854, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_MACE")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddWorldDrop(Z.OUTLAND)

	-- Sunblessed Gauntlets -- 46140
	recipe = AddRecipe(46140, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(365, 365, 375, 392, 410)
	recipe:SetRecipeItem(35208, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(34380, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.SUNWELL_PLATEAU)

	-- Hard Khorium Battlefists -- 46141
	recipe = AddRecipe(46141, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(365, 365, 375, 392, 410)
	recipe:SetRecipeItem(35209, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(34378, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.SUNWELL_PLATEAU)

	-- Sunblessed Breastplate -- 46142
	recipe = AddRecipe(46142, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(365, 365, 375, 392, 410)
	recipe:SetRecipeItem(35210, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(34379, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.SUNWELL_PLATEAU)

	-- Hard Khorium Battleplate -- 46144
	recipe = AddRecipe(46144, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(365, 365, 375, 392, 410)
	recipe:SetRecipeItem(35211, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(34377, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.SUNWELL_PLATEAU)

	-- Relic of the Past I -- 330144
	recipe = AddRecipe(330144, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(180055, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_MATERIALS")
	recipe:AddTrainer(20124, 20125, 33609, 33631, 33675)

	-- Relic of the Past II -- 330145
	recipe = AddRecipe(330145, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(180057, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_MATERIALS")
	recipe:AddTrainer(20124, 20125, 33609, 33631, 33675)

	-- Relic of the Past III -- 330146
	recipe = AddRecipe(330146, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(180058, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_MATERIALS")
	recipe:AddTrainer(20124, 20125, 33609, 33631, 33675)

	-- Relic of the Past IV -- 330147
	recipe = AddRecipe(330147, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(180059, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_MATERIALS")
	recipe:AddTrainer(20124, 20125, 33609, 33631, 33675)

	-- Relic of the Past V -- 330148
	recipe = AddRecipe(330148, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(180060, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_MATERIALS")
	recipe:AddTrainer(20124, 20125, 33609, 33631, 33675)

	-- ----------------------------------------------------------------------------
	-- Wrath of the Lich King.
	-- ----------------------------------------------------------------------------
	-- Cobalt Legplates -- 52567
	recipe = AddRecipe(52567, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(39086, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.DPS, F.TANK)
	recipe:AddTrainer(16823, 19341, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 92264, 92265)

	-- Cobalt Belt -- 52568
	recipe = AddRecipe(52568, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(39087, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddFilters(F.DPS, F.TANK)
	recipe:AddTrainer(16823, 19341, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 92264, 92265)

	-- Cobalt Boots -- 52569
	recipe = AddRecipe(52569, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(39088, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.DPS, F.TANK)
	recipe:AddTrainer(16823, 19341, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 92264, 92265)

	-- Cobalt Chestpiece -- 52570
	recipe = AddRecipe(52570, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(39085, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.DPS, F.TANK)
	recipe:AddTrainer(1241, 16823, 19341, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 92264, 92265)

	-- Cobalt Helm -- 52571
	recipe = AddRecipe(52571, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(39084, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.DPS, F.TANK)
	recipe:AddTrainer(16823, 19341, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 92264, 92265)

	-- Cobalt Shoulders -- 52572
	recipe = AddRecipe(52572, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(39083, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHOULDER")
	recipe:AddFilters(F.DPS, F.TANK)
	recipe:AddTrainer(1241, 16823, 19341, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 92264, 92265)

	-- Cobalt Triangle Shield -- 54550
	recipe = AddRecipe(54550, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(40668, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHIELD")
	recipe:AddFilters(F.DPS, F.TANK)
	recipe:AddTrainer(1241, 16823, 19341, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 92264, 92265)

	-- Tempered Saronite Belt -- 54551
	recipe = AddRecipe(54551, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(20, 20, 30, 35, 40)
	recipe:SetCraftedItem(40669, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddFilters(F.DPS, F.TANK)
	recipe:AddTrainer(1241, 16823, 19341, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 92264, 92265)

	-- Tempered Saronite Boots -- 54552
	recipe = AddRecipe(54552, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(40671, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.DPS, F.TANK)
	recipe:AddTrainer(1241, 16823, 19341, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 92264, 92265)

	-- Tempered Saronite Breastplate -- 54553
	recipe = AddRecipe(54553, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(40672, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.DPS, F.TANK)
	recipe:AddTrainer(1241, 16823, 19341, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 92264, 92265)

	-- Tempered Saronite Legplates -- 54554
	recipe = AddRecipe(54554, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(20, 20, 30, 35, 40)
	recipe:SetCraftedItem(40674, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.DPS, F.TANK)
	recipe:AddTrainer(1241, 16823, 19341, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 92264, 92265)

	-- Tempered Saronite Helm -- 54555
	recipe = AddRecipe(54555, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(30, 30, 40, 45, 50)
	recipe:SetCraftedItem(40673, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.DPS, F.TANK)
	recipe:AddTrainer(1241, 16823, 19341, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 92264, 92265)

	-- Tempered Saronite Shoulders -- 54556
	recipe = AddRecipe(54556, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(30, 30, 40, 45, 50)
	recipe:SetCraftedItem(40675, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHOULDER")
	recipe:AddFilters(F.DPS, F.TANK)
	recipe:AddTrainer(1241, 16823, 19341, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 92264, 92265)

	-- Saronite Defender -- 54557
	recipe = AddRecipe(54557, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(15, 15, 25, 30, 35)
	recipe:SetCraftedItem(40670, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHIELD")
	recipe:AddFilters(F.DPS, F.TANK)
	recipe:AddTrainer(1241, 16823, 19341, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 92264, 92265)

	-- Spiked Cobalt Helm -- 54917
	recipe = AddRecipe(54917, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(40942, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(1241, 16823, 19341, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 92264, 92265)

	-- Spiked Cobalt Boots -- 54918
	recipe = AddRecipe(54918, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(5, 5, 15, 20, 25)
	recipe:SetCraftedItem(40949, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(1241, 16823, 19341, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 92264, 92265)

	-- Spiked Cobalt Shoulders -- 54941
	recipe = AddRecipe(54941, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(10, 10, 20, 25, 30)
	recipe:SetCraftedItem(40950, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(1241, 16823, 19341, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 92264, 92265)

	-- Spiked Cobalt Chestpiece -- 54944
	recipe = AddRecipe(54944, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(10, 10, 20, 25, 30)
	recipe:SetCraftedItem(40951, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(1241, 16823, 19341, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 92264, 92265)

	-- Spiked Cobalt Gauntlets -- 54945
	recipe = AddRecipe(54945, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(15, 15, 25, 30, 35)
	recipe:SetCraftedItem(40952, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(1241, 16823, 19341, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 92264, 92265)

	-- Spiked Cobalt Belt -- 54946
	recipe = AddRecipe(54946, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(20, 20, 30, 35, 40)
	recipe:SetCraftedItem(40953, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(1241, 16823, 19341, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 92264, 92265)

	-- Spiked Cobalt Legplates -- 54947
	recipe = AddRecipe(54947, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(20, 20, 30, 35, 40)
	recipe:SetCraftedItem(40943, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(1241, 16823, 19341, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 92264, 92265)

	-- Spiked Cobalt Bracers -- 54948
	recipe = AddRecipe(54948, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(40954, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(1241, 16823, 19341, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 92264, 92265)

	-- Horned Cobalt Helm -- 54949
	recipe = AddRecipe(54949, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(40955, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(1241, 16823, 19341, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 92264, 92265)

	-- Reinforced Cobalt Shoulders -- 54978
	recipe = AddRecipe(54978, V.WOTLK, Q.UNCOMMON)
	recipe:SetSkillLevels(375, 375, 395, 400, 405)
	recipe:SetRecipeItem(41124, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(40956, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddMobDrop(27333)

	-- Reinforced Cobalt Helm -- 54979
	recipe = AddRecipe(54979, V.WOTLK, Q.UNCOMMON)
	recipe:SetSkillLevels(375, 375, 405, 410, 415)
	recipe:SetRecipeItem(41123, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(40957, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddMobDrop(26270)

	-- Reinforced Cobalt Legplates -- 54980
	recipe = AddRecipe(54980, V.WOTLK, Q.UNCOMMON)
	recipe:SetSkillLevels(375, 375, 410, 415, 420)
	recipe:SetRecipeItem(41120, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(40958, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddMobDrop(29235)

	-- Reinforced Cobalt Chestpiece -- 54981
	recipe = AddRecipe(54981, V.WOTLK, Q.UNCOMMON)
	recipe:SetSkillLevels(375, 375, 415, 420, 425)
	recipe:SetRecipeItem(41122, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(40959, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddMobDrop(28123)

	-- Saronite Protector -- 55013
	recipe = AddRecipe(55013, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(15, 15, 25, 30, 35)
	recipe:SetCraftedItem(41117, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHIELD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(1241, 16823, 19341, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 92264, 92265)

	-- Saronite Bulwark -- 55014
	recipe = AddRecipe(55014, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(35, 35, 45, 50, 55)
	recipe:SetCraftedItem(41113, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHIELD")
	recipe:AddFilters(F.DPS, F.TANK)
	recipe:AddTrainer(1241, 16823, 19341, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 92264, 92265)

	-- Tempered Saronite Gauntlets -- 55015
	recipe = AddRecipe(55015, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(40, 40, 50, 55, 60)
	recipe:SetCraftedItem(41114, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.DPS, F.TANK)
	recipe:AddTrainer(1241, 16823, 19341, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 92264, 92265)

	-- Tempered Saronite Bracers -- 55017
	recipe = AddRecipe(55017, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(35, 35, 45, 50, 55)
	recipe:SetCraftedItem(41116, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.DPS, F.TANK)
	recipe:AddTrainer(1241, 16823, 19341, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 92264, 92265)

	-- Brilliant Saronite Legplates -- 55055
	recipe = AddRecipe(55055, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(20, 20, 30, 35, 40)
	recipe:SetCraftedItem(41126, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(1241, 16823, 19341, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 92264, 92265)

	-- Brilliant Saronite Gauntlets -- 55056
	recipe = AddRecipe(55056, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(41127, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(1241, 16823, 19341, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 92264, 92265)

	-- Brilliant Saronite Boots -- 55057
	recipe = AddRecipe(55057, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(30, 30, 40, 45, 50)
	recipe:SetCraftedItem(41128, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(1241, 16823, 19341, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 92264, 92265)

	-- Brilliant Saronite Breastplate -- 55058
	recipe = AddRecipe(55058, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(40, 40, 50, 55, 60)
	recipe:SetCraftedItem(41129, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(1241, 16823, 19341, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 92264, 92265)

	-- Honed Cobalt Cleaver -- 55174
	recipe = AddRecipe(55174, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(15, 15, 25, 30, 35)
	recipe:SetCraftedItem(41181, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_AXE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(1241, 16823, 19341, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 92264, 92265)

	-- Savage Cobalt Slicer -- 55177
	recipe = AddRecipe(55177, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(20, 20, 30, 35, 40)
	recipe:SetCraftedItem(41182, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_SWORD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(1241, 16823, 19341, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 92264, 92265)

	-- Saronite Ambusher -- 55179
	recipe = AddRecipe(55179, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(41183, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_DAGGER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(1241, 16823, 19341, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 92264, 92265)

	-- Saronite Shiv -- 55181
	recipe = AddRecipe(55181, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(30, 30, 40, 45, 50)
	recipe:SetCraftedItem(41184, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_DAGGER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(1241, 16823, 19341, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 92264, 92265)

	-- Furious Saronite Beatstick -- 55182
	recipe = AddRecipe(55182, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(35, 35, 45, 50, 55)
	recipe:SetCraftedItem(41185, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_MACE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(1241, 16823, 19341, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 92264, 92265)

	-- Corroded Saronite Edge -- 55183
	recipe = AddRecipe(55183, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(415, 415, 420, 425, 430)
	recipe:SetCraftedItem(41186, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_SWORD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:Retire()

	-- Corroded Saronite Woundbringer -- 55184
	recipe = AddRecipe(55184, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(415, 415, 420, 425, 430)
	recipe:SetCraftedItem(41187, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_SWORD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:Retire()

	-- Saronite Mindcrusher -- 55185
	recipe = AddRecipe(55185, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(40, 40, 50, 55, 60)
	recipe:SetCraftedItem(41188, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_MACE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(1241, 16823, 19341, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 33591, 92264, 92265)

	-- Chestplate of Conquest -- 55186
	recipe = AddRecipe(55186, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(415, 415, 420, 425, 430)
	recipe:SetCraftedItem(41189, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:Retire()

	-- Legplates of Conquest -- 55187
	recipe = AddRecipe(55187, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(415, 415, 420, 425, 430)
	recipe:SetCraftedItem(41190, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:Retire()

	-- Sturdy Cobalt Quickblade -- 55200
	recipe = AddRecipe(55200, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(5, 5, 15, 20, 25)
	recipe:SetCraftedItem(41239, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_SWORD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(1241, 16823, 19341, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 92264, 92265)

	-- Cobalt Tenderizer -- 55201
	recipe = AddRecipe(55201, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(5, 5, 15, 20, 25)
	recipe:SetCraftedItem(41240, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_MACE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(1241, 16823, 19341, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 92264, 92265)

	-- Forged Cobalt Claymore -- 55203
	recipe = AddRecipe(55203, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(10, 10, 20, 25, 30)
	recipe:SetCraftedItem(41242, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_SWORD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(1241, 16823, 19341, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 92264, 92265)

	-- Notched Cobalt War Axe -- 55204
	recipe = AddRecipe(55204, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(15, 15, 25, 30, 35)
	recipe:SetCraftedItem(41243, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_AXE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(1241, 16823, 19341, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 92264, 92265)

	-- Deadly Saronite Dirk -- 55206
	recipe = AddRecipe(55206, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(3, 3, 13, 18, 23)
	recipe:SetCraftedItem(41245, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_THROWN")
	recipe:AddTrainer(1241, 16823, 19341, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 92264, 92265)

	-- Vengeance Bindings -- 55298
	recipe = AddRecipe(55298, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(45, 45, 55, 60, 65)
	recipe:SetCraftedItem(41355, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(1241, 16823, 19341, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 92264, 92265)

	-- Righteous Gauntlets -- 55300
	recipe = AddRecipe(55300, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(45, 45, 55, 60, 65)
	recipe:SetCraftedItem(41356, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(1241, 16823, 19341, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 92264, 92265)

	-- Daunting Handguards -- 55301
	recipe = AddRecipe(55301, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(45, 45, 55, 60, 65)
	recipe:SetCraftedItem(41357, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.DPS, F.TANK)
	recipe:AddTrainer(1241, 16823, 19341, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 92264, 92265)

	-- Helm of Command -- 55302
	recipe = AddRecipe(55302, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(41344, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(1241, 16823, 19341, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 92264, 92265)

	-- Daunting Legplates -- 55303
	recipe = AddRecipe(55303, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(41345, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.DPS, F.TANK)
	recipe:AddTrainer(1241, 16823, 19341, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 92264, 92265)

	-- Righteous Greaves -- 55304
	recipe = AddRecipe(55304, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(41346, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(1241, 16823, 19341, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 92264, 92265)

	-- Savage Saronite Bracers -- 55305
	recipe = AddRecipe(55305, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(45, 45, 55, 60, 65)
	recipe:SetCraftedItem(41354, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(1241, 16823, 19341, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 92264, 92265)

	-- Savage Saronite Pauldrons -- 55306
	recipe = AddRecipe(55306, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(45, 45, 55, 60, 65)
	recipe:SetCraftedItem(41351, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(1241, 16823, 19341, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 92264, 92265)

	-- Savage Saronite Waistguard -- 55307
	recipe = AddRecipe(55307, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(65, 65, 75, 80, 85)
	recipe:SetCraftedItem(41352, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(1241, 16823, 19341, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 92264, 92265)

	-- Savage Saronite Walkers -- 55308
	recipe = AddRecipe(55308, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(45, 45, 55, 60, 65)
	recipe:SetCraftedItem(41348, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(1241, 16823, 19341, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 92264, 92265)

	-- Savage Saronite Gauntlets -- 55309
	recipe = AddRecipe(55309, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(45, 45, 55, 60, 65)
	recipe:SetCraftedItem(41349, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(1241, 16823, 19341, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 92264, 92265)

	-- Savage Saronite Legplates -- 55310
	recipe = AddRecipe(55310, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(41347, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(1241, 16823, 19341, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 92264, 92265)

	-- Savage Saronite Hauberk -- 55311
	recipe = AddRecipe(55311, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(41353, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(1241, 16823, 19341, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 92264, 92265)

	-- Savage Saronite Skullshield -- 55312
	recipe = AddRecipe(55312, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(41350, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(1241, 16823, 19341, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 92264, 92265)

	-- Titansteel Destroyer -- 55369
	recipe = AddRecipe(55369, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(65, 65, 75, 80, 85)
	recipe:SetCraftedItem(41257, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_MACE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(1241, 16823, 19341, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 92264, 92265)

	-- Titansteel Bonecrusher -- 55370
	recipe = AddRecipe(55370, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(65, 65, 75, 80, 85)
	recipe:SetCraftedItem(41383, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_MACE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(1241, 16823, 19341, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 92264, 92265)

	-- Titansteel Guardian -- 55371
	recipe = AddRecipe(55371, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(65, 65, 75, 80, 85)
	recipe:SetCraftedItem(41384, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_MACE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(1241, 16823, 19341, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 92264, 92265)

	-- Spiked Titansteel Helm -- 55372
	recipe = AddRecipe(55372, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(65, 65, 75, 80, 85)
	recipe:SetCraftedItem(41386, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(1241, 16823, 19341, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 92264, 92265)

	-- Tempered Titansteel Helm -- 55373
	recipe = AddRecipe(55373, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(65, 65, 75, 80, 85)
	recipe:SetCraftedItem(41387, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.DPS, F.TANK)
	recipe:AddTrainer(1241, 16823, 19341, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 92264, 92265)

	-- Brilliant Titansteel Helm -- 55374
	recipe = AddRecipe(55374, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(65, 65, 75, 80, 85)
	recipe:SetCraftedItem(41388, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(1241, 16823, 19341, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 92264, 92265)

	-- Spiked Titansteel Treads -- 55375
	recipe = AddRecipe(55375, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(65, 65, 75, 80, 85)
	recipe:SetCraftedItem(41391, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(1241, 16823, 19341, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 92264, 92265)

	-- Tempered Titansteel Treads -- 55376
	recipe = AddRecipe(55376, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(65, 65, 75, 80, 85)
	recipe:SetCraftedItem(41392, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.DPS, F.TANK)
	recipe:AddTrainer(1241, 16823, 19341, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 92264, 92265)

	-- Brilliant Titansteel Treads -- 55377
	recipe = AddRecipe(55377, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(65, 65, 75, 80, 85)
	recipe:SetCraftedItem(41394, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(1241, 16823, 19341, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 92264, 92265)

	-- Eternal Belt Buckle -- 55656
	recipe = AddRecipe(55656, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(40, 40, 50, 55, 60)
	recipe:SetCraftedItem(41611, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ITEM_ENHANCEMENT")
	recipe:AddTrainer(1241, 16823, 19341, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 92264, 92265)

	-- Cobalt Bracers -- 55834
	recipe = AddRecipe(55834, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(41974, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.DPS, F.TANK)
	recipe:AddTrainer(1241, 16823, 19341, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 92264, 92265)

	-- Cobalt Gauntlets -- 55835
	recipe = AddRecipe(55835, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(41975, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.DPS, F.TANK)
	recipe:AddTrainer(1241, 16823, 19341, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 92264, 92265)

	-- Titanium Weapon Chain -- 55839
	recipe = AddRecipe(55839, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(45, 45, 55, 60, 65)
	recipe:SetCraftedItem(41976, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(1241, 16823, 19341, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 92264, 92265)

	-- Titansteel Shanker -- 56234
	recipe = AddRecipe(56234, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(65, 65, 75, 80, 85)
	recipe:SetCraftedItem(42435, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_DAGGER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(1241, 16823, 19341, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 92264, 92265)

	-- Cudgel of Saronite Justice -- 56280
	recipe = AddRecipe(56280, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(35, 35, 45, 50, 55)
	recipe:SetCraftedItem(42443, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_MACE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(1241, 16823, 19341, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 92264, 92265)

	-- Titanium Shield Spike -- 56357
	recipe = AddRecipe(56357, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(45, 45, 55, 60, 65)
	recipe:SetCraftedItem(42500, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ITEM_ENHANCEMENT")
	recipe:AddTrainer(1241, 16823, 19341, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 92264, 92265)

	-- Titansteel Shield Wall -- 56400
	recipe = AddRecipe(56400, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(65, 65, 75, 80, 85)
	recipe:SetCraftedItem(42508, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHIELD")
	recipe:AddFilters(F.DPS, F.TANK)
	recipe:AddTrainer(1241, 16823, 19341, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 92264, 92265)

	-- Ornate Saronite Bracers -- 56549
	recipe = AddRecipe(56549, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(45, 45, 55, 60, 65)
	recipe:SetCraftedItem(42723, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(1241, 16823, 19341, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 92264, 92265)

	-- Ornate Saronite Pauldrons -- 56550
	recipe = AddRecipe(56550, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(45, 45, 55, 60, 65)
	recipe:SetCraftedItem(42727, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(1241, 16823, 19341, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 92264, 92265)

	-- Ornate Saronite Waistguard -- 56551
	recipe = AddRecipe(56551, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(45, 45, 55, 60, 65)
	recipe:SetCraftedItem(42729, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(1241, 16823, 19341, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 92264, 92265)

	-- Ornate Saronite Walkers -- 56552
	recipe = AddRecipe(56552, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(45, 45, 55, 60, 65)
	recipe:SetCraftedItem(42730, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(1241, 16823, 19341, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 92264, 92265)

	-- Ornate Saronite Gauntlets -- 56553
	recipe = AddRecipe(56553, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(45, 45, 55, 60, 65)
	recipe:SetCraftedItem(42724, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(1241, 16823, 19341, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 92264, 92265)

	-- Ornate Saronite Legplates -- 56554
	recipe = AddRecipe(56554, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(42726, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(1241, 16823, 19341, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 92264, 92265)

	-- Ornate Saronite Hauberk -- 56555
	recipe = AddRecipe(56555, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(42725, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(1241, 16823, 19341, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 92264, 92265)

	-- Ornate Saronite Skullshield -- 56556
	recipe = AddRecipe(56556, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(42728, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(1241, 16823, 19341, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 92264, 92265)

	-- Cobalt Skeleton Key -- 59405
	recipe = AddRecipe(59405, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(43854, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SKELETON_KEY")
	recipe:AddTrainer(1241, 16823, 19341, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 92264, 92265)

	-- Titanium Skeleton Key -- 59406
	recipe = AddRecipe(59406, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(55, 55, 65, 70, 75)
	recipe:SetCraftedItem(43853, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SKELETON_KEY")
	recipe:AddTrainer(1241, 16823, 19341, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 92264, 92265)

	-- Brilliant Saronite Belt -- 59436
	recipe = AddRecipe(59436, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(20, 20, 30, 35, 40)
	recipe:SetCraftedItem(43860, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(1241, 16823, 19341, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 92264, 92265)

	-- Brilliant Saronite Bracers -- 59438
	recipe = AddRecipe(59438, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(43864, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(1241, 16823, 19341, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 92264, 92265)

	-- Brilliant Saronite Pauldrons -- 59440
	recipe = AddRecipe(59440, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(30, 30, 40, 45, 50)
	recipe:SetCraftedItem(43865, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(1241, 16823, 19341, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 92264, 92265)

	-- Brilliant Saronite Helm -- 59441
	recipe = AddRecipe(59441, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(40, 40, 50, 55, 60)
	recipe:SetCraftedItem(43870, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(1241, 16823, 19341, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 92264, 92265)

	-- Saronite Spellblade -- 59442
	recipe = AddRecipe(59442, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(35, 35, 45, 50, 55)
	recipe:SetCraftedItem(43871, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_SWORD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(1241, 16823, 19341, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 92264, 92265)

	-- Icebane Chestguard -- 61008
	recipe = AddRecipe(61008, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(43586, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddTrainer(1241, 16823, 19341, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 92264, 92265)

	-- Icebane Girdle -- 61009
	recipe = AddRecipe(61009, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(45, 45, 55, 60, 65)
	recipe:SetCraftedItem(43587, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddTrainer(1241, 16823, 19341, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 92264, 92265)

	-- Icebane Treads -- 61010
	recipe = AddRecipe(61010, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(45, 45, 55, 60, 65)
	recipe:SetCraftedItem(43588, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddTrainer(1241, 16823, 19341, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 92264, 92265)

	-- Titanium Plating -- 62202
	recipe = AddRecipe(62202, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(450, 450, 455, 460, 465)
	recipe:SetRecipeItem(44937, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(44936, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_MATERIALS")
	recipe:AddFilters(F.TANK)
	recipe:AddRepVendor(FAC.HORDE_EXPEDITION, REP.EXALTED, 32565, 32774)
	recipe:AddRepVendor(FAC.ALLIANCE_VANGUARD, REP.EXALTED, 32564, 32773)

	-- Titansteel Spellblade -- 63182
	recipe = AddRecipe(63182, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(65, 65, 75, 80, 85)
	recipe:SetCraftedItem(45085, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_DAGGER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(1241, 16823, 19341, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 92264, 92265)

	-- Belt of the Titans -- 63187
	recipe = AddRecipe(63187, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(450, 450, 455, 465, 475)
	recipe:SetRecipeItem(45088, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(45088, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.ULDUAR)

	-- Battlelord's Plate Boots -- 63188
	recipe = AddRecipe(63188, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(450, 450, 455, 465, 475)
	recipe:SetRecipeItem(45089, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(45089, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.ULDUAR)

	-- Plate Girdle of Righteousness -- 63189
	recipe = AddRecipe(63189, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(450, 450, 455, 465, 475)
	recipe:SetRecipeItem(45090, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(45090, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.ULDUAR)

	-- Treads of Destiny -- 63190
	recipe = AddRecipe(63190, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(450, 450, 455, 465, 475)
	recipe:SetRecipeItem(45091, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(45091, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.ULDUAR)

	-- Indestructible Plate Girdle -- 63191
	recipe = AddRecipe(63191, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(450, 450, 455, 465, 475)
	recipe:SetRecipeItem(45092, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(45092, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddFilters(F.DPS, F.TANK)
	recipe:AddWorldDrop(Z.ULDUAR)

	-- Spiked Deathdealers -- 63192
	recipe = AddRecipe(63192, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(450, 450, 455, 465, 475)
	recipe:SetRecipeItem(45093, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(45093, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.DPS, F.TANK)
	recipe:AddWorldDrop(Z.ULDUAR)

	-- Breastplate of the White Knight -- 67091
	recipe = AddRecipe(67091, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(450, 450, 455, 465, 475)
	recipe:SetRecipeItem(47622, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(47591, "BIND_ON_EQUIP")
	recipe:SetRequiredFaction("Alliance")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.DPS, F.TANK)
	recipe:AddWorldDrop(Z.TRIAL_OF_THE_CRUSADER)
	recipe:AddCustom("NORMAL")

	-- Saronite Swordbreakers -- 67092
	recipe = AddRecipe(67092, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(450, 450, 455, 465, 475)
	recipe:SetRecipeItem(47623, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(47570, "BIND_ON_EQUIP")
	recipe:SetRequiredFaction("Alliance")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.TANK)
	recipe:AddWorldDrop(Z.TRIAL_OF_THE_CRUSADER)
	recipe:AddCustom("NORMAL")

	-- Titanium Razorplate -- 67093
	recipe = AddRecipe(67093, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(450, 450, 455, 465, 475)
	recipe:SetRecipeItem(47624, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(47589, "BIND_ON_EQUIP")
	recipe:SetRequiredFaction("Alliance")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.TRIAL_OF_THE_CRUSADER)
	recipe:AddCustom("NORMAL")

	-- Titanium Spikeguards -- 67094
	recipe = AddRecipe(67094, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(450, 450, 455, 465, 475)
	recipe:SetRecipeItem(47625, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(47572, "BIND_ON_EQUIP")
	recipe:SetRequiredFaction("Alliance")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.TRIAL_OF_THE_CRUSADER)
	recipe:AddCustom("NORMAL")

	-- Sunforged Breastplate -- 67095
	recipe = AddRecipe(67095, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(450, 450, 460, 467, 475)
	recipe:SetRecipeItem(47626, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(47593, "BIND_ON_EQUIP")
	recipe:SetRequiredFaction("Alliance")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.TRIAL_OF_THE_CRUSADER)
	recipe:AddCustom("NORMAL")

	-- Sunforged Bracers -- 67096
	recipe = AddRecipe(67096, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(450, 450, 455, 465, 475)
	recipe:SetRecipeItem(47627, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(47574, "BIND_ON_EQUIP")
	recipe:SetRequiredFaction("Alliance")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.TRIAL_OF_THE_CRUSADER)
	recipe:AddCustom("NORMAL")

	-- Breastplate of the White Knight -- 67130
	recipe = AddRecipe(67130, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(450, 450, 455, 465, 475)
	recipe:SetRecipeItem(47640, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(47592, "BIND_ON_EQUIP")
	recipe:SetRequiredFaction("Horde")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.DPS, F.TANK)
	recipe:AddWorldDrop(Z.TRIAL_OF_THE_CRUSADER)
	recipe:AddCustom("NORMAL")

	-- Saronite Swordbreakers -- 67131
	recipe = AddRecipe(67131, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(450, 450, 455, 465, 475)
	recipe:SetRecipeItem(47641, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(47571, "BIND_ON_EQUIP")
	recipe:SetRequiredFaction("Horde")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.TANK)
	recipe:AddWorldDrop(Z.TRIAL_OF_THE_CRUSADER)
	recipe:AddCustom("NORMAL")

	-- Titanium Razorplate -- 67132
	recipe = AddRecipe(67132, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(450, 450, 455, 465, 475)
	recipe:SetRecipeItem(47644, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(47590, "BIND_ON_EQUIP")
	recipe:SetRequiredFaction("Horde")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.TRIAL_OF_THE_CRUSADER)
	recipe:AddCustom("NORMAL")

	-- Titanium Spikeguards -- 67133
	recipe = AddRecipe(67133, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(450, 450, 455, 465, 475)
	recipe:SetRecipeItem(47645, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(47573, "BIND_ON_EQUIP")
	recipe:SetRequiredFaction("Horde")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.TRIAL_OF_THE_CRUSADER)
	recipe:AddCustom("NORMAL")

	-- Sunforged Breastplate -- 67134
	recipe = AddRecipe(67134, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(450, 450, 460, 467, 475)
	recipe:SetRecipeItem(47643, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(47594, "BIND_ON_EQUIP")
	recipe:SetRequiredFaction("Horde")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.TRIAL_OF_THE_CRUSADER)
	recipe:AddCustom("NORMAL")

	-- Sunforged Bracers -- 67135
	recipe = AddRecipe(67135, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(450, 450, 455, 465, 475)
	recipe:SetRecipeItem(47642, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(47575, "BIND_ON_EQUIP")
	recipe:SetRequiredFaction("Horde")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.TRIAL_OF_THE_CRUSADER)
	recipe:AddCustom("NORMAL")

	-- Puresteel Legplates -- 70562
	recipe = AddRecipe(70562, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(450, 450, 475, 487, 500)
	recipe:SetRecipeItem(49969, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(49902, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddRepVendor(FAC.THE_ASHEN_VERDICT, REP.REVERED, 37687)

	-- Protectors of Life -- 70563
	recipe = AddRecipe(70563, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(450, 450, 475, 487, 500)
	recipe:SetRecipeItem(49970, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(49905, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddRepVendor(FAC.THE_ASHEN_VERDICT, REP.HONORED, 37687)

	-- Legplates of Painful Death -- 70565
	recipe = AddRecipe(70565, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(450, 450, 475, 487, 500)
	recipe:SetRecipeItem(49971, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(49903, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddRepVendor(FAC.THE_ASHEN_VERDICT, REP.REVERED, 37687)

	-- Hellfrozen Bonegrinders -- 70566
	recipe = AddRecipe(70566, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(450, 450, 475, 487, 500)
	recipe:SetRecipeItem(49972, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(49906, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddRepVendor(FAC.THE_ASHEN_VERDICT, REP.HONORED, 37687)

	-- Pillars of Might -- 70567
	recipe = AddRecipe(70567, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(450, 450, 475, 487, 500)
	recipe:SetRecipeItem(49973, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(49904, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.DPS, F.TANK)
	recipe:AddRepVendor(FAC.THE_ASHEN_VERDICT, REP.REVERED, 37687)

	-- Boots of Kingly Upheaval -- 70568
	recipe = AddRecipe(70568, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(450, 450, 475, 487, 500)
	recipe:SetRecipeItem(49974, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(49907, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.TANK)
	recipe:AddRepVendor(FAC.THE_ASHEN_VERDICT, REP.HONORED, 37687)

	-- Relic of the Past I -- 330149
	recipe = AddRecipe(330149, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(15, 15, 25, 30, 35)
	recipe:SetCraftedItem(180055, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_MATERIALS")
	recipe:AddTrainer(28694, 29505, 29506)

	-- Relic of the Past II -- 330150
	recipe = AddRecipe(330150, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(30, 30, 40, 45, 50)
	recipe:SetCraftedItem(180057, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_MATERIALS")
	recipe:AddTrainer(28694, 29505, 29506)

	-- Relic of the Past III -- 330151
	recipe = AddRecipe(330151, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(45, 45, 55, 60, 65)
	recipe:SetCraftedItem(180058, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_MATERIALS")
	recipe:AddTrainer(28694, 29505, 29506)

	-- Relic of the Past IV -- 330152
	recipe = AddRecipe(330152, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(60, 60, 70, 75, 80)
	recipe:SetCraftedItem(180059, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_MATERIALS")
	recipe:AddTrainer(28694, 29505, 29506)

	-- Relic of the Past V -- 330153
	recipe = AddRecipe(330153, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 85, 90, 95)
	recipe:SetCraftedItem(180060, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_MATERIALS")
	recipe:AddTrainer(28694, 29505, 29506)

	-- ----------------------------------------------------------------------------
	-- Cataclysm.
	-- ----------------------------------------------------------------------------
	-- Folded Obsidium -- 76178
	recipe = AddRecipe(76178, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(65365, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_MATERIALS")
	recipe:AddTrainer(514, 1241, 2998, 3136, 3174, 3355, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16669, 16724, 16823, 17245, 19341, 37072, 44781, 45548, 92264, 92265)

	-- Hardened Obsidium Bracers -- 76179
	recipe = AddRecipe(76179, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(54850, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.TANK)
	recipe:AddTrainer(514, 1241, 2998, 3136, 3174, 3355, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16669, 16724, 16823, 17245, 19341, 37072, 44781, 45548, 92264, 92265)

	-- Hardened Obsidium Gauntlets -- 76180
	recipe = AddRecipe(76180, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(54852, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.DPS, F.TANK)
	recipe:AddTrainer(514, 1241, 2998, 3136, 3174, 3355, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16669, 16724, 16823, 17245, 19341, 37072, 44781, 45548, 92264, 92265)

	-- Hardened Obsidium Belt -- 76181
	recipe = AddRecipe(76181, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(10, 10, 20, 25, 30)
	recipe:SetCraftedItem(54853, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddFilters(F.DPS, F.TANK)
	recipe:AddTrainer(514, 1241, 2998, 3136, 3174, 3355, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16669, 16724, 16823, 17245, 19341, 37072, 44781, 45548, 92264, 92265)

	-- Hardened Obsidium Boots -- 76182
	recipe = AddRecipe(76182, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(20, 20, 30, 35, 40)
	recipe:SetCraftedItem(54854, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.TANK)
	recipe:AddTrainer(514, 1241, 2998, 3136, 3174, 3355, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16669, 16724, 16823, 17245, 19341, 37072, 44781, 45548, 92264, 92265)

	-- Hardened Obsidium Shoulders -- 76258
	recipe = AddRecipe(76258, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(30, 30, 40, 45, 50)
	recipe:SetCraftedItem(54876, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.TANK)
	recipe:AddTrainer(514, 1241, 2998, 3136, 3174, 3355, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16669, 16724, 16823, 17245, 19341, 37072, 44781, 45548, 92264, 92265)

	-- Hardened Obsidium Legguards -- 76259
	recipe = AddRecipe(76259, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(40, 40, 50, 55, 60)
	recipe:SetCraftedItem(55022, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.DPS, F.TANK)
	recipe:AddTrainer(514, 1241, 2998, 3136, 3174, 3355, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16669, 16724, 16823, 17245, 19341, 37072, 44781, 45548, 92264, 92265)

	-- Hardened Obsidium Helm -- 76260
	recipe = AddRecipe(76260, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(40, 40, 50, 55, 60)
	recipe:SetCraftedItem(55023, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.TANK)
	recipe:AddTrainer(514, 1241, 2998, 3136, 3174, 3355, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16669, 16724, 16823, 17245, 19341, 37072, 44781, 45548, 92264, 92265)

	-- Hardened Obsidium Breastplate -- 76261
	recipe = AddRecipe(76261, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(55024, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.TANK)
	recipe:AddTrainer(514, 1241, 2998, 3136, 3174, 3355, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16669, 16724, 16823, 17245, 19341, 37072, 44781, 45548, 92264, 92265)

	-- Redsteel Bracers -- 76262
	recipe = AddRecipe(76262, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(55025, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(514, 1241, 2998, 3136, 3174, 3355, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16669, 16724, 16823, 17245, 19341, 37072, 44781, 45548, 92264, 92265)

	-- Redsteel Gauntlets -- 76263
	recipe = AddRecipe(76263, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(55026, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(514, 1241, 2998, 3136, 3174, 3355, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16669, 16724, 16823, 17245, 19341, 37072, 44781, 45548, 92264, 92265)

	-- Redsteel Belt -- 76264
	recipe = AddRecipe(76264, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(10, 10, 20, 25, 30)
	recipe:SetCraftedItem(55027, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(514, 1241, 2998, 3136, 3174, 3355, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16669, 16724, 16823, 17245, 19341, 37072, 44781, 45548, 92264, 92265)

	-- Redsteel Boots -- 76265
	recipe = AddRecipe(76265, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(20, 20, 30, 35, 40)
	recipe:SetCraftedItem(55028, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(514, 1241, 2998, 3136, 3174, 3355, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16669, 16724, 16823, 17245, 19341, 37072, 44781, 45548, 92264, 92265)

	-- Redsteel Shoulders -- 76266
	recipe = AddRecipe(76266, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(30, 30, 40, 45, 50)
	recipe:SetCraftedItem(55029, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(514, 1241, 2998, 3136, 3174, 3355, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16669, 16724, 16823, 17245, 19341, 37072, 44781, 45548, 92264, 92265)

	-- Redsteel Legguards -- 76267
	recipe = AddRecipe(76267, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(40, 40, 50, 55, 60)
	recipe:SetCraftedItem(55030, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(514, 1241, 2998, 3136, 3174, 3355, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16669, 16724, 16823, 17245, 19341, 37072, 44781, 45548, 92264, 92265)

	-- Redsteel Helm -- 76269
	recipe = AddRecipe(76269, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(55031, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(514, 1241, 2998, 3136, 3174, 3355, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16669, 16724, 16823, 17245, 19341, 37072, 44781, 45548, 92264, 92265)

	-- Redsteel Breastplate -- 76270
	recipe = AddRecipe(76270, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(55032, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(514, 1241, 2998, 3136, 3174, 3355, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16669, 16724, 16823, 17245, 19341, 37072, 44781, 45548, 92264, 92265)

	-- Stormforged Bracers -- 76280
	recipe = AddRecipe(76280, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(55033, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(514, 1241, 2998, 3136, 3174, 3355, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16669, 16724, 16823, 17245, 19341, 37072, 44781, 45548, 92264, 92265)

	-- Stormforged Gauntlets -- 76281
	recipe = AddRecipe(76281, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(55034, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(514, 1241, 2998, 3136, 3174, 3355, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16669, 16724, 16823, 17245, 19341, 37072, 44781, 45548, 92264, 92265)

	-- Stormforged Belt -- 76283
	recipe = AddRecipe(76283, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(10, 10, 20, 25, 30)
	recipe:SetCraftedItem(55035, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(514, 1241, 2998, 3136, 3174, 3355, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16669, 16724, 16823, 17245, 19341, 37072, 44781, 45548, 92264, 92265)

	-- Stormforged Boots -- 76285
	recipe = AddRecipe(76285, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(20, 20, 30, 35, 40)
	recipe:SetCraftedItem(55036, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(514, 1241, 2998, 3136, 3174, 3355, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16669, 16724, 16823, 17245, 19341, 37072, 44781, 45548, 92264, 92265)

	-- Stormforged Shoulders -- 76286
	recipe = AddRecipe(76286, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(30, 30, 40, 45, 50)
	recipe:SetCraftedItem(55037, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(514, 1241, 2998, 3136, 3174, 3355, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16669, 16724, 16823, 17245, 19341, 37072, 44781, 45548, 92264, 92265)

	-- Stormforged Legguards -- 76287
	recipe = AddRecipe(76287, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(30, 30, 40, 45, 50)
	recipe:SetCraftedItem(55038, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(514, 1241, 2998, 3136, 3174, 3355, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16669, 16724, 16823, 17245, 19341, 37072, 44781, 45548, 92264, 92265)

	-- Stormforged Helm -- 76288
	recipe = AddRecipe(76288, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(40, 40, 50, 55, 60)
	recipe:SetCraftedItem(55039, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(514, 1241, 2998, 3136, 3174, 3355, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16669, 16724, 16823, 17245, 19341, 37072, 44781, 45548, 92264, 92265)

	-- Stormforged Breastplate -- 76289
	recipe = AddRecipe(76289, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(55040, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(514, 1241, 2998, 3136, 3174, 3355, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16669, 16724, 16823, 17245, 19341, 37072, 44781, 45548, 92264, 92265)

	-- Hardened Obsidium Shield -- 76291
	recipe = AddRecipe(76291, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(55041, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHIELD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.TANK)
	recipe:AddTrainer(514, 1241, 2998, 3136, 3174, 3355, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16669, 16724, 16823, 17245, 19341, 37072, 44781, 45548, 92264, 92265)

	-- Stormforged Shield -- 76293
	recipe = AddRecipe(76293, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(20, 20, 30, 35, 40)
	recipe:SetCraftedItem(55042, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHIELD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(514, 1241, 2998, 3136, 3174, 3355, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16669, 16724, 16823, 17245, 19341, 37072, 44781, 45548, 92264, 92265)

	-- Decapitator's Razor -- 76433
	recipe = AddRecipe(76433, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(10, 10, 20, 25, 30)
	recipe:SetCraftedItem(55043, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_AXE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(514, 1241, 2998, 3136, 3174, 3355, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16669, 16724, 16823, 17245, 19341, 37072, 44781, 45548, 92264, 92265)

	-- Cold-Forged Shank -- 76434
	recipe = AddRecipe(76434, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(20, 20, 30, 35, 40)
	recipe:SetCraftedItem(55044, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_DAGGER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(514, 1241, 2998, 3136, 3174, 3355, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16669, 16724, 16823, 17245, 19341, 37072, 44781, 45548, 92264, 92265)

	-- Fire-Etched Dagger -- 76435
	recipe = AddRecipe(76435, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(30, 30, 40, 45, 50)
	recipe:SetCraftedItem(55045, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_DAGGER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(514, 1241, 2998, 3136, 3174, 3355, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16669, 16724, 16823, 17245, 19341, 37072, 44781, 45548, 92264, 92265)

	-- Lifeforce Hammer -- 76436
	recipe = AddRecipe(76436, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(30, 30, 40, 45, 50)
	recipe:SetCraftedItem(55046, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_MACE")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(514, 1241, 2998, 3136, 3174, 3355, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16669, 16724, 16823, 17245, 19341, 37072, 44781, 45548, 92264, 92265)

	-- Obsidium Executioner -- 76437
	recipe = AddRecipe(76437, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(30, 30, 40, 45, 50)
	recipe:SetCraftedItem(55052, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_SWORD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(514, 1241, 2998, 3136, 3174, 3355, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16669, 16724, 16823, 17245, 19341, 37072, 44781, 45548, 92264, 92265)

	-- Obsidium Skeleton Key -- 76438
	recipe = AddRecipe(76438, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(55053, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SKELETON_KEY")
	recipe:AddTrainer(514, 1241, 2998, 3136, 3174, 3355, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16669, 16724, 16823, 17245, 19341, 37072, 44781, 45548, 92264, 92265)

	-- Ebonsteel Belt Buckle -- 76439
	recipe = AddRecipe(76439, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(525, 525, 525, 525, 525)
	recipe:SetRecipeItem(66100, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_ITEM_ENHANCEMENT")
	recipe:AddVendor(2999, 3356, 4259, 4597, 5512, 16670, 16713, 45549, 46359, 50375, 50382)

	-- Pyrium Shield Spike -- 76440
	recipe = AddRecipe(76440, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(525, 525, 530, 535, 540)
	recipe:SetRecipeItem(66101, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_ITEM_ENHANCEMENT")
	recipe:AddVendor(2999, 3356, 4259, 4597, 5512, 16670, 16713, 45549, 46359, 50375, 50382)

	-- Elementium Shield Spike -- 76441
	recipe = AddRecipe(76441, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(40, 40, 50, 55, 60)
	recipe:SetCraftedItem(55055, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ITEM_ENHANCEMENT")
	recipe:AddTrainer(514, 1241, 2998, 3136, 3174, 3355, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16669, 16724, 16823, 17245, 19341, 37072, 44781, 45548, 92264, 92265)

	-- Pyrium Weapon Chain -- 76442
	recipe = AddRecipe(76442, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(500, 500, 505, 510, 515)
	recipe:SetRecipeItem(66103, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(2999, 3356, 4259, 4597, 5512, 16670, 16713, 45549, 46359, 50375, 50382)

	-- Hardened Elementium Hauberk -- 76443
	recipe = AddRecipe(76443, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(515, 515, 515, 515, 525)
	recipe:SetRecipeItem(66104, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.TANK)
	recipe:AddVendor(2999, 3356, 4259, 4597, 5512, 16670, 16713, 45549, 46359, 50375, 50382)

	-- Hardened Elementium Girdle -- 76444
	recipe = AddRecipe(76444, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(510, 510, 520, 522, 525)
	recipe:SetRecipeItem(66105, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.TANK)
	recipe:AddVendor(2999, 3356, 4259, 4597, 5512, 16670, 16713, 45549, 46359, 50375, 50382)

	-- Elementium Deathplate -- 76445
	recipe = AddRecipe(76445, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(515, 515, 515, 515, 525)
	recipe:SetRecipeItem(66106, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(2999, 3356, 4259, 4597, 5512, 16670, 16713, 45549, 46359, 50375, 50382)

	-- Elementium Girdle of Pain -- 76446
	recipe = AddRecipe(76446, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(510, 510, 520, 522, 525)
	recipe:SetRecipeItem(66107, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(2999, 3356, 4259, 4597, 5512, 16670, 16713, 45549, 46359, 50375, 50382)

	-- Light Elementium Chestguard -- 76447
	recipe = AddRecipe(76447, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(515, 515, 515, 515, 525)
	recipe:SetRecipeItem(66108, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(2999, 3356, 4259, 4597, 5512, 16670, 16713, 45549, 46359, 50375, 50382)

	-- Light Elementium Belt -- 76448
	recipe = AddRecipe(76448, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(510, 510, 520, 522, 525)
	recipe:SetRecipeItem(66109, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(2999, 3356, 4259, 4597, 5512, 16670, 16713, 45549, 46359, 50375, 50382)

	-- Elementium Spellblade -- 76449
	recipe = AddRecipe(76449, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(520, 520, 520, 520, 525)
	recipe:SetRecipeItem(66110, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_DAGGER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(2999, 3356, 4259, 4597, 5512, 16670, 16713, 45549, 46359, 50375, 50382)

	-- Elementium Hammer -- 76450
	recipe = AddRecipe(76450, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(515, 515, 515, 515, 525)
	recipe:SetRecipeItem(66111, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_MACE")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(2999, 3356, 4259, 4597, 5512, 16670, 16713, 45549, 46359, 50375, 50382)

	-- Elementium Poleaxe -- 76451
	recipe = AddRecipe(76451, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(520, 520, 520, 520, 525)
	recipe:SetRecipeItem(66112, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_POLEARM")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(2999, 3356, 4259, 4597, 5512, 16670, 16713, 45549, 46359, 50375, 50382)

	-- Elementium Bonesplitter -- 76452
	recipe = AddRecipe(76452, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(515, 515, 515, 515, 525)
	recipe:SetRecipeItem(66113, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_AXE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(2999, 3356, 4259, 4597, 5512, 16670, 16713, 45549, 46359, 50375, 50382)

	-- Elementium Shank -- 76453
	recipe = AddRecipe(76453, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(520, 520, 520, 520, 525)
	recipe:SetRecipeItem(66114, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_DAGGER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(2999, 3356, 4259, 4597, 5512, 16670, 16713, 45549, 46359, 50375, 50382)

	-- Elementium Earthguard -- 76454
	recipe = AddRecipe(76454, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(520, 520, 520, 520, 525)
	recipe:SetRecipeItem(66115, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_SHIELD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(2999, 3356, 4259, 4597, 5512, 16670, 16713, 45549, 46359, 50375, 50382)

	-- Elementium Stormshield -- 76455
	recipe = AddRecipe(76455, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(520, 520, 520, 520, 525)
	recipe:SetRecipeItem(66116, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_SHIELD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(2999, 3356, 4259, 4597, 5512, 16670, 16713, 45549, 46359, 50375, 50382)

	-- Vicious Pyrium Bracers -- 76456
	recipe = AddRecipe(76456, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(500, 500, 510, 512, 515)
	recipe:SetRecipeItem(66117, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(2999, 3356, 4259, 4597, 5512, 16670, 16713, 45549, 46359, 50375, 50382)

	-- Vicious Pyrium Gauntlets -- 76457
	recipe = AddRecipe(76457, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(505, 505, 515, 517, 520)
	recipe:SetRecipeItem(66118, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(2999, 3356, 4259, 4597, 5512, 16670, 16713, 45549, 46359, 50375, 50382)

	-- Vicious Pyrium Belt -- 76458
	recipe = AddRecipe(76458, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(510, 510, 520, 522, 525)
	recipe:SetRecipeItem(66119, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(2999, 3356, 4259, 4597, 5512, 16670, 16713, 45549, 46359, 50375, 50382)

	-- Vicious Pyrium Boots -- 76459
	recipe = AddRecipe(76459, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(515, 515, 525, 527, 530)
	recipe:SetRecipeItem(66120, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(2999, 3356, 4259, 4597, 5512, 16670, 16713, 45549, 46359, 50375, 50382)

	-- Vicious Pyrium Shoulders -- 76461
	recipe = AddRecipe(76461, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(520, 520, 530, 532, 535)
	recipe:SetRecipeItem(66121, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(2999, 3356, 4259, 4597, 5512, 16670, 16713, 45549, 46359, 50375, 50382)

	-- Vicious Pyrium Legguards -- 76462
	recipe = AddRecipe(76462, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(525, 525, 535, 537, 540)
	recipe:SetRecipeItem(66122, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(2999, 3356, 4259, 4597, 5512, 16670, 16713, 45549, 46359, 50375, 50382)

	-- Vicious Pyrium Helm -- 76463
	recipe = AddRecipe(76463, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(525, 525, 535, 537, 540)
	recipe:SetRecipeItem(66123, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(2999, 3356, 4259, 4597, 5512, 16670, 16713, 45549, 46359, 50375, 50382)

	-- Vicious Pyrium Breastplate -- 76464
	recipe = AddRecipe(76464, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(525, 525, 535, 537, 540)
	recipe:SetRecipeItem(66124, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(2999, 3356, 4259, 4597, 5512, 16670, 16713, 45549, 46359, 50375, 50382)

	-- Vicious Ornate Pyrium Bracers -- 76465
	recipe = AddRecipe(76465, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(500, 500, 510, 512, 515)
	recipe:SetRecipeItem(66125, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(2999, 3356, 4259, 4597, 5512, 16670, 16713, 45549, 46359, 50375, 50382)

	-- Vicious Ornate Pyrium Gauntlets -- 76466
	recipe = AddRecipe(76466, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(505, 505, 515, 517, 520)
	recipe:SetRecipeItem(66126, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(2999, 3356, 4259, 4597, 5512, 16670, 16713, 45549, 46359, 50375, 50382)

	-- Vicious Ornate Pyrium Belt -- 76467
	recipe = AddRecipe(76467, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(510, 510, 520, 522, 525)
	recipe:SetRecipeItem(66127, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(2999, 3356, 4259, 4597, 5512, 16670, 16713, 45549, 46359, 50375, 50382)

	-- Vicious Ornate Pyrium Boots -- 76468
	recipe = AddRecipe(76468, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(515, 515, 525, 527, 530)
	recipe:SetRecipeItem(66128, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(2999, 3356, 4259, 4597, 5512, 16670, 16713, 45549, 46359, 50375, 50382)

	-- Vicious Ornate Pyrium Shoulders -- 76469
	recipe = AddRecipe(76469, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(520, 520, 530, 532, 535)
	recipe:SetRecipeItem(66129, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(2999, 3356, 4259, 4597, 5512, 16670, 16713, 45549, 46359, 50375, 50382)

	-- Vicious Ornate Pyrium Legguards -- 76470
	recipe = AddRecipe(76470, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(525, 525, 535, 537, 540)
	recipe:SetRecipeItem(66130, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(2999, 3356, 4259, 4597, 5512, 16670, 16713, 45549, 46359, 50375, 50382)

	-- Vicious Ornate Pyrium Helm -- 76471
	recipe = AddRecipe(76471, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(525, 525, 535, 537, 540)
	recipe:SetRecipeItem(66131, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(2999, 3356, 4259, 4597, 5512, 16670, 16713, 45549, 46359, 50375, 50382)

	-- Vicious Ornate Pyrium Breastplate -- 76472
	recipe = AddRecipe(76472, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(525, 525, 535, 537, 540)
	recipe:SetRecipeItem(66132, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(2999, 3356, 4259, 4597, 5512, 16670, 16713, 45549, 46359, 50375, 50382)

	-- Obsidium Bladespear -- 76474
	recipe = AddRecipe(76474, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(20, 20, 30, 35, 40)
	recipe:SetCraftedItem(55246, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_POLEARM")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(514, 1241, 2998, 3136, 3174, 3355, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16669, 16724, 16823, 17245, 19341, 37072, 44781, 45548, 92264, 92265)

	-- Elementium Gutslicer -- 94718
	recipe = AddRecipe(94718, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(515, 515, 515, 515, 525)
	recipe:SetRecipeItem(67603, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_AXE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(2999, 3356, 4259, 4597, 5512, 16670, 16713, 45549, 46359, 50375, 50382)

	-- Forged Elementium Mindcrusher -- 94732
	recipe = AddRecipe(94732, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(520, 520, 520, 520, 525)
	recipe:SetRecipeItem(67606, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_MACE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(2999, 3356, 4259, 4597, 5512, 16670, 16713, 45549, 46359, 50375, 50382)

	-- Fists of Fury -- 99439
	recipe = AddRecipe(99439, V.CATA, Q.EPIC)
	recipe:SetSkillLevels(525, 525, 525, 527, 530)
	recipe:SetRecipeItem(69957, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(69936, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.FIRELANDS)

	-- Eternal Elementium Handguards -- 99440
	recipe = AddRecipe(99440, V.CATA, Q.EPIC)
	recipe:SetSkillLevels(525, 525, 525, 527, 530)
	recipe:SetRecipeItem(69958, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(69937, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.DPS, F.TANK)
	recipe:AddWorldDrop(Z.FIRELANDS)

	-- Holy Flame Gauntlets -- 99441
	recipe = AddRecipe(99441, V.CATA, Q.EPIC)
	recipe:SetSkillLevels(525, 525, 525, 527, 530)
	recipe:SetRecipeItem(69959, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(69938, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.FIRELANDS)

	-- Warboots of Mighty Lords -- 99452
	recipe = AddRecipe(99452, V.CATA, Q.EPIC)
	recipe:SetSkillLevels(525, 525, 525, 527, 530)
	recipe:SetRecipeItem(69968, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(69946, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.FIRELANDS)

	-- Mirrored Boots -- 99453
	recipe = AddRecipe(99453, V.CATA, Q.EPIC)
	recipe:SetSkillLevels(525, 525, 525, 527, 530)
	recipe:SetRecipeItem(69969, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(69947, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.DPS, F.TANK)
	recipe:AddWorldDrop(Z.FIRELANDS)

	-- Emberforged Elementium Boots -- 99454
	recipe = AddRecipe(99454, V.CATA, Q.EPIC)
	recipe:SetSkillLevels(525, 525, 525, 527, 530)
	recipe:SetRecipeItem(69970, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(69948, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.FIRELANDS)

	-- Brainsplinter -- 99652
	recipe = AddRecipe(99652, V.CATA, Q.RARE)
	recipe:SetSkillLevels(525, 525, 525, 527, 530)
	recipe:SetRecipeItem(70166, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(70155, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_DAGGER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(53214)

	-- Masterwork Elementium Spellblade -- 99653
	recipe = AddRecipe(99653, V.CATA, Q.RARE)
	recipe:SetSkillLevels(525, 525, 525, 527, 530)
	recipe:SetRecipeItem(70167, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(70156, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_DAGGER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(53214)

	-- Lightforged Elementium Hammer -- 99654
	recipe = AddRecipe(99654, V.CATA, Q.RARE)
	recipe:SetSkillLevels(525, 525, 525, 527, 530)
	recipe:SetRecipeItem(70168, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(70157, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_MACE")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(53214)

	-- Elementium-Edged Scalper -- 99655
	recipe = AddRecipe(99655, V.CATA, Q.RARE)
	recipe:SetSkillLevels(525, 525, 525, 527, 530)
	recipe:SetRecipeItem(70169, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(70158, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_AXE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(53214)

	-- Pyrium Spellward -- 99656
	recipe = AddRecipe(99656, V.CATA, Q.RARE)
	recipe:SetSkillLevels(525, 525, 525, 527, 530)
	recipe:SetRecipeItem(70170, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(70162, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_SWORD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(53214)

	-- Unbreakable Guardian -- 99657
	recipe = AddRecipe(99657, V.CATA, Q.RARE)
	recipe:SetSkillLevels(525, 525, 525, 527, 530)
	recipe:SetRecipeItem(70171, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(70163, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_SWORD")
	recipe:AddFilters(F.DPS, F.TANK)
	recipe:AddVendor(53214)

	-- Masterwork Elementium Deathblade -- 99658
	recipe = AddRecipe(99658, V.CATA, Q.RARE)
	recipe:SetSkillLevels(525, 525, 525, 527, 530)
	recipe:SetRecipeItem(70172, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(70164, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_SWORD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(53214)

	-- Witch-Hunter's Harvester -- 99660
	recipe = AddRecipe(99660, V.CATA, Q.RARE)
	recipe:SetSkillLevels(525, 525, 525, 527, 530)
	recipe:SetRecipeItem(70173, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(70165, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_POLEARM")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(53214)

	-- Pyrium Legplates of Purified Evil -- 101924
	recipe = AddRecipe(101924, V.CATA, Q.EPIC)
	recipe:SetSkillLevels(525, 525, 525, 527, 530)
	recipe:SetRecipeItem(72001, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(71982, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.DRAGON_SOUL)

	-- Unstoppable Destroyer's Legplates -- 101925
	recipe = AddRecipe(101925, V.CATA, Q.EPIC)
	recipe:SetSkillLevels(525, 525, 525, 527, 530)
	recipe:SetRecipeItem(72012, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(71983, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.DRAGON_SOUL)

	-- Foundations of Courage -- 101928
	recipe = AddRecipe(101928, V.CATA, Q.EPIC)
	recipe:SetSkillLevels(525, 525, 525, 527, 530)
	recipe:SetRecipeItem(72013, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(71984, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.DPS, F.TANK)
	recipe:AddWorldDrop(Z.DRAGON_SOUL)

	-- Soul Redeemer Bracers -- 101929
	recipe = AddRecipe(101929, V.CATA, Q.EPIC)
	recipe:SetSkillLevels(525, 525, 525, 527, 530)
	recipe:SetRecipeItem(72014, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(71991, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.DRAGON_SOUL)

	-- Bracers of Destructive Strength -- 101931
	recipe = AddRecipe(101931, V.CATA, Q.EPIC)
	recipe:SetSkillLevels(525, 525, 525, 527, 530)
	recipe:SetRecipeItem(72015, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(71992, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.DRAGON_SOUL)

	-- Titanguard Wristplates -- 101932
	recipe = AddRecipe(101932, V.CATA, Q.EPIC)
	recipe:SetSkillLevels(525, 525, 525, 527, 530)
	recipe:SetRecipeItem(72016, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(71993, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.DPS, F.TANK)
	recipe:AddWorldDrop(Z.DRAGON_SOUL)

	-- Relic of the Past I -- 330154
	recipe = AddRecipe(330154, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(180055, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_MATERIALS")
	recipe:AddTrainer(2998, 4258, 4596, 5511, 11146, 16669, 45548)

	-- Relic of the Past II -- 330155
	recipe = AddRecipe(330155, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(180057, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_MATERIALS")
	recipe:AddTrainer(2998, 4258, 4596, 5511, 11146, 16669, 45548)

	-- Relic of the Past III -- 330156
	recipe = AddRecipe(330156, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(180058, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_MATERIALS")
	recipe:AddTrainer(2998, 4258, 4596, 5511, 11146, 16669, 45548)

	-- Relic of the Past IV -- 330157
	recipe = AddRecipe(330157, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(180059, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_MATERIALS")
	recipe:AddTrainer(2998, 4258, 4596, 5511, 11146, 16669, 45548)

	-- Relic of the Past V -- 330158
	recipe = AddRecipe(330158, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(180060, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_MATERIALS")
	recipe:AddTrainer(2998, 4258, 4596, 5511, 11146, 16669, 45548)

	-- ----------------------------------------------------------------------------
	-- Mists of Pandaria.
	-- ----------------------------------------------------------------------------
	-- Ghost-Forged Helm -- 122576
	recipe = AddRecipe(122576, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(82903, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddTrainer(16823, 19341, 65114, 65129, 92264, 92265)
	recipe:AddMixed(64058, 64085)

	-- Ghost-Forged Shoulders -- 122577
	recipe = AddRecipe(122577, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(15, 15, 25, 30, 35)
	recipe:SetCraftedItem(82904, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_SHOULDER")
	recipe:AddTrainer(16823, 19341, 65114, 65129, 92264, 92265)
	recipe:AddMixed(64058, 64085)

	-- Ghost-Forged Breastplate -- 122578
	recipe = AddRecipe(122578, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(82905, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddTrainer(16823, 19341, 65114, 65129, 92264, 92265)
	recipe:AddMixed(64058, 64085)

	-- Ghost-Forged Gauntlets -- 122579
	recipe = AddRecipe(122579, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(82906, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddTrainer(16823, 19341, 65114, 65129, 92264, 92265)
	recipe:AddMixed(64058, 64085)

	-- Ghost-Forged Legplates -- 122580
	recipe = AddRecipe(122580, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(5, 5, 15, 20, 25)
	recipe:SetCraftedItem(82907, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddTrainer(16823, 19341, 65114, 65129, 92264, 92265)
	recipe:AddMixed(64058, 64085)

	-- Ghost-Forged Bracers -- 122581
	recipe = AddRecipe(122581, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(82908, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddTrainer(16823, 19341, 65114, 65129, 92264, 92265)
	recipe:AddMixed(64058, 64085)

	-- Ghost-Forged Boots -- 122582
	recipe = AddRecipe(122582, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(5, 5, 15, 20, 25)
	recipe:SetCraftedItem(82909, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddTrainer(16823, 19341, 65114, 65129, 92264, 92265)
	recipe:AddMixed(64058, 64085)

	-- Ghost-Forged Belt -- 122583
	recipe = AddRecipe(122583, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(82910, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddTrainer(16823, 19341, 65114, 65129, 92264, 92265)
	recipe:AddMixed(64058, 64085)

	-- Masterwork Spiritguard Helm -- 122592
	recipe = AddRecipe(122592, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(575, 575, 575, 575, 600)
	recipe:SetRecipeItem(84224, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddMixed(64058, 64085)

	-- Masterwork Spiritguard Shoulders -- 122593
	recipe = AddRecipe(122593, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(575, 575, 575, 575, 600)
	recipe:SetRecipeItem(84227, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.MIXED)
	recipe:AddMixed(64058, 64085)

	-- Masterwork Spiritguard Breastplate -- 122594
	recipe = AddRecipe(122594, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(575, 575, 575, 575, 600)
	recipe:SetRecipeItem(84222, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddMixed(64058, 64085)

	-- Masterwork Spiritguard Gauntlets -- 122595
	recipe = AddRecipe(122595, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(575, 575, 575, 575, 600)
	recipe:SetRecipeItem(84223, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddMixed(64058, 64085)

	-- Masterwork Spiritguard Legplates -- 122596
	recipe = AddRecipe(122596, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(575, 575, 575, 575, 600)
	recipe:SetRecipeItem(84225, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddMixed(64058, 64085)

	-- Masterwork Spiritguard Bracers -- 122597
	recipe = AddRecipe(122597, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(575, 575, 575, 575, 600)
	recipe:SetRecipeItem(84221, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddMixed(64058, 64085)

	-- Masterwork Spiritguard Boots -- 122598
	recipe = AddRecipe(122598, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(575, 575, 575, 575, 600)
	recipe:SetRecipeItem(84220, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddMixed(64058, 64085)

	-- Masterwork Spiritguard Belt -- 122599
	recipe = AddRecipe(122599, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(575, 575, 575, 575, 600)
	recipe:SetRecipeItem(84219, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddMixed(64058, 64085)

	-- Contender's Revenant Helm -- 122616
	recipe = AddRecipe(122616, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(575, 575, 575, 575, 600)
	recipe:SetRecipeItem(84163, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddMixed(64058, 64085)

	-- Contender's Revenant Shoulders -- 122617
	recipe = AddRecipe(122617, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(575, 575, 575, 575, 600)
	recipe:SetRecipeItem(84165, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddMixed(64058, 64085)

	-- Contender's Revenant Breastplate -- 122618
	recipe = AddRecipe(122618, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(575, 575, 575, 575, 600)
	recipe:SetRecipeItem(84161, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddMixed(64058, 64085)

	-- Contender's Revenant Gauntlets -- 122619
	recipe = AddRecipe(122619, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(575, 575, 575, 575, 600)
	recipe:SetRecipeItem(84162, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddMixed(64058, 64085)

	-- Contender's Revenant Legplates -- 122620
	recipe = AddRecipe(122620, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(575, 575, 575, 575, 600)
	recipe:SetRecipeItem(84164, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddMixed(64058, 64085)

	-- Contender's Revenant Bracers -- 122621
	recipe = AddRecipe(122621, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(575, 575, 575, 575, 600)
	recipe:SetRecipeItem(84160, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddMixed(64058, 64085)

	-- Contender's Revenant Boots -- 122622
	recipe = AddRecipe(122622, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(575, 575, 575, 575, 600)
	recipe:SetRecipeItem(84159, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddMixed(64058, 64085)

	-- Contender's Revenant Belt -- 122623
	recipe = AddRecipe(122623, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(575, 575, 575, 575, 600)
	recipe:SetRecipeItem(84158, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddMixed(64058, 64085)

	-- Contender's Spirit Helm -- 122624
	recipe = AddRecipe(122624, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(575, 575, 575, 575, 600)
	recipe:SetRecipeItem(84171, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddMixed(64058, 64085)

	-- Contender's Spirit Shoulders -- 122625
	recipe = AddRecipe(122625, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(575, 575, 575, 575, 600)
	recipe:SetRecipeItem(84173, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddMixed(64058, 64085)

	-- Contender's Spirit Breastplate -- 122626
	recipe = AddRecipe(122626, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(575, 575, 575, 575, 600)
	recipe:SetRecipeItem(84169, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddMixed(64058, 64085)

	-- Contender's Spirit Gauntlets -- 122627
	recipe = AddRecipe(122627, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(575, 575, 575, 575, 600)
	recipe:SetRecipeItem(84170, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddMixed(64058, 64085)

	-- Contender's Spirit Legplates -- 122628
	recipe = AddRecipe(122628, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(575, 575, 575, 575, 600)
	recipe:SetRecipeItem(84172, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddMixed(64058, 64085)

	-- Contender's Spirit Bracers -- 122629
	recipe = AddRecipe(122629, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(575, 575, 575, 575, 600)
	recipe:SetRecipeItem(84168, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddMixed(64058, 64085)

	-- Contender's Spirit Boots -- 122630
	recipe = AddRecipe(122630, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(575, 575, 575, 575, 600)
	recipe:SetRecipeItem(84167, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddMixed(64058, 64085)

	-- Contender's Spirit Belt -- 122631
	recipe = AddRecipe(122631, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(575, 575, 575, 575, 600)
	recipe:SetRecipeItem(84166, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddMixed(64058, 64085)

	-- Living Steel Belt Buckle -- 122632
	recipe = AddRecipe(122632, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetRecipeItem(84196, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(90046, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ITEM_ENHANCEMENT")
	recipe:AddRepVendor(FAC.THE_KLAXXI, REP.HONORED, 64599)

	-- Ghostly Skeleton Key -- 122633
	recipe = AddRecipe(122633, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(82960, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SKELETON_KEY")
	recipe:AddTrainer(16823, 19341, 65114, 65129, 92264, 92265)
	recipe:AddMixed(64058, 64085)

	-- Lightsteel Shield -- 122635
	recipe = AddRecipe(122635, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(15, 15, 25, 30, 35)
	recipe:SetCraftedItem(82961, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHIELD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(16823, 19341, 65114, 65129, 92264, 92265)
	recipe:AddMixed(64058, 64085)

	-- Spiritguard Shield -- 122636
	recipe = AddRecipe(122636, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(20, 20, 30, 35, 40)
	recipe:SetCraftedItem(82962, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_SHIELD")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(16823, 19341, 65114, 65129, 92264, 92265)
	recipe:AddMixed(64058, 64085)

	-- Forgewire Axe -- 122637
	recipe = AddRecipe(122637, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(20, 20, 30, 35, 40)
	recipe:SetCraftedItem(82963, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_AXE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(16823, 19341, 65114, 65129, 92264, 92265)
	recipe:AddMixed(64058, 64085)

	-- Ghost-Forged Blade -- 122638
	recipe = AddRecipe(122638, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(20, 20, 30, 35, 40)
	recipe:SetCraftedItem(82964, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_SWORD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(16823, 19341, 65114, 65129, 92264, 92265)
	recipe:AddMixed(64058, 64085)

	-- Phantasmal Hammer -- 122639
	recipe = AddRecipe(122639, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(35, 35, 45, 50, 55)
	recipe:SetCraftedItem(82965, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_MACE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(16823, 19341, 65114, 65129, 92264, 92265)
	recipe:AddMixed(64058, 64085)

	-- Spiritblade Decimator -- 122640
	recipe = AddRecipe(122640, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(40, 40, 50, 55, 60)
	recipe:SetCraftedItem(82966, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_DAGGER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(16823, 19341, 65114, 65129, 92264, 92265)
	recipe:AddMixed(64058, 64085)

	-- Ghost Shard -- 122641
	recipe = AddRecipe(122641, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(40, 40, 50, 55, 60)
	recipe:SetCraftedItem(82967, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_DAGGER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(16823, 19341, 65114, 65129, 92264, 92265)
	recipe:AddMixed(64058, 64085)

	-- Masterwork Lightsteel Shield -- 122642
	recipe = AddRecipe(122642, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(575, 575, 600, 602, 605)
	recipe:SetRecipeItem(84208, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(82968, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHIELD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddMixed(64058, 64085)

	-- Masterwork Spiritguard Shield -- 122643
	recipe = AddRecipe(122643, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(575, 575, 600, 602, 605)
	recipe:SetRecipeItem(84226, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(82969, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHIELD")
	recipe:AddFilters(F.DPS)
	recipe:AddMixed(64058, 64085)

	-- Masterwork Forgewire Axe -- 122644
	recipe = AddRecipe(122644, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(575, 575, 600, 602, 605)
	recipe:SetRecipeItem(84197, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(82970, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_AXE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddRepVendor(FAC.THE_KLAXXI, REP.HONORED, 64599)

	-- Masterwork Ghost-Forged Blade -- 122645
	recipe = AddRecipe(122645, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(575, 575, 600, 602, 605)
	recipe:SetRecipeItem(84200, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(82971, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_SWORD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddRepVendor(FAC.THE_KLAXXI, REP.HONORED, 64599)

	-- Masterwork Phantasmal Hammer -- 122646
	recipe = AddRecipe(122646, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(575, 575, 600, 602, 605)
	recipe:SetRecipeItem(84217, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(82972, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_MACE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddRepVendor(FAC.THE_KLAXXI, REP.HONORED, 64599)

	-- Masterwork Spiritblade Decimator -- 122647
	recipe = AddRecipe(122647, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(575, 575, 600, 602, 605)
	recipe:SetRecipeItem(84218, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(82974, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_AXE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddRepVendor(FAC.THE_KLAXXI, REP.HONORED, 64599)

	-- Masterwork Ghost Shard -- 122648
	recipe = AddRecipe(122648, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(575, 575, 600, 602, 605)
	recipe:SetRecipeItem(84198, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(82974, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_DAGGER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddRepVendor(FAC.THE_KLAXXI, REP.HONORED, 64599)

	-- Ghost Reaver's Breastplate -- 122649
	recipe = AddRecipe(122649, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetRecipeItem(83787, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(82975, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddRepVendor(FAC.THE_KLAXXI, REP.HONORED, 64599)

	-- Ghost Reaver's Gauntlets -- 122650
	recipe = AddRecipe(122650, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetRecipeItem(83788, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(82976, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddRepVendor(FAC.THE_KLAXXI, REP.HONORED, 64599)

	-- Living Steel Breastplate -- 122651
	recipe = AddRecipe(122651, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetRecipeItem(83789, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(82977, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddRepVendor(FAC.THE_KLAXXI, REP.HONORED, 64599)

	-- Living Steel Gauntlets -- 122652
	recipe = AddRecipe(122652, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetRecipeItem(83790, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(82978, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddRepVendor(FAC.THE_KLAXXI, REP.HONORED, 64599)

	-- Breastplate of Ancient Steel -- 122653
	recipe = AddRecipe(122653, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetRecipeItem(83791, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(82979, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddRepVendor(FAC.THE_KLAXXI, REP.HONORED, 64599)

	-- Gauntlets of Ancient Steel -- 122654
	recipe = AddRecipe(122654, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetRecipeItem(83792, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(82980, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddRepVendor(FAC.THE_KLAXXI, REP.HONORED, 64599)

	-- Unyielding Bloodplate -- 126850
	recipe = AddRecipe(126850, V.MOP, Q.EPIC)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetRecipeItem(87408, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(87405, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddCustom("HEROIC")
	recipe:AddWorldDrop(Z.HEART_OF_FEAR, Z.MOGUSHAN_VAULTS, Z.TERRACE_OF_ENDLESS_SPRING)

	-- Gauntlets of Battle Command -- 126851
	recipe = AddRecipe(126851, V.MOP, Q.EPIC)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetRecipeItem(87409, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(87406, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddCustom("HEROIC")
	recipe:AddWorldDrop(Z.HEART_OF_FEAR, Z.MOGUSHAN_VAULTS, Z.TERRACE_OF_ENDLESS_SPRING)

	-- Ornate Battleplate of the Master -- 126852
	recipe = AddRecipe(126852, V.MOP, Q.EPIC)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetRecipeItem(87410, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(87402, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddCustom("HEROIC")
	recipe:AddWorldDrop(Z.HEART_OF_FEAR, Z.MOGUSHAN_VAULTS, Z.TERRACE_OF_ENDLESS_SPRING)

	-- Bloodforged Warfists -- 126853
	recipe = AddRecipe(126853, V.MOP, Q.EPIC)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetRecipeItem(87411, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(87407, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddCustom("HEROIC")
	recipe:AddWorldDrop(Z.HEART_OF_FEAR, Z.MOGUSHAN_VAULTS, Z.TERRACE_OF_ENDLESS_SPRING)

	-- Chestplate of Limitless Faith -- 126854
	recipe = AddRecipe(126854, V.MOP, Q.EPIC)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetRecipeItem(87412, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(87403, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddCustom("HEROIC")
	recipe:AddWorldDrop(Z.HEART_OF_FEAR, Z.MOGUSHAN_VAULTS, Z.TERRACE_OF_ENDLESS_SPRING)

	-- Gauntlets of Unbound Devotion -- 126855
	recipe = AddRecipe(126855, V.MOP, Q.EPIC)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetRecipeItem(87413, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(87403, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddCustom("HEROIC")
	recipe:AddWorldDrop(Z.HEART_OF_FEAR, Z.MOGUSHAN_VAULTS, Z.TERRACE_OF_ENDLESS_SPRING)

	-- Ghost Iron Shield Spike -- 131928
	recipe = AddRecipe(131928, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(540, 540, 550, 557, 565)
	recipe:SetRecipeItem(90531, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(86599, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ITEM_ENHANCEMENT")
	recipe:AddRepVendor(FAC.THE_KLAXXI, REP.HONORED, 64599)

	-- Living Steel Weapon Chain -- 131929
	recipe = AddRecipe(131929, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(540, 540, 600, 602, 605)
	recipe:SetRecipeItem(90532, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(86597, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddRepVendor(FAC.THE_KLAXXI, REP.HONORED, 64599)

	-- Haunted Steel Greaves -- 137766
	recipe = AddRecipe(137766, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(94263, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddDiscovery("DISCOVERY_BS_PANDARIA")

	-- Haunted Steel Headcover -- 137767
	recipe = AddRecipe(137767, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(94264, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddDiscovery("DISCOVERY_BS_PANDARIA")

	-- Haunted Steel Treads -- 137768
	recipe = AddRecipe(137768, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(94265, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddDiscovery("DISCOVERY_BS_PANDARIA")

	-- Haunted Steel Greathelm -- 137769
	recipe = AddRecipe(137769, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(94266, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddDiscovery("DISCOVERY_BS_PANDARIA")

	-- Haunted Steel Warboots -- 137770
	recipe = AddRecipe(137770, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(94267, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddDiscovery("DISCOVERY_BS_PANDARIA")

	-- Haunted Steel Headguard -- 137771
	recipe = AddRecipe(137771, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(94268, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddDiscovery("DISCOVERY_BS_PANDARIA")

	-- Crafted Dreadful Gladiator's Scaled Gauntlets -- 137772
	recipe = AddRecipe(137772, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetCraftedItem(93528, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.PALADIN)
	recipe:AddDiscovery("DISCOVERY_BS_PANDARIA")

	-- Crafted Dreadful Gladiator's Scaled Helm -- 137773
	recipe = AddRecipe(137773, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetCraftedItem(93529, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.PALADIN)
	recipe:AddDiscovery("DISCOVERY_BS_PANDARIA")

	-- Crafted Dreadful Gladiator's Scaled Legguards -- 137774
	recipe = AddRecipe(137774, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetCraftedItem(93530, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.PALADIN)
	recipe:AddDiscovery("DISCOVERY_BS_PANDARIA")

	-- Crafted Dreadful Gladiator's Scaled Shoulders -- 137775
	recipe = AddRecipe(137775, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetCraftedItem(93531, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.PALADIN)
	recipe:AddDiscovery("DISCOVERY_BS_PANDARIA")

	-- Crafted Dreadful Gladiator's Clasp of Cruelty -- 137776
	recipe = AddRecipe(137776, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetCraftedItem(93532, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.PALADIN)
	recipe:AddDiscovery("DISCOVERY_BS_PANDARIA")

	-- Crafted Dreadful Gladiator's Clasp of Meditation -- 137777
	recipe = AddRecipe(137777, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetCraftedItem(93533, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.PALADIN)
	recipe:AddDiscovery("DISCOVERY_BS_PANDARIA")

	-- Crafted Dreadful Gladiator's Greaves of Alacrity -- 137778
	recipe = AddRecipe(137778, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetCraftedItem(93534, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.PALADIN)
	recipe:AddDiscovery("DISCOVERY_BS_PANDARIA")

	-- Crafted Dreadful Gladiator's Greaves of Meditation -- 137779
	recipe = AddRecipe(137779, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetCraftedItem(93535, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.PALADIN)
	recipe:AddDiscovery("DISCOVERY_BS_PANDARIA")

	-- Crafted Dreadful Gladiator's Bracers of Prowess -- 137780
	recipe = AddRecipe(137780, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetCraftedItem(93536, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.PALADIN)
	recipe:AddDiscovery("DISCOVERY_BS_PANDARIA")

	-- Crafted Dreadful Gladiator's Bracers of Meditation -- 137781
	recipe = AddRecipe(137781, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetCraftedItem(93537, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.PALADIN)
	recipe:AddDiscovery("DISCOVERY_BS_PANDARIA")

	-- Crafted Dreadful Gladiator's Ornamented Chestguard -- 137782
	recipe = AddRecipe(137782, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetCraftedItem(93538, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.PALADIN)
	recipe:AddDiscovery("DISCOVERY_BS_PANDARIA")

	-- Crafted Dreadful Gladiator's Ornamented Gloves -- 137783
	recipe = AddRecipe(137783, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetCraftedItem(93539, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.PALADIN)
	recipe:AddDiscovery("DISCOVERY_BS_PANDARIA")

	-- Crafted Dreadful Gladiator's Ornamented Headcover -- 137784
	recipe = AddRecipe(137784, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetCraftedItem(93540, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.PALADIN)
	recipe:AddDiscovery("DISCOVERY_BS_PANDARIA")

	-- Crafted Dreadful Gladiator's Ornamented Legplates -- 137785
	recipe = AddRecipe(137785, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetCraftedItem(93455, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.PALADIN)
	recipe:AddDiscovery("DISCOVERY_BS_PANDARIA")

	-- Crafted Dreadful Gladiator's Ornamented Spaulders -- 137786
	recipe = AddRecipe(137786, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetCraftedItem(93542, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.PALADIN)
	recipe:AddDiscovery("DISCOVERY_BS_PANDARIA")

	-- Crafted Dreadful Gladiator's Girdle of Accuracy -- 137787
	recipe = AddRecipe(137787, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetCraftedItem(93543, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.DK, F.PALADIN, F.WARRIOR)
	recipe:AddDiscovery("DISCOVERY_BS_PANDARIA")

	-- Crafted Dreadful Gladiator's Girdle of Prowess -- 137788
	recipe = AddRecipe(137788, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetCraftedItem(93544, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.DK, F.PALADIN, F.WARRIOR)
	recipe:AddDiscovery("DISCOVERY_BS_PANDARIA")

	-- Crafted Dreadful Gladiator's Warboots of Cruelty -- 137789
	recipe = AddRecipe(137789, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetCraftedItem(93545, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.DK, F.PALADIN, F.WARRIOR)
	recipe:AddDiscovery("DISCOVERY_BS_PANDARIA")

	-- Crafted Dreadful Gladiator's Warboots of Alacrity -- 137790
	recipe = AddRecipe(137790, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetCraftedItem(93546, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.DK, F.PALADIN, F.WARRIOR)
	recipe:AddDiscovery("DISCOVERY_BS_PANDARIA")

	-- Crafted Dreadful Gladiator's Armplates of Proficiency -- 137791
	recipe = AddRecipe(137791, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetCraftedItem(93547, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.DK, F.PALADIN, F.WARRIOR)
	recipe:AddDiscovery("DISCOVERY_BS_PANDARIA")

	-- Crafted Dreadful Gladiator's Armplates of Alacrity -- 137792
	recipe = AddRecipe(137792, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetCraftedItem(93546, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.DK, F.PALADIN, F.WARRIOR)
	recipe:AddDiscovery("DISCOVERY_BS_PANDARIA")

	-- Crafted Dreadful Gladiator's Plate Chestpiece -- 137793
	recipe = AddRecipe(137793, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetCraftedItem(93620, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.WARRIOR)
	recipe:AddDiscovery("DISCOVERY_BS_PANDARIA")

	-- Crafted Dreadful Gladiator's Plate Gauntlets -- 137794
	recipe = AddRecipe(137794, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetCraftedItem(93621, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.WARRIOR)
	recipe:AddDiscovery("DISCOVERY_BS_PANDARIA")

	-- Crafted Dreadful Gladiator's Plate Helm -- 137795
	recipe = AddRecipe(137795, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetCraftedItem(93622, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.WARRIOR)
	recipe:AddDiscovery("DISCOVERY_BS_PANDARIA")

	-- Crafted Dreadful Gladiator's Plate Legguards -- 137796
	recipe = AddRecipe(137796, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetCraftedItem(93623, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.WARRIOR)
	recipe:AddDiscovery("DISCOVERY_BS_PANDARIA")

	-- Crafted Dreadful Gladiator's Plate Shoulders -- 137797
	recipe = AddRecipe(137797, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetCraftedItem(93544, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.WARRIOR)
	recipe:AddDiscovery("DISCOVERY_BS_PANDARIA")

	-- Lightning Steel Ingot -- 138646
	recipe = AddRecipe(138646, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(500, 500, 605, 610, 615)
	recipe:SetRecipeItem(94552, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(94111, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_MATERIALS")
	recipe:AddMobDrop(69461)

	-- The Planar Edge, Reborn -- 138876
	recipe = AddRecipe(138876, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(500, 500, 605, 610, 615)
	recipe:SetRecipeItem(94570, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(94575, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_AXE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddMobDrop(69461)

	-- Lunar Crescent, Reborn -- 138877
	recipe = AddRecipe(138877, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(500, 500, 605, 610, 615)
	recipe:SetRecipeItem(94569, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(94576, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_AXE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddMobDrop(69461)

	-- Black Planar Edge, Reborn -- 138878
	recipe = AddRecipe(138878, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(94577, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_AXE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddDiscovery("DISCOVERY_BS_WEAP_PANDARIA")

	-- Mooncleaver, Reborn -- 138879
	recipe = AddRecipe(138879, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(94578, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_AXE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddDiscovery("DISCOVERY_BS_WEAP_PANDARIA")

	-- Wicked Edge of the Planes, Reborn -- 138880
	recipe = AddRecipe(138880, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(94579, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_AXE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddDiscovery("DISCOVERY_BS_WEAP_PANDARIA")

	-- Bloodmoon, Reborn -- 138881
	recipe = AddRecipe(138881, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(94580, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_AXE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddDiscovery("DISCOVERY_BS_WEAP_PANDARIA")

	-- Drakefist Hammer, Reborn -- 138882
	recipe = AddRecipe(138882, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(500, 500, 605, 610, 615)
	recipe:SetRecipeItem(94568, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(94581, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_MACE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddMobDrop(69461)

	-- Thunder, Reborn -- 138883
	recipe = AddRecipe(138883, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(500, 500, 605, 610, 615)
	recipe:SetRecipeItem(94567, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(94582, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_MACE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddMobDrop(69461)

	-- Deep Thunder, Reborn -- 138884
	recipe = AddRecipe(138884, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(94583, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_MACE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddDiscovery("DISCOVERY_BS_WEAP_PANDARIA")

	-- Dragonmaw, Reborn -- 138885
	recipe = AddRecipe(138885, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(94584, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_MACE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddDiscovery("DISCOVERY_BS_WEAP_PANDARIA")

	-- Dragonstrike, Reborn -- 138886
	recipe = AddRecipe(138886, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(94585, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_MACE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddDiscovery("DISCOVERY_BS_WEAP_PANDARIA")

	-- Stormherald, Reborn -- 138887
	recipe = AddRecipe(138887, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(94586, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_MACE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddDiscovery("DISCOVERY_BS_WEAP_PANDARIA")

	-- Fireguard, Reborn -- 138888
	recipe = AddRecipe(138888, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(500, 500, 605, 610, 615)
	recipe:SetRecipeItem(94572, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(94587, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_SWORD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddMobDrop(69461)

	-- Lionheart Blade, Reborn -- 138889
	recipe = AddRecipe(138889, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(500, 500, 605, 610, 615)
	recipe:SetRecipeItem(94571, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(94588, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_SWORD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddMobDrop(69461)

	-- Blazeguard, Reborn -- 138890
	recipe = AddRecipe(138890, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(94589, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_SWORD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddDiscovery("DISCOVERY_BS_WEAP_PANDARIA")

	-- Lionheart Champion, Reborn -- 138891
	recipe = AddRecipe(138891, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(94590, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_SWORD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddDiscovery("DISCOVERY_BS_WEAP_PANDARIA")

	-- Blazefury, Reborn -- 138892
	recipe = AddRecipe(138892, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(94591, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_SWORD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddDiscovery("DISCOVERY_BS_WEAP_PANDARIA")

	-- Lionheart Executioner, Reborn -- 138893
	recipe = AddRecipe(138893, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(94592, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_SWORD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddDiscovery("DISCOVERY_BS_WEAP_PANDARIA")

	-- Crafted Dreadful Gladiator's Scaled Chestpiece -- 140841
	recipe = AddRecipe(140841, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(93527, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.PALADIN)
	recipe:AddDiscovery("DISCOVERY_BS_PANDARIA")

	-- Crafted Dreadful Gladiator's Dreadplate Shoulders -- 140842
	recipe = AddRecipe(140842, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(93457, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.DK)
	recipe:AddDiscovery("DISCOVERY_BS_PANDARIA")

	-- Crafted Dreadful Gladiator's Dreadplate Legguards -- 140843
	recipe = AddRecipe(140843, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(93456, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.DK)
	recipe:AddDiscovery("DISCOVERY_BS_PANDARIA")

	-- Crafted Dreadful Gladiator's Dreadplate Helm -- 140844
	recipe = AddRecipe(140844, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(93455, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.DK)
	recipe:AddDiscovery("DISCOVERY_BS_PANDARIA")

	-- Crafted Dreadful Gladiator's Dreadplate Gauntlets -- 140845
	recipe = AddRecipe(140845, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(93454, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.DK)
	recipe:AddDiscovery("DISCOVERY_BS_PANDARIA")

	-- Crafted Dreadful Gladiator's Dreadplate Chestpiece -- 140846
	recipe = AddRecipe(140846, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(93453, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.DK)
	recipe:AddDiscovery("DISCOVERY_BS_PANDARIA")

	-- Blessed Trillium Greaves -- 142954
	recipe = AddRecipe(142954, V.MOP, Q.RARE)
	recipe:SetSkillLevels(600, 600, 605, 611, 618)
	recipe:SetRecipeItem(100865, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(98602, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddDiscovery("DISCOVERY_BS_INGOT_PANDARIA")

	-- Protector's Trillium Legguards -- 142958
	recipe = AddRecipe(142958, V.MOP, Q.RARE)
	recipe:SetSkillLevels(600, 600, 605, 611, 618)
	recipe:SetRecipeItem(100865, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(98606, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddDiscovery("DISCOVERY_BS_INGOT_PANDARIA")

	-- Avenger's Trillium Legplates -- 142959
	recipe = AddRecipe(142959, V.MOP, Q.RARE)
	recipe:SetSkillLevels(600, 600, 605, 611, 618)
	recipe:SetRecipeItem(100865, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(98607, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddDiscovery("DISCOVERY_BS_INGOT_PANDARIA")

	-- Blessed Trillium Belt -- 142963
	recipe = AddRecipe(142963, V.MOP, Q.RARE)
	recipe:SetSkillLevels(600, 600, 605, 611, 618)
	recipe:SetRecipeItem(100865, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(98611, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddDiscovery("DISCOVERY_BS_INGOT_PANDARIA")

	-- Protector's Trillium Waistguard -- 142967
	recipe = AddRecipe(142967, V.MOP, Q.RARE)
	recipe:SetSkillLevels(600, 600, 605, 611, 618)
	recipe:SetRecipeItem(100865, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(98615, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddDiscovery("DISCOVERY_BS_INGOT_PANDARIA")

	-- Avenger's Trillium Waistplate -- 142968
	recipe = AddRecipe(142968, V.MOP, Q.RARE)
	recipe:SetSkillLevels(600, 600, 605, 611, 618)
	recipe:SetRecipeItem(100865, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(98616, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddDiscovery("DISCOVERY_BS_INGOT_PANDARIA")

	-- Crafted Malevolent Gladiator's Dreadplate Chestpiece -- 143163
	recipe = AddRecipe(143163, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 603, 606)
	recipe:SetCraftedItem(98784, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.DK)
	recipe:AddDiscovery("DISCOVERY_BS_INGOT_PANDARIA")

	-- Crafted Malevolent Gladiator's Dreadplate Gauntlets -- 143164
	recipe = AddRecipe(143164, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 603, 606)
	recipe:SetCraftedItem(98785, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.DK)
	recipe:AddDiscovery("DISCOVERY_BS_INGOT_PANDARIA")

	-- Crafted Malevolent Gladiator's Dreadplate Helm -- 143165
	recipe = AddRecipe(143165, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 603, 606)
	recipe:SetCraftedItem(98786, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.DK)
	recipe:AddDiscovery("DISCOVERY_BS_INGOT_PANDARIA")

	-- Crafted Malevolent Gladiator's Dreadplate Legguards -- 143166
	recipe = AddRecipe(143166, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 603, 606)
	recipe:SetCraftedItem(98787, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.DK)
	recipe:AddDiscovery("DISCOVERY_BS_INGOT_PANDARIA")

	-- Crafted Malevolent Gladiator's Dreadplate Shoulders -- 143167
	recipe = AddRecipe(143167, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 603, 606)
	recipe:SetCraftedItem(98788, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.DK)
	recipe:AddDiscovery("DISCOVERY_BS_INGOT_PANDARIA")

	-- Crafted Malevolent Gladiator's Scaled Chestpiece -- 143168
	recipe = AddRecipe(143168, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 603, 606)
	recipe:SetCraftedItem(98843, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.PALADIN)
	recipe:AddDiscovery("DISCOVERY_BS_INGOT_PANDARIA")

	-- Crafted Malevolent Gladiator's Scaled Gauntlets -- 143169
	recipe = AddRecipe(143169, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 603, 606)
	recipe:SetCraftedItem(98844, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.PALADIN)
	recipe:AddDiscovery("DISCOVERY_BS_INGOT_PANDARIA")

	-- Crafted Malevolent Gladiator's Scaled Helm -- 143170
	recipe = AddRecipe(143170, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 603, 606)
	recipe:SetCraftedItem(98845, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.PALADIN)
	recipe:AddDiscovery("DISCOVERY_BS_INGOT_PANDARIA")

	-- Crafted Malevolent Gladiator's Scaled Legguards -- 143171
	recipe = AddRecipe(143171, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 603, 606)
	recipe:SetCraftedItem(98846, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.PALADIN)
	recipe:AddDiscovery("DISCOVERY_BS_INGOT_PANDARIA")

	-- Crafted Malevolent Gladiator's Scaled Shoulders -- 143172
	recipe = AddRecipe(143172, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 603, 606)
	recipe:SetCraftedItem(98847, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.PALADIN)
	recipe:AddDiscovery("DISCOVERY_BS_INGOT_PANDARIA")

	-- Crafted Malevolent Gladiator's Clasp of Cruelty -- 143173
	recipe = AddRecipe(143173, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 603, 606)
	recipe:SetCraftedItem(98848, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.PALADIN)
	recipe:AddDiscovery("DISCOVERY_BS_INGOT_PANDARIA")

	-- Crafted Malevolent Gladiator's Clasp of Meditation -- 143174
	recipe = AddRecipe(143174, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 603, 606)
	recipe:SetCraftedItem(98849, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.PALADIN)
	recipe:AddDiscovery("DISCOVERY_BS_INGOT_PANDARIA")

	-- Crafted Malevolent Gladiator's Greaves of Alacrity -- 143175
	recipe = AddRecipe(143175, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 603, 606)
	recipe:SetCraftedItem(98850, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.PALADIN)
	recipe:AddDiscovery("DISCOVERY_BS_INGOT_PANDARIA")

	-- Crafted Malevolent Gladiator's Greaves of Meditation -- 143176
	recipe = AddRecipe(143176, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 603, 606)
	recipe:SetCraftedItem(98851, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.PALADIN)
	recipe:AddDiscovery("DISCOVERY_BS_INGOT_PANDARIA")

	-- Crafted Malevolent Gladiator's Bracers of Prowess -- 143177
	recipe = AddRecipe(143177, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 603, 606)
	recipe:SetCraftedItem(98852, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.PALADIN)
	recipe:AddDiscovery("DISCOVERY_BS_INGOT_PANDARIA")

	-- Crafted Malevolent Gladiator's Bracers of Meditation -- 143178
	recipe = AddRecipe(143178, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 603, 606)
	recipe:SetCraftedItem(98853, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.PALADIN)
	recipe:AddDiscovery("DISCOVERY_BS_INGOT_PANDARIA")

	-- Crafted Malevolent Gladiator's Ornamented Chestguard -- 143179
	recipe = AddRecipe(143179, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 603, 606)
	recipe:SetCraftedItem(98854, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.PALADIN)
	recipe:AddDiscovery("DISCOVERY_BS_INGOT_PANDARIA")

	-- Crafted Malevolent Gladiator's Ornamented Gloves -- 143180
	recipe = AddRecipe(143180, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 603, 606)
	recipe:SetCraftedItem(98855, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.PALADIN)
	recipe:AddDiscovery("DISCOVERY_BS_INGOT_PANDARIA")

	-- Crafted Malevolent Gladiator's Ornamented Headcover -- 143181
	recipe = AddRecipe(143181, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 603, 606)
	recipe:SetCraftedItem(98856, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.PALADIN)
	recipe:AddDiscovery("DISCOVERY_BS_INGOT_PANDARIA")

	-- Crafted Malevolent Gladiator's Ornamented Legplates -- 143182
	recipe = AddRecipe(143182, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 603, 606)
	recipe:SetCraftedItem(98857, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.PALADIN)
	recipe:AddDiscovery("DISCOVERY_BS_INGOT_PANDARIA")

	-- Crafted Malevolent Gladiator's Ornamented Spaulders -- 143183
	recipe = AddRecipe(143183, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 603, 606)
	recipe:SetCraftedItem(98858, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.PALADIN)
	recipe:AddDiscovery("DISCOVERY_BS_INGOT_PANDARIA")

	-- Crafted Malevolent Gladiator's Girdle of Accuracy -- 143184
	recipe = AddRecipe(143184, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 603, 606)
	recipe:SetCraftedItem(98859, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.DK, F.PALADIN, F.WARRIOR)
	recipe:AddDiscovery("DISCOVERY_BS_INGOT_PANDARIA")

	-- Crafted Malevolent Gladiator's Girdle of Prowess -- 143185
	recipe = AddRecipe(143185, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 603, 606)
	recipe:SetCraftedItem(98860, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.DK, F.PALADIN, F.WARRIOR)
	recipe:AddDiscovery("DISCOVERY_BS_INGOT_PANDARIA")

	-- Crafted Malevolent Gladiator's Warboots of Cruelty -- 143186
	recipe = AddRecipe(143186, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 603, 606)
	recipe:SetCraftedItem(98861, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.DK, F.PALADIN, F.WARRIOR)
	recipe:AddDiscovery("DISCOVERY_BS_INGOT_PANDARIA")

	-- Crafted Malevolent Gladiator's Warboots of Alacrity -- 143187
	recipe = AddRecipe(143187, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 603, 606)
	recipe:SetCraftedItem(98862, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.DK, F.PALADIN, F.WARRIOR)
	recipe:AddDiscovery("DISCOVERY_BS_INGOT_PANDARIA")

	-- Crafted Malevolent Gladiator's Armplates of Proficiency -- 143188
	recipe = AddRecipe(143188, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 603, 606)
	recipe:SetCraftedItem(98863, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.DK, F.PALADIN, F.WARRIOR)
	recipe:AddDiscovery("DISCOVERY_BS_INGOT_PANDARIA")

	-- Crafted Malevolent Gladiator's Armplates of Alacrity -- 143189
	recipe = AddRecipe(143189, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 603, 606)
	recipe:SetCraftedItem(98864, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.DK, F.PALADIN, F.WARRIOR)
	recipe:AddDiscovery("DISCOVERY_BS_INGOT_PANDARIA")

	-- Crafted Malevolent Gladiator's Plate Chestpiece -- 143190
	recipe = AddRecipe(143190, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 603, 606)
	recipe:SetCraftedItem(98926, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.WARRIOR)
	recipe:AddDiscovery("DISCOVERY_BS_INGOT_PANDARIA")

	-- Crafted Malevolent Gladiator's Plate Gauntlets -- 143191
	recipe = AddRecipe(143191, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 603, 606)
	recipe:SetCraftedItem(98927, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.WARRIOR)
	recipe:AddDiscovery("DISCOVERY_BS_INGOT_PANDARIA")

	-- Crafted Malevolent Gladiator's Plate Helm -- 143192
	recipe = AddRecipe(143192, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 603, 606)
	recipe:SetCraftedItem(98928, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.WARRIOR)
	recipe:AddDiscovery("DISCOVERY_BS_INGOT_PANDARIA")

	-- Crafted Malevolent Gladiator's Plate Legguards -- 143193
	recipe = AddRecipe(143193, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 603, 606)
	recipe:SetCraftedItem(98929, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.WARRIOR)
	recipe:AddDiscovery("DISCOVERY_BS_INGOT_PANDARIA")

	-- Crafted Malevolent Gladiator's Plate Shoulders -- 143194
	recipe = AddRecipe(143194, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 603, 606)
	recipe:SetCraftedItem(98930, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.WARRIOR)
	recipe:AddDiscovery("DISCOVERY_BS_INGOT_PANDARIA")

	-- Crafted Malevolent Gladiator's Barrier -- 143195
	recipe = AddRecipe(143195, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 603, 606)
	recipe:SetCraftedItem(98776, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHIELD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddDiscovery("DISCOVERY_BS_INGOT_PANDARIA")

	-- Crafted Malevolent Gladiator's Redoubt -- 143196
	recipe = AddRecipe(143196, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 603, 606)
	recipe:SetCraftedItem(98810, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHIELD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddDiscovery("DISCOVERY_BS_INGOT_PANDARIA")

	-- Crafted Malevolent Gladiator's Shield Wall -- 143197
	recipe = AddRecipe(143197, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 603, 606)
	recipe:SetCraftedItem(98920, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHIELD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddDiscovery("DISCOVERY_BS_INGOT_PANDARIA")

	-- Balanced Trillium Ingot -- 143255
	recipe = AddRecipe(143255, V.MOP, Q.RARE)
	recipe:SetSkillLevels(600, 600, 605, 610, 616)
	recipe:SetRecipeItem(100865, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(98717, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_MATERIALS")
	recipe:AddWorldDrop(Z.PANDARIA)

	-- Accelerated Balanced Trillium Ingot -- 146921
	recipe = AddRecipe(146921, V.MOP, Q.RARE)
	recipe:SetSkillLevels(600, 600, 605, 610, 616)
	recipe:SetRecipeItem(100865, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(98717, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_MATERIALS")
	recipe:AddDiscovery("DISCOVERY_BS_INGOT_PANDARIA")

	-- Relic of the Past I -- 330159
	recipe = AddRecipe(330159, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(180055, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_MATERIALS")
	recipe:AddMixed(64058, 64085)

	-- Relic of the Past II -- 330160
	recipe = AddRecipe(330160, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(180057, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_MATERIALS")
	recipe:AddMixed(64058, 64085)

	-- Relic of the Past III -- 330161
	recipe = AddRecipe(330161, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(180058, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_MATERIALS")
	recipe:AddMixed(64058, 64085)

	-- Relic of the Past IV -- 330162
	recipe = AddRecipe(330162, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(180059, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_MATERIALS")
	recipe:AddMixed(64058, 64085)

	-- Relic of the Past V -- 330163
	recipe = AddRecipe(330163, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(180060, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_MATERIALS")
	recipe:AddMixed(64058, 64085)

	-- ----------------------------------------------------------------------------
	-- Warlords of Draenor.
	-- ----------------------------------------------------------------------------
	-- Truesteel Ingot -- 171690
	recipe = AddRecipe(171690, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 1, 50, 100)
	recipe:SetCraftedItem(108257, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_MATERIALS")
	recipe:AddCustom("DRAENOR_DEFAULT")

	-- Smoldering Helm -- 171691
	recipe = AddRecipe(171691, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 50, 55, 60)
	recipe:SetRecipeItem(116726, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(116426, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddCustom("DRAENOR_DEFAULT")

	-- Smoldering Breastplate -- 171692
	recipe = AddRecipe(171692, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 50, 55, 60)
	recipe:SetRecipeItem(116727, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(116427, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddCustom("DRAENOR_DEFAULT")

	-- Smoldering Greaves -- 171693
	recipe = AddRecipe(171693, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 50, 55, 60)
	recipe:SetRecipeItem(116728, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(116425, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddCustom("DRAENOR_DEFAULT")

	-- Steelforged Greataxe -- 171694
	recipe = AddRecipe(171694, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 100, 100, 100)
	recipe:SetRecipeItem(116729, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(116453, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_AXE")
	recipe:AddFilters(F.DPS)
	recipe:AddVendor(77359, 79867, 87062, 87550)

	-- Steelforged Saber -- 171695
	recipe = AddRecipe(171695, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 100, 100, 100)
	recipe:SetRecipeItem(116730, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(116454, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_SWORD")
	recipe:AddFilters(F.DPS)
	recipe:AddVendor(77359, 79867, 87062, 87550)

	-- Steelforged Dagger -- 171696
	recipe = AddRecipe(171696, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 100, 100, 100)
	recipe:SetRecipeItem(116731, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(116644, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_DAGGER")
	recipe:AddFilters(F.DPS)
	recipe:AddVendor(77359, 79867, 87062, 87550)

	-- Steelforged Hammer -- 171697
	recipe = AddRecipe(171697, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 100, 100, 100)
	recipe:SetRecipeItem(116732, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(116646, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_MACE")
	recipe:AddFilters(F.DPS)
	recipe:AddVendor(77359, 79867, 87062, 87550)

	-- Steelforged Shield -- 171698
	recipe = AddRecipe(171698, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 100, 100, 100)
	recipe:SetRecipeItem(116733, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(116647, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHIELD")
	recipe:AddFilters(F.DPS)
	recipe:AddVendor(77359, 79867, 87062, 87550)

	-- Truesteel Grinder -- 171699
	recipe = AddRecipe(171699, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 100, 100, 100)
	recipe:SetRecipeItem(116734, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(116654, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ITEM_ENHANCEMENT")
	recipe:AddVendor(77359, 79867, 87062, 87550)

	-- Truesteel Pauldrons -- 171700
	recipe = AddRecipe(171700, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 100, 100, 101)
	recipe:SetRecipeItem(116735, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(114231, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(77359, 79867, 87062, 87550)

	-- Truesteel Helm -- 171701
	recipe = AddRecipe(171701, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 100, 100, 101)
	recipe:SetRecipeItem(116736, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(114230, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(77359, 79867, 87062, 87550)

	-- Truesteel Greaves -- 171702
	recipe = AddRecipe(171702, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 100, 100, 101)
	recipe:SetRecipeItem(116737, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(114234, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(77359, 79867, 87062, 87550)

	-- Truesteel Gauntlets -- 171703
	recipe = AddRecipe(171703, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 100, 100, 101)
	recipe:SetRecipeItem(116738, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(114237, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(77359, 79867, 87062, 87550)

	-- Truesteel Breastplate -- 171704
	recipe = AddRecipe(171704, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 100, 100, 101)
	recipe:SetRecipeItem(116739, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(116739, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(77359, 79867, 87062, 87550)

	-- Truesteel Armguards -- 171705
	recipe = AddRecipe(171705, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 100, 100, 101)
	recipe:SetRecipeItem(116740, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(114236, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(77359, 79867, 87062, 87550)

	-- Truesteel Boots -- 171706
	recipe = AddRecipe(171706, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 100, 100, 101)
	recipe:SetRecipeItem(116741, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(114235, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(77359, 79867, 87062, 87550)

	-- Truesteel Waistguard -- 171707
	recipe = AddRecipe(171707, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 100, 100, 101)
	recipe:SetRecipeItem(116742, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(114233, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(77359, 79867, 87062, 87550)

	-- Truesteel Reshaper -- 173355
	recipe = AddRecipe(173355, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 100, 100, 101)
	recipe:SetRecipeItem(118044, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(116428, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ITEM_ENHANCEMENT")
	recipe:AddVendor(77359, 79867, 87062, 87550)

	-- Secrets of Draenor Blacksmithing -- 176090
	recipe = AddRecipe(176090, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 1, 50, 100)
	recipe:SetCraftedItem(118720, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_CREATED_ITEM")
	recipe:AddCustom("DRAENOR_DEFAULT")

	-- Soul of the Forge -- 177169
	recipe = AddRecipe(177169, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 600, 650, 700)
	recipe:SetRecipeItem(119329, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(119328, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_CREATED_ITEM")
	recipe:AddVendor(77359, 79867, 87062, 87550)

	-- Steelforged Axe -- 178243
	recipe = AddRecipe(178243, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 100, 100, 100)
	recipe:SetRecipeItem(120260, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(120259, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_AXE")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(77359, 79867, 87062, 87550)

	-- Steelforged Aegis -- 178245
	recipe = AddRecipe(178245, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 100, 100, 100)
	recipe:SetRecipeItem(120262, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(120261, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHIELD")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(77359, 79867, 87062, 87550)

	-- Riddle of Truesteel -- 182116
	recipe = AddRecipe(182116, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 100, 100, 100)
	recipe:SetRecipeItem(122705, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(108257, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_CREATED_ITEM")
	recipe:AddVendor(90894, 91030)

	-- Relic of the Past I -- 330164
	recipe = AddRecipe(330164, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(180055, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_MATERIALS")
	recipe:AddCustom("DEFAULT_RECIPE")

	-- Relic of the Past II -- 330165
	recipe = AddRecipe(330165, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(180057, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_MATERIALS")
	recipe:AddCustom("DEFAULT_RECIPE")

	-- Relic of the Past III -- 330166
	recipe = AddRecipe(330166, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(180058, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_MATERIALS")
	recipe:AddCustom("DEFAULT_RECIPE")

	-- Relic of the Past IV -- 330167
	recipe = AddRecipe(330167, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(180059, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_MATERIALS")
	recipe:AddCustom("DEFAULT_RECIPE")

	-- Relic of the Past V -- 330168
	recipe = AddRecipe(330168, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(180060, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_MATERIALS")
	recipe:AddCustom("DEFAULT_RECIPE")

	-- ----------------------------------------------------------------------------
	-- Legion.
	-- ----------------------------------------------------------------------------
	-- Leystone Armguards -- 182928
	recipe = AddRecipe(182928, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 20, 30, 40)
	recipe:SetRecipeItem(123899, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(123898, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddQuest(39681)

	-- Leystone Waistguard -- 182929
	recipe = AddRecipe(182929, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 20, 30, 40)
	recipe:SetRecipeItem(123900, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(123897, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddQuest(39681)

	-- Leystone Pauldrons -- 182930
	recipe = AddRecipe(182930, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 20, 30, 40)
	recipe:SetRecipeItem(123901, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(123896, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHOULDER")
	recipe:AddQuest(38501)

	-- Leystone Greaves -- 182931
	recipe = AddRecipe(182931, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 20, 30, 40)
	recipe:SetRecipeItem(123902, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(123895, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddQuest(38500)

	-- Leystone Helm -- 182932
	recipe = AddRecipe(182932, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 20, 30, 40)
	recipe:SetRecipeItem(123903, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(123894, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddQuest(38500)

	-- Leystone Gauntlets -- 182933
	recipe = AddRecipe(182933, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 20, 30, 40)
	recipe:SetRecipeItem(123904, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(123893, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddQuest(38500)

	-- Leystone Boots -- 182934
	recipe = AddRecipe(182934, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 20, 30, 40)
	recipe:SetRecipeItem(123905, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(123892, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddQuest(38500)

	-- Leystone Breastplate -- 182935
	recipe = AddRecipe(182935, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 20, 30, 40)
	recipe:SetRecipeItem(1239065, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(123891, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddQuest(38501)

	-- Demonsteel Armguards -- 182944
	recipe = AddRecipe(182944, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 60, 70, 80)
	recipe:SetRecipeItem(123920, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(123917, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddQuest(38533)

	-- Demonsteel Waistguard -- 182945
	recipe = AddRecipe(182945, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 60, 70, 80)
	recipe:SetRecipeItem(123921, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(123916, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddVendor(92265)

	-- Demonsteel Pauldrons -- 182946
	recipe = AddRecipe(182946, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 60, 70, 80)
	recipe:SetRecipeItem(123922, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(123915, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHOULDER")
	recipe:AddVendor(92265)

	-- Demonsteel Greaves -- 182947
	recipe = AddRecipe(182947, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 60, 70, 80)
	recipe:SetRecipeItem(123923, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(123914, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddVendor(92265)

	-- Demonsteel Helm -- 182948
	recipe = AddRecipe(182948, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 60, 70, 80)
	recipe:SetRecipeItem(123924, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(123913, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddVendor(92265)

	-- Demonsteel Gauntlets -- 182949
	recipe = AddRecipe(182949, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 60, 70, 80)
	recipe:SetRecipeItem(123925, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(123912, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddVendor(92265)

	-- Demonsteel Boots -- 182950
	recipe = AddRecipe(182950, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 60, 70, 80)
	recipe:SetRecipeItem(123926, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(123911, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddVendor(92265)

	-- Demonsteel Breastplate -- 182951
	recipe = AddRecipe(182951, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 60, 70, 80)
	recipe:SetRecipeItem(123927, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(123910, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddVendor(92265)

	-- Leystone Armguards -- 182962
	recipe = AddRecipe(182962, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 40, 50, 60)
	recipe:SetRecipeItem(123928, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(123898, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddQuest(38528)
	recipe:AddVendor(92184)

	-- Leystone Waistguard -- 182963
	recipe = AddRecipe(182963, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 720, 730, 740)
	recipe:SetRecipeItem(123929, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(123897, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddQuest(39680)
	recipe:AddVendor(107760)

	-- Leystone Pauldrons -- 182964
	recipe = AddRecipe(182964, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 720, 730, 740)
	recipe:SetRecipeItem(123930, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(123896, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHOULDER")
	recipe:AddQuest(38531)
	recipe:AddVendor(92184)

	-- Leystone Greaves -- 182965
	recipe = AddRecipe(182965, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 720, 730, 740)
	recipe:SetRecipeItem(137680, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(123895, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddQuest(38519)
	recipe:AddVendor(92184)

	-- Leystone Helm -- 182966
	recipe = AddRecipe(182966, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 720, 730, 740)
	recipe:SetRecipeItem(123932, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(123894, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddQuest(38531)
	recipe:AddVendor(92184)

	-- Leystone Gauntlets -- 182967
	recipe = AddRecipe(182967, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 720, 730, 740)
	recipe:SetRecipeItem(123933, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(123893, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddQuest(39699)
	recipe:AddVendor(92184)

	-- Leystone Boots -- 182968
	recipe = AddRecipe(182968, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 720, 730, 740)
	recipe:SetRecipeItem(123934, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(123892, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddQuest(38526)
	recipe:AddVendor(92184)

	-- Leystone Breastplate -- 182969
	recipe = AddRecipe(182969, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 720, 730, 740)
	recipe:SetRecipeItem(123935, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(123891, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddQuest(44449)
	recipe:AddVendor(92184)

	-- Leystone Armguards -- 182970
	recipe = AddRecipe(182970, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 740, 750, 760)
	recipe:SetRecipeItem(123936, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(123898, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddQuest(41634)

	-- Leystone Waistguard -- 182971
	recipe = AddRecipe(182971, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 740, 750, 760)
	recipe:SetRecipeItem(123937, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(123897, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddVendor(107760)

	-- Leystone Pauldrons -- 182972
	recipe = AddRecipe(182972, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 740, 750, 760)
	recipe:SetRecipeItem(123938, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(123896, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHOULDER")
	recipe:AddQuest(41637)

	-- Leystone Breastplate -- 182973
	recipe = AddRecipe(182973, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 740, 750, 760)
	recipe:SetRecipeItem(123939, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(123891, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddQuest(41636)

	-- Demonsteel Armguards -- 182974
	recipe = AddRecipe(182974, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 760, 770, 780)
	recipe:SetRecipeItem(123940, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(123917, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddQuest(38534)

	-- Demonsteel Waistguard -- 182975
	recipe = AddRecipe(182975, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 760, 770, 780)
	recipe:SetRecipeItem(123941, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(123916, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddQuest(38536)

	-- Demonsteel Pauldrons -- 182976
	recipe = AddRecipe(182976, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 760, 770, 780)
	recipe:SetRecipeItem(123942, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(123915, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddQuest(38537)

	-- Demonsteel Greaves -- 182977
	recipe = AddRecipe(182977, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 760, 770, 780)
	recipe:SetRecipeItem(123943, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(123914, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddQuest(38541)

	-- Demonsteel Helm -- 182978
	recipe = AddRecipe(182978, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 760, 770, 780)
	recipe:SetRecipeItem(123944, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(123913, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddQuest(38541)

	-- Demonsteel Gauntlets -- 182979
	recipe = AddRecipe(182979, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 760, 770, 780)
	recipe:SetRecipeItem(123945, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(123912, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddQuest(38539)

	-- Demonsteel Boots -- 182980
	recipe = AddRecipe(182980, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 760, 770, 780)
	recipe:SetRecipeItem(123946, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(123911, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddQuest(38538)

	-- Demonsteel Breastplate -- 182981
	recipe = AddRecipe(182981, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 760, 770, 780)
	recipe:SetRecipeItem(123947, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(123910, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddQuest(38542)

	-- Demonsteel Armguards -- 182982
	recipe = AddRecipe(182982, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 760, 770, 780)
	recipe:SetRecipeItem(123948, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(123917, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddRepVendor(FAC.HIGHMOUNTAIN_TRIBE, REP.EXALTED, 106902)

	-- Demonsteel Waistguard -- 182983
	recipe = AddRecipe(182983, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 760, 770, 780)
	recipe:SetRecipeItem(123949, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(123916, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(107760)

	-- Demonsteel Pauldrons -- 182984
	recipe = AddRecipe(182984, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 760, 770, 780)
	recipe:SetRecipeItem(123950, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(123915, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddCustom("RATED_PVP")

	-- Demonsteel Greaves -- 182985
	recipe = AddRecipe(182985, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 760, 770, 780)
	recipe:SetRecipeItem(123951, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(123914, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddRepVendor(FAC.VALARJAR, REP.EXALTED, 106904)

	-- Demonsteel Helm -- 182986
	recipe = AddRecipe(182986, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 760, 770, 780)
	recipe:SetRecipeItem(123952, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(123913, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(106904)

	-- Demonsteel Gauntlets -- 182987
	recipe = AddRecipe(182987, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 760, 770, 780)
	recipe:SetRecipeItem(123953, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(123912, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddRepVendor(FAC.HIGHMOUNTAIN_TRIBE, REP.EXALTED, 106902)

	-- Demonsteel Boots -- 182988
	recipe = AddRecipe(182988, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 760, 770, 780)
	recipe:SetRecipeItem(123954, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(123911, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddRepVendor(FAC.VALARJAR, REP.EXALTED, 106904)

	-- Demonsteel Breastplate -- 182989
	recipe = AddRecipe(182989, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 760, 770, 780)
	recipe:SetRecipeItem(123955, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(123910, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddRepVendor(FAC.HIGHMOUNTAIN_TRIBE, REP.EXALTED, 106902)

	-- Leystone Hoofplates -- 182999
	recipe = AddRecipe(182999, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 712, 725)
	recipe:SetRecipeItem(123957, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(123956, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CREATED_ITEM")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddQuest(38523)

	-- Demonsteel Bar -- 184442
	recipe = AddRecipe(184442, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 740, 750, 760)
	recipe:SetRecipeItem(124462, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(124461, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_MATERIALS")
	recipe:AddQuest(38833)

	-- Leystone Boots -- 191928
	recipe = AddRecipe(191928, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 740, 747, 755)
	recipe:SetRecipeItem(137605, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(123892, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddQuest(41635)

	-- Leystone Helm -- 191929
	recipe = AddRecipe(191929, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 740, 750, 760)
	recipe:SetRecipeItem(137607, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(123894, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddCustom("SPOILS_OF_THE_WORTHY")

	-- Leystone Gauntlets -- 191930
	recipe = AddRecipe(191930, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 740, 750, 760)
	recipe:SetRecipeItem(137606, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(123893, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddQuest(41638)

	-- Leystone Greaves -- 191931
	recipe = AddRecipe(191931, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 740, 750, 760)
	recipe:SetRecipeItem(123931, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(123895, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddQuest(41633)

	-- Terrorspike -- 209496
	recipe = AddRecipe(209496, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 725, 750)
	recipe:SetRecipeItem(136696, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(136683, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_RELIC")
	recipe:AddCustom("WATERLOGGED_CACHE")

	-- Gleaming Iron Spike -- 209497
	recipe = AddRecipe(209497, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 725, 750)
	recipe:SetRecipeItem(136697, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(136684, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_RELIC")
	recipe:AddRepVendor(FAC.HIGHMOUNTAIN_TRIBE, REP.HONORED, 106902)

	-- Consecrated Spike -- 209498
	recipe = AddRecipe(209498, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 725, 750)
	recipe:SetRecipeItem(136698, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(136685, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_RELIC")
	recipe:AddRepVendor(FAC.VALARJAR, REP.HONORED, 106904)

	-- Flamespike -- 209499
	recipe = AddRecipe(209499, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 725, 750)
	recipe:SetRecipeItem(136699, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(136686, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_RELIC")
	recipe:AddVendor(107109)

	-- Demonsteel Stirrups -- 209564
	recipe = AddRecipe(209564, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 712, 715)
	recipe:SetRecipeItem(136709, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(136708, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CREATED_ITEM")
	recipe:AddWorldDrop(Z.BROKEN_ISLES)

	-- Fel Core Hound Harness -- 213916
	recipe = AddRecipe(213916, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(800, 800, 800, 800, 800)
	recipe:SetRecipeItem(137687, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(137686, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_MOUNT")
	recipe:AddFilters(F.RAID)
	recipe:AddMobDrop(103685)

	-- Rethu's Incessant Courage -- 239415
	recipe = AddRecipe(239415, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 110, 115, 120)
	recipe:SetCraftedItem(146667, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddTrainer(3355, 92183, 106655)

	-- Felslate Anchor -- 247700
	recipe = AddRecipe(247700, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 720, 732, 745)
	recipe:SetRecipeItem(151709, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(151239, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CREATED_ITEM")
	recipe:AddQuest(48053, 48054)

	-- Empyrial Breastplate -- 247710
	recipe = AddRecipe(247710, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 790, 795, 800)
	recipe:SetRecipeItem(151711, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(151576, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddQuest(48055)

	-- Empyrial Breastplate -- 247713
	recipe = AddRecipe(247713, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 790, 795, 800)
	recipe:SetRecipeItem(151712, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(151576, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddRepVendor(FAC.ARMY_OF_THE_LIGHT, REP.REVERED, 127120)

	-- Empyrial Breastplate -- 247714
	recipe = AddRecipe(247714, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 790, 795, 800)
	recipe:SetRecipeItem(151713, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(151576, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddMobDrop(123371)

	-- Relic of the Past I -- 330169
	recipe = AddRecipe(330169, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(180055, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_MATERIALS")
	recipe:AddCustom("DEFAULT_RECIPE")

	-- Relic of the Past II -- 330170
	recipe = AddRecipe(330170, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(180057, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_MATERIALS")
	recipe:AddCustom("DEFAULT_RECIPE")

	-- Relic of the Past III -- 330171
	recipe = AddRecipe(330171, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(180058, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_MATERIALS")
	recipe:AddCustom("DEFAULT_RECIPE")

	-- Relic of the Past IV -- 330172
	recipe = AddRecipe(330172, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(180059, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_MATERIALS")
	recipe:AddCustom("DEFAULT_RECIPE")

	-- Relic of the Past V -- 330173
	recipe = AddRecipe(330173, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(180060, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_MATERIALS")
	recipe:AddCustom("DEFAULT_RECIPE")

	-- ----------------------------------------------------------------------------
	-- Battle for Azeroth.
	-- ----------------------------------------------------------------------------
	-- Monel-Hardened Hoofplates -- 253110
	recipe = AddRecipe(253110, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(152812, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CREATED_ITEM")
	recipe:AddTrainer(127112, 133536, 153817, 154321)

	-- Monel-Hardened Stirrups -- 253112
	recipe = AddRecipe(253112, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(152813, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CREATED_ITEM")
	recipe:AddTrainer(127112, 133536, 153817, 154321)

	-- Monel-Hardened Shield -- 253113
	recipe = AddRecipe(253113, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(15, 15, 25, 30, 35)
	recipe:SetCraftedItem(152818, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHIELD")
	recipe:AddTrainer(127112, 133536, 153817, 154321)

	-- Stormsteel Shield -- 253116
	recipe = AddRecipe(253116, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(95, 95, 105, 110, 115)
	recipe:SetCraftedItem(152819, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHIELD")
	recipe:AddTrainer(127112, 133536, 153817, 154321)

	-- Stormsteel Shield -- 253117
	recipe = AddRecipe(253117, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(120, 120, 130, 135, 140)
	recipe:SetCraftedItem(152819, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHIELD")
	recipe:AddTrainer(127112, 133536, 153817, 154321)

	-- Stormsteel Shield -- 253118
	recipe = AddRecipe(253118, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(120, 120, 135, 142, 150)
	recipe:SetRecipeItem(162261, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(152819, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHIELD")
	recipe:AddRepVendor(FAC.SEVENTH_LEGION, REP.REVERED, 135446)
	recipe:AddRepVendor(FAC.THE_HONORBOUND, REP.REVERED, 135447)

	-- Monel-Hardened Cutlass -- 253125
	recipe = AddRecipe(253125, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(152827, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_SWORD")
	recipe:AddTrainer(127112, 133536, 153817, 154321)

	-- Monel-Hardened Deckpounder -- 253132
	recipe = AddRecipe(253132, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(152831, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_MACE")
	recipe:AddTrainer(127112, 133536, 153817, 154321)

	-- Monel-Hardened Claymore -- 253135
	recipe = AddRecipe(253135, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(152828, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_SWORD")
	recipe:AddTrainer(127112, 133536, 153817, 154321)

	-- Monel-Hardened Shanker -- 253138
	recipe = AddRecipe(253138, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(152832, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_DAGGER")
	recipe:AddTrainer(127112, 133536, 153817, 154321)

	-- Monel-Hardened Polearm -- 253141
	recipe = AddRecipe(253141, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(152833, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_POLEARM")
	recipe:AddTrainer(127112, 133536, 153817, 154321)

	-- Honorable Combatant's Spellblade -- 253144
	recipe = AddRecipe(253144, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 120, 132, 145)
	recipe:SetRecipeItem(162669, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(162652, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_DAGGER")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(142552, 142564)

	-- Khaz'gorian Smithing Hammer -- 253145
	recipe = AddRecipe(253145, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(150, 150, 150, 150, 150)
	recipe:SetRecipeItem(168022, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(152839, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_CREATED_ITEM")
	recipe:AddQuest(50123, 50276)

	-- Honorable Combatant's Spellblade -- 253149
	recipe = AddRecipe(253149, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 110, 122, 135)
	recipe:SetRecipeItem(162668, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(162652, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_DAGGER")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(142552, 142564)

	-- Stormsteel Dagger -- 253156
	recipe = AddRecipe(253156, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(95, 95, 105, 110, 115)
	recipe:SetCraftedItem(152835, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_DAGGER")
	recipe:AddTrainer(127112, 133536, 153817, 154321)

	-- Stormsteel Dagger -- 253157
	recipe = AddRecipe(253157, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(120, 120, 130, 135, 140)
	recipe:SetCraftedItem(152835, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_DAGGER")
	recipe:AddTrainer(127112, 133536, 153817, 154321)

	-- Stormsteel Dagger -- 253158
	recipe = AddRecipe(253158, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 135, 142, 150)
	recipe:SetRecipeItem(162275, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(152835, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_DAGGER")
	recipe:AddRepVendor(FAC.SEVENTH_LEGION, REP.REVERED, 135446)
	recipe:AddRepVendor(FAC.THE_HONORBOUND, REP.REVERED, 135447)

	-- Stormsteel Spear -- 253159
	recipe = AddRecipe(253159, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(95, 95, 105, 110, 115)
	recipe:SetCraftedItem(152834, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_POLEARM")
	recipe:AddTrainer(127112, 133536, 153817, 154321)

	-- Stormsteel Spear -- 253160
	recipe = AddRecipe(253160, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(120, 120, 130, 135, 140)
	recipe:SetCraftedItem(152834, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_POLEARM")
	recipe:AddTrainer(127112, 133536, 153817, 154321)

	-- Stormsteel Spear -- 253161
	recipe = AddRecipe(253161, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 135, 142, 150)
	recipe:SetRecipeItem(162276, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(152834, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_POLEARM")
	recipe:AddRepVendor(FAC.SEVENTH_LEGION, REP.REVERED, 135446)
	recipe:AddRepVendor(FAC.THE_HONORBOUND, REP.REVERED, 135447)

	-- Monel-Hardened Breastplate -- 253162
	recipe = AddRecipe(253162, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(35, 35, 45, 50, 55)
	recipe:SetCraftedItem(152802, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddTrainer(127112, 133536, 153817, 154321)

	-- Monel-Hardened Boots -- 253165
	recipe = AddRecipe(253165, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(15, 15, 25, 30, 35)
	recipe:SetCraftedItem(152803, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddTrainer(127112, 133536, 153817, 154321)

	-- Monel-Hardened Gauntlets -- 253168
	recipe = AddRecipe(253168, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 15, 32, 50)
	recipe:SetCraftedItem(152804, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddCustom("DEFAULT_RECIPE")

	-- Monel-Hardened Helm -- 253171
	recipe = AddRecipe(253171, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(15, 15, 25, 30, 35)
	recipe:SetCraftedItem(152805, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddTrainer(127112, 133536, 153817, 154321)

	-- Monel-Hardened Greaves -- 253174
	recipe = AddRecipe(253174, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(152806, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddTrainer(127112, 133536, 153817, 154321)

	-- Monel-Hardened Pauldrons -- 253177
	recipe = AddRecipe(253177, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(35, 35, 45, 50, 55)
	recipe:SetCraftedItem(152807, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHOULDER")
	recipe:AddTrainer(127112, 133536, 153817, 154321)

	-- Monel-Hardened Waistguard -- 253180
	recipe = AddRecipe(253180, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(15, 15, 25, 30, 35)
	recipe:SetCraftedItem(152808, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddTrainer(127112, 133536, 153817, 154321)

	-- Monel-Hardened Armguards -- 253183
	recipe = AddRecipe(253183, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 10, 17, 25)
	recipe:SetCraftedItem(152809, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddCustom("DEFAULT_RECIPE")

	-- Stormsteel Legguards -- 253186
	recipe = AddRecipe(253186, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(120, 120, 130, 135, 140)
	recipe:SetCraftedItem(161888, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddTrainer(127112, 133536, 153817, 154321)

	-- Imbued Stormsteel Legguards -- 253187
	recipe = AddRecipe(253187, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 150, 150, 150)
	recipe:SetCraftedItem(162491, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddDiscovery("DISCOVERY_BS_BFA")

	-- Emblazoned Stormsteel Legguards -- 253188
	recipe = AddRecipe(253188, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 150, 150, 150)
	recipe:SetCraftedItem(162464, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddDiscovery("DISCOVERY_BS_BFA")

	-- Stormsteel Girdle -- 253190
	recipe = AddRecipe(253190, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(120, 120, 130, 135, 140)
	recipe:SetCraftedItem(161889, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddTrainer(127112, 133536, 153817, 154321)

	-- Imbued Stormsteel Girdle -- 253191
	recipe = AddRecipe(253191, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 150, 150, 150)
	recipe:SetCraftedItem(162492, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddDiscovery("DISCOVERY_BS_BFA")

	-- Emblazoned Stormsteel Girdle -- 253192
	recipe = AddRecipe(253192, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 150, 150, 150)
	recipe:SetCraftedItem(162466, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddDiscovery("DISCOVERY_BS_BFA")

	-- Honorable Combatant's Spellblade -- 256786
	recipe = AddRecipe(256786, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 85, 90, 95)
	recipe:SetCraftedItem(162652, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_DAGGER")
	recipe:AddTrainer(127112, 133536, 153817, 154321)

	-- Monelite Reinforced Chassis -- 265937
	recipe = AddRecipe(265937, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(160, 160, 165, 170, 175)
	recipe:SetRecipeItem(169529, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(158887, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CREATED_ITEM")
	recipe:AddMobDrop(144246)

	-- Monelite Skeleton Key -- 269064
	recipe = AddRecipe(269064, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(159826, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SKELETON_KEY")
	recipe:AddTrainer(127112, 133536, 153817, 154321)

	-- Honorable Combatant's Plate Gauntlets -- 269421
	recipe = AddRecipe(269421, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 85, 90, 95)
	recipe:SetRecipeItem(162266, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(159861, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(127112, 133536, 153817, 154321)
	recipe:AddVendor(142564)

	-- Honorable Combatant's Plate Gauntlets -- 269422
	recipe = AddRecipe(269422, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 110, 122, 135)
	recipe:SetRecipeItem(162265, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(159861, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(142552, 142564)

	-- Honorable Combatant's Plate Gauntlets -- 269423
	recipe = AddRecipe(269423, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 120, 132, 145)
	recipe:SetRecipeItem(162266, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(159861, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddVendor(142552, 142564)

	-- Honorable Combatant's Plate Boots -- 269424
	recipe = AddRecipe(269424, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(95, 95, 105, 110, 115)
	recipe:SetCraftedItem(159860, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddTrainer(127112, 133536, 153817, 154321)

	-- Honorable Combatant's Plate Boots -- 269425
	recipe = AddRecipe(269425, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(95, 95, 120, 135, 150)
	recipe:SetRecipeItem(162262, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(159860, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(142552, 142564)

	-- Honorable Combatant's Plate Boots -- 269426
	recipe = AddRecipe(269426, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(95, 95, 130, 140, 150)
	recipe:SetRecipeItem(162263, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(159860, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(142552, 142564)

	-- Honorable Combatant's Plate Greaves -- 269444
	recipe = AddRecipe(269444, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(105, 105, 115, 120, 125)
	recipe:SetCraftedItem(159863, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddTrainer(127112, 133536, 153817, 154321)

	-- Honorable Combatant's Plate Greaves -- 269446
	recipe = AddRecipe(269446, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(105, 105, 125, 137, 150)
	recipe:SetRecipeItem(162267, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(159863, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(142552, 142564)

	-- Honorable Combatant's Plate Greaves -- 269447
	recipe = AddRecipe(269447, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(105, 105, 135, 142, 150)
	recipe:SetRecipeItem(162268, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(159863, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(142552, 142564)

	-- Honorable Combatant's Plate Waistguard -- 269448
	recipe = AddRecipe(269448, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(95, 95, 105, 110, 115)
	recipe:SetCraftedItem(159865, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddTrainer(127112, 133536, 153817, 154321)

	-- Honorable Combatant's Plate Waistguard -- 269449
	recipe = AddRecipe(269449, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(115, 115, 120, 135, 150)
	recipe:SetRecipeItem(162269, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(159865, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(142552, 142564)

	-- Honorable Combatant's Plate Waistguard -- 269450
	recipe = AddRecipe(269450, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(115, 115, 130, 140, 150)
	recipe:SetRecipeItem(162270, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(159865, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(142552, 142564)

	-- Honorable Combatant's Plate Armguards -- 269451
	recipe = AddRecipe(269451, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 85, 90, 95)
	recipe:SetCraftedItem(159866, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddTrainer(127112, 133536, 153817, 154321)

	-- Honorable Combatant's Plate Armguards -- 269452
	recipe = AddRecipe(269452, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 110, 122, 135)
	recipe:SetRecipeItem(162271, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(159866, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(142552, 142564)

	-- Honorable Combatant's Plate Armguards -- 269453
	recipe = AddRecipe(269453, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 120, 132, 145)
	recipe:SetRecipeItem(162272, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(159866, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(142552, 142564)

	-- Honorable Combatant's Shield -- 269458
	recipe = AddRecipe(269458, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(95, 95, 105, 110, 115)
	recipe:SetCraftedItem(159851, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHIELD")
	recipe:AddTrainer(127112, 133536, 153817, 154321)

	-- Honorable Combatant's Shield -- 269459
	recipe = AddRecipe(269459, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(95, 95, 120, 135, 150)
	recipe:SetRecipeItem(162273, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(159851, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHIELD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(142552, 142564)

	-- Honorable Combatant's Shield -- 269460
	recipe = AddRecipe(269460, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(95, 95, 130, 140, 150)
	recipe:SetRecipeItem(162274, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(159851, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHIELD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(142552, 142564)

	-- Honorable Combatant's Cutlass -- 269464
	recipe = AddRecipe(269464, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 85, 90, 95)
	recipe:SetCraftedItem(159853, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_SWORD")
	recipe:AddTrainer(127112, 133536, 153817, 154321)

	-- Honorable Combatant's Cutlass -- 269465
	recipe = AddRecipe(269465, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 110, 122, 135)
	recipe:SetRecipeItem(162277, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(159853, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_SWORD")
	recipe:AddFilters(F.DPS)
	recipe:AddVendor(142552, 142564)

	-- Honorable Combatant's Cutlass -- 269466
	recipe = AddRecipe(269466, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 120, 132, 145)
	recipe:SetRecipeItem(162278, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(159853, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_SWORD")
	recipe:AddFilters(F.DPS)
	recipe:AddVendor(142552, 142564)

	-- Honorable Combatant's Deckpounder -- 269470
	recipe = AddRecipe(269470, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(105, 105, 115, 120, 125)
	recipe:SetCraftedItem(159855, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_MACE")
	recipe:AddTrainer(127112, 133536, 153817, 154321)

	-- Honorable Combatant's Deckpounder -- 269471
	recipe = AddRecipe(269471, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(105, 105, 125, 137, 150)
	recipe:SetRecipeItem(162279, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(159855, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_MACE")
	recipe:AddFilters(F.DPS)
	recipe:AddVendor(142552, 142564)

	-- Honorable Combatant's Deckpounder -- 269472
	recipe = AddRecipe(269472, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(105, 105, 135, 142, 150)
	recipe:SetRecipeItem(162280, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(159855, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_MACE")
	recipe:AddFilters(F.DPS)
	recipe:AddVendor(142552, 142564)

	-- Honorable Combatant's Shanker -- 269476
	recipe = AddRecipe(269476, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 85, 90, 95)
	recipe:SetCraftedItem(159857, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_DAGGER")
	recipe:AddTrainer(127112, 133536, 153817, 154321)

	-- Honorable Combatant's Shanker -- 269477
	recipe = AddRecipe(269477, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 110, 122, 135)
	recipe:SetRecipeItem(162281, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(159857, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_DAGGER")
	recipe:AddFilters(F.DPS)
	recipe:AddVendor(142552, 142564)

	-- Honorable Combatant's Shanker -- 269478
	recipe = AddRecipe(269478, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 120, 132, 145)
	recipe:SetRecipeItem(162282, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(159857, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_DAGGER")
	recipe:AddFilters(F.DPS)
	recipe:AddVendor(142552, 142564)

	-- Honorable Combatant's Polearm -- 269479
	recipe = AddRecipe(269479, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(105, 105, 115, 120, 125)
	recipe:SetCraftedItem(159858, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_POLEARM")
	recipe:AddTrainer(127112, 133536, 153817, 154321)

	-- Honorable Combatant's Polearm -- 269480
	recipe = AddRecipe(269480, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(105, 105, 125, 137, 150)
	recipe:SetRecipeItem(162283, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(159858, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_POLEARM")
	recipe:AddFilters(F.DPS)
	recipe:AddVendor(142552, 142564)

	-- Honorable Combatant's Polearm -- 269481
	recipe = AddRecipe(269481, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(105, 105, 135, 142, 150)
	recipe:SetRecipeItem(162284, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(159858, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_POLEARM")
	recipe:AddFilters(F.DPS)
	recipe:AddVendor(142552, 142564)

	-- Stormsteel Saber -- 278131
	recipe = AddRecipe(278131, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(95, 95, 105, 110, 115)
	recipe:SetCraftedItem(162655, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_SWORD")
	recipe:AddTrainer(127112, 133536, 153817, 154321)

	-- Stormsteel Saber -- 278132
	recipe = AddRecipe(278132, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(120, 120, 130, 135, 140)
	recipe:SetCraftedItem(162655, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_SWORD")
	recipe:AddTrainer(127112, 133536, 153817, 154321)

	-- Stormsteel Saber -- 278133
	recipe = AddRecipe(278133, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(120, 120, 135, 142, 150)
	recipe:SetRecipeItem(162670, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(162655, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_SWORD")
	recipe:AddRepVendor(FAC.SEVENTH_LEGION, REP.REVERED, 135446)
	recipe:AddRepVendor(FAC.THE_HONORBOUND, REP.REVERED, 135447)

	-- Storm Silver Spurs -- 278415
	recipe = AddRecipe(278415, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(65, 65, 75, 80, 85)
	recipe:SetCraftedItem(165740, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CREATED_ITEM")
	recipe:AddTrainer(127112, 133536, 153817, 154321)

	-- Magnetic Mining Pick -- 278416
	recipe = AddRecipe(278416, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(65, 65, 75, 80, 85)
	recipe:SetCraftedItem(165746, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CREATED_ITEM")
	recipe:AddTrainer(127112, 133536, 153817, 154321)

	-- Platinum Whetstone -- 278417
	recipe = AddRecipe(278417, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(65, 65, 75, 80, 85)
	recipe:SetCraftedItem(165748, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CREATED_ITEM")
	recipe:AddTrainer(127112, 133536, 153817, 154321)

	-- Barbaric Iron Hauberk -- 280671
	recipe = AddRecipe(280671, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(155, 155, 165, 170, 175)
	recipe:SetCraftedItem(163964, "BIND_ON_EQUIP")
	recipe:AddTrainer(514, 2998, 3174, 3355, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16669, 16724, 17245, 37072, 44781, 45548)

	-- Sinister Combatant's Polearm -- 282859
	recipe = AddRecipe(282859, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(105, 105, 115, 120, 125)
	recipe:SetCraftedItem(164652, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_POLEARM")
	recipe:AddTrainer(127112, 133536, 153817, 154321)

	-- Sinister Combatant's Polearm -- 282860
	recipe = AddRecipe(282860, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(105, 105, 140, 145, 150)
	recipe:SetRecipeItem(165298, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(164652, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_POLEARM")
	recipe:AddFilters(F.DPS)
	recipe:AddVendor(142552, 142564)

	-- Sinister Combatant's Polearm -- 282861
	recipe = AddRecipe(282861, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(105, 105, 145, 147, 150)
	recipe:SetRecipeItem(165299, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(164652, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_POLEARM")
	recipe:AddFilters(F.DPS)
	recipe:AddVendor(142552, 142564)

	-- Sinister Combatant's Shanker -- 282862
	recipe = AddRecipe(282862, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(105, 105, 115, 120, 125)
	recipe:SetCraftedItem(164651, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_DAGGER")
	recipe:AddTrainer(127112, 133536, 153817, 154321)

	-- Sinister Combatant's Shanker -- 282863
	recipe = AddRecipe(282863, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(105, 105, 140, 145, 150)
	recipe:SetRecipeItem(165296, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(164651, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_DAGGER")
	recipe:AddFilters(F.DPS)
	recipe:AddVendor(142552, 142564)

	-- Sinister Combatant's Shanker -- 282864
	recipe = AddRecipe(282864, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(105, 105, 145, 147, 150)
	recipe:SetRecipeItem(165297, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(164651, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_DAGGER")
	recipe:AddFilters(F.DPS)
	recipe:AddVendor(142552, 142564)

	-- Sinister Combatant's Spellblade -- 282865
	recipe = AddRecipe(282865, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(105, 105, 115, 120, 125)
	recipe:SetCraftedItem(164719, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_DAGGER")
	recipe:AddTrainer(127112, 133536, 153817, 154321)

	-- Sinister Combatant's Spellblade -- 282866
	recipe = AddRecipe(282866, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(105, 105, 140, 145, 150)
	recipe:SetRecipeItem(165294, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(164719, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_DAGGER")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(142552, 142564)

	-- Sinister Combatant's Spellblade -- 282867
	recipe = AddRecipe(282867, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(105, 105, 145, 147, 150)
	recipe:SetRecipeItem(165295, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(164719, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_DAGGER")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(142552, 142564)

	-- Sinister Combatant's Deckpounder -- 282868
	recipe = AddRecipe(282868, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(105, 105, 115, 120, 125)
	recipe:SetCraftedItem(164650, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_MACE")
	recipe:AddTrainer(127112, 133536, 153817, 154321)

	-- Sinister Combatant's Deckpounder -- 282869
	recipe = AddRecipe(282869, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(105, 105, 140, 145, 150)
	recipe:SetRecipeItem(165292, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(164650, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_MACE")
	recipe:AddFilters(F.DPS)
	recipe:AddVendor(142552, 142564)

	-- Sinister Combatant's Deckpounder -- 282870
	recipe = AddRecipe(282870, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(105, 105, 145, 147, 150)
	recipe:SetRecipeItem(165293, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(164650, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_MACE")
	recipe:AddFilters(F.DPS)
	recipe:AddVendor(142552, 142564)

	-- Sinister Combatant's Cutlass -- 282871
	recipe = AddRecipe(282871, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(105, 105, 115, 120, 125)
	recipe:SetCraftedItem(164649, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_SWORD")
	recipe:AddTrainer(127112, 133536, 153817, 154321)

	-- Sinister Combatant's Cutlass -- 282872
	recipe = AddRecipe(282872, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(105, 105, 140, 145, 150)
	recipe:SetRecipeItem(165290, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(164649, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_SWORD")
	recipe:AddFilters(F.DPS)
	recipe:AddVendor(142552, 142564)

	-- Sinister Combatant's Cutlass -- 282873
	recipe = AddRecipe(282873, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(105, 105, 145, 147, 150)
	recipe:SetRecipeItem(165291, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(164649, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_SWORD")
	recipe:AddFilters(F.DPS)
	recipe:AddVendor(142552, 142564)

	-- Sinister Combatant's Shield -- 282876
	recipe = AddRecipe(282876, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(105, 105, 115, 120, 125)
	recipe:SetCraftedItem(164648, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHIELD")
	recipe:AddTrainer(127112, 133536, 153817, 154321)

	-- Sinister Combatant's Shield -- 282878
	recipe = AddRecipe(282878, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(105, 105, 140, 145, 150)
	recipe:SetRecipeItem(165284, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(164648, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHIELD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(142552, 142564)

	-- Sinister Combatant's Shield -- 282879
	recipe = AddRecipe(282879, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(105, 105, 145, 147, 150)
	recipe:SetRecipeItem(165285, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(164648, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHIELD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(142552, 142564)

	-- Sinister Combatant's Plate Armguards -- 282889
	recipe = AddRecipe(282889, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(105, 105, 115, 120, 125)
	recipe:SetCraftedItem(164657, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddTrainer(127112, 133536, 153817, 154321)

	-- Sinister Combatant's Plate Armguards -- 283237
	recipe = AddRecipe(283237, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(105, 105, 140, 145, 150)
	recipe:SetRecipeItem(165288, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(164657, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(142552, 142564)

	-- Sinister Combatant's Plate Armguards -- 283238
	recipe = AddRecipe(283238, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(105, 105, 145, 147, 150)
	recipe:SetRecipeItem(165289, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(164657, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(142552, 142564)

	-- Sinister Combatant's Plate Waistguard -- 283239
	recipe = AddRecipe(283239, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(105, 105, 115, 120, 125)
	recipe:SetCraftedItem(164656, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddTrainer(127112, 133536, 153817, 154321)

	-- Sinister Combatant's Plate Waistguard -- 283240
	recipe = AddRecipe(283240, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(105, 105, 140, 145, 150)
	recipe:SetRecipeItem(165286, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(164656, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(142552, 142564)

	-- Sinister Combatant's Plate Waistguard -- 283241
	recipe = AddRecipe(283241, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(105, 105, 145, 147, 150)
	recipe:SetRecipeItem(165287, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(164656, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(142552, 142564)

	-- Sinister Combatant's Plate Greaves -- 283242
	recipe = AddRecipe(283242, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(105, 105, 115, 120, 125)
	recipe:SetCraftedItem(164655, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddTrainer(127112, 133536, 153817, 154321)

	-- Sinister Combatant's Plate Greaves -- 283243
	recipe = AddRecipe(283243, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(105, 105, 140, 145, 150)
	recipe:SetRecipeItem(165282, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(164655, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(142552, 142564)

	-- Sinister Combatant's Plate Greaves -- 283244
	recipe = AddRecipe(283244, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(105, 105, 145, 147, 150)
	recipe:SetRecipeItem(165283, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(164655, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(142552, 142564)

	-- Sinister Combatant's Plate Gauntlets -- 283245
	recipe = AddRecipe(283245, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(105, 105, 115, 120, 125)
	recipe:SetCraftedItem(164654, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddTrainer(127112, 133536, 153817, 154321)

	-- Sinister Combatant's Plate Gauntlets -- 283247
	recipe = AddRecipe(283247, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(105, 105, 140, 145, 150)
	recipe:SetRecipeItem(165280, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(164654, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(142552, 142564)

	-- Sinister Combatant's Plate Gauntlets -- 283248
	recipe = AddRecipe(283248, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(105, 105, 145, 147, 150)
	recipe:SetRecipeItem(165281, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(164654, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(142552, 142564)

	-- Sinister Combatant's Plate Boots -- 283249
	recipe = AddRecipe(283249, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(105, 105, 115, 120, 125)
	recipe:SetCraftedItem(164653, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddTrainer(127112, 133536, 153817, 154321)

	-- Sinister Combatant's Plate Boots -- 283250
	recipe = AddRecipe(283250, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(105, 105, 140, 145, 150)
	recipe:SetRecipeItem(165278, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(164653, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(142552, 142564)

	-- Sinister Combatant's Plate Boots -- 283251
	recipe = AddRecipe(283251, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(105, 105, 145, 147, 150)
	recipe:SetRecipeItem(165279, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(164653, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(142552, 142564)

	-- Enhanced Stormsteel Girdle -- 285081
	recipe = AddRecipe(285081, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(140, 140, 150, 155, 160)
	recipe:SetCraftedItem(165406, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddTrainer(127112, 133536, 153817, 154321)

	-- Enhanced Stormsteel Legguards -- 285082
	recipe = AddRecipe(285082, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(140, 140, 150, 155, 160)
	recipe:SetCraftedItem(165379, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddTrainer(127112, 133536, 153817, 154321)

	-- Fortified Stormsteel Girdle -- 285089
	recipe = AddRecipe(285089, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(140, 140, 150, 150, 150)
	recipe:SetCraftedItem(165414, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddDiscovery("DISCOVERY_BS_BFA")

	-- Fortified Stormsteel Legguards -- 285090
	recipe = AddRecipe(285090, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(140, 140, 150, 150, 150)
	recipe:SetCraftedItem(165389, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddDiscovery("DISCOVERY_BS_BFA")

	-- Tempered Stormsteel Girdle -- 285097
	recipe = AddRecipe(285097, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(140, 140, 150, 150, 150)
	recipe:SetCraftedItem(165422, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddDiscovery("DISCOVERY_BS_BFA")

	-- Tempered Stormsteel Legguards -- 285098
	recipe = AddRecipe(285098, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(140, 140, 150, 150, 150)
	recipe:SetCraftedItem(165397, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddDiscovery("DISCOVERY_BS_BFA")

	-- Monel-Hardened Hoofplates -- 286015
	recipe = AddRecipe(286015, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(95, 95, 105, 110, 115)
	recipe:SetCraftedItem(152812, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CREATED_ITEM")
	recipe:AddTrainer(127112, 133536, 153817, 154321)

	-- Monel-Hardened Hoofplates -- 286016
	recipe = AddRecipe(286016, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(95, 95, 110, 115, 120)
	recipe:SetCraftedItem(152812, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CREATED_ITEM")
	recipe:AddWorldDrop(Z.DRUSTVAR, Z.NAZMIR, Z.STORMSONG_VALLEY, Z.TIRAGARDE_SOUND, Z.VOLDUN, Z.ZULDAZAR)

	-- Sanguinated Reconstruction -- 286631
	recipe = AddRecipe(286631, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(162461, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CREATED_ITEM")
	recipe:AddTrainer(127112, 133536, 153817, 154321)

	-- Aqueous Reconstruction -- 287235
	recipe = AddRecipe(287235, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(162460, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CREATED_ITEM")
	recipe:AddTrainer(127112, 133536, 153817, 154321)

	-- Notorious Combatant's Plate Boots -- 294748
	recipe = AddRecipe(294748, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(140, 140, 150, 155, 160)
	recipe:SetCraftedItem(167967, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddTrainer(153817, 154321)

	-- Notorious Combatant's Plate Boots -- 294749
	recipe = AddRecipe(294749, V.BFA, Q.EPIC)
	recipe:SetSkillLevels(155, 155, 170, 175, 175)
	recipe:SetRecipeItem(169511, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(167967, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddVendor(154652, 154653)

	-- Notorious Combatant's Plate Boots -- 294750
	recipe = AddRecipe(294750, V.BFA, Q.EPIC)
	recipe:SetSkillLevels(170, 170, 175, 175, 175)
	recipe:SetRecipeItem(169512, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(167967, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddVendor(154652, 154653)

	-- Notorious Combatant's Plate Gauntlets -- 294751
	recipe = AddRecipe(294751, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(135, 135, 145, 150, 155)
	recipe:SetCraftedItem(167969, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddTrainer(153817, 154321)

	-- Notorious Combatant's Plate Gauntlets -- 294752
	recipe = AddRecipe(294752, V.BFA, Q.EPIC)
	recipe:SetSkillLevels(150, 150, 170, 172, 175)
	recipe:SetRecipeItem(169505, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(167969, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddVendor(154652, 154653)

	-- Notorious Combatant's Plate Gauntlets -- 294753
	recipe = AddRecipe(294753, V.BFA, Q.EPIC)
	recipe:SetSkillLevels(150, 150, 170, 172, 175)
	recipe:SetRecipeItem(169506, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(167969, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddVendor(154652, 154653)

	-- Notorious Combatant's Plate Greaves -- 294754
	recipe = AddRecipe(294754, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(145, 145, 155, 160, 165)
	recipe:SetCraftedItem(167971, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddTrainer(153817, 154321)

	-- Notorious Combatant's Plate Greaves -- 294755
	recipe = AddRecipe(294755, V.BFA, Q.EPIC)
	recipe:SetSkillLevels(145, 145, 170, 172, 175)
	recipe:SetRecipeItem(169513, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(167971, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddVendor(154652, 154653)

	-- Notorious Combatant's Plate Greaves -- 294756
	recipe = AddRecipe(294756, V.BFA, Q.EPIC)
	recipe:SetSkillLevels(145, 145, 170, 172, 175)
	recipe:SetRecipeItem(169514, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(167971, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddVendor(154652, 154653)

	-- Notorious Combatant's Shield -- 294757
	recipe = AddRecipe(294757, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(135, 135, 145, 150, 155)
	recipe:SetCraftedItem(167991, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHIELD")
	recipe:AddTrainer(153817, 154321)

	-- Notorious Combatant's Shield -- 294758
	recipe = AddRecipe(294758, V.BFA, Q.EPIC)
	recipe:SetSkillLevels(165, 165, 170, 172, 175)
	recipe:SetRecipeItem(169522, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(167991, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHIELD")
	recipe:AddVendor(154652, 154653)

	-- Notorious Combatant's Shield -- 294759
	recipe = AddRecipe(294759, V.BFA, Q.EPIC)
	recipe:SetSkillLevels(175, 175, 175, 175, 175)
	recipe:SetRecipeItem(169523, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(167991, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHIELD")
	recipe:AddVendor(154652, 154653)

	-- Notorious Combatant's Plate Waistguard -- 294760
	recipe = AddRecipe(294760, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(140, 140, 150, 155, 160)
	recipe:SetCraftedItem(167973, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddTrainer(153817, 154321)

	-- Notorious Combatant's Plate Waistguard -- 294761
	recipe = AddRecipe(294761, V.BFA, Q.EPIC)
	recipe:SetSkillLevels(160, 160, 170, 172, 175)
	recipe:SetRecipeItem(169509, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(167973, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddVendor(154652, 154653)

	-- Notorious Combatant's Plate Waistguard -- 294762
	recipe = AddRecipe(294762, V.BFA, Q.EPIC)
	recipe:SetSkillLevels(170, 170, 175, 175, 175)
	recipe:SetRecipeItem(169510, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(167973, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddVendor(154652, 154653)

	-- Notorious Combatant's Plate Armguards -- 294763
	recipe = AddRecipe(294763, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(135, 135, 145, 150, 155)
	recipe:SetCraftedItem(167965, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddTrainer(153817, 154321)

	-- Notorious Combatant's Plate Armguards -- 294764
	recipe = AddRecipe(294764, V.BFA, Q.EPIC)
	recipe:SetSkillLevels(160, 160, 170, 172, 175)
	recipe:SetRecipeItem(169507, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(167965, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddVendor(154652, 154653)

	-- Notorious Combatant's Plate Armguards -- 294765
	recipe = AddRecipe(294765, V.BFA, Q.EPIC)
	recipe:SetSkillLevels(160, 160, 170, 172, 175)
	recipe:SetRecipeItem(169508, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(167965, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddVendor(154652, 154653)

	-- Notorious Combatant's Cutlass -- 294766
	recipe = AddRecipe(294766, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(135, 135, 145, 150, 155)
	recipe:SetCraftedItem(167937, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_SWORD")
	recipe:AddTrainer(153817, 154321)

	-- Notorious Combatant's Cutlass -- 294767
	recipe = AddRecipe(294767, V.BFA, Q.EPIC)
	recipe:SetSkillLevels(165, 165, 170, 172, 175)
	recipe:SetRecipeItem(169519, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(167937, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_SWORD")
	recipe:AddVendor(154652, 154653)

	-- Notorious Combatant's Cutlass -- 294768
	recipe = AddRecipe(294768, V.BFA, Q.EPIC)
	recipe:SetSkillLevels(175, 175, 175, 175, 175)
	recipe:SetRecipeItem(169520, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(167937, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_SWORD")
	recipe:AddVendor(154652, 154653)

	-- Notorious Combatant's Deckpounder -- 294769
	recipe = AddRecipe(294769, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(145, 145, 155, 160, 165)
	recipe:SetCraftedItem(167939, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_MACE")
	recipe:AddTrainer(153817, 154321)

	-- Notorious Combatant's Deckpounder -- 294770
	recipe = AddRecipe(294770, V.BFA, Q.EPIC)
	recipe:SetSkillLevels(170, 170, 170, 172, 175)
	recipe:SetRecipeItem(169526, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(167939, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_MACE")
	recipe:AddVendor(154652, 154653)

	-- Notorious Combatant's Deckpounder -- 294771
	recipe = AddRecipe(294771, V.BFA, Q.EPIC)
	recipe:SetSkillLevels(175, 175, 175, 175, 175)
	recipe:SetRecipeItem(169528, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(167939, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_MACE")
	recipe:AddVendor(154652, 154653)

	-- Notorious Combatant's Spellblade -- 294772
	recipe = AddRecipe(294772, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(125, 125, 135, 140, 145)
	recipe:SetCraftedItem(167995, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_DAGGER")
	recipe:AddTrainer(153817, 154321)

	-- Notorious Combatant's Spellblade -- 294773
	recipe = AddRecipe(294773, V.BFA, Q.EPIC)
	recipe:SetSkillLevels(160, 160, 170, 172, 175)
	recipe:SetRecipeItem(169515, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(167995, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_DAGGER")
	recipe:AddVendor(154652, 154653)

	-- Notorious Combatant's Spellblade -- 294774
	recipe = AddRecipe(294774, V.BFA, Q.EPIC)
	recipe:SetSkillLevels(170, 170, 170, 172, 175)
	recipe:SetRecipeItem(169516, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(167995, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_DAGGER")
	recipe:AddVendor(154652, 154653)

	-- Notorious Combatant's Shanker -- 294775
	recipe = AddRecipe(294775, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(125, 125, 135, 140, 145)
	recipe:SetCraftedItem(167989, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_DAGGER")
	recipe:AddTrainer(153817, 154321)

	-- Notorious Combatant's Shanker -- 294776
	recipe = AddRecipe(294776, V.BFA, Q.EPIC)
	recipe:SetSkillLevels(160, 160, 170, 172, 175)
	recipe:SetRecipeItem(169517, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(167989, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_DAGGER")
	recipe:AddVendor(154652, 154653)

	-- Notorious Combatant's Shanker -- 294777
	recipe = AddRecipe(294777, V.BFA, Q.EPIC)
	recipe:SetSkillLevels(170, 170, 175, 175, 175)
	recipe:SetRecipeItem(169517, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(167989, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_DAGGER")
	recipe:AddVendor(154652, 154653)

	-- Notorious Combatant's Polearm -- 294778
	recipe = AddRecipe(294778, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(145, 145, 155, 160, 165)
	recipe:SetCraftedItem(167975, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_POLEARM")
	recipe:AddTrainer(153817, 154321)

	-- Notorious Combatant's Polearm -- 294779
	recipe = AddRecipe(294779, V.BFA, Q.EPIC)
	recipe:SetSkillLevels(170, 170, 170, 172, 175)
	recipe:SetRecipeItem(169524, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(167975, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_POLEARM")
	recipe:AddVendor(154652, 154653)

	-- Notorious Combatant's Polearm -- 294780
	recipe = AddRecipe(294780, V.BFA, Q.EPIC)
	recipe:SetSkillLevels(175, 175, 175, 175, 175)
	recipe:SetRecipeItem(169525, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(167975, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_POLEARM")
	recipe:AddVendor(154652, 154653)

	-- Osmenite Legguards -- 298998
	recipe = AddRecipe(298998, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(170, 170, 180, 185, 190)
	recipe:SetCraftedItem(168677, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddTrainer(153817, 154321)

	-- Reinforced Osmenite Legguards -- 298999
	recipe = AddRecipe(298999, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(170, 170, 175, 175, 175)
	recipe:SetCraftedItem(168678, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddDiscovery("DISCOVERY_BS_BFA")

	-- Banded Osmenite Legguards -- 299000
	recipe = AddRecipe(299000, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(170, 170, 175, 175, 175)
	recipe:SetCraftedItem(168679, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddDiscovery("DISCOVERY_BS_BFA")

	-- Osmenite Girdle -- 299001
	recipe = AddRecipe(299001, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(160, 160, 170, 175, 180)
	recipe:SetCraftedItem(168680, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddTrainer(153817, 154321)

	-- Reinforced Osmenite Girdle -- 299002
	recipe = AddRecipe(299002, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(165, 165, 175, 175, 175)
	recipe:SetCraftedItem(168681, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddDiscovery("DISCOVERY_BS_BFA")

	-- Banded Osmenite Girdle -- 299003
	recipe = AddRecipe(299003, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(165, 165, 175, 175, 175)
	recipe:SetCraftedItem(168682, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddDiscovery("DISCOVERY_BS_BFA")

	-- Inflatable Mount Shoes -- 301413
	recipe = AddRecipe(301413, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(150, 150, 160, 165, 170)
	recipe:SetCraftedItem(168417, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CREATED_ITEM")
	recipe:AddTrainer(153817, 154321)

	-- Uncanny Combatant's Plate Boots -- 304307
	recipe = AddRecipe(304307, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(170, 170, 180, 185, 190)
	recipe:SetCraftedItem(170285, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddTrainer(127112, 133536)

	-- Uncanny Combatant's Plate Gauntlets -- 304308
	recipe = AddRecipe(304308, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(170, 170, 180, 185, 190)
	recipe:SetCraftedItem(170286, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddTrainer(127112, 133536)

	-- Uncanny Combatant's Plate Greaves -- 304312
	recipe = AddRecipe(304312, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(170, 170, 180, 185, 190)
	recipe:SetCraftedItem(170287, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddTrainer(127112, 133536)

	-- Uncanny Combatant's Shield -- 304314
	recipe = AddRecipe(304314, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(170, 170, 180, 185, 190)
	recipe:SetCraftedItem(170364, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHIELD")
	recipe:AddTrainer(127112, 133536)

	-- Uncanny Combatant's Plate Waistguard -- 304315
	recipe = AddRecipe(304315, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(170, 170, 180, 185, 190)
	recipe:SetCraftedItem(170288, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddTrainer(127112, 133536)

	-- Uncanny Combatant's Plate Armguards -- 304317
	recipe = AddRecipe(304317, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(170, 170, 180, 185, 190)
	recipe:SetCraftedItem(170289, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddTrainer(127112, 133536)

	-- Uncanny Combatant's Cutlass -- 304318
	recipe = AddRecipe(304318, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(170, 170, 180, 185, 190)
	recipe:SetCraftedItem(170294, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_SWORD")
	recipe:AddTrainer(127112, 133536)

	-- Uncanny Combatant's Deckpounder -- 304320
	recipe = AddRecipe(304320, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(170, 170, 180, 185, 190)
	recipe:SetCraftedItem(170293, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_MACE")
	recipe:AddTrainer(127112, 133536)

	-- Uncanny Combatant's Spellblade -- 304322
	recipe = AddRecipe(304322, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(170, 170, 180, 185, 190)
	recipe:SetCraftedItem(170292, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_DAGGER")
	recipe:AddTrainer(127112, 133536)

	-- Uncanny Combatant's Shanker -- 304323
	recipe = AddRecipe(304323, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(170, 170, 180, 185, 190)
	recipe:SetCraftedItem(170291, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_DAGGER")
	recipe:AddTrainer(127112, 133536)

	-- Uncanny Combatant's Polearm -- 304324
	recipe = AddRecipe(304324, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(170, 170, 180, 185, 190)
	recipe:SetCraftedItem(170290, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_POLEARM")
	recipe:AddTrainer(127112, 133536)

	-- Eldritch Osmenite Girdle -- 305838
	recipe = AddRecipe(305838, V.BFA, Q.EPIC)
	recipe:SetSkillLevels(175, 175, 175, 175, 175)
	recipe:SetRecipeItem(171107, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(170391, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddDiscovery("DISCOVERY_BS_BFA")

	-- Maddening Osmenite Girdle -- 305839
	recipe = AddRecipe(305839, V.BFA, Q.EPIC)
	recipe:SetSkillLevels(175, 175, 175, 175, 175)
	recipe:SetRecipeItem(171108, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(170390, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddDiscovery("DISCOVERY_BS_BFA")

	-- Unsettling Osmenite Girdle -- 305840
	recipe = AddRecipe(305840, V.BFA, Q.RARE)
	recipe:SetSkillLevels(175, 175, 175, 175, 175)
	recipe:SetRecipeItem(171317, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(170389, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddMobDrop(153910, 162245)

	-- Eldritch Osmenite Legguards -- 305841
	recipe = AddRecipe(305841, V.BFA, Q.EPIC)
	recipe:SetSkillLevels(175, 175, 175, 175, 175)
	recipe:SetRecipeItem(171109, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(170388, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddDiscovery("DISCOVERY_BS_BFA")

	-- Maddening Osmenite Legguards -- 305842
	recipe = AddRecipe(305842, V.BFA, Q.EPIC)
	recipe:SetSkillLevels(175, 175, 175, 175, 175)
	recipe:SetRecipeItem(171110, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(170387, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddDiscovery("DISCOVERY_BS_BFA")

	-- Unsettling Osmenite Legguards -- 305843
	recipe = AddRecipe(305843, V.BFA, Q.RARE)
	recipe:SetSkillLevels(175, 175, 175, 175, 175)
	recipe:SetRecipeItem(171316, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(170386, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddMobDrop(153910, 162245)

	-- Uncanny Combatant's Polearm -- 305844
	recipe = AddRecipe(305844, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 165, 170, 175)
	recipe:SetRecipeItem(170946, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(170290, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_POLEARM")
	recipe:AddFilters(F.DPS)
	recipe:AddVendor(142552, 142564, 161565)

	-- Uncanny Combatant's Polearm -- 305845
	recipe = AddRecipe(305845, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 165, 170, 175)
	recipe:SetRecipeItem(170947, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(170290, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_POLEARM")
	recipe:AddFilters(F.DPS)
	recipe:AddVendor(142552, 142564, 161565)

	-- Uncanny Combatant's Shanker -- 305846
	recipe = AddRecipe(305846, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 165, 170, 175)
	recipe:SetRecipeItem(170948, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(170291, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_DAGGER")
	recipe:AddFilters(F.DPS)
	recipe:AddVendor(142552, 142564, 161565)

	-- Uncanny Combatant's Shanker -- 305847
	recipe = AddRecipe(305847, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 165, 170, 175)
	recipe:SetRecipeItem(170949, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(170291, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_DAGGER")
	recipe:AddFilters(F.DPS)
	recipe:AddVendor(142552, 142564, 161565)

	-- Uncanny Combatant's Spellblade -- 305848
	recipe = AddRecipe(305848, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 165, 170, 175)
	recipe:SetRecipeItem(170950, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(170292, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_DAGGER")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(142552, 142564, 161565)

	-- Uncanny Combatant's Spellblade -- 305849
	recipe = AddRecipe(305849, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 165, 170, 175)
	recipe:SetRecipeItem(170951, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(170292, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_DAGGER")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(142552, 142564, 161565)

	-- Uncanny Combatant's Deckpounder -- 305850
	recipe = AddRecipe(305850, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 165, 170, 175)
	recipe:SetRecipeItem(170952, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(170293, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_MACE")
	recipe:AddFilters(F.DPS)
	recipe:AddVendor(142552, 142564, 161565)

	-- Uncanny Combatant's Deckpounder -- 305851
	recipe = AddRecipe(305851, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 165, 170, 175)
	recipe:SetRecipeItem(170953, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(170293, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_MACE")
	recipe:AddFilters(F.DPS)
	recipe:AddVendor(142552, 142564, 161565)

	-- Uncanny Combatant's Cutlass -- 305852
	recipe = AddRecipe(305852, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 165, 170, 175)
	recipe:SetRecipeItem(170954, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(170294, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_SWORD")
	recipe:AddFilters(F.DPS)
	recipe:AddVendor(142552, 142564, 161565)

	-- Uncanny Combatant's Cutlass -- 305853
	recipe = AddRecipe(305853, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 165, 170, 175)
	recipe:SetRecipeItem(170955, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(170294, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_SWORD")
	recipe:AddFilters(F.DPS)
	recipe:AddVendor(142552, 142564, 161565)

	-- Uncanny Combatant's Plate Armguards -- 306078
	recipe = AddRecipe(306078, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 165, 170, 175)
	recipe:SetRecipeItem(170403, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(170289, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(142552, 142564, 161565)

	-- Uncanny Combatant's Plate Armguards -- 306079
	recipe = AddRecipe(306079, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 165, 170, 175)
	recipe:SetRecipeItem(170402, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(170289, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(142552, 142564, 161565)

	-- Uncanny Combatant's Plate Waistguard -- 306080
	recipe = AddRecipe(306080, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 165, 170, 175)
	recipe:SetRecipeItem(170393, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(170288, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(142552, 142564, 161565)

	-- Uncanny Combatant's Plate Waistguard -- 306081
	recipe = AddRecipe(306081, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 165, 170, 175)
	recipe:SetRecipeItem(170392, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(170288, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(142552, 142564, 161565)

	-- Uncanny Combatant's Plate Greaves -- 306082
	recipe = AddRecipe(306082, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 165, 170, 175)
	recipe:SetRecipeItem(170399, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(170287, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(142552, 142564, 161565)

	-- Uncanny Combatant's Plate Greaves -- 306083
	recipe = AddRecipe(306083, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 165, 170, 175)
	recipe:SetRecipeItem(170398, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(170287, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(142552, 142564, 161565)

	-- Uncanny Combatant's Plate Gauntlets -- 306084
	recipe = AddRecipe(306084, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 165, 170, 175)
	recipe:SetRecipeItem(170397, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(170286, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(142552, 142564, 161565)

	-- Uncanny Combatant's Plate Gauntlets -- 306085
	recipe = AddRecipe(306085, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 165, 170, 175)
	recipe:SetRecipeItem(170396, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(170286, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(142552, 142564, 161565)

	-- Uncanny Combatant's Plate Boots -- 306086
	recipe = AddRecipe(306086, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 165, 170, 175)
	recipe:SetRecipeItem(170395, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(170285, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(142552, 142564, 161565)

	-- Uncanny Combatant's Plate Boots -- 306087
	recipe = AddRecipe(306087, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 165, 170, 175)
	recipe:SetRecipeItem(170394, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(170285, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(142552, 142564, 161565)

	-- Uncanny Combatant's Shield -- 306310
	recipe = AddRecipe(306310, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 165, 170, 175)
	recipe:SetRecipeItem(170401, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(170364, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHIELD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(142552, 142564, 161565)

	-- Uncanny Combatant's Shield -- 306312
	recipe = AddRecipe(306312, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 165, 170, 175)
	recipe:SetRecipeItem(170400, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(170364, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHIELD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(142552, 142564, 161565)

	-- Void Focus -- 307221
	recipe = AddRecipe(307221, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 165, 170, 175)
	recipe:SetRecipeItem(171312, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(171320, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_CREATED_ITEM")
	recipe:AddMobDrop(153910, 162245)

	-- Relic of the Past I -- 330174
	recipe = AddRecipe(330174, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(180055, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_MATERIALS")
	recipe:AddTrainer(127112, 133536)

	-- Relic of the Past II -- 330175
	recipe = AddRecipe(330175, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(180057, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_MATERIALS")
	recipe:AddTrainer(127112, 133536)

	-- Relic of the Past III -- 330176
	recipe = AddRecipe(330176, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(180058, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_MATERIALS")
	recipe:AddTrainer(127112, 133536)

	-- Relic of the Past IV -- 330177
	recipe = AddRecipe(330177, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(180059, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_MATERIALS")
	recipe:AddTrainer(127112, 133536)

	-- Relic of the Past V -- 330178
	recipe = AddRecipe(330178, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(180060, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_MATERIALS")
	recipe:AddTrainer(127112, 133536)

	-- ----------------------------------------------------------------------------
	-- Shadowlands.
	-- ----------------------------------------------------------------------------
	-- Shadowghast Ingot -- 307611
	recipe = AddRecipe(307611, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(171428, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_MATERIALS")
	recipe:AddTrainer(156666)

	-- Ceremonious Breastplate -- 307663
	recipe = AddRecipe(307663, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(20, 20, 30, 35, 40)
	recipe:SetCraftedItem(171374, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddTrainer(156666)

	-- Ceremonious Sabatons -- 307664
	recipe = AddRecipe(307664, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(5, 5, 15, 20, 25)
	recipe:SetCraftedItem(171375, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddCustom("DEFAULT_RECIPE")

	-- Ceremonious Gauntlets -- 307665
	recipe = AddRecipe(307665, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(10, 10, 20, 25, 30)
	recipe:SetCraftedItem(171376, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddTrainer(156666)

	-- Ceremonious Helm -- 307666
	recipe = AddRecipe(307666, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(171377, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddTrainer(156666)

	-- Ceremonious Greaves -- 307667
	recipe = AddRecipe(307667, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(30, 30, 40, 45, 50)
	recipe:SetCraftedItem(171378, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddTrainer(156666)

	-- Ceremonious Pauldrons -- 307668
	recipe = AddRecipe(307668, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(35, 35, 45, 50, 55)
	recipe:SetCraftedItem(171379, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHOULDER")
	recipe:AddTrainer(156666)

	-- Ceremonious Waistguard -- 307669
	recipe = AddRecipe(307669, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(5, 5, 15, 20, 25)
	recipe:SetCraftedItem(171380, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddTrainer(156666)

	-- Ceremonious Armguards -- 307670
	recipe = AddRecipe(307670, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 10, 15, 20)
	recipe:SetCraftedItem(171381, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddCustom("DEFAULT_RECIPE")

	-- Ceremonious Shield -- 307671
	recipe = AddRecipe(307671, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(15, 15, 25, 30, 35)
	recipe:SetCraftedItem(171391, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHIELD")
	recipe:AddTrainer(156666)

	-- Ceremonious Axe -- 307672
	recipe = AddRecipe(307672, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(171388, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_AXE")
	recipe:AddTrainer(156666)

	-- Ceremonious Mace -- 307674
	recipe = AddRecipe(307674, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(20, 20, 30, 35, 40)
	recipe:SetCraftedItem(171387, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_MACE")
	recipe:AddTrainer(156666)

	-- Ceremonious Rapier -- 307675
	recipe = AddRecipe(307675, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(10, 10, 20, 25, 30)
	recipe:SetCraftedItem(171382, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_SWORD")
	recipe:AddTrainer(156666)

	-- Ceremonious Reaper -- 307676
	recipe = AddRecipe(307676, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(171389, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_AXE")
	recipe:AddTrainer(156666)

	-- Ceremonious Smasher -- 307677
	recipe = AddRecipe(307677, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(15, 15, 25, 30, 35)
	recipe:SetCraftedItem(171384, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_MACE")
	recipe:AddTrainer(156666)

	-- Ceremonious Claymore -- 307678
	recipe = AddRecipe(307678, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(5, 5, 15, 20, 25)
	recipe:SetCraftedItem(171383, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_SWORD")
	recipe:AddTrainer(156666)

	-- Ceremonious Blade -- 307679
	recipe = AddRecipe(307679, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(35, 35, 45, 50, 55)
	recipe:SetCraftedItem(171390, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_DAGGER")
	recipe:AddTrainer(156666)

	-- Ceremonious Shanker -- 307680
	recipe = AddRecipe(307680, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 10, 15, 20)
	recipe:SetCraftedItem(171385, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_DAGGER")
	recipe:AddCustom("DEFAULT_RECIPE")

	-- Ceremonious Spear -- 307681
	recipe = AddRecipe(307681, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(15, 15, 25, 30, 35)
	recipe:SetCraftedItem(171386, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_POLEARM")
	recipe:AddTrainer(156666)

	-- Ceremonious Warglaive -- 307682
	recipe = AddRecipe(307682, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(30, 30, 40, 45, 50)
	recipe:SetCraftedItem(171392, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WARGLAIVE")
	recipe:AddTrainer(156666)

	-- Shadowghast Armguards -- 307705
	recipe = AddRecipe(307705, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 100, 100, 100)
	recipe:SetCraftedItem(171419, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddTrainer(156666)

	-- Shadowghast Waistguard -- 307706
	recipe = AddRecipe(307706, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 100, 100, 100)
	recipe:SetCraftedItem(171418, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddTrainer(156666)

	-- Shadowghast Pauldrons -- 307707
	recipe = AddRecipe(307707, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 100, 100, 100)
	recipe:SetCraftedItem(171417, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHOULDER")
	recipe:AddTrainer(156666)

	-- Shadowghast Greaves -- 307708
	recipe = AddRecipe(307708, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 100, 100, 100)
	recipe:SetCraftedItem(171416, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddTrainer(156666)

	-- Shadowghast Helm -- 307709
	recipe = AddRecipe(307709, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 100, 100, 100)
	recipe:SetCraftedItem(171415, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddTrainer(156666)

	-- Shadowghast Gauntlets -- 307710
	recipe = AddRecipe(307710, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 100, 100, 100)
	recipe:SetCraftedItem(171414, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddTrainer(156666)

	-- Shadowghast Sabatons -- 307711
	recipe = AddRecipe(307711, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 100, 100, 100)
	recipe:SetCraftedItem(171413, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddTrainer(156666)

	-- Shadowghast Breastplate -- 307712
	recipe = AddRecipe(307712, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 100, 100, 100)
	recipe:SetCraftedItem(171412, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddTrainer(156666)

	-- Porous Sharpening Stone -- 307717
	recipe = AddRecipe(307717, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 10, 15, 20)
	recipe:SetCraftedItem(171436, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ITEM_ENHANCEMENT")
	recipe:AddCustom("DEFAULT_RECIPE")

	-- Shaded Sharpening Stone -- 307718
	recipe = AddRecipe(307718, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(171437, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ITEM_ENHANCEMENT")
	recipe:AddTrainer(156666)

	-- Porous Weightstone -- 307719
	recipe = AddRecipe(307719, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 10, 15, 20)
	recipe:SetCraftedItem(171438, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ITEM_ENHANCEMENT")
	recipe:AddCustom("DEFAULT_RECIPE")

	-- Shaded Weightstone -- 307720
	recipe = AddRecipe(307720, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(55, 55, 65, 70, 75)
	recipe:SetCraftedItem(171439, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ITEM_ENHANCEMENT")
	recipe:AddTrainer(156666)

	-- Laestrite Skeleton Key -- 307721
	recipe = AddRecipe(307721, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(15, 15, 25, 30, 35)
	recipe:SetCraftedItem(171441, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SKELETON_KEY")
	recipe:AddTrainer(156666)

	-- Shadowsteel Breastplate -- 322587
	recipe = AddRecipe(322587, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(80, 80, 90, 95, 100)
	recipe:SetCraftedItem(171442, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddTrainer(156666)

	-- Shadowsteel Sabatons -- 322588
	recipe = AddRecipe(322588, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(55, 55, 65, 70, 75)
	recipe:SetCraftedItem(171443, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddTrainer(156666)

	-- Shadowsteel Gauntlets -- 322589
	recipe = AddRecipe(322589, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(65, 65, 75, 80, 85)
	recipe:SetCraftedItem(171444, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddTrainer(156666)

	-- Shadowsteel Helm -- 322590
	recipe = AddRecipe(322590, V.SHA, Q.RARE)
	recipe:SetSkillLevels(80, 80, 90, 95, 100)
	recipe:SetRecipeItem(183094, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(171445, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddRepVendor(FAC.THE_ASCENDED, REP.HONORED, 160470, 176064)

	-- Shadowsteel Greaves -- 322591
	recipe = AddRecipe(322591, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(90, 90, 100, 105, 110)
	recipe:SetCraftedItem(171446, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddTrainer(156666)

	-- Shadowsteel Pauldrons -- 322593
	recipe = AddRecipe(322593, V.SHA, Q.RARE)
	recipe:SetSkillLevels(90, 90, 100, 105, 110)
	recipe:SetRecipeItem(183095, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(171447, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHOULDER")
	recipe:AddRepVendor(FAC.THE_UNDYING_ARMY, REP.HONORED, 173003, 176067)

	-- Shadowsteel Waistguard -- 322594
	recipe = AddRecipe(322594, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(60, 60, 70, 75, 80)
	recipe:SetCraftedItem(171448, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddTrainer(156666)

	-- Shadowsteel Armguards -- 322595
	recipe = AddRecipe(322595, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(171449, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddTrainer(156666)

	-- Shadowghast Armguards -- 332006
	recipe = AddRecipe(332006, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 100, 100, 100)
	recipe:SetCraftedItem(171419, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddDiscovery("DISCOVERY_SHADOWLANDS")

	-- Shadowghast Waistguard -- 332007
	recipe = AddRecipe(332007, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 100, 100, 100)
	recipe:SetCraftedItem(171418, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddDiscovery("DISCOVERY_SHADOWLANDS")

	-- Shadowghast Pauldrons -- 332008
	recipe = AddRecipe(332008, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 100, 100, 100)
	recipe:SetCraftedItem(171417, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHOULDER")
	recipe:AddDiscovery("DISCOVERY_SHADOWLANDS")

	-- Shadowghast Greaves -- 332009
	recipe = AddRecipe(332009, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 100, 100, 100)
	recipe:SetCraftedItem(171416, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddDiscovery("DISCOVERY_SHADOWLANDS")

	-- Shadowghast Helm -- 332010
	recipe = AddRecipe(332010, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 100, 100, 100)
	recipe:SetCraftedItem(171415, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddDiscovery("DISCOVERY_SHADOWLANDS")

	-- Shadowghast Gauntlets -- 332011
	recipe = AddRecipe(332011, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 100, 100, 100)
	recipe:SetCraftedItem(171414, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddDiscovery("DISCOVERY_SHADOWLANDS")

	-- Shadowghast Sabatons -- 332012
	recipe = AddRecipe(332012, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 100, 100, 100)
	recipe:SetCraftedItem(171413, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddDiscovery("DISCOVERY_SHADOWLANDS")

	-- Shadowghast Breastplate -- 332013
	recipe = AddRecipe(332013, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 100, 100, 100)
	recipe:SetCraftedItem(171412, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddDiscovery("DISCOVERY_SHADOWLANDS")

	-- Shadowghast Armguards -- 332041
	recipe = AddRecipe(332041, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 100, 100, 100)
	recipe:SetCraftedItem(171419, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddDiscovery("DISCOVERY_SHADOWLANDS")

	-- Shadowghast Waistguard -- 332042
	recipe = AddRecipe(332042, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 100, 100, 100)
	recipe:SetCraftedItem(171418, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddDiscovery("DISCOVERY_SHADOWLANDS")

	-- Shadowghast Pauldrons -- 332043
	recipe = AddRecipe(332043, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 100, 100, 100)
	recipe:SetCraftedItem(171417, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHOULDER")
	recipe:AddDiscovery("DISCOVERY_SHADOWLANDS")

	-- Shadowghast Greaves -- 332044
	recipe = AddRecipe(332044, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 100, 100, 100)
	recipe:SetCraftedItem(171416, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddDiscovery("DISCOVERY_SHADOWLANDS")

	-- Shadowghast Helm -- 332045
	recipe = AddRecipe(332045, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 100, 100, 100)
	recipe:SetCraftedItem(171415, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddDiscovery("DISCOVERY_SHADOWLANDS")

	-- Shadowghast Gauntlets -- 332046
	recipe = AddRecipe(332046, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 100, 100, 100)
	recipe:SetCraftedItem(171414, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddDiscovery("DISCOVERY_SHADOWLANDS")

	-- Shadowghast Sabatons -- 332047
	recipe = AddRecipe(332047, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 100, 100, 100)
	recipe:SetCraftedItem(171413, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddDiscovery("DISCOVERY_SHADOWLANDS")

	-- Shadowghast Breastplate -- 332048
	recipe = AddRecipe(332048, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 100, 100, 100)
	recipe:SetCraftedItem(171412, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddDiscovery("DISCOVERY_SHADOWLANDS")

	-- Shadowghast Breastplate -- 338968
	recipe = AddRecipe(338968, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 100, 100, 100)
	recipe:SetCraftedItem(171412, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddDiscovery("DISCOVERY_SHADOWLANDS")

	-- Shadowghast Sabatons -- 338969
	recipe = AddRecipe(338969, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 100, 100, 100)
	recipe:SetCraftedItem(171413, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddDiscovery("DISCOVERY_SHADOWLANDS")

	-- Shadowghast Gauntlets -- 338970
	recipe = AddRecipe(338970, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 100, 100, 100)
	recipe:SetCraftedItem(171414, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddDiscovery("DISCOVERY_SHADOWLANDS")

	-- Shadowghast Helm -- 338971
	recipe = AddRecipe(338971, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 100, 100, 100)
	recipe:SetCraftedItem(171415, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddDiscovery("DISCOVERY_SHADOWLANDS")

	-- Shadowghast Greaves -- 338972
	recipe = AddRecipe(338972, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 100, 100, 100)
	recipe:SetCraftedItem(171416, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddDiscovery("DISCOVERY_SHADOWLANDS")

	-- Shadowghast Pauldrons -- 338974
	recipe = AddRecipe(338974, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 100, 100, 100)
	recipe:SetCraftedItem(171417, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHOULDER")
	recipe:AddDiscovery("DISCOVERY_SHADOWLANDS")

	-- Shadowghast Waistguard -- 338975
	recipe = AddRecipe(338975, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 100, 100, 100)
	recipe:SetCraftedItem(171418, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddDiscovery("DISCOVERY_SHADOWLANDS")

	-- Shadowghast Armguards -- 338976
	recipe = AddRecipe(338976, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 100, 100, 100)
	recipe:SetCraftedItem(171419, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddDiscovery("DISCOVERY_SHADOWLANDS")

	-- Crafter's Mark I -- 343184
	recipe = AddRecipe(343184, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(45, 45, 55, 60, 65)
	recipe:SetCraftedItem(173381, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CREATED_ITEM")
	recipe:AddTrainer(156666)

	-- Crafter's Mark II -- 343185
	recipe = AddRecipe(343185, V.SHA, Q.RARE)
	recipe:SetSkillLevels(0, 0, 0, 0, 0)
	recipe:SetRecipeItem(183870, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(173382, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_CREATED_ITEM")
	recipe:AddRepVendor(FAC.THE_AVOWED, REP.REVERED, 173705)

	-- Crafter's Mark III -- 343186
	recipe = AddRecipe(343186, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 190, 192, 195)
	recipe:SetRecipeItem(183868, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(173383, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_CREATED_ITEM")
	recipe:AddRepVendor(FAC.DEATHS_ADVANCE, REP.HONORED, 179321)

	-- Crafter's Mark of the Chained Isle -- 343188
	recipe = AddRecipe(343188, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(200, 200, 200, 200, 200)
	recipe:SetRecipeItem(186470, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(173384, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_CREATED_ITEM")
	recipe:AddRepVendor(FAC.THE_ARCHIVISTS_CODEX, REP.REVERED, 178257)

	-- Novice Crafter's Mark -- 343662
	recipe = AddRecipe(343662, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(183942, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CREATED_ITEM")
	recipe:AddTrainer(156666)

	-- Vestige of Origins -- 352439
	recipe = AddRecipe(352439, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 190, 192, 195)
	recipe:SetCraftedItem(185960, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_CREATED_ITEM")
	recipe:AddRepVendor(FAC.DEATHS_ADVANCE, REP.HONORED, 179321)


	-- 9.2 Recipes

	-- Crafter's Mark IV -- 359665
	recipe = AddRecipe(359665, V.SHA, Q.EPIC)
	recipe:SetSkillLevels(201, 201, 201, 201, 201)
	recipe:SetRecipeItem(187750, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(187741, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_CREATED_ITEM")
	recipe:AddRepVendor(FAC.THE_ENLIGHTENED, REP.HONORED, 182257)

	-- Crafter's Mark of the First Ones -- 359671
	recipe = AddRecipe(359671, V.SHA, Q.EPIC)
	recipe:SetSkillLevels(201, 201, 201, 201, 201)
	recipe:SetRecipeItem(187749, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(187742, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_CREATED_ITEM")
	recipe:AddRepVendor(FAC.THE_ENLIGHTENED, REP.HONORED, 182257)

	-- Vestige of the Eternal -- 359700
	recipe = AddRecipe(359700, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 203, 203, 203)
	recipe:SetRecipeItem(187785, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(187784, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_CREATED_ITEM")
	recipe:AddRepVendor(FAC.THE_ENLIGHTENED, REP.HONORED, 182257)

	self.InitializeRecipes = nil
end
