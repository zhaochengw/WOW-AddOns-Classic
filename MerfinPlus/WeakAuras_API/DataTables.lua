local petBuffIdToDesc = {
  ["10%_MELEE_RANGED_HASTE"] = "+10% Melee and Ranged Attack Speed",
  ["10%_SPELL_POWER"] = "+10% Spell Power",
  ["5%_SPELL_HASTE"] = "+5% Spell Haste",
  ["5%_CRIT_CHANCE"] = "+5% Critical Strike Chance",
  ["3000_MASTERY"] = "+3000 Mastery Rating",
  ["5%_STR_AGI_INT"] = "+5% Strength, Agility, Intellect",
  ["10%_STAMINA"] = "+10% Stamina",
  ["4%_PHYSICAL_DAMAGE"] = "+4% Physical damage taken",
  ["4%_MINUS_ARMOR"] = "% minus armor",
}

local familyMap = {
  ["enUS"] = {
    ["Hyena"] = "10%_MELEE_RANGED_HASTE",
    ["Serpent"] = "10%_MELEE_RANGED_HASTE",
    ["Water Strider"] = "10%_SPELL_POWER",
    ["Sporebat"] = "5%_SPELL_HASTE",
    ["Wolf"] = "5%_CRIT_CHANCE",
    ["Devilsaur"] = "5%_CRIT_CHANCE",
    ["Cat"] = "3000_MASTERY",
    ["Spirit Beast"] = "3000_MASTERY",
    ["Shale Spider"] = "5%_STR_AGI_INT",
    ["Silithid"] = "10%_STAMINA",
    ["Boar"] = "4%_PHYSICAL_DAMAGE",
    ["Raptor"] = "4%_MINUS_ARMOR",
  },
  ["ruRU"] = {
    ["Гиена"] = "10%_MELEE_RANGED_HASTE",
    ["Змея"] = "10%_MELEE_RANGED_HASTE",
    ["Водный долгоног"] = "10%_SPELL_POWER",
    ["Спороскат"] = "5%_SPELL_HASTE",
    ["Волк"] = "5%_CRIT_CHANCE",
    ["Дьявозавр"] = "5%_CRIT_CHANCE",
    ["Кошка"] = "3000_MASTERY",
    ["Дух зверя"] = "3000_MASTERY",
    ["Сланцевый паук"] = "5%_STR_AGI_INT",
    ["Силитид"] = "10%_STAMINA",
  },
}

Merfin.petBuffIdToDesc = petBuffIdToDesc
Merfin.petFamilyBuffMap = familyMap[GetLocale()]
