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
	recipe:AddTrainer(1443, 1681, 1701, 3001, 3137, 3175, 3357, 3555, 4254, 4598, 5392, 5513, 8128, 16663, 16752, 17488, 18747, 18779, 18804, 43431, 46357, 47384, 47396, 47400, 47418, 47419, 47421, 47431, 48619, 49885, 52170, 52642, 53409, 57620, 65043, 65092, 85919, 86014, 93189, 133236)

	-- Smelt Bronze -- 2659
	recipe = AddRecipe(2659, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(2841, "BIND_ON_EQUIP")
	recipe:AddTrainer(1443, 1681, 1701, 3001, 3137, 3175, 3357, 3555, 4254, 4598, 5392, 5513, 8128, 16663, 16752, 17488, 18747, 18779, 18804, 43431, 46357, 47384, 47396, 47400, 47418, 47419, 47421, 47431, 48619, 49885, 52170, 52642, 53409, 57620, 65043, 65092, 85919, 86014, 93189, 133236)

	-- Smelt Tin -- 3304
	recipe = AddRecipe(3304, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(3576, "BIND_ON_EQUIP")
	recipe:AddTrainer(1443, 1681, 1701, 3001, 3137, 3175, 3357, 3555, 4254, 4598, 5392, 5513, 8128, 16663, 16752, 17488, 18747, 18779, 18804, 43431, 46357, 47384, 47396, 47400, 47418, 47419, 47421, 47431, 48619, 49885, 52170, 52642, 53409, 57620, 65043, 65092, 85919, 86014, 93189, 133236)

	-- Smelt Iron -- 3307
	recipe = AddRecipe(3307, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 110, 115, 120)
	recipe:SetCraftedItem(3575, "BIND_ON_EQUIP")
	recipe:AddTrainer(1443, 1681, 1701, 3001, 3137, 3175, 3357, 3555, 4254, 4598, 5392, 5513, 8128, 16663, 16752, 17488, 18747, 18779, 18804, 43431, 46357, 49885, 52170, 52642, 53409, 65092, 133236)

	-- Smelt Gold -- 3308
	recipe = AddRecipe(3308, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(115, 115, 125, 130, 135)
	recipe:SetCraftedItem(3577, "BIND_ON_EQUIP")
	recipe:AddTrainer(1443, 1681, 1701, 3001, 3137, 3175, 3357, 3555, 4254, 4598, 5392, 5513, 8128, 16663, 16752, 17488, 18747, 18779, 18804, 43431, 46357, 49885, 52170, 52642, 53409, 65092, 133236)

	-- Smelt Steel -- 3569
	recipe = AddRecipe(3569, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(125, 125, 135, 140, 145)
	recipe:SetCraftedItem(3859, "BIND_ON_EQUIP")
	recipe:AddTrainer(1443, 1681, 1701, 3001, 3137, 3175, 3357, 3555, 4254, 4598, 5392, 5513, 8128, 16663, 16752, 17488, 18747, 18779, 18804, 43431, 46357, 49885, 52170, 52642, 53409, 65092, 133236)

	-- Smelt Mithril -- 10097
	recipe = AddRecipe(10097, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(150, 150, 160, 165, 170)
	recipe:SetCraftedItem(3860, "BIND_ON_EQUIP")
	recipe:AddTrainer(1443, 1681, 1701, 3001, 3137, 3175, 3357, 3555, 4254, 4598, 5392, 5513, 8128, 16663, 16752, 17488, 18747, 18779, 18804, 43431, 46357, 52170, 52642, 53409, 65092, 133236)

	-- Smelt Truesilver -- 10098
	recipe = AddRecipe(10098, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(165, 165, 175, 180, 185)
	recipe:SetCraftedItem(6037, "BIND_ON_EQUIP")
	recipe:AddTrainer(1443, 1681, 1701, 3001, 3137, 3175, 3357, 3555, 4254, 4598, 5392, 5513, 8128, 16663, 16752, 17488, 18747, 18779, 18804, 43431, 46357, 52170, 52642, 53409, 65092, 133236)

	-- Smelt Dark Iron -- 14891
	recipe = AddRecipe(14891, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(230, 230, 300, 305, 310)
	recipe:SetCraftedItem(11371, "BIND_ON_EQUIP")
	recipe:AddQuest(4083)

	-- Smelt Thorium -- 16153
	recipe = AddRecipe(16153, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(200, 200, 210, 215, 220)
	recipe:SetCraftedItem(12359, "BIND_ON_EQUIP")
	recipe:AddTrainer(1443, 1681, 1701, 3001, 3137, 3175, 3357, 3555, 4254, 4598, 5392, 5513, 8128, 16663, 16752, 17488, 18747, 18779, 18804, 43431, 46357, 52170, 52642, 53409, 65092, 133236)

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
	recipe:AddTrainer(1443, 1701, 17488, 18747, 18779, 33617, 33640, 33682, 52642, 65092)

	-- Smelt Adamantite -- 29358
	recipe = AddRecipe(29358, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(23446, "BIND_ON_EQUIP")
	recipe:AddTrainer(1443, 1701, 17488, 18747, 18779, 33617, 33640, 33682, 52642, 65092)

	-- Smelt Eternium -- 29359
	recipe = AddRecipe(29359, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(23447, "BIND_ON_EQUIP")
	recipe:AddTrainer(1443, 1701, 17488, 18747, 18779, 33617, 33640, 33682, 52642, 65092)

	-- Smelt Felsteel -- 29360
	recipe = AddRecipe(29360, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(23448, "BIND_ON_EQUIP")
	recipe:AddTrainer(1443, 1701, 17488, 18747, 18779, 33617, 33640, 33682, 52642, 65092)

	-- Smelt Khorium -- 29361
	recipe = AddRecipe(29361, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 85, 90, 95)
	recipe:SetCraftedItem(23449, "BIND_ON_EQUIP")
	recipe:AddTrainer(1443, 1701, 17488, 18747, 18779, 33617, 33640, 33682, 52642, 65092)

	-- Smelt Hardened Adamantite -- 29686
	recipe = AddRecipe(29686, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 85, 90, 95)
	recipe:SetCraftedItem(23573, "BIND_ON_EQUIP")
	recipe:AddTrainer(1443, 1701, 17488, 18747, 18779, 33617, 33640, 33682, 52642, 65092)

	-- Earth Shatter -- 35750
	recipe = AddRecipe(35750, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(22573, "BIND_ON_EQUIP")
	recipe:AddTrainer(1443, 1701, 17488, 18747, 18779, 33617, 33640, 33682, 52642, 65092)

	-- Fire Sunder -- 35751
	recipe = AddRecipe(35751, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(22574, "BIND_ON_EQUIP")
	recipe:AddTrainer(1443, 1701, 17488, 18747, 18779, 33617, 33640, 33682, 52642, 65092)

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
	recipe:AddTrainer(1443, 1701, 17488, 18747, 18779, 26912, 26962, 26976, 26999, 28698, 52642, 65092)

	-- Smelt Saronite -- 49258
	recipe = AddRecipe(49258, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(36913, "BIND_ON_EQUIP")
	recipe:AddTrainer(1443, 1701, 17488, 18747, 18779, 26912, 26962, 26976, 26999, 28698, 52642, 65092)

	-- Smelt Titansteel -- 55208
	recipe = AddRecipe(55208, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 85, 90, 95)
	recipe:SetCraftedItem(37663, "BIND_ON_EQUIP")
	recipe:AddTrainer(1443, 1701, 17488, 18747, 18779, 26912, 26962, 26976, 26999, 28698, 52642, 65092)

	-- Smelt Titanium -- 55211
	recipe = AddRecipe(55211, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 85, 90, 95)
	recipe:SetCraftedItem(41163, "BIND_ON_EQUIP")
	recipe:AddTrainer(1443, 1701, 17488, 18747, 18779, 26912, 26962, 26976, 26999, 28698, 52642, 65092)

	-- Enchanted Thorium Bar -- 70524
	recipe = AddRecipe(70524, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(250, 250, 250, 255, 260)
	recipe:SetCraftedItem(12655, "BIND_ON_EQUIP")
	recipe:AddTrainer(1443, 1701, 3001, 3175, 3357, 4254, 4598, 5513, 8128, 16663, 17488, 18747, 18779, 43431, 46357, 52170, 52642, 53409, 65092, 133236)

	-- ----------------------------------------------------------------------------
	-- Cataclysm.
	-- ----------------------------------------------------------------------------
	-- Smelt Pyrite -- 74529
	recipe = AddRecipe(74529, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 85, 90, 95)
	recipe:SetCraftedItem(51950, "BIND_ON_EQUIP")
	recipe:AddTrainer(1443, 1701, 3001, 3175, 3357, 4254, 4598, 5513, 8128, 16663, 17488, 18747, 18779, 43431, 46357, 52170, 52642, 53409, 65092, 133236)

	-- Smelt Elementium -- 74530
	recipe = AddRecipe(74530, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:SetCraftedItem(52186, "BIND_ON_EQUIP")
	recipe:AddTrainer(1443, 1701, 3001, 3175, 3357, 4254, 4598, 5513, 8128, 16663, 17488, 18747, 18779, 43431, 46357, 52170, 52642, 53409, 65092, 133236)

	-- Smelt Hardened Elementium -- 74537
	recipe = AddRecipe(74537, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 60, 65, 70)
	recipe:SetCraftedItem(53039, "BIND_ON_EQUIP")
	recipe:AddTrainer(1443, 1701, 3001, 3175, 3357, 4254, 4598, 5513, 8128, 16663, 17488, 18747, 18779, 43431, 46357, 52170, 52642, 53409, 65092, 133236)

	-- Smelt Obsidium -- 84038
	recipe = AddRecipe(84038, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(54849, "BIND_ON_EQUIP")
	recipe:AddTrainer(1443, 1701, 3001, 3175, 3357, 4254, 4598, 5513, 8128, 16663, 17488, 18747, 18779, 43431, 46357, 52170, 52642, 53409, 65092, 133236)

	-- ----------------------------------------------------------------------------
	-- Mists of Pandaria.
	-- ----------------------------------------------------------------------------
	-- Smelt Ghost Iron -- 102165
	recipe = AddRecipe(102165, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(72096, "BIND_ON_EQUIP")
	recipe:AddTrainer(1443, 1701, 17488, 18747, 18779, 52642, 65092, 66979)

	-- Smelt Trillium -- 102167
	recipe = AddRecipe(102167, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 85, 90, 95)
	recipe:SetCraftedItem(72095, "BIND_ON_EQUIP")
	recipe:AddTrainer(1443, 1701, 17488, 18747, 18779, 52642, 65092, 66979)

	-- ----------------------------------------------------------------------------
	-- Legion.
	-- ----------------------------------------------------------------------------
	-- Leystone Deposit -- 184454
	recipe = AddRecipe(184454, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 700, 700)
	recipe:AddWorldDrop(Z.BROKEN_ISLES)

	-- Leystone Deposit -- 184456
	recipe = AddRecipe(184456, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 700, 700)
	recipe:AddWorldDrop(Z.BROKEN_ISLES)

	-- Leystone Deposit -- 184457
	recipe = AddRecipe(184457, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 700, 700)
	recipe:AddQuest(38792)

	-- Leystone Seam -- 184484
	recipe = AddRecipe(184484, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 700, 700)
	recipe:AddWorldDrop(Z.BROKEN_ISLES)

	-- Leystone Seam -- 184485
	recipe = AddRecipe(184485, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 700, 700)
	recipe:AddWorldDrop(Z.BROKEN_ISLES)

	-- Leystone Seam -- 184486
	recipe = AddRecipe(184486, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 700, 700)
	recipe:AddQuest(38793)

	-- Living Leystone -- 184488
	recipe = AddRecipe(184488, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 700, 700)
	recipe:AddWorldDrop(Z.BROKEN_ISLES)

	-- Living Leystone -- 184489
	recipe = AddRecipe(184489, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 700, 700)
	recipe:AddWorldDrop(Z.BROKEN_ISLES)

	-- Living Leystone -- 184490
	recipe = AddRecipe(184490, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 700, 700)
	recipe:AddQuest(38794)

	-- Felslate Deposit -- 184492
	recipe = AddRecipe(184492, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 700, 700)
	recipe:AddWorldDrop(Z.BROKEN_ISLES)

	-- Felslate Deposit -- 184493
	recipe = AddRecipe(184493, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 700, 700)
	recipe:AddQuest(38800)

	-- Felslate Deposit -- 184494
	recipe = AddRecipe(184494, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 700, 700)
	recipe:AddWorldDrop(Z.BROKEN_ISLES)

	-- Felslate Seam -- 184496
	recipe = AddRecipe(184496, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 700, 700)
	recipe:AddWorldDrop(Z.BROKEN_ISLES)

	-- Felslate Seam -- 184497
	recipe = AddRecipe(184497, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 700, 700)
	recipe:AddQuest(38801)

	-- Felslate Seam -- 184498
	recipe = AddRecipe(184498, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 700, 700)
	recipe:AddQuest(38804)

	-- Living Felslate -- 184500
	recipe = AddRecipe(184500, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 700, 700)
	recipe:AddWorldDrop(Z.BROKEN_ISLES)

	-- Living Felslate -- 184501
	recipe = AddRecipe(184501, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 700, 700)
	recipe:AddQuest(38802)

	-- Living Felslate -- 184502
	recipe = AddRecipe(184502, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 700, 700)
	recipe:AddQuest(38805)

	-- Infernal Brimstone -- 184504
	recipe = AddRecipe(184504, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 700, 700)
	recipe:AddWorldDrop(Z.BROKEN_ISLES)

	-- Infernal Brimstone -- 184505
	recipe = AddRecipe(184505, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 700, 700)
	recipe:AddQuest(38807)

	-- Infernal Brimstone -- 191970
	recipe = AddRecipe(191970, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 700, 700)
	recipe:AddWorldDrop(Z.BROKEN_ISLES)

	-- Empyrium Deposit -- 247848
	recipe = AddRecipe(247848, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 700, 700)
	recipe:AddWorldDrop(Z.BROKEN_ISLES)

	-- Empyrium Deposit -- 247849
	recipe = AddRecipe(247849, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 700, 700)
	recipe:AddWorldDrop(Z.BROKEN_ISLES)

	-- Empyrium Deposit -- 247850
	recipe = AddRecipe(247850, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 700, 700)
	recipe:AddWorldDrop(Z.BROKEN_ISLES)

	-- Empyrium Seam -- 247851
	recipe = AddRecipe(247851, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 700, 700)
	recipe:AddWorldDrop(Z.BROKEN_ISLES)

	-- Empyrium Seam -- 247852
	recipe = AddRecipe(247852, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 700, 700)
	recipe:AddWorldDrop(Z.BROKEN_ISLES)

	-- Empyrium Seam -- 247853
	recipe = AddRecipe(247853, V.LEGION, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 700, 700, 700)
	recipe:AddWorldDrop(Z.BROKEN_ISLES)

	-- ----------------------------------------------------------------------------
	-- Battle for Azeroth.
	-- ----------------------------------------------------------------------------
	-- Monelite Deposit -- 253333
	recipe = AddRecipe(253333, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:AddTrainer(122694, 136091, 154257, 154408)

	-- Monelite Deposit -- 253334
	recipe = AddRecipe(253334, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 150, 150, 150)
	recipe:AddWorldDrop(Z.KUL_TIRAS, Z.ZULDAZAR)

	-- Monelite Deposit -- 253335
	recipe = AddRecipe(253335, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(150, 150, 150, 150, 150)
	recipe:AddWorldDrop(Z.KUL_TIRAS, Z.ZULDAZAR)

	-- Storm Silver Deposit -- 253336
	recipe = AddRecipe(253336, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:AddTrainer(122694, 136091, 154257, 154408)

	-- Storm Silver Deposit -- 253337
	recipe = AddRecipe(253337, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 150, 150, 150)
	recipe:AddWorldDrop(Z.KUL_TIRAS, Z.ZULDAZAR)

	-- Storm Silver Deposit -- 253338
	recipe = AddRecipe(253338, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(150, 150, 150, 150, 150)
	recipe:AddWorldDrop(Z.KUL_TIRAS, Z.ZULDAZAR)

	-- Platinum Deposit -- 253339
	recipe = AddRecipe(253339, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:AddTrainer(122694, 136091, 154257, 154408)

	-- Platinum Deposit -- 253340
	recipe = AddRecipe(253340, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(150, 150, 150, 150, 150)
	recipe:AddWorldDrop(Z.KUL_TIRAS, Z.ZULDAZAR)

	-- Platinum Deposit -- 253341
	recipe = AddRecipe(253341, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(150, 150, 150, 150, 150)
	recipe:AddWorldDrop(Z.KUL_TIRAS, Z.ZULDAZAR)

	-- Monelite Seam -- 253342
	recipe = AddRecipe(253342, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:AddTrainer(122694, 136091, 154257, 154408)

	-- Monelite Seam -- 253343
	recipe = AddRecipe(253343, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(50, 50, 150, 150, 150)
	recipe:AddWorldDrop(Z.KUL_TIRAS, Z.ZULDAZAR)

	-- Monelite Seam -- 253344
	recipe = AddRecipe(253344, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(150, 150, 150, 150, 150)
	recipe:AddWorldDrop(Z.KUL_TIRAS, Z.ZULDAZAR)

	-- Storm Silver Seam -- 253345
	recipe = AddRecipe(253345, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 35, 40, 45)
	recipe:AddTrainer(122694, 136091, 154257, 154408)

	-- Storm Silver Seam -- 253346
	recipe = AddRecipe(253346, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(150, 150, 150, 150, 150)
	recipe:AddWorldDrop(Z.KUL_TIRAS, Z.ZULDAZAR)

	-- Storm Silver Seam -- 253347
	recipe = AddRecipe(253347, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(150, 150, 150, 150, 150)
	recipe:AddWorldDrop(Z.KUL_TIRAS, Z.ZULDAZAR)

	-- Osmenite Seam -- 296143
	recipe = AddRecipe(296143, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(155, 155, 175, 175, 175)
	recipe:AddWorldDrop(Z.KUL_TIRAS, Z.ZULDAZAR)

	-- Osmenite Seam -- 296144
	recipe = AddRecipe(296144, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(155, 155, 175, 175, 175)
	recipe:SetRecipeItem(169613, "BIND_ON_PICKUP")
	recipe:AddMobDrop(150191)

	-- Osmenite Seam -- 296145
	recipe = AddRecipe(296145, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(140, 140, 150, 155, 160)
	recipe:AddTrainer(154257, 154408)

	-- Osmenite Deposit -- 296147
	recipe = AddRecipe(296147, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(155, 155, 175, 175, 175)
	recipe:AddWorldDrop(Z.KUL_TIRAS, Z.ZULDAZAR)

	-- Osmenite Deposit -- 296148
	recipe = AddRecipe(296148, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(155, 155, 175, 175, 175)
	recipe:SetRecipeItem(169612, "BIND_ON_PICKUP")
	recipe:AddMobDrop(150191)

	-- Osmenite Deposit -- 296149
	recipe = AddRecipe(296149, V.BFA, Q.COMMON)
	recipe:SetSkillLevels(140, 140, 150, 155, 160)
	recipe:AddTrainer(154257, 154408)

	-- ----------------------------------------------------------------------------
	-- Shadowlands.
	-- ----------------------------------------------------------------------------

	self.InitializeRecipes = nil
end
