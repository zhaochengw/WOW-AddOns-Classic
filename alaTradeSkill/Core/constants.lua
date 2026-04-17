--[=[
	CONSTANTS
--]=]
----------------------------------------------------------------------------------------------------
local __addon, __private = ...;
local CT = __private.CT;

-->		upvalue

-->		constant
	CT._ITEM_CLASS_CONSUMABLE = LE_ITEM_CLASS_CONSUMABLE or Enum.ItemClass.Consumable or 0;
	CT._ITEM_CLASS_CONTAINER = LE_ITEM_CLASS_CONTAINER or Enum.ItemClass.Container or 1;
	CT._ITEM_CLASS_WEAPON = LE_ITEM_CLASS_WEAPON or Enum.ItemClass.Weapon or 2;
	CT._ITEM_CLASS_GEM = LE_ITEM_CLASS_GEM or Enum.ItemClass.Gem or 3;
	CT._ITEM_CLASS_ARMOR = LE_ITEM_CLASS_ARMOR or Enum.ItemClass.Armor or 4;
	CT._ITEM_CLASS_REAGENT = LE_ITEM_CLASS_REAGENT or Enum.ItemClass.Reagent or 5;
	CT._ITEM_CLASS_PROJECTILE = LE_ITEM_CLASS_PROJECTILE or Enum.ItemClass.Projectile or 6;
	CT._ITEM_CLASS_TRADEGOODS = LE_ITEM_CLASS_TRADEGOODS or Enum.ItemClass.Tradegoods or 7;
	CT._ITEM_CLASS_ITEM_ENHANCEMENT = LE_ITEM_CLASS_ITEM_ENHANCEMENT or Enum.ItemClass.ItemEnhancement or 8;
	CT._ITEM_CLASS_RECIPE = LE_ITEM_CLASS_RECIPE or Enum.ItemClass.Recipe or 9;
	CT._ITEM_CLASS_ITEM_CURRENCY = Enum.ItemClass.CurrencyTokenObsolete or 10;
	CT._ITEM_CLASS_QUIVER = LE_ITEM_CLASS_QUIVER or Enum.ItemClass.Quiver or 11;
	CT._ITEM_CLASS_QUESTITEM = LE_ITEM_CLASS_QUESTITEM or Enum.ItemClass.Questitem or 12;
	CT._ITEM_CLASS_KEY = LE_ITEM_CLASS_KEY or Enum.ItemClass.Key or 13;
	CT._ITEM_CLASS_PERMANENT = Enum.ItemClass.PermanentObsolete or 14;
	CT._ITEM_CLASS_MISCELLANEOUS = LE_ITEM_CLASS_MISCELLANEOUS or Enum.ItemClass.Miscellaneous or 15;
	CT._ITEM_CLASS_GLYPH = LE_ITEM_CLASS_GLYPH or Enum.ItemClass.Glyph or 16;
	CT._ITEM_CLASS_BATTLEPET = LE_ITEM_CLASS_BATTLEPET or Enum.ItemClass.Battlepet or 17;
	CT._ITEM_CLASS_WOW_TOKEN = LE_ITEM_CLASS_WOW_TOKEN or Enum.ItemClass.WoWToken or 18;
	CT._ITEM_WEAPON_AXE1H = LE_ITEM_WEAPON_AXE1H or Enum.ItemWeaponSubclass.Axe1H or 0;
	CT._ITEM_WEAPON_AXE2H = LE_ITEM_WEAPON_AXE2H or Enum.ItemWeaponSubclass.Axe2H or 1;
	CT._ITEM_WEAPON_BOWS = LE_ITEM_WEAPON_BOWS or Enum.ItemWeaponSubclass.Bows or 2;
	CT._ITEM_WEAPON_GUNS = LE_ITEM_WEAPON_GUNS or Enum.ItemWeaponSubclass.Guns or 3;
	CT._ITEM_WEAPON_MACE1H = LE_ITEM_WEAPON_MACE1H or Enum.ItemWeaponSubclass.Mace1H or 4;
	CT._ITEM_WEAPON_MACE2H = LE_ITEM_WEAPON_MACE2H or Enum.ItemWeaponSubclass.Mace2H or 5;
	CT._ITEM_WEAPON_POLEARM = LE_ITEM_WEAPON_POLEARM or Enum.ItemWeaponSubclass.Polearm or 6;
	CT._ITEM_WEAPON_SWORD1H = LE_ITEM_WEAPON_SWORD1H or Enum.ItemWeaponSubclass.Sword1H or 7;
	CT._ITEM_WEAPON_SWORD2H = LE_ITEM_WEAPON_SWORD2H or Enum.ItemWeaponSubclass.Sword2H or 8;
	CT._ITEM_WEAPON_WARGLAIVE = LE_ITEM_WEAPON_WARGLAIVE or Enum.ItemWeaponSubclass.Warglaive or 9;
	CT._ITEM_WEAPON_STAFF = LE_ITEM_WEAPON_STAFF or Enum.ItemWeaponSubclass.Staff or 10;
	CT._ITEM_WEAPON_BEARCLAW = LE_ITEM_WEAPON_BEARCLAW or Enum.ItemWeaponSubclass.Bearclaw or 11;
	CT._ITEM_WEAPON_CATCLAW = LE_ITEM_WEAPON_CATCLAW or Enum.ItemWeaponSubclass.Catclaw or 12;
	CT._ITEM_WEAPON_UNARMED = LE_ITEM_WEAPON_UNARMED or Enum.ItemWeaponSubclass.Unarmed or 13;
	CT._ITEM_WEAPON_GENERIC = LE_ITEM_WEAPON_GENERIC or Enum.ItemWeaponSubclass.Generic or 14;
	CT._ITEM_WEAPON_DAGGER = LE_ITEM_WEAPON_DAGGER or Enum.ItemWeaponSubclass.Dagger or 15;
	CT._ITEM_WEAPON_THROWN = LE_ITEM_WEAPON_THROWN or Enum.ItemWeaponSubclass.Thrown or 16;
	CT._ITEM_WEAPON_SPEAR = LE_ITEM_WEAPON_SPEAR or Enum.ItemWeaponSubclass.Obsolete3 or 17;
	CT._ITEM_WEAPON_CROSSBOW = LE_ITEM_WEAPON_CROSSBOW or Enum.ItemWeaponSubclass.Crossbow or 18;
	CT._ITEM_WEAPON_WAND = LE_ITEM_WEAPON_WAND or Enum.ItemWeaponSubclass.Wand or 19;
	CT._ITEM_WEAPON_FISHINGPOLE = LE_ITEM_WEAPON_FISHINGPOLE or Enum.ItemWeaponSubclass.Fishingpole or 20;
	--	classic
	CT._ITEM_GEM_INTELLECT = LE_ITEM_GEM_INTELLECT or 0;
	CT._ITEM_GEM_AGILITY = LE_ITEM_GEM_AGILITY or 1;
	CT._ITEM_GEM_STRENGTH = LE_ITEM_GEM_STRENGTH or 2;
	CT._ITEM_GEM_STAMINA = LE_ITEM_GEM_STAMINA or 3;
	CT._ITEM_GEM_SPIRIT = LE_ITEM_GEM_SPIRIT or 4;
	CT._ITEM_GEM_CRITICALSTRIKE = LE_ITEM_GEM_CRITICALSTRIKE or 5;
	CT._ITEM_GEM_MASTERY = LE_ITEM_GEM_MASTERY or 6;
	CT._ITEM_GEM_HASTE = LE_ITEM_GEM_HASTE or 7;
	CT._ITEM_GEM_VERSATILITY = LE_ITEM_GEM_VERSATILITY or 8;
	--	9
	CT._ITEM_GEM_MULTIPLESTATS = LE_ITEM_GEM_MULTIPLESTATS or 10;
	CT._ITEM_GEM_ARTIFACTRELIC = LE_ITEM_GEM_ARTIFACTRELIC or 11;
	--	wotlk & bcc
	CT._ITEM_GEM_RED = LE_ITEM_GEM_RED or Enum.ItemGemSubclass.Red or 0;
	CT._ITEM_GEM_BLUE = LE_ITEM_GEM_BLUE or Enum.ItemGemSubclass.Blue or 1;
	CT._ITEM_GEM_YELLOW = LE_ITEM_GEM_YELLOW or Enum.ItemGemSubclass.Yellow or 2;
	CT._ITEM_GEM_PURPLE = LE_ITEM_GEM_PURPLE or Enum.ItemGemSubclass.Purple or 3;
	CT._ITEM_GEM_GREEN = LE_ITEM_GEM_GREEN or Enum.ItemGemSubclass.Green or 4;
	CT._ITEM_GEM_ORANGE = LE_ITEM_GEM_ORANGE or Enum.ItemGemSubclass.Orange or 5;
	CT._ITEM_GEM_META = LE_ITEM_GEM_META or Enum.ItemGemSubclass.Meta or 6;
	CT._ITEM_GEM_SIMPLE = LE_ITEM_GEM_SIMPLE or Enum.ItemGemSubclass.Simple or 7;
	CT._ITEM_GEM_PRISMATIC = LE_ITEM_GEM_PRISMATIC or Enum.ItemGemSubclass.Prismatic or 8;
	--
	CT._ITEM_ARMOR_GENERIC = LE_ITEM_ARMOR_GENERIC or Enum.ItemArmorSubclass.Generic or 0;
	CT._ITEM_ARMOR_CLOTH = LE_ITEM_ARMOR_CLOTH or Enum.ItemArmorSubclass.Cloth or 1;
	CT._ITEM_ARMOR_LEATHER = LE_ITEM_ARMOR_LEATHER or Enum.ItemArmorSubclass.Leather or 2;
	CT._ITEM_ARMOR_MAIL = LE_ITEM_ARMOR_MAIL or Enum.ItemArmorSubclass.Mail or 3;
	CT._ITEM_ARMOR_PLATE = LE_ITEM_ARMOR_PLATE or Enum.ItemArmorSubclass.Plate or 4;
	CT._ITEM_ARMOR_COSMETIC = LE_ITEM_ARMOR_COSMETIC or Enum.ItemArmorSubclass.Cosmetic or 5;
	CT._ITEM_ARMOR_SHIELD = LE_ITEM_ARMOR_SHIELD or Enum.ItemArmorSubclass.Shield or 6;
	CT._ITEM_ARMOR_LIBRAM = LE_ITEM_ARMOR_LIBRAM or Enum.ItemArmorSubclass.Libram or 7;
	CT._ITEM_ARMOR_IDOL = LE_ITEM_ARMOR_IDOL or Enum.ItemArmorSubclass.Idol or 8;
	CT._ITEM_ARMOR_TOTEM = LE_ITEM_ARMOR_TOTEM or Enum.ItemArmorSubclass.Totem or 9;
	CT._ITEM_ARMOR_SIGIL = LE_ITEM_ARMOR_SIGIL or Enum.ItemArmorSubclass.Sigil or 10;
	CT._ITEM_ARMOR_RELIC = LE_ITEM_ARMOR_RELIC or Enum.ItemArmorSubclass.Relic or 11;
	CT._ITEM_RECIPE_BOOK = LE_ITEM_RECIPE_BOOK or Enum.ItemRecipeSubclass.Book or 0;
	CT._ITEM_RECIPE_LEATHERWORKING = LE_ITEM_RECIPE_LEATHERWORKING or Enum.ItemRecipeSubclass.Leatherworking or 1;
	CT._ITEM_RECIPE_TAILORING = LE_ITEM_RECIPE_TAILORING or Enum.ItemRecipeSubclass.Tailoring or 2;
	CT._ITEM_RECIPE_ENGINEERING = LE_ITEM_RECIPE_ENGINEERING or Enum.ItemRecipeSubclass.Engineering or 3;
	CT._ITEM_RECIPE_BLACKSMITHING = LE_ITEM_RECIPE_BLACKSMITHING or Enum.ItemRecipeSubclass.Blacksmithing or 4;
	CT._ITEM_RECIPE_COOKING = LE_ITEM_RECIPE_COOKING or Enum.ItemRecipeSubclass.Cooking or 5;
	CT._ITEM_RECIPE_ALCHEMY = LE_ITEM_RECIPE_ALCHEMY or Enum.ItemRecipeSubclass.Alchemy or 6;
	CT._ITEM_RECIPE_FIRST_AID = LE_ITEM_RECIPE_FIRST_AID or Enum.ItemRecipeSubclass.FirstAid or 7;
	CT._ITEM_RECIPE_ENCHANTING = LE_ITEM_RECIPE_ENCHANTING or Enum.ItemRecipeSubclass.Enchanting or 8;
	CT._ITEM_RECIPE_FISHING = LE_ITEM_RECIPE_FISHING or Enum.ItemRecipeSubclass.Fishing or 9;
	CT._ITEM_RECIPE_JEWELCRAFTING = LE_ITEM_RECIPE_JEWELCRAFTING or Enum.ItemRecipeSubclass.Jewelcrafting or 10;
	CT._ITEM_RECIPE_INSCRIPTION = LE_ITEM_RECIPE_INSCRIPTION or Enum.ItemRecipeSubclass.Inscription or 11;
	CT._ITEM_MISCELLANEOUS_JUNK = LE_ITEM_MISCELLANEOUS_JUNK or Enum.ItemMiscellaneousSubclass.Junk or 0;
	CT._ITEM_MISCELLANEOUS_REAGENT = LE_ITEM_MISCELLANEOUS_REAGENT or Enum.ItemMiscellaneousSubclass.Reagent or 1;
	CT._ITEM_MISCELLANEOUS_COMPANION_PET = LE_ITEM_MISCELLANEOUS_COMPANION_PET or Enum.ItemMiscellaneousSubclass.CompanionPet or 2;
	CT._ITEM_MISCELLANEOUS_HOLIDAY = LE_ITEM_MISCELLANEOUS_HOLIDAY or Enum.ItemMiscellaneousSubclass.Holiday or 3;
	CT._ITEM_MISCELLANEOUS_OTHER = LE_ITEM_MISCELLANEOUS_OTHER or Enum.ItemMiscellaneousSubclass.Other or 4;
	CT._ITEM_MISCELLANEOUS_MOUNT = LE_ITEM_MISCELLANEOUS_MOUNT or Enum.ItemMiscellaneousSubclass.Mount or 5;

-->
