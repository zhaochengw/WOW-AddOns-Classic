if not Talented_Data then return end

Talented_Data.PALADIN = {
	{
		numtalents = 20,
		talents = {
			{
				info = {
					name = "Divine Strength",
					tips = "Increases your total Strength by %d%%.",
					tipValues = {{2}, {4}, {6}, {8}, {10}},
					column = 2,
					row = 1,
					icon = 132154,
					ranks = 5,
				},
			}, -- [1]
			{
				info = {
					name = "Divine Intellect",
					tips = "Increases your total Intellect by %d%%.",
					tipValues = {{2}, {4}, {6}, {8}, {10}},
					column = 3,
					row = 1,
					icon = 136090,
					ranks = 5,
				},
			}, -- [2]
			{
				info = {
					name = "Spiritual Focus",
					tips = "Gives your Flash of Light and Holy Light spells a %d%% chance to not lose casting time when you take damage.",
					tipValues = {{14}, {28}, {42}, {56}, {70}},
					column = 2,
					row = 2,
					icon = 135736,
					ranks = 5,
				},
			}, -- [3]
			{
				info = {
					name = "Improved Seal of Righteousness",
					tips = "Increases the damage done by your Seal of Righteousness and Judgement of Righteousness by %d%%.",
					tipValues = {{3}, {6}, {9}, {12}, {15}},
					column = 3,
					row = 2,
					icon = 132325,
					ranks = 5,
				},
			}, -- [4]
			{
				info = {
					name = "Healing Light",
					tips = "Increases the amount healed by your Holy Light and Flash of Light spells by %d%%.",
					tipValues = {{4}, {8}, {12}},
					column = 1,
					row = 3,
					icon = 135920,
					ranks = 3,
				},
			}, -- [5]
			{
				info = {
					tips = "Increases the radius of your Auras to 40 yards.",
					name = "Aura Mastery",
					row = 3,
					column = 2,
					exceptional = 1,
					icon = 135872,
					ranks = 1,
				},
			}, -- [6]
			{
				info = {
					name = "Improved Lay on Hands",
					tips = "Gives the target of your Lay on Hands spell a %d%% bonus to their armor value from items for 2 min.  In addition, the cooldown for your Lay on Hands spell is reduced by %d min.",
					tipValues = {{15, 10}, {30, 20}},
					column = 3,
					row = 3,
					icon = 135928,
					ranks = 2,
				},
			}, -- [7]
			{
				info = {
					name = "Unyielding Faith",
					tips = "Increases your chance to resist Fear and Disorient effects by an additional %d%%.",
					tipValues = {{5}, {10}},
					column = 4,
					row = 3,
					icon = 135984,
					ranks = 2,
				},
			}, -- [8]
			{
				info = {
					name = "Illumination",
					tips = "After getting a critical effect from your Flash of Light, Holy Light, or Holy Shock heal spell, gives you a %d%% chance to gain mana equal to 60%% of the base cost of the spell.",
					tipValues = {{20}, {40}, {60}, {80}, {100}},
					column = 2,
					row = 4,
					icon = 135913,
					ranks = 5,
				},
			}, -- [9]
			{
				info = {
					name = "Improved Blessing of Wisdom",
					tips = "Increases the effect of your Blessing of Wisdom spell by %d%%.",
					tipValues = {{10}, {20}},
					column = 3,
					row = 4,
					icon = 135970,
					ranks = 2,
				},
			}, -- [10]
			{
				info = {
					name = "Pure of Heart",
					tips = "Increases your resistance to Curse and Disease effects by %d%%.",
					tipValues = {{5}, {10}, {15}},
					column = 1,
					row = 5,
					icon = 135948,
					ranks = 3,
				},
			}, -- [11]
			{
				info = {
					tips = "When activated, gives your next Flash of Light, Holy Light, or Holy Shock spell a 100% critical effect chance.",
					prereqs = {
						{
							column = 2,
							row = 4,
							source = 9,
						}, -- [1]
					},
					name = "Divine Favor",
					row = 5,
					column = 2,
					exceptional = 1,
					icon = 135915,
					ranks = 1,
				},
			}, -- [12]
			{
				info = {
					name = "Sanctified Light",
					tips = "Increases the critical effect chance of your Holy Light spell by %d%%.",
					tipValues = {{2}, {4}, {6}},
					column = 3,
					row = 5,
					icon = 135917,
					ranks = 3,
				},
			}, -- [13]
			{
				info = {
					name = "Purifying Power",
					tips = "Reduces the mana cost of your Cleanse, Purify and Consecration spells by %d%% and increases the critical strike chance of your Exorcism and Holy Wrath spells by %d%%.",
					tipValues = {{5, 10}, {10, 20}},
					column = 1,
					row = 6,
					icon = 135950,
					ranks = 2,
				},
			}, -- [14]
			{
				info = {
					name = "Holy Power",
					tips = "Increases the critical effect chance of your Holy spells by %d%%.",
					tipValues = {{1}, {2}, {3}, {4}, {5}},
					column = 3,
					row = 6,
					icon = 135938,
					ranks = 5,
				},
			}, -- [15]
			{
				info = {
					name = "Light's Grace",
					tips = "Gives your Holy Light spell a %d%% chance to reduce the cast time of your next Holy Light spell by 0.5 sec.  This effect lasts 15 sec.",
					tipValues = {{33}, {66}, {100}},
					column = 1,
					row = 7,
					icon = 135931,
					ranks = 3,
				},
			}, -- [16]
			{
				info = {
					tips = "Blasts the target with Holy energy, causing 277 to 299 Holy damage to an enemy, or 351 to 379 healing to an ally.",
					prereqs = {
						{
							column = 2,
							row = 5,
							source = 12,
						}, -- [1]
					},
					name = "Holy Shock",
					row = 7,
					column = 2,
					exceptional = 1,
					icon = 135972,
					ranks = 1,
				},
			}, -- [17]
			{
				info = {
					name = "Blessed Life",
					tips = "All attacks against you have a %d%% chance to cause half damage.",
					tipValues = {{4}, {7}, {10}},
					column = 3,
					row = 7,
					icon = 135876,
					ranks = 3,
				},
			}, -- [18]
			{
				info = {
					name = "Holy Guidance",
					tips = "Increases your spell damage and healing by %d%% of your total Intellect.",
					tipValues = {{7}, {14}, {21}, {28}, {35}},
					column = 2,
					row = 8,
					icon = 135921,
					ranks = 5,
				},
			}, -- [19]
			{
				info = {
					tips = "Reduces the mana cost of all spells by 50% for 15 sec.",
					name = "Divine Illumination",
					row = 9,
					column = 2,
					exceptional = 1,
					icon = 135895,
					ranks = 1,
				},
			}, -- [20]
		},
		info = {
			name = "Holy",
			background = "PaladinHoly",
		},
	}, -- [1]
	{
		numtalents = 22,
		talents = {
			{
				info = {
					name = "Improved Devotion Aura",
					tips = "Increases the armor bonus of your Devotion Aura by %d%%.",
					tipValues = {{8}, {16}, {24}, {32}, {40}},
					column = 2,
					row = 1,
					icon = 135893,
					ranks = 5,
				},
			}, -- [1]
			{
				info = {
					name = "Redoubt",
					tips = "Damaging melee and ranged attacks against you have a 10%% chance to increase your chance to block by %d%%.  Lasts 10 sec or 5 blocks.",
					tipValues = {{6}, {12}, {18}, {24}, {30}},
					column = 3,
					row = 1,
					icon = 132110,
					ranks = 5,
				},
			}, -- [2]
			{
				info = {
					name = "Precision",
					tips = "Increases your chance to hit with melee weapons and spells by %d%%.",
					tipValues = {{1}, {2}, {3}},
					column = 1,
					row = 2,
					icon = 132282,
					ranks = 3,
				},
			}, -- [3]
			{
				info = {
					name = "Guardian's Favor",
					tips = "Reduces the cooldown of your Blessing of Protection by %d sec and increases the duration of your Blessing of Freedom by %d sec.",
					tipValues = {{60, 2}, {120, 4}},
					column = 2,
					row = 2,
					icon = 135964,
					ranks = 2,
				},
			}, -- [4]
			{
				info = {
					name = "Toughness",
					tips = "Increases your armor value from items by %d%%.",
					tipValues = {{2}, {4}, {6}, {8}, {10}},
					column = 4,
					row = 2,
					icon = 135892,
					ranks = 5,
				},
			}, -- [5]
			{
				info = {
					tips = "Places a Blessing on the friendly target, increasing total stats by 10% for 10 min.  Players may only have one Blessing on them per Paladin at any one time.",
					name = "Blessing of Kings",
					row = 3,
					column = 1,
					exceptional = 1,
					icon = 135995,
					ranks = 1,
				},
			}, -- [6]
			{
				info = {
					name = "Improved Righteous Fury",
					tips = "While Righteous Fury is active, all damage taken is reduced by %d%% and increases the amount of threat generated by your Righteous Fury spell by %d%%.",
					tipValues = {{2, 16}, {4, 33}, {6, 50}},
					column = 2,
					row = 3,
					icon = 135962,
					ranks = 3,
				},
			}, -- [7]
			{
				info = {
					prereqs = {
						{
							column = 3,
							row = 1,
							source = 2,
						}, -- [1]
					},
					name = "Shield Specialization",
					tips = "Increases the amount of damage absorbed by your shield by %d%%.",
					tipValues = {{10}, {20}, {30}},
					column = 3,
					row = 3,
					icon = 134952,
					ranks = 3,
				},
			}, -- [8]
			{
				info = {
					name = "Anticipation",
					tips = "Increases your Defense skill by %d.",
					tipValues = {{4}, {8}, {12}, {16}, {20}},
					column = 4,
					row = 3,
					icon = 135994,
					ranks = 5,
				},
			}, -- [9]
			{
				info = {
					name = "Stoicism",
					tips = "Increases your resistance to Stun effects by an additional %d%% and reduces the chance your spells will be dispelled by an additional %d%%.",
					tipValues = {{5, 15}, {10, 30}},
					column = 1,
					row = 4,
					icon = 135978,
					ranks = 2,
				},
			}, -- [10]
			{
				info = {
					name = "Improved Hammer of Justice",
					tips = "Decreases the cooldown of your Hammer of Justice spell by %d sec.",
					tipValues = {{5}, {10}, {15}},
					column = 2,
					row = 4,
					icon = 135963,
					ranks = 3,
				},
			}, -- [11]
			{
				info = {
					name = "Improved Concentration Aura",
					tips = "Increases the effect of your Concentration Aura by an additional %d%% and reduces the duration of any Silence or Interrupt effect used against an affected group member by %d%%.  The duration reduction does not stack with any other effects.",
					tipValues = {{5, 10}, {10, 20}, {15, 30}},
					column = 3,
					row = 4,
					icon = 135933,
					ranks = 3,
				},
			}, -- [12]
			{
				info = {
					name = "Spell Warding",
					tips = "All spell damage taken is reduced by %d%%.",
					tipValues = {{2}, {4}},
					column = 1,
					row = 5,
					icon = 135925,
					ranks = 2,
				},
			}, -- [13]
			{
				info = {
					tips = "Places a Blessing on the friendly target, reducing damage dealt from all sources by up to 10 for 10 min.  In addition, when the target blocks a melee attack the attacker will take 14 Holy damage.  Players may only have one Blessing on them per Paladin at any one time.",
					name = "Blessing of Sanctuary",
					row = 5,
					column = 2,
					exceptional = 1,
					icon = 136051,
					ranks = 1,
				},
			}, -- [14]
			{
				info = {
					name = "Reckoning",
					tips = "Gives you a %d%% chance after being hit by any damaging attack that the next 4 weapon swings within 8 sec will generate an additional attack.",
					tipValues = {{2}, {4}, {6}, {8}, {10}},
					column = 3,
					row = 5,
					icon = 135882,
					ranks = 5,
				},
			}, -- [15]
			{
				info = {
					name = "Sacred Duty",
					tips = "Increases your total Stamina by %d%%, reduces the cooldown of your Divine Shield spell by %d sec and reduces the attack speed penalty by %d%%.",
					tipValues = {{3, 30, 50}, {6, 60, 100}},
					column = 1,
					row = 6,
					icon = 135896,
					ranks = 2,
				},
			}, -- [16]
			{
				info = {
					name = "One-Handed Weapon Specialization",
					tips = "Increases all damage you deal when a one-handed melee weapon is equipped by %d%%.",
					tipValues = {{1}, {2}, {3}, {4}, {5}},
					column = 3,
					row = 6,
					icon = 135321,
					ranks = 5,
				},
			}, -- [17]
			{
				info = {
					prereqs = {
						{
							column = 2,
							row = 7,
							source = 19,
						}, -- [1]
					},
					name = "Improved Holy Shield",
					tips = "Increases damage caused by your Holy Shield by %d%% and increases the number of charges of your Holy Shield by %d.",
					tipValues = {{10, 2}, {20, 4}},
					column = 1,
					row = 7,
					icon = 135880,
					ranks = 2,
				},
			}, -- [18]
			{
				info = {
					tips = "Increases chance to block by 30% for 10 sec and deals 59 Holy damage for each attack blocked while active.  Damage caused by Holy Shield causes 35% additional threat.  Each block expends a charge.  4 charges.",
					prereqs = {
						{
							column = 2,
							row = 5,
							source = 14,
						}, -- [1]
					},
					name = "Holy Shield",
					row = 7,
					column = 2,
					exceptional = 1,
					icon = 135880,
					ranks = 1,
				},
			}, -- [19]
			{
				info = {
					name = "Ardent Defender",
					tips = "When you have less than 35%% health, all damage taken is reduced by %d%%.",
					tipValues = {{6}, {12}, {18}, {24}, {30}},
					column = 3,
					row = 7,
					icon = 135870,
					ranks = 5,
				},
			}, -- [20]
			{
				info = {
					name = "Combat Expertise",
					tips = "Increases your expertise by %d and your total Stamina by %d%%.",
					tipValues = {{1, 2}, {2, 4}, {3, 6}, {4, 8}, {5, 10}},
					column = 3,
					row = 8,
					icon = 135986,
					ranks = 5,
				},
			}, -- [21]
			{
				info = {
					tips = "Hurls a holy shield at the enemy, dealing 270 to 330 Holy damage, Dazing them and then jumping to additional nearby enemies.  Affects 3 total targets.  Lasts 6 sec.",
					prereqs = {
						{
							column = 2,
							row = 7,
							source = 19,
						}, -- [1]
					},
					name = "Avenger's Shield",
					row = 9,
					column = 2,
					exceptional = 1,
					icon = 135874,
					ranks = 1,
				},
			}, -- [22]
		},
		info = {
			name = "Protection",
			background = "PaladinProtection",
		},
	}, -- [2]
	{
		numtalents = 22,
		talents = {
			{
				info = {
					name = "Improved Blessing of Might",
					tips = "Increases the attack power bonus of your Blessing of Might by %d%%.",
					tipValues = {{4}, {8}, {12}, {16}, {20}},
					column = 2,
					row = 1,
					icon = 135906,
					ranks = 5,
				},
			}, -- [1]
			{
				info = {
					name = "Benediction",
					tips = "Reduces the mana cost of your Judgement and Seal spells by %d%%.",
					tipValues = {{3}, {6}, {9}, {12}, {15}},
					column = 3,
					row = 1,
					icon = 135863,
					ranks = 5,
				},
			}, -- [2]
			{
				info = {
					name = "Improved Judgement",
					tips = "Decreases the cooldown of your Judgement spell by %d sec.",
					tipValues = {{1}, {2}},
					column = 1,
					row = 2,
					icon = 135959,
					ranks = 2,
				},
			}, -- [3]
			{
				info = {
					name = "Improved Seal of the Crusader",
					tips = "In addition to the normal effect, your Judgement of the Crusader spell will also increase the critical strike chance of all attacks made against that target by an additional %d%%.",
					tipValues = {{1}, {2}, {3}},
					column = 2,
					row = 2,
					icon = 135924,
					ranks = 3,
				},
			}, -- [4]
			{
				info = {
					name = "Deflection",
					tips = "Increases your Parry chance by %d%%.",
					tipValues = {{1}, {2}, {3}, {4}, {5}},
					column = 3,
					row = 2,
					icon = 132269,
					ranks = 5,
				},
			}, -- [5]
			{
				info = {
					name = "Vindication",
					tips = "Gives the Paladin's damaging melee attacks a chance to reduce the target's attributes by %d%% for 15 sec.",
					tipValues = {{5}, {10}, {15}},
					column = 1,
					row = 3,
					icon = 135985,
					ranks = 3,
				},
			}, -- [6]
			{
				info = {
					name = "Conviction",
					tips = "Increases your chance to get a critical strike with melee weapons by %d%%.",
					tipValues = {{1}, {2}, {3}, {4}, {5}},
					column = 2,
					row = 3,
					icon = 135957,
					ranks = 5,
				},
			}, -- [7]
			{
				info = {
					tips = "Gives the Paladin a chance to deal additional Holy damage equal to 70% of normal weapon damage.  Only one Seal can be active on the Paladin at any one time.  Lasts 30 sec.\r\n\r\nUnleashing this Seal's energy will judge an enemy, instantly causing 68 to 73 Holy damage, 137 to 146 if the target is stunned or incapacitated.",
					name = "Seal of Command",
					row = 3,
					column = 3,
					exceptional = 1,
					icon = 132347,
					ranks = 1,
				},
			}, -- [8]
			{
				info = {
					name = "Pursuit of Justice",
					tips = "Reduces the chance you'll be hit by spells by %d%% and increases movement and mounted movement speed by %d%%.  This does not stack with other movement speed increasing effects.",
					tipValues = {{1, 5}, {2, 10}, {3, 15}},
					column = 4,
					row = 3,
					icon = 135937,
					ranks = 3,
				},
			}, -- [9]
			{
				info = {
					name = "Eye for an Eye",
					tips = "All spell criticals against you cause %d%% of the damage taken to the caster as well.  The damage caused by Eye for an Eye will not exceed 50%% of the Paladin's total health.",
					tipValues = {{15}, {30}},
					column = 1,
					row = 4,
					icon = 135904,
					ranks = 2,
				},
			}, -- [10]
			{
				info = {
					name = "Improved Retribution Aura",
					tips = "Increases the damage done by your Retribution Aura by %d%%.",
					tipValues = {{25}, {50}},
					column = 3,
					row = 4,
					icon = 135873,
					ranks = 2,
				},
			}, -- [11]
			{
				info = {
					name = "Crusade",
					tips = "Increases all damage caused against Humanoids, Demons, Undead and Elementals by %d%%.",
					tipValues = {{1}, {2}, {3}},
					column = 4,
					row = 4,
					icon = 135889,
					ranks = 3,
				},
			}, -- [12]
			{
				info = {
					name = "Two-Handed Weapon Specialization",
					tips = "Increases the damage you deal with two-handed melee weapons by %d%%.",
					tipValues = {{2}, {4}, {6}},
					column = 1,
					row = 5,
					icon = 133041,
					ranks = 3,
				},
			}, -- [13]
			{
				info = {
					tips = "Increases Holy damage done by party members within 30 yards by 10%.  Players may only have one Aura on them per Paladin at any one time.",
					name = "Sanctity Aura",
					row = 5,
					column = 3,
					exceptional = 1,
					icon = 135934,
					ranks = 1,
				},
			}, -- [14]
			{
				info = {
					prereqs = {
						{
							column = 3,
							row = 5,
							source = 14,
						}, -- [1]
					},
					name = "Improved Sanctity Aura",
					tips = "The amount of damage caused by targets affected by Sanctity Aura is increased by %d%%.",
					tipValues = {{1}, {2}},
					column = 4,
					row = 5,
					icon = 135934,
					ranks = 2,
				},
			}, -- [15]
			{
				info = {
					prereqs = {
						{
							column = 2,
							row = 3,
							source = 7,
						}, -- [1]
					},
					name = "Vengeance",
					tips = "Gives you a %d%% bonus to Physical and Holy damage you deal for 30 sec after dealing a critical strike from a weapon swing, spell, or ability.  This effect stacks up to 3 times.",
					tipValues = {{1}, {2}, {3}, {4}, {5}},
					column = 2,
					row = 6,
					icon = 132275,
					ranks = 5,
				},
			}, -- [16]
			{
				info = {
					name = "Sanctified Judgement",
					tips = "Gives your Judgement spell a %d%% chance to return 80%% of the mana cost of the judged seal.",
					tipValues = {{33}, {66}, {100}},
					column = 3,
					row = 6,
					icon = 135959,
					ranks = 3,
				},
			}, -- [17]
			{
				info = {
					name = "Sanctified Seals",
					tips = "Increases your chance to critically hit with all spells and melee attacks by %d%% and reduces the chance your Seals will be dispelled by %d%%.",
					tipValues = {{1, 33}, {2, 66}, {3, 100}},
					column = 1,
					row = 7,
					icon = 135924,
					ranks = 3,
				},
			}, -- [18]
			{
				info = {
					tips = "Puts the enemy target in a state of meditation, incapacitating them for up to 6 sec.  Any damage caused will awaken the target.  Only works against Humanoids.",
					name = "Repentance",
					row = 7,
					column = 2,
					exceptional = 1,
					icon = 135942,
					ranks = 1,
				},
			}, -- [19]
			{
				info = {
					name = "Divine Purpose",
					tips = "Melee and ranged critical strikes against you cause %d%% less damage.",
					tipValues = {{4}, {7}, {10}},
					column = 3,
					row = 7,
					icon = 135897,
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
					name = "Fanaticism",
					tips = "Increases the critical strike chance of all Judgements capable of a critical hit by %d%% and reduces threat caused by all actions by %d%% except when under the effects of Righteous Fury.",
					tipValues = {{3, 6}, {6, 12}, {9, 18}, {12, 24}, {15, 30}},
					column = 2,
					row = 8,
					icon = 135905,
					ranks = 5,
				},
			}, -- [21]
			{
				info = {
					tips = "An instant strike that causes 110% weapon damage and refreshes all Judgements on the target.",
					name = "Crusader Strike",
					row = 9,
					column = 2,
					exceptional = 1,
					icon = 135891,
					ranks = 1,
				},
			}, -- [22]
		},
		info = {
			name = "Retribution",
			background = "PaladinCombat",
		},
	}, -- [3]
}
