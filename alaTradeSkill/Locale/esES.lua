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
l10n["PROFIT_SHOW_CUR_EXPAC_ONLY"] = "Current Expac Only";
--
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
--
l10n["PREV"] = "Prev";
l10n["NEXT"] = "Next";
l10n["PRINT_MATERIALS: "] = "Needs: ";
l10n["PRICE_UNK"] = "Unknown";
l10n["AH_PRICE"] = "|cff00ff00Sell|r";
l10n["VENDOR_RPICE"] = "|cffffaf00Vendor|r";
l10n["COST_PRICE"] = "|cffff7f00Cost|r";
l10n["COST_PRICE_KNOWN"] = "|cffff0000Known Materials|r";
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
l10n["QueueToggleButton"] = "Queue";
l10n["AddQueue"] = "Add";
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
	[CT._ITEM_CLASS_CONSUMABLE] = "Consumable",				--	0	Consumable
	[CT._ITEM_CLASS_CONTAINER] = "Container",				--	1	Container
	[CT._ITEM_CLASS_WEAPON] = "Weapon",						--	2	Weapon
	[CT._ITEM_CLASS_GEM] = "Gem",							--	3	Gem
	[CT._ITEM_CLASS_ARMOR] = "Armor",						--	4	Armor
	[CT._ITEM_CLASS_REAGENT] = "Reagent",					--	5	Reagent Obsolete
	[CT._ITEM_CLASS_PROJECTILE] = "Projectile",				--	6	Projectile Obsolete
	[CT._ITEM_CLASS_TRADEGOODS] = "Tradeskill",				--	7	Tradeskill
	[CT._ITEM_CLASS_ITEM_ENHANCEMENT] = "Item Enhancement",	--	8	Item Enhancement
	[CT._ITEM_CLASS_RECIPE] = "Recipe",						--	9	Recipe
	[CT._ITEM_CLASS_ITEM_CURRENCY] = "Money",											--	10	Money(OBSOLETE)
	[CT._ITEM_CLASS_QUIVER] = "Quiver",						--	11	Quiver Obsolete
	[CT._ITEM_CLASS_QUESTITEM] = "Quest",					--	12	Quest
	[CT._ITEM_CLASS_KEY] = "Key",							--	13	Key Obsolete
	[CT._ITEM_CLASS_PERMANENT] = "Permanent",										--	14	Permanent(OBSOLETE)
	[CT._ITEM_CLASS_MISCELLANEOUS] = "Miscellaneous",		--	15	Miscellaneous
	[CT._ITEM_CLASS_GLYPH] = "Glyph",						--	16	Glyph
	[CT._ITEM_CLASS_BATTLEPET] = "Battle Pets",				--	17	Battle Pets
	[CT._ITEM_CLASS_WOW_TOKEN] = "WoW Token",				--	18	WoW Token
};
l10n.ITEM_SUB_TYPE_LIST = {
	[CT._ITEM_CLASS_CONSUMABLE] = {			--	0	Consumable
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
	[CT._ITEM_CLASS_CONTAINER] = {			--	1	Container
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
	[CT._ITEM_CLASS_WEAPON] = {								--	2	Weapon
		[CT._ITEM_WEAPON_AXE1H] = "One-Handed Axes", 		--	0
		[CT._ITEM_WEAPON_AXE2H] = "Two-Handed Axes", 		--	1
		[CT._ITEM_WEAPON_BOWS] = "Bows", 					--	2
		[CT._ITEM_WEAPON_GUNS] = "Guns", 					--	3
		[CT._ITEM_WEAPON_MACE1H] = "One-Handed Maces", 		--	4
		[CT._ITEM_WEAPON_MACE2H] = "Two-Handed Maces", 		--	5
		[CT._ITEM_WEAPON_POLEARM] = "Polearms", 				--	6
		[CT._ITEM_WEAPON_SWORD1H] = "One-Handed Swords", 	--	7
		[CT._ITEM_WEAPON_SWORD2H] = "Two-Handed Swords", 	--	8
		[CT._ITEM_WEAPON_WARGLAIVE] = "Warglaives", 			--	9
		[CT._ITEM_WEAPON_STAFF] = "Staves", 					--	10
		[CT._ITEM_WEAPON_BEARCLAW] = "Bear Claws", 			--	11	--	CT._ITEM_WEAPON_BEARCLAW
		[CT._ITEM_WEAPON_CATCLAW] = "CatClaws", 				--	12	--	CT._ITEM_WEAPON_CATCLAW
		[CT._ITEM_WEAPON_UNARMED] = "Fist Weapons", 			--	13
		[CT._ITEM_WEAPON_GENERIC] = "Miscellaneous", 		--	14
		[CT._ITEM_WEAPON_DAGGER] = "Daggers", 				--	15
		[CT._ITEM_WEAPON_THROWN] = "Thrown", 				--	16
		[CT._ITEM_WEAPON_SPEAR] = "Spears", 					--	17
		[CT._ITEM_WEAPON_CROSSBOW] = "Crossbows", 			--	18
		[CT._ITEM_WEAPON_WAND] = "Wands", 					--	19
		[CT._ITEM_WEAPON_FISHINGPOLE] = "Fishing Poles", 	--	20
	},
	[CT._ITEM_CLASS_GEM] = not CT.ISCLASSIC and {					--	3	Gem
		[CT._ITEM_GEM_RED] = "Red Gem",					--	0	--	Intellect
		[CT._ITEM_GEM_BLUE] = "Blue Gem",				--	1	--	Agility
		[CT._ITEM_GEM_YELLOW] = "Yellow Gem",				--	2	--	Strength
		[CT._ITEM_GEM_PURPLE] = "Purple Gem",				--	3	--	Stamina
		[CT._ITEM_GEM_GREEN] = "Green Gem",				--	4	--	Spirit
		[CT._ITEM_GEM_ORANGE] = "Orange Gem",				--	5	--	Critical Strike
		[CT._ITEM_GEM_META] = "Meta Gem",				--	6	--	Mastery
		[CT._ITEM_GEM_SIMPLE] = "Simple Gem",				--	7	--	Haste
		[CT._ITEM_GEM_PRISMATIC] = "Prismatic Gem",			--	8	--	Versatility
	} or {
		[CT._ITEM_GEM_INTELLECT] = "Intellect", 				--	0
		[CT._ITEM_GEM_AGILITY] = "Agility", 					--	1
		[CT._ITEM_GEM_STRENGTH] = "Strength", 				--	2
		[CT._ITEM_GEM_STAMINA] = "Stamina", 					--	3
		[CT._ITEM_GEM_SPIRIT] = "Spirit", 					--	4
		[CT._ITEM_GEM_CRITICALSTRIKE] = "Critical Strike", 	--	5
		[CT._ITEM_GEM_MASTERY] = "Mastery", 					--	6
		[CT._ITEM_GEM_HASTE] = "Haste", 						--	7
		[CT._ITEM_GEM_VERSATILITY] = "Versatility", 			--	8
		[9] = "Other", 										--	9
		[CT._ITEM_GEM_MULTIPLESTATS] = "Multiple Stats", 	--	10
		[CT._ITEM_GEM_ARTIFACTRELIC] = "Artifact Relic", 	--	11
	},
	[CT._ITEM_CLASS_ARMOR] = {						--	4	Armor
		[CT._ITEM_ARMOR_GENERIC] = "Miscellaneous", 	--	0	Includes Spellstones, Firestones, Trinkets, Rings and Necks
		[CT._ITEM_ARMOR_CLOTH] = "Cloth", 			--	1
		[CT._ITEM_ARMOR_LEATHER] = "Leather", 		--	2
		[CT._ITEM_ARMOR_MAIL] = "Mail", 				--	3
		[CT._ITEM_ARMOR_PLATE] = "Plate", 			--	4
		[CT._ITEM_ARMOR_COSMETIC] = "Cosmetic", 		--	5
		[CT._ITEM_ARMOR_SHIELD] = "Shields", 		--	6
		[CT._ITEM_ARMOR_LIBRAM] = "Librams", 		--	7
		[CT._ITEM_ARMOR_IDOL] = "Idols", 			--	8
		[CT._ITEM_ARMOR_TOTEM] = "Totems", 			--	9
		[CT._ITEM_ARMOR_SIGIL] = "Sigils", 			--	10
		[CT._ITEM_ARMOR_RELIC] = "Relic", 			--	11
	},
	[CT._ITEM_CLASS_REAGENT] = {				--	5	Reagent Obsolete
		[0] = "Reagent", 
		[1] = "Keystone", 
	},
	[CT._ITEM_CLASS_PROJECTILE] = {			--	6	Projectile Obsolete
		[0] = "Wand", 
		[1] = "Bolt", 
		[2] = "Arrow", 
		[3] = "Bullet", 
		[4] = "Thrown", 
	},
	[CT._ITEM_CLASS_TRADEGOODS] = {			--	7	Tradeskill
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
	[CT._ITEM_CLASS_ITEM_ENHANCEMENT] = {	--	8	Item Enhancement
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
	[CT._ITEM_CLASS_RECIPE] = {				--	9	Recipe
		[CT._ITEM_RECIPE_BOOK] = "Book", 					--	0
		[CT._ITEM_RECIPE_LEATHERWORKING] = "Leatherworking", --	1
		[CT._ITEM_RECIPE_TAILORING] = "Tailoring", 			--	2
		[CT._ITEM_RECIPE_ENGINEERING] = "Engineering", 		--	3
		[CT._ITEM_RECIPE_BLACKSMITHING] = "Blacksmithing", 	--	4
		[CT._ITEM_RECIPE_COOKING] = "Cooking", 				--	5
		[CT._ITEM_RECIPE_ALCHEMY] = "Alchemy", 				--	6
		[CT._ITEM_RECIPE_FIRST_AID] = "First Aid", 			--	7
		[CT._ITEM_RECIPE_ENCHANTING] = "Enchanting", 		--	8
		[CT._ITEM_RECIPE_FISHING] = "Fishing", 				--	9
		[CT._ITEM_RECIPE_JEWELCRAFTING] = "Jewelcrafting", 	--	10
		[CT._ITEM_RECIPE_INSCRIPTION] = "Inscription", 		--	11
	},
	[10] = {								--	10	Money(OBSOLETE)
		[0] = "Money",
	},
	[CT._ITEM_CLASS_QUIVER] = {				--	11	Quiver Obsolete
		[0] = "Quiver(OBSOLETE)",
		[1] = "Bolt(OBSOLETE)",
		[2] = "Quiver",
		[3] = "Ammo Pouch",
	},
	[CT._ITEM_CLASS_QUESTITEM] = {			--	12	Quest
		[0] = "Quest",
	},
	[CT._ITEM_CLASS_KEY] = {					--	13	Key Obsolete
		[0] = "Key",
		[1] = "Lockpick",
	},
	[14] = {								--	14	Permanent(OBSOLETE)
		[0] = "Permanent",
	},
	[CT._ITEM_CLASS_MISCELLANEOUS] = {		--	15	Miscellaneous
		[CT._ITEM_MISCELLANEOUS_JUNK] = "Junk",							--	0
		[CT._ITEM_MISCELLANEOUS_REAGENT] = "Reagent",					--	17: Tradeskill.
		[CT._ITEM_MISCELLANEOUS_COMPANION_PET] = "Companion Pets",		--	2
		[CT._ITEM_MISCELLANEOUS_HOLIDAY] = "Holiday",					--	3
		[CT._ITEM_MISCELLANEOUS_OTHER] = "Other",						--	4
		[CT._ITEM_MISCELLANEOUS_MOUNT] = "Mount",						--	5
		-- [CT._ITEM_MISCELLANEOUS_MOUNT_EQUIPMENT] = "Mount Equipment",	--	6
	},
	[CT._ITEM_CLASS_GLYPH] = {				--	16	Glyph
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
	[CT._ITEM_CLASS_BATTLEPET] = {			--	17	Battle Pets
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
	[CT._ITEM_CLASS_WOW_TOKEN] = {			--	18	WoW Token
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
	["show_queue_button"] = "Show queue button",
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

