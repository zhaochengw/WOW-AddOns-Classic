--[[--
	by ALA 
--]]--

local __addon, __private = ...;
local CT = __private.CT;

if CT.LOCALE ~= "ruRU" then
	return;
end
local l10n = CT.l10n;
l10n.LOCALE = "ruRU";
-- Translator ZamestoTV
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
l10n["OK"] = "ОК";
l10n["Search"] = "Поиск";
l10n["OVERRIDE_OPEN"] = "Открыть";
l10n["OVERRIDE_CLOSE"] = "Закрыть";
l10n["SEND_REAGENTS"] = "Отправить реагенты";
l10n["ADD_FAV"] = "Добавить в избранное";
l10n["SUB_FAV"] = "Убрать из избранного";
l10n["QUERY_WHO_CAN_CRAFT_IT"] = "Кто может это создать?";
--
l10n["showUnkown"] = "Неизвестно";
l10n["showKnown"] = "Известно";
l10n["showHighRank"] = "Высокий ранг";
l10n["filterClass"] = CT.SELFLCLASS;
l10n["filterSpec"] = "Моя специализация";
l10n["showItemInsteadOfSpell"] = "Подсказка предмета";
l10n["showRank"] = "Ранг";
l10n["haveMaterials"] = "Есть материалы";
l10n["showUnkownTip"] = "Показать неизученные рецепты";
l10n["showKnownTip"] = "Показать изученные рецепты";
l10n["showHighRankTip"] = "Показать рецепты более высокого ранга";
l10n["filterClassTip"] = "Скрыть рецепты, недоступные для " .. CT.SELFLCLASS;
l10n["filterSpecTip"] = "Скрыть рецепты, недоступные для текущей специализации";
l10n["showItemInsteadOfSpellTip"] = "Показывать предмет в подсказке вместо заклинания";
l10n["showRankTip"] = "Показывать цветной ранг сложности";
--
l10n["PROFIT_SHOW_COST_ONLY"] = "Показывать только стоимость";
--
l10n["LABEL_GET_FROM"] = "|cffff7f00Получено из: |r";
l10n["quest"] = "Задание";
l10n["item"] = "Предмет";
l10n["object"] = "Объект";
l10n["trainer"] = "Тренер";
l10n["quest_reward"] = "Награда за задание";
l10n["quest_accepted_from"] = "Задание получено от";
l10n["sold_by"] = "Продаётся у";
l10n["dropped_by"] = "Падает с";
l10n["world_drop"] = "Мировая добыча";
l10n["dropped_by_mod_level"] = "Уровень моба";
l10n["tradable"] = "Торгуемый";
l10n["non_tradable"] = "Неторгуемый";
l10n["elite"] = "Элитный";
l10n["phase"] = "Фаза";
l10n["unknown area"] = "Неизвестная зона";
l10n["NOT_AVAILABLE_FOR_PLAYER'S_FACTION"] = "Недоступно для фракции игрока";
l10n["AVAILABLE_IN_PHASE_"] = "Доступно в фазе ";
l10n["LABEL_ACCOUT_RECIPE_LEARNED"] = "|cffff7f00Статус персонажей:|r";
l10n["LABEL_USED_AS_MATERIAL_IN"] = "|cffff7f00Используется для создания: |r";
l10n["RECIPE_LEARNED"] = "|cff00ff00Изучено|r";
l10n["RECIPE_NOT_LEARNED"] = "|cffff0000Не изучено|r";
--
l10n["PREV"] = "Пред";
l10n["NEXT"] = "След";
l10n["PRINT_MATERIALS: "] = "Требуется: ";
l10n["PRICE_UNK"] = "Неизвестно";
l10n["AH_PRICE"] = "|cff00ff00Продажа|r";
l10n["VENDOR_RPICE"] = "|cffffaf00Торговец|r";
l10n["COST_PRICE"] = "|cffff7f00Стоимость|r";
l10n["COST_PRICE_KNOWN"] = "|cffff0000Известные материалы|r";
l10n["UNKOWN_PRICE"] = "|cffff0000Неизвестно|r";
l10n["BOP"] = "|cffff7f7fBOP|r";
l10n["PRICE_DIFF+"] = "|cff00ff00Разница|r";
l10n["PRICE_DIFF-"] = "|cffff0000Разница|r";
l10n["PRICE_DIFF0"] = "Одинаково";
l10n["PRICE_DIFF_AH+"] = "|cff00ff00AH5%|r";
l10n["PRICE_DIFF_AH-"] = "|cffff0000AH5%|r";
l10n["PRICE_DIFF_AH0"] = "AH";
l10n["PRICE_DIFF_INFO+"] = "|cff00ff00+|r";
l10n["PRICE_DIFF_INFO-"] = "|cffff0000-|r";
l10n["CRAFT_INFO"] = "|cffff7f00Информация о создании: |r";
l10n["CRAFTED_BY"] = "|cffff7f00Создано: |r";
l10n["ITEMS_UNK"] = "неизвестные предметы";
l10n["NEED_UPDATE"] = "|cffff0000!!Требуется обновление!!|r";
--
l10n["QueueToggleButton"] = "Очередь";
l10n["AddQueue"] = "Добавить";
--
l10n["TIP_SEARCH_NAME_ONLY_INFO"] = "|cffffffПоиск по имени вместо гиперссылки|r";
l10n["TIP_HAVE_MATERIALS_INFO"] = "|cffffffffПоказать рецепты, для которых у вас достаточно материалов|r";
l10n["TIP_PROFIT_FRAME_CALL_INFO"] = "|cffffffffЗаработайте немного денег! |r";
--
l10n["BOARD_LOCK"] = "ЗАБЛОКИРОВАТЬ";
l10n["BOARD_CLOSE"] = "ЗАКРЫТЬ";
l10n["BOARD_TIP"] = "Показать перезарядку ремесленных навыков среди аккаунта. Щёлкните правой кнопкой мыши, чтобы переключить или заблокировать";
l10n["COLORED_FORMATTED_TIME_LEN"] = {
	"|cff%.2x%.2x00%dд %02dч %02dм %02dс|r",
	"|cff%.2x%.2x00%02dч %02dм %02dс|r",
	"|cff%.2x%.2x00%02dм %02dс|r",
	"|cff%.2x%.2x00%02dс|r",
};
l10n["COOLDOWN_EXPIRED"] = "|cff00ff00Доступно|r";
--
l10n["EXPLORER_TITLE"] = "ALA ";
l10n.EXPLORER_SET = {
	Skill = "Навык",
	Type = "Тип",
	SubType = "Подтип",
	EquipLoc = "Место экипировки",
};
l10n.ITEM_TYPE_LIST = {
	[LE_ITEM_CLASS_CONSUMABLE] = "Расходуемые",				--	0	Consumable
	[LE_ITEM_CLASS_CONTAINER] = "Контейнер",				--	1	Container
	[LE_ITEM_CLASS_WEAPON] = "Оружие",						--	2	Weapon
	[LE_ITEM_CLASS_GEM] = "Камень",							--	3	Gem
	[LE_ITEM_CLASS_ARMOR] = "Броня",						--	4	Armor
	[LE_ITEM_CLASS_REAGENT] = "Реагент",					--	5	Reagent Obsolete
	[LE_ITEM_CLASS_PROJECTILE] = "Снаряд",					--	6	Projectile Obsolete
	[LE_ITEM_CLASS_TRADEGOODS] = "Ремесленные товары",		--	7	Tradeskill
	[LE_ITEM_CLASS_ITEM_ENHANCEMENT] = "Улучшение предмета",	--	8	Item Enhancement
	[LE_ITEM_CLASS_RECIPE] = "Рецепт",						--	9	Recipe
	[10] = "Деньги",										--	10	Money(OBSOLETE)
	[LE_ITEM_CLASS_QUIVER] = "Колчан",						--	11	Quiver Obsolete
	[LE_ITEM_CLASS_QUESTITEM] = "Задание",					--	12	Quest
	[LE_ITEM_CLASS_KEY] = "Ключ",							--	13	Key Obsolete
	[14] = "Постоянный",									--	14	Permanent(OBSOLETE)
	[LE_ITEM_CLASS_MISCELLANEOUS] = "Разное",				--	15	Miscellaneous
	[LE_ITEM_CLASS_GLYPH] = "Глиф",							--	16	Glyph
	[LE_ITEM_CLASS_BATTLEPET] = "Боевые питомцы",			--	17	Battle Pets
	[LE_ITEM_CLASS_WOW_TOKEN] = "Жетон WoW",				--	18	WoW Token
};
l10n.ITEM_SUB_TYPE_LIST = {
	[LE_ITEM_CLASS_CONSUMABLE] = {			--	0	Consumable
		[0] = "Расходуемые", 
		[1] = "Зелье", 
		[2] = "Эликсир", 
		[3] = "Настой", 
		[4] = "Свиток", 
		[5] = "Еда и напитки", 
		[6] = "Улучшение предмета", 
		[7] = "Бинт", 
		[8] = "Другое", 
		[9] = "Вантийская руна", 
	},
	[LE_ITEM_CLASS_CONTAINER] = {			--	1	Container
		[0] = "Сумка", 
		[1] = "Сумка душ", 
		[2] = "Сумка для трав", 
		[3] = "Сумка для зачарования", 
		[4] = "Сумка для инженерии", 
		[5] = "Сумка для ювелира", 
		[6] = "Сумка для горного дела", 
		[7] = "Сумка для кожевничества", 
		[8] = "Сумка для начертания", 
		[9] = "Ящик для рыболова", 
		[10] = "Сумка для кулинарии", 
	},
	[LE_ITEM_CLASS_WEAPON] = {								--	2	Weapon
		[LE_ITEM_WEAPON_AXE1H] = "Одноручные топоры", 		--	0
		[LE_ITEM_WEAPON_AXE2H] = "Двуручные топоры", 		--	1
		[LE_ITEM_WEAPON_BOWS] = "Луки", 					--	2
		[LE_ITEM_WEAPON_GUNS] = "Ружья", 					--	3
		[LE_ITEM_WEAPON_MACE1H] = "Одноручные булавы", 		--	4
		[LE_ITEM_WEAPON_MACE2H] = "Двуручные булавы", 		--	5
		[LE_ITEM_WEAPON_POLEARM] = "Древковое оружие", 		--	6
		[LE_ITEM_WEAPON_SWORD1H] = "Одноручные мечи", 		--	7
		[LE_ITEM_WEAPON_SWORD2H] = "Двуручные мечи", 		--	8
		[LE_ITEM_WEAPON_WARGLAIVE] = "Боевые глефы", 		--	9
		[LE_ITEM_WEAPON_STAFF] = "Посохи", 					--	10
		[LE_ITEM_WEAPON_EXOTIC1H] = "Медвежьи когти", 		--	11	--	LE_ITEM_WEAPON_BEARCLAW
		[LE_ITEM_WEAPON_EXOTIC2H] = "Кошачьи когти", 		--	12	--	LE_ITEM_WEAPON_CATCLAW
		[LE_ITEM_WEAPON_UNARMED] = "Кистевое оружие", 		--	13
		[LE_ITEM_WEAPON_GENERIC] = "Разное", 				--	14
		[LE_ITEM_WEAPON_DAGGER] = "Кинжалы", 				--	15
		[LE_ITEM_WEAPON_THROWN] = "Метательное", 			--	16
		[LE_ITEM_WEAPON_SPEAR] = "Копья", 					--	17
		[LE_ITEM_WEAPON_CROSSBOW] = "Арбалеты", 			--	18
		[LE_ITEM_WEAPON_WAND] = "Жезлы", 					--	19
		[LE_ITEM_WEAPON_FISHINGPOLE] = "Удочки", 			--	20
	},
	[LE_ITEM_CLASS_GEM] = not CT.ISCLASSIC and {					--	3	Gem
		[LE_ITEM_GEM_RED] = "Красный камень",				--	0	--	Intellect
		[LE_ITEM_GEM_BLUE] = "Синий камень",				--	1	--	Agility
		[LE_ITEM_GEM_YELLOW] = "Жёлтый камень",				--	2	--	Strength
		[LE_ITEM_GEM_PURPLE] = "Фиолетовый камень",			--	3	--	Stamina
		[LE_ITEM_GEM_GREEN] = "Зелёный камень",				--	4	--	Spirit
		[LE_ITEM_GEM_ORANGE] = "Оранжевый камень",			--	5	--	Critical Strike
		[LE_ITEM_GEM_META] = "Мета-камень",					--	6	--	Mastery
		[LE_ITEM_GEM_SIMPLE] = "Простой камень",			--	7	--	Haste
		[LE_ITEM_GEM_PRISMATIC] = "Призматический камень",	--	8	--	Versatility
	} or {
		[LE_ITEM_GEM_INTELLECT] = "Интеллект", 				--	0
		[LE_ITEM_GEM_AGILITY] = "Ловкость", 				--	1
		[LE_ITEM_GEM_STRENGTH] = "Сила", 					--	2
		[LE_ITEM_GEM_STAMINA] = "Выносливость", 			--	3
		[LE_ITEM_GEM_SPIRIT] = "Дух", 						--	4
		[LE_ITEM_GEM_CRITICALSTRIKE] = "Критический удар", 	--	5
		[LE_ITEM_GEM_MASTERY] = "Искусность", 				--	6
		[LE_ITEM_GEM_HASTE] = "Скорость", 					--	7
		[LE_ITEM_GEM_VERSATILITY] = "Универсальность", 		--	8
		[9] = "Другое", 									--	9
		[LE_ITEM_GEM_MULTIPLESTATS] = "Множественные характеристики", 	--	10
		[LE_ITEM_GEM_ARTIFACTRELIC] = "Реликвия артефакта", 	--	11
	},
	[LE_ITEM_CLASS_ARMOR] = {						--	4	Armor
		[LE_ITEM_ARMOR_GENERIC] = "Разное", 		--	0	Includes Spellstones, Firestones, Trinkets, Rings and Necks
		[LE_ITEM_ARMOR_CLOTH] = "Ткань", 			--	1
		[LE_ITEM_ARMOR_LEATHER] = "Кожа", 			--	2
		[LE_ITEM_ARMOR_MAIL] = "Кольчуга", 			--	3
		[LE_ITEM_ARMOR_PLATE] = "Латы", 			--	4
		[LE_ITEM_ARMOR_COSMETIC] = "Косметика", 	--	5
		[LE_ITEM_ARMOR_SHIELD] = "Щиты", 			--	6
		[LE_ITEM_ARMOR_LIBRAM] = "Манускрипты", 		--	7
		[LE_ITEM_ARMOR_IDOL] = "Идолы", 			--	8
		[LE_ITEM_ARMOR_TOTEM] = "Тотемы", 			--	9
		[LE_ITEM_ARMOR_SIGIL] = "Символы", 			--	10
		[LE_ITEM_ARMOR_RELIC] = "Реликвия", 		--	11
	},
	[LE_ITEM_CLASS_REAGENT] = {				--	5	Reagent Obsolete
		[0] = "Реагент", 
		[1] = "Ключевой камень", 
	},
	[LE_ITEM_CLASS_PROJECTILE] = {			--	6	Projectile Obsolete
		[0] = "Жезл", 
		[1] = "Болт", 
		[2] = "Стрела", 
		[3] = "Пуля", 
		[4] = "Метательное", 
	},
	[LE_ITEM_CLASS_TRADEGOODS] = {			--	7	Tradeskill
		[0] = "Ремесленные товары", 
		[1] = "Детали", 
		[2] = "Взрывчатка", 
		[3] = "Устройства", 
		[4] = "Ювелирное дело", 
		[5] = "Ткань", 
		[6] = "Кожа", 
		[7] = "Металл и камень", 
		[8] = "Кулинария", 
		[9] = "Трава", 
		[10] = "Элементаль", 
		[11] = "Другое", 
		[12] = "Зачарование", 
		[13] = "Материалы", 
		[14] = "Улучшение предмета", 
		[15] = "Чары для оружия", 
		[16] = "Начертание", 
		[17] = "Взрывчатка и устройства", 
	},
	[LE_ITEM_CLASS_ITEM_ENHANCEMENT] = {	--	8	Item Enhancement
		[0] = "Голова", 
		[1] = "Шея", 
		[2] = "Плечи", 
		[3] = "Плащ", 
		[4] = "Грудь", 
		[5] = "Запястья", 
		[6] = "Перчатки", 
		[7] = "Пояс", 
		[8] = "Ноги", 
		[9] = "Ботинки", 
		[10] = "Кольцо", 
		[11] = "Оружие одноручное", 
		[12] = "Двуручное оружие", 
		[13] = "Щит/Второстепенная рука", 
		[14] = "Разное", 
	},
	[LE_ITEM_CLASS_RECIPE] = {				--	9	Recipe
		[LE_ITEM_RECIPE_BOOK] = "Книга", 					--	0
		[LE_ITEM_RECIPE_LEATHERWORKING] = "Кожевничество", 	--	1
		[LE_ITEM_RECIPE_TAILORING] = "Портняжное дело", 	--	2
		[LE_ITEM_RECIPE_ENGINEERING] = "Инженерия", 		--	3
		[LE_ITEM_RECIPE_BLACKSMITHING] = "Кузнечное дело", 	--	4
		[LE_ITEM_RECIPE_COOKING] = "Кулинария", 			--	5
		[LE_ITEM_RECIPE_ALCHEMY] = "Алхимия", 				--	6
		[LE_ITEM_RECIPE_FIRST_AID] = "Первая помощь", 		--	7
		[LE_ITEM_RECIPE_ENCHANTING] = "Зачарование", 		--	8
		[LE_ITEM_RECIPE_FISHING] = "Рыбная ловля", 			--	9
		[LE_ITEM_RECIPE_JEWELCRAFTING] = "Ювелирное дело", 	--	10
		[LE_ITEM_RECIPE_INSCRIPTION] = "Начертание", 		--	11
	},
	[10] = {								--	10	Money(OBSOLETE)
		[0] = "Деньги",
	},
	[LE_ITEM_CLASS_QUIVER] = {				--	11	Quiver Obsolete
		[0] = "Колчан(УСТАРЕЛО)",
		[1] = "Болт(УСТАРЕЛО)",
		[2] = "Колчан",
		[3] = "Подсумок для боеприпасов",
	},
	[LE_ITEM_CLASS_QUESTITEM] = {			--	12	Quest
		[0] = "Задание",
	},
	[LE_ITEM_CLASS_KEY] = {					--	13	Key Obsolete
		[0] = "Ключ",
		[1] = "Отмычка",
	},
	[14] = {								--	14	Permanent(OBSOLETE)
		[0] = "Постоянный",
	},
	[LE_ITEM_CLASS_MISCELLANEOUS] = {		--	15	Miscellaneous
		[LE_ITEM_MISCELLANEOUS_JUNK] = "Хлам",							--	0
		[LE_ITEM_MISCELLANEOUS_REAGENT] = "Реагент",					--	17: Tradeskill.
		[LE_ITEM_MISCELLANEOUS_COMPANION_PET] = "Спутники",				--	2
		[LE_ITEM_MISCELLANEOUS_HOLIDAY] = "Праздник",					--	3
		[LE_ITEM_MISCELLANEOUS_OTHER] = "Другое",						--	4
		[LE_ITEM_MISCELLANEOUS_MOUNT] = "Транспорт",					--	5
		-- [LE_ITEM_MISCELLANEOUS_MOUNT_EQUIPMENT] = "Снаряжение для транспорта",	--	6
	},
	[LE_ITEM_CLASS_GLYPH] = {				--	16	Glyph
		[1] = "Воин",
		[2] = "Паладин",
		[3] = "Охотник",
		[4] = "Разбойник",
		[5] = "Жрец",
		[6] = "Рыцарь смерти",
		[7] = "Шаман",
		[8] = "Маг",
		[9] = "Чернокнижник",
		[10] = "Монах",
		[11] = "Друид",
		[12] = "Охотник на демонов",
	},
	[LE_ITEM_CLASS_BATTLEPET] = {			--	17	Battle Pets
		[0] = "Гуманоид",
		[1] = "Драконоид",
		[2] = "Летающий",
		[3] = "Нежить",
		[4] = "Зверёк",
		[5] = "Магический",
		[6] = "Элементаль",
		[7] = "Зверь",
		[8] = "Водный",
		[9] = "Механический",
	},
	[LE_ITEM_CLASS_WOW_TOKEN] = {			--	18	WoW Token
		[0] = "Жетон WoW",
	},
};
l10n.ITEM_EQUIP_LOC = {
	[0] = "Боеприпасы",
	[1] = "Голова",
	[2] = "Шея",
	[3] = "Плечи",
	[4] = "Рубашка",
	[5] = "Грудь",
	[6] = "Пояс",
	[7] = "Ноги",
	[8] = "Ботинки",
	[9] = "Запястья",
	[10] = "Перчатки",
	[11] = "Кольца",
	[13] = "Аксессуары",
	[15] = "Плащи",
	[16] = "Основная рука",
	[17] = "Второстепенная рука",
	[18] = "Дальний бой",
	[19] = "Гербовая накидка",
	[20] = "Контейнеры",
	[21] = "Одноручное",
	[22] = "Двуручное",
};
l10n["EXPLORER_CLEAR_FILTER"] = "|cff00ff00Очистить|r";
--
l10n.SLASH_NOTE = {
	["expand"] = "Развернуть рамку",
	["blz_style"] = "Стиль Blizzard",
	["bg_color"] = "Щёлкните, чтобы установить цвет фона",
	["show_tradeskill_frame_price_info"] = "Показать информацию о цене в рамке ремесла",
	["show_tradeskill_frame_rank_info"] = "Показать информацию о ранге в рамке ремесла",
	["show_queue_button"] = "Показать кнопку очереди",
	["show_tradeskill_tip_craft_item_price"] = "Показать информацию в подсказке предмета",
	["show_tradeskill_tip_craft_spell_price"] = "Показать информацию в подсказке навыка",
	["show_tradeskill_tip_recipe_price"] = "Показать информацию в подсказке рецептов",
	["show_tradeskill_tip_recipe_account_learned"] = "Показать других персонажей в подсказке рецепта",
	["show_tradeskill_tip_material_craft_info"] = "Список навыков, использующих предмет как материал",
	["default_skill_button_tip"] = "Показать подсказку на кнопке навыка Blizzard",
	["colored_rank_for_unknown"] = "Цвет имени по рангу для неизвестного заклинания",
	["regular_exp"] = "Поиск по регулярному выражению|cffff0000!!!Осторожно!!!|r",
	["show_call"] = "Показать кнопку переключения интерфейса",
	["show_tab"] = "Показать панель переключения",
	["portrait_button"] = "Выпадающее меню на портрете рамки ремесла",
	["show_board"] = "Показать доску",
	["lock_board"] = "Заблокировать доску",
	["show_DBIcon"] = "Показать DBIcon на миникарте",
	["hide_mtsl"] = "Скрыть MTSL",
	["first_auction_mod"] = "Использовать этот аддон аукциона первым",
	["first_auction_mod:*"] = "Авто",
};
l10n.ALPHA = "Альфа";
l10n.CHAR_LIST = "Список персонажей";
l10n.CHAR_DEL = "Удалить персонажа";
l10n["INVALID_COMMANDS"] = "Недействительные команды. Используйте |cff00ff00true, 1, on, enable|r или |cffff0000false, 0, off, disable|r вместо этого.";
l10n.TooltipLines = {
	"ЛКМ: Открыть обозреватель",
	"ПКМ: Открыть настройки интерфейса",
};

--
l10n.ENCHANT_FILTER = {
	INVTYPE_CLOAK = "Плащ",
	INVTYPE_CHEST = "Нагрудник",
	INVTYPE_WRIST = "Наруч",
	INVTYPE_HAND = "Перчатки",
	INVTYPE_FEET = "Обувь",
	INVTYPE_WEAPON = "Оружие",
	INVTYPE_SHIELD = "Щит",
	NONE = "Нет подходящего рецепта зачарования",
};

l10n.ENCHANT_FILTER.INVTYPE_ROBE = l10n.ENCHANT_FILTER.INVTYPE_CHEST;
l10n.ENCHANT_FILTER.INVTYPE_2HWEAPON = l10n.ENCHANT_FILTER.INVTYPE_WEAPON;
l10n.ENCHANT_FILTER.INVTYPE_WEAPONMAINHAND = l10n.ENCHANT_FILTER.INVTYPE_WEAPON;
l10n.ENCHANT_FILTER.INVTYPE_WEAPONOFFHAND = l10n.ENCHANT_FILTER.INVTYPE_WEAPON;
