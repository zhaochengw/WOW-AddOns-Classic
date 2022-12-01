if Grid2.isClassic then return end

local RDDB = Grid2Options:GetRaidDebuffsTable()
RDDB["Dragonflight"] = {
	-- 5 man instances
	[1196] = {
		{ id = 1196, name = "Brackenhide Hollow" },
		["Hackclaw's War-Band"] = {
		order = 1, ejid = 2471,
		378020, --gash-frenzy
		381379, --decayed-senses
		},
		["Treemouth"] = {
		order = 2, ejid = 2473,
		377864, --infectious-spit
		378054, --withering-away
		378022, --consuming
		376933, --grasping-vines
			},
		["Gutshot"] = {
		order = 3, ejid = 2472,
		376997, --savage-peck
		},
		["Decatriarch Wratheye"] = {
		order = 4, ejid = 2474,
		373896, --withering-rot
		},
	},
	[1197] = {
		{ id = 1197, name = "Uldaman: Legacy of Tyr" },
		["The Lost Dwarves"] = {
		order = 1, ejid = 2475,
		377825, --burning-pitch
		375286, --searing-cannonfire
		},
		["Bromach"] = {
		order = 2, ejid = 2487,
		369660, --tremor
		},
		["Sentinel Talondras"] = {
		order = 3, ejid = 2484,
		372652, --resonating-orb
		},
		["Emberon"] = {
		order = 4, ejid = 2476,
		369110, --unstable-embers
		369025, --fire-wave
		},
		["Chrono-Lord Deios"] = {
		order = 5, ejid = 2479,
		376325, --eternity-zone
		377405, --time-sink
		},
	},
	[1198] = {
		{ id = 1198, name = "The Nokhud Offensive" },
		["The Raging Tempest"] = {
		order = 2, ejid = 2497,
		384185, -- Lightning Strike
		386916, -- The Raging Tempest
		382628, -- Surge of Power
		},
		["Teera and Maruuk"] = {
		order = 3, ejid = 2478,
		392151, -- Gale Arrow
		395669, -- Aftershock
		},
		["Balakar Khan"] = {
		order = 4, ejid = 2477,
		375937, -- Rending Strike
		376634, -- Iron Spear
		393421, -- Quake
		376730, -- Stormwinds
		376827, -- Conductive Strike
		376864, -- Static Spear
		376894, -- Crackling Upheaval
		376899, -- Crackling Cloud
		},
		["Trash"] = {
		order = 5, ejid = nil,
		384134, -- Pierce
		381692, -- Swift Stab
		334610, -- Hunt Prey
		384336, -- War Stomp
		384492, -- Hunter's Mark
		386025, -- Tempest
		386912, -- Stormsurge Cloud
		388801, -- Mortal Strike
		387615, -- Grasp of the Dead
		387616, -- Grasp of the Dead
		381530, -- Storm Shock
		373395, -- Bloodcurdling Shout
		387629, -- Rotting Wind
		395035, -- Shatter Soul
		},
	},
	[1199] = {
		{ id = 1199, name = "Neltharus" },
		["Chargath, Bane of Scales"] = {
		order = 1, ejid = 2490,
		374471, --erupted-ground
		374482, --grounding-chain
		},
		["Forgemaster Gorek"] = {
		order = 2, ejid = 2489,
		381482, --forgefire
		},
		["Magmatusk"] = {
		order = 3, ejid = 2494,
		375890, --magma-eruption
		374410, --magma-tentacle
		},
		["Warlord Sargha"] = {
		order = 4, ejid = 2501,
		377522, --burning-pursuit
		376784, --flame-vulnerability
		377018, --molten-gold
		377022, --hardened-gold
		377542, --burning-ground
		},
	},
	[1201] = {
		{ id = 1201, name = "Algeth'ar Academy" },
		["Vexamus"] = {
		order = 1, ejid = 2509,
		391977, -- Oversurge
		386181, -- Mana Bomb
		386201, -- Corrupted Mana
		},
		["Overgrown Ancient"] = {
		order = 2, ejid = 2512,
		388544, -- Barkbreaker
		396716, -- Splinterbark
		389033, -- Lasher Toxin
		},
		["Crawth"] = {
		order = 3, ejid = 2495,
		397210, -- Sonic Vulnerability
		376449, -- Firestorm
		376997, -- Savage Peck
		},
		["Echo of Doragosa"] = {
		order = 4, ejid = 2514,
		374350, -- Energy Bomb
		},
		["Trash"] = {
		order = 5, ejid = nil,
		390918, -- Seed Detonation
		377344, -- Peck
		388912, -- Severing Slash
		388866, -- Mana Void
		388984, -- Vicious Ambush
		388392, -- Monotonous Lecture
		387932, -- Astral Whirlwind
		378011, -- Deadly Winds
		387843, -- Astral Bomb
		},
	},
	[1202] = {
		{ id = 1202, name = "Ruby Life Pools" },
		["Melidrussa Chillworn"] = {
		order = 1, ejid = 2488,
		385518, -- Chillstorm
		372963, -- Chillstorm
		372682, -- Primal Chill
		378968, -- Flame Patch
		373022, -- Frozen Solid
		},
		["Kokia Blazehoof"] = {
		order = 2, ejid = 2485,
		372860, -- Searing Wounds
		372820, -- Scorched Earth
		372811, -- Molten Boulder
		384823, -- Inferno
		},
		["Kyrakka and Erkhart Stormvein"] = {
		order = 3, ejid = 2503,
		381526, -- Roaring Firebreath
		381862, -- Infernocore
		381515, -- Stormslam
		381518, -- Winds of Change
		384773, -- Flaming Embers
		},
		["Trash"] = {
		order = 4, ejid = nil,
		372697, -- Jagged Earth
		372047, -- Steel Barrage
		373869, -- Burning Touch
		392641, -- Rolling Thunder
		373693, -- Living Bomb
		373692, -- Inferno
		395292, -- Fire Maw
		372796, -- Blazing Rush
		392406, -- Thunderclap
		392451, -- Flashfire
		392924, -- Shock Blast
		373589, -- Primal Chill
		},
	},
	[1203] = {
		{ id = 1203, name = "The Azure Vault" },
		["Leymor"] = {
		order = 1, ejid = 2492,
		374789, -- Infused Strike
		374523, -- Stinging Sap
		374567, -- Explosive Brand
		},
		["Azureblade"] = {
		order = 2, ejid = 2505,
		},
		["Telash Greywing"] = {
		order = 3, ejid = 2483,
		386881, -- Frost Bomb
		387150, -- Frozen Ground
		387151, -- Icy Devastator
		388072, -- Vault Rune
		396722, -- Absolute Zero
		},
		["Umbrelskul"] = {
		order = 4, ejid = 2508,
		388777, -- Oppressive Miasma
		384978, -- Dragon Strike
		385331, -- Fracture
		385267, -- Crackling Vortex
		},
		["Trash"] = {
		order = 5, ejid = nil,
		387564, -- Mystic Vapors
		370764, -- Piercing Shards
		375596, -- Erratic Growth
		375602, -- Erratic Growth
		375649, -- Infused Ground
		370766, -- Crystalline Rupture
		371007, -- Splintering Shards
		375591, -- Sappy Burst
		395492, -- Scornful Haste
		395532, -- Sluggish Adoration
		390301, -- Hardening Scales
		386549, -- Waking Bane
		371352, -- Forbidden Knowledge
		377488, -- Icy Bindings
		386640, -- Tear Flesh
		},
	},
	[1204] = {
		{ id = 1204, name = "Halls of Infusion" },
		["Watcher Irideus"] = {
		order = 1, ejid = 2504,
		},
		["Gulping Goliath"] = {
		order = 2, ejid = 2507,
		},
		["Khajin the Unyielding"] = {
		order = 3, ejid = 2510,
		},
		["Primal Tsunami"] = {
		order = 4, ejid = 2511,
		},
	},
	-- World Bosses
	[102444] = {
		{ id = 1205, name = "Dragon Isles", raid = true },
		["Strunraan, The Sky's Misery"] = {
		order = 1, ejid = 2515,
		},
		["Basrikron, The Shale Wing"] = {
		order = 2, ejid = 2506,
		},
		["Bazual, The Dreaded Flame"] = {
		order = 3, ejid = 2517,
		},
		["Liskanoth, The Futurebane"] = {
		order = 4, ejid = 2518,
		},
	},
	-- Raid instances
	[1200] = {
		{ id = 1200, name = "Vault of the Incarnates", raid = true },
		["Eranog"] = {
		order = 1, ejid = 2480,
		370597, --kill-order
		371059, --melting-armor
		371955, --rising-heat
		370410, --pulsing-flames
		},
		["Terros"] = {
		order = 2, ejid = 2500,
		376276, --concussive-slam
		382776, --awakened-earth
		381576, --seismic-assault
		},
		["The Primal Council"] = {
		order = 3, ejid = 2486,
		371591, --frost-tomb
		371857, --shivering-lance
		371624, --conductive-mark
		372056, --crush
		374792, --faultline
		372027, --slashing-blaze
		},
		["Sennarth, the Cold Breath"] = {
		order = 4, ejid = 2482,
		372736, --permafrost
		372648, --pervasive-cold
		373817, --chilling-aura
		372129, --web-blast
		372044, --wrapped-in-webs
		372082, --enveloping-webs
		371976, --chilling-blast
		372030, --sticky-webbing
		372055, --icy-ground
		},
		["Dathea, Ascended"] = {
		order = 5, ejid = 2502,
		378095, --crushing-atmosphere
		377819, --lingering-slash
		374900, --microburst
		376802, --razor-winds
		375580, --zephyr-slam
		},
		["Kurog Grimtotem"] = {
		order = 6, ejid = 2491,
		374864, --primal-break
		372158, --sundering-strike
		373681, --biting-chill
		373487, --lightning-crash
		372514, --frost-bite
		372517, --frozen-solid
		377780, --skeletal-fractures
		374623, --frost-binds
		374554, --lava-pool
		},
		["Broodkeeper Diurna"] = {
		order = 7, ejid = 2493,
		378782, --mortal-wounds
		375829, --clutchwatchers-rage
		378787, --crushing-stoneclaws
		375871, --wildfire
		376266, --burrowing-strike
		375575, --flame-sentry
		375475, --rending-bite
		375457, --chilling-tantrum
		375653, --static-jolt
		376392, --disoriented
		375876, --icy-shards
		375430, --sever-tendon
		},
		["Raszageth the Storm-Eater"] = {
		order = 8, ejid = 2499,
		381615, --static-charge
		377594, --lightning-breath
		381249, --electrifying-presence
		},
	},
}
