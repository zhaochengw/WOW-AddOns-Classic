local _, L = ...;

MCF_CHARACTERFRAME_EXPANDED_WIDTH = 540;

MCF_PAPERDOLL_SIDEBARS = {
	{
		name=PAPERDOLL_SIDEBAR_STATS;
		frame="CharacterStatsPane";
		icon = nil;  -- Uses the character portrait
		texCoords = {0.109375, 0.890625, 0.09375, 0.90625};
	},
	{
		name=PAPERDOLL_SIDEBAR_TITLES;
		frame="PaperDollTitlesPane";
		icon = "Interface\\PaperDollInfoFrame\\PaperDollSidebarTabs";
		texCoords = {0.01562500, 0.53125000, 0.32421875, 0.46093750};
	},
	{
		name=PAPERDOLL_EQUIPMENTMANAGER;
		frame="PaperDollEquipmentManagerPane";
		icon = "Interface\\PaperDollInfoFrame\\PaperDollSidebarTabs";
		texCoords = {0.01562500, 0.53125000, 0.46875000, 0.60546875};
	},
};

----------------------------------------------------------------------------------
------------------------------------- STATS --------------------------------------
----------------------------------------------------------------------------------
--[[ MCF_CLASS_MASTERY_SPELLS = {
	["DEATHKNIGHT"] = 86471,
	["DRUID"] = 86470 ,
	["HUNTER"] = 86472,
	["MAGE"] = 86473,
	["PALADIN"] = 86474,
	["PRIEST"] = 86475,
	["ROGUE"] = 86476, 
	["SHAMAN"] = 86477,
	["WARLOCK"] = 86478,
	["WARRIOR"] = 86479,
}; ]]

MCF_PAPERDOLL_STATINFO = {
	-- General
	["HEALTH"] = {
		updateFunc = function(statFrame, unit) MCF_PaperDollFrame_SetHealth(statFrame, unit); end
	},
	["POWER"] = {
		updateFunc = function(statFrame, unit) MCF_PaperDollFrame_SetPower(statFrame, unit); end
	},
	["DRUIDMANA"] = {
		-- Only appears for Druids when in shapeshift form
		updateFunc = function(statFrame, unit) MCF_PaperDollFrame_SetDruidMana(statFrame, unit); end
	},
	--[[ ["MASTERY"] = {
		updateFunc = function(statFrame, unit) MCF_PaperDollFrame_SetMastery(statFrame, unit); end
	}, ]] --MCFFIX disabled Mastery because it doesn't exist in WotLK Classic
	["ITEMLEVEL"] = {
		updateFunc = function(statFrame, unit) MCF_PaperDollFrame_SetItemLevel(statFrame, unit); end
	},
	["MOVESPEED"] = {
		updateFunc = function(statFrame, unit) MCF_PaperDollFrame_SetMovementSpeed(statFrame, unit); end
	},
	["REPAIR"] = {
		updateFunc = function(statFrame, unit) MCF_PaperDollFrame_SetRepairCost(statFrame, unit); end
	},
	
	-- Base stats
	["STRENGTH"] = {
		updateFunc = function(statFrame, unit) MCF_PaperDollFrame_SetStat(statFrame, unit, 1); end 
	},
	["AGILITY"] = {
		updateFunc = function(statFrame, unit) MCF_PaperDollFrame_SetStat(statFrame, unit, 2); end 
	},
	["STAMINA"] = {
		updateFunc = function(statFrame, unit) MCF_PaperDollFrame_SetStat(statFrame, unit, 3); end 
	},
	["INTELLECT"] = {
		updateFunc = function(statFrame, unit) MCF_PaperDollFrame_SetStat(statFrame, unit, 4); end 
	},
	["SPIRIT"] = {
		updateFunc = function(statFrame, unit) MCF_PaperDollFrame_SetStat(statFrame, unit, 5); end 
	},
	
	-- Melee
	["MELEE_DAMAGE"] = {
		updateFunc = function(statFrame, unit) MCF_PaperDollFrame_SetDamage(statFrame, unit); end
	},
	["MELEE_DPS"] = {
		updateFunc = function(statFrame, unit) MCF_PaperDollFrame_SetMeleeDPS(statFrame, unit); end
	},
	["MELEE_AP"] = {
		updateFunc = function(statFrame, unit) MCF_PaperDollFrame_SetAttackPower(statFrame, unit); end
	},
	["MELEE_ATTACKSPEED"] = {
		updateFunc = function(statFrame, unit) MCF_PaperDollFrame_SetAttackSpeed(statFrame, unit); end
	},
	["HASTE"] = {
		updateFunc = function(statFrame, unit) MCF_PaperDollFrame_SetMeleeHaste(statFrame, unit); end
	},
	["HITCHANCE"] = {
		updateFunc = function(statFrame, unit) MCF_PaperDollFrame_SetMeleeHitChance(statFrame, unit); end
	}, 
	["CRITCHANCE"] = {
		updateFunc = function(statFrame, unit) MCF_PaperDollFrame_SetMeleeCritChance(statFrame, unit); end
	},
	["EXPERTISE"] = {
		updateFunc = function(statFrame, unit) MCF_PaperDollFrame_SetExpertise(statFrame, unit); end
	},
	["MELEE_ARMOR_PENETRATION"] = {
		updateFunc = function(statFrame, unit) MCF_PaperDollFrame_SetArmorPenetration(statFrame, unit); end
	},
	["ENERGY_REGEN"] = {
		updateFunc = function(statFrame, unit) MCF_PaperDollFrame_SetEnergyRegen(statFrame, unit); end
	},
	["RUNE_REGEN"] = {
		updateFunc = function(statFrame, unit) MCF_PaperDollFrame_SetRuneRegen(statFrame, unit); end
	},
	
	-- Ranged
	["RANGED_DAMAGE"] = {
		updateFunc = function(statFrame, unit) MCF_PaperDollFrame_SetRangedDamage(statFrame, unit); end
	},
	["RANGED_DPS"] = {
		updateFunc = function(statFrame, unit) MCF_PaperDollFrame_SetRangedDPS(statFrame, unit); end
	},
	["RANGED_AP"] = {
		updateFunc = function(statFrame, unit) MCF_PaperDollFrame_SetRangedAttackPower(statFrame, unit); end
	},
	["RANGED_ATTACKSPEED"] = {
		updateFunc = function(statFrame, unit) MCF_PaperDollFrame_SetRangedAttackSpeed(statFrame, unit); end
	},
	["RANGED_CRITCHANCE"] = {
		updateFunc = function(statFrame, unit) MCF_PaperDollFrame_SetRangedCritChance(statFrame, unit); end
	},
	["RANGED_HITCHANCE"] = {
		updateFunc = function(statFrame, unit) MCF_PaperDollFrame_SetRangedHitChance(statFrame, unit); end
	}, 
	["RANGED_HASTE"] = {
		updateFunc = function(statFrame, unit) MCF_PaperDollFrame_SetRangedHaste(statFrame, unit); end
	},
	["RANGED_ARMOR_PENETRATION"] = {
		updateFunc = function(statFrame, unit) MCF_PaperDollFrame_SetArmorPenetration(statFrame, unit); end
	},
	["FOCUS_REGEN"] = {
		updateFunc = function(statFrame, unit) MCF_PaperDollFrame_SetFocusRegen(statFrame, unit); end
	},
	
	-- Spell
	["SPELLDAMAGE"] = {
		updateFunc = function(statFrame, unit) MCF_PaperDollFrame_SetSpellBonusDamage(statFrame, unit); end
	},
	["SPELLHEALING"] = {
		updateFunc = function(statFrame, unit) MCF_PaperDollFrame_SetSpellBonusHealing(statFrame, unit); end
	},
	["SPELL_HASTE"] = {
		updateFunc = function(statFrame, unit) MCF_PaperDollFrame_SetSpellHaste(statFrame, unit); end
	},
	["SPELL_HITCHANCE"] = {
		updateFunc = function(statFrame, unit) MCF_PaperDollFrame_SetSpellHitChance(statFrame, unit); end
	},
	["SPELL_PENETRATION"] = {
		updateFunc = function(statFrame, unit) MCF_PaperDollFrame_SetSpellPenetration(statFrame, unit); end
	},
	["MANAREGEN"] = {
		updateFunc = function(statFrame, unit) MCF_PaperDollFrame_SetManaRegen(statFrame, unit); end
	},
	["COMBATMANAREGEN"] = {
		updateFunc = function(statFrame, unit) MCF_PaperDollFrame_SetCombatManaRegen(statFrame, unit); end
	},
	["SPELLCRIT"] = {
		updateFunc = function(statFrame, unit) MCF_PaperDollFrame_SetSpellCritChance(statFrame, unit); end
	},
	
	-- Defense
	["ARMOR"] = {
		updateFunc = function(statFrame, unit) MCF_PaperDollFrame_SetArmor(statFrame, unit); end
	},
	["DEFENSE"] = {
		updateFunc = function(statFrame, unit) MCF_PaperDollFrame_SetDefense(statFrame, unit); end
	},
	["DODGE"] = {
		updateFunc = function(statFrame, unit) MCF_PaperDollFrame_SetDodge(statFrame, unit); end
	},
	["PARRY"] = {
		updateFunc = function(statFrame, unit) MCF_PaperDollFrame_SetParry(statFrame, unit); end
	},
	["BLOCK"] = {
		updateFunc = function(statFrame, unit) MCF_PaperDollFrame_SetBlock(statFrame, unit); end
	},
	["RESILIENCE_REDUCTION"] = {
		updateFunc = function(statFrame, unit) MCF_PaperDollFrame_SetResilience(statFrame, unit); end
	},
	["RESILIENCE_CRIT"] = {
		-- TODO
		updateFunc = function(statFrame, unit) MCF_PaperDollFrame_SetResilience(statFrame, unit); end
	},
	
	-- Resistance
	["ARCANE"] = {
		updateFunc = function(statFrame, unit) MCF_PaperDollFrame_SetResistance(statFrame, unit, 6); end
	},
	["FIRE"] = {
		updateFunc = function(statFrame, unit) MCF_PaperDollFrame_SetResistance(statFrame, unit, 2); end
	},
	["FROST"] = {
		updateFunc = function(statFrame, unit) MCF_PaperDollFrame_SetResistance(statFrame, unit, 3); end
	},
	["NATURE"] = {
		updateFunc = function(statFrame, unit) MCF_PaperDollFrame_SetResistance(statFrame, unit, 4); end
	},
	["SHADOW"] = {
		updateFunc = function(statFrame, unit) MCF_PaperDollFrame_SetResistance(statFrame, unit, 5); end
	},
};
-- Warning: Avoid changing the IDs, since this will screw up the cvars that remember which categories a player has collapsed
MCF_PAPERDOLL_STATCATEGORIES = {
	["GENERAL"] = {
			id = 1,
			stats = { 
				"HEALTH",
				"DRUIDMANA",  -- Only appears for Druids when in bear/cat form
				"POWER",
				"ITEMLEVEL",
				"REPAIR",
				"MOVESPEED",
			}
	},
						
	["ATTRIBUTES"] = {
			id = 2,
			stats = {
				"STRENGTH",
				"AGILITY",
				"STAMINA",
				"INTELLECT",
				"SPIRIT"
			}
	},
					
	["MELEE"] = {
			id = 3,
			stats = {
				"MELEE_DAMAGE", 
				"MELEE_DPS", 
				"MELEE_AP", 
				"MELEE_ATTACKSPEED", 
				"HASTE", 
				"ENERGY_REGEN",
				"RUNE_REGEN",
				"HITCHANCE", 
				"CRITCHANCE",
				"MELEE_ARMOR_PENETRATION",
				"EXPERTISE",
				--[[ "MASTERY", ]] -- Disabled Mastery because it doesn't exist in WotLK Classic
			}
	},
				
	["RANGED"] = {
			id = 4,
			stats = {
				"RANGED_DAMAGE", 
				"RANGED_DPS", 
				"RANGED_AP", 
				"RANGED_ATTACKSPEED", 
				"RANGED_HASTE",
				"FOCUS_REGEN",
				"RANGED_HITCHANCE",
				"RANGED_CRITCHANCE",
				"RANGED_ARMOR_PENETRATION",
				--[[ "MASTERY", ]] -- Disabled Mastery because it doesn't exist in WotLK Classic
			}
	},
				
	["SPELL"] = {
			id = 5,
			stats = {
				"SPELLDAMAGE",    -- If Damage and Healing are the same, this changes to Spell Power
				"SPELLHEALING",    -- If Damage and Healing are the same, this is hidden
				"SPELL_HASTE", 
				"SPELL_HITCHANCE",
				"SPELL_PENETRATION",
				"MANAREGEN",
				"COMBATMANAREGEN",
				"SPELLCRIT",
				--[[ "MASTERY", ]] -- Disabled Mastery because it doesn't exist in WotLK Classic
			}
	},
			
	["DEFENSE"] = {
			id = 6,
			stats = {
				"ARMOR",
				"DEFENSE",
				"DODGE",
				"PARRY", 
				"BLOCK",
				"RESILIENCE_REDUCTION", 
				--"RESILIENCE_CRIT",
			}
	},

	["RESISTANCE"] = {
			id = 7,
			stats = {
				"ARCANE", 
				"FIRE", 
				"FROST", 
				"NATURE", 
				"SHADOW",
			}
	},
};

MCF_PAPERDOLL_STATCATEGORY_DEFAULTORDER = {
	"GENERAL",
	"ATTRIBUTES",
	"MELEE",
	"RANGED",
	"SPELL",
	"DEFENSE",
	"RESISTANCE",
};

MCF_BASE_MISS_CHANCE_PHYSICAL = {
	[0] = 5.0;
	[1] = 5.5;
	[2] = 6.0;
	[3] = 8.0;
};

MCF_BASE_MISS_CHANCE_SPELL = {
	[0] = 4.0;
	[1] = 5.0;
	[2] = 6.0;
	[3] = 17.0;
};

MCF_BASE_ENEMY_DODGE_CHANCE = {
	[0] = 5.0;
	[1] = 5.5;
	[2] = 6.0;
	[3] = 6.5;
};

MCF_BASE_ENEMY_PARRY_CHANCE = {
	[0] = 5.0;
	[1] = 5.5;
	[2] = 6.0;
	[3] = 14.0;
};

MCF_DUAL_WIELD_HIT_PENALTY = 19.0;

MCF_TALENTS_FOR_HIT = {
	["DEATHKNIGHT"] = {
		-- Nerves of Cold Steel has manual check in Stats.lua
		
		-- Virulence
		[1] = {
			tab = 3,
			index = 1,
			increment = 1,
			all_schools = true,
			icon = "Interface\\Icons\\spell_shadow_burningspirit",
			hit_types = {
				"spells",
			},
		},
	},
	["DRUID"] = {
		-- Balance of Power
		[1] = {
			tab = 1,
			index = 13,
			increment = 2,
			all_schools = true,
			icon = "Interface\\Icons\\ability_druid_balanceofpower",
			hit_types = {
				'spells',
			},
		},
	},
	["HUNTER"] = {
		-- Focused Aim
		[1] = {
			tab = 2,
			index = 27,
			increment = 1,
			all_schools = true,
			icon = "Interface\\Icons\\ability_hunter_focusedaim",
			hit_types = {
				"melee",
				"ranged",
			},
		},
	},
	["MAGE"] = {
		-- Precision
		[1] = {
			tab = 3,
			index = 17,
			increment = 1,
			all_schools = true,
			icon = "Interface\\Icons\\spell_ice_magicdamage",
			hit_types = {
				"spells",
			},
		},
		-- Arcane Focus
		[2] = {
			tab = 1,
			index = 3,
			increment = 1,
			all_schools = false,
			schools = {
				nil,
				nil,
				false, -- Holy (id 2)
				false, -- Fire
				false, -- Nature
				false, -- Frost
				false, -- Shadow
				true,  -- Arcane
			},
			icon = "Interface\\Icons\\spell_holy_devotion",
			hit_types = {
				"spells",
			},
		},
	},
	["PALADIN"] = {
		-- Enlightened Judgements
		[1] = {
			tab = 1,
			index = 22,
			increment = 2,
			all_schools = true,
			icon = "Interface\\Icons\\ability_paladin_enlightenedjudgements",
			hit_types = "all",
		},
	},
	["PRIEST"] = {
		-- Shadow Focus
		[1] = {
			tab = 3,
			index = 3,
			increment = 1,
			all_schools = false,
			schools = {
				nil,
				nil,
				false, -- Holy (id 2)
				false, -- Fire
				false, -- Nature
				false, -- Frost
				true,  -- Shadow
				false, -- Arcane
			},
			icon = "Interface\\Icons\\spell_shadow_burningspirit",
			hit_types = {
				"spells",
			},
		},
	},
	["ROGUE"] = {
		-- Precision
		[1] = {
			tab = 2,
			index = 1,
			increment = 1,
			all_schools = true,
			icon = "Interface\\Icons\\ability_marksmanship",
			hit_types = "all",
		},
	},
	["SHAMAN"] = {
		-- Heroic Presence (racial) has manual check in Stats.lua

		-- Elemental Precision
		[1] = {
			tab = 1,
			index = 16,
			increment = 1,
			all_schools = false,
			schools = {
				nil,
				nil,
				false, -- Holy (id 2)
				true,  -- Fire
				true,  -- Nature
				true,  -- Frost
				false, -- Shadow
				false, -- Arcane
			},
			icon = "Interface\\Icons\\spell_nature_elementalprecision_1",
			hit_types = {
				"spells",
			},
		},
		-- Dual Wield Specialization has manual check in Stats.lua
	},
	["WARLOCK"] = {
		-- Suppression
		[1] = {
			tab = 1,
			index = 5,
			increment = 1,
			all_schools = true,
			icon = "Interface\\Icons\\spell_shadow_unsummonbuilding",
			hit_types = {
				"spells",
			},
		},
	},
	["WARRIOR"] = {
		-- Precision
		[1] = {
			tab = 2,
			index = 18,
			increment = 1,
			all_schools = true,
			icon = "Interface\\Icons\\ability_marksmanship",
			hit_types = {
				"melee",
				"ranged",
			},
		},
	},
};

----------------------------------------------------------------------------------
------------------------------------- TITLES -------------------------------------
----------------------------------------------------------------------------------

MCF_PLAYER_DISPLAYED_TITLES = 6;
MCF_PLAYER_TITLE_HEIGHT = 22;

----------------------------------------------------------------------------------
------------------------------- EQUIPMENT MANAGER --------------------------------
----------------------------------------------------------------------------------
MCF_VERTICAL_FLYOUTS = { [16] = true, [17] = true, [18] = true };
MCF_EQUIPMENTSET_BUTTON_HEIGHT = 44;

StaticPopupDialogs["MCF_CONFIRM_OVERWRITE_EQUIPMENT_SET"] = {
	text = CONFIRM_OVERWRITE_EQUIPMENT_SET,
	button1 = YES,
	button2 = NO,
	OnAccept = function (self) C_EquipmentSet.SaveEquipmentSet(self.data, self.selectedIcon); MCF_GearManagerDialogPopup:Hide(); end,
	OnCancel = function (self) end,
	OnHide = function (self) self.data = nil; self.selectedIcon = nil; end,
	hideOnEscape = 1,
	timeout = 0,
	exclusive = 1,
	whileDead = 1,
};