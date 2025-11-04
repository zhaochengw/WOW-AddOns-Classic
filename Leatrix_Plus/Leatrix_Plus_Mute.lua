
	----------------------------------------------------------------------
	-- Leatrix Plus Mute for Mists of Pandaria Classic
	----------------------------------------------------------------------

	local void, Leatrix_Plus = ...
	local L = Leatrix_Plus.L

	----------------------------------------------------------------------
	-- Mute game sounds
	----------------------------------------------------------------------

	-- Create soundtable
	local muteTable = {

		-- Chimes (sound/doodad/)
		["MuteChimes"] = {
			"belltollalliance.ogg#566564",
			"belltollhorde.ogg#565853",
			"belltollnightelf.ogg#566558",
			"belltolltribal.ogg#566027",
			"kharazahnbelltoll.ogg#566254",
			"dwarfhorn.ogg#566064",
		},

		-- Events
		["MuteEvents"] = {

			-- Headless Horseman (sound/creature/headlesshorseman/)
			"horseman_beckon_01.ogg#551670",
			"horseman_bodydefeat_01.ogg#551706",
			"horseman_bomb_01.ogg#551705",
			"horseman_conflag_01.ogg#551686",
			"horseman_death_01.ogg#551695",
			"horseman_failing_01.ogg#551684",
			"horseman_failing_02.ogg#551700",
			"horseman_fire_01.ogg#551673",
			"horseman_laugh_01.ogg#551703",
			"horseman_laugh_02.ogg#551682",
			"horseman_out_01.ogg#551680",
			"horseman_request_01.ogg#551687",
			"horseman_return_01.ogg#551698",
			"horseman_slay_01.ogg#551676",
			"horseman_special_01.ogg#551696",

		},

		["MuteFizzle"] = {			"sound/spells/fizzle/fizzlefirea.ogg#569773", "sound/spells/fizzle/FizzleFrostA.ogg#569775", "sound/spells/fizzle/FizzleHolyA.ogg#569772", "sound/spells/fizzle/FizzleNatureA.ogg#569774", "sound/spells/fizzle/FizzleShadowA.ogg#569776",},
		["MuteInterface"] = {		"sound/interface/iUiInterfaceButtonA.ogg#567481", "sound/interface/uChatScrollButton.ogg#567407", "sound/interface/uEscapeScreenClose.ogg#567464", "sound/interface/uEscapeScreenOpen.ogg#567490",},

		-- Login (sound/interface/)
		["MuteLogin"] = {

			-- This is handled with the PLAYER_LOGOUT event

		},

		-- Ready check (sound/interface/)
		["MuteReady"] = {
			"levelup2.ogg#567478",
		},

		-- Sniffing
		["MuteSniffing"] = {

			-- Female (sound/creature/worgenfemale/worgenfemale_emotesniff)
			"01.ogg#564422", "02.ogg#564378", "03.ogg#564383",

			-- Male (sound/creature/worgenfemale/worgenmale_emotesniff)
			"01.ogg#564560", "02.ogg#564544", "03.ogg#564536",
		},

		-- Trains
		["MuteTrains"] = {

			--[[Blood Elf]]	"sound#539219", "sound#539203",
			--[[Draenei]]	"sound#539516", "sound#539730",
			--[[Dwarf]]		"sound#539802", "sound#539881",
			--[[Gnome]]		"sound#540271", "sound#540275",
			--[[Goblin]]	"sound#541769", "sound#542017",
			--[[Human]]		"sound#540535", "sound#540734",
			--[[Night Elf]]	"sound#540870", "sound#540947",
			--[[Orc]]		"sound#541157", "sound#541239",
			--[[Tauren]]	"sound#542818", "sound#542896",
			--[[Troll]] 	"sound#543085", "sound#543093",
			--[[Undead]]	"sound#542526", "sound#542600",
			--[[Worgen]]	"sound#542035", "sound#542206", "sound#541463", "sound#541601",
			--[[Pandaren]]	"sound#636621", "sound#630296", "sound#630298",

		},

		-- Vaults
		["MuteVaults"] = {

			-- Mechanical guild vault idle sound (such as those found in Booty Bay and Winterspring)
			"sound/doodad/guildvault_goblin_01stand.ogg#566289",

		},

		----------------------------------------------------------------------
		-- Hunter
		----------------------------------------------------------------------

		-- Screech (sound/spells/)
		["MuteScreech"] = {

			"screech.ogg#569429",

		},

		-- Yawns (sound/creature/tiger/)
		["MuteYawns"] = {

			"mtigerstand2a.ogg#562388",

		},

		----------------------------------------------------------------------
		-- Pets
		----------------------------------------------------------------------

		-- Sunflower (Singing Sunflower) (sound/event/)
		["MuteSunflower"] = {

			"event_pvz_babbling.ogg#567354",
			"event_pvz_dadadoo.ogg#567327",
			"event_pvz_doobeedoo.ogg#567317",
			"event_pvz_lalala.ogg#567338",
			"event_pvz_sunflower.ogg#567374",
			"event_pvz_zombieonyourlawn.ogg#567295",

		},

		-- Pierre (sound/creature/cookbot/)
		["MutePierre"] = {
			"mon_cookbot_clickable01.ogg#805133", "mon_cookbot_clickable02.ogg#805135", "mon_cookbot_clickable03.ogg#805137", "mon_cookbot_clickable04.ogg#805139", "mon_cookbot_clickable05.ogg#805141", "mon_cookbot_clickable06.ogg#805143", "mon_cookbot_clickable07.ogg#805145", "mon_cookbot_clickable08.ogg#805147", "mon_cookbot_clickable09.ogg#805149",
			"mon_cookbot_stand.ogg#805163", "mon_cookbot_stand01.ogg#805165", "mon_cookbot_stand02.ogg#805167", "mon_cookbot_stand03.ogg#805169",
			-- sound/doodad/bush_flamecap.ogg#567067 -- Fire sound (not same as Cooking Fire) (this is enabled by game every time Pierre is summoned)
			-- sound/doodad/dt_bigdooropen.ogg#595622 and g_huntertrapopen.ogg#565429 -- Summon sounds
		},

		----------------------------------------------------------------------
		-- Toys
		----------------------------------------------------------------------

		-- Balls
		["MuteBalls"] = {

			-- Foot Ball (sound/item/weapons/mace2h)
			"2hmacehitstone1b.ogg#567794", "2hmacehitstone1c.ogg#567797", "2hmacehitstone1a.ogg#567804",

			-- Net sound (sound/spells)
			"sound/spells/thrownet.ogg#569368",

			-- The Pigskin (sound/item/weapons/weaponswings) (not used currently as the sound is more common and probably not annoying)
			-- "fx_whoosh_small_revamp_01.ogg#1302923", "fx_whoosh_small_revamp_02.ogg#1302924", "fx_whoosh_small_revamp_03.ogg#1302925", "fx_whoosh_small_revamp_04.ogg#1302926", "fx_whoosh_small_revamp_05.ogg#1302927", "fx_whoosh_small_revamp_06.ogg#1302928", "fx_whoosh_small_revamp_07.ogg#1302929", "fx_whoosh_small_revamp_08.ogg#1302930", "fx_whoosh_small_revamp_09.ogg#1302931", "fx_whoosh_small_revamp_10.ogg#1302932",

		},

		----------------------------------------------------------------------
		-- Misc
		----------------------------------------------------------------------

		-- A'dal
		["MuteAdal"] = {

			-- sound/creature/naaru/
			"naruuloopgood.ogg#601649",

			-- sound/doodad/
			"ancient_d_lights.ogg#567134",

		},

		-- Ripper (Arcanite ripper guitar sound)
		["MuteRipper"] = {

			-- sound/events/
			"archaniteripper.ogg#567384",

		},

		-- Rhonin
		["MuteRhonin"] = {

			-- sound/creature/rhonin/ur_rhonin_event
			"01.ogg#559130", "02.ogg#559131", "03.ogg#559126", "04.ogg#559128", "05.ogg#559133", "06.ogg#559129", "07.ogg#559132", "08.ogg#559127",

		},

		-- Kalecgos
		["MuteKalecgos"] = {

			-- sound/creature/kalecgos/vo_quest_42_kalecgos_final
			"01.ogg#552973", "02.ogg#552998", "03.ogg#552962", "04.ogg#552999", "05.ogg#552979", "06.ogg#553004", "07.ogg#553012", "08.ogg#552968", "09.ogg#552992",

		},

	}

	----------------------------------------------------------------------
	-- Mute mount sounds
	----------------------------------------------------------------------

	-- Create soundtable
	local mountTable = {

		----------------------------------------------------------------------
		-- Mounts
		----------------------------------------------------------------------

		-- Bikes
		["MuteBikes"] = {

			-- Mekgineer's Chopper/Mechano Hog/Chauffeured (sound/vehicles/motorcyclevehicle, sound/vehicles)
			"motorcyclevehicleattackthrown.ogg#569858", "motorcyclevehiclejumpend1.ogg#569863", "motorcyclevehiclejumpend2.ogg#569857", "motorcyclevehiclejumpend3.ogg#569855", "motorcyclevehiclejumpstart1.ogg#569856", "motorcyclevehiclejumpstart2.ogg#569862", "motorcyclevehiclejumpstart3.ogg#569860", "motorcyclevehicleloadthrown.ogg#569861", "motorcyclevehiclestand.ogg#569859", "motorcyclevehiclewalkrun.ogg#569854", "vehicle_ground_gearshift_1.ogg#598748", "vehicle_ground_gearshift_2.ogg#598736", "vehicle_ground_gearshift_3.ogg#569852", "vehicle_ground_gearshift_4.ogg#598745", "vehicle_ground_gearshift_5.ogg#569845",

		},

		-- Brooms
		["MuteBrooms"] = {

			-- sound/creature/broomstickmount/
			"broomstickmountland.ogg#545651",
			"broomstickmounttakeoff.ogg#545652",

			-- sound/spells/
			"summonbroomstick1.ogg#567986",
			"summonbroomstick3.ogg#569547",
			"summonbroomstick2.ogg#568335",

		},

		-- Gyrocopters
		["MuteGyrocopters"] = {

			-- Mimiron's Head (sound/creature/mimironheadmount/)
			"mimironheadmount_jumpend.ogg#595097",
			"mimironheadmount_jumpstart.ogg#595103",
			"mimironheadmount_run.ogg#555364",
			"mimironheadmount_walk.ogg#595100",

			-- sound/creature/gyrocopter/
			"gyrocopterfly.ogg#551390",
			"gyrocopterflyidle.ogg#551398",
			"gyrocopterflyup.ogg#551389",
			"gyrocoptergearshift1.ogg#551384",
			"gyrocoptergearshift2.ogg#551391",
			"gyrocoptergearshift3.ogg#551387",
			"gyrocopterjumpend.ogg#551396",
			"gyrocopterjumpstart.ogg#551399",
			"gyrocopterrun.ogg#551386",
			"gyrocoptershuffleleftorright1.ogg#551385",
			"gyrocoptershuffleleftorright2.ogg#551382",
			"gyrocoptershuffleleftorright3.ogg#551392",
			"gyrocopterstallinair.ogg#551395",
			"gyrocopterstallinairlong.ogg#551394",
			"gyrocopterstallongroundlong.ogg#551393",
			"gyrocopterstand.ogg#551383",
			"gyrocopterstandvar1_a.ogg#551388",
			"gyrocopterstandvar1_b.ogg#551397",
			"gyrocopterstandvar1_bnew.ogg#551400",
			"gyrocopterwalk.ogg#551401",

			-- Gear shift sounds (sound/vehicles/)
			"vehicle_airplane_gearshift_1.ogg#569846",
			"vehicle_airplane_gearshift_2.ogg#598739",
			"vehicle_airplane_gearshift_3.ogg#569851",
			"vehicle_airplane_gearshift_4.ogg#598742",
			"vehicle_airplane_gearshift_5.ogg#598733",
			"vehicle_airplane_gearshift_6.ogg#569850",

			-- sound/spells/
			"summongyrocopter.ogg#568252",

		},

		-- Horse footsteps
		["MuteHorsesteps"] = {

			-- sound/creature/horse/mfootstepshorse
			"dirt01.ogg#552083",
			"dirt02.ogg#552081",
			"dirt03.ogg#552072",
			"dirt04.ogg#552089",
			"dirt05.ogg#552078",
			"grass01.ogg#552087",
			"grass02.ogg#552085",
			"grass03.ogg#552062",
			"grass04.ogg#552071",
			"grass05.ogg#552079",
			"snow01.ogg#552065",
			"snow02.ogg#552084",
			"snow03.ogg#552058",
			"snow04.ogg#552073",
			"snow05.ogg#552077",
			"stone01.ogg#552090",
			"stone02.ogg#552068",
			"stone03.ogg#552070",
			"stone04.ogg#552082",
			"stone05.ogg#552060",
			"wood01.ogg#552086",
			"wood02.ogg#552075",
			"wood03.ogg#552076",
			"wood04.ogg#552066",
			"wood05.ogg#552063",

			-- Water is sound/character/footsteps/watersplash/footstepsmediumwater

		},

		-- Mechanical mount footsteps
		["MuteMechSteps"] = {

			-- sound/creature/gnomespidertank/
			"gnomespidertankfootstepa.ogg#550507",
			"gnomespidertankfootstepb.ogg#550514",
			"gnomespidertankfootstepc.ogg#550501",
			"gnomespidertankfootstepd.ogg#550500",
			"gnomespidertankwoundd.ogg#550511",
			"gnomespidertankwounde.ogg#550504",
			"gnomespidertankwoundf.ogg#550498",

		},

		-- Striders (footsteps are in another setting) (wound sounds are handled in SetupMute() as they are shared with travelers)
		["MuteStriders"] = {

			-- sound/creature/mechastrider/
			"mechastrideraggro.ogg#555127",
			"mechastriderattacka.ogg#555125",
			"smechastriderattackb.ogg#555123",
			"mechastriderattackc.ogg#555132",
			"mechastriderloop.ogg#555124",
			"mechastriderwoundcrit.ogg#555131",

		},

		-- Netherdrakes
		["MuteNetherdrakes"] = {

			-- sound/creature/netherdrake/
			"hugewingflap1.ogg#556477",
			"hugewingflap2.ogg#556479",
			"hugewingflap3.ogg#556476",
			"netherdrakea.ogg#556475",
			"netherdrakeb.ogg#556478",

		},

		-- Panthers
		["MutePanthers"] = {

			-- Idle (sound/doodad/fx_fire_magical_loop_)
			"01.ogg#565406", "02.ogg#566903", "03.ogg#566095",

			-- Mount special (sound/creature/wingedguardian/wingedguardian_mountspecial_)
			"01.ogg#564156", "02.ogg#564149", "03.ogg#564153", "04.ogg#564146", "05.ogg#564145", "06.ogg#564150", "07.ogg#564155",

			-- Everything else (sound/creature/onyxpanther/mon_onyx_panther_aggro)
			"01.ogg#623455", "02.ogg#623457", "03.ogg#623459", "04.ogg#623461", "05.ogg#623463", "06.ogg#623465", "07.ogg#623467", "08.ogg#623469",

			-- Moving idle wind (sound/doodad/fx_mount_wind_gusts)
			-- "01.ogg#644101", "02.ogg#644103", "03.ogg#644105", "04.ogg#644107", "05.ogg#644109",

		},

		-- Travelers (gnimo sounds are handled in SetupMute() as they are shared with striders)
		["MuteTravelers"] = {

			-- Traveler's Tundra Mammoth (sound/creature/npcdraeneimalestandard, sound/creature/goblinmalezanynpc, sound/creature/trollfemalelaidbacknpc, sound/creature/trollfemalelaidbacknpc)
			"npcdraeneimalestandardvendor01.ogg#557341", "npcdraeneimalestandardvendor02.ogg#557335", "npcdraeneimalestandardvendor03.ogg#557328", "npcdraeneimalestandardvendor04.ogg#557331", "npcdraeneimalestandardvendor05.ogg#557325", "npcdraeneimalestandardvendor06.ogg#557324",
			"npcdraeneimalestandardfarewell01.ogg#557342", "npcdraeneimalestandardfarewell02.ogg#557326", "npcdraeneimalestandardfarewell03.ogg#557322", "npcdraeneimalestandardfarewell05.ogg#557332", "npcdraeneimalestandardfarewell06.ogg#557338", "npcdraeneimalestandardfarewell08.ogg#557334",
			"goblinmalezanynpcvendor01.ogg#550818", "goblinmalezanynpcvendor02.ogg#550817", "goblinmalezanynpcgreeting01.ogg#550805", "goblinmalezanynpcgreeting02.ogg#550813", "goblinmalezanynpcgreeting03.ogg#550819", "goblinmalezanynpcgreeting04.ogg#550806", "goblinmalezanynpcgreeting05.ogg#550820", "goblinmalezanynpcgreeting06.ogg#550809",
			"goblinmalezanynpcfarewell01.ogg#550807", "goblinmalezanynpcfarewell03.ogg#550808", "goblinmalezanynpcfarewell04.ogg#550812",
			"trollfemalelaidbacknpcvendor01.ogg#562812","trollfemalelaidbacknpcvendor02.ogg#562802", "trollfemalelaidbacknpcgreeting01.ogg#562815","trollfemalelaidbacknpcgreeting02.ogg#562814", "trollfemalelaidbacknpcgreeting03.ogg#562816", "trollfemalelaidbacknpcgreeting04.ogg#562807", "trollfemalelaidbacknpcgreeting05.ogg#562804", "trollfemalelaidbacknpcgreeting06.ogg#562803",
			"trollfemalelaidbacknpcfarewell01.ogg#562809", "trollfemalelaidbacknpcfarewell02.ogg#562808", "trollfemalelaidbacknpcfarewell03.ogg#562813", "trollfemalelaidbacknpcfarewell04.ogg#562817", "trollfemalelaidbacknpcfarewell05.ogg#562806",
			-- sound/creature/mammoth2/ (mammoth sounds)
			-- "mammoth2_aggro_4552931.ogg#4552931",
			-- "mammoth2_aggro_4552929.ogg#4552929",
			-- "mammoth2_aggro_4552927.ogg#4552927",

			-- Grand Expedition Yak (sound/creature/grummlekooky, sound/creature/grummlestandard)
			"vo_grummle_kooky_vendor_01.ogg#640180", "vo_grummle_kooky_vendor_02.ogg#640182", "vo_grummle_kooky_vendor_03.ogg#640184",
			"vo_grummle_kooky_farewell_01.ogg#640158", "vo_grummle_kooky_farewell_02.ogg#640160", "vo_grummle_kooky_farewell_03.ogg#640162", "vo_grummle_kooky_farewell_04.ogg#640164",
			"vo_grummle_standard_vendor_01.ogg#640336", "vo_grummle_standard_vendor_02.ogg#640338", "vo_grummle_standard_vendor_03.ogg#640340",
			"vo_grummle_standard_farewell_01.ogg#640314", "vo_grummle_standard_farewell_02.ogg#640316", "vo_grummle_standard_farewell_03.ogg#640318", "vo_grummle_standard_farewell_04.ogg#640320",
			-- sound/creature/yak/ (Yak sounds)
			-- "mon_yak_mountspecial_01.ogg#613143",
			-- "mon_yak_mountspecial_02.ogg#613145",
			-- "mon_yak_mountspecial_03.ogg#613147",
			-- "mon_yak_mountspecial_04.ogg#613149",

		},

		-- Rockets (sound/creature/rocketmount/)
		["MuteRockets"] = {

			"rocketmountfly.ogg#595154",
			"rocketmountjumpland1.ogg#559355",
			"rocketmountjumpland2.ogg#559352",
			"rocketmountjumpland3.ogg#559353",
			"rocketmountshuffleleft_right1.ogg#595151",
			"rocketmountshuffleleft_right2.ogg#595163",
			"rocketmountshuffleleft_right3.ogg#595160",
			"rocketmountshuffleleft_right4.ogg#595157",
			"rocketmountstand_idle.ogg#559354",
			"rocketmountwalk.ogg#595148",
			"rocketmountwalkup.ogg#559351",

		},

	}

	----------------------------------------------------------------------
	-- End
	----------------------------------------------------------------------

	Leatrix_Plus["muteTable"] = muteTable
	Leatrix_Plus["mountTable"] = mountTable
