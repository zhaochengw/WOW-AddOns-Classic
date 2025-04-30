--[[--
	by ALA 
--]]--

local __addon, __private = ...;
local CT = __private.CT;

if CT.LOCALE ~= "zhTW" then
	return;
end
local l10n = CT.l10n;
l10n.LOCALE = "zhTW";

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
l10n["OK"] = "確定";
l10n["Search"] = "搜索";
l10n["OVERRIDE_OPEN"] = "打開搜索";
l10n["OVERRIDE_CLOSE"] = "關閉搜索";
l10n["SEND_REAGENTS"] = "發送材料";
l10n["ADD_FAV"] = "添加收藏";
l10n["SUB_FAV"] = "取消收藏";
l10n["QUERY_WHO_CAN_CRAFT_IT"] = "睡會做它？";
--
l10n["showUnkown"] = "未學";
l10n["showKnown"] = "已學";
l10n["showHighRank"] = "高等級";
l10n["filterClass"] = CT.SELFLCLASS;
l10n["filterSpec"] = "專精";
l10n["showItemInsteadOfSpell"] = "物品";
l10n["showRank"] = "難度等級";
l10n["haveMaterials"] = "材料";
l10n["showUnkownTip"] = "顯示還沒學會的配方";
l10n["showKnownTip"] = "顯示已經學會的配方";
l10n["showHighRankTip"] = "顯示高等級的配方";
l10n["filterClassTip"] = "是否過濾掉" .. CT.SELFLCLASS .. "不能學到的配方";
l10n["filterSpecTip"] = "是否過濾掉當前專精不能學到的配方";
l10n["showItemInsteadOfSpellTip"] = "鼠標提示顯示物品而不是技能";
l10n["showRankTip"] = "顯示難度等級";
--
l10n["PROFIT_SHOW_COST_ONLY"] = "只顯示成本";
--
l10n["LABEL_GET_FROM"] = "|cffff7f00來源: |r";
l10n["quest"] = "任務";
l10n["item"] = "物品";
l10n["object"] = "物品";
l10n["trainer"] = "訓練師";
l10n["quest_reward"] = "任務獎勵";
l10n["quest_accepted_from"] = "開始於";
l10n["sold_by"] = "出售";
l10n["dropped_by"] = "掉落自";
l10n["world_drop"] = "世界掉落";
l10n["dropped_by_mod_level"] = "怪物等級";
l10n["tradable"] = "可交易";
l10n["non_tradable"] = "不可交易";
l10n["elite"] = "精英";
l10n["phase"] = "階段";
l10n["unknown area"] = "未知區域";
l10n["NOT_AVAILABLE_FOR_PLAYER'S_FACTION"] = "不適用於當前角色陣營";
l10n["AVAILABLE_IN_PHASE_"] = "開放於階段: ";
l10n["LABEL_ACCOUT_RECIPE_LEARNED"] = "|cffff7f00賬號角色狀態: |r";
l10n["LABEL_USED_AS_MATERIAL_IN"] = "|cffff7f00用於製造: |r";
l10n["RECIPE_LEARNED"] = "|cff00ff00已學|r";
l10n["RECIPE_NOT_LEARNED"] = "|cffff0000未學|r";
--
l10n["PREV"] = "上一個";
l10n["NEXT"] = "下一個";
l10n["PRINT_MATERIALS: "] = "材料: ";
l10n["PRICE_UNK"] = "未知";
l10n["AH_PRICE"] = "|cff00ff00價格|r";
l10n["VENDOR_RPICE"] = "|cffffaf00商人|r";
l10n["COST_PRICE"] = "|cffff7f00成本|r";
l10n["COST_PRICE_KNOWN"] = "|cffff0000已緩存成本|r";
l10n["UNKOWN_PRICE"] = "|cffff0000未知價格|r";
l10n["BOP"] = "|cffff7f7f拾取綁定|r";
l10n["PRICE_DIFF+"] = "|cff00ff00差價|r";
l10n["PRICE_DIFF-"] = "|cffff0000差價|r";
l10n["PRICE_DIFF0"] = "持平";
l10n["PRICE_DIFF_AH+"] = "|cff00ff00AH5%|r";
l10n["PRICE_DIFF_AH-"] = "|cffff0000AH5%|r";
l10n["PRICE_DIFF_AH0"] = "AH";
l10n["PRICE_DIFF_INFO+"] = "|cff00ff00利潤|r";
l10n["PRICE_DIFF_INFO-"] = "|cffff0000虧損|r";
l10n["CRAFT_INFO"] = "|cffff7f00商業技能製造信息: |r";
l10n["CRAFTED_BY"] = "|cffff7f00可由以下角色製作: |r";
l10n["ITEMS_UNK"] = "項未知";
l10n["NEED_UPDATE"] = "|cffff0000!!需要刷新!!|r";
--
l10n["QueueToggleButton"] = "隊列";
l10n["AddQueue"] = "Add";
--
l10n["TIP_SEARCH_NAME_ONLY_INFO"] = "|cffffffff只搜索名字，而不是物品鏈接|r";
l10n["TIP_HAVE_MATERIALS_INFO"] = "|cffffffff只顯示有足夠材料的配方|r";
l10n["TIP_PROFIT_FRAME_CALL_INFO"] = "|cffffffff我想賺點零花錢! |r";
--
l10n["BOARD_LOCK"] = "鎖定";
l10n["BOARD_CLOSE"] = "關閉";
l10n["BOARD_TIP"] = "顯示賬號下角色的商業技能冷卻時間，鼠標右擊鎖定或關閉";
l10n["COLORED_FORMATTED_TIME_LEN"] = {
	"|cff%.2x%.2x00%d天%02d時%02d分%02d秒|r",
	"|cff%.2x%.2x00%d時%02d分%02d秒|r",
	"|cff%.2x%.2x00%d分%02d秒|r",
	"|cff%.2x%.2x00%d秒|r",
};
l10n["COOLDOWN_EXPIRED"] = "|cff00ff00冷卻結束|r";
--
l10n["EXPLORER_TITLE"] = "配方瀏覽器";
l10n.EXPLORER_SET = {
	Skill = "技能",
	Type = "物品類型",
	SubType = "子類型",
	EquipLoc = "裝備部位",
};
l10n.ITEM_TYPE_LIST = {
	[LE_ITEM_CLASS_CONSUMABLE] = "消耗品",				--	0	Consumable
	[LE_ITEM_CLASS_CONTAINER] = "容器",					--	1	Container
	[LE_ITEM_CLASS_WEAPON] = "武器",					--	2	Weapon
	[LE_ITEM_CLASS_GEM] = "寶石",						--	3	Gem
	[LE_ITEM_CLASS_ARMOR] = "護甲",						--	4	Armor
	[LE_ITEM_CLASS_REAGENT] = "材料",					--	5	Reagent Obsolete
	[LE_ITEM_CLASS_PROJECTILE] = "彈藥",				--	6	Projectile Obsolete
	[LE_ITEM_CLASS_TRADEGOODS] = "商品",				--	7	Tradeskill
	[LE_ITEM_CLASS_ITEM_ENHANCEMENT] = "物品附魔",		--	8	Item Enhancement
	[LE_ITEM_CLASS_RECIPE] = "配方",					--	9	Recipe
	[10] = "Money",										--	10	Money(OBSOLETE)
	[LE_ITEM_CLASS_QUIVER] = "箭袋",					--	11	Quiver Obsolete
	[LE_ITEM_CLASS_QUESTITEM] = "任務",					--	12	Quest
	[LE_ITEM_CLASS_KEY] = "鑰匙",						--	13	Key Obsolete
	[14] = "Permanent",									--	14	Permanent(OBSOLETE)
	[LE_ITEM_CLASS_MISCELLANEOUS] = "其它",				--	15	Miscellaneous
	[LE_ITEM_CLASS_GLYPH] = "雕文",						--	16	Glyph
	[LE_ITEM_CLASS_BATTLEPET] = "戰鬥寵物",				--	17	Battle Pets
	[LE_ITEM_CLASS_WOW_TOKEN] = "WoW Token",			--	18	WoW Token
};
l10n.ITEM_SUB_TYPE_LIST = {
	[LE_ITEM_CLASS_CONSUMABLE] = {			--	0	Consumable
		[0] = "消耗品",				--	Explosives and Devices
		[1] = "藥水",				--	Potion
		[2] = "藥劑",				--	Elixir
		[3] = "合劑",				--	Flask
		[4] = "捲軸",				--	Scroll (OBSOLETE)
		[5] = "食物和飲料",			--	Food & Drink
		[6] = "物品附魔",			--	Item Enhancement (OBSOLETE)
		[7] = "繃帶",				--	Bandage
		[8] = "其它",				--	Other
		[9] = "凡圖斯符文",			--	Vantus Runes
	},
	[LE_ITEM_CLASS_CONTAINER] = {			--	1	Container
		[0] = "容器",		--	Bag
		[1] = "靈魂包",		--	Soul Bag
		[2] = "草藥包",		--	Herb Bag
		[3] = "附魔包",		--	Enchanting Bag
		[4] = "工程包",		--	Engineering Bag
		[5] = "寶石包",		--	Gem Bag
		[6] = "礦石包",		--	Mining Bag
		[7] = "製皮包",		--	Leatherworking Bag
		[8] = "銘文包",		--	Inscription Bag
		[9] = "漁具包",		--	Tackle Box
		[10] = "烹飪包",	--	Cooking Bag
	},
	[LE_ITEM_CLASS_WEAPON] = {				--	2	Weapon
		[LE_ITEM_WEAPON_AXE1H] = "單手斧",			--	0	--	One-Handed Axes
		[LE_ITEM_WEAPON_AXE2H] = "雙手斧",			--	1	--	Two-Handed Axes
		[LE_ITEM_WEAPON_BOWS] = "弓",				--	2	--	Bows
		[LE_ITEM_WEAPON_GUNS] = "槍",				--	3	--	Guns
		[LE_ITEM_WEAPON_MACE1H] = "單手錘",			--	4	--	One-Handed Maces
		[LE_ITEM_WEAPON_MACE2H] = "雙手錘",			--	5	--	Two-Handed Maces
		[LE_ITEM_WEAPON_POLEARM] = "長柄武器",		--	6	--	Polearms
		[LE_ITEM_WEAPON_SWORD1H] = "單手劍",		--	7	--	One-Handed Swords
		[LE_ITEM_WEAPON_SWORD2H] = "雙手劍",		--	8	--	Two-Handed Swords
		[LE_ITEM_WEAPON_WARGLAIVE] = "戰刃",		--	9	--	Warglaives
		[LE_ITEM_WEAPON_STAFF] = "法杖",			--	10	--	Staves
		[LE_ITEM_WEAPON_EXOTIC1H] = "Bear Claws",	--	11	--	LE_ITEM_WEAPON_BEARCLAW	--	Bear Claws
		[LE_ITEM_WEAPON_EXOTIC2H] = "CatClaws",		--	12	--	LE_ITEM_WEAPON_CATCLAW	--	CatClaws
		[LE_ITEM_WEAPON_UNARMED] = "拳套",			--	13	--	Fist Weapons
		[LE_ITEM_WEAPON_GENERIC] = "其它",			--	14	--	Miscellaneous
		[LE_ITEM_WEAPON_DAGGER] = "匕首",			--	15	--	Daggers
		[LE_ITEM_WEAPON_THROWN] = "投擲武器",		--	16	--	Thrown
		[LE_ITEM_WEAPON_SPEAR] = "Spears",			--	17	--	Spears
		[LE_ITEM_WEAPON_CROSSBOW] = "弩",			--	18	--	Crossbows
		[LE_ITEM_WEAPON_WAND] = "魔杖",				--	19	--	Wands
		[LE_ITEM_WEAPON_FISHINGPOLE] = "釣魚竿",	--	20	--	Fishing Poles
	},
	[LE_ITEM_CLASS_GEM] = not CT.ISCLASSIC and {					--	3	Gem
		[LE_ITEM_GEM_RED] = "紅色寶石",					--	0	--	Intellect
		[LE_ITEM_GEM_BLUE] = "藍色寶石",				--	1	--	Agility
		[LE_ITEM_GEM_YELLOW] = "黃色寶石",				--	2	--	Strength
		[LE_ITEM_GEM_PURPLE] = "紫色寶石",				--	3	--	Stamina
		[LE_ITEM_GEM_GREEN] = "綠色寶石",				--	4	--	Spirit
		[LE_ITEM_GEM_ORANGE] = "橙色寶石",				--	5	--	Critical Strike
		[LE_ITEM_GEM_META] = "多彩寶石",				--	6	--	Mastery
		[LE_ITEM_GEM_SIMPLE] = "簡單寶石",				--	7	--	Haste
		[LE_ITEM_GEM_PRISMATIC] = "棱彩寶石",			--	8	--	Versatility
	} or {
		[LE_ITEM_GEM_INTELLECT] = "智力",			--	0	--	Intellect
		[LE_ITEM_GEM_AGILITY] = "敏捷",				--	1	--	Agility
		[LE_ITEM_GEM_STRENGTH] = "力量",			--	2	--	Strength
		[LE_ITEM_GEM_STAMINA] = "耐力",				--	3	--	Stamina
		[LE_ITEM_GEM_SPIRIT] = "精神",				--	4	--	Spirit
		[LE_ITEM_GEM_CRITICALSTRIKE] = "爆擊",		--	5	--	Critical Strike
		[LE_ITEM_GEM_MASTERY] = "精通",				--	6	--	Mastery
		[LE_ITEM_GEM_HASTE] = "急速",				--	7	--	Haste
		[LE_ITEM_GEM_VERSATILITY] = "全能",			--	8	--	Versatility
		[9] = "Other",								--	9	--	Other
		[LE_ITEM_GEM_MULTIPLESTATS] = "多屬性",		--	10	--	Multiple Stats
		[LE_ITEM_GEM_ARTIFACTRELIC] = "神器聖物",	--	11	--	Artifact Relic
	},
	[LE_ITEM_CLASS_ARMOR] = {				--	4	Armor
		[LE_ITEM_ARMOR_GENERIC] = "其它",		--	0	--	Miscellaneous	Includes Spellstones, Firestones, Trinkets, Rings and Necks
		[LE_ITEM_ARMOR_CLOTH] = "布甲",			--	1	--	Cloth
		[LE_ITEM_ARMOR_LEATHER] = "皮甲",		--	2	--	Leather
		[LE_ITEM_ARMOR_MAIL] = "鎖甲",			--	3	--	Mail
		[LE_ITEM_ARMOR_PLATE] = "板甲",			--	4	--	Plate
		[LE_ITEM_ARMOR_COSMETIC] = "Cosmetic",	--	5	--	Cosmetic
		[LE_ITEM_ARMOR_SHIELD] = "盾牌",		--	6	--	Shields
		[LE_ITEM_ARMOR_LIBRAM] = "聖契",		--	7	--	Librams
		[LE_ITEM_ARMOR_IDOL] = "神像",			--	8	--	Idols
		[LE_ITEM_ARMOR_TOTEM] = "圖騰",			--	9	--	Totems
		[LE_ITEM_ARMOR_SIGIL] = "魔印",			--	10	--	Sigils
		[LE_ITEM_ARMOR_RELIC] = "Relic",		--	11	--	Relic
	},
	[LE_ITEM_CLASS_REAGENT] = {				--	5	Reagent Obsolete
		[0] = "材料",		--	Reagent
		[1] = "Keystone",	--	Keystone
	},
	[LE_ITEM_CLASS_PROJECTILE] = {			--	6	Projectile Obsolete
		[0] = "Wand",		--	Wand(OBSOLETE)
		[1] = "Bolt",		--	Bolt(OBSOLETE)
		[2] = "箭",			--	Arrow
		[3] = "子彈",		--	Bullet
		[4] = "投擲武器",	--	Thrown(OBSOLETE)
	},
	[LE_ITEM_CLASS_TRADEGOODS] = {			--	7	Tradeskill
		[0] = "商品",						--	Trade Goods (OBSOLETE)
		[1] = "零件",						--	Parts
		[2] = "爆炸物",						--	Explosives (OBSOLETE)
		[3] = "裝置",						--	Devices (OBSOLETE)
		[4] = "Jewelcrafting",				--	Jewelcrafting
		[5] = "Cloth",						--	Cloth
		[6] = "Leather",					--	Leather
		[7] = "Metal & Stone",				--	Metal & Stone
		[8] = "Cooking",					--	Cooking
		[9] = "Herb",						--	Herb
		[10] = "Elemental",					--	Elemental
		[11] = "Other",						--	Other
		[12] = "Enchanting",				--	Enchanting
		[13] = "Materials",					--	Materials (OBSOLETE)
		[14] = "Item Enchantment",			--	Item Enchantment (OBSOLETE)
		[15] = "Weapon Enchantment",		--	Weapon Enchantment - Obsolete
		[16] = "Inscription",				--	Inscription
		[17] = "Explosives and Devices",	--	Explosives and Devices (OBSOLETE)
	},
	[LE_ITEM_CLASS_ITEM_ENHANCEMENT] = {	--	8	Item Enhancement
		[0] = "頭部",			--	Head
		[1] = "頸部",			--	Neck
		[2] = "肩部",			--	Shoulder
		[3] = "背部",			--	Cloak
		[4] = "胸部",			--	Chest
		[5] = "手腕",			--	Wrist
		[6] = "手",				--	Hands
		[7] = "腰部",			--	Waist
		[8] = "腿部",			--	Legs
		[9] = "腳",				--	Feet
		[10] = "手指",			--	Finger
		[11] = "武器",			--	Weapon	One-handed weapons
		[12] = "雙手武器",		--	Two-Handed Weapon
		[13] = "盾牌/副手",		--	Shield/Off-hand
		[14] = "Misc",			--	Misc
	},
	[LE_ITEM_CLASS_RECIPE] = {				--	9	Recipe
		[LE_ITEM_RECIPE_BOOK] = "書籍",					--	0	--	Book
		[LE_ITEM_RECIPE_LEATHERWORKING] = "製皮",		--	1	--	Leatherworking
		[LE_ITEM_RECIPE_TAILORING] = "裁縫",			--	2	--	Tailoring
		[LE_ITEM_RECIPE_ENGINEERING] = "工程學",		--	3	--	Engineering
		[LE_ITEM_RECIPE_BLACKSMITHING] = "鍛造",		--	4	--	Blacksmithing
		[LE_ITEM_RECIPE_COOKING] = "烹飪",				--	5	--	Cooking
		[LE_ITEM_RECIPE_ALCHEMY] = "煉金術",			--	6	--	Alchemy
		[LE_ITEM_RECIPE_FIRST_AID] = "急救",			--	7	--	First Aid
		[LE_ITEM_RECIPE_ENCHANTING] = "附魔",			--	8	--	Enchanting
		[LE_ITEM_RECIPE_FISHING] = "釣魚",				--	9	--	Fishing
		[LE_ITEM_RECIPE_JEWELCRAFTING] = "珠寶加工",	--	10	--	Jewelcrafting
		[LE_ITEM_RECIPE_INSCRIPTION] = "銘文",			--	11	--	Inscription
	},
	[10] = {								--	10	Money(OBSOLETE)
		[0] = "Money",	--	Money(OBSOLETE)
	},
	[LE_ITEM_CLASS_QUIVER] = {				--	11	Quiver Obsolete
		[0] = "Quiver(OBSOLETE)",	--	Quiver(OBSOLETE)
		[1] = "Bolt(OBSOLETE)",		--	Bolt(OBSOLETE)
		[2] = "箭袋",				--	Quiver
		[3] = "彈藥袋",				--	Ammo Pouch
	},
	[LE_ITEM_CLASS_QUESTITEM] = {			--	12	Quest
		[0] = "任務",			--	Quest
	},
	[LE_ITEM_CLASS_KEY] = {					--	13	Key Obsolete
		[0] = "鑰匙",			--	Key
		[1] = "Lockpick",		--	Lockpick
	},
	[14] = {								--	14	Permanent(OBSOLETE)
		[0] = "Permanent",		--	Permanent
	},
	[LE_ITEM_CLASS_MISCELLANEOUS] = {		--	15	Miscellaneous
		[LE_ITEM_MISCELLANEOUS_JUNK] = "垃圾",							--	0	--	Junk
		[LE_ITEM_MISCELLANEOUS_REAGENT] = "Reagent",					--	1	--	Reagent	Mainly spell reagents. For crafting reagents see 7: Tradeskill.
		[LE_ITEM_MISCELLANEOUS_COMPANION_PET] = "Companion Pets",		--	2	--	Companion Pets
		[LE_ITEM_MISCELLANEOUS_HOLIDAY] = "Holiday",					--	3	--	Holiday
		[LE_ITEM_MISCELLANEOUS_OTHER] = "Other",						--	4	--	Other
		[LE_ITEM_MISCELLANEOUS_MOUNT] = "Mount",						--	5	--	Mount
		-- [LE_ITEM_MISCELLANEOUS_MOUNT_EQUIPMENT] = "Mount Equipment",	--	6	--	Mount Equipment
	},
	[LE_ITEM_CLASS_GLYPH] = {				--	16	Glyph
		[1] = "Warrior",		--	Warrior
		[2] = "Paladin",		--	Paladin
		[3] = "Hunter",			--	Hunter
		[4] = "Rogue",			--	Rogue
		[5] = "Priest",			--	Priest
		[6] = "Death Knight",	--	Death Knight
		[7] = "Shaman",			--	Shaman
		[8] = "Mage",			--	Mage
		[9] = "Warlock",		--	Warlock
		[10] = "Monk",			--	Monk
		[11] = "Druid",			--	Druid
		[12] = "Demon Hunter",	--	Demon Hunter
	},
	[LE_ITEM_CLASS_BATTLEPET] = {			--	17	Battle Pets
		[0] = "Humanoid",		--	Humanoid
		[1] = "Dragonkin",		--	Dragonkin
		[2] = "Flying",			--	Flying
		[3] = "Undead",			--	Undead
		[4] = "Critter",		--	Critter
		[5] = "Magic",			--	Magic
		[6] = "Elemental",		--	Elemental
		[7] = "Beast",			--	Beast
		[8] = "Aquatic",		--	Aquatic
		[9] = "Mechanical",		--	Mechanical
	},
	[LE_ITEM_CLASS_WOW_TOKEN] = {			--	18	WoW Token
		[0] = "WoW Token",		--	WoW Token
	},
};
l10n.ITEM_EQUIP_LOC = {
	[0] = "彈藥",
	[1] = "頭部",
	[2] = "頸部",
	[3] = "肩部",
	[4] = "襯衣",
	[5] = "胸部",
	[6] = "腰部",
	[7] = "腿部",
	[8] = "腳部",
	[9] = "手腕",
	[10] = "手",
	[11] = "手指",
	[13] = "飾品",
	[15] = "背部",
	[16] = "主手",
	[17] = "副手",
	[18] = "遠程",
	[19] = "戰袍",
	[20] = "背包",
	[21] = "單手武器",
	[22] = "雙手武器",
};
l10n["EXPLORER_CLEAR_FILTER"] = "|cff00ff00清除|r";
--
l10n.SLASH_NOTE = {
	["expand"] = "加寬窗口",
	["blz_style"] = "暴雪風格",
	["bg_color"] = "點擊設置背景顏色",
	["show_tradeskill_frame_price_info"] = "在商業技能窗口中顯示價格信息",
	["show_tradeskill_frame_rank_info"] = "在商業技能窗口中顯示等級信息",
	["show_queue_button"] = "顯示隊列切換按鈕",
	["show_tradeskill_tip_craft_item_price"] = "在鼠標提示中顯示物品製造信息",
	["show_tradeskill_tip_craft_spell_price"] = "在鼠標提示中顯示商業技能法術信息",
	["show_tradeskill_tip_recipe_price"] = "在鼠標提示中顯示配方信息",
	["show_tradeskill_tip_recipe_account_learned"] = "在配方的鼠標提示中，顯示賬號所有角色學習情況",
	["show_tradeskill_tip_material_craft_info"] = "顯示物品作為材料的商業技能信息",
	["default_skill_button_tip"] = "在默認的技能列表上顯示鼠標提示",
	["colored_rank_for_unknown"] = "總是將名稱按照難度染色，將未學技能底色顯示為紅色",
	["regular_exp"] = "正則表達式搜索|cffff0000!!!慎用!!!|r",
	["show_call"] = "顯示界面切換按鈕",
	["show_tab"] = "顯示切換欄",
	["portrait_button"] = "商業技能頭像下拉菜單",
	["show_board"] = "顯示冷卻面板",
	["lock_board"] = "鎖定冷卻面板",
	["show_DBIcon"] = "顯示小地圖按鈕",
	["hide_mtsl"] = "隱藏MTSL界面",
	["first_auction_mod"] = "首選拍賣插件",
	["first_auction_mod:*"] = "自動選擇",
};
l10n.ALPHA = "透明度";
l10n.CHAR_LIST = "角色列表";
l10n.CHAR_DEL = "刪除角色";
l10n["INVALID_COMMANDS"] = "無效命令參數，使用|cff00ff00true、1、on、enable|r 或者 |cffff0000false、0、off、disable|r.";
l10n.TooltipLines = {
	"左鍵打開瀏覽器",
	"右鍵打開設置",
};

--
l10n.ENCHANT_FILTER = {
	INVTYPE_CLOAK = "披風",
	INVTYPE_CHEST = "胸甲",
	INVTYPE_WRIST = "護腕",
	INVTYPE_HAND = "手套",
	INVTYPE_FEET = "靴",
	INVTYPE_WEAPON = "武器",
	INVTYPE_SHIELD = "盾牌",
	NONE = "沒有匹配的附魔",
};

l10n.ENCHANT_FILTER.INVTYPE_ROBE = l10n.ENCHANT_FILTER.INVTYPE_CHEST;
l10n.ENCHANT_FILTER.INVTYPE_2HWEAPON = l10n.ENCHANT_FILTER.INVTYPE_WEAPON;
l10n.ENCHANT_FILTER.INVTYPE_WEAPONMAINHAND = l10n.ENCHANT_FILTER.INVTYPE_WEAPON;
l10n.ENCHANT_FILTER.INVTYPE_WEAPONOFFHAND = l10n.ENCHANT_FILTER.INVTYPE_WEAPON;

