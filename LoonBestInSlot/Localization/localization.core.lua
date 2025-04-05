LBIS = {}
LBIS.L = {};
local L = LBIS.L;
LBIS.ENGLISH_CLASS = {};

local function defaultFunc(L, key)
 -- If this function was called, we have no localization for this key.
 -- We could complain loudly to allow localizers to see the error of their ways, 
 -- but, for now, just return the key as its own localization. This allows you to 
 -- avoid writing the default localization out explicitly.
 return key;
end
setmetatable(L, {__index=defaultFunc});

local CLASS_NAMES = {};
FillLocalizedClassList(CLASS_NAMES)
L["Druid"] = CLASS_NAMES.DRUID;
L["Hunter"] = CLASS_NAMES.HUNTER;
L["Mage"] = CLASS_NAMES.MAGE;
L["Paladin"] = CLASS_NAMES.PALADIN;
L["Priest"] = CLASS_NAMES.PRIEST;
L["Rogue"] = CLASS_NAMES.ROGUE;
L["Shaman"] = CLASS_NAMES.SHAMAN;
L["Warlock"] = CLASS_NAMES.WARLOCK;
L["Warrior"] = CLASS_NAMES.WARRIOR;
L["Death Knight"] = CLASS_NAMES.DEATHKNIGHT;

LBIS.ENGLISH_CLASS[CLASS_NAMES.DRUID] =  "Druid";
LBIS.ENGLISH_CLASS[CLASS_NAMES.HUNTER] =  "Hunter";
LBIS.ENGLISH_CLASS[CLASS_NAMES.MAGE] =  "Mage";
LBIS.ENGLISH_CLASS[CLASS_NAMES.PALADIN] =  "Paladin";
LBIS.ENGLISH_CLASS[CLASS_NAMES.PRIEST] =  "Priest";
LBIS.ENGLISH_CLASS[CLASS_NAMES.ROGUE] =  "Rogue";
LBIS.ENGLISH_CLASS[CLASS_NAMES.SHAMAN] =  "Shaman";
LBIS.ENGLISH_CLASS[CLASS_NAMES.WARLOCK] =  "Warlock";
LBIS.ENGLISH_CLASS[CLASS_NAMES.WARRIOR] =  "Warrior";
LBIS.ENGLISH_CLASS[CLASS_NAMES.DEATHKNIGHT] =  "DeathKnight";