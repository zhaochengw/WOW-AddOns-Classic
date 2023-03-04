local _, L = ...;

local function defaultFunc(L, key)
    --[[ print("MCF debug - send it to author - key is missing:", key); ]]
    return key;
end
setmetatable(L, {__index=defaultFunc});

-- HOW TO TRANSLATE
-- 1. Find Cata or Retail client's locales (I'd recommend to look on GitHub).
-- (Cata is preferable because I used its design and all tooltip functions made for it, they can be different with Retail versions).

-- 2. Check if the current WotLK Classic version is the same as was in Cata.
-- You can use command in game like this: /dump PLAYER_LEVEL. If string is too long then use: /run print(PLAYER_LEVEL).

-- 3. If strings are different then copy Cata's version here. If they're the same - use built-in global string (for example look at L["MCF_STAT_AVERAGE_ITEM_LEVEL"] in enUS.lua file).

-- 4. Keep in mind, that some strings in Cata were longer and had more places for numbers ("%d" or "%.2f%%" things).
-- So you can't just blindly copy Cata/retail version. If it has more numbers (like DEFAULT_STAT4_TOOLTIP has)
-- then functions have to be changed as well. Contact me via GitHub Issues or CurseForge comments/PM and I'll fix it.
-- If locale file doesn't have some string, that differ from Cataclysm version, then you can contact me and I'll add it (it has to be added in other locales as well)

-- OPTIONS FRAME
-- Please  translate also "Re-skins default Character frame into modern version.", "Version:", "Author:" and your version of "<your language> translation:"
L["MCF_OPTIONS_DESCRIPTION"] = "Re-skins default Character frame into modern version.\n\nVersion: " .. GetAddOnMetadata("ModernCharacterFrame", "Version") .. ".\nAuthor: Профессия — Flamegor (EU).";
-- Coloring Item Slots
L["MCF_OPTIONS_COLOR_ITEMSLOT_BUTTON_TEXT"] = "Items quality color";
L["MCF_OPTIONS_COLOR_ITEMSLOT_BUTTON_TOOLTIP"] = "Show items quality color";
-- Repair Cost
L["MCF_OPTIONS_REPAIR_BUTTON_TEXT"] = "Repair cost";
L["MCF_OPTIONS_REPAIR_BUTTON_TOOLTIP"] = "Show estimated repair cost";
-- Taco Tip integration
L["MCF_OPTIONS_TT_INTEGRATION_TITLE"] = "TacoTip's Gear Score";
L["MCF_OPTIONS_TT_INTEGRATION_TITLE_DISABLED"] = "TacoTip's Gear Score "..RED_FONT_COLOR_CODE.."(AddOn isn't loaded)"..FONT_COLOR_CODE_CLOSE;
L["MCF_OPTIONS_TT_INTEGRATION_ENABLE_LABEL"] = "Show Gear Score";
L["MCF_OPTIONS_TT_INTEGRATION_ENABLE_TOOLTIP"] = "Show Gear Score value on Stats panel in line \"Item Level\".";
L["MCF_OPTIONS_TT_INTEGRATION_GSTYPE_LABEL"] = "Display style";
L["MCF_OPTIONS_TT_INTEGRATION_GSTYPE_TOOLTIP"] = "Choose Gear Score value display style.";
L["MCF_OPTIONS_TT_INTEGRATION_COLOR_LABEL"] = "Color Gear Score";
L["MCF_OPTIONS_TT_INTEGRATION_COLOR_TOOLTIP"] = "Enable colorizing for Gear Score numbers based on its value.";
-- Reset button
L["MCF_OPTIONS_RESET_BUTTON_TEXT"] = "Reset settings";
L["MCF_OPTIONS_RESET_BUTTON_TOOLTIP"] = "Reset addon's and Character frame's settings to default state.";
L["MCF_OPTIONS_CONFIRM_RESET"] = "Are you sure you want to reset Modern Character Frame settings?";
L["MCF_OPTIONS_RESETED_MESSAGE"] = "Modern Character Frame settings have been reset.";

-- MAIN WINDOW
-- Level text
L["MCF_PLAYER_LEVEL"] = "Level %s |c%s%s %s|r";
L["MCF_PLAYER_LEVEL_NO_SPEC"] = "Level %s |c%s%s|r";
-- Expand/collapse button
L["MCF_STATS_COLLAPSE_TOOLTIP"] = "Hide Character Information";
L["MCF_STATS_EXPAND_TOOLTIP"] = "Show Character Information";
L["MCF_PET_STATS_COLLAPSE_TOOLTIP"] = "Hide Pet Information";
L["MCF_PET_STATS_EXPAND_TOOLTIP"] = "Show Pet Information";

-- STATS PANEL LABELS
-- General
L["MCF_STAT_AVERAGE_ITEM_LEVEL"] = STAT_AVERAGE_ITEM_LEVEL; -- "Item Level"
L["MCF_STAT_GEARSCORE_LABEL"] = "Item Level (GS)";
L["MCF_STAT_MOVEMENT_SPEED"] = "Speed";
-- Various
L["MCF_STAT_ATTACK_POWER"] = "Attack Power";
L["MCF_STAT_DPS_SHORT"] = STAT_DPS_SHORT; -- "DPS"
L["MCF_WEAPON_SPEED"] = WEAPON_SPEED; -- "Attack Speed"
L["MCF_STAT_HASTE"] = "Haste";
L["MCF_STAT_ARMOR_PENETRATION"] = "Armor Penetration";
-- Spells
L["MCF_SPELL_PENETRATION"] = SPELL_PENETRATION; -- "Penetration"
L["MCF_MANA_REGEN"] = MANA_REGEN; -- "Mana Regen"
-- Defense
L["MCF_STAT_PARRY"] = STAT_PARRY; -- "Parry"

-- STATS PANEL TOOLTIPS
-- General
L["MCF_STAT_AVERAGE_ITEM_LEVEL_EQUIPPED"] = STAT_AVERAGE_ITEM_LEVEL_EQUIPPED; -- "(Equipped %d)"
L["MCF_STAT_GEARSCORE"] = "(Gear Score %d)";
L["MCF_STAT_REPAIR"] = "Estimated repair cost."
-- Attributes
L["MCF_DEFAULT_STAT1_TOOLTIP"] = DEFAULT_STAT1_TOOLTIP; -- "Increases Attack Power by %d"
L["MCF_DEFAULT_STAT2_TOOLTIP"] = DEFAULT_STAT2_TOOLTIP; -- "Increases Critical Hit chance by %.2f%%"
L["MCF_DEFAULT_STAT3_TOOLTIP"] = DEFAULT_STAT3_TOOLTIP; -- "Increases Health by %d"
L["MCF_DEFAULT_STAT4_TOOLTIP"] = "Increases Mana by %d|nIncreases Spell Power (WRONG - WORK IN PROGRESS) by %d|nIncreases Spell Critical Hit by %.2f%%";
L["MCF_MANA_REGEN_FROM_SPIRIT"] = MANA_REGEN_FROM_SPIRIT; -- "Increases Mana Regeneration by %d Per 5 Seconds while not casting"
-- Various
L["MCF_STAT_HASTE_BASE_TOOLTIP"] = "\nHaste rating %d (+%.2f%% Haste)";
L["MCF_CR_EXPERTISE_TOOLTIP"] = CR_EXPERTISE_TOOLTIP; -- "Reduces chance to be dodged or chance to be parried by %s\nExpertise %s (+%.2F%% expertise)"
L["MCF_CR_ARMOR_PENETRATION_TOOLTIP"] = "Reduces enemy armor (only for your attacks).\nArmor Penetration Rating: %d (enemy armor reduced for %.2f%%).";
-- Melee
L["MCF_STAT_TOOLTIP_BONUS_AP"] = "Increases Attack Power by %d.\n";
L["MCF_STAT_HIT_MELEE_TOOLTIP"] = "Hit rating %d (+%.2f%% hit chance)";
L["MCF_CR_CRIT_MELEE_TOOLTIP"] = "Chance of attacks doing extra damage.\nCrit rating %d (+%.2f%% crit chance)";
-- Ranged
L["MCF_STAT_HIT_RANGED_TOOLTIP"] = "Hit rating %d (+%.2f%% hit chance)";
L["MCF_CR_CRIT_RANGED_TOOLTIP"] = "Chance of attacks doing extra damage.\nCrit rating %d (+%.2f%% crit chance)";
-- Spells
L["MCF_STAT_HIT_SPELL_TOOLTIP"] = "Hit rating %d (+%.2f%% hit chance)";
L["MCF_SPELL_PENETRATION_TOOLTIP"] = SPELL_PENETRATION_TOOLTIP; -- "Spell Penetration %d (Reduces enemy resistances by %d)"
L["MCF_MANA_REGEN_TOOLTIP"] = "%d mana regenerated every 5 seconds while not in combat.";
L["MCF_CR_CRIT_SPELL_TOOLTIP"] = "Chance of spells doing extra damage.\nCrit rating %d (+%.2f%% crit chance)";
-- Defense
L["MCF_CR_BLOCK_TOOLTIP"] = CR_BLOCK_TOOLTIP; -- "Your block stops %d%% of incoming damage."
-- Defense - Custom addition
L["MCF_SPELLHIT_NOTALENTS_TOOLTIP"] = "|cff888888(Excluding talent effects)|r";
L["MCF_TALENT_EFFECTS_ACTIVE"] = "Talents effects active:";
L["MCF_DEFENSE_TOOLTIP_DRUID_TALENT"] = "Chance to be critically hit redused by %d%%";
L["MCF_STAT_ENEMY_LEVEL"] = "Enemy Level";
L["MCF_CRIT_HIT_TAKEN_CHANCE"] = "Chance to be critically hit";
-- Resistances
L["MCF_RESISTANCE_TOOLTIP_SUBTEXT"] = "Reduces %s damage taken by an average of %.2f%%.";

-- EQUIPMENT MANAGER
L["MCF_EQUIPMENT_SETS_NAME_RESERVED"] = "This name is restricted for use.";

-- HIT TOOLTIP CUSTOM ADDITION
L["MCF_TALENTS_AND_ABILITIES_EFFECTS_ACTIVE"] = "Talents and abilities effects active:";
L["MCF_TALENT_NOT_TAKEN_INTO_ACCOUNT"] = "|cff888888Not taken into account|r";
-- Try to make the text authentic but as short as possible (authenticity is priority, though).
L["MCF_TALENT_DESC_BASE"] = "Hit Chance increased by %d%%";
