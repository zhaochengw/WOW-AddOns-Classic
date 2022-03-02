if not Talented_Data then return end

Talented_Data.DRUID = {
	{
		numtalents = 21,
		talents = {
			{
				info = {
					name = "Starlight Wrath",
					tips = "Reduces the cast time of your Wrath and Starfire spells by %.1f sec.",
					tipValues = {{0.1}, {0.2}, {0.3}, {0.4}, {0.5}},
					column = 1,
					row = 1,
					icon = 136006,
					ranks = 5,
				},
			}, -- [1]
			{
				info = {
					tips = "While active, any time an enemy strikes the caster they have a 35% chance to become afflicted by Entangling Roots (Rank 1).  Only useable outdoors.  1 charge.  Lasts 45 sec.",
					name = "Nature's Grasp",
					row = 1,
					column = 2,
					exceptional = 1,
					icon = 136063,
					ranks = 1,
				},
			}, -- [2]
			{
				info = {
					prereqs = {
						{
							column = 2,
							row = 1,
							source = 2,
						}, -- [1]
					},
					name = "Improved Nature's Grasp",
					tips = "Increases the chance for your Nature's Grasp to entangle an enemy by %d%%.",
					tipValues = {{15}, {30}, {45}, {65}},
					column = 3,
					row = 1,
					icon = 136063,
					ranks = 4,
				},
			}, -- [3]
			{
				info = {
					name = "Control of Nature",
					tips = "Gives you a %d%% chance to avoid interruption caused by damage while casting Entangling Roots and Cyclone.",
					tipValues = {{40}, {70}, {100}},
					column = 1,
					row = 2,
					icon = 136100,
					ranks = 3,
				},
			}, -- [4]
			{
				info = {
					name = "Focused Starlight",
					tips = "Increases the critical strike chance of your Wrath and Starfire spells by %d%%.",
					tipValues = {{2}, {4}},
					column = 2,
					row = 2,
					icon = 135138,
					ranks = 2,
				},
			}, -- [5]
			{
				info = {
					name = "Improved Moonfire",
					tips = "Increases the damage and critical strike chance of your Moonfire spell by %d%%.",
					tipValues = {{5}, {10}},
					column = 3,
					row = 2,
					icon = 136096,
					ranks = 2,
				},
			}, -- [6]
			{
				info = {
					name = "Brambles",
					tips = "Increases damage caused by your Thorns and Entangling Roots spells by %d%%.",
					tipValues = {{25}, {50}, {75}},
					column = 1,
					row = 3,
					icon = 136104,
					ranks = 3,
				},
			}, -- [7]
			{
				info = {
					tips = "The enemy target is swarmed by insects, decreasing their chance to hit by 2% and causing 108 Nature damage over 12 sec.",
					name = "Insect Swarm",
					row = 3,
					column = 3,
					exceptional = 1,
					icon = 136045,
					ranks = 1,
				},
			}, -- [8]
			{
				info = {
					name = "Nature's Reach",
					tips = "Increases the range of your Balance spells and Faerie Fire (Feral) ability by %d%%.",
					tipValues = {{10}, {20}},
					column = 4,
					row = 3,
					icon = 136065,
					ranks = 2,
				},
			}, -- [9]
			{
				info = {
					prereqs = {
						{
							column = 2,
							row = 2,
							source = 5,
						}, -- [1]
					},
					name = "Vengeance",
					tips = "Increases the critical strike damage bonus of your Starfire, Moonfire, and Wrath spells by %d%%.",
					tipValues = {{20}, {40}, {60}, {80}, {100}},
					column = 2,
					row = 4,
					icon = 136075,
					ranks = 5,
				},
			}, -- [10]
			{
				info = {
					name = "Celestial Focus",
					tips = "Gives your Starfire spell a %d%% chance to stun the target for 3 sec and increases the chance you'll resist spell interruption when casting your Wrath spell by %d%%.",
					tipValues = {{5, 25}, {10, 50}, {15, 70}}, 
					column = 3,
					row = 4,
					icon = 135753,
					ranks = 3,
				},
			}, -- [11]
			{
				info = {
					name = "Lunar Guidance",
					tips = "Increases your spell damage and healing by %d%% of your total Intellect.",
					tipValues = {{8}, {16}, {25}},
					column = 1,
					row = 5,
					icon = 132132,
					ranks = 3,
				},
			}, -- [12]
			{
				info = {
					name = "Nature's Grace",
					tips = "All spell criticals grace you with a blessing of nature, reducing the casting time of your next spell by 0.5 sec.",
					column = 2,
					row = 5,
					icon = 136062,
					ranks = 1,
				},
			}, -- [13]
			{
				info = {
					name = "Moonglow",
					tips = "Reduces the Mana cost of your Moonfire, Starfire, Wrath, Healing Touch, Regrowth and Rejuvenation spells by %d%%.",
					tipValues = {{3}, {6}, {9}},
					column = 3,
					row = 5,
					icon = 136087,
					ranks = 3,
				},
			}, -- [14]
			{
				info = {
					prereqs = {
						{
							column = 2,
							row = 5,
							source = 13,
						}, -- [1]
					},
					name = "Moonfury",
					tips = "Increases the damage done by your Starfire, Moonfire and Wrath spells by %d%%.",
					tipValues = {{2}, {4}, {6}, {8}, {10}},
					column = 2,
					row = 6,
					icon = 136057,
					ranks = 5,
				},
			}, -- [15]
			{
				info = {
					name = "Balance of Power",
					tips = "Increases your chance to hit with all spells and reduces the chance you'll be hit by spells by %d%%.",
					tipValues = {{2, 2}, {4, 4}},
					column = 3,
					row = 6,
					icon = 132113,
					ranks = 2,
				},
			}, -- [16]
			{
				info = {
					name = "Dreamstate",
					tips = "Regenerate mana equal to %d%% of your Intellect every 5 sec, even while casting.",
					tipValues = {{4}, {7}, {10}},
					column = 1,
					row = 7,
					icon = 132123,
					ranks = 3,
				},
			}, -- [17]
			{
				info = {
					tips = "Shapeshift into Moonkin Form.  While in this form the armor contribution from items is increased by 400%, attack power is increased by 150% of your level and all party members within 30 yards have their spell critical chance increased by 5%.  Melee attacks in this form have a chance on hit to regenerate mana based on attack power.  The Moonkin can only cast Balance and Remove Curse spells while shapeshifted.\r\n\r\nThe act of shapeshifting frees the caster of Polymorph and Movement Impairing effects.",
					name = "Moonkin Form",
					row = 7,
					column = 2,
					exceptional = 1,
					icon = 136036,
					ranks = 1,
				},
			}, -- [18]
			{
				info = {
					name = "Improved Faerie Fire",
					tips = "Your Faerie Fire spell also increases the chance the target will be hit by melee and ranged attacks by %d%%.",
					tipValues = {{1}, {2}, {3}},
					column = 3,
					row = 7,
					icon = 136033,
					ranks = 3,
				},
			}, -- [19]
			{
				info = {
					name = "Wrath of Cenarius",
					tips = "Your Starfire spell gains an additional %d%% and your Wrath gains an additional %d%% of your bonus damage effects.",
					tipValues = {{4, 2}, {8, 4}, {12, 6}, {16, 8}, {20, 10}}, 
					column = 2,
					row = 8,
					icon = 132146,
					ranks = 5,
				},
			}, -- [20]
			{
				info = {
					tips = "Summons 3 treants to attack enemy targets for 30 sec.",
					name = "Force of Nature",
					row = 9,
					column = 2,
					exceptional = 1,
					icon = 132129,
					ranks = 1,
				},
			}, -- [21]
		},
		info = {
			name = "Balance",
			background = "DruidBalance",
		},
	}, -- [1]
	{
		numtalents = 21,
		talents = {
			{
				info = {
					name = "Ferocity",
					tips = "Reduces the cost of your Maul, Swipe, Claw, Rake and Mangle abilities by %d Rage or Energy.",
					tipValues = {{1}, {2}, {3}, {4}, {5}},
					column = 2,
					row = 1,
					icon = 132190,
					ranks = 5,
				},
			}, -- [1]
			{
				info = {
					name = "Feral Aggression",
					tips = "Increases the attack power reduction of your Demoralizing Roar by %d%% and the damage caused by your Ferocious Bite by %d%%.",
					tipValues = {{8, 3}, {16, 6}, {24, 9}, {32, 12}, {40, 15}}, 
					column = 3,
					row = 1,
					icon = 132121,
					ranks = 5,
				},
			}, -- [2]
			{
				info = {
					name = "Feral Instinct",
					tips = "Increases threat caused in Bear and Dire Bear Form by %d%% and reduces the chance enemies have to detect you while Prowling.",
					tipValues = {{5}, {10}, {15}},
					column = 1,
					row = 2,
					icon = 132089,
					ranks = 3,
				},
			}, -- [3]
			{
				info = {
					name = "Brutal Impact",
					tips = "Increases the stun duration of your Bash and Pounce abilities by %.1f sec.",
					tipValues = {{0.5}, {1.0}},
					column = 2,
					row = 2,
					icon = 132114,
					ranks = 2,
				},
			}, -- [4]
			{
				info = {
					name = "Thick Hide",
					tips = "Increases your Armor contribution from items by %d%%.",
					tipValues = {{4}, {7}, {10}},
					column = 3,
					row = 2,
					icon = 134355,
					ranks = 3,
				},
			}, -- [5]
			{
				info = {
					name = "Feral Swiftness",
					tips = "Increases your movement speed by %d%% while outdoors in Cat Form and increases your chance to dodge while in Cat Form, Bear Form and Dire Bear Form by %d%%.",
					tipValues = {{15, 2}, {30, 4}},
					column = 1,
					row = 3,
					icon = 136095,
					ranks = 2,
				},
			}, -- [6]
			{
				info = {
					tips = "Causes you to charge an enemy, immobilizing and interrupting any spell being cast for 4 sec.",
					name = "Feral Charge",
					row = 3,
					column = 2,
					exceptional = 1,
					icon = 132183,
					ranks = 1,
				},
			}, -- [7]
			{
				info = {
					name = "Sharpened Claws",
					tips = "Increases your critical strike chance while in Bear, Dire Bear or Cat Form by %d%%.",
					tipValues = {{2}, {4}, {6}},
					column = 3,
					row = 3,
					icon = 134297,
					ranks = 3,
				},
			}, -- [8]
			{
				info = {
					name = "Shredding Attacks",
					tips = "Reduces the energy cost of your Shred ability by %d and the rage cost of your Lacerate ability by %d.",
					tipValues = {{9, 1}, {18, 2}},
					column = 1,
					row = 4,
					icon = 136231,
					ranks = 2,
				},
			}, -- [9]
			{
				info = {
					name = "Predatory Strikes",
					tips = "Increases your melee attack power in Cat, Bear, Dire Bear and Moonkin Forms by %d%% of your level.",
					tipValues = {{50}, {100}, {150}},
					column = 2,
					row = 4,
					icon = 132185,
					ranks = 3,
				},
			}, -- [10]
			{
				info = {
					prereqs = {
						{
							column = 3,
							row = 3,
							source = 8,
						}, -- [1]
					},
					name = "Primal Fury",
					tips = "Gives you a %d%% chance to gain an additional 5 Rage anytime you get a critical strike while in Bear and Dire Bear Form and your critical strikes from Cat Form abilities that add combo points  have a %d%% chance to add an additional combo point.",
					tipValues = {{50, 50}, {100, 100}},
					column = 3,
					row = 4,
					icon = 132278,
					ranks = 2,
				},
			}, -- [11]
			{
				info = {
					name = "Savage Fury",
					tips = "Increases the damage caused by your Claw, Rake, and Mangle (Cat) abilities by %d%%.",
					tipValues = {{10}, {20}},
					column = 1,
					row = 5,
					icon = 132141,
					ranks = 2,
				},
			}, -- [12]
			{
				info = {
					tips = "Decrease the armor of the target by 175 for 40 sec.  While affected, the target cannot stealth or turn invisible.",
					name = "Faerie Fire (Feral)",
					row = 5,
					column = 3,
					exceptional = 1,
					icon = 136033,
					ranks = 1,
				},
			}, -- [13]
			{
				info = {
					name = "Nurturing Instinct",
					tips = "Increases your healing spells by up to %d%% of your Agility, and increases healing done to you by %d%% while in Cat form.",
					tipValues = {{50, 10}, {100, 20}},
					column = 4,
					row = 5,
					icon = 132130,
					ranks = 2,
				},
			}, -- [14]
			{
				info = {
					prereqs = {
						{
							column = 2,
							row = 4,
							source = 10,
						}, -- [1]
					},
					name = "Heart of the Wild",
					tips = "Increases your Intellect by %d%%.  In addition, while in Bear or Dire Bear Form your Stamina is increased by %d%% and while in Cat Form your attack power is increased by %d%%.",
					tipValues = {{4, 4, 2}, {8, 8, 4}, {12, 12, 6}, {16, 16, 8}, {20, 20, 10}},
					column = 2,
					row = 6,
					icon = 135879,
					ranks = 5,
				},
			}, -- [15]
			{
				info = {
					name = "Survival of the Fittest",
					tips = "Increases all attributes by %d%% and reduces the chance you'll be critically hit by melee attacks by %d%%.",
					tipValues = {{1, 1}, {2, 2}, {3, 3}},
					column = 3,
					row = 6,
					icon = 132126,
					ranks = 3,
				},
			}, -- [16]
			{
				info = {
					name = "Primal Tenacity",
					tips = "Increases your chance to resist Stun and Fear mechanics by %d%%.",
					tipValues = {{5}, {10}, {15}},
					column = 1,
					row = 7,
					icon = 132139,
					ranks = 3,
				},
			}, -- [17]
			{
				info = {
					tips = "While in Cat, Bear or Dire Bear Form, the Leader of the Pack increases ranged and melee critical chance of all party members within 45 yards by 5%.",
					name = "Leader of the Pack",
					row = 7,
					column = 2,
					exceptional = 1,
					icon = 136112,
					ranks = 1,
				},
			}, -- [18]
			{
				info = {
					prereqs = {
						{
							column = 2,
							row = 7,
							source = 18,
						}, -- [1]
					},
					name = "Improved Leader of the Pack",
					tips = "Your Leader of the Pack ability also causes affected targets to have a 100%% chance to heal themselves for %d%% of their total health when they critically hit with a melee or ranged attack.  The healing effect cannot occur more than once every 6 sec.",
					tipValues = {{2}, {4}},
					column = 3,
					row = 7,
					icon = 136112,
					ranks = 2,
				},
			}, -- [19]
			{
				info = {
					name = "Predatory Instincts",
					tips = "While in Cat Form, Bear Form, or Dire Bear Form, increases your damage from melee critical strikes by %d%% and your chance to avoid area effect attacks by %d%%.",
					tipValues = {{2, 3}, {4, 6}, {6, 9}, {8, 12}, {10, 15}},
					column = 3,
					row = 8,
					icon = 132138,
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
					name = "Mangle",
					tips = "Mangle the target, inflicting damage and causing the target to take additional damage from bleed effects for 12 sec.  This ability can be used in Cat Form or Dire Bear Form.",
					column = 2,
					row = 9,
					icon = 132135,
					ranks = 1,
				},
			}, -- [21]
		},
		info = {
			name = "Feral Combat",
			background = "DruidFeralCombat",
		},
	}, -- [2]
	{
		numtalents = 20,
		talents = {
			{
				info = {
					name = "Improved Mark of the Wild",
					tips = "Increases the effects of your Mark of the Wild and Gift of the Wild spells by %d%%.",
					tipValues = {{7}, {14}, {21}, {28}, {35}},
					column = 2,
					row = 1,
					icon = 136078,
					ranks = 5,
				},
			}, -- [1]
			{
				info = {
					name = "Furor",
					tips = "Gives you %d%% chance to gain 10 Rage when you shapeshift into Bear and Dire Bear Form or 40 Energy when you shapeshift into Cat Form.",
					tipValues = {{20}, {40}, {60}, {80}, {100}},
					column = 3,
					row = 1,
					icon = 135881,
					ranks = 5,
				},
			}, -- [2]
			{
				info = {
					name = "Naturalist",
					tips = "Reduces the cast time of your Healing Touch spell by %.1f sec and increases the damage you deal with physical attacks in all forms by %d%%.",
					tipValues = {{0.1, 2}, {0.2, 4}, {0.3, 6}, {0.4, 8}, {0.5, 10}},
					column = 1,
					row = 2,
					icon = 136041,
					ranks = 5,
				},
			}, -- [3]
			{
				info = {
					name = "Nature's Focus",
					tips = "Gives you a %d%% chance to avoid interruption caused by damage while casting the Healing Touch, Regrowth and Tranquility spells.",
					tipValues = {{14}, {28}, {42}, {56}, {70}},
					column = 2,
					row = 2,
					icon = 136042,
					ranks = 5,
				},
			}, -- [4]
			{
				info = {
					name = "Natural Shapeshifter",
					tips = "Reduces the mana cost of all shapeshifting by %d%%.",
					tipValues = {{10}, {20}, {30}},
					column = 3,
					row = 2,
					icon = 136116,
					ranks = 3,
				},
			}, -- [5]
			{
				info = {
					name = "Intensity",
					tips = "Allows %d%% of your Mana regeneration to continue while casting and causes your Enrage ability to instantly generate %d rage.",
					tipValues = {{10, 4}, {20, 7}, {30, 10}},
					column = 1,
					row = 3,
					icon = 135863,
					ranks = 3,
				},
			}, -- [6]
			{
				info = {
					name = "Subtlety",
					tips = "Reduces the threat generated by your spells by %d%% and reduces the chance your spells will be dispelled by %d%%.",
					tipValues = {{4, 6}, {8, 12}, {12, 18}, {16, 24}, {20, 30}},
					column = 2,
					row = 3,
					icon = 132150,
					ranks = 5,
				},
			}, -- [7]
			{
				info = {
					tips = "Imbues the Druid with natural energy.  Each of the Druid's melee attacks has a chance of causing the caster to enter a Clearcasting state.  The Clearcasting state reduces the Mana, Rage or Energy cost of your next damage or healing spell or offensive ability by 100%.  Lasts 30 min.",
					name = "Omen of Clarity",
					row = 3,
					column = 3,
					exceptional = 1,
					icon = 136017,
					ranks = 1,
				},
			}, -- [8]
			{
				info = {
					name = "Tranquil Spirit",
					tips = "Reduces the mana cost of your Healing Touch and Tranquility spells by %d%%.",
					tipValues = {{2}, {4}, {6}, {8}, {10}},
					column = 2,
					row = 4,
					icon = 135900,
					ranks = 5,
				},
			}, -- [9]
			{
				info = {
					name = "Improved Rejuvenation",
					tips = "Increases the effect of your Rejuvenation spell by %d%%.",
					tipValues = {{5}, {10}, {15}},
					column = 3,
					row = 4,
					icon = 136081,
					ranks = 3,
				},
			}, -- [10]
			{
				info = {
					tips = "When activated, your next Nature spell becomes an instant cast spell.",
					prereqs = {
						{
							column = 1,
							row = 3,
							source = 6,
						}, -- [1]
					},
					name = "Nature's Swiftness",
					row = 5,
					column = 1,
					exceptional = 1,
					icon = 136076,
					ranks = 1,
				},
			}, -- [11]
			{
				info = {
					name = "Gift of Nature",
					tips = "Increases the effect of all healing spells by %d%%.",
					tipValues = {{2}, {4}, {6}, {8}, {10}},
					column = 2,
					row = 5,
					icon = 136074,
					ranks = 5,
				},
			}, -- [12]
			{
				info = {
					name = "Improved Tranquility",
					tips = "Reduces threat caused by Tranquility by %d%%.",
					tipValues = {{50}, {100}},
					column = 4,
					row = 5,
					icon = 136107,
					ranks = 2,
				},
			}, -- [13]
			{
				info = {
					name = "Empowered Touch",
					tips = "Your Healing Touch spell gains an additional %d%% of your bonus healing effects.",
					tipValues = {{10}, {20}},
					column = 1,
					row = 6,
					icon = 132125,
					ranks = 2,
				},
			}, -- [14]
			{
				info = {
					prereqs = {
						{
							column = 3,
							row = 4,
							source = 10,
						}, -- [1]
					},
					name = "Improved Regrowth",
					tips = "Increases the critical effect chance of your Regrowth spell by %d%%.",
					tipValues = {{10}, {20}, {30}, {40}, {50}},
					column = 3,
					row = 6,
					icon = 136085,
					ranks = 5,
				},
			}, -- [15]
			{
				info = {
					name = "Living Spirit",
					tips = "Increases your total Spirit by %d%%.",
					tipValues = {{5}, {10}, {15}},
					column = 1,
					row = 7,
					icon = 136037,
					ranks = 3,
				},
			}, -- [16]
			{
				info = {
					tips = "Consumes a Rejuvenation or Regrowth effect on a friendly target to instantly heal them an amount equal to 12 sec. of Rejuvenation or 18 sec. of Regrowth.",
					prereqs = {
						{
							column = 2,
							row = 5,
							source = 12,
						}, -- [1]
					},
					name = "Swiftmend",
					row = 7,
					column = 2,
					exceptional = 1,
					icon = 134914,
					ranks = 1,
				},
			}, -- [17]
			{
				info = {
					name = "Natural Perfection",
					tips = "Your critical strike chance with all spells is increased by %d%% and critical strikes against you give you the Natural Perfection effect reducing all damage taken by %d%%.  Stacks up to 3 times.  Lasts 8 sec.",
					tipValues = {{1, 2}, {2,3 }, {3, 4}},
					column = 3,
					row = 7,
					icon = 132137,
					ranks = 3,
				},
			}, -- [18]
			{
				info = {
					name = "Empowered Rejuvenation",
					tips = "The bonus healing effects of your healing over time spells is increased by %d%%.",
					tipValues = {{4}, {8}, {12}, {16}, {20}},
					column = 2,
					row = 8,
					icon = 132124,
					ranks = 5,
				},
			}, -- [19]
			{
				info = {
					tips = "Shapeshift into the Tree of Life.  While in this form you increase healing received by 25% of your total Spirit for all party members within 45 yards, your movement speed is reduced by 20%, and you can only cast Swiftmend, Innervate, Nature's Swiftness, Rebirth, Barkskin, poison removing and healing over time spells, but the mana cost of these spells is reduced by 20%.\r\n\r\nThe act of shapeshifting frees the caster of Polymorph and Movement Impairing effects.",
					prereqs = {
						{
							column = 2,
							row = 8,
							source = 19,
						}, -- [1]
					},
					name = "Tree of Life",
					row = 9,
					column = 2,
					exceptional = 1,
					icon = 132145,
					ranks = 1,
				},
			}, -- [20]
		},
		info = {
			name = "Restoration",
			background = "DruidRestoration",
		},
	}, -- [3]
}
