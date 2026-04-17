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

	-- Timeless Shadow Draenite -- 28925
	recipe = AddRecipe(28925, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(23108, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(15501, 18751, 18774, 19063, 19539, 19775, 33614, 33637, 33680, 46675, 93527, 100538)

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
	recipe = AddRecipe(62941, V.TBC, Q.UNCOMMON)
	recipe:SetSkillLevels(300, 300, 310, 315, 320)
	recipe:SetCraftedItem(45054, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_MATERIALS")
	recipe:AddTrainer(5388, 15501, 18751, 19775, 19778, 44582, 46675, 52586, 52587, 52645, 52657, 93527, 100538)

	-- Lustrous Azure Moonstone -- 28957
	recipe = AddRecipe(28957, V.TBC, Q.UNCOMMON)
	recipe:SetSkillLevels(325, 325, 325, 340, 355)
	recipe:SetRecipeItem(23155, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(23121, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_BLUE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddRepVendor(FAC.THE_CONSORTIUM, REP.HONORED, 20242, 23007)

	-- Lustrous Star of Elune -- 31094
	recipe = AddRecipe(31094, V.TBC, Q.RARE)
	recipe:SetSkillLevels(350, 350, 350, 365, 380)
	recipe:SetRecipeItem(24201, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(24037, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_BLUE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.OUTLAND)

	-- Lustrous Empyrean Sapphire -- 39717
	recipe = AddRecipe(39717, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(375, 375, 375, 380, 385)
	recipe:SetRecipeItem(32288, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(32202, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_BLUE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddRepVendor(FAC.SHATTERED_SUN_OFFENSIVE, REP.FRIENDLY, 25950, 27666)
	recipe:AddRepVendor(FAC.THE_SCALE_OF_THE_SANDS, REP.FRIENDLY, 23437)

	-- Enduring Deep Peridot -- 28918
	recipe = AddRecipe(28918, V.TBC, Q.UNCOMMON)
	recipe:SetSkillLevels(315, 315, 315, 335, 355)
	recipe:SetRecipeItem(23142, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(23105, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddFilters(F.TANK)
	recipe:AddRepVendor(FAC.HONOR_HOLD, REP.FRIENDLY, 17657)
	recipe:AddRepVendor(FAC.THRALLMAR, REP.FRIENDLY, 17585)

	-- Enduring Talasite -- 31110
	recipe = AddRecipe(31110, V.TBC, Q.RARE)
	recipe:SetSkillLevels(350, 350, 350, 365, 380)
	recipe:SetRecipeItem(24217, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(24062, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddFilters(F.TANK)
	recipe:AddWorldDrop(Z.OUTLAND)

	-- Enduring Seaspray Emerald -- 39739
	recipe = AddRecipe(39739, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(375, 375, 375, 380, 385)
	recipe:SetRecipeItem(35252, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(32223, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_GREEN")
	recipe:AddFilters(F.TANK)
	recipe:AddRepVendor(FAC.SHATTERED_SUN_OFFENSIVE, REP.REVERED, 25950, 27666)
	recipe:AddRepVendor(FAC.THE_SCALE_OF_THE_SANDS, REP.REVERED, 23437)

	-- Balanced Shadow Draenite -- 39455
	recipe = AddRecipe(39455, V.TBC, Q.UNCOMMON)
	recipe:SetSkillLevels(325, 325, 325, 340, 355)
	recipe:SetRecipeItem(31871, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(31862, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.DPS)
	recipe:AddWorldDrop(Z.OUTLAND)

	-- Balanced Nightseye -- 39463
	recipe = AddRecipe(39463, V.TBC, Q.RARE)
	recipe:SetSkillLevels(325, 325, 325, 340, 355)
	recipe:SetRecipeItem(31876, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(31863, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.DPS)
	recipe:AddWorldDrop(Z.OUTLAND)

	-- Balanced Shadowsong Amethyst -- 39729
	recipe = AddRecipe(39729, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(375, 375, 375, 380, 385)
	recipe:SetRecipeItem(35238, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(32223, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.DPS)
	recipe:AddRepVendor(FAC.SHATTERED_SUN_OFFENSIVE, REP.REVERED, 25950, 27666)
	recipe:AddRepVendor(FAC.THE_SCALE_OF_THE_SANDS, REP.REVERED, 23437)

	-- Infused Shadow Draenite -- 39458
	recipe = AddRecipe(39458, V.TBC, Q.UNCOMMON)
	recipe:SetSkillLevels(325, 325, 325, 340, 355)
	recipe:SetRecipeItem(31872, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(31864, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.OUTLAND)

	-- Infused Nightseye -- 39462
	recipe = AddRecipe(39462, V.TBC, Q.RARE)
	recipe:SetSkillLevels(350, 350, 350, 365, 380)
	recipe:SetRecipeItem(31877, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(31865, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.OUTLAND)

	-- Infused Shadowsong Amethyst -- 39730
	recipe = AddRecipe(39730, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(375, 375, 375, 380, 385)
	recipe:SetRecipeItem(35240, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(32214, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddRepVendor(FAC.SHATTERED_SUN_OFFENSIVE, REP.HONORED, 25950, 27666)
	recipe:AddRepVendor(FAC.THE_SCALE_OF_THE_SANDS, REP.HONORED, 23437)

	-- Royal Shadow Draenite -- 28927
	recipe = AddRecipe(28927, V.TBC, Q.UNCOMMON)
	recipe:SetSkillLevels(305, 305, 305, 325, 345)
	recipe:SetRecipeItem(23145, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(23109, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddRepVendor(FAC.THE_ALDOR, REP.HONORED, 19321)

	-- Royal Nightseye -- 31105
	recipe = AddRecipe(31105, V.TBC, Q.RARE)
	recipe:SetSkillLevels(350, 350, 350, 365, 380)
	recipe:SetRecipeItem(24212, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(24057, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.OUTLAND)

	-- Royal Shadowsong Amethyst -- 39732
	recipe = AddRecipe(39732, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(375, 375, 375, 380, 385)
	recipe:SetRecipeItem(35241, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(32216, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PURPLE")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddRepVendor(FAC.SHATTERED_SUN_OFFENSIVE, REP.REVERED, 25950, 27666)
	recipe:AddRepVendor(FAC.THE_SCALE_OF_THE_SANDS, REP.REVERED, 23437)

	-- Bright Living Ruby -- 31089
	recipe = AddRecipe(31089, V.TBC, Q.UNCOMMON)
	recipe:SetSkillLevels(350, 350, 350, 365, 380)
	recipe:SetRecipeItem(24192, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(24031, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_RED")
	recipe:AddFilters(F.DPS)
	recipe:AddWorldDrop(Z.OUTLAND)

	-- Bright Blood Garnet -- 34590
	recipe = AddRecipe(34590, V.TBC, Q.RARE)
	recipe:SetSkillLevels(305, 305, 305, 325, 345)
	recipe:SetCraftedItem(28595, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_RED")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(33614, 26982, 28701, 18774, 26997, 18751, 26915, 19539, 19063, 33590, 33680, 26960)

	-- Bright Crimson Spinel -- 39712
	recipe = AddRecipe(39712, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(375, 375, 375, 380, 385)
	recipe:SetRecipeItem(35245, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(32197, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_RED")
	recipe:AddFilters(F.DPS)
	recipe:AddRepVendor(FAC.SHATTERED_SUN_OFFENSIVE, REP.FRIENDLY, 25950, 27666)
	recipe:AddRepVendor(FAC.THE_SCALE_OF_THE_SANDS, REP.FRIENDLY, 23437)


	-- Teardrop Blood Garnet -- 28903
	recipe = AddRecipe(28903, V.TBC, Q.UNCOMMON)
	recipe:SetSkillLevels(300, 300, 300, 320, 340)
	recipe:SetCraftedItem(23094, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_RED")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(33614, 26982, 28701, 18774, 26997, 18751, 26915, 19539, 19063, 33590, 33680, 26960)


	-- Teardrop Living Ruby -- 31087
	recipe = AddRecipe(31087, V.TBC, Q.RARE)
	recipe:SetSkillLevels(350, 350, 350, 365, 380)
	recipe:SetRecipeItem(24195, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(24029, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_RED")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.OUTLAND)

	-- Teardrop Crimson Spinel -- 39710
	recipe = AddRecipe(39710, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(375, 375, 375, 380, 385)
	recipe:SetRecipeItem(35250, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(32195, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_RED")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddRepVendor(FAC.SHATTERED_SUN_OFFENSIVE, REP.FRIENDLY, 25950, 27666)
	recipe:AddRepVendor(FAC.THE_SCALE_OF_THE_SANDS, REP.FRIENDLY, 23437)

	-- Gleaming Golden Draenite -- 28944
	recipe = AddRecipe(28944, V.TBC, Q.UNCOMMON)
	recipe:SetSkillLevels(305, 305, 305, 325, 345)
	recipe:SetRecipeItem(23149, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(23114, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_YELLOW")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddRepVendor(FAC.THE_ALDOR, REP.FRIENDLY, 19321)

	-- Gleaming Dawnstone -- 31099
	recipe = AddRecipe(31099, V.TBC, Q.RARE)
	recipe:SetSkillLevels(350, 350, 350, 365, 380)
	recipe:SetRecipeItem(24206, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(24050, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_YELLOW")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.OUTLAND)

	-- Gleaming Lionseye -- 39722
	recipe = AddRecipe(39722, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(375, 375, 375, 380, 385)
	recipe:SetRecipeItem(35256, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(32207, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_YELLOW")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddRepVendor(FAC.SHATTERED_SUN_OFFENSIVE, REP.FRIENDLY, 25950, 27666)
	recipe:AddRepVendor(FAC.THE_SCALE_OF_THE_SANDS, REP.FRIENDLY, 23437)

	-- Great Golden Draenite -- 39451
	recipe = AddRecipe(39451, V.TBC, Q.UNCOMMON)
	recipe:SetSkillLevels(325, 325, 325, 340, 355)
	recipe:SetRecipeItem(31870, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(31860, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_YELLOW")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.OUTLAND)

	-- Great Dawnstone -- 39452
	recipe = AddRecipe(39452, V.TBC, Q.RARE)
	recipe:SetSkillLevels(325, 325, 325, 340, 355)
	recipe:SetRecipeItem(31875, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(31861, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_YELLOW")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.OUTLAND)

	-- Great Lionseye -- 39725
	recipe = AddRecipe(39725, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(375, 375, 375, 380, 385)
	recipe:SetRecipeItem(35257, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(32210, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_YELLOW")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddRepVendor(FAC.SHATTERED_SUN_OFFENSIVE, REP.EXALTED, 25950, 27666)
	recipe:AddWorldDrop(Z.MOUNT_HYJAL)

	-- Thick Golden Draenite -- 28947
	recipe = AddRecipe(28947, V.TBC, Q.UNCOMMON)
	recipe:SetSkillLevels(315, 315, 315, 335, 355)
	recipe:SetRecipeItem(23150, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(23115, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_YELLOW")
	recipe:AddFilters(F.TANK)
	recipe:AddRepVendor(FAC.SHATTERED_SUN_OFFENSIVE, REP.EXALTED, 25950, 27666)

	-- Thick Dawnstone -- 31100
	recipe = AddRecipe(31100, V.TBC, Q.RARE)
	recipe:SetSkillLevels(350, 350, 350, 365, 380)
	recipe:SetRecipeItem(24207, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(24052, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_YELLOW")
	recipe:AddFilters(F.TANK)
	recipe:AddWorldDrop(Z.OUTLAND)

	-- Thick Lionseye -- 39723
	recipe = AddRecipe(39723, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(375, 375, 375, 380, 385)
	recipe:SetRecipeItem(35261, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(32208, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_YELLOW")
	recipe:AddFilters(F.TANK)
	recipe:AddRepVendor(FAC.SHATTERED_SUN_OFFENSIVE, REP.FRIENDLY, 25950, 27666)
	recipe:AddRepVendor(FAC.THE_SCALE_OF_THE_SANDS, REP.FRIENDLY, 23437)


	-- ----------------------------------------------------------------------------
	-- Wrath of the Lich King.
	-- ----------------------------------------------------------------------------
	-- Bold Scarlet Ruby -- 53830
	recipe = AddRecipe(53830, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(390, 390, 410, 425, 440)
	recipe:SetRecipeItem(41576, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(39996, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("JEWELCRAFTING_GEM_PUR")
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

	self.InitializeRecipes = nil
end
