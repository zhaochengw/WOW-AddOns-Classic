--[[--
	by ALA @ 163UI
--]]--

if WOW_PROJECT_ID ~= WOW_PROJECT_WRATH_CLASSIC then
	return;
end

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
local LE_ITEM_GEM_RED = LE_ITEM_GEM_RED or 0;
local LE_ITEM_GEM_BLUE = LE_ITEM_GEM_BLUE or 1;
local LE_ITEM_GEM_YELLOW = LE_ITEM_GEM_YELLOW or 2;
local LE_ITEM_GEM_PURPLE = LE_ITEM_GEM_PURPLE or 3;
local LE_ITEM_GEM_GREEN = LE_ITEM_GEM_GREEN or 4;
local LE_ITEM_GEM_ORANGE = LE_ITEM_GEM_ORANGE or 5;
local LE_ITEM_GEM_META = LE_ITEM_GEM_META or 6;
local LE_ITEM_GEM_SIMPLE = LE_ITEM_GEM_SIMPLE or 7;
local LE_ITEM_GEM_PRISMATIC = LE_ITEM_GEM_PRISMATIC or 8;
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


local __addon__, __namespace__ = ...;

local LOCALE = GetLocale();
local L = {
	extra_skill_name = {  },
};

if LOCALE == "koKR" then
	L.extra_skill_name[3] = "가죽 세공";
end
--
if LOCALE == "zhCN" or LOCALE == "zhTW" then
	L["OK"] = "确定";
	L["Search"] = "搜索";
	L["OVERRIDE_OPEN"] = "打开搜索";
	L["OVERRIDE_CLOSE"] = "关闭搜索";
	L["ADD_FAV"] = "添加收藏";
	L["SUB_FAV"] = "取消收藏";
	L["QUERY_WHO_CAN_CRAFT_IT"] = "谁会做它？";
	--
	L["showUnkown"] = "未学";
	L["showKnown"] = "已学";
	L["showHighRank"] = "高等级";
	L["filterClass"] = UnitClass('player');
	L["filterSpec"] = "专精";
	L["showItemInsteadOfSpell"] = "物品";
	L["showRank"] = "等级";
	L["haveMaterials"] = "材料";
	L["showUnkownTip"] = "显示还没学会的配方";
	L["showKnownTip"] = "显示已经学会的配方";
	L["showHighRankTip"] = "显示高等级的配方";
	L["filterClassTip"] = "是否过滤掉" .. UnitClass('player') .. "不能学到的配方";
	L["filterSpecTip"] = "是否过滤掉当前专精不能学到的配方";
	L["showItemInsteadOfSpellTip"] = "鼠标提示显示物品而不是技能";
	L["showRankTip"] = "显示难度等级";
	--
	L["PROFIT_SHOW_COST_ONLY"] = "只显示成本";
	--
	L["LABEL_RANK_LEVEL"] = "\124cffff7f00技能等级: \124r";
	L["LABEL_GET_FROM"] = "\124cffff7f00来源: \124r";
	L["quest"] = "任务";
	L["item"] = "物品";
	L["object"] = "物品";
	L["trainer"] = "训练师";
	L["quest_reward"] = "任务奖励";
	L["quest_accepted_from"] = "开始于";
	L["sold_by"] = "出售";
	L["dropped_by"] = "掉落自";
	L["world_drop"] = "世界掉落";
	L["dropped_by_mod_level"] = "怪物等级";
	L["tradable"] = "可交易";
	L["non_tradable"] = "不可交易";
	L["elite"] = "精英";
	L["phase"] = "阶段";
	L["unknown area"] = "未知区域";
	L["NOT_AVAILABLE_FOR_PLAYER'S_FACTION"] = "不适用于当前角色阵营";
	L["AVAILABLE_IN_PHASE_"] = "开放于阶段: ";
	L["LABEL_ACCOUT_RECIPE_LEARNED"] = "\124cffff7f00帐号角色状态: \124r";
	L["LABEL_USED_AS_MATERIAL_IN"] = "\124cffff7f00用于制造: \124r";
	L["RECIPE_LEARNED"] = "\124cff00ff00已学\124r";
	L["RECIPE_NOT_LEARNED"] = "\124cffff0000未学\124r";

	L["PRINT_MATERIALS: "] = "材料: ";
	L["PRICE_UNK"] = "未知";
	L["AH_PRICE"] = "\124cff00ff00价格\124r";
	L["VENDOR_RPICE"] = "\124cffffaf00商人\124r";
	L["COST_PRICE"] = "\124cffff7f00成本\124r";
	L["COST_PRICE_KNOWN"] = "\124cffff0000已缓存成本\124r";
	L["UNKOWN_PRICE"] = "\124cffff0000未知价格\124r";
	L["BOP"] = "\124cffff7f7f拾取绑定\124r";
	L["PRICE_DIFF+"] = "\124cff00ff00差价\124r";
	L["PRICE_DIFF-"] = "\124cffff0000差价\124r";
	L["PRICE_DIFF0"] = "持平";
	L["PRICE_DIFF_AH+"] = "\124cff00ff00AH5%\124r";
	L["PRICE_DIFF_AH-"] = "\124cffff0000AH5%\124r";
	L["PRICE_DIFF_AH0"] = "AH";
	L["PRICE_DIFF_INFO+"] = "\124cff00ff00利润\124r";
	L["PRICE_DIFF_INFO-"] = "\124cffff0000亏损\124r";
	L["CRAFT_INFO"] = "\124cffff7f00商业技能制造信息: \124r";
	L["ITEMS_UNK"] = "项未知";
	L["NEED_UPDATE"] = "\124cffff0000!!需要刷新!!\124r";
	--
	L["TIP_SEARCH_NAME_ONLY_INFO"] = "\124cffffffff只搜索名字，而不是物品链接\124r";
	L["haveMaterialsTip"] = "只显示有足够材料的配方";
	L["TIP_PROFIT_FRAME_CALL_INFO"] = "\124cffffffff我想赚点零花钱! \124r";
	--
	L["BOARD_LOCK"] = "锁定";
	L["BOARD_CLOSE"] = "关闭";
	L["BOARD_TIP"] = "显示帐号下角色的商业技能冷却时间，鼠标右击锁定或关闭";
	L["COLORED_FORMATTED_TIME_LEN"] = {
		"\124cff%.2x%.2x00%d天%02d时%02d分%02d秒\124r",
		"\124cff%.2x%.2x00%d时%02d分%02d秒\124r",
		"\124cff%.2x%.2x00%d分%02d秒\124r",
		"\124cff%.2x%.2x00%d秒\124r",
	};
	L["COOLDOWN_EXPIRED"] = "\124cff00ff00冷却结束\124r";
	--
	L["EXPLORER_TITLE"] = "ALA @ 网易有爱 \124cff00ff00wowui.w.163.com\124r";
	L.EXPLORER_SET = {
		skill = "技能",
		type = "物品类型",
		subType = "子类型",
		eqLoc = "装备部位",
	};
	L.ITEM_TYPE_LIST = {
		[LE_ITEM_CLASS_CONSUMABLE] = "消耗品",				--	0	Consumable
		[LE_ITEM_CLASS_CONTAINER] = "容器",					--	1	Container
		[LE_ITEM_CLASS_WEAPON] = "武器",					--	2	Weapon
		[LE_ITEM_CLASS_GEM] = "宝石",						--	3	Gem
		[LE_ITEM_CLASS_ARMOR] = "护甲",						--	4	Armor
		[LE_ITEM_CLASS_REAGENT] = "材料",					--	5	Reagent Obsolete
		[LE_ITEM_CLASS_PROJECTILE] = "弹药",				--	6	Projectile Obsolete
		[LE_ITEM_CLASS_TRADEGOODS] = "商品",				--	7	Tradeskill
		[LE_ITEM_CLASS_ITEM_ENHANCEMENT] = "Item Enhancement",	--	8	Item Enhancement
		[LE_ITEM_CLASS_RECIPE] = "配方",					--	9	Recipe
		[10] = "Money",										--	10	Money(OBSOLETE)
		[LE_ITEM_CLASS_QUIVER] = "箭袋",					--	11	Quiver Obsolete
		[LE_ITEM_CLASS_QUESTITEM] = "任务",					--	12	Quest
		[LE_ITEM_CLASS_KEY] = "钥匙",						--	13	Key Obsolete
		[14] = "Permanent",									--	14	Permanent(OBSOLETE)
		[LE_ITEM_CLASS_MISCELLANEOUS] = "其它",				--	15	Miscellaneous
		[LE_ITEM_CLASS_GLYPH] = "Glyph",					--	16	Glyph
		[LE_ITEM_CLASS_BATTLEPET] = "战斗宠物",				--	17	Battle Pets
		[LE_ITEM_CLASS_WOW_TOKEN] = "WoW Token",			--	18	WoW Token
	};
	L.ITEM_SUB_TYPE_LIST = {
		[LE_ITEM_CLASS_CONSUMABLE] = {			--	0	Consumable
			[0] = "消耗品",				--	Explosives and Devices
			[1] = "药水",				--	Potion
			[2] = "药剂",				--	Elixir
			[3] = "合剂",				--	Flask
			[4] = "卷轴",				--	Scroll (OBSOLETE)
			[5] = "食物和饮料",			--	Food & Drink
			[6] = "物品附魔",			--	Item Enhancement (OBSOLETE)
			[7] = "绷带",				--	Bandage
			[8] = "其它",				--	Other
			[9] = "凡图斯符文",			--	Vantus Runes
		},
		[LE_ITEM_CLASS_CONTAINER] = {			--	1	Container
			[0] = "容器",		--	Bag
			[1] = "灵魂包",		--	Soul Bag
			[2] = "草药包",		--	Herb Bag
			[3] = "附魔包",		--	Enchanting Bag
			[4] = "工程包",		--	Engineering Bag
			[5] = "宝石包",		--	Gem Bag
			[6] = "矿石包",		--	Mining Bag
			[7] = "制皮包",		--	Leatherworking Bag
			[8] = "铭文包",		--	Inscription Bag
			[9] = "渔具包",		--	Tackle Box
			[10] = "烹饪包",	--	Cooking Bag
		},
		[LE_ITEM_CLASS_WEAPON] = {				--	2	Weapon
			[LE_ITEM_WEAPON_AXE1H] = "单手斧",			--	0	--	One-Handed Axes
			[LE_ITEM_WEAPON_AXE2H] = "双手斧",			--	1	--	Two-Handed Axes
			[LE_ITEM_WEAPON_BOWS] = "弓",				--	2	--	Bows
			[LE_ITEM_WEAPON_GUNS] = "枪",				--	3	--	Guns
			[LE_ITEM_WEAPON_MACE1H] = "单手锤",			--	4	--	One-Handed Maces
			[LE_ITEM_WEAPON_MACE2H] = "双手锤",			--	5	--	Two-Handed Maces
			[LE_ITEM_WEAPON_POLEARM] = "长柄武器",		--	6	--	Polearms
			[LE_ITEM_WEAPON_SWORD1H] = "单手剑",		--	7	--	One-Handed Swords
			[LE_ITEM_WEAPON_SWORD2H] = "双手剑",		--	8	--	Two-Handed Swords
			[LE_ITEM_WEAPON_WARGLAIVE] = "战刃",		--	9	--	Warglaives
			[LE_ITEM_WEAPON_STAFF] = "法杖",			--	10	--	Staves
			[LE_ITEM_WEAPON_EXOTIC1H] = "Bear Claws",	--	11	--	LE_ITEM_WEAPON_BEARCLAW	--	Bear Claws
			[LE_ITEM_WEAPON_EXOTIC2H] = "CatClaws",		--	12	--	LE_ITEM_WEAPON_CATCLAW	--	CatClaws
			[LE_ITEM_WEAPON_UNARMED] = "拳套",			--	13	--	Fist Weapons
			[LE_ITEM_WEAPON_GENERIC] = "其它",			--	14	--	Miscellaneous
			[LE_ITEM_WEAPON_DAGGER] = "匕首",			--	15	--	Daggers
			[LE_ITEM_WEAPON_THROWN] = "投掷武器",		--	16	--	Thrown
			[LE_ITEM_WEAPON_SPEAR] = "Spears",			--	17	--	Spears
			[LE_ITEM_WEAPON_CROSSBOW] = "弩",			--	18	--	Crossbows
			[LE_ITEM_WEAPON_WAND] = "魔杖",				--	19	--	Wands
			[LE_ITEM_WEAPON_FISHINGPOLE] = "钓鱼竿",	--	20	--	Fishing Poles
		},
		[LE_ITEM_CLASS_GEM] = {					--	3	Gem
			[LE_ITEM_GEM_RED] = "红色宝石",					--	0	--	Intellect
			[LE_ITEM_GEM_BLUE] = "蓝色宝石",				--	1	--	Agility
			[LE_ITEM_GEM_YELLOW] = "黄色宝石",				--	2	--	Strength
			[LE_ITEM_GEM_PURPLE] = "紫色宝石",				--	3	--	Stamina
			[LE_ITEM_GEM_GREEN] = "绿色宝石",				--	4	--	Spirit
			[LE_ITEM_GEM_ORANGE] = "橙色宝石",				--	5	--	Critical Strike
			[LE_ITEM_GEM_META] = "多彩宝石",				--	6	--	Mastery
			[LE_ITEM_GEM_SIMPLE] = "简单宝石",				--	7	--	Haste
			[LE_ITEM_GEM_PRISMATIC] = "棱彩宝石",			--	8	--	Versatility
		},
		[LE_ITEM_CLASS_ARMOR] = {				--	4	Armor
			[LE_ITEM_ARMOR_GENERIC] = "其它",		--	0	--	Miscellaneous	Includes Spellstones, Firestones, Trinkets, Rings and Necks
			[LE_ITEM_ARMOR_CLOTH] = "布甲",			--	1	--	Cloth
			[LE_ITEM_ARMOR_LEATHER] = "皮甲",		--	2	--	Leather
			[LE_ITEM_ARMOR_MAIL] = "锁甲",			--	3	--	Mail
			[LE_ITEM_ARMOR_PLATE] = "板甲",			--	4	--	Plate
			[LE_ITEM_ARMOR_COSMETIC] = "Cosmetic",	--	5	--	Cosmetic
			[LE_ITEM_ARMOR_SHIELD] = "盾牌",		--	6	--	Shields
			[LE_ITEM_ARMOR_LIBRAM] = "圣契",		--	7	--	Librams
			[LE_ITEM_ARMOR_IDOL] = "神像",			--	8	--	Idols
			[LE_ITEM_ARMOR_TOTEM] = "图腾",			--	9	--	Totems
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
			[2] = "箭",		--	Arrow
			[3] = "子弹",		--	Bullet
			[4] = "投掷武器",	--	Thrown(OBSOLETE)
		},
		[LE_ITEM_CLASS_TRADEGOODS] = {			--	7	Tradeskill
			[0] = "商品",						--	Trade Goods (OBSOLETE)
			[1] = "零件",						--	Parts
			[2] = "爆炸物",						--	Explosives (OBSOLETE)
			[3] = "装置",						--	Devices (OBSOLETE)
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
			[0] = "头部",			--	Head
			[1] = "颈部",			--	Neck
			[2] = "肩部",			--	Shoulder
			[3] = "背部",			--	Cloak
			[4] = "胸部",			--	Chest
			[5] = "手腕",			--	Wrist
			[6] = "手",				--	Hands
			[7] = "腰部",			--	Waist
			[8] = "腿部",			--	Legs
			[9] = "脚",				--	Feet
			[10] = "手指",			--	Finger
			[11] = "武器",			--	Weapon	One-handed weapons
			[12] = "双手武器",		--	Two-Handed Weapon
			[13] = "盾牌/副手",		--	Shield/Off-hand
			[14] = "Misc",			--	Misc
		},
		[LE_ITEM_CLASS_RECIPE] = {				--	9	Recipe
			[LE_ITEM_RECIPE_BOOK] = "书籍",					--	0	--	Book
			[LE_ITEM_RECIPE_LEATHERWORKING] = "制皮",		--	1	--	Leatherworking
			[LE_ITEM_RECIPE_TAILORING] = "裁缝",			--	2	--	Tailoring
			[LE_ITEM_RECIPE_ENGINEERING] = "工程学",		--	3	--	Engineering
			[LE_ITEM_RECIPE_BLACKSMITHING] = "锻造",		--	4	--	Blacksmithing
			[LE_ITEM_RECIPE_COOKING] = "烹饪",				--	5	--	Cooking
			[LE_ITEM_RECIPE_ALCHEMY] = "炼金术",			--	6	--	Alchemy
			[LE_ITEM_RECIPE_FIRST_AID] = "急救",			--	7	--	First Aid
			[LE_ITEM_RECIPE_ENCHANTING] = "附魔",			--	8	--	Enchanting
			[LE_ITEM_RECIPE_FISHING] = "钓鱼",				--	9	--	Fishing
			[LE_ITEM_RECIPE_JEWELCRAFTING] = "珠宝加工",	--	10	--	Jewelcrafting
			[LE_ITEM_RECIPE_INSCRIPTION] = "铭文",			--	11	--	Inscription
		},
		[10] = {								--	10	Money(OBSOLETE)
			[0] = "Money",	--	Money(OBSOLETE)
		},
		[LE_ITEM_CLASS_QUIVER] = {				--	11	Quiver Obsolete
			[0] = "Quiver(OBSOLETE)",	--	Quiver(OBSOLETE)
			[1] = "Bolt(OBSOLETE)",		--	Bolt(OBSOLETE)
			[2] = "箭袋",				--	Quiver
			[3] = "弹药袋",				--	Ammo Pouch
		},
		[LE_ITEM_CLASS_QUESTITEM] = {			--	12	Quest
			[0] = "任务",			--	Quest
		},
		[LE_ITEM_CLASS_KEY] = {					--	13	Key Obsolete
			[0] = "钥匙",			--	Key
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
	L.ITEM_EQUIP_LOC = {
		[0] = "弹药",
		[1] = "头部",
		[2] = "颈部",
		[3] = "肩部",
		[4] = "衬衣",
		[5] = "胸部",
		[6] = "腰部",
		[7] = "腿部",
		[8] = "脚部",
		[9] = "手腕",
		[10] = "手",
		[11] = "手指",
		[13] = "饰品",
		[15] = "背部",
		[16] = "主手",
		[17] = "副手",
		[18] = "远程",
		[19] = "战袍",
		[20] = "背包",
		[21] = "单手武器",
		[22] = "双手武器",
	};
	L["EXPLORER_CLEAR_FILTER"] = "\124cff00ff00清除\124r";
	--
	L.SLASH_NOTE = {
		["expand"] = "加宽窗口",
		["blz_style"] = "暴雪风格",
		["bg_color"] = "点击设置背景颜色",
		["show_tradeskill_frame_price_info"] = "在商业技能窗口中显示价格信息",
		["show_tradeskill_frame_rank_info"] = "在商业技能窗口中显示等级信息",
		["show_tradeskill_tip_craft_item_price"] = "在鼠标提示中显示物品制造信息",
		["show_tradeskill_tip_craft_spell_price"] = "在鼠标提示中显示商业技能法术信息",
		["show_tradeskill_tip_recipe_price"] = "在鼠标提示中显示配方信息",
		["show_tradeskill_tip_recipe_account_learned"] = "在配方的鼠标提示中，显示帐号所有角色的学习情况",
		["show_tradeskill_tip_material_craft_info"] = "显示物品作为材料的商业技能信息",
		["default_skill_button_tip"] = "在默认的技能列表上显示鼠标提示",
		["colored_rank_for_unknown"] = "总是将名称按照难度染色，将未学技能底色显示为红色",
		["regular_exp"] = "正则表达式搜索\124cffff0000!!!慎用!!!\124r",
		["show_call"] = "显示界面切换按钮",
		["show_tab"] = "显示切换栏",
		["portrait_button"] = "商业技能头像下拉菜单",
		["show_board"] = "显示冷却面板",
		["lock_board"] = "锁定冷却面板",
		["show_DBIcon"] = "显示小地图按钮",
		["hide_mtsl"] = "隐藏MTSL界面",
		["first_auction_mod"] = "首选拍卖插件",
		["first_auction_mod:*"] = "自动选择",
	};
	L.ALPHA = "透明度";
	L.CHAR_LIST = "角色列表";
	L.CHAR_DEL = "删除角色";
	L["INVALID_COMMANDS"] = "无效命令参数，使用\124cff00ff00true、1、on、enable\124r 或者 \124cffff0000false、0、off、disable\124r.";
	L.TooltipLines = {
		"左键打开浏览器",
		"右键打开设置",
	};
elseif LOCALE == "koKR" then
	L["OK"] = "확인";
	L["Search"] = "검색";
	L["OVERRIDE_OPEN"] = "열기";
	L["OVERRIDE_CLOSE"] = "닫기";
	L["ADD_FAV"] = "즐겨찾기";
	L["SUB_FAV"] = "즐겨찾기 해제";
	L["QUERY_WHO_CAN_CRAFT_IT"] = "누가 제작 가능?";
	--
	L["showUnkown"] = "알 수 없음";
	L["showKnown"] = "알려짐";
	L["showHighRank"] = "높은 랭크";
	L["filterClass"] = UnitClass('player');
	L["filterSpec"] = "MySpec";
	L["showItemInsteadOfSpell"] = "아이템";
	L["showRank"] = "랭크";
	L["haveMaterials"] = "보유 재료";
	L["showUnkownTip"] = "Show unlearned recipes";
	L["showKnownTip"] = "Show learned recipes";
	L["showHighRankTip"] = "Show recipes of higher rank";
	L["filterClassTip"] = "Hide recipes unavailable to" .. UnitClass('player');
	L["filterSpecTip"] = "Hide recipes unavailable to current specialization";
	L["showItemInsteadOfSpellTip"] = "Show item in tip instead of spell";
	L["showRankTip"] = "Show color of difficulty";
	--
	L["PROFIT_SHOW_COST_ONLY"] = "가격만 표시";
	--
	L["LABEL_RANK_LEVEL"] = "\124cffff7f00랭크: \124r";
	L["LABEL_GET_FROM"] = "\124cffff7f00획득: \124r";
	L["quest"] = "퀘스트";
	L["item"] = "아이템";
	L["object"] = "아이템";
	L["trainer"] = "기술 전문가";
	L["quest_reward"] = "퀘스트 보상";
	L["quest_accepted_from"] = "에 의해 주어진 퀘스트";
	L["sold_by"] = "판매";
	L["dropped_by"] = "드랍";
	L["world_drop"] = "월드 드랍";
	L["dropped_by_mod_level"] = "몹 레벨";
	L["tradable"] = "거래 가능";
	L["non_tradable"] = "거래 불가능";
	L["elite"] = "정예";
	L["phase"] = "페이즈";
	L["unknown area"] = "Unknown area";
	L["NOT_AVAILABLE_FOR_PLAYER'S_FACTION"] = "플레이어 진영에는 사용할 수 없습니다";
	L["AVAILABLE_IN_PHASE_"] = "페이즈에 이용 가능 → ";
	L["LABEL_ACCOUT_RECIPE_LEARNED"] = "\124cffff7f00Status of characters:\124r";
	L["LABEL_USED_AS_MATERIAL_IN"] = "\124cffff7f00Used to craft: \124r";
	L["RECIPE_LEARNED"] = "\124cff00ff00학습\124r";
	L["RECIPE_NOT_LEARNED"] = "\124cffff0000비학습\124r";

	L["PRINT_MATERIALS: "] = "필요: ";
	L["PRICE_UNK"] = "알 수 없음";
	L["AH_PRICE"] = "\124cff00ff00경매 \124r";
	L["VENDOR_RPICE"] = "\124cffffaf00상점 \124r";
	L["COST_PRICE"] = "\124cffff7f00가격 \124r";
	L["COST_PRICE_KNOWN"] = "\124cffff0000알려진 가격 \124r";
	L["UNKOWN_PRICE"] = "\124cffff0000알 수 없는 가격\124r";
	L["BOP"] = "\124cffff7f7f획득시 귀속\124r";
	L["PRICE_DIFF+"] = "\124cff00ff00가격 차이 \124r";
	L["PRICE_DIFF-"] = "\124cffff0000가격 차이 \124r";
	L["PRICE_DIFF0"] = "똑같음";
	L["PRICE_DIFF_AH+"] = "\124cff00ff00AH5%\124r";
	L["PRICE_DIFF_AH-"] = "\124cffff0000AH5%\124r";
	L["PRICE_DIFF_AH0"] = "AH";
	L["PRICE_DIFF_INFO+"] = "\124cff00ff00+\124r";
	L["PRICE_DIFF_INFO-"] = "\124cffff0000-\124r";
	L["CRAFT_INFO"] = "\124cffff7f00제작 정보: \124r";
	L["ITEMS_UNK"] = "알 수 없는 아이템";
	L["NEED_UPDATE"] = "\124cffff0000!!새로 고침 필요!\124r";
	--
	L["haveMaterialsTip"] = "Show recipes that u have enough materials";
	L["TIP_SEARCH_NAME_ONLY_INFO"] = "\124cffffffSearch name instead of hyperlink\124r";
	L["TIP_PROFIT_FRAME_CALL_INFO"] = "\124cffffffff돈을 버세요!\124r";
	--
	L["BOARD_LOCK"] = "잠금";
	L["BOARD_CLOSE"] = "닫기";
	L["BOARD_TIP"] = "계정간 스킬 스킬의 재사용 대기 시간을 표시합니다. 마우스 오른쪽 버튼을 클릭하여 전환 또는 잠금";
	L["COLORED_FORMATTED_TIME_LEN"] = {
		"\124cff%.2x%.2x00%d일 %02d시간 %02d분 %02d초\124r",
		"\124cff%.2x%.2x00%d시간 %02d분 %02d초\124r",
		"\124cff%.2x%.2x00%d분 %02d초\124r",
		"\124cff%.2x%.2x00%d초\124r",
	};
	L["COOLDOWN_EXPIRED"] = "\124cff00ff00유효함\124r";
	--
	L["EXPLORER_TITLE"] = "ALA @ 163UI";
	L.EXPLORER_SET = {
		skill = "기술",
		type = "유형",
		subType = "하위유형",
		eqLoc = "장비부위",
	};
	L.ITEM_TYPE_LIST = {
		[LE_ITEM_CLASS_CONSUMABLE] = "소모품",				--	0	Consumable
		[LE_ITEM_CLASS_CONTAINER] = "용기",				--	1	Container
		[LE_ITEM_CLASS_WEAPON] = "무기",						--	2	Weapon
		[LE_ITEM_CLASS_GEM] = "보석",							--	3	Gem
		[LE_ITEM_CLASS_ARMOR] = "갑옷",						--	4	Armor
		[LE_ITEM_CLASS_REAGENT] = "재료",					--	5	Reagent Obsolete
		[LE_ITEM_CLASS_PROJECTILE] = "탄약",				--	6	Projectile Obsolete
		[LE_ITEM_CLASS_TRADEGOODS] = "상품",				--	7	Tradeskill
		[LE_ITEM_CLASS_ITEM_ENHANCEMENT] = "아이템 향상",	--	8	Item Enhancement
		[LE_ITEM_CLASS_RECIPE] = "레시피",						--	9	Recipe
		[10] = "돈",											--	10	Money(OBSOLETE)
		[LE_ITEM_CLASS_QUIVER] = "직업가방",						--	11	Quiver Obsolete
		[LE_ITEM_CLASS_QUESTITEM] = "퀘스트",					--	12	Quest
		[LE_ITEM_CLASS_KEY] = "열쇠",							--	13	Key Obsolete
		[14] = "영구적인",										--	14	Permanent(OBSOLETE)
		[LE_ITEM_CLASS_MISCELLANEOUS] = "기타",		--	15	Miscellaneous
		[LE_ITEM_CLASS_GLYPH] = "GLYPH",						--	16	Glyph
		[LE_ITEM_CLASS_BATTLEPET] = "전투 애완 동물",				--	17	Battle Pets
		[LE_ITEM_CLASS_WOW_TOKEN] = "와우 토큰",				--	18	WoW Token
	};
	L.ITEM_SUB_TYPE_LIST = {
		[LE_ITEM_CLASS_CONSUMABLE] = {			--	0	Consumable
			[0] = "소모품", 
			[1] = "물약", 
			[2] = "영약", 
			[3] = "용기", 
			[4] = "두루마리", 
			[5] = "음식 & 음료", 
			[6] = "아이템 향상", 
			[7] = "붕대", 
			[8] = "기타", 
			[9] = "반투스 룬", 
		},
		[LE_ITEM_CLASS_CONTAINER] = {			--	1	Container
			[0] = "가방", 
			[1] = "영혼석 가방", 
			[2] = "약초 가방", 
			[3] = "마법부여 가방", 
			[4] = "기계공학 가방", 
			[5] = "보석 가방", 
			[6] = "채광 가방", 
			[7] = "무두 가방", 
			[8] = "주문각인 가방", 
			[9] = "낚시 도구 상자", 
			[10] = "요리 가방", 
		},
		[LE_ITEM_CLASS_WEAPON] = {								--	2	Weapon
			[LE_ITEM_WEAPON_AXE1H] = "한손 도끼", 		--	0
			[LE_ITEM_WEAPON_AXE2H] = "양손 도끼", 		--	1
			[LE_ITEM_WEAPON_BOWS] = "활", 					--	2
			[LE_ITEM_WEAPON_GUNS] = "총", 					--	3
			[LE_ITEM_WEAPON_MACE1H] = "한손 둔기", 		--	4
			[LE_ITEM_WEAPON_MACE2H] = "양손 둔기", 		--	5
			[LE_ITEM_WEAPON_POLEARM] = "장창", 				--	6
			[LE_ITEM_WEAPON_SWORD1H] = "한손 도검", 	--	7
			[LE_ITEM_WEAPON_SWORD2H] = "양손 도검", 	--	8
			[LE_ITEM_WEAPON_WARGLAIVE] = "전투검", 			--	9
			[LE_ITEM_WEAPON_STAFF] = "자팡이", 					--	10
			[LE_ITEM_WEAPON_EXOTIC1H] = "곰 발톱", 			--	11	--	LE_ITEM_WEAPON_BEARCLAW
			[LE_ITEM_WEAPON_EXOTIC2H] = "고양이 발톱", 				--	12	--	LE_ITEM_WEAPON_CATCLAW
			[LE_ITEM_WEAPON_UNARMED] = "장착 무기", 			--	13
			[LE_ITEM_WEAPON_GENERIC] = "기타", 		--	14
			[LE_ITEM_WEAPON_DAGGER] = "단검", 				--	15
			[LE_ITEM_WEAPON_THROWN] = "투척 무기", 				--	16
			[LE_ITEM_WEAPON_SPEAR] = "SPEAR", 					--	17
			[LE_ITEM_WEAPON_CROSSBOW] = "석궁", 			--	18
			[LE_ITEM_WEAPON_WAND] = "마법봉", 					--	19
			[LE_ITEM_WEAPON_FISHINGPOLE] = "낚시대", 	--	20
		},
		[LE_ITEM_CLASS_GEM] = {					--	3	Gem
			[LE_ITEM_GEM_RED] = "Red Gem",					--	0	--	Intellect
			[LE_ITEM_GEM_BLUE] = "Blue Gem",				--	1	--	Agility
			[LE_ITEM_GEM_YELLOW] = "Yellow Gem",				--	2	--	Strength
			[LE_ITEM_GEM_PURPLE] = "Purple Gem",				--	3	--	Stamina
			[LE_ITEM_GEM_GREEN] = "Green Gem",				--	4	--	Spirit
			[LE_ITEM_GEM_ORANGE] = "Orange Gem",				--	5	--	Critical Strike
			[LE_ITEM_GEM_META] = "Meta Gem",				--	6	--	Mastery
			[LE_ITEM_GEM_SIMPLE] = "Simple Gem",				--	7	--	Haste
			[LE_ITEM_GEM_PRISMATIC] = "Prismatic Gem",			--	8	--	Versatility
		},
		[LE_ITEM_CLASS_ARMOR] = {						--	4	Armor
			[LE_ITEM_ARMOR_GENERIC] = "기타", 	--	0	Includes Spellstones, Firestones, Trinkets, Rings and Necks
			[LE_ITEM_ARMOR_CLOTH] = "천", 			--	1
			[LE_ITEM_ARMOR_LEATHER] = "가죽", 		--	2
			[LE_ITEM_ARMOR_MAIL] = "사슬", 				--	3
			[LE_ITEM_ARMOR_PLATE] = "판금", 			--	4
			[LE_ITEM_ARMOR_COSMETIC] = "Cosmetic", 		--	5
			[LE_ITEM_ARMOR_SHIELD] = "방패", 		--	6
			[LE_ITEM_ARMOR_LIBRAM] = "성서", 		--	7
			[LE_ITEM_ARMOR_IDOL] = "우상", 			--	8
			[LE_ITEM_ARMOR_TOTEM] = "토템", 			--	9
			[LE_ITEM_ARMOR_SIGIL] = "Sigils", 			--	10
			[LE_ITEM_ARMOR_RELIC] = "유물", 			--	11
		},
		[LE_ITEM_CLASS_REAGENT] = {				--	5	Reagent Obsolete
			[0] = "재료", 
			[1] = "쐐기돌", 
		},
		[LE_ITEM_CLASS_PROJECTILE] = {			--	6	Projectile Obsolete
			[0] = "Wand", 
			[1] = "Bolt", 
			[2] = "화살", 
			[3] = "총알", 
			[4] = "투척", 
		},
		[LE_ITEM_CLASS_TRADEGOODS] = {			--	7	Tradeskill
			[0] = "상품", 
			[1] = "부속", 
			[2] = "폭발물", 
			[3] = "장치", 
			[4] = "보석세공", 
			[5] = "천", 
			[6] = "가죽", 
			[7] = "주괴 및 광석", 
			[8] = "요리", 
			[9] = "약초", 
			[10] = "정령", 
			[11] = "기타", 
			[12] = "마법부여", 
			[13] = "재료", 
			[14] = "아이템 마법부여", 
			[15] = "무기 마법부여", 
			[16] = "주문각인", 
			[17] = "폭발물과 장치", 
		},
		[LE_ITEM_CLASS_ITEM_ENHANCEMENT] = {	--	8	Item Enhancement
			[0] = "머리", 
			[1] = "목", 
			[2] = "어깨", 
			[3] = "망토", 
			[4] = "가슴", 
			[5] = "손목", 
			[6] = "손", 
			[7] = "허리", 
			[8] = "다리", 
			[9] = "발", 
			[10] = "손가락", 
			[11] = "한손 무기", 
			[12] = "양손 무기", 
			[13] = "방패/보조장비", 
			[14] = "기타", 
		},
		[LE_ITEM_CLASS_RECIPE] = {				--	9	Recipe
			[LE_ITEM_RECIPE_BOOK] = "책", 					--	0
			[LE_ITEM_RECIPE_LEATHERWORKING] = "가죽세공", --	1
			[LE_ITEM_RECIPE_TAILORING] = "재봉술", 			--	2
			[LE_ITEM_RECIPE_ENGINEERING] = "기계공학", 		--	3
			[LE_ITEM_RECIPE_BLACKSMITHING] = "대장기술", 	--	4
			[LE_ITEM_RECIPE_COOKING] = "요리", 				--	5
			[LE_ITEM_RECIPE_ALCHEMY] = "연금술", 				--	6
			[LE_ITEM_RECIPE_FIRST_AID] = "응급치료", 			--	7
			[LE_ITEM_RECIPE_ENCHANTING] = "마법부여", 		--	8
			[LE_ITEM_RECIPE_FISHING] = "낚시", 				--	9
			[LE_ITEM_RECIPE_JEWELCRAFTING] = "보석세공", 	--	10
			[LE_ITEM_RECIPE_INSCRIPTION] = "주문각인", 		--	11
		},
		[10] = {								--	10	Money(OBSOLETE)
			[0] = "돈",
		},
		[LE_ITEM_CLASS_QUIVER] = {				--	11	Quiver Obsolete
			[0] = "Quiver(OBSOLETE)",
			[1] = "Bolt(OBSOLETE)",
			[2] = "Quiver",
			[3] = "총알 주머니",
		},
		[LE_ITEM_CLASS_QUESTITEM] = {			--	12	Quest
			[0] = "퀘스트",
		},
		[LE_ITEM_CLASS_KEY] = {					--	13	Key Obsolete
			[0] = "열쇠",
			[1] = "자물쇠",
		},
		[14] = {								--	14	Permanent(OBSOLETE)
			[0] = "영구적인",
		},
		[LE_ITEM_CLASS_MISCELLANEOUS] = {		--	15	Miscellaneous
			[LE_ITEM_MISCELLANEOUS_JUNK] = "기타 잡템",							--	0
			[LE_ITEM_MISCELLANEOUS_REAGENT] = "영구적인",					--	17: Tradeskill.
			[LE_ITEM_MISCELLANEOUS_COMPANION_PET] = "반려 동물",		--	2
			[LE_ITEM_MISCELLANEOUS_HOLIDAY] = "휴일",					--	3
			[LE_ITEM_MISCELLANEOUS_OTHER] = "기타",						--	4
			[LE_ITEM_MISCELLANEOUS_MOUNT] = "장착",						--	5
			-- [LE_ITEM_MISCELLANEOUS_MOUNT_EQUIPMENT] = "Mount Equipment",	--	6
		},
		[LE_ITEM_CLASS_GLYPH] = {				--	16	Glyph
			[1] = "전사",
			[2] = "성기사",
			[3] = "사냥꾼",
			[4] = "도적",
			[5] = "사제",
			[6] = "죽음의기사",
			[7] = "주술사",
			[8] = "마법사",
			[9] = "흑마법사",
			[10] = "수도사",
			[11] = "드루이드",
			[12] = "악마사냥꾼",
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
			[0] = "와우 토큰",
		},
	};
	L.ITEM_EQUIP_LOC = {
		[0] = "탄약",
		[1] = "머리",
		[2] = "목",
		[3] = "어깨",
		[4] = "셔츠",
		[5] = "가슴",
		[6] = "허리",
		[7] = "다리",
		[8] = "발",
		[9] = "손목",
		[10] = "손",
		[11] = "손가락",
		[13] = "장신구",
		[15] = "망토",
		[16] = "주장비",
		[17] = "보조장비",
		[18] = "원거리",
		[19] = "휘장",
		[20] = "용기",
		[21] = "한손 무기",
		[22] = "양손 무기",
	};
	L["EXPLORER_CLEAR_FILTER"] = "\124cff00ff00Clear\124r";
	--
	L.SLASH_NOTE = {
		["expand"] = "Expand frame",
		["blz_style"] = "Blizzar style",
		["bg_color"] = "Click to set Color of Background",
		["show_tradeskill_frame_price_info"] = "전문 기술 프레임에 가격 정보 표시",
		["show_tradeskill_frame_rank_info"] = "전문 기술 프레임에 순위 정보 표시",
		["show_tradeskill_tip_craft_item_price"] = "제작된 아이템의 툴팁에 정보 표시",
		["show_tradeskill_tip_craft_spell_price"] = "전문 기술 주문에 대한 정보를 툴팁에 표시",
		["show_tradeskill_tip_recipe_price"] = "레시피를 위해 툴팁에 정보 표시",
		["show_tradeskill_tip_recipe_account_learned"] = "다른 캐릭터가 레시피를 배웠는지 여부를 표시",
		["show_tradeskill_tip_material_craft_info"] = "Show tradeskill list using tip item",
		["default_skill_button_tip"] = "Show tip on default skill list button",
		["colored_rank_for_unknown"] = "알 수 없는 맞춤법에 대한 순위 별 색상 이름",
		["regular_exp"] = "정규식으로 검색\124cffff0000!!!Caution!!!\124r",
		["show_call"] = "Show UI toggle button",
		["show_tab"] = "Show switch bar",
		["portrait_button"] = "Dropdown menu on portrait of tradeskill frame",
		["show_board"] = "변환 쿨타임 보드 표시",
		["lock_board"] = "변환 쿨타임 보드 잠금",
		["show_DBIcon"] = "Show DBIcon on minimap",
		["hide_mtsl"] = "MTSL 숨김",
		["first_auction_mod"] = "Use this auction addon first",
		["first_auction_mod:*"] = "Auto",
	};
	L.ALPHA = "Alpha";
	L.CHAR_LIST = "캐릭터 목록";
	L.CHAR_DEL = "캐릭터 삭제";
	L["INVALID_COMMANDS"] = "잘못된 명령. 사용 \124cff00ff00true, 1, on, enable\124r or \124cffff0000false, 0, off, disable\124r instead.";
	L.TooltipLines = {
		"Left Click: Open Explorer",
		"Right Click: Open SettingUI",
	};
else
	L["OK"] = "OK";
	L["Search"] = "Search";
	L["OVERRIDE_OPEN"] = "Open";
	L["OVERRIDE_CLOSE"] = "Close";
	L["ADD_FAV"] = "Favorite";
	L["SUB_FAV"] = "Unfavorite";
	L["QUERY_WHO_CAN_CRAFT_IT"] = "Who can craft it ?";
	--
	L["showUnkown"] = "Unknown";
	L["showKnown"] = "Known";
	L["showHighRank"] = "HighRank";
	L["filterClass"] = UnitClass('player');
	L["filterSpec"] = "MySpec";
	L["showItemInsteadOfSpell"] = "ItemTip";
	L["showRank"] = "Rank";
	L["haveMaterials"] = "haveMaterials";
	L["showUnkownTip"] = "Show unlearned recipes";
	L["showKnownTip"] = "Show learned recipes";
	L["showHighRankTip"] = "Show recipes of higher rank";
	L["filterClassTip"] = "Hide recipes unavailable to" .. UnitClass('player');
	L["filterSpecTip"] = "Hide recipes unavailable to current specialization";
	L["showItemInsteadOfSpellTip"] = "Show item in tip instead of spell";
	L["showRankTip"] = "Show color of difficulty";
	--
	L["PROFIT_SHOW_COST_ONLY"] = "Show cost only";
	--
	L["LABEL_RANK_LEVEL"] = "\124cffff7f00Rank: \124r";
	L["LABEL_GET_FROM"] = "\124cffff7f00Get from: \124r";
	L["quest"] = "Quest";
	L["item"] = "Item";
	L["object"] = "Object";
	L["trainer"] = "Trainer";
	L["quest_reward"] = "Quest reward";
	L["quest_accepted_from"] = "Quest given by";
	L["sold_by"] = "Sold by";
	L["dropped_by"] = "Dropped by";
	L["world_drop"] = "World drop";
	L["dropped_by_mod_level"] = "Mob Lv";
	L["tradable"] = "Tradable";
	L["non_tradable"] = "Non-tradable";
	L["elite"] = "Elite";
	L["phase"] = "Phase";
	L["unknown area"] = "Unknown area";
	L["NOT_AVAILABLE_FOR_PLAYER'S_FACTION"] = "Not available for player's faction";
	L["AVAILABLE_IN_PHASE_"] = "Available in phase ";
	L["LABEL_ACCOUT_RECIPE_LEARNED"] = "\124cffff7f00Status of characters:\124r";
	L["LABEL_USED_AS_MATERIAL_IN"] = "\124cffff7f00Used to craft: \124r";
	L["RECIPE_LEARNED"] = "\124cff00ff00Learned\124r";
	L["RECIPE_NOT_LEARNED"] = "\124cffff0000Not learned\124r";

	L["PRINT_MATERIALS: "] = "Needs: ";
	L["PRICE_UNK"] = "Unknown";
	L["AH_PRICE"] = "\124cff00ff00AH\124r";
	L["VENDOR_RPICE"] = "\124cffffaf00Vendor\124r";
	L["COST_PRICE"] = "\124cffff7f00Cost\124r";
	L["COST_PRICE_KNOWN"] = "\124cffff0000Known Material\124r";
	L["UNKOWN_PRICE"] = "\124cffff0000Unkown\124r";
	L["BOP"] = "\124cffff7f7fBOP\124r";
	L["PRICE_DIFF+"] = "\124cff00ff00Diff\124r";
	L["PRICE_DIFF-"] = "\124cffff0000Diff\124r";
	L["PRICE_DIFF0"] = "The same";
	L["PRICE_DIFF_AH+"] = "\124cff00ff00AH5%\124r";
	L["PRICE_DIFF_AH-"] = "\124cffff0000AH5%\124r";
	L["PRICE_DIFF_AH0"] = "AH";
	L["PRICE_DIFF_INFO+"] = "\124cff00ff00+\124r";
	L["PRICE_DIFF_INFO-"] = "\124cffff0000-\124r";
	L["CRAFT_INFO"] = "\124cffff7f00Craft info: \124r";
	L["ITEMS_UNK"] = "items unk";
	L["NEED_UPDATE"] = "\124cffff0000!!Need refresh!!\124r";
	--
	L["haveMaterialsTip"] = "Show recipes that u have enough materials";
	L["TIP_SEARCH_NAME_ONLY_INFO"] = "\124cffffffSearch name instead of hyperlink\124r";
	L["TIP_PROFIT_FRAME_CALL_INFO"] = "\124cffffffffEarn some money! \124r";
	--
	L["BOARD_LOCK"] = "LOCK";
	L["BOARD_CLOSE"] = "CLOSE";
	L["BOARD_TIP"] = "Show cooldown of tradeskill among account. Right-click to toggle or lock";
	L["COLORED_FORMATTED_TIME_LEN"] = {
		"\124cff%.2x%.2x00%dd %02dh %02dm %02ds\124r",
		"\124cff%.2x%.2x00%dh %02dm %02ds\124r",
		"\124cff%.2x%.2x00%dm %02ds\124r",
		"\124cff%.2x%.2x00%ds\124r",
	};
	L["COOLDOWN_EXPIRED"] = "\124cff00ff00Available\124r";
	--
	L["EXPLORER_TITLE"] = "ALA @ 163UI";
	L.EXPLORER_SET = {
		skill = "Skill",
		type = "Type",
		subType = "SubType",
		eqLoc = "EqLoc",
	};
	L.ITEM_TYPE_LIST = {
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
	L.ITEM_SUB_TYPE_LIST = {
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
		[LE_ITEM_CLASS_GEM] = {					--	3	Gem
			[LE_ITEM_GEM_RED] = "Red Gem",					--	0	--	Intellect
			[LE_ITEM_GEM_BLUE] = "Blue Gem",				--	1	--	Agility
			[LE_ITEM_GEM_YELLOW] = "Yellow Gem",				--	2	--	Strength
			[LE_ITEM_GEM_PURPLE] = "Purple Gem",				--	3	--	Stamina
			[LE_ITEM_GEM_GREEN] = "Green Gem",				--	4	--	Spirit
			[LE_ITEM_GEM_ORANGE] = "Orange Gem",				--	5	--	Critical Strike
			[LE_ITEM_GEM_META] = "Meta Gem",				--	6	--	Mastery
			[LE_ITEM_GEM_SIMPLE] = "Simple Gem",				--	7	--	Haste
			[LE_ITEM_GEM_PRISMATIC] = "Prismatic Gem",			--	8	--	Versatility
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
	L.ITEM_EQUIP_LOC = {
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
	L["EXPLORER_CLEAR_FILTER"] = "\124cff00ff00Clear\124r";
	--
	L.SLASH_NOTE = {
		["expand"] = "Expand frame",
		["blz_style"] = "Blizzard style",
		["bg_color"] = "Click to set Color of Background",
		["show_tradeskill_frame_price_info"] = "Show price info in tradeskill frame",
		["show_tradeskill_frame_rank_info"] = "Show rank info in tradeskill frame",
		["show_tradeskill_tip_craft_item_price"] = "Show info in tooltip for crafted item",
		["show_tradeskill_tip_craft_spell_price"] = "Show info in tooltip for tradeskill spell",
		["show_tradeskill_tip_recipe_price"] = "Show info in tooltip for recipe",
		["show_tradeskill_tip_recipe_account_learned"] = "Show whether the other characters learned the recipe",
		["show_tradeskill_tip_material_craft_info"] = "Show tradeskill list using tip item",
		["default_skill_button_tip"] = "Show tip on default skill list button",
		["colored_rank_for_unknown"] = "Color name by rank for unknown spell",
		["regular_exp"] = "Search in the way of Regular Expression\124cffff0000!!!Caution!!!\124r",
		["show_call"] = "Show UI toggle button",
		["show_tab"] = "Show switch bar",
		["portrait_button"] = "Dropdown menu on portrait of tradeskill frame",
		["show_board"] = "Show board",
		["lock_board"] = "Lock board",
		["show_DBIcon"] = "Show DBIcon on minimap",
		["hide_mtsl"] = "Hide MTSL",
		["first_auction_mod"] = "Use this auction addon first",
		["first_auction_mod:*"] = "Auto",
	};
	L.ALPHA = "Alpha";
	L.CHAR_LIST = "Character list";
	L.CHAR_DEL = "Del character";
	L["INVALID_COMMANDS"] = "Invalid commonds. Use \124cff00ff00true, 1, on, enable\124r or \124cffff0000false, 0, off, disable\124r instead.";
	L.TooltipLines = {
		"Left Click: Open Explorer",
		"Right Click: Open SettingUI",
	};
end
--
L.ENCHANT_FILTER = {  };
if LOCALE == "zhCN" then
	L.ENCHANT_FILTER.INVTYPE_CLOAK = "披风";
	L.ENCHANT_FILTER.INVTYPE_CHEST = "胸甲";
	L.ENCHANT_FILTER.INVTYPE_WRIST = "护腕";
	L.ENCHANT_FILTER.INVTYPE_HAND = "手套";
	L.ENCHANT_FILTER.INVTYPE_FEET = "靴";
	L.ENCHANT_FILTER.INVTYPE_WEAPON = "武器";
	L.ENCHANT_FILTER.INVTYPE_SHIELD = "盾牌";
	L.ENCHANT_FILTER.NONE = "没有匹配的附魔";
elseif LOCALE == "zhTW" then
	L.ENCHANT_FILTER.INVTYPE_CLOAK = "披風";
	L.ENCHANT_FILTER.INVTYPE_CHEST = "胸甲";
	L.ENCHANT_FILTER.INVTYPE_WRIST = "護腕";
	L.ENCHANT_FILTER.INVTYPE_HAND = "手套";
	L.ENCHANT_FILTER.INVTYPE_FEET = "靴";
	L.ENCHANT_FILTER.INVTYPE_WEAPON = "武器";
	L.ENCHANT_FILTER.INVTYPE_SHIELD = "盾牌";
	L.ENCHANT_FILTER.NONE = "沒有匹配的附魔";
elseif LOCALE == "enUS" then
	L.ENCHANT_FILTER.INVTYPE_CLOAK = "Cloak";
	L.ENCHANT_FILTER.INVTYPE_CHEST = "Chest";
	L.ENCHANT_FILTER.INVTYPE_WRIST = "Bracer";
	L.ENCHANT_FILTER.INVTYPE_HAND = "Glove";
	L.ENCHANT_FILTER.INVTYPE_FEET = "Boot";
	L.ENCHANT_FILTER.INVTYPE_WEAPON = "Weapon";
	L.ENCHANT_FILTER.INVTYPE_SHIELD = "Shield";
	L.ENCHANT_FILTER.NONE = "No matched enchating recipe";
elseif LOCALE == "deDE" then
	L.ENCHANT_FILTER.INVTYPE_CLOAK = "Umhang";
	L.ENCHANT_FILTER.INVTYPE_CHEST = "Brust";
	L.ENCHANT_FILTER.INVTYPE_WRIST = "Armschiene";
	L.ENCHANT_FILTER.INVTYPE_HAND = "Handschuhe";
	L.ENCHANT_FILTER.INVTYPE_FEET = "Stiefel";
	L.ENCHANT_FILTER.INVTYPE_WEAPON = "Waffe";
	L.ENCHANT_FILTER.INVTYPE_SHIELD = "Schild";
	L.ENCHANT_FILTER.NONE = "No matched enchating recipe";
elseif LOCALE == "esES" or LOCALE == "esMX" then
	L.ENCHANT_FILTER.INVTYPE_CLOAK = "capa";
	L.ENCHANT_FILTER.INVTYPE_CHEST = "pechera";
	L.ENCHANT_FILTER.INVTYPE_WRIST = "brazal";
	L.ENCHANT_FILTER.INVTYPE_HAND = "guantes";
	L.ENCHANT_FILTER.INVTYPE_FEET = "botas";
	L.ENCHANT_FILTER.INVTYPE_WEAPON = "arma";
	L.ENCHANT_FILTER.INVTYPE_SHIELD = "escudo";
	L.ENCHANT_FILTER.NONE = "No matched enchating recipe";
elseif LOCALE == "frFR" then
	L.ENCHANT_FILTER.INVTYPE_CLOAK = "cape";
	L.ENCHANT_FILTER.INVTYPE_CHEST = "plastron";
	L.ENCHANT_FILTER.INVTYPE_WRIST = "bracelets";
	L.ENCHANT_FILTER.INVTYPE_HAND = "gants";
	L.ENCHANT_FILTER.INVTYPE_FEET = "bottes";
	L.ENCHANT_FILTER.INVTYPE_WEAPON = "d'arme";
	L.ENCHANT_FILTER.INVTYPE_SHIELD = "bouclier";
	L.ENCHANT_FILTER.NONE = "No matched enchating recipe";
elseif LOCALE == "ptBR" then
	L.ENCHANT_FILTER.INVTYPE_CLOAK = "Manto";
	L.ENCHANT_FILTER.INVTYPE_CHEST = "Torso";
	L.ENCHANT_FILTER.INVTYPE_WRIST = "Braçadeiras";
	L.ENCHANT_FILTER.INVTYPE_HAND = "Luvas";
	L.ENCHANT_FILTER.INVTYPE_FEET = "Botas";
	L.ENCHANT_FILTER.INVTYPE_WEAPON = "Arma";
	L.ENCHANT_FILTER.INVTYPE_SHIELD = "Escudo";
	L.ENCHANT_FILTER.NONE = "No matched enchating recipe";
elseif LOCALE == "ruRU" then
	L.ENCHANT_FILTER.INVTYPE_CLOAK = "плаща";
	L.ENCHANT_FILTER.INVTYPE_CHEST = "нагрудника";
	L.ENCHANT_FILTER.INVTYPE_WRIST = "браслетов";
	L.ENCHANT_FILTER.INVTYPE_HAND = "перчаток";
	L.ENCHANT_FILTER.INVTYPE_FEET = "обуви";
	L.ENCHANT_FILTER.INVTYPE_WEAPON = "оружия";
	L.ENCHANT_FILTER.INVTYPE_SHIELD = "щита";
	L.ENCHANT_FILTER.NONE = "No matched enchating recipe";
elseif LOCALE == "koKR" then
	L.ENCHANT_FILTER.INVTYPE_CLOAK = "망토";
	L.ENCHANT_FILTER.INVTYPE_CHEST = "가슴보호구";
	L.ENCHANT_FILTER.INVTYPE_WRIST = "손목보호구";
	L.ENCHANT_FILTER.INVTYPE_HAND = "장갑";
	L.ENCHANT_FILTER.INVTYPE_FEET = "장화";
	L.ENCHANT_FILTER.INVTYPE_WEAPON = "무기";
	L.ENCHANT_FILTER.INVTYPE_SHIELD = "방패";
	L.ENCHANT_FILTER.NONE = "No matched enchating recipe";
end
L.ENCHANT_FILTER.INVTYPE_ROBE = L.ENCHANT_FILTER.INVTYPE_CHEST;
L.ENCHANT_FILTER.INVTYPE_2HWEAPON = L.ENCHANT_FILTER.INVTYPE_WEAPON;
L.ENCHANT_FILTER.INVTYPE_WEAPONMAINHAND = L.ENCHANT_FILTER.INVTYPE_WEAPON;
L.ENCHANT_FILTER.INVTYPE_WEAPONOFFHAND = L.ENCHANT_FILTER.INVTYPE_WEAPON;

__namespace__.L = L;
