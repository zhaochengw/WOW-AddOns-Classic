if not Talented_Data then return end

Talented_Data.MAGE = {
	{
		numtalents = 23,
		talents = {
			{
				info = {
					name = "Arcane Subtlety",
					tips = "Reduces your target's resistance to all your spells by %d and reduces the threat caused by your Arcane spells by %d%%.",
					tipValues = {{5, 20}, {10, 40}},
					column = 1,
					row = 1,
					icon = 135894,
					ranks = 2,
				},
			}, -- [1]
			{
				info = {
					name = "Arcane Focus",
					tips = "Reduces the chance that the opponent can resist your Arcane spells by %d%%.",
					tipValues = {{2}, {4}, {6}, {8}, {10}},
					column = 2,
					row = 1,
					icon = 135892,
					ranks = 5,
				},
			}, -- [2]
			{
				info = {
					name = "Improved Arcane Missiles",
					tips = "Gives you a %d%% chance to avoid interruption caused by damage while channeling Arcane Missiles.",
					tipValues = {{20}, {40}, {60}, {80}, {100}},
					column = 3,
					row = 1,
					icon = 136096,
					ranks = 5,
				},
			}, -- [3]
			{
				info = {
					name = "Wand Specialization",
					tips = "Increases your damage with Wands by %d%%.",
					tipValues = {{13}, {25}},
					column = 1,
					row = 2,
					icon = 135463,
					ranks = 2,
				},
			}, -- [4]
			{
				info = {
					name = "Magic Absorption",
					tips = "Increases all resistances by %d and causes all spells you fully resist to restore %d%% of your total mana.  1 sec. cooldown.",
					tipValues = {{2, 1}, {4, 2}, {6, 3}, {8, 4}, {10, 5}},
					column = 2,
					row = 2,
					icon = 136011,
					ranks = 5,
				},
			}, -- [5]
			{
				info = {
					name = "Arcane Concentration",
					tips = "Gives you a %d%% chance of entering a Clearcasting state after any damage spell hits a target.  The Clearcasting state reduces the mana cost of your next damage spell by 100%%.",
					tipValues = {{2}, {4}, {6}, {8}, {10}},
					column = 3,
					row = 2,
					icon = 136170,
					ranks = 5,
				},
			}, -- [6]
			{
				info = {
					name = "Magic Attunement",
					tips = "Increases the effect of your Amplify Magic and Dampen Magic spells by %d%%.",
					tipValues = {{25}, {50}},
					column = 1,
					row = 3,
					icon = 136006,
					ranks = 2,
				},
			}, -- [7]
			{
				info = {
					name = "Arcane Impact",
					tips = "Increases the critical strike chance of your Arcane Explosion and Arcane Blast spells by an additional %d%%.",
					tipValues = {{2}, {4}, {6}},
					column = 2,
					row = 3,
					icon = 136116,
					ranks = 3,
				},
			}, -- [8]
			{
				info = {
					tips = "Increases your armor by an amount equal to 100% of your Intellect.",
					name = "Arcane Fortitude",
					row = 3,
					column = 4,
					exceptional = 1,
					icon = 135733,
					ranks = 1,
				},
			}, -- [9]
			{
				info = {
					name = "Improved Mana Shield",
					tips = "Decreases the mana lost per point of damage taken when Mana Shield is active by %d%%.",
					tipValues = {{10}, {20}},
					column = 1,
					row = 4,
					icon = 136153,
					ranks = 2,
				},
			}, -- [10]
			{
				info = {
					name = "Improved Counterspell",
					tips = "Gives your Counterspell a %d%% chance to silence the target for 4 sec.",
					tipValues = {{50}, {100}},
					column = 2,
					row = 4,
					icon = 135856,
					ranks = 2,
				},
			}, -- [11]
			{
				info = {
					name = "Arcane Meditation",
					tips = "Allows %d%% of your mana regeneration to continue while casting.",
					tipValues = {{10}, {20}, {30}},
					column = 4,
					row = 4,
					icon = 136208,
					ranks = 3,
				},
			}, -- [12]
			{
				info = {
					name = "Improved Blink",
					tips = "For 4 sec after casting Blink, your chance to be hit by all attacks and spells is reduced by %d%%.",
					tipValues = {{13}, {25}},
					column = 1,
					row = 5,
					icon = 135736,
					ranks = 2,
				},
			}, -- [13]
			{
				info = {
					tips = "When activated, your next Mage spell with a casting time less than 10 sec becomes an instant cast spell.",
					name = "Presence of Mind",
					row = 5,
					column = 2,
					exceptional = 1,
					icon = 136031,
					ranks = 1,
				},
			}, -- [14]
			{
				info = {
					name = "Arcane Mind",
					tips = "Increases your total Intellect by %d%%.",
					tipValues = {{3}, {6}, {9}, {12}, {15}},
					column = 4,
					row = 5,
					icon = 136129,
					ranks = 5,
				},
			}, -- [15]
			{
				info = {
					name = "Prismatic Cloak",
					tips = "Reduces all damage taken by %d%%.",
					tipValues = {{2}, {4}},
					column = 1,
					row = 6,
					icon = 135752,
					ranks = 2,
				},
			}, -- [16]
			{
				info = {
					prereqs = {
						{
							column = 2,
							row = 5,
							source = 14,
						}, -- [1]
					},
					name = "Arcane Instability",
					tips = "Increases your spell damage and critical strike chance by %d%%.",
					tipValues = {{1}, {2}, {3}},
					column = 2,
					row = 6,
					icon = 136222,
					ranks = 3,
				},
			}, -- [17]
			{
				info = {
					prereqs = {
						{
							column = 3,
							row = 2,
							source = 6,
						}, -- [1]
					},
					name = "Arcane Potency",
					tips = "Increases the critical strike chance of any spell cast while Clearcasting by %d%%.",
					tipValues = {{10}, {20}, {30}},
					column = 3,
					row = 6,
					icon = 135732,
					ranks = 3,
				},
			}, -- [18]
			{
				info = {
					name = "Empowered Arcane Missiles",
					tips = "Your Arcane Missiles spell gains an additional %d%% of your bonus spell damage effects, but mana cost is increased by %d%%.",
					tipValues = {{15, 2}, {30, 4}, {45, 6}},
					column = 1,
					row = 7,
					icon = 136096,
					ranks = 3,
				},
			}, -- [19]
			{
				info = {
					tips = "When activated, your spells deal 30% more damage while costing 30% more mana to cast.  This effect lasts 15 sec.",
					prereqs = {
						{
							column = 2,
							row = 6,
							source = 17,
						}, -- [1]
					},
					name = "Arcane Power",
					row = 7,
					column = 2,
					exceptional = 1,
					icon = 136048,
					ranks = 1,
				},
			}, -- [20]
			{
				info = {
					name = "Spell Power",
					tips = "Increases critical strike damage bonus of all spells by %d%%.",
					tipValues = {{25}, {50}},
					column = 3,
					row = 7,
					icon = 135734,
					ranks = 2,
				},
			}, -- [21]
			{
				info = {
					name = "Mind Mastery",
					tips = "Increases spell damage by up to %d%% of your total Intellect.",
					tipValues = {{5}, {10}, {15}, {20}, {25}},
					column = 2,
					row = 8,
					icon = 135740,
					ranks = 5,
				},
			}, -- [22]
			{
				info = {
					tips = "Reduces target's movement speed by 50%, increases the time between ranged attacks by 50% and increases casting time by 50%.  Lasts 15 sec.  Slow can only affect one target at a time.",
					name = "Slow",
					row = 9,
					column = 2,
					exceptional = 1,
					icon = 136091,
					ranks = 1,
				},
			}, -- [23]
		},
		info = {
			name = "Arcane",
			background = "MageArcane",
		},
	}, -- [1]
	{
		numtalents = 22,
		talents = {
			{
				info = {
					name = "Improved Fireball",
					tips = "Reduces the casting time of your Fireball spell by %.1f sec.",
					tipValues = {{0.1}, {0.2}, {0.3}, {0.4}, {0.5}},
					column = 2,
					row = 1,
					icon = 135812,
					ranks = 5,
				},
			}, -- [1]
			{
				info = {
					name = "Impact",
					tips = "Gives your Fire spells a %d%% chance to stun the target for 2 sec.",
					tipValues = {{2}, {4}, {6}, {8}, {10}},
					column = 3,
					row = 1,
					icon = 135821,
					ranks = 5,
				},
			}, -- [2]
			{
				info = {
					name = "Ignite",
					tips = "Your critical strikes from Fire damage spells cause the target to burn for an additional %d%% of your spell's damage over 4 sec.",
					tipValues = {{8}, {16}, {24}, {32}, {40}},
					column = 1,
					row = 2,
					icon = 135818,
					ranks = 5,
				},
			}, -- [3]
			{
				info = {
					name = "Flame Throwing",
					tips = "Increases the range of your Fire spells by %d yards.",
					tipValues = {{3}, {6}},
					column = 2,
					row = 2,
					icon = 135815,
					ranks = 2,
				},
			}, -- [4]
			{
				info = {
					name = "Improved Fire Blast",
					tips = "Reduces the cooldown of your Fire Blast spell by %.1f sec.",
					tipValues = {{0.5}, {1.0}, {1.5}},
					column = 3,
					row = 2,
					icon = 135807,
					ranks = 3,
				},
			}, -- [5]
			{
				info = {
					name = "Incineration",
					tips = "Increases the critical strike chance of your Fire Blast and Scorch spells by %d%%.",
					tipValues = {{2}, {4}},
					column = 1,
					row = 3,
					icon = 135813,
					ranks = 2,
				},
			}, -- [6]
			{
				info = {
					name = "Improved Flamestrike",
					tips = "Increases the critical strike chance of your Flamestrike spell by %d%%.",
					tipValues = {{5}, {10}, {15}},
					column = 2,
					row = 3,
					icon = 135826,
					ranks = 3,
				},
			}, -- [7]
			{
				info = {
					tips = "Hurls an immense fiery boulder that causes 148 to 195 Fire damage and an additional 56 Fire damage over 12 sec.",
					name = "Pyroblast",
					row = 3,
					column = 3,
					exceptional = 1,
					icon = 135808,
					ranks = 1,
				},
			}, -- [8]
			{
				info = {
					name = "Burning Soul",
					tips = "Gives your Fire spells a %d%% chance to not lose casting time when you take damage and reduces the threat caused by your Fire spells by %d%%.",
					tipValues = {{35, 5}, {70, 10}},
					column = 4,
					row = 3,
					icon = 135805,
					ranks = 2,
				},
			}, -- [9]
			{
				info = {
					name = "Improved Scorch",
					tips = "Your Scorch spells have a %d%% chance to cause your target to be vulnerable to Fire damage.  This vulnerability increases the Fire damage dealt to your target by 3%% and lasts 30 sec.  Stacks up to 5 times.",
					tipValues = {{33}, {66}, {100}},
					column = 1,
					row = 4,
					icon = 135827,
					ranks = 3,
				},
			}, -- [10]
			{
				info = {
					name = "Molten Shields",
					tips = "Causes your Fire Ward to have a %d%% chance to reflect Fire spells while active. In addition, your Molten Armor has a %d%% chance to affect ranged and spell attacks.",
					tipValues = {{10, 50}, {20, 100}},
					column = 2,
					row = 4,
					icon = 135806,
					ranks = 2,
				},
			}, -- [11]
			{
				info = {
					name = "Master of Elements",
					tips = "Your Fire and Frost spell criticals will refund %d%% of their base mana cost.",
					tipValues = {{10}, {20}, {30}},
					column = 4,
					row = 4,
					icon = 135820,
					ranks = 3,
				},
			}, -- [12]
			{
				info = {
					name = "Playing with Fire",
					tips = "Increases all spell damage caused by %d%% and all spell damage taken by %d%%.",
					tipValues = {{1, 1}, {2, 2}, {3, 3}},
					column = 1,
					row = 5,
					icon = 135823,
					ranks = 3,
				},
			}, -- [13]
			{
				info = {
					name = "Critical Mass",
					tips = "Increases the critical strike chance of your Fire spells by %d%%.",
					tipValues = {{2}, {4}, {6}},
					column = 2,
					row = 5,
					icon = 136115,
					ranks = 3,
				},
			}, -- [14]
			{
				info = {
					tips = "A wave of flame radiates outward from the caster, damaging all enemies caught within the blast for 160 to 192 Fire damage, and Dazing them for 6 sec.",
					prereqs = {
						{
							column = 3,
							row = 3,
							source = 8,
						}, -- [1]
					},
					name = "Blast Wave",
					row = 5,
					column = 3,
					exceptional = 1,
					icon = 135903,
					ranks = 1,
				},
			}, -- [15]
			{
				info = {
					name = "Blazing Speed",
					tips = "Gives you a %d%% chance when hit by a melee or ranged attack to increase your movement speed by 50%% and dispel all movement impairing effects.  This effect lasts 8 sec.",
					tipValues = {{5}, {10}},
					column = 1,
					row = 6,
					icon = 135788,
					ranks = 2,
				},
			}, -- [16]
			{
				info = {
					name = "Fire Power",
					tips = "Increases the damage done by your Fire spells by %d%%.",
					tipValues = {{2}, {4}, {6}, {8}, {10}},
					column = 3,
					row = 6,
					icon = 135817,
					ranks = 5,
				},
			}, -- [17]
			{
				info = {
					name = "Pyromaniac",
					tips = "Increases chance to critically hit and reduces the mana cost of all Fire spells by an additional %d%%.",
					tipValues = {{1, 1}, {2, 2}, {3, 3}},
					column = 1,
					row = 7,
					icon = 135789,
					ranks = 3,
				},
			}, -- [18]
			{
				info = {
					tips = "When activated, this spell causes each of your Fire damage spell hits to increase your critical strike chance with Fire damage spells by 10%.  This effect lasts until you have caused 3 critical strikes with Fire spells.",
					prereqs = {
						{
							column = 2,
							row = 5,
							source = 14,
						}, -- [1]
					},
					name = "Combustion",
					row = 7,
					column = 2,
					exceptional = 1,
					icon = 135824,
					ranks = 1,
				},
			}, -- [19]
			{
				info = {
					name = "Molten Fury",
					tips = "Increases damage of all spells against targets with less than 20%% health by %d%%.",
					tipValues = {{10}, {20}},
					column = 3,
					row = 7,
					icon = 135822,
					ranks = 2,
				},
			}, -- [20]
			{
				info = {
					name = "Empowered Fireball",
					tips = "Your Fireball spell gains an additional %d%% of your bonus spell damage effects.",
					tipValues = {{3}, {6}, {9}, {12}, {15}},
					column = 3,
					row = 8,
					icon = 135812,
					ranks = 5,
				},
			}, -- [21]
			{
				info = {
					tips = "Targets in a cone in front of the caster take 382 to 442 Fire damage and are Disoriented for 3 sec.  Any direct damaging attack will revive targets.  Turns off your attack when used.",
					prereqs = {
						{
							column = 2,
							row = 7,
							source = 19,
						}, -- [1]
					},
					name = "Dragon's Breath",
					row = 9,
					column = 2,
					exceptional = 1,
					icon = 134153,
					ranks = 1,
				},
			}, -- [22]
		},
		info = {
			name = "Fire",
			background = "MageFire",
		},
	}, -- [2]
	{
		numtalents = 22,
		talents = {
			{
				info = {
					name = "Frost Warding",
					tips = "Increases the armor and resistances given by your Frost Armor and Ice Armor spells by %d%%.  In addition, gives your Frost Ward a %d%% chance to reflect Frost spells and effects while active.",
					tipValues = {{15, 10}, {30, 20}},
					column = 1,
					row = 1,
					icon = 135850,
					ranks = 2,
				},
			}, -- [1]
			{
				info = {
					name = "Improved Frostbolt",
					tips = "Reduces the casting time of your Frostbolt spell by %.1f sec.",
					tipValues = {{0.1}, {0.2}, {0.3}, {0.4}, {0.5}},
					column = 2,
					row = 1,
					icon = 135846,
					ranks = 5,
				},
			}, -- [2]
			{
				info = {
					name = "Elemental Precision",
					tips = "Reduces the mana cost and chance targets resist your Frost and Fire spells by %d%%.",
					tipValues = {{1}, {2}, {3}},
					column = 3,
					row = 1,
					icon = 135989,
					ranks = 3,
				},
			}, -- [3]
			{
				info = {
					name = "Ice Shards",
					tips = "Increases the critical strike damage bonus of your Frost spells by %d%%.",
					tipValues = {{20}, {40}, {60}, {80}, {100}},
					column = 1,
					row = 2,
					icon = 135855,
					ranks = 5,
				},
			}, -- [4]
			{
				info = {
					name = "Frostbite",
					tips = "Gives your Chill effects a %d%% chance to freeze the target for 5 sec.",
					tipValues = {{5}, {10}, {15}},
					column = 2,
					row = 2,
					icon = 135842,
					ranks = 3,
				},
			}, -- [5]
			{
				info = {
					name = "Improved Frost Nova",
					tips = "Reduces the cooldown of your Frost Nova spell by %d sec.",
					tipValues = {{2}, {4}},
					column = 3,
					row = 2,
					icon = 135840,
					ranks = 2,
				},
			}, -- [6]
			{
				info = {
					name = "Permafrost",
					tips = "Increases the duration of your Chill effects by %d sec and reduces the target's speed by an additional %d%%.",
					tipValues = {{1, 4}, {2, 7}, {3, 10}},
					column = 4,
					row = 2,
					icon = 135864,
					ranks = 3,
				},
			}, -- [7]
			{
				info = {
					name = "Piercing Ice",
					tips = "Increases the damage done by your Frost spells by %d%%.",
					tipValues = {{2}, {4}, {6}},
					column = 1,
					row = 3,
					icon = 135845,
					ranks = 3,
				},
			}, -- [8]
			{
				info = {
					tips = "Hastens your spellcasting, increasing spell casting speed by 20% and gives you 100% chance to avoid interruption caused by damage while casting.  Lasts 20 sec.",
					name = "Icy Veins",
					row = 3,
					column = 2,
					exceptional = 1,
					icon = 135838,
					ranks = 1,
				},
			}, -- [9]
			{
				info = {
					name = "Improved Blizzard",
					tips = "Adds a chill effect to your Blizzard spell.  This effect lowers the target's movement speed by %d%%.  Lasts 1.50 sec.",
					tipValues = {{30}, {50}, {65}},
					column = 4,
					row = 3,
					icon = 135857,
					ranks = 3,
				},
			}, -- [10]
			{
				info = {
					name = "Arctic Reach",
					tips = "Increases the range of your Frostbolt, Ice Lance and Blizzard spells and the radius of your Frost Nova and Cone of Cold spells by %d%%.",
					tipValues = {{10}, {20}},
					column = 1,
					row = 4,
					icon = 136141,
					ranks = 2,
				},
			}, -- [11]
			{
				info = {
					name = "Frost Channeling",
					tips = "Reduces the mana cost of your Frost spells by %d%% and reduces the threat caused by your Frost spells by %d%%.",
					tipValues = {{5, 4}, {10, 7}, {15, 10}},
					column = 2,
					row = 4,
					icon = 135860,
					ranks = 3,
				},
			}, -- [12]
			{
				info = {
					prereqs = {
						{
							column = 3,
							row = 2,
							source = 6,
						}, -- [1]
					},
					name = "Shatter",
					tips = "Increases the critical strike chance of all your spells against frozen targets by %d%%.",
					tipValues = {{10}, {20}, {30}, {40}, {50}},
					column = 3,
					row = 4,
					icon = 135849,
					ranks = 5,
				},
			}, -- [13]
			{
				info = {
					name = "Frozen Core",
					tips = "Reduces the damage taken by Frost and Fire effects by %d%%.",
					tipValues = {{2}, {4}, {6}},
					column = 1,
					row = 5,
					icon = 135851,
					ranks = 3,
				},
			}, -- [14]
			{
				info = {
					tips = "When activated, this spell finishes the cooldown on all Frost spells you recently cast.",
					name = "Cold Snap",
					row = 5,
					column = 2,
					exceptional = 1,
					icon = 135865,
					ranks = 1,
				},
			}, -- [15]
			{
				info = {
					name = "Improved Cone of Cold",
					tips = "Increases the damage dealt by your Cone of Cold spell by %d%%.",
					tipValues = {{15}, {25}, {35}},
					column = 3,
					row = 5,
					icon = 135852,
					ranks = 3,
				},
			}, -- [16]
			{
				info = {
					name = "Ice Floes",
					tips = "Reduces the cooldown of your Cone of Cold, Cold Snap, Ice Barrier and Ice Block spells by %d%%.",
					tipValues = {{10}, {20}},
					column = 1,
					row = 6,
					icon = 135854,
					ranks = 2,
				},
			}, -- [17]
			{
				info = {
					name = "Winter's Chill",
					tips = "Gives your Frost damage spells a %d%% chance to apply the Winter's Chill effect, which increases the chance a Frost spell will critically hit the target by 2%% for 15 sec.  Stacks up to 5 times.",
					tipValues = {{20}, {40}, {60}, {80}, {100}},
					column = 3,
					row = 6,
					icon = 135836,
					ranks = 5,
				},
			}, -- [18]
			{
				info = {
					tips = "Instantly shields you, absorbing 454 damage.  Lasts 1 min.  While the shield holds, spells will not be interrupted.",
					prereqs = {
						{
							column = 2,
							row = 5,
							source = 15,
						}, -- [1]
					},
					name = "Ice Barrier",
					row = 7,
					column = 2,
					exceptional = 1,
					icon = 135988,
					ranks = 1,
				},
			}, -- [19]
			{
				info = {
					name = "Arctic Winds",
					tips = "Increases all Frost damage you cause by %d%% and reduces the chance melee and ranged attacks will hit you by %d%%.",
					tipValues = {{1, 1}, {2, 2}, {3, 3}, {4, 4}, {5, 5}},
					column = 3,
					row = 7,
					icon = 135833,
					ranks = 5,
				},
			}, -- [20]
			{
				info = {
					name = "Empowered Frostbolt",
					tips = "Your Frostbolt spell gains an additional %d%% of your bonus spell damage effects and an additional %d%% chance to critically strike.",
					tipValues = {{2, 1}, {4, 2}, {6, 3}, {8, 4}, {10, 5}},
					column = 2,
					row = 8,
					icon = 135846,
					ranks = 5,
				},
			}, -- [21]
			{
				info = {
					tips = "Summon a Water Elemental to fight for the caster for 45 sec.",
					name = "Summon Water Elemental",
					row = 9,
					column = 2,
					exceptional = 1,
					icon = 135862,
					ranks = 1,
				},
			}, -- [22]
		},
		info = {
			name = "Frost",
			background = "MageFrost",
		},
	}, -- [3]
}
