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
local F = constants.FILTER_IDS
local Q = constants.ITEM_QUALITIES
local V = constants.GAME_VERSIONS
local Z = constants.ZONE_NAMES

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
	
	-- Smelt Copper -- 2657
	recipe = AddRecipe(2657, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 25, 47, 70)
	recipe:SetCraftedItem(2840, "BIND_ON_EQUIP")
	recipe:AddCustom("DEFAULT_RECIPE")
	-- Smelt Silver -- 2658
	recipe = AddRecipe(2658, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(65, 65, 75, 80, 85)
	recipe:SetCraftedItem(2842, "BIND_ON_EQUIP")
	recipe:AddTrainer(33682, 18779, 5392, 8128, 1701, 16752, 5513, 26999, 4254, 3357, 16663, 1681, 26912, 3175, 6297, 3555, 26962, 3001, 28698, 17488, 18804, 26976, 33617, 3137, 18747, 4598)
	-- Smelt Bronze -- 2659
	recipe = AddRecipe(2659, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(2841, "BIND_ON_EQUIP")
	recipe:AddTrainer(33682, 18779, 5392, 8128, 1701, 16752, 5513, 26999, 4254, 3357, 16663, 1681, 26912, 3175, 6297, 3555, 26962, 3001, 28698, 17488, 18804, 26976, 33617, 3137, 18747, 4598)
	-- Smelt Tin -- 3304
	recipe = AddRecipe(3304, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(3576, "BIND_ON_EQUIP")
	recipe:AddTrainer(33682, 18779, 5392, 8128, 1701, 16752, 5513, 26999, 4254, 3357, 16663, 1681, 26912, 3175, 6297, 3555, 26962, 3001, 28698, 17488, 18804, 26976, 33617, 3137, 18747, 4598)
	-- Smelt Iron -- 3307
	recipe = AddRecipe(3307, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 110, 115, 120)
	recipe:SetCraftedItem(3575, "BIND_ON_EQUIP")
	recipe:AddTrainer(33682, 18779, 5392, 8128, 1701, 16752, 5513, 26999, 4254, 3357, 16663, 1681, 26912, 3175, 6297, 3555, 26962, 3001, 28698, 17488, 18804, 26976, 33617, 3137, 18747, 4598)
	-- Smelt Gold -- 3308
	recipe = AddRecipe(3308, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(115, 115, 125, 130, 135)
	recipe:SetCraftedItem(3577, "BIND_ON_EQUIP")
	recipe:AddTrainer(33682, 18779, 5392, 8128, 1701, 16752, 5513, 26999, 4254, 3357, 16663, 1681, 26912, 3175, 6297, 3555, 26962, 3001, 28698, 17488, 18804, 26976, 33617, 3137, 18747, 4598)
	-- Smelt Steel -- 3569
	recipe = AddRecipe(3569, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(125, 125, 135, 140, 145)
	recipe:SetCraftedItem(3859, "BIND_ON_EQUIP")
	recipe:AddTrainer(33682, 18779, 5392, 8128, 1701, 16752, 5513, 26999, 4254, 3357, 16663, 1681, 26912, 3175, 6297, 3555, 26962, 3001, 28698, 17488, 18804, 26976, 33617, 3137, 18747, 4598)
	-- Smelt Mithril -- 10097
	recipe = AddRecipe(10097, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(150, 150, 160, 165, 170)
	recipe:SetCraftedItem(3860, "BIND_ON_EQUIP")
	recipe:AddTrainer(33682, 18779, 5392, 8128, 1701, 16752, 5513, 26999, 4254, 3357, 16663, 1681, 26912, 3175, 6297, 3555, 26962, 3001, 28698, 17488, 18804, 26976, 33617, 3137, 18747, 4598)
	-- Smelt Truesilver -- 10098
	recipe = AddRecipe(10098, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(165, 165, 175, 180, 185)
	recipe:SetCraftedItem(6037, "BIND_ON_EQUIP")
	recipe:AddTrainer(33682, 18779, 5392, 8128, 1701, 16752, 5513, 26999, 4254, 3357, 16663, 1681, 26912, 3175, 6297, 3555, 26962, 3001, 28698, 17488, 18804, 26976, 33617, 3137, 18747, 4598)
	-- Smelt Dark Iron -- 14891
	recipe = AddRecipe(14891, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(230, 230, 300, 305, 310)
	recipe:SetCraftedItem(11371, "BIND_ON_EQUIP")
	recipe:AddQuest(4083)
	-- Smelt Thorium -- 16153
	recipe = AddRecipe(16153, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(200, 200, 210, 215, 220)
	recipe:SetCraftedItem(12359, "BIND_ON_EQUIP")
	recipe:AddTrainer(33682, 18779, 5392, 8128, 1701, 16752, 5513, 26999, 4254, 3357, 16663, 1681, 26912, 3175, 6297, 3555, 26962, 3001, 28698, 17488, 18804, 26976, 33617, 3137, 18747, 4598)
	-- Smelt Enchanted Elementium -- 22967
	recipe = AddRecipe(22967, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(300, 300, 350, 362, 375)
	recipe:SetRecipeItem(44956, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(17771, "BIND_ON_EQUIP")
	recipe:AddFilters(F.RAID)
	recipe:AddMobDrop(14401)

	-- ----------------------------------------------------------------------------
	-- The Burning Crusade.
	-- ----------------------------------------------------------------------------

	-- Smelt Fel Iron -- 29356
	recipe = AddRecipe(29356, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(23445, "BIND_ON_EQUIP")
	recipe:AddTrainer(18779, 28698, 26962, 33617, 26999, 33682, 26912, 26976, 18747)
	-- Smelt Adamantite -- 29358
	recipe = AddRecipe(29358, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(23446, "BIND_ON_EQUIP")
	recipe:AddTrainer(18779, 28698, 26962, 33617, 26999, 33682, 26912, 26976, 18747)
	-- Smelt Eternium -- 29359
	recipe = AddRecipe(29359, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(23447, "BIND_ON_EQUIP")
	recipe:AddTrainer(18779, 28698, 26962, 33617, 26999, 33682, 26912, 26976, 18747)
	-- Smelt Felsteel -- 29360
	recipe = AddRecipe(29360, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(23448, "BIND_ON_EQUIP")
	recipe:AddTrainer(18779, 28698, 26962, 33617, 26999, 33682, 26912, 26976, 18747)
	-- Smelt Khorium -- 29361
	recipe = AddRecipe(29361, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 85, 90, 95)
	recipe:SetCraftedItem(23449, "BIND_ON_EQUIP")
	recipe:AddTrainer(18779, 28698, 26962, 33617, 26999, 33682, 26912, 26976, 18747)
	-- Smelt Hardened Adamantite -- 29686
	recipe = AddRecipe(29686, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 85, 90, 95)
	recipe:SetCraftedItem(23573, "BIND_ON_EQUIP")
	recipe:AddTrainer(18779, 28698, 26962, 33617, 26999, 33682, 26912, 26976, 18747)
	-- Earth Shatter -- 35750
	recipe = AddRecipe(35750, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(22573, "BIND_ON_EQUIP")
	recipe:AddTrainer(18779, 28698, 26962, 33617, 26999, 33682, 26912, 26976, 18747)
	-- Fire Sunder -- 35751
	recipe = AddRecipe(35751, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(22574, "BIND_ON_EQUIP")
	recipe:AddTrainer(18779, 28698, 26962, 33617, 26999, 33682, 26912, 26976, 18747)

	-- ----------------------------------------------------------------------------
	-- Wrath of the Lich King.
	-- ----------------------------------------------------------------------------

	-- Smelt Hardened Khorium -- 46353
	recipe = AddRecipe(46353, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(375, 375, 375, 375, 375)
	recipe:SetRecipeItem(35273, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(35128, "BIND_ON_EQUIP")
	recipe:AddFilters(F.RAID)
	recipe:AddWorldDrop(Z.SUNWELL_PLATEAU)
	-- Smelt Cobalt -- 49252
	recipe = AddRecipe(49252, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(36916, "BIND_ON_EQUIP")
	recipe:AddTrainer(26999, 28698, 26912, 26976, 26962)
	-- Smelt Saronite -- 49258
	recipe = AddRecipe(49258, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(36913, "BIND_ON_EQUIP")
	recipe:AddTrainer(26999, 28698, 26912, 26976, 26962)
	-- Smelt Titansteel -- 55208
	recipe = AddRecipe(55208, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 85, 90, 95)
	recipe:SetCraftedItem(37663, "BIND_ON_EQUIP")
	recipe:AddTrainer(26999, 28698, 26912, 26976, 26962)
	-- Smelt Titanium -- 55211
	recipe = AddRecipe(55211, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 85, 90, 95)
	recipe:SetCraftedItem(41163, "BIND_ON_EQUIP")
	recipe:AddTrainer(26999, 28698, 26912, 26976, 26962)
	-- Enchanted Thorium Bar -- 70524
	recipe = AddRecipe(70524, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(250, 250, 250, 255, 260)
	recipe:SetCraftedItem(12655, "BIND_ON_EQUIP")
	recipe:AddTrainer(28698)
	
	self.InitializeRecipes = nil
end
