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
	-- Handstitched Leather Boots -- 2149
	recipe = AddRecipe(2149, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 40, 55, 70)
	recipe:SetCraftedItem(2302, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddCustom("DEFAULT_RECIPE")

	-- Light Armor Kit -- 2152
	recipe = AddRecipe(2152, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 30, 45, 60)
	recipe:SetCraftedItem(2304, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_ITEM_ENHANCEMENT")
	recipe:AddCustom("DEFAULT_RECIPE")

	-- Handstitched Leather Pants -- 2153
	recipe = AddRecipe(2153, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(15, 15, 45, 60, 75)
	recipe:SetCraftedItem(2303, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddTrainer(1385, 1632, 3007, 3069, 3365, 3549, 3605, 3967, 4212, 4588, 5127, 5564, 5784, 8153, 11097, 11098, 16278, 16688, 16728, 17442, 18754, 18771, 21087, 47384, 47396, 47400, 47418, 47419, 47421, 47431, 48619, 49885, 53436, 57620, 65043, 66354, 85920, 86032, 93522, 93523, 98931, 98948, 98964)

	-- Fine Leather Boots -- 2158
	recipe = AddRecipe(2158, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(90, 90, 120, 135, 150)
	recipe:SetRecipeItem(2406, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(2307, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddFilters(F.DPS)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Fine Leather Cloak -- 2159
	recipe = AddRecipe(2159, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(85, 85, 105, 120, 135)
	recipe:SetCraftedItem(2308, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_BACK")
	recipe:AddTrainer(1385, 1632, 3007, 3069, 3365, 3549, 3605, 3967, 4212, 4588, 5127, 5564, 5784, 8153, 11097, 11098, 16278, 16688, 16728, 17442, 18754, 18771, 21087, 49885, 53436, 66354, 98948, 98964)

	-- Embossed Leather Vest -- 2160
	recipe = AddRecipe(2160, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(40, 40, 70, 85, 100)
	recipe:SetCraftedItem(2300, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddTrainer(1385, 1632, 3007, 3069, 3365, 3549, 3605, 3967, 4212, 4588, 5127, 5564, 5784, 8153, 11097, 11098, 16278, 16688, 16728, 17442, 18754, 18771, 21087, 47384, 47396, 47400, 47418, 47419, 47421, 47431, 48619, 49885, 53436, 57620, 65043, 66354, 85920, 86032, 93522, 93523, 98931, 98948, 98964)

	-- Embossed Leather Boots -- 2161
	recipe = AddRecipe(2161, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(55, 55, 85, 100, 115)
	recipe:SetCraftedItem(2309, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(1385, 1632, 3007, 3069, 3365, 3549, 3605, 3967, 4212, 4588, 5127, 5564, 5784, 8153, 11097, 11098, 16278, 16688, 16728, 17442, 18754, 18771, 21087, 47384, 47396, 47400, 47418, 47419, 47421, 47431, 48619, 49885, 53436, 57620, 65043, 66354, 85920, 86032, 93522, 93523, 98931, 98948, 98964)

	-- Embossed Leather Cloak -- 2162
	recipe = AddRecipe(2162, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(60, 60, 90, 105, 120)
	recipe:SetCraftedItem(2310, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_BACK")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(1385, 1632, 3007, 3069, 3365, 3549, 3605, 3967, 4212, 4588, 5127, 5564, 5784, 8153, 11097, 11098, 16278, 16688, 16728, 17442, 18754, 18771, 21087, 47384, 47396, 47400, 47418, 47419, 47421, 47431, 48619, 49885, 53436, 57620, 65043, 66354, 85920, 86032, 93522, 93523, 98931, 98948, 98964)

	-- White Leather Jerkin -- 2163
	recipe = AddRecipe(2163, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(60, 60, 90, 105, 120)
	recipe:SetRecipeItem(2407, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(2311, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.DPS)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Fine Leather Gloves -- 2164
	recipe = AddRecipe(2164, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(75, 75, 105, 120, 135)
	recipe:SetRecipeItem(2408, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(2312, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Medium Armor Kit -- 2165
	recipe = AddRecipe(2165, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 115, 122, 130)
	recipe:SetCraftedItem(2313, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_ITEM_ENHANCEMENT")
	recipe:AddTrainer(1385, 1632, 3007, 3069, 3365, 3549, 3605, 3967, 4212, 4588, 5127, 5564, 5784, 8153, 11097, 11098, 16278, 16688, 16728, 17442, 18754, 18771, 21087, 49885, 53436, 66354, 98948, 98964)

	-- Toughened Leather Armor -- 2166
	recipe = AddRecipe(2166, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(120, 120, 145, 157, 170)
	recipe:SetCraftedItem(2314, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddTrainer(1385, 1632, 3007, 3069, 3365, 3549, 3605, 3967, 4212, 4588, 5127, 5564, 5784, 8153, 11097, 11098, 16278, 16688, 16728, 17442, 18754, 18771, 21087, 49885, 53436, 66354, 98948, 98964)

	-- Dark Leather Boots -- 2167
	recipe = AddRecipe(2167, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 125, 137, 150)
	recipe:SetCraftedItem(2315, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(1385, 1632, 3007, 3069, 3365, 3549, 3605, 3967, 4212, 4588, 5127, 5564, 5784, 8153, 11097, 11098, 16278, 16688, 16728, 17442, 18754, 18771, 21087, 49885, 53436, 66354, 98948, 98964)

	-- Dark Leather Cloak -- 2168
	recipe = AddRecipe(2168, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(110, 110, 135, 147, 160)
	recipe:SetCraftedItem(2316, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_BACK")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(1385, 1632, 3007, 3069, 3365, 3549, 3605, 3967, 4212, 4588, 5127, 5564, 5784, 8153, 11097, 11098, 16278, 16688, 16728, 17442, 18754, 18771, 21087, 49885, 53436, 66354, 98948, 98964)

	-- Dark Leather Tunic -- 2169
	recipe = AddRecipe(2169, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(100, 100, 125, 137, 150)
	recipe:SetRecipeItem(2409, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(2317, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.DPS)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Light Leather -- 2881
	recipe = AddRecipe(2881, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 20, 30, 40)
	recipe:SetCraftedItem(2318, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_MATERIALS")
	recipe:AddCustom("DEFAULT_RECIPE")

	-- Handstitched Leather Belt -- 3753
	recipe = AddRecipe(3753, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 55, 70, 85)
	recipe:SetCraftedItem(4237, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddTrainer(1385, 1632, 3007, 3069, 3365, 3549, 3605, 3967, 4212, 4588, 5127, 5564, 5784, 8153, 11097, 11098, 16278, 16688, 16728, 17442, 18754, 18771, 21087, 47384, 47396, 47400, 47418, 47419, 47421, 47431, 48619, 49885, 53436, 57620, 65043, 66354, 85920, 86032, 93522, 93523, 98931, 98948, 98964)

	-- Embossed Leather Gloves -- 3756
	recipe = AddRecipe(3756, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(55, 55, 85, 100, 115)
	recipe:SetCraftedItem(4239, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(1385, 1632, 3007, 3069, 3365, 3549, 3605, 3967, 4212, 4588, 5127, 5564, 5784, 8153, 11097, 11098, 16278, 16688, 16728, 17442, 18754, 18771, 21087, 47384, 47396, 47400, 47418, 47419, 47421, 47431, 48619, 49885, 53436, 57620, 65043, 66354, 85920, 86032, 93522, 93523, 98931, 98948, 98964)

	-- Embossed Leather Pants -- 3759
	recipe = AddRecipe(3759, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 105, 120, 135)
	recipe:SetCraftedItem(4242, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(1385, 1632, 3007, 3069, 3365, 3549, 3605, 3967, 4212, 4588, 5127, 5564, 5784, 8153, 11097, 11098, 16278, 16688, 16728, 17442, 18754, 18771, 21087, 47384, 47396, 47400, 47418, 47419, 47421, 47431, 48619, 49885, 53436, 57620, 65043, 66354, 85920, 86032, 93522, 93523, 98931, 98948, 98964)

	-- Hillman's Cloak -- 3760
	recipe = AddRecipe(3760, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(150, 150, 170, 180, 190)
	recipe:SetCraftedItem(3719, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_BACK")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(1385, 1632, 3007, 3069, 3365, 3549, 3605, 3967, 4212, 4588, 5127, 5564, 5784, 8153, 11097, 11098, 16278, 16688, 16728, 17442, 18754, 18771, 21087, 49885, 53436, 66354, 98948, 98964)

	-- Fine Leather Tunic -- 3761
	recipe = AddRecipe(3761, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(85, 85, 115, 130, 145)
	recipe:SetCraftedItem(4243, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(1385, 1632, 3007, 3069, 3365, 3549, 3605, 3967, 4212, 4588, 5127, 5564, 5784, 8153, 11097, 11098, 16278, 16688, 16728, 17442, 18754, 18771, 21087, 49885, 53436, 66354, 98948, 98964)

	-- Hillman's Leather Vest -- 3762
	recipe = AddRecipe(3762, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(100, 100, 125, 137, 150)
	recipe:SetRecipeItem(4293, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(4244, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Fine Leather Belt -- 3763
	recipe = AddRecipe(3763, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(80, 80, 110, 125, 140)
	recipe:SetCraftedItem(4246, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddTrainer(1385, 1632, 3007, 3069, 3365, 3549, 3605, 3967, 4212, 4588, 5127, 5564, 5784, 8153, 11097, 11098, 16278, 16688, 16728, 17442, 18754, 18771, 21087, 49885, 53436, 66354, 98948, 98964)

	-- Hillman's Leather Gloves -- 3764
	recipe = AddRecipe(3764, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(145, 145, 170, 182, 195)
	recipe:SetCraftedItem(4247, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(1385, 1632, 3007, 3069, 3365, 3549, 3605, 3967, 4212, 4588, 5127, 5564, 5784, 8153, 11097, 11098, 16278, 16688, 16728, 17442, 18754, 18771, 21087, 49885, 53436, 66354, 98948, 98964)

	-- Dark Leather Gloves -- 3765
	recipe = AddRecipe(3765, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(120, 120, 155, 167, 180)
	recipe:SetRecipeItem(7360, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(4248, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.DPS)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Dark Leather Belt -- 3766
	recipe = AddRecipe(3766, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(125, 125, 150, 162, 175)
	recipe:SetCraftedItem(4249, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(1385, 1632, 3007, 3069, 3365, 3549, 3605, 3967, 4212, 4588, 5127, 5564, 5784, 8153, 11097, 11098, 16278, 16688, 16728, 17442, 18754, 18771, 21087, 49885, 53436, 66354, 98948, 98964)

	-- Hillman's Belt -- 3767
	recipe = AddRecipe(3767, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(120, 120, 145, 157, 170)
	recipe:SetRecipeItem(4294, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(4250, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Hillman's Shoulders -- 3768
	recipe = AddRecipe(3768, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(130, 130, 155, 167, 180)
	recipe:SetCraftedItem(4251, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_SHOULDER")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(1385, 1632, 3007, 3069, 3365, 3549, 3605, 3967, 4212, 4588, 5127, 5564, 5784, 8153, 11097, 11098, 16278, 16688, 16728, 17442, 18754, 18771, 21087, 49885, 53436, 66354, 98948, 98964)

	-- Dark Leather Shoulders -- 3769
	recipe = AddRecipe(3769, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(140, 140, 165, 177, 190)
	recipe:SetRecipeItem(4296, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(4252, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_SHOULDER")
	recipe:AddFilters(F.DPS)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Toughened Leather Gloves -- 3770
	recipe = AddRecipe(3770, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(135, 135, 160, 172, 185)
	recipe:SetCraftedItem(4253, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(1385, 1632, 3007, 3069, 3365, 3549, 3605, 3967, 4212, 4588, 5127, 5564, 5784, 8153, 11097, 11098, 16278, 16688, 16728, 17442, 18754, 18771, 21087, 49885, 53436, 66354, 98948, 98964)

	-- Barbaric Gloves -- 3771
	recipe = AddRecipe(3771, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(150, 150, 170, 180, 190)
	recipe:SetRecipeItem(4297, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(4254, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.DPS)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Green Leather Armor -- 3772
	recipe = AddRecipe(3772, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(155, 155, 175, 185, 195)
	recipe:SetRecipeItem(7613, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(4255, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.DPS, F.TANK)
	recipe:AddVendor(2679)
	recipe:AddLimitedVendor(2698, 1)

	-- Guardian Armor -- 3773
	recipe = AddRecipe(3773, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(175, 175, 195, 205, 215)
	recipe:SetRecipeItem(4299, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(4256, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Green Leather Belt -- 3774
	recipe = AddRecipe(3774, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(160, 160, 180, 190, 200)
	recipe:SetCraftedItem(4257, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddFilters(F.DPS, F.TANK)
	recipe:AddTrainer(1385, 1632, 3007, 3069, 3365, 3549, 3605, 3967, 4212, 4588, 5127, 5564, 5784, 8153, 11097, 11098, 16278, 16688, 16728, 17442, 18754, 18771, 21087, 53436, 66354, 98948, 98964)

	-- Guardian Belt -- 3775
	recipe = AddRecipe(3775, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(170, 170, 190, 200, 210)
	recipe:SetRecipeItem(4298, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(4258, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Green Leather Bracers -- 3776
	recipe = AddRecipe(3776, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(180, 180, 200, 210, 220)
	recipe:SetCraftedItem(4259, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddFilters(F.DPS, F.TANK)
	recipe:AddTrainer(1385, 1632, 3007, 3069, 3365, 3549, 3605, 3967, 4212, 4588, 5127, 5564, 5784, 8153, 11097, 11098, 16278, 16688, 16728, 17442, 18754, 18771, 21087, 53436, 66354, 98948, 98964)

	-- Guardian Leather Bracers -- 3777
	recipe = AddRecipe(3777, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(195, 195, 215, 225, 235)
	recipe:SetRecipeItem(4300, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(4260, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Gem-studded Leather Belt -- 3778
	recipe = AddRecipe(3778, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(185, 185, 205, 215, 225)
	recipe:SetRecipeItem(14635, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(4262, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddLimitedVendor(2699, 1)

	-- Barbaric Belt -- 3779
	recipe = AddRecipe(3779, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(200, 200, 220, 230, 240)
	recipe:SetRecipeItem(4301, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(4264, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddFilters(F.DPS, F.TANK)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Heavy Armor Kit -- 3780
	recipe = AddRecipe(3780, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(150, 150, 170, 180, 190)
	recipe:SetCraftedItem(4265, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_ITEM_ENHANCEMENT")
	recipe:AddTrainer(1385, 1632, 3007, 3069, 3365, 3549, 3605, 3967, 4212, 4588, 5127, 5564, 5784, 8153, 11097, 11098, 16278, 16688, 16728, 17442, 18754, 18771, 21087, 49885, 53436, 66354, 98948, 98964)

	-- Cured Light Hide -- 3816
	recipe = AddRecipe(3816, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(35, 35, 55, 65, 75)
	recipe:SetCraftedItem(4231, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_MATERIALS")
	recipe:AddTrainer(1385, 1632, 3007, 3069, 3365, 3549, 3605, 3967, 4212, 4588, 5127, 5564, 5784, 8153, 11097, 11098, 16278, 16688, 16728, 17442, 18754, 18771, 21087, 47384, 47396, 47400, 47418, 47419, 47421, 47431, 48619, 49885, 53436, 57620, 65043, 66354, 85920, 86032, 93522, 93523, 98931, 98948, 98964)

	-- Cured Medium Hide -- 3817
	recipe = AddRecipe(3817, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 115, 122, 130)
	recipe:SetCraftedItem(4233, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_MATERIALS")
	recipe:AddTrainer(1385, 1632, 3007, 3069, 3365, 3549, 3605, 3967, 4212, 4588, 5127, 5564, 5784, 8153, 11097, 11098, 16278, 16688, 16728, 17442, 18754, 18771, 21087, 49885, 53436, 66354, 98948, 98964)

	-- Cured Heavy Hide -- 3818
	recipe = AddRecipe(3818, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(150, 150, 160, 165, 170)
	recipe:SetCraftedItem(4236, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_MATERIALS")
	recipe:AddTrainer(1385, 1632, 3007, 3069, 3365, 3549, 3605, 3967, 4212, 4588, 5127, 5564, 5784, 8153, 11097, 11098, 16278, 16688, 16728, 17442, 18754, 18771, 21087, 49885, 53436, 66354, 98948, 98964)

	-- Raptor Hide Harness -- 4096
	recipe = AddRecipe(4096, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(165, 165, 185, 195, 205)
	recipe:SetRecipeItem(13287, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(4455, "BIND_ON_EQUIP")
	recipe:SetRequiredFaction("Horde")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddLimitedVendor(2819, 1)

	-- Raptor Hide Belt -- 4097
	recipe = AddRecipe(4097, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(165, 165, 185, 195, 205)
	recipe:SetRecipeItem(13288, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(4456, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddFilters(F.DPS)
	recipe:AddVendor(2816)

	-- Kodo Hide Bag -- 5244
	recipe = AddRecipe(5244, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(40, 40, 70, 85, 100)
	recipe:SetRecipeItem(5083, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(5081, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_BAG")
	recipe:AddQuest(769)

	-- Barbaric Harness -- 6661
	recipe = AddRecipe(6661, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(190, 190, 210, 220, 230)
	recipe:SetCraftedItem(5739, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(1385, 1632, 3007, 3069, 3365, 3549, 3605, 3967, 4212, 4588, 5127, 5564, 5784, 8153, 11097, 11098, 16278, 16688, 16728, 17442, 18754, 18771, 21087, 53436, 66354, 98948, 98964)

	-- Murloc Scale Belt -- 6702
	recipe = AddRecipe(6702, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(90, 90, 120, 135, 150)
	recipe:SetRecipeItem(5786, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(5780, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddFilters(F.DPS)
	recipe:AddMobDrop(1732, 3385)
	recipe:AddVendor(843, 3556)

	-- Murloc Scale Breastplate -- 6703
	recipe = AddRecipe(6703, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(95, 95, 125, 140, 155)
	recipe:SetRecipeItem(5787, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(5781, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.DPS)
	recipe:AddMobDrop(657, 3386)
	recipe:AddVendor(843, 3556)

	-- Thick Murloc Armor -- 6704
	recipe = AddRecipe(6704, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(170, 170, 190, 200, 210)
	recipe:SetRecipeItem(5788, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(5782, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.DPS)
	recipe:AddMobDrop(938, 1160)
	recipe:AddLimitedVendor(2393, 1, 2846, 1)

	-- Murloc Scale Bracers -- 6705
	recipe = AddRecipe(6705, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(190, 190, 210, 220, 230)
	recipe:SetRecipeItem(5789, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(5783, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddFilters(F.DPS)
	recipe:AddMobDrop(1561)
	recipe:AddLimitedVendor(4897, 1)

	-- Handstitched Leather Vest -- 7126
	recipe = AddRecipe(7126, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 40, 55, 70)
	recipe:SetCraftedItem(5957, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddCustom("DEFAULT_RECIPE")

	-- Fine Leather Pants -- 7133
	recipe = AddRecipe(7133, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(105, 105, 130, 142, 155)
	recipe:SetRecipeItem(5972, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(5958, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Dark Leather Pants -- 7135
	recipe = AddRecipe(7135, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(115, 115, 140, 152, 165)
	recipe:SetCraftedItem(5961, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(1385, 1632, 3007, 3069, 3365, 3549, 3605, 3967, 4212, 4588, 5127, 5564, 5784, 8153, 11097, 11098, 16278, 16688, 16728, 17442, 18754, 18771, 21087, 49885, 53436, 66354, 98948, 98964)

	-- Guardian Pants -- 7147
	recipe = AddRecipe(7147, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(160, 160, 180, 190, 200)
	recipe:SetCraftedItem(5962, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(1385, 1632, 3007, 3069, 3365, 3549, 3605, 3967, 4212, 4588, 5127, 5564, 5784, 8153, 11097, 11098, 16278, 16688, 16728, 17442, 18754, 18771, 21087, 53436, 66354, 98948, 98964)

	-- Barbaric Leggings -- 7149
	recipe = AddRecipe(7149, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(170, 170, 190, 200, 210)
	recipe:SetRecipeItem(5973, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(5963, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(2810, 3958)
	recipe:AddLimitedVendor(2821, 1)

	-- Barbaric Shoulders -- 7151
	recipe = AddRecipe(7151, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(175, 175, 195, 205, 215)
	recipe:SetCraftedItem(5964, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_SHOULDER")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(1385, 1632, 3007, 3069, 3365, 3549, 3605, 3967, 4212, 4588, 5127, 5564, 5784, 8153, 11097, 11098, 16278, 16688, 16728, 17442, 18754, 18771, 21087, 53436, 66354, 98948, 98964)

	-- Guardian Cloak -- 7153
	recipe = AddRecipe(7153, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(185, 185, 205, 215, 225)
	recipe:SetRecipeItem(5974, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(5965, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_BACK")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Guardian Gloves -- 7156
	recipe = AddRecipe(7156, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(190, 190, 210, 220, 230)
	recipe:SetCraftedItem(5966, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(1385, 1632, 3007, 3069, 3365, 3549, 3605, 3967, 4212, 4588, 5127, 5564, 5784, 8153, 11097, 11098, 16278, 16688, 16728, 17442, 18754, 18771, 21087, 53436, 66354, 98948, 98964)

	-- Deviate Scale Cloak -- 7953
	recipe = AddRecipe(7953, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(90, 90, 120, 135, 150)
	recipe:SetRecipeItem(6474, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(6466, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_BACK")
	recipe:AddFilters(F.DPS)
	recipe:Retire()

	-- Deviate Scale Gloves -- 7954
	recipe = AddRecipe(7954, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(105, 105, 130, 142, 155)
	recipe:SetRecipeItem(6475, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(6467, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.DPS)
	recipe:Retire()

	-- Deviate Scale Belt -- 7955
	recipe = AddRecipe(7955, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(115, 115, 140, 152, 165)
	recipe:SetRecipeItem(6476, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(6468, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:Retire()

	-- Moonglow Vest -- 8322
	recipe = AddRecipe(8322, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(90, 90, 115, 130, 145)
	recipe:SetRecipeItem(6710, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(6709, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddQuest(1582)

	-- Handstitched Leather Cloak -- 9058
	recipe = AddRecipe(9058, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 40, 55, 70)
	recipe:SetCraftedItem(7276, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_BACK")
	recipe:AddCustom("DEFAULT_RECIPE")

	-- Handstitched Leather Bracers -- 9059
	recipe = AddRecipe(9059, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 40, 55, 70)
	recipe:SetCraftedItem(7277, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddCustom("DEFAULT_RECIPE")

	-- Rugged Leather Pants -- 9064
	recipe = AddRecipe(9064, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(35, 35, 65, 80, 95)
	recipe:SetRecipeItem(7288, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(7280, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Light Leather Bracers -- 9065
	recipe = AddRecipe(9065, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(70, 70, 100, 115, 130)
	recipe:SetCraftedItem(7281, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddTrainer(1385, 1632, 3007, 3069, 3365, 3549, 3605, 3967, 4212, 4588, 5127, 5564, 5784, 8153, 11097, 11098, 16278, 16688, 16728, 17442, 18754, 18771, 21087, 47384, 47396, 47400, 47418, 47419, 47421, 47431, 48619, 49885, 53436, 57620, 65043, 66354, 85920, 86032, 93522, 93523, 98931, 98948, 98964)

	-- Light Leather Pants -- 9068
	recipe = AddRecipe(9068, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(95, 95, 125, 140, 155)
	recipe:SetCraftedItem(7282, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(1385, 1632, 3007, 3069, 3365, 3549, 3605, 3967, 4212, 4588, 5127, 5564, 5784, 8153, 11097, 11098, 16278, 16688, 16728, 17442, 18754, 18771, 21087, 49885, 53436, 66354, 98948, 98964)

	-- Black Whelp Cloak -- 9070
	recipe = AddRecipe(9070, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 125, 137, 150)
	recipe:SetRecipeItem(7289, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(7283, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_BACK")
	recipe:AddVendor(2697)

	-- Red Whelp Gloves -- 9072
	recipe = AddRecipe(9072, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(120, 120, 145, 157, 170)
	recipe:SetRecipeItem(7290, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(7284, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddVendor(2679)

	-- Nimble Leather Gloves -- 9074
	recipe = AddRecipe(9074, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(120, 120, 145, 157, 170)
	recipe:SetCraftedItem(7285, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(1385, 1632, 3007, 3069, 3365, 3549, 3605, 3967, 4212, 4588, 5127, 5564, 5784, 8153, 11097, 11098, 16278, 16688, 16728, 17442, 18754, 18771, 21087, 49885, 53436, 66354, 98948, 98964)

	-- Fletcher's Gloves -- 9145
	recipe = AddRecipe(9145, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(125, 125, 150, 162, 175)
	recipe:SetCraftedItem(7348, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(1385, 1632, 3007, 3069, 3365, 3549, 3605, 3967, 4212, 4588, 5127, 5564, 5784, 8153, 11097, 11098, 16278, 16688, 16728, 17442, 18754, 18771, 21087, 49885, 53436, 66354, 98948, 98964)

	-- Herbalist's Gloves -- 9146
	recipe = AddRecipe(9146, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(135, 135, 160, 172, 185)
	recipe:SetRecipeItem(7361, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(7349, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddVendor(34601)

	-- Earthen Leather Shoulders -- 9147
	recipe = AddRecipe(9147, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(135, 135, 160, 172, 185)
	recipe:SetRecipeItem(7362, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(7352, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_SHOULDER")
	recipe:AddLimitedVendor(3537, 1)

	-- Pilferer's Gloves -- 9148
	recipe = AddRecipe(9148, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(140, 140, 165, 177, 190)
	recipe:SetRecipeItem(7363, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(7358, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.DPS)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Heavy Earthen Gloves -- 9149
	recipe = AddRecipe(9149, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(145, 145, 170, 182, 195)
	recipe:SetRecipeItem(7364, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(7359, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.DPS)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Dusky Leather Leggings -- 9195
	recipe = AddRecipe(9195, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(165, 165, 185, 195, 205)
	recipe:SetRecipeItem(7449, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(7373, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.DPS)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Dusky Leather Armor -- 9196
	recipe = AddRecipe(9196, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(175, 175, 195, 205, 215)
	recipe:SetCraftedItem(7374, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(1385, 1632, 3007, 3069, 3365, 3549, 3605, 3967, 4212, 4588, 5127, 5564, 5784, 8153, 11097, 11098, 16278, 16688, 16728, 17442, 18754, 18771, 21087, 53436, 66354, 98948, 98964)

	-- Green Whelp Armor -- 9197
	recipe = AddRecipe(9197, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(175, 175, 195, 205, 215)
	recipe:SetRecipeItem(7450, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(7375, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Frost Leather Cloak -- 9198
	recipe = AddRecipe(9198, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(180, 180, 200, 210, 220)
	recipe:SetCraftedItem(7377, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_BACK")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(1385, 1632, 3007, 3069, 3365, 3549, 3605, 3967, 4212, 4588, 5127, 5564, 5784, 8153, 11097, 11098, 16278, 16688, 16728, 17442, 18754, 18771, 21087, 53436, 66354, 98948, 98964)

	-- Dusky Bracers -- 9201
	recipe = AddRecipe(9201, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(185, 185, 205, 215, 225)
	recipe:SetCraftedItem(7378, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(1385, 1632, 3007, 3069, 3365, 3549, 3605, 3967, 4212, 4588, 5127, 5564, 5784, 8153, 11097, 11098, 16278, 16688, 16728, 17442, 18754, 18771, 21087, 53436, 66354, 98948, 98964)

	-- Green Whelp Bracers -- 9202
	recipe = AddRecipe(9202, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(190, 190, 210, 220, 230)
	recipe:SetRecipeItem(7451, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(7386, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(40226)
	recipe:AddLimitedVendor(4225, 1, 4589, 1, 7854, 1)

	-- Dusky Belt -- 9206
	recipe = AddRecipe(9206, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(195, 195, 215, 225, 235)
	recipe:SetCraftedItem(7387, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(1385, 1632, 3007, 3069, 3365, 3549, 3605, 3967, 4212, 4588, 5127, 5564, 5784, 8153, 11097, 11098, 16278, 16688, 16728, 17442, 18754, 18771, 21087, 53436, 66354, 98948, 98964)

	-- Dusky Boots -- 9207
	recipe = AddRecipe(9207, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(200, 200, 220, 230, 240)
	recipe:SetRecipeItem(7452, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(7390, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddFilters(F.DPS)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Swift Boots -- 9208
	recipe = AddRecipe(9208, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(200, 200, 220, 230, 240)
	recipe:SetRecipeItem(7453, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(7391, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Cured Thick Hide -- 10482
	recipe = AddRecipe(10482, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(200, 200, 200, 200, 200)
	recipe:SetCraftedItem(8172, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_MATERIALS")
	recipe:AddTrainer(1385, 1632, 3007, 3069, 3365, 3549, 3605, 3967, 4212, 4588, 5127, 5564, 5784, 8153, 11097, 11098, 16278, 16688, 16728, 17442, 18754, 18771, 21087, 53436, 66354, 98948, 98964)

	-- Thick Armor Kit -- 10487
	recipe = AddRecipe(10487, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(200, 200, 220, 230, 240)
	recipe:SetCraftedItem(8173, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_ITEM_ENHANCEMENT")
	recipe:AddTrainer(1385, 1632, 3007, 3069, 3365, 3549, 3605, 3967, 4212, 4588, 5127, 5564, 5784, 8153, 11097, 11098, 16278, 16688, 16728, 17442, 18754, 18771, 21087, 53436, 66354, 98948, 98964)

	-- Comfortable Leather Hat -- 10490
	recipe = AddRecipe(10490, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(200, 200, 220, 230, 240)
	recipe:SetRecipeItem(8384, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(8174, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Nightscape Tunic -- 10499
	recipe = AddRecipe(10499, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(205, 205, 225, 235, 245)
	recipe:SetCraftedItem(8175, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(1385, 1632, 3007, 3069, 3365, 3549, 3605, 3967, 4212, 4588, 5127, 5564, 5784, 8153, 11097, 11098, 16278, 16688, 16728, 17442, 18754, 18771, 21087, 53436, 66354, 98948, 98964)

	-- Nightscape Headband -- 10507
	recipe = AddRecipe(10507, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(205, 205, 225, 235, 245)
	recipe:SetCraftedItem(8176, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HEAD")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(1385, 1632, 3007, 3069, 3365, 3549, 3605, 3967, 4212, 4588, 5127, 5564, 5784, 8153, 11097, 11098, 16278, 16688, 16728, 17442, 18754, 18771, 21087, 53436, 66354, 98948, 98964)

	-- Turtle Scale Gloves -- 10509
	recipe = AddRecipe(10509, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(205, 205, 225, 235, 245)
	recipe:SetRecipeItem(8385, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(8187, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(40226)
	recipe:AddLimitedVendor(7854, 1)

	-- Turtle Scale Breastplate -- 10511
	recipe = AddRecipe(10511, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(210, 210, 230, 240, 250)
	recipe:SetCraftedItem(8189, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(1385, 1632, 3007, 3069, 3365, 3549, 3605, 3967, 4212, 4588, 5127, 5564, 5784, 8153, 11097, 11098, 16278, 16688, 16728, 17442, 18754, 18771, 21087, 53436, 66354, 98948, 98964)

	-- Nightscape Shoulders -- 10516
	recipe = AddRecipe(10516, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(210, 210, 230, 240, 250)
	recipe:SetRecipeItem(8409, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(8192, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_SHOULDER")
	recipe:AddFilters(F.DPS)
	recipe:AddVendor(8160)
	recipe:AddLimitedVendor(7854, 1)

	-- Turtle Scale Bracers -- 10518
	recipe = AddRecipe(10518, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(210, 210, 230, 240, 250)
	recipe:SetCraftedItem(8198, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(1385, 1632, 3007, 3069, 3365, 3549, 3605, 3967, 4212, 4588, 5127, 5564, 5784, 8153, 11097, 11098, 16278, 16688, 16728, 17442, 18754, 18771, 21087, 53436, 66354, 98948, 98964)

	-- Big Voodoo Robe -- 10520
	recipe = AddRecipe(10520, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(215, 215, 235, 245, 255)
	recipe:SetRecipeItem(8386, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(8200, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Tough Scorpid Breastplate -- 10525
	recipe = AddRecipe(10525, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(220, 220, 240, 250, 260)
	recipe:SetRecipeItem(72029, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(8203, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.DPS)
	recipe:AddWorldDrop(Z.TANARIS)

	-- Wild Leather Shoulders -- 10529
	recipe = AddRecipe(10529, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(220, 220, 240, 250, 260)
	recipe:SetRecipeItem(8403, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(8210, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_SHOULDER")
	recipe:Retire()

	-- Big Voodoo Mask -- 10531
	recipe = AddRecipe(10531, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(220, 220, 240, 250, 260)
	recipe:SetRecipeItem(8387, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(8201, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HEAD")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Tough Scorpid Bracers -- 10533
	recipe = AddRecipe(10533, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(220, 220, 240, 250, 260)
	recipe:SetRecipeItem(72026, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(8205, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddFilters(F.DPS)
	recipe:AddWorldDrop(Z.TANARIS)

	-- Tough Scorpid Gloves -- 10542
	recipe = AddRecipe(10542, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(225, 225, 245, 255, 265)
	recipe:SetRecipeItem(72025, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(8204, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.DPS)
	recipe:AddWorldDrop(Z.TANARIS)

	-- Wild Leather Vest -- 10544
	recipe = AddRecipe(10544, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(225, 225, 245, 255, 265)
	recipe:SetRecipeItem(8404, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(8211, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:Retire()

	-- Wild Leather Helmet -- 10546
	recipe = AddRecipe(10546, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(225, 225, 245, 255, 265)
	recipe:SetRecipeItem(8405, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(8214, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HEAD")
	recipe:Retire()

	-- Nightscape Pants -- 10548
	recipe = AddRecipe(10548, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(230, 230, 250, 260, 270)
	recipe:SetCraftedItem(8193, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(1385, 1632, 3007, 3069, 3365, 3549, 3605, 3967, 4212, 4588, 5127, 5564, 5784, 8153, 11097, 11098, 16278, 16688, 16728, 17442, 18754, 18771, 21087, 53436, 66354, 98948, 98964)

	-- Turtle Scale Helm -- 10552
	recipe = AddRecipe(10552, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(230, 230, 250, 260, 270)
	recipe:SetCraftedItem(8191, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HEAD")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(1385, 1632, 3007, 3069, 3365, 3549, 3605, 3967, 4212, 4588, 5127, 5564, 5784, 8153, 11097, 11098, 16278, 16688, 16728, 17442, 18754, 18771, 21087, 53436, 66354, 98948, 98964)

	-- Tough Scorpid Boots -- 10554
	recipe = AddRecipe(10554, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(235, 235, 255, 265, 275)
	recipe:SetRecipeItem(72028, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(8209, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddFilters(F.DPS)
	recipe:AddWorldDrop(Z.TANARIS)

	-- Turtle Scale Leggings -- 10556
	recipe = AddRecipe(10556, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(235, 235, 255, 265, 275)
	recipe:SetCraftedItem(8185, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(1385, 1632, 3007, 3069, 3365, 3549, 3967, 4212, 4588, 5127, 5564, 5784, 8153, 11097, 11098, 16278, 16688, 16728, 17442, 18754, 18771, 21087, 53436, 66354, 98948, 98964)

	-- Nightscape Boots -- 10558
	recipe = AddRecipe(10558, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(235, 235, 255, 265, 275)
	recipe:SetCraftedItem(8197, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(1385, 1632, 3007, 3069, 3365, 3549, 3605, 3967, 4212, 4588, 5127, 5564, 5784, 8153, 11097, 11098, 16278, 16688, 16728, 17442, 18754, 18771, 21087, 53436, 66354, 98948, 98964)

	-- Big Voodoo Pants -- 10560
	recipe = AddRecipe(10560, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(240, 240, 260, 270, 280)
	recipe:SetRecipeItem(8389, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(8202, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Big Voodoo Cloak -- 10562
	recipe = AddRecipe(10562, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(240, 240, 260, 270, 280)
	recipe:SetRecipeItem(8390, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(8216, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_BACK")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Tough Scorpid Shoulders -- 10564
	recipe = AddRecipe(10564, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(240, 240, 260, 270, 280)
	recipe:SetRecipeItem(72027, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(8207, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_SHOULDER")
	recipe:AddFilters(F.DPS)
	recipe:AddWorldDrop(Z.TANARIS)

	-- Wild Leather Boots -- 10566
	recipe = AddRecipe(10566, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(245, 245, 265, 275, 285)
	recipe:SetRecipeItem(8406, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(8213, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:Retire()

	-- Tough Scorpid Leggings -- 10568
	recipe = AddRecipe(10568, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(245, 245, 265, 275, 285)
	recipe:SetRecipeItem(72030, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(8206, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.DPS)
	recipe:AddWorldDrop(Z.TANARIS)

	-- Tough Scorpid Helm -- 10570
	recipe = AddRecipe(10570, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(250, 250, 270, 280, 290)
	recipe:SetRecipeItem(72033, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(8208, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HEAD")
	recipe:AddFilters(F.DPS)
	recipe:AddWorldDrop(Z.TANARIS)

	-- Wild Leather Leggings -- 10572
	recipe = AddRecipe(10572, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(250, 250, 270, 280, 290)
	recipe:SetRecipeItem(8407, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(8212, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:Retire()

	-- Wild Leather Cloak -- 10574
	recipe = AddRecipe(10574, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(250, 250, 270, 280, 290)
	recipe:SetRecipeItem(8408, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(8215, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_BACK")
	recipe:Retire()

	-- Dragonscale Gauntlets -- 10619
	recipe = AddRecipe(10619, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(225, 225, 245, 255, 265)
	recipe:SetCraftedItem(8347, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:Retire()

	-- Wolfshead Helm -- 10621
	recipe = AddRecipe(10621, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(225, 225, 245, 255, 265)
	recipe:SetCraftedItem(8345, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HEAD")
	recipe:AddFilters(F.DPS, F.DRUID)
	recipe:Retire()

	-- Gauntlets of the Sea -- 10630
	recipe = AddRecipe(10630, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(230, 230, 250, 260, 270)
	recipe:SetCraftedItem(8346, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(3007, 3069, 3365, 3549, 4212, 4588, 5127, 5564, 7868, 7869, 16688, 16728, 17442, 18754, 21087, 53436, 66354, 98948, 98964)

	-- Helm of Fire -- 10632
	recipe = AddRecipe(10632, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(250, 250, 270, 280, 290)
	recipe:SetCraftedItem(8348, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HEAD")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(3007, 3069, 3365, 3549, 4212, 4588, 5127, 5564, 7868, 7869, 16688, 16728, 17442, 18754, 21087, 53436, 66354, 98948, 98964)

	-- Feathered Breastplate -- 10647
	recipe = AddRecipe(10647, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(250, 250, 270, 280, 290)
	recipe:SetCraftedItem(8349, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(3007, 3069, 3365, 3549, 4212, 4588, 5127, 5564, 7871, 16688, 16728, 17442, 18754, 21087, 53436, 66354, 98948, 98964)

	-- Dragonscale Breastplate -- 10650
	recipe = AddRecipe(10650, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(255, 255, 275, 285, 295)
	recipe:SetCraftedItem(8367, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(3007, 3069, 3365, 3549, 4212, 4588, 5127, 5564, 16688, 16728, 17442, 18754, 21087, 53436, 66354, 98948, 98964)

	-- Cured Rugged Hide -- 19047
	recipe = AddRecipe(19047, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(250, 250, 250, 255, 260)
	recipe:SetCraftedItem(15407, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_MATERIALS")
	recipe:AddTrainer(1385, 1632, 3007, 3069, 3365, 3549, 3605, 3967, 4212, 4588, 5127, 5564, 5784, 8153, 11097, 11098, 16278, 16688, 16728, 17442, 18754, 18771, 21087, 53436, 66354, 98948, 98964)

	-- Heavy Scorpid Bracers -- 19048
	recipe = AddRecipe(19048, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(255, 255, 275, 285, 295)
	recipe:SetRecipeItem(15724, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(15077, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddFilters(F.DPS)
	recipe:AddVendor(12956)

	-- Wicked Leather Gauntlets -- 19049
	recipe = AddRecipe(19049, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(260, 260, 280, 290, 300)
	recipe:SetRecipeItem(15725, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(15083, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.DPS)
	recipe:AddVendor(12942, 12943)

	-- Green Dragonscale Breastplate -- 19050
	recipe = AddRecipe(19050, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(260, 260, 280, 290, 300)
	recipe:SetRecipeItem(78346, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(15045, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddWorldDrop(Z.THE_TEMPLE_OF_ATALHAKKAR)

	-- Heavy Scorpid Vest -- 19051
	recipe = AddRecipe(19051, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(265, 265, 285, 295, 305)
	recipe:SetRecipeItem(15727, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(15076, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.DPS)
	recipe:Retire()

	-- Wicked Leather Bracers -- 19052
	recipe = AddRecipe(19052, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(265, 265, 285, 295, 305)
	recipe:SetCraftedItem(15084, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(1385, 1632, 3007, 3069, 3365, 3549, 3605, 3967, 4212, 4588, 5127, 5564, 5784, 8153, 11097, 11098, 16278, 16688, 16728, 17442, 18754, 18771, 21087, 53436, 66354, 98948, 98964)

	-- Chimeric Gloves -- 19053
	recipe = AddRecipe(19053, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(265, 265, 285, 295, 305)
	recipe:SetRecipeItem(15729, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(15074, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:Retire()

	-- Red Dragonscale Breastplate -- 19054
	recipe = AddRecipe(19054, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(15730, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(15047, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:Retire()

	-- Runic Leather Gauntlets -- 19055
	recipe = AddRecipe(19055, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(270, 270, 290, 300, 310)
	recipe:SetCraftedItem(15091, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(1385, 1632, 3007, 3069, 3365, 3549, 3605, 3967, 4212, 4588, 5127, 5564, 5784, 8153, 11097, 11098, 16278, 16688, 16728, 17442, 18754, 18771, 21087, 53436, 66354, 98948, 98964)

	-- Rugged Armor Kit -- 19058
	recipe = AddRecipe(19058, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(250, 250, 255, 265, 275)
	recipe:SetCraftedItem(15564, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_ITEM_ENHANCEMENT")
	recipe:AddTrainer(1385, 1632, 3007, 3069, 3365, 3549, 3605, 3967, 4212, 4588, 5127, 5564, 5784, 8153, 11097, 11098, 16688, 16728, 17442, 18754, 18771, 21087, 53436, 66354, 98948, 98964)

	-- Volcanic Leggings -- 19059
	recipe = AddRecipe(19059, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(270, 270, 290, 300, 310)
	recipe:SetRecipeItem(15732, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(15054, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddMobDrop(7035)

	-- Green Dragonscale Leggings -- 19060
	recipe = AddRecipe(19060, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(270, 270, 290, 300, 310)
	recipe:SetRecipeItem(78345, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(15046, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddWorldDrop(Z.THE_TEMPLE_OF_ATALHAKKAR)

	-- Living Shoulders -- 19061
	recipe = AddRecipe(19061, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(270, 270, 290, 300, 310)
	recipe:SetRecipeItem(15734, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(15061, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(40226)
	recipe:AddLimitedVendor(7854, 1)

	-- Ironfeather Shoulders -- 19062
	recipe = AddRecipe(19062, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(270, 270, 290, 300, 310)
	recipe:SetRecipeItem(15735, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(15067, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddLimitedVendor(12958, 1)

	-- Chimeric Boots -- 19063
	recipe = AddRecipe(19063, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(275, 275, 295, 305, 315)
	recipe:SetRecipeItem(15737, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(15073, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Heavy Scorpid Gauntlets -- 19064
	recipe = AddRecipe(19064, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(275, 275, 295, 305, 315)
	recipe:SetRecipeItem(15738, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(15078, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.DPS)
	recipe:Retire()

	-- Runic Leather Bracers -- 19065
	recipe = AddRecipe(19065, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(275, 275, 295, 305, 315)
	recipe:SetCraftedItem(15092, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(1385, 1632, 3007, 3069, 3365, 3549, 3605, 3967, 4212, 4588, 5127, 5564, 5784, 8153, 11097, 11098, 16688, 16728, 17442, 18754, 18771, 21087, 53436, 66354, 98948, 98964)

	-- Frostsaber Boots -- 19066
	recipe = AddRecipe(19066, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(275, 275, 295, 305, 315)
	recipe:SetRecipeItem(15740, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(15071, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddVendor(11189)

	-- Stormshroud Pants -- 19067
	recipe = AddRecipe(19067, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(275, 275, 295, 305, 315)
	recipe:SetRecipeItem(15741, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(15057, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.TANK)
	recipe:AddVendor(12942, 12943)

	-- Warbear Harness -- 19068
	recipe = AddRecipe(19068, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(275, 275, 295, 305, 315)
	recipe:SetRecipeItem(20253, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(15064, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.DPS)
	recipe:AddRepVendor(FAC.TIMBERMAW_HOLD, REP.FRIENDLY, 11557)

	-- Heavy Scorpid Belt -- 19070
	recipe = AddRecipe(19070, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(280, 280, 300, 310, 320)
	recipe:SetRecipeItem(15743, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(15082, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddFilters(F.DPS)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Wicked Leather Headband -- 19071
	recipe = AddRecipe(19071, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(280, 280, 300, 310, 320)
	recipe:SetCraftedItem(15086, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HEAD")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(1385, 1632, 3007, 3069, 3365, 3549, 3605, 3967, 4212, 4588, 5127, 5564, 5784, 8153, 11097, 11098, 16278, 16688, 16728, 17442, 18754, 18771, 21087, 53436, 66354, 98948, 98964)

	-- Runic Leather Belt -- 19072
	recipe = AddRecipe(19072, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(280, 280, 300, 310, 320)
	recipe:SetCraftedItem(15093, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(1385, 1632, 3007, 3069, 3365, 3549, 3605, 3967, 4212, 4588, 5127, 5564, 5784, 8153, 11097, 11098, 16278, 16688, 16728, 17442, 18754, 18771, 21087, 53436, 66354, 98948, 98964)

	-- Chimeric Leggings -- 19073
	recipe = AddRecipe(19073, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(280, 280, 300, 310, 320)
	recipe:SetRecipeItem(15746, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(15072, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Frostsaber Leggings -- 19074
	recipe = AddRecipe(19074, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(285, 285, 305, 315, 325)
	recipe:SetRecipeItem(15747, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(15069, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddMobDrop(7440)

	-- Heavy Scorpid Leggings -- 19075
	recipe = AddRecipe(19075, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(285, 285, 305, 315, 325)
	recipe:SetRecipeItem(15748, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(15079, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.DPS)
	recipe:Retire()

	-- Volcanic Breastplate -- 19076
	recipe = AddRecipe(19076, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(285, 285, 305, 315, 325)
	recipe:SetRecipeItem(15749, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(15053, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddMobDrop(9259)

	-- Blue Dragonscale Breastplate -- 19077
	recipe = AddRecipe(19077, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(285, 285, 305, 315, 325)
	recipe:SetRecipeItem(15751, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(15048, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:Retire()

	-- Living Leggings -- 19078
	recipe = AddRecipe(19078, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(285, 285, 305, 315, 325)
	recipe:SetRecipeItem(15752, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(15060, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddMobDrop(7158)

	-- Stormshroud Armor -- 19079
	recipe = AddRecipe(19079, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(285, 285, 305, 315, 325)
	recipe:SetRecipeItem(15753, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(15056, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.TANK)
	recipe:Retire()

	-- Warbear Woolies -- 19080
	recipe = AddRecipe(19080, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(285, 285, 305, 315, 325)
	recipe:SetRecipeItem(20254, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(15065, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.DPS)
	recipe:AddRepVendor(FAC.TIMBERMAW_HOLD, REP.FRIENDLY, 11557)

	-- Chimeric Vest -- 19081
	recipe = AddRecipe(19081, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(290, 290, 310, 320, 330)
	recipe:SetRecipeItem(15755, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(15075, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Runic Leather Headband -- 19082
	recipe = AddRecipe(19082, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(290, 290, 310, 320, 330)
	recipe:SetCraftedItem(15094, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(1385, 1632, 3007, 3069, 3365, 3549, 3605, 3967, 4212, 4588, 5127, 5564, 5784, 8153, 11097, 11098, 16278, 16688, 16728, 17442, 18754, 18771, 21087, 53436, 66354, 98948, 98964)

	-- Wicked Leather Pants -- 19083
	recipe = AddRecipe(19083, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(290, 290, 315, 325, 335)
	recipe:SetCraftedItem(15087, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(1385, 1632, 3007, 3069, 3365, 3549, 3605, 3967, 4212, 4588, 5127, 5564, 5784, 8153, 11097, 11098, 16278, 16688, 16728, 17442, 18754, 18771, 21087, 53436, 66354, 98948, 98964)

	-- Devilsaur Gauntlets -- 19084
	recipe = AddRecipe(19084, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(290, 290, 310, 320, 330)
	recipe:SetRecipeItem(15758, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(15063, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddLimitedVendor(12959, 1)

	-- Black Dragonscale Breastplate -- 19085
	recipe = AddRecipe(19085, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(290, 290, 310, 320, 330)
	recipe:SetRecipeItem(15759, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(15050, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(9499)

	-- Ironfeather Breastplate -- 19086
	recipe = AddRecipe(19086, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(290, 290, 310, 320, 330)
	recipe:SetRecipeItem(15760, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(15066, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddMobDrop(2644)

	-- Frostsaber Gloves -- 19087
	recipe = AddRecipe(19087, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(295, 295, 315, 325, 335)
	recipe:SetRecipeItem(15761, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(15070, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddMobDrop(7441)

	-- Heavy Scorpid Helm -- 19088
	recipe = AddRecipe(19088, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(295, 295, 315, 325, 335)
	recipe:SetRecipeItem(15762, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(15080, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HEAD")
	recipe:AddFilters(F.DPS)
	recipe:AddVendor(12956)

	-- Blue Dragonscale Shoulders -- 19089
	recipe = AddRecipe(19089, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(295, 295, 315, 325, 335)
	recipe:SetRecipeItem(15763, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(15049, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:Retire()

	-- Stormshroud Shoulders -- 19090
	recipe = AddRecipe(19090, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(295, 295, 315, 325, 335)
	recipe:SetRecipeItem(15764, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(15058, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.TANK)
	recipe:Retire()

	-- Runic Leather Pants -- 19091
	recipe = AddRecipe(19091, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetCraftedItem(15095, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(1385, 1632, 3007, 3069, 3365, 3549, 3605, 3967, 4212, 4588, 5127, 5564, 5784, 8153, 11097, 11098, 16278, 16688, 16728, 17442, 18754, 18771, 21087, 53436, 66354, 98948, 98964)

	-- Wicked Leather Belt -- 19092
	recipe = AddRecipe(19092, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetCraftedItem(15088, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(1385, 1632, 3007, 3069, 3365, 3549, 3605, 3967, 4212, 4588, 5127, 5564, 5784, 8153, 11097, 11098, 16278, 16688, 16728, 17442, 18754, 18771, 21087, 53436, 66354, 98948, 98964)

	-- Onyxia Scale Cloak -- 19093
	recipe = AddRecipe(19093, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(15769, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(15138, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_BACK")
	recipe:AddQuest(7493, 7497)
	recipe:AddCustom("ONYXIA_HEAD_QUEST")

	-- Black Dragonscale Shoulders -- 19094
	recipe = AddRecipe(19094, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(15770, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(15051, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddMobDrop(8898)

	-- Living Breastplate -- 19095
	recipe = AddRecipe(19095, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(15771, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(15059, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:Retire()

	-- Devilsaur Leggings -- 19097
	recipe = AddRecipe(19097, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(15772, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(15062, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddMobDrop(6557, 6559)
	recipe:AddLimitedVendor(12959, 1)

	-- Wicked Leather Armor -- 19098
	recipe = AddRecipe(19098, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetCraftedItem(15085, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(1385, 1632, 3007, 3069, 3365, 3549, 3967, 4212, 4588, 5127, 5564, 5784, 8153, 11097, 11098, 16278, 16688, 16728, 17442, 18754, 18771, 21087, 53436, 66354, 98948, 98964)

	-- Heavy Scorpid Shoulders -- 19100
	recipe = AddRecipe(19100, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(15774, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(15081, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_SHOULDER")
	recipe:AddFilters(F.DPS)
	recipe:Retire()

	-- Volcanic Shoulders -- 19101
	recipe = AddRecipe(19101, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(15775, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(15055, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_SHOULDER")
	recipe:AddMobDrop(9260)

	-- Runic Leather Armor -- 19102
	recipe = AddRecipe(19102, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetCraftedItem(15090, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(1385, 1632, 3007, 3069, 3365, 3549, 3605, 3967, 4212, 4588, 5127, 5564, 5784, 8153, 11097, 11098, 16278, 16688, 16728, 17442, 18754, 18771, 21087, 53436, 66354, 98948, 98964)

	-- Runic Leather Shoulders -- 19103
	recipe = AddRecipe(19103, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetCraftedItem(15096, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(1385, 1632, 3007, 3069, 3365, 3549, 3605, 3967, 4212, 4588, 5127, 5564, 5784, 8153, 11097, 11098, 16278, 16688, 16728, 17442, 18754, 18771, 21087, 53436, 66354, 98948, 98964)

	-- Frostsaber Tunic -- 19104
	recipe = AddRecipe(19104, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(15779, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(15068, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddMobDrop(7438)

	-- Black Dragonscale Leggings -- 19107
	recipe = AddRecipe(19107, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(15781, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(15052, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddMobDrop(8903)

	-- Medium Leather -- 20648
	recipe = AddRecipe(20648, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 100, 105, 110)
	recipe:SetCraftedItem(2319, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_MATERIALS")
	recipe:AddTrainer(1385, 1632, 3007, 3069, 3365, 3549, 3605, 3967, 4212, 4588, 5127, 5564, 5784, 8153, 11097, 11098, 16278, 16688, 16728, 17442, 18754, 18771, 21087, 49885, 53436, 66354, 98948, 98964)

	-- Heavy Leather -- 20649
	recipe = AddRecipe(20649, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(150, 150, 150, 155, 160)
	recipe:SetCraftedItem(4234, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_MATERIALS")
	recipe:AddTrainer(1385, 1632, 3007, 3069, 3365, 3549, 3605, 3967, 4212, 4588, 5127, 5564, 5784, 8153, 11097, 11098, 16278, 16688, 16728, 17442, 18754, 18771, 21087, 49885, 53436, 66354, 98948, 98964)

	-- Thick Leather -- 20650
	recipe = AddRecipe(20650, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(200, 200, 200, 202, 205)
	recipe:SetCraftedItem(4304, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_MATERIALS")
	recipe:AddTrainer(1385, 1632, 3007, 3069, 3365, 3549, 3605, 3967, 4212, 4588, 5127, 5564, 5784, 8153, 11097, 11098, 16278, 16688, 16728, 17442, 18754, 18771, 21087, 53436, 66354, 98948, 98964)

	-- Corehound Boots -- 20853
	recipe = AddRecipe(20853, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(295, 295, 315, 325, 335)
	recipe:SetRecipeItem(17022, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(16982, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddFilters(F.DPS)
	recipe:AddVendor(12944)

	-- Molten Helm -- 20854
	recipe = AddRecipe(20854, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(17023, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(16983, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HEAD")
	recipe:AddFilters(F.TANK)
	recipe:AddVendor(12944)

	-- Black Dragonscale Boots -- 20855
	recipe = AddRecipe(20855, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(17025, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(16984, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddRepVendor(FAC.THORIUM_BROTHERHOOD, REP.HONORED, 12944)

	-- Gloves of the Greatfather -- 21943
	recipe = AddRecipe(21943, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(190, 190, 210, 220, 230)
	recipe:SetRecipeItem(17722, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(17721, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddWorldEvent("WINTER_VEIL")
	recipe:AddCustom("PRESENTS")

	-- Rugged Leather -- 22331
	recipe = AddRecipe(22331, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(250, 250, 250, 250, 250)
	recipe:SetCraftedItem(8170, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_MATERIALS")
	recipe:AddTrainer(1385, 1632, 3007, 3069, 3365, 3549, 3605, 3967, 4212, 4588, 5127, 5564, 5784, 8153, 11097, 11098, 16278, 16688, 16728, 17442, 18754, 18771, 21087, 53436, 66354, 98948, 98964)

	-- Shadowskin Gloves -- 22711
	recipe = AddRecipe(22711, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(200, 200, 210, 220, 230)
	recipe:SetRecipeItem(18239, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(18238, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddLimitedVendor(2699, 1)

	-- Core Armor Kit -- 22727
	recipe = AddRecipe(22727, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(18252, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(18251, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.TANK)
	recipe:AddWorldDrop(Z.MOLTEN_CORE)

	-- Gordok Ogre Suit -- 22815
	recipe = AddRecipe(22815, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(275, 275, 285, 290, 385)
	recipe:SetCraftedItem(18258, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CREATED_ITEM")
	recipe:Retire()

	-- Girdle of Insight -- 22921
	recipe = AddRecipe(22921, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(18514, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(18504, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:Retire()

	-- Mongoose Boots -- 22922
	recipe = AddRecipe(22922, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(18515, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(18506, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddFilters(F.DPS)
	recipe:Retire()

	-- Swift Flight Bracers -- 22923
	recipe = AddRecipe(22923, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(18516, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(18508, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:Retire()

	-- Chromatic Cloak -- 22926
	recipe = AddRecipe(22926, V.ORIG, Q.EPIC)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(18517, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(18509, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_BACK")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:Retire()

	-- Hide of the Wild -- 22927
	recipe = AddRecipe(22927, V.ORIG, Q.EPIC)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(18518, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(18510, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_BACK")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:Retire()

	-- Shifting Cloak -- 22928
	recipe = AddRecipe(22928, V.ORIG, Q.EPIC)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(18519, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(18511, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_BACK")
	recipe:AddFilters(F.DPS, F.TANK)
	recipe:Retire()

	-- Heavy Leather Ball -- 23190
	recipe = AddRecipe(23190, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(150, 150, 150, 155, 160)
	recipe:SetRecipeItem(18731, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(18662, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CREATED_ITEM")
	recipe:AddLimitedVendor(3366, 1, 5128, 1)

	-- Barbaric Bracers -- 23399
	recipe = AddRecipe(23399, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(155, 155, 175, 185, 195)
	recipe:SetRecipeItem(18949, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(18948, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddLimitedVendor(4225, 1, 4589, 1)

	-- Might of the Timbermaw -- 23703
	recipe = AddRecipe(23703, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(290, 290, 310, 320, 330)
	recipe:SetRecipeItem(19326, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(19044, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddFilters(F.DPS)
	recipe:AddRepVendor(FAC.TIMBERMAW_HOLD, REP.HONORED, 11557)

	-- Timbermaw Brawlers -- 23704
	recipe = AddRecipe(23704, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(19327, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(19049, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.DPS)
	recipe:AddRepVendor(FAC.TIMBERMAW_HOLD, REP.REVERED, 11557)

	-- Dawn Treaders -- 23705
	recipe = AddRecipe(23705, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(290, 290, 310, 320, 330)
	recipe:SetRecipeItem(19328, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(19052, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddRepVendor(FAC.ARGENT_DAWN, REP.HONORED, 10856, 10857, 11536)

	-- Golden Mantle of the Dawn -- 23706
	recipe = AddRecipe(23706, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(19329, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(19058, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_SHOULDER")
	recipe:AddFilters(F.TANK)
	recipe:AddRepVendor(FAC.ARGENT_DAWN, REP.REVERED, 10856, 10857, 11536)

	-- Lava Belt -- 23707
	recipe = AddRecipe(23707, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(19330, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(19149, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddRepVendor(FAC.THORIUM_BROTHERHOOD, REP.HONORED, 12944)

	-- Chromatic Gauntlets -- 23708
	recipe = AddRecipe(23708, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(19331, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(19157, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddRepVendor(FAC.THORIUM_BROTHERHOOD, REP.REVERED, 12944)

	-- Corehound Belt -- 23709
	recipe = AddRecipe(23709, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(19332, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(19162, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddRepVendor(FAC.THORIUM_BROTHERHOOD, REP.REVERED, 12944)

	-- Molten Belt -- 23710
	recipe = AddRecipe(23710, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(19333, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(19163, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddFilters(F.DPS)
	recipe:AddRepVendor(FAC.THORIUM_BROTHERHOOD, REP.REVERED, 12944)

	-- Primal Batskin Jerkin -- 24121
	recipe = AddRecipe(24121, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(19769, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(19685, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:Retire()

	-- Primal Batskin Gloves -- 24122
	recipe = AddRecipe(24122, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(19770, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(19686, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:Retire()

	-- Primal Batskin Bracers -- 24123
	recipe = AddRecipe(24123, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(19771, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(19687, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:Retire()

	-- Blood Tiger Breastplate -- 24124
	recipe = AddRecipe(24124, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(19772, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(19688, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:Retire()

	-- Blood Tiger Shoulders -- 24125
	recipe = AddRecipe(24125, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(19773, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(19689, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:Retire()

	-- Blue Dragonscale Leggings -- 24654
	recipe = AddRecipe(24654, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetCraftedItem(20295, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(3007, 3069, 3365, 3549, 4212, 4588, 5127, 5564, 16688, 16728, 17442, 18754, 21087, 53436, 66354, 98948, 98964)

	-- Green Dragonscale Gauntlets -- 24655
	recipe = AddRecipe(24655, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(280, 280, 290, 295, 300)
	recipe:SetCraftedItem(20296, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(3007, 3069, 3365, 3549, 4212, 4588, 5127, 5564, 16688, 16728, 17442, 18754, 21087, 53436, 66354, 98948, 98964)

	-- Dreamscale Breastplate -- 24703
	recipe = AddRecipe(24703, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(20382, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(20380, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddRepVendor(FAC.CENARION_CIRCLE, REP.EXALTED, 15293)

	-- Spitfire Bracers -- 24846
	recipe = AddRecipe(24846, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(20506, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(20481, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddRepVendor(FAC.CENARION_CIRCLE, REP.FRIENDLY, 15293)

	-- Spitfire Gauntlets -- 24847
	recipe = AddRecipe(24847, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(20507, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(20480, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddRepVendor(FAC.CENARION_CIRCLE, REP.HONORED, 15293)

	-- Spitfire Breastplate -- 24848
	recipe = AddRecipe(24848, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(20508, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(20479, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddRepVendor(FAC.CENARION_CIRCLE, REP.REVERED, 15293)

	-- Sandstalker Bracers -- 24849
	recipe = AddRecipe(24849, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(20509, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(20476, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddRepVendor(FAC.CENARION_CIRCLE, REP.FRIENDLY, 15293)

	-- Sandstalker Gauntlets -- 24850
	recipe = AddRecipe(24850, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(20510, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(20477, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddRepVendor(FAC.CENARION_CIRCLE, REP.HONORED, 15293)

	-- Sandstalker Breastplate -- 24851
	recipe = AddRecipe(24851, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(20511, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(20478, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddRepVendor(FAC.CENARION_CIRCLE, REP.REVERED, 15293)

	-- Black Whelp Tunic -- 24940
	recipe = AddRecipe(24940, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 125, 137, 150)
	recipe:SetRecipeItem(20576, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(20575, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(777)

	-- Stormshroud Gloves -- 26279
	recipe = AddRecipe(26279, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(21548, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(21278, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:Retire()

	-- Polar Tunic -- 28219
	recipe = AddRecipe(28219, V.ORIG, Q.EPIC)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetCraftedItem(22661, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.DPS)
	recipe:Retire()

	-- Polar Gloves -- 28220
	recipe = AddRecipe(28220, V.ORIG, Q.EPIC)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetCraftedItem(22662, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.DPS)
	recipe:Retire()

	-- Polar Bracers -- 28221
	recipe = AddRecipe(28221, V.ORIG, Q.EPIC)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetCraftedItem(22663, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddFilters(F.DPS)
	recipe:Retire()

	-- Icy Scale Breastplate -- 28222
	recipe = AddRecipe(28222, V.ORIG, Q.EPIC)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetCraftedItem(22664, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.DPS)
	recipe:Retire()

	-- Icy Scale Gauntlets -- 28223
	recipe = AddRecipe(28223, V.ORIG, Q.EPIC)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetCraftedItem(22666, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.DPS)
	recipe:Retire()

	-- Icy Scale Bracers -- 28224
	recipe = AddRecipe(28224, V.ORIG, Q.EPIC)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetCraftedItem(22665, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddFilters(F.DPS)
	recipe:Retire()

	-- Bramblewood Helm -- 28472
	recipe = AddRecipe(28472, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(22771, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(22759, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HEAD")
	recipe:AddRepVendor(FAC.CENARION_CIRCLE, REP.REVERED, 15293)

	-- Bramblewood Boots -- 28473
	recipe = AddRecipe(28473, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(22770, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(22760, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddRepVendor(FAC.CENARION_CIRCLE, REP.HONORED, 15293)

	-- Bramblewood Belt -- 28474
	recipe = AddRecipe(28474, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(22769, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(22761, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddRepVendor(FAC.CENARION_CIRCLE, REP.FRIENDLY, 15293)

	-- ----------------------------------------------------------------------------
	-- The Burning Crusade.
	-- ----------------------------------------------------------------------------
	-- Knothide Leather -- 32454
	recipe = AddRecipe(32454, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(21887, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_MATERIALS")
	recipe:AddTrainer(3069, 4212, 17442, 18754, 18771, 19187, 21087, 33612, 33635, 33681, 66354, 98948, 98964)

	-- Heavy Knothide Leather -- 32455
	recipe = AddRecipe(32455, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(23793, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_MATERIALS")
	recipe:AddTrainer(3069, 4212, 17442, 18754, 19187, 21087, 33612, 33635, 33681, 66354, 98948, 98964)

	-- Knothide Armor Kit -- 32456
	recipe = AddRecipe(32456, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(25650, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_ITEM_ENHANCEMENT")
	recipe:AddTrainer(3069, 4212, 17442, 18754, 18771, 19187, 21087, 33612, 33635, 33681, 66354, 98948, 98964)

	-- Vindicator's Armor Kit -- 32457
	recipe = AddRecipe(32457, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(325, 325, 335, 340, 345)
	recipe:SetRecipeItem(25721, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(25651, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_ITEM_ENHANCEMENT")
	recipe:AddRepVendor(FAC.THE_ALDOR, REP.REVERED, 19321)

	-- Magister's Armor Kit -- 32458
	recipe = AddRecipe(32458, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(325, 325, 335, 340, 345)
	recipe:SetRecipeItem(25722, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(25652, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddRepVendor(FAC.THE_SCRYERS, REP.REVERED, 19331)

	-- Riding Crop -- 32461
	recipe = AddRecipe(32461, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(350, 350, 360, 370, 380)
	recipe:SetRecipeItem(25725, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(25653, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CREATED_ITEM")
	recipe:AddVendor(18672)

	-- Felscale Gloves -- 32462
	recipe = AddRecipe(32462, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(25654, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(3069, 4212, 17442, 18754, 18771, 19187, 21087, 33612, 33635, 33681, 66354, 98948, 98964)

	-- Felscale Boots -- 32463
	recipe = AddRecipe(32463, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(10, 10, 20, 25, 30)
	recipe:SetCraftedItem(25655, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(3069, 4212, 17442, 18754, 18771, 19187, 21087, 33612, 33635, 33681, 66354, 98948, 98964)

	-- Felscale Pants -- 32464
	recipe = AddRecipe(32464, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(20, 20, 30, 35, 40)
	recipe:SetCraftedItem(25656, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(3069, 4212, 17442, 18754, 18771, 19187, 21087, 33612, 33635, 33681, 66354, 98948, 98964)

	-- Felscale Breastplate -- 32465
	recipe = AddRecipe(32465, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(35, 35, 45, 50, 55)
	recipe:SetCraftedItem(25657, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(3069, 4212, 17442, 18754, 18771, 19187, 21087, 33612, 33635, 33681, 66354, 98948, 98964)

	-- Scaled Draenic Pants -- 32466
	recipe = AddRecipe(32466, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(25662, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(3069, 4212, 17442, 18754, 18771, 19187, 21087, 33612, 33635, 33681, 66354, 98948, 98964)

	-- Scaled Draenic Gloves -- 32467
	recipe = AddRecipe(32467, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(10, 10, 20, 25, 30)
	recipe:SetCraftedItem(25661, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(3069, 4212, 17442, 18754, 18771, 19187, 21087, 33612, 33635, 33681, 66354, 98948, 98964)

	-- Scaled Draenic Vest -- 32468
	recipe = AddRecipe(32468, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(25660, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(3069, 4212, 17442, 18754, 18771, 19187, 21087, 33612, 33635, 33681, 66354, 98948, 98964)

	-- Scaled Draenic Boots -- 32469
	recipe = AddRecipe(32469, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(35, 35, 45, 50, 55)
	recipe:SetCraftedItem(25659, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(3069, 4212, 17442, 18754, 18771, 19187, 21087, 33612, 33635, 33681, 66354, 98948, 98964)

	-- Thick Draenic Gloves -- 32470
	recipe = AddRecipe(32470, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(25669, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(3069, 4212, 17442, 18754, 18771, 19187, 21087, 33612, 33635, 33681, 66354, 98948, 98964)

	-- Thick Draenic Pants -- 32471
	recipe = AddRecipe(32471, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(15, 15, 25, 30, 35)
	recipe:SetCraftedItem(25670, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(3069, 4212, 17442, 18754, 18771, 19187, 21087, 33612, 33635, 33681, 66354, 98948, 98964)

	-- Thick Draenic Boots -- 32472
	recipe = AddRecipe(32472, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(20, 20, 30, 35, 40)
	recipe:SetCraftedItem(25668, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(3069, 4212, 17442, 18754, 18771, 19187, 21087, 33612, 33635, 33681, 66354, 98948, 98964)

	-- Thick Draenic Vest -- 32473
	recipe = AddRecipe(32473, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(30, 30, 40, 45, 50)
	recipe:SetCraftedItem(25671, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(3069, 4212, 17442, 18754, 18771, 19187, 21087, 33612, 33635, 33681, 66354, 98948, 98964)

	-- Wild Draenish Boots -- 32478
	recipe = AddRecipe(32478, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(25673, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(3069, 4212, 17442, 18754, 18771, 19187, 21087, 33612, 33635, 33681, 66354, 98948, 98964)

	-- Wild Draenish Gloves -- 32479
	recipe = AddRecipe(32479, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(10, 10, 20, 25, 30)
	recipe:SetCraftedItem(25674, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(3069, 4212, 17442, 18754, 18771, 19187, 21087, 33612, 33635, 33681, 66354, 98948, 98964)

	-- Wild Draenish Leggings -- 32480
	recipe = AddRecipe(32480, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(20, 20, 30, 35, 40)
	recipe:SetCraftedItem(25675, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(3069, 4212, 17442, 18754, 18771, 19187, 21087, 33612, 33635, 33681, 66354, 98948, 98964)

	-- Wild Draenish Vest -- 32481
	recipe = AddRecipe(32481, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(30, 30, 40, 45, 50)
	recipe:SetCraftedItem(25676, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(3069, 4212, 17442, 18754, 18771, 19187, 21087, 33612, 33635, 33681, 66354, 98948, 98964)

	-- Comfortable Insoles -- 32482
	recipe = AddRecipe(32482, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 300, 305, 310)
	recipe:SetRecipeItem(25726, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(25679, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CREATED_ITEM")
	recipe:AddLimitedVendor(16689, 1, 16748, 1)

	-- Stylin' Purple Hat -- 32485
	recipe = AddRecipe(32485, V.TBC, Q.RARE)
	recipe:SetSkillLevels(350, 350, 360, 370, 380)
	recipe:SetRecipeItem(25728, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(25680, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HEAD")
	recipe:AddFilters(F.DPS)
	recipe:AddMobDrop(18667)

	-- Stylin' Adventure Hat -- 32487
	recipe = AddRecipe(32487, V.TBC, Q.RARE)
	recipe:SetSkillLevels(350, 350, 360, 370, 380)
	recipe:SetRecipeItem(25729, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(25681, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HEAD")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddMobDrop(17820, 28132)

	-- Stylin' Crimson Hat -- 32488
	recipe = AddRecipe(32488, V.TBC, Q.RARE)
	recipe:SetSkillLevels(350, 350, 360, 370, 380)
	recipe:SetRecipeItem(25731, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(25683, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HEAD")
	recipe:AddFilters(F.DPS)
	recipe:AddMobDrop(18322)

	-- Stylin' Jungle Hat -- 32489
	recipe = AddRecipe(32489, V.TBC, Q.RARE)
	recipe:SetSkillLevels(350, 350, 360, 370, 380)
	recipe:SetRecipeItem(25730, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(25682, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddMobDrop(17839, 21104)

	-- Fel Leather Gloves -- 32490
	recipe = AddRecipe(32490, V.TBC, Q.RARE)
	recipe:SetSkillLevels(340, 340, 350, 360, 370)
	recipe:SetRecipeItem(25732, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(25685, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.TANK)
	recipe:AddRepVendor(FAC.THE_CONSORTIUM, REP.FRIENDLY, 20242, 23007)

	-- Fel Leather Boots -- 32493
	recipe = AddRecipe(32493, V.TBC, Q.RARE)
	recipe:SetSkillLevels(350, 350, 360, 370, 380)
	recipe:SetRecipeItem(25733, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(25686, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.TANK)
	recipe:AddRepVendor(FAC.THE_CONSORTIUM, REP.HONORED, 20242, 23007)

	-- Fel Leather Leggings -- 32494
	recipe = AddRecipe(32494, V.TBC, Q.RARE)
	recipe:SetSkillLevels(350, 350, 360, 370, 380)
	recipe:SetRecipeItem(25734, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(25687, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.TANK)
	recipe:AddRepVendor(FAC.THE_CONSORTIUM, REP.REVERED, 20242, 23007)

	-- Heavy Clefthoof Vest -- 32495
	recipe = AddRecipe(32495, V.TBC, Q.RARE)
	recipe:SetSkillLevels(360, 360, 370, 380, 390)
	recipe:SetRecipeItem(25735, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(25689, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.DPS, F.TANK)
	recipe:AddRepVendor(FAC.CENARION_EXPEDITION, REP.HONORED, 17904)

	-- Heavy Clefthoof Leggings -- 32496
	recipe = AddRecipe(32496, V.TBC, Q.RARE)
	recipe:SetSkillLevels(355, 355, 365, 375, 385)
	recipe:SetRecipeItem(25736, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(25690, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.DPS, F.TANK)
	recipe:AddRepVendor(FAC.CENARION_EXPEDITION, REP.HONORED, 17904)

	-- Heavy Clefthoof Boots -- 32497
	recipe = AddRecipe(32497, V.TBC, Q.RARE)
	recipe:SetSkillLevels(355, 355, 365, 375, 385)
	recipe:SetRecipeItem(25737, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(25691, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddFilters(F.DPS, F.TANK)
	recipe:AddRepVendor(FAC.CENARION_EXPEDITION, REP.FRIENDLY, 17904)

	-- Felstalker Belt -- 32498
	recipe = AddRecipe(32498, V.TBC, Q.RARE)
	recipe:SetSkillLevels(350, 350, 360, 370, 380)
	recipe:SetRecipeItem(29213, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(25695, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddRepVendor(FAC.HONOR_HOLD, REP.FRIENDLY, 17657)
	recipe:AddRepVendor(FAC.THRALLMAR, REP.FRIENDLY, 17585)

	-- Felstalker Bracers -- 32499
	recipe = AddRecipe(32499, V.TBC, Q.RARE)
	recipe:SetSkillLevels(360, 360, 370, 380, 390)
	recipe:SetRecipeItem(29214, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(25697, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddRepVendor(FAC.HONOR_HOLD, REP.HONORED, 17657)
	recipe:AddRepVendor(FAC.THRALLMAR, REP.HONORED, 17585)

	-- Felstalker Breastplate -- 32500
	recipe = AddRecipe(32500, V.TBC, Q.RARE)
	recipe:SetSkillLevels(360, 360, 370, 380, 390)
	recipe:SetRecipeItem(29215, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(25696, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddRepVendor(FAC.HONOR_HOLD, REP.HONORED, 17657)
	recipe:AddRepVendor(FAC.THRALLMAR, REP.HONORED, 17585)

	-- Netherfury Belt -- 32501
	recipe = AddRecipe(32501, V.TBC, Q.RARE)
	recipe:SetSkillLevels(340, 340, 350, 360, 370)
	recipe:SetRecipeItem(29217, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(25694, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddRepVendor(FAC.KURENAI, REP.FRIENDLY, 20240)
	recipe:AddRepVendor(FAC.THE_MAGHAR, REP.FRIENDLY, 20241)

	-- Netherfury Leggings -- 32502
	recipe = AddRecipe(32502, V.TBC, Q.RARE)
	recipe:SetSkillLevels(340, 340, 350, 360, 370)
	recipe:SetRecipeItem(29219, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(25692, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddRepVendor(FAC.KURENAI, REP.HONORED, 20240)
	recipe:AddRepVendor(FAC.THE_MAGHAR, REP.HONORED, 20241)

	-- Netherfury Boots -- 32503
	recipe = AddRecipe(32503, V.TBC, Q.RARE)
	recipe:SetSkillLevels(350, 350, 360, 370, 380)
	recipe:SetRecipeItem(29218, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(25693, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddRepVendor(FAC.KURENAI, REP.REVERED, 20240)
	recipe:AddRepVendor(FAC.THE_MAGHAR, REP.REVERED, 20241)

	-- Enchanted Felscale Leggings -- 35525
	recipe = AddRecipe(35525, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(350, 350, 360, 370, 380)
	recipe:SetRecipeItem(29677, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(29489, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.DPS)
	recipe:AddRepVendor(FAC.THE_SCRYERS, REP.EXALTED, 19331)

	-- Enchanted Felscale Gloves -- 35526
	recipe = AddRecipe(35526, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(350, 350, 360, 370, 380)
	recipe:SetRecipeItem(29682, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(29490, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.DPS)
	recipe:AddRepVendor(FAC.THE_SCRYERS, REP.HONORED, 19331)

	-- Enchanted Felscale Boots -- 35527
	recipe = AddRecipe(35527, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(350, 350, 360, 370, 380)
	recipe:SetRecipeItem(29684, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(29491, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddFilters(F.DPS)
	recipe:AddRepVendor(FAC.THE_SCRYERS, REP.REVERED, 19331)

	-- Flamescale Boots -- 35528
	recipe = AddRecipe(35528, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(350, 350, 360, 370, 380)
	recipe:SetRecipeItem(29691, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(29493, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddFilters(F.DPS)
	recipe:AddRepVendor(FAC.THE_ALDOR, REP.REVERED, 19321)

	-- Flamescale Leggings -- 35529
	recipe = AddRecipe(35529, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(350, 350, 360, 370, 380)
	recipe:SetRecipeItem(29689, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(29492, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.DPS)
	recipe:AddRepVendor(FAC.THE_ALDOR, REP.EXALTED, 19321)

	-- Reinforced Mining Bag -- 35530
	recipe = AddRecipe(35530, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(325, 325, 335, 340, 345)
	recipe:SetRecipeItem(30444, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(29540, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_BAG")
	recipe:AddRepVendor(FAC.KURENAI, REP.HONORED, 20240)
	recipe:AddRepVendor(FAC.THE_MAGHAR, REP.HONORED, 20241)

	-- Flamescale Belt -- 35531
	recipe = AddRecipe(35531, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(350, 350, 360, 370, 380)
	recipe:SetRecipeItem(29693, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(29494, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddFilters(F.DPS)
	recipe:AddRepVendor(FAC.THE_ALDOR, REP.HONORED, 19321)

	-- Enchanted Clefthoof Leggings -- 35532
	recipe = AddRecipe(35532, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(350, 350, 360, 370, 380)
	recipe:SetRecipeItem(29698, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(29495, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.DPS)
	recipe:AddRepVendor(FAC.THE_SCRYERS, REP.EXALTED, 19331)

	-- Enchanted Clefthoof Gloves -- 35533
	recipe = AddRecipe(35533, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(350, 350, 360, 370, 380)
	recipe:SetRecipeItem(29700, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(29496, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.DPS)
	recipe:AddRepVendor(FAC.THE_SCRYERS, REP.REVERED, 19331)

	-- Enchanted Clefthoof Boots -- 35534
	recipe = AddRecipe(35534, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(350, 350, 360, 370, 380)
	recipe:SetRecipeItem(29701, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(29497, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddFilters(F.DPS)
	recipe:AddRepVendor(FAC.THE_SCRYERS, REP.HONORED, 19331)

	-- Blastguard Pants -- 35535
	recipe = AddRecipe(35535, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(350, 350, 360, 370, 380)
	recipe:SetRecipeItem(29702, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(29498, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.DPS)
	recipe:AddRepVendor(FAC.THE_ALDOR, REP.EXALTED, 19321)

	-- Blastguard Boots -- 35536
	recipe = AddRecipe(35536, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(350, 350, 360, 370, 380)
	recipe:SetRecipeItem(29703, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(29499, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddFilters(F.DPS)
	recipe:AddRepVendor(FAC.THE_ALDOR, REP.REVERED, 19321)

	-- Blastguard Belt -- 35537
	recipe = AddRecipe(35537, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(350, 350, 360, 370, 380)
	recipe:SetRecipeItem(29704, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(29500, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddFilters(F.DPS)
	recipe:AddRepVendor(FAC.THE_ALDOR, REP.HONORED, 19321)

	-- Drums of Panic -- 35538
	recipe = AddRecipe(35538, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(370, 370, 370, 377, 385)
	recipe:SetRecipeItem(29713, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(29532, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CREATED_ITEM")
	recipe:AddRepVendor(FAC.KEEPERS_OF_TIME, REP.HONORED, 21643)

	-- Drums of Restoration -- 35539
	recipe = AddRecipe(35539, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(350, 350, 350, 357, 365)
	recipe:SetRecipeItem(34175, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(29531, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CREATED_ITEM")
	recipe:AddRepVendor(FAC.KURENAI, REP.HONORED, 20240)
	recipe:AddRepVendor(FAC.THE_MAGHAR, REP.HONORED, 20241)

	-- Drums of War -- 35540
	recipe = AddRecipe(35540, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(40, 40, 50, 55, 60)
	recipe:SetCraftedItem(29528, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CREATED_ITEM")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(3069, 4212, 17442, 18754, 18771, 19187, 21087, 33612, 33635, 33681, 66354, 98948, 98964)

	-- Drums of Battle -- 35543
	recipe = AddRecipe(35543, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(365, 365, 365, 372, 380)
	recipe:SetRecipeItem(29717, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(29529, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CREATED_ITEM")
	recipe:AddRepVendor(FAC.THE_SHATAR, REP.HONORED, 21432)

	-- Drums of Speed -- 35544
	recipe = AddRecipe(35544, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(345, 345, 345, 352, 360)
	recipe:SetRecipeItem(34173, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(29530, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CREATED_ITEM")
	recipe:AddRepVendor(FAC.KURENAI, REP.HONORED, 20240)
	recipe:AddRepVendor(FAC.THE_MAGHAR, REP.HONORED, 20241)

	-- Cobrahide Leg Armor -- 35549
	recipe = AddRecipe(35549, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(335, 335, 335, 345, 355)
	recipe:SetRecipeItem(29719, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(29533, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddRepVendor(FAC.HONOR_HOLD, REP.HONORED, 17657)
	recipe:AddRepVendor(FAC.THRALLMAR, REP.HONORED, 17585)

	-- Nethercobra Leg Armor -- 35554
	recipe = AddRecipe(35554, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(365, 365, 365, 375, 385)
	recipe:SetRecipeItem(29722, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(29535, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddRepVendor(FAC.HONOR_HOLD, REP.EXALTED, 17657)
	recipe:AddRepVendor(FAC.THRALLMAR, REP.EXALTED, 17585)

	-- Clefthide Leg Armor -- 35555
	recipe = AddRecipe(35555, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(335, 335, 335, 345, 355)
	recipe:SetRecipeItem(29720, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(29534, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.DPS)
	recipe:AddRepVendor(FAC.CENARION_EXPEDITION, REP.HONORED, 17904)

	-- Nethercleft Leg Armor -- 35557
	recipe = AddRecipe(35557, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(365, 365, 365, 375, 385)
	recipe:SetRecipeItem(29721, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(29536, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.DPS)
	recipe:AddRepVendor(FAC.CENARION_EXPEDITION, REP.EXALTED, 17904)

	-- Cobrascale Hood -- 35558
	recipe = AddRecipe(35558, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(365, 365, 375, 385, 395)
	recipe:SetRecipeItem(29723, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(29502, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.OUTLAND)

	-- Cobrascale Gloves -- 35559
	recipe = AddRecipe(35559, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(365, 365, 375, 385, 395)
	recipe:SetRecipeItem(35302, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(29503, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddMobDrop(24664)
	recipe:AddWorldDrop(Z.OUTLAND)

	-- Windscale Hood -- 35560
	recipe = AddRecipe(35560, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(365, 365, 375, 385, 395)
	recipe:SetRecipeItem(29725, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(29504, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.OUTLAND)

	-- Hood of Primal Life -- 35561
	recipe = AddRecipe(35561, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(365, 365, 375, 385, 395)
	recipe:SetRecipeItem(29726, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(29505, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HEAD")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddWorldDrop(Z.OUTLAND)

	-- Gloves of the Living Touch -- 35562
	recipe = AddRecipe(35562, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(365, 365, 375, 385, 395)
	recipe:SetRecipeItem(35303, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(29506, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddMobDrop(24664)

	-- Windslayer Wraps -- 35563
	recipe = AddRecipe(35563, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(365, 365, 375, 385, 395)
	recipe:SetRecipeItem(29728, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(29507, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.OUTLAND)

	-- Living Dragonscale Helm -- 35564
	recipe = AddRecipe(35564, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(365, 365, 375, 385, 395)
	recipe:SetRecipeItem(29729, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(29508, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HEAD")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddWorldDrop(Z.OUTLAND)

	-- Earthen Netherscale Boots -- 35567
	recipe = AddRecipe(35567, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(365, 365, 375, 385, 395)
	recipe:SetRecipeItem(29730, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(29512, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.OUTLAND)

	-- Windstrike Gloves -- 35568
	recipe = AddRecipe(35568, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(365, 365, 375, 385, 395)
	recipe:SetRecipeItem(35300, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(29509, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddMobDrop(24664)

	-- Netherdrake Helm -- 35572
	recipe = AddRecipe(35572, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(365, 365, 375, 385, 395)
	recipe:SetRecipeItem(29732, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(29510, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.OUTLAND)

	-- Netherdrake Gloves -- 35573
	recipe = AddRecipe(35573, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(365, 365, 375, 385, 395)
	recipe:SetRecipeItem(35301, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(29511, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddMobDrop(24664)

	-- Thick Netherscale Breastplate -- 35574
	recipe = AddRecipe(35574, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(365, 365, 375, 385, 395)
	recipe:SetRecipeItem(29734, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(29514, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.OUTLAND)

	-- Ebon Netherscale Breastplate -- 35575
	recipe = AddRecipe(35575, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 385, 395, 405)
	recipe:SetCraftedItem(29515, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:Retire()

	-- Ebon Netherscale Belt -- 35576
	recipe = AddRecipe(35576, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 385, 395, 405)
	recipe:SetCraftedItem(29516, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:Retire()

	-- Ebon Netherscale Bracers -- 35577
	recipe = AddRecipe(35577, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 385, 395, 405)
	recipe:SetCraftedItem(29517, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:Retire()

	-- Netherstrike Breastplate -- 35580
	recipe = AddRecipe(35580, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 385, 395, 405)
	recipe:SetCraftedItem(29519, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:Retire()

	-- Netherstrike Belt -- 35582
	recipe = AddRecipe(35582, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 385, 395, 405)
	recipe:SetCraftedItem(29520, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:Retire()

	-- Netherstrike Bracers -- 35584
	recipe = AddRecipe(35584, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 385, 395, 405)
	recipe:SetCraftedItem(29521, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:Retire()

	-- Windhawk Hauberk -- 35585
	recipe = AddRecipe(35585, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 385, 395, 405)
	recipe:SetCraftedItem(29522, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:Retire()

	-- Windhawk Belt -- 35587
	recipe = AddRecipe(35587, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 385, 395, 405)
	recipe:SetCraftedItem(29524, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:Retire()

	-- Windhawk Bracers -- 35588
	recipe = AddRecipe(35588, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 385, 395, 405)
	recipe:SetCraftedItem(29523, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:Retire()

	-- Primalstrike Vest -- 35589
	recipe = AddRecipe(35589, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 385, 395, 405)
	recipe:SetCraftedItem(29525, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:Retire()

	-- Primalstrike Belt -- 35590
	recipe = AddRecipe(35590, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 385, 395, 405)
	recipe:SetCraftedItem(29526, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddFilters(F.DPS)
	recipe:Retire()

	-- Primalstrike Bracers -- 35591
	recipe = AddRecipe(35591, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 385, 395, 405)
	recipe:SetCraftedItem(29527, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddFilters(F.DPS)
	recipe:Retire()

	-- Blackstorm Leggings -- 36074
	recipe = AddRecipe(36074, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(260, 260, 280, 290, 300)
	recipe:SetCraftedItem(29964, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(3007, 3069, 3365, 3549, 4212, 4588, 5127, 5564, 7868, 7869, 16688, 16728, 17442, 18754, 21087, 53436, 66354, 98948, 98964)

	-- Wildfeather Leggings -- 36075
	recipe = AddRecipe(36075, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(260, 260, 280, 290, 300)
	recipe:SetCraftedItem(29970, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(3007, 3069, 3365, 3549, 4212, 4588, 5127, 5564, 7871, 16688, 16728, 17442, 18754, 21087, 53436, 66354, 98948, 98964)

	-- Dragonstrike Leggings -- 36076
	recipe = AddRecipe(36076, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(260, 260, 280, 290, 300)
	recipe:SetCraftedItem(29971, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(3007, 3069, 3365, 3549, 4212, 4588, 5127, 5564, 16688, 16728, 17442, 18754, 21087, 53436, 66354, 98948, 98964)

	-- Primalstorm Breastplate -- 36077
	recipe = AddRecipe(36077, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(30, 30, 40, 45, 50)
	recipe:SetCraftedItem(29973, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(3069, 4212, 7868, 7869, 17442, 18754, 19187, 21087, 33612, 33635, 33681, 66354, 98948, 98964)

	-- Living Crystal Breastplate -- 36078
	recipe = AddRecipe(36078, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(30, 30, 40, 45, 50)
	recipe:SetCraftedItem(29974, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(3069, 4212, 7871, 17442, 18754, 19187, 21087, 33612, 33635, 33681, 66354, 98948, 98964)

	-- Golden Dragonstrike Breastplate -- 36079
	recipe = AddRecipe(36079, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(30, 30, 40, 45, 50)
	recipe:SetCraftedItem(29975, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(3069, 4212, 17442, 18754, 19187, 21087, 33612, 33635, 33681, 66354, 98948, 98964)

	-- Belt of Natural Power -- 36349
	recipe = AddRecipe(36349, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(375, 375, 385, 395, 405)
	recipe:SetRecipeItem(30301, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(30042, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddWorldDrop(Z.SERPENTSHRINE_CAVERN, Z.TEMPEST_KEEP)

	-- Belt of Deep Shadow -- 36351
	recipe = AddRecipe(36351, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(375, 375, 385, 395, 405)
	recipe:SetRecipeItem(30302, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(30040, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.SERPENTSHRINE_CAVERN, Z.TEMPEST_KEEP)

	-- Belt of the Black Eagle -- 36352
	recipe = AddRecipe(36352, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(375, 375, 385, 395, 405)
	recipe:SetRecipeItem(30303, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(30046, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.SERPENTSHRINE_CAVERN, Z.TEMPEST_KEEP)

	-- Monsoon Belt -- 36353
	recipe = AddRecipe(36353, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(375, 375, 385, 395, 405)
	recipe:SetRecipeItem(30304, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(30044, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.SERPENTSHRINE_CAVERN, Z.TEMPEST_KEEP)

	-- Boots of Natural Grace -- 36355
	recipe = AddRecipe(36355, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(375, 375, 385, 395, 405)
	recipe:SetRecipeItem(30305, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(30041, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.SERPENTSHRINE_CAVERN, Z.TEMPEST_KEEP)

	-- Boots of Utter Darkness -- 36357
	recipe = AddRecipe(36357, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(375, 375, 385, 395, 405)
	recipe:SetRecipeItem(30306, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(30039, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.SERPENTSHRINE_CAVERN, Z.TEMPEST_KEEP)

	-- Boots of the Crimson Hawk -- 36358
	recipe = AddRecipe(36358, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(375, 375, 385, 395, 405)
	recipe:SetRecipeItem(30307, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(30045, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.SERPENTSHRINE_CAVERN, Z.TEMPEST_KEEP)

	-- Hurricane Boots -- 36359
	recipe = AddRecipe(36359, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(375, 375, 385, 395, 405)
	recipe:SetRecipeItem(30308, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(30043, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.SERPENTSHRINE_CAVERN, Z.TEMPEST_KEEP)

	-- Boots of Shackled Souls -- 39997
	recipe = AddRecipe(39997, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 385, 395, 405)
	recipe:SetRecipeItem(32429, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(32398, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddRepVendor(FAC.ASHTONGUE_DEATHSWORN, REP.FRIENDLY, 23159)

	-- Greaves of Shackled Souls -- 40001
	recipe = AddRecipe(40001, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 385, 395, 405)
	recipe:SetRecipeItem(32431, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(32400, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddRepVendor(FAC.ASHTONGUE_DEATHSWORN, REP.HONORED, 23159)

	-- Waistguard of Shackled Souls -- 40002
	recipe = AddRecipe(40002, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 385, 395, 405)
	recipe:SetRecipeItem(32432, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(32397, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddRepVendor(FAC.ASHTONGUE_DEATHSWORN, REP.HONORED, 23159)

	-- Redeemed Soul Moccasins -- 40003
	recipe = AddRecipe(40003, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 385, 395, 405)
	recipe:SetRecipeItem(32433, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(32394, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddRepVendor(FAC.ASHTONGUE_DEATHSWORN, REP.HONORED, 23159)

	-- Redeemed Soul Wristguards -- 40004
	recipe = AddRecipe(40004, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 385, 395, 405)
	recipe:SetRecipeItem(32434, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(32395, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddRepVendor(FAC.ASHTONGUE_DEATHSWORN, REP.HONORED, 23159)

	-- Redeemed Soul Legguards -- 40005
	recipe = AddRecipe(40005, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 385, 395, 405)
	recipe:SetRecipeItem(32435, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(32396, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddRepVendor(FAC.ASHTONGUE_DEATHSWORN, REP.FRIENDLY, 23159)

	-- Redeemed Soul Cinch -- 40006
	recipe = AddRecipe(40006, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 385, 395, 405)
	recipe:SetRecipeItem(32436, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(32393, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddRepVendor(FAC.ASHTONGUE_DEATHSWORN, REP.FRIENDLY, 23159)

	-- Bracers of Renewed Life -- 41156
	recipe = AddRecipe(41156, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(375, 375, 385, 395, 405)
	recipe:SetRecipeItem(32744, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(32582, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.BLACK_TEMPLE)

	-- Shoulderpads of Renewed Life -- 41157
	recipe = AddRecipe(41157, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(375, 375, 385, 395, 405)
	recipe:SetRecipeItem(35523, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(32583, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.BLACK_TEMPLE, Z.MOUNT_HYJAL)

	-- Swiftstrike Bracers -- 41158
	recipe = AddRecipe(41158, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(375, 375, 385, 395, 405)
	recipe:SetRecipeItem(35527, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(32580, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.MOUNT_HYJAL)

	-- Swiftstrike Shoulders -- 41160
	recipe = AddRecipe(41160, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(375, 375, 385, 395, 405)
	recipe:SetRecipeItem(35528, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(32581, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.BLACK_TEMPLE)

	-- Bindings of Lightning Reflexes -- 41161
	recipe = AddRecipe(41161, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(375, 375, 385, 395, 405)
	recipe:SetRecipeItem(35517, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(32574, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.MOUNT_HYJAL)

	-- Shoulders of Lightning Reflexes -- 41162
	recipe = AddRecipe(41162, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(375, 375, 385, 395, 405)
	recipe:SetRecipeItem(35524, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(32575, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.BLACK_TEMPLE)

	-- Living Earth Bindings -- 41163
	recipe = AddRecipe(41163, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(375, 375, 385, 395, 405)
	recipe:SetRecipeItem(35520, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(32577, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.BLACK_TEMPLE)

	-- Living Earth Shoulders -- 41164
	recipe = AddRecipe(41164, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(375, 375, 385, 395, 405)
	recipe:SetRecipeItem(35521, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(32579, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.BLACK_TEMPLE, Z.MOUNT_HYJAL)

	-- Cloak of Darkness -- 42546
	recipe = AddRecipe(42546, V.TBC, Q.RARE)
	recipe:SetSkillLevels(360, 360, 370, 380, 390)
	recipe:SetRecipeItem(33124, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(33122, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_BACK")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddRepVendor(FAC.THE_VIOLET_EYE, REP.EXALTED, 18255)

	-- Shadowprowler's Chestguard -- 42731
	recipe = AddRecipe(42731, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(365, 365, 375, 385, 395)
	recipe:SetRecipeItem(33205, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(33204, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddRepVendor(FAC.THE_VIOLET_EYE, REP.REVERED, 18255)

	-- Quiver of a Thousand Feathers -- 44359
	recipe = AddRecipe(44359, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(350, 350, 360, 370, 380)
	recipe:SetRecipeItem(34200, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(34105, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_BAG")
	recipe:Retire()

	-- Glove Reinforcements -- 44770
	recipe = AddRecipe(44770, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(34207, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_ITEM_ENHANCEMENT")
	recipe:AddTrainer(3069, 4212, 17442, 18754, 18771, 19187, 21087, 33612, 33635, 33681, 66354, 98948, 98964)

	-- Winter Boots -- 44953
	recipe = AddRecipe(44953, V.TBC, Q.UNCOMMON)
	recipe:SetSkillLevels(285, 285, 285, 285, 285)
	recipe:SetRecipeItem(34262, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(34086, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddVendor(13420, 13433)
	recipe:AddWorldEvent("WINTER_VEIL")

	-- Heavy Knothide Armor Kit -- 44970
	recipe = AddRecipe(44970, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(34330, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_ITEM_ENHANCEMENT")
	recipe:AddTrainer(3069, 4212, 17442, 18754, 18771, 19187, 21087, 33612, 33635, 33681, 66354, 98948, 98964)

	-- Leatherworker's Satchel -- 45100
	recipe = AddRecipe(45100, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(34482, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_BAG")
	recipe:AddTrainer(3069, 4212, 17442, 18754, 18771, 19187, 21087, 33612, 33635, 33681, 66354, 98948, 98964)

	-- Bag of Many Hides -- 45117
	recipe = AddRecipe(45117, V.TBC, Q.UNCOMMON)
	recipe:SetSkillLevels(360, 360, 370, 380, 390)
	recipe:SetRecipeItem(34491, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(34490, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_BAG")
	recipe:AddMobDrop(22143, 22144, 22148, 23022)

	-- Leather Gauntlets of the Sun -- 46132
	recipe = AddRecipe(46132, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(365, 365, 375, 392, 410)
	recipe:SetRecipeItem(35546, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(34372, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.SUNWELL_PLATEAU)

	-- Fletcher's Gloves of the Phoenix -- 46133
	recipe = AddRecipe(46133, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(365, 365, 375, 392, 410)
	recipe:SetRecipeItem(35541, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(34374, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.SUNWELL_PLATEAU)

	-- Gloves of Immortal Dusk -- 46134
	recipe = AddRecipe(46134, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(365, 365, 375, 392, 410)
	recipe:SetRecipeItem(35214, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(34370, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.SUNWELL_PLATEAU)

	-- Sun-Drenched Scale Gloves -- 46135
	recipe = AddRecipe(46135, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(365, 365, 375, 392, 410)
	recipe:SetRecipeItem(35215, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(34376, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.SUNWELL_PLATEAU)

	-- Leather Chestguard of the Sun -- 46136
	recipe = AddRecipe(46136, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(365, 365, 375, 392, 410)
	recipe:SetRecipeItem(35216, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(34371, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddWorldDrop(Z.SUNWELL_PLATEAU)

	-- Embrace of the Phoenix -- 46137
	recipe = AddRecipe(46137, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(365, 365, 375, 392, 410)
	recipe:SetRecipeItem(35217, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(34373, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.SUNWELL_PLATEAU)

	-- Carapace of Sun and Shadow -- 46138
	recipe = AddRecipe(46138, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(365, 365, 375, 392, 410)
	recipe:SetRecipeItem(35218, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(34369, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.SUNWELL_PLATEAU)

	-- Sun-Drenched Scale Chestguard -- 46139
	recipe = AddRecipe(46139, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(365, 365, 375, 392, 410)
	recipe:SetRecipeItem(35549, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(34375, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.SUNWELL_PLATEAU)

	-- ----------------------------------------------------------------------------
	-- Wrath of the Lich King.
	-- ----------------------------------------------------------------------------
	-- Heavy Borean Leather -- 50936
	recipe = AddRecipe(50936, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(15, 15, 25, 30, 35)
	recipe:SetCraftedItem(38425, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_MATERIALS")
	recipe:AddTrainer(3069, 4212, 17442, 18754, 21087, 26911, 26961, 26996, 26998, 28700, 29507, 29508, 29509, 33581, 66354, 98948, 98964)

	-- Iceborne Chestguard -- 50938
	recipe = AddRecipe(50938, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(38408, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(3069, 4212, 17442, 18754, 21087, 26911, 26961, 26996, 26998, 28700, 29507, 29508, 29509, 33581, 66354, 98948, 98964)

	-- Iceborne Leggings -- 50939
	recipe = AddRecipe(50939, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(38410, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(3069, 4212, 17442, 18754, 21087, 26911, 26961, 26996, 26998, 28700, 29507, 29508, 29509, 33581, 66354, 98948, 98964)

	-- Iceborne Shoulderpads -- 50940
	recipe = AddRecipe(50940, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(5, 5, 15, 20, 25)
	recipe:SetCraftedItem(38411, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(3069, 4212, 17442, 18754, 21087, 26911, 26961, 26996, 26998, 28700, 29507, 29508, 29509, 33581, 66354, 98948, 98964)

	-- Iceborne Gloves -- 50941
	recipe = AddRecipe(50941, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(38409, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(3069, 4212, 17442, 18754, 21087, 26911, 26961, 26996, 26998, 28700, 29507, 29508, 29509, 33581, 66354, 98948, 98964)

	-- Iceborne Boots -- 50942
	recipe = AddRecipe(50942, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(38407, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(3069, 4212, 17442, 18754, 21087, 26911, 26961, 26996, 26998, 28700, 29507, 29508, 29509, 33581, 66354, 98948, 98964)

	-- Iceborne Belt -- 50943
	recipe = AddRecipe(50943, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(5, 5, 15, 20, 25)
	recipe:SetCraftedItem(38406, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(3069, 4212, 17442, 18754, 21087, 26911, 26961, 26996, 26998, 28700, 29507, 29508, 29509, 33581, 66354, 98948, 98964)

	-- Arctic Chestpiece -- 50944
	recipe = AddRecipe(50944, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(38400, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(3069, 4212, 17442, 18754, 21087, 26911, 26961, 26996, 26998, 28700, 29507, 29508, 29509, 33581, 66354, 98948, 98964)

	-- Arctic Leggings -- 50945
	recipe = AddRecipe(50945, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(38401, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(3069, 4212, 17442, 18754, 21087, 26911, 26961, 26996, 26998, 28700, 29507, 29508, 29509, 33581, 66354, 98948, 98964)

	-- Arctic Shoulderpads -- 50946
	recipe = AddRecipe(50946, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(5, 5, 15, 20, 25)
	recipe:SetCraftedItem(38402, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_SHOULDER")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(3069, 4212, 17442, 18754, 21087, 26911, 26961, 26996, 26998, 28700, 29507, 29508, 29509, 33581, 66354, 98948, 98964)

	-- Arctic Gloves -- 50947
	recipe = AddRecipe(50947, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(38403, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(3069, 4212, 17442, 18754, 21087, 26911, 26961, 26996, 26998, 28700, 29507, 29508, 29509, 33581, 66354, 98948, 98964)

	-- Arctic Boots -- 50948
	recipe = AddRecipe(50948, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(38404, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(3069, 4212, 17442, 18754, 21087, 26911, 26961, 26996, 26998, 28700, 29507, 29508, 29509, 33581, 66354, 98948, 98964)

	-- Arctic Belt -- 50949
	recipe = AddRecipe(50949, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(5, 5, 15, 20, 25)
	recipe:SetCraftedItem(38405, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(3069, 4212, 17442, 18754, 21087, 26911, 26961, 26996, 26998, 28700, 29507, 29508, 29509, 33581, 66354, 98948, 98964)

	-- Frostscale Chestguard -- 50950
	recipe = AddRecipe(50950, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(38414, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(3069, 4212, 17442, 18754, 21087, 26911, 26961, 26996, 26998, 28700, 29507, 29508, 29509, 33581, 66354, 98948, 98964)

	-- Frostscale Leggings -- 50951
	recipe = AddRecipe(50951, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(38416, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(3069, 4212, 17442, 18754, 21087, 26911, 26961, 26996, 26998, 28700, 29507, 29508, 29509, 33581, 66354, 98948, 98964)

	-- Frostscale Shoulders -- 50952
	recipe = AddRecipe(50952, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(38424, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(3069, 4212, 17442, 18754, 21087, 26911, 26961, 26996, 26998, 28700, 29507, 29508, 29509, 33581, 66354, 98948, 98964)

	-- Frostscale Gloves -- 50953
	recipe = AddRecipe(50953, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(5, 5, 15, 20, 25)
	recipe:SetCraftedItem(38415, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(3069, 4212, 17442, 18754, 21087, 26911, 26961, 26996, 26998, 28700, 29507, 29508, 29509, 33581, 66354, 98948, 98964)

	-- Frostscale Boots -- 50954
	recipe = AddRecipe(50954, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(5, 5, 15, 20, 25)
	recipe:SetCraftedItem(38413, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(3069, 4212, 17442, 18754, 21087, 26911, 26961, 26996, 26998, 28700, 29507, 29508, 29509, 33581, 66354, 98948, 98964)

	-- Frostscale Belt -- 50955
	recipe = AddRecipe(50955, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(38412, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(3069, 4212, 17442, 18754, 21087, 26911, 26961, 26996, 26998, 28700, 29507, 29508, 29509, 33581, 66354, 98948, 98964)

	-- Nerubian Chestguard -- 50956
	recipe = AddRecipe(50956, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(38420, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(3069, 4212, 17442, 18754, 21087, 26911, 26961, 26996, 26998, 28700, 29507, 29508, 29509, 33581, 66354, 98948, 98964)

	-- Nerubian Legguards -- 50957
	recipe = AddRecipe(50957, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(38422, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(3069, 4212, 17442, 18754, 21087, 26911, 26961, 26996, 26998, 28700, 29507, 29508, 29509, 33581, 66354, 98948, 98964)

	-- Nerubian Shoulders -- 50958
	recipe = AddRecipe(50958, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(5, 5, 15, 20, 25)
	recipe:SetCraftedItem(38417, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(3069, 4212, 17442, 18754, 21087, 26911, 26961, 26996, 26998, 28700, 29507, 29508, 29509, 33581, 66354, 98948, 98964)

	-- Nerubian Gloves -- 50959
	recipe = AddRecipe(50959, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(38421, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(3069, 4212, 17442, 18754, 21087, 26911, 26961, 26996, 26998, 28700, 29507, 29508, 29509, 33581, 66354, 98948, 98964)

	-- Nerubian Boots -- 50960
	recipe = AddRecipe(50960, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(5, 5, 15, 20, 25)
	recipe:SetCraftedItem(38419, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(3069, 4212, 17442, 18754, 21087, 26911, 26961, 26996, 26998, 28700, 29507, 29508, 29509, 33581, 66354, 98948, 98964)

	-- Nerubian Belt -- 50961
	recipe = AddRecipe(50961, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(38418, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(3069, 4212, 17442, 18754, 21087, 26911, 26961, 26996, 26998, 28700, 29507, 29508, 29509, 33581, 66354, 98948, 98964)

	-- Borean Armor Kit -- 50962
	recipe = AddRecipe(50962, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(38375, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_ITEM_ENHANCEMENT")
	recipe:AddTrainer(3069, 4212, 17442, 18754, 21087, 26911, 26961, 26996, 26998, 28700, 29507, 29508, 29509, 33581, 66354, 98948, 98964)

	-- Heavy Borean Armor Kit -- 50963
	recipe = AddRecipe(50963, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(20, 20, 30, 35, 40)
	recipe:SetCraftedItem(38376, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_ITEM_ENHANCEMENT")
	recipe:AddTrainer(3069, 4212, 17442, 18754, 21087, 26911, 26961, 26996, 26998, 28700, 29507, 29508, 29509, 33581, 66354, 98948, 98964)

	-- Jormungar Leg Armor -- 50964
	recipe = AddRecipe(50964, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(30, 30, 40, 45, 50)
	recipe:SetCraftedItem(38371, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(3069, 4212, 17442, 18754, 21087, 26911, 26961, 26996, 26998, 28700, 29507, 29508, 29509, 33581, 66354, 98948, 98964)

	-- Frosthide Leg Armor -- 50965
	recipe = AddRecipe(50965, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(38373, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(3069, 4212, 17442, 18754, 21087, 26911, 26961, 26996, 26998, 28700, 29507, 29508, 29509, 33581, 66354, 98948, 98964)

	-- Nerubian Leg Armor -- 50966
	recipe = AddRecipe(50966, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(38372, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(3069, 4212, 17442, 18754, 21087, 26911, 26961, 26996, 26998, 28700, 29507, 29508, 29509, 33581, 66354, 98948, 98964)

	-- Icescale Leg Armor -- 50967
	recipe = AddRecipe(50967, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(38374, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(3069, 4212, 17442, 18754, 21087, 26911, 26961, 26996, 26998, 28700, 29507, 29508, 29509, 33581, 66354, 98948, 98964)

	-- Trapper's Traveling Pack -- 50970
	recipe = AddRecipe(50970, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(415, 415, 420, 422, 425)
	recipe:SetRecipeItem(44509, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(38399, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_BAG")
	recipe:AddRepVendor(FAC.THE_KALUAK, REP.REVERED, 31916, 32763)

	-- Mammoth Mining Bag -- 50971
	recipe = AddRecipe(50971, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(415, 415, 420, 422, 425)
	recipe:SetRecipeItem(44510, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(38347, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_BAG")
	recipe:AddRepVendor(FAC.THE_SONS_OF_HODIR, REP.HONORED, 32540)

	-- Black Chitinguard Boots -- 51568
	recipe = AddRecipe(51568, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(38590, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(3069, 4212, 17442, 18754, 21087, 26911, 26961, 26996, 26998, 28700, 29507, 29508, 29509, 33581, 66354, 98948, 98964)

	-- Dark Arctic Leggings -- 51569
	recipe = AddRecipe(51569, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(20, 20, 30, 35, 40)
	recipe:SetCraftedItem(38591, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(3069, 4212, 17442, 18754, 21087, 26911, 26961, 26996, 26998, 28700, 29507, 29508, 29509, 33581, 66354, 98948, 98964)

	-- Dark Arctic Chestpiece -- 51570
	recipe = AddRecipe(51570, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(20, 20, 30, 35, 40)
	recipe:SetCraftedItem(38592, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(3069, 4212, 17442, 18754, 21087, 26911, 26961, 26996, 26998, 28700, 29507, 29508, 29509, 33581, 66354, 98948, 98964)

	-- Arctic Wristguards -- 51571
	recipe = AddRecipe(51571, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(10, 10, 20, 25, 30)
	recipe:SetCraftedItem(38433, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(3069, 4212, 17442, 18754, 21087, 26911, 26961, 26996, 26998, 28700, 29507, 29508, 29509, 33581, 66354, 98948, 98964)

	-- Arctic Helm -- 51572
	recipe = AddRecipe(51572, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(10, 10, 20, 25, 30)
	recipe:SetCraftedItem(38437, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HEAD")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(3069, 4212, 17442, 18754, 21087, 26911, 26961, 26996, 26998, 28700, 29507, 29508, 29509, 33581, 66354, 98948, 98964)

	-- Bracers of Shackled Souls -- 52733
	recipe = AddRecipe(52733, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 385, 395, 405)
	recipe:SetRecipeItem(32430, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(32399, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddRepVendor(FAC.ASHTONGUE_DEATHSWORN, REP.FRIENDLY, 23159)

	-- Cloak of Tormented Skies -- 55199
	recipe = AddRecipe(55199, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(20, 20, 30, 35, 40)
	recipe:SetCraftedItem(41238, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_BACK")
	recipe:AddFilters(F.DPS, F.TANK)
	recipe:AddTrainer(3069, 4212, 17442, 18754, 21087, 26911, 26961, 26996, 26998, 28700, 29507, 29508, 29509, 33581, 66354, 98948, 98964)

	-- Frostscale Bracers -- 60599
	recipe = AddRecipe(60599, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(10, 10, 20, 25, 30)
	recipe:SetCraftedItem(38436, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(3069, 4212, 17442, 18754, 21087, 26911, 26961, 26996, 26998, 28700, 29507, 29508, 29509, 33581, 66354, 98948, 98964)

	-- Frostscale Helm -- 60600
	recipe = AddRecipe(60600, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(10, 10, 20, 25, 30)
	recipe:SetCraftedItem(38440, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(3069, 4212, 17442, 18754, 21087, 26911, 26961, 26996, 26998, 28700, 29507, 29508, 29509, 33581, 66354, 98948, 98964)

	-- Dark Frostscale Leggings -- 60601
	recipe = AddRecipe(60601, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(20, 20, 30, 35, 40)
	recipe:SetCraftedItem(44436, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(3069, 4212, 17442, 18754, 21087, 26911, 26961, 26996, 26998, 28700, 29507, 29508, 29509, 33581, 66354, 98948, 98964)

	-- Dark Frostscale Breastplate -- 60604
	recipe = AddRecipe(60604, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(20, 20, 30, 35, 40)
	recipe:SetCraftedItem(44437, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(3069, 4212, 17442, 18754, 21087, 26911, 26961, 26996, 26998, 28700, 29507, 29508, 29509, 33581, 66354, 98948, 98964)

	-- Dragonstompers -- 60605
	recipe = AddRecipe(60605, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(44438, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(3069, 4212, 17442, 18754, 21087, 26911, 26961, 26996, 26998, 28700, 29507, 29508, 29509, 33581, 66354, 98948, 98964)

	-- Iceborne Wristguards -- 60607
	recipe = AddRecipe(60607, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(10, 10, 20, 25, 30)
	recipe:SetCraftedItem(38434, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(3069, 4212, 17442, 18754, 21087, 26911, 26961, 26996, 26998, 28700, 29507, 29508, 29509, 33581, 66354, 98948, 98964)

	-- Iceborne Helm -- 60608
	recipe = AddRecipe(60608, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(10, 10, 20, 25, 30)
	recipe:SetCraftedItem(38438, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(3069, 4212, 17442, 18754, 21087, 26911, 26961, 26996, 26998, 28700, 29507, 29508, 29509, 33581, 66354, 98948, 98964)

	-- Dark Iceborne Leggings -- 60611
	recipe = AddRecipe(60611, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(20, 20, 30, 35, 40)
	recipe:SetCraftedItem(44440, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(3069, 4212, 17442, 18754, 21087, 26911, 26961, 26996, 26998, 28700, 29507, 29508, 29509, 33581, 66354, 98948, 98964)

	-- Dark Iceborne Chestguard -- 60613
	recipe = AddRecipe(60613, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(20, 20, 30, 35, 40)
	recipe:SetCraftedItem(44441, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(3069, 4212, 17442, 18754, 21087, 26911, 26961, 26996, 26998, 28700, 29507, 29508, 29509, 33581, 66354, 98948, 98964)

	-- Bugsquashers -- 60620
	recipe = AddRecipe(60620, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(44442, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(3069, 4212, 17442, 18754, 21087, 26911, 26961, 26996, 26998, 28700, 29507, 29508, 29509, 33581, 66354, 98948, 98964)

	-- Nerubian Bracers -- 60622
	recipe = AddRecipe(60622, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(10, 10, 20, 25, 30)
	recipe:SetCraftedItem(38435, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(3069, 4212, 17442, 18754, 21087, 26911, 26961, 26996, 26998, 28700, 29507, 29508, 29509, 33581, 66354, 98948, 98964)

	-- Nerubian Helm -- 60624
	recipe = AddRecipe(60624, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(10, 10, 20, 25, 30)
	recipe:SetCraftedItem(38439, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(3069, 4212, 17442, 18754, 21087, 26911, 26961, 26996, 26998, 28700, 29507, 29508, 29509, 33581, 66354, 98948, 98964)

	-- Dark Nerubian Leggings -- 60627
	recipe = AddRecipe(60627, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(20, 20, 30, 35, 40)
	recipe:SetCraftedItem(44443, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(3069, 4212, 17442, 18754, 21087, 26911, 26961, 26996, 26998, 28700, 29507, 29508, 29509, 33581, 66354, 98948, 98964)

	-- Dark Nerubian Chestpiece -- 60629
	recipe = AddRecipe(60629, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(20, 20, 30, 35, 40)
	recipe:SetCraftedItem(44444, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(3069, 4212, 17442, 18754, 21087, 26911, 26961, 26996, 26998, 28700, 29507, 29508, 29509, 33581, 66354, 98948, 98964)

	-- Scaled Icewalkers -- 60630
	recipe = AddRecipe(60630, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(44445, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddTrainer(3069, 4212, 17442, 18754, 21087, 26911, 26961, 26996, 26998, 28700, 29507, 29508, 29509, 33581, 66354, 98948, 98964)

	-- Cloak of Harsh Winds -- 60631
	recipe = AddRecipe(60631, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(5, 5, 15, 20, 25)
	recipe:SetCraftedItem(38441, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_BACK")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(3069, 4212, 17442, 18754, 21087, 26911, 26961, 26996, 26998, 28700, 29507, 29508, 29509, 33581, 66354, 98948, 98964)

	-- Ice Striker's Cloak -- 60637
	recipe = AddRecipe(60637, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(65, 65, 75, 80, 85)
	recipe:SetCraftedItem(43566, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_BACK")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(3069, 4212, 17442, 18754, 21087, 26911, 26961, 26996, 26998, 28700, 29507, 29508, 29509, 33581, 66354, 98948, 98964)

	-- Durable Nerubhide Cape -- 60640
	recipe = AddRecipe(60640, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(65, 65, 75, 80, 85)
	recipe:SetCraftedItem(43565, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_BACK")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.TANK)
	recipe:AddTrainer(3069, 4212, 17442, 18754, 21087, 26911, 26961, 26996, 26998, 28700, 29507, 29508, 29509, 33581, 66354, 98948, 98964)

	-- Pack of Endless Pockets -- 60643
	recipe = AddRecipe(60643, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(40, 40, 50, 55, 60)
	recipe:SetCraftedItem(44446, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_BAG")
	recipe:AddTrainer(3069, 4212, 17442, 18754, 21087, 26911, 26961, 26996, 26998, 28700, 29507, 29508, 29509, 33581, 66354, 98948, 98964)

	-- Razorstrike Breastplate -- 60649
	recipe = AddRecipe(60649, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(43129, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(3069, 4212, 17442, 18754, 21087, 26911, 26961, 26996, 26998, 28700, 29507, 29508, 29509, 33581, 66354, 98948, 98964)

	-- Virulent Spaulders -- 60651
	recipe = AddRecipe(60651, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(45, 45, 55, 60, 65)
	recipe:SetCraftedItem(43130, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(3069, 4212, 17442, 18754, 21087, 26911, 26961, 26996, 26998, 28700, 29507, 29508, 29509, 33581, 66354, 98948, 98964)

	-- Eaglebane Bracers -- 60652
	recipe = AddRecipe(60652, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(45, 45, 55, 60, 65)
	recipe:SetCraftedItem(43131, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(3069, 4212, 17442, 18754, 21087, 26911, 26961, 26996, 26998, 28700, 29507, 29508, 29509, 33581, 66354, 98948, 98964)

	-- Nightshock Hood -- 60655
	recipe = AddRecipe(60655, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(43132, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(3069, 4212, 17442, 18754, 21087, 26911, 26961, 26996, 26998, 28700, 29507, 29508, 29509, 33581, 66354, 98948, 98964)

	-- Nightshock Girdle -- 60658
	recipe = AddRecipe(60658, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(45, 45, 55, 60, 65)
	recipe:SetCraftedItem(43133, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(3069, 4212, 17442, 18754, 21087, 26911, 26961, 26996, 26998, 28700, 29507, 29508, 29509, 33581, 66354, 98948, 98964)

	-- Leggings of Visceral Strikes -- 60660
	recipe = AddRecipe(60660, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(42731, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(3069, 4212, 17442, 18754, 21087, 26911, 26961, 26996, 26998, 28700, 29507, 29508, 29509, 33581, 66354, 98948, 98964)

	-- Seafoam Gauntlets -- 60665
	recipe = AddRecipe(60665, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(45, 45, 55, 60, 65)
	recipe:SetCraftedItem(43255, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(3069, 4212, 17442, 18754, 21087, 26911, 26961, 26996, 26998, 28700, 29507, 29508, 29509, 33581, 66354, 98948, 98964)

	-- Jormscale Footpads -- 60666
	recipe = AddRecipe(60666, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(45, 45, 55, 60, 65)
	recipe:SetCraftedItem(43256, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(3069, 4212, 17442, 18754, 21087, 26911, 26961, 26996, 26998, 28700, 29507, 29508, 29509, 33581, 66354, 98948, 98964)

	-- Wildscale Breastplate -- 60669
	recipe = AddRecipe(60669, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(43257, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(3069, 4212, 17442, 18754, 21087, 26911, 26961, 26996, 26998, 28700, 29507, 29508, 29509, 33581, 66354, 98948, 98964)

	-- Purehorn Spaulders -- 60671
	recipe = AddRecipe(60671, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(45, 45, 55, 60, 65)
	recipe:SetCraftedItem(43258, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(3069, 4212, 17442, 18754, 21087, 26911, 26961, 26996, 26998, 28700, 29507, 29508, 29509, 33581, 66354, 98948, 98964)

	-- Eviscerator's Facemask -- 60697
	recipe = AddRecipe(60697, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(420, 420, 425, 430, 435)
	recipe:SetRecipeItem(44513, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(43260, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(32515)

	-- Eviscerator's Shoulderpads -- 60702
	recipe = AddRecipe(60702, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(420, 420, 425, 430, 435)
	recipe:SetRecipeItem(44514, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(43433, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(32515)

	-- Eviscerator's Chestguard -- 60703
	recipe = AddRecipe(60703, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(420, 420, 425, 430, 435)
	recipe:SetRecipeItem(44515, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(43434, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(32515)

	-- Eviscerator's Bindings -- 60704
	recipe = AddRecipe(60704, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(420, 420, 425, 430, 435)
	recipe:SetRecipeItem(44516, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(43435, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(32515)

	-- Eviscerator's Gauntlets -- 60705
	recipe = AddRecipe(60705, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(425, 425, 430, 435, 440)
	recipe:SetRecipeItem(44517, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(43436, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(32515)

	-- Eviscerator's Waistguard -- 60706
	recipe = AddRecipe(60706, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(425, 425, 430, 435, 440)
	recipe:SetRecipeItem(44518, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(43437, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(32515)

	-- Eviscerator's Legguards -- 60711
	recipe = AddRecipe(60711, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(425, 425, 430, 435, 440)
	recipe:SetRecipeItem(44519, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(43438, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(32515)

	-- Eviscerator's Treads -- 60712
	recipe = AddRecipe(60712, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(425, 425, 430, 435, 440)
	recipe:SetRecipeItem(44520, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(43439, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(32515)

	-- Overcast Headguard -- 60715
	recipe = AddRecipe(60715, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(420, 420, 425, 430, 435)
	recipe:SetRecipeItem(44521, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(43261, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HEAD")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(32515)

	-- Overcast Spaulders -- 60716
	recipe = AddRecipe(60716, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(420, 420, 425, 430, 435)
	recipe:SetRecipeItem(44522, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(43262, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(32515)

	-- Overcast Chestguard -- 60718
	recipe = AddRecipe(60718, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(420, 420, 425, 430, 435)
	recipe:SetRecipeItem(44523, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(43263, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(32515)

	-- Overcast Bracers -- 60720
	recipe = AddRecipe(60720, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(420, 420, 425, 430, 435)
	recipe:SetRecipeItem(44524, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(43264, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddVendor(32515)

	-- Overcast Handwraps -- 60721
	recipe = AddRecipe(60721, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(425, 425, 430, 435, 440)
	recipe:SetRecipeItem(44525, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(43265, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(32515)

	-- Overcast Belt -- 60723
	recipe = AddRecipe(60723, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(425, 425, 430, 435, 440)
	recipe:SetRecipeItem(44526, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(43266, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(32515)

	-- Overcast Leggings -- 60725
	recipe = AddRecipe(60725, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(425, 425, 430, 435, 440)
	recipe:SetRecipeItem(44527, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(43271, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(32515)

	-- Overcast Boots -- 60727
	recipe = AddRecipe(60727, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(425, 425, 430, 435, 440)
	recipe:SetRecipeItem(44528, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(43273, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(32515)

	-- Swiftarrow Helm -- 60728
	recipe = AddRecipe(60728, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(420, 420, 425, 430, 435)
	recipe:SetRecipeItem(44530, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(43447, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(32515)

	-- Swiftarrow Shoulderguards -- 60729
	recipe = AddRecipe(60729, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(420, 420, 425, 430, 435)
	recipe:SetRecipeItem(44531, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(43449, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(32515)

	-- Swiftarrow Hauberk -- 60730
	recipe = AddRecipe(60730, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(420, 420, 425, 430, 435)
	recipe:SetRecipeItem(44532, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(43445, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(32515)

	-- Swiftarrow Bracers -- 60731
	recipe = AddRecipe(60731, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(420, 420, 425, 430, 435)
	recipe:SetRecipeItem(44533, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(43444, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(32515)

	-- Swiftarrow Gauntlets -- 60732
	recipe = AddRecipe(60732, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(425, 425, 430, 435, 440)
	recipe:SetRecipeItem(44534, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(43446, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(32515)

	-- Swiftarrow Belt -- 60734
	recipe = AddRecipe(60734, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(425, 425, 430, 435, 440)
	recipe:SetRecipeItem(44535, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(43442, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(32515)

	-- Swiftarrow Leggings -- 60735
	recipe = AddRecipe(60735, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(425, 425, 430, 435, 440)
	recipe:SetRecipeItem(44536, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(43448, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(32515)

	-- Swiftarrow Boots -- 60737
	recipe = AddRecipe(60737, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(425, 425, 430, 435, 440)
	recipe:SetRecipeItem(44537, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(43443, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(32515)

	-- Stormhide Crown -- 60743
	recipe = AddRecipe(60743, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(420, 420, 425, 430, 435)
	recipe:SetRecipeItem(44538, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(43455, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HEAD")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(32515)

	-- Stormhide Shoulders -- 60746
	recipe = AddRecipe(60746, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(420, 420, 425, 430, 435)
	recipe:SetRecipeItem(44539, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(43457, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(32515)

	-- Stormhide Hauberk -- 60747
	recipe = AddRecipe(60747, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(420, 420, 425, 430, 435)
	recipe:SetRecipeItem(44540, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(43453, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(32515)

	-- Stormhide Wristguards -- 60748
	recipe = AddRecipe(60748, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(420, 420, 425, 430, 435)
	recipe:SetRecipeItem(44541, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(43452, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(32515)

	-- Stormhide Grips -- 60749
	recipe = AddRecipe(60749, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(425, 425, 430, 435, 440)
	recipe:SetRecipeItem(44542, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(43454, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(32515)

	-- Stormhide Belt -- 60750
	recipe = AddRecipe(60750, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(425, 425, 430, 435, 440)
	recipe:SetRecipeItem(44543, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(43450, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddVendor(32515)

	-- Stormhide Legguards -- 60751
	recipe = AddRecipe(60751, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(425, 425, 430, 435, 440)
	recipe:SetRecipeItem(44544, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(43456, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(32515)

	-- Stormhide Stompers -- 60752
	recipe = AddRecipe(60752, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(425, 425, 430, 435, 440)
	recipe:SetRecipeItem(44545, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(43451, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(32515)

	-- Giantmaim Legguards -- 60754
	recipe = AddRecipe(60754, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(440, 440, 450, 455, 460)
	recipe:SetRecipeItem(44546, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(43458, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(32515)

	-- Giantmaim Bracers -- 60755
	recipe = AddRecipe(60755, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(440, 440, 450, 455, 460)
	recipe:SetRecipeItem(44547, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(43459, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(32515)

	-- Revenant's Breastplate -- 60756
	recipe = AddRecipe(60756, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(440, 440, 450, 455, 460)
	recipe:SetRecipeItem(44548, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(43461, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(32515)

	-- Revenant's Treads -- 60757
	recipe = AddRecipe(60757, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(440, 440, 450, 455, 460)
	recipe:SetRecipeItem(44549, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(43469, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(32515)

	-- Trollwoven Spaulders -- 60758
	recipe = AddRecipe(60758, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(440, 440, 450, 455, 460)
	recipe:SetRecipeItem(44550, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(43481, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(32515)

	-- Trollwoven Girdle -- 60759
	recipe = AddRecipe(60759, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(440, 440, 450, 455, 460)
	recipe:SetRecipeItem(44551, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(43484, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(32515)

	-- Earthgiving Legguards -- 60760
	recipe = AddRecipe(60760, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(440, 440, 450, 455, 460)
	recipe:SetRecipeItem(44552, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(43495, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(32515)

	-- Earthgiving Boots -- 60761
	recipe = AddRecipe(60761, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(440, 440, 450, 455, 460)
	recipe:SetRecipeItem(44553, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(43502, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(32515)

	-- Polar Vest -- 60996
	recipe = AddRecipe(60996, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(425, 425, 435, 445, 455)
	recipe:SetRecipeItem(44584, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(43590, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddVendor(32515)

	-- Polar Cord -- 60997
	recipe = AddRecipe(60997, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(420, 420, 430, 440, 450)
	recipe:SetRecipeItem(44585, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(43591, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddVendor(32515)

	-- Polar Boots -- 60998
	recipe = AddRecipe(60998, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(420, 420, 430, 440, 450)
	recipe:SetRecipeItem(44586, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(43592, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddVendor(32515)

	-- Icy Scale Chestguard -- 60999
	recipe = AddRecipe(60999, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(425, 425, 435, 445, 455)
	recipe:SetRecipeItem(44587, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(43593, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddVendor(32515)

	-- Icy Scale Belt -- 61000
	recipe = AddRecipe(61000, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(420, 420, 430, 440, 450)
	recipe:SetRecipeItem(44588, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(43594, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddVendor(32515)

	-- Icy Scale Boots -- 61002
	recipe = AddRecipe(61002, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(420, 420, 430, 440, 450)
	recipe:SetRecipeItem(44589, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(43595, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddVendor(32515)

	-- Windripper Boots -- 62176
	recipe = AddRecipe(62176, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(440, 440, 450, 455, 460)
	recipe:SetRecipeItem(44932, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(44930, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(32515)

	-- Windripper Leggings -- 62177
	recipe = AddRecipe(62177, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(440, 440, 450, 455, 460)
	recipe:SetRecipeItem(44933, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(44931, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(32515)

	-- Earthen Leg Armor -- 62448
	recipe = AddRecipe(62448, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(44963, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_ITEM_ENHANCEMENT")
	recipe:AddTrainer(3069, 4212, 17442, 18754, 21087, 26911, 26961, 26996, 26998, 28700, 29507, 29508, 29509, 33581, 66354, 98948, 98964)

	-- Belt of Dragons -- 63194
	recipe = AddRecipe(63194, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(450, 450, 455, 465, 475)
	recipe:SetRecipeItem(45094, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(45553, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.ULDUAR)

	-- Boots of Living Scale -- 63195
	recipe = AddRecipe(63195, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(450, 450, 455, 465, 475)
	recipe:SetRecipeItem(45095, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(45095, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.ULDUAR)

	-- Blue Belt of Chaos -- 63196
	recipe = AddRecipe(63196, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(450, 450, 455, 465, 475)
	recipe:SetRecipeItem(45096, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(45096, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.ULDUAR)

	-- Lightning Grounded Boots -- 63197
	recipe = AddRecipe(63197, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(450, 450, 455, 465, 475)
	recipe:SetRecipeItem(45097, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(45097, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.ULDUAR)

	-- Death-warmed Belt -- 63198
	recipe = AddRecipe(63198, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(450, 450, 455, 465, 475)
	recipe:SetRecipeItem(45098, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(45098, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.ULDUAR)

	-- Footpads of Silence -- 63199
	recipe = AddRecipe(63199, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(450, 450, 455, 465, 475)
	recipe:SetRecipeItem(45099, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(45099, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.ULDUAR)

	-- Belt of Arctic Life -- 63200
	recipe = AddRecipe(63200, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(450, 450, 455, 465, 475)
	recipe:SetRecipeItem(45100, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(45100, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.ULDUAR)

	-- Boots of Wintry Endurance -- 63201
	recipe = AddRecipe(63201, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(450, 450, 455, 465, 475)
	recipe:SetRecipeItem(45101, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(45101, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.ULDUAR)

	-- Borean Leather -- 64661
	recipe = AddRecipe(64661, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(33568, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_MATERIALS")
	recipe:AddTrainer(3069, 4212, 17442, 18754, 21087, 26911, 26961, 26996, 26998, 28700, 29507, 29508, 29509, 33581, 66354, 98948, 98964)

	-- Ensorcelled Nerubian Breastplate -- 67080
	recipe = AddRecipe(67080, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(450, 450, 460, 467, 475)
	recipe:SetRecipeItem(47628, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(47597, "BIND_ON_EQUIP")
	recipe:SetRequiredFaction("Alliance")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.TRIAL_OF_THE_CRUSADER)
	recipe:AddCustom("NORMAL")

	-- Black Chitin Bracers -- 67081
	recipe = AddRecipe(67081, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(450, 450, 460, 467, 475)
	recipe:SetRecipeItem(47629, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(47579, "BIND_ON_EQUIP")
	recipe:SetRequiredFaction("Alliance")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.TRIAL_OF_THE_CRUSADER)
	recipe:AddCustom("NORMAL")

	-- Crusader's Dragonscale Breastplate -- 67082
	recipe = AddRecipe(67082, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(450, 450, 460, 467, 475)
	recipe:SetRecipeItem(47630, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(47595, "BIND_ON_EQUIP")
	recipe:SetRequiredFaction("Alliance")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.TRIAL_OF_THE_CRUSADER)
	recipe:AddCustom("NORMAL")

	-- Crusader's Dragonscale Bracers -- 67083
	recipe = AddRecipe(67083, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(450, 450, 460, 467, 475)
	recipe:SetRecipeItem(47631, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(47576, "BIND_ON_EQUIP")
	recipe:SetRequiredFaction("Alliance")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.TRIAL_OF_THE_CRUSADER)
	recipe:AddCustom("NORMAL")

	-- Lunar Eclipse Robes -- 67084
	recipe = AddRecipe(67084, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(450, 450, 460, 467, 475)
	recipe:SetRecipeItem(47632, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(47602, "BIND_ON_EQUIP")
	recipe:SetRequiredFaction("Alliance")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.TRIAL_OF_THE_CRUSADER)
	recipe:AddCustom("NORMAL")

	-- Moonshadow Armguards -- 67085
	recipe = AddRecipe(67085, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(450, 450, 460, 467, 475)
	recipe:SetRecipeItem(47633, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(47583, "BIND_ON_EQUIP")
	recipe:SetRequiredFaction("Alliance")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.TRIAL_OF_THE_CRUSADER)
	recipe:AddCustom("NORMAL")

	-- Knightbane Carapace -- 67086
	recipe = AddRecipe(67086, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(450, 450, 460, 467, 475)
	recipe:SetRecipeItem(47634, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(47599, "BIND_ON_EQUIP")
	recipe:SetRequiredFaction("Alliance")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.TRIAL_OF_THE_CRUSADER)
	recipe:AddCustom("NORMAL")

	-- Bracers of Swift Death -- 67087
	recipe = AddRecipe(67087, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(450, 450, 460, 467, 475)
	recipe:SetRecipeItem(47635, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(47581, "BIND_ON_PICKUP")
	recipe:SetRequiredFaction("Alliance")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.TRIAL_OF_THE_CRUSADER)
	recipe:AddCustom("NORMAL")

	-- Ensorcelled Nerubian Breastplate -- 67136
	recipe = AddRecipe(67136, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(450, 450, 460, 467, 475)
	recipe:SetRecipeItem(47650, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(47598, "BIND_ON_EQUIP")
	recipe:SetRequiredFaction("Horde")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.TRIAL_OF_THE_CRUSADER)
	recipe:AddCustom("NORMAL")

	-- Black Chitin Bracers -- 67137
	recipe = AddRecipe(67137, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(450, 450, 460, 467, 475)
	recipe:SetRecipeItem(47646, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(47580, "BIND_ON_EQUIP")
	recipe:SetRequiredFaction("Horde")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.TRIAL_OF_THE_CRUSADER)
	recipe:AddCustom("NORMAL")

	-- Crusader's Dragonscale Breastplate -- 67138
	recipe = AddRecipe(67138, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(450, 450, 460, 467, 475)
	recipe:SetRecipeItem(47649, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(47596, "BIND_ON_EQUIP")
	recipe:SetRequiredFaction("Horde")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.TRIAL_OF_THE_CRUSADER)
	recipe:AddCustom("NORMAL")

	-- Bracers of Swift Death -- 67139
	recipe = AddRecipe(67139, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(450, 450, 460, 467, 475)
	recipe:SetRecipeItem(47647, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(47582, "BIND_ON_EQUIP")
	recipe:SetRequiredFaction("Horde")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.TRIAL_OF_THE_CRUSADER)
	recipe:AddCustom("NORMAL")

	-- Lunar Eclipse Robes -- 67140
	recipe = AddRecipe(67140, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(450, 450, 460, 467, 475)
	recipe:SetRecipeItem(47652, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(47601, "BIND_ON_EQUIP")
	recipe:SetRequiredFaction("Horde")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.TRIAL_OF_THE_CRUSADER)
	recipe:AddCustom("NORMAL")

	-- Moonshadow Armguards -- 67141
	recipe = AddRecipe(67141, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(450, 450, 460, 467, 475)
	recipe:SetRecipeItem(47653, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(47584, "BIND_ON_EQUIP")
	recipe:SetRequiredFaction("Horde")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.TRIAL_OF_THE_CRUSADER)
	recipe:AddCustom("NORMAL")

	-- Knightbane Carapace -- 67142
	recipe = AddRecipe(67142, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(450, 450, 460, 467, 475)
	recipe:SetRecipeItem(47651, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(47600, "BIND_ON_EQUIP")
	recipe:SetRequiredFaction("Horde")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.TRIAL_OF_THE_CRUSADER)
	recipe:AddCustom("NORMAL")

	-- Crusader's Dragonscale Bracers -- 67143
	recipe = AddRecipe(67143, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(450, 450, 460, 467, 475)
	recipe:SetRecipeItem(47648, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(47577, "BIND_ON_EQUIP")
	recipe:SetRequiredFaction("Horde")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.TRIAL_OF_THE_CRUSADER)
	recipe:AddCustom("NORMAL")

	-- Drums of Forgotten Kings -- 69386
	recipe = AddRecipe(69386, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 85, 90, 95)
	recipe:SetCraftedItem(49633, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CREATED_ITEM")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(3069, 4212, 17442, 18754, 21087, 26911, 26961, 26996, 26998, 28700, 29507, 29508, 29509, 33581, 66354, 98948, 98964)

	-- Drums of the Wild -- 69388
	recipe = AddRecipe(69388, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 85, 90, 95)
	recipe:SetCraftedItem(49634, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CREATED_ITEM")
	recipe:AddTrainer(3069, 4212, 17442, 18754, 21087, 26911, 26961, 26996, 26998, 28700, 29507, 29508, 29509, 33581, 66354, 98948, 98964)

	-- Legwraps of Unleashed Nature -- 70554
	recipe = AddRecipe(70554, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(450, 450, 460, 465, 470)
	recipe:SetRecipeItem(49957, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(49898, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddRepVendor(FAC.THE_ASHEN_VERDICT, REP.REVERED, 37687)

	-- Blessed Cenarion Boots -- 70555
	recipe = AddRecipe(70555, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(450, 450, 460, 465, 470)
	recipe:SetRecipeItem(49958, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(49894, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddRepVendor(FAC.THE_ASHEN_VERDICT, REP.HONORED, 37687)

	-- Bladeborn Leggings -- 70556
	recipe = AddRecipe(70556, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(450, 450, 460, 465, 470)
	recipe:SetRecipeItem(49959, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(49899, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddRepVendor(FAC.THE_ASHEN_VERDICT, REP.REVERED, 37687)

	-- Footpads of Impending Death -- 70557
	recipe = AddRecipe(70557, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(450, 450, 460, 465, 470)
	recipe:SetRecipeItem(49961, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(49895, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddRepVendor(FAC.THE_ASHEN_VERDICT, REP.HONORED, 37687)

	-- Lightning-Infused Leggings -- 70558
	recipe = AddRecipe(70558, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(450, 450, 460, 465, 470)
	recipe:SetRecipeItem(49962, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(49900, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddRepVendor(FAC.THE_ASHEN_VERDICT, REP.REVERED, 37687)

	-- Earthsoul Boots -- 70559
	recipe = AddRecipe(70559, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(450, 450, 460, 465, 470)
	recipe:SetRecipeItem(49963, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(49896, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddRepVendor(FAC.THE_ASHEN_VERDICT, REP.HONORED, 37687)

	-- Draconic Bonesplinter Legguards -- 70560
	recipe = AddRecipe(70560, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(450, 450, 460, 465, 470)
	recipe:SetRecipeItem(49965, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(49901, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddRepVendor(FAC.THE_ASHEN_VERDICT, REP.REVERED, 37687)

	-- Rock-Steady Treads -- 70561
	recipe = AddRecipe(70561, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(450, 450, 460, 465, 470)
	recipe:SetRecipeItem(49966, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(49897, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddRepVendor(FAC.THE_ASHEN_VERDICT, REP.HONORED, 37687)

	-- ----------------------------------------------------------------------------
	-- Cataclysm.
	-- ----------------------------------------------------------------------------
	-- Savage Armor Kit -- 78379
	recipe = AddRecipe(78379, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(56477, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_ITEM_ENHANCEMENT")
	recipe:AddTrainer(3007, 3069, 3365, 3549, 3967, 4212, 4588, 5127, 5564, 16688, 16728, 17442, 18754, 21087, 53436, 66354, 98948, 98964)

	-- Savage Cloak -- 78380
	recipe = AddRecipe(78380, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(10, 10, 20, 25, 30)
	recipe:SetCraftedItem(56480, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_BACK")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(3007, 3069, 3365, 3549, 3967, 4212, 4588, 5127, 5564, 16688, 16728, 17442, 18754, 21087, 53436, 66354, 98948, 98964)

	-- Tsunami Bracers -- 78388
	recipe = AddRecipe(78388, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(10, 10, 20, 25, 30)
	recipe:SetCraftedItem(56481, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddTrainer(3007, 3069, 3365, 3549, 3967, 4212, 4588, 5127, 5564, 16688, 16728, 17442, 18754, 21087, 53436, 66354, 98948, 98964)

	-- Tsunami Belt -- 78396
	recipe = AddRecipe(78396, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(20, 20, 30, 35, 40)
	recipe:SetCraftedItem(56482, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddTrainer(3007, 3069, 3365, 3549, 3967, 4212, 4588, 5127, 5564, 16688, 16728, 17442, 18754, 21087, 53436, 66354, 98948, 98964)

	-- Darkbrand Bracers -- 78398
	recipe = AddRecipe(78398, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(56483, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddTrainer(3007, 3069, 3365, 3549, 3967, 4212, 4588, 5127, 5564, 16688, 16728, 17442, 18754, 21087, 53436, 66354, 98948, 98964)

	-- Darkbrand Gloves -- 78399
	recipe = AddRecipe(78399, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(15, 15, 25, 30, 35)
	recipe:SetCraftedItem(56484, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddTrainer(3007, 3069, 3365, 3549, 3967, 4212, 4588, 5127, 5564, 16688, 16728, 17442, 18754, 21087, 53436, 66354, 98948, 98964)

	-- Hardened Scale Cloak -- 78405
	recipe = AddRecipe(78405, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(20, 20, 30, 35, 40)
	recipe:SetCraftedItem(56489, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_BACK")
	recipe:AddFilters(F.DPS, F.TANK)
	recipe:AddTrainer(3007, 3069, 3365, 3549, 3967, 4212, 4588, 5127, 5564, 16688, 16728, 17442, 18754, 21087, 53436, 66354, 98948, 98964)

	-- Tsunami Gloves -- 78406
	recipe = AddRecipe(78406, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(56490, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddTrainer(3007, 3069, 3365, 3549, 3967, 4212, 4588, 5127, 5564, 16688, 16728, 17442, 18754, 21087, 53436, 66354, 98948, 98964)

	-- Darkbrand Boots -- 78407
	recipe = AddRecipe(78407, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(15, 15, 25, 30, 35)
	recipe:SetCraftedItem(56491, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddTrainer(3007, 3069, 3365, 3549, 3967, 4212, 4588, 5127, 5564, 16688, 16728, 17442, 18754, 21087, 53436, 66354, 98948, 98964)

	-- Tsunami Boots -- 78410
	recipe = AddRecipe(78410, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(56494, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddTrainer(3007, 3069, 3365, 3549, 3967, 4212, 4588, 5127, 5564, 16688, 16728, 17442, 18754, 21087, 53436, 66354, 98948, 98964)

	-- Darkbrand Shoulders -- 78411
	recipe = AddRecipe(78411, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(56495, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_SHOULDER")
	recipe:AddTrainer(3007, 3069, 3365, 3549, 3967, 4212, 4588, 5127, 5564, 16688, 16728, 17442, 18754, 21087, 53436, 66354, 98948, 98964)

	-- Tsunami Shoulders -- 78415
	recipe = AddRecipe(78415, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(5, 5, 15, 20, 25)
	recipe:SetCraftedItem(56498, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_SHOULDER")
	recipe:AddTrainer(3007, 3069, 3365, 3549, 3967, 4212, 4588, 5127, 5564, 16688, 16728, 17442, 18754, 21087, 53436, 66354, 98948, 98964)

	-- Darkbrand Belt -- 78416
	recipe = AddRecipe(78416, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(5, 5, 15, 20, 25)
	recipe:SetCraftedItem(56499, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddTrainer(3007, 3069, 3365, 3549, 3967, 4212, 4588, 5127, 5564, 16688, 16728, 17442, 18754, 21087, 53436, 66354, 98948, 98964)

	-- Scorched Leg Armor -- 78419
	recipe = AddRecipe(78419, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(56502, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(3007, 3069, 3365, 3549, 3967, 4212, 4588, 5127, 5564, 16688, 16728, 17442, 18754, 21087, 53436, 66354, 98948, 98964)

	-- Twilight Leg Armor -- 78420
	recipe = AddRecipe(78420, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(30, 30, 40, 45, 50)
	recipe:SetCraftedItem(56503, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(3007, 3069, 3365, 3549, 3967, 4212, 4588, 5127, 5564, 16688, 16728, 17442, 18754, 21087, 53436, 66354, 98948, 98964)

	-- Tsunami Chestguard -- 78423
	recipe = AddRecipe(78423, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(40, 40, 50, 55, 60)
	recipe:SetCraftedItem(56504, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddTrainer(3007, 3069, 3365, 3549, 3967, 4212, 4588, 5127, 5564, 16688, 16728, 17442, 18754, 21087, 53436, 66354, 98948, 98964)

	-- Darkbrand Helm -- 78424
	recipe = AddRecipe(78424, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(40, 40, 50, 55, 60)
	recipe:SetCraftedItem(56505, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HEAD")
	recipe:AddTrainer(3007, 3069, 3365, 3549, 3967, 4212, 4588, 5127, 5564, 16688, 16728, 17442, 18754, 21087, 53436, 66354, 98948, 98964)

	-- Tsunami Leggings -- 78427
	recipe = AddRecipe(78427, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(30, 30, 40, 45, 50)
	recipe:SetCraftedItem(56508, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddTrainer(3007, 3069, 3365, 3549, 3967, 4212, 4588, 5127, 5564, 16688, 16728, 17442, 18754, 21087, 53436, 66354, 98948, 98964)

	-- Darkbrand Chestguard -- 78428
	recipe = AddRecipe(78428, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(30, 30, 40, 45, 50)
	recipe:SetCraftedItem(56509, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddTrainer(3007, 3069, 3365, 3549, 3967, 4212, 4588, 5127, 5564, 16688, 16728, 17442, 18754, 21087, 53436, 66354, 98948, 98964)

	-- Tsunami Helm -- 78432
	recipe = AddRecipe(78432, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(35, 35, 45, 50, 55)
	recipe:SetCraftedItem(56512, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HEAD")
	recipe:AddTrainer(3007, 3069, 3365, 3549, 3967, 4212, 4588, 5127, 5564, 16688, 16728, 17442, 18754, 21087, 53436, 66354, 98948, 98964)

	-- Darkbrand Leggings -- 78433
	recipe = AddRecipe(78433, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(35, 35, 45, 50, 55)
	recipe:SetCraftedItem(56513, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddTrainer(3007, 3069, 3365, 3549, 3967, 4212, 4588, 5127, 5564, 16688, 16728, 17442, 18754, 21087, 53436, 66354, 98948, 98964)

	-- Heavy Savage Leather -- 78436
	recipe = AddRecipe(78436, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(35, 35, 45, 50, 55)
	recipe:SetCraftedItem(56516, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_MATERIALS")
	recipe:AddTrainer(3007, 3069, 3365, 3549, 3967, 4212, 4588, 5127, 5564, 16688, 16728, 17442, 18754, 21087, 53436, 66354, 98948, 98964)

	-- Heavy Savage Armor Kit -- 78437
	recipe = AddRecipe(78437, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(35, 35, 45, 50, 55)
	recipe:SetCraftedItem(56517, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_ITEM_ENHANCEMENT")
	recipe:AddTrainer(3007, 3069, 3365, 3549, 3967, 4212, 4588, 5127, 5564, 16688, 16728, 17442, 18754, 21087, 53436, 66354, 98948, 98964)

	-- Cloak of Beasts -- 78438
	recipe = AddRecipe(78438, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(45, 45, 55, 60, 65)
	recipe:SetCraftedItem(56518, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_BACK")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(3007, 3069, 3365, 3549, 3967, 4212, 4588, 5127, 5564, 16688, 16728, 17442, 18754, 21087, 53436, 66354, 98948, 98964)

	-- Cloak of War -- 78439
	recipe = AddRecipe(78439, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(45, 45, 55, 60, 65)
	recipe:SetCraftedItem(56519, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_BACK")
	recipe:AddFilters(F.DPS, F.TANK)
	recipe:AddTrainer(3007, 3069, 3365, 3549, 3967, 4212, 4588, 5127, 5564, 16688, 16728, 17442, 18754, 21087, 53436, 66354, 98948, 98964)

	-- Vicious Wyrmhide Bracers -- 78444
	recipe = AddRecipe(78444, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(510, 510, 515, 520, 525)
	recipe:SetRecipeItem(67042, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(3008, 3366, 4225, 4589, 5128, 5565, 16689, 16748, 50172, 50381)

	-- Vicious Wyrmhide Belt -- 78445
	recipe = AddRecipe(78445, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(510, 510, 515, 520, 525)
	recipe:SetRecipeItem(67044, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(3008, 3366, 4225, 4589, 5128, 5565, 16689, 16748, 50172, 50381)

	-- Vicious Leather Bracers -- 78446
	recipe = AddRecipe(78446, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(510, 510, 515, 520, 525)
	recipe:SetRecipeItem(67046, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(3008, 3366, 4225, 4589, 5128, 5565, 16689, 16748, 50172, 50381)

	-- Vicious Leather Gloves -- 78447
	recipe = AddRecipe(78447, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(510, 510, 515, 520, 525)
	recipe:SetRecipeItem(67048, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(3008, 3366, 4225, 4589, 5128, 5565, 16689, 16748, 50172, 50381)

	-- Vicious Charscale Bracers -- 78448
	recipe = AddRecipe(78448, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(510, 510, 515, 520, 525)
	recipe:SetRecipeItem(67049, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(3008, 3366, 4225, 4589, 5128, 5565, 16689, 16748, 50172, 50381)

	-- Vicious Charscale Gloves -- 78449
	recipe = AddRecipe(78449, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(510, 510, 515, 520, 525)
	recipe:SetRecipeItem(67053, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(3008, 3366, 4225, 4589, 5128, 5565, 16689, 16748, 50172, 50381)

	-- Vicious Dragonscale Bracers -- 78450
	recipe = AddRecipe(78450, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(510, 510, 515, 520, 525)
	recipe:SetRecipeItem(67054, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(3008, 3366, 4225, 4589, 5128, 5565, 16689, 16748, 50172, 50381)

	-- Vicious Dragonscale Shoulders -- 78451
	recipe = AddRecipe(78451, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(510, 510, 515, 520, 525)
	recipe:SetRecipeItem(67055, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(3008, 3366, 4225, 4589, 5128, 5565, 16689, 16748, 50172, 50381)

	-- Vicious Wyrmhide Gloves -- 78452
	recipe = AddRecipe(78452, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(515, 515, 520, 525, 530)
	recipe:SetRecipeItem(67056, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(3008, 3366, 4225, 4589, 5128, 5565, 16689, 16748, 50172, 50381)

	-- Vicious Wyrmhide Boots -- 78453
	recipe = AddRecipe(78453, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(515, 515, 520, 525, 530)
	recipe:SetRecipeItem(67058, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(3008, 3366, 4225, 4589, 5128, 5565, 16689, 16748, 50172, 50381)

	-- Vicious Leather Boots -- 78454
	recipe = AddRecipe(78454, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(515, 515, 520, 525, 530)
	recipe:SetRecipeItem(67060, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(3008, 3366, 4225, 4589, 5128, 5565, 16689, 16748, 50172, 50381)

	-- Vicious Leather Shoulders -- 78455
	recipe = AddRecipe(78455, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(515, 515, 520, 525, 530)
	recipe:SetRecipeItem(67062, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(3008, 3366, 4225, 4589, 5128, 5565, 16689, 16748, 50172, 50381)

	-- Vicious Charscale Boots -- 78456
	recipe = AddRecipe(78456, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(515, 515, 520, 525, 530)
	recipe:SetRecipeItem(67063, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(3008, 3366, 4225, 4589, 5128, 5565, 16689, 16748, 50172, 50381)

	-- Vicious Charscale Belt -- 78457
	recipe = AddRecipe(78457, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(515, 515, 520, 525, 530)
	recipe:SetRecipeItem(67064, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(3008, 3366, 4225, 4589, 5128, 5565, 16689, 16748, 50172, 50381)

	-- Vicious Dragonscale Boots -- 78458
	recipe = AddRecipe(78458, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(515, 515, 520, 525, 530)
	recipe:SetRecipeItem(67065, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(3008, 3366, 4225, 4589, 5128, 5565, 16689, 16748, 50172, 50381)

	-- Vicious Dragonscale Gloves -- 78459
	recipe = AddRecipe(78459, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(515, 515, 520, 525, 530)
	recipe:SetRecipeItem(67066, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(3008, 3366, 4225, 4589, 5128, 5565, 16689, 16748, 50172, 50381)

	-- Lightning Lash -- 78460
	recipe = AddRecipe(78460, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(525, 525, 525, 525, 530)
	recipe:SetRecipeItem(67068, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(3008, 3366, 4225, 4589, 5128, 5565, 16689, 16748, 50172, 50381)

	-- Belt of Nefarious Whispers -- 78461
	recipe = AddRecipe(78461, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(525, 525, 525, 525, 530)
	recipe:SetRecipeItem(67070, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(3008, 3366, 4225, 4589, 5128, 5565, 16689, 16748, 50172, 50381)

	-- Stormleather Sash -- 78462
	recipe = AddRecipe(78462, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(525, 525, 525, 525, 530)
	recipe:SetRecipeItem(67072, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(3008, 3366, 4225, 4589, 5128, 5565, 16689, 16748, 50172, 50381)

	-- Corded Viper Belt -- 78463
	recipe = AddRecipe(78463, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(525, 525, 525, 525, 530)
	recipe:SetRecipeItem(67073, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(3008, 3366, 4225, 4589, 5128, 5565, 16689, 16748, 50172, 50381)

	-- Vicious Wyrmhide Shoulders -- 78464
	recipe = AddRecipe(78464, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(520, 520, 525, 530, 535)
	recipe:SetRecipeItem(67074, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(3008, 3366, 4225, 4589, 5128, 5565, 16689, 16748, 50172, 50381)

	-- Vicious Wyrmhide Chest -- 78467
	recipe = AddRecipe(78467, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(520, 520, 525, 530, 535)
	recipe:SetRecipeItem(67075, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(3008, 3366, 4225, 4589, 5128, 5565, 16689, 16748, 50172, 50381)

	-- Vicious Leather Belt -- 78468
	recipe = AddRecipe(78468, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(520, 520, 525, 530, 535)
	recipe:SetRecipeItem(67076, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(3008, 3366, 4225, 4589, 5128, 5565, 16689, 16748, 50172, 50381)

	-- Vicious Leather Helm -- 78469
	recipe = AddRecipe(78469, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(520, 520, 525, 530, 535)
	recipe:SetRecipeItem(67077, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(3008, 3366, 4225, 4589, 5128, 5565, 16689, 16748, 50172, 50381)

	-- Vicious Charscale Shoulders -- 78470
	recipe = AddRecipe(78470, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(520, 520, 525, 530, 535)
	recipe:SetRecipeItem(67078, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(3008, 3366, 4225, 4589, 5128, 5565, 16689, 16748, 50172, 50381)

	-- Vicious Charscale Legs -- 78471
	recipe = AddRecipe(78471, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(520, 520, 525, 530, 535)
	recipe:SetRecipeItem(67079, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(3008, 3366, 4225, 4589, 5128, 5565, 16689, 16748, 50172, 50381)

	-- Vicious Dragonscale Belt -- 78473
	recipe = AddRecipe(78473, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(520, 520, 525, 530, 535)
	recipe:SetRecipeItem(67080, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(3008, 3366, 4225, 4589, 5128, 5565, 16689, 16748, 50172, 50381)

	-- Vicious Dragonscale Helm -- 78474
	recipe = AddRecipe(78474, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(520, 520, 525, 530, 535)
	recipe:SetRecipeItem(67081, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(3008, 3366, 4225, 4589, 5128, 5565, 16689, 16748, 50172, 50381)

	-- Razor-Edged Cloak -- 78475
	recipe = AddRecipe(78475, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(525, 525, 530, 535, 540)
	recipe:SetRecipeItem(67082, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_BACK")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(3008, 3366, 4225, 4589, 5128, 5565, 16689, 16748, 50172, 50381)

	-- Twilight Dragonscale Cloak -- 78476
	recipe = AddRecipe(78476, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(525, 525, 530, 535, 540)
	recipe:SetRecipeItem(67083, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_BACK")
	recipe:AddFilters(F.DPS, F.TANK)
	recipe:AddVendor(3008, 3366, 4225, 4589, 5128, 5565, 16689, 16748, 50172, 50381)

	-- Dragonscale Leg Armor -- 78477
	recipe = AddRecipe(78477, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(525, 525, 530, 535, 540)
	recipe:SetRecipeItem(68193, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(3008, 3366, 4225, 4589, 5128, 5565, 16689, 16748, 50172, 50381)

	-- Charscale Leg Armor -- 78478
	recipe = AddRecipe(78478, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(525, 525, 530, 535, 540)
	recipe:SetRecipeItem(67084, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.DPS)
	recipe:AddVendor(3008, 3366, 4225, 4589, 5128, 5565, 16689, 16748, 50172, 50381)

	-- Vicious Wyrmhide Legs -- 78479
	recipe = AddRecipe(78479, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(525, 525, 530, 535, 540)
	recipe:SetRecipeItem(67085, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(3008, 3366, 4225, 4589, 5128, 5565, 16689, 16748, 50172, 50381)

	-- Vicious Wyrmhide Helm -- 78480
	recipe = AddRecipe(78480, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(525, 525, 530, 535, 540)
	recipe:SetRecipeItem(67086, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(3008, 3366, 4225, 4589, 5128, 5565, 16689, 16748, 50172, 50381)

	-- Vicious Leather Chest -- 78481
	recipe = AddRecipe(78481, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(525, 525, 530, 535, 540)
	recipe:SetRecipeItem(67087, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(3008, 3366, 4225, 4589, 5128, 5565, 16689, 16748, 50172, 50381)

	-- Vicious Leather Legs -- 78482
	recipe = AddRecipe(78482, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(525, 525, 530, 535, 540)
	recipe:SetRecipeItem(67089, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(3008, 3366, 4225, 4589, 5128, 5565, 16689, 16748, 50172, 50381)

	-- Vicious Charscale Chest -- 78483
	recipe = AddRecipe(78483, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(525, 525, 530, 535, 540)
	recipe:SetRecipeItem(67090, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(3008, 3366, 4225, 4589, 5128, 5565, 16689, 16748, 50172, 50381)

	-- Vicious Charscale Helm -- 78484
	recipe = AddRecipe(78484, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(525, 525, 530, 535, 540)
	recipe:SetRecipeItem(67091, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(3008, 3366, 4225, 4589, 5128, 5565, 16689, 16748, 50172, 50381)

	-- Vicious Dragonscale Legs -- 78485
	recipe = AddRecipe(78485, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(525, 525, 530, 535, 540)
	recipe:SetRecipeItem(67092, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(3008, 3366, 4225, 4589, 5128, 5565, 16689, 16748, 50172, 50381)

	-- Vicious Dragonscale Chest -- 78486
	recipe = AddRecipe(78486, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(525, 525, 530, 535, 540)
	recipe:SetRecipeItem(67093, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(3008, 3366, 4225, 4589, 5128, 5565, 16689, 16748, 50172, 50381)

	-- Chestguard of Nature's Fury -- 78487
	recipe = AddRecipe(78487, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(525, 525, 530, 535, 540)
	recipe:SetRecipeItem(67094, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(3008, 3366, 4225, 4589, 5128, 5565, 16689, 16748, 50172, 50381)

	-- Assassin's Chestplate -- 78488
	recipe = AddRecipe(78488, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(525, 525, 530, 535, 540)
	recipe:SetRecipeItem(67095, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(3008, 3366, 4225, 4589, 5128, 5565, 16689, 16748, 50172, 50381)

	-- Twilight Scale Chestguard -- 78489
	recipe = AddRecipe(78489, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(525, 525, 530, 535, 540)
	recipe:SetRecipeItem(67096, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(3008, 3366, 4225, 4589, 5128, 5565, 16689, 16748, 50172, 50381)

	-- Dragonkiller Tunic -- 78490
	recipe = AddRecipe(78490, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(525, 525, 530, 535, 540)
	recipe:SetRecipeItem(67100, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(3008, 3366, 4225, 4589, 5128, 5565, 16689, 16748, 50172, 50381)

	-- Savage Leather -- 84950
	recipe = AddRecipe(84950, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(52976, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_MATERIALS")
	recipe:AddTrainer(3007, 3069, 3365, 3549, 3967, 4212, 4588, 5127, 5564, 16688, 16728, 17442, 18754, 21087, 53436, 66354, 98948, 98964)

	-- Dragonfire Gloves -- 99443
	recipe = AddRecipe(99443, V.CATA, Q.EPIC)
	recipe:SetSkillLevels(525, 525, 525, 527, 530)
	recipe:SetRecipeItem(69960, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(69939, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.FIRELANDS)

	-- Gloves of Unforgiving Flame -- 99445
	recipe = AddRecipe(99445, V.CATA, Q.EPIC)
	recipe:SetSkillLevels(525, 525, 525, 527, 530)
	recipe:SetRecipeItem(69961, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(69941, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.FIRELANDS)

	-- Clutches of Evil -- 99446
	recipe = AddRecipe(99446, V.CATA, Q.EPIC)
	recipe:SetSkillLevels(525, 525, 525, 527, 530)
	recipe:SetRecipeItem(69962, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(69942, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.FIRELANDS)

	-- Heavenly Gloves of the Moon -- 99447
	recipe = AddRecipe(99447, V.CATA, Q.EPIC)
	recipe:SetSkillLevels(525, 525, 525, 527, 530)
	recipe:SetRecipeItem(69963, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(69943, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.FIRELANDS)

	-- Earthen Scale Sabatons -- 99455
	recipe = AddRecipe(99455, V.CATA, Q.EPIC)
	recipe:SetSkillLevels(525, 525, 525, 527, 530)
	recipe:SetRecipeItem(69971, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(69949, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.FIRELANDS)

	-- Footwraps of Quenched Fire -- 99456
	recipe = AddRecipe(99456, V.CATA, Q.EPIC)
	recipe:SetSkillLevels(525, 525, 525, 527, 530)
	recipe:SetRecipeItem(69972, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(69950, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.FIRELANDS)

	-- Treads of the Craft -- 99457
	recipe = AddRecipe(99457, V.CATA, Q.EPIC)
	recipe:SetSkillLevels(525, 525, 525, 527, 530)
	recipe:SetRecipeItem(69973, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(69951, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.FIRELANDS)

	-- Ethereal Footfalls -- 99458
	recipe = AddRecipe(99458, V.CATA, Q.EPIC)
	recipe:SetSkillLevels(525, 525, 525, 527, 530)
	recipe:SetRecipeItem(69974, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(69952, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.FIRELANDS)

	-- Vicious Hide Cloak -- 99535
	recipe = AddRecipe(99535, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(75077, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_BACK")
	recipe:AddFilters(F.DPS)
	recipe:AddTrainer(3007, 3069, 3365, 3549, 4212, 4588, 5127, 5564, 16688, 16728, 17442, 18754, 21087, 53436, 66354, 98948, 98964)

	-- Vicious Fur Cloak -- 99536
	recipe = AddRecipe(99536, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(75076, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_BACK")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(3007, 3069, 3365, 3549, 4212, 4588, 5127, 5564, 16688, 16728, 17442, 18754, 21087, 53436, 66354, 98948, 98964)

	-- Royal Scribe's Satchel -- 100583
	recipe = AddRecipe(100583, V.CATA, Q.RARE)
	recipe:SetSkillLevels(510, 510, 520, 527, 535)
	recipe:SetRecipeItem(70174, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(70136, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_BAG")
	recipe:AddVendor(53881)

	-- Triple-Reinforced Mining Bag -- 100586
	recipe = AddRecipe(100586, V.CATA, Q.RARE)
	recipe:SetSkillLevels(500, 500, 520, 527, 535)
	recipe:SetRecipeItem(70175, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(70137, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_BAG")
	recipe:AddVendor(53881)

	-- Drakehide Leg Armor -- 101599
	recipe = AddRecipe(101599, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(525, 525, 530, 535, 540)
	recipe:SetRecipeItem(71721, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(71720, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.TANK)
	recipe:AddVendor(3008, 3366, 4225, 4589, 5128, 5565, 16689, 16748, 50172)

	-- Leggings of Nature's Champion -- 101933
	recipe = AddRecipe(101933, V.CATA, Q.EPIC)
	recipe:SetSkillLevels(525, 525, 525, 527, 530)
	recipe:SetRecipeItem(71999, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(71986, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.DRAGON_SOUL)

	-- Deathscale Leggings -- 101934
	recipe = AddRecipe(101934, V.CATA, Q.EPIC)
	recipe:SetSkillLevels(525, 525, 525, 527, 530)
	recipe:SetRecipeItem(72005, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(71988, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.DRAGON_SOUL)

	-- Bladeshadow Leggings -- 101935
	recipe = AddRecipe(101935, V.CATA, Q.EPIC)
	recipe:SetSkillLevels(525, 525, 525, 527, 530)
	recipe:SetRecipeItem(72006, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(71985, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.DRAGON_SOUL)

	-- Rended Earth Leggings -- 101936
	recipe = AddRecipe(101936, V.CATA, Q.EPIC)
	recipe:SetSkillLevels(525, 525, 525, 527, 530)
	recipe:SetRecipeItem(72007, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(71987, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.DRAGON_SOUL)

	-- Bracers of Flowing Serenity -- 101937
	recipe = AddRecipe(101937, V.CATA, Q.EPIC)
	recipe:SetSkillLevels(525, 525, 525, 527, 530)
	recipe:SetRecipeItem(72008, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(71995, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.DRAGON_SOUL)

	-- Thundering Deathscale Wristguards -- 101939
	recipe = AddRecipe(101939, V.CATA, Q.EPIC)
	recipe:SetSkillLevels(525, 525, 525, 527, 530)
	recipe:SetRecipeItem(72009, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(71997, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.DRAGON_SOUL)

	-- Bladeshadow Wristguards -- 101940
	recipe = AddRecipe(101940, V.CATA, Q.EPIC)
	recipe:SetSkillLevels(525, 525, 525, 527, 530)
	recipe:SetRecipeItem(72010, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(71994, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.DRAGON_SOUL)

	-- Bracers of the Hunter-Killer -- 101941
	recipe = AddRecipe(101941, V.CATA, Q.EPIC)
	recipe:SetSkillLevels(525, 525, 525, 527, 530)
	recipe:SetRecipeItem(72011, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(71996, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.DRAGON_SOUL)

	-- ----------------------------------------------------------------------------
	-- Mists of Pandaria.
	-- ----------------------------------------------------------------------------
	-- Sha-Touched Leg Armor -- 124124
	recipe = AddRecipe(124124, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(20, 20, 30, 35, 40)
	recipe:SetCraftedItem(85569, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(3069, 3967, 4212, 17442, 18754, 21087, 65121, 66354, 98948, 98964)

	-- Toughened Leg Armor -- 124125
	recipe = AddRecipe(124125, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(30, 30, 40, 45, 50)
	recipe:SetCraftedItem(85570, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.TANK)
	recipe:AddTrainer(3069, 3967, 4212, 17442, 18754, 21087, 65121, 66354, 98948, 98964)

	-- Brutal Leg Armor -- 124126
	recipe = AddRecipe(124126, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(10, 10, 20, 25, 30)
	recipe:SetCraftedItem(85568, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(3069, 3967, 4212, 17442, 18754, 21087, 65121, 66354, 98948, 98964)

	-- Angerhide Leg Armor -- 124127
	recipe = AddRecipe(124127, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(575, 575, 600, 602, 605)
	recipe:SetRecipeItem(86235, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(83765, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddRepVendor(FAC.GOLDEN_LOTUS, REP.HONORED, 59908)

	-- Ironscale Leg Armor -- 124128
	recipe = AddRecipe(124128, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(575, 575, 600, 602, 605)
	recipe:SetRecipeItem(86276, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(83763, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.TANK)
	recipe:AddRepVendor(FAC.GOLDEN_LOTUS, REP.HONORED, 59908)

	-- Shadowleather Leg Armor -- 124129
	recipe = AddRecipe(124129, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(575, 575, 600, 602, 605)
	recipe:SetRecipeItem(86295, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(83764, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddRepVendor(FAC.GOLDEN_LOTUS, REP.HONORED, 59908)

	-- Primal Leg Reinforcements -- 124559
	recipe = AddRecipe(124559, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(400, 400, 410, 415, 420)
	recipe:SetItemFilterType("LEATHERWORKING_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddDiscovery("DISCOVERY_AUTOLEARN")

	-- Draconic Leg Reinforcements -- 124561
	recipe = AddRecipe(124561, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(400, 400, 410, 415, 420)
	recipe:SetItemFilterType("LEATHERWORKING_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddDiscovery("DISCOVERY_AUTOLEARN")

	-- Heavy Leg Reinforcements -- 124563
	recipe = AddRecipe(124563, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(400, 400, 410, 415, 420)
	recipe:SetItemFilterType("LEATHERWORKING_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.TANK)
	recipe:AddDiscovery("DISCOVERY_AUTOLEARN")

	-- Misthide Helm -- 124571
	recipe = AddRecipe(124571, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(30, 30, 40, 45, 50)
	recipe:SetCraftedItem(85837, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HEAD")
	recipe:AddTrainer(3069, 3967, 4212, 17442, 18754, 21087, 65121, 66354, 98948, 98964)

	-- Misthide Shoulders -- 124572
	recipe = AddRecipe(124572, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(15, 15, 25, 30, 35)
	recipe:SetCraftedItem(85839, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_SHOULDER")
	recipe:AddTrainer(3069, 3967, 4212, 17442, 18754, 21087, 65121, 66354, 98948, 98964)

	-- Misthide Chestguard -- 124573
	recipe = AddRecipe(124573, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(35, 35, 45, 50, 55)
	recipe:SetCraftedItem(85835, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddTrainer(3069, 3967, 4212, 17442, 18754, 21087, 65121, 66354, 98948, 98964)

	-- Misthide Gloves -- 124574
	recipe = AddRecipe(124574, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(20, 20, 30, 35, 40)
	recipe:SetCraftedItem(85836, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddTrainer(3069, 3967, 4212, 17442, 18754, 21087, 65121, 66354, 98948, 98964)

	-- Misthide Leggings -- 124575
	recipe = AddRecipe(124575, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(85838, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddTrainer(3069, 3967, 4212, 17442, 18754, 21087, 65121, 66354, 98948, 98964)

	-- Misthide Bracers -- 124576
	recipe = AddRecipe(124576, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(5, 5, 15, 20, 25)
	recipe:SetCraftedItem(85834, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddTrainer(3069, 3967, 4212, 17442, 18754, 21087, 65121, 66354, 98948, 98964)

	-- Misthide Boots -- 124577
	recipe = AddRecipe(124577, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(85833, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddTrainer(3069, 3967, 4212, 17442, 18754, 21087, 65121, 66354, 98948, 98964)

	-- Misthide Belt -- 124578
	recipe = AddRecipe(124578, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(10, 10, 20, 25, 30)
	recipe:SetCraftedItem(85832, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddTrainer(3069, 3967, 4212, 17442, 18754, 21087, 65121, 66354, 98948, 98964)

	-- Stormscale Helm -- 124579
	recipe = AddRecipe(124579, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(85846, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HEAD")
	recipe:AddTrainer(3069, 3967, 4212, 17442, 18754, 21087, 65121, 66354, 98948, 98964)

	-- Stormscale Shoulders -- 124580
	recipe = AddRecipe(124580, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(20, 20, 30, 35, 40)
	recipe:SetCraftedItem(85848, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_SHOULDER")
	recipe:AddTrainer(3069, 3967, 4212, 17442, 18754, 21087, 65121, 66354, 98948, 98964)

	-- Stormscale Chestguard -- 124581
	recipe = AddRecipe(124581, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(30, 30, 40, 45, 50)
	recipe:SetCraftedItem(85844, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddTrainer(3069, 3967, 4212, 17442, 18754, 21087, 65121, 66354, 98948, 98964)

	-- Stormscale Gloves -- 124582
	recipe = AddRecipe(124582, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(15, 15, 25, 30, 35)
	recipe:SetCraftedItem(85845, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddTrainer(3069, 3967, 4212, 17442, 18754, 21087, 65121, 66354, 98948, 98964)

	-- Stormscale Leggings -- 124583
	recipe = AddRecipe(124583, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(35, 35, 45, 50, 55)
	recipe:SetCraftedItem(85847, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddTrainer(3069, 3967, 4212, 17442, 18754, 21087, 65121, 66354, 98948, 98964)

	-- Stormscale Bracers -- 124584
	recipe = AddRecipe(124584, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(85843, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddTrainer(3069, 3967, 4212, 17442, 18754, 21087, 65121, 66354, 98948, 98964)

	-- Stormscale Boots -- 124585
	recipe = AddRecipe(124585, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(10, 10, 20, 25, 30)
	recipe:SetCraftedItem(85842, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddTrainer(3069, 3967, 4212, 17442, 18754, 21087, 65121, 66354, 98948, 98964)

	-- Stormscale Belt -- 124586
	recipe = AddRecipe(124586, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(5, 5, 15, 20, 25)
	recipe:SetCraftedItem(85841, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddTrainer(3069, 3967, 4212, 17442, 18754, 21087, 65121, 66354, 98948, 98964)

	-- Contender's Wyrmhide Helm -- 124587
	recipe = AddRecipe(124587, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(590, 590, 600, 602, 605)
	recipe:SetRecipeItem(86269, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(85818, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(64054, 64094)

	-- Contender's Wyrmhide Shoulders -- 124588
	recipe = AddRecipe(124588, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(575, 575, 600, 602, 605)
	recipe:SetRecipeItem(86271, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(85820, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(64054, 64094)

	-- Contender's Wyrmhide Chestguard -- 124589
	recipe = AddRecipe(124589, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(590, 590, 600, 602, 605)
	recipe:SetRecipeItem(86267, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(85816, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(64054, 64094)

	-- Contender's Wyrmhide Gloves -- 124590
	recipe = AddRecipe(124590, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(565, 565, 600, 602, 605)
	recipe:SetRecipeItem(86268, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(85817, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(64054, 64094)

	-- Contender's Wyrmhide Leggings -- 124591
	recipe = AddRecipe(124591, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(565, 565, 600, 602, 605)
	recipe:SetRecipeItem(86270, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(85819, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(64054, 64094)

	-- Contender's Wyrmhide Bracers -- 124592
	recipe = AddRecipe(124592, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(555, 555, 600, 602, 605)
	recipe:SetRecipeItem(86266, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(85815, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(64054, 64094)

	-- Contender's Wyrmhide Boots -- 124593
	recipe = AddRecipe(124593, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(565, 565, 600, 602, 605)
	recipe:SetRecipeItem(86265, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(85814, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(64054, 64094)

	-- Contender's Wyrmhide Belt -- 124594
	recipe = AddRecipe(124594, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(565, 565, 600, 602, 605)
	recipe:SetRecipeItem(86264, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(85813, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(64054, 64094)

	-- Contender's Scale Helm -- 124595
	recipe = AddRecipe(124595, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(590, 590, 600, 602, 605)
	recipe:SetRecipeItem(86261, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(85810, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(64054, 64094)

	-- Contender's Scale Shoulders -- 124596
	recipe = AddRecipe(124596, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(575, 575, 600, 602, 605)
	recipe:SetRecipeItem(86263, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(85812, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(64054, 64094)

	-- Contender's Scale Chestguard -- 124597
	recipe = AddRecipe(124597, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(590, 590, 600, 602, 605)
	recipe:SetRecipeItem(86259, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(85808, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(64054, 64094)

	-- Contender's Scale Gloves -- 124598
	recipe = AddRecipe(124598, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(565, 565, 600, 602, 605)
	recipe:SetRecipeItem(86260, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(85809, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(64054, 64094)

	-- Contender's Scale Leggings -- 124599
	recipe = AddRecipe(124599, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(565, 565, 600, 602, 605)
	recipe:SetRecipeItem(86262, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(85811, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(64054, 64094)

	-- Contender's Scale Bracers -- 124600
	recipe = AddRecipe(124600, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(555, 555, 600, 602, 605)
	recipe:SetRecipeItem(86258, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(85807, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(64054, 64094)

	-- Contender's Scale Boots -- 124601
	recipe = AddRecipe(124601, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(565, 565, 600, 602, 605)
	recipe:SetRecipeItem(86257, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(85806, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(64054, 64094)

	-- Contender's Scale Belt -- 124602
	recipe = AddRecipe(124602, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(565, 565, 600, 602, 605)
	recipe:SetRecipeItem(86256, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(85805, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(64054, 64094)

	-- Contender's Leather Helm -- 124603
	recipe = AddRecipe(124603, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(590, 590, 600, 602, 605)
	recipe:SetRecipeItem(86253, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(85802, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(64054, 64094)

	-- Contender's Leather Shoulders -- 124604
	recipe = AddRecipe(124604, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(575, 575, 600, 602, 605)
	recipe:SetRecipeItem(86255, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(85804, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(64054, 64094)

	-- Contender's Leather Chestguard -- 124605
	recipe = AddRecipe(124605, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(590, 590, 600, 602, 605)
	recipe:SetRecipeItem(86251, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(85800, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(64054, 64094)

	-- Contender's Leather Gloves -- 124606
	recipe = AddRecipe(124606, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(565, 565, 600, 602, 605)
	recipe:SetRecipeItem(86252, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(85801, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(64054, 64094)

	-- Contender's Leather Leggings -- 124607
	recipe = AddRecipe(124607, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(565, 565, 600, 602, 605)
	recipe:SetRecipeItem(86254, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(85803, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(64054, 64094)

	-- Contender's Leather Bracers -- 124608
	recipe = AddRecipe(124608, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(555, 555, 600, 602, 605)
	recipe:SetRecipeItem(86250, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(85799, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(64054, 64094)

	-- Contender's Leather Boots -- 124609
	recipe = AddRecipe(124609, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(565, 565, 600, 602, 605)
	recipe:SetRecipeItem(86249, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(85798, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(64054, 64094)

	-- Contender's Leather Belt -- 124610
	recipe = AddRecipe(124610, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(565, 565, 600, 602, 605)
	recipe:SetRecipeItem(86248, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(85797, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(64054, 64094)

	-- Contender's Dragonscale Helm -- 124611
	recipe = AddRecipe(124611, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(590, 590, 600, 602, 605)
	recipe:SetRecipeItem(86245, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(85794, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(64054, 64094)

	-- Contender's Dragonscale Shoulders -- 124612
	recipe = AddRecipe(124612, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(575, 575, 600, 602, 605)
	recipe:SetRecipeItem(86247, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(85796, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(64054, 64094)

	-- Contender's Dragonscale Chestguard -- 124613
	recipe = AddRecipe(124613, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(590, 590, 600, 602, 605)
	recipe:SetRecipeItem(86243, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(85792, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(64054, 64094)

	-- Contender's Dragonscale Gloves -- 124614
	recipe = AddRecipe(124614, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(565, 565, 600, 602, 605)
	recipe:SetRecipeItem(86244, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(85793, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(64054, 64094)

	-- Contender's Dragonscale Leggings -- 124615
	recipe = AddRecipe(124615, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(565, 565, 600, 602, 605)
	recipe:SetRecipeItem(86246, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(85795, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(64054, 64094)

	-- Contender's Dragonscale Bracers -- 124616
	recipe = AddRecipe(124616, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(555, 555, 600, 602, 605)
	recipe:SetRecipeItem(86242, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(85791, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(64054, 64094)

	-- Contender's Dragonscale Boots -- 124617
	recipe = AddRecipe(124617, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(565, 565, 600, 602, 605)
	recipe:SetRecipeItem(86241, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(85790, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(64054, 64094)

	-- Contender's Dragonscale Belt -- 124618
	recipe = AddRecipe(124618, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(565, 565, 600, 602, 605)
	recipe:SetRecipeItem(86240, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(85789, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(64054, 64094)

	-- Greyshadow Chestguard -- 124619
	recipe = AddRecipe(124619, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetRecipeItem(86274, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(85823, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddRepVendor(FAC.GOLDEN_LOTUS, REP.HONORED, 59908)

	-- Greyshadow Gloves -- 124620
	recipe = AddRecipe(124620, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetRecipeItem(86275, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(85824, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddRepVendor(FAC.GOLDEN_LOTUS, REP.HONORED, 59908)

	-- Wildblood Vest -- 124621
	recipe = AddRecipe(124621, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetRecipeItem(86309, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(85850, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddRepVendor(FAC.GOLDEN_LOTUS, REP.HONORED, 59908)

	-- Wildblood Gloves -- 124622
	recipe = AddRecipe(124622, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetRecipeItem(86308, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(85849, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddRepVendor(FAC.GOLDEN_LOTUS, REP.HONORED, 59908)

	-- Lifekeeper's Robe -- 124623
	recipe = AddRecipe(124623, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetRecipeItem(86278, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(85826, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddRepVendor(FAC.GOLDEN_LOTUS, REP.HONORED, 59908)

	-- Lifekeeper's Gloves -- 124624
	recipe = AddRecipe(124624, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetRecipeItem(86277, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(85825, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddRepVendor(FAC.GOLDEN_LOTUS, REP.HONORED, 59908)

	-- Chestguard of Earthen Harmony -- 124625
	recipe = AddRecipe(124625, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetRecipeItem(86237, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(85787, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddRepVendor(FAC.GOLDEN_LOTUS, REP.HONORED, 59908)

	-- Gloves of Earthen Harmony -- 124626
	recipe = AddRecipe(124626, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetRecipeItem(86273, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(85822, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddRepVendor(FAC.GOLDEN_LOTUS, REP.HONORED, 59908)

	-- Exotic Leather -- 124627
	recipe = AddRecipe(124627, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(72120, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_MATERIALS")
	recipe:AddTrainer(3069, 3967, 4212, 17442, 18754, 21087, 65121, 66354, 98948, 98964)

	-- Sha Armor Kit -- 124628
	recipe = AddRecipe(124628, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(85559, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_ITEM_ENHANCEMENT")
	recipe:AddTrainer(3069, 3967, 4212, 17442, 18754, 21087, 65121, 66354, 98948, 98964)

	-- Misthide Drape -- 124635
	recipe = AddRecipe(124635, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(30, 30, 40, 45, 50)
	recipe:SetCraftedItem(85851, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_BACK")
	recipe:AddTrainer(3069, 3967, 4212, 17442, 18754, 21087, 65121, 66354, 98948, 98964)

	-- Stormscale Drape -- 124636
	recipe = AddRecipe(124636, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(85853, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_BACK")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(3069, 3967, 4212, 17442, 18754, 21087, 65121, 66354, 98948, 98964)

	-- Quick Strike Cloak -- 124637
	recipe = AddRecipe(124637, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(35, 35, 45, 50, 55)
	recipe:SetCraftedItem(85852, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_BACK")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddTrainer(3069, 3967, 4212, 17442, 18754, 21087, 65121, 66354, 98948, 98964)

	-- Chestguard of Nemeses -- 124638
	recipe = AddRecipe(124638, V.MOP, Q.EPIC)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetRecipeItem(86238, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(85788, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.HEART_OF_FEAR, Z.MOGUSHAN_VAULTS, Z.TERRACE_OF_ENDLESS_SPRING)

	-- Murderer's Gloves -- 124639
	recipe = AddRecipe(124639, V.MOP, Q.EPIC)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetRecipeItem(86280, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(85828, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.HEART_OF_FEAR, Z.MOGUSHAN_VAULTS, Z.TERRACE_OF_ENDLESS_SPRING)

	-- Nightfire Robe -- 124640
	recipe = AddRecipe(124640, V.MOP, Q.EPIC)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetRecipeItem(86281, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(85829, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.HEART_OF_FEAR, Z.MOGUSHAN_VAULTS, Z.TERRACE_OF_ENDLESS_SPRING)

	-- Liferuned Leather Gloves -- 124641
	recipe = AddRecipe(124641, V.MOP, Q.EPIC)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetRecipeItem(86279, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(85827, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.HEART_OF_FEAR, Z.MOGUSHAN_VAULTS, Z.TERRACE_OF_ENDLESS_SPRING)

	-- Stormbreaker Chestguard -- 124642
	recipe = AddRecipe(124642, V.MOP, Q.EPIC)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetRecipeItem(86297, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(85840, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.HEART_OF_FEAR, Z.MOGUSHAN_VAULTS, Z.TERRACE_OF_ENDLESS_SPRING)

	-- Fists of Lightning -- 124643
	recipe = AddRecipe(124643, V.MOP, Q.EPIC)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetRecipeItem(86272, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(85821, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.HEART_OF_FEAR, Z.MOGUSHAN_VAULTS, Z.TERRACE_OF_ENDLESS_SPRING)

	-- Raiment of Blood and Bone -- 124644
	recipe = AddRecipe(124644, V.MOP, Q.EPIC)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetRecipeItem(86283, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(85830, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.HEART_OF_FEAR, Z.MOGUSHAN_VAULTS, Z.TERRACE_OF_ENDLESS_SPRING)

	-- Raven Lord's Gloves -- 124645
	recipe = AddRecipe(124645, V.MOP, Q.EPIC)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetRecipeItem(86284, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(85831, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.HEART_OF_FEAR, Z.MOGUSHAN_VAULTS, Z.TERRACE_OF_ENDLESS_SPRING)

	-- Magnificent Hide -- 131865
	recipe = AddRecipe(131865, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(72163, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_MATERIALS")
	recipe:AddTrainer(3069, 3967, 4212, 17442, 18754, 21087, 65121, 66354, 98948, 98964)

	-- Crafted Dreadful Gladiator's Dragonhide Gloves -- 137809
	recipe = AddRecipe(137809, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(93458, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.DRUID)
	recipe:AddDiscovery("DISCOVERY_LW_PANDARIA")

	-- Crafted Dreadful Gladiator's Dragonhide Helm -- 137810
	recipe = AddRecipe(137810, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(93459, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.DRUID)
	recipe:AddDiscovery("DISCOVERY_LW_PANDARIA")

	-- Crafted Dreadful Gladiator's Dragonhide Legguards -- 137811
	recipe = AddRecipe(137811, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(93460, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.DRUID)
	recipe:AddDiscovery("DISCOVERY_LW_PANDARIA")

	-- Crafted Dreadful Gladiator's Dragonhide Robes -- 137812
	recipe = AddRecipe(137812, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(93461, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.DRUID)
	recipe:AddDiscovery("DISCOVERY_LW_PANDARIA")

	-- Crafted Dreadful Gladiator's Dragonhide Spaulders -- 137813
	recipe = AddRecipe(137813, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(93462, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.DRUID)
	recipe:AddDiscovery("DISCOVERY_LW_PANDARIA")

	-- Crafted Dreadful Gladiator's Belt of Meditation -- 137814
	recipe = AddRecipe(137814, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(93463, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.DRUID, F.MONK)
	recipe:AddDiscovery("DISCOVERY_LW_PANDARIA")

	-- Crafted Dreadful Gladiator's Leather Footguards of Meditation -- 137815
	recipe = AddRecipe(137815, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(93464, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.DRUID, F.MONK)
	recipe:AddDiscovery("DISCOVERY_LW_PANDARIA")

	-- Crafted Dreadful Gladiator's Bindings of Meditation -- 137816
	recipe = AddRecipe(137816, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(93465, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.DRUID, F.MONK)
	recipe:AddDiscovery("DISCOVERY_LW_PANDARIA")

	-- Crafted Dreadful Gladiator's Kodohide Gloves -- 137817
	recipe = AddRecipe(137817, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(93466, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.DRUID)
	recipe:AddDiscovery("DISCOVERY_LW_PANDARIA")

	-- Crafted Dreadful Gladiator's Kodohide Helm -- 137818
	recipe = AddRecipe(137818, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(93467, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.DRUID)
	recipe:AddDiscovery("DISCOVERY_LW_PANDARIA")

	-- Crafted Dreadful Gladiator's Kodohide Legguards -- 137819
	recipe = AddRecipe(137819, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(93468, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.DRUID)
	recipe:AddDiscovery("DISCOVERY_LW_PANDARIA")

	-- Crafted Dreadful Gladiator's Kodohide Robes -- 137820
	recipe = AddRecipe(137820, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(93469, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.DRUID)
	recipe:AddDiscovery("DISCOVERY_LW_PANDARIA")

	-- Crafted Dreadful Gladiator's Kodohide Spaulders -- 137821
	recipe = AddRecipe(137821, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(93470, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.DRUID)
	recipe:AddDiscovery("DISCOVERY_LW_PANDARIA")

	-- Crafted Dreadful Gladiator's Belt of Cruelty -- 137822
	recipe = AddRecipe(137822, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(93472, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.DRUID, F.MONK)
	recipe:AddDiscovery("DISCOVERY_LW_PANDARIA")

	-- Crafted Dreadful Gladiator's Leather Footguards of Alacrity -- 137823
	recipe = AddRecipe(137823, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(93473, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.DRUID, F.MONK)
	recipe:AddDiscovery("DISCOVERY_LW_PANDARIA")

	-- Crafted Dreadful Gladiator's Bindings of Prowess -- 137824
	recipe = AddRecipe(137824, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(93474, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.DRUID, F.MONK)
	recipe:AddDiscovery("DISCOVERY_LW_PANDARIA")

	-- Crafted Dreadful Gladiator's Wyrmhide Gloves -- 137825
	recipe = AddRecipe(137825, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(93475, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.DRUID)
	recipe:AddDiscovery("DISCOVERY_LW_PANDARIA")

	-- Crafted Dreadful Gladiator's Wyrmhide Helm -- 137826
	recipe = AddRecipe(137826, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(93476, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.DRUID)
	recipe:AddDiscovery("DISCOVERY_LW_PANDARIA")

	-- Crafted Dreadful Gladiator's Wyrmhide Legguards -- 137827
	recipe = AddRecipe(137827, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(93477, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.DRUID)
	recipe:AddDiscovery("DISCOVERY_LW_PANDARIA")

	-- Crafted Dreadful Gladiator's Wyrmhide Robes -- 137828
	recipe = AddRecipe(137828, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(93478, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.DRUID)
	recipe:AddDiscovery("DISCOVERY_LW_PANDARIA")

	-- Crafted Dreadful Gladiator's Wyrmhide Spaulders -- 137829
	recipe = AddRecipe(137829, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(93479, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.DRUID)
	recipe:AddDiscovery("DISCOVERY_LW_PANDARIA")

	-- Crafted Dreadful Gladiator's Waistband of Cruelty -- 137830
	recipe = AddRecipe(137830, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(93504, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.DRUID, F.ROGUE, F.MONK)
	recipe:AddDiscovery("DISCOVERY_LW_PANDARIA")

	-- Crafted Dreadful Gladiator's Boots of Alacrity -- 137831
	recipe = AddRecipe(137831, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(93505, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.DRUID, F.ROGUE, F.MONK)
	recipe:AddDiscovery("DISCOVERY_LW_PANDARIA")

	-- Crafted Dreadful Gladiator's Armwraps of Accuracy -- 137832
	recipe = AddRecipe(137832, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(93506, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.DRUID, F.ROGUE, F.MONK)
	recipe:AddDiscovery("DISCOVERY_LW_PANDARIA")

	-- Crafted Dreadful Gladiator's Ironskin Gloves -- 137833
	recipe = AddRecipe(137833, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(93507, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.MONK)
	recipe:AddDiscovery("DISCOVERY_LW_PANDARIA")

	-- Crafted Dreadful Gladiator's Ironskin Helm -- 137834
	recipe = AddRecipe(137834, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(93509, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.MONK)
	recipe:AddDiscovery("DISCOVERY_LW_PANDARIA")

	-- Crafted Dreadful Gladiator's Ironskin Legguards -- 137835
	recipe = AddRecipe(137835, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(93511, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.MONK)
	recipe:AddDiscovery("DISCOVERY_LW_PANDARIA")

	-- Crafted Dreadful Gladiator's Ironskin Spaulders -- 137836
	recipe = AddRecipe(137836, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(93513, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.MONK)
	recipe:AddDiscovery("DISCOVERY_LW_PANDARIA")

	-- Crafted Dreadful Gladiator's Ironskin Tunic -- 137837
	recipe = AddRecipe(137837, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(93515, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.MONK)
	recipe:AddDiscovery("DISCOVERY_LW_PANDARIA")

	-- Crafted Dreadful Gladiator's Copperskin Gloves -- 137838
	recipe = AddRecipe(137838, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(93517, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.MONK)
	recipe:AddDiscovery("DISCOVERY_LW_PANDARIA")

	-- Crafted Dreadful Gladiator's Copperskin Helm -- 137839
	recipe = AddRecipe(137839, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(93519, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.MONK)
	recipe:AddDiscovery("DISCOVERY_LW_PANDARIA")

	-- Crafted Dreadful Gladiator's Copperskin Legguards -- 137840
	recipe = AddRecipe(137840, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(93521, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.MONK)
	recipe:AddDiscovery("DISCOVERY_LW_PANDARIA")

	-- Crafted Dreadful Gladiator's Copperskin Spaulders -- 137841
	recipe = AddRecipe(137841, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(93523, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.MONK)
	recipe:AddDiscovery("DISCOVERY_LW_PANDARIA")

	-- Crafted Dreadful Gladiator's Copperskin Tunic -- 137842
	recipe = AddRecipe(137842, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(93525, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.MONK)
	recipe:AddDiscovery("DISCOVERY_LW_PANDARIA")

	-- Crafted Dreadful Gladiator's Waistband of Accuracy -- 137843
	recipe = AddRecipe(137843, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(93566, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.DRUID, F.ROGUE, F.MONK)
	recipe:AddDiscovery("DISCOVERY_LW_PANDARIA")

	-- Crafted Dreadful Gladiator's Boots of Cruelty -- 137844
	recipe = AddRecipe(137844, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(93567, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.DRUID, F.ROGUE, F.MONK)
	recipe:AddDiscovery("DISCOVERY_LW_PANDARIA")

	-- Crafted Dreadful Gladiator's Armwraps of Alacrity -- 137845
	recipe = AddRecipe(137845, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(93568, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.DRUID, F.ROGUE, F.MONK)
	recipe:AddDiscovery("DISCOVERY_LW_PANDARIA")

	-- Crafted Dreadful Gladiator's Leather Tunic -- 137846
	recipe = AddRecipe(137846, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(93569, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.ROGUE)
	recipe:AddDiscovery("DISCOVERY_LW_PANDARIA")

	-- Crafted Dreadful Gladiator's Leather Gloves -- 137847
	recipe = AddRecipe(137847, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(93570, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.ROGUE)
	recipe:AddDiscovery("DISCOVERY_LW_PANDARIA")

	-- Crafted Dreadful Gladiator's Leather Helm -- 137848
	recipe = AddRecipe(137848, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(93571, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.ROGUE)
	recipe:AddDiscovery("DISCOVERY_LW_PANDARIA")

	-- Crafted Dreadful Gladiator's Leather Legguards -- 137849
	recipe = AddRecipe(137849, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(93572, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.ROGUE)
	recipe:AddDiscovery("DISCOVERY_LW_PANDARIA")

	-- Crafted Dreadful Gladiator's Leather Spaulders -- 137850
	recipe = AddRecipe(137850, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(93573, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.ROGUE)
	recipe:AddDiscovery("DISCOVERY_LW_PANDARIA")

	-- Crafted Dreadful Gladiator's Links of Cruelty -- 137851
	recipe = AddRecipe(137851, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(93488, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.HUNTER, F.SHAMAN)
	recipe:AddDiscovery("DISCOVERY_LW_PANDARIA")

	-- Crafted Dreadful Gladiator's Links of Accuracy -- 137852
	recipe = AddRecipe(137852, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(93489, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.HUNTER, F.SHAMAN)
	recipe:AddDiscovery("DISCOVERY_LW_PANDARIA")

	-- Crafted Dreadful Gladiator's Sabatons of Cruelty -- 137853
	recipe = AddRecipe(137853, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(93490, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.HUNTER, F.SHAMAN)
	recipe:AddDiscovery("DISCOVERY_LW_PANDARIA")

	-- Crafted Dreadful Gladiator's Sabatons of Alacrity -- 137854
	recipe = AddRecipe(137854, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(93491, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.HUNTER, F.SHAMAN)
	recipe:AddDiscovery("DISCOVERY_LW_PANDARIA")

	-- Crafted Dreadful Gladiator's Wristguards of Alacrity -- 137855
	recipe = AddRecipe(137855, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(93492, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.HUNTER, F.SHAMAN)
	recipe:AddDiscovery("DISCOVERY_LW_PANDARIA")

	-- Crafted Dreadful Gladiator's Wristguards of Accuracy -- 137856
	recipe = AddRecipe(137856, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(93493, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.HUNTER, F.SHAMAN)
	recipe:AddDiscovery("DISCOVERY_LW_PANDARIA")

	-- Crafted Dreadful Gladiator's Chain Armor -- 137857
	recipe = AddRecipe(137857, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(93494, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.HUNTER)
	recipe:AddDiscovery("DISCOVERY_LW_PANDARIA")

	-- Crafted Dreadful Gladiator's Chain Gauntlets -- 137858
	recipe = AddRecipe(137858, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(93495, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.HUNTER)
	recipe:AddDiscovery("DISCOVERY_LW_PANDARIA")

	-- Crafted Dreadful Gladiator's Chain Helm -- 137859
	recipe = AddRecipe(137859, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(93496, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.HUNTER)
	recipe:AddDiscovery("DISCOVERY_LW_PANDARIA")

	-- Crafted Dreadful Gladiator's Chain Leggings -- 137860
	recipe = AddRecipe(137860, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(93497, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.HUNTER)
	recipe:AddDiscovery("DISCOVERY_LW_PANDARIA")

	-- Crafted Dreadful Gladiator's Chain Spaulders -- 137861
	recipe = AddRecipe(137861, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(93498, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.HUNTER)
	recipe:AddDiscovery("DISCOVERY_LW_PANDARIA")

	-- Crafted Dreadful Gladiator's Waistguard of Meditation -- 137862
	recipe = AddRecipe(137862, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(93574, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.SHAMAN)
	recipe:AddDiscovery("DISCOVERY_LW_PANDARIA")

	-- Crafted Dreadful Gladiator's Mail Footguards of Alacrity -- 137863
	recipe = AddRecipe(137863, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(93575, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.SHAMAN)
	recipe:AddDiscovery("DISCOVERY_LW_PANDARIA")

	-- Crafted Dreadful Gladiator's Mail Footguards of Meditation -- 137864
	recipe = AddRecipe(137864, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(93576, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.SHAMAN)
	recipe:AddDiscovery("DISCOVERY_LW_PANDARIA")

	-- Crafted Dreadful Gladiator's Armbands of Prowess -- 137865
	recipe = AddRecipe(137865, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(93577, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.SHAMAN)
	recipe:AddDiscovery("DISCOVERY_LW_PANDARIA")

	-- Crafted Dreadful Gladiator's Armbands of Meditation -- 137866
	recipe = AddRecipe(137866, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(93578, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.SHAMAN)
	recipe:AddDiscovery("DISCOVERY_LW_PANDARIA")

	-- Crafted Dreadful Gladiator's Ringmail Armor -- 137867
	recipe = AddRecipe(137867, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(93579, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.SHAMAN)
	recipe:AddDiscovery("DISCOVERY_LW_PANDARIA")

	-- Crafted Dreadful Gladiator's Ringmail Gauntlets -- 137868
	recipe = AddRecipe(137868, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(93580, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.SHAMAN)
	recipe:AddDiscovery("DISCOVERY_LW_PANDARIA")

	-- Crafted Dreadful Gladiator's Ringmail Helm -- 137869
	recipe = AddRecipe(137869, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(93581, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.SHAMAN)
	recipe:AddDiscovery("DISCOVERY_LW_PANDARIA")

	-- Crafted Dreadful Gladiator's Ringmail Leggings -- 137870
	recipe = AddRecipe(137870, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(93582, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.SHAMAN)
	recipe:AddDiscovery("DISCOVERY_LW_PANDARIA")

	-- Crafted Dreadful Gladiator's Ringmail Spaulders -- 137871
	recipe = AddRecipe(137871, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(93583, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.SHAMAN)
	recipe:AddDiscovery("DISCOVERY_LW_PANDARIA")

	-- Crafted Dreadful Gladiator's Linked Armor -- 137872
	recipe = AddRecipe(137872, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(93584, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.SHAMAN)
	recipe:AddDiscovery("DISCOVERY_LW_PANDARIA")

	-- Crafted Dreadful Gladiator's Linked Gauntlets -- 137873
	recipe = AddRecipe(137873, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(93585, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.SHAMAN)
	recipe:AddDiscovery("DISCOVERY_LW_PANDARIA")

	-- Crafted Dreadful Gladiator's Linked Helm -- 137874
	recipe = AddRecipe(137874, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(93586, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.SHAMAN)
	recipe:AddDiscovery("DISCOVERY_LW_PANDARIA")

	-- Crafted Dreadful Gladiator's Linked Leggings -- 137875
	recipe = AddRecipe(137875, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(93587, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.SHAMAN)
	recipe:AddDiscovery("DISCOVERY_LW_PANDARIA")

	-- Crafted Dreadful Gladiator's Linked Spaulders -- 137876
	recipe = AddRecipe(137876, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(93588, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.SHAMAN)
	recipe:AddDiscovery("DISCOVERY_LW_PANDARIA")

	-- Crafted Dreadful Gladiator's Waistguard of Cruelty -- 137877
	recipe = AddRecipe(137877, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(93589, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.SHAMAN)
	recipe:AddDiscovery("DISCOVERY_LW_PANDARIA")

	-- Crafted Dreadful Gladiator's Mail Armor -- 137878
	recipe = AddRecipe(137878, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(93590, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.SHAMAN)
	recipe:AddDiscovery("DISCOVERY_LW_PANDARIA")

	-- Crafted Dreadful Gladiator's Mail Gauntlets -- 137879
	recipe = AddRecipe(137879, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(93591, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.SHAMAN)
	recipe:AddDiscovery("DISCOVERY_LW_PANDARIA")

	-- Crafted Dreadful Gladiator's Mail Helm -- 137880
	recipe = AddRecipe(137880, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(93592, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.SHAMAN)
	recipe:AddDiscovery("DISCOVERY_LW_PANDARIA")

	-- Crafted Dreadful Gladiator's Mail Leggings -- 137881
	recipe = AddRecipe(137881, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(93593, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.SHAMAN)
	recipe:AddDiscovery("DISCOVERY_LW_PANDARIA")

	-- Crafted Dreadful Gladiator's Mail Spaulders -- 137882
	recipe = AddRecipe(137882, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(93594, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.SHAMAN)
	recipe:AddDiscovery("DISCOVERY_LW_PANDARIA")

	-- Quilen Hide Boots -- 138589
	recipe = AddRecipe(138589, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(94269, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddDiscovery("DISCOVERY_LW_PANDARIA")

	-- Quilen Hide Helm -- 138590
	recipe = AddRecipe(138590, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(94270, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddDiscovery("DISCOVERY_LW_PANDARIA")

	-- Dreadrunner Sabatons -- 138591
	recipe = AddRecipe(138591, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(94271, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddDiscovery("DISCOVERY_LW_PANDARIA")

	-- Dreadrunner Helm -- 138592
	recipe = AddRecipe(138592, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(94272, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddDiscovery("DISCOVERY_LW_PANDARIA")

	-- Spirit Keeper Footguards -- 138593
	recipe = AddRecipe(138593, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(94273, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddDiscovery("DISCOVERY_LW_PANDARIA")

	-- Spirit Keeper Helm -- 138594
	recipe = AddRecipe(138594, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(94274, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddDiscovery("DISCOVERY_LW_PANDARIA")

	-- Cloud Serpent Sabatons -- 138595
	recipe = AddRecipe(138595, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(94275, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddDiscovery("DISCOVERY_LW_PANDARIA")

	-- Cloud Serpent Helm -- 138596
	recipe = AddRecipe(138596, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(94276, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddDiscovery("DISCOVERY_LW_PANDARIA")

	-- Magnificence of Leather -- 140040
	recipe = AddRecipe(140040, V.MOP, Q.UNCOMMON)
	recipe:SetSkillLevels(550, 550, 560, 565, 570)
	recipe:SetRecipeItem(95467, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(72163, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_MATERIALS")
	recipe:AddWorldDrop(Z.PANDARIA)

	-- Magnificence of Scales -- 140041
	recipe = AddRecipe(140041, V.MOP, Q.UNCOMMON)
	recipe:SetSkillLevels(550, 550, 560, 565, 570)
	recipe:SetRecipeItem(95468, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(72163, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_MATERIALS")
	recipe:AddWorldDrop(Z.PANDARIA)

	-- Magnificent Hide Pack -- 140185
	recipe = AddRecipe(140185, V.MOP, Q.UNCOMMON)
	recipe:SetSkillLevels(595, 595, 595, 597, 600)
	recipe:SetCraftedItem(95536, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_BAG")
	recipe:AddDiscovery("DISCOVERY_LW_PANDARIA")

	-- Pennyroyal Leggings -- 142952
	recipe = AddRecipe(142952, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 612, 618)
	recipe:SetCraftedItem(98600, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddDiscovery("DISCOVERY_LW_HARDENED_PANDARIA")

	-- Krasari Prowler Britches -- 142953
	recipe = AddRecipe(142953, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 612, 618)
	recipe:SetCraftedItem(98601, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddDiscovery("DISCOVERY_LW_HARDENED_PANDARIA")

	-- Snow Lily Britches -- 142956
	recipe = AddRecipe(142956, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 612, 618)
	recipe:SetCraftedItem(98613, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddDiscovery("DISCOVERY_LW_HARDENED_PANDARIA")

	-- Gorge Stalker Legplates -- 142957
	recipe = AddRecipe(142957, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 612, 618)
	recipe:SetCraftedItem(98605, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddDiscovery("DISCOVERY_LW_HARDENED_PANDARIA")

	-- Pennyroyal Belt -- 142961
	recipe = AddRecipe(142961, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 612, 618)
	recipe:SetCraftedItem(98609, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddDiscovery("DISCOVERY_LW_HARDENED_PANDARIA")

	-- Krasari Prowler Belt -- 142962
	recipe = AddRecipe(142962, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 612, 618)
	recipe:SetCraftedItem(98610, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddDiscovery("DISCOVERY_LW_HARDENED_PANDARIA")

	-- Snow Lily Belt -- 142965
	recipe = AddRecipe(142965, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 612, 618)
	recipe:SetCraftedItem(98613, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddDiscovery("DISCOVERY_LW_HARDENED_PANDARIA")

	-- Gorge Stalker Belt -- 142966
	recipe = AddRecipe(142966, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 612, 618)
	recipe:SetCraftedItem(98614, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddDiscovery("DISCOVERY_LW_HARDENED_PANDARIA")

	-- Hardened Magnificent Hide -- 142976
	recipe = AddRecipe(142976, V.MOP, Q.RARE)
	recipe:SetSkillLevels(600, 600, 605, 612, 618)
	recipe:SetRecipeItem(100864, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(98617, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_MATERIALS")
	recipe:AddWorldDrop(Z.PANDARIA)

	-- Crafted Malevolent Gladiator's Dragonhide Gloves -- 143089
	recipe = AddRecipe(143089, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 611, 616)
	recipe:SetCraftedItem(98789, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.DRUID)
	recipe:AddDiscovery("DISCOVERY_LW_HARDENED_PANDARIA")

	-- Crafted Malevolent Gladiator's Dragonhide Helm -- 143090
	recipe = AddRecipe(143090, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 611, 616)
	recipe:SetCraftedItem(98790, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.DRUID)
	recipe:AddDiscovery("DISCOVERY_LW_HARDENED_PANDARIA")

	-- Crafted Malevolent Gladiator's Dragonhide Legguards -- 143091
	recipe = AddRecipe(143091, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 611, 616)
	recipe:SetCraftedItem(98791, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.DRUID)
	recipe:AddDiscovery("DISCOVERY_LW_HARDENED_PANDARIA")

	-- Crafted Malevolent Gladiator's Dragonhide Robes -- 143092
	recipe = AddRecipe(143092, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 611, 616)
	recipe:SetCraftedItem(98792, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.DRUID)
	recipe:AddDiscovery("DISCOVERY_LW_HARDENED_PANDARIA")

	-- Crafted Malevolent Gladiator's Dragonhide Spaulders -- 143093
	recipe = AddRecipe(143093, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 611, 616)
	recipe:SetCraftedItem(98793, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.DRUID)
	recipe:AddDiscovery("DISCOVERY_LW_HARDENED_PANDARIA")

	-- Crafted Malevolent Gladiator's Belt of Meditation -- 143094
	recipe = AddRecipe(143094, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 611, 616)
	recipe:SetCraftedItem(98794, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.DRUID, F.MONK)
	recipe:AddDiscovery("DISCOVERY_LW_HARDENED_PANDARIA")

	-- Crafted Malevolent Gladiator's Footguards of Meditation -- 143095
	recipe = AddRecipe(143095, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 611, 616)
	recipe:SetCraftedItem(98795, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.DRUID, F.MONK)
	recipe:AddDiscovery("DISCOVERY_LW_HARDENED_PANDARIA")

	-- Crafted Malevolent Gladiator's Bindings of Meditation -- 143096
	recipe = AddRecipe(143096, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 611, 616)
	recipe:SetCraftedItem(98796, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.DRUID, F.MONK)
	recipe:AddDiscovery("DISCOVERY_LW_HARDENED_PANDARIA")

	-- Crafted Malevolent Gladiator's Kodohide Gloves -- 143097
	recipe = AddRecipe(143097, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 611, 616)
	recipe:SetCraftedItem(98797, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.DRUID)
	recipe:AddDiscovery("DISCOVERY_LW_HARDENED_PANDARIA")

	-- Crafted Malevolent Gladiator's Kodohide Helm -- 143098
	recipe = AddRecipe(143098, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 611, 616)
	recipe:SetCraftedItem(98798, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.DRUID)
	recipe:AddDiscovery("DISCOVERY_LW_HARDENED_PANDARIA")

	-- Crafted Malevolent Gladiator's Kodohide Legguards -- 143099
	recipe = AddRecipe(143099, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 611, 616)
	recipe:SetCraftedItem(98799, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.DRUID)
	recipe:AddDiscovery("DISCOVERY_LW_HARDENED_PANDARIA")

	-- Crafted Malevolent Gladiator's Kodohide Robes -- 143100
	recipe = AddRecipe(143100, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 611, 616)
	recipe:SetCraftedItem(98800, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.DRUID)
	recipe:AddDiscovery("DISCOVERY_LW_HARDENED_PANDARIA")

	-- Crafted Malevolent Gladiator's Kodohide Spaulders -- 143101
	recipe = AddRecipe(143101, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 611, 616)
	recipe:SetCraftedItem(98801, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.DRUID)
	recipe:AddDiscovery("DISCOVERY_LW_HARDENED_PANDARIA")

	-- Crafted Malevolent Gladiator's Belt of Cruelty -- 143102
	recipe = AddRecipe(143102, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 611, 616)
	recipe:SetCraftedItem(98802, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.DRUID, F.MONK)
	recipe:AddDiscovery("DISCOVERY_LW_HARDENED_PANDARIA")

	-- Crafted Malevolent Gladiator's Footguards of Alacrity -- 143103
	recipe = AddRecipe(143103, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 611, 616)
	recipe:SetCraftedItem(98803, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.DRUID, F.MONK)
	recipe:AddDiscovery("DISCOVERY_LW_HARDENED_PANDARIA")

	-- Crafted Malevolent Gladiator's Bindings of Prowess -- 143104
	recipe = AddRecipe(143104, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 611, 615)
	recipe:SetCraftedItem(98804, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.DRUID, F.MONK)
	recipe:AddDiscovery("DISCOVERY_LW_HARDENED_PANDARIA")

	-- Crafted Malevolent Gladiator's Wyrmhide Gloves -- 143105
	recipe = AddRecipe(143105, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 611, 616)
	recipe:SetCraftedItem(98805, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.DRUID)
	recipe:AddDiscovery("DISCOVERY_LW_HARDENED_PANDARIA")

	-- Crafted Malevolent Gladiator's Wyrmhide Helm -- 143106
	recipe = AddRecipe(143106, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 611, 616)
	recipe:SetCraftedItem(98806, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.DRUID)
	recipe:AddDiscovery("DISCOVERY_LW_HARDENED_PANDARIA")

	-- Crafted Malevolent Gladiator's Wyrmhide Legguards -- 143107
	recipe = AddRecipe(143107, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 611, 616)
	recipe:SetCraftedItem(98807, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.DRUID)
	recipe:AddDiscovery("DISCOVERY_LW_HARDENED_PANDARIA")

	-- Crafted Malevolent Gladiator's Wyrmhide Robes -- 143108
	recipe = AddRecipe(143108, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 611, 616)
	recipe:SetCraftedItem(98808, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.DRUID)
	recipe:AddDiscovery("DISCOVERY_LW_HARDENED_PANDARIA")

	-- Crafted Malevolent Gladiator's Wyrmhide Spaulders -- 143109
	recipe = AddRecipe(143109, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 611, 616)
	recipe:SetCraftedItem(98809, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.DRUID)
	recipe:AddDiscovery("DISCOVERY_LW_HARDENED_PANDARIA")

	-- Crafted Malevolent Gladiator's Waistband of Cruelty -- 143110
	recipe = AddRecipe(143110, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 611, 616)
	recipe:SetCraftedItem(98830, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.DRUID, F.ROGUE, F.MONK)
	recipe:AddDiscovery("DISCOVERY_LW_HARDENED_PANDARIA")

	-- Crafted Malevolent Gladiator's Boots of Alacrity -- 143111
	recipe = AddRecipe(143111, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 611, 616)
	recipe:SetCraftedItem(98831, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.DRUID, F.ROGUE, F.MONK)
	recipe:AddDiscovery("DISCOVERY_LW_HARDENED_PANDARIA")

	-- Crafted Malevolent Gladiator's Armwraps of Accuracy -- 143112
	recipe = AddRecipe(143112, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 611, 616)
	recipe:SetCraftedItem(98832, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.DRUID, F.ROGUE, F.MONK)
	recipe:AddDiscovery("DISCOVERY_LW_HARDENED_PANDARIA")

	-- Crafted Malevolent Gladiator's Ironskin Gloves -- 143113
	recipe = AddRecipe(143113, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 611, 616)
	recipe:SetCraftedItem(98833, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.MONK)
	recipe:AddDiscovery("DISCOVERY_LW_HARDENED_PANDARIA")

	-- Crafted Malevolent Gladiator's Ironskin Helm -- 143114
	recipe = AddRecipe(143114, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 611, 616)
	recipe:SetCraftedItem(98834, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.MONK)
	recipe:AddDiscovery("DISCOVERY_LW_HARDENED_PANDARIA")

	-- Crafted Malevolent Gladiator's Ironskin Legguards -- 143115
	recipe = AddRecipe(143115, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 611, 616)
	recipe:SetCraftedItem(98835, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.MONK)
	recipe:AddDiscovery("DISCOVERY_LW_HARDENED_PANDARIA")

	-- Crafted Malevolent Gladiator's Ironskin Spaulders -- 143116
	recipe = AddRecipe(143116, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 611, 616)
	recipe:SetCraftedItem(98836, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.MONK)
	recipe:AddDiscovery("DISCOVERY_LW_HARDENED_PANDARIA")

	-- Crafted Malevolent Gladiator's Ironskin Tunic -- 143117
	recipe = AddRecipe(143117, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 611, 616)
	recipe:SetCraftedItem(98837, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.MONK)
	recipe:AddDiscovery("DISCOVERY_LW_HARDENED_PANDARIA")

	-- Crafted Malevolent Gladiator's Copperskin Gloves -- 143118
	recipe = AddRecipe(143118, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 611, 616)
	recipe:SetCraftedItem(98838, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.MONK)
	recipe:AddDiscovery("DISCOVERY_LW_HARDENED_PANDARIA")

	-- Crafted Malevolent Gladiator's Copperskin Helm -- 143119
	recipe = AddRecipe(143119, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 611, 616)
	recipe:SetCraftedItem(98839, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.MONK)
	recipe:AddDiscovery("DISCOVERY_LW_HARDENED_PANDARIA")

	-- Crafted Malevolent Gladiator's Copperskin Legguards -- 143120
	recipe = AddRecipe(143120, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 611, 616)
	recipe:SetCraftedItem(98840, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.MONK)
	recipe:AddDiscovery("DISCOVERY_LW_HARDENED_PANDARIA")

	-- Crafted Malevolent Gladiator's Copperskin Spaulders -- 143121
	recipe = AddRecipe(143121, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 611, 616)
	recipe:SetCraftedItem(98841, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.MONK)
	recipe:AddDiscovery("DISCOVERY_LW_HARDENED_PANDARIA")

	-- Crafted Malevolent Gladiator's Copperskin Tunic -- 143122
	recipe = AddRecipe(143122, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 611, 616)
	recipe:SetCraftedItem(98842, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.MONK)
	recipe:AddDiscovery("DISCOVERY_LW_HARDENED_PANDARIA")

	-- Crafted Malevolent Gladiator's Waistband of Accuracy -- 143123
	recipe = AddRecipe(143123, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 611, 616)
	recipe:SetCraftedItem(98881, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.DRUID, F.ROGUE, F.MONK)
	recipe:AddDiscovery("DISCOVERY_LW_HARDENED_PANDARIA")

	-- Crafted Malevolent Gladiator's Boots of Cruelty -- 143124
	recipe = AddRecipe(143124, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 611, 616)
	recipe:SetCraftedItem(98882, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.DRUID, F.ROGUE, F.MONK)
	recipe:AddDiscovery("DISCOVERY_LW_HARDENED_PANDARIA")

	-- Crafted Malevolent Gladiator's Armwraps of Alacrity -- 143125
	recipe = AddRecipe(143125, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 611, 616)
	recipe:SetCraftedItem(98883, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.DRUID, F.ROGUE, F.MONK)
	recipe:AddDiscovery("DISCOVERY_LW_HARDENED_PANDARIA")

	-- Crafted Malevolent Gladiator's Leather Tunic -- 143126
	recipe = AddRecipe(143126, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 611, 616)
	recipe:SetCraftedItem(98884, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.ROGUE)
	recipe:AddDiscovery("DISCOVERY_LW_HARDENED_PANDARIA")

	-- Crafted Malevolent Gladiator's Leather Gloves -- 143127
	recipe = AddRecipe(143127, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 611, 616)
	recipe:SetCraftedItem(98885, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.ROGUE)
	recipe:AddDiscovery("DISCOVERY_LW_HARDENED_PANDARIA")

	-- Crafted Malevolent Gladiator's Leather Helm -- 143128
	recipe = AddRecipe(143128, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 611, 616)
	recipe:SetCraftedItem(98886, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.ROGUE)
	recipe:AddDiscovery("DISCOVERY_LW_HARDENED_PANDARIA")

	-- Crafted Malevolent Gladiator's Leather Legguards -- 143129
	recipe = AddRecipe(143129, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 611, 616)
	recipe:SetCraftedItem(98887, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.ROGUE)
	recipe:AddDiscovery("DISCOVERY_LW_HARDENED_PANDARIA")

	-- Crafted Malevolent Gladiator's Leather Spaulders -- 143130
	recipe = AddRecipe(143130, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 611, 616)
	recipe:SetCraftedItem(98888, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.ROGUE)
	recipe:AddDiscovery("DISCOVERY_LW_HARDENED_PANDARIA")

	-- Crafted Malevolent Gladiator's Links of Cruelty -- 143131
	recipe = AddRecipe(143131, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 611, 616)
	recipe:SetCraftedItem(98814, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.HUNTER, F.SHAMAN)
	recipe:AddDiscovery("DISCOVERY_LW_HARDENED_PANDARIA")

	-- Crafted Malevolent Gladiator's Links of Accuracy -- 143132
	recipe = AddRecipe(143132, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 611, 616)
	recipe:SetCraftedItem(98815, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.HUNTER, F.SHAMAN)
	recipe:AddDiscovery("DISCOVERY_LW_HARDENED_PANDARIA")

	-- Crafted Malevolent Gladiator's Sabatons of Cruelty -- 143133
	recipe = AddRecipe(143133, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 611, 616)
	recipe:SetCraftedItem(98816, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.HUNTER, F.SHAMAN)
	recipe:AddDiscovery("DISCOVERY_LW_HARDENED_PANDARIA")

	-- Crafted Malevolent Gladiator's Sabatons of Alacrity -- 143134
	recipe = AddRecipe(143134, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 611, 616)
	recipe:SetCraftedItem(98817, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.HUNTER, F.SHAMAN)
	recipe:AddDiscovery("DISCOVERY_LW_HARDENED_PANDARIA")

	-- Crafted Malevolent Gladiator's Wristguards of Alacrity -- 143135
	recipe = AddRecipe(143135, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 611, 616)
	recipe:SetCraftedItem(98818, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.HUNTER, F.SHAMAN)
	recipe:AddDiscovery("DISCOVERY_LW_HARDENED_PANDARIA")

	-- Crafted Malevolent Gladiator's Wristguards of Accuracy -- 143136
	recipe = AddRecipe(143136, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 611, 616)
	recipe:SetCraftedItem(98819, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.HUNTER, F.SHAMAN)
	recipe:AddDiscovery("DISCOVERY_LW_HARDENED_PANDARIA")

	-- Crafted Malevolent Gladiator's Chain Armor -- 143137
	recipe = AddRecipe(143137, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 611, 616)
	recipe:SetCraftedItem(98820, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.HUNTER)
	recipe:AddDiscovery("DISCOVERY_LW_HARDENED_PANDARIA")

	-- Crafted Malevolent Gladiator's Chain Gauntlets -- 143138
	recipe = AddRecipe(143138, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 611, 616)
	recipe:SetCraftedItem(98821, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.HUNTER)
	recipe:AddDiscovery("DISCOVERY_LW_HARDENED_PANDARIA")

	-- Crafted Malevolent Gladiator's Chain Helm -- 143139
	recipe = AddRecipe(143139, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 611, 616)
	recipe:SetCraftedItem(98822, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.HUNTER)
	recipe:AddDiscovery("DISCOVERY_LW_HARDENED_PANDARIA")

	-- Crafted Malevolent Gladiator's Chain Leggings -- 143140
	recipe = AddRecipe(143140, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 611, 616)
	recipe:SetCraftedItem(98823, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.HUNTER)
	recipe:AddDiscovery("DISCOVERY_LW_HARDENED_PANDARIA")

	-- Crafted Malevolent Gladiator's Chain Spaulders -- 143141
	recipe = AddRecipe(143141, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 611, 616)
	recipe:SetCraftedItem(98824, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.HUNTER)
	recipe:AddDiscovery("DISCOVERY_LW_HARDENED_PANDARIA")

	-- Crafted Malevolent Gladiator's Waistguard of Meditation -- 143142
	recipe = AddRecipe(143142, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 611, 616)
	recipe:SetCraftedItem(98889, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.SHAMAN)
	recipe:AddDiscovery("DISCOVERY_LW_HARDENED_PANDARIA")

	-- Crafted Malevolent Gladiator's Footguards of Alacrity -- 143143
	recipe = AddRecipe(143143, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 611, 616)
	recipe:SetCraftedItem(98890, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.SHAMAN)
	recipe:AddDiscovery("DISCOVERY_LW_HARDENED_PANDARIA")

	-- Crafted Malevolent Gladiator's Footguards of Meditation -- 143144
	recipe = AddRecipe(143144, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 611, 616)
	recipe:SetCraftedItem(98891, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.SHAMAN)
	recipe:AddDiscovery("DISCOVERY_LW_HARDENED_PANDARIA")

	-- Crafted Malevolent Gladiator's Armbands of Prowess -- 143145
	recipe = AddRecipe(143145, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 611, 616)
	recipe:SetCraftedItem(98892, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.SHAMAN)
	recipe:AddDiscovery("DISCOVERY_LW_HARDENED_PANDARIA")

	-- Crafted Malevolent Gladiator's Armbands of Meditation -- 143146
	recipe = AddRecipe(143146, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 611, 616)
	recipe:SetCraftedItem(98893, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.SHAMAN)
	recipe:AddDiscovery("DISCOVERY_LW_HARDENED_PANDARIA")

	-- Crafted Malevolent Gladiator's Ringmail Armor -- 143147
	recipe = AddRecipe(143147, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 611, 616)
	recipe:SetCraftedItem(98894, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.SHAMAN)
	recipe:AddDiscovery("DISCOVERY_LW_HARDENED_PANDARIA")

	-- Crafted Malevolent Gladiator's Ringmail Gauntlets -- 143148
	recipe = AddRecipe(143148, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 611, 616)
	recipe:SetCraftedItem(98895, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.SHAMAN)
	recipe:AddDiscovery("DISCOVERY_LW_HARDENED_PANDARIA")

	-- Crafted Malevolent Gladiator's Ringmail Helm -- 143149
	recipe = AddRecipe(143149, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 611, 616)
	recipe:SetCraftedItem(98896, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.SHAMAN)
	recipe:AddDiscovery("DISCOVERY_LW_HARDENED_PANDARIA")

	-- Crafted Malevolent Gladiator's Ringmail Leggings -- 143150
	recipe = AddRecipe(143150, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 611, 616)
	recipe:SetCraftedItem(98897, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.SHAMAN)
	recipe:AddDiscovery("DISCOVERY_LW_HARDENED_PANDARIA")

	-- Crafted Malevolent Gladiator's Ringmail Spaulders -- 143151
	recipe = AddRecipe(143151, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 611, 616)
	recipe:SetCraftedItem(98898, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.SHAMAN)
	recipe:AddDiscovery("DISCOVERY_LW_HARDENED_PANDARIA")

	-- Crafted Malevolent Gladiator's Linked Armor -- 143152
	recipe = AddRecipe(143152, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 611, 616)
	recipe:SetCraftedItem(98899, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.SHAMAN)
	recipe:AddDiscovery("DISCOVERY_LW_HARDENED_PANDARIA")

	-- Crafted Malevolent Gladiator's Linked Gauntlets -- 143153
	recipe = AddRecipe(143153, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 611, 616)
	recipe:SetCraftedItem(98900, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.SHAMAN)
	recipe:AddDiscovery("DISCOVERY_LW_HARDENED_PANDARIA")

	-- Crafted Malevolent Gladiator's Linked Helm -- 143154
	recipe = AddRecipe(143154, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 611, 616)
	recipe:SetCraftedItem(98901, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.SHAMAN)
	recipe:AddDiscovery("DISCOVERY_LW_HARDENED_PANDARIA")

	-- Crafted Malevolent Gladiator's Linked Leggings -- 143155
	recipe = AddRecipe(143155, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 611, 616)
	recipe:SetCraftedItem(98902, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.SHAMAN)
	recipe:AddDiscovery("DISCOVERY_LW_HARDENED_PANDARIA")

	-- Crafted Malevolent Gladiator's Linked Spaulders -- 143156
	recipe = AddRecipe(143156, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 611, 616)
	recipe:SetCraftedItem(98903, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.SHAMAN)
	recipe:AddDiscovery("DISCOVERY_LW_HARDENED_PANDARIA")

	-- Crafted Malevolent Gladiator's Waistguard of Cruelty -- 143157
	recipe = AddRecipe(143157, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 611, 616)
	recipe:SetCraftedItem(98904, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.SHAMAN)
	recipe:AddDiscovery("DISCOVERY_LW_HARDENED_PANDARIA")

	-- Crafted Malevolent Gladiator's Mail Armor -- 143158
	recipe = AddRecipe(143158, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 611, 616)
	recipe:SetCraftedItem(98905, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.SHAMAN)
	recipe:AddDiscovery("DISCOVERY_LW_HARDENED_PANDARIA")

	-- Crafted Malevolent Gladiator's Mail Gauntlets -- 143159
	recipe = AddRecipe(143159, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 611, 616)
	recipe:SetCraftedItem(98906, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.SHAMAN)
	recipe:AddDiscovery("DISCOVERY_LW_HARDENED_PANDARIA")

	-- Crafted Malevolent Gladiator's Mail Helm -- 143160
	recipe = AddRecipe(143160, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 611, 616)
	recipe:SetCraftedItem(98907, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.SHAMAN)
	recipe:AddDiscovery("DISCOVERY_LW_HARDENED_PANDARIA")

	-- Crafted Malevolent Gladiator's Mail Leggings -- 143161
	recipe = AddRecipe(143161, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 611, 616)
	recipe:SetCraftedItem(98908, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.SHAMAN)
	recipe:AddDiscovery("DISCOVERY_LW_HARDENED_PANDARIA")

	-- Crafted Malevolent Gladiator's Mail Spaulders -- 143162
	recipe = AddRecipe(143162, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 611, 616)
	recipe:SetCraftedItem(98909, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER, F.SHAMAN)
	recipe:AddDiscovery("DISCOVERY_LW_HARDENED_PANDARIA")

	-- Drums of Rage -- 146613
	recipe = AddRecipe(146613, V.MOP, Q.UNCOMMON)
	recipe:SetSkillLevels(600, 600, 600, 600, 600)
	recipe:SetRecipeItem(102513, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(102351, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_CREATED_ITEM")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddWorldDrop(Z.PANDARIA)

	-- Accelerated Hardened Magnificent Hide -- 146923
	recipe = AddRecipe(146923, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 612, 618)
	recipe:SetCraftedItem(98617, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_MATERIALS")
	recipe:AddDiscovery("DISCOVERY_LW_HARDENED_PANDARIA")

	-- ----------------------------------------------------------------------------
	-- Warlords of Draenor.
	-- ----------------------------------------------------------------------------
	-- Blackened Dragonscale -- 163216
	recipe = AddRecipe(163216, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(52979, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_MATERIALS")
	recipe:AddTrainer(3007, 3069, 3365, 3549, 3967, 4212, 4588, 5127, 5564, 16688, 16728, 17442, 18754, 21087, 53436, 66354, 98948, 98964)

	-- Deepsea Scale -- 163218
	recipe = AddRecipe(163218, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(52982, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_MATERIALS")
	recipe:AddTrainer(3007, 3069, 3365, 3549, 3967, 4212, 4588, 5127, 5564, 16688, 16728, 17442, 18754, 21087, 53436, 66354, 98948, 98964)

	-- Prismatic Scale -- 163220
	recipe = AddRecipe(163220, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(79101, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_MATERIALS")
	recipe:AddTrainer(3069, 3967, 4212, 17442, 18754, 21087, 65121, 66354, 98948, 98964)

	-- Icy Dragonscale -- 163222
	recipe = AddRecipe(163222, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(38557, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_MATERIALS")
	recipe:AddTrainer(3069, 3967, 4212, 17442, 18754, 21087, 26911, 26961, 26998, 28700, 29507, 29508, 29509, 33581, 66354, 98948, 98964)

	-- Nerubian Chitin -- 163223
	recipe = AddRecipe(163223, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(38558, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_MATERIALS")
	recipe:AddTrainer(3069, 3967, 4212, 17442, 18754, 21087, 26911, 26961, 26998, 28700, 29507, 29508, 29509, 33581, 66354, 98948, 98964)

	-- Jormungar Scale -- 163224
	recipe = AddRecipe(163224, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(38561, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_MATERIALS")
	recipe:AddTrainer(3069, 3967, 4212, 17442, 18754, 21087, 26911, 26961, 26998, 28700, 29507, 29508, 29509, 33581, 66354, 98948, 98964)

	-- Thick Clefthoof Leather -- 163225
	recipe = AddRecipe(163225, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(25708, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_MATERIALS")
	recipe:AddTrainer(3069, 3967, 4212, 17442, 18754, 19187, 21087, 33612, 33635, 33681, 66354, 98948, 98964)

	-- Crystal Infused Leather -- 163226
	recipe = AddRecipe(163226, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(25699, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_MATERIALS")
	recipe:AddTrainer(3069, 3967, 4212, 17442, 18754, 19187, 21087, 33612, 33635, 33681, 66354, 98948, 98964)

	-- Fel Scales -- 163228
	recipe = AddRecipe(163228, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(25700, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_MATERIALS")
	recipe:AddTrainer(3069, 3967, 4212, 17442, 18754, 19187, 21087, 33612, 33635, 33681, 66354, 98948, 98964)

	-- Fel Hide -- 163229
	recipe = AddRecipe(163229, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(25707, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_MATERIALS")
	recipe:AddTrainer(3069, 3967, 4212, 17442, 18754, 19187, 21087, 33612, 33635, 33681, 66354, 98948, 98964)

	-- Nether Dragonscales -- 163230
	recipe = AddRecipe(163230, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(29548, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_MATERIALS")
	recipe:AddTrainer(3069, 3967, 4212, 17442, 18754, 19187, 21087, 33612, 33635, 33681, 66354, 98948, 98964)

	-- Cobra Scales -- 163231
	recipe = AddRecipe(163231, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(29539, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_MATERIALS")
	recipe:AddTrainer(3069, 3967, 4212, 17442, 18754, 19187, 21087, 33612, 33635, 33681, 66354, 98948, 98964)

	-- Wind Scales -- 163232
	recipe = AddRecipe(163232, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(29547, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_MATERIALS")
	recipe:AddTrainer(3069, 3967, 4212, 17442, 18754, 19187, 21087, 33612, 33635, 33681, 66354, 98948, 98964)

	-- Journeying Helm -- 171260
	recipe = AddRecipe(171260, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 600, 600, 600)
	recipe:SetCraftedItem(116164, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddCustom("DRAENOR_DEFAULT")

	-- Journeying Robes -- 171261
	recipe = AddRecipe(171261, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 600, 600, 600)
	recipe:SetCraftedItem(116165, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddCustom("DRAENOR_DEFAULT")

	-- Journeying Slacks -- 171262
	recipe = AddRecipe(171262, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 600, 600, 600)
	recipe:SetCraftedItem(116166, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddCustom("DRAENOR_DEFAULT")

	-- Traveling Helm -- 171263
	recipe = AddRecipe(171263, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 600, 600, 600)
	recipe:SetCraftedItem(116167, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddCustom("DRAENOR_DEFAULT")

	-- Traveling Tunic -- 171264
	recipe = AddRecipe(171264, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 600, 600, 600)
	recipe:SetCraftedItem(116168, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddCustom("DRAENOR_DEFAULT")

	-- Traveling Leggings -- 171265
	recipe = AddRecipe(171265, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 600, 600, 600)
	recipe:SetCraftedItem(116169, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddCustom("DRAENOR_DEFAULT")

	-- Leather Refurbishing Kit -- 171266
	recipe = AddRecipe(171266, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 700, 700)
	recipe:SetRecipeItem(116325, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(116170, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddVendor(77383, 79834, 87057, 87549)

	-- Powerful Burnished Cloak -- 171267
	recipe = AddRecipe(171267, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 700, 700)
	recipe:SetRecipeItem(116326, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(116171, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_BACK")
	recipe:AddFilters(F.DPS)
	recipe:AddVendor(77383, 79834, 87057, 87549)

	-- Nimble Burnished Cloak -- 171268
	recipe = AddRecipe(171268, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 700, 700)
	recipe:SetRecipeItem(116327, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(116174, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_BACK")
	recipe:AddFilters(F.DPS)
	recipe:AddVendor(77383, 79834, 87057, 87549)

	-- Brilliant Burnished Cloak -- 171269
	recipe = AddRecipe(171269, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 700, 700)
	recipe:SetRecipeItem(116328, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(116175, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_BACK")
	recipe:AddFilters(F.CASTER, F.HEALER)
	recipe:AddVendor(77383, 79834, 87057, 87549)

	-- Supple Shoulderguards -- 171270
	recipe = AddRecipe(171270, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 700, 701)
	recipe:SetRecipeItem(116329, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(116176, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(77383, 79834, 87057, 87549)

	-- Supple Helm -- 171271
	recipe = AddRecipe(171271, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 700, 701)
	recipe:SetRecipeItem(116330, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(116177, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(77383, 79834, 87057, 87549)

	-- Supple Leggings -- 171272
	recipe = AddRecipe(171272, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 700, 701)
	recipe:SetRecipeItem(116331, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(116178, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(77383, 79834, 87057, 87549)

	-- Supple Gloves -- 171273
	recipe = AddRecipe(171273, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 700, 701)
	recipe:SetRecipeItem(116332, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(116179, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(77383, 79834, 87057, 87549)

	-- Supple Vest -- 171274
	recipe = AddRecipe(171274, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 700, 701)
	recipe:SetRecipeItem(116333, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(116180, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(77383, 79834, 87057, 87549)

	-- Supple Bracers -- 171275
	recipe = AddRecipe(171275, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 700, 701)
	recipe:SetRecipeItem(116334, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(116181, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(77383, 79834, 87057, 87549)

	-- Supple Boots -- 171276
	recipe = AddRecipe(171276, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 700, 701)
	recipe:SetRecipeItem(116335, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(116182, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(77383, 79834, 87057, 87549)

	-- Supple Waistguard -- 171277
	recipe = AddRecipe(171277, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 700, 701)
	recipe:SetRecipeItem(116336, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(116183, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(77383, 79834, 87057, 87549)

	-- Wayfaring Shoulderguards -- 171278
	recipe = AddRecipe(171278, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 700, 701)
	recipe:SetRecipeItem(116337, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(116187, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_SHOULDER")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(77383, 79834, 87057, 87549)

	-- Wayfaring Helm -- 171279
	recipe = AddRecipe(171279, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 700, 701)
	recipe:SetRecipeItem(116338, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(116188, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HEAD")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(77383, 79834, 87057, 87549)

	-- Wayfaring Leggings -- 171280
	recipe = AddRecipe(171280, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 700, 701)
	recipe:SetRecipeItem(116339, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(116189, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(77383, 79834, 87057, 87549)

	-- Wayfaring Gloves -- 171281
	recipe = AddRecipe(171281, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 700, 701)
	recipe:SetRecipeItem(116340, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(116190, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(77383, 79834, 87057, 87549)

	-- Wayfaring Tunic -- 171282
	recipe = AddRecipe(171282, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 700, 701)
	recipe:SetRecipeItem(116341, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(116191, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(77383, 79834, 87057, 87549)

	-- Wayfaring Bracers -- 171283
	recipe = AddRecipe(171283, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 700, 701)
	recipe:SetRecipeItem(116342, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(116192, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(77383, 79834, 87057, 87549)

	-- Wayfaring Boots -- 171284
	recipe = AddRecipe(171284, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 700, 701)
	recipe:SetRecipeItem(116343, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(116193, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(77383, 79834, 87057, 87549)

	-- Wayfaring Belt -- 171285
	recipe = AddRecipe(171285, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 700, 701)
	recipe:SetRecipeItem(116344, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(116194, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(77383, 79834, 87057, 87549)

	-- Burnished Leather Bag -- 171288
	recipe = AddRecipe(171288, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 700, 700)
	recipe:SetRecipeItem(116347, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(116259, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_BAG")
	recipe:AddVendor(77383, 79834, 87057, 87549)

	-- Burnished Mining Bag -- 171289
	recipe = AddRecipe(171289, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 700, 700)
	recipe:SetRecipeItem(116348, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(116260, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_BAG")
	recipe:AddVendor(77383, 79834, 87057, 87549)

	-- Burnished Inscription Bag -- 171290
	recipe = AddRecipe(171290, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 700, 700)
	recipe:SetRecipeItem(116349, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(116261, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_BAG")
	recipe:AddVendor(77383, 79834, 87057, 87549)

	-- Riding Harness -- 171291
	recipe = AddRecipe(171291, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 700, 700)
	recipe:SetRecipeItem(116350, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(108883, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CREATED_ITEM")
	recipe:AddVendor(77383, 79834, 87057, 87549)

	-- Burnished Leather -- 171391
	recipe = AddRecipe(171391, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 800, 1000)
	recipe:SetCraftedItem(110611, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_MATERIALS")
	recipe:AddCustom("DRAENOR_DEFAULT")

	-- Secrets of Draenor Leatherworking -- 176089
	recipe = AddRecipe(176089, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 600, 650, 700)
	recipe:SetCraftedItem(118721, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_CREATED_ITEM")
	recipe:AddCustom("DRAENOR_DEFAULT")

	-- Drums of Fury -- 178208
	recipe = AddRecipe(178208, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 600, 600, 600)
	recipe:SetRecipeItem(120258, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(120257, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CREATED_ITEM")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(77383, 79834, 87057, 87549)

	-- Spiritual Leathercraft -- 182121
	recipe = AddRecipe(182121, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 700, 700)
	recipe:SetRecipeItem(122715, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(110611, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_MATERIALS")
	recipe:AddVendor(91024, 91033)

	-- ----------------------------------------------------------------------------
	-- Legion.
	-- ----------------------------------------------------------------------------
	-- Warhide Bindings -- 194695
	recipe = AddRecipe(194695, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 710, 720)
	recipe:SetCraftedItem(128883, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddQuest(40186)

	-- Warhide Belt -- 194696
	recipe = AddRecipe(194696, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 710, 720)
	recipe:SetCraftedItem(128882, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddQuest(40179)

	-- Warhide Shoulderguard -- 194697
	recipe = AddRecipe(194697, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 710, 720)
	recipe:SetCraftedItem(128881, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_SHOULDER")
	recipe:AddQuest(40185)

	-- Warhide Pants -- 194698
	recipe = AddRecipe(194698, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 710, 720)
	recipe:SetCraftedItem(128880, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddQuest(40179)

	-- Warhide Mask -- 194699
	recipe = AddRecipe(194699, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 710, 720)
	recipe:SetCraftedItem(128879, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HEAD")
	recipe:AddQuest(40183)

	-- Warhide Gloves -- 194700
	recipe = AddRecipe(194700, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 710, 720)
	recipe:SetCraftedItem(128878, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddQuest(40186)

	-- Warhide Footpads -- 194701
	recipe = AddRecipe(194701, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 710, 720)
	recipe:SetCraftedItem(128877, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddQuest(40176)

	-- Warhide Jerkin -- 194702
	recipe = AddRecipe(194702, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 710, 720)
	recipe:SetCraftedItem(128876, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddQuest(40178)

	-- Warhide Bindings -- 194703
	recipe = AddRecipe(194703, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 720, 730, 740)
	recipe:SetCraftedItem(128883, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddQuest(40192)

	-- Warhide Belt -- 194704
	recipe = AddRecipe(194704, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 720, 730, 740)
	recipe:SetRecipeItem(137869, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(128882, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddQuest(40192)
	recipe:AddVendor(107760)

	-- Warhide Shoulderguard -- 194705
	recipe = AddRecipe(194705, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 720, 730, 740)
	recipe:SetCraftedItem(128881, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_SHOULDER")
	recipe:AddQuest(40198)

	-- Warhide Pants -- 194706
	recipe = AddRecipe(194706, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 720, 730, 740)
	recipe:SetCraftedItem(128880, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddQuest(40205)

	-- Warhide Mask -- 194707
	recipe = AddRecipe(194707, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 720, 730, 740)
	recipe:SetCraftedItem(128879, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HEAD")
	recipe:AddQuest(40203)

	-- Warhide Gloves -- 194708
	recipe = AddRecipe(194708, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 720, 730, 740)
	recipe:SetCraftedItem(128878, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddQuest(40204)

	-- Warhide Footpads -- 194709
	recipe = AddRecipe(194709, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 720, 730, 740)
	recipe:SetCraftedItem(128877, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddQuest(40198)

	-- Warhide Jerkin -- 194710
	recipe = AddRecipe(194710, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 720, 730, 740)
	recipe:SetCraftedItem(128876, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddQuest(40191)

	-- Warhide Bindings -- 194711
	recipe = AddRecipe(194711, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 740, 750, 760)
	recipe:SetRecipeItem(137876, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(128883, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddFilters(F.INSTANCE)
	recipe:AddMobDrop(101403)

	-- Warhide Pants -- 194712
	recipe = AddRecipe(194712, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 740, 750, 760)
	recipe:SetRecipeItem(137877, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(128880, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.INSTANCE)
	recipe:AddMobDrop(96028)

	-- Warhide Mask -- 194713
	recipe = AddRecipe(194713, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 740, 750, 760)
	recipe:SetRecipeItem(137878, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(128879, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HEAD")
	recipe:AddQuest(41640)

	-- Warhide Gloves -- 194714
	recipe = AddRecipe(194714, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 720, 730, 740)
	recipe:SetRecipeItem(137879, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(128878, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddQuest(41644)

	-- Warhide Footpads -- 194715
	recipe = AddRecipe(194715, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 720, 730, 740)
	recipe:SetRecipeItem(137880, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(128877, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddQuest(41642)

	-- Warhide Belt -- 194716
	recipe = AddRecipe(194716, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 740, 750, 760)
	recipe:SetRecipeItem(137881, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(128882, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddVendor(107760)

	-- Warhide Shoulderguard -- 194717
	recipe = AddRecipe(194717, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 740, 750, 760)
	recipe:SetRecipeItem(137882, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(128881, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_SHOULDER")
	recipe:AddWorldDrop(Z.THE_VIOLET_HOLD)

	-- Warhide Jerkin -- 194718
	recipe = AddRecipe(194718, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 740, 750, 760)
	recipe:SetRecipeItem(137883, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(128876, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddRepVendor(FAC.DREAMWEAVERS, REP.HONORED, 106901)

	-- Dreadleather Bindings -- 194719
	recipe = AddRecipe(194719, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 760, 770, 780)
	recipe:SetRecipeItem(137884, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(128891, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddVendor(93521)

	-- Dreadleather Belt -- 194720
	recipe = AddRecipe(194720, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 760, 770, 780)
	recipe:SetRecipeItem(137885, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(128890, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddVendor(107760)

	-- Dreadleather Shoulderguard -- 194721
	recipe = AddRecipe(194721, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 760, 770, 780)
	recipe:SetRecipeItem(137886, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(128889, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_SHOULDER")
	recipe:AddVendor(93521)

	-- Dreadleather Pants -- 194722
	recipe = AddRecipe(194722, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 760, 770, 780)
	recipe:SetRecipeItem(137887, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(128888, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddVendor(93521)

	-- Dreadleather Mask -- 194723
	recipe = AddRecipe(194723, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 760, 770, 780)
	recipe:SetRecipeItem(137888, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(128887, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HEAD")
	recipe:AddVendor(93521)

	-- Dreadleather Gloves -- 194724
	recipe = AddRecipe(194724, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 760, 770, 780)
	recipe:SetRecipeItem(137889, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(128886, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddVendor(93521)

	-- Dreadleather Footpads -- 194725
	recipe = AddRecipe(194725, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 760, 770, 780)
	recipe:SetRecipeItem(137890, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(128885, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddVendor(93521)

	-- Dreadleather Jerkin -- 194726
	recipe = AddRecipe(194726, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 760, 770, 780)
	recipe:SetRecipeItem(137891, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(128884, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddVendor(93521)

	-- Dreadleather Bindings -- 194727
	recipe = AddRecipe(194727, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 780, 790, 800)
	recipe:SetRecipeItem(137892, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(128891, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddQuest(43943)
	recipe:AddCustom("WITHERED_ARMY")

	-- Dreadleather Belt -- 194728
	recipe = AddRecipe(194728, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 780, 790, 800)
	recipe:SetRecipeItem(137893, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(128890, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddVendor(107760)

	-- Dreadleather Shoulderguard -- 194729
	recipe = AddRecipe(194729, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 780, 790, 800)
	recipe:SetRecipeItem(137894, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(128889, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_SHOULDER")
	recipe:AddFilters(F.PVP)
	recipe:AddCustom("RATED_PVP")

	-- Dreadleather Pants -- 194730
	recipe = AddRecipe(194730, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 780, 790, 800)
	recipe:SetRecipeItem(137895, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(128888, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddRepVendor(FAC.DREAMWEAVERS, REP.EXALTED, 106901)

	-- Dreadleather Mask -- 194731
	recipe = AddRecipe(194731, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 780, 790, 800)
	recipe:SetRecipeItem(137896, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(128887, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HEAD")
	recipe:AddRepVendor(FAC.DREAMWEAVERS, REP.EXALTED, 106901)

	-- Dreadleather Gloves -- 194732
	recipe = AddRecipe(194732, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 780, 790, 800)
	recipe:SetRecipeItem(137897, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(128886, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddMobDrop(98208)
	recipe:AddCustom("HEROIC")

	-- Dreadleather Footpads -- 194733
	recipe = AddRecipe(194733, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 780, 790, 800)
	recipe:SetRecipeItem(137898, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(128885, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddRepVendor(FAC.DREAMWEAVERS, REP.EXALTED, 106901)

	-- Dreadleather Jerkin -- 194734
	recipe = AddRecipe(194734, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 780, 790, 800)
	recipe:SetRecipeItem(137899, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(128884, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddCustom("MYTHIC", "WATERLOGGED_CACHE")

	-- Battlebound Armbands -- 194735
	recipe = AddRecipe(194735, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 710, 720)
	recipe:SetCraftedItem(128899, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddQuest(40188)

	-- Battlebound Girdle -- 194736
	recipe = AddRecipe(194736, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 710, 720)
	recipe:SetCraftedItem(128898, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddQuest(40181)

	-- Battlebound Spaulders -- 194737
	recipe = AddRecipe(194737, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 710, 720)
	recipe:SetCraftedItem(128897, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_SHOULDER")
	recipe:AddQuest(40189)

	-- Battlebound Leggings -- 194738
	recipe = AddRecipe(194738, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 710, 720)
	recipe:SetCraftedItem(128896, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddQuest(40181)

	-- Battlebound Warhelm -- 194739
	recipe = AddRecipe(194739, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 740, 750, 760)
	recipe:SetCraftedItem(128895, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HEAD")
	recipe:AddQuest(40183)

	-- Battlebound Grips -- 194740
	recipe = AddRecipe(194740, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 740, 750, 760)
	recipe:SetCraftedItem(128894, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddQuest(40188)

	-- Battlebound Treads -- 194741
	recipe = AddRecipe(194741, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 740, 750, 760)
	recipe:SetCraftedItem(128893, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddQuest(40176)

	-- Battlebound Hauberk -- 194742
	recipe = AddRecipe(194742, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 710, 720)
	recipe:SetCraftedItem(128892, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddQuest(40182)

	-- Battlebound Armbands -- 194743
	recipe = AddRecipe(194743, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 720, 730, 740)
	recipe:SetCraftedItem(128899, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddQuest(40194)

	-- Battlebound Girdle -- 194744
	recipe = AddRecipe(194744, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 720, 730, 740)
	recipe:SetRecipeItem(137901, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(128898, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddVendor(107760)
	recipe:AddQuest(40194)

	-- Battlebound Spaulders -- 194745
	recipe = AddRecipe(194745, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 720, 730, 740)
	recipe:SetCraftedItem(128897, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_SHOULDER")
	recipe:AddQuest(40199)

	-- Battlebound Leggings -- 194746
	recipe = AddRecipe(194746, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 720, 730, 740)
	recipe:SetCraftedItem(128896, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddQuest(40209)

	-- Battlebound Warhelm -- 194747
	recipe = AddRecipe(194747, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 720, 730, 740)
	recipe:SetCraftedItem(128895, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HEAD")
	recipe:AddQuest(40208)

	-- Battlebound Grips -- 194748
	recipe = AddRecipe(194748, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 720, 730, 740)
	recipe:SetCraftedItem(128894, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddQuest(40207)

	-- Battlebound Treads -- 194749
	recipe = AddRecipe(194749, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 720, 730, 740)
	recipe:SetCraftedItem(128893, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddQuest(40199)

	-- Battlebound Hauberk -- 194750
	recipe = AddRecipe(194750, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 710, 720)
	recipe:SetCraftedItem(128892, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddQuest(40327)

	-- Battlebound Armbands -- 194751
	recipe = AddRecipe(194751, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 740, 750, 760)
	recipe:SetRecipeItem(137908, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(128899, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddQuest(41641)

	-- Battlebound Leggings -- 194752
	recipe = AddRecipe(194752, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 740, 750, 760)
	recipe:SetRecipeItem(137909, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(128896, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddQuest(41643)

	-- Battlebound Warhelm -- 194753
	recipe = AddRecipe(194753, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 740, 750, 760)
	recipe:SetRecipeItem(137910, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(128895, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HEAD")
	recipe:AddRepVendor(FAC.VALARJAR, REP.HONORED, 106904)

	-- Battlebound Grips -- 194754
	recipe = AddRecipe(194754, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 740, 750, 760)
	recipe:SetRecipeItem(137911, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(128894, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddMobDrop(110962)

	-- Battlebound Treads -- 194755
	recipe = AddRecipe(194755, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 740, 750, 760)
	recipe:SetRecipeItem(137912, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(128893, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddMobDrop(91007)

	-- Battlebound Girdle -- 194756
	recipe = AddRecipe(194756, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 740, 750, 760)
	recipe:SetRecipeItem(137913, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(128898, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddVendor(107760)

	-- Battlebound Spaulders -- 194757
	recipe = AddRecipe(194757, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 740, 750, 760)
	recipe:SetRecipeItem(137914, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(128897, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_SHOULDER")
	recipe:AddQuest(41639)

	-- Battlebound Hauberk -- 194758
	recipe = AddRecipe(194758, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 740, 750, 760)
	recipe:SetRecipeItem(137915, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(128892, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddRepVendor(FAC.VALARJAR, REP.HONORED, 106904)

	-- Gravenscale Armbands -- 194759
	recipe = AddRecipe(194759, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 760, 770, 780)
	recipe:SetRecipeItem(137916, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(128907, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddVendor(93521)

	-- Gravenscale Girdle -- 194760
	recipe = AddRecipe(194760, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 760, 770, 780)
	recipe:SetRecipeItem(137917, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(128906, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddVendor(107760)

	-- Gravenscale Spaulders -- 194761
	recipe = AddRecipe(194761, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 760, 770, 780)
	recipe:SetRecipeItem(137918, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(128905, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_SHOULDER")
	recipe:AddVendor(93521)

	-- Gravenscale Leggings -- 194762
	recipe = AddRecipe(194762, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 760, 770, 780)
	recipe:SetRecipeItem(137919, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(128904, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddVendor(93521)

	-- Gravenscale Warhelm -- 194763
	recipe = AddRecipe(194763, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 760, 770, 780)
	recipe:SetRecipeItem(137920, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(128903, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HEAD")
	recipe:AddVendor(93521)

	-- Gravenscale Grips -- 194764
	recipe = AddRecipe(194764, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 760, 770, 780)
	recipe:SetRecipeItem(137921, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(128902, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddVendor(93521)

	-- Gravenscale Treads -- 194765
	recipe = AddRecipe(194765, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 760, 770, 780)
	recipe:SetRecipeItem(137922, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(128901, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddVendor(93521)

	-- Gravenscale Hauberk -- 194766
	recipe = AddRecipe(194766, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 760, 770, 780)
	recipe:SetRecipeItem(137923, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(128900, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddVendor(93521)

	-- Gravenscale Armbands -- 194767
	recipe = AddRecipe(194767, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 780, 790, 800)
	recipe:SetRecipeItem(137924, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(128907, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddWorldDrop(Z.BROKEN_ISLES)

	-- Gravenscale Girdle -- 194768
	recipe = AddRecipe(194768, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 780, 790, 800)
	recipe:SetRecipeItem(137925, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(128906, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddVendor(107760)

	-- Gravenscale Spaulders -- 194769
	recipe = AddRecipe(194769, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 780, 790, 800)
	recipe:SetRecipeItem(137926, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(128905, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_SHOULDER")
	recipe:AddFilters(F.PVP)
	recipe:AddCustom("RATED_PVP")

	-- Gravenscale Leggings -- 194770
	recipe = AddRecipe(194770, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 780, 790, 800)
	recipe:SetRecipeItem(137927, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(128904, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddRepVendor(FAC.VALARJAR, REP.HONORED, 106904)

	-- Gravenscale Warhelm -- 194771
	recipe = AddRecipe(194771, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 780, 790, 800)
	recipe:SetRecipeItem(137928, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(128903, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HEAD")
	recipe:AddRepVendor(FAC.VALARJAR, REP.HONORED, 106904)

	-- Gravenscale Grips -- 194772
	recipe = AddRecipe(194772, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 780, 790, 800)
	recipe:SetRecipeItem(137929, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(128902, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.INSTANCE)
	recipe:AddMobDrop(104218)
	recipe:AddCustom("MYTHIC")

	-- Gravenscale Treads -- 194773
	recipe = AddRecipe(194773, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 760, 770, 780)
	recipe:SetRecipeItem(137930, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(128901, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddFilters(F.INSTANCE)
	recipe:AddMobDrop(95888)
	recipe:AddCustom("HEROIC")

	-- Gravenscale Hauberk -- 194774
	recipe = AddRecipe(194774, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 740, 750, 760)
	recipe:SetRecipeItem(137931, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(128900, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddFilters(F.INSTANCE)
	recipe:AddMobDrop(94923)

	-- Flaming Hoop -- 194775
	recipe = AddRecipe(194775, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 725, 750)
	recipe:SetRecipeItem(137932, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(129961, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CREATED_ITEM")
	recipe:AddVendor(97364)

	-- Leather Pet Bed -- 194776
	recipe = AddRecipe(194776, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 725, 750)
	recipe:SetRecipeItem(137933, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(129960, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CREATED_ITEM")
	recipe:AddQuest(40201)

	-- Leather Pet Leash -- 194778
	recipe = AddRecipe(194778, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 712, 725)
	recipe:SetRecipeItem(137934, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(129958, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CREATED_ITEM")
	recipe:AddVendor(97364)

	-- Leather Love Seat -- 194779
	recipe = AddRecipe(194779, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 725, 750)
	recipe:SetRecipeItem(137935, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(129956, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CREATED_ITEM")
	recipe:AddVendor(107109)

	-- Elderhorn Riding Harness -- 194780
	recipe = AddRecipe(194780, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 800, 800, 800)
	recipe:SetRecipeItem(141850, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(129962, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CREATED_ITEM")
	recipe:AddQuest(40215)

	-- Dreadleather Mask -- 194784
	recipe = AddRecipe(194784, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 740, 750, 760)
	recipe:SetRecipeItem(140640, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(128887, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HEAD")
	recipe:AddVendor(98969)

	-- Dreadleather Footpads -- 194785
	recipe = AddRecipe(194785, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 740, 750, 760)
	recipe:SetRecipeItem(140642, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(128885, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddVendor(98969)

	-- Dreadleather Pants -- 194786
	recipe = AddRecipe(194786, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 740, 750, 760)
	recipe:SetRecipeItem(140639, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(128888, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddVendor(98969)

	-- Dreadleather Bindings -- 194787
	recipe = AddRecipe(194787, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 740, 750, 760)
	recipe:SetRecipeItem(140636, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(128891, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddQuest(40214)

	-- Dreadleather Belt -- 194788
	recipe = AddRecipe(194788, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 740, 750, 760)
	recipe:SetRecipeItem(140637, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(128890, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddVendor(98969)

	-- Dreadleather Shoulderguard -- 194789
	recipe = AddRecipe(194789, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 780, 790, 800)
	recipe:SetRecipeItem(140638, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(128889, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_SHOULDER")
	recipe:AddVendor(98969)

	-- Dreadleather Gloves -- 194790
	recipe = AddRecipe(194790, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 740, 750, 760)
	recipe:SetRecipeItem(140641, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(128886, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddVendor(98969)

	-- Dreadleather Jerkin -- 194791
	recipe = AddRecipe(194791, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 740, 750, 760)
	recipe:SetRecipeItem(140643, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(128884, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddVendor(98969)

	-- Gravenscale Leggings -- 194792
	recipe = AddRecipe(194792, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 740, 750, 760)
	recipe:SetRecipeItem(140647, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(128904, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddVendor(98969)

	-- Gravenscale Treads -- 194793
	recipe = AddRecipe(194793, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 760, 770, 780)
	recipe:SetRecipeItem(140650, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(128901, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddVendor(98969)

	-- Gravenscale Warhelm -- 194794
	recipe = AddRecipe(194794, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 740, 750, 760)
	recipe:SetRecipeItem(140648, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(128903, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HEAD")
	recipe:AddVendor(98969)

	-- Gravenscale Hauberk -- 194795
	recipe = AddRecipe(194795, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 740, 750, 760)
	recipe:SetRecipeItem(140651, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(128900, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddVendor(98969)

	-- Gravenscale Armbands -- 194796
	recipe = AddRecipe(194796, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 740, 750, 760)
	recipe:SetRecipeItem(140644, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(128907, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddQuest(40214)

	-- Gravenscale Girdle -- 194797
	recipe = AddRecipe(194797, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 740, 750, 760)
	recipe:SetRecipeItem(140645, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(128906, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddVendor(98969)

	-- Gravenscale Spaulders -- 194798
	recipe = AddRecipe(194798, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 740, 750, 760)
	recipe:SetRecipeItem(140646, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(128905, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_SHOULDER")
	recipe:AddVendor(98969)

	-- Gravenscale Grips -- 194799
	recipe = AddRecipe(194799, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 740, 750, 760)
	recipe:SetRecipeItem(140649, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(128902, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddVendor(98969)

	-- Stonehide Leather Barding -- 196648
	recipe = AddRecipe(196648, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 712, 725)
	recipe:SetRecipeItem(137952, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(131746, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CREATED_ITEM")
	recipe:AddQuest(41889)

	-- Light Scale Gloves -- 226105
	recipe = AddRecipe(226105, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(55, 55, 85, 100, 115)
	recipe:SetCraftedItem(132490, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddTrainer(1385, 1632, 3007, 3069, 3365, 3549, 3605, 3967, 4212, 4588, 5127, 5564, 5784, 8153, 11097, 11098, 16278, 16688, 16728, 17442, 18754, 18771, 21087, 47384, 47396, 47400, 47418, 47419, 47421, 47431, 48619, 49885, 53436, 57620, 65043, 66354, 85920, 86032, 93522, 93523, 98931, 98948, 98964)

	-- Light Scale Bracers -- 226106
	recipe = AddRecipe(226106, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(70, 70, 100, 115, 130)
	recipe:SetCraftedItem(132491, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddTrainer(1385, 1632, 3007, 3069, 3365, 3549, 3605, 3967, 4212, 4588, 5127, 5564, 5784, 8153, 11097, 11098, 16278, 16688, 16728, 17442, 18754, 18771, 21087, 47384, 47396, 47400, 47418, 47419, 47421, 47431, 48619, 49885, 53436, 57620, 65043, 66354, 85920, 86032, 93522, 93523, 98931, 98948, 98964)

	-- Light Scale Belt -- 226107
	recipe = AddRecipe(226107, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(70, 70, 110, 125, 140)
	recipe:SetCraftedItem(132489, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddTrainer(1385, 1632, 3007, 3069, 3365, 3549, 3605, 3967, 4212, 4588, 5127, 5564, 5784, 8153, 11097, 11098, 16278, 16688, 16728, 17442, 18754, 18771, 21087, 47384, 47396, 47400, 47418, 47419, 47421, 47431, 48619, 49885, 53436, 57620, 65043, 66354, 85920, 86032, 93522, 93523, 98931, 98948, 98964)

	-- Light Scale Jerkin -- 226108
	recipe = AddRecipe(226108, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(85, 85, 115, 130, 145)
	recipe:SetCraftedItem(132487, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddTrainer(1385, 1632, 3007, 3069, 3365, 3549, 3605, 3967, 4212, 4588, 5127, 5564, 5784, 8153, 11097, 11098, 16278, 16688, 16728, 17442, 18754, 18771, 21087, 47419, 47421, 47431, 48619, 49885, 53436, 57620, 65043, 66354, 98948, 98964)

	-- Light Scale Boots -- 226109
	recipe = AddRecipe(226109, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(90, 90, 120, 135, 150)
	recipe:SetCraftedItem(132488, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddTrainer(1385, 1632, 3007, 3069, 3365, 3549, 3605, 3967, 4212, 4588, 5127, 5564, 5784, 8153, 11097, 11098, 16278, 16688, 16728, 17442, 18754, 18771, 21087, 47419, 47421, 47431, 48619, 49885, 53436, 57620, 65043, 66354, 98948, 98964)

	-- Shamanic Treads -- 226110
	recipe = AddRecipe(226110, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(90, 90, 120, 135, 150)
	recipe:SetCraftedItem(132548, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddTrainer(1385, 1632, 3007, 3069, 3365, 3549, 3605, 3967, 4212, 4588, 5127, 5564, 5784, 8153, 11097, 11098, 16278, 16688, 16728, 17442, 18754, 18771, 21087, 47419, 47421, 47431, 48619, 49885, 53436, 57620, 65043, 66354, 98948, 98964)

	-- Light Scale Pants -- 226111
	recipe = AddRecipe(226111, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(105, 105, 125, 140, 155)
	recipe:SetCraftedItem(132492, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddTrainer(1385, 1632, 3007, 3069, 3365, 3549, 3605, 3967, 4212, 4588, 5127, 5564, 5784, 8153, 11097, 11098, 16278, 16688, 16728, 17442, 18754, 18771, 21087, 47419, 47421, 47431, 48619, 49885, 53436, 57620, 65043, 66354, 98948, 98964)

	-- Chain Hauberk -- 226112
	recipe = AddRecipe(226112, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(95, 95, 125, 137, 150)
	recipe:SetCraftedItem(132493, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddTrainer(1385, 1632, 3007, 3069, 3365, 3549, 3605, 3967, 4212, 4588, 5127, 5564, 5784, 8153, 11097, 11098, 16278, 16688, 16728, 17442, 18754, 18771, 21087, 47419, 47421, 47431, 48619, 49885, 53436, 57620, 65043, 66354, 98948, 98964)

	-- Chain Boots -- 226113
	recipe = AddRecipe(226113, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(95, 95, 125, 137, 150)
	recipe:SetCraftedItem(132494, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddTrainer(1385, 1632, 3007, 3069, 3365, 3549, 3605, 3967, 4212, 4588, 5127, 5564, 5784, 8153, 11097, 11098, 16278, 16688, 16728, 17442, 18754, 18771, 21087, 47419, 47421, 47431, 48619, 49885, 53436, 57620, 65043, 66354, 98948, 98964)

	-- Crackling Scale Breastplate -- 226114
	recipe = AddRecipe(226114, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(85, 85, 125, 137, 150)
	recipe:SetCraftedItem(132545, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddTrainer(1385, 1632, 3007, 3069, 3365, 3549, 3605, 3967, 4212, 4588, 5127, 5564, 5784, 8153, 11097, 11098, 16278, 16688, 16728, 17442, 18754, 18771, 21087, 47419, 47421, 47431, 48619, 49885, 53436, 57620, 65043, 66354, 98948, 98964)

	-- Blue Chain Leggings -- 226115
	recipe = AddRecipe(226115, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 130, 142, 155)
	recipe:SetCraftedItem(132547, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddTrainer(1385, 1632, 3007, 3069, 3365, 3549, 3605, 3967, 4212, 4588, 5127, 5564, 5784, 8153, 11097, 11098, 16278, 16688, 16728, 17442, 18754, 18771, 21087, 47419, 47421, 47431, 48619, 49885, 53436, 57620, 65043, 66354, 98948, 98964)

	-- Chain Bracers -- 226116
	recipe = AddRecipe(226116, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(105, 105, 135, 147, 160)
	recipe:SetCraftedItem(132496, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddTrainer(1385, 1632, 3007, 3069, 3365, 3549, 3605, 3967, 4212, 4588, 5127, 5564, 5784, 8153, 11097, 11098, 16278, 16688, 16728, 17442, 18754, 18771, 21087, 47419, 47421, 47431, 48619, 49885, 53436, 57620, 65043, 66354, 98948, 98964)

	-- Chain Leggings -- 226117
	recipe = AddRecipe(226117, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(110, 110, 140, 152, 165)
	recipe:SetCraftedItem(132497, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddTrainer(1385, 1632, 3007, 3069, 3365, 3549, 3605, 3967, 4212, 4588, 5127, 5564, 5784, 8153, 11097, 11098, 16278, 16688, 16728, 17442, 18754, 18771, 21087, 47419, 47421, 47431, 48619, 49885, 53436, 57620, 65043, 66354, 98948, 98964)

	-- Chain Gauntlets -- 226118
	recipe = AddRecipe(226118, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(115, 115, 145, 157, 170)
	recipe:SetCraftedItem(132499, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddTrainer(1385, 1632, 3007, 3069, 3365, 3549, 3605, 3967, 4212, 4588, 5127, 5564, 5784, 8153, 11097, 11098, 16278, 16688, 16728, 17442, 18754, 18771, 21087, 47419, 47421, 47431, 48619, 49885, 53436, 57620, 65043, 66354, 98948, 98964)

	-- Chain Belt -- 226119
	recipe = AddRecipe(226119, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(120, 120, 150, 162, 175)
	recipe:SetCraftedItem(132495, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddTrainer(1385, 1632, 3007, 3069, 3365, 3549, 3605, 3967, 4212, 4588, 5127, 5564, 5784, 8153, 11097, 11098, 16278, 16688, 16728, 17442, 18754, 18771, 21087, 47419, 47421, 47431, 48619, 49885, 53436, 57620, 65043, 66354, 98948, 98964)

	-- Spritescale Epaulets -- 226120
	recipe = AddRecipe(226120, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(125, 125, 155, 167, 180)
	recipe:SetCraftedItem(132543, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_SHOULDER")
	recipe:AddTrainer(1385, 1632, 3007, 3069, 3365, 3549, 3605, 3967, 4212, 4588, 5127, 5564, 5784, 8153, 11097, 11098, 16278, 16688, 16728, 17442, 18754, 18771, 21087, 47419, 47421, 47431, 48619, 49885, 53436, 57620, 65043, 66354, 98948, 98964)

	-- Chain Pauldrons -- 226121
	recipe = AddRecipe(226121, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(130, 130, 160, 172, 185)
	recipe:SetCraftedItem(132498, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_SHOULDER")
	recipe:AddTrainer(1385, 1632, 3007, 3069, 3365, 3549, 3605, 3967, 4212, 4588, 5127, 5564, 5784, 8153, 11097, 11098, 16278, 16688, 16728, 17442, 18754, 18771, 21087, 47419, 47421, 47431, 48619, 49885, 53436, 57620, 65043, 66354, 98948, 98964)

	-- Element Grips -- 226122
	recipe = AddRecipe(226122, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(135, 135, 165, 175, 185)
	recipe:SetCraftedItem(132546, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddTrainer(1385, 1632, 3007, 3069, 3365, 3549, 3605, 3967, 4212, 4588, 5127, 5564, 5784, 8153, 11097, 11098, 16278, 16688, 16728, 17442, 18754, 18771, 21087, 47419, 47421, 47431, 48619, 49885, 53436, 57620, 65043, 66354, 98948, 98964)

	-- Heavy Scale Gauntlets -- 226123
	recipe = AddRecipe(226123, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(140, 140, 170, 180, 190)
	recipe:SetCraftedItem(132533, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddTrainer(1385, 1632, 3007, 3069, 3365, 3549, 3605, 3967, 4212, 4588, 5127, 5564, 5784, 8153, 11097, 11098, 16278, 16688, 16728, 17442, 18754, 18771, 21087, 47419, 47421, 47431, 48619, 49885, 53436, 57620, 65043, 66354, 98948, 98964)

	-- Heavy Scale Wraps -- 226124
	recipe = AddRecipe(226124, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(150, 150, 180, 190, 200)
	recipe:SetCraftedItem(132534, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddTrainer(1385, 1632, 3007, 3069, 3365, 3549, 3605, 3967, 4212, 4588, 5127, 5564, 5784, 8153, 11097, 11098, 16278, 16688, 16728, 17442, 18754, 18771, 21087, 47419, 47421, 47431, 48619, 49885, 53436, 57620, 65043, 66354, 98948, 98964)

	-- Spritescale Britches -- 226125
	recipe = AddRecipe(226125, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(150, 150, 180, 190, 200)
	recipe:SetCraftedItem(132542, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddTrainer(1385, 1632, 3007, 3069, 3365, 3549, 3605, 3967, 4212, 4588, 5127, 5564, 5784, 8153, 11097, 11098, 16278, 16688, 16728, 17442, 18754, 18771, 21087, 47419, 47421, 47431, 48619, 49885, 53436, 57620, 65043, 66354, 98948, 98964)

	-- Heavy Scale Pants -- 226126
	recipe = AddRecipe(226126, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(155, 155, 185, 195, 205)
	recipe:SetCraftedItem(132532, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddTrainer(1385, 1632, 3007, 3069, 3365, 3549, 3605, 3967, 4212, 4588, 5127, 5564, 5784, 8153, 11097, 11098, 16278, 16688, 16728, 17442, 18754, 18771, 21087, 47419, 47421, 47431, 48619, 49885, 53436, 57620, 65043, 66354, 98948, 98964)

	-- Spritescale Cinch -- 226127
	recipe = AddRecipe(226127, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(160, 160, 190, 200, 210)
	recipe:SetCraftedItem(132539, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddTrainer(1385, 1632, 3007, 3069, 3365, 3549, 3605, 3967, 4212, 4588, 5127, 5564, 5784, 8153, 11097, 11098, 16278, 16688, 16728, 17442, 18754, 18771, 21087, 47419, 47421, 47431, 48619, 49885, 53436, 57620, 65043, 66354, 98948, 98964)

	-- Heavy Scale Shirt -- 226128
	recipe = AddRecipe(226128, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(165, 165, 150, 205, 215)
	recipe:SetCraftedItem(132520, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddTrainer(1385, 1632, 3007, 3069, 3365, 3549, 3605, 3967, 4212, 4588, 5127, 5564, 5784, 8153, 11097, 11098, 16278, 16688, 16728, 17442, 18754, 18771, 21087, 47419, 47421, 47431, 48619, 49885, 53436, 57620, 65043, 66354, 98948, 98964)

	-- Heavy Scale Pauldrons -- 226129
	recipe = AddRecipe(226129, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(165, 165, 150, 205, 215)
	recipe:SetCraftedItem(132535, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_SHOULDER")
	recipe:AddTrainer(1385, 1632, 3007, 3069, 3365, 3549, 3605, 3967, 4212, 4588, 5127, 5564, 5784, 8153, 11097, 11098, 16278, 16688, 16728, 17442, 18754, 18771, 21087, 47419, 47421, 47431, 48619, 49885, 53436, 57620, 65043, 66354, 98948, 98964)

	-- Spritescale Jerkin -- 226130
	recipe = AddRecipe(226130, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(165, 165, 150, 205, 215)
	recipe:SetCraftedItem(132538, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddTrainer(1385, 1632, 3007, 3069, 3365, 3549, 3605, 3967, 4212, 4588, 5127, 5564, 5784, 8153, 11097, 11098, 16278, 16688, 16728, 17442, 18754, 18771, 21087, 47419, 47421, 47431, 48619, 49885, 53436, 57620, 65043, 66354, 98948, 98964)

	-- Spritescale Gloves -- 226131
	recipe = AddRecipe(226131, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(180, 180, 210, 220, 230)
	recipe:SetCraftedItem(132540, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddTrainer(1385, 1632, 3007, 3069, 3365, 3549, 3605, 3967, 4212, 4588, 5127, 5564, 5784, 8153, 11097, 11098, 16278, 16688, 16728, 17442, 18754, 18771, 21087, 47419, 47421, 47431, 48619, 49885, 53436, 57620, 65043, 66354, 98948, 98964)

	-- Heavy Scale Belt -- 226132
	recipe = AddRecipe(226132, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(185, 185, 215, 225, 235)
	recipe:SetCraftedItem(132522, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddTrainer(1385, 1632, 3007, 3069, 3365, 3549, 3605, 3967, 4212, 4588, 5127, 5564, 5784, 8153, 11097, 11098, 16278, 16688, 16728, 17442, 18754, 18771, 21087, 47419, 47421, 47431, 48619, 49885, 53436, 57620, 65043, 66354, 98948, 98964)

	-- Spritescale Wraps -- 226133
	recipe = AddRecipe(226133, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(185, 185, 215, 225, 235)
	recipe:SetCraftedItem(132541, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddTrainer(1385, 1632, 3007, 3069, 3365, 3549, 3605, 3967, 4212, 4588, 5127, 5564, 5784, 8153, 11097, 11098, 16278, 16688, 16728, 17442, 18754, 18771, 21087, 47419, 47421, 47431, 48619, 49885, 53436, 57620, 65043, 66354, 98948, 98964)

	-- Heavy Scale Boots -- 226134
	recipe = AddRecipe(226134, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(190, 190, 220, 230, 240)
	recipe:SetCraftedItem(132521, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddTrainer(1385, 1632, 3007, 3069, 3365, 3549, 3605, 3967, 4212, 4588, 5127, 5564, 5784, 8153, 11097, 11098, 16278, 16688, 16728, 17442, 18754, 18771, 21087, 47419, 47421, 47431, 48619, 49885, 53436, 57620, 65043, 66354, 98948, 98964)

	-- Heavy Scale Hood -- 226135
	recipe = AddRecipe(226135, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(190, 190, 220, 230, 240)
	recipe:SetCraftedItem(132536, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HEAD")
	recipe:AddTrainer(1385, 1632, 3007, 3069, 3365, 3549, 3605, 3967, 4212, 4588, 5127, 5564, 5784, 8153, 11097, 11098, 16278, 16688, 16728, 17442, 18754, 18771, 21087, 47419, 47421, 47431, 48619, 49885, 53436, 57620, 65043, 66354, 98948, 98964)

	-- Spritescale Circlet -- 226136
	recipe = AddRecipe(226136, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(190, 190, 220, 230, 240)
	recipe:SetCraftedItem(132537, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HEAD")
	recipe:AddTrainer(1385, 1632, 3007, 3069, 3365, 3549, 3605, 3967, 4212, 4588, 5127, 5564, 5784, 8153, 11097, 11098, 16278, 16688, 16728, 17442, 18754, 18771, 21087, 47419, 47421, 47431, 48619, 49885, 53436, 57620, 65043, 66354, 98948, 98964)

	-- Spritescale Boots -- 226137
	recipe = AddRecipe(226137, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(190, 190, 220, 230, 240)
	recipe:SetCraftedItem(132544, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddTrainer(1385, 1632, 3007, 3069, 3365, 3549, 3605, 3967, 4212, 4588, 5127, 5564, 5784, 8153, 11097, 11098, 16278, 16688, 16728, 17442, 18754, 18771, 21087, 47419, 47421, 47431, 48619, 49885, 53436, 57620, 65043, 66354, 98948, 98964)

	-- Drums of the Mountain -- 230936
	recipe = AddRecipe(230936, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 720, 740)
	recipe:SetRecipeItem(142407, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(142406, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CREATED_ITEM")
	recipe:AddVendor(93521)

	-- Drums of the Mountain -- 230954
	recipe = AddRecipe(230954, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 720, 740, 760)
	recipe:SetRecipeItem(142408, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(142406, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CREATED_ITEM")
	recipe:AddRepVendor(FAC.HIGHMOUNTAIN_TRIBE, REP.REVERED, 106902)

	-- Drums of the Mountain -- 230955
	recipe = AddRecipe(230955, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 740, 760, 780)
	recipe:SetRecipeItem(142409, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(142406, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CREATED_ITEM")
	recipe:AddRepVendor(FAC.HIGHMOUNTAIN_TRIBE, REP.EXALTED, 106902)

	-- The Sentinel's Eternal Refuge -- 239413
	recipe = AddRecipe(239413, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 110, 115, 120)
	recipe:SetCraftedItem(146669, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddTrainer(93523, 98948, 98964)

	-- Vigilance Perch -- 239414
	recipe = AddRecipe(239414, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 110, 115, 120)
	recipe:SetCraftedItem(146668, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddTrainer(93523, 98948, 98964)

	-- Fiendish Shoulderguards -- 247800
	recipe = AddRecipe(247800, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 790, 795, 800)
	recipe:SetRecipeItem(151740, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(151577, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_SHOULDER")
	recipe:AddQuest(48078)

	-- Fiendish Shoulderguards -- 247801
	recipe = AddRecipe(247801, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 790, 795, 800)
	recipe:SetRecipeItem(151741, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(151577, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_SHOULDER")
	recipe:AddRepVendor(FAC.ARMY_OF_THE_LIGHT, REP.REVERED, 127120)

	-- Fiendish Shoulderguards -- 247802
	recipe = AddRecipe(247802, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 790, 795, 800)
	recipe:SetRecipeItem(151742, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(151577, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_SHOULDER")
	recipe:AddMobDrop(122367)

	-- Fiendish Spaulders -- 247803
	recipe = AddRecipe(247803, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 790, 795, 800)
	recipe:SetRecipeItem(151743, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(151578, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_SHOULDER")
	recipe:AddQuest(48078)

	-- Fiendish Spaulders -- 247804
	recipe = AddRecipe(247804, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 790, 795, 800)
	recipe:SetRecipeItem(151744, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(151578, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_SHOULDER")
	recipe:AddRepVendor(FAC.ARMY_OF_THE_LIGHT, REP.REVERED, 127120)

	-- Fiendish Spaulders -- 247805
	recipe = AddRecipe(247805, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 790, 795, 800)
	recipe:SetRecipeItem(151745, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(151578, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_SHOULDER")
	recipe:AddMobDrop(122367)

	-- ----------------------------------------------------------------------------
	-- Battle for Azeroth.
	-- ----------------------------------------------------------------------------
	-- Coarse Leather Treads -- 256748
	recipe = AddRecipe(256748, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(154139, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddTrainer(122698, 136063, 153817, 154321)

	-- Coarse Leather Vest -- 256749
	recipe = AddRecipe(256749, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(154138, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddTrainer(122698, 136063, 153817, 154321)

	-- Coarse Leather Gauntlets -- 256750
	recipe = AddRecipe(256750, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 15, 50, 85)
	recipe:SetCraftedItem(154140, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddCustom("DEFAULT_RECIPE")

	-- Coarse Leather Helm -- 256751
	recipe = AddRecipe(256751, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(154141, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HEAD")
	recipe:AddTrainer(122698, 136063, 153817, 154321)

	-- Coarse Leather Leggings -- 256752
	recipe = AddRecipe(256752, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(154142, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddTrainer(122698, 136063, 153817, 154321)

	-- Coarse Leather Pauldrons -- 256754
	recipe = AddRecipe(256754, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(154143, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_SHOULDER")
	recipe:AddTrainer(122698, 136063, 153817, 154321)

	-- Coarse Leather Waistguard -- 256755
	recipe = AddRecipe(256755, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(154144, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddTrainer(122698, 136063, 153817, 154321)

	-- Coarse Leather Armguards -- 256756
	recipe = AddRecipe(256756, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 10, 47, 85)
	recipe:SetCraftedItem(154145, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddCustom("DEFAULT_RECIPE")

	-- Shimmerscale Armguards -- 256757
	recipe = AddRecipe(256757, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 10, 47, 85)
	recipe:SetCraftedItem(154153, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddCustom("DEFAULT_RECIPE")

	-- Shimmerscale Waistguard -- 256758
	recipe = AddRecipe(256758, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(154152, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddTrainer(122698, 136063, 153817, 154321)

	-- Shimmerscale Pauldrons -- 256759
	recipe = AddRecipe(256759, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(154151, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_SHOULDER")
	recipe:AddTrainer(122698, 136063, 153817, 154321)

	-- Shimmerscale Leggings -- 256760
	recipe = AddRecipe(256760, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(154150, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddTrainer(122698, 136063, 153817, 154321)

	-- Shimmerscale Helm -- 256761
	recipe = AddRecipe(256761, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(154149, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HEAD")
	recipe:AddTrainer(122698, 136063, 153817, 154321)

	-- Shimmerscale Gauntlets -- 256762
	recipe = AddRecipe(256762, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 15, 50, 85)
	recipe:SetCraftedItem(154148, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddCustom("DEFAULT_RECIPE")

	-- Shimmerscale Vest -- 256763
	recipe = AddRecipe(256763, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(154146, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddTrainer(122698, 136063, 153817, 154321)

	-- Shimmerscale Treads -- 256764
	recipe = AddRecipe(256764, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(154147, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddTrainer(122698, 136063, 153817, 154321)

	-- Hardened Tempest Boots -- 256765
	recipe = AddRecipe(256765, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(115, 115, 125, 130, 135)
	recipe:SetCraftedItem(161946, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddTrainer(122698, 136063, 153817, 154321)

	-- Imbued Tempest Boots -- 256766
	recipe = AddRecipe(256766, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 150, 150, 150)
	recipe:SetCraftedItem(162493, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddDiscovery("DISCOVERY_LW_BFA")

	-- Emblazoned Tempest Boots -- 256767
	recipe = AddRecipe(256767, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 150, 150, 150)
	recipe:SetCraftedItem(162468, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddDiscovery("DISCOVERY_LW_BFA")

	-- Hardened Tempest Leggings -- 256768
	recipe = AddRecipe(256768, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(115, 115, 125, 130, 135)
	recipe:SetCraftedItem(161947, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddTrainer(122698, 136063, 153817, 154321)

	-- Imbued Tempest Leggings -- 256769
	recipe = AddRecipe(256769, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 150, 150, 150)
	recipe:SetCraftedItem(162494, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddDiscovery("DISCOVERY_LW_BFA")

	-- Emblazoned Tempest Leggings -- 256770
	recipe = AddRecipe(256770, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 150, 150, 150)
	recipe:SetCraftedItem(162470, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddDiscovery("DISCOVERY_LW_BFA")

	-- Mistscale Boots -- 256771
	recipe = AddRecipe(256771, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(115, 115, 125, 130, 135)
	recipe:SetCraftedItem(161961, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddTrainer(122698, 136063, 153817, 154321)

	-- Imbued Mistscale Boots -- 256772
	recipe = AddRecipe(256772, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 150, 150, 150)
	recipe:SetCraftedItem(162489, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddDiscovery("DISCOVERY_LW_BFA")

	-- Emblazoned Mistscale Boots -- 256773
	recipe = AddRecipe(256773, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 150, 150, 150)
	recipe:SetCraftedItem(162472, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddDiscovery("DISCOVERY_LW_BFA")

	-- Mistscale Leggings -- 256774
	recipe = AddRecipe(256774, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(115, 115, 125, 130, 135)
	recipe:SetCraftedItem(161962, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddTrainer(122698, 136063, 153817, 154321)

	-- Imbued Mistscale Leggings -- 256775
	recipe = AddRecipe(256775, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 150, 150, 150)
	recipe:SetCraftedItem(162472, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddDiscovery("DISCOVERY_LW_BFA")

	-- Emblazoned Mistscale Leggings -- 256776
	recipe = AddRecipe(256776, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 150, 150, 150)
	recipe:SetCraftedItem(162474, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddDiscovery("DISCOVERY_LW_BFA")

	-- Shimmerscale Striker -- 256777
	recipe = AddRecipe(256777, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(154160, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FIST")
	recipe:AddTrainer(122698, 136063, 153817, 154321)

	-- Coarse Leather Cestus -- 256778
	recipe = AddRecipe(256778, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(154161, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FIST")
	recipe:AddTrainer(122698, 136063, 153817, 154321)

	-- Mistscale Knuckles -- 256779
	recipe = AddRecipe(256779, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(85, 85, 95, 100, 105)
	recipe:SetCraftedItem(154162, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FIST")
	recipe:AddTrainer(122698, 136063, 153817, 154321)

	-- Mistscale Knuckles -- 256780
	recipe = AddRecipe(256780, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 110, 115, 120)
	recipe:SetCraftedItem(154162, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FIST")
	recipe:AddTrainer(122698, 136063, 153817, 154321)

	-- Mistscale Knuckles -- 256781
	recipe = AddRecipe(256781, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 120, 135, 150)
	recipe:SetRecipeItem(162413, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(154162, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FIST")
	recipe:AddRepVendor(FAC.PROUDMOORE_ADMIRALTY, REP.REVERED, 135808)
	recipe:AddRepVendor(FAC.TALANJIS_EXPEDITION, REP.REVERED, 135459)

	-- Hardened Tempest Knuckles -- 256782
	recipe = AddRecipe(256782, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(85, 85, 95, 100, 105)
	recipe:SetCraftedItem(154163, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FIST")
	recipe:AddTrainer(122698, 136063, 153817, 154321)

	-- Hardened Tempest Knuckles -- 256783
	recipe = AddRecipe(256783, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 110, 115, 120)
	recipe:SetCraftedItem(154163, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FIST")
	recipe:AddTrainer(122698, 136063, 153817, 154321)

	-- Hardened Tempest Knuckles -- 256784
	recipe = AddRecipe(256784, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 120, 135, 150)
	recipe:SetRecipeItem(162414, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(154163, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FIST")
	recipe:AddRepVendor(FAC.PROUDMOORE_ADMIRALTY, REP.REVERED, 135808)
	recipe:AddRepVendor(FAC.TALANJIS_EXPEDITION, REP.REVERED, 135459)

	-- Recurve Bow of the Strands -- 256787
	recipe = AddRecipe(256787, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(85, 85, 95, 100, 105)
	recipe:SetCraftedItem(154159, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_BOW")
	recipe:AddTrainer(122698, 136063, 153817, 154321)

	-- Recurve Bow of the Strands -- 256788
	recipe = AddRecipe(256788, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 110, 115, 120)
	recipe:SetCraftedItem(154159, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_BOW")
	recipe:AddTrainer(122698, 136063, 153817, 154321)

	-- Recurve Bow of the Strands -- 256789
	recipe = AddRecipe(256789, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 120, 135, 150)
	recipe:SetRecipeItem(162412, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(154159, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FIST")
	recipe:AddRepVendor(FAC.ORDER_OF_EMBERS, REP.REVERED, 135815)
	recipe:AddRepVendor(FAC.VOLDUNAI, REP.REVERED, 135804)

	-- Coarse Leather Barding -- 256790
	recipe = AddRecipe(256790, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(154166, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CREATED_ITEM")
	recipe:AddTrainer(122698, 136063, 153817, 154321)

	-- Drums of the Maelstrom -- 256791
	recipe = AddRecipe(256791, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 85, 90, 95)
	recipe:SetCraftedItem(154167, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CREATED_ITEM")
	recipe:AddTrainer(122698, 136063, 153817, 154321)

	-- Shimmerscale Diving Suit -- 256792
	recipe = AddRecipe(256792, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(154168, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CREATED_ITEM")
	recipe:AddTrainer(122698, 136063, 153817, 154321)

	-- Shimmerscale Diving Helmet -- 256793
	recipe = AddRecipe(256793, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(154169, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CREATED_ITEM")
	recipe:AddTrainer(122698, 136063, 153817, 154321)

	-- Honorable Combatant's Leather Treads -- 269516
	recipe = AddRecipe(269516, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(85, 85, 95, 100, 105)
	recipe:SetCraftedItem(159884, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddTrainer(122698, 136063, 153817, 154321)

	-- Honorable Combatant's Leather Treads -- 269517
	recipe = AddRecipe(269517, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 110, 127, 145)
	recipe:SetRecipeItem(162390, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(159884, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(142552, 142564)

	-- Honorable Combatant's Leather Treads -- 269518
	recipe = AddRecipe(269518, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 120, 135, 150)
	recipe:SetRecipeItem(162391, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(159884, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(142552, 142564)

	-- Honorable Combatant's Leather Gauntlets -- 269519
	recipe = AddRecipe(269519, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(85, 85, 95, 100, 105)
	recipe:SetCraftedItem(159885, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddTrainer(122698, 136063, 153817, 154321)

	-- Honorable Combatant's Leather Gauntlets -- 269520
	recipe = AddRecipe(269520, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 110, 127, 145)
	recipe:SetRecipeItem(162392, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(159885, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(142552, 142564)

	-- Honorable Combatant's Leather Gauntlets -- 269521
	recipe = AddRecipe(269521, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 120, 135, 150)
	recipe:SetRecipeItem(162393, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(159885, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(142552, 142564)

	-- Honorable Combatant's Leather Leggings -- 269522
	recipe = AddRecipe(269522, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(85, 85, 95, 100, 105)
	recipe:SetCraftedItem(159886, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddTrainer(122698, 136063, 153817, 154321)

	-- Honorable Combatant's Leather Leggings -- 269523
	recipe = AddRecipe(269523, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 110, 127, 145)
	recipe:SetRecipeItem(162394, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(159886, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(142552, 142564)

	-- Honorable Combatant's Leather Leggings -- 269524
	recipe = AddRecipe(269524, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 120, 135, 150)
	recipe:SetRecipeItem(162395, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(159886, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(142552, 142564)

	-- Honorable Combatant's Leather Waistguard -- 269525
	recipe = AddRecipe(269525, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(85, 85, 95, 100, 105)
	recipe:SetCraftedItem(159887, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddTrainer(122698, 136063, 153817, 154321)

	-- Honorable Combatant's Leather Waistguard -- 269526
	recipe = AddRecipe(269526, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 110, 127, 145)
	recipe:SetRecipeItem(162396, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(159887, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(142552, 142564)

	-- Honorable Combatant's Leather Waistguard -- 269527
	recipe = AddRecipe(269527, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 120, 135, 150)
	recipe:SetRecipeItem(162397, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(159887, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(142552, 142564)

	-- Honorable Combatant's Leather Armguards -- 269528
	recipe = AddRecipe(269528, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(85, 85, 95, 100, 105)
	recipe:SetCraftedItem(159888, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddTrainer(122698, 136063, 153817, 154321)

	-- Honorable Combatant's Leather Armguards -- 269529
	recipe = AddRecipe(269529, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 110, 127, 145)
	recipe:SetRecipeItem(162398, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(159888, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(142552, 142564)

	-- Honorable Combatant's Leather Armguards -- 269530
	recipe = AddRecipe(269530, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 120, 135, 150)
	recipe:SetRecipeItem(162399, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(159888, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(142552, 142564)

	-- Honorable Combatant's Mail Treads -- 269531
	recipe = AddRecipe(269531, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(85, 85, 95, 100, 105)
	recipe:SetCraftedItem(159889, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddTrainer(122698, 136063, 153817, 154321)

	-- Honorable Combatant's Mail Treads -- 269532
	recipe = AddRecipe(269532, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(85, 85, 110, 127, 145)
	recipe:SetRecipeItem(162402, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(159889, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(142552, 142564)

	-- Honorable Combatant's Mail Treads -- 269533
	recipe = AddRecipe(269533, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(85, 85, 120, 135, 150)
	recipe:SetRecipeItem(162403, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(159889, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(142552, 142564)

	-- Honorable Combatant's Mail Gauntlets -- 269534
	recipe = AddRecipe(269534, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(85, 85, 95, 100, 105)
	recipe:SetCraftedItem(159890, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddTrainer(122698, 136063, 153817, 154321)

	-- Honorable Combatant's Mail Gauntlets -- 269535
	recipe = AddRecipe(269535, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(85, 85, 110, 127, 145)
	recipe:SetRecipeItem(162404, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(159890, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(142552, 142564)

	-- Honorable Combatant's Mail Gauntlets -- 269536
	recipe = AddRecipe(269536, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(85, 85, 120, 135, 150)
	recipe:SetRecipeItem(162405, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(159890, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(142552, 142564)

	-- Honorable Combatant's Mail Leggings -- 269537
	recipe = AddRecipe(269537, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(85, 85, 95, 100, 105)
	recipe:SetCraftedItem(159891, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddTrainer(122698, 136063, 153817, 154321)

	-- Honorable Combatant's Mail Leggings -- 269538
	recipe = AddRecipe(269538, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(85, 85, 110, 127, 145)
	recipe:SetRecipeItem(162406, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(159891, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(142552, 142564)

	-- Honorable Combatant's Mail Leggings -- 269539
	recipe = AddRecipe(269539, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(85, 85, 120, 135, 150)
	recipe:SetRecipeItem(162407, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(159891, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(142552, 142564)

	-- Honorable Combatant's Mail Waistguard -- 269540
	recipe = AddRecipe(269540, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(85, 85, 95, 100, 105)
	recipe:SetCraftedItem(159892, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddTrainer(122698, 136063, 153817, 154321)

	-- Honorable Combatant's Mail Waistguard -- 269541
	recipe = AddRecipe(269541, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(85, 85, 110, 127, 145)
	recipe:SetRecipeItem(162408, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(159892, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(142552, 142564)

	-- Honorable Combatant's Mail Waistguard -- 269542
	recipe = AddRecipe(269542, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(85, 85, 120, 135, 150)
	recipe:SetRecipeItem(162409, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(159892, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(142552, 142564)

	-- Honorable Combatant's Mail Armguards -- 269543
	recipe = AddRecipe(269543, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(85, 85, 95, 100, 105)
	recipe:SetCraftedItem(159893, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddTrainer(122698, 136063, 153817, 154321)

	-- Honorable Combatant's Mail Armguards -- 269544
	recipe = AddRecipe(269544, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(85, 85, 110, 127, 145)
	recipe:SetRecipeItem(162410, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(159893, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(142552, 142564)

	-- Honorable Combatant's Mail Armguards -- 269545
	recipe = AddRecipe(269545, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(85, 85, 120, 135, 150)
	recipe:SetRecipeItem(162411, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(159893, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(142552, 142564)

	-- Honorable Combatant's Bow -- 269552
	recipe = AddRecipe(269552, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(85, 85, 95, 100, 105)
	recipe:SetCraftedItem(159896, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_BOW")
	recipe:AddTrainer(122698, 136063, 153817, 154321)

	-- Honorable Combatant's Bow -- 269553
	recipe = AddRecipe(269553, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(85, 85, 110, 127, 145)
	recipe:SetRecipeItem(162417, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(159896, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_BOW")
	recipe:AddFilters(F.DPS)
	recipe:AddVendor(142552, 142564)

	-- Honorable Combatant's Bow -- 269554
	recipe = AddRecipe(269554, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(85, 85, 120, 135, 150)
	recipe:SetRecipeItem(162418, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(159896, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_BOW")
	recipe:AddFilters(F.DPS)
	recipe:AddVendor(142552, 142564)

	-- Hardened Tempest Hide -- 272278
	recipe = AddRecipe(272278, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(152542, "BIND_ON_EQUIP")
	recipe:AddTrainer(122698, 136063, 153817, 154321)

	-- Tempest Hide Pouch -- 276256
	recipe = AddRecipe(276256, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 85, 90, 95)
	recipe:SetCraftedItem(165747, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_MATERIALS")
	recipe:AddTrainer(122698, 136063, 153817, 154321)

	-- Amber Rallying Horn -- 278423
	recipe = AddRecipe(278423, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 85, 90, 95)
	recipe:SetCraftedItem(165749, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CREATED_ITEM")
	recipe:AddTrainer(122698, 136063, 153817, 154321)

	-- Sinister Combatant's Bow -- 282277
	recipe = AddRecipe(282277, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(115, 115, 125, 130, 135)
	recipe:SetCraftedItem(164670, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_BOW")
	recipe:AddTrainer(122698, 136063, 153817, 154321)

	-- Sinister Combatant's Bow -- 282278
	recipe = AddRecipe(282278, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(135, 135, 140, 145, 150)
	recipe:SetRecipeItem(165330, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(164670, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_BOW")
	recipe:AddFilters(F.DPS)
	recipe:AddVendor(142552, 142564)

	-- Sinister Combatant's Bow -- 282281
	recipe = AddRecipe(282281, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(135, 135, 145, 147, 150)
	recipe:SetRecipeItem(165331, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(164670, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_BOW")
	recipe:AddFilters(F.DPS)
	recipe:AddVendor(142552, 142564)

	-- Sinister Combatant's Mail Armguards -- 282287
	recipe = AddRecipe(282287, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(115, 115, 125, 130, 135)
	recipe:SetCraftedItem(164667, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddTrainer(122698, 136063, 153817, 154321)

	-- Sinister Combatant's Mail Armguards -- 282288
	recipe = AddRecipe(282288, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(135, 135, 140, 145, 150)
	recipe:SetRecipeItem(165328, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(164667, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(142552, 142564)

	-- Sinister Combatant's Mail Armguards -- 282289
	recipe = AddRecipe(282289, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(135, 135, 145, 147, 150)
	recipe:SetRecipeItem(165329, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(164667, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(142552, 142564)

	-- Sinister Combatant's Mail Waistguard -- 282290
	recipe = AddRecipe(282290, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(115, 115, 125, 130, 135)
	recipe:SetCraftedItem(164666, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddTrainer(122698, 136063, 153817, 154321)

	-- Sinister Combatant's Mail Waistguard -- 282291
	recipe = AddRecipe(282291, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(135, 135, 140, 145, 150)
	recipe:SetRecipeItem(165326, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(164666, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(142552, 142564)

	-- Sinister Combatant's Mail Waistguard -- 282292
	recipe = AddRecipe(282292, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(135, 135, 145, 147, 150)
	recipe:SetRecipeItem(165327, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(164666, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(142552, 142564)

	-- Sinister Combatant's Mail Leggings -- 282302
	recipe = AddRecipe(282302, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(115, 115, 125, 130, 135)
	recipe:SetCraftedItem(164665, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddTrainer(122698, 136063, 153817, 154321)

	-- Sinister Combatant's Mail Leggings -- 282303
	recipe = AddRecipe(282303, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(135, 135, 140, 145, 150)
	recipe:SetRecipeItem(165324, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(164665, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(142552, 142564)

	-- Sinister Combatant's Mail Leggings -- 282305
	recipe = AddRecipe(282305, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(135, 135, 145, 147, 150)
	recipe:SetRecipeItem(165325, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(164665, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(142552, 142564)

	-- Sinister Combatant's Mail Gauntlets -- 282306
	recipe = AddRecipe(282306, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(115, 115, 125, 130, 135)
	recipe:SetCraftedItem(164664, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddTrainer(122698, 136063, 153817, 154321)

	-- Sinister Combatant's Mail Gauntlets -- 282307
	recipe = AddRecipe(282307, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(135, 135, 140, 145, 150)
	recipe:SetRecipeItem(165322, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(164664, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(142552, 142564)

	-- Sinister Combatant's Mail Gauntlets -- 282308
	recipe = AddRecipe(282308, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(135, 135, 145, 147, 150)
	recipe:SetRecipeItem(165323, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(164664, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(142552, 142564)

	-- Sinister Combatant's Mail Treads -- 282309
	recipe = AddRecipe(282309, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(115, 115, 125, 130, 135)
	recipe:SetCraftedItem(164663, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddTrainer(122698, 136063, 153817, 154321)

	-- Sinister Combatant's Mail Treads -- 282310
	recipe = AddRecipe(282310, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(135, 135, 140, 145, 150)
	recipe:SetRecipeItem(165320, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(164663, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(142552, 142564)

	-- Sinister Combatant's Mail Treads -- 282311
	recipe = AddRecipe(282311, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(135, 135, 145, 147, 150)
	recipe:SetRecipeItem(165321, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(164663, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(142552, 142564)

	-- Sinister Combatant's Leather Armguards -- 282312
	recipe = AddRecipe(282312, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(115, 115, 125, 130, 135)
	recipe:SetCraftedItem(164662, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddTrainer(122698, 136063, 153817, 154321)

	-- Sinister Combatant's Leather Armguards -- 282313
	recipe = AddRecipe(282313, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(135, 135, 140, 145, 150)
	recipe:SetRecipeItem(165318, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(164662, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(142552, 142564)

	-- Sinister Combatant's Leather Armguards -- 282314
	recipe = AddRecipe(282314, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(135, 135, 145, 147, 150)
	recipe:SetRecipeItem(165319, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(164662, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(142552, 142564)

	-- Sinister Combatant's Leather Waistguard -- 282318
	recipe = AddRecipe(282318, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(115, 115, 125, 130, 135)
	recipe:SetCraftedItem(164661, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddTrainer(122698, 136063, 153817, 154321)

	-- Sinister Combatant's Leather Waistguard -- 282319
	recipe = AddRecipe(282319, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(135, 135, 140, 145, 150)
	recipe:SetRecipeItem(165316, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(164661, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(142552, 142564)

	-- Sinister Combatant's Leather Waistguard -- 282320
	recipe = AddRecipe(282320, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(135, 135, 145, 147, 150)
	recipe:SetRecipeItem(165317, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(164661, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(142552, 142564)

	-- Sinister Combatant's Leather Leggings -- 282321
	recipe = AddRecipe(282321, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(115, 115, 125, 130, 135)
	recipe:SetCraftedItem(164660, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddTrainer(122698, 136063, 153817, 154321)

	-- Sinister Combatant's Leather Leggings -- 282322
	recipe = AddRecipe(282322, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(135, 135, 140, 145, 150)
	recipe:SetRecipeItem(165314, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(164660, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(142552, 142564)

	-- Sinister Combatant's Leather Leggings -- 282323
	recipe = AddRecipe(282323, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(135, 135, 145, 147, 150)
	recipe:SetRecipeItem(165315, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(164660, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(142552, 142564)

	-- Sinister Combatant's Leather Gauntlets -- 282324
	recipe = AddRecipe(282324, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(115, 115, 125, 130, 135)
	recipe:SetCraftedItem(164659, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddTrainer(122698, 136063, 153817, 154321)

	-- Sinister Combatant's Leather Gauntlets -- 282325
	recipe = AddRecipe(282325, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(135, 135, 140, 145, 150)
	recipe:SetRecipeItem(165312, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(164659, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(142552, 142564)

	-- Sinister Combatant's Leather Gauntlets -- 282326
	recipe = AddRecipe(282326, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(135, 135, 145, 147, 150)
	recipe:SetRecipeItem(165313, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(164659, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(142552, 142564)

	-- Sinister Combatant's Leather Treads -- 282327
	recipe = AddRecipe(282327, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(115, 115, 125, 130, 135)
	recipe:SetCraftedItem(164658, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddTrainer(122698, 136063, 153817, 154321)

	-- Sinister Combatant's Leather Treads -- 282328
	recipe = AddRecipe(282328, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(135, 135, 140, 145, 150)
	recipe:SetRecipeItem(165310, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(164658, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(142552, 142564)

	-- Sinister Combatant's Leather Treads -- 282329
	recipe = AddRecipe(282329, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(135, 135, 145, 147, 150)
	recipe:SetRecipeItem(165311, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(164658, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(142552, 142564)

	-- Enhanced Mistscale Boots -- 285079
	recipe = AddRecipe(285079, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(120, 120, 130, 135, 140)
	recipe:SetCraftedItem(165404, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddTrainer(122698, 136063, 153817, 154321)

	-- Enhanced Mistscale Greaves -- 285080
	recipe = AddRecipe(285080, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(120, 120, 130, 135, 140)
	recipe:SetCraftedItem(165382, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddTrainer(122698, 136063, 153817, 154321)

	-- Enhanced Tempest Boots -- 285083
	recipe = AddRecipe(285083, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(120, 120, 130, 135, 140)
	recipe:SetCraftedItem(165408, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddTrainer(122698, 136063, 153817, 154321)

	-- Enhanced Tempest Leggings -- 285084
	recipe = AddRecipe(285084, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(120, 120, 130, 135, 140)
	recipe:SetCraftedItem(165383, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddTrainer(122698, 136063, 153817, 154321)

	-- Fortified Mistscale Boots -- 285087
	recipe = AddRecipe(285087, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(150, 150, 150, 150, 150)
	recipe:SetCraftedItem(165412, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddDiscovery("DISCOVERY_LW_BFA")

	-- Fortified Mistscale Greaves -- 285088
	recipe = AddRecipe(285088, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(150, 150, 150, 150, 150)
	recipe:SetCraftedItem(165388, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddDiscovery("DISCOVERY_LW_BFA")

	-- Fortified Tempest Boots -- 285091
	recipe = AddRecipe(285091, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(150, 150, 150, 150, 150)
	recipe:SetCraftedItem(165416, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddDiscovery("DISCOVERY_LW_BFA")

	-- Fortified Tempest Leggings -- 285092
	recipe = AddRecipe(285092, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(150, 150, 150, 150, 150)
	recipe:SetCraftedItem(165391, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddDiscovery("DISCOVERY_LW_BFA")

	-- Tempered Mistscale Boots -- 285095
	recipe = AddRecipe(285095, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(150, 150, 150, 150, 150)
	recipe:SetCraftedItem(165420, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddDiscovery("DISCOVERY_LW_BFA")

	-- Tempered Mistscale Greaves -- 285096
	recipe = AddRecipe(285096, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(150, 150, 150, 150, 150)
	recipe:SetCraftedItem(165396, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddDiscovery("DISCOVERY_LW_BFA")

	-- Tempered Tempest Boots -- 285099
	recipe = AddRecipe(285099, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(150, 150, 150, 150, 150)
	recipe:SetCraftedItem(165424, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddDiscovery("DISCOVERY_LW_BFA")

	-- Tempered Tempest Leggings -- 285100
	recipe = AddRecipe(285100, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(150, 150, 150, 150, 150)
	recipe:SetCraftedItem(165424, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddDiscovery("DISCOVERY_LW_BFA")

	-- Scarlet Herring Lure -- 285895
	recipe = AddRecipe(285895, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(85, 85, 95, 100, 105)
	recipe:SetCraftedItem(165699, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CREATED_ITEM")
	recipe:AddTrainer(122698, 136063, 153817, 154321)

	-- Coarse Leather Barding -- 286019
	recipe = AddRecipe(286019, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(85, 85, 95, 100, 105)
	recipe:SetCraftedItem(154166, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CREATED_ITEM")
	recipe:AddTrainer(122698, 136063, 153817, 154321)

	-- Coarse Leather Barding -- 286021
	recipe = AddRecipe(286021, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 115, 125, 135)
	recipe:SetCraftedItem(154166, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CREATED_ITEM")
	recipe:AddWorldDrop(Z.KUL_TIRAS, Z.ZANDALAR)

	-- Sanguinated Reskinning -- 286652
	recipe = AddRecipe(286652, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(162461, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_MATERIALS")
	recipe:AddTrainer(122698, 136063, 153817, 154321)

	-- Aqueous Reskinning -- 287273
	recipe = AddRecipe(287273, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(162460, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_MATERIALS")
	recipe:AddTrainer(122698, 136063, 153817, 154321)

	-- Mallet of Thunderous Skins -- 293076
	recipe = AddRecipe(293076, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(150, 150, 150, 150, 150)
	recipe:SetCraftedItem(164978, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_MATERIALS")
	recipe:AddQuest(55223, 55235)

	-- Drum of Primal Might -- 293135
	recipe = AddRecipe(293135, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(0, 0, 0, 0, 0)

	-- Notorious Combatant's Leather Treads -- 294796
	recipe = AddRecipe(294796, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(150, 150, 160, 165, 170)
	recipe:SetCraftedItem(167951, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddTrainer(153817, 154321)

	-- Notorious Combatant's Leather Treads -- 294797
	recipe = AddRecipe(294797, V.BFA, Q.EPIC)
	recipe:SetSkillLevels(165, 165, 170, 172, 175)
	recipe:SetRecipeItem(169553, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(167951, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddVendor(154652, 154653)

	-- Notorious Combatant's Leather Treads -- 294798
	recipe = AddRecipe(294798, V.BFA, Q.EPIC)
	recipe:SetSkillLevels(175, 175, 175, 175, 175)
	recipe:SetRecipeItem(169554, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(167951, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddVendor(154652, 154653)

	-- Notorious Combatant's Leather Gauntlets -- 294799
	recipe = AddRecipe(294799, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(145, 145, 155, 160, 165)
	recipe:SetCraftedItem(167947, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddTrainer(153817, 154321)

	-- Notorious Combatant's Leather Gauntlets -- 294800
	recipe = AddRecipe(294800, V.BFA, Q.EPIC)
	recipe:SetSkillLevels(160, 160, 170, 172, 175)
	recipe:SetRecipeItem(169555, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(167947, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddVendor(154652, 154653)

	-- Notorious Combatant's Leather Gauntlets -- 294801
	recipe = AddRecipe(294801, V.BFA, Q.EPIC)
	recipe:SetSkillLevels(170, 170, 175, 175, 175)
	recipe:SetRecipeItem(169556, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(167947, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddVendor(154652, 154653)

	-- Notorious Combatant's Leather Leggings -- 294802
	recipe = AddRecipe(294802, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(155, 155, 165, 170, 175)
	recipe:SetCraftedItem(167949, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddTrainer(153817, 154321)

	-- Notorious Combatant's Leather Leggings -- 294803
	recipe = AddRecipe(294803, V.BFA, Q.EPIC)
	recipe:SetSkillLevels(170, 170, 175, 175, 175)
	recipe:SetRecipeItem(169561, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(167949, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddVendor(154652, 154653)

	-- Notorious Combatant's Leather Leggings -- 294804
	recipe = AddRecipe(294804, V.BFA, Q.EPIC)
	recipe:SetSkillLevels(175, 175, 175, 175, 175)
	recipe:SetRecipeItem(169562, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(167949, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddVendor(154652, 154653)

	-- Notorious Combatant's Leather Waistguard -- 294805
	recipe = AddRecipe(294805, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(150, 150, 160, 165, 170)
	recipe:SetCraftedItem(167953, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddTrainer(153817, 154321)

	-- Notorious Combatant's Leather Waistguard -- 294806
	recipe = AddRecipe(294806, V.BFA, Q.EPIC)
	recipe:SetSkillLevels(165, 165, 170, 172, 175)
	recipe:SetRecipeItem(169559, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(167953, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddVendor(154652, 154653)

	-- Notorious Combatant's Leather Waistguard -- 294807
	recipe = AddRecipe(294807, V.BFA, Q.EPIC)
	recipe:SetSkillLevels(175, 175, 175, 175, 175)
	recipe:SetRecipeItem(169560, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(167953, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddVendor(154652, 154653)

	-- Notorious Combatant's Leather Armguards -- 294808
	recipe = AddRecipe(294808, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(145, 145, 155, 160, 165)
	recipe:SetCraftedItem(167945, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddTrainer(153817, 154321)

	-- Notorious Combatant's Leather Armguards -- 294809
	recipe = AddRecipe(294809, V.BFA, Q.EPIC)
	recipe:SetSkillLevels(160, 160, 170, 172, 175)
	recipe:SetRecipeItem(169557, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(167945, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddVendor(154652, 154653)

	-- Notorious Combatant's Leather Armguards -- 294810
	recipe = AddRecipe(294810, V.BFA, Q.EPIC)
	recipe:SetSkillLevels(170, 170, 175, 175, 175)
	recipe:SetRecipeItem(169558, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(167945, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddVendor(154652, 154653)

	-- Notorious Combatant's Mail Treads -- 294811
	recipe = AddRecipe(294811, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(150, 150, 160, 165, 170)
	recipe:SetCraftedItem(167961, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddTrainer(153817, 154321)

	-- Notorious Combatant's Mail Treads -- 294812
	recipe = AddRecipe(294812, V.BFA, Q.EPIC)
	recipe:SetSkillLevels(165, 165, 170, 172, 175)
	recipe:SetRecipeItem(169569, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(167961, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddVendor(154652, 154653)

	-- Notorious Combatant's Mail Treads -- 294813
	recipe = AddRecipe(294813, V.BFA, Q.EPIC)
	recipe:SetSkillLevels(175, 175, 175, 175, 175)
	recipe:SetRecipeItem(169570, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(167961, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddVendor(154652, 154653)

	-- Notorious Combatant's Mail Gauntlets -- 294814
	recipe = AddRecipe(294814, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(145, 145, 155, 160, 165)
	recipe:SetCraftedItem(167957, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddTrainer(153817, 154321)

	-- Notorious Combatant's Mail Gauntlets -- 294815
	recipe = AddRecipe(294815, V.BFA, Q.EPIC)
	recipe:SetSkillLevels(160, 160, 170, 172, 175)
	recipe:SetRecipeItem(169563, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(167957, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddVendor(154652, 154653)

	-- Notorious Combatant's Mail Gauntlets -- 294816
	recipe = AddRecipe(294816, V.BFA, Q.EPIC)
	recipe:SetSkillLevels(170, 170, 175, 175, 175)
	recipe:SetRecipeItem(169564, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(167957, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddVendor(154652, 154653)

	-- Notorious Combatant's Mail Leggings -- 294817
	recipe = AddRecipe(294817, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(155, 155, 165, 170, 175)
	recipe:SetCraftedItem(167959, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddTrainer(153817, 154321)

	-- Notorious Combatant's Mail Leggings -- 294818
	recipe = AddRecipe(294818, V.BFA, Q.EPIC)
	recipe:SetSkillLevels(170, 170, 175, 175, 175)
	recipe:SetRecipeItem(169571, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(167959, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddVendor(154652, 154653)

	-- Notorious Combatant's Mail Leggings -- 294819
	recipe = AddRecipe(294819, V.BFA, Q.EPIC)
	recipe:SetSkillLevels(175, 175, 175, 175, 175)
	recipe:SetRecipeItem(169572, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(167959, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddVendor(154652, 154653)

	-- Notorious Combatant's Mail Waistguard -- 294820
	recipe = AddRecipe(294820, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(150, 150, 160, 165, 170)
	recipe:SetCraftedItem(167963, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddTrainer(153817, 154321)

	-- Notorious Combatant's Mail Waistguard -- 294821
	recipe = AddRecipe(294821, V.BFA, Q.EPIC)
	recipe:SetSkillLevels(160, 160, 170, 172, 175)
	recipe:SetRecipeItem(169567, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(167963, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddVendor(154652, 154653)

	-- Notorious Combatant's Mail Waistguard -- 294822
	recipe = AddRecipe(294822, V.BFA, Q.EPIC)
	recipe:SetSkillLevels(170, 170, 175, 175, 175)
	recipe:SetRecipeItem(169568, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(167963, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddVendor(154652, 154653)

	-- Notorious Combatant's Mail Armguards -- 294823
	recipe = AddRecipe(294823, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(145, 145, 155, 160, 165)
	recipe:SetCraftedItem(167955, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddTrainer(153817, 154321)

	-- Notorious Combatant's Mail Armguards -- 294824
	recipe = AddRecipe(294824, V.BFA, Q.EPIC)
	recipe:SetSkillLevels(160, 160, 170, 172, 175)
	recipe:SetRecipeItem(169565, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(167955, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddVendor(154652, 154653)

	-- Notorious Combatant's Mail Armguards -- 294825
	recipe = AddRecipe(294825, V.BFA, Q.EPIC)
	recipe:SetSkillLevels(170, 170, 175, 175, 175)
	recipe:SetRecipeItem(169566, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(167955, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddVendor(154652, 154653)

	-- Notorious Combatant's Bow -- 294826
	recipe = AddRecipe(294826, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(145, 145, 155, 160, 165)
	recipe:SetCraftedItem(167935, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_BOW")
	recipe:AddTrainer(153817, 154321)

	-- Notorious Combatant's Bow -- 294827
	recipe = AddRecipe(294827, V.BFA, Q.EPIC)
	recipe:SetSkillLevels(160, 160, 170, 172, 175)
	recipe:SetRecipeItem(169573, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(167935, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_BOW")
	recipe:AddVendor(154652, 154653)

	-- Notorious Combatant's Bow -- 294828
	recipe = AddRecipe(294828, V.BFA, Q.EPIC)
	recipe:SetSkillLevels(175, 175, 175, 175, 175)
	recipe:SetRecipeItem(169574, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(167935, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_BOW")
	recipe:AddVendor(154652, 154653)

	-- Dredged Leather Boots -- 299019
	recipe = AddRecipe(299019, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(165, 165, 175, 180, 185)
	recipe:SetCraftedItem(168704, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddTrainer(153817, 154321)

	-- Reinforced Dredged Boots -- 299020
	recipe = AddRecipe(299020, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(165, 165, 175, 175, 180)
	recipe:SetRecipeItem(168773, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(168705, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddDiscovery("DISCOVERY_LW_BFA")

	-- Banded Dredged Boots -- 299021
	recipe = AddRecipe(299021, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(165, 165, 175, 175, 180)
	recipe:SetRecipeItem(168774, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(168706, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddDiscovery("DISCOVERY_LW_BFA")

	-- Dredged Leather Leggings -- 299022
	recipe = AddRecipe(299022, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(170, 170, 180, 185, 190)
	recipe:SetCraftedItem(168707, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddTrainer(153817, 154321)

	-- Reinforced Dredged Leggings -- 299023
	recipe = AddRecipe(299023, V.BFA, Q.EPIC)
	recipe:SetSkillLevels(170, 170, 180, 185, 190)
	recipe:SetRecipeItem(168775, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(168708, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddDiscovery("DISCOVERY_LW_BFA")

	-- Banded Dredged Leggings -- 299024
	recipe = AddRecipe(299024, V.BFA, Q.EPIC)
	recipe:SetSkillLevels(170, 170, 180, 185, 190)
	recipe:SetRecipeItem(168776, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(168709, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddDiscovery("DISCOVERY_LW_BFA")

	-- Cragscale Boots -- 299025
	recipe = AddRecipe(299025, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(165, 165, 175, 180, 185)
	recipe:SetCraftedItem(168716, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddTrainer(153817, 154321)

	-- Reinforced Cragscale Boots -- 299026
	recipe = AddRecipe(299026, V.BFA, Q.EPIC)
	recipe:SetSkillLevels(165, 165, 175, 175, 180)
	recipe:SetRecipeItem(168777, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(168717, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddDiscovery("DISCOVERY_LW_BFA")

	-- Banded Cragscale Boots -- 299027
	recipe = AddRecipe(299027, V.BFA, Q.EPIC)
	recipe:SetSkillLevels(165, 165, 175, 175, 180)
	recipe:SetRecipeItem(168778, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(168718, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddDiscovery("DISCOVERY_LW_BFA")

	-- Cragscale Greaves -- 299028
	recipe = AddRecipe(299028, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(170, 170, 180, 185, 190)
	recipe:SetCraftedItem(168719, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddTrainer(153817, 154321)

	-- Reinforced Cragscale Greaves -- 299029
	recipe = AddRecipe(299029, V.BFA, Q.EPIC)
	recipe:SetSkillLevels(170, 170, 180, 185, 190)
	recipe:SetRecipeItem(168779, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(168720, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddDiscovery("DISCOVERY_LW_BFA")

	-- Banded Cragscale Greaves -- 299030
	recipe = AddRecipe(299030, V.BFA, Q.EPIC)
	recipe:SetSkillLevels(170, 170, 180, 185, 190)
	recipe:SetRecipeItem(168780, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(168721, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddDiscovery("DISCOVERY_LW_BFA")

	-- Dredged Leather Bladder -- 301405
	recipe = AddRecipe(301405, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(150, 150, 160, 165, 170)
	recipe:SetCraftedItem(169445, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CREATED_ITEM")
	recipe:AddTrainer(153817, 154321)

	-- Comfortable Rider's Barding -- 301411
	recipe = AddRecipe(301411, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(150, 150, 160, 165, 170)
	recipe:SetCraftedItem(168419, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CREATED_ITEM")
	recipe:AddTrainer(153817, 154321)

	-- Uncanny Combatant's Leather Treads -- 304412
	recipe = AddRecipe(304412, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(170, 170, 180, 185, 190)
	recipe:SetCraftedItem(170345, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddTrainer(122698, 136063)

	-- Uncanny Combatant's Leather Treads -- 304413
	recipe = AddRecipe(304413, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 165, 170, 175)
	recipe:SetRecipeItem(170412, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(170345, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(142552, 142564, 161565)

	-- Uncanny Combatant's Leather Treads -- 304414
	recipe = AddRecipe(304414, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 165, 170, 175)
	recipe:SetRecipeItem(170413, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(170345, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(142552, 142564, 161565)

	-- Uncanny Combatant's Leather Gauntlets -- 304415
	recipe = AddRecipe(304415, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(170, 170, 180, 185, 190)
	recipe:SetCraftedItem(170342, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddTrainer(122698, 136063)

	-- Uncanny Combatant's Leather Gauntlets -- 304416
	recipe = AddRecipe(304416, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 165, 170, 175)
	recipe:SetRecipeItem(170414, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(170342, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(142552, 142564, 161565)

	-- Uncanny Combatant's Leather Gauntlets -- 304417
	recipe = AddRecipe(304417, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 165, 170, 175)
	recipe:SetRecipeItem(170415, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(170345, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(142552, 142564, 161565)

	-- Uncanny Combatant's Leather Leggings -- 304418
	recipe = AddRecipe(304418, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(170, 170, 180, 185, 190)
	recipe:SetCraftedItem(170344, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddTrainer(122698, 136063)

	-- Uncanny Combatant's Leather Leggings -- 304419
	recipe = AddRecipe(304419, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 165, 170, 175)
	recipe:SetRecipeItem(170416, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(170344, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(142552, 142564, 161565)

	-- Uncanny Combatant's Leather Leggings -- 304420
	recipe = AddRecipe(304420, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 165, 170, 175)
	recipe:SetRecipeItem(170417, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(170344, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(142552, 142564, 161565)

	-- Uncanny Combatant's Leather Waistguard -- 304421
	recipe = AddRecipe(304421, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(170, 170, 180, 185, 190)
	recipe:SetCraftedItem(170346, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddTrainer(122698, 136063)

	-- Uncanny Combatant's Leather Waistguard -- 304422
	recipe = AddRecipe(304422, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 165, 170, 175)
	recipe:SetRecipeItem(170418, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(170346, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(142552, 142564, 161565)

	-- Uncanny Combatant's Leather Waistguard -- 304423
	recipe = AddRecipe(304423, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 165, 170, 175)
	recipe:SetRecipeItem(170419, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(170346, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(142552, 142564, 161565)

	-- Uncanny Combatant's Leather Armguards -- 304424
	recipe = AddRecipe(304424, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(170, 170, 180, 185, 190)
	recipe:SetCraftedItem(170343, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddTrainer(122698, 136063)

	-- Uncanny Combatant's Leather Armguards -- 304425
	recipe = AddRecipe(304425, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 165, 170, 175)
	recipe:SetRecipeItem(170420, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(170343, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(142552, 142564, 161565)

	-- Uncanny Combatant's Leather Armguards -- 304426
	recipe = AddRecipe(304426, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 165, 170, 175)
	recipe:SetRecipeItem(170421, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(170343, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(142552, 142564, 161565)

	-- Uncanny Combatant's Mail Treads -- 304427
	recipe = AddRecipe(304427, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(170, 170, 180, 185, 190)
	recipe:SetCraftedItem(170355, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddTrainer(122698, 136063)

	-- Uncanny Combatant's Mail Treads -- 304428
	recipe = AddRecipe(304428, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 165, 170, 175)
	recipe:SetRecipeItem(170422, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(170355, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(142552, 142564, 161565)

	-- Uncanny Combatant's Mail Treads -- 304429
	recipe = AddRecipe(304429, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 165, 170, 175)
	recipe:SetRecipeItem(170423, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(170355, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(142552, 142564, 161565)

	-- Uncanny Combatant's Mail Gauntlets -- 304430
	recipe = AddRecipe(304430, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(170, 170, 180, 185, 190)
	recipe:SetCraftedItem(170353, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddTrainer(122698, 136063)

	-- Uncanny Combatant's Mail Gauntlets -- 304431
	recipe = AddRecipe(304431, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 165, 170, 175)
	recipe:SetRecipeItem(170424, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(170353, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(142552, 142564, 161565)

	-- Uncanny Combatant's Mail Gauntlets -- 304432
	recipe = AddRecipe(304432, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 165, 170, 175)
	recipe:SetRecipeItem(170425, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(170353, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(142552, 142564, 161565)

	-- Uncanny Combatant's Mail Leggings -- 304433
	recipe = AddRecipe(304433, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(170, 170, 180, 185, 190)
	recipe:SetCraftedItem(170354, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddTrainer(122698, 136063)

	-- Uncanny Combatant's Mail Leggings -- 304434
	recipe = AddRecipe(304434, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 165, 170, 175)
	recipe:SetRecipeItem(170426, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(170354, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(142552, 142564, 161565)

	-- Uncanny Combatant's Mail Leggings -- 304435
	recipe = AddRecipe(304435, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 165, 170, 175)
	recipe:SetRecipeItem(170427, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(170354, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(142552, 142564, 161565)

	-- Uncanny Combatant's Mail Waistguard -- 304436
	recipe = AddRecipe(304436, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(170, 170, 180, 185, 190)
	recipe:SetCraftedItem(170356, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddTrainer(122698, 136063)

	-- Uncanny Combatant's Mail Waistguard -- 304437
	recipe = AddRecipe(304437, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 165, 170, 175)
	recipe:SetRecipeItem(170428, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(170356, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(142552, 142564, 161565)

	-- Uncanny Combatant's Mail Waistguard -- 304438
	recipe = AddRecipe(304438, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 165, 170, 175)
	recipe:SetRecipeItem(170429, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(170356, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(142552, 142564, 161565)

	-- Uncanny Combatant's Mail Armguards -- 304439
	recipe = AddRecipe(304439, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(170, 170, 180, 185, 190)
	recipe:SetCraftedItem(170352, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddTrainer(122698, 136063)

	-- Uncanny Combatant's Mail Armguards -- 304440
	recipe = AddRecipe(304440, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 165, 170, 175)
	recipe:SetRecipeItem(170430, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(170352, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(142552, 142564, 161565)

	-- Uncanny Combatant's Mail Armguards -- 304441
	recipe = AddRecipe(304441, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 165, 170, 175)
	recipe:SetRecipeItem(170431, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(170352, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddFilters(F.CASTER, F.DPS, F.HEALER)
	recipe:AddVendor(142552, 142564, 161565)

	-- Uncanny Combatant's Bow -- 304442
	recipe = AddRecipe(304442, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(170, 170, 180, 185, 190)
	recipe:SetCraftedItem(170362, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_BOW")
	recipe:AddTrainer(122698, 136063)

	-- Uncanny Combatant's Bow -- 304443
	recipe = AddRecipe(304443, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 165, 170, 175)
	recipe:SetRecipeItem(170586, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(170362, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_BOW")
	recipe:AddFilters(F.DPS)
	recipe:AddVendor(142552, 142564, 161565)

	-- Uncanny Combatant's Bow -- 304444
	recipe = AddRecipe(304444, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 165, 170, 175)
	recipe:SetRecipeItem(170587, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(170362, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_BOW")
	recipe:AddFilters(F.DPS)
	recipe:AddVendor(142552, 142564, 161565)

	-- Maddening Dredged Leather Boots -- 305795
	recipe = AddRecipe(305795, V.BFA, Q.EPIC)
	recipe:SetSkillLevels(170, 170, 175, 175, 175)
	recipe:SetRecipeItem(171127, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(170433, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddDiscovery("DISCOVERY_LW_BFA")

	-- Unsettling Dredged Leather Boots -- 305796
	recipe = AddRecipe(305796, V.BFA, Q.EPIC)
	recipe:SetSkillLevels(170, 170, 175, 175, 175)
	recipe:SetRecipeItem(174366, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(170432, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddMobDrop(153910, 162245)

	-- Maddening Dredged Leather Leggings -- 305798
	recipe = AddRecipe(305798, V.BFA, Q.EPIC)
	recipe:SetSkillLevels(170, 170, 175, 175, 175)
	recipe:SetRecipeItem(171125, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(170436, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddDiscovery("DISCOVERY_LW_BFA")

	-- Eldritch Dredged Leather Leggings -- 305799
	recipe = AddRecipe(305799, V.BFA, Q.EPIC)
	recipe:SetSkillLevels(170, 170, 175, 175, 175)
	recipe:SetRecipeItem(171124, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(170437, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddDiscovery("DISCOVERY_LW_BFA")

	-- Unsettling Cragscale Greaves -- 305800
	recipe = AddRecipe(305800, V.BFA, Q.RARE)
	recipe:SetSkillLevels(165, 165, 175, 175, 175)
	recipe:SetRecipeItem(174369, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(170441, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddMobDrop(153910, 162245)

	-- Eldritch Cragscale Boots -- 305801
	recipe = AddRecipe(305801, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(175, 175, 175, 175, 175)
	recipe:SetRecipeItem(171122, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(170440, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddDiscovery("DISCOVERY_LW_BFA")

	-- Maddening Cragscale Boots -- 305802
	recipe = AddRecipe(305802, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(170, 170, 175, 175, 175)
	recipe:SetRecipeItem(171123, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(170439, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddDiscovery("DISCOVERY_LW_BFA")

	-- Unsettling Cragscale Boots -- 305803
	recipe = AddRecipe(305803, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(165, 165, 175, 175, 175)
	recipe:SetRecipeItem(174368, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(170438, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddMobDrop(153910, 162245)

	-- Unsettling Dredged Leather Leggings -- 305804
	recipe = AddRecipe(305804, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(165, 165, 175, 175, 175)
	recipe:SetRecipeItem(174367, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(170435, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddMobDrop(153910, 162245)

	-- Eldritch Dredged Leather Boots -- 305805
	recipe = AddRecipe(305805, V.BFA, Q.EPIC)
	recipe:SetSkillLevels(175, 175, 175, 175, 175)
	recipe:SetRecipeItem(171126, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(170434, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddDiscovery("DISCOVERY_LW_BFA")

	-- Maddening Cragscale Greaves -- 305806
	recipe = AddRecipe(305806, V.BFA, Q.EPIC)
	recipe:SetSkillLevels(170, 170, 175, 175, 175)
	recipe:SetRecipeItem(171128, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(170442, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddDiscovery("DISCOVERY_LW_BFA")

	-- Eldritch Cragscale Greaves -- 305807
	recipe = AddRecipe(305807, V.BFA, Q.EPIC)
	recipe:SetSkillLevels(175, 175, 175, 175, 175)
	recipe:SetRecipeItem(171118, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(170443, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddDiscovery("DISCOVERY_LW_BFA")

	-- Void Focus -- 307176
	recipe = AddRecipe(307176, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 165, 170, 175)
	recipe:SetRecipeItem(171312, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(171320, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_CREATED_ITEM")
	recipe:AddMobDrop(153910, 162245)

	-- ----------------------------------------------------------------------------
	-- Shadowlands.
	-- ----------------------------------------------------------------------------
	-- Heavy Callous Hide -- 308897
	recipe = AddRecipe(308897, V.SHA, Q.RARE)
	recipe:SetSkillLevels(80, 80, 90, 95, 100)
	recipe:SetRecipeItem(183839, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(172097, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_MATERIALS")
	recipe:AddRepVendor(FAC.COURT_OF_HARVESTERS, REP.REVERED, 156822)
	recipe:AddTrainer(156669)

	-- Heavy Desolate Leather -- 308899
	recipe = AddRecipe(308899, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(70, 70, 80, 85, 90)
	recipe:SetCraftedItem(172096, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_MATERIALS")
	recipe:AddTrainer(156669)

	-- Drums of Deathly Ferocity -- 309173
	recipe = AddRecipe(309173, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 110, 115, 120)
	recipe:SetCraftedItem(172233, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CREATED_ITEM")
	recipe:AddTrainer(156669)

	-- Desolate Leather Treads -- 309174
	recipe = AddRecipe(309174, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(10, 10, 20, 25, 30)
	recipe:SetCraftedItem(172235, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddCustom("DEFAULT_RECIPE")

	-- Desolate Leather Vest -- 309175
	recipe = AddRecipe(309175, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(172234, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddTrainer(156669)

	-- Desolate Leather Gauntlets -- 309176
	recipe = AddRecipe(309176, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(10, 10, 20, 25, 30)
	recipe:SetCraftedItem(172236, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddTrainer(156669)

	-- Desolate Leather Helm -- 309177
	recipe = AddRecipe(309177, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(20, 20, 30, 35, 40)
	recipe:SetCraftedItem(172237, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HEAD")
	recipe:AddTrainer(156669)

	-- Desolate Leather Leggings -- 309178
	recipe = AddRecipe(309178, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(30, 30, 40, 45, 50)
	recipe:SetCraftedItem(172238, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddTrainer(156669)

	-- Desolate Leather Pauldrons -- 309179
	recipe = AddRecipe(309179, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(35, 35, 45, 50, 55)
	recipe:SetCraftedItem(172239, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_SHOULDER")
	recipe:AddTrainer(156669)

	-- Desolate Leather Waistguard -- 309180
	recipe = AddRecipe(309180, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(5, 5, 15, 20, 25)
	recipe:SetCraftedItem(172240, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddTrainer(156669)

	-- Desolate Leather Armguards -- 309181
	recipe = AddRecipe(309181, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(5, 5, 15, 20, 25)
	recipe:SetCraftedItem(172241, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddCustom("DEFAULT_RECIPE")

	-- Desolate Scale Treads -- 309182
	recipe = AddRecipe(309182, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(10, 10, 20, 25, 30)
	recipe:SetCraftedItem(172243, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddCustom("DEFAULT_RECIPE")

	-- Desolate Scale Vest -- 309183
	recipe = AddRecipe(309183, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(172242, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddTrainer(156669)

	-- Desolate Scale Gauntlets -- 309184
	recipe = AddRecipe(309184, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(10, 10, 20, 25, 30)
	recipe:SetCraftedItem(172244, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddTrainer(156669)

	-- Desolate Scale Helm -- 309185
	recipe = AddRecipe(309185, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(20, 20, 30, 35, 40)
	recipe:SetCraftedItem(172245, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HEAD")
	recipe:AddTrainer(156669)

	-- Desolate Scale Greaves -- 309186
	recipe = AddRecipe(309186, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(30, 30, 40, 45, 50)
	recipe:SetCraftedItem(172246, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddTrainer(156669)

	-- Desolate Scale Pauldrons -- 309187
	recipe = AddRecipe(309187, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(35, 35, 45, 50, 55)
	recipe:SetCraftedItem(172247, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_SHOULDER")
	recipe:AddTrainer(156669)

	-- Desolate Scale Waistguard -- 309188
	recipe = AddRecipe(309188, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(5, 5, 15, 20, 25)
	recipe:SetCraftedItem(172248, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddTrainer(156669)

	-- Desolate Scale Armguards -- 309189
	recipe = AddRecipe(309189, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(5, 5, 15, 20, 25)
	recipe:SetCraftedItem(172249, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddCustom("DEFAULT_RECIPE")

	-- Bone Bound Knuckles -- 309190
	recipe = AddRecipe(309190, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(15, 15, 25, 30, 35)
	recipe:SetCraftedItem(172349, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FIST")
	recipe:AddTrainer(156669)

	-- Desolate Leather Cestus -- 309191
	recipe = AddRecipe(309191, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(15, 15, 25, 30, 35)
	recipe:SetCraftedItem(172348, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FIST")
	recipe:AddTrainer(156669)

	-- Composite Bow -- 309192
	recipe = AddRecipe(309192, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(172350, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_BOW")
	recipe:AddTrainer(156669)

	-- Composite Crossbow -- 309193
	recipe = AddRecipe(309193, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(45, 45, 55, 60, 65)
	recipe:SetCraftedItem(172351, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_BOW")
	recipe:AddTrainer(156669)

	-- Umbrahide Treads -- 309198
	recipe = AddRecipe(309198, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 110, 115, 120)
	recipe:SetCraftedItem(172315, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddTrainer(156669)

	-- Umbrahide Vest -- 309199
	recipe = AddRecipe(309199, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 110, 115, 120)
	recipe:SetCraftedItem(172314, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddTrainer(156669)

	-- Umbrahide Gauntlets -- 309200
	recipe = AddRecipe(309200, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 110, 115, 120)
	recipe:SetCraftedItem(172316, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddTrainer(156669)

	-- Umbrahide Helm -- 309201
	recipe = AddRecipe(309201, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 110, 115, 120)
	recipe:SetCraftedItem(172317, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HEAD")
	recipe:AddTrainer(156669)

	-- Umbrahide Leggings -- 309202
	recipe = AddRecipe(309202, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 110, 115, 120)
	recipe:SetCraftedItem(172318, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddTrainer(156669)

	-- Umbrahide Pauldrons -- 309203
	recipe = AddRecipe(309203, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 110, 115, 120)
	recipe:SetCraftedItem(172319, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddTrainer(156669)

	-- Umbrahide Waistguard -- 309204
	recipe = AddRecipe(309204, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 110, 115, 120)
	recipe:SetCraftedItem(172320, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddTrainer(156669)

	-- Umbrahide Armguards -- 309205
	recipe = AddRecipe(309205, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 110, 115, 120)
	recipe:SetCraftedItem(172321, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddTrainer(156669)

	-- Boneshatter Treads -- 309206
	recipe = AddRecipe(309206, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 110, 115, 120)
	recipe:SetCraftedItem(172323, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddTrainer(156669)

	-- Boneshatter Vest -- 309207
	recipe = AddRecipe(309207, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 110, 115, 120)
	recipe:SetCraftedItem(172322, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddTrainer(156669)

	-- Boneshatter Gauntlets -- 309208
	recipe = AddRecipe(309208, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 110, 115, 120)
	recipe:SetCraftedItem(172324, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddTrainer(156669)

	-- Boneshatter Helm -- 309209
	recipe = AddRecipe(309209, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 110, 115, 120)
	recipe:SetCraftedItem(172325, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HEAD")
	recipe:AddTrainer(156669)

	-- Boneshatter Greaves -- 309210
	recipe = AddRecipe(309210, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 110, 115, 120)
	recipe:SetCraftedItem(172326, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddTrainer(156669)

	-- Boneshatter Pauldrons -- 309211
	recipe = AddRecipe(309211, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 110, 115, 120)
	recipe:SetCraftedItem(172327, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_SHOULDER")
	recipe:AddTrainer(156669)

	-- Boneshatter Waistguard -- 309212
	recipe = AddRecipe(309212, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 110, 115, 120)
	recipe:SetCraftedItem(172328, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddTrainer(156669)

	-- Boneshatter Armguards -- 309213
	recipe = AddRecipe(309213, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 110, 115, 120)
	recipe:SetCraftedItem(172329, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddTrainer(156669)

	-- Shadebound Treads -- 309230
	recipe = AddRecipe(309230, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(55, 55, 65, 70, 75)
	recipe:SetCraftedItem(172251, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddTrainer(156669)

	-- Shadebound Vest -- 309231
	recipe = AddRecipe(309231, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(80, 80, 90, 95, 100)
	recipe:SetCraftedItem(172250, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddTrainer(156669)

	-- Shadebound Gauntlets -- 309232
	recipe = AddRecipe(309232, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(65, 65, 75, 80, 85)
	recipe:SetCraftedItem(172252, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddTrainer(156669)

	-- Shadebound Helm -- 309233
	recipe = AddRecipe(309233, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 85, 90, 95)
	recipe:SetCraftedItem(172253, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HEAD")
	recipe:AddTrainer(156669)

	-- Shadebound Leggings -- 309234
	recipe = AddRecipe(309234, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(90, 90, 100, 105, 110)
	recipe:SetCraftedItem(172254, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddTrainer(156669)

	-- Shadebound Pauldrons -- 309235
	recipe = AddRecipe(309235, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(95, 95, 105, 110, 115)
	recipe:SetCraftedItem(172255, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_SHOULDER")
	recipe:AddTrainer(156669)

	-- Shadebound Waistguard -- 309236
	recipe = AddRecipe(309236, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(60, 60, 70, 75, 80)
	recipe:SetCraftedItem(172256, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddTrainer(156669)

	-- Shadebound Armguards -- 309237
	recipe = AddRecipe(309237, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(172257, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddTrainer(156669)

	-- Shadowscale Treads -- 309238
	recipe = AddRecipe(309238, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(55, 55, 65, 70, 75)
	recipe:SetCraftedItem(172259, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddTrainer(156669)

	-- Shadowscale Vest -- 309239
	recipe = AddRecipe(309239, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(80, 80, 90, 95, 100)
	recipe:SetCraftedItem(172258, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddTrainer(156669)

	-- Shadowscale Gauntlets -- 309240
	recipe = AddRecipe(309240, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(65, 65, 75, 80, 85)
	recipe:SetCraftedItem(172260, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddTrainer(156669)

	-- Shadowscale Helm -- 309241
	recipe = AddRecipe(309241, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 85, 90, 95)
	recipe:SetCraftedItem(172261, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HEAD")
	recipe:AddTrainer(156669)

	-- Shadowscale Leggings -- 309242
	recipe = AddRecipe(309242, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(90, 90, 100, 105, 110)
	recipe:SetCraftedItem(172262, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddTrainer(156669)

	-- Shadowscale Pauldrons -- 309243
	recipe = AddRecipe(309243, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(95, 95, 105, 110, 115)
	recipe:SetCraftedItem(172263, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_SHOULDER")
	recipe:AddTrainer(156669)

	-- Shadowscale Waistguard -- 309244
	recipe = AddRecipe(309244, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(60, 60, 70, 75, 80)
	recipe:SetCraftedItem(172264, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddTrainer(156669)

	-- Shadowscale Armguards -- 309245
	recipe = AddRecipe(309245, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(172265, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddTrainer(156669)

	-- Desolate Armor Kit -- 324087
	recipe = AddRecipe(324087, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(10, 10, 20, 25, 30)
	recipe:SetCraftedItem(172346, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_ITEM_ENHANCEMENT")
	recipe:AddCustom("DEFAULT_RECIPE")

	-- Heavy Desolate Armor Kit -- 324088
	recipe = AddRecipe(324088, V.SHA, Q.UNCOMMON)
	recipe:SetSkillLevels(50, 50, 60, 62, 65)
	recipe:SetRecipeItem(183100, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(172264, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_ITEM_ENHANCEMENT")
	recipe:AddRepVendor(FAC.THE_WILD_HUNT, REP.HONORED, 158556, 176065)

	-- Comfortable Rider's Barding -- 324735
	recipe = AddRecipe(324735, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(80, 80, 90, 95, 100)
	recipe:SetCraftedItem(168419, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CREATED_ITEM")
	recipe:AddTrainer(156669)

	-- Relic of the Past I -- 330180
	recipe = AddRecipe(330180, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(180055, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_MATERIALS")
	recipe:AddTrainer(3007, 3365, 4588, 5127, 5564, 16688, 85920, 86032, 93522, 93523, 98931)

	-- Relic of the Past II -- 330181
	recipe = AddRecipe(330181, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(180057, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_MATERIALS")
	recipe:AddTrainer(3007, 3365, 4588, 5127, 5564, 16688, 85920, 86032, 93522, 93523, 98931)

	-- Relic of the Past III -- 330183
	recipe = AddRecipe(330183, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(180058, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_MATERIALS")
	recipe:AddTrainer(3007, 3365, 4588, 5127, 5564, 16688, 85920, 86032, 93522, 93523, 98931)

	-- Relic of the Past IV -- 330184
	recipe = AddRecipe(330184, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(180059, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_MATERIALS")
	recipe:AddTrainer(3007, 3365, 4588, 5127, 5564, 16688, 85920, 86032, 93522, 93523, 98931)

	-- Relic of the Past V -- 330185
	recipe = AddRecipe(330185, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(180060, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_MATERIALS")
	recipe:AddTrainer(3007, 3365, 4588, 5127, 5564, 16688, 85920, 86032, 93522, 93523, 98931)

	-- Relic of the Past I -- 330186
	recipe = AddRecipe(330186, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(180055, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_MATERIALS")
	recipe:AddTrainer(19187, 33612, 33635, 33681)

	-- Relic of the Past II -- 330187
	recipe = AddRecipe(330187, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(180057, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_MATERIALS")
	recipe:AddTrainer(19187, 33612, 33635, 33681)

	-- Relic of the Past III -- 330188
	recipe = AddRecipe(330188, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(180058, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_MATERIALS")
	recipe:AddTrainer(19187, 33612, 33635, 33681)

	-- Relic of the Past IV -- 330189
	recipe = AddRecipe(330189, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(180059, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_MATERIALS")
	recipe:AddTrainer(19187, 33612, 33635, 33681)

	-- Relic of the Past V -- 330190
	recipe = AddRecipe(330190, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(180060, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_MATERIALS")
	recipe:AddTrainer(19187, 33612, 33635, 33681)

	-- Relic of the Past I -- 330191
	recipe = AddRecipe(330191, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(15, 15, 25, 30, 35)
	recipe:SetCraftedItem(180055, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_MATERIALS")
	recipe:AddTrainer(28700, 29507, 29508, 29509)

	-- Relic of the Past II -- 330192
	recipe = AddRecipe(330192, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(30, 30, 40, 45, 50)
	recipe:SetCraftedItem(180057, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_MATERIALS")
	recipe:AddTrainer(28700, 29507, 29508, 29509)

	-- Relic of the Past III -- 330193
	recipe = AddRecipe(330193, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(45, 45, 55, 60, 65)
	recipe:SetCraftedItem(180058, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_MATERIALS")
	recipe:AddTrainer(28700, 29507, 29508, 29509)

	-- Relic of the Past IV -- 330194
	recipe = AddRecipe(330194, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(60, 60, 70, 75, 80)
	recipe:SetCraftedItem(180059, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_MATERIALS")
	recipe:AddTrainer(28700, 29507, 29508, 29509)

	-- Relic of the Past V -- 330195
	recipe = AddRecipe(330195, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 85, 90, 95)
	recipe:SetCraftedItem(180060, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_MATERIALS")
	recipe:AddTrainer(28700, 29507, 29508, 29509)

	-- Relic of the Past I -- 330196
	recipe = AddRecipe(330196, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(180055, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_MATERIALS")
	recipe:AddTrainer(3007, 3365, 4588, 5127, 5564, 16688)

	-- Relic of the Past II -- 330197
	recipe = AddRecipe(330197, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(180057, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_MATERIALS")
	recipe:AddTrainer(3007, 3365, 4588, 5127, 5564, 16688)

	-- Relic of the Past III -- 330198
	recipe = AddRecipe(330198, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(180058, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_MATERIALS")
	recipe:AddTrainer(3007, 3365, 4588, 5127, 5564, 16688)

	-- Relic of the Past IV -- 330199
	recipe = AddRecipe(330199, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(180059, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_MATERIALS")
	recipe:AddTrainer(3007, 3365, 4588, 5127, 5564, 16688)

	-- Relic of the Past V -- 330200
	recipe = AddRecipe(330200, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(180060, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_MATERIALS")
	recipe:AddTrainer(3007, 3365, 4588, 5127, 5564, 16688)

	-- Relic of the Past I -- 330201
	recipe = AddRecipe(330201, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(180055, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_MATERIALS")
	recipe:AddTrainer(65121)

	-- Relic of the Past II -- 330202
	recipe = AddRecipe(330202, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(180057, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_MATERIALS")
	recipe:AddTrainer(65121)

	-- Relic of the Past III -- 330203
	recipe = AddRecipe(330203, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(180058, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_MATERIALS")
	recipe:AddTrainer(65121)

	-- Relic of the Past IV -- 330204
	recipe = AddRecipe(330204, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(180059, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_MATERIALS")
	recipe:AddTrainer(65121)

	-- Relic of the Past V -- 330205
	recipe = AddRecipe(330205, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(180060, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_MATERIALS")
	recipe:AddTrainer(65121)

	-- Relic of the Past I -- 330206
	recipe = AddRecipe(330206, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(180055, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_MATERIALS")
	recipe:AddCustom("DRAENOR_DEFAULT")

	-- Relic of the Past II -- 330207
	recipe = AddRecipe(330207, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(180057, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_MATERIALS")
	recipe:AddCustom("DRAENOR_DEFAULT")

	-- Relic of the Past III -- 330208
	recipe = AddRecipe(330208, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(180058, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_MATERIALS")
	recipe:AddCustom("DRAENOR_DEFAULT")

	-- Relic of the Past IV -- 330209
	recipe = AddRecipe(330209, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(180059, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_MATERIALS")
	recipe:AddCustom("DRAENOR_DEFAULT")

	-- Relic of the Past V -- 330210
	recipe = AddRecipe(330210, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(180060, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_MATERIALS")
	recipe:AddCustom("DRAENOR_DEFAULT")

	-- Relic of the Past I -- 330211
	recipe = AddRecipe(330211, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(180055, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_MATERIALS")
	recipe:AddCustom("DEFAULT_RECIPE")

	-- Relic of the Past II -- 330212
	recipe = AddRecipe(330212, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(180057, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_MATERIALS")
	recipe:AddCustom("DEFAULT_RECIPE")

	-- Relic of the Past III -- 330213
	recipe = AddRecipe(330213, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(180058, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_MATERIALS")
	recipe:AddCustom("DEFAULT_RECIPE")

	-- Relic of the Past IV -- 330214
	recipe = AddRecipe(330214, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(180059, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_MATERIALS")
	recipe:AddCustom("DEFAULT_RECIPE")

	-- Relic of the Past V -- 330215
	recipe = AddRecipe(330215, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(180060, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_MATERIALS")
	recipe:AddCustom("DEFAULT_RECIPE")

	-- Relic of the Past I -- 330216
	recipe = AddRecipe(330216, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(180055, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_MATERIALS")
	recipe:AddTrainer(122698, 136063)

	-- Relic of the Past II -- 330218
	recipe = AddRecipe(330218, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(180057, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_MATERIALS")
	recipe:AddTrainer(122698, 136063)

	-- Relic of the Past III -- 330219
	recipe = AddRecipe(330219, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(180058, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_MATERIALS")
	recipe:AddTrainer(122698, 136063)

	-- Relic of the Past IV -- 330220
	recipe = AddRecipe(330220, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(180059, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_MATERIALS")
	recipe:AddTrainer(122698, 136063)

	-- Relic of the Past V -- 330221
	recipe = AddRecipe(330221, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(180060, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_MATERIALS")
	recipe:AddTrainer(122698, 136063)

	-- Umbrahide Treads -- 332014
	recipe = AddRecipe(332014, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 110, 115, 120)
	recipe:SetCraftedItem(172315, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddDiscovery("DISCOVERY_SHADOWLANDS")

	-- Umbrahide Vest -- 332015
	recipe = AddRecipe(332015, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 110, 115, 120)
	recipe:SetCraftedItem(172314, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddDiscovery("DISCOVERY_SHADOWLANDS")

	-- Umbrahide Gauntlets -- 332016
	recipe = AddRecipe(332016, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 110, 115, 120)
	recipe:SetCraftedItem(172316, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddDiscovery("DISCOVERY_SHADOWLANDS")

	-- Umbrahide Helm -- 332017
	recipe = AddRecipe(332017, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 110, 115, 120)
	recipe:SetCraftedItem(172317, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HEAD")
	recipe:AddDiscovery("DISCOVERY_SHADOWLANDS")

	-- Umbrahide Leggings -- 332018
	recipe = AddRecipe(332018, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 110, 115, 120)
	recipe:SetCraftedItem(172318, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddDiscovery("DISCOVERY_SHADOWLANDS")

	-- Umbrahide Pauldrons -- 332019
	recipe = AddRecipe(332019, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 110, 115, 120)
	recipe:SetCraftedItem(172319, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddDiscovery("DISCOVERY_SHADOWLANDS")

	-- Umbrahide Waistguard -- 332020
	recipe = AddRecipe(332020, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 110, 115, 120)
	recipe:SetCraftedItem(172320, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddDiscovery("DISCOVERY_SHADOWLANDS")

	-- Umbrahide Armguards -- 332021
	recipe = AddRecipe(332021, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 110, 115, 120)
	recipe:SetCraftedItem(172321, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddDiscovery("DISCOVERY_SHADOWLANDS")

	-- Boneshatter Treads -- 332022
	recipe = AddRecipe(332022, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 110, 115, 120)
	recipe:SetCraftedItem(172323, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddDiscovery("DISCOVERY_SHADOWLANDS")

	-- Boneshatter Vest -- 332023
	recipe = AddRecipe(332023, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 110, 115, 120)
	recipe:SetCraftedItem(172322, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddDiscovery("DISCOVERY_SHADOWLANDS")

	-- Boneshatter Gauntlets -- 332024
	recipe = AddRecipe(332024, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 110, 115, 120)
	recipe:SetCraftedItem(172324, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddDiscovery("DISCOVERY_SHADOWLANDS")

	-- Boneshatter Helm -- 332025
	recipe = AddRecipe(332025, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 110, 115, 120)
	recipe:SetCraftedItem(172325, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HEAD")
	recipe:AddDiscovery("DISCOVERY_SHADOWLANDS")

	-- Boneshatter Greaves -- 332026
	recipe = AddRecipe(332026, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 110, 115, 120)
	recipe:SetCraftedItem(172326, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddDiscovery("DISCOVERY_SHADOWLANDS")

	-- Boneshatter Pauldrons -- 332027
	recipe = AddRecipe(332027, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 110, 115, 120)
	recipe:SetCraftedItem(172327, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_SHOULDER")
	recipe:AddDiscovery("DISCOVERY_SHADOWLANDS")

	-- Boneshatter Waistguard -- 332028
	recipe = AddRecipe(332028, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 110, 115, 120)
	recipe:SetCraftedItem(172328, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddDiscovery("DISCOVERY_SHADOWLANDS")

	-- Boneshatter Armguards -- 332029
	recipe = AddRecipe(332029, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 110, 115, 120)
	recipe:SetCraftedItem(172329, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddDiscovery("DISCOVERY_SHADOWLANDS")

	-- Umbrahide Treads -- 332049
	recipe = AddRecipe(332049, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 110, 115, 120)
	recipe:SetCraftedItem(172315, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddDiscovery("DISCOVERY_SHADOWLANDS")

	-- Umbrahide Vest -- 332050
	recipe = AddRecipe(332050, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 110, 115, 120)
	recipe:SetCraftedItem(172314, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddDiscovery("DISCOVERY_SHADOWLANDS")

	-- Umbrahide Gauntlets -- 332051
	recipe = AddRecipe(332051, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 110, 115, 120)
	recipe:SetCraftedItem(172316, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddDiscovery("DISCOVERY_SHADOWLANDS")

	-- Umbrahide Helm -- 332052
	recipe = AddRecipe(332052, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 110, 115, 120)
	recipe:SetCraftedItem(172317, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HEAD")
	recipe:AddDiscovery("DISCOVERY_SHADOWLANDS")

	-- Umbrahide Leggings -- 332053
	recipe = AddRecipe(332053, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 110, 115, 120)
	recipe:SetCraftedItem(172318, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddDiscovery("DISCOVERY_SHADOWLANDS")

	-- Umbrahide Pauldrons -- 332054
	recipe = AddRecipe(332054, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 110, 115, 120)
	recipe:SetCraftedItem(172319, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddDiscovery("DISCOVERY_SHADOWLANDS")

	-- Umbrahide Waistguard -- 332055
	recipe = AddRecipe(332055, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 110, 115, 120)
	recipe:SetCraftedItem(172320, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddDiscovery("DISCOVERY_SHADOWLANDS")

	-- Umbrahide Armguards -- 332056
	recipe = AddRecipe(332056, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 110, 115, 120)
	recipe:SetCraftedItem(172321, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddDiscovery("DISCOVERY_SHADOWLANDS")

	-- Boneshatter Treads -- 332057
	recipe = AddRecipe(332057, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 110, 115, 120)
	recipe:SetCraftedItem(172323, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddDiscovery("DISCOVERY_SHADOWLANDS")

	-- Boneshatter Vest -- 332058
	recipe = AddRecipe(332058, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 110, 115, 120)
	recipe:SetCraftedItem(172322, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddDiscovery("DISCOVERY_SHADOWLANDS")

	-- Boneshatter Gauntlets -- 332059
	recipe = AddRecipe(332059, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 110, 115, 120)
	recipe:SetCraftedItem(172324, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddDiscovery("DISCOVERY_SHADOWLANDS")

	-- Boneshatter Helm -- 332060
	recipe = AddRecipe(332060, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 110, 115, 120)
	recipe:SetCraftedItem(172325, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HEAD")
	recipe:AddDiscovery("DISCOVERY_SHADOWLANDS")

	-- Boneshatter Greaves -- 332061
	recipe = AddRecipe(332061, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 110, 115, 120)
	recipe:SetCraftedItem(172326, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddDiscovery("DISCOVERY_SHADOWLANDS")

	-- Boneshatter Pauldrons -- 332062
	recipe = AddRecipe(332062, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 110, 115, 120)
	recipe:SetCraftedItem(172327, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_SHOULDER")
	recipe:AddDiscovery("DISCOVERY_SHADOWLANDS")

	-- Boneshatter Waistguard -- 332063
	recipe = AddRecipe(332063, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 110, 115, 120)
	recipe:SetCraftedItem(172328, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddDiscovery("DISCOVERY_SHADOWLANDS")

	-- Boneshatter Armguards -- 332064
	recipe = AddRecipe(332064, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 110, 115, 120)
	recipe:SetCraftedItem(172329, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddDiscovery("DISCOVERY_SHADOWLANDS")

	-- Umbrahide Vest -- 338979
	recipe = AddRecipe(338979, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 110, 115, 120)
	recipe:SetCraftedItem(172314, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddDiscovery("DISCOVERY_SHADOWLANDS")

	-- Umbrahide Treads -- 338980
	recipe = AddRecipe(338980, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 110, 115, 120)
	recipe:SetCraftedItem(172315, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddDiscovery("DISCOVERY_SHADOWLANDS")

	-- Umbrahide Gauntlets -- 338981
	recipe = AddRecipe(338981, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 110, 115, 120)
	recipe:SetCraftedItem(172316, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddDiscovery("DISCOVERY_SHADOWLANDS")

	-- Umbrahide Helm -- 338982
	recipe = AddRecipe(338982, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 110, 115, 120)
	recipe:SetCraftedItem(172317, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HEAD")
	recipe:AddDiscovery("DISCOVERY_SHADOWLANDS")

	-- Umbrahide Leggings -- 338983
	recipe = AddRecipe(338983, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 110, 115, 120)
	recipe:SetCraftedItem(172318, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddDiscovery("DISCOVERY_SHADOWLANDS")

	-- Umbrahide Pauldrons -- 338984
	recipe = AddRecipe(338984, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 110, 115, 120)
	recipe:SetCraftedItem(172319, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddDiscovery("DISCOVERY_SHADOWLANDS")

	-- Umbrahide Waistguard -- 338985
	recipe = AddRecipe(338985, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 110, 115, 120)
	recipe:SetCraftedItem(172320, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddDiscovery("DISCOVERY_SHADOWLANDS")

	-- Umbrahide Armguards -- 338986
	recipe = AddRecipe(338986, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 110, 115, 120)
	recipe:SetCraftedItem(172321, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddDiscovery("DISCOVERY_SHADOWLANDS")

	-- Boneshatter Vest -- 338987
	recipe = AddRecipe(338987, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 110, 115, 120)
	recipe:SetCraftedItem(172322, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_CHEST")
	recipe:AddDiscovery("DISCOVERY_SHADOWLANDS")

	-- Boneshatter Treads -- 338988
	recipe = AddRecipe(338988, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 110, 115, 120)
	recipe:SetCraftedItem(172323, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_FEET")
	recipe:AddDiscovery("DISCOVERY_SHADOWLANDS")

	-- Boneshatter Gauntlets -- 338989
	recipe = AddRecipe(338989, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 110, 115, 120)
	recipe:SetCraftedItem(172324, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HANDS")
	recipe:AddDiscovery("DISCOVERY_SHADOWLANDS")

	-- Boneshatter Helm -- 338990
	recipe = AddRecipe(338990, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 110, 115, 120)
	recipe:SetCraftedItem(172325, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_HEAD")
	recipe:AddDiscovery("DISCOVERY_SHADOWLANDS")

	-- Boneshatter Greaves -- 338991
	recipe = AddRecipe(338991, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 110, 115, 120)
	recipe:SetCraftedItem(172326, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_LEGS")
	recipe:AddDiscovery("DISCOVERY_SHADOWLANDS")

	-- Boneshatter Pauldrons -- 338992
	recipe = AddRecipe(338992, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 110, 115, 120)
	recipe:SetCraftedItem(172327, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_SHOULDER")
	recipe:AddDiscovery("DISCOVERY_SHADOWLANDS")

	-- Boneshatter Waistguard -- 338993
	recipe = AddRecipe(338993, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 110, 115, 120)
	recipe:SetCraftedItem(172328, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WAIST")
	recipe:AddDiscovery("DISCOVERY_SHADOWLANDS")

	-- Boneshatter Armguards -- 338994
	recipe = AddRecipe(338994, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 110, 115, 120)
	recipe:SetCraftedItem(172329, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_WRIST")
	recipe:AddDiscovery("DISCOVERY_SHADOWLANDS")

	-- Crafter's Mark of the Chained Isle -- 343189
	recipe = AddRecipe(343189, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(200, 200, 200, 200, 200)
	recipe:SetRecipeItem(186470, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(173384, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_MATERIALS")
	recipe:AddRepVendor(FAC.THE_ARCHIVISTS_CODEX, REP.REVERED, 178257)

	-- Crafter's Mark III -- 343192
	recipe = AddRecipe(343192, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 190, 192, 195)
	recipe:SetRecipeItem(183868, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(173383, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_MATERIALS")
	recipe:AddRepVendor(FAC.DEATHS_ADVANCE, REP.HONORED, 179321)

	-- Crafter's Mark II -- 343193
	recipe = AddRecipe(343193, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 100, 100, 100)
	recipe:SetRecipeItem(183870, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(173381, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_MATERIALS")
	recipe:AddRepVendor(FAC.THE_VENARI, REP.REVERED, 162804)

	-- Crafter's Mark I -- 343195
	recipe = AddRecipe(343195, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(45, 45, 55, 60, 65)
	recipe:SetCraftedItem(173381, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_MATERIALS")
	recipe:AddTrainer(156669)

	-- Novice Crafter's Mark -- 343660
	recipe = AddRecipe(343660, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(183942, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_MATERIALS")
	recipe:AddTrainer(156669)

	-- Vestige of Origins -- 352444
	recipe = AddRecipe(352444, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 100, 100, 100)
	recipe:SetCraftedItem(185960, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_MATERIALS")
	recipe:AddRepVendor(FAC.DEATHS_ADVANCE, REP.HONORED, 179321)

	-- Pallid Oracle Bones -- 354797
	recipe = AddRecipe(354797, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 55, 60, 65)
	recipe:SetRecipeItem(186998, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(186686, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_TOY")
	recipe:AddWorldDrop(Z.DE_OTHER_SIDE)

	-- Pallid Bone Flute -- 354800
	recipe = AddRecipe(354800, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 80, 82, 85)
	recipe:SetRecipeItem(186999, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(186702, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_TOY")
	recipe:AddWorldDrop(Z.KORTHIA)

	-- Elusive Pet Treat -- 355354
	recipe = AddRecipe(355354, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 100, 100, 100)
	recipe:SetRecipeItem(187000, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(186985, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("LEATHERWORKING_TOY")
	recipe:AddQuest(64016, 64065)

-- 9.2 Recipes

	-- Crafter's Mark IV -- 359662
	recipe = AddRecipe(359662, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(201, 201, 201, 201, 201)
	recipe:SetRecipeItem(187750, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(187741, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_CREATED_ITEM")
	recipe:AddRepVendor(FAC.THE_ENLIGHTENED, REP.HONORED, 182257)

	-- Crafter's Mark of the First Ones -- 359669
	recipe = AddRecipe(359669, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(201, 201, 201, 201, 201)
	recipe:SetRecipeItem(187749, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(187742, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_CREATED_ITEM")
	recipe:AddRepVendor(FAC.THE_ENLIGHTENED, REP.HONORED, 182257)

	-- Vestige of the Eternal -- 359702
	recipe = AddRecipe(359702, V.SHA, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 203, 203, 203)
	recipe:SetRecipeItem(187785, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(187784, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("LEATHERWORKING_CREATED_ITEM")
	recipe:AddRepVendor(FAC.THE_ENLIGHTENED, REP.HONORED, 182257)

	self.InitializeRecipes = nil
end
