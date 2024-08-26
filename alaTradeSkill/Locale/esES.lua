--[[--
	by ALA 
--]]--

local __addon, __private = ...;
local CT = __private.CT;

if CT.LOCALE ~= "esES" then
	return;
end
local l10n = CT.l10n;
l10n.LOCALE = "esES";

-->	fix for ptr
	local LE_ITEM_CLASS_CONSUMABLE = LE_ITEM_CLASS_CONSUMABLE or 0;
	local LE_ITEM_CLASS_CONTAINER = LE_ITEM_CLASS_CONTAINER or 1;
	local LE_ITEM_CLASS_WEAPON = LE_ITEM_CLASS_WEAPON or 2;
	local LE_ITEM_CLASS_GEM = LE_ITEM_CLASS_GEM or 3;
	local LE_ITEM_CLASS_ARMOR = LE_ITEM_CLASS_ARMOR or 4;
	local LE_ITEM_CLASS_REAGENT = LE_ITEM_CLASS_REAGENT or 5;
	local LE_ITEM_CLASS_PROJECTILE = LE_ITEM_CLASS_PROJECTILE or 6;
	local LE_ITEM_CLASS_TRADEGOODS = LE_ITEM_CLASS_TRADEGOODS or 7;
	local LE_ITEM_CLASS_ITEM_ENHANCEMENT = LE_ITEM_CLASS_ITEM_ENHANCEMENT or 8;
	local LE_ITEM_CLASS_RECIPE = LE_ITEM_CLASS_RECIPE or 9;
	local LE_ITEM_CLASS_QUIVER = LE_ITEM_CLASS_QUIVER or 11;
	local LE_ITEM_CLASS_QUESTITEM = LE_ITEM_CLASS_QUESTITEM or 12;
	local LE_ITEM_CLASS_KEY = LE_ITEM_CLASS_KEY or 13;
	local LE_ITEM_CLASS_MISCELLANEOUS = LE_ITEM_CLASS_MISCELLANEOUS or 15;
	local LE_ITEM_CLASS_GLYPH = LE_ITEM_CLASS_GLYPH or 16;
	local LE_ITEM_CLASS_BATTLEPET = LE_ITEM_CLASS_BATTLEPET or 17;
	local LE_ITEM_CLASS_WOW_TOKEN = LE_ITEM_CLASS_WOW_TOKEN or 18;
	local LE_ITEM_WEAPON_AXE1H = LE_ITEM_WEAPON_AXE1H or 0;
	local LE_ITEM_WEAPON_AXE2H = LE_ITEM_WEAPON_AXE2H or 1;
	local LE_ITEM_WEAPON_BOWS = LE_ITEM_WEAPON_BOWS or 2;
	local LE_ITEM_WEAPON_GUNS = LE_ITEM_WEAPON_GUNS or 3;
	local LE_ITEM_WEAPON_MACE1H = LE_ITEM_WEAPON_MACE1H or 4;
	local LE_ITEM_WEAPON_MACE2H = LE_ITEM_WEAPON_MACE2H or 5;
	local LE_ITEM_WEAPON_POLEARM = LE_ITEM_WEAPON_POLEARM or 6;
	local LE_ITEM_WEAPON_SWORD1H = LE_ITEM_WEAPON_SWORD1H or 7;
	local LE_ITEM_WEAPON_SWORD2H = LE_ITEM_WEAPON_SWORD2H or 8;
	local LE_ITEM_WEAPON_WARGLAIVE = LE_ITEM_WEAPON_WARGLAIVE or 9;
	local LE_ITEM_WEAPON_STAFF = LE_ITEM_WEAPON_STAFF or 10;
	local LE_ITEM_WEAPON_EXOTIC1H = LE_ITEM_WEAPON_EXOTIC1H or 11;
	local LE_ITEM_WEAPON_EXOTIC2H = LE_ITEM_WEAPON_EXOTIC2H or 12;
	local LE_ITEM_WEAPON_UNARMED = LE_ITEM_WEAPON_UNARMED or 13;
	local LE_ITEM_WEAPON_GENERIC = LE_ITEM_WEAPON_GENERIC or 14;
	local LE_ITEM_WEAPON_DAGGER = LE_ITEM_WEAPON_DAGGER or 15;
	local LE_ITEM_WEAPON_THROWN = LE_ITEM_WEAPON_THROWN or 16;
	local LE_ITEM_WEAPON_SPEAR = LE_ITEM_WEAPON_SPEAR or 17;
	local LE_ITEM_WEAPON_CROSSBOW = LE_ITEM_WEAPON_CROSSBOW or 18;
	local LE_ITEM_WEAPON_WAND = LE_ITEM_WEAPON_WAND or 19;
	local LE_ITEM_WEAPON_FISHINGPOLE = LE_ITEM_WEAPON_FISHINGPOLE or 20;
	--	classic
	local LE_ITEM_GEM_INTELLECT = LE_ITEM_GEM_INTELLECT or 0;
	local LE_ITEM_GEM_AGILITY = LE_ITEM_GEM_AGILITY or 1;
	local LE_ITEM_GEM_STRENGTH = LE_ITEM_GEM_STRENGTH or 2;
	local LE_ITEM_GEM_STAMINA = LE_ITEM_GEM_STAMINA or 3;
	local LE_ITEM_GEM_SPIRIT = LE_ITEM_GEM_SPIRIT or 4;
	local LE_ITEM_GEM_CRITICALSTRIKE = LE_ITEM_GEM_CRITICALSTRIKE or 5;
	local LE_ITEM_GEM_MASTERY = LE_ITEM_GEM_MASTERY or 6;
	local LE_ITEM_GEM_HASTE = LE_ITEM_GEM_HASTE or 7;
	local LE_ITEM_GEM_VERSATILITY = LE_ITEM_GEM_VERSATILITY or 8;
	--	9
	local LE_ITEM_GEM_MULTIPLESTATS = LE_ITEM_GEM_MULTIPLESTATS or 10;
	local LE_ITEM_GEM_ARTIFACTRELIC = LE_ITEM_GEM_ARTIFACTRELIC or 11;
	--	wotlk & bcc
	local LE_ITEM_GEM_RED = LE_ITEM_GEM_RED or 0;
	local LE_ITEM_GEM_BLUE = LE_ITEM_GEM_BLUE or 1;
	local LE_ITEM_GEM_YELLOW = LE_ITEM_GEM_YELLOW or 2;
	local LE_ITEM_GEM_PURPLE = LE_ITEM_GEM_PURPLE or 3;
	local LE_ITEM_GEM_GREEN = LE_ITEM_GEM_GREEN or 4;
	local LE_ITEM_GEM_ORANGE = LE_ITEM_GEM_ORANGE or 5;
	local LE_ITEM_GEM_META = LE_ITEM_GEM_META or 6;
	local LE_ITEM_GEM_SIMPLE = LE_ITEM_GEM_SIMPLE or 7;
	local LE_ITEM_GEM_PRISMATIC = LE_ITEM_GEM_PRISMATIC or 8;
	--
	local LE_ITEM_ARMOR_GENERIC = LE_ITEM_ARMOR_GENERIC or 0;
	local LE_ITEM_ARMOR_CLOTH = LE_ITEM_ARMOR_CLOTH or 1;
	local LE_ITEM_ARMOR_LEATHER = LE_ITEM_ARMOR_LEATHER or 2;
	local LE_ITEM_ARMOR_MAIL = LE_ITEM_ARMOR_MAIL or 3;
	local LE_ITEM_ARMOR_PLATE = LE_ITEM_ARMOR_PLATE or 4;
	local LE_ITEM_ARMOR_COSMETIC = LE_ITEM_ARMOR_COSMETIC or 5;
	local LE_ITEM_ARMOR_SHIELD = LE_ITEM_ARMOR_SHIELD or 6;
	local LE_ITEM_ARMOR_LIBRAM = LE_ITEM_ARMOR_LIBRAM or 7;
	local LE_ITEM_ARMOR_IDOL = LE_ITEM_ARMOR_IDOL or 8;
	local LE_ITEM_ARMOR_TOTEM = LE_ITEM_ARMOR_TOTEM or 9;
	local LE_ITEM_ARMOR_SIGIL = LE_ITEM_ARMOR_SIGIL or 10;
	local LE_ITEM_ARMOR_RELIC = LE_ITEM_ARMOR_RELIC or 11;
	local LE_ITEM_RECIPE_BOOK = LE_ITEM_RECIPE_BOOK or 0;
	local LE_ITEM_RECIPE_LEATHERWORKING = LE_ITEM_RECIPE_LEATHERWORKING or 1;
	local LE_ITEM_RECIPE_TAILORING = LE_ITEM_RECIPE_TAILORING or 2;
	local LE_ITEM_RECIPE_ENGINEERING = LE_ITEM_RECIPE_ENGINEERING or 3;
	local LE_ITEM_RECIPE_BLACKSMITHING = LE_ITEM_RECIPE_BLACKSMITHING or 4;
	local LE_ITEM_RECIPE_COOKING = LE_ITEM_RECIPE_COOKING or 5;
	local LE_ITEM_RECIPE_ALCHEMY = LE_ITEM_RECIPE_ALCHEMY or 6;
	local LE_ITEM_RECIPE_FIRST_AID = LE_ITEM_RECIPE_FIRST_AID or 7;
	local LE_ITEM_RECIPE_ENCHANTING = LE_ITEM_RECIPE_ENCHANTING or 8;
	local LE_ITEM_RECIPE_FISHING = LE_ITEM_RECIPE_FISHING or 9;
	local LE_ITEM_RECIPE_JEWELCRAFTING = LE_ITEM_RECIPE_JEWELCRAFTING or 10;
	local LE_ITEM_RECIPE_INSCRIPTION = LE_ITEM_RECIPE_INSCRIPTION or 11;
	local LE_ITEM_MISCELLANEOUS_JUNK = LE_ITEM_MISCELLANEOUS_JUNK or 0;
	local LE_ITEM_MISCELLANEOUS_REAGENT = LE_ITEM_MISCELLANEOUS_REAGENT or 1;
	local LE_ITEM_MISCELLANEOUS_COMPANION_PET = LE_ITEM_MISCELLANEOUS_COMPANION_PET or 2;
	local LE_ITEM_MISCELLANEOUS_HOLIDAY = LE_ITEM_MISCELLANEOUS_HOLIDAY or 3;
	local LE_ITEM_MISCELLANEOUS_OTHER = LE_ITEM_MISCELLANEOUS_OTHER or 4;
	local LE_ITEM_MISCELLANEOUS_MOUNT = LE_ITEM_MISCELLANEOUS_MOUNT or 5;
-->

l10n.extra_skill_name = {  };

--
l10n["OK"] = "OK";
l10n["Search"] = "Search";
l10n["OVERRIDE_OPEN"] = "Open";
l10n["OVERRIDE_CLOSE"] = "Close";
l10n["SEND_REAGENTS"] = "Send Reagents";
l10n["ADD_FAV"] = "Favorite";
l10n["SUB_FAV"] = "Unfavorite";
l10n["QUERY_WHO_CAN_CRAFT_IT"] = "Who can craft it ?";
--
l10n["showUnkown"] = "Unknown";
l10n["showKnown"] = "Known";
l10n["showHighRank"] = "HighRank";
l10n["filterClass"] = CT.SELFLCLASS;
l10n["filterSpec"] = "MySpec";
l10n["showItemInsteadOfSpell"] = "ItemTip";
l10n["showRank"] = "Rank";
l10n["haveMaterials"] = "haveMaterials";
l10n["showUnkownTip"] = "Show unlearned recipes";
l10n["showKnownTip"] = "Show learned recipes";
l10n["showHighRankTip"] = "Show recipes of higher rank";
l10n["filterClassTip"] = "Hide recipes unavailable to" .. CT.SELFLCLASS;
l10n["filterSpecTip"] = "Hide recipes unavailable to current specialization";
l10n["showItemInsteadOfSpellTip"] = "Show item in tip instead of spell";
l10n["showRankTip"] = "Show colored difficulty rank";
--
l10n["PROFIT_SHOW_COST_ONLY"] = "Show cost only";
--
l10n["LABEL_RANK_LEVEL"] = "|cffff7f00Rank: |r";
l10n["LABEL_GET_FROM"] = "|cffff7f00Get from: |r";
l10n["quest"] = "Quest";
l10n["item"] = "Item";
l10n["object"] = "Object";
l10n["trainer"] = "Trainer";
l10n["quest_reward"] = "Quest reward";
l10n["quest_accepted_from"] = "Quest given by";
l10n["sold_by"] = "Sold by";
l10n["dropped_by"] = "Dropped by";
l10n["world_drop"] = "World drop";
l10n["dropped_by_mod_level"] = "Mob Lv";
l10n["tradable"] = "Tradable";
l10n["non_tradable"] = "Non-tradable";
l10n["elite"] = "Elite";
l10n["phase"] = "Phase";
l10n["unknown area"] = "Unknown area";
l10n["NOT_AVAILABLE_FOR_PLAYER'S_FACTION"] = "Not available for player's faction";
l10n["AVAILABLE_IN_PHASE_"] = "Available in phase ";
l10n["LABEL_ACCOUT_RECIPE_LEARNED"] = "|cffff7f00Status of characters:|r";
l10n["LABEL_USED_AS_MATERIAL_IN"] = "|cffff7f00Used to craft: |r";
l10n["RECIPE_LEARNED"] = "|cff00ff00Learned|r";
l10n["RECIPE_NOT_LEARNED"] = "|cffff0000Not learned|r";

l10n["PRINT_MATERIALS: "] = "Needs: ";
l10n["PRICE_UNK"] = "Unknown";
l10n["AH_PRICE"] = "|cff00ff00AH|r";
l10n["VENDOR_RPICE"] = "|cffffaf00Vendor|r";
l10n["COST_PRICE"] = "|cffff7f00Cost|r";
l10n["COST_PRICE_KNOWN"] = "|cffff0000Known Material|r";
l10n["UNKOWN_PRICE"] = "|cffff0000Unkown|r";
l10n["BOP"] = "|cffff7f7fBOP|r";
l10n["PRICE_DIFF+"] = "|cff00ff00Diff|r";
l10n["PRICE_DIFF-"] = "|cffff0000Diff|r";
l10n["PRICE_DIFF0"] = "The same";
l10n["PRICE_DIFF_AH+"] = "|cff00ff00AH5%|r";
l10n["PRICE_DIFF_AH-"] = "|cffff0000AH5%|r";
l10n["PRICE_DIFF_AH0"] = "AH";
l10n["PRICE_DIFF_INFO+"] = "|cff00ff00+|r";
l10n["PRICE_DIFF_INFO-"] = "|cffff0000-|r";
l10n["CRAFT_INFO"] = "|cffff7f00Craft info: |r";
l10n["CRAFTED_BY"] = "|cffff7f00Crafted by: |r";
l10n["ITEMS_UNK"] = "items unk";
l10n["NEED_UPDATE"] = "|cffff0000!!Need refresh!!|r";
--
l10n["TIP_SEARCH_NAME_ONLY_INFO"] = "|cffffffSearch name instead of hyperlink|r";
l10n["TIP_HAVE_MATERIALS_INFO"] = "|cffffffffShow recipes that u have enough materials|r";
l10n["TIP_PROFIT_FRAME_CALL_INFO"] = "|cffffffffEarn some money! |r";
--
l10n["BOARD_LOCK"] = "LOCK";
l10n["BOARD_CLOSE"] = "CLOSE";
l10n["BOARD_TIP"] = "Show cooldown of tradeskill among account. Right-click to toggle or lock";
l10n["COLORED_FORMATTED_TIME_LEN"] = {
	"|cff%.2x%.2x00%dd %02dh %02dm %02ds|r",
	"|cff%.2x%.2x00%dh %02dm %02ds|r",
	"|cff%.2x%.2x00%dm %02ds|r",
	"|cff%.2x%.2x00%ds|r",
};
l10n["COOLDOWN_EXPIRED"] = "|cff00ff00Available|r";
--
l10n["EXPLORER_TITLE"] = "ALA ";
l10n.EXPLORER_SET = {
	Skill = "Skill",
	Type = "Type",
	SubType = "SubType",
	EquipLoc = "EqLoc",
};
l10n.ITEM_TYPE_LIST = {
	[LE_ITEM_CLASS_CONSUMABLE] = "Consumable",				--	0	Consumable
	[LE_ITEM_CLASS_CONTAINER] = "Container",				--	1	Container
	[LE_ITEM_CLASS_WEAPON] = "Weapon",						--	2	Weapon
	[LE_ITEM_CLASS_GEM] = "Gem",							--	3	Gem
	[LE_ITEM_CLASS_ARMOR] = "Armor",						--	4	Armor
	[LE_ITEM_CLASS_REAGENT] = "Reagent",					--	5	Reagent Obsolete
	[LE_ITEM_CLASS_PROJECTILE] = "Projectile",				--	6	Projectile Obsolete
	[LE_ITEM_CLASS_TRADEGOODS] = "Tradeskill",				--	7	Tradeskill
	[LE_ITEM_CLASS_ITEM_ENHANCEMENT] = "Item Enhancement",	--	8	Item Enhancement
	[LE_ITEM_CLASS_RECIPE] = "Recipe",						--	9	Recipe
	[10] = "Money",											--	10	Money(OBSOLETE)
	[LE_ITEM_CLASS_QUIVER] = "Quiver",						--	11	Quiver Obsolete
	[LE_ITEM_CLASS_QUESTITEM] = "Quest",					--	12	Quest
	[LE_ITEM_CLASS_KEY] = "Key",							--	13	Key Obsolete
	[14] = "Permanent",										--	14	Permanent(OBSOLETE)
	[LE_ITEM_CLASS_MISCELLANEOUS] = "Miscellaneous",		--	15	Miscellaneous
	[LE_ITEM_CLASS_GLYPH] = "Glyph",						--	16	Glyph
	[LE_ITEM_CLASS_BATTLEPET] = "Battle Pets",				--	17	Battle Pets
	[LE_ITEM_CLASS_WOW_TOKEN] = "WoW Token",				--	18	WoW Token
};
l10n.ITEM_SUB_TYPE_LIST = {
	[LE_ITEM_CLASS_CONSUMABLE] = {			--	0	Consumable
		[0] = "Consumable", 
		[1] = "Potion", 
		[2] = "Elixir", 
		[3] = "Flask", 
		[4] = "Scroll ", 
		[5] = "Food & Drink", 
		[6] = "Item Enhancement ", 
		[7] = "Bandage", 
		[8] = "Other", 
		[9] = "Vantus Runes", 
	},
	[LE_ITEM_CLASS_CONTAINER] = {			--	1	Container
		[0] = "Bag", 
		[1] = "Soul Bag", 
		[2] = "Herb Bag", 
		[3] = "Enchanting Bag", 
		[4] = "Engineering Bag", 
		[5] = "Gem Bag", 
		[6] = "Mining Bag", 
		[7] = "Leatherworking Bag", 
		[8] = "Inscription Bag", 
		[9] = "Tackle Box", 
		[10] = "Cooking Bag", 
	},
	[LE_ITEM_CLASS_WEAPON] = {								--	2	Weapon
		[LE_ITEM_WEAPON_AXE1H] = "One-Handed Axes", 		--	0
		[LE_ITEM_WEAPON_AXE2H] = "Two-Handed Axes", 		--	1
		[LE_ITEM_WEAPON_BOWS] = "Bows", 					--	2
		[LE_ITEM_WEAPON_GUNS] = "Guns", 					--	3
		[LE_ITEM_WEAPON_MACE1H] = "One-Handed Maces", 		--	4
		[LE_ITEM_WEAPON_MACE2H] = "Two-Handed Maces", 		--	5
		[LE_ITEM_WEAPON_POLEARM] = "Polearms", 				--	6
		[LE_ITEM_WEAPON_SWORD1H] = "One-Handed Swords", 	--	7
		[LE_ITEM_WEAPON_SWORD2H] = "Two-Handed Swords", 	--	8
		[LE_ITEM_WEAPON_WARGLAIVE] = "Warglaives", 			--	9
		[LE_ITEM_WEAPON_STAFF] = "Staves", 					--	10
		[LE_ITEM_WEAPON_EXOTIC1H] = "Bear Claws", 			--	11	--	LE_ITEM_WEAPON_BEARCLAW
		[LE_ITEM_WEAPON_EXOTIC2H] = "CatClaws", 				--	12	--	LE_ITEM_WEAPON_CATCLAW
		[LE_ITEM_WEAPON_UNARMED] = "Fist Weapons", 			--	13
		[LE_ITEM_WEAPON_GENERIC] = "Miscellaneous", 		--	14
		[LE_ITEM_WEAPON_DAGGER] = "Daggers", 				--	15
		[LE_ITEM_WEAPON_THROWN] = "Thrown", 				--	16
		[LE_ITEM_WEAPON_SPEAR] = "Spears", 					--	17
		[LE_ITEM_WEAPON_CROSSBOW] = "Crossbows", 			--	18
		[LE_ITEM_WEAPON_WAND] = "Wands", 					--	19
		[LE_ITEM_WEAPON_FISHINGPOLE] = "Fishing Poles", 	--	20
	},
	[LE_ITEM_CLASS_GEM] = not CT.ISCLASSIC and {					--	3	Gem
		[LE_ITEM_GEM_RED] = "Red Gem",					--	0	--	Intellect
		[LE_ITEM_GEM_BLUE] = "Blue Gem",				--	1	--	Agility
		[LE_ITEM_GEM_YELLOW] = "Yellow Gem",				--	2	--	Strength
		[LE_ITEM_GEM_PURPLE] = "Purple Gem",				--	3	--	Stamina
		[LE_ITEM_GEM_GREEN] = "Green Gem",				--	4	--	Spirit
		[LE_ITEM_GEM_ORANGE] = "Orange Gem",				--	5	--	Critical Strike
		[LE_ITEM_GEM_META] = "Meta Gem",				--	6	--	Mastery
		[LE_ITEM_GEM_SIMPLE] = "Simple Gem",				--	7	--	Haste
		[LE_ITEM_GEM_PRISMATIC] = "Prismatic Gem",			--	8	--	Versatility
	} or {
		[LE_ITEM_GEM_INTELLECT] = "Intellect", 				--	0
		[LE_ITEM_GEM_AGILITY] = "Agility", 					--	1
		[LE_ITEM_GEM_STRENGTH] = "Strength", 				--	2
		[LE_ITEM_GEM_STAMINA] = "Stamina", 					--	3
		[LE_ITEM_GEM_SPIRIT] = "Spirit", 					--	4
		[LE_ITEM_GEM_CRITICALSTRIKE] = "Critical Strike", 	--	5
		[LE_ITEM_GEM_MASTERY] = "Mastery", 					--	6
		[LE_ITEM_GEM_HASTE] = "Haste", 						--	7
		[LE_ITEM_GEM_VERSATILITY] = "Versatility", 			--	8
		[9] = "Other", 										--	9
		[LE_ITEM_GEM_MULTIPLESTATS] = "Multiple Stats", 	--	10
		[LE_ITEM_GEM_ARTIFACTRELIC] = "Artifact Relic", 	--	11
	},
	[LE_ITEM_CLASS_ARMOR] = {						--	4	Armor
		[LE_ITEM_ARMOR_GENERIC] = "Miscellaneous", 	--	0	Includes Spellstones, Firestones, Trinkets, Rings and Necks
		[LE_ITEM_ARMOR_CLOTH] = "Cloth", 			--	1
		[LE_ITEM_ARMOR_LEATHER] = "Leather", 		--	2
		[LE_ITEM_ARMOR_MAIL] = "Mail", 				--	3
		[LE_ITEM_ARMOR_PLATE] = "Plate", 			--	4
		[LE_ITEM_ARMOR_COSMETIC] = "Cosmetic", 		--	5
		[LE_ITEM_ARMOR_SHIELD] = "Shields", 		--	6
		[LE_ITEM_ARMOR_LIBRAM] = "Librams", 		--	7
		[LE_ITEM_ARMOR_IDOL] = "Idols", 			--	8
		[LE_ITEM_ARMOR_TOTEM] = "Totems", 			--	9
		[LE_ITEM_ARMOR_SIGIL] = "Sigils", 			--	10
		[LE_ITEM_ARMOR_RELIC] = "Relic", 			--	11
	},
	[LE_ITEM_CLASS_REAGENT] = {				--	5	Reagent Obsolete
		[0] = "Reagent", 
		[1] = "Keystone", 
	},
	[LE_ITEM_CLASS_PROJECTILE] = {			--	6	Projectile Obsolete
		[0] = "Wand", 
		[1] = "Bolt", 
		[2] = "Arrow", 
		[3] = "Bullet", 
		[4] = "Thrown", 
	},
	[LE_ITEM_CLASS_TRADEGOODS] = {			--	7	Tradeskill
		[0] = "Trade Goods ", 
		[1] = "Parts", 
		[2] = "Explosives ", 
		[3] = "Devices ", 
		[4] = "Jewelcrafting", 
		[5] = "Cloth", 
		[6] = "Leather", 
		[7] = "Metal & Stone", 
		[8] = "Cooking", 
		[9] = "Herb", 
		[10] = "Elemental", 
		[11] = "Other", 
		[12] = "Enchanting", 
		[13] = "Materials ", 
		[14] = "Item Enchantment ", 
		[15] = "Weapon Enchantment", 
		[16] = "Inscription", 
		[17] = "Explosives and Devices ", 
	},
	[LE_ITEM_CLASS_ITEM_ENHANCEMENT] = {	--	8	Item Enhancement
		[0] = "Head", 
		[1] = "Neck", 
		[2] = "Shoulder", 
		[3] = "Cloak", 
		[4] = "Chest", 
		[5] = "Wrist", 
		[6] = "Hands", 
		[7] = "Waist", 
		[8] = "Legs", 
		[9] = "Feet", 
		[10] = "Finger", 
		[11] = "Weapon	One-handed weapons", 
		[12] = "Two-Handed Weapon", 
		[13] = "Shield/Off-hand", 
		[14] = "Misc", 
	},
	[LE_ITEM_CLASS_RECIPE] = {				--	9	Recipe
		[LE_ITEM_RECIPE_BOOK] = "Book", 					--	0
		[LE_ITEM_RECIPE_LEATHERWORKING] = "Leatherworking", --	1
		[LE_ITEM_RECIPE_TAILORING] = "Tailoring", 			--	2
		[LE_ITEM_RECIPE_ENGINEERING] = "Engineering", 		--	3
		[LE_ITEM_RECIPE_BLACKSMITHING] = "Blacksmithing", 	--	4
		[LE_ITEM_RECIPE_COOKING] = "Cooking", 				--	5
		[LE_ITEM_RECIPE_ALCHEMY] = "Alchemy", 				--	6
		[LE_ITEM_RECIPE_FIRST_AID] = "First Aid", 			--	7
		[LE_ITEM_RECIPE_ENCHANTING] = "Enchanting", 		--	8
		[LE_ITEM_RECIPE_FISHING] = "Fishing", 				--	9
		[LE_ITEM_RECIPE_JEWELCRAFTING] = "Jewelcrafting", 	--	10
		[LE_ITEM_RECIPE_INSCRIPTION] = "Inscription", 		--	11
	},
	[10] = {								--	10	Money(OBSOLETE)
		[0] = "Money",
	},
	[LE_ITEM_CLASS_QUIVER] = {				--	11	Quiver Obsolete
		[0] = "Quiver(OBSOLETE)",
		[1] = "Bolt(OBSOLETE)",
		[2] = "Quiver",
		[3] = "Ammo Pouch",
	},
	[LE_ITEM_CLASS_QUESTITEM] = {			--	12	Quest
		[0] = "Quest",
	},
	[LE_ITEM_CLASS_KEY] = {					--	13	Key Obsolete
		[0] = "Key",
		[1] = "Lockpick",
	},
	[14] = {								--	14	Permanent(OBSOLETE)
		[0] = "Permanent",
	},
	[LE_ITEM_CLASS_MISCELLANEOUS] = {		--	15	Miscellaneous
		[LE_ITEM_MISCELLANEOUS_JUNK] = "Junk",							--	0
		[LE_ITEM_MISCELLANEOUS_REAGENT] = "Reagent",					--	17: Tradeskill.
		[LE_ITEM_MISCELLANEOUS_COMPANION_PET] = "Companion Pets",		--	2
		[LE_ITEM_MISCELLANEOUS_HOLIDAY] = "Holiday",					--	3
		[LE_ITEM_MISCELLANEOUS_OTHER] = "Other",						--	4
		[LE_ITEM_MISCELLANEOUS_MOUNT] = "Mount",						--	5
		-- [LE_ITEM_MISCELLANEOUS_MOUNT_EQUIPMENT] = "Mount Equipment",	--	6
	},
	[LE_ITEM_CLASS_GLYPH] = {				--	16	Glyph
		[1] = "Warrior",
		[2] = "Paladin",
		[3] = "Hunter",
		[4] = "Rogue",
		[5] = "Priest",
		[6] = "Death Knight",
		[7] = "Shaman",
		[8] = "Mage",
		[9] = "Warlock",
		[10] = "Monk",
		[11] = "Druid",
		[12] = "Demon Hunter",
	},
	[LE_ITEM_CLASS_BATTLEPET] = {			--	17	Battle Pets
		[0] = "Humanoid",
		[1] = "Dragonkin",
		[2] = "Flying",
		[3] = "Undead",
		[4] = "Critter",
		[5] = "Magic",
		[6] = "Elemental",
		[7] = "Beast",
		[8] = "Aquatic",
		[9] = "Mechanical",
	},
	[LE_ITEM_CLASS_WOW_TOKEN] = {			--	18	WoW Token
		[0] = "WoW Token",
	},
};
l10n.ITEM_EQUIP_LOC = {
	[0] = "Ammo",
	[1] = "Head",
	[2] = "Neck",
	[3] = "Shoulder",
	[4] = "Shirt",
	[5] = "Chest",
	[6] = "Waist",
	[7] = "Legs",
	[8] = "Feet",
	[9] = "Wrist",
	[10] = "Hands",
	[11] = "Fingers",
	[13] = "Trinkets",
	[15] = "Cloaks",
	[16] = "Main-Hand",
	[17] = "Off-Hand",
	[18] = "Ranged",
	[19] = "Tabard",
	[20] = "Containers",
	[21] = "One-Hand",
	[22] = "Two-Handed",
};
l10n["EXPLORER_CLEAR_FILTER"] = "|cff00ff00Clear|r";
--
l10n.SLASH_NOTE = {
	["expand"] = "Expand frame",
	["blz_style"] = "Blizzard style",
	["bg_color"] = "Click to set background color",
	["show_tradeskill_frame_price_info"] = "Show price info in tradeskill frame",
	["show_tradeskill_frame_rank_info"] = "Show rank info in tradeskill frame",
	["show_tradeskill_tip_craft_item_price"] = "Show info in tooltip of item",
	["show_tradeskill_tip_craft_spell_price"] = "Show info in tooltip of skill",
	["show_tradeskill_tip_recipe_price"] = "Show info in tooltip of recipes",
	["show_tradeskill_tip_recipe_account_learned"] = "Show other characters in tooltip of recipe",
	["show_tradeskill_tip_material_craft_info"] = "List skills using the item as material",
	["default_skill_button_tip"] = "Show tooltip on blizzard's skill button",
	["colored_rank_for_unknown"] = "Color name by rank for unknown spell",
	["regular_exp"] = "Regular Expression Search|cffff0000!!!Caution!!!|r",
	["show_call"] = "Show UI toggle button",
	["show_tab"] = "Show switch bar",
	["portrait_button"] = "Dropdown menu on the tradeskill frame portrait",
	["show_board"] = "Show board",
	["lock_board"] = "Lock board",
	["show_DBIcon"] = "Show DBIcon on minimap",
	["hide_mtsl"] = "Hide MTSL",
	["first_auction_mod"] = "Use this auction addon first",
	["first_auction_mod:*"] = "Auto",
};
l10n.ALPHA = "Alpha";
l10n.CHAR_LIST = "Character list";
l10n.CHAR_DEL = "Del character";
l10n["INVALID_COMMANDS"] = "Invalid commonds. Use |cff00ff00true, 1, on, enable|r or |cffff0000false, 0, off, disable|r instead.";
l10n.TooltipLines = {
	"Left Click: Open Explorer",
	"Right Click: Open SettingUI",
};

--
l10n.ENCHANT_FILTER = {	--	esMX
	INVTYPE_CLOAK = "capa",
	INVTYPE_CHEST = "pechera",
	INVTYPE_WRIST = "brazal",
	INVTYPE_HAND = "guantes",
	INVTYPE_FEET = "botas",
	INVTYPE_WEAPON = "arma",
	INVTYPE_SHIELD = "escudo",
	NONE = "No matched enchating recipe",
};

l10n.ENCHANT_FILTER.INVTYPE_ROBE = l10n.ENCHANT_FILTER.INVTYPE_CHEST;
l10n.ENCHANT_FILTER.INVTYPE_2HWEAPON = l10n.ENCHANT_FILTER.INVTYPE_WEAPON;
l10n.ENCHANT_FILTER.INVTYPE_WEAPONMAINHAND = l10n.ENCHANT_FILTER.INVTYPE_WEAPON;
l10n.ENCHANT_FILTER.INVTYPE_WEAPONOFFHAND = l10n.ENCHANT_FILTER.INVTYPE_WEAPON;

