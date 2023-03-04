local _, L = ...;

-- HOW TO TRANSLATE
-- 1. Find Cata or Retail client's locales (I'd recommend to look on GitHub).
-- (Cata is preferable because I used its design and all tooltip functions made for it, they can be different with Retail versions).

-- 2. Check if the current WotLK Classic version is the same as was in Cata.
-- You can use command in game like this: /dump PLAYER_LEVEL. If string is too long then use: /run print(PLAYER_LEVEL).

-- 3. If strings are different then copy Cata's version here. If they're the same - use built-in global string (for example look at L["MCF_STAT_AVERAGE_ITEM_LEVEL"] in enUS.lua file).

-- 4. Keep in mind, that some strings in Cata had more places for numbers ("%d" or "%.2f%%" things).
-- So you can't just blindly copy Cata version. If it has more numbers (like DEFAULT_STAT4_TOOLTIP has)
-- then functions have to be changed as well. Contact me via GitHub Issues or CurseForge comments/PM and I'll fix it.
-- If locale file doesn't have some string, that differ from Cataclysm version, then you can contact me and I'll add it (it has to be added in other locales as well)

if (GetLocale() == "frFR") then
    -- OPTIONS FRAME
    -- Please  translate also "Re-skins default Character frame into modern version.", "Version:", "Author:" and your version of "<your language> translation:"
    L["MCF_OPTIONS_DESCRIPTION"] = "Transforme le cadre du personnage par défaut en une version moderne.\n\nVersion: " .. GetAddOnMetadata("ModernCharacterFrame", "Version") .. ".\nAuteur: Профессия — Flamegor (EU).\nTraduction française: Datyb — Auberdine (EU).";
    -- NEW (delete this line after translation. Also check a few lines at the bottom)
    -- Coloring Item Slots
    L["MCF_OPTIONS_COLOR_ITEMSLOT_BUTTON_TEXT"] = "Items quality color";
    L["MCF_OPTIONS_COLOR_ITEMSLOT_BUTTON_TOOLTIP"] = "Show items quality color";
    -- Repair Cost
    -- NEW - delete this line after translation
    L["MCF_OPTIONS_REPAIR_BUTTON_TEXT"] = "Repair cost";
    L["MCF_OPTIONS_REPAIR_BUTTON_TOOLTIP"] = "Show estimated repair cost";
    -- Taco Tip integration
    L["MCF_OPTIONS_TT_INTEGRATION_TITLE"] = "Score d'équipement de TacoTip";
    L["MCF_OPTIONS_TT_INTEGRATION_TITLE_DISABLED"] = "Score d'équipement de TacoTip "..RED_FONT_COLOR_CODE.."(AddOn n'est pas chargé)"..FONT_COLOR_CODE_CLOSE;
    L["MCF_OPTIONS_TT_INTEGRATION_ENABLE_LABEL"] = "Afficher le score d'équipement";
    L["MCF_OPTIONS_TT_INTEGRATION_ENABLE_TOOLTIP"] = "Afficher la valeur du score d'équipement sur le panneau des statistiques dans la ligne Niveau d'objet.";
    L["MCF_OPTIONS_TT_INTEGRATION_GSTYPE_LABEL"] = "Style d'affichage";
    L["MCF_OPTIONS_TT_INTEGRATION_GSTYPE_TOOLTIP"] = "Choisir le style d'affichage du score d'équipement.";
    L["MCF_OPTIONS_TT_INTEGRATION_COLOR_LABEL"] = "Colorer le score d'équipement";
    L["MCF_OPTIONS_TT_INTEGRATION_COLOR_TOOLTIP"] = "Activer la coloration pour les nombres de score d'équipement en fonction de sa valeur.";
    -- Reset button
    L["MCF_OPTIONS_RESET_BUTTON_TEXT"] = "Réinitialiser les paramètres";
    L["MCF_OPTIONS_RESET_BUTTON_TOOLTIP"] = "Réinitialiser les paramètres de l'addon et de la fenêtre du personnage à l'état par défaut.";
    L["MCF_OPTIONS_CONFIRM_RESET"] = "Êtes-vous sûr de vouloir réinitialiser les paramètres de Modern Character Frame?";
    L["MCF_OPTIONS_RESETED_MESSAGE"] = "Les paramètres de Modern Character Frame ont été réinitialisés.";

    -- MAIN WINDOW
    -- Level text
    L["MCF_PLAYER_LEVEL"] = "Niveau %s |c%s%s %s|r";
    L["MCF_PLAYER_LEVEL_NO_SPEC"] = "Niveau %s |c%s%s|r";
    -- Expand/collapse button
    L["MCF_STATS_COLLAPSE_TOOLTIP"] = "Cacher les informations du personnage";
    L["MCF_STATS_EXPAND_TOOLTIP"] = "Afficher les informations de personnage";
    L["MCF_PET_STATS_COLLAPSE_TOOLTIP"] = "Masquer les informations de familier";
    L["MCF_PET_STATS_EXPAND_TOOLTIP"] = "Afficher les informations de familier";

    -- STATS PANEL LABELS
    -- General
    L["MCF_STAT_AVERAGE_ITEM_LEVEL"] = "Niveau d'objet";
    L["MCF_STAT_GEARSCORE_LABEL"] = "Niveau d'objet (GS)";
    L["MCF_STAT_MOVEMENT_SPEED"] = "Vitesse";
    -- Various
    L["MCF_STAT_ATTACK_POWER"] = "Puissance d'attaque";
    L["MCF_STAT_DPS_SHORT"] = "Dégâts par seconde";
    L["MCF_WEAPON_SPEED"] = "Vitesse d'attaque";
    L["MCF_STAT_HASTE"] = "Hâte";
    L["MCF_STAT_ARMOR_PENETRATION"] = "Pénétration d'armure";
    -- Spells
    L["MCF_SPELL_PENETRATION"] = "Pénétration des sorts";
    L["MCF_MANA_REGEN"] = "Régénération de mana";
    -- Defense
    L["MCF_STAT_PARRY"] = "Parade";

    -- STATS PANEL TOOLTIPS
    -- General
    L["MCF_STAT_AVERAGE_ITEM_LEVEL_EQUIPPED"] = "(équipé %d)";
    L["MCF_STAT_GEARSCORE"] = "(Gear Score %d)";
    -- NEW - delete this line after translation
    L["MCF_STAT_REPAIR"] = "Estimated repair cost."
    -- Attributes
    L["MCF_DEFAULT_STAT1_TOOLTIP"] = "Augmente la puissance d'attaque de %d"; -- "Augmente la puissance d'attaque de %d";
    L["MCF_DEFAULT_STAT2_TOOLTIP"] = "Augmente la chance de coup critique de %.2f%%"; -- "Augmente la chance de coup critique de %.2f%%";
    L["MCF_DEFAULT_STAT3_TOOLTIP"] = "Augmente la santé de %d"; -- "Augmente la santé de %d";
    L["MCF_DEFAULT_STAT4_TOOLTIP"] = "Augmente le mana de %d|nAugmente la puissance des sorts (FAUX - EN COURS) de %d|nAugmente la chance de coup critique des sorts de %.2f%%";
    L["MCF_MANA_REGEN_FROM_SPIRIT"] = "Augmente la régénération de mana de %d par 5 secondes pendant qu'on ne lance pas de sorts"; -- "Augmente la régénération de mana de %d par 5 secondes pendant qu'on ne lance pas de sorts";
    -- Various
    L["MCF_STAT_HASTE_BASE_TOOLTIP"] = "\nScore de hâte %d (+%.2f%% Hâte)";
    L["MCF_CR_EXPERTISE_TOOLTIP"] = "Diminue les chances d'être esquivé ou paré de %s.\nScore d'expertise %d (+%d en expertise)";
    L["MCF_CR_ARMOR_PENETRATION_TOOLTIP"] = "Réduit l'armure de l'ennemi (uniquement pour vos attaques).\nScore de pénétration d'armure : %d (armure de ennemi réduite de %.2f%%).";
    -- Melee
    L["MCF_STAT_TOOLTIP_BONUS_AP"] = "Augmente la puissance d'attaque de %d.\n"
    L["MCF_STAT_HIT_MELEE_TOOLTIP"] = "Score de toucher %d (+%.2F% chance de toucher)."; -- "Hit rating %d (+%.2f%% hit chance)";
    L["MCF_CR_CRIT_MELEE_TOOLTIP"] = "Chance des attaques infligent des dégâts supplémentaires.\nScore de critique %d (+%.2f%% chance de critique)";
    -- Ranged
    L["MCF_STAT_HIT_RANGED_TOOLTIP"] = "Score de toucher %d (+%.2F% chance de toucher)."; -- "Hit rating %d (+%.2f%% hit chance)";
    L["MCF_CR_CRIT_RANGED_TOOLTIP"] = "Chance des attaques infligent des dégâts supplémentaires.\nScore de critique %d (+%.2f%% chance de critique)";
    -- Spells
    L["MCF_STAT_HIT_SPELL_TOOLTIP"] = "Score de toucher %d (+%.2F% chance de toucher)."; -- "Hit rating %d (+%.2f%% hit chance)";
    L["MCF_SPELL_PENETRATION_TOOLTIP"] = "Pénétration des sorts %d (Réduit la résistance adverse de %d)";
    L["MCF_MANA_REGEN_TOOLTIP"] = "%d points de mana régénérés toutes les 5 secondes hors combat.";
    L["MCF_CR_CRIT_SPELL_TOOLTIP"] = "Chance que les sorts infligent des dégâts supplémentaires.\nScore de critique %d (+%.2f%% chance de critique)";
    -- Defense
    L["MCF_CR_BLOCK_TOOLTIP"] = "Le score de blocage %d augmente la probabilité de bloquer les attaques de %.2f%%.\nUn blocage réussi arrête %d points de dégâts.";
    -- Defense - Custom addition
    L["MCF_SPELLHIT_NOTALENTS_TOOLTIP"] = "|cff888888(Excluant les effets de talents)|r";
    L["MCF_TALENT_EFFECTS_ACTIVE"] = "Effet de talents actif:";
    L["MCF_DEFENSE_TOOLTIP_DRUID_TALENT"] = "Chance d'être touché réduit de %d%%";
    L["MCF_STAT_ENEMY_LEVEL"] = "Niveau de l'ennemi";
    L["MCF_CRIT_HIT_TAKEN_CHANCE"] = "Chance d'être touché critique";
    -- Resistances
    L["MCF_RESISTANCE_TOOLTIP_SUBTEXT"] = "Réduit les dégâts %s subis en moyenne de %.2f%%.";
    
    -- EQUIPMENT MANAGER
    L["MCF_EQUIPMENT_SETS_NAME_RESERVED"] = "Ce nom est réservé.";

    -- HIT TOOLTIP CUSTOM ADDITION
    L["MCF_TALENTS_AND_ABILITIES_EFFECTS_ACTIVE"] = "Effets des talents et des compétences actifs:"; -- Talents and abilities effects active:
    L["MCF_TALENT_NOT_TAKEN_INTO_ACCOUNT"] = "|cff888888Non pris en compte|r"; --Not taken into account
    -- Try to make the text authentic but as short as possible (authenticity is priority, though).
    L["MCF_TALENT_DESC_BASE"] = "Chance de toucher augmenté de %d%%";
end
