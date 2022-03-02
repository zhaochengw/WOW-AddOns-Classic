if not Talented_Data then return end

Talented_Data.ROGUE = {
	{
		numtalents = 21,
		talents = {
			{
				info = {
					name = "Improved Eviscerate",
					tips = "Increases the damage done by your Eviscerate ability by %d%%.",
					tipValues = {{5}, {10}, {15}},
					column = 1,
					row = 1,
					icon = 132292,
					ranks = 3,
				},
			}, -- [1]
			{
				info = {
					name = "Remorseless Attacks",
					tips = "After killing an opponent that yields experience or honor, gives you a %d%% increased critical strike chance on your next Sinister Strike, Hemorrhage, Backstab, Mutilate, Ambush, or Ghostly Strike.  Lasts 20 sec.",
					tipValues = {{20}, {40}},
					column = 2,
					row = 1,
					icon = 132151,
					ranks = 2,
				},
			}, -- [2]
			{
				info = {
					name = "Malice",
					tips = "Increases your critical strike chance by %d%%.",
					tipValues = {{1}, {2}, {3}, {4}, {5}},
					column = 3,
					row = 1,
					icon = 132277,
					ranks = 5,
				},
			}, -- [3]
			{
				info = {
					name = "Ruthlessness",
					tips = "Gives your melee finishing moves a %d%% chance to add a combo point to your target.",
					tipValues = {{20}, {40}, {60}},
					column = 1,
					row = 2,
					icon = 132122,
					ranks = 3,
				},
			}, -- [4]
			{
				info = {
					name = "Murder",
					tips = "Increases all damage caused against Humanoid, Giant, Beast and Dragonkin targets by %d%%.",
					tipValues = {{1}, {2}},
					column = 2,
					row = 2,
					icon = 136147,
					ranks = 2,
				},
			}, -- [5]
			{
				info = {
					name = "Puncturing Wounds",
					tips = "Increases the critical strike chance of your Backstab ability by %d%%, and the critical strike chance of your Mutilate ability by %d%%.",
					tipValues = {{10, 5}, {20, 10}, {30, 15}},
					column = 4,
					row = 2,
					icon = 132090,
					ranks = 3,
				},
			}, -- [6]
			{
				info = {
					tips = "Your finishing moves have a 20% chance per combo point to restore 25 energy.",
					name = "Relentless Strikes",
					row = 3,
					column = 1,
					exceptional = 1,
					icon = 132340,
					ranks = 1,
				},
			}, -- [7]
			{
				info = {
					name = "Improved Expose Armor",
					tips = "Increases the armor reduced by your Expose Armor ability by %d%%.",
					tipValues = {{25}, {50}},
					column = 2,
					row = 3,
					icon = 132354,
					ranks = 2,
				},
			}, -- [8]
			{
				info = {
					prereqs = {
						{
							column = 3,
							row = 1,
							source = 3,
						}, -- [1]
					},
					name = "Lethality",
					tips = "Increases the critical strike damage bonus of your Sinister Strike, Gouge, Backstab, Ghostly Strike, Mutilate, Shiv, and Hemorrhage abilities by %d%%.",
					tipValues = {{6}, {12}, {18}, {24}, {30}},
					column = 3,
					row = 3,
					icon = 132109,
					ranks = 5,
				},
			}, -- [9]
			{
				info = {
					name = "Vile Poisons",
					tips = "Increases the damage dealt by your poisons and Envenom ability by %d%% and gives your poisons an additional %d%% chance to resist dispel effects.",
					tipValues = {{4, 8}, {8, 16}, {12, 24}, {16, 32}, {20, 40}},
					column = 2,
					row = 4,
					icon = 132293,
					ranks = 5,
				},
			}, -- [10]
			{
				info = {
					name = "Improved Poisons",
					tips = "Increases the chance to apply poisons to your target by %d%%.",
					tipValues = {{2}, {4}, {6}, {8}, {10}},
					column = 3,
					row = 4,
					icon = 132273,
					ranks = 5,
				},
			}, -- [11]
			{
				info = {
					name = "Fleet Footed",
					tips = "Increases your chance to resist movement impairing effects by %d%% and increases your movement speed by %d%%.  This does not stack with other movement speed increasing effects.",
					tipValues = {{5, 8}, {10, 15}},
					column = 1,
					row = 5,
					icon = 132296,
					ranks = 2,
				},
			}, -- [12]
			{
				info = {
					tips = "When activated, increases the critical strike chance of your next offensive ability by 100%.",
					name = "Cold Blood",
					row = 5,
					column = 2,
					exceptional = 1,
					icon = 135988,
					ranks = 1,
				},
			}, -- [13]
			{
				info = {
					name = "Improved Kidney Shot",
					tips = "While affected by your Kidney Shot ability, the target receives an additional %d%% damage from all sources.",
					tipValues = {{3}, {6}, {9}},
					column = 3,
					row = 5,
					icon = 132298,
					ranks = 3,
				},
			}, -- [14]
			{
				info = {
					name = "Quick Recovery",
					tips = "All healing effects on you are increased by %d%%.  In addition, your finishing moves cost %d%% less Energy when they fail to hit.",
					tipValues = {{10, 40}, {20, 80}},
					column = 4,
					row = 5,
					icon = 132301,
					ranks = 2,
				},
			}, -- [15]
			{
				info = {
					prereqs = {
						{
							column = 2,
							row = 5,
							source = 13,
						}, -- [1]
					},
					name = "Seal Fate",
					tips = "Your critical strikes from abilities that add combo points have a %d%% chance to add an additional combo point.",
					tipValues = {{20}, {40}, {60}, {80}, {100}},
					column = 2,
					row = 6,
					icon = 136130,
					ranks = 5,
				},
			}, -- [16]
			{
				info = {
					name = "Master Poisoner",
					tips = "Reduces the chance your poisons will be resisted by %d%% and increases your chance to resist Poison effects by an additional %d%%.",
					tipValues = {{5, 15}, {10, 30}},
					column = 3,
					row = 6,
					icon = 132108,
					ranks = 2,
				},
			}, -- [17]
			{
				info = {
					name = "Vigor",
					tips = "Increases your maximum Energy by 10.",
					column = 2,
					row = 7,
					icon = 136023,
					ranks = 1,
				},
			}, -- [18]
			{
				info = {
					name = "Deadened Nerves",
					tips = "Decreases all physical damage taken by %d%%.",
					tipValues = {{1}, {2}, {3}, {4}, {5}},
					column = 3,
					row = 7,
					icon = 132286,
					ranks = 5,
				},
			}, -- [19]
			{
				info = {
					name = "Find Weakness",
					tips = "Your finishing moves increase the damage of all your offensive abilities by %d%% for 10 sec.",
					tipValues = {{2}, {4}, {6}, {8}, {10}},
					column = 3,
					row = 8,
					icon = 132295,
					ranks = 5,
				},
			}, -- [20]
			{
				info = {
					tips = "Instantly attacks with both weapons for an additional 44 with each weapon.  Damage is increased by 50% against Poisoned targets.  Must be behind the target.  Awards 2 combo points.",
					prereqs = {
						{
							column = 2,
							row = 7,
							source = 18,
						}, -- [1]
					},
					name = "Mutilate",
					row = 9,
					column = 2,
					exceptional = 1,
					icon = 132304,
					ranks = 1,
				},
			}, -- [21]
		},
		info = {
			name = "Assassination",
			background = "RogueAssassination",
		},
	}, -- [1]
	{
		numtalents = 24,
		talents = {
			{
				info = {
					name = "Improved Gouge",
					tips = "Increases the effect duration of your Gouge ability by %.1f sec.",
					tipValues = {{0.5}, {1.0}, {1.5}},
					column = 1,
					row = 1,
					icon = 132155,
					ranks = 3,
				},
			}, -- [1]
			{
				info = {
					name = "Improved Sinister Strike",
					tips = "Reduces the Energy cost of your Sinister Strike ability by %d.",
					tipValues = {{3}, {5}},
					column = 2,
					row = 1,
					icon = 136189,
					ranks = 2,
				},
			}, -- [2]
			{
				info = {
					name = "Lightning Reflexes",
					tips = "Increases your Dodge chance by %d%%.",
					tipValues = {{1}, {2}, {3}, {4}, {5}},
					column = 3,
					row = 1,
					icon = 136047,
					ranks = 5,
				},
			}, -- [3]
			{
				info = {
					name = "Improved Slice and Dice",
					tips = "Increases the duration of your Slice and Dice ability by %d%%.",
					tipValues = {{15}, {30}, {45}},
					column = 1,
					row = 2,
					icon = 132306,
					ranks = 3,
				},
			}, -- [4]
			{
				info = {
					name = "Deflection",
					tips = "Increases your Parry chance by %d%%.",
					tipValues = {{1}, {2}, {3}, {4}, {5}},
					column = 2,
					row = 2,
					icon = 132269,
					ranks = 5,
				},
			}, -- [5]
			{
				info = {
					name = "Precision",
					tips = "Increases your chance to hit with weapons by %d%%.",
					tipValues = {{1}, {2}, {3}, {4}, {5}},
					column = 3,
					row = 2,
					icon = 132222,
					ranks = 5,
				},
			}, -- [6]
			{
				info = {
					name = "Endurance",
					tips = "Reduces the cooldown of your Sprint and Evasion abilities by %d sec.",
					tipValues = {{45}, {90}},
					column = 1,
					row = 3,
					icon = 136205,
					ranks = 2,
				},
			}, -- [7]
			{
				info = {
					tips = "A strike that becomes active after parrying an opponent's attack.  This attack deals 150% weapon damage and disarms the target for 6 sec.",
					prereqs = {
						{
							column = 2,
							row = 2,
							source = 5,
						}, -- [1]
					},
					name = "Riposte",
					row = 3,
					column = 2,
					exceptional = 1,
					icon = 132336,
					ranks = 1,
				},
			}, -- [8]
			{
				info = {
					name = "Improved Sprint",
					tips = "Gives a %d%% chance to remove all Movement Impairing effects when you activate your Sprint ability.",
					tipValues = {{50}, {100}},
					column = 4,
					row = 3,
					icon = 132307,
					ranks = 2,
				},
			}, -- [9]
			{
				info = {
					name = "Improved Kick",
					tips = "Gives your Kick ability a %d%% chance to silence the target for 2 sec.",
					tipValues = {{50}, {100}},
					column = 1,
					row = 4,
					icon = 132219,
					ranks = 2,
				},
			}, -- [10]
			{
				info = {
					name = "Dagger Specialization",
					tips = "Increases your chance to get a critical strike with Daggers by %d%%.",
					tipValues = {{1}, {2}, {3}, {4}, {5}},
					column = 2,
					row = 4,
					icon = 135641,
					ranks = 5,
				},
			}, -- [11]
			{
				info = {
					prereqs = {
						{
							column = 3,
							row = 2,
							source = 6,
						}, -- [1]
					},
					name = "Dual Wield Specialization",
					tips = "Increases the damage done by your offhand weapon by %d%%.",
					tipValues = {{10}, {20}, {30}, {40}, {50}},
					column = 3,
					row = 4,
					icon = 132147,
					ranks = 5,
				},
			}, -- [12]
			{
				info = {
					name = "Mace Specialization",
					tips = "Increases the damage dealt by your critical strikes with maces by %d%%, and gives you a %d%% chance to stun your target for 3 sec with a mace.",
					tipValues = {{1, 1}, {2, 2}, {3, 3}, {4, 4}, {5, 5}},
					column = 1,
					row = 5,
					icon = 133476,
					ranks = 5,
				},
			}, -- [13]
			{
				info = {
					tips = "Increases your attack speed by 20%.  In addition, attacks strike an additional nearby opponent.  Lasts 15 sec.",
					name = "Blade Flurry",
					row = 5,
					column = 2,
					exceptional = 1,
					icon = 132350,
					ranks = 1,
				},
			}, -- [14]
			{
				info = {
					name = "Sword Specialization",
					tips = "Gives you a %d%% chance to get an extra attack on the same target after hitting your target with your Sword.",
					tipValues = {{1}, {2}, {3}, {4}, {5}},
					column = 3,
					row = 5,
					icon = 135328,
					ranks = 5,
				},
			}, -- [15]
			{
				info = {
					name = "Fist Weapon Specialization",
					tips = "Increases your chance to get a critical strike with Fist Weapons by %d%%.",
					tipValues = {{1}, {2}, {3}, {4}, {5}},
					column = 4,
					row = 5,
					icon = 132938,
					ranks = 5,
				},
			}, -- [16]
			{
				info = {
					name = "Blade Twisting",
					tips = "Gives your Sinister Strike, Backstab, Gouge and Shiv abilities a %d%% chance to Daze the target for 8 sec.",
					tipValues = {{10}, {20}},
					column = 1,
					row = 6,
					icon = 132283,
					ranks = 2,
				},
			}, -- [17]
			{
				info = {
					prereqs = {
						{
							column = 2,
							row = 5,
							source = 14,
						}, -- [1]
					},
					name = "Weapon Expertise",
					tips = "Increases your expertise by %d.",
					tipValues = {{5}, {10}},
					column = 2,
					row = 6,
					icon = 135882,
					ranks = 2,
				},
			}, -- [18]
			{
				info = {
					name = "Aggression",
					tips = "Increases the damage of your Sinister Strike, Backstab, and Eviscerate abilities by %d%%.",
					tipValues = {{2}, {4}, {6}},
					column = 3,
					row = 6,
					icon = 132275,
					ranks = 3,
				},
			}, -- [19]
			{
				info = {
					name = "Vitality",
					tips = "Increases your total Stamina by %d%% and your total Agility by %d%%.",
					tipValues = {{2, 1}, {4, 2}},
					column = 1,
					row = 7,
					icon = 132353,
					ranks = 2,
				},
			}, -- [20]
			{
				info = {
					tips = "Increases your Energy regeneration rate by 100% for 15 sec.",
					name = "Adrenaline Rush",
					row = 7,
					column = 2,
					exceptional = 1,
					icon = 136206,
					ranks = 1,
				},
			}, -- [21]
			{
				info = {
					name = "Nerves of Steel",
					tips = "Increases your chance to resist Stun and Fear effects by an additional %d%%.",
					tipValues = {{5}, {10}},
					column = 3,
					row = 7,
					icon = 132300,
					ranks = 2,
				},
			}, -- [22]
			{
				info = {
					name = "Combat Potency",
					tips = "Gives your successful off-hand melee attacks a 20%% chance to generate %d Energy.",
					tipValues = {{3}, {6}, {9}, {12}, {15}},
					column = 3,
					row = 8,
					icon = 135673,
					ranks = 5,
				},
			}, -- [23]
			{
				info = {
					tips = "Your finishing moves can no longer be dodged, and the damage dealt by your Sinister Strike, Backstab, Shiv and Gouge abilities is increased by 10%.",
					prereqs = {
						{
							column = 2,
							row = 7,
							source = 21,
						}, -- [1]
					},
					name = "Surprise Attacks",
					row = 9,
					column = 2,
					exceptional = 1,
					icon = 132308,
					ranks = 1,
				},
			}, -- [24]
		},
		info = {
			name = "Combat",
			background = "RogueCombat",
		},
	}, -- [2]
	{
		numtalents = 22,
		talents = {
			{
				info = {
					name = "Master of Deception",
					tips = "Reduces the chance enemies have to detect you while in Stealth mode.",
					column = 2,
					row = 1,
					icon = 136129,
					ranks = 5,
				},
			}, -- [1]
			{
				info = {
					name = "Opportunity",
					tips = "Increases the damage dealt when striking from behind with your Backstab, Mutilate, Garrote and Ambush abilities by %d%%.",
					tipValues = {{4}, {8}, {12}, {16}, {20}},
					column = 3,
					row = 1,
					icon = 132366,
					ranks = 5,
				},
			}, -- [2]
			{
				info = {
					name = "Sleight of Hand",
					tips = "Reduces the chance you are critically hit by melee and ranged attacks by %d%% and increases the threat reduction of your Feint ability by %d%%.",
					tipValues = {{1, 10}, {2, 20}},
					column = 1,
					row = 2,
					icon = 132294,
					ranks = 2,
				},
			}, -- [3]
			{
				info = {
					name = "Dirty Tricks",
					tips = "Increases the range of your Blind and Sap abilities by %d yards and reduces the energy cost of your Blind and Sap abilities by %d%%.",
					tipValues = {{2, 25}, {5, 50}},
					column = 2,
					row = 2,
					icon = 132310,
					ranks = 2,
				},
			}, -- [4]
			{
				info = {
					name = "Camouflage",
					tips = "Increases your speed while stealthed by %d%% and reduces the cooldown of your Stealth ability by %d sec.",
					tipValues = {{3, 1}, {6, 2}, {9, 3}, {12, 4}, {15, 5}},
					column = 3,
					row = 2,
					icon = 132320,
					ranks = 5,
				},
			}, -- [5]
			{
				info = {
					name = "Initiative",
					tips = "Gives you a %d%% chance to add an additional combo point to your target when using your Ambush, Garrote, or Cheap Shot ability.",
					tipValues = {{25}, {50}, {75}},
					column = 1,
					row = 3,
					icon = 136159,
					ranks = 3,
				},
			}, -- [6]
			{
				info = {
					tips = "A strike that deals 125% weapon damage and increases your chance to dodge by 15% for 7 sec.  Awards 1 combo point.",
					name = "Ghostly Strike",
					row = 3,
					column = 2,
					exceptional = 1,
					icon = 136136,
					ranks = 1,
				},
			}, -- [7]
			{
				info = {
					name = "Improved Ambush",
					tips = "Increases the critical strike chance of your Ambush ability by %d%%.",
					tipValues = {{15}, {30}, {45}},
					column = 3,
					row = 3,
					icon = 132282,
					ranks = 3,
				},
			}, -- [8]
			{
				info = {
					name = "Setup",
					tips = "Gives you a %d%% chance to add a combo point to your target after dodging their attack or fully resisting one of their spells.",
					tipValues = {{15}, {30}, {45}},
					column = 1,
					row = 4,
					icon = 136056,
					ranks = 3,
				},
			}, -- [9]
			{
				info = {
					name = "Elusiveness",
					tips = "Reduces the cooldown of your Vanish and Blind abilities by %d sec.",
					tipValues = {{45}, {90}},
					column = 2,
					row = 4,
					icon = 135994,
					ranks = 2,
				},
			}, -- [10]
			{
				info = {
					name = "Serrated Blades",
					tips = "Causes your attacks to ignore %.2f*level of your target's Armor and increases the damage dealt by your Rupture ability by %d%%.  The amount of Armor reduced increases with your level.",
					tipValues = {{2.67, 10}, {5.43, 20}, {8, 30}},
					column = 3,
					row = 4,
					icon = 135315,
					ranks = 3,
				},
			}, -- [11]
			{
				info = {
					name = "Heightened Senses",
					tips = "Increases your Stealth detection and reduces the chance you are hit by spells and ranged attacks by %d%%.",
					tipValues = {{2}, {4}},
					column = 1,
					row = 5,
					icon = 132089,
					ranks = 2,
				},
			}, -- [12]
			{
				info = {
					tips = "When activated, this ability immediately finishes the cooldown on your Evasion, Sprint, Vanish, Cold Blood, Shadowstep and Premeditation abilities.",
					name = "Preparation",
					row = 5,
					column = 2,
					exceptional = 1,
					icon = 136121,
					ranks = 1,
				},
			}, -- [13]
			{
				info = {
					name = "Dirty Deeds",
					tips = "Reduces the Energy cost of your Cheap Shot and Garrote abilities by %d.  Additionally, your special abilities cause %d%% more damage against targets below 35%% health.",
					tipValues = {{10, 10}, {20, 20}},
					column = 3,
					row = 5,
					icon = 136220,
					ranks = 2,
				},
			}, -- [14]
			{
				info = {
					tips = "An instant strike that deals 110% weapon damage and causes the target to hemorrhage, increasing any Physical damage dealt to the target by up to 13.  Lasts 10 charges or 15 sec.  Awards 1 combo point.",
					prereqs = {
						{
							column = 3,
							row = 4,
							source = 11,
						}, -- [1]
					},
					name = "Hemorrhage",
					row = 5,
					column = 4,
					exceptional = 1,
					icon = 136168,
					ranks = 1,
				},
			}, -- [15]
			{
				info = {
					name = "Master of Subtlety",
					tips = "Attacks made while stealthed and for 6 seconds after breaking stealth cause an additional %d%% damage.",
					tipValues = {{4}, {7}, {10}},
					column = 1,
					row = 6,
					icon = 132299,
					ranks = 3,
				},
			}, -- [16]
			{
				info = {
					name = "Deadliness",
					tips = "Increases your attack power by %d%%.",
					tipValues = {{2}, {4}, {6}, {8}, {10}},
					column = 3,
					row = 6,
					icon = 135540,
					ranks = 5,
				},
			}, -- [17]
			{
				info = {
					name = "Enveloping Shadows",
					tips = "Increases your chance to avoid area of effect attacks by an additional %d%%.",
					tipValues = {{5}, {10}, {15}},
					column = 1,
					row = 7,
					icon = 132291,
					ranks = 3,
				},
			}, -- [18]
			{
				info = {
					tips = "When used, adds 2 combo points to your target.  You must add to or use those combo points within 10 sec or the combo points are lost.",
					prereqs = {
						{
							column = 2,
							row = 5,
							source = 13,
						}, -- [1]
					},
					name = "Premeditation",
					row = 7,
					column = 2,
					exceptional = 1,
					icon = 136183,
					ranks = 1,
				},
			}, -- [19]
			{
				info = {
					name = "Cheat Death",
					tips = "You have a %d%% chance that an attack which would otherwise kill you will instead reduce you to 10%% of your maximum health. In addition, all damage taken will be reduced by up to 90%% for 3 sec (modified by resilience).  This effect cannot occur more than once per minute.",
					tipValues = {{33}, {66}, {100}},
					column = 3,
					row = 7,
					icon = 132285,
					ranks = 3,
				},
			}, -- [20]
			{
				info = {
					prereqs = {
						{
							column = 2,
							row = 7,
							source = 19,
						}, -- [1]
					},
					name = "Sinister Calling",
					tips = "Increases your total Agility by %d%% and increases the percentage damage bonus of Backstab and Hemorrhage by an additional %d%%.",
					tipValues = {{3, 1}, {6, 2}, {9, 3}, {12, 4}, {15, 5}},
					column = 2,
					row = 8,
					icon = 132305,
					ranks = 5,
				},
			}, -- [21]
			{
				info = {
					tips = "Attempts to step through the shadows and reappear behind your enemy and increases movement speed by 70% for 3 sec.  The damage of your next ability is increased by 20% and the threat caused is reduced by 50%.  Lasts 10 sec.",
					name = "Shadowstep",
					row = 9,
					column = 2,
					exceptional = 1,
					icon = 132303,
					ranks = 1,
				},
			}, -- [22]
		},
		info = {
			name = "Subtlety",
			background = "RogueSubtlety",
		},
	}, -- [3]
}
