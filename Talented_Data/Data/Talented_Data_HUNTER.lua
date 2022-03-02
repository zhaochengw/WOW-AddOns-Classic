if not Talented_Data then return end

Talented_Data.HUNTER = {
	{
		numtalents = 21,
		talents = {
			{
				info = {
					name = "Improved Aspect of the Hawk",
					tips = "While Aspect of the Hawk is active, all normal ranged attacks have a 10%% chance of increasing ranged attack speed by %d%% for 12 sec.",
					tipValues = {{3}, {6}, {9}, {12}, {15}},
					column = 2,
					row = 1,
					icon = 136076,
					ranks = 5,
				},
			}, -- [1]
			{
				info = {
					name = "Endurance Training",
					tips = "Increases the Health of your pet by %d%% and your total health by %d%%.",
					tipValues = {{2, 1}, {4, 2}, {6, 3}, {8, 4}, {10, 5}},
					column = 3,
					row = 1,
					icon = 136080,
					ranks = 5,
				},
			}, -- [2]
			{
				info = {
					name = "Focused Fire",
					tips = "All damage caused by you is increased by %d%% while your pet is active and the critical strike chance of your Kill Command ability is increased by %d%%.",
					tipValues = {{1, 10}, {2, 20}},
					column = 1,
					row = 2,
					icon = 132210,
					ranks = 2,
				},
			}, -- [3]
			{
				info = {
					name = "Improved Aspect of the Monkey",
					tips = "Increases the Dodge bonus of your Aspect of the Monkey by %d%%.",
					tipValues = {{2}, {4}, {6}},
					column = 2,
					row = 2,
					icon = 132159,
					ranks = 3,
				},
			}, -- [4]
			{
				info = {
					name = "Thick Hide",
					tips = "Increases the armor rating of your pets by %d%% and your armor contribution from items by %d%%.",
					tipValues = {{7, 4}, {14, 7}, {20, 10}},
					column = 3,
					row = 2,
					icon = 134355,
					ranks = 3,
				},
			}, -- [5]
			{
				info = {
					name = "Improved Revive Pet",
					tips = "Revive Pet's casting time is reduced by %d sec, mana cost is reduced by %d%%, and increases the health your pet returns with by an additional %d%%.",
					tipValues = {{3, 20, 15}, {6, 40, 30}},
					column = 4,
					row = 2,
					icon = 132163,
					ranks = 2,
				},
			}, -- [6]
			{
				info = {
					name = "Pathfinding",
					tips = "Increases the speed bonus of your Aspect of the Cheetah and Aspect of the Pack by %d%%.",
					tipValues = {{4}, {8}},
					column = 1,
					row = 3,
					icon = 132242,
					ranks = 2,
				},
			}, -- [7]
			{
				info = {
					name = "Bestial Swiftness",
					tips = "Increases the outdoor movement speed of your pets by 30%.",
					column = 2,
					row = 3,
					icon = 132120,
					ranks = 1,
				},
			}, -- [8]
			{
				info = {
					name = "Unleashed Fury",
					tips = "Increases the damage done by your pets by %d%%.",
					tipValues = {{4}, {8}, {12}, {16}, {20}},
					column = 3,
					row = 3,
					icon = 132091,
					ranks = 5,
				},
			}, -- [9]
			{
				info = {
					name = "Improved Mend Pet",
					tips = "Reduces the mana cost of your Mend Pet spell by %d%% and gives the Mend Pet spell a %d%% chance of cleansing 1 Curse, Disease, Magic or Poison effect from the pet each tick.",
					tipValues = {{10, 25}, {20, 50}},
					column = 2,
					row = 4,
					icon = 132179,
					ranks = 2,
				},
			}, -- [10]
			{
				info = {
					name = "Ferocity",
					tips = "Increases the critical strike chance of your pet by %d%%.",
					tipValues = {{2}, {4}, {6}, {8}, {10}},
					column = 3,
					row = 4,
					icon = 134297,
					ranks = 5,
				},
			}, -- [11]
			{
				info = {
					name = "Spirit Bond",
					tips = "While your pet is active, you and your pet will regenerate %d%% of total health every 10 sec.",
					tipValues = {{1}, {2}},
					column = 1,
					row = 5,
					icon = 132121,
					ranks = 2,
				},
			}, -- [12]
			{
				info = {
					tips = "Command your pet to intimidate the target on the next successful melee attack, causing a high amount of threat and stunning the target for 3 sec.",
					name = "Intimidation",
					row = 5,
					column = 2,
					exceptional = 1,
					icon = 132111,
					ranks = 1,
				},
			}, -- [13]
			{
				info = {
					name = "Bestial Discipline",
					tips = "Increases the Focus regeneration of your pets by %d%%.",
					tipValues = {{50}, {100}},
					column = 4,
					row = 5,
					icon = 136006,
					ranks = 2,
				},
			}, -- [14]
			{
				info = {
					name = "Animal Handler",
					tips = "Increases your speed while mounted by %d%% and your pet's chance to hit by %d%%.  The mounted movement speed increase does not stack with other effects.",
					tipValues = {{4, 2}, {8, 4}},
					column = 1,
					row = 6,
					icon = 132158,
					ranks = 2,
				},
			}, -- [15]
			{
				info = {
					prereqs = {
						{
							column = 3,
							row = 4,
							source = 11,
						}, -- [1]
					},
					name = "Frenzy",
					tips = "Gives your pet a %d%% chance to gain a 30%% attack speed increase for 8 sec after dealing a critical strike.",
					tipValues = {{20}, {40}, {60}, {80}, {100}},
					column = 3,
					row = 6,
					icon = 134296,
					ranks = 5,
				},
			}, -- [16]
			{
				info = {
					name = "Ferocious Inspiration",
					tips = "When your pet scores a critical hit, all party members have all damage increased by %d%% for 10 sec.",
					tipValues = {{1}, {2}, {3}},
					column = 1,
					row = 7,
					icon = 132173,
					ranks = 3,
				},
			}, -- [17]
			{
				info = {
					tips = "Send your pet into a rage causing 50% additional damage for 18 sec.  While enraged, the beast does not feel pity or remorse or fear and it cannot be stopped unless killed.",
					prereqs = {
						{
							column = 2,
							row = 5,
							source = 13,
						}, -- [1]
					},
					name = "Bestial Wrath",
					row = 7,
					column = 2,
					exceptional = 1,
					icon = 132127,
					ranks = 1,
				},
			}, -- [18]
			{
				info = {
					name = "Catlike Reflexes",
					tips = "Increases your chance to dodge by %d%% and your pet's chance to dodge by an additional %d%%.",
					tipValues = {{1, 3}, {2, 6}, {3, 9}},
					column = 3,
					row = 7,
					icon = 132167,
					ranks = 3,
				},
			}, -- [19]
			{
				info = {
					name = "Serpent's Swiftness",
					tips = "Increases ranged combat attack speed by %d%% and your pet's melee attack speed by %d%%.",
					tipValues = {{4, 4}, {8, 8}, {12, 12}, {16, 16}, {20, 20}},
					column = 3,
					row = 8,
					icon = 132209,
					ranks = 5,
				},
			}, -- [20]
			{
				info = {
					prereqs = {
						{
							column = 2,
							row = 7,
							source = 18,
						}, -- [1]
					},
					name = "The Beast Within",
					tips = "When your pet is under the effects of Bestial Wrath, you also go into a rage causing 10% additional damage and reducing mana costs of all spells by 20% for 18 sec.  While enraged, you do not feel pity or remorse or fear and you cannot be stopped unless killed.",
					column = 2,
					row = 9,
					icon = 132166,
					ranks = 1,
				},
			}, -- [21]
		},
		info = {
			name = "Beast Mastery",
			background = "HunterBeastMastery",
		},
	}, -- [1]
	{
		numtalents = 20,
		talents = {
			{
				info = {
					name = "Improved Concussive Shot",
					tips = "Gives your Concussive Shot a %d%% chance to stun the target for 3 sec.",
					tipValues = {{4}, {8}, {12}, {16}, {20}},
					column = 2,
					row = 1,
					icon = 135860,
					ranks = 5,
				},
			}, -- [1]
			{
				info = {
					name = "Lethal Shots",
					tips = "Increases your critical strike chance with ranged weapons by %d%%.",
					tipValues = {{1}, {2}, {3}, {4}, {5}},
					column = 3,
					row = 1,
					icon = 132312,
					ranks = 5,
				},
			}, -- [2]
			{
				info = {
					name = "Improved Hunter's Mark",
					tips = "Causes %d%% of your Hunter's Mark ability's base attack power to apply to melee attack power as well.",
					tipValues = {{20}, {40}, {60}, {80}, {100}},
					column = 2,
					row = 2,
					icon = 132212,
					ranks = 5,
				},
			}, -- [3]
			{
				info = {
					name = "Efficiency",
					tips = "Reduces the Mana cost of your Shots and Stings by %d%%.",
					tipValues = {{2}, {4}, {6}, {8}, {10}},
					column = 3,
					row = 2,
					icon = 135865,
					ranks = 5,
				},
			}, -- [4]
			{
				info = {
					name = "Go for the Throat",
					tips = "Your ranged critical hits cause your pet to generate %d Focus.",
					tipValues = {{25}, {50}},
					column = 1,
					row = 3,
					icon = 132174,
					ranks = 2,
				},
			}, -- [5]
			{
				info = {
					name = "Improved Arcane Shot",
					tips = "Reduces the cooldown of your Arcane Shot by %.1f sec.",
					tipValues = {{0.2}, {0.4}, {0.6}, {0.8}, {1.0}},
					column = 2,
					row = 3,
					icon = 132218,
					ranks = 5,
				},
			}, -- [6]
			{
				info = {
					tips = "An aimed shot that increases ranged damage by 70 and reduces healing done to that target by 50%.  Lasts 10 sec.",
					name = "Aimed Shot",
					row = 3,
					column = 3,
					exceptional = 1,
					icon = 135130,
					ranks = 1,
				},
			}, -- [7]
			{
				info = {
					name = "Rapid Killing",
					tips = "Reduces the cooldown of your Rapid Fire ability by %d min.  In addition, after killing an opponent that yields experience or honor, your next Aimed Shot, Arcane Shot or Auto Shot causes %d%% additional damage.  Lasts 20 sec.",
					tipValues = {{1, 10}, {2, 20}},
					column = 4,
					row = 3,
					icon = 132205,
					ranks = 2,
				},
			}, -- [8]
			{
				info = {
					name = "Improved Stings",
					tips = "Increases the damage done by your Serpent Sting and Wyvern Sting by %d%% and the mana drained by your Viper Sting by %d%%.  In addition, reduces the chance your Stings will be dispelled by %d%%.",
					tipValues = {{6, 6, 6}, {12, 12, 12}, {18, 18, 18}, {24, 24, 24}, {30, 30, 30}},
					column = 2,
					row = 4,
					icon = 132204,
					ranks = 5,
				},
			}, -- [9]
			{
				info = {
					prereqs = {
						{
							column = 3,
							row = 3,
							source = 7,
						}, -- [1]
					},
					name = "Mortal Shots",
					tips = "Increases your ranged weapon critical strike damage bonus by %d%%.",
					tipValues = {{6}, {12}, {18}, {24}, {30}},
					column = 3,
					row = 4,
					icon = 132271,
					ranks = 5,
				},
			}, -- [10]
			{
				info = {
					name = "Concussive Barrage",
					tips = "Your successful Auto Shot attacks have a %d%% chance to Daze the target for 4 sec.",
					tipValues = {{2}, {4}, {6}},
					column = 1,
					row = 5,
					icon = 135753,
					ranks = 3,
				},
			}, -- [11]
			{
				info = {
					tips = "A short-range shot that deals 50% weapon damage and disorients the target for 4 sec.  Any damage caused will remove the effect.  Turns off your attack when used.",
					name = "Scatter Shot",
					row = 5,
					column = 2,
					exceptional = 1,
					icon = 132153,
					ranks = 1,
				},
			}, -- [12]
			{
				info = {
					name = "Barrage",
					tips = "Increases the damage done by your Multi-Shot and Volley spells by %d%%.",
					tipValues = {{4}, {8}, {12}},
					column = 3,
					row = 5,
					icon = 132330,
					ranks = 3,
				},
			}, -- [13]
			{
				info = {
					name = "Combat Experience",
					tips = "Increases your total Agility by %d%% and your total Intellect by %d%%.",
					tipValues = {{1, 3}, {2, 6}},
					column = 1,
					row = 6,
					icon = 132168,
					ranks = 2,
				},
			}, -- [14]
			{
				info = {
					name = "Ranged Weapon Specialization",
					tips = "Increases the damage you deal with ranged weapons by %d%%.",
					tipValues = {{1}, {2}, {3}, {4}, {5}},
					column = 4,
					row = 6,
					icon = 135615,
					ranks = 5,
				},
			}, -- [15]
			{
				info = {
					name = "Careful Aim",
					tips = "Increases your ranged attack power by an amount equal to %d%% of your total Intellect.",
					tipValues = {{15}, {30}, {45}},
					column = 1,
					row = 7,
					icon = 132217,
					ranks = 3,
				},
			}, -- [16]
			{
				info = {
					tips = "Increases the attack power of party members within 45 yards by 50.  Lasts until cancelled.",
					prereqs = {
						{
							column = 2,
							row = 5,
							source = 12,
						}, -- [1]
					},
					name = "Trueshot Aura",
					row = 7,
					column = 2,
					exceptional = 1,
					icon = 132329,
					ranks = 1,
				},
			}, -- [17]
			{
				info = {
					prereqs = {
						{
							column = 3,
							row = 5,
							source = 13,
						}, -- [1]
					},
					name = "Improved Barrage",
					tips = "Increases the critical strike chance of your Multi-Shot ability by %d%% and gives you a %d%% chance to avoid interruption caused by damage while channeling Volley.",
					tipValues = {{4, 33}, {8, 66}, {12, 100}},
					column = 3,
					row = 7,
					icon = 132330,
					ranks = 3,
				},
			}, -- [18]
			{
				info = {
					name = "Master Marksman",
					tips = "Increases your ranged attack power by %d%%.",
					tipValues = {{2}, {4}, {6}, {8}, {10}},
					column = 2,
					row = 8,
					icon = 132177,
					ranks = 5,
				},
			}, -- [19]
			{
				info = {
					tips = "A shot that deals 50% weapon damage and Silences the target for 3 sec.",
					prereqs = {
						{
							column = 2,
							row = 8,
							source = 19,
						}, -- [1]
					},
					name = "Silencing Shot",
					row = 9,
					column = 2,
					exceptional = 1,
					icon = 132323,
					ranks = 1,
				},
			}, -- [20]
		},
		info = {
			name = "Marksmanship",
			background = "HunterMarksmanship",
		},
	}, -- [2]
	{
		numtalents = 23,
		talents = {
			{
				info = {
					name = "Monster Slaying",
					tips = "Increases all damage caused against Beasts, Giants and Dragonkin targets by %d%% and increases critical damage caused against Beasts, Giants and Dragonkin targets by an additional %d%%.",
					tipValues = {{1, 1}, {2, 2}, {3, 3}},
					column = 1,
					row = 1,
					icon = 134154,
					ranks = 3,
				},
			}, -- [1]
			{
				info = {
					name = "Humanoid Slaying",
					tips = "Increases all damage caused against Humanoid targets by %d%% and increases critical damage caused against Humanoid targets by an additional %d%%.",
					tipValues = {{1, 1}, {2, 2}, {3, 3}},
					column = 2,
					row = 1,
					icon = 135942,
					ranks = 3,
				},
			}, -- [2]
			{
				info = {
					name = "Hawk Eye",
					tips = "Increases the range of your ranged weapons by %d yards.",
					tipValues = {{2}, {4}, {6}},
					column = 3,
					row = 1,
					icon = 132327,
					ranks = 3,
				},
			}, -- [3]
			{
				info = {
					name = "Savage Strikes",
					tips = "Increases the critical strike chance of Raptor Strike and Mongoose Bite by %d%%.",
					tipValues = {{10}, {20}},
					column = 4,
					row = 1,
					icon = 132277,
					ranks = 2,
				},
			}, -- [4]
			{
				info = {
					name = "Entrapment",
					tips = "Gives your Immolation Trap, Frost Trap, Explosive Trap, and Snake Trap a %d%% chance to entrap the target, preventing them from moving for 4 sec.",
					tipValues = {{8}, {16}, {25}},
					column = 1,
					row = 2,
					icon = 136100,
					ranks = 3,
				},
			}, -- [5]
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
			}, -- [6]
			{
				info = {
					name = "Improved Wing Clip",
					tips = "Gives your Wing Clip ability a %d%% chance to immobilize the target for 5 sec.",
					tipValues = {{7}, {14}, {20}},
					column = 3,
					row = 2,
					icon = 132309,
					ranks = 3,
				},
			}, -- [7]
			{
				info = {
					name = "Clever Traps",
					tips = "Increases the duration of Freezing and Frost Trap effects by %d%%, the damage of Immolation and Explosive Trap effects by %d%%, and the number of snakes summoned from Snake Traps by %d%%.",
					tipValues = {{15, 15, 15}, {30, 30, 30}},
					column = 1,
					row = 3,
					icon = 136106,
					ranks = 2,
				},
			}, -- [8]
			{
				info = {
					name = "Survivalist",
					tips = "Increases total health by %d%%.",
					tipValues = {{2}, {4}, {6}, {8}, {10}},
					column = 2,
					row = 3,
					icon = 136223,
					ranks = 5,
				},
			}, -- [9]
			{
				info = {
					tips = "When activated, increases your Dodge and Parry chance by 25% for 10 sec.",
					name = "Deterrence",
					row = 3,
					column = 3,
					exceptional = 1,
					icon = 132369,
					ranks = 1,
				},
			}, -- [10]
			{
				info = {
					name = "Trap Mastery",
					tips = "Decreases the chance enemies will resist trap effects by %d%%.",
					tipValues = {{5}, {10}},
					column = 1,
					row = 4,
					icon = 132149,
					ranks = 2,
				},
			}, -- [11]
			{
				info = {
					name = "Surefooted",
					tips = "Increases hit chance by %d%% and increases the chance movement impairing effects will be resisted by an additional %d%%.",
					tipValues = {{1, 5}, {2, 10}, {3, 15}},
					column = 2,
					row = 4,
					icon = 132219,
					ranks = 3,
				},
			}, -- [12]
			{
				info = {
					name = "Improved Feign Death",
					tips = "Reduces the chance your Feign Death ability will be resisted by %d%%.",
					tipValues = {{2}, {4}},
					column = 4,
					row = 4,
					icon = 132293,
					ranks = 2,
				},
			}, -- [13]
			{
				info = {
					name = "Survival Instincts",
					tips = "Reduces all damage taken by %d%% and increases attack power by %d%%.",
					tipValues = {{2, 2}, {4, 4}},
					column = 1,
					row = 5,
					icon = 132214,
					ranks = 2,
				},
			}, -- [14]
			{
				info = {
					name = "Killer Instinct",
					tips = "Increases your critical strike chance with all attacks by %d%%.",
					tipValues = {{1}, {2}, {3}},
					column = 2,
					row = 5,
					icon = 135881,
					ranks = 3,
				},
			}, -- [15]
			{
				info = {
					tips = "A strike that becomes active after parrying an opponent's attack.  This attack deals 40 damage and immobilizes the target for 5 sec.  Counterattack cannot be blocked, dodged, or parried.",
					prereqs = {
						{
							column = 3,
							row = 3,
							source = 10,
						}, -- [1]
					},
					name = "Counterattack",
					row = 5,
					column = 3,
					exceptional = 1,
					icon = 132336,
					ranks = 1,
				},
			}, -- [16]
			{
				info = {
					name = "Resourcefulness",
					tips = "Reduces the mana cost of all traps and melee abilities by %d%% and reduces the cooldown of all traps by %d sec.",
					tipValues = {{20, 2}, {40, 4}, {60, 6}},
					column = 1,
					row = 6,
					icon = 132207,
					ranks = 3,
				},
			}, -- [17]
			{
				info = {
					name = "Lightning Reflexes",
					tips = "Increases your Agility by %d%%.",
					tipValues = {{3}, {6}, {9}, {12}, {15}},
					column = 3,
					row = 6,
					icon = 136047,
					ranks = 5,
				},
			}, -- [18]
			{
				info = {
					name = "Thrill of the Hunt",
					tips = "Gives you a %d%% chance to regain 40%% of the mana cost of any shot when it critically hits.",
					tipValues = {{33}, {66}, {100}},
					column = 1,
					row = 7,
					icon = 132216,
					ranks = 3,
				},
			}, -- [19]
			{
				info = {
					tips = "A stinging shot that puts the target to sleep for 12 sec.  Any damage will cancel the effect.  When the target wakes up, the Sting causes 300 Nature damage over 12 sec.  Only one Sting per Hunter can be active on the target at a time.",
					prereqs = {
						{
							column = 2,
							row = 5,
							source = 15,
						}, -- [1]
					},
					name = "Wyvern Sting",
					row = 7,
					column = 2,
					exceptional = 1,
					icon = 135125,
					ranks = 1,
				},
			}, -- [20]
			{
				info = {
					prereqs = {
						{
							column = 3,
							row = 6,
							source = 18,
						}, -- [1]
					},
					name = "Expose Weakness",
					tips = "Your ranged criticals have a %d%% chance to apply an Expose Weakness effect to the target. Expose Weakness increases the attack power of all attackers against that target by 25%% of your Agility for 7 sec.",
					tipValues = {{33}, {66}, {100}},
					column = 3,
					row = 7,
					icon = 132295,
					ranks = 3,
				},
			}, -- [21]
			{
				info = {
					name = "Master Tactician",
					tips = "Your successful ranged attacks have a 6%% chance to increase your critical strike chance with all attacks by %d%% for 8 sec.",
					tipValues = {{2}, {4}, {6}, {8}, {10}},
					column = 2,
					row = 8,
					icon = 132178,
					ranks = 5,
				},
			}, -- [22]
			{
				info = {
					tips = "When activated, this ability immediately finishes the cooldown on your other Hunter abilities.",
					prereqs = {
						{
							column = 2,
							row = 8,
							source = 22,
						}, -- [1]
					},
					name = "Readiness",
					row = 9,
					column = 2,
					exceptional = 1,
					icon = 132206,
					ranks = 1,
				},
			}, -- [23]
		},
		info = {
			name = "Survival",
			background = "HunterSurvival",
		},
	}, -- [3]
}
