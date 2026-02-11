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

	-- ----------------------------------------------------------------------------
	-- Classic.
	-- ----------------------------------------------------------------------------
	-- Delicate Copper Wire -- 25255
	recipe = AddRecipe(25255, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 20, 35, 50)
	recipe:SetCraftedItem(20816, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_MATERIALS")
	recipe:AddCustom("DEFAULT_RECIPE")

	-- Bronze Setting -- 25278
	recipe = AddRecipe(25278, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 70, 80, 90)
	recipe:SetCraftedItem(20817, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_MATERIALS")
	recipe:AddTrainer(5388, 15501, 18751, 19775, 19778, 44582, 46675, 47384, 47396, 47400, 47418, 47419, 47421, 47431, 48619, 49885, 52586, 52587, 52645, 52657, 57620, 65043, 85916, 86010, 93527, 100538)

	-- Elegant Silver Ring -- 25280
	recipe = AddRecipe(25280, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 80, 95, 110)
	recipe:SetCraftedItem(20818, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(5388, 15501, 18751, 19775, 19778, 44582, 46675, 47384, 47396, 47400, 47418, 47419, 47421, 47431, 48619, 49885, 52586, 52587, 52645, 52657, 57620, 65043, 85916, 86010, 93527, 100538)

	-- Inlaid Malachite Ring -- 25283
	recipe = AddRecipe(25283, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(30, 30, 60, 75, 90)
	recipe:SetCraftedItem(20821, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(5388, 15501, 18751, 19775, 19778, 44582, 46675, 47384, 47396, 47400, 47418, 47419, 47421, 47431, 48619, 49885, 52586, 52587, 52645, 52657, 57620, 65043, 85916, 86010, 93527, 100538)

	-- Simple Pearl Ring -- 25284
	recipe = AddRecipe(25284, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(60, 60, 90, 105, 120)
	recipe:SetCraftedItem(20820, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(5388, 15501, 18751, 19775, 19778, 44582, 46675, 47384, 47396, 47400, 47418, 47419, 47421, 47431, 48619, 49885, 52586, 52587, 52645, 52657, 57620, 65043, 85916, 86010, 93527, 100538)

	-- Gloom Band -- 25287
	recipe = AddRecipe(25287, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(70, 70, 100, 115, 130)
	recipe:SetCraftedItem(20823, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(5388, 15501, 18751, 19775, 19778, 44582, 46675, 47384, 47396, 47400, 47418, 47419, 47421, 47431, 48619, 49885, 52586, 52587, 52645, 52657, 57620, 65043, 85916, 86010, 93527, 100538)

	-- Heavy Silver Ring -- 25305
	recipe = AddRecipe(25305, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(90, 90, 120, 135, 150)
	recipe:SetCraftedItem(20826, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddTrainer(5388, 15501, 18751, 19775, 19778, 44582, 46675, 49885, 52586, 52587, 52645, 52657, 93527, 100538)

	-- Ring of Silver Might -- 25317
	recipe = AddRecipe(25317, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(80, 80, 110, 125, 140)
	recipe:SetCraftedItem(20827, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(5388, 15501, 18751, 19775, 19778, 44582, 46675, 49885, 52586, 52587, 52645, 52657, 93527, 100538)

	-- Ring of Twilight Shadows -- 25318
	recipe = AddRecipe(25318, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 130, 145, 160)
	recipe:SetCraftedItem(20828, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(5388, 15501, 18751, 19775, 19778, 44582, 46675, 49885, 52586, 52587, 52645, 52657, 93527, 100538)

	-- Heavy Golden Necklace of Battle -- 25320
	recipe = AddRecipe(25320, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(150, 150, 180, 195, 210)
	recipe:SetRecipeItem(20856, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(20856, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddFilters(F.DPS)
	recipe:AddLimitedVendor(1286, 1, 3367, 1, 16624, 1, 17512, 1)

	-- Moonsoul Crown -- 25321
	recipe = AddRecipe(25321, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(120, 120, 150, 165, 180)
	recipe:SetCraftedItem(20832, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_HEAD")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(5388, 15501, 18751, 19775, 19778, 44582, 46675, 49885, 52586, 52587, 52645, 52657, 93527, 100538)

	-- Wicked Moonstone Ring -- 25323
	recipe = AddRecipe(25323, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(125, 125, 155, 170, 185)
	recipe:SetRecipeItem(20855, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(20833, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddLimitedVendor(3499, 1, 3954, 1)

	-- Amulet of the Moon -- 25339
	recipe = AddRecipe(25339, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(110, 110, 140, 155, 170)
	recipe:SetRecipeItem(20854, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(20830, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddLimitedVendor(16624, 1, 17512, 1)

	-- Solid Bronze Ring -- 25490
	recipe = AddRecipe(25490, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 80, 95, 110)
	recipe:SetCraftedItem(20907, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(5388, 15501, 18751, 19775, 19778, 44582, 46675, 47384, 47396, 47400, 47418, 47419, 47421, 47431, 48619, 49885, 52586, 52587, 52645, 52657, 57620, 65043, 85916, 86010, 93527, 100538)

	-- Braided Copper Ring -- 25493
	recipe = AddRecipe(25493, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 30, 45, 60)
	recipe:SetCraftedItem(20906, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddCustom("DEFAULT_RECIPE")

	-- Barbaric Iron Collar -- 25498
	recipe = AddRecipe(25498, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(110, 110, 140, 155, 170)
	recipe:SetCraftedItem(20909, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(5388, 15501, 18751, 19775, 19778, 44582, 46675, 49885, 52586, 52587, 52645, 52657, 93527, 100538)

	-- Pendant of the Agate Shield -- 25610
	recipe = AddRecipe(25610, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(120, 120, 150, 165, 180)
	recipe:SetRecipeItem(20970, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(20950, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddFilters(F.DPS, F.TANK)
	recipe:AddTrainer(5388, 15501, 18751, 19775, 19778, 44582, 46675, 49885, 52586, 52587, 52645, 52657, 93527, 100538)

	-- Heavy Iron Knuckles -- 25612
	recipe = AddRecipe(25612, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(125, 125, 155, 170, 185)
	recipe:SetRecipeItem(20971, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(20954, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_FIST_WEAPON")
	recipe:AddTrainer(5388, 15501, 18751, 19775, 19778, 44582, 46675, 49885, 52586, 52587, 52645, 52657, 93527, 100538)
	recipe:AddLimitedVendor(2393, 1)

	-- Golden Dragon Ring -- 25613
	recipe = AddRecipe(25613, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(135, 135, 165, 180, 195)
	recipe:SetCraftedItem(20955, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddFilters(F.DPS, F.TANK)
	recipe:AddTrainer(5388, 15501, 18751, 19775, 19778, 44582, 46675, 49885, 52586, 52587, 52645, 52657, 93527, 100538)

	-- Mithril Filigree -- 25615
	recipe = AddRecipe(25615, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(150, 150, 170, 180, 190)
	recipe:SetCraftedItem(20963, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_MATERIALS")
	recipe:AddTrainer(5388, 15501, 18751, 19775, 19778, 44582, 46675, 49885, 52586, 52587, 52645, 52657, 93527, 100538)

	-- Blazing Citrine Ring -- 25617
	recipe = AddRecipe(25617, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(150, 150, 180, 195, 210)
	recipe:SetRecipeItem(20973, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(20958, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(5388, 15501, 18751, 19775, 19778, 44582, 46675, 49885, 52586, 52587, 52645, 52657, 93527, 100538)
	recipe:AddLimitedVendor(9636, 1)

	-- Jade Pendant of Blasting -- 25618
	recipe = AddRecipe(25618, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(160, 160, 190, 205, 220)
	recipe:SetRecipeItem(20974, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(20966, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- The Jade Eye -- 25619
	recipe = AddRecipe(25619, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(170, 170, 200, 215, 230)
	recipe:SetRecipeItem(20975, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(20959, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddFilters(F.TANK)
	recipe:AddLimitedVendor(4775, 1, 5163, 1, 16624, 1, 17512, 1)

	-- Engraved Truesilver Ring -- 25620
	recipe = AddRecipe(25620, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(170, 170, 200, 215, 230)
	recipe:SetCraftedItem(20960, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(5388, 15501, 18751, 19775, 19778, 44582, 46675, 52586, 52587, 52645, 52657, 93527, 100538)

	-- Citrine Ring of Rapid Healing -- 25621
	recipe = AddRecipe(25621, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(180, 180, 210, 225, 240)
	recipe:SetCraftedItem(20961, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(5388, 15501, 18751, 19775, 19778, 44582, 46675, 52586, 52587, 52645, 52657, 93527, 100538)

	-- Citrine Pendant of Golden Healing -- 25622
	recipe = AddRecipe(25622, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(190, 190, 220, 235, 250)
	recipe:SetRecipeItem(20976, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(20967, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Figurine - Jade Owl -- 26872
	recipe = AddRecipe(26872, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(200, 200, 225, 240, 255)
	recipe:SetCraftedItem(21748, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_TRINKET")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(5388, 15501, 18751, 19775, 19778, 44582, 46675, 52586, 52587, 52645, 52657, 93527, 100538)

	-- Figurine - Golden Hare -- 26873
	recipe = AddRecipe(26873, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(200, 200, 225, 240, 255)
	recipe:SetRecipeItem(21940, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(21756, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_TRINKET")
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Aquamarine Signet -- 26874
	recipe = AddRecipe(26874, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(210, 210, 235, 250, 265)
	recipe:SetCraftedItem(20964, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(5388, 15501, 18751, 19775, 19778, 44582, 46675, 52586, 52587, 52645, 52657, 93527, 100538)

	-- Figurine - Black Pearl Panther -- 26875
	recipe = AddRecipe(26875, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(215, 215, 240, 255, 270)
	recipe:SetRecipeItem(21941, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(21758, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_TRINKET")
	recipe:AddFilters(F.DPS)
	recipe:AddLimitedVendor(989, 1, 4897, 1)

	-- Aquamarine Pendant of the Warrior -- 26876
	recipe = AddRecipe(26876, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(220, 220, 245, 260, 275)
	recipe:SetCraftedItem(21755, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(5388, 15501, 18751, 19775, 19778, 44582, 46675, 52586, 52587, 52645, 52657, 93527, 100538)

	-- Ruby Crown of Restoration -- 26878
	recipe = AddRecipe(26878, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(225, 225, 250, 265, 280)
	recipe:SetRecipeItem(21942, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(20969, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_HEAD")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddLimitedVendor(2810, 1, 2821, 1)

	-- Thorium Setting -- 26880
	recipe = AddRecipe(26880, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(225, 225, 235, 245, 255)
	recipe:SetCraftedItem(21752, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_MATERIALS")
	recipe:AddTrainer(5388, 15501, 18751, 19775, 19778, 44582, 46675, 52586, 52587, 52645, 52657, 93527, 100538)

	-- Figurine - Truesilver Crab -- 26881
	recipe = AddRecipe(26881, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(225, 225, 250, 265, 280)
	recipe:SetRecipeItem(21943, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(21760, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_TRINKET")
	recipe:AddFilters(F.TANK)
	recipe:AddLimitedVendor(1148, 1, 4897, 1)

	-- Figurine - Truesilver Boar -- 26882
	recipe = AddRecipe(26882, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(235, 235, 260, 275, 290)
	recipe:SetRecipeItem(21944, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(21763, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_TRINKET")
	recipe:AddFilters(F.DPS)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Ruby Pendant of Fire -- 26883
	recipe = AddRecipe(26883, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(235, 235, 260, 275, 290)
	recipe:SetCraftedItem(21764, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(5388, 15501, 18751, 19775, 19778, 44582, 46675, 52586, 52587, 52645, 52657, 93527, 100538)

	-- Truesilver Healing Ring -- 26885
	recipe = AddRecipe(26885, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(240, 240, 265, 280, 295)
	recipe:SetCraftedItem(21765, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(5388, 15501, 18751, 19775, 19778, 44582, 46675, 52586, 52587, 52645, 52657, 93527, 100538)

	-- The Aquamarine Ward -- 26887
	recipe = AddRecipe(26887, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(245, 245, 270, 285, 300)
	recipe:SetRecipeItem(21945, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(21754, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddFilters(F.TANK)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Gem Studded Band -- 26896
	recipe = AddRecipe(26896, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(250, 250, 275, 290, 305)
	recipe:SetRecipeItem(21947, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(21753, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Opal Necklace of Impact -- 26897
	recipe = AddRecipe(26897, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(250, 250, 275, 290, 305)
	recipe:SetRecipeItem(21948, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(21766, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddFilters(F.DPS)
	recipe:AddLimitedVendor(5163, 1, 8363, 1, 16624, 1, 17512, 1)

	-- Figurine - Ruby Serpent -- 26900
	recipe = AddRecipe(26900, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(260, 260, 280, 290, 300)
	recipe:SetRecipeItem(21949, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(21769, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_TRINKET")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Simple Opal Ring -- 26902
	recipe = AddRecipe(26902, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(260, 260, 280, 290, 300)
	recipe:SetCraftedItem(21767, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(5388, 15501, 18751, 19775, 19778, 44582, 46675, 52586, 52587, 52645, 52657, 93527, 100538)

	-- Sapphire Signet -- 26903
	recipe = AddRecipe(26903, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(275, 275, 285, 295, 305)
	recipe:SetCraftedItem(21768, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddTrainer(5388, 15501, 18751, 19775, 19778, 44582, 46675, 52586, 52587, 52645, 52657, 93527, 100538)

	-- Emerald Crown of Destruction -- 26906
	recipe = AddRecipe(26906, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(275, 275, 285, 295, 305)
	recipe:SetRecipeItem(21952, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(21774, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddLimitedVendor(15179, 1)

	-- Onslaught Ring -- 26907
	recipe = AddRecipe(26907, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(280, 280, 290, 300, 310)
	recipe:SetCraftedItem(21775, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(5388, 15501, 18751, 19775, 19778, 44582, 46675, 52586, 52587, 52645, 52657, 93527, 100538)

	-- Sapphire Pendant of Winter Night -- 26908
	recipe = AddRecipe(26908, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(280, 280, 290, 300, 310)
	recipe:SetCraftedItem(21790, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(5388, 15501, 18751, 19775, 19778, 44582, 46675, 52586, 52587, 52645, 52657, 93527, 100538)

	-- Figurine - Emerald Owl -- 26909
	recipe = AddRecipe(26909, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(285, 285, 295, 305, 315)
	recipe:SetRecipeItem(21953, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(21777, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_TRINKET")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Ring of Bitter Shadows -- 26910
	recipe = AddRecipe(26910, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(285, 285, 295, 305, 315)
	recipe:SetRecipeItem(21954, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(21778, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddLimitedVendor(12941, 1)

	-- Living Emerald Pendant -- 26911
	recipe = AddRecipe(26911, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(290, 290, 300, 310, 320)
	recipe:SetCraftedItem(21791, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(5388, 15501, 18751, 19775, 19778, 44582, 46675, 52586, 52587, 52645, 52657, 93527, 100538)

	-- Figurine - Black Diamond Crab -- 26912
	recipe = AddRecipe(26912, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(300, 300, 310, 320, 330)
	recipe:SetRecipeItem(21955, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(21784, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_TRINKET")
	recipe:AddFilters(F.TANK)
	recipe:AddMobDrop(9736)

	-- Figurine - Dark Iron Scorpid -- 26914
	recipe = AddRecipe(26914, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(300, 300, 310, 320, 330)
	recipe:SetRecipeItem(21956, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(21789, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_TRINKET")
	recipe:AddFilters(F.DPS)
	recipe:AddMobDrop(8983)

	-- Necklace of the Diamond Tower -- 26915
	recipe = AddRecipe(26915, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(305, 305, 315, 325, 335)
	recipe:SetRecipeItem(21957, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(21792, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddFilters(F.TANK)
	recipe:AddLimitedVendor(11189, 1)

	-- Woven Copper Ring -- 26925
	recipe = AddRecipe(26925, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 30, 45, 60)
	recipe:SetCraftedItem(21931, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddCustom("DEFAULT_RECIPE")

	-- Heavy Copper Ring -- 26926
	recipe = AddRecipe(26926, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(5, 5, 35, 50, 65)
	recipe:SetCraftedItem(21932, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddTrainer(5388, 15501, 18751, 19775, 19778, 44582, 46675, 47384, 47396, 47400, 47418, 47419, 47421, 47431, 48619, 49885, 52586, 52587, 52645, 52657, 57620, 65043, 85916, 86010, 93527, 100538)

	-- Thick Bronze Necklace -- 26927
	recipe = AddRecipe(26927, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 80, 95, 110)
	recipe:SetCraftedItem(21933, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddTrainer(5388, 15501, 18751, 19775, 19778, 44582, 46675, 47384, 47396, 47400, 47418, 47419, 47421, 47431, 48619, 49885, 52586, 52587, 52645, 52657, 57620, 65043, 85916, 86010, 93527, 100538)

	-- Ornate Tigerseye Necklace -- 26928
	recipe = AddRecipe(26928, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(30, 30, 60, 75, 90)
	recipe:SetCraftedItem(21934, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(5388, 15501, 18751, 19775, 19778, 44582, 46675, 47384, 47396, 47400, 47418, 47419, 47421, 47431, 48619, 49885, 52586, 52587, 52645, 52657, 57620, 65043, 85916, 86010, 93527, 100538)

	-- Malachite Pendant -- 32178
	recipe = AddRecipe(32178, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(20, 20, 50, 65, 80)
	recipe:SetCraftedItem(25438, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(5388, 15501, 18751, 19775, 19778, 44582, 46675, 47384, 47396, 47400, 47418, 47419, 47421, 47431, 48619, 49885, 52586, 52587, 52645, 52657, 57620, 65043, 85916, 86010, 93527, 100538)

	-- Tigerseye Band -- 32179
	recipe = AddRecipe(32179, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(20, 20, 50, 65, 80)
	recipe:SetCraftedItem(25439, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(5388, 15501, 18751, 19775, 19778, 44582, 46675, 47384, 47396, 47400, 47418, 47419, 47421, 47431, 48619, 49885, 52586, 52587, 52645, 52657, 57620, 65043, 85916, 86010, 93527, 100538)

	-- Rough Stone Statue -- 32259
	recipe = AddRecipe(32259, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 30, 40, 50)
	recipe:SetCraftedItem(25498, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_CREATED_ITEM")
	recipe:AddCustom("DEFAULT_RECIPE")

	-- Coarse Stone Statue -- 32801
	recipe = AddRecipe(32801, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 70, 80, 90)
	recipe:SetCraftedItem(25880, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_CREATED_ITEM")
	recipe:AddTrainer(5388, 15501, 18751, 19775, 19778, 44582, 46675, 47384, 47396, 47400, 47418, 47419, 47421, 47431, 48619, 49885, 52586, 52587, 52645, 52657, 57620, 65043, 85916, 86010, 93527, 100538)

	-- Heavy Stone Statue -- 32807
	recipe = AddRecipe(32807, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(110, 110, 120, 130, 140)
	recipe:SetCraftedItem(25881, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_CREATED_ITEM")
	recipe:AddTrainer(5388, 15501, 18751, 19775, 19778, 44582, 46675, 49885, 52586, 52587, 52645, 52657, 93527, 100538)

	-- Solid Stone Statue -- 32808
	recipe = AddRecipe(32808, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(175, 175, 175, 185, 195)
	recipe:SetCraftedItem(25882, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_CREATED_ITEM")
	recipe:AddTrainer(5388, 15501, 18751, 19775, 19778, 44582, 46675, 52586, 52587, 52645, 52657, 93527, 100538)

	-- Dense Stone Statue -- 32809
	recipe = AddRecipe(32809, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(225, 225, 225, 235, 245)
	recipe:SetCraftedItem(25883, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_CREATED_ITEM")
	recipe:AddTrainer(5388, 15501, 18751, 19775, 19778, 44582, 46675, 52586, 52587, 52645, 52657, 93527, 100538)

	-- Golden Ring of Power -- 34955
	recipe = AddRecipe(34955, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(180, 180, 190, 200, 210)
	recipe:SetCraftedItem(29157, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(5388, 15501, 18751, 19775, 19778, 44582, 46675, 52586, 52587, 52645, 52657, 93527, 100538)

	-- Truesilver Commander's Ring -- 34959
	recipe = AddRecipe(34959, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(200, 200, 210, 220, 230)
	recipe:SetCraftedItem(29158, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(5388, 15501, 18751, 19775, 19778, 44582, 46675, 52586, 52587, 52645, 52657, 93527, 100538)

	-- Glowing Thorium Band -- 34960
	recipe = AddRecipe(34960, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(280, 280, 290, 300, 310)
	recipe:SetCraftedItem(29159, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(5388, 15501, 18751, 19775, 19778, 44582, 46675, 52586, 52587, 52645, 52657, 93527, 100538)

	-- Emerald Lion Ring -- 34961
	recipe = AddRecipe(34961, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(290, 290, 300, 310, 320)
	recipe:SetCraftedItem(29160, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(5388, 15501, 18751, 19775, 19778, 44582, 46675, 52586, 52587, 52645, 52657, 93527, 100538)

	-- Brilliant Necklace -- 36523
	recipe = AddRecipe(36523, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 105, 120, 135)
	recipe:SetCraftedItem(30419, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(5388, 15501, 18751, 19775, 19778, 44582, 46675, 47384, 47396, 47400, 47418, 47419, 47421, 47431, 48619, 49885, 52586, 52587, 52645, 52657, 57620, 65043, 85916, 86010, 93527, 100538)

	-- Heavy Jade Ring -- 36524
	recipe = AddRecipe(36524, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(105, 105, 135, 150, 165)
	recipe:SetCraftedItem(30420, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(5388, 15501, 18751, 19775, 19778, 44582, 46675, 49885, 52586, 52587, 52645, 52657, 93527, 100538)

	-- Red Ring of Destruction -- 36525
	recipe = AddRecipe(36525, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(230, 230, 255, 270, 285)
	recipe:SetCraftedItem(30421, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(5388, 15501, 18751, 19775, 19778, 44582, 46675, 52586, 52587, 52645, 52657, 93527, 100538)

	-- Diamond Focus Ring -- 36526
	recipe = AddRecipe(36526, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(265, 265, 285, 295, 305)
	recipe:SetCraftedItem(30422, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(5388, 15501, 18751, 19775, 19778, 44582, 46675, 52586, 52587, 52645, 52657, 93527, 100538)

	-- Bronze Band of Force -- 37818
	recipe = AddRecipe(37818, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(65, 65, 95, 110, 125)
	recipe:SetCraftedItem(30804, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(5388, 15501, 18751, 19775, 19778, 44582, 46675, 47384, 47396, 47400, 47418, 47419, 47421, 47431, 48619, 49885, 52586, 52587, 52645, 52657, 57620, 65043, 85916, 86010, 93527, 100538)

	-- Bronze Torc -- 38175
	recipe = AddRecipe(38175, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(80, 80, 110, 125, 140)
	recipe:SetCraftedItem(31154, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddTrainer(5388, 15501, 18751, 19775, 19778, 44582, 46675, 49885, 52586, 52587, 52645, 52657, 93527, 100538)

	-- Amulet of Truesight -- 63743
	recipe = AddRecipe(63743, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(200, 200, 210, 220, 230)
	recipe:SetCraftedItem(45627, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(5388, 15501, 18751, 19775, 19778, 44582, 46675, 52586, 52587, 52645, 52657, 93527, 100538)

	-- ----------------------------------------------------------------------------
	-- The Burning Crusade.
	-- ----------------------------------------------------------------------------
	-- Band of Natural Fire -- 26916
	recipe = AddRecipe(26916, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(10, 10, 20, 25, 30)
	recipe:SetCraftedItem(21779, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(15501, 18751, 18774, 19063, 19539, 19775, 33614, 33637, 33680, 46675, 93527, 100538)

	-- Brilliant Blood Garnet -- 28903
	recipe = AddRecipe(28903, V.TBC, Q.UNCOMMON)
	recipe:SetSkillLevels(300, 300, 300, 320, 340)
	recipe:SetRecipeItem(23133, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(23094, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_RED")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddRepVendor(FAC.THE_SCRYERS, REP.FRIENDLY, 19331)

	-- Bold Blood Garnet -- 28905
	recipe = AddRecipe(28905, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(23095, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_RED")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(15501, 18751, 18774, 19063, 19539, 19775, 33614, 33637, 33680, 46675, 93527, 100538)

	-- Inscribed Flame Spessarite -- 28910
	recipe = AddRecipe(28910, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(23098, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(15501, 18751, 18774, 19063, 19539, 19775, 33614, 33637, 33680, 46675, 93527, 100538)

	-- Reckless Flame Spessarite -- 28912
	recipe = AddRecipe(28912, V.TBC, Q.UNCOMMON)
	recipe:SetSkillLevels(305, 305, 305, 325, 345)
	recipe:SetRecipeItem(23136, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(23099, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddRepVendor(FAC.THE_CONSORTIUM, REP.FRIENDLY, 20242, 23007)

	-- Glinting Shadow Draenite -- 28914
	recipe = AddRecipe(28914, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(15, 15, 25, 30, 35)
	recipe:SetCraftedItem(23100, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(15501, 18751, 18774, 19063, 19539, 19775, 33614, 33637, 33680, 46675, 93527, 100538)

	-- Potent Flame Spessarite -- 28915
	recipe = AddRecipe(28915, V.TBC, Q.UNCOMMON)
	recipe:SetSkillLevels(325, 325, 325, 340, 355)
	recipe:SetRecipeItem(23138, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(23101, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddRepVendor(FAC.LOWER_CITY, REP.FRIENDLY, 21655)

	-- Radiant Deep Peridot -- 28916
	recipe = AddRecipe(28916, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(23103, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(15501, 18751, 18774, 19063, 19539, 19775, 33614, 33637, 33680, 46675, 93527, 100538)

	-- Jagged Deep Peridot -- 28917
	recipe = AddRecipe(28917, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(23104, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(15501, 18751, 18774, 19063, 19539, 19775, 33614, 33637, 33680, 46675, 93527, 100538)

	-- Regal Deep Peridot -- 28918
	recipe = AddRecipe(28918, V.TBC, Q.UNCOMMON)
	recipe:SetSkillLevels(315, 315, 315, 335, 355)
	recipe:SetRecipeItem(23142, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(23105, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddFilters(F.TANK)
	recipe:AddRepVendor(FAC.HONOR_HOLD, REP.FRIENDLY, 17657)
	recipe:AddRepVendor(FAC.THRALLMAR, REP.FRIENDLY, 17585)

	-- Timeless Shadow Draenite -- 28925
	recipe = AddRecipe(28925, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(23108, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(15501, 18751, 18774, 19063, 19539, 19775, 33614, 33637, 33680, 46675, 93527, 100538)

	-- Purified Shadow Draenite -- 28927
	recipe = AddRecipe(28927, V.TBC, Q.UNCOMMON)
	recipe:SetSkillLevels(305, 305, 305, 325, 345)
	recipe:SetRecipeItem(23145, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(23109, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddRepVendor(FAC.THE_ALDOR, REP.HONORED, 19321)

	-- Shifting Shadow Draenite -- 28933
	recipe = AddRecipe(28933, V.TBC, Q.UNCOMMON)
	recipe:SetSkillLevels(315, 315, 315, 335, 355)
	recipe:SetRecipeItem(23146, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(23110, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.DPS)
	recipe:AddRepVendor(FAC.THE_CONSORTIUM, REP.FRIENDLY, 20242, 23007)

	-- Sovereign Shadow Draenite -- 28936
	recipe = AddRecipe(28936, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(23111, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(15501, 18751, 18774, 19063, 19539, 19775, 33614, 33637, 33680, 46675, 93527, 100538)

	-- Smooth Golden Draenite -- 28944
	recipe = AddRecipe(28944, V.TBC, Q.UNCOMMON)
	recipe:SetSkillLevels(305, 305, 305, 325, 345)
	recipe:SetRecipeItem(23149, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(23114, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_YELLOW")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddRepVendor(FAC.THE_ALDOR, REP.FRIENDLY, 19321)

	-- Subtle Golden Draenite -- 28947
	recipe = AddRecipe(28947, V.TBC, Q.UNCOMMON)
	recipe:SetSkillLevels(315, 315, 315, 335, 355)
	recipe:SetRecipeItem(23150, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(23115, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_YELLOW")
	recipe:AddFilters(F.TANK)
	recipe:AddRepVendor(FAC.THE_CONSORTIUM, REP.HONORED, 20242, 23007)

	-- Rigid Azure Moonstone -- 28948
	recipe = AddRecipe(28948, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(23116, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_BLUE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(15501, 18751, 18774, 19063, 19539, 19775, 33614, 33637, 33680, 46675, 93527, 100538)

	-- Solid Azure Moonstone -- 28950
	recipe = AddRecipe(28950, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(23118, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_BLUE")
	recipe:AddTrainer(15501, 18751, 18774, 19063, 19539, 19775, 33614, 33637, 33680, 46675, 93527, 100538)

	-- Sparkling Azure Moonstone -- 28953
	recipe = AddRecipe(28953, V.TBC, Q.UNCOMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetRecipeItem(23155, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(23119, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_BLUE")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(15501, 18751, 18774, 19063, 19539, 19775, 33614, 33637, 33680, 46675, 93527, 100538)
	recipe:AddVendor(20242, 23007)

	-- Stormy Azure Moonstone -- 28955
	recipe = AddRecipe(28955, V.TBC, Q.UNCOMMON)
	recipe:SetSkillLevels(315, 315, 315, 335, 355)
	recipe:SetRecipeItem(23154, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(23120, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_BLUE")
	recipe:AddWorldDrop(Z.OUTLAND)

	-- Fel Iron Blood Ring -- 31048
	recipe = AddRecipe(31048, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(5, 5, 15, 20, 25)
	recipe:SetCraftedItem(24074, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(15501, 18751, 18774, 19063, 19539, 19775, 33614, 33637, 33680, 46675, 93527, 100538)

	-- Golden Draenite Ring -- 31049
	recipe = AddRecipe(31049, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(5, 5, 15, 20, 25)
	recipe:SetCraftedItem(24075, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(15501, 18751, 18774, 19063, 19539, 19775, 33614, 33637, 33680, 46675, 93527, 100538)

	-- Azure Moonstone Ring -- 31050
	recipe = AddRecipe(31050, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(20, 20, 30, 35, 40)
	recipe:SetCraftedItem(24076, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(15501, 18751, 18774, 19063, 19539, 19775, 33614, 33637, 33680, 46675, 93527, 100538)

	-- Thick Adamantite Necklace -- 31051
	recipe = AddRecipe(31051, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(35, 35, 45, 50, 55)
	recipe:SetCraftedItem(24077, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddTrainer(15501, 18751, 18774, 19063, 19539, 19775, 33614, 33637, 33680, 46675, 93527, 100538)

	-- Heavy Adamantite Ring -- 31052
	recipe = AddRecipe(31052, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(35, 35, 45, 50, 55)
	recipe:SetCraftedItem(24078, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddTrainer(15501, 18751, 18774, 19063, 19539, 19775, 33614, 33637, 33680, 46675, 93527, 100538)

	-- Khorium Band of Shadows -- 31053
	recipe = AddRecipe(31053, V.TBC, Q.RARE)
	recipe:SetSkillLevels(350, 350, 360, 370, 380)
	recipe:SetRecipeItem(24158, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(24079, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddMobDrop(19826)

	-- Khorium Band of Frost -- 31054
	recipe = AddRecipe(31054, V.TBC, Q.RARE)
	recipe:SetSkillLevels(355, 355, 365, 372, 380)
	recipe:SetRecipeItem(24159, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(24080, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddMobDrop(17722)

	-- Khorium Inferno Band -- 31055
	recipe = AddRecipe(31055, V.TBC, Q.RARE)
	recipe:SetSkillLevels(355, 355, 365, 372, 380)
	recipe:SetRecipeItem(24160, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(24082, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddMobDrop(18472)

	-- Khorium Band of Leaves -- 31056
	recipe = AddRecipe(31056, V.TBC, Q.RARE)
	recipe:SetSkillLevels(360, 360, 370, 375, 380)
	recipe:SetRecipeItem(24161, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(24085, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddMobDrop(19984)

	-- Arcane Khorium Band -- 31057
	recipe = AddRecipe(31057, V.TBC, Q.RARE)
	recipe:SetSkillLevels(365, 365, 370, 375, 380)
	recipe:SetRecipeItem(24162, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(24086, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddMobDrop(18866)

	-- Heavy Felsteel Ring -- 31058
	recipe = AddRecipe(31058, V.TBC, Q.RARE)
	recipe:SetSkillLevels(345, 345, 355, 365, 375)
	recipe:SetRecipeItem(24163, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(24087, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddFilters(F.DPS)
	recipe:AddWorldDrop(Z.OUTLAND)

	-- Delicate Eternium Ring -- 31060
	recipe = AddRecipe(31060, V.TBC, Q.RARE)
	recipe:SetSkillLevels(355, 355, 365, 375, 385)
	recipe:SetRecipeItem(24164, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(24088, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddFilters(F.DPS, F.TANK)
	recipe:AddWorldDrop(Z.OUTLAND)

	-- Blazing Eternium Band -- 31061
	recipe = AddRecipe(31061, V.TBC, Q.RARE)
	recipe:SetSkillLevels(365, 365, 375, 377, 380)
	recipe:SetRecipeItem(24165, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(24089, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddWorldDrop(Z.OUTLAND)

	-- Pendant of Frozen Flame -- 31062
	recipe = AddRecipe(31062, V.TBC, Q.RARE)
	recipe:SetSkillLevels(360, 360, 370, 375, 380)
	recipe:SetRecipeItem(24174, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(24092, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddRepVendor(FAC.KEEPERS_OF_TIME, REP.REVERED, 21643)

	-- Pendant of Thawing -- 31063
	recipe = AddRecipe(31063, V.TBC, Q.RARE)
	recipe:SetSkillLevels(360, 360, 370, 375, 380)
	recipe:SetRecipeItem(24175, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(24093, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddRepVendor(FAC.LOWER_CITY, REP.REVERED, 21655)

	-- Pendant of Withering -- 31064
	recipe = AddRecipe(31064, V.TBC, Q.RARE)
	recipe:SetSkillLevels(360, 360, 370, 375, 380)
	recipe:SetRecipeItem(24176, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(24095, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddRepVendor(FAC.THE_SCRYERS, REP.REVERED, 19331)

	-- Pendant of Shadow's End -- 31065
	recipe = AddRecipe(31065, V.TBC, Q.RARE)
	recipe:SetSkillLevels(360, 360, 370, 375, 380)
	recipe:SetRecipeItem(24177, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(24097, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddRepVendor(FAC.THE_ALDOR, REP.REVERED, 19321)

	-- Pendant of the Null Rune -- 31066
	recipe = AddRecipe(31066, V.TBC, Q.RARE)
	recipe:SetSkillLevels(360, 360, 370, 375, 380)
	recipe:SetRecipeItem(24178, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(24098, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddRepVendor(FAC.THE_CONSORTIUM, REP.REVERED, 20242, 23007)

	-- Thick Felsteel Necklace -- 31067
	recipe = AddRecipe(31067, V.TBC, Q.RARE)
	recipe:SetSkillLevels(355, 355, 365, 375, 385)
	recipe:SetRecipeItem(24166, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(24106, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddWorldDrop(Z.OUTLAND)

	-- Living Ruby Pendant -- 31068
	recipe = AddRecipe(31068, V.TBC, Q.RARE)
	recipe:SetSkillLevels(355, 355, 365, 375, 385)
	recipe:SetRecipeItem(24167, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(24110, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddWorldDrop(Z.OUTLAND)

	-- Braided Eternium Chain -- 31070
	recipe = AddRecipe(31070, V.TBC, Q.RARE)
	recipe:SetSkillLevels(360, 360, 370, 377, 385)
	recipe:SetRecipeItem(24168, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(24114, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.OUTLAND)

	-- Eye of the Night -- 31071
	recipe = AddRecipe(31071, V.TBC, Q.RARE)
	recipe:SetSkillLevels(360, 360, 370, 375, 380)
	recipe:SetRecipeItem(24169, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(24116, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.OUTLAND)

	-- Embrace of the Dawn -- 31072
	recipe = AddRecipe(31072, V.TBC, Q.RARE)
	recipe:SetSkillLevels(365, 365, 375, 380, 385)
	recipe:SetRecipeItem(24170, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(24117, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddWorldDrop(Z.OUTLAND)

	-- Chain of the Twilight Owl -- 31076
	recipe = AddRecipe(31076, V.TBC, Q.RARE)
	recipe:SetSkillLevels(365, 365, 375, 380, 385)
	recipe:SetRecipeItem(24171, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(24121, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddFilters(F.CASTER, F.HEALER, F.TANK)
	recipe:AddWorldDrop(Z.OUTLAND)

	-- Coronet of Verdant Flame -- 31077
	recipe = AddRecipe(31077, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(370, 370, 375, 380, 385)
	recipe:SetRecipeItem(24172, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(24122, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_HEAD")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddMobDrop(18422)

	-- Circlet of Arcane Might -- 31078
	recipe = AddRecipe(31078, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(370, 370, 375, 380, 385)
	recipe:SetRecipeItem(24173, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(24123, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_HEAD")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddMobDrop(18096)

	-- Figurine - Felsteel Boar -- 31079
	recipe = AddRecipe(31079, V.TBC, Q.RARE)
	recipe:SetSkillLevels(370, 370, 375, 380, 385)
	recipe:SetRecipeItem(24179, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(24124, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_TRINKET")
	recipe:AddFilters(F.DPS)
	recipe:AddRepVendor(FAC.LOWER_CITY, REP.REVERED, 21655)

	-- Figurine - Dawnstone Crab -- 31080
	recipe = AddRecipe(31080, V.TBC, Q.RARE)
	recipe:SetSkillLevels(370, 370, 375, 380, 385)
	recipe:SetRecipeItem(31358, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(24125, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_TRINKET")
	recipe:AddFilters(F.TANK)
	recipe:AddRepVendor(FAC.HONOR_HOLD, REP.REVERED, 17657)
	recipe:AddRepVendor(FAC.THRALLMAR, REP.REVERED, 17585)

	-- Figurine - Living Ruby Serpent -- 31081
	recipe = AddRecipe(31081, V.TBC, Q.RARE)
	recipe:SetSkillLevels(370, 370, 375, 380, 385)
	recipe:SetRecipeItem(24181, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(24126, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_TRINKET")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddRepVendor(FAC.KEEPERS_OF_TIME, REP.REVERED, 21643)

	-- Figurine - Talasite Owl -- 31082
	recipe = AddRecipe(31082, V.TBC, Q.RARE)
	recipe:SetSkillLevels(370, 370, 375, 380, 385)
	recipe:SetRecipeItem(24182, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(24127, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_TRINKET")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddRepVendor(FAC.THE_SHATAR, REP.REVERED, 21432)

	-- Figurine - Nightseye Panther -- 31083
	recipe = AddRecipe(31083, V.TBC, Q.RARE)
	recipe:SetSkillLevels(370, 370, 375, 380, 385)
	recipe:SetRecipeItem(24183, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(24128, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_TRINKET")
	recipe:AddFilters(F.DPS)
	recipe:AddRepVendor(FAC.CENARION_EXPEDITION, REP.REVERED, 17904)

	-- Bold Living Ruby -- 31084
	recipe = AddRecipe(31084, V.TBC, Q.RARE)
	recipe:SetSkillLevels(350, 350, 350, 365, 380)
	recipe:SetRecipeItem(24193, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(24027, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_RED")
	recipe:AddFilters(F.DPS)
	recipe:AddWorldDrop(Z.OUTLAND)

	-- Delicate Living Ruby -- 31085
	recipe = AddRecipe(31085, V.TBC, Q.RARE)
	recipe:SetSkillLevels(350, 350, 350, 365, 380)
	recipe:SetRecipeItem(24194, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(24028, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_RED")
	recipe:AddFilters(F.DPS)
	recipe:AddWorldDrop(Z.OUTLAND)

	-- Brilliant Living Ruby -- 31088
	recipe = AddRecipe(31088, V.TBC, Q.RARE)
	recipe:SetSkillLevels(350, 350, 350, 365, 380)
	recipe:SetRecipeItem(35305, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(24030, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_RED")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddMobDrop(24664)
	recipe:AddWorldDrop(Z.OUTLAND)

	-- Subtle Dawnstone -- 31090
	recipe = AddRecipe(31090, V.TBC, Q.RARE)
	recipe:SetSkillLevels(350, 350, 350, 365, 380)
	recipe:SetRecipeItem(24197, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(24032, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_YELLOW")
	recipe:AddFilters(F.TANK)
	recipe:AddWorldDrop(Z.OUTLAND)

	-- Flashing Living Ruby -- 31091
	recipe = AddRecipe(31091, V.TBC, Q.RARE)
	recipe:SetSkillLevels(350, 350, 350, 365, 380)
	recipe:SetRecipeItem(24198, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(24036, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_RED")
	recipe:AddFilters(F.TANK)
	recipe:AddWorldDrop(Z.OUTLAND)

	-- Solid Star of Elune -- 31092
	recipe = AddRecipe(31092, V.TBC, Q.RARE)
	recipe:SetSkillLevels(350, 350, 350, 365, 380)
	recipe:SetRecipeItem(35304, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(24033, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_BLUE")
	recipe:AddMobDrop(24664)
	recipe:AddWorldDrop(Z.OUTLAND)

	-- Stormy Star of Elune -- 31095
	recipe = AddRecipe(31095, V.TBC, Q.RARE)
	recipe:SetSkillLevels(350, 350, 350, 365, 380)
	recipe:SetRecipeItem(24202, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(24039, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_BLUE")
	recipe:AddWorldDrop(Z.OUTLAND)

	-- Smooth Dawnstone -- 31097
	recipe = AddRecipe(31097, V.TBC, Q.RARE)
	recipe:SetSkillLevels(350, 350, 350, 365, 380)
	recipe:SetRecipeItem(24204, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(24048, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_YELLOW")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.OUTLAND)

	-- Rigid Star of Elune -- 31098
	recipe = AddRecipe(31098, V.TBC, Q.RARE)
	recipe:SetSkillLevels(350, 350, 350, 365, 380)
	recipe:SetRecipeItem(35307, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(24051, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_BLUE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddMobDrop(24664)
	recipe:AddWorldDrop(Z.OUTLAND)

	-- Mystic Dawnstone -- 31101
	recipe = AddRecipe(31101, V.TBC, Q.RARE)
	recipe:SetSkillLevels(350, 350, 350, 365, 380)
	recipe:SetRecipeItem(24208, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(24053, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_YELLOW")
	recipe:AddVendor(21474, 21485)

	-- Sovereign Nightseye -- 31102
	recipe = AddRecipe(31102, V.TBC, Q.RARE)
	recipe:SetSkillLevels(350, 350, 350, 365, 380)
	recipe:SetRecipeItem(24209, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(24054, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.DPS)
	recipe:AddWorldDrop(Z.OUTLAND)

	-- Shifting Nightseye -- 31103
	recipe = AddRecipe(31103, V.TBC, Q.RARE)
	recipe:SetSkillLevels(350, 350, 350, 365, 380)
	recipe:SetRecipeItem(24210, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(24055, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.DPS)
	recipe:AddWorldDrop(Z.OUTLAND)

	-- Timeless Nightseye -- 31104
	recipe = AddRecipe(31104, V.TBC, Q.RARE)
	recipe:SetSkillLevels(350, 350, 350, 365, 380)
	recipe:SetRecipeItem(24211, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(24056, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddWorldDrop(Z.OUTLAND)

	-- Inscribed Noble Topaz -- 31106
	recipe = AddRecipe(31106, V.TBC, Q.RARE)
	recipe:SetSkillLevels(350, 350, 350, 365, 380)
	recipe:SetRecipeItem(24213, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(24058, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.OUTLAND)

	-- Potent Noble Topaz -- 31107
	recipe = AddRecipe(31107, V.TBC, Q.RARE)
	recipe:SetSkillLevels(350, 350, 350, 365, 380)
	recipe:SetRecipeItem(24214, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(24059, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.OUTLAND)

	-- Reckless Noble Topaz -- 31108
	recipe = AddRecipe(31108, V.TBC, Q.RARE)
	recipe:SetSkillLevels(350, 350, 350, 365, 380)
	recipe:SetRecipeItem(24215, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(24060, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.OUTLAND)

	-- Glinting Nightseye -- 31109
	recipe = AddRecipe(31109, V.TBC, Q.RARE)
	recipe:SetSkillLevels(350, 350, 350, 365, 380)
	recipe:SetRecipeItem(24216, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(24061, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.OUTLAND)

	-- Radiant Talasite -- 31111
	recipe = AddRecipe(31111, V.TBC, Q.RARE)
	recipe:SetSkillLevels(350, 350, 350, 365, 380)
	recipe:SetRecipeItem(24218, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(24066, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.OUTLAND)

	-- Purified Nightseye -- 31112
	recipe = AddRecipe(31112, V.TBC, Q.RARE)
	recipe:SetSkillLevels(350, 350, 350, 365, 380)
	recipe:SetRecipeItem(24219, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(24065, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddWorldDrop(Z.OUTLAND)

	-- Jagged Talasite -- 31113
	recipe = AddRecipe(31113, V.TBC, Q.RARE)
	recipe:SetSkillLevels(350, 350, 350, 365, 380)
	recipe:SetRecipeItem(24220, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(24067, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.OUTLAND)

	-- Sparkling Star of Elune -- 31149
	recipe = AddRecipe(31149, V.TBC, Q.RARE)
	recipe:SetSkillLevels(350, 350, 350, 365, 380)
	recipe:SetRecipeItem(24200, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(24035, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_BLUE")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddWorldDrop(Z.OUTLAND)

	-- Powerful Earthstorm Diamond -- 32866
	recipe = AddRecipe(32866, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(365, 365, 375, 377, 380)
	recipe:SetRecipeItem(25902, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(25896, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_META")
	recipe:AddRepVendor(FAC.THE_CONSORTIUM, REP.HONORED, 17518)

	-- Bracing Earthstorm Diamond -- 32867
	recipe = AddRecipe(32867, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(365, 365, 375, 377, 380)
	recipe:SetRecipeItem(25903, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(25897, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_META")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddRepVendor(FAC.THE_CONSORTIUM, REP.REVERED, 17518)

	-- Tenacious Earthstorm Diamond -- 32868
	recipe = AddRecipe(32868, V.TBC, Q.RARE)
	recipe:SetSkillLevels(365, 365, 375, 377, 380)
	recipe:SetRecipeItem(25905, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(25898, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_META")
	recipe:AddFilters(F.TANK)
	recipe:AddWorldDrop(Z.OUTLAND)

	-- Brutal Earthstorm Diamond -- 32869
	recipe = AddRecipe(32869, V.TBC, Q.RARE)
	recipe:SetSkillLevels(365, 365, 375, 377, 380)
	recipe:SetRecipeItem(25906, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(25899, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_META")
	recipe:AddWorldDrop(Z.OUTLAND)

	-- Insightful Earthstorm Diamond -- 32870
	recipe = AddRecipe(32870, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(365, 365, 375, 377, 380)
	recipe:SetRecipeItem(25904, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(25901, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_META")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddRepVendor(FAC.THE_SHATAR, REP.FRIENDLY, 21432)

	-- Destructive Skyfire Diamond -- 32871
	recipe = AddRecipe(32871, V.TBC, Q.RARE)
	recipe:SetSkillLevels(365, 365, 375, 377, 380)
	recipe:SetRecipeItem(25907, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(25890, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_META")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.OUTLAND)

	-- Mystical Skyfire Diamond -- 32872
	recipe = AddRecipe(32872, V.TBC, Q.RARE)
	recipe:SetSkillLevels(365, 365, 375, 377, 380)
	recipe:SetRecipeItem(25909, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(25893, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_META")
	recipe:AddWorldDrop(Z.OUTLAND)

	-- Swift Skyfire Diamond -- 32873
	recipe = AddRecipe(32873, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(365, 365, 375, 377, 380)
	recipe:SetRecipeItem(25908, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(25894, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_META")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddRepVendor(FAC.THE_CONSORTIUM, REP.HONORED, 20242, 23007)

	-- Enigmatic Skyfire Diamond -- 32874
	recipe = AddRecipe(32874, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(365, 365, 375, 377, 380)
	recipe:SetRecipeItem(25910, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(25895, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_META")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddRepVendor(FAC.KEEPERS_OF_TIME, REP.HONORED, 21643)

	-- Delicate Blood Garnet -- 34590
	recipe = AddRecipe(34590, V.TBC, Q.UNCOMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetRecipeItem(23134, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(28595, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_RED")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(15501, 18751, 18774, 19063, 19539, 19775, 33614, 33637, 33680, 46675, 93527, 100538)
	recipe:AddVendor(20242, 23007)

	-- Ring of Arcane Shielding -- 37855
	recipe = AddRecipe(37855, V.TBC, Q.RARE)
	recipe:SetSkillLevels(360, 360, 370, 375, 380)
	recipe:SetRecipeItem(30826, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(30825, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddRepVendor(FAC.THE_SHATAR, REP.HONORED, 21432)

	-- Mercurial Adamantite -- 38068
	recipe = AddRecipe(38068, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(31079, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_MATERIALS")
	recipe:AddTrainer(15501, 18751, 18774, 19063, 19539, 19775, 33614, 33637, 33680, 46675, 93527, 100538)

	-- The Frozen Eye -- 38503
	recipe = AddRecipe(38503, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(375, 375, 375, 380, 385)
	recipe:SetRecipeItem(31401, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(31398, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddRepVendor(FAC.THE_VIOLET_EYE, REP.HONORED, 18255)

	-- The Natural Ward -- 38504
	recipe = AddRecipe(38504, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(375, 375, 375, 380, 385)
	recipe:SetRecipeItem(31402, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(31399, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddRepVendor(FAC.CENARION_EXPEDITION, REP.EXALTED, 17904)

	-- Veiled Shadow Draenite -- 39466
	recipe = AddRecipe(39466, V.TBC, Q.UNCOMMON)
	recipe:SetSkillLevels(325, 325, 325, 340, 355)
	recipe:SetRecipeItem(31873, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(31866, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddCustom("OGRI_DRAGONS")

	-- Deadly Flame Spessarite -- 39467
	recipe = AddRecipe(39467, V.TBC, Q.UNCOMMON)
	recipe:SetSkillLevels(325, 325, 325, 340, 355)
	recipe:SetRecipeItem(31874, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(31869, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddCustom("OGRI_DRAGONS")

	-- Veiled Nightseye -- 39470
	recipe = AddRecipe(39470, V.TBC, Q.RARE)
	recipe:SetSkillLevels(350, 350, 350, 365, 380)
	recipe:SetRecipeItem(31878, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(31867, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.OUTLAND)

	-- Deadly Noble Topaz -- 39471
	recipe = AddRecipe(39471, V.TBC, Q.RARE)
	recipe:SetSkillLevels(350, 350, 350, 365, 380)
	recipe:SetRecipeItem(31879, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(31868, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.OUTLAND)

	-- Bold Crimson Spinel -- 39705
	recipe = AddRecipe(39705, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 375, 380, 385)
	recipe:SetRecipeItem(35244, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(32193, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_RED")
	recipe:AddFilters(F.DPS)
	recipe:AddRepVendor(FAC.SHATTERED_SUN_OFFENSIVE, REP.FRIENDLY, 25950, 27666)
	recipe:AddRepVendor(FAC.THE_SCALE_OF_THE_SANDS, REP.FRIENDLY, 23437)

	-- Delicate Crimson Spinel -- 39706
	recipe = AddRecipe(39706, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 375, 380, 385)
	recipe:SetRecipeItem(35246, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(32194, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_RED")
	recipe:AddFilters(F.DPS)
	recipe:AddRepVendor(FAC.SHATTERED_SUN_OFFENSIVE, REP.FRIENDLY, 25950, 27666)
	recipe:AddRepVendor(FAC.THE_SCALE_OF_THE_SANDS, REP.FRIENDLY, 23437)

	-- Brilliant Crimson Spinel -- 39711
	recipe = AddRecipe(39711, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 375, 380, 385)
	recipe:SetRecipeItem(35248, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(32196, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_RED")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddRepVendor(FAC.SHATTERED_SUN_OFFENSIVE, REP.FRIENDLY, 25950, 27666)
	recipe:AddRepVendor(FAC.THE_SCALE_OF_THE_SANDS, REP.FRIENDLY, 23437)

	-- Subtle Lionseye -- 39713
	recipe = AddRecipe(39713, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 375, 380, 385)
	recipe:SetRecipeItem(35249, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(32198, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_YELLOW")
	recipe:AddFilters(F.TANK)
	recipe:AddRepVendor(FAC.SHATTERED_SUN_OFFENSIVE, REP.FRIENDLY, 25950, 27666)
	recipe:AddRepVendor(FAC.THE_SCALE_OF_THE_SANDS, REP.FRIENDLY, 23437)

	-- Flashing Crimson Spinel -- 39714
	recipe = AddRecipe(39714, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 375, 380, 385)
	recipe:SetRecipeItem(35247, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(32199, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_RED")
	recipe:AddFilters(F.TANK)
	recipe:AddRepVendor(FAC.SHATTERED_SUN_OFFENSIVE, REP.EXALTED, 25950, 27666)
	recipe:AddWorldDrop(Z.MOUNT_HYJAL)

	-- Solid Empyrean Sapphire -- 39715
	recipe = AddRecipe(39715, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 375, 380, 385)
	recipe:SetRecipeItem(35263, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(32200, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_BLUE")
	recipe:AddRepVendor(FAC.SHATTERED_SUN_OFFENSIVE, REP.FRIENDLY, 25950, 27666)
	recipe:AddRepVendor(FAC.THE_SCALE_OF_THE_SANDS, REP.FRIENDLY, 23437)

	-- Sparkling Empyrean Sapphire -- 39716
	recipe = AddRecipe(39716, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 375, 380, 385)
	recipe:SetRecipeItem(35264, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(32201, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_BLUE")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddRepVendor(FAC.SHATTERED_SUN_OFFENSIVE, REP.FRIENDLY, 25950, 27666)
	recipe:AddRepVendor(FAC.THE_SCALE_OF_THE_SANDS, REP.FRIENDLY, 23437)

	-- Stormy Empyrean Sapphire -- 39718
	recipe = AddRecipe(39718, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 375, 380, 385)
	recipe:SetRecipeItem(35265, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(32203, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_BLUE")
	recipe:AddRepVendor(FAC.SHATTERED_SUN_OFFENSIVE, REP.EXALTED, 25950, 27666)
	recipe:AddWorldDrop(Z.MOUNT_HYJAL)

	-- Smooth Lionseye -- 39720
	recipe = AddRecipe(39720, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 375, 380, 385)
	recipe:SetRecipeItem(35260, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(32205, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_YELLOW")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddRepVendor(FAC.SHATTERED_SUN_OFFENSIVE, REP.FRIENDLY, 25950, 27666)
	recipe:AddRepVendor(FAC.THE_SCALE_OF_THE_SANDS, REP.FRIENDLY, 23437)

	-- Rigid Empyrean Sapphire -- 39721
	recipe = AddRecipe(39721, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 375, 380, 385)
	recipe:SetRecipeItem(35259, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(32206, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_BLUE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddRepVendor(FAC.SHATTERED_SUN_OFFENSIVE, REP.REVERED, 25950, 27666)
	recipe:AddRepVendor(FAC.THE_SCALE_OF_THE_SANDS, REP.REVERED, 23437)

	-- Mystic Lionseye -- 39724
	recipe = AddRecipe(39724, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 375, 380, 385)
	recipe:SetRecipeItem(35258, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(32209, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_YELLOW")
	recipe:AddRepVendor(FAC.SHATTERED_SUN_OFFENSIVE, REP.EXALTED, 25950, 27666)
	recipe:AddWorldDrop(Z.MOUNT_HYJAL)

	-- Sovereign Shadowsong Amethyst -- 39727
	recipe = AddRecipe(39727, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 375, 380, 385)
	recipe:SetRecipeItem(35243, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(32211, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.DPS)
	recipe:AddRepVendor(FAC.SHATTERED_SUN_OFFENSIVE, REP.EXALTED, 25950, 27666)
	recipe:AddWorldDrop(Z.MOUNT_HYJAL)

	-- Shifting Shadowsong Amethyst -- 39728
	recipe = AddRecipe(39728, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 375, 380, 385)
	recipe:SetRecipeItem(35242, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(32212, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.DPS)
	recipe:AddRepVendor(FAC.SHATTERED_SUN_OFFENSIVE, REP.EXALTED, 25950, 27666)
	recipe:AddWorldDrop(Z.MOUNT_HYJAL)

	-- Timeless Shadowsong Amethyst -- 39731
	recipe = AddRecipe(39731, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 375, 380, 385)
	recipe:SetRecipeItem(35239, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(32215, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddRepVendor(FAC.SHATTERED_SUN_OFFENSIVE, REP.HONORED, 25950, 27666)
	recipe:AddRepVendor(FAC.THE_SCALE_OF_THE_SANDS, REP.HONORED, 23437)

	-- Inscribed Pyrestone -- 39733
	recipe = AddRecipe(39733, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 375, 380, 385)
	recipe:SetRecipeItem(35267, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(32217, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddRepVendor(FAC.SHATTERED_SUN_OFFENSIVE, REP.EXALTED, 25950, 27666)
	recipe:AddWorldDrop(Z.MOUNT_HYJAL)

	-- Potent Pyrestone -- 39734
	recipe = AddRecipe(39734, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 375, 380, 385)
	recipe:SetRecipeItem(35269, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(32218, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddRepVendor(FAC.SHATTERED_SUN_OFFENSIVE, REP.HONORED, 25950, 27666)
	recipe:AddRepVendor(FAC.THE_SCALE_OF_THE_SANDS, REP.HONORED, 23437)

	-- Glinting Shadowsong Amethyst -- 39736
	recipe = AddRecipe(39736, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 375, 380, 385)
	recipe:SetRecipeItem(35266, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(32220, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddRepVendor(FAC.SHATTERED_SUN_OFFENSIVE, REP.HONORED, 25950, 27666)
	recipe:AddRepVendor(FAC.THE_SCALE_OF_THE_SANDS, REP.HONORED, 23437)

	-- Veiled Shadowsong Amethyst -- 39737
	recipe = AddRecipe(39737, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 375, 380, 385)
	recipe:SetRecipeItem(35270, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(32221, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddRepVendor(FAC.SHATTERED_SUN_OFFENSIVE, REP.EXALTED, 25950, 27666)
	recipe:AddWorldDrop(Z.MOUNT_HYJAL)

	-- Deadly Pyrestone -- 39738
	recipe = AddRecipe(39738, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 375, 380, 385)
	recipe:SetRecipeItem(35271, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(32222, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddRepVendor(FAC.SHATTERED_SUN_OFFENSIVE, REP.REVERED, 25950, 27666)
	recipe:AddRepVendor(FAC.THE_SCALE_OF_THE_SANDS, REP.REVERED, 23437)

	-- Regal Seaspray Emerald -- 39739
	recipe = AddRecipe(39739, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 375, 380, 385)
	recipe:SetRecipeItem(35252, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(32223, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddFilters(F.TANK)
	recipe:AddRepVendor(FAC.SHATTERED_SUN_OFFENSIVE, REP.REVERED, 25950, 27666)
	recipe:AddRepVendor(FAC.THE_SCALE_OF_THE_SANDS, REP.REVERED, 23437)

	-- Radiant Seaspray Emerald -- 39740
	recipe = AddRecipe(39740, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 375, 380, 385)
	recipe:SetRecipeItem(35254, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(32224, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddRepVendor(FAC.SHATTERED_SUN_OFFENSIVE, REP.HONORED, 25950, 27666)
	recipe:AddRepVendor(FAC.THE_SCALE_OF_THE_SANDS, REP.HONORED, 23437)

	-- Purified Shadowsong Amethyst -- 39741
	recipe = AddRecipe(39741, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 375, 380, 385)
	recipe:SetRecipeItem(35251, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(32225, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddRepVendor(FAC.SHATTERED_SUN_OFFENSIVE, REP.HONORED, 25950, 27666)
	recipe:AddRepVendor(FAC.THE_SCALE_OF_THE_SANDS, REP.HONORED, 23437)

	-- Jagged Seaspray Emerald -- 39742
	recipe = AddRecipe(39742, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 375, 380, 385)
	recipe:SetRecipeItem(35253, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(32226, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddRepVendor(FAC.SHATTERED_SUN_OFFENSIVE, REP.HONORED, 25950, 27666)
	recipe:AddRepVendor(FAC.THE_SCALE_OF_THE_SANDS, REP.HONORED, 23437)

	-- Relentless Earthstorm Diamond -- 39961
	recipe = AddRecipe(39961, V.TBC, Q.RARE)
	recipe:SetSkillLevels(365, 365, 375, 377, 380)
	recipe:SetRecipeItem(33622, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(32409, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_META")
	recipe:AddFilters(F.DPS)
	recipe:AddRepVendor(FAC.THE_CONSORTIUM, REP.EXALTED, 20242, 23007)

	-- Thundering Skyfire Diamond -- 39963
	recipe = AddRecipe(39963, V.TBC, Q.RARE)
	recipe:SetSkillLevels(365, 365, 375, 377, 380)
	recipe:SetRecipeItem(32411, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(32410, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_META")
	recipe:AddWorldDrop(Z.OUTLAND)

	-- Necklace of the Deep -- 40514
	recipe = AddRecipe(40514, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(40, 40, 50, 55, 60)
	recipe:SetCraftedItem(32508, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(15501, 18751, 18774, 19063, 19539, 19775, 33614, 33637, 33680, 46675, 93527, 100538)

	-- Brilliant Pearl Band -- 41414
	recipe = AddRecipe(41414, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(32772, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(15501, 18751, 18774, 19063, 19539, 19775, 33614, 33637, 33680, 46675, 93527, 100538)

	-- The Black Pearl -- 41415
	recipe = AddRecipe(41415, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(30, 30, 40, 45, 50)
	recipe:SetCraftedItem(32774, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(15501, 18751, 18774, 19063, 19539, 19775, 33614, 33637, 33680, 46675, 93527, 100538)

	-- Crown of the Sea Witch -- 41418
	recipe = AddRecipe(41418, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(65, 65, 75, 80, 85)
	recipe:SetCraftedItem(32776, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_HEAD")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(15501, 18751, 18774, 19063, 19539, 19775, 33614, 33637, 33680, 46675, 93527, 100538)

	-- Purified Jaggal Pearl -- 41420
	recipe = AddRecipe(41420, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(32833, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(15501, 18751, 18774, 19063, 19539, 19775, 33614, 33637, 33680, 46675, 93527, 100538)

	-- Purified Shadow Pearl -- 41429
	recipe = AddRecipe(41429, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(32836, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(15501, 18751, 18774, 19063, 19539, 19775, 33614, 33637, 33680, 46675, 93527, 100538)

	-- Don Julio's Heart -- 42558
	recipe = AddRecipe(42558, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(360, 360, 365, 370, 375)
	recipe:SetRecipeItem(33305, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(33133, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_RED")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddRepVendor(FAC.THE_CONSORTIUM, REP.REVERED, 20242, 23007)

	-- Kailee's Rose -- 42588
	recipe = AddRecipe(42588, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(360, 360, 365, 370, 375)
	recipe:SetRecipeItem(33155, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(33134, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_RED")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddRepVendor(FAC.THE_SHATAR, REP.HONORED, 21432)

	-- Crimson Sun -- 42589
	recipe = AddRecipe(42589, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(360, 360, 365, 370, 375)
	recipe:SetRecipeItem(33156, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(33131, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_RED")
	recipe:AddFilters(F.DPS)
	recipe:AddRepVendor(FAC.THE_CONSORTIUM, REP.REVERED, 20242, 23007)

	-- Falling Star -- 42590
	recipe = AddRecipe(42590, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(360, 360, 365, 370, 375)
	recipe:SetRecipeItem(33157, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(33135, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_BLUE")
	recipe:AddRepVendor(FAC.LOWER_CITY, REP.REVERED, 21655)

	-- Stone of Blades -- 42591
	recipe = AddRecipe(42591, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(360, 360, 365, 370, 375)
	recipe:SetRecipeItem(33158, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(33143, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_YELLOW")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddRepVendor(FAC.KEEPERS_OF_TIME, REP.REVERED, 21643)

	-- Blood of Amber -- 42592
	recipe = AddRecipe(42592, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(360, 360, 365, 370, 375)
	recipe:SetRecipeItem(33159, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(33140, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_YELLOW")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddRepVendor(FAC.THE_SHATAR, REP.REVERED, 21432)

	-- Facet of Eternity -- 42593
	recipe = AddRecipe(42593, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(360, 360, 365, 370, 375)
	recipe:SetRecipeItem(33160, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(33144, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_YELLOW")
	recipe:AddFilters(F.TANK)
	recipe:AddRepVendor(FAC.KEEPERS_OF_TIME, REP.HONORED, 21643)

	-- Steady Talasite -- 43493
	recipe = AddRecipe(43493, V.TBC, Q.RARE)
	recipe:SetSkillLevels(350, 350, 350, 365, 380)
	recipe:SetRecipeItem(33783, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(33782, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddVendor(18821, 18822)

	-- Chaotic Skyfire Diamond -- 44794
	recipe = AddRecipe(44794, V.TBC, Q.RARE)
	recipe:SetSkillLevels(365, 365, 375, 377, 380)
	recipe:SetRecipeItem(34689, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(34220, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_META")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddMobDrop(19768)

	-- Loop of Forged Power -- 46122
	recipe = AddRecipe(46122, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(365, 365, 375, 380, 385)
	recipe:SetRecipeItem(35198, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(34362, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.SUNWELL_PLATEAU)

	-- Ring of Flowing Life -- 46123
	recipe = AddRecipe(46123, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(365, 365, 375, 380, 385)
	recipe:SetRecipeItem(35538, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(34363, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.SUNWELL_PLATEAU)

	-- Hard Khorium Band -- 46124
	recipe = AddRecipe(46124, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(365, 365, 375, 380, 385)
	recipe:SetRecipeItem(35200, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(34361, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.SUNWELL_PLATEAU)

	-- Pendant of Sunfire -- 46125
	recipe = AddRecipe(46125, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(365, 365, 375, 380, 385)
	recipe:SetRecipeItem(35201, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(34359, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.SUNWELL_PLATEAU)

	-- Amulet of Flowing Life -- 46126
	recipe = AddRecipe(46126, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(365, 365, 375, 380, 385)
	recipe:SetRecipeItem(35533, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(34360, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.SUNWELL_PLATEAU)

	-- Hard Khorium Choker -- 46127
	recipe = AddRecipe(46127, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(365, 365, 375, 380, 385)
	recipe:SetRecipeItem(35203, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(34358, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.SUNWELL_PLATEAU)

	-- Quick Dawnstone -- 46403
	recipe = AddRecipe(46403, V.TBC, Q.RARE)
	recipe:SetSkillLevels(350, 350, 350, 365, 380)
	recipe:SetRecipeItem(35322, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(35315, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_YELLOW")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddRepVendor(FAC.SHATTERED_SUN_OFFENSIVE, REP.EXALTED, 25950, 27666)

	-- Forceful Talasite -- 46405
	recipe = AddRecipe(46405, V.TBC, Q.RARE)
	recipe:SetSkillLevels(350, 350, 350, 365, 380)
	recipe:SetRecipeItem(35325, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(35318, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddRepVendor(FAC.SHATTERED_SUN_OFFENSIVE, REP.EXALTED, 25950, 27666)

	-- Eternal Earthstorm Diamond -- 46597
	recipe = AddRecipe(46597, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(370, 370, 375, 377, 380)
	recipe:SetRecipeItem(35502, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(35501, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_META")
	recipe:AddFilters(F.TANK)
	recipe:AddRepVendor(FAC.SHATTERED_SUN_OFFENSIVE, REP.REVERED, 25032)

	-- Ember Skyfire Diamond -- 46601
	recipe = AddRecipe(46601, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(370, 370, 375, 377, 380)
	recipe:SetRecipeItem(35505, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(35503, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_META")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddRepVendor(FAC.SHATTERED_SUN_OFFENSIVE, REP.REVERED, 25032)

	-- Figurine - Empyrean Tortoise -- 46775
	recipe = AddRecipe(46775, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 375, 380, 385)
	recipe:SetRecipeItem(35695, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(35693, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_TRINKET")
	recipe:AddFilters(F.TANK)
	recipe:AddRepVendor(FAC.SHATTERED_SUN_OFFENSIVE, REP.REVERED, 25032)

	-- Figurine - Khorium Boar -- 46776
	recipe = AddRecipe(46776, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 375, 380, 385)
	recipe:SetRecipeItem(35696, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(35694, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_TRINKET")
	recipe:AddFilters(F.DPS)
	recipe:AddRepVendor(FAC.SHATTERED_SUN_OFFENSIVE, REP.REVERED, 25032)

	-- Figurine - Crimson Serpent -- 46777
	recipe = AddRecipe(46777, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 375, 380, 385)
	recipe:SetRecipeItem(35697, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(35700, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_TRINKET")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddRepVendor(FAC.SHATTERED_SUN_OFFENSIVE, REP.REVERED, 25032)

	-- Figurine - Shadowsong Panther -- 46778
	recipe = AddRecipe(46778, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 375, 380, 385)
	recipe:SetRecipeItem(35698, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(35702, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_TRINKET")
	recipe:AddFilters(F.DPS)
	recipe:AddRepVendor(FAC.SHATTERED_SUN_OFFENSIVE, REP.REVERED, 25032)

	-- Figurine - Seaspray Albatross -- 46779
	recipe = AddRecipe(46779, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 375, 380, 385)
	recipe:SetRecipeItem(35699, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(35703, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_TRINKET")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddRepVendor(FAC.SHATTERED_SUN_OFFENSIVE, REP.REVERED, 25032)

	-- Regal Talasite -- 46803
	recipe = AddRecipe(46803, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(350, 350, 350, 365, 380)
	recipe:SetRecipeItem(35708, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(35707, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddFilters(F.TANK)
	recipe:AddRepVendor(FAC.SHATTERED_SUN_OFFENSIVE, REP.REVERED, 25032)

	-- Forceful Seaspray Emerald -- 47053
	recipe = AddRecipe(47053, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(375, 375, 375, 380, 385)
	recipe:SetRecipeItem(35769, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(35759, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddRepVendor(FAC.SHATTERED_SUN_OFFENSIVE, REP.REVERED, 25032, 25950, 27666)
	recipe:AddRepVendor(FAC.THE_SCALE_OF_THE_SANDS, REP.HONORED, 23437)

	-- Steady Seaspray Emerald -- 47054
	recipe = AddRecipe(47054, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(375, 375, 375, 380, 385)
	recipe:SetRecipeItem(35766, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(35758, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddRepVendor(FAC.THE_SCALE_OF_THE_SANDS, REP.HONORED, 23437)
	recipe:AddRepVendor(FAC.SHATTERED_SUN_OFFENSIVE, REP.REVERED, 25032, 25950, 27666)

	-- Reckless Pyrestone -- 47055
	recipe = AddRecipe(47055, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(375, 375, 375, 380, 385)
	recipe:SetRecipeItem(35767, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(35760, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddRepVendor(FAC.SHATTERED_SUN_OFFENSIVE, REP.REVERED, 25032, 25950, 27666)
	recipe:AddRepVendor(FAC.THE_SCALE_OF_THE_SANDS, REP.HONORED, 23437)

	-- Quick Lionseye -- 47056
	recipe = AddRecipe(47056, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(375, 375, 375, 380, 385)
	recipe:SetRecipeItem(35768, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(35761, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_YELLOW")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddRepVendor(FAC.SHATTERED_SUN_OFFENSIVE, REP.REVERED, 25032, 25950, 27666)
	recipe:AddRepVendor(FAC.THE_SCALE_OF_THE_SANDS, REP.HONORED, 23437)

	-- Brilliant Glass -- 47280
	recipe = AddRecipe(47280, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(35945, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_MATERIALS")
	recipe:AddTrainer(15501, 18751, 18774, 19063, 19539, 19775, 33614, 33637, 33680, 46675, 93527, 100538)

	-- Prismatic Black Diamond -- 62941
	recipe = AddRecipe(62941, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 310, 315, 320)
	recipe:SetCraftedItem(45054, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_MATERIALS")
	recipe:AddTrainer(5388, 15501, 18751, 19775, 19778, 44582, 46675, 52586, 52587, 52645, 52657, 93527, 100538)

	-- ----------------------------------------------------------------------------
	-- Wrath of the Lich King.
	-- ----------------------------------------------------------------------------
	-- Bold Scarlet Ruby -- 53830
	recipe = AddRecipe(53830, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(390, 390, 410, 425, 440)
	recipe:SetRecipeItem(41576, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(39996, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_RED")
	recipe:AddFilters(F.DPS)
	recipe:AddVendor(28721, 33602, 93526)

	-- Bold Bloodstone -- 53831
	recipe = AddRecipe(53831, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(39900, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_RED")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(15501, 18751, 19775, 26915, 26960, 26982, 26997, 28701, 33590, 46675, 93527, 100538)

	-- Delicate Bloodstone -- 53832
	recipe = AddRecipe(53832, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(39905, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_RED")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(15501, 18751, 19775, 26915, 26960, 26982, 26997, 28701, 33590, 46675, 93527, 100538)

	-- Subtle Sun Crystal -- 53843
	recipe = AddRecipe(53843, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(39907, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_YELLOW")
	recipe:AddFilters(F.TANK)
	recipe:AddTrainer(15501, 18751, 19775, 26915, 26960, 26982, 26997, 28701, 33590, 46675, 93527, 100538)

	-- Flashing Bloodstone -- 53844
	recipe = AddRecipe(53844, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(39908, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_RED")
	recipe:AddFilters(F.TANK)
	recipe:AddTrainer(15501, 18751, 19775, 26915, 26960, 26982, 26997, 28701, 33590, 46675, 93527, 100538)

	-- Smooth Sun Crystal -- 53845
	recipe = AddRecipe(53845, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(39909, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_YELLOW")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(15501, 18751, 19775, 26915, 26960, 26982, 26997, 28701, 33590, 46675, 93527, 100538)

	-- Brilliant Bloodstone -- 53852
	recipe = AddRecipe(53852, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(39912, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_RED")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(15501, 18751, 19775, 26915, 26960, 26982, 26997, 28701, 33590, 46675, 93527, 100538)

	-- Rigid Chalcedony -- 53854
	recipe = AddRecipe(53854, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(39915, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_BLUE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(15501, 18751, 19775, 26915, 26960, 26982, 26997, 28701, 33590, 46675, 93527, 100538)

	-- Quick Sun Crystal -- 53856
	recipe = AddRecipe(53856, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(39918, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_YELLOW")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(15501, 18751, 19775, 26915, 26960, 26982, 26997, 28701, 33590, 46675, 93527, 100538)

	-- Mystic Sun Crystal -- 53857
	recipe = AddRecipe(53857, V.WOTLK, Q.UNCOMMON)
	recipe:SetSkillLevels(350, 350, 375, 395, 415)
	recipe:SetRecipeItem(41559, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(39917, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_YELLOW")
	recipe:AddVendor(28721, 33602, 93526)

	-- Sovereign Shadow Crystal -- 53859
	recipe = AddRecipe(53859, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(39934, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(15501, 18751, 19775, 26915, 26960, 26982, 26997, 28701, 33590, 46675, 93527, 100538)

	-- Shifting Shadow Crystal -- 53860
	recipe = AddRecipe(53860, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(39935, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(15501, 18751, 19775, 26915, 26960, 26982, 26997, 28701, 33590, 46675, 93527, 100538)

	-- Glinting Shadow Crystal -- 53861
	recipe = AddRecipe(53861, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(39942, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(15501, 18751, 19775, 26915, 26960, 26982, 26997, 28701, 33590, 46675, 93527, 100538)

	-- Mysterious Shadow Crystal -- 53865
	recipe = AddRecipe(53865, V.WOTLK, Q.UNCOMMON)
	recipe:SetSkillLevels(350, 350, 375, 395, 415)
	recipe:SetRecipeItem(41575, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(39945, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(28721, 33602, 93526)

	-- Defender's Shadow Crystal -- 53869
	recipe = AddRecipe(53869, V.WOTLK, Q.UNCOMMON)
	recipe:SetSkillLevels(350, 350, 375, 395, 415)
	recipe:SetRecipeItem(41574, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(39939, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.TANK)
	recipe:AddRepVendor(FAC.THE_KALUAK, REP.HONORED, 31916, 32763)

	-- Jagged Dark Jade -- 53870
	recipe = AddRecipe(53870, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(39933, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(15501, 18751, 19775, 26915, 26960, 26982, 26997, 28701, 33590, 46675, 93527, 100538)

	-- Guardian's Shadow Crystal -- 53871
	recipe = AddRecipe(53871, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(39940, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(15501, 18751, 19775, 26915, 26960, 26982, 26997, 28701, 33590, 46675, 93527, 100538)

	-- Inscribed Huge Citrine -- 53872
	recipe = AddRecipe(53872, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(39947, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(15501, 18751, 19775, 26915, 26960, 26982, 26997, 28701, 33590, 46675, 93527, 100538)

	-- Etched Shadow Crystal -- 53873
	recipe = AddRecipe(53873, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(39948, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(15501, 18751, 19775, 26915, 26960, 26982, 26997, 28701, 33590, 46675, 93527, 100538)

	-- Champion's Huge Citrine -- 53874
	recipe = AddRecipe(53874, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(39949, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.DPS, F.TANK)
	recipe:AddTrainer(15501, 18751, 19775, 26915, 26960, 26982, 26997, 28701, 33590, 46675, 93527, 100538)

	-- Resplendent Huge Citrine -- 53875
	recipe = AddRecipe(53875, V.WOTLK, Q.UNCOMMON)
	recipe:SetSkillLevels(350, 350, 375, 395, 415)
	recipe:SetRecipeItem(41566, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(39950, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.DPS)
	recipe:AddVendor(28721, 33602, 93526)

	-- Fierce Huge Citrine -- 53876
	recipe = AddRecipe(53876, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(39951, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(15501, 18751, 19775, 26915, 26960, 26982, 26997, 28701, 33590, 46675, 93527, 100538)

	-- Deadly Huge Citrine -- 53877
	recipe = AddRecipe(53877, V.WOTLK, Q.UNCOMMON)
	recipe:SetSkillLevels(350, 350, 375, 395, 415)
	recipe:SetRecipeItem(41562, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(39952, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddRepVendor(FAC.KNIGHTS_OF_THE_EBON_BLADE, REP.FRIENDLY, 32538)

	-- Lucent Huge Citrine -- 53879
	recipe = AddRecipe(53879, V.WOTLK, Q.UNCOMMON)
	recipe:SetSkillLevels(350, 350, 375, 395, 415)
	recipe:SetRecipeItem(41565, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(39954, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.DPS)
	recipe:AddVendor(28721, 33602, 93526)

	-- Deft Huge Citrine -- 53880
	recipe = AddRecipe(53880, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(39955, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(15501, 18751, 19775, 26915, 26960, 26982, 26997, 28701, 33590, 46675, 93527, 100538)

	-- Potent Huge Citrine -- 53882
	recipe = AddRecipe(53882, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(39956, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(15501, 18751, 19775, 26915, 26960, 26982, 26997, 28701, 33590, 46675, 93527, 100538)

	-- Veiled Shadow Crystal -- 53883
	recipe = AddRecipe(53883, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(39957, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(15501, 18751, 19775, 26915, 26960, 26982, 26997, 28701, 33590, 46675, 93527, 100538)

	-- Willful Huge Citrine -- 53884
	recipe = AddRecipe(53884, V.WOTLK, Q.UNCOMMON)
	recipe:SetSkillLevels(350, 350, 375, 395, 415)
	recipe:SetRecipeItem(41563, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(39958, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(28721, 33602, 93526)

	-- Reckless Huge Citrine -- 53885
	recipe = AddRecipe(53885, V.WOTLK, Q.UNCOMMON)
	recipe:SetSkillLevels(350, 350, 375, 395, 415)
	recipe:SetRecipeItem(41561, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(39959, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddRepVendor(FAC.FRENZYHEART_TRIBE, REP.FRIENDLY, 31911)

	-- Stalwart Huge Citrine -- 53891
	recipe = AddRecipe(53891, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(39965, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.TANK)
	recipe:AddTrainer(15501, 18751, 19775, 26915, 26960, 26982, 26997, 28701, 33590, 46675, 93527, 100538)

	-- Accurate Shadow Crystal -- 53892
	recipe = AddRecipe(53892, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(39966, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(15501, 18751, 19775, 26915, 26960, 26982, 26997, 28701, 33590, 46675, 93527, 100538)

	-- Resolute Huge Citrine -- 53893
	recipe = AddRecipe(53893, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(39967, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.TANK)
	recipe:AddTrainer(15501, 18751, 19775, 26915, 26960, 26982, 26997, 28701, 33590, 46675, 93527, 100538)

	-- Timeless Shadow Crystal -- 53894
	recipe = AddRecipe(53894, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(39968, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(15501, 18751, 19775, 26915, 26960, 26982, 26997, 28701, 33590, 46675, 93527, 100538)

	-- Nimble Dark Jade -- 53917
	recipe = AddRecipe(53917, V.WOTLK, Q.UNCOMMON)
	recipe:SetSkillLevels(350, 350, 375, 395, 415)
	recipe:SetRecipeItem(41567, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(39975, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.TANK)
	recipe:AddRepVendor(FAC.THE_ORACLES, REP.FRIENDLY, 31910)

	-- Regal Dark Jade -- 53918
	recipe = AddRecipe(53918, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(39976, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddFilters(F.TANK)
	recipe:AddTrainer(15501, 18751, 19775, 26915, 26960, 26982, 26997, 28701, 33590, 46675, 93527, 100538)

	-- Steady Dark Jade -- 53919
	recipe = AddRecipe(53919, V.WOTLK, Q.UNCOMMON)
	recipe:SetSkillLevels(350, 350, 375, 395, 415)
	recipe:SetRecipeItem(41572, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(39977, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddVendor(28721, 33602, 93526)

	-- Forceful Dark Jade -- 53920
	recipe = AddRecipe(53920, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(39978, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(15501, 18751, 19775, 26915, 26960, 26982, 26997, 28701, 33590, 46675, 93527, 100538)

	-- Purified Shadow Crystal -- 53921
	recipe = AddRecipe(53921, V.WOTLK, Q.UNCOMMON)
	recipe:SetSkillLevels(350, 350, 375, 395, 415)
	recipe:SetRecipeItem(41568, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(39979, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddRepVendor(FAC.THE_KALUAK, REP.FRIENDLY, 31916, 32763)

	-- Misty Dark Jade -- 53922
	recipe = AddRecipe(53922, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(39980, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(15501, 18751, 19775, 26915, 26960, 26982, 26997, 28701, 33590, 46675, 93527, 100538)

	-- Lightning Dark Jade -- 53923
	recipe = AddRecipe(53923, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(39981, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(15501, 18751, 19775, 26915, 26960, 26982, 26997, 28701, 33590, 46675, 93527, 100538)

	-- Turbid Dark Jade -- 53924
	recipe = AddRecipe(53924, V.WOTLK, Q.UNCOMMON)
	recipe:SetSkillLevels(350, 350, 375, 395, 415)
	recipe:SetRecipeItem(41571, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(39982, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddVendor(28721, 33602, 93526)

	-- Energized Dark Jade -- 53925
	recipe = AddRecipe(53925, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(39983, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(15501, 18751, 19775, 26915, 26960, 26982, 26997, 28701, 33590, 46675, 93527, 100538)

	-- Radiant Dark Jade -- 53932
	recipe = AddRecipe(53932, V.WOTLK, Q.UNCOMMON)
	recipe:SetSkillLevels(350, 350, 375, 395, 415)
	recipe:SetRecipeItem(41570, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(39991, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(28721, 33602, 93526)

	-- Shattered Dark Jade -- 53933
	recipe = AddRecipe(53933, V.WOTLK, Q.UNCOMMON)
	recipe:SetSkillLevels(350, 350, 375, 395, 415)
	recipe:SetRecipeItem(41569, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(39992, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(28721, 33602, 93526)

	-- Solid Chalcedony -- 53934
	recipe = AddRecipe(53934, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(39919, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_BLUE")
	recipe:AddTrainer(15501, 18751, 19775, 26915, 26960, 26982, 26997, 28701, 33590, 46675, 93527, 100538)

	-- Sparkling Chalcedony -- 53941
	recipe = AddRecipe(53941, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(39927, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_BLUE")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(15501, 18751, 19775, 26915, 26960, 26982, 26997, 28701, 33590, 46675, 93527, 100538)

	-- Stormy Chalcedony -- 53943
	recipe = AddRecipe(53943, V.WOTLK, Q.UNCOMMON)
	recipe:SetSkillLevels(350, 350, 375, 395, 415)
	recipe:SetRecipeItem(41560, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(39932, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_BLUE")
	recipe:AddVendor(28721, 33602, 93526)

	-- Delicate Scarlet Ruby -- 53945
	recipe = AddRecipe(53945, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(390, 390, 410, 425, 440)
	recipe:SetRecipeItem(41577, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(39997, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_RED")
	recipe:AddFilters(F.DPS)
	recipe:AddVendor(28721, 33602, 93526)

	-- Brilliant Scarlet Ruby -- 53946
	recipe = AddRecipe(53946, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(390, 390, 410, 425, 440)
	recipe:SetRecipeItem(41718, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(39998, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_RED")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddRepVendor(FAC.KIRIN_TOR, REP.EXALTED, 32287)

	-- Subtle Autumn's Glow -- 53948
	recipe = AddRecipe(53948, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(390, 390, 410, 425, 440)
	recipe:SetRecipeItem(41719, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(40000, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_YELLOW")
	recipe:AddFilters(F.TANK)
	recipe:AddVendor(28721, 33602, 93526)

	-- Flashing Scarlet Ruby -- 53949
	recipe = AddRecipe(53949, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(390, 390, 410, 425, 440)
	recipe:SetRecipeItem(41578, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(40001, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_RED")
	recipe:AddFilters(F.TANK)
	recipe:AddVendor(28721, 33602, 93526)

	-- Precise Scarlet Ruby -- 53951
	recipe = AddRecipe(53951, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(390, 390, 410, 425, 440)
	recipe:SetRecipeItem(41790, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(40003, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_RED")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddMobDrop(29311)

	-- Solid Sky Sapphire -- 53952
	recipe = AddRecipe(53952, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(390, 390, 410, 425, 440)
	recipe:SetRecipeItem(42138, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(40008, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_BLUE")
	recipe:AddVendor(28721, 33602, 93526)

	-- Sparkling Sky Sapphire -- 53954
	recipe = AddRecipe(53954, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(390, 390, 410, 425, 440)
	recipe:SetRecipeItem(41581, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(40010, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_BLUE")
	recipe:AddVendor(28721, 33602, 93526)

	-- Stormy Sky Sapphire -- 53955
	recipe = AddRecipe(53955, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(390, 390, 410, 425, 440)
	recipe:SetRecipeItem(41728, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(40011, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_BLUE")
	recipe:AddVendor(30489, 32294, 32296)

	-- Smooth Autumn's Glow -- 53957
	recipe = AddRecipe(53957, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(390, 390, 410, 425, 440)
	recipe:SetRecipeItem(41720, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(40013, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_YELLOW")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddRepVendor(FAC.THE_SONS_OF_HODIR, REP.EXALTED, 32540)

	-- Rigid Sky Sapphire -- 53958
	recipe = AddRecipe(53958, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(390, 390, 410, 425, 440)
	recipe:SetRecipeItem(41580, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(40014, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_BLUE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(28721, 33602, 93526)

	-- Mystic Autumn's Glow -- 53960
	recipe = AddRecipe(53960, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(390, 390, 410, 425, 440)
	recipe:SetRecipeItem(41727, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(40016, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_YELLOW")
	recipe:AddVendor(30489, 32294, 32296)

	-- Quick Autumn's Glow -- 53961
	recipe = AddRecipe(53961, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(390, 390, 410, 425, 440)
	recipe:SetRecipeItem(41579, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(40017, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_YELLOW")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(28721, 33602, 93526)

	-- Sovereign Twilight Opal -- 53962
	recipe = AddRecipe(53962, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(390, 390, 410, 425, 440)
	recipe:SetRecipeItem(41784, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(40022, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.DPS)
	recipe:AddWorldDrop(Z.NORTHREND)

	-- Shifting Twilight Opal -- 53963
	recipe = AddRecipe(53963, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(390, 390, 410, 425, 440)
	recipe:SetRecipeItem(41747, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(40023, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.DPS)
	recipe:AddVendor(28721, 33602, 93526)

	-- Timeless Twilight Opal -- 53965
	recipe = AddRecipe(53965, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(390, 390, 410, 425, 440)
	recipe:SetRecipeItem(41725, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(40025, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddRepVendor(FAC.KNIGHTS_OF_THE_EBON_BLADE, REP.EXALTED, 32538)

	-- Purified Twilight Opal -- 53966
	recipe = AddRecipe(53966, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(390, 390, 410, 425, 440)
	recipe:SetRecipeItem(41783, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(40026, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddWorldDrop(Z.NORTHREND)

	-- Mysterious Twilight Opal -- 53968
	recipe = AddRecipe(53968, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(390, 390, 410, 425, 440)
	recipe:SetRecipeItem(41740, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(40028, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(30489, 32294, 32296)

	-- Defender's Twilight Opal -- 53972
	recipe = AddRecipe(53972, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(390, 390, 410, 425, 440)
	recipe:SetRecipeItem(41820, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(40032, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.TANK)
	recipe:AddMobDrop(29370, 29376, 30208, 30222)

	-- Guardian's Twilight Opal -- 53974
	recipe = AddRecipe(53974, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(390, 390, 410, 425, 440)
	recipe:SetRecipeItem(41726, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(40034, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddRepVendor(FAC.ARGENT_CRUSADE, REP.REVERED, 30431)

	-- Inscribed Monarch Topaz -- 53975
	recipe = AddRecipe(53975, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(390, 390, 410, 425, 440)
	recipe:SetRecipeItem(41789, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(40037, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.NORTHREND)

	-- Etched Twilight Opal -- 53976
	recipe = AddRecipe(53976, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(390, 390, 410, 425, 440)
	recipe:SetRecipeItem(41777, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(40038, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.NORTHREND)

	-- Champion's Monarch Topaz -- 53977
	recipe = AddRecipe(53977, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(390, 390, 410, 425, 440)
	recipe:SetRecipeItem(41780, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(40039, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.DPS, F.TANK)
	recipe:AddWorldDrop(Z.NORTHREND)

	-- Resplendent Monarch Topaz -- 53978
	recipe = AddRecipe(53978, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(390, 390, 410, 425, 440)
	recipe:SetRecipeItem(41734, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(40040, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.DPS)
	recipe:AddVendor(30489, 32294, 32296)

	-- Glinting Twilight Opal -- 53980
	recipe = AddRecipe(53980, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(390, 390, 410, 425, 440)
	recipe:SetRecipeItem(41582, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(40044, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(28721, 33602, 93526)

	-- Lucent Monarch Topaz -- 53981
	recipe = AddRecipe(53981, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(390, 390, 410, 425, 440)
	recipe:SetRecipeItem(41733, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(40045, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.DPS)
	recipe:AddVendor(30489, 32294, 32296)

	-- Potent Monarch Topaz -- 53984
	recipe = AddRecipe(53984, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(390, 390, 410, 425, 440)
	recipe:SetRecipeItem(41686, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(40048, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(28721, 33602, 93526)

	-- Veiled Twilight Opal -- 53985
	recipe = AddRecipe(53985, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(390, 390, 410, 425, 440)
	recipe:SetRecipeItem(41688, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(40049, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(28721, 33602, 93526)

	-- Willful Monarch Topaz -- 53986
	recipe = AddRecipe(53986, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(390, 390, 410, 425, 440)
	recipe:SetRecipeItem(41730, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(40050, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(30489, 32294, 32296)

	-- Reckless Monarch Topaz -- 53987
	recipe = AddRecipe(53987, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(390, 390, 410, 425, 440)
	recipe:SetRecipeItem(41690, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(40051, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(28721, 33602, 93526)

	-- Deadly Monarch Topaz -- 53988
	recipe = AddRecipe(53988, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(390, 390, 410, 425, 440)
	recipe:SetRecipeItem(41721, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(40052, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddRepVendor(FAC.KNIGHTS_OF_THE_EBON_BLADE, REP.REVERED, 32538)

	-- Deft Monarch Topaz -- 53991
	recipe = AddRecipe(53991, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(390, 390, 410, 425, 440)
	recipe:SetRecipeItem(41687, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(40055, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(28721, 33602, 93526)

	-- Stalwart Monarch Topaz -- 53993
	recipe = AddRecipe(53993, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(390, 390, 410, 425, 440)
	recipe:SetRecipeItem(41722, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(40057, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.TANK)
	recipe:AddRepVendor(FAC.THE_WYRMREST_ACCORD, REP.EXALTED, 32533)

	-- Accurate Twilight Opal -- 53994
	recipe = AddRecipe(53994, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(390, 390, 410, 425, 440)
	recipe:SetRecipeItem(41818, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(40058, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddMobDrop(28379, 28851, 29402, 30260, 30448)

	-- Jagged Forest Emerald -- 53996
	recipe = AddRecipe(53996, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(390, 390, 410, 425, 440)
	recipe:SetRecipeItem(41702, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(40086, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddRepVendor(FAC.FRENZYHEART_TRIBE, REP.REVERED, 31911)
	recipe:AddVendor(28721, 33602, 93526)

	-- Nimble Forest Emerald -- 53997
	recipe = AddRecipe(53997, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(390, 390, 410, 425, 440)
	recipe:SetRecipeItem(41698, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(40088, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.TANK)
	recipe:AddVendor(28721, 33602, 93526)

	-- Regal Forest Emerald -- 53998
	recipe = AddRecipe(53998, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(390, 390, 410, 425, 440)
	recipe:SetRecipeItem(41697, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(40089, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddFilters(F.TANK)
	recipe:AddVendor(28721, 33602, 93526)

	-- Steady Forest Emerald -- 54000
	recipe = AddRecipe(54000, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(390, 390, 410, 425, 440)
	recipe:SetRecipeItem(41738, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(40090, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddVendor(30489, 32294, 32296)

	-- Forceful Forest Emerald -- 54001
	recipe = AddRecipe(54001, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(390, 390, 410, 425, 440)
	recipe:SetRecipeItem(41693, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(40091, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(28721, 33602, 93526)

	-- Misty Forest Emerald -- 54003
	recipe = AddRecipe(54003, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(390, 390, 410, 425, 440)
	recipe:SetRecipeItem(41724, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(40095, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.NORTHREND)
	recipe:AddRepVendor(FAC.THE_ORACLES, REP.REVERED, 31910)

	-- Turbid Forest Emerald -- 54005
	recipe = AddRecipe(54005, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(390, 390, 410, 425, 440)
	recipe:SetRecipeItem(41737, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(40102, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(30489, 32294, 32296)

	-- Lightning Forest Emerald -- 54009
	recipe = AddRecipe(54009, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(390, 390, 410, 425, 440)
	recipe:SetRecipeItem(41696, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(40100, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(28721, 33602, 93526)

	-- Energized Forest Emerald -- 54011
	recipe = AddRecipe(54011, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(390, 390, 410, 425, 440)
	recipe:SetRecipeItem(41692, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(40105, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(28721, 33602, 93526)

	-- Radiant Forest Emerald -- 54012
	recipe = AddRecipe(54012, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(390, 390, 410, 425, 440)
	recipe:SetRecipeItem(41819, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(40098, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddMobDrop(29792, 29793)

	-- Shattered Forest Emerald -- 54014
	recipe = AddRecipe(54014, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(390, 390, 410, 425, 440)
	recipe:SetRecipeItem(41735, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(40106, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(30489, 32294, 32296)

	-- Precise Bloodstone -- 54017
	recipe = AddRecipe(54017, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(39910, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_RED")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(15501, 18751, 19775, 26915, 26960, 26982, 26997, 28701, 33590, 46675, 93527, 100538)

	-- Fierce Monarch Topaz -- 54019
	recipe = AddRecipe(54019, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(390, 390, 410, 425, 440)
	recipe:SetRecipeItem(41793, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(40041, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddMobDrop(23954)

	-- Resolute Monarch Topaz -- 54023
	recipe = AddRecipe(54023, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(390, 390, 410, 425, 440)
	recipe:SetRecipeItem(41778, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(40059, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.TANK)
	recipe:AddWorldDrop(Z.NORTHREND)

	-- Shielded Skyflare Diamond -- 55384
	recipe = AddRecipe(55384, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(420, 420, 440, 450, 460)
	recipe:SetRecipeItem(41705, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(41377, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_META")
	recipe:AddVendor(28721, 33602, 93526)

	-- Tireless Skyflare Diamond -- 55386
	recipe = AddRecipe(55386, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(45, 45, 55, 60, 65)
	recipe:SetCraftedItem(41375, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_META")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(15501, 18751, 19775, 26915, 26960, 26982, 26997, 28701, 33590, 46675, 93527, 100538)

	-- Forlorn Skyflare Diamond -- 55387
	recipe = AddRecipe(55387, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(420, 420, 440, 450, 460)
	recipe:SetRecipeItem(41743, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(41378, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_META")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(30489, 32294, 32296)

	-- Impassive Skyflare Diamond -- 55388
	recipe = AddRecipe(55388, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(420, 420, 440, 450, 460)
	recipe:SetRecipeItem(41744, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(41379, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_META")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(30489, 32294, 32296)

	-- Chaotic Skyflare Diamond -- 55389
	recipe = AddRecipe(55389, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(420, 420, 440, 450, 460)
	recipe:SetRecipeItem(41704, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(41285, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_META")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(28721, 33602, 93526)

	-- Destructive Skyflare Diamond -- 55390
	recipe = AddRecipe(55390, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(420, 420, 440, 450, 460)
	recipe:SetRecipeItem(41786, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(41307, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_META")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.NORTHREND)

	-- Ember Skyflare Diamond -- 55392
	recipe = AddRecipe(55392, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(420, 420, 440, 450, 460)
	recipe:SetRecipeItem(41706, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(41333, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_META")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(28721, 33602, 93526)

	-- Enigmatic Skyflare Diamond -- 55393
	recipe = AddRecipe(55393, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(420, 420, 440, 450, 460)
	recipe:SetRecipeItem(41742, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(41335, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_META")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(30489, 32294, 32296)

	-- Swift Skyflare Diamond -- 55394
	recipe = AddRecipe(55394, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(45, 45, 55, 60, 65)
	recipe:SetCraftedItem(41339, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_META")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(15501, 18751, 19775, 26915, 26960, 26982, 26997, 28701, 33590, 46675, 93527, 100538)

	-- Thundering Skyflare Diamond -- 55395
	recipe = AddRecipe(55395, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(420, 420, 440, 450, 460)
	recipe:SetRecipeItem(41787, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(41400, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_META")
	recipe:AddWorldDrop(Z.NORTHREND)

	-- Insightful Earthsiege Diamond -- 55396
	recipe = AddRecipe(55396, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(420, 420, 440, 450, 460)
	recipe:SetRecipeItem(41708, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(41401, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_META")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(28721, 33602, 93526)

	-- Bracing Earthsiege Diamond -- 55397
	recipe = AddRecipe(55397, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(420, 420, 440, 450, 460)
	recipe:SetRecipeItem(41798, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(41395, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_META")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddMobDrop(27656)

	-- Eternal Earthsiege Diamond -- 55398
	recipe = AddRecipe(55398, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(420, 420, 440, 450, 460)
	recipe:SetRecipeItem(41799, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(41396, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_META")
	recipe:AddFilters(F.TANK)
	recipe:AddMobDrop(28923)

	-- Powerful Earthsiege Diamond -- 55399
	recipe = AddRecipe(55399, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(45, 45, 55, 60, 65)
	recipe:SetCraftedItem(41397, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_META")
	recipe:AddTrainer(15501, 18751, 19775, 26915, 26960, 26982, 26997, 28701, 33590, 46675, 93527, 100538)

	-- Relentless Earthsiege Diamond -- 55400
	recipe = AddRecipe(55400, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(420, 420, 440, 450, 460)
	recipe:SetRecipeItem(41710, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(41398, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_META")
	recipe:AddFilters(F.DPS)
	recipe:AddVendor(28721, 33602, 93526)

	-- Austere Earthsiege Diamond -- 55401
	recipe = AddRecipe(55401, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(420, 420, 440, 450, 460)
	recipe:SetRecipeItem(41797, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(41380, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_META")
	recipe:AddMobDrop(26861)

	-- Persistent Earthsiege Diamond -- 55402
	recipe = AddRecipe(55402, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(45, 45, 55, 60, 65)
	recipe:SetCraftedItem(41381, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_META")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(15501, 18751, 19775, 26915, 26960, 26982, 26997, 28701, 33590, 46675, 93527, 100538)

	-- Trenchant Earthsiege Diamond -- 55403
	recipe = AddRecipe(55403, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(420, 420, 440, 450, 460)
	recipe:SetRecipeItem(41711, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(41382, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_META")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(28721, 33602, 93526)

	-- Invigorating Earthsiege Diamond -- 55404
	recipe = AddRecipe(55404, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(420, 420, 440, 450, 460)
	recipe:SetRecipeItem(41709, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(41385, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_META")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(28721, 33602, 93526)

	-- Beaming Earthsiege Diamond -- 55405
	recipe = AddRecipe(55405, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(420, 420, 440, 450, 460)
	recipe:SetRecipeItem(41788, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(41389, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_META")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.NORTHREND)

	-- Revitalizing Skyflare Diamond -- 55407
	recipe = AddRecipe(55407, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(420, 420, 440, 450, 460)
	recipe:SetRecipeItem(41707, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(41376, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_META")
	recipe:AddVendor(28721, 33602, 93526)

	-- Bold Dragon's Eye -- 56049
	recipe = AddRecipe(56049, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(370, 370, 390, 415, 440)
	recipe:SetRecipeItem(42298, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(42142, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_RED")
	recipe:AddFilters(F.DPS)
	recipe:AddVendor(28721, 33602, 93526)

	-- Delicate Dragon's Eye -- 56052
	recipe = AddRecipe(56052, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(370, 370, 390, 415, 440)
	recipe:SetRecipeItem(42301, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(42143, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_RED")
	recipe:AddFilters(F.DPS)
	recipe:AddVendor(28721, 33602, 93526)

	-- Brilliant Dragon's Eye -- 56053
	recipe = AddRecipe(56053, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(370, 370, 390, 415, 440)
	recipe:SetRecipeItem(42309, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(42144, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_RED")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(28721, 33602, 93526)

	-- Subtle Dragon's Eye -- 56055
	recipe = AddRecipe(56055, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(370, 370, 390, 415, 440)
	recipe:SetRecipeItem(42314, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(42151, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_YELLOW")
	recipe:AddFilters(F.TANK)
	recipe:AddVendor(28721, 33602, 93526)

	-- Flashing Dragon's Eye -- 56056
	recipe = AddRecipe(56056, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(370, 370, 390, 415, 440)
	recipe:SetRecipeItem(42302, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(42152, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_RED")
	recipe:AddFilters(F.TANK)
	recipe:AddVendor(28721, 33602, 93526)

	-- Mystic Dragon's Eye -- 56079
	recipe = AddRecipe(56079, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(370, 370, 390, 415, 440)
	recipe:SetRecipeItem(42305, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(42158, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_YELLOW")
	recipe:AddVendor(28721, 33602, 93526)

	-- Precise Dragon's Eye -- 56081
	recipe = AddRecipe(56081, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(370, 370, 390, 415, 440)
	recipe:SetRecipeItem(42306, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(42154, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_RED")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(28721, 33602, 93526)

	-- Quick Dragon's Eye -- 56083
	recipe = AddRecipe(56083, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(370, 370, 390, 415, 440)
	recipe:SetRecipeItem(42307, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(42150, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_YELLOW")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(28721, 33602, 93526)

	-- Rigid Dragon's Eye -- 56084
	recipe = AddRecipe(56084, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(370, 370, 390, 415, 440)
	recipe:SetRecipeItem(42308, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(42156, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_BLUE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(28721, 33602, 93526)

	-- Smooth Dragon's Eye -- 56085
	recipe = AddRecipe(56085, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(370, 370, 390, 415, 440)
	recipe:SetRecipeItem(42310, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(42149, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_YELLOW")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(28721, 33602, 93526)

	-- Solid Dragon's Eye -- 56086
	recipe = AddRecipe(56086, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(370, 370, 390, 415, 440)
	recipe:SetRecipeItem(42311, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(36767, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_BLUE")
	recipe:AddVendor(28721, 33602, 93526)

	-- Sparkling Dragon's Eye -- 56087
	recipe = AddRecipe(56087, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(370, 370, 390, 415, 440)
	recipe:SetRecipeItem(42312, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(42145, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_BLUE")
	recipe:AddVendor(28721, 33602, 93526)

	-- Stormy Dragon's Eye -- 56088
	recipe = AddRecipe(56088, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(370, 370, 390, 415, 440)
	recipe:SetRecipeItem(42313, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(42155, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_BLUE")
	recipe:AddVendor(28721, 33602, 93526)

	-- Bloodstone Band -- 56193
	recipe = AddRecipe(56193, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(42336, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(15501, 18751, 19775, 26915, 26960, 26982, 26997, 28701, 33590, 46675, 93527, 100538)

	-- Sun Rock Ring -- 56194
	recipe = AddRecipe(56194, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(42337, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(15501, 18751, 19775, 26915, 26960, 26982, 26997, 28701, 33590, 46675, 93527, 100538)

	-- Jade Dagger Pendant -- 56195
	recipe = AddRecipe(56195, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(5, 5, 15, 20, 25)
	recipe:SetCraftedItem(42338, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(15501, 18751, 19775, 26915, 26960, 26982, 26997, 28701, 33590, 46675, 93527, 100538)

	-- Blood Sun Necklace -- 56196
	recipe = AddRecipe(56196, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(5, 5, 15, 20, 25)
	recipe:SetCraftedItem(42339, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(15501, 18751, 19775, 26915, 26960, 26982, 26997, 28701, 33590, 46675, 93527, 100538)

	-- Dream Signet -- 56197
	recipe = AddRecipe(56197, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(45, 45, 55, 60, 65)
	recipe:SetCraftedItem(42340, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddTrainer(15501, 18751, 19775, 26915, 26960, 26982, 26997, 28701, 33590, 46675, 93527, 100538)

	-- Figurine - Ruby Hare -- 56199
	recipe = AddRecipe(56199, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(42341, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_TRINKET")
	recipe:AddTrainer(15501, 18751, 19775, 26915, 26960, 26982, 26997, 28701, 33590, 46675, 93527, 100538)

	-- Figurine - Twilight Serpent -- 56201
	recipe = AddRecipe(56201, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(42395, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_TRINKET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(15501, 18751, 19775, 26915, 26960, 26982, 26997, 28701, 33590, 46675, 93527, 100538)

	-- Figurine - Sapphire Owl -- 56202
	recipe = AddRecipe(56202, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(42413, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_TRINKET")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(15501, 18751, 19775, 26915, 26960, 26982, 26997, 28701, 33590, 46675, 93527, 100538)

	-- Figurine - Emerald Boar -- 56203
	recipe = AddRecipe(56203, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(42418, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_TRINKET")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(15501, 18751, 19775, 26915, 26960, 26982, 26997, 28701, 33590, 46675, 93527, 100538)

	-- Dark Jade Focusing Lens -- 56205
	recipe = AddRecipe(56205, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(41367, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_CREATED_ITEM")
	recipe:AddTrainer(15501, 18751, 19775, 26915, 26960, 26982, 26997, 28701, 33590, 46675, 93527, 100538)

	-- Shadow Crystal Focusing Lens -- 56206
	recipe = AddRecipe(56206, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(42420, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_CREATED_ITEM")
	recipe:AddTrainer(15501, 18751, 19775, 26915, 26960, 26982, 26997, 28701, 33590, 46675, 93527, 100538)

	-- Shadow Jade Focusing Lens -- 56208
	recipe = AddRecipe(56208, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(42421, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_CREATED_ITEM")
	recipe:AddTrainer(15501, 18751, 19775, 26915, 26960, 26982, 26997, 28701, 33590, 46675, 93527, 100538)

	-- Titanium Impact Band -- 56496
	recipe = AddRecipe(56496, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(430, 430, 450, 455, 460)
	recipe:SetRecipeItem(42648, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(42642, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(28721, 33602, 93526)

	-- Titanium Earthguard Ring -- 56497
	recipe = AddRecipe(56497, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(430, 430, 450, 455, 460)
	recipe:SetRecipeItem(42649, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(42643, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddFilters(F.DPS, F.TANK)
	recipe:AddVendor(28721, 33602, 93526)

	-- Titanium Spellshock Ring -- 56498
	recipe = AddRecipe(56498, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(430, 430, 450, 455, 460)
	recipe:SetRecipeItem(42650, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(42644, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(28721, 33602, 93526)

	-- Titanium Impact Choker -- 56499
	recipe = AddRecipe(56499, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(440, 440, 450, 455, 460)
	recipe:SetRecipeItem(42651, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(42645, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(28721, 33602, 93526)

	-- Titanium Earthguard Chain -- 56500
	recipe = AddRecipe(56500, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(440, 440, 450, 455, 460)
	recipe:SetRecipeItem(42652, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(42646, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddFilters(F.DPS, F.TANK)
	recipe:AddVendor(28721, 33602, 93526)

	-- Titanium Spellshock Necklace -- 56501
	recipe = AddRecipe(56501, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(440, 440, 450, 455, 460)
	recipe:SetRecipeItem(42653, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(42647, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(28721, 33602, 93526)

	-- Enchanted Pearl -- 56530
	recipe = AddRecipe(56530, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(42701, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PRISMATIC")
	recipe:AddTrainer(15501, 18751, 19775, 26915, 26960, 26982, 26997, 28701, 33590, 46675, 93527, 100538)

	-- Enchanted Tear -- 56531
	recipe = AddRecipe(56531, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(15, 15, 25, 30, 35)
	recipe:SetCraftedItem(42702, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PRISMATIC")
	recipe:AddTrainer(15501, 18751, 19775, 26915, 26960, 26982, 26997, 28701, 33590, 46675, 93527, 100538)

	-- Crystal Citrine Necklace -- 58141
	recipe = AddRecipe(58141, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(43244, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(15501, 18751, 19775, 26915, 26960, 26982, 26997, 28701, 33590, 46675, 93527, 100538)

	-- Crystal Chalcedony Amulet -- 58142
	recipe = AddRecipe(58142, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(43245, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(15501, 18751, 19775, 26915, 26960, 26982, 26997, 28701, 33590, 46675, 93527, 100538)

	-- Earthshadow Ring -- 58143
	recipe = AddRecipe(58143, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(43246, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(15501, 18751, 19775, 26915, 26960, 26982, 26997, 28701, 33590, 46675, 93527, 100538)

	-- Jade Ring of Slaying -- 58144
	recipe = AddRecipe(58144, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(43247, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(15501, 18751, 19775, 26915, 26960, 26982, 26997, 28701, 33590, 46675, 93527, 100538)

	-- Stoneguard Band -- 58145
	recipe = AddRecipe(58145, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(15, 15, 25, 30, 35)
	recipe:SetCraftedItem(43248, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddFilters(F.DPS, F.TANK)
	recipe:AddTrainer(15501, 18751, 19775, 26915, 26960, 26982, 26997, 28701, 33590, 46675, 93527, 100538)

	-- Shadowmight Ring -- 58146
	recipe = AddRecipe(58146, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(15, 15, 25, 30, 35)
	recipe:SetCraftedItem(43249, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(15501, 18751, 19775, 26915, 26960, 26982, 26997, 28701, 33590, 46675, 93527, 100538)

	-- Ring of Earthen Might -- 58147
	recipe = AddRecipe(58147, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(420, 420, 440, 450, 460)
	recipe:SetRecipeItem(43317, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(43250, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddFilters(F.DPS, F.TANK)
	recipe:AddVendor(28721, 33602, 93526)

	-- Ring of Scarlet Shadows -- 58148
	recipe = AddRecipe(58148, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(420, 420, 440, 450, 460)
	recipe:SetRecipeItem(43318, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(43251, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(28721, 33602, 93526)

	-- Windfire Band -- 58149
	recipe = AddRecipe(58149, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(420, 420, 440, 450, 460)
	recipe:SetRecipeItem(43319, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(43252, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(28721, 33602, 93526)

	-- Ring of Northern Tears -- 58150
	recipe = AddRecipe(58150, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(420, 420, 440, 450, 460)
	recipe:SetRecipeItem(43320, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(43253, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(28721, 33602, 93526)

	-- Savage Titanium Ring -- 58492
	recipe = AddRecipe(58492, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(420, 420, 440, 450, 460)
	recipe:SetRecipeItem(43485, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(43482, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(28721, 33602, 93526)

	-- Savage Titanium Band -- 58507
	recipe = AddRecipe(58507, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(420, 420, 440, 450, 460)
	recipe:SetRecipeItem(43497, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(43498, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(28721, 33602, 93526)

	-- Titanium Frostguard Ring -- 58954
	recipe = AddRecipe(58954, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(420, 420, 440, 450, 460)
	recipe:SetRecipeItem(43597, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(43582, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddVendor(28721, 33602, 93526)

	-- Figurine - Monarch Crab -- 59759
	recipe = AddRecipe(59759, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(44063, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_TRINKET")
	recipe:AddFilters(F.TANK)
	recipe:AddTrainer(15501, 18751, 19775, 26915, 26960, 26982, 26997, 28701, 33590, 46675, 93527, 100538)

	-- Icy Prism -- 62242
	recipe = AddRecipe(62242, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(44943, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_MATERIALS")
	recipe:AddTrainer(15501, 18751, 19775, 26915, 26960, 26982, 26997, 28701, 33590, 46675, 93527, 100538)

	-- Emerald Choker -- 64725
	recipe = AddRecipe(64725, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(45, 45, 55, 60, 65)
	recipe:SetCraftedItem(45812, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(15501, 18751, 19775, 26915, 26960, 26982, 26997, 28701, 33590, 46675, 93527, 100538)

	-- Sky Sapphire Amulet -- 64726
	recipe = AddRecipe(64726, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(45, 45, 55, 60, 65)
	recipe:SetCraftedItem(45813, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(15501, 18751, 19775, 26915, 26960, 26982, 26997, 28701, 33590, 46675, 93527, 100538)

	-- Runed Mana Band -- 64727
	recipe = AddRecipe(64727, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(45, 45, 55, 60, 65)
	recipe:SetCraftedItem(45808, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(15501, 18751, 19775, 26915, 26960, 26982, 26997, 28701, 33590, 46675, 93527, 100538)

	-- Scarlet Signet -- 64728
	recipe = AddRecipe(64728, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(45, 45, 55, 60, 65)
	recipe:SetCraftedItem(45809, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(15501, 18751, 19775, 26915, 26960, 26982, 26997, 28701, 33590, 46675, 93527, 100538)

	-- Regal Eye of Zul -- 66338
	recipe = AddRecipe(66338, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(450, 450, 450, 452, 465)
	recipe:SetRecipeItem(46897, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(40167, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddFilters(F.TANK)
	recipe:AddVendor(19065, 28701, 93527)

	-- Steady Eye of Zul -- 66428
	recipe = AddRecipe(66428, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(450, 450, 450, 452, 465)
	recipe:SetRecipeItem(46898, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(40168, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddVendor(19065, 28701, 93527)

	-- Nimble Eye of Zul -- 66429
	recipe = AddRecipe(66429, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(450, 450, 450, 452, 465)
	recipe:SetRecipeItem(46899, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(40166, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.TANK)
	recipe:AddVendor(19065, 28701, 93527)

	-- Jagged Eye of Zul -- 66431
	recipe = AddRecipe(66431, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(450, 450, 450, 452, 465)
	recipe:SetRecipeItem(46901, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(40165, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(19065, 28701, 93527)

	-- Timeless Dreadstone -- 66432
	recipe = AddRecipe(66432, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(450, 450, 450, 452, 465)
	recipe:SetRecipeItem(46902, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(40164, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(19065, 28701, 93527)

	-- Forceful Eye of Zul -- 66434
	recipe = AddRecipe(66434, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(450, 450, 450, 452, 465)
	recipe:SetRecipeItem(46904, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(40169, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(19065, 28701, 93527)

	-- Misty Eye of Zul -- 66435
	recipe = AddRecipe(66435, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(450, 450, 450, 452, 465)
	recipe:SetRecipeItem(46905, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(40171, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(19065, 28701, 93527)

	-- Lightning Eye of Zul -- 66439
	recipe = AddRecipe(66439, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(450, 450, 450, 452, 465)
	recipe:SetRecipeItem(46909, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(40177, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(19065, 28701, 93527)

	-- Radiant Eye of Zul -- 66441
	recipe = AddRecipe(66441, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(450, 450, 450, 452, 465)
	recipe:SetRecipeItem(46911, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(40180, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(19065, 28701, 93527)

	-- Energized Eye of Zul -- 66442
	recipe = AddRecipe(66442, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(450, 450, 450, 452, 465)
	recipe:SetRecipeItem(46912, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(40179, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(19065, 28701, 93527)

	-- Shattered Eye of Zul -- 66443
	recipe = AddRecipe(66443, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(450, 450, 450, 452, 465)
	recipe:SetRecipeItem(46913, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(40182, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(19065, 28701, 93527)

	-- Turbid Eye of Zul -- 66445
	recipe = AddRecipe(66445, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(450, 450, 450, 452, 465)
	recipe:SetRecipeItem(46915, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(40173, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddVendor(19065, 28701, 93527)

	-- Brilliant Cardinal Ruby -- 66446
	recipe = AddRecipe(66446, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(450, 450, 450, 452, 465)
	recipe:SetRecipeItem(46916, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(40113, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_RED")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(19065, 28701, 93527)

	-- Bold Cardinal Ruby -- 66447
	recipe = AddRecipe(66447, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(450, 450, 450, 452, 465)
	recipe:SetRecipeItem(46917, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(40111, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_RED")
	recipe:AddFilters(F.DPS)
	recipe:AddVendor(19065, 28701, 93527)

	-- Delicate Cardinal Ruby -- 66448
	recipe = AddRecipe(66448, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(450, 450, 450, 452, 465)
	recipe:SetRecipeItem(46918, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(40112, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_RED")
	recipe:AddFilters(F.DPS)
	recipe:AddVendor(19065, 28701, 93527)

	-- Precise Cardinal Ruby -- 66450
	recipe = AddRecipe(66450, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(450, 450, 450, 452, 465)
	recipe:SetRecipeItem(46920, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(40118, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_RED")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(19065, 28701, 93527)

	-- Subtle King's Amber -- 66452
	recipe = AddRecipe(66452, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(450, 450, 450, 452, 465)
	recipe:SetRecipeItem(46922, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(40115, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_YELLOW")
	recipe:AddFilters(F.TANK)
	recipe:AddVendor(19065, 28701, 93527)

	-- Flashing Cardinal Ruby -- 66453
	recipe = AddRecipe(66453, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(450, 450, 450, 452, 465)
	recipe:SetRecipeItem(46923, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(40116, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_RED")
	recipe:AddFilters(F.TANK)
	recipe:AddVendor(19065, 28701, 93527)

	-- Solid Majestic Zircon -- 66497
	recipe = AddRecipe(66497, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(450, 450, 450, 452, 465)
	recipe:SetRecipeItem(46924, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(40119, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_BLUE")
	recipe:AddVendor(19065, 28701, 93527)

	-- Sparkling Majestic Zircon -- 66498
	recipe = AddRecipe(66498, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(450, 450, 450, 452, 465)
	recipe:SetRecipeItem(46925, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(40120, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_BLUE")
	recipe:AddVendor(19065, 28701, 93527)

	-- Stormy Majestic Zircon -- 66499
	recipe = AddRecipe(66499, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(450, 450, 450, 452, 465)
	recipe:SetRecipeItem(46926, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(40122, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_BLUE")
	recipe:AddVendor(19065, 28701, 93527)

	-- Rigid Majestic Zircon -- 66501
	recipe = AddRecipe(66501, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(450, 450, 450, 452, 465)
	recipe:SetRecipeItem(46928, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(40125, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_BLUE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(19065, 28701, 93527)

	-- Smooth King's Amber -- 66502
	recipe = AddRecipe(66502, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(450, 450, 450, 452, 465)
	recipe:SetRecipeItem(46929, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(40124, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_YELLOW")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(19065, 28701, 93527)

	-- Mystic King's Amber -- 66505
	recipe = AddRecipe(66505, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(450, 450, 450, 452, 465)
	recipe:SetRecipeItem(46932, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(40127, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_YELLOW")
	recipe:AddVendor(19065, 28701, 93527)

	-- Quick King's Amber -- 66506
	recipe = AddRecipe(66506, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(450, 450, 450, 452, 465)
	recipe:SetRecipeItem(46933, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(40128, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_YELLOW")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(19065, 28701, 93527)

	-- Sovereign Dreadstone -- 66554
	recipe = AddRecipe(66554, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(450, 450, 450, 452, 465)
	recipe:SetRecipeItem(46935, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(40129, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.DPS)
	recipe:AddVendor(19065, 28701, 93527)

	-- Purified Dreadstone -- 66556
	recipe = AddRecipe(66556, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(450, 450, 450, 452, 465)
	recipe:SetRecipeItem(46937, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(40133, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(19065, 28701, 93527)

	-- Shifting Dreadstone -- 66557
	recipe = AddRecipe(66557, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(450, 450, 450, 452, 465)
	recipe:SetRecipeItem(46938, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(40130, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.DPS)
	recipe:AddVendor(19065, 28701, 93527)

	-- Defender's Dreadstone -- 66560
	recipe = AddRecipe(66560, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(450, 450, 450, 452, 465)
	recipe:SetRecipeItem(46941, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(40139, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.TANK)
	recipe:AddVendor(19065, 28701, 93527)

	-- Guardian's Dreadstone -- 66561
	recipe = AddRecipe(66561, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(450, 450, 450, 452, 465)
	recipe:SetRecipeItem(46942, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(40141, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(19065, 28701, 93527)

	-- Mysterious Dreadstone -- 66562
	recipe = AddRecipe(66562, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(450, 450, 450, 452, 465)
	recipe:SetRecipeItem(46943, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(40135, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(19065, 28701, 93527)

	-- Inscribed Ametrine -- 66567
	recipe = AddRecipe(66567, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(450, 450, 450, 452, 465)
	recipe:SetRecipeItem(46948, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(40142, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(19065, 28701, 93527)

	-- Deadly Ametrine -- 66568
	recipe = AddRecipe(66568, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(450, 450, 450, 452, 465)
	recipe:SetRecipeItem(46949, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(40147, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(19065, 28701, 93527)

	-- Potent Ametrine -- 66569
	recipe = AddRecipe(66569, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(450, 450, 450, 452, 465)
	recipe:SetRecipeItem(46950, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(40152, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(19065, 28701, 93527)

	-- Veiled Dreadstone -- 66570
	recipe = AddRecipe(66570, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(450, 450, 450, 452, 465)
	recipe:SetRecipeItem(46951, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(40153, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(19065, 28701, 93527)

	-- Willful Ametrine -- 66571
	recipe = AddRecipe(66571, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(450, 450, 450, 452, 465)
	recipe:SetRecipeItem(46952, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(40154, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(19065, 28701, 93527)

	-- Etched Dreadstone -- 66572
	recipe = AddRecipe(66572, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(450, 450, 450, 452, 465)
	recipe:SetRecipeItem(46953, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(40143, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(19065, 28701, 93527)

	-- Glinting Dreadstone -- 66573
	recipe = AddRecipe(66573, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(450, 450, 450, 452, 465)
	recipe:SetRecipeItem(46956, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(40157, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(19065, 28701, 93527)

	-- Reckless Ametrine -- 66574
	recipe = AddRecipe(66574, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(450, 450, 450, 452, 465)
	recipe:SetRecipeItem(47007, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(40155, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(19065, 28701, 93527)

	-- Accurate Dreadstone -- 66576
	recipe = AddRecipe(66576, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(450, 450, 450, 452, 465)
	recipe:SetRecipeItem(47010, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(40162, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(19065, 28701, 93527)

	-- Champion's Ametrine -- 66579
	recipe = AddRecipe(66579, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(450, 450, 450, 452, 465)
	recipe:SetRecipeItem(47015, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(40144, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.DPS, F.TANK)
	recipe:AddVendor(19065, 28701, 93527)

	-- Stalwart Ametrine -- 66581
	recipe = AddRecipe(66581, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(450, 450, 450, 452, 465)
	recipe:SetRecipeItem(47017, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(40160, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.TANK)
	recipe:AddVendor(19065, 28701, 93527)

	-- Resplendent Ametrine -- 66582
	recipe = AddRecipe(66582, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(450, 450, 450, 452, 465)
	recipe:SetRecipeItem(47018, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(40145, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.DPS)
	recipe:AddVendor(19065, 28701, 93527)

	-- Fierce Ametrine -- 66583
	recipe = AddRecipe(66583, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(450, 450, 450, 452, 465)
	recipe:SetRecipeItem(47019, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(40146, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(19065, 28701, 93527)

	-- Deft Ametrine -- 66584
	recipe = AddRecipe(66584, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(450, 450, 450, 452, 465)
	recipe:SetRecipeItem(47020, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(40150, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(19065, 28701, 93527)

	-- Lucent Ametrine -- 66585
	recipe = AddRecipe(66585, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(450, 450, 450, 452, 465)
	recipe:SetRecipeItem(47021, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(40149, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.DPS)
	recipe:AddVendor(19065, 28701, 93527)

	-- Resolute Ametrine -- 66586
	recipe = AddRecipe(66586, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(450, 450, 450, 452, 465)
	recipe:SetRecipeItem(47022, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(40163, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.TANK)
	recipe:AddVendor(19065, 28701, 93527)

	-- Nightmare Tear -- 68253
	recipe = AddRecipe(68253, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(450, 450, 450, 452, 465)
	recipe:SetRecipeItem(49112, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(49110, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PRISMATIC")
	recipe:AddVendor(19065, 28701, 93527)

	-- ----------------------------------------------------------------------------
	-- Cataclysm.
	-- ----------------------------------------------------------------------------
	-- Bold Carnelian -- 73222
	recipe = AddRecipe(73222, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(52081, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_RED")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(5388, 15501, 18751, 19775, 19778, 44582, 46675, 52586, 52587, 52645, 52657, 93527, 100538)

	-- Delicate Carnelian -- 73223
	recipe = AddRecipe(73223, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(52082, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_RED")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(5388, 15501, 18751, 19775, 19778, 44582, 46675, 52586, 52587, 52645, 52657, 93527, 100538)

	-- Flashing Carnelian -- 73224
	recipe = AddRecipe(73224, V.CATA, Q.UNCOMMON)
	recipe:SetSkillLevels(425, 425, 450, 467, 485)
	recipe:SetRecipeItem(52363, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(52083, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_RED")
	recipe:AddFilters(F.TANK)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Brilliant Carnelian -- 73225
	recipe = AddRecipe(73225, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(52084, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_RED")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(5388, 15501, 18751, 19775, 19778, 44582, 46675, 52586, 52587, 52645, 52657, 93527, 100538)

	-- Precise Carnelian -- 73226
	recipe = AddRecipe(73226, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(52085, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_RED")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(5388, 15501, 18751, 19775, 19778, 44582, 46675, 52586, 52587, 52645, 52657, 93527, 100538)

	-- Solid Zephyrite -- 73227
	recipe = AddRecipe(73227, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(52086, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_BLUE")
	recipe:AddTrainer(5388, 15501, 18751, 19775, 19778, 44582, 46675, 52586, 52587, 52645, 52657, 93527, 100538)

	-- Sparkling Zephyrite -- 73228
	recipe = AddRecipe(73228, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(52087, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_BLUE")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(5388, 15501, 18751, 19775, 19778, 44582, 46675, 52586, 52587, 52645, 52657, 93527, 100538)

	-- Stormy Zephyrite -- 73229
	recipe = AddRecipe(73229, V.CATA, Q.UNCOMMON)
	recipe:SetSkillLevels(425, 425, 450, 467, 485)
	recipe:SetRecipeItem(52364, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(52088, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_BLUE")
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Rigid Zephyrite -- 73230
	recipe = AddRecipe(73230, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(52089, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_BLUE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(5388, 15501, 18751, 19775, 19778, 44582, 46675, 52586, 52587, 52645, 52657, 93527, 100538)

	-- Subtle Alicite -- 73231
	recipe = AddRecipe(73231, V.CATA, Q.UNCOMMON)
	recipe:SetSkillLevels(425, 425, 450, 467, 485)
	recipe:SetRecipeItem(52365, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(52090, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_YELLOW")
	recipe:AddFilters(F.TANK)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Smooth Alicite -- 73232
	recipe = AddRecipe(73232, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(52091, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_YELLOW")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(5388, 15501, 18751, 19775, 19778, 44582, 46675, 52586, 52587, 52645, 52657, 93527, 100538)

	-- Quick Alicite -- 73234
	recipe = AddRecipe(73234, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(52093, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_YELLOW")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(5388, 15501, 18751, 19775, 19778, 44582, 46675, 52586, 52587, 52645, 52657, 93527, 100538)

	-- Fractured Alicite -- 73239
	recipe = AddRecipe(73239, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(52094, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_YELLOW")
	recipe:AddTrainer(5388, 15501, 18751, 19775, 19778, 44582, 46675, 52586, 52587, 52645, 52657, 93527, 100538)

	-- Sovereign Nightstone -- 73240
	recipe = AddRecipe(73240, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(52095, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(5388, 15501, 18751, 19775, 19778, 44582, 46675, 52586, 52587, 52645, 52657, 93527, 100538)

	-- Shifting Nightstone -- 73241
	recipe = AddRecipe(73241, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(52096, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(5388, 15501, 18751, 19775, 19778, 44582, 46675, 52586, 52587, 52645, 52657, 93527, 100538)

	-- Defender's Nightstone -- 73242
	recipe = AddRecipe(73242, V.CATA, Q.UNCOMMON)
	recipe:SetSkillLevels(425, 425, 450, 467, 485)
	recipe:SetRecipeItem(52366, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(52097, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.TANK)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Timeless Nightstone -- 73243
	recipe = AddRecipe(73243, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(52098, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(5388, 15501, 18751, 19775, 19778, 44582, 46675, 52586, 52587, 52645, 52657, 93527, 100538)

	-- Guardian's Nightstone -- 73244
	recipe = AddRecipe(73244, V.CATA, Q.UNCOMMON)
	recipe:SetSkillLevels(425, 425, 450, 467, 485)
	recipe:SetRecipeItem(52367, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(52099, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Purified Nightstone -- 73245
	recipe = AddRecipe(73245, V.CATA, Q.UNCOMMON)
	recipe:SetSkillLevels(425, 425, 450, 467, 485)
	recipe:SetRecipeItem(52368, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(52100, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Etched Nightstone -- 73246
	recipe = AddRecipe(73246, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(52101, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(5388, 15501, 18751, 19775, 19778, 44582, 46675, 52586, 52587, 52645, 52657, 93527, 100538)

	-- Glinting Nightstone -- 73247
	recipe = AddRecipe(73247, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(52102, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(5388, 15501, 18751, 19775, 19778, 44582, 46675, 52586, 52587, 52645, 52657, 93527, 100538)

	-- Retaliating Nightstone -- 73248
	recipe = AddRecipe(73248, V.CATA, Q.UNCOMMON)
	recipe:SetSkillLevels(425, 425, 450, 467, 485)
	recipe:SetRecipeItem(52369, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(52103, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.TANK)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Veiled Nightstone -- 73249
	recipe = AddRecipe(73249, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(52104, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(5388, 15501, 18751, 19775, 19778, 44582, 46675, 52586, 52587, 52645, 52657, 93527, 100538)

	-- Accurate Nightstone -- 73250
	recipe = AddRecipe(73250, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(52105, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(5388, 15501, 18751, 19775, 19778, 44582, 46675, 52586, 52587, 52645, 52657, 93527, 100538)

	-- Polished Hessonite -- 73258
	recipe = AddRecipe(73258, V.CATA, Q.UNCOMMON)
	recipe:SetSkillLevels(425, 425, 450, 467, 485)
	recipe:SetRecipeItem(52370, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(52106, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.DPS, F.TANK)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Inscribed Hessonite -- 73260
	recipe = AddRecipe(73260, V.CATA, Q.UNCOMMON)
	recipe:SetSkillLevels(425, 425, 450, 467, 485)
	recipe:SetRecipeItem(52371, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(52108, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Deadly Hessonite -- 73262
	recipe = AddRecipe(73262, V.CATA, Q.UNCOMMON)
	recipe:SetSkillLevels(425, 425, 450, 467, 485)
	recipe:SetRecipeItem(52372, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(52109, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Potent Hessonite -- 73263
	recipe = AddRecipe(73263, V.CATA, Q.UNCOMMON)
	recipe:SetSkillLevels(425, 425, 450, 467, 485)
	recipe:SetRecipeItem(52373, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(52110, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Fierce Hessonite -- 73264
	recipe = AddRecipe(73264, V.CATA, Q.UNCOMMON)
	recipe:SetSkillLevels(425, 425, 450, 467, 485)
	recipe:SetRecipeItem(52374, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(52111, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Deft Hessonite -- 73265
	recipe = AddRecipe(73265, V.CATA, Q.UNCOMMON)
	recipe:SetSkillLevels(425, 425, 450, 467, 485)
	recipe:SetRecipeItem(52375, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(52112, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Reckless Hessonite -- 73266
	recipe = AddRecipe(73266, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(52113, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(5388, 15501, 18751, 19775, 19778, 44582, 46675, 52586, 52587, 52645, 52657, 93527, 100538)

	-- Skillful Hessonite -- 73267
	recipe = AddRecipe(73267, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(52114, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(5388, 15501, 18751, 19775, 19778, 44582, 46675, 52586, 52587, 52645, 52657, 93527, 100538)

	-- Adept Hessonite -- 73268
	recipe = AddRecipe(73268, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(52115, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(5388, 15501, 18751, 19775, 19778, 44582, 46675, 52586, 52587, 52645, 52657, 93527, 100538)

	-- Fine Hessonite -- 73269
	recipe = AddRecipe(73269, V.CATA, Q.UNCOMMON)
	recipe:SetSkillLevels(425, 425, 450, 467, 485)
	recipe:SetRecipeItem(52376, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(52116, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.TANK)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Artful Hessonite -- 73270
	recipe = AddRecipe(73270, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(52117, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(5388, 15501, 18751, 19775, 19778, 44582, 46675, 52586, 52587, 52645, 52657, 93527, 100538)

	-- Keen Hessonite -- 73271
	recipe = AddRecipe(73271, V.CATA, Q.UNCOMMON)
	recipe:SetSkillLevels(425, 425, 450, 467, 485)
	recipe:SetRecipeItem(52377, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(52118, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Regal Jasper -- 73272
	recipe = AddRecipe(73272, V.CATA, Q.UNCOMMON)
	recipe:SetSkillLevels(425, 425, 450, 467, 485)
	recipe:SetRecipeItem(52378, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(52119, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddFilters(F.TANK)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Nimble Jasper -- 73273
	recipe = AddRecipe(73273, V.CATA, Q.UNCOMMON)
	recipe:SetSkillLevels(425, 425, 450, 467, 485)
	recipe:SetRecipeItem(52379, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(52120, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.TANK)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Jagged Jasper -- 73274
	recipe = AddRecipe(73274, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(52121, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(5388, 15501, 18751, 19775, 19778, 44582, 46675, 52586, 52587, 52645, 52657, 93527, 100538)

	-- Piercing Jasper -- 73275
	recipe = AddRecipe(73275, V.CATA, Q.UNCOMMON)
	recipe:SetSkillLevels(425, 425, 450, 467, 485)
	recipe:SetRecipeItem(52382, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(52122, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Steady Jasper -- 73276
	recipe = AddRecipe(73276, V.CATA, Q.UNCOMMON)
	recipe:SetSkillLevels(425, 425, 450, 467, 485)
	recipe:SetRecipeItem(52383, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(52123, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Forceful Jasper -- 73277
	recipe = AddRecipe(73277, V.CATA, Q.UNCOMMON)
	recipe:SetSkillLevels(425, 425, 450, 467, 485)
	recipe:SetRecipeItem(52385, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(52124, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Lightning Jasper -- 73278
	recipe = AddRecipe(73278, V.CATA, Q.UNCOMMON)
	recipe:SetSkillLevels(425, 425, 450, 467, 485)
	recipe:SetRecipeItem(52386, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(52125, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Puissant Jasper -- 73279
	recipe = AddRecipe(73279, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(52126, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddTrainer(5388, 15501, 18751, 19775, 19778, 44582, 46675, 52586, 52587, 52645, 52657, 93527, 100538)

	-- Zen Jasper -- 73280
	recipe = AddRecipe(73280, V.CATA, Q.UNCOMMON)
	recipe:SetSkillLevels(425, 425, 450, 467, 485)
	recipe:SetRecipeItem(52388, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(52127, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Sensei's Jasper -- 73281
	recipe = AddRecipe(73281, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(52128, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(5388, 15501, 18751, 19775, 19778, 44582, 46675, 52586, 52587, 52645, 52657, 93527, 100538)

	-- Bold Inferno Ruby -- 73335
	recipe = AddRecipe(73335, V.CATA, Q.RARE)
	recipe:SetSkillLevels(465, 465, 500, 507, 515)
	recipe:SetRecipeItem(52362, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_RED")
	recipe:AddFilters(F.DPS)
	recipe:AddVendor(16624, 17512, 44583, 50480, 50482, 52584, 52588, 52644, 52658)

	-- Delicate Inferno Ruby -- 73336
	recipe = AddRecipe(73336, V.CATA, Q.RARE)
	recipe:SetSkillLevels(465, 465, 500, 507, 515)
	recipe:SetRecipeItem(52380, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_RED")
	recipe:AddVendor(16624, 17512, 44583, 50480, 50482, 52584, 52588, 52644, 52658)

	-- Flashing Inferno Ruby -- 73337
	recipe = AddRecipe(73337, V.CATA, Q.RARE)
	recipe:SetSkillLevels(465, 465, 500, 507, 515)
	recipe:SetRecipeItem(52384, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_RED")
	recipe:AddFilters(F.TANK)
	recipe:AddVendor(16624, 17512, 44583, 50480, 50482, 52584, 52588, 52644, 52658)

	-- Brilliant Inferno Ruby -- 73338
	recipe = AddRecipe(73338, V.CATA, Q.RARE)
	recipe:SetSkillLevels(465, 465, 500, 507, 515)
	recipe:SetRecipeItem(52387, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_RED")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(16624, 17512, 44583, 50480, 50482, 52584, 52588, 52644, 52658)

	-- Precise Inferno Ruby -- 73339
	recipe = AddRecipe(73339, V.CATA, Q.RARE)
	recipe:SetSkillLevels(465, 465, 500, 507, 515)
	recipe:SetRecipeItem(52389, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_RED")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(16624, 17512, 44583, 50480, 50482, 52584, 52588, 52644, 52658)

	-- Solid Ocean Sapphire -- 73340
	recipe = AddRecipe(73340, V.CATA, Q.RARE)
	recipe:SetSkillLevels(465, 465, 500, 507, 515)
	recipe:SetRecipeItem(52390, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_BLUE")
	recipe:AddVendor(16624, 17512, 44583, 50480, 50482, 52584, 52588, 52644, 52658)

	-- Sparkling Ocean Sapphire -- 73341
	recipe = AddRecipe(73341, V.CATA, Q.RARE)
	recipe:SetSkillLevels(465, 465, 500, 507, 515)
	recipe:SetRecipeItem(52391, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_BLUE")
	recipe:AddVendor(16624, 17512, 44583, 50480, 50482, 52584, 52588, 52644, 52658)

	-- Stormy Ocean Sapphire -- 73343
	recipe = AddRecipe(73343, V.CATA, Q.RARE)
	recipe:SetSkillLevels(465, 465, 500, 507, 515)
	recipe:SetRecipeItem(52392, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_BLUE")
	recipe:AddVendor(16624, 17512, 44583, 50480, 50482, 52584, 52588, 52644, 52658)

	-- Rigid Ocean Sapphire -- 73344
	recipe = AddRecipe(73344, V.CATA, Q.RARE)
	recipe:SetSkillLevels(465, 465, 500, 507, 515)
	recipe:SetRecipeItem(52393, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_BLUE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(16624, 17512, 44583, 50480, 50482, 52584, 52588, 52644, 52658)

	-- Subtle Amberjewel -- 73345
	recipe = AddRecipe(73345, V.CATA, Q.RARE)
	recipe:SetSkillLevels(465, 465, 500, 507, 515)
	recipe:SetRecipeItem(52394, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_YELLOW")
	recipe:AddFilters(F.TANK)
	recipe:AddVendor(16624, 17512, 44583, 50480, 50482, 52584, 52588, 52644, 52658)

	-- Smooth Amberjewel -- 73346
	recipe = AddRecipe(73346, V.CATA, Q.RARE)
	recipe:SetSkillLevels(465, 465, 500, 507, 515)
	recipe:SetRecipeItem(52395, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_YELLOW")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(16624, 17512, 44583, 50480, 50482, 52584, 52588, 52644, 52658)

	-- Mystic Amberjewel -- 73347
	recipe = AddRecipe(73347, V.CATA, Q.RARE)
	recipe:SetSkillLevels(465, 465, 500, 507, 515)
	recipe:SetRecipeItem(52396, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_YELLOW")
	recipe:AddVendor(16624, 17512, 44583, 50480, 50482, 52584, 52588, 52644, 52658)

	-- Quick Amberjewel -- 73348
	recipe = AddRecipe(73348, V.CATA, Q.RARE)
	recipe:SetSkillLevels(465, 465, 500, 507, 515)
	recipe:SetRecipeItem(52397, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_YELLOW")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(16624, 17512, 44583, 50480, 50482, 52584, 52588, 52644, 52658)

	-- Fractured Amberjewel -- 73349
	recipe = AddRecipe(73349, V.CATA, Q.RARE)
	recipe:SetSkillLevels(465, 465, 500, 507, 515)
	recipe:SetRecipeItem(52398, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_YELLOW")
	recipe:AddVendor(16624, 17512, 44583, 50480, 50482, 52584, 52588, 52644, 52658)

	-- Sovereign Demonseye -- 73350
	recipe = AddRecipe(73350, V.CATA, Q.RARE)
	recipe:SetSkillLevels(465, 465, 500, 507, 515)
	recipe:SetRecipeItem(52399, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.DPS)
	recipe:AddVendor(16624, 17512, 44583, 50480, 50482, 52584, 52588, 52644, 52658)

	-- Shifting Demonseye -- 73351
	recipe = AddRecipe(73351, V.CATA, Q.RARE)
	recipe:SetSkillLevels(465, 465, 500, 507, 515)
	recipe:SetRecipeItem(52400, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.DPS)
	recipe:AddVendor(16624, 17512, 44583, 50480, 50482, 52584, 52588, 52644, 52658)

	-- Defender's Demonseye -- 73352
	recipe = AddRecipe(73352, V.CATA, Q.RARE)
	recipe:SetSkillLevels(465, 465, 500, 507, 515)
	recipe:SetRecipeItem(52401, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.TANK)
	recipe:AddVendor(16624, 17512, 44583, 50480, 50482, 52584, 52588, 52644, 52658)

	-- Timeless Demonseye -- 73353
	recipe = AddRecipe(73353, V.CATA, Q.RARE)
	recipe:SetSkillLevels(465, 465, 500, 507, 515)
	recipe:SetRecipeItem(52402, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(16624, 17512, 44583, 50480, 50482, 52584, 52588, 52644, 52658)

	-- Guardian's Demonseye -- 73354
	recipe = AddRecipe(73354, V.CATA, Q.RARE)
	recipe:SetSkillLevels(465, 465, 500, 507, 515)
	recipe:SetRecipeItem(52403, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(16624, 17512, 44583, 50480, 50482, 52584, 52588, 52644, 52658)

	-- Purified Demonseye -- 73355
	recipe = AddRecipe(73355, V.CATA, Q.RARE)
	recipe:SetSkillLevels(465, 465, 500, 507, 515)
	recipe:SetRecipeItem(52404, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(16624, 17512, 44583, 50480, 50482, 52584, 52588, 52644, 52658)

	-- Etched Demonseye -- 73356
	recipe = AddRecipe(73356, V.CATA, Q.RARE)
	recipe:SetSkillLevels(465, 465, 500, 507, 515)
	recipe:SetRecipeItem(52405, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(16624, 17512, 44583, 50480, 50482, 52584, 52588, 52644, 52658)

	-- Glinting Demonseye -- 73357
	recipe = AddRecipe(73357, V.CATA, Q.RARE)
	recipe:SetSkillLevels(465, 465, 500, 507, 515)
	recipe:SetRecipeItem(52406, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(16624, 17512, 44583, 50480, 50482, 52584, 52588, 52644, 52658)

	-- Retaliating Demonseye -- 73358
	recipe = AddRecipe(73358, V.CATA, Q.RARE)
	recipe:SetSkillLevels(465, 465, 500, 507, 515)
	recipe:SetRecipeItem(52407, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.TANK)
	recipe:AddVendor(16624, 17512, 44583, 50480, 50482, 52584, 52588, 52644, 52658)

	-- Veiled Demonseye -- 73359
	recipe = AddRecipe(73359, V.CATA, Q.RARE)
	recipe:SetSkillLevels(465, 465, 500, 507, 515)
	recipe:SetRecipeItem(52408, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(16624, 17512, 44583, 50480, 50482, 52584, 52588, 52644, 52658)

	-- Accurate Demonseye -- 73360
	recipe = AddRecipe(73360, V.CATA, Q.RARE)
	recipe:SetSkillLevels(465, 465, 500, 507, 515)
	recipe:SetRecipeItem(52409, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(16624, 17512, 44583, 50480, 50482, 52584, 52588, 52644, 52658)

	-- Polished Ember Topaz -- 73361
	recipe = AddRecipe(73361, V.CATA, Q.RARE)
	recipe:SetSkillLevels(465, 465, 500, 507, 515)
	recipe:SetRecipeItem(52410, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.DPS, F.TANK)
	recipe:AddVendor(16624, 17512, 44583, 50480, 50482, 52584, 52588, 52644, 52658)

	-- Resolute Ember Topaz -- 73362
	recipe = AddRecipe(73362, V.CATA, Q.RARE)
	recipe:SetSkillLevels(465, 465, 500, 507, 515)
	recipe:SetRecipeItem(52411, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.TANK)
	recipe:AddVendor(16624, 17512, 44583, 50480, 50482, 52584, 52588, 52644, 52658)

	-- Inscribed Ember Topaz -- 73364
	recipe = AddRecipe(73364, V.CATA, Q.RARE)
	recipe:SetSkillLevels(465, 465, 500, 507, 515)
	recipe:SetRecipeItem(52412, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(16624, 17512, 44583, 50480, 50482, 52584, 52588, 52644, 52658)

	-- Deadly Ember Topaz -- 73365
	recipe = AddRecipe(73365, V.CATA, Q.RARE)
	recipe:SetSkillLevels(465, 465, 500, 507, 515)
	recipe:SetRecipeItem(52413, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(16624, 17512, 44583, 50480, 50482, 52584, 52588, 52644, 52658)

	-- Potent Ember Topaz -- 73366
	recipe = AddRecipe(73366, V.CATA, Q.RARE)
	recipe:SetSkillLevels(465, 465, 500, 507, 515)
	recipe:SetRecipeItem(52414, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(16624, 17512, 44583, 50480, 50482, 52584, 52588, 52644, 52658)

	-- Fierce Ember Topaz -- 73367
	recipe = AddRecipe(73367, V.CATA, Q.RARE)
	recipe:SetSkillLevels(465, 465, 500, 507, 515)
	recipe:SetRecipeItem(52415, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(16624, 17512, 44583, 50480, 50482, 52584, 52588, 52644, 52658)

	-- Deft Ember Topaz -- 73368
	recipe = AddRecipe(73368, V.CATA, Q.RARE)
	recipe:SetSkillLevels(465, 465, 500, 507, 515)
	recipe:SetRecipeItem(52416, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(16624, 17512, 44583, 50480, 50482, 52584, 52588, 52644, 52658)

	-- Reckless Ember Topaz -- 73369
	recipe = AddRecipe(73369, V.CATA, Q.RARE)
	recipe:SetSkillLevels(465, 465, 500, 507, 515)
	recipe:SetRecipeItem(52417, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(16624, 17512, 44583, 50480, 50482, 52584, 52588, 52644, 52658)

	-- Skillful Ember Topaz -- 73370
	recipe = AddRecipe(73370, V.CATA, Q.RARE)
	recipe:SetSkillLevels(465, 465, 500, 507, 515)
	recipe:SetRecipeItem(52418, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.DPS)
	recipe:AddVendor(16624, 17512, 44583, 50480, 50482, 52584, 52588, 52644, 52658)

	-- Adept Ember Topaz -- 73371
	recipe = AddRecipe(73371, V.CATA, Q.RARE)
	recipe:SetSkillLevels(465, 465, 500, 507, 515)
	recipe:SetRecipeItem(52419, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.DPS)
	recipe:AddVendor(16624, 17512, 44583, 50480, 50482, 52584, 52588, 52644, 52658)

	-- Fine Ember Topaz -- 73372
	recipe = AddRecipe(73372, V.CATA, Q.RARE)
	recipe:SetSkillLevels(465, 465, 500, 507, 515)
	recipe:SetRecipeItem(52420, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.TANK)
	recipe:AddVendor(16624, 17512, 44583, 50480, 50482, 52584, 52588, 52644, 52658)

	-- Artful Ember Topaz -- 73373
	recipe = AddRecipe(73373, V.CATA, Q.RARE)
	recipe:SetSkillLevels(465, 465, 500, 507, 515)
	recipe:SetRecipeItem(52421, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(16624, 17512, 44583, 50480, 50482, 52584, 52588, 52644, 52658)

	-- Keen Ember Topaz -- 73374
	recipe = AddRecipe(73374, V.CATA, Q.RARE)
	recipe:SetSkillLevels(465, 465, 500, 507, 515)
	recipe:SetRecipeItem(52422, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(16624, 17512, 44583, 50480, 50482, 52584, 52588, 52644, 52658)

	-- Regal Dream Emerald -- 73375
	recipe = AddRecipe(73375, V.CATA, Q.RARE)
	recipe:SetSkillLevels(465, 465, 500, 507, 515)
	recipe:SetRecipeItem(52423, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddFilters(F.TANK)
	recipe:AddVendor(16624, 17512, 44583, 50480, 50482, 52584, 52588, 52644, 52658)

	-- Nimble Dream Emerald -- 73376
	recipe = AddRecipe(73376, V.CATA, Q.RARE)
	recipe:SetSkillLevels(465, 465, 500, 507, 515)
	recipe:SetRecipeItem(52424, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.TANK)
	recipe:AddVendor(16624, 17512, 44583, 50480, 50482, 52584, 52588, 52644, 52658)

	-- Jagged Dream Emerald -- 73377
	recipe = AddRecipe(73377, V.CATA, Q.RARE)
	recipe:SetSkillLevels(465, 465, 500, 507, 515)
	recipe:SetRecipeItem(52425, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(16624, 17512, 44583, 50480, 50482, 52584, 52588, 52644, 52658)

	-- Piercing Dream Emerald -- 73378
	recipe = AddRecipe(73378, V.CATA, Q.RARE)
	recipe:SetSkillLevels(465, 465, 500, 507, 515)
	recipe:SetRecipeItem(52426, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(16624, 17512, 44583, 50480, 50482, 52584, 52588, 52644, 52658)

	-- Steady Dream Emerald -- 73379
	recipe = AddRecipe(73379, V.CATA, Q.RARE)
	recipe:SetSkillLevels(465, 465, 500, 507, 515)
	recipe:SetRecipeItem(52427, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddVendor(16624, 17512, 44583, 50480, 50482, 52584, 52588, 52644, 52658)

	-- Forceful Dream Emerald -- 73380
	recipe = AddRecipe(73380, V.CATA, Q.RARE)
	recipe:SetSkillLevels(465, 465, 500, 507, 515)
	recipe:SetRecipeItem(52428, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddVendor(16624, 17512, 44583, 50480, 50482, 52584, 52588, 52644, 52658)

	-- Lightning Dream Emerald -- 73381
	recipe = AddRecipe(73381, V.CATA, Q.RARE)
	recipe:SetSkillLevels(465, 465, 500, 507, 515)
	recipe:SetRecipeItem(52429, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddVendor(16624, 17512, 44583, 50480, 50482, 52584, 52588, 52644, 52658)

	-- Puissant Dream Emerald -- 73382
	recipe = AddRecipe(73382, V.CATA, Q.RARE)
	recipe:SetSkillLevels(465, 465, 500, 507, 515)
	recipe:SetRecipeItem(52430, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddVendor(16624, 17512, 44583, 50480, 50482, 52584, 52588, 52644, 52658)

	-- Zen Dream Emerald -- 73383
	recipe = AddRecipe(73383, V.CATA, Q.RARE)
	recipe:SetSkillLevels(465, 465, 500, 507, 515)
	recipe:SetRecipeItem(52431, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddVendor(16624, 17512, 44583, 50480, 50482, 52584, 52588, 52644, 52658)

	-- Sensei's Dream Emerald -- 73384
	recipe = AddRecipe(73384, V.CATA, Q.RARE)
	recipe:SetSkillLevels(465, 465, 500, 507, 515)
	recipe:SetRecipeItem(52432, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(16624, 17512, 44583, 50480, 50482, 52584, 52588, 52644, 52658)

	-- Bold Chimera's Eye -- 73396
	recipe = AddRecipe(73396, V.CATA, Q.EPIC)
	recipe:SetSkillLevels(500, 500, 505, 507, 510)
	recipe:SetRecipeItem(52381, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_RED")
	recipe:AddVendor(16624, 17512, 44583, 50480, 50482, 52584, 52588, 52644, 52658)

	-- Delicate Chimera's Eye -- 73397
	recipe = AddRecipe(73397, V.CATA, Q.EPIC)
	recipe:SetSkillLevels(500, 500, 505, 507, 510)
	recipe:SetRecipeItem(52447, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_RED")
	recipe:AddFilters(F.DPS)
	recipe:AddVendor(16624, 17512, 44583, 50480, 50482, 52584, 52588, 52644, 52658)

	-- Flashing Chimera's Eye -- 73398
	recipe = AddRecipe(73398, V.CATA, Q.EPIC)
	recipe:SetSkillLevels(500, 500, 505, 507, 510)
	recipe:SetRecipeItem(52448, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_RED")
	recipe:AddVendor(16624, 17512, 44583, 50480, 50482, 52584, 52588, 52644, 52658)

	-- Brilliant Chimera's Eye -- 73399
	recipe = AddRecipe(73399, V.CATA, Q.EPIC)
	recipe:SetSkillLevels(500, 500, 505, 507, 510)
	recipe:SetRecipeItem(52449, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_RED")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(16624, 17512, 44583, 50480, 50482, 52584, 52588, 52644, 52658)

	-- Precise Chimera's Eye -- 73400
	recipe = AddRecipe(73400, V.CATA, Q.EPIC)
	recipe:SetSkillLevels(500, 500, 505, 507, 510)
	recipe:SetRecipeItem(52450, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_RED")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(16624, 17512, 44583, 50480, 50482, 52584, 52588, 52644, 52658)

	-- Solid Chimera's Eye -- 73401
	recipe = AddRecipe(73401, V.CATA, Q.EPIC)
	recipe:SetSkillLevels(500, 500, 505, 507, 510)
	recipe:SetRecipeItem(52451, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_BLUE")
	recipe:AddVendor(16624, 17512, 44583, 50480, 50482, 52584, 52588, 52644, 52658)

	-- Sparkling Chimera's Eye -- 73402
	recipe = AddRecipe(73402, V.CATA, Q.EPIC)
	recipe:SetSkillLevels(500, 500, 505, 507, 510)
	recipe:SetRecipeItem(52452, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(52262, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_BLUE")
	recipe:AddVendor(16624, 17512, 44583, 50480, 50482, 52584, 52588, 52644, 52658)

	-- Stormy Chimera's Eye -- 73403
	recipe = AddRecipe(73403, V.CATA, Q.EPIC)
	recipe:SetSkillLevels(500, 500, 505, 507, 510)
	recipe:SetRecipeItem(52453, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(52263, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_BLUE")
	recipe:AddVendor(16624, 17512, 44583, 50480, 50482, 52584, 52588, 52644, 52658)

	-- Rigid Chimera's Eye -- 73404
	recipe = AddRecipe(73404, V.CATA, Q.EPIC)
	recipe:SetSkillLevels(500, 500, 505, 507, 510)
	recipe:SetRecipeItem(52454, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_BLUE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(16624, 17512, 44583, 50480, 50482, 52584, 52588, 52644, 52658)

	-- Subtle Chimera's Eye -- 73405
	recipe = AddRecipe(73405, V.CATA, Q.EPIC)
	recipe:SetSkillLevels(500, 500, 505, 507, 510)
	recipe:SetRecipeItem(52455, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(52265, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_YELLOW")
	recipe:AddFilters(F.TANK)
	recipe:AddVendor(16624, 17512, 44583, 50480, 50482, 52584, 52588, 52644, 52658)

	-- Smooth Chimera's Eye -- 73406
	recipe = AddRecipe(73406, V.CATA, Q.EPIC)
	recipe:SetSkillLevels(500, 500, 505, 507, 510)
	recipe:SetRecipeItem(52456, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_YELLOW")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(16624, 17512, 44583, 50480, 50482, 52584, 52588, 52644, 52658)

	-- Mystic Chimera's Eye -- 73407
	recipe = AddRecipe(73407, V.CATA, Q.EPIC)
	recipe:SetSkillLevels(500, 500, 505, 507, 510)
	recipe:SetRecipeItem(52457, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_YELLOW")
	recipe:AddVendor(16624, 17512, 44583, 50480, 50482, 52584, 52588, 52644, 52658)

	-- Quick Chimera's Eye -- 73408
	recipe = AddRecipe(73408, V.CATA, Q.EPIC)
	recipe:SetSkillLevels(500, 500, 505, 507, 510)
	recipe:SetRecipeItem(52458, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_YELLOW")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(16624, 17512, 44583, 50480, 50482, 52584, 52588, 52644, 52658)

	-- Fractured Chimera's Eye -- 73409
	recipe = AddRecipe(73409, V.CATA, Q.EPIC)
	recipe:SetSkillLevels(500, 500, 505, 507, 510)
	recipe:SetRecipeItem(52459, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_YELLOW")
	recipe:AddVendor(16624, 17512, 44583, 50480, 50482, 52584, 52588, 52644, 52658)

	-- Fleet Shadowspirit Diamond -- 73464
	recipe = AddRecipe(73464, V.CATA, Q.RARE)
	recipe:SetSkillLevels(490, 490, 515, 520, 525)
	recipe:SetRecipeItem(52433, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_META")
	recipe:AddVendor(16624, 17512, 44583, 50480, 50482, 52584, 52588, 52644, 52658)

	-- Chaotic Shadowspirit Diamond -- 73465
	recipe = AddRecipe(73465, V.CATA, Q.RARE)
	recipe:SetSkillLevels(490, 490, 515, 520, 525)
	recipe:SetRecipeItem(52434, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_META")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(16624, 17512, 44583, 50480, 50482, 52584, 52588, 52644, 52658)

	-- Bracing Shadowspirit Diamond -- 73466
	recipe = AddRecipe(73466, V.CATA, Q.RARE)
	recipe:SetSkillLevels(490, 490, 515, 520, 525)
	recipe:SetRecipeItem(52435, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_META")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(16624, 17512, 44583, 50480, 50482, 52584, 52588, 52644, 52658)

	-- Eternal Shadowspirit Diamond -- 73467
	recipe = AddRecipe(73467, V.CATA, Q.RARE)
	recipe:SetSkillLevels(490, 490, 515, 520, 525)
	recipe:SetRecipeItem(52436, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_META")
	recipe:AddVendor(16624, 17512, 44583, 50480, 50482, 52584, 52588, 52644, 52658)

	-- Austere Shadowspirit Diamond -- 73468
	recipe = AddRecipe(73468, V.CATA, Q.RARE)
	recipe:SetSkillLevels(490, 490, 515, 520, 525)
	recipe:SetRecipeItem(52437, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_META")
	recipe:AddVendor(16624, 17512, 44583, 50480, 50482, 52584, 52588, 52644, 52658)

	-- Effulgent Shadowspirit Diamond -- 73469
	recipe = AddRecipe(73469, V.CATA, Q.RARE)
	recipe:SetSkillLevels(490, 490, 515, 520, 525)
	recipe:SetRecipeItem(52438, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_META")
	recipe:AddVendor(16624, 17512, 44583, 50480, 50482, 52584, 52588, 52644, 52658)

	-- Ember Shadowspirit Diamond -- 73470
	recipe = AddRecipe(73470, V.CATA, Q.RARE)
	recipe:SetSkillLevels(490, 490, 515, 520, 525)
	recipe:SetRecipeItem(52439, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_META")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(16624, 17512, 44583, 50480, 50482, 52584, 52588, 52644, 52658)

	-- Revitalizing Shadowspirit Diamond -- 73471
	recipe = AddRecipe(73471, V.CATA, Q.RARE)
	recipe:SetSkillLevels(490, 490, 515, 520, 525)
	recipe:SetRecipeItem(52440, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_META")
	recipe:AddVendor(16624, 17512, 44583, 50480, 50482, 52584, 52588, 52644, 52658)

	-- Destructive Shadowspirit Diamond -- 73472
	recipe = AddRecipe(73472, V.CATA, Q.RARE)
	recipe:SetSkillLevels(490, 490, 515, 520, 525)
	recipe:SetRecipeItem(52441, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_META")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(16624, 17512, 44583, 50480, 50482, 52584, 52588, 52644, 52658)

	-- Powerful Shadowspirit Diamond -- 73473
	recipe = AddRecipe(73473, V.CATA, Q.RARE)
	recipe:SetSkillLevels(490, 490, 515, 520, 525)
	recipe:SetRecipeItem(52442, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_META")
	recipe:AddVendor(16624, 17512, 44583, 50480, 50482, 52584, 52588, 52644, 52658)

	-- Enigmatic Shadowspirit Diamond -- 73474
	recipe = AddRecipe(73474, V.CATA, Q.RARE)
	recipe:SetSkillLevels(490, 490, 515, 520, 525)
	recipe:SetRecipeItem(52443, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_META")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(16624, 17512, 44583, 50480, 50482, 52584, 52588, 52644, 52658)

	-- Impassive Shadowspirit Diamond -- 73475
	recipe = AddRecipe(73475, V.CATA, Q.RARE)
	recipe:SetSkillLevels(490, 490, 515, 520, 525)
	recipe:SetRecipeItem(52444, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_META")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(16624, 17512, 44583, 50480, 50482, 52584, 52588, 52644, 52658)

	-- Forlorn Shadowspirit Diamond -- 73476
	recipe = AddRecipe(73476, V.CATA, Q.RARE)
	recipe:SetSkillLevels(490, 490, 515, 520, 525)
	recipe:SetRecipeItem(52445, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_META")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(16624, 17512, 44583, 50480, 50482, 52584, 52588, 52644, 52658)

	-- Fire Prism -- 73478
	recipe = AddRecipe(73478, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(52304, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_MATERIALS")
	recipe:AddTrainer(5388, 15501, 18751, 19775, 19778, 44582, 46675, 52586, 52587, 52645, 52657, 93527, 100538)

	-- Jasper Ring -- 73494
	recipe = AddRecipe(73494, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(52306, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddTrainer(5388, 15501, 18751, 19775, 19778, 44582, 46675, 52586, 52587, 52645, 52657, 93527, 100538)

	-- Hessonite Band -- 73495
	recipe = AddRecipe(73495, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(52308, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddTrainer(5388, 15501, 18751, 19775, 19778, 44582, 46675, 52586, 52587, 52645, 52657, 93527, 100538)

	-- Alicite Pendant -- 73496
	recipe = AddRecipe(73496, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(52307, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddTrainer(5388, 15501, 18751, 19775, 19778, 44582, 46675, 52586, 52587, 52645, 52657, 93527, 100538)

	-- Nightstone Choker -- 73497
	recipe = AddRecipe(73497, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(10, 10, 20, 25, 30)
	recipe:SetCraftedItem(52309, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddTrainer(5388, 15501, 18751, 19775, 19778, 44582, 46675, 52586, 52587, 52645, 52657, 93527, 100538)

	-- Band of Blades -- 73498
	recipe = AddRecipe(73498, V.CATA, Q.EPIC)
	recipe:SetSkillLevels(525, 525, 525, 525, 525)
	recipe:SetRecipeItem(52461, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(52318, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(16624, 17512, 44583, 50480, 50482, 52584, 52588, 52644, 52658)

	-- Ring of Warring Elements -- 73502
	recipe = AddRecipe(73502, V.CATA, Q.EPIC)
	recipe:SetSkillLevels(525, 525, 525, 525, 525)
	recipe:SetRecipeItem(52462, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(52319, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(16624, 17512, 44583, 50480, 50482, 52584, 52588, 52644, 52658)

	-- Elementium Moebius Band -- 73503
	recipe = AddRecipe(73503, V.CATA, Q.EPIC)
	recipe:SetSkillLevels(525, 525, 525, 525, 525)
	recipe:SetRecipeItem(52463, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(52320, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddFilters(F.DPS, F.TANK)
	recipe:AddVendor(16624, 17512, 44583, 50480, 50482, 52584, 52588, 52644, 52658)

	-- Entwined Elementium Choker -- 73504
	recipe = AddRecipe(73504, V.CATA, Q.EPIC)
	recipe:SetSkillLevels(525, 525, 525, 525, 525)
	recipe:SetRecipeItem(52465, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(52321, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(16624, 17512, 44583, 50480, 50482, 52584, 52588, 52644, 52658)

	-- Eye of Many Deaths -- 73505
	recipe = AddRecipe(73505, V.CATA, Q.EPIC)
	recipe:SetSkillLevels(525, 525, 525, 525, 525)
	recipe:SetRecipeItem(52466, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(52322, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(16624, 17512, 44583, 50480, 50482, 52584, 52588, 52644, 52658)

	-- Elementium Guardian -- 73506
	recipe = AddRecipe(73506, V.CATA, Q.EPIC)
	recipe:SetSkillLevels(525, 525, 525, 525, 525)
	recipe:SetRecipeItem(52467, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(52323, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.TANK)
	recipe:AddVendor(16624, 17512, 44583, 50480, 50482, 52584, 52588, 52644, 52658)

	-- Elementium Destroyer's Ring -- 73520
	recipe = AddRecipe(73520, V.CATA, Q.EPIC)
	recipe:SetSkillLevels(525, 525, 525, 525, 525)
	recipe:SetRecipeItem(52460, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(52348, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(16624, 17512, 44583, 50480, 50482, 52584, 52588, 52644, 52658)

	-- Brazen Elementium Medallion -- 73521
	recipe = AddRecipe(73521, V.CATA, Q.EPIC)
	recipe:SetSkillLevels(525, 525, 525, 525, 525)
	recipe:SetRecipeItem(52464, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(52350, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(16624, 17512, 44583, 50480, 50482, 52584, 52588, 52644, 52658)

	-- Carnelian Spikes -- 73620
	recipe = AddRecipe(73620, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(10, 10, 20, 25, 30)
	recipe:SetCraftedItem(52492, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_FIST_WEAPON")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(5388, 15501, 18751, 19775, 19778, 44582, 46675, 52586, 52587, 52645, 52657, 93527, 100538)

	-- The Perforator -- 73621
	recipe = AddRecipe(73621, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(40, 40, 50, 55, 60)
	recipe:SetCraftedItem(52493, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_FIST_WEAPON")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(5388, 15501, 18751, 19775, 19778, 44582, 46675, 52586, 52587, 52645, 52657, 93527, 100538)

	-- Stardust -- 73622
	recipe = AddRecipe(73622, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(52490, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_CREATED_ITEM")
	recipe:AddTrainer(5388, 15501, 18751, 19775, 19778, 44582, 46675, 52586, 52587, 52645, 52657, 93527, 100538)

	-- Rhinestone Sunglasses -- 73623
	recipe = AddRecipe(73623, V.CATA, Q.RARE)
	recipe:SetSkillLevels(525, 525, 525, 530, 535)
	recipe:SetRecipeItem(71965, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(52489, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_HEAD")
	recipe:AddMobDrop(50005, 50009, 50056, 50061, 50063, 50089)

	-- Jeweler's Ruby Monocle -- 73625
	recipe = AddRecipe(73625, V.CATA, Q.RARE)
	recipe:SetSkillLevels(450, 450, 480, 490, 500)
	recipe:SetRecipeItem(52494, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(52485, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_HEAD")
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Jeweler's Sapphire Monocle -- 73626
	recipe = AddRecipe(73626, V.CATA, Q.RARE)
	recipe:SetSkillLevels(455, 455, 485, 495, 505)
	recipe:SetRecipeItem(52495, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(52486, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_HEAD")
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Jeweler's Amber Monocle -- 73627
	recipe = AddRecipe(73627, V.CATA, Q.RARE)
	recipe:SetSkillLevels(460, 460, 490, 500, 510)
	recipe:SetRecipeItem(52496, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(52487, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_HEAD")
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Willful Ember Topaz -- 95754
	recipe = AddRecipe(95754, V.CATA, Q.RARE)
	recipe:SetSkillLevels(465, 465, 500, 507, 515)
	recipe:SetRecipeItem(68359, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(16624, 17512, 44583, 50480, 50482, 52584, 52588, 52644, 52658)

	-- Lucent Ember Topaz -- 95755
	recipe = AddRecipe(95755, V.CATA, Q.RARE)
	recipe:SetSkillLevels(465, 465, 500, 507, 515)
	recipe:SetRecipeItem(68360, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.DPS)
	recipe:AddVendor(16624, 17512, 44583, 50480, 50482, 52584, 52588, 52644, 52658)

	-- Resplendent Ember Topaz -- 95756
	recipe = AddRecipe(95756, V.CATA, Q.RARE)
	recipe:SetSkillLevels(465, 465, 500, 507, 515)
	recipe:SetRecipeItem(68361, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.DPS)
	recipe:AddVendor(16624, 17512, 44583, 50480, 50482, 52584, 52588, 52644, 52658)

	-- Vivid Dream Emerald -- 96226
	recipe = AddRecipe(96226, V.CATA, Q.RARE)
	recipe:SetSkillLevels(465, 465, 500, 507, 515)
	recipe:SetRecipeItem(68742, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(68741, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddVendor(16624, 17512, 44583, 50480, 50482, 52584, 52588, 52644, 52658)

	-- Agile Shadowspirit Diamond -- 96255
	recipe = AddRecipe(96255, V.CATA, Q.RARE)
	recipe:SetSkillLevels(490, 490, 515, 520, 525)
	recipe:SetRecipeItem(68781, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(68778, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_META")
	recipe:AddFilters(F.DPS)
	recipe:AddWorldDrop(Z.DEEPHOLM, Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Reverberating Shadowspirit Diamond -- 96256
	recipe = AddRecipe(96256, V.CATA, Q.RARE)
	recipe:SetSkillLevels(490, 490, 515, 520, 525)
	recipe:SetRecipeItem(68782, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(68779, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_META")
	recipe:AddFilters(F.DPS)
	recipe:AddWorldDrop(Z.DEEPHOLM, Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Burning Shadowspirit Diamond -- 96257
	recipe = AddRecipe(96257, V.CATA, Q.RARE)
	recipe:SetSkillLevels(490, 490, 515, 520, 525)
	recipe:SetRecipeItem(68783, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(68780, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_META")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddWorldDrop(Z.DEEPHOLM, Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Punisher's Band -- 98921
	recipe = AddRecipe(98921, V.CATA, Q.EPIC)
	recipe:SetSkillLevels(525, 525, 525, 525, 525)
	recipe:SetRecipeItem(69853, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(69852, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(16624, 17512, 44583, 50480, 50482, 52584, 52588, 52644, 52658)

	-- Vicious Sapphire Ring -- 99539
	recipe = AddRecipe(99539, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(60, 60, 70, 75, 80)
	recipe:SetCraftedItem(75067, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(5388, 15501, 18751, 19775, 19778, 44582, 46675, 52586, 52587, 52645, 52657, 93527, 100538)

	-- Vicious Amberjewel Band -- 99540
	recipe = AddRecipe(99540, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(60, 60, 70, 75, 80)
	recipe:SetCraftedItem(75068, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(5388, 15501, 18751, 19775, 19778, 44582, 46675, 52586, 52587, 52645, 52657, 93527, 100538)

	-- Vicious Ruby Signet -- 99541
	recipe = AddRecipe(99541, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(60, 60, 70, 75, 80)
	recipe:SetCraftedItem(75071, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(5388, 15501, 18751, 19775, 19778, 44582, 46675, 52586, 52587, 52645, 52657, 93527, 100538)

	-- Vicious Sapphire Necklace -- 99542
	recipe = AddRecipe(99542, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(70, 70, 80, 85, 90)
	recipe:SetCraftedItem(75074, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(5388, 15501, 18751, 19775, 19778, 44582, 46675, 52586, 52587, 52645, 52657, 93527, 100538)

	-- Vicious Amberjewel Pendant -- 99543
	recipe = AddRecipe(99543, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(70, 70, 80, 85, 90)
	recipe:SetCraftedItem(75075, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(5388, 15501, 18751, 19775, 19778, 44582, 46675, 52586, 52587, 52645, 52657, 93527, 100538)

	-- Vicious Ruby Choker -- 99544
	recipe = AddRecipe(99544, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(70, 70, 80, 85, 90)
	recipe:SetCraftedItem(75078, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(5388, 15501, 18751, 19775, 19778, 44582, 46675, 52586, 52587, 52645, 52657, 93527, 100538)

	-- Rigid Deepholm Iolite -- 101735
	recipe = AddRecipe(101735, V.CATA, Q.RARE)
	recipe:SetSkillLevels(520, 520, 525, 530, 535)
	recipe:SetRecipeItem(71821, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_BLUE")
	recipe:AddVendor(56925, 57922)

	-- Stormy Deepholm Iolite -- 101740
	recipe = AddRecipe(101740, V.CATA, Q.RARE)
	recipe:SetSkillLevels(520, 520, 525, 530, 535)
	recipe:SetRecipeItem(71884, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_BLUE")
	recipe:AddVendor(56925, 57922)

	-- Sparkling Deepholm Iolite -- 101741
	recipe = AddRecipe(101741, V.CATA, Q.RARE)
	recipe:SetSkillLevels(520, 520, 525, 530, 535)
	recipe:SetRecipeItem(71885, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_BLUE")
	recipe:AddVendor(56925, 57922)

	-- Solid Deepholm Iolite -- 101742
	recipe = AddRecipe(101742, V.CATA, Q.RARE)
	recipe:SetSkillLevels(520, 520, 525, 530, 535)
	recipe:SetRecipeItem(71886, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_BLUE")
	recipe:AddVendor(56925, 57922)

	-- Misty Elven Peridot -- 101743
	recipe = AddRecipe(101743, V.CATA, Q.RARE)
	recipe:SetSkillLevels(520, 520, 525, 530, 535)
	recipe:SetRecipeItem(71887, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddVendor(56925, 57922)

	-- Piercing Elven Peridot -- 101744
	recipe = AddRecipe(101744, V.CATA, Q.RARE)
	recipe:SetSkillLevels(520, 520, 525, 530, 535)
	recipe:SetRecipeItem(71888, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddVendor(56925, 57922)

	-- Lightning Elven Peridot -- 101745
	recipe = AddRecipe(101745, V.CATA, Q.RARE)
	recipe:SetSkillLevels(520, 520, 525, 530, 535)
	recipe:SetRecipeItem(71889, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddVendor(56925, 57922)

	-- Sensei's Elven Peridot -- 101746
	recipe = AddRecipe(101746, V.CATA, Q.RARE)
	recipe:SetSkillLevels(520, 520, 525, 530, 535)
	recipe:SetRecipeItem(71890, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddVendor(56925, 57922)

	-- Infused Elven Peridot -- 101747
	recipe = AddRecipe(101747, V.CATA, Q.RARE)
	recipe:SetSkillLevels(520, 520, 525, 530, 535)
	recipe:SetRecipeItem(71891, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddVendor(56925, 57922)

	-- Zen Elven Peridot -- 101748
	recipe = AddRecipe(101748, V.CATA, Q.RARE)
	recipe:SetSkillLevels(520, 520, 525, 530, 535)
	recipe:SetRecipeItem(71892, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddVendor(56925, 57922)

	-- Balanced Elven Peridot -- 101749
	recipe = AddRecipe(101749, V.CATA, Q.RARE)
	recipe:SetSkillLevels(520, 520, 525, 530, 535)
	recipe:SetRecipeItem(71893, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddVendor(56925, 57922)

	-- Vivid Elven Peridot -- 101750
	recipe = AddRecipe(101750, V.CATA, Q.RARE)
	recipe:SetSkillLevels(520, 520, 525, 530, 535)
	recipe:SetRecipeItem(71894, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddVendor(56925, 57922)

	-- Turbid Elven Peridot -- 101751
	recipe = AddRecipe(101751, V.CATA, Q.RARE)
	recipe:SetSkillLevels(520, 520, 525, 530, 535)
	recipe:SetRecipeItem(71895, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddVendor(56925, 57922)

	-- Radiant Elven Peridot -- 101752
	recipe = AddRecipe(101752, V.CATA, Q.RARE)
	recipe:SetSkillLevels(520, 520, 525, 530, 535)
	recipe:SetRecipeItem(71896, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddVendor(56925, 57922)

	-- Shattered Elven Peridot -- 101753
	recipe = AddRecipe(101753, V.CATA, Q.RARE)
	recipe:SetSkillLevels(520, 520, 525, 530, 535)
	recipe:SetRecipeItem(71897, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddVendor(56925, 57922)

	-- Energized Elven Peridot -- 101754
	recipe = AddRecipe(101754, V.CATA, Q.RARE)
	recipe:SetSkillLevels(520, 520, 525, 530, 535)
	recipe:SetRecipeItem(71898, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddVendor(56925, 57922)

	-- Jagged Elven Peridot -- 101755
	recipe = AddRecipe(101755, V.CATA, Q.RARE)
	recipe:SetSkillLevels(520, 520, 525, 530, 535)
	recipe:SetRecipeItem(71899, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddVendor(56925, 57922)

	-- Regal Elven Peridot -- 101756
	recipe = AddRecipe(101756, V.CATA, Q.RARE)
	recipe:SetSkillLevels(520, 520, 525, 530, 535)
	recipe:SetRecipeItem(71900, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddVendor(56925, 57922)

	-- Forceful Elven Peridot -- 101757
	recipe = AddRecipe(101757, V.CATA, Q.RARE)
	recipe:SetSkillLevels(520, 520, 525, 530, 535)
	recipe:SetRecipeItem(71901, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddVendor(56925, 57922)

	-- Nimble Elven Peridot -- 101758
	recipe = AddRecipe(101758, V.CATA, Q.RARE)
	recipe:SetSkillLevels(520, 520, 525, 530, 535)
	recipe:SetRecipeItem(71902, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddVendor(56925, 57922)

	-- Puissant Elven Peridot -- 101759
	recipe = AddRecipe(101759, V.CATA, Q.RARE)
	recipe:SetSkillLevels(520, 520, 525, 530, 535)
	recipe:SetRecipeItem(71903, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddVendor(56925, 57922)

	-- Steady Elven Peridot -- 101760
	recipe = AddRecipe(101760, V.CATA, Q.RARE)
	recipe:SetSkillLevels(520, 520, 525, 530, 535)
	recipe:SetRecipeItem(71904, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddVendor(56925, 57922)

	-- Deadly Lava Coral -- 101761
	recipe = AddRecipe(101761, V.CATA, Q.RARE)
	recipe:SetSkillLevels(520, 520, 525, 530, 535)
	recipe:SetRecipeItem(71905, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddVendor(56925, 57922)

	-- Crafty Lava Coral -- 101762
	recipe = AddRecipe(101762, V.CATA, Q.RARE)
	recipe:SetSkillLevels(520, 520, 525, 530, 535)
	recipe:SetRecipeItem(71906, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddVendor(56925, 57922)

	-- Potent Lava Coral -- 101763
	recipe = AddRecipe(101763, V.CATA, Q.RARE)
	recipe:SetSkillLevels(520, 520, 525, 530, 535)
	recipe:SetRecipeItem(71907, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddVendor(56925, 57922)

	-- Inscribed Lava Coral -- 101764
	recipe = AddRecipe(101764, V.CATA, Q.RARE)
	recipe:SetSkillLevels(520, 520, 525, 530, 535)
	recipe:SetRecipeItem(71908, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddVendor(56925, 57922)

	-- Polished Lava Coral -- 101765
	recipe = AddRecipe(101765, V.CATA, Q.RARE)
	recipe:SetSkillLevels(520, 520, 525, 530, 535)
	recipe:SetRecipeItem(71909, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddVendor(56925, 57922)

	-- Resolute Lava Coral -- 101766
	recipe = AddRecipe(101766, V.CATA, Q.RARE)
	recipe:SetSkillLevels(520, 520, 525, 530, 535)
	recipe:SetRecipeItem(71910, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddVendor(56925, 57922)

	-- Stalwart Lava Coral -- 101767
	recipe = AddRecipe(101767, V.CATA, Q.RARE)
	recipe:SetSkillLevels(520, 520, 525, 530, 535)
	recipe:SetRecipeItem(71911, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddVendor(56925, 57922)

	-- Champion's Lava Coral -- 101768
	recipe = AddRecipe(101768, V.CATA, Q.RARE)
	recipe:SetSkillLevels(520, 520, 525, 530, 535)
	recipe:SetRecipeItem(71912, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddVendor(56925, 57922)

	-- Deft Lava Coral -- 101769
	recipe = AddRecipe(101769, V.CATA, Q.RARE)
	recipe:SetSkillLevels(520, 520, 525, 530, 535)
	recipe:SetRecipeItem(71913, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddVendor(56925, 57922)

	-- Wicked Lava Coral -- 101770
	recipe = AddRecipe(101770, V.CATA, Q.RARE)
	recipe:SetSkillLevels(520, 520, 525, 530, 535)
	recipe:SetRecipeItem(71914, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddVendor(56925, 57922)

	-- Reckless Lava Coral -- 101771
	recipe = AddRecipe(101771, V.CATA, Q.RARE)
	recipe:SetSkillLevels(520, 520, 525, 530, 535)
	recipe:SetRecipeItem(71915, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddVendor(56925, 57922)

	-- Fierce Lava Coral -- 101772
	recipe = AddRecipe(101772, V.CATA, Q.RARE)
	recipe:SetSkillLevels(520, 520, 525, 530, 535)
	recipe:SetRecipeItem(71916, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddVendor(56925, 57922)

	-- Adept Lava Coral -- 101773
	recipe = AddRecipe(101773, V.CATA, Q.RARE)
	recipe:SetSkillLevels(520, 520, 525, 530, 535)
	recipe:SetRecipeItem(71917, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddVendor(56925, 57922)

	-- Keen Lava Coral -- 101774
	recipe = AddRecipe(101774, V.CATA, Q.RARE)
	recipe:SetSkillLevels(520, 520, 525, 530, 535)
	recipe:SetRecipeItem(71918, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddVendor(56925, 57922)

	-- Artful Lava Coral -- 101775
	recipe = AddRecipe(101775, V.CATA, Q.RARE)
	recipe:SetSkillLevels(520, 520, 525, 530, 535)
	recipe:SetRecipeItem(71919, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddVendor(56925, 57922)

	-- Fine Lava Coral -- 101776
	recipe = AddRecipe(101776, V.CATA, Q.RARE)
	recipe:SetSkillLevels(520, 520, 525, 530, 535)
	recipe:SetRecipeItem(71920, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddVendor(56925, 57922)

	-- Skillful Lava Coral -- 101777
	recipe = AddRecipe(101777, V.CATA, Q.RARE)
	recipe:SetSkillLevels(520, 520, 525, 530, 535)
	recipe:SetRecipeItem(71921, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddVendor(56925, 57922)

	-- Lucent Lava Coral -- 101778
	recipe = AddRecipe(101778, V.CATA, Q.RARE)
	recipe:SetSkillLevels(520, 520, 525, 530, 535)
	recipe:SetRecipeItem(71922, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddVendor(56925, 57922)

	-- Tenuous Lava Coral -- 101779
	recipe = AddRecipe(101779, V.CATA, Q.RARE)
	recipe:SetSkillLevels(520, 520, 525, 530, 535)
	recipe:SetRecipeItem(71923, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddVendor(56925, 57922)

	-- Willful Lava Coral -- 101780
	recipe = AddRecipe(101780, V.CATA, Q.RARE)
	recipe:SetSkillLevels(520, 520, 525, 530, 535)
	recipe:SetRecipeItem(71924, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddVendor(56925, 57922)

	-- Splendid Lava Coral -- 101781
	recipe = AddRecipe(101781, V.CATA, Q.RARE)
	recipe:SetSkillLevels(520, 520, 525, 530, 535)
	recipe:SetRecipeItem(71925, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddVendor(56925, 57922)

	-- Resplendent Lava Coral -- 101782
	recipe = AddRecipe(101782, V.CATA, Q.RARE)
	recipe:SetSkillLevels(520, 520, 525, 530, 535)
	recipe:SetRecipeItem(71926, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddVendor(56925, 57922)

	-- Glinting Shadow Spinel -- 101783
	recipe = AddRecipe(101783, V.CATA, Q.RARE)
	recipe:SetSkillLevels(520, 520, 525, 530, 535)
	recipe:SetRecipeItem(71927, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddVendor(56925, 57922)

	-- Accurate Shadow Spinel -- 101784
	recipe = AddRecipe(101784, V.CATA, Q.RARE)
	recipe:SetSkillLevels(520, 520, 525, 530, 535)
	recipe:SetRecipeItem(71928, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(71863, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(56925, 57922)

	-- Veiled Shadow Spinel -- 101785
	recipe = AddRecipe(101785, V.CATA, Q.RARE)
	recipe:SetSkillLevels(520, 520, 525, 530, 535)
	recipe:SetRecipeItem(71929, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddVendor(56925, 57922)

	-- Retaliating Shadow Spinel -- 101786
	recipe = AddRecipe(101786, V.CATA, Q.RARE)
	recipe:SetSkillLevels(520, 520, 525, 530, 535)
	recipe:SetRecipeItem(71930, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddVendor(56925, 57922)

	-- Etched Shadow Spinel -- 101787
	recipe = AddRecipe(101787, V.CATA, Q.RARE)
	recipe:SetSkillLevels(520, 520, 525, 530, 535)
	recipe:SetRecipeItem(71931, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddVendor(56925, 57922)

	-- Mysterious Shadow Spinel -- 101788
	recipe = AddRecipe(101788, V.CATA, Q.RARE)
	recipe:SetSkillLevels(520, 520, 525, 530, 535)
	recipe:SetRecipeItem(71932, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddVendor(56925, 57922)

	-- Purified Shadow Spinel -- 101789
	recipe = AddRecipe(101789, V.CATA, Q.RARE)
	recipe:SetSkillLevels(520, 520, 525, 530, 535)
	recipe:SetRecipeItem(71933, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddVendor(56925, 57922)

	-- Shifting Shadow Spinel -- 101790
	recipe = AddRecipe(101790, V.CATA, Q.RARE)
	recipe:SetSkillLevels(520, 520, 525, 530, 535)
	recipe:SetRecipeItem(71934, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddVendor(56925, 57922)

	-- Guardian's Shadow Spinel -- 101791
	recipe = AddRecipe(101791, V.CATA, Q.RARE)
	recipe:SetSkillLevels(520, 520, 525, 530, 535)
	recipe:SetRecipeItem(71935, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddVendor(56925, 57922)

	-- Timeless Shadow Spinel -- 101792
	recipe = AddRecipe(101792, V.CATA, Q.RARE)
	recipe:SetSkillLevels(520, 520, 525, 530, 535)
	recipe:SetRecipeItem(71936, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddVendor(56925, 57922)

	-- Defender's Shadow Spinel -- 101793
	recipe = AddRecipe(101793, V.CATA, Q.RARE)
	recipe:SetSkillLevels(520, 520, 525, 530, 535)
	recipe:SetRecipeItem(71937, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddVendor(56925, 57922)

	-- Sovereign Shadow Spinel -- 101794
	recipe = AddRecipe(101794, V.CATA, Q.RARE)
	recipe:SetSkillLevels(520, 520, 525, 530, 535)
	recipe:SetRecipeItem(71938, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddVendor(56925, 57922)

	-- Delicate Queen's Garnet -- 101795
	recipe = AddRecipe(101795, V.CATA, Q.RARE)
	recipe:SetSkillLevels(520, 520, 525, 530, 535)
	recipe:SetRecipeItem(71939, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_RED")
	recipe:AddVendor(56925, 57922)

	-- Precise Queen's Garnet -- 101796
	recipe = AddRecipe(101796, V.CATA, Q.RARE)
	recipe:SetSkillLevels(520, 520, 525, 530, 535)
	recipe:SetRecipeItem(71940, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_RED")
	recipe:AddVendor(56925, 57922)

	-- Brilliant Queen's Garnet -- 101797
	recipe = AddRecipe(101797, V.CATA, Q.RARE)
	recipe:SetSkillLevels(520, 520, 525, 530, 535)
	recipe:SetRecipeItem(71941, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_RED")
	recipe:AddVendor(56925, 57922)

	-- Flashing Queen's Garnet -- 101798
	recipe = AddRecipe(101798, V.CATA, Q.RARE)
	recipe:SetSkillLevels(520, 520, 525, 530, 535)
	recipe:SetRecipeItem(71942, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_RED")
	recipe:AddVendor(56925, 57922)

	-- Bold Queen's Garnet -- 101799
	recipe = AddRecipe(101799, V.CATA, Q.RARE)
	recipe:SetSkillLevels(520, 520, 525, 530, 535)
	recipe:SetRecipeItem(71943, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_RED")
	recipe:AddVendor(56925, 57922)

	-- Smooth Lightstone -- 101800
	recipe = AddRecipe(101800, V.CATA, Q.RARE)
	recipe:SetSkillLevels(520, 520, 525, 530, 535)
	recipe:SetRecipeItem(71944, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_YELLOW")
	recipe:AddVendor(56925, 57922)

	-- Subtle Lightstone -- 101801
	recipe = AddRecipe(101801, V.CATA, Q.RARE)
	recipe:SetSkillLevels(520, 520, 525, 530, 535)
	recipe:SetRecipeItem(71945, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_YELLOW")
	recipe:AddVendor(56925, 57922)

	-- Quick Lightstone -- 101802
	recipe = AddRecipe(101802, V.CATA, Q.RARE)
	recipe:SetSkillLevels(520, 520, 525, 530, 535)
	recipe:SetRecipeItem(71946, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_YELLOW")
	recipe:AddVendor(56925, 57922)

	-- Fractured Lightstone -- 101803
	recipe = AddRecipe(101803, V.CATA, Q.RARE)
	recipe:SetSkillLevels(520, 520, 525, 530, 535)
	recipe:SetRecipeItem(71947, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_YELLOW")
	recipe:AddVendor(56925, 57922)

	-- Mystic Lightstone -- 101804
	recipe = AddRecipe(101804, V.CATA, Q.RARE)
	recipe:SetSkillLevels(520, 520, 525, 530, 535)
	recipe:SetRecipeItem(71948, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_YELLOW")
	recipe:AddVendor(56925, 57922)

	-- ----------------------------------------------------------------------------
	-- Mists of Pandaria.
	-- ----------------------------------------------------------------------------
	-- Rigid River's Heart -- 106947
	recipe = AddRecipe(106947, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(550, 550, 600, 602, 605)
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_BLUE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddDiscovery("DISCOVERY_JC_PANDARIA")

	-- Stormy River's Heart -- 106948
	recipe = AddRecipe(106948, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(550, 550, 600, 602, 605)
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_BLUE")
	recipe:AddDiscovery("DISCOVERY_JC_PANDARIA")

	-- Sparkling River's Heart -- 106949
	recipe = AddRecipe(106949, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(550, 550, 600, 602, 605)
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_BLUE")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddDiscovery("DISCOVERY_JC_PANDARIA")

	-- Solid River's Heart -- 106950
	recipe = AddRecipe(106950, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(550, 550, 600, 602, 605)
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_BLUE")
	recipe:AddDiscovery("DISCOVERY_JC_PANDARIA")

	-- Misty Wild Jade -- 106953
	recipe = AddRecipe(106953, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(550, 550, 600, 602, 605)
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddDiscovery("DISCOVERY_JC_PANDARIA")

	-- Piercing Wild Jade -- 106954
	recipe = AddRecipe(106954, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(550, 550, 600, 602, 605)
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddDiscovery("DISCOVERY_JC_PANDARIA")

	-- Lightning Wild Jade -- 106955
	recipe = AddRecipe(106955, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(550, 550, 600, 602, 605)
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddDiscovery("DISCOVERY_JC_PANDARIA")

	-- Sensei's Wild Jade -- 106956
	recipe = AddRecipe(106956, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(550, 550, 600, 602, 605)
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddDiscovery("DISCOVERY_JC_PANDARIA")

	-- Effulgent Wild Jade -- 106957
	recipe = AddRecipe(106957, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(550, 550, 600, 602, 605)
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddDiscovery("DISCOVERY_JC_PANDARIA")

	-- Zen Wild Jade -- 106958
	recipe = AddRecipe(106958, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(550, 550, 600, 602, 605)
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddDiscovery("DISCOVERY_JC_PANDARIA")

	-- Balanced Wild Jade -- 106960
	recipe = AddRecipe(106960, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(550, 550, 600, 602, 605)
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddDiscovery("DISCOVERY_JC_PANDARIA")

	-- Vivid Wild Jade -- 106961
	recipe = AddRecipe(106961, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(550, 550, 600, 602, 605)
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddDiscovery("DISCOVERY_JC_PANDARIA")

	-- Turbid Wild Jade -- 106962
	recipe = AddRecipe(106962, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(550, 550, 600, 602, 605)
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddDiscovery("DISCOVERY_JC_PANDARIA")

	-- Balanced Alexandrite -- 107598
	recipe = AddRecipe(107598, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(76513, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(15501, 18751, 19775, 46675, 65098, 93527, 100538)

	-- Effulgent Alexandrite -- 107599
	recipe = AddRecipe(107599, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(76511, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddTrainer(15501, 18751, 19775, 46675, 65098, 93527, 100538)

	-- Energized Alexandrite -- 107600
	recipe = AddRecipe(107600, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(35, 35, 45, 50, 55)
	recipe:SetCraftedItem(76519, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(15501, 18751, 19775, 46675, 65098, 93527, 100538)

	-- Forceful Alexandrite -- 107601
	recipe = AddRecipe(107601, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(40, 40, 50, 55, 60)
	recipe:SetCraftedItem(76522, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(15501, 18751, 19775, 46675, 65098, 93527, 100538)

	-- Jagged Alexandrite -- 107602
	recipe = AddRecipe(107602, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(5, 5, 15, 20, 25)
	recipe:SetCraftedItem(76520, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(15501, 18751, 19775, 46675, 65098, 93527, 100538)

	-- Lightning Alexandrite -- 107604
	recipe = AddRecipe(107604, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(76509, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(15501, 18751, 19775, 46675, 65098, 93527, 100538)

	-- Misty Alexandrite -- 107605
	recipe = AddRecipe(107605, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(15, 15, 25, 30, 35)
	recipe:SetCraftedItem(76507, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(15501, 18751, 19775, 46675, 65098, 93527, 100538)

	-- Nimble Alexandrite -- 107606
	recipe = AddRecipe(107606, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(5, 5, 15, 20, 25)
	recipe:SetCraftedItem(93706, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.TANK)
	recipe:AddTrainer(15501, 18751, 19775, 46675, 65098, 93527, 100538)

	-- Piercing Alexandrite -- 107607
	recipe = AddRecipe(107607, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(30, 30, 40, 45, 50)
	recipe:SetCraftedItem(76508, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(15501, 18751, 19775, 46675, 65098, 93527, 100538)

	-- Puissant Alexandrite -- 107608
	recipe = AddRecipe(107608, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(45, 45, 55, 60, 65)
	recipe:SetCraftedItem(76524, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddTrainer(15501, 18751, 19775, 46675, 65098, 93527, 100538)

	-- Radiant Alexandrite -- 107609
	recipe = AddRecipe(107609, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(76517, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(15501, 18751, 19775, 46675, 65098, 93527, 100538)

	-- Regal Alexandrite -- 107610
	recipe = AddRecipe(107610, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(10, 10, 20, 25, 30)
	recipe:SetCraftedItem(76521, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddFilters(F.TANK)
	recipe:AddTrainer(15501, 18751, 19775, 46675, 65098, 93527, 100538)

	-- Sensei's Alexandrite -- 107611
	recipe = AddRecipe(107611, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(20, 20, 30, 35, 40)
	recipe:SetCraftedItem(76510, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(15501, 18751, 19775, 46675, 65098, 93527, 100538)

	-- Shattered Alexandrite -- 107612
	recipe = AddRecipe(107612, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(15, 15, 25, 30, 35)
	recipe:SetCraftedItem(76518, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(15501, 18751, 19775, 46675, 65098, 93527, 100538)

	-- Steady Alexandrite -- 107613
	recipe = AddRecipe(107613, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(30, 30, 40, 45, 50)
	recipe:SetCraftedItem(76525, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddTrainer(15501, 18751, 19775, 46675, 65098, 93527, 100538)

	-- Turbid Alexandrite -- 107614
	recipe = AddRecipe(107614, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(20, 20, 30, 35, 40)
	recipe:SetCraftedItem(76515, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(15501, 18751, 19775, 46675, 65098, 93527, 100538)

	-- Vivid Alexandrite -- 107615
	recipe = AddRecipe(107615, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(76514, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddTrainer(15501, 18751, 19775, 46675, 65098, 93527, 100538)

	-- Zen Alexandrite -- 107616
	recipe = AddRecipe(107616, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(10, 10, 20, 25, 30)
	recipe:SetCraftedItem(76512, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(15501, 18751, 19775, 46675, 65098, 93527, 100538)

	-- Rigid Lapis Lazuli -- 107617
	recipe = AddRecipe(107617, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(76502, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_BLUE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(15501, 18751, 19775, 46675, 65098, 93527, 100538)

	-- Solid Lapis Lazuli -- 107619
	recipe = AddRecipe(107619, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(10, 10, 20, 25, 30)
	recipe:SetCraftedItem(76506, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_BLUE")
	recipe:AddTrainer(15501, 18751, 19775, 46675, 65098, 93527, 100538)

	-- Sparkling Lapis Lazuli -- 107620
	recipe = AddRecipe(107620, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(20, 20, 30, 35, 40)
	recipe:SetCraftedItem(76505, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_BLUE")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(15501, 18751, 19775, 46675, 65098, 93527, 100538)

	-- Stormy Lapis Lazuli -- 107621
	recipe = AddRecipe(107621, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(30, 30, 40, 45, 50)
	recipe:SetCraftedItem(76504, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_BLUE")
	recipe:AddTrainer(15501, 18751, 19775, 46675, 65098, 93527, 100538)

	-- Bold Pandarian Garnet -- 107622
	recipe = AddRecipe(107622, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(45, 45, 55, 60, 65)
	recipe:SetCraftedItem(76564, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_RED")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(15501, 18751, 19775, 46675, 65098, 93527, 100538)

	-- Brilliant Pandarian Garnet -- 107623
	recipe = AddRecipe(107623, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(35, 35, 45, 50, 55)
	recipe:SetCraftedItem(76562, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_RED")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(15501, 18751, 19775, 46675, 65098, 93527, 100538)

	-- Delicate Pandarian Garnet -- 107624
	recipe = AddRecipe(107624, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(5, 5, 15, 20, 25)
	recipe:SetCraftedItem(76560, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_RED")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(15501, 18751, 19775, 46675, 65098, 93527, 100538)

	-- Flashing Pandarian Garnet -- 107625
	recipe = AddRecipe(107625, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(76563, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_RED")
	recipe:AddFilters(F.TANK)
	recipe:AddTrainer(15501, 18751, 19775, 46675, 65098, 93527, 100538)

	-- Precise Pandarian Garnet -- 107626
	recipe = AddRecipe(107626, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(15, 15, 25, 30, 35)
	recipe:SetCraftedItem(76561, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_RED")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(15501, 18751, 19775, 46675, 65098, 93527, 100538)

	-- Accurate Roguestone -- 107627
	recipe = AddRecipe(107627, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(76549, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(15501, 18751, 19775, 46675, 65098, 93527, 100538)

	-- Defender's Roguestone -- 107628
	recipe = AddRecipe(107628, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(30, 30, 40, 45, 50)
	recipe:SetCraftedItem(76558, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.TANK)
	recipe:AddTrainer(15501, 18751, 19775, 46675, 65098, 93527, 100538)

	-- Etched Roguestone -- 107630
	recipe = AddRecipe(107630, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(76552, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(15501, 18751, 19775, 46675, 65098, 93527, 100538)

	-- Glinting Roguestone -- 107631
	recipe = AddRecipe(107631, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(15, 15, 25, 30, 35)
	recipe:SetCraftedItem(76548, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(15501, 18751, 19775, 46675, 65098, 93527, 100538)

	-- Guardian's Roguestone -- 107632
	recipe = AddRecipe(107632, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(20, 20, 30, 35, 40)
	recipe:SetCraftedItem(76556, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(15501, 18751, 19775, 46675, 65098, 93527, 100538)

	-- Mysterious Roguestone -- 107633
	recipe = AddRecipe(107633, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(76553, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(15501, 18751, 19775, 46675, 65098, 93527, 100538)

	-- Purified Roguestone -- 107634
	recipe = AddRecipe(107634, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(40, 40, 50, 55, 60)
	recipe:SetCraftedItem(76554, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(15501, 18751, 19775, 46675, 65098, 93527, 100538)

	-- Retaliating Roguestone -- 107635
	recipe = AddRecipe(107635, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(76551, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.TANK)
	recipe:AddTrainer(15501, 18751, 19775, 46675, 65098, 93527, 100538)

	-- Shifting Roguestone -- 107636
	recipe = AddRecipe(107636, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(10, 10, 20, 25, 30)
	recipe:SetCraftedItem(76555, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(15501, 18751, 19775, 46675, 65098, 93527, 100538)

	-- Sovereign Roguestone -- 107637
	recipe = AddRecipe(107637, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(10, 10, 20, 25, 30)
	recipe:SetCraftedItem(76559, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(15501, 18751, 19775, 46675, 65098, 93527, 100538)

	-- Timeless Roguestone -- 107638
	recipe = AddRecipe(107638, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(35, 35, 45, 50, 55)
	recipe:SetCraftedItem(76557, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(15501, 18751, 19775, 46675, 65098, 93527, 100538)

	-- Veiled Roguestone -- 107639
	recipe = AddRecipe(107639, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(5, 5, 15, 20, 25)
	recipe:SetCraftedItem(76550, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(15501, 18751, 19775, 46675, 65098, 93527, 100538)

	-- Fractured Sunstone -- 107640
	recipe = AddRecipe(107640, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(10, 10, 20, 25, 30)
	recipe:SetCraftedItem(76568, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_YELLOW")
	recipe:AddTrainer(15501, 18751, 19775, 46675, 65098, 93527, 100538)

	-- Mystic Sunstone -- 107641
	recipe = AddRecipe(107641, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(20, 20, 30, 35, 40)
	recipe:SetCraftedItem(76569, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_YELLOW")
	recipe:AddTrainer(15501, 18751, 19775, 46675, 65098, 93527, 100538)

	-- Quick Sunstone -- 107642
	recipe = AddRecipe(107642, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(30, 30, 40, 45, 50)
	recipe:SetCraftedItem(76567, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_YELLOW")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(15501, 18751, 19775, 46675, 65098, 93527, 100538)

	-- Smooth Sunstone -- 107643
	recipe = AddRecipe(107643, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(40, 40, 50, 55, 60)
	recipe:SetCraftedItem(76565, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_YELLOW")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(15501, 18751, 19775, 46675, 65098, 93527, 100538)

	-- Subtle Sunstone -- 107644
	recipe = AddRecipe(107644, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(76566, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_YELLOW")
	recipe:AddFilters(F.TANK)
	recipe:AddTrainer(15501, 18751, 19775, 46675, 65098, 93527, 100538)

	-- Adept Tiger Opal -- 107645
	recipe = AddRecipe(107645, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(76538, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(15501, 18751, 19775, 46675, 65098, 93527, 100538)

	-- Artful Tiger Opal -- 107646
	recipe = AddRecipe(107646, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(76540, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(15501, 18751, 19775, 46675, 65098, 93527, 100538)

	-- Champion's Tiger Opal -- 107647
	recipe = AddRecipe(107647, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(20, 20, 30, 35, 40)
	recipe:SetCraftedItem(76533, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.DPS, F.TANK)
	recipe:AddTrainer(15501, 18751, 19775, 46675, 65098, 93527, 100538)

	-- Crafty Tiger Opal -- 107648
	recipe = AddRecipe(107648, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(40, 40, 50, 55, 60)
	recipe:SetCraftedItem(76527, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(15501, 18751, 19775, 46675, 65098, 93527, 100538)

	-- Deadly Tiger Opal -- 107649
	recipe = AddRecipe(107649, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(76526, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(15501, 18751, 19775, 46675, 65098, 93527, 100538)

	-- Deft Tiger Opal -- 107650
	recipe = AddRecipe(107650, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(5, 5, 15, 20, 25)
	recipe:SetCraftedItem(76534, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(15501, 18751, 19775, 46675, 65098, 93527, 100538)

	-- Fierce Tiger Opal -- 107651
	recipe = AddRecipe(107651, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(30, 30, 40, 45, 50)
	recipe:SetCraftedItem(76537, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(15501, 18751, 19775, 46675, 65098, 93527, 100538)

	-- Fine Tiger Opal -- 107652
	recipe = AddRecipe(107652, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(10, 10, 20, 25, 30)
	recipe:SetCraftedItem(76541, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.TANK)
	recipe:AddTrainer(15501, 18751, 19775, 46675, 65098, 93527, 100538)

	-- Inscribed Tiger Opal -- 107653
	recipe = AddRecipe(107653, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(30, 30, 40, 45, 50)
	recipe:SetCraftedItem(76529, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(15501, 18751, 19775, 46675, 65098, 93527, 100538)

	-- Keen Tiger Opal -- 107654
	recipe = AddRecipe(107654, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(5, 5, 15, 20, 25)
	recipe:SetCraftedItem(76539, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(15501, 18751, 19775, 46675, 65098, 93527, 100538)

	-- Lucent Tiger Opal -- 107655
	recipe = AddRecipe(107655, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(15, 15, 25, 30, 35)
	recipe:SetCraftedItem(76543, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(15501, 18751, 19775, 46675, 65098, 93527, 100538)

	-- Polished Tiger Opal -- 107656
	recipe = AddRecipe(107656, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(20, 20, 30, 35, 40)
	recipe:SetCraftedItem(76530, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.DPS, F.TANK)
	recipe:AddTrainer(15501, 18751, 19775, 46675, 65098, 93527, 100538)

	-- Potent Tiger Opal -- 107657
	recipe = AddRecipe(107657, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(35, 35, 45, 50, 55)
	recipe:SetCraftedItem(76528, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(15501, 18751, 19775, 46675, 65098, 93527, 100538)

	-- Reckless Tiger Opal -- 107658
	recipe = AddRecipe(107658, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(15, 15, 25, 30, 35)
	recipe:SetCraftedItem(76536, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(15501, 18751, 19775, 46675, 65098, 93527, 100538)

	-- Resolute Tiger Opal -- 107659
	recipe = AddRecipe(107659, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(76531, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.TANK)
	recipe:AddTrainer(15501, 18751, 19775, 46675, 65098, 93527, 100538)

	-- Resplendent Tiger Opal -- 107660
	recipe = AddRecipe(107660, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(76547, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(15501, 18751, 19775, 46675, 65098, 93527, 100538)

	-- Skillful Tiger Opal -- 107661
	recipe = AddRecipe(107661, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(35, 35, 45, 50, 55)
	recipe:SetCraftedItem(76542, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(15501, 18751, 19775, 46675, 65098, 93527, 100538)

	-- Splendid Tiger Opal -- 107662
	recipe = AddRecipe(107662, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(45, 45, 55, 60, 65)
	recipe:SetCraftedItem(76546, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.TANK)
	recipe:AddTrainer(15501, 18751, 19775, 46675, 65098, 93527, 100538)

	-- Stalwart Tiger Opal -- 107663
	recipe = AddRecipe(107663, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(40, 40, 50, 55, 60)
	recipe:SetCraftedItem(76532, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.TANK)
	recipe:AddTrainer(15501, 18751, 19775, 46675, 65098, 93527, 100538)

	-- Tenuous Tiger Opal -- 107665
	recipe = AddRecipe(107665, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(76544, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(15501, 18751, 19775, 46675, 65098, 93527, 100538)

	-- Wicked Tiger Opal -- 107666
	recipe = AddRecipe(107666, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(45, 45, 55, 60, 65)
	recipe:SetCraftedItem(76535, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(15501, 18751, 19775, 46675, 65098, 93527, 100538)

	-- Willful Tiger Opal -- 107667
	recipe = AddRecipe(107667, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(10, 10, 20, 25, 30)
	recipe:SetCraftedItem(76545, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(15501, 18751, 19775, 46675, 65098, 93527, 100538)

	-- Accurate Imperial Amethyst -- 107693
	recipe = AddRecipe(107693, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(550, 550, 600, 602, 605)
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddDiscovery("DISCOVERY_JC_PANDARIA")

	-- Defender's Imperial Amethyst -- 107694
	recipe = AddRecipe(107694, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(550, 550, 600, 602, 605)
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.TANK)
	recipe:AddDiscovery("DISCOVERY_JC_PANDARIA")

	-- Etched Imperial Amethyst -- 107695
	recipe = AddRecipe(107695, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(550, 550, 600, 602, 605)
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddDiscovery("DISCOVERY_JC_PANDARIA")

	-- Glinting Imperial Amethyst -- 107696
	recipe = AddRecipe(107696, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(550, 550, 600, 602, 605)
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddDiscovery("DISCOVERY_JC_PANDARIA")

	-- Guardian's Imperial Amethyst -- 107697
	recipe = AddRecipe(107697, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(550, 550, 600, 602, 605)
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddDiscovery("DISCOVERY_JC_PANDARIA")

	-- Mysterious Imperial Amethyst -- 107698
	recipe = AddRecipe(107698, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(550, 550, 600, 602, 605)
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddDiscovery("DISCOVERY_JC_PANDARIA")

	-- Purified Imperial Amethyst -- 107699
	recipe = AddRecipe(107699, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(550, 550, 600, 602, 605)
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddDiscovery("DISCOVERY_JC_PANDARIA")

	-- Retaliating Imperial Amethyst -- 107700
	recipe = AddRecipe(107700, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(550, 550, 600, 602, 605)
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.TANK)
	recipe:AddDiscovery("DISCOVERY_JC_PANDARIA")

	-- Shifting Imperial Amethyst -- 107701
	recipe = AddRecipe(107701, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(550, 550, 600, 602, 605)
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.DPS)
	recipe:AddDiscovery("DISCOVERY_JC_PANDARIA")

	-- Sovereign Imperial Amethyst -- 107702
	recipe = AddRecipe(107702, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(550, 550, 600, 602, 605)
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.DPS)
	recipe:AddDiscovery("DISCOVERY_JC_PANDARIA")

	-- Timeless Imperial Amethyst -- 107703
	recipe = AddRecipe(107703, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(550, 550, 600, 602, 605)
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddDiscovery("DISCOVERY_JC_PANDARIA")

	-- Veiled Imperial Amethyst -- 107704
	recipe = AddRecipe(107704, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(550, 550, 600, 602, 605)
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddDiscovery("DISCOVERY_JC_PANDARIA")

	-- Bold Primordial Ruby -- 107705
	recipe = AddRecipe(107705, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(550, 550, 600, 602, 605)
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_RED")
	recipe:AddFilters(F.DPS)
	recipe:AddDiscovery("DISCOVERY_JC_PANDARIA")

	-- Brilliant Primordial Ruby -- 107706
	recipe = AddRecipe(107706, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(550, 550, 600, 602, 605)
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_RED")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddDiscovery("DISCOVERY_JC_PANDARIA")

	-- Delicate Primordial Ruby -- 107707
	recipe = AddRecipe(107707, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(550, 550, 600, 602, 605)
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_RED")
	recipe:AddFilters(F.DPS)
	recipe:AddDiscovery("DISCOVERY_JC_PANDARIA")

	-- Flashing Primordial Ruby -- 107708
	recipe = AddRecipe(107708, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(550, 550, 600, 602, 605)
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_RED")
	recipe:AddFilters(F.TANK)
	recipe:AddDiscovery("DISCOVERY_JC_PANDARIA")

	-- Precise Primordial Ruby -- 107709
	recipe = AddRecipe(107709, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(550, 550, 600, 602, 605)
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_RED")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddDiscovery("DISCOVERY_JC_PANDARIA")

	-- Fractured Sun's Radiance -- 107710
	recipe = AddRecipe(107710, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(550, 550, 600, 602, 605)
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_YELLOW")
	recipe:AddDiscovery("DISCOVERY_JC_PANDARIA")

	-- Mystic Sun's Radiance -- 107711
	recipe = AddRecipe(107711, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(550, 550, 600, 602, 605)
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_YELLOW")
	recipe:AddDiscovery("DISCOVERY_JC_PANDARIA")

	-- Quick Sun's Radiance -- 107712
	recipe = AddRecipe(107712, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(550, 550, 600, 602, 605)
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_YELLOW")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddDiscovery("DISCOVERY_JC_PANDARIA")

	-- Smooth Sun's Radiance -- 107713
	recipe = AddRecipe(107713, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(550, 550, 600, 602, 605)
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_YELLOW")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddDiscovery("DISCOVERY_JC_PANDARIA")

	-- Subtle Sun's Radiance -- 107714
	recipe = AddRecipe(107714, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(550, 550, 600, 602, 605)
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_YELLOW")
	recipe:AddFilters(F.TANK)
	recipe:AddDiscovery("DISCOVERY_JC_PANDARIA")

	-- Adept Vermilion Onyx -- 107715
	recipe = AddRecipe(107715, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(550, 550, 600, 602, 605)
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.DPS)
	recipe:AddDiscovery("DISCOVERY_JC_PANDARIA")

	-- Artful Vermilion Onyx -- 107716
	recipe = AddRecipe(107716, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(550, 550, 600, 602, 605)
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddDiscovery("DISCOVERY_JC_PANDARIA")

	-- Champion's Vermilion Onyx -- 107717
	recipe = AddRecipe(107717, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(550, 550, 600, 602, 605)
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.DPS, F.TANK)
	recipe:AddDiscovery("DISCOVERY_JC_PANDARIA")

	-- Crafty Vermilion Onyx -- 107718
	recipe = AddRecipe(107718, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(550, 550, 600, 602, 605)
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddDiscovery("DISCOVERY_JC_PANDARIA")

	-- Deadly Vermilion Onyx -- 107719
	recipe = AddRecipe(107719, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(550, 550, 600, 602, 605)
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddDiscovery("DISCOVERY_JC_PANDARIA")

	-- Deft Vermilion Onyx -- 107720
	recipe = AddRecipe(107720, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(550, 550, 600, 602, 605)
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddDiscovery("DISCOVERY_JC_PANDARIA")

	-- Fierce Vermilion Onyx -- 107721
	recipe = AddRecipe(107721, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(550, 550, 600, 602, 605)
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddDiscovery("DISCOVERY_JC_PANDARIA")

	-- Fine Vermilion Onyx -- 107722
	recipe = AddRecipe(107722, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(550, 550, 600, 602, 605)
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.TANK)
	recipe:AddDiscovery("DISCOVERY_JC_PANDARIA")

	-- Inscribed Vermilion Onyx -- 107723
	recipe = AddRecipe(107723, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(550, 550, 600, 602, 605)
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddDiscovery("DISCOVERY_JC_PANDARIA")

	-- Keen Vermilion Onyx -- 107724
	recipe = AddRecipe(107724, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(550, 550, 600, 602, 605)
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddDiscovery("DISCOVERY_JC_PANDARIA")

	-- Lucent Vermilion Onyx -- 107725
	recipe = AddRecipe(107725, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(550, 550, 600, 602, 605)
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.DPS)
	recipe:AddDiscovery("DISCOVERY_JC_PANDARIA")

	-- Polished Vermilion Onyx -- 107726
	recipe = AddRecipe(107726, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(550, 550, 600, 602, 605)
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.DPS, F.TANK)
	recipe:AddDiscovery("DISCOVERY_JC_PANDARIA")

	-- Potent Vermilion Onyx -- 107727
	recipe = AddRecipe(107727, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(550, 550, 600, 602, 605)
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddDiscovery("DISCOVERY_JC_PANDARIA")

	-- Reckless Vermilion Onyx -- 107728
	recipe = AddRecipe(107728, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(550, 550, 600, 602, 605)
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddDiscovery("DISCOVERY_JC_PANDARIA")

	-- Resolute Vermilion Onyx -- 107729
	recipe = AddRecipe(107729, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(550, 550, 600, 602, 605)
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.TANK)
	recipe:AddDiscovery("DISCOVERY_JC_PANDARIA")

	-- Resplendent Vermilion Onyx -- 107730
	recipe = AddRecipe(107730, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(550, 550, 600, 602, 605)
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.DPS)
	recipe:AddDiscovery("DISCOVERY_JC_PANDARIA")

	-- Skillful Vermilion Onyx -- 107731
	recipe = AddRecipe(107731, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(550, 550, 600, 602, 605)
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.DPS)
	recipe:AddDiscovery("DISCOVERY_JC_PANDARIA")

	-- Splendid Vermilion Onyx -- 107732
	recipe = AddRecipe(107732, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(550, 550, 600, 602, 605)
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.TANK)
	recipe:AddDiscovery("DISCOVERY_JC_PANDARIA")

	-- Stalwart Vermilion Onyx -- 107733
	recipe = AddRecipe(107733, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(550, 550, 600, 602, 605)
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.TANK)
	recipe:AddDiscovery("DISCOVERY_JC_PANDARIA")

	-- Tenuous Vermilion Onyx -- 107734
	recipe = AddRecipe(107734, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(550, 550, 600, 602, 605)
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddDiscovery("DISCOVERY_JC_PANDARIA")

	-- Wicked Vermilion Onyx -- 107735
	recipe = AddRecipe(107735, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(550, 550, 600, 602, 605)
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddDiscovery("DISCOVERY_JC_PANDARIA")

	-- Willful Vermilion Onyx -- 107736
	recipe = AddRecipe(107736, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(550, 550, 600, 602, 605)
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddDiscovery("DISCOVERY_JC_PANDARIA")

	-- Energized Wild Jade -- 107737
	recipe = AddRecipe(107737, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(550, 550, 600, 602, 605)
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddDiscovery("DISCOVERY_JC_PANDARIA")

	-- Forceful Wild Jade -- 107738
	recipe = AddRecipe(107738, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(550, 550, 600, 602, 605)
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddDiscovery("DISCOVERY_JC_PANDARIA")

	-- Jagged Wild Jade -- 107739
	recipe = AddRecipe(107739, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(550, 550, 600, 602, 605)
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddDiscovery("DISCOVERY_JC_PANDARIA")

	-- Nimble Wild Jade -- 107740
	recipe = AddRecipe(107740, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(550, 550, 600, 602, 605)
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.TANK)
	recipe:AddDiscovery("DISCOVERY_JC_PANDARIA")

	-- Puissant Wild Jade -- 107742
	recipe = AddRecipe(107742, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(550, 550, 600, 602, 605)
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddDiscovery("DISCOVERY_JC_PANDARIA")

	-- Radiant Wild Jade -- 107743
	recipe = AddRecipe(107743, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(550, 550, 600, 602, 605)
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddDiscovery("DISCOVERY_JC_PANDARIA")

	-- Regal Wild Jade -- 107744
	recipe = AddRecipe(107744, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(550, 550, 600, 602, 605)
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddFilters(F.TANK)
	recipe:AddDiscovery("DISCOVERY_JC_PANDARIA")

	-- Shattered Wild Jade -- 107745
	recipe = AddRecipe(107745, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(550, 550, 600, 602, 605)
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddDiscovery("DISCOVERY_JC_PANDARIA")

	-- Steady Wild Jade -- 107746
	recipe = AddRecipe(107746, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(550, 550, 600, 602, 605)
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddDiscovery("DISCOVERY_JC_PANDARIA")

	-- Agile Primal Diamond -- 107753
	recipe = AddRecipe(107753, V.MOP, Q.RARE)
	recipe:SetSkillLevels(575, 575, 600, 602, 605)
	recipe:SetRecipeItem(83811, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_META")
	recipe:AddFilters(F.DPS)
	recipe:AddWorldDrop(Z.PANDARIA)

	-- Austere Primal Diamond -- 107754
	recipe = AddRecipe(107754, V.MOP, Q.RARE)
	recipe:SetSkillLevels(575, 575, 600, 602, 605)
	recipe:SetRecipeItem(83815, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_META")
	recipe:AddWorldDrop(Z.PANDARIA)

	-- Burning Primal Diamond -- 107756
	recipe = AddRecipe(107756, V.MOP, Q.RARE)
	recipe:SetSkillLevels(575, 575, 600, 602, 605)
	recipe:SetRecipeItem(83825, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_META")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddWorldDrop(Z.PANDARIA)

	-- Destructive Primal Diamond -- 107757
	recipe = AddRecipe(107757, V.MOP, Q.RARE)
	recipe:SetSkillLevels(575, 575, 600, 602, 605)
	recipe:SetRecipeItem(83840, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_META")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.PANDARIA)

	-- Effulgent Primal Diamond -- 107758
	recipe = AddRecipe(107758, V.MOP, Q.RARE)
	recipe:SetSkillLevels(575, 575, 600, 602, 605)
	recipe:SetRecipeItem(83842, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_META")
	recipe:AddWorldDrop(Z.PANDARIA)

	-- Ember Primal Diamond -- 107759
	recipe = AddRecipe(107759, V.MOP, Q.RARE)
	recipe:SetSkillLevels(575, 575, 600, 602, 605)
	recipe:SetRecipeItem(83844, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_META")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddWorldDrop(Z.PANDARIA)

	-- Enigmatic Primal Diamond -- 107760
	recipe = AddRecipe(107760, V.MOP, Q.RARE)
	recipe:SetSkillLevels(575, 575, 600, 602, 605)
	recipe:SetRecipeItem(83848, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_META")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.PANDARIA)

	-- Eternal Primal Diamond -- 107762
	recipe = AddRecipe(107762, V.MOP, Q.RARE)
	recipe:SetSkillLevels(575, 575, 600, 602, 605)
	recipe:SetRecipeItem(83851, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_META")
	recipe:AddFilters(F.TANK)
	recipe:AddWorldDrop(Z.PANDARIA)

	-- Fleet Primal Diamond -- 107763
	recipe = AddRecipe(107763, V.MOP, Q.RARE)
	recipe:SetSkillLevels(575, 575, 600, 602, 605)
	recipe:SetRecipeItem(83859, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_META")
	recipe:AddWorldDrop(Z.PANDARIA)

	-- Forlorn Primal Diamond -- 107764
	recipe = AddRecipe(107764, V.MOP, Q.RARE)
	recipe:SetSkillLevels(575, 575, 600, 602, 605)
	recipe:SetRecipeItem(83862, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_META")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddWorldDrop(Z.PANDARIA)

	-- Impassive Primal Diamond -- 107765
	recipe = AddRecipe(107765, V.MOP, Q.RARE)
	recipe:SetSkillLevels(575, 575, 600, 602, 605)
	recipe:SetRecipeItem(83872, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_META")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.PANDARIA)

	-- Powerful Primal Diamond -- 107766
	recipe = AddRecipe(107766, V.MOP, Q.RARE)
	recipe:SetSkillLevels(575, 575, 600, 602, 605)
	recipe:SetRecipeItem(83842, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_META")
	recipe:AddWorldDrop(Z.PANDARIA)

	-- Reverberating Primal Diamond -- 107767
	recipe = AddRecipe(107767, V.MOP, Q.RARE)
	recipe:SetSkillLevels(575, 575, 600, 602, 605)
	recipe:SetRecipeItem(83925, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_META")
	recipe:AddFilters(F.DPS)
	recipe:AddWorldDrop(Z.PANDARIA)

	-- Revitalizing Primal Diamond -- 107768
	recipe = AddRecipe(107768, V.MOP, Q.RARE)
	recipe:SetSkillLevels(575, 575, 600, 602, 605)
	recipe:SetRecipeItem(83926, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_META")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddWorldDrop(Z.PANDARIA)

	-- Jeweled Onyx Panther -- 120045
	recipe = AddRecipe(120045, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 600, 615)
	recipe:SetRecipeItem(83877, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(82453, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_MOUNT")
	recipe:AddRepVendor(FAC.ORDER_OF_THE_CLOUD_SERPENT, REP.EXALTED, 58414)

	-- Ruby Panther -- 121841
	recipe = AddRecipe(121841, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 600, 615)
	recipe:SetRecipeItem(83931, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(83087, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_MOUNT")
	recipe:AddRepVendor(FAC.ORDER_OF_THE_CLOUD_SERPENT, REP.REVERED, 58414)

	-- Sapphire Panther -- 121842
	recipe = AddRecipe(121842, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 600, 615)
	recipe:SetRecipeItem(83932, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(83090, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_MOUNT")
	recipe:AddRepVendor(FAC.ORDER_OF_THE_CLOUD_SERPENT, REP.REVERED, 58414)

	-- Sunstone Panther -- 121843
	recipe = AddRecipe(121843, V.MOP, Q.RARE)
	recipe:SetSkillLevels(600, 600, 600, 600, 615)
	recipe:SetRecipeItem(83930, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(83089, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_MOUNT")
	recipe:AddRepVendor(FAC.ORDER_OF_THE_CLOUD_SERPENT, REP.HONORED, 58414)

	-- Jade Panther -- 121844
	recipe = AddRecipe(121844, V.MOP, Q.RARE)
	recipe:SetSkillLevels(600, 600, 600, 600, 615)
	recipe:SetRecipeItem(83945, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(83088, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_MOUNT")
	recipe:AddRepVendor(FAC.ORDER_OF_THE_CLOUD_SERPENT, REP.HONORED, 58414)

	-- Ornate Band -- 122661
	recipe = AddRecipe(122661, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(83793, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddTrainer(15501, 18751, 19775, 46675, 65098, 93527, 100538)

	-- Shadowfire Necklace -- 122662
	recipe = AddRecipe(122662, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(83794, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddTrainer(15501, 18751, 19775, 46675, 65098, 93527, 100538)

	-- Scrying Roguestone -- 122663
	recipe = AddRecipe(122663, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(83795, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddTrainer(15501, 18751, 19775, 46675, 65098, 93527, 100538)

	-- Heart of the Earth -- 122664
	recipe = AddRecipe(122664, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(83796, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(65098)

	-- Roguestone Shadowband -- 122665
	recipe = AddRecipe(122665, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(83798, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(65098)

	-- Lord's Signet -- 122666
	recipe = AddRecipe(122666, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(83799, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(65098)

	-- Lionsfall Ring -- 122667
	recipe = AddRecipe(122667, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(83800, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(65098)

	-- Band of Blood -- 122668
	recipe = AddRecipe(122668, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(83801, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(65098)

	-- Reflection of the Sea -- 122669
	recipe = AddRecipe(122669, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(83802, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(65098)

	-- Golembreaker Amulet -- 122670
	recipe = AddRecipe(122670, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(83803, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(65098)

	-- Widow Chain -- 122671
	recipe = AddRecipe(122671, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(83804, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(65098)

	-- Skymage Circle -- 122672
	recipe = AddRecipe(122672, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(83805, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(65098)

	-- Tiger Opal Pendant -- 122673
	recipe = AddRecipe(122673, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(83806, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(65098)

	-- Delicate Serpent's Eye -- 122674
	recipe = AddRecipe(122674, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(83151, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_RED")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(65098)

	-- Bold Serpent's Eye -- 122675
	recipe = AddRecipe(122675, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(83141, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_RED")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(65098)

	-- Brilliant Serpent's Eye -- 122676
	recipe = AddRecipe(122676, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(83150, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_RED")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(65098)

	-- Sparkling Serpent's Eye -- 122677
	recipe = AddRecipe(122677, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(83149, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_BLUE")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(65098)

	-- Solid Serpent's Eye -- 122678
	recipe = AddRecipe(122678, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(83148, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_BLUE")
	recipe:AddTrainer(65098)

	-- Subtle Serpent's Eye -- 122679
	recipe = AddRecipe(122679, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(83145, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_YELLOW")
	recipe:AddFilters(F.TANK)
	recipe:AddTrainer(65098)

	-- Smooth Serpent's Eye -- 122680
	recipe = AddRecipe(122680, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(83146, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_YELLOW")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(65098)

	-- Rigid Serpent's Eye -- 122681
	recipe = AddRecipe(122681, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(83144, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_BLUE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(65098)

	-- Quick Serpent's Eye -- 122682
	recipe = AddRecipe(122682, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(83142, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_YELLOW")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(65098)

	-- Precise Serpent's Eye -- 122683
	recipe = AddRecipe(122683, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(83147, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_RED")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(65098)

	-- Fractured Serpent's Eye -- 122684
	recipe = AddRecipe(122684, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(83143, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_YELLOW")
	recipe:AddTrainer(65098)

	-- Flashing Serpent's Eye -- 122685
	recipe = AddRecipe(122685, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(83152, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_RED")
	recipe:AddFilters(F.TANK)
	recipe:AddTrainer(65098)

	-- Tense Roguestone -- 130655
	recipe = AddRecipe(130655, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(45, 45, 55, 60, 65)
	recipe:SetCraftedItem(89675, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(15501, 18751, 19775, 46675, 65098, 93527, 100538)

	-- Assassin's Roguestone -- 130656
	recipe = AddRecipe(130656, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(5, 5, 15, 20, 25)
	recipe:SetCraftedItem(89678, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(15501, 18751, 19775, 46675, 65098, 93527, 100538)

	-- Assassin's Imperial Amethyst -- 130657
	recipe = AddRecipe(130657, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(550, 550, 600, 602, 605)
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.DPS)
	recipe:AddDiscovery("DISCOVERY_JC_PANDARIA")

	-- Tense Imperial Amethyst -- 130658
	recipe = AddRecipe(130658, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(550, 550, 600, 602, 605)
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.DPS)
	recipe:AddDiscovery("DISCOVERY_JC_PANDARIA")

	-- River's Heart -- 131593
	recipe = AddRecipe(131593, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(90395, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_BLUE")
	recipe:AddTrainer(15501, 18751, 19775, 46675, 65098, 93527, 100538)

	-- Primordial Ruby -- 131686
	recipe = AddRecipe(131686, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(90401, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_RED")
	recipe:AddTrainer(15501, 18751, 19775, 46675, 65098, 93527, 100538)

	-- Wild Jade -- 131688
	recipe = AddRecipe(131688, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(10, 10, 20, 25, 30)
	recipe:SetCraftedItem(90397, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddTrainer(15501, 18751, 19775, 46675, 65098, 93527, 100538)

	-- Vermilion Onyx -- 131690
	recipe = AddRecipe(131690, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(10, 10, 20, 25, 30)
	recipe:SetCraftedItem(90400, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddTrainer(15501, 18751, 19775, 46675, 65098, 93527, 100538)

	-- Imperial Amethyst -- 131691
	recipe = AddRecipe(131691, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(20, 20, 30, 35, 40)
	recipe:SetCraftedItem(90399, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddTrainer(15501, 18751, 19775, 46675, 65098, 93527, 100538)

	-- Sun's Radiance -- 131695
	recipe = AddRecipe(131695, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(90398, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_YELLOW")
	recipe:AddTrainer(15501, 18751, 19775, 46675, 65098, 93527, 100538)

	-- Secrets of the Stone -- 131759
	recipe = AddRecipe(131759, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(90406, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_CREATED_ITEM")
	recipe:AddTrainer(15501, 18751, 19775, 46675, 65098, 93527, 100538)

	-- Jade Owl -- 131897
	recipe = AddRecipe(131897, V.MOP, Q.RARE)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetRecipeItem(90470, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(82774, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_PET")
	recipe:AddCustom("ANCIENT_GUO-LAI_CACHE")

	-- Sapphire Cub -- 131898
	recipe = AddRecipe(131898, V.MOP, Q.RARE)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetRecipeItem(90471, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_PET")
	recipe:AddCustom("ANCIENT_GUO-LAI_CACHE")

	-- Resplendent Serpent's Eye -- 136269
	recipe = AddRecipe(136269, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(93404, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(65098)

	-- Lucent Serpent's Eye -- 136270
	recipe = AddRecipe(136270, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(93405, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(65098)

	-- Willful Serpent's Eye -- 136272
	recipe = AddRecipe(136272, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(93406, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(65098)

	-- Tense Serpent's Eye -- 136273
	recipe = AddRecipe(136273, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(93408, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(65098)

	-- Assassin's Serpent's Eye -- 136274
	recipe = AddRecipe(136274, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(93409, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(65098)

	-- Mysterious Serpent's Eye -- 136275
	recipe = AddRecipe(136275, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(93410, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(65098)

	-- Serpent's Heart -- 140050
	recipe = AddRecipe(140050, V.MOP, Q.RARE)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetRecipeItem(95469, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PRISMATIC")
	recipe:AddWorldDrop(Z.PANDARIA)

	-- Primal Diamond -- 140060
	recipe = AddRecipe(140060, V.MOP, Q.RARE)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetRecipeItem(95471, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_META")
	recipe:AddWorldDrop(Z.PANDARIA)

	-- ----------------------------------------------------------------------------
	-- Warlords of Draenor.
	-- ----------------------------------------------------------------------------
	-- Taladite Crystal -- 170700
	recipe = AddRecipe(170700, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 600, 800, 1000)
	recipe:SetCraftedItem(115524, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_CREATED_ITEM")
	recipe:AddCustom("DRAENOR_DEFAULT")

	-- Taladite Recrystalizer -- 170701
	recipe = AddRecipe(170701, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 700, 700)
	recipe:SetRecipeItem(116078, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(115526, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_ITEM_ENHANCEMENT")
	recipe:AddVendor(77356, 79832, 87052, 87548)

	-- Glowing Iron Band -- 170704
	recipe = AddRecipe(170704, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 600, 600, 600)
	recipe:SetCraftedItem(115987, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddFilters(F.DPS)
	recipe:AddCustom("DRAENOR_DEFAULT")

	-- Shifting Iron Band -- 170705
	recipe = AddRecipe(170705, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 600, 600, 600)
	recipe:SetCraftedItem(115988, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddFilters(F.DPS)
	recipe:AddCustom("DRAENOR_DEFAULT")

	-- Whispering Iron Band -- 170706
	recipe = AddRecipe(170706, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 600, 600, 600)
	recipe:SetCraftedItem(115989, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddCustom("DRAENOR_DEFAULT")

	-- Glowing Iron Choker -- 170707
	recipe = AddRecipe(170707, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 600, 600, 600)
	recipe:SetCraftedItem(115990, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddFilters(F.DPS)
	recipe:AddCustom("DRAENOR_DEFAULT")

	-- Shifting Iron Choker -- 170708
	recipe = AddRecipe(170708, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 600, 600, 600)
	recipe:SetCraftedItem(115991, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddFilters(F.DPS)
	recipe:AddCustom("DRAENOR_DEFAULT")

	-- Whispering Iron Choker -- 170709
	recipe = AddRecipe(170709, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 600, 600, 600)
	recipe:SetCraftedItem(115992, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddCustom("DRAENOR_DEFAULT")

	-- Glowing Blackrock Band -- 170710
	recipe = AddRecipe(170710, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 600, 600, 600)
	recipe:SetCraftedItem(115993, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddFilters(F.DPS)
	recipe:AddCustom("DRAENOR_DEFAULT")

	-- Shifting Blackrock Band -- 170711
	recipe = AddRecipe(170711, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 600, 600, 600)
	recipe:SetCraftedItem(115994, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddFilters(F.DPS)
	recipe:AddCustom("DRAENOR_DEFAULT")

	-- Whispering Blackrock Band -- 170712
	recipe = AddRecipe(170712, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 600, 600, 600)
	recipe:SetCraftedItem(115995, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddCustom("DRAENOR_DEFAULT")

	-- Glowing Taladite Ring -- 170713
	recipe = AddRecipe(170713, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 700, 701)
	recipe:SetRecipeItem(116090, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(115794, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddFilters(F.DPS)
	recipe:AddVendor(77356, 79832, 87052, 87548)

	-- Shifting Taladite Ring -- 170714
	recipe = AddRecipe(170714, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 700, 701)
	recipe:SetRecipeItem(116091, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(115796, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddFilters(F.DPS)
	recipe:AddVendor(77356, 79832, 87052, 87548)

	-- Whispering Taladite Ring -- 170715
	recipe = AddRecipe(170715, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 700, 701)
	recipe:SetRecipeItem(116092, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(115798, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(77356, 79832, 87052, 87548)

	-- Glowing Taladite Pendant -- 170716
	recipe = AddRecipe(170716, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 700, 701)
	recipe:SetRecipeItem(116093, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(115799, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddFilters(F.DPS)
	recipe:AddVendor(77356, 79832, 87052, 87548)

	-- Shifting Taladite Pendant -- 170717
	recipe = AddRecipe(170717, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 700, 701)
	recipe:SetRecipeItem(116094, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(115800, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddFilters(F.DPS)
	recipe:AddVendor(77356, 79832, 87052, 87548)

	-- Whispering Taladite Pendant -- 170718
	recipe = AddRecipe(170718, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 700, 701)
	recipe:SetRecipeItem(116095, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(115801, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(77356, 79832, 87052, 87548)

	-- Critical Strike Taladite -- 170719
	recipe = AddRecipe(170719, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 700, 700)
	recipe:SetRecipeItem(116096, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(115803, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PRISMATIC")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(77356, 79832, 87052, 87548)

	-- Haste Taladite -- 170720
	recipe = AddRecipe(170720, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 700, 700)
	recipe:SetRecipeItem(116097, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(115804, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PRISMATIC")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(77356, 79832, 87052, 87548)

	-- Mastery Taladite -- 170721
	recipe = AddRecipe(170721, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 700, 700)
	recipe:SetRecipeItem(116098, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(115805, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PRISMATIC")
	recipe:AddVendor(77356, 79832, 87052, 87548)

	-- Versatility Taladite -- 170723
	recipe = AddRecipe(170723, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 700, 700)
	recipe:SetRecipeItem(116100, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(115807, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PRISMATIC")
	recipe:AddVendor(77356, 79832, 87052, 87548)

	-- Stamina Taladite -- 170724
	recipe = AddRecipe(170724, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 700, 700)
	recipe:SetRecipeItem(116101, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(115808, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PRISMATIC")
	recipe:AddVendor(77356, 79832, 87052, 87548)

	-- Greater Critical Strike Taladite -- 170725
	recipe = AddRecipe(170725, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 705, 710)
	recipe:SetRecipeItem(116102, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(115809, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PRISMATIC")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(77356, 79832, 87052, 87548)

	-- Greater Haste Taladite -- 170726
	recipe = AddRecipe(170726, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 705, 710)
	recipe:SetRecipeItem(116103, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(115811, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PRISMATIC")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(77356, 79832, 87052, 87548)

	-- Greater Mastery Taladite -- 170727
	recipe = AddRecipe(170727, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 705, 710)
	recipe:SetRecipeItem(116104, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(115812, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PRISMATIC")
	recipe:AddVendor(77356, 79832, 87052, 87548)

	-- Greater Versatility Taladite -- 170729
	recipe = AddRecipe(170729, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 705, 710)
	recipe:SetRecipeItem(116106, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(115814, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PRISMATIC")
	recipe:AddVendor(77356, 79832, 87052, 87548)

	-- Greater Stamina Taladite -- 170730
	recipe = AddRecipe(170730, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 705, 710)
	recipe:SetRecipeItem(116107, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(115815, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PRISMATIC")
	recipe:AddVendor(77356, 79832, 87052, 87548)

	-- Reflecting Prism -- 170731
	recipe = AddRecipe(170731, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 600, 600, 600)
	recipe:SetRecipeItem(116108, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(112384, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_CREATED_ITEM")
	recipe:AddVendor(77356, 79832, 87052, 87548)

	-- Prismatic Focusing Lens -- 170732
	recipe = AddRecipe(170732, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 600, 600, 600)
	recipe:SetRecipeItem(116109, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(112498, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_CREATED_ITEM")
	recipe:AddVendor(77356, 79832, 87052, 87548)

	-- Secrets of Draenor Jewelcrafting -- 176087
	recipe = AddRecipe(176087, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 600, 650, 700)
	recipe:SetCraftedItem(118723, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_CREATED_ITEM")
	recipe:AddCustom("DRAENOR_DEFAULT")

	-- Primal Gemcutting -- 182127
	recipe = AddRecipe(182127, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 700, 700)
	recipe:SetRecipeItem(122714, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(115524, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_CREATED_ITEM")
	recipe:AddVendor(90894, 91030)

	-- Immaculate Critical Strike Taladite -- 187634
	recipe = AddRecipe(187634, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(700, 700, 700, 707, 715)
	recipe:SetRecipeItem(127771, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(127760, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PRISMATIC")
	recipe:AddMobDrop(95067)
	recipe:AddDiscovery("DISCOVERY_JC_WOD")

	-- Immaculate Haste Taladite -- 187635
	recipe = AddRecipe(187635, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(700, 700, 700, 707, 715)
	recipe:SetRecipeItem(127772, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(127761, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PRISMATIC")
	recipe:AddDiscovery("DISCOVERY_JC_WOD")
	recipe:AddMobDrop(76266)
	recipe:AddCustom("MYTHIC")

	-- Immaculate Mastery Taladite -- 187636
	recipe = AddRecipe(187636, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(700, 700, 700, 707, 715)
	recipe:SetRecipeItem(127773, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(127762, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PRISMATIC")
	recipe:AddVendor(68363, 68364)
	recipe:AddDiscovery("DISCOVERY_JC_WOD")

	-- Immaculate Versatility Taladite -- 187639
	recipe = AddRecipe(187639, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(700, 700, 700, 707, 715)
	recipe:SetCraftedItem(127764, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PRISMATIC")
	recipe:AddQuest(39175, 39195)
	recipe:AddDiscovery("DISCOVERY_JC_WOD")

	-- Immaculate Stamina Taladite -- 187640
	recipe = AddRecipe(187640, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(700, 700, 700, 707, 715)
	recipe:SetRecipeItem(127775, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(127765, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PRISMATIC")
	recipe:AddMobDrop(87493)
	recipe:AddDiscovery("DISCOVERY_JC_WOD")

	-- ----------------------------------------------------------------------------
	-- Legion.
	-- ----------------------------------------------------------------------------
	-- Deadly Deep Amber -- 195848
	recipe = AddRecipe(195848, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 715, 730)
	recipe:SetRecipeItem(138451, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(130215, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PRISMATIC")
	recipe:AddQuest(40532)
	recipe:AddVendor(100500)

	-- Quick Azsunite -- 195849
	recipe = AddRecipe(195849, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 715, 730)
	recipe:SetRecipeItem(138452, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(130216, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PRISMATIC")
	recipe:AddQuest(40533)
	recipe:AddVendor(100500)

	-- Versatile Skystone -- 195850
	recipe = AddRecipe(195850, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 715, 730)
	recipe:SetCraftedItem(130217, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PRISMATIC")
	recipe:AddQuest(40529)

	-- Masterful Queen's Opal -- 195851
	recipe = AddRecipe(195851, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 715, 730)
	recipe:SetCraftedItem(130218, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PRISMATIC")
	recipe:AddQuest(40534)

	-- Deadly Eye of Prophecy -- 195852
	recipe = AddRecipe(195852, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 720, 735, 750)
	recipe:SetCraftedItem(130219, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PRISMATIC")
	recipe:AddQuest(40542)

	-- Quick Dawnlight -- 195853
	recipe = AddRecipe(195853, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 720, 735, 750)
	recipe:SetCraftedItem(130220, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PRISMATIC")
	recipe:AddQuest(40543)

	-- Versatile Maelstrom Sapphire -- 195854
	recipe = AddRecipe(195854, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 720, 735, 750)
	recipe:SetCraftedItem(130221, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PRISMATIC")
	recipe:AddQuest(40538)

	-- Masterful Shadowruby -- 195855
	recipe = AddRecipe(195855, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 720, 735, 750)
	recipe:SetCraftedItem(130222, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PRISMATIC")
	recipe:AddQuest(40544)

	-- Deep Amber Loop -- 195856
	recipe = AddRecipe(195856, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 720, 720)
	recipe:SetRecipeItem(137792, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(130223, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddQuest(40527)
	recipe:AddVendor(100500)

	-- Skystone Loop -- 195857
	recipe = AddRecipe(195857, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 720, 720)
	recipe:SetRecipeItem(137793, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(130224, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddQuest(40526)
	recipe:AddVendor(100500)

	-- Azsunite Loop -- 195858
	recipe = AddRecipe(195858, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 720, 720)
	recipe:SetRecipeItem(137794, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(130225, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddQuest(40528)

	-- Deep Amber Pendant -- 195859
	recipe = AddRecipe(195859, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 720, 730, 740)
	recipe:SetRecipeItem(137795, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(130226, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddQuest(40536)

	-- Skystone Pendant -- 195860
	recipe = AddRecipe(195860, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 720, 730, 740)
	recipe:SetRecipeItem(137796, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(130227, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddQuest(40536)

	-- Azsunite Pendant -- 195861
	recipe = AddRecipe(195861, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 720, 730, 740)
	recipe:SetRecipeItem(137797, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(130228, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddQuest(40536)

	-- Prophetic Band -- 195862
	recipe = AddRecipe(195862, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 720, 730, 740)
	recipe:SetRecipeItem(137798, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(130229, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddQuest(40560)

	-- Maelstrom Band -- 195863
	recipe = AddRecipe(195863, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 720, 730, 740)
	recipe:SetRecipeItem(137799, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(130230, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddQuest(40561)

	-- Dawnlight Band -- 195864
	recipe = AddRecipe(195864, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 720, 730, 740)
	recipe:SetRecipeItem(137800, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(130231, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddQuest(40559)

	-- Sorcerous Shadowruby Pendant -- 195865
	recipe = AddRecipe(195865, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 740, 750, 760)
	recipe:SetRecipeItem(137801, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(130233, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddFilters(F.MAGE)
	recipe:AddVendor(100500)

	-- Blessed Dawnlight Medallion -- 195866
	recipe = AddRecipe(195866, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 740, 750, 760)
	recipe:SetRecipeItem(137802, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(130234, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddFilters(F.PRIEST)
	recipe:AddVendor(100500)

	-- Twisted Pandemonite Choker -- 195867
	recipe = AddRecipe(195867, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 740, 750, 760)
	recipe:SetRecipeItem(137803, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(130235, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddFilters(F.WARLOCK)
	recipe:AddVendor(100500)

	-- Subtle Shadowruby Pendant -- 195868
	recipe = AddRecipe(195868, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 740, 750, 760)
	recipe:SetRecipeItem(137804, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(130236, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddFilters(F.ROGUE)
	recipe:AddVendor(100500)

	-- Tranquil Necklace of Prophecy -- 195869
	recipe = AddRecipe(195869, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 740, 750, 760)
	recipe:SetRecipeItem(137805, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(130237, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddFilters(F.MONK)
	recipe:AddVendor(100500)

	-- Vindictive Pandemonite Choker -- 195870
	recipe = AddRecipe(195870, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 740, 750, 760)
	recipe:SetRecipeItem(137806, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(130238, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddFilters(F.DEMONHUNTER)
	recipe:AddVendor(100500)

	-- Sylvan Maelstrom Amulet -- 195871
	recipe = AddRecipe(195871, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 740, 750, 760)
	recipe:SetRecipeItem(137807, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(130239, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddFilters(F.DRUID)
	recipe:AddVendor(100500)

	-- Intrepid Necklace of Prophecy -- 195872
	recipe = AddRecipe(195872, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 740, 750, 760)
	recipe:SetRecipeItem(137808, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(130240, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddFilters(F.HUNTER)
	recipe:AddVendor(100500)

	-- Ancient Maelstrom Amulet -- 195873
	recipe = AddRecipe(195873, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 740, 750, 760)
	recipe:SetRecipeItem(137809, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(130241, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddFilters(F.SHAMAN)
	recipe:AddVendor(100500)

	-- Righteous Dawnlight Medallion -- 195874
	recipe = AddRecipe(195874, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 740, 750, 760)
	recipe:SetRecipeItem(137810, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(130242, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddFilters(F.PALADIN)
	recipe:AddVendor(100500)

	-- Raging Furystone Gorget -- 195875
	recipe = AddRecipe(195875, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 740, 750, 760)
	recipe:SetRecipeItem(137811, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(130243, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddFilters(F.WARRIOR)
	recipe:AddVendor(100500)

	-- Grim Furystone Gorget -- 195876
	recipe = AddRecipe(195876, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 740, 750, 760)
	recipe:SetRecipeItem(137812, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(130244, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddFilters(F.DK)
	recipe:AddVendor(100500)

	-- Saber's Eye -- 195877
	recipe = AddRecipe(195877, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 800, 800, 800)
	recipe:SetRecipeItem(137813, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(130245, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_MATERIALS")
	recipe:AddVendor(100500)

	-- Saber's Eye of Strength -- 195878
	recipe = AddRecipe(195878, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 800, 800, 800)
	recipe:SetRecipeItem(137814, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(130246, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PRISMATIC")
	recipe:AddVendor(100500)

	-- Saber's Eye of Agility -- 195879
	recipe = AddRecipe(195879, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 800, 800, 800)
	recipe:SetRecipeItem(137815, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(130247, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PRISMATIC")
	recipe:AddVendor(100500)

	-- Saber's Eye of Intellect -- 195880
	recipe = AddRecipe(195880, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 800, 800, 800)
	recipe:SetRecipeItem(137816, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(130248, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PRISMATIC")
	recipe:AddVendor(100500)

	-- Jeweled Lockpick -- 195881
	recipe = AddRecipe(195881, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 720, 740)
	recipe:SetCraftedItem(130250, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_CREATED_ITEM")
	recipe:AddQuest(40539)

	-- JewelCraft -- 195882
	recipe = AddRecipe(195882, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 735, 770)
	recipe:SetCraftedItem(130251, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_CREATED_ITEM")
	recipe:AddQuest(40558)

	-- Chatterstone -- 195883
	recipe = AddRecipe(195883, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 720, 740)
	recipe:SetCraftedItem(130254, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_CREATED_ITEM")
	recipe:AddQuest(40546)

	-- Deep Amber Loop -- 195902
	recipe = AddRecipe(195902, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 720, 730, 740)
	recipe:SetRecipeItem(137817, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(130223, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(93526)

	-- Skystone Loop -- 195903
	recipe = AddRecipe(195903, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 720, 730, 740)
	recipe:SetRecipeItem(137818, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(130224, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddVendor(93526)

	-- Azsunite Loop -- 195904
	recipe = AddRecipe(195904, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 720, 730, 740)
	recipe:SetRecipeItem(137819, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(130225, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(93526)

	-- Deep Amber Pendant -- 195905
	recipe = AddRecipe(195905, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 740, 750, 760)
	recipe:SetRecipeItem(137820, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(130226, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(93526)

	-- Skystone Pendant -- 195906
	recipe = AddRecipe(195906, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 740, 750, 760)
	recipe:SetRecipeItem(137821, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(130227, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddVendor(93526)

	-- Azsunite Pendant -- 195907
	recipe = AddRecipe(195907, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 740, 750, 760)
	recipe:SetRecipeItem(137822, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(130228, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(93526)

	-- Prophetic Band -- 195908
	recipe = AddRecipe(195908, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 740, 750, 760)
	recipe:SetRecipeItem(137823, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(130229, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddQuest(43943)
	recipe:AddCustom("WITHERED_ARMY")

	-- Maelstrom Band -- 195909
	recipe = AddRecipe(195909, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 740, 750, 760)
	recipe:SetRecipeItem(137824, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(130230, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddWorldDrop(Z.THE_VIOLET_HOLD)

	-- Dawnlight Band -- 195910
	recipe = AddRecipe(195910, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 740, 750, 760)
	recipe:SetRecipeItem(137825, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(130231, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddMobDrop(96028)

	-- Sorcerous Shadowruby Pendant -- 195911
	recipe = AddRecipe(195911, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 760, 770, 780)
	recipe:SetRecipeItem(137826, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(130233, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddFilters(F.MAGE)
	recipe:AddVendor(97362)

	-- Blessed Dawnlight Medallion -- 195912
	recipe = AddRecipe(195912, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 760, 770, 780)
	recipe:SetRecipeItem(137827, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(130234, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddFilters(F.PRIEST)
	recipe:AddVendor(93526)

	-- Twisted Pandemonite Choker -- 195913
	recipe = AddRecipe(195913, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 760, 770, 780)
	recipe:SetRecipeItem(137828, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(130235, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddFilters(F.WARLOCK)
	recipe:AddVendor(97360)

	-- Subtle Shadowruby Pendant -- 195914
	recipe = AddRecipe(195914, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 760, 770, 780)
	recipe:SetRecipeItem(137829, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(130236, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddFilters(F.ROGUE)
	recipe:AddVendor(97366)

	-- Tranquil Necklace of Prophecy -- 195915
	recipe = AddRecipe(195915, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 760, 770, 780)
	recipe:SetRecipeItem(137830, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(130237, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddFilters(F.MONK)
	recipe:AddVendor(93526)

	-- Vindictive Pandemonite Choker -- 195916
	recipe = AddRecipe(195916, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 760, 770, 780)
	recipe:SetRecipeItem(137831, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(130238, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddFilters(F.DEMONHUNTER)
	recipe:AddVendor(97361)

	-- Sylvan Maelstrom Amulet -- 195917
	recipe = AddRecipe(195917, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 760, 770, 780)
	recipe:SetRecipeItem(137832, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(130239, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddFilters(F.DRUID)
	recipe:AddVendor(93526)

	-- Intrepid Necklace of Prophecy -- 195918
	recipe = AddRecipe(195918, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 760, 770, 780)
	recipe:SetRecipeItem(137833, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(130240, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddFilters(F.HUNTER)
	recipe:AddVendor(93526)

	-- Ancient Maelstrom Amulet -- 195919
	recipe = AddRecipe(195919, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 760, 770, 780)
	recipe:SetRecipeItem(137834, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(130241, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddFilters(F.SHAMAN)
	recipe:AddVendor(93526)

	-- Righteous Dawnlight Medallion -- 195920
	recipe = AddRecipe(195920, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 760, 770, 780)
	recipe:SetRecipeItem(137835, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(130242, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddFilters(F.PALADIN)
	recipe:AddVendor(93526)

	-- Raging Furystone Gorget -- 195921
	recipe = AddRecipe(195921, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 760, 770, 780)
	recipe:SetRecipeItem(137836, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(130243, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddFilters(F.WARRIOR)
	recipe:AddVendor(93526)

	-- Grim Furystone Gorget -- 195922
	recipe = AddRecipe(195922, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 760, 770, 780)
	recipe:SetRecipeItem(137837, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(130244, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddFilters(F.DK)
	recipe:AddVendor(93526)

	-- Deep Amber Loop -- 195923
	recipe = AddRecipe(195923, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 740, 750, 760)
	recipe:SetRecipeItem(137838, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(130223, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddQuest(41652)

	-- Skystone Loop -- 195924
	recipe = AddRecipe(195924, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 740, 750, 760)
	recipe:SetRecipeItem(137839, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(130224, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddRepVendor(FAC.HIGHMOUNTAIN_TRIBE, REP.HONORED, 106902)

	-- Azsunite Loop -- 195925
	recipe = AddRecipe(195925, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 740, 750, 760)
	recipe:SetRecipeItem(137840, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(130225, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddQuest(41656)

	-- Deep Amber Pendant -- 195926
	recipe = AddRecipe(195926, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 760, 770, 780)
	recipe:SetRecipeItem(137841, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(130226, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddWorldDrop(Z.BROKEN_ISLES)

	-- Skystone Pendant -- 195927
	recipe = AddRecipe(195927, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 760, 770, 780)
	recipe:SetRecipeItem(137842, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(130227, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddQuest(41653)

	-- Azsunite Pendant -- 195928
	recipe = AddRecipe(195928, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 760, 770, 780)
	recipe:SetRecipeItem(137843, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(130228, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddQuest(41651)

	-- Prophetic Band -- 195929
	recipe = AddRecipe(195929, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 740, 750, 760)
	recipe:SetRecipeItem(137844, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(130229, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddRepVendor(FAC.HIGHMOUNTAIN_TRIBE, REP.EXALTED, 106902)

	-- Maelstrom Band -- 195930
	recipe = AddRecipe(195930, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 740, 750, 760)
	recipe:SetRecipeItem(137845, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(130230, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddCustom("PROF_FISH_SURA")

	-- Dawnlight Band -- 195931
	recipe = AddRecipe(195931, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 740, 750, 760)
	recipe:SetRecipeItem(137846, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(130231, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddRepVendor(FAC.HIGHMOUNTAIN_TRIBE, REP.EXALTED, 106902)

	-- Sorcerous Shadowruby Pendant -- 195932
	recipe = AddRecipe(195932, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 780, 790, 800)
	recipe:SetRecipeItem(137847, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(130233, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddFilters(F.MAGE)
	recipe:AddMobDrop(109331)

	-- Blessed Dawnlight Medallion -- 195933
	recipe = AddRecipe(195933, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 780, 790, 800)
	recipe:SetRecipeItem(137848, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(130234, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddFilters(F.PRIEST)
	recipe:AddCustom("HEROIC", "WATERLOGGED_CACHE")

	-- Twisted Pandemonite Choker -- 195934
	recipe = AddRecipe(195934, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 780, 790, 800)
	recipe:SetRecipeItem(137849, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(130235, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddFilters(F.WARLOCK)
	recipe:AddRepVendor(FAC.THE_WARDENS, REP.EXALTED, 107379)

	-- Subtle Shadowruby Pendant -- 195935
	recipe = AddRecipe(195935, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 780, 790, 800)
	recipe:SetRecipeItem(137850, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(130236, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddFilters(F.ROGUE)
	recipe:AddRepVendor(FAC.THE_NIGHTFALLEN, REP.EXALTED, 97140, 115736)

	-- Tranquil Necklace of Prophecy -- 195936
	recipe = AddRecipe(195936, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 780, 790, 800)
	recipe:SetRecipeItem(137851, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(130237, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddFilters(F.INSTANCE, F.MONK)
	recipe:AddMobDrop(98208)
	recipe:AddCustom("HEROIC")

	-- Vindictive Pandemonite Choker -- 195937
	recipe = AddRecipe(195937, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 780, 790, 800)
	recipe:SetRecipeItem(137852, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(130238, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddFilters(F.INSTANCE, F.DEMONHUNTER)
	recipe:AddMobDrop(95888)
	recipe:AddCustom("HEROIC")

	-- Sylvan Maelstrom Amulet -- 195938
	recipe = AddRecipe(195938, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 780, 790, 800)
	recipe:SetRecipeItem(137853, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(130239, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddFilters(F.DRUID)
	recipe:AddMobDrop(101403)
	recipe:AddCustom("HEROIC")

	-- Intrepid Necklace of Prophecy -- 195939
	recipe = AddRecipe(195939, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 780, 790, 800)
	recipe:SetRecipeItem(137854, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(130240, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddFilters(F.INSTANCE, F.HUNTER)
	recipe:AddMobDrop(91007)
	recipe:AddCustom("HEROIC")

	-- Ancient Maelstrom Amulet -- 195940
	recipe = AddRecipe(195940, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 780, 790, 800)
	recipe:SetRecipeItem(137855, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(130241, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddFilters(F.SHAMAN)
	recipe:AddRepVendor(FAC.HIGHMOUNTAIN_TRIBE, REP.EXALTED, 106902)

	-- Righteous Dawnlight Medallion -- 195941
	recipe = AddRecipe(195941, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 780, 790, 800)
	recipe:SetRecipeItem(137856, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(130242, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddFilters(F.INSTANCE, F.PALADIN)
	recipe:AddMobDrop(104218)
	recipe:AddCustom("MYTHIC")

	-- Raging Furystone Gorget -- 195942
	recipe = AddRecipe(195942, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 780, 790, 800)
	recipe:SetRecipeItem(137857, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(130243, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddFilters(F.INSTANCE, F.WARRIOR)
	recipe:AddMobDrop(110962)
	recipe:AddCustom("HEROIC")

	-- Grim Furystone Gorget -- 195943
	recipe = AddRecipe(195943, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 780, 790, 800)
	recipe:SetRecipeItem(137858, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(130244, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddFilters(F.INSTANCE, F.DK)
	recipe:AddMobDrop(94923)
	recipe:AddCustom("HEROIC")

	-- Queen's Opal Loop -- 209603
	recipe = AddRecipe(209603, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 710, 720)
	recipe:SetRecipeItem(137859, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(136711, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddVendor(100500)

	-- Queen's Opal Pendant -- 209604
	recipe = AddRecipe(209604, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 720, 730, 740)
	recipe:SetRecipeItem(137860, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(136712, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddVendor(100500)

	-- Shadowruby Band -- 209605
	recipe = AddRecipe(209605, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 720, 730, 740)
	recipe:SetRecipeItem(137861, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(136713, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddVendor(100500)

	-- Queen's Opal Loop -- 209606
	recipe = AddRecipe(209606, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 720, 730, 740)
	recipe:SetRecipeItem(137862, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(136711, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddVendor(93526)

	-- Queen's Opal Pendant -- 209607
	recipe = AddRecipe(209607, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 740, 750, 760)
	recipe:SetRecipeItem(137863, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(136712, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddVendor(93526)

	-- Shadowruby Band -- 209608
	recipe = AddRecipe(209608, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 740, 750, 760)
	recipe:SetRecipeItem(137864, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(136713, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddFilters(F.INSTANCE)
	recipe:AddMobDrop(91007)

	-- Queen's Opal Loop -- 209609
	recipe = AddRecipe(209609, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 740, 750, 760)
	recipe:SetRecipeItem(137865, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(136711, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddQuest(41654)

	-- Queen's Opal Pendant -- 209610
	recipe = AddRecipe(209610, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 760, 770, 780)
	recipe:SetRecipeItem(137866, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(136712, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddQuest(41655)

	-- Shadowruby Band -- 209611
	recipe = AddRecipe(209611, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 760, 770, 780)
	recipe:SetRecipeItem(137867, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(136713, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddCustom("PROF_ARCH_HIGH")

	-- Mass Prospect Leystone -- 225902
	recipe = AddRecipe(225902, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 1, 1, 1)
	recipe:SetRecipeItem(141311, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(130172, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_MATERIALS")
	recipe:AddDiscovery("DISCOVERY_JC_LEGION")

	-- Mass Prospect Felslate -- 225904
	recipe = AddRecipe(225904, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 1, 1, 1)
	recipe:SetRecipeItem(141312, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(130172, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_MATERIALS")
	recipe:AddDiscovery("DISCOVERY_JC_LEGION")

	-- Empyrial Cosmic Crown -- 247751
	recipe = AddRecipe(247751, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 790, 795, 800)
	recipe:SetRecipeItem(151724, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(151587, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_HEAD")
	recipe:AddQuest(48076)

	-- Empyrial Cosmic Crown -- 247754
	recipe = AddRecipe(247754, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 790, 795, 800)
	recipe:SetRecipeItem(151725, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(151587, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_HEAD")
	recipe:AddRepVendor(FAC.ARMY_OF_THE_LIGHT, REP.REVERED, 127120)

	-- Empyrial Cosmic Crown -- 247755
	recipe = AddRecipe(247755, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 790, 795, 800)
	recipe:SetRecipeItem(151726, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(151587, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_HEAD")
	recipe:AddMobDrop(126915)

	-- Empyrial Deep Crown -- 247756
	recipe = AddRecipe(247756, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 790, 795, 800)
	recipe:SetRecipeItem(151727, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(151588, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_HEAD")
	recipe:AddQuest(48076)

	-- Empyrial Deep Crown -- 247757
	recipe = AddRecipe(247757, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 790, 795, 800)
	recipe:SetRecipeItem(151728, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(151588, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_HEAD")
	recipe:AddRepVendor(FAC.ARMY_OF_THE_LIGHT, REP.REVERED, 127120)

	-- Empyrial Deep Crown -- 247758
	recipe = AddRecipe(247758, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 790, 795, 800)
	recipe:SetRecipeItem(151729, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(151588, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_HEAD")
	recipe:AddMobDrop(126915)

	-- Mass Prospect Empyrium -- 247761
	recipe = AddRecipe(247761, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 1, 1, 1)
	recipe:SetRecipeItem(152726, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_MATERIALS")
	recipe:AddRepVendor(FAC.ARMY_OF_THE_LIGHT, REP.FRIENDLY, 127120)

	-- Empyrial Elemental Crown -- 247762
	recipe = AddRecipe(247762, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 790, 795, 800)
	recipe:SetRecipeItem(151730, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(151589, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_HEAD")
	recipe:AddQuest(48076)

	-- Empyrial Elemental Crown -- 247763
	recipe = AddRecipe(247763, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 790, 795, 800)
	recipe:SetRecipeItem(151731, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(151589, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_HEAD")
	recipe:AddRepVendor(FAC.ARMY_OF_THE_LIGHT, REP.REVERED, 127120)

	-- Empyrial Elemental Crown -- 247764
	recipe = AddRecipe(247764, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 790, 795, 800)
	recipe:SetRecipeItem(151732, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(151589, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_HEAD")
	recipe:AddMobDrop(126915)

	-- Empyrial Titan Crown -- 247765
	recipe = AddRecipe(247765, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 790, 795, 800)
	recipe:SetRecipeItem(151733, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(151590, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_HEAD")
	recipe:AddQuest(48076)

	-- Empyrial Titan Crown -- 247766
	recipe = AddRecipe(247766, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 790, 795, 800)
	recipe:SetRecipeItem(151734, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(151590, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_HEAD")
	recipe:AddRepVendor(FAC.ARMY_OF_THE_LIGHT, REP.REVERED, 127120)

	-- Empyrial Titan Crown -- 247767
	recipe = AddRecipe(247767, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 790, 795, 800)
	recipe:SetRecipeItem(151735, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(151590, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_HEAD")
	recipe:AddMobDrop(126915)

	-- Deadly Deep Chemirine -- 247771
	recipe = AddRecipe(247771, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 780, 790, 800)
	recipe:SetRecipeItem(151736, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(151580, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddQuest(48075)

	-- Quick Lightsphene -- 247772
	recipe = AddRecipe(247772, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 780, 790, 800)
	recipe:SetRecipeItem(151737, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(151583, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_YELLOW")
	recipe:AddQuest(48075)

	-- Masterful Argulite -- 247773
	recipe = AddRecipe(247773, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 780, 790, 800)
	recipe:SetRecipeItem(151738, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(151584, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddQuest(48075)

	-- Versatile Labradorite -- 247774
	recipe = AddRecipe(247774, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 780, 790, 800)
	recipe:SetRecipeItem(151739, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(151585, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_BLUE")
	recipe:AddQuest(48075)

	-- ----------------------------------------------------------------------------
	-- Battle for Azeroth.
	-- ----------------------------------------------------------------------------
	-- Viridium Staff of Alacrity -- 256253
	recipe = AddRecipe(256253, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(153638, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_STAFF")
	recipe:AddTrainer(122695, 130368, 153811, 154393)

	-- Rubellite Staff of Intuition -- 256254
	recipe = AddRecipe(256254, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(153637, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_STAFF")
	recipe:AddTrainer(122695, 130368, 153811, 154393)

	-- Laribole Staff of Alacrity -- 256255
	recipe = AddRecipe(256255, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(105, 105, 115, 120, 125)
	recipe:SetCraftedItem(153639, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_STAFF")
	recipe:AddTrainer(122695, 130368, 153811, 154393)

	-- Laribole Staff of Alacrity -- 256256
	recipe = AddRecipe(256256, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(125, 125, 135, 140, 145)
	recipe:SetCraftedItem(153639, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_STAFF")
	recipe:AddTrainer(122695, 130368, 153811, 154393)

	-- Laribole Staff of Alacrity -- 256257
	recipe = AddRecipe(256257, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 150, 150, 150)
	recipe:SetRecipeItem(162382, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(153639, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_STAFF")
	recipe:AddRepVendor(FAC.ZANDALARI_EMPIRE, REP.REVERED, 131287)
	recipe:AddRepVendor(FAC.STORMS_WAKE, REP.REVERED, 135800)

	-- Scarlet Diamond Staff of Intuition -- 256258
	recipe = AddRecipe(256258, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(105, 105, 115, 120, 125)
	recipe:SetCraftedItem(153640, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_STAFF")
	recipe:AddTrainer(122695, 130368, 153811, 154393)

	-- Scarlet Diamond Staff of Intuition -- 256259
	recipe = AddRecipe(256259, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(125, 125, 135, 140, 145)
	recipe:SetCraftedItem(153640, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_STAFF")
	recipe:AddTrainer(122695, 130368, 153811, 154393)

	-- Scarlet Diamond Staff of Intuition -- 256260
	recipe = AddRecipe(256260, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 150, 150, 150)
	recipe:SetRecipeItem(162385, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(153640, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_STAFF")
	recipe:AddRepVendor(FAC.ZANDALARI_EMPIRE, REP.REVERED, 131287)
	recipe:AddRepVendor(FAC.STORMS_WAKE, REP.REVERED, 135800)

	-- Amberblaze Loop -- 256510
	recipe = AddRecipe(256510, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(153686, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddTrainer(122695, 130368, 153811, 154393)

	-- Owlseye Loop -- 256511
	recipe = AddRecipe(256511, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(153685, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddTrainer(122695, 130368, 153811, 154393)

	-- Tidal Amethyst Loop -- 256512
	recipe = AddRecipe(256512, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(153684, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddTrainer(122695, 130368, 153811, 154393)

	-- Royal Quartz Loop -- 256513
	recipe = AddRecipe(256513, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(153683, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddTrainer(122695, 130368, 153811, 154393)

	-- Amberblaze Loop -- 256514
	recipe = AddRecipe(256514, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(85, 85, 95, 100, 105)
	recipe:SetCraftedItem(153686, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddTrainer(122695, 130368, 153811, 154393)

	-- Amberblaze Loop -- 256515
	recipe = AddRecipe(256515, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(85, 85, 125, 137, 150)
	recipe:SetRecipeItem(162378, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(153686, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddRepVendor(FAC.SEVENTH_LEGION, REP.REVERED, 135446)
	recipe:AddRepVendor(FAC.THE_HONORBOUND, REP.REVERED, 135447)

	-- Owlseye Loop -- 256516
	recipe = AddRecipe(256516, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(85, 85, 95, 100, 105)
	recipe:SetCraftedItem(153685, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddTrainer(122695, 130368, 153811, 154393)

	-- Owlseye Loop -- 256517
	recipe = AddRecipe(256517, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(85, 85, 125, 137, 150)
	recipe:SetRecipeItem(162379, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(153685, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddRepVendor(FAC.ZANDALARI_EMPIRE, REP.REVERED, 131287)
	recipe:AddRepVendor(FAC.STORMS_WAKE, REP.REVERED, 135800)

	-- Tidal Amethyst Loop -- 256518
	recipe = AddRecipe(256518, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(85, 85, 95, 100, 105)
	recipe:SetCraftedItem(153684, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddTrainer(122695, 130368, 153811, 154393)

	-- Tidal Amethyst Loop -- 256519
	recipe = AddRecipe(256519, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(85, 85, 125, 137, 150)
	recipe:SetRecipeItem(162380, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(153684, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddRepVendor(FAC.PROUDMOORE_ADMIRALTY, REP.REVERED, 135808)
	recipe:AddRepVendor(FAC.TALANJIS_EXPEDITION, REP.REVERED, 135459)

	-- Royal Quartz Loop -- 256520
	recipe = AddRecipe(256520, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(85, 85, 95, 100, 105)
	recipe:SetCraftedItem(153683, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddTrainer(122695, 130368, 153811, 154393)

	-- Royal Quartz Loop -- 256521
	recipe = AddRecipe(256521, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(85, 85, 125, 137, 150)
	recipe:SetRecipeItem(162381, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(153683, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddRepVendor(FAC.ORDER_OF_EMBERS, REP.REVERED, 135815)
	recipe:AddRepVendor(FAC.VOLDUNAI, REP.REVERED, 135804)

	-- Mass Prospect Monelite -- 256611
	recipe = AddRecipe(256611, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 85, 90, 95)
	recipe:SetCraftedItem(152512, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_MATERIALS")
	recipe:AddTrainer(122695, 130368, 153811, 154393)

	-- Mass Prospect Storm Silver -- 256613
	recipe = AddRecipe(256613, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 85, 90, 95)
	recipe:SetCraftedItem(152579, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_MATERIALS")
	recipe:AddTrainer(122695, 130368, 153811, 154393)

	-- Mass Prospect Platinum -- 256622
	recipe = AddRecipe(256622, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 85, 90, 95)
	recipe:SetCraftedItem(152513, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_MATERIALS")
	recipe:AddTrainer(122695, 130368, 153811, 154393)

	-- Deadly Solstone -- 256689
	recipe = AddRecipe(256689, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(153710, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddTrainer(122695, 130368, 153811, 154393)

	-- Versatile Kyanite -- 256690
	recipe = AddRecipe(256690, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(153712, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_BLUE")
	recipe:AddTrainer(122695, 130368, 153811, 154393)

	-- Straddling Viridium -- 256691
	recipe = AddRecipe(256691, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 15, 50, 85)
	recipe:SetCraftedItem(153715, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddCustom("DEFAULT_RECIPE")

	-- Masterful Kubiline -- 256692
	recipe = AddRecipe(256692, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(153713, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddTrainer(122695, 130368, 153811, 154393)

	-- Natant Rubellite -- 256693
	recipe = AddRecipe(256693, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 15, 50, 85)
	recipe:SetCraftedItem(153714, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_RED")
	recipe:AddCustom("DEFAULT_RECIPE")

	-- Quick Golden Beryl -- 256694
	recipe = AddRecipe(256694, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(153711, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_YELLOW")
	recipe:AddTrainer(122695, 130368, 153811, 154393)

	-- Versatile Royal Quartz -- 256695
	recipe = AddRecipe(256695, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 85, 90, 95)
	recipe:SetCraftedItem(154128, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_BLUE")
	recipe:AddTrainer(122695, 130368, 153811, 154393)

	-- Deadly Amberblaze -- 256696
	recipe = AddRecipe(256696, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 85, 90, 95)
	recipe:SetCraftedItem(154126, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddTrainer(122695, 130368, 153811, 154393)

	-- Masterful Tidal Amethyst -- 256698
	recipe = AddRecipe(256698, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 85, 90, 95)
	recipe:SetCraftedItem(154129, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddTrainer(122695, 130368, 153811, 154393)

	-- Quick Owlseye -- 256699
	recipe = AddRecipe(256699, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 85, 90, 95)
	recipe:SetCraftedItem(154127, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_YELLOW")
	recipe:AddTrainer(122695, 130368, 153811, 154393)

	-- Kraken's Eye of Strength -- 256700
	recipe = AddRecipe(256700, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(125, 125, 135, 140, 145)
	recipe:SetCraftedItem(153707, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PRISMATIC")
	recipe:AddTrainer(122695, 130368, 153811, 154393)

	-- Kraken's Eye of Agility -- 256701
	recipe = AddRecipe(256701, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(125, 125, 135, 140, 145)
	recipe:SetCraftedItem(153708, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PRISMATIC")
	recipe:AddTrainer(122695, 130368, 153811, 154393)

	-- Kraken's Eye of Intellect -- 256702
	recipe = AddRecipe(256702, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(125, 125, 135, 140, 145)
	recipe:SetCraftedItem(153709, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PRISMATIC")
	recipe:AddTrainer(122695, 130368, 153811, 154393)

	-- Jewelhammer's Focus -- 256703
	recipe = AddRecipe(256703, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(150, 150, 150, 150, 150)
	recipe:SetRecipeItem(168027, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(153716, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_CREATED_ITEM")
	recipe:AddQuest(49570, 49585)

	-- Honorable Combatant's Intuitive Staff -- 269734
	recipe = AddRecipe(269734, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(105, 105, 115, 120, 125)
	recipe:SetCraftedItem(159939, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_STAFF")
	recipe:AddTrainer(122695, 130368, 153811, 154393)

	-- Honorable Combatant's Intuitive Staff -- 269735
	recipe = AddRecipe(269735, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 115, 130, 145)
	recipe:SetRecipeItem(163024, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(159939, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_STAFF")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(142552, 142564)

	-- Honorable Combatant's Intuitive Staff -- 269736
	recipe = AddRecipe(269736, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 125, 137, 150)
	recipe:SetRecipeItem(163025, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(159939, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_STAFF")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(142552, 142564)

	-- Solstone Ring -- 272226
	recipe = AddRecipe(272226, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(153690, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddTrainer(122695, 130368, 153811, 154393)

	-- Golden Beryl Ring -- 272227
	recipe = AddRecipe(272227, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(153689, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddTrainer(122695, 130368, 153811, 154393)

	-- Kubiline Ring -- 272228
	recipe = AddRecipe(272228, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(153688, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddTrainer(122695, 130368, 153811, 154393)

	-- Kyanite Ring -- 272230
	recipe = AddRecipe(272230, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(153687, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddTrainer(122695, 130368, 153811, 154393)

	-- Kaleidoscopic Lens -- 278419
	recipe = AddRecipe(278419, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 85, 90, 95)
	recipe:SetCraftedItem(165743, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_CREATED_ITEM")
	recipe:AddTrainer(122695, 130368, 153811, 154393)

	-- Sinister Combatant's Intuitive Staff -- 282343
	recipe = AddRecipe(282343, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(115, 115, 125, 130, 135)
	recipe:SetCraftedItem(164681, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_STAFF")
	recipe:AddTrainer(122695, 130368, 153811, 154393)

	-- Sinister Combatant's Intuitive Staff -- 282344
	recipe = AddRecipe(282344, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 140, 145, 150)
	recipe:SetRecipeItem(165308, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(164681, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_STAFF")
	recipe:AddVendor(142552, 142564)

	-- Sinister Combatant's Intuitive Staff -- 282345
	recipe = AddRecipe(282345, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 145, 147, 150)
	recipe:SetRecipeItem(165309, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(164681, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_STAFF")
	recipe:AddVendor(142552, 142564)

	-- Sanguinated Recalibration -- 286651
	recipe = AddRecipe(286651, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(162461, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_MATERIALS")
	recipe:AddTrainer(122695, 130368, 153811, 154393)

	-- Aqueous Recalibration -- 287272
	recipe = AddRecipe(287272, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(162460, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_MATERIALS")
	recipe:AddTrainer(122695, 130368, 153811, 154393)

	-- Kraken's Eye Loop -- 289105
	recipe = AddRecipe(289105, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(130, 130, 140, 145, 150)
	recipe:SetCraftedItem(166519, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddTrainer(122695, 130368, 153811, 154393)

	-- Imbued Kraken's Eye Loop -- 289174
	recipe = AddRecipe(289174, V.BFA, Q.UNCOMMON)
	recipe:SetSkillLevels(130, 130, 145, 147, 150)
	recipe:SetRecipeItem(166540, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(166520, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddDiscovery("DISCOVERY_JC_BFA")

	-- Emblazoned Kraken's Eye Loop -- 289175
	recipe = AddRecipe(289175, V.BFA, Q.UNCOMMON)
	recipe:SetSkillLevels(130, 130, 150, 150, 150)
	recipe:SetRecipeItem(166541, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(166521, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddDiscovery("DISCOVERY_JC_BFA")

	-- Tidal Kraken's Eye Loop -- 289179
	recipe = AddRecipe(289179, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(135, 135, 145, 150, 155)
	recipe:SetCraftedItem(166522, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddTrainer(122695, 130368, 153811, 154393)

	-- Spirited Kraken's Eye Loop -- 289180
	recipe = AddRecipe(289180, V.BFA, Q.UNCOMMON)
	recipe:SetSkillLevels(135, 135, 150, 150, 150)
	recipe:SetRecipeItem(166542, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(166523, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddDiscovery("DISCOVERY_JC_BFA")

	-- Eternal Kraken's Eye Loop -- 289181
	recipe = AddRecipe(289181, V.BFA, Q.UNCOMMON)
	recipe:SetSkillLevels(135, 135, 150, 150, 150)
	recipe:SetRecipeItem(166543, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(166524, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddDiscovery("DISCOVERY_JC_BFA")

	-- Notorious Combatant's Intuitive Staff -- 294793
	recipe = AddRecipe(294793, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(145, 145, 155, 160, 165)
	recipe:SetCraftedItem(167943, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_STAFF")
	recipe:AddTrainer(153811, 154393)

	-- Notorious Combatant's Intuitive Staff -- 294794
	recipe = AddRecipe(294794, V.BFA, Q.EPIC)
	recipe:SetSkillLevels(160, 160, 170, 172, 175)
	recipe:SetRecipeItem(169551, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(167943, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_STAFF")
	recipe:AddVendor(154652, 154653)

	-- Notorious Combatant's Intuitive Staff -- 294795
	recipe = AddRecipe(294795, V.BFA, Q.EPIC)
	recipe:SetSkillLevels(175, 175, 175, 175, 175)
	recipe:SetRecipeItem(169552, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(167943, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_STAFF")
	recipe:AddVendor(154652, 154653)

	-- Versatile Dark Opal -- 298794
	recipe = AddRecipe(298794, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(150, 150, 160, 165, 170)
	recipe:SetCraftedItem(168642, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_BLUE")
	recipe:AddTrainer(153811, 154393)

	-- Quick Sand Spinel -- 298796
	recipe = AddRecipe(298796, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(155, 155, 165, 170, 175)
	recipe:SetCraftedItem(168641, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_YELLOW")
	recipe:AddTrainer(153811, 154393)

	-- Masterful Sea Currant -- 298797
	recipe = AddRecipe(298797, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(150, 150, 160, 165, 170)
	recipe:SetCraftedItem(168640, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddTrainer(153811, 154393)

	-- Deadly Lava Lazuli -- 298798
	recipe = AddRecipe(298798, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(155, 155, 165, 170, 175)
	recipe:SetCraftedItem(168639, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddTrainer(153811, 154393)

	-- Leviathan's Eye of Strength -- 298799
	recipe = AddRecipe(298799, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(165, 165, 175, 180, 185)
	recipe:SetCraftedItem(168636, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_META")
	recipe:AddTrainer(153811, 154393)

	-- Leviathan's Eye of Agility -- 298800
	recipe = AddRecipe(298800, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(165, 165, 175, 180, 185)
	recipe:SetCraftedItem(168637, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_META")
	recipe:AddTrainer(153811, 154393)

	-- Leviathan's Eye of Intellect -- 298801
	recipe = AddRecipe(298801, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(165, 165, 175, 180, 185)
	recipe:SetCraftedItem(168638, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_META")
	recipe:AddTrainer(153811, 154393)

	-- Leviathan's Eye Loop -- 299016
	recipe = AddRecipe(299016, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(170, 170, 180, 185, 190)
	recipe:SetCraftedItem(168701, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddTrainer(153811, 154393)

	-- Crushing Leviathan's Eye Loop -- 299017
	recipe = AddRecipe(299017, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(170, 170, 175, 175, 175)
	recipe:SetRecipeItem(168771, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(168702, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddDiscovery("DISCOVERY_JC_BFA")

	-- Ascended Leviathan's Eye Loop -- 299018
	recipe = AddRecipe(299018, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(170, 170, 175, 175, 175)
	recipe:SetRecipeItem(168772, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(168703, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddDiscovery("DISCOVERY_JC_BFA")

	-- Mass Prospect Osmenite -- 300619
	recipe = AddRecipe(300619, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(165, 165, 175, 180, 185)
	recipe:SetCraftedItem(168185, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_MATERIALS")
	recipe:AddTrainer(153811, 154393)

	-- Straddling Sage Agate -- 300756
	recipe = AddRecipe(300756, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(155, 155, 165, 170, 175)
	recipe:SetCraftedItem(169220, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddTrainer(153811, 154393)

	-- Uncanny Combatant's Intuitive Staff -- 305168
	recipe = AddRecipe(305168, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(170, 170, 180, 185, 190)
	recipe:SetCraftedItem(170318, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_STAFF")
	recipe:AddTrainer(122695, 130368)

	-- Uncanny Combatant's Intuitive Staff -- 305170
	recipe = AddRecipe(305170, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(165, 165, 165, 170, 170)
	recipe:SetRecipeItem(171159, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(170318, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_STAFF")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(142552, 142564, 161565)

	-- Uncanny Combatant's Intuitive Staff -- 305171
	recipe = AddRecipe(305171, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(165, 165, 165, 170, 170)
	recipe:SetRecipeItem(171158, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(170318, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_STAFF")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(142552, 142564, 161565)

	-- Peerless Leviathan's Eye Loop -- 305980
	recipe = AddRecipe(305980, V.BFA, Q.EPIC)
	recipe:SetSkillLevels(175, 175, 175, 175, 175)
	recipe:SetRecipeItem(171082, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(171075, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddDiscovery("DISCOVERY_JC_BFA")

	-- Awakened Leviathan's Eye Loop -- 305981
	recipe = AddRecipe(305981, V.BFA, Q.EPIC)
	recipe:SetSkillLevels(175, 175, 175, 175, 175)
	recipe:SetRecipeItem(171083, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(171076, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddDiscovery("DISCOVERY_JC_BFA")

	-- Unbound Leviathan's Eye Loop -- 305982
	recipe = AddRecipe(305982, V.BFA, Q.RARE)
	recipe:SetSkillLevels(165, 165, 175, 175, 175)
	recipe:SetRecipeItem(174365, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(171077, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddMobDrop(153910)

	-- Void Focus -- 307219
	recipe = AddRecipe(307219, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 165, 170, 175)
	recipe:SetRecipeItem(171312, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(171320, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_CREATED_ITEM")
	recipe:AddMobDrop(153910, 162245)

	-- ----------------------------------------------------------------------------
	-- Shadowlands.
	-- ----------------------------------------------------------------------------
	-- Versatile Jewel Cluster -- 311859
	recipe = AddRecipe(311859, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(173129, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_BLUE")
	recipe:AddTrainer(156670)

	-- Deadly Jewel Cluster -- 311863
	recipe = AddRecipe(311863, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(173127, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddTrainer(156670)

	-- Masterful Jewel Cluster -- 311864
	recipe = AddRecipe(311864, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(55, 55, 65, 70, 75)
	recipe:SetCraftedItem(173130, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddTrainer(156670)

	-- Quick Jewel Cluster -- 311865
	recipe = AddRecipe(311865, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(55, 55, 65, 70, 75)
	recipe:SetCraftedItem(173128, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_YELLOW")
	recipe:AddTrainer(156670)

	-- Versatile Jewel Doublet -- 311866
	recipe = AddRecipe(311866, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 15, 37, 60)
	recipe:SetCraftedItem(173123, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_BLUE")
	recipe:AddCustom("DEFAULT_RECIPE")

	-- Straddling Jewel Doublet -- 311867
	recipe = AddRecipe(311867, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 15, 37, 60)
	recipe:SetCraftedItem(173126, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddCustom("DEFAULT_RECIPE")

	-- Deadly Jewel Doublet -- 311868
	recipe = AddRecipe(311868, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(10, 10, 20, 25, 30)
	recipe:SetCraftedItem(173121, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_ORANGE")
	recipe:AddTrainer(156670)

	-- Masterful Jewel Doublet -- 311869
	recipe = AddRecipe(311869, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(10, 10, 20, 25, 30)
	recipe:SetCraftedItem(173124, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddTrainer(156670)

	-- Revitalizing Jewel Doublet -- 311870
	recipe = AddRecipe(311870, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(15, 15, 25, 30, 35)
	recipe:SetRecipeItem(183099, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(173125, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_RED")
	recipe:AddRepVendor(FAC.COURT_OF_HARVESTERS, REP.HONORED, 156822, 176066)

	-- Quick Jewel Doublet -- 311871
	recipe = AddRecipe(311871, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(15, 15, 25, 30, 35)
	recipe:SetCraftedItem(173122, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_YELLOW")
	recipe:AddTrainer(156670)

	-- Deadly Laestrite Band -- 311880
	recipe = AddRecipe(311880, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(10, 10, 20, 25, 30)
	recipe:SetCraftedItem(173138, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddTrainer(156670)

	-- Quick Laestrite Band -- 311881
	recipe = AddRecipe(311881, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(20, 20, 30, 35, 40)
	recipe:SetCraftedItem(173137, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddTrainer(156670)

	-- Masterful Laestrite Band -- 311882
	recipe = AddRecipe(311882, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(15, 15, 25, 30, 35)
	recipe:SetCraftedItem(173136, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddTrainer(156670)

	-- Versatile Laestrite Band -- 311883
	recipe = AddRecipe(311883, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(173135, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddTrainer(156670)

	-- Deadly Sinvyr Ring -- 311884
	recipe = AddRecipe(311884, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(70, 70, 80, 85, 90)
	recipe:SetCraftedItem(173134, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddTrainer(156670)

	-- Quick Oxxein Ring -- 311885
	recipe = AddRecipe(311885, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 85, 90, 95)
	recipe:SetCraftedItem(173133, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddTrainer(156670)

	-- Masterful Phaedrum Ring -- 311886
	recipe = AddRecipe(311886, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(80, 80, 90, 95, 100)
	recipe:SetCraftedItem(173132, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddTrainer(156670)

	-- Versatile Solenium Ring -- 311887
	recipe = AddRecipe(311887, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(85, 85, 95, 100, 105)
	recipe:SetCraftedItem(173131, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddTrainer(156670)

	-- Deadly Laestrite Choker -- 311902
	recipe = AddRecipe(311902, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(173143, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddTrainer(156670)

	-- Quick Laestrite Choker -- 311903
	recipe = AddRecipe(311903, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(35, 35, 45, 50, 55)
	recipe:SetCraftedItem(173142, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddTrainer(156670)

	-- Masterful Laestrite Choker -- 311904
	recipe = AddRecipe(311904, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(173141, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddTrainer(156670)

	-- Versatile Laestrite Choker -- 311905
	recipe = AddRecipe(311905, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(35, 35, 45, 50, 55)
	recipe:SetCraftedItem(173140, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddTrainer(156670)

	-- Deadly Sinvyr Necklace -- 311906
	recipe = AddRecipe(311906, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(70, 70, 80, 85, 90)
	recipe:SetCraftedItem(173147, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddTrainer(156670)

	-- Quick Oxxein Necklace -- 311907
	recipe = AddRecipe(311907, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 85, 90, 95)
	recipe:SetCraftedItem(173146, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddTrainer(156670)

	-- Masterful Phaedrum Necklace -- 311908
	recipe = AddRecipe(311908, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(80, 80, 90, 95, 100)
	recipe:SetCraftedItem(173145, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddTrainer(156670)

	-- Versatile Solenium Necklace -- 311909
	recipe = AddRecipe(311909, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(85, 85, 95, 100, 105)
	recipe:SetCraftedItem(173144, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddTrainer(156670)

	-- Mass Prospect Laestrite -- 311948
	recipe = AddRecipe(311948, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(20, 20, 30, 35, 40)
	recipe:SetCraftedItem(171828, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_MATERIALS")
	recipe:AddTrainer(156670)

	-- Mass Prospect Solenium -- 311949
	recipe = AddRecipe(311949, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(30, 30, 40, 45, 50)
	recipe:SetCraftedItem(171829, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_MATERIALS")
	recipe:AddTrainer(156670)

	-- Mass Prospect Oxxein -- 311950
	recipe = AddRecipe(311950, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(30, 30, 40, 45, 50)
	recipe:SetCraftedItem(171830, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_MATERIALS")
	recipe:AddTrainer(156670)

	-- Mass Prospect Phaedrum -- 311951
	recipe = AddRecipe(311951, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(30, 30, 40, 45, 50)
	recipe:SetCraftedItem(171831, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_MATERIALS")
	recipe:AddTrainer(156670)

	-- Mass Prospect Sinvyr -- 311952
	recipe = AddRecipe(311952, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(30, 30, 40, 45, 50)
	recipe:SetCraftedItem(171832, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_MATERIALS")
	recipe:AddTrainer(156670)

	-- Mass Prospect Elethium -- 311953
	recipe = AddRecipe(311953, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(40, 40, 50, 55, 60)
	recipe:SetCraftedItem(171833, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_MATERIALS")
	recipe:AddTrainer(156670)

	-- Shadowghast Ring -- 327920
	recipe = AddRecipe(327920, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 100, 100, 100)
	recipe:SetCraftedItem(178926, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddTrainer(156670)

	-- Shadowghast Necklace -- 327921
	recipe = AddRecipe(327921, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 100, 100, 100)
	recipe:SetCraftedItem(178927, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddTrainer(156670)

	-- Shadowghast Ring -- 332039
	recipe = AddRecipe(332039, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 100, 100, 100)
	recipe:SetCraftedItem(178926, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddDiscovery("DISCOVERY_SHADOWLANDS")

	-- Shadowghast Necklace -- 332040
	recipe = AddRecipe(332040, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 100, 100, 100)
	recipe:SetCraftedItem(178927, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddDiscovery("DISCOVERY_SHADOWLANDS")

	-- Shadowghast Ring -- 332074
	recipe = AddRecipe(332074, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 100, 100, 100)
	recipe:SetCraftedItem(178926, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddDiscovery("DISCOVERY_SHADOWLANDS")

	-- Shadowghast Necklace -- 332075
	recipe = AddRecipe(332075, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 100, 100, 100)
	recipe:SetCraftedItem(178927, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddDiscovery("DISCOVERY_SHADOWLANDS")

	-- Crown of the Righteous -- 334548
	recipe = AddRecipe(334548, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 10, 15, 20)
	recipe:SetCraftedItem(180760, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_HEAD")
	recipe:AddCustom("CLOUDWALKERS_COFFER")

	-- Shadowghast Necklace -- 338977
	recipe = AddRecipe(338977, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 100, 100, 100)
	recipe:SetCraftedItem(178927, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_NECK")
	recipe:AddDiscovery("DISCOVERY_SHADOWLANDS")

	-- Shadowghast Ring -- 338978
	recipe = AddRecipe(338978, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 100, 100, 100)
	recipe:SetCraftedItem(178926, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_RING")
	recipe:AddDiscovery("DISCOVERY_SHADOWLANDS")

	-- Novice Crafter's Mark -- 343693
	recipe = AddRecipe(343693, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(70, 70, 80, 85, 90)
	recipe:SetCraftedItem(183942, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_MATERIALS")
	recipe:AddTrainer(156670)

	-- Crafter's Mark of the Chained Isle -- 343694
	recipe = AddRecipe(343694, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(200, 200, 200, 200, 200)
	recipe:SetRecipeItem(186470, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(173384, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_MATERIALS")
	recipe:AddRepVendor(FAC.THE_ARCHIVISTS_CODEX, REP.REVERED, 178257)

	-- Crafter's Mark III -- 343695
	recipe = AddRecipe(343695, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 190, 192, 195)
	recipe:SetRecipeItem(183868, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(173383, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_MATERIALS")
	recipe:AddRepVendor(FAC.DEATHS_ADVANCE, REP.HONORED, 179321)

	-- Crafter's Mark II -- 343696
	recipe = AddRecipe(343696, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 110, 115, 120)
	recipe:SetCraftedItem(173382, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_MATERIALS")
	recipe:AddRepVendor(FAC.THE_AVOWED, REP.REVERED, 173705)

	-- Crafter's Mark I -- 343697
	recipe = AddRecipe(343697, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(45, 45, 55, 60, 65)
	recipe:SetCraftedItem(173381, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_MATERIALS")
	recipe:AddTrainer(156670)

	-- Vestige of Origins -- 352443
	recipe = AddRecipe(352443, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 100, 100, 100)
	recipe:SetCraftedItem(185960, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_MATERIALS")
	recipe:AddRepVendor(FAC.DEATHS_ADVANCE, REP.HONORED, 179321)

	-- Porous Stone Statue -- 355187
	recipe = AddRecipe(355187, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetRecipeItem(186994, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(186981, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_CREATED_ITEM")
	recipe:AddCustom("RELIC_CACHE")

	-- Shaded Stone Statue -- 355189
	recipe = AddRecipe(355189, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 100, 100, 100)
	recipe:SetRecipeItem(186994, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(186982, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_CREATED_ITEM")
	recipe:AddCustom("RIFTBOUND_CACHE")

-- 9.2 Recipes

	-- Mass Prospect Progenium -- 359492
	recipe = AddRecipe(359492, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(40, 40, 50, 55, 60)
	recipe:SetCraftedItem(187700, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_MATERIALS")
	recipe:AddTrainer(156670)

	-- Crafter's Mark IV -- 359663
	recipe = AddRecipe(359663, V.SHA, Q.EPIC)
	recipe:SetSkillLevels(201, 201, 201, 201, 201)
	recipe:SetRecipeItem(187750, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(187741, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_CREATED_ITEM")
	recipe:AddRepVendor(FAC.THE_ENLIGHTENED, REP.HONORED, 182257)

	-- Crafter's Mark of the First Ones -- 359672
	recipe = AddRecipe(359672, V.SHA, Q.EPIC)
	recipe:SetSkillLevels(201, 201, 201, 201, 201)
	recipe:SetRecipeItem(187749, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(187742, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_CREATED_ITEM")
	recipe:AddRepVendor(FAC.THE_ENLIGHTENED, REP.HONORED, 182257)

	-- Vestige of the Eternal -- 359701
	recipe = AddRecipe(359701, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 203, 203, 203)
	recipe:SetRecipeItem(187785, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(187784, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_CREATED_ITEM")
	recipe:AddRepVendor(FAC.THE_ENLIGHTENED, REP.HONORED, 182257)

	-- Aealic Harmonizing Stone -- 360016
	recipe = AddRecipe(360016, V.SHA, Q.RARE)
	recipe:SetSkillLevels(100, 100, 100, 110, 120)
	recipe:SetRecipeItem(187830, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(187829, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_CREATED_ITEM")
	recipe:AddMobDrop(181249)

	-- Devourer Essence Stone -- 360317
	recipe = AddRecipe(360317, V.SHA, Q.RARE)
	recipe:SetSkillLevels(100, 100, 100, 110, 120)
	recipe:SetRecipeItem(187847, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(187849, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("JEWELCRAFTING_CREATED_ITEM")
	recipe:AddMobDrop(183516, 184413)

	self.InitializeRecipes = nil
end
