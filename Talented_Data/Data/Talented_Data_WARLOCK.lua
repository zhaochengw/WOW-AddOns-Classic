if not Talented_Data then return end

Talented_Data.WARLOCK = {
	{
		numtalents = 21,
		talents = {
			{
				info = {
					name = "Suppression",
					tips = "Reduces the chance for enemies to resist your Affliction spells by %d%%.",
					tipValues = {{2}, {4}, {6}, {8}, {10}},
					column = 2,
					row = 1,
					icon = 136230,
					ranks = 5,
				},
			}, -- [1]
			{
				info = {
					name = "Improved Corruption",
					tips = "Reduces the casting time of your Corruption spell by %.1f sec.",
					tipValues = {{0.4}, {0.8}, {1.2}, {1.6}, {2.0}},
					column = 3,
					row = 1,
					icon = 136118,
					ranks = 5,
				},
			}, -- [2]
			{
				info = {
					name = "Improved Curse of Weakness",
					tips = "Increases the effect of your Curse of Weakness by %d%%.",
					tipValues = {{10}, {20}},
					column = 1,
					row = 2,
					icon = 136138,
					ranks = 2,
				},
			}, -- [3]
			{
				info = {
					name = "Improved Drain Soul",
					tips = "Returns %d%% of your maximum mana if the target is killed by you while you drain its soul.  In addition, your Affliction spells generate %d%% less threat.",
					tipValues = {{7, 5}, {15, 10}},
					column = 2,
					row = 2,
					icon = 136163,
					ranks = 2,
				},
			}, -- [4]
			{
				info = {
					name = "Improved Life Tap",
					tips = "Increases the amount of Mana awarded by your Life Tap spell by %d%%.",
					tipValues = {{10}, {20}},
					column = 3,
					row = 2,
					icon = 136126,
					ranks = 2,
				},
			}, -- [5]
			{
				info = {
					name = "Soul Siphon",
					tips = "Increases the amount drained by your Drain Life spell by an additional %d%% for each Affliction effect on the target, up to a maximum of %d%% additional effect.",
					tipValues = {{2, 24}, {4, 60}},
					column = 4,
					row = 2,
					icon = 136169,
					ranks = 2,
				},
			}, -- [6]
			{
				info = {
					name = "Improved Curse of Agony",
					tips = "Increases the damage done by your Curse of Agony by %d%%.",
					tipValues = {{5}, {10}},
					column = 1,
					row = 3,
					icon = 136139,
					ranks = 2,
				},
			}, -- [7]
			{
				info = {
					name = "Fel Concentration",
					tips = "Gives you a %d%% chance to avoid interruption caused by damage while channeling the Drain Life, Drain Mana, or Drain Soul spell.",
					tipValues = {{14}, {28}, {42}, {56}, {70}},
					column = 2,
					row = 3,
					icon = 136157,
					ranks = 5,
				},
			}, -- [8]
			{
				info = {
					tips = "Increases the effect of your next Curse of Doom or Curse of Agony by 50%, or your next Curse of Exhaustion by an additional 20%.  Lasts 30 sec.",
					name = "Amplify Curse",
					row = 3,
					column = 3,
					exceptional = 1,
					icon = 136132,
					ranks = 1,
				},
			}, -- [9]
			{
				info = {
					name = "Grim Reach",
					tips = "Increases the range of your Affliction spells by %d%%.",
					tipValues = {{10}, {20}},
					column = 1,
					row = 4,
					icon = 136127,
					ranks = 2,
				},
			}, -- [10]
			{
				info = {
					name = "Nightfall",
					tips = "Gives your Corruption and Drain Life spells a %d%% chance to cause you to enter a Shadow Trance state after damaging the opponent.  The Shadow Trance state reduces the casting time of your next Shadow Bolt spell by 100%%.",
					tipValues = {{2}, {4}},
					column = 2,
					row = 4,
					icon = 136223,
					ranks = 2,
				},
			}, -- [11]
			{
				info = {
					name = "Empowered Corruption",
					tips = "Your Corruption spell gains an additional %d%% of your bonus spell damage effects.",
					tipValues = {{12}, {24}, {36}},
					column = 4,
					row = 4,
					icon = 136118,
					ranks = 3,
				},
			}, -- [12]
			{
				info = {
					name = "Shadow Embrace",
					tips = "Your Corruption, Curse of Agony, Siphon Life and Seed of Corruption spells also cause the Shadow Embrace effect, which reduces physical damage caused by %d%%.",
					tipValues = {{1}, {2}, {3}, {4}, {5}},
					column = 1,
					row = 5,
					icon = 136198,
					ranks = 5,
				},
			}, -- [13]
			{
				info = {
					tips = "Transfers 15 health from the target to the caster every 3 sec.  Lasts 30 sec.",
					name = "Siphon Life",
					row = 5,
					column = 2,
					exceptional = 1,
					icon = 136188,
					ranks = 1,
				},
			}, -- [14]
			{
				info = {
					tips = "Reduces the target's movement speed by 30% for 12 sec.  Only one Curse per Warlock can be active on any one target.",
					prereqs = {
						{
							column = 3,
							row = 3,
							source = 9,
						}, -- [1]
					},
					name = "Curse of Exhaustion",
					row = 5,
					column = 3,
					exceptional = 1,
					icon = 136162,
					ranks = 1,
				},
			}, -- [15]
			{
				info = {
					prereqs = {
						{
							column = 2,
							row = 5,
							source = 14,
						}, -- [1]
					},
					name = "Shadow Mastery",
					tips = "Increases the damage dealt or life drained by your Shadow spells by %d%%.",
					tipValues = {{2}, {4}, {6}, {8}, {10}},
					column = 2,
					row = 6,
					icon = 136195,
					ranks = 5,
				},
			}, -- [16]
			{
				info = {
					name = "Contagion",
					tips = "Increases the damage of Curse of Agony, Corruption and Seed of Corruption by %d%% and reduces the chance your Affliction spells will be dispelled by an additional %d%%.",
					tipValues = {{1, 6}, {2, 12}, {3, 18}, {4, 24}, {5, 30}},
					column = 2,
					row = 7,
					icon = 136180,
					ranks = 5,
				},
			}, -- [17]
			{
				info = {
					tips = "Drains 305 of your pet's Mana, returning 100% to you.",
					name = "Dark Pact",
					row = 7,
					column = 3,
					exceptional = 1,
					icon = 136141,
					ranks = 1,
				},
			}, -- [18]
			{
				info = {
					name = "Improved Howl of Terror",
					tips = "Reduces the casting time of your Howl of Terror spell by %.1f sec.",
					tipValues = {{0.8}, {1.5}},
					column = 1,
					row = 8,
					icon = 136147,
					ranks = 2,
				},
			}, -- [19]
			{
				info = {
					name = "Malediction",
					tips = "Increases the damage bonus effect of your Curse of the Elements spell by an additional %d%%.",
					tipValues = {{1}, {2}, {3}},
					column = 3,
					row = 8,
					icon = 136137,
					ranks = 3,
				},
			}, -- [20]
			{
				info = {
					tips = "Shadow energy slowly destroys the target, causing 660 damage over 18 sec.  In addition, if the Unstable Affliction is dispelled it will cause 990 damage to the dispeller and silence them for 5 sec.",
					prereqs = {
						{
							column = 2,
							row = 7,
							source = 17,
						}, -- [1]
					},
					name = "Unstable Affliction",
					row = 9,
					column = 2,
					exceptional = 1,
					icon = 136228,
					ranks = 1,
				},
			}, -- [21]
		},
		info = {
			name = "Affliction",
			background = "WarlockCurses",
		},
	}, -- [1]
	{
		numtalents = 22,
		talents = {
			{
				info = {
					name = "Improved Healthstone",
					tips = "Increases the amount of Health restored by your Healthstone by %d%%.",
					tipValues = {{10}, {20}},
					column = 1,
					row = 1,
					icon = 135230,
					ranks = 2,
				},
			}, -- [1]
			{
				info = {
					name = "Improved Imp",
					tips = "Increases the effect of your Imp's Firebolt, Fire Shield, and Blood Pact spells by %d%%.",
					tipValues = {{10}, {20}, {30}},
					column = 2,
					row = 1,
					icon = 136218,
					ranks = 3,
				},
			}, -- [2]
			{
				info = {
					name = "Demonic Embrace",
					tips = "Increases your total Stamina by %d%% but reduces your total Spirit by %d%%.",
					tipValues = {{3, 1}, {6, 2}, {9, 3}, {12, 4}, {15, 5}},
					column = 3,
					row = 1,
					icon = 136172,
					ranks = 5,
				},
			}, -- [3]
			{
				info = {
					name = "Improved Health Funnel",
					tips = "Increases the amount of Health transferred by your Health Funnel spell by %d%% and reduces the initial health cost by %d%%.",
					tipValues = {{10, 10}, {20, 20}},
					column = 1,
					row = 2,
					icon = 136168,
					ranks = 2,
				},
			}, -- [4]
			{
				info = {
					name = "Improved Voidwalker",
					tips = "Increases the effectiveness of your Voidwalker's Torment, Consume Shadows, Sacrifice and Suffering spells by %d%%.",
					tipValues = {{10}, {20}, {30}},
					column = 2,
					row = 2,
					icon = 136221,
					ranks = 3,
				},
			}, -- [5]
			{
				info = {
					name = "Fel Intellect",
					tips = "Increases the Intellect of your Imp, Voidwalker, Succubus, Felhunter and Felguard by %d%% and increases your maximum mana by %d%%.",
					tipValues = {{5, 1}, {10, 2}, {15, 3}},
					column = 3,
					row = 2,
					icon = 135932,
					ranks = 3,
				},
			}, -- [6]
			{
				info = {
					name = "Improved Succubus",
					tips = "Increases the effect of your Succubus' Lash of Pain and Soothing Kiss spells by %d%%, and increases the duration of your Succubus' Seduction and Lesser Invisibility spells by %d%%.",
					tipValues = {{10, 10}, {20, 20}, {30, 30}},
					column = 1,
					row = 3,
					icon = 136220,
					ranks = 3,
				},
			}, -- [7]
			{
				info = {
					tips = "Your next Imp, Voidwalker, Succubus, Felhunter or Felguard Summon spell has its casting time reduced by 5.5 sec and its Mana cost reduced by 50%.",
					name = "Fel Domination",
					row = 3,
					column = 2,
					exceptional = 1,
					icon = 136082,
					ranks = 1,
				},
			}, -- [8]
			{
				info = {
					name = "Fel Stamina",
					tips = "Increases the Stamina of your Imp, Voidwalker, Succubus, Felhunter and Felguard by %d%% and increases your maximum health by %d%%.",
					tipValues = {{5, 1}, {10, 2}, {15, 3}},
					column = 3,
					row = 3,
					icon = 136121,
					ranks = 3,
				},
			}, -- [9]
			{
				info = {
					name = "Demonic Aegis",
					tips = "Increases the effectiveness of your Demon Armor and Fel Armor spells by %d%%.",
					tipValues = {{10}, {20}, {30}},
					column = 4,
					row = 3,
					icon = 136185,
					ranks = 3,
				},
			}, -- [10]
			{
				info = {
					prereqs = {
						{
							column = 2,
							row = 3,
							source = 8,
						}, -- [1]
					},
					name = "Master Summoner",
					tips = "Reduces the casting time of your Imp, Voidwalker, Succubus, Felhunter and Fel Guard Summoning spells by %d sec and the Mana cost by %d%%.",
					tipValues = {{2, 20}, {4, 40}},
					column = 2,
					row = 4,
					icon = 136164,
					ranks = 2,
				},
			}, -- [11]
			{
				info = {
					name = "Unholy Power",
					tips = "Increases the damage done by your Voidwalker, Succubus, Felhunter and Felguard's melee attacks and your Imp's Firebolt by %d%%.",
					tipValues = {{4}, {8}, {12}, {16}, {20}},
					column = 3,
					row = 4,
					icon = 136206,
					ranks = 5,
				},
			}, -- [12]
			{
				info = {
					name = "Improved Enslave Demon",
					tips = "Reduces the Attack Speed and Casting Speed penalty of your Enslave Demon spell by %d%% and reduces the resist chance by %d%%.",
					tipValues = {{5, 5}, {10, 10}},
					column = 1,
					row = 5,
					icon = 136154,
					ranks = 2,
				},
			}, -- [13]
			{
				info = {
					tips = "When activated, sacrifices your summoned demon to grant you an effect that lasts 30 min.  The effect is canceled if any Demon is summoned.\r\n\r\nImp: Increases your Fire damage by 15%.\r\n\r\nVoidwalker: Restores 2% of total health every 4 sec.\r\n\r\nSuccubus: Increases your Shadow damage by 15%.\r\n\r\nFelhunter: Restores 3% of total mana every 4 sec.\r\n\r\nFelguard: Increases your Shadow damage by 10% and restores 2% of total mana every 4 sec.",
					name = "Demonic Sacrifice",
					row = 5,
					column = 2,
					exceptional = 1,
					icon = 136184,
					ranks = 1,
				},
			}, -- [14]
			{
				info = {
					name = "Master Conjuror",
					tips = "Increases the bonus Fire damage from Firestones and the Firestone effect by %d%% and increases the spell critical strike rating bonus of your Spellstone by %d%%.",
					tipValues = {{15, 15}, {30, 30}},
					column = 4,
					row = 5,
					icon = 132386,
					ranks = 2,
				},
			}, -- [15]
			{
				info = {
					name = "Mana Feed",
					tips = "When you gain mana from Drain Mana or Life Tap spells, your pet gains %d%% of the mana you gain.",
					tipValues = {{33}, {66}, {100}},
					column = 1,
					row = 6,
					icon = 136171,
					ranks = 3,
				},
			}, -- [16]
			{
				info = {
					prereqs = {
						{
							column = 3,
							row = 4,
							source = 12,
						}, -- [1]
					},
					name = "Master Demonologist",
					tips = "Grants both the Warlock and the summoned demon an effect as long as that demon is active.\r\n\r\nImp - Reduces threat caused by 5d%%.\r\n\r\nVoidwalker - Reduces physical damage taken by %d%%.\r\n\r\nSuccubus - Increases all damage caused by %d%%.\r\n\r\nFelhunter - Increases all resistances by %.1f per level.\r\n\r\nFelguard - Increases all damage caused by %d%% and all resistances by %.1f per level.",
					tipValues = {{4, 2, 2, 0.2, 1, 0.1}, {8, 4, 4, 0.4, 2, 0.2}, {12, 6, 6, 0.6, 3, 0.3}, {16, 8, 8, 0.8, 4, 0.4}, {20, 10, 10, 1.0, 5, 0.5}},
					column = 3,
					row = 6,
					icon = 136203,
					ranks = 5,
				},
			}, -- [17]
			{
				info = {
					name = "Demonic Resilience",
					tips = "Reduces the chance you'll be critically hit by melee and spells by %d%% and reduces all damage your summoned demon takes by %d%%.",
					tipValues = {{1, 5}, {2, 10}, {3, 15}},
					column = 1,
					row = 7,
					icon = 136149,
					ranks = 3,
				},
			}, -- [18]
			{
				info = {
					tips = "When active, 20% of all damage taken by the caster is taken by your Imp, Voidwalker, Succubus, Felhunter, Felguard, or enslaved demon instead.  That damage cannot be prevented.  In addition, both the demon and master will inflict 5% more damage.  Lasts as long as the demon is active and controlled.",
					prereqs = {
						{
							column = 2,
							row = 5,
							source = 14,
						}, -- [1]
					},
					name = "Soul Link",
					row = 7,
					column = 2,
					exceptional = 1,
					icon = 136160,
					ranks = 1,
				},
			}, -- [19]
			{
				info = {
					name = "Demonic Knowledge",
					tips = "Increases your spell damage by an amount equal to %d%% of the total of your active demon's Stamina plus Intellect.",
					tipValues = {{4}, {8}, {12}},
					column = 3,
					row = 7,
					icon = 136165,
					ranks = 3,
				},
			}, -- [20]
			{
				info = {
					name = "Demonic Tactics",
					tips = "Increases melee and spell critical strike chance for you and your summoned demon by %d%%.",
					tipValues = {{1}, {2}, {3}, {4}, {5}},
					column = 2,
					row = 8,
					icon = 136150,
					ranks = 5,
				},
			}, -- [21]
			{
				info = {
					tips = "Summons a Felguard under the command of the Warlock.",
					name = "Summon Felguard",
					row = 9,
					column = 2,
					exceptional = 1,
					icon = 136216,
					ranks = 1,
				},
			}, -- [22]
		},
		info = {
			name = "Demonology",
			background = "WarlockSummoning",
		},
	}, -- [2]
	{
		numtalents = 21,
		talents = {
			{
				info = {
					name = "Improved Shadow Bolt",
					tips = "Your Shadow Bolt critical strikes increase Shadow damage dealt to the target by %d%% until 4 non-periodic damage sources are applied.  Effect lasts a maximum of 12 sec.",
					tipValues = {{4}, {8}, {12}, {16}, {20}},
					column = 2,
					row = 1,
					icon = 136197,
					ranks = 5,
				},
			}, -- [1]
			{
				info = {
					name = "Cataclysm",
					tips = "Reduces the Mana cost of your Destruction spells by %d%%.",
					tipValues = {{1}, {2}, {3}, {4}, {5}},
					column = 3,
					row = 1,
					icon = 135831,
					ranks = 5,
				},
			}, -- [2]
			{
				info = {
					name = "Bane",
					tips = "Reduces the casting time of your Shadow Bolt and Immolate spells by %.1f sec and your Soul Fire spell by %.1f sec.",
					tipValues = {{0.1, 0.4}, {0.2, 0.8}, {0.3, 1.2}, {0.4, 1.6}, {0.5, 2.0}},
					column = 2,
					row = 2,
					icon = 136146,
					ranks = 5,
				},
			}, -- [3]
			{
				info = {
					name = "Aftermath",
					tips = "Gives your Destruction spells a %d%% chance to daze the target for 5 sec.",
					tipValues = {{2}, {4}, {6}, {8}, {10}},
					column = 3,
					row = 2,
					icon = 135805,
					ranks = 5,
				},
			}, -- [4]
			{
				info = {
					name = "Improved Firebolt",
					tips = "Reduces the casting time of your Imp's Firebolt spell by %.2f sec.",
					tipValues = {{0.25}, {0.5}},
					column = 1,
					row = 3,
					icon = 135809,
					ranks = 2,
				},
			}, -- [5]
			{
				info = {
					name = "Improved Lash of Pain",
					tips = "Reduces the cooldown of your Succubus' Lash of Pain spell by %d sec.",
					tipValues = {{3}, {6}},
					column = 2,
					row = 3,
					icon = 136136,
					ranks = 2,
				},
			}, -- [6]
			{
				info = {
					name = "Devastation",
					tips = "Increases the critical strike chance of your Destruction spells by %d%%.",
					tipValues = {{1}, {2}, {3}, {4}, {5}},
					column = 3,
					row = 3,
					icon = 135813,
					ranks = 5,
				},
			}, -- [7]
			{
				info = {
					tips = "Instantly blasts the target for 91 to 104 Shadow damage.  If the target dies within 5 sec of Shadowburn, and yields experience or honor, the caster gains a Soul Shard.",
					name = "Shadowburn",
					row = 3,
					column = 4,
					exceptional = 1,
					icon = 136191,
					ranks = 1,
				},
			}, -- [8]
			{
				info = {
					name = "Intensity",
					tips = "Gives you a %d%% chance to resist interruption caused by damage while casting or channeling any Destruction spell.",
					tipValues = {{35}, {70}},
					column = 1,
					row = 4,
					icon = 135819,
					ranks = 2,
				},
			}, -- [9]
			{
				info = {
					name = "Destructive Reach",
					tips = "Increases the range of your Destruction spells by %d%% and reduces threat caused by Destruction spells by %d%%.",
					tipValues = {{10, 5}, {20, 10}},
					column = 2,
					row = 4,
					icon = 136133,
					ranks = 2,
				},
			}, -- [10]
			{
				info = {
					name = "Improved Searing Pain",
					tips = "Increases the critical strike chance of your Searing Pain spell by %d%%.",
					tipValues = {{4}, {7}, {10}},
					column = 4,
					row = 4,
					icon = 135827,
					ranks = 3,
				},
			}, -- [11]
			{
				info = {
					prereqs = {
						{
							column = 1,
							row = 4,
							source = 9,
						}, -- [1]
					},
					name = "Pyroclasm",
					tips = "Gives your Rain of Fire, Hellfire, and Soul Fire spells a %d%% chance to stun the target for 3 sec.",
					tipValues = {{13}, {26}},
					column = 1,
					row = 5,
					icon = 135830,
					ranks = 2,
				},
			}, -- [12]
			{
				info = {
					name = "Improved Immolate",
					tips = "Increases the initial damage of your Immolate spell by %d%%.",
					tipValues = {{5}, {10}, {15}, {20}, {25}},
					column = 2,
					row = 5,
					icon = 135817,
					ranks = 5,
				},
			}, -- [13]
			{
				info = {
					prereqs = {
						{
							column = 3,
							row = 3,
							source = 7,
						}, -- [1]
					},
					name = "Ruin",
					tips = "Increases the critical strike damage bonus of your Destruction spells by 100%.",
					column = 3,
					row = 5,
					icon = 136207,
					ranks = 1,
				},
			}, -- [14]
			{
				info = {
					name = "Nether Protection",
					tips = "After being hit with a Shadow or Fire spell, you have a %d%% chance to become immune to Shadow and Fire spells for 4 sec.",
					tipValues = {{10}, {20}, {30}},
					column = 1,
					row = 6,
					icon = 136178,
					ranks = 3,
				},
			}, -- [15]
			{
				info = {
					name = "Emberstorm",
					tips = "Increases the damage done by your Fire spells by %d%% and reduces the cast time of your Incinerate spell by %d%%.",
					tipValues = {{2, 2}, {4, 4}, {6, 6}, {8, 8}, {10, 10}},
					column = 3,
					row = 6,
					icon = 135826,
					ranks = 5,
				},
			}, -- [16]
			{
				info = {
					name = "Backlash",
					tips = "Increases your critical strike chance with spells by an additional %d%% and gives you a %d%% chance when hit by a physical attack to reduce the cast time of your next Shadow Bolt or Incinerate spell by 100%%.  This effect lasts 8 sec and will not occur more than once every 8 seconds.",
					tipValues = {{1, 8}, {2, 16}, {3, 25}},
					column = 1,
					row = 7,
					icon = 135823,
					ranks = 3,
				},
			}, -- [17]
			{
				info = {
					tips = "Ignites a target that is already afflicted by your Immolate, dealing 249 to 316 Fire damage and consuming the Immolate spell.",
					prereqs = {
						{
							column = 2,
							row = 5,
							source = 13,
						}, -- [1]
					},
					name = "Conflagrate",
					row = 7,
					column = 2,
					exceptional = 1,
					icon = 135807,
					ranks = 1,
				},
			}, -- [18]
			{
				info = {
					name = "Soul Leech",
					tips = "Gives your Shadow Bolt, Shadowburn, Soul Fire, Incinerate, Searing Pain and Conflagrate spells a %d%% chance to return health equal to 20%% of the damage caused.",
					tipValues = {{10}, {20}, {30}},
					column = 3,
					row = 7,
					icon = 136214,
					ranks = 3,
				},
			}, -- [19]
			{
				info = {
					name = "Shadow and Flame",
					tips = "Your Shadow Bolt and Incinerate spells gain an additional %d%% of your bonus spell damage effects.",
					tipValues = {{4}, {8}, {12}, {16}, {20}},
					column = 2,
					row = 8,
					icon = 136196,
					ranks = 5,
				},
			}, -- [20]
			{
				info = {
					tips = "Shadowfury is unleashed, causing 355 to 420 Shadow damage and stunning all enemies within 8 yds for 2 sec.",
					prereqs = {
						{
							column = 2,
							row = 8,
							source = 20,
						}, -- [1]
					},
					name = "Shadowfury",
					row = 9,
					column = 2,
					exceptional = 1,
					icon = 136201,
					ranks = 1,
				}, 
			}, -- [21]
		},
		info = {
			name = "Destruction",
			background = "WarlockDestruction",
		},
	}, -- [3]
}
