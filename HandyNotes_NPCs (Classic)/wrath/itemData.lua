local name, data = ...
data["items"] = { }
local t = data["items"]
local L = LibStub("AceLocale-3.0"):GetLocale("HandyNotes_NPCs (Classic)")

t[2880] = {
	name = L["Weak Flux"],
	quality = 1,
	icon = "inv_misc_ammo_gunpowder_02",
	buyPrice = 100,
	sellPrice = 25,
	reqLevel = 0,
}
t[3466] = {
	name = L["Strong Flux"],
	quality = 1,
	icon = "inv_misc_ammo_gunpowder_01",
	buyPrice = 2000,
	sellPrice = 500,
	reqLevel = 0,
}
t[2901] = {
	name = L["Mining Pick"],
	quality = 1,
	icon = "inv_pick_02",
	buyPrice = 81,
	sellPrice = 16,
	reqLevel = 1,
}
t[3857] = {
	name = L["Coal"],
	quality = 1,
	icon = "inv_ore_tin_01",
	buyPrice = 500,
	sellPrice = 125,
	reqLevel = 0,
}
t[5956] = {
	name = L["Blacksmith Hammer"],
	quality = 1,
	icon = "inv_hammer_20",
	buyPrice = 18,
	sellPrice = 3,
	reqLevel = 1,
}
t[18567] = {
	name = L["Elemental Flux"],
	quality = 1,
	icon = "spell_frost_fireresistancetotem",
	buyPrice = 150000,
	sellPrice = 37500,
	reqLevel = 0,
}
t[23638] = {
	name = L["Plans: Lesser Ward of Shielding"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 60000,
	sellPrice = 15000,
	reqLevel = 0,
	profession = L["Blacksmithing"],
	teaches = L["Lesser Ward of Shielding"],
	learnedAt = 340,
}
t[25847] = {
	name = L["Plans: Eternium Rod"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 120000,
	sellPrice = 30000,
	reqLevel = 0,
	profession = L["Blacksmithing"],
	teaches = L["Eternium Rod"],
	learnedAt = 360,
}
t[8766] = {
	name = L["Morning Glory Dew"],
	quality = 1,
	icon = "inv_potion_01",
	buyPrice = 4000,
	sellPrice = 200,
	reqLevel = 45,
}
t[8952] = {
	name = L["Roasted Quail"],
	quality = 1,
	icon = "inv_misc_food_15",
	buyPrice = 4000,
	sellPrice = 200,
	reqLevel = 45,
}
t[27688] = {
	name = L["Recipe: Ravager Dog"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 20000,
	sellPrice = 5000,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Ravager Dog"],
	learnedAt = 300,
}
t[27854] = {
	name = L["Smoked Talbuk Venison"],
	quality = 1,
	icon = "inv_misc_food_50",
	buyPrice = 5600,
	sellPrice = 280,
	reqLevel = 55,
}
t[27860] = {
	name = L["Purified Draenic Water"],
	quality = 1,
	icon = "inv_drink_waterskin_12",
	buyPrice = 6400,
	sellPrice = 320,
	reqLevel = 65,
}
t[28399] = {
	name = L["Filtered Draenic Water"],
	quality = 1,
	icon = "inv_drink_waterskin_11",
	buyPrice = 5600,
	sellPrice = 280,
	reqLevel = 60,
}
t[29451] = {
	name = L["Clefthoof Ribs"],
	quality = 1,
	icon = "inv_misc_food_48",
	buyPrice = 8000,
	sellPrice = 400,
	reqLevel = 65,
}
t[8925] = {
	name = L["Crystal Vial"],
	quality = 1,
	icon = "inv_alchemy_crystalvial",
	buyPrice = 2500,
	sellPrice = 125,
	reqLevel = 0,
}
t[18256] = {
	name = L["Imbued Vial"],
	quality = 1,
	icon = "inv_alchemy_imbuedvial",
	buyPrice = 20000,
	sellPrice = 1000,
	reqLevel = 0,
}
t[3775] = {
	name = L["Crippling Poison"],
	quality = 1,
	icon = "ability_poisonsting",
	buyPrice = 70,
	sellPrice = 17,
	reqLevel = 20,
}
t[3777] = {
	name = L["Lethargy Root"],
	quality = 0,
	icon = "inv_misc_dust_02",
	buyPrice = 40,
	sellPrice = 10,
	reqLevel = 0,
}
t[5140] = {
	name = L["Flash Powder"],
	quality = 0,
	icon = "inv_misc_powder_purple",
	buyPrice = 25,
	sellPrice = 6,
	reqLevel = 0,
}
t[5173] = {
	name = L["Deathweed"],
	quality = 0,
	icon = "inv_misc_flower_03",
	buyPrice = 100,
	sellPrice = 25,
	reqLevel = 0,
}
t[5237] = {
	name = L["Mind-numbing Poison"],
	quality = 1,
	icon = "spell_nature_nullifydisease",
	buyPrice = 40,
	sellPrice = 10,
	reqLevel = 24,
}
t[5565] = {
	name = L["Infernal Stone"],
	quality = 1,
	icon = "inv_stone_05",
	buyPrice = 5000,
	sellPrice = 1250,
	reqLevel = 0,
}
t[8923] = {
	name = L["Essence of Agony"],
	quality = 0,
	icon = "inv_potion_19",
	buyPrice = 200,
	sellPrice = 50,
	reqLevel = 0,
}
t[8924] = {
	name = L["Dust of Deterioration"],
	quality = 0,
	icon = "inv_misc_ammo_gunpowder_01",
	buyPrice = 100,
	sellPrice = 25,
	reqLevel = 0,
}
t[8927] = {
	name = L["Instant Poison V"],
	quality = 1,
	icon = "ability_poisons",
	buyPrice = 700,
	sellPrice = 175,
	reqLevel = 52,
}
t[8928] = {
	name = L["Instant Poison VI"],
	quality = 1,
	icon = "ability_poisons",
	buyPrice = 800,
	sellPrice = 200,
	reqLevel = 60,
}
t[8985] = {
	name = L["Deadly Poison IV"],
	quality = 1,
	icon = "ability_rogue_dualweild",
	buyPrice = 250,
	sellPrice = 62,
	reqLevel = 54,
}
t[10922] = {
	name = L["Wound Poison IV"],
	quality = 1,
	icon = "inv_misc_herb_16",
	buyPrice = 800,
	sellPrice = 200,
	reqLevel = 56,
}
t[16583] = {
	name = L["Demonic Figurine"],
	quality = 1,
	icon = "inv_misc_orb_05",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 0,
}
t[17020] = {
	name = L["Arcane Powder"],
	quality = 1,
	icon = "inv_misc_dust_01",
	buyPrice = 1000,
	sellPrice = 250,
	reqLevel = 0,
}
t[17021] = {
	name = L["Wild Berries"],
	quality = 1,
	icon = "inv_misc_branch_01",
	buyPrice = 700,
	sellPrice = 175,
	reqLevel = 0,
}
t[17026] = {
	name = L["Wild Thornroot"],
	quality = 1,
	icon = "inv_misc_root_01",
	buyPrice = 1000,
	sellPrice = 250,
	reqLevel = 0,
}
t[17028] = {
	name = L["Holy Candle"],
	quality = 1,
	icon = "inv_misc_candle_03",
	buyPrice = 700,
	sellPrice = 175,
	reqLevel = 0,
}
t[17029] = {
	name = L["Sacred Candle"],
	quality = 1,
	icon = "inv_misc_candle_02",
	buyPrice = 1000,
	sellPrice = 250,
	reqLevel = 0,
}
t[17030] = {
	name = L["Ankh"],
	quality = 1,
	icon = "inv_jewelry_talisman_06",
	buyPrice = 2000,
	sellPrice = 500,
	reqLevel = 0,
}
t[17031] = {
	name = L["Rune of Teleportation"],
	quality = 1,
	icon = "inv_misc_rune_06",
	buyPrice = 1000,
	sellPrice = 250,
	reqLevel = 0,
}
t[17032] = {
	name = L["Rune of Portals"],
	quality = 1,
	icon = "inv_misc_rune_08",
	buyPrice = 2000,
	sellPrice = 500,
	reqLevel = 0,
}
t[17033] = {
	name = L["Symbol of Divinity"],
	quality = 1,
	icon = "inv_stone_weightstone_05",
	buyPrice = 2000,
	sellPrice = 500,
	reqLevel = 0,
}
t[17037] = {
	name = L["Hornbeam Seed"],
	quality = 1,
	icon = "inv_misc_food_02",
	buyPrice = 1400,
	sellPrice = 350,
	reqLevel = 0,
}
t[17038] = {
	name = L["Ironwood Seed"],
	quality = 1,
	icon = "inv_misc_food_02",
	buyPrice = 2000,
	sellPrice = 500,
	reqLevel = 0,
}
t[20844] = {
	name = L["Deadly Poison V"],
	quality = 1,
	icon = "ability_rogue_dualweild",
	buyPrice = 300,
	sellPrice = 75,
	reqLevel = 60,
}
t[21177] = {
	name = L["Symbol of Kings"],
	quality = 1,
	icon = "inv_misc_symbolofkings_01",
	buyPrice = 3000,
	sellPrice = 37,
	reqLevel = 0,
}
t[21835] = {
	name = L["Anesthetic Poison"],
	quality = 1,
	icon = "spell_nature_slowpoison",
	buyPrice = 1500,
	sellPrice = 375,
	reqLevel = 68,
}
t[21927] = {
	name = L["Instant Poison VII"],
	quality = 1,
	icon = "ability_poisons",
	buyPrice = 1500,
	sellPrice = 375,
	reqLevel = 68,
}
t[22053] = {
	name = L["Deadly Poison VI"],
	quality = 1,
	icon = "ability_rogue_dualweild",
	buyPrice = 1000,
	sellPrice = 250,
	reqLevel = 62,
}
t[22054] = {
	name = L["Deadly Poison VII"],
	quality = 1,
	icon = "ability_rogue_dualweild",
	buyPrice = 1500,
	sellPrice = 375,
	reqLevel = 70,
}
t[22055] = {
	name = L["Wound Poison V"],
	quality = 1,
	icon = "inv_misc_herb_16",
	buyPrice = 900,
	sellPrice = 225,
	reqLevel = 64,
}
t[22147] = {
	name = L["Flintweed Seed"],
	quality = 1,
	icon = "inv_misc_food_02",
	buyPrice = 5000,
	sellPrice = 1250,
	reqLevel = 0,
}
t[22148] = {
	name = L["Wild Quillvine"],
	quality = 1,
	icon = "inv_misc_root_01",
	buyPrice = 1500,
	sellPrice = 375,
	reqLevel = 0,
}
t[22900] = {
	name = L["Recipe: Elixir of Camouflage"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 30000,
	sellPrice = 7500,
	reqLevel = 0,
	profession = L["Alchemy"],
	teaches = L["Elixir of Camouflage"],
	learnedAt = 305,
}
t[37201] = {
	name = L["Corpse Dust"],
	quality = 1,
	icon = "inv_misc_dust_02",
	buyPrice = 500,
	sellPrice = 125,
	reqLevel = 0,
}
t[3713] = {
	name = L["Soothing Spices"],
	quality = 0,
	icon = "inv_misc_food_wheat_02",
	buyPrice = 160,
	sellPrice = 40,
	reqLevel = 0,
}
t[4470] = {
	name = L["Simple Wood"],
	quality = 1,
	icon = "inv_tradeskillitem_01",
	buyPrice = 38,
	sellPrice = 9,
	reqLevel = 0,
}
t[4471] = {
	name = L["Flint and Tinder"],
	quality = 0,
	icon = "inv_stone_11",
	buyPrice = 135,
	sellPrice = 33,
	reqLevel = 0,
}
t[6532] = {
	name = L["Bright Baubles"],
	quality = 1,
	icon = "inv_misc_gem_variety_02",
	buyPrice = 250,
	sellPrice = 62,
	reqLevel = 0,
}
t[10648] = {
	name = L["Common Parchment"],
	quality = 1,
	icon = "inv_inscription_parchment",
	buyPrice = 125,
	sellPrice = 31,
	reqLevel = 0,
}
t[11284] = {
	name = L["Accurate Slugs"],
	quality = 1,
	icon = "inv_ammo_bullet_01",
	buyPrice = 1000,
	sellPrice = 1,
	reqLevel = 40,
}
t[11285] = {
	name = L["Jagged Arrow"],
	quality = 1,
	icon = "inv_weapon_shortblade_25",
	buyPrice = 1000,
	sellPrice = 2,
	reqLevel = 40,
}
t[14341] = {
	name = L["Rune Thread"],
	quality = 1,
	icon = "spell_shadow_antimagicshell",
	buyPrice = 5000,
	sellPrice = 1250,
	reqLevel = 0,
}
t[28053] = {
	name = L["Wicked Arrow"],
	quality = 1,
	icon = "inv_misc_ammo_arrow_03",
	buyPrice = 1600,
	sellPrice = 2,
	reqLevel = 55,
}
t[28056] = {
	name = L["Blackflight Arrow"],
	quality = 1,
	icon = "inv_misc_ammo_arrow_01",
	buyPrice = 3000,
	sellPrice = 3,
	reqLevel = 65,
}
t[28060] = {
	name = L["Impact Shot"],
	quality = 1,
	icon = "inv_misc_ammo_bullet_02",
	buyPrice = 1600,
	sellPrice = 2,
	reqLevel = 55,
}
t[28061] = {
	name = L["Ironbite Shell"],
	quality = 1,
	icon = "inv_misc_ammo_bullet_06",
	buyPrice = 3000,
	sellPrice = 3,
	reqLevel = 65,
}
t[30744] = {
	name = L["Draenic Leather Pack"],
	quality = 2,
	icon = "inv_misc_bag_21",
	buyPrice = 120000,
	sellPrice = 30000,
	reqLevel = 0,
}
t[30745] = {
	name = L["Heavy Toolbox"],
	quality = 2,
	icon = "inv_box_02",
	buyPrice = 140000,
	sellPrice = 35000,
	reqLevel = 0,
}
t[30746] = {
	name = L["Mining Sack"],
	quality = 2,
	icon = "inv_misc_bag_10_blue",
	buyPrice = 100000,
	sellPrice = 25000,
	reqLevel = 0,
}
t[30747] = {
	name = L["Gem Pouch"],
	quality = 2,
	icon = "inv_misc_bag_06",
	buyPrice = 120000,
	sellPrice = 30000,
	reqLevel = 0,
}
t[30748] = {
	name = L["Enchanter's Satchel"],
	quality = 2,
	icon = "inv_misc_bag_07_blue",
	buyPrice = 140000,
	sellPrice = 35000,
	reqLevel = 0,
}
t[8953] = {
	name = L["Deep Fried Plantains"],
	quality = 1,
	icon = "inv_misc_food_23",
	buyPrice = 4000,
	sellPrice = 200,
	reqLevel = 45,
}
t[27856] = {
	name = L["Skethyl Berries"],
	quality = 1,
	icon = "inv_misc_food_93_skethylberries-",
	buyPrice = 5600,
	sellPrice = 280,
	reqLevel = 55,
}
t[29450] = {
	name = L["Telaari Grapes"],
	quality = 1,
	icon = "inv_misc_food_57",
	buyPrice = 8000,
	sellPrice = 400,
	reqLevel = 65,
}
t[29013] = {
	name = L["Jagged Throwing Axe"],
	quality = 1,
	icon = "inv_throwingaxe_01",
	buyPrice = 800,
	sellPrice = 200,
	reqLevel = 50,
}
t[29014] = {
	name = L["Blacksteel Throwing Dagger"],
	quality = 1,
	icon = "inv_weapon_shortblade_24",
	buyPrice = 800,
	sellPrice = 200,
	reqLevel = 50,
}
t[2928] = {
	name = L["Dust of Decay"],
	quality = 0,
	icon = "inv_misc_dust_02",
	buyPrice = 20,
	sellPrice = 5,
	reqLevel = 0,
}
t[2930] = {
	name = L["Essence of Pain"],
	quality = 0,
	icon = "inv_potion_12",
	buyPrice = 50,
	sellPrice = 12,
	reqLevel = 0,
}
t[3371] = {
	name = L["Empty Vial"],
	quality = 1,
	icon = "inv_drink_06",
	buyPrice = 20,
	sellPrice = 1,
	reqLevel = 0,
}
t[3372] = {
	name = L["Leaded Vial"],
	quality = 1,
	icon = "inv_alchemy_leadedvial",
	buyPrice = 200,
	sellPrice = 10,
	reqLevel = 0,
}
t[5060] = {
	name = L["Thieves' Tools"],
	quality = 1,
	icon = "inv_misc_gear_03",
	buyPrice = 1500,
	sellPrice = 0,
	reqLevel = 15,
}
t[17034] = {
	name = L["Maple Seed"],
	quality = 1,
	icon = "inv_misc_food_02",
	buyPrice = 200,
	sellPrice = 50,
	reqLevel = 0,
}
t[17035] = {
	name = L["Stranglethorn Seed"],
	quality = 1,
	icon = "inv_misc_food_02",
	buyPrice = 400,
	sellPrice = 100,
	reqLevel = 0,
}
t[17036] = {
	name = L["Ashwood Seed"],
	quality = 1,
	icon = "inv_misc_food_02",
	buyPrice = 800,
	sellPrice = 200,
	reqLevel = 0,
}
t[40411] = {
	name = L["Enchanted Vial"],
	quality = 1,
	icon = "inv_alchemy_enchantedvial",
	buyPrice = 50000,
	sellPrice = 2500,
	reqLevel = 0,
}
t[30637] = {
	name = L["Flamewrought Key"],
	quality = 1,
	icon = "inv_misc_key_13",
	buyPrice = 100000,
	sellPrice = 25000,
	reqLevel = 0,
}
t[24004] = {
	name = L["Thrallmar Tabard"],
	quality = 1,
	icon = "inv_shirt_guildtabard_01",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 0,
}
t[24000] = {
	name = L["Formula: Enchant Bracer - Superior Healing"],
	quality = 1,
	icon = "inv_misc_note_01",
	buyPrice = 60000,
	sellPrice = 15000,
	reqLevel = 0,
	profession = L["Enchanting"],
	teaches = L["Enchant Bracer - Superior Healing"],
	learnedAt = 325,
}
t[24001] = {
	name = L["Recipe: Elixir of Major Agility"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 50000,
	sellPrice = 12500,
	reqLevel = 0,
	profession = L["Alchemy"],
	teaches = L["Elixir of Major Agility"],
	learnedAt = 330,
}
t[24002] = {
	name = L["Plans: Felsteel Shield Spike"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 60000,
	sellPrice = 15000,
	reqLevel = 0,
	profession = L["Blacksmithing"],
	teaches = L["Felsteel Shield Spike"],
	learnedAt = 360,
}
t[24003] = {
	name = L["Formula: Enchant Chest - Exceptional Stats"],
	quality = 1,
	icon = "inv_misc_note_01",
	buyPrice = 60000,
	sellPrice = 15000,
	reqLevel = 0,
	profession = L["Enchanting"],
	teaches = L["Enchant Chest - Exceptional Stats"],
	learnedAt = 345,
}
t[24006] = {
	name = L["Grunt's Waterskin"],
	quality = 1,
	icon = "inv_drink_waterskin_05",
	buyPrice = 2000,
	sellPrice = 100,
	reqLevel = 45,
}
t[24009] = {
	name = L["Dried Fruit Rations"],
	quality = 1,
	icon = "inv_misc_food_42",
	buyPrice = 4500,
	sellPrice = 225,
	reqLevel = 55,
}
t[25738] = {
	name = L["Pattern: Felstalker Belt"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 120000,
	sellPrice = 30000,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Felstalker Belt"],
	learnedAt = 350,
}
t[25739] = {
	name = L["Pattern: Felstalker Bracers"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 160000,
	sellPrice = 40000,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Felstalker Bracer"],
	learnedAt = 360,
}
t[25740] = {
	name = L["Pattern: Felstalker Breastplate"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 160000,
	sellPrice = 40000,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Felstalker Breastplate"],
	learnedAt = 360,
}
t[25823] = {
	name = L["Grunt's Waraxe"],
	quality = 3,
	icon = "inv_axe_11",
	buyPrice = 347318,
	sellPrice = 69463,
	reqLevel = 60,
}
t[25824] = {
	name = L["Farseer's Band"],
	quality = 3,
	icon = "inv_jewelry_ring_17",
	buyPrice = 114780,
	sellPrice = 28695,
	reqLevel = 60,
}
t[29152] = {
	name = L["Marksman's Bow"],
	quality = 4,
	icon = "inv_weapon_bow_08",
	buyPrice = 1599984,
	sellPrice = 319996,
	reqLevel = 70,
}
t[29155] = {
	name = L["Stormcaller"],
	quality = 4,
	icon = "inv_sword_01",
	buyPrice = 2156059,
	sellPrice = 431211,
	reqLevel = 70,
}
t[29165] = {
	name = L["Warbringer"],
	quality = 4,
	icon = "inv_axe_10",
	buyPrice = 2079958,
	sellPrice = 415991,
	reqLevel = 70,
}
t[29167] = {
	name = L["Blackened Spear"],
	quality = 3,
	icon = "inv_spear_03",
	buyPrice = 557054,
	sellPrice = 111410,
	reqLevel = 70,
}
t[29168] = {
	name = L["Ancestral Band"],
	quality = 3,
	icon = "inv_jewelry_ring_22",
	buyPrice = 175952,
	sellPrice = 43988,
	reqLevel = 70,
}
t[29190] = {
	name = L["Arcanum of Renewal"],
	quality = 2,
	icon = "spell_holy_healingaura",
	buyPrice = 1000000,
	sellPrice = 250000,
	reqLevel = 70,
}
t[29197] = {
	name = L["Arcanum of Fire Warding"],
	quality = 2,
	icon = "spell_fire_sealoffire",
	buyPrice = 1000000,
	sellPrice = 250000,
	reqLevel = 70,
}
t[29232] = {
	name = L["Recipe: Transmute Skyfire Diamond"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 80000,
	sellPrice = 20000,
	reqLevel = 0,
	profession = L["Alchemy"],
	teaches = L["Transmute: Skyfire Diamond"],
	learnedAt = 350,
}
t[31358] = {
	name = L["Design: Dawnstone Crab"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 120000,
	sellPrice = 30000,
	reqLevel = 0,
}
t[31359] = {
	name = L["Design: Enduring Deep Peridot"],
	quality = 2,
	icon = "inv_scroll_06",
	buyPrice = 60000,
	sellPrice = 15000,
	reqLevel = 0,
}
t[31361] = {
	name = L["Pattern: Cobrahide Leg Armor"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 60000,
	sellPrice = 15000,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Cobrahide Leg Armor"],
	learnedAt = 335,
}
t[31362] = {
	name = L["Pattern: Nethercobra Leg Armor"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 120000,
	sellPrice = 30000,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Nethercobra Leg Armor"],
	learnedAt = 365,
}
t[32882] = {
	name = L["Hellfire Shot"],
	quality = 3,
	icon = "inv_misc_ammo_bullet_02",
	buyPrice = 5000,
	sellPrice = 6,
	reqLevel = 68,
}
t[33151] = {
	name = L["Formula: Enchant Cloak - Subtlety"],
	quality = 3,
	icon = "inv_misc_note_01",
	buyPrice = 100000,
	sellPrice = 25000,
	reqLevel = 0,
	profession = L["Enchanting"],
	teaches = L["Enchant Cloak - Subtlety"],
	learnedAt = 300,
}
t[34201] = {
	name = L["Pattern: Netherscale Ammo Pouch"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 160000,
	sellPrice = 40000,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Netherscale Ammo Pouch"],
	learnedAt = 350,
}
t[35332] = {
	name = L["Dreadweave Robe"],
	quality = 3,
	icon = "inv_chest_cloth_43",
	buyPrice = 176497,
	sellPrice = 35299,
	reqLevel = 70,
}
t[35337] = {
	name = L["Mooncloth Vestments"],
	quality = 3,
	icon = "inv_chest_cloth_43",
	buyPrice = 179717,
	sellPrice = 35943,
	reqLevel = 70,
}
t[35339] = {
	name = L["Satin Hood"],
	quality = 3,
	icon = "inv_helmet_30",
	buyPrice = 135764,
	sellPrice = 27152,
	reqLevel = 70,
}
t[35343] = {
	name = L["Evoker's Silk Amice"],
	quality = 3,
	icon = "inv_shoulder_19",
	buyPrice = 137704,
	sellPrice = 27540,
	reqLevel = 70,
}
t[35360] = {
	name = L["Dragonhide Robe"],
	quality = 3,
	icon = "inv_chest_leather_03",
	buyPrice = 210856,
	sellPrice = 42171,
	reqLevel = 70,
}
t[35364] = {
	name = L["Kodohide Spaulders"],
	quality = 3,
	icon = "inv_shoulder_12",
	buyPrice = 160567,
	sellPrice = 32113,
	reqLevel = 70,
}
t[35366] = {
	name = L["Opportunist's Leather Gloves"],
	quality = 3,
	icon = "inv_gauntlets_28",
	buyPrice = 107858,
	sellPrice = 21571,
	reqLevel = 70,
}
t[35371] = {
	name = L["Wyrmhide Gloves"],
	quality = 3,
	icon = "inv_gauntlets_28",
	buyPrice = 109871,
	sellPrice = 21974,
	reqLevel = 70,
}
t[35377] = {
	name = L["Stalker's Chain Gauntlets"],
	quality = 3,
	icon = "inv_gauntlets_11",
	buyPrice = 138258,
	sellPrice = 27651,
	reqLevel = 70,
}
t[35383] = {
	name = L["Seer's Linked Helm"],
	quality = 3,
	icon = "inv_helmet_09",
	buyPrice = 191928,
	sellPrice = 38385,
	reqLevel = 70,
}
t[35386] = {
	name = L["Seer's Mail Armor"],
	quality = 3,
	icon = "inv_chest_chain_11",
	buyPrice = 258808,
	sellPrice = 51761,
	reqLevel = 70,
}
t[35392] = {
	name = L["Seer's Ringmail Gloves"],
	quality = 3,
	icon = "inv_gauntlets_11",
	buyPrice = 132320,
	sellPrice = 26464,
	reqLevel = 70,
}
t[35406] = {
	name = L["Crusader's Ornamented Spaulders"],
	quality = 3,
	icon = "inv_shoulder_22",
	buyPrice = 226002,
	sellPrice = 45200,
	reqLevel = 70,
}
t[35409] = {
	name = L["Savage Plate Helm"],
	quality = 3,
	icon = "inv_helmet_22",
	buyPrice = 234646,
	sellPrice = 46929,
	reqLevel = 70,
}
t[35413] = {
	name = L["Crusader's Scaled Gauntlets"],
	quality = 3,
	icon = "inv_gauntlets_29",
	buyPrice = 159901,
	sellPrice = 31980,
	reqLevel = 70,
}
t[185686] = {
	name = L["Flamewrought Key"],
	quality = 1,
	icon = "inv_misc_key_13",
	buyPrice = 100000,
	sellPrice = 25000,
	reqLevel = 0,
}
t[23999] = {
	name = L["Honor Hold Tabard"],
	quality = 1,
	icon = "inv_shirt_guildtabard_01",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 0,
}
t[22531] = {
	name = L["Formula: Enchant Bracer - Superior Healing"],
	quality = 1,
	icon = "inv_misc_note_01",
	buyPrice = 60000,
	sellPrice = 15000,
	reqLevel = 0,
	profession = L["Enchanting"],
	teaches = L["Enchant Bracer - Superior Healing"],
	learnedAt = 325,
}
t[22547] = {
	name = L["Formula: Enchant Chest - Exceptional Stats"],
	quality = 1,
	icon = "inv_misc_note_01",
	buyPrice = 60000,
	sellPrice = 15000,
	reqLevel = 0,
	profession = L["Enchanting"],
	teaches = L["Enchant Chest - Exceptional Stats"],
	learnedAt = 345,
}
t[22905] = {
	name = L["Recipe: Elixir of Major Agility"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 50000,
	sellPrice = 12500,
	reqLevel = 0,
	profession = L["Alchemy"],
	teaches = L["Elixir of Major Agility"],
	learnedAt = 330,
}
t[23142] = {
	name = L["Design: Enduring Deep Peridot"],
	quality = 2,
	icon = "inv_scroll_06",
	buyPrice = 60000,
	sellPrice = 15000,
	reqLevel = 0,
}
t[23619] = {
	name = L["Plans: Felsteel Shield Spike"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 60000,
	sellPrice = 15000,
	reqLevel = 0,
	profession = L["Blacksmithing"],
	teaches = L["Felsteel Shield Spike"],
	learnedAt = 360,
}
t[24007] = {
	name = L["Footman's Waterskin"],
	quality = 1,
	icon = "inv_drink_waterskin_05",
	buyPrice = 2000,
	sellPrice = 100,
	reqLevel = 55,
}
t[24008] = {
	name = L["Dried Mushroom Rations"],
	quality = 1,
	icon = "inv_mushroom_01",
	buyPrice = 4500,
	sellPrice = 225,
	reqLevel = 55,
}
t[24180] = {
	name = L["Design: Dawnstone Crab"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 120000,
	sellPrice = 30000,
	reqLevel = 0,
}
t[25825] = {
	name = L["Footman's Longsword"],
	quality = 3,
	icon = "inv_sword_20",
	buyPrice = 349801,
	sellPrice = 69960,
	reqLevel = 60,
}
t[25826] = {
	name = L["Sage's Band"],
	quality = 3,
	icon = "inv_jewelry_ring_11",
	buyPrice = 114780,
	sellPrice = 28695,
	reqLevel = 60,
}
t[25870] = {
	name = L["Recipe: Transmute Skyfire Diamond"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 80000,
	sellPrice = 20000,
	reqLevel = 0,
	profession = L["Alchemy"],
	teaches = L["Transmute: Skyfire Diamond"],
	learnedAt = 350,
}
t[29151] = {
	name = L["Veteran's Musket"],
	quality = 4,
	icon = "inv_weapon_rifle_02",
	buyPrice = 1594245,
	sellPrice = 318849,
	reqLevel = 70,
}
t[29153] = {
	name = L["Blade of the Archmage"],
	quality = 4,
	icon = "inv_weapon_shortblade_37",
	buyPrice = 2140963,
	sellPrice = 428192,
	reqLevel = 70,
}
t[29156] = {
	name = L["Honor's Call"],
	quality = 4,
	icon = "inv_sword_11",
	buyPrice = 2011508,
	sellPrice = 402301,
	reqLevel = 70,
}
t[29166] = {
	name = L["Hellforged Halberd"],
	quality = 3,
	icon = "inv_weapon_halberd_12",
	buyPrice = 555019,
	sellPrice = 111003,
	reqLevel = 70,
}
t[29169] = {
	name = L["Ring of Convalescence"],
	quality = 3,
	icon = "inv_jewelry_ring_43",
	buyPrice = 175952,
	sellPrice = 43988,
	reqLevel = 70,
}
t[29189] = {
	name = L["Arcanum of Renewal"],
	quality = 2,
	icon = "spell_holy_healingaura",
	buyPrice = 1000000,
	sellPrice = 250000,
	reqLevel = 70,
}
t[29196] = {
	name = L["Arcanum of Fire Warding"],
	quality = 2,
	icon = "spell_fire_sealoffire",
	buyPrice = 1000000,
	sellPrice = 250000,
	reqLevel = 70,
}
t[29213] = {
	name = L["Pattern: Felstalker Belt"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 120000,
	sellPrice = 30000,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Felstalker Belt"],
	learnedAt = 350,
}
t[29214] = {
	name = L["Pattern: Felstalker Bracers"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 160000,
	sellPrice = 40000,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Felstalker Bracer"],
	learnedAt = 360,
}
t[29215] = {
	name = L["Pattern: Felstalker Breastplate"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 160000,
	sellPrice = 40000,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Felstalker Breastplate"],
	learnedAt = 360,
}
t[29719] = {
	name = L["Pattern: Cobrahide Leg Armor"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 60000,
	sellPrice = 15000,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Cobrahide Leg Armor"],
	learnedAt = 335,
}
t[29722] = {
	name = L["Pattern: Nethercobra Leg Armor"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 120000,
	sellPrice = 30000,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Nethercobra Leg Armor"],
	learnedAt = 365,
}
t[30622] = {
	name = L["Flamewrought Key"],
	quality = 1,
	icon = "inv_misc_key_13",
	buyPrice = 100000,
	sellPrice = 25000,
	reqLevel = 0,
}
t[32883] = {
	name = L["Felbane Slugs"],
	quality = 3,
	icon = "inv_misc_ammo_bullet_02",
	buyPrice = 5000,
	sellPrice = 6,
	reqLevel = 68,
}
t[33150] = {
	name = L["Formula: Enchant Cloak - Subtlety"],
	quality = 3,
	icon = "inv_misc_note_01",
	buyPrice = 100000,
	sellPrice = 25000,
	reqLevel = 0,
	profession = L["Enchanting"],
	teaches = L["Enchant Cloak - Subtlety"],
	learnedAt = 300,
}
t[34218] = {
	name = L["Pattern: Netherscale Ammo Pouch"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 160000,
	sellPrice = 40000,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Netherscale Ammo Pouch"],
	learnedAt = 350,
}
t[35464] = {
	name = L["Dreadweave Robe"],
	quality = 3,
	icon = "inv_chest_cloth_43",
	buyPrice = 175829,
	sellPrice = 35165,
	reqLevel = 70,
}
t[35465] = {
	name = L["Evoker's Silk Amice"],
	quality = 3,
	icon = "inv_shoulder_19",
	buyPrice = 132346,
	sellPrice = 26469,
	reqLevel = 70,
}
t[35466] = {
	name = L["Satin Hood"],
	quality = 3,
	icon = "inv_helmet_30",
	buyPrice = 132835,
	sellPrice = 26567,
	reqLevel = 70,
}
t[35467] = {
	name = L["Mooncloth Vestments"],
	quality = 3,
	icon = "inv_chest_cloth_43",
	buyPrice = 177764,
	sellPrice = 35552,
	reqLevel = 70,
}
t[35468] = {
	name = L["Opportunist's Leather Gloves"],
	quality = 3,
	icon = "inv_gauntlets_28",
	buyPrice = 111509,
	sellPrice = 22301,
	reqLevel = 70,
}
t[35469] = {
	name = L["Dragonhide Robe"],
	quality = 3,
	icon = "inv_chest_leather_03",
	buyPrice = 223811,
	sellPrice = 44762,
	reqLevel = 70,
}
t[35470] = {
	name = L["Kodohide Spaulders"],
	quality = 3,
	icon = "inv_shoulder_12",
	buyPrice = 168468,
	sellPrice = 33693,
	reqLevel = 70,
}
t[35471] = {
	name = L["Wyrmhide Gloves"],
	quality = 3,
	icon = "inv_gauntlets_28",
	buyPrice = 112719,
	sellPrice = 22543,
	reqLevel = 70,
}
t[35472] = {
	name = L["Seer's Mail Armor"],
	quality = 3,
	icon = "inv_chest_chain_11",
	buyPrice = 271476,
	sellPrice = 54295,
	reqLevel = 70,
}
t[35473] = {
	name = L["Seer's Ringmail Gloves"],
	quality = 3,
	icon = "inv_gauntlets_11",
	buyPrice = 126514,
	sellPrice = 25302,
	reqLevel = 70,
}
t[35474] = {
	name = L["Seer's Linked Helm"],
	quality = 3,
	icon = "inv_helmet_09",
	buyPrice = 190503,
	sellPrice = 38100,
	reqLevel = 70,
}
t[35475] = {
	name = L["Stalker's Chain Gauntlets"],
	quality = 3,
	icon = "inv_gauntlets_11",
	buyPrice = 127490,
	sellPrice = 25498,
	reqLevel = 70,
}
t[35476] = {
	name = L["Crusader's Ornamented Spaulders"],
	quality = 3,
	icon = "inv_shoulder_22",
	buyPrice = 223513,
	sellPrice = 44702,
	reqLevel = 70,
}
t[35477] = {
	name = L["Crusader's Scaled Gauntlets"],
	quality = 3,
	icon = "inv_gauntlets_29",
	buyPrice = 150719,
	sellPrice = 30143,
	reqLevel = 70,
}
t[35478] = {
	name = L["Savage Plate Helm"],
	quality = 3,
	icon = "inv_helmet_22",
	buyPrice = 225219,
	sellPrice = 45043,
	reqLevel = 70,
}
t[185687] = {
	name = L["Flamewrought Key"],
	quality = 1,
	icon = "inv_misc_key_13",
	buyPrice = 100000,
	sellPrice = 25000,
	reqLevel = 0,
}
t[24520] = {
	name = L["Honor Hold Favor"],
	quality = 1,
	icon = "inv_banner_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 1,
}
t[27809] = {
	name = L["Barbed Deep Peridot"],
	quality = 3,
	icon = "inv_misc_gem_deepperidot_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[27812] = {
	name = L["Stark Blood Garnet"],
	quality = 3,
	icon = "inv_misc_gem_ruby_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[27820] = {
	name = L["Notched Deep Peridot"],
	quality = 3,
	icon = "inv_misc_gem_deepperidot_03",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[27833] = {
	name = L["Band of the Victor"],
	quality = 3,
	icon = "inv_jewelry_ring_36",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[27834] = {
	name = L["Circlet of the Victor"],
	quality = 3,
	icon = "inv_jewelry_ring_36",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[28361] = {
	name = L["Mighty Blood Garnet"],
	quality = 3,
	icon = "inv_misc_gem_bloodstone_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[31799] = {
	name = L["Fei Fei Doggy Treat"],
	quality = 1,
	icon = "ability_hunter_beasttraining",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[24522] = {
	name = L["Thrallmar Favor"],
	quality = 1,
	icon = "racial_orc_berserkerstrength",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 1,
}
t[27777] = {
	name = L["Stark Blood Garnet"],
	quality = 3,
	icon = "inv_misc_gem_ruby_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[27785] = {
	name = L["Notched Deep Peridot"],
	quality = 3,
	icon = "inv_misc_gem_deepperidot_03",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[27786] = {
	name = L["Barbed Deep Peridot"],
	quality = 3,
	icon = "inv_misc_gem_deepperidot_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[27830] = {
	name = L["Circlet of the Victor"],
	quality = 3,
	icon = "inv_jewelry_ring_36",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[27832] = {
	name = L["Band of the Victor"],
	quality = 3,
	icon = "inv_jewelry_ring_36",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[28360] = {
	name = L["Mighty Blood Garnet"],
	quality = 3,
	icon = "inv_misc_gem_bloodstone_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[2320] = {
	name = L["Coarse Thread"],
	quality = 1,
	icon = "inv_fabric_linen_03",
	buyPrice = 10,
	sellPrice = 2,
	reqLevel = 0,
}
t[2604] = {
	name = L["Red Dye"],
	quality = 1,
	icon = "inv_potion_11",
	buyPrice = 50,
	sellPrice = 12,
	reqLevel = 0,
}
t[2324] = {
	name = L["Bleach"],
	quality = 1,
	icon = "inv_drink_12",
	buyPrice = 25,
	sellPrice = 6,
	reqLevel = 0,
}
t[6260] = {
	name = L["Blue Dye"],
	quality = 1,
	icon = "inv_potion_15",
	buyPrice = 50,
	sellPrice = 12,
	reqLevel = 0,
}
t[2321] = {
	name = L["Fine Thread"],
	quality = 1,
	icon = "inv_fabric_wool_02",
	buyPrice = 100,
	sellPrice = 25,
	reqLevel = 0,
}
t[2605] = {
	name = L["Green Dye"],
	quality = 1,
	icon = "inv_potion_12",
	buyPrice = 100,
	sellPrice = 25,
	reqLevel = 0,
}
t[4340] = {
	name = L["Gray Dye"],
	quality = 1,
	icon = "inv_drink_10",
	buyPrice = 350,
	sellPrice = 87,
	reqLevel = 0,
}
t[4291] = {
	name = L["Silken Thread"],
	quality = 1,
	icon = "inv_fabric_silk_02",
	buyPrice = 500,
	sellPrice = 125,
	reqLevel = 0,
}
t[8343] = {
	name = L["Heavy Silken Thread"],
	quality = 1,
	icon = "inv_fabric_silk_02",
	buyPrice = 2000,
	sellPrice = 500,
	reqLevel = 0,
}
t[6261] = {
	name = L["Orange Dye"],
	quality = 1,
	icon = "inv_potion_35",
	buyPrice = 1000,
	sellPrice = 250,
	reqLevel = 0,
}
t[2325] = {
	name = L["Black Dye"],
	quality = 1,
	icon = "inv_potion_63",
	buyPrice = 1000,
	sellPrice = 250,
	reqLevel = 0,
}
t[4341] = {
	name = L["Yellow Dye"],
	quality = 1,
	icon = "inv_potion_12",
	buyPrice = 500,
	sellPrice = 125,
	reqLevel = 0,
}
t[4342] = {
	name = L["Purple Dye"],
	quality = 1,
	icon = "inv_potion_02",
	buyPrice = 2500,
	sellPrice = 625,
	reqLevel = 0,
}
t[10290] = {
	name = L["Pink Dye"],
	quality = 1,
	icon = "inv_potion_09",
	buyPrice = 2500,
	sellPrice = 625,
	reqLevel = 0,
}
t[38426] = {
	name = L["Eternium Thread"],
	quality = 1,
	icon = "inv_misc_thread_01",
	buyPrice = 30000,
	sellPrice = 7500,
	reqLevel = 0,
}
t[20815] = {
	name = L["Jeweler's Kit"],
	quality = 1,
	icon = "inv_box_02",
	buyPrice = 800,
	sellPrice = 200,
	reqLevel = 1,
}
t[20824] = {
	name = L["Simple Grinder"],
	quality = 1,
	icon = "inv_stone_grindingstone_01",
	buyPrice = 25000,
	sellPrice = 6250,
	reqLevel = 1,
}
t[23130] = {
	name = L["Design: Teardrop Blood Garnet"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 40000,
	sellPrice = 10000,
	reqLevel = 0,
}
t[23131] = {
	name = L["Design: Bold Blood Garnet"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 50000,
	sellPrice = 12500,
	reqLevel = 0,
}
t[23135] = {
	name = L["Design: Inscribed Flame Spessarite"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 40000,
	sellPrice = 10000,
	reqLevel = 0,
}
t[23137] = {
	name = L["Design: Glinting Flame Spessarite"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 60000,
	sellPrice = 15000,
	reqLevel = 0,
}
t[23140] = {
	name = L["Design: Radiant Deep Peridot"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 40000,
	sellPrice = 10000,
	reqLevel = 0,
}
t[23141] = {
	name = L["Design: Jagged Deep Peridot"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 50000,
	sellPrice = 12500,
	reqLevel = 0,
}
t[23144] = {
	name = L["Design: Glowing Shadow Draenite"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 40000,
	sellPrice = 10000,
	reqLevel = 0,
}
t[23147] = {
	name = L["Design: Sovereign Shadow Draenite"],
	quality = 2,
	icon = "inv_scroll_06",
	buyPrice = 60000,
	sellPrice = 15000,
	reqLevel = 0,
}
t[23148] = {
	name = L["Design: Brilliant Golden Draenite"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 40000,
	sellPrice = 10000,
	reqLevel = 0,
}
t[23151] = {
	name = L["Design: Rigid Golden Draenite"],
	quality = 2,
	icon = "inv_scroll_06",
	buyPrice = 60000,
	sellPrice = 15000,
	reqLevel = 0,
}
t[23152] = {
	name = L["Design: Solid Azure Moonstone"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 40000,
	sellPrice = 10000,
	reqLevel = 0,
}
t[23153] = {
	name = L["Design: Sparkling Azure Moonstone"],
	quality = 2,
	icon = "inv_scroll_06",
	buyPrice = 50000,
	sellPrice = 12500,
	reqLevel = 0,
}
t[28291] = {
	name = L["Design: Smooth Golden Draenite"],
	quality = 2,
	icon = "inv_scroll_06",
	buyPrice = 60000,
	sellPrice = 15000,
	reqLevel = 0,
}
t[28596] = {
	name = L["Design: Bright Blood Garnet"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 50000,
	sellPrice = 12500,
	reqLevel = 0,
}
t[4357] = {
	name = L["Rough Blasting Powder"],
	quality = 1,
	icon = "inv_misc_dust_01",
	buyPrice = 16,
	sellPrice = 4,
	reqLevel = 0,
}
t[4361] = {
	name = L["Copper Tube"],
	quality = 1,
	icon = "inv_gizmo_pipe_02",
	buyPrice = 480,
	sellPrice = 120,
	reqLevel = 0,
}
t[4399] = {
	name = L["Wooden Stock"],
	quality = 1,
	icon = "inv_mace_11",
	buyPrice = 200,
	sellPrice = 50,
	reqLevel = 0,
}
t[4363] = {
	name = L["Copper Modulator"],
	quality = 1,
	icon = "inv_gizmo_03",
	buyPrice = 200,
	sellPrice = 50,
	reqLevel = 0,
}
t[4364] = {
	name = L["Coarse Blasting Powder"],
	quality = 1,
	icon = "inv_misc_dust_02",
	buyPrice = 48,
	sellPrice = 12,
	reqLevel = 0,
}
t[4404] = {
	name = L["Silver Contact"],
	quality = 1,
	icon = "inv_ingot_04",
	buyPrice = 100,
	sellPrice = 25,
	reqLevel = 0,
}
t[4371] = {
	name = L["Bronze Tube"],
	quality = 1,
	icon = "inv_gizmo_pipe_01",
	buyPrice = 800,
	sellPrice = 200,
	reqLevel = 0,
}
t[4400] = {
	name = L["Heavy Stock"],
	quality = 1,
	icon = "inv_mace_11",
	buyPrice = 2000,
	sellPrice = 500,
	reqLevel = 0,
}
t[4382] = {
	name = L["Bronze Framework"],
	quality = 1,
	icon = "inv_gizmo_bronzeframework_01",
	buyPrice = 2400,
	sellPrice = 600,
	reqLevel = 0,
}
t[4389] = {
	name = L["Gyrochronatom"],
	quality = 1,
	icon = "inv_misc_pocketwatch_02",
	buyPrice = 3000,
	sellPrice = 750,
	reqLevel = 0,
}
t[10647] = {
	name = L["Engineer's Ink"],
	quality = 1,
	icon = "inv_potion_65",
	buyPrice = 2000,
	sellPrice = 500,
	reqLevel = 0,
}
t[39684] = {
	name = L["Hair Trigger"],
	quality = 1,
	icon = "inv_misc_enggizmos_25",
	buyPrice = 9000,
	sellPrice = 2250,
	reqLevel = 0,
}
t[40533] = {
	name = L["Walnut Stock"],
	quality = 1,
	icon = "inv_mace_11",
	buyPrice = 50000,
	sellPrice = 12500,
	reqLevel = 0,
}
t[10940] = {
	name = L["Strange Dust"],
	quality = 1,
	icon = "inv_enchant_duststrange",
	buyPrice = 800,
	sellPrice = 0,
	reqLevel = 0,
}
t[10938] = {
	name = L["Lesser Magic Essence"],
	quality = 2,
	icon = "inv_enchant_essencemagicsmall",
	buyPrice = 800,
	sellPrice = 0,
	reqLevel = 0,
}
t[11291] = {
	name = L["Star Wood"],
	quality = 1,
	icon = "inv_tradeskillitem_03",
	buyPrice = 4500,
	sellPrice = 1125,
	reqLevel = 0,
}
t[6217] = {
	name = L["Copper Rod"],
	quality = 1,
	icon = "inv_misc_flute_01",
	buyPrice = 124,
	sellPrice = 24,
	reqLevel = 0,
}
t[6342] = {
	name = L["Formula: Enchant Chest - Minor Mana"],
	quality = 2,
	icon = "inv_misc_note_01",
	buyPrice = 300,
	sellPrice = 75,
	reqLevel = 0,
	profession = L["Enchanting"],
	teaches = L["Enchant Chest - Minor Mana"],
	learnedAt = 20,
}
t[20752] = {
	name = L["Formula: Minor Mana Oil"],
	quality = 1,
	icon = "inv_misc_note_01",
	buyPrice = 3000,
	sellPrice = 750,
	reqLevel = 0,
	profession = L["Enchanting"],
	teaches = L["Minor Mana Oil"],
	learnedAt = 150,
}
t[20753] = {
	name = L["Formula: Lesser Wizard Oil"],
	quality = 1,
	icon = "inv_misc_note_01",
	buyPrice = 4000,
	sellPrice = 1000,
	reqLevel = 0,
	profession = L["Enchanting"],
	teaches = L["Lesser Wizard Oil"],
	learnedAt = 200,
}
t[20758] = {
	name = L["Formula: Minor Wizard Oil"],
	quality = 1,
	icon = "inv_misc_note_01",
	buyPrice = 500,
	sellPrice = 125,
	reqLevel = 0,
	profession = L["Enchanting"],
	teaches = L["Minor Wizard Oil"],
	learnedAt = 45,
}
t[22307] = {
	name = L["Pattern: Enchanted Mageweave Pouch"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 6000,
	sellPrice = 1500,
	reqLevel = 0,
	profession = L["Tailoring"],
	teaches = L["Enchanted Mageweave Pouch"],
	learnedAt = 225,
}
t[4289] = {
	name = L["Salt"],
	quality = 1,
	icon = "inv_misc_dust_02",
	buyPrice = 50,
	sellPrice = 12,
	reqLevel = 0,
}
t[7005] = {
	name = L["Skinning Knife"],
	quality = 1,
	icon = "inv_weapon_shortblade_01",
	buyPrice = 82,
	sellPrice = 16,
	reqLevel = 1,
}
t[23803] = {
	name = L["Schematic: Cogspinner Goggles"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 60000,
	sellPrice = 15000,
	reqLevel = 0,
	profession = L["Engineering"],
	teaches = L["Cogspinner Goggles"],
	learnedAt = 340,
}
t[23805] = {
	name = L["Schematic: Ultra-Spectropic Detection Goggles"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 80000,
	sellPrice = 20000,
	reqLevel = 0,
	profession = L["Engineering"],
	teaches = L["Ultra-Spectropic Detection Goggles"],
	learnedAt = 350,
}
t[3928] = {
	name = L["Superior Healing Potion"],
	quality = 1,
	icon = "inv_potion_53",
	buyPrice = 1000,
	sellPrice = 250,
	reqLevel = 35,
}
t[6149] = {
	name = L["Greater Mana Potion"],
	quality = 1,
	icon = "inv_potion_73",
	buyPrice = 1200,
	sellPrice = 300,
	reqLevel = 31,
}
t[159] = {
	name = L["Refreshing Spring Water"],
	quality = 1,
	icon = "inv_drink_07",
	buyPrice = 25,
	sellPrice = 1,
	reqLevel = 1,
}
t[30817] = {
	name = L["Simple Flour"],
	quality = 1,
	icon = "inv_misc_food_wheat_01",
	buyPrice = 25,
	sellPrice = 1,
	reqLevel = 0,
}
t[2678] = {
	name = L["Mild Spices"],
	quality = 1,
	icon = "inv_misc_food_wheat_02",
	buyPrice = 10,
	sellPrice = 0,
	reqLevel = 0,
}
t[2692] = {
	name = L["Hot Spices"],
	quality = 0,
	icon = "inv_misc_food_wheat_02",
	buyPrice = 40,
	sellPrice = 10,
	reqLevel = 0,
}
t[27736] = {
	name = L["Master Cookbook"],
	quality = 1,
	icon = "inv_misc_book_10",
	buyPrice = 20000,
	sellPrice = 5000,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Cooking"],
	learnedAt = 300,
}
t[21992] = {
	name = L["Manual: Netherweave Bandage"],
	quality = 1,
	icon = "inv_misc_book_03",
	buyPrice = 20000,
	sellPrice = 5000,
	reqLevel = 0,
	profession = L["First Aid"],
	teaches = L["Netherweave Bandage"],
	learnedAt = 330,
}
t[21993] = {
	name = L["Manual: Heavy Netherweave Bandage"],
	quality = 1,
	icon = "inv_misc_book_03",
	buyPrice = 40000,
	sellPrice = 10000,
	reqLevel = 0,
	profession = L["First Aid"],
	teaches = L["Heavy Netherweave Bandage"],
	learnedAt = 360,
}
t[22012] = {
	name = L["Master First Aid - Doctor in the House"],
	quality = 1,
	icon = "inv_misc_book_10",
	buyPrice = 50000,
	sellPrice = 12500,
	reqLevel = 0,
	profession = L["First Aid"],
	teaches = L["First Aid"],
	learnedAt = 300,
}
t[30749] = {
	name = L["Draenic Sparring Blade"],
	quality = 1,
	icon = "inv_sword_draenei_01",
	buyPrice = 145540,
	sellPrice = 29108,
	reqLevel = 60,
}
t[30750] = {
	name = L["Draenic Warblade"],
	quality = 1,
	icon = "inv_sword_draenei_08",
	buyPrice = 189372,
	sellPrice = 37874,
	reqLevel = 60,
}
t[30751] = {
	name = L["Mag'hari Light Axe"],
	quality = 1,
	icon = "inv_axe_17",
	buyPrice = 148381,
	sellPrice = 29676,
	reqLevel = 60,
}
t[30752] = {
	name = L["Mag'hari Battleaxe"],
	quality = 1,
	icon = "inv_axe_20",
	buyPrice = 168397,
	sellPrice = 33679,
	reqLevel = 60,
}
t[30753] = {
	name = L["Warphorn Spear"],
	quality = 2,
	icon = "inv_spear_05",
	buyPrice = 326668,
	sellPrice = 65333,
	reqLevel = 60,
}
t[30754] = {
	name = L["Ancient Bone Mace"],
	quality = 1,
	icon = "spell_shadow_shadowward",
	buyPrice = 137417,
	sellPrice = 27483,
	reqLevel = 60,
}
t[30755] = {
	name = L["Mag'hari Fighting Claw"],
	quality = 2,
	icon = "inv_misc_monsterclaw_04",
	buyPrice = 254979,
	sellPrice = 50995,
	reqLevel = 60,
}
t[25848] = {
	name = L["Formula: Runed Adamantite Rod"],
	quality = 1,
	icon = "inv_misc_note_01",
	buyPrice = 100000,
	sellPrice = 25000,
	reqLevel = 0,
	profession = L["Enchanting"],
	teaches = L["Runed Adamantite Rod"],
	learnedAt = 350,
}
t[8950] = {
	name = L["Homemade Cherry Pie"],
	quality = 1,
	icon = "inv_misc_food_10",
	buyPrice = 4000,
	sellPrice = 200,
	reqLevel = 45,
}
t[27855] = {
	name = L["Mag'har Grainbread"],
	quality = 1,
	icon = "inv_misc_food_95_grainbread",
	buyPrice = 5600,
	sellPrice = 280,
	reqLevel = 55,
}
t[29449] = {
	name = L["Bladespire Bagel"],
	quality = 1,
	icon = "inv_misc_food_34",
	buyPrice = 8000,
	sellPrice = 400,
	reqLevel = 65,
}
t[4496] = {
	name = L["Small Brown Pouch"],
	quality = 1,
	icon = "inv_misc_bag_09",
	buyPrice = 500,
	sellPrice = 125,
	reqLevel = 0,
}
t[4497] = {
	name = L["Heavy Brown Bag"],
	quality = 1,
	icon = "inv_misc_bag_10",
	buyPrice = 20000,
	sellPrice = 5000,
	reqLevel = 0,
}
t[4498] = {
	name = L["Brown Leather Satchel"],
	quality = 1,
	icon = "inv_misc_bag_09",
	buyPrice = 2500,
	sellPrice = 625,
	reqLevel = 0,
}
t[2512] = {
	name = L["Rough Arrow"],
	quality = 1,
	icon = "inv_ammo_arrow_02",
	buyPrice = 10,
	sellPrice = 0,
	reqLevel = 1,
}
t[2515] = {
	name = L["Sharp Arrow"],
	quality = 1,
	icon = "inv_ammo_arrow_02",
	buyPrice = 50,
	sellPrice = 0,
	reqLevel = 10,
}
t[3026] = {
	name = L["Reinforced Bow"],
	quality = 1,
	icon = "inv_weapon_bow_02",
	buyPrice = 3812,
	sellPrice = 762,
	reqLevel = 16,
}
t[3027] = {
	name = L["Heavy Recurve Bow"],
	quality = 1,
	icon = "inv_weapon_bow_01",
	buyPrice = 6349,
	sellPrice = 1269,
	reqLevel = 20,
}
t[3030] = {
	name = L["Razor Arrow"],
	quality = 1,
	icon = "inv_ammo_arrow_02",
	buyPrice = 300,
	sellPrice = 0,
	reqLevel = 25,
}
t[5439] = {
	name = L["Small Quiver"],
	quality = 1,
	icon = "inv_misc_quiver_09",
	buyPrice = 100,
	sellPrice = 25,
	reqLevel = 1,
}
t[11362] = {
	name = L["Medium Quiver"],
	quality = 1,
	icon = "inv_misc_quiver_10",
	buyPrice = 1000,
	sellPrice = 250,
	reqLevel = 10,
}
t[3025] = {
	name = L["BKP 42 \"Ultra\""],
	quality = 1,
	icon = "inv_weapon_rifle_03",
	buyPrice = 18479,
	sellPrice = 3695,
	reqLevel = 31,
}
t[23807] = {
	name = L["Schematic: Adamantite Scope"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 60000,
	sellPrice = 15000,
	reqLevel = 0,
	profession = L["Engineering"],
	teaches = L["Adamantite Scope"],
	learnedAt = 335,
}
t[28458] = {
	name = L["Bold Tourmaline"],
	quality = 1,
	icon = "inv_misc_gem_ruby_03",
	buyPrice = 20000,
	sellPrice = 5000,
	reqLevel = 0,
}
t[28459] = {
	name = L["Delicate Tourmaline"],
	quality = 1,
	icon = "inv_misc_gem_ruby_03",
	buyPrice = 20000,
	sellPrice = 5000,
	reqLevel = 0,
}
t[28460] = {
	name = L["Teardrop Tourmaline"],
	quality = 1,
	icon = "inv_misc_gem_ruby_03",
	buyPrice = 20000,
	sellPrice = 5000,
	reqLevel = 0,
}
t[28461] = {
	name = L["Runed Tourmaline"],
	quality = 1,
	icon = "inv_misc_gem_ruby_03",
	buyPrice = 20000,
	sellPrice = 5000,
	reqLevel = 0,
}
t[28462] = {
	name = L["Bright Tourmaline"],
	quality = 1,
	icon = "inv_misc_gem_ruby_03",
	buyPrice = 20000,
	sellPrice = 5000,
	reqLevel = 0,
}
t[28463] = {
	name = L["Solid Zircon"],
	quality = 1,
	icon = "inv_misc_gem_crystal_03",
	buyPrice = 20000,
	sellPrice = 5000,
	reqLevel = 0,
}
t[28464] = {
	name = L["Sparkling Zircon"],
	quality = 1,
	icon = "inv_misc_gem_crystal_03",
	buyPrice = 20000,
	sellPrice = 5000,
	reqLevel = 0,
}
t[28465] = {
	name = L["Lustrous Zircon"],
	quality = 1,
	icon = "inv_misc_gem_crystal_03",
	buyPrice = 20000,
	sellPrice = 5000,
	reqLevel = 0,
}
t[28466] = {
	name = L["Brilliant Amber"],
	quality = 1,
	icon = "inv_misc_gem_topaz_03",
	buyPrice = 20000,
	sellPrice = 5000,
	reqLevel = 0,
}
t[28467] = {
	name = L["Smooth Amber"],
	quality = 1,
	icon = "inv_misc_gem_topaz_03",
	buyPrice = 20000,
	sellPrice = 5000,
	reqLevel = 0,
}
t[28468] = {
	name = L["Rigid Amber"],
	quality = 1,
	icon = "inv_misc_gem_topaz_03",
	buyPrice = 20000,
	sellPrice = 5000,
	reqLevel = 0,
}
t[28469] = {
	name = L["Gleaming Amber"],
	quality = 1,
	icon = "inv_misc_gem_topaz_03",
	buyPrice = 20000,
	sellPrice = 5000,
	reqLevel = 0,
}
t[28470] = {
	name = L["Thick Amber"],
	quality = 1,
	icon = "inv_misc_gem_topaz_03",
	buyPrice = 20000,
	sellPrice = 5000,
	reqLevel = 0,
}
t[39354] = {
	name = L["Light Parchment"],
	quality = 1,
	icon = "inv_inscription_papyrus",
	buyPrice = 15,
	sellPrice = 3,
	reqLevel = 0,
}
t[39489] = {
	name = L["Scribe's Satchel"],
	quality = 2,
	icon = "inv_misc_bag_05",
	buyPrice = 5000,
	sellPrice = 1250,
	reqLevel = 0,
}
t[39501] = {
	name = L["Heavy Parchment"],
	quality = 1,
	icon = "inv_inscription_scroll",
	buyPrice = 1250,
	sellPrice = 312,
	reqLevel = 0,
}
t[39502] = {
	name = L["Resilient Parchment"],
	quality = 1,
	icon = "inv_inscription_certificate",
	buyPrice = 5000,
	sellPrice = 1250,
	reqLevel = 0,
}
t[39505] = {
	name = L["Virtuoso Inking Set"],
	quality = 1,
	icon = "inv_misc_enggizmos_19",
	buyPrice = 750,
	sellPrice = 187,
	reqLevel = 0,
}
t[50166] = {
	name = L["Technique: Glyph of Eternal Water"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 30000,
	sellPrice = 7500,
	reqLevel = 0,
	profession = L["Inscription"],
	teaches = L["Glyph of Eternal Water"],
	learnedAt = 250,
}
t[25474] = {
	name = L["Tawny Wind Rider"],
	quality = 3,
	icon = "ability_mount_tawnywindrider",
	buyPrice = 500000,
	sellPrice = 125000,
	reqLevel = 60,
}
t[25475] = {
	name = L["Blue Wind Rider"],
	quality = 3,
	icon = "ability_mount_bluewindrider",
	buyPrice = 500000,
	sellPrice = 125000,
	reqLevel = 60,
}
t[25476] = {
	name = L["Green Wind Rider"],
	quality = 3,
	icon = "ability_mount_greenwindrider",
	buyPrice = 500000,
	sellPrice = 125000,
	reqLevel = 60,
}
t[25477] = {
	name = L["Swift Red Wind Rider"],
	quality = 4,
	icon = "ability_mount_swiftredwindrider",
	buyPrice = 1000000,
	sellPrice = 250000,
	reqLevel = 70,
}
t[25531] = {
	name = L["Swift Green Wind Rider"],
	quality = 4,
	icon = "ability_mount_swiftgreenwindrider",
	buyPrice = 1000000,
	sellPrice = 250000,
	reqLevel = 70,
}
t[25532] = {
	name = L["Swift Yellow Wind Rider"],
	quality = 4,
	icon = "ability_mount_swiftyellowwindrider",
	buyPrice = 1000000,
	sellPrice = 250000,
	reqLevel = 70,
}
t[25533] = {
	name = L["Swift Purple Wind Rider"],
	quality = 4,
	icon = "ability_mount_swiftpurplewindrider",
	buyPrice = 1000000,
	sellPrice = 250000,
	reqLevel = 70,
}
t[25470] = {
	name = L["Golden Gryphon"],
	quality = 3,
	icon = "ability_mount_goldengryphon",
	buyPrice = 500000,
	sellPrice = 125000,
	reqLevel = 60,
}
t[25471] = {
	name = L["Ebon Gryphon"],
	quality = 3,
	icon = "ability_mount_ebongryphon",
	buyPrice = 500000,
	sellPrice = 125000,
	reqLevel = 60,
}
t[25472] = {
	name = L["Snowy Gryphon"],
	quality = 3,
	icon = "ability_mount_snowygryphon",
	buyPrice = 500000,
	sellPrice = 125000,
	reqLevel = 60,
}
t[25473] = {
	name = L["Swift Blue Gryphon"],
	quality = 4,
	icon = "ability_mount_gryphon_01",
	buyPrice = 1000000,
	sellPrice = 250000,
	reqLevel = 70,
}
t[25527] = {
	name = L["Swift Red Gryphon"],
	quality = 4,
	icon = "ability_mount_gryphon_01",
	buyPrice = 1000000,
	sellPrice = 250000,
	reqLevel = 70,
}
t[25528] = {
	name = L["Swift Green Gryphon"],
	quality = 4,
	icon = "ability_mount_gryphon_01",
	buyPrice = 1000000,
	sellPrice = 250000,
	reqLevel = 70,
}
t[25529] = {
	name = L["Swift Purple Gryphon"],
	quality = 4,
	icon = "ability_mount_gryphon_01",
	buyPrice = 1000000,
	sellPrice = 250000,
	reqLevel = 70,
}
t[29393] = {
	name = L["Diamond Berries"],
	quality = 1,
	icon = "inv_misc_gem_amethyst_03",
	buyPrice = 5600,
	sellPrice = 280,
	reqLevel = 55,
}
t[29394] = {
	name = L["Lyribread"],
	quality = 1,
	icon = "inv_holiday_tow_spicebrownie",
	buyPrice = 8000,
	sellPrice = 400,
	reqLevel = 65,
}
t[29395] = {
	name = L["Ethermead"],
	quality = 1,
	icon = "inv_drink_21",
	buyPrice = 6400,
	sellPrice = 320,
	reqLevel = 65,
}
t[29454] = {
	name = L["Silverwine"],
	quality = 1,
	icon = "inv_drink_20",
	buyPrice = 5600,
	sellPrice = 280,
	reqLevel = 60,
}
t[29371] = {
	name = L["Nexus-Claw"],
	quality = 2,
	icon = "inv_weapon_hand_01",
	buyPrice = 348334,
	sellPrice = 69666,
	reqLevel = 66,
}
t[29372] = {
	name = L["Void-Talon"],
	quality = 2,
	icon = "inv_weapon_hand_01",
	buyPrice = 349616,
	sellPrice = 69923,
	reqLevel = 66,
}
t[29377] = {
	name = L["Ethereum Phase-Spear"],
	quality = 2,
	icon = "inv_spear_06",
	buyPrice = 444941,
	sellPrice = 88988,
	reqLevel = 66,
}
t[29378] = {
	name = L["Starheart Baton"],
	quality = 2,
	icon = "inv_wand_05",
	buyPrice = 267925,
	sellPrice = 53585,
	reqLevel = 66,
}
t[29380] = {
	name = L["Ethereum Phase Blade"],
	quality = 2,
	icon = "inv_weapon_shortblade_37",
	buyPrice = 359762,
	sellPrice = 71952,
	reqLevel = 66,
}
t[29391] = {
	name = L["Pulse Dagger"],
	quality = 2,
	icon = "inv_weapon_shortblade_07",
	buyPrice = 348265,
	sellPrice = 69653,
	reqLevel = 66,
}
t[23094] = {
	name = L["Teardrop Blood Garnet"],
	quality = 2,
	icon = "inv_misc_gem_bloodgem_02",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 0,
}
t[23095] = {
	name = L["Bold Blood Garnet"],
	quality = 2,
	icon = "inv_misc_gem_bloodgem_02",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 0,
}
t[23096] = {
	name = L["Runed Blood Garnet"],
	quality = 2,
	icon = "inv_misc_gem_bloodgem_02",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 0,
}
t[23097] = {
	name = L["Delicate Blood Garnet"],
	quality = 2,
	icon = "inv_misc_gem_bloodgem_02",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 0,
}
t[23098] = {
	name = L["Inscribed Flame Spessarite"],
	quality = 2,
	icon = "inv_misc_gem_flamespessarite_02",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 0,
}
t[23099] = {
	name = L["Luminous Flame Spessarite"],
	quality = 2,
	icon = "inv_misc_gem_flamespessarite_02",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 0,
}
t[23100] = {
	name = L["Glinting Flame Spessarite"],
	quality = 2,
	icon = "inv_misc_gem_flamespessarite_02",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 0,
}
t[23101] = {
	name = L["Potent Flame Spessarite"],
	quality = 2,
	icon = "inv_misc_gem_flamespessarite_02",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 0,
}
t[23103] = {
	name = L["Radiant Deep Peridot"],
	quality = 2,
	icon = "inv_misc_gem_deepperidot_02",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 0,
}
t[23104] = {
	name = L["Jagged Deep Peridot"],
	quality = 2,
	icon = "inv_misc_gem_deepperidot_02",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 0,
}
t[23105] = {
	name = L["Enduring Deep Peridot"],
	quality = 2,
	icon = "inv_misc_gem_deepperidot_02",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 0,
}
t[23106] = {
	name = L["Dazzling Deep Peridot"],
	quality = 2,
	icon = "inv_misc_gem_deepperidot_02",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 0,
}
t[23108] = {
	name = L["Glowing Shadow Draenite"],
	quality = 2,
	icon = "inv_misc_gem_ebondraenite_02",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 0,
}
t[23109] = {
	name = L["Royal Shadow Draenite"],
	quality = 2,
	icon = "inv_misc_gem_ebondraenite_02",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 0,
}
t[23110] = {
	name = L["Shifting Shadow Draenite"],
	quality = 2,
	icon = "inv_misc_gem_ebondraenite_02",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 0,
}
t[23111] = {
	name = L["Sovereign Shadow Draenite"],
	quality = 2,
	icon = "inv_misc_gem_ebondraenite_02",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 0,
}
t[23113] = {
	name = L["Brilliant Golden Draenite"],
	quality = 2,
	icon = "inv_misc_gem_goldendraenite_02",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 0,
}
t[23114] = {
	name = L["Gleaming Golden Draenite"],
	quality = 2,
	icon = "inv_misc_gem_goldendraenite_02",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 0,
}
t[23115] = {
	name = L["Thick Golden Draenite"],
	quality = 2,
	icon = "inv_misc_gem_goldendraenite_02",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 0,
}
t[23116] = {
	name = L["Rigid Golden Draenite"],
	quality = 2,
	icon = "inv_misc_gem_goldendraenite_02",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 0,
}
t[23118] = {
	name = L["Solid Azure Moonstone"],
	quality = 2,
	icon = "inv_misc_gem_azuredraenite_02",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 0,
}
t[23119] = {
	name = L["Sparkling Azure Moonstone"],
	quality = 2,
	icon = "inv_misc_gem_azuredraenite_02",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 0,
}
t[23120] = {
	name = L["Stormy Azure Moonstone"],
	quality = 2,
	icon = "inv_misc_gem_azuredraenite_02",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 0,
}
t[23121] = {
	name = L["Lustrous Azure Moonstone"],
	quality = 2,
	icon = "inv_misc_gem_azuredraenite_02",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 0,
}
t[28290] = {
	name = L["Smooth Golden Draenite"],
	quality = 2,
	icon = "inv_misc_gem_goldendraenite_02",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 0,
}
t[28595] = {
	name = L["Bright Blood Garnet"],
	quality = 2,
	icon = "inv_misc_gem_bloodgem_02",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 0,
}
t[23736] = {
	name = L["Fel Iron Bomb"],
	quality = 1,
	icon = "inv_gizmo_felironbomb",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 0,
}
t[23737] = {
	name = L["Adamantite Grenade"],
	quality = 1,
	icon = "inv_misc_bomb_08",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 0,
}
t[23768] = {
	name = L["White Smoke Flare"],
	quality = 1,
	icon = "inv_misc_missilesmall_white",
	buyPrice = 1000,
	sellPrice = 250,
	reqLevel = 0,
}
t[23771] = {
	name = L["Green Smoke Flare"],
	quality = 1,
	icon = "inv_misc_missilesmall_green",
	buyPrice = 1000,
	sellPrice = 250,
	reqLevel = 0,
}
t[23781] = {
	name = L["Elemental Blasting Powder"],
	quality = 1,
	icon = "inv_misc_ammo_gunpowder_07",
	buyPrice = 2000,
	sellPrice = 500,
	reqLevel = 0,
}
t[23782] = {
	name = L["Fel Iron Casing"],
	quality = 1,
	icon = "inv_gizmo_felironcasing",
	buyPrice = 32000,
	sellPrice = 8000,
	reqLevel = 0,
}
t[23783] = {
	name = L["Handful of Fel Iron Bolts"],
	quality = 1,
	icon = "inv_gizmo_felironbolts",
	buyPrice = 6000,
	sellPrice = 1500,
	reqLevel = 0,
}
t[23784] = {
	name = L["Adamantite Frame"],
	quality = 1,
	icon = "inv_gizmo_adamantiteframe",
	buyPrice = 40000,
	sellPrice = 10000,
	reqLevel = 0,
}
t[23786] = {
	name = L["Khorium Power Core"],
	quality = 1,
	icon = "inv_gizmo_khoriumpowercore",
	buyPrice = 48000,
	sellPrice = 12000,
	reqLevel = 0,
}
t[23787] = {
	name = L["Felsteel Stabilizer"],
	quality = 1,
	icon = "inv_gizmo_felstabilizer",
	buyPrice = 48000,
	sellPrice = 12000,
	reqLevel = 0,
}
t[1179] = {
	name = L["Ice Cold Milk"],
	quality = 1,
	icon = "inv_drink_milk_01",
	buyPrice = 125,
	sellPrice = 6,
	reqLevel = 5,
}
t[1205] = {
	name = L["Melon Juice"],
	quality = 1,
	icon = "inv_drink_09",
	buyPrice = 500,
	sellPrice = 25,
	reqLevel = 15,
}
t[1645] = {
	name = L["Moonberry Juice"],
	quality = 1,
	icon = "inv_drink_02",
	buyPrice = 2000,
	sellPrice = 100,
	reqLevel = 35,
}
t[1708] = {
	name = L["Sweet Nectar"],
	quality = 1,
	icon = "inv_drink_12",
	buyPrice = 1000,
	sellPrice = 50,
	reqLevel = 25,
}
t[2593] = {
	name = L["Flask of Stormwind Tawny"],
	quality = 1,
	icon = "inv_potion_12",
	buyPrice = 150,
	sellPrice = 37,
	reqLevel = 0,
}
t[2594] = {
	name = L["Flagon of Dwarven Honeymead"],
	quality = 1,
	icon = "inv_drink_05",
	buyPrice = 1500,
	sellPrice = 375,
	reqLevel = 0,
}
t[2595] = {
	name = L["Jug of Badlands Bourbon"],
	quality = 1,
	icon = "inv_cask_02",
	buyPrice = 2000,
	sellPrice = 500,
	reqLevel = 0,
}
t[2596] = {
	name = L["Skin of Dwarven Stout"],
	quality = 1,
	icon = "inv_drink_milk_02",
	buyPrice = 120,
	sellPrice = 30,
	reqLevel = 0,
}
t[2723] = {
	name = L["Bottle of Dalaran Noir"],
	quality = 1,
	icon = "inv_drink_10",
	buyPrice = 50,
	sellPrice = 12,
	reqLevel = 1,
}
t[4600] = {
	name = L["Cherry Grog"],
	quality = 1,
	icon = "inv_drink_03",
	buyPrice = 340,
	sellPrice = 85,
	reqLevel = 25,
}
t[28284] = {
	name = L["Don Carlos Tequila"],
	quality = 1,
	icon = "inv_drink_10",
	buyPrice = 300,
	sellPrice = 75,
	reqLevel = 0,
}
t[4425] = {
	name = L["Scroll of Agility III"],
	quality = 1,
	icon = "inv_scroll_02",
	buyPrice = 500,
	sellPrice = 125,
	reqLevel = 30,
}
t[4426] = {
	name = L["Scroll of Strength III"],
	quality = 1,
	icon = "inv_scroll_02",
	buyPrice = 500,
	sellPrice = 125,
	reqLevel = 30,
}
t[10306] = {
	name = L["Scroll of Spirit IV"],
	quality = 1,
	icon = "inv_scroll_01",
	buyPrice = 550,
	sellPrice = 100,
	reqLevel = 40,
}
t[10307] = {
	name = L["Scroll of Stamina IV"],
	quality = 1,
	icon = "inv_scroll_07",
	buyPrice = 600,
	sellPrice = 112,
	reqLevel = 40,
}
t[10308] = {
	name = L["Scroll of Intellect IV"],
	quality = 1,
	icon = "inv_scroll_01",
	buyPrice = 600,
	sellPrice = 112,
	reqLevel = 40,
}
t[13444] = {
	name = L["Major Mana Potion"],
	quality = 1,
	icon = "inv_potion_76",
	buyPrice = 6000,
	sellPrice = 1500,
	reqLevel = 49,
}
t[13446] = {
	name = L["Major Healing Potion"],
	quality = 1,
	icon = "inv_potion_54",
	buyPrice = 4000,
	sellPrice = 1000,
	reqLevel = 45,
}
t[22552] = {
	name = L["Formula: Enchant Weapon - Major Striking"],
	quality = 1,
	icon = "inv_misc_note_01",
	buyPrice = 60000,
	sellPrice = 15000,
	reqLevel = 0,
	profession = L["Enchanting"],
	teaches = L["Enchant Weapon - Major Striking"],
	learnedAt = 340,
}
t[23134] = {
	name = L["Design: Delicate Blood Garnet"],
	quality = 2,
	icon = "inv_scroll_06",
	buyPrice = 60000,
	sellPrice = 15000,
	reqLevel = 0,
}
t[23136] = {
	name = L["Design: Luminous Flame Spessarite"],
	quality = 2,
	icon = "inv_scroll_06",
	buyPrice = 50000,
	sellPrice = 12500,
	reqLevel = 0,
}
t[23146] = {
	name = L["Design: Shifting Shadow Draenite"],
	quality = 2,
	icon = "inv_scroll_06",
	buyPrice = 60000,
	sellPrice = 15000,
	reqLevel = 0,
}
t[23150] = {
	name = L["Design: Thick Golden Draenite"],
	quality = 2,
	icon = "inv_scroll_06",
	buyPrice = 60000,
	sellPrice = 15000,
	reqLevel = 0,
}
t[23155] = {
	name = L["Design: Lustrous Azure Moonstone"],
	quality = 2,
	icon = "inv_scroll_06",
	buyPrice = 60000,
	sellPrice = 15000,
	reqLevel = 0,
}
t[23874] = {
	name = L["Schematic: Elemental Seaforium Charge"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 80000,
	sellPrice = 20000,
	reqLevel = 0,
	profession = L["Engineering"],
	teaches = L["Elemental Seaforium Charge"],
	learnedAt = 350,
}
t[24178] = {
	name = L["Design: Pendant of the Null Rune"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 120000,
	sellPrice = 30000,
	reqLevel = 0,
}
t[24314] = {
	name = L["Pattern: Bag of Jewels"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 40000,
	sellPrice = 10000,
	reqLevel = 0,
	profession = L["Tailoring"],
	teaches = L["Bag of Jewels"],
	learnedAt = 340,
}
t[25732] = {
	name = L["Pattern: Fel Leather Gloves"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 120000,
	sellPrice = 30000,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Fel Leather Gloves"],
	learnedAt = 340,
}
t[25733] = {
	name = L["Pattern: Fel Leather Boots"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 140000,
	sellPrice = 35000,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Fel Leather Boots"],
	learnedAt = 350,
}
t[25734] = {
	name = L["Pattern: Fel Leather Leggings"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 140000,
	sellPrice = 35000,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Fel Leather Leggings"],
	learnedAt = 350,
}
t[25908] = {
	name = L["Design: Swift Skyfire Diamond"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 120000,
	sellPrice = 30000,
	reqLevel = 0,
}
t[28274] = {
	name = L["Formula: Enchant Cloak - Spell Penetration"],
	quality = 2,
	icon = "inv_misc_note_01",
	buyPrice = 40000,
	sellPrice = 10000,
	reqLevel = 0,
	profession = L["Enchanting"],
	teaches = L["Enchant Cloak - Spell Penetration"],
	learnedAt = 325,
}
t[29115] = {
	name = L["Consortium Blaster"],
	quality = 3,
	icon = "inv_weapon_rifle_07",
	buyPrice = 344063,
	sellPrice = 68812,
	reqLevel = 70,
}
t[29116] = {
	name = L["Nomad's Leggings"],
	quality = 3,
	icon = "inv_pants_02",
	buyPrice = 230189,
	sellPrice = 46037,
	reqLevel = 70,
}
t[29117] = {
	name = L["Stormspire Vest"],
	quality = 3,
	icon = "inv_chest_cloth_08",
	buyPrice = 167172,
	sellPrice = 33434,
	reqLevel = 70,
}
t[29118] = {
	name = L["Smuggler's Ammo Pouch"],
	quality = 3,
	icon = "inv_misc_bag_10_black",
	buyPrice = 100000,
	sellPrice = 25000,
	reqLevel = 68,
}
t[29119] = {
	name = L["Haramad's Bargain"],
	quality = 4,
	icon = "inv_jewelry_necklace_29naxxramas",
	buyPrice = 790112,
	sellPrice = 197528,
	reqLevel = 70,
}
t[29121] = {
	name = L["Guile of Khoraazi"],
	quality = 4,
	icon = "inv_weapon_shortblade_31",
	buyPrice = 1995172,
	sellPrice = 399034,
	reqLevel = 70,
}
t[29122] = {
	name = L["Nether Runner's Cowl"],
	quality = 4,
	icon = "inv_helmet_30",
	buyPrice = 627777,
	sellPrice = 125555,
	reqLevel = 70,
}
t[29456] = {
	name = L["Gift of the Ethereal"],
	quality = 3,
	icon = "inv_sword_draenei_01",
	buyPrice = 348580,
	sellPrice = 69716,
	reqLevel = 63,
}
t[29457] = {
	name = L["Nethershard"],
	quality = 3,
	icon = "inv_weapon_shortblade_08",
	buyPrice = 349938,
	sellPrice = 69987,
	reqLevel = 63,
}
t[31776] = {
	name = L["Consortium Tabard"],
	quality = 1,
	icon = "inv_shirt_guildtabard_01",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 0,
}
t[33156] = {
	name = L["Design: Crimson Sun"],
	quality = 1,
	icon = "inv_scroll_05",
	buyPrice = 120000,
	sellPrice = 30000,
	reqLevel = 0,
}
t[33305] = {
	name = L["Design: Don Julio's Heart"],
	quality = 1,
	icon = "inv_scroll_05",
	buyPrice = 120000,
	sellPrice = 30000,
	reqLevel = 0,
}
t[33622] = {
	name = L["Design: Relentless Earthstorm Diamond"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 120000,
	sellPrice = 30000,
	reqLevel = 0,
}
t[24544] = {
	name = L["Gladiator's Plate Chestpiece"],
	quality = 4,
	icon = "inv_chest_plate05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[24545] = {
	name = L["Gladiator's Plate Helm"],
	quality = 4,
	icon = "inv_helmet_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[24546] = {
	name = L["Gladiator's Plate Shoulders"],
	quality = 4,
	icon = "inv_shoulder_22",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[24547] = {
	name = L["Gladiator's Plate Legguards"],
	quality = 4,
	icon = "inv_pants_plate_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[24549] = {
	name = L["Gladiator's Plate Gauntlets"],
	quality = 4,
	icon = "inv_gauntlets_29",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[24550] = {
	name = L["Gladiator's Greatsword"],
	quality = 4,
	icon = "inv_sword_70",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[24552] = {
	name = L["Gladiator's Dreadweave Robe"],
	quality = 4,
	icon = "inv_chest_cloth_43",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[24553] = {
	name = L["Gladiator's Dreadweave Hood"],
	quality = 4,
	icon = "inv_helmet_30",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[24554] = {
	name = L["Gladiator's Dreadweave Mantle"],
	quality = 4,
	icon = "inv_shoulder_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[24555] = {
	name = L["Gladiator's Dreadweave Leggings"],
	quality = 4,
	icon = "inv_pants_cloth_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[24556] = {
	name = L["Gladiator's Dreadweave Gloves"],
	quality = 4,
	icon = "inv_gauntlets_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[24557] = {
	name = L["Gladiator's War Staff"],
	quality = 4,
	icon = "inv_staff_53",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[25830] = {
	name = L["Gladiator's Leather Helm"],
	quality = 4,
	icon = "inv_helmet_30",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[25831] = {
	name = L["Gladiator's Leather Tunic"],
	quality = 4,
	icon = "inv_chest_leather_03",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[25832] = {
	name = L["Gladiator's Leather Spaulders"],
	quality = 4,
	icon = "inv_shoulder_12",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[25833] = {
	name = L["Gladiator's Leather Legguards"],
	quality = 4,
	icon = "inv_pants_cloth_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[25834] = {
	name = L["Gladiator's Leather Gloves"],
	quality = 4,
	icon = "inv_gauntlets_28",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[25854] = {
	name = L["Gladiator's Silk Amice"],
	quality = 4,
	icon = "inv_shoulder_19",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[25855] = {
	name = L["Gladiator's Silk Cowl"],
	quality = 4,
	icon = "inv_helmet_08",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[25856] = {
	name = L["Gladiator's Silk Raiment"],
	quality = 4,
	icon = "inv_chest_leather_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[25857] = {
	name = L["Gladiator's Silk Handguards"],
	quality = 4,
	icon = "inv_gauntlets_19",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[25858] = {
	name = L["Gladiator's Silk Trousers"],
	quality = 4,
	icon = "inv_pants_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[25997] = {
	name = L["Gladiator's Linked Armor"],
	quality = 4,
	icon = "inv_chest_chain_11",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[25998] = {
	name = L["Gladiator's Linked Helm"],
	quality = 4,
	icon = "inv_helmet_09",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[25999] = {
	name = L["Gladiator's Linked Spaulders"],
	quality = 4,
	icon = "inv_shoulder_29",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[26000] = {
	name = L["Gladiator's Linked Gauntlets"],
	quality = 4,
	icon = "inv_gauntlets_11",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[26001] = {
	name = L["Gladiator's Linked Leggings"],
	quality = 4,
	icon = "inv_pants_mail_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[27469] = {
	name = L["Gladiator's Mail Armor"],
	quality = 4,
	icon = "inv_chest_chain_11",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[27470] = {
	name = L["Gladiator's Mail Gauntlets"],
	quality = 4,
	icon = "inv_gauntlets_11",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[27471] = {
	name = L["Gladiator's Mail Helm"],
	quality = 4,
	icon = "inv_helmet_09",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[27472] = {
	name = L["Gladiator's Mail Leggings"],
	quality = 4,
	icon = "inv_pants_mail_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[27473] = {
	name = L["Gladiator's Mail Spaulders"],
	quality = 4,
	icon = "inv_shoulder_29",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[27702] = {
	name = L["Gladiator's Lamellar Chestpiece"],
	quality = 4,
	icon = "inv_chest_plate05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[27703] = {
	name = L["Gladiator's Lamellar Gauntlets"],
	quality = 4,
	icon = "inv_gauntlets_29",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[27704] = {
	name = L["Gladiator's Lamellar Helm"],
	quality = 4,
	icon = "inv_helmet_22",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[27705] = {
	name = L["Gladiator's Lamellar Legguards"],
	quality = 4,
	icon = "inv_pants_plate_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[27706] = {
	name = L["Gladiator's Lamellar Shoulders"],
	quality = 4,
	icon = "inv_shoulder_22",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[27707] = {
	name = L["Gladiator's Satin Gloves"],
	quality = 4,
	icon = "inv_gauntlets_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[27708] = {
	name = L["Gladiator's Satin Hood"],
	quality = 4,
	icon = "inv_helmet_30",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[27709] = {
	name = L["Gladiator's Satin Leggings"],
	quality = 4,
	icon = "inv_pants_cloth_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[27710] = {
	name = L["Gladiator's Satin Mantle"],
	quality = 4,
	icon = "inv_shoulder_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[27711] = {
	name = L["Gladiator's Satin Robe"],
	quality = 4,
	icon = "inv_chest_cloth_43",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[27879] = {
	name = L["Gladiator's Scaled Chestpiece"],
	quality = 4,
	icon = "inv_chest_plate05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[27880] = {
	name = L["Gladiator's Scaled Gauntlets"],
	quality = 4,
	icon = "inv_gauntlets_29",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[27881] = {
	name = L["Gladiator's Scaled Helm"],
	quality = 4,
	icon = "inv_helmet_22",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[27882] = {
	name = L["Gladiator's Scaled Legguards"],
	quality = 4,
	icon = "inv_pants_plate_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[27883] = {
	name = L["Gladiator's Scaled Shoulders"],
	quality = 4,
	icon = "inv_shoulder_22",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28126] = {
	name = L["Gladiator's Dragonhide Gloves"],
	quality = 4,
	icon = "inv_gauntlets_28",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28127] = {
	name = L["Gladiator's Dragonhide Helm"],
	quality = 4,
	icon = "inv_helmet_30",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28128] = {
	name = L["Gladiator's Dragonhide Legguards"],
	quality = 4,
	icon = "inv_pants_cloth_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28129] = {
	name = L["Gladiator's Dragonhide Spaulders"],
	quality = 4,
	icon = "inv_shoulder_12",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28130] = {
	name = L["Gladiator's Dragonhide Tunic"],
	quality = 4,
	icon = "inv_chest_leather_03",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28136] = {
	name = L["Gladiator's Wyrmhide Gloves"],
	quality = 4,
	icon = "inv_gauntlets_28",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28137] = {
	name = L["Gladiator's Wyrmhide Helm"],
	quality = 4,
	icon = "inv_helmet_30",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28138] = {
	name = L["Gladiator's Wyrmhide Legguards"],
	quality = 4,
	icon = "inv_pants_cloth_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28139] = {
	name = L["Gladiator's Wyrmhide Spaulders"],
	quality = 4,
	icon = "inv_shoulder_12",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28140] = {
	name = L["Gladiator's Wyrmhide Tunic"],
	quality = 4,
	icon = "inv_chest_leather_03",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28294] = {
	name = L["Gladiator's Heavy Crossbow"],
	quality = 4,
	icon = "inv_weapon_crossbow_10",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28295] = {
	name = L["Gladiator's Slicer"],
	quality = 4,
	icon = "inv_sword_71",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28297] = {
	name = L["Gladiator's Spellblade"],
	quality = 4,
	icon = "inv_weapon_shortblade_26",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28298] = {
	name = L["Gladiator's Decapitator"],
	quality = 4,
	icon = "inv_axe_68",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28299] = {
	name = L["Gladiator's Bonegrinder"],
	quality = 4,
	icon = "inv_mace_52",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28300] = {
	name = L["Gladiator's Painsaw"],
	quality = 4,
	icon = "inv_weapon_halberd15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28302] = {
	name = L["Gladiator's Bonecracker"],
	quality = 4,
	icon = "inv_mace_36",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28305] = {
	name = L["Gladiator's Pummeler"],
	quality = 4,
	icon = "inv_mace_36",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28307] = {
	name = L["Gladiator's Quickblade"],
	quality = 4,
	icon = "inv_sword_71",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28308] = {
	name = L["Gladiator's Cleaver"],
	quality = 4,
	icon = "inv_axe_54",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28309] = {
	name = L["Gladiator's Hacker"],
	quality = 4,
	icon = "inv_axe_54",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28310] = {
	name = L["Gladiator's Shiv"],
	quality = 4,
	icon = "inv_weapon_shortblade_45",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28312] = {
	name = L["Gladiator's Shanker"],
	quality = 4,
	icon = "inv_weapon_shortblade_45",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28313] = {
	name = L["Gladiator's Right Ripper"],
	quality = 4,
	icon = "inv_weapon_hand_13",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28314] = {
	name = L["Gladiator's Left Ripper"],
	quality = 4,
	icon = "inv_weapon_hand_13",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28319] = {
	name = L["Gladiator's War Edge"],
	quality = 4,
	icon = "inv_axe_03",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28320] = {
	name = L["Gladiator's Touch of Defeat"],
	quality = 4,
	icon = "inv_wand_09",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28331] = {
	name = L["Gladiator's Chain Helm"],
	quality = 4,
	icon = "inv_helmet_09",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28332] = {
	name = L["Gladiator's Chain Leggings"],
	quality = 4,
	icon = "inv_pants_mail_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28333] = {
	name = L["Gladiator's Chain Spaulders"],
	quality = 4,
	icon = "inv_shoulder_29",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28334] = {
	name = L["Gladiator's Chain Armor"],
	quality = 4,
	icon = "inv_chest_chain_11",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28335] = {
	name = L["Gladiator's Chain Gauntlets"],
	quality = 4,
	icon = "inv_gauntlets_11",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28346] = {
	name = L["Gladiator's Endgame"],
	quality = 4,
	icon = "inv_misc_book_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28355] = {
	name = L["Gladiator's Idol of Tenacity"],
	quality = 4,
	icon = "inv_relics_idolofhealth",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28356] = {
	name = L["Gladiator's Libram of Justice"],
	quality = 4,
	icon = "inv_relics_libramofhope",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28357] = {
	name = L["Gladiator's Totem of the Third Wind"],
	quality = 4,
	icon = "spell_nature_slowingtotem",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28358] = {
	name = L["Gladiator's Shield Wall"],
	quality = 4,
	icon = "inv_shield_31",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28476] = {
	name = L["Gladiator's Maul"],
	quality = 4,
	icon = "inv_mace_52",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30186] = {
	name = L["Gladiator's Felweave Amice"],
	quality = 4,
	icon = "inv_shoulder_19",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30187] = {
	name = L["Gladiator's Felweave Cowl"],
	quality = 4,
	icon = "inv_helmet_08",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30188] = {
	name = L["Gladiator's Felweave Handguards"],
	quality = 4,
	icon = "inv_gauntlets_19",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30200] = {
	name = L["Gladiator's Felweave Raiment"],
	quality = 4,
	icon = "inv_chest_leather_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30201] = {
	name = L["Gladiator's Felweave Trousers"],
	quality = 4,
	icon = "inv_pants_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30486] = {
	name = L["Merciless Gladiator's Plate Chestpiece"],
	quality = 4,
	icon = "inv_chest_plate05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30487] = {
	name = L["Merciless Gladiator's Plate Gauntlets"],
	quality = 4,
	icon = "inv_gauntlets_29",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30488] = {
	name = L["Merciless Gladiator's Plate Helm"],
	quality = 4,
	icon = "inv_helmet_22",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30489] = {
	name = L["Merciless Gladiator's Plate Legguards"],
	quality = 4,
	icon = "inv_pants_plate_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30490] = {
	name = L["Merciless Gladiator's Plate Shoulders"],
	quality = 4,
	icon = "inv_shoulder_22",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31375] = {
	name = L["Gladiator's Kodohide Gloves"],
	quality = 4,
	icon = "inv_gauntlets_28",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31376] = {
	name = L["Gladiator's Kodohide Helm"],
	quality = 4,
	icon = "inv_helmet_30",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31377] = {
	name = L["Gladiator's Kodohide Legguards"],
	quality = 4,
	icon = "inv_pants_cloth_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31378] = {
	name = L["Gladiator's Kodohide Spaulders"],
	quality = 4,
	icon = "inv_shoulder_12",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31379] = {
	name = L["Gladiator's Kodohide Tunic"],
	quality = 4,
	icon = "inv_chest_leather_03",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31396] = {
	name = L["Gladiator's Ringmail Armor"],
	quality = 4,
	icon = "inv_chest_chain_11",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31397] = {
	name = L["Gladiator's Ringmail Gauntlets"],
	quality = 4,
	icon = "inv_gauntlets_11",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31400] = {
	name = L["Gladiator's Ringmail Helm"],
	quality = 4,
	icon = "inv_helmet_09",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31406] = {
	name = L["Gladiator's Ringmail Leggings"],
	quality = 4,
	icon = "inv_pants_mail_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31407] = {
	name = L["Gladiator's Ringmail Spaulders"],
	quality = 4,
	icon = "inv_shoulder_29",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31409] = {
	name = L["Gladiator's Mooncloth Gloves"],
	quality = 4,
	icon = "inv_gauntlets_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31410] = {
	name = L["Gladiator's Mooncloth Hood"],
	quality = 4,
	icon = "inv_helmet_30",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31411] = {
	name = L["Gladiator's Mooncloth Leggings"],
	quality = 4,
	icon = "inv_pants_cloth_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31412] = {
	name = L["Gladiator's Mooncloth Mantle"],
	quality = 4,
	icon = "inv_shoulder_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31413] = {
	name = L["Gladiator's Mooncloth Robe"],
	quality = 4,
	icon = "inv_chest_cloth_43",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31613] = {
	name = L["Gladiator's Ornamented Chestguard"],
	quality = 4,
	icon = "inv_chest_plate05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31614] = {
	name = L["Gladiator's Ornamented Gloves"],
	quality = 4,
	icon = "inv_gauntlets_29",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31616] = {
	name = L["Gladiator's Ornamented Headcover"],
	quality = 4,
	icon = "inv_helmet_22",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31618] = {
	name = L["Gladiator's Ornamented Legplates"],
	quality = 4,
	icon = "inv_pants_plate_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31619] = {
	name = L["Gladiator's Ornamented Spaulders"],
	quality = 4,
	icon = "inv_shoulder_22",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31958] = {
	name = L["Merciless Gladiator's Bonecracker"],
	quality = 4,
	icon = "inv_mace_36",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31959] = {
	name = L["Merciless Gladiator's Bonegrinder"],
	quality = 4,
	icon = "inv_mace_52",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31960] = {
	name = L["Merciless Gladiator's Chain Armor"],
	quality = 4,
	icon = "inv_chest_chain_11",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31961] = {
	name = L["Merciless Gladiator's Chain Gauntlets"],
	quality = 4,
	icon = "inv_gauntlets_11",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31962] = {
	name = L["Merciless Gladiator's Chain Helm"],
	quality = 4,
	icon = "inv_helmet_09",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31963] = {
	name = L["Merciless Gladiator's Chain Leggings"],
	quality = 4,
	icon = "inv_pants_mail_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31964] = {
	name = L["Merciless Gladiator's Chain Spaulders"],
	quality = 4,
	icon = "inv_shoulder_29",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31965] = {
	name = L["Merciless Gladiator's Cleaver"],
	quality = 4,
	icon = "inv_axe_54",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31966] = {
	name = L["Merciless Gladiator's Decapitator"],
	quality = 4,
	icon = "inv_axe_68",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31967] = {
	name = L["Merciless Gladiator's Dragonhide Gloves"],
	quality = 4,
	icon = "inv_gauntlets_28",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31968] = {
	name = L["Merciless Gladiator's Dragonhide Helm"],
	quality = 4,
	icon = "inv_helmet_30",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31969] = {
	name = L["Merciless Gladiator's Dragonhide Legguards"],
	quality = 4,
	icon = "inv_pants_cloth_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31971] = {
	name = L["Merciless Gladiator's Dragonhide Spaulders"],
	quality = 4,
	icon = "inv_shoulder_12",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31972] = {
	name = L["Merciless Gladiator's Dragonhide Tunic"],
	quality = 4,
	icon = "inv_chest_leather_03",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31973] = {
	name = L["Merciless Gladiator's Dreadweave Gloves"],
	quality = 4,
	icon = "inv_gauntlets_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31974] = {
	name = L["Merciless Gladiator's Dreadweave Hood"],
	quality = 4,
	icon = "inv_helmet_30",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31975] = {
	name = L["Merciless Gladiator's Dreadweave Leggings"],
	quality = 4,
	icon = "inv_pants_cloth_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31976] = {
	name = L["Merciless Gladiator's Dreadweave Mantle"],
	quality = 4,
	icon = "inv_shoulder_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31977] = {
	name = L["Merciless Gladiator's Dreadweave Robe"],
	quality = 4,
	icon = "inv_chest_cloth_43",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31978] = {
	name = L["Merciless Gladiator's Endgame"],
	quality = 4,
	icon = "inv_misc_book_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31979] = {
	name = L["Merciless Gladiator's Felweave Amice"],
	quality = 4,
	icon = "inv_shoulder_19",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31980] = {
	name = L["Merciless Gladiator's Felweave Cowl"],
	quality = 4,
	icon = "inv_helmet_08",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31981] = {
	name = L["Merciless Gladiator's Felweave Handguards"],
	quality = 4,
	icon = "inv_gauntlets_19",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31982] = {
	name = L["Merciless Gladiator's Felweave Raiment"],
	quality = 4,
	icon = "inv_chest_leather_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31983] = {
	name = L["Merciless Gladiator's Felweave Trousers"],
	quality = 4,
	icon = "inv_pants_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31984] = {
	name = L["Merciless Gladiator's Greatsword"],
	quality = 4,
	icon = "inv_sword_70",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31985] = {
	name = L["Merciless Gladiator's Hacker"],
	quality = 4,
	icon = "inv_axe_54",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31986] = {
	name = L["Merciless Gladiator's Crossbow of the Phoenix"],
	quality = 4,
	icon = "inv_weapon_crossbow_10",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31987] = {
	name = L["Merciless Gladiator's Kodohide Gloves"],
	quality = 4,
	icon = "inv_gauntlets_28",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31988] = {
	name = L["Merciless Gladiator's Kodohide Helm"],
	quality = 4,
	icon = "inv_helmet_30",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31989] = {
	name = L["Merciless Gladiator's Kodohide Legguards"],
	quality = 4,
	icon = "inv_pants_cloth_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31990] = {
	name = L["Merciless Gladiator's Kodohide Spaulders"],
	quality = 4,
	icon = "inv_shoulder_12",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31991] = {
	name = L["Merciless Gladiator's Kodohide Tunic"],
	quality = 4,
	icon = "inv_chest_leather_03",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31992] = {
	name = L["Merciless Gladiator's Lamellar Chestpiece"],
	quality = 4,
	icon = "inv_chest_plate05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31993] = {
	name = L["Merciless Gladiator's Lamellar Gauntlets"],
	quality = 4,
	icon = "inv_gauntlets_29",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31995] = {
	name = L["Merciless Gladiator's Lamellar Legguards"],
	quality = 4,
	icon = "inv_pants_plate_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31996] = {
	name = L["Merciless Gladiator's Lamellar Shoulders"],
	quality = 4,
	icon = "inv_shoulder_22",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31997] = {
	name = L["Merciless Gladiator's Lamellar Helm"],
	quality = 4,
	icon = "inv_helmet_22",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31998] = {
	name = L["Merciless Gladiator's Leather Gloves"],
	quality = 4,
	icon = "inv_gauntlets_28",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31999] = {
	name = L["Merciless Gladiator's Leather Helm"],
	quality = 4,
	icon = "inv_helmet_30",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32000] = {
	name = L["Merciless Gladiator's Leather Legguards"],
	quality = 4,
	icon = "inv_pants_cloth_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32001] = {
	name = L["Merciless Gladiator's Leather Spaulders"],
	quality = 4,
	icon = "inv_shoulder_12",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32002] = {
	name = L["Merciless Gladiator's Leather Tunic"],
	quality = 4,
	icon = "inv_chest_leather_03",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32003] = {
	name = L["Merciless Gladiator's Left Ripper"],
	quality = 4,
	icon = "inv_weapon_hand_13",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32004] = {
	name = L["Merciless Gladiator's Linked Armor"],
	quality = 4,
	icon = "inv_chest_chain_11",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32005] = {
	name = L["Merciless Gladiator's Linked Gauntlets"],
	quality = 4,
	icon = "inv_gauntlets_11",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32006] = {
	name = L["Merciless Gladiator's Linked Helm"],
	quality = 4,
	icon = "inv_helmet_09",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32007] = {
	name = L["Merciless Gladiator's Linked Leggings"],
	quality = 4,
	icon = "inv_pants_mail_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32008] = {
	name = L["Merciless Gladiator's Linked Spaulders"],
	quality = 4,
	icon = "inv_shoulder_29",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32009] = {
	name = L["Merciless Gladiator's Mail Armor"],
	quality = 4,
	icon = "inv_chest_chain_11",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32010] = {
	name = L["Merciless Gladiator's Mail Gauntlets"],
	quality = 4,
	icon = "inv_gauntlets_11",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32011] = {
	name = L["Merciless Gladiator's Mail Helm"],
	quality = 4,
	icon = "inv_helmet_09",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32012] = {
	name = L["Merciless Gladiator's Mail Leggings"],
	quality = 4,
	icon = "inv_pants_mail_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32013] = {
	name = L["Merciless Gladiator's Mail Spaulders"],
	quality = 4,
	icon = "inv_shoulder_29",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32014] = {
	name = L["Merciless Gladiator's Maul"],
	quality = 4,
	icon = "inv_mace_52",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32015] = {
	name = L["Merciless Gladiator's Mooncloth Gloves"],
	quality = 4,
	icon = "inv_gauntlets_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32016] = {
	name = L["Merciless Gladiator's Mooncloth Hood"],
	quality = 4,
	icon = "inv_helmet_30",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32017] = {
	name = L["Merciless Gladiator's Mooncloth Leggings"],
	quality = 4,
	icon = "inv_pants_cloth_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32018] = {
	name = L["Merciless Gladiator's Mooncloth Mantle"],
	quality = 4,
	icon = "inv_shoulder_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32019] = {
	name = L["Merciless Gladiator's Mooncloth Robe"],
	quality = 4,
	icon = "inv_chest_cloth_43",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32020] = {
	name = L["Merciless Gladiator's Ornamented Chestguard"],
	quality = 4,
	icon = "inv_chest_plate05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32021] = {
	name = L["Merciless Gladiator's Ornamented Gloves"],
	quality = 4,
	icon = "inv_gauntlets_29",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32022] = {
	name = L["Merciless Gladiator's Ornamented Headcover"],
	quality = 4,
	icon = "inv_helmet_22",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32023] = {
	name = L["Merciless Gladiator's Ornamented Legplates"],
	quality = 4,
	icon = "inv_pants_plate_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32024] = {
	name = L["Merciless Gladiator's Ornamented Spaulders"],
	quality = 4,
	icon = "inv_shoulder_22",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32025] = {
	name = L["Merciless Gladiator's Painsaw"],
	quality = 4,
	icon = "inv_weapon_halberd15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32026] = {
	name = L["Merciless Gladiator's Pummeler"],
	quality = 4,
	icon = "inv_mace_36",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32027] = {
	name = L["Merciless Gladiator's Quickblade"],
	quality = 4,
	icon = "inv_sword_71",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32028] = {
	name = L["Merciless Gladiator's Right Ripper"],
	quality = 4,
	icon = "inv_weapon_hand_13",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32029] = {
	name = L["Merciless Gladiator's Ringmail Armor"],
	quality = 4,
	icon = "inv_chest_chain_11",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32030] = {
	name = L["Merciless Gladiator's Ringmail Gauntlets"],
	quality = 4,
	icon = "inv_gauntlets_11",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32031] = {
	name = L["Merciless Gladiator's Ringmail Helm"],
	quality = 4,
	icon = "inv_helmet_09",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32032] = {
	name = L["Merciless Gladiator's Ringmail Leggings"],
	quality = 4,
	icon = "inv_pants_mail_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32033] = {
	name = L["Merciless Gladiator's Ringmail Spaulders"],
	quality = 4,
	icon = "inv_shoulder_29",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32034] = {
	name = L["Merciless Gladiator's Satin Gloves"],
	quality = 4,
	icon = "inv_gauntlets_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32035] = {
	name = L["Merciless Gladiator's Satin Hood"],
	quality = 4,
	icon = "inv_helmet_30",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32036] = {
	name = L["Merciless Gladiator's Satin Leggings"],
	quality = 4,
	icon = "inv_pants_cloth_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32037] = {
	name = L["Merciless Gladiator's Satin Mantle"],
	quality = 4,
	icon = "inv_shoulder_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32038] = {
	name = L["Merciless Gladiator's Satin Robe"],
	quality = 4,
	icon = "inv_chest_cloth_43",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32039] = {
	name = L["Merciless Gladiator's Scaled Chestpiece"],
	quality = 4,
	icon = "inv_chest_plate05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32040] = {
	name = L["Merciless Gladiator's Scaled Gauntlets"],
	quality = 4,
	icon = "inv_gauntlets_29",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32041] = {
	name = L["Merciless Gladiator's Scaled Helm"],
	quality = 4,
	icon = "inv_helmet_22",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32042] = {
	name = L["Merciless Gladiator's Scaled Legguards"],
	quality = 4,
	icon = "inv_pants_plate_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32043] = {
	name = L["Merciless Gladiator's Scaled Shoulders"],
	quality = 4,
	icon = "inv_shoulder_22",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32044] = {
	name = L["Merciless Gladiator's Shanker"],
	quality = 4,
	icon = "inv_weapon_shortblade_45",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32045] = {
	name = L["Merciless Gladiator's Shield Wall"],
	quality = 4,
	icon = "inv_shield_31",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32046] = {
	name = L["Merciless Gladiator's Shiv"],
	quality = 4,
	icon = "inv_weapon_shortblade_45",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32047] = {
	name = L["Merciless Gladiator's Silk Amice"],
	quality = 4,
	icon = "inv_shoulder_19",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32048] = {
	name = L["Merciless Gladiator's Silk Cowl"],
	quality = 4,
	icon = "inv_helmet_08",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32049] = {
	name = L["Merciless Gladiator's Silk Handguards"],
	quality = 4,
	icon = "inv_gauntlets_19",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32050] = {
	name = L["Merciless Gladiator's Silk Raiment"],
	quality = 4,
	icon = "inv_chest_leather_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32051] = {
	name = L["Merciless Gladiator's Silk Trousers"],
	quality = 4,
	icon = "inv_pants_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32052] = {
	name = L["Merciless Gladiator's Slicer"],
	quality = 4,
	icon = "inv_sword_71",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32053] = {
	name = L["Merciless Gladiator's Spellblade"],
	quality = 4,
	icon = "inv_weapon_shortblade_26",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32054] = {
	name = L["Merciless Gladiator's War Edge"],
	quality = 4,
	icon = "inv_axe_03",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32055] = {
	name = L["Merciless Gladiator's War Staff"],
	quality = 4,
	icon = "inv_staff_53",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32056] = {
	name = L["Merciless Gladiator's Wyrmhide Gloves"],
	quality = 4,
	icon = "inv_gauntlets_28",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32057] = {
	name = L["Merciless Gladiator's Wyrmhide Helm"],
	quality = 4,
	icon = "inv_helmet_30",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32058] = {
	name = L["Merciless Gladiator's Wyrmhide Legguards"],
	quality = 4,
	icon = "inv_pants_cloth_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32059] = {
	name = L["Merciless Gladiator's Wyrmhide Spaulders"],
	quality = 4,
	icon = "inv_shoulder_12",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32060] = {
	name = L["Merciless Gladiator's Wyrmhide Tunic"],
	quality = 4,
	icon = "inv_chest_leather_03",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32450] = {
	name = L["Gladiator's Gavel"],
	quality = 4,
	icon = "inv_mace_47",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32451] = {
	name = L["Gladiator's Salvation"],
	quality = 4,
	icon = "inv_mace_47",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32452] = {
	name = L["Gladiator's Reprieve"],
	quality = 4,
	icon = "inv_misc_book_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32961] = {
	name = L["Merciless Gladiator's Reprieve"],
	quality = 4,
	icon = "inv_misc_book_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32962] = {
	name = L["Merciless Gladiator's Touch of Defeat"],
	quality = 4,
	icon = "inv_wand_09",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32963] = {
	name = L["Merciless Gladiator's Gavel"],
	quality = 4,
	icon = "inv_mace_47",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32964] = {
	name = L["Merciless Gladiator's Salvation"],
	quality = 4,
	icon = "inv_mace_47",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33006] = {
	name = L["Vengeful Gladiator's Heavy Crossbow"],
	quality = 4,
	icon = "inv_weapon_crossbow_19",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33076] = {
	name = L["Merciless Gladiator's Idol of Tenacity"],
	quality = 4,
	icon = "spell_nature_naturetouchgrow",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33077] = {
	name = L["Merciless Gladiator's Libram of Justice"],
	quality = 4,
	icon = "inv_misc_book_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33078] = {
	name = L["Merciless Gladiator's Totem of the Third Wind"],
	quality = 4,
	icon = "spell_frost_summonwaterelemental",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33309] = {
	name = L["Merciless Gladiator's Redoubt"],
	quality = 4,
	icon = "inv_shield_31",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33313] = {
	name = L["Merciless Gladiator's Barrier"],
	quality = 4,
	icon = "inv_shield_31",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33661] = {
	name = L["Vengeful Gladiator's Barrier"],
	quality = 4,
	icon = "inv_shield_31",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33662] = {
	name = L["Vengeful Gladiator's Bonecracker"],
	quality = 4,
	icon = "inv_mace_41",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33663] = {
	name = L["Vengeful Gladiator's Bonegrinder"],
	quality = 4,
	icon = "inv_mace_43",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33664] = {
	name = L["Vengeful Gladiator's Chain Armor"],
	quality = 4,
	icon = "inv_chest_mail_03",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33665] = {
	name = L["Vengeful Gladiator's Chain Gauntlets"],
	quality = 4,
	icon = "inv_gauntlets_59",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33666] = {
	name = L["Vengeful Gladiator's Chain Helm"],
	quality = 4,
	icon = "inv_helmet_95",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33667] = {
	name = L["Vengeful Gladiator's Chain Leggings"],
	quality = 4,
	icon = "inv_pants_mail_24",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33668] = {
	name = L["Vengeful Gladiator's Chain Spaulders"],
	quality = 4,
	icon = "inv_shoulder_59",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33669] = {
	name = L["Vengeful Gladiator's Cleaver"],
	quality = 4,
	icon = "inv_axe_84",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33670] = {
	name = L["Vengeful Gladiator's Decapitator"],
	quality = 4,
	icon = "inv_axe_60",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33671] = {
	name = L["Vengeful Gladiator's Dragonhide Gloves"],
	quality = 4,
	icon = "inv_gauntlets_58",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33672] = {
	name = L["Vengeful Gladiator's Dragonhide Helm"],
	quality = 4,
	icon = "inv_helmet_94",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33673] = {
	name = L["Vengeful Gladiator's Dragonhide Legguards"],
	quality = 4,
	icon = "inv_pants_leather_26",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33674] = {
	name = L["Vengeful Gladiator's Dragonhide Spaulders"],
	quality = 4,
	icon = "inv_shoulder_58",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33675] = {
	name = L["Vengeful Gladiator's Dragonhide Tunic"],
	quality = 4,
	icon = "inv_chest_leather_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33681] = {
	name = L["Vengeful Gladiator's Endgame"],
	quality = 4,
	icon = "inv_misc_book_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33687] = {
	name = L["Vengeful Gladiator's Gavel"],
	quality = 4,
	icon = "inv_mace_56",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33688] = {
	name = L["Vengeful Gladiator's Greatsword"],
	quality = 4,
	icon = "inv_sword_108",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33689] = {
	name = L["Vengeful Gladiator's Hacker"],
	quality = 4,
	icon = "inv_axe_84",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33690] = {
	name = L["Vengeful Gladiator's Kodohide Gloves"],
	quality = 4,
	icon = "inv_gauntlets_58",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33691] = {
	name = L["Vengeful Gladiator's Kodohide Helm"],
	quality = 4,
	icon = "inv_helmet_94",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33692] = {
	name = L["Vengeful Gladiator's Kodohide Legguards"],
	quality = 4,
	icon = "inv_pants_leather_26",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33693] = {
	name = L["Vengeful Gladiator's Kodohide Spaulders"],
	quality = 4,
	icon = "inv_shoulder_58",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33694] = {
	name = L["Vengeful Gladiator's Kodohide Tunic"],
	quality = 4,
	icon = "inv_chest_leather_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33695] = {
	name = L["Vengeful Gladiator's Lamellar Chestpiece"],
	quality = 4,
	icon = "inv_chest_plate_22",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33696] = {
	name = L["Vengeful Gladiator's Lamellar Gauntlets"],
	quality = 4,
	icon = "inv_gauntlets_60",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33697] = {
	name = L["Vengeful Gladiator's Lamellar Helm"],
	quality = 4,
	icon = "inv_helmet_96",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33698] = {
	name = L["Vengeful Gladiator's Lamellar Legguards"],
	quality = 4,
	icon = "inv_pants_plate_26",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33699] = {
	name = L["Vengeful Gladiator's Lamellar Shoulders"],
	quality = 4,
	icon = "inv_shoulder_60",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33700] = {
	name = L["Vengeful Gladiator's Leather Gloves"],
	quality = 4,
	icon = "inv_gauntlets_65",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33701] = {
	name = L["Vengeful Gladiator's Leather Helm"],
	quality = 4,
	icon = "inv_helmet_102",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33702] = {
	name = L["Vengeful Gladiator's Leather Legguards"],
	quality = 4,
	icon = "inv_pants_leather_27",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33703] = {
	name = L["Vengeful Gladiator's Leather Spaulders"],
	quality = 4,
	icon = "inv_shoulder_67",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33704] = {
	name = L["Vengeful Gladiator's Leather Tunic"],
	quality = 4,
	icon = "inv_chest_leather_16",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33705] = {
	name = L["Vengeful Gladiator's Left Ripper"],
	quality = 4,
	icon = "inv_weapon_hand_13",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33716] = {
	name = L["Vengeful Gladiator's Staff"],
	quality = 4,
	icon = "inv_staff_60",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33722] = {
	name = L["Vengeful Gladiator's Ornamented Chestguard"],
	quality = 4,
	icon = "inv_chest_plate_22",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33723] = {
	name = L["Vengeful Gladiator's Ornamented Gloves"],
	quality = 4,
	icon = "inv_gauntlets_60",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33724] = {
	name = L["Vengeful Gladiator's Ornamented Headcover"],
	quality = 4,
	icon = "inv_helmet_96",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33725] = {
	name = L["Vengeful Gladiator's Ornamented Legplates"],
	quality = 4,
	icon = "inv_pants_plate_26",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33726] = {
	name = L["Vengeful Gladiator's Ornamented Spaulders"],
	quality = 4,
	icon = "inv_shoulder_60",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33727] = {
	name = L["Vengeful Gladiator's Painsaw"],
	quality = 4,
	icon = "inv_weapon_halberd15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33728] = {
	name = L["Vengeful Gladiator's Plate Chestpiece"],
	quality = 4,
	icon = "inv_chest_plate_23",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33729] = {
	name = L["Vengeful Gladiator's Plate Gauntlets"],
	quality = 4,
	icon = "inv_gauntlets_62",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33730] = {
	name = L["Vengeful Gladiator's Plate Helm"],
	quality = 4,
	icon = "inv_helmet_98",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33731] = {
	name = L["Vengeful Gladiator's Plate Legguards"],
	quality = 4,
	icon = "inv_pants_plate_27",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33732] = {
	name = L["Vengeful Gladiator's Plate Shoulders"],
	quality = 4,
	icon = "inv_shoulder_62",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33733] = {
	name = L["Vengeful Gladiator's Pummeler"],
	quality = 4,
	icon = "inv_mace_41",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33734] = {
	name = L["Vengeful Gladiator's Quickblade"],
	quality = 4,
	icon = "inv_sword_89",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33735] = {
	name = L["Vengeful Gladiator's Redoubt"],
	quality = 4,
	icon = "inv_shield_31",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33736] = {
	name = L["Vengeful Gladiator's Reprieve"],
	quality = 4,
	icon = "inv_misc_book_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33737] = {
	name = L["Vengeful Gladiator's Right Ripper"],
	quality = 4,
	icon = "inv_weapon_hand_13",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33743] = {
	name = L["Vengeful Gladiator's Salvation"],
	quality = 4,
	icon = "inv_mace_56",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33749] = {
	name = L["Vengeful Gladiator's Scaled Chestpiece"],
	quality = 4,
	icon = "inv_chest_plate_22",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33750] = {
	name = L["Vengeful Gladiator's Scaled Gauntlets"],
	quality = 4,
	icon = "inv_gauntlets_60",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33751] = {
	name = L["Vengeful Gladiator's Scaled Helm"],
	quality = 4,
	icon = "inv_helmet_96",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33752] = {
	name = L["Vengeful Gladiator's Scaled Legguards"],
	quality = 4,
	icon = "inv_pants_plate_26",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33753] = {
	name = L["Vengeful Gladiator's Scaled Shoulders"],
	quality = 4,
	icon = "inv_shoulder_60",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33754] = {
	name = L["Vengeful Gladiator's Shanker"],
	quality = 4,
	icon = "inv_weapon_shortblade_62",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33755] = {
	name = L["Vengeful Gladiator's Shield Wall"],
	quality = 4,
	icon = "inv_shield_31",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33756] = {
	name = L["Vengeful Gladiator's Shiv"],
	quality = 4,
	icon = "inv_weapon_shortblade_62",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33757] = {
	name = L["Vengeful Gladiator's Silk Amice"],
	quality = 4,
	icon = "inv_shoulder_64",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33758] = {
	name = L["Vengeful Gladiator's Silk Cowl"],
	quality = 4,
	icon = "inv_helmet_101",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33759] = {
	name = L["Vengeful Gladiator's Silk Handguards"],
	quality = 4,
	icon = "inv_gauntlets_64",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33760] = {
	name = L["Vengeful Gladiator's Silk Raiment"],
	quality = 4,
	icon = "inv_chest_cloth_67",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33761] = {
	name = L["Vengeful Gladiator's Silk Trousers"],
	quality = 4,
	icon = "inv_pants_cloth_28",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33762] = {
	name = L["Vengeful Gladiator's Slicer"],
	quality = 4,
	icon = "inv_sword_89",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33763] = {
	name = L["Vengeful Gladiator's Spellblade"],
	quality = 4,
	icon = "inv_weapon_shortblade_51",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33764] = {
	name = L["Vengeful Gladiator's Touch of Defeat"],
	quality = 4,
	icon = "inv_wand_09",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33765] = {
	name = L["Vengeful Gladiator's War Edge"],
	quality = 4,
	icon = "inv_axe_03",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33766] = {
	name = L["Vengeful Gladiator's War Staff"],
	quality = 4,
	icon = "inv_staff_54",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33767] = {
	name = L["Vengeful Gladiator's Wyrmhide Gloves"],
	quality = 4,
	icon = "inv_gauntlets_58",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33768] = {
	name = L["Vengeful Gladiator's Wyrmhide Helm"],
	quality = 4,
	icon = "inv_helmet_94",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33769] = {
	name = L["Vengeful Gladiator's Wyrmhide Legguards"],
	quality = 4,
	icon = "inv_pants_leather_26",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33770] = {
	name = L["Vengeful Gladiator's Wyrmhide Spaulders"],
	quality = 4,
	icon = "inv_shoulder_58",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33771] = {
	name = L["Vengeful Gladiator's Wyrmhide Tunic"],
	quality = 4,
	icon = "inv_chest_leather_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33801] = {
	name = L["Vengeful Gladiator's Mutilator"],
	quality = 4,
	icon = "inv_weapon_shortblade_62",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33841] = {
	name = L["Vengeful Gladiator's Idol of Tenacity"],
	quality = 4,
	icon = "spell_nature_naturetouchgrow",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33842] = {
	name = L["Vengeful Gladiator's Libram of Justice"],
	quality = 4,
	icon = "inv_misc_book_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33936] = {
	name = L["Gladiator's Libram of Fortitude"],
	quality = 4,
	icon = "inv_relics_libramofhope",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33937] = {
	name = L["Merciless Gladiator's Libram of Fortitude"],
	quality = 4,
	icon = "inv_relics_libramofhope",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33938] = {
	name = L["Vengeful Gladiator's Libram of Fortitude"],
	quality = 4,
	icon = "inv_relics_libramofhope",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33939] = {
	name = L["Gladiator's Totem of Indomitability"],
	quality = 4,
	icon = "spell_nature_slowingtotem",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33940] = {
	name = L["Merciless Gladiator's Totem of Indomitability"],
	quality = 4,
	icon = "spell_nature_slowingtotem",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33942] = {
	name = L["Gladiator's Idol of Steadfastness"],
	quality = 4,
	icon = "inv_relics_idolofhealth",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33943] = {
	name = L["Merciless Gladiator's Idol of Steadfastness"],
	quality = 4,
	icon = "inv_relics_idolofhealth",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33944] = {
	name = L["Vengeful Gladiator's Idol of Steadfastness"],
	quality = 4,
	icon = "inv_relics_idolofhealth",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33945] = {
	name = L["Gladiator's Idol of Resolve"],
	quality = 4,
	icon = "inv_relics_idolofhealth",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33946] = {
	name = L["Merciless Gladiator's Idol of Resolve"],
	quality = 4,
	icon = "inv_relics_idolofhealth",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33947] = {
	name = L["Vengeful Gladiator's Idol of Resolve"],
	quality = 4,
	icon = "inv_relics_idolofhealth",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33948] = {
	name = L["Gladiator's Libram of Vengeance"],
	quality = 4,
	icon = "inv_relics_libramofhope",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33949] = {
	name = L["Merciless Gladiator's Libram of Vengeance"],
	quality = 4,
	icon = "inv_relics_libramofhope",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33950] = {
	name = L["Vengeful Gladiator's Libram of Vengeance"],
	quality = 4,
	icon = "inv_relics_libramofhope",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33951] = {
	name = L["Gladiator's Totem of Survival"],
	quality = 4,
	icon = "spell_nature_slowingtotem",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33952] = {
	name = L["Merciless Gladiator's Totem of Survival"],
	quality = 4,
	icon = "spell_nature_slowingtotem",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34014] = {
	name = L["Vengeful Gladiator's Waraxe"],
	quality = 4,
	icon = "inv_axe_61",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34015] = {
	name = L["Vengeful Gladiator's Chopper"],
	quality = 4,
	icon = "inv_axe_84",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34016] = {
	name = L["Vengeful Gladiator's Left Render"],
	quality = 4,
	icon = "inv_weapon_hand_13",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34033] = {
	name = L["Vengeful Gladiator's Grimoire"],
	quality = 4,
	icon = "inv_misc_book_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34059] = {
	name = L["Vengeful Gladiator's Baton of Light"],
	quality = 4,
	icon = "inv_wand_09",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34066] = {
	name = L["Vengeful Gladiator's Piercing Touch"],
	quality = 4,
	icon = "inv_wand_09",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34529] = {
	name = L["Vengeful Gladiator's Longbow"],
	quality = 4,
	icon = "inv_weapon_bow_20",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34530] = {
	name = L["Vengeful Gladiator's Rifle"],
	quality = 4,
	icon = "inv_weapon_rifle_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34540] = {
	name = L["Vengeful Gladiator's Battle Staff"],
	quality = 4,
	icon = "inv_staff_54",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34985] = {
	name = L["Brutal Gladiator's Baton of Light"],
	quality = 4,
	icon = "inv_wand_09",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34986] = {
	name = L["Brutal Gladiator's Barrier"],
	quality = 4,
	icon = "inv_shield_54",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34987] = {
	name = L["Brutal Gladiator's Battle Staff"],
	quality = 4,
	icon = "inv_staff_74",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34988] = {
	name = L["Brutal Gladiator's Bonecracker"],
	quality = 4,
	icon = "inv_mace_74",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34989] = {
	name = L["Brutal Gladiator's Bonegrinder"],
	quality = 4,
	icon = "inv_mace_49",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34990] = {
	name = L["Brutal Gladiator's Chain Armor"],
	quality = 4,
	icon = "inv_chest_chain_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34991] = {
	name = L["Brutal Gladiator's Chain Gauntlets"],
	quality = 4,
	icon = "inv_gauntlets_65",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34992] = {
	name = L["Brutal Gladiator's Chain Helm"],
	quality = 4,
	icon = "inv_helmet128",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34993] = {
	name = L["Brutal Gladiator's Chain Leggings"],
	quality = 4,
	icon = "inv_pants_mail_20",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34994] = {
	name = L["Brutal Gladiator's Chain Spaulders"],
	quality = 4,
	icon = "inv_shoulder_90",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34995] = {
	name = L["Brutal Gladiator's Chopper"],
	quality = 4,
	icon = "inv_axe_1h_blacksmithing_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34996] = {
	name = L["Brutal Gladiator's Cleaver"],
	quality = 4,
	icon = "inv_axe_1h_blacksmithing_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34997] = {
	name = L["Brutal Gladiator's Decapitator"],
	quality = 4,
	icon = "inv_axe_73",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34998] = {
	name = L["Brutal Gladiator's Dragonhide Gloves"],
	quality = 4,
	icon = "inv_gauntlets_25",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34999] = {
	name = L["Brutal Gladiator's Dragonhide Helm"],
	quality = 4,
	icon = "inv_helmet_126",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35000] = {
	name = L["Brutal Gladiator's Dragonhide Legguards"],
	quality = 4,
	icon = "inv_pants_leather_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35001] = {
	name = L["Brutal Gladiator's Dragonhide Spaulders"],
	quality = 4,
	icon = "inv_shoulder_88",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35002] = {
	name = L["Brutal Gladiator's Dragonhide Tunic"],
	quality = 4,
	icon = "inv_chest_cloth_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35008] = {
	name = L["Brutal Gladiator's Endgame"],
	quality = 4,
	icon = "inv_misc_book_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35014] = {
	name = L["Brutal Gladiator's Gavel"],
	quality = 4,
	icon = "inv_mace_73",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35015] = {
	name = L["Brutal Gladiator's Greatsword"],
	quality = 4,
	icon = "inv_sword_116",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35016] = {
	name = L["Brutal Gladiator's Grimoire"],
	quality = 4,
	icon = "inv_misc_book_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35017] = {
	name = L["Brutal Gladiator's Hacker"],
	quality = 4,
	icon = "inv_axe_1h_blacksmithing_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35018] = {
	name = L["Brutal Gladiator's Heavy Crossbow"],
	quality = 4,
	icon = "inv_weapon_crossbow_26",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35019] = {
	name = L["Brutal Gladiator's Idol of Resolve"],
	quality = 4,
	icon = "inv_relics_idolofhealth",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35020] = {
	name = L["Brutal Gladiator's Idol of Steadfastness"],
	quality = 4,
	icon = "inv_relics_idolofhealth",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35021] = {
	name = L["Brutal Gladiator's Idol of Tenacity"],
	quality = 4,
	icon = "spell_nature_naturetouchgrow",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35022] = {
	name = L["Brutal Gladiator's Kodohide Gloves"],
	quality = 4,
	icon = "inv_gauntlets_25",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35023] = {
	name = L["Brutal Gladiator's Kodohide Helm"],
	quality = 4,
	icon = "inv_helmet_126",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35024] = {
	name = L["Brutal Gladiator's Kodohide Legguards"],
	quality = 4,
	icon = "inv_pants_leather_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35025] = {
	name = L["Brutal Gladiator's Kodohide Spaulders"],
	quality = 4,
	icon = "inv_shoulder_88",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35026] = {
	name = L["Brutal Gladiator's Kodohide Tunic"],
	quality = 4,
	icon = "inv_chest_cloth_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35027] = {
	name = L["Brutal Gladiator's Lamellar Chestpiece"],
	quality = 4,
	icon = "inv_chest_plate_22",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35028] = {
	name = L["Brutal Gladiator's Lamellar Gauntlets"],
	quality = 4,
	icon = "inv_gauntlets_52",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35029] = {
	name = L["Brutal Gladiator's Lamellar Helm"],
	quality = 4,
	icon = "inv_helmet_127",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35030] = {
	name = L["Brutal Gladiator's Lamellar Legguards"],
	quality = 4,
	icon = "inv_pants_plate_29",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35031] = {
	name = L["Brutal Gladiator's Lamellar Shoulders"],
	quality = 4,
	icon = "inv_shoulder_89",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35032] = {
	name = L["Brutal Gladiator's Leather Gloves"],
	quality = 4,
	icon = "inv_gauntlets_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35033] = {
	name = L["Brutal Gladiator's Leather Helm"],
	quality = 4,
	icon = "inv_helmet_126",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35034] = {
	name = L["Brutal Gladiator's Leather Legguards"],
	quality = 4,
	icon = "inv_pants_leather_12",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35035] = {
	name = L["Brutal Gladiator's Leather Spaulders"],
	quality = 4,
	icon = "inv_shoulder_88",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35036] = {
	name = L["Brutal Gladiator's Leather Tunic"],
	quality = 4,
	icon = "inv_chest_leather_03",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35037] = {
	name = L["Brutal Gladiator's Left Render"],
	quality = 4,
	icon = "inv_weapon_hand_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35038] = {
	name = L["Brutal Gladiator's Left Ripper"],
	quality = 4,
	icon = "inv_weapon_hand_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35039] = {
	name = L["Brutal Gladiator's Libram of Fortitude"],
	quality = 4,
	icon = "inv_relics_libramofhope",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35040] = {
	name = L["Brutal Gladiator's Libram of Justice"],
	quality = 4,
	icon = "inv_misc_book_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35041] = {
	name = L["Brutal Gladiator's Libram of Vengeance"],
	quality = 4,
	icon = "inv_relics_libramofhope",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35042] = {
	name = L["Brutal Gladiator's Linked Armor"],
	quality = 4,
	icon = "inv_chest_chain_16",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35043] = {
	name = L["Brutal Gladiator's Linked Gauntlets"],
	quality = 4,
	icon = "inv_gauntlets_65",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35044] = {
	name = L["Brutal Gladiator's Linked Helm"],
	quality = 4,
	icon = "inv_helmet128",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35045] = {
	name = L["Brutal Gladiator's Linked Leggings"],
	quality = 4,
	icon = "inv_pants_mail_20",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35046] = {
	name = L["Brutal Gladiator's Linked Spaulders"],
	quality = 4,
	icon = "inv_shoulder_90",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35047] = {
	name = L["Brutal Gladiator's Longbow"],
	quality = 4,
	icon = "inv_weapon_bow_31",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35048] = {
	name = L["Brutal Gladiator's Mail Armor"],
	quality = 4,
	icon = "inv_chest_chain_16",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35049] = {
	name = L["Brutal Gladiator's Mail Gauntlets"],
	quality = 4,
	icon = "inv_gauntlets_65",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35050] = {
	name = L["Brutal Gladiator's Mail Helm"],
	quality = 4,
	icon = "inv_helmet128",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35051] = {
	name = L["Brutal Gladiator's Mail Leggings"],
	quality = 4,
	icon = "inv_pants_mail_20",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35052] = {
	name = L["Brutal Gladiator's Mail Spaulders"],
	quality = 4,
	icon = "inv_shoulder_90",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35053] = {
	name = L["Brutal Gladiator's Mooncloth Gloves"],
	quality = 4,
	icon = "inv_gauntlets_64",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35054] = {
	name = L["Brutal Gladiator's Mooncloth Hood"],
	quality = 4,
	icon = "inv_helmet_132",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35055] = {
	name = L["Brutal Gladiator's Mooncloth Leggings"],
	quality = 4,
	icon = "inv_pants_cloth_28",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35056] = {
	name = L["Brutal Gladiator's Mooncloth Mantle"],
	quality = 4,
	icon = "inv_shoulder_96",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35057] = {
	name = L["Brutal Gladiator's Mooncloth Robe"],
	quality = 4,
	icon = "inv_chest_cloth_60",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35058] = {
	name = L["Brutal Gladiator's Mutilator"],
	quality = 4,
	icon = "inv_weapon_shortblade_75",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35059] = {
	name = L["Brutal Gladiator's Ornamented Chestguard"],
	quality = 4,
	icon = "inv_chest_plate_22",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35060] = {
	name = L["Brutal Gladiator's Ornamented Gloves"],
	quality = 4,
	icon = "inv_gauntlets_52",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35061] = {
	name = L["Brutal Gladiator's Ornamented Headcover"],
	quality = 4,
	icon = "inv_helmet_127",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35062] = {
	name = L["Brutal Gladiator's Ornamented Legplates"],
	quality = 4,
	icon = "inv_pants_plate_29",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35063] = {
	name = L["Brutal Gladiator's Ornamented Spaulders"],
	quality = 4,
	icon = "inv_shoulder_89",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35064] = {
	name = L["Brutal Gladiator's Painsaw"],
	quality = 4,
	icon = "inv_weapon_halberd_20",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35065] = {
	name = L["Brutal Gladiator's Piercing Touch"],
	quality = 4,
	icon = "inv_wand_09",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35071] = {
	name = L["Brutal Gladiator's Pummeler"],
	quality = 4,
	icon = "inv_mace_74",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35072] = {
	name = L["Brutal Gladiator's Quickblade"],
	quality = 4,
	icon = "inv_sword_114",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35073] = {
	name = L["Brutal Gladiator's Redoubt"],
	quality = 4,
	icon = "inv_shield_52",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35074] = {
	name = L["Brutal Gladiator's Reprieve"],
	quality = 4,
	icon = "inv_misc_book_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35075] = {
	name = L["Brutal Gladiator's Rifle"],
	quality = 4,
	icon = "inv_weapon_rifle_21",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35076] = {
	name = L["Brutal Gladiator's Right Ripper"],
	quality = 4,
	icon = "inv_weapon_hand_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35077] = {
	name = L["Brutal Gladiator's Ringmail Armor"],
	quality = 4,
	icon = "inv_chest_chain_16",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35078] = {
	name = L["Brutal Gladiator's Ringmail Gauntlets"],
	quality = 4,
	icon = "inv_gauntlets_65",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35079] = {
	name = L["Brutal Gladiator's Ringmail Helm"],
	quality = 4,
	icon = "inv_helmet128",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35080] = {
	name = L["Brutal Gladiator's Ringmail Leggings"],
	quality = 4,
	icon = "inv_pants_mail_20",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35081] = {
	name = L["Brutal Gladiator's Ringmail Spaulders"],
	quality = 4,
	icon = "inv_shoulder_90",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35082] = {
	name = L["Brutal Gladiator's Salvation"],
	quality = 4,
	icon = "inv_mace_71",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35083] = {
	name = L["Brutal Gladiator's Satin Gloves"],
	quality = 4,
	icon = "inv_gauntlets_64",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35084] = {
	name = L["Brutal Gladiator's Satin Hood"],
	quality = 4,
	icon = "inv_helmet_132",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35085] = {
	name = L["Brutal Gladiator's Satin Leggings"],
	quality = 4,
	icon = "inv_pants_cloth_28",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35086] = {
	name = L["Brutal Gladiator's Satin Mantle"],
	quality = 4,
	icon = "inv_shoulder_96",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35087] = {
	name = L["Brutal Gladiator's Satin Robe"],
	quality = 4,
	icon = "inv_chest_cloth_60",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35088] = {
	name = L["Brutal Gladiator's Scaled Chestpiece"],
	quality = 4,
	icon = "inv_chest_plate_22",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35089] = {
	name = L["Brutal Gladiator's Scaled Gauntlets"],
	quality = 4,
	icon = "inv_gauntlets_52",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35090] = {
	name = L["Brutal Gladiator's Scaled Helm"],
	quality = 4,
	icon = "inv_helmet_127",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35091] = {
	name = L["Brutal Gladiator's Scaled Legguards"],
	quality = 4,
	icon = "inv_pants_plate_29",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35092] = {
	name = L["Brutal Gladiator's Scaled Shoulders"],
	quality = 4,
	icon = "inv_shoulder_89",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35093] = {
	name = L["Brutal Gladiator's Shanker"],
	quality = 4,
	icon = "inv_weapon_shortblade_75",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35094] = {
	name = L["Brutal Gladiator's Shield Wall"],
	quality = 4,
	icon = "inv_shield_53",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35095] = {
	name = L["Brutal Gladiator's Shiv"],
	quality = 4,
	icon = "inv_weapon_shortblade_75",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35096] = {
	name = L["Brutal Gladiator's Silk Amice"],
	quality = 4,
	icon = "inv_shoulder_96",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35097] = {
	name = L["Brutal Gladiator's Silk Cowl"],
	quality = 4,
	icon = "inv_helmet_132",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35098] = {
	name = L["Brutal Gladiator's Silk Handguards"],
	quality = 4,
	icon = "inv_gauntlets_47",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35099] = {
	name = L["Brutal Gladiator's Silk Raiment"],
	quality = 4,
	icon = "inv_chest_cloth_62",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35100] = {
	name = L["Brutal Gladiator's Silk Trousers"],
	quality = 4,
	icon = "inv_pants_cloth_27",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35101] = {
	name = L["Brutal Gladiator's Slicer"],
	quality = 4,
	icon = "inv_sword_114",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35102] = {
	name = L["Brutal Gladiator's Spellblade"],
	quality = 4,
	icon = "inv_weapon_shortblade_73",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35103] = {
	name = L["Brutal Gladiator's Staff"],
	quality = 4,
	icon = "inv_staff_60",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35104] = {
	name = L["Brutal Gladiator's Totem of Indomitability"],
	quality = 4,
	icon = "spell_nature_slowingtotem",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35105] = {
	name = L["Brutal Gladiator's Totem of Survival"],
	quality = 4,
	icon = "spell_nature_slowingtotem",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35106] = {
	name = L["Brutal Gladiator's Totem of the Third Wind"],
	quality = 4,
	icon = "spell_frost_summonwaterelemental",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35107] = {
	name = L["Brutal Gladiator's Touch of Defeat"],
	quality = 4,
	icon = "inv_wand_09",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35108] = {
	name = L["Brutal Gladiator's War Edge"],
	quality = 4,
	icon = "inv_axe_03",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35109] = {
	name = L["Brutal Gladiator's War Staff"],
	quality = 4,
	icon = "inv_staff_74",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35110] = {
	name = L["Brutal Gladiator's Waraxe"],
	quality = 4,
	icon = "inv_axe_1h_blacksmithing_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35111] = {
	name = L["Brutal Gladiator's Wyrmhide Gloves"],
	quality = 4,
	icon = "inv_gauntlets_25",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35112] = {
	name = L["Brutal Gladiator's Wyrmhide Helm"],
	quality = 4,
	icon = "inv_helmet_126",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35113] = {
	name = L["Brutal Gladiator's Wyrmhide Legguards"],
	quality = 4,
	icon = "inv_pants_leather_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35114] = {
	name = L["Brutal Gladiator's Wyrmhide Spaulders"],
	quality = 4,
	icon = "inv_shoulder_88",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35115] = {
	name = L["Brutal Gladiator's Wyrmhide Tunic"],
	quality = 4,
	icon = "inv_chest_cloth_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[36737] = {
	name = L["Brutal Gladiator's Hatchet"],
	quality = 4,
	icon = "inv_axe_1h_blacksmithing_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[38545] = {
	name = L["Bold Ornate Ruby"],
	quality = 4,
	icon = "inv_misc_gem_ruby_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[38546] = {
	name = L["Gleaming Ornate Dawnstone"],
	quality = 4,
	icon = "inv_misc_gem_topaz_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[38547] = {
	name = L["Inscribed Ornate Topaz"],
	quality = 4,
	icon = "inv_misc_gem_opal_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[38548] = {
	name = L["Potent Ornate Topaz"],
	quality = 4,
	icon = "inv_misc_gem_opal_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[38549] = {
	name = L["Runed Ornate Ruby"],
	quality = 4,
	icon = "inv_misc_gem_bloodstone_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[38550] = {
	name = L["Smooth Ornate Dawnstone"],
	quality = 4,
	icon = "inv_misc_gem_topaz_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[8490] = {
	name = L["Cat Carrier (Siamese)"],
	quality = 1,
	icon = "inv_box_petcarrier_01",
	buyPrice = 6000,
	sellPrice = 1500,
	reqLevel = 0,
}
t[8495] = {
	name = L["Parrot Cage (Senegal)"],
	quality = 1,
	icon = "spell_nature_forceofnature",
	buyPrice = 4000,
	sellPrice = 1000,
	reqLevel = 0,
}
t[10392] = {
	name = L["Crimson Snake"],
	quality = 1,
	icon = "spell_nature_guardianward",
	buyPrice = 5000,
	sellPrice = 1250,
	reqLevel = 0,
}
t[10393] = {
	name = L["Cockroach"],
	quality = 1,
	icon = "inv_pet_cockroach",
	buyPrice = 5000,
	sellPrice = 1250,
	reqLevel = 0,
}
t[29363] = {
	name = L["Mana Wyrmling"],
	quality = 1,
	icon = "spell_nature_abolishmagic",
	buyPrice = 400000,
	sellPrice = 100000,
	reqLevel = 0,
}
t[29364] = {
	name = L["Brown Rabbit Crate"],
	quality = 1,
	icon = "inv_crate_02",
	buyPrice = 100000,
	sellPrice = 25000,
	reqLevel = 0,
}
t[29902] = {
	name = L["Red Moth Egg"],
	quality = 1,
	icon = "ability_hunter_pet_moth",
	buyPrice = 100000,
	sellPrice = 25000,
	reqLevel = 0,
}
t[29958] = {
	name = L["Blue Dragonhawk Hatchling"],
	quality = 1,
	icon = "ability_hunter_pet_dragonhawk",
	buyPrice = 100000,
	sellPrice = 25000,
	reqLevel = 0,
}
t[22572] = {
	name = L["Mote of Air"],
	quality = 1,
	icon = "inv_elemental_mote_air01",
	buyPrice = 1600,
	sellPrice = 400,
	reqLevel = 0,
}
t[22573] = {
	name = L["Mote of Earth"],
	quality = 1,
	icon = "inv_elemental_mote_earth01",
	buyPrice = 1600,
	sellPrice = 400,
	reqLevel = 0,
}
t[22574] = {
	name = L["Mote of Fire"],
	quality = 1,
	icon = "inv_elemental_mote_fire01",
	buyPrice = 1600,
	sellPrice = 400,
	reqLevel = 0,
}
t[22575] = {
	name = L["Mote of Life"],
	quality = 1,
	icon = "inv_elemental_mote_life01",
	buyPrice = 1600,
	sellPrice = 400,
	reqLevel = 0,
}
t[22576] = {
	name = L["Mote of Mana"],
	quality = 1,
	icon = "inv_elemental_mote_mana",
	buyPrice = 1600,
	sellPrice = 400,
	reqLevel = 0,
}
t[22577] = {
	name = L["Mote of Shadow"],
	quality = 1,
	icon = "inv_elemental_mote_shadow01",
	buyPrice = 1600,
	sellPrice = 400,
	reqLevel = 0,
}
t[22578] = {
	name = L["Mote of Water"],
	quality = 1,
	icon = "inv_elemental_mote_water01",
	buyPrice = 1600,
	sellPrice = 400,
	reqLevel = 0,
}
t[23785] = {
	name = L["Hardened Adamantite Tube"],
	quality = 1,
	icon = "inv_gizmo_hardenedadamantitetube",
	buyPrice = 120000,
	sellPrice = 30000,
	reqLevel = 0,
}
t[13467] = {
	name = L["Icecap"],
	quality = 1,
	icon = "inv_misc_herb_icecap",
	buyPrice = 1000,
	sellPrice = 250,
	reqLevel = 0,
}
t[22785] = {
	name = L["Felweed"],
	quality = 1,
	icon = "inv_misc_herb_felweed",
	buyPrice = 2000,
	sellPrice = 500,
	reqLevel = 0,
}
t[22786] = {
	name = L["Dreaming Glory"],
	quality = 1,
	icon = "inv_misc_herb_dreamingglory",
	buyPrice = 2000,
	sellPrice = 500,
	reqLevel = 0,
}
t[22791] = {
	name = L["Netherbloom"],
	quality = 1,
	icon = "inv_misc_herb_netherbloom",
	buyPrice = 4000,
	sellPrice = 1000,
	reqLevel = 0,
}
t[22793] = {
	name = L["Mana Thistle"],
	quality = 1,
	icon = "inv_misc_herb_manathistle",
	buyPrice = 6000,
	sellPrice = 1500,
	reqLevel = 0,
}
t[22829] = {
	name = L["Super Healing Potion"],
	quality = 1,
	icon = "inv_potion_131",
	buyPrice = 20000,
	sellPrice = 5000,
	reqLevel = 55,
}
t[22832] = {
	name = L["Super Mana Potion"],
	quality = 1,
	icon = "inv_potion_137",
	buyPrice = 20000,
	sellPrice = 5000,
	reqLevel = 55,
}
t[22845] = {
	name = L["Major Arcane Protection Potion"],
	quality = 1,
	icon = "inv_potion_128",
	buyPrice = 20000,
	sellPrice = 5000,
	reqLevel = 60,
}
t[22846] = {
	name = L["Major Shadow Protection Potion"],
	quality = 1,
	icon = "inv_potion_123",
	buyPrice = 20000,
	sellPrice = 5000,
	reqLevel = 60,
}
t[33676] = {
	name = L["Vengeful Gladiator's Dreadweave Gloves"],
	quality = 4,
	icon = "inv_gauntlets_66",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33677] = {
	name = L["Vengeful Gladiator's Dreadweave Hood"],
	quality = 4,
	icon = "inv_helmet_103",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33678] = {
	name = L["Vengeful Gladiator's Dreadweave Leggings"],
	quality = 4,
	icon = "inv_pants_cloth_29",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33679] = {
	name = L["Vengeful Gladiator's Dreadweave Mantle"],
	quality = 4,
	icon = "inv_shoulder_68",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33680] = {
	name = L["Vengeful Gladiator's Dreadweave Robe"],
	quality = 4,
	icon = "inv_chest_cloth_68",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33682] = {
	name = L["Vengeful Gladiator's Felweave Amice"],
	quality = 4,
	icon = "inv_shoulder_68",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33683] = {
	name = L["Vengeful Gladiator's Felweave Cowl"],
	quality = 4,
	icon = "inv_helmet_103",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33684] = {
	name = L["Vengeful Gladiator's Felweave Handguards"],
	quality = 4,
	icon = "inv_gauntlets_66",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33685] = {
	name = L["Vengeful Gladiator's Felweave Raiment"],
	quality = 4,
	icon = "inv_chest_cloth_68",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33686] = {
	name = L["Vengeful Gladiator's Felweave Trousers"],
	quality = 4,
	icon = "inv_pants_cloth_29",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33706] = {
	name = L["Vengeful Gladiator's Linked Armor"],
	quality = 4,
	icon = "inv_chest_mail_04",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33707] = {
	name = L["Vengeful Gladiator's Linked Gauntlets"],
	quality = 4,
	icon = "inv_gauntlets_61",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33708] = {
	name = L["Vengeful Gladiator's Linked Helm"],
	quality = 4,
	icon = "inv_helmet_97",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33709] = {
	name = L["Vengeful Gladiator's Linked Leggings"],
	quality = 4,
	icon = "inv_pants_mail_25",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33710] = {
	name = L["Vengeful Gladiator's Linked Spaulders"],
	quality = 4,
	icon = "inv_shoulder_61",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33711] = {
	name = L["Vengeful Gladiator's Mail Armor"],
	quality = 4,
	icon = "inv_chest_mail_04",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33712] = {
	name = L["Vengeful Gladiator's Mail Gauntlets"],
	quality = 4,
	icon = "inv_gauntlets_61",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33713] = {
	name = L["Vengeful Gladiator's Mail Helm"],
	quality = 4,
	icon = "inv_helmet_97",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33714] = {
	name = L["Vengeful Gladiator's Mail Leggings"],
	quality = 4,
	icon = "inv_pants_mail_25",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33715] = {
	name = L["Vengeful Gladiator's Mail Spaulders"],
	quality = 4,
	icon = "inv_shoulder_61",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33717] = {
	name = L["Vengeful Gladiator's Mooncloth Gloves"],
	quality = 4,
	icon = "inv_gauntlets_63",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33718] = {
	name = L["Vengeful Gladiator's Mooncloth Hood"],
	quality = 4,
	icon = "inv_helmet_99",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33719] = {
	name = L["Vengeful Gladiator's Mooncloth Leggings"],
	quality = 4,
	icon = "inv_pants_cloth_27",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33720] = {
	name = L["Vengeful Gladiator's Mooncloth Mantle"],
	quality = 4,
	icon = "inv_shoulder_63",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33721] = {
	name = L["Vengeful Gladiator's Mooncloth Robe"],
	quality = 4,
	icon = "inv_chest_cloth_66",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33738] = {
	name = L["Vengeful Gladiator's Ringmail Armor"],
	quality = 4,
	icon = "inv_chest_mail_04",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33739] = {
	name = L["Vengeful Gladiator's Ringmail Gauntlets"],
	quality = 4,
	icon = "inv_gauntlets_61",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33740] = {
	name = L["Vengeful Gladiator's Ringmail Helm"],
	quality = 4,
	icon = "inv_helmet_97",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33741] = {
	name = L["Vengeful Gladiator's Ringmail Leggings"],
	quality = 4,
	icon = "inv_pants_mail_25",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33742] = {
	name = L["Vengeful Gladiator's Ringmail Spaulders"],
	quality = 4,
	icon = "inv_shoulder_61",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33744] = {
	name = L["Vengeful Gladiator's Satin Gloves"],
	quality = 4,
	icon = "inv_gauntlets_63",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33745] = {
	name = L["Vengeful Gladiator's Satin Hood"],
	quality = 4,
	icon = "inv_helmet_99",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33746] = {
	name = L["Vengeful Gladiator's Satin Leggings"],
	quality = 4,
	icon = "inv_pants_cloth_27",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33747] = {
	name = L["Vengeful Gladiator's Satin Mantle"],
	quality = 4,
	icon = "inv_shoulder_63",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33748] = {
	name = L["Vengeful Gladiator's Satin Robe"],
	quality = 4,
	icon = "inv_chest_cloth_66",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33843] = {
	name = L["Vengeful Gladiator's Totem of the Third Wind"],
	quality = 4,
	icon = "spell_frost_summonwaterelemental",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33941] = {
	name = L["Vengeful Gladiator's Totem of Indomitability"],
	quality = 4,
	icon = "spell_nature_slowingtotem",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33953] = {
	name = L["Vengeful Gladiator's Totem of Survival"],
	quality = 4,
	icon = "spell_nature_slowingtotem",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35003] = {
	name = L["Brutal Gladiator's Dreadweave Gloves"],
	quality = 4,
	icon = "inv_gauntlets_49",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35004] = {
	name = L["Brutal Gladiator's Dreadweave Hood"],
	quality = 4,
	icon = "inv_helmet_132",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35005] = {
	name = L["Brutal Gladiator's Dreadweave Leggings"],
	quality = 4,
	icon = "inv_pants_cloth_22",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35006] = {
	name = L["Brutal Gladiator's Dreadweave Mantle"],
	quality = 4,
	icon = "inv_shoulder_96",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35007] = {
	name = L["Brutal Gladiator's Dreadweave Robe"],
	quality = 4,
	icon = "inv_chest_cloth_61",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35009] = {
	name = L["Brutal Gladiator's Felweave Amice"],
	quality = 4,
	icon = "inv_shoulder_96",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35010] = {
	name = L["Brutal Gladiator's Felweave Cowl"],
	quality = 4,
	icon = "inv_helmet_132",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35011] = {
	name = L["Brutal Gladiator's Felweave Handguards"],
	quality = 4,
	icon = "inv_gauntlets_49",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35012] = {
	name = L["Brutal Gladiator's Felweave Raiment"],
	quality = 4,
	icon = "inv_chest_cloth_61",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35013] = {
	name = L["Brutal Gladiator's Felweave Trousers"],
	quality = 4,
	icon = "inv_pants_cloth_22",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35066] = {
	name = L["Brutal Gladiator's Plate Chestpiece"],
	quality = 4,
	icon = "inv_chest_plate_23",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35067] = {
	name = L["Brutal Gladiator's Plate Gauntlets"],
	quality = 4,
	icon = "inv_gauntlets_62",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35068] = {
	name = L["Brutal Gladiator's Plate Helm"],
	quality = 4,
	icon = "inv_helmet_127",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35069] = {
	name = L["Brutal Gladiator's Plate Legguards"],
	quality = 4,
	icon = "inv_pants_plate_27",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35070] = {
	name = L["Brutal Gladiator's Plate Shoulders"],
	quality = 4,
	icon = "inv_shoulder_89",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[40778] = {
	name = L["Savage Gladiator's Plate Chestpiece"],
	quality = 3,
	icon = "inv_chest_plate_23",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40779] = {
	name = L["Savage Gladiator's Dreadplate Chestpiece"],
	quality = 3,
	icon = "inv_chest_plate_23",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40780] = {
	name = L["Savage Gladiator's Scaled Chestpiece"],
	quality = 3,
	icon = "inv_chest_plate_23",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40797] = {
	name = L["Savage Gladiator's Plate Gauntlets"],
	quality = 3,
	icon = "inv_gauntlets_62",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40798] = {
	name = L["Savage Gladiator's Scaled Gauntlets"],
	quality = 3,
	icon = "inv_gauntlets_62",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40799] = {
	name = L["Savage Gladiator's Dreadplate Gauntlets"],
	quality = 3,
	icon = "inv_gauntlets_62",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40816] = {
	name = L["Savage Gladiator's Plate Helm"],
	quality = 3,
	icon = "inv_helmet_98",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40817] = {
	name = L["Savage Gladiator's Dreadplate Helm"],
	quality = 3,
	icon = "inv_helmet_135",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40818] = {
	name = L["Savage Gladiator's Scaled Helm"],
	quality = 3,
	icon = "inv_helmet_124",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40836] = {
	name = L["Savage Gladiator's Plate Legguards"],
	quality = 3,
	icon = "inv_pants_plate_27",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40837] = {
	name = L["Savage Gladiator's Dreadplate Legguards"],
	quality = 3,
	icon = "inv_pants_plate_27",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40838] = {
	name = L["Savage Gladiator's Scaled Legguards"],
	quality = 3,
	icon = "inv_pants_plate_27",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40856] = {
	name = L["Savage Gladiator's Plate Shoulders"],
	quality = 3,
	icon = "inv_shoulder_62",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40857] = {
	name = L["Savage Gladiator's Dreadplate Shoulders"],
	quality = 3,
	icon = "inv_shoulder_99",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40858] = {
	name = L["Savage Gladiator's Scaled Shoulders"],
	quality = 3,
	icon = "inv_shoulder_62",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40898] = {
	name = L["Savage Gladiator's Ornamented Chestguard"],
	quality = 3,
	icon = "inv_chest_plate_23",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40918] = {
	name = L["Savage Gladiator's Ornamented Gloves"],
	quality = 3,
	icon = "inv_gauntlets_62",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40930] = {
	name = L["Savage Gladiator's Ornamented Headcover"],
	quality = 3,
	icon = "inv_helmet_124",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40936] = {
	name = L["Savage Gladiator's Ornamented Legplates"],
	quality = 3,
	icon = "inv_pants_plate_27",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40960] = {
	name = L["Savage Gladiator's Ornamented Spaulders"],
	quality = 3,
	icon = "inv_shoulder_62",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40986] = {
	name = L["Savage Gladiator's Ringmail Armor"],
	quality = 3,
	icon = "inv_chest_mail_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40987] = {
	name = L["Savage Gladiator's Mail Armor"],
	quality = 3,
	icon = "inv_chest_mail_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40998] = {
	name = L["Savage Gladiator's Ringmail Gauntlets"],
	quality = 3,
	icon = "inv_gauntlets_65",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41004] = {
	name = L["Savage Gladiator's Mail Gauntlets"],
	quality = 3,
	icon = "inv_gauntlets_65",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41010] = {
	name = L["Savage Gladiator's Ringmail Helm"],
	quality = 3,
	icon = "inv_helmet_140",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41016] = {
	name = L["Savage Gladiator's Mail Helm"],
	quality = 3,
	icon = "inv_helmet_140",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41023] = {
	name = L["Savage Gladiator's Ringmail Leggings"],
	quality = 3,
	icon = "inv_pants_mail_25",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41024] = {
	name = L["Savage Gladiator's Ringmail Spaulders"],
	quality = 3,
	icon = "inv_shoulder_104",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41030] = {
	name = L["Savage Gladiator's Mail Leggings"],
	quality = 3,
	icon = "inv_pants_mail_25",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41041] = {
	name = L["Savage Gladiator's Mail Spaulders"],
	quality = 3,
	icon = "inv_shoulder_104",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41078] = {
	name = L["Savage Gladiator's Linked Armor"],
	quality = 3,
	icon = "inv_chest_mail_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41084] = {
	name = L["Savage Gladiator's Chain Armor"],
	quality = 3,
	icon = "inv_chest_mail_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41134] = {
	name = L["Savage Gladiator's Linked Gauntlets"],
	quality = 3,
	icon = "inv_gauntlets_65",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41140] = {
	name = L["Savage Gladiator's Chain Gauntlets"],
	quality = 3,
	icon = "inv_gauntlets_65",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41148] = {
	name = L["Savage Gladiator's Linked Helm"],
	quality = 3,
	icon = "inv_helmet_140",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41154] = {
	name = L["Savage Gladiator's Chain Helm"],
	quality = 3,
	icon = "inv_helmet128",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41160] = {
	name = L["Savage Gladiator's Linked Leggings"],
	quality = 3,
	icon = "inv_pants_mail_25",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41202] = {
	name = L["Savage Gladiator's Chain Leggings"],
	quality = 3,
	icon = "inv_pants_mail_26",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41208] = {
	name = L["Savage Gladiator's Linked Spaulders"],
	quality = 3,
	icon = "inv_shoulder_104",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41214] = {
	name = L["Savage Gladiator's Chain Spaulders"],
	quality = 3,
	icon = "inv_shoulder_101",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41268] = {
	name = L["Savage Gladiator's Kodohide Gloves"],
	quality = 3,
	icon = "inv_gauntlets_58",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41269] = {
	name = L["Savage Gladiator's Kodohide Helm"],
	quality = 3,
	icon = "inv_helmet_141",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41270] = {
	name = L["Savage Gladiator's Kodohide Legguards"],
	quality = 3,
	icon = "inv_pants_leather_23",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41271] = {
	name = L["Savage Gladiator's Kodohide Spaulders"],
	quality = 3,
	icon = "inv_shoulder_98",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41272] = {
	name = L["Savage Gladiator's Kodohide Robes"],
	quality = 3,
	icon = "inv_chest_leather_12",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41278] = {
	name = L["Savage Gladiator's Wyrmhide Spaulders"],
	quality = 3,
	icon = "inv_shoulder_98",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41290] = {
	name = L["Savage Gladiator's Wyrmhide Gloves"],
	quality = 3,
	icon = "inv_gauntlets_58",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41301] = {
	name = L["Savage Gladiator's Wyrmhide Legguards"],
	quality = 3,
	icon = "inv_pants_leather_23",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41313] = {
	name = L["Savage Gladiator's Wyrmhide Robes"],
	quality = 3,
	icon = "inv_chest_leather_12",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41324] = {
	name = L["Savage Gladiator's Wyrmhide Helm"],
	quality = 3,
	icon = "inv_helmet_141",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41643] = {
	name = L["Savage Gladiator's Leather Gloves"],
	quality = 3,
	icon = "inv_gauntlets_49",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41644] = {
	name = L["Savage Gladiator's Leather Helm"],
	quality = 3,
	icon = "inv_misc_bandana_03",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41645] = {
	name = L["Savage Gladiator's Leather Legguards"],
	quality = 3,
	icon = "inv_pants_leather_25",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41646] = {
	name = L["Savage Gladiator's Leather Spaulders"],
	quality = 3,
	icon = "inv_shoulder_95",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41647] = {
	name = L["Savage Gladiator's Leather Tunic"],
	quality = 3,
	icon = "inv_chest_leather_13",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41658] = {
	name = L["Savage Gladiator's Dragonhide Robes"],
	quality = 3,
	icon = "inv_chest_leather_12",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41664] = {
	name = L["Savage Gladiator's Dragonhide Legguards"],
	quality = 3,
	icon = "inv_pants_leather_23",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41675] = {
	name = L["Savage Gladiator's Dragonhide Helm"],
	quality = 3,
	icon = "inv_helmet_141",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41712] = {
	name = L["Savage Gladiator's Dragonhide Spaulders"],
	quality = 3,
	icon = "inv_shoulder_98",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41770] = {
	name = L["Savage Gladiator's Dragonhide Gloves"],
	quality = 3,
	icon = "inv_gauntlets_58",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41990] = {
	name = L["Savage Gladiator's Felweave Cowl"],
	quality = 3,
	icon = "inv_helmet_139",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41996] = {
	name = L["Savage Gladiator's Felweave Raiment"],
	quality = 3,
	icon = "inv_chest_cloth_63",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[42002] = {
	name = L["Savage Gladiator's Felweave Trousers"],
	quality = 3,
	icon = "inv_pants_cloth_28",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[42008] = {
	name = L["Savage Gladiator's Felweave Amice"],
	quality = 3,
	icon = "inv_shoulder_99",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[42014] = {
	name = L["Savage Gladiator's Felweave Handguards"],
	quality = 3,
	icon = "inv_gauntlets_64",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[45706] = {
	name = L["Commendation of Bravery"],
	quality = 4,
	icon = "spell_holy_divinepurpose",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[40781] = {
	name = L["Hateful Gladiator's Dreadplate Chestpiece"],
	quality = 4,
	icon = "inv_chest_plate_23",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40782] = {
	name = L["Hateful Gladiator's Scaled Chestpiece"],
	quality = 4,
	icon = "inv_chest_plate_23",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40783] = {
	name = L["Hateful Gladiator's Plate Chestpiece"],
	quality = 4,
	icon = "inv_chest_plate_23",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40801] = {
	name = L["Hateful Gladiator's Plate Gauntlets"],
	quality = 4,
	icon = "inv_gauntlets_62",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40802] = {
	name = L["Hateful Gladiator's Scaled Gauntlets"],
	quality = 4,
	icon = "inv_gauntlets_62",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40803] = {
	name = L["Hateful Gladiator's Dreadplate Gauntlets"],
	quality = 4,
	icon = "inv_gauntlets_62",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40819] = {
	name = L["Hateful Gladiator's Plate Helm"],
	quality = 4,
	icon = "inv_helmet_98",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40820] = {
	name = L["Hateful Gladiator's Dreadplate Helm"],
	quality = 4,
	icon = "inv_helmet_135",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40821] = {
	name = L["Hateful Gladiator's Scaled Helm"],
	quality = 4,
	icon = "inv_helmet_124",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40840] = {
	name = L["Hateful Gladiator's Plate Legguards"],
	quality = 4,
	icon = "inv_pants_plate_27",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40841] = {
	name = L["Hateful Gladiator's Dreadplate Legguards"],
	quality = 4,
	icon = "inv_pants_plate_27",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40842] = {
	name = L["Hateful Gladiator's Scaled Legguards"],
	quality = 4,
	icon = "inv_pants_plate_27",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40859] = {
	name = L["Hateful Gladiator's Plate Shoulders"],
	quality = 4,
	icon = "inv_shoulder_62",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40860] = {
	name = L["Hateful Gladiator's Dreadplate Shoulders"],
	quality = 4,
	icon = "inv_shoulder_99",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40861] = {
	name = L["Hateful Gladiator's Scaled Shoulders"],
	quality = 4,
	icon = "inv_shoulder_62",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40904] = {
	name = L["Hateful Gladiator's Ornamented Chestguard"],
	quality = 4,
	icon = "inv_chest_plate_23",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40925] = {
	name = L["Hateful Gladiator's Ornamented Gloves"],
	quality = 4,
	icon = "inv_gauntlets_62",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40931] = {
	name = L["Hateful Gladiator's Ornamented Headcover"],
	quality = 4,
	icon = "inv_helmet_124",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40937] = {
	name = L["Hateful Gladiator's Ornamented Legplates"],
	quality = 4,
	icon = "inv_pants_plate_27",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40961] = {
	name = L["Hateful Gladiator's Ornamented Spaulders"],
	quality = 4,
	icon = "inv_shoulder_62",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40988] = {
	name = L["Hateful Gladiator's Ringmail Armor"],
	quality = 4,
	icon = "inv_chest_mail_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40989] = {
	name = L["Hateful Gladiator's Mail Armor"],
	quality = 4,
	icon = "inv_chest_mail_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40999] = {
	name = L["Hateful Gladiator's Ringmail Gauntlets"],
	quality = 4,
	icon = "inv_gauntlets_65",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41005] = {
	name = L["Hateful Gladiator's Mail Gauntlets"],
	quality = 4,
	icon = "inv_gauntlets_65",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41011] = {
	name = L["Hateful Gladiator's Ringmail Helm"],
	quality = 4,
	icon = "inv_helmet_140",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41017] = {
	name = L["Hateful Gladiator's Mail Helm"],
	quality = 4,
	icon = "inv_helmet_140",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41025] = {
	name = L["Hateful Gladiator's Ringmail Leggings"],
	quality = 4,
	icon = "inv_pants_mail_25",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41031] = {
	name = L["Hateful Gladiator's Mail Leggings"],
	quality = 4,
	icon = "inv_pants_mail_25",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41036] = {
	name = L["Hateful Gladiator's Ringmail Spaulders"],
	quality = 4,
	icon = "inv_shoulder_104",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41042] = {
	name = L["Hateful Gladiator's Mail Spaulders"],
	quality = 4,
	icon = "inv_shoulder_104",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41079] = {
	name = L["Hateful Gladiator's Linked Armor"],
	quality = 4,
	icon = "inv_chest_mail_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41085] = {
	name = L["Hateful Gladiator's Chain Armor"],
	quality = 4,
	icon = "inv_chest_mail_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41135] = {
	name = L["Hateful Gladiator's Linked Gauntlets"],
	quality = 4,
	icon = "inv_gauntlets_65",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41141] = {
	name = L["Hateful Gladiator's Chain Gauntlets"],
	quality = 4,
	icon = "inv_gauntlets_65",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41149] = {
	name = L["Hateful Gladiator's Linked Helm"],
	quality = 4,
	icon = "inv_helmet_140",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41155] = {
	name = L["Hateful Gladiator's Chain Helm"],
	quality = 4,
	icon = "inv_helmet128",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41162] = {
	name = L["Hateful Gladiator's Linked Leggings"],
	quality = 4,
	icon = "inv_pants_mail_25",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41203] = {
	name = L["Hateful Gladiator's Chain Leggings"],
	quality = 4,
	icon = "inv_pants_mail_26",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41209] = {
	name = L["Hateful Gladiator's Linked Spaulders"],
	quality = 4,
	icon = "inv_shoulder_104",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41215] = {
	name = L["Hateful Gladiator's Chain Spaulders"],
	quality = 4,
	icon = "inv_shoulder_101",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41273] = {
	name = L["Hateful Gladiator's Kodohide Spaulders"],
	quality = 4,
	icon = "inv_shoulder_98",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41279] = {
	name = L["Hateful Gladiator's Wyrmhide Spaulders"],
	quality = 4,
	icon = "inv_shoulder_98",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41284] = {
	name = L["Hateful Gladiator's Kodohide Gloves"],
	quality = 4,
	icon = "inv_gauntlets_58",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41291] = {
	name = L["Hateful Gladiator's Wyrmhide Gloves"],
	quality = 4,
	icon = "inv_gauntlets_58",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41296] = {
	name = L["Hateful Gladiator's Kodohide Legguards"],
	quality = 4,
	icon = "inv_pants_leather_23",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41302] = {
	name = L["Hateful Gladiator's Wyrmhide Legguards"],
	quality = 4,
	icon = "inv_pants_leather_23",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41308] = {
	name = L["Hateful Gladiator's Kodohide Robes"],
	quality = 4,
	icon = "inv_chest_leather_12",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41314] = {
	name = L["Hateful Gladiator's Wyrmhide Robes"],
	quality = 4,
	icon = "inv_chest_leather_12",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41319] = {
	name = L["Hateful Gladiator's Kodohide Helm"],
	quality = 4,
	icon = "inv_helmet_141",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41325] = {
	name = L["Hateful Gladiator's Wyrmhide Helm"],
	quality = 4,
	icon = "inv_helmet_141",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41648] = {
	name = L["Hateful Gladiator's Leather Tunic"],
	quality = 4,
	icon = "inv_chest_leather_13",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41653] = {
	name = L["Hateful Gladiator's Leather Legguards"],
	quality = 4,
	icon = "inv_pants_leather_25",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41659] = {
	name = L["Hateful Gladiator's Dragonhide Robes"],
	quality = 4,
	icon = "inv_chest_leather_12",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41665] = {
	name = L["Hateful Gladiator's Dragonhide Legguards"],
	quality = 4,
	icon = "inv_pants_leather_23",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41670] = {
	name = L["Hateful Gladiator's Leather Helm"],
	quality = 4,
	icon = "inv_misc_bandana_03",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41676] = {
	name = L["Hateful Gladiator's Dragonhide Helm"],
	quality = 4,
	icon = "inv_helmet_141",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41681] = {
	name = L["Hateful Gladiator's Leather Spaulders"],
	quality = 4,
	icon = "inv_shoulder_95",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41713] = {
	name = L["Hateful Gladiator's Dragonhide Spaulders"],
	quality = 4,
	icon = "inv_shoulder_98",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41765] = {
	name = L["Hateful Gladiator's Leather Gloves"],
	quality = 4,
	icon = "inv_gauntlets_49",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41771] = {
	name = L["Hateful Gladiator's Dragonhide Gloves"],
	quality = 4,
	icon = "inv_gauntlets_58",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41991] = {
	name = L["Hateful Gladiator's Felweave Cowl"],
	quality = 4,
	icon = "inv_helmet_139",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[42001] = {
	name = L["Hateful Gladiator's Felweave Raiment"],
	quality = 4,
	icon = "inv_chest_cloth_63",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[42003] = {
	name = L["Hateful Gladiator's Felweave Trousers"],
	quality = 4,
	icon = "inv_pants_cloth_28",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[42009] = {
	name = L["Hateful Gladiator's Felweave Amice"],
	quality = 4,
	icon = "inv_shoulder_99",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[42015] = {
	name = L["Hateful Gladiator's Felweave Handguards"],
	quality = 4,
	icon = "inv_gauntlets_64",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40784] = {
	name = L["Deadly Gladiator's Dreadplate Chestpiece"],
	quality = 4,
	icon = "inv_chest_plate_23",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40785] = {
	name = L["Deadly Gladiator's Scaled Chestpiece"],
	quality = 4,
	icon = "inv_chest_plate_23",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40786] = {
	name = L["Deadly Gladiator's Plate Chestpiece"],
	quality = 4,
	icon = "inv_chest_plate_23",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40804] = {
	name = L["Deadly Gladiator's Plate Gauntlets"],
	quality = 4,
	icon = "inv_gauntlets_62",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40805] = {
	name = L["Deadly Gladiator's Scaled Gauntlets"],
	quality = 4,
	icon = "inv_gauntlets_62",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40806] = {
	name = L["Deadly Gladiator's Dreadplate Gauntlets"],
	quality = 4,
	icon = "inv_gauntlets_62",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40823] = {
	name = L["Deadly Gladiator's Plate Helm"],
	quality = 4,
	icon = "inv_helmet_98",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40824] = {
	name = L["Deadly Gladiator's Dreadplate Helm"],
	quality = 4,
	icon = "inv_helmet_135",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40825] = {
	name = L["Deadly Gladiator's Scaled Helm"],
	quality = 4,
	icon = "inv_helmet_124",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40844] = {
	name = L["Deadly Gladiator's Plate Legguards"],
	quality = 4,
	icon = "inv_pants_plate_27",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40845] = {
	name = L["Deadly Gladiator's Dreadplate Legguards"],
	quality = 4,
	icon = "inv_pants_plate_27",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40846] = {
	name = L["Deadly Gladiator's Scaled Legguards"],
	quality = 4,
	icon = "inv_pants_plate_27",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40862] = {
	name = L["Deadly Gladiator's Plate Shoulders"],
	quality = 4,
	icon = "inv_shoulder_62",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40863] = {
	name = L["Deadly Gladiator's Dreadplate Shoulders"],
	quality = 4,
	icon = "inv_shoulder_99",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40864] = {
	name = L["Deadly Gladiator's Scaled Shoulders"],
	quality = 4,
	icon = "inv_shoulder_62",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40905] = {
	name = L["Deadly Gladiator's Ornamented Chestguard"],
	quality = 4,
	icon = "inv_chest_plate_23",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40926] = {
	name = L["Deadly Gladiator's Ornamented Gloves"],
	quality = 4,
	icon = "inv_gauntlets_62",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40932] = {
	name = L["Deadly Gladiator's Ornamented Headcover"],
	quality = 4,
	icon = "inv_helmet_124",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40938] = {
	name = L["Deadly Gladiator's Ornamented Legplates"],
	quality = 4,
	icon = "inv_pants_plate_27",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40962] = {
	name = L["Deadly Gladiator's Ornamented Spaulders"],
	quality = 4,
	icon = "inv_shoulder_62",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40990] = {
	name = L["Deadly Gladiator's Ringmail Armor"],
	quality = 4,
	icon = "inv_chest_mail_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40991] = {
	name = L["Deadly Gladiator's Mail Armor"],
	quality = 4,
	icon = "inv_chest_mail_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41000] = {
	name = L["Deadly Gladiator's Ringmail Gauntlets"],
	quality = 4,
	icon = "inv_gauntlets_65",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41006] = {
	name = L["Deadly Gladiator's Mail Gauntlets"],
	quality = 4,
	icon = "inv_gauntlets_65",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41012] = {
	name = L["Deadly Gladiator's Ringmail Helm"],
	quality = 4,
	icon = "inv_helmet_140",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41018] = {
	name = L["Deadly Gladiator's Mail Helm"],
	quality = 4,
	icon = "inv_helmet_140",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41026] = {
	name = L["Deadly Gladiator's Ringmail Leggings"],
	quality = 4,
	icon = "inv_pants_mail_25",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41032] = {
	name = L["Deadly Gladiator's Mail Leggings"],
	quality = 4,
	icon = "inv_pants_mail_25",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41037] = {
	name = L["Deadly Gladiator's Ringmail Spaulders"],
	quality = 4,
	icon = "inv_shoulder_104",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41043] = {
	name = L["Deadly Gladiator's Mail Spaulders"],
	quality = 4,
	icon = "inv_shoulder_104",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41080] = {
	name = L["Deadly Gladiator's Linked Armor"],
	quality = 4,
	icon = "inv_chest_mail_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41086] = {
	name = L["Deadly Gladiator's Chain Armor"],
	quality = 4,
	icon = "inv_chest_mail_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41136] = {
	name = L["Deadly Gladiator's Linked Gauntlets"],
	quality = 4,
	icon = "inv_gauntlets_65",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41142] = {
	name = L["Deadly Gladiator's Chain Gauntlets"],
	quality = 4,
	icon = "inv_gauntlets_65",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41150] = {
	name = L["Deadly Gladiator's Linked Helm"],
	quality = 4,
	icon = "inv_helmet_140",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41156] = {
	name = L["Deadly Gladiator's Chain Helm"],
	quality = 4,
	icon = "inv_helmet128",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41198] = {
	name = L["Deadly Gladiator's Linked Leggings"],
	quality = 4,
	icon = "inv_pants_mail_25",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41204] = {
	name = L["Deadly Gladiator's Chain Leggings"],
	quality = 4,
	icon = "inv_pants_mail_26",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41210] = {
	name = L["Deadly Gladiator's Linked Spaulders"],
	quality = 4,
	icon = "inv_shoulder_104",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41216] = {
	name = L["Deadly Gladiator's Chain Spaulders"],
	quality = 4,
	icon = "inv_shoulder_101",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41274] = {
	name = L["Deadly Gladiator's Kodohide Spaulders"],
	quality = 4,
	icon = "inv_shoulder_98",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41280] = {
	name = L["Deadly Gladiator's Wyrmhide Spaulders"],
	quality = 4,
	icon = "inv_shoulder_98",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41286] = {
	name = L["Deadly Gladiator's Kodohide Gloves"],
	quality = 4,
	icon = "inv_gauntlets_58",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41292] = {
	name = L["Deadly Gladiator's Wyrmhide Gloves"],
	quality = 4,
	icon = "inv_gauntlets_58",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41297] = {
	name = L["Deadly Gladiator's Kodohide Legguards"],
	quality = 4,
	icon = "inv_pants_leather_23",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41303] = {
	name = L["Deadly Gladiator's Wyrmhide Legguards"],
	quality = 4,
	icon = "inv_pants_leather_23",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41309] = {
	name = L["Deadly Gladiator's Kodohide Robes"],
	quality = 4,
	icon = "inv_chest_leather_12",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41315] = {
	name = L["Deadly Gladiator's Wyrmhide Robes"],
	quality = 4,
	icon = "inv_chest_leather_12",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41320] = {
	name = L["Deadly Gladiator's Kodohide Helm"],
	quality = 4,
	icon = "inv_helmet_141",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41326] = {
	name = L["Deadly Gladiator's Wyrmhide Helm"],
	quality = 4,
	icon = "inv_helmet_141",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41649] = {
	name = L["Deadly Gladiator's Leather Tunic"],
	quality = 4,
	icon = "inv_chest_leather_13",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41654] = {
	name = L["Deadly Gladiator's Leather Legguards"],
	quality = 4,
	icon = "inv_pants_leather_25",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41660] = {
	name = L["Deadly Gladiator's Dragonhide Robes"],
	quality = 4,
	icon = "inv_chest_leather_12",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41666] = {
	name = L["Deadly Gladiator's Dragonhide Legguards"],
	quality = 4,
	icon = "inv_pants_leather_23",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41671] = {
	name = L["Deadly Gladiator's Leather Helm"],
	quality = 4,
	icon = "inv_misc_bandana_03",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41677] = {
	name = L["Deadly Gladiator's Dragonhide Helm"],
	quality = 4,
	icon = "inv_helmet_141",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41682] = {
	name = L["Deadly Gladiator's Leather Spaulders"],
	quality = 4,
	icon = "inv_shoulder_95",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41714] = {
	name = L["Deadly Gladiator's Dragonhide Spaulders"],
	quality = 4,
	icon = "inv_shoulder_98",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41766] = {
	name = L["Deadly Gladiator's Leather Gloves"],
	quality = 4,
	icon = "inv_gauntlets_49",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41772] = {
	name = L["Deadly Gladiator's Dragonhide Gloves"],
	quality = 4,
	icon = "inv_gauntlets_58",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41945] = {
	name = L["Deadly Gladiator's Silk Cowl"],
	quality = 4,
	icon = "inv_helmet_139",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41951] = {
	name = L["Deadly Gladiator's Silk Raiment"],
	quality = 4,
	icon = "inv_chest_cloth_63",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41958] = {
	name = L["Deadly Gladiator's Silk Trousers"],
	quality = 4,
	icon = "inv_pants_cloth_28",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41964] = {
	name = L["Deadly Gladiator's Silk Amice"],
	quality = 4,
	icon = "inv_shoulder_103",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41970] = {
	name = L["Deadly Gladiator's Silk Handguards"],
	quality = 4,
	icon = "inv_gauntlets_64",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41992] = {
	name = L["Deadly Gladiator's Felweave Cowl"],
	quality = 4,
	icon = "inv_helmet_139",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41997] = {
	name = L["Deadly Gladiator's Felweave Raiment"],
	quality = 4,
	icon = "inv_chest_cloth_63",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[42004] = {
	name = L["Deadly Gladiator's Felweave Trousers"],
	quality = 4,
	icon = "inv_pants_cloth_28",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[42010] = {
	name = L["Deadly Gladiator's Felweave Amice"],
	quality = 4,
	icon = "inv_shoulder_99",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[42016] = {
	name = L["Deadly Gladiator's Felweave Handguards"],
	quality = 4,
	icon = "inv_gauntlets_64",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[42208] = {
	name = L["Deadly Gladiator's Cleaver"],
	quality = 4,
	icon = "inv_axe_97",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[42227] = {
	name = L["Deadly Gladiator's Hacker"],
	quality = 4,
	icon = "inv_axe_97",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[42232] = {
	name = L["Deadly Gladiator's Chopper"],
	quality = 4,
	icon = "inv_axe_97",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[42237] = {
	name = L["Deadly Gladiator's Waraxe"],
	quality = 4,
	icon = "inv_axe_97",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[42242] = {
	name = L["Deadly Gladiator's Shanker"],
	quality = 4,
	icon = "inv_weapon_shortblade_90",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[42248] = {
	name = L["Deadly Gladiator's Shiv"],
	quality = 4,
	icon = "inv_weapon_shortblade_90",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[42255] = {
	name = L["Deadly Gladiator's Mutilator"],
	quality = 4,
	icon = "inv_weapon_shortblade_90",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[42260] = {
	name = L["Deadly Gladiator's Right Ripper"],
	quality = 4,
	icon = "inv_weapon_hand_19",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[42265] = {
	name = L["Deadly Gladiator's Left Render"],
	quality = 4,
	icon = "inv_weapon_hand_19",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[42270] = {
	name = L["Deadly Gladiator's Left Ripper"],
	quality = 4,
	icon = "inv_weapon_hand_19",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[42275] = {
	name = L["Deadly Gladiator's Pummeler"],
	quality = 4,
	icon = "inv_mace_72",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[42280] = {
	name = L["Deadly Gladiator's Bonecracker"],
	quality = 4,
	icon = "inv_mace_72",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[42285] = {
	name = L["Deadly Gladiator's Slicer"],
	quality = 4,
	icon = "inv_sword_86",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[42290] = {
	name = L["Deadly Gladiator's Quickblade"],
	quality = 4,
	icon = "inv_sword_86",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[42317] = {
	name = L["Deadly Gladiator's Decapitator"],
	quality = 4,
	icon = "inv_axe_98",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[42322] = {
	name = L["Deadly Gladiator's Bonegrinder"],
	quality = 4,
	icon = "inv_hammer_31",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[42327] = {
	name = L["Deadly Gladiator's Pike"],
	quality = 4,
	icon = "inv_weapon_halberd_29",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[42332] = {
	name = L["Deadly Gladiator's Greatsword"],
	quality = 4,
	icon = "inv_sword_131",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[42346] = {
	name = L["Deadly Gladiator's Spellblade"],
	quality = 4,
	icon = "inv_weapon_shortblade_91",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[42352] = {
	name = L["Deadly Gladiator's Gavel"],
	quality = 4,
	icon = "inv_hammer_29",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[42362] = {
	name = L["Deadly Gladiator's Battle Staff"],
	quality = 4,
	icon = "inv_staff_87",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[42384] = {
	name = L["Deadly Gladiator's Energy Staff"],
	quality = 4,
	icon = "inv_staff_87",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[42390] = {
	name = L["Deadly Gladiator's Staff"],
	quality = 4,
	icon = "inv_staff_88",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[42450] = {
	name = L["Deadly Gladiator's War Edge"],
	quality = 4,
	icon = "inv_axe_03",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[42485] = {
	name = L["Deadly Gladiator's Rifle"],
	quality = 4,
	icon = "inv_weapon_rifle_31",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[42490] = {
	name = L["Deadly Gladiator's Longbow"],
	quality = 4,
	icon = "inv_weapon_bow_50",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[42495] = {
	name = L["Deadly Gladiator's Heavy Crossbow"],
	quality = 4,
	icon = "inv_weapon_crossbow_32",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[42502] = {
	name = L["Deadly Gladiator's Touch of Defeat"],
	quality = 4,
	icon = "inv_wand_27",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[42513] = {
	name = L["Deadly Gladiator's Baton of Light"],
	quality = 4,
	icon = "inv_wand_27",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[42519] = {
	name = L["Deadly Gladiator's Piercing Touch"],
	quality = 4,
	icon = "inv_wand_27",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[42525] = {
	name = L["Deadly Gladiator's Endgame"],
	quality = 4,
	icon = "inv_misc_book_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[42531] = {
	name = L["Deadly Gladiator's Reprieve"],
	quality = 4,
	icon = "inv_misc_book_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[42537] = {
	name = L["Deadly Gladiator's Grimoire"],
	quality = 4,
	icon = "inv_misc_book_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[42559] = {
	name = L["Deadly Gladiator's Shield Wall"],
	quality = 4,
	icon = "inv_shield_61",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[42564] = {
	name = L["Deadly Gladiator's Barrier"],
	quality = 4,
	icon = "inv_shield_61",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[42570] = {
	name = L["Deadly Gladiator's Redoubt"],
	quality = 4,
	icon = "inv_shield_61",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[42578] = {
	name = L["Deadly Gladiator's Idol of Tenacity"],
	quality = 4,
	icon = "spell_nature_naturetouchgrow",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[42583] = {
	name = L["Deadly Gladiator's Idol of Steadfastness"],
	quality = 4,
	icon = "inv_relics_idolofhealth",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[42588] = {
	name = L["Deadly Gladiator's Idol of Resolve"],
	quality = 4,
	icon = "inv_relics_idolofhealth",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[42597] = {
	name = L["Deadly Gladiator's Totem of the Third Wind"],
	quality = 4,
	icon = "spell_frost_summonwaterelemental",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[42602] = {
	name = L["Deadly Gladiator's Totem of Survival"],
	quality = 4,
	icon = "spell_nature_slowingtotem",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[42607] = {
	name = L["Deadly Gladiator's Totem of Indomitability"],
	quality = 4,
	icon = "spell_nature_slowingtotem",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[42614] = {
	name = L["Deadly Gladiator's Libram of Justice"],
	quality = 4,
	icon = "inv_misc_book_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[42620] = {
	name = L["Deadly Gladiator's Sigil of Strife"],
	quality = 4,
	icon = "inv_shield_56",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[42852] = {
	name = L["Deadly Gladiator's Libram of Fortitude"],
	quality = 4,
	icon = "inv_relics_libramofhope",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[44419] = {
	name = L["Deadly Gladiator's War Staff"],
	quality = 4,
	icon = "inv_staff_87",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[44420] = {
	name = L["Deadly Gladiator's Focus Staff"],
	quality = 4,
	icon = "inv_staff_87",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[30757] = {
	name = L["Draenic Light Crossbow"],
	quality = 1,
	icon = "inv_weapon_crossbow_13",
	buyPrice = 104257,
	sellPrice = 20851,
	reqLevel = 60,
}
t[30758] = {
	name = L["Aldor Guardian Rifle"],
	quality = 1,
	icon = "inv_weapon_rifle_14",
	buyPrice = 103377,
	sellPrice = 20675,
	reqLevel = 60,
}
t[30759] = {
	name = L["Mag'hari Light Recurve"],
	quality = 1,
	icon = "inv_weapon_bow_15",
	buyPrice = 102498,
	sellPrice = 20499,
	reqLevel = 60,
}
t[23594] = {
	name = L["Plans: Adamantite Plate Bracers"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 60000,
	sellPrice = 15000,
	reqLevel = 0,
	profession = L["Blacksmithing"],
	teaches = L["Adamantite Plate Bracers"],
	learnedAt = 335,
}
t[23595] = {
	name = L["Plans: Adamantite Plate Gloves"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 60000,
	sellPrice = 15000,
	reqLevel = 0,
	profession = L["Blacksmithing"],
	teaches = L["Adamantite Plate Gloves"],
	learnedAt = 335,
}
t[23596] = {
	name = L["Plans: Adamantite Breastplate"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 60000,
	sellPrice = 15000,
	reqLevel = 0,
	profession = L["Blacksmithing"],
	teaches = L["Adamantite Breastplate"],
	learnedAt = 340,
}
t[2524] = {
	name = L["Truncheon"],
	quality = 1,
	icon = "inv_mace_11",
	buyPrice = 19192,
	sellPrice = 3838,
	reqLevel = 29,
}
t[2525] = {
	name = L["War Hammer"],
	quality = 1,
	icon = "inv_hammer_03",
	buyPrice = 26490,
	sellPrice = 5298,
	reqLevel = 30,
}
t[2527] = {
	name = L["Battle Staff"],
	quality = 1,
	icon = "inv_wand_07",
	buyPrice = 29356,
	sellPrice = 5871,
	reqLevel = 31,
}
t[2532] = {
	name = L["Morning Star"],
	quality = 1,
	icon = "inv_mace_12",
	buyPrice = 52608,
	sellPrice = 10521,
	reqLevel = 41,
}
t[2533] = {
	name = L["War Maul"],
	quality = 1,
	icon = "inv_hammer_17",
	buyPrice = 61108,
	sellPrice = 12221,
	reqLevel = 40,
}
t[2535] = {
	name = L["War Staff"],
	quality = 1,
	icon = "inv_staff_14",
	buyPrice = 61557,
	sellPrice = 12311,
	reqLevel = 40,
}
t[6256] = {
	name = L["Fishing Pole"],
	quality = 1,
	icon = "inv_fishingpole_02",
	buyPrice = 23,
	sellPrice = 4,
	reqLevel = 0,
}
t[6530] = {
	name = L["Nightcrawlers"],
	quality = 1,
	icon = "inv_misc_monstertail_03",
	buyPrice = 100,
	sellPrice = 25,
	reqLevel = 0,
}
t[30765] = {
	name = L["Heavy Draenic Breastplate"],
	quality = 1,
	icon = "inv_chest_plate12",
	buyPrice = 126608,
	sellPrice = 25321,
	reqLevel = 70,
}
t[30771] = {
	name = L["Heavy Draenic Bracers"],
	quality = 1,
	icon = "inv_bracer_16",
	buyPrice = 65032,
	sellPrice = 13006,
	reqLevel = 70,
}
t[30775] = {
	name = L["Layered Bone Shield"],
	quality = 1,
	icon = "inv_shield_21",
	buyPrice = 108595,
	sellPrice = 21719,
	reqLevel = 70,
}
t[30777] = {
	name = L["Aldor Heavy Belt"],
	quality = 1,
	icon = "inv_belt_27",
	buyPrice = 59255,
	sellPrice = 11851,
	reqLevel = 70,
}
t[30781] = {
	name = L["Mag'hari Chain Vest"],
	quality = 1,
	icon = "inv_chest_chain_12",
	buyPrice = 101003,
	sellPrice = 20200,
	reqLevel = 70,
}
t[30784] = {
	name = L["Worn Mag'hari Gauntlets"],
	quality = 1,
	icon = "inv_gauntlets_12",
	buyPrice = 50501,
	sellPrice = 10100,
	reqLevel = 70,
}
t[21900] = {
	name = L["Pattern: Imbued Netherweave Robe"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 60000,
	sellPrice = 15000,
	reqLevel = 0,
	profession = L["Tailoring"],
	teaches = L["Imbued Netherweave Robe"],
	learnedAt = 360,
}
t[21901] = {
	name = L["Pattern: Imbued Netherweave Tunic"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 60000,
	sellPrice = 15000,
	reqLevel = 0,
	profession = L["Tailoring"],
	teaches = L["Imbued Netherweave Tunic"],
	learnedAt = 360,
}
t[30355] = {
	name = L["Grilled Shadowmoon Tuber"],
	quality = 1,
	icon = "inv_misc_food_79",
	buyPrice = 8000,
	sellPrice = 400,
	reqLevel = 65,
}
t[8932] = {
	name = L["Alterac Swiss"],
	quality = 1,
	icon = "inv_misc_food_37",
	buyPrice = 4000,
	sellPrice = 200,
	reqLevel = 45,
}
t[27857] = {
	name = L["Garadar Sharp"],
	quality = 1,
	icon = "inv_misc_food_94_garadarsharp-",
	buyPrice = 5600,
	sellPrice = 280,
	reqLevel = 55,
}
t[29448] = {
	name = L["Mag'har Mild Cheese"],
	quality = 1,
	icon = "inv_misc_food_04",
	buyPrice = 8000,
	sellPrice = 400,
	reqLevel = 65,
}
t[32857] = {
	name = L["Reins of the Onyx Netherwing Drake"],
	quality = 4,
	icon = "ability_mount_netherdrakepurple",
	buyPrice = 2000000,
	sellPrice = 0,
	reqLevel = 70,
}
t[32858] = {
	name = L["Reins of the Azure Netherwing Drake"],
	quality = 4,
	icon = "ability_mount_netherdrakepurple",
	buyPrice = 2000000,
	sellPrice = 0,
	reqLevel = 70,
}
t[32859] = {
	name = L["Reins of the Cobalt Netherwing Drake"],
	quality = 4,
	icon = "ability_mount_netherdrakepurple",
	buyPrice = 2000000,
	sellPrice = 0,
	reqLevel = 70,
}
t[32860] = {
	name = L["Reins of the Purple Netherwing Drake"],
	quality = 4,
	icon = "ability_mount_netherdrakepurple",
	buyPrice = 2000000,
	sellPrice = 0,
	reqLevel = 70,
}
t[32861] = {
	name = L["Reins of the Veridian Netherwing Drake"],
	quality = 4,
	icon = "ability_mount_netherdrakepurple",
	buyPrice = 2000000,
	sellPrice = 0,
	reqLevel = 70,
}
t[32862] = {
	name = L["Reins of the Violet Netherwing Drake"],
	quality = 4,
	icon = "ability_mount_netherdrakepurple",
	buyPrice = 2000000,
	sellPrice = 0,
	reqLevel = 70,
}
t[27637] = {
	name = L["Shadowstalker's Sash"],
	quality = 3,
	icon = "inv_belt_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 66,
}
t[27638] = {
	name = L["Hierophant's Sash"],
	quality = 3,
	icon = "inv_belt_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 66,
}
t[27639] = {
	name = L["Slayer's Waistguard"],
	quality = 3,
	icon = "inv_belt_14",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 66,
}
t[27643] = {
	name = L["Stormbreaker's Girdle"],
	quality = 3,
	icon = "inv_belt_20",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 66,
}
t[27644] = {
	name = L["Avenger's Waistguard"],
	quality = 3,
	icon = "inv_belt_14",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 66,
}
t[27645] = {
	name = L["Dreamstalker Sash"],
	quality = 3,
	icon = "inv_belt_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 66,
}
t[27646] = {
	name = L["Marksman's Belt"],
	quality = 3,
	icon = "inv_belt_20",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 66,
}
t[27647] = {
	name = L["Marksman's Legguards"],
	quality = 3,
	icon = "inv_pants_mail_04",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 66,
}
t[27648] = {
	name = L["Dreamstalker Leggings"],
	quality = 3,
	icon = "inv_pants_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 66,
}
t[27649] = {
	name = L["Hierophant's Leggings"],
	quality = 3,
	icon = "inv_pants_cloth_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 66,
}
t[27650] = {
	name = L["Shadowstalker's Leggings"],
	quality = 3,
	icon = "inv_pants_leather_03",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 66,
}
t[27652] = {
	name = L["Stormbreaker's Leggings"],
	quality = 3,
	icon = "inv_pants_mail_12",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 66,
}
t[27653] = {
	name = L["Slayer's Leggings"],
	quality = 3,
	icon = "inv_pants_plate_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 66,
}
t[27654] = {
	name = L["Avenger's Legplates"],
	quality = 3,
	icon = "inv_pants_plate_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 66,
}
t[27679] = {
	name = L["Sublime Mystic Dawnstone"],
	quality = 4,
	icon = "inv_misc_gem_topaz_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[27680] = {
	name = L["Halaani Bag"],
	quality = 3,
	icon = "inv_misc_bag_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[32071] = {
	name = L["Recipe: Elixir of Ironskin"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Alchemy"],
	teaches = L["Elixir of Ironskin"],
	learnedAt = 330,
}
t[33783] = {
	name = L["Design: Steady Talasite"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[32453] = {
	name = L["Star's Tears"],
	quality = 1,
	icon = "inv_drink_waterskin_01",
	buyPrice = 10000,
	sellPrice = 125,
	reqLevel = 65,
}
t[35356] = {
	name = L["Dragonhide Gloves"],
	quality = 3,
	icon = "inv_gauntlets_28",
	buyPrice = 111905,
	sellPrice = 22381,
	reqLevel = 70,
}
t[35357] = {
	name = L["Dragonhide Helm"],
	quality = 3,
	icon = "inv_helmet_30",
	buyPrice = 168468,
	sellPrice = 33693,
	reqLevel = 70,
}
t[35358] = {
	name = L["Dragonhide Legguards"],
	quality = 3,
	icon = "inv_pants_cloth_05",
	buyPrice = 225438,
	sellPrice = 45087,
	reqLevel = 70,
}
t[35359] = {
	name = L["Dragonhide Spaulders"],
	quality = 3,
	icon = "inv_shoulder_12",
	buyPrice = 169689,
	sellPrice = 33937,
	reqLevel = 70,
}
t[35361] = {
	name = L["Kodohide Gloves"],
	quality = 3,
	icon = "inv_gauntlets_28",
	buyPrice = 105835,
	sellPrice = 21167,
	reqLevel = 70,
}
t[35362] = {
	name = L["Kodohide Helm"],
	quality = 3,
	icon = "inv_helmet_30",
	buyPrice = 159363,
	sellPrice = 31872,
	reqLevel = 70,
}
t[35363] = {
	name = L["Kodohide Legguards"],
	quality = 3,
	icon = "inv_pants_cloth_05",
	buyPrice = 213276,
	sellPrice = 42655,
	reqLevel = 70,
}
t[35365] = {
	name = L["Kodohide Robe"],
	quality = 3,
	icon = "inv_chest_leather_03",
	buyPrice = 214903,
	sellPrice = 42980,
	reqLevel = 70,
}
t[35372] = {
	name = L["Wyrmhide Helm"],
	quality = 3,
	icon = "inv_helmet_30",
	buyPrice = 165417,
	sellPrice = 33083,
	reqLevel = 70,
}
t[35373] = {
	name = L["Wyrmhide Legguards"],
	quality = 3,
	icon = "inv_pants_cloth_05",
	buyPrice = 221369,
	sellPrice = 44273,
	reqLevel = 70,
}
t[35374] = {
	name = L["Wyrmhide Spaulders"],
	quality = 3,
	icon = "inv_shoulder_12",
	buyPrice = 166637,
	sellPrice = 33327,
	reqLevel = 70,
}
t[35375] = {
	name = L["Wyrmhide Robe"],
	quality = 3,
	icon = "inv_chest_leather_03",
	buyPrice = 222975,
	sellPrice = 44595,
	reqLevel = 70,
}
t[35402] = {
	name = L["Crusader's Ornamented Chestplate"],
	quality = 3,
	icon = "inv_chest_plate05",
	buyPrice = 297385,
	sellPrice = 59477,
	reqLevel = 70,
}
t[35403] = {
	name = L["Crusader's Ornamented Gloves"],
	quality = 3,
	icon = "inv_gauntlets_29",
	buyPrice = 150115,
	sellPrice = 30023,
	reqLevel = 70,
}
t[35404] = {
	name = L["Crusader's Ornamented Headguard"],
	quality = 3,
	icon = "inv_helmet_22",
	buyPrice = 224320,
	sellPrice = 44864,
	reqLevel = 70,
}
t[35405] = {
	name = L["Crusader's Ornamented Leggings"],
	quality = 3,
	icon = "inv_pants_plate_17",
	buyPrice = 300772,
	sellPrice = 60154,
	reqLevel = 70,
}
t[35407] = {
	name = L["Savage Plate Chestpiece"],
	quality = 3,
	icon = "inv_chest_plate05",
	buyPrice = 303051,
	sellPrice = 60610,
	reqLevel = 70,
}
t[35408] = {
	name = L["Savage Plate Gauntlets"],
	quality = 3,
	icon = "inv_gauntlets_29",
	buyPrice = 152949,
	sellPrice = 30589,
	reqLevel = 70,
}
t[35410] = {
	name = L["Savage Plate Legguards"],
	quality = 3,
	icon = "inv_pants_plate_17",
	buyPrice = 314598,
	sellPrice = 62919,
	reqLevel = 70,
}
t[35411] = {
	name = L["Savage Plate Shoulders"],
	quality = 3,
	icon = "inv_shoulder_22",
	buyPrice = 236352,
	sellPrice = 47270,
	reqLevel = 70,
}
t[35412] = {
	name = L["Crusader's Scaled Chestpiece"],
	quality = 3,
	icon = "inv_chest_plate05",
	buyPrice = 316846,
	sellPrice = 63369,
	reqLevel = 70,
}
t[35414] = {
	name = L["Crusader's Scaled Helm"],
	quality = 3,
	icon = "inv_helmet_22",
	buyPrice = 238887,
	sellPrice = 47777,
	reqLevel = 70,
}
t[35415] = {
	name = L["Crusader's Scaled Legguards"],
	quality = 3,
	icon = "inv_pants_plate_17",
	buyPrice = 320263,
	sellPrice = 64052,
	reqLevel = 70,
}
t[35416] = {
	name = L["Crusader's Scaled Shoulders"],
	quality = 3,
	icon = "inv_shoulder_22",
	buyPrice = 240570,
	sellPrice = 48114,
	reqLevel = 70,
}
t[24551] = {
	name = L["Talisman of the Horde"],
	quality = 4,
	icon = "inv_jewelry_talisman_09",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[25829] = {
	name = L["Talisman of the Alliance"],
	quality = 4,
	icon = "inv_jewelry_talisman_10",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28234] = {
	name = L["Medallion of the Alliance"],
	quality = 3,
	icon = "inv_jewelry_trinketpvp_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28235] = {
	name = L["Medallion of the Alliance"],
	quality = 3,
	icon = "inv_jewelry_trinketpvp_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28236] = {
	name = L["Medallion of the Alliance"],
	quality = 3,
	icon = "inv_jewelry_trinketpvp_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28237] = {
	name = L["Medallion of the Alliance"],
	quality = 3,
	icon = "inv_jewelry_trinketpvp_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28238] = {
	name = L["Medallion of the Alliance"],
	quality = 3,
	icon = "inv_jewelry_trinketpvp_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28240] = {
	name = L["Medallion of the Horde"],
	quality = 3,
	icon = "inv_jewelry_trinketpvp_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28242] = {
	name = L["Medallion of the Horde"],
	quality = 3,
	icon = "inv_jewelry_trinketpvp_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28243] = {
	name = L["Medallion of the Horde"],
	quality = 3,
	icon = "inv_jewelry_trinketpvp_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28244] = {
	name = L["Pendant of Triumph"],
	quality = 4,
	icon = "inv_jewelry_necklace_36",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28245] = {
	name = L["Pendant of Dominance"],
	quality = 4,
	icon = "inv_jewelry_necklace_36",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28246] = {
	name = L["Band of Triumph"],
	quality = 3,
	icon = "inv_jewelry_ring_60",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28247] = {
	name = L["Band of Dominance"],
	quality = 3,
	icon = "inv_jewelry_ring_60",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28293] = {
	name = L["High Warlord's Claymore"],
	quality = 3,
	icon = "inv_sword_48",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28377] = {
	name = L["Sergeant's Heavy Cloak"],
	quality = 4,
	icon = "inv_misc_cape_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28378] = {
	name = L["Sergeant's Heavy Cape"],
	quality = 4,
	icon = "inv_misc_cape_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28379] = {
	name = L["Sergeant's Heavy Cape"],
	quality = 4,
	icon = "inv_misc_cape_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28380] = {
	name = L["Sergeant's Heavy Cloak"],
	quality = 4,
	icon = "inv_misc_cape_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28381] = {
	name = L["General's Plate Bracers"],
	quality = 4,
	icon = "inv_bracer_19",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28383] = {
	name = L["General's Plate Greaves"],
	quality = 4,
	icon = "inv_boots_plate_04",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28385] = {
	name = L["General's Plate Belt"],
	quality = 4,
	icon = "inv_belt_14",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28402] = {
	name = L["General's Dreadweave Stalkers"],
	quality = 4,
	icon = "inv_boots_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28404] = {
	name = L["General's Dreadweave Belt"],
	quality = 4,
	icon = "inv_belt_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28405] = {
	name = L["General's Dreadweave Cuffs"],
	quality = 4,
	icon = "inv_bracer_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28409] = {
	name = L["General's Silk Belt"],
	quality = 4,
	icon = "inv_belt_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28410] = {
	name = L["General's Silk Footguards"],
	quality = 4,
	icon = "inv_boots_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28411] = {
	name = L["General's Silk Cuffs"],
	quality = 4,
	icon = "inv_bracer_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28422] = {
	name = L["General's Leather Boots"],
	quality = 4,
	icon = "inv_boots_08",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28423] = {
	name = L["General's Leather Belt"],
	quality = 4,
	icon = "inv_belt_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28424] = {
	name = L["General's Leather Bracers"],
	quality = 4,
	icon = "inv_bracer_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28443] = {
	name = L["General's Dragonhide Belt"],
	quality = 4,
	icon = "inv_belt_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28444] = {
	name = L["General's Dragonhide Boots"],
	quality = 4,
	icon = "inv_boots_08",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28445] = {
	name = L["General's Dragonhide Bracers"],
	quality = 4,
	icon = "inv_bracer_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28446] = {
	name = L["General's Wyrmhide Belt"],
	quality = 4,
	icon = "inv_belt_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28447] = {
	name = L["General's Wyrmhide Boots"],
	quality = 4,
	icon = "inv_boots_08",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28448] = {
	name = L["General's Wyrmhide Bracers"],
	quality = 4,
	icon = "inv_bracer_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28449] = {
	name = L["General's Chain Sabatons"],
	quality = 4,
	icon = "inv_boots_plate_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28450] = {
	name = L["General's Chain Girdle"],
	quality = 4,
	icon = "inv_belt_20",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28451] = {
	name = L["General's Chain Bracers"],
	quality = 4,
	icon = "inv_bracer_16",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28605] = {
	name = L["General's Linked Bracers"],
	quality = 4,
	icon = "inv_bracer_16",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28613] = {
	name = L["Grand Marshal's Chain Armor"],
	quality = 3,
	icon = "inv_chest_chain_11",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28614] = {
	name = L["Grand Marshal's Chain Gauntlets"],
	quality = 3,
	icon = "inv_gauntlets_11",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28615] = {
	name = L["Grand Marshal's Chain Helm"],
	quality = 3,
	icon = "inv_helmet_09",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28616] = {
	name = L["Grand Marshal's Chain Leggings"],
	quality = 3,
	icon = "inv_pants_mail_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28617] = {
	name = L["Grand Marshal's Chain Spaulders"],
	quality = 3,
	icon = "inv_shoulder_29",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28618] = {
	name = L["Grand Marshal's Dragonhide Gloves"],
	quality = 3,
	icon = "inv_gauntlets_28",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28619] = {
	name = L["Grand Marshal's Dragonhide Helm"],
	quality = 3,
	icon = "inv_helmet_30",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28620] = {
	name = L["Grand Marshal's Dragonhide Legguards"],
	quality = 3,
	icon = "inv_pants_cloth_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28622] = {
	name = L["Grand Marshal's Dragonhide Spaulders"],
	quality = 3,
	icon = "inv_shoulder_12",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28623] = {
	name = L["Grand Marshal's Dragonhide Tunic"],
	quality = 3,
	icon = "inv_chest_leather_03",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28624] = {
	name = L["Grand Marshal's Dreadweave Gloves"],
	quality = 3,
	icon = "inv_gauntlets_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28625] = {
	name = L["Grand Marshal's Dreadweave Hood"],
	quality = 3,
	icon = "inv_helmet_30",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28626] = {
	name = L["Grand Marshal's Dreadweave Leggings"],
	quality = 3,
	icon = "inv_pants_cloth_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28627] = {
	name = L["Grand Marshal's Dreadweave Mantle"],
	quality = 3,
	icon = "inv_shoulder_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28628] = {
	name = L["Grand Marshal's Dreadweave Robe"],
	quality = 3,
	icon = "inv_chest_cloth_43",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28629] = {
	name = L["General's Linked Girdle"],
	quality = 4,
	icon = "inv_belt_20",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28630] = {
	name = L["General's Linked Sabatons"],
	quality = 4,
	icon = "inv_boots_plate_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28638] = {
	name = L["General's Mail Bracers"],
	quality = 4,
	icon = "inv_bracer_16",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28639] = {
	name = L["General's Mail Girdle"],
	quality = 4,
	icon = "inv_belt_20",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28640] = {
	name = L["General's Mail Sabatons"],
	quality = 4,
	icon = "inv_boots_plate_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28641] = {
	name = L["General's Lamellar Belt"],
	quality = 4,
	icon = "inv_belt_14",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28642] = {
	name = L["General's Lamellar Greaves"],
	quality = 4,
	icon = "inv_boots_plate_04",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28643] = {
	name = L["General's Lamellar Bracers"],
	quality = 4,
	icon = "inv_bracer_19",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28644] = {
	name = L["General's Scaled Belt"],
	quality = 4,
	icon = "inv_belt_14",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28645] = {
	name = L["General's Scaled Greaves"],
	quality = 4,
	icon = "inv_boots_plate_04",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28646] = {
	name = L["General's Scaled Bracers"],
	quality = 4,
	icon = "inv_bracer_19",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28679] = {
	name = L["Grand Marshal's Lamellar Chestpiece"],
	quality = 3,
	icon = "inv_chest_plate05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28680] = {
	name = L["Grand Marshal's Lamellar Gauntlets"],
	quality = 3,
	icon = "inv_gauntlets_29",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28681] = {
	name = L["Grand Marshal's Lamellar Helm"],
	quality = 3,
	icon = "inv_helmet_22",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28683] = {
	name = L["Grand Marshal's Lamellar Shoulders"],
	quality = 3,
	icon = "inv_shoulder_22",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28684] = {
	name = L["Grand Marshal's Leather Gloves"],
	quality = 3,
	icon = "inv_gauntlets_28",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28685] = {
	name = L["Grand Marshal's Leather Helm"],
	quality = 3,
	icon = "inv_helmet_30",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28686] = {
	name = L["Grand Marshal's Leather Legguards"],
	quality = 3,
	icon = "inv_pants_cloth_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28687] = {
	name = L["Grand Marshal's Leather Spaulders"],
	quality = 3,
	icon = "inv_shoulder_12",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28688] = {
	name = L["Grand Marshal's Leather Tunic"],
	quality = 3,
	icon = "inv_chest_leather_03",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28689] = {
	name = L["Grand Marshal's Linked Armor"],
	quality = 3,
	icon = "inv_chest_chain_11",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28690] = {
	name = L["Grand Marshal's Linked Gauntlets"],
	quality = 3,
	icon = "inv_gauntlets_11",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28691] = {
	name = L["Grand Marshal's Linked Helm"],
	quality = 3,
	icon = "inv_helmet_09",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28692] = {
	name = L["Grand Marshal's Linked Leggings"],
	quality = 3,
	icon = "inv_pants_mail_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28693] = {
	name = L["Grand Marshal's Linked Spaulders"],
	quality = 3,
	icon = "inv_shoulder_29",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28694] = {
	name = L["Grand Marshal's Mail Armor"],
	quality = 3,
	icon = "inv_chest_chain_11",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28695] = {
	name = L["Grand Marshal's Mail Gauntlets"],
	quality = 3,
	icon = "inv_gauntlets_11",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28696] = {
	name = L["Grand Marshal's Mail Helm"],
	quality = 3,
	icon = "inv_helmet_09",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28697] = {
	name = L["Grand Marshal's Mail Leggings"],
	quality = 3,
	icon = "inv_pants_mail_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28698] = {
	name = L["Grand Marshal's Mail Spaulders"],
	quality = 3,
	icon = "inv_shoulder_29",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28699] = {
	name = L["Grand Marshal's Plate Chestpiece"],
	quality = 3,
	icon = "inv_chest_plate05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28700] = {
	name = L["Grand Marshal's Plate Gauntlets"],
	quality = 3,
	icon = "inv_gauntlets_29",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28701] = {
	name = L["Grand Marshal's Plate Helm"],
	quality = 3,
	icon = "inv_helmet_22",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28702] = {
	name = L["Grand Marshal's Plate Legguards"],
	quality = 3,
	icon = "inv_pants_plate_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28703] = {
	name = L["Grand Marshal's Plate Shoulders"],
	quality = 3,
	icon = "inv_shoulder_22",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28709] = {
	name = L["Grand Marshal's Scaled Chestpiece"],
	quality = 3,
	icon = "inv_chest_plate05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28710] = {
	name = L["Grand Marshal's Scaled Gauntlets"],
	quality = 3,
	icon = "inv_gauntlets_29",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28711] = {
	name = L["Grand Marshal's Scaled Helm"],
	quality = 3,
	icon = "inv_helmet_22",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28712] = {
	name = L["Grand Marshal's Scaled Legguards"],
	quality = 3,
	icon = "inv_pants_plate_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28713] = {
	name = L["Grand Marshal's Scaled Shoulders"],
	quality = 3,
	icon = "inv_shoulder_22",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28714] = {
	name = L["Grand Marshal's Silk Amice"],
	quality = 3,
	icon = "inv_shoulder_19",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28715] = {
	name = L["Grand Marshal's Silk Cowl"],
	quality = 3,
	icon = "inv_helmet_08",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28716] = {
	name = L["Grand Marshal's Silk Handguards"],
	quality = 3,
	icon = "inv_gauntlets_19",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28717] = {
	name = L["Grand Marshal's Silk Raiment"],
	quality = 3,
	icon = "inv_chest_leather_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28718] = {
	name = L["Grand Marshal's Silk Trousers"],
	quality = 3,
	icon = "inv_pants_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28719] = {
	name = L["Grand Marshal's Wyrmhide Gloves"],
	quality = 3,
	icon = "inv_gauntlets_28",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28720] = {
	name = L["Grand Marshal's Wyrmhide Helm"],
	quality = 3,
	icon = "inv_helmet_30",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28721] = {
	name = L["Grand Marshal's Wyrmhide Legguards"],
	quality = 3,
	icon = "inv_pants_cloth_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28722] = {
	name = L["Grand Marshal's Wyrmhide Spaulders"],
	quality = 3,
	icon = "inv_shoulder_12",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28723] = {
	name = L["Grand Marshal's Wyrmhide Tunic"],
	quality = 3,
	icon = "inv_chest_leather_03",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28724] = {
	name = L["Grand Marshal's Lamellar Legguards"],
	quality = 3,
	icon = "inv_pants_plate_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28805] = {
	name = L["High Warlord's Chain Armor"],
	quality = 3,
	icon = "inv_chest_chain_11",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28806] = {
	name = L["High Warlord's Chain Gauntlets"],
	quality = 3,
	icon = "inv_gauntlets_11",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28807] = {
	name = L["High Warlord's Chain Helm"],
	quality = 3,
	icon = "inv_helmet_09",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28808] = {
	name = L["High Warlord's Chain Leggings"],
	quality = 3,
	icon = "inv_pants_mail_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28809] = {
	name = L["High Warlord's Chain Spaulders"],
	quality = 3,
	icon = "inv_shoulder_29",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28817] = {
	name = L["High Warlord's Dreadweave Gloves"],
	quality = 3,
	icon = "inv_gauntlets_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28818] = {
	name = L["High Warlord's Dreadweave Hood"],
	quality = 3,
	icon = "inv_helmet_30",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28819] = {
	name = L["High Warlord's Dreadweave Leggings"],
	quality = 3,
	icon = "inv_pants_cloth_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28820] = {
	name = L["High Warlord's Dreadweave Mantle"],
	quality = 3,
	icon = "inv_shoulder_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28821] = {
	name = L["High Warlord's Dreadweave Robe"],
	quality = 3,
	icon = "inv_chest_cloth_43",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28831] = {
	name = L["High Warlord's Lamellar Chestpiece"],
	quality = 3,
	icon = "inv_chest_plate05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28832] = {
	name = L["High Warlord's Lamellar Gauntlets"],
	quality = 3,
	icon = "inv_gauntlets_29",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28833] = {
	name = L["High Warlord's Lamellar Helm"],
	quality = 3,
	icon = "inv_helmet_22",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28834] = {
	name = L["High Warlord's Lamellar Legguards"],
	quality = 3,
	icon = "inv_pants_plate_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28835] = {
	name = L["High Warlord's Lamellar Shoulders"],
	quality = 3,
	icon = "inv_shoulder_22",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28836] = {
	name = L["High Warlord's Leather Gloves"],
	quality = 3,
	icon = "inv_gauntlets_28",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28837] = {
	name = L["High Warlord's Leather Helm"],
	quality = 3,
	icon = "inv_helmet_30",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28838] = {
	name = L["High Warlord's Leather Legguards"],
	quality = 3,
	icon = "inv_pants_cloth_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28839] = {
	name = L["High Warlord's Leather Spaulders"],
	quality = 3,
	icon = "inv_shoulder_12",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28840] = {
	name = L["High Warlord's Leather Tunic"],
	quality = 3,
	icon = "inv_chest_leather_03",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28856] = {
	name = L["High Warlord's Satin Gloves"],
	quality = 3,
	icon = "inv_gauntlets_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28857] = {
	name = L["High Warlord's Satin Hood"],
	quality = 3,
	icon = "inv_helmet_30",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28858] = {
	name = L["High Warlord's Satin Leggings"],
	quality = 3,
	icon = "inv_pants_cloth_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28859] = {
	name = L["High Warlord's Satin Mantle"],
	quality = 3,
	icon = "inv_shoulder_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28860] = {
	name = L["High Warlord's Satin Robe"],
	quality = 3,
	icon = "inv_chest_cloth_43",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28861] = {
	name = L["High Warlord's Scaled Chestpiece"],
	quality = 3,
	icon = "inv_chest_plate05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28862] = {
	name = L["High Warlord's Scaled Gauntlets"],
	quality = 3,
	icon = "inv_gauntlets_29",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28863] = {
	name = L["High Warlord's Scaled Helm"],
	quality = 3,
	icon = "inv_helmet_22",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28864] = {
	name = L["High Warlord's Scaled Legguards"],
	quality = 3,
	icon = "inv_pants_plate_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28865] = {
	name = L["High Warlord's Scaled Shoulders"],
	quality = 3,
	icon = "inv_shoulder_22",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28917] = {
	name = L["High Warlord's Bonegrinder"],
	quality = 3,
	icon = "inv_hammer_04",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28918] = {
	name = L["High Warlord's Decapitator"],
	quality = 3,
	icon = "inv_axe_10",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28919] = {
	name = L["High Warlord's Maul"],
	quality = 3,
	icon = "inv_hammer_04",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28920] = {
	name = L["High Warlord's Cleaver"],
	quality = 3,
	icon = "inv_axe_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28921] = {
	name = L["High Warlord's Hacker"],
	quality = 3,
	icon = "inv_axe_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28922] = {
	name = L["High Warlord's Left Ripper"],
	quality = 3,
	icon = "inv_weapon_hand_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28923] = {
	name = L["High Warlord's Painsaw"],
	quality = 3,
	icon = "inv_weapon_halberd_04",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28924] = {
	name = L["High Warlord's Bonecracker"],
	quality = 3,
	icon = "inv_mace_08",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28925] = {
	name = L["High Warlord's Pummeler"],
	quality = 3,
	icon = "inv_mace_08",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28926] = {
	name = L["High Warlord's Quickblade"],
	quality = 3,
	icon = "inv_sword_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28928] = {
	name = L["High Warlord's Right Ripper"],
	quality = 3,
	icon = "inv_weapon_hand_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28929] = {
	name = L["High Warlord's Shanker"],
	quality = 3,
	icon = "inv_weapon_shortblade_29",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28930] = {
	name = L["High Warlord's Shiv"],
	quality = 3,
	icon = "inv_weapon_shortblade_29",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28931] = {
	name = L["High Warlord's Spellblade"],
	quality = 3,
	icon = "inv_weapon_shortblade_26",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28933] = {
	name = L["High Warlord's Heavy Crossbow"],
	quality = 3,
	icon = "inv_weapon_crossbow_10",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28935] = {
	name = L["High Warlord's War Staff"],
	quality = 3,
	icon = "inv_misc_bone_elfskull_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28937] = {
	name = L["High Warlord's Slicer"],
	quality = 3,
	icon = "inv_sword_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28938] = {
	name = L["High Warlord's Battletome"],
	quality = 3,
	icon = "inv_misc_book_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28939] = {
	name = L["High Warlord's Barricade"],
	quality = 3,
	icon = "inv_shield_19",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28940] = {
	name = L["Grand Marshal's Barricade"],
	quality = 3,
	icon = "inv_shield_19",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28941] = {
	name = L["Grand Marshal's Battletome"],
	quality = 3,
	icon = "inv_misc_book_12",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28942] = {
	name = L["Grand Marshal's Bonegrinder"],
	quality = 3,
	icon = "inv_hammer_04",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28943] = {
	name = L["Grand Marshal's Warblade"],
	quality = 3,
	icon = "inv_sword_39",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28944] = {
	name = L["Grand Marshal's Cleaver"],
	quality = 3,
	icon = "inv_axe_03",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28945] = {
	name = L["Grand Marshal's Decapitator"],
	quality = 3,
	icon = "inv_axe_09",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28946] = {
	name = L["Grand Marshal's Hacker"],
	quality = 3,
	icon = "inv_axe_03",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28947] = {
	name = L["Grand Marshal's Left Ripper"],
	quality = 3,
	icon = "inv_weapon_hand_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28948] = {
	name = L["Grand Marshal's Maul"],
	quality = 3,
	icon = "inv_hammer_04",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28949] = {
	name = L["Grand Marshal's Painsaw"],
	quality = 3,
	icon = "inv_weapon_halberd_04",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28950] = {
	name = L["Grand Marshal's Bonecracker"],
	quality = 3,
	icon = "inv_mace_08",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28951] = {
	name = L["Grand Marshal's Pummeler"],
	quality = 3,
	icon = "inv_mace_08",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28952] = {
	name = L["Grand Marshal's Quickblade"],
	quality = 3,
	icon = "inv_sword_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28953] = {
	name = L["Grand Marshal's Right Ripper"],
	quality = 3,
	icon = "inv_weapon_hand_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28954] = {
	name = L["Grand Marshal's Shanker"],
	quality = 3,
	icon = "inv_weapon_shortblade_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28955] = {
	name = L["Grand Marshal's Shiv"],
	quality = 3,
	icon = "inv_weapon_shortblade_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28956] = {
	name = L["Grand Marshal's Slicer"],
	quality = 3,
	icon = "inv_sword_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28957] = {
	name = L["Grand Marshal's Spellblade"],
	quality = 3,
	icon = "inv_weapon_shortblade_26",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28959] = {
	name = L["Grand Marshal's War Staff"],
	quality = 3,
	icon = "inv_staff_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28960] = {
	name = L["Grand Marshal's Heavy Crossbow"],
	quality = 3,
	icon = "inv_weapon_crossbow_10",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28973] = {
	name = L["Marshal's Chain Bracers"],
	quality = 4,
	icon = "inv_bracer_16",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28974] = {
	name = L["Marshal's Chain Girdle"],
	quality = 4,
	icon = "inv_belt_20",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28975] = {
	name = L["Marshal's Chain Sabatons"],
	quality = 4,
	icon = "inv_boots_plate_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28976] = {
	name = L["Marshal's Dragonhide Belt"],
	quality = 4,
	icon = "inv_belt_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28977] = {
	name = L["Marshal's Dragonhide Boots"],
	quality = 4,
	icon = "inv_boots_08",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28978] = {
	name = L["Marshal's Dragonhide Bracers"],
	quality = 4,
	icon = "inv_bracer_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28980] = {
	name = L["Marshal's Dreadweave Belt"],
	quality = 4,
	icon = "inv_belt_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28981] = {
	name = L["Marshal's Dreadweave Cuffs"],
	quality = 4,
	icon = "inv_bracer_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28982] = {
	name = L["Marshal's Dreadweave Stalkers"],
	quality = 4,
	icon = "inv_boots_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28983] = {
	name = L["Marshal's Lamellar Belt"],
	quality = 4,
	icon = "inv_belt_14",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28984] = {
	name = L["Marshal's Lamellar Bracers"],
	quality = 4,
	icon = "inv_bracer_19",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28985] = {
	name = L["Marshal's Lamellar Greaves"],
	quality = 4,
	icon = "inv_boots_plate_04",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28986] = {
	name = L["Marshal's Leather Belt"],
	quality = 4,
	icon = "inv_belt_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28987] = {
	name = L["Marshal's Leather Boots"],
	quality = 4,
	icon = "inv_boots_08",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28988] = {
	name = L["Marshal's Leather Bracers"],
	quality = 4,
	icon = "inv_bracer_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28989] = {
	name = L["Marshal's Linked Bracers"],
	quality = 4,
	icon = "inv_bracer_16",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28990] = {
	name = L["Marshal's Linked Girdle"],
	quality = 4,
	icon = "inv_belt_20",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28991] = {
	name = L["Marshal's Linked Sabatons"],
	quality = 4,
	icon = "inv_boots_plate_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28992] = {
	name = L["Marshal's Mail Bracers"],
	quality = 4,
	icon = "inv_bracer_16",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28993] = {
	name = L["Marshal's Mail Girdle"],
	quality = 4,
	icon = "inv_belt_20",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28994] = {
	name = L["Marshal's Mail Sabatons"],
	quality = 4,
	icon = "inv_boots_plate_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28995] = {
	name = L["Marshal's Plate Belt"],
	quality = 4,
	icon = "inv_belt_14",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28996] = {
	name = L["Marshal's Plate Bracers"],
	quality = 4,
	icon = "inv_bracer_19",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28997] = {
	name = L["Marshal's Plate Greaves"],
	quality = 4,
	icon = "inv_boots_plate_04",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28998] = {
	name = L["Marshal's Scaled Belt"],
	quality = 4,
	icon = "inv_belt_14",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28999] = {
	name = L["Marshal's Scaled Bracers"],
	quality = 4,
	icon = "inv_bracer_19",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29000] = {
	name = L["Marshal's Scaled Greaves"],
	quality = 4,
	icon = "inv_boots_plate_04",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29001] = {
	name = L["Marshal's Silk Belt"],
	quality = 4,
	icon = "inv_belt_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29002] = {
	name = L["Marshal's Silk Cuffs"],
	quality = 4,
	icon = "inv_bracer_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29003] = {
	name = L["Marshal's Silk Footguards"],
	quality = 4,
	icon = "inv_boots_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29004] = {
	name = L["Marshal's Wyrmhide Belt"],
	quality = 4,
	icon = "inv_belt_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29005] = {
	name = L["Marshal's Wyrmhide Boots"],
	quality = 4,
	icon = "inv_boots_08",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29006] = {
	name = L["Marshal's Wyrmhide Bracers"],
	quality = 4,
	icon = "inv_bracer_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30343] = {
	name = L["Medallion of the Horde"],
	quality = 3,
	icon = "inv_jewelry_trinketpvp_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30346] = {
	name = L["Medallion of the Horde"],
	quality = 3,
	icon = "inv_jewelry_trinketpvp_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30348] = {
	name = L["Medallion of the Alliance"],
	quality = 3,
	icon = "inv_jewelry_trinketpvp_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30350] = {
	name = L["Medallion of the Alliance"],
	quality = 3,
	icon = "inv_jewelry_trinketpvp_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30351] = {
	name = L["Medallion of the Alliance"],
	quality = 3,
	icon = "inv_jewelry_trinketpvp_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31589] = {
	name = L["Grand Marshal's Kodohide Gloves"],
	quality = 3,
	icon = "inv_gauntlets_28",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31590] = {
	name = L["Grand Marshal's Kodohide Helm"],
	quality = 3,
	icon = "inv_helmet_30",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31591] = {
	name = L["Grand Marshal's Kodohide Legguards"],
	quality = 3,
	icon = "inv_pants_cloth_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31592] = {
	name = L["Grand Marshal's Kodohide Spaulders"],
	quality = 3,
	icon = "inv_shoulder_12",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31593] = {
	name = L["Grand Marshal's Kodohide Tunic"],
	quality = 3,
	icon = "inv_chest_leather_03",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31594] = {
	name = L["General's Kodohide Belt"],
	quality = 4,
	icon = "inv_belt_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31595] = {
	name = L["General's Kodohide Boots"],
	quality = 4,
	icon = "inv_boots_08",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31596] = {
	name = L["Marshal's Kodohide Belt"],
	quality = 4,
	icon = "inv_belt_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31597] = {
	name = L["Marshal's Kodohide Boots"],
	quality = 4,
	icon = "inv_boots_08",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31598] = {
	name = L["General's Kodohide Bracers"],
	quality = 4,
	icon = "inv_bracer_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31599] = {
	name = L["Marshal's Kodohide Bracers"],
	quality = 4,
	icon = "inv_bracer_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31621] = {
	name = L["High Warlord's Mooncloth Mitts"],
	quality = 3,
	icon = "inv_gauntlets_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31626] = {
	name = L["High Warlord's Mooncloth Cowl"],
	quality = 3,
	icon = "inv_helmet_30",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31627] = {
	name = L["High Warlord's Mooncloth Legguards"],
	quality = 3,
	icon = "inv_pants_cloth_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31628] = {
	name = L["High Warlord's Mooncloth Shoulderpads"],
	quality = 3,
	icon = "inv_shoulder_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31629] = {
	name = L["High Warlord's Mooncloth Vestments"],
	quality = 3,
	icon = "inv_chest_cloth_43",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31630] = {
	name = L["Grand Marshal's Ornamented Chestplate"],
	quality = 3,
	icon = "inv_chest_plate05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31631] = {
	name = L["Grand Marshal's Ornamented Gloves"],
	quality = 3,
	icon = "inv_gauntlets_29",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31632] = {
	name = L["Grand Marshal's Ornamented Headguard"],
	quality = 3,
	icon = "inv_helmet_22",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31633] = {
	name = L["Grand Marshal's Ornamented Leggings"],
	quality = 3,
	icon = "inv_pants_plate_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31634] = {
	name = L["Grand Marshal's Ornamented Spaulders"],
	quality = 3,
	icon = "inv_shoulder_22",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31635] = {
	name = L["High Warlord's Ornamented Chestplate"],
	quality = 3,
	icon = "inv_chest_plate05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31636] = {
	name = L["High Warlord's Ornamented Gloves"],
	quality = 3,
	icon = "inv_gauntlets_29",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31637] = {
	name = L["High Warlord's Ornamented Headguard"],
	quality = 3,
	icon = "inv_helmet_22",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31638] = {
	name = L["High Warlord's Ornamented Leggings"],
	quality = 3,
	icon = "inv_pants_plate_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31639] = {
	name = L["High Warlord's Ornamented Spaulders"],
	quality = 3,
	icon = "inv_shoulder_22",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31640] = {
	name = L["Grand Marshal's Ringmail Chestguard"],
	quality = 3,
	icon = "inv_chest_chain_11",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31641] = {
	name = L["Grand Marshal's Ringmail Gloves"],
	quality = 3,
	icon = "inv_gauntlets_11",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31642] = {
	name = L["Grand Marshal's Ringmail Headpiece"],
	quality = 3,
	icon = "inv_helmet_09",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31643] = {
	name = L["Grand Marshal's Ringmail Legguards"],
	quality = 3,
	icon = "inv_pants_mail_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31644] = {
	name = L["Grand Marshal's Ringmail Shoulders"],
	quality = 3,
	icon = "inv_shoulder_29",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32785] = {
	name = L["Veteran's Chain Sabatons"],
	quality = 4,
	icon = "inv_boots_plate_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32786] = {
	name = L["Veteran's Dragonhide Boots"],
	quality = 4,
	icon = "inv_boots_08",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32787] = {
	name = L["Veteran's Dreadweave Stalkers"],
	quality = 4,
	icon = "inv_boots_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32788] = {
	name = L["Veteran's Kodohide Boots"],
	quality = 4,
	icon = "inv_boots_08",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32789] = {
	name = L["Veteran's Lamellar Greaves"],
	quality = 4,
	icon = "inv_boots_plate_04",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32790] = {
	name = L["Veteran's Leather Boots"],
	quality = 4,
	icon = "inv_boots_08",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32791] = {
	name = L["Veteran's Linked Sabatons"],
	quality = 4,
	icon = "inv_boots_plate_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32792] = {
	name = L["Veteran's Mail Sabatons"],
	quality = 4,
	icon = "inv_boots_plate_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32793] = {
	name = L["Veteran's Plate Greaves"],
	quality = 4,
	icon = "inv_boots_plate_04",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32794] = {
	name = L["Veteran's Scaled Greaves"],
	quality = 4,
	icon = "inv_boots_plate_04",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32795] = {
	name = L["Veteran's Silk Footguards"],
	quality = 4,
	icon = "inv_boots_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32796] = {
	name = L["Veteran's Wyrmhide Boots"],
	quality = 4,
	icon = "inv_boots_08",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32797] = {
	name = L["Veteran's Chain Girdle"],
	quality = 4,
	icon = "inv_belt_20",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32798] = {
	name = L["Veteran's Dragonhide Belt"],
	quality = 4,
	icon = "inv_belt_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32799] = {
	name = L["Veteran's Dreadweave Belt"],
	quality = 4,
	icon = "inv_belt_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32800] = {
	name = L["Veteran's Kodohide Belt"],
	quality = 4,
	icon = "inv_belt_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32801] = {
	name = L["Veteran's Lamellar Belt"],
	quality = 4,
	icon = "inv_belt_14",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32802] = {
	name = L["Veteran's Leather Belt"],
	quality = 4,
	icon = "inv_belt_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32803] = {
	name = L["Veteran's Linked Girdle"],
	quality = 4,
	icon = "inv_belt_20",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32804] = {
	name = L["Veteran's Mail Girdle"],
	quality = 4,
	icon = "inv_belt_20",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32805] = {
	name = L["Veteran's Plate Belt"],
	quality = 4,
	icon = "inv_belt_14",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32806] = {
	name = L["Veteran's Scaled Belt"],
	quality = 4,
	icon = "inv_belt_14",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32807] = {
	name = L["Veteran's Silk Belt"],
	quality = 4,
	icon = "inv_belt_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32808] = {
	name = L["Veteran's Wyrmhide Belt"],
	quality = 4,
	icon = "inv_belt_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32809] = {
	name = L["Veteran's Chain Bracers"],
	quality = 4,
	icon = "inv_bracer_16",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32810] = {
	name = L["Veteran's Dragonhide Bracers"],
	quality = 4,
	icon = "inv_bracer_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32811] = {
	name = L["Veteran's Dreadweave Cuffs"],
	quality = 4,
	icon = "inv_bracer_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32812] = {
	name = L["Veteran's Kodohide Bracers"],
	quality = 4,
	icon = "inv_bracer_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32813] = {
	name = L["Veteran's Lamellar Bracers"],
	quality = 4,
	icon = "inv_bracer_19",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32814] = {
	name = L["Veteran's Leather Bracers"],
	quality = 4,
	icon = "inv_bracer_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32816] = {
	name = L["Veteran's Linked Bracers"],
	quality = 4,
	icon = "inv_bracer_16",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32817] = {
	name = L["Veteran's Mail Bracers"],
	quality = 4,
	icon = "inv_bracer_16",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32818] = {
	name = L["Veteran's Plate Bracers"],
	quality = 4,
	icon = "inv_bracer_19",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32819] = {
	name = L["Veteran's Scaled Bracers"],
	quality = 4,
	icon = "inv_bracer_19",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32820] = {
	name = L["Veteran's Silk Cuffs"],
	quality = 4,
	icon = "inv_bracer_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32821] = {
	name = L["Veteran's Wyrmhide Bracers"],
	quality = 4,
	icon = "inv_bracer_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32973] = {
	name = L["General's Mooncloth Cuffs"],
	quality = 4,
	icon = "inv_bracer_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32974] = {
	name = L["General's Mooncloth Belt"],
	quality = 4,
	icon = "inv_belt_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32975] = {
	name = L["General's Mooncloth Slippers"],
	quality = 4,
	icon = "inv_boots_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32976] = {
	name = L["Marshal's Mooncloth Belt"],
	quality = 4,
	icon = "inv_belt_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32977] = {
	name = L["Marshal's Mooncloth Cuffs"],
	quality = 4,
	icon = "inv_bracer_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32978] = {
	name = L["Marshal's Mooncloth Slippers"],
	quality = 4,
	icon = "inv_boots_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32979] = {
	name = L["Veteran's Mooncloth Belt"],
	quality = 4,
	icon = "inv_belt_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32980] = {
	name = L["Veteran's Mooncloth Cuffs"],
	quality = 4,
	icon = "inv_bracer_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32981] = {
	name = L["Veteran's Mooncloth Slippers"],
	quality = 4,
	icon = "inv_boots_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32982] = {
	name = L["General's Ornamented Belt"],
	quality = 4,
	icon = "inv_belt_14",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32983] = {
	name = L["General's Ornamented Bracers"],
	quality = 4,
	icon = "inv_bracer_19",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32984] = {
	name = L["General's Ornamented Greaves"],
	quality = 4,
	icon = "inv_boots_plate_04",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32985] = {
	name = L["Marshal's Ornamented Belt"],
	quality = 4,
	icon = "inv_belt_14",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32986] = {
	name = L["Marshal's Ornamented Bracers"],
	quality = 4,
	icon = "inv_bracer_19",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32987] = {
	name = L["Marshal's Ornamented Greaves"],
	quality = 4,
	icon = "inv_boots_plate_04",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32988] = {
	name = L["Veteran's Ornamented Belt"],
	quality = 4,
	icon = "inv_belt_14",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32989] = {
	name = L["Veteran's Ornamented Bracers"],
	quality = 4,
	icon = "inv_bracer_19",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32990] = {
	name = L["Veteran's Ornamented Greaves"],
	quality = 4,
	icon = "inv_boots_plate_04",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32991] = {
	name = L["General's Ringmail Bracers"],
	quality = 4,
	icon = "inv_bracer_16",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32992] = {
	name = L["General's Ringmail Girdle"],
	quality = 4,
	icon = "inv_belt_20",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32993] = {
	name = L["General's Ringmail Sabatons"],
	quality = 4,
	icon = "inv_boots_plate_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32994] = {
	name = L["Marshal's Ringmail Bracers"],
	quality = 4,
	icon = "inv_bracer_16",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32995] = {
	name = L["Marshal's Ringmail Girdle"],
	quality = 4,
	icon = "inv_belt_20",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32996] = {
	name = L["Marshal's Ringmail Sabatons"],
	quality = 4,
	icon = "inv_boots_plate_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32997] = {
	name = L["Veteran's Ringmail Bracers"],
	quality = 4,
	icon = "inv_bracer_16",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32998] = {
	name = L["Veteran's Ringmail Girdle"],
	quality = 4,
	icon = "inv_belt_20",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32999] = {
	name = L["Veteran's Ringmail Sabatons"],
	quality = 4,
	icon = "inv_boots_plate_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33056] = {
	name = L["Veteran's Band of Dominance"],
	quality = 4,
	icon = "inv_jewelry_ring_60",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33057] = {
	name = L["Veteran's Band of Triumph"],
	quality = 4,
	icon = "inv_jewelry_ring_60",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33064] = {
	name = L["Veteran's Band of Salvation"],
	quality = 4,
	icon = "inv_jewelry_ring_60",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33065] = {
	name = L["Veteran's Pendant of Dominance"],
	quality = 4,
	icon = "inv_jewelry_necklace_36",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33066] = {
	name = L["Veteran's Pendant of Triumph"],
	quality = 4,
	icon = "inv_jewelry_necklace_36",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33067] = {
	name = L["Veteran's Pendant of Conquest"],
	quality = 4,
	icon = "inv_jewelry_necklace_36",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33068] = {
	name = L["Veteran's Pendant of Salvation"],
	quality = 4,
	icon = "inv_jewelry_necklace_36",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33811] = {
	name = L["Vindicator's Plate Belt"],
	quality = 4,
	icon = "inv_belt_14",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33812] = {
	name = L["Vindicator's Plate Greaves"],
	quality = 4,
	icon = "inv_boots_plate_04",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33813] = {
	name = L["Vindicator's Plate Bracers"],
	quality = 4,
	icon = "inv_bracer_19",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33853] = {
	name = L["Vindicator's Band of Dominance"],
	quality = 4,
	icon = "inv_jewelry_ring_60",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33876] = {
	name = L["Vindicator's Chain Bracers"],
	quality = 4,
	icon = "inv_bracer_16",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33877] = {
	name = L["Vindicator's Chain Girdle"],
	quality = 4,
	icon = "inv_belt_20",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33878] = {
	name = L["Vindicator's Chain Sabatons"],
	quality = 4,
	icon = "inv_boots_plate_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33879] = {
	name = L["Vindicator's Dragonhide Belt"],
	quality = 4,
	icon = "inv_belt_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33880] = {
	name = L["Vindicator's Dragonhide Boots"],
	quality = 4,
	icon = "inv_boots_08",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33881] = {
	name = L["Vindicator's Dragonhide Bracers"],
	quality = 4,
	icon = "inv_bracer_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33882] = {
	name = L["Vindicator's Dreadweave Belt"],
	quality = 4,
	icon = "inv_belt_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33883] = {
	name = L["Vindicator's Dreadweave Cuffs"],
	quality = 4,
	icon = "inv_bracer_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33884] = {
	name = L["Vindicator's Dreadweave Stalkers"],
	quality = 4,
	icon = "inv_boots_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33885] = {
	name = L["Vindicator's Kodohide Belt"],
	quality = 4,
	icon = "inv_belt_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33886] = {
	name = L["Vindicator's Kodohide Boots"],
	quality = 4,
	icon = "inv_boots_08",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33887] = {
	name = L["Vindicator's Kodohide Bracers"],
	quality = 4,
	icon = "inv_bracer_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33888] = {
	name = L["Vindicator's Lamellar Belt"],
	quality = 4,
	icon = "inv_belt_14",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33889] = {
	name = L["Vindicator's Lamellar Bracers"],
	quality = 4,
	icon = "inv_bracer_19",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33890] = {
	name = L["Vindicator's Lamellar Greaves"],
	quality = 4,
	icon = "inv_boots_plate_04",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33891] = {
	name = L["Vindicator's Leather Belt"],
	quality = 4,
	icon = "inv_belt_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33892] = {
	name = L["Vindicator's Leather Boots"],
	quality = 4,
	icon = "inv_boots_08",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33893] = {
	name = L["Vindicator's Leather Bracers"],
	quality = 4,
	icon = "inv_bracer_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33894] = {
	name = L["Vindicator's Linked Bracers"],
	quality = 4,
	icon = "inv_bracer_16",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33895] = {
	name = L["Vindicator's Linked Girdle"],
	quality = 4,
	icon = "inv_belt_20",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33896] = {
	name = L["Vindicator's Linked Sabatons"],
	quality = 4,
	icon = "inv_boots_plate_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33897] = {
	name = L["Vindicator's Mail Bracers"],
	quality = 4,
	icon = "inv_bracer_16",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33898] = {
	name = L["Vindicator's Mail Girdle"],
	quality = 4,
	icon = "inv_belt_20",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33899] = {
	name = L["Vindicator's Mail Sabatons"],
	quality = 4,
	icon = "inv_boots_plate_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33900] = {
	name = L["Vindicator's Mooncloth Belt"],
	quality = 4,
	icon = "inv_belt_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33901] = {
	name = L["Vindicator's Mooncloth Cuffs"],
	quality = 4,
	icon = "inv_bracer_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33902] = {
	name = L["Vindicator's Mooncloth Slippers"],
	quality = 4,
	icon = "inv_boots_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33903] = {
	name = L["Vindicator's Ornamented Belt"],
	quality = 4,
	icon = "inv_belt_14",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33904] = {
	name = L["Vindicator's Ornamented Bracers"],
	quality = 4,
	icon = "inv_bracer_19",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33905] = {
	name = L["Vindicator's Ornamented Greaves"],
	quality = 4,
	icon = "inv_boots_plate_04",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33906] = {
	name = L["Vindicator's Ringmail Bracers"],
	quality = 4,
	icon = "inv_bracer_16",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33907] = {
	name = L["Vindicator's Ringmail Girdle"],
	quality = 4,
	icon = "inv_belt_20",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33908] = {
	name = L["Vindicator's Ringmail Sabatons"],
	quality = 4,
	icon = "inv_boots_plate_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33909] = {
	name = L["Vindicator's Scaled Belt"],
	quality = 4,
	icon = "inv_belt_14",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33910] = {
	name = L["Vindicator's Scaled Bracers"],
	quality = 4,
	icon = "inv_bracer_19",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33911] = {
	name = L["Vindicator's Scaled Greaves"],
	quality = 4,
	icon = "inv_boots_plate_04",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33912] = {
	name = L["Vindicator's Silk Belt"],
	quality = 4,
	icon = "inv_belt_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33913] = {
	name = L["Vindicator's Silk Cuffs"],
	quality = 4,
	icon = "inv_bracer_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33914] = {
	name = L["Vindicator's Silk Footguards"],
	quality = 4,
	icon = "inv_boots_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33915] = {
	name = L["Vindicator's Wyrmhide Belt"],
	quality = 4,
	icon = "inv_belt_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33916] = {
	name = L["Vindicator's Wyrmhide Boots"],
	quality = 4,
	icon = "inv_boots_08",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33917] = {
	name = L["Vindicator's Wyrmhide Bracers"],
	quality = 4,
	icon = "inv_bracer_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33918] = {
	name = L["Vindicator's Band of Salvation"],
	quality = 4,
	icon = "inv_jewelry_ring_60",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33919] = {
	name = L["Vindicator's Band of Triumph"],
	quality = 4,
	icon = "inv_jewelry_ring_60",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33920] = {
	name = L["Vindicator's Pendant of Conquest"],
	quality = 4,
	icon = "inv_jewelry_necklace_36",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33921] = {
	name = L["Vindicator's Pendant of Dominance"],
	quality = 4,
	icon = "inv_jewelry_necklace_36",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33922] = {
	name = L["Vindicator's Pendant of Salvation"],
	quality = 4,
	icon = "inv_jewelry_necklace_36",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33923] = {
	name = L["Vindicator's Pendant of Triumph"],
	quality = 4,
	icon = "inv_jewelry_necklace_36",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34576] = {
	name = L["Battlemaster's Cruelty"],
	quality = 4,
	icon = "ability_warrior_focusedrage",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34577] = {
	name = L["Battlemaster's Depravity"],
	quality = 4,
	icon = "ability_rogue_sinistercalling",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34578] = {
	name = L["Battlemaster's Determination"],
	quality = 4,
	icon = "ability_warrior_endlessrage",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34579] = {
	name = L["Battlemaster's Audacity"],
	quality = 4,
	icon = "spell_nature_focusedmind",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34580] = {
	name = L["Battlemaster's Perseverance"],
	quality = 4,
	icon = "spell_holy_heroism",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35129] = {
	name = L["Guardian's Band of Dominance"],
	quality = 4,
	icon = "inv_jewelry_ring_60",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35130] = {
	name = L["Guardian's Band of Salvation"],
	quality = 4,
	icon = "inv_jewelry_ring_60",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35131] = {
	name = L["Guardian's Band of Triumph"],
	quality = 4,
	icon = "inv_jewelry_ring_60",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35132] = {
	name = L["Guardian's Pendant of Conquest"],
	quality = 4,
	icon = "inv_jewelry_necklace_36",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35133] = {
	name = L["Guardian's Pendant of Dominance"],
	quality = 4,
	icon = "inv_jewelry_necklace_36",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35134] = {
	name = L["Guardian's Pendant of Salvation"],
	quality = 4,
	icon = "inv_jewelry_necklace_36",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35135] = {
	name = L["Guardian's Pendant of Triumph"],
	quality = 4,
	icon = "inv_jewelry_necklace_36",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35136] = {
	name = L["Guardian's Chain Sabatons"],
	quality = 4,
	icon = "inv_boots_plate_09",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35137] = {
	name = L["Guardian's Dragonhide Boots"],
	quality = 4,
	icon = "inv_boots_cloth_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35138] = {
	name = L["Guardian's Dreadweave Stalkers"],
	quality = 4,
	icon = "inv_boots_cloth_12",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35139] = {
	name = L["Guardian's Kodohide Boots"],
	quality = 4,
	icon = "inv_boots_cloth_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35140] = {
	name = L["Guardian's Lamellar Greaves"],
	quality = 4,
	icon = "inv_boots_plate_08",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35141] = {
	name = L["Guardian's Leather Boots"],
	quality = 4,
	icon = "inv_boots_cloth_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35142] = {
	name = L["Guardian's Linked Sabatons"],
	quality = 4,
	icon = "inv_boots_plate_09",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35143] = {
	name = L["Guardian's Mail Sabatons"],
	quality = 4,
	icon = "inv_boots_plate_09",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35144] = {
	name = L["Guardian's Mooncloth Slippers"],
	quality = 4,
	icon = "inv_boots_cloth_12",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35145] = {
	name = L["Guardian's Ornamented Greaves"],
	quality = 4,
	icon = "inv_boots_plate_08",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35146] = {
	name = L["Guardian's Plate Greaves"],
	quality = 4,
	icon = "inv_boots_plate_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35147] = {
	name = L["Guardian's Ringmail Sabatons"],
	quality = 4,
	icon = "inv_boots_plate_09",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35148] = {
	name = L["Guardian's Scaled Greaves"],
	quality = 4,
	icon = "inv_boots_plate_08",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35149] = {
	name = L["Guardian's Silk Footguards"],
	quality = 4,
	icon = "inv_boots_cloth_12",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35150] = {
	name = L["Guardian's Wyrmhide Boots"],
	quality = 4,
	icon = "inv_boots_cloth_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35151] = {
	name = L["Guardian's Chain Girdle"],
	quality = 4,
	icon = "inv_belt_13",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35152] = {
	name = L["Guardian's Dragonhide Belt"],
	quality = 4,
	icon = "inv_belt_12",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35153] = {
	name = L["Guardian's Dreadweave Belt"],
	quality = 4,
	icon = "inv_belt_13",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35154] = {
	name = L["Guardian's Kodohide Belt"],
	quality = 4,
	icon = "inv_belt_12",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35155] = {
	name = L["Guardian's Lamellar Belt"],
	quality = 4,
	icon = "inv_belt_12",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35156] = {
	name = L["Guardian's Leather Belt"],
	quality = 4,
	icon = "inv_belt_12",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35157] = {
	name = L["Guardian's Linked Girdle"],
	quality = 4,
	icon = "inv_belt_13",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35158] = {
	name = L["Guardian's Mail Girdle"],
	quality = 4,
	icon = "inv_belt_13",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35159] = {
	name = L["Guardian's Mooncloth Belt"],
	quality = 4,
	icon = "inv_belt_13",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35160] = {
	name = L["Guardian's Ornamented Belt"],
	quality = 4,
	icon = "inv_belt_12",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35161] = {
	name = L["Guardian's Plate Belt"],
	quality = 4,
	icon = "inv_belt_14",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35162] = {
	name = L["Guardian's Ringmail Girdle"],
	quality = 4,
	icon = "inv_belt_13",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35163] = {
	name = L["Guardian's Scaled Belt"],
	quality = 4,
	icon = "inv_belt_12",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35164] = {
	name = L["Guardian's Silk Belt"],
	quality = 4,
	icon = "inv_belt_12",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35165] = {
	name = L["Guardian's Wyrmhide Belt"],
	quality = 4,
	icon = "inv_belt_12",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35166] = {
	name = L["Guardian's Chain Bracers"],
	quality = 4,
	icon = "inv_bracer_18",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35167] = {
	name = L["Guardian's Dragonhide Bracers"],
	quality = 4,
	icon = "inv_bracer_09",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35168] = {
	name = L["Guardian's Dreadweave Cuffs"],
	quality = 4,
	icon = "inv_bracer_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35169] = {
	name = L["Guardian's Kodohide Bracers"],
	quality = 4,
	icon = "inv_bracer_09",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35170] = {
	name = L["Guardian's Lamellar Bracers"],
	quality = 4,
	icon = "inv_bracer_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35171] = {
	name = L["Guardian's Leather Bracers"],
	quality = 4,
	icon = "inv_bracer_09",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35172] = {
	name = L["Guardian's Linked Bracers"],
	quality = 4,
	icon = "inv_bracer_18",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35173] = {
	name = L["Guardian's Mail Bracers"],
	quality = 4,
	icon = "inv_bracer_18",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35174] = {
	name = L["Guardian's Mooncloth Cuffs"],
	quality = 4,
	icon = "inv_bracer_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35175] = {
	name = L["Guardian's Ornamented Bracers"],
	quality = 4,
	icon = "inv_bracer_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35176] = {
	name = L["Guardian's Plate Bracers"],
	quality = 4,
	icon = "inv_bracer_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35177] = {
	name = L["Guardian's Ringmail Bracers"],
	quality = 4,
	icon = "inv_bracer_18",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35178] = {
	name = L["Guardian's Scaled Bracers"],
	quality = 4,
	icon = "inv_bracer_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35179] = {
	name = L["Guardian's Silk Cuffs"],
	quality = 4,
	icon = "inv_bracer_14",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35180] = {
	name = L["Guardian's Wyrmhide Bracers"],
	quality = 4,
	icon = "inv_bracer_09",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35317] = {
	name = L["Vindicator's Pendant of Reprieve"],
	quality = 4,
	icon = "inv_jewelry_necklace_36",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35319] = {
	name = L["Vindicator's Pendant of Subjugation"],
	quality = 4,
	icon = "inv_jewelry_necklace_36",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35320] = {
	name = L["Vindicator's Band of Subjugation"],
	quality = 4,
	icon = "inv_jewelry_ring_60",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35327] = {
	name = L["Battlemaster's Alacrity"],
	quality = 4,
	icon = "spell_arcane_arcanetorrent",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[37739] = {
	name = L["Brutal Gladiator's Blade of Alacrity"],
	quality = 4,
	icon = "inv_weapon_shortblade_73",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[37740] = {
	name = L["Brutal Gladiator's Swift Judgement"],
	quality = 4,
	icon = "inv_mace_71",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[37864] = {
	name = L["Medallion of the Alliance"],
	quality = 4,
	icon = "inv_jewelry_trinketpvp_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[37865] = {
	name = L["Medallion of the Horde"],
	quality = 4,
	icon = "inv_jewelry_trinketpvp_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[37927] = {
	name = L["Guardian's Band of Subjugation"],
	quality = 4,
	icon = "inv_jewelry_ring_60",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[37928] = {
	name = L["Guardian's Pendant of Subjugation"],
	quality = 4,
	icon = "inv_jewelry_necklace_36",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[37929] = {
	name = L["Guardian's Pendant of Reprieve"],
	quality = 4,
	icon = "inv_jewelry_necklace_36",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[38588] = {
	name = L["Medallion of the Horde"],
	quality = 3,
	icon = "inv_jewelry_trinketpvp_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[38589] = {
	name = L["Medallion of the Alliance"],
	quality = 3,
	icon = "inv_jewelry_trinketpvp_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[40440] = {
	name = L["Brutal Gladiator's Dreadplate Chestpiece"],
	quality = 4,
	icon = "inv_chest_plate_23",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[40441] = {
	name = L["Brutal Gladiator's Dreadplate Gauntlets"],
	quality = 4,
	icon = "inv_gauntlets_62",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[40442] = {
	name = L["Brutal Gladiator's Dreadplate Helm"],
	quality = 4,
	icon = "inv_helmet_127",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[40443] = {
	name = L["Brutal Gladiator's Dreadplate Legguards"],
	quality = 4,
	icon = "inv_pants_plate_27",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[40444] = {
	name = L["Brutal Gladiator's Dreadplate Shoulders"],
	quality = 4,
	icon = "inv_shoulder_89",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[41587] = {
	name = L["Battlemaster's Celerity"],
	quality = 4,
	icon = "spell_arcane_arcanetorrent",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[41588] = {
	name = L["Battlemaster's Aggression"],
	quality = 4,
	icon = "ability_warrior_focusedrage",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[41589] = {
	name = L["Battlemaster's Resolve"],
	quality = 4,
	icon = "ability_warrior_endlessrage",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[41590] = {
	name = L["Battlemaster's Courage"],
	quality = 4,
	icon = "spell_nature_focusedmind",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[41591] = {
	name = L["Sergeant's Reinforced Cape"],
	quality = 4,
	icon = "inv_misc_cape_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[41592] = {
	name = L["The Gladiator's Resolution"],
	quality = 4,
	icon = "inv_misc_cape_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[44429] = {
	name = L["Volanthius Shroud"],
	quality = 4,
	icon = "inv_misc_cape_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[44431] = {
	name = L["Cloak of Certain Reprieve"],
	quality = 4,
	icon = "inv_misc_cape_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[7228] = {
	name = L["Tigule's Strawberry Ice Cream"],
	quality = 1,
	icon = "inv_misc_food_31",
	buyPrice = 500,
	sellPrice = 25,
	reqLevel = 15,
}
t[21893] = {
	name = L["Pattern: Imbued Netherweave Bag"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 40000,
	sellPrice = 10000,
	reqLevel = 0,
	profession = L["Tailoring"],
	teaches = L["Imbued Netherweave Bag"],
	learnedAt = 340,
}
t[21894] = {
	name = L["Pattern: Bolt of Soulcloth"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 40000,
	sellPrice = 10000,
	reqLevel = 0,
	profession = L["Tailoring"],
	teaches = L["Bolt of Soulcloth"],
	learnedAt = 345,
}
t[21902] = {
	name = L["Pattern: Soulcloth Gloves"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 80000,
	sellPrice = 20000,
	reqLevel = 0,
	profession = L["Tailoring"],
	teaches = L["Soulcloth Gloves"],
	learnedAt = 355,
}
t[27691] = {
	name = L["Recipe: Roasted Clefthoof"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 30000,
	sellPrice = 7500,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Roasted Clefthoof"],
	learnedAt = 325,
}
t[27693] = {
	name = L["Recipe: Talbuk Steak"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 30000,
	sellPrice = 7500,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Talbuk Steak"],
	learnedAt = 325,
}
t[27697] = {
	name = L["Recipe: Grilled Mudfish"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 30000,
	sellPrice = 7500,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Grilled Mudfish"],
	learnedAt = 320,
}
t[27698] = {
	name = L["Recipe: Poached Bluefish"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 30000,
	sellPrice = 7500,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Poached Bluefish"],
	learnedAt = 320,
}
t[29136] = {
	name = L["Far Seer's Helm"],
	quality = 3,
	icon = "inv_helmet_04",
	buyPrice = 207131,
	sellPrice = 41426,
	reqLevel = 70,
}
t[29138] = {
	name = L["Arechron's Gift"],
	quality = 3,
	icon = "inv_mace_45",
	buyPrice = 524392,
	sellPrice = 104878,
	reqLevel = 70,
}
t[29140] = {
	name = L["Cloak of the Ancient Spirits"],
	quality = 3,
	icon = "inv_misc_cape_19",
	buyPrice = 130314,
	sellPrice = 26062,
	reqLevel = 70,
}
t[29142] = {
	name = L["Kurenai Kilt"],
	quality = 3,
	icon = "inv_pants_leather_14",
	buyPrice = 218818,
	sellPrice = 43763,
	reqLevel = 70,
}
t[29144] = {
	name = L["Worg Hide Quiver"],
	quality = 3,
	icon = "inv_misc_quiver_06",
	buyPrice = 100000,
	sellPrice = 25000,
	reqLevel = 68,
}
t[29146] = {
	name = L["Band of Elemental Spirits"],
	quality = 3,
	icon = "inv_jewelry_ring_35",
	buyPrice = 175952,
	sellPrice = 43988,
	reqLevel = 70,
}
t[29148] = {
	name = L["Blackened Leather Spaulders"],
	quality = 3,
	icon = "inv_shoulder_25",
	buyPrice = 167743,
	sellPrice = 33548,
	reqLevel = 70,
}
t[29217] = {
	name = L["Pattern: Netherfury Belt"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 120000,
	sellPrice = 30000,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Netherfury Belt"],
	learnedAt = 340,
}
t[29218] = {
	name = L["Pattern: Netherfury Boots"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 120000,
	sellPrice = 30000,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Netherfury Boots"],
	learnedAt = 350,
}
t[29219] = {
	name = L["Pattern: Netherfury Leggings"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 120000,
	sellPrice = 30000,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Netherfury Leggings"],
	learnedAt = 340,
}
t[29227] = {
	name = L["Reins of the Cobalt War Talbuk"],
	quality = 4,
	icon = "inv_misc_foot_centaur",
	buyPrice = 1000000,
	sellPrice = 0,
	reqLevel = 40,
}
t[29229] = {
	name = L["Reins of the Silver War Talbuk"],
	quality = 4,
	icon = "inv_misc_foot_centaur",
	buyPrice = 1000000,
	sellPrice = 0,
	reqLevel = 40,
}
t[29230] = {
	name = L["Reins of the Tan War Talbuk"],
	quality = 4,
	icon = "inv_misc_foot_centaur",
	buyPrice = 1000000,
	sellPrice = 0,
	reqLevel = 40,
}
t[29231] = {
	name = L["Reins of the White War Talbuk"],
	quality = 4,
	icon = "inv_misc_foot_centaur",
	buyPrice = 1000000,
	sellPrice = 0,
	reqLevel = 40,
}
t[30443] = {
	name = L["Recipe: Transmute Primal Fire to Earth"],
	quality = 2,
	icon = "inv_scroll_06",
	buyPrice = 80000,
	sellPrice = 20000,
	reqLevel = 0,
	profession = L["Alchemy"],
	teaches = L["Transmute: Primal Fire to Earth"],
	learnedAt = 350,
}
t[30444] = {
	name = L["Pattern: Reinforced Mining Bag"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 50000,
	sellPrice = 12500,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Reinforced Mining Bag"],
	learnedAt = 325,
}
t[31774] = {
	name = L["Kurenai Tabard"],
	quality = 1,
	icon = "inv_shirt_guildtabard_01",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 0,
}
t[31830] = {
	name = L["Reins of the Cobalt Riding Talbuk"],
	quality = 4,
	icon = "inv_misc_foot_centaur",
	buyPrice = 700000,
	sellPrice = 0,
	reqLevel = 40,
}
t[31832] = {
	name = L["Reins of the Silver Riding Talbuk"],
	quality = 4,
	icon = "inv_misc_foot_centaur",
	buyPrice = 700000,
	sellPrice = 0,
	reqLevel = 40,
}
t[31834] = {
	name = L["Reins of the Tan Riding Talbuk"],
	quality = 4,
	icon = "inv_misc_foot_centaur",
	buyPrice = 700000,
	sellPrice = 0,
	reqLevel = 40,
}
t[31836] = {
	name = L["Reins of the White Riding Talbuk"],
	quality = 4,
	icon = "inv_misc_foot_centaur",
	buyPrice = 700000,
	sellPrice = 0,
	reqLevel = 40,
}
t[34173] = {
	name = L["Pattern: Drums of Speed"],
	quality = 1,
	icon = "inv_scroll_06",
	buyPrice = 160000,
	sellPrice = 40000,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Drums of Speed"],
	learnedAt = 345,
}
t[34175] = {
	name = L["Pattern: Drums of Restoration"],
	quality = 1,
	icon = "inv_scroll_06",
	buyPrice = 160000,
	sellPrice = 40000,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Drums of Restoration"],
	learnedAt = 350,
}
t[187048] = {
	name = L["Pattern: Greater Drums of Restoration"],
	quality = 3,
	icon = "inv_scroll_04",
	buyPrice = 160000,
	sellPrice = 40000,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Greater Drums of Restoration"],
	learnedAt = 350,
}
t[187049] = {
	name = L["Pattern: Greater Drums of Speed"],
	quality = 3,
	icon = "inv_scroll_04",
	buyPrice = 160000,
	sellPrice = 40000,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Greater Drums of Speed"],
	learnedAt = 345,
}
t[22917] = {
	name = L["Recipe: Transmute Primal Fire to Earth"],
	quality = 2,
	icon = "inv_scroll_06",
	buyPrice = 80000,
	sellPrice = 20000,
	reqLevel = 0,
	profession = L["Alchemy"],
	teaches = L["Transmute: Primal Fire to Earth"],
	learnedAt = 350,
}
t[25741] = {
	name = L["Pattern: Netherfury Belt"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 120000,
	sellPrice = 30000,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Netherfury Belt"],
	learnedAt = 340,
}
t[25742] = {
	name = L["Pattern: Netherfury Leggings"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 120000,
	sellPrice = 30000,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Netherfury Leggings"],
	learnedAt = 340,
}
t[25743] = {
	name = L["Pattern: Netherfury Boots"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 120000,
	sellPrice = 30000,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Netherfury Boots"],
	learnedAt = 350,
}
t[29102] = {
	name = L["Reins of the Cobalt War Talbuk"],
	quality = 4,
	icon = "inv_misc_foot_centaur",
	buyPrice = 1000000,
	sellPrice = 0,
	reqLevel = 40,
}
t[29103] = {
	name = L["Reins of the White War Talbuk"],
	quality = 4,
	icon = "inv_misc_foot_centaur",
	buyPrice = 1000000,
	sellPrice = 0,
	reqLevel = 40,
}
t[29104] = {
	name = L["Reins of the Silver War Talbuk"],
	quality = 4,
	icon = "inv_misc_foot_centaur",
	buyPrice = 1000000,
	sellPrice = 0,
	reqLevel = 40,
}
t[29105] = {
	name = L["Reins of the Tan War Talbuk"],
	quality = 4,
	icon = "inv_misc_foot_centaur",
	buyPrice = 1000000,
	sellPrice = 0,
	reqLevel = 40,
}
t[29135] = {
	name = L["Earthcaller's Headdress"],
	quality = 3,
	icon = "inv_helmet_17",
	buyPrice = 206398,
	sellPrice = 41279,
	reqLevel = 70,
}
t[29137] = {
	name = L["Hellscream's Will"],
	quality = 3,
	icon = "inv_axe_44",
	buyPrice = 522358,
	sellPrice = 104471,
	reqLevel = 70,
}
t[29139] = {
	name = L["Ceremonial Cover"],
	quality = 3,
	icon = "inv_misc_cape_06",
	buyPrice = 126329,
	sellPrice = 25265,
	reqLevel = 70,
}
t[29141] = {
	name = L["Tempest Leggings"],
	quality = 3,
	icon = "inv_pants_leather_14",
	buyPrice = 218004,
	sellPrice = 43600,
	reqLevel = 70,
}
t[29143] = {
	name = L["Clefthoof Hide Quiver"],
	quality = 3,
	icon = "inv_misc_quiver_08",
	buyPrice = 100000,
	sellPrice = 25000,
	reqLevel = 68,
}
t[29145] = {
	name = L["Band of Ancestral Spirits"],
	quality = 3,
	icon = "inv_jewelry_ring_15",
	buyPrice = 175952,
	sellPrice = 43988,
	reqLevel = 70,
}
t[29147] = {
	name = L["Talbuk Hide Spaulders"],
	quality = 3,
	icon = "inv_shoulder_07",
	buyPrice = 167132,
	sellPrice = 33426,
	reqLevel = 70,
}
t[29664] = {
	name = L["Pattern: Reinforced Mining Bag"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 50000,
	sellPrice = 12500,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Reinforced Mining Bag"],
	learnedAt = 325,
}
t[31773] = {
	name = L["Mag'har Tabard"],
	quality = 1,
	icon = "inv_shirt_guildtabard_01",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 0,
}
t[31829] = {
	name = L["Reins of the Cobalt Riding Talbuk"],
	quality = 4,
	icon = "inv_misc_foot_centaur",
	buyPrice = 700000,
	sellPrice = 0,
	reqLevel = 40,
}
t[31831] = {
	name = L["Reins of the Silver Riding Talbuk"],
	quality = 4,
	icon = "inv_misc_foot_centaur",
	buyPrice = 700000,
	sellPrice = 0,
	reqLevel = 40,
}
t[31833] = {
	name = L["Reins of the Tan Riding Talbuk"],
	quality = 4,
	icon = "inv_misc_foot_centaur",
	buyPrice = 700000,
	sellPrice = 0,
	reqLevel = 40,
}
t[31835] = {
	name = L["Reins of the White Riding Talbuk"],
	quality = 4,
	icon = "inv_misc_foot_centaur",
	buyPrice = 700000,
	sellPrice = 0,
	reqLevel = 40,
}
t[34172] = {
	name = L["Pattern: Drums of Speed"],
	quality = 1,
	icon = "inv_scroll_06",
	buyPrice = 160000,
	sellPrice = 40000,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Drums of Speed"],
	learnedAt = 345,
}
t[34174] = {
	name = L["Pattern: Drums of Restoration"],
	quality = 1,
	icon = "inv_scroll_06",
	buyPrice = 160000,
	sellPrice = 40000,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Drums of Restoration"],
	learnedAt = 350,
}
t[185923] = {
	name = L["Pattern: Greater Drums of Speed"],
	quality = 3,
	icon = "inv_scroll_04",
	buyPrice = 160000,
	sellPrice = 40000,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Greater Drums of Speed"],
	learnedAt = 345,
}
t[185924] = {
	name = L["Pattern: Greater Drums of Restoration"],
	quality = 3,
	icon = "inv_scroll_04",
	buyPrice = 160000,
	sellPrice = 40000,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Greater Drums of Restoration"],
	learnedAt = 350,
}
t[2520] = {
	name = L["Broadsword"],
	quality = 1,
	icon = "inv_sword_05",
	buyPrice = 24629,
	sellPrice = 4925,
	reqLevel = 31,
}
t[2521] = {
	name = L["Flamberge"],
	quality = 1,
	icon = "inv_sword_26",
	buyPrice = 30896,
	sellPrice = 6179,
	reqLevel = 31,
}
t[2526] = {
	name = L["Main Gauche"],
	quality = 1,
	icon = "inv_weapon_shortblade_15",
	buyPrice = 19336,
	sellPrice = 3867,
	reqLevel = 29,
}
t[2528] = {
	name = L["Falchion"],
	quality = 1,
	icon = "inv_sword_34",
	buyPrice = 51836,
	sellPrice = 10367,
	reqLevel = 41,
}
t[2529] = {
	name = L["Zweihander"],
	quality = 1,
	icon = "inv_sword_15",
	buyPrice = 65032,
	sellPrice = 13006,
	reqLevel = 41,
}
t[2534] = {
	name = L["Rondel"],
	quality = 1,
	icon = "inv_sword_31",
	buyPrice = 45431,
	sellPrice = 9086,
	reqLevel = 39,
}
t[24208] = {
	name = L["Design: Mystic Dawnstone"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 120000,
	sellPrice = 30000,
	reqLevel = 0,
}
t[28915] = {
	name = L["Reins of the Dark Riding Talbuk"],
	quality = 4,
	icon = "inv_misc_foot_centaur",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 40,
}
t[29228] = {
	name = L["Reins of the Dark War Talbuk"],
	quality = 4,
	icon = "inv_misc_foot_centaur",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 40,
}
t[30568] = {
	name = L["The Sharp Cookie"],
	quality = 2,
	icon = "ability_upgrademoonglaive",
	buyPrice = 22142,
	sellPrice = 5535,
	reqLevel = 66,
}
t[30569] = {
	name = L["Proximo's Rudius"],
	quality = 0,
	icon = "inv_sword_04",
	buyPrice = 18166,
	sellPrice = 3633,
	reqLevel = 64,
}
t[30570] = {
	name = L["Arkadian Claymore"],
	quality = 2,
	icon = "inv_sword_draenei_06",
	buyPrice = 87726,
	sellPrice = 17545,
	reqLevel = 66,
}
t[30571] = {
	name = L["Don Rodrigo's Heart"],
	quality = 3,
	icon = "inv_misc_gem_ruby_01",
	buyPrice = 140972,
	sellPrice = 35243,
	reqLevel = 0,
}
t[30611] = {
	name = L["Halaani Razorshaft"],
	quality = 3,
	icon = "inv_misc_ammo_arrow_03",
	buyPrice = 5000,
	sellPrice = 6,
	reqLevel = 66,
}
t[30612] = {
	name = L["Halaani Grimshot"],
	quality = 3,
	icon = "inv_misc_ammo_bullet_04",
	buyPrice = 5000,
	sellPrice = 6,
	reqLevel = 66,
}
t[30615] = {
	name = L["Halaani Whiskey"],
	quality = 1,
	icon = "inv_drink_01",
	buyPrice = 16000,
	sellPrice = 1333,
	reqLevel = 0,
}
t[30597] = {
	name = L["Halaani Claymore"],
	quality = 2,
	icon = "inv_sword_draenei_06",
	buyPrice = 92463,
	sellPrice = 18492,
	reqLevel = 66,
}
t[30598] = {
	name = L["Don Amancio's Heart"],
	quality = 3,
	icon = "inv_misc_gem_ruby_01",
	buyPrice = 140972,
	sellPrice = 35243,
	reqLevel = 0,
}
t[30599] = {
	name = L["Avenging Blades"],
	quality = 2,
	icon = "ability_upgrademoonglaive",
	buyPrice = 22142,
	sellPrice = 5535,
	reqLevel = 66,
}
t[22918] = {
	name = L["Recipe: Transmute Primal Water to Air"],
	quality = 2,
	icon = "inv_scroll_06",
	buyPrice = 80000,
	sellPrice = 20000,
	reqLevel = 0,
	profession = L["Alchemy"],
	teaches = L["Transmute: Primal Water to Air"],
	learnedAt = 350,
}
t[22922] = {
	name = L["Recipe: Major Nature Protection Potion"],
	quality = 1,
	icon = "inv_scroll_06",
	buyPrice = 100000,
	sellPrice = 25000,
	reqLevel = 0,
	profession = L["Alchemy"],
	teaches = L["Major Nature Protection Potion"],
	learnedAt = 360,
}
t[23618] = {
	name = L["Plans: Adamantite Sharpening Stone"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 60000,
	sellPrice = 15000,
	reqLevel = 0,
	profession = L["Blacksmithing"],
	teaches = L["Adamantite Sharpening Stone"],
	learnedAt = 350,
}
t[23814] = {
	name = L["Schematic: Green Smoke Flare"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 60000,
	sellPrice = 15000,
	reqLevel = 0,
	profession = L["Engineering"],
	teaches = L["Green Smoke Flare"],
	learnedAt = 335,
}
t[24183] = {
	name = L["Design: Nightseye Panther"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 120000,
	sellPrice = 30000,
	reqLevel = 0,
}
t[24417] = {
	name = L["Scout's Arrow"],
	quality = 2,
	icon = "inv_misc_ammo_arrow_05",
	buyPrice = 2000,
	sellPrice = 2,
	reqLevel = 61,
}
t[24429] = {
	name = L["Expedition Flare"],
	quality = 1,
	icon = "inv_enchant_essenceastralsmall",
	buyPrice = 8000,
	sellPrice = 2000,
	reqLevel = 60,
}
t[25526] = {
	name = L["Plans: Greater Rune of Warding"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 60000,
	sellPrice = 15000,
	reqLevel = 0,
	profession = L["Blacksmithing"],
	teaches = L["Greater Rune of Warding"],
	learnedAt = 350,
}
t[25735] = {
	name = L["Pattern: Heavy Clefthoof Vest"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 160000,
	sellPrice = 40000,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Heavy Clefthoof Vest"],
	learnedAt = 360,
}
t[25736] = {
	name = L["Pattern: Heavy Clefthoof Leggings"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 140000,
	sellPrice = 35000,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Heavy Clefthoof Leggings"],
	learnedAt = 355,
}
t[25737] = {
	name = L["Pattern: Heavy Clefthoof Boots"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 140000,
	sellPrice = 35000,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Heavy Clefthoof Boots"],
	learnedAt = 355,
}
t[25835] = {
	name = L["Explorer's Walking Stick"],
	quality = 3,
	icon = "inv_staff_31",
	buyPrice = 447982,
	sellPrice = 89596,
	reqLevel = 62,
}
t[25836] = {
	name = L["Preserver's Cudgel"],
	quality = 3,
	icon = "inv_mace_11",
	buyPrice = 359704,
	sellPrice = 71940,
	reqLevel = 62,
}
t[25838] = {
	name = L["Warden's Hauberk"],
	quality = 3,
	icon = "inv_chest_leather_08",
	buyPrice = 181153,
	sellPrice = 36230,
	reqLevel = 62,
}
t[25869] = {
	name = L["Recipe: Transmute Earthstorm Diamond"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 80000,
	sellPrice = 20000,
	reqLevel = 0,
	profession = L["Alchemy"],
	teaches = L["Transmute: Earthstorm Diamond"],
	learnedAt = 350,
}
t[28271] = {
	name = L["Formula: Enchant Gloves - Precise Strikes"],
	quality = 2,
	icon = "inv_misc_note_01",
	buyPrice = 80000,
	sellPrice = 20000,
	reqLevel = 0,
	profession = L["Enchanting"],
	teaches = L["Enchant Gloves - Precise Strikes"],
	learnedAt = 360,
}
t[28632] = {
	name = L["Plans: Adamantite Weightstone"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 60000,
	sellPrice = 15000,
	reqLevel = 0,
	profession = L["Blacksmithing"],
	teaches = L["Adamantite Weightstone"],
	learnedAt = 350,
}
t[29170] = {
	name = L["Windcaller's Orb"],
	quality = 4,
	icon = "inv_misc_orb_01",
	buyPrice = 790112,
	sellPrice = 197528,
	reqLevel = 70,
}
t[29171] = {
	name = L["Earthwarden"],
	quality = 4,
	icon = "inv_hammer_10",
	buyPrice = 2656817,
	sellPrice = 531363,
	reqLevel = 70,
}
t[29172] = {
	name = L["Ashyen's Gift"],
	quality = 4,
	icon = "inv_jewelry_ring_51naxxramas",
	buyPrice = 790112,
	sellPrice = 197528,
	reqLevel = 70,
}
t[29173] = {
	name = L["Strength of the Untamed"],
	quality = 3,
	icon = "inv_jewelry_necklace_06",
	buyPrice = 175952,
	sellPrice = 43988,
	reqLevel = 70,
}
t[29174] = {
	name = L["Watcher's Cowl"],
	quality = 3,
	icon = "inv_helmet_34",
	buyPrice = 127371,
	sellPrice = 25474,
	reqLevel = 70,
}
t[29192] = {
	name = L["Arcanum of Ferocity"],
	quality = 2,
	icon = "classic_ability_druid_demoralizingroar",
	buyPrice = 1000000,
	sellPrice = 250000,
	reqLevel = 70,
}
t[29194] = {
	name = L["Arcanum of Nature Warding"],
	quality = 2,
	icon = "spell_nature_protectionformnature",
	buyPrice = 1000000,
	sellPrice = 250000,
	reqLevel = 70,
}
t[29720] = {
	name = L["Pattern: Clefthide Leg Armor"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 60000,
	sellPrice = 15000,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Clefthide Leg Armor"],
	learnedAt = 335,
}
t[29721] = {
	name = L["Pattern: Nethercleft Leg Armor"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 120000,
	sellPrice = 30000,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Nethercleft Leg Armor"],
	learnedAt = 365,
}
t[30623] = {
	name = L["Reservoir Key"],
	quality = 1,
	icon = "inv_misc_key_13",
	buyPrice = 100000,
	sellPrice = 25000,
	reqLevel = 0,
}
t[31356] = {
	name = L["Recipe: Flask of Distilled Wisdom"],
	quality = 2,
	icon = "inv_scroll_06",
	buyPrice = 40000,
	sellPrice = 10000,
	reqLevel = 0,
	profession = L["Alchemy"],
	teaches = L["Flask of Distilled Wisdom"],
	learnedAt = 300,
}
t[31390] = {
	name = L["Plans: Wildguard Breastplate"],
	quality = 4,
	icon = "inv_scroll_04",
	buyPrice = 240000,
	sellPrice = 60000,
	reqLevel = 0,
	profession = L["Blacksmithing"],
	teaches = L["Wildguard Breastplate"],
	learnedAt = 375,
}
t[31391] = {
	name = L["Plans: Wildguard Leggings"],
	quality = 4,
	icon = "inv_scroll_04",
	buyPrice = 240000,
	sellPrice = 60000,
	reqLevel = 0,
	profession = L["Blacksmithing"],
	teaches = L["Wildguard Leggings"],
	learnedAt = 375,
}
t[31392] = {
	name = L["Plans: Wildguard Helm"],
	quality = 4,
	icon = "inv_scroll_04",
	buyPrice = 240000,
	sellPrice = 60000,
	reqLevel = 0,
	profession = L["Blacksmithing"],
	teaches = L["Wildguard Helm"],
	learnedAt = 375,
}
t[31402] = {
	name = L["Design: The Natural Ward"],
	quality = 4,
	icon = "inv_scroll_04",
	buyPrice = 120000,
	sellPrice = 30000,
	reqLevel = 0,
}
t[31804] = {
	name = L["Cenarion Expedition Tabard"],
	quality = 1,
	icon = "inv_shirt_guildtabard_01",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 0,
}
t[31949] = {
	name = L["Warden's Arrow"],
	quality = 3,
	icon = "inv_misc_ammo_arrow_02",
	buyPrice = 5000,
	sellPrice = 6,
	reqLevel = 68,
}
t[32070] = {
	name = L["Recipe: Earthen Elixir"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 40000,
	sellPrice = 10000,
	reqLevel = 0,
	profession = L["Alchemy"],
	teaches = L["Earthen Elixir"],
	learnedAt = 320,
}
t[33149] = {
	name = L["Formula: Enchant Cloak - Stealth"],
	quality = 3,
	icon = "inv_misc_note_01",
	buyPrice = 100000,
	sellPrice = 25000,
	reqLevel = 0,
	profession = L["Enchanting"],
	teaches = L["Enchant Cloak - Stealth"],
	learnedAt = 300,
}
t[33999] = {
	name = L["Cenarion War Hippogryph"],
	quality = 4,
	icon = "ability_mount_warhippogryph",
	buyPrice = 20000000,
	sellPrice = 0,
	reqLevel = 70,
}
t[35329] = {
	name = L["Dreadweave Hood"],
	quality = 3,
	icon = "inv_helmet_30",
	buyPrice = 130908,
	sellPrice = 26181,
	reqLevel = 70,
}
t[35336] = {
	name = L["Mooncloth Shoulderpads"],
	quality = 3,
	icon = "inv_shoulder_02",
	buyPrice = 134313,
	sellPrice = 26862,
	reqLevel = 70,
}
t[35342] = {
	name = L["Satin Robe"],
	quality = 3,
	icon = "inv_chest_cloth_43",
	buyPrice = 182955,
	sellPrice = 36591,
	reqLevel = 70,
}
t[35347] = {
	name = L["Evoker's Silk Trousers"],
	quality = 3,
	icon = "inv_pants_07",
	buyPrice = 173242,
	sellPrice = 34648,
	reqLevel = 70,
}
t[35367] = {
	name = L["Opportunist's Leather Helm"],
	quality = 3,
	icon = "inv_helmet_30",
	buyPrice = 162381,
	sellPrice = 32476,
	reqLevel = 70,
}
t[35379] = {
	name = L["Stalker's Chain Leggings"],
	quality = 3,
	icon = "inv_pants_mail_15",
	buyPrice = 252025,
	sellPrice = 50405,
	reqLevel = 70,
}
t[35385] = {
	name = L["Seer's Linked Spaulders"],
	quality = 3,
	icon = "inv_shoulder_29",
	buyPrice = 194253,
	sellPrice = 38850,
	reqLevel = 70,
}
t[35387] = {
	name = L["Seer's Mail Gauntlets"],
	quality = 3,
	icon = "inv_gauntlets_11",
	buyPrice = 129892,
	sellPrice = 25978,
	reqLevel = 70,
}
t[35394] = {
	name = L["Seer's Ringmail Legguards"],
	quality = 3,
	icon = "inv_pants_mail_15",
	buyPrice = 273561,
	sellPrice = 54712,
	reqLevel = 70,
}
t[185690] = {
	name = L["Reservoir Key"],
	quality = 1,
	icon = "inv_misc_key_13",
	buyPrice = 100000,
	sellPrice = 25000,
	reqLevel = 0,
}
t[22902] = {
	name = L["Recipe: Elixir of Major Frost Power"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 40000,
	sellPrice = 10000,
	reqLevel = 0,
	profession = L["Alchemy"],
	teaches = L["Elixir of Major Frost Power"],
	learnedAt = 320,
}
t[22907] = {
	name = L["Recipe: Super Mana Potion"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 50000,
	sellPrice = 12500,
	reqLevel = 0,
	profession = L["Alchemy"],
	teaches = L["Super Mana Potion"],
	learnedAt = 340,
}
t[22909] = {
	name = L["Recipe: Elixir of Major Defense"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 50000,
	sellPrice = 12500,
	reqLevel = 0,
	profession = L["Alchemy"],
	teaches = L["Elixir of Major Defense"],
	learnedAt = 345,
}
t[2892] = {
	name = L["Deadly Poison"],
	quality = 1,
	icon = "ability_rogue_dualweild",
	buyPrice = 100,
	sellPrice = 25,
	reqLevel = 30,
}
t[2893] = {
	name = L["Deadly Poison II"],
	quality = 1,
	icon = "ability_rogue_dualweild",
	buyPrice = 150,
	sellPrice = 37,
	reqLevel = 38,
}
t[6947] = {
	name = L["Instant Poison"],
	quality = 1,
	icon = "ability_poisons",
	buyPrice = 25,
	sellPrice = 6,
	reqLevel = 20,
}
t[6949] = {
	name = L["Instant Poison II"],
	quality = 1,
	icon = "ability_poisons",
	buyPrice = 50,
	sellPrice = 12,
	reqLevel = 28,
}
t[6950] = {
	name = L["Instant Poison III"],
	quality = 1,
	icon = "ability_poisons",
	buyPrice = 150,
	sellPrice = 37,
	reqLevel = 36,
}
t[8926] = {
	name = L["Instant Poison IV"],
	quality = 1,
	icon = "ability_poisons",
	buyPrice = 500,
	sellPrice = 125,
	reqLevel = 44,
}
t[8984] = {
	name = L["Deadly Poison III"],
	quality = 1,
	icon = "ability_rogue_dualweild",
	buyPrice = 200,
	sellPrice = 50,
	reqLevel = 46,
}
t[10918] = {
	name = L["Wound Poison"],
	quality = 1,
	icon = "inv_misc_herb_16",
	buyPrice = 50,
	sellPrice = 12,
	reqLevel = 32,
}
t[10920] = {
	name = L["Wound Poison II"],
	quality = 1,
	icon = "inv_misc_herb_16",
	buyPrice = 150,
	sellPrice = 37,
	reqLevel = 40,
}
t[10921] = {
	name = L["Wound Poison III"],
	quality = 1,
	icon = "inv_misc_herb_16",
	buyPrice = 250,
	sellPrice = 62,
	reqLevel = 48,
}
t[43230] = {
	name = L["Instant Poison VIII"],
	quality = 1,
	icon = "ability_poisons",
	buyPrice = 4000,
	sellPrice = 1000,
	reqLevel = 73,
}
t[43231] = {
	name = L["Instant Poison IX"],
	quality = 1,
	icon = "ability_poisons",
	buyPrice = 4500,
	sellPrice = 1125,
	reqLevel = 79,
}
t[43232] = {
	name = L["Deadly Poison VIII"],
	quality = 1,
	icon = "ability_rogue_dualweild",
	buyPrice = 4500,
	sellPrice = 1125,
	reqLevel = 76,
}
t[43233] = {
	name = L["Deadly Poison IX"],
	quality = 1,
	icon = "ability_rogue_dualweild",
	buyPrice = 5000,
	sellPrice = 1250,
	reqLevel = 80,
}
t[43234] = {
	name = L["Wound Poison VI"],
	quality = 1,
	icon = "inv_misc_herb_16",
	buyPrice = 3500,
	sellPrice = 875,
	reqLevel = 72,
}
t[43235] = {
	name = L["Wound Poison VII"],
	quality = 1,
	icon = "inv_misc_herb_16",
	buyPrice = 4000,
	sellPrice = 1000,
	reqLevel = 78,
}
t[43237] = {
	name = L["Anesthetic Poison II"],
	quality = 1,
	icon = "spell_nature_slowpoison",
	buyPrice = 4000,
	sellPrice = 1000,
	reqLevel = 77,
}
t[21898] = {
	name = L["Pattern: Imbued Netherweave Pants"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 60000,
	sellPrice = 15000,
	reqLevel = 0,
	profession = L["Tailoring"],
	teaches = L["Imbued Netherweave Pants"],
	learnedAt = 340,
}
t[21899] = {
	name = L["Pattern: Imbued Netherweave Boots"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 60000,
	sellPrice = 15000,
	reqLevel = 0,
	profession = L["Tailoring"],
	teaches = L["Imbued Netherweave Boots"],
	learnedAt = 350,
}
t[27695] = {
	name = L["Recipe: Feltail Delight"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 20000,
	sellPrice = 5000,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Feltail Delight"],
	learnedAt = 300,
}
t[27694] = {
	name = L["Recipe: Blackened Trout"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 20000,
	sellPrice = 5000,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Blackened Trout"],
	learnedAt = 300,
}
t[22901] = {
	name = L["Recipe: Sneaking Potion"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 30000,
	sellPrice = 7500,
	reqLevel = 0,
	profession = L["Alchemy"],
	teaches = L["Sneaking Potion"],
	learnedAt = 315,
}
t[6365] = {
	name = L["Strong Fishing Pole"],
	quality = 1,
	icon = "inv_fishingpole_02",
	buyPrice = 902,
	sellPrice = 180,
	reqLevel = 5,
}
t[6529] = {
	name = L["Shiny Bauble"],
	quality = 1,
	icon = "inv_misc_orb_03",
	buyPrice = 50,
	sellPrice = 12,
	reqLevel = 0,
}
t[6533] = {
	name = L["Aquadynamic Fish Attractor"],
	quality = 1,
	icon = "inv_misc_food_26",
	buyPrice = 250,
	sellPrice = 62,
	reqLevel = 0,
}
t[22906] = {
	name = L["Recipe: Shrouding Potion"],
	quality = 2,
	icon = "inv_scroll_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Alchemy"],
	teaches = L["Shrouding Potion"],
	learnedAt = 335,
}
t[22916] = {
	name = L["Recipe: Transmute Primal Earth to Water"],
	quality = 2,
	icon = "inv_scroll_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Alchemy"],
	teaches = L["Transmute: Primal Earth to Water"],
	learnedAt = 350,
}
t[24539] = {
	name = L["Marsh Lichen"],
	quality = 1,
	icon = "inv_mushroom_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 55,
}
t[25548] = {
	name = L["Tallstalk Mushroom"],
	quality = 1,
	icon = "inv_mushroom_10",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 40,
}
t[25550] = {
	name = L["Redcap Toadstool"],
	quality = 1,
	icon = "inv_mushroom_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 40,
}
t[25827] = {
	name = L["Muck-Covered Drape"],
	quality = 3,
	icon = "inv_misc_cape_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 64,
}
t[25828] = {
	name = L["Petrified Lichen Guard"],
	quality = 3,
	icon = "inv_shield_21",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 62,
}
t[27689] = {
	name = L["Recipe: Sporeling Snack"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Sporeling Snack"],
	learnedAt = 310,
}
t[29149] = {
	name = L["Sporeling's Firestick"],
	quality = 3,
	icon = "inv_staff_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 62,
}
t[29150] = {
	name = L["Hardened Stone Shard"],
	quality = 3,
	icon = "inv_weapon_shortblade_08",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 62,
}
t[30156] = {
	name = L["Recipe: Clam Bar"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Clam Bar"],
	learnedAt = 300,
}
t[31775] = {
	name = L["Sporeggar Tabard"],
	quality = 1,
	icon = "inv_shirt_guildtabard_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[34478] = {
	name = L["Tiny Sporebat"],
	quality = 3,
	icon = "ability_hunter_pet_sporebat",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[38229] = {
	name = L["Pattern: Mycah's Botanical Bag"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Tailoring"],
	teaches = L["Mycah's Botanical Bag"],
	learnedAt = 375,
}
t[27920] = {
	name = L["Mark of Conquest"],
	quality = 3,
	icon = "inv_misc_armorkit_11",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 62,
}
t[27924] = {
	name = L["Mark of Defiance"],
	quality = 3,
	icon = "inv_jewelry_necklace_16",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 62,
}
t[27926] = {
	name = L["Mark of Vindication"],
	quality = 3,
	icon = "inv_qirajidol_sun",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 62,
}
t[27928] = {
	name = L["Terminal Edge"],
	quality = 3,
	icon = "inv_axe_03",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 62,
}
t[27930] = {
	name = L["Splintermark"],
	quality = 3,
	icon = "inv_weapon_bow_04",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 62,
}
t[27939] = {
	name = L["Incendic Rod"],
	quality = 3,
	icon = "inv_wand_11",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 62,
}
t[27947] = {
	name = L["Totem of Impact"],
	quality = 3,
	icon = "spell_nature_slowingtotem",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 62,
}
t[27949] = {
	name = L["Libram of Zeal"],
	quality = 3,
	icon = "inv_relics_libramoftruth",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 62,
}
t[27989] = {
	name = L["Idol of Savagery"],
	quality = 3,
	icon = "inv_relics_idolofferocity",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 62,
}
t[27921] = {
	name = L["Mark of Conquest"],
	quality = 3,
	icon = "inv_misc_armorkit_12",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 62,
}
t[27922] = {
	name = L["Mark of Defiance"],
	quality = 3,
	icon = "inv_jewelry_necklace_16",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 62,
}
t[27927] = {
	name = L["Mark of Vindication"],
	quality = 3,
	icon = "inv_qirajidol_sun",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 62,
}
t[27929] = {
	name = L["Terminal Edge"],
	quality = 3,
	icon = "inv_axe_03",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 62,
}
t[27931] = {
	name = L["Splintermark"],
	quality = 3,
	icon = "inv_weapon_bow_04",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 62,
}
t[27942] = {
	name = L["Incendic Rod"],
	quality = 3,
	icon = "inv_wand_11",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 62,
}
t[27983] = {
	name = L["Libram of Zeal"],
	quality = 3,
	icon = "inv_relics_libramoftruth",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 62,
}
t[27984] = {
	name = L["Totem of Impact"],
	quality = 3,
	icon = "spell_nature_slowingtotem",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 62,
}
t[27990] = {
	name = L["Idol of Savagery"],
	quality = 3,
	icon = "inv_relics_idolofferocity",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 62,
}
t[29112] = {
	name = L["Cenarion Spirits"],
	quality = 1,
	icon = "inv_drink_11",
	buyPrice = 300,
	sellPrice = 75,
	reqLevel = 0,
}
t[27532] = {
	name = L["Master Fishing - The Art of Angling"],
	quality = 1,
	icon = "inv_misc_book_06",
	buyPrice = 50000,
	sellPrice = 12500,
	reqLevel = 45,
}
t[27696] = {
	name = L["Recipe: Blackened Sporefish"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 20000,
	sellPrice = 5000,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Blackened Sporefish"],
	learnedAt = 310,
}
t[23811] = {
	name = L["Schematic: White Smoke Flare"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 60000,
	sellPrice = 15000,
	reqLevel = 0,
	profession = L["Engineering"],
	teaches = L["White Smoke Flare"],
	learnedAt = 335,
}
t[32903] = {
	name = L["Cenarion Mana Salve"],
	quality = 1,
	icon = "inv_potion_168",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 55,
}
t[32904] = {
	name = L["Cenarion Healing Salve"],
	quality = 1,
	icon = "inv_potion_167",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 55,
}
t[19221] = {
	name = L["Darkmoon Special Reserve"],
	quality = 1,
	icon = "inv_drink_03",
	buyPrice = 50,
	sellPrice = 12,
	reqLevel = 0,
}
t[19222] = {
	name = L["Cheap Beer"],
	quality = 1,
	icon = "inv_drink_08",
	buyPrice = 10,
	sellPrice = 2,
	reqLevel = 0,
}
t[19299] = {
	name = L["Fizzy Faire Drink"],
	quality = 1,
	icon = "inv_drink_05",
	buyPrice = 500,
	sellPrice = 25,
	reqLevel = 15,
}
t[19300] = {
	name = L["Bottled Winterspring Water"],
	quality = 1,
	icon = "inv_drink_18",
	buyPrice = 2000,
	sellPrice = 100,
	reqLevel = 35,
}
t[33234] = {
	name = L["Iced Berry Slush"],
	quality = 1,
	icon = "inv_drink_20",
	buyPrice = 4000,
	sellPrice = 200,
	reqLevel = 45,
}
t[33236] = {
	name = L["Fizzy Faire Drink \"Classic\""],
	quality = 1,
	icon = "inv_drink_waterskin_11",
	buyPrice = 5600,
	sellPrice = 280,
	reqLevel = 60,
}
t[44941] = {
	name = L["Fresh-Squeezed Limeade"],
	quality = 1,
	icon = "inv_drink_21",
	buyPrice = 8500,
	sellPrice = 425,
	reqLevel = 70,
}
t[19223] = {
	name = L["Darkmoon Dog"],
	quality = 1,
	icon = "inv_misc_food_66",
	buyPrice = 25,
	sellPrice = 1,
	reqLevel = 1,
}
t[19224] = {
	name = L["Red Hot Wings"],
	quality = 1,
	icon = "inv_misc_food_46",
	buyPrice = 1000,
	sellPrice = 50,
	reqLevel = 25,
}
t[19225] = {
	name = L["Deep Fried Candybar"],
	quality = 1,
	icon = "inv_misc_food_27",
	buyPrice = 4000,
	sellPrice = 200,
	reqLevel = 45,
}
t[19304] = {
	name = L["Spiced Beef Jerky"],
	quality = 1,
	icon = "inv_misc_leatherscrap_07",
	buyPrice = 125,
	sellPrice = 6,
	reqLevel = 5,
}
t[19305] = {
	name = L["Pickled Kodo Foot"],
	quality = 1,
	icon = "inv_misc_foot_kodo",
	buyPrice = 500,
	sellPrice = 25,
	reqLevel = 15,
}
t[19306] = {
	name = L["Crunchy Frog"],
	quality = 1,
	icon = "inv_misc_fish_33",
	buyPrice = 2000,
	sellPrice = 100,
	reqLevel = 35,
}
t[33246] = {
	name = L["Funnel Cake"],
	quality = 1,
	icon = "inv_misc_food_73cinnamonroll",
	buyPrice = 5600,
	sellPrice = 280,
	reqLevel = 55,
}
t[33254] = {
	name = L["Forest Strider Drumstick"],
	quality = 1,
	icon = "inv_misc_food_60",
	buyPrice = 8000,
	sellPrice = 400,
	reqLevel = 65,
}
t[44940] = {
	name = L["Corn-Breaded Sausage"],
	quality = 1,
	icon = "inv_holiday_beerfestsausage04",
	buyPrice = 16000,
	sellPrice = 800,
	reqLevel = 75,
}
t[785] = {
	name = L["Mageroyal"],
	quality = 1,
	icon = "inv_jewelry_talisman_03",
	buyPrice = 80,
	sellPrice = 20,
	reqLevel = 0,
}
t[2319] = {
	name = L["Medium Leather"],
	quality = 1,
	icon = "inv_misc_leatherscrap_05",
	buyPrice = 200,
	sellPrice = 50,
	reqLevel = 0,
}
t[2449] = {
	name = L["Earthroot"],
	quality = 1,
	icon = "inv_misc_herb_07",
	buyPrice = 80,
	sellPrice = 20,
	reqLevel = 0,
}
t[2453] = {
	name = L["Bruiseweed"],
	quality = 1,
	icon = "inv_misc_herb_01",
	buyPrice = 100,
	sellPrice = 25,
	reqLevel = 0,
}
t[3355] = {
	name = L["Wild Steelbloom"],
	quality = 1,
	icon = "inv_misc_flower_01",
	buyPrice = 200,
	sellPrice = 50,
	reqLevel = 0,
}
t[3356] = {
	name = L["Kingsblood"],
	quality = 1,
	icon = "inv_misc_herb_03",
	buyPrice = 120,
	sellPrice = 30,
	reqLevel = 0,
}
t[3357] = {
	name = L["Liferoot"],
	quality = 1,
	icon = "inv_misc_root_02",
	buyPrice = 300,
	sellPrice = 75,
	reqLevel = 0,
}
t[3358] = {
	name = L["Khadgar's Whisker"],
	quality = 1,
	icon = "inv_misc_herb_08",
	buyPrice = 700,
	sellPrice = 175,
	reqLevel = 0,
}
t[4234] = {
	name = L["Heavy Leather"],
	quality = 1,
	icon = "inv_misc_leatherscrap_07",
	buyPrice = 600,
	sellPrice = 150,
	reqLevel = 0,
}
t[4304] = {
	name = L["Thick Leather"],
	quality = 1,
	icon = "inv_misc_leatherscrap_08",
	buyPrice = 1200,
	sellPrice = 300,
	reqLevel = 0,
}
t[8170] = {
	name = L["Rugged Leather"],
	quality = 1,
	icon = "inv_misc_leatherscrap_02",
	buyPrice = 2000,
	sellPrice = 500,
	reqLevel = 0,
}
t[8845] = {
	name = L["Ghost Mushroom"],
	quality = 1,
	icon = "inv_mushroom_08",
	buyPrice = 1500,
	sellPrice = 375,
	reqLevel = 0,
}
t[11303] = {
	name = L["Fine Shortbow"],
	quality = 2,
	icon = "inv_weapon_bow_07",
	buyPrice = 3185,
	sellPrice = 637,
	reqLevel = 11,
}
t[11305] = {
	name = L["Dense Shortbow"],
	quality = 2,
	icon = "inv_weapon_bow_07",
	buyPrice = 25814,
	sellPrice = 5162,
	reqLevel = 30,
}
t[11306] = {
	name = L["Sturdy Recurve"],
	quality = 2,
	icon = "inv_weapon_bow_07",
	buyPrice = 19468,
	sellPrice = 3893,
	reqLevel = 27,
}
t[11308] = {
	name = L["Sylvan Shortbow"],
	quality = 2,
	icon = "inv_weapon_bow_07",
	buyPrice = 78829,
	sellPrice = 15765,
	reqLevel = 44,
}
t[12248] = {
	name = L["Daring Dirk"],
	quality = 2,
	icon = "inv_weapon_shortblade_15",
	buyPrice = 32030,
	sellPrice = 6406,
	reqLevel = 29,
}
t[12251] = {
	name = L["Big Stick"],
	quality = 2,
	icon = "inv_staff_21",
	buyPrice = 53897,
	sellPrice = 10779,
	reqLevel = 32,
}
t[12810] = {
	name = L["Enchanted Leather"],
	quality = 1,
	icon = "inv_misc_rune_05",
	buyPrice = 2000,
	sellPrice = 500,
	reqLevel = 0,
}
t[13463] = {
	name = L["Dreamfoil"],
	quality = 1,
	icon = "inv_misc_herb_dreamfoil",
	buyPrice = 400,
	sellPrice = 100,
	reqLevel = 0,
}
t[13464] = {
	name = L["Golden Sansam"],
	quality = 1,
	icon = "inv_misc_herb_sansamroot",
	buyPrice = 400,
	sellPrice = 100,
	reqLevel = 0,
}
t[13465] = {
	name = L["Mountain Silversage"],
	quality = 1,
	icon = "inv_misc_herb_mountainsilversage",
	buyPrice = 600,
	sellPrice = 150,
	reqLevel = 0,
}
t[13468] = {
	name = L["Black Lotus"],
	quality = 2,
	icon = "inv_misc_herb_blacklotus",
	buyPrice = 4000,
	sellPrice = 1000,
	reqLevel = 0,
}
t[19302] = {
	name = L["Darkmoon Ring"],
	quality = 3,
	icon = "inv_jewelry_ring_34",
	buyPrice = 50000,
	sellPrice = 12500,
	reqLevel = 50,
}
t[19303] = {
	name = L["Darkmoon Necklace"],
	quality = 2,
	icon = "inv_jewelry_necklace_11",
	buyPrice = 50000,
	sellPrice = 12500,
	reqLevel = 50,
}
t[21887] = {
	name = L["Knothide Leather"],
	quality = 1,
	icon = "inv_misc_leatherscrap_10",
	buyPrice = 5000,
	sellPrice = 1250,
	reqLevel = 0,
}
t[22787] = {
	name = L["Ragveil"],
	quality = 1,
	icon = "inv_misc_herb_ragveil",
	buyPrice = 2400,
	sellPrice = 600,
	reqLevel = 0,
}
t[22789] = {
	name = L["Terocone"],
	quality = 1,
	icon = "inv_misc_herb_terrocone",
	buyPrice = 2000,
	sellPrice = 500,
	reqLevel = 0,
}
t[22790] = {
	name = L["Ancient Lichen"],
	quality = 1,
	icon = "inv_misc_herb_ancientlichen",
	buyPrice = 3000,
	sellPrice = 750,
	reqLevel = 0,
}
t[22792] = {
	name = L["Nightmare Vine"],
	quality = 1,
	icon = "inv_misc_herb_nightmarevine",
	buyPrice = 5000,
	sellPrice = 1250,
	reqLevel = 0,
}
t[22794] = {
	name = L["Fel Lotus"],
	quality = 2,
	icon = "inv_misc_herb_fellotus",
	buyPrice = 30000,
	sellPrice = 7500,
	reqLevel = 0,
}
t[23436] = {
	name = L["Living Ruby"],
	quality = 3,
	icon = "inv_jewelcrafting_livingruby_02",
	buyPrice = 120000,
	sellPrice = 30000,
	reqLevel = 0,
}
t[23437] = {
	name = L["Talasite"],
	quality = 3,
	icon = "inv_jewelcrafting_talasite_02",
	buyPrice = 120000,
	sellPrice = 30000,
	reqLevel = 0,
}
t[23438] = {
	name = L["Star of Elune"],
	quality = 3,
	icon = "inv_jewelcrafting_starofelune_02",
	buyPrice = 120000,
	sellPrice = 30000,
	reqLevel = 0,
}
t[23439] = {
	name = L["Noble Topaz"],
	quality = 3,
	icon = "inv_jewelcrafting_nobletopaz_02",
	buyPrice = 120000,
	sellPrice = 30000,
	reqLevel = 0,
}
t[23440] = {
	name = L["Dawnstone"],
	quality = 3,
	icon = "inv_jewelcrafting_dawnstone_02",
	buyPrice = 120000,
	sellPrice = 30000,
	reqLevel = 0,
}
t[23441] = {
	name = L["Nightseye"],
	quality = 3,
	icon = "inv_jewelcrafting_nightseye_02",
	buyPrice = 120000,
	sellPrice = 30000,
	reqLevel = 0,
}
t[23793] = {
	name = L["Heavy Knothide Leather"],
	quality = 1,
	icon = "inv_misc_leatherscrap_11",
	buyPrice = 25000,
	sellPrice = 6250,
	reqLevel = 0,
}
t[25707] = {
	name = L["Fel Hide"],
	quality = 1,
	icon = "inv_misc_leatherscrap_13",
	buyPrice = 5000,
	sellPrice = 1250,
	reqLevel = 0,
}
t[25708] = {
	name = L["Thick Clefthoof Leather"],
	quality = 1,
	icon = "inv_misc_leatherscrap_14",
	buyPrice = 3000,
	sellPrice = 750,
	reqLevel = 0,
}
t[33568] = {
	name = L["Borean Leather"],
	quality = 1,
	icon = "inv_misc_leatherscrap_15",
	buyPrice = 9000,
	sellPrice = 2250,
	reqLevel = 0,
}
t[36901] = {
	name = L["Goldclover"],
	quality = 1,
	icon = "inv_misc_herb_goldclover",
	buyPrice = 3000,
	sellPrice = 750,
	reqLevel = 0,
}
t[36903] = {
	name = L["Adder's Tongue"],
	quality = 1,
	icon = "inv_misc_herb_evergreenmoss",
	buyPrice = 5000,
	sellPrice = 1250,
	reqLevel = 0,
}
t[36904] = {
	name = L["Tiger Lily"],
	quality = 1,
	icon = "inv_misc_herb_tigerlily",
	buyPrice = 3000,
	sellPrice = 750,
	reqLevel = 0,
}
t[36905] = {
	name = L["Lichbloom"],
	quality = 1,
	icon = "inv_misc_herb_whispervine",
	buyPrice = 8000,
	sellPrice = 2000,
	reqLevel = 0,
}
t[36906] = {
	name = L["Icethorn"],
	quality = 1,
	icon = "inv_misc_herb_icethorn",
	buyPrice = 8000,
	sellPrice = 2000,
	reqLevel = 0,
}
t[36907] = {
	name = L["Talandra's Rose"],
	quality = 1,
	icon = "inv_misc_herb_talandrasrose",
	buyPrice = 3000,
	sellPrice = 750,
	reqLevel = 0,
}
t[36908] = {
	name = L["Frost Lotus"],
	quality = 2,
	icon = "inv_misc_herb_frostlotus",
	buyPrice = 40000,
	sellPrice = 10000,
	reqLevel = 0,
}
t[37700] = {
	name = L["Crystallized Air"],
	quality = 1,
	icon = "inv_elemental_crystal_air",
	buyPrice = 2400,
	sellPrice = 600,
	reqLevel = 0,
}
t[37701] = {
	name = L["Crystallized Earth"],
	quality = 1,
	icon = "inv_elemental_crystal_earth",
	buyPrice = 2400,
	sellPrice = 600,
	reqLevel = 0,
}
t[37702] = {
	name = L["Crystallized Fire"],
	quality = 1,
	icon = "inv_elemental_crystal_fire",
	buyPrice = 2400,
	sellPrice = 600,
	reqLevel = 0,
}
t[37703] = {
	name = L["Crystallized Shadow"],
	quality = 1,
	icon = "inv_elemental_crystal_shadow",
	buyPrice = 2400,
	sellPrice = 600,
	reqLevel = 0,
}
t[37704] = {
	name = L["Crystallized Life"],
	quality = 1,
	icon = "inv_elemental_crystal_life",
	buyPrice = 2400,
	sellPrice = 600,
	reqLevel = 0,
}
t[37705] = {
	name = L["Crystallized Water"],
	quality = 1,
	icon = "inv_elemental_crystal_water",
	buyPrice = 2400,
	sellPrice = 600,
	reqLevel = 0,
}
t[37921] = {
	name = L["Deadnettle"],
	quality = 1,
	icon = "inv_misc_herb_constrictorgrass",
	buyPrice = 3000,
	sellPrice = 750,
	reqLevel = 0,
}
t[38425] = {
	name = L["Heavy Borean Leather"],
	quality = 1,
	icon = "inv_misc_leatherscrap_19",
	buyPrice = 54000,
	sellPrice = 13500,
	reqLevel = 0,
}
t[44128] = {
	name = L["Arctic Fur"],
	quality = 3,
	icon = "inv_misc_pelt_14",
	buyPrice = 120000,
	sellPrice = 30000,
	reqLevel = 0,
}
t[46812] = {
	name = L["Northrend Mystery Gem Pouch"],
	quality = 1,
	icon = "inv_misc_bag_10_blue",
	buyPrice = 500000,
	sellPrice = 125000,
	reqLevel = 0,
}
t[858] = {
	name = L["Lesser Healing Potion"],
	quality = 1,
	icon = "inv_potion_50",
	buyPrice = 100,
	sellPrice = 25,
	reqLevel = 3,
}
t[954] = {
	name = L["Scroll of Strength"],
	quality = 1,
	icon = "inv_scroll_02",
	buyPrice = 200,
	sellPrice = 50,
	reqLevel = 1,
}
t[955] = {
	name = L["Scroll of Intellect"],
	quality = 1,
	icon = "inv_scroll_01",
	buyPrice = 150,
	sellPrice = 37,
	reqLevel = 1,
}
t[1180] = {
	name = L["Scroll of Stamina"],
	quality = 1,
	icon = "inv_scroll_07",
	buyPrice = 150,
	sellPrice = 37,
	reqLevel = 1,
}
t[1181] = {
	name = L["Scroll of Spirit"],
	quality = 1,
	icon = "inv_scroll_01",
	buyPrice = 100,
	sellPrice = 25,
	reqLevel = 1,
}
t[1477] = {
	name = L["Scroll of Agility II"],
	quality = 1,
	icon = "inv_scroll_02",
	buyPrice = 350,
	sellPrice = 87,
	reqLevel = 15,
}
t[1711] = {
	name = L["Scroll of Stamina II"],
	quality = 1,
	icon = "inv_scroll_07",
	buyPrice = 300,
	sellPrice = 75,
	reqLevel = 15,
}
t[2289] = {
	name = L["Scroll of Strength II"],
	quality = 1,
	icon = "inv_scroll_02",
	buyPrice = 350,
	sellPrice = 87,
	reqLevel = 15,
}
t[2290] = {
	name = L["Scroll of Intellect II"],
	quality = 1,
	icon = "inv_scroll_01",
	buyPrice = 300,
	sellPrice = 75,
	reqLevel = 15,
}
t[3012] = {
	name = L["Scroll of Agility"],
	quality = 1,
	icon = "inv_scroll_02",
	buyPrice = 200,
	sellPrice = 50,
	reqLevel = 1,
}
t[3013] = {
	name = L["Scroll of Protection"],
	quality = 1,
	icon = "inv_scroll_07",
	buyPrice = 100,
	sellPrice = 25,
	reqLevel = 1,
}
t[3385] = {
	name = L["Lesser Mana Potion"],
	quality = 1,
	icon = "inv_potion_71",
	buyPrice = 120,
	sellPrice = 30,
	reqLevel = 14,
}
t[4419] = {
	name = L["Scroll of Intellect III"],
	quality = 1,
	icon = "inv_scroll_01",
	buyPrice = 450,
	sellPrice = 112,
	reqLevel = 30,
}
t[4421] = {
	name = L["Scroll of Protection III"],
	quality = 1,
	icon = "inv_scroll_07",
	buyPrice = 400,
	sellPrice = 100,
	reqLevel = 30,
}
t[4422] = {
	name = L["Scroll of Stamina III"],
	quality = 1,
	icon = "inv_scroll_07",
	buyPrice = 450,
	sellPrice = 112,
	reqLevel = 30,
}
t[4424] = {
	name = L["Scroll of Spirit III"],
	quality = 1,
	icon = "inv_scroll_01",
	buyPrice = 400,
	sellPrice = 100,
	reqLevel = 30,
}
t[10305] = {
	name = L["Scroll of Protection IV"],
	quality = 1,
	icon = "inv_scroll_07",
	buyPrice = 550,
	sellPrice = 100,
	reqLevel = 40,
}
t[10309] = {
	name = L["Scroll of Agility IV"],
	quality = 1,
	icon = "inv_scroll_02",
	buyPrice = 650,
	sellPrice = 125,
	reqLevel = 40,
}
t[10310] = {
	name = L["Scroll of Strength IV"],
	quality = 1,
	icon = "inv_scroll_02",
	buyPrice = 650,
	sellPrice = 125,
	reqLevel = 40,
}
t[13443] = {
	name = L["Superior Mana Potion"],
	quality = 1,
	icon = "inv_potion_74",
	buyPrice = 1600,
	sellPrice = 400,
	reqLevel = 41,
}
t[27498] = {
	name = L["Scroll of Agility V"],
	quality = 1,
	icon = "inv_scroll_02",
	buyPrice = 500,
	sellPrice = 125,
	reqLevel = 50,
}
t[27499] = {
	name = L["Scroll of Intellect V"],
	quality = 1,
	icon = "inv_scroll_01",
	buyPrice = 600,
	sellPrice = 112,
	reqLevel = 50,
}
t[27500] = {
	name = L["Scroll of Protection V"],
	quality = 1,
	icon = "inv_scroll_07",
	buyPrice = 550,
	sellPrice = 100,
	reqLevel = 50,
}
t[27501] = {
	name = L["Scroll of Spirit V"],
	quality = 1,
	icon = "inv_scroll_01",
	buyPrice = 550,
	sellPrice = 100,
	reqLevel = 50,
}
t[27502] = {
	name = L["Scroll of Stamina V"],
	quality = 1,
	icon = "inv_scroll_07",
	buyPrice = 600,
	sellPrice = 112,
	reqLevel = 50,
}
t[27503] = {
	name = L["Scroll of Strength V"],
	quality = 1,
	icon = "inv_scroll_02",
	buyPrice = 500,
	sellPrice = 125,
	reqLevel = 50,
}
t[33447] = {
	name = L["Runic Healing Potion"],
	quality = 1,
	icon = "inv_alchemy_elixir_05",
	buyPrice = 24000,
	sellPrice = 6000,
	reqLevel = 70,
}
t[33457] = {
	name = L["Scroll of Agility VI"],
	quality = 1,
	icon = "inv_scroll_02",
	buyPrice = 900,
	sellPrice = 225,
	reqLevel = 60,
}
t[33458] = {
	name = L["Scroll of Intellect VI"],
	quality = 1,
	icon = "inv_scroll_01",
	buyPrice = 1080,
	sellPrice = 270,
	reqLevel = 60,
}
t[33459] = {
	name = L["Scroll of Protection VI"],
	quality = 1,
	icon = "inv_scroll_07",
	buyPrice = 990,
	sellPrice = 247,
	reqLevel = 60,
}
t[33460] = {
	name = L["Scroll of Spirit VI"],
	quality = 1,
	icon = "inv_scroll_01",
	buyPrice = 990,
	sellPrice = 247,
	reqLevel = 60,
}
t[33461] = {
	name = L["Scroll of Stamina VI"],
	quality = 1,
	icon = "inv_scroll_07",
	buyPrice = 1080,
	sellPrice = 270,
	reqLevel = 60,
}
t[33462] = {
	name = L["Scroll of Strength VI"],
	quality = 1,
	icon = "inv_scroll_02",
	buyPrice = 900,
	sellPrice = 225,
	reqLevel = 60,
}
t[37091] = {
	name = L["Scroll of Intellect VII"],
	quality = 1,
	icon = "inv_scroll_01",
	buyPrice = 1080,
	sellPrice = 270,
	reqLevel = 70,
}
t[37093] = {
	name = L["Scroll of Stamina VII"],
	quality = 1,
	icon = "inv_scroll_07",
	buyPrice = 1080,
	sellPrice = 270,
	reqLevel = 70,
}
t[37097] = {
	name = L["Scroll of Spirit VII"],
	quality = 1,
	icon = "inv_scroll_01",
	buyPrice = 990,
	sellPrice = 247,
	reqLevel = 70,
}
t[43463] = {
	name = L["Scroll of Agility VII"],
	quality = 1,
	icon = "inv_scroll_02",
	buyPrice = 900,
	sellPrice = 225,
	reqLevel = 70,
}
t[43465] = {
	name = L["Scroll of Strength VII"],
	quality = 1,
	icon = "inv_scroll_02",
	buyPrice = 900,
	sellPrice = 225,
	reqLevel = 70,
}
t[43467] = {
	name = L["Scroll of Protection VII"],
	quality = 1,
	icon = "inv_scroll_07",
	buyPrice = 990,
	sellPrice = 247,
	reqLevel = 70,
}
t[11026] = {
	name = L["Tree Frog Box"],
	quality = 1,
	icon = "inv_crate_02",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 0,
}
t[11027] = {
	name = L["Wood Frog Box"],
	quality = 1,
	icon = "inv_crate_02",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 0,
}
t[18662] = {
	name = L["Heavy Leather Ball"],
	quality = 1,
	icon = "inv_misc_throwingball_01",
	buyPrice = 20,
	sellPrice = 5,
	reqLevel = 1,
}
t[27690] = {
	name = L["Recipe: Blackened Basilisk"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 30000,
	sellPrice = 7500,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Blackened Basilisk"],
	learnedAt = 315,
}
t[27692] = {
	name = L["Recipe: Warp Burger"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 30000,
	sellPrice = 7500,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Warp Burger"],
	learnedAt = 325,
}
t[27699] = {
	name = L["Recipe: Golden Fish Sticks"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 30000,
	sellPrice = 7500,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Golden Fish Sticks"],
	learnedAt = 325,
}
t[27700] = {
	name = L["Recipe: Spicy Crawdad"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 30000,
	sellPrice = 7500,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Spicy Crawdad"],
	learnedAt = 350,
}
t[22911] = {
	name = L["Recipe: Major Dreamless Sleep Potion"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 50000,
	sellPrice = 12500,
	reqLevel = 0,
	profession = L["Alchemy"],
	teaches = L["Major Dreamless Sleep Potion"],
	learnedAt = 350,
}
t[8957] = {
	name = L["Spinefin Halibut"],
	quality = 1,
	icon = "inv_misc_fish_22",
	buyPrice = 4000,
	sellPrice = 200,
	reqLevel = 45,
}
t[27858] = {
	name = L["Sunspring Carp"],
	quality = 1,
	icon = "inv_misc_food_97_sunspringcarp",
	buyPrice = 5600,
	sellPrice = 280,
	reqLevel = 55,
}
t[29452] = {
	name = L["Zangar Trout"],
	quality = 1,
	icon = "inv_misc_fish_26",
	buyPrice = 8000,
	sellPrice = 400,
	reqLevel = 65,
}
t[28553] = {
	name = L["Band of the Exorcist"],
	quality = 4,
	icon = "inv_jewelry_ring_60",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 67,
}
t[28555] = {
	name = L["Seal of the Exorcist"],
	quality = 4,
	icon = "inv_jewelry_ring_60",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 67,
}
t[28556] = {
	name = L["Swift Windfire Diamond"],
	quality = 3,
	icon = "inv_misc_gem_diamond_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[28557] = {
	name = L["Swift Starfire Diamond"],
	quality = 3,
	icon = "inv_misc_gem_diamond_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[28559] = {
	name = L["Exorcist's Plate Helm"],
	quality = 3,
	icon = "inv_helmet_22",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 66,
}
t[28560] = {
	name = L["Exorcist's Lamellar Helm"],
	quality = 3,
	icon = "inv_helmet_22",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 66,
}
t[28561] = {
	name = L["Exorcist's Leather Helm"],
	quality = 3,
	icon = "inv_helmet_30",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 66,
}
t[28574] = {
	name = L["Exorcist's Dragonhide Helm"],
	quality = 3,
	icon = "inv_helmet_30",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 66,
}
t[28575] = {
	name = L["Exorcist's Wyrmhide Helm"],
	quality = 3,
	icon = "inv_helmet_30",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 66,
}
t[28576] = {
	name = L["Exorcist's Chain Helm"],
	quality = 3,
	icon = "inv_helmet_09",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 66,
}
t[28577] = {
	name = L["Exorcist's Linked Helm"],
	quality = 3,
	icon = "inv_helmet_09",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 66,
}
t[28758] = {
	name = L["Exorcist's Mail Helm"],
	quality = 3,
	icon = "inv_helmet_09",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 66,
}
t[28759] = {
	name = L["Exorcist's Dreadweave Hood"],
	quality = 3,
	icon = "inv_helmet_30",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 66,
}
t[28760] = {
	name = L["Exorcist's Silk Hood"],
	quality = 3,
	icon = "inv_helmet_30",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 66,
}
t[28761] = {
	name = L["Exorcist's Scaled Helm"],
	quality = 3,
	icon = "inv_helmet_22",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 66,
}
t[32947] = {
	name = L["Auchenai Healing Potion"],
	quality = 1,
	icon = "inv_potion_131",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 55,
}
t[32948] = {
	name = L["Auchenai Mana Potion"],
	quality = 1,
	icon = "inv_potion_137",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 55,
}
t[32742] = {
	name = L["Adversarial Bloodlines"],
	quality = 1,
	icon = "inv_misc_book_01",
	buyPrice = 30000,
	sellPrice = 7500,
	reqLevel = 0,
}
t[32445] = {
	name = L["Skyguard Tabard"],
	quality = 1,
	icon = "inv_shirt_guildtabard_01",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 70,
}
t[32314] = {
	name = L["Green Riding Nether Ray"],
	quality = 4,
	icon = "ability_hunter_pet_netherray",
	buyPrice = 2000000,
	sellPrice = 0,
	reqLevel = 70,
}
t[32316] = {
	name = L["Purple Riding Nether Ray"],
	quality = 4,
	icon = "ability_hunter_pet_netherray",
	buyPrice = 2000000,
	sellPrice = 0,
	reqLevel = 70,
}
t[32317] = {
	name = L["Red Riding Nether Ray"],
	quality = 4,
	icon = "ability_hunter_pet_netherray",
	buyPrice = 2000000,
	sellPrice = 0,
	reqLevel = 70,
}
t[32318] = {
	name = L["Silver Riding Nether Ray"],
	quality = 4,
	icon = "ability_hunter_pet_netherray",
	buyPrice = 2000000,
	sellPrice = 0,
	reqLevel = 70,
}
t[32319] = {
	name = L["Blue Riding Nether Ray"],
	quality = 4,
	icon = "ability_hunter_pet_netherray",
	buyPrice = 2000000,
	sellPrice = 0,
	reqLevel = 70,
}
t[32538] = {
	name = L["Skywitch's Drape"],
	quality = 3,
	icon = "inv_misc_cape_05",
	buyPrice = 137691,
	sellPrice = 27538,
	reqLevel = 70,
}
t[32539] = {
	name = L["Skyguard's Drape"],
	quality = 3,
	icon = "inv_misc_cape_08",
	buyPrice = 138166,
	sellPrice = 27633,
	reqLevel = 70,
}
t[32721] = {
	name = L["Skyguard Rations"],
	quality = 1,
	icon = "inv_misc_food_63",
	buyPrice = 4500,
	sellPrice = 225,
	reqLevel = 55,
}
t[32722] = {
	name = L["Enriched Terocone Juice"],
	quality = 1,
	icon = "inv_drink_09",
	buyPrice = 4000,
	sellPrice = 200,
	reqLevel = 65,
}
t[32770] = {
	name = L["Skyguard Silver Cross"],
	quality = 4,
	icon = "inv_jewelry_talisman_06",
	buyPrice = 41230,
	sellPrice = 10307,
	reqLevel = 70,
}
t[32771] = {
	name = L["Airman's Ribbon of Gallantry"],
	quality = 4,
	icon = "inv_misc_ribbon_01",
	buyPrice = 41230,
	sellPrice = 10307,
	reqLevel = 70,
}
t[38628] = {
	name = L["Nether Ray Fry"],
	quality = 3,
	icon = "ability_hunter_pet_netherray",
	buyPrice = 400000,
	sellPrice = 100000,
	reqLevel = 0,
}
t[8948] = {
	name = L["Dried King Bolete"],
	quality = 1,
	icon = "inv_mushroom_05",
	buyPrice = 4000,
	sellPrice = 200,
	reqLevel = 45,
}
t[27859] = {
	name = L["Zangar Caps"],
	quality = 1,
	icon = "inv_mushroom_04",
	buyPrice = 5600,
	sellPrice = 280,
	reqLevel = 55,
}
t[29453] = {
	name = L["Sporeggar Mushroom"],
	quality = 1,
	icon = "inv_misc_food_96_zangarcaps",
	buyPrice = 8000,
	sellPrice = 400,
	reqLevel = 65,
}
t[2522] = {
	name = L["Crescent Axe"],
	quality = 1,
	icon = "inv_throwingaxe_01",
	buyPrice = 22548,
	sellPrice = 4509,
	reqLevel = 30,
}
t[2523] = {
	name = L["Bullova"],
	quality = 1,
	icon = "inv_weapon_halberd_06",
	buyPrice = 28286,
	sellPrice = 5657,
	reqLevel = 30,
}
t[2530] = {
	name = L["Francisca"],
	quality = 1,
	icon = "inv_axe_01",
	buyPrice = 52220,
	sellPrice = 10444,
	reqLevel = 41,
}
t[2531] = {
	name = L["Great Axe"],
	quality = 1,
	icon = "inv_throwingaxe_06",
	buyPrice = 56170,
	sellPrice = 11234,
	reqLevel = 39,
}
t[28239] = {
	name = L["Medallion of the Horde"],
	quality = 3,
	icon = "inv_jewelry_trinketpvp_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28866] = {
	name = L["High Warlord's Silk Amice"],
	quality = 3,
	icon = "inv_shoulder_19",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28867] = {
	name = L["High Warlord's Silk Cowl"],
	quality = 3,
	icon = "inv_helmet_08",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28868] = {
	name = L["High Warlord's Silk Handguards"],
	quality = 3,
	icon = "inv_gauntlets_19",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28869] = {
	name = L["High Warlord's Silk Raiment"],
	quality = 3,
	icon = "inv_chest_leather_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28870] = {
	name = L["High Warlord's Silk Trousers"],
	quality = 3,
	icon = "inv_pants_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31674] = {
	name = L["Recipe: Crunchy Serpent"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 30000,
	sellPrice = 7500,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Crunchy Serpent"],
	learnedAt = 335,
}
t[31675] = {
	name = L["Recipe: Mok'Nathal Shortribs"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 30000,
	sellPrice = 7500,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Mok'Nathal Shortribs"],
	learnedAt = 335,
}
t[28100] = {
	name = L["Volatile Healing Potion"],
	quality = 1,
	icon = "inv_potion_40",
	buyPrice = 4000,
	sellPrice = 1000,
	reqLevel = 55,
}
t[28101] = {
	name = L["Unstable Mana Potion"],
	quality = 1,
	icon = "inv_potion_75",
	buyPrice = 6000,
	sellPrice = 1500,
	reqLevel = 55,
}
t[31337] = {
	name = L["Orb of the Blackwhelp"],
	quality = 1,
	icon = "inv_misc_orb_02",
	buyPrice = 25000,
	sellPrice = 6250,
	reqLevel = 0,
}
t[31341] = {
	name = L["Wyrmcultist's Cloak"],
	quality = 2,
	icon = "inv_misc_cape_20",
	buyPrice = 100261,
	sellPrice = 20052,
	reqLevel = 67,
}
t[32685] = {
	name = L["Ogri'la Chicken Fingers"],
	quality = 1,
	icon = "inv_misc_fish_18",
	buyPrice = 8000,
	sellPrice = 400,
	reqLevel = 65,
}
t[32686] = {
	name = L["Mingo's Fortune Giblets"],
	quality = 1,
	icon = "inv_misc_organ_06",
	buyPrice = 8000,
	sellPrice = 400,
	reqLevel = 65,
}
t[32758] = {
	name = L["Brute Cologne"],
	quality = 1,
	icon = "inv_drink_11",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 0,
}
t[32667] = {
	name = L["Bash Ale"],
	quality = 1,
	icon = "inv_drink_10",
	buyPrice = 340,
	sellPrice = 85,
	reqLevel = 65,
}
t[32668] = {
	name = L["Dos Ogris"],
	quality = 1,
	icon = "inv_drink_05",
	buyPrice = 6400,
	sellPrice = 320,
	reqLevel = 65,
}
t[5740] = {
	name = L["Red Fireworks Rocket"],
	quality = 1,
	icon = "spell_fire_fireball02",
	buyPrice = 100,
	sellPrice = 25,
	reqLevel = 0,
}
t[9314] = {
	name = L["Red Streaks Firework"],
	quality = 1,
	icon = "spell_fire_flare",
	buyPrice = 50,
	sellPrice = 12,
	reqLevel = 0,
}
t[23769] = {
	name = L["Red Smoke Flare"],
	quality = 1,
	icon = "inv_misc_missilesmall_red",
	buyPrice = 1000,
	sellPrice = 250,
	reqLevel = 0,
}
t[32596] = {
	name = L["Unstable Flask of the Elder"],
	quality = 1,
	icon = "inv_potion_77",
	buyPrice = 0,
	sellPrice = 2300,
	reqLevel = 65,
}
t[32597] = {
	name = L["Unstable Flask of the Soldier"],
	quality = 1,
	icon = "inv_potion_84",
	buyPrice = 0,
	sellPrice = 2300,
	reqLevel = 65,
}
t[32599] = {
	name = L["Unstable Flask of the Bandit"],
	quality = 1,
	icon = "inv_potion_91",
	buyPrice = 0,
	sellPrice = 2300,
	reqLevel = 65,
}
t[32600] = {
	name = L["Unstable Flask of the Physician"],
	quality = 1,
	icon = "inv_potion_70",
	buyPrice = 0,
	sellPrice = 2300,
	reqLevel = 65,
}
t[32634] = {
	name = L["Unstable Amethyst"],
	quality = 3,
	icon = "inv_jewelcrafting_shadowsongamethyst_01",
	buyPrice = 0,
	sellPrice = 9200,
	reqLevel = 0,
}
t[32635] = {
	name = L["Unstable Peridot"],
	quality = 3,
	icon = "inv_misc_gem_deepperidot_03",
	buyPrice = 0,
	sellPrice = 9200,
	reqLevel = 0,
}
t[32636] = {
	name = L["Unstable Sapphire"],
	quality = 3,
	icon = "inv_misc_gem_sapphire_02",
	buyPrice = 0,
	sellPrice = 9200,
	reqLevel = 0,
}
t[32637] = {
	name = L["Unstable Citrine"],
	quality = 3,
	icon = "inv_misc_gem_opal_01",
	buyPrice = 0,
	sellPrice = 9200,
	reqLevel = 0,
}
t[32638] = {
	name = L["Unstable Topaz"],
	quality = 3,
	icon = "inv_jewelcrafting_nobletopaz_02",
	buyPrice = 0,
	sellPrice = 9200,
	reqLevel = 0,
}
t[32639] = {
	name = L["Unstable Talasite"],
	quality = 3,
	icon = "inv_jewelcrafting_talasite_01",
	buyPrice = 0,
	sellPrice = 9200,
	reqLevel = 0,
}
t[32624] = {
	name = L["Large Iron Metamorphosis Geode"],
	quality = 1,
	icon = "inv_ore_ethernium_01",
	buyPrice = 0,
	sellPrice = 32200,
	reqLevel = 0,
}
t[32625] = {
	name = L["Small Iron Metamorphosis Geode"],
	quality = 1,
	icon = "inv_ore_khorium",
	buyPrice = 0,
	sellPrice = 24150,
	reqLevel = 0,
}
t[32626] = {
	name = L["Large Copper Metamorphosis Geode"],
	quality = 1,
	icon = "inv_ore_ethernium_01",
	buyPrice = 0,
	sellPrice = 32200,
	reqLevel = 0,
}
t[32627] = {
	name = L["Small Copper Metamorphosis Geode"],
	quality = 1,
	icon = "inv_ore_khorium",
	buyPrice = 0,
	sellPrice = 24150,
	reqLevel = 0,
}
t[32628] = {
	name = L["Large Silver Metamorphosis Geode"],
	quality = 1,
	icon = "inv_ore_ethernium_01",
	buyPrice = 0,
	sellPrice = 32200,
	reqLevel = 0,
}
t[32629] = {
	name = L["Large Gold Metamorphosis Geode"],
	quality = 1,
	icon = "inv_ore_ethernium_01",
	buyPrice = 0,
	sellPrice = 32200,
	reqLevel = 0,
}
t[32630] = {
	name = L["Small Gold Metamorphosis Geode"],
	quality = 1,
	icon = "inv_ore_khorium",
	buyPrice = 0,
	sellPrice = 24150,
	reqLevel = 0,
}
t[32631] = {
	name = L["Small Silver Metamorphosis Geode"],
	quality = 1,
	icon = "inv_ore_khorium",
	buyPrice = 0,
	sellPrice = 24150,
	reqLevel = 0,
}
t[32640] = {
	name = L["Potent Unstable Diamond"],
	quality = 3,
	icon = "inv_misc_gem_diamond_07",
	buyPrice = 0,
	sellPrice = 36800,
	reqLevel = 0,
}
t[32641] = {
	name = L["Imbued Unstable Diamond"],
	quality = 3,
	icon = "inv_misc_gem_diamond_06",
	buyPrice = 0,
	sellPrice = 36800,
	reqLevel = 0,
}
t[32759] = {
	name = L["Accelerator Module"],
	quality = 1,
	icon = "inv_battery_02",
	buyPrice = 0,
	sellPrice = 8050,
	reqLevel = 0,
}
t[32645] = {
	name = L["Crystalline Crossbow"],
	quality = 4,
	icon = "inv_weapon_crossbow_14",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32647] = {
	name = L["Shard-bound Bracers"],
	quality = 4,
	icon = "inv_bracer_13",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32648] = {
	name = L["Vortex Walking Boots"],
	quality = 4,
	icon = "inv_boots_plate_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32650] = {
	name = L["Cerulean Crystal Rod"],
	quality = 3,
	icon = "inv_wand_14",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32651] = {
	name = L["Crystal Orb of Enlightenment"],
	quality = 4,
	icon = "inv_misc_orb_04",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32652] = {
	name = L["Ogri'la Aegis"],
	quality = 3,
	icon = "inv_shield_30",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32653] = {
	name = L["Apexis Cloak"],
	quality = 3,
	icon = "inv_misc_cape_08",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32654] = {
	name = L["Crystalforged Trinket"],
	quality = 3,
	icon = "inv_datacrystal01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32783] = {
	name = L["Blue Ogre Brew"],
	quality = 1,
	icon = "inv_potion_73",
	buyPrice = 0,
	sellPrice = 690,
	reqLevel = 70,
}
t[32784] = {
	name = L["Red Ogre Brew"],
	quality = 1,
	icon = "inv_potion_52",
	buyPrice = 0,
	sellPrice = 460,
	reqLevel = 70,
}
t[32828] = {
	name = L["Ogri'la Tabard"],
	quality = 1,
	icon = "inv_shirt_guildtabard_01",
	buyPrice = 0,
	sellPrice = 2300,
	reqLevel = 0,
}
t[33934] = {
	name = L["Crystal Healing Potion"],
	quality = 1,
	icon = "inv_potion_160",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 55,
}
t[33935] = {
	name = L["Crystal Mana Potion"],
	quality = 1,
	icon = "inv_potion_163",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 55,
}
t[35221] = {
	name = L["Tabard of the Shattered Sun"],
	quality = 1,
	icon = "inv_shirt_guildtabard_01",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 0,
}
t[29193] = {
	name = L["Arcanum of the Gladiator"],
	quality = 2,
	icon = "inv_misc_statue_04",
	buyPrice = 1000000,
	sellPrice = 250000,
	reqLevel = 70,
}
t[34665] = {
	name = L["Bombardier's Blade"],
	quality = 3,
	icon = "inv_weapon_shortblade_14",
	buyPrice = 459015,
	sellPrice = 91803,
	reqLevel = 70,
}
t[34666] = {
	name = L["The Sunbreaker"],
	quality = 3,
	icon = "inv_sword_91",
	buyPrice = 460643,
	sellPrice = 92128,
	reqLevel = 70,
}
t[34667] = {
	name = L["Archmage's Guile"],
	quality = 3,
	icon = "inv_sword_59",
	buyPrice = 418194,
	sellPrice = 83638,
	reqLevel = 70,
}
t[34670] = {
	name = L["Seeker's Gavel"],
	quality = 3,
	icon = "inv_mace_35",
	buyPrice = 434690,
	sellPrice = 86938,
	reqLevel = 70,
}
t[34671] = {
	name = L["K'iru's Presage"],
	quality = 3,
	icon = "inv_mace_34",
	buyPrice = 436317,
	sellPrice = 87263,
	reqLevel = 70,
}
t[34672] = {
	name = L["Inuuro's Blade"],
	quality = 3,
	icon = "inv_sword_draenei_01",
	buyPrice = 437945,
	sellPrice = 87589,
	reqLevel = 0,
}
t[34673] = {
	name = L["Legionfoe"],
	quality = 3,
	icon = "inv_axe_46",
	buyPrice = 549466,
	sellPrice = 109893,
	reqLevel = 70,
}
t[34674] = {
	name = L["Truestrike Crossbow"],
	quality = 3,
	icon = "inv_weapon_crossbow_14",
	buyPrice = 330867,
	sellPrice = 66173,
	reqLevel = 70,
}
t[34675] = {
	name = L["Sunward Crest"],
	quality = 4,
	icon = "inv_shield_48",
	buyPrice = 377842,
	sellPrice = 75568,
	reqLevel = 70,
}
t[34676] = {
	name = L["Dawnforged Defender"],
	quality = 4,
	icon = "inv_shield_05",
	buyPrice = 379231,
	sellPrice = 75846,
	reqLevel = 70,
}
t[34677] = {
	name = L["Shattered Sun Pendant of Restoration"],
	quality = 4,
	icon = "inv_jewelry_necklace_12",
	buyPrice = 232752,
	sellPrice = 58188,
	reqLevel = 70,
}
t[34678] = {
	name = L["Shattered Sun Pendant of Acumen"],
	quality = 4,
	icon = "inv_jewelry_necklace_32",
	buyPrice = 232752,
	sellPrice = 58188,
	reqLevel = 70,
}
t[34679] = {
	name = L["Shattered Sun Pendant of Might"],
	quality = 4,
	icon = "inv_jewelry_necklace_38",
	buyPrice = 232752,
	sellPrice = 58188,
	reqLevel = 70,
}
t[34680] = {
	name = L["Shattered Sun Pendant of Resolve"],
	quality = 4,
	icon = "inv_jewelry_necklace_39",
	buyPrice = 232752,
	sellPrice = 58188,
	reqLevel = 70,
}
t[34780] = {
	name = L["Naaru Ration"],
	quality = 1,
	icon = "inv_misc_food_95_grainbread",
	buyPrice = 5000,
	sellPrice = 250,
	reqLevel = 65,
}
t[34872] = {
	name = L["Formula: Void Shatter"],
	quality = 1,
	icon = "inv_misc_note_01",
	buyPrice = 150000,
	sellPrice = 37500,
	reqLevel = 0,
	profession = L["Enchanting"],
	teaches = L["Void Shatter"],
	learnedAt = 375,
}
t[35500] = {
	name = L["Formula: Enchant Chest - Defense"],
	quality = 1,
	icon = "inv_misc_note_01",
	buyPrice = 150000,
	sellPrice = 37500,
	reqLevel = 0,
	profession = L["Enchanting"],
	teaches = L["Enchant Chest - Defense"],
	learnedAt = 360,
}
t[35502] = {
	name = L["Design: Eternal Earthstorm Diamond"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 150000,
	sellPrice = 37500,
	reqLevel = 0,
}
t[35505] = {
	name = L["Design: Ember Skyfire Diamond"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 150000,
	sellPrice = 37500,
	reqLevel = 0,
}
t[35695] = {
	name = L["Design: Figurine - Empyrean Tortoise"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 250000,
	sellPrice = 62500,
	reqLevel = 0,
}
t[35696] = {
	name = L["Design: Figurine - Khorium Boar"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 250000,
	sellPrice = 62500,
	reqLevel = 0,
}
t[35697] = {
	name = L["Design: Figurine - Crimson Serpent"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 250000,
	sellPrice = 62500,
	reqLevel = 0,
}
t[35698] = {
	name = L["Design: Figurine - Shadowsong Panther"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 250000,
	sellPrice = 62500,
	reqLevel = 0,
}
t[35699] = {
	name = L["Design: Figurine - Seaspray Albatross"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 250000,
	sellPrice = 62500,
	reqLevel = 0,
}
t[35708] = {
	name = L["Design: Regal Nightseye"],
	quality = 1,
	icon = "inv_scroll_05",
	buyPrice = 120000,
	sellPrice = 30000,
	reqLevel = 0,
}
t[35752] = {
	name = L["Recipe: Guardian's Alchemist Stone"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 250000,
	sellPrice = 62500,
	reqLevel = 0,
	profession = L["Alchemy"],
	teaches = L["Guardian's Alchemist Stone"],
	learnedAt = 375,
}
t[35753] = {
	name = L["Recipe: Sorcerer's Alchemist Stone"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 250000,
	sellPrice = 62500,
	reqLevel = 0,
	profession = L["Alchemy"],
	teaches = L["Sorcerer's Alchemist Stone"],
	learnedAt = 375,
}
t[35754] = {
	name = L["Recipe: Redeemer's Alchemist Stone"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 250000,
	sellPrice = 62500,
	reqLevel = 0,
	profession = L["Alchemy"],
	teaches = L["Redeemer's Alchemist Stone"],
	learnedAt = 375,
}
t[35755] = {
	name = L["Recipe: Assassin's Alchemist Stone"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 250000,
	sellPrice = 62500,
	reqLevel = 0,
	profession = L["Alchemy"],
	teaches = L["Assassin's Alchemist Stone"],
	learnedAt = 375,
}
t[35766] = {
	name = L["Design: Steady Seaspray Emerald"],
	quality = 4,
	icon = "inv_scroll_04",
	buyPrice = 500000,
	sellPrice = 125000,
	reqLevel = 0,
}
t[35767] = {
	name = L["Design: Reckless Pyrestone"],
	quality = 4,
	icon = "inv_scroll_04",
	buyPrice = 500000,
	sellPrice = 125000,
	reqLevel = 0,
}
t[35768] = {
	name = L["Design: Quick Lionseye"],
	quality = 4,
	icon = "inv_scroll_04",
	buyPrice = 500000,
	sellPrice = 125000,
	reqLevel = 0,
}
t[35769] = {
	name = L["Design: Forceful Seaspray Emerald"],
	quality = 4,
	icon = "inv_scroll_04",
	buyPrice = 500000,
	sellPrice = 125000,
	reqLevel = 0,
}
t[34887] = {
	name = L["Angelista's Revenge"],
	quality = 4,
	icon = "inv_jewelry_ring_79",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34888] = {
	name = L["Ring of the Stalwart Protector"],
	quality = 4,
	icon = "inv_jewelry_ring_67",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34889] = {
	name = L["Fused Nethergon Band"],
	quality = 4,
	icon = "inv_jewelry_ring_68",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34890] = {
	name = L["Anveena's Touch"],
	quality = 4,
	icon = "inv_jewelry_ring_54",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34891] = {
	name = L["The Blade of Harbingers"],
	quality = 4,
	icon = "inv_axe_04",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34892] = {
	name = L["Crossbow of Relentless Strikes"],
	quality = 4,
	icon = "inv_weapon_crossbow_26",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34893] = {
	name = L["Vanir's Right Fist of Brutality"],
	quality = 4,
	icon = "inv_weapon_hand_16",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34894] = {
	name = L["Blade of Serration"],
	quality = 4,
	icon = "inv_weapon_shortblade_78",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34895] = {
	name = L["Scryer's Blade of Focus"],
	quality = 4,
	icon = "inv_weapon_shortblade_78",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34896] = {
	name = L["Gavel of Naaru Blessings"],
	quality = 4,
	icon = "inv_mace_82",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34898] = {
	name = L["Staff of the Forest Lord"],
	quality = 4,
	icon = "inv_staff_12",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34900] = {
	name = L["Shroud of Nature's Harmony"],
	quality = 4,
	icon = "inv_chest_cloth_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34901] = {
	name = L["Grovewalker's Leggings"],
	quality = 4,
	icon = "inv_pants_leather_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34902] = {
	name = L["Oakleaf-Spun Handguards"],
	quality = 4,
	icon = "inv_gauntlets_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34903] = {
	name = L["Embrace of Starlight"],
	quality = 4,
	icon = "inv_chest_cloth_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34904] = {
	name = L["Barbed Gloves of the Sage"],
	quality = 4,
	icon = "inv_gauntlets_50",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34905] = {
	name = L["Crystalwind Leggings"],
	quality = 4,
	icon = "inv_pants_leather_16",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34906] = {
	name = L["Embrace of Everlasting Prowess"],
	quality = 4,
	icon = "inv_chest_cloth_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34910] = {
	name = L["Tameless Breeches"],
	quality = 4,
	icon = "inv_pants_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34911] = {
	name = L["Handwraps of the Aggressor"],
	quality = 4,
	icon = "inv_gauntlets_08",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34912] = {
	name = L["Scaled Drakeskin Chestguard"],
	quality = 4,
	icon = "inv_chest_chain_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34914] = {
	name = L["Leggings of the Pursuit"],
	quality = 4,
	icon = "inv_pants_mail_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34916] = {
	name = L["Gauntlets of Rapidity"],
	quality = 4,
	icon = "inv_gauntlets_25",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34917] = {
	name = L["Shroud of the Lore`nial"],
	quality = 4,
	icon = "inv_chest_cloth_51",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34918] = {
	name = L["Legwraps of Sweltering Flame"],
	quality = 4,
	icon = "inv_pants_cloth_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34919] = {
	name = L["Boots of Incantations"],
	quality = 4,
	icon = "inv_boots_cloth_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34921] = {
	name = L["Ecclesiastical Cuirass"],
	quality = 4,
	icon = "inv_chest_plate03",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34922] = {
	name = L["Greaves of Pacification"],
	quality = 4,
	icon = "inv_pants_plate_19",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34923] = {
	name = L["Waistguard of Reparation"],
	quality = 4,
	icon = "inv_belt_28",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34924] = {
	name = L["Gown of Spiritual Wonder"],
	quality = 4,
	icon = "inv_chest_cloth_10",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34925] = {
	name = L["Adorned Supernal Legwraps"],
	quality = 4,
	icon = "inv_pants_cloth_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34926] = {
	name = L["Slippers of Dutiful Mending"],
	quality = 4,
	icon = "inv_boots_cloth_03",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34927] = {
	name = L["Tunic of the Dark Hour"],
	quality = 4,
	icon = "inv_chest_plate02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34928] = {
	name = L["Trousers of the Scryers' Retainer"],
	quality = 4,
	icon = "inv_pants_leather_03",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34929] = {
	name = L["Belt of the Silent Path"],
	quality = 4,
	icon = "inv_belt_03",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34930] = {
	name = L["Wave of Life Chestguard"],
	quality = 4,
	icon = "inv_chest_chain_11",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34931] = {
	name = L["Runed Scales of Antiquity"],
	quality = 4,
	icon = "inv_pants_mail_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34932] = {
	name = L["Clutch of the Soothing Breeze"],
	quality = 4,
	icon = "inv_belt_22",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34933] = {
	name = L["Hauberk of Whirling Fury"],
	quality = 4,
	icon = "inv_chest_chain_11",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34934] = {
	name = L["Rushing Storm Kilt"],
	quality = 4,
	icon = "inv_pants_mail_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34935] = {
	name = L["Aftershock Waistguard"],
	quality = 4,
	icon = "inv_belt_13",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34936] = {
	name = L["Tormented Demonsoul Robes"],
	quality = 4,
	icon = "inv_chest_cloth_43",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34937] = {
	name = L["Corrupted Soulcloth Pantaloons"],
	quality = 4,
	icon = "inv_pants_cloth_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34938] = {
	name = L["Enslaved Doomguard Soulgrips"],
	quality = 4,
	icon = "inv_gauntlets_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34939] = {
	name = L["Chestplate of Stoicism"],
	quality = 4,
	icon = "inv_chest_plate13",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34940] = {
	name = L["Sunguard Legplates"],
	quality = 4,
	icon = "inv_pants_plate_21",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34941] = {
	name = L["Girdle of the Fearless"],
	quality = 4,
	icon = "inv_belt_27",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34942] = {
	name = L["Breastplate of Ire"],
	quality = 4,
	icon = "inv_chest_plate06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34943] = {
	name = L["Legplates of Unending Fury"],
	quality = 4,
	icon = "inv_pants_plate_21",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34944] = {
	name = L["Girdle of Seething Rage"],
	quality = 4,
	icon = "inv_belt_13",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34945] = {
	name = L["Shattrath Protectorate's Breastplate"],
	quality = 4,
	icon = "inv_chest_plate16",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34946] = {
	name = L["Inscribed Legplates of the Aldor"],
	quality = 4,
	icon = "inv_pants_plate_19",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34947] = {
	name = L["Blue's Greaves of the Righteous Guardian"],
	quality = 4,
	icon = "inv_boots_plate_04",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34949] = {
	name = L["Swift Blade of Uncertainty"],
	quality = 4,
	icon = "inv_weapon_shortblade_78",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34950] = {
	name = L["Vanir's Left Fist of Savagery"],
	quality = 4,
	icon = "inv_weapon_hand_16",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34951] = {
	name = L["Vanir's Left Fist of Brutality"],
	quality = 4,
	icon = "inv_weapon_hand_16",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34952] = {
	name = L["The Mutilator"],
	quality = 4,
	icon = "inv_weapon_shortblade_78",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32227] = {
	name = L["Crimson Spinel"],
	quality = 4,
	icon = "inv_jewelcrafting_crimsonspinel_01",
	buyPrice = 0,
	sellPrice = 50000,
	reqLevel = 0,
}
t[32228] = {
	name = L["Empyrean Sapphire"],
	quality = 4,
	icon = "inv_jewelcrafting_empyreansapphire_01",
	buyPrice = 0,
	sellPrice = 50000,
	reqLevel = 0,
}
t[32229] = {
	name = L["Lionseye"],
	quality = 4,
	icon = "inv_jewelcrafting_lionseye_01",
	buyPrice = 0,
	sellPrice = 50000,
	reqLevel = 0,
}
t[32230] = {
	name = L["Shadowsong Amethyst"],
	quality = 4,
	icon = "inv_jewelcrafting_shadowsongamethyst_01",
	buyPrice = 0,
	sellPrice = 50000,
	reqLevel = 0,
}
t[32231] = {
	name = L["Pyrestone"],
	quality = 4,
	icon = "inv_jewelcrafting_pyrestone_01",
	buyPrice = 0,
	sellPrice = 50000,
	reqLevel = 0,
}
t[32249] = {
	name = L["Seaspray Emerald"],
	quality = 4,
	icon = "inv_jewelcrafting_seasprayemerald_01",
	buyPrice = 0,
	sellPrice = 50000,
	reqLevel = 0,
}
t[35238] = {
	name = L["Design: Balanced Shadowsong Amethyst"],
	quality = 1,
	icon = "inv_scroll_04",
	buyPrice = 500000,
	sellPrice = 125000,
	reqLevel = 0,
}
t[35239] = {
	name = L["Design: Glowing Shadowsong Amethyst"],
	quality = 1,
	icon = "inv_scroll_04",
	buyPrice = 500000,
	sellPrice = 125000,
	reqLevel = 0,
}
t[35240] = {
	name = L["Design: Infused Shadowsong Amethyst"],
	quality = 1,
	icon = "inv_scroll_04",
	buyPrice = 500000,
	sellPrice = 125000,
	reqLevel = 0,
}
t[35241] = {
	name = L["Design: Royal Shadowsong Amethyst"],
	quality = 1,
	icon = "inv_scroll_04",
	buyPrice = 500000,
	sellPrice = 125000,
	reqLevel = 0,
}
t[35242] = {
	name = L["Design: Shifting Shadowsong Amethyst"],
	quality = 1,
	icon = "inv_scroll_04",
	buyPrice = 500000,
	sellPrice = 125000,
	reqLevel = 0,
}
t[35243] = {
	name = L["Design: Sovereign Shadowsong Amethyst"],
	quality = 1,
	icon = "inv_scroll_04",
	buyPrice = 500000,
	sellPrice = 125000,
	reqLevel = 0,
}
t[35244] = {
	name = L["Design: Bold Crimson Spinel"],
	quality = 1,
	icon = "inv_scroll_04",
	buyPrice = 500000,
	sellPrice = 125000,
	reqLevel = 0,
}
t[35245] = {
	name = L["Design: Bright Crimson Spinel"],
	quality = 1,
	icon = "inv_scroll_04",
	buyPrice = 500000,
	sellPrice = 125000,
	reqLevel = 0,
}
t[35246] = {
	name = L["Design: Delicate Crimson Spinel"],
	quality = 1,
	icon = "inv_scroll_04",
	buyPrice = 500000,
	sellPrice = 125000,
	reqLevel = 0,
}
t[35247] = {
	name = L["Design: Flashing Crimson Spinel"],
	quality = 1,
	icon = "inv_scroll_04",
	buyPrice = 500000,
	sellPrice = 125000,
	reqLevel = 0,
}
t[35248] = {
	name = L["Design: Runed Crimson Spinel"],
	quality = 1,
	icon = "inv_scroll_04",
	buyPrice = 500000,
	sellPrice = 125000,
	reqLevel = 0,
}
t[35249] = {
	name = L["Design: Subtle Crimson Spinel"],
	quality = 1,
	icon = "inv_scroll_04",
	buyPrice = 500000,
	sellPrice = 125000,
	reqLevel = 0,
}
t[35250] = {
	name = L["Design: Teardrop Crimson Spinel"],
	quality = 1,
	icon = "inv_scroll_04",
	buyPrice = 500000,
	sellPrice = 125000,
	reqLevel = 0,
}
t[35251] = {
	name = L["Design: Dazzling Seaspray Emerald"],
	quality = 1,
	icon = "inv_scroll_04",
	buyPrice = 500000,
	sellPrice = 125000,
	reqLevel = 0,
}
t[35252] = {
	name = L["Design: Enduring Seaspray Emerald"],
	quality = 1,
	icon = "inv_scroll_04",
	buyPrice = 500000,
	sellPrice = 125000,
	reqLevel = 0,
}
t[35253] = {
	name = L["Design: Jagged Seaspray Emerald"],
	quality = 1,
	icon = "inv_scroll_04",
	buyPrice = 500000,
	sellPrice = 125000,
	reqLevel = 0,
}
t[35254] = {
	name = L["Design: Radiant Seaspray Emerald"],
	quality = 1,
	icon = "inv_scroll_04",
	buyPrice = 500000,
	sellPrice = 125000,
	reqLevel = 0,
}
t[35255] = {
	name = L["Design: Brilliant Lionseye"],
	quality = 1,
	icon = "inv_scroll_04",
	buyPrice = 500000,
	sellPrice = 125000,
	reqLevel = 0,
}
t[35256] = {
	name = L["Design: Gleaming Lionseye"],
	quality = 1,
	icon = "inv_scroll_04",
	buyPrice = 500000,
	sellPrice = 125000,
	reqLevel = 0,
}
t[35257] = {
	name = L["Design: Great Lionseye"],
	quality = 1,
	icon = "inv_scroll_04",
	buyPrice = 500000,
	sellPrice = 125000,
	reqLevel = 0,
}
t[35258] = {
	name = L["Design: Mystic Lionseye"],
	quality = 1,
	icon = "inv_scroll_04",
	buyPrice = 500000,
	sellPrice = 125000,
	reqLevel = 0,
}
t[35259] = {
	name = L["Design: Rigid Lionseye"],
	quality = 1,
	icon = "inv_scroll_04",
	buyPrice = 500000,
	sellPrice = 125000,
	reqLevel = 0,
}
t[35260] = {
	name = L["Design: Smooth Lionseye"],
	quality = 1,
	icon = "inv_scroll_04",
	buyPrice = 500000,
	sellPrice = 125000,
	reqLevel = 0,
}
t[35261] = {
	name = L["Design: Thick Lionseye"],
	quality = 1,
	icon = "inv_scroll_04",
	buyPrice = 500000,
	sellPrice = 125000,
	reqLevel = 0,
}
t[35262] = {
	name = L["Design: Lustrous Empyrean Sapphire"],
	quality = 1,
	icon = "inv_scroll_04",
	buyPrice = 500000,
	sellPrice = 125000,
	reqLevel = 0,
}
t[35263] = {
	name = L["Design: Solid Empyrean Sapphire"],
	quality = 1,
	icon = "inv_scroll_04",
	buyPrice = 500000,
	sellPrice = 125000,
	reqLevel = 0,
}
t[35264] = {
	name = L["Design: Sparkling Empyrean Sapphire"],
	quality = 1,
	icon = "inv_scroll_04",
	buyPrice = 500000,
	sellPrice = 125000,
	reqLevel = 0,
}
t[35265] = {
	name = L["Design: Stormy Empyrean Sapphire"],
	quality = 1,
	icon = "inv_scroll_04",
	buyPrice = 500000,
	sellPrice = 125000,
	reqLevel = 0,
}
t[35266] = {
	name = L["Design: Glinting Pyrestone"],
	quality = 1,
	icon = "inv_scroll_04",
	buyPrice = 500000,
	sellPrice = 125000,
	reqLevel = 0,
}
t[35267] = {
	name = L["Design: Inscribed Pyrestone"],
	quality = 1,
	icon = "inv_scroll_04",
	buyPrice = 500000,
	sellPrice = 125000,
	reqLevel = 0,
}
t[35268] = {
	name = L["Design: Luminous Pyrestone"],
	quality = 1,
	icon = "inv_scroll_04",
	buyPrice = 500000,
	sellPrice = 125000,
	reqLevel = 0,
}
t[35269] = {
	name = L["Design: Potent Pyrestone"],
	quality = 1,
	icon = "inv_scroll_04",
	buyPrice = 500000,
	sellPrice = 125000,
	reqLevel = 0,
}
t[35270] = {
	name = L["Design: Veiled Pyrestone"],
	quality = 1,
	icon = "inv_scroll_04",
	buyPrice = 500000,
	sellPrice = 125000,
	reqLevel = 0,
}
t[35271] = {
	name = L["Design: Wicked Pyrestone"],
	quality = 1,
	icon = "inv_scroll_04",
	buyPrice = 500000,
	sellPrice = 125000,
	reqLevel = 0,
}
t[35322] = {
	name = L["Design: Quick Dawnstone"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 120000,
	sellPrice = 30000,
	reqLevel = 0,
}
t[35323] = {
	name = L["Design: Reckless Noble Topaz"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 120000,
	sellPrice = 30000,
	reqLevel = 0,
}
t[35325] = {
	name = L["Design: Forceful Talasite"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 120000,
	sellPrice = 30000,
	reqLevel = 0,
}
t[37504] = {
	name = L["Design: Purified Shadowsong Amethyst"],
	quality = 1,
	icon = "inv_scroll_04",
	buyPrice = 500000,
	sellPrice = 125000,
	reqLevel = 0,
}
t[34431] = {
	name = L["Lightbringer Bands"],
	quality = 4,
	icon = "inv_bracer_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34432] = {
	name = L["Lightbringer Bracers"],
	quality = 4,
	icon = "inv_bracer_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34433] = {
	name = L["Lightbringer Wristguards"],
	quality = 4,
	icon = "inv_bracer_14",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34434] = {
	name = L["Bracers of Absolution"],
	quality = 4,
	icon = "inv_bracer_10",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34435] = {
	name = L["Cuffs of Absolution"],
	quality = 4,
	icon = "inv_bracer_10",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34436] = {
	name = L["Bracers of the Malefic"],
	quality = 4,
	icon = "inv_bracer_12",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34437] = {
	name = L["Skyshatter Bands"],
	quality = 4,
	icon = "inv_bracer_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34438] = {
	name = L["Skyshatter Bracers"],
	quality = 4,
	icon = "inv_bracer_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34439] = {
	name = L["Skyshatter Wristguards"],
	quality = 4,
	icon = "inv_bracer_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34441] = {
	name = L["Onslaught Bracers"],
	quality = 4,
	icon = "inv_bracer_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34442] = {
	name = L["Onslaught Wristguards"],
	quality = 4,
	icon = "inv_bracer_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34443] = {
	name = L["Gronnstalker's Bracers"],
	quality = 4,
	icon = "inv_bracer_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34444] = {
	name = L["Thunderheart Wristguards"],
	quality = 4,
	icon = "inv_bracer_09",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34445] = {
	name = L["Thunderheart Bracers"],
	quality = 4,
	icon = "inv_bracer_08",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34446] = {
	name = L["Thunderheart Bands"],
	quality = 4,
	icon = "inv_bracer_08",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34447] = {
	name = L["Bracers of the Tempest"],
	quality = 4,
	icon = "inv_bracer_12",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34448] = {
	name = L["Slayer's Bracers"],
	quality = 4,
	icon = "inv_bracer_09",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34485] = {
	name = L["Lightbringer Girdle"],
	quality = 4,
	icon = "inv_belt_27",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34487] = {
	name = L["Lightbringer Belt"],
	quality = 4,
	icon = "inv_belt_27",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34488] = {
	name = L["Lightbringer Waistguard"],
	quality = 4,
	icon = "inv_belt_27",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34527] = {
	name = L["Belt of Absolution"],
	quality = 4,
	icon = "inv_belt_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34528] = {
	name = L["Cord of Absolution"],
	quality = 4,
	icon = "inv_belt_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34541] = {
	name = L["Belt of the Malefic"],
	quality = 4,
	icon = "inv_belt_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34542] = {
	name = L["Skyshatter Cord"],
	quality = 4,
	icon = "inv_belt_13",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34543] = {
	name = L["Skyshatter Belt"],
	quality = 4,
	icon = "inv_belt_13",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34545] = {
	name = L["Skyshatter Girdle"],
	quality = 4,
	icon = "inv_belt_13",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34546] = {
	name = L["Onslaught Belt"],
	quality = 4,
	icon = "inv_belt_27",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34547] = {
	name = L["Onslaught Waistguard"],
	quality = 4,
	icon = "inv_belt_33",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34549] = {
	name = L["Gronnstalker's Belt"],
	quality = 4,
	icon = "inv_belt_14",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34554] = {
	name = L["Thunderheart Belt"],
	quality = 4,
	icon = "inv_belt_24",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34555] = {
	name = L["Thunderheart Cord"],
	quality = 4,
	icon = "inv_belt_24",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34556] = {
	name = L["Thunderheart Waistguard"],
	quality = 4,
	icon = "inv_belt_24",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34557] = {
	name = L["Belt of the Tempest"],
	quality = 4,
	icon = "inv_belt_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34558] = {
	name = L["Slayer's Belt"],
	quality = 4,
	icon = "inv_belt_26",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34559] = {
	name = L["Lightbringer Treads"],
	quality = 4,
	icon = "inv_boots_chain_08",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34560] = {
	name = L["Lightbringer Stompers"],
	quality = 4,
	icon = "inv_boots_chain_08",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34561] = {
	name = L["Lightbringer Boots"],
	quality = 4,
	icon = "inv_boots_chain_08",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34562] = {
	name = L["Boots of Absolution"],
	quality = 4,
	icon = "inv_boots_cloth_08",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34563] = {
	name = L["Treads of Absolution"],
	quality = 4,
	icon = "inv_boots_cloth_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34564] = {
	name = L["Boots of the Malefic"],
	quality = 4,
	icon = "inv_boots_cloth_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34565] = {
	name = L["Skyshatter Boots"],
	quality = 4,
	icon = "inv_boots_chain_08",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34566] = {
	name = L["Skyshatter Treads"],
	quality = 4,
	icon = "inv_boots_chain_08",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34567] = {
	name = L["Skyshatter Greaves"],
	quality = 4,
	icon = "inv_boots_chain_08",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34568] = {
	name = L["Onslaught Boots"],
	quality = 4,
	icon = "inv_boots_plate_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34569] = {
	name = L["Onslaught Treads"],
	quality = 4,
	icon = "inv_boots_plate_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34570] = {
	name = L["Gronnstalker's Boots"],
	quality = 4,
	icon = "inv_boots_chain_08",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34571] = {
	name = L["Thunderheart Boots"],
	quality = 4,
	icon = "inv_boots_08",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34572] = {
	name = L["Thunderheart Footwraps"],
	quality = 4,
	icon = "inv_boots_08",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34573] = {
	name = L["Thunderheart Treads"],
	quality = 4,
	icon = "inv_boots_wolf",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34574] = {
	name = L["Boots of the Tempest"],
	quality = 4,
	icon = "inv_boots_cloth_16",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34575] = {
	name = L["Slayer's Boots"],
	quality = 4,
	icon = "inv_boots_cloth_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34381] = {
	name = L["Felstrength Legplates"],
	quality = 4,
	icon = "inv_pants_plate_21",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34382] = {
	name = L["Judicator's Legguards"],
	quality = 4,
	icon = "inv_pants_plate_19",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34383] = {
	name = L["Kilt of Spiritual Reconstruction"],
	quality = 4,
	icon = "inv_pants_mail_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34384] = {
	name = L["Breeches of Natural Splendor"],
	quality = 4,
	icon = "inv_pants_leather_23",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34385] = {
	name = L["Leggings of the Immortal Beast"],
	quality = 4,
	icon = "inv_pants_leather_23",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34386] = {
	name = L["Pantaloons of Growing Strife"],
	quality = 4,
	icon = "inv_pants_cloth_14",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34388] = {
	name = L["Pauldrons of Berserking"],
	quality = 4,
	icon = "inv_shoulder_89",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34389] = {
	name = L["Spaulders of the Thalassian Defender"],
	quality = 4,
	icon = "inv_shoulder_89",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34390] = {
	name = L["Erupting Epaulets"],
	quality = 4,
	icon = "inv_shoulder_90",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34391] = {
	name = L["Spaulders of Devastation"],
	quality = 4,
	icon = "inv_shoulder_88",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34392] = {
	name = L["Demontooth Shoulderpads"],
	quality = 4,
	icon = "inv_shoulder_88",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34393] = {
	name = L["Shoulderpads of Knowledge's Pursuit"],
	quality = 4,
	icon = "inv_shoulder_96",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34394] = {
	name = L["Breastplate of Agony's Aversion"],
	quality = 4,
	icon = "inv_chest_plate20",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34395] = {
	name = L["Noble Judicator's Chestguard"],
	quality = 4,
	icon = "inv_chest_plate18",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34396] = {
	name = L["Garments of Crashing Shores"],
	quality = 4,
	icon = "inv_chest_chain_11",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34397] = {
	name = L["Bladed Chaos Tunic"],
	quality = 4,
	icon = "inv_chest_leather_16",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34398] = {
	name = L["Utopian Tunic of Elune"],
	quality = 4,
	icon = "inv_chest_leather_14",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34399] = {
	name = L["Robes of Ghostly Hatred"],
	quality = 4,
	icon = "inv_chest_cloth_25",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34400] = {
	name = L["Crown of Dath'Remar"],
	quality = 4,
	icon = "inv_helmet_08",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34401] = {
	name = L["Helm of Uther's Resolve"],
	quality = 4,
	icon = "inv_helmet_25",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34402] = {
	name = L["Shroud of Chieftain Ner'zhul"],
	quality = 4,
	icon = "inv_helmet128",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34403] = {
	name = L["Cover of Ursoc the Mighty"],
	quality = 4,
	icon = "inv_helmet_126",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34404] = {
	name = L["Mask of the Fury Hunter"],
	quality = 4,
	icon = "inv_helmet_126",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34405] = {
	name = L["Helm of Arcane Purity"],
	quality = 4,
	icon = "inv_helmet_132",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34406] = {
	name = L["Gloves of Tyri's Power"],
	quality = 4,
	icon = "inv_gauntlets_16",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34407] = {
	name = L["Tranquil Moonlight Wraps"],
	quality = 4,
	icon = "inv_gauntlets_51",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34408] = {
	name = L["Gloves of the Forest Drifter"],
	quality = 4,
	icon = "inv_gauntlets_51",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34409] = {
	name = L["Gauntlets of the Ancient Frostwolf"],
	quality = 4,
	icon = "inv_gauntlets_52",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[414] = {
	name = L["Dalaran Sharp"],
	quality = 1,
	icon = "inv_misc_food_39",
	buyPrice = 125,
	sellPrice = 6,
	reqLevel = 5,
}
t[422] = {
	name = L["Dwarven Mild"],
	quality = 1,
	icon = "inv_misc_food_07",
	buyPrice = 500,
	sellPrice = 25,
	reqLevel = 15,
}
t[1707] = {
	name = L["Stormwind Brie"],
	quality = 1,
	icon = "inv_misc_food_38",
	buyPrice = 1000,
	sellPrice = 62,
	reqLevel = 25,
}
t[2070] = {
	name = L["Darnassian Bleu"],
	quality = 1,
	icon = "inv_misc_food_06",
	buyPrice = 25,
	sellPrice = 1,
	reqLevel = 1,
}
t[3927] = {
	name = L["Fine Aged Cheddar"],
	quality = 1,
	icon = "inv_misc_food_03",
	buyPrice = 2000,
	sellPrice = 150,
	reqLevel = 35,
}
t[2129] = {
	name = L["Large Round Shield"],
	quality = 1,
	icon = "inv_shield_09",
	buyPrice = 77,
	sellPrice = 15,
	reqLevel = 1,
}
t[2379] = {
	name = L["Tarnished Chain Vest"],
	quality = 1,
	icon = "inv_chest_chain",
	buyPrice = 76,
	sellPrice = 15,
	reqLevel = 1,
}
t[2380] = {
	name = L["Tarnished Chain Belt"],
	quality = 1,
	icon = "inv_belt_06",
	buyPrice = 38,
	sellPrice = 7,
	reqLevel = 1,
}
t[2381] = {
	name = L["Tarnished Chain Leggings"],
	quality = 1,
	icon = "inv_pants_03",
	buyPrice = 76,
	sellPrice = 15,
	reqLevel = 1,
}
t[2383] = {
	name = L["Tarnished Chain Boots"],
	quality = 1,
	icon = "inv_boots_01",
	buyPrice = 58,
	sellPrice = 11,
	reqLevel = 1,
}
t[2384] = {
	name = L["Tarnished Chain Bracers"],
	quality = 1,
	icon = "inv_bracer_03",
	buyPrice = 38,
	sellPrice = 7,
	reqLevel = 1,
}
t[2385] = {
	name = L["Tarnished Chain Gloves"],
	quality = 1,
	icon = "inv_gauntlets_04",
	buyPrice = 38,
	sellPrice = 7,
	reqLevel = 1,
}
t[17184] = {
	name = L["Small Shield"],
	quality = 1,
	icon = "inv_shield_09",
	buyPrice = 36,
	sellPrice = 7,
	reqLevel = 1,
}
t[2117] = {
	name = L["Thin Cloth Shoes"],
	quality = 1,
	icon = "inv_boots_09",
	buyPrice = 37,
	sellPrice = 7,
	reqLevel = 1,
}
t[2119] = {
	name = L["Thin Cloth Gloves"],
	quality = 1,
	icon = "inv_gauntlets_18",
	buyPrice = 25,
	sellPrice = 5,
	reqLevel = 1,
}
t[2120] = {
	name = L["Thin Cloth Pants"],
	quality = 1,
	icon = "inv_pants_02",
	buyPrice = 50,
	sellPrice = 10,
	reqLevel = 1,
}
t[2121] = {
	name = L["Thin Cloth Armor"],
	quality = 1,
	icon = "inv_shirt_red_01",
	buyPrice = 50,
	sellPrice = 10,
	reqLevel = 1,
}
t[2122] = {
	name = L["Cracked Leather Belt"],
	quality = 1,
	icon = "inv_belt_26",
	buyPrice = 32,
	sellPrice = 6,
	reqLevel = 1,
}
t[2123] = {
	name = L["Cracked Leather Boots"],
	quality = 1,
	icon = "inv_boots_06",
	buyPrice = 49,
	sellPrice = 9,
	reqLevel = 1,
}
t[2124] = {
	name = L["Cracked Leather Bracers"],
	quality = 1,
	icon = "inv_bracer_12",
	buyPrice = 33,
	sellPrice = 6,
	reqLevel = 1,
}
t[2125] = {
	name = L["Cracked Leather Gloves"],
	quality = 1,
	icon = "inv_gauntlets_18",
	buyPrice = 33,
	sellPrice = 6,
	reqLevel = 1,
}
t[2126] = {
	name = L["Cracked Leather Pants"],
	quality = 1,
	icon = "inv_pants_10",
	buyPrice = 60,
	sellPrice = 12,
	reqLevel = 1,
}
t[2127] = {
	name = L["Cracked Leather Vest"],
	quality = 1,
	icon = "inv_shirt_06",
	buyPrice = 60,
	sellPrice = 12,
	reqLevel = 1,
}
t[3599] = {
	name = L["Thin Cloth Belt"],
	quality = 1,
	icon = "inv_belt_06",
	buyPrice = 24,
	sellPrice = 4,
	reqLevel = 1,
}
t[3600] = {
	name = L["Thin Cloth Bracers"],
	quality = 1,
	icon = "inv_bracer_03",
	buyPrice = 24,
	sellPrice = 4,
	reqLevel = 1,
}
t[1194] = {
	name = L["Bastard Sword"],
	quality = 1,
	icon = "inv_sword_06",
	buyPrice = 104,
	sellPrice = 20,
	reqLevel = 1,
}
t[2101] = {
	name = L["Light Quiver"],
	quality = 1,
	icon = "inv_misc_quiver_09",
	buyPrice = 4,
	sellPrice = 1,
	reqLevel = 1,
}
t[2130] = {
	name = L["Club"],
	quality = 1,
	icon = "inv_mace_10",
	buyPrice = 54,
	sellPrice = 10,
	reqLevel = 1,
}
t[2131] = {
	name = L["Shortsword"],
	quality = 1,
	icon = "inv_sword_04",
	buyPrice = 54,
	sellPrice = 10,
	reqLevel = 1,
}
t[2132] = {
	name = L["Short Staff"],
	quality = 1,
	icon = "inv_staff_02",
	buyPrice = 102,
	sellPrice = 20,
	reqLevel = 1,
}
t[2134] = {
	name = L["Hand Axe"],
	quality = 1,
	icon = "inv_axe_19",
	buyPrice = 82,
	sellPrice = 16,
	reqLevel = 1,
}
t[2139] = {
	name = L["Dirk"],
	quality = 1,
	icon = "inv_weapon_shortblade_14",
	buyPrice = 57,
	sellPrice = 11,
	reqLevel = 1,
}
t[2479] = {
	name = L["Broad Axe"],
	quality = 1,
	icon = "inv_axe_11",
	buyPrice = 108,
	sellPrice = 21,
	reqLevel = 1,
}
t[2480] = {
	name = L["Large Club"],
	quality = 1,
	icon = "inv_mace_06",
	buyPrice = 72,
	sellPrice = 14,
	reqLevel = 1,
}
t[7371] = {
	name = L["Heavy Quiver"],
	quality = 2,
	icon = "inv_misc_quiver_02",
	buyPrice = 2000,
	sellPrice = 500,
	reqLevel = 30,
}
t[15807] = {
	name = L["Light Crossbow"],
	quality = 1,
	icon = "inv_weapon_crossbow_02",
	buyPrice = 294,
	sellPrice = 58,
	reqLevel = 3,
}
t[15808] = {
	name = L["Fine Light Crossbow"],
	quality = 1,
	icon = "inv_weapon_crossbow_02",
	buyPrice = 3641,
	sellPrice = 728,
	reqLevel = 16,
}
t[15809] = {
	name = L["Heavy Crossbow"],
	quality = 1,
	icon = "inv_weapon_crossbow_03",
	buyPrice = 14691,
	sellPrice = 2938,
	reqLevel = 29,
}
t[20857] = {
	name = L["Honey Bread"],
	quality = 1,
	icon = "inv_misc_food_11",
	buyPrice = 25,
	sellPrice = 1,
	reqLevel = 1,
}
t[25861] = {
	name = L["Crude Throwing Axe"],
	quality = 1,
	icon = "inv_axe_19",
	buyPrice = 15,
	sellPrice = 3,
	reqLevel = 1,
}
t[21099] = {
	name = L["Recipe: Smoked Sagefish"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 500,
	sellPrice = 125,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Smoked Sagefish"],
	learnedAt = 80,
}
t[21219] = {
	name = L["Recipe: Sagefish Delight"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 5000,
	sellPrice = 1250,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Sagefish Delight"],
	learnedAt = 175,
}
t[2516] = {
	name = L["Light Shot"],
	quality = 1,
	icon = "inv_ammo_bullet_02",
	buyPrice = 10,
	sellPrice = 0,
	reqLevel = 1,
}
t[5042] = {
	name = L["Red Ribboned Wrapping Paper"],
	quality = 1,
	icon = "inv_misc_giftwrap_02",
	buyPrice = 50,
	sellPrice = 12,
	reqLevel = 0,
}
t[25872] = {
	name = L["Balanced Throwing Dagger"],
	quality = 1,
	icon = "inv_weapon_shortblade_05",
	buyPrice = 30,
	sellPrice = 7,
	reqLevel = 3,
}
t[28979] = {
	name = L["Light Throwing Knife"],
	quality = 1,
	icon = "inv_weapon_shortblade_20",
	buyPrice = 15,
	sellPrice = 3,
	reqLevel = 1,
}
t[29007] = {
	name = L["Weighted Throwing Axe"],
	quality = 1,
	icon = "inv_axe_20",
	buyPrice = 30,
	sellPrice = 7,
	reqLevel = 3,
}
t[2519] = {
	name = L["Heavy Shot"],
	quality = 1,
	icon = "inv_ammo_bullet_02",
	buyPrice = 50,
	sellPrice = 0,
	reqLevel = 10,
}
t[3033] = {
	name = L["Solid Shot"],
	quality = 1,
	icon = "inv_ammo_bullet_02",
	buyPrice = 300,
	sellPrice = 0,
	reqLevel = 25,
}
t[5048] = {
	name = L["Blue Ribboned Wrapping Paper"],
	quality = 1,
	icon = "inv_misc_giftwrap_03",
	buyPrice = 50,
	sellPrice = 12,
	reqLevel = 0,
}
t[25873] = {
	name = L["Keen Throwing Knife"],
	quality = 1,
	icon = "inv_throwingknife_01",
	buyPrice = 75,
	sellPrice = 18,
	reqLevel = 11,
}
t[25875] = {
	name = L["Deadly Throwing Axe"],
	quality = 1,
	icon = "inv_throwingaxe_05",
	buyPrice = 200,
	sellPrice = 50,
	reqLevel = 22,
}
t[29008] = {
	name = L["Sharp Throwing Axe"],
	quality = 1,
	icon = "inv_axe_01",
	buyPrice = 75,
	sellPrice = 18,
	reqLevel = 11,
}
t[29009] = {
	name = L["Heavy Throwing Dagger"],
	quality = 1,
	icon = "inv_weapon_shortblade_14",
	buyPrice = 200,
	sellPrice = 50,
	reqLevel = 22,
}
t[792] = {
	name = L["Knitted Sandals"],
	quality = 1,
	icon = "inv_boots_fabric_01",
	buyPrice = 208,
	sellPrice = 41,
	reqLevel = 5,
}
t[793] = {
	name = L["Knitted Gloves"],
	quality = 1,
	icon = "inv_gauntlets_18",
	buyPrice = 139,
	sellPrice = 27,
	reqLevel = 5,
}
t[794] = {
	name = L["Knitted Pants"],
	quality = 1,
	icon = "inv_pants_11",
	buyPrice = 280,
	sellPrice = 56,
	reqLevel = 5,
}
t[795] = {
	name = L["Knitted Tunic"],
	quality = 1,
	icon = "inv_shirt_10",
	buyPrice = 281,
	sellPrice = 56,
	reqLevel = 5,
}
t[796] = {
	name = L["Rough Leather Boots"],
	quality = 1,
	icon = "inv_boots_09",
	buyPrice = 264,
	sellPrice = 52,
	reqLevel = 5,
}
t[797] = {
	name = L["Rough Leather Gloves"],
	quality = 1,
	icon = "inv_gauntlets_18",
	buyPrice = 177,
	sellPrice = 35,
	reqLevel = 5,
}
t[798] = {
	name = L["Rough Leather Pants"],
	quality = 1,
	icon = "inv_pants_09",
	buyPrice = 355,
	sellPrice = 71,
	reqLevel = 5,
}
t[799] = {
	name = L["Rough Leather Vest"],
	quality = 1,
	icon = "inv_chest_wolf",
	buyPrice = 356,
	sellPrice = 71,
	reqLevel = 5,
}
t[1839] = {
	name = L["Rough Leather Belt"],
	quality = 1,
	icon = "inv_belt_26",
	buyPrice = 185,
	sellPrice = 37,
	reqLevel = 5,
}
t[1840] = {
	name = L["Rough Leather Bracers"],
	quality = 1,
	icon = "inv_bracer_02",
	buyPrice = 185,
	sellPrice = 37,
	reqLevel = 5,
}
t[3602] = {
	name = L["Knitted Belt"],
	quality = 1,
	icon = "inv_belt_06",
	buyPrice = 145,
	sellPrice = 29,
	reqLevel = 5,
}
t[3603] = {
	name = L["Knitted Bracers"],
	quality = 1,
	icon = "inv_bracer_03",
	buyPrice = 146,
	sellPrice = 29,
	reqLevel = 5,
}
t[1201] = {
	name = L["Dull Heater Shield"],
	quality = 1,
	icon = "inv_shield_04",
	buyPrice = 473,
	sellPrice = 94,
	reqLevel = 5,
}
t[2392] = {
	name = L["Light Mail Armor"],
	quality = 1,
	icon = "inv_chest_chain",
	buyPrice = 413,
	sellPrice = 82,
	reqLevel = 5,
}
t[2393] = {
	name = L["Light Mail Belt"],
	quality = 1,
	icon = "inv_belt_06",
	buyPrice = 207,
	sellPrice = 41,
	reqLevel = 5,
}
t[2394] = {
	name = L["Light Mail Leggings"],
	quality = 1,
	icon = "inv_pants_03",
	buyPrice = 416,
	sellPrice = 83,
	reqLevel = 5,
}
t[2395] = {
	name = L["Light Mail Boots"],
	quality = 1,
	icon = "inv_boots_01",
	buyPrice = 323,
	sellPrice = 64,
	reqLevel = 5,
}
t[2396] = {
	name = L["Light Mail Bracers"],
	quality = 1,
	icon = "inv_bracer_03",
	buyPrice = 215,
	sellPrice = 43,
	reqLevel = 5,
}
t[2397] = {
	name = L["Light Mail Gloves"],
	quality = 1,
	icon = "inv_gauntlets_04",
	buyPrice = 216,
	sellPrice = 43,
	reqLevel = 5,
}
t[2488] = {
	name = L["Gladius"],
	quality = 1,
	icon = "inv_sword_20",
	buyPrice = 536,
	sellPrice = 107,
	reqLevel = 4,
}
t[2489] = {
	name = L["Two-handed Sword"],
	quality = 1,
	icon = "inv_sword_14",
	buyPrice = 343,
	sellPrice = 68,
	reqLevel = 2,
}
t[2490] = {
	name = L["Tomahawk"],
	quality = 1,
	icon = "inv_throwingaxe_03",
	buyPrice = 540,
	sellPrice = 108,
	reqLevel = 4,
}
t[2491] = {
	name = L["Large Axe"],
	quality = 1,
	icon = "inv_axe_10",
	buyPrice = 484,
	sellPrice = 96,
	reqLevel = 3,
}
t[2492] = {
	name = L["Cudgel"],
	quality = 1,
	icon = "inv_torch_unlit",
	buyPrice = 285,
	sellPrice = 57,
	reqLevel = 2,
}
t[2493] = {
	name = L["Wooden Mallet"],
	quality = 1,
	icon = "inv_hammer_16",
	buyPrice = 701,
	sellPrice = 140,
	reqLevel = 4,
}
t[2494] = {
	name = L["Stiletto"],
	quality = 1,
	icon = "inv_weapon_shortblade_05",
	buyPrice = 402,
	sellPrice = 80,
	reqLevel = 3,
}
t[2495] = {
	name = L["Walking Stick"],
	quality = 1,
	icon = "inv_staff_08",
	buyPrice = 505,
	sellPrice = 101,
	reqLevel = 3,
}
t[17186] = {
	name = L["Small Targe"],
	quality = 1,
	icon = "inv_shield_09",
	buyPrice = 260,
	sellPrice = 52,
	reqLevel = 3,
}
t[929] = {
	name = L["Healing Potion"],
	quality = 1,
	icon = "inv_potion_51",
	buyPrice = 300,
	sellPrice = 75,
	reqLevel = 12,
}
t[787] = {
	name = L["Slitherskin Mackerel"],
	quality = 1,
	icon = "inv_misc_fish_24",
	buyPrice = 25,
	sellPrice = 1,
	reqLevel = 1,
}
t[4540] = {
	name = L["Tough Hunk of Bread"],
	quality = 1,
	icon = "inv_misc_food_11",
	buyPrice = 25,
	sellPrice = 1,
	reqLevel = 1,
}
t[4541] = {
	name = L["Freshly Baked Bread"],
	quality = 1,
	icon = "inv_misc_food_12",
	buyPrice = 125,
	sellPrice = 6,
	reqLevel = 5,
}
t[4542] = {
	name = L["Moist Cornbread"],
	quality = 1,
	icon = "inv_misc_food_08",
	buyPrice = 500,
	sellPrice = 25,
	reqLevel = 15,
}
t[4544] = {
	name = L["Mulgore Spice Bread"],
	quality = 1,
	icon = "inv_misc_food_11",
	buyPrice = 1000,
	sellPrice = 50,
	reqLevel = 25,
}
t[4592] = {
	name = L["Longjaw Mud Snapper"],
	quality = 1,
	icon = "inv_misc_fish_32",
	buyPrice = 20,
	sellPrice = 1,
	reqLevel = 5,
}
t[4593] = {
	name = L["Bristle Whisker Catfish"],
	quality = 1,
	icon = "inv_misc_fish_30",
	buyPrice = 500,
	sellPrice = 4,
	reqLevel = 15,
}
t[4594] = {
	name = L["Rockscale Cod"],
	quality = 1,
	icon = "inv_misc_fish_04",
	buyPrice = 1000,
	sellPrice = 6,
	reqLevel = 25,
}
t[4601] = {
	name = L["Soft Banana Bread"],
	quality = 1,
	icon = "inv_misc_food_09",
	buyPrice = 2000,
	sellPrice = 100,
	reqLevel = 35,
}
t[21552] = {
	name = L["Striped Yellowtail"],
	quality = 1,
	icon = "inv_misc_fish_01",
	buyPrice = 2000,
	sellPrice = 5,
	reqLevel = 35,
}
t[20849] = {
	name = L["Arcane Forged Shortsword"],
	quality = 1,
	icon = "inv_sword_04",
	buyPrice = 84,
	sellPrice = 16,
	reqLevel = 1,
}
t[20850] = {
	name = L["Arcane Forged Axe"],
	quality = 1,
	icon = "inv_axe_19",
	buyPrice = 84,
	sellPrice = 16,
	reqLevel = 1,
}
t[20851] = {
	name = L["Arcane Forged Mace"],
	quality = 1,
	icon = "inv_mace_10",
	buyPrice = 85,
	sellPrice = 17,
	reqLevel = 1,
}
t[20852] = {
	name = L["Arcane Forged Dirk"],
	quality = 1,
	icon = "inv_weapon_shortblade_12",
	buyPrice = 85,
	sellPrice = 17,
	reqLevel = 1,
}
t[20853] = {
	name = L["Mana Gathering Staff"],
	quality = 1,
	icon = "inv_staff_02",
	buyPrice = 107,
	sellPrice = 21,
	reqLevel = 1,
}
t[20910] = {
	name = L["Stiff Shortbow"],
	quality = 1,
	icon = "inv_weapon_bow_02",
	buyPrice = 63,
	sellPrice = 12,
	reqLevel = 1,
}
t[20920] = {
	name = L["Sun Cured Belt"],
	quality = 1,
	icon = "inv_belt_04",
	buyPrice = 30,
	sellPrice = 6,
	reqLevel = 1,
}
t[20921] = {
	name = L["Sun Cured Boots"],
	quality = 1,
	icon = "inv_boots_06",
	buyPrice = 46,
	sellPrice = 9,
	reqLevel = 1,
}
t[20922] = {
	name = L["Sun Cured Bracers"],
	quality = 1,
	icon = "inv_bracer_11",
	buyPrice = 30,
	sellPrice = 6,
	reqLevel = 1,
}
t[20923] = {
	name = L["Sun Cured Gloves"],
	quality = 1,
	icon = "inv_gauntlets_18",
	buyPrice = 30,
	sellPrice = 6,
	reqLevel = 1,
}
t[20924] = {
	name = L["Sun Cured Pants"],
	quality = 1,
	icon = "inv_pants_10",
	buyPrice = 62,
	sellPrice = 12,
	reqLevel = 1,
}
t[20925] = {
	name = L["Sun Cured Vest"],
	quality = 1,
	icon = "inv_shirt_06",
	buyPrice = 62,
	sellPrice = 12,
	reqLevel = 1,
}
t[20985] = {
	name = L["Light Cloth Shoes"],
	quality = 1,
	icon = "inv_boots_09",
	buyPrice = 38,
	sellPrice = 7,
	reqLevel = 1,
}
t[20986] = {
	name = L["Light Cloth Pants"],
	quality = 1,
	icon = "inv_pants_02",
	buyPrice = 51,
	sellPrice = 10,
	reqLevel = 1,
}
t[20987] = {
	name = L["Light Cloth Gloves"],
	quality = 1,
	icon = "inv_gauntlets_18",
	buyPrice = 25,
	sellPrice = 5,
	reqLevel = 1,
}
t[20988] = {
	name = L["Light Cloth Bracers"],
	quality = 1,
	icon = "inv_bracer_03",
	buyPrice = 25,
	sellPrice = 5,
	reqLevel = 1,
}
t[20989] = {
	name = L["Light Cloth Belt"],
	quality = 1,
	icon = "inv_belt_06",
	buyPrice = 25,
	sellPrice = 5,
	reqLevel = 1,
}
t[20990] = {
	name = L["Light Cloth Armor"],
	quality = 1,
	icon = "inv_shirt_red_01",
	buyPrice = 52,
	sellPrice = 10,
	reqLevel = 1,
}
t[20911] = {
	name = L["Light Guard"],
	quality = 1,
	icon = "inv_shield_09",
	buyPrice = 37,
	sellPrice = 7,
	reqLevel = 1,
}
t[20912] = {
	name = L["Large Shield"],
	quality = 1,
	icon = "inv_shield_09",
	buyPrice = 84,
	sellPrice = 16,
	reqLevel = 1,
}
t[20914] = {
	name = L["Unadorned Chain Belt"],
	quality = 1,
	icon = "inv_belt_06",
	buyPrice = 39,
	sellPrice = 7,
	reqLevel = 1,
}
t[20915] = {
	name = L["Unadorned Chain Boots"],
	quality = 1,
	icon = "inv_boots_01",
	buyPrice = 60,
	sellPrice = 12,
	reqLevel = 1,
}
t[20916] = {
	name = L["Unadorned Chain Bracers"],
	quality = 1,
	icon = "inv_bracer_03",
	buyPrice = 36,
	sellPrice = 7,
	reqLevel = 1,
}
t[20917] = {
	name = L["Unadorned Chain Gloves"],
	quality = 1,
	icon = "inv_gauntlets_04",
	buyPrice = 36,
	sellPrice = 7,
	reqLevel = 1,
}
t[20918] = {
	name = L["Unadorned Chain Leggings"],
	quality = 1,
	icon = "inv_pants_mail_03",
	buyPrice = 72,
	sellPrice = 14,
	reqLevel = 1,
}
t[20919] = {
	name = L["Unadorned Chain Vest"],
	quality = 1,
	icon = "inv_chest_chain_13",
	buyPrice = 73,
	sellPrice = 14,
	reqLevel = 1,
}
t[117] = {
	name = L["Tough Jerky"],
	quality = 1,
	icon = "inv_misc_food_16",
	buyPrice = 25,
	sellPrice = 1,
	reqLevel = 1,
}
t[2287] = {
	name = L["Haunch of Meat"],
	quality = 1,
	icon = "inv_misc_food_18",
	buyPrice = 125,
	sellPrice = 6,
	reqLevel = 5,
}
t[3770] = {
	name = L["Mutton Chop"],
	quality = 1,
	icon = "inv_misc_food_14",
	buyPrice = 500,
	sellPrice = 25,
	reqLevel = 15,
}
t[3771] = {
	name = L["Wild Hog Shank"],
	quality = 1,
	icon = "inv_misc_food_13",
	buyPrice = 1000,
	sellPrice = 50,
	reqLevel = 25,
}
t[4599] = {
	name = L["Cured Ham Steak"],
	quality = 1,
	icon = "inv_misc_food_14",
	buyPrice = 2000,
	sellPrice = 100,
	reqLevel = 35,
}
t[25876] = {
	name = L["Gleaming Throwing Axe"],
	quality = 1,
	icon = "inv_throwingaxe_06",
	buyPrice = 800,
	sellPrice = 200,
	reqLevel = 35,
}
t[29010] = {
	name = L["Wicked Throwing Dagger"],
	quality = 1,
	icon = "inv_weapon_shortblade_15",
	buyPrice = 800,
	sellPrice = 200,
	reqLevel = 35,
}
t[16302] = {
	name = L["Grimoire of Firebolt (Rank 2)"],
	quality = 1,
	icon = "inv_misc_book_06",
	buyPrice = 100,
	sellPrice = 25,
	reqLevel = 8,
}
t[16316] = {
	name = L["Grimoire of Firebolt (Rank 3)"],
	quality = 1,
	icon = "inv_misc_book_06",
	buyPrice = 1500,
	sellPrice = 375,
	reqLevel = 18,
}
t[16317] = {
	name = L["Grimoire of Firebolt (Rank 4)"],
	quality = 1,
	icon = "inv_misc_book_06",
	buyPrice = 5000,
	sellPrice = 1250,
	reqLevel = 28,
}
t[16318] = {
	name = L["Grimoire of Firebolt (Rank 5)"],
	quality = 1,
	icon = "inv_misc_book_06",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 38,
}
t[16319] = {
	name = L["Grimoire of Firebolt (Rank 6)"],
	quality = 1,
	icon = "inv_misc_book_06",
	buyPrice = 14000,
	sellPrice = 3500,
	reqLevel = 48,
}
t[16320] = {
	name = L["Grimoire of Firebolt (Rank 7)"],
	quality = 1,
	icon = "inv_misc_book_06",
	buyPrice = 24000,
	sellPrice = 6000,
	reqLevel = 58,
}
t[16321] = {
	name = L["Grimoire of Blood Pact (Rank 1)"],
	quality = 1,
	icon = "inv_misc_book_06",
	buyPrice = 100,
	sellPrice = 25,
	reqLevel = 4,
}
t[16322] = {
	name = L["Grimoire of Blood Pact (Rank 2)"],
	quality = 1,
	icon = "inv_misc_book_06",
	buyPrice = 900,
	sellPrice = 225,
	reqLevel = 14,
}
t[16323] = {
	name = L["Grimoire of Blood Pact (Rank 3)"],
	quality = 1,
	icon = "inv_misc_book_06",
	buyPrice = 4000,
	sellPrice = 1000,
	reqLevel = 26,
}
t[16324] = {
	name = L["Grimoire of Blood Pact (Rank 4)"],
	quality = 1,
	icon = "inv_misc_book_06",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 38,
}
t[16325] = {
	name = L["Grimoire of Blood Pact (Rank 5)"],
	quality = 1,
	icon = "inv_misc_book_06",
	buyPrice = 15000,
	sellPrice = 3750,
	reqLevel = 50,
}
t[16326] = {
	name = L["Grimoire of Fire Shield (Rank 1)"],
	quality = 1,
	icon = "inv_misc_book_06",
	buyPrice = 900,
	sellPrice = 225,
	reqLevel = 14,
}
t[16327] = {
	name = L["Grimoire of Fire Shield (Rank 2)"],
	quality = 1,
	icon = "inv_misc_book_06",
	buyPrice = 3000,
	sellPrice = 750,
	reqLevel = 24,
}
t[16328] = {
	name = L["Grimoire of Fire Shield (Rank 3)"],
	quality = 1,
	icon = "inv_misc_book_06",
	buyPrice = 8000,
	sellPrice = 2000,
	reqLevel = 34,
}
t[16329] = {
	name = L["Grimoire of Fire Shield (Rank 4)"],
	quality = 1,
	icon = "inv_misc_book_06",
	buyPrice = 12000,
	sellPrice = 3000,
	reqLevel = 44,
}
t[16330] = {
	name = L["Grimoire of Fire Shield (Rank 5)"],
	quality = 1,
	icon = "inv_misc_book_06",
	buyPrice = 20000,
	sellPrice = 5000,
	reqLevel = 54,
}
t[16331] = {
	name = L["Grimoire of Phase Shift"],
	quality = 1,
	icon = "inv_misc_book_06",
	buyPrice = 600,
	sellPrice = 150,
	reqLevel = 12,
}
t[22179] = {
	name = L["Grimoire of Firebolt (Rank 8)"],
	quality = 1,
	icon = "inv_misc_book_06",
	buyPrice = 54000,
	sellPrice = 13500,
	reqLevel = 68,
}
t[22180] = {
	name = L["Grimoire of Blood Pact (Rank 6)"],
	quality = 1,
	icon = "inv_misc_book_06",
	buyPrice = 26000,
	sellPrice = 6500,
	reqLevel = 62,
}
t[22181] = {
	name = L["Grimoire of Fire Shield (Rank 6)"],
	quality = 1,
	icon = "inv_misc_book_06",
	buyPrice = 36000,
	sellPrice = 9000,
	reqLevel = 64,
}
t[2364] = {
	name = L["Woven Vest"],
	quality = 1,
	icon = "inv_shirt_07",
	buyPrice = 296,
	sellPrice = 59,
	reqLevel = 5,
}
t[2366] = {
	name = L["Woven Pants"],
	quality = 1,
	icon = "inv_pants_06",
	buyPrice = 298,
	sellPrice = 59,
	reqLevel = 5,
}
t[2367] = {
	name = L["Woven Boots"],
	quality = 1,
	icon = "inv_boots_09",
	buyPrice = 224,
	sellPrice = 44,
	reqLevel = 5,
}
t[2369] = {
	name = L["Woven Gloves"],
	quality = 1,
	icon = "inv_gauntlets_23",
	buyPrice = 150,
	sellPrice = 30,
	reqLevel = 5,
}
t[2370] = {
	name = L["Battered Leather Harness"],
	quality = 1,
	icon = "inv_chest_leather_04",
	buyPrice = 378,
	sellPrice = 75,
	reqLevel = 5,
}
t[2371] = {
	name = L["Battered Leather Belt"],
	quality = 1,
	icon = "inv_belt_03",
	buyPrice = 189,
	sellPrice = 37,
	reqLevel = 5,
}
t[2372] = {
	name = L["Battered Leather Pants"],
	quality = 1,
	icon = "inv_pants_wolf",
	buyPrice = 344,
	sellPrice = 68,
	reqLevel = 5,
}
t[2373] = {
	name = L["Battered Leather Boots"],
	quality = 1,
	icon = "inv_boots_wolf",
	buyPrice = 259,
	sellPrice = 51,
	reqLevel = 5,
}
t[2374] = {
	name = L["Battered Leather Bracers"],
	quality = 1,
	icon = "inv_bracer_02",
	buyPrice = 173,
	sellPrice = 34,
	reqLevel = 5,
}
t[2375] = {
	name = L["Battered Leather Gloves"],
	quality = 1,
	icon = "inv_gauntlets_18",
	buyPrice = 174,
	sellPrice = 34,
	reqLevel = 5,
}
t[3606] = {
	name = L["Woven Belt"],
	quality = 1,
	icon = "inv_belt_24",
	buyPrice = 147,
	sellPrice = 29,
	reqLevel = 5,
}
t[3607] = {
	name = L["Woven Bracers"],
	quality = 1,
	icon = "inv_bracer_10",
	buyPrice = 148,
	sellPrice = 29,
	reqLevel = 5,
}
t[2376] = {
	name = L["Worn Heater Shield"],
	quality = 1,
	icon = "inv_shield_04",
	buyPrice = 448,
	sellPrice = 89,
	reqLevel = 5,
}
t[2398] = {
	name = L["Light Chain Armor"],
	quality = 1,
	icon = "inv_chest_chain",
	buyPrice = 434,
	sellPrice = 86,
	reqLevel = 5,
}
t[2399] = {
	name = L["Light Chain Belt"],
	quality = 1,
	icon = "inv_belt_06",
	buyPrice = 218,
	sellPrice = 43,
	reqLevel = 5,
}
t[2400] = {
	name = L["Light Chain Leggings"],
	quality = 1,
	icon = "inv_pants_03",
	buyPrice = 437,
	sellPrice = 87,
	reqLevel = 5,
}
t[2401] = {
	name = L["Light Chain Boots"],
	quality = 1,
	icon = "inv_boots_01",
	buyPrice = 331,
	sellPrice = 66,
	reqLevel = 5,
}
t[2402] = {
	name = L["Light Chain Bracers"],
	quality = 1,
	icon = "inv_bracer_05",
	buyPrice = 220,
	sellPrice = 44,
	reqLevel = 5,
}
t[2403] = {
	name = L["Light Chain Gloves"],
	quality = 1,
	icon = "inv_gauntlets_04",
	buyPrice = 221,
	sellPrice = 44,
	reqLevel = 5,
}
t[17185] = {
	name = L["Round Buckler"],
	quality = 1,
	icon = "inv_shield_09",
	buyPrice = 260,
	sellPrice = 52,
	reqLevel = 3,
}
t[27685] = {
	name = L["Recipe: Lynx Steak"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 40,
	sellPrice = 10,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Lynx Steak"],
	learnedAt = 1,
}
t[2504] = {
	name = L["Worn Shortbow"],
	quality = 1,
	icon = "inv_weapon_bow_05",
	buyPrice = 29,
	sellPrice = 5,
	reqLevel = 1,
}
t[2505] = {
	name = L["Polished Shortbow"],
	quality = 1,
	icon = "inv_weapon_bow_02",
	buyPrice = 60,
	sellPrice = 12,
	reqLevel = 1,
}
t[2506] = {
	name = L["Hornwood Recurve Bow"],
	quality = 1,
	icon = "inv_weapon_bow_11",
	buyPrice = 285,
	sellPrice = 57,
	reqLevel = 3,
}
t[2507] = {
	name = L["Laminated Recurve Bow"],
	quality = 1,
	icon = "inv_weapon_bow_01",
	buyPrice = 1752,
	sellPrice = 350,
	reqLevel = 11,
}
t[28927] = {
	name = L["Red Hawkstrider"],
	quality = 3,
	icon = "ability_mount_cockatricemount",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 20,
}
t[28936] = {
	name = L["Swift Pink Hawkstrider"],
	quality = 4,
	icon = "ability_mount_cockatricemountelite",
	buyPrice = 100000,
	sellPrice = 25000,
	reqLevel = 40,
}
t[29220] = {
	name = L["Blue Hawkstrider"],
	quality = 3,
	icon = "ability_mount_cockatricemount_blue",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 20,
}
t[29221] = {
	name = L["Black Hawkstrider"],
	quality = 3,
	icon = "ability_mount_cockatricemount_black",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 20,
}
t[29222] = {
	name = L["Purple Hawkstrider"],
	quality = 3,
	icon = "ability_mount_cockatricemount_purple",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 20,
}
t[29223] = {
	name = L["Swift Green Hawkstrider"],
	quality = 4,
	icon = "ability_mount_cockatricemountelite_green",
	buyPrice = 100000,
	sellPrice = 25000,
	reqLevel = 40,
}
t[29224] = {
	name = L["Swift Purple Hawkstrider"],
	quality = 4,
	icon = "ability_mount_cockatricemountelite_purple",
	buyPrice = 100000,
	sellPrice = 25000,
	reqLevel = 40,
}
t[16346] = {
	name = L["Grimoire of Torment (Rank 2)"],
	quality = 1,
	icon = "inv_misc_book_06",
	buyPrice = 2000,
	sellPrice = 500,
	reqLevel = 20,
}
t[16347] = {
	name = L["Grimoire of Torment (Rank 3)"],
	quality = 1,
	icon = "inv_misc_book_06",
	buyPrice = 6000,
	sellPrice = 1500,
	reqLevel = 30,
}
t[16348] = {
	name = L["Grimoire of Torment (Rank 4)"],
	quality = 1,
	icon = "inv_misc_book_06",
	buyPrice = 11000,
	sellPrice = 2750,
	reqLevel = 40,
}
t[16349] = {
	name = L["Grimoire of Torment (Rank 5)"],
	quality = 1,
	icon = "inv_misc_book_06",
	buyPrice = 15000,
	sellPrice = 3750,
	reqLevel = 50,
}
t[16350] = {
	name = L["Grimoire of Torment (Rank 6)"],
	quality = 1,
	icon = "inv_misc_book_06",
	buyPrice = 26000,
	sellPrice = 6500,
	reqLevel = 60,
}
t[16351] = {
	name = L["Grimoire of Sacrifice (Rank 1)"],
	quality = 1,
	icon = "inv_misc_book_06",
	buyPrice = 1200,
	sellPrice = 300,
	reqLevel = 16,
}
t[16352] = {
	name = L["Grimoire of Sacrifice (Rank 2)"],
	quality = 1,
	icon = "inv_misc_book_06",
	buyPrice = 3000,
	sellPrice = 750,
	reqLevel = 24,
}
t[16353] = {
	name = L["Grimoire of Sacrifice (Rank 3)"],
	quality = 1,
	icon = "inv_misc_book_06",
	buyPrice = 7000,
	sellPrice = 1750,
	reqLevel = 32,
}
t[16354] = {
	name = L["Grimoire of Sacrifice (Rank 4)"],
	quality = 1,
	icon = "inv_misc_book_06",
	buyPrice = 11000,
	sellPrice = 2750,
	reqLevel = 40,
}
t[16355] = {
	name = L["Grimoire of Sacrifice (Rank 5)"],
	quality = 1,
	icon = "inv_misc_book_06",
	buyPrice = 14000,
	sellPrice = 3500,
	reqLevel = 48,
}
t[16356] = {
	name = L["Grimoire of Sacrifice (Rank 6)"],
	quality = 1,
	icon = "inv_misc_book_06",
	buyPrice = 22000,
	sellPrice = 5500,
	reqLevel = 56,
}
t[16357] = {
	name = L["Grimoire of Consume Shadows (Rank 1)"],
	quality = 1,
	icon = "inv_misc_book_06",
	buyPrice = 1500,
	sellPrice = 375,
	reqLevel = 18,
}
t[16358] = {
	name = L["Grimoire of Consume Shadows (Rank 2)"],
	quality = 1,
	icon = "inv_misc_book_06",
	buyPrice = 4000,
	sellPrice = 1000,
	reqLevel = 26,
}
t[16359] = {
	name = L["Grimoire of Consume Shadows (Rank 3)"],
	quality = 1,
	icon = "inv_misc_book_06",
	buyPrice = 8000,
	sellPrice = 2000,
	reqLevel = 34,
}
t[16360] = {
	name = L["Grimoire of Consume Shadows (Rank 4)"],
	quality = 1,
	icon = "inv_misc_book_06",
	buyPrice = 11000,
	sellPrice = 2750,
	reqLevel = 42,
}
t[16361] = {
	name = L["Grimoire of Consume Shadows (Rank 5)"],
	quality = 1,
	icon = "inv_misc_book_06",
	buyPrice = 15000,
	sellPrice = 3750,
	reqLevel = 50,
}
t[16362] = {
	name = L["Grimoire of Consume Shadows (Rank 6)"],
	quality = 1,
	icon = "inv_misc_book_06",
	buyPrice = 24000,
	sellPrice = 6000,
	reqLevel = 58,
}
t[16363] = {
	name = L["Grimoire of Suffering (Rank 1)"],
	quality = 1,
	icon = "inv_misc_book_06",
	buyPrice = 3000,
	sellPrice = 750,
	reqLevel = 24,
}
t[16364] = {
	name = L["Grimoire of Suffering (Rank 2)"],
	quality = 1,
	icon = "inv_misc_book_06",
	buyPrice = 9000,
	sellPrice = 2250,
	reqLevel = 36,
}
t[16365] = {
	name = L["Grimoire of Suffering (Rank 3)"],
	quality = 1,
	icon = "inv_misc_book_06",
	buyPrice = 14000,
	sellPrice = 3500,
	reqLevel = 48,
}
t[16366] = {
	name = L["Grimoire of Suffering (Rank 4)"],
	quality = 1,
	icon = "inv_misc_book_06",
	buyPrice = 26000,
	sellPrice = 6500,
	reqLevel = 60,
}
t[16368] = {
	name = L["Grimoire of Lash of Pain (Rank 2)"],
	quality = 1,
	icon = "inv_misc_book_06",
	buyPrice = 5000,
	sellPrice = 1250,
	reqLevel = 28,
}
t[16371] = {
	name = L["Grimoire of Lash of Pain (Rank 3)"],
	quality = 1,
	icon = "inv_misc_book_06",
	buyPrice = 9000,
	sellPrice = 2250,
	reqLevel = 36,
}
t[16372] = {
	name = L["Grimoire of Lash of Pain (Rank 4)"],
	quality = 1,
	icon = "inv_misc_book_06",
	buyPrice = 12000,
	sellPrice = 3000,
	reqLevel = 44,
}
t[16373] = {
	name = L["Grimoire of Lash of Pain (Rank 5)"],
	quality = 1,
	icon = "inv_misc_book_06",
	buyPrice = 18000,
	sellPrice = 4500,
	reqLevel = 52,
}
t[16374] = {
	name = L["Grimoire of Lash of Pain (Rank 6)"],
	quality = 1,
	icon = "inv_misc_book_06",
	buyPrice = 26000,
	sellPrice = 6500,
	reqLevel = 60,
}
t[16375] = {
	name = L["Grimoire of Soothing Kiss (Rank 1)"],
	quality = 1,
	icon = "inv_misc_book_06",
	buyPrice = 2500,
	sellPrice = 625,
	reqLevel = 22,
}
t[16376] = {
	name = L["Grimoire of Soothing Kiss (Rank 2)"],
	quality = 1,
	icon = "inv_misc_book_06",
	buyPrice = 8000,
	sellPrice = 2000,
	reqLevel = 34,
}
t[16377] = {
	name = L["Grimoire of Soothing Kiss (Rank 3)"],
	quality = 1,
	icon = "inv_misc_book_06",
	buyPrice = 13000,
	sellPrice = 3250,
	reqLevel = 46,
}
t[16378] = {
	name = L["Grimoire of Soothing Kiss (Rank 4)"],
	quality = 1,
	icon = "inv_misc_book_06",
	buyPrice = 24000,
	sellPrice = 6000,
	reqLevel = 58,
}
t[16379] = {
	name = L["Grimoire of Seduction"],
	quality = 1,
	icon = "inv_misc_book_06",
	buyPrice = 4000,
	sellPrice = 1000,
	reqLevel = 26,
}
t[16380] = {
	name = L["Grimoire of Lesser Invisibility"],
	quality = 1,
	icon = "inv_misc_book_06",
	buyPrice = 7000,
	sellPrice = 1750,
	reqLevel = 32,
}
t[16381] = {
	name = L["Grimoire of Devour Magic (Rank 2)"],
	quality = 1,
	icon = "inv_misc_book_06",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 38,
}
t[16382] = {
	name = L["Grimoire of Devour Magic (Rank 3)"],
	quality = 1,
	icon = "inv_misc_book_06",
	buyPrice = 13000,
	sellPrice = 3250,
	reqLevel = 46,
}
t[16383] = {
	name = L["Grimoire of Devour Magic (Rank 4)"],
	quality = 1,
	icon = "inv_misc_book_06",
	buyPrice = 20000,
	sellPrice = 5000,
	reqLevel = 54,
}
t[16384] = {
	name = L["Grimoire of Tainted Blood (Rank 1)"],
	quality = 1,
	icon = "inv_misc_book_06",
	buyPrice = 7000,
	sellPrice = 1750,
	reqLevel = 32,
}
t[16385] = {
	name = L["Grimoire of Tainted Blood (Rank 2)"],
	quality = 1,
	icon = "inv_misc_book_06",
	buyPrice = 11000,
	sellPrice = 2750,
	reqLevel = 40,
}
t[16386] = {
	name = L["Grimoire of Tainted Blood (Rank 3)"],
	quality = 1,
	icon = "inv_misc_book_06",
	buyPrice = 14000,
	sellPrice = 3500,
	reqLevel = 48,
}
t[16387] = {
	name = L["Grimoire of Tainted Blood (Rank 4)"],
	quality = 1,
	icon = "inv_misc_book_06",
	buyPrice = 22000,
	sellPrice = 5500,
	reqLevel = 56,
}
t[16388] = {
	name = L["Grimoire of Spell Lock (Rank 1)"],
	quality = 1,
	icon = "inv_misc_book_06",
	buyPrice = 9000,
	sellPrice = 2250,
	reqLevel = 36,
}
t[16389] = {
	name = L["Grimoire of Spell Lock (Rank 2)"],
	quality = 1,
	icon = "inv_misc_book_06",
	buyPrice = 18000,
	sellPrice = 4500,
	reqLevel = 52,
}
t[16390] = {
	name = L["Grimoire of Paranoia"],
	quality = 1,
	icon = "inv_misc_book_06",
	buyPrice = 11000,
	sellPrice = 2750,
	reqLevel = 42,
}
t[22182] = {
	name = L["Grimoire of Torment (Rank 7)"],
	quality = 1,
	icon = "inv_misc_book_06",
	buyPrice = 67000,
	sellPrice = 16750,
	reqLevel = 70,
}
t[22183] = {
	name = L["Grimoire of Suffering (Rank 5)"],
	quality = 1,
	icon = "inv_misc_book_06",
	buyPrice = 32000,
	sellPrice = 8000,
	reqLevel = 63,
}
t[22184] = {
	name = L["Grimoire of Consume Shadows (Rank 7)"],
	quality = 1,
	icon = "inv_misc_book_06",
	buyPrice = 44000,
	sellPrice = 11000,
	reqLevel = 66,
}
t[22185] = {
	name = L["Grimoire of Sacrifice (Rank 7)"],
	quality = 1,
	icon = "inv_misc_book_06",
	buyPrice = 36000,
	sellPrice = 9000,
	reqLevel = 64,
}
t[22186] = {
	name = L["Grimoire of Lash of Pain (Rank 7)"],
	quality = 1,
	icon = "inv_misc_book_06",
	buyPrice = 54000,
	sellPrice = 13500,
	reqLevel = 68,
}
t[22187] = {
	name = L["Grimoire of Soothing Kiss (Rank 5)"],
	quality = 1,
	icon = "inv_misc_book_06",
	buyPrice = 67000,
	sellPrice = 16750,
	reqLevel = 70,
}
t[22188] = {
	name = L["Grimoire of Devour Magic (Rank 5)"],
	quality = 1,
	icon = "inv_misc_book_06",
	buyPrice = 29000,
	sellPrice = 7250,
	reqLevel = 62,
}
t[22189] = {
	name = L["Grimoire of Devour Magic (Rank 6)"],
	quality = 1,
	icon = "inv_misc_book_06",
	buyPrice = 67000,
	sellPrice = 16750,
	reqLevel = 70,
}
t[22190] = {
	name = L["Grimoire of Tainted Blood (Rank 5)"],
	quality = 1,
	icon = "inv_misc_book_06",
	buyPrice = 36000,
	sellPrice = 9000,
	reqLevel = 64,
}
t[23711] = {
	name = L["Grimoire of Intercept (Rank 1)"],
	quality = 1,
	icon = "inv_misc_book_06",
	buyPrice = 18000,
	sellPrice = 4500,
	reqLevel = 52,
}
t[23730] = {
	name = L["Grimoire of Intercept (Rank 2)"],
	quality = 1,
	icon = "inv_misc_book_06",
	buyPrice = 26000,
	sellPrice = 6500,
	reqLevel = 61,
}
t[23731] = {
	name = L["Grimoire of Intercept (Rank 3)"],
	quality = 1,
	icon = "inv_misc_book_06",
	buyPrice = 60000,
	sellPrice = 15000,
	reqLevel = 69,
}
t[23734] = {
	name = L["Grimoire of Cleave (Rank 1)"],
	quality = 1,
	icon = "inv_misc_book_06",
	buyPrice = 15000,
	sellPrice = 3750,
	reqLevel = 50,
}
t[23745] = {
	name = L["Grimoire of Cleave (Rank 2)"],
	quality = 1,
	icon = "inv_misc_book_06",
	buyPrice = 15000,
	sellPrice = 3750,
	reqLevel = 60,
}
t[23755] = {
	name = L["Grimoire of Cleave (Rank 3)"],
	quality = 1,
	icon = "inv_misc_book_06",
	buyPrice = 60000,
	sellPrice = 15000,
	reqLevel = 68,
}
t[25469] = {
	name = L["Grimoire of Avoidance"],
	quality = 1,
	icon = "inv_misc_book_06",
	buyPrice = 26000,
	sellPrice = 6500,
	reqLevel = 60,
}
t[25900] = {
	name = L["Grimoire of Demonic Frenzy"],
	quality = 1,
	icon = "inv_misc_book_06",
	buyPrice = 22000,
	sellPrice = 5500,
	reqLevel = 56,
}
t[28068] = {
	name = L["Grimoire of Suffering (Rank 6)"],
	quality = 1,
	icon = "inv_misc_book_06",
	buyPrice = 60000,
	sellPrice = 15000,
	reqLevel = 69,
}
t[28071] = {
	name = L["Grimoire of Anguish (Rank 1)"],
	quality = 1,
	icon = "inv_misc_book_06",
	buyPrice = 15000,
	sellPrice = 3750,
	reqLevel = 50,
}
t[28072] = {
	name = L["Grimoire of Anguish (Rank 2)"],
	quality = 1,
	icon = "inv_misc_book_06",
	buyPrice = 26000,
	sellPrice = 6500,
	reqLevel = 60,
}
t[28073] = {
	name = L["Grimoire of Anguish (Rank 3)"],
	quality = 1,
	icon = "inv_misc_book_06",
	buyPrice = 67000,
	sellPrice = 16750,
	reqLevel = 70,
}
t[22250] = {
	name = L["Herb Pouch"],
	quality = 2,
	icon = "inv_misc_bag_herbpouch",
	buyPrice = 1000,
	sellPrice = 250,
	reqLevel = 0,
}
t[4536] = {
	name = L["Shiny Red Apple"],
	quality = 1,
	icon = "inv_misc_food_19",
	buyPrice = 25,
	sellPrice = 1,
	reqLevel = 1,
}
t[4537] = {
	name = L["Tel'Abim Banana"],
	quality = 1,
	icon = "inv_misc_food_24",
	buyPrice = 125,
	sellPrice = 6,
	reqLevel = 5,
}
t[4538] = {
	name = L["Snapvine Watermelon"],
	quality = 1,
	icon = "inv_misc_food_22",
	buyPrice = 500,
	sellPrice = 25,
	reqLevel = 15,
}
t[4539] = {
	name = L["Goldenbark Apple"],
	quality = 1,
	icon = "inv_misc_food_20",
	buyPrice = 1000,
	sellPrice = 50,
	reqLevel = 25,
}
t[4602] = {
	name = L["Moon Harvest Pumpkin"],
	quality = 1,
	icon = "inv_misc_food_25",
	buyPrice = 2000,
	sellPrice = 100,
	reqLevel = 35,
}
t[22776] = {
	name = L["Springpaw Appetizers"],
	quality = 1,
	icon = "inv_misc_food_18",
	buyPrice = 100,
	sellPrice = 25,
	reqLevel = 0,
}
t[22777] = {
	name = L["Bundle of Fireworks"],
	quality = 1,
	icon = "inv_misc_missilesmall_red",
	buyPrice = 150,
	sellPrice = 37,
	reqLevel = 0,
}
t[29953] = {
	name = L["Golden Dragonhawk Hatchling"],
	quality = 1,
	icon = "ability_hunter_pet_dragonhawk",
	buyPrice = 5000,
	sellPrice = 1250,
	reqLevel = 0,
}
t[29956] = {
	name = L["Red Dragonhawk Hatchling"],
	quality = 1,
	icon = "ability_hunter_pet_dragonhawk",
	buyPrice = 5000,
	sellPrice = 1250,
	reqLevel = 0,
}
t[29957] = {
	name = L["Silver Dragonhawk Hatchling"],
	quality = 1,
	icon = "ability_hunter_pet_dragonhawk",
	buyPrice = 5000,
	sellPrice = 1250,
	reqLevel = 0,
}
t[765] = {
	name = L["Silverleaf"],
	quality = 1,
	icon = "inv_misc_herb_10",
	buyPrice = 40,
	sellPrice = 10,
	reqLevel = 0,
}
t[2447] = {
	name = L["Peacebloom"],
	quality = 1,
	icon = "inv_misc_flower_02",
	buyPrice = 40,
	sellPrice = 10,
	reqLevel = 0,
}
t[2770] = {
	name = L["Copper Ore"],
	quality = 1,
	icon = "inv_ore_copper_01",
	buyPrice = 20,
	sellPrice = 5,
	reqLevel = 0,
}
t[2771] = {
	name = L["Tin Ore"],
	quality = 1,
	icon = "inv_ore_tin_01",
	buyPrice = 100,
	sellPrice = 25,
	reqLevel = 0,
}
t[2775] = {
	name = L["Silver Ore"],
	quality = 2,
	icon = "inv_stone_16",
	buyPrice = 300,
	sellPrice = 75,
	reqLevel = 0,
}
t[5771] = {
	name = L["Pattern: Red Linen Bag"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 200,
	sellPrice = 50,
	reqLevel = 0,
	profession = L["Tailoring"],
	teaches = L["Red Linen Bag"],
	learnedAt = 70,
}
t[22647] = {
	name = L["Recipe: Crunchy Spider Surprise"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 400,
	sellPrice = 100,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Crunchy Spider Surprise"],
	learnedAt = 60,
}
t[27687] = {
	name = L["Recipe: Bat Bites"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 400,
	sellPrice = 100,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Bat Bites"],
	learnedAt = 50,
}
t[29583] = {
	name = L["Sinister Scimitar"],
	quality = 2,
	icon = "inv_sword_34",
	buyPrice = 7313,
	sellPrice = 1462,
	reqLevel = 15,
}
t[29584] = {
	name = L["Throat Piercers"],
	quality = 2,
	icon = "inv_throwingknife_03",
	buyPrice = 600,
	sellPrice = 150,
	reqLevel = 14,
}
t[2509] = {
	name = L["Ornate Blunderbuss"],
	quality = 1,
	icon = "inv_weapon_rifle_02",
	buyPrice = 414,
	sellPrice = 82,
	reqLevel = 4,
}
t[2511] = {
	name = L["Hunter's Boomstick"],
	quality = 1,
	icon = "inv_weapon_rifle_04",
	buyPrice = 1324,
	sellPrice = 264,
	reqLevel = 9,
}
t[3023] = {
	name = L["Large Bore Blunderbuss"],
	quality = 1,
	icon = "inv_weapon_rifle_03",
	buyPrice = 3772,
	sellPrice = 754,
	reqLevel = 16,
}
t[5441] = {
	name = L["Small Shot Pouch"],
	quality = 1,
	icon = "inv_misc_ammo_bullet_01",
	buyPrice = 1000,
	sellPrice = 250,
	reqLevel = 1,
}
t[22985] = {
	name = L["Suncrown Hauberk"],
	quality = 2,
	icon = "inv_chest_chain",
	buyPrice = 2038,
	sellPrice = 407,
	reqLevel = 10,
}
t[22986] = {
	name = L["Apothecary's Robe"],
	quality = 2,
	icon = "inv_chest_cloth_19",
	buyPrice = 1364,
	sellPrice = 272,
	reqLevel = 10,
}
t[22987] = {
	name = L["Deathstalker's Vest"],
	quality = 2,
	icon = "inv_chest_leather_01",
	buyPrice = 1712,
	sellPrice = 342,
	reqLevel = 10,
}
t[22990] = {
	name = L["Tranquillien Champion's Cloak"],
	quality = 3,
	icon = "inv_misc_cape_07",
	buyPrice = 2883,
	sellPrice = 576,
	reqLevel = 16,
}
t[22991] = {
	name = L["Apprentice Boots"],
	quality = 2,
	icon = "inv_boots_cloth_05",
	buyPrice = 1042,
	sellPrice = 208,
	reqLevel = 10,
}
t[22992] = {
	name = L["Bogwalker Boots"],
	quality = 2,
	icon = "inv_boots_04",
	buyPrice = 1308,
	sellPrice = 261,
	reqLevel = 10,
}
t[22993] = {
	name = L["Volunteer's Greaves"],
	quality = 2,
	icon = "inv_boots_01",
	buyPrice = 1582,
	sellPrice = 316,
	reqLevel = 10,
}
t[28155] = {
	name = L["Apothecary's Waistband"],
	quality = 2,
	icon = "inv_misc_bandana_03",
	buyPrice = 965,
	sellPrice = 193,
	reqLevel = 12,
}
t[28158] = {
	name = L["Batskin Belt"],
	quality = 2,
	icon = "inv_belt_09",
	buyPrice = 1219,
	sellPrice = 243,
	reqLevel = 12,
}
t[28162] = {
	name = L["Tranquillien Defender's Girdle"],
	quality = 2,
	icon = "inv_belt_03",
	buyPrice = 1380,
	sellPrice = 276,
	reqLevel = 12,
}
t[28164] = {
	name = L["Tranquillien Flamberge"],
	quality = 2,
	icon = "inv_sword_07",
	buyPrice = 4381,
	sellPrice = 876,
	reqLevel = 10,
}
t[4604] = {
	name = L["Forest Mushroom Cap"],
	quality = 1,
	icon = "inv_mushroom_13",
	buyPrice = 25,
	sellPrice = 1,
	reqLevel = 1,
}
t[4605] = {
	name = L["Red-speckled Mushroom"],
	quality = 1,
	icon = "inv_mushroom_11",
	buyPrice = 125,
	sellPrice = 6,
	reqLevel = 5,
}
t[4606] = {
	name = L["Spongy Morel"],
	quality = 1,
	icon = "inv_mushroom_08",
	buyPrice = 500,
	sellPrice = 25,
	reqLevel = 15,
}
t[4607] = {
	name = L["Delicious Cave Mold"],
	quality = 1,
	icon = "inv_misc_herb_06",
	buyPrice = 1000,
	sellPrice = 50,
	reqLevel = 25,
}
t[4608] = {
	name = L["Raw Black Truffle"],
	quality = 1,
	icon = "inv_mushroom_03",
	buyPrice = 2000,
	sellPrice = 100,
	reqLevel = 35,
}
t[54637] = {
	name = L["Commendation of Service"],
	quality = 4,
	icon = "spell_holy_avengersshield",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[23815] = {
	name = L["Schematic: Adamantite Shell Machine"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 60000,
	sellPrice = 15000,
	reqLevel = 0,
	profession = L["Engineering"],
	teaches = L["Adamantite Shell Machine"],
	learnedAt = 335,
}
t[23816] = {
	name = L["Schematic: Fel Iron Toolbox"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 40000,
	sellPrice = 10000,
	reqLevel = 0,
	profession = L["Engineering"],
	teaches = L["Fel Iron Toolbox"],
	learnedAt = 325,
}
t[23572] = {
	name = L["Primal Nether"],
	quality = 3,
	icon = "inv_elemental_primal_nether",
	buyPrice = 0,
	sellPrice = 16000,
	reqLevel = 0,
}
t[29266] = {
	name = L["Azure-Shield of Coldarra"],
	quality = 4,
	icon = "inv_shield_33",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29267] = {
	name = L["Light-Bearer's Faith Shield"],
	quality = 4,
	icon = "inv_shield_33",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29268] = {
	name = L["Mazthoril Honor Shield"],
	quality = 4,
	icon = "inv_shield_37",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29269] = {
	name = L["Sapphiron's Wing Bone"],
	quality = 4,
	icon = "inv_misc_bone_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29270] = {
	name = L["Flametongue Seal"],
	quality = 4,
	icon = "spell_fire_sealoffire",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29271] = {
	name = L["Talisman of Kalecgos"],
	quality = 4,
	icon = "inv_offhand_outlandraid_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29272] = {
	name = L["Orb of the Soul-Eater"],
	quality = 4,
	icon = "inv_misc_orb_04",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29273] = {
	name = L["Khadgar's Knapsack"],
	quality = 4,
	icon = "inv_misc_bag_10_green",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29274] = {
	name = L["Tears of Heaven"],
	quality = 4,
	icon = "inv_potion_75",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29275] = {
	name = L["Searing Sunblade"],
	quality = 4,
	icon = "inv_knife_1h_stratholme_d_03",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29367] = {
	name = L["Ring of Cryptic Dreams"],
	quality = 4,
	icon = "inv_jewelry_ring_56",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29368] = {
	name = L["Manasurge Pendant"],
	quality = 4,
	icon = "inv_jewelry_necklace_30naxxramas",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29369] = {
	name = L["Shawl of Shifting Probabilities"],
	quality = 4,
	icon = "inv_misc_cape_16",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29370] = {
	name = L["Icon of the Silver Crescent"],
	quality = 4,
	icon = "inv_weapon_shortblade_23",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29373] = {
	name = L["Band of Halos"],
	quality = 4,
	icon = "inv_jewelry_ring_53naxxramas",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29374] = {
	name = L["Necklace of Eternal Hope"],
	quality = 4,
	icon = "inv_jewelry_necklace_31",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29375] = {
	name = L["Bishop's Cloak"],
	quality = 4,
	icon = "inv_misc_cape_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29376] = {
	name = L["Essence of the Martyr"],
	quality = 4,
	icon = "inv_valentineperfumebottle",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29379] = {
	name = L["Ring of Arathi Warlords"],
	quality = 4,
	icon = "inv_jewelry_ring_ahnqiraj_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29381] = {
	name = L["Choker of Vile Intent"],
	quality = 4,
	icon = "inv_jewelry_necklace_04",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29382] = {
	name = L["Blood Knight War Cloak"],
	quality = 4,
	icon = "inv_misc_cape_18",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29383] = {
	name = L["Bloodlust Brooch"],
	quality = 4,
	icon = "inv_misc_monsterscales_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29384] = {
	name = L["Ring of Unyielding Force"],
	quality = 4,
	icon = "inv_jewelry_ring_46",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29385] = {
	name = L["Farstrider Defender's Cloak"],
	quality = 4,
	icon = "inv_misc_cape_naxxramas_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29386] = {
	name = L["Necklace of the Juggernaut"],
	quality = 4,
	icon = "inv_jewelry_necklace_ahnqiraj_03",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29387] = {
	name = L["Gnomeregan Auto-Blocker 600"],
	quality = 4,
	icon = "inv_battery_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29388] = {
	name = L["Libram of Repentance"],
	quality = 4,
	icon = "inv_relics_libramofhope",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29389] = {
	name = L["Totem of the Pulsing Earth"],
	quality = 4,
	icon = "inv_elemental_primal_earth",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29390] = {
	name = L["Everbloom Idol"],
	quality = 4,
	icon = "inv_relics_idolofhealth",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30183] = {
	name = L["Nether Vortex"],
	quality = 4,
	icon = "inv_elemental_mote_nether",
	buyPrice = 0,
	sellPrice = 20000,
	reqLevel = 0,
}
t[30761] = {
	name = L["Infernoweave Leggings"],
	quality = 4,
	icon = "inv_pants_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30762] = {
	name = L["Infernoweave Robe"],
	quality = 4,
	icon = "inv_chest_cloth_18",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30763] = {
	name = L["Infernoweave Boots"],
	quality = 4,
	icon = "inv_boots_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30764] = {
	name = L["Infernoweave Gloves"],
	quality = 4,
	icon = "inv_gauntlets_26",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30766] = {
	name = L["Inferno Tempered Leggings"],
	quality = 4,
	icon = "inv_pants_04",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30767] = {
	name = L["Inferno Tempered Gauntlets"],
	quality = 4,
	icon = "inv_gauntlets_22",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30768] = {
	name = L["Inferno Tempered Boots"],
	quality = 4,
	icon = "inv_boots_chain_08",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30769] = {
	name = L["Inferno Tempered Chestguard"],
	quality = 4,
	icon = "inv_chest_plate08",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30770] = {
	name = L["Inferno Forged Boots"],
	quality = 4,
	icon = "inv_boots_chain_08",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30772] = {
	name = L["Inferno Forged Leggings"],
	quality = 4,
	icon = "inv_pants_mail_14",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30773] = {
	name = L["Inferno Forged Hauberk"],
	quality = 4,
	icon = "inv_chest_plate08",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30774] = {
	name = L["Inferno Forged Gloves"],
	quality = 4,
	icon = "inv_gauntlets_10",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30776] = {
	name = L["Inferno Hardened Chestguard"],
	quality = 4,
	icon = "inv_chest_leather_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30778] = {
	name = L["Inferno Hardened Leggings"],
	quality = 4,
	icon = "inv_pants_leather_18",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30779] = {
	name = L["Inferno Hardened Boots"],
	quality = 4,
	icon = "inv_boots_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30780] = {
	name = L["Inferno Hardened Gloves"],
	quality = 4,
	icon = "inv_gauntlets_26",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32083] = {
	name = L["Faceguard of Determination"],
	quality = 4,
	icon = "inv_helmet_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32084] = {
	name = L["Helmet of the Steadfast Champion"],
	quality = 4,
	icon = "inv_helmet_16",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32085] = {
	name = L["Warpstalker Helm"],
	quality = 4,
	icon = "inv_helmet_72",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32086] = {
	name = L["Storm Master's Helmet"],
	quality = 4,
	icon = "inv_helmet_69",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32087] = {
	name = L["Mask of the Deceiver"],
	quality = 4,
	icon = "inv_helmet_73",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32088] = {
	name = L["Cowl of Beastly Rage"],
	quality = 4,
	icon = "inv_helmet_38",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32089] = {
	name = L["Mana-Binders Cowl"],
	quality = 4,
	icon = "inv_helmet_30",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32090] = {
	name = L["Cowl of Naaru Blessings"],
	quality = 4,
	icon = "inv_helmet_30",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33192] = {
	name = L["Carved Witch Doctor's Stick"],
	quality = 4,
	icon = "inv_wand_23",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33207] = {
	name = L["Implacable Guardian Sabatons"],
	quality = 4,
	icon = "inv_boots_plate_10",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33222] = {
	name = L["Nyn'jah's Tabi Boots"],
	quality = 4,
	icon = "inv_boots_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33279] = {
	name = L["Iron-tusk Girdle"],
	quality = 4,
	icon = "inv_belt_27",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33280] = {
	name = L["War-Feathered Loop"],
	quality = 4,
	icon = "inv_belt_22",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33287] = {
	name = L["Gnarled Ironwood Pauldrons"],
	quality = 4,
	icon = "inv_shoulder_83",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33291] = {
	name = L["Voodoo-woven Belt"],
	quality = 4,
	icon = "inv_belt_03",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33296] = {
	name = L["Brooch of Deftness"],
	quality = 4,
	icon = "inv_jewelry_necklace_28",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33304] = {
	name = L["Cloak of Subjugated Power"],
	quality = 4,
	icon = "inv_misc_cape_20",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33324] = {
	name = L["Treads of the Life Path"],
	quality = 4,
	icon = "inv_boots_chain_13",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33325] = {
	name = L["Voodoo Shaker"],
	quality = 4,
	icon = "inv_offhand_zulaman_d_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33331] = {
	name = L["Chain of Unleashed Rage"],
	quality = 4,
	icon = "inv_belt_18",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33333] = {
	name = L["Kharmaa's Shroud of Hope"],
	quality = 4,
	icon = "inv_misc_cape_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33334] = {
	name = L["Fetish of the Primal Gods"],
	quality = 4,
	icon = "inv_offhand_zulaman_d_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33386] = {
	name = L["Man'kin'do's Belt"],
	quality = 4,
	icon = "inv_belt_22",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33484] = {
	name = L["Dory's Embrace"],
	quality = 4,
	icon = "inv_misc_cape_20",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33501] = {
	name = L["Bloodthirster's Wargreaves"],
	quality = 4,
	icon = "inv_pants_plate_28",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33502] = {
	name = L["Libram of Mending"],
	quality = 4,
	icon = "inv_relics_libramoftruth",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33503] = {
	name = L["Libram of Divine Judgement"],
	quality = 4,
	icon = "inv_relics_libramofgrace",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33504] = {
	name = L["Libram of Divine Purpose"],
	quality = 4,
	icon = "inv_relics_libramofhope",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33505] = {
	name = L["Totem of Living Water"],
	quality = 4,
	icon = "spell_frost_summonwaterelemental",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33506] = {
	name = L["Skycall Totem"],
	quality = 4,
	icon = "spell_nature_callstorm",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33507] = {
	name = L["Stonebreaker's Totem"],
	quality = 4,
	icon = "spell_nature_earthquake",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33508] = {
	name = L["Idol of Budding Life"],
	quality = 4,
	icon = "spell_nature_protectionformnature",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33509] = {
	name = L["Idol of Terror"],
	quality = 4,
	icon = "classic_ability_druid_demoralizingroar",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33510] = {
	name = L["Idol of the Unseen Moon"],
	quality = 4,
	icon = "spell_nature_sentinal",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33512] = {
	name = L["Furious Deathgrips"],
	quality = 4,
	icon = "inv_gauntlets_67",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33513] = {
	name = L["Eternium Rage-shackles"],
	quality = 4,
	icon = "inv_bracer_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33514] = {
	name = L["Pauldrons of Gruesome Fate"],
	quality = 4,
	icon = "inv_shoulder_81",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33515] = {
	name = L["Unwavering Legguards"],
	quality = 4,
	icon = "inv_pants_plate_28",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33516] = {
	name = L["Bracers of the Ancient Phalanx"],
	quality = 4,
	icon = "inv_bracer_19",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33517] = {
	name = L["Bonefist Gauntlets"],
	quality = 4,
	icon = "inv_gauntlets_67",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33518] = {
	name = L["High Justicar's Legplates"],
	quality = 4,
	icon = "inv_pants_plate_28",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33519] = {
	name = L["Handguards of the Templar"],
	quality = 4,
	icon = "inv_gauntlets_67",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33520] = {
	name = L["Vambraces of the Naaru"],
	quality = 4,
	icon = "inv_bracer_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33522] = {
	name = L["Chestguard of the Stoic Guardian"],
	quality = 4,
	icon = "inv_chest_plate_24",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33523] = {
	name = L["Sabatons of the Righteous Defender"],
	quality = 4,
	icon = "inv_boots_plate_10",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33524] = {
	name = L["Girdle of the Protector"],
	quality = 4,
	icon = "inv_belt_27",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33527] = {
	name = L["Shifting Camouflage Pants"],
	quality = 4,
	icon = "inv_pants_leather_23",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33528] = {
	name = L["Gauntlets of Sniping"],
	quality = 4,
	icon = "inv_gauntlets_25",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33529] = {
	name = L["Steadying Bracers"],
	quality = 4,
	icon = "inv_bracer_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33530] = {
	name = L["Natural Life Leggings"],
	quality = 4,
	icon = "inv_pants_mail_26",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33531] = {
	name = L["Polished Waterscale Gloves"],
	quality = 4,
	icon = "inv_gauntlets_68",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33532] = {
	name = L["Gleaming Earthen Bracers"],
	quality = 4,
	icon = "inv_bracer_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33534] = {
	name = L["Grips of Nature's Wrath"],
	quality = 4,
	icon = "inv_gauntlets_68",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33535] = {
	name = L["Earthquake Bracers"],
	quality = 4,
	icon = "inv_bracer_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33536] = {
	name = L["Stormwrap"],
	quality = 4,
	icon = "inv_belt_22",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33537] = {
	name = L["Treads of Booming Thunder"],
	quality = 4,
	icon = "inv_boots_chain_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33538] = {
	name = L["Shallow-grave Trousers"],
	quality = 4,
	icon = "inv_pants_leather_09",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33539] = {
	name = L["Trickster's Stickyfingers"],
	quality = 4,
	icon = "inv_gauntlets_50",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33540] = {
	name = L["Master Assassin Wristwraps"],
	quality = 4,
	icon = "inv_bracer_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33552] = {
	name = L["Pants of Splendid Recovery"],
	quality = 4,
	icon = "inv_pants_leather_23",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33557] = {
	name = L["Gargon's Bracers of Peaceful Slumber"],
	quality = 4,
	icon = "inv_bracer_08",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33559] = {
	name = L["Starfire Waistband"],
	quality = 4,
	icon = "inv_belt_08",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33566] = {
	name = L["Blessed Elunite Coverings"],
	quality = 4,
	icon = "inv_chest_cloth_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33577] = {
	name = L["Moon-walkers"],
	quality = 4,
	icon = "inv_boots_cloth_16",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33578] = {
	name = L["Armwraps of the Kaldorei Protector"],
	quality = 4,
	icon = "inv_bracer_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33579] = {
	name = L["Vestments of Hibernation"],
	quality = 4,
	icon = "inv_chest_leather_08",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33580] = {
	name = L["Band of the Swift Paw"],
	quality = 4,
	icon = "inv_bracer_12",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33582] = {
	name = L["Footwraps of Wild Encroachment"],
	quality = 4,
	icon = "inv_boots_wolf",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33583] = {
	name = L["Waistguard of the Great Beast"],
	quality = 4,
	icon = "inv_belt_22",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33584] = {
	name = L["Pantaloons of Arcane Annihilation"],
	quality = 4,
	icon = "inv_pants_cloth_21",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33585] = {
	name = L["Achromic Trousers of the Naaru"],
	quality = 4,
	icon = "inv_pants_plate_09",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33586] = {
	name = L["Studious Wraps"],
	quality = 4,
	icon = "inv_gauntlets_14",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33587] = {
	name = L["Light-Blessed Bonds"],
	quality = 4,
	icon = "inv_gauntlets_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33588] = {
	name = L["Runed Spell-cuffs"],
	quality = 4,
	icon = "inv_bracer_09",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33589] = {
	name = L["Wristguards of Tranquil Thought"],
	quality = 4,
	icon = "inv_bracer_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33593] = {
	name = L["Slikk's Cloak of Placation"],
	quality = 4,
	icon = "inv_misc_cape_18",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33810] = {
	name = L["Amani Mask of Death"],
	quality = 4,
	icon = "inv_helmet_114",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33832] = {
	name = L["Battlemaster's Determination"],
	quality = 4,
	icon = "ability_warrior_endlessrage",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33965] = {
	name = L["Hauberk of the Furious Elements"],
	quality = 4,
	icon = "inv_chest_mail_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33970] = {
	name = L["Pauldrons of the Furious Elements"],
	quality = 4,
	icon = "inv_shoulder_86",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33972] = {
	name = L["Mask of Primal Power"],
	quality = 4,
	icon = "inv_helmet_112",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33973] = {
	name = L["Pauldrons of Tribal Fury"],
	quality = 4,
	icon = "inv_shoulder_83",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33974] = {
	name = L["Grasp of the Moonkin"],
	quality = 4,
	icon = "inv_gauntlets_50",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34049] = {
	name = L["Battlemaster's Audacity"],
	quality = 4,
	icon = "spell_nature_focusedmind",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34050] = {
	name = L["Battlemaster's Perseverance"],
	quality = 4,
	icon = "spell_holy_heroism",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34162] = {
	name = L["Battlemaster's Depravity"],
	quality = 4,
	icon = "ability_rogue_sinistercalling",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[34163] = {
	name = L["Battlemaster's Cruelty"],
	quality = 4,
	icon = "ability_warrior_focusedrage",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35321] = {
	name = L["Cloak of Arcane Alacrity"],
	quality = 4,
	icon = "inv_misc_cape_20",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35324] = {
	name = L["Cloak of Swift Reprieve"],
	quality = 4,
	icon = "inv_misc_cape_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35326] = {
	name = L["Battlemaster's Alacrity"],
	quality = 4,
	icon = "spell_arcane_arcanetorrent",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[37934] = {
	name = L["Noble's Elementium Signet"],
	quality = 1,
	icon = "inv_jewelry_ring_72",
	buyPrice = 24000000,
	sellPrice = 50000,
	reqLevel = 0,
}
t[38082] = {
	name = L["\"Gigantique\" Bag"],
	quality = 4,
	icon = "inv_misc_bag_27",
	buyPrice = 12000000,
	sellPrice = 100000,
	reqLevel = 0,
}
t[38089] = {
	name = L["Ruby Shades"],
	quality = 1,
	icon = "inv_helmet_47",
	buyPrice = 5,
	sellPrice = 1,
	reqLevel = 0,
}
t[38090] = {
	name = L["Sapphire Pinky Ring"],
	quality = 1,
	icon = "inv_jewelry_ring_22",
	buyPrice = 6000000,
	sellPrice = 50000,
	reqLevel = 0,
}
t[38091] = {
	name = L["Gold Eternium Band"],
	quality = 1,
	icon = "inv_jewelry_ring_71",
	buyPrice = 30000000,
	sellPrice = 0,
	reqLevel = 0,
}
t[51809] = {
	name = L["Portable Hole"],
	quality = 4,
	icon = "inv_misc_shadowegg",
	buyPrice = 30000000,
	sellPrice = 250000,
	reqLevel = 0,
}
t[15903] = {
	name = L["Right-Handed Claw"],
	quality = 1,
	icon = "inv_gauntlets_07",
	buyPrice = 8118,
	sellPrice = 1623,
	reqLevel = 20,
}
t[15904] = {
	name = L["Right-Handed Blades"],
	quality = 1,
	icon = "inv_gauntlets_07",
	buyPrice = 21708,
	sellPrice = 4341,
	reqLevel = 30,
}
t[15905] = {
	name = L["Right-Handed Brass Knuckles"],
	quality = 1,
	icon = "inv_gauntlets_04",
	buyPrice = 2130,
	sellPrice = 426,
	reqLevel = 10,
}
t[15906] = {
	name = L["Left-Handed Brass Knuckles"],
	quality = 1,
	icon = "inv_gauntlets_04",
	buyPrice = 2138,
	sellPrice = 427,
	reqLevel = 10,
}
t[15907] = {
	name = L["Left-Handed Claw"],
	quality = 1,
	icon = "inv_gauntlets_07",
	buyPrice = 8237,
	sellPrice = 1647,
	reqLevel = 20,
}
t[15909] = {
	name = L["Left-Handed Blades"],
	quality = 1,
	icon = "inv_gauntlets_07",
	buyPrice = 22107,
	sellPrice = 4421,
	reqLevel = 30,
}
t[23574] = {
	name = L["Recipe: Transmute Primal Might"],
	quality = 2,
	icon = "inv_scroll_06",
	buyPrice = 80000,
	sellPrice = 20000,
	reqLevel = 0,
	profession = L["Alchemy"],
	teaches = L["Transmute: Primal Might"],
	learnedAt = 350,
}
t[25720] = {
	name = L["Pattern: Heavy Knothide Leather"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 50000,
	sellPrice = 12500,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Heavy Knothide Leather"],
	learnedAt = 325,
}
t[38518] = {
	name = L["Cro's Apple"],
	quality = 1,
	icon = "inv_misc_food_19",
	buyPrice = 150,
	sellPrice = 37,
	reqLevel = 1,
}
t[4499] = {
	name = L["Huge Brown Sack"],
	quality = 1,
	icon = "inv_misc_bag_10",
	buyPrice = 100000,
	sellPrice = 25000,
	reqLevel = 0,
}
t[21892] = {
	name = L["Pattern: Bolt of Imbued Netherweave"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 40000,
	sellPrice = 10000,
	reqLevel = 0,
	profession = L["Tailoring"],
	teaches = L["Bolt of Imbued Netherweave"],
	learnedAt = 325,
}
t[21896] = {
	name = L["Pattern: Netherweave Robe"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 40000,
	sellPrice = 10000,
	reqLevel = 0,
	profession = L["Tailoring"],
	teaches = L["Netherweave Robe"],
	learnedAt = 340,
}
t[21897] = {
	name = L["Pattern: Netherweave Tunic"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 40000,
	sellPrice = 10000,
	reqLevel = 0,
	profession = L["Tailoring"],
	teaches = L["Netherweave Tunic"],
	learnedAt = 345,
}
t[27940] = {
	name = L["Marvelous Madstone of Immortality"],
	quality = 1,
	icon = "inv_jewelry_necklace_14",
	buyPrice = 400000,
	sellPrice = 100000,
	reqLevel = 0,
}
t[27941] = {
	name = L["Compassionate Critter's Friend"],
	quality = 1,
	icon = "inv_jewelry_amulet_03",
	buyPrice = 200000,
	sellPrice = 50000,
	reqLevel = 1,
}
t[27944] = {
	name = L["Talisman of True Treasure Tracking"],
	quality = 1,
	icon = "inv_jewelry_necklace_12",
	buyPrice = 350000,
	sellPrice = 87500,
	reqLevel = 0,
}
t[27945] = {
	name = L["Shark's Tooth of Bona Fide Fluidic Mobility"],
	quality = 1,
	icon = "inv_jewelry_necklace_09",
	buyPrice = 150000,
	sellPrice = 37500,
	reqLevel = 1,
}
t[27976] = {
	name = L["Polished Pendant of Edible Energy"],
	quality = 1,
	icon = "inv_jewelry_amulet_06",
	buyPrice = 250000,
	sellPrice = 62500,
	reqLevel = 0,
}
t[27978] = {
	name = L["Soap on a Rope"],
	quality = 1,
	icon = "inv_jewelry_necklace_10",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 1,
}
t[27979] = {
	name = L["Stone of Stupendous Springing Strides"],
	quality = 1,
	icon = "inv_jewelry_necklace_16",
	buyPrice = 100000,
	sellPrice = 25000,
	reqLevel = 0,
}
t[27982] = {
	name = L["Charm of Potent and Powerful Passions"],
	quality = 1,
	icon = "inv_jewelry_talisman_01",
	buyPrice = 300000,
	sellPrice = 75000,
	reqLevel = 0,
}
t[27992] = {
	name = L["Infallible Tikbalang Ward"],
	quality = 1,
	icon = "inv_jewelry_necklace_13",
	buyPrice = 50000,
	sellPrice = 12500,
	reqLevel = 0,
}
t[34249] = {
	name = L["Hula Girl Doll"],
	quality = 1,
	icon = "inv_misc_toy_07",
	buyPrice = 1000000,
	sellPrice = 250000,
	reqLevel = 0,
}
t[5208] = {
	name = L["Smoldering Wand"],
	quality = 1,
	icon = "inv_wand_06",
	buyPrice = 3340,
	sellPrice = 668,
	reqLevel = 15,
}
t[5209] = {
	name = L["Gloom Wand"],
	quality = 1,
	icon = "inv_staff_02",
	buyPrice = 3855,
	sellPrice = 771,
	reqLevel = 16,
}
t[5210] = {
	name = L["Burning Wand"],
	quality = 1,
	icon = "inv_staff_02",
	buyPrice = 5808,
	sellPrice = 1161,
	reqLevel = 20,
}
t[5211] = {
	name = L["Dusk Wand"],
	quality = 1,
	icon = "inv_wand_07",
	buyPrice = 5830,
	sellPrice = 1166,
	reqLevel = 20,
}
t[5236] = {
	name = L["Combustible Wand"],
	quality = 1,
	icon = "inv_wand_06",
	buyPrice = 14394,
	sellPrice = 2878,
	reqLevel = 29,
}
t[5238] = {
	name = L["Pitchwood Wand"],
	quality = 1,
	icon = "inv_staff_02",
	buyPrice = 35727,
	sellPrice = 7145,
	reqLevel = 40,
}
t[5239] = {
	name = L["Blackbone Wand"],
	quality = 1,
	icon = "inv_misc_bone_01",
	buyPrice = 38731,
	sellPrice = 7746,
	reqLevel = 41,
}
t[5347] = {
	name = L["Pestilent Wand"],
	quality = 1,
	icon = "inv_wand_04",
	buyPrice = 15713,
	sellPrice = 3142,
	reqLevel = 30,
}
t[854] = {
	name = L["Quarter Staff"],
	quality = 1,
	icon = "inv_staff_17",
	buyPrice = 3023,
	sellPrice = 604,
	reqLevel = 11,
}
t[928] = {
	name = L["Long Staff"],
	quality = 1,
	icon = "inv_staff_20",
	buyPrice = 9860,
	sellPrice = 1972,
	reqLevel = 20,
}
t[2030] = {
	name = L["Gnarled Staff"],
	quality = 1,
	icon = "inv_staff_10",
	buyPrice = 5545,
	sellPrice = 1109,
	reqLevel = 15,
}
t[12252] = {
	name = L["Staff of Protection"],
	quality = 2,
	icon = "inv_staff_07",
	buyPrice = 63095,
	sellPrice = 12619,
	reqLevel = 34,
}
t[23145] = {
	name = L["Design: Royal Shadow Draenite"],
	quality = 2,
	icon = "inv_scroll_06",
	buyPrice = 50000,
	sellPrice = 12500,
	reqLevel = 0,
}
t[23149] = {
	name = L["Design: Gleaming Golden Draenite"],
	quality = 2,
	icon = "inv_scroll_06",
	buyPrice = 50000,
	sellPrice = 12500,
	reqLevel = 0,
}
t[23601] = {
	name = L["Plans: Flamebane Bracers"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 60000,
	sellPrice = 15000,
	reqLevel = 0,
	profession = L["Blacksmithing"],
	teaches = L["Flamebane Bracers"],
	learnedAt = 350,
}
t[23602] = {
	name = L["Plans: Flamebane Helm"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 60000,
	sellPrice = 15000,
	reqLevel = 0,
	profession = L["Blacksmithing"],
	teaches = L["Flamebane Helm"],
	learnedAt = 355,
}
t[23603] = {
	name = L["Plans: Flamebane Gloves"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 60000,
	sellPrice = 15000,
	reqLevel = 0,
	profession = L["Blacksmithing"],
	teaches = L["Flamebane Gloves"],
	learnedAt = 360,
}
t[23604] = {
	name = L["Plans: Flamebane Breastplate"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 80000,
	sellPrice = 20000,
	reqLevel = 0,
	profession = L["Blacksmithing"],
	teaches = L["Flamebane Breastplate"],
	learnedAt = 365,
}
t[24177] = {
	name = L["Design: Pendant of Shadow's End"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 120000,
	sellPrice = 30000,
	reqLevel = 0,
}
t[24293] = {
	name = L["Pattern: Silver Spellthread"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 60000,
	sellPrice = 15000,
	reqLevel = 0,
	profession = L["Tailoring"],
	teaches = L["Silver Spellthread"],
	learnedAt = 335,
}
t[24295] = {
	name = L["Pattern: Golden Spellthread"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 360000,
	sellPrice = 90000,
	reqLevel = 0,
	profession = L["Tailoring"],
	teaches = L["Golden Spellthread"],
	learnedAt = 375,
}
t[25721] = {
	name = L["Pattern: Vindicator's Armor Kit"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 50000,
	sellPrice = 12500,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Vindicator's Armor Kit"],
	learnedAt = 325,
}
t[29123] = {
	name = L["Medallion of the Lightbearer"],
	quality = 4,
	icon = "inv_jewelry_amulet_04",
	buyPrice = 790112,
	sellPrice = 197528,
	reqLevel = 70,
}
t[29124] = {
	name = L["Vindicator's Brand"],
	quality = 4,
	icon = "inv_sword_draenei_01",
	buyPrice = 2072720,
	sellPrice = 414544,
	reqLevel = 70,
}
t[29127] = {
	name = L["Vindicator's Hauberk"],
	quality = 3,
	icon = "inv_chest_plate02",
	buyPrice = 312042,
	sellPrice = 62408,
	reqLevel = 70,
}
t[29128] = {
	name = L["Lightwarden's Band"],
	quality = 3,
	icon = "inv_jewelry_ring_48naxxramas",
	buyPrice = 28410,
	sellPrice = 7102,
	reqLevel = 70,
}
t[29129] = {
	name = L["Anchorite's Robes"],
	quality = 3,
	icon = "inv_chest_cloth_19",
	buyPrice = 179594,
	sellPrice = 35918,
	reqLevel = 70,
}
t[29130] = {
	name = L["Auchenai Staff"],
	quality = 3,
	icon = "inv_staff_14",
	buyPrice = 563267,
	sellPrice = 112653,
	reqLevel = 70,
}
t[29689] = {
	name = L["Pattern: Flamescale Leggings"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 80000,
	sellPrice = 20000,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Flamescale Leggings"],
	learnedAt = 350,
}
t[29691] = {
	name = L["Pattern: Flamescale Boots"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 80000,
	sellPrice = 20000,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Flamescale Boots"],
	learnedAt = 350,
}
t[29693] = {
	name = L["Pattern: Flamescale Belt"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 80000,
	sellPrice = 20000,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Flamescale Belt"],
	learnedAt = 350,
}
t[29702] = {
	name = L["Pattern: Blastguard Pants"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 80000,
	sellPrice = 20000,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Blastguard Pants"],
	learnedAt = 350,
}
t[29703] = {
	name = L["Pattern: Blastguard Boots"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 80000,
	sellPrice = 20000,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Blastguard Boots"],
	learnedAt = 350,
}
t[29704] = {
	name = L["Pattern: Blastguard Belt"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 80000,
	sellPrice = 20000,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Blastguard Belt"],
	learnedAt = 350,
}
t[30842] = {
	name = L["Pattern: Flameheart Bracers"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 60000,
	sellPrice = 15000,
	reqLevel = 0,
	profession = L["Tailoring"],
	teaches = L["Flameheart Bracers"],
	learnedAt = 350,
}
t[30843] = {
	name = L["Pattern: Flameheart Gloves"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 80000,
	sellPrice = 20000,
	reqLevel = 0,
	profession = L["Tailoring"],
	teaches = L["Flameheart Gloves"],
	learnedAt = 360,
}
t[30844] = {
	name = L["Pattern: Flameheart Vest"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 100000,
	sellPrice = 25000,
	reqLevel = 0,
	profession = L["Tailoring"],
	teaches = L["Flameheart Vest"],
	learnedAt = 370,
}
t[31779] = {
	name = L["Aldor Tabard"],
	quality = 1,
	icon = "inv_shirt_guildtabard_01",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 0,
}
t[31780] = {
	name = L["Scryers Tabard"],
	quality = 1,
	icon = "inv_shirt_guildtabard_01",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 0,
}
t[22908] = {
	name = L["Recipe: Elixir of Major Firepower"],
	quality = 2,
	icon = "inv_scroll_06",
	buyPrice = 60000,
	sellPrice = 15000,
	reqLevel = 0,
	profession = L["Alchemy"],
	teaches = L["Elixir of Major Firepower"],
	learnedAt = 345,
}
t[23133] = {
	name = L["Design: Runed Blood Garnet"],
	quality = 2,
	icon = "inv_scroll_06",
	buyPrice = 60000,
	sellPrice = 15000,
	reqLevel = 0,
}
t[23143] = {
	name = L["Design: Dazzling Deep Peridot"],
	quality = 2,
	icon = "inv_scroll_06",
	buyPrice = 60000,
	sellPrice = 15000,
	reqLevel = 0,
}
t[23597] = {
	name = L["Plans: Enchanted Adamantite Belt"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 60000,
	sellPrice = 15000,
	reqLevel = 0,
	profession = L["Blacksmithing"],
	teaches = L["Enchanted Adamantite Belt"],
	learnedAt = 355,
}
t[23598] = {
	name = L["Plans: Enchanted Adamantite Boots"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 60000,
	sellPrice = 15000,
	reqLevel = 0,
	profession = L["Blacksmithing"],
	teaches = L["Enchanted Adamantite Boots"],
	learnedAt = 355,
}
t[23599] = {
	name = L["Plans: Enchanted Adamantite Breastplate"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 60000,
	sellPrice = 15000,
	reqLevel = 0,
	profession = L["Blacksmithing"],
	teaches = L["Enchanted Adamantite Breastplate"],
	learnedAt = 360,
}
t[23600] = {
	name = L["Plans: Enchanted Adamantite Leggings"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 80000,
	sellPrice = 20000,
	reqLevel = 0,
	profession = L["Blacksmithing"],
	teaches = L["Enchanted Adamantite Leggings"],
	learnedAt = 365,
}
t[24176] = {
	name = L["Design: Pendant of Withering"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 120000,
	sellPrice = 30000,
	reqLevel = 0,
}
t[24292] = {
	name = L["Pattern: Mystic Spellthread"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 60000,
	sellPrice = 15000,
	reqLevel = 0,
	profession = L["Tailoring"],
	teaches = L["Mystic Spellthread"],
	learnedAt = 335,
}
t[24294] = {
	name = L["Pattern: Runic Spellthread"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 360000,
	sellPrice = 90000,
	reqLevel = 0,
	profession = L["Tailoring"],
	teaches = L["Runic Spellthread"],
	learnedAt = 375,
}
t[25722] = {
	name = L["Pattern: Magister's Armor Kit"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 50000,
	sellPrice = 12500,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Magister's Armor Kit"],
	learnedAt = 325,
}
t[29125] = {
	name = L["Retainer's Blade"],
	quality = 4,
	icon = "inv_weapon_shortblade_29",
	buyPrice = 2080372,
	sellPrice = 416074,
	reqLevel = 70,
}
t[29126] = {
	name = L["Seer's Signet"],
	quality = 4,
	icon = "inv_jewelry_ring_52naxxramas",
	buyPrice = 790112,
	sellPrice = 197528,
	reqLevel = 70,
}
t[29131] = {
	name = L["Retainer's Leggings"],
	quality = 3,
	icon = "inv_pants_leather_18",
	buyPrice = 226120,
	sellPrice = 45224,
	reqLevel = 70,
}
t[29132] = {
	name = L["Scryer's Bloodgem"],
	quality = 3,
	icon = "inv_misc_gem_bloodstone_02",
	buyPrice = 175952,
	sellPrice = 43988,
	reqLevel = 70,
}
t[29133] = {
	name = L["Seer's Cane"],
	quality = 3,
	icon = "inv_staff_38",
	buyPrice = 569315,
	sellPrice = 113863,
	reqLevel = 70,
}
t[29134] = {
	name = L["Gauntlets of the Chosen"],
	quality = 3,
	icon = "inv_gauntlets_26",
	buyPrice = 160892,
	sellPrice = 32178,
	reqLevel = 70,
}
t[29677] = {
	name = L["Pattern: Enchanted Felscale Leggings"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 80000,
	sellPrice = 20000,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Enchanted Felscale Leggings"],
	learnedAt = 350,
}
t[29682] = {
	name = L["Pattern: Enchanted Felscale Gloves"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 80000,
	sellPrice = 20000,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Enchanted Felscale Gloves"],
	learnedAt = 350,
}
t[29684] = {
	name = L["Pattern: Enchanted Felscale Boots"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 80000,
	sellPrice = 20000,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Enchanted Felscale Boots"],
	learnedAt = 350,
}
t[29698] = {
	name = L["Pattern: Enchanted Clefthoof Leggings"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 80000,
	sellPrice = 20000,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Enchanted Clefthoof Leggings"],
	learnedAt = 350,
}
t[29700] = {
	name = L["Pattern: Enchanted Clefthoof Gloves"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 80000,
	sellPrice = 20000,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Enchanted Clefthoof Gloves"],
	learnedAt = 350,
}
t[29701] = {
	name = L["Pattern: Enchanted Clefthoof Boots"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 80000,
	sellPrice = 20000,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Enchanted Clefthoof Boots"],
	learnedAt = 350,
}
t[23799] = {
	name = L["Schematic: Adamantite Rifle"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 80000,
	sellPrice = 20000,
	reqLevel = 0,
	profession = L["Engineering"],
	teaches = L["Adamantite Rifle"],
	learnedAt = 350,
}
t[32381] = {
	name = L["Schematic: Fused Wiring"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 16000,
	sellPrice = 4000,
	reqLevel = 0,
	profession = L["Engineering"],
	teaches = L["Fused Wiring"],
	learnedAt = 275,
}
t[23590] = {
	name = L["Plans: Adamantite Maul"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 40000,
	sellPrice = 10000,
	reqLevel = 0,
	profession = L["Blacksmithing"],
	teaches = L["Adamantite Maul"],
	learnedAt = 325,
}
t[23591] = {
	name = L["Plans: Adamantite Cleaver"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 40000,
	sellPrice = 10000,
	reqLevel = 0,
	profession = L["Blacksmithing"],
	teaches = L["Adamantite Cleaver"],
	learnedAt = 330,
}
t[23592] = {
	name = L["Plans: Adamantite Dagger"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 40000,
	sellPrice = 10000,
	reqLevel = 0,
	profession = L["Blacksmithing"],
	teaches = L["Adamantite Dagger"],
	learnedAt = 330,
}
t[23593] = {
	name = L["Plans: Adamantite Rapier"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 40000,
	sellPrice = 10000,
	reqLevel = 0,
	profession = L["Blacksmithing"],
	teaches = L["Adamantite Rapier"],
	learnedAt = 335,
}
t[25846] = {
	name = L["Plans: Adamantite Rod"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 40000,
	sellPrice = 10000,
	reqLevel = 0,
	profession = L["Blacksmithing"],
	teaches = L["Adamantite Rod"],
	learnedAt = 350,
}
t[22562] = {
	name = L["Formula: Superior Mana Oil"],
	quality = 1,
	icon = "inv_misc_note_01",
	buyPrice = 50000,
	sellPrice = 12500,
	reqLevel = 0,
	profession = L["Enchanting"],
	teaches = L["Superior Mana Oil"],
	learnedAt = 310,
}
t[22563] = {
	name = L["Formula: Superior Wizard Oil"],
	quality = 1,
	icon = "inv_misc_note_01",
	buyPrice = 70000,
	sellPrice = 17500,
	reqLevel = 0,
	profession = L["Enchanting"],
	teaches = L["Superior Wizard Oil"],
	learnedAt = 340,
}
t[22565] = {
	name = L["Formula: Large Prismatic Shard"],
	quality = 1,
	icon = "inv_misc_note_01",
	buyPrice = 60000,
	sellPrice = 15000,
	reqLevel = 0,
	profession = L["Enchanting"],
	teaches = L["Large Prismatic Shard"],
	learnedAt = 335,
}
t[25849] = {
	name = L["Formula: Runed Eternium Rod"],
	quality = 1,
	icon = "inv_misc_note_01",
	buyPrice = 120000,
	sellPrice = 30000,
	reqLevel = 0,
	profession = L["Enchanting"],
	teaches = L["Runed Eternium Rod"],
	learnedAt = 375,
}
t[28282] = {
	name = L["Formula: Enchant Shield - Major Stamina"],
	quality = 1,
	icon = "inv_misc_note_01",
	buyPrice = 40000,
	sellPrice = 10000,
	reqLevel = 0,
	profession = L["Enchanting"],
	teaches = L["Enchant Shield - Major Stamina"],
	learnedAt = 325,
}
t[28486] = {
	name = L["Moser's Magnificent Muffin"],
	quality = 1,
	icon = "inv_misc_food_33",
	buyPrice = 5600,
	sellPrice = 280,
	reqLevel = 55,
}
t[30823] = {
	name = L["Demon Warding Totem"],
	quality = 1,
	icon = "spell_shadow_focusedpower",
	buyPrice = 300000,
	sellPrice = 75000,
	reqLevel = 0,
}
t[28963] = {
	name = L["Voidheart Crown"],
	quality = 4,
	icon = "inv_crown_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28964] = {
	name = L["Voidheart Robe"],
	quality = 4,
	icon = "inv_chest_cloth_43",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28966] = {
	name = L["Voidheart Leggings"],
	quality = 4,
	icon = "inv_pants_cloth_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28967] = {
	name = L["Voidheart Mantle"],
	quality = 4,
	icon = "inv_shoulder_25",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28968] = {
	name = L["Voidheart Gloves"],
	quality = 4,
	icon = "inv_gauntlets_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29011] = {
	name = L["Warbringer Greathelm"],
	quality = 4,
	icon = "inv_helmet_58",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29012] = {
	name = L["Warbringer Chestguard"],
	quality = 4,
	icon = "inv_chest_plate02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29015] = {
	name = L["Warbringer Legguards"],
	quality = 4,
	icon = "inv_pants_plate_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29016] = {
	name = L["Warbringer Shoulderguards"],
	quality = 4,
	icon = "inv_shoulder_29",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29017] = {
	name = L["Warbringer Handguards"],
	quality = 4,
	icon = "inv_gauntlets_28",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29019] = {
	name = L["Warbringer Breastplate"],
	quality = 4,
	icon = "inv_chest_plate02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29020] = {
	name = L["Warbringer Gauntlets"],
	quality = 4,
	icon = "inv_gauntlets_28",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29021] = {
	name = L["Warbringer Battle-Helm"],
	quality = 4,
	icon = "inv_helmet_58",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29022] = {
	name = L["Warbringer Greaves"],
	quality = 4,
	icon = "inv_pants_plate_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29023] = {
	name = L["Warbringer Shoulderplates"],
	quality = 4,
	icon = "inv_shoulder_29",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29028] = {
	name = L["Cyclone Headdress"],
	quality = 4,
	icon = "inv_helmet_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29029] = {
	name = L["Cyclone Hauberk"],
	quality = 4,
	icon = "inv_chest_chain_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29030] = {
	name = L["Cyclone Kilt"],
	quality = 4,
	icon = "inv_pants_mail_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29031] = {
	name = L["Cyclone Shoulderpads"],
	quality = 4,
	icon = "inv_shoulder_14",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29032] = {
	name = L["Cyclone Gloves"],
	quality = 4,
	icon = "inv_gauntlets_25",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29033] = {
	name = L["Cyclone Chestguard"],
	quality = 4,
	icon = "inv_chest_chain_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29034] = {
	name = L["Cyclone Handguards"],
	quality = 4,
	icon = "inv_gauntlets_25",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29035] = {
	name = L["Cyclone Faceguard"],
	quality = 4,
	icon = "inv_helmet_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29036] = {
	name = L["Cyclone Legguards"],
	quality = 4,
	icon = "inv_pants_mail_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29037] = {
	name = L["Cyclone Shoulderguards"],
	quality = 4,
	icon = "inv_shoulder_14",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29038] = {
	name = L["Cyclone Breastplate"],
	quality = 4,
	icon = "inv_chest_chain_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29039] = {
	name = L["Cyclone Gauntlets"],
	quality = 4,
	icon = "inv_gauntlets_25",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29040] = {
	name = L["Cyclone Helm"],
	quality = 4,
	icon = "inv_helmet_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29042] = {
	name = L["Cyclone War-Kilt"],
	quality = 4,
	icon = "inv_pants_mail_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29043] = {
	name = L["Cyclone Shoulderplates"],
	quality = 4,
	icon = "inv_shoulder_14",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29044] = {
	name = L["Netherblade Facemask"],
	quality = 4,
	icon = "inv_helmet_58",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29045] = {
	name = L["Netherblade Chestpiece"],
	quality = 4,
	icon = "inv_chest_plate02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29046] = {
	name = L["Netherblade Breeches"],
	quality = 4,
	icon = "inv_pants_plate_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29047] = {
	name = L["Netherblade Shoulderpads"],
	quality = 4,
	icon = "inv_shoulder_29",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29048] = {
	name = L["Netherblade Gloves"],
	quality = 4,
	icon = "inv_gauntlets_28",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29049] = {
	name = L["Light-Collar of the Incarnate"],
	quality = 4,
	icon = "inv_crown_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29050] = {
	name = L["Robes of the Incarnate"],
	quality = 4,
	icon = "inv_chest_cloth_43",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29053] = {
	name = L["Trousers of the Incarnate"],
	quality = 4,
	icon = "inv_pants_cloth_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29054] = {
	name = L["Light-Mantle of the Incarnate"],
	quality = 4,
	icon = "inv_shoulder_25",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29055] = {
	name = L["Handwraps of the Incarnate"],
	quality = 4,
	icon = "inv_gauntlets_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29056] = {
	name = L["Shroud of the Incarnate"],
	quality = 4,
	icon = "inv_chest_cloth_43",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29057] = {
	name = L["Gloves of the Incarnate"],
	quality = 4,
	icon = "inv_gauntlets_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29058] = {
	name = L["Soul-Collar of the Incarnate"],
	quality = 4,
	icon = "inv_crown_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29059] = {
	name = L["Leggings of the Incarnate"],
	quality = 4,
	icon = "inv_pants_cloth_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29060] = {
	name = L["Soul-Mantle of the Incarnate"],
	quality = 4,
	icon = "inv_shoulder_25",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29061] = {
	name = L["Justicar Diadem"],
	quality = 4,
	icon = "inv_helmet_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29062] = {
	name = L["Justicar Chestpiece"],
	quality = 4,
	icon = "inv_chest_chain_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29063] = {
	name = L["Justicar Leggings"],
	quality = 4,
	icon = "inv_pants_mail_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29064] = {
	name = L["Justicar Pauldrons"],
	quality = 4,
	icon = "inv_shoulder_14",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29065] = {
	name = L["Justicar Gloves"],
	quality = 4,
	icon = "inv_gauntlets_25",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29066] = {
	name = L["Justicar Chestguard"],
	quality = 4,
	icon = "inv_chest_chain_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29067] = {
	name = L["Justicar Handguards"],
	quality = 4,
	icon = "inv_gauntlets_25",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29068] = {
	name = L["Justicar Faceguard"],
	quality = 4,
	icon = "inv_helmet_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29069] = {
	name = L["Justicar Legguards"],
	quality = 4,
	icon = "inv_pants_mail_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29070] = {
	name = L["Justicar Shoulderguards"],
	quality = 4,
	icon = "inv_shoulder_14",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29071] = {
	name = L["Justicar Breastplate"],
	quality = 4,
	icon = "inv_chest_chain_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29072] = {
	name = L["Justicar Gauntlets"],
	quality = 4,
	icon = "inv_gauntlets_25",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29073] = {
	name = L["Justicar Crown"],
	quality = 4,
	icon = "inv_helmet_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29074] = {
	name = L["Justicar Greaves"],
	quality = 4,
	icon = "inv_pants_mail_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29075] = {
	name = L["Justicar Shoulderplates"],
	quality = 4,
	icon = "inv_shoulder_14",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29076] = {
	name = L["Collar of the Aldor"],
	quality = 4,
	icon = "inv_crown_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29077] = {
	name = L["Vestments of the Aldor"],
	quality = 4,
	icon = "inv_chest_cloth_43",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29078] = {
	name = L["Legwraps of the Aldor"],
	quality = 4,
	icon = "inv_pants_cloth_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29079] = {
	name = L["Pauldrons of the Aldor"],
	quality = 4,
	icon = "inv_shoulder_25",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29080] = {
	name = L["Gloves of the Aldor"],
	quality = 4,
	icon = "inv_gauntlets_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29081] = {
	name = L["Demon Stalker Greathelm"],
	quality = 4,
	icon = "inv_helmet_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29082] = {
	name = L["Demon Stalker Harness"],
	quality = 4,
	icon = "inv_chest_chain_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29083] = {
	name = L["Demon Stalker Greaves"],
	quality = 4,
	icon = "inv_pants_mail_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29084] = {
	name = L["Demon Stalker Shoulderguards"],
	quality = 4,
	icon = "inv_shoulder_14",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29085] = {
	name = L["Demon Stalker Gauntlets"],
	quality = 4,
	icon = "inv_gauntlets_25",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29086] = {
	name = L["Crown of Malorne"],
	quality = 4,
	icon = "inv_helmet_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29087] = {
	name = L["Chestguard of Malorne"],
	quality = 4,
	icon = "inv_chest_chain_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29088] = {
	name = L["Legguards of Malorne"],
	quality = 4,
	icon = "inv_pants_mail_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29089] = {
	name = L["Shoulderguards of Malorne"],
	quality = 4,
	icon = "inv_shoulder_14",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29090] = {
	name = L["Handguards of Malorne"],
	quality = 4,
	icon = "inv_gauntlets_25",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29091] = {
	name = L["Chestpiece of Malorne"],
	quality = 4,
	icon = "inv_chest_chain_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29092] = {
	name = L["Gloves of Malorne"],
	quality = 4,
	icon = "inv_gauntlets_25",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29093] = {
	name = L["Antlers of Malorne"],
	quality = 4,
	icon = "inv_helmet_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29094] = {
	name = L["Britches of Malorne"],
	quality = 4,
	icon = "inv_pants_mail_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29095] = {
	name = L["Pauldrons of Malorne"],
	quality = 4,
	icon = "inv_shoulder_14",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29096] = {
	name = L["Breastplate of Malorne"],
	quality = 4,
	icon = "inv_chest_chain_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29097] = {
	name = L["Gauntlets of Malorne"],
	quality = 4,
	icon = "inv_gauntlets_25",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29098] = {
	name = L["Stag-Helm of Malorne"],
	quality = 4,
	icon = "inv_helmet_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29099] = {
	name = L["Greaves of Malorne"],
	quality = 4,
	icon = "inv_pants_mail_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29100] = {
	name = L["Mantle of Malorne"],
	quality = 4,
	icon = "inv_shoulder_14",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28878] = {
	name = L["Inscription of Faith"],
	quality = 2,
	icon = "spell_holy_sealofsalvation",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 64,
}
t[28881] = {
	name = L["Inscription of Discipline"],
	quality = 2,
	icon = "spell_holy_sealofwisdom",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 64,
}
t[28882] = {
	name = L["Inscription of Warding"],
	quality = 2,
	icon = "spell_holy_greaterblessingofsanctuary",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 64,
}
t[28885] = {
	name = L["Inscription of Vengeance"],
	quality = 2,
	icon = "spell_holy_fistofjustice",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 64,
}
t[28886] = {
	name = L["Greater Inscription of Discipline"],
	quality = 3,
	icon = "spell_holy_sealofwisdom",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28887] = {
	name = L["Greater Inscription of Faith"],
	quality = 3,
	icon = "spell_holy_greaterblessingofsalvation",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28888] = {
	name = L["Greater Inscription of Vengeance"],
	quality = 3,
	icon = "spell_holy_greaterblessingofkings",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28889] = {
	name = L["Greater Inscription of Warding"],
	quality = 3,
	icon = "classic_spell_holy_blessingofprotection",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28903] = {
	name = L["Inscription of the Orb"],
	quality = 2,
	icon = "inv_misc_orb_04",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 64,
}
t[28904] = {
	name = L["Inscription of the Oracle"],
	quality = 2,
	icon = "spell_holy_spiritualguidence",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 64,
}
t[28907] = {
	name = L["Inscription of the Blade"],
	quality = 2,
	icon = "ability_dualwield",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 64,
}
t[28908] = {
	name = L["Inscription of the Knight"],
	quality = 2,
	icon = "spell_holy_championsbond",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 64,
}
t[28909] = {
	name = L["Greater Inscription of the Orb"],
	quality = 3,
	icon = "inv_misc_orb_03",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28910] = {
	name = L["Greater Inscription of the Blade"],
	quality = 3,
	icon = "spell_holy_weaponmastery",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28911] = {
	name = L["Greater Inscription of the Knight"],
	quality = 3,
	icon = "spell_holy_championsgrace",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28912] = {
	name = L["Greater Inscription of the Oracle"],
	quality = 3,
	icon = "spell_holy_powerinfusion",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[13517] = {
	name = L["Recipe: Alchemist's Stone"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 80000,
	sellPrice = 20000,
	reqLevel = 0,
	profession = L["Alchemy"],
	teaches = L["Alchemist's Stone"],
	learnedAt = 350,
}
t[22537] = {
	name = L["Formula: Enchant Ring - Healing Power"],
	quality = 1,
	icon = "inv_misc_note_01",
	buyPrice = 100000,
	sellPrice = 25000,
	reqLevel = 0,
	profession = L["Enchanting"],
	teaches = L["Enchant Ring - Healing Power"],
	learnedAt = 370,
}
t[22915] = {
	name = L["Recipe: Transmute Primal Air to Fire"],
	quality = 2,
	icon = "inv_scroll_06",
	buyPrice = 80000,
	sellPrice = 20000,
	reqLevel = 0,
	profession = L["Alchemy"],
	teaches = L["Transmute: Primal Air to Fire"],
	learnedAt = 350,
}
t[24182] = {
	name = L["Design: Talasite Owl"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 120000,
	sellPrice = 30000,
	reqLevel = 0,
}
t[25904] = {
	name = L["Design: Insightful Earthstorm Diamond"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 120000,
	sellPrice = 30000,
	reqLevel = 0,
}
t[28273] = {
	name = L["Formula: Enchant Gloves - Major Healing"],
	quality = 2,
	icon = "inv_misc_note_01",
	buyPrice = 60000,
	sellPrice = 15000,
	reqLevel = 0,
	profession = L["Enchanting"],
	teaches = L["Enchant Gloves - Major Healing"],
	learnedAt = 350,
}
t[28281] = {
	name = L["Formula: Enchant Weapon - Major Healing"],
	quality = 2,
	icon = "inv_misc_note_01",
	buyPrice = 60000,
	sellPrice = 15000,
	reqLevel = 0,
	profession = L["Enchanting"],
	teaches = L["Enchant Weapon - Major Healing"],
	learnedAt = 350,
}
t[29175] = {
	name = L["Gavel of Pure Light"],
	quality = 4,
	icon = "inv_hammer_04",
	buyPrice = 2003650,
	sellPrice = 400730,
	reqLevel = 70,
}
t[29176] = {
	name = L["Crest of the Sha'tar"],
	quality = 4,
	icon = "inv_shield_30",
	buyPrice = 1344928,
	sellPrice = 268985,
	reqLevel = 70,
}
t[29177] = {
	name = L["A'dal's Command"],
	quality = 4,
	icon = "inv_jewelry_ring_48naxxramas",
	buyPrice = 790112,
	sellPrice = 197528,
	reqLevel = 70,
}
t[29179] = {
	name = L["Xi'ri's Gift"],
	quality = 3,
	icon = "inv_misc_elvencoins",
	buyPrice = 175952,
	sellPrice = 43988,
	reqLevel = 70,
}
t[29180] = {
	name = L["Blessed Scale Girdle"],
	quality = 3,
	icon = "inv_belt_08",
	buyPrice = 130288,
	sellPrice = 26057,
	reqLevel = 70,
}
t[29191] = {
	name = L["Arcanum of Power"],
	quality = 2,
	icon = "spell_nature_lightningoverload",
	buyPrice = 1000000,
	sellPrice = 250000,
	reqLevel = 70,
}
t[29195] = {
	name = L["Arcanum of Arcane Warding"],
	quality = 2,
	icon = "spell_arcane_arcaneresilience",
	buyPrice = 1000000,
	sellPrice = 250000,
	reqLevel = 70,
}
t[29717] = {
	name = L["Pattern: Drums of Battle"],
	quality = 1,
	icon = "inv_scroll_05",
	buyPrice = 120000,
	sellPrice = 30000,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Drums of Battle"],
	learnedAt = 365,
}
t[30634] = {
	name = L["Warpforged Key"],
	quality = 1,
	icon = "inv_misc_key_09",
	buyPrice = 100000,
	sellPrice = 25000,
	reqLevel = 0,
}
t[30826] = {
	name = L["Design: Ring of Arcane Shielding"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 120000,
	sellPrice = 30000,
	reqLevel = 0,
}
t[31354] = {
	name = L["Recipe: Flask of the Titans"],
	quality = 2,
	icon = "inv_scroll_06",
	buyPrice = 40000,
	sellPrice = 10000,
	reqLevel = 0,
	profession = L["Alchemy"],
	teaches = L["Flask of the Titans"],
	learnedAt = 300,
}
t[31781] = {
	name = L["Sha'tar Tabard"],
	quality = 1,
	icon = "inv_shirt_guildtabard_01",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 0,
}
t[33153] = {
	name = L["Formula: Enchant Gloves - Threat"],
	quality = 3,
	icon = "inv_misc_note_01",
	buyPrice = 100000,
	sellPrice = 25000,
	reqLevel = 0,
	profession = L["Enchanting"],
	teaches = L["Enchant Gloves - Threat"],
	learnedAt = 300,
}
t[33155] = {
	name = L["Design: Kailee's Rose"],
	quality = 1,
	icon = "inv_scroll_05",
	buyPrice = 120000,
	sellPrice = 30000,
	reqLevel = 0,
}
t[33159] = {
	name = L["Design: Blood of Amber"],
	quality = 1,
	icon = "inv_scroll_05",
	buyPrice = 120000,
	sellPrice = 30000,
	reqLevel = 0,
}
t[35330] = {
	name = L["Dreadweave Leggings"],
	quality = 3,
	icon = "inv_pants_cloth_05",
	buyPrice = 175195,
	sellPrice = 35039,
	reqLevel = 70,
}
t[35333] = {
	name = L["Mooncloth Cowl"],
	quality = 3,
	icon = "inv_helmet_30",
	buyPrice = 132848,
	sellPrice = 26569,
	reqLevel = 70,
}
t[35341] = {
	name = L["Satin Mantle"],
	quality = 3,
	icon = "inv_shoulder_02",
	buyPrice = 136728,
	sellPrice = 27345,
	reqLevel = 70,
}
t[35345] = {
	name = L["Evoker's Silk Handguards"],
	quality = 3,
	icon = "inv_gauntlets_19",
	buyPrice = 85970,
	sellPrice = 17194,
	reqLevel = 70,
}
t[35368] = {
	name = L["Opportunist's Leather Legguards"],
	quality = 3,
	icon = "inv_pants_cloth_05",
	buyPrice = 217323,
	sellPrice = 43464,
	reqLevel = 70,
}
t[35380] = {
	name = L["Stalker's Chain Spaulders"],
	quality = 3,
	icon = "inv_shoulder_29",
	buyPrice = 190594,
	sellPrice = 38118,
	reqLevel = 70,
}
t[35381] = {
	name = L["Seer's Linked Armor"],
	quality = 3,
	icon = "inv_chest_chain_11",
	buyPrice = 253978,
	sellPrice = 50795,
	reqLevel = 70,
}
t[35388] = {
	name = L["Seer's Mail Helm"],
	quality = 3,
	icon = "inv_helmet_09",
	buyPrice = 195570,
	sellPrice = 39114,
	reqLevel = 70,
}
t[35395] = {
	name = L["Seer's Ringmail Shoulderpads"],
	quality = 3,
	icon = "inv_shoulder_29",
	buyPrice = 206818,
	sellPrice = 41363,
	reqLevel = 70,
}
t[185692] = {
	name = L["Warpforged Key"],
	quality = 1,
	icon = "inv_misc_key_09",
	buyPrice = 100000,
	sellPrice = 25000,
	reqLevel = 0,
}
t[185926] = {
	name = L["Pattern: Greater Drums of Battle"],
	quality = 3,
	icon = "inv_scroll_04",
	buyPrice = 120000,
	sellPrice = 30000,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Greater Drums of Battle"],
	learnedAt = 365,
}
t[22538] = {
	name = L["Formula: Enchant Ring - Stats"],
	quality = 1,
	icon = "inv_misc_note_01",
	buyPrice = 200000,
	sellPrice = 50000,
	reqLevel = 0,
	profession = L["Enchanting"],
	teaches = L["Enchant Ring - Stats"],
	learnedAt = 375,
}
t[22910] = {
	name = L["Recipe: Elixir of Major Shadow Power"],
	quality = 2,
	icon = "inv_scroll_06",
	buyPrice = 80000,
	sellPrice = 20000,
	reqLevel = 0,
	profession = L["Alchemy"],
	teaches = L["Elixir of Major Shadow Power"],
	learnedAt = 350,
}
t[23138] = {
	name = L["Design: Potent Flame Spessarite"],
	quality = 2,
	icon = "inv_scroll_06",
	buyPrice = 60000,
	sellPrice = 15000,
	reqLevel = 0,
}
t[24175] = {
	name = L["Design: Pendant of Thawing"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 120000,
	sellPrice = 30000,
	reqLevel = 0,
}
t[24179] = {
	name = L["Design: Felsteel Boar"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 120000,
	sellPrice = 30000,
	reqLevel = 0,
}
t[29199] = {
	name = L["Arcanum of Shadow Warding"],
	quality = 2,
	icon = "spell_shadow_sealofkings",
	buyPrice = 1000000,
	sellPrice = 250000,
	reqLevel = 70,
}
t[30633] = {
	name = L["Auchenai Key"],
	quality = 1,
	icon = "inv_misc_key_11",
	buyPrice = 100000,
	sellPrice = 25000,
	reqLevel = 0,
}
t[30830] = {
	name = L["Trident of the Outcast Tribe"],
	quality = 4,
	icon = "inv_spear_04",
	buyPrice = 2505080,
	sellPrice = 501016,
	reqLevel = 70,
}
t[30832] = {
	name = L["Gavel of Unearthed Secrets"],
	quality = 4,
	icon = "inv_hammer_08",
	buyPrice = 504841,
	sellPrice = 100968,
	reqLevel = 70,
}
t[30833] = {
	name = L["Pattern: Cloak of Arcane Evasion"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 60000,
	sellPrice = 15000,
	reqLevel = 0,
	profession = L["Tailoring"],
	teaches = L["Cloak of Arcane Evasion"],
	learnedAt = 350,
}
t[30834] = {
	name = L["Shapeshifter's Signet"],
	quality = 4,
	icon = "inv_jewelry_ring_41",
	buyPrice = 197528,
	sellPrice = 49382,
	reqLevel = 70,
}
t[30835] = {
	name = L["Salvager's Hauberk"],
	quality = 3,
	icon = "inv_chest_plate08",
	buyPrice = 260629,
	sellPrice = 52125,
	reqLevel = 70,
}
t[30836] = {
	name = L["Leggings of the Skettis Exile"],
	quality = 3,
	icon = "inv_pants_cloth_09",
	buyPrice = 174403,
	sellPrice = 34880,
	reqLevel = 70,
}
t[30841] = {
	name = L["Lower City Prayerbook"],
	quality = 3,
	icon = "inv_misc_book_11",
	buyPrice = 175952,
	sellPrice = 43988,
	reqLevel = 70,
}
t[30846] = {
	name = L["Arcanum of the Outcast"],
	quality = 2,
	icon = "ability_rogue_masterofsubtlety",
	buyPrice = 1000000,
	sellPrice = 250000,
	reqLevel = 70,
}
t[31357] = {
	name = L["Recipe: Flask of Chromatic Resistance"],
	quality = 2,
	icon = "inv_scroll_06",
	buyPrice = 40000,
	sellPrice = 10000,
	reqLevel = 0,
	profession = L["Alchemy"],
	teaches = L["Flask of Chromatic Resistance"],
	learnedAt = 300,
}
t[31778] = {
	name = L["Lower City Tabard"],
	quality = 1,
	icon = "inv_shirt_guildtabard_01",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 0,
}
t[33148] = {
	name = L["Formula: Enchant Cloak - Dodge"],
	quality = 3,
	icon = "inv_misc_note_01",
	buyPrice = 100000,
	sellPrice = 25000,
	reqLevel = 0,
	profession = L["Enchanting"],
	teaches = L["Enchant Cloak - Dodge"],
	learnedAt = 300,
}
t[33157] = {
	name = L["Design: Falling Star"],
	quality = 1,
	icon = "inv_scroll_05",
	buyPrice = 120000,
	sellPrice = 30000,
	reqLevel = 0,
}
t[34200] = {
	name = L["Pattern: Quiver of a Thousand Feathers"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 160000,
	sellPrice = 40000,
	reqLevel = 0,
}
t[35331] = {
	name = L["Dreadweave Mantle"],
	quality = 3,
	icon = "inv_shoulder_02",
	buyPrice = 131885,
	sellPrice = 26377,
	reqLevel = 70,
}
t[35335] = {
	name = L["Mooncloth Mitts"],
	quality = 3,
	icon = "inv_gauntlets_15",
	buyPrice = 89216,
	sellPrice = 17843,
	reqLevel = 70,
}
t[35340] = {
	name = L["Satin Leggings"],
	quality = 3,
	icon = "inv_pants_cloth_05",
	buyPrice = 181670,
	sellPrice = 36334,
	reqLevel = 70,
}
t[35344] = {
	name = L["Evoker's Silk Cowl"],
	quality = 3,
	icon = "inv_helmet_08",
	buyPrice = 128467,
	sellPrice = 25693,
	reqLevel = 70,
}
t[35370] = {
	name = L["Opportunist's Leather Tunic"],
	quality = 3,
	icon = "inv_chest_leather_03",
	buyPrice = 218950,
	sellPrice = 43790,
	reqLevel = 70,
}
t[35378] = {
	name = L["Stalker's Chain Helm"],
	quality = 3,
	icon = "inv_helmet_09",
	buyPrice = 188286,
	sellPrice = 37657,
	reqLevel = 70,
}
t[35382] = {
	name = L["Seer's Linked Gauntlets"],
	quality = 3,
	icon = "inv_gauntlets_11",
	buyPrice = 127464,
	sellPrice = 25492,
	reqLevel = 70,
}
t[35389] = {
	name = L["Seer's Mail Leggings"],
	quality = 3,
	icon = "inv_pants_mail_15",
	buyPrice = 261737,
	sellPrice = 52347,
	reqLevel = 70,
}
t[35391] = {
	name = L["Seer's Ringmail Chestguard"],
	quality = 3,
	icon = "inv_chest_chain_11",
	buyPrice = 263664,
	sellPrice = 52732,
	reqLevel = 70,
}
t[185691] = {
	name = L["Auchenai Key"],
	quality = 1,
	icon = "inv_misc_key_11",
	buyPrice = 100000,
	sellPrice = 25000,
	reqLevel = 0,
}
t[30113] = {
	name = L["Destroyer Chestguard"],
	quality = 4,
	icon = "inv_chest_plate02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30114] = {
	name = L["Destroyer Handguards"],
	quality = 4,
	icon = "inv_gauntlets_28",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30115] = {
	name = L["Destroyer Greathelm"],
	quality = 4,
	icon = "inv_helmet_58",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30116] = {
	name = L["Destroyer Legguards"],
	quality = 4,
	icon = "inv_pants_plate_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30117] = {
	name = L["Destroyer Shoulderguards"],
	quality = 4,
	icon = "inv_shoulder_29",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30118] = {
	name = L["Destroyer Breastplate"],
	quality = 4,
	icon = "inv_chest_plate02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30119] = {
	name = L["Destroyer Gauntlets"],
	quality = 4,
	icon = "inv_gauntlets_28",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30120] = {
	name = L["Destroyer Battle-Helm"],
	quality = 4,
	icon = "inv_helmet_58",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30121] = {
	name = L["Destroyer Greaves"],
	quality = 4,
	icon = "inv_pants_plate_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30122] = {
	name = L["Destroyer Shoulderblades"],
	quality = 4,
	icon = "inv_shoulder_29",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30123] = {
	name = L["Crystalforge Chestguard"],
	quality = 4,
	icon = "inv_chest_chain_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30124] = {
	name = L["Crystalforge Handguards"],
	quality = 4,
	icon = "inv_gauntlets_25",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30125] = {
	name = L["Crystalforge Faceguard"],
	quality = 4,
	icon = "inv_helmet_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30126] = {
	name = L["Crystalforge Legguards"],
	quality = 4,
	icon = "inv_pants_mail_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30127] = {
	name = L["Crystalforge Shoulderguards"],
	quality = 4,
	icon = "inv_shoulder_14",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30129] = {
	name = L["Crystalforge Breastplate"],
	quality = 4,
	icon = "inv_chest_chain_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30130] = {
	name = L["Crystalforge Gauntlets"],
	quality = 4,
	icon = "inv_gauntlets_25",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30131] = {
	name = L["Crystalforge War-Helm"],
	quality = 4,
	icon = "inv_helmet_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30132] = {
	name = L["Crystalforge Greaves"],
	quality = 4,
	icon = "inv_pants_mail_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30133] = {
	name = L["Crystalforge Shoulderbraces"],
	quality = 4,
	icon = "inv_shoulder_14",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30134] = {
	name = L["Crystalforge Chestpiece"],
	quality = 4,
	icon = "inv_chest_chain_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30135] = {
	name = L["Crystalforge Gloves"],
	quality = 4,
	icon = "inv_gauntlets_25",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30136] = {
	name = L["Crystalforge Greathelm"],
	quality = 4,
	icon = "inv_helmet_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30137] = {
	name = L["Crystalforge Leggings"],
	quality = 4,
	icon = "inv_pants_mail_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30138] = {
	name = L["Crystalforge Pauldrons"],
	quality = 4,
	icon = "inv_shoulder_14",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30139] = {
	name = L["Rift Stalker Hauberk"],
	quality = 4,
	icon = "inv_chest_chain_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30140] = {
	name = L["Rift Stalker Gauntlets"],
	quality = 4,
	icon = "inv_gauntlets_25",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30141] = {
	name = L["Rift Stalker Helm"],
	quality = 4,
	icon = "inv_helmet_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30142] = {
	name = L["Rift Stalker Leggings"],
	quality = 4,
	icon = "inv_pants_mail_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30143] = {
	name = L["Rift Stalker Mantle"],
	quality = 4,
	icon = "inv_shoulder_14",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30144] = {
	name = L["Deathmantle Chestguard"],
	quality = 4,
	icon = "inv_chest_plate02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30145] = {
	name = L["Deathmantle Handguards"],
	quality = 4,
	icon = "inv_gauntlets_28",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30146] = {
	name = L["Deathmantle Helm"],
	quality = 4,
	icon = "inv_helmet_58",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30148] = {
	name = L["Deathmantle Legguards"],
	quality = 4,
	icon = "inv_pants_plate_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30149] = {
	name = L["Deathmantle Shoulderpads"],
	quality = 4,
	icon = "inv_shoulder_29",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30150] = {
	name = L["Vestments of the Avatar"],
	quality = 4,
	icon = "inv_chest_cloth_43",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30151] = {
	name = L["Gloves of the Avatar"],
	quality = 4,
	icon = "inv_gauntlets_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30152] = {
	name = L["Cowl of the Avatar"],
	quality = 4,
	icon = "inv_crown_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30153] = {
	name = L["Breeches of the Avatar"],
	quality = 4,
	icon = "inv_pants_cloth_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30154] = {
	name = L["Mantle of the Avatar"],
	quality = 4,
	icon = "inv_shoulder_25",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30159] = {
	name = L["Shroud of the Avatar"],
	quality = 4,
	icon = "inv_chest_cloth_43",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30160] = {
	name = L["Handguards of the Avatar"],
	quality = 4,
	icon = "inv_gauntlets_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30161] = {
	name = L["Hood of the Avatar"],
	quality = 4,
	icon = "inv_crown_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30162] = {
	name = L["Leggings of the Avatar"],
	quality = 4,
	icon = "inv_pants_cloth_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30163] = {
	name = L["Wings of the Avatar"],
	quality = 4,
	icon = "inv_shoulder_25",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30164] = {
	name = L["Cataclysm Chestguard"],
	quality = 4,
	icon = "inv_chest_plate08",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30165] = {
	name = L["Cataclysm Gloves"],
	quality = 4,
	icon = "inv_gauntlets_25",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30166] = {
	name = L["Cataclysm Headguard"],
	quality = 4,
	icon = "inv_helmet_54",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30167] = {
	name = L["Cataclysm Legguards"],
	quality = 4,
	icon = "inv_pants_mail_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30168] = {
	name = L["Cataclysm Shoulderguards"],
	quality = 4,
	icon = "inv_shoulder_14",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30169] = {
	name = L["Cataclysm Chestpiece"],
	quality = 4,
	icon = "inv_chest_plate08",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30170] = {
	name = L["Cataclysm Handgrips"],
	quality = 4,
	icon = "inv_gauntlets_25",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30171] = {
	name = L["Cataclysm Headpiece"],
	quality = 4,
	icon = "inv_helmet_54",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30172] = {
	name = L["Cataclysm Leggings"],
	quality = 4,
	icon = "inv_pants_mail_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30173] = {
	name = L["Cataclysm Shoulderpads"],
	quality = 4,
	icon = "inv_shoulder_14",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30185] = {
	name = L["Cataclysm Chestplate"],
	quality = 4,
	icon = "inv_chest_plate08",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30189] = {
	name = L["Cataclysm Gauntlets"],
	quality = 4,
	icon = "inv_gauntlets_25",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30190] = {
	name = L["Cataclysm Helm"],
	quality = 4,
	icon = "inv_helmet_54",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30192] = {
	name = L["Cataclysm Legplates"],
	quality = 4,
	icon = "inv_pants_mail_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30194] = {
	name = L["Cataclysm Shoulderplates"],
	quality = 4,
	icon = "inv_shoulder_14",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30196] = {
	name = L["Robes of Tirisfal"],
	quality = 4,
	icon = "inv_chest_cloth_43",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30205] = {
	name = L["Gloves of Tirisfal"],
	quality = 4,
	icon = "inv_gauntlets_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30206] = {
	name = L["Cowl of Tirisfal"],
	quality = 4,
	icon = "inv_crown_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30207] = {
	name = L["Leggings of Tirisfal"],
	quality = 4,
	icon = "inv_pants_cloth_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30210] = {
	name = L["Mantle of Tirisfal"],
	quality = 4,
	icon = "inv_shoulder_25",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30211] = {
	name = L["Gloves of the Corruptor"],
	quality = 4,
	icon = "inv_gauntlets_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30212] = {
	name = L["Hood of the Corruptor"],
	quality = 4,
	icon = "inv_crown_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30213] = {
	name = L["Leggings of the Corruptor"],
	quality = 4,
	icon = "inv_pants_cloth_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30214] = {
	name = L["Robe of the Corruptor"],
	quality = 4,
	icon = "inv_chest_cloth_43",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30215] = {
	name = L["Mantle of the Corruptor"],
	quality = 4,
	icon = "inv_shoulder_25",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30216] = {
	name = L["Nordrassil Chestguard"],
	quality = 4,
	icon = "inv_chest_chain_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30217] = {
	name = L["Nordrassil Gloves"],
	quality = 4,
	icon = "inv_gauntlets_25",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30219] = {
	name = L["Nordrassil Headguard"],
	quality = 4,
	icon = "inv_helmet_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30220] = {
	name = L["Nordrassil Life-Kilt"],
	quality = 4,
	icon = "inv_pants_mail_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30221] = {
	name = L["Nordrassil Life-Mantle"],
	quality = 4,
	icon = "inv_shoulder_14",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30222] = {
	name = L["Nordrassil Chestplate"],
	quality = 4,
	icon = "inv_chest_chain_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30223] = {
	name = L["Nordrassil Handgrips"],
	quality = 4,
	icon = "inv_gauntlets_25",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30228] = {
	name = L["Nordrassil Headdress"],
	quality = 4,
	icon = "inv_helmet_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30229] = {
	name = L["Nordrassil Feral-Kilt"],
	quality = 4,
	icon = "inv_pants_mail_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30230] = {
	name = L["Nordrassil Feral-Mantle"],
	quality = 4,
	icon = "inv_shoulder_14",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30231] = {
	name = L["Nordrassil Chestpiece"],
	quality = 4,
	icon = "inv_chest_chain_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30232] = {
	name = L["Nordrassil Gauntlets"],
	quality = 4,
	icon = "inv_gauntlets_25",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30233] = {
	name = L["Nordrassil Headpiece"],
	quality = 4,
	icon = "inv_helmet_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30234] = {
	name = L["Nordrassil Wrath-Kilt"],
	quality = 4,
	icon = "inv_pants_mail_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30235] = {
	name = L["Nordrassil Wrath-Mantle"],
	quality = 4,
	icon = "inv_shoulder_14",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[21895] = {
	name = L["Pattern: Primal Mooncloth"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 40000,
	sellPrice = 10000,
	reqLevel = 0,
	profession = L["Tailoring"],
	teaches = L["Primal Mooncloth"],
	learnedAt = 350,
}
t[21916] = {
	name = L["Pattern: Primal Mooncloth Belt"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 60000,
	sellPrice = 15000,
	reqLevel = 0,
	profession = L["Tailoring"],
	teaches = L["Primal Mooncloth Belt"],
	learnedAt = 355,
}
t[21917] = {
	name = L["Pattern: Primal Mooncloth Robe"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 60000,
	sellPrice = 15000,
	reqLevel = 0,
	profession = L["Tailoring"],
	teaches = L["Primal Mooncloth Robe"],
	learnedAt = 375,
}
t[21918] = {
	name = L["Pattern: Primal Mooncloth Shoulders"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 60000,
	sellPrice = 15000,
	reqLevel = 0,
	profession = L["Tailoring"],
	teaches = L["Primal Mooncloth Shoulders"],
	learnedAt = 365,
}
t[21919] = {
	name = L["Pattern: Primal Mooncloth Bag"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 60000,
	sellPrice = 15000,
	reqLevel = 0,
	profession = L["Tailoring"],
	teaches = L["Primal Mooncloth Bag"],
	learnedAt = 375,
}
t[21912] = {
	name = L["Pattern: Frozen Shadoweave Shoulders"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 60000,
	sellPrice = 15000,
	reqLevel = 0,
	profession = L["Tailoring"],
	teaches = L["Frozen Shadoweave Shoulders"],
	learnedAt = 355,
}
t[21913] = {
	name = L["Pattern: Frozen Shadoweave Robe"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 60000,
	sellPrice = 15000,
	reqLevel = 0,
	profession = L["Tailoring"],
	teaches = L["Frozen Shadoweave Robe"],
	learnedAt = 375,
}
t[21914] = {
	name = L["Pattern: Frozen Shadoweave Boots"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 60000,
	sellPrice = 15000,
	reqLevel = 0,
	profession = L["Tailoring"],
	teaches = L["Frozen Shadoweave Boots"],
	learnedAt = 365,
}
t[21915] = {
	name = L["Pattern: Ebon Shadowbag"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 60000,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Tailoring"],
	teaches = L["Ebon Shadowbag"],
	learnedAt = 375,
}
t[30483] = {
	name = L["Pattern: Shadowcloth"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 40000,
	sellPrice = 10000,
	reqLevel = 0,
	profession = L["Tailoring"],
	teaches = L["Shadowcloth"],
	learnedAt = 350,
}
t[21908] = {
	name = L["Pattern: Spellfire Belt"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 60000,
	sellPrice = 15000,
	reqLevel = 0,
	profession = L["Tailoring"],
	teaches = L["Spellfire Belt"],
	learnedAt = 355,
}
t[21909] = {
	name = L["Pattern: Spellfire Gloves"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 60000,
	sellPrice = 15000,
	reqLevel = 0,
	profession = L["Tailoring"],
	teaches = L["Spellfire Gloves"],
	learnedAt = 365,
}
t[21910] = {
	name = L["Pattern: Spellfire Robe"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 60000,
	sellPrice = 15000,
	reqLevel = 0,
	profession = L["Tailoring"],
	teaches = L["Spellfire Robe"],
	learnedAt = 375,
}
t[21911] = {
	name = L["Pattern: Spellfire Bag"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 60000,
	sellPrice = 15000,
	reqLevel = 0,
	profession = L["Tailoring"],
	teaches = L["Spellfire Bag"],
	learnedAt = 375,
}
t[24316] = {
	name = L["Pattern: Spellcloth"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 40000,
	sellPrice = 10000,
	reqLevel = 0,
	profession = L["Tailoring"],
	teaches = L["Spellcloth"],
	learnedAt = 350,
}
t[17194] = {
	name = L["Holiday Spices"],
	quality = 1,
	icon = "inv_misc_bag_11",
	buyPrice = 10,
	sellPrice = 0,
	reqLevel = 0,
}
t[17196] = {
	name = L["Holiday Spirits"],
	quality = 1,
	icon = "inv_drink_10",
	buyPrice = 50,
	sellPrice = 12,
	reqLevel = 1,
}
t[17200] = {
	name = L["Recipe: Gingerbread Cookie"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 25,
	sellPrice = 6,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Gingerbread Cookie"],
	learnedAt = 1,
}
t[17201] = {
	name = L["Recipe: Egg Nog"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 240,
	sellPrice = 60,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Egg Nog"],
	learnedAt = 35,
}
t[17202] = {
	name = L["Snowball"],
	quality = 1,
	icon = "inv_ammo_snowball",
	buyPrice = 10,
	sellPrice = 0,
	reqLevel = 0,
}
t[17303] = {
	name = L["Blue Ribboned Wrapping Paper"],
	quality = 1,
	icon = "inv_holiday_christmas_wrapping_03",
	buyPrice = 10,
	sellPrice = 2,
	reqLevel = 0,
}
t[17304] = {
	name = L["Green Ribboned Wrapping Paper"],
	quality = 1,
	icon = "inv_holiday_christmas_wrapping_01",
	buyPrice = 10,
	sellPrice = 2,
	reqLevel = 0,
}
t[17307] = {
	name = L["Purple Ribboned Wrapping Paper"],
	quality = 1,
	icon = "inv_holiday_christmas_wrapping_02",
	buyPrice = 10,
	sellPrice = 2,
	reqLevel = 0,
}
t[17344] = {
	name = L["Candy Cane"],
	quality = 1,
	icon = "inv_misc_food_61",
	buyPrice = 25,
	sellPrice = 1,
	reqLevel = 1,
}
t[17402] = {
	name = L["Greatfather's Winter Ale"],
	quality = 1,
	icon = "inv_drink_13",
	buyPrice = 2000,
	sellPrice = 500,
	reqLevel = 0,
}
t[17403] = {
	name = L["Steamwheedle Fizzy Spirits"],
	quality = 1,
	icon = "inv_drink_11",
	buyPrice = 150,
	sellPrice = 37,
	reqLevel = 0,
}
t[17404] = {
	name = L["Blended Bean Brew"],
	quality = 1,
	icon = "inv_drink_15",
	buyPrice = 125,
	sellPrice = 6,
	reqLevel = 5,
}
t[17405] = {
	name = L["Green Garden Tea"],
	quality = 1,
	icon = "inv_drink_milk_05",
	buyPrice = 1000,
	sellPrice = 50,
	reqLevel = 25,
}
t[17406] = {
	name = L["Holiday Cheesewheel"],
	quality = 1,
	icon = "inv_misc_food_03",
	buyPrice = 125,
	sellPrice = 6,
	reqLevel = 5,
}
t[17407] = {
	name = L["Graccu's Homemade Meat Pie"],
	quality = 1,
	icon = "inv_misc_food_10",
	buyPrice = 1000,
	sellPrice = 50,
	reqLevel = 25,
}
t[17408] = {
	name = L["Spicy Beefstick"],
	quality = 1,
	icon = "inv_misc_food_49",
	buyPrice = 2000,
	sellPrice = 100,
	reqLevel = 35,
}
t[34410] = {
	name = L["Honeyed Holiday Ham"],
	quality = 1,
	icon = "inv_misc_food_99",
	buyPrice = 4000,
	sellPrice = 200,
	reqLevel = 65,
}
t[34412] = {
	name = L["Sparkling Apple Cider"],
	quality = 1,
	icon = "inv_drink_22",
	buyPrice = 1000,
	sellPrice = 50,
	reqLevel = 35,
}
t[32898] = {
	name = L["Shattrath Flask of Fortification"],
	quality = 1,
	icon = "inv_potion_119",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32899] = {
	name = L["Shattrath Flask of Mighty Restoration"],
	quality = 1,
	icon = "inv_potion_118",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32900] = {
	name = L["Shattrath Flask of Supreme Power"],
	quality = 1,
	icon = "inv_potion_41",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[32901] = {
	name = L["Shattrath Flask of Relentless Assault"],
	quality = 1,
	icon = "inv_potion_117",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35716] = {
	name = L["Shattrath Flask of Pure Death"],
	quality = 1,
	icon = "inv_potion_115",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[35717] = {
	name = L["Shattrath Flask of Blinding Light"],
	quality = 1,
	icon = "inv_potion_116",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[33034] = {
	name = L["Gordok Grog"],
	quality = 1,
	icon = "inv_drink_08",
	buyPrice = 400,
	sellPrice = 100,
	reqLevel = 55,
}
t[33035] = {
	name = L["Ogre Mead"],
	quality = 1,
	icon = "inv_drink_08",
	buyPrice = 640,
	sellPrice = 160,
	reqLevel = 65,
}
t[33036] = {
	name = L["Mudder's Milk"],
	quality = 1,
	icon = "inv_drink_08",
	buyPrice = 640,
	sellPrice = 160,
	reqLevel = 65,
}
t[46403] = {
	name = L["Chuganpug's Delight"],
	quality = 1,
	icon = "inv_drink_08",
	buyPrice = 1040,
	sellPrice = 260,
	reqLevel = 75,
}
t[33042] = {
	name = L["Black Coffee"],
	quality = 1,
	icon = "inv_drink_15",
	buyPrice = 6400,
	sellPrice = 320,
	reqLevel = 65,
}
t[33031] = {
	name = L["Thunder 45"],
	quality = 1,
	icon = "inv_drink_08",
	buyPrice = 100,
	sellPrice = 25,
	reqLevel = 25,
}
t[33032] = {
	name = L["Thunderbrew Ale"],
	quality = 1,
	icon = "inv_drink_08",
	buyPrice = 200,
	sellPrice = 50,
	reqLevel = 35,
}
t[33033] = {
	name = L["Thunderbrew Stout"],
	quality = 1,
	icon = "inv_drink_08",
	buyPrice = 400,
	sellPrice = 100,
	reqLevel = 45,
}
t[46399] = {
	name = L["Thunder's Plunder"],
	quality = 1,
	icon = "inv_drink_08",
	buyPrice = 1040,
	sellPrice = 260,
	reqLevel = 75,
}
t[31735] = {
	name = L["Timeless Shell"],
	quality = 4,
	icon = "inv_misc_ammo_bullet_02",
	buyPrice = 20000,
	sellPrice = 25,
	reqLevel = 70,
}
t[31737] = {
	name = L["Timeless Arrow"],
	quality = 4,
	icon = "inv_misc_ammo_arrow_04",
	buyPrice = 20000,
	sellPrice = 25,
	reqLevel = 70,
}
t[34581] = {
	name = L["Mysterious Arrow"],
	quality = 4,
	icon = "inv_misc_ammo_arrow_02",
	buyPrice = 10000,
	sellPrice = 12,
	reqLevel = 70,
}
t[34582] = {
	name = L["Mysterious Shell"],
	quality = 4,
	icon = "inv_misc_ammo_bullet_02",
	buyPrice = 10000,
	sellPrice = 12,
	reqLevel = 70,
}
t[28241] = {
	name = L["Medallion of the Horde"],
	quality = 3,
	icon = "inv_jewelry_trinketpvp_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28704] = {
	name = L["Grand Marshal's Satin Gloves"],
	quality = 3,
	icon = "inv_gauntlets_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28705] = {
	name = L["Grand Marshal's Satin Hood"],
	quality = 3,
	icon = "inv_helmet_30",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28706] = {
	name = L["Grand Marshal's Satin Leggings"],
	quality = 3,
	icon = "inv_pants_cloth_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28707] = {
	name = L["Grand Marshal's Satin Mantle"],
	quality = 3,
	icon = "inv_shoulder_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28708] = {
	name = L["Grand Marshal's Satin Robe"],
	quality = 3,
	icon = "inv_chest_cloth_43",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28811] = {
	name = L["High Warlord's Dragonhide Gloves"],
	quality = 3,
	icon = "inv_gauntlets_28",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28812] = {
	name = L["High Warlord's Dragonhide Helm"],
	quality = 3,
	icon = "inv_helmet_30",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28813] = {
	name = L["High Warlord's Dragonhide Legguards"],
	quality = 3,
	icon = "inv_pants_cloth_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28814] = {
	name = L["High Warlord's Dragonhide Spaulders"],
	quality = 3,
	icon = "inv_shoulder_12",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28815] = {
	name = L["High Warlord's Dragonhide Tunic"],
	quality = 3,
	icon = "inv_chest_leather_03",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28841] = {
	name = L["High Warlord's Linked Armor"],
	quality = 3,
	icon = "inv_chest_chain_11",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28842] = {
	name = L["High Warlord's Linked Gauntlets"],
	quality = 3,
	icon = "inv_gauntlets_11",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28843] = {
	name = L["High Warlord's Linked Helm"],
	quality = 3,
	icon = "inv_helmet_09",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28844] = {
	name = L["High Warlord's Linked Leggings"],
	quality = 3,
	icon = "inv_pants_mail_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28845] = {
	name = L["High Warlord's Linked Spaulders"],
	quality = 3,
	icon = "inv_shoulder_29",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28846] = {
	name = L["High Warlord's Mail Armor"],
	quality = 3,
	icon = "inv_chest_chain_11",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28847] = {
	name = L["High Warlord's Mail Gauntlets"],
	quality = 3,
	icon = "inv_gauntlets_11",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28848] = {
	name = L["High Warlord's Mail Helm"],
	quality = 3,
	icon = "inv_helmet_09",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28849] = {
	name = L["High Warlord's Mail Leggings"],
	quality = 3,
	icon = "inv_pants_mail_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28850] = {
	name = L["High Warlord's Mail Spaulders"],
	quality = 3,
	icon = "inv_shoulder_29",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28851] = {
	name = L["High Warlord's Plate Chestpiece"],
	quality = 3,
	icon = "inv_chest_plate05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28852] = {
	name = L["High Warlord's Plate Gauntlets"],
	quality = 3,
	icon = "inv_gauntlets_29",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28853] = {
	name = L["High Warlord's Plate Helm"],
	quality = 3,
	icon = "inv_helmet_22",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28854] = {
	name = L["High Warlord's Plate Legguards"],
	quality = 3,
	icon = "inv_pants_plate_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28855] = {
	name = L["High Warlord's Plate Shoulders"],
	quality = 3,
	icon = "inv_shoulder_22",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28871] = {
	name = L["High Warlord's Wyrmhide Gloves"],
	quality = 3,
	icon = "inv_gauntlets_28",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28872] = {
	name = L["High Warlord's Wyrmhide Helm"],
	quality = 3,
	icon = "inv_helmet_30",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28873] = {
	name = L["High Warlord's Wyrmhide Legguards"],
	quality = 3,
	icon = "inv_pants_cloth_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28874] = {
	name = L["High Warlord's Wyrmhide Spaulders"],
	quality = 3,
	icon = "inv_shoulder_12",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[28875] = {
	name = L["High Warlord's Wyrmhide Tunic"],
	quality = 3,
	icon = "inv_chest_leather_03",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30344] = {
	name = L["Medallion of the Horde"],
	quality = 3,
	icon = "inv_jewelry_trinketpvp_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30345] = {
	name = L["Medallion of the Horde"],
	quality = 3,
	icon = "inv_jewelry_trinketpvp_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[30349] = {
	name = L["Medallion of the Alliance"],
	quality = 3,
	icon = "inv_jewelry_trinketpvp_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31584] = {
	name = L["High Warlord's Kodohide Gloves"],
	quality = 3,
	icon = "inv_gauntlets_28",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31585] = {
	name = L["High Warlord's Kodohide Helm"],
	quality = 3,
	icon = "inv_helmet_30",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31586] = {
	name = L["High Warlord's Kodohide Legguards"],
	quality = 3,
	icon = "inv_pants_cloth_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31587] = {
	name = L["High Warlord's Kodohide Spaulders"],
	quality = 3,
	icon = "inv_shoulder_12",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31588] = {
	name = L["High Warlord's Kodohide Tunic"],
	quality = 3,
	icon = "inv_chest_leather_03",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31620] = {
	name = L["Grand Marshal's Mooncloth Mitts"],
	quality = 3,
	icon = "inv_gauntlets_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31622] = {
	name = L["Grand Marshal's Mooncloth Cowl"],
	quality = 3,
	icon = "inv_helmet_30",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31623] = {
	name = L["Grand Marshal's Mooncloth Legguards"],
	quality = 3,
	icon = "inv_pants_cloth_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31624] = {
	name = L["Grand Marshal's Mooncloth Shoulderpads"],
	quality = 3,
	icon = "inv_shoulder_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31625] = {
	name = L["Grand Marshal's Mooncloth Vestments"],
	quality = 3,
	icon = "inv_chest_cloth_43",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31646] = {
	name = L["High Warlord's Ringmail Chestguard"],
	quality = 3,
	icon = "inv_chest_chain_11",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31647] = {
	name = L["High Warlord's Ringmail Gloves"],
	quality = 3,
	icon = "inv_gauntlets_11",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31648] = {
	name = L["High Warlord's Ringmail Headpiece"],
	quality = 3,
	icon = "inv_helmet_09",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31649] = {
	name = L["High Warlord's Ringmail Legguards"],
	quality = 3,
	icon = "inv_pants_mail_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[31650] = {
	name = L["High Warlord's Ringmail Shoulderpads"],
	quality = 3,
	icon = "inv_shoulder_29",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[22775] = {
	name = L["Suntouched Special Reserve"],
	quality = 1,
	icon = "inv_drink_11",
	buyPrice = 300,
	sellPrice = 75,
	reqLevel = 0,
}
t[5976] = {
	name = L["Guild Tabard"],
	quality = 1,
	icon = "inv_shirt_guildtabard_01",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 0,
}
t[24286] = {
	name = L["Arcane Catalyst"],
	quality = 1,
	icon = "classic_inv_misc_dust_03",
	buyPrice = 500000,
	sellPrice = 125000,
	reqLevel = 0,
}
t[44605] = {
	name = L["Wild Spineleaf"],
	quality = 1,
	icon = "inv_misc_spineleaf-_01",
	buyPrice = 5000,
	sellPrice = 1250,
	reqLevel = 0,
}
t[44614] = {
	name = L["Starleaf Seed"],
	quality = 1,
	icon = "inv_misc_food_02",
	buyPrice = 7000,
	sellPrice = 1750,
	reqLevel = 0,
}
t[44615] = {
	name = L["Devout Candle"],
	quality = 1,
	icon = "inv_misc_candle_01",
	buyPrice = 2000,
	sellPrice = 500,
	reqLevel = 0,
}
t[2455] = {
	name = L["Minor Mana Potion"],
	quality = 1,
	icon = "inv_potion_70",
	buyPrice = 40,
	sellPrice = 10,
	reqLevel = 5,
}
t[33444] = {
	name = L["Pungent Seal Whey"],
	quality = 1,
	icon = "inv_drink_24_sealwhey",
	buyPrice = 8500,
	sellPrice = 425,
	reqLevel = 70,
}
t[33445] = {
	name = L["Honeymint Tea"],
	quality = 1,
	icon = "inv_drink_25_honeytea",
	buyPrice = 11000,
	sellPrice = 550,
	reqLevel = 75,
}
t[33451] = {
	name = L["Fillet of Icefin"],
	quality = 1,
	icon = "inv_misc_food_111_icefinfillet",
	buyPrice = 8500,
	sellPrice = 425,
	reqLevel = 65,
}
t[33454] = {
	name = L["Salted Venison"],
	quality = 1,
	icon = "inv_misc_food_107_venison",
	buyPrice = 8500,
	sellPrice = 425,
	reqLevel = 65,
}
t[35951] = {
	name = L["Poached Emperor Salmon"],
	quality = 1,
	icon = "inv_misc_food_110_emperorsalmon",
	buyPrice = 16000,
	sellPrice = 800,
	reqLevel = 75,
}
t[35953] = {
	name = L["Mead Basted Caribou"],
	quality = 1,
	icon = "inv_misc_food_108_meadcaribou",
	buyPrice = 16000,
	sellPrice = 800,
	reqLevel = 75,
}
t[35954] = {
	name = L["Sweetened Goat's Milk"],
	quality = 1,
	icon = "inv_drink_26_goatsmilk",
	buyPrice = 6000,
	sellPrice = 300,
	reqLevel = 65,
}
t[3024] = {
	name = L["BKP 2700 \"Enforcer\""],
	quality = 1,
	icon = "inv_weapon_rifle_03",
	buyPrice = 7098,
	sellPrice = 1419,
	reqLevel = 21,
}
t[200] = {
	name = L["Thick Cloth Vest"],
	quality = 1,
	icon = "inv_shirt_02",
	buyPrice = 2270,
	sellPrice = 454,
	reqLevel = 17,
}
t[201] = {
	name = L["Thick Cloth Pants"],
	quality = 1,
	icon = "inv_pants_12",
	buyPrice = 2278,
	sellPrice = 455,
	reqLevel = 17,
}
t[202] = {
	name = L["Thick Cloth Shoes"],
	quality = 1,
	icon = "inv_boots_05",
	buyPrice = 1715,
	sellPrice = 343,
	reqLevel = 17,
}
t[203] = {
	name = L["Thick Cloth Gloves"],
	quality = 1,
	icon = "inv_gauntlets_21",
	buyPrice = 1147,
	sellPrice = 229,
	reqLevel = 17,
}
t[837] = {
	name = L["Heavy Weave Armor"],
	quality = 1,
	icon = "inv_shirt_06",
	buyPrice = 1125,
	sellPrice = 225,
	reqLevel = 12,
}
t[838] = {
	name = L["Heavy Weave Pants"],
	quality = 1,
	icon = "inv_pants_14",
	buyPrice = 1129,
	sellPrice = 225,
	reqLevel = 12,
}
t[839] = {
	name = L["Heavy Weave Gloves"],
	quality = 1,
	icon = "inv_gauntlets_18",
	buyPrice = 566,
	sellPrice = 113,
	reqLevel = 12,
}
t[840] = {
	name = L["Heavy Weave Shoes"],
	quality = 1,
	icon = "inv_boots_05",
	buyPrice = 853,
	sellPrice = 170,
	reqLevel = 12,
}
t[3428] = {
	name = L["Common Gray Shirt"],
	quality = 1,
	icon = "inv_shirt_grey_01",
	buyPrice = 400,
	sellPrice = 100,
	reqLevel = 0,
}
t[3589] = {
	name = L["Heavy Weave Belt"],
	quality = 1,
	icon = "inv_belt_25",
	buyPrice = 577,
	sellPrice = 115,
	reqLevel = 12,
}
t[3590] = {
	name = L["Heavy Weave Bracers"],
	quality = 1,
	icon = "inv_bracer_06",
	buyPrice = 579,
	sellPrice = 115,
	reqLevel = 12,
}
t[3597] = {
	name = L["Thick Cloth Belt"],
	quality = 1,
	icon = "inv_belt_06",
	buyPrice = 1081,
	sellPrice = 216,
	reqLevel = 17,
}
t[3598] = {
	name = L["Thick Cloth Bracers"],
	quality = 1,
	icon = "inv_bracer_11",
	buyPrice = 1085,
	sellPrice = 217,
	reqLevel = 17,
}
t[16059] = {
	name = L["Common Brown Shirt"],
	quality = 1,
	icon = "inv_shirt_orange_01",
	buyPrice = 400,
	sellPrice = 100,
	reqLevel = 0,
}
t[16060] = {
	name = L["Common White Shirt"],
	quality = 1,
	icon = "inv_shirt_white_01",
	buyPrice = 400,
	sellPrice = 100,
	reqLevel = 0,
}
t[7337] = {
	name = L["The Rock"],
	quality = 1,
	icon = "inv_jewelry_ring_31",
	buyPrice = 1000000,
	sellPrice = 250000,
	reqLevel = 0,
}
t[7338] = {
	name = L["Mood Ring"],
	quality = 1,
	icon = "inv_jewelry_ring_12",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 0,
}
t[7339] = {
	name = L["Miniscule Diamond Ring"],
	quality = 1,
	icon = "inv_jewelry_ring_07",
	buyPrice = 250000,
	sellPrice = 62500,
	reqLevel = 0,
}
t[7340] = {
	name = L["Flawless Diamond Solitaire"],
	quality = 1,
	icon = "inv_jewelry_ring_10",
	buyPrice = 500000,
	sellPrice = 125000,
	reqLevel = 0,
}
t[7341] = {
	name = L["Cubic Zirconia Ring"],
	quality = 1,
	icon = "inv_jewelry_ring_05",
	buyPrice = 50000,
	sellPrice = 12500,
	reqLevel = 0,
}
t[7342] = {
	name = L["Silver Piffeny Band"],
	quality = 1,
	icon = "inv_belt_33",
	buyPrice = 100000,
	sellPrice = 25000,
	reqLevel = 0,
}
t[20854] = {
	name = L["Design: Amulet of the Moon"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 1800,
	sellPrice = 450,
	reqLevel = 0,
}
t[20856] = {
	name = L["Design: Heavy Golden Necklace of Battle"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 1500,
	sellPrice = 375,
	reqLevel = 0,
}
t[20975] = {
	name = L["Design: The Jade Eye"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 2500,
	sellPrice = 625,
	reqLevel = 0,
}
t[21948] = {
	name = L["Design: Opal Necklace of Impact"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 7500,
	sellPrice = 1875,
	reqLevel = 0,
}
t[285] = {
	name = L["Scalemail Vest"],
	quality = 1,
	icon = "inv_chest_chain_09",
	buyPrice = 3555,
	sellPrice = 711,
	reqLevel = 17,
}
t[286] = {
	name = L["Scalemail Pants"],
	quality = 1,
	icon = "inv_pants_03",
	buyPrice = 3229,
	sellPrice = 645,
	reqLevel = 17,
}
t[287] = {
	name = L["Scalemail Boots"],
	quality = 1,
	icon = "inv_boots_01",
	buyPrice = 2442,
	sellPrice = 488,
	reqLevel = 17,
}
t[718] = {
	name = L["Scalemail Gloves"],
	quality = 1,
	icon = "inv_gauntlets_04",
	buyPrice = 1614,
	sellPrice = 322,
	reqLevel = 17,
}
t[847] = {
	name = L["Chainmail Armor"],
	quality = 1,
	icon = "inv_chest_chain",
	buyPrice = 1749,
	sellPrice = 349,
	reqLevel = 12,
}
t[848] = {
	name = L["Chainmail Pants"],
	quality = 1,
	icon = "inv_pants_03",
	buyPrice = 1755,
	sellPrice = 351,
	reqLevel = 12,
}
t[849] = {
	name = L["Chainmail Boots"],
	quality = 1,
	icon = "inv_boots_01",
	buyPrice = 1327,
	sellPrice = 265,
	reqLevel = 12,
}
t[850] = {
	name = L["Chainmail Gloves"],
	quality = 1,
	icon = "inv_gauntlets_04",
	buyPrice = 883,
	sellPrice = 176,
	reqLevel = 12,
}
t[1845] = {
	name = L["Chainmail Belt"],
	quality = 1,
	icon = "inv_belt_03",
	buyPrice = 877,
	sellPrice = 175,
	reqLevel = 12,
}
t[1846] = {
	name = L["Chainmail Bracers"],
	quality = 1,
	icon = "inv_bracer_07",
	buyPrice = 881,
	sellPrice = 176,
	reqLevel = 12,
}
t[1852] = {
	name = L["Scalemail Bracers"],
	quality = 1,
	icon = "inv_bracer_07",
	buyPrice = 1684,
	sellPrice = 336,
	reqLevel = 17,
}
t[1853] = {
	name = L["Scalemail Belt"],
	quality = 1,
	icon = "inv_belt_04",
	buyPrice = 1690,
	sellPrice = 338,
	reqLevel = 17,
}
t[2423] = {
	name = L["Brigandine Vest"],
	quality = 1,
	icon = "inv_chest_plate13",
	buyPrice = 42770,
	sellPrice = 8554,
	reqLevel = 45,
}
t[2424] = {
	name = L["Brigandine Belt"],
	quality = 1,
	icon = "inv_belt_03",
	buyPrice = 21461,
	sellPrice = 4292,
	reqLevel = 45,
}
t[2425] = {
	name = L["Brigandine Leggings"],
	quality = 1,
	icon = "inv_pants_03",
	buyPrice = 43077,
	sellPrice = 8615,
	reqLevel = 45,
}
t[2426] = {
	name = L["Brigandine Boots"],
	quality = 1,
	icon = "inv_boots_01",
	buyPrice = 32569,
	sellPrice = 6513,
	reqLevel = 45,
}
t[2427] = {
	name = L["Brigandine Bracers"],
	quality = 1,
	icon = "inv_bracer_03",
	buyPrice = 20146,
	sellPrice = 4029,
	reqLevel = 45,
}
t[2428] = {
	name = L["Brigandine Gloves"],
	quality = 1,
	icon = "inv_gauntlets_04",
	buyPrice = 20222,
	sellPrice = 4044,
	reqLevel = 45,
}
t[2451] = {
	name = L["Crested Heater Shield"],
	quality = 1,
	icon = "inv_shield_06",
	buyPrice = 43629,
	sellPrice = 8725,
	reqLevel = 45,
}
t[3894] = {
	name = L["Brigandine Helm"],
	quality = 1,
	icon = "inv_helmet_03",
	buyPrice = 29986,
	sellPrice = 5997,
	reqLevel = 45,
}
t[8088] = {
	name = L["Platemail Belt"],
	quality = 1,
	icon = "inv_belt_15",
	buyPrice = 23470,
	sellPrice = 4694,
	reqLevel = 45,
}
t[8089] = {
	name = L["Platemail Boots"],
	quality = 1,
	icon = "inv_boots_plate_08",
	buyPrice = 35075,
	sellPrice = 7015,
	reqLevel = 45,
}
t[8090] = {
	name = L["Platemail Bracers"],
	quality = 1,
	icon = "inv_bracer_14",
	buyPrice = 23653,
	sellPrice = 4730,
	reqLevel = 45,
}
t[8091] = {
	name = L["Platemail Gloves"],
	quality = 1,
	icon = "inv_gauntlets_29",
	buyPrice = 23742,
	sellPrice = 4748,
	reqLevel = 45,
}
t[8092] = {
	name = L["Platemail Helm"],
	quality = 1,
	icon = "inv_helmet_03",
	buyPrice = 35479,
	sellPrice = 7095,
	reqLevel = 45,
}
t[8093] = {
	name = L["Platemail Leggings"],
	quality = 1,
	icon = "inv_pants_04",
	buyPrice = 47577,
	sellPrice = 9515,
	reqLevel = 45,
}
t[8094] = {
	name = L["Platemail Armor"],
	quality = 1,
	icon = "inv_chest_plate04",
	buyPrice = 47759,
	sellPrice = 9551,
	reqLevel = 45,
}
t[17190] = {
	name = L["Ornate Buckler"],
	quality = 1,
	icon = "inv_shield_10",
	buyPrice = 37647,
	sellPrice = 7529,
	reqLevel = 42,
}
t[2589] = {
	name = L["Linen Cloth"],
	quality = 1,
	icon = "inv_fabric_linen_01",
	buyPrice = 55,
	sellPrice = 13,
	reqLevel = 0,
}
t[2592] = {
	name = L["Wool Cloth"],
	quality = 1,
	icon = "inv_fabric_wool_01",
	buyPrice = 135,
	sellPrice = 33,
	reqLevel = 0,
}
t[2996] = {
	name = L["Bolt of Linen Cloth"],
	quality = 1,
	icon = "inv_fabric_linen_02",
	buyPrice = 160,
	sellPrice = 40,
	reqLevel = 0,
}
t[2997] = {
	name = L["Bolt of Woolen Cloth"],
	quality = 1,
	icon = "inv_fabric_wool_03",
	buyPrice = 400,
	sellPrice = 100,
	reqLevel = 0,
}
t[4305] = {
	name = L["Bolt of Silk Cloth"],
	quality = 1,
	icon = "inv_fabric_silk_03",
	buyPrice = 2400,
	sellPrice = 600,
	reqLevel = 0,
}
t[4306] = {
	name = L["Silk Cloth"],
	quality = 1,
	icon = "inv_fabric_silk_01",
	buyPrice = 600,
	sellPrice = 150,
	reqLevel = 0,
}
t[4338] = {
	name = L["Mageweave Cloth"],
	quality = 1,
	icon = "inv_fabric_mageweave_01",
	buyPrice = 1000,
	sellPrice = 250,
	reqLevel = 0,
}
t[24285] = {
	name = L["Crepuscular Powder"],
	quality = 1,
	icon = "inv_misc_powder_green",
	buyPrice = 1500000,
	sellPrice = 375000,
	reqLevel = 0,
}
t[25726] = {
	name = L["Pattern: Comfortable Insoles"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Comfortable Insoles"],
	learnedAt = 300,
}
t[236] = {
	name = L["Cured Leather Armor"],
	quality = 1,
	icon = "inv_chest_leather_10",
	buyPrice = 2795,
	sellPrice = 559,
	reqLevel = 17,
}
t[237] = {
	name = L["Cured Leather Pants"],
	quality = 1,
	icon = "inv_pants_06",
	buyPrice = 2806,
	sellPrice = 561,
	reqLevel = 17,
}
t[238] = {
	name = L["Cured Leather Boots"],
	quality = 1,
	icon = "inv_boots_03",
	buyPrice = 2112,
	sellPrice = 422,
	reqLevel = 17,
}
t[239] = {
	name = L["Cured Leather Gloves"],
	quality = 1,
	icon = "inv_gauntlets_21",
	buyPrice = 1413,
	sellPrice = 282,
	reqLevel = 17,
}
t[843] = {
	name = L["Tanned Leather Boots"],
	quality = 1,
	icon = "inv_boots_wolf",
	buyPrice = 1077,
	sellPrice = 215,
	reqLevel = 12,
}
t[844] = {
	name = L["Tanned Leather Gloves"],
	quality = 1,
	icon = "inv_gauntlets_05",
	buyPrice = 721,
	sellPrice = 144,
	reqLevel = 12,
}
t[845] = {
	name = L["Tanned Leather Pants"],
	quality = 1,
	icon = "inv_pants_wolf",
	buyPrice = 1447,
	sellPrice = 289,
	reqLevel = 12,
}
t[846] = {
	name = L["Tanned Leather Jerkin"],
	quality = 1,
	icon = "inv_chest_wolf",
	buyPrice = 1452,
	sellPrice = 290,
	reqLevel = 12,
}
t[1843] = {
	name = L["Tanned Leather Belt"],
	quality = 1,
	icon = "inv_belt_23",
	buyPrice = 726,
	sellPrice = 145,
	reqLevel = 12,
}
t[1844] = {
	name = L["Tanned Leather Bracers"],
	quality = 1,
	icon = "inv_bracer_08",
	buyPrice = 728,
	sellPrice = 145,
	reqLevel = 12,
}
t[1849] = {
	name = L["Cured Leather Belt"],
	quality = 1,
	icon = "inv_belt_06",
	buyPrice = 1388,
	sellPrice = 277,
	reqLevel = 17,
}
t[1850] = {
	name = L["Cured Leather Bracers"],
	quality = 1,
	icon = "inv_bracer_04",
	buyPrice = 1393,
	sellPrice = 278,
	reqLevel = 17,
}
t[1200] = {
	name = L["Large Wooden Shield"],
	quality = 1,
	icon = "inv_shield_09",
	buyPrice = 82,
	sellPrice = 16,
	reqLevel = 1,
}
t[1202] = {
	name = L["Wall Shield"],
	quality = 1,
	icon = "inv_shield_03",
	buyPrice = 1839,
	sellPrice = 367,
	reqLevel = 12,
}
t[2445] = {
	name = L["Large Metal Shield"],
	quality = 1,
	icon = "inv_shield_03",
	buyPrice = 3433,
	sellPrice = 686,
	reqLevel = 17,
}
t[2446] = {
	name = L["Kite Shield"],
	quality = 1,
	icon = "inv_shield_06",
	buyPrice = 6182,
	sellPrice = 1236,
	reqLevel = 22,
}
t[17183] = {
	name = L["Dented Buckler"],
	quality = 1,
	icon = "inv_shield_09",
	buyPrice = 36,
	sellPrice = 7,
	reqLevel = 1,
}
t[17187] = {
	name = L["Banded Buckler"],
	quality = 1,
	icon = "inv_shield_03",
	buyPrice = 1161,
	sellPrice = 232,
	reqLevel = 9,
}
t[17188] = {
	name = L["Ringed Buckler"],
	quality = 1,
	icon = "inv_shield_10",
	buyPrice = 2447,
	sellPrice = 489,
	reqLevel = 14,
}
t[17192] = {
	name = L["Reinforced Targe"],
	quality = 1,
	icon = "inv_shield_10",
	buyPrice = 4820,
	sellPrice = 964,
	reqLevel = 19,
}
t[33443] = {
	name = L["Sour Goat Cheese"],
	quality = 1,
	icon = "inv_misc_food_101_sourcheese",
	buyPrice = 8500,
	sellPrice = 425,
	reqLevel = 65,
}
t[33449] = {
	name = L["Crusty Flatbread"],
	quality = 1,
	icon = "inv_misc_food_102_flatbread",
	buyPrice = 8500,
	sellPrice = 425,
	reqLevel = 65,
}
t[35948] = {
	name = L["Savory Snowplum"],
	quality = 1,
	icon = "inv_misc_food_105_snowplum",
	buyPrice = 16000,
	sellPrice = 800,
	reqLevel = 75,
}
t[35949] = {
	name = L["Tundra Berries"],
	quality = 1,
	icon = "inv_misc_food_104_tundraberries",
	buyPrice = 8500,
	sellPrice = 425,
	reqLevel = 65,
}
t[35950] = {
	name = L["Sweet Potato Bread"],
	quality = 1,
	icon = "inv_misc_food_103_potatobread",
	buyPrice = 16000,
	sellPrice = 800,
	reqLevel = 75,
}
t[35952] = {
	name = L["Briny Hardcheese"],
	quality = 1,
	icon = "inv_misc_food_100_hardcheese",
	buyPrice = 16000,
	sellPrice = 800,
	reqLevel = 75,
}
t[851] = {
	name = L["Cutlass"],
	quality = 1,
	icon = "inv_sword_36",
	buyPrice = 2023,
	sellPrice = 404,
	reqLevel = 10,
}
t[853] = {
	name = L["Hatchet"],
	quality = 1,
	icon = "inv_axe_11",
	buyPrice = 2409,
	sellPrice = 481,
	reqLevel = 11,
}
t[922] = {
	name = L["Dacian Falx"],
	quality = 1,
	icon = "inv_sword_10",
	buyPrice = 12039,
	sellPrice = 2407,
	reqLevel = 21,
}
t[923] = {
	name = L["Longsword"],
	quality = 1,
	icon = "inv_sword_23",
	buyPrice = 8744,
	sellPrice = 1748,
	reqLevel = 21,
}
t[926] = {
	name = L["Battle Axe"],
	quality = 1,
	icon = "inv_throwingaxe_05",
	buyPrice = 9785,
	sellPrice = 1957,
	reqLevel = 20,
}
t[927] = {
	name = L["Double Axe"],
	quality = 1,
	icon = "inv_axe_21",
	buyPrice = 6954,
	sellPrice = 1390,
	reqLevel = 19,
}
t[1196] = {
	name = L["Tabar"],
	quality = 1,
	icon = "inv_axe_04",
	buyPrice = 2214,
	sellPrice = 442,
	reqLevel = 9,
}
t[1198] = {
	name = L["Claymore"],
	quality = 1,
	icon = "inv_sword_40",
	buyPrice = 2677,
	sellPrice = 535,
	reqLevel = 10,
}
t[2024] = {
	name = L["Espadon"],
	quality = 1,
	icon = "inv_sword_43",
	buyPrice = 6079,
	sellPrice = 1215,
	reqLevel = 16,
}
t[2025] = {
	name = L["Bearded Axe"],
	quality = 1,
	icon = "inv_axe_03",
	buyPrice = 5305,
	sellPrice = 1061,
	reqLevel = 15,
}
t[2027] = {
	name = L["Scimitar"],
	quality = 1,
	icon = "inv_sword_33",
	buyPrice = 3816,
	sellPrice = 763,
	reqLevel = 14,
}
t[2029] = {
	name = L["Cleaver"],
	quality = 1,
	icon = "inv_axe_23",
	buyPrice = 4420,
	sellPrice = 884,
	reqLevel = 15,
}
t[2207] = {
	name = L["Jambiya"],
	quality = 1,
	icon = "inv_weapon_shortblade_04",
	buyPrice = 2391,
	sellPrice = 478,
	reqLevel = 11,
}
t[2208] = {
	name = L["Poniard"],
	quality = 1,
	icon = "inv_sword_12",
	buyPrice = 3651,
	sellPrice = 730,
	reqLevel = 14,
}
t[2209] = {
	name = L["Kris"],
	quality = 1,
	icon = "inv_sword_32",
	buyPrice = 7116,
	sellPrice = 1423,
	reqLevel = 19,
}
t[852] = {
	name = L["Mace"],
	quality = 1,
	icon = "inv_mace_15",
	buyPrice = 1739,
	sellPrice = 347,
	reqLevel = 9,
}
t[924] = {
	name = L["Maul"],
	quality = 1,
	icon = "inv_hammer_07",
	buyPrice = 10973,
	sellPrice = 2194,
	reqLevel = 21,
}
t[925] = {
	name = L["Flail"],
	quality = 1,
	icon = "inv_mace_01",
	buyPrice = 7797,
	sellPrice = 1559,
	reqLevel = 20,
}
t[1197] = {
	name = L["Giant Mace"],
	quality = 1,
	icon = "inv_mace_02",
	buyPrice = 2667,
	sellPrice = 533,
	reqLevel = 10,
}
t[2026] = {
	name = L["Rock Hammer"],
	quality = 1,
	icon = "inv_hammer_09",
	buyPrice = 6286,
	sellPrice = 1257,
	reqLevel = 16,
}
t[2028] = {
	name = L["Hammer"],
	quality = 1,
	icon = "inv_hammer_15",
	buyPrice = 5065,
	sellPrice = 1013,
	reqLevel = 16,
}
t[15196] = {
	name = L["Private's Tabard"],
	quality = 1,
	icon = "inv_misc_tabardpvp_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[15198] = {
	name = L["Knight's Colors"],
	quality = 1,
	icon = "inv_misc_tabardpvp_03",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[19032] = {
	name = L["Stormpike Battle Tabard"],
	quality = 1,
	icon = "inv_shirt_guildtabard_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[19506] = {
	name = L["Silverwing Battle Tabard"],
	quality = 1,
	icon = "inv_shirt_guildtabard_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[31777] = {
	name = L["Keepers of Time Tabard"],
	quality = 1,
	icon = "inv_shirt_guildtabard_01",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 0,
}
t[28481] = {
	name = L["Brown Elekk"],
	quality = 3,
	icon = "ability_mount_ridingelekk",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 20,
}
t[29743] = {
	name = L["Purple Elekk"],
	quality = 3,
	icon = "ability_mount_ridingelekk_purple",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 20,
}
t[29744] = {
	name = L["Gray Elekk"],
	quality = 3,
	icon = "ability_mount_ridingelekk_grey",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 20,
}
t[29745] = {
	name = L["Great Blue Elekk"],
	quality = 4,
	icon = "ability_mount_ridingelekkelite_blue",
	buyPrice = 100000,
	sellPrice = 25000,
	reqLevel = 40,
}
t[29746] = {
	name = L["Great Green Elekk"],
	quality = 4,
	icon = "ability_mount_ridingelekkelite_green",
	buyPrice = 100000,
	sellPrice = 25000,
	reqLevel = 40,
}
t[29747] = {
	name = L["Great Purple Elekk"],
	quality = 4,
	icon = "ability_mount_ridingelekkelite_purple",
	buyPrice = 100000,
	sellPrice = 25000,
	reqLevel = 40,
}
t[29901] = {
	name = L["Blue Moth Egg"],
	quality = 1,
	icon = "ability_hunter_pet_moth",
	buyPrice = 5000,
	sellPrice = 1250,
	reqLevel = 0,
}
t[29903] = {
	name = L["Yellow Moth Egg"],
	quality = 1,
	icon = "ability_hunter_pet_moth",
	buyPrice = 5000,
	sellPrice = 1250,
	reqLevel = 0,
}
t[29904] = {
	name = L["White Moth Egg"],
	quality = 1,
	icon = "ability_hunter_pet_moth",
	buyPrice = 5000,
	sellPrice = 1250,
	reqLevel = 0,
}
t[23246] = {
	name = L["Fiery Festival Brew"],
	quality = 1,
	icon = "inv_summerfest_firedrink",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 1,
}
t[23435] = {
	name = L["Elderberry Pie"],
	quality = 1,
	icon = "inv_misc_food_10",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 1,
}
t[23327] = {
	name = L["Fire-toasted Bun"],
	quality = 1,
	icon = "inv_misc_food_11",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 1,
}
t[23326] = {
	name = L["Midsummer Sausage"],
	quality = 1,
	icon = "inv_misc_food_53",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 1,
}
t[23211] = {
	name = L["Toasted Smorc"],
	quality = 1,
	icon = "inv_summerfest_smorc",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 1,
}
t[23215] = {
	name = L["Bag of Smorc Ingredients"],
	quality = 1,
	icon = "inv_misc_bag_10_green",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 1,
}
t[34684] = {
	name = L["Handful of Summer Petals"],
	quality = 1,
	icon = "inv_holiday_summerfest_petals",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[34599] = {
	name = L["Juggling Torch"],
	quality = 1,
	icon = "inv_torch_lit",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[23324] = {
	name = L["Mantle of the Fire Festival"],
	quality = 1,
	icon = "inv_shoulder_23",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[34685] = {
	name = L["Vestment of Summer"],
	quality = 1,
	icon = "inv_chest_cloth_72",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[34683] = {
	name = L["Sandals of Summer"],
	quality = 1,
	icon = "inv_boots_cloth_20",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[34686] = {
	name = L["Brazier of Dancing Flames"],
	quality = 3,
	icon = "inv_misc_firedancer_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[23083] = {
	name = L["Captured Flame"],
	quality = 3,
	icon = "inv_potion_33",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[2141] = {
	name = L["Cuirboulli Vest"],
	quality = 1,
	icon = "inv_chest_leather_09",
	buyPrice = 5224,
	sellPrice = 1044,
	reqLevel = 22,
}
t[2142] = {
	name = L["Cuirboulli Belt"],
	quality = 1,
	icon = "inv_belt_24",
	buyPrice = 2621,
	sellPrice = 524,
	reqLevel = 22,
}
t[2143] = {
	name = L["Cuirboulli Boots"],
	quality = 1,
	icon = "inv_boots_07",
	buyPrice = 3945,
	sellPrice = 789,
	reqLevel = 22,
}
t[2144] = {
	name = L["Cuirboulli Bracers"],
	quality = 1,
	icon = "inv_bracer_04",
	buyPrice = 2639,
	sellPrice = 527,
	reqLevel = 22,
}
t[2145] = {
	name = L["Cuirboulli Gloves"],
	quality = 1,
	icon = "inv_gauntlets_21",
	buyPrice = 2649,
	sellPrice = 529,
	reqLevel = 22,
}
t[2146] = {
	name = L["Cuirboulli Pants"],
	quality = 1,
	icon = "inv_pants_09",
	buyPrice = 4809,
	sellPrice = 961,
	reqLevel = 22,
}
t[7089] = {
	name = L["Pattern: Azure Silk Cloak"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 1500,
	sellPrice = 375,
	reqLevel = 0,
	profession = L["Tailoring"],
	teaches = L["Azure Silk Cloak"],
	learnedAt = 175,
}
t[21815] = {
	name = L["Love Token"],
	quality = 1,
	icon = "inv_valentinescard01",
	buyPrice = 10,
	sellPrice = 0,
	reqLevel = 0,
}
t[21829] = {
	name = L["Perfume Bottle"],
	quality = 1,
	icon = "inv_valentineperfumebottle",
	buyPrice = 100,
	sellPrice = 25,
	reqLevel = 0,
}
t[21833] = {
	name = L["Cologne Bottle"],
	quality = 1,
	icon = "inv_valentinecolognebottle",
	buyPrice = 100,
	sellPrice = 25,
	reqLevel = 0,
}
t[10684] = {
	name = L["Colossal Parachute"],
	quality = 1,
	icon = "ability_whirlwind",
	buyPrice = 2000,
	sellPrice = 500,
	reqLevel = 0,
}
t[11141] = {
	name = L["Bait"],
	quality = 1,
	icon = "inv_misc_food_50",
	buyPrice = 2000,
	sellPrice = 0,
	reqLevel = 0,
}
t[7451] = {
	name = L["Pattern: Green Whelp Bracers"],
	quality = 2,
	icon = "inv_scroll_03",
	buyPrice = 2800,
	sellPrice = 700,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Green Whelp Bracers"],
	learnedAt = 190,
}
t[8385] = {
	name = L["Pattern: Turtle Scale Gloves"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 3500,
	sellPrice = 875,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Turtle Scale Gloves"],
	learnedAt = 205,
}
t[15734] = {
	name = L["Pattern: Living Shoulders"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 14000,
	sellPrice = 3500,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Living Shoulders"],
	learnedAt = 270,
}
t[8409] = {
	name = L["Pattern: Nightscape Shoulders"],
	quality = 2,
	icon = "inv_scroll_03",
	buyPrice = 4000,
	sellPrice = 1000,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Nightscape Shoulders"],
	learnedAt = 210,
}
t[11020] = {
	name = L["Evergreen Pouch"],
	quality = 1,
	icon = "inv_misc_bag_18",
	buyPrice = 10000,
	sellPrice = 0,
	reqLevel = 0,
}
t[11022] = {
	name = L["Packet of Tharlendris Seeds"],
	quality = 1,
	icon = "spell_nature_protectionformnature",
	buyPrice = 1000,
	sellPrice = 250,
	reqLevel = 0,
}
t[16166] = {
	name = L["Bean Soup"],
	quality = 1,
	icon = "inv_drink_17",
	buyPrice = 25,
	sellPrice = 1,
	reqLevel = 1,
}
t[16167] = {
	name = L["Versicolor Treat"],
	quality = 1,
	icon = "inv_misc_food_28",
	buyPrice = 125,
	sellPrice = 6,
	reqLevel = 5,
}
t[16168] = {
	name = L["Heaven Peach"],
	quality = 1,
	icon = "inv_misc_food_42",
	buyPrice = 2000,
	sellPrice = 100,
	reqLevel = 35,
}
t[16169] = {
	name = L["Wild Ricecake"],
	quality = 1,
	icon = "inv_misc_food_35",
	buyPrice = 1000,
	sellPrice = 62,
	reqLevel = 25,
}
t[16170] = {
	name = L["Steamed Mandu"],
	quality = 1,
	icon = "inv_misc_food_51",
	buyPrice = 500,
	sellPrice = 25,
	reqLevel = 15,
}
t[21030] = {
	name = L["Darnassus Kimchi Pie"],
	quality = 1,
	icon = "inv_misc_food_10",
	buyPrice = 2000,
	sellPrice = 100,
	reqLevel = 35,
}
t[21031] = {
	name = L["Cabbage Kimchi"],
	quality = 1,
	icon = "inv_misc_food_63",
	buyPrice = 4000,
	sellPrice = 200,
	reqLevel = 45,
}
t[21033] = {
	name = L["Radish Kimchi"],
	quality = 1,
	icon = "inv_misc_food_64",
	buyPrice = 4000,
	sellPrice = 200,
	reqLevel = 45,
}
t[12229] = {
	name = L["Recipe: Hot Wolf Ribs"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 5000,
	sellPrice = 1250,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Hot Wolf Ribs"],
	learnedAt = 175,
}
t[13947] = {
	name = L["Recipe: Lobster Stew"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 20000,
	sellPrice = 5000,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Lobster Stew"],
	learnedAt = 275,
}
t[13948] = {
	name = L["Recipe: Mightfish Steak"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 20000,
	sellPrice = 5000,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Mightfish Steak"],
	learnedAt = 275,
}
t[13949] = {
	name = L["Recipe: Baked Salmon"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 20000,
	sellPrice = 5000,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Baked Salmon"],
	learnedAt = 275,
}
t[6057] = {
	name = L["Recipe: Nature Protection Potion"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 2000,
	sellPrice = 500,
	reqLevel = 0,
	profession = L["Alchemy"],
	teaches = L["Nature Protection Potion"],
	learnedAt = 190,
}
t[9302] = {
	name = L["Recipe: Ghost Dye"],
	quality = 1,
	icon = "inv_scroll_05",
	buyPrice = 9000,
	sellPrice = 2250,
	reqLevel = 0,
	profession = L["Alchemy"],
	teaches = L["Ghost Dye"],
	learnedAt = 245,
}
t[2429] = {
	name = L["Russet Vest"],
	quality = 1,
	icon = "inv_shirt_14",
	buyPrice = 10139,
	sellPrice = 2027,
	reqLevel = 32,
}
t[2431] = {
	name = L["Russet Pants"],
	quality = 1,
	icon = "inv_pants_10",
	buyPrice = 10215,
	sellPrice = 2043,
	reqLevel = 32,
}
t[2432] = {
	name = L["Russet Boots"],
	quality = 1,
	icon = "inv_boots_05",
	buyPrice = 7691,
	sellPrice = 1538,
	reqLevel = 32,
}
t[2434] = {
	name = L["Russet Gloves"],
	quality = 1,
	icon = "inv_gauntlets_18",
	buyPrice = 5166,
	sellPrice = 1033,
	reqLevel = 32,
}
t[2463] = {
	name = L["Studded Doublet"],
	quality = 1,
	icon = "inv_chest_leather_10",
	buyPrice = 13695,
	sellPrice = 2739,
	reqLevel = 32,
}
t[2464] = {
	name = L["Studded Belt"],
	quality = 1,
	icon = "inv_belt_03",
	buyPrice = 6872,
	sellPrice = 1374,
	reqLevel = 32,
}
t[2465] = {
	name = L["Studded Pants"],
	quality = 1,
	icon = "inv_pants_06",
	buyPrice = 12477,
	sellPrice = 2495,
	reqLevel = 32,
}
t[2467] = {
	name = L["Studded Boots"],
	quality = 1,
	icon = "inv_boots_08",
	buyPrice = 9430,
	sellPrice = 1886,
	reqLevel = 32,
}
t[2468] = {
	name = L["Studded Bracers"],
	quality = 1,
	icon = "inv_bracer_02",
	buyPrice = 6311,
	sellPrice = 1262,
	reqLevel = 32,
}
t[2469] = {
	name = L["Studded Gloves"],
	quality = 1,
	icon = "inv_gauntlets_25",
	buyPrice = 6335,
	sellPrice = 1267,
	reqLevel = 32,
}
t[3593] = {
	name = L["Russet Belt"],
	quality = 1,
	icon = "inv_belt_26",
	buyPrice = 5478,
	sellPrice = 1095,
	reqLevel = 32,
}
t[3594] = {
	name = L["Russet Bracers"],
	quality = 1,
	icon = "inv_bracer_07",
	buyPrice = 5497,
	sellPrice = 1099,
	reqLevel = 32,
}
t[3889] = {
	name = L["Russet Hat"],
	quality = 1,
	icon = "inv_helmet_33",
	buyPrice = 7923,
	sellPrice = 1584,
	reqLevel = 32,
}
t[3890] = {
	name = L["Studded Hat"],
	quality = 1,
	icon = "inv_helmet_20",
	buyPrice = 10201,
	sellPrice = 2040,
	reqLevel = 32,
}
t[12253] = {
	name = L["Brilliant Red Cloak"],
	quality = 2,
	icon = "inv_misc_cape_18",
	buyPrice = 17728,
	sellPrice = 3545,
	reqLevel = 36,
}
t[12254] = {
	name = L["Well Oiled Cloak"],
	quality = 2,
	icon = "inv_misc_cape_04",
	buyPrice = 22416,
	sellPrice = 4483,
	reqLevel = 39,
}
t[2438] = {
	name = L["Embroidered Boots"],
	quality = 1,
	icon = "inv_boots_05",
	buyPrice = 20996,
	sellPrice = 4199,
	reqLevel = 45,
}
t[2440] = {
	name = L["Embroidered Gloves"],
	quality = 1,
	icon = "inv_gauntlets_18",
	buyPrice = 14099,
	sellPrice = 2819,
	reqLevel = 45,
}
t[2435] = {
	name = L["Embroidered Armor"],
	quality = 1,
	icon = "inv_shirt_17",
	buyPrice = 27683,
	sellPrice = 5536,
	reqLevel = 45,
}
t[2437] = {
	name = L["Embroidered Pants"],
	quality = 1,
	icon = "inv_pants_08",
	buyPrice = 27891,
	sellPrice = 5578,
	reqLevel = 45,
}
t[3587] = {
	name = L["Embroidered Belt"],
	quality = 1,
	icon = "inv_belt_08",
	buyPrice = 14314,
	sellPrice = 2862,
	reqLevel = 45,
}
t[3588] = {
	name = L["Embroidered Bracers"],
	quality = 1,
	icon = "inv_bracer_13",
	buyPrice = 14366,
	sellPrice = 2873,
	reqLevel = 45,
}
t[3892] = {
	name = L["Embroidered Hat"],
	quality = 1,
	icon = "inv_helmet_33",
	buyPrice = 21940,
	sellPrice = 4388,
	reqLevel = 45,
}
t[19027] = {
	name = L["Schematic: Snake Burst Firework"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 5000,
	sellPrice = 1250,
	reqLevel = 0,
	profession = L["Engineering"],
	teaches = L["Snake Burst Firework"],
	learnedAt = 250,
}
t[6047] = {
	name = L["Plans: Golden Scale Coif"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 4400,
	sellPrice = 1100,
	reqLevel = 0,
	profession = L["Blacksmithing"],
	teaches = L["Golden Scale Coif"],
	learnedAt = 190,
}
t[9303] = {
	name = L["Recipe: Philosopher's Stone"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 8000,
	sellPrice = 2000,
	reqLevel = 0,
	profession = L["Alchemy"],
	teaches = L["Philosopher's Stone"],
	learnedAt = 225,
}
t[9304] = {
	name = L["Recipe: Transmute Iron to Gold"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 8000,
	sellPrice = 2000,
	reqLevel = 0,
	profession = L["Alchemy"],
	teaches = L["Transmute: Iron to Gold"],
	learnedAt = 225,
}
t[9305] = {
	name = L["Recipe: Transmute Mithril to Truesilver"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 8000,
	sellPrice = 2000,
	reqLevel = 0,
	profession = L["Alchemy"],
	teaches = L["Transmute: Mithril to Truesilver"],
	learnedAt = 225,
}
t[12958] = {
	name = L["Recipe: Transmute Arcanite"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 50000,
	sellPrice = 12500,
	reqLevel = 0,
	profession = L["Alchemy"],
	teaches = L["Transmute: Arcanite"],
	learnedAt = 275,
}
t[21358] = {
	name = L["Pattern: Soul Pouch"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 12000,
	sellPrice = 3000,
	reqLevel = 0,
	profession = L["Tailoring"],
	teaches = L["Soul Pouch"],
	learnedAt = 260,
}
t[7088] = {
	name = L["Pattern: Crimson Silk Robe"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 5000,
	sellPrice = 1250,
	reqLevel = 0,
	profession = L["Tailoring"],
	teaches = L["Crimson Silk Robe"],
	learnedAt = 205,
}
t[8529] = {
	name = L["Noggenfogger Elixir"],
	quality = 1,
	icon = "inv_potion_83",
	buyPrice = 3500,
	sellPrice = 175,
	reqLevel = 35,
}
t[18046] = {
	name = L["Recipe: Tender Wolf Steak"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 12000,
	sellPrice = 3000,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Tender Wolf Steak"],
	learnedAt = 225,
}
t[2417] = {
	name = L["Augmented Chain Vest"],
	quality = 1,
	icon = "inv_chest_plate12",
	buyPrice = 15673,
	sellPrice = 3134,
	reqLevel = 32,
}
t[2418] = {
	name = L["Augmented Chain Leggings"],
	quality = 1,
	icon = "inv_pants_03",
	buyPrice = 15732,
	sellPrice = 3146,
	reqLevel = 32,
}
t[2419] = {
	name = L["Augmented Chain Belt"],
	quality = 1,
	icon = "inv_belt_03",
	buyPrice = 7895,
	sellPrice = 1579,
	reqLevel = 32,
}
t[2420] = {
	name = L["Augmented Chain Boots"],
	quality = 1,
	icon = "inv_boots_01",
	buyPrice = 11938,
	sellPrice = 2387,
	reqLevel = 32,
}
t[2421] = {
	name = L["Augmented Chain Bracers"],
	quality = 1,
	icon = "inv_bracer_07",
	buyPrice = 7952,
	sellPrice = 1590,
	reqLevel = 32,
}
t[2422] = {
	name = L["Augmented Chain Gloves"],
	quality = 1,
	icon = "inv_gauntlets_04",
	buyPrice = 7981,
	sellPrice = 1596,
	reqLevel = 32,
}
t[2448] = {
	name = L["Heavy Pavise"],
	quality = 1,
	icon = "inv_shield_03",
	buyPrice = 16159,
	sellPrice = 3231,
	reqLevel = 32,
}
t[3891] = {
	name = L["Augmented Chain Helm"],
	quality = 1,
	icon = "inv_helmet_03",
	buyPrice = 12285,
	sellPrice = 2457,
	reqLevel = 32,
}
t[17189] = {
	name = L["Metal Buckler"],
	quality = 1,
	icon = "inv_shield_10",
	buyPrice = 13054,
	sellPrice = 2610,
	reqLevel = 29,
}
t[18650] = {
	name = L["Schematic: EZ-Thro Dynamite II"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 5000,
	sellPrice = 1250,
	reqLevel = 0,
	profession = L["Engineering"],
	teaches = L["EZ-Thro Dynamite II"],
	learnedAt = 200,
}
t[13939] = {
	name = L["Recipe: Spotted Yellowtail"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 16000,
	sellPrice = 4000,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Spotted Yellowtail"],
	learnedAt = 225,
}
t[13942] = {
	name = L["Recipe: Grilled Squid"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 16000,
	sellPrice = 4000,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Grilled Squid"],
	learnedAt = 240,
}
t[13945] = {
	name = L["Recipe: Nightfin Soup"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 20000,
	sellPrice = 5000,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Nightfin Soup"],
	learnedAt = 250,
}
t[13946] = {
	name = L["Recipe: Poached Sunscale Salmon"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 20000,
	sellPrice = 5000,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Poached Sunscale Salmon"],
	learnedAt = 250,
}
t[16767] = {
	name = L["Recipe: Undermine Clam Chowder"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 3000,
	sellPrice = 750,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Undermine Clam Chowder"],
	learnedAt = 225,
}
t[37915] = {
	name = L["Pattern: Dress Shoes"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 5000,
	sellPrice = 1250,
	reqLevel = 0,
	profession = L["Tailoring"],
	teaches = L["Dress Shoes"],
	learnedAt = 250,
}
t[38327] = {
	name = L["Pattern: Haliscan Jacket"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 5000,
	sellPrice = 1250,
	reqLevel = 0,
	profession = L["Tailoring"],
	teaches = L["Haliscan Jacket"],
	learnedAt = 250,
}
t[38328] = {
	name = L["Pattern: Haliscan Pantaloons"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 4500,
	sellPrice = 1125,
	reqLevel = 0,
	profession = L["Tailoring"],
	teaches = L["Haliscan Pantaloons"],
	learnedAt = 245,
}
t[186683] = {
	name = L["Formula: Enchant Ring - Stats"],
	quality = 1,
	icon = "inv_misc_note_01",
	buyPrice = 200000,
	sellPrice = 50000,
	reqLevel = 0,
	profession = L["Enchanting"],
	teaches = L["Enchant Ring - Stats"],
	learnedAt = 375,
}
t[22536] = {
	name = L["Formula: Enchant Ring - Spellpower"],
	quality = 1,
	icon = "inv_misc_note_01",
	buyPrice = 100000,
	sellPrice = 25000,
	reqLevel = 0,
	profession = L["Enchanting"],
	teaches = L["Enchant Ring - Spellpower"],
	learnedAt = 360,
}
t[24174] = {
	name = L["Design: Pendant of Frozen Flame"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 120000,
	sellPrice = 30000,
	reqLevel = 0,
}
t[24181] = {
	name = L["Design: Living Ruby Serpent"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 120000,
	sellPrice = 30000,
	reqLevel = 0,
}
t[25910] = {
	name = L["Design: Enigmatic Skyfire Diamond"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 120000,
	sellPrice = 30000,
	reqLevel = 0,
}
t[28272] = {
	name = L["Formula: Enchant Gloves - Major Spellpower"],
	quality = 2,
	icon = "inv_misc_note_01",
	buyPrice = 80000,
	sellPrice = 20000,
	reqLevel = 0,
	profession = L["Enchanting"],
	teaches = L["Enchant Gloves - Major Spellpower"],
	learnedAt = 360,
}
t[29181] = {
	name = L["Timelapse Shard"],
	quality = 4,
	icon = "inv_datacrystal02",
	buyPrice = 790112,
	sellPrice = 197528,
	reqLevel = 70,
}
t[29182] = {
	name = L["Riftmaker"],
	quality = 4,
	icon = "inv_weapon_shortblade_26",
	buyPrice = 2056797,
	sellPrice = 411359,
	reqLevel = 70,
}
t[29183] = {
	name = L["Bindings of the Timewalker"],
	quality = 4,
	icon = "inv_bracer_10",
	buyPrice = 431396,
	sellPrice = 86279,
	reqLevel = 70,
}
t[29184] = {
	name = L["Timewarden's Leggings"],
	quality = 3,
	icon = "inv_pants_plate_10",
	buyPrice = 308501,
	sellPrice = 61700,
	reqLevel = 70,
}
t[29185] = {
	name = L["Continuum Blade"],
	quality = 3,
	icon = "inv_sword_11",
	buyPrice = 442344,
	sellPrice = 88468,
	reqLevel = 70,
}
t[29186] = {
	name = L["Arcanum of the Defender"],
	quality = 2,
	icon = "ability_warrior_victoryrush",
	buyPrice = 1000000,
	sellPrice = 250000,
	reqLevel = 70,
}
t[29198] = {
	name = L["Arcanum of Frost Warding"],
	quality = 2,
	icon = "spell_frost_frostarmor02",
	buyPrice = 1000000,
	sellPrice = 250000,
	reqLevel = 70,
}
t[29713] = {
	name = L["Pattern: Drums of Panic"],
	quality = 1,
	icon = "inv_scroll_05",
	buyPrice = 120000,
	sellPrice = 30000,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Drums of Panic"],
	learnedAt = 370,
}
t[30635] = {
	name = L["Key of Time"],
	quality = 1,
	icon = "inv_misc_key_04",
	buyPrice = 100000,
	sellPrice = 25000,
	reqLevel = 0,
}
t[31355] = {
	name = L["Recipe: Flask of Supreme Power"],
	quality = 2,
	icon = "inv_scroll_06",
	buyPrice = 40000,
	sellPrice = 10000,
	reqLevel = 0,
	profession = L["Alchemy"],
	teaches = L["Flask of Supreme Power"],
	learnedAt = 300,
}
t[33152] = {
	name = L["Formula: Enchant Gloves - Superior Agility"],
	quality = 3,
	icon = "inv_misc_note_01",
	buyPrice = 100000,
	sellPrice = 25000,
	reqLevel = 0,
	profession = L["Enchanting"],
	teaches = L["Enchant Gloves - Superior Agility"],
	learnedAt = 300,
}
t[33158] = {
	name = L["Design: Stone of Blades"],
	quality = 1,
	icon = "inv_scroll_05",
	buyPrice = 120000,
	sellPrice = 30000,
	reqLevel = 0,
}
t[33160] = {
	name = L["Design: Facet of Eternity"],
	quality = 1,
	icon = "inv_scroll_05",
	buyPrice = 120000,
	sellPrice = 30000,
	reqLevel = 0,
}
t[35328] = {
	name = L["Dreadweave Gloves"],
	quality = 3,
	icon = "inv_gauntlets_15",
	buyPrice = 86955,
	sellPrice = 17391,
	reqLevel = 70,
}
t[35334] = {
	name = L["Mooncloth Legguards"],
	quality = 3,
	icon = "inv_pants_cloth_05",
	buyPrice = 177782,
	sellPrice = 35556,
	reqLevel = 70,
}
t[35338] = {
	name = L["Satin Gloves"],
	quality = 3,
	icon = "inv_gauntlets_15",
	buyPrice = 90184,
	sellPrice = 18036,
	reqLevel = 70,
}
t[35346] = {
	name = L["Evoker's Silk Raiment"],
	quality = 3,
	icon = "inv_chest_leather_01",
	buyPrice = 172591,
	sellPrice = 34518,
	reqLevel = 70,
}
t[35369] = {
	name = L["Opportunist's Leather Spaulders"],
	quality = 3,
	icon = "inv_shoulder_12",
	buyPrice = 163602,
	sellPrice = 32720,
	reqLevel = 70,
}
t[35376] = {
	name = L["Stalker's Chain Armor"],
	quality = 3,
	icon = "inv_chest_chain_11",
	buyPrice = 268547,
	sellPrice = 53709,
	reqLevel = 70,
}
t[35384] = {
	name = L["Seer's Linked Leggings"],
	quality = 3,
	icon = "inv_pants_mail_15",
	buyPrice = 256881,
	sellPrice = 51376,
	reqLevel = 70,
}
t[35390] = {
	name = L["Seer's Mail Spaulders"],
	quality = 3,
	icon = "inv_shoulder_29",
	buyPrice = 197891,
	sellPrice = 39578,
	reqLevel = 70,
}
t[35393] = {
	name = L["Seer's Ringmail Headpiece"],
	quality = 3,
	icon = "inv_helmet_09",
	buyPrice = 204438,
	sellPrice = 40887,
	reqLevel = 70,
}
t[185693] = {
	name = L["Key of Time"],
	quality = 1,
	icon = "inv_misc_key_04",
	buyPrice = 100000,
	sellPrice = 25000,
	reqLevel = 0,
}
t[185925] = {
	name = L["Pattern: Greater Drums of Panic"],
	quality = 3,
	icon = "inv_scroll_04",
	buyPrice = 120000,
	sellPrice = 30000,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Greater Drums of Panic"],
	learnedAt = 370,
}
t[20075] = {
	name = L["Recipe: Heavy Crocolisk Stew"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 2000,
	sellPrice = 500,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Heavy Crocolisk Stew"],
	learnedAt = 150,
}
t[12228] = {
	name = L["Recipe: Roast Raptor"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 5000,
	sellPrice = 1250,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Roast Raptor"],
	learnedAt = 175,
}
t[12232] = {
	name = L["Recipe: Carrion Surprise"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 5000,
	sellPrice = 1250,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Carrion Surprise"],
	learnedAt = 175,
}
t[12239] = {
	name = L["Recipe: Dragonbreath Chili"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 7000,
	sellPrice = 1750,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Dragonbreath Chili"],
	learnedAt = 200,
}
t[2148] = {
	name = L["Polished Scale Belt"],
	quality = 1,
	icon = "inv_belt_04",
	buyPrice = 2908,
	sellPrice = 581,
	reqLevel = 22,
}
t[2149] = {
	name = L["Polished Scale Boots"],
	quality = 1,
	icon = "inv_boots_01",
	buyPrice = 4398,
	sellPrice = 879,
	reqLevel = 22,
}
t[2150] = {
	name = L["Polished Scale Bracers"],
	quality = 1,
	icon = "inv_bracer_03",
	buyPrice = 2930,
	sellPrice = 586,
	reqLevel = 22,
}
t[2151] = {
	name = L["Polished Scale Gloves"],
	quality = 1,
	icon = "inv_gauntlets_04",
	buyPrice = 2941,
	sellPrice = 588,
	reqLevel = 22,
}
t[2152] = {
	name = L["Polished Scale Leggings"],
	quality = 1,
	icon = "inv_pants_03",
	buyPrice = 5906,
	sellPrice = 1181,
	reqLevel = 22,
}
t[2153] = {
	name = L["Polished Scale Vest"],
	quality = 1,
	icon = "inv_chest_chain_09",
	buyPrice = 5928,
	sellPrice = 1185,
	reqLevel = 22,
}
t[12250] = {
	name = L["Midnight Axe"],
	quality = 2,
	icon = "inv_axe_17",
	buyPrice = 40342,
	sellPrice = 8068,
	reqLevel = 29,
}
t[2414] = {
	name = L["Pinto Bridle"],
	quality = 3,
	icon = "ability_mount_ridinghorse",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 20,
}
t[5655] = {
	name = L["Chestnut Mare Bridle"],
	quality = 3,
	icon = "ability_mount_ridinghorse",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 20,
}
t[5656] = {
	name = L["Brown Horse Bridle"],
	quality = 3,
	icon = "ability_mount_ridinghorse",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 20,
}
t[18776] = {
	name = L["Swift Palomino"],
	quality = 4,
	icon = "ability_mount_ridinghorse",
	buyPrice = 100000,
	sellPrice = 25000,
	reqLevel = 40,
}
t[18777] = {
	name = L["Swift Brown Steed"],
	quality = 4,
	icon = "ability_mount_ridinghorse",
	buyPrice = 100000,
	sellPrice = 25000,
	reqLevel = 40,
}
t[18778] = {
	name = L["Swift White Steed"],
	quality = 4,
	icon = "ability_mount_ridinghorse",
	buyPrice = 100000,
	sellPrice = 25000,
	reqLevel = 40,
}
t[2473] = {
	name = L["Reinforced Leather Boots"],
	quality = 1,
	icon = "inv_boots_08",
	buyPrice = 25753,
	sellPrice = 5150,
	reqLevel = 45,
}
t[4817] = {
	name = L["Blessed Claymore"],
	quality = 2,
	icon = "inv_sword_13",
	buyPrice = 12311,
	sellPrice = 2462,
	reqLevel = 17,
}
t[4818] = {
	name = L["Executioner's Sword"],
	quality = 2,
	icon = "inv_sword_28",
	buyPrice = 14273,
	sellPrice = 2854,
	reqLevel = 19,
}
t[4824] = {
	name = L["Blurred Axe"],
	quality = 2,
	icon = "inv_axe_14",
	buyPrice = 16856,
	sellPrice = 3371,
	reqLevel = 22,
}
t[4825] = {
	name = L["Callous Axe"],
	quality = 2,
	icon = "inv_axe_21",
	buyPrice = 20472,
	sellPrice = 4094,
	reqLevel = 24,
}
t[4826] = {
	name = L["Marauder Axe"],
	quality = 2,
	icon = "inv_axe_23",
	buyPrice = 15436,
	sellPrice = 3087,
	reqLevel = 21,
}
t[4830] = {
	name = L["Saber Leggings"],
	quality = 2,
	icon = "inv_pants_06",
	buyPrice = 9475,
	sellPrice = 1895,
	reqLevel = 23,
}
t[4831] = {
	name = L["Stalking Pants"],
	quality = 2,
	icon = "inv_pants_10",
	buyPrice = 7859,
	sellPrice = 1571,
	reqLevel = 21,
}
t[4832] = {
	name = L["Mystic Sarong"],
	quality = 2,
	icon = "inv_pants_07",
	buyPrice = 10498,
	sellPrice = 2099,
	reqLevel = 24,
}
t[5789] = {
	name = L["Pattern: Murloc Scale Bracers"],
	quality = 2,
	icon = "inv_scroll_03",
	buyPrice = 2800,
	sellPrice = 700,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Murloc Scale Bracers"],
	learnedAt = 190,
}
t[12233] = {
	name = L["Recipe: Mystery Stew"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 3000,
	sellPrice = 750,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Mystery Stew"],
	learnedAt = 175,
}
t[21941] = {
	name = L["Design: Black Pearl Panther"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 5000,
	sellPrice = 1250,
	reqLevel = 0,
}
t[21943] = {
	name = L["Design: Truesilver Crab"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 6000,
	sellPrice = 1500,
	reqLevel = 0,
}
t[1710] = {
	name = L["Greater Healing Potion"],
	quality = 1,
	icon = "inv_potion_52",
	buyPrice = 500,
	sellPrice = 125,
	reqLevel = 21,
}
t[3827] = {
	name = L["Mana Potion"],
	quality = 1,
	icon = "inv_potion_72",
	buyPrice = 480,
	sellPrice = 120,
	reqLevel = 22,
}
t[4355] = {
	name = L["Pattern: Icy Cloak"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 1500,
	sellPrice = 375,
	reqLevel = 0,
	profession = L["Tailoring"],
	teaches = L["Icy Cloak"],
	learnedAt = 200,
}
t[19974] = {
	name = L["Mudskunk Lure"],
	quality = 1,
	icon = "inv_cask_01",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 0,
}
t[16084] = {
	name = L["Expert First Aid - Under Wraps"],
	quality = 1,
	icon = "inv_misc_book_08",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 0,
	profession = L["First Aid"],
	teaches = L["First Aid"],
	learnedAt = 125,
}
t[16112] = {
	name = L["Manual: Heavy Silk Bandage"],
	quality = 1,
	icon = "inv_misc_book_03",
	buyPrice = 2200,
	sellPrice = 550,
	reqLevel = 0,
	profession = L["First Aid"],
	teaches = L["Heavy Silk Bandage"],
	learnedAt = 180,
}
t[16113] = {
	name = L["Manual: Mageweave Bandage"],
	quality = 1,
	icon = "inv_misc_book_03",
	buyPrice = 5000,
	sellPrice = 1250,
	reqLevel = 0,
	profession = L["First Aid"],
	teaches = L["Mageweave Bandage"],
	learnedAt = 210,
}
t[1478] = {
	name = L["Scroll of Protection II"],
	quality = 1,
	icon = "inv_scroll_07",
	buyPrice = 250,
	sellPrice = 62,
	reqLevel = 15,
}
t[1712] = {
	name = L["Scroll of Spirit II"],
	quality = 1,
	icon = "inv_scroll_01",
	buyPrice = 250,
	sellPrice = 62,
	reqLevel = 15,
}
t[15758] = {
	name = L["Pattern: Devilsaur Gauntlets"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 22000,
	sellPrice = 5500,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Devilsaur Gauntlets"],
	learnedAt = 290,
}
t[10607] = {
	name = L["Schematic: Deepdive Helmet"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 3600,
	sellPrice = 900,
	reqLevel = 0,
	profession = L["Engineering"],
	teaches = L["Deepdive Helmet"],
	learnedAt = 230,
}
t[15729] = {
	name = L["Pattern: Chimeric Gloves"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 12000,
	sellPrice = 3000,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Chimeric Gloves"],
	learnedAt = 265,
}
t[15751] = {
	name = L["Pattern: Blue Dragonscale Breastplate"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 20000,
	sellPrice = 5000,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Blue Dragonscale Breastplate"],
	learnedAt = 285,
}
t[12240] = {
	name = L["Recipe: Heavy Kodo Stew"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 7000,
	sellPrice = 1750,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Heavy Kodo Stew"],
	learnedAt = 200,
}
t[10858] = {
	name = L["Plans: Solid Iron Maul"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 3000,
	sellPrice = 750,
	reqLevel = 0,
	profession = L["Blacksmithing"],
	teaches = L["Solid Iron Maul"],
	learnedAt = 155,
}
t[7114] = {
	name = L["Pattern: Azure Silk Gloves"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 1000,
	sellPrice = 250,
	reqLevel = 0,
	profession = L["Tailoring"],
	teaches = L["Azure Silk Gloves"],
	learnedAt = 145,
}
t[20973] = {
	name = L["Design: Blazing Citrine Ring"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 2000,
	sellPrice = 500,
	reqLevel = 0,
}
t[6369] = {
	name = L["Recipe: Rockscale Cod"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 2200,
	sellPrice = 550,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Rockscale Cod"],
	learnedAt = 175,
}
t[16072] = {
	name = L["Expert Cookbook"],
	quality = 1,
	icon = "inv_misc_book_08",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Cooking"],
	learnedAt = 125,
}
t[17062] = {
	name = L["Recipe: Mithril Head Trout"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 2200,
	sellPrice = 550,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Mithril Head Trout"],
	learnedAt = 175,
}
t[12249] = {
	name = L["Merciless Axe"],
	quality = 2,
	icon = "inv_axe_17",
	buyPrice = 30195,
	sellPrice = 6039,
	reqLevel = 26,
}
t[3735] = {
	name = L["Recipe: Hot Lion Chops"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 1800,
	sellPrice = 450,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Hot Lion Chops"],
	learnedAt = 125,
}
t[5489] = {
	name = L["Recipe: Lean Venison"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 1200,
	sellPrice = 300,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Lean Venison"],
	learnedAt = 110,
}
t[12231] = {
	name = L["Recipe: Jungle Stew"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 3000,
	sellPrice = 750,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Jungle Stew"],
	learnedAt = 175,
}
t[3734] = {
	name = L["Recipe: Big Bear Steak"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 1600,
	sellPrice = 400,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Big Bear Steak"],
	learnedAt = 110,
}
t[4609] = {
	name = L["Recipe: Barbecued Buzzard Wing"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 1000,
	sellPrice = 250,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Barbecued Buzzard Wing"],
	learnedAt = 175,
}
t[12227] = {
	name = L["Recipe: Lean Wolf Steak"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 1600,
	sellPrice = 400,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Lean Wolf Steak"],
	learnedAt = 125,
}
t[13086] = {
	name = L["Reins of the Winterspring Frostsaber"],
	quality = 4,
	icon = "ability_mount_pinktiger",
	buyPrice = 1000000,
	sellPrice = 250000,
	reqLevel = 40,
}
t[22324] = {
	name = L["Winter Kimchi"],
	quality = 1,
	icon = "inv_misc_food_63",
	buyPrice = 4000,
	sellPrice = 200,
	reqLevel = 45,
}
t[2470] = {
	name = L["Reinforced Leather Vest"],
	quality = 1,
	icon = "inv_chest_cloth_05",
	buyPrice = 33952,
	sellPrice = 6790,
	reqLevel = 45,
}
t[2471] = {
	name = L["Reinforced Leather Belt"],
	quality = 1,
	icon = "inv_belt_16",
	buyPrice = 17041,
	sellPrice = 3408,
	reqLevel = 45,
}
t[2472] = {
	name = L["Reinforced Leather Pants"],
	quality = 1,
	icon = "inv_pants_09",
	buyPrice = 34212,
	sellPrice = 6842,
	reqLevel = 45,
}
t[2474] = {
	name = L["Reinforced Leather Bracers"],
	quality = 1,
	icon = "inv_bracer_03",
	buyPrice = 17233,
	sellPrice = 3446,
	reqLevel = 45,
}
t[2475] = {
	name = L["Reinforced Leather Gloves"],
	quality = 1,
	icon = "inv_gauntlets_05",
	buyPrice = 17298,
	sellPrice = 3459,
	reqLevel = 45,
}
t[3893] = {
	name = L["Reinforced Leather Cap"],
	quality = 1,
	icon = "inv_helmet_15",
	buyPrice = 27523,
	sellPrice = 5504,
	reqLevel = 45,
}
t[16046] = {
	name = L["Schematic: Masterwork Target Dummy"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 16000,
	sellPrice = 4000,
	reqLevel = 0,
	profession = L["Engineering"],
	teaches = L["Masterwork Target Dummy"],
	learnedAt = 275,
}
t[16050] = {
	name = L["Schematic: Delicate Arcanite Converter"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 20000,
	sellPrice = 5000,
	reqLevel = 0,
	profession = L["Engineering"],
	teaches = L["Delicate Arcanite Converter"],
	learnedAt = 285,
}
t[18652] = {
	name = L["Schematic: Gyrofreeze Ice Reflector"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 12000,
	sellPrice = 3000,
	reqLevel = 0,
	profession = L["Engineering"],
	teaches = L["Gyrofreeze Ice Reflector"],
	learnedAt = 260,
}
t[18656] = {
	name = L["Schematic: Powerful Seaforium Charge"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 16000,
	sellPrice = 4000,
	reqLevel = 0,
	profession = L["Engineering"],
	teaches = L["Powerful Seaforium Charge"],
	learnedAt = 275,
}
t[16110] = {
	name = L["Recipe: Monster Omelet"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 12000,
	sellPrice = 3000,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Monster Omelet"],
	learnedAt = 225,
}
t[14468] = {
	name = L["Pattern: Runecloth Bag"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 12000,
	sellPrice = 3000,
	reqLevel = 0,
	profession = L["Tailoring"],
	teaches = L["Runecloth Bag"],
	learnedAt = 260,
}
t[16221] = {
	name = L["Formula: Enchant Chest - Major Health"],
	quality = 1,
	icon = "inv_misc_note_01",
	buyPrice = 16000,
	sellPrice = 4000,
	reqLevel = 0,
	profession = L["Enchanting"],
	teaches = L["Enchant Chest - Major Health"],
	learnedAt = 275,
}
t[15740] = {
	name = L["Pattern: Frostsaber Boots"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 16000,
	sellPrice = 4000,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Frostsaber Boots"],
	learnedAt = 275,
}
t[14526] = {
	name = L["Pattern: Mooncloth"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 20000,
	sellPrice = 5000,
	reqLevel = 0,
	profession = L["Tailoring"],
	teaches = L["Mooncloth"],
	learnedAt = 250,
}
t[21957] = {
	name = L["Design: Necklace of the Diamond Tower"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 13500,
	sellPrice = 3375,
	reqLevel = 0,
}
t[8846] = {
	name = L["Gromsblood"],
	quality = 1,
	icon = "inv_misc_herb_16",
	buyPrice = 1000,
	sellPrice = 250,
	reqLevel = 0,
}
t[14256] = {
	name = L["Felcloth"],
	quality = 1,
	icon = "inv_fabric_felrag",
	buyPrice = 8000,
	sellPrice = 2000,
	reqLevel = 0,
}
t[21939] = {
	name = L["Fel Elemental Rod"],
	quality = 1,
	icon = "inv_staff_18",
	buyPrice = 400000,
	sellPrice = 100000,
	reqLevel = 0,
}
t[2156] = {
	name = L["Padded Boots"],
	quality = 1,
	icon = "inv_boots_09",
	buyPrice = 3078,
	sellPrice = 615,
	reqLevel = 22,
}
t[2158] = {
	name = L["Padded Gloves"],
	quality = 1,
	icon = "inv_gauntlets_23",
	buyPrice = 2066,
	sellPrice = 413,
	reqLevel = 22,
}
t[2159] = {
	name = L["Padded Pants"],
	quality = 1,
	icon = "inv_pants_07",
	buyPrice = 4148,
	sellPrice = 829,
	reqLevel = 22,
}
t[2160] = {
	name = L["Padded Armor"],
	quality = 1,
	icon = "inv_shirt_02",
	buyPrice = 4163,
	sellPrice = 832,
	reqLevel = 22,
}
t[3591] = {
	name = L["Padded Belt"],
	quality = 1,
	icon = "inv_belt_06",
	buyPrice = 2097,
	sellPrice = 419,
	reqLevel = 22,
}
t[3592] = {
	name = L["Padded Bracers"],
	quality = 1,
	icon = "inv_bracer_11",
	buyPrice = 2104,
	sellPrice = 420,
	reqLevel = 22,
}
t[11039] = {
	name = L["Formula: Enchant Cloak - Minor Agility"],
	quality = 2,
	icon = "inv_misc_note_01",
	buyPrice = 800,
	sellPrice = 200,
	reqLevel = 0,
	profession = L["Enchanting"],
	teaches = L["Enchant Cloak - Minor Agility"],
	learnedAt = 110,
}
t[11101] = {
	name = L["Formula: Enchant Bracer - Lesser Strength"],
	quality = 2,
	icon = "inv_misc_note_01",
	buyPrice = 2500,
	sellPrice = 625,
	reqLevel = 0,
	profession = L["Enchanting"],
	teaches = L["Enchant Bracer - Lesser Strength"],
	learnedAt = 140,
}
t[20855] = {
	name = L["Design: Wicked Moonstone Ring"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 1500,
	sellPrice = 375,
	reqLevel = 0,
}
t[6054] = {
	name = L["Recipe: Shadow Protection Potion"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 900,
	sellPrice = 225,
	reqLevel = 0,
	profession = L["Alchemy"],
	teaches = L["Shadow Protection Potion"],
	learnedAt = 135,
}
t[5973] = {
	name = L["Pattern: Barbaric Leggings"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 650,
	sellPrice = 162,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Barbaric Leggings"],
	learnedAt = 170,
}
t[2102] = {
	name = L["Small Ammo Pouch"],
	quality = 1,
	icon = "inv_misc_ammo_bullet_01",
	buyPrice = 4,
	sellPrice = 1,
	reqLevel = 1,
}
t[11363] = {
	name = L["Medium Shot Pouch"],
	quality = 1,
	icon = "inv_misc_ammo_bullet_01",
	buyPrice = 1000,
	sellPrice = 250,
	reqLevel = 10,
}
t[7361] = {
	name = L["Pattern: Herbalist's Gloves"],
	quality = 2,
	icon = "inv_scroll_03",
	buyPrice = 1800,
	sellPrice = 450,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Herbalist's Gloves"],
	learnedAt = 135,
}
t[19061] = {
	name = L["Warsong Gulch Iron Ration"],
	quality = 1,
	icon = "inv_misc_food_08",
	buyPrice = 1500,
	sellPrice = 75,
	reqLevel = 35,
}
t[19062] = {
	name = L["Warsong Gulch Field Ration"],
	quality = 1,
	icon = "inv_misc_food_09",
	buyPrice = 1000,
	sellPrice = 50,
	reqLevel = 25,
}
t[19067] = {
	name = L["Warsong Gulch Mageweave Bandage"],
	quality = 1,
	icon = "inv_misc_bandage_20",
	buyPrice = 1500,
	sellPrice = 75,
	reqLevel = 35,
}
t[19068] = {
	name = L["Warsong Gulch Silk Bandage"],
	quality = 1,
	icon = "inv_misc_bandage_02",
	buyPrice = 1000,
	sellPrice = 50,
	reqLevel = 25,
}
t[17348] = {
	name = L["Major Healing Draught"],
	quality = 1,
	icon = "inv_potion_38",
	buyPrice = 1000,
	sellPrice = 250,
	reqLevel = 45,
}
t[17349] = {
	name = L["Superior Healing Draught"],
	quality = 1,
	icon = "inv_potion_39",
	buyPrice = 500,
	sellPrice = 125,
	reqLevel = 35,
}
t[17351] = {
	name = L["Major Mana Draught"],
	quality = 1,
	icon = "inv_potion_80",
	buyPrice = 1000,
	sellPrice = 250,
	reqLevel = 45,
}
t[17352] = {
	name = L["Superior Mana Draught"],
	quality = 1,
	icon = "inv_potion_81",
	buyPrice = 500,
	sellPrice = 125,
	reqLevel = 35,
}
t[19060] = {
	name = L["Warsong Gulch Enriched Ration"],
	quality = 1,
	icon = "inv_misc_food_33",
	buyPrice = 2000,
	sellPrice = 100,
	reqLevel = 45,
}
t[19066] = {
	name = L["Warsong Gulch Runecloth Bandage"],
	quality = 1,
	icon = "inv_misc_bandage_12",
	buyPrice = 2000,
	sellPrice = 100,
	reqLevel = 45,
}
t[19514] = {
	name = L["Protector's Band"],
	quality = 3,
	icon = "inv_jewelry_ring_10",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 58,
}
t[19515] = {
	name = L["Protector's Band"],
	quality = 3,
	icon = "inv_jewelry_ring_10",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 38,
}
t[19516] = {
	name = L["Protector's Band"],
	quality = 3,
	icon = "inv_jewelry_ring_10",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 48,
}
t[19517] = {
	name = L["Protector's Band"],
	quality = 3,
	icon = "inv_jewelry_ring_10",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 28,
}
t[19522] = {
	name = L["Lorekeeper's Ring"],
	quality = 3,
	icon = "inv_jewelry_ring_28",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 58,
}
t[19523] = {
	name = L["Lorekeeper's Ring"],
	quality = 3,
	icon = "inv_jewelry_ring_28",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 48,
}
t[19524] = {
	name = L["Lorekeeper's Ring"],
	quality = 3,
	icon = "inv_jewelry_ring_28",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 38,
}
t[19525] = {
	name = L["Lorekeeper's Ring"],
	quality = 3,
	icon = "inv_jewelry_ring_28",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 28,
}
t[19530] = {
	name = L["Caretaker's Cape"],
	quality = 3,
	icon = "inv_misc_cape_13",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 58,
}
t[19531] = {
	name = L["Caretaker's Cape"],
	quality = 3,
	icon = "inv_misc_cape_13",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 48,
}
t[19532] = {
	name = L["Caretaker's Cape"],
	quality = 3,
	icon = "inv_misc_cape_13",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 38,
}
t[19533] = {
	name = L["Caretaker's Cape"],
	quality = 3,
	icon = "inv_misc_cape_13",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 28,
}
t[19538] = {
	name = L["Sentinel's Medallion"],
	quality = 3,
	icon = "inv_jewelry_necklace_13",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 58,
}
t[19539] = {
	name = L["Sentinel's Medallion"],
	quality = 3,
	icon = "inv_jewelry_necklace_13",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 48,
}
t[19540] = {
	name = L["Sentinel's Medallion"],
	quality = 3,
	icon = "inv_jewelry_necklace_13",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 38,
}
t[19541] = {
	name = L["Sentinel's Medallion"],
	quality = 3,
	icon = "inv_jewelry_necklace_13",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 28,
}
t[19546] = {
	name = L["Sentinel's Blade"],
	quality = 3,
	icon = "inv_weapon_shortblade_14",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 58,
}
t[19547] = {
	name = L["Sentinel's Blade"],
	quality = 3,
	icon = "inv_weapon_shortblade_14",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 48,
}
t[19548] = {
	name = L["Sentinel's Blade"],
	quality = 3,
	icon = "inv_weapon_shortblade_14",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 38,
}
t[19549] = {
	name = L["Sentinel's Blade"],
	quality = 3,
	icon = "inv_weapon_shortblade_14",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 28,
}
t[19554] = {
	name = L["Protector's Sword"],
	quality = 3,
	icon = "inv_sword_27",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 58,
}
t[19555] = {
	name = L["Protector's Sword"],
	quality = 3,
	icon = "inv_sword_27",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 48,
}
t[19556] = {
	name = L["Protector's Sword"],
	quality = 3,
	icon = "inv_sword_27",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 38,
}
t[19557] = {
	name = L["Protector's Sword"],
	quality = 3,
	icon = "inv_sword_27",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 28,
}
t[19562] = {
	name = L["Outrunner's Bow"],
	quality = 3,
	icon = "inv_weapon_bow_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 58,
}
t[19563] = {
	name = L["Outrunner's Bow"],
	quality = 3,
	icon = "inv_weapon_bow_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 48,
}
t[19564] = {
	name = L["Outrunner's Bow"],
	quality = 3,
	icon = "inv_weapon_bow_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 38,
}
t[19565] = {
	name = L["Outrunner's Bow"],
	quality = 3,
	icon = "inv_weapon_bow_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 28,
}
t[19570] = {
	name = L["Lorekeeper's Staff"],
	quality = 3,
	icon = "inv_staff_28",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 58,
}
t[19571] = {
	name = L["Lorekeeper's Staff"],
	quality = 3,
	icon = "inv_staff_28",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 48,
}
t[19572] = {
	name = L["Lorekeeper's Staff"],
	quality = 3,
	icon = "inv_staff_28",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 38,
}
t[19573] = {
	name = L["Lorekeeper's Staff"],
	quality = 3,
	icon = "inv_staff_28",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 28,
}
t[19578] = {
	name = L["Berserker Bracers"],
	quality = 4,
	icon = "inv_bracer_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[19580] = {
	name = L["Berserker Bracers"],
	quality = 4,
	icon = "inv_bracer_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 50,
}
t[19581] = {
	name = L["Berserker Bracers"],
	quality = 4,
	icon = "inv_bracer_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 40,
}
t[19582] = {
	name = L["Windtalker's Wristguards"],
	quality = 4,
	icon = "inv_bracer_03",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[19583] = {
	name = L["Windtalker's Wristguards"],
	quality = 4,
	icon = "inv_bracer_03",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 50,
}
t[19584] = {
	name = L["Windtalker's Wristguards"],
	quality = 4,
	icon = "inv_bracer_03",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 40,
}
t[19587] = {
	name = L["Forest Stalker's Bracers"],
	quality = 4,
	icon = "inv_bracer_12",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[19589] = {
	name = L["Forest Stalker's Bracers"],
	quality = 4,
	icon = "inv_bracer_12",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 50,
}
t[19590] = {
	name = L["Forest Stalker's Bracers"],
	quality = 4,
	icon = "inv_bracer_12",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 40,
}
t[19595] = {
	name = L["Dryad's Wrist Bindings"],
	quality = 4,
	icon = "inv_bracer_13",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[19596] = {
	name = L["Dryad's Wrist Bindings"],
	quality = 4,
	icon = "inv_bracer_13",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 50,
}
t[19597] = {
	name = L["Dryad's Wrist Bindings"],
	quality = 4,
	icon = "inv_bracer_13",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 40,
}
t[20428] = {
	name = L["Caretaker's Cape"],
	quality = 3,
	icon = "inv_misc_cape_13",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 18,
}
t[20431] = {
	name = L["Lorekeeper's Ring"],
	quality = 3,
	icon = "inv_jewelry_ring_28",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 18,
}
t[20434] = {
	name = L["Lorekeeper's Staff"],
	quality = 3,
	icon = "inv_staff_28",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 18,
}
t[20438] = {
	name = L["Outrunner's Bow"],
	quality = 3,
	icon = "inv_weapon_bow_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 18,
}
t[20439] = {
	name = L["Protector's Band"],
	quality = 3,
	icon = "inv_jewelry_ring_10",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 18,
}
t[20440] = {
	name = L["Protector's Sword"],
	quality = 3,
	icon = "inv_sword_27",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 18,
}
t[20443] = {
	name = L["Sentinel's Blade"],
	quality = 3,
	icon = "inv_weapon_shortblade_14",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 18,
}
t[20444] = {
	name = L["Sentinel's Medallion"],
	quality = 3,
	icon = "inv_jewelry_necklace_13",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 18,
}
t[21565] = {
	name = L["Rune of Perfection"],
	quality = 3,
	icon = "inv_misc_rune_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 40,
}
t[21566] = {
	name = L["Rune of Perfection"],
	quality = 3,
	icon = "inv_misc_rune_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 20,
}
t[21567] = {
	name = L["Rune of Duty"],
	quality = 3,
	icon = "inv_misc_rune_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 40,
}
t[21568] = {
	name = L["Rune of Duty"],
	quality = 3,
	icon = "inv_misc_rune_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 20,
}
t[22672] = {
	name = L["Sentinel's Plate Legguards"],
	quality = 4,
	icon = "inv_pants_plate_20",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[22748] = {
	name = L["Sentinel's Chain Leggings"],
	quality = 4,
	icon = "inv_pants_03",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[22749] = {
	name = L["Sentinel's Leather Pants"],
	quality = 4,
	icon = "inv_pants_leather_12",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[22750] = {
	name = L["Sentinel's Lizardhide Pants"],
	quality = 4,
	icon = "inv_pants_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[22752] = {
	name = L["Sentinel's Silk Leggings"],
	quality = 4,
	icon = "inv_pants_cloth_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[22753] = {
	name = L["Sentinel's Lamellar Legguards"],
	quality = 4,
	icon = "inv_pants_plate_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[30497] = {
	name = L["Sentinel's Mail Leggings"],
	quality = 4,
	icon = "inv_pants_03",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[44977] = {
	name = L["Recipe: Dig Rat Stew"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 800,
	sellPrice = 200,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Dig Rat Stew"],
	learnedAt = 90,
}
t[5051] = {
	name = L["Dig Rat"],
	quality = 1,
	icon = "inv_misc_pelt_bear_ruin_04",
	buyPrice = 1,
	sellPrice = 1,
	reqLevel = 0,
}
t[4765] = {
	name = L["Enamelled Broadsword"],
	quality = 2,
	icon = "inv_sword_20",
	buyPrice = 2878,
	sellPrice = 575,
	reqLevel = 9,
}
t[4766] = {
	name = L["Feral Blade"],
	quality = 2,
	icon = "inv_sword_24",
	buyPrice = 2407,
	sellPrice = 481,
	reqLevel = 8,
}
t[5488] = {
	name = L["Recipe: Crispy Lizard Tail"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 400,
	sellPrice = 100,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Crispy Lizard Tail"],
	learnedAt = 100,
}
t[5486] = {
	name = L["Recipe: Strider Stew"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 440,
	sellPrice = 110,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Strider Stew"],
	learnedAt = 50,
}
t[5772] = {
	name = L["Pattern: Red Woolen Bag"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 500,
	sellPrice = 125,
	reqLevel = 0,
	profession = L["Tailoring"],
	teaches = L["Red Woolen Bag"],
	learnedAt = 115,
}
t[6270] = {
	name = L["Pattern: Blue Linen Vest"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 200,
	sellPrice = 50,
	reqLevel = 0,
	profession = L["Tailoring"],
	teaches = L["Blue Linen Vest"],
	learnedAt = 55,
}
t[6272] = {
	name = L["Pattern: Blue Linen Robe"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 300,
	sellPrice = 75,
	reqLevel = 0,
	profession = L["Tailoring"],
	teaches = L["Blue Linen Robe"],
	learnedAt = 70,
}
t[4781] = {
	name = L["Whispering Vest"],
	quality = 2,
	icon = "inv_shirt_10",
	buyPrice = 2736,
	sellPrice = 547,
	reqLevel = 15,
}
t[4782] = {
	name = L["Solstice Robe"],
	quality = 2,
	icon = "inv_chest_cloth_17",
	buyPrice = 2077,
	sellPrice = 415,
	reqLevel = 13,
}
t[4786] = {
	name = L["Wise Man's Belt"],
	quality = 2,
	icon = "inv_belt_02",
	buyPrice = 1394,
	sellPrice = 278,
	reqLevel = 15,
}
t[4790] = {
	name = L["Inferno Cloak"],
	quality = 2,
	icon = "inv_misc_cape_18",
	buyPrice = 4159,
	sellPrice = 831,
	reqLevel = 20,
}
t[4792] = {
	name = L["Spirit Cloak"],
	quality = 2,
	icon = "inv_misc_cape_11",
	buyPrice = 3280,
	sellPrice = 656,
	reqLevel = 18,
}
t[4793] = {
	name = L["Sylvan Cloak"],
	quality = 2,
	icon = "inv_misc_cape_01",
	buyPrice = 3720,
	sellPrice = 744,
	reqLevel = 19,
}
t[11304] = {
	name = L["Fine Longbow"],
	quality = 2,
	icon = "inv_weapon_bow_02",
	buyPrice = 4862,
	sellPrice = 972,
	reqLevel = 14,
}
t[6053] = {
	name = L["Recipe: Holy Protection Potion"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 800,
	sellPrice = 200,
	reqLevel = 0,
	profession = L["Alchemy"],
	teaches = L["Holy Protection Potion"],
	learnedAt = 100,
}
t[4794] = {
	name = L["Wolf Bracers"],
	quality = 2,
	icon = "inv_bracer_04",
	buyPrice = 3515,
	sellPrice = 703,
	reqLevel = 20,
}
t[4795] = {
	name = L["Bear Bracers"],
	quality = 2,
	icon = "inv_bracer_07",
	buyPrice = 3528,
	sellPrice = 705,
	reqLevel = 20,
}
t[4796] = {
	name = L["Owl Bracers"],
	quality = 2,
	icon = "inv_bracer_04",
	buyPrice = 3540,
	sellPrice = 708,
	reqLevel = 20,
}
t[4797] = {
	name = L["Fiery Cloak"],
	quality = 2,
	icon = "inv_misc_cape_08",
	buyPrice = 4263,
	sellPrice = 852,
	reqLevel = 20,
}
t[4798] = {
	name = L["Heavy Runed Cloak"],
	quality = 2,
	icon = "inv_misc_cape_02",
	buyPrice = 3871,
	sellPrice = 774,
	reqLevel = 20,
}
t[4799] = {
	name = L["Antiquated Cloak"],
	quality = 2,
	icon = "inv_misc_cape_02",
	buyPrice = 3043,
	sellPrice = 608,
	reqLevel = 18,
}
t[4800] = {
	name = L["Mighty Chain Pants"],
	quality = 2,
	icon = "inv_pants_03",
	buyPrice = 6110,
	sellPrice = 1222,
	reqLevel = 18,
}
t[4816] = {
	name = L["Legionnaire's Leggings"],
	quality = 2,
	icon = "inv_pants_03",
	buyPrice = 7519,
	sellPrice = 1503,
	reqLevel = 19,
}
t[4820] = {
	name = L["Guardian Buckler"],
	quality = 2,
	icon = "inv_shield_10",
	buyPrice = 8321,
	sellPrice = 1664,
	reqLevel = 20,
}
t[4821] = {
	name = L["Bear Buckler"],
	quality = 2,
	icon = "inv_shield_09",
	buyPrice = 6541,
	sellPrice = 1308,
	reqLevel = 18,
}
t[4822] = {
	name = L["Owl's Disk"],
	quality = 2,
	icon = "inv_shield_09",
	buyPrice = 6746,
	sellPrice = 1349,
	reqLevel = 18,
}
t[14639] = {
	name = L["Schematic: Minor Recombobulator"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 1500,
	sellPrice = 375,
	reqLevel = 0,
	profession = L["Engineering"],
	teaches = L["Minor Recombobulator"],
	learnedAt = 140,
}
t[18648] = {
	name = L["Schematic: Green Firework"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 1800,
	sellPrice = 450,
	reqLevel = 0,
	profession = L["Engineering"],
	teaches = L["Green Firework"],
	learnedAt = 150,
}
t[6330] = {
	name = L["Recipe: Bristle Whisker Catfish"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 1200,
	sellPrice = 300,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Bristle Whisker Catfish"],
	learnedAt = 100,
}
t[6368] = {
	name = L["Recipe: Rainbow Fin Albacore"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 400,
	sellPrice = 100,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Rainbow Fin Albacore"],
	learnedAt = 50,
}
t[5640] = {
	name = L["Recipe: Rage Potion"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 100,
	sellPrice = 25,
	reqLevel = 0,
	profession = L["Alchemy"],
	teaches = L["Rage Potion"],
	learnedAt = 60,
}
t[6275] = {
	name = L["Pattern: Greater Adept's Robe"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 800,
	sellPrice = 200,
	reqLevel = 0,
	profession = L["Tailoring"],
	teaches = L["Greater Adept's Robe"],
	learnedAt = 115,
}
t[4777] = {
	name = L["Ironwood Maul"],
	quality = 2,
	icon = "inv_hammer_16",
	buyPrice = 7040,
	sellPrice = 1408,
	reqLevel = 13,
}
t[4778] = {
	name = L["Heavy Spiked Mace"],
	quality = 2,
	icon = "inv_mace_01",
	buyPrice = 7351,
	sellPrice = 1470,
	reqLevel = 14,
}
t[4788] = {
	name = L["Agile Boots"],
	quality = 2,
	icon = "inv_boots_05",
	buyPrice = 2634,
	sellPrice = 526,
	reqLevel = 15,
}
t[4789] = {
	name = L["Stable Boots"],
	quality = 2,
	icon = "inv_boots_03",
	buyPrice = 1999,
	sellPrice = 399,
	reqLevel = 13,
}
t[6274] = {
	name = L["Pattern: Blue Overalls"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 400,
	sellPrice = 100,
	reqLevel = 0,
	profession = L["Tailoring"],
	teaches = L["Blue Overalls"],
	learnedAt = 100,
}
t[8626] = {
	name = L["Blue Sparkler"],
	quality = 1,
	icon = "inv_wand_05",
	buyPrice = 1000,
	sellPrice = 250,
	reqLevel = 0,
}
t[8624] = {
	name = L["Red Sparkler"],
	quality = 1,
	icon = "inv_wand_06",
	buyPrice = 1000,
	sellPrice = 250,
	reqLevel = 0,
}
t[8625] = {
	name = L["White Sparkler"],
	quality = 1,
	icon = "inv_wand_07",
	buyPrice = 1000,
	sellPrice = 250,
	reqLevel = 0,
}
t[9317] = {
	name = L["Red, White and Blue Firework"],
	quality = 1,
	icon = "spell_holy_mindvision",
	buyPrice = 100,
	sellPrice = 25,
	reqLevel = 0,
}
t[9312] = {
	name = L["Blue Firework"],
	quality = 1,
	icon = "spell_ice_magicdamage",
	buyPrice = 20,
	sellPrice = 5,
	reqLevel = 0,
}
t[9313] = {
	name = L["Green Firework"],
	quality = 1,
	icon = "spell_nature_abolishmagic",
	buyPrice = 20,
	sellPrice = 5,
	reqLevel = 0,
}
t[9315] = {
	name = L["Yellow Rose Firework"],
	quality = 1,
	icon = "spell_holy_holybolt",
	buyPrice = 40,
	sellPrice = 10,
	reqLevel = 0,
}
t[9318] = {
	name = L["Red Firework"],
	quality = 1,
	icon = "spell_fire_fireball02",
	buyPrice = 20,
	sellPrice = 5,
	reqLevel = 0,
}
t[19505] = {
	name = L["Warsong Battle Tabard"],
	quality = 1,
	icon = "inv_shirt_guildtabard_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[19510] = {
	name = L["Legionnaire's Band"],
	quality = 3,
	icon = "inv_jewelry_ring_21",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 58,
}
t[19511] = {
	name = L["Legionnaire's Band"],
	quality = 3,
	icon = "inv_jewelry_ring_21",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 48,
}
t[19512] = {
	name = L["Legionnaire's Band"],
	quality = 3,
	icon = "inv_jewelry_ring_21",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 38,
}
t[19513] = {
	name = L["Legionnaire's Band"],
	quality = 3,
	icon = "inv_jewelry_ring_21",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 28,
}
t[19518] = {
	name = L["Advisor's Ring"],
	quality = 3,
	icon = "inv_jewelry_ring_20",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 58,
}
t[19519] = {
	name = L["Advisor's Ring"],
	quality = 3,
	icon = "inv_jewelry_ring_20",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 48,
}
t[19520] = {
	name = L["Advisor's Ring"],
	quality = 3,
	icon = "inv_jewelry_ring_20",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 38,
}
t[19521] = {
	name = L["Advisor's Ring"],
	quality = 3,
	icon = "inv_jewelry_ring_20",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 28,
}
t[19526] = {
	name = L["Battle Healer's Cloak"],
	quality = 3,
	icon = "inv_misc_cape_18",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 58,
}
t[19527] = {
	name = L["Battle Healer's Cloak"],
	quality = 3,
	icon = "inv_misc_cape_18",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 48,
}
t[19528] = {
	name = L["Battle Healer's Cloak"],
	quality = 3,
	icon = "inv_misc_cape_18",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 38,
}
t[19529] = {
	name = L["Battle Healer's Cloak"],
	quality = 3,
	icon = "inv_misc_cape_18",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 28,
}
t[19534] = {
	name = L["Scout's Medallion"],
	quality = 3,
	icon = "inv_jewelry_necklace_14",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 58,
}
t[19535] = {
	name = L["Scout's Medallion"],
	quality = 3,
	icon = "inv_jewelry_necklace_14",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 48,
}
t[19536] = {
	name = L["Scout's Medallion"],
	quality = 3,
	icon = "inv_jewelry_necklace_14",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 38,
}
t[19537] = {
	name = L["Scout's Medallion"],
	quality = 3,
	icon = "inv_jewelry_necklace_14",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 28,
}
t[19542] = {
	name = L["Scout's Blade"],
	quality = 3,
	icon = "inv_weapon_shortblade_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 58,
}
t[19543] = {
	name = L["Scout's Blade"],
	quality = 3,
	icon = "inv_weapon_shortblade_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 48,
}
t[19544] = {
	name = L["Scout's Blade"],
	quality = 3,
	icon = "inv_weapon_shortblade_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 38,
}
t[19545] = {
	name = L["Scout's Blade"],
	quality = 3,
	icon = "inv_weapon_shortblade_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 28,
}
t[19550] = {
	name = L["Legionnaire's Sword"],
	quality = 3,
	icon = "inv_sword_31",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 58,
}
t[19551] = {
	name = L["Legionnaire's Sword"],
	quality = 3,
	icon = "inv_sword_31",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 48,
}
t[19552] = {
	name = L["Legionnaire's Sword"],
	quality = 3,
	icon = "inv_sword_31",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 38,
}
t[19553] = {
	name = L["Legionnaire's Sword"],
	quality = 3,
	icon = "inv_sword_31",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 28,
}
t[19558] = {
	name = L["Outrider's Bow"],
	quality = 3,
	icon = "inv_weapon_bow_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 58,
}
t[19559] = {
	name = L["Outrider's Bow"],
	quality = 3,
	icon = "inv_weapon_bow_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 48,
}
t[19560] = {
	name = L["Outrider's Bow"],
	quality = 3,
	icon = "inv_weapon_bow_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 38,
}
t[19561] = {
	name = L["Outrider's Bow"],
	quality = 3,
	icon = "inv_weapon_bow_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 28,
}
t[19566] = {
	name = L["Advisor's Gnarled Staff"],
	quality = 3,
	icon = "inv_staff_25",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 58,
}
t[19567] = {
	name = L["Advisor's Gnarled Staff"],
	quality = 3,
	icon = "inv_staff_25",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 48,
}
t[19568] = {
	name = L["Advisor's Gnarled Staff"],
	quality = 3,
	icon = "inv_staff_25",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 38,
}
t[19569] = {
	name = L["Advisor's Gnarled Staff"],
	quality = 3,
	icon = "inv_staff_25",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 28,
}
t[20425] = {
	name = L["Advisor's Gnarled Staff"],
	quality = 3,
	icon = "inv_staff_25",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 18,
}
t[20426] = {
	name = L["Advisor's Ring"],
	quality = 3,
	icon = "inv_jewelry_ring_20",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 18,
}
t[20427] = {
	name = L["Battle Healer's Cloak"],
	quality = 3,
	icon = "inv_misc_cape_18",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 18,
}
t[20429] = {
	name = L["Legionnaire's Band"],
	quality = 3,
	icon = "inv_jewelry_ring_21",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 18,
}
t[20430] = {
	name = L["Legionnaire's Sword"],
	quality = 3,
	icon = "inv_sword_31",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 18,
}
t[20437] = {
	name = L["Outrider's Bow"],
	quality = 3,
	icon = "inv_weapon_bow_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 18,
}
t[20441] = {
	name = L["Scout's Blade"],
	quality = 3,
	icon = "inv_weapon_shortblade_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 18,
}
t[20442] = {
	name = L["Scout's Medallion"],
	quality = 3,
	icon = "inv_jewelry_necklace_14",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 18,
}
t[22651] = {
	name = L["Outrider's Plate Legguards"],
	quality = 4,
	icon = "inv_pants_plate_20",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[22673] = {
	name = L["Outrider's Chain Leggings"],
	quality = 4,
	icon = "inv_pants_03",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[22676] = {
	name = L["Outrider's Mail Leggings"],
	quality = 4,
	icon = "inv_pants_03",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[22740] = {
	name = L["Outrider's Leather Pants"],
	quality = 4,
	icon = "inv_pants_leather_12",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[22741] = {
	name = L["Outrider's Lizardhide Pants"],
	quality = 4,
	icon = "inv_pants_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[22747] = {
	name = L["Outrider's Silk Leggings"],
	quality = 4,
	icon = "inv_pants_cloth_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[30498] = {
	name = L["Outrider's Lamellar Legguards"],
	quality = 4,
	icon = "inv_pants_plate_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[35564] = {
	name = L["Recipe: Charred Bear Kabobs"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 18000,
	sellPrice = 4500,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Charred Bear Kabobs"],
	learnedAt = 250,
}
t[35566] = {
	name = L["Recipe: Juicy Bear Burger"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 18000,
	sellPrice = 4500,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Juicy Bear Burger"],
	learnedAt = 250,
}
t[16768] = {
	name = L["Furbolg Medicine Pouch"],
	quality = 2,
	icon = "inv_misc_bag_11",
	buyPrice = 150000,
	sellPrice = 37500,
	reqLevel = 0,
}
t[16769] = {
	name = L["Furbolg Medicine Totem"],
	quality = 2,
	icon = "inv_mace_11",
	buyPrice = 133081,
	sellPrice = 26616,
	reqLevel = 47,
}
t[13484] = {
	name = L["Recipe: Transmute Earth to Water"],
	quality = 2,
	icon = "inv_scroll_06",
	buyPrice = 15000,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Alchemy"],
	teaches = L["Transmute: Earth to Water"],
	learnedAt = 275,
}
t[19202] = {
	name = L["Plans: Heavy Timbermaw Belt"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 22000,
	sellPrice = 5500,
	reqLevel = 0,
	profession = L["Blacksmithing"],
	teaches = L["Heavy Timbermaw Belt"],
	learnedAt = 290,
}
t[19204] = {
	name = L["Plans: Heavy Timbermaw Boots"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 40000,
	sellPrice = 10000,
	reqLevel = 0,
	profession = L["Blacksmithing"],
	teaches = L["Heavy Timbermaw Boots"],
	learnedAt = 300,
}
t[19215] = {
	name = L["Pattern: Wisdom of the Timbermaw"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 22000,
	sellPrice = 5500,
	reqLevel = 0,
	profession = L["Tailoring"],
	teaches = L["Wisdom of the Timbermaw"],
	learnedAt = 290,
}
t[19218] = {
	name = L["Pattern: Mantle of the Timbermaw"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 40000,
	sellPrice = 10000,
	reqLevel = 0,
	profession = L["Tailoring"],
	teaches = L["Mantle of the Timbermaw"],
	learnedAt = 300,
}
t[19326] = {
	name = L["Pattern: Might of the Timbermaw"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 22000,
	sellPrice = 5500,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Might of the Timbermaw"],
	learnedAt = 290,
}
t[19327] = {
	name = L["Pattern: Timbermaw Brawlers"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 40000,
	sellPrice = 10000,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Timbermaw Brawlers"],
	learnedAt = 300,
}
t[19445] = {
	name = L["Formula: Enchant Weapon - Agility"],
	quality = 1,
	icon = "inv_misc_note_01",
	buyPrice = 30000,
	sellPrice = 7500,
	reqLevel = 0,
	profession = L["Enchanting"],
	teaches = L["Enchant Weapon - Agility"],
	learnedAt = 290,
}
t[20253] = {
	name = L["Pattern: Warbear Harness"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 16000,
	sellPrice = 4000,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Warbear Harness"],
	learnedAt = 275,
}
t[20254] = {
	name = L["Pattern: Warbear Woolies"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 20000,
	sellPrice = 5000,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Warbear Woolies"],
	learnedAt = 285,
}
t[22392] = {
	name = L["Formula: Enchant 2H Weapon - Agility"],
	quality = 1,
	icon = "inv_misc_note_01",
	buyPrice = 25000,
	sellPrice = 6250,
	reqLevel = 0,
	profession = L["Enchanting"],
	teaches = L["Enchant 2H Weapon - Agility"],
	learnedAt = 290,
}
t[18687] = {
	name = L["Xorothian Stardust"],
	quality = 1,
	icon = "inv_misc_dust_02",
	buyPrice = 1500000,
	sellPrice = 0,
	reqLevel = 0,
}
t[20970] = {
	name = L["Design: Pendant of the Agate Shield"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 1500,
	sellPrice = 375,
	reqLevel = 0,
}
t[6068] = {
	name = L["Recipe: Shadow Oil"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 1500,
	sellPrice = 375,
	reqLevel = 0,
	profession = L["Alchemy"],
	teaches = L["Shadow Oil"],
	learnedAt = 165,
}
t[11023] = {
	name = L["Ancona Chicken"],
	quality = 1,
	icon = "inv_crate_02",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 0,
}
t[7560] = {
	name = L["Schematic: Gnomish Universal Remote"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 1200,
	sellPrice = 300,
	reqLevel = 0,
	profession = L["Engineering"],
	teaches = L["Gnomish Universal Remote"],
	learnedAt = 125,
}
t[13309] = {
	name = L["Schematic: Lovingly Crafted Boomstick"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 1000,
	sellPrice = 250,
	reqLevel = 0,
	profession = L["Engineering"],
	teaches = L["Lovingly Crafted Boomstick"],
	learnedAt = 120,
}
t[13899] = {
	name = L["Red Traditional Hanbok"],
	quality = 1,
	icon = "inv_chest_cloth_24",
	buyPrice = 17641,
	sellPrice = 3528,
	reqLevel = 0,
}
t[13900] = {
	name = L["Green Wedding Hanbok"],
	quality = 1,
	icon = "inv_chest_cloth_22",
	buyPrice = 137214,
	sellPrice = 27442,
	reqLevel = 0,
}
t[13895] = {
	name = L["Formal Dangui"],
	quality = 1,
	icon = "inv_chest_cloth_29",
	buyPrice = 506622,
	sellPrice = 101324,
	reqLevel = 0,
}
t[13896] = {
	name = L["Dark Green Wedding Hanbok"],
	quality = 1,
	icon = "inv_chest_cloth_23",
	buyPrice = 55103,
	sellPrice = 11020,
	reqLevel = 0,
}
t[13897] = {
	name = L["White Traditional Hanbok"],
	quality = 1,
	icon = "inv_chest_cloth_50",
	buyPrice = 2977,
	sellPrice = 595,
	reqLevel = 0,
}
t[13898] = {
	name = L["Royal Dangui"],
	quality = 1,
	icon = "inv_chest_cloth_30",
	buyPrice = 288699,
	sellPrice = 57739,
	reqLevel = 0,
}
t[14469] = {
	name = L["Pattern: Runecloth Robe"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 12000,
	sellPrice = 3000,
	reqLevel = 0,
	profession = L["Tailoring"],
	teaches = L["Runecloth Robe"],
	learnedAt = 260,
}
t[14472] = {
	name = L["Pattern: Runecloth Cloak"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 12000,
	sellPrice = 3000,
	reqLevel = 0,
	profession = L["Tailoring"],
	teaches = L["Runecloth Cloak"],
	learnedAt = 265,
}
t[14483] = {
	name = L["Pattern: Felcloth Pants"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 16000,
	sellPrice = 4000,
	reqLevel = 0,
	profession = L["Tailoring"],
	teaches = L["Felcloth Pants"],
	learnedAt = 275,
}
t[16224] = {
	name = L["Formula: Enchant Cloak - Superior Defense"],
	quality = 1,
	icon = "inv_misc_note_01",
	buyPrice = 20000,
	sellPrice = 5000,
	reqLevel = 0,
	profession = L["Enchanting"],
	teaches = L["Enchant Cloak - Superior Defense"],
	learnedAt = 285,
}
t[16243] = {
	name = L["Formula: Runed Arcanite Rod"],
	quality = 1,
	icon = "inv_misc_note_01",
	buyPrice = 22000,
	sellPrice = 5500,
	reqLevel = 0,
	profession = L["Enchanting"],
	teaches = L["Runed Arcanite Rod"],
	learnedAt = 290,
}
t[21713] = {
	name = L["Elune's Candle"],
	quality = 1,
	icon = "inv_musket_02",
	buyPrice = 1000,
	sellPrice = 250,
	reqLevel = 0,
}
t[21557] = {
	name = L["Small Red Rocket"],
	quality = 1,
	icon = "inv_misc_missilesmall_red",
	buyPrice = 25,
	sellPrice = 6,
	reqLevel = 0,
}
t[21558] = {
	name = L["Small Blue Rocket"],
	quality = 1,
	icon = "inv_misc_missilesmall_blue",
	buyPrice = 25,
	sellPrice = 6,
	reqLevel = 0,
}
t[21559] = {
	name = L["Small Green Rocket"],
	quality = 1,
	icon = "inv_misc_missilesmall_green",
	buyPrice = 25,
	sellPrice = 6,
	reqLevel = 0,
}
t[21571] = {
	name = L["Blue Rocket Cluster"],
	quality = 1,
	icon = "inv_misc_missilesmallcluster_blue",
	buyPrice = 100,
	sellPrice = 25,
	reqLevel = 0,
}
t[21574] = {
	name = L["Green Rocket Cluster"],
	quality = 1,
	icon = "inv_misc_missilesmallcluster_green",
	buyPrice = 100,
	sellPrice = 25,
	reqLevel = 0,
}
t[21576] = {
	name = L["Red Rocket Cluster"],
	quality = 1,
	icon = "inv_misc_missilesmallcluster_red",
	buyPrice = 100,
	sellPrice = 25,
	reqLevel = 0,
}
t[21721] = {
	name = L["Moonglow"],
	quality = 1,
	icon = "inv_potion_20",
	buyPrice = 15,
	sellPrice = 3,
	reqLevel = 0,
}
t[21747] = {
	name = L["Festival Firecracker"],
	quality = 1,
	icon = "inv_misc_bomb_05",
	buyPrice = 300,
	sellPrice = 75,
	reqLevel = 0,
}
t[6055] = {
	name = L["Recipe: Fire Protection Potion"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 1500,
	sellPrice = 375,
	reqLevel = 0,
	profession = L["Alchemy"],
	teaches = L["Fire Protection Potion"],
	learnedAt = 165,
}
t[4827] = {
	name = L["Wizard's Belt"],
	quality = 2,
	icon = "inv_belt_29",
	buyPrice = 3749,
	sellPrice = 749,
	reqLevel = 23,
}
t[4828] = {
	name = L["Nightwind Belt"],
	quality = 2,
	icon = "inv_belt_26",
	buyPrice = 3420,
	sellPrice = 684,
	reqLevel = 22,
}
t[4829] = {
	name = L["Dreamer's Belt"],
	quality = 2,
	icon = "inv_belt_04",
	buyPrice = 4154,
	sellPrice = 830,
	reqLevel = 24,
}
t[4833] = {
	name = L["Glorious Shoulders"],
	quality = 2,
	icon = "inv_shoulder_05",
	buyPrice = 8658,
	sellPrice = 1731,
	reqLevel = 23,
}
t[4835] = {
	name = L["Elite Shoulders"],
	quality = 2,
	icon = "inv_shoulder_05",
	buyPrice = 10551,
	sellPrice = 2110,
	reqLevel = 25,
}
t[4836] = {
	name = L["Fireproof Orb"],
	quality = 2,
	icon = "inv_jewelry_talisman_01",
	buyPrice = 8002,
	sellPrice = 2000,
	reqLevel = 23,
}
t[4837] = {
	name = L["Strength of Will"],
	quality = 2,
	icon = "inv_jewelry_talisman_05",
	buyPrice = 8002,
	sellPrice = 2000,
	reqLevel = 25,
}
t[4838] = {
	name = L["Orb of Power"],
	quality = 2,
	icon = "inv_ore_arcanite_02",
	buyPrice = 8002,
	sellPrice = 2000,
	reqLevel = 21,
}
t[7561] = {
	name = L["Schematic: Goblin Jumper Cables"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 2000,
	sellPrice = 500,
	reqLevel = 0,
	profession = L["Engineering"],
	teaches = L["Goblin Jumper Cables"],
	learnedAt = 165,
}
t[15724] = {
	name = L["Pattern: Heavy Scorpid Bracers"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 12000,
	sellPrice = 3000,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Heavy Scorpid Bracers"],
	learnedAt = 255,
}
t[15762] = {
	name = L["Pattern: Heavy Scorpid Helm"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 25000,
	sellPrice = 6250,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Heavy Scorpid Helm"],
	learnedAt = 295,
}
t[22209] = {
	name = L["Plans: Heavy Obsidian Belt"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 50000,
	sellPrice = 12500,
	reqLevel = 0,
	profession = L["Blacksmithing"],
	teaches = L["Heavy Obsidian Belt"],
	learnedAt = 300,
}
t[22214] = {
	name = L["Plans: Light Obsidian Belt"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 50000,
	sellPrice = 12500,
	reqLevel = 0,
	profession = L["Blacksmithing"],
	teaches = L["Light Obsidian Belt"],
	learnedAt = 300,
}
t[22766] = {
	name = L["Plans: Ironvine Breastplate"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 50000,
	sellPrice = 12500,
	reqLevel = 0,
	profession = L["Blacksmithing"],
	teaches = L["Ironvine Breastplate"],
	learnedAt = 300,
}
t[22767] = {
	name = L["Plans: Ironvine Gloves"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 50000,
	sellPrice = 12500,
	reqLevel = 0,
	profession = L["Blacksmithing"],
	teaches = L["Ironvine Gloves"],
	learnedAt = 300,
}
t[22768] = {
	name = L["Plans: Ironvine Belt"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 50000,
	sellPrice = 12500,
	reqLevel = 0,
	profession = L["Blacksmithing"],
	teaches = L["Ironvine Belt"],
	learnedAt = 300,
}
t[21952] = {
	name = L["Design: Emerald Crown of Destruction"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 0,
}
t[22310] = {
	name = L["Pattern: Cenarion Herb Bag"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 20000,
	sellPrice = 5000,
	reqLevel = 0,
	profession = L["Tailoring"],
	teaches = L["Cenarion Herb Bag"],
	learnedAt = 275,
}
t[22312] = {
	name = L["Pattern: Satchel of Cenarius"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 50000,
	sellPrice = 12500,
	reqLevel = 0,
	profession = L["Tailoring"],
	teaches = L["Satchel of Cenarius"],
	learnedAt = 300,
}
t[22683] = {
	name = L["Pattern: Gaea's Embrace"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 90000,
	sellPrice = 22500,
	reqLevel = 0,
	profession = L["Tailoring"],
	teaches = L["Gaea's Embrace"],
	learnedAt = 300,
}
t[22772] = {
	name = L["Pattern: Sylvan Shoulders"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 50000,
	sellPrice = 12500,
	reqLevel = 0,
	profession = L["Tailoring"],
	teaches = L["Sylvan Shoulders"],
	learnedAt = 300,
}
t[22773] = {
	name = L["Pattern: Sylvan Crown"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 50000,
	sellPrice = 12500,
	reqLevel = 0,
	profession = L["Tailoring"],
	teaches = L["Sylvan Crown"],
	learnedAt = 300,
}
t[22774] = {
	name = L["Pattern: Sylvan Vest"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 50000,
	sellPrice = 12500,
	reqLevel = 0,
	profession = L["Tailoring"],
	teaches = L["Sylvan Vest"],
	learnedAt = 300,
}
t[20382] = {
	name = L["Pattern: Dreamscale Breastplate"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 60000,
	sellPrice = 15000,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Dreamscale Breastplate"],
	learnedAt = 300,
}
t[20506] = {
	name = L["Pattern: Spitfire Bracers"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 40000,
	sellPrice = 10000,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Spitfire Bracers"],
	learnedAt = 300,
}
t[20507] = {
	name = L["Pattern: Spitfire Gauntlets"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 40000,
	sellPrice = 10000,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Spitfire Gauntlets"],
	learnedAt = 300,
}
t[20508] = {
	name = L["Pattern: Spitfire Breastplate"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 40000,
	sellPrice = 10000,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Spitfire Breastplate"],
	learnedAt = 300,
}
t[20509] = {
	name = L["Pattern: Sandstalker Bracers"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 40000,
	sellPrice = 10000,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Sandstalker Bracers"],
	learnedAt = 300,
}
t[20510] = {
	name = L["Pattern: Sandstalker Gauntlets"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 40000,
	sellPrice = 10000,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Sandstalker Gauntlets"],
	learnedAt = 300,
}
t[20511] = {
	name = L["Pattern: Sandstalker Breastplate"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 40000,
	sellPrice = 10000,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Sandstalker Breastplate"],
	learnedAt = 300,
}
t[22769] = {
	name = L["Pattern: Bramblewood Belt"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 50000,
	sellPrice = 12500,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Bramblewood Belt"],
	learnedAt = 300,
}
t[22770] = {
	name = L["Pattern: Bramblewood Boots"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 50000,
	sellPrice = 12500,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Bramblewood Boots"],
	learnedAt = 300,
}
t[22771] = {
	name = L["Pattern: Bramblewood Helm"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 50000,
	sellPrice = 12500,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Bramblewood Helm"],
	learnedAt = 300,
}
t[20732] = {
	name = L["Formula: Enchant Cloak - Greater Fire Resistance"],
	quality = 1,
	icon = "inv_misc_note_01",
	buyPrice = 100000,
	sellPrice = 25000,
	reqLevel = 0,
	profession = L["Enchanting"],
	teaches = L["Enchant Cloak - Greater Fire Resistance"],
	learnedAt = 300,
}
t[20733] = {
	name = L["Formula: Enchant Cloak - Greater Nature Resistance"],
	quality = 1,
	icon = "inv_misc_note_01",
	buyPrice = 100000,
	sellPrice = 25000,
	reqLevel = 0,
	profession = L["Enchanting"],
	teaches = L["Enchant Cloak - Greater Nature Resistance"],
	learnedAt = 300,
}
t[20754] = {
	name = L["Formula: Lesser Mana Oil"],
	quality = 1,
	icon = "inv_misc_note_01",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 0,
	profession = L["Enchanting"],
	teaches = L["Lesser Mana Oil"],
	learnedAt = 250,
}
t[20755] = {
	name = L["Formula: Wizard Oil"],
	quality = 1,
	icon = "inv_misc_note_01",
	buyPrice = 20000,
	sellPrice = 5000,
	reqLevel = 0,
	profession = L["Enchanting"],
	teaches = L["Wizard Oil"],
	learnedAt = 275,
}
t[22308] = {
	name = L["Pattern: Enchanted Runecloth Bag"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 20000,
	sellPrice = 5000,
	reqLevel = 0,
	profession = L["Tailoring"],
	teaches = L["Enchanted Runecloth Bag"],
	learnedAt = 275,
}
t[23160] = {
	name = L["Friendship Bread"],
	quality = 1,
	icon = "inv_misc_food_35",
	buyPrice = 4000,
	sellPrice = 200,
	reqLevel = 45,
}
t[23161] = {
	name = L["Freshly-Squeezed Lemonade"],
	quality = 1,
	icon = "inv_drink_14",
	buyPrice = 4000,
	sellPrice = 200,
	reqLevel = 45,
}
t[5786] = {
	name = L["Pattern: Murloc Scale Belt"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 550,
	sellPrice = 137,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Murloc Scale Belt"],
	learnedAt = 90,
}
t[5787] = {
	name = L["Pattern: Murloc Scale Breastplate"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 600,
	sellPrice = 150,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Murloc Scale Breastplate"],
	learnedAt = 95,
}
t[5485] = {
	name = L["Recipe: Fillet of Frenzy"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 400,
	sellPrice = 100,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Fillet of Frenzy"],
	learnedAt = 50,
}
t[5528] = {
	name = L["Recipe: Clam Chowder"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 800,
	sellPrice = 200,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Clam Chowder"],
	learnedAt = 90,
}
t[85] = {
	name = L["Dirty Leather Vest"],
	quality = 1,
	icon = "inv_shirt_07",
	buyPrice = 63,
	sellPrice = 12,
	reqLevel = 1,
}
t[209] = {
	name = L["Dirty Leather Pants"],
	quality = 1,
	icon = "inv_pants_wolf",
	buyPrice = 61,
	sellPrice = 12,
	reqLevel = 1,
}
t[210] = {
	name = L["Dirty Leather Boots"],
	quality = 1,
	icon = "inv_boots_06",
	buyPrice = 45,
	sellPrice = 9,
	reqLevel = 1,
}
t[714] = {
	name = L["Dirty Leather Gloves"],
	quality = 1,
	icon = "inv_gauntlets_18",
	buyPrice = 32,
	sellPrice = 6,
	reqLevel = 1,
}
t[1835] = {
	name = L["Dirty Leather Belt"],
	quality = 1,
	icon = "inv_belt_04",
	buyPrice = 31,
	sellPrice = 6,
	reqLevel = 1,
}
t[1836] = {
	name = L["Dirty Leather Bracers"],
	quality = 1,
	icon = "inv_bracer_04",
	buyPrice = 31,
	sellPrice = 6,
	reqLevel = 1,
}
t[2386] = {
	name = L["Rusted Chain Vest"],
	quality = 1,
	icon = "inv_chest_chain",
	buyPrice = 78,
	sellPrice = 15,
	reqLevel = 1,
}
t[2387] = {
	name = L["Rusted Chain Belt"],
	quality = 1,
	icon = "inv_belt_06",
	buyPrice = 39,
	sellPrice = 7,
	reqLevel = 1,
}
t[2388] = {
	name = L["Rusted Chain Leggings"],
	quality = 1,
	icon = "inv_pants_03",
	buyPrice = 78,
	sellPrice = 15,
	reqLevel = 1,
}
t[2389] = {
	name = L["Rusted Chain Boots"],
	quality = 1,
	icon = "inv_boots_01",
	buyPrice = 59,
	sellPrice = 11,
	reqLevel = 1,
}
t[2390] = {
	name = L["Rusted Chain Bracers"],
	quality = 1,
	icon = "inv_bracer_05",
	buyPrice = 39,
	sellPrice = 7,
	reqLevel = 1,
}
t[2391] = {
	name = L["Rusted Chain Gloves"],
	quality = 1,
	icon = "inv_gauntlets_04",
	buyPrice = 39,
	sellPrice = 7,
	reqLevel = 1,
}
t[2510] = {
	name = L["Solid Blunderbuss"],
	quality = 1,
	icon = "inv_weapon_rifle_07",
	buyPrice = 41,
	sellPrice = 8,
	reqLevel = 1,
}
t[5484] = {
	name = L["Recipe: Roasted Kodo Meat"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 240,
	sellPrice = 60,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Roasted Kodo Meat"],
	learnedAt = 35,
}
t[15277] = {
	name = L["Gray Kodo"],
	quality = 3,
	icon = "ability_mount_kodo_01",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 20,
}
t[15290] = {
	name = L["Brown Kodo"],
	quality = 3,
	icon = "ability_mount_kodo_03",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 20,
}
t[18793] = {
	name = L["Great White Kodo"],
	quality = 4,
	icon = "ability_mount_kodo_01",
	buyPrice = 100000,
	sellPrice = 25000,
	reqLevel = 40,
}
t[18794] = {
	name = L["Great Brown Kodo"],
	quality = 4,
	icon = "ability_mount_kodo_03",
	buyPrice = 100000,
	sellPrice = 25000,
	reqLevel = 40,
}
t[18795] = {
	name = L["Great Gray Kodo"],
	quality = 4,
	icon = "ability_mount_kodo_01",
	buyPrice = 100000,
	sellPrice = 25000,
	reqLevel = 40,
}
t[46100] = {
	name = L["White Kodo"],
	quality = 3,
	icon = "ability_mount_kodo_01",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 20,
}
t[6325] = {
	name = L["Recipe: Brilliant Smallfish"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 40,
	sellPrice = 10,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Brilliant Smallfish"],
	learnedAt = 1,
}
t[6328] = {
	name = L["Recipe: Longjaw Mud Snapper"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 400,
	sellPrice = 100,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Longjaw Mud Snapper"],
	learnedAt = 50,
}
t[193] = {
	name = L["Tattered Cloth Vest"],
	quality = 1,
	icon = "inv_shirt_black_01",
	buyPrice = 49,
	sellPrice = 9,
	reqLevel = 1,
}
t[194] = {
	name = L["Tattered Cloth Pants"],
	quality = 1,
	icon = "inv_pants_12",
	buyPrice = 49,
	sellPrice = 9,
	reqLevel = 1,
}
t[195] = {
	name = L["Tattered Cloth Boots"],
	quality = 1,
	icon = "inv_boots_05",
	buyPrice = 37,
	sellPrice = 7,
	reqLevel = 1,
}
t[711] = {
	name = L["Tattered Cloth Gloves"],
	quality = 1,
	icon = "inv_gauntlets_27",
	buyPrice = 26,
	sellPrice = 5,
	reqLevel = 1,
}
t[3595] = {
	name = L["Tattered Cloth Belt"],
	quality = 1,
	icon = "inv_belt_24",
	buyPrice = 24,
	sellPrice = 4,
	reqLevel = 1,
}
t[3596] = {
	name = L["Tattered Cloth Bracers"],
	quality = 1,
	icon = "inv_bracer_07",
	buyPrice = 24,
	sellPrice = 4,
	reqLevel = 1,
}
t[5483] = {
	name = L["Recipe: Scorpid Surprise"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 140,
	sellPrice = 35,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Scorpid Surprise"],
	learnedAt = 20,
}
t[6326] = {
	name = L["Recipe: Slitherskin Mackerel"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 40,
	sellPrice = 10,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Slitherskin Mackerel"],
	learnedAt = 1,
}
t[8588] = {
	name = L["Whistle of the Emerald Raptor"],
	quality = 3,
	icon = "ability_mount_raptor",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 20,
}
t[8591] = {
	name = L["Whistle of the Turquoise Raptor"],
	quality = 3,
	icon = "ability_mount_raptor",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 20,
}
t[8592] = {
	name = L["Whistle of the Violet Raptor"],
	quality = 3,
	icon = "ability_mount_raptor",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 20,
}
t[18788] = {
	name = L["Swift Blue Raptor"],
	quality = 4,
	icon = "ability_mount_raptor",
	buyPrice = 100000,
	sellPrice = 25000,
	reqLevel = 40,
}
t[18789] = {
	name = L["Swift Olive Raptor"],
	quality = 4,
	icon = "ability_mount_raptor",
	buyPrice = 100000,
	sellPrice = 25000,
	reqLevel = 40,
}
t[18790] = {
	name = L["Swift Orange Raptor"],
	quality = 4,
	icon = "ability_mount_raptor",
	buyPrice = 100000,
	sellPrice = 25000,
	reqLevel = 40,
}
t[34850] = {
	name = L["Midsummer Ground Flower"],
	quality = 1,
	icon = "inv_summerfest_groundflower",
	buyPrice = 100,
	sellPrice = 25,
	reqLevel = 0,
}
t[34020] = {
	name = L["Jungle River Water"],
	quality = 1,
	icon = "inv_drink_08",
	buyPrice = 100,
	sellPrice = 25,
	reqLevel = 25,
}
t[34021] = {
	name = L["Brewdoo Magic"],
	quality = 1,
	icon = "inv_drink_08",
	buyPrice = 200,
	sellPrice = 50,
	reqLevel = 35,
}
t[34022] = {
	name = L["Stout Shrunken Head"],
	quality = 1,
	icon = "inv_drink_08",
	buyPrice = 400,
	sellPrice = 100,
	reqLevel = 45,
}
t[46401] = {
	name = L["Crimson Stripe"],
	quality = 1,
	icon = "inv_drink_08",
	buyPrice = 1040,
	sellPrice = 260,
	reqLevel = 75,
}
t[33043] = {
	name = L["The Essential Brewfest Pretzel"],
	quality = 1,
	icon = "inv_holiday_beerfestpretzel01",
	buyPrice = 3,
	sellPrice = 0,
	reqLevel = 1,
}
t[34065] = {
	name = L["Spiced Onion Cheese"],
	quality = 1,
	icon = "inv_misc_food_94_garadarsharp-",
	buyPrice = 15,
	sellPrice = 3,
	reqLevel = 5,
}
t[33023] = {
	name = L["Savory Sausage"],
	quality = 1,
	icon = "inv_holiday_beerfestsausage01",
	buyPrice = 200,
	sellPrice = 50,
	reqLevel = 35,
}
t[33024] = {
	name = L["Pickled Sausage"],
	quality = 1,
	icon = "inv_holiday_beerfestsausage02",
	buyPrice = 400,
	sellPrice = 100,
	reqLevel = 45,
}
t[33025] = {
	name = L["Spicy Smoked Sausage"],
	quality = 1,
	icon = "inv_holiday_beerfestsausage03",
	buyPrice = 500,
	sellPrice = 125,
	reqLevel = 55,
}
t[33026] = {
	name = L["The Golden Link"],
	quality = 1,
	icon = "inv_holiday_beerfestsausage04",
	buyPrice = 800,
	sellPrice = 200,
	reqLevel = 65,
}
t[34063] = {
	name = L["Dried Sausage"],
	quality = 1,
	icon = "inv_misc_food_49",
	buyPrice = 50,
	sellPrice = 12,
	reqLevel = 15,
}
t[34064] = {
	name = L["Succulent Sausage"],
	quality = 1,
	icon = "inv_misc_food_53",
	buyPrice = 100,
	sellPrice = 25,
	reqLevel = 25,
}
t[34008] = {
	name = L["Blix's Eyesight Enhancing Romance Goggles"],
	quality = 1,
	icon = "inv_gizmo_newgoggles",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[32233] = {
	name = L["Wolpertinger's Tankard"],
	quality = 3,
	icon = "inv_drink_13",
	buyPrice = 5000,
	sellPrice = 1250,
	reqLevel = 0,
}
t[33862] = {
	name = L["Brewfest Regalia"],
	quality = 1,
	icon = "inv_chest_cloth_69",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[33863] = {
	name = L["Brewfest Dress"],
	quality = 1,
	icon = "inv_chest_cloth_70",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[33864] = {
	name = L["Brown Brewfest Hat"],
	quality = 1,
	icon = "inv_helmet_118",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[33868] = {
	name = L["Brewfest Boots"],
	quality = 1,
	icon = "inv_boots_cloth_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[33927] = {
	name = L["Brewfest Pony Keg"],
	quality = 3,
	icon = "inv_cask_04",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[33966] = {
	name = L["Brewfest Slippers"],
	quality = 1,
	icon = "inv_boots_cloth_18",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[33967] = {
	name = L["Green Brewfest Hat"],
	quality = 1,
	icon = "inv_helmet_117",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[33968] = {
	name = L["Blue Brewfest Hat"],
	quality = 1,
	icon = "inv_helmet_120",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[33969] = {
	name = L["Purple Brewfest Hat"],
	quality = 1,
	icon = "inv_helmet_119",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[34028] = {
	name = L["\"Honorary Brewer\" Hand Stamp"],
	quality = 1,
	icon = "ability_mount_mountainram",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 40,
}
t[37599] = {
	name = L["\"Brew of the Month\" Club Membership Form"],
	quality = 1,
	icon = "inv_misc_note_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 1,
}
t[37737] = {
	name = L["\"Brew of the Month\" Club Membership Form"],
	quality = 1,
	icon = "inv_misc_note_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 1,
}
t[37750] = {
	name = L["Fresh Brewfest Hops"],
	quality = 1,
	icon = "inv_misc_herb_08",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 20,
}
t[37816] = {
	name = L["Preserved Brewfest Hops"],
	quality = 2,
	icon = "inv_misc_herb_08",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 20,
}
t[39477] = {
	name = L["Fresh Dwarven Brewfest Hops"],
	quality = 1,
	icon = "inv_misc_herb_08",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 20,
}
t[46707] = {
	name = L["Pint-Sized Pink Pachyderm"],
	quality = 3,
	icon = "ability_mount_ridingelekk_purple",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[34017] = {
	name = L["Small Step Brew"],
	quality = 1,
	icon = "inv_drink_08",
	buyPrice = 3,
	sellPrice = 1,
	reqLevel = 1,
}
t[34018] = {
	name = L["Long Stride Brew"],
	quality = 1,
	icon = "inv_drink_08",
	buyPrice = 15,
	sellPrice = 3,
	reqLevel = 5,
}
t[34019] = {
	name = L["Path of Brew"],
	quality = 1,
	icon = "inv_drink_08",
	buyPrice = 50,
	sellPrice = 12,
	reqLevel = 15,
}
t[46402] = {
	name = L["Promise of the Pandaren"],
	quality = 1,
	icon = "inv_drink_08",
	buyPrice = 1040,
	sellPrice = 260,
	reqLevel = 75,
}
t[33976] = {
	name = L["Brewfest Ram"],
	quality = 3,
	icon = "ability_mount_mountainram",
	buyPrice = 100000,
	sellPrice = 0,
	reqLevel = 20,
}
t[33977] = {
	name = L["Swift Brewfest Ram"],
	quality = 4,
	icon = "ability_mount_mountainram",
	buyPrice = 1000000,
	sellPrice = 0,
	reqLevel = 40,
}
t[13482] = {
	name = L["Recipe: Transmute Air to Fire"],
	quality = 2,
	icon = "inv_scroll_06",
	buyPrice = 15000,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Alchemy"],
	teaches = L["Transmute: Air to Fire"],
	learnedAt = 275,
}
t[13724] = {
	name = L["Enriched Manna Biscuit"],
	quality = 1,
	icon = "inv_misc_food_33",
	buyPrice = 6000,
	sellPrice = 300,
	reqLevel = 45,
}
t[13810] = {
	name = L["Blessed Sunfruit"],
	quality = 1,
	icon = "inv_misc_food_41",
	buyPrice = 6000,
	sellPrice = 300,
	reqLevel = 45,
}
t[13813] = {
	name = L["Blessed Sunfruit Juice"],
	quality = 1,
	icon = "inv_drink_16",
	buyPrice = 6000,
	sellPrice = 300,
	reqLevel = 45,
}
t[18169] = {
	name = L["Flame Mantle of the Dawn"],
	quality = 2,
	icon = "spell_fire_flameshock",
	buyPrice = 100000,
	sellPrice = 25000,
	reqLevel = 50,
}
t[18170] = {
	name = L["Frost Mantle of the Dawn"],
	quality = 2,
	icon = "spell_frost_frostshock",
	buyPrice = 100000,
	sellPrice = 25000,
	reqLevel = 50,
}
t[18171] = {
	name = L["Arcane Mantle of the Dawn"],
	quality = 2,
	icon = "spell_holy_wordfortitude",
	buyPrice = 100000,
	sellPrice = 25000,
	reqLevel = 50,
}
t[18172] = {
	name = L["Nature Mantle of the Dawn"],
	quality = 2,
	icon = "spell_nature_protectionformnature",
	buyPrice = 100000,
	sellPrice = 25000,
	reqLevel = 50,
}
t[18173] = {
	name = L["Shadow Mantle of the Dawn"],
	quality = 2,
	icon = "spell_shadow_ragingscream",
	buyPrice = 100000,
	sellPrice = 25000,
	reqLevel = 50,
}
t[18182] = {
	name = L["Chromatic Mantle of the Dawn"],
	quality = 2,
	icon = "inv_misc_gem_variety_02",
	buyPrice = 400000,
	sellPrice = 100000,
	reqLevel = 50,
}
t[19203] = {
	name = L["Plans: Girdle of the Dawn"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 22000,
	sellPrice = 5500,
	reqLevel = 0,
	profession = L["Blacksmithing"],
	teaches = L["Girdle of the Dawn"],
	learnedAt = 290,
}
t[19205] = {
	name = L["Plans: Gloves of the Dawn"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 40000,
	sellPrice = 10000,
	reqLevel = 0,
	profession = L["Blacksmithing"],
	teaches = L["Gloves of the Dawn"],
	learnedAt = 300,
}
t[19216] = {
	name = L["Pattern: Argent Boots"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 22000,
	sellPrice = 5500,
	reqLevel = 0,
	profession = L["Tailoring"],
	teaches = L["Argent Boots"],
	learnedAt = 290,
}
t[19217] = {
	name = L["Pattern: Argent Shoulders"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 40000,
	sellPrice = 10000,
	reqLevel = 0,
	profession = L["Tailoring"],
	teaches = L["Argent Shoulders"],
	learnedAt = 300,
}
t[19328] = {
	name = L["Pattern: Dawn Treaders"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 22000,
	sellPrice = 5500,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Dawn Treaders"],
	learnedAt = 290,
}
t[19329] = {
	name = L["Pattern: Golden Mantle of the Dawn"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 40000,
	sellPrice = 10000,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Golden Mantle of the Dawn"],
	learnedAt = 300,
}
t[19442] = {
	name = L["Formula: Powerful Anti-Venom"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 100000,
	sellPrice = 25000,
	reqLevel = 0,
	profession = L["First Aid"],
	teaches = L["Powerful Anti-Venom"],
	learnedAt = 300,
}
t[19446] = {
	name = L["Formula: Enchant Bracer - Mana Regeneration"],
	quality = 1,
	icon = "inv_misc_note_01",
	buyPrice = 30000,
	sellPrice = 7500,
	reqLevel = 0,
	profession = L["Enchanting"],
	teaches = L["Enchant Bracer - Mana Regeneration"],
	learnedAt = 290,
}
t[19447] = {
	name = L["Formula: Enchant Bracer - Healing Power"],
	quality = 1,
	icon = "inv_misc_note_01",
	buyPrice = 60000,
	sellPrice = 15000,
	reqLevel = 0,
	profession = L["Enchanting"],
	teaches = L["Enchant Bracer - Healing Power"],
	learnedAt = 300,
}
t[22014] = {
	name = L["Hallowed Brazier"],
	quality = 1,
	icon = "inv_misc_enggizmos_21",
	buyPrice = 1333333,
	sellPrice = 333333,
	reqLevel = 0,
}
t[15902] = {
	name = L["A Crazy Grab Bag"],
	quality = 1,
	icon = "inv_box_01",
	buyPrice = 80000,
	sellPrice = 20000,
	reqLevel = 0,
}
t[21954] = {
	name = L["Design: Ring of Bitter Shadows"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 0,
}
t[22999] = {
	name = L["Tabard of the Argent Dawn"],
	quality = 1,
	icon = "inv_shirt_guildtabard_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[23122] = {
	name = L["Consecrated Sharpening Stone"],
	quality = 2,
	icon = "inv_stone_sharpeningstone_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 50,
}
t[23123] = {
	name = L["Blessed Wizard Oil"],
	quality = 2,
	icon = "inv_potion_26",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 50,
}
t[40492] = {
	name = L["Argent War Horn"],
	quality = 3,
	icon = "inv_misc_horn_03",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[40593] = {
	name = L["Argent Tome"],
	quality = 3,
	icon = "inv_misc_book_13",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[40601] = {
	name = L["Argent Dawn Banner"],
	quality = 3,
	icon = "inv_bannerpvp_03",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[43068] = {
	name = L["Blessed Spaulders of Undead Slaying"],
	quality = 4,
	icon = "inv_shoulder_21",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[43070] = {
	name = L["Blessed Gauntlets of Undead Slaying"],
	quality = 4,
	icon = "inv_gauntlets_28",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[43073] = {
	name = L["Blessed Gloves of Undead Cleansing"],
	quality = 4,
	icon = "inv_gauntlets_27",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[43074] = {
	name = L["Blessed Mantle of Undead Cleansing"],
	quality = 4,
	icon = "inv_shoulder_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[43077] = {
	name = L["Blessed Shoulderpads of Undead Slaying"],
	quality = 4,
	icon = "inv_shoulder_12",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[43078] = {
	name = L["Blessed Grips of Undead Slaying"],
	quality = 4,
	icon = "inv_gauntlets_47",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[43081] = {
	name = L["Blessed Pauldrons of Undead Slaying"],
	quality = 4,
	icon = "inv_shoulder_14",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[43082] = {
	name = L["Blessed Handguards of Undead Slaying"],
	quality = 4,
	icon = "inv_gauntlets_11",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[43530] = {
	name = L["Argent Mana Potion"],
	quality = 1,
	icon = "inv_potion_137",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 55,
}
t[43531] = {
	name = L["Argent Healing Potion"],
	quality = 1,
	icon = "inv_potion_131",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 55,
}
t[38645] = {
	name = L["Bone-Plated Armor"],
	quality = 1,
	icon = "inv_chest_plate04",
	buyPrice = 49791,
	sellPrice = 9958,
	reqLevel = 45,
}
t[38646] = {
	name = L["Bone-Plated Belt"],
	quality = 1,
	icon = "inv_belt_15",
	buyPrice = 25129,
	sellPrice = 5025,
	reqLevel = 45,
}
t[38647] = {
	name = L["Bone-Plated Boots"],
	quality = 1,
	icon = "inv_boots_plate_08",
	buyPrice = 37540,
	sellPrice = 7508,
	reqLevel = 45,
}
t[38648] = {
	name = L["Bone-Plated Bracers"],
	quality = 1,
	icon = "inv_bracer_14",
	buyPrice = 25309,
	sellPrice = 5061,
	reqLevel = 45,
}
t[38649] = {
	name = L["Bone-Plated Gloves"],
	quality = 1,
	icon = "inv_gauntlets_29",
	buyPrice = 25400,
	sellPrice = 5080,
	reqLevel = 45,
}
t[38650] = {
	name = L["Bone-Plated Helm"],
	quality = 1,
	icon = "inv_helmet_03",
	buyPrice = 37944,
	sellPrice = 7588,
	reqLevel = 45,
}
t[38651] = {
	name = L["Bone-Plated Leggings"],
	quality = 1,
	icon = "inv_pants_04",
	buyPrice = 50870,
	sellPrice = 10174,
	reqLevel = 45,
}
t[33452] = {
	name = L["Honey-Spiced Lichen"],
	quality = 1,
	icon = "inv_misc_food_109_honeylichen",
	buyPrice = 8500,
	sellPrice = 425,
	reqLevel = 65,
}
t[35947] = {
	name = L["Sparkling Frostcap"],
	quality = 1,
	icon = "inv_misc_food_112_frostcaps",
	buyPrice = 16000,
	sellPrice = 800,
	reqLevel = 75,
}
t[40775] = {
	name = L["Winged Steed of the Ebon Blade"],
	quality = 4,
	icon = "ability_mount_ebonblade",
	buyPrice = 10000000,
	sellPrice = 0,
	reqLevel = 60,
}
t[12164] = {
	name = L["Plans: Massive Iron Axe"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 4400,
	sellPrice = 1100,
	reqLevel = 0,
	profession = L["Blacksmithing"],
	teaches = L["Massive Iron Axe"],
	learnedAt = 185,
}
t[3682] = {
	name = L["Recipe: Curiously Tasty Omelet"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 1600,
	sellPrice = 400,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Curiously Tasty Omelet"],
	learnedAt = 130,
}
t[16111] = {
	name = L["Recipe: Spiced Chili Crab"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 12000,
	sellPrice = 3000,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Spiced Chili Crab"],
	learnedAt = 225,
}
t[12163] = {
	name = L["Plans: Moonsteel Broadsword"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 4400,
	sellPrice = 1100,
	reqLevel = 0,
	profession = L["Blacksmithing"],
	teaches = L["Moonsteel Broadsword"],
	learnedAt = 180,
}
t[36783] = {
	name = L["Northsea Pearl"],
	quality = 2,
	icon = "inv_misc_gem_pearl_09",
	buyPrice = 0,
	sellPrice = 5000,
	reqLevel = 0,
}
t[36784] = {
	name = L["Siren's Tear"],
	quality = 3,
	icon = "inv_misc_gem_pearl_11",
	buyPrice = 0,
	sellPrice = 10000,
	reqLevel = 0,
}
t[37449] = {
	name = L["Breath of Murloc"],
	quality = 1,
	icon = "inv_potion_17",
	buyPrice = 0,
	sellPrice = 200,
	reqLevel = 0,
}
t[37461] = {
	name = L["Tidebreaker Trident"],
	quality = 3,
	icon = "inv_spear_04",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[37462] = {
	name = L["Sea King's Crown"],
	quality = 2,
	icon = "inv_helmet_13",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[37463] = {
	name = L["Winterfin Patch of Honor"],
	quality = 2,
	icon = "inv_helmet_46",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[37464] = {
	name = L["Winterfin Horn of Distress"],
	quality = 1,
	icon = "inv_misc_shell_04",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[38350] = {
	name = L["Winterfin \"Depth Charge\""],
	quality = 1,
	icon = "inv_drink_20",
	buyPrice = 0,
	sellPrice = 100,
	reqLevel = 0,
}
t[38351] = {
	name = L["Murliver Oil"],
	quality = 1,
	icon = "inv_potion_20",
	buyPrice = 0,
	sellPrice = 100,
	reqLevel = 0,
}
t[37252] = {
	name = L["Frostberries"],
	quality = 1,
	icon = "spell_nature_starfall",
	buyPrice = 8500,
	sellPrice = 425,
	reqLevel = 65,
}
t[37253] = {
	name = L["Frostberry Juice"],
	quality = 1,
	icon = "inv_drink_waterskin_09",
	buyPrice = 6000,
	sellPrice = 300,
	reqLevel = 65,
}
t[42084] = {
	name = L["Snowhide Belt"],
	quality = 1,
	icon = "inv_belt_16",
	buyPrice = 35440,
	sellPrice = 7088,
	reqLevel = 65,
}
t[42088] = {
	name = L["Snowhide Hoof-Warmers"],
	quality = 1,
	icon = "inv_boots_08",
	buyPrice = 53942,
	sellPrice = 10788,
	reqLevel = 65,
}
t[42092] = {
	name = L["Snowhide Bracers"],
	quality = 1,
	icon = "inv_bracer_08",
	buyPrice = 36482,
	sellPrice = 7296,
	reqLevel = 65,
}
t[42094] = {
	name = L["Snowhide Cap"],
	quality = 1,
	icon = "inv_helmet_15",
	buyPrice = 55116,
	sellPrice = 11023,
	reqLevel = 65,
}
t[42097] = {
	name = L["Snowhide Mitts"],
	quality = 1,
	icon = "inv_gauntlets_02",
	buyPrice = 34526,
	sellPrice = 6905,
	reqLevel = 65,
}
t[42098] = {
	name = L["Snowhide Pants"],
	quality = 1,
	icon = "inv_pants_12",
	buyPrice = 69315,
	sellPrice = 13863,
	reqLevel = 65,
}
t[42099] = {
	name = L["Snowhide Vest"],
	quality = 1,
	icon = "inv_chest_fur",
	buyPrice = 69577,
	sellPrice = 13915,
	reqLevel = 65,
}
t[41584] = {
	name = L["Frostbite Bullets"],
	quality = 1,
	icon = "inv_misc_ammo_bullet_06",
	buyPrice = 3000,
	sellPrice = 3,
	reqLevel = 75,
}
t[41586] = {
	name = L["Terrorshaft Arrow"],
	quality = 1,
	icon = "inv_misc_ammo_arrow_01",
	buyPrice = 3000,
	sellPrice = 3,
	reqLevel = 75,
}
t[40018] = {
	name = L["Wand of Onyx"],
	quality = 1,
	icon = "inv_wand_10",
	buyPrice = 113201,
	sellPrice = 22640,
	reqLevel = 70,
}
t[40019] = {
	name = L["Wand of Amber"],
	quality = 1,
	icon = "inv_wand_11",
	buyPrice = 113618,
	sellPrice = 22723,
	reqLevel = 70,
}
t[40020] = {
	name = L["Wand of Jade"],
	quality = 1,
	icon = "inv_wand_04",
	buyPrice = 114036,
	sellPrice = 22807,
	reqLevel = 70,
}
t[40021] = {
	name = L["Wand of Crystal"],
	quality = 1,
	icon = "inv_wand_07",
	buyPrice = 114442,
	sellPrice = 22888,
	reqLevel = 70,
}
t[39987] = {
	name = L["Tuskarr Fishing Spear"],
	quality = 1,
	icon = "inv_spear_06",
	buyPrice = 194930,
	sellPrice = 38986,
	reqLevel = 70,
}
t[39995] = {
	name = L["Tuskarr Javelin"],
	quality = 1,
	icon = "inv_spear_05",
	buyPrice = 111565,
	sellPrice = 22313,
	reqLevel = 70,
}
t[38453] = {
	name = L["Shield of the Lion-hearted"],
	quality = 3,
	icon = "inv_shield_36",
	buyPrice = 391933,
	sellPrice = 78386,
	reqLevel = 78,
}
t[38455] = {
	name = L["Hammer of the Alliance Vanguard"],
	quality = 3,
	icon = "inv_mace_60",
	buyPrice = 616901,
	sellPrice = 123380,
	reqLevel = 78,
}
t[38457] = {
	name = L["Sawed-off Hand Cannon"],
	quality = 3,
	icon = "inv_weapon_rifle_19",
	buyPrice = 466101,
	sellPrice = 93220,
	reqLevel = 78,
}
t[38459] = {
	name = L["Orb of the Eastern Kingdoms"],
	quality = 3,
	icon = "inv_misc_orb_01",
	buyPrice = 179386,
	sellPrice = 44846,
	reqLevel = 78,
}
t[38463] = {
	name = L["Lordaeron's Resolve"],
	quality = 3,
	icon = "inv_shield_49",
	buyPrice = 377358,
	sellPrice = 75471,
	reqLevel = 78,
}
t[38464] = {
	name = L["Gnomish Magician's Quill"],
	quality = 3,
	icon = "inv_wand_15",
	buyPrice = 443930,
	sellPrice = 88786,
	reqLevel = 78,
}
t[38465] = {
	name = L["Vanguard Soldier's Dagger"],
	quality = 3,
	icon = "inv_weapon_shortblade_69",
	buyPrice = 594190,
	sellPrice = 118838,
	reqLevel = 78,
}
t[44503] = {
	name = L["Schematic: Mekgineer's Chopper"],
	quality = 4,
	icon = "inv_scroll_04",
	buyPrice = 4000000,
	sellPrice = 1000000,
	reqLevel = 0,
	profession = L["Engineering"],
	teaches = L["Mekgineer's Chopper"],
	learnedAt = 450,
}
t[44937] = {
	name = L["Plans: Titanium Plating"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 150000,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Blacksmithing"],
	teaches = L["Titanium Plating"],
	learnedAt = 450,
}
t[50372] = {
	name = L["Arcanum of the Savage Gladiator"],
	quality = 7,
	icon = "ability_warrior_shieldmastery",
	buyPrice = 1500000,
	sellPrice = 375000,
	reqLevel = 80,
}
t[38452] = {
	name = L["Bulwark of the Warchief"],
	quality = 3,
	icon = "inv_shield_51",
	buyPrice = 390472,
	sellPrice = 78094,
	reqLevel = 78,
}
t[38454] = {
	name = L["Warsong Punisher"],
	quality = 3,
	icon = "inv_mace_61",
	buyPrice = 614679,
	sellPrice = 122935,
	reqLevel = 78,
}
t[38456] = {
	name = L["Sin'dorei Recurve Bow"],
	quality = 3,
	icon = "inv_weapon_bow_35",
	buyPrice = 464388,
	sellPrice = 92877,
	reqLevel = 78,
}
t[38458] = {
	name = L["Darkspear Orb"],
	quality = 3,
	icon = "inv_misc_orb_05",
	buyPrice = 179386,
	sellPrice = 44846,
	reqLevel = 78,
}
t[38460] = {
	name = L["Charged Wand of the Cleft"],
	quality = 3,
	icon = "inv_wand_11",
	buyPrice = 471192,
	sellPrice = 94238,
	reqLevel = 78,
}
t[38461] = {
	name = L["Warsong Shanker"],
	quality = 3,
	icon = "inv_weapon_shortblade_69",
	buyPrice = 630540,
	sellPrice = 126108,
	reqLevel = 78,
}
t[38462] = {
	name = L["Warsong Stormshield"],
	quality = 3,
	icon = "inv_shield_50",
	buyPrice = 375897,
	sellPrice = 75179,
	reqLevel = 78,
}
t[44502] = {
	name = L["Schematic: Mechano-hog"],
	quality = 4,
	icon = "inv_scroll_04",
	buyPrice = 4000000,
	sellPrice = 1000000,
	reqLevel = 0,
	profession = L["Engineering"],
	teaches = L["Mechano-hog"],
	learnedAt = 450,
}
t[44938] = {
	name = L["Plans: Titanium Plating"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 150000,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Blacksmithing"],
	teaches = L["Titanium Plating"],
	learnedAt = 450,
}
t[50373] = {
	name = L["Arcanum of the Savage Gladiator"],
	quality = 7,
	icon = "ability_warrior_shieldmastery",
	buyPrice = 1500000,
	sellPrice = 375000,
	reqLevel = 80,
}
t[3419] = {
	name = L["Red Rose"],
	quality = 1,
	icon = "inv_jewelry_talisman_03",
	buyPrice = 500,
	sellPrice = 125,
	reqLevel = 0,
}
t[3420] = {
	name = L["Black Rose"],
	quality = 1,
	icon = "inv_jewelry_talisman_03",
	buyPrice = 5000,
	sellPrice = 1250,
	reqLevel = 0,
}
t[3421] = {
	name = L["Simple Wildflowers"],
	quality = 1,
	icon = "inv_misc_flower_02",
	buyPrice = 200,
	sellPrice = 50,
	reqLevel = 0,
}
t[3422] = {
	name = L["Beautiful Wildflowers"],
	quality = 1,
	icon = "inv_misc_flower_02",
	buyPrice = 2000,
	sellPrice = 500,
	reqLevel = 0,
}
t[3423] = {
	name = L["Bouquet of White Roses"],
	quality = 1,
	icon = "inv_misc_flower_02",
	buyPrice = 20000,
	sellPrice = 5000,
	reqLevel = 0,
}
t[3424] = {
	name = L["Bouquet of Black Roses"],
	quality = 1,
	icon = "inv_jewelry_talisman_03",
	buyPrice = 500000,
	sellPrice = 125000,
	reqLevel = 0,
}
t[40035] = {
	name = L["Honey Mead"],
	quality = 1,
	icon = "inv_drink_04",
	buyPrice = 50,
	sellPrice = 12,
	reqLevel = 1,
}
t[40036] = {
	name = L["Snowplum Brandy"],
	quality = 1,
	icon = "inv_drink_02",
	buyPrice = 150,
	sellPrice = 37,
	reqLevel = 0,
}
t[40042] = {
	name = L["Caraway Burnwine"],
	quality = 1,
	icon = "inv_drink_01",
	buyPrice = 1500,
	sellPrice = 375,
	reqLevel = 0,
}
t[11307] = {
	name = L["Massive Longbow"],
	quality = 2,
	icon = "inv_weapon_bow_01",
	buyPrice = 67952,
	sellPrice = 13590,
	reqLevel = 42,
}
t[12037] = {
	name = L["Mystery Meat"],
	quality = 1,
	icon = "inv_misc_food_67",
	buyPrice = 350,
	sellPrice = 87,
	reqLevel = 0,
}
t[33612] = {
	name = L["Fresh Pound of Flesh"],
	quality = 1,
	icon = "inv_misc_food_14",
	buyPrice = 8500,
	sellPrice = 2125,
	reqLevel = 0,
}
t[40004] = {
	name = L["Forsaken Greatsword"],
	quality = 1,
	icon = "inv_sword_06",
	buyPrice = 179342,
	sellPrice = 35868,
	reqLevel = 70,
}
t[40005] = {
	name = L["Forsaken Blade"],
	quality = 1,
	icon = "inv_weapon_shortblade_05",
	buyPrice = 143474,
	sellPrice = 28694,
	reqLevel = 70,
}
t[40006] = {
	name = L["Forsaken Sword"],
	quality = 1,
	icon = "inv_sword_04",
	buyPrice = 143474,
	sellPrice = 28694,
	reqLevel = 70,
}
t[40007] = {
	name = L["Forsaken Throwing Knife"],
	quality = 1,
	icon = "inv_weapon_shortblade_05",
	buyPrice = 111565,
	sellPrice = 22313,
	reqLevel = 70,
}
t[6097] = {
	name = L["Acolyte's Shirt"],
	quality = 1,
	icon = "inv_shirt_01",
	buyPrice = 1,
	sellPrice = 1,
	reqLevel = 0,
}
t[20978] = {
	name = L["Apprentice's Staff"],
	quality = 1,
	icon = "inv_staff_08",
	buyPrice = 46,
	sellPrice = 9,
	reqLevel = 1,
}
t[20983] = {
	name = L["Acolyte's Dagger"],
	quality = 1,
	icon = "inv_weapon_shortblade_18",
	buyPrice = 37,
	sellPrice = 7,
	reqLevel = 1,
}
t[35813] = {
	name = L["Shiny Knife"],
	quality = 1,
	icon = "inv_weapon_shortblade_07",
	buyPrice = 8000,
	sellPrice = 2000,
	reqLevel = 0,
}
t[41568] = {
	name = L["Design: Seer's Dark Jade"],
	quality = 2,
	icon = "inv_scroll_06",
	buyPrice = 20000,
	sellPrice = 5000,
	reqLevel = 0,
}
t[41574] = {
	name = L["Design: Defender's Shadow Crystal"],
	quality = 2,
	icon = "inv_scroll_06",
	buyPrice = 20000,
	sellPrice = 5000,
	reqLevel = 0,
}
t[44049] = {
	name = L["Freshly-Speared Emperor Salmon"],
	quality = 1,
	icon = "inv_misc_fish_52",
	buyPrice = 16000,
	sellPrice = 800,
	reqLevel = 75,
}
t[44050] = {
	name = L["Mastercraft Kalu'ak Fishing Pole"],
	quality = 4,
	icon = "inv_fishingpole_03",
	buyPrice = 1280448,
	sellPrice = 256089,
	reqLevel = 0,
}
t[44051] = {
	name = L["Traditional Flensing Knife"],
	quality = 3,
	icon = "inv_weapon_shortblade_87",
	buyPrice = 723612,
	sellPrice = 144722,
	reqLevel = 78,
}
t[44052] = {
	name = L["Totemic Purification Rod"],
	quality = 3,
	icon = "inv_mace_76",
	buyPrice = 657082,
	sellPrice = 131416,
	reqLevel = 78,
}
t[44053] = {
	name = L["Whale-Stick Harpoon"],
	quality = 3,
	icon = "inv_weapon_halberd_ahnqiraj",
	buyPrice = 824545,
	sellPrice = 164909,
	reqLevel = 78,
}
t[44054] = {
	name = L["Whale-Skin Breastplate"],
	quality = 3,
	icon = "inv_chest_leather_05",
	buyPrice = 296045,
	sellPrice = 59209,
	reqLevel = 76,
}
t[44055] = {
	name = L["Whale-Skin Vest"],
	quality = 3,
	icon = "inv_chest_leather_08",
	buyPrice = 297187,
	sellPrice = 59437,
	reqLevel = 76,
}
t[44057] = {
	name = L["Ivory-Reinforced Chestguard"],
	quality = 3,
	icon = "inv_chest_plate07",
	buyPrice = 430664,
	sellPrice = 86132,
	reqLevel = 76,
}
t[44058] = {
	name = L["Whalebone Carapace"],
	quality = 3,
	icon = "inv_chest_plate05",
	buyPrice = 432262,
	sellPrice = 86452,
	reqLevel = 76,
}
t[44059] = {
	name = L["Cuttlefish Scale Breastplate"],
	quality = 3,
	icon = "inv_chest_chain_07",
	buyPrice = 371881,
	sellPrice = 74376,
	reqLevel = 76,
}
t[44060] = {
	name = L["Cuttlefish Tooth Ringmail"],
	quality = 3,
	icon = "inv_chest_chain_05",
	buyPrice = 373251,
	sellPrice = 74650,
	reqLevel = 76,
}
t[44061] = {
	name = L["Pigment-Stained Robes"],
	quality = 3,
	icon = "inv_chest_cloth_19",
	buyPrice = 249722,
	sellPrice = 49944,
	reqLevel = 76,
}
t[44062] = {
	name = L["Turtle-Minders Robe"],
	quality = 3,
	icon = "inv_chest_cloth_18",
	buyPrice = 250636,
	sellPrice = 50127,
	reqLevel = 76,
}
t[44509] = {
	name = L["Pattern: Trapper's Traveling Pack"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 50000,
	sellPrice = 12500,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Trapper's Traveling Pack"],
	learnedAt = 415,
}
t[44511] = {
	name = L["Pattern: Dragonscale Ammo Pouch"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 50000,
	sellPrice = 12500,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Dragonscale Ammo Pouch"],
	learnedAt = 415,
}
t[44723] = {
	name = L["Nurtured Penguin Egg"],
	quality = 3,
	icon = "inv_pet_nurturedpenguinegg",
	buyPrice = 120000,
	sellPrice = 30000,
	reqLevel = 0,
}
t[45774] = {
	name = L["Pattern: Emerald Bag"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 50000,
	sellPrice = 12500,
	reqLevel = 0,
	profession = L["Tailoring"],
	teaches = L["Emerald Bag"],
	learnedAt = 435,
}
t[44570] = {
	name = L["Glass of Eversong Wine"],
	quality = 1,
	icon = "inv_drink_02",
	buyPrice = 50,
	sellPrice = 12,
	reqLevel = 1,
}
t[44571] = {
	name = L["Bottle of Silvermoon Port"],
	quality = 1,
	icon = "inv_drink_12",
	buyPrice = 150,
	sellPrice = 37,
	reqLevel = 0,
}
t[44573] = {
	name = L["Cup of Frog Venom Brew"],
	quality = 1,
	icon = "inv_drink_14",
	buyPrice = 1500,
	sellPrice = 375,
	reqLevel = 0,
}
t[44574] = {
	name = L["Skin of Mulgore Firewater"],
	quality = 1,
	icon = "inv_drink_waterskin_12",
	buyPrice = 2000,
	sellPrice = 500,
	reqLevel = 0,
}
t[44575] = {
	name = L["Flask of Bitter Cactus Cider"],
	quality = 1,
	icon = "inv_drink_01",
	buyPrice = 120,
	sellPrice = 30,
	reqLevel = 0,
}
t[43156] = {
	name = L["Tabard of the Wyrmrest Accord"],
	quality = 1,
	icon = "inv_shirt_guildtabard_01",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 0,
}
t[41722] = {
	name = L["Design: Glimmering Monarch Topaz"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 40000,
	sellPrice = 10000,
	reqLevel = 0,
}
t[42185] = {
	name = L["Pattern: Mysterious Bag"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 50000,
	sellPrice = 12500,
	reqLevel = 0,
	profession = L["Tailoring"],
	teaches = L["Mysterious Bag"],
	learnedAt = 440,
}
t[43955] = {
	name = L["Reins of the Red Drake"],
	quality = 4,
	icon = "ability_mount_drake_red",
	buyPrice = 20000000,
	sellPrice = 0,
	reqLevel = 70,
}
t[44140] = {
	name = L["Arcanum of the Eclipsed Moon"],
	quality = 3,
	icon = "ability_druid_eclipse",
	buyPrice = 1500000,
	sellPrice = 375000,
	reqLevel = 80,
}
t[44152] = {
	name = L["Arcanum of Blissful Mending"],
	quality = 7,
	icon = "ability_warrior_shieldmastery",
	buyPrice = 1500000,
	sellPrice = 375000,
	reqLevel = 80,
}
t[44187] = {
	name = L["Fang of Truth"],
	quality = 3,
	icon = "inv_sword_99",
	buyPrice = 680340,
	sellPrice = 136068,
	reqLevel = 78,
}
t[44188] = {
	name = L["Cloak of Peaceful Resolutions"],
	quality = 3,
	icon = "inv_misc_cape_naxxramas_02",
	buyPrice = 204868,
	sellPrice = 40973,
	reqLevel = 78,
}
t[44196] = {
	name = L["Sash of the Wizened Wyrm"],
	quality = 3,
	icon = "inv_belt_22",
	buyPrice = 140636,
	sellPrice = 28127,
	reqLevel = 78,
}
t[44197] = {
	name = L["Bracers of Accorded Courtesy"],
	quality = 3,
	icon = "inv_bracer_17",
	buyPrice = 248395,
	sellPrice = 49679,
	reqLevel = 78,
}
t[44198] = {
	name = L["Breastplate of the Solemn Council"],
	quality = 3,
	icon = "inv_chest_plate12",
	buyPrice = 528214,
	sellPrice = 105642,
	reqLevel = 80,
}
t[44199] = {
	name = L["Gavel of the Brewing Storm"],
	quality = 3,
	icon = "inv_mace_60",
	buyPrice = 757312,
	sellPrice = 151462,
	reqLevel = 80,
}
t[44200] = {
	name = L["Ancestral Sinew Wristguards"],
	quality = 3,
	icon = "inv_bracer_05",
	buyPrice = 141182,
	sellPrice = 28236,
	reqLevel = 80,
}
t[44201] = {
	name = L["Sabatons of Draconic Vigor"],
	quality = 3,
	icon = "inv_boots_plate_09",
	buyPrice = 371285,
	sellPrice = 74257,
	reqLevel = 80,
}
t[44202] = {
	name = L["Sandals of Crimson Fury"],
	quality = 4,
	icon = "inv_boots_cloth_16",
	buyPrice = 284512,
	sellPrice = 56902,
	reqLevel = 80,
}
t[44203] = {
	name = L["Dragonfriend Bracers"],
	quality = 4,
	icon = "inv_bracer_15",
	buyPrice = 238000,
	sellPrice = 47600,
	reqLevel = 80,
}
t[44204] = {
	name = L["Grips of Fierce Pronouncements"],
	quality = 4,
	icon = "inv_gauntlets_73",
	buyPrice = 286659,
	sellPrice = 57331,
	reqLevel = 80,
}
t[44205] = {
	name = L["Legplates of Bloody Reprisal"],
	quality = 4,
	icon = "inv_pants_plate_02",
	buyPrice = 671411,
	sellPrice = 134282,
	reqLevel = 80,
}
t[50370] = {
	name = L["Arcanum of Blissful Mending"],
	quality = 7,
	icon = "ability_warrior_shieldmastery",
	buyPrice = 1500000,
	sellPrice = 375000,
	reqLevel = 80,
}
t[43154] = {
	name = L["Tabard of the Argent Crusade"],
	quality = 1,
	icon = "inv_shirt_guildtabard_01",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 0,
}
t[41726] = {
	name = L["Design: Guardian's Twilight Opal"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 40000,
	sellPrice = 10000,
	reqLevel = 0,
}
t[42187] = {
	name = L["Pattern: Brilliant Spellthread"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 50000,
	sellPrice = 12500,
	reqLevel = 0,
	profession = L["Tailoring"],
	teaches = L["Brilliant Spellthread"],
	learnedAt = 430,
}
t[44139] = {
	name = L["Arcanum of the Fleeing Shadow"],
	quality = 3,
	icon = "ability_paladin_gaurdedbythelight",
	buyPrice = 1500000,
	sellPrice = 375000,
	reqLevel = 80,
}
t[44150] = {
	name = L["Arcanum of the Stalwart Protector"],
	quality = 7,
	icon = "ability_warrior_swordandboard",
	buyPrice = 1500000,
	sellPrice = 375000,
	reqLevel = 80,
}
t[44214] = {
	name = L["Purifying Torch"],
	quality = 3,
	icon = "inv_wand_11",
	buyPrice = 523506,
	sellPrice = 104701,
	reqLevel = 78,
}
t[44216] = {
	name = L["Cloak of Holy Extermination"],
	quality = 3,
	icon = "inv_misc_cape_12",
	buyPrice = 210913,
	sellPrice = 42182,
	reqLevel = 78,
}
t[44239] = {
	name = L["Standard Issue Legguards"],
	quality = 3,
	icon = "inv_pants_plate_10",
	buyPrice = 461842,
	sellPrice = 92368,
	reqLevel = 78,
}
t[44240] = {
	name = L["Special Issue Legplates"],
	quality = 3,
	icon = "inv_pants_plate_23",
	buyPrice = 463629,
	sellPrice = 92725,
	reqLevel = 78,
}
t[44244] = {
	name = L["Argent Skeleton Crusher"],
	quality = 3,
	icon = "inv_staff_71",
	buyPrice = 895627,
	sellPrice = 179125,
	reqLevel = 80,
}
t[44245] = {
	name = L["Zombie Sweeper Shotgun"],
	quality = 3,
	icon = "inv_weapon_rifle_01",
	buyPrice = 539417,
	sellPrice = 107883,
	reqLevel = 80,
}
t[44247] = {
	name = L["Fang-Deflecting Faceguard"],
	quality = 3,
	icon = "inv_helmet_134",
	buyPrice = 379685,
	sellPrice = 75937,
	reqLevel = 80,
}
t[44248] = {
	name = L["Battle Mender's Helm"],
	quality = 3,
	icon = "inv_helmet_13",
	buyPrice = 327290,
	sellPrice = 65458,
	reqLevel = 80,
}
t[44283] = {
	name = L["Signet of Hopeful Light"],
	quality = 4,
	icon = "inv_jewelry_ring_70",
	buyPrice = 284983,
	sellPrice = 71245,
	reqLevel = 80,
}
t[44295] = {
	name = L["Polished Regimental Hauberk"],
	quality = 4,
	icon = "inv_chest_chain_16",
	buyPrice = 612379,
	sellPrice = 122475,
	reqLevel = 80,
}
t[44296] = {
	name = L["Helm of Purified Thoughts"],
	quality = 4,
	icon = "inv_helmet_20",
	buyPrice = 536712,
	sellPrice = 107342,
	reqLevel = 80,
}
t[44297] = {
	name = L["Boots of the Neverending Path"],
	quality = 4,
	icon = "inv_boots_08",
	buyPrice = 358398,
	sellPrice = 71679,
	reqLevel = 80,
}
t[50369] = {
	name = L["Arcanum of the Stalwart Protector"],
	quality = 7,
	icon = "ability_warrior_swordandboard",
	buyPrice = 1500000,
	sellPrice = 375000,
	reqLevel = 80,
}
t[42777] = {
	name = L["Crusader's Waterskin"],
	quality = 1,
	icon = "inv_drink_waterskin_06",
	buyPrice = 11000,
	sellPrice = 550,
	reqLevel = 75,
}
t[42778] = {
	name = L["Crusader's Rations"],
	quality = 1,
	icon = "inv_misc_food_08",
	buyPrice = 16000,
	sellPrice = 800,
	reqLevel = 75,
}
t[42779] = {
	name = L["Steaming Chicken Soup"],
	quality = 1,
	icon = "inv_misc_food_115_condorsoup",
	buyPrice = 16000,
	sellPrice = 800,
	reqLevel = 75,
}
t[41562] = {
	name = L["Design: Deadly Huge Citrine"],
	quality = 2,
	icon = "inv_scroll_06",
	buyPrice = 20000,
	sellPrice = 5000,
	reqLevel = 0,
}
t[41721] = {
	name = L["Design: Wicked Monarch Topaz"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 40000,
	sellPrice = 10000,
	reqLevel = 0,
}
t[41725] = {
	name = L["Design: Glowing Twilight Opal"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 40000,
	sellPrice = 10000,
	reqLevel = 0,
}
t[42183] = {
	name = L["Pattern: Abyssal Bag"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 50000,
	sellPrice = 12500,
	reqLevel = 0,
	profession = L["Tailoring"],
	teaches = L["Abyssal Bag"],
	learnedAt = 435,
}
t[43155] = {
	name = L["Tabard of the Ebon Blade"],
	quality = 1,
	icon = "inv_shirt_guildtabard_01",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 0,
}
t[44138] = {
	name = L["Arcanum of Toxic Warding"],
	quality = 3,
	icon = "trade_brewpoison",
	buyPrice = 1500000,
	sellPrice = 375000,
	reqLevel = 80,
}
t[44149] = {
	name = L["Arcanum of Torment"],
	quality = 7,
	icon = "ability_warrior_rampage",
	buyPrice = 1500000,
	sellPrice = 375000,
	reqLevel = 80,
}
t[44241] = {
	name = L["Unholy Persuader"],
	quality = 3,
	icon = "inv_weapon_hand_01",
	buyPrice = 664881,
	sellPrice = 132976,
	reqLevel = 78,
}
t[44242] = {
	name = L["Dark Soldier Cape"],
	quality = 3,
	icon = "inv_misc_cape_21",
	buyPrice = 200209,
	sellPrice = 40041,
	reqLevel = 78,
}
t[44243] = {
	name = L["Toxin-Tempered Sabatons"],
	quality = 3,
	icon = "inv_boots_plate_07",
	buyPrice = 351037,
	sellPrice = 70207,
	reqLevel = 78,
}
t[44249] = {
	name = L["Runeblade of Demonstrable Power"],
	quality = 3,
	icon = "inv_sword_95",
	buyPrice = 936897,
	sellPrice = 187379,
	reqLevel = 80,
}
t[44250] = {
	name = L["Reaper of Dark Souls"],
	quality = 3,
	icon = "inv_sword_97",
	buyPrice = 752165,
	sellPrice = 150433,
	reqLevel = 80,
}
t[44256] = {
	name = L["Sterile Flesh-Handling Gloves"],
	quality = 3,
	icon = "inv_gauntlets_17",
	buyPrice = 153683,
	sellPrice = 30736,
	reqLevel = 80,
}
t[44257] = {
	name = L["Spaulders of the Black Arrow"],
	quality = 3,
	icon = "inv_shoulder_102",
	buyPrice = 348520,
	sellPrice = 69704,
	reqLevel = 80,
}
t[44258] = {
	name = L["Wound-Binder's Wristguards"],
	quality = 3,
	icon = "inv_bracer_18",
	buyPrice = 175044,
	sellPrice = 35008,
	reqLevel = 80,
}
t[44302] = {
	name = L["Belt of Dark Mending"],
	quality = 4,
	icon = "inv_belt_13",
	buyPrice = 187027,
	sellPrice = 37405,
	reqLevel = 80,
}
t[44303] = {
	name = L["Darkheart Chestguard"],
	quality = 4,
	icon = "inv_chest_leather_16",
	buyPrice = 488648,
	sellPrice = 97729,
	reqLevel = 80,
}
t[44305] = {
	name = L["Kilt of Dark Mercy"],
	quality = 4,
	icon = "inv_pants_mail_11",
	buyPrice = 590731,
	sellPrice = 118146,
	reqLevel = 80,
}
t[44306] = {
	name = L["Death-Inured Sabatons"],
	quality = 4,
	icon = "inv_boots_plate_06",
	buyPrice = 517755,
	sellPrice = 103551,
	reqLevel = 80,
}
t[44512] = {
	name = L["Pattern: Nerubian Reinforced Quiver"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 50000,
	sellPrice = 12500,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Nerubian Reinforced Quiver"],
	learnedAt = 415,
}
t[50367] = {
	name = L["Arcanum of Torment"],
	quality = 7,
	icon = "ability_warrior_rampage",
	buyPrice = 1500000,
	sellPrice = 375000,
	reqLevel = 80,
}
t[35794] = {
	name = L["Silvercoat Stag Meat"],
	quality = 1,
	icon = "inv_misc_food_70",
	buyPrice = 8000,
	sellPrice = 400,
	reqLevel = 65,
}
t[35796] = {
	name = L["Howlin' Good Moonshine"],
	quality = 1,
	icon = "inv_cask_02",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 0,
}
t[38353] = {
	name = L["Venture Bay Buccaneer's Cape"],
	quality = 3,
	icon = "inv_misc_cape_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 74,
}
t[38354] = {
	name = L["Oil-Stained Tarp"],
	quality = 3,
	icon = "inv_misc_cape_20",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 74,
}
t[38355] = {
	name = L["Thick Goblin Back Protector"],
	quality = 3,
	icon = "inv_misc_cape_10",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 74,
}
t[38356] = {
	name = L["Venture Battle Wand"],
	quality = 3,
	icon = "inv_wand_18",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 74,
}
t[38357] = {
	name = L["Sharpened Throwing Gizmo"],
	quality = 3,
	icon = "inv_misc_coin_10",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 74,
}
t[38358] = {
	name = L["Arcane Revitalizer"],
	quality = 3,
	icon = "inv_misc_armorkit_22",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 74,
}
t[38359] = {
	name = L["Goblin Repetition Reducer"],
	quality = 3,
	icon = "inv_misc_armorkit_22",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 74,
}
t[38360] = {
	name = L["Idol of Arcane Terror"],
	quality = 3,
	icon = "inv_misc_root_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 74,
}
t[38361] = {
	name = L["Venture Co. Lightning Rod"],
	quality = 3,
	icon = "spell_fire_felfire",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 74,
}
t[38362] = {
	name = L["Venture Co. Libram of Retribution"],
	quality = 3,
	icon = "inv_misc_stonetablet_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 74,
}
t[38363] = {
	name = L["Venture Co. Libram of Protection"],
	quality = 3,
	icon = "inv_misc_book_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 74,
}
t[38364] = {
	name = L["Venture Co. Libram of Mostly Holy Deeds"],
	quality = 3,
	icon = "inv_misc_stonetablet_04",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 74,
}
t[38365] = {
	name = L["Idol of Perspicacious Attacks"],
	quality = 3,
	icon = "classic_ability_druid_demoralizingroar",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 74,
}
t[38366] = {
	name = L["Idol of Pure Thoughts"],
	quality = 3,
	icon = "ability_druid_treeoflife",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 74,
}
t[38367] = {
	name = L["Venture Co. Flame Slicer"],
	quality = 3,
	icon = "spell_fire_burnout",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 74,
}
t[38368] = {
	name = L["Totem of the Bay"],
	quality = 3,
	icon = "spell_shaman_earthlivingweapon",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 74,
}
t[40822] = {
	name = L["Sigil of the Frozen Conscience"],
	quality = 3,
	icon = "inv_shield_56",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 74,
}
t[40867] = {
	name = L["Sigil of the Wild Buck"],
	quality = 3,
	icon = "inv_shield_56",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 74,
}
t[40875] = {
	name = L["Sigil of Arthritic Binding"],
	quality = 3,
	icon = "inv_shield_56",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 74,
}
t[38698] = {
	name = L["Bitter Plasma"],
	quality = 1,
	icon = "inv_drink_21",
	buyPrice = 8500,
	sellPrice = 425,
	reqLevel = 70,
}
t[38706] = {
	name = L["Bowels 'n' Brains"],
	quality = 1,
	icon = "inv_misc_food_64",
	buyPrice = 16000,
	sellPrice = 800,
	reqLevel = 75,
}
t[43462] = {
	name = L["Airy Pale Ale"],
	quality = 1,
	icon = "inv_drink_08",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[43470] = {
	name = L["Worg Tooth Oatmeal Stout"],
	quality = 1,
	icon = "inv_drink_13",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[43472] = {
	name = L["Snowfall Lager"],
	quality = 1,
	icon = "inv_drink_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[43473] = {
	name = L["Drakefire Chile Ale"],
	quality = 1,
	icon = "inv_drink_03",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[43499] = {
	name = L["Iron Boot Flask"],
	quality = 1,
	icon = "inv_drink_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[41746] = {
	name = L["Brunnhildar Bow"],
	quality = 1,
	icon = "inv_weapon_bow_01",
	buyPrice = 126343,
	sellPrice = 25268,
	reqLevel = 75,
}
t[41752] = {
	name = L["Brunnhildar Axe"],
	quality = 1,
	icon = "inv_axe_03",
	buyPrice = 172165,
	sellPrice = 34433,
	reqLevel = 75,
}
t[41754] = {
	name = L["Brunnhildar Shield"],
	quality = 1,
	icon = "inv_shield_19",
	buyPrice = 110970,
	sellPrice = 22194,
	reqLevel = 75,
}
t[43600] = {
	name = L["Brunnhildar Harpoon"],
	quality = 1,
	icon = "inv_spear_04",
	buyPrice = 200063,
	sellPrice = 40012,
	reqLevel = 75,
}
t[43601] = {
	name = L["Brunnhildar Great Axe"],
	quality = 1,
	icon = "inv_axe_01",
	buyPrice = 200063,
	sellPrice = 40012,
	reqLevel = 75,
}
t[41720] = {
	name = L["Design: Smooth Autumn's Glow"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 40000,
	sellPrice = 10000,
	reqLevel = 0,
}
t[42184] = {
	name = L["Pattern: Glacial Bag"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 50000,
	sellPrice = 12500,
	reqLevel = 0,
	profession = L["Tailoring"],
	teaches = L["Glacial Bag"],
	learnedAt = 445,
}
t[43958] = {
	name = L["Reins of the Ice Mammoth"],
	quality = 4,
	icon = "ability_mount_mammoth_white",
	buyPrice = 10000000,
	sellPrice = 2500000,
	reqLevel = 40,
}
t[43961] = {
	name = L["Reins of the Grand Ice Mammoth"],
	quality = 4,
	icon = "ability_mount_mammoth_white",
	buyPrice = 100000000,
	sellPrice = 25000000,
	reqLevel = 40,
}
t[44080] = {
	name = L["Reins of the Ice Mammoth"],
	quality = 4,
	icon = "ability_mount_mammoth_white",
	buyPrice = 10000000,
	sellPrice = 2500000,
	reqLevel = 40,
}
t[44086] = {
	name = L["Reins of the Grand Ice Mammoth"],
	quality = 4,
	icon = "ability_mount_mammoth_white",
	buyPrice = 100000000,
	sellPrice = 25000000,
	reqLevel = 40,
}
t[44129] = {
	name = L["Lesser Inscription of the Storm"],
	quality = 3,
	icon = "spell_nature_lightning",
	buyPrice = 750000,
	sellPrice = 187500,
	reqLevel = 80,
}
t[44130] = {
	name = L["Lesser Inscription of the Crag"],
	quality = 3,
	icon = "spell_nature_farsight",
	buyPrice = 750000,
	sellPrice = 187500,
	reqLevel = 80,
}
t[44131] = {
	name = L["Lesser Inscription of the Axe"],
	quality = 3,
	icon = "inv_axe_82",
	buyPrice = 750000,
	sellPrice = 187500,
	reqLevel = 80,
}
t[44132] = {
	name = L["Lesser Inscription of the Pinnacle"],
	quality = 3,
	icon = "spell_holy_divinepurpose",
	buyPrice = 750000,
	sellPrice = 187500,
	reqLevel = 80,
}
t[44137] = {
	name = L["Arcanum of the Frosty Soul"],
	quality = 3,
	icon = "spell_frost_frozencore",
	buyPrice = 1500000,
	sellPrice = 375000,
	reqLevel = 80,
}
t[44189] = {
	name = L["Giant Ring Belt"],
	quality = 3,
	icon = "inv_belt_31",
	buyPrice = 205613,
	sellPrice = 41122,
	reqLevel = 78,
}
t[44190] = {
	name = L["Spaulders of Frozen Knives"],
	quality = 3,
	icon = "inv_shoulder_101",
	buyPrice = 257974,
	sellPrice = 51594,
	reqLevel = 78,
}
t[44192] = {
	name = L["Stalactite Chopper"],
	quality = 3,
	icon = "inv_axe_30",
	buyPrice = 738414,
	sellPrice = 147682,
	reqLevel = 80,
}
t[44193] = {
	name = L["Broken Stalactite"],
	quality = 3,
	icon = "inv_weapon_shortblade_71",
	buyPrice = 741061,
	sellPrice = 148212,
	reqLevel = 80,
}
t[44194] = {
	name = L["Giant-Friend Kilt"],
	quality = 3,
	icon = "inv_pants_leather_11",
	buyPrice = 371891,
	sellPrice = 74378,
	reqLevel = 80,
}
t[44195] = {
	name = L["Spaulders of the Giant Lords"],
	quality = 3,
	icon = "inv_shoulder_92",
	buyPrice = 391167,
	sellPrice = 78233,
	reqLevel = 80,
}
t[44510] = {
	name = L["Pattern: Mammoth Mining Bag"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 50000,
	sellPrice = 12500,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Mammoth Mining Bag"],
	learnedAt = 415,
}
t[50335] = {
	name = L["Greater Inscription of the Axe"],
	quality = 7,
	icon = "inv_axe_85",
	buyPrice = 1000000,
	sellPrice = 250000,
	reqLevel = 80,
}
t[50336] = {
	name = L["Greater Inscription of the Crag"],
	quality = 7,
	icon = "spell_arcane_teleportorgrimmar",
	buyPrice = 1000000,
	sellPrice = 250000,
	reqLevel = 80,
}
t[50337] = {
	name = L["Greater Inscription of the Pinnacle"],
	quality = 7,
	icon = "spell_holy_divinepurpose",
	buyPrice = 1000000,
	sellPrice = 250000,
	reqLevel = 80,
}
t[50338] = {
	name = L["Greater Inscription of the Storm"],
	quality = 7,
	icon = "spell_nature_lightningoverload",
	buyPrice = 1000000,
	sellPrice = 250000,
	reqLevel = 80,
}
t[39522] = {
	name = L["Wolvar Shortbow"],
	quality = 1,
	icon = "inv_weapon_bow_01",
	buyPrice = 101389,
	sellPrice = 20277,
	reqLevel = 65,
}
t[39878] = {
	name = L["Mysterious Egg"],
	quality = 1,
	icon = "inv_egg_02",
	buyPrice = 30000,
	sellPrice = 7500,
	reqLevel = 70,
}
t[41567] = {
	name = L["Design: Vivid Dark Jade"],
	quality = 2,
	icon = "inv_scroll_06",
	buyPrice = 20000,
	sellPrice = 5000,
	reqLevel = 0,
}
t[41724] = {
	name = L["Design: Sundered Forest Emerald"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 40000,
	sellPrice = 10000,
	reqLevel = 0,
}
t[44065] = {
	name = L["Oracle Secret Solution"],
	quality = 1,
	icon = "inv_potion_106",
	buyPrice = 3200,
	sellPrice = 800,
	reqLevel = 70,
}
t[44071] = {
	name = L["Slow-Roasted Eel"],
	quality = 1,
	icon = "inv_misc_fish_11",
	buyPrice = 16000,
	sellPrice = 800,
	reqLevel = 75,
}
t[44074] = {
	name = L["Oracle Talisman of Ablution"],
	quality = 4,
	icon = "inv_misc_rune_05",
	buyPrice = 429375,
	sellPrice = 107343,
	reqLevel = 70,
}
t[44104] = {
	name = L["Fishy Cinch"],
	quality = 3,
	icon = "inv_belt_03",
	buyPrice = 144777,
	sellPrice = 28955,
	reqLevel = 78,
}
t[44106] = {
	name = L["Glitterscale Wrap"],
	quality = 3,
	icon = "inv_belt_24",
	buyPrice = 164960,
	sellPrice = 32992,
	reqLevel = 78,
}
t[44108] = {
	name = L["Shinygem Rod"],
	quality = 3,
	icon = "inv_wand_12",
	buyPrice = 498712,
	sellPrice = 99742,
	reqLevel = 78,
}
t[44109] = {
	name = L["Toothslice Helm"],
	quality = 3,
	icon = "inv_helmet_138",
	buyPrice = 300376,
	sellPrice = 60075,
	reqLevel = 78,
}
t[44110] = {
	name = L["Sharkjaw Cap"],
	quality = 3,
	icon = "inv_helmet_138",
	buyPrice = 301494,
	sellPrice = 60298,
	reqLevel = 78,
}
t[44111] = {
	name = L["Gold Star Spaulders"],
	quality = 3,
	icon = "inv_shoulder_98",
	buyPrice = 352412,
	sellPrice = 70482,
	reqLevel = 78,
}
t[44112] = {
	name = L["Glimmershell Shoulder Protectors"],
	quality = 3,
	icon = "inv_shoulder_haremmatron_d_01",
	buyPrice = 353750,
	sellPrice = 70750,
	reqLevel = 78,
}
t[41561] = {
	name = L["Design: Reckless Huge Citrine"],
	quality = 2,
	icon = "inv_scroll_06",
	buyPrice = 20000,
	sellPrice = 5000,
	reqLevel = 0,
}
t[41723] = {
	name = L["Design: Jagged Forest Emerald"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 40000,
	sellPrice = 10000,
	reqLevel = 0,
}
t[44064] = {
	name = L["Nepeta Leaf"],
	quality = 1,
	icon = "inv_misc_herb_12",
	buyPrice = 3200,
	sellPrice = 800,
	reqLevel = 70,
}
t[44072] = {
	name = L["Roasted Mystery Beast"],
	quality = 1,
	icon = "inv_misc_food_116_condorleg",
	buyPrice = 16000,
	sellPrice = 800,
	reqLevel = 75,
}
t[44073] = {
	name = L["Frenzyheart Insignia of Fury"],
	quality = 4,
	icon = "inv_misc_rune_14",
	buyPrice = 429375,
	sellPrice = 107343,
	reqLevel = 70,
}
t[44116] = {
	name = L["Muddied Crimson Gloves"],
	quality = 3,
	icon = "inv_gauntlets_49",
	buyPrice = 137048,
	sellPrice = 27409,
	reqLevel = 78,
}
t[44117] = {
	name = L["Azure Strappy Pants"],
	quality = 3,
	icon = "inv_pants_leather_21",
	buyPrice = 321380,
	sellPrice = 64276,
	reqLevel = 78,
}
t[44118] = {
	name = L["Stolen Vrykul Harpoon"],
	quality = 3,
	icon = "inv_spear_03",
	buyPrice = 138516,
	sellPrice = 34629,
	reqLevel = 78,
}
t[44120] = {
	name = L["Giant-Sized Gauntlets"],
	quality = 3,
	icon = "inv_gauntlets_53",
	buyPrice = 251213,
	sellPrice = 50242,
	reqLevel = 78,
}
t[44121] = {
	name = L["Sparkly Shiny Gloves"],
	quality = 3,
	icon = "inv_gauntlets_29",
	buyPrice = 252087,
	sellPrice = 50417,
	reqLevel = 78,
}
t[44122] = {
	name = L["Scavenged Feathery Leggings"],
	quality = 3,
	icon = "inv_pants_mail_25",
	buyPrice = 431227,
	sellPrice = 86245,
	reqLevel = 78,
}
t[44123] = {
	name = L["Discarded Titanium Legplates"],
	quality = 3,
	icon = "inv_pants_plate_20",
	buyPrice = 504886,
	sellPrice = 100977,
	reqLevel = 78,
}
t[44717] = {
	name = L["Disgusting Jar"],
	quality = 1,
	icon = "inv_potion_139",
	buyPrice = 30000,
	sellPrice = 7500,
	reqLevel = 1,
}
t[16083] = {
	name = L["Expert Fishing - The Bass and You"],
	quality = 1,
	icon = "inv_misc_book_08",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 0,
}
t[8496] = {
	name = L["Parrot Cage (Cockatiel)"],
	quality = 1,
	icon = "spell_nature_forceofnature",
	buyPrice = 4000,
	sellPrice = 1000,
	reqLevel = 0,
}
t[10728] = {
	name = L["Pattern: Black Swashbuckler's Shirt"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 1500,
	sellPrice = 375,
	reqLevel = 0,
	profession = L["Tailoring"],
	teaches = L["Black Swashbuckler's Shirt"],
	learnedAt = 200,
}
t[6039] = {
	name = L["Recipe: Giant Clam Scorcho"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 5000,
	sellPrice = 1250,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Giant Clam Scorcho"],
	learnedAt = 175,
}
t[13940] = {
	name = L["Recipe: Cooked Glossy Mightfish"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 16000,
	sellPrice = 4000,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Cooked Glossy Mightfish"],
	learnedAt = 225,
}
t[13941] = {
	name = L["Recipe: Filet of Redgill"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 16000,
	sellPrice = 4000,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Filet of Redgill"],
	learnedAt = 225,
}
t[13943] = {
	name = L["Recipe: Hot Smoked Bass"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 16000,
	sellPrice = 4000,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Hot Smoked Bass"],
	learnedAt = 240,
}
t[7087] = {
	name = L["Pattern: Crimson Silk Cloak"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 1200,
	sellPrice = 300,
	reqLevel = 0,
	profession = L["Tailoring"],
	teaches = L["Crimson Silk Cloak"],
	learnedAt = 180,
}
t[14630] = {
	name = L["Pattern: Enchanter's Cowl"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 1000,
	sellPrice = 250,
	reqLevel = 0,
	profession = L["Tailoring"],
	teaches = L["Enchanter's Cowl"],
	learnedAt = 165,
}
t[10318] = {
	name = L["Pattern: Admiral's Hat"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 7000,
	sellPrice = 1750,
	reqLevel = 0,
	profession = L["Tailoring"],
	teaches = L["Admiral's Hat"],
	learnedAt = 240,
}
t[13310] = {
	name = L["Schematic: Accurate Scope"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 2000,
	sellPrice = 500,
	reqLevel = 0,
	profession = L["Engineering"],
	teaches = L["Accurate Scope"],
	learnedAt = 180,
}
t[13311] = {
	name = L["Schematic: Mechanical Dragonling"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 0,
	profession = L["Engineering"],
	teaches = L["Mechanical Dragonling"],
	learnedAt = 200,
}
t[14635] = {
	name = L["Pattern: Gem-studded Leather Belt"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 3000,
	sellPrice = 750,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Gem-studded Leather Belt"],
	learnedAt = 185,
}
t[18239] = {
	name = L["Pattern: Shadowskin Gloves"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 3500,
	sellPrice = 875,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Shadowskin Gloves"],
	learnedAt = 200,
}
t[4595] = {
	name = L["Junglevine Wine"],
	quality = 1,
	icon = "inv_drink_09",
	buyPrice = 300,
	sellPrice = 75,
	reqLevel = 0,
}
t[12162] = {
	name = L["Plans: Hardened Iron Shortsword"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 3000,
	sellPrice = 750,
	reqLevel = 0,
	profession = L["Blacksmithing"],
	teaches = L["Hardened Iron Shortsword"],
	learnedAt = 160,
}
t[12257] = {
	name = L["Heavy Notched Belt"],
	quality = 2,
	icon = "inv_belt_34",
	buyPrice = 19430,
	sellPrice = 3886,
	reqLevel = 37,
}
t[5788] = {
	name = L["Pattern: Thick Murloc Armor"],
	quality = 2,
	icon = "inv_scroll_03",
	buyPrice = 650,
	sellPrice = 162,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Thick Murloc Armor"],
	learnedAt = 170,
}
t[6056] = {
	name = L["Recipe: Frost Protection Potion"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 2000,
	sellPrice = 500,
	reqLevel = 0,
	profession = L["Alchemy"],
	teaches = L["Frost Protection Potion"],
	learnedAt = 190,
}
t[10602] = {
	name = L["Schematic: Deadly Scope"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 3000,
	sellPrice = 750,
	reqLevel = 0,
	profession = L["Engineering"],
	teaches = L["Deadly Scope"],
	learnedAt = 210,
}
t[19764] = {
	name = L["Pattern: Bloodvine Vest"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 50000,
	sellPrice = 12500,
	reqLevel = 0,
	profession = L["Tailoring"],
	teaches = L["Bloodvine Vest"],
	learnedAt = 300,
}
t[19765] = {
	name = L["Pattern: Bloodvine Leggings"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 50000,
	sellPrice = 12500,
	reqLevel = 0,
	profession = L["Tailoring"],
	teaches = L["Bloodvine Leggings"],
	learnedAt = 300,
}
t[19766] = {
	name = L["Pattern: Bloodvine Boots"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 50000,
	sellPrice = 12500,
	reqLevel = 0,
	profession = L["Tailoring"],
	teaches = L["Bloodvine Boots"],
	learnedAt = 300,
}
t[19769] = {
	name = L["Pattern: Primal Batskin Jerkin"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 50000,
	sellPrice = 12500,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Primal Batskin Jerkin"],
	learnedAt = 300,
}
t[19770] = {
	name = L["Pattern: Primal Batskin Gloves"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 50000,
	sellPrice = 12500,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Primal Batskin Gloves"],
	learnedAt = 300,
}
t[19771] = {
	name = L["Pattern: Primal Batskin Bracers"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 50000,
	sellPrice = 12500,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Primal Batskin Bracers"],
	learnedAt = 300,
}
t[19772] = {
	name = L["Pattern: Blood Tiger Breastplate"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 50000,
	sellPrice = 12500,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Blood Tiger Breastplate"],
	learnedAt = 300,
}
t[19773] = {
	name = L["Pattern: Blood Tiger Shoulders"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 50000,
	sellPrice = 12500,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Blood Tiger Shoulders"],
	learnedAt = 300,
}
t[19776] = {
	name = L["Plans: Bloodsoul Breastplate"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 50000,
	sellPrice = 12500,
	reqLevel = 0,
	profession = L["Blacksmithing"],
	teaches = L["Bloodsoul Breastplate"],
	learnedAt = 300,
}
t[19777] = {
	name = L["Plans: Bloodsoul Shoulders"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 50000,
	sellPrice = 12500,
	reqLevel = 0,
	profession = L["Blacksmithing"],
	teaches = L["Bloodsoul Shoulders"],
	learnedAt = 300,
}
t[19778] = {
	name = L["Plans: Bloodsoul Gauntlets"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 50000,
	sellPrice = 12500,
	reqLevel = 0,
	profession = L["Blacksmithing"],
	teaches = L["Bloodsoul Gauntlets"],
	learnedAt = 300,
}
t[19779] = {
	name = L["Plans: Darksoul Breastplate"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 50000,
	sellPrice = 12500,
	reqLevel = 0,
	profession = L["Blacksmithing"],
	teaches = L["Darksoul Breastplate"],
	learnedAt = 300,
}
t[19780] = {
	name = L["Plans: Darksoul Leggings"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 50000,
	sellPrice = 12500,
	reqLevel = 0,
	profession = L["Blacksmithing"],
	teaches = L["Darksoul Leggings"],
	learnedAt = 300,
}
t[19781] = {
	name = L["Plans: Darksoul Shoulders"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 50000,
	sellPrice = 12500,
	reqLevel = 0,
	profession = L["Blacksmithing"],
	teaches = L["Darksoul Shoulders"],
	learnedAt = 300,
}
t[20000] = {
	name = L["Schematic: Bloodvine Goggles"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 120000,
	sellPrice = 30000,
	reqLevel = 0,
	profession = L["Engineering"],
	teaches = L["Bloodvine Goggles"],
	learnedAt = 300,
}
t[20001] = {
	name = L["Schematic: Bloodvine Lens"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 50000,
	sellPrice = 12500,
	reqLevel = 0,
	profession = L["Engineering"],
	teaches = L["Bloodvine Lens"],
	learnedAt = 300,
}
t[20011] = {
	name = L["Recipe: Mageblood Elixir"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 50000,
	sellPrice = 12500,
	reqLevel = 0,
	profession = L["Alchemy"],
	teaches = L["Mageblood Elixir"],
	learnedAt = 275,
}
t[20012] = {
	name = L["Recipe: Greater Dreamless Sleep Potion"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 50000,
	sellPrice = 12500,
	reqLevel = 0,
	profession = L["Alchemy"],
	teaches = L["Greater Dreamless Sleep Potion"],
	learnedAt = 275,
}
t[20013] = {
	name = L["Recipe: Living Action Potion"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 50000,
	sellPrice = 12500,
	reqLevel = 0,
	profession = L["Alchemy"],
	teaches = L["Living Action Potion"],
	learnedAt = 285,
}
t[20014] = {
	name = L["Recipe: Mighty Troll's Blood Elixir"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 50000,
	sellPrice = 12500,
	reqLevel = 0,
	profession = L["Alchemy"],
	teaches = L["Mighty Troll's Blood Elixir"],
	learnedAt = 290,
}
t[20756] = {
	name = L["Formula: Brilliant Wizard Oil"],
	quality = 1,
	icon = "inv_misc_note_01",
	buyPrice = 40000,
	sellPrice = 10000,
	reqLevel = 0,
	profession = L["Enchanting"],
	teaches = L["Brilliant Wizard Oil"],
	learnedAt = 300,
}
t[20757] = {
	name = L["Formula: Brilliant Mana Oil"],
	quality = 1,
	icon = "inv_misc_note_01",
	buyPrice = 40000,
	sellPrice = 10000,
	reqLevel = 0,
	profession = L["Enchanting"],
	teaches = L["Brilliant Mana Oil"],
	learnedAt = 300,
}
t[10609] = {
	name = L["Schematic: Mithril Mechanical Dragonling"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 4000,
	sellPrice = 1000,
	reqLevel = 0,
	profession = L["Engineering"],
	teaches = L["Mithril Mechanical Dragonling"],
	learnedAt = 250,
}
t[2686] = {
	name = L["Thunder Ale"],
	quality = 1,
	icon = "inv_drink_13",
	buyPrice = 50,
	sellPrice = 12,
	reqLevel = 1,
}
t[2894] = {
	name = L["Rhapsody Malt"],
	quality = 1,
	icon = "inv_drink_13",
	buyPrice = 50,
	sellPrice = 12,
	reqLevel = 1,
}
t[7995] = {
	name = L["Plans: Mithril Scale Bracers"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 6000,
	sellPrice = 1500,
	reqLevel = 0,
	profession = L["Blacksmithing"],
	teaches = L["Mithril Scale Bracers"],
	learnedAt = 215,
}
t[15735] = {
	name = L["Pattern: Ironfeather Shoulders"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 14000,
	sellPrice = 3500,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Ironfeather Shoulders"],
	learnedAt = 270,
}
t[18629] = {
	name = L["Black Lodestone"],
	quality = 1,
	icon = "inv_misc_gem_pearl_01",
	buyPrice = 500000,
	sellPrice = 0,
	reqLevel = 0,
}
t[18663] = {
	name = L["J'eevee's Jar"],
	quality = 1,
	icon = "inv_misc_urn_01",
	buyPrice = 1500000,
	sellPrice = 0,
	reqLevel = 0,
}
t[18670] = {
	name = L["Xorothian Glyphs"],
	quality = 1,
	icon = "inv_scroll_01",
	buyPrice = 500000,
	sellPrice = 0,
	reqLevel = 0,
}
t[18802] = {
	name = L["Shadowy Potion"],
	quality = 1,
	icon = "inv_potion_27",
	buyPrice = 60000,
	sellPrice = 5000,
	reqLevel = 0,
}
t[23848] = {
	name = L["Nethergarde Bitter"],
	quality = 1,
	icon = "inv_drink_04",
	buyPrice = 2000,
	sellPrice = 500,
	reqLevel = 30,
}
t[9300] = {
	name = L["Recipe: Elixir of Demonslaying"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 0,
	profession = L["Alchemy"],
	teaches = L["Elixir of Demonslaying"],
	learnedAt = 250,
}
t[21942] = {
	name = L["Design: Ruby Crown of Restoration"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 6000,
	sellPrice = 1500,
	reqLevel = 0,
}
t[13288] = {
	name = L["Pattern: Raptor Hide Belt"],
	quality = 2,
	icon = "inv_scroll_03",
	buyPrice = 2500,
	sellPrice = 625,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Raptor Hide Belt"],
	learnedAt = 165,
}
t[13287] = {
	name = L["Pattern: Raptor Hide Harness"],
	quality = 2,
	icon = "inv_scroll_03",
	buyPrice = 2500,
	sellPrice = 625,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Raptor Hide Harness"],
	learnedAt = 165,
}
t[11163] = {
	name = L["Formula: Enchant Bracer - Lesser Deflection"],
	quality = 2,
	icon = "inv_misc_note_01",
	buyPrice = 3000,
	sellPrice = 750,
	reqLevel = 0,
	profession = L["Enchanting"],
	teaches = L["Enchant Bracer - Lesser Deflection"],
	learnedAt = 170,
}
t[20068] = {
	name = L["Deathguard's Cloak"],
	quality = 4,
	icon = "inv_misc_cape_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[20072] = {
	name = L["Defiler's Talisman"],
	quality = 3,
	icon = "inv_jewelry_talisman_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 58,
}
t[20150] = {
	name = L["Defiler's Chain Girdle"],
	quality = 3,
	icon = "inv_belt_20",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 58,
}
t[20151] = {
	name = L["Defiler's Chain Girdle"],
	quality = 3,
	icon = "inv_belt_20",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 48,
}
t[20152] = {
	name = L["Defiler's Chain Girdle"],
	quality = 3,
	icon = "inv_belt_20",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 28,
}
t[20153] = {
	name = L["Defiler's Chain Girdle"],
	quality = 3,
	icon = "inv_belt_20",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 40,
}
t[20154] = {
	name = L["Defiler's Chain Greaves"],
	quality = 3,
	icon = "inv_boots_chain_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 58,
}
t[20155] = {
	name = L["Defiler's Chain Greaves"],
	quality = 3,
	icon = "inv_boots_chain_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 48,
}
t[20156] = {
	name = L["Defiler's Chain Greaves"],
	quality = 3,
	icon = "inv_boots_chain_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 40,
}
t[20157] = {
	name = L["Defiler's Chain Greaves"],
	quality = 3,
	icon = "inv_boots_chain_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 28,
}
t[20158] = {
	name = L["Defiler's Chain Pauldrons"],
	quality = 4,
	icon = "inv_shoulder_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[20159] = {
	name = L["Defiler's Cloth Boots"],
	quality = 3,
	icon = "inv_boots_cloth_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 58,
}
t[20160] = {
	name = L["Defiler's Cloth Boots"],
	quality = 3,
	icon = "inv_boots_cloth_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 48,
}
t[20161] = {
	name = L["Defiler's Cloth Boots"],
	quality = 3,
	icon = "inv_boots_cloth_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 38,
}
t[20162] = {
	name = L["Defiler's Cloth Boots"],
	quality = 3,
	icon = "inv_boots_cloth_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 28,
}
t[20163] = {
	name = L["Defiler's Cloth Girdle"],
	quality = 3,
	icon = "inv_belt_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 58,
}
t[20164] = {
	name = L["Defiler's Cloth Girdle"],
	quality = 3,
	icon = "inv_belt_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 28,
}
t[20165] = {
	name = L["Defiler's Cloth Girdle"],
	quality = 3,
	icon = "inv_belt_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 48,
}
t[20166] = {
	name = L["Defiler's Cloth Girdle"],
	quality = 3,
	icon = "inv_belt_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 38,
}
t[20167] = {
	name = L["Defiler's Lizardhide Boots"],
	quality = 3,
	icon = "inv_boots_cloth_04",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 58,
}
t[20168] = {
	name = L["Defiler's Lizardhide Boots"],
	quality = 3,
	icon = "inv_boots_cloth_04",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 38,
}
t[20169] = {
	name = L["Defiler's Lizardhide Boots"],
	quality = 3,
	icon = "inv_boots_cloth_04",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 28,
}
t[20170] = {
	name = L["Defiler's Lizardhide Boots"],
	quality = 3,
	icon = "inv_boots_cloth_04",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 48,
}
t[20171] = {
	name = L["Defiler's Lizardhide Girdle"],
	quality = 3,
	icon = "inv_belt_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 58,
}
t[20172] = {
	name = L["Defiler's Lizardhide Girdle"],
	quality = 3,
	icon = "inv_belt_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 28,
}
t[20173] = {
	name = L["Defiler's Lizardhide Girdle"],
	quality = 3,
	icon = "inv_belt_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 38,
}
t[20174] = {
	name = L["Defiler's Lizardhide Girdle"],
	quality = 3,
	icon = "inv_belt_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 48,
}
t[20175] = {
	name = L["Defiler's Lizardhide Shoulders"],
	quality = 4,
	icon = "inv_shoulder_24",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[20176] = {
	name = L["Defiler's Epaulets"],
	quality = 4,
	icon = "inv_shoulder_24",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[20177] = {
	name = L["Defiler's Lamellar Girdle"],
	quality = 3,
	icon = "inv_belt_14",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 58,
}
t[20178] = {
	name = L["Defiler's Lamellar Girdle"],
	quality = 3,
	icon = "inv_belt_14",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 28,
}
t[20179] = {
	name = L["Defiler's Lamellar Girdle"],
	quality = 3,
	icon = "inv_belt_14",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 48,
}
t[20180] = {
	name = L["Defiler's Lamellar Girdle"],
	quality = 3,
	icon = "inv_belt_14",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 40,
}
t[20181] = {
	name = L["Defiler's Lamellar Greaves"],
	quality = 3,
	icon = "inv_boots_plate_04",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 58,
}
t[20182] = {
	name = L["Defiler's Lamellar Greaves"],
	quality = 3,
	icon = "inv_boots_plate_04",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 28,
}
t[20183] = {
	name = L["Defiler's Lamellar Greaves"],
	quality = 3,
	icon = "inv_boots_plate_04",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 40,
}
t[20184] = {
	name = L["Defiler's Lamellar Spaulders"],
	quality = 4,
	icon = "inv_shoulder_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[20185] = {
	name = L["Defiler's Lamellar Greaves"],
	quality = 3,
	icon = "inv_boots_plate_04",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 48,
}
t[20186] = {
	name = L["Defiler's Leather Boots"],
	quality = 3,
	icon = "inv_boots_cloth_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 58,
}
t[20187] = {
	name = L["Defiler's Leather Boots"],
	quality = 3,
	icon = "inv_boots_cloth_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 38,
}
t[20188] = {
	name = L["Defiler's Leather Boots"],
	quality = 3,
	icon = "inv_boots_cloth_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 28,
}
t[20189] = {
	name = L["Defiler's Leather Boots"],
	quality = 3,
	icon = "inv_boots_cloth_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 48,
}
t[20190] = {
	name = L["Defiler's Leather Girdle"],
	quality = 3,
	icon = "inv_belt_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 58,
}
t[20191] = {
	name = L["Defiler's Leather Girdle"],
	quality = 3,
	icon = "inv_belt_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 28,
}
t[20192] = {
	name = L["Defiler's Leather Girdle"],
	quality = 3,
	icon = "inv_belt_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 38,
}
t[20193] = {
	name = L["Defiler's Leather Girdle"],
	quality = 3,
	icon = "inv_belt_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 48,
}
t[20194] = {
	name = L["Defiler's Leather Shoulders"],
	quality = 4,
	icon = "inv_shoulder_24",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[20195] = {
	name = L["Defiler's Mail Girdle"],
	quality = 3,
	icon = "inv_belt_20",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 58,
}
t[20196] = {
	name = L["Defiler's Mail Girdle"],
	quality = 3,
	icon = "inv_belt_20",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 48,
}
t[20197] = {
	name = L["Defiler's Padded Girdle"],
	quality = 3,
	icon = "inv_belt_20",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 28,
}
t[20198] = {
	name = L["Defiler's Mail Girdle"],
	quality = 3,
	icon = "inv_belt_20",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 40,
}
t[20199] = {
	name = L["Defiler's Mail Greaves"],
	quality = 3,
	icon = "inv_boots_chain_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 58,
}
t[20200] = {
	name = L["Defiler's Mail Greaves"],
	quality = 3,
	icon = "inv_boots_chain_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 40,
}
t[20201] = {
	name = L["Defiler's Mail Greaves"],
	quality = 3,
	icon = "inv_boots_chain_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 28,
}
t[20202] = {
	name = L["Defiler's Mail Greaves"],
	quality = 3,
	icon = "inv_boots_chain_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 48,
}
t[20203] = {
	name = L["Defiler's Mail Pauldrons"],
	quality = 4,
	icon = "inv_shoulder_19",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[20204] = {
	name = L["Defiler's Plate Girdle"],
	quality = 3,
	icon = "inv_belt_14",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 58,
}
t[20205] = {
	name = L["Defiler's Plate Girdle"],
	quality = 3,
	icon = "inv_belt_14",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 48,
}
t[20206] = {
	name = L["Defiler's Plate Girdle"],
	quality = 3,
	icon = "inv_belt_14",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 40,
}
t[20207] = {
	name = L["Defiler's Mail Girdle"],
	quality = 3,
	icon = "inv_belt_14",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 28,
}
t[20208] = {
	name = L["Defiler's Plate Greaves"],
	quality = 3,
	icon = "inv_boots_plate_04",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 58,
}
t[20209] = {
	name = L["Defiler's Plate Greaves"],
	quality = 3,
	icon = "inv_boots_plate_04",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 40,
}
t[20210] = {
	name = L["Defiler's Mail Greaves"],
	quality = 3,
	icon = "inv_boots_plate_04",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 28,
}
t[20211] = {
	name = L["Defiler's Plate Greaves"],
	quality = 3,
	icon = "inv_boots_plate_04",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 48,
}
t[20212] = {
	name = L["Defiler's Plate Spaulders"],
	quality = 4,
	icon = "inv_shoulder_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[20214] = {
	name = L["Mindfang"],
	quality = 4,
	icon = "inv_sword_13",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[20220] = {
	name = L["Ironbark Staff"],
	quality = 4,
	icon = "inv_wand_04",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[20222] = {
	name = L["Defiler's Enriched Ration"],
	quality = 1,
	icon = "inv_misc_food_33",
	buyPrice = 2000,
	sellPrice = 100,
	reqLevel = 45,
}
t[20223] = {
	name = L["Defiler's Field Ration"],
	quality = 1,
	icon = "inv_misc_food_09",
	buyPrice = 1000,
	sellPrice = 50,
	reqLevel = 25,
}
t[20224] = {
	name = L["Defiler's Iron Ration"],
	quality = 1,
	icon = "inv_misc_food_08",
	buyPrice = 1500,
	sellPrice = 75,
	reqLevel = 35,
}
t[20232] = {
	name = L["Defiler's Mageweave Bandage"],
	quality = 1,
	icon = "inv_misc_bandage_20",
	buyPrice = 1500,
	sellPrice = 75,
	reqLevel = 35,
}
t[20234] = {
	name = L["Defiler's Runecloth Bandage"],
	quality = 1,
	icon = "inv_misc_bandage_12",
	buyPrice = 2000,
	sellPrice = 100,
	reqLevel = 45,
}
t[20235] = {
	name = L["Defiler's Silk Bandage"],
	quality = 1,
	icon = "inv_misc_bandage_02",
	buyPrice = 1000,
	sellPrice = 50,
	reqLevel = 25,
}
t[21115] = {
	name = L["Defiler's Talisman"],
	quality = 3,
	icon = "inv_jewelry_talisman_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 48,
}
t[21116] = {
	name = L["Defiler's Talisman"],
	quality = 3,
	icon = "inv_jewelry_talisman_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 38,
}
t[21120] = {
	name = L["Defiler's Talisman"],
	quality = 3,
	icon = "inv_jewelry_talisman_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 28,
}
t[20041] = {
	name = L["Highlander's Plate Girdle"],
	quality = 3,
	icon = "inv_belt_14",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 58,
}
t[20042] = {
	name = L["Highlander's Lamellar Girdle"],
	quality = 3,
	icon = "inv_belt_14",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 58,
}
t[20043] = {
	name = L["Highlander's Chain Girdle"],
	quality = 3,
	icon = "inv_belt_20",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 58,
}
t[20044] = {
	name = L["Highlander's Mail Girdle"],
	quality = 3,
	icon = "inv_belt_20",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 58,
}
t[20045] = {
	name = L["Highlander's Leather Girdle"],
	quality = 3,
	icon = "inv_belt_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 58,
}
t[20046] = {
	name = L["Highlander's Lizardhide Girdle"],
	quality = 3,
	icon = "inv_belt_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 58,
}
t[20047] = {
	name = L["Highlander's Cloth Girdle"],
	quality = 3,
	icon = "inv_belt_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 58,
}
t[20048] = {
	name = L["Highlander's Plate Greaves"],
	quality = 3,
	icon = "inv_boots_plate_04",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 58,
}
t[20049] = {
	name = L["Highlander's Lamellar Greaves"],
	quality = 3,
	icon = "inv_boots_plate_04",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 58,
}
t[20050] = {
	name = L["Highlander's Chain Greaves"],
	quality = 3,
	icon = "inv_boots_chain_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 58,
}
t[20051] = {
	name = L["Highlander's Mail Greaves"],
	quality = 3,
	icon = "inv_boots_chain_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 58,
}
t[20052] = {
	name = L["Highlander's Leather Boots"],
	quality = 3,
	icon = "inv_boots_cloth_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 58,
}
t[20053] = {
	name = L["Highlander's Lizardhide Boots"],
	quality = 3,
	icon = "inv_boots_cloth_04",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 58,
}
t[20054] = {
	name = L["Highlander's Cloth Boots"],
	quality = 3,
	icon = "inv_boots_cloth_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 58,
}
t[20055] = {
	name = L["Highlander's Chain Pauldrons"],
	quality = 4,
	icon = "inv_shoulder_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[20056] = {
	name = L["Highlander's Mail Pauldrons"],
	quality = 4,
	icon = "inv_shoulder_19",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[20057] = {
	name = L["Highlander's Plate Spaulders"],
	quality = 4,
	icon = "inv_shoulder_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[20058] = {
	name = L["Highlander's Lamellar Spaulders"],
	quality = 4,
	icon = "inv_shoulder_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[20059] = {
	name = L["Highlander's Leather Shoulders"],
	quality = 4,
	icon = "inv_shoulder_24",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[20060] = {
	name = L["Highlander's Lizardhide Shoulders"],
	quality = 4,
	icon = "inv_shoulder_24",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[20061] = {
	name = L["Highlander's Epaulets"],
	quality = 4,
	icon = "inv_shoulder_24",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[20069] = {
	name = L["Ironbark Staff"],
	quality = 4,
	icon = "inv_wand_04",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[20070] = {
	name = L["Sageclaw"],
	quality = 4,
	icon = "inv_sword_13",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[20071] = {
	name = L["Talisman of Arathor"],
	quality = 3,
	icon = "inv_jewelry_talisman_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 58,
}
t[20073] = {
	name = L["Cloak of the Honor Guard"],
	quality = 4,
	icon = "inv_misc_cape_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[20088] = {
	name = L["Highlander's Chain Girdle"],
	quality = 3,
	icon = "inv_belt_20",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 48,
}
t[20089] = {
	name = L["Highlander's Chain Girdle"],
	quality = 3,
	icon = "inv_belt_20",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 40,
}
t[20090] = {
	name = L["Highlander's Padded Girdle"],
	quality = 3,
	icon = "inv_belt_20",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 28,
}
t[20091] = {
	name = L["Highlander's Chain Greaves"],
	quality = 3,
	icon = "inv_boots_chain_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 48,
}
t[20092] = {
	name = L["Highlander's Chain Greaves"],
	quality = 3,
	icon = "inv_boots_chain_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 40,
}
t[20093] = {
	name = L["Highlander's Padded Greaves"],
	quality = 3,
	icon = "inv_boots_chain_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 28,
}
t[20094] = {
	name = L["Highlander's Cloth Boots"],
	quality = 3,
	icon = "inv_boots_cloth_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 48,
}
t[20095] = {
	name = L["Highlander's Cloth Boots"],
	quality = 3,
	icon = "inv_boots_cloth_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 38,
}
t[20096] = {
	name = L["Highlander's Cloth Boots"],
	quality = 3,
	icon = "inv_boots_cloth_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 28,
}
t[20097] = {
	name = L["Highlander's Cloth Girdle"],
	quality = 3,
	icon = "inv_belt_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 48,
}
t[20098] = {
	name = L["Highlander's Cloth Girdle"],
	quality = 3,
	icon = "inv_belt_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 38,
}
t[20099] = {
	name = L["Highlander's Cloth Girdle"],
	quality = 3,
	icon = "inv_belt_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 28,
}
t[20100] = {
	name = L["Highlander's Lizardhide Boots"],
	quality = 3,
	icon = "inv_boots_cloth_04",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 48,
}
t[20101] = {
	name = L["Highlander's Lizardhide Boots"],
	quality = 3,
	icon = "inv_boots_cloth_04",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 38,
}
t[20102] = {
	name = L["Highlander's Lizardhide Boots"],
	quality = 3,
	icon = "inv_boots_cloth_04",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 28,
}
t[20103] = {
	name = L["Highlander's Lizardhide Girdle"],
	quality = 3,
	icon = "inv_belt_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 48,
}
t[20104] = {
	name = L["Highlander's Lizardhide Girdle"],
	quality = 3,
	icon = "inv_belt_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 38,
}
t[20105] = {
	name = L["Highlander's Lizardhide Girdle"],
	quality = 3,
	icon = "inv_belt_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 28,
}
t[20106] = {
	name = L["Highlander's Lamellar Girdle"],
	quality = 3,
	icon = "inv_belt_14",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 48,
}
t[20107] = {
	name = L["Highlander's Lamellar Girdle"],
	quality = 3,
	icon = "inv_belt_14",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 40,
}
t[20108] = {
	name = L["Highlander's Lamellar Girdle"],
	quality = 3,
	icon = "inv_belt_14",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 28,
}
t[20109] = {
	name = L["Highlander's Lamellar Greaves"],
	quality = 3,
	icon = "inv_boots_plate_04",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 48,
}
t[20110] = {
	name = L["Highlander's Lamellar Greaves"],
	quality = 3,
	icon = "inv_boots_plate_04",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 40,
}
t[20111] = {
	name = L["Highlander's Lamellar Greaves"],
	quality = 3,
	icon = "inv_boots_plate_04",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 28,
}
t[20112] = {
	name = L["Highlander's Leather Boots"],
	quality = 3,
	icon = "inv_boots_cloth_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 48,
}
t[20113] = {
	name = L["Highlander's Leather Boots"],
	quality = 3,
	icon = "inv_boots_cloth_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 38,
}
t[20114] = {
	name = L["Highlander's Leather Boots"],
	quality = 3,
	icon = "inv_boots_cloth_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 28,
}
t[20115] = {
	name = L["Highlander's Leather Girdle"],
	quality = 3,
	icon = "inv_belt_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 48,
}
t[20116] = {
	name = L["Highlander's Leather Girdle"],
	quality = 3,
	icon = "inv_belt_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 38,
}
t[20117] = {
	name = L["Highlander's Leather Girdle"],
	quality = 3,
	icon = "inv_belt_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 28,
}
t[20118] = {
	name = L["Highlander's Mail Girdle"],
	quality = 3,
	icon = "inv_belt_20",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 48,
}
t[20119] = {
	name = L["Highlander's Mail Girdle"],
	quality = 3,
	icon = "inv_belt_20",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 40,
}
t[20120] = {
	name = L["Highlander's Mail Girdle"],
	quality = 3,
	icon = "inv_belt_20",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 28,
}
t[20121] = {
	name = L["Highlander's Mail Greaves"],
	quality = 3,
	icon = "inv_boots_chain_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 48,
}
t[20122] = {
	name = L["Highlander's Mail Greaves"],
	quality = 3,
	icon = "inv_boots_chain_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 40,
}
t[20123] = {
	name = L["Highlander's Mail Greaves"],
	quality = 3,
	icon = "inv_boots_chain_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 28,
}
t[20124] = {
	name = L["Highlander's Plate Girdle"],
	quality = 3,
	icon = "inv_belt_14",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 48,
}
t[20125] = {
	name = L["Highlander's Plate Girdle"],
	quality = 3,
	icon = "inv_belt_14",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 40,
}
t[20126] = {
	name = L["Highlander's Mail Girdle"],
	quality = 3,
	icon = "inv_belt_14",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 28,
}
t[20127] = {
	name = L["Highlander's Plate Greaves"],
	quality = 3,
	icon = "inv_boots_plate_04",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 48,
}
t[20128] = {
	name = L["Highlander's Plate Greaves"],
	quality = 3,
	icon = "inv_boots_plate_04",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 40,
}
t[20129] = {
	name = L["Highlander's Mail Greaves"],
	quality = 3,
	icon = "inv_boots_plate_04",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 28,
}
t[20225] = {
	name = L["Highlander's Enriched Ration"],
	quality = 1,
	icon = "inv_misc_food_33",
	buyPrice = 2000,
	sellPrice = 100,
	reqLevel = 45,
}
t[20226] = {
	name = L["Highlander's Field Ration"],
	quality = 1,
	icon = "inv_misc_food_09",
	buyPrice = 1000,
	sellPrice = 50,
	reqLevel = 25,
}
t[20227] = {
	name = L["Highlander's Iron Ration"],
	quality = 1,
	icon = "inv_misc_food_08",
	buyPrice = 1500,
	sellPrice = 75,
	reqLevel = 35,
}
t[20237] = {
	name = L["Highlander's Mageweave Bandage"],
	quality = 1,
	icon = "inv_misc_bandage_20",
	buyPrice = 1500,
	sellPrice = 75,
	reqLevel = 35,
}
t[20243] = {
	name = L["Highlander's Runecloth Bandage"],
	quality = 1,
	icon = "inv_misc_bandage_12",
	buyPrice = 2000,
	sellPrice = 100,
	reqLevel = 45,
}
t[20244] = {
	name = L["Highlander's Silk Bandage"],
	quality = 1,
	icon = "inv_misc_bandage_02",
	buyPrice = 1000,
	sellPrice = 50,
	reqLevel = 25,
}
t[21117] = {
	name = L["Talisman of Arathor"],
	quality = 3,
	icon = "inv_jewelry_talisman_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 48,
}
t[21118] = {
	name = L["Talisman of Arathor"],
	quality = 3,
	icon = "inv_jewelry_talisman_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 38,
}
t[21119] = {
	name = L["Talisman of Arathor"],
	quality = 3,
	icon = "inv_jewelry_talisman_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 28,
}
t[20971] = {
	name = L["Design: Heavy Iron Knuckles"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 1500,
	sellPrice = 375,
	reqLevel = 0,
}
t[3703] = {
	name = L["Southshore Stout"],
	quality = 1,
	icon = "inv_drink_08",
	buyPrice = 145,
	sellPrice = 36,
	reqLevel = 0,
}
t[6401] = {
	name = L["Pattern: Dark Silk Shirt"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 1100,
	sellPrice = 275,
	reqLevel = 0,
	profession = L["Tailoring"],
	teaches = L["Dark Silk Shirt"],
	learnedAt = 155,
}
t[7613] = {
	name = L["Pattern: Green Leather Armor"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 2000,
	sellPrice = 500,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Green Leather Armor"],
	learnedAt = 155,
}
t[6377] = {
	name = L["Formula: Enchant Boots - Minor Agility"],
	quality = 2,
	icon = "inv_misc_note_01",
	buyPrice = 1000,
	sellPrice = 250,
	reqLevel = 0,
	profession = L["Enchanting"],
	teaches = L["Enchant Boots - Minor Agility"],
	learnedAt = 125,
}
t[7362] = {
	name = L["Pattern: Earthen Leather Shoulders"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 2000,
	sellPrice = 500,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Earthen Leather Shoulders"],
	learnedAt = 135,
}
t[12247] = {
	name = L["Broad Bladed Knife"],
	quality = 2,
	icon = "inv_weapon_shortblade_04",
	buyPrice = 28373,
	sellPrice = 5674,
	reqLevel = 27,
}
t[20604] = {
	name = L["Stink Bomb Cleaner"],
	quality = 1,
	icon = "inv_misc_enggizmos_02",
	buyPrice = 500,
	sellPrice = 0,
	reqLevel = 0,
}
t[5374] = {
	name = L["Small Pocket Watch"],
	quality = 0,
	icon = "inv_misc_pocketwatch_02",
	buyPrice = 350,
	sellPrice = 87,
	reqLevel = 0,
}
t[184937] = {
	name = L["Chronoboon Displacer"],
	quality = 1,
	icon = "inv_misc_enggizmos_21",
	buyPrice = 100000,
	sellPrice = 25000,
	reqLevel = 0,
}
t[13320] = {
	name = L["Arcane Quickener"],
	quality = 1,
	icon = "spell_nature_abolishmagic",
	buyPrice = 5000,
	sellPrice = 0,
	reqLevel = 0,
}
t[8030] = {
	name = L["Plans: Ebon Shiv"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 0,
	profession = L["Blacksmithing"],
	teaches = L["Ebon Shiv"],
	learnedAt = 255,
}
t[12703] = {
	name = L["Plans: Storm Gauntlets"],
	quality = 3,
	icon = "inv_scroll_03",
	buyPrice = 40000,
	sellPrice = 10000,
	reqLevel = 0,
	profession = L["Blacksmithing"],
	teaches = L["Storm Gauntlets"],
	learnedAt = 295,
}
t[12819] = {
	name = L["Plans: Ornate Thorium Handaxe"],
	quality = 2,
	icon = "inv_scroll_03",
	buyPrice = 16000,
	sellPrice = 4000,
	reqLevel = 0,
	profession = L["Blacksmithing"],
	teaches = L["Ornate Thorium Handaxe"],
	learnedAt = 275,
}
t[12823] = {
	name = L["Plans: Huge Thorium Battleaxe"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 20000,
	sellPrice = 5000,
	reqLevel = 0,
	profession = L["Blacksmithing"],
	teaches = L["Huge Thorium Battleaxe"],
	learnedAt = 280,
}
t[13485] = {
	name = L["Recipe: Transmute Water to Air"],
	quality = 2,
	icon = "inv_scroll_06",
	buyPrice = 15000,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Alchemy"],
	teaches = L["Transmute: Water to Air"],
	learnedAt = 275,
}
t[13501] = {
	name = L["Recipe: Major Mana Potion"],
	quality = 2,
	icon = "inv_scroll_06",
	buyPrice = 30000,
	sellPrice = 7500,
	reqLevel = 0,
	profession = L["Alchemy"],
	teaches = L["Major Mana Potion"],
	learnedAt = 295,
}
t[15725] = {
	name = L["Pattern: Wicked Leather Gauntlets"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 12000,
	sellPrice = 3000,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Wicked Leather Gauntlets"],
	learnedAt = 260,
}
t[15741] = {
	name = L["Pattern: Stormshroud Pants"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 16000,
	sellPrice = 4000,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Stormshroud Pants"],
	learnedAt = 275,
}
t[12255] = {
	name = L["Pale Leggings"],
	quality = 2,
	icon = "inv_pants_01",
	buyPrice = 34988,
	sellPrice = 6997,
	reqLevel = 41,
}
t[12256] = {
	name = L["Cindercloth Leggings"],
	quality = 2,
	icon = "inv_pants_06",
	buyPrice = 43828,
	sellPrice = 8765,
	reqLevel = 44,
}
t[11223] = {
	name = L["Formula: Enchant Bracer - Deflection"],
	quality = 2,
	icon = "inv_misc_note_01",
	buyPrice = 5800,
	sellPrice = 1450,
	reqLevel = 0,
	profession = L["Enchanting"],
	teaches = L["Enchant Bracer - Deflection"],
	learnedAt = 235,
}
t[15726] = {
	name = L["Pattern: Green Dragonscale Breastplate"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 12000,
	sellPrice = 3000,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Green Dragonscale Breastplate"],
	learnedAt = 260,
}
t[2411] = {
	name = L["Black Stallion Bridle"],
	quality = 3,
	icon = "ability_mount_ridinghorse",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 20,
}
t[7290] = {
	name = L["Pattern: Red Whelp Gloves"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 1600,
	sellPrice = 400,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Red Whelp Gloves"],
	learnedAt = 120,
}
t[4378] = {
	name = L["Heavy Dynamite"],
	quality = 1,
	icon = "inv_misc_bomb_06",
	buyPrice = 1400,
	sellPrice = 350,
	reqLevel = 0,
}
t[1942] = {
	name = L["Bottle of Moonshine"],
	quality = 1,
	icon = "inv_drink_11",
	buyPrice = 1265,
	sellPrice = 316,
	reqLevel = 0,
}
t[14627] = {
	name = L["Pattern: Bright Yellow Shirt"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 800,
	sellPrice = 200,
	reqLevel = 0,
	profession = L["Tailoring"],
	teaches = L["Bright Yellow Shirt"],
	learnedAt = 135,
}
t[14634] = {
	name = L["Recipe: Frost Oil"],
	quality = 2,
	icon = "inv_scroll_06",
	buyPrice = 2500,
	sellPrice = 625,
	reqLevel = 0,
	profession = L["Alchemy"],
	teaches = L["Frost Oil"],
	learnedAt = 200,
}
t[13308] = {
	name = L["Schematic: Ice Deflector"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 1800,
	sellPrice = 450,
	reqLevel = 0,
	profession = L["Engineering"],
	teaches = L["Ice Deflector"],
	learnedAt = 155,
}
t[7742] = {
	name = L["Schematic: Gnomish Cloaking Device"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 2400,
	sellPrice = 600,
	reqLevel = 0,
	profession = L["Engineering"],
	teaches = L["Gnomish Cloaking Device"],
	learnedAt = 200,
}
t[18160] = {
	name = L["Recipe: Thistle Tea"],
	quality = 2,
	icon = "inv_scroll_03",
	buyPrice = 200,
	sellPrice = 50,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Thistle Tea"],
	learnedAt = 60,
}
t[19030] = {
	name = L["Stormpike Battle Charger"],
	quality = 4,
	icon = "ability_mount_mountainram",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 40,
}
t[19045] = {
	name = L["Stormpike Battle Standard"],
	quality = 3,
	icon = "inv_bannerpvp_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[19084] = {
	name = L["Stormpike Soldier's Cloak"],
	quality = 3,
	icon = "inv_misc_cape_18",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 55,
}
t[19086] = {
	name = L["Stormpike Sage's Cloak"],
	quality = 3,
	icon = "inv_misc_cape_18",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 55,
}
t[19091] = {
	name = L["Stormpike Plate Girdle"],
	quality = 3,
	icon = "inv_belt_35",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 55,
}
t[19092] = {
	name = L["Stormpike Mail Girdle"],
	quality = 3,
	icon = "inv_belt_18",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 55,
}
t[19093] = {
	name = L["Stormpike Leather Girdle"],
	quality = 3,
	icon = "inv_belt_26",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 55,
}
t[19094] = {
	name = L["Stormpike Cloth Girdle"],
	quality = 3,
	icon = "inv_belt_04",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 55,
}
t[19097] = {
	name = L["Stormpike Soldier's Pendant"],
	quality = 3,
	icon = "inv_jewelry_necklace_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 55,
}
t[19098] = {
	name = L["Stormpike Sage's Pendant"],
	quality = 3,
	icon = "inv_jewelry_necklace_08",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 55,
}
t[19100] = {
	name = L["Electrified Dagger"],
	quality = 3,
	icon = "inv_weapon_shortblade_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[19102] = {
	name = L["Crackling Staff"],
	quality = 3,
	icon = "inv_staff_20",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[19104] = {
	name = L["Stormstrike Hammer"],
	quality = 3,
	icon = "inv_hammer_21",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[19301] = {
	name = L["Alterac Manna Biscuit"],
	quality = 1,
	icon = "inv_misc_food_33",
	buyPrice = 7000,
	sellPrice = 350,
	reqLevel = 51,
}
t[19307] = {
	name = L["Alterac Heavy Runecloth Bandage"],
	quality = 1,
	icon = "inv_misc_bandage_12",
	buyPrice = 8000,
	sellPrice = 100,
	reqLevel = 0,
}
t[19308] = {
	name = L["Tome of Arcane Domination"],
	quality = 4,
	icon = "inv_misc_book_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[19309] = {
	name = L["Tome of Shadow Force"],
	quality = 4,
	icon = "inv_misc_book_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[19310] = {
	name = L["Tome of the Ice Lord"],
	quality = 4,
	icon = "inv_misc_book_11",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[19311] = {
	name = L["Tome of Fiery Arcana"],
	quality = 4,
	icon = "inv_misc_book_09",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[19312] = {
	name = L["Lei of the Lifegiver"],
	quality = 4,
	icon = "inv_misc_flower_04",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[19315] = {
	name = L["Therazane's Touch"],
	quality = 4,
	icon = "inv_misc_branch_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[19316] = {
	name = L["Ice Threaded Arrow"],
	quality = 2,
	icon = "spell_frost_iceshard",
	buyPrice = 6000,
	sellPrice = 7,
	reqLevel = 51,
}
t[19317] = {
	name = L["Ice Threaded Bullet"],
	quality = 2,
	icon = "spell_frost_frostblast",
	buyPrice = 6000,
	sellPrice = 7,
	reqLevel = 51,
}
t[19318] = {
	name = L["Bottled Alterac Spring Water"],
	quality = 1,
	icon = "inv_drink_11",
	buyPrice = 5000,
	sellPrice = 250,
	reqLevel = 55,
}
t[19319] = {
	name = L["Harpy Hide Quiver"],
	quality = 3,
	icon = "inv_misc_quiver_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 55,
}
t[19320] = {
	name = L["Gnoll Skin Bandolier"],
	quality = 3,
	icon = "inv_misc_ammo_bullet_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 55,
}
t[19321] = {
	name = L["The Immovable Object"],
	quality = 4,
	icon = "spell_frost_chillingarmor",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[19323] = {
	name = L["The Unstoppable Force"],
	quality = 4,
	icon = "inv_hammer_13",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[19324] = {
	name = L["The Lobotomizer"],
	quality = 4,
	icon = "inv_sword_29",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[19325] = {
	name = L["Don Julio's Band"],
	quality = 4,
	icon = "inv_jewelry_ring_35",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[21563] = {
	name = L["Don Rodrigo's Band"],
	quality = 4,
	icon = "inv_jewelry_ring_34",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[19029] = {
	name = L["Horn of the Frostwolf Howler"],
	quality = 4,
	icon = "inv_misc_horn_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 40,
}
t[19031] = {
	name = L["Frostwolf Battle Tabard"],
	quality = 1,
	icon = "inv_shirt_guildtabard_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[19046] = {
	name = L["Frostwolf Battle Standard"],
	quality = 3,
	icon = "inv_bannerpvp_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[19083] = {
	name = L["Frostwolf Legionnaire's Cloak"],
	quality = 3,
	icon = "inv_misc_cape_16",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 55,
}
t[19085] = {
	name = L["Frostwolf Advisor's Cloak"],
	quality = 3,
	icon = "inv_misc_cape_16",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 55,
}
t[19087] = {
	name = L["Frostwolf Plate Belt"],
	quality = 3,
	icon = "inv_belt_35",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 55,
}
t[19088] = {
	name = L["Frostwolf Mail Belt"],
	quality = 3,
	icon = "inv_belt_18",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 55,
}
t[19089] = {
	name = L["Frostwolf Leather Belt"],
	quality = 3,
	icon = "inv_belt_26",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 55,
}
t[19090] = {
	name = L["Frostwolf Cloth Belt"],
	quality = 3,
	icon = "inv_belt_04",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 55,
}
t[19095] = {
	name = L["Frostwolf Legionnaire's Pendant"],
	quality = 3,
	icon = "inv_jewelry_necklace_16",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 55,
}
t[19096] = {
	name = L["Frostwolf Advisor's Pendant"],
	quality = 3,
	icon = "inv_jewelry_necklace_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 55,
}
t[19099] = {
	name = L["Glacial Blade"],
	quality = 3,
	icon = "inv_weapon_shortblade_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[19101] = {
	name = L["Whiteout Staff"],
	quality = 3,
	icon = "inv_staff_30",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[19103] = {
	name = L["Frostbite"],
	quality = 3,
	icon = "inv_axe_22",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[20576] = {
	name = L["Pattern: Black Whelp Tunic"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 1400,
	sellPrice = 350,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Black Whelp Tunic"],
	learnedAt = 100,
}
t[7289] = {
	name = L["Pattern: Black Whelp Cloak"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 650,
	sellPrice = 162,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Black Whelp Cloak"],
	learnedAt = 100,
}
t[1939] = {
	name = L["Skin of Sweet Rum"],
	quality = 1,
	icon = "inv_drink_07",
	buyPrice = 675,
	sellPrice = 168,
	reqLevel = 0,
}
t[8485] = {
	name = L["Cat Carrier (Bombay)"],
	quality = 1,
	icon = "inv_box_petcarrier_01",
	buyPrice = 4000,
	sellPrice = 1000,
	reqLevel = 0,
}
t[8486] = {
	name = L["Cat Carrier (Cornish Rex)"],
	quality = 1,
	icon = "inv_box_petcarrier_01",
	buyPrice = 4000,
	sellPrice = 1000,
	reqLevel = 0,
}
t[8487] = {
	name = L["Cat Carrier (Orange Tabby)"],
	quality = 1,
	icon = "inv_box_petcarrier_01",
	buyPrice = 4000,
	sellPrice = 1000,
	reqLevel = 0,
}
t[8488] = {
	name = L["Cat Carrier (Silver Tabby)"],
	quality = 1,
	icon = "inv_box_petcarrier_01",
	buyPrice = 4000,
	sellPrice = 1000,
	reqLevel = 0,
}
t[33028] = {
	name = L["Barleybrew Light"],
	quality = 1,
	icon = "inv_drink_08",
	buyPrice = 15,
	sellPrice = 3,
	reqLevel = 5,
}
t[33029] = {
	name = L["Barleybrew Dark"],
	quality = 1,
	icon = "inv_drink_08",
	buyPrice = 50,
	sellPrice = 12,
	reqLevel = 15,
}
t[33030] = {
	name = L["Barleybrew Clear"],
	quality = 1,
	icon = "inv_drink_08",
	buyPrice = 3,
	sellPrice = 1,
	reqLevel = 1,
}
t[46400] = {
	name = L["Barleybrew Gold"],
	quality = 1,
	icon = "inv_drink_08",
	buyPrice = 1040,
	sellPrice = 260,
	reqLevel = 75,
}
t[5864] = {
	name = L["Gray Ram"],
	quality = 3,
	icon = "ability_mount_mountainram",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 20,
}
t[5872] = {
	name = L["Brown Ram"],
	quality = 3,
	icon = "ability_mount_mountainram",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 20,
}
t[5873] = {
	name = L["White Ram"],
	quality = 3,
	icon = "ability_mount_mountainram",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 20,
}
t[18785] = {
	name = L["Swift White Ram"],
	quality = 4,
	icon = "ability_mount_mountainram",
	buyPrice = 100000,
	sellPrice = 25000,
	reqLevel = 40,
}
t[18786] = {
	name = L["Swift Brown Ram"],
	quality = 4,
	icon = "ability_mount_mountainram",
	buyPrice = 100000,
	sellPrice = 25000,
	reqLevel = 40,
}
t[18787] = {
	name = L["Swift Gray Ram"],
	quality = 4,
	icon = "ability_mount_mountainram",
	buyPrice = 100000,
	sellPrice = 25000,
	reqLevel = 40,
}
t[8497] = {
	name = L["Rabbit Crate (Snowshoe)"],
	quality = 1,
	icon = "inv_crate_02",
	buyPrice = 2000,
	sellPrice = 500,
	reqLevel = 0,
}
t[8563] = {
	name = L["Red Mechanostrider"],
	quality = 3,
	icon = "ability_mount_mechastrider",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 20,
}
t[8595] = {
	name = L["Blue Mechanostrider"],
	quality = 3,
	icon = "ability_mount_mechastrider",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 20,
}
t[13321] = {
	name = L["Green Mechanostrider"],
	quality = 3,
	icon = "ability_mount_mechastrider",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 20,
}
t[13322] = {
	name = L["Unpainted Mechanostrider"],
	quality = 3,
	icon = "ability_mount_mechastrider",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 20,
}
t[18772] = {
	name = L["Swift Green Mechanostrider"],
	quality = 4,
	icon = "ability_mount_mechastrider",
	buyPrice = 100000,
	sellPrice = 25000,
	reqLevel = 40,
}
t[18773] = {
	name = L["Swift White Mechanostrider"],
	quality = 4,
	icon = "ability_mount_mechastrider",
	buyPrice = 100000,
	sellPrice = 25000,
	reqLevel = 40,
}
t[18774] = {
	name = L["Swift Yellow Mechanostrider"],
	quality = 4,
	icon = "ability_mount_mechastrider",
	buyPrice = 100000,
	sellPrice = 25000,
	reqLevel = 40,
}
t[33047] = {
	name = L["Belbi's Eyesight Enhancing Romance Goggles"],
	quality = 1,
	icon = "inv_gizmo_newgoggles",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[33978] = {
	name = L["\"Honorary Brewer\" Hand Stamp"],
	quality = 1,
	icon = "ability_mount_mountainram",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 40,
}
t[37571] = {
	name = L["\"Brew of the Month\" Club Membership Form"],
	quality = 1,
	icon = "inv_misc_note_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 1,
}
t[37736] = {
	name = L["\"Brew of the Month\" Club Membership Form"],
	quality = 1,
	icon = "inv_misc_note_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 1,
}
t[39476] = {
	name = L["Fresh Goblin Brewfest Hops"],
	quality = 1,
	icon = "inv_misc_herb_08",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 20,
}
t[6892] = {
	name = L["Recipe: Smoked Bear Meat"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 250,
	sellPrice = 62,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Smoked Bear Meat"],
	learnedAt = 40,
}
t[6346] = {
	name = L["Formula: Enchant Chest - Lesser Mana"],
	quality = 2,
	icon = "inv_misc_note_01",
	buyPrice = 400,
	sellPrice = 100,
	reqLevel = 0,
	profession = L["Enchanting"],
	teaches = L["Enchant Chest - Lesser Mana"],
	learnedAt = 80,
}
t[6349] = {
	name = L["Formula: Enchant 2H Weapon - Lesser Intellect"],
	quality = 1,
	icon = "inv_misc_note_01",
	buyPrice = 500,
	sellPrice = 125,
	reqLevel = 0,
	profession = L["Enchanting"],
	teaches = L["Enchant 2H Weapon - Lesser Intellect"],
	learnedAt = 100,
}
t[12226] = {
	name = L["Recipe: Crispy Bat Wing"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 25,
	sellPrice = 6,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Crispy Bat Wing"],
	learnedAt = 1,
}
t[13331] = {
	name = L["Red Skeletal Horse"],
	quality = 3,
	icon = "ability_mount_undeadhorse",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 20,
}
t[13332] = {
	name = L["Blue Skeletal Horse"],
	quality = 3,
	icon = "ability_mount_undeadhorse",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 20,
}
t[13333] = {
	name = L["Brown Skeletal Horse"],
	quality = 3,
	icon = "ability_mount_undeadhorse",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 20,
}
t[13334] = {
	name = L["Green Skeletal Warhorse"],
	quality = 4,
	icon = "ability_mount_undeadhorse",
	buyPrice = 100000,
	sellPrice = 25000,
	reqLevel = 40,
}
t[18791] = {
	name = L["Purple Skeletal Warhorse"],
	quality = 4,
	icon = "ability_mount_undeadhorse",
	buyPrice = 100000,
	sellPrice = 25000,
	reqLevel = 40,
}
t[46308] = {
	name = L["Black Skeletal Horse"],
	quality = 3,
	icon = "ability_mount_undeadhorse",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 20,
}
t[47101] = {
	name = L["Ochre Skeletal Warhorse"],
	quality = 4,
	icon = "ability_mount_undeadhorse",
	buyPrice = 100000,
	sellPrice = 25000,
	reqLevel = 40,
}
t[20387] = {
	name = L["Forsaken Stink Bomb Cluster"],
	quality = 1,
	icon = "inv_potion_12",
	buyPrice = 1000,
	sellPrice = 0,
	reqLevel = 0,
}
t[11109] = {
	name = L["Special Chicken Feed"],
	quality = 1,
	icon = "inv_misc_food_wheat_01",
	buyPrice = 25,
	sellPrice = 6,
	reqLevel = 1,
}
t[6329] = {
	name = L["Recipe: Loch Frenzy Delight"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 400,
	sellPrice = 100,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Loch Frenzy Delight"],
	learnedAt = 50,
}
t[29187] = {
	name = L["Inscription of Endurance"],
	quality = 2,
	icon = "ability_warrior_shieldmastery",
	buyPrice = 300000,
	sellPrice = 75000,
	reqLevel = 70,
}
t[31401] = {
	name = L["Design: The Frozen Eye"],
	quality = 4,
	icon = "inv_scroll_04",
	buyPrice = 120000,
	sellPrice = 30000,
	reqLevel = 0,
}
t[33124] = {
	name = L["Pattern: Cloak of Darkness"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 50000,
	sellPrice = 12500,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Cloak of Darkness"],
	learnedAt = 360,
}
t[33165] = {
	name = L["Formula: Enchant Weapon - Greater Agility"],
	quality = 1,
	icon = "inv_misc_note_01",
	buyPrice = 30000,
	sellPrice = 7500,
	reqLevel = 0,
	profession = L["Enchanting"],
	teaches = L["Enchant Weapon - Greater Agility"],
	learnedAt = 350,
}
t[33205] = {
	name = L["Pattern: Shadowprowler's Chestguard"],
	quality = 4,
	icon = "inv_scroll_04",
	buyPrice = 240000,
	sellPrice = 60000,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Shadowprowler's Chestguard"],
	learnedAt = 365,
}
t[33209] = {
	name = L["Recipe: Flask of Chromatic Wonder"],
	quality = 2,
	icon = "inv_scroll_06",
	buyPrice = 40000,
	sellPrice = 10000,
	reqLevel = 0,
	profession = L["Alchemy"],
	teaches = L["Flask of Chromatic Wonder"],
	learnedAt = 375,
}
t[46897] = {
	name = L["Design: Enduring Eye of Zul"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[46898] = {
	name = L["Design: Steady Eye of Zul"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[46899] = {
	name = L["Design: Vivid Eye of Zul"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[46900] = {
	name = L["Design: Dazzling Eye of Zul"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[46901] = {
	name = L["Design: Jagged Eye of Zul"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[46902] = {
	name = L["Design: Timeless Eye of Zul"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[46903] = {
	name = L["Design: Seer's Eye of Zul"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[46904] = {
	name = L["Design: Forceful Eye of Zul"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[46905] = {
	name = L["Design: Misty Eye of Zul"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[46906] = {
	name = L["Design: Sundered Eye of Zul"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[46907] = {
	name = L["Design: Shining Eye of Zul"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[46908] = {
	name = L["Design: Tense Eye of Zul"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[46909] = {
	name = L["Design: Lambent Eye of Zul"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[46910] = {
	name = L["Design: Intricate Eye of Zul"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[46911] = {
	name = L["Design: Radiant Eye of Zul"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[46912] = {
	name = L["Design: Energized Eye of Zul"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[46913] = {
	name = L["Design: Shattered Eye of Zul"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[46914] = {
	name = L["Design: Opaque Eye of Zul"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[46915] = {
	name = L["Design: Turbid Eye of Zul"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[46916] = {
	name = L["Design: Runed Cardinal Ruby"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[46917] = {
	name = L["Design: Bold Cardinal Ruby"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[46918] = {
	name = L["Design: Delicate Cardinal Ruby"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[46919] = {
	name = L["Design: Bright Cardinal Ruby"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[46920] = {
	name = L["Design: Precise Cardinal Ruby"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[46921] = {
	name = L["Design: Fractured Cardinal Ruby"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[46922] = {
	name = L["Design: Subtle Cardinal Ruby"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[46923] = {
	name = L["Design: Flashing Cardinal Ruby"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[46924] = {
	name = L["Design: Solid Majestic Zircon"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[46925] = {
	name = L["Design: Sparkling Majestic Zircon"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[46926] = {
	name = L["Design: Stormy Majestic Zircon"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[46927] = {
	name = L["Design: Lustrous Majestic Zircon"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[46928] = {
	name = L["Design: Rigid King's Amber"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[46929] = {
	name = L["Design: Smooth King's Amber"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[46930] = {
	name = L["Design: Brilliant King's Amber"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[46931] = {
	name = L["Design: Thick King's Amber"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[46932] = {
	name = L["Design: Mystic King's Amber"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[46933] = {
	name = L["Design: Quick King's Amber"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[46934] = {
	name = L["Design: Balanced Dreadstone"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[46935] = {
	name = L["Design: Sovereign Dreadstone"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[46936] = {
	name = L["Design: Glowing Dreadstone"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[46937] = {
	name = L["Design: Purified Dreadstone"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[46938] = {
	name = L["Design: Shifting Dreadstone"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[46939] = {
	name = L["Design: Royal Dreadstone"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[46940] = {
	name = L["Design: Regal Dreadstone"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[46941] = {
	name = L["Design: Defender's Dreadstone"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[46942] = {
	name = L["Design: Guardian's Dreadstone"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[46943] = {
	name = L["Design: Mysterious Dreadstone"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[46944] = {
	name = L["Design: Puissant Dreadstone"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[46945] = {
	name = L["Design: Infused Dreadstone"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[46946] = {
	name = L["Design: Tenuous Dreadstone"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[46947] = {
	name = L["Design: Luminous Ametrine"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[46948] = {
	name = L["Design: Inscribed Ametrine"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[46949] = {
	name = L["Design: Deadly Ametrine"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[46950] = {
	name = L["Design: Potent Ametrine"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[46951] = {
	name = L["Design: Veiled Ametrine"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[46952] = {
	name = L["Design: Durable Ametrine"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[46953] = {
	name = L["Design: Etched Ametrine"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[46956] = {
	name = L["Design: Pristine Ametrine"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[47007] = {
	name = L["Design: Reckless Ametrine"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[47008] = {
	name = L["Design: Glinting Ametrine"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[47010] = {
	name = L["Design: Accurate Ametrine"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[47011] = {
	name = L["Design: Wicked Ametrine"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[47012] = {
	name = L["Design: Glimmering Ametrine"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[47015] = {
	name = L["Design: Champion's Ametrine"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[47016] = {
	name = L["Design: Empowered Ametrine"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[47017] = {
	name = L["Design: Stalwart Ametrine"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[47018] = {
	name = L["Design: Resplendent Ametrine"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[47019] = {
	name = L["Design: Fierce Ametrine"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[47020] = {
	name = L["Design: Deft Ametrine"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[47021] = {
	name = L["Design: Lucent Ametrine"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[47022] = {
	name = L["Design: Resolute Ametrine"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[47023] = {
	name = L["Design: Stark Ametrine"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[49112] = {
	name = L["Design: Nightmare Tear"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[33448] = {
	name = L["Runic Mana Potion"],
	quality = 1,
	icon = "inv_alchemy_elixir_02",
	buyPrice = 24000,
	sellPrice = 6000,
	reqLevel = 70,
}
t[44602] = {
	name = L["Tome of Dalaran Intellect"],
	quality = 2,
	icon = "inv_misc_book_03",
	buyPrice = 4750000,
	sellPrice = 1187500,
	reqLevel = 80,
}
t[44709] = {
	name = L["Tome of Polymorph: Black Cat"],
	quality = 3,
	icon = "inv_misc_book_07",
	buyPrice = 25000000,
	sellPrice = 6250000,
	reqLevel = 60,
}
t[44714] = {
	name = L["Tome of Dalaran Brilliance"],
	quality = 2,
	icon = "inv_misc_book_03",
	buyPrice = 5000000,
	sellPrice = 1250000,
	reqLevel = 80,
}
t[41576] = {
	name = L["Design: Bold Scarlet Ruby"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[41577] = {
	name = L["Design: Delicate Scarlet Ruby"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[41578] = {
	name = L["Design: Flashing Scarlet Ruby"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[41579] = {
	name = L["Design: Quick Autumn's Glow"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[41580] = {
	name = L["Design: Rigid Autumn's Glow"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[41581] = {
	name = L["Design: Lustrous Sky Sapphire"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[41582] = {
	name = L["Design: Glinting Monarch Topaz"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[41686] = {
	name = L["Design: Potent Monarch Topaz"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[41687] = {
	name = L["Design: Stark Monarch Topaz"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[41688] = {
	name = L["Design: Veiled Monarch Topaz"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[41689] = {
	name = L["Design: Luminous Monarch Topaz"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[41690] = {
	name = L["Design: Reckless Monarch Topaz"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[41692] = {
	name = L["Design: Energized Forest Emerald"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[41693] = {
	name = L["Design: Forceful Forest Emerald"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[41694] = {
	name = L["Design: Intricate Forest Emerald"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[41696] = {
	name = L["Design: Lambent Forest Emerald"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[41697] = {
	name = L["Design: Enduring Forest Emerald"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[41698] = {
	name = L["Design: Vivid Forest Emerald"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[41699] = {
	name = L["Design: Seer's Forest Emerald"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[41701] = {
	name = L["Design: Royal Twilight Opal"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[41702] = {
	name = L["Design: Puissant Twilight Opal"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[41703] = {
	name = L["Design: Regal Twilight Opal"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[41704] = {
	name = L["Design: Chaotic Skyflare Diamond"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[41705] = {
	name = L["Design: Effulgent Skyflare Diamond"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[41706] = {
	name = L["Design: Ember Skyflare Diamond"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[41707] = {
	name = L["Design: Revitalizing Skyflare Diamond"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[41708] = {
	name = L["Design: Insightful Earthsiege Diamond"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[41709] = {
	name = L["Design: Invigorating Earthsiege Diamond"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[41710] = {
	name = L["Design: Relentless Earthsiege Diamond"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[41711] = {
	name = L["Design: Trenchant Earthsiege Diamond"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[41719] = {
	name = L["Design: Subtle Scarlet Ruby"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[41747] = {
	name = L["Design: Shifting Twilight Opal"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[42138] = {
	name = L["Design: Solid Sky Sapphire"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[42225] = {
	name = L["Dragon's Eye"],
	quality = 3,
	icon = "inv_jewelcrafting_dragonseye01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[42298] = {
	name = L["Design: Bold Dragon's Eye"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[42299] = {
	name = L["Design: Bright Dragon's Eye"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[42300] = {
	name = L["Design: Brilliant Dragon's Eye"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[42301] = {
	name = L["Design: Delicate Dragon's Eye"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[42302] = {
	name = L["Design: Flashing Dragon's Eye"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[42303] = {
	name = L["Design: Fractured Dragon's Eye"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[42304] = {
	name = L["Design: Lustrous Dragon's Eye"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[42305] = {
	name = L["Design: Mystic Dragon's Eye"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[42306] = {
	name = L["Design: Precise Dragon's Eye"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[42307] = {
	name = L["Design: Quick Dragon's Eye"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[42308] = {
	name = L["Design: Rigid Dragon's Eye"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[42309] = {
	name = L["Design: Runed Dragon's Eye"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[42310] = {
	name = L["Design: Smooth Dragon's Eye"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[42311] = {
	name = L["Design: Solid Dragon's Eye"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[42312] = {
	name = L["Design: Sparkling Dragon's Eye"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[42313] = {
	name = L["Design: Stormy Dragon's Eye"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[42314] = {
	name = L["Design: Subtle Dragon's Eye"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[42315] = {
	name = L["Design: Thick Dragon's Eye"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[42648] = {
	name = L["Design: Titanium Impact Band"],
	quality = 4,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[42649] = {
	name = L["Design: Titanium Earthguard Ring"],
	quality = 4,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[42650] = {
	name = L["Design: Titanium Spellshock Ring"],
	quality = 4,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[42651] = {
	name = L["Design: Titanium Impact Choker"],
	quality = 4,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[42652] = {
	name = L["Design: Titanium Earthguard Chain"],
	quality = 4,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[42653] = {
	name = L["Design: Titanium Spellshock Necklace"],
	quality = 4,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[43317] = {
	name = L["Design: Ring of Earthen Might"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[43318] = {
	name = L["Design: Ring of Scarlet Shadows"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[43319] = {
	name = L["Design: Windfire Band"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[43320] = {
	name = L["Design: Ring of Northern Tears"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[43485] = {
	name = L["Design: Savage Titanium Ring"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[43497] = {
	name = L["Design: Savage Titanium Band"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[43597] = {
	name = L["Design: Titanium Frostguard Ring"],
	quality = 4,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[23817] = {
	name = L["Schematic: Titanium Toolbox"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 80000,
	sellPrice = 20000,
	reqLevel = 0,
	profession = L["Engineering"],
	teaches = L["Titanium Toolbox"],
	learnedAt = 405,
}
t[50167] = {
	name = L["Technique: Glyph of Rapid Rejuvenation"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 80000,
	sellPrice = 20000,
	reqLevel = 0,
	profession = L["Inscription"],
	teaches = L["Glyph of Rapid Rejuvenation"],
	learnedAt = 375,
}
t[50168] = {
	name = L["Technique: Glyph of Quick Decay"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 80000,
	sellPrice = 20000,
	reqLevel = 0,
	profession = L["Inscription"],
	teaches = L["Glyph of Quick Decay"],
	learnedAt = 375,
}
t[37431] = {
	name = L["Fetch Ball"],
	quality = 2,
	icon = "inv_fabric_wool_02",
	buyPrice = 5000,
	sellPrice = 250,
	reqLevel = 0,
}
t[43352] = {
	name = L["Pet Grooming Kit"],
	quality = 2,
	icon = "inv_drink_19",
	buyPrice = 5000,
	sellPrice = 1250,
	reqLevel = 0,
}
t[43626] = {
	name = L["Happy Pet Snack"],
	quality = 2,
	icon = "inv_valentinescandysack",
	buyPrice = 5000,
	sellPrice = 250,
	reqLevel = 0,
}
t[44820] = {
	name = L["Red Ribbon Pet Leash"],
	quality = 1,
	icon = "inv_misc_bandage_16",
	buyPrice = 15000,
	sellPrice = 3750,
	reqLevel = 0,
}
t[44822] = {
	name = L["Albino Snake"],
	quality = 1,
	icon = "spell_nature_guardianward",
	buyPrice = 500000,
	sellPrice = 125000,
	reqLevel = 0,
}
t[46398] = {
	name = L["Calico Cat"],
	quality = 1,
	icon = "inv_box_petcarrier_01",
	buyPrice = 500000,
	sellPrice = 125000,
	reqLevel = 0,
}
t[48120] = {
	name = L["Obsidian Hatchling"],
	quality = 1,
	icon = "ability_mount_raptor",
	buyPrice = 500000,
	sellPrice = 125000,
	reqLevel = 0,
}
t[44637] = {
	name = L["Dalaran Crossbow"],
	quality = 1,
	icon = "inv_weapon_crossbow_14",
	buyPrice = 116757,
	sellPrice = 23351,
	reqLevel = 70,
}
t[44643] = {
	name = L["Dalaran Bow"],
	quality = 1,
	icon = "inv_weapon_bow_15",
	buyPrice = 119394,
	sellPrice = 23878,
	reqLevel = 70,
}
t[40700] = {
	name = L["Protective Barricade of the Light"],
	quality = 4,
	icon = "inv_shield_60",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40701] = {
	name = L["Crygil's Discarded Plate Panel"],
	quality = 4,
	icon = "inv_shield_41",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40703] = {
	name = L["Grasscutter"],
	quality = 4,
	icon = "inv_sword_123",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[44638] = {
	name = L["Dalaran Sword"],
	quality = 1,
	icon = "inv_sword_draenei_01",
	buyPrice = 156265,
	sellPrice = 31253,
	reqLevel = 70,
}
t[44639] = {
	name = L["Dalaran Greatsword"],
	quality = 1,
	icon = "inv_sword_40",
	buyPrice = 196067,
	sellPrice = 39213,
	reqLevel = 70,
}
t[39531] = {
	name = L["Heroes' Dreamwalker Headpiece"],
	quality = 4,
	icon = "inv_helmet_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[39538] = {
	name = L["Heroes' Dreamwalker Robe"],
	quality = 4,
	icon = "inv_chest_chain_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[39539] = {
	name = L["Heroes' Dreamwalker Leggings"],
	quality = 4,
	icon = "inv_pants_mail_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[39542] = {
	name = L["Heroes' Dreamwalker Spaulders"],
	quality = 4,
	icon = "inv_shoulder_14",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[39543] = {
	name = L["Heroes' Dreamwalker Handguards"],
	quality = 4,
	icon = "inv_gauntlets_25",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[39544] = {
	name = L["Heroes' Dreamwalker Gloves"],
	quality = 4,
	icon = "inv_gauntlets_25",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[39545] = {
	name = L["Heroes' Dreamwalker Cover"],
	quality = 4,
	icon = "inv_helmet_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[39546] = {
	name = L["Heroes' Dreamwalker Trousers"],
	quality = 4,
	icon = "inv_pants_mail_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[39547] = {
	name = L["Heroes' Dreamwalker Vestments"],
	quality = 4,
	icon = "inv_chest_plate02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[39548] = {
	name = L["Heroes' Dreamwalker Mantle"],
	quality = 4,
	icon = "inv_shoulder_14",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[39553] = {
	name = L["Heroes' Dreamwalker Headguard"],
	quality = 4,
	icon = "inv_helmet_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[39554] = {
	name = L["Heroes' Dreamwalker Raiments"],
	quality = 4,
	icon = "inv_chest_chain_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[39555] = {
	name = L["Heroes' Dreamwalker Legguards"],
	quality = 4,
	icon = "inv_pants_mail_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[39556] = {
	name = L["Heroes' Dreamwalker Shoulderpads"],
	quality = 4,
	icon = "inv_shoulder_14",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[39557] = {
	name = L["Heroes' Dreamwalker Handgrips"],
	quality = 4,
	icon = "inv_gauntlets_25",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[39558] = {
	name = L["Heroes' Bonescythe Breastplate"],
	quality = 4,
	icon = "inv_chest_chain_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[39560] = {
	name = L["Heroes' Bonescythe Gauntlets"],
	quality = 4,
	icon = "inv_gauntlets_25",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[39561] = {
	name = L["Heroes' Bonescythe Helmet"],
	quality = 4,
	icon = "inv_helmet_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[39564] = {
	name = L["Heroes' Bonescythe Legplates"],
	quality = 4,
	icon = "inv_pants_mail_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[39565] = {
	name = L["Heroes' Bonescythe Pauldrons"],
	quality = 4,
	icon = "inv_shoulder_14",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40460] = {
	name = L["Valorous Dreamwalker Handguards"],
	quality = 4,
	icon = "inv_gauntlets_25",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40461] = {
	name = L["Valorous Dreamwalker Headpiece"],
	quality = 4,
	icon = "inv_helmet_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40462] = {
	name = L["Valorous Dreamwalker Leggings"],
	quality = 4,
	icon = "inv_pants_mail_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40463] = {
	name = L["Valorous Dreamwalker Robe"],
	quality = 4,
	icon = "inv_chest_chain_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40465] = {
	name = L["Valorous Dreamwalker Spaulders"],
	quality = 4,
	icon = "inv_shoulder_14",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40466] = {
	name = L["Valorous Dreamwalker Gloves"],
	quality = 4,
	icon = "inv_gauntlets_25",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40467] = {
	name = L["Valorous Dreamwalker Cover"],
	quality = 4,
	icon = "inv_helmet_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40468] = {
	name = L["Valorous Dreamwalker Trousers"],
	quality = 4,
	icon = "inv_pants_mail_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40469] = {
	name = L["Valorous Dreamwalker Vestments"],
	quality = 4,
	icon = "inv_chest_chain_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40470] = {
	name = L["Valorous Dreamwalker Mantle"],
	quality = 4,
	icon = "inv_shoulder_14",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40471] = {
	name = L["Valorous Dreamwalker Raiments"],
	quality = 4,
	icon = "inv_chest_chain_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40472] = {
	name = L["Valorous Dreamwalker Handgrips"],
	quality = 4,
	icon = "inv_gauntlets_25",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40473] = {
	name = L["Valorous Dreamwalker Headguard"],
	quality = 4,
	icon = "inv_helmet_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40493] = {
	name = L["Valorous Dreamwalker Legguards"],
	quality = 4,
	icon = "inv_pants_mail_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40494] = {
	name = L["Valorous Dreamwalker Shoulderpads"],
	quality = 4,
	icon = "inv_shoulder_14",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40495] = {
	name = L["Valorous Bonescythe Breastplate"],
	quality = 4,
	icon = "inv_chest_chain_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40496] = {
	name = L["Valorous Bonescythe Gauntlets"],
	quality = 4,
	icon = "inv_gauntlets_25",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40499] = {
	name = L["Valorous Bonescythe Helmet"],
	quality = 4,
	icon = "inv_helmet_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40500] = {
	name = L["Valorous Bonescythe Legplates"],
	quality = 4,
	icon = "inv_pants_mail_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40502] = {
	name = L["Valorous Bonescythe Pauldrons"],
	quality = 4,
	icon = "inv_shoulder_14",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40694] = {
	name = L["Jorach's Crocolisk Skin Belt"],
	quality = 4,
	icon = "inv_belt_26",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40695] = {
	name = L["Vine Belt of the Woodland Dryad"],
	quality = 4,
	icon = "inv_belt_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40738] = {
	name = L["Wristwraps of the Cutthroat"],
	quality = 4,
	icon = "inv_bracer_16",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40739] = {
	name = L["Bands of the Great Tree"],
	quality = 4,
	icon = "inv_bracer_08",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40748] = {
	name = L["Boots of Captain Ellis"],
	quality = 4,
	icon = "inv_boots_08",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40749] = {
	name = L["Rainey's Chewed Boots"],
	quality = 4,
	icon = "inv_boots_03",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[47658] = {
	name = L["Brimstone Igniter"],
	quality = 4,
	icon = "inv_wand_32",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[39491] = {
	name = L["Heroes' Frostfire Circlet"],
	quality = 4,
	icon = "inv_crown_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[39492] = {
	name = L["Heroes' Frostfire Robe"],
	quality = 4,
	icon = "inv_chest_cloth_43",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[39493] = {
	name = L["Heroes' Frostfire Leggings"],
	quality = 4,
	icon = "inv_pants_cloth_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[39494] = {
	name = L["Heroes' Frostfire Shoulderpads"],
	quality = 4,
	icon = "inv_shoulder_25",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[39495] = {
	name = L["Heroes' Frostfire Gloves"],
	quality = 4,
	icon = "inv_gauntlets_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[39496] = {
	name = L["Heroes' Plagueheart Circlet"],
	quality = 4,
	icon = "inv_crown_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[39497] = {
	name = L["Heroes' Plagueheart Robe"],
	quality = 4,
	icon = "inv_chest_cloth_43",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[39498] = {
	name = L["Heroes' Plagueheart Leggings"],
	quality = 4,
	icon = "inv_pants_cloth_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[39499] = {
	name = L["Heroes' Plagueheart Shoulderpads"],
	quality = 4,
	icon = "inv_shoulder_25",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[39500] = {
	name = L["Heroes' Plagueheart Gloves"],
	quality = 4,
	icon = "inv_gauntlets_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[39514] = {
	name = L["Heroes' Crown of Faith"],
	quality = 4,
	icon = "inv_crown_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[39515] = {
	name = L["Heroes' Robe of Faith"],
	quality = 4,
	icon = "inv_chest_cloth_43",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[39517] = {
	name = L["Heroes' Leggings of Faith"],
	quality = 4,
	icon = "inv_pants_cloth_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[39518] = {
	name = L["Heroes' Shoulderpads of Faith"],
	quality = 4,
	icon = "inv_shoulder_25",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[39519] = {
	name = L["Heroes' Gloves of Faith"],
	quality = 4,
	icon = "inv_gauntlets_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[39521] = {
	name = L["Heroes' Circlet of Faith"],
	quality = 4,
	icon = "inv_crown_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[39523] = {
	name = L["Heroes' Raiments of Faith"],
	quality = 4,
	icon = "inv_chest_cloth_43",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[39528] = {
	name = L["Heroes' Pants of Faith"],
	quality = 4,
	icon = "inv_pants_cloth_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[39529] = {
	name = L["Heroes' Mantle of Faith"],
	quality = 4,
	icon = "inv_shoulder_25",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[39530] = {
	name = L["Heroes' Handwraps of Faith"],
	quality = 4,
	icon = "inv_gauntlets_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40415] = {
	name = L["Valorous Frostfire Gloves"],
	quality = 4,
	icon = "inv_gauntlets_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40416] = {
	name = L["Valorous Frostfire Circlet"],
	quality = 4,
	icon = "inv_crown_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40417] = {
	name = L["Valorous Frostfire Leggings"],
	quality = 4,
	icon = "inv_pants_cloth_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40418] = {
	name = L["Valorous Frostfire Robe"],
	quality = 4,
	icon = "inv_chest_cloth_43",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40419] = {
	name = L["Valorous Frostfire Shoulderpads"],
	quality = 4,
	icon = "inv_shoulder_25",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40420] = {
	name = L["Valorous Plagueheart Gloves"],
	quality = 4,
	icon = "inv_gauntlets_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40421] = {
	name = L["Valorous Plagueheart Circlet"],
	quality = 4,
	icon = "inv_crown_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40422] = {
	name = L["Valorous Plagueheart Leggings"],
	quality = 4,
	icon = "inv_pants_cloth_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40423] = {
	name = L["Valorous Plagueheart Robe"],
	quality = 4,
	icon = "inv_chest_cloth_43",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40424] = {
	name = L["Valorous Plagueheart Shoulderpads"],
	quality = 4,
	icon = "inv_shoulder_25",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40445] = {
	name = L["Valorous Gloves of Faith"],
	quality = 4,
	icon = "inv_gauntlets_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40447] = {
	name = L["Valorous Crown of Faith"],
	quality = 4,
	icon = "inv_crown_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40448] = {
	name = L["Valorous Leggings of Faith"],
	quality = 4,
	icon = "inv_pants_cloth_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40449] = {
	name = L["Valorous Robe of Faith"],
	quality = 4,
	icon = "inv_chest_cloth_43",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40450] = {
	name = L["Valorous Shoulderpads of Faith"],
	quality = 4,
	icon = "inv_shoulder_25",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40454] = {
	name = L["Valorous Handwraps of Faith"],
	quality = 4,
	icon = "inv_gauntlets_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40456] = {
	name = L["Valorous Circlet of Faith"],
	quality = 4,
	icon = "inv_crown_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40457] = {
	name = L["Valorous Pants of Faith"],
	quality = 4,
	icon = "inv_pants_cloth_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40458] = {
	name = L["Valorous Raiments of Faith"],
	quality = 4,
	icon = "inv_chest_cloth_43",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40459] = {
	name = L["Valorous Mantle of Faith"],
	quality = 4,
	icon = "inv_shoulder_25",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40696] = {
	name = L["Plush Sash of Guzbah"],
	quality = 4,
	icon = "inv_belt_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40697] = {
	name = L["Elegant Temple Gardens' Girdle"],
	quality = 4,
	icon = "inv_belt_08",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40740] = {
	name = L["Wraps of the Astral Traveler"],
	quality = 4,
	icon = "inv_bracer_18",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40750] = {
	name = L["Xintor's Expeditionary Boots"],
	quality = 4,
	icon = "inv_boots_cloth_03",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40751] = {
	name = L["Slippers of the Holy Light"],
	quality = 4,
	icon = "inv_boots_cloth_09",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[39605] = {
	name = L["Heroes' Dreadnaught Helmet"],
	quality = 4,
	icon = "inv_helmet_58",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[39606] = {
	name = L["Heroes' Dreadnaught Battleplate"],
	quality = 4,
	icon = "inv_chest_plate02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[39607] = {
	name = L["Heroes' Dreadnaught Legplates"],
	quality = 4,
	icon = "inv_pants_plate_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[39608] = {
	name = L["Heroes' Dreadnaught Shoulderplates"],
	quality = 4,
	icon = "inv_shoulder_29",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[39609] = {
	name = L["Heroes' Dreadnaught Gauntlets"],
	quality = 4,
	icon = "inv_gauntlets_28",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[39610] = {
	name = L["Heroes' Dreadnaught Greathelm"],
	quality = 4,
	icon = "inv_helmet_58",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[39611] = {
	name = L["Heroes' Dreadnaught Breastplate"],
	quality = 4,
	icon = "inv_chest_plate02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[39612] = {
	name = L["Heroes' Dreadnaught Legguards"],
	quality = 4,
	icon = "inv_pants_plate_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[39613] = {
	name = L["Heroes' Dreadnaught Pauldrons"],
	quality = 4,
	icon = "inv_shoulder_29",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[39617] = {
	name = L["Heroes' Scourgeborne Battleplate"],
	quality = 4,
	icon = "inv_chest_plate02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[39618] = {
	name = L["Heroes' Scourgeborne Gauntlets"],
	quality = 4,
	icon = "inv_gauntlets_28",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[39619] = {
	name = L["Heroes' Scourgeborne Helmet"],
	quality = 4,
	icon = "inv_helmet_58",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[39620] = {
	name = L["Heroes' Scourgeborne Legplates"],
	quality = 4,
	icon = "inv_pants_plate_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[39621] = {
	name = L["Heroes' Scourgeborne Shoulderplates"],
	quality = 4,
	icon = "inv_shoulder_29",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[39622] = {
	name = L["Heroes' Dreadnaught Handguards"],
	quality = 4,
	icon = "inv_gauntlets_28",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[39623] = {
	name = L["Heroes' Scourgeborne Chestguard"],
	quality = 4,
	icon = "inv_chest_plate02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[39624] = {
	name = L["Heroes' Scourgeborne Handguards"],
	quality = 4,
	icon = "inv_gauntlets_28",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[39625] = {
	name = L["Heroes' Scourgeborne Faceguard"],
	quality = 4,
	icon = "inv_helmet_58",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[39626] = {
	name = L["Heroes' Scourgeborne Legguards"],
	quality = 4,
	icon = "inv_pants_plate_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[39627] = {
	name = L["Heroes' Scourgeborne Pauldrons"],
	quality = 4,
	icon = "inv_shoulder_29",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[39628] = {
	name = L["Heroes' Redemption Headpiece"],
	quality = 4,
	icon = "inv_helmet_58",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[39629] = {
	name = L["Heroes' Redemption Tunic"],
	quality = 4,
	icon = "inv_chest_plate02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[39630] = {
	name = L["Heroes' Redemption Greaves"],
	quality = 4,
	icon = "inv_pants_plate_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[39631] = {
	name = L["Heroes' Redemption Spaulders"],
	quality = 4,
	icon = "inv_shoulder_29",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[39632] = {
	name = L["Heroes' Redemption Gloves"],
	quality = 4,
	icon = "inv_gauntlets_28",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[39633] = {
	name = L["Heroes' Redemption Chestpiece"],
	quality = 4,
	icon = "inv_chest_plate02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[39634] = {
	name = L["Heroes' Redemption Gauntlets"],
	quality = 4,
	icon = "inv_gauntlets_28",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[39635] = {
	name = L["Heroes' Redemption Helm"],
	quality = 4,
	icon = "inv_helmet_58",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[39636] = {
	name = L["Heroes' Redemption Legplates"],
	quality = 4,
	icon = "inv_pants_plate_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[39637] = {
	name = L["Heroes' Redemption Shoulderplates"],
	quality = 4,
	icon = "inv_shoulder_29",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[39638] = {
	name = L["Heroes' Redemption Breastplate"],
	quality = 4,
	icon = "inv_chest_plate02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[39639] = {
	name = L["Heroes' Redemption Handguards"],
	quality = 4,
	icon = "inv_gauntlets_28",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[39640] = {
	name = L["Heroes' Redemption Faceguard"],
	quality = 4,
	icon = "inv_helmet_58",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[39641] = {
	name = L["Heroes' Redemption Legguards"],
	quality = 4,
	icon = "inv_pants_plate_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[39642] = {
	name = L["Heroes' Redemption Shoulderguards"],
	quality = 4,
	icon = "inv_shoulder_29",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40525] = {
	name = L["Valorous Dreadnaught Battleplate"],
	quality = 4,
	icon = "inv_chest_plate02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40527] = {
	name = L["Valorous Dreadnaught Gauntlets"],
	quality = 4,
	icon = "inv_gauntlets_28",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40528] = {
	name = L["Valorous Dreadnaught Helmet"],
	quality = 4,
	icon = "inv_helmet_58",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40529] = {
	name = L["Valorous Dreadnaught Legplates"],
	quality = 4,
	icon = "inv_pants_plate_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40530] = {
	name = L["Valorous Dreadnaught Shoulderplates"],
	quality = 4,
	icon = "inv_shoulder_29",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40544] = {
	name = L["Valorous Dreadnaught Breastplate"],
	quality = 4,
	icon = "inv_chest_plate02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40545] = {
	name = L["Valorous Dreadnaught Handguards"],
	quality = 4,
	icon = "inv_gauntlets_28",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40546] = {
	name = L["Valorous Dreadnaught Greathelm"],
	quality = 4,
	icon = "inv_helmet_58",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40547] = {
	name = L["Valorous Dreadnaught Legguards"],
	quality = 4,
	icon = "inv_pants_plate_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40548] = {
	name = L["Valorous Dreadnaught Pauldrons"],
	quality = 4,
	icon = "inv_shoulder_29",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40550] = {
	name = L["Valorous Scourgeborne Battleplate"],
	quality = 4,
	icon = "inv_chest_plate02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40552] = {
	name = L["Valorous Scourgeborne Gauntlets"],
	quality = 4,
	icon = "inv_gauntlets_28",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40554] = {
	name = L["Valorous Scourgeborne Helmet"],
	quality = 4,
	icon = "inv_helmet_58",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40556] = {
	name = L["Valorous Scourgeborne Legplates"],
	quality = 4,
	icon = "inv_pants_plate_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40557] = {
	name = L["Valorous Scourgeborne Shoulderplates"],
	quality = 4,
	icon = "inv_shoulder_29",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40559] = {
	name = L["Valorous Scourgeborne Chestguard"],
	quality = 4,
	icon = "inv_chest_plate02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40563] = {
	name = L["Valorous Scourgeborne Handguards"],
	quality = 4,
	icon = "inv_gauntlets_28",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40565] = {
	name = L["Valorous Scourgeborne Faceguard"],
	quality = 4,
	icon = "inv_helmet_58",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40567] = {
	name = L["Valorous Scourgeborne Legguards"],
	quality = 4,
	icon = "inv_pants_plate_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40568] = {
	name = L["Valorous Scourgeborne Pauldrons"],
	quality = 4,
	icon = "inv_shoulder_29",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40569] = {
	name = L["Valorous Redemption Tunic"],
	quality = 4,
	icon = "inv_chest_plate02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40570] = {
	name = L["Valorous Redemption Gloves"],
	quality = 4,
	icon = "inv_gauntlets_28",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40571] = {
	name = L["Valorous Redemption Headpiece"],
	quality = 4,
	icon = "inv_helmet_58",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40572] = {
	name = L["Valorous Redemption Greaves"],
	quality = 4,
	icon = "inv_pants_plate_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40573] = {
	name = L["Valorous Redemption Spaulders"],
	quality = 4,
	icon = "inv_shoulder_29",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40574] = {
	name = L["Valorous Redemption Chestpiece"],
	quality = 4,
	icon = "inv_chest_plate02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40575] = {
	name = L["Valorous Redemption Gauntlets"],
	quality = 4,
	icon = "inv_gauntlets_28",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40576] = {
	name = L["Valorous Redemption Helm"],
	quality = 4,
	icon = "inv_helmet_58",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40577] = {
	name = L["Valorous Redemption Legplates"],
	quality = 4,
	icon = "inv_pants_plate_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40578] = {
	name = L["Valorous Redemption Shoulderplates"],
	quality = 4,
	icon = "inv_shoulder_29",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40579] = {
	name = L["Valorous Redemption Breastplate"],
	quality = 4,
	icon = "inv_chest_plate02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40580] = {
	name = L["Valorous Redemption Handguards"],
	quality = 4,
	icon = "inv_gauntlets_28",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40581] = {
	name = L["Valorous Redemption Faceguard"],
	quality = 4,
	icon = "inv_helmet_58",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40583] = {
	name = L["Valorous Redemption Legguards"],
	quality = 4,
	icon = "inv_pants_plate_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40584] = {
	name = L["Valorous Redemption Shoulderguards"],
	quality = 4,
	icon = "inv_shoulder_29",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40688] = {
	name = L["Verdungo's Barbarian Cord"],
	quality = 4,
	icon = "inv_belt_13",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40689] = {
	name = L["Waistguard of Living Iron"],
	quality = 4,
	icon = "inv_belt_29",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40691] = {
	name = L["Magroth's Meditative Cincture"],
	quality = 4,
	icon = "inv_belt_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40733] = {
	name = L["Wristbands of the Sentinel Huntress"],
	quality = 4,
	icon = "inv_bracer_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40734] = {
	name = L["Bracers of Dalaran's Parapets"],
	quality = 4,
	icon = "inv_bracer_14",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40735] = {
	name = L["Zartson's Jungle Vambraces"],
	quality = 4,
	icon = "inv_bracer_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40742] = {
	name = L["Bladed Steelboots"],
	quality = 4,
	icon = "inv_boots_plate_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40743] = {
	name = L["Kyzoc's Ground Stompers"],
	quality = 4,
	icon = "inv_boots_plate_08",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40745] = {
	name = L["Sabatons of Rapid Recovery"],
	quality = 4,
	icon = "inv_boots_plate_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[44435] = {
	name = L["Windle's Lighter"],
	quality = 2,
	icon = "inv_wand_02",
	buyPrice = 5000,
	sellPrice = 1250,
	reqLevel = 0,
}
t[44635] = {
	name = L["Dalaran Rifle"],
	quality = 1,
	icon = "inv_weapon_rifle_03",
	buyPrice = 115886,
	sellPrice = 23177,
	reqLevel = 70,
}
t[34498] = {
	name = L["Paper Zeppelin Kit"],
	quality = 1,
	icon = "inv_misc_toy_05",
	buyPrice = 50000,
	sellPrice = 12500,
	reqLevel = 0,
}
t[44481] = {
	name = L["Grindgear Toy Gorilla"],
	quality = 1,
	icon = "inv_cask_03",
	buyPrice = 4500,
	sellPrice = 1125,
	reqLevel = 0,
}
t[44482] = {
	name = L["Trusty Copper Racer"],
	quality = 2,
	icon = "inv_gizmo_02",
	buyPrice = 3000,
	sellPrice = 750,
	reqLevel = 0,
}
t[44599] = {
	name = L["Zippy Copper Racer"],
	quality = 2,
	icon = "inv_gizmo_01",
	buyPrice = 3000,
	sellPrice = 750,
	reqLevel = 0,
}
t[44601] = {
	name = L["Heavy Copper Racer"],
	quality = 2,
	icon = "inv_gizmo_04",
	buyPrice = 3000,
	sellPrice = 750,
	reqLevel = 0,
}
t[44606] = {
	name = L["Toy Train Set"],
	quality = 3,
	icon = "inv_misc_toy_10",
	buyPrice = 2500000,
	sellPrice = 625000,
	reqLevel = 0,
}
t[45057] = {
	name = L["Wind-Up Train Wrecker"],
	quality = 3,
	icon = "inv_misc_head_clockworkgnome_01",
	buyPrice = 2500000,
	sellPrice = 625000,
	reqLevel = 0,
}
t[54343] = {
	name = L["Blue Crashin' Thrashin' Racer Controller"],
	quality = 2,
	icon = "inv_gizmo_goblingtonkcontroller",
	buyPrice = 400000,
	sellPrice = 100000,
	reqLevel = 0,
}
t[54436] = {
	name = L["Blue Clockwork Rocket Bot"],
	quality = 3,
	icon = "inv_gizmo_06",
	buyPrice = 500000,
	sellPrice = 125000,
	reqLevel = 0,
}
t[54437] = {
	name = L["Tiny Green Ragdoll"],
	quality = 2,
	icon = "inv_misc_toy_03",
	buyPrice = 100000,
	sellPrice = 25000,
	reqLevel = 0,
}
t[54438] = {
	name = L["Tiny Blue Ragdoll"],
	quality = 2,
	icon = "inv_misc_toy_02",
	buyPrice = 100000,
	sellPrice = 25000,
	reqLevel = 0,
}
t[42360] = {
	name = L["Ebon Filigreed Doublet"],
	quality = 1,
	icon = "inv_shirt_black_01",
	buyPrice = 550000,
	sellPrice = 137500,
	reqLevel = 0,
}
t[42361] = {
	name = L["Cerulean Filigreed Doublet"],
	quality = 1,
	icon = "inv_shirt_blue_01",
	buyPrice = 475000,
	sellPrice = 118750,
	reqLevel = 0,
}
t[42363] = {
	name = L["Golden Filigreed Doublet"],
	quality = 1,
	icon = "inv_shirt_yellow_01",
	buyPrice = 525000,
	sellPrice = 131250,
	reqLevel = 0,
}
t[42365] = {
	name = L["Amber Filigreed Doublet"],
	quality = 1,
	icon = "inv_shirt_orange_01",
	buyPrice = 450000,
	sellPrice = 112500,
	reqLevel = 0,
}
t[42368] = {
	name = L["Scarlet Filigreed Doublet"],
	quality = 1,
	icon = "inv_shirt_red_01",
	buyPrice = 500000,
	sellPrice = 125000,
	reqLevel = 0,
}
t[42369] = {
	name = L["Ebon Filigreed Shirt"],
	quality = 1,
	icon = "inv_shirt_black_01",
	buyPrice = 350000,
	sellPrice = 87500,
	reqLevel = 0,
}
t[42370] = {
	name = L["Cerulean Filigreed Shirt"],
	quality = 1,
	icon = "inv_shirt_blue_01",
	buyPrice = 275000,
	sellPrice = 68750,
	reqLevel = 0,
}
t[42371] = {
	name = L["Amber Filigreed Shirt"],
	quality = 1,
	icon = "inv_shirt_orange_01",
	buyPrice = 250000,
	sellPrice = 62500,
	reqLevel = 0,
}
t[42372] = {
	name = L["Scarlet Filigreed Shirt"],
	quality = 1,
	icon = "inv_shirt_red_01",
	buyPrice = 300000,
	sellPrice = 75000,
	reqLevel = 0,
}
t[42373] = {
	name = L["Golden Filigreed Shirt"],
	quality = 1,
	icon = "inv_shirt_yellow_01",
	buyPrice = 325000,
	sellPrice = 81250,
	reqLevel = 0,
}
t[42374] = {
	name = L["Blue Martial Shirt"],
	quality = 1,
	icon = "inv_shirt_blue_01",
	buyPrice = 375000,
	sellPrice = 93750,
	reqLevel = 0,
}
t[42375] = {
	name = L["Green Martial Shirt"],
	quality = 1,
	icon = "inv_shirt_green_01",
	buyPrice = 350000,
	sellPrice = 87500,
	reqLevel = 0,
}
t[42376] = {
	name = L["Yellow Martial Shirt"],
	quality = 1,
	icon = "inv_shirt_yellow_01",
	buyPrice = 425000,
	sellPrice = 106250,
	reqLevel = 0,
}
t[42377] = {
	name = L["Purple Martial Shirt"],
	quality = 1,
	icon = "inv_shirt_purple_01",
	buyPrice = 450000,
	sellPrice = 112500,
	reqLevel = 0,
}
t[42378] = {
	name = L["Red Martial Shirt"],
	quality = 1,
	icon = "inv_shirt_red_01",
	buyPrice = 400000,
	sellPrice = 100000,
	reqLevel = 0,
}
t[40716] = {
	name = L["Lillehoff's Winged Blades"],
	quality = 4,
	icon = "inv_throwingknife_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[44644] = {
	name = L["Dalaran Dart"],
	quality = 1,
	icon = "inv_throwingknife_03",
	buyPrice = 119394,
	sellPrice = 29848,
	reqLevel = 70,
}
t[47659] = {
	name = L["Crimson Star"],
	quality = 4,
	icon = "inv_throwingknife_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[47660] = {
	name = L["Blades of the Sable Cross"],
	quality = 4,
	icon = "inv_throwingaxepvp320_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[50474] = {
	name = L["Shrapnel Star"],
	quality = 4,
	icon = "inv_throwingknife_07",
	buyPrice = 0,
	sellPrice = 82022,
	reqLevel = 80,
}
t[44655] = {
	name = L["Dalaran Stave"],
	quality = 1,
	icon = "inv_staff_07",
	buyPrice = 193123,
	sellPrice = 38624,
	reqLevel = 70,
}
t[40721] = {
	name = L["Hammerhead Sharkskin Cloak"],
	quality = 4,
	icon = "inv_misc_cape_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40722] = {
	name = L["Platinum Mesh Cloak"],
	quality = 4,
	icon = "inv_misc_cape_20",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40723] = {
	name = L["Disguise of the Kumiho"],
	quality = 4,
	icon = "inv_misc_cape_18",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40724] = {
	name = L["Cloak of Kea Feathers"],
	quality = 4,
	icon = "inv_misc_cape_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[50466] = {
	name = L["Sentinel's Winter Cloak"],
	quality = 4,
	icon = "inv_misc_cape_13",
	buyPrice = 0,
	sellPrice = 73013,
	reqLevel = 80,
}
t[50467] = {
	name = L["Might of the Ocean Serpent"],
	quality = 4,
	icon = "inv_misc_cape_17",
	buyPrice = 0,
	sellPrice = 73296,
	reqLevel = 80,
}
t[50468] = {
	name = L["Drape of the Violet Tower"],
	quality = 4,
	icon = "inv_misc_cape_16",
	buyPrice = 0,
	sellPrice = 73580,
	reqLevel = 80,
}
t[50469] = {
	name = L["Volde's Cloak of the Night Sky"],
	quality = 4,
	icon = "inv_misc_cape_16",
	buyPrice = 0,
	sellPrice = 75894,
	reqLevel = 80,
}
t[50470] = {
	name = L["Recovered Scarlet Onslaught Cape"],
	quality = 4,
	icon = "inv_misc_cape_14",
	buyPrice = 0,
	sellPrice = 76170,
	reqLevel = 80,
}
t[44640] = {
	name = L["Dalaran Great Axe"],
	quality = 1,
	icon = "inv_axe_44",
	buyPrice = 196803,
	sellPrice = 39360,
	reqLevel = 70,
}
t[44642] = {
	name = L["Dalaran Axe"],
	quality = 1,
	icon = "inv_axe_30",
	buyPrice = 158604,
	sellPrice = 31720,
	reqLevel = 70,
}
t[44654] = {
	name = L["Dalaran Spear"],
	quality = 1,
	icon = "inv_spear_06",
	buyPrice = 192387,
	sellPrice = 38477,
	reqLevel = 70,
}
t[44636] = {
	name = L["Dalaran Cudgel"],
	quality = 1,
	icon = "inv_mace_35",
	buyPrice = 155103,
	sellPrice = 31020,
	reqLevel = 70,
}
t[44645] = {
	name = L["Dalaran Hammer"],
	quality = 1,
	icon = "inv_mace_31",
	buyPrice = 200443,
	sellPrice = 40088,
	reqLevel = 70,
}
t[40702] = {
	name = L["Rolfsen's Ripper"],
	quality = 4,
	icon = "inv_weapon_shortblade_88",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40704] = {
	name = L["Pride"],
	quality = 4,
	icon = "inv_weapon_hand_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[44641] = {
	name = L["Dalaran Knuckles"],
	quality = 1,
	icon = "inv_gauntlets_11",
	buyPrice = 158015,
	sellPrice = 31603,
	reqLevel = 70,
}
t[44652] = {
	name = L["Dalaran Dagger"],
	quality = 1,
	icon = "inv_weapon_shortblade_05",
	buyPrice = 152732,
	sellPrice = 30546,
	reqLevel = 70,
}
t[39578] = {
	name = L["Heroes' Cryptstalker Headpiece"],
	quality = 4,
	icon = "inv_helmet_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[39579] = {
	name = L["Heroes' Cryptstalker Tunic"],
	quality = 4,
	icon = "inv_chest_chain_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[39580] = {
	name = L["Heroes' Cryptstalker Legguards"],
	quality = 4,
	icon = "inv_pants_mail_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[39581] = {
	name = L["Heroes' Cryptstalker Spaulders"],
	quality = 4,
	icon = "inv_shoulder_14",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[39582] = {
	name = L["Heroes' Cryptstalker Handguards"],
	quality = 4,
	icon = "inv_gauntlets_25",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[39583] = {
	name = L["Heroes' Earthshatter Headpiece"],
	quality = 4,
	icon = "inv_helmet_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[39588] = {
	name = L["Heroes' Earthshatter Tunic"],
	quality = 4,
	icon = "inv_chest_chain_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[39589] = {
	name = L["Heroes' Earthshatter Legguards"],
	quality = 4,
	icon = "inv_pants_mail_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[39590] = {
	name = L["Heroes' Earthshatter Spaulders"],
	quality = 4,
	icon = "inv_shoulder_14",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[39591] = {
	name = L["Heroes' Earthshatter Handguards"],
	quality = 4,
	icon = "inv_gauntlets_25",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[39592] = {
	name = L["Heroes' Earthshatter Hauberk"],
	quality = 4,
	icon = "inv_chest_chain_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[39593] = {
	name = L["Heroes' Earthshatter Gloves"],
	quality = 4,
	icon = "inv_gauntlets_25",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[39594] = {
	name = L["Heroes' Earthshatter Helm"],
	quality = 4,
	icon = "inv_helmet_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[39595] = {
	name = L["Heroes' Earthshatter Kilt"],
	quality = 4,
	icon = "inv_pants_mail_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[39596] = {
	name = L["Heroes' Earthshatter Shoulderpads"],
	quality = 4,
	icon = "inv_shoulder_14",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[39597] = {
	name = L["Heroes' Earthshatter Chestguard"],
	quality = 4,
	icon = "inv_chest_chain_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[39601] = {
	name = L["Heroes' Earthshatter Grips"],
	quality = 4,
	icon = "inv_gauntlets_25",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[39602] = {
	name = L["Heroes' Earthshatter Faceguard"],
	quality = 4,
	icon = "inv_helmet_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[39603] = {
	name = L["Heroes' Earthshatter War-Kilt"],
	quality = 4,
	icon = "inv_pants_mail_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[39604] = {
	name = L["Heroes' Earthshatter Shoulderguards"],
	quality = 4,
	icon = "inv_shoulder_14",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40503] = {
	name = L["Valorous Cryptstalker Tunic"],
	quality = 4,
	icon = "inv_chest_chain_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40504] = {
	name = L["Valorous Cryptstalker Handguards"],
	quality = 4,
	icon = "inv_gauntlets_25",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40505] = {
	name = L["Valorous Cryptstalker Headpiece"],
	quality = 4,
	icon = "inv_helmet_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40506] = {
	name = L["Valorous Cryptstalker Legguards"],
	quality = 4,
	icon = "inv_pants_mail_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40507] = {
	name = L["Valorous Cryptstalker Spaulders"],
	quality = 4,
	icon = "inv_shoulder_14",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40508] = {
	name = L["Valorous Earthshatter Tunic"],
	quality = 4,
	icon = "inv_chest_chain_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40509] = {
	name = L["Valorous Earthshatter Handguards"],
	quality = 4,
	icon = "inv_gauntlets_25",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40510] = {
	name = L["Valorous Earthshatter Headpiece"],
	quality = 4,
	icon = "inv_helmet_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40512] = {
	name = L["Valorous Earthshatter Legguards"],
	quality = 4,
	icon = "inv_pants_mail_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40513] = {
	name = L["Valorous Earthshatter Spaulders"],
	quality = 4,
	icon = "inv_shoulder_14",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40514] = {
	name = L["Valorous Earthshatter Hauberk"],
	quality = 4,
	icon = "inv_chest_chain_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40515] = {
	name = L["Valorous Earthshatter Gloves"],
	quality = 4,
	icon = "inv_gauntlets_25",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40516] = {
	name = L["Valorous Earthshatter Helm"],
	quality = 4,
	icon = "inv_helmet_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40517] = {
	name = L["Valorous Earthshatter Kilt"],
	quality = 4,
	icon = "inv_pants_mail_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40518] = {
	name = L["Valorous Earthshatter Shoulderpads"],
	quality = 4,
	icon = "inv_shoulder_14",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40520] = {
	name = L["Valorous Earthshatter Grips"],
	quality = 4,
	icon = "inv_gauntlets_25",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40521] = {
	name = L["Valorous Earthshatter Faceguard"],
	quality = 4,
	icon = "inv_helmet_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40522] = {
	name = L["Valorous Earthshatter War-Kilt"],
	quality = 4,
	icon = "inv_pants_mail_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40523] = {
	name = L["Valorous Earthshatter Chestguard"],
	quality = 4,
	icon = "inv_chest_chain_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40524] = {
	name = L["Valorous Earthshatter Shoulderguards"],
	quality = 4,
	icon = "inv_shoulder_14",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40692] = {
	name = L["Vereesa's Silver Chain Belt"],
	quality = 4,
	icon = "inv_belt_18",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40693] = {
	name = L["Beadwork Belt of Shamanic Vision"],
	quality = 4,
	icon = "inv_belt_23",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40736] = {
	name = L["Armguard of the Tower Archer"],
	quality = 4,
	icon = "inv_bracer_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40737] = {
	name = L["Pigmented Clan Bindings"],
	quality = 4,
	icon = "inv_bracer_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40746] = {
	name = L["Pack-Ice Striders"],
	quality = 4,
	icon = "inv_boots_chain_03",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40747] = {
	name = L["Treads of Coastal Wandering"],
	quality = 4,
	icon = "inv_boots_chain_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40698] = {
	name = L["Ward of the Violet Citadel"],
	quality = 4,
	icon = "inv_offhand_dalaran_d_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40699] = {
	name = L["Handbook of Obscure Remedies"],
	quality = 4,
	icon = "inv_misc_book_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40682] = {
	name = L["Sundial of the Exiled"],
	quality = 4,
	icon = "ability_hunter_readiness",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40683] = {
	name = L["Valor Medal of the First War"],
	quality = 4,
	icon = "inv_qirajidol_sun",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40684] = {
	name = L["Mirror of Truth"],
	quality = 4,
	icon = "inv_jewelry_talisman_08",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40685] = {
	name = L["The Egg of Mortal Essence"],
	quality = 4,
	icon = "inv_egg_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[47734] = {
	name = L["Mark of Supremacy"],
	quality = 4,
	icon = "inv_misc_gem_bloodstone_03",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[47735] = {
	name = L["Glyph of Indomitability"],
	quality = 4,
	icon = "inv_spiritshard_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[48722] = {
	name = L["Shard of the Crystal Heart"],
	quality = 4,
	icon = "inv_spiritshard_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[48724] = {
	name = L["Talisman of Resurgence"],
	quality = 4,
	icon = "inv_misc_gem_bloodstone_03",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[50355] = {
	name = L["Herkuml War Token"],
	quality = 4,
	icon = "inv_misc_rune_12",
	buyPrice = 0,
	sellPrice = 113940,
	reqLevel = 80,
}
t[50356] = {
	name = L["Corroded Skeleton Key"],
	quality = 4,
	icon = "inv_misc_key_15",
	buyPrice = 0,
	sellPrice = 113940,
	reqLevel = 80,
}
t[50357] = {
	name = L["Maghia's Misguided Quill"],
	quality = 4,
	icon = "inv_jewelry_trinket_02",
	buyPrice = 0,
	sellPrice = 113940,
	reqLevel = 80,
}
t[50358] = {
	name = L["Purified Lunar Dust"],
	quality = 4,
	icon = "inv_misc_ammo_gunpowder_05",
	buyPrice = 0,
	sellPrice = 113940,
	reqLevel = 80,
}
t[39728] = {
	name = L["Totem of Misery"],
	quality = 4,
	icon = "spell_nature_slowingtotem",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[39757] = {
	name = L["Idol of Worship"],
	quality = 4,
	icon = "inv_qirajidol_strife",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40191] = {
	name = L["Libram of Radiance"],
	quality = 4,
	icon = "inv_relics_libramofhope",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40207] = {
	name = L["Sigil of Awareness"],
	quality = 4,
	icon = "inv_shield_56",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40267] = {
	name = L["Totem of Hex"],
	quality = 4,
	icon = "spell_nature_diseasecleansingtotem",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40268] = {
	name = L["Libram of Tolerance"],
	quality = 4,
	icon = "inv_relics_libramoftruth",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40321] = {
	name = L["Idol of the Shooting Star"],
	quality = 4,
	icon = "inv_relics_idolofrejuvenation",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40322] = {
	name = L["Totem of Dueling"],
	quality = 4,
	icon = "spell_nature_groundingtotem",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40337] = {
	name = L["Libram of Resurgence"],
	quality = 4,
	icon = "inv_relics_libramofhope",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40342] = {
	name = L["Idol of Awakening"],
	quality = 4,
	icon = "inv_misc_thegoldencheep",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[47661] = {
	name = L["Libram of Valiance"],
	quality = 4,
	icon = "inv_relics_libramofhope",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[47662] = {
	name = L["Libram of Veracity"],
	quality = 4,
	icon = "inv_relics_libramoftruth",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[47664] = {
	name = L["Libram of Defiance"],
	quality = 4,
	icon = "inv_relics_libramofhope",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[47665] = {
	name = L["Totem of Calming Tides"],
	quality = 4,
	icon = "spell_nature_slowingtotem",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[47666] = {
	name = L["Totem of Electrifying Wind"],
	quality = 4,
	icon = "spell_nature_diseasecleansingtotem",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[47667] = {
	name = L["Totem of Quaking Earth"],
	quality = 4,
	icon = "spell_nature_earthelemental_totem",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[47668] = {
	name = L["Idol of Mutilation"],
	quality = 4,
	icon = "inv_qirajidol_strife",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[47670] = {
	name = L["Idol of Lunar Fury"],
	quality = 4,
	icon = "inv_relics_idolofrejuvenation",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[47671] = {
	name = L["Idol of Flaring Growth"],
	quality = 4,
	icon = "inv_relics_idolofrejuvenation",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[47672] = {
	name = L["Sigil of Insolence"],
	quality = 4,
	icon = "inv_shield_56",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[47673] = {
	name = L["Sigil of Virulence"],
	quality = 4,
	icon = "inv_shield_56",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[50454] = {
	name = L["Idol of the Black Willow"],
	quality = 4,
	icon = "trade_herbalism",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[50455] = {
	name = L["Libram of Three Truths"],
	quality = 4,
	icon = "inv_scroll_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[50456] = {
	name = L["Idol of the Crying Moon"],
	quality = 4,
	icon = "spell_nature_natureguardian",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[50457] = {
	name = L["Idol of the Lunar Eclipse"],
	quality = 4,
	icon = "inv_offhand_1h_ulduarraid_d_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[50458] = {
	name = L["Bizuri's Totem of Shattered Ice"],
	quality = 4,
	icon = "spell_frost_frostnova",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[50459] = {
	name = L["Sigil of the Hanged Man"],
	quality = 4,
	icon = "inv_misc_noose_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[50460] = {
	name = L["Libram of Blinding Light"],
	quality = 4,
	icon = "spell_holy_blessedresillience",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[50461] = {
	name = L["Libram of the Eternal Tower"],
	quality = 4,
	icon = "inv_offhand_ulduarraid_d_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[50462] = {
	name = L["Sigil of the Bone Gryphon"],
	quality = 4,
	icon = "ability_mount_ebonblade",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[50463] = {
	name = L["Totem of the Avalanche"],
	quality = 4,
	icon = "inv_misc_gem_diamond_03",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[50464] = {
	name = L["Totem of the Surging Sea"],
	quality = 4,
	icon = "spell_frost_summonwaterelemental",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[39973] = {
	name = L["Ghostly Skull"],
	quality = 3,
	icon = "inv_misc_bone_humanskull_01",
	buyPrice = 400000,
	sellPrice = 100000,
	reqLevel = 0,
}
t[43086] = {
	name = L["Fresh Apple Juice"],
	quality = 1,
	icon = "inv_drink_04",
	buyPrice = 8500,
	sellPrice = 425,
	reqLevel = 70,
}
t[43088] = {
	name = L["Dalaran Apple Bowl"],
	quality = 1,
	icon = "inv_misc_bowl_01",
	buyPrice = 40000,
	sellPrice = 8000,
	reqLevel = 75,
}
t[42428] = {
	name = L["Carrot Cupcake"],
	quality = 1,
	icon = "inv_misc_food_149_cupcake",
	buyPrice = 8500,
	sellPrice = 425,
	reqLevel = 70,
}
t[42429] = {
	name = L["Red Velvet Cupcake"],
	quality = 1,
	icon = "inv_misc_food_148_cupcake",
	buyPrice = 16000,
	sellPrice = 800,
	reqLevel = 75,
}
t[42430] = {
	name = L["Dalaran Doughnut"],
	quality = 1,
	icon = "inv_misc_food_153_doughnut",
	buyPrice = 8500,
	sellPrice = 425,
	reqLevel = 70,
}
t[42431] = {
	name = L["Dalaran Brownie"],
	quality = 1,
	icon = "inv_holiday_tow_spicebrownie",
	buyPrice = 16000,
	sellPrice = 800,
	reqLevel = 75,
}
t[42436] = {
	name = L["Chocolate Celebration Cake"],
	quality = 1,
	icon = "inv_misc_food_147_cake",
	buyPrice = 90000,
	sellPrice = 2125,
	reqLevel = 70,
}
t[42438] = {
	name = L["Lovely Cake"],
	quality = 1,
	icon = "inv_misc_food_145_cake",
	buyPrice = 180000,
	sellPrice = 4000,
	reqLevel = 75,
}
t[42439] = {
	name = L["Big Berry Pie"],
	quality = 1,
	icon = "inv_misc_food_10",
	buyPrice = 17000,
	sellPrice = 4250,
	reqLevel = 70,
}
t[44692] = {
	name = L["Dalaran Nurse's Gown"],
	quality = 1,
	icon = "inv_chest_cloth_12",
	buyPrice = 749998,
	sellPrice = 149999,
	reqLevel = 0,
}
t[44693] = {
	name = L["Wound Dressing"],
	quality = 1,
	icon = "inv_misc_bandage_17",
	buyPrice = 200000,
	sellPrice = 50000,
	reqLevel = 0,
}
t[44694] = {
	name = L["Antiseptic-Soaked Dressing"],
	quality = 1,
	icon = "inv_misc_bandage_08",
	buyPrice = 250000,
	sellPrice = 62500,
	reqLevel = 0,
}
t[44698] = {
	name = L["Intravenous Healing Potion"],
	quality = 1,
	icon = "spell_holy_sealofsacrifice",
	buyPrice = 27000,
	sellPrice = 6750,
	reqLevel = 75,
}
t[44647] = {
	name = L["Violet Hat"],
	quality = 1,
	icon = "inv_helmet_27",
	buyPrice = 550001,
	sellPrice = 110000,
	reqLevel = 0,
}
t[44648] = {
	name = L["Purple Turban"],
	quality = 1,
	icon = "inv_helmet_62",
	buyPrice = 999999,
	sellPrice = 199999,
	reqLevel = 0,
}
t[44610] = {
	name = L["Fresh Dalaran Bread"],
	quality = 1,
	icon = "inv_misc_food_12",
	buyPrice = 85000,
	sellPrice = 425,
	reqLevel = 65,
}
t[44612] = {
	name = L["Dalaran Swiss Wheel"],
	quality = 1,
	icon = "inv_misc_food_03",
	buyPrice = 85000,
	sellPrice = 2125,
	reqLevel = 65,
}
t[44613] = {
	name = L["Aged Dalaran Sharp Wheel"],
	quality = 1,
	icon = "inv_misc_food_94_garadarsharp-",
	buyPrice = 160000,
	sellPrice = 4000,
	reqLevel = 75,
}
t[44616] = {
	name = L["Glass of Dalaran White"],
	quality = 1,
	icon = "inv_drink_22",
	buyPrice = 1500,
	sellPrice = 375,
	reqLevel = 0,
}
t[44617] = {
	name = L["Glass of Dalaran Red"],
	quality = 1,
	icon = "inv_drink_02",
	buyPrice = 2000,
	sellPrice = 500,
	reqLevel = 1,
}
t[44618] = {
	name = L["Glass of Aged Dalaran Red"],
	quality = 2,
	icon = "inv_drink_02",
	buyPrice = 10000,
	sellPrice = 500,
	reqLevel = 0,
}
t[43236] = {
	name = L["Star's Sorrow"],
	quality = 1,
	icon = "inv_drink_waterskin_01",
	buyPrice = 10000,
	sellPrice = 125,
	reqLevel = 75,
}
t[43007] = {
	name = L["Northern Spices"],
	quality = 1,
	icon = "inv_misc_ammo_gunpowder_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[43017] = {
	name = L["Recipe: Fish Feast"],
	quality = 2,
	icon = "inv_scroll_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Fish Feast"],
	learnedAt = 450,
}
t[43018] = {
	name = L["Recipe: Mega Mammoth Meal"],
	quality = 2,
	icon = "inv_scroll_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Mega Mammoth Meal"],
	learnedAt = 400,
}
t[43019] = {
	name = L["Recipe: Tender Shoveltusk Steak"],
	quality = 2,
	icon = "inv_scroll_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Tender Shoveltusk Steak"],
	learnedAt = 400,
}
t[43020] = {
	name = L["Recipe: Spiced Worm Burger"],
	quality = 2,
	icon = "inv_scroll_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Spiced Worm Burger"],
	learnedAt = 400,
}
t[43021] = {
	name = L["Recipe: Very Burnt Worg"],
	quality = 2,
	icon = "inv_scroll_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Very Burnt Worg"],
	learnedAt = 400,
}
t[43022] = {
	name = L["Recipe: Mighty Rhino Dogs"],
	quality = 2,
	icon = "inv_scroll_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Mighty Rhino Dogs"],
	learnedAt = 400,
}
t[43023] = {
	name = L["Recipe: Poached Northern Sculpin"],
	quality = 2,
	icon = "inv_scroll_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Poached Northern Sculpin"],
	learnedAt = 400,
}
t[43024] = {
	name = L["Recipe: Firecracker Salmon"],
	quality = 2,
	icon = "inv_scroll_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Firecracker Salmon"],
	learnedAt = 400,
}
t[43025] = {
	name = L["Recipe: Spicy Blue Nettlefish"],
	quality = 2,
	icon = "inv_scroll_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Spicy Blue Nettlefish"],
	learnedAt = 400,
}
t[43026] = {
	name = L["Recipe: Imperial Manta Steak"],
	quality = 2,
	icon = "inv_scroll_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Imperial Manta Steak"],
	learnedAt = 400,
}
t[43027] = {
	name = L["Recipe: Spicy Fried Herring"],
	quality = 2,
	icon = "inv_scroll_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Spicy Fried Herring"],
	learnedAt = 400,
}
t[43028] = {
	name = L["Recipe: Rhinolicious Wormsteak"],
	quality = 2,
	icon = "inv_scroll_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Rhinolicious Wormsteak"],
	learnedAt = 400,
}
t[43029] = {
	name = L["Recipe: Critter Bites"],
	quality = 2,
	icon = "inv_scroll_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Critter Bites"],
	learnedAt = 400,
}
t[43030] = {
	name = L["Recipe: Hearty Rhino"],
	quality = 2,
	icon = "inv_scroll_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Hearty Rhino"],
	learnedAt = 400,
}
t[43031] = {
	name = L["Recipe: Snapper Extreme"],
	quality = 2,
	icon = "inv_scroll_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Snapper Extreme"],
	learnedAt = 400,
}
t[43032] = {
	name = L["Recipe: Blackened Worg Steak"],
	quality = 2,
	icon = "inv_scroll_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Blackened Worg Steak"],
	learnedAt = 400,
}
t[43033] = {
	name = L["Recipe: Cuttlesteak"],
	quality = 2,
	icon = "inv_scroll_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Cuttlesteak"],
	learnedAt = 400,
}
t[43034] = {
	name = L["Recipe: Spiced Mammoth Treats"],
	quality = 2,
	icon = "inv_scroll_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Spiced Mammoth Treats"],
	learnedAt = 400,
}
t[43035] = {
	name = L["Recipe: Blackened Dragonfin"],
	quality = 2,
	icon = "inv_scroll_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Blackened Dragonfin"],
	learnedAt = 400,
}
t[43036] = {
	name = L["Recipe: Dragonfin Filet"],
	quality = 2,
	icon = "inv_scroll_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Dragonfin Filet"],
	learnedAt = 400,
}
t[43037] = {
	name = L["Recipe: Tracker Snacks"],
	quality = 2,
	icon = "inv_scroll_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Tracker Snacks"],
	learnedAt = 400,
}
t[43505] = {
	name = L["Recipe: Gigantic Feast"],
	quality = 2,
	icon = "inv_scroll_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Gigantic Feast"],
	learnedAt = 425,
}
t[43506] = {
	name = L["Recipe: Small Feast"],
	quality = 2,
	icon = "inv_scroll_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Small Feast"],
	learnedAt = 425,
}
t[44954] = {
	name = L["Recipe: Worg Tartare"],
	quality = 2,
	icon = "inv_scroll_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Worg Tartare"],
	learnedAt = 400,
}
t[46349] = {
	name = L["Chef's Hat"],
	quality = 3,
	icon = "achievement_profession_chefhat",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[49177] = {
	name = L["Tome of Cold Weather Flight"],
	quality = 7,
	icon = "inv_misc_book_11",
	buyPrice = 10000000,
	sellPrice = 0,
	reqLevel = 68,
}
t[40634] = {
	name = L["Legplates of the Lost Conqueror"],
	quality = 4,
	icon = "inv_pants_plate_17",
	buyPrice = 0,
	sellPrice = 50000,
	reqLevel = 80,
}
t[40635] = {
	name = L["Legplates of the Lost Protector"],
	quality = 4,
	icon = "inv_pants_plate_17",
	buyPrice = 0,
	sellPrice = 50000,
	reqLevel = 80,
}
t[40636] = {
	name = L["Legplates of the Lost Vanquisher"],
	quality = 4,
	icon = "inv_pants_plate_17",
	buyPrice = 0,
	sellPrice = 50000,
	reqLevel = 80,
}
t[40637] = {
	name = L["Mantle of the Lost Conqueror"],
	quality = 4,
	icon = "inv_shoulder_22",
	buyPrice = 0,
	sellPrice = 50000,
	reqLevel = 80,
}
t[40638] = {
	name = L["Mantle of the Lost Protector"],
	quality = 4,
	icon = "inv_shoulder_22",
	buyPrice = 0,
	sellPrice = 50000,
	reqLevel = 80,
}
t[40639] = {
	name = L["Mantle of the Lost Vanquisher"],
	quality = 4,
	icon = "inv_shoulder_22",
	buyPrice = 0,
	sellPrice = 50000,
	reqLevel = 80,
}
t[40717] = {
	name = L["Ring of Invincibility"],
	quality = 4,
	icon = "inv_jewelry_ring_47",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40718] = {
	name = L["Signet of the Impregnable Fortress"],
	quality = 4,
	icon = "inv_jewelry_ring_46",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40719] = {
	name = L["Band of Channeled Magic"],
	quality = 4,
	icon = "inv_jewelry_ring_68",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40720] = {
	name = L["Renewal of Life"],
	quality = 4,
	icon = "inv_jewelry_ring_69",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40741] = {
	name = L["Cuffs of the Shadow Ascendant"],
	quality = 4,
	icon = "inv_bracer_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41944] = {
	name = L["Hateful Gladiator's Silk Cowl"],
	quality = 4,
	icon = "inv_helmet_139",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41950] = {
	name = L["Hateful Gladiator's Silk Raiment"],
	quality = 4,
	icon = "inv_chest_cloth_63",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41957] = {
	name = L["Hateful Gladiator's Silk Trousers"],
	quality = 4,
	icon = "inv_pants_cloth_28",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41963] = {
	name = L["Hateful Gladiator's Silk Amice"],
	quality = 4,
	icon = "inv_shoulder_103",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41969] = {
	name = L["Hateful Gladiator's Silk Handguards"],
	quality = 4,
	icon = "inv_gauntlets_64",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40610] = {
	name = L["Chestguard of the Lost Conqueror"],
	quality = 4,
	icon = "inv_chest_chain_03",
	buyPrice = 0,
	sellPrice = 50000,
	reqLevel = 80,
}
t[40611] = {
	name = L["Chestguard of the Lost Protector"],
	quality = 4,
	icon = "inv_chest_chain_03",
	buyPrice = 0,
	sellPrice = 50000,
	reqLevel = 80,
}
t[40612] = {
	name = L["Chestguard of the Lost Vanquisher"],
	quality = 4,
	icon = "inv_chest_chain_03",
	buyPrice = 0,
	sellPrice = 50000,
	reqLevel = 80,
}
t[40613] = {
	name = L["Gloves of the Lost Conqueror"],
	quality = 4,
	icon = "inv_gauntlets_27",
	buyPrice = 0,
	sellPrice = 50000,
	reqLevel = 80,
}
t[40614] = {
	name = L["Gloves of the Lost Protector"],
	quality = 4,
	icon = "inv_gauntlets_27",
	buyPrice = 0,
	sellPrice = 50000,
	reqLevel = 80,
}
t[40615] = {
	name = L["Gloves of the Lost Vanquisher"],
	quality = 4,
	icon = "inv_gauntlets_27",
	buyPrice = 0,
	sellPrice = 50000,
	reqLevel = 80,
}
t[40678] = {
	name = L["Pendant of the Outcast Hero"],
	quality = 4,
	icon = "inv_jewelry_necklace_29naxxramas",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40679] = {
	name = L["Chained Military Gorget"],
	quality = 4,
	icon = "inv_jewelry_necklace_30naxxramas",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40680] = {
	name = L["Encircling Burnished Gold Chains"],
	quality = 4,
	icon = "inv_jewelry_necklace_27naxxramas",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40681] = {
	name = L["Lattice Choker of Light"],
	quality = 4,
	icon = "inv_jewelry_necklace_28naxxramas",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40705] = {
	name = L["Libram of Renewal"],
	quality = 4,
	icon = "inv_relics_libramofgrace",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40706] = {
	name = L["Libram of Reciprocation"],
	quality = 4,
	icon = "inv_relics_libramofhope",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40707] = {
	name = L["Libram of Obstruction"],
	quality = 4,
	icon = "inv_relics_libramoftruth",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40708] = {
	name = L["Totem of the Elemental Plane"],
	quality = 4,
	icon = "spell_nature_unrelentingstorm",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40709] = {
	name = L["Totem of Forest Growth"],
	quality = 4,
	icon = "inv_relics_totemoflife",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40710] = {
	name = L["Totem of Splintering"],
	quality = 4,
	icon = "inv_relics_totemofrebirth",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40711] = {
	name = L["Idol of Lush Moss"],
	quality = 4,
	icon = "inv_relics_idolofhealth",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40712] = {
	name = L["Idol of Steadfast Renewal"],
	quality = 4,
	icon = "spell_arcane_arcane03",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40713] = {
	name = L["Idol of the Ravenous Beast"],
	quality = 4,
	icon = "inv_relics_idolofferocity",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40714] = {
	name = L["Sigil of the Unfaltering Knight"],
	quality = 4,
	icon = "inv_shield_56",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40715] = {
	name = L["Sigil of Haunted Dreams"],
	quality = 4,
	icon = "inv_shield_56",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41943] = {
	name = L["Savage Gladiator's Silk Cowl"],
	quality = 3,
	icon = "inv_helmet_139",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41949] = {
	name = L["Savage Gladiator's Silk Raiment"],
	quality = 3,
	icon = "inv_chest_cloth_63",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41956] = {
	name = L["Savage Gladiator's Silk Trousers"],
	quality = 3,
	icon = "inv_pants_cloth_28",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41962] = {
	name = L["Savage Gladiator's Silk Amice"],
	quality = 3,
	icon = "inv_shoulder_103",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41968] = {
	name = L["Savage Gladiator's Silk Handguards"],
	quality = 3,
	icon = "inv_gauntlets_64",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[43102] = {
	name = L["Frozen Orb"],
	quality = 3,
	icon = "spell_frost_frozencore",
	buyPrice = 50000,
	sellPrice = 50000,
	reqLevel = 0,
}
t[41852] = {
	name = L["Hateful Gladiator's Mooncloth Hood"],
	quality = 4,
	icon = "inv_helmet_136",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41857] = {
	name = L["Hateful Gladiator's Mooncloth Robe"],
	quality = 4,
	icon = "inv_chest_cloth_63",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41862] = {
	name = L["Hateful Gladiator's Mooncloth Leggings"],
	quality = 4,
	icon = "inv_pants_cloth_28",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41867] = {
	name = L["Hateful Gladiator's Mooncloth Mantle"],
	quality = 4,
	icon = "inv_shoulder_100",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41872] = {
	name = L["Hateful Gladiator's Mooncloth Gloves"],
	quality = 4,
	icon = "inv_gauntlets_64",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41913] = {
	name = L["Hateful Gladiator's Satin Hood"],
	quality = 4,
	icon = "inv_helmet_136",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41919] = {
	name = L["Hateful Gladiator's Satin Robe"],
	quality = 4,
	icon = "inv_chest_cloth_63",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41925] = {
	name = L["Hateful Gladiator's Satin Leggings"],
	quality = 4,
	icon = "inv_pants_cloth_28",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41931] = {
	name = L["Hateful Gladiator's Satin Mantle"],
	quality = 4,
	icon = "inv_shoulder_100",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41938] = {
	name = L["Hateful Gladiator's Satin Gloves"],
	quality = 4,
	icon = "inv_gauntlets_64",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41847] = {
	name = L["Savage Gladiator's Mooncloth Gloves"],
	quality = 3,
	icon = "inv_gauntlets_64",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41848] = {
	name = L["Savage Gladiator's Mooncloth Hood"],
	quality = 3,
	icon = "inv_helmet_136",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41849] = {
	name = L["Savage Gladiator's Mooncloth Leggings"],
	quality = 3,
	icon = "inv_pants_cloth_28",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41850] = {
	name = L["Savage Gladiator's Mooncloth Mantle"],
	quality = 3,
	icon = "inv_shoulder_100",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41851] = {
	name = L["Savage Gladiator's Mooncloth Robe"],
	quality = 3,
	icon = "inv_chest_cloth_63",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41912] = {
	name = L["Savage Gladiator's Satin Hood"],
	quality = 3,
	icon = "inv_helmet_136",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41918] = {
	name = L["Savage Gladiator's Satin Robe"],
	quality = 3,
	icon = "inv_chest_cloth_63",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41924] = {
	name = L["Savage Gladiator's Satin Leggings"],
	quality = 3,
	icon = "inv_pants_cloth_28",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41930] = {
	name = L["Savage Gladiator's Satin Mantle"],
	quality = 3,
	icon = "inv_shoulder_100",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41937] = {
	name = L["Savage Gladiator's Satin Gloves"],
	quality = 3,
	icon = "inv_gauntlets_64",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40586] = {
	name = L["Band of the Kirin Tor"],
	quality = 4,
	icon = "inv_jewelry_ring_74",
	buyPrice = 85000000,
	sellPrice = 2125,
	reqLevel = 80,
}
t[44934] = {
	name = L["Loop of the Kirin Tor"],
	quality = 4,
	icon = "inv_jewelry_ring_73",
	buyPrice = 85000000,
	sellPrice = 2125,
	reqLevel = 80,
}
t[44935] = {
	name = L["Ring of the Kirin Tor"],
	quality = 4,
	icon = "inv_jewelry_ring_74",
	buyPrice = 85000000,
	sellPrice = 2125,
	reqLevel = 80,
}
t[40585] = {
	name = L["Signet of the Kirin Tor"],
	quality = 4,
	icon = "inv_jewelry_ring_73",
	buyPrice = 85000000,
	sellPrice = 2125,
	reqLevel = 80,
}
t[45688] = {
	name = L["Inscribed Band of the Kirin Tor"],
	quality = 4,
	icon = "inv_jewelry_ring_74",
	buyPrice = 12500000,
	sellPrice = 31250,
	reqLevel = 80,
}
t[45689] = {
	name = L["Inscribed Loop of the Kirin Tor"],
	quality = 4,
	icon = "inv_jewelry_ring_73",
	buyPrice = 12500000,
	sellPrice = 31250,
	reqLevel = 80,
}
t[45690] = {
	name = L["Inscribed Ring of the Kirin Tor"],
	quality = 4,
	icon = "inv_jewelry_ring_74",
	buyPrice = 12500000,
	sellPrice = 31250,
	reqLevel = 80,
}
t[45691] = {
	name = L["Inscribed Signet of the Kirin Tor"],
	quality = 4,
	icon = "inv_jewelry_ring_73",
	buyPrice = 12500000,
	sellPrice = 31250,
	reqLevel = 80,
}
t[48957] = {
	name = L["Etched Signet of the Kirin Tor"],
	quality = 4,
	icon = "inv_jewelry_ring_73",
	buyPrice = 12500000,
	sellPrice = 31250,
	reqLevel = 80,
}
t[48956] = {
	name = L["Etched Ring of the Kirin Tor"],
	quality = 4,
	icon = "inv_jewelry_ring_74",
	buyPrice = 12500000,
	sellPrice = 31250,
	reqLevel = 80,
}
t[48955] = {
	name = L["Etched Loop of the Kirin Tor"],
	quality = 4,
	icon = "inv_jewelry_ring_73",
	buyPrice = 12500000,
	sellPrice = 31250,
	reqLevel = 80,
}
t[48954] = {
	name = L["Etched Band of the Kirin Tor"],
	quality = 4,
	icon = "inv_jewelry_ring_74",
	buyPrice = 12500000,
	sellPrice = 31250,
	reqLevel = 80,
}
t[45819] = {
	name = L["Spiked Battleguard Choker"],
	quality = 4,
	icon = "inv_jewelry_necklace_42",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[45820] = {
	name = L["Broach of the Wailing Night"],
	quality = 4,
	icon = "inv_jewelry_necklace_40",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[45821] = {
	name = L["Shard of the Crystal Forest"],
	quality = 4,
	icon = "inv_jewelry_necklace_47",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[45822] = {
	name = L["Evoker's Charm"],
	quality = 4,
	icon = "inv_jewelry_necklace_41",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[45823] = {
	name = L["Frozen Tear of Elune"],
	quality = 4,
	icon = "inv_jewelry_amulet_04",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51557] = {
	name = L["Runed Signet of the Kirin Tor"],
	quality = 4,
	icon = "inv_jewelry_ring_73",
	buyPrice = 12500000,
	sellPrice = 31250,
	reqLevel = 80,
}
t[51558] = {
	name = L["Runed Loop of the Kirin Tor"],
	quality = 4,
	icon = "inv_jewelry_ring_73",
	buyPrice = 12500000,
	sellPrice = 31250,
	reqLevel = 80,
}
t[51559] = {
	name = L["Runed Ring of the Kirin Tor"],
	quality = 4,
	icon = "inv_jewelry_ring_74",
	buyPrice = 12500000,
	sellPrice = 31250,
	reqLevel = 80,
}
t[51560] = {
	name = L["Runed Band of the Kirin Tor"],
	quality = 4,
	icon = "inv_jewelry_ring_74",
	buyPrice = 12500000,
	sellPrice = 31250,
	reqLevel = 80,
}
t[44225] = {
	name = L["Reins of the Armored Brown Bear"],
	quality = 4,
	icon = "ability_mount_polarbear_brown",
	buyPrice = 7500000,
	sellPrice = 0,
	reqLevel = 40,
}
t[44226] = {
	name = L["Reins of the Armored Brown Bear"],
	quality = 4,
	icon = "ability_mount_polarbear_brown",
	buyPrice = 7500000,
	sellPrice = 0,
	reqLevel = 40,
}
t[44230] = {
	name = L["Reins of the Wooly Mammoth"],
	quality = 4,
	icon = "ability_mount_ridingelekk_grey",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 40,
}
t[44231] = {
	name = L["Reins of the Wooly Mammoth"],
	quality = 4,
	icon = "ability_mount_ridingelekk_grey",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 40,
}
t[44234] = {
	name = L["Reins of the Traveler's Tundra Mammoth"],
	quality = 4,
	icon = "ability_mount_mammoth_brown",
	buyPrice = 200000000,
	sellPrice = 0,
	reqLevel = 40,
}
t[44235] = {
	name = L["Reins of the Traveler's Tundra Mammoth"],
	quality = 4,
	icon = "ability_mount_mammoth_brown",
	buyPrice = 200000000,
	sellPrice = 0,
	reqLevel = 40,
}
t[44689] = {
	name = L["Armored Snowy Gryphon"],
	quality = 4,
	icon = "ability_mount_gryphon_01",
	buyPrice = 20000000,
	sellPrice = 0,
	reqLevel = 70,
}
t[44690] = {
	name = L["Armored Blue Wind Rider"],
	quality = 4,
	icon = "ability_mount_swiftpurplewindrider",
	buyPrice = 20000000,
	sellPrice = 0,
	reqLevel = 70,
}
t[41718] = {
	name = L["Design: Runed Scarlet Ruby"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 40000,
	sellPrice = 10000,
	reqLevel = 0,
}
t[42188] = {
	name = L["Pattern: Sapphire Spellthread"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 50000,
	sellPrice = 12500,
	reqLevel = 0,
	profession = L["Tailoring"],
	teaches = L["Sapphire Spellthread"],
	learnedAt = 430,
}
t[43157] = {
	name = L["Tabard of the Kirin Tor"],
	quality = 1,
	icon = "inv_shirt_guildtabard_01",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 0,
}
t[44141] = {
	name = L["Arcanum of the Flame's Soul"],
	quality = 3,
	icon = "spell_fire_burnout",
	buyPrice = 1500000,
	sellPrice = 375000,
	reqLevel = 80,
}
t[44159] = {
	name = L["Arcanum of Burning Mysteries"],
	quality = 7,
	icon = "spell_fire_masterofelements",
	buyPrice = 1500000,
	sellPrice = 375000,
	reqLevel = 80,
}
t[44166] = {
	name = L["Lightblade Rivener"],
	quality = 3,
	icon = "inv_weapon_shortblade_71",
	buyPrice = 659636,
	sellPrice = 131927,
	reqLevel = 78,
}
t[44167] = {
	name = L["Shroud of Dedicated Research"],
	quality = 3,
	icon = "inv_misc_cape_06",
	buyPrice = 198636,
	sellPrice = 39727,
	reqLevel = 78,
}
t[44170] = {
	name = L["Helm of the Majestic Stag"],
	quality = 3,
	icon = "inv_helmet_104",
	buyPrice = 258000,
	sellPrice = 51600,
	reqLevel = 78,
}
t[44171] = {
	name = L["Spaulders of Grounded Lightning"],
	quality = 3,
	icon = "inv_shoulder_97",
	buyPrice = 312130,
	sellPrice = 62426,
	reqLevel = 78,
}
t[44173] = {
	name = L["Flameheart Spell Scalpel"],
	quality = 3,
	icon = "inv_sword_91",
	buyPrice = 741209,
	sellPrice = 148241,
	reqLevel = 80,
}
t[44174] = {
	name = L["Stave of Shrouded Mysteries"],
	quality = 3,
	icon = "inv_staff_71",
	buyPrice = 929820,
	sellPrice = 185964,
	reqLevel = 80,
}
t[44176] = {
	name = L["Girdle of the Warrior Magi"],
	quality = 3,
	icon = "inv_belt_34",
	buyPrice = 263752,
	sellPrice = 52750,
	reqLevel = 80,
}
t[44179] = {
	name = L["Mind-Expanding Leggings"],
	quality = 3,
	icon = "inv_pants_leather_27",
	buyPrice = 378693,
	sellPrice = 75738,
	reqLevel = 80,
}
t[44180] = {
	name = L["Robes of Crackling Flame"],
	quality = 4,
	icon = "inv_chest_cloth_24",
	buyPrice = 405390,
	sellPrice = 81078,
	reqLevel = 80,
}
t[44181] = {
	name = L["Ghostflicker Waistband"],
	quality = 4,
	icon = "inv_belt_39",
	buyPrice = 254275,
	sellPrice = 50855,
	reqLevel = 80,
}
t[44182] = {
	name = L["Boots of Twinkling Stars"],
	quality = 4,
	icon = "inv_boots_chain_05",
	buyPrice = 461326,
	sellPrice = 92265,
	reqLevel = 80,
}
t[44183] = {
	name = L["Fireproven Gauntlets"],
	quality = 4,
	icon = "inv_gauntlets_31",
	buyPrice = 360539,
	sellPrice = 72107,
	reqLevel = 80,
}
t[50368] = {
	name = L["Arcanum of Burning Mysteries"],
	quality = 7,
	icon = "spell_fire_masterofelements",
	buyPrice = 1500000,
	sellPrice = 375000,
	reqLevel = 80,
}
t[44621] = {
	name = L["Bottle of Dalaran White"],
	quality = 1,
	icon = "inv_drink_11",
	buyPrice = 75000,
	sellPrice = 1875,
	reqLevel = 0,
}
t[44622] = {
	name = L["Cask of Dalaran White"],
	quality = 1,
	icon = "inv_cask_03",
	buyPrice = 375000,
	sellPrice = 9375,
	reqLevel = 0,
}
t[44623] = {
	name = L["Bottle of Dalaran Red"],
	quality = 1,
	icon = "inv_drink_09",
	buyPrice = 100000,
	sellPrice = 2500,
	reqLevel = 0,
}
t[44625] = {
	name = L["Bottle of Aged Dalaran Red"],
	quality = 2,
	icon = "inv_drink_10",
	buyPrice = 500000,
	sellPrice = 2500,
	reqLevel = 0,
}
t[44626] = {
	name = L["Cask of Aged Dalaran Red"],
	quality = 2,
	icon = "inv_cask_01",
	buyPrice = 2500000,
	sellPrice = 12500,
	reqLevel = 0,
}
t[44632] = {
	name = L["Cask of Dalaran Red"],
	quality = 1,
	icon = "inv_cask_01",
	buyPrice = 500000,
	sellPrice = 12500,
	reqLevel = 0,
}
t[44678] = {
	name = L["Wine Glass"],
	quality = 1,
	icon = "inv_drink_22",
	buyPrice = 50000,
	sellPrice = 12500,
	reqLevel = 0,
}
t[44679] = {
	name = L["Red Wine Glass"],
	quality = 1,
	icon = "inv_drink_02",
	buyPrice = 100000,
	sellPrice = 25000,
	reqLevel = 0,
}
t[42943] = {
	name = L["Bloodied Arcanite Reaper"],
	quality = 7,
	icon = "inv_axe_09",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[42944] = {
	name = L["Balanced Heartseeker"],
	quality = 7,
	icon = "inv_sword_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[42945] = {
	name = L["Venerable Dal'Rend's Sacred Charge"],
	quality = 7,
	icon = "inv_sword_43",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[42946] = {
	name = L["Charmed Ancient Bone Bow"],
	quality = 7,
	icon = "inv_weapon_bow_08",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[42947] = {
	name = L["Dignified Headmaster's Charge"],
	quality = 7,
	icon = "inv_jewelry_talisman_12",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[42948] = {
	name = L["Devout Aurastone Hammer"],
	quality = 7,
	icon = "inv_hammer_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[42949] = {
	name = L["Polished Spaulders of Valor"],
	quality = 7,
	icon = "inv_shoulder_30",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[42950] = {
	name = L["Champion Herod's Shoulder"],
	quality = 7,
	icon = "inv_shoulder_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[42951] = {
	name = L["Mystical Pauldrons of Elements"],
	quality = 7,
	icon = "inv_shoulder_29",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[42952] = {
	name = L["Stained Shadowcraft Spaulders"],
	quality = 7,
	icon = "inv_shoulder_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[42984] = {
	name = L["Preened Ironfeather Shoulders"],
	quality = 7,
	icon = "inv_shoulder_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[42985] = {
	name = L["Tattered Dreadmist Mantle"],
	quality = 7,
	icon = "inv_misc_bone_taurenskull_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[42991] = {
	name = L["Swift Hand of Justice"],
	quality = 7,
	icon = "inv_jewelry_talisman_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[42992] = {
	name = L["Discerning Eye of the Beast"],
	quality = 7,
	icon = "inv_jewelry_talisman_08",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[48677] = {
	name = L["Champion's Deathdealer Breastplate"],
	quality = 7,
	icon = "inv_chest_chain_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 1,
}
t[48683] = {
	name = L["Mystical Vest of Elements"],
	quality = 7,
	icon = "inv_chest_chain_11",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 1,
}
t[48685] = {
	name = L["Polished Breastplate of Valor"],
	quality = 7,
	icon = "inv_chest_plate03",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 1,
}
t[48687] = {
	name = L["Preened Ironfeather Breastplate"],
	quality = 7,
	icon = "inv_chest_leather_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 1,
}
t[48689] = {
	name = L["Stained Shadowcraft Tunic"],
	quality = 7,
	icon = "inv_chest_leather_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 1,
}
t[48691] = {
	name = L["Tattered Dreadmist Robe"],
	quality = 7,
	icon = "inv_chest_cloth_49",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 1,
}
t[48716] = {
	name = L["Venerable Mass of McGowan"],
	quality = 7,
	icon = "inv_hammer_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 1,
}
t[48718] = {
	name = L["Repurposed Lava Dredger"],
	quality = 7,
	icon = "inv_gizmo_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 1,
}
t[37339] = {
	name = L["Formula: Enchant Weapon - Giant Slayer"],
	quality = 3,
	icon = "inv_enchant_formulasuperior_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Enchanting"],
	teaches = L["Enchant Weapon - Giant Slayer"],
	learnedAt = 430,
}
t[37340] = {
	name = L["Formula: Enchant Chest - Exceptional Resilience"],
	quality = 2,
	icon = "inv_enchant_formulagood_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Enchanting"],
	teaches = L["Enchant Chest - Exceptional Resilience"],
	learnedAt = 410,
}
t[37344] = {
	name = L["Formula: Enchant Weapon - Icebreaker"],
	quality = 3,
	icon = "inv_enchant_formulasuperior_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Enchanting"],
	teaches = L["Enchant Weapon - Icebreaker"],
	learnedAt = 425,
}
t[37347] = {
	name = L["Formula: Enchant Cloak - Titanweave"],
	quality = 2,
	icon = "inv_enchant_formulagood_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Enchanting"],
	teaches = L["Enchant Cloak - Titanweave"],
	learnedAt = 435,
}
t[37349] = {
	name = L["Formula: Enchant Cloak - Shadow Armor"],
	quality = 2,
	icon = "inv_enchant_formulagood_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Enchanting"],
	teaches = L["Enchant Cloak - Shadow Armor"],
	learnedAt = 440,
}
t[44471] = {
	name = L["Formula: Enchant Cloak - Mighty Armor"],
	quality = 2,
	icon = "inv_enchant_formulagood_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Enchanting"],
	teaches = L["Enchant Cloak - Mighty Armor"],
	learnedAt = 430,
}
t[44472] = {
	name = L["Formula: Enchant Cloak - Greater Speed"],
	quality = 2,
	icon = "inv_enchant_formulagood_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Enchanting"],
	teaches = L["Enchant Cloak - Greater Speed"],
	learnedAt = 430,
}
t[44473] = {
	name = L["Formula: Enchant Weapon - Scourgebane"],
	quality = 3,
	icon = "inv_enchant_formulasuperior_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Enchanting"],
	teaches = L["Enchant 2H Weapon - Scourgebane"],
	learnedAt = 430,
}
t[44483] = {
	name = L["Formula: Enchant 2H Weapon - Massacre"],
	quality = 3,
	icon = "inv_enchant_formulasuperior_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Enchanting"],
	teaches = L["Enchant 2H Weapon - Massacre"],
	learnedAt = 430,
}
t[44484] = {
	name = L["Formula: Enchant Bracers - Greater Assault"],
	quality = 2,
	icon = "inv_enchant_formulagood_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Enchanting"],
	teaches = L["Enchant Bracers - Greater Assault"],
	learnedAt = 430,
}
t[44485] = {
	name = L["Formula: Enchant Gloves - Armsman"],
	quality = 2,
	icon = "inv_enchant_formulagood_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Enchanting"],
	teaches = L["Enchant Gloves - Armsman"],
	learnedAt = 435,
}
t[44486] = {
	name = L["Formula: Enchant Weapon - Superior Potency"],
	quality = 3,
	icon = "inv_enchant_formulasuperior_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Enchanting"],
	teaches = L["Enchant Weapon - Superior Potency"],
	learnedAt = 435,
}
t[44487] = {
	name = L["Formula: Enchant Weapon - Mighty Spellpower"],
	quality = 3,
	icon = "inv_enchant_formulasuperior_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Enchanting"],
	teaches = L["Enchant Weapon - Mighty Spellpower"],
	learnedAt = 435,
}
t[44488] = {
	name = L["Formula: Enchant Cloak - Wisdom"],
	quality = 2,
	icon = "inv_enchant_formulagood_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Enchanting"],
	teaches = L["Enchant Cloak - Wisdom"],
	learnedAt = 440,
}
t[44489] = {
	name = L["Formula: Enchant Chest - Powerful Stats"],
	quality = 2,
	icon = "inv_enchant_formulagood_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Enchanting"],
	teaches = L["Enchant Chest - Powerful Stats"],
	learnedAt = 440,
}
t[44490] = {
	name = L["Formula: Enchant Boots - Greater Assault"],
	quality = 2,
	icon = "inv_enchant_formulagood_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Enchanting"],
	teaches = L["Enchant Boots - Greater Assault"],
	learnedAt = 440,
}
t[44491] = {
	name = L["Formula: Enchant Boots - Tuskarr's Vitality"],
	quality = 2,
	icon = "inv_enchant_formulagood_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Enchanting"],
	teaches = L["Enchant Boots - Tuskarr's Vitality"],
	learnedAt = 440,
}
t[44492] = {
	name = L["Formula: Enchant Weapon - Berserking"],
	quality = 3,
	icon = "inv_enchant_formulasuperior_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Enchanting"],
	teaches = L["Enchant Weapon - Berserking"],
	learnedAt = 440,
}
t[44494] = {
	name = L["Formula: Enchant Weapon - Lifeward"],
	quality = 3,
	icon = "inv_enchant_formulasuperior_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Enchanting"],
	teaches = L["Enchant Weapon - Lifeward"],
	learnedAt = 425,
}
t[44495] = {
	name = L["Formula: Enchant Weapon - Black Magic"],
	quality = 3,
	icon = "inv_enchant_formulasuperior_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Enchanting"],
	teaches = L["Enchant Weapon - Black Magic"],
	learnedAt = 440,
}
t[44496] = {
	name = L["Formula: Enchant Weapon - Accuracy"],
	quality = 3,
	icon = "inv_enchant_formulasuperior_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Enchanting"],
	teaches = L["Enchant Weapon - Accuracy"],
	learnedAt = 440,
}
t[44498] = {
	name = L["Formula: Enchant Bracer - Superior Spellpower"],
	quality = 2,
	icon = "inv_enchant_formulagood_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Enchanting"],
	teaches = L["Enchant Bracers - Superior Spellpower"],
	learnedAt = 440,
}
t[44944] = {
	name = L["Formula: Enchant Bracer - Major Stamina"],
	quality = 3,
	icon = "inv_enchant_formulasuperior_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Enchanting"],
	teaches = L["Enchant Bracers - Major Stamina"],
	learnedAt = 450,
}
t[45059] = {
	name = L["Formula: Enchant Staff - Greater Spellpower"],
	quality = 3,
	icon = "inv_enchant_formulasuperior_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Enchanting"],
	teaches = L["Enchant Staff - Greater Spellpower"],
	learnedAt = 450,
}
t[44513] = {
	name = L["Pattern: Eviscerator's Facemask"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Eviscerator's Facemask"],
	learnedAt = 420,
}
t[44514] = {
	name = L["Pattern: Eviscerator's Shoulderpads"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Eviscerator's Shoulderpads"],
	learnedAt = 420,
}
t[44515] = {
	name = L["Pattern: Eviscerator's Chestguard"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Eviscerator's Chestguard"],
	learnedAt = 420,
}
t[44516] = {
	name = L["Pattern: Eviscerator's Bindings"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Eviscerator's Bindings"],
	learnedAt = 420,
}
t[44517] = {
	name = L["Pattern: Eviscerator's Gauntlets"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Eviscerator's Gauntlets"],
	learnedAt = 425,
}
t[44518] = {
	name = L["Pattern: Eviscerator's Waistguard"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Eviscerator's Waistguard"],
	learnedAt = 425,
}
t[44519] = {
	name = L["Pattern: Eviscerator's Legguards"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Eviscerator's Legguards"],
	learnedAt = 425,
}
t[44520] = {
	name = L["Pattern: Eviscerator's Treads"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Eviscerator's Treads"],
	learnedAt = 425,
}
t[44521] = {
	name = L["Pattern: Overcast Headguard"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Overcast Headguard"],
	learnedAt = 420,
}
t[44522] = {
	name = L["Pattern: Overcast Spaulders"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Overcast Spaulders"],
	learnedAt = 420,
}
t[44523] = {
	name = L["Pattern: Overcast Chestguard"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Overcast Chestguard"],
	learnedAt = 420,
}
t[44524] = {
	name = L["Pattern: Overcast Bracers"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Overcast Bracers"],
	learnedAt = 420,
}
t[44525] = {
	name = L["Pattern: Overcast Handwraps"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Overcast Handwraps"],
	learnedAt = 425,
}
t[44526] = {
	name = L["Pattern: Overcast Belt"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Overcast Belt"],
	learnedAt = 425,
}
t[44527] = {
	name = L["Pattern: Overcast Leggings"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Overcast Leggings"],
	learnedAt = 425,
}
t[44528] = {
	name = L["Pattern: Overcast Boots"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Overcast Boots"],
	learnedAt = 425,
}
t[44530] = {
	name = L["Pattern: Swiftarrow Helm"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Swiftarrow Helm"],
	learnedAt = 420,
}
t[44531] = {
	name = L["Pattern: Swiftarrow Shoulderguards"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Swiftarrow Shoulderguards"],
	learnedAt = 420,
}
t[44532] = {
	name = L["Pattern: Swiftarrow Hauberk"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Swiftarrow Hauberk"],
	learnedAt = 420,
}
t[44533] = {
	name = L["Pattern: Swiftarrow Bracers"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Swiftarrow Bracers"],
	learnedAt = 420,
}
t[44534] = {
	name = L["Pattern: Swiftarrow Gauntlets"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Swiftarrow Gauntlets"],
	learnedAt = 425,
}
t[44535] = {
	name = L["Pattern: Swiftarrow Belt"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Swiftarrow Belt"],
	learnedAt = 425,
}
t[44536] = {
	name = L["Pattern: Swiftarrow Leggings"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Swiftarrow Leggings"],
	learnedAt = 425,
}
t[44537] = {
	name = L["Pattern: Swiftarrow Boots"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Swiftarrow Boots"],
	learnedAt = 425,
}
t[44538] = {
	name = L["Pattern: Stormhide Crown"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Stormhide Crown"],
	learnedAt = 420,
}
t[44539] = {
	name = L["Pattern: Stormhide Shoulders"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Stormhide Shoulders"],
	learnedAt = 420,
}
t[44540] = {
	name = L["Pattern: Stormhide Hauberk"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Stormhide Hauberk"],
	learnedAt = 420,
}
t[44541] = {
	name = L["Pattern: Stormhide Wristguards"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Stormhide Wristguards"],
	learnedAt = 420,
}
t[44542] = {
	name = L["Pattern: Stormhide Grips"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Stormhide Grips"],
	learnedAt = 425,
}
t[44543] = {
	name = L["Pattern: Stormhide Belt"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Stormhide Belt"],
	learnedAt = 425,
}
t[44544] = {
	name = L["Pattern: Stormhide Legguards"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Stormhide Legguards"],
	learnedAt = 425,
}
t[44545] = {
	name = L["Pattern: Stormhide Stompers"],
	quality = 3,
	icon = "inv_scroll_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Stormhide Stompers"],
	learnedAt = 425,
}
t[44546] = {
	name = L["Pattern: Giantmaim Legguards"],
	quality = 4,
	icon = "inv_scroll_04",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Giantmaim Legguards"],
	learnedAt = 440,
}
t[44547] = {
	name = L["Pattern: Giantmaim Bracers"],
	quality = 4,
	icon = "inv_scroll_04",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Giantmaim Bracers"],
	learnedAt = 440,
}
t[44548] = {
	name = L["Pattern: Revenant's Breastplate"],
	quality = 4,
	icon = "inv_scroll_04",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Revenant's Breastplate"],
	learnedAt = 440,
}
t[44549] = {
	name = L["Pattern: Revenant's Treads"],
	quality = 4,
	icon = "inv_scroll_04",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Revenant's Treads"],
	learnedAt = 440,
}
t[44550] = {
	name = L["Pattern: Trollwoven Spaulders"],
	quality = 4,
	icon = "inv_scroll_04",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Trollwoven Spaulders"],
	learnedAt = 440,
}
t[44551] = {
	name = L["Pattern: Trollwoven Girdle"],
	quality = 4,
	icon = "inv_scroll_04",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Trollwoven Girdle"],
	learnedAt = 440,
}
t[44552] = {
	name = L["Pattern: Earthgiving Legguards"],
	quality = 4,
	icon = "inv_scroll_04",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Earthgiving Legguards"],
	learnedAt = 440,
}
t[44553] = {
	name = L["Pattern: Earthgiving Boots"],
	quality = 4,
	icon = "inv_scroll_04",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Earthgiving Boots"],
	learnedAt = 440,
}
t[44584] = {
	name = L["Pattern: Polar Vest"],
	quality = 4,
	icon = "inv_scroll_04",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Polar Vest"],
	learnedAt = 425,
}
t[44585] = {
	name = L["Pattern: Polar Cord"],
	quality = 4,
	icon = "inv_scroll_04",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Polar Cord"],
	learnedAt = 420,
}
t[44586] = {
	name = L["Pattern: Polar Boots"],
	quality = 4,
	icon = "inv_scroll_04",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Polar Boots"],
	learnedAt = 420,
}
t[44587] = {
	name = L["Pattern: Icy Scale Chestguard"],
	quality = 4,
	icon = "inv_scroll_04",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Icy Scale Chestguard"],
	learnedAt = 425,
}
t[44588] = {
	name = L["Pattern: Icy Scale Belt"],
	quality = 4,
	icon = "inv_scroll_04",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Icy Scale Belt"],
	learnedAt = 420,
}
t[44589] = {
	name = L["Pattern: Icy Scale Boots"],
	quality = 4,
	icon = "inv_scroll_04",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Icy Scale Boots"],
	learnedAt = 420,
}
t[44932] = {
	name = L["Pattern: Windripper Boots"],
	quality = 4,
	icon = "inv_scroll_04",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Windripper Boots"],
	learnedAt = 440,
}
t[44933] = {
	name = L["Pattern: Windripper Leggings"],
	quality = 4,
	icon = "inv_scroll_04",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Windripper Leggings"],
	learnedAt = 440,
}
t[44737] = {
	name = L["Draenic Silk Robes"],
	quality = 1,
	icon = "inv_chest_cloth_26",
	buyPrice = 500005,
	sellPrice = 100001,
	reqLevel = 0,
}
t[37101] = {
	name = L["Ivory Ink"],
	quality = 1,
	icon = "inv_inscription_inkwhite03",
	buyPrice = 0,
	sellPrice = 12,
	reqLevel = 0,
}
t[39469] = {
	name = L["Moonglow Ink"],
	quality = 1,
	icon = "inv_inscription_inkwhite02",
	buyPrice = 0,
	sellPrice = 500,
	reqLevel = 0,
}
t[39774] = {
	name = L["Midnight Ink"],
	quality = 1,
	icon = "inv_inscription_inkblack01",
	buyPrice = 0,
	sellPrice = 500,
	reqLevel = 0,
}
t[43116] = {
	name = L["Lion's Ink"],
	quality = 1,
	icon = "inv_inscription_inkyellow02",
	buyPrice = 0,
	sellPrice = 500,
	reqLevel = 0,
}
t[43118] = {
	name = L["Jadefire Ink"],
	quality = 1,
	icon = "inv_inscription_inkgreen03",
	buyPrice = 0,
	sellPrice = 500,
	reqLevel = 0,
}
t[43120] = {
	name = L["Celestial Ink"],
	quality = 1,
	icon = "inv_inscription_inkpurple03",
	buyPrice = 0,
	sellPrice = 500,
	reqLevel = 0,
}
t[43122] = {
	name = L["Shimmering Ink"],
	quality = 1,
	icon = "inv_inscription_inksilver01",
	buyPrice = 0,
	sellPrice = 500,
	reqLevel = 0,
}
t[43124] = {
	name = L["Ethereal Ink"],
	quality = 1,
	icon = "inv_inscription_inkblack02",
	buyPrice = 0,
	sellPrice = 500,
	reqLevel = 0,
}
t[43127] = {
	name = L["Snowfall Ink"],
	quality = 2,
	icon = "inv_inscription_inkbluewhite01",
	buyPrice = 0,
	sellPrice = 500,
	reqLevel = 0,
}
t[45335] = {
	name = L["Valorous Darkruned Chestguard"],
	quality = 4,
	icon = "inv_chest_plate02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[45336] = {
	name = L["Valorous Darkruned Faceguard"],
	quality = 4,
	icon = "inv_helmet_58",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[45337] = {
	name = L["Valorous Darkruned Handguards"],
	quality = 4,
	icon = "inv_gauntlets_28",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[45338] = {
	name = L["Valorous Darkruned Legguards"],
	quality = 4,
	icon = "inv_pants_plate_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[45339] = {
	name = L["Valorous Darkruned Pauldrons"],
	quality = 4,
	icon = "inv_shoulder_29",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[45340] = {
	name = L["Valorous Darkruned Battleplate"],
	quality = 4,
	icon = "inv_chest_plate02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[45341] = {
	name = L["Valorous Darkruned Gauntlets"],
	quality = 4,
	icon = "inv_gauntlets_28",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[45342] = {
	name = L["Valorous Darkruned Helmet"],
	quality = 4,
	icon = "inv_helmet_58",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[45343] = {
	name = L["Valorous Darkruned Legplates"],
	quality = 4,
	icon = "inv_pants_plate_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[45344] = {
	name = L["Valorous Darkruned Shoulderplates"],
	quality = 4,
	icon = "inv_shoulder_29",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[45370] = {
	name = L["Valorous Aegis Gloves"],
	quality = 4,
	icon = "inv_gauntlets_28",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[45371] = {
	name = L["Valorous Aegis Greaves"],
	quality = 4,
	icon = "inv_pants_plate_29",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[45372] = {
	name = L["Valorous Aegis Headpiece"],
	quality = 4,
	icon = "inv_helmet_97",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[45373] = {
	name = L["Valorous Aegis Spaulders"],
	quality = 4,
	icon = "inv_shoulder_22",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[45374] = {
	name = L["Valorous Aegis Tunic"],
	quality = 4,
	icon = "inv_chest_plate21",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[45375] = {
	name = L["Valorous Aegis Battleplate"],
	quality = 4,
	icon = "inv_chest_plate21",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[45376] = {
	name = L["Valorous Aegis Gauntlets"],
	quality = 4,
	icon = "inv_gauntlets_28",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[45377] = {
	name = L["Valorous Aegis Helm"],
	quality = 4,
	icon = "inv_helmet_97",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[45379] = {
	name = L["Valorous Aegis Legplates"],
	quality = 4,
	icon = "inv_pants_plate_29",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[45380] = {
	name = L["Valorous Aegis Shoulderplates"],
	quality = 4,
	icon = "inv_shoulder_22",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[45381] = {
	name = L["Valorous Aegis Breastplate"],
	quality = 4,
	icon = "inv_chest_plate21",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[45382] = {
	name = L["Valorous Aegis Faceguard"],
	quality = 4,
	icon = "inv_helmet_97",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[45383] = {
	name = L["Valorous Aegis Handguards"],
	quality = 4,
	icon = "inv_gauntlets_28",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[45384] = {
	name = L["Valorous Aegis Legguards"],
	quality = 4,
	icon = "inv_pants_plate_29",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[45385] = {
	name = L["Valorous Aegis Shoulderguards"],
	quality = 4,
	icon = "inv_shoulder_22",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[45424] = {
	name = L["Valorous Siegebreaker Breastplate"],
	quality = 4,
	icon = "inv_chest_plate02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[45425] = {
	name = L["Valorous Siegebreaker Greathelm"],
	quality = 4,
	icon = "inv_helmet_58",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[45426] = {
	name = L["Valorous Siegebreaker Handguards"],
	quality = 4,
	icon = "inv_gauntlets_28",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[45427] = {
	name = L["Valorous Siegebreaker Legguards"],
	quality = 4,
	icon = "inv_pants_plate_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[45428] = {
	name = L["Valorous Siegebreaker Pauldrons"],
	quality = 4,
	icon = "inv_shoulder_29",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[45429] = {
	name = L["Valorous Siegebreaker Battleplate"],
	quality = 4,
	icon = "inv_chest_plate02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[45430] = {
	name = L["Valorous Siegebreaker Gauntlets"],
	quality = 4,
	icon = "inv_gauntlets_28",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[45431] = {
	name = L["Valorous Siegebreaker Helmet"],
	quality = 4,
	icon = "inv_helmet_58",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[45432] = {
	name = L["Valorous Siegebreaker Legplates"],
	quality = 4,
	icon = "inv_pants_plate_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[45433] = {
	name = L["Valorous Siegebreaker Shoulderplates"],
	quality = 4,
	icon = "inv_shoulder_29",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[46111] = {
	name = L["Conqueror's Darkruned Battleplate"],
	quality = 4,
	icon = "inv_chest_plate02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[46113] = {
	name = L["Conqueror's Darkruned Gauntlets"],
	quality = 4,
	icon = "inv_gauntlets_28",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[46115] = {
	name = L["Conqueror's Darkruned Helmet"],
	quality = 4,
	icon = "inv_helmet_58",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[46116] = {
	name = L["Conqueror's Darkruned Legplates"],
	quality = 4,
	icon = "inv_pants_plate_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[46117] = {
	name = L["Conqueror's Darkruned Shoulderplates"],
	quality = 4,
	icon = "inv_shoulder_29",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[46118] = {
	name = L["Conqueror's Darkruned Chestguard"],
	quality = 4,
	icon = "inv_chest_plate02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[46119] = {
	name = L["Conqueror's Darkruned Handguards"],
	quality = 4,
	icon = "inv_gauntlets_28",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[46120] = {
	name = L["Conqueror's Darkruned Faceguard"],
	quality = 4,
	icon = "inv_helmet_58",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[46121] = {
	name = L["Conqueror's Darkruned Legguards"],
	quality = 4,
	icon = "inv_pants_plate_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[46122] = {
	name = L["Conqueror's Darkruned Pauldrons"],
	quality = 4,
	icon = "inv_shoulder_29",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[46146] = {
	name = L["Conqueror's Siegebreaker Battleplate"],
	quality = 4,
	icon = "inv_chest_plate02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[46148] = {
	name = L["Conqueror's Siegebreaker Gauntlets"],
	quality = 4,
	icon = "inv_gauntlets_28",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[46149] = {
	name = L["Conqueror's Siegebreaker Shoulderplates"],
	quality = 4,
	icon = "inv_shoulder_29",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[46150] = {
	name = L["Conqueror's Siegebreaker Legplates"],
	quality = 4,
	icon = "inv_pants_plate_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[46151] = {
	name = L["Conqueror's Siegebreaker Helmet"],
	quality = 4,
	icon = "inv_helmet_58",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[46152] = {
	name = L["Conqueror's Aegis Shoulderplates"],
	quality = 4,
	icon = "inv_shoulder_22",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[46153] = {
	name = L["Conqueror's Aegis Legplates"],
	quality = 4,
	icon = "inv_pants_plate_24",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[46154] = {
	name = L["Conqueror's Aegis Battleplate"],
	quality = 4,
	icon = "inv_chest_plate21",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[46155] = {
	name = L["Conqueror's Aegis Gauntlets"],
	quality = 4,
	icon = "inv_gauntlets_28",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[46156] = {
	name = L["Conqueror's Aegis Helm"],
	quality = 4,
	icon = "inv_helmet_97",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[46162] = {
	name = L["Conqueror's Siegebreaker Breastplate"],
	quality = 4,
	icon = "inv_chest_plate02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[46164] = {
	name = L["Conqueror's Siegebreaker Handguards"],
	quality = 4,
	icon = "inv_gauntlets_28",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[46166] = {
	name = L["Conqueror's Siegebreaker Greathelm"],
	quality = 4,
	icon = "inv_helmet_58",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[46167] = {
	name = L["Conqueror's Siegebreaker Pauldrons"],
	quality = 4,
	icon = "inv_shoulder_29",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[46169] = {
	name = L["Conqueror's Siegebreaker Legguards"],
	quality = 4,
	icon = "inv_pants_plate_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[46173] = {
	name = L["Conqueror's Aegis Breastplate"],
	quality = 4,
	icon = "inv_chest_plate21",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[46174] = {
	name = L["Conqueror's Aegis Handguards"],
	quality = 4,
	icon = "inv_gauntlets_28",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[46175] = {
	name = L["Conqueror's Aegis Faceguard"],
	quality = 4,
	icon = "inv_helmet_97",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[46176] = {
	name = L["Conqueror's Aegis Legguards"],
	quality = 4,
	icon = "inv_pants_plate_24",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[46177] = {
	name = L["Conqueror's Aegis Shoulderguards"],
	quality = 4,
	icon = "inv_shoulder_22",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[46178] = {
	name = L["Conqueror's Aegis Tunic"],
	quality = 4,
	icon = "inv_chest_plate21",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[46179] = {
	name = L["Conqueror's Aegis Gloves"],
	quality = 4,
	icon = "inv_gauntlets_28",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[46180] = {
	name = L["Conqueror's Aegis Headpiece"],
	quality = 4,
	icon = "inv_helmet_97",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[46181] = {
	name = L["Conqueror's Aegis Greaves"],
	quality = 4,
	icon = "inv_pants_plate_24",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[46182] = {
	name = L["Conqueror's Aegis Spaulders"],
	quality = 4,
	icon = "inv_shoulder_22",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[48371] = {
	name = L["Wrynn's Helmet of Conquest"],
	quality = 4,
	icon = "inv_helmet_23",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[48372] = {
	name = L["Wrynn's Battleplate of Conquest"],
	quality = 4,
	icon = "inv_chest_plate_25",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[48373] = {
	name = L["Wrynn's Legplates of Conquest"],
	quality = 4,
	icon = "inv_pants_plate_24",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[48374] = {
	name = L["Wrynn's Shoulderplates of Conquest"],
	quality = 4,
	icon = "inv_shoulder_20",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[48375] = {
	name = L["Wrynn's Gauntlets of Conquest"],
	quality = 4,
	icon = "inv_gauntlets_62",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[48429] = {
	name = L["Wrynn's Greathelm of Conquest"],
	quality = 4,
	icon = "inv_helmet_23",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[48436] = {
	name = L["Wrynn's Breastplate of Conquest"],
	quality = 4,
	icon = "inv_chest_plate_25",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[48445] = {
	name = L["Wrynn's Legguards of Conquest"],
	quality = 4,
	icon = "inv_pants_plate_24",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[48448] = {
	name = L["Wrynn's Pauldrons of Conquest"],
	quality = 4,
	icon = "inv_shoulder_20",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[48449] = {
	name = L["Wrynn's Handguards of Conquest"],
	quality = 4,
	icon = "inv_gauntlets_62",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[48472] = {
	name = L["Thassarian's Helmet of Conquest"],
	quality = 4,
	icon = "inv_helmet_08",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[48474] = {
	name = L["Thassarian's Battleplate of Conquest"],
	quality = 4,
	icon = "inv_chest_plate_24",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[48476] = {
	name = L["Thassarian's Legplates of Conquest"],
	quality = 4,
	icon = "inv_pants_plate_27",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[48478] = {
	name = L["Thassarian's Shoulderplates of Conquest"],
	quality = 4,
	icon = "inv_shoulder_04",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[48480] = {
	name = L["Thassarian's Gauntlets of Conquest"],
	quality = 4,
	icon = "inv_gauntlets_75",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[48529] = {
	name = L["Thassarian's Faceguard of Conquest"],
	quality = 4,
	icon = "inv_helmet_08",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[48531] = {
	name = L["Thassarian's Chestguard of Conquest"],
	quality = 4,
	icon = "inv_chest_plate_24",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[48533] = {
	name = L["Thassarian's Legguards of Conquest"],
	quality = 4,
	icon = "inv_pants_plate_27",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[48535] = {
	name = L["Thassarian's Pauldrons of Conquest"],
	quality = 4,
	icon = "inv_shoulder_04",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[48537] = {
	name = L["Thassarian's Handguards of Conquest"],
	quality = 4,
	icon = "inv_gauntlets_75",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[48564] = {
	name = L["Turalyon's Headpiece of Conquest"],
	quality = 4,
	icon = "inv_helmet_25",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[48566] = {
	name = L["Turalyon's Tunic of Conquest"],
	quality = 4,
	icon = "inv_chest_plate_22",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[48568] = {
	name = L["Turalyon's Greaves of Conquest"],
	quality = 4,
	icon = "inv_pants_plate_29",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[48572] = {
	name = L["Turalyon's Spaulders of Conquest"],
	quality = 4,
	icon = "inv_shoulder_30",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[48574] = {
	name = L["Turalyon's Gloves of Conquest"],
	quality = 4,
	icon = "inv_gauntlets_79",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[48602] = {
	name = L["Turalyon's Battleplate of Conquest"],
	quality = 4,
	icon = "inv_chest_plate_22",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[48603] = {
	name = L["Turalyon's Gauntlets of Conquest"],
	quality = 4,
	icon = "inv_gauntlets_79",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[48604] = {
	name = L["Turalyon's Helm of Conquest"],
	quality = 4,
	icon = "inv_helmet_25",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[48605] = {
	name = L["Turalyon's Legplates of Conquest"],
	quality = 4,
	icon = "inv_pants_plate_29",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[48606] = {
	name = L["Turalyon's Shoulderplates of Conquest"],
	quality = 4,
	icon = "inv_shoulder_30",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[48632] = {
	name = L["Turalyon's Breastplate of Conquest"],
	quality = 4,
	icon = "inv_chest_plate_22",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[48633] = {
	name = L["Turalyon's Handguards of Conquest"],
	quality = 4,
	icon = "inv_gauntlets_79",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[48634] = {
	name = L["Turalyon's Faceguard of Conquest"],
	quality = 4,
	icon = "inv_helmet_25",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[48635] = {
	name = L["Turalyon's Legguards of Conquest"],
	quality = 4,
	icon = "inv_pants_plate_29",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[48636] = {
	name = L["Turalyon's Shoulderguards of Conquest"],
	quality = 4,
	icon = "inv_shoulder_30",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[50244] = {
	name = L["Dark Coven Shoulderpads"],
	quality = 4,
	icon = "inv_shoulder_114",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[50243] = {
	name = L["Dark Coven Robe"],
	quality = 4,
	icon = "inv_chest_cloth_77",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[50242] = {
	name = L["Dark Coven Leggings"],
	quality = 4,
	icon = "inv_kilt_cloth_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[50241] = {
	name = L["Dark Coven Hood"],
	quality = 4,
	icon = "inv_helmet_152",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[50240] = {
	name = L["Dark Coven Gloves"],
	quality = 4,
	icon = "inv_gauntlets_88",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51209] = {
	name = L["Sanctified Dark Coven Gloves"],
	quality = 4,
	icon = "inv_gauntlets_88",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51208] = {
	name = L["Sanctified Dark Coven Hood"],
	quality = 4,
	icon = "inv_helmet_152",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51207] = {
	name = L["Sanctified Dark Coven Leggings"],
	quality = 4,
	icon = "inv_kilt_cloth_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51206] = {
	name = L["Sanctified Dark Coven Robe"],
	quality = 4,
	icon = "inv_chest_cloth_77",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51205] = {
	name = L["Sanctified Dark Coven Shoulderpads"],
	quality = 4,
	icon = "inv_shoulder_114",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[50767] = {
	name = L["Crimson Acolyte Shoulderpads"],
	quality = 4,
	icon = "inv_shoulder_119",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[50768] = {
	name = L["Crimson Acolyte Robe"],
	quality = 4,
	icon = "inv_chest_cloth_80",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[50769] = {
	name = L["Crimson Acolyte Leggings"],
	quality = 4,
	icon = "inv_pants_cloth_35",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[50765] = {
	name = L["Crimson Acolyte Hood"],
	quality = 4,
	icon = "inv_helmet_156",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[50766] = {
	name = L["Crimson Acolyte Gloves"],
	quality = 4,
	icon = "inv_gauntlets_92",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51179] = {
	name = L["Sanctified Crimson Acolyte Gloves"],
	quality = 4,
	icon = "inv_gauntlets_92",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51178] = {
	name = L["Sanctified Crimson Acolyte Hood"],
	quality = 4,
	icon = "inv_helmet_156",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51177] = {
	name = L["Sanctified Crimson Acolyte Leggings"],
	quality = 4,
	icon = "inv_pants_cloth_35",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51176] = {
	name = L["Sanctified Crimson Acolyte Robe"],
	quality = 4,
	icon = "inv_chest_cloth_80",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51175] = {
	name = L["Sanctified Crimson Acolyte Shoulderpads"],
	quality = 4,
	icon = "inv_shoulder_119",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[50394] = {
	name = L["Crimson Acolyte Raiments"],
	quality = 4,
	icon = "inv_chest_cloth_80",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[50393] = {
	name = L["Crimson Acolyte Pants"],
	quality = 4,
	icon = "inv_pants_cloth_35",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[50396] = {
	name = L["Crimson Acolyte Mantle"],
	quality = 4,
	icon = "inv_shoulder_119",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[50391] = {
	name = L["Crimson Acolyte Handwraps"],
	quality = 4,
	icon = "inv_gauntlets_92",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[50392] = {
	name = L["Crimson Acolyte Cowl"],
	quality = 4,
	icon = "inv_helmet_156",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51184] = {
	name = L["Sanctified Crimson Acolyte Cowl"],
	quality = 4,
	icon = "inv_helmet_156",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51183] = {
	name = L["Sanctified Crimson Acolyte Handwraps"],
	quality = 4,
	icon = "inv_gauntlets_92",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51182] = {
	name = L["Sanctified Crimson Acolyte Mantle"],
	quality = 4,
	icon = "inv_shoulder_119",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51181] = {
	name = L["Sanctified Crimson Acolyte Pants"],
	quality = 4,
	icon = "inv_pants_cloth_35",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51180] = {
	name = L["Sanctified Crimson Acolyte Raiments"],
	quality = 4,
	icon = "inv_chest_cloth_80",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[47798] = {
	name = L["Gul'dan's Shoulderpads of Conquest"],
	quality = 4,
	icon = "inv_shoulder_35",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[47799] = {
	name = L["Gul'dan's Robe of Conquest"],
	quality = 4,
	icon = "inv_chest_cloth_63",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[47800] = {
	name = L["Gul'dan's Leggings of Conquest"],
	quality = 4,
	icon = "inv_pants_cloth_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[47801] = {
	name = L["Gul'dan's Hood of Conquest"],
	quality = 4,
	icon = "inv_helmet_139",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[47802] = {
	name = L["Gul'dan's Gloves of Conquest"],
	quality = 4,
	icon = "inv_gauntlets_61",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[48067] = {
	name = L["Zabra's Gloves of Conquest"],
	quality = 4,
	icon = "inv_gauntlets_55",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[48068] = {
	name = L["Zabra's Cowl of Conquest"],
	quality = 4,
	icon = "inv_helmet_87",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[48069] = {
	name = L["Zabra's Leggings of Conquest"],
	quality = 4,
	icon = "inv_pants_cloth_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[48070] = {
	name = L["Zabra's Robe of Conquest"],
	quality = 4,
	icon = "inv_chest_cloth_73",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[48071] = {
	name = L["Zabra's Shoulderpads of Conquest"],
	quality = 4,
	icon = "inv_shoulder_90",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[48097] = {
	name = L["Zabra's Handwraps of Conquest"],
	quality = 4,
	icon = "inv_gauntlets_55",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[48098] = {
	name = L["Zabra's Circlet of Conquest"],
	quality = 4,
	icon = "inv_helmet_87",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[48099] = {
	name = L["Zabra's Pants of Conquest"],
	quality = 4,
	icon = "inv_pants_cloth_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[48100] = {
	name = L["Zabra's Raiments of Conquest"],
	quality = 4,
	icon = "inv_chest_cloth_73",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[48101] = {
	name = L["Zabra's Mantle of Conquest"],
	quality = 4,
	icon = "inv_shoulder_90",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51230] = {
	name = L["Sanctified Dark Coven Gloves"],
	quality = 4,
	icon = "inv_gauntlets_88",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51231] = {
	name = L["Sanctified Dark Coven Hood"],
	quality = 4,
	icon = "inv_helmet_152",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51232] = {
	name = L["Sanctified Dark Coven Leggings"],
	quality = 4,
	icon = "inv_kilt_cloth_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51233] = {
	name = L["Sanctified Dark Coven Robe"],
	quality = 4,
	icon = "inv_chest_cloth_77",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51234] = {
	name = L["Sanctified Dark Coven Shoulderpads"],
	quality = 4,
	icon = "inv_shoulder_114",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51255] = {
	name = L["Sanctified Crimson Acolyte Cowl"],
	quality = 4,
	icon = "inv_helmet_156",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51256] = {
	name = L["Sanctified Crimson Acolyte Handwraps"],
	quality = 4,
	icon = "inv_gauntlets_92",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51257] = {
	name = L["Sanctified Crimson Acolyte Mantle"],
	quality = 4,
	icon = "inv_shoulder_119",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51258] = {
	name = L["Sanctified Crimson Acolyte Pants"],
	quality = 4,
	icon = "inv_pants_cloth_35",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51259] = {
	name = L["Sanctified Crimson Acolyte Raiments"],
	quality = 4,
	icon = "inv_chest_cloth_80",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51260] = {
	name = L["Sanctified Crimson Acolyte Gloves"],
	quality = 4,
	icon = "inv_gauntlets_92",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51261] = {
	name = L["Sanctified Crimson Acolyte Hood"],
	quality = 4,
	icon = "inv_helmet_156",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51262] = {
	name = L["Sanctified Crimson Acolyte Leggings"],
	quality = 4,
	icon = "inv_pants_cloth_35",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51263] = {
	name = L["Sanctified Crimson Acolyte Robe"],
	quality = 4,
	icon = "inv_chest_cloth_80",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51264] = {
	name = L["Sanctified Crimson Acolyte Shoulderpads"],
	quality = 4,
	icon = "inv_shoulder_119",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[50105] = {
	name = L["Shadowblade Pauldrons"],
	quality = 4,
	icon = "inv_shoulder_112",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[50090] = {
	name = L["Shadowblade Legplates"],
	quality = 4,
	icon = "inv_pants_leather_34",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[50089] = {
	name = L["Shadowblade Helmet"],
	quality = 4,
	icon = "inv_helmet_149",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[50088] = {
	name = L["Shadowblade Gauntlets"],
	quality = 4,
	icon = "inv_gauntlets_85",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[50087] = {
	name = L["Shadowblade Breastplate"],
	quality = 4,
	icon = "inv_chest_leather_22",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51189] = {
	name = L["Sanctified Shadowblade Breastplate"],
	quality = 4,
	icon = "inv_chest_leather_22",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51188] = {
	name = L["Sanctified Shadowblade Gauntlets"],
	quality = 4,
	icon = "inv_gauntlets_85",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51187] = {
	name = L["Sanctified Shadowblade Helmet"],
	quality = 4,
	icon = "inv_helmet_149",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51186] = {
	name = L["Sanctified Shadowblade Legplates"],
	quality = 4,
	icon = "inv_pants_leather_34",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51185] = {
	name = L["Sanctified Shadowblade Pauldrons"],
	quality = 4,
	icon = "inv_shoulder_112",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[50113] = {
	name = L["Lasherweave Pauldrons"],
	quality = 4,
	icon = "inv_shoulder_111",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[50109] = {
	name = L["Lasherweave Legplates"],
	quality = 4,
	icon = "inv_pants_leather_35",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[50108] = {
	name = L["Lasherweave Helmet"],
	quality = 4,
	icon = "inv_helmet_148",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[50107] = {
	name = L["Lasherweave Gauntlets"],
	quality = 4,
	icon = "inv_gauntlets_83",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[50106] = {
	name = L["Lasherweave Robes"],
	quality = 4,
	icon = "inv_chest_leather_21",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51139] = {
	name = L["Sanctified Lasherweave Robes"],
	quality = 4,
	icon = "inv_chest_leather_21",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51138] = {
	name = L["Sanctified Lasherweave Gauntlets"],
	quality = 4,
	icon = "inv_gauntlets_83",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51137] = {
	name = L["Sanctified Lasherweave Helmet"],
	quality = 4,
	icon = "inv_helmet_148",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51136] = {
	name = L["Sanctified Lasherweave Legplates"],
	quality = 4,
	icon = "inv_pants_leather_35",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51135] = {
	name = L["Sanctified Lasherweave Pauldrons"],
	quality = 4,
	icon = "inv_shoulder_111",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[50823] = {
	name = L["Lasherweave Vestment"],
	quality = 4,
	icon = "inv_chest_leather_21",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[50820] = {
	name = L["Lasherweave Trousers"],
	quality = 4,
	icon = "inv_pants_leather_35",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[50819] = {
	name = L["Lasherweave Mantle"],
	quality = 4,
	icon = "inv_shoulder_111",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[50822] = {
	name = L["Lasherweave Gloves"],
	quality = 4,
	icon = "inv_gauntlets_83",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[50821] = {
	name = L["Lasherweave Cover"],
	quality = 4,
	icon = "inv_helmet_148",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51149] = {
	name = L["Sanctified Lasherweave Cover"],
	quality = 4,
	icon = "inv_helmet_148",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51148] = {
	name = L["Sanctified Lasherweave Gloves"],
	quality = 4,
	icon = "inv_gauntlets_83",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51147] = {
	name = L["Sanctified Lasherweave Mantle"],
	quality = 4,
	icon = "inv_shoulder_111",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51146] = {
	name = L["Sanctified Lasherweave Trousers"],
	quality = 4,
	icon = "inv_pants_leather_35",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51145] = {
	name = L["Sanctified Lasherweave Vestment"],
	quality = 4,
	icon = "inv_chest_leather_21",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[50824] = {
	name = L["Lasherweave Shoulderpads"],
	quality = 4,
	icon = "inv_shoulder_111",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[50828] = {
	name = L["Lasherweave Raiment"],
	quality = 4,
	icon = "inv_chest_leather_21",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[50825] = {
	name = L["Lasherweave Legguards"],
	quality = 4,
	icon = "inv_pants_leather_35",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[50826] = {
	name = L["Lasherweave Headguard"],
	quality = 4,
	icon = "inv_helmet_148",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[50827] = {
	name = L["Lasherweave Handgrips"],
	quality = 4,
	icon = "inv_gauntlets_83",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51144] = {
	name = L["Sanctified Lasherweave Handgrips"],
	quality = 4,
	icon = "inv_gauntlets_83",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51143] = {
	name = L["Sanctified Lasherweave Headguard"],
	quality = 4,
	icon = "inv_helmet_148",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51142] = {
	name = L["Sanctified Lasherweave Legguards"],
	quality = 4,
	icon = "inv_pants_leather_35",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51141] = {
	name = L["Sanctified Lasherweave Raiment"],
	quality = 4,
	icon = "inv_chest_leather_21",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51140] = {
	name = L["Sanctified Lasherweave Shoulderpads"],
	quality = 4,
	icon = "inv_shoulder_111",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[48243] = {
	name = L["Garona's Breastplate of Conquest"],
	quality = 4,
	icon = "inv_chest_leather_18a",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[48244] = {
	name = L["Garona's Gauntlets of Conquest"],
	quality = 4,
	icon = "inv_gauntlets_78a",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[48245] = {
	name = L["Garona's Helmet of Conquest"],
	quality = 4,
	icon = "inv_helmet_145a",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[48246] = {
	name = L["Garona's Legplates of Conquest"],
	quality = 4,
	icon = "inv_pants_leather_30a",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[48247] = {
	name = L["Garona's Pauldrons of Conquest"],
	quality = 4,
	icon = "inv_shoulder_109a",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51250] = {
	name = L["Sanctified Shadowblade Breastplate"],
	quality = 4,
	icon = "inv_chest_leather_22",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51251] = {
	name = L["Sanctified Shadowblade Gauntlets"],
	quality = 4,
	icon = "inv_gauntlets_85",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51252] = {
	name = L["Sanctified Shadowblade Helmet"],
	quality = 4,
	icon = "inv_helmet_149",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51253] = {
	name = L["Sanctified Shadowblade Legplates"],
	quality = 4,
	icon = "inv_pants_leather_34",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51254] = {
	name = L["Sanctified Shadowblade Pauldrons"],
	quality = 4,
	icon = "inv_shoulder_112",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51290] = {
	name = L["Sanctified Lasherweave Cover"],
	quality = 4,
	icon = "inv_helmet_148",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51291] = {
	name = L["Sanctified Lasherweave Gloves"],
	quality = 4,
	icon = "inv_gauntlets_83",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51292] = {
	name = L["Sanctified Lasherweave Mantle"],
	quality = 4,
	icon = "inv_shoulder_111",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51293] = {
	name = L["Sanctified Lasherweave Trousers"],
	quality = 4,
	icon = "inv_pants_leather_35",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51294] = {
	name = L["Sanctified Lasherweave Vestment"],
	quality = 4,
	icon = "inv_chest_leather_21",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51295] = {
	name = L["Sanctified Lasherweave Handgrips"],
	quality = 4,
	icon = "inv_gauntlets_83",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51296] = {
	name = L["Sanctified Lasherweave Headguard"],
	quality = 4,
	icon = "inv_helmet_148",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51297] = {
	name = L["Sanctified Lasherweave Legguards"],
	quality = 4,
	icon = "inv_pants_leather_35",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51298] = {
	name = L["Sanctified Lasherweave Raiment"],
	quality = 4,
	icon = "inv_chest_leather_21",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51299] = {
	name = L["Sanctified Lasherweave Shoulderpads"],
	quality = 4,
	icon = "inv_shoulder_111",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51300] = {
	name = L["Sanctified Lasherweave Robes"],
	quality = 4,
	icon = "inv_chest_leather_21",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51301] = {
	name = L["Sanctified Lasherweave Gauntlets"],
	quality = 4,
	icon = "inv_gauntlets_83",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51302] = {
	name = L["Sanctified Lasherweave Helmet"],
	quality = 4,
	icon = "inv_helmet_148",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51303] = {
	name = L["Sanctified Lasherweave Legplates"],
	quality = 4,
	icon = "inv_pants_leather_35",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51304] = {
	name = L["Sanctified Lasherweave Pauldrons"],
	quality = 4,
	icon = "inv_shoulder_111",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[50098] = {
	name = L["Scourgelord Shoulderplates"],
	quality = 4,
	icon = "inv_shoulder_130",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[50097] = {
	name = L["Scourgelord Legplates"],
	quality = 4,
	icon = "inv_pants_plate_31",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[50096] = {
	name = L["Scourgelord Helmet"],
	quality = 4,
	icon = "inv_helmet_151",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[50095] = {
	name = L["Scourgelord Gauntlets"],
	quality = 4,
	icon = "inv_gauntlets_87",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[50094] = {
	name = L["Scourgelord Battleplate"],
	quality = 4,
	icon = "inv_chest_plate_26",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51129] = {
	name = L["Sanctified Scourgelord Battleplate"],
	quality = 4,
	icon = "inv_chest_plate_26",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51128] = {
	name = L["Sanctified Scourgelord Gauntlets"],
	quality = 4,
	icon = "inv_gauntlets_87",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51127] = {
	name = L["Sanctified Scourgelord Helmet"],
	quality = 4,
	icon = "inv_helmet_151",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51126] = {
	name = L["Sanctified Scourgelord Legplates"],
	quality = 4,
	icon = "inv_pants_plate_31",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51125] = {
	name = L["Sanctified Scourgelord Shoulderplates"],
	quality = 4,
	icon = "inv_shoulder_130",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[50853] = {
	name = L["Scourgelord Pauldrons"],
	quality = 4,
	icon = "inv_shoulder_130",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[50854] = {
	name = L["Scourgelord Legguards"],
	quality = 4,
	icon = "inv_pants_plate_31",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[50856] = {
	name = L["Scourgelord Handguards"],
	quality = 4,
	icon = "inv_gauntlets_87",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[50855] = {
	name = L["Scourgelord Faceguard"],
	quality = 4,
	icon = "inv_helmet_151",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[50857] = {
	name = L["Scourgelord Chestguard"],
	quality = 4,
	icon = "inv_chest_plate_26",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51134] = {
	name = L["Sanctified Scourgelord Chestguard"],
	quality = 4,
	icon = "inv_chest_plate_26",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51133] = {
	name = L["Sanctified Scourgelord Faceguard"],
	quality = 4,
	icon = "inv_helmet_151",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51132] = {
	name = L["Sanctified Scourgelord Handguards"],
	quality = 4,
	icon = "inv_gauntlets_87",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51131] = {
	name = L["Sanctified Scourgelord Legguards"],
	quality = 4,
	icon = "inv_pants_plate_31",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51130] = {
	name = L["Sanctified Scourgelord Pauldrons"],
	quality = 4,
	icon = "inv_shoulder_130",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[50869] = {
	name = L["Lightsworn Tunic"],
	quality = 4,
	icon = "inv_chest_plate22",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[50865] = {
	name = L["Lightsworn Spaulders"],
	quality = 4,
	icon = "inv_shoulder_117",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[50867] = {
	name = L["Lightsworn Headpiece"],
	quality = 4,
	icon = "inv_helmet_154",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[50866] = {
	name = L["Lightsworn Greaves"],
	quality = 4,
	icon = "inv_pants_plate_33",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[50868] = {
	name = L["Lightsworn Gloves"],
	quality = 4,
	icon = "inv_gauntlets_85",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51169] = {
	name = L["Sanctified Lightsworn Gloves"],
	quality = 4,
	icon = "inv_gauntlets_85",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51168] = {
	name = L["Sanctified Lightsworn Greaves"],
	quality = 4,
	icon = "inv_pants_plate_33",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51167] = {
	name = L["Sanctified Lightsworn Headpiece"],
	quality = 4,
	icon = "inv_helmet_154",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51166] = {
	name = L["Sanctified Lightsworn Spaulders"],
	quality = 4,
	icon = "inv_shoulder_117",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51165] = {
	name = L["Sanctified Lightsworn Tunic"],
	quality = 4,
	icon = "inv_chest_plate22",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[50324] = {
	name = L["Lightsworn Shoulderplates"],
	quality = 4,
	icon = "inv_shoulder_117",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[50325] = {
	name = L["Lightsworn Legplates"],
	quality = 4,
	icon = "inv_pants_plate_33",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[50326] = {
	name = L["Lightsworn Helmet"],
	quality = 4,
	icon = "inv_helmet_154",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[50327] = {
	name = L["Lightsworn Gauntlets"],
	quality = 4,
	icon = "inv_gauntlets_85",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[50328] = {
	name = L["Lightsworn Battleplate"],
	quality = 4,
	icon = "inv_chest_plate22",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51164] = {
	name = L["Sanctified Lightsworn Battleplate"],
	quality = 4,
	icon = "inv_chest_plate22",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51163] = {
	name = L["Sanctified Lightsworn Gauntlets"],
	quality = 4,
	icon = "inv_gauntlets_85",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51162] = {
	name = L["Sanctified Lightsworn Helmet"],
	quality = 4,
	icon = "inv_helmet_154",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51161] = {
	name = L["Sanctified Lightsworn Legplates"],
	quality = 4,
	icon = "inv_pants_plate_33",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51160] = {
	name = L["Sanctified Lightsworn Shoulderplates"],
	quality = 4,
	icon = "inv_shoulder_117",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[50860] = {
	name = L["Lightsworn Shoulderguards"],
	quality = 4,
	icon = "inv_shoulder_117",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[50861] = {
	name = L["Lightsworn Legguards"],
	quality = 4,
	icon = "inv_pants_plate_33",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[50863] = {
	name = L["Lightsworn Handguards"],
	quality = 4,
	icon = "inv_gauntlets_85",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[50862] = {
	name = L["Lightsworn Faceguard"],
	quality = 4,
	icon = "inv_helmet_154",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[50864] = {
	name = L["Lightsworn Chestguard"],
	quality = 4,
	icon = "inv_chest_plate22",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51174] = {
	name = L["Sanctified Lightsworn Chestguard"],
	quality = 4,
	icon = "inv_chest_plate22",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51173] = {
	name = L["Sanctified Lightsworn Faceguard"],
	quality = 4,
	icon = "inv_helmet_154",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51172] = {
	name = L["Sanctified Lightsworn Handguards"],
	quality = 4,
	icon = "inv_gauntlets_85",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51171] = {
	name = L["Sanctified Lightsworn Legguards"],
	quality = 4,
	icon = "inv_pants_plate_33",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51170] = {
	name = L["Sanctified Lightsworn Shoulderguards"],
	quality = 4,
	icon = "inv_shoulder_117",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[50082] = {
	name = L["Ymirjar Lord's Shoulderplates"],
	quality = 4,
	icon = "inv_shoulder_129",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[50081] = {
	name = L["Ymirjar Lord's Legplates"],
	quality = 4,
	icon = "inv_pants_plate_32",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[50080] = {
	name = L["Ymirjar Lord's Helmet"],
	quality = 4,
	icon = "inv_helmet_158",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[50079] = {
	name = L["Ymirjar Lord's Gauntlets"],
	quality = 4,
	icon = "inv_gauntlets_86",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[50078] = {
	name = L["Ymirjar Lord's Battleplate"],
	quality = 4,
	icon = "inv_chest_plate_25",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51214] = {
	name = L["Sanctified Ymirjar Lord's Battleplate"],
	quality = 4,
	icon = "inv_chest_plate_25",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51213] = {
	name = L["Sanctified Ymirjar Lord's Gauntlets"],
	quality = 4,
	icon = "inv_gauntlets_86",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51212] = {
	name = L["Sanctified Ymirjar Lord's Helmet"],
	quality = 4,
	icon = "inv_helmet_158",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51211] = {
	name = L["Sanctified Ymirjar Lord's Legplates"],
	quality = 4,
	icon = "inv_pants_plate_32",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51210] = {
	name = L["Sanctified Ymirjar Lord's Shoulderplates"],
	quality = 4,
	icon = "inv_shoulder_129",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[50846] = {
	name = L["Ymirjar Lord's Pauldrons"],
	quality = 4,
	icon = "inv_shoulder_129",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[50847] = {
	name = L["Ymirjar Lord's Legguards"],
	quality = 4,
	icon = "inv_pants_plate_32",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[50849] = {
	name = L["Ymirjar Lord's Handguards"],
	quality = 4,
	icon = "inv_gauntlets_86",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[50848] = {
	name = L["Ymirjar Lord's Greathelm"],
	quality = 4,
	icon = "inv_helmet_158",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[50850] = {
	name = L["Ymirjar Lord's Breastplate"],
	quality = 4,
	icon = "inv_chest_plate_25",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51219] = {
	name = L["Sanctified Ymirjar Lord's Breastplate"],
	quality = 4,
	icon = "inv_chest_plate_25",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51218] = {
	name = L["Sanctified Ymirjar Lord's Greathelm"],
	quality = 4,
	icon = "inv_helmet_158",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51217] = {
	name = L["Sanctified Ymirjar Lord's Handguards"],
	quality = 4,
	icon = "inv_gauntlets_86",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51216] = {
	name = L["Sanctified Ymirjar Lord's Legguards"],
	quality = 4,
	icon = "inv_pants_plate_32",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51215] = {
	name = L["Sanctified Ymirjar Lord's Pauldrons"],
	quality = 4,
	icon = "inv_shoulder_129",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[48501] = {
	name = L["Koltira's Battleplate of Conquest"],
	quality = 4,
	icon = "inv_chest_plate_24",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[48502] = {
	name = L["Koltira's Gauntlets of Conquest"],
	quality = 4,
	icon = "inv_gauntlets_62",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[48503] = {
	name = L["Koltira's Helmet of Conquest"],
	quality = 4,
	icon = "inv_helmet_130",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[48504] = {
	name = L["Koltira's Legplates of Conquest"],
	quality = 4,
	icon = "inv_pants_plate_25",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[48505] = {
	name = L["Koltira's Shoulderplates of Conquest"],
	quality = 4,
	icon = "inv_shoulder_73",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[48558] = {
	name = L["Koltira's Chestguard of Conquest"],
	quality = 4,
	icon = "inv_chest_plate_24",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[48559] = {
	name = L["Koltira's Handguards of Conquest"],
	quality = 4,
	icon = "inv_gauntlets_62",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[48560] = {
	name = L["Koltira's Faceguard of Conquest"],
	quality = 4,
	icon = "inv_helmet_130",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[48561] = {
	name = L["Koltira's Legguards of Conquest"],
	quality = 4,
	icon = "inv_pants_plate_25",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[48562] = {
	name = L["Koltira's Pauldrons of Conquest"],
	quality = 4,
	icon = "inv_shoulder_73",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[48595] = {
	name = L["Liadrin's Spaulders of Conquest"],
	quality = 4,
	icon = "inv_shoulder_62",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[48596] = {
	name = L["Liadrin's Greaves of Conquest"],
	quality = 4,
	icon = "inv_pants_plate_30",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[48597] = {
	name = L["Liadrin's Headpiece of Conquest"],
	quality = 4,
	icon = "inv_helmet_98",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[48598] = {
	name = L["Liadrin's Gloves of Conquest"],
	quality = 4,
	icon = "inv_gauntlets_65",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[48599] = {
	name = L["Liadrin's Tunic of Conquest"],
	quality = 4,
	icon = "inv_chest_plate_23",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[48627] = {
	name = L["Liadrin's Shoulderplates of Conquest"],
	quality = 4,
	icon = "inv_shoulder_62",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[48628] = {
	name = L["Liadrin's Legplates of Conquest"],
	quality = 4,
	icon = "inv_pants_plate_30",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[48629] = {
	name = L["Liadrin's Helm of Conquest"],
	quality = 4,
	icon = "inv_helmet_98",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[48630] = {
	name = L["Liadrin's Gauntlets of Conquest"],
	quality = 4,
	icon = "inv_gauntlets_65",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[48631] = {
	name = L["Liadrin's Battleplate of Conquest"],
	quality = 4,
	icon = "inv_chest_plate_23",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[48652] = {
	name = L["Liadrin's Breastplate of Conquest"],
	quality = 4,
	icon = "inv_chest_plate_23",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[48653] = {
	name = L["Liadrin's Handguards of Conquest"],
	quality = 4,
	icon = "inv_gauntlets_65",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[48654] = {
	name = L["Liadrin's Faceguard of Conquest"],
	quality = 4,
	icon = "inv_helmet_98",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[48655] = {
	name = L["Liadrin's Legguards of Conquest"],
	quality = 4,
	icon = "inv_pants_plate_30",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[48656] = {
	name = L["Liadrin's Shoulderguards of Conquest"],
	quality = 4,
	icon = "inv_shoulder_62",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51220] = {
	name = L["Sanctified Ymirjar Lord's Breastplate"],
	quality = 4,
	icon = "inv_chest_plate_25",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51221] = {
	name = L["Sanctified Ymirjar Lord's Greathelm"],
	quality = 4,
	icon = "inv_helmet_158",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51222] = {
	name = L["Sanctified Ymirjar Lord's Handguards"],
	quality = 4,
	icon = "inv_gauntlets_86",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51223] = {
	name = L["Sanctified Ymirjar Lord's Legguards"],
	quality = 4,
	icon = "inv_pants_plate_32",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51224] = {
	name = L["Sanctified Ymirjar Lord's Pauldrons"],
	quality = 4,
	icon = "inv_shoulder_129",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51225] = {
	name = L["Sanctified Ymirjar Lord's Battleplate"],
	quality = 4,
	icon = "inv_chest_plate_25",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51226] = {
	name = L["Sanctified Ymirjar Lord's Gauntlets"],
	quality = 4,
	icon = "inv_gauntlets_86",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51227] = {
	name = L["Sanctified Ymirjar Lord's Helmet"],
	quality = 4,
	icon = "inv_helmet_158",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51228] = {
	name = L["Sanctified Ymirjar Lord's Legplates"],
	quality = 4,
	icon = "inv_pants_plate_32",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51229] = {
	name = L["Sanctified Ymirjar Lord's Shoulderplates"],
	quality = 4,
	icon = "inv_shoulder_129",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51265] = {
	name = L["Sanctified Lightsworn Chestguard"],
	quality = 4,
	icon = "inv_chest_plate22",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51266] = {
	name = L["Sanctified Lightsworn Faceguard"],
	quality = 4,
	icon = "inv_helmet_154",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51267] = {
	name = L["Sanctified Lightsworn Handguards"],
	quality = 4,
	icon = "inv_gauntlets_85",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51268] = {
	name = L["Sanctified Lightsworn Legguards"],
	quality = 4,
	icon = "inv_pants_plate_33",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51269] = {
	name = L["Sanctified Lightsworn Shoulderguards"],
	quality = 4,
	icon = "inv_shoulder_117",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51270] = {
	name = L["Sanctified Lightsworn Gloves"],
	quality = 4,
	icon = "inv_gauntlets_85",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51271] = {
	name = L["Sanctified Lightsworn Greaves"],
	quality = 4,
	icon = "inv_pants_plate_33",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51272] = {
	name = L["Sanctified Lightsworn Headpiece"],
	quality = 4,
	icon = "inv_helmet_154",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51273] = {
	name = L["Sanctified Lightsworn Spaulders"],
	quality = 4,
	icon = "inv_shoulder_117",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51274] = {
	name = L["Sanctified Lightsworn Tunic"],
	quality = 4,
	icon = "inv_chest_plate22",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51275] = {
	name = L["Sanctified Lightsworn Battleplate"],
	quality = 4,
	icon = "inv_chest_plate22",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51276] = {
	name = L["Sanctified Lightsworn Gauntlets"],
	quality = 4,
	icon = "inv_gauntlets_85",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51277] = {
	name = L["Sanctified Lightsworn Helmet"],
	quality = 4,
	icon = "inv_helmet_154",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51278] = {
	name = L["Sanctified Lightsworn Legplates"],
	quality = 4,
	icon = "inv_pants_plate_33",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51279] = {
	name = L["Sanctified Lightsworn Shoulderplates"],
	quality = 4,
	icon = "inv_shoulder_117",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51305] = {
	name = L["Sanctified Scourgelord Chestguard"],
	quality = 4,
	icon = "inv_chest_plate_26",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51306] = {
	name = L["Sanctified Scourgelord Faceguard"],
	quality = 4,
	icon = "inv_helmet_151",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51307] = {
	name = L["Sanctified Scourgelord Handguards"],
	quality = 4,
	icon = "inv_gauntlets_87",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51308] = {
	name = L["Sanctified Scourgelord Legguards"],
	quality = 4,
	icon = "inv_pants_plate_31",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51309] = {
	name = L["Sanctified Scourgelord Pauldrons"],
	quality = 4,
	icon = "inv_shoulder_130",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51310] = {
	name = L["Sanctified Scourgelord Battleplate"],
	quality = 4,
	icon = "inv_chest_plate_26",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51311] = {
	name = L["Sanctified Scourgelord Gauntlets"],
	quality = 4,
	icon = "inv_gauntlets_87",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51312] = {
	name = L["Sanctified Scourgelord Helmet"],
	quality = 4,
	icon = "inv_helmet_151",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51313] = {
	name = L["Sanctified Scourgelord Legplates"],
	quality = 4,
	icon = "inv_pants_plate_31",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51314] = {
	name = L["Sanctified Scourgelord Shoulderplates"],
	quality = 4,
	icon = "inv_shoulder_130",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[50118] = {
	name = L["Ahn'Kahar Blood Hunter's Tunic"],
	quality = 4,
	icon = "inv_chest_mail_11",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[50117] = {
	name = L["Ahn'Kahar Blood Hunter's Spaulders"],
	quality = 4,
	icon = "inv_shoulder_113",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[50116] = {
	name = L["Ahn'Kahar Blood Hunter's Legguards"],
	quality = 4,
	icon = "inv_pants_mail_32",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[50115] = {
	name = L["Ahn'Kahar Blood Hunter's Headpiece"],
	quality = 4,
	icon = "inv_helmet_158",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[50114] = {
	name = L["Ahn'Kahar Blood Hunter's Handguards"],
	quality = 4,
	icon = "inv_gauntlets_84",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51154] = {
	name = L["Sanctified Ahn'Kahar Blood Hunter's Handguards"],
	quality = 4,
	icon = "inv_gauntlets_84",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51153] = {
	name = L["Sanctified Ahn'Kahar Blood Hunter's Headpiece"],
	quality = 4,
	icon = "inv_helmet_158",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51152] = {
	name = L["Sanctified Ahn'Kahar Blood Hunter's Legguards"],
	quality = 4,
	icon = "inv_pants_mail_32",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51151] = {
	name = L["Sanctified Ahn'Kahar Blood Hunter's Spaulders"],
	quality = 4,
	icon = "inv_shoulder_113",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51150] = {
	name = L["Sanctified Ahn'Kahar Blood Hunter's Tunic"],
	quality = 4,
	icon = "inv_chest_mail_11",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51285] = {
	name = L["Sanctified Ahn'Kahar Blood Hunter's Handguards"],
	quality = 4,
	icon = "inv_gauntlets_84",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51286] = {
	name = L["Sanctified Ahn'Kahar Blood Hunter's Headpiece"],
	quality = 4,
	icon = "inv_helmet_158",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51287] = {
	name = L["Sanctified Ahn'Kahar Blood Hunter's Legguards"],
	quality = 4,
	icon = "inv_pants_mail_32",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51288] = {
	name = L["Sanctified Ahn'Kahar Blood Hunter's Spaulders"],
	quality = 4,
	icon = "inv_shoulder_113",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[51289] = {
	name = L["Sanctified Ahn'Kahar Blood Hunter's Tunic"],
	quality = 4,
	icon = "inv_chest_mail_11",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[2889] = {
	name = L["Recipe: Beer Basted Boar Ribs"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 240,
	sellPrice = 60,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Beer Basted Boar Ribs"],
	learnedAt = 10,
}
t[3679] = {
	name = L["Recipe: Blood Sausage"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 400,
	sellPrice = 100,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Blood Sausage"],
	learnedAt = 60,
}
t[3681] = {
	name = L["Recipe: Crocolisk Gumbo"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 1600,
	sellPrice = 400,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Crocolisk Gumbo"],
	learnedAt = 120,
}
t[3678] = {
	name = L["Recipe: Crocolisk Steak"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 400,
	sellPrice = 100,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Crocolisk Steak"],
	learnedAt = 80,
}
t[3683] = {
	name = L["Recipe: Gooey Spider Cake"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 1600,
	sellPrice = 400,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Gooey Spider Cake"],
	learnedAt = 110,
}
t[2697] = {
	name = L["Recipe: Goretusk Liver Pie"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 400,
	sellPrice = 100,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Goretusk Liver Pie"],
	learnedAt = 50,
}
t[3680] = {
	name = L["Recipe: Murloc Fin Soup"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 1600,
	sellPrice = 400,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Murloc Fin Soup"],
	learnedAt = 90,
}
t[2699] = {
	name = L["Recipe: Redridge Goulash"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 800,
	sellPrice = 200,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Redridge Goulash"],
	learnedAt = 100,
}
t[2701] = {
	name = L["Recipe: Seasoned Wolf Kabob"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 1600,
	sellPrice = 400,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Seasoned Wolf Kabob"],
	learnedAt = 100,
}
t[728] = {
	name = L["Recipe: Westfall Stew"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 200,
	sellPrice = 50,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Westfall Stew"],
	learnedAt = 50,
}
t[2698] = {
	name = L["Recipe: Cooked Crab Claw"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 400,
	sellPrice = 100,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Cooked Crab Claw"],
	learnedAt = 85,
}
t[2700] = {
	name = L["Recipe: Succulent Pork Ribs"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 400,
	sellPrice = 100,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Succulent Pork Ribs"],
	learnedAt = 110,
}
t[15810] = {
	name = L["Short Spear"],
	quality = 1,
	icon = "inv_spear_05",
	buyPrice = 10145,
	sellPrice = 2029,
	reqLevel = 20,
}
t[15811] = {
	name = L["Heavy Spear"],
	quality = 1,
	icon = "inv_spear_06",
	buyPrice = 27133,
	sellPrice = 5426,
	reqLevel = 30,
}
t[2665] = {
	name = L["Stormwind Seasoning Herbs"],
	quality = 1,
	icon = "inv_misc_dust_02",
	buyPrice = 20,
	sellPrice = 5,
	reqLevel = 0,
}
t[18649] = {
	name = L["Schematic: Blue Firework"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 1800,
	sellPrice = 450,
	reqLevel = 0,
	profession = L["Engineering"],
	teaches = L["Blue Firework"],
	learnedAt = 150,
}
t[2612] = {
	name = L["Plain Robe"],
	quality = 1,
	icon = "inv_chest_cloth_33",
	buyPrice = 163,
	sellPrice = 32,
	reqLevel = 3,
}
t[2613] = {
	name = L["Double-stitched Robes"],
	quality = 1,
	icon = "inv_chest_cloth_24",
	buyPrice = 608,
	sellPrice = 121,
	reqLevel = 8,
}
t[2614] = {
	name = L["Robe of Apprenticeship"],
	quality = 1,
	icon = "inv_chest_cloth_38",
	buyPrice = 1162,
	sellPrice = 232,
	reqLevel = 12,
}
t[2615] = {
	name = L["Chromatic Robe"],
	quality = 1,
	icon = "inv_chest_cloth_38",
	buyPrice = 5092,
	sellPrice = 1018,
	reqLevel = 24,
}
t[2616] = {
	name = L["Shimmering Silk Robes"],
	quality = 1,
	icon = "inv_chest_cloth_04",
	buyPrice = 2660,
	sellPrice = 532,
	reqLevel = 18,
}
t[2617] = {
	name = L["Burning Robes"],
	quality = 1,
	icon = "inv_chest_cloth_40",
	buyPrice = 10992,
	sellPrice = 2198,
	reqLevel = 32,
}
t[2618] = {
	name = L["Silver Dress Robes"],
	quality = 1,
	icon = "inv_chest_cloth_32",
	buyPrice = 26640,
	sellPrice = 5328,
	reqLevel = 45,
}
t[9301] = {
	name = L["Recipe: Elixir of Shadow Power"],
	quality = 2,
	icon = "inv_scroll_06",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 0,
	profession = L["Alchemy"],
	teaches = L["Elixir of Shadow Power"],
	learnedAt = 250,
}
t[10325] = {
	name = L["Pattern: White Wedding Dress"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 0,
	profession = L["Tailoring"],
	teaches = L["White Wedding Dress"],
	learnedAt = 250,
}
t[2508] = {
	name = L["Old Blunderbuss"],
	quality = 1,
	icon = "inv_weapon_rifle_01",
	buyPrice = 27,
	sellPrice = 5,
	reqLevel = 1,
}
t[8489] = {
	name = L["Cat Carrier (White Kitten)"],
	quality = 1,
	icon = "inv_box_petcarrier_01",
	buyPrice = 6000,
	sellPrice = 1500,
	reqLevel = 0,
}
t[18442] = {
	name = L["Master Sergeant's Insignia"],
	quality = 3,
	icon = "inv_misc_monsterscales_09",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 30,
}
t[18443] = {
	name = L["Master Sergeant's Insignia"],
	quality = 3,
	icon = "inv_misc_monsterscales_09",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 58,
}
t[18444] = {
	name = L["Master Sergeant's Insignia"],
	quality = 3,
	icon = "inv_misc_monsterscales_09",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 45,
}
t[18606] = {
	name = L["Alliance Battle Standard"],
	quality = 1,
	icon = "inv_bannerpvp_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[18839] = {
	name = L["Combat Healing Potion"],
	quality = 1,
	icon = "inv_potion_39",
	buyPrice = 1000,
	sellPrice = 250,
	reqLevel = 35,
}
t[18841] = {
	name = L["Combat Mana Potion"],
	quality = 1,
	icon = "inv_potion_81",
	buyPrice = 1000,
	sellPrice = 250,
	reqLevel = 41,
}
t[18854] = {
	name = L["Insignia of the Alliance"],
	quality = 3,
	icon = "inv_jewelry_trinketpvp_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[18856] = {
	name = L["Insignia of the Alliance"],
	quality = 3,
	icon = "inv_jewelry_trinketpvp_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[18857] = {
	name = L["Insignia of the Alliance"],
	quality = 3,
	icon = "inv_jewelry_trinketpvp_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[18858] = {
	name = L["Insignia of the Alliance"],
	quality = 3,
	icon = "inv_jewelry_trinketpvp_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[18859] = {
	name = L["Insignia of the Alliance"],
	quality = 3,
	icon = "inv_jewelry_trinketpvp_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[18862] = {
	name = L["Insignia of the Alliance"],
	quality = 3,
	icon = "inv_jewelry_trinketpvp_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[18863] = {
	name = L["Insignia of the Alliance"],
	quality = 3,
	icon = "inv_jewelry_trinketpvp_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[18864] = {
	name = L["Insignia of the Alliance"],
	quality = 3,
	icon = "inv_jewelry_trinketpvp_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[28118] = {
	name = L["Runed Ornate Ruby"],
	quality = 4,
	icon = "inv_misc_gem_bloodstone_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[28119] = {
	name = L["Smooth Ornate Dawnstone"],
	quality = 4,
	icon = "inv_misc_gem_topaz_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[28120] = {
	name = L["Gleaming Ornate Dawnstone"],
	quality = 4,
	icon = "inv_misc_gem_topaz_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[28123] = {
	name = L["Potent Ornate Topaz"],
	quality = 4,
	icon = "inv_misc_gem_opal_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[28362] = {
	name = L["Bold Ornate Ruby"],
	quality = 4,
	icon = "inv_misc_gem_ruby_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[28363] = {
	name = L["Inscribed Ornate Topaz"],
	quality = 4,
	icon = "inv_misc_gem_opal_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[29593] = {
	name = L["Insignia of the Alliance"],
	quality = 3,
	icon = "inv_jewelry_trinketpvp_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[31838] = {
	name = L["Major Combat Healing Potion"],
	quality = 1,
	icon = "inv_potion_40",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 61,
}
t[31839] = {
	name = L["Major Combat Healing Potion"],
	quality = 1,
	icon = "inv_potion_40",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 61,
}
t[31840] = {
	name = L["Major Combat Mana Potion"],
	quality = 1,
	icon = "inv_potion_82",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 61,
}
t[31841] = {
	name = L["Major Combat Mana Potion"],
	quality = 1,
	icon = "inv_potion_82",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 61,
}
t[31852] = {
	name = L["Major Combat Healing Potion"],
	quality = 1,
	icon = "inv_potion_40",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 61,
}
t[31853] = {
	name = L["Major Combat Healing Potion"],
	quality = 1,
	icon = "inv_potion_40",
	buyPrice = 4000,
	sellPrice = 1000,
	reqLevel = 61,
}
t[31854] = {
	name = L["Major Combat Mana Potion"],
	quality = 1,
	icon = "inv_potion_82",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 61,
}
t[31855] = {
	name = L["Major Combat Mana Potion"],
	quality = 1,
	icon = "inv_potion_82",
	buyPrice = 4000,
	sellPrice = 1000,
	reqLevel = 61,
}
t[32455] = {
	name = L["Star's Lament"],
	quality = 1,
	icon = "inv_drink_waterskin_02",
	buyPrice = 1200,
	sellPrice = 60,
	reqLevel = 55,
}
t[44957] = {
	name = L["Greater Inscription of the Gladiator"],
	quality = 4,
	icon = "inv_shoulder_61",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 70,
}
t[29465] = {
	name = L["Black Battlestrider"],
	quality = 4,
	icon = "ability_mount_blackbattlestrider",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 40,
}
t[29467] = {
	name = L["Black War Ram"],
	quality = 4,
	icon = "ability_mount_mountainram",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 40,
}
t[29468] = {
	name = L["Black War Steed Bridle"],
	quality = 4,
	icon = "ability_mount_nightmarehorse",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 40,
}
t[29471] = {
	name = L["Reins of the Black War Tiger"],
	quality = 4,
	icon = "ability_mount_blackpanther",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 40,
}
t[35906] = {
	name = L["Reins of the Black War Elekk"],
	quality = 4,
	icon = "ability_mount_ridingelekkelite_green",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 40,
}
t[12584] = {
	name = L["Grand Marshal's Longsword"],
	quality = 4,
	icon = "inv_sword_11",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[18825] = {
	name = L["Grand Marshal's Aegis"],
	quality = 4,
	icon = "inv_shield_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[18827] = {
	name = L["Grand Marshal's Handaxe"],
	quality = 4,
	icon = "inv_axe_24",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[18830] = {
	name = L["Grand Marshal's Sunderer"],
	quality = 4,
	icon = "inv_axe_10",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[18833] = {
	name = L["Grand Marshal's Bullseye"],
	quality = 4,
	icon = "inv_weapon_bow_12",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[18836] = {
	name = L["Grand Marshal's Repeater"],
	quality = 4,
	icon = "inv_weapon_crossbow_04",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[18838] = {
	name = L["Grand Marshal's Dirk"],
	quality = 4,
	icon = "inv_weapon_shortblade_26",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[18843] = {
	name = L["Grand Marshal's Right Hand Blade"],
	quality = 4,
	icon = "inv_weapon_shortblade_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[18847] = {
	name = L["Grand Marshal's Left Hand Blade"],
	quality = 4,
	icon = "ability_rogue_rupture",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[18855] = {
	name = L["Grand Marshal's Hand Cannon"],
	quality = 4,
	icon = "inv_weapon_rifle_08",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[18865] = {
	name = L["Grand Marshal's Punisher"],
	quality = 4,
	icon = "inv_mace_13",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[18867] = {
	name = L["Grand Marshal's Battle Hammer"],
	quality = 4,
	icon = "inv_hammer_03",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[18869] = {
	name = L["Grand Marshal's Glaive"],
	quality = 4,
	icon = "inv_spear_08",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[18873] = {
	name = L["Grand Marshal's Stave"],
	quality = 4,
	icon = "inv_staff_14",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[18876] = {
	name = L["Grand Marshal's Claymore"],
	quality = 4,
	icon = "inv_sword_39",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[23451] = {
	name = L["Grand Marshal's Mageblade"],
	quality = 4,
	icon = "inv_weapon_shortblade_26",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[23452] = {
	name = L["Grand Marshal's Tome of Power"],
	quality = 4,
	icon = "inv_misc_book_12",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[23453] = {
	name = L["Grand Marshal's Tome of Restoration"],
	quality = 4,
	icon = "inv_misc_book_13",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[23454] = {
	name = L["Grand Marshal's Warhammer"],
	quality = 4,
	icon = "inv_hammer_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[23455] = {
	name = L["Grand Marshal's Demolisher"],
	quality = 4,
	icon = "inv_hammer_23",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[23456] = {
	name = L["Grand Marshal's Swiftblade"],
	quality = 4,
	icon = "inv_sword_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[16342] = {
	name = L["Sergeant's Cape"],
	quality = 3,
	icon = "inv_misc_cape_21",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 58,
}
t[16437] = {
	name = L["Marshal's Silk Footwraps"],
	quality = 4,
	icon = "inv_boots_cloth_03",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[16440] = {
	name = L["Marshal's Silk Gloves"],
	quality = 4,
	icon = "inv_gauntlets_14",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[16441] = {
	name = L["Field Marshal's Coronet"],
	quality = 4,
	icon = "inv_helmet_24",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[16442] = {
	name = L["Marshal's Silk Leggings"],
	quality = 4,
	icon = "inv_pants_08",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[16443] = {
	name = L["Field Marshal's Silk Vestments"],
	quality = 4,
	icon = "inv_chest_cloth_12",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[16444] = {
	name = L["Field Marshal's Silk Spaulders"],
	quality = 4,
	icon = "inv_shoulder_23",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[16446] = {
	name = L["Marshal's Leather Footguards"],
	quality = 4,
	icon = "inv_boots_08",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[16448] = {
	name = L["Marshal's Dragonhide Gauntlets"],
	quality = 4,
	icon = "inv_gauntlets_21",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[16449] = {
	name = L["Field Marshal's Dragonhide Spaulders"],
	quality = 4,
	icon = "inv_shoulder_23",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[16450] = {
	name = L["Marshal's Dragonhide Legguards"],
	quality = 4,
	icon = "inv_pants_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[16451] = {
	name = L["Field Marshal's Dragonhide Helmet"],
	quality = 4,
	icon = "inv_helmet_41",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[16452] = {
	name = L["Field Marshal's Dragonhide Breastplate"],
	quality = 4,
	icon = "inv_chest_cloth_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[16453] = {
	name = L["Field Marshal's Leather Chestpiece"],
	quality = 4,
	icon = "inv_chest_cloth_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[16454] = {
	name = L["Marshal's Leather Handgrips"],
	quality = 4,
	icon = "inv_gauntlets_21",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[16455] = {
	name = L["Field Marshal's Leather Mask"],
	quality = 4,
	icon = "inv_helmet_41",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[16456] = {
	name = L["Marshal's Leather Leggings"],
	quality = 4,
	icon = "inv_pants_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[16457] = {
	name = L["Field Marshal's Leather Epaulets"],
	quality = 4,
	icon = "inv_shoulder_23",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[16459] = {
	name = L["Marshal's Dragonhide Boots"],
	quality = 4,
	icon = "inv_boots_08",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[16462] = {
	name = L["Marshal's Chain Boots"],
	quality = 4,
	icon = "inv_boots_plate_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[16463] = {
	name = L["Marshal's Chain Grips"],
	quality = 4,
	icon = "inv_gauntlets_10",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[16465] = {
	name = L["Field Marshal's Chain Helm"],
	quality = 4,
	icon = "inv_helmet_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[16466] = {
	name = L["Field Marshal's Chain Breastplate"],
	quality = 4,
	icon = "inv_chest_chain_03",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[16467] = {
	name = L["Marshal's Chain Legguards"],
	quality = 4,
	icon = "inv_pants_mail_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[16468] = {
	name = L["Field Marshal's Chain Spaulders"],
	quality = 4,
	icon = "inv_shoulder_10",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[16471] = {
	name = L["Marshal's Lamellar Gloves"],
	quality = 4,
	icon = "inv_gauntlets_29",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[16472] = {
	name = L["Marshal's Lamellar Boots"],
	quality = 4,
	icon = "inv_boots_plate_09",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[16473] = {
	name = L["Field Marshal's Lamellar Chestplate"],
	quality = 4,
	icon = "inv_chest_plate03",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[16474] = {
	name = L["Field Marshal's Lamellar Faceguard"],
	quality = 4,
	icon = "inv_helmet_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[16475] = {
	name = L["Marshal's Lamellar Legplates"],
	quality = 4,
	icon = "inv_pants_04",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[16476] = {
	name = L["Field Marshal's Lamellar Pauldrons"],
	quality = 4,
	icon = "inv_shoulder_20",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[16477] = {
	name = L["Field Marshal's Plate Armor"],
	quality = 4,
	icon = "inv_chest_plate03",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[16478] = {
	name = L["Field Marshal's Plate Helm"],
	quality = 4,
	icon = "inv_helmet_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[16479] = {
	name = L["Marshal's Plate Legguards"],
	quality = 4,
	icon = "inv_pants_04",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[16480] = {
	name = L["Field Marshal's Plate Shoulderguards"],
	quality = 4,
	icon = "inv_shoulder_20",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[16483] = {
	name = L["Marshal's Plate Boots"],
	quality = 4,
	icon = "inv_boots_plate_09",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[16484] = {
	name = L["Marshal's Plate Gauntlets"],
	quality = 4,
	icon = "inv_gauntlets_29",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[17578] = {
	name = L["Field Marshal's Coronal"],
	quality = 4,
	icon = "inv_helmet_24",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[17579] = {
	name = L["Marshal's Dreadweave Leggings"],
	quality = 4,
	icon = "inv_pants_cloth_09",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[17580] = {
	name = L["Field Marshal's Dreadweave Shoulders"],
	quality = 4,
	icon = "inv_shoulder_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[17581] = {
	name = L["Field Marshal's Dreadweave Robe"],
	quality = 4,
	icon = "inv_chest_cloth_09",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[17583] = {
	name = L["Marshal's Dreadweave Boots"],
	quality = 4,
	icon = "inv_boots_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[17584] = {
	name = L["Marshal's Dreadweave Gloves"],
	quality = 4,
	icon = "inv_gauntlets_14",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[17602] = {
	name = L["Field Marshal's Headdress"],
	quality = 4,
	icon = "inv_helmet_24",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[17603] = {
	name = L["Marshal's Satin Pants"],
	quality = 4,
	icon = "inv_pants_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[17604] = {
	name = L["Field Marshal's Satin Mantle"],
	quality = 4,
	icon = "inv_shoulder_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[17605] = {
	name = L["Field Marshal's Satin Vestments"],
	quality = 4,
	icon = "inv_chest_cloth_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[17607] = {
	name = L["Marshal's Satin Sandals"],
	quality = 4,
	icon = "inv_boots_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[17608] = {
	name = L["Marshal's Satin Gloves"],
	quality = 4,
	icon = "inv_gauntlets_14",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[18440] = {
	name = L["Sergeant's Cape"],
	quality = 3,
	icon = "inv_misc_cape_21",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 30,
}
t[18441] = {
	name = L["Sergeant's Cape"],
	quality = 3,
	icon = "inv_misc_cape_21",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 45,
}
t[18445] = {
	name = L["Sergeant Major's Plate Wristguards"],
	quality = 3,
	icon = "inv_bracer_18",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 58,
}
t[18447] = {
	name = L["Sergeant Major's Plate Wristguards"],
	quality = 3,
	icon = "inv_bracer_18",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 45,
}
t[18448] = {
	name = L["Sergeant Major's Chain Armguards"],
	quality = 3,
	icon = "inv_bracer_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 58,
}
t[18449] = {
	name = L["Sergeant Major's Chain Armguards"],
	quality = 3,
	icon = "inv_bracer_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 45,
}
t[18452] = {
	name = L["Sergeant Major's Leather Armsplints"],
	quality = 3,
	icon = "inv_bracer_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 58,
}
t[18453] = {
	name = L["Sergeant Major's Leather Armsplints"],
	quality = 3,
	icon = "inv_bracer_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 45,
}
t[18454] = {
	name = L["Sergeant Major's Dragonhide Armsplints"],
	quality = 3,
	icon = "inv_bracer_03",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 58,
}
t[18455] = {
	name = L["Sergeant Major's Dragonhide Armsplints"],
	quality = 3,
	icon = "inv_bracer_03",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 45,
}
t[18456] = {
	name = L["Sergeant Major's Silk Cuffs"],
	quality = 3,
	icon = "inv_bracer_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 58,
}
t[18457] = {
	name = L["Sergeant Major's Silk Cuffs"],
	quality = 3,
	icon = "inv_bracer_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 45,
}
t[23272] = {
	name = L["Knight-Captain's Lamellar Breastplate"],
	quality = 3,
	icon = "inv_chest_plate03",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[23273] = {
	name = L["Knight-Captain's Lamellar Leggings"],
	quality = 3,
	icon = "inv_pants_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[23274] = {
	name = L["Knight-Lieutenant's Lamellar Gauntlets"],
	quality = 3,
	icon = "inv_gauntlets_29",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[23275] = {
	name = L["Knight-Lieutenant's Lamellar Sabatons"],
	quality = 3,
	icon = "inv_boots_plate_03",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[23276] = {
	name = L["Lieutenant Commander's Lamellar Headguard"],
	quality = 3,
	icon = "inv_helmet_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[23277] = {
	name = L["Lieutenant Commander's Lamellar Shoulders"],
	quality = 3,
	icon = "inv_shoulder_28",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[23278] = {
	name = L["Knight-Lieutenant's Chain Greaves"],
	quality = 3,
	icon = "inv_boots_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[23279] = {
	name = L["Knight-Lieutenant's Chain Vices"],
	quality = 3,
	icon = "inv_gauntlets_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[23280] = {
	name = L["Knight-Lieutenant's Dragonhide Grips"],
	quality = 3,
	icon = "inv_gauntlets_25",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[23281] = {
	name = L["Knight-Lieutenant's Dragonhide Treads"],
	quality = 3,
	icon = "inv_boots_08",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[23282] = {
	name = L["Knight-Lieutenant's Dreadweave Handwraps"],
	quality = 3,
	icon = "inv_gauntlets_19",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[23283] = {
	name = L["Knight-Lieutenant's Dreadweave Walkers"],
	quality = 3,
	icon = "inv_boots_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[23284] = {
	name = L["Knight-Lieutenant's Leather Grips"],
	quality = 3,
	icon = "inv_gauntlets_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[23285] = {
	name = L["Knight-Lieutenant's Leather Walkers"],
	quality = 3,
	icon = "inv_boots_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[23286] = {
	name = L["Knight-Lieutenant's Plate Gauntlets"],
	quality = 3,
	icon = "inv_gauntlets_26",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[23287] = {
	name = L["Knight-Lieutenant's Plate Greaves"],
	quality = 3,
	icon = "inv_boots_plate_09",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[23288] = {
	name = L["Knight-Lieutenant's Satin Handwraps"],
	quality = 3,
	icon = "inv_gauntlets_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[23289] = {
	name = L["Knight-Lieutenant's Satin Walkers"],
	quality = 3,
	icon = "inv_boots_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[23290] = {
	name = L["Knight-Lieutenant's Silk Handwraps"],
	quality = 3,
	icon = "inv_gauntlets_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[23291] = {
	name = L["Knight-Lieutenant's Silk Walkers"],
	quality = 3,
	icon = "inv_boots_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[23292] = {
	name = L["Knight-Captain's Chain Hauberk"],
	quality = 3,
	icon = "inv_chest_chain_04",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[23293] = {
	name = L["Knight-Captain's Chain Legguards"],
	quality = 3,
	icon = "inv_pants_03",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[23294] = {
	name = L["Knight-Captain's Dragonhide Chestpiece"],
	quality = 3,
	icon = "inv_chest_leather_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[23295] = {
	name = L["Knight-Captain's Dragonhide Leggings"],
	quality = 3,
	icon = "inv_pants_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[23296] = {
	name = L["Knight-Captain's Dreadweave Legguards"],
	quality = 3,
	icon = "inv_pants_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[23297] = {
	name = L["Knight-Captain's Dreadweave Tunic"],
	quality = 3,
	icon = "inv_chest_leather_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[23298] = {
	name = L["Knight-Captain's Leather Chestpiece"],
	quality = 3,
	icon = "inv_chest_leather_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[23299] = {
	name = L["Knight-Captain's Leather Legguards"],
	quality = 3,
	icon = "inv_pants_08",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[23300] = {
	name = L["Knight-Captain's Plate Hauberk"],
	quality = 3,
	icon = "inv_chest_plate16",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[23301] = {
	name = L["Knight-Captain's Plate Leggings"],
	quality = 3,
	icon = "inv_pants_04",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[23302] = {
	name = L["Knight-Captain's Satin Legguards"],
	quality = 3,
	icon = "inv_pants_11",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[23303] = {
	name = L["Knight-Captain's Satin Tunic"],
	quality = 3,
	icon = "inv_chest_leather_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[23304] = {
	name = L["Knight-Captain's Silk Legguards"],
	quality = 3,
	icon = "inv_pants_11",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[23305] = {
	name = L["Knight-Captain's Silk Tunic"],
	quality = 3,
	icon = "inv_chest_cloth_28",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[23306] = {
	name = L["Lieutenant Commander's Chain Helm"],
	quality = 3,
	icon = "inv_helmet_21",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[23307] = {
	name = L["Lieutenant Commander's Chain Shoulders"],
	quality = 3,
	icon = "inv_shoulder_16",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[23308] = {
	name = L["Lieutenant Commander's Dragonhide Headguard"],
	quality = 3,
	icon = "inv_helmet_09",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[23309] = {
	name = L["Lieutenant Commander's Dragonhide Shoulders"],
	quality = 3,
	icon = "inv_shoulder_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[23310] = {
	name = L["Lieutenant Commander's Dreadweave Cowl"],
	quality = 3,
	icon = "inv_helmet_08",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[23311] = {
	name = L["Lieutenant Commander's Dreadweave Spaulders"],
	quality = 3,
	icon = "inv_shoulder_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[23312] = {
	name = L["Lieutenant Commander's Leather Helm"],
	quality = 3,
	icon = "inv_helmet_09",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[23313] = {
	name = L["Lieutenant Commander's Leather Shoulders"],
	quality = 3,
	icon = "inv_shoulder_14",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[23314] = {
	name = L["Lieutenant Commander's Plate Helmet"],
	quality = 3,
	icon = "inv_helmet_09",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[23315] = {
	name = L["Lieutenant Commander's Plate Shoulders"],
	quality = 3,
	icon = "inv_shoulder_11",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[23316] = {
	name = L["Lieutenant Commander's Satin Hood"],
	quality = 3,
	icon = "inv_helmet_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[23317] = {
	name = L["Lieutenant Commander's Satin Mantle"],
	quality = 3,
	icon = "inv_shoulder_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[23318] = {
	name = L["Lieutenant Commander's Silk Cowl"],
	quality = 3,
	icon = "inv_helmet_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[23319] = {
	name = L["Lieutenant Commander's Silk Mantle"],
	quality = 3,
	icon = "inv_shoulder_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[29594] = {
	name = L["Knight-Lieutenant's Mail Greaves"],
	quality = 3,
	icon = "inv_boots_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[29595] = {
	name = L["Knight-Lieutenant's Mail Vices"],
	quality = 3,
	icon = "inv_gauntlets_11",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[29596] = {
	name = L["Knight-Captain's Mail Hauberk"],
	quality = 3,
	icon = "inv_chest_chain_16",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[29597] = {
	name = L["Knight-Captain's Mail Legguards"],
	quality = 3,
	icon = "inv_pants_09",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[29598] = {
	name = L["Lieutenant Commander's Mail Headguard"],
	quality = 3,
	icon = "inv_helmet_09",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[29599] = {
	name = L["Lieutenant Commander's Mail Pauldrons"],
	quality = 3,
	icon = "inv_shoulder_04",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[29606] = {
	name = L["Marshal's Mail Boots"],
	quality = 4,
	icon = "inv_boots_plate_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[29607] = {
	name = L["Marshal's Mail Gauntlets"],
	quality = 4,
	icon = "inv_gauntlets_11",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[29608] = {
	name = L["Marshal's Mail Leggings"],
	quality = 4,
	icon = "inv_pants_mail_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[29609] = {
	name = L["Field Marshal's Mail Armor"],
	quality = 4,
	icon = "inv_chest_chain_11",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[29610] = {
	name = L["Field Marshal's Mail Helm"],
	quality = 4,
	icon = "inv_helmet_09",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[29611] = {
	name = L["Field Marshal's Mail Spaulders"],
	quality = 4,
	icon = "inv_shoulder_29",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[38579] = {
	name = L["Venomous Tome"],
	quality = 2,
	icon = "inv_misc_book_11",
	buyPrice = 4545,
	sellPrice = 1136,
	reqLevel = 20,
}
t[41559] = {
	name = L["Design: Mystic Sun Crystal"],
	quality = 2,
	icon = "inv_scroll_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[41560] = {
	name = L["Design: Stormy Chalcedony"],
	quality = 2,
	icon = "inv_scroll_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[41563] = {
	name = L["Design: Durable Huge Citrine"],
	quality = 2,
	icon = "inv_scroll_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[41564] = {
	name = L["Design: Empowered Huge Citrine"],
	quality = 2,
	icon = "inv_scroll_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[41565] = {
	name = L["Design: Lucent Huge Citrine"],
	quality = 2,
	icon = "inv_scroll_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[41566] = {
	name = L["Design: Resplendent Huge Citrine"],
	quality = 2,
	icon = "inv_scroll_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[41569] = {
	name = L["Design: Shattered Dark Jade"],
	quality = 2,
	icon = "inv_scroll_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[41570] = {
	name = L["Design: Tense Dark Jade"],
	quality = 2,
	icon = "inv_scroll_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[41571] = {
	name = L["Design: Turbid Dark Jade"],
	quality = 2,
	icon = "inv_scroll_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[41572] = {
	name = L["Design: Steady Dark Jade"],
	quality = 2,
	icon = "inv_scroll_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[41573] = {
	name = L["Design: Opaque Dark Jade"],
	quality = 2,
	icon = "inv_scroll_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[41575] = {
	name = L["Design: Mysterious Shadow Crystal"],
	quality = 2,
	icon = "inv_scroll_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[40879] = {
	name = L["Deadly Gladiator's Girdle of Triumph"],
	quality = 4,
	icon = "inv_belt_14",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40880] = {
	name = L["Deadly Gladiator's Greaves of Triumph"],
	quality = 4,
	icon = "inv_boots_plate_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40888] = {
	name = L["Deadly Gladiator's Bracers of Triumph"],
	quality = 4,
	icon = "inv_bracer_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40974] = {
	name = L["Deadly Gladiator's Girdle of Salvation"],
	quality = 4,
	icon = "inv_belt_12",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40975] = {
	name = L["Deadly Gladiator's Greaves of Salvation"],
	quality = 4,
	icon = "inv_boots_plate_08",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40982] = {
	name = L["Deadly Gladiator's Bracers of Salvation"],
	quality = 4,
	icon = "inv_bracer_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41048] = {
	name = L["Deadly Gladiator's Waistguard of Salvation"],
	quality = 4,
	icon = "inv_belt_13",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41054] = {
	name = L["Deadly Gladiator's Sabatons of Salvation"],
	quality = 4,
	icon = "inv_boots_plate_09",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41059] = {
	name = L["Deadly Gladiator's Wristguards of Salvation"],
	quality = 4,
	icon = "inv_bracer_18",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41064] = {
	name = L["Deadly Gladiator's Wristguards of Dominance"],
	quality = 4,
	icon = "inv_bracer_18",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41069] = {
	name = L["Deadly Gladiator's Waistguard of Dominance"],
	quality = 4,
	icon = "inv_belt_13",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41074] = {
	name = L["Deadly Gladiator's Sabatons of Dominance"],
	quality = 4,
	icon = "inv_boots_plate_09",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41224] = {
	name = L["Deadly Gladiator's Wristguards of Triumph"],
	quality = 4,
	icon = "inv_bracer_18",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41229] = {
	name = L["Deadly Gladiator's Sabatons of Triumph"],
	quality = 4,
	icon = "inv_boots_plate_09",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41234] = {
	name = L["Deadly Gladiator's Waistguard of Triumph"],
	quality = 4,
	icon = "inv_belt_13",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41616] = {
	name = L["Deadly Gladiator's Belt of Salvation"],
	quality = 4,
	icon = "inv_belt_12",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41620] = {
	name = L["Deadly Gladiator's Boots of Salvation"],
	quality = 4,
	icon = "inv_boots_cloth_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41624] = {
	name = L["Deadly Gladiator's Armwraps of Salvation"],
	quality = 4,
	icon = "inv_bracer_09",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41629] = {
	name = L["Deadly Gladiator's Belt of Dominance"],
	quality = 4,
	icon = "inv_belt_12",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41634] = {
	name = L["Deadly Gladiator's Boots of Dominance"],
	quality = 4,
	icon = "inv_boots_cloth_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41639] = {
	name = L["Deadly Gladiator's Armwraps of Dominance"],
	quality = 4,
	icon = "inv_bracer_09",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41831] = {
	name = L["Deadly Gladiator's Belt of Triumph"],
	quality = 4,
	icon = "inv_belt_12",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41835] = {
	name = L["Deadly Gladiator's Boots of Triumph"],
	quality = 4,
	icon = "inv_boots_cloth_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41839] = {
	name = L["Deadly Gladiator's Armwraps of Triumph"],
	quality = 4,
	icon = "inv_bracer_09",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41880] = {
	name = L["Deadly Gladiator's Cord of Salvation"],
	quality = 4,
	icon = "inv_belt_13",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41884] = {
	name = L["Deadly Gladiator's Treads of Salvation"],
	quality = 4,
	icon = "inv_boots_cloth_12",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41892] = {
	name = L["Deadly Gladiator's Cuffs of Salvation"],
	quality = 4,
	icon = "inv_bracer_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41897] = {
	name = L["Deadly Gladiator's Cord of Dominance"],
	quality = 4,
	icon = "inv_belt_13",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41902] = {
	name = L["Deadly Gladiator's Treads of Dominance"],
	quality = 4,
	icon = "inv_boots_cloth_12",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41908] = {
	name = L["Deadly Gladiator's Cuffs of Dominance"],
	quality = 4,
	icon = "inv_bracer_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[42027] = {
	name = L["Deadly Gladiator's Pendant of Triumph"],
	quality = 4,
	icon = "inv_jewelry_necklace_36",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[42028] = {
	name = L["Deadly Gladiator's Pendant of Victory"],
	quality = 4,
	icon = "inv_jewelry_necklace_36",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[42029] = {
	name = L["Deadly Gladiator's Pendant of Dominance"],
	quality = 4,
	icon = "inv_jewelry_necklace_36",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[42030] = {
	name = L["Deadly Gladiator's Pendant of Ascendancy"],
	quality = 4,
	icon = "inv_jewelry_necklace_36",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[42031] = {
	name = L["Deadly Gladiator's Pendant of Subjugation"],
	quality = 4,
	icon = "inv_jewelry_necklace_36",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[42032] = {
	name = L["Deadly Gladiator's Pendant of Deliverance"],
	quality = 4,
	icon = "inv_jewelry_necklace_36",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[42033] = {
	name = L["Deadly Gladiator's Pendant of Salvation"],
	quality = 4,
	icon = "inv_jewelry_necklace_36",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[42062] = {
	name = L["Deadly Gladiator's Cloak of Dominance"],
	quality = 4,
	icon = "inv_misc_cape_19",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[42063] = {
	name = L["Deadly Gladiator's Cloak of Subjugation"],
	quality = 4,
	icon = "inv_misc_cape_19",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[42064] = {
	name = L["Deadly Gladiator's Cloak of Ascendancy"],
	quality = 4,
	icon = "inv_misc_cape_19",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[42065] = {
	name = L["Deadly Gladiator's Cloak of Salvation"],
	quality = 4,
	icon = "inv_misc_cape_19",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[42066] = {
	name = L["Deadly Gladiator's Cloak of Deliverance"],
	quality = 4,
	icon = "inv_misc_cape_19",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[42067] = {
	name = L["Deadly Gladiator's Cloak of Triumph"],
	quality = 4,
	icon = "inv_misc_cape_19",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[42068] = {
	name = L["Deadly Gladiator's Cloak of Victory"],
	quality = 4,
	icon = "inv_misc_cape_19",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[42110] = {
	name = L["Hateful Gladiator's Band of Dominance"],
	quality = 4,
	icon = "inv_jewelry_ring_60",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[42112] = {
	name = L["Hateful Gladiator's Band of Triumph"],
	quality = 4,
	icon = "inv_jewelry_ring_60",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[42114] = {
	name = L["Deadly Gladiator's Band of Ascendancy"],
	quality = 4,
	icon = "inv_jewelry_ring_60",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[42115] = {
	name = L["Deadly Gladiator's Band of Victory"],
	quality = 4,
	icon = "inv_jewelry_ring_60",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[42123] = {
	name = L["Medallion of the Alliance"],
	quality = 4,
	icon = "inv_jewelry_necklace_37",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[42128] = {
	name = L["Battlemaster's Hostility"],
	quality = 4,
	icon = "ability_warrior_endlessrage",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[42129] = {
	name = L["Battlemaster's Accuracy"],
	quality = 4,
	icon = "ability_warrior_endlessrage",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[42130] = {
	name = L["Battlemaster's Avidity"],
	quality = 4,
	icon = "ability_warrior_endlessrage",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[42131] = {
	name = L["Battlemaster's Conviction"],
	quality = 4,
	icon = "ability_warrior_endlessrage",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[42132] = {
	name = L["Battlemaster's Bravery"],
	quality = 4,
	icon = "ability_warrior_endlessrage",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40877] = {
	name = L["Hateful Gladiator's Girdle of Triumph"],
	quality = 4,
	icon = "inv_belt_14",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40878] = {
	name = L["Hateful Gladiator's Greaves of Triumph"],
	quality = 4,
	icon = "inv_boots_plate_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40887] = {
	name = L["Hateful Gladiator's Bracers of Triumph"],
	quality = 4,
	icon = "inv_bracer_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40966] = {
	name = L["Hateful Gladiator's Girdle of Salvation"],
	quality = 4,
	icon = "inv_belt_12",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40972] = {
	name = L["Hateful Gladiator's Bracers of Salvation"],
	quality = 4,
	icon = "inv_bracer_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[40973] = {
	name = L["Hateful Gladiator's Greaves of Salvation"],
	quality = 4,
	icon = "inv_boots_plate_08",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41047] = {
	name = L["Hateful Gladiator's Wristguards of Salvation"],
	quality = 4,
	icon = "inv_bracer_18",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41049] = {
	name = L["Hateful Gladiator's Sabatons of Salvation"],
	quality = 4,
	icon = "inv_boots_plate_09",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41050] = {
	name = L["Hateful Gladiator's Waistguard of Salvation"],
	quality = 4,
	icon = "inv_belt_13",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41063] = {
	name = L["Hateful Gladiator's Wristguards of Dominance"],
	quality = 4,
	icon = "inv_bracer_18",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41068] = {
	name = L["Hateful Gladiator's Waistguard of Dominance"],
	quality = 4,
	icon = "inv_belt_13",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41073] = {
	name = L["Hateful Gladiator's Sabatons of Dominance"],
	quality = 4,
	icon = "inv_boots_plate_09",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41223] = {
	name = L["Hateful Gladiator's Wristguards of Triumph"],
	quality = 4,
	icon = "inv_bracer_18",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41228] = {
	name = L["Hateful Gladiator's Sabatons of Triumph"],
	quality = 4,
	icon = "inv_boots_plate_09",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41233] = {
	name = L["Hateful Gladiator's Waistguard of Triumph"],
	quality = 4,
	icon = "inv_belt_13",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41330] = {
	name = L["Hateful Gladiator's Belt of Salvation"],
	quality = 4,
	icon = "inv_belt_12",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41331] = {
	name = L["Hateful Gladiator's Boots of Salvation"],
	quality = 4,
	icon = "inv_boots_cloth_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41332] = {
	name = L["Hateful Gladiator's Armwraps of Salvation"],
	quality = 4,
	icon = "inv_bracer_09",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41628] = {
	name = L["Hateful Gladiator's Belt of Dominance"],
	quality = 4,
	icon = "inv_belt_12",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41633] = {
	name = L["Hateful Gladiator's Boots of Dominance"],
	quality = 4,
	icon = "inv_boots_cloth_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41638] = {
	name = L["Hateful Gladiator's Armwraps of Dominance"],
	quality = 4,
	icon = "inv_bracer_09",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41827] = {
	name = L["Hateful Gladiator's Belt of Triumph"],
	quality = 4,
	icon = "inv_belt_12",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41828] = {
	name = L["Hateful Gladiator's Boots of Triumph"],
	quality = 4,
	icon = "inv_boots_cloth_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41830] = {
	name = L["Hateful Gladiator's Armwraps of Triumph"],
	quality = 4,
	icon = "inv_bracer_09",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41877] = {
	name = L["Hateful Gladiator's Cord of Salvation"],
	quality = 4,
	icon = "inv_belt_13",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41878] = {
	name = L["Hateful Gladiator's Cuffs of Salvation"],
	quality = 4,
	icon = "inv_bracer_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41879] = {
	name = L["Hateful Gladiator's Slippers of Salvation"],
	quality = 4,
	icon = "inv_boots_cloth_12",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41896] = {
	name = L["Hateful Gladiator's Cord of Dominance"],
	quality = 4,
	icon = "inv_belt_13",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41901] = {
	name = L["Hateful Gladiator's Slippers of Dominance"],
	quality = 4,
	icon = "inv_boots_cloth_12",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[41907] = {
	name = L["Hateful Gladiator's Cuffs of Dominance"],
	quality = 4,
	icon = "inv_bracer_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[42020] = {
	name = L["Hateful Gladiator's Pendant of Triumph"],
	quality = 4,
	icon = "inv_jewelry_necklace_36",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[42021] = {
	name = L["Hateful Gladiator's Pendant of Victory"],
	quality = 4,
	icon = "inv_jewelry_necklace_36",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[42022] = {
	name = L["Hateful Gladiator's Pendant of Dominance"],
	quality = 4,
	icon = "inv_jewelry_necklace_36",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[42023] = {
	name = L["Hateful Gladiator's Pendant of Subjugation"],
	quality = 4,
	icon = "inv_jewelry_necklace_36",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[42024] = {
	name = L["Hateful Gladiator's Pendant of Ascendancy"],
	quality = 4,
	icon = "inv_jewelry_necklace_36",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[42025] = {
	name = L["Hateful Gladiator's Pendant of Deliverance"],
	quality = 4,
	icon = "inv_jewelry_necklace_36",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[42026] = {
	name = L["Hateful Gladiator's Pendant of Salvation"],
	quality = 4,
	icon = "inv_jewelry_necklace_36",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[42055] = {
	name = L["Hateful Gladiator's Cloak of Dominance"],
	quality = 4,
	icon = "inv_misc_cape_19",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[42056] = {
	name = L["Hateful Gladiator's Cloak of Subjugation"],
	quality = 4,
	icon = "inv_misc_cape_19",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[42057] = {
	name = L["Hateful Gladiator's Cloak of Ascendancy"],
	quality = 4,
	icon = "inv_misc_cape_19",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[42058] = {
	name = L["Hateful Gladiator's Cloak of Salvation"],
	quality = 4,
	icon = "inv_misc_cape_19",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[42059] = {
	name = L["Hateful Gladiator's Cloak of Deliverance"],
	quality = 4,
	icon = "inv_misc_cape_19",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[42060] = {
	name = L["Hateful Gladiator's Cloak of Triumph"],
	quality = 4,
	icon = "inv_misc_cape_19",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[42061] = {
	name = L["Hateful Gladiator's Cloak of Victory"],
	quality = 4,
	icon = "inv_misc_cape_19",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[5643] = {
	name = L["Recipe: Great Rage Potion"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 2000,
	sellPrice = 500,
	reqLevel = 0,
	profession = L["Alchemy"],
	teaches = L["Great Rage Potion"],
	learnedAt = 175,
}
t[5642] = {
	name = L["Recipe: Free Action Potion"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 1800,
	sellPrice = 450,
	reqLevel = 0,
	profession = L["Alchemy"],
	teaches = L["Free Action Potion"],
	learnedAt = 150,
}
t[13478] = {
	name = L["Recipe: Elixir of Superior Defense"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 13000,
	sellPrice = 3250,
	reqLevel = 0,
	profession = L["Alchemy"],
	teaches = L["Elixir of Superior Defense"],
	learnedAt = 265,
}
t[6523] = {
	name = L["Buckled Harness"],
	quality = 1,
	icon = "inv_chest_leather_01",
	buyPrice = 1422,
	sellPrice = 284,
	reqLevel = 12,
}
t[6524] = {
	name = L["Studded Leather Harness"],
	quality = 1,
	icon = "inv_chest_leather_01",
	buyPrice = 2871,
	sellPrice = 574,
	reqLevel = 17,
}
t[6525] = {
	name = L["Grunt's Harness"],
	quality = 1,
	icon = "inv_chest_leather_01",
	buyPrice = 5168,
	sellPrice = 1033,
	reqLevel = 22,
}
t[6526] = {
	name = L["Battle Harness"],
	quality = 1,
	icon = "inv_chest_leather_04",
	buyPrice = 12487,
	sellPrice = 2497,
	reqLevel = 32,
}
t[1132] = {
	name = L["Horn of the Timber Wolf"],
	quality = 3,
	icon = "ability_mount_blackdirewolf",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 20,
}
t[5665] = {
	name = L["Horn of the Dire Wolf"],
	quality = 3,
	icon = "ability_mount_whitedirewolf",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 20,
}
t[5668] = {
	name = L["Horn of the Brown Wolf"],
	quality = 3,
	icon = "ability_mount_blackdirewolf",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 20,
}
t[18796] = {
	name = L["Horn of the Swift Brown Wolf"],
	quality = 4,
	icon = "ability_mount_blackdirewolf",
	buyPrice = 100000,
	sellPrice = 25000,
	reqLevel = 40,
}
t[18797] = {
	name = L["Horn of the Swift Timber Wolf"],
	quality = 4,
	icon = "ability_mount_whitedirewolf",
	buyPrice = 100000,
	sellPrice = 25000,
	reqLevel = 40,
}
t[18798] = {
	name = L["Horn of the Swift Gray Wolf"],
	quality = 4,
	icon = "ability_mount_whitedirewolf",
	buyPrice = 100000,
	sellPrice = 25000,
	reqLevel = 40,
}
t[46099] = {
	name = L["Horn of the Black Wolf"],
	quality = 3,
	icon = "ability_mount_blackdirewolf",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 20,
}
t[10314] = {
	name = L["Pattern: Lavender Mageweave Shirt"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 4000,
	sellPrice = 1000,
	reqLevel = 0,
	profession = L["Tailoring"],
	teaches = L["Lavender Mageweave Shirt"],
	learnedAt = 230,
}
t[10317] = {
	name = L["Pattern: Pink Mageweave Shirt"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 4000,
	sellPrice = 1000,
	reqLevel = 0,
	profession = L["Tailoring"],
	teaches = L["Pink Mageweave Shirt"],
	learnedAt = 235,
}
t[18731] = {
	name = L["Pattern: Heavy Leather Ball"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 2000,
	sellPrice = 500,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Heavy Leather Ball"],
	learnedAt = 150,
}
t[18647] = {
	name = L["Schematic: Red Firework"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 1800,
	sellPrice = 450,
	reqLevel = 0,
	profession = L["Engineering"],
	teaches = L["Red Firework"],
	learnedAt = 150,
}
t[22729] = {
	name = L["Schematic: Steam Tonk Controller"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 8000,
	sellPrice = 2000,
	reqLevel = 0,
	profession = L["Engineering"],
	teaches = L["Steam Tonk Controller"],
	learnedAt = 275,
}
t[15197] = {
	name = L["Scout's Tabard"],
	quality = 1,
	icon = "inv_misc_tabardpvp_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[15199] = {
	name = L["Stone Guard's Herald"],
	quality = 1,
	icon = "inv_misc_tabardpvp_04",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[10360] = {
	name = L["Black Kingsnake"],
	quality = 1,
	icon = "spell_nature_guardianward",
	buyPrice = 5000,
	sellPrice = 1250,
	reqLevel = 0,
}
t[10361] = {
	name = L["Brown Snake"],
	quality = 1,
	icon = "spell_nature_guardianward",
	buyPrice = 5000,
	sellPrice = 1250,
	reqLevel = 0,
}
t[15200] = {
	name = L["Senior Sergeant's Insignia"],
	quality = 3,
	icon = "inv_misc_monsterscales_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 30,
}
t[16335] = {
	name = L["Senior Sergeant's Insignia"],
	quality = 3,
	icon = "inv_misc_monsterscales_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 58,
}
t[18428] = {
	name = L["Senior Sergeant's Insignia"],
	quality = 3,
	icon = "inv_misc_monsterscales_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 45,
}
t[18607] = {
	name = L["Horde Battle Standard"],
	quality = 1,
	icon = "inv_bannerpvp_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[18834] = {
	name = L["Insignia of the Horde"],
	quality = 3,
	icon = "inv_jewelry_trinketpvp_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[18845] = {
	name = L["Insignia of the Horde"],
	quality = 3,
	icon = "inv_jewelry_trinketpvp_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[18846] = {
	name = L["Insignia of the Horde"],
	quality = 3,
	icon = "inv_jewelry_trinketpvp_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[18849] = {
	name = L["Insignia of the Horde"],
	quality = 3,
	icon = "inv_jewelry_trinketpvp_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[18850] = {
	name = L["Insignia of the Horde"],
	quality = 3,
	icon = "inv_jewelry_trinketpvp_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[18851] = {
	name = L["Insignia of the Horde"],
	quality = 3,
	icon = "inv_jewelry_trinketpvp_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[18852] = {
	name = L["Insignia of the Horde"],
	quality = 3,
	icon = "inv_jewelry_trinketpvp_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[18853] = {
	name = L["Insignia of the Horde"],
	quality = 3,
	icon = "inv_jewelry_trinketpvp_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[29592] = {
	name = L["Insignia of the Horde"],
	quality = 3,
	icon = "inv_jewelry_trinketpvp_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 0,
}
t[16345] = {
	name = L["High Warlord's Blade"],
	quality = 4,
	icon = "inv_sword_11",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[18826] = {
	name = L["High Warlord's Shield Wall"],
	quality = 4,
	icon = "inv_shield_19",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[18828] = {
	name = L["High Warlord's Cleaver"],
	quality = 4,
	icon = "inv_axe_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[18831] = {
	name = L["High Warlord's Battle Axe"],
	quality = 4,
	icon = "inv_axe_21",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[18835] = {
	name = L["High Warlord's Recurve"],
	quality = 4,
	icon = "inv_weapon_bow_08",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[18837] = {
	name = L["High Warlord's Crossbow"],
	quality = 4,
	icon = "inv_weapon_crossbow_10",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[18840] = {
	name = L["High Warlord's Razor"],
	quality = 4,
	icon = "inv_weapon_shortblade_13",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[18844] = {
	name = L["High Warlord's Right Claw"],
	quality = 4,
	icon = "inv_misc_monsterclaw_03",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[18848] = {
	name = L["High Warlord's Left Claw"],
	quality = 4,
	icon = "inv_misc_monsterclaw_04",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[18860] = {
	name = L["High Warlord's Street Sweeper"],
	quality = 4,
	icon = "inv_weapon_rifle_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[18866] = {
	name = L["High Warlord's Bludgeon"],
	quality = 4,
	icon = "inv_hammer_20",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[18868] = {
	name = L["High Warlord's Pulverizer"],
	quality = 4,
	icon = "inv_hammer_10",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[18871] = {
	name = L["High Warlord's Pig Sticker"],
	quality = 4,
	icon = "inv_spear_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[18874] = {
	name = L["High Warlord's War Staff"],
	quality = 4,
	icon = "inv_misc_bone_elfskull_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[18877] = {
	name = L["High Warlord's Greatsword"],
	quality = 4,
	icon = "inv_sword_48",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[23464] = {
	name = L["High Warlord's Battle Mace"],
	quality = 4,
	icon = "inv_hammer_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[23465] = {
	name = L["High Warlord's Destroyer"],
	quality = 4,
	icon = "inv_mace_09",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[23466] = {
	name = L["High Warlord's Spellblade"],
	quality = 4,
	icon = "inv_weapon_shortblade_26",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[23467] = {
	name = L["High Warlord's Quickblade"],
	quality = 4,
	icon = "inv_sword_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[23468] = {
	name = L["High Warlord's Tome of Destruction"],
	quality = 4,
	icon = "inv_misc_book_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[23469] = {
	name = L["High Warlord's Tome of Mending"],
	quality = 4,
	icon = "inv_misc_book_14",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[22874] = {
	name = L["Legionnaire's Chain Hauberk"],
	quality = 3,
	icon = "inv_chest_chain_04",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[22875] = {
	name = L["Legionnaire's Chain Legguards"],
	quality = 3,
	icon = "inv_pants_03",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[22862] = {
	name = L["Blood Guard's Chain Vices"],
	quality = 3,
	icon = "inv_gauntlets_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[16341] = {
	name = L["Sergeant's Cloak"],
	quality = 3,
	icon = "inv_misc_cape_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 45,
}
t[16486] = {
	name = L["First Sergeant's Silk Cuffs"],
	quality = 3,
	icon = "inv_bracer_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 58,
}
t[16497] = {
	name = L["First Sergeant's Leather Armguards"],
	quality = 3,
	icon = "inv_bracer_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 58,
}
t[16532] = {
	name = L["First Sergeant's Mail Wristguards"],
	quality = 3,
	icon = "inv_bracer_16",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 58,
}
t[16533] = {
	name = L["Warlord's Silk Cowl"],
	quality = 4,
	icon = "inv_helmet_08",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[16534] = {
	name = L["General's Silk Trousers"],
	quality = 4,
	icon = "inv_pants_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[16535] = {
	name = L["Warlord's Silk Raiment"],
	quality = 4,
	icon = "inv_chest_leather_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[16536] = {
	name = L["Warlord's Silk Amice"],
	quality = 4,
	icon = "inv_shoulder_19",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[16539] = {
	name = L["General's Silk Boots"],
	quality = 4,
	icon = "inv_boots_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[16540] = {
	name = L["General's Silk Handguards"],
	quality = 4,
	icon = "inv_gauntlets_19",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[16541] = {
	name = L["Warlord's Plate Armor"],
	quality = 4,
	icon = "inv_chest_plate16",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[16542] = {
	name = L["Warlord's Plate Headpiece"],
	quality = 4,
	icon = "inv_helmet_09",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[16543] = {
	name = L["General's Plate Leggings"],
	quality = 4,
	icon = "inv_pants_04",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[16544] = {
	name = L["Warlord's Plate Shoulders"],
	quality = 4,
	icon = "inv_shoulder_11",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[16545] = {
	name = L["General's Plate Boots"],
	quality = 4,
	icon = "inv_boots_plate_04",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[16548] = {
	name = L["General's Plate Gauntlets"],
	quality = 4,
	icon = "inv_gauntlets_10",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[16549] = {
	name = L["Warlord's Dragonhide Hauberk"],
	quality = 4,
	icon = "inv_chest_chain_16",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[16550] = {
	name = L["Warlord's Dragonhide Helmet"],
	quality = 4,
	icon = "inv_helmet_09",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[16551] = {
	name = L["Warlord's Dragonhide Epaulets"],
	quality = 4,
	icon = "inv_shoulder_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[16552] = {
	name = L["General's Dragonhide Leggings"],
	quality = 4,
	icon = "inv_pants_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[16554] = {
	name = L["General's Dragonhide Boots"],
	quality = 4,
	icon = "inv_boots_08",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[16555] = {
	name = L["General's Dragonhide Gloves"],
	quality = 4,
	icon = "inv_gauntlets_25",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[16558] = {
	name = L["General's Leather Treads"],
	quality = 4,
	icon = "inv_boots_08",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[16560] = {
	name = L["General's Leather Mitts"],
	quality = 4,
	icon = "inv_gauntlets_25",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[16561] = {
	name = L["Warlord's Leather Helm"],
	quality = 4,
	icon = "inv_helmet_09",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[16562] = {
	name = L["Warlord's Leather Spaulders"],
	quality = 4,
	icon = "inv_shoulder_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[16563] = {
	name = L["Warlord's Leather Breastplate"],
	quality = 4,
	icon = "inv_chest_chain_16",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[16564] = {
	name = L["General's Leather Legguards"],
	quality = 4,
	icon = "inv_pants_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[16565] = {
	name = L["Warlord's Chain Chestpiece"],
	quality = 4,
	icon = "inv_chest_chain_11",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[16566] = {
	name = L["Warlord's Chain Helmet"],
	quality = 4,
	icon = "inv_helmet_09",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[16567] = {
	name = L["General's Chain Legguards"],
	quality = 4,
	icon = "inv_pants_mail_16",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[16568] = {
	name = L["Warlord's Chain Shoulders"],
	quality = 4,
	icon = "inv_shoulder_29",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[16569] = {
	name = L["General's Chain Boots"],
	quality = 4,
	icon = "inv_boots_plate_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[16571] = {
	name = L["General's Chain Gloves"],
	quality = 4,
	icon = "inv_gauntlets_11",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[16573] = {
	name = L["General's Mail Boots"],
	quality = 4,
	icon = "inv_boots_plate_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[16574] = {
	name = L["General's Mail Gauntlets"],
	quality = 4,
	icon = "inv_gauntlets_11",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[16577] = {
	name = L["Warlord's Mail Armor"],
	quality = 4,
	icon = "inv_chest_chain_11",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[16578] = {
	name = L["Warlord's Mail Helm"],
	quality = 4,
	icon = "inv_helmet_09",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[16579] = {
	name = L["General's Mail Leggings"],
	quality = 4,
	icon = "inv_pants_mail_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[16580] = {
	name = L["Warlord's Mail Spaulders"],
	quality = 4,
	icon = "inv_shoulder_29",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[17586] = {
	name = L["General's Dreadweave Boots"],
	quality = 4,
	icon = "inv_boots_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[17588] = {
	name = L["General's Dreadweave Gloves"],
	quality = 4,
	icon = "inv_gauntlets_19",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[17590] = {
	name = L["Warlord's Dreadweave Mantle"],
	quality = 4,
	icon = "inv_shoulder_19",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[17591] = {
	name = L["Warlord's Dreadweave Hood"],
	quality = 4,
	icon = "inv_helmet_08",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[17592] = {
	name = L["Warlord's Dreadweave Robe"],
	quality = 4,
	icon = "inv_chest_leather_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[17593] = {
	name = L["General's Dreadweave Pants"],
	quality = 4,
	icon = "inv_pants_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[17618] = {
	name = L["General's Satin Boots"],
	quality = 4,
	icon = "inv_boots_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[17620] = {
	name = L["General's Satin Gloves"],
	quality = 4,
	icon = "inv_gauntlets_27",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[17622] = {
	name = L["Warlord's Satin Mantle"],
	quality = 4,
	icon = "inv_shoulder_19",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[17623] = {
	name = L["Warlord's Satin Cowl"],
	quality = 4,
	icon = "inv_helmet_08",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[17624] = {
	name = L["Warlord's Satin Robes"],
	quality = 4,
	icon = "inv_chest_leather_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[17625] = {
	name = L["General's Satin Leggings"],
	quality = 4,
	icon = "inv_pants_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[18427] = {
	name = L["Sergeant's Cloak"],
	quality = 3,
	icon = "inv_misc_cape_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 30,
}
t[18429] = {
	name = L["First Sergeant's Plate Bracers"],
	quality = 3,
	icon = "inv_bracer_19",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 58,
}
t[18430] = {
	name = L["First Sergeant's Plate Bracers"],
	quality = 3,
	icon = "inv_bracer_19",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 45,
}
t[18432] = {
	name = L["First Sergeant's Mail Wristguards"],
	quality = 3,
	icon = "inv_bracer_16",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 45,
}
t[18434] = {
	name = L["First Sergeant's Dragonhide Armguards"],
	quality = 3,
	icon = "inv_bracer_03",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 58,
}
t[18435] = {
	name = L["First Sergeant's Leather Armguards"],
	quality = 3,
	icon = "inv_bracer_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 45,
}
t[18436] = {
	name = L["First Sergeant's Dragonhide Armguards"],
	quality = 3,
	icon = "inv_bracer_03",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 45,
}
t[18437] = {
	name = L["First Sergeant's Silk Cuffs"],
	quality = 3,
	icon = "inv_bracer_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 45,
}
t[18461] = {
	name = L["Sergeant's Cloak"],
	quality = 3,
	icon = "inv_misc_cape_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 58,
}
t[22843] = {
	name = L["Blood Guard's Chain Greaves"],
	quality = 3,
	icon = "inv_boots_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[22852] = {
	name = L["Blood Guard's Dragonhide Treads"],
	quality = 3,
	icon = "inv_boots_08",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[22855] = {
	name = L["Blood Guard's Dreadweave Walkers"],
	quality = 3,
	icon = "inv_boots_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[22856] = {
	name = L["Blood Guard's Leather Walkers"],
	quality = 3,
	icon = "inv_boots_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[22857] = {
	name = L["Blood Guard's Mail Greaves"],
	quality = 3,
	icon = "inv_boots_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[22858] = {
	name = L["Blood Guard's Plate Greaves"],
	quality = 3,
	icon = "inv_boots_plate_09",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[22859] = {
	name = L["Blood Guard's Satin Walkers"],
	quality = 3,
	icon = "inv_boots_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[22860] = {
	name = L["Blood Guard's Silk Walkers"],
	quality = 3,
	icon = "inv_boots_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[22863] = {
	name = L["Blood Guard's Dragonhide Grips"],
	quality = 3,
	icon = "inv_gauntlets_25",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[22864] = {
	name = L["Blood Guard's Leather Grips"],
	quality = 3,
	icon = "inv_gauntlets_15",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[22865] = {
	name = L["Blood Guard's Dreadweave Handwraps"],
	quality = 3,
	icon = "inv_gauntlets_19",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[22867] = {
	name = L["Blood Guard's Mail Vices"],
	quality = 3,
	icon = "inv_gauntlets_11",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[22868] = {
	name = L["Blood Guard's Plate Gauntlets"],
	quality = 3,
	icon = "inv_gauntlets_26",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[22869] = {
	name = L["Blood Guard's Satin Handwraps"],
	quality = 3,
	icon = "inv_gauntlets_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[22870] = {
	name = L["Blood Guard's Silk Handwraps"],
	quality = 3,
	icon = "inv_gauntlets_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[22872] = {
	name = L["Legionnaire's Plate Hauberk"],
	quality = 3,
	icon = "inv_chest_plate16",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[22873] = {
	name = L["Legionnaire's Plate Leggings"],
	quality = 3,
	icon = "inv_pants_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[22876] = {
	name = L["Legionnaire's Mail Hauberk"],
	quality = 3,
	icon = "inv_chest_chain_16",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[22877] = {
	name = L["Legionnaire's Dragonhide Chestpiece"],
	quality = 3,
	icon = "inv_chest_leather_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[22878] = {
	name = L["Legionnaire's Dragonhide Leggings"],
	quality = 3,
	icon = "inv_pants_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[22879] = {
	name = L["Legionnaire's Leather Chestpiece"],
	quality = 3,
	icon = "inv_chest_leather_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[22880] = {
	name = L["Legionnaire's Leather Legguards"],
	quality = 3,
	icon = "inv_pants_08",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[22881] = {
	name = L["Legionnaire's Dreadweave Legguards"],
	quality = 3,
	icon = "inv_pants_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[22882] = {
	name = L["Legionnaire's Satin Legguards"],
	quality = 3,
	icon = "inv_pants_11",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[22883] = {
	name = L["Legionnaire's Silk Legguards"],
	quality = 3,
	icon = "inv_pants_11",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[22884] = {
	name = L["Legionnaire's Dreadweave Tunic"],
	quality = 3,
	icon = "inv_chest_leather_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[22885] = {
	name = L["Legionnaire's Satin Tunic"],
	quality = 3,
	icon = "inv_chest_leather_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[22886] = {
	name = L["Legionnaire's Silk Tunic"],
	quality = 3,
	icon = "inv_chest_cloth_28",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[22887] = {
	name = L["Legionnaire's Mail Legguards"],
	quality = 3,
	icon = "inv_pants_09",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[23243] = {
	name = L["Champion's Plate Shoulders"],
	quality = 3,
	icon = "inv_shoulder_11",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[23244] = {
	name = L["Champion's Plate Helm"],
	quality = 3,
	icon = "inv_helmet_09",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[23251] = {
	name = L["Champion's Chain Helm"],
	quality = 3,
	icon = "inv_helmet_03",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[23252] = {
	name = L["Champion's Chain Shoulders"],
	quality = 3,
	icon = "inv_shoulder_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[23253] = {
	name = L["Champion's Dragonhide Headguard"],
	quality = 3,
	icon = "inv_helmet_09",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[23254] = {
	name = L["Champion's Dragonhide Shoulders"],
	quality = 3,
	icon = "inv_shoulder_07",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[23255] = {
	name = L["Champion's Dreadweave Cowl"],
	quality = 3,
	icon = "inv_helmet_08",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[23256] = {
	name = L["Champion's Dreadweave Spaulders"],
	quality = 3,
	icon = "inv_shoulder_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[23257] = {
	name = L["Champion's Leather Helm"],
	quality = 3,
	icon = "inv_helmet_09",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[23258] = {
	name = L["Champion's Leather Shoulders"],
	quality = 3,
	icon = "inv_shoulder_14",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[23259] = {
	name = L["Champion's Mail Headguard"],
	quality = 3,
	icon = "inv_helmet_09",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[23260] = {
	name = L["Champion's Mail Pauldrons"],
	quality = 3,
	icon = "inv_shoulder_04",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[23261] = {
	name = L["Champion's Satin Hood"],
	quality = 3,
	icon = "inv_helmet_17",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[23262] = {
	name = L["Champion's Satin Mantle"],
	quality = 3,
	icon = "inv_shoulder_01",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[23263] = {
	name = L["Champion's Silk Cowl"],
	quality = 3,
	icon = "inv_helmet_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[23264] = {
	name = L["Champion's Silk Mantle"],
	quality = 3,
	icon = "inv_shoulder_02",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[29600] = {
	name = L["Blood Guard's Lamellar Gauntlets"],
	quality = 3,
	icon = "inv_gauntlets_29",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[29601] = {
	name = L["Blood Guard's Lamellar Sabatons"],
	quality = 3,
	icon = "inv_boots_plate_03",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[29602] = {
	name = L["Legionnaire's Lamellar Breastplate"],
	quality = 3,
	icon = "inv_chest_plate03",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[29603] = {
	name = L["Legionnaire's Lamellar Leggings"],
	quality = 3,
	icon = "inv_pants_06",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[29604] = {
	name = L["Champion's Lamellar Headguard"],
	quality = 3,
	icon = "inv_helmet_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[29605] = {
	name = L["Champion's Lamellar Shoulders"],
	quality = 3,
	icon = "inv_shoulder_28",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[29612] = {
	name = L["General's Lamellar Boots"],
	quality = 4,
	icon = "inv_boots_plate_09",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[29613] = {
	name = L["General's Lamellar Gloves"],
	quality = 4,
	icon = "inv_gauntlets_29",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[29614] = {
	name = L["General's Lamellar Legplates"],
	quality = 4,
	icon = "inv_pants_04",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[29615] = {
	name = L["Warlord's Lamellar Chestplate"],
	quality = 4,
	icon = "inv_chest_plate03",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[29616] = {
	name = L["Warlord's Lamellar Faceguard"],
	quality = 4,
	icon = "inv_helmet_05",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[29617] = {
	name = L["Warlord's Lamellar Pauldrons"],
	quality = 4,
	icon = "inv_shoulder_20",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 60,
}
t[29466] = {
	name = L["Black War Kodo"],
	quality = 4,
	icon = "ability_mount_kodo_03",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 40,
}
t[29469] = {
	name = L["Horn of the Black War Wolf"],
	quality = 4,
	icon = "ability_mount_blackdirewolf",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 40,
}
t[29470] = {
	name = L["Red Skeletal Warhorse"],
	quality = 4,
	icon = "ability_mount_undeadhorse",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 40,
}
t[29472] = {
	name = L["Whistle of the Black War Raptor"],
	quality = 4,
	icon = "ability_mount_raptor",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 40,
}
t[34129] = {
	name = L["Swift Warstrider"],
	quality = 4,
	icon = "ability_mount_cockatricemount_black",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 40,
}
t[18675] = {
	name = L["Military Ranks of the Horde & Alliance"],
	quality = 1,
	icon = "inv_misc_book_10",
	buyPrice = 100,
	sellPrice = 25,
	reqLevel = 0,
}
t[34261] = {
	name = L["Pattern: Green Winter Clothes"],
	quality = 2,
	icon = "inv_scroll_06",
	buyPrice = 5000,
	sellPrice = 1250,
	reqLevel = 0,
	profession = L["Tailoring"],
	teaches = L["Green Winter Clothes"],
	learnedAt = 250,
}
t[34262] = {
	name = L["Pattern: Winter Boots"],
	quality = 2,
	icon = "inv_scroll_03",
	buyPrice = 5000,
	sellPrice = 1250,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Winter Boots"],
	learnedAt = 285,
}
t[34413] = {
	name = L["Recipe: Hot Apple Cider"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 0,
	profession = L["Cooking"],
	teaches = L["Hot Apple Cider"],
	learnedAt = 325,
}
t[18632] = {
	name = L["Moonbrook Riot Taffy"],
	quality = 1,
	icon = "inv_misc_food_30",
	buyPrice = 1000,
	sellPrice = 50,
	reqLevel = 25,
}
t[18633] = {
	name = L["Styleen's Sour Suckerpop"],
	quality = 1,
	icon = "inv_misc_food_26",
	buyPrice = 125,
	sellPrice = 6,
	reqLevel = 5,
}
t[18635] = {
	name = L["Bellara's Nutterbar"],
	quality = 1,
	icon = "inv_misc_food_27",
	buyPrice = 2000,
	sellPrice = 100,
	reqLevel = 35,
}
t[20557] = {
	name = L["Hallow's End Pumpkin Treat"],
	quality = 1,
	icon = "inv_misc_food_59",
	buyPrice = 3500,
	sellPrice = 175,
	reqLevel = 0,
}
t[37898] = {
	name = L["Wild Winter Pilsner"],
	quality = 1,
	icon = "inv_drink_10",
	buyPrice = 150,
	sellPrice = 6,
	reqLevel = 1,
}
t[37899] = {
	name = L["Izzard's Ever Flavor"],
	quality = 1,
	icon = "inv_drink_10",
	buyPrice = 150,
	sellPrice = 6,
	reqLevel = 1,
}
t[37900] = {
	name = L["Aromatic Honey Brew"],
	quality = 1,
	icon = "inv_drink_10",
	buyPrice = 150,
	sellPrice = 6,
	reqLevel = 1,
}
t[37905] = {
	name = L["Draenic Pale Ale"],
	quality = 1,
	icon = "inv_drink_10",
	buyPrice = 150,
	sellPrice = 6,
	reqLevel = 1,
}
t[37496] = {
	name = L["Binary Brew"],
	quality = 1,
	icon = "inv_drink_10",
	buyPrice = 150,
	sellPrice = 6,
	reqLevel = 1,
}
t[37906] = {
	name = L["Binary Brew"],
	quality = 1,
	icon = "inv_drink_10",
	buyPrice = 150,
	sellPrice = 6,
	reqLevel = 1,
}
t[37907] = {
	name = L["Autumnal Acorn Ale"],
	quality = 1,
	icon = "inv_drink_10",
	buyPrice = 150,
	sellPrice = 6,
	reqLevel = 1,
}
t[37908] = {
	name = L["Bartlett's Bitter Brew"],
	quality = 1,
	icon = "inv_drink_10",
	buyPrice = 150,
	sellPrice = 6,
	reqLevel = 1,
}
t[42122] = {
	name = L["Medallion of the Horde"],
	quality = 4,
	icon = "inv_jewelry_necklace_38",
	buyPrice = 0,
	sellPrice = 0,
	reqLevel = 80,
}
t[10321] = {
	name = L["Pattern: Tuxedo Shirt"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 4500,
	sellPrice = 1125,
	reqLevel = 0,
	profession = L["Tailoring"],
	teaches = L["Tuxedo Shirt"],
	learnedAt = 240,
}
t[10323] = {
	name = L["Pattern: Tuxedo Pants"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 4500,
	sellPrice = 1125,
	reqLevel = 0,
	profession = L["Tailoring"],
	teaches = L["Tuxedo Pants"],
	learnedAt = 245,
}
t[10326] = {
	name = L["Pattern: Tuxedo Jacket"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 5000,
	sellPrice = 1250,
	reqLevel = 0,
	profession = L["Tailoring"],
	teaches = L["Tuxedo Jacket"],
	learnedAt = 250,
}
t[34319] = {
	name = L["Pattern: Red Winter Clothes"],
	quality = 2,
	icon = "inv_scroll_06",
	buyPrice = 5000,
	sellPrice = 1250,
	reqLevel = 0,
	profession = L["Tailoring"],
	teaches = L["Red Winter Clothes"],
	learnedAt = 250,
}
t[37909] = {
	name = L["Lord of Frost's Private Label"],
	quality = 1,
	icon = "inv_drink_10",
	buyPrice = 150,
	sellPrice = 6,
	reqLevel = 1,
}
t[10311] = {
	name = L["Pattern: Orange Martial Shirt"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 3000,
	sellPrice = 750,
	reqLevel = 0,
	profession = L["Tailoring"],
	teaches = L["Orange Martial Shirt"],
	learnedAt = 220,
}
t[10394] = {
	name = L["Prairie Dog Whistle"],
	quality = 1,
	icon = "ability_hunter_beastcall",
	buyPrice = 5000,
	sellPrice = 1250,
	reqLevel = 0,
}
t[18949] = {
	name = L["Pattern: Barbaric Bracers"],
	quality = 1,
	icon = "inv_scroll_03",
	buyPrice = 2000,
	sellPrice = 500,
	reqLevel = 0,
	profession = L["Leatherworking"],
	teaches = L["Barbaric Bracers"],
	learnedAt = 155,
}
t[16217] = {
	name = L["Formula: Enchant Shield - Greater Stamina"],
	quality = 1,
	icon = "inv_misc_note_01",
	buyPrice = 12000,
	sellPrice = 3000,
	reqLevel = 0,
	profession = L["Enchanting"],
	teaches = L["Enchant Shield - Greater Stamina"],
	learnedAt = 265,
}
t[8629] = {
	name = L["Reins of the Striped Nightsaber"],
	quality = 3,
	icon = "ability_mount_blackpanther",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 20,
}
t[8631] = {
	name = L["Reins of the Striped Frostsaber"],
	quality = 3,
	icon = "ability_mount_whitetiger",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 20,
}
t[8632] = {
	name = L["Reins of the Spotted Frostsaber"],
	quality = 3,
	icon = "ability_mount_whitetiger",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 20,
}
t[18766] = {
	name = L["Reins of the Swift Frostsaber"],
	quality = 4,
	icon = "ability_mount_whitetiger",
	buyPrice = 100000,
	sellPrice = 25000,
	reqLevel = 40,
}
t[18767] = {
	name = L["Reins of the Swift Mistsaber"],
	quality = 4,
	icon = "ability_mount_whitetiger",
	buyPrice = 100000,
	sellPrice = 25000,
	reqLevel = 40,
}
t[18902] = {
	name = L["Reins of the Swift Stormsaber"],
	quality = 4,
	icon = "ability_mount_whitetiger",
	buyPrice = 100000,
	sellPrice = 25000,
	reqLevel = 40,
}
t[47100] = {
	name = L["Reins of the Striped Dawnsaber"],
	quality = 3,
	icon = "ability_mount_blackpanther",
	buyPrice = 10000,
	sellPrice = 2500,
	reqLevel = 20,
}
t[8500] = {
	name = L["Great Horned Owl"],
	quality = 1,
	icon = "ability_eyeoftheowl",
	buyPrice = 5000,
	sellPrice = 1250,
	reqLevel = 0,
}
t[8501] = {
	name = L["Hawk Owl"],
	quality = 1,
	icon = "ability_eyeoftheowl",
	buyPrice = 5000,
	sellPrice = 1250,
	reqLevel = 0,
}
t[8523] = {
	name = L["Field Testing Kit"],
	quality = 1,
	icon = "inv_misc_bag_07_red",
	buyPrice = 1000,
	sellPrice = 0,
	reqLevel = 0,
}
t[2555] = {
	name = L["true"],
	profession = L["Alchemy"],
	teaches = L["Swiftness Potion"],
	learnedAt = 60,
}
t[22913] = {
	name = L["true"],
	profession = L["Alchemy"],
	teaches = L["Haste Potion"],
	learnedAt = 350,
}
t[47507] = {
	name = L["true"],
	profession = L["Alchemy"],
	teaches = L["Flask of the North"],
	learnedAt = 425,
}
t[22919] = {
	name = L["true"],
	profession = L["Alchemy"],
	teaches = L["Elixir of Major Mageblood"],
	learnedAt = 355,
}
t[22914] = {
	name = L["true"],
	profession = L["Alchemy"],
	teaches = L["Destruction Potion"],
	learnedAt = 350,
}
t[22927] = {
	name = L["true"],
	profession = L["Alchemy"],
	teaches = L["Ironshield Potion"],
	learnedAt = 365,
}
t[13518] = {
	name = L["true"],
	profession = L["Alchemy"],
	teaches = L["Potion of Petrification"],
	learnedAt = 300,
}
t[10644] = {
	name = L["true"],
	profession = L["Alchemy"],
	teaches = L["Goblin Rocket Fuel"],
	learnedAt = 210,
}
t[6663] = {
	name = L["true"],
	profession = L["Alchemy"],
	teaches = L["Elixir of Giant Growth"],
	learnedAt = 90,
}
t[35295] = {
	name = L["true"],
	profession = L["Alchemy"],
	teaches = L["Haste Potion"],
	learnedAt = 350,
}
t[3831] = {
	name = L["true"],
	profession = L["Alchemy"],
	teaches = L["Major Troll's Blood Elixir"],
	learnedAt = 180,
}
t[13520] = {
	name = L["true"],
	profession = L["Alchemy"],
	teaches = L["Flask of Distilled Wisdom"],
	learnedAt = 300,
}
t[44564] = {
	name = L["true"],
	profession = L["Alchemy"],
	teaches = L["Mighty Arcane Protection Potion"],
	learnedAt = 400,
}
t[34481] = {
	name = L["true"],
	profession = L["Alchemy"],
	teaches = L["Mad Alchemist's Potion"],
	learnedAt = 325,
}
t[44566] = {
	name = L["true"],
	profession = L["Alchemy"],
	teaches = L["Mighty Frost Protection Potion"],
	learnedAt = 400,
}
t[3396] = {
	name = L["true"],
	profession = L["Alchemy"],
	teaches = L["Elixir of Lesser Agility"],
	learnedAt = 140,
}
t[2553] = {
	name = L["true"],
	profession = L["Alchemy"],
	teaches = L["Elixir of Minor Agility"],
	learnedAt = 50,
}
t[44508] = {
	name = L["Discovery!"],
	profession = L["Alchemy"],
	teaches = L["None"],
	learnedAt = None,
}
t[13481] = {
	name = L["true"],
	profession = L["Alchemy"],
	teaches = L["Elixir of Brute Force"],
	learnedAt = 275,
}
t[13476] = {
	name = L["true"],
	profession = L["Alchemy"],
	teaches = L["Mighty Rage Potion"],
	learnedAt = 255,
}
t[9296] = {
	name = L["true"],
	profession = L["Alchemy"],
	teaches = L["Gift of Arthas"],
	learnedAt = 240,
}
t[31682] = {
	name = L["true"],
	profession = L["Alchemy"],
	teaches = L["Fel Mana Potion"],
	learnedAt = 360,
}
t[13521] = {
	name = L["true"],
	profession = L["Alchemy"],
	teaches = L["Flask of Supreme Power"],
	learnedAt = 300,
}
t[9295] = {
	name = L["true"],
	profession = L["Alchemy"],
	teaches = L["Invisibility Potion"],
	learnedAt = 235,
}
t[22926] = {
	name = L["true"],
	profession = L["Alchemy"],
	teaches = L["Elixir of Empowerment"],
	learnedAt = 365,
}
t[13480] = {
	name = L["true"],
	profession = L["Alchemy"],
	teaches = L["Major Healing Potion"],
	learnedAt = 275,
}
t[44568] = {
	name = L["true"],
	profession = L["Alchemy"],
	teaches = L["Mighty Shadow Protection Potion"],
	learnedAt = 400,
}
t[22912] = {
	name = L["true"],
	profession = L["Alchemy"],
	teaches = L["Heroic Potion"],
	learnedAt = 350,
}
t[9297] = {
	name = L["true"],
	profession = L["Alchemy"],
	teaches = L["Elixir of Dream Vision"],
	learnedAt = 240,
}
t[6211] = {
	name = L["true"],
	profession = L["Alchemy"],
	teaches = L["Elixir of Ogre's Strength"],
	learnedAt = 150,
}
t[3394] = {
	name = L["true"],
	profession = L["Alchemy"],
	teaches = L["Potion of Curing"],
	learnedAt = 120,
}
t[22904] = {
	name = L["true"],
	profession = L["Alchemy"],
	teaches = L["Elixir of the Searching Eye"],
	learnedAt = 325,
}
t[21547] = {
	name = L["true"],
	profession = L["Alchemy"],
	teaches = L["Elixir of Greater Firepower"],
	learnedAt = 250,
}
t[22903] = {
	name = L["true"],
	profession = L["Alchemy"],
	teaches = L["Insane Strength Potion"],
	learnedAt = 320,
}
t[13477] = {
	name = L["true"],
	profession = L["Alchemy"],
	teaches = L["Superior Mana Potion"],
	learnedAt = 260,
}
t[31680] = {
	name = L["true"],
	profession = L["Alchemy"],
	teaches = L["Fel Strength Elixir"],
	learnedAt = 335,
}
t[13496] = {
	name = L["true"],
	profession = L["Alchemy"],
	teaches = L["Greater Nature Protection Potion"],
	learnedAt = 290,
}
t[3393] = {
	name = L["true"],
	profession = L["Alchemy"],
	teaches = L["Minor Magic Resistance Potion"],
	learnedAt = 110,
}
t[4597] = {
	name = L["true"],
	profession = L["Alchemy"],
	teaches = L["Discolored Healing Potion"],
	learnedAt = 50,
}
t[44565] = {
	name = L["true"],
	profession = L["Alchemy"],
	teaches = L["Mighty Fire Protection Potion"],
	learnedAt = 400,
}
t[13519] = {
	name = L["true"],
	profession = L["Alchemy"],
	teaches = L["Flask of the Titans"],
	learnedAt = 300,
}
t[13497] = {
	name = L["true"],
	profession = L["Alchemy"],
	teaches = L["Greater Arcane Protection Potion"],
	learnedAt = 290,
}
t[13490] = {
	name = L["true"],
	profession = L["Alchemy"],
	teaches = L["Greater Stoneshield Potion"],
	learnedAt = 280,
}
t[13487] = {
	name = L["true"],
	profession = L["Alchemy"],
	teaches = L["Transmute: Water to Undeath"],
	learnedAt = 275,
}
t[44567] = {
	name = L["true"],
	profession = L["Alchemy"],
	teaches = L["Mighty Nature Protection Potion"],
	learnedAt = 400,
}
t[13492] = {
	name = L["true"],
	profession = L["Alchemy"],
	teaches = L["Purification Potion"],
	learnedAt = 285,
}
t[13493] = {
	name = L["true"],
	profession = L["Alchemy"],
	teaches = L["Greater Arcane Elixir"],
	learnedAt = 285,
}
t[13494] = {
	name = L["true"],
	profession = L["Alchemy"],
	teaches = L["Greater Fire Protection Potion"],
	learnedAt = 290,
}
t[31681] = {
	name = L["true"],
	profession = L["Alchemy"],
	teaches = L["Fel Regeneration Potion"],
	learnedAt = 345,
}
t[18257] = {
	name = L["true"],
	profession = L["Alchemy"],
	teaches = L["Major Rejuvenation Potion"],
	learnedAt = 300,
}
t[13499] = {
	name = L["true"],
	profession = L["Alchemy"],
	teaches = L["Greater Shadow Protection Potion"],
	learnedAt = 290,
}
t[9294] = {
	name = L["true"],
	profession = L["Alchemy"],
	teaches = L["Wildvine Potion"],
	learnedAt = 225,
}
t[9293] = {
	name = L["true"],
	profession = L["Alchemy"],
	teaches = L["Magic Resistance Potion"],
	learnedAt = 210,
}
t[22925] = {
	name = L["true"],
	profession = L["Alchemy"],
	teaches = L["Major Holy Protection Potion"],
	learnedAt = 360,
}
t[13495] = {
	name = L["true"],
	profession = L["Alchemy"],
	teaches = L["Greater Frost Protection Potion"],
	learnedAt = 290,
}
t[13486] = {
	name = L["true"],
	profession = L["Alchemy"],
	teaches = L["Transmute: Undeath to Water"],
	learnedAt = 275,
}
t[17709] = {
	name = L["true"],
	profession = L["Alchemy"],
	teaches = L["Elixir of Frost Power"],
	learnedAt = 190,
}
t[2556] = {
	name = L["true"],
	profession = L["Alchemy"],
	teaches = L["Elixir of Tongues"],
	learnedAt = 70,
}
t[36841] = {
	name = L["true"],
	profession = L["Alchemy"],
	teaches = L["Elixir of Brute Force"],
	learnedAt = 275,
}
t[36842] = {
	name = L["true"],
	profession = L["Alchemy"],
	teaches = L["Elixir of Brute Force"],
	learnedAt = 275,
}
t[36843] = {
	name = L["true"],
	profession = L["Alchemy"],
	teaches = L["Elixir of Brute Force"],
	learnedAt = 275,
}
t[13488] = {
	name = L["true"],
	profession = L["Alchemy"],
	teaches = L["Transmute: Life to Earth"],
	learnedAt = 275,
}
t[3832] = {
	name = L["true"],
	profession = L["Alchemy"],
	teaches = L["Elixir of Detect Lesser Invisibility"],
	learnedAt = 195,
}
t[22921] = {
	name = L["true"],
	profession = L["Alchemy"],
	teaches = L["Major Frost Protection Potion"],
	learnedAt = 360,
}
t[22924] = {
	name = L["true"],
	profession = L["Alchemy"],
	teaches = L["Major Shadow Protection Potion"],
	learnedAt = 360,
}
t[20761] = {
	name = L["true"],
	profession = L["Alchemy"],
	teaches = L["Transmute: Elemental Fire"],
	learnedAt = 300,
}
t[3395] = {
	name = L["true"],
	profession = L["Alchemy"],
	teaches = L["Limited Invulnerability Potion"],
	learnedAt = 250,
}
t[4624] = {
	name = L["true"],
	profession = L["Alchemy"],
	teaches = L["Lesser Stoneshield Potion"],
	learnedAt = 215,
}
t[22920] = {
	name = L["true"],
	profession = L["Alchemy"],
	teaches = L["Major Fire Protection Potion"],
	learnedAt = 360,
}
t[13522] = {
	name = L["true"],
	profession = L["Alchemy"],
	teaches = L["Flask of Chromatic Resistance"],
	learnedAt = 300,
}
t[22923] = {
	name = L["true"],
	profession = L["Alchemy"],
	teaches = L["Major Arcane Protection Potion"],
	learnedAt = 360,
}
t[13491] = {
	name = L["true"],
	profession = L["Alchemy"],
	teaches = L["Elixir of the Mongoose"],
	learnedAt = 280,
}
t[3830] = {
	name = L["true"],
	profession = L["Alchemy"],
	teaches = L["Elixir of Fortitude"],
	learnedAt = 175,
}
t[5641] = {
	name = L["Recipe: Cowardly Flight Potion"],
	profession = L["Alchemy"],
	teaches = L["None"],
	learnedAt = 125,
}
t[13479] = {
	name = L["true"],
	profession = L["Alchemy"],
	teaches = L["Elixir of the Sages"],
	learnedAt = 270,
}
t[9298] = {
	name = L["true"],
	profession = L["Alchemy"],
	teaches = L["Elixir of Giants"],
	learnedAt = 245,
}
t[13500] = {
	name = L["true"],
	profession = L["Alchemy"],
	teaches = L["Greater Holy Protection Potion"],
	learnedAt = 290,
}
t[13483] = {
	name = L["true"],
	profession = L["Alchemy"],
	teaches = L["Transmute: Fire to Earth"],
	learnedAt = 275,
}
t[36844] = {
	name = L["true"],
	profession = L["Alchemy"],
	teaches = L["Elixir of Brute Force"],
	learnedAt = 275,
}
t[13489] = {
	name = L["true"],
	profession = L["Alchemy"],
	teaches = L["Transmute: Earth to Life"],
	learnedAt = 275,
}
t[35294] = {
	name = L["true"],
	profession = L["Alchemy"],
	teaches = L["Elixir of Empowerment"],
	learnedAt = 365,
}
t[7989] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Mithril Spurs"],
	learnedAt = 235,
}
t[12690] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Imperial Plate Bracers"],
	learnedAt = 270,
}
t[30322] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Red Belt of Battle"],
	learnedAt = 375,
}
t[32736] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Swiftsteel Bracers"],
	learnedAt = 375,
}
t[23629] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Felsteel Longblade"],
	learnedAt = 365,
}
t[41122] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Reinforced Cobalt Chestpiece"],
	learnedAt = 375,
}
t[18592] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Sulfuron Hammer"],
	learnedAt = 300,
}
t[23605] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Felsteel Gloves"],
	learnedAt = 360,
}
t[6044] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Iron Shield Spike"],
	learnedAt = 150,
}
t[45089] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Battlelord's Plate Boots"],
	learnedAt = 450,
}
t[49974] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Boots of Kingly Upheaval"],
	learnedAt = 450,
}
t[49972] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Hellfrozen Bonegrinders"],
	learnedAt = 450,
}
t[7987] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Ornate Mithril Helm"],
	learnedAt = 245,
}
t[10713] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Inlaid Mithril Cylinder"],
	learnedAt = 200,
}
t[30321] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Belt of the Guardian"],
	learnedAt = 375,
}
t[33174] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Ragesteel Shoulders"],
	learnedAt = 365,
}
t[12700] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Imperial Plate Boots"],
	learnedAt = 295,
}
t[49973] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Pillars of Might"],
	learnedAt = 450,
}
t[23630] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Khorium Champion"],
	learnedAt = 365,
}
t[12838] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Arcanite Reaper"],
	learnedAt = 300,
}
t[23613] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Ragesteel Breastplate"],
	learnedAt = 370,
}
t[35209] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Hard Khorium Battlefists"],
	learnedAt = 365,
}
t[23612] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Ragesteel Helm"],
	learnedAt = 365,
}
t[33186] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Adamantite Weapon Chain"],
	learnedAt = 335,
}
t[45092] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Indestructible Plate Girdle"],
	learnedAt = 450,
}
t[23608] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Khorium Belt"],
	learnedAt = 360,
}
t[6046] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Steel Weapon Chain"],
	learnedAt = 190,
}
t[12692] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Thorium Shield Spike"],
	learnedAt = 275,
}
t[8029] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Wicked Mithril Blade"],
	learnedAt = 225,
}
t[23610] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Khorium Boots"],
	learnedAt = 365,
}
t[12705] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Imperial Plate Chest"],
	learnedAt = 300,
}
t[12694] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Thorium Helm"],
	learnedAt = 280,
}
t[12261] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Searing Golden Blade"],
	learnedAt = 190,
}
t[6735] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Ironforge Breastplate"],
	learnedAt = 100,
}
t[23607] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Felsteel Helm"],
	learnedAt = 365,
}
t[47624] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Titanium Razorplate"],
	learnedAt = 450,
}
t[12702] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Radiant Circlet"],
	learnedAt = 295,
}
t[33792] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Heavy Copper Longsword"],
	learnedAt = 35,
}
t[23639] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Greater Ward of Shielding"],
	learnedAt = 375,
}
t[23606] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Felsteel Leggings"],
	learnedAt = 360,
}
t[12687] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Imperial Plate Shoulders"],
	learnedAt = 265,
}
t[47622] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Breastplate of the White Knight"],
	learnedAt = 450,
}
t[23626] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Black Felsteel Bracers"],
	learnedAt = 365,
}
t[12688] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Imperial Plate Belt"],
	learnedAt = 265,
}
t[7976] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Mithril Shield Spike"],
	learnedAt = 215,
}
t[47623] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Saronite Swordbreakers"],
	learnedAt = 450,
}
t[12684] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Thorium Bracers"],
	learnedAt = 255,
}
t[41124] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Reinforced Cobalt Shoulders"],
	learnedAt = 375,
}
t[35296] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Adamantite Weapon Chain"],
	learnedAt = 335,
}
t[12715] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Imperial Plate Leggings"],
	learnedAt = 300,
}
t[2883] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Deadly Bronze Poniard"],
	learnedAt = 125,
}
t[23609] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Khorium Pants"],
	learnedAt = 360,
}
t[35211] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Hard Khorium Battleplate"],
	learnedAt = 365,
}
t[7990] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Heavy Mithril Helm"],
	learnedAt = 245,
}
t[45091] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Treads of Destiny"],
	learnedAt = 450,
}
t[49969] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Puresteel Legplates"],
	learnedAt = 450,
}
t[22705] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Icebane Bracers"],
	learnedAt = 300,
}
t[23637] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Hand of Eternity"],
	learnedAt = 365,
}
t[12834] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Arcanite Champion"],
	learnedAt = 300,
}
t[12704] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Thorium Leggings"],
	learnedAt = 300,
}
t[3872] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Golden Scale Leggings"],
	learnedAt = 170,
}
t[7978] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Barbaric Iron Shoulders"],
	learnedAt = 160,
}
t[2881] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Runed Copper Breastplate"],
	learnedAt = 80,
}
t[47625] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Titanium Spikeguards"],
	learnedAt = 450,
}
t[45088] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Belt of the Titans"],
	learnedAt = 450,
}
t[41123] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Reinforced Cobalt Helm"],
	learnedAt = 375,
}
t[12685] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Radiant Belt"],
	learnedAt = 260,
}
t[3610] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Gemmed Copper Gauntlets"],
	learnedAt = 60,
}
t[3609] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Copper Chain Vest"],
	learnedAt = 35,
}
t[47644] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Titanium Razorplate"],
	learnedAt = 450,
}
t[23621] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Gauntlets of the Iron Tower"],
	learnedAt = 365,
}
t[23632] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Felsteel Reaper"],
	learnedAt = 365,
}
t[23633] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Runic Hammer"],
	learnedAt = 365,
}
t[23611] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Ragesteel Gloves"],
	learnedAt = 365,
}
t[12830] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Corruption"],
	learnedAt = 290,
}
t[7980] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Barbaric Iron Helm"],
	learnedAt = 175,
}
t[49970] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Protectors of Life"],
	learnedAt = 450,
}
t[22703] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Icebane Breastplate"],
	learnedAt = 300,
}
t[23625] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Oathkeeper's Helm"],
	learnedAt = 365,
}
t[23623] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Storm Helm"],
	learnedAt = 365,
}
t[23634] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Fel Hardened Maul"],
	learnedAt = 365,
}
t[32737] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Swiftsteel Shoulders"],
	learnedAt = 375,
}
t[7986] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Ornate Mithril Breastplate"],
	learnedAt = 240,
}
t[3611] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Green Iron Boots"],
	learnedAt = 145,
}
t[47641] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Saronite Swordbreakers"],
	learnedAt = 450,
}
t[47640] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Breastplate of the White Knight"],
	learnedAt = 450,
}
t[30323] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Boots of the Protector"],
	learnedAt = 375,
}
t[33954] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Hammer of Righteous Might"],
	learnedAt = 365,
}
t[18264] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Elemental Sharpening Stone"],
	learnedAt = 300,
}
t[12701] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Imperial Plate Helm"],
	learnedAt = 295,
}
t[49971] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Legplates of Painful Death"],
	learnedAt = 450,
}
t[12717] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Lionheart Helm"],
	learnedAt = 300,
}
t[12693] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Thorium Boots"],
	learnedAt = 280,
}
t[7983] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Ornate Mithril Pants"],
	learnedAt = 220,
}
t[9367] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Golden Scale Gauntlets"],
	learnedAt = 205,
}
t[7981] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Barbaric Iron Boots"],
	learnedAt = 180,
}
t[5577] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Rough Bronze Bracers"],
	learnedAt = 100,
}
t[45093] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Spiked Deathdealers"],
	learnedAt = 450,
}
t[47626] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Sunforged Breastplate"],
	learnedAt = 450,
}
t[35531] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Swiftsteel Bracers"],
	learnedAt = 375,
}
t[12696] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Demon Forged Breastplate"],
	learnedAt = 285,
}
t[11610] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Dark Iron Pulverizer"],
	learnedAt = 265,
}
t[3870] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Green Iron Shoulders"],
	learnedAt = 160,
}
t[3612] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Green Iron Gauntlets"],
	learnedAt = 150,
}
t[2882] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Silvered Bronze Shoulders"],
	learnedAt = 125,
}
t[32444] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Shadesteel Girdle"],
	learnedAt = 375,
}
t[22388] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Titanic Leggings"],
	learnedAt = 300,
}
t[12711] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Whitesoul Helm"],
	learnedAt = 300,
}
t[11615] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Dark Iron Shoulders"],
	learnedAt = 280,
}
t[8028] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Runed Mithril Hammer"],
	learnedAt = 245,
}
t[7992] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Blue Glittering Axe"],
	learnedAt = 220,
}
t[7984] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Ornate Mithril Gloves"],
	learnedAt = 220,
}
t[5578] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Silvered Bronze Breastplate"],
	learnedAt = 130,
}
t[47627] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Sunforged Bracers"],
	learnedAt = 450,
}
t[30324] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Red Havoc Boots"],
	learnedAt = 375,
}
t[41120] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Reinforced Cobalt Legplates"],
	learnedAt = 375,
}
t[31393] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Iceguard Breastplate"],
	learnedAt = 375,
}
t[31394] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Iceguard Leggings"],
	learnedAt = 375,
}
t[31395] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Iceguard Helm"],
	learnedAt = 375,
}
t[23620] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Felfury Gauntlets"],
	learnedAt = 365,
}
t[23631] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Fel Edged Battleaxe"],
	learnedAt = 365,
}
t[32738] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Dawnsteel Bracers"],
	learnedAt = 375,
}
t[12727] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Enchanted Thorium Breastplate"],
	learnedAt = 300,
}
t[17053] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Fiery Chain Shoulders"],
	learnedAt = 300,
}
t[17052] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Dark Iron Leggings"],
	learnedAt = 300,
}
t[17051] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Dark Iron Bracers"],
	learnedAt = 295,
}
t[12699] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Fiery Plate Gauntlets"],
	learnedAt = 290,
}
t[7993] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Dazzling Mithril Rapier"],
	learnedAt = 240,
}
t[7994] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Orcish War Leggings"],
	learnedAt = 230,
}
t[7975] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Heavy Mithril Pants"],
	learnedAt = 210,
}
t[10424] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Silvered Bronze Leggings"],
	learnedAt = 155,
}
t[6736] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Ironforge Gauntlets"],
	learnedAt = 140,
}
t[6734] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Ironforge Chain"],
	learnedAt = 70,
}
t[47642] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Sunforged Bracers"],
	learnedAt = 450,
}
t[22704] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Icebane Gauntlets"],
	learnedAt = 300,
}
t[32441] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Shadesteel Sabots"],
	learnedAt = 375,
}
t[32442] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Shadesteel Bracers"],
	learnedAt = 375,
}
t[23627] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Bracers of the Green Fortress"],
	learnedAt = 365,
}
t[23622] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Steelgrip Gauntlets"],
	learnedAt = 365,
}
t[35210] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Sunblessed Breastplate"],
	learnedAt = 365,
}
t[19210] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Ebon Hand"],
	learnedAt = 300,
}
t[35553] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Hard Khorium Battlefists"],
	learnedAt = 365,
}
t[17059] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Dark Iron Reaver"],
	learnedAt = 300,
}
t[12719] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Runic Plate Leggings"],
	learnedAt = 300,
}
t[12827] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Serenity"],
	learnedAt = 285,
}
t[12821] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Dawn's Edge"],
	learnedAt = 275,
}
t[12683] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Thorium Belt"],
	learnedAt = 250,
}
t[7988] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Ornate Mithril Boots"],
	learnedAt = 245,
}
t[7977] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Mithril Scale Gloves"],
	learnedAt = 220,
}
t[3868] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Frost Tiger Blade"],
	learnedAt = 200,
}
t[47645] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Titanium Spikeguards"],
	learnedAt = 450,
}
t[45090] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Plate Girdle of Righteousness"],
	learnedAt = 450,
}
t[23635] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Eternium Runed Blade"],
	learnedAt = 365,
}
t[23624] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Helm of the Stalwart Defender"],
	learnedAt = 365,
}
t[19207] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Dark Iron Gauntlets"],
	learnedAt = 300,
}
t[35529] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Dawnsteel Bracers"],
	learnedAt = 375,
}
t[12728] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Invulnerable Mail"],
	learnedAt = 300,
}
t[12713] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Radiant Leggings"],
	learnedAt = 300,
}
t[12707] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Runic Plate Boots"],
	learnedAt = 300,
}
t[11614] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Dark Iron Mail"],
	learnedAt = 270,
}
t[3869] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Shadow Crescent Axe"],
	learnedAt = 200,
}
t[3875] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Golden Scale Boots"],
	learnedAt = 200,
}
t[3871] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Golden Scale Shoulders"],
	learnedAt = 175,
}
t[3866] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Jade Serpentblade"],
	learnedAt = 175,
}
t[5543] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Iridescent Hammer"],
	learnedAt = 140,
}
t[47643] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Sunforged Breastplate"],
	learnedAt = 450,
}
t[23615] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Swiftsteel Gloves"],
	learnedAt = 370,
}
t[23628] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Blessed Bracers"],
	learnedAt = 365,
}
t[19211] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Blackguard"],
	learnedAt = 300,
}
t[19212] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Nightfall"],
	learnedAt = 300,
}
t[35532] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Swiftsteel Shoulders"],
	learnedAt = 375,
}
t[22389] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Sageblade"],
	learnedAt = 300,
}
t[12835] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Annihilator"],
	learnedAt = 300,
}
t[22390] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Persuader"],
	learnedAt = 300,
}
t[12836] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Frostguard"],
	learnedAt = 300,
}
t[12725] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Enchanted Thorium Helm"],
	learnedAt = 300,
}
t[12726] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Enchanted Thorium Leggings"],
	learnedAt = 300,
}
t[12720] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Stronghold Gauntlets"],
	learnedAt = 300,
}
t[12831] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Blood Talon"],
	learnedAt = 300,
}
t[12691] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Wildthorn Mail"],
	learnedAt = 270,
}
t[3873] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Golden Scale Cuirass"],
	learnedAt = 195,
}
t[17706] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Edge of Winter"],
	learnedAt = 190,
}
t[6045] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Iron Counterweight"],
	learnedAt = 165,
}
t[3608] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Mighty Iron Hammer"],
	learnedAt = 145,
}
t[23636] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Dirge"],
	learnedAt = 365,
}
t[22222] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Thick Obsidian Breastplate"],
	learnedAt = 300,
}
t[22221] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Obsidian Mail Tunic"],
	learnedAt = 300,
}
t[35555] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Sunblessed Breastplate"],
	learnedAt = 365,
}
t[22219] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Jagged Obsidian Shield"],
	learnedAt = 300,
}
t[22220] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Black Grasp of the Destroyer"],
	learnedAt = 300,
}
t[19209] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Blackfury"],
	learnedAt = 300,
}
t[20553] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Darkrune Gauntlets"],
	learnedAt = 300,
}
t[20555] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Darkrune Helm"],
	learnedAt = 300,
}
t[12718] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Runic Breastplate"],
	learnedAt = 300,
}
t[12716] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Helm of the Great Chief"],
	learnedAt = 300,
}
t[12832] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Darkspear"],
	learnedAt = 300,
}
t[17049] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Fiery Chain Girdle"],
	learnedAt = 295,
}
t[11612] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Dark Iron Plate"],
	learnedAt = 285,
}
t[11611] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Dark Iron Sunderer"],
	learnedAt = 275,
}
t[12817] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Bleakwood Hew"],
	learnedAt = 270,
}
t[12816] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Thorium Greatsword"],
	learnedAt = 260,
}
t[12682] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Thorium Armor"],
	learnedAt = 250,
}
t[7991] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Mithril Scale Shoulders"],
	learnedAt = 235,
}
t[7985] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Ornate Mithril Shoulder"],
	learnedAt = 225,
}
t[7979] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Barbaric Iron Breastplate"],
	learnedAt = 160,
}
t[32443] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Shadesteel Greaves"],
	learnedAt = 375,
}
t[23617] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Earthpeace Breastplate"],
	learnedAt = 370,
}
t[35208] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Sunblessed Gauntlets"],
	learnedAt = 365,
}
t[20040] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Dark Iron Boots"],
	learnedAt = 300,
}
t[32739] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Dawnsteel Shoulders"],
	learnedAt = 375,
}
t[35530] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Dawnsteel Shoulders"],
	learnedAt = 375,
}
t[35554] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Hard Khorium Battleplate"],
	learnedAt = 365,
}
t[19208] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Black Amnesty"],
	learnedAt = 300,
}
t[19206] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Dark Iron Helm"],
	learnedAt = 300,
}
t[17060] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Dark Iron Destroyer"],
	learnedAt = 300,
}
t[12833] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Hammer of the Titans"],
	learnedAt = 300,
}
t[12837] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Masterwork Stormhammer"],
	learnedAt = 300,
}
t[12714] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Runic Plate Helm"],
	learnedAt = 300,
}
t[12706] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Runic Plate Shoulders"],
	learnedAt = 300,
}
t[12698] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Dawnbringer Shoulders"],
	learnedAt = 290,
}
t[12828] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Volcanic Hammer"],
	learnedAt = 290,
}
t[12695] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Radiant Gloves"],
	learnedAt = 285,
}
t[12824] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Enchanted Battlehammer"],
	learnedAt = 280,
}
t[12825] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Blazing Rapier"],
	learnedAt = 280,
}
t[12689] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Radiant Breastplate"],
	learnedAt = 270,
}
t[12818] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Inlaid Thorium Hammer"],
	learnedAt = 270,
}
t[7982] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Barbaric Iron Gloves"],
	learnedAt = 185,
}
t[3874] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Polished Steel Boots"],
	learnedAt = 185,
}
t[3867] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Golden Iron Destroyer"],
	learnedAt = 170,
}
t[35556] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Sunblessed Gauntlets"],
	learnedAt = 365,
}
t[20554] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Darkrune Breastplate"],
	learnedAt = 300,
}
t[12839] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Heartseeker"],
	learnedAt = 300,
}
t[12697] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Radiant Boots"],
	learnedAt = 290,
}
t[12826] = {
	name = L["true"],
	profession = L["Blacksmithing"],
	teaches = L["Rune Edge"],
	learnedAt = 285,
}
t[6661] = {
	name = L["true"],
	profession = L["Cooking"],
	teaches = L["Savory Deviate Delight"],
	learnedAt = 85,
}
t[33925] = {
	name = L["true"],
	profession = L["Cooking"],
	teaches = L["Delicious Chocolate Cake"],
	learnedAt = 1,
}
t[34834] = {
	name = L["true"],
	profession = L["Cooking"],
	teaches = L["Captain Rumsey's Lager"],
	learnedAt = 100,
}
t[33871] = {
	name = L["true"],
	profession = L["Cooking"],
	teaches = L["Stormchops"],
	learnedAt = 300,
}
t[27684] = {
	name = L["true"],
	profession = L["Cooking"],
	teaches = L["Buzzard Bites"],
	learnedAt = 300,
}
t[33873] = {
	name = L["true"],
	profession = L["Cooking"],
	teaches = L["Spicy Hot Talbuk"],
	learnedAt = 325,
}
t[33869] = {
	name = L["true"],
	profession = L["Cooking"],
	teaches = L["Broiled Bloodfin"],
	learnedAt = 300,
}
t[33875] = {
	name = L["true"],
	profession = L["Cooking"],
	teaches = L["Kibler's Bits"],
	learnedAt = 300,
}
t[33870] = {
	learnedAt = 325,