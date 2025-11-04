-------------------------------------------------------------------------------
-- AddOn namespace.
-------------------------------------------------------------------------------
local FOLDER_NAME, private = ...

private.NPC_INFO = {
	[10203] = { zoneID = 0, displayID = 1687 }; --Berylgos
	[10236] = { zoneID = 0, displayID = 9529 }; --Wep
	[10237] = { zoneID = 0, displayID = 9530 }; --Yor
	[10238] = { zoneID = 0, displayID = 9531 }; --Staggon
	[10239] = { zoneID = 0, displayID = 9532 }; --Tepolar
	[11580] = { zoneID = 0, displayID = 10701 }; --Kelemis the Lifeless
	[11676] = { zoneID = 0, displayID = 12815 }; --Fjordune the Greater
	[12902] = { zoneID = 0, displayID = 12822 }; --Lorgus Jett
	[13977] = { zoneID = 0, displayID = 12249 }; --Gash'nak the Cannibal
	[14016] = { zoneID = 0, displayID = 14064 }; --Ushalac the Gloomdweller
	[14018] = { zoneID = 0, displayID = 14072 }; --Rezrelek <Winterax Hero>
	[14019] = { zoneID = 0, displayID = 13990 }; --Tatterhide
	[14341] = { zoneID = 0, displayID = 4943 }; --Felendor the Accuser
	[14346] = { zoneID = 0, displayID = 4426 }; --Captain Greshkil
	[17075] = { zoneID = 0, displayID = 17445 }; --Sandworm
	[18699] = { zoneID = 0, displayID = 17102 }; --Netherstorm Rare Chimaera UNUSED
	[31086] = { zoneID = 0, displayID = 25680 }; --Quest - Wintergrasp - PvP Kill - Alliance
	[3718] = { zoneID = 0, displayID = 4973 }; --Wrathtail Tide Princess
	[39019] = { zoneID = 0, displayID = 25680 }; --Quest - Wintergrasp - PvP Kill - Horde
	[50091] = { zoneID = 0, displayID = 36722 }; --Julak-Doom <The Eye of Zor>
	[50327] = { zoneID = 0, displayID = 1062 }; --Eastern Plaguelands 4.x Monster Bat Rare JMF
	[50736] = { zoneID = 0, displayID = 42488 }; --Acidous
	[50844] = { zoneID = 0, displayID = 1062 }; --Tyranitar
	[50845] = { zoneID = 0, displayID = 1062 }; --Thousand-Tooth
	[50847] = { zoneID = 0, displayID = 1062 }; --Proceratos
	[50849] = { zoneID = 0, displayID = 1062 }; --Blistermaw
	[50853] = { zoneID = 0, displayID = 1062 }; --Corpsegnaw the Feeder
	[50860] = { zoneID = 0, displayID = 1062 }; --Mos'delith
	[50861] = { zoneID = 0, displayID = 1062 }; --Nor-Nasam
	[50863] = { zoneID = 0, displayID = 1062 }; --Granulax
	[50867] = { zoneID = 0, displayID = 1062 }; --Bloodclaw
	[50868] = { zoneID = 0, displayID = 1062 }; --Skree
	[50870] = { zoneID = 0, displayID = 1062 }; --The Eviscerator
	[50871] = { zoneID = 0, displayID = 1062 }; --Velocitus
	[50872] = { zoneID = 0, displayID = 1062 }; --Teryx
	[50877] = { zoneID = 0, displayID = 1062 }; --Halfclaw
	[50879] = { zoneID = 0, displayID = 1062 }; --Herdstalker
	[50887] = { zoneID = 0, displayID = 1062 }; --Longstride
	[50889] = { zoneID = 0, displayID = 1062 }; --Limpwing the Swift
	[50890] = { zoneID = 0, displayID = 1062 }; --Deathsting
	[50899] = { zoneID = 0, displayID = 1062 }; --Pili
	[50900] = { zoneID = 0, displayID = 1062 }; --Pollix
	[50909] = { zoneID = 0, displayID = 1062 }; --Growler
	[50911] = { zoneID = 0, displayID = 1062 }; --Sharptooth
	[50912] = { zoneID = 0, displayID = 1062 }; --Keen-Ears the Tracker
	[50914] = { zoneID = 0, displayID = 1062 }; --Rendclaw <Slaughterer of Rabbits>
	[50917] = { zoneID = 0, displayID = 1062 }; --Yip
	[50918] = { zoneID = 0, displayID = 1062 }; --Yelper
	[50919] = { zoneID = 0, displayID = 1062 }; --Moonwaker the Baying
	[50920] = { zoneID = 0, displayID = 1062 }; --Canus
	[50921] = { zoneID = 0, displayID = 1062 }; --Lenois
	[50927] = { zoneID = 0, displayID = 1062 }; --Ursolon
	[50928] = { zoneID = 0, displayID = 1062 }; --Kodir the Cave-Dweller
	[50932] = { zoneID = 0, displayID = 1062 }; --Timbercraw
	[50933] = { zoneID = 0, displayID = 1062 }; --Dormis the Cub
	[50935] = { zoneID = 0, displayID = 1062 }; --Charger
	[50936] = { zoneID = 0, displayID = 1062 }; --Mudkin the Wallower
	[50938] = { zoneID = 0, displayID = 1062 }; --The Sungrass Stalker
	[50941] = { zoneID = 0, displayID = 1062 }; --Squealer
	[50943] = { zoneID = 0, displayID = 1062 }; --Tusky
	[50950] = { zoneID = 0, displayID = 1062 }; --Felspike
	[50953] = { zoneID = 0, displayID = 1062 }; --Dunge
	[50954] = { zoneID = 0, displayID = 1062 }; --Bisque
	[50956] = { zoneID = 0, displayID = 1062 }; --Pinner
	[50961] = { zoneID = 0, displayID = 1062 }; --Soft-Shell
	[50963] = { zoneID = 0, displayID = 1062 }; --Scalehide the Maw
	[50965] = { zoneID = 0, displayID = 1062 }; --Niles
	[50968] = { zoneID = 0, displayID = 1062 }; --Gullet
	[50969] = { zoneID = 0, displayID = 1062 }; --Dampscale
	[50972] = { zoneID = 0, displayID = 1062 }; --Mugs
	[50976] = { zoneID = 0, displayID = 1062 }; --Saltwater Behemoth
	[50979] = { zoneID = 0, displayID = 1062 }; --The River Stalker
	[50999] = { zoneID = 0, displayID = 1062 }; --Thorix
	[51012] = { zoneID = 0, displayID = 1062 }; --Shimmershell
	[51016] = { zoneID = 0, displayID = 1062 }; --Murr
	[51019] = { zoneID = 0, displayID = 1062 }; --Narakk
	[51020] = { zoneID = 0, displayID = 1062 }; --The Invisible Stalker
	[51024] = { zoneID = 0, displayID = 1062 }; --Nematoss
	[51030] = { zoneID = 0, displayID = 1062 }; --Onych
	[51032] = { zoneID = 0, displayID = 38484 }; --Muffin
	[51043] = { zoneID = 0, displayID = 1062 }; --B'lok the Shadow Mutt
	[51049] = { zoneID = 0, displayID = 1062 }; --Bongo
	[51050] = { zoneID = 0, displayID = 1062 }; --Bonobus
	[51051] = { zoneID = 0, displayID = 1062 }; --Jumpi the Swinger
	[51054] = { zoneID = 0, displayID = 1062 }; --Dak the Hardened
	[51055] = { zoneID = 0, displayID = 1062 }; --Clattershell
	[51056] = { zoneID = 0, displayID = 1062 }; --Opterax
	[51064] = { zoneID = 0, displayID = 1062 }; --Glitterweb
	[51072] = { zoneID = 0, displayID = 1062 }; --Vulpos
	[51074] = { zoneID = 0, displayID = 1062 }; --Alope
	[51267] = { zoneID = 0, displayID = 37149 }; --Aeonaxx <Mate of Aeosera>
	[5367] = { zoneID = 0, displayID = 10875 }; --Scillia Daggerquil
	[5399] = { zoneID = 0, displayID = 6695 }; --Veyzhak the Cannibal
	[5400] = { zoneID = 0, displayID = 6693 }; --Zekkis
	[56079] = { zoneID = 0, displayID = 37737 }; --Little Samras
	[5789] = { zoneID = 0, displayID = 4314 }; --Serra Mountainhome <Ironforge Surveyor>
	[5790] = { zoneID = 0, displayID = 4316 }; --Lizzle Sprysprocket <Ironforge Surveyor>
	[5793] = { zoneID = 0, displayID = 4433 }; --Captain Armistice <Alliance Peacekeeper>
	[5794] = { zoneID = 0, displayID = 4431 }; --Thurmonde the Devout <Alliance Peacekeeper>
	[5795] = { zoneID = 0, displayID = 4432 }; --Grash Thunderbrew <Alliance Peacekeeper>
	[5796] = { zoneID = 0, displayID = 1006 }; --Ben <Grash Thunderbrew's Pet>
	[59071] = { zoneID = 0, displayID = 46293 }; --D'uuurps <Minion of N'Zoth>
	[63509] = { zoneID = 0, displayID = 43632 }; --Wulon <The Granite Sentinel>
	[64669] = { zoneID = 0, displayID = 43631 }; --Wulon <The Granite Sentinel>
	[64670] = { zoneID = 0, displayID = 45429 }; --Wulon <The Granite Sentinel>
	[64671] = { zoneID = 0, displayID = 45430 }; --Wulon <The Granite Sentinel>
	[65631] = { zoneID = 0, displayID = 44483 }; --Doctor Theolen Krastinov <The Butcher>
	[68315] = { zoneID = 0, displayID = 46547 }; --Quest Gnome
	[73242] = { zoneID = 0, displayID = 44343 }; --Cah Silentsky
	[73854] = { zoneID = 0, displayID = 39588, event = 4 }; --Cranegnasher
	[8206] = { zoneID = 0, displayID = 2533 }; --Soul of Tanaris
	[9417] = { zoneID = 0, displayID = 8574 }; --Sleeping Dragon
	[5808] = { zoneID = 1, artID = { 2 }, x = 5180, y = 7660, overlay = { "4640-7840","4640-7960","4740-7740","4760-7860","4780-8040","4880-7900","5000-7840","5000-8060","5180-7660","5180-7980","5200-7800" }, displayID = 9444 }; --Warlord Kolkanis
	[5809] = { zoneID = 1, artID = { 2 }, x = 5920, y = 5820, overlay = { "5920-5820" }, displayID = 33165 }; --Sergeant Curtis
	[5822] = { zoneID = {
		[1] = { x = 5260, y = 0880, artID = { 2 }, overlay = { "5260-0880" } };
		[5] = { x = 2120, y = 6080, artID = { 7 }, overlay = { "2120-6080","2180-5760","2220-5880","2360-6240","3800-4020","5580-2380","5820-2760" } };
	}, displayID = 4594 }; --Felweaver Scornn
	[5823] = { zoneID = 1, artID = { 2 }, x = 3540, y = 4600, overlay = { "3440-4460","3480-4340","3540-4600","3640-4440","3720-4580","3720-4760","3800-4460","3840-4340","3840-4680","3880-4860","3960-4520","3980-4400" }, displayID = 2491 }; --Death Flayer
	[5824] = { zoneID = 1, artID = { 2 }, x = 4226, y = 4034, overlay = { "3860-5380","4240-3860","4420-4980","4226-4034" }, displayID = 1346 }; --Captain Flat Tusk <Captain of the Battleguard>
	[5826] = { zoneID = 1, artID = { 2 }, x = 4263, y = 3782, overlay = { "4320-3940","4340-4980","4700-4940","4263-3782" }, displayID = 6113 }; --Geolord Mottle
	[3058] = { zoneID = 7, artID = { 8 }, x = 5783, y = 6744, overlay = { "4800-6860","5040-6660","5040-6840","5140-6520","5180-6840","5240-6380","5320-6220","5380-6900","5460-6800","5480-6240","5480-7000","5620-6320","5620-7000","5700-6580","5780-6760","5780-6900" }, displayID = 10916 }; --Arra'chea
	[3068] = { zoneID = 7, artID = { 8 }, x = 4204, y = 4508, overlay = { "4240-4540","4360-4100","4440-4740","4560-4720","4680-4680","4720-4060","4880-4340","5000-4260","4980-4100" }, displayID = 1961 }; --Mazzranache
	[43613] = { zoneID = 7, artID = { 8 }, x = 3375, y = 3693, overlay = { "3380-3700" }, displayID = 33430 }; --Doomsayer Wiserunner <Twilight's Hammer>
	[43720] = { zoneID = {
		[7] = { x = 4295, y = 8914, artID = { 8 }, overlay = { "4295-8914" } };
		[462] = { x = 2120, y = 7100, artID = { 474 }, overlay = { "2040-7060" } };
	}, displayID = 52724 }; --"Pokey" Thornmantle
	[5785] = { zoneID = 7, artID = { 8 }, x = 3199, y = 2444, overlay = { "3200-2440","5240-1180","5340-1260" }, displayID = 2163 }; --Sister Hatelash
	[5786] = { zoneID = 7, artID = { 8 }, x = 4840, y = 7040, overlay = { "4840-7040","5320-7120" }, displayID = 488 }; --Snagglespear
	[5787] = { zoneID = 7, artID = { 8 }, x = 6040, y = 4740, overlay = { "6040-4740" }, displayID = 610 }; --Enforcer Emilgund
	[5807] = { zoneID = 7, artID = { 8 }, x = 4960, y = 2200, overlay = { "4960-2200","4980-2500","5000-2320","5040-2620","5080-2160","5100-2840","5220-2120","5340-1940","5340-2960","5440-2020","5540-2400","5580-2560" }, displayID = 1973 }; --The Rake
	[3270] = { zoneID = 10, artID = { 11 }, x = 6142, y = 5332, overlay = { "5640-5160","5820-4960","6080-5240" }, displayID = 6112 }; --Elder Mystic Razorsnout
	[3295] = { zoneID = 10, artID = { 11 }, x = 5692, y = 1931, overlay = { "5740-1920","5760-2040" }, displayID = 360 }; --Sludge Anomaly
	[3398] = { zoneID = 10, artID = { 11 }, x = 4003, y = 7454, overlay = { "4000-7460" }, displayID = 1397 }; --Gesharahan
	[3470] = { zoneID = 10, artID = { 11 }, x = 4131, y = 3917, overlay = { "4120-3920","4220-3840" }, displayID = 5047 }; --Rathorian
	[3652] = { zoneID = {
		[10] = { x = 4275, y = 6364, artID = { 11 }, overlay = { "4275-6364" } };
		[11] = { x = 6040, y = 3859, artID = { 12 }, overlay = { "6040-3860","6040-4060","6160-4120","6200-3880","6240-3740" } };
	}, displayID = 1092 }; --Trigore the Lasher
	[3672] = { zoneID = {
		[10] = { x = 4266, y = 6509, artID = { 11 }, overlay = { "4266-6509" } };
		[11] = { x = 6003, y = 4967, artID = { 12 }, overlay = { "6760-5740","6820-5900","7080-5780","7400-2560","7800-4000","7920-3920" } };
	}, displayID = 4212 }; --Boahn <Druid of the Fang>
	[5797] = { zoneID = 10, artID = { 11 }, x = 5080, y = 4820, overlay = { "4380-4140","4380-6160","4420-4400","4420-6000","4440-5860","4460-4260","4500-6420","4540-4140","4540-4420","4540-5120","4540-6120","4540-6620","4540-7000","4540-7320","4560-5820","4560-6280","4580-7760","4580-8140","4600-6740","4600-6880","4600-7460","4620-4800","4620-6020","4620-7220","4640-4280","4640-4600","4640-8020","4660-7080","4680-5660","4680-6600","4680-7660","4700-5900","4720-5040","4720-6180","4720-7340","4720-7520","4740-6380","4760-5480","4760-7180","4800-8040","4820-4220","4820-5340","4820-6040","4840-4660","4840-5120","4840-5620","4840-5760","4840-7720","4840-7860","4860-5920","4860-6280","4860-7520","4880-4980","4880-6160","4900-5440","4940-4800","4960-5280","4980-5560","5000-4140","5000-4320","5000-4620","5020-4480","5020-5780","5020-7740","5080-3760","5080-4820" }, displayID = 4345 }; --Aean Swiftriver <Alliance Outrunner>
	[5798] = { zoneID = 10, artID = { 11 }, x = 4960, y = 5100, overlay = { "4440-5900","4480-4320","4480-6120","4500-6400","4520-4160","4520-7100","4540-4460","4540-4720","4540-6240","4540-6640","4560-5840","4580-7740","4600-4260","4600-6760","4600-6900","4600-7360","4600-7620","4600-7880","4620-6000","4620-8220","4640-4580","4640-4880","4640-5020","4640-8080","4660-6320","4660-7140","4680-5880","4680-6560","4700-5200","4720-6160","4720-7540","4740-4260","4740-5560","4740-6420","4740-7360","4760-5080","4760-7220","4780-4800","4800-7680","4800-8020","4820-6040","4820-7000","4840-5300","4840-5480","4840-5740","4840-5920","4840-6240","4860-4260","4860-6360","4860-7840","4880-4680","4880-5620","4900-4900","4940-6140","4960-5100","4960-5500","5000-4320","5000-5820","5040-4500","5060-4660","5080-4800" }, displayID = 4346 }; --Thora Feathermoon <Alliance Outrunner>
	[5799] = { zoneID = 10, artID = { 11 }, x = 4420, y = 6020, overlay = { "4360-6080","4400-4780","4440-4260","4480-5880","4480-6100","4500-6400","4520-4160","4540-4420","4540-4720","4540-4860","4540-6620","4540-7000","4540-8520","4560-6280","4600-5980","4600-6100","4600-6740","4600-6880","4600-7360","4600-7980","4620-4240","4620-8180","4640-4600","4640-5020","4640-5800","4640-7220","4640-7580","4640-7820","4660-4840","4680-6300","4680-6620","4720-5980","4720-6160","4720-7460","4760-5540","4760-6480","4780-8080","4800-4260","4800-7640","4820-4940","4820-5160","4820-6340","4840-5280","4840-5640","4840-5760","4840-5900","4840-7800","4840-7940","4860-4140","4880-6180","4920-4280","4940-4800","4940-5060","4960-5380","4960-5500","4960-5780","4980-4660","4980-6040","5000-6160","5020-4420" }, displayID = 4348 }; --Hannah Bladeleaf <Alliance Outrunner>
	[5800] = { zoneID = 10, artID = { 11 }, x = 4700, y = 7680, overlay = { "4340-5980","4460-5880","4480-4200","4480-6100","4500-6400","4520-6240","4540-4420","4540-4840","4540-6640","4580-4120","4580-5900","4600-6100","4600-6800","4600-7040","4600-7360","4620-4700","4620-7160","4620-8180","4640-4260","4640-7820","4660-4840","4660-6640","4680-4440","4680-6300","4680-8020","4700-5040","4700-5920","4700-7680","4720-6160","4720-7340","4740-5500","4740-5760","4740-6420","4740-7460","4760-8220","4780-8100","4820-4220","4820-4920","4820-5340","4840-5220","4840-5620","4840-5920","4840-6240","4840-7720","4840-7940","4860-5080","4860-5800","4860-6360","4920-5480","4940-4800","4940-6080","4960-4920","4960-5180","4980-4680","5020-4200","5020-4320","5020-4480","5020-7760" }, displayID = 4347 }; --Marcus Bel <Alliance Outrunner>
	[5827] = { zoneID = 10, artID = { 11 }, x = 4940, y = 5620, overlay = { "4400-7920","4440-7540","4480-7740","4500-8600","4540-7340","4560-5820","4560-7880","4600-7580","4620-6780","4620-7120","4620-7460","4620-8120","4640-6620","4680-7280","4740-6240","4740-6400","4760-5880","4760-6540","4780-6100","4820-5620","4860-6300","4900-5880","4900-6020","4940-5620" }, displayID = 1308 }; --Brontus
	[5828] = { zoneID = 10, artID = { 11 }, x = 6720, y = 6400, overlay = { "6720-6400" }, displayID = 4424 }; --Humar the Pridelord
	[5830] = { zoneID = 10, artID = { 11 }, x = 2540, y = 3320, overlay = { "2540-3320" }, displayID = 10876 }; --Sister Rathtalon
	[5831] = { zoneID = 10, artID = { 11 }, x = 6320, y = 6340, overlay = { "6320-6340","6480-6040" }, displayID = 6084 }; --Swiftmane
	[5835] = { zoneID = 10, artID = { 11 }, x = 5698, y = 1999, overlay = { "5720-1940","5720-2060" }, displayID = 4593 }; --Foreman Grills
	[5836] = { zoneID = 10, artID = { 11 }, x = 5801, y = 2062, overlay = { "5800-2040" }, displayID = 7049 }; --Engineer Whirleygig
	[5837] = { zoneID = {
		[10] = { x = 4014, y = 4563, artID = { 11 }, overlay = { "3180-4840","3240-5240","4000-4560" } };
		[199] = { x = 4060, y = 0880, artID = { 204 }, overlay = { "4060-0880" } };
	}, displayID = 4874 }; --Stonearm
	[5838] = { zoneID = 10, artID = { 11 }, x = 5224, y = 7575, overlay = { "5140-8340","5180-7540","5380-8700","5780-8220","5840-7760" }, displayID = 9448 }; --Brokespear
	[5841] = { zoneID = 10, artID = { 11 }, x = 5900, y = 8060, overlay = { "5900-8060","5920-7940" }, displayID = 9533 }; --Rocklance
	[5842] = { zoneID = 10, artID = { 11 }, x = 6243, y = 2637, overlay = { "6340-3600","6243-2637" }, displayID = 1337 }; --Takk the Leaper
	[5865] = { zoneID = 10, artID = { 11 }, x = 4520, y = 5280, overlay = { "4520-5280","4540-3300","4880-5180" }, displayID = 1043 }; --Dishu
	[7895] = { zoneID = 10, artID = { 11 }, x = 4840, y = 9540, overlay = { "4580-8760","4780-9060","4840-9540","4860-9400" }, displayID = 7043 }; --Ambassador Bloodrage
	[2598] = { zoneID = 14, artID = { 15 }, x = 1920, y = 6459, overlay = { "1920-6460" }, displayID = 4027 }; --Darbel Montrose
	[2600] = { zoneID = 14, artID = { 15 }, x = 2740, y = 2780, overlay = { "2740-2780" }, displayID = 4026 }; --Singer
	[2601] = { zoneID = 14, artID = { 15 }, x = 1400, y = 6740, overlay = { "1400-6740","1420-6940","1500-6840" }, displayID = 20018 }; --Foulbelly
	[2602] = { zoneID = 14, artID = { 15 }, x = 1800, y = 3120, overlay = { "1800-3120","1960-3060","1840-3000" }, displayID = 32547 }; --Ruul Onestone
	[2603] = { zoneID = 14, artID = { 15 }, x = 2420, y = 4440, overlay = { "2420-4440" }, displayID = 25189 }; --Kovork
	[2604] = { zoneID = 14, artID = { 15 }, x = 4660, y = 7719, overlay = { "4660-7720","4700-7500","4780-7680","4780-7880" }, displayID = 20017 }; --Molok the Crusher
	[2605] = { zoneID = 14, artID = { 15 }, x = 6240, y = 8000, overlay = { "6240-8000" }, displayID = 28239 }; --Zalas Witherbark <Warband Leader>
	[2606] = { zoneID = 14, artID = { 15 }, x = 6780, y = 6640, overlay = { "6780-6640" }, displayID = 28818 }; --Nimar the Slayer <Warband Leader>
	[2609] = { zoneID = 14, artID = { 15 }, x = 7940, y = 2940, overlay = { "7940-2940" }, displayID = 27190 }; --Geomancer Flintdagger
	[2779] = { zoneID = 14, artID = { 15 }, x = 1400, y = 8660, overlay = { "1400-8660","1420-9240","1540-8880","1620-8700","1620-9320","1640-9120" }, displayID = 6763 }; --Prince Nazjak
	[50337] = { zoneID = 14, artID = { 15 }, x = 2260, y = 8760, overlay = { "2100-8760","2180-8620","2220-8780" }, displayID = 46227, event = 1 }; --Cackle
	[50770] = { zoneID = {
		[14] = { x = 2200, y = 1400, artID = { 15 }, overlay = { "2160-1540","2200-1400" } };
		[25] = { x = 7710, y = 6000, artID = { 26 }, overlay = { "7700-6000" } };
	}, displayID = 46232, event = 2 }; --Zorn
	[50804] = { zoneID = 14, artID = { 15 }, x = 3720, y = 6360, overlay = { "3540-6180","3600-6340","3660-6140","3720-6360" }, displayID = 10827, event = 1 }; --Ripwing
	[50865] = { zoneID = 14, artID = { 15 }, x = 4320, y = 3480, overlay = { "4180-3440","4180-3560","4320-3480" }, displayID = 21825, event = 1 }; --Saurix
	[50891] = { zoneID = 14, artID = { 15 }, x = 4859, y = 3579, overlay = { "4740-3380","4820-3660","4840-3520" }, displayID = 46235, event = 2 }; --Boros
	[50940] = { zoneID = 14, artID = { 15 }, x = 5660, y = 5660, overlay = { "5560-5760","5640-5640" }, displayID = 20814, event = 2 }; --Swee
	[51040] = { zoneID = 14, artID = { 15 }, x = 2680, y = 2720, overlay = { "2520-2760","2680-2720" }, displayID = 30222, event = 1 }; --Snuffles
	[51063] = { zoneID = 14, artID = { 15 }, x = 4859, y = 8140, overlay = { "4780-8220" }, displayID = 46226, event = 1 }; --Phalanax
	[51067] = { zoneID = 14, artID = { 15 }, x = 3060, y = 6140, overlay = { "3000-6100","3040-6340" }, displayID = 36634, event = 2 }; --Glint
	[14224] = { zoneID = 15, artID = { 16 }, x = 7800, y = 3259, overlay = { "7800-3260","7840-3140" }, displayID = 6889 }; --7:XT <Long Distance Recovery Unit>
	[2744] = { zoneID = 15, artID = { 16 }, x = 3940, y = 2440, overlay = { "3940-2440" }, displayID = 4937 }; --Shadowforge Commander
	[2749] = { zoneID = 15, artID = { 16 }, x = 0940, y = 4880, overlay = { "0940-4880","2700-3780" }, displayID = 10802 }; --Barricade
	[2751] = { zoneID = 15, artID = { 16 }, x = 4840, y = 2620, overlay = { "4840-2620" }, displayID = 5747 }; --War Golem
	[2752] = { zoneID = 15, artID = { 16 }, x = 1580, y = 2979, overlay = { "1580-2980" }, displayID = 37714 }; --Rumbler
	[2753] = { zoneID = 15, artID = { 16 }, x = 3940, y = 5820, overlay = { "3940-5820","3940-5940","4060-6020","4080-5880" }, displayID = 9372 }; --Barnabus
	[2754] = { zoneID = 15, artID = { 16 }, x = 0800, y = 6640, overlay = { "0800-6640","0880-6520" }, displayID = 35463 }; --Anathemus
	[2850] = { zoneID = 15, artID = { 16 }, x = 2239, y = 6080, overlay = { "2240-6080" }, displayID = 21192 }; --Broken Tooth
	[2931] = { zoneID = 15, artID = { 16 }, x = 5500, y = 4320, overlay = { "5500-4320","5540-4440","5540-4580","5660-4340" }, displayID = 37577 }; --Zaricotl
	[50726] = { zoneID = 15, artID = { 16 }, x = 3240, y = 3420, overlay = { "3200-3520" }, displayID = 46250, event = 2 }; --Kalixx
	[50728] = { zoneID = 15, artID = { 16 }, x = 7019, y = 5340, overlay = { "6940-5360" }, displayID = 20308, event = 1 }; --Deathstrike
	[50731] = { zoneID = 15, artID = { 16 }, x = 5080, y = 7260, overlay = { "5040-7240" }, displayID = 17062, event = 2 }; --Needlefang
	[50838] = { zoneID = 15, artID = { 16 }, x = 5859, y = 6060, overlay = { "5820-6040" }, displayID = 46251, event = 1 }; --Tabbs
	[51000] = { zoneID = 15, artID = { 16 }, x = 7219, y = 2740, overlay = { "7020-2960","7180-2800" }, displayID = 46248, event = 2 }; --Blackshell the Impenetrable
	[51007] = { zoneID = 15, artID = { 16 }, x = 2760, y = 3800, overlay = { "2640-3800","2760-3800" }, displayID = 46252, event = 2 }; --Serkett
	[51018] = { zoneID = 15, artID = { 16 }, x = 5180, y = 3420, overlay = { "5140-3420" }, displayID = 19996, event = 2 }; --Zormus
	[51021] = { zoneID = 15, artID = { 16 }, x = 2320, y = 3760, overlay = { "2180-3740","2320-3720" }, displayID = 20910, event = 1 }; --Vorticus
	[7057] = { zoneID = 15, artID = { 16 }, x = 4540, y = 1260, overlay = { "4540-1260","4760-1400" }, displayID = 7220 }; --Digmaster Shovelphlange
	[45257] = { zoneID = 17, artID = { 18 }, x = 6065, y = 3505, overlay = { "6040-2920","6065-3505" }, displayID = 6786 }; --Mordak Nightbender
	[45258] = { zoneID = 17, artID = { 18 }, x = 6065, y = 7523, overlay = { "6040-7540" }, displayID = 5029 }; --Cassia the Slitherqueen
	[45260] = { zoneID = 17, artID = { 18 }, x = 3100, y = 7060, overlay = { "3100-6980" }, displayID = 12929 }; --Blackleaf
	[45262] = { zoneID = 17, artID = { 18 }, x = 3240, y = 4440, overlay = { "3200-4460" }, displayID = 19949 }; --Narixxus the Doombringer
	[7846] = { zoneID = 17, artID = { 18 }, x = 5120, y = 4820, overlay = { "5120-4820","5120-5040","5140-4620","5160-4460","5160-5200","5160-5380","5240-4920","5280-4580","5300-4420","5320-5400","5440-4340","5440-4500","5500-5420","5580-4380","5620-4540","5640-5340","5680-4680","5720-4840","5720-5220","5780-5000" }, displayID = 6378 }; --Teremus the Devourer
	[8296] = { zoneID = 17, artID = { 18 }, x = 4640, y = 2620, overlay = { "4640-2620" }, displayID = 11562 }; --Mojo the Twisted
	[8297] = { zoneID = 17, artID = { 18 }, x = 4640, y = 3920, overlay = { "4640-3920" }, displayID = 11564 }; --Magronos the Unyielding
	[8298] = { zoneID = 17, artID = { 18 }, x = 7353, y = 5529, overlay = { "7340-5500" }, displayID = 10920 }; --Akubar the Seer
	[8299] = { zoneID = 17, artID = { 18 }, x = 6568, y = 4300, overlay = { "5940-3540","5940-3660","5940-3820","6000-3420","6080-4000","6160-3260","6200-3660","6200-4020","6320-4020","6340-3300","6440-3800","6460-3360","6460-3600","6460-3940","6568-4300" }, displayID = 37536 }; --Spiteflayer
	[8300] = { zoneID = 17, artID = { 18 }, x = 4874, y = 3192, overlay = { "4900-3440","4920-3560","4874-3192" }, displayID = 34324 }; --Ravage
	[8301] = { zoneID = 17, artID = { 18 }, x = 4720, y = 1380, overlay = { "4720-1380" }, displayID = 15433 }; --Clack the Reaver
	[8302] = { zoneID = 17, artID = { 18 }, x = 5219, y = 2739, overlay = { "5120-2720","5160-2560","5240-2740","5240-2900","5340-2640" }, displayID = 46053 }; --Deatheye
	[8303] = { zoneID = 17, artID = { 18 }, x = 5519, y = 3907, overlay = { "5440-3940","5520-3840","5540-4020" }, displayID = 24741 }; --Grunter
	[8304] = { zoneID = 17, artID = { 18 }, x = 3660, y = 2820, overlay = { "3660-2820","3700-2940" }, displayID = 7844 }; --Dreadscorn
	[10356] = { zoneID = 18, artID = { 19 }, x = 4599, y = 4847, overlay = { "4540-4880","4660-5020" }, displayID = 37773 }; --Bayne
	[10357] = { zoneID = 18, artID = { 19 }, x = 5715, y = 5189, overlay = { "5220-5640","5340-5740","5360-5860","5420-5620","5715-5189" }, displayID = 16053 }; --Ressan the Needler
	[10358] = { zoneID = 18, artID = { 19 }, x = 7700, y = 5980, overlay = { "7700-5980" }, displayID = 16254 }; --Fellicent's Shade
	[10359] = { zoneID = 18, artID = { 19 }, x = 8440, y = 4920, overlay = { "8440-4920" }, displayID = 22185 }; --Sri'skulk
	[1531] = { zoneID = 18, artID = { 19 }, x = 4500, y = 3760, overlay = { "4500-3760","4860-3420","4900-3540","4920-3260","5320-4540","5320-4840" }, displayID = 985 }; --Lost Soul
	[1533] = { zoneID = 18, artID = { 19 }, x = 4380, y = 3140, overlay = { "4380-3140","4380-3380","4500-3160","4520-3560","4640-3040","4660-3160","4740-3260","4740-3500","4820-3360" }, displayID = 9534 }; --Tormented Spirit
	[1910] = { zoneID = 18, artID = { 19 }, x = 3590, y = 4281, overlay = { "3580-4300" }, displayID = 5243 }; --Muad
	[1911] = { zoneID = 18, artID = { 19 }, x = 7240, y = 2580, overlay = { "7240-2580" }, displayID = 5293 }; --Deeb
	[1936] = { zoneID = 18, artID = { 19 }, x = 3410, y = 5207, overlay = { "3420-5200","3720-4920","3800-5140" }, displayID = 3535 }; --Farmer Solliden
	[50763] = { zoneID = 18, artID = { 19 }, x = 3800, y = 5200, overlay = { "3800-5200" }, displayID = 67596, event = 1 }; --Shadowstalker
	[50803] = { zoneID = 18, artID = { 19 }, x = 3259, y = 4640, overlay = { "3120-4640","3220-4720","3220-4540" }, displayID = 37992, event = 2 }; --Bonechewer
	[50908] = { zoneID = 18, artID = { 19 }, x = 4280, y = 2840, overlay = { "4240-2840" }, displayID = 46667, event = 2 }; --Nighthowl
	[50930] = { zoneID = 18, artID = { 19 }, x = 4759, y = 7019, overlay = { "4680-6920","4760-7020" }, displayID = 70192, event = 1 }; --Hibernus the Sleeper
	[51044] = { zoneID = 18, artID = { 19 }, x = 5780, y = 3300, overlay = { "5780-3300" }, displayID = 46668, event = 1 }; --Plague
	[12431] = { zoneID = 21, artID = { 22 }, x = 5668, y = 2420, overlay = { "5600-2300","5620-2520","5720-1600","5740-1740","5860-1500","6000-0900" }, displayID = 11413 }; --Gorefang
	[12432] = { zoneID = 21, artID = { 22 }, x = 5360, y = 5260, overlay = { "5080-6480","5100-6240","5120-6360","5140-6600","5240-5320","5260-6440","5320-5140","5360-5260","5440-6160","5520-4960","5540-6040","5540-6260","5660-6000","5660-6400" }, displayID = 982 }; --Old Vicejaw
	[12433] = { zoneID = 21, artID = { 22 }, x = 3460, y = 1560, overlay = { "3460-1560","3460-1760","3540-1420","3620-1520","3660-1700","3800-1580","3840-1420" }, displayID = 22185 }; --Krethis the Shadowspinner
	[1920] = { zoneID = 21, artID = { 22 }, x = 6360, y = 6540, overlay = { "6280-6220","6300-6360","6340-6520" }, displayID = 3589 }; --Ambermill Spellscribe
	[1944] = { zoneID = 21, artID = { 22 }, x = 6520, y = 2040, overlay = { "6340-2220","6420-2460","6440-2340","6480-2220","6520-2040","6560-1920","6560-3020","6600-2700","6640-2540","6680-2340","6760-2440","6820-2560" }, displayID = 10850 }; --Rot Hide Bruiser
	[1948] = { zoneID = 21, artID = { 22 }, x = 6520, y = 2500, overlay = { "6500-2320","6520-2500","6620-2700" }, displayID = 965 }; --Snarlmane
	[2283] = { zoneID = 21, artID = { 22 }, x = 5760, y = 7140, overlay = { "5720-7080" }, displayID = 1019 }; --Ravenclaw Regent
	[46981] = { zoneID = 21, artID = { 22 }, x = 5320, y = 2480, overlay = { "5120-2600","5180-2780","5240-2520","5240-2640","5300-2800" }, displayID = 915 }; --Nightlash
	[46992] = { zoneID = 21, artID = { 22 }, x = 4336, y = 5066, overlay = { "4320-5080" }, displayID = 35373 }; --Berard the Moon-Crazed
	[47003] = { zoneID = 21, artID = { 22 }, x = 4850, y = 2440, overlay = { "4840-2420","4880-2540" }, displayID = 35381 }; --Bolgaff <The Mad Hunter>
	[47008] = { zoneID = 21, artID = { 22 }, x = 5940, y = 3340, overlay = { "5940-3340" }, displayID = 10834 }; --Fenwick Thatros
	[47009] = { zoneID = 21, artID = { 22 }, x = 6168, y = 6309, overlay = { "5700-6420","5740-6260","5820-6620","5900-6260","5980-6140","5980-6540","6080-6320","6120-6560","6120-6680","6180-6420","6260-6620","6180-6100","6200-6800" }, displayID = 35383 }; --Aquarius the Unbound
	[47012] = { zoneID = 21, artID = { 22 }, x = 4694, y = 6994, overlay = { "4680-6980" }, displayID = 26799 }; --Effritus
	[47015] = { zoneID = 21, artID = { 22 }, x = 5660, y = 3200, overlay = { "4560-3000","4640-2480","4640-2780","4680-2340","4840-2100","4840-2300","4840-3420","4940-3520","5020-2000","5280-1920","5400-4280","5420-4700","5420-5400","5440-2080","5440-6420","5460-4840","5460-5160","5500-2300","5500-3820","5500-4500","5500-7380","5520-3700","5520-7100","5520-7580","5540-3140","5560-6140","5580-3300","5580-4100","5620-2640","5620-2880","5620-3440","5620-7860","5660-3200" }, displayID = 563 }; --Lost Son of Arugal
	[47023] = { zoneID = 21, artID = { 22 }, x = 5018, y = 6005, overlay = { "5020-6000" }, displayID = 4430 }; --Thule Ravenclaw
	[50330] = { zoneID = 21, artID = { 22 }, x = 6065, y = 0676, overlay = { "6020-0680","6160-0640" }, displayID = 34130, event = 1 }; --Kree
	[50814] = { zoneID = 21, artID = { 22 }, x = 4921, y = 6832, overlay = { "4920-6820" }, displayID = 23481, event = 1 }; --Corpsefeeder
	[50949] = { zoneID = 21, artID = { 22 }, x = 6400, y = 4660, overlay = { "6400-4660" }, displayID = 4714, event = 1 }; --Finn's Gambit
	[51026] = { zoneID = 21, artID = { 22 }, x = 5000, y = 2940, overlay = { "4920-2940" }, displayID = 46569, event = 2 }; --Gnath
	[51037] = { zoneID = 21, artID = { 22 }, x = 6020, y = 4040, overlay = { "5720-4240","5840-4100","5960-4080" }, displayID = 33998, event = 2 }; --Lost Gilnean Wardog
	[1837] = { zoneID = 22, artID = { 23 }, x = 6922, y = 4955, overlay = { "6900-4940" }, displayID = 10355 }; --Scarlet Judge
	[1838] = { zoneID = 22, artID = { 23 }, x = 4500, y = 5200, overlay = { "4500-5200" }, displayID = 10343 }; --Scarlet Interrogator
	[1839] = { zoneID = 22, artID = { 23 }, x = 4100, y = 5200, overlay = { "4100-5200","4160-5320" }, displayID = 10342 }; --Scarlet High Clerist
	[1841] = { zoneID = 22, artID = { 23 }, x = 5080, y = 4040, overlay = { "5080-4040" }, displayID = 10344 }; --Scarlet Executioner
	[1847] = { zoneID = 22, artID = { 23 }, x = 5400, y = 8040, overlay = { "5400-8040" }, displayID = 30656 }; --Foulmane
	[1848] = { zoneID = 22, artID = { 23 }, x = 6536, y = 4761, overlay = { "6540-4740" }, displayID = 10356 }; --Lord Maldazzar
	[1849] = { zoneID = 22, artID = { 23 }, x = 6380, y = 5640, overlay = { "6380-5640" }, displayID = 30520 }; --Dreadwhisper
	[1850] = { zoneID = 22, artID = { 23 }, x = 6940, y = 7300, overlay = { "6940-7300" }, displayID = 10612 }; --Putridius
	[1851] = { zoneID = 22, artID = { 23 }, x = 6300, y = 8280, overlay = { "6300-8280","6400-8360" }, displayID = 9013 }; --The Husk
	[1885] = { zoneID = 22, artID = { 23 }, x = 5388, y = 4408, overlay = { "5380-4420" }, displayID = 10346 }; --Scarlet Smith
	[2447] = { zoneID = {
		[22] = { x = 4400, y = 8580, artID = { 23 }, overlay = { "4360-8440","4400-8580","4480-8140","5080-9440","5340-7460","5760-8240" } };
		[25] = { x = 6920, y = 1600, artID = { 26 }, overlay = { "5060-5960","5160-5660","5520-1000","6000-2040","6000-2940","6260-1720","6340-1520","6380-0560","6380-0880","6500-0580","6500-0740","6540-1920","6620-0740","6640-0940","6640-2200","6800-1080","6860-1340","6920-1600","7000-0960","7120-0800" } };
	}, displayID = 6371 }; --Narillasanz
	[50345] = { zoneID = 22, artID = { 23 }, x = 3191, y = 7229, overlay = { "3100-7180","3200-7300" }, displayID = 21133, event = 1 }; --Alit
	[50778] = { zoneID = 22, artID = { 23 }, x = 5220, y = 6840, overlay = { "5120-7020","5220-6840" }, displayID = 42742, event = 2 }; --Ironweb
	[50809] = { zoneID = 22, artID = { 23 }, x = 3579, y = 5259, overlay = { "3480-5240","3480-5380" }, displayID = 46740, event = 1 }; --Heress
	[50906] = { zoneID = 22, artID = { 23 }, x = 5259, y = 2760, overlay = { "5220-2720" }, displayID = 37857, event = 1 }; --Mutilax
	[50922] = { zoneID = 22, artID = { 23 }, x = 5820, y = 6140, overlay = { "5600-6260","5700-6180","5700-6340","5720-6060","5820-6140" }, displayID = 35394, event = 2 }; --Warg
	[50931] = { zoneID = 22, artID = { 23 }, x = 6622, y = 5534, overlay = { "6600-5540" }, displayID = 70191, event = 2 }; --Mange
	[50937] = { zoneID = 22, artID = { 23 }, x = 4360, y = 3600, overlay = { "4300-3440","4320-3560" }, displayID = 6122, event = 2 }; --Hamhide
	[51029] = { zoneID = 22, artID = { 23 }, x = 6200, y = 7360, overlay = { "6140-7280" }, displayID = 23998, event = 2 }; --Parasitus
	[51031] = { zoneID = 22, artID = { 23 }, x = 6260, y = 4720, overlay = { "6220-4760" }, displayID = 46741, event = 1 }; --Tracker
	[51058] = { zoneID = 22, artID = { 23 }, x = 6260, y = 3540, overlay = { "6240-3520" }, displayID = 34900, event = 1 }; --Aphis
	[10817] = { zoneID = 23, artID = { 24 }, x = 3599, y = 6202, overlay = { "3580-6200" }, displayID = 10374 }; --Duggan Wildhammer
	[10818] = { zoneID = 23, artID = { 24 }, x = 6540, y = 2440, overlay = { "6540-2440" }, displayID = 6380 }; --Death Knight Soulbearer
	[10819] = { zoneID = 23, artID = { 24 }, x = 3570, y = 2149, overlay = { "3540-2120" }, displayID = 6380 }; --Baron Bloodbane
	[10820] = { zoneID = 23, artID = { 24 }, x = 2706, y = 1325, overlay = { "2640-1160","2700-1300","2780-1160" }, displayID = 6380 }; --Duke Ragereaver
	[10821] = { zoneID = 23, artID = { 24 }, x = 7900, y = 3900, overlay = { "7900-3900" }, displayID = 10709 }; --Hed'mush the Rotting
	[10823] = { zoneID = 23, artID = { 24 }, x = 6400, y = 1240, overlay = { "6400-1240" }, displayID = 10443 }; --Zul'Brin Warpbranch
	[10824] = { zoneID = 23, artID = { 24 }, x = 4733, y = 2133, overlay = { "4720-2140" }, displayID = 19824 }; --Death-Hunter Hawkspear
	[10825] = { zoneID = 23, artID = { 24 }, x = 2580, y = 6800, overlay = { "2580-6800" }, displayID = 7616 }; --Gish the Unmoving
	[10826] = { zoneID = 23, artID = { 24 }, x = 3693, y = 4411, overlay = { "3320-4740","3340-4880","3400-4620","3440-4480","3520-4720","3560-4860","3620-4340","3640-4720","3720-4540" }, displayID = 27984 }; --Lord Darkscythe
	[10827] = { zoneID = 23, artID = { 24 }, x = 1713, y = 7841, overlay = { "1700-7840","1800-7700","1880-7860" }, displayID = 37768 }; --Deathspeaker Selendre <Cult of the Damned>
	[10828] = { zoneID = 23, artID = { 24 }, x = 7740, y = 7219, overlay = { "7740-7220" }, displayID = 37769 }; --Lynnia Abbendis <The Fallen Hope>
	[16184] = { zoneID = 23, artID = { 24 }, x = 0420, y = 3600, overlay = { "0420-3600" }, displayID = 14698 }; --Nerubian Overseer
	[1843] = { zoneID = 23, artID = { 24 }, x = 5520, y = 6860, overlay = { "5520-6860" }, displayID = 37598 }; --Foreman Jerris
	[1844] = { zoneID = 23, artID = { 24 }, x = 5380, y = 6840, overlay = { "5380-6840" }, displayID = 37600 }; --Foreman Marcrid
	[50775] = { zoneID = 23, artID = { 24 }, x = 1300, y = 7140, overlay = { "1160-7020","1220-7160" }, displayID = 46518, event = 1 }; --Likk the Hunter
	[50779] = { zoneID = 23, artID = { 24 }, x = 3940, y = 5560, overlay = { "3940-5560" }, displayID = 18029, event = 2 }; --Sporeggon
	[50813] = { zoneID = 23, artID = { 24 }, x = 4935, y = 4424, overlay = { "4960-4320" }, displayID = 46516, event = 1 }; --Fene-mal
	[50856] = { zoneID = 23, artID = { 24 }, x = 3960, y = 8459, overlay = { "3780-8400","3920-8400" }, displayID = 31352, event = 2 }; --Snark
	[50915] = { zoneID = 23, artID = { 24 }, x = 5760, y = 7980, overlay = { "5740-8000" }, displayID = 46520, event = 2 }; --Snort
	[50947] = { zoneID = 23, artID = { 24 }, x = 1160, y = 2800, overlay = { "1140-2820" }, displayID = 46532, event = 2 }; --Varah
	[51027] = { zoneID = 23, artID = { 24 }, x = 7460, y = 5880, overlay = { "7420-5840" }, displayID = 46534, event = 1 }; --Spirocula
	[51042] = { zoneID = 23, artID = { 24 }, x = 7180, y = 4580, overlay = { "7180-4540" }, displayID = 46517, event = 2 }; --Bleakheart
	[51053] = { zoneID = 23, artID = { 24 }, x = 2379, y = 7860, overlay = { "2360-7840" }, displayID = 37580, event = 1 }; --Quirix
	[14221] = { zoneID = 25, artID = { 26 }, x = 5807, y = 2391, overlay = { "5540-2380","5620-2500","5660-2360","5740-2500","5807-2391" }, displayID = 3729 }; --Gravis Slipknot
	[14222] = { zoneID = 25, artID = { 26 }, x = 4420, y = 5400, overlay = { "4420-5400" }, displayID = 37735 }; --Araga
	[14223] = { zoneID = 25, artID = { 26 }, x = 5660, y = 6160, overlay = { "5660-6160","5740-6000","5920-5860","6020-5700","6040-5520","6060-4740","6080-5080","6080-5200","6080-5400","6120-4540","6140-4160","6140-4300","6220-4040","6280-3920","6400-3860","6460-3720","6540-3600","6720-3480","6840-3060","6860-3260" }, displayID = 21240 }; --Cranky Benj
	[14275] = { zoneID = 25, artID = { 26 }, x = 6320, y = 8580, overlay = { "6320-8580" }, displayID = 37740 }; --Tamra Stormpike
	[14276] = { zoneID = 25, artID = { 26 }, x = 3220, y = 7940, overlay = { "3220-7940" }, displayID = 5243 }; --Scargil
	[14277] = { zoneID = 25, artID = { 26 }, x = 5440, y = 7640, overlay = { "5440-7660" }, displayID = 11260 }; --Lady Zephris
	[14278] = { zoneID = 25, artID = { 26 }, x = 5700, y = 7460, overlay = { "5700-7460","5740-7320","5740-7620","5800-7200","5840-7500","5920-7320" }, displayID = 34276 }; --Ro'Bark
	[14279] = { zoneID = 25, artID = { 26 }, x = 4340, y = 7520, overlay = { "4340-7520" }, displayID = 37738 }; --Creepthess
	[14280] = { zoneID = 25, artID = { 26 }, x = 6357, y = 5256, overlay = { "6340-5260" }, displayID = 37737 }; --Big Samras
	[14281] = { zoneID = 25, artID = { 26 }, x = 4980, y = 5020, overlay = { "4980-5020" }, displayID = 3616 }; --Jimmy the Bleeder
	[2258] = { zoneID = 25, artID = { 26 }, x = 6034, y = 2886, overlay = { "6020-2880" }, displayID = 36325 }; --Maggarrak <The Mountain Lord>
	[2452] = { zoneID = 25, artID = { 26 }, x = 4340, y = 3780, overlay = { "4340-3780" }, displayID = 7336 }; --Skhowl
	[2453] = { zoneID = 25, artID = { 26 }, x = 4943, y = 1846, overlay = { "4940-1840" }, displayID = 32547 }; --Lo'Grosh
	[47010] = { zoneID = 25, artID = { 26 }, x = 3166, y = 3979, overlay = { "3140-3980" }, displayID = 9995 }; --Indigos
	[50335] = { zoneID = 25, artID = { 26 }, x = 4740, y = 6820, overlay = { "4600-6620","4740-6820" }, displayID = 26255, event = 2 }; --Alitus
	[50765] = { zoneID = 25, artID = { 26 }, x = 3700, y = 6820, overlay = { "3700-6820" }, displayID = 27683, event = 1 }; --Miasmiss
	[50818] = { zoneID = 25, artID = { 26 }, x = 3300, y = 5500, overlay = { "3300-5500" }, displayID = 26618, event = 2 }; --The Dark Prowler
	[50858] = { zoneID = 25, artID = { 26 }, x = 2860, y = 8380, overlay = { "2780-8360" }, displayID = 46551, event = 1 }; --Dustwing
	[50929] = { zoneID = 25, artID = { 26 }, x = 3500, y = 7840, overlay = { "3460-7880" }, displayID = 46552, event = 2 }; --Little Bjorn
	[50955] = { zoneID = 25, artID = { 26 }, x = 4680, y = 7600, overlay = { "4660-7660" }, displayID = 46558, event = 2 }; --Carcinak
	[50967] = { zoneID = 25, artID = { 26 }, x = 5180, y = 8720, overlay = { "5180-8680" }, displayID = 32807, event = 1 }; --Craw the Ravager
	[51022] = { zoneID = 25, artID = { 26 }, x = 5680, y = 5480, overlay = { "5620-5440" }, displayID = 37540, event = 1 }; --Chordix
	[51057] = { zoneID = 25, artID = { 26 }, x = 4559, y = 5380, overlay = { "4540-5240","4560-5380" }, displayID = 34898, event = 2 }; --Weevil
	[51076] = { zoneID = 25, artID = { 26 }, x = 6883, y = 5601, overlay = { "6880-5600" }, displayID = 40191, event = 2 }; --Lopex
	[8210] = { zoneID = 26, artID = { 27 }, x = 6600, y = 5300, overlay = { "6600-5300" }, displayID = 37771 }; --Razortalon
	[8211] = { zoneID = 26, artID = { 27 }, x = 1343, y = 5395, overlay = { "1320-5380" }, displayID = 11414 }; --Old Cliff Jumper
	[8212] = { zoneID = 26, artID = { 27 }, x = 5740, y = 4300, overlay = { "5740-4300" }, displayID = 37772 }; --The Reak
	[8213] = { zoneID = 26, artID = { 27 }, x = 7940, y = 5660, overlay = { "7940-5660","8020-5820","8060-5620" }, displayID = 37770 }; --Ironback
	[8214] = { zoneID = 26, artID = { 27 }, x = 3440, y = 5500, overlay = { "3440-5500" }, displayID = 19816 }; --Jalinde Summerdrake
	[8215] = { zoneID = 26, artID = { 27 }, x = 7140, y = 6100, overlay = { "7140-6100","7160-6260","7200-5980","7260-5860","7280-5700","7380-5580","7460-5260","7480-5420","7500-5540","7600-5440","7620-5260","7660-5560","7740-5020","7860-5080" }, displayID = 12816 }; --Grimungous
	[8216] = { zoneID = 26, artID = { 27 }, x = 4740, y = 6640, overlay = { "4740-6640","4820-6740" }, displayID = 28248 }; --Retherokk the Berserker
	[8217] = { zoneID = 26, artID = { 27 }, x = 6480, y = 8140, overlay = { "6480-8140" }, displayID = 28256 }; --Mith'rethis the Enchanter
	[8218] = { zoneID = 26, artID = { 27 }, x = 3940, y = 6619, overlay = { "3940-6620" }, displayID = 28230 }; --Witherheart the Stalker
	[8219] = { zoneID = 26, artID = { 27 }, x = 2460, y = 6540, overlay = { "2460-6540" }, displayID = 28230 }; --Zul'arek Hatefowler
	[1130] = { zoneID = 27, artID = { 28 }, x = 6768, y = 5899, overlay = { "6620-5980","6720-5800","6920-5580","6980-5860" }, displayID = 913 }; --Bjarn
	[1132] = { zoneID = {
		[27] = { x = 4440, y = 3726, artID = { 28 }, overlay = { "4440-3726" } };
		[469] = { x = 6434, y = 2751, artID = { 481 }, overlay = { "6600-3360","6600-3720","6720-3560","6740-3400","6780-3740","6900-3440","6960-3800","6434-2751" } };
	}, displayID = 10278 }; --Timber
	[1260] = { zoneID = {
		[27] = { x = 2940, y = 4980, artID = { 28 }, overlay = { "2940-4980" } };
		[469] = { x = 2920, y = 6800, artID = { 481 }, overlay = { "2920-6800","2960-6600","3060-6420" } };
	}, displayID = 27504 }; --Great Father Arctikus
	[8503] = { zoneID = {
		[27] = { x = 3419, y = 4082, artID = { 28 }, overlay = { "3419-4082" } };
		[469] = { x = 4020, y = 4420, artID = { 481 }, overlay = { "4020-4420","4040-4620" } };
	}, displayID = 7807 }; --Gibblewilt
	[1137] = { zoneID = 29, artID = { 31 }, x = 3180, y = 4400, overlay = { "3180-4400","3220-4920","3380-5220","3400-4880","3460-4520","3520-4960","3560-5360","3800-5100","3920-4660" }, displayID = 13990 }; --Edan the Howler
	[1119] = { zoneID = 31, artID = { 30 }, x = 5240, y = 3220, overlay = { "5240-3220","5540-3640","5620-3840","5620-3980","5660-3720" }, displayID = 11165 }; --Hammerspine
	[50846] = { zoneID = 32, artID = { 33 }, x = 5900, y = 2540, overlay = { "5700-2560","5720-2380","5820-2240","5900-2540" }, displayID = 5240, event = 2 }; --Slavermaw
	[50876] = { zoneID = 32, artID = { 33 }, x = 7159, y = 1920, overlay = { "7060-1860","7140-1680" }, displayID = 1746, event = 1 }; --Avis
	[50946] = { zoneID = 32, artID = { 33 }, x = 2220, y = 7780, overlay = { "2120-7880","2220-7780" }, displayID = 2450, event = 2 }; --Hogzilla
	[50948] = { zoneID = 32, artID = { 33 }, x = 6700, y = 4520, overlay = { "6440-4620","6520-4500","6580-4760","6600-4620","6640-4440" }, displayID = 46566, event = 2 }; --Crystalback
	[51002] = { zoneID = 32, artID = { 33 }, x = 1840, y = 3879, overlay = { "1780-3840" }, displayID = 15336, event = 1 }; --Scorpoxx
	[51010] = { zoneID = 32, artID = { 33 }, x = 3620, y = 5300, overlay = { "3500-5200","3620-5300" }, displayID = 46248, event = 1 }; --Snips
	[51048] = { zoneID = 32, artID = { 33 }, x = 4280, y = 4720, overlay = { "3940-5060","3980-5300","4040-4940","4140-5060","4280-4720" }, displayID = 35356, event = 2 }; --Rexxus
	[8277] = { zoneID = 32, artID = { 33 }, x = 2920, y = 6780, overlay = { "2920-6780","3020-6860","3040-7020","3040-7180","3160-7200","3180-7320" }, displayID = 37685 }; --Rekk'tilac
	[8278] = { zoneID = 32, artID = { 33 }, x = 4800, y = 3840, overlay = { "4800-3840","4920-3700","4920-3940" }, displayID = 33498 }; --Smoldar
	[8279] = { zoneID = 32, artID = { 33 }, x = 5800, y = 5640, overlay = { "5800-5640","6200-6100","6220-5960","6300-6300" }, displayID = 10800 }; --Faulty War Golem
	[8280] = { zoneID = 32, artID = { 33 }, x = 5579, y = 4520, overlay = { "5580-4520","5660-4660","5720-4480","5740-4340","5840-4440" }, displayID = 2346 }; --Shleipnarr
	[8281] = { zoneID = 32, artID = { 33 }, x = 4020, y = 5859, overlay = { "4020-5860","4040-5740" }, displayID = 14513 }; --Scald
	[8282] = { zoneID = 32, artID = { 33 }, x = 2940, y = 2540, overlay = { "2940-2540","3100-2640" }, displayID = 7835 }; --Highlord Mastrogonde
	[8283] = { zoneID = 32, artID = { 33 }, x = 3740, y = 4420, overlay = { "3740-4420" }, displayID = 7819 }; --Slave Master Blackheart
	[50839] = { zoneID = {
		[33] = { x = 6200, y = 4479, artID = { 34 }, overlay = { "3560-6080","3600-4960","3720-6600","3820-4460","3880-4260","4040-4020","4080-7320","4240-7480","4300-7600","4360-3600","4440-7660","4460-3760","4460-7500","4500-3600","4640-3500","4640-7880","4680-7760","4740-3600","4800-7860","4880-3500","5000-3520","5060-7860","5440-3580","5460-7620","5620-7600","5700-3640","5780-3800","5960-4140","6100-4340","6200-4480" } };
		[36] = { x = 2400, y = 3040, artID = { 37 }, overlay = { "1780-3160","1840-2540","1880-3300","1940-2440","2020-3380","2080-2400","2220-3340","2280-2540","2400-3040" } };
	}, displayID = 29539, event = 1 }; --Chromehound
	[51066] = { zoneID = 35, artID = { 36 }, x = 3400, y = 2000, overlay = { "3320-1900","3400-2000" }, displayID = 33863, event = 2 }; --Crystalfang
	[8924] = { zoneID = 35, artID = { 36 }, x = 4013, y = 6061, overlay = { "4013-6061" }, displayID = 8390 }; --The Behemoth
	[10077] = { zoneID = 36, artID = { 37 }, x = 6280, y = 3140, overlay = { "6280-3140","6340-3260","6740-5460","6960-5560","7020-5680","7060-3120","7080-2980","7220-5900","7300-5160" }, displayID = 37671 }; --Deathmaw
	[10078] = { zoneID = 36, artID = { 37 }, x = 5620, y = 3300, overlay = { "5620-3300","5700-3140","5700-3460","5780-3320","6000-3020" }, displayID = 37683 }; --Terrorspark
	[10119] = { zoneID = 36, artID = { 37 }, x = 1880, y = 4340, overlay = { "1880-4340","1940-4120","2120-4140","2260-4180" }, displayID = 12232 }; --Volchan
	[50357] = { zoneID = 36, artID = { 37 }, x = 0980, y = 5440, overlay = { "0840-5460","0940-5240","0960-5500" }, displayID = 45201, event = 1 }; --Sunwing
	[50361] = { zoneID = 36, artID = { 37 }, x = 5060, y = 6060, overlay = { "5040-6020" }, displayID = 20596, event = 2 }; --Ornat
	[50725] = { zoneID = 36, artID = { 37 }, x = 7280, y = 2260, overlay = { "7180-2300" }, displayID = 20309, event = 1 }; --Azelisk
	[50730] = { zoneID = 36, artID = { 37 }, x = 0580, y = 3820, overlay = { "0520-3860" }, displayID = 20297, event = 1 }; --Venomspine
	[50792] = { zoneID = 36, artID = { 37 }, x = 3540, y = 2680, overlay = { "3520-2620" }, displayID = 46278, event = 2 }; --Chiaa
	[50807] = { zoneID = 36, artID = { 37 }, x = 6500, y = 5380, overlay = { "6360-5420","6400-5200","6460-5320" }, displayID = 46277, event = 2 }; --Catal
	[50810] = { zoneID = 36, artID = { 37 }, x = 7560, y = 5340, overlay = { "7320-5300","7420-5200","7500-5320","7540-5180" }, displayID = 20347, event = 1 }; --Favored of Isiset
	[50842] = { zoneID = 36, artID = { 37 }, x = 2920, y = 3140, overlay = { "2840-3300","2900-3480","2920-3140" }, displayID = 12168, event = 2 }; --Magmagan
	[50855] = { zoneID = 36, artID = { 37 }, x = 4700, y = 2420, overlay = { "4700-2420" }, displayID = 46279, event = 2 }; --Jaxx the Rabid
	[8976] = { zoneID = 36, artID = { 37 }, x = 2770, y = 5921, overlay = { "2640-5820","2740-5900" }, displayID = 6369 }; --Hematos
	[8978] = { zoneID = 36, artID = { 37 }, x = 4380, y = 3980, overlay = { "4380-3980" }, displayID = 11511 }; --Thauris Balgarr
	[8979] = { zoneID = 36, artID = { 37 }, x = 3340, y = 3680, overlay = { "3340-3680","3480-3660" }, displayID = 11510 }; --Gruklash
	[8981] = { zoneID = 36, artID = { 37 }, x = 5100, y = 3640, overlay = { "5100-3640","5260-3840","5340-3600","5500-4360" }, displayID = 23822 }; --Malfunctioning Reaver
	[9602] = { zoneID = 36, artID = { 37 }, x = 6840, y = 4040, overlay = { "6840-4040" }, displayID = 11564 }; --Hahk'Zor
	[9604] = { zoneID = 36, artID = { 37 }, x = 6340, y = 4740, overlay = { "6340-4740","6440-4660" }, displayID = 11562 }; --Gorgon'och
	[100] = { zoneID = 37, artID = { 41 }, x = 2760, y = 8880, overlay = { "2520-9320","2540-9100","2640-8920","2640-9340","2680-8680","2680-9080","2740-8840","2880-8820" }, displayID = 603 }; --Gruff Swiftbite
	[471] = { zoneID = {
		[37] = { x = 6192, y = 4783, artID = { 41 }, overlay = { "6192-4783" } };
		[40] = { x = 3940, y = 2120, artID = { 42 }, overlay = { "3940-2120","4040-2000","4700-2400","5140-3020","5240-2860","5400-3320" } };
	}, displayID = 36505 }; --Mother Fang
	[472] = { zoneID = 37, artID = { 41 }, x = 6794, y = 3952, overlay = { "6640-4040","6680-4160","6700-3920","6780-4700","6800-4440","6920-3860","7020-4000" }, displayID = 543 }; --Fedfennel
	[50752] = { zoneID = 37, artID = { 41 }, x = 6760, y = 6320, overlay = { "6520-6460","6640-6300","6760-6320" }, displayID = 2537, event = 1 }; --Tarantis
	[50916] = { zoneID = 37, artID = { 41 }, x = 5259, y = 6320, overlay = { "5140-6240","5140-6360","5260-6320" }, displayID = 46543, event = 1 }; --Lamepaw the Whimperer
	[50926] = { zoneID = 37, artID = { 41 }, x = 2860, y = 6660, overlay = { "2740-6740","2740-6920","2860-6660" }, displayID = 70199, event = 1 }; --Grizzled Ben
	[50942] = { zoneID = 37, artID = { 41 }, x = 7060, y = 7980, overlay = { "6780-8220","6920-7700","6920-7820","6940-7960","7060-7980" }, displayID = 1208, event = 1 }; --Snoot the Rooter
	[51014] = { zoneID = {
		[37] = { x = 7400, y = 8480, artID = { 41 }, overlay = { "5060-8720","5340-8780","5520-8660","5620-8540","5840-8380","5960-8300","6080-8240","6260-8240","6340-8340","6600-8440","6740-8440","6860-8460","7020-8540","7200-8440","7300-8520","6460-8360" } };
		[47] = { x = 6100, y = 1260, artID = { 52 }, overlay = { "4940-1080","6100-1220" } };
	}, displayID = 7837, event = 2 }; --Terrapis
	[51077] = { zoneID = 37, artID = { 41 }, x = 8380, y = 8500, overlay = { "8160-8520","8240-8400","8300-8280","8300-8580" }, displayID = 30254, event = 1 }; --Bushtail
	[61] = { zoneID = 37, artID = { 41 }, x = 5063, y = 8308, overlay = { "4920-8200","5040-8320","5040-8440","5060-8160" }, displayID = 3341 }; --Thuros Lightfingers
	[62] = { zoneID = {
		[37] = { x = 4763, y = 3182, artID = { 41 }, overlay = { "4763-3182" } };
		[425] = { x = 3140, y = 1700, artID = { 437 }, overlay = { "3140-1700" } };
	}, displayID = 511 }; --Gug Fatcandle
	[79] = { zoneID = 37, artID = { 41 }, x = 3720, y = 8340, overlay = { "3720-8340","3800-8140","3840-8340" }, displayID = 774 }; --Narg the Taskmaster
	[99] = { zoneID = 37, artID = { 41 }, x = 3080, y = 6500, overlay = { "3080-6500" }, displayID = 3320 }; --Morgaine the Sly
	[45739] = { zoneID = 47, artID = { 52 }, x = 9059, y = 3060, overlay = { "8940-3060","9060-3040" }, displayID = 34648 }; --The Unknown Soldier
	[45740] = { zoneID = 47, artID = { 52 }, x = 8180, y = 5920, overlay = { "7940-6960","7940-7080","7960-6740","8060-6940","8080-6240","8080-6540","8080-6820","8120-5960" }, displayID = 34649 }; --Watcher Eva <The Restless Dead>
	[45771] = { zoneID = 47, artID = { 52 }, x = 6519, y = 7040, overlay = { "5800-7720","5860-8000","6040-7560","6120-7300","6140-7040","6140-7180","6200-7460","6300-7300","6320-6820","6320-8340","6360-7000","6500-6860","6520-7040" }, displayID = 34669 }; --Marus <The Pack Leader>
	[45785] = { zoneID = 47, artID = { 52 }, x = 5120, y = 7480, overlay = { "4680-7440","4720-7220","4740-7080","4780-7640","4820-7400","4860-7100","4940-7560","4960-7200","5020-7400","5040-7000","5080-7180","5120-7480" }, displayID = 34671 }; --Carved One
	[45801] = { zoneID = 47, artID = { 52 }, x = 2760, y = 3360, overlay = { "2700-3100","2740-3260" }, displayID = 34682 }; --Eliza <Bride of the Embalmer>
	[45811] = { zoneID = 47, artID = { 52 }, x = 0800, y = 3660, overlay = { "0740-3280","0740-3540","0780-3420","0800-3660" }, displayID = 4277 }; --Marina DeSirrus <Thief of the Dead>
	[503] = { zoneID = 47, artID = { 52 }, x = 2560, y = 3020, overlay = { "2120-2740","2560-3020" }, displayID = 10626 }; --Lord Malathrom
	[507] = { zoneID = 47, artID = { 52 }, x = 5900, y = 3000, overlay = { "5900-3000","6120-4000","6140-4160","6240-4340","6320-4180","6380-4500","6380-4880","6400-5120" }, displayID = 34650 }; --Fenros
	[521] = { zoneID = 47, artID = { 52 }, x = 5954, y = 1956, overlay = { "5880-1860","5900-2000","5980-2100","6020-1880","6020-2280","6380-1940","6440-2180","6480-2060","6520-1820","6540-1940","6600-2160","6660-1900","6900-2420","6920-2560","6940-2280","7040-2560","7080-2220","7080-2380" }, displayID = 10278 }; --Lupos
	[534] = { zoneID = 47, artID = { 52 }, x = 7400, y = 7860, overlay = { "7400-7860" }, displayID = 34651 }; --Nefaru <The Den Mother>
	[574] = { zoneID = 47, artID = { 52 }, x = 8640, y = 4800, overlay = { "8640-4800" }, displayID = 963 }; --Naraxis
	[771] = { zoneID = 47, artID = { 52 }, x = 1660, y = 3740, overlay = { "1340-3440","1440-3340","1500-3480","1520-3840","1540-3700","1660-3740","1680-3960","1700-3560","1800-3740","1800-3860","1840-3560" }, displayID = 7848 }; --Commander Felstrom
	[1398] = { zoneID = 48, artID = { 53 }, x = 6680, y = 6900, overlay = { "6680-6900","6800-6600","6880-6840","6900-5960","6920-6660","7000-6060","7000-6240","7040-6360","7040-6760","7060-6540","7120-6060" }, displayID = 5945 }; --Boss Galgosh <Stonesplinter Chieftain>
	[1399] = { zoneID = 48, artID = { 53 }, x = 3080, y = 7500, overlay = { "3080-7500" }, displayID = 6528 }; --Magosh <Stonesplinter Tribal Shaman>
	[1425] = { zoneID = 48, artID = { 53 }, x = 2440, y = 3000, overlay = { "2440-3000","2480-2800","2560-2940","2560-3080","2600-2700" }, displayID = 774 }; --Kubb <Master of Meats and Fishes>
	[14266] = { zoneID = 48, artID = { 53 }, x = 6140, y = 7340, overlay = { "6140-7340","6160-7460" }, displayID = 34437 }; --Shanda the Spinner
	[14267] = { zoneID = 48, artID = { 53 }, x = 6600, y = 2140, overlay = { "6600-2140","6720-2220","6800-2720","6820-2140","6840-2380","6840-2900","6860-2580","6940-2700","6980-2240","6980-2580","7000-2360","7100-2000","7120-2280","7120-2420","7240-2180","7240-2540" }, displayID = 25191 }; --Emogg the Crusher
	[14268] = { zoneID = 48, artID = { 53 }, x = 6619, y = 7119, overlay = { "6620-7120","6620-7320","6740-7600","6880-7500","6900-7380","7080-7340","7080-7500","7100-7220","7200-7100","7220-7240","7360-7120","7420-6580","7420-6860","7440-6300","7440-7000","7480-6720","7480-7360","7500-7120","7580-6300","7600-7380","7720-7340","7780-6460","7800-6760","7800-7020","7800-7600","7820-6880","7820-7180","7820-7460","7900-6300","7920-6600" }, displayID = 25868 }; --Lord Condar
	[2476] = { zoneID = 48, artID = { 53 }, x = 5280, y = 5780, overlay = { "5280-5780","5300-5580","5360-5420","5400-5660","5520-5420","5540-5300","5560-5580","5640-5180" }, displayID = 32813 }; --Gosh-Haldir <The Clutch Mother>
	[45369] = { zoneID = 48, artID = { 53 }, x = 4080, y = 6260, overlay = { "3740-6220","3880-6200","4000-6120","4040-6500","4080-6240" }, displayID = 3452 }; --Morick Darkbrew <Dark Iron Courier>
	[45380] = { zoneID = 48, artID = { 53 }, x = 7759, y = 4159, overlay = { "6660-4000","6760-4280","6840-3780","6880-3600","6960-4200","7000-3740","7040-3560","7100-4280","7220-3700","7240-4220","7300-3540","7300-4340","7320-4460","7380-3640","7400-3400","7460-4380","7520-4260","7620-4380","7640-3840","7640-4240","7660-3500","7700-3680","7760-4160","6760-4140" }, displayID = 30239 }; --Ashtail
	[45384] = { zoneID = 48, artID = { 53 }, x = 2560, y = 4479, overlay = { "2540-4320","2560-4480" }, displayID = 10796 }; --Sagepaw <Mosshide Chieftain>
	[45398] = { zoneID = 48, artID = { 53 }, x = 3559, y = 1560, overlay = { "3540-1540" }, displayID = 27195 }; --Grizlak <Associate Troggwhacker>
	[45399] = { zoneID = 48, artID = { 53 }, x = 7800, y = 7780, overlay = { "7140-7640","7220-7800","7340-7800","7480-7640","7520-7860","7620-8040","7640-8180","7700-8320","7740-8000","7760-7880","7800-7700" }, displayID = 10664 }; --Optimo
	[45401] = { zoneID = 48, artID = { 53 }, x = 4960, y = 5700, overlay = { "4180-4400","4220-4660","4240-4160","4260-4800","4280-4320","4280-4540","4340-4040","4360-4880","4400-3900","4440-5140","4460-4960","4480-3800","4480-5260","4500-5380","4520-4740","4560-5160","4600-5480","4720-5100","4740-5540","4820-5640","4920-5760" }, displayID = 5286 }; --Whitefin
	[45402] = { zoneID = 48, artID = { 53 }, x = 5940, y = 4060, overlay = { "5040-3780","5080-3600","5120-4060","5220-3600","5220-4160","5240-3480","5380-3520","5380-4100","5380-4320","5540-3460","5540-3580","5540-4020","5540-4200","5580-3900","5600-3700","5680-3820","5680-4160","5720-3420","5740-3580","5740-4000","5760-4260","5840-3860","5880-3980","5880-4160" }, displayID = 18723 }; --Nix
	[45404] = { zoneID = 48, artID = { 53 }, x = 5000, y = 2400, overlay = { "5000-2400" }, displayID = 34187 }; --Geoshaper Maren
	[14269] = { zoneID = 49, artID = { 54 }, x = 7102, y = 5475, overlay = { "6980-5520","7020-5380","7100-5500","7160-5660" }, displayID = 37624 }; --Seeker Aqualon
	[14270] = { zoneID = 49, artID = { 54 }, x = 3620, y = 4260, overlay = { "3620-4260","3680-4140","3740-4260" }, displayID = 5243 }; --Squiddic
	[14271] = { zoneID = 49, artID = { 54 }, x = 2780, y = 6160, overlay = { "2780-6160","2880-5960","2940-6100","2940-6320","3000-5760","3060-6260","3080-6140" }, displayID = 37621 }; --Ribchaser
	[14272] = { zoneID = 49, artID = { 54 }, x = 3400, y = 5700, overlay = { "3400-5700","3440-6000","3540-6160","3560-6040" }, displayID = 6378 }; --Snarlflare
	[14273] = { zoneID = 49, artID = { 54 }, x = 5640, y = 5140, overlay = { "5640-5140" }, displayID = 5229 }; --Boulderheart
	[52146] = { zoneID = 49, artID = { 54 }, x = 6419, y = 6440, overlay = { "6320-6660","6340-6520" }, displayID = 909 }; --Chitter
	[584] = { zoneID = 49, artID = { 54 }, x = 3340, y = 1020, overlay = { "3340-1020","3420-1200" }, displayID = 6041 }; --Kazon
	[616] = { zoneID = 49, artID = { 54 }, x = 3640, y = 3380, overlay = { "3640-3380","3680-3620","3780-3440","3820-3580" }, displayID = 37620 }; --Chatter
	[947] = { zoneID = 49, artID = { 54 }, x = 6660, y = 3600, overlay = { "6660-3600","6800-3540" }, displayID = 37623 }; --Rohh the Silent
	[11383] = { zoneID = 50, artID = { 55 }, x = 6700, y = 3160, overlay = { "6700-3160","6700-3400" }, displayID = 11295 }; --High Priestess Hai'watna
	[14487] = { zoneID = 50, artID = { 55 }, x = 4362, y = 4336, overlay = { "4000-3880","4120-3960","4200-4120","4200-4240","4320-4100","4320-4340" }, displayID = 22530 }; --Gluggl
	[14488] = { zoneID = 50, artID = { 55 }, x = 4479, y = 5320, overlay = { "4480-5320","4520-5440","4540-5100","4540-5560","4580-4680","4580-4820","4600-4500","4640-5420","4680-5580","4720-4560" }, displayID = 37382 }; --Roloch
	[51658] = { zoneID = 50, artID = { 55 }, x = 6280, y = 7460, overlay = { "6220-7300","6240-7420" }, displayID = 37596 }; --Mogh the Dead <Skullsplitter Clan Witchdoctor>
	[51661] = { zoneID = 50, artID = { 55 }, x = 4759, y = 3320, overlay = { "4700-3200","4760-3320" }, displayID = 10133 }; --Tsul'Kalu <The Earth Spirit>
	[51662] = { zoneID = 50, artID = { 55 }, x = 5500, y = 3060, overlay = { "5340-3020","5420-3160","5440-2920","5500-3060" }, displayID = 37613 }; --Mahamba <The Water Spirit>
	[51663] = { zoneID = 50, artID = { 55 }, x = 3700, y = 2979, overlay = { "3620-2920" }, displayID = 37615 }; --Pogeyan <The Fire Spirit>
	[1063] = { zoneID = 51, artID = { 56 }, x = 3000, y = 4540, overlay = { "3000-4540","3000-4800","3080-4680","3220-4640" }, displayID = 7975 }; --Jade <Victim of the Nightmare>
	[1106] = { zoneID = 51, artID = { 56 }, x = 6160, y = 2760, overlay = { "6160-2760","6240-2520","6240-2640","6300-2760","6360-2620" }, displayID = 18349 }; --Lost One Cook
	[14445] = { zoneID = 51, artID = { 56 }, x = 7380, y = 4440, overlay = { "7380-4440","7500-4540" }, displayID = 7976 }; --Captain Wyrmak <Victim of the Nightmare>
	[14446] = { zoneID = 51, artID = { 56 }, x = 7700, y = 8480, overlay = { "7700-8480","7720-8200","7760-8360","7840-8580" }, displayID = 5286 }; --Fingat
	[14447] = { zoneID = 51, artID = { 56 }, x = 8900, y = 6820, overlay = { "8900-6820","8920-6660","8960-6540","9020-6760" }, displayID = 37634 }; --Gilmorian
	[14448] = { zoneID = 51, artID = { 56 }, x = 4820, y = 4080, overlay = { "4820-4080","4920-4260","4980-4140" }, displayID = 14497 }; --Molt Thorn
	[50738] = { zoneID = 51, artID = { 56 }, x = 5780, y = 5240, overlay = { "5540-5460","5580-5260","5660-5460","5720-5200","5780-5320" }, displayID = 25009, event = 2 }; --Shimmerscale
	[50790] = { zoneID = 51, artID = { 56 }, x = 4080, y = 3579, overlay = { "3900-3400","3980-3300","3980-3520" }, displayID = 47120, event = 1 }; --Ionis
	[50797] = { zoneID = 51, artID = { 56 }, x = 7080, y = 6500, overlay = { "6920-6640","6940-6780","7040-6480","7060-6620" }, displayID = 47126, event = 2 }; --Yukiko
	[50837] = { zoneID = 51, artID = { 56 }, x = 8020, y = 2960, overlay = { "7820-2720","7820-2960","7940-2680","7940-2980","7960-2820" }, displayID = 46575, event = 1 }; --Kash
	[50882] = { zoneID = 51, artID = { 56 }, x = 2780, y = 6360, overlay = { "2700-6100","2740-6300" }, displayID = 19743, event = 1 }; --Chupacabros
	[50886] = { zoneID = 51, artID = { 56 }, x = 9059, y = 3920, overlay = { "8020-1620","8180-1700","8500-2420","8540-2220","8720-2460","8760-3040","8800-2660","8880-3120","8880-3300","8900-2880","8940-2720","8940-3580","9040-3680","9040-3880" }, displayID = 21268, event = 1 }; --Seawing
	[50903] = { zoneID = 51, artID = { 56 }, x = 1860, y = 3820, overlay = { "1600-3600","1720-3860","1740-3720","1860-3540","1860-3820" }, displayID = 37856, event = 2 }; --Orlix the Swamplord
	[51052] = { zoneID = 51, artID = { 56 }, x = 1779, y = 4800, overlay = { "1640-4720","1760-4720" }, displayID = 46574, event = 2 }; --Gib the Banana-Hoarder
	[5348] = { zoneID = 51, artID = { 56 }, x = 1800, y = 6980, overlay = { "1800-6980" }, displayID = 625 }; --Dreamwatcher Forktongue <Victim of the Nightmare>
	[763] = { zoneID = 51, artID = { 56 }, x = 6279, y = 2494, overlay = { "5960-2640","6120-2560","6140-2340","6140-2760","6280-2480","6380-1900","6380-2360","6460-2260","6560-2340" }, displayID = 18620 }; --Lost One Chieftain
	[1424] = { zoneID = 52, artID = { 57 }, x = 4600, y = 1840, overlay = { "4600-1840" }, displayID = 774 }; --Master Digger
	[462] = { zoneID = 52, artID = { 57 }, x = 4840, y = 3300, overlay = { "4840-3300","4900-2800","4900-3520","4940-2640","4980-3240","5020-2820","5420-2420","5440-2580","5520-3500","5540-2360","5620-3340","5640-2080","5640-3520","5720-1940","5780-2060","5800-1800" }, displayID = 507 }; --Vultros
	[506] = { zoneID = 52, artID = { 57 }, x = 5959, y = 7440, overlay = { "5960-7440","6000-7300","6080-7480","6300-7240","6320-7380","6340-7580","6460-7500" }, displayID = 383 }; --Sergeant Brashclaw
	[519] = { zoneID = 52, artID = { 57 }, x = 4980, y = 1039, overlay = { "4980-1040","5200-1060","5340-0980","5400-1180","5460-1040","5560-0900","5620-1120" }, displayID = 540 }; --Slark
	[520] = { zoneID = 52, artID = { 57 }, x = 2880, y = 7280, overlay = { "2880-7280" }, displayID = 652 }; --Brack
	[572] = { zoneID = 52, artID = { 57 }, x = 4120, y = 2840, overlay = { "4120-2840","4140-2960","4260-2880" }, displayID = 1065 }; --Leprithus
	[573] = { zoneID = 52, artID = { 57 }, x = 6273, y = 6201, overlay = { "3800-5100","3860-5260","4400-3600","5400-3300","5500-3180","6240-6120","6360-6100" }, displayID = 548 }; --Foe Reaper 4000
	[596] = { zoneID = {
		[52] = { x = 4100, y = 7660, artID = { 57 }, overlay = { "4100-7660","4240-7660","4280-7900" } };
		[55] = { x = 6151, y = 6572, artID = { 60 }, overlay = { "6151-6572" } };
	}, displayID = 3267 }; --Brainwashed Noble
	[599] = { zoneID = {
		[52] = { x = 3966, y = 7819, artID = { 57 }, overlay = { "3966-7819" } };
		[55] = { x = 2960, y = 6140, artID = { 60 }, overlay = { "2960-6140","2980-5920","3280-5680","3420-5500","3460-5680","3620-5600","3740-5640","3860-5680","3960-5580","4140-5660","5060-5360","5140-5480","5180-6520","5200-5620","5220-5780","5260-5420","5320-6320","5420-5400","5420-5700","5420-6820","5440-5540","5460-6940","5600-6400","5600-6660","5620-6780","5620-7080","5700-6520","5720-6940","6280-5920" } };
	}, displayID = 2355 }; --Marisa du'Paige
	[1037] = { zoneID = 56, artID = { 61 }, x = 4420, y = 4400, overlay = { "4220-4080","4220-4460","4240-4280","4320-4380","4440-4480","4460-4280","4580-4380","4700-4300","4700-4420","4700-4600","4820-4520","4840-4660","4840-4880","4920-4200","5000-4820","5000-4940","5020-5220","5120-5100","5140-5260","5160-4880","5240-5360" }, displayID = 4912 }; --Dragonmaw Battlemaster
	[1112] = { zoneID = 56, artID = { 61 }, x = 4680, y = 6340, overlay = { "4680-6340" }, displayID = 283 }; --Leech Widow
	[1140] = { zoneID = 56, artID = { 61 }, x = 6980, y = 2920, overlay = { "6980-2920" }, displayID = 11316 }; --Razormaw Matriarch
	[14424] = { zoneID = 56, artID = { 61 }, x = 5040, y = 3020, overlay = { "5040-3020","5060-3240","5140-2880","5140-3380","5220-3540","5220-3680","5240-2760","5280-3420","5380-2720","5380-2840","5400-3340","5460-3200","5500-3040","5520-2740","5560-2900","5620-3060" }, displayID = 697 }; --Mirelow
	[14425] = { zoneID = 56, artID = { 61 }, x = 3040, y = 3300, overlay = { "3040-3300","3140-2900","3160-3240","3160-3360","3440-2720","3500-2860" }, displayID = 501 }; --Gnawbone
	[14433] = { zoneID = 56, artID = { 61 }, x = 4440, y = 2480, overlay = { "4440-2480" }, displayID = 15463 }; --Sludginn
	[2090] = { zoneID = 56, artID = { 61 }, x = 4800, y = 7420, overlay = { "4800-7420" }, displayID = 4914 }; --Ma'ruk Wyrmscale <Dragonmaw Warlord>
	[2108] = { zoneID = 56, artID = { 61 }, x = 3820, y = 4580, overlay = { "3820-4580" }, displayID = 4913 }; --Garneg Charskull
	[44224] = { zoneID = 56, artID = { 61 }, x = 1560, y = 4000, overlay = { "1320-3780","1340-3900","1340-4140","1340-4260","1500-3840","1520-3720","1520-4000" }, displayID = 1763 }; --Two-Toes
	[44225] = { zoneID = 56, artID = { 61 }, x = 4280, y = 3259, overlay = { "4260-3220" }, displayID = 32448 }; --Rufus Darkshot
	[44226] = { zoneID = 56, artID = { 61 }, x = 3360, y = 5100, overlay = { "3240-5080","3360-5100" }, displayID = 33737 }; --Sarltooth
	[44227] = { zoneID = 56, artID = { 61 }, x = 6160, y = 5780, overlay = { "6140-5740" }, displayID = 3199 }; --Gazz the Loch-Hunter
	[50964] = { zoneID = 56, artID = { 61 }, x = 5800, y = 0860, overlay = { "5720-0900","5780-0720" }, displayID = 46230, event = 1 }; --Chops
	[14428] = { zoneID = 57, artID = { 62 }, x = 6519, y = 5120, overlay = { "6520-5120","6520-5000" }, displayID = 6818 }; --Uruson
	[14429] = { zoneID = 57, artID = { 62 }, x = 5160, y = 3840, overlay = { "5160-3840" }, displayID = 1011 }; --Grimmaw
	[14430] = { zoneID = 57, artID = { 62 }, x = 5409, y = 6679, overlay = { "5220-6740","5400-6660","5700-6640","5940-6440","5940-6560" }, displayID = 37558 }; --Duskstalker
	[14431] = { zoneID = 57, artID = { 62 }, x = 3700, y = 3040, overlay = { "3700-3040","3740-3160","3820-3340","3920-3660","3940-3540" }, displayID = 2296 }; --Fury Shelda
	[14432] = { zoneID = 57, artID = { 62 }, x = 5300, y = 4420, overlay = { "5300-4420" }, displayID = 904 }; --Threggil
	[2162] = { zoneID = 57, artID = { 62 }, x = 4720, y = 4479, overlay = { "4720-4480" }, displayID = 936 }; --Agal
	[3535] = { zoneID = 57, artID = { 62 }, x = 5406, y = 6669, overlay = { "5200-6340","5406-6669" }, displayID = 1549 }; --Blackmoss the Fetid
	[2172] = { zoneID = 62, artID = { 67 }, x = 4080, y = 4840, overlay = { "4080-4840" }, displayID = 38 }; --Strider Clutchmother
	[2175] = { zoneID = 62, artID = { 67 }, x = 4120, y = 3640, overlay = { "4120-3640" }, displayID = 37555 }; --Shadowclaw
	[2184] = { zoneID = 62, artID = { 67 }, x = 4479, y = 5660, overlay = { "4480-5660" }, displayID = 5774 }; --Lady Moongazer
	[2186] = { zoneID = 62, artID = { 67 }, x = 4420, y = 8240, overlay = { "4420-8240" }, displayID = 5773 }; --Carnivous the Breaker
	[2191] = { zoneID = 62, artID = { 67 }, x = 5720, y = 3279, overlay = { "5720-3280" }, displayID = 37531 }; --Licillin
	[2192] = { zoneID = 62, artID = { 67 }, x = 4000, y = 8300, overlay = { "4000-8300" }, displayID = 5772 }; --Firecaller Radison
	[7015] = { zoneID = 62, artID = { 67 }, x = 5740, y = 1520, overlay = { "5740-1520","5800-1180","5840-0980" }, displayID = 1305 }; --Flagglemurk the Cruel
	[7016] = { zoneID = 62, artID = { 67 }, x = 4640, y = 4140, overlay = { "4640-4140","4840-4120","4860-3900" }, displayID = 4982 }; --Lady Vespira
	[7017] = { zoneID = 62, artID = { 67 }, x = 3400, y = 8340, overlay = { "3400-8340" }, displayID = 31547 }; --Lord Sinslayer
	[10559] = { zoneID = 63, artID = { 68 }, x = 1461, y = 2411, overlay = { "1200-1500","1240-2920","1500-2420" }, displayID = 4979 }; --Lady Vespia
	[10639] = { zoneID = 63, artID = { 68 }, x = 3700, y = 3360, overlay = { "3700-3360","3660-3620" }, displayID = 6800 }; --Rorgish Jowl
	[10640] = { zoneID = 63, artID = { 68 }, x = 5422, y = 6272, overlay = { "5400-6220","5580-6260","5640-6440" }, displayID = 5773 }; --Oakpaw
	[10641] = { zoneID = 63, artID = { 68 }, x = 4240, y = 4620, overlay = { "4240-4620","4320-4740","4340-4860","4360-5020","4380-5220","4400-5360","4540-4700","4640-4820","4660-5160","4400-4540" }, displayID = 8389 }; --Branch Snapper
	[10642] = { zoneID = 63, artID = { 68 }, x = 4661, y = 6936, overlay = { "4640-6940","4640-7060","4700-7180","4720-6840","4860-6840","4920-7160","4980-6900","4980-7040","5100-7080" }, displayID = 27029 }; --Eck'alom
	[10643] = { zoneID = 63, artID = { 68 }, x = 2100, y = 4180, overlay = { "1780-3680","1840-4140","1880-3800","1920-4420","1940-4240","1980-4560","2000-4040","2080-4400","2100-4180","2140-4040" }, displayID = 11293 }; --Mugglefin
	[10644] = { zoneID = 63, artID = { 68 }, x = 2520, y = 2680, overlay = { "2520-2680","2620-1540" }, displayID = 165 }; --Mist Howler
	[10647] = { zoneID = 63, artID = { 68 }, x = 8109, y = 4924, overlay = { "6660-5680","7840-4520","8100-4920" }, displayID = 11331 }; --Prince Raze
	[12037] = { zoneID = 63, artID = { 68 }, x = 8940, y = 4640, overlay = { "8940-4640","9280-4540" }, displayID = 706 }; --Ursol'lok
	[3735] = { zoneID = 63, artID = { 68 }, x = 3140, y = 2239, overlay = { "3140-2240" }, displayID = 4156 }; --Apothecary Falthis
	[3736] = { zoneID = 63, artID = { 68 }, x = 7240, y = 7100, overlay = { "7240-7100","7360-7360","7520-7100" }, displayID = 4155 }; --Darkslayer Mordenthal
	[3773] = { zoneID = 63, artID = { 68 }, x = 2500, y = 6040, overlay = { "2500-6040" }, displayID = 1912 }; --Akkrilus
	[3792] = { zoneID = 63, artID = { 68 }, x = 5300, y = 3740, overlay = { "5300-3740" }, displayID = 522 }; --Terrowulf Packlord
	[14426] = { zoneID = 64, artID = { 69 }, x = 3849, y = 2691, overlay = { "3840-2720" }, displayID = 3898 }; --Harb Foulmountain
	[14427] = { zoneID = 64, artID = { 69 }, x = 3996, y = 3272, overlay = { "3980-3260" }, displayID = 511 }; --Gibblesnik
	[4132] = { zoneID = 64, artID = { 69 }, x = 6980, y = 8560, overlay = { "6980-8560" }, displayID = 37583 }; --Krkk'kx
	[50329] = { zoneID = 64, artID = { 69 }, x = 9080, y = 4060, overlay = { "9000-3980","9040-3840" }, displayID = 46999, event = 2 }; --Rrakk
	[50727] = { zoneID = 64, artID = { 69 }, x = 9460, y = 8160, overlay = { "9340-8060","9440-8160" }, displayID = 20834, event = 2 }; --Strix the Barbed
	[50741] = { zoneID = 64, artID = { 69 }, x = 3760, y = 5600, overlay = { "3740-5580" }, displayID = 1561, event = 2 }; --Kaxx
	[50748] = { zoneID = 64, artID = { 69 }, x = 4459, y = 4040, overlay = { "4400-4040" }, displayID = 481, event = 1 }; --Nyaj
	[50785] = { zoneID = 64, artID = { 69 }, x = 9420, y = 5859, overlay = { "9380-5740","9420-5860" }, displayID = 46995, event = 1 }; --Skyshadow
	[50892] = { zoneID = 64, artID = { 69 }, x = 5520, y = 4060, overlay = { "5520-4040" }, displayID = 25857, event = 2 }; --Cyn
	[50952] = { zoneID = 64, artID = { 69 }, x = 4135, y = 3685, overlay = { "4100-3620" }, displayID = 46994, event = 2 }; --Barnacle Jim
	[51001] = { zoneID = 64, artID = { 69 }, x = 8180, y = 9600, overlay = { "8140-9580" }, displayID = 15423, event = 1 }; --Venomclaw
	[51008] = { zoneID = 64, artID = { 69 }, x = 7119, y = 9480, overlay = { "7120-9480" }, displayID = 20912, event = 1 }; --The Barbed Horror
	[5933] = { zoneID = 64, artID = { 69 }, x = 6960, y = 4940, overlay = { "6960-4940","7020-5060","7100-4900","7200-5000" }, displayID = 9418 }; --Achellios the Banished
	[5934] = { zoneID = 64, artID = { 69 }, x = 1780, y = 4260, overlay = { "1220-3560","1300-3900","1420-4000","1540-4000","1640-4160","1740-4020","1740-4260" }, displayID = 11011 }; --Heartrazor
	[5935] = { zoneID = 64, artID = { 69 }, x = 6120, y = 6700, overlay = { "6120-6700" }, displayID = 46055 }; --Ironeye the Invincible
	[5937] = { zoneID = 64, artID = { 69 }, x = 0612, y = 4203, overlay = { "0540-4200" }, displayID = 10988 }; --Vile Sting
	[4015] = { zoneID = 65, artID = { 70 }, x = 5500, y = 4500, overlay = { "5500-4500","5540-4640" }, displayID = 4585 }; --Pridewing Patriarch
	[4030] = { zoneID = 65, artID = { 70 }, x = 3200, y = 7200, overlay = { "2800-7180","2860-6960","2880-6360","2920-6800","2920-7080","2940-6680","2940-7220","3040-6440","3040-7400","3080-7100","3080-7520","3100-6600","3100-6920","3140-6200","3140-6360","3140-6740","3140-7300","3160-6480","3200-6020","3200-7020","3220-7460","3260-6220","3260-6560","3260-7300","3280-6700","3320-7080","3340-6420","3340-6920","3380-6100","3400-6220","3420-7300","3460-6360","3500-7440","3520-7160","3540-7040","3540-7320","3660-7380","3700-7260" }, displayID = 9591 }; --Vengeful Ancient
	[4066] = { zoneID = 65, artID = { 70 }, x = 4827, y = 7347, overlay = { "4840-7340" }, displayID = 8471 }; --Nal'taszar
	[50343] = { zoneID = 65, artID = { 70 }, x = 6000, y = 6340, overlay = { "5960-6400" }, displayID = 46988, event = 2 }; --Quall
	[50759] = { zoneID = 65, artID = { 70 }, x = 5444, y = 7477, overlay = { "5440-7480" }, displayID = 42742, event = 2 }; --Iriss the Widow
	[50786] = { zoneID = 65, artID = { 70 }, x = 5900, y = 8660, overlay = { "5880-8640" }, displayID = 46990, event = 2 }; --Sparkwing
	[50812] = { zoneID = 65, artID = { 70 }, x = 4921, y = 6607, overlay = { "4940-6560" }, displayID = 46229, event = 2 }; --Arae
	[50825] = { zoneID = 65, artID = { 70 }, x = 7600, y = 9119, overlay = { "7600-9120" }, displayID = 46987, event = 2 }; --Feras
	[50874] = { zoneID = 65, artID = { 70 }, x = 4440, y = 4920, overlay = { "4440-4920" }, displayID = 19733, event = 1 }; --Tenok
	[50884] = { zoneID = 65, artID = { 70 }, x = 4479, y = 5579, overlay = { "4480-5580" }, displayID = 21268, event = 2 }; --Dustflight the Cowardly
	[50895] = { zoneID = 65, artID = { 70 }, x = 3980, y = 4600, overlay = { "3980-4600" }, displayID = 46998, event = 2 }; --Volux
	[50986] = { zoneID = 65, artID = { 70 }, x = 8219, y = 7920, overlay = { "8220-7920" }, displayID = 5245, event = 1 }; --Goldenback
	[51062] = { zoneID = 65, artID = { 70 }, x = 7460, y = 7320, overlay = { "7460-7320" }, displayID = 46225, event = 1 }; --Khep-Re
	[5915] = { zoneID = 65, artID = { 70 }, x = 4179, y = 1900, overlay = { "4180-1900" }, displayID = 4599 }; --Brother Ravenoak
	[5916] = { zoneID = 65, artID = { 70 }, x = 3520, y = 1740, overlay = { "3000-1560","3020-1440","3100-1340","3200-1500","3260-1640","3300-1760","3320-1360","3320-1900","3420-1740","3440-1400","3500-1600","3540-1940","3620-1440","3640-1580","3660-1760","3720-2080","3760-1460","3800-1840","3820-1640","4180-1600" }, displayID = 11356 }; --Sentinel Amarassan
	[5928] = { zoneID = 65, artID = { 70 }, x = 5020, y = 4120, overlay = { "5020-4120" }, displayID = 11012 }; --Sorrow Wing
	[5930] = { zoneID = 65, artID = { 70 }, x = 4040, y = 7080, overlay = { "4040-7080" }, displayID = 10875 }; --Sister Riven
	[5931] = { zoneID = 65, artID = { 70 }, x = 6320, y = 5100, overlay = { "6240-5180","6260-4640","6300-5480","6340-4520","6400-5260","6420-4380","6440-5000","6440-5140","6480-5360","6500-4600","6500-4800","6540-4420","6540-5540","6540-5660","6560-5140","6580-4960","6620-4520","6640-4680","6640-5240","6640-5360","6720-5060","6720-5460","6760-4540","6760-4720","6760-5220","6880-4620","6900-5040","6920-4360","6920-4860","6960-4720" }, displayID = 4600 }; --Foreman Rigger
	[5932] = { zoneID = 65, artID = { 70 }, x = 6440, y = 4540, overlay = { "6440-4540" }, displayID = 487 }; --Taskmaster Whipfang
	[11688] = { zoneID = {
		[66] = { x = 2786, y = 6266, artID = { 71 }, overlay = { "2786-6266" } };
		[67] = { x = 1994, y = 3927, artID = { 72 }, overlay = { "1220-5000","1300-4720","1440-4880","1460-4720","1520-4560","1520-5040","1580-3840","1580-4200","1640-4520","1640-5240","1660-3740","1680-5460","1700-4000","1720-4140","1740-5640","1760-3820","1760-4380","1820-5780","1840-6040","1860-4640","1900-4320","1920-4480","1920-5940","1940-3840","2020-5060","2040-4540","2040-6120","2060-4660","2100-4400","2100-4900","2140-5260","2140-5460","2200-4680","2200-5660","2200-5960","2260-6160","2280-4480","2340-4300","2680-4280","2940-4280" } };
	}, displayID = 11640 }; --Cursed Centaur
	[14225] = { zoneID = 66, artID = { 71 }, x = 7440, y = 1240, overlay = { "7440-1240","7540-1880","7740-2380" }, displayID = 2879 }; --Prince Kellen
	[14226] = { zoneID = 66, artID = { 71 }, x = 5000, y = 7200, overlay = { "5000-7200","5040-8120","5100-7520","5100-7660","5120-8480","5520-7640","5680-7440" }, displayID = 14255 }; --Kaskk
	[14227] = { zoneID = 66, artID = { 71 }, x = 4617, y = 5323, overlay = { "4180-4720","4240-4580","4300-4260","4300-6120","4620-5300","5140-4760","5140-4880" }, displayID = 45445 }; --Hissperak
	[14228] = { zoneID = 66, artID = { 71 }, x = 5740, y = 0840, overlay = { "5740-0840","5740-1000","5860-1840","5900-1720","6000-2540","6020-2400","6300-3420","6380-1960","6420-3360","6600-2420","6640-2580" }, displayID = 2714 }; --Giggler
	[14229] = { zoneID = 66, artID = { 71 }, x = 2900, y = 1340, overlay = { "2900-1340","2900-1460","3040-1880","3160-1340","3220-0580","3260-1500","3420-0940" }, displayID = 9135 }; --Accursed Slitherblade
	[18241] = { zoneID = 66, artID = { 71 }, x = 3440, y = 2160, overlay = { "3440-2160","3440-2340","3500-2000","3520-2540","3580-2400","3620-2240","3700-1980","3800-2080","3840-1900","3960-1800","4120-1880" }, displayID = 17625 }; --Crusty
	[11447] = { zoneID = 69, artID = { 74 }, x = 6920, y = 6140, overlay = { "6920-6140","6940-5980","6960-5820","6980-6260","7120-6340","7140-5780","7160-6140","7180-5940","7260-6280" }, displayID = 14382 }; --Mushgog
	[11497] = { zoneID = 69, artID = { 74 }, x = 8450, y = 4970, overlay = { "8450-4970" }, displayID = 37571 }; --The Razza
	[11498] = { zoneID = 69, artID = { 74 }, x = 8419, y = 3700, overlay = { "8420-3700" }, displayID = 10169 }; --Skarr the Broken
	[43488] = { zoneID = 69, artID = { 74 }, x = 4950, y = 3011, overlay = { "4920-3020" }, displayID = 21120 }; --Mordei the Earthrender
	[5343] = { zoneID = 69, artID = { 74 }, x = 3040, y = 4580, overlay = { "3040-4580","3100-4260","3180-4520","3240-4380" }, displayID = 11262 }; --Lady Szallah
	[5345] = { zoneID = 69, artID = { 74 }, x = 4900, y = 2079, overlay = { "4900-2080" }, displayID = 1817 }; --Diamond Head
	[5346] = { zoneID = 69, artID = { 74 }, x = 5180, y = 6060, overlay = { "5180-6060","5280-5940" }, displayID = 7336 }; --Bloodroar the Stalker
	[5347] = { zoneID = 69, artID = { 74 }, x = 5340, y = 6880, overlay = { "5340-6880","5360-7080","5380-6760","5400-6640","5440-6520","5460-7360","5480-6900","5520-6660","5520-7080","5580-7360" }, displayID = 10889 }; --Antilus the Soarer
	[5349] = { zoneID = 69, artID = { 74 }, x = 4110, y = 2429, overlay = { "3740-2200","3780-2340","3880-2420","3900-2040","4020-2460","4040-2240","4140-2400" }, displayID = 7569 }; --Arash-ethis
	[5350] = { zoneID = 69, artID = { 74 }, x = 7659, y = 6137, overlay = { "7340-6400","7640-6120" }, displayID = 11142 }; --Qirot
	[5352] = { zoneID = 69, artID = { 74 }, x = 5540, y = 6120, overlay = { "5540-6120","5580-5980","5580-6240","5600-5760","5720-6220","5760-5880","5860-6240","5880-5900","5920-6100","6000-5940","6080-6040","6080-6200" }, displayID = 706 }; --Old Grizzlegut
	[5354] = { zoneID = 69, artID = { 74 }, x = 6940, y = 4220, overlay = { "6940-4220","6940-4420","7000-4100","7060-4600","7120-4040","7140-3920","7180-4200","7180-4540","7200-4340","7240-4080","7260-3940" }, displayID = 2168 }; --Gnarl Leafbrother
	[5356] = { zoneID = 69, artID = { 74 }, x = 7520, y = 3640, overlay = { "7520-3640","7600-3860","7780-3780","7940-3920","8120-3860","8140-3980","8340-3880","8460-3800" }, displayID = 780 }; --Snarler
	[54533] = { zoneID = {
		[69] = { x = 4859, y = 7900, artID = { 74 }, overlay = { "4760-7460","4800-7840","4800-7720" } };
		[81] = { x = 2140, y = 0640, artID = { 86 }, overlay = { "2060-0840","2140-0640" } };
	}, displayID = 39009 }; --Prince Lakma <The Last Chimaerok>
	[14230] = { zoneID = 70, artID = { 498,75 }, x = 5904, y = 0933, overlay = { "5740-1660","5920-0920","6240-0820" }, displayID = 391 }; --Burgle Eye
	[14231] = { zoneID = 70, artID = { 498,75 }, x = 3980, y = 1924, overlay = { "3760-1840","3900-1820","3940-1960" }, displayID = 18313 }; --Drogoth the Roamer
	[14232] = { zoneID = 70, artID = { 498,75 }, x = 5142, y = 1686, overlay = { "4680-1740","4720-1600","4720-1860","4740-2000","4820-1420","4840-1580","4900-1720","4900-1880","5142-1686" }, displayID = 788 }; --Dart
	[14233] = { zoneID = 70, artID = { 498,75 }, x = 4378, y = 4999, overlay = { "3760-4920","3760-5060","4180-5520","4360-5080","4740-5440","4740-5560","4900-5760" }, displayID = 37748 }; --Ripscale
	[14234] = { zoneID = 70, artID = { 498,75 }, x = 4740, y = 6140, overlay = { "4740-6140","4780-6320","4840-5980","4860-6160" }, displayID = 2703 }; --Hayoc
	[14235] = { zoneID = 70, artID = { 498,75 }, x = 5163, y = 6069, overlay = { "5140-6060","5300-5880" }, displayID = 46282 }; --The Rot
	[14236] = { zoneID = 70, artID = { 498,75 }, x = 5594, y = 6328, overlay = { "5520-6320","5580-6500","5660-6240" }, displayID = 14257 }; --Lord Angler
	[14237] = { zoneID = 70, artID = { 498,75 }, x = 3711, y = 6256, overlay = { "3640-6240" }, displayID = 12336 }; --Oozeworm
	[4339] = { zoneID = 70, artID = { 498,75 }, x = 5020, y = 7540, overlay = { "5020-7540" }, displayID = 6369 }; --Brimgore
	[4380] = { zoneID = 70, artID = { 498,75 }, x = 3340, y = 2279, overlay = { "3340-2280" }, displayID = 17814 }; --Darkmist Widow
	[50342] = { zoneID = 70, artID = { 498,75 }, x = 3992, y = 2821, overlay = { "3940-2860" }, displayID = 33004, event = 2 }; --Heronis
	[50735] = { zoneID = 70, artID = { 498,75 }, x = 5147, y = 1679, overlay = { "5140-1680" }, displayID = 4435, event = 1 }; --Blinkeye the Rattler
	[50764] = { zoneID = 70, artID = { 498,75 }, x = 3859, y = 7484, overlay = { "3800-7440" }, displayID = 46518, event = 1 }; --Paraliss
	[50784] = { zoneID = 70, artID = { 498,75 }, x = 3338, y = 3096, overlay = { "3220-3100","3434-3040" }, displayID = 47124, event = 2 }; --Anith
	[50875] = { zoneID = 70, artID = { 498,75 }, x = 3388, y = 7037, overlay = { "3400-7040" }, displayID = 46287, event = 1 }; --Nychus
	[50901] = { zoneID = 70, artID = { 498,75 }, x = 4110, y = 4048, overlay = { "4180-4340","4200-4200","4110-4048" }, displayID = 46235, event = 2 }; --Teromak
	[50945] = { zoneID = 70, artID = { 498,75 }, x = 2934, y = 4377, overlay = { "2940-4340","2940-4460" }, displayID = 4714, event = 2 }; --Scruff
	[50957] = { zoneID = 70, artID = { 498,75 }, x = 5408, y = 4351, overlay = { "5380-4340" }, displayID = 46285, event = 2 }; --Hugeclaw
	[51061] = { zoneID = 70, artID = { 498,75 }, x = 5011, y = 8474, overlay = { "5020-8440" }, displayID = 15339, event = 1 }; --Roth-Salam
	[51069] = { zoneID = 70, artID = { 498,75 }, x = 5595, y = 8570, overlay = { "5580-8560" }, displayID = 46290, event = 2 }; --Scintillex
	[39183] = { zoneID = 71, artID = { 76 }, x = 4954, y = 5873, overlay = { "4940-5840" }, displayID = 31351 }; --Scorpitar
	[39185] = { zoneID = 71, artID = { 76 }, x = 4014, y = 6746, overlay = { "4000-6780" }, displayID = 31352 }; --Slaverjaw
	[39186] = { zoneID = 71, artID = { 76 }, x = 4450, y = 4031, overlay = { "4080-4120","4450-4031" }, displayID = 45946 }; --Hellgazer
	[44714] = { zoneID = 71, artID = { 76 }, x = 5702, y = 8963, overlay = { "5700-8980" }, displayID = 34030 }; --Fronkle the Disturbed
	[44722] = { zoneID = 71, artID = { 76 }, x = 6459, y = 1980, overlay = { "6440-2000" }, displayID = 11757 }; --Twisted Reflection of Narain
	[44750] = { zoneID = 71, artID = { 76 }, x = 4703, y = 6525, overlay = { "4700-6520" }, displayID = 9169 }; --Caliph Scorpidsting
	[44759] = { zoneID = 71, artID = { 76 }, x = 6950, y = 5720, overlay = { "6940-5700" }, displayID = 9073 }; --Andre Firebeard
	[44761] = { zoneID = 71, artID = { 76 }, x = 6958, y = 4987, overlay = { "6940-5000" }, displayID = 5564 }; --Aquementas the Unchained
	[44767] = { zoneID = 71, artID = { 76 }, x = 6100, y = 5040, overlay = { "6100-5040" }, displayID = 19060 }; --Occulus the Corrupted
	[47386] = { zoneID = 71, artID = { 76 }, x = 3680, y = 4759, overlay = { "3240-4860","3380-4600","3500-4460","3640-4240","3680-4380","3680-4660" }, displayID = 37549 }; --Ainamiss the Hive Queen
	[47387] = { zoneID = 71, artID = { 76 }, x = 5651, y = 6850, overlay = { "5040-7240","5240-6540","5280-7060","5560-6440","5620-6880" }, displayID = 15657 }; --Harakiss the Infestor
	[8199] = { zoneID = 71, artID = { 76 }, x = 4080, y = 2920, overlay = { "4080-2920" }, displayID = 9023 }; --Warleader Krazzilak
	[8200] = { zoneID = 71, artID = { 76 }, x = 3740, y = 2600, overlay = { "3740-2600","4080-3020" }, displayID = 9024 }; --Jin'Zallah the Sandbringer
	[8201] = { zoneID = 71, artID = { 76 }, x = 4278, y = 5317, overlay = { "3780-5680","3840-5340","3840-5460","3860-5200","3880-5820","3960-5060","4040-5860","4120-4980","4120-5140","4220-5480","4240-5280","4300-5580" }, displayID = 20017 }; --Omgorn the Lost
	[8202] = { zoneID = 71, artID = { 76 }, x = 3940, y = 5340, overlay = { "3920-5380","4020-7240","4180-5420","4480-6620","4600-6540" }, displayID = 11532 }; --Cyclok the Mad
	[8203] = { zoneID = 71, artID = { 76 }, x = 7341, y = 4764, overlay = { "7120-4680","7340-4740","7500-4540" }, displayID = 7509 }; --Kregg Keelhaul
	[8204] = { zoneID = {
		[71] = { x = 3491, y = 4625, artID = { 76 }, overlay = { "3491-4625" } };
		[72] = { x = 5340, y = 6780, artID = { 78 }, overlay = { "5340-6780","5340-7040" } };
	}, displayID = 14521 }; --Soriid the Devourer
	[8205] = { zoneID = {
		[71] = { x = 5672, y = 6839, artID = { 76 }, overlay = { "5672-6839" } };
		[73] = { x = 6015, y = 2538, artID = { 77 }, overlay = { "5820-2340","6020-2780","6060-2160","6080-2540" } };
	}, displayID = 15439 }; --Haarka the Ravenous
	[8207] = { zoneID = 71, artID = { 76 }, x = 4547, y = 3981, overlay = { "4440-4040","4820-4540","4547-3981" }, displayID = 34048 }; --Emberwing
	[13896] = { zoneID = 76, artID = { 81 }, x = 4308, y = 5160, overlay = { "4220-5020","4240-4640","4240-4840","4300-5160","4300-5280" }, displayID = 7046 }; --Scalebeard
	[6118] = { zoneID = 76, artID = { 81 }, x = 3406, y = 7436, overlay = { "3240-7720","3300-7500","3340-7640","3400-7340","3420-7160","3500-7720","3580-7120","3740-7440","3673-7750","3760-7560" }, displayID = 21587 }; --Varo'then's Ghost
	[6646] = { zoneID = 76, artID = { 81 }, x = 7100, y = 2040, overlay = { "5260-8260","5320-7860","5400-7960","5420-8160","5440-8340","5520-8640","5540-7940","5540-8060","5540-8460","5580-8320","5640-7840","5640-8780","5660-8440","5700-8580","5720-7640","5720-8100","5780-8780","5800-7740","5800-8320","5800-8480","5820-7980","5900-8080","5920-7740","5920-8860","5940-9000","5980-7900","7040-2200","7060-1820","7080-2480","7100-2040","7140-2300","7200-1840","7240-1980","7260-2120","7260-2280","7260-2460","7380-1860","7380-2160","7400-2560","7420-2020","7420-2420","7460-1580","7520-2160","7540-1860","7600-1680","7620-2260","7640-2120","7660-1500","7660-1920","7680-2380","7760-1640","7840-1780","7960-1700","8040-1860","8100-1700","8200-1860","8300-2240" }, displayID = 10042 }; --Monnos the Elder
	[6647] = { zoneID = 76, artID = { 81 }, x = 5640, y = 2820, overlay = { "5640-2820","5680-3000","5940-3120" }, displayID = 21180 }; --Magister Hawkhelm
	[6648] = { zoneID = 76, artID = { 81 }, x = 4440, y = 2640, overlay = { "4440-2640","4440-2760" }, displayID = 3212 }; --Antilos
	[6649] = { zoneID = 76, artID = { 81 }, x = 4417, y = 5977, overlay = { "4400-5980" }, displayID = 11261 }; --Lady Sesspira
	[6650] = { zoneID = 76, artID = { 81 }, x = 6070, y = 7765, overlay = { "5880-7700","6040-7760","6160-7880","6180-7720","6300-7960","6300-8120","6300-8240" }, displayID = 11257 }; --General Fangferror
	[6651] = { zoneID = 76, artID = { 81 }, x = 3273, y = 3282, overlay = { "3300-3240" }, displayID = 1012 }; --Gatekeeper Rageroar
	[6652] = { zoneID = 76, artID = { 81 }, x = 6180, y = 2380, overlay = { "6040-2480","6120-2620","6180-2380","6260-2520","6440-1720","6560-1740" }, displayID = 2687 }; --Master Feardred
	[8660] = { zoneID = 76, artID = { 81 }, x = 1399, y = 5040, overlay = { "1380-5060","1440-5740" }, displayID = 37569 }; --The Evalcharr
	[14339] = { zoneID = 77, artID = { 82 }, x = 4820, y = 7440, overlay = { "4820-7440","5380-8480" }, displayID = 36341 }; --Death Howl
	[14340] = { zoneID = 77, artID = { 82 }, x = 3920, y = 8000, overlay = { "3920-8000","4000-8220","4080-8380","4240-8460","4320-8560" }, displayID = 2879 }; --Alshirr Banebreath
	[14342] = { zoneID = 77, artID = { 82 }, x = 4865, y = 8915, overlay = { "4860-8900" }, displayID = 1012 }; --Ragepaw
	[14343] = { zoneID = 77, artID = { 82 }, x = 5440, y = 2640, overlay = { "5440-2640","5480-2320","5620-2360","5700-1840","5740-1960" }, displayID = 37568 }; --Olm the Wise
	[14344] = { zoneID = 77, artID = { 82 }, x = 4366, y = 7580, overlay = { "4340-7580","4680-8200" }, displayID = 14315 }; --Mongress
	[14345] = { zoneID = 77, artID = { 82 }, x = 4200, y = 4580, overlay = { "4200-4580" }, displayID = 682 }; --The Ongar
	[50362] = { zoneID = 77, artID = { 82 }, x = 3480, y = 5959, overlay = { "3480-5960" }, displayID = 20596, event = 1 }; --Blackbog the Fang
	[50724] = { zoneID = 77, artID = { 82 }, x = 6060, y = 2220, overlay = { "6040-2200" }, displayID = 20297, event = 2 }; --Spinecrawl
	[50777] = { zoneID = 77, artID = { 82 }, x = 5100, y = 3420, overlay = { "5100-3420" }, displayID = 18041, event = 1 }; --Needle
	[50833] = { zoneID = 77, artID = { 82 }, x = 4060, y = 3100, overlay = { "3940-3160" }, displayID = 38913, event = 1 }; --Duskcoat
	[50864] = { zoneID = 77, artID = { 82 }, x = 5930, y = 0688, overlay = { "5940-0680" }, displayID = 46831, event = 1 }; --Thicket
	[50905] = { zoneID = 77, artID = { 82 }, x = 4500, y = 3180, overlay = { "4500-3180" }, displayID = 46830, event = 2 }; --Cida
	[50925] = { zoneID = 77, artID = { 82 }, x = 3820, y = 7260, overlay = { "3820-7260" }, displayID = 9569, event = 2 }; --Grovepaw
	[51017] = { zoneID = 77, artID = { 82 }, x = 5259, y = 3160, overlay = { "5240-3140" }, displayID = 20142, event = 2 }; --Gezan
	[51025] = { zoneID = 77, artID = { 82 }, x = 4220, y = 4820, overlay = { "4220-4740" }, displayID = 12335, event = 2 }; --Dilennaa
	[51046] = { zoneID = 77, artID = { 82 }, x = 3842, y = 5286, overlay = { "3840-5280" }, displayID = 46517, event = 1 }; --Fidonis
	[7104] = { zoneID = 77, artID = { 82 }, x = 5780, y = 1939, overlay = { "5780-1940" }, displayID = 9013 }; --Dessecus
	[7137] = { zoneID = 77, artID = { 82 }, x = 4060, y = 4340, overlay = { "4060-4340","4140-4200","4180-3860" } }; --Immolatus
	[6581] = { zoneID = 78, artID = { 83 }, x = 6080, y = 7280, overlay = { "6080-7280","6640-6700" }, displayID = 11319 }; --Ravasaur Matriarch
	[6582] = { zoneID = {
		[78] = { x = 4875, y = 8529, artID = { 83 }, overlay = { "4875-8529" } };
		[79] = { x = 7680, y = 5240, artID = { 84 }, overlay = { "7680-5240","7860-4780","8020-4560" } };
	}, displayID = 11084 }; --Clutchmother Zavas
	[6583] = { zoneID = 78, artID = { 83 }, x = 3180, y = 7819, overlay = { "3180-7820","3300-7940" }, displayID = 37587 }; --Gruff
	[6584] = { zoneID = 78, artID = { 83 }, x = 2900, y = 3640, overlay = { "2900-3640","2920-4740","2940-4240","2940-4600","3000-3560","3000-4440","3080-3180","3120-2940","3140-3660","3200-3040","3260-3660","3340-2840","3340-3560","3420-3720","3520-3580","3520-3900","3620-3700","3640-3060","3640-3540","3680-3220","3700-2940","3700-3380","3760-3100" }, displayID = 5305 }; --King Mosh
	[6585] = { zoneID = 78, artID = { 83 }, x = 6291, y = 1861, overlay = { "6280-1840" }, displayID = 8129 }; --Uhk'loc
	[14471] = { zoneID = 81, artID = { 86 }, x = 3600, y = 8219, overlay = { "3600-8220" }, displayID = 5965 }; --Setis
	[14472] = { zoneID = 81, artID = { 86 }, x = 3559, y = 3800, overlay = { "3560-3800","3580-3960","3640-4200","4440-5100","4460-4900","4560-5040","5160-5620","5300-5460","5300-5580","6400-5760" }, displayID = 1104 }; --Gretheer
	[14473] = { zoneID = 81, artID = { 86 }, x = 5540, y = 7100, overlay = { "5540-7100","5600-7440","5720-7500","5860-6680","6080-6880","6160-6600","6300-7340","6360-8200","6560-7520" }, displayID = 37593 }; --Lapress
	[14474] = { zoneID = 81, artID = { 86 }, x = 2700, y = 6200, overlay = { "2700-6200","3200-5580","3380-5340" }, displayID = 37548 }; --Zora
	[14475] = { zoneID = 81, artID = { 86 }, x = 5100, y = 2300, overlay = { "5100-2300","5140-2660","5200-2480" }, displayID = 37579 }; --Rex Ashil
	[14476] = { zoneID = 81, artID = { 86 }, x = 6240, y = 1840, overlay = { "6240-1840","6440-3900","6720-2920","6920-3680" }, displayID = 6068 }; --Krellack
	[14477] = { zoneID = 81, artID = { 86 }, x = 3400, y = 7320, overlay = { "3400-7320","3440-7100","4100-6580","4120-6440","4880-7140","4920-7260","4940-6380","5020-6140","5080-6260" }, displayID = 14523 }; --Grubthor
	[14478] = { zoneID = 81, artID = { 86 }, x = 2920, y = 1920, overlay = { "2920-1920","3020-2420","3080-2620","3200-1560","3220-2660","3320-1480","3420-2600","3520-1620","3620-1780","3660-2200","3680-2360","3020-1660" }, displayID = 14525 }; --Huricanian
	[14479] = { zoneID = 81, artID = { 86 }, x = 2540, y = 7719, overlay = { "2540-7720","2620-7500","2640-7640","3300-3000","3440-3180","3500-3040","4420-4020","4520-4260","4660-4120" }, displayID = 14526 }; --Twilight Lord Everun <Twilight's Hammer>
	[50370] = { zoneID = 81, artID = { 86 }, x = 5760, y = 1480, overlay = { "5700-1440" }, displayID = 20067, event = 2 }; --Karapax
	[50737] = { zoneID = 81, artID = { 86 }, x = 7360, y = 1600, overlay = { "7360-1600" }, displayID = 46985, event = 1 }; --Acroniss
	[50742] = { zoneID = 81, artID = { 86 }, x = 4400, y = 1720, overlay = { "4380-1760" }, displayID = 46982, event = 2 }; --Qem
	[50743] = { zoneID = 81, artID = { 86 }, x = 6780, y = 6680, overlay = { "6720-6640" }, displayID = 46983, event = 2 }; --Manax
	[50744] = { zoneID = 81, artID = { 86 }, x = 5460, y = 2660, overlay = { "5440-2640" }, displayID = 46981, event = 2 }; --Qu'rik
	[50745] = { zoneID = 81, artID = { 86 }, x = 4260, y = 5660, overlay = { "4220-5580","4220-5700" }, displayID = 15658, event = 2 }; --Losaj
	[50746] = { zoneID = 81, artID = { 86 }, x = 6360, y = 8880, overlay = { "6260-8940" }, displayID = 15656, event = 2 }; --Bornix the Burrower
	[50747] = { zoneID = {
		[81] = { x = 3800, y = 8580, artID = { 86 }, overlay = { "3800-8580" } };
		[327] = { x = 6080, y = 0660, artID = { 339 }, overlay = { "6040-0620" } };
	}, displayID = 15334, event = 2 }; --Tix
	[50897] = { zoneID = 81, artID = { 86 }, x = 3300, y = 5340, overlay = { "3220-5300" }, displayID = 46980, event = 2 }; --Ffexk the Dunestalker
	[51004] = { zoneID = 81, artID = { 86 }, x = 4280, y = 1820, overlay = { "4240-1720" }, displayID = 46984, event = 2 }; --Toxx
	[10196] = { zoneID = 83, artID = { 88 }, x = 6110, y = 6404, overlay = { "5560-6420","5640-6560","5780-6560","5900-6540","6060-6400","6240-6420" }, displayID = 9489 }; --General Colbatann
	[10197] = { zoneID = 83, artID = { 88 }, x = 2450, y = 5189, overlay = { "2400-5040","2420-5160" }, displayID = 3208 }; --Mezzir the Howler
	[10198] = { zoneID = 83, artID = { 88 }, x = 6120, y = 8380, overlay = { "6120-8380" }, displayID = 10317 }; --Kashoch the Reaver
	[10199] = { zoneID = 83, artID = { 88 }, x = 6840, y = 5020, overlay = { "6840-5020" }, displayID = 9491 }; --Grizzle Snowpaw
	[10200] = { zoneID = 83, artID = { 88 }, x = 4680, y = 1939, overlay = { "4680-1940","4740-1820" }, displayID = 10054 }; --Rak'shiri
	[10201] = { zoneID = 83, artID = { 88 }, x = 5280, y = 8860, overlay = { "5100-8560","5140-8420","5280-8400","5280-8720","5280-8860","5300-8540","5400-8460","5420-8700","6220-7860","6320-7980","6400-7820","6420-8100","6440-7980","6560-7960" }, displayID = 10925 }; --Lady Hederine
	[10202] = { zoneID = 83, artID = { 88 }, x = 5240, y = 5900, overlay = { "5240-5900","5260-6180","5680-5700","5800-5600","6080-5380","6180-5460","6300-5480","6420-5600","6560-6640","6560-6760","6580-5860","6580-6100","6580-6440","6600-6300" }, displayID = 6373 }; --Azurous
	[10741] = { zoneID = 83, artID = { 88 }, x = 4580, y = 1740, overlay = { "4580-1740" }, displayID = 10114 }; --Sian-Rotam
	[50346] = { zoneID = 83, artID = { 88 }, x = 5980, y = 4280, overlay = { "5940-4260" }, displayID = 17093, event = 1 }; --Ronak
	[50348] = { zoneID = 83, artID = { 88 }, x = 5959, y = 2400, overlay = { "5940-2380" }, displayID = 17092, event = 1 }; --Norissis
	[50353] = { zoneID = 83, artID = { 88 }, x = 6400, y = 8000, overlay = { "6400-8000" }, displayID = 45200, event = 2 }; --Manas
	[50788] = { zoneID = 83, artID = { 88 }, x = 6680, y = 8359, overlay = { "6680-8340" }, displayID = 46996, event = 1 }; --Quetzl
	[50819] = { zoneID = 83, artID = { 88 }, x = 5200, y = 1880, overlay = { "5200-1840" }, displayID = 9951, event = 1 }; --Iceclaw
	[50993] = { zoneID = 83, artID = { 88 }, x = 3552, y = 4903, overlay = { "3540-4840" }, displayID = 26267, event = 1 }; --Gal'dorak
	[50995] = { zoneID = 83, artID = { 88 }, x = 6600, y = 4200, overlay = { "6540-4160","6580-4280" }, displayID = 28648, event = 2 }; --Bruiser
	[50997] = { zoneID = 83, artID = { 88 }, x = 6240, y = 2480, overlay = { "5920-1640","5980-1760","6220-2440" }, displayID = 26295, event = 2 }; --Bornak the Gorer
	[51028] = { zoneID = 83, artID = { 88 }, x = 5060, y = 7219, overlay = { "5060-7220" }, displayID = 37551, event = 1 }; --The Deep Tunneler
	[51045] = { zoneID = 83, artID = { 88 }, x = 4800, y = 5959, overlay = { "4800-5940" }, displayID = 24906, event = 1 }; --Arcanus
	[3581] = { zoneID = 84, artID = { 89 }, x = 4840, y = 6180, overlay = { "4840-6180","5220-6420","5400-6820","5420-6480","5440-7080","5480-6940","5560-6500","5600-7280","5620-7420","5620-7660","5760-4280","5760-7340","5780-7760","5800-4120","5840-7920","5900-4300","5940-4520","6020-4300","6040-7220","6120-4720","6180-4880","6200-5100","6360-4900","6440-6040","6500-6540","6560-5080","6600-6120","6640-6420","6660-5840","6700-5500","6740-5300","6740-6200","6780-6400","6780-6600","6860-5340","6880-5040","6900-6540","6940-5160","6940-6340","6960-4920","7020-6580","7060-6800","7100-4880" }, displayID = 2850 }; --Sewer Beast
	[16854] = { zoneID = 94, artID = { 99 }, x = 6820, y = 4500, overlay = { "6820-4500","6860-4620","6900-4840","6980-4640","6980-4960" }, displayID = 14272 }; --Eldinarcus
	[16855] = { zoneID = 94, artID = { 99 }, x = 6280, y = 7960, overlay = { "6280-7960","6320-7820","6460-7800","6480-6720","6600-6900","6620-7900","6800-7940","6860-7180","6900-8120","6920-7320","6940-7460","6940-7840","7020-7240","7080-7540" }, displayID = 16406 }; --Tregla
	[22062] = { zoneID = 95, artID = { 100 }, x = 2940, y = 8840, overlay = { "2940-8840","3420-4860","3440-4720","3540-8860","4000-5000" }, displayID = 16176 }; --Dr. Whitherlimb
	[18677] = { zoneID = 100, artID = { 105 }, x = 4262, y = 6436, overlay = { "4100-7100","4160-6900","4180-6760","4220-6540","4280-6420","4380-6240","4460-5960","4480-3960","4500-4280","4540-4440","4560-4100","4600-5960","4660-4440","4680-4620","4700-5840","4820-5020","4860-5360","4960-5240","5020-5080","5180-5120","5320-5060","5560-5040","6480-7240","6520-7100","6740-6840","6760-7340","6780-7680","6880-7020","6960-6900" }, displayID = 20761 }; --Mekthorg the Wild
	[18678] = { zoneID = 100, artID = { 105 }, x = 2360, y = 5680, overlay = { "2360-5680","2360-5820","2360-5960","2360-6100","2480-4800","2480-4960","2580-4580","2620-4380","2740-4240","2860-6580","2900-4080","3000-6480","3080-3700","3140-6120","3360-6120","3540-5700","3720-5280","4040-5180","4240-7220","4360-5040","4380-7100","4500-4880","4640-6980","4900-7040","5080-7020","5340-7160","5460-7180","5660-7180","3080-6240","2420-6360" }, displayID = 17445 }; --Fulgorge
	[18679] = { zoneID = 100, artID = { 105 }, x = 7140, y = 5600, overlay = { "7140-5600","7400-3780","3880-3200","3920-3020","4020-3120","4040-3240","4080-3420","4100-2900","4200-3320","4240-2940","4240-3140","5280-2840","5300-2700","5360-2940","5400-2800","5460-3040","5460-3160","5520-2900","5620-3000","5660-3140","5780-3020","5880-2880","5940-3080","6060-3040","6200-2960","6260-3080","6340-2860","6360-3260","6420-3060","6500-2920","6580-3100","6960-4500","7000-5740","7040-4600","7060-4380","7080-5440","7120-4720","7120-6240","7140-5920","7140-6040","7200-4480","7220-5440","7220-5740","7240-3980","7260-4360","7260-5600","7300-5880","7320-4200","7380-5600","7400-4060","7500-3880","7600-4100" }, displayID = 20044 }; --Vorakem Doomspeaker <Herald of Doom Lord Kazzak>
	[18680] = { zoneID = 102, artID = { 107 }, x = 0980, y = 5220, overlay = { "0980-5220","1080-4720","1100-5040","1480-4440","1500-4040","1600-3820","3780-3840","3880-3380","4040-3360","4220-3360","4300-3460","4460-3420","4700-3200","4740-3060","5000-3080","5240-3240","5400-3300","7020-3980","7040-3740","7580-4840","7700-5140","7880-5360","1000-5380","1100-4560","1100-5580","1120-4860","1240-4660","1360-4480","1460-4220","1640-3580","1740-3480","1800-3240","1820-3020","3740-3640","3940-3240","4080-3240","4500-2960","4580-3560","4640-3340","4860-3020","5080-3280","5460-3420","5620-3420","6940-3860","7080-4100","7100-4220","7180-3540","7240-3680","7300-4620","7360-4320","7400-3660","7400-4480","7420-4700","7580-5000","7720-5260" }, displayID = 45045 }; --Marticar
	[18681] = { zoneID = 102, artID = { 107 }, x = 2540, y = 3740, overlay = { "2540-3740","2580-4240","2620-4660","5980-3640","6200-6920","6300-3800","6340-4380","6380-6500","6440-6940","6480-4140","7040-7280","7220-7600","7340-8240","7480-7700" }, displayID = 20768 }; --Coilfang Emissary
	[18682] = { zoneID = 102, artID = { 107 }, x = 2300, y = 2140, overlay = { "2300-2140","2440-2060","2820-2320","4020-6180","4480-5900","4920-5820","8480-7960","8600-8420","8600-8960","8600-9120","2160-2100","2200-2240","2200-2360","2260-2480","2260-2600","2280-2760","2340-2920","2480-2760","2500-2920","2600-2020","2620-2700","2640-2820","2660-2420","2760-2680","2780-2140","2940-2220","3960-6460","4120-6080","4220-5940","4280-6060","4640-5860","4820-5900","4920-6680","5000-6480","5040-5980","5040-6700","5080-6260","5180-5980","5180-6160","8200-7840","8260-7720","8300-7960","8440-7820","8520-8720","8580-8540","8620-8080","8620-8280","8640-8840" }, displayID = 20769 }; --Bog Lurker
	[18694] = { zoneID = 104, artID = { 109 }, x = 3660, y = 4500, overlay = { "3660-4500","3760-4320","3940-4280","5500-7120","5880-7040","6660-2620","6720-2320","7060-2880","7300-3020","7360-2900","4080-4640","4280-4740","4300-4920","4440-4980","4440-5240","4560-5240","4600-5380","5540-7280","5660-7420","5780-2400","5800-7320","5840-7180","5900-2280","5960-7140","6020-2140","6100-6740","6140-2120","6220-6400","6260-2140","6320-2280","6440-6660","6440-6800","6460-2260","6580-2300","6640-6840","6660-2500","6660-2740","6660-6960","6720-2140","6760-2880","6800-6820","6900-2960","6940-6640","6940-6760","7040-2760","7040-3020","7080-6680","7220-2860" }, displayID = 20590 }; --Collidus the Warp-Watcher
	[18695] = { zoneID = 104, artID = { 109 }, x = 2800, y = 4840, overlay = { "2800-4840","2900-5500","2920-5040","2960-5260","3060-5820","4500-2880","4500-3060","4620-2880","4640-6600","4640-6940","4660-2620","4660-2760","4660-7100","4780-6720","5580-3800","5620-3560","5700-3860","5740-3500","5740-3700","5860-3640","6800-6120","6880-5980","7100-6220" }, displayID = 11347 }; --Ambassador Jerrikar <Servant of Illidan>
	[18696] = { zoneID = 104, artID = { 109 }, x = 3100, y = 4520, overlay = { "3100-4520","4180-4060","4200-3940","4200-6880","4540-1240","5940-4640" }, displayID = 20810 }; --Kraator
	[18690] = { zoneID = 105, artID = { 110 }, x = 6040, y = 2480, overlay = { "6040-2480","6340-5160","6720-4780","6800-6700","6840-6940","6880-4660","7100-2920","5920-2440","5940-2020","5940-2240","6040-2120","6080-2300","6140-1880","6140-5460","6180-2100","6260-5320","6320-5040","6500-4920","6500-5340","6520-4720","6520-5040","6700-4900","6720-6820","6740-6540","6740-7020","6780-7340","6800-3360","6820-7560","6840-3060","6840-3240","6840-7120","6860-6440","6860-6580","6920-4500","6940-3380","7060-4300","7060-4420","7080-4180","7160-3340","7220-2840","7300-3260","7320-2980","7360-2460","7400-2620","7420-2740","7440-2340","7680-2380","7780-2880","7780-3000","7840-2680" }, displayID = 20862 }; --Morcrush
	[18692] = { zoneID = 105, artID = { 110 }, x = 2800, y = 6619, overlay = { "2800-6620","2840-6760","2920-6360","2940-4940","2940-7000","2980-4740","2980-7120","3000-4540","3000-6500","3020-6740","3040-5140","3100-6900","3140-5700","3180-5300","3180-5560" }, displayID = 8574 }; --Hemathion
	[18693] = { zoneID = 105, artID = { 110 }, x = 3920, y = 5640, overlay = { "3920-5640","4060-5560","4080-4820","4080-4960","4140-5120","4140-5420","4180-5600","4240-5000","4240-8200","4340-8000","4380-7860","4520-7640","4640-7800","4680-7640","4720-7520","5580-3560","5600-2580","5620-3420","5640-2440","5640-2700","5740-2900","5740-3340","5760-3020","5780-3220","6440-1920","6520-2100","6560-2240","6620-2400","6620-2520","6640-2660","4180-5260","4660-7960" }, displayID = 20762 }; --Speaker Mar'grom
	[22060] = { zoneID = 106, artID = { 111 }, x = 1480, y = 5460, overlay = { "1480-5460" }, displayID = 20771 }; --Fenissa the Assassin
	[17144] = { zoneID = 107, artID = { 112 }, x = 4140, y = 4140, overlay = { "4140-4140","4400-4700","4480-4040","5820-2780","7460-7600","7580-7560","7600-7960","7600-8080","7620-7800","3120-5040","3140-5240","3180-4920","3320-5100","3320-5280","3340-4980","3420-4780","3480-4980","3480-5140","3580-4620","3640-4480","3740-4700","4000-4380","4020-4220","4040-4620","4240-4760","4340-3920","4440-4200","4520-4360","4520-4640","5540-2960","5600-2720","5640-2500","5660-2920","5780-2980","5800-2280","5800-3260","5860-3080","5900-2600","6000-2900","6000-3300","6020-2760","6140-2920","6140-3220","6180-3060","7500-7460","7620-7680","7660-8220","7760-8120","7780-7960" }, displayID = 20763 }; --Goretooth
	[18683] = { zoneID = 107, artID = { 112 }, x = 3220, y = 7040, overlay = { "3220-7040","3220-7160","3240-7320","3280-6880","3300-7460","3340-6740","3360-7580","3420-6620","3500-7680","3580-6560","3620-7700","3720-6580","3820-7600","3900-6820","3900-7440","3940-7320","3960-7080","3960-7200" }, displayID = 19681 }; --Voidhunter Yar
	[18684] = { zoneID = 107, artID = { 112 }, x = 2560, y = 5180, overlay = { "2560-5180","2700-4200","5000-5220","6000-7520","6020-7160","6040-7660","6080-7280","6480-7700","6760-7380","6920-7160","6980-7040","2480-5380","2540-5060","2600-4900","2600-5400","2660-4620","2720-3880","2720-4420","2720-4740","2800-4060","2860-3780","2880-3640","2920-3460","3000-3300","3100-3200","3120-2080","3140-3040","3260-3120","3280-2780","3280-2920","3300-2240","3320-1940","3320-2360","3320-2540","4400-5580","4440-5460","4460-5740","4580-5860","4800-6180","4940-6080","4940-6280","5120-5140","5120-6060","5220-5940","5280-5200","5280-5800","5300-5620","5340-5460","5900-7180","5920-8020","6040-7840","6200-7400","6340-7600","6620-7620","6760-7520","6840-7260","6980-6920","7100-7040" }, displayID = 18070 }; --Bro'Gaz the Clanless
	[18685] = { zoneID = 108, artID = { 113 }, x = 3040, y = 4340, overlay = { "3040-4340","3180-4220","4900-1740","4980-1880","5600-7040","5620-6920","5660-6780","5680-7140","5700-6580","5780-2320","5920-2420" }, displayID = 20766 }; --Okrek
	[18686] = { zoneID = 108, artID = { 113 }, x = 3559, y = 3780, overlay = { "3560-3780","3580-3440","3580-3580","3580-3920","3640-4060","3640-4220","4100-2560","4240-2660","4380-2640","4500-2640","4660-2640","4840-2560","4960-2520","5080-2500","5240-2380","5300-2220","5420-2060","5540-1980","5540-3240","5660-3260","5900-3440","6060-3520","6200-3640","6360-3840","6440-3940","6540-4120","6720-4520","6880-4740","7040-4880","5800-3360","6640-4420" }, displayID = 20767 }; --Doomsayer Jurim
	[18689] = { zoneID = 108, artID = { 113 }, x = 3040, y = 6380, overlay = { "3040-6380","3200-5520","3240-5200","3820-6500","3820-6640","3920-6820","3960-4860","4000-5040","4000-6240","4120-6540","4140-6340","4480-5620","4520-7400","4520-7920","4580-5960","4760-6260","4820-7460","4840-5540","4840-5740","4940-7100","2880-5580","2880-6340","2960-5820","3060-5520","3140-5940","3160-6060","3160-6320","3180-6440","3220-6180","3260-5040","3320-5600","3380-5220","3380-5720","3500-5480","3520-5660","3580-6720","3620-5580","3700-6400","3760-6820","3840-4840","3840-5160","3840-7020","3920-5400","3920-6420","4000-5280","4160-5420","4200-5580","4280-5420","4280-5700","4540-5820","4540-6220","4560-5320","4560-5520","4560-7620","4620-6340","4640-5420","4640-7880","4680-7040","4700-7620","4720-5900","4760-5420","4800-7040","4820-7620","4880-6220","4900-7240","4960-7540","5000-6200","5020-7420","5080-6900","5100-6680" }, displayID = 12073 }; --Crippler
	[21724] = { zoneID = 108, artID = { 113 }, x = 7619, y = 8120, overlay = { "7620-8120" }, displayID = 20425 }; --Hawkbane
	[18697] = { zoneID = 109, artID = { 114 }, x = 2620, y = 4040, overlay = { "2620-4040","2640-4240","2680-3600","2700-3720","2720-3840","2800-4000","4620-8000","4640-8220","4720-8080","4740-8460","4820-8160","5860-6400","5880-6260","5920-6720","6080-6560" }, displayID = 20765 }; --Chief Engineer Lorthander
	[18698] = { zoneID = 109, artID = { 114 }, x = 2060, y = 6820, overlay = { "2060-6820","2120-7640","2280-6440","2400-7560","2440-4140","2600-4220","2680-6500","2680-7280","2700-6980","2720-4260","2800-4120","2920-4000","2960-4140","3080-4180","5760-3900","5760-4260","5960-3340","5980-3520","6100-4660","6120-3220","6500-3260","1940-7180","1980-6940","2040-7340","2060-6660","2100-7520","2160-6540","2340-3920","2400-3720","2440-6460","2740-6680","2800-7240","2820-6520","2840-7120","2880-4420","2920-4300","3040-4300","5740-4020","5760-4400","5840-3740","5880-4520","6180-4760","6340-3200","6420-4820","6560-3380","6580-4660","6640-4520","6680-3480","6680-3720","6740-3860","6780-4480","6800-4040","6800-4160","6840-4300" }, displayID = 20764 }; --Ever-Core the Punisher
	[20932] = { zoneID = 109, artID = { 114 }, x = 2320, y = 7880, overlay = { "2320-7880","2480-8020","2680-8140","3280-3040","3300-3200","3420-2080","3440-2500","3440-2760","3480-3020","3520-1960","3560-2440","3560-7800","3840-7840","4040-7720","4420-7180","5420-5980","5640-5880","5720-6020","6360-5880","6560-5820","6760-6040","2260-8000","2400-8180","2660-8360","2780-8040","2860-8240","2980-8240","3000-8080","3040-7960","3120-7840","3200-8180","3280-2880","3340-3360","3420-7740","3440-2220","3440-2900","3460-3340","3500-2620","3540-3180","3600-2120","3620-3480","3640-2280","3680-2400","3920-7740","4040-8020","4220-7600","4240-6840","4260-6960","4380-6940","4380-7440","4380-7800","4400-7060","4440-7660","4540-7080","4580-7320","5220-5620","5260-5960","5380-5680","5440-6100","5560-6100","5740-5740","5840-6000","5980-5820","6000-6060","6100-5860","6140-6000","6220-6100","6400-6160","6520-6120","6540-6240","6660-6180","6680-5920" }, displayID = 19913 }; --Nuramoc
	[32357] = { zoneID = 114, artID = { 119 }, x = 3380, y = 3080, overlay = { "3380-3080","2060-2780","2120-2980","2180-2700","2180-3460","2220-3580","2240-3340","2360-3580","2440-3440","2560-3460","2700-3560","2960-3320","3000-3200","3080-3060","3200-3140","3320-2440","3320-3400","3420-2360","3440-2540","3460-2740","3540-3000","3560-3160","3600-2820","3720-2900" }, displayID = 24960 }; --Old Crystalbark
	[32358] = { zoneID = 114, artID = { 119 }, x = 5760, y = 1880, overlay = { "5760-1880","5900-2320","5920-2480","6020-1540","6140-2260","6140-3020","6160-2060","6260-1880","6260-3480","6340-1600","6340-2780","6500-1740","6580-3500","6600-1980","6620-3620","6680-2200","6780-2860","6840-3660","6860-1920","6960-3140","6960-3740","6980-3860","7060-2960","7100-3420","7200-3600","7220-2720","5920-2180","5960-1940","5980-2620","6000-1700","6040-2360","6040-2840","6060-2500","6280-2900","6300-3240","6320-2540","6380-1760","6440-3240","6460-3500","6540-3360","6620-1800","6700-2080","6720-3500","6780-2340","6780-2640","6900-2940","7160-2840","7300-3420","7400-3020" }, displayID = 24103 }; --Fumblub Gearwind
	[32361] = { zoneID = 114, artID = { 119 }, x = 8040, y = 4600, overlay = { "8040-4600","8120-3160","8460-4680","8540-3440","8820-3960","9140-3240","8980-4340","9120-3380" }, displayID = 26286 }; --Icehorn
	[32400] = { zoneID = 115, artID = { 120 }, x = 5460, y = 5440, overlay = { "5460-5440","5700-5080","5740-4840","5860-5940","5940-2880","5960-4300","6080-3260","6140-5820","6160-4840","6220-5020","6240-5440","6260-5280","6360-3620","6700-3100","6760-2980","6800-5880","6900-4840","6920-5600","6960-5420","5300-5600","5380-5940","5420-5820","5600-5300","5700-5540","5720-4660","5720-5340","5720-5860","5780-4060","5780-4440","5800-5700","5840-4260","5880-5800","5900-3840","5960-3680","5980-6040","6080-4680","6100-5620","6140-6040","6160-4380","6200-3940","6220-4180","6240-5560","6300-3860","6320-5160","6540-3520","6620-3880","6660-3420","6660-3560","6680-3220","6700-4140","6700-4320","6700-4560","6700-5980","6780-5720","6800-4700","6820-2780","6920-3440","6920-4660","6940-2780","7060-2940","7060-3080" }, displayID = 27951 }; --Tukemuth
	[32409] = { zoneID = 115, artID = { 120 }, x = 1540, y = 4520, overlay = { "1540-4520","1540-5820","2020-5500","2400-5340","2640-5800","2860-6140","3040-5860","3320-5680","1460-5960","1520-5680","2040-5380","2880-6020","3320-5540" }, displayID = 28284 }; --Crazed Indu'le Survivor
	[32417] = { zoneID = 115, artID = { 120 }, x = 6900, y = 7580, overlay = { "6900-7580","7120-2240","7180-7320","7200-2540","7200-7040","7540-2720","8580-3660","8640-4080","8800-3640","6900-7460","7200-7460","8760-4200" }, displayID = 10294 }; --Scarlet Highlord Daion
	[32422] = { zoneID = 116, artID = { 121 }, x = 1020, y = 3720, overlay = { "1020-3720","1040-3940","1100-4120","1120-7100","1140-4260","1200-5560","1220-4360","1240-5400","1260-4500","1280-5000","1300-4800","1320-4660","1320-5140","1340-5500","1340-7040","1420-5340","1480-5160","1500-7000","1520-5040","1640-6940","1720-7040","1840-7240","1880-7100","2000-7240","2020-5620","2100-7160","2140-5700","2220-7220","2240-7360","2260-5740","2380-5620","2400-5440","2400-5940","2460-6060","2480-5540","2500-5820","2620-5640","2800-4180","1200-5700","1780-6920","2100-6080","2160-6780" }, displayID = 26663 }; --Grocklar
	[32429] = { zoneID = 116, artID = { 121 }, x = 2820, y = 4540, overlay = { "2800-4560","3400-4920","3840-4920","3960-5060","4000-4840","2660-4420","3480-4820" }, displayID = 18083 }; --Seething Hate
	[32438] = { zoneID = 116, artID = { 121 }, x = 6200, y = 3680, overlay = { "6120-3520","6180-3660","6440-3580","6500-3000","6560-3360","6580-2840","6580-3680","6600-3940","6620-3560","6640-4140","6700-3800","6760-2800","6860-2680","6880-3080","7020-3340","7160-3500","7360-3760","7500-3820","7620-4160","6300-3680","6520-3120","6660-4260","6900-3280","6940-2880","7240-3660","7420-4300","7440-3580","7500-4160" }, displayID = 27970 }; --Syreian the Bonecarver
	[38453] = { zoneID = 116, artID = { 121 }, x = 3100, y = 5579, overlay = { "3100-5580","3280-5520" }, displayID = 31094 }; --Arcturis
	[32377] = { zoneID = 117, artID = { 122 }, x = 5020, y = 0480, overlay = { "5020-0480","5300-1200","6060-2000","6840-1640","6840-1760","7120-1380","4780-0580","5240-1080","6080-2200","6940-1420" }, displayID = 28051 }; --Perobas the Bloodthirster
	[32386] = { zoneID = 117, artID = { 122 }, x = 6860, y = 4840, overlay = { "6800-4480","6840-4680","6860-4840","6900-5880","6940-5720","6980-4940","7040-5100","7060-5680","7100-5560","7120-5320","7140-4400","7140-4520","7140-4760","7240-4940","7240-5100","7240-5280","7260-4420","7260-6140","7280-4060","7280-4600","7340-4740","7400-4500","7400-5240","7420-4640","7440-4860","7440-5400","7440-5520","7440-5660","7440-6040","7480-5100","7480-5880","7500-4140","7520-4980","7540-4480","7540-4720","7580-4280","7220-4280","7280-3920" }, displayID = 27063 }; --Vigdis the War Maiden
	[32398] = { zoneID = 117, artID = { 122 }, x = 2600, y = 6400, overlay = { "2600-6400","3080-7120","3120-5680","3200-7580","3320-8020","2560-6920","3160-7740","3260-7880" }, displayID = 27950 }; --King Ping
	[32487] = { zoneID = 118, artID = { 123 }, x = 4380, y = 5780, overlay = { "4380-5720","4420-5580","4440-5400","4440-5900","4480-5100","4480-6040","4540-4980","4540-6180","4560-6320","4640-6520","4660-4860","4740-4740","4820-4520","4880-4280","4960-4160","5100-3980","5140-4180","5260-4120","5280-3880","5400-3840","5400-4120","5520-4120","5720-4060","5820-4160","5940-4060","6040-4240","6080-4120","6180-4240","6340-4380","6400-4540","6500-4740","6520-4860","6520-5100","6600-5240","6640-5420","6700-5600","6740-5800","6740-5920","6800-6040","6800-6260","6820-6900","6840-6480","6880-6760","6920-6300","4360-6020","4600-5380","4720-6640","5000-4440","5720-3800","6080-4480","6640-5120" }, displayID = 27979 }; --Putridus the Ancient
	[32495] = { zoneID = 118, artID = { 123 }, x = 2840, y = 4580, overlay = { "2840-4580","3040-3840","3120-3980","3140-2820","3140-2960","3260-4040","3700-2440","5480-5220","5600-5320","5940-5860","5940-6220","2900-2920","2940-2740","3020-3220","3020-4420","3040-3440","3060-2660","3140-4300","3260-2960","3320-2840","3520-2720","3640-2560","5240-5200","5260-5440","5260-5560","5320-5300","5400-5120","5620-5480","5740-5720","5760-5460","5800-6260","5860-5660","5900-5500","5960-5980" }, displayID = 27983, event = 3 }; --Hildana Deathstealer
	[32501] = { zoneID = 118, artID = { 123 }, x = 3120, y = 6220, overlay = { "3120-6220","3120-6380","3120-6860","3140-6580","3160-6720","3200-6980","3340-7040","3440-6940","3520-7060","4640-8480","4720-8060","4740-7820","4740-8600","4780-8440","4800-8180","4840-8680","4860-7820","4860-8020","4900-8420","4960-8620","6700-3740","6740-3860","6780-3980","6800-4120","6960-4080","7080-3920","7080-4140","7120-3760","7200-3640","7200-3920","7280-3500","7380-3140","7400-3380","7100-3360" }, displayID = 27988 }; --High Thane Jorfus
	[32481] = { zoneID = 119, artID = { 124 }, x = 4040, y = 5959, overlay = { "4040-5960","4120-6840","4200-7380","4300-5240","4320-5080","4420-6940","4680-5500","5240-7240","5440-5180","5640-6520","5760-6540","4060-7400","4160-6660","4180-7020","4240-7560","4480-6820","5100-7240","5820-6420" }, displayID = 27975 }; --Aotona
	[32485] = { zoneID = 119, artID = { 124 }, x = 2600, y = 4800, overlay = { "2600-4800","2740-4840","3000-4400","3020-3940","3280-3320","3300-3460","3400-3240","3680-3000","3700-2820","4600-4140","4680-4280","4760-4180","4760-4420","4920-4420","5020-4200","5040-4380","5080-8180","5160-4260","5240-8400","5460-8360","5680-8040","5700-8160","5800-8260","6080-8360","6260-8280","6380-7900","6560-7880","2620-7340","2700-5140","2760-6820","2760-6940","2760-7280","2800-4480","2820-5860","2840-4600","2840-5080","2900-5360","2900-6440","2940-5180","2940-6800","2980-5060","3000-6300","3040-3800","3040-4900","3120-3680","3240-3580","3440-3120","3580-2800","4820-4580","4920-4300","5000-4580","5060-7920","5080-4820","5160-4580","5160-4920","5200-4760","5200-8520","5220-4120","5560-8260","5780-8380","5840-8140","5920-8320","6340-8380","6440-8080","6500-8300","6620-7760" }, displayID = 28052 }; --King Krush
	[32517] = { zoneID = 119, artID = { 124 }, x = 3596, y = 3058, overlay = { "2060-7000","2180-6880","3040-6680","3540-3020","5100-8160","5820-2200","6620-7900","7080-7120","2200-7080","3140-6580","3440-2900","3640-3180","5940-2260","7140-7260" }, displayID = 28010 }; --Loque'nahak <Mate of Har'koa>
	[32475] = { zoneID = {
		[120] = { x = 7160, y = 7500, artID = { 125 }, overlay = { "7160-7500" } };
		[121] = { x = 5259, y = 3200, artID = { 126 }, overlay = { "5200-3280","5320-3140","6040-3560","6120-3660","7080-2980","7140-2320","7140-2840","7180-2460","7400-6600","7520-6660","7700-4240","8140-3440","6160-3380","7240-2760","7340-6840","7640-4380","7660-6880" } };
	}, displayID = 27973 }; --Terror Spinner
	[32491] = { zoneID = {
		[120] = { x = 2800, y = 6540, artID = { 125 }, overlay = { "3300-6500","3000-6400","2700-6600","2700-6000","2600-5600","2700-5200","2900-4800","3100-4600","3500-4000","3700-3900","3900-4000","4000-4400","4000-4900","3800-5100","3700-5600","3600-6000","2800-4400","2800-4000","2700-3600","2800-3300","3500-3100","3300-3100","3100-3200","3600-2900","3800-2800","4100-2700","4400-2600","4500-2500","4800-2500","5000-2500","5100-2700","5300-3100","5000-3500","5100-3300","4500-3600","4700-3500","4400-3800","4400-4000","4500-4200","4700-4600","4900-4900","4900-5200","4700-5300","4400-5600","4100-6000","3900-6100","3600-6300","4200-5700","2700-4700","3800-6500","4000-6300","4200-6100","4400-6100","4700-6400","4700-6800","4600-7100","4400-7400","4300-7600","4300-7800","4100-8200","3700-8500","3300-8000","3500-7700","3700-7600","3700-7300","3700-6900","3700-6700","3800-8400","3400-8400","3300-8200","3500-8500","2700-6200","2700-6900","2500-7100","2500-7400","2600-7700","2800-7800","2900-7900","3100-7900","3500-6700","3500-6900","3600-7100","3500-7400","3400-4100","3300-4400","2800-4200","4600-4400","3700-5300","3600-5700","3000-6780","3940-8440","4120-6820" } };
		[550] = { x = 9060, y = 2960, artID = { 567 }, overlay = { "9060-2960" } };
	}, displayID = 26711 }; --Time-Lost Proto-Drake
	[32500] = { zoneID = 120, artID = { 125 }, x = 3780, y = 5840, overlay = { "3780-5840","4100-5140","4140-3900","4140-4040","6800-4740","3740-6040","3760-5700","4260-3820" }, displayID = 27986 }; --Dirkee
	[32630] = { zoneID = 120, artID = { 125 }, x = 2600, y = 7380, overlay = { "2600-7380","2640-4140","2700-7120","2720-4540","2740-5920","2740-6040","2780-7000","2840-6520","2880-8020","2900-6640","2980-6740","3080-6560","3120-6960","3200-6600","3400-6620","3540-3440","3540-6620","3620-6480","3660-6860","3660-6980","3680-7120","3680-7240","3680-7380","3680-8040","3700-7900","3720-6200","3720-7700","3800-6060","3840-3200","3860-8360","3980-5780","4020-4860","4040-6560","4080-5240","4080-5400","4080-8400","4100-7080","4220-5960","4360-5820","4420-3100","4580-6140","4800-4020","4820-6600","5000-6880","5080-7040","2620-4340","2640-5840","2720-5500","2720-6380","2740-6760","2780-3860","2780-6220","2840-5120","2980-3800","3160-6440","3320-3660","3340-3540","3380-6480","3560-7400","3580-7780","3640-7600","3820-7400","3840-7520","3900-5940","3920-7300","4020-2960","4040-6340","4080-5520","4120-3060","4280-3060","4560-8240","4620-3000","4640-3140","4660-6260","4740-6380","4780-3060","4840-6780","4900-2960","4900-7480","4920-3100","4920-4680","5180-3400","5200-3220" }, displayID = 28110 }; --Vyragosa
	[35189] = { zoneID = 120, artID = { 125 }, x = 2780, y = 5040, overlay = { "2780-5040","3020-6440","4620-6440","2780-4760","4620-6560","4800-6300" }, displayID = 29673 }; --Skoll
	[32447] = { zoneID = 121, artID = { 126 }, x = 2279, y = 8280, overlay = { "2280-8280","2840-8280","2900-7680","2900-8120","2920-7560","4040-5380","4040-5520","4040-5840","4040-5960","4040-6220","4040-6420","4240-7020","4360-7240","4500-5880","4560-6020","4620-7660","4700-7800","2120-8720","2420-8700","2440-8300","2560-8340","2640-8220","2860-7380","2880-7240","2940-7920","2960-8240","3960-6740","4000-5180","4040-5660","4040-6100","4180-5600","4320-5460","4440-7380","4460-6760","4520-7480","4600-6160","4600-6440","4600-6600","4740-6320","4800-7960","4900-8120","5060-8300" }, displayID = 26589 }; --Zul'drak Sentinel
	[32471] = { zoneID = 121, artID = { 126 }, x = 1440, y = 5620, overlay = { "1440-5620","1740-7020","1740-7140","2040-7880","2040-8020","2100-7160","2140-7020","2240-6180","2360-6200","2380-6080","2440-7660","2620-5560","2620-7160","2640-7040","2720-5440","1320-5620","1340-5480","2500-7540" }, displayID = 25926 }; --Griegen
	[33776] = { zoneID = 121, artID = { 126 }, x = 6100, y = 6340, overlay = { "6100-6340","6140-6160","6320-4280","6740-7760","6940-4840","7720-7000","6760-7920","7820-7120" }, displayID = 28871 }; --Gondria
	[32435] = { zoneID = 126, artID = { 131 }, x = 5120, y = 3140, overlay = { "5120-3140","5260-3180","5380-3340","5400-2880","5500-3380","5560-3080","5700-3080","5700-3700" }, displayID = 20763 }; --Vern
	[50053] = { zoneID = 198, artID = { 203,227 }, x = 5920, y = 3760, overlay = { "3440-2600","3640-2640","3960-2600","4140-3040","4260-3160","4420-3260","4560-3240","4680-3360","4860-3420","5040-3300","5140-3200","5200-3080","5300-3000","5420-2940","5540-2860","5620-3460","5660-3280","5700-3140","5720-2840","5740-3560","5760-2960","5860-3620","5920-3760" }, displayID = 36700 }; --Thartuk the Exile
	[50056] = { zoneID = 198, artID = { 203,227 }, x = 4060, y = 8140, overlay = { "3720-7240","3720-7440","3740-7560","3780-7820","3800-7700","3820-8300","3900-7880","3900-8200","4000-8380","4020-8020","4020-8140" }, displayID = 37307 }; --Garr
	[50057] = { zoneID = 198, artID = { 203,227 }, x = 6780, y = 5500, overlay = { "4500-6040","5600-5720","6580-5480","6780-5500","4980-5260" }, displayID = 36701 }; --Blazewing
	[50058] = { zoneID = 198, artID = { 203,227 }, x = 5680, y = 7540, overlay = { "5220-8320","5380-8200","5420-8000","5560-7620","5680-7540","5280-7320" }, displayID = 37282 }; --Terrorpene
	[54318] = { zoneID = 198, artID = { 203,227 }, x = 2740, y = 5100, overlay = { "2740-5120","2880-5220","3000-5140","3240-5140","3320-5260","3440-5320","3500-5460","3600-5380","3800-5420","3920-5480","4040-5340" }, displayID = 38748 }; --Ankha
	[54319] = { zoneID = 198, artID = { 203,227 }, x = 2740, y = 5140, overlay = { "2740-5140","2900-5240","3000-5160","3120-5120","3240-5140","3340-5260","3460-5300","3520-5460","3640-5420","3780-5420","3880-5500","3960-5380","4080-5400" }, displayID = 38749 }; --Magria
	[54320] = { zoneID = 198, artID = { 203,227 }, x = 2800, y = 6220, overlay = { "2580-6120","2600-6520","2620-6280","2640-6000","2720-6420","2760-6020","2780-6260" }, displayID = 38634 }; --Ban'thalos
	[3253] = { zoneID = 199, artID = { 204 }, x = 4129, y = 6707, overlay = { "4120-6700" }, displayID = 37581 }; --Silithid Harvester
	[5829] = { zoneID = 199, artID = { 204 }, x = 4540, y = 4340, overlay = { "4540-4340" }, displayID = 34324 }; --Snort the Heckler
	[5832] = { zoneID = 199, artID = { 204 }, x = 4440, y = 7740, overlay = { "4440-7740","4440-8000","4620-7900","4820-7440","4980-7920","4980-8060" }, displayID = 37778 }; --Thunderstomp
	[5834] = { zoneID = 199, artID = { 204 }, x = 4497, y = 5627, overlay = { "4220-5340","4240-5480","4300-5620","4360-5740","4380-5480","4420-5900","4460-5620","4600-5740","4620-5520" }, displayID = 2702 }; --Azzere the Skyblade
	[5847] = { zoneID = 199, artID = { 204 }, x = 4713, y = 8855, overlay = { "4700-8860" }, friendly = { "A" }, displayID = 4595 }; --Heggin Stonewhisker <Bael'dun Chief Engineer>
	[5848] = { zoneID = 199, artID = { 204 }, x = 4743, y = 8594, overlay = { "4740-8580" }, friendly = { "A" }, displayID = 4597 }; --Malgin Barleybrew <Bael'dun Morale Officer>
	[5849] = { zoneID = 199, artID = { 204 }, x = 4790, y = 8832, overlay = { "4780-8820" }, friendly = { "A" }, displayID = 4596 }; --Digger Flameforge <Excavation Specialist>
	[5851] = { zoneID = 199, artID = { 204 }, x = 4960, y = 8940, overlay = { "4960-8940" }, friendly = { "A" }, displayID = 4598 }; --Captain Gerogg Hammertoe <Bael'dun Captain of the Guard>
	[5859] = { zoneID = 199, artID = { 204 }, x = 4040, y = 8300, overlay = { "4040-8300","4180-8440","4320-8440" }, displayID = 6114 }; --Hagg Taurenbane <Razormane Champion>
	[5863] = { zoneID = 199, artID = { 204 }, x = 4424, y = 4207, overlay = { "4200-4260","4420-4200","4200-3780" }, displayID = 6100 }; --Geopriest Gukk'rok
	[5864] = { zoneID = 199, artID = { 204 }, x = 3859, y = 3340, overlay = { "3860-3340" }, displayID = 6114 }; --Swinegart Spearhide
	[49913] = { zoneID = 201, artID = { 206 }, x = 6160, y = 7540, overlay = { "5620-7780","5720-8020","5940-7520","6000-7680","6020-7040","6040-6920","6100-7500" }, displayID = 36660 }; --Lady La-La <Siren of the Deeps>
	[51071] = { zoneID = {
		[203] = { x = 6840, y = 7380, artID = { 208 }, overlay = { "6840-7380" } };
		[205] = { x = 5520, y = 7380, artID = { 210 }, overlay = { "5520-7320" } };
	}, friendly = { "A" }, displayID = 4693 }; --Captain Florence
	[51079] = { zoneID = 203, artID = { 208 }, x = 6680, y = 6960, overlay = { "6680-6940" }, friendly = { "H" }, displayID = 30103, event = 6 }; --Captain Foulwind
	[50005] = { zoneID = {
		[204] = { x = 4220, y = 7600, artID = { 209 }, overlay = { "3940-7160","4040-7380","4100-7660","4180-7340","4220-7600" } };
		[205] = { x = 6700, y = 4320, artID = { 210 }, overlay = { "3780-6680","3940-6880","3980-6640","4440-4940","4620-4860","5640-8200","5720-8080","5740-8360","5820-8160","6580-4320","6700-4320","3800-6820","4480-5080","4660-5000","6500-4200" } };
	}, displayID = 37308 }; --Poseidus
	[50009] = { zoneID = 204, artID = { 209 }, x = 7740, y = 2680, overlay = { "6300-3060","6340-2500","6340-3200","6420-2320","6580-2040","6700-1900","6820-3960","6840-1820","6980-1740","6980-4020","7180-1840","7320-2000","7480-2040","7560-3660","7700-2540","7720-2900","7720-3180","7740-2680","6280-2800","7100-4000","7220-3940","7340-3880","7460-3780","7640-3460","6420-3540","6460-2180","6520-3740","7560-2160","7660-2360" }, displayID = 37338 }; --Mobus <The Crushing Tide>
	[50050] = { zoneID = 204, artID = { 209 }, x = 5100, y = 3220, overlay = { "4180-3240","4620-2940","4800-2740","4800-3460","5100-3220" }, displayID = 37335 }; --Shok'sharak
	[50051] = { zoneID = 204, artID = { 209 }, x = 3140, y = 8060, overlay = { "1280-8260","1500-7740","1500-8740","1900-7740","2000-5800","2040-6840","2200-6500","2420-7180","2440-8040","2600-8140","2820-8220","3120-7800","3140-8060" }, displayID = 37396 }; --Ghostcrawler
	[50052] = { zoneID = 205, artID = { 210 }, x = 5760, y = 6980, overlay = { "5640-7000","5720-6900" }, displayID = 36699 }; --Burgy Blackheart <Dreaded Captain of Diane's Fancy>
	[49822] = { zoneID = 207, artID = { 212 }, x = 6120, y = 2260, overlay = { "6120-2240" }, displayID = 36636 }; --Jadefang
	[50059] = { zoneID = 207, artID = { 212 }, x = 4580, y = 8419, overlay = { "3240-7680","3720-7980","3720-8160","3860-8320","4280-8760","4540-8400" }, displayID = 37364 }; --Golgarok <The Crimson Shatterer>
	[50060] = { zoneID = 207, artID = { 212 }, x = 5520, y = 2440, overlay = { "5420-2540","5520-2440" }, displayID = 36703 }; --Terborus
	[50061] = { zoneID = 207, artID = { 212 }, x = 5859, y = 5120, overlay = { "4040-5280","4060-5580","4080-4740","4080-5700","4100-4580","4200-4360","4200-6000","4280-4180","4300-6140","4360-4060","4420-6240","4440-6360","4540-3900","4620-6440","4640-3800","4740-6500","4960-3800","5040-6540","5260-6460","5300-3880","5440-4000","5540-6180","5580-4320","5620-6040","5720-5840","5740-4420","5760-5640","5820-5100" }, displayID = 32229 }; --Xariona
	[50062] = { zoneID = 207, artID = { 212 }, x = 5505, y = 5411, overlay = { "5505-5411","5372-3971","4912-5560","4300-5079","5050-6350","4200-4360","3120-4260","3500-4200","3940-4880","4140-8240","4260-4680","4280-5840","4320-4840","4340-6040","4640-4480","4700-5740","4740-5900","5160-4280","6040-2620","6160-2700","6480-1920","6600-6440" }, displayID = 37149 }; --Aeonaxx <Mate of Aeosera>
	[14490] = { zoneID = 210, artID = { 215 }, x = 4120, y = 7180, overlay = { "4120-7180" }, displayID = 14528 }; --Rippa
	[14491] = { zoneID = 210, artID = { 215 }, x = 4800, y = 5800, overlay = { "4800-5800","4940-5660","5060-5560","5100-5440","5220-5320","5360-5320","5440-5220","5540-5120","5620-5020","5620-5280","5720-4920","5800-4780" }, displayID = 3188 }; --Kurmokk
	[14492] = { zoneID = 210, artID = { 215 }, x = 5300, y = 2760, overlay = { "5300-2760" }, displayID = 7232 }; --Verifonix <The Surveyor>
	[1552] = { zoneID = 210, artID = { 215 }, x = 6780, y = 2520, overlay = { "6780-2520" }, displayID = 45945 }; --Scale Belly
	[2541] = { zoneID = 210, artID = { 215 }, x = 4320, y = 4960, overlay = { "4320-4960" }, displayID = 21160 }; --Lord Sakrasis
	[10080] = { zoneID = 219, artID = { 230 }, x = 5200, y = 4100, displayID = 9291 }; --Sandarr Dunereaver
	[10081] = { zoneID = 219, artID = { 230 }, x = 3620, y = 1780, overlay = { "3620-1780" }, displayID = 9292 }; --Dustwraith
	[10082] = { zoneID = 219, artID = { 230 }, x = 5300, y = 4000, displayID = 9293 }; --Zerillis
	[6228] = { zoneID = 229, artID = { 240 }, x = 2800, y = 5200, displayID = 6669 }; --Dark Iron Ambassador
	[11467] = { zoneID = 237, artID = { 248 }, x = 3200, y = 2800, displayID = 11250 }; --Tsu'zee
	[14506] = { zoneID = 238, artID = { 249 }, x = 3800, y = 5900, displayID = 14556 }; --Lord Hel'nurath
	[50085] = { zoneID = 241, artID = { 338,252 }, x = 5800, y = 3380, overlay = { "5780-3340" }, displayID = 36711 }; --Overlord Sunderfury
	[50086] = { zoneID = 241, artID = { 338,252 }, x = 5100, y = 8240, overlay = { "5080-8260" }, displayID = 36714 }; --Tarvus the Vile
	[50089] = { zoneID = 241, artID = { 338,252 }, x = 5980, y = 0680, overlay = { "5020-0880","5080-0740","5200-0720","5220-1060","5240-0920","5320-0800","5320-1200","5360-1080","5500-1180","5620-1260","5640-0820","5660-1100","5700-0700","5800-0960","5880-0620","4960-0740","6000-0640" }, displayID = 24301 }; --Julak-Doom <The Eye of Zor>
	[50138] = { zoneID = 241, artID = { 338,252 }, x = 6559, y = 6060, overlay = { "4920-7420","4980-7540","5380-5320","5420-7620","5460-7500","5820-6360","5920-4340","6540-6020" }, displayID = 36726 }; --Karoma <The Wolf Spirit>
	[50159] = { zoneID = 241, artID = { 338,252 }, x = 6880, y = 2580, overlay = { "3820-5300","4260-3860","4520-3120","4580-2940","6880-2580","6880-2769","4860-2350" }, displayID = 37352 }; --Sambas
	[8923] = { zoneID = 243, artID = { 254 }, x = 5000, y = 3700, overlay = { "5000-3700" }, displayID = 8270 }; --Panzor the Invincible
	[50063] = { zoneID = 249, artID = { 260,289 }, x = 3800, y = 6060, overlay = { "3800-6020" }, displayID = 34573 }; --Akma'hat <Dirge of the Eternal Sands>
	[50064] = { zoneID = 249, artID = { 260,289 }, x = 7080, y = 7420, overlay = { "5800-8240","5820-6120","6640-6800","7080-7420" }, displayID = 36707 }; --Cyrus the Black
	[50065] = { zoneID = 249, artID = { 260,289 }, x = 4440, y = 4200, overlay = { "4440-4200","4480-4360" }, displayID = 37353 }; --Armagedillo
	[50154] = { zoneID = 249, artID = { 260,289 }, x = 5380, y = 1939, overlay = { "4440-1040","4440-2180","4700-1740","4760-1860","5000-2380","5020-1960","5040-2100","5340-1860" }, displayID = 36728 }; --Madexx
	[51401] = { zoneID = 249, artID = { 260,289 }, x = 5320, y = 1980, overlay = { "4420-1080","4460-2140","4740-1900","5020-2380","5040-2020","5320-1980" }, displayID = 37360 }; --Madexx
	[51402] = { zoneID = 249, artID = { 260,289 }, x = 5320, y = 1939, overlay = { "4440-1040","4440-2200","5080-2020","5320-1940" }, displayID = 37362 }; --Madexx
	[51403] = { zoneID = 249, artID = { 260,289 }, x = 5340, y = 1900, overlay = { "4780-1820","5020-2380","5100-2040","5340-1900","5380-2020" }, displayID = 37359 }; --Madexx
	[51404] = { zoneID = 249, artID = { 260,289 }, x = 5320, y = 1980, overlay = { "4440-1020","4440-2180","4740-1840","5000-2060","5000-2400","5100-1960","5320-1980","5380-1860" }, displayID = 37361 }; --Madexx
	[10509] = { zoneID = 250, artID = { 261 }, displayID = 9686 }; --Jed Runewatcher <Blackhand Legion>
	[10263] = { zoneID = 251, artID = { 262 }, x = 6600, y = 4100, displayID = 5047 }; --Burning Felguard
	[10376] = { zoneID = 251, artID = { 262 }, x = 5700, y = 7800, overlay = { "5700-7800" }, displayID = 9755 }; --Crystal Fang
	[9596] = { zoneID = 251, artID = { 262 }, x = 4790, y = 6420, overlay = { "4790-6420" }, displayID = 9668 }; --Bannok Grimaxe <Firebrand Legion Champion>
	[9217] = { zoneID = 252, artID = { 263 }, x = 4100, y = 5800, overlay = { "4100-5800" }, displayID = 11578 }; --Spirestone Lord Magus
	[9218] = { zoneID = 252, artID = { 263 }, x = 3500, y = 5600, overlay = { "3500-5600" }, displayID = 11576 }; --Spirestone Battle Lord
	[9219] = { zoneID = 252, artID = { 263 }, x = 5120, y = 5670, displayID = 11574 }; --Spirestone Butcher
	[9718] = { zoneID = 255, artID = { 266 }, x = 3500, y = 7400, displayID = 11809 }; --Ghok Bashguud <Bloodaxe Champion>
	[56080] = { zoneID = 274, artID = { 285 }, x = 6120, y = 4110, friendly = { "A","H" }, displayID = 39299 }; --Little Samras
	[56081] = { zoneID = 274, artID = { 285 }, x = 4800, y = 6430, friendly = { "A","H" }, displayID = 5027 }; --Optimistic Benj
	[5912] = { zoneID = 279, artID = { 290 }, x = 7200, y = 6600, overlay = { "7200-6600" }, displayID = 1267 }; --Deviate Faerie Dragon
	[12237] = { zoneID = 280, artID = { 291 }, x = 2500, y = 7900, displayID = 9014 }; --Meshlok the Harvester
	[4425] = { zoneID = 301, artID = { 313 }, displayID = 4735 }; --Blind Hunter
	[4842] = { zoneID = 301, artID = { 313 }, displayID = 6102 }; --Earthcaller Halmgar
	[6488] = { zoneID = 302, artID = { 314 }, x = 2801, y = 5633, overlay = { "2801-5633" }, displayID = 5230 }; --Fallen Champion
	[6489] = { zoneID = 302, artID = { 314 }, x = 4254, y = 6915, overlay = { "4254-6915" }, displayID = 5231 }; --Ironspine
	[6490] = { zoneID = 302, artID = { 314 }, x = 2577, y = 6957, overlay = { "2577-6957" }, displayID = 5534 }; --Azshir the Sleepless
	[3872] = { zoneID = 316, artID = { 328 }, x = 6800, y = 6000, displayID = 37296 }; --Deathsworn Captain
	[10393] = { zoneID = 317, artID = { 329 }, x = 5600, y = 6600, overlay = { "5600-6600" }, displayID = 2606 }; --Skul
	[10558] = { zoneID = {
		[317] = { x = 8300, y = 2300, artID = { 329 }, overlay = { "8300-2300" } };
		[318] = { x = 6050, y = 3130, artID = { 330 }, overlay = { "6050-3130" } };
	}, displayID = 10482 }; --Hearthsinger Forresten
	[10809] = { zoneID = 318, artID = { 330 }, x = 6700, y = 3000, displayID = 7856 }; --Stonespine
	[50815] = { zoneID = 338, artID = { 350 }, x = 3740, y = 3559, overlay = { "3300-5220","3680-3480" }, displayID = 19607 }; --Skarr
	[50959] = { zoneID = 338, artID = { 350 }, x = 3760, y = 3540, overlay = { "3300-5220","3680-3480" }, displayID = 38825 }; --Karkin
	[54321] = { zoneID = 338, artID = { 350 }, x = 6060, y = 5959, overlay = { "6020-5860","6040-6020" }, displayID = 38780 }; --Solix
	[54322] = { zoneID = 338, artID = { 350 }, x = 7320, y = 5940, overlay = { "6800-7140","6940-6980","7300-5800","7320-5940" }, displayID = 38424 }; --Deth'tilac <The Smouldering Darkness>
	[54323] = { zoneID = 338, artID = { 350 }, x = 3160, y = 5680, overlay = { "2660-6640","2700-6200","2900-7300","2980-5520","3020-5800","3040-5680","3160-5680" }, displayID = 38453 }; --Kirix
	[54324] = { zoneID = 338, artID = { 350 }, x = 2000, y = 5080, overlay = { "1860-5260","1940-4740","1940-4880","2000-5080" }, displayID = 38779 }; --Skitterflame
	[54338] = { zoneID = 338, artID = { 350 }, x = 5660, y = 4140, overlay = { "5260-4120","5380-3960","5460-4180","5480-3840","5660-4140" }, displayID = 38426 }; --Anthriss
	[16179] = { zoneID = 351, artID = { 363 }, x = 5959, y = 2870, overlay = { "5960-2870" }, displayID = 15938 }; --Hyakiss the Lurker
	[16180] = { zoneID = 351, artID = { 363 }, x = 5959, y = 2870, overlay = { "5960-2870" }, displayID = 16053 }; --Shadikith the Glider
	[16181] = { zoneID = 351, artID = { 363 }, x = 5959, y = 2870, overlay = { "5960-2870" }, displayID = 16054 }; --Rokad the Ravager
	[50338] = { zoneID = 371, artID = { 383 }, x = 4400, y = 7580, overlay = { "4340-7640","4360-7220","4400-7400" }, displayID = 44274 }; --Kor'nas Nightsavage
	[50350] = { zoneID = 371, artID = { 383 }, x = 4221, y = 1741, overlay = { "4080-1520","4220-1720","4240-1600","4640-1680","4800-1840","4820-2040" }, displayID = 44346 }; --Morgrinn Crackfang
	[50363] = { zoneID = 371, artID = { 383 }, x = 3951, y = 6260, overlay = { "3940-6240" }, displayID = 44394 }; --Krax'ik
	[50750] = { zoneID = 371, artID = { 383 }, x = 3355, y = 5078, overlay = { "3340-5080" }, displayID = 44203 }; --Aethis
	[50782] = { zoneID = 371, artID = { 383 }, x = 6445, y = 7410, overlay = { "6440-7400" }, displayID = 44255 }; --Sarnak
	[50808] = { zoneID = 371, artID = { 383 }, x = 5737, y = 7169, overlay = { "5720-7160" }, displayID = 44362 }; --Urobi the Walker
	[50823] = { zoneID = 371, artID = { 383 }, x = 4254, y = 3885, overlay = { "4240-3880" }, displayID = 44236 }; --Mister Ferocious
	[51078] = { zoneID = 371, artID = { 383 }, x = 5376, y = 4557, overlay = { "5200-4440","5340-4940","5360-4540","5420-4240","5640-4800" }, displayID = 43977 }; --Ferdinand
	[69768] = { zoneID = {
		[371] = { x = 5420, y = 2760, artID = { 383 }, overlay = { "4320-1720","4440-1760","4680-1880","4740-2100","4880-2140","4940-2020","5080-3680","5100-2000","5260-1940","5260-2180","5260-2340","5260-3260","5300-3460","5320-3060","5340-2940","5420-2760" } };
		[379] = { x = 6475, y = 6414, artID = { 391 }, overlay = { "6460-6400","6620-6500","6720-8180","6740-7960","6800-6440","6960-6560","6960-7680","7060-7540","7080-6600","7120-7420","7160-7240","7240-6640","7240-7140","7320-6900","7420-6720" } };
		[388] = { x = 4940, y = 7300, artID = { 400 }, overlay = { "3680-8520","3740-8660","3760-8420","3860-8740","3880-8260","3940-8140","3960-8820","4040-7740","4080-8980","4200-9020","4360-9080","4420-7480","4560-7520","4620-8980","4680-7480","4840-7420","4840-8600","4880-8460","4940-7300","4460-8920" } };
		[418] = { x = 5780, y = 2920, artID = { 499 }, overlay = { "3620-6020","3720-6240","3840-6560","3920-6360","5780-2920" } };
		[422] = { x = 5760, y = 6600, artID = { 434 }, overlay = { "3740-4840","3900-4640","3940-4940","4120-5020","4300-5160","4540-5600","4600-5840","4640-5960","4700-6080","4840-6100","4900-6260","4960-6380","5340-6660","5600-6660","5760-6600" } };
	}, displayID = 47673, event = 5 }; --Zandalari Warscout
	[69769] = { zoneID = {
		[371] = { x = 5259, y = 1900, artID = { 383 }, overlay = { "5240-1880" } };
		[379] = { x = 7500, y = 6760, artID = { 391 }, overlay = { "7500-6740" } };
		[388] = { x = 3660, y = 8560, artID = { 400 }, overlay = { "3640-8540" } };
		[418] = { x = 3980, y = 6559, artID = { 499 }, overlay = { "3860-6720","3980-6540" } };
		[422] = { x = 4759, y = 6160, artID = { 434 }, overlay = { "4720-6100" } };
	}, displayID = 47681, event = 5 }; --Zandalari Warbringer
	[69841] = { zoneID = {
		[371] = { x = 5259, y = 1900, artID = { 383 }, overlay = { "5240-1880" } };
		[379] = { x = 7500, y = 6760, artID = { 391 }, overlay = { "7500-6740" } };
		[388] = { x = 3660, y = 8560, artID = { 400 }, overlay = { "3640-8540" } };
		[422] = { x = 4740, y = 6160, artID = { 434 }, overlay = { "4720-6140" } };
	}, displayID = 47681, event = 5 }; --Zandalari Warbringer
	[69842] = { zoneID = {
		[371] = { x = 5259, y = 1900, artID = { 383 }, overlay = { "5240-1880" } };
		[379] = { x = 7500, y = 6760, artID = { 391 }, overlay = { "7500-6740" } };
		[388] = { x = 3660, y = 8560, artID = { 400 }, overlay = { "3640-8540" } };
		[422] = { x = 4759, y = 6160, artID = { 434 }, overlay = { "4720-6140" } };
	}, displayID = 47681, event = 5 }; --Zandalari Warbringer
	[70323] = { zoneID = {
		[371] = { x = 5660, y = 2180, artID = { 383 }, overlay = { "5080-2080","5580-2140" } };
		[376] = { x = 3720, y = 7060, artID = { 388 }, overlay = { "3720-7060" } };
		[379] = { x = 7340, y = 8640, artID = { 391 }, overlay = { "3300-4440","7280-8520","7320-8660","3420-4420" } };
		[388] = { x = 3559, y = 5300, artID = { 400 }, overlay = { "3520-5120","3540-5300","3500-5440" } };
		[418] = { x = 3460, y = 3420, artID = { 499 }, overlay = { "3240-3420","3320-3320","3460-3420" } };
		[422] = { x = 2640, y = 1600, artID = { 434 }, overlay = { "2640-1600" } };
		[554] = { x = 4759, y = 5480, artID = { 571 }, overlay = { "4740-5500" } };
	}, displayID = 48006, event = 2 }; --Krakkanon
	[50339] = { zoneID = 376, artID = { 388 }, x = 3694, y = 2574, overlay = { "3680-2540" }, displayID = 44282 }; --Sulik'shor
	[50351] = { zoneID = 376, artID = { 388 }, x = 1860, y = 7770, overlay = { "1840-7740" }, displayID = 44347 }; --Jonn-Dar
	[50364] = { zoneID = 376, artID = { 388 }, x = 1059, y = 4745, overlay = { "0820-5940","0840-5620","0840-5760","0860-6080","0880-5080","0920-4740","0920-5400","0940-4560","0940-4880","0960-5740","0980-5240","0980-5620","1040-4740","1100-5660","1120-5500","1120-5860","1140-4880","1180-5220","1200-5080","1280-4980" }, displayID = 44395 }; --Nal'lak the Ripper
	[50766] = { zoneID = 376, artID = { 388 }, x = 5444, y = 3633, overlay = { "5220-2860","5400-3140","5420-3260","5440-3640","5740-3340","5800-3820","5920-3720","5960-3840" }, displayID = 44222 }; --Sele'na
	[50783] = { zoneID = 376, artID = { 388 }, x = 6776, y = 5875, overlay = { "6740-5940","6820-5820","6900-5280","6900-5620","6940-5440","7020-5320","7100-5220","7260-5240","7380-5240","7400-5080","7420-4940","7500-4820","7520-4700" }, displayID = 44267 }; --Salyin Warscout
	[50811] = { zoneID = 376, artID = { 388 }, x = 8839, y = 1785, overlay = { "8840-1800" }, displayID = 44370 }; --Nasra Spothide
	[50828] = { zoneID = 376, artID = { 388 }, x = 1395, y = 3847, overlay = { "1380-3860","1540-3240","1560-3100","1640-3520","1640-4080","1900-3540" }, displayID = 44242 }; --Bonobos <The Bananamancer>
	[51059] = { zoneID = 376, artID = { 388 }, x = 3455, y = 5922, overlay = { "3280-6240","3440-5940","3760-6040","3940-5740" }, displayID = 44161 }; --Blackhoof
	[62346] = { zoneID = 376, artID = { 388 }, x = 7094, y = 6233, overlay = { "7160-6440","7094-6233" }, displayID = 42439, questReset = true, questID = { 32098 } }; --null
	[50332] = { zoneID = 379, artID = { 391 }, x = 5076, y = 8059, overlay = { "4740-8140","4860-8000","5000-8060","5120-7940","5140-8060" }, displayID = 44163 }; --Korda Torros
	[50341] = { zoneID = 379, artID = { 391 }, x = 5548, y = 4392, overlay = { "5540-4340" }, displayID = 44283 }; --Borginn Darkfist
	[50354] = { zoneID = 379, artID = { 391 }, x = 5935, y = 7375, overlay = { "5700-7600","5920-7380" }, displayID = 44349 }; --Havak
	[50733] = { zoneID = 379, artID = { 391 }, x = 3660, y = 7960, overlay = { "3640-7960" }, displayID = 44397 }; --Ski'thik
	[50769] = { zoneID = 379, artID = { 391 }, x = 7437, y = 7929, overlay = { "7320-7640","7440-7920" }, displayID = 44226 }; --Zai the Outcast
	[50789] = { zoneID = 379, artID = { 391 }, x = 6389, y = 1373, overlay = { "6380-1380" }, displayID = 44269 }; --Nessos the Oracle
	[50817] = { zoneID = 379, artID = { 391 }, x = 4080, y = 4240, overlay = { "4060-4280" }, displayID = 44372 }; --Ahone the Wanderer
	[50831] = { zoneID = 379, artID = { 391 }, x = 4720, y = 6300, overlay = { "4480-6360","4480-6520","4620-6180","4720-6300" }, displayID = 44246 }; --Scritch
	[60491] = { zoneID = 379, artID = { 391 }, x = 5380, y = 6460, overlay = { "5380-6460","5000-6900","5120-8760","7080-6380","6780-7800" }, displayID = 41448, questReset = true, questID = { 32099 } }; --Sha of Anger
	[50333] = { zoneID = 388, artID = { 400 }, x = 6646, y = 5167, overlay = { "6420-4980","6540-5060","6640-4480","6640-5220","6680-5100","6720-4700","6740-4560","6760-5000" }, displayID = 44164 }; --Lon the Bull
	[50344] = { zoneID = 388, artID = { 400 }, x = 5389, y = 6349, overlay = { "5380-6360" }, displayID = 44284 }; --Norlaxx
	[50355] = { zoneID = 388, artID = { 400 }, x = 6300, y = 3559, overlay = { "6280-3540" }, displayID = 44350 }; --Kah'tir
	[50734] = { zoneID = 388, artID = { 400 }, x = 4786, y = 8854, overlay = { "4180-7860","4620-7460","4780-8420","4780-8840" }, displayID = 44398 }; --Lith'ik the Stalker
	[50772] = { zoneID = 388, artID = { 400 }, x = 6536, y = 8746, overlay = { "6540-8740","6780-8740","6880-8900" }, displayID = 44228 }; --Eshelon
	[50791] = { zoneID = 388, artID = { 400 }, x = 5920, y = 8560, overlay = { "5920-8540" }, displayID = 44270 }; --Siltriss the Sharpener
	[50820] = { zoneID = 388, artID = { 400 }, x = 3200, y = 6180, overlay = { "3200-6180" }, displayID = 44373 }; --Yul Wildpaw
	[50832] = { zoneID = 388, artID = { 400 }, x = 6761, y = 7460, overlay = { "6760-7440" }, displayID = 44249 }; --The Yowler
	[50336] = { zoneID = 390, artID = { 1972,402 }, x = 8808, y = 4433, overlay = { "8780-4440" }, displayID = 44159 }; --Yorik Sharpeye
	[50349] = { zoneID = 390, artID = { 1972,402 }, x = 1523, y = 3521, overlay = { "1500-3520" }, displayID = 44286 }; --Kang the Soul Thief
	[50359] = { zoneID = 390, artID = { 1972,402 }, x = 3957, y = 2514, overlay = { "3940-2520" }, displayID = 44352 }; --Urgolax
	[50749] = { zoneID = 390, artID = { 1972,402 }, x = 1384, y = 5864, overlay = { "1400-5820" }, displayID = 44400 }; --Kal'tik the Blight
	[50780] = { zoneID = 390, artID = { 1972,402 }, x = 6210, y = 5520, overlay = { "6210-5520" }, displayID = 44230 }; --Sahn Tidehunter
	[50806] = { zoneID = 390, artID = { 1972,402 }, x = 3519, y = 6050, overlay = { "3500-6160","3540-6020","3640-5940","3660-5820","3760-5580","3760-5720","3860-5500","3920-5360","4140-5300","4260-5380","4380-5100" }, displayID = 44272 }; --Moldo One-Eye
	[50822] = { zoneID = 390, artID = { 1972,402 }, x = 4283, y = 6924, overlay = { "4240-6900" }, displayID = 44375 }; --Ai-Ran the Shifting Cloud
	[50840] = { zoneID = 390, artID = { 1972,402 }, x = 3100, y = 9160, overlay = { "3040-9140" }, displayID = 44251 }; --Major Nanners
	[58474] = { zoneID = 390, artID = { 1972,402 }, x = 2700, y = 1460, overlay = { "2700-1460" }, displayID = 43640, event = 4 }; --Bloodtip <Ashweb Matriarch>
	[58768] = { zoneID = 390, artID = { 1972,402 }, x = 4644, y = 5934, overlay = { "4620-5900" }, displayID = 44455, event = 4 }; --Cracklefang
	[58769] = { zoneID = 390, artID = { 1972,402 }, x = 3737, y = 5090, overlay = { "3480-5080","3720-5120" }, displayID = 42333, event = 4 }; --Vicejaw
	[58771] = { zoneID = 390, artID = { 1972,402 }, x = 6650, y = 3931, overlay = { "6640-3920" }, displayID = 40357, event = 4 }; --Quid <Spirit of the Misty Falls>
	[58778] = { zoneID = 390, artID = { 1972,402 }, x = 3500, y = 8959, overlay = { "3500-8940" }, displayID = 42736, event = 4 }; --Aetha <Spirit of the Golden Winds>
	[58817] = { zoneID = 390, artID = { 1972,402 }, x = 4743, y = 6566, overlay = { "4740-6620" }, displayID = 40299, event = 4 }; --Spirit of Lao-Fe <The Slavebinder>
	[58949] = { zoneID = 390, artID = { 1972,402 }, x = 1699, y = 4858, overlay = { "1680-4820" }, displayID = 45743, event = 4 }; --Bai-Jin the Butcher <Shao-Tien Imperion>
	[62880] = { zoneID = 390, artID = { 1972,402 }, x = 2685, y = 1311, overlay = { "2700-1340" }, displayID = 45741, event = 4 }; --Gochao the Ironfist <Shao-Tien Imperion>
	[63101] = { zoneID = 390, artID = { 1972,402 }, x = 2896, y = 5707, overlay = { "2640-5120","2660-5260","2740-5380","2800-5520","2840-5660","2940-5760","3060-5820","3080-5980" }, displayID = 45786, event = 4 }; --General Temuja <The Soul-Slaver>
	[63240] = { zoneID = 390, artID = { 1972,402 }, x = 3058, y = 7837, overlay = { "3040-7800" }, displayID = 45785, event = 4 }; --Shadowmaster Sydow <The Soul-Gatherer>
	[63510] = { zoneID = {
		[395] = { x = 7747, y = 7282, artID = { 403 }, overlay = { "5820-6400","6300-6640","6620-6800","6640-7300","6700-7140","6720-6580","6740-6820","6800-7240","6840-7020","6860-6880","6880-6380","6900-6600","6900-7160","6980-6760","6980-7500","7000-6880","7000-7040","7040-6640","7080-6500","7100-7260","7120-6120","7120-7080","7140-7380","7160-5940","7180-6640","7180-6760","7200-6460","7220-7640","7240-7240","7240-7480","7260-6320","7260-7100","7280-6880","7300-5780","7300-6000","7320-6760","7380-6420","7380-6580","7420-7000","7420-7260","7420-7600","7440-5400","7440-6780","7440-7140","7440-7420","7440-7740","7540-7580","7560-7180","7560-7460","7580-4540","7580-6560","7600-6820","7600-7040","7620-7780","7660-7280","7660-7620","7680-7480","7700-7980","7740-6780","7740-7140","7760-7740","7780-7360","7820-8020","7860-7600","7880-7040","7900-7280","7940-6840","7960-7440","8020-7220","8040-7060","8060-6940" } };
		[390] = { x = 2442, y = 2332, artID = { 1972,402 }, overlay = { "2442-2332" } };
	}, displayID = 43097 }; --Wulon <The Granite Sentinel>
	[63691] = { zoneID = 390, artID = { 1972,402 }, x = 2680, y = 1580, overlay = { "2680-1580" }, displayID = 45739, event = 4 }; --Huo-Shuang <Shao-Tien Imperion>
	[63695] = { zoneID = 390, artID = { 1972,402 }, x = 2869, y = 4337, overlay = { "2840-4320" }, displayID = 45745, event = 4 }; --Baolai the Immolator <Shao-Tien Imperion>
	[63977] = { zoneID = 390, artID = { 1972,402 }, x = 0792, y = 3384, overlay = { "0800-3340" }, displayID = 43377, event = 4 }; --Vyraxxis <Krik'thik Swarm-Lord>
	[63978] = { zoneID = 390, artID = { 1972,402 }, x = 0603, y = 5854, overlay = { "0620-5780" }, displayID = 43409, event = 4 }; --Kri'chon <The Corpse-Reaver>
	[62881] = { zoneID = 395, artID = { 403 }, x = 5480, y = 5840, overlay = { "5280-6080","5340-5940","5480-5840" }, displayID = 45744, event = 4 }; --Gaohun the Soul-Severer <Shao-Tien Imperion>
	[50331] = { zoneID = 418, artID = { 430,499 }, x = 3940, y = 2880, overlay = { "3940-2880","4040-2440" }, displayID = 44162 }; --Go-Kan
	[50340] = { zoneID = 418, artID = { 430,499 }, x = 5571, y = 3517, overlay = { "5340-3860","5400-3220","5620-2800","5620-3520","5620-3820","5860-3120","5860-3440" }, displayID = 44281 }; --Gaarn the Toxic
	[50352] = { zoneID = 418, artID = { 430,499 }, x = 7040, y = 1820, overlay = { "6720-2300","7040-1820" }, displayID = 44348 }; --Qu'nas
	[50388] = { zoneID = 418, artID = { 430,499 }, x = 1560, y = 3559, overlay = { "1420-3160","1440-3540","1460-3040","1560-3520" }, displayID = 44396 }; --Torik-Ethis
	[50768] = { zoneID = 418, artID = { 430,499 }, x = 3104, y = 3462, overlay = { "3060-3820","3100-3440" }, displayID = 44224 }; --Cournith Waterstrider
	[50787] = { zoneID = 418, artID = { 430,499 }, x = 5859, y = 4380, overlay = { "5620-4680","5860-4380" }, displayID = 44268 }; --Arness the Scale
	[50816] = { zoneID = 418, artID = { 430,499 }, x = 4283, y = 5286, overlay = { "3940-5520","4040-5280","4140-5520","4280-5280" }, displayID = 44371 }; --Ruun Ghostpaw
	[50830] = { zoneID = 418, artID = { 430,499 }, x = 5420, y = 8900, overlay = { "5220-8880","5420-8900" }, displayID = 44243 }; --Spriggin
	[68317] = { zoneID = 418, artID = { 499 }, x = 8440, y = 3100, overlay = { "8440-3100" }, friendly = { "A" }, displayID = 46743, event = 6 }; --Mavis Harms <Champion of the Shadows>
	[68318] = { zoneID = 418, artID = { 499 }, x = 8480, y = 2720, overlay = { "8480-2720" }, friendly = { "A" }, displayID = 46747, event = 6 }; --Dalan Nightbreaker <Champion of Arms>
	[68319] = { zoneID = 418, artID = { 499 }, x = 8740, y = 2920, overlay = { "8740-2920" }, friendly = { "A" }, displayID = 46745, event = 6 }; --Disha Fearwarden <Champion of the Light>
	[68320] = { zoneID = 418, artID = { 499 }, x = 1320, y = 6600, overlay = { "1300-6660" }, friendly = { "H" }, displayID = 46744, event = 6 }; --Ubunti the Shade <Champion of the Shadows>
	[68321] = { zoneID = 418, artID = { 499 }, x = 1400, y = 5700, overlay = { "1400-5700" }, friendly = { "H" }, displayID = 46748, event = 6 }; --Kar Warmaker <Champion of Arms>
	[68322] = { zoneID = 418, artID = { 499 }, x = 1060, y = 5700, overlay = { "1040-5680" }, friendly = { "H" }, displayID = 46746, event = 6 }; --Muerta <Champion of the Light>
	[50334] = { zoneID = 422, artID = { 434 }, x = 2520, y = 2860, overlay = { "2520-2840" }, displayID = 44166 }; --Dak the Breaker
	[50347] = { zoneID = 422, artID = { 434 }, x = 7180, y = 3760, overlay = { "7180-3740" }, displayID = 44285 }; --Karr the Darkener
	[50356] = { zoneID = 422, artID = { 434 }, x = 7315, y = 2021, overlay = { "7280-2220","7320-2040","7340-2340" }, displayID = 44351 }; --Krol the Blade
	[50739] = { zoneID = 422, artID = { 434 }, x = 3561, y = 3053, overlay = { "3560-3080","3780-2940","3920-4180" }, displayID = 44399 }; --Gar'lok
	[50776] = { zoneID = 422, artID = { 434 }, x = 6424, y = 5846, overlay = { "6420-5840" }, displayID = 44229 }; --Nalash Verdantis
	[50805] = { zoneID = 422, artID = { 434 }, x = 3615, y = 6366, overlay = { "3620-6240","3640-6120","3640-6400","3800-6360","3820-5800","3920-6240","3940-5860","3960-6040" }, displayID = 44271 }; --Omnis Grinlok
	[50821] = { zoneID = 422, artID = { 434 }, x = 3473, y = 2323, overlay = { "3480-2320" }, displayID = 44374 }; --Ai-Li Skymirror
	[50836] = { zoneID = 422, artID = { 434 }, x = 5534, y = 6354, overlay = { "5520-6380" }, displayID = 44250 }; --Ik-Ik the Nimble
	[70126] = { zoneID = 433, artID = { 445 }, x = 6380, y = 7560, overlay = { "5360-8220","5560-7360","6240-7460","6360-7360","6380-7540" }, displayID = 47874, event = 6 }; --Willy Wilder
	[50328] = { zoneID = 465, artID = { 477 }, x = 6519, y = 7980, overlay = { "6080-7780","6160-7960","6280-8060","6400-8000","6400-8140","6520-7980" }, displayID = 46665, event = 2 }; --Fangor
	[59369] = { zoneID = 477, artID = { 489 }, x = 3669, y = 3805, overlay = { "3669-3805" }, displayID = 40741 }; --Doctor Theolen Krastinov <The Butcher>
	[50358] = { zoneID = 504, artID = { 521 }, x = 5020, y = 9080, overlay = { "4800-8880","4820-8720","4920-8640","4920-8980","5020-9080" }, displayID = 47695, event = 5 }; --Haywire Sunreaver Construct
	[69099] = { zoneID = 504, artID = { 521 }, x = 6050, y = 3730, overlay = { "6050-3730" }, displayID = 47227, questReset = true, questID = { 32518 }, event = 5 }; --null
	[69664] = { zoneID = 504, artID = { 521 }, x = 3500, y = 6260, overlay = { "3500-6240" }, displayID = 47873, event = 5 }; --Mumta <Thief of Souls>
	[69996] = { zoneID = 504, artID = { 521 }, x = 3760, y = 8260, overlay = { "3300-8100","3420-8140","3540-8140","3680-8220" }, displayID = 47886, event = 5 }; --Ku'lai the Skyclaw <Ward of Beasts>
	[69997] = { zoneID = 504, artID = { 521 }, x = 5100, y = 7119, overlay = { "5100-7120" }, displayID = 47889, event = 5 }; --Progenitus <The Firstborn>
	[69998] = { zoneID = 504, artID = { 521 }, x = 5371, y = 5313, overlay = { "5360-5300" }, displayID = 47809, event = 5 }; --Goda
	[69999] = { zoneID = 504, artID = { 521 }, x = 6160, y = 4980, overlay = { "6140-4940" }, displayID = 47595, event = 5 }; --God-Hulk Ramuk
	[70000] = { zoneID = 504, artID = { 521 }, x = 4472, y = 2979, overlay = { "4460-3000" }, displayID = 47902, event = 5 }; --Al'tabim the All-Seeing
	[70002] = { zoneID = 504, artID = { 521 }, x = 5460, y = 3579, overlay = { "5440-3540" }, displayID = 47917, event = 5 }; --Lu-Ban <The War Crafter>
	[70003] = { zoneID = 504, artID = { 521 }, x = 5959, y = 3613, overlay = { "5940-3640","6340-4900" }, displayID = 47900, event = 5 }; --Molthor <The Gatekeeper>
	[70530] = { zoneID = 504, artID = { 521 }, x = 3960, y = 8120, overlay = { "3940-8140" }, displayID = 48097, event = 5 }; --Ra'sha <Tender of Sacrifices>
	[70001] = { zoneID = 505, artID = { 522 }, x = 4459, y = 4100, overlay = { "3480-2720","3520-2560","3800-2680","4220-3220","4260-3380","4280-2900","4440-3660","4460-4100" }, displayID = 47810, event = 2 }; --Backbreaker Uru
	[69161] = { zoneID = 507, artID = { 524 }, x = 5002, y = 5832, overlay = { "4990-5400","5002-5832" }, displayID = 47257, questReset = true, questID = { 32519 }, event = 4 }; --null
	[70096] = { zoneID = 507, artID = { 524 }, x = 7860, y = 8060, overlay = { "7640-8340","7740-8240","7760-8020","7800-8380","7820-8140" }, displayID = 47868, event = 4 }; --War-God Dokah <Ward of Beasts>
	[70440] = { zoneID = 508, artID = { 525 }, x = 5951, y = 7952, overlay = { "5951-7952" }, displayID = 48053, event = 2 }; --Monara <The Last Queen>
	[70276] = { zoneID = 509, artID = { 526 }, x = 2770, y = 1990, overlay = { "6053-1990" }, displayID = 47975, event = 2 }; --No'ku Stormsayer <Lord of Tempest>
	[70430] = { zoneID = 510, artID = { 527 }, x = 6053, y = 6053, overlay = { "6053-6053" }, displayID = 34264, event = 2 }; --Rocky Horror
	[70238] = { zoneID = 512, artID = { 529 }, x = 7600, y = 2900, overlay = { "7600-2900" }, displayID = 47963, event = 2 }; --Unblinking Eye
	[70243] = { zoneID = 512, artID = { 529 }, x = 3849, y = 4808, overlay = { "3849-4808" }, displayID = 47952, event = 2 }; --Archritualist Kelada
	[70249] = { zoneID = 512, artID = { 529 }, x = 7600, y = 2900, overlay = { "7600-2900" }, displayID = 47963, event = 2 }; --Focused Eye
	[70429] = { zoneID = 512, artID = { 529 }, x = 7266, y = 1060, overlay = { "7266-1060" }, displayID = 48039, event = 2 }; --Flesh'rok the Diseased <Primordial Saurok Horror>
	[69843] = { zoneID = 513, artID = { 530 }, x = 9113, y = 5728, overlay = { "9113-5728" }, displayID = 48164, event = 2 }; --Zao'cho <The Emperor's Shield>
	[50992] = { zoneID = 525, artID = { 542 }, x = 6459, y = 5200, overlay = { "2240-6600","5160-5040","5780-2040","5840-1920","6340-7960","6360-8100","6440-5240" }, displayID = 61218 }; --Gorok
	[51015] = { zoneID = 535, artID = { 552 }, x = 8040, y = 5600, overlay = { "5500-8120","6200-4540","6240-3320","6240-4700","6720-5980","7940-5540" }, displayID = 61216 }; --Silthide
	[50883] = { zoneID = 539, artID = { 556 }, x = 5680, y = 5220, overlay = { "3860-3700","3960-3500","4240-3080","4320-3260","4420-4320","4580-6740","5320-3020","5620-5200" }, displayID = 61221 }; --Pathrunner
	[50985] = { zoneID = 543, artID = { 560 }, x = 5140, y = 4310, overlay = { "4200-2500","4320-5550","4540-4750","4700-5410","5140-4310" }, displayID = 61217 }; --Poundfist
	[50981] = { zoneID = 550, artID = { 567 }, x = 8419, y = 6360, overlay = { "6620-4400","7220-5380","7440-3240","7600-3060","7940-5500","7960-5640","8420-6360" }, displayID = 61220 }; --Luk'hok
	[50990] = { zoneID = 550, artID = { 567 }, x = 6440, y = 2000, overlay = { "5000-3420","5440-3560","6020-3200","6240-1480","6260-1800","6440-2000" }, displayID = 61219 }; --Nakk the Thunderer
	[71864] = { zoneID = 554, artID = { 571 }, x = 5950, y = 4887, overlay = { "5800-4860","5920-4840" }, displayID = 40976, event = 4 }; --Spelurk
	[71919] = { zoneID = 554, artID = { 571 }, x = 3745, y = 7741, overlay = { "3720-7720" }, displayID = 44361, event = 4 }; --Zhu-Gon the Sour
	[72045] = { zoneID = 554, artID = { 571 }, x = 2520, y = 3600, overlay = { "2520-3540" }, displayID = 44784, event = 4 }; --Chelon
	[72048] = { zoneID = 554, artID = { 571 }, x = 6060, y = 8780, overlay = { "6020-8740" }, displayID = 49277, event = 4 }; --Rattleskew
	[72049] = { zoneID = 554, artID = { 571 }, x = 4380, y = 6960, overlay = { "4380-6940" }, displayID = 39588, event = 4 }; --Cranegnasher
	[72193] = { zoneID = 554, artID = { 571 }, x = 3380, y = 8580, overlay = { "3380-8520" }, displayID = 29487, event = 4 }; --Karkanos <The Gushing Maw>
	[72245] = { zoneID = 554, artID = { 571 }, x = 4724, y = 8803, overlay = { "4700-8740" }, displayID = 51015, event = 4 }; --Zesqua
	[72775] = { zoneID = 554, artID = { 571 }, x = 6489, y = 7483, overlay = { "6200-7640","6340-7300","6480-7420","6520-6920","6640-6720","6660-6540" }, displayID = 48112, event = 4 }; --Bufo
	[72808] = { zoneID = 554, artID = { 571 }, x = 5406, y = 4233, overlay = { "5400-4240" }, displayID = 51132, event = 4 }; --Tsavo'ka <Ghost in the Darkness>
	[72909] = { zoneID = 554, artID = { 571 }, x = 4202, y = 7323, overlay = { "3020-7100","3020-7280","3120-7020","3140-7440","3180-7600","3220-7740","3260-7080","3340-7940","3420-7100","3520-7000","3520-8000","3640-8060","3680-6940","3720-8220","3860-8220","3940-6980","4020-8280","4040-7920","4040-8140","4080-6920","4120-7760","4140-7100","4140-7260","4220-7400","4220-7600","3800-6980" }, displayID = 46461, event = 4 }; --Gu'chi the Swarmbringer
	[72970] = { zoneID = 554, artID = { 571 }, x = 6203, y = 6369, overlay = { "6120-6380","6200-6240" }, displayID = 51013, event = 4 }; --Golganarr
	[73158] = { zoneID = 554, artID = { 571 }, x = 4479, y = 5360, overlay = { "2940-5020","2980-4540","2980-6140","2980-6600","3000-6260","3020-5800","3040-4360","3040-6480","3060-5240","3080-5000","3100-6600","3120-6260","3120-7940","3160-4000","3200-5260","3220-4880","3220-8060","3320-3940","3620-3940","3620-4060","3640-8380","3760-4160","3920-4340","3920-6800","4000-3940","4040-4080","4040-4340","4220-7020","4240-6680","4240-6800","4340-5520","4420-6100","4440-5400" }, displayID = 51264, event = 4 }; --Emerald Gander
	[73160] = { zoneID = 554, artID = { 571 }, x = 4459, y = 4380, overlay = { "2780-5120","2780-6000","2820-4020","2860-4740","2920-4300","2920-4440","2940-7140","2960-4580","2980-7000","3080-4740","3080-7080","3120-5760","3160-4320","3160-5880","3220-4480","3320-3860","3340-6120","3360-3720","3420-7100","3520-4180","3540-6740","3600-7060","3940-3840","4160-3960","4380-4380" }, displayID = 51284, event = 4 }; --Ironfur Steelhorn
	[73161] = { zoneID = 554, artID = { 571 }, x = 2660, y = 7240, overlay = { "2060-4320","2100-4440","2140-6460","2140-6620","2200-4260","2200-6160","2220-5360","2220-6780","2240-4580","2260-6540","2300-4740","2320-6320","2320-6980","2340-4900","2340-6060","2360-5340","2380-5920","2440-5780","2540-5040","2540-5240","2540-5580","2560-5780","2580-5440","2580-7160" }, displayID = 51127, event = 4 }; --Great Turtle Furyshell
	[73163] = { zoneID = 554, artID = { 571 }, x = 5300, y = 5880, overlay = { "2560-4640","2740-6140","2740-6920","2880-6200","2900-4340","2900-6360","2940-7320","3020-3660","3100-7540","3340-4560","3440-7420","3620-7360","4420-6620","5040-4620","5300-5840" }, displayID = 51135, event = 4 }; --Imperial Python
	[73166] = { zoneID = 554, artID = { 571 }, x = 6880, y = 7480, overlay = { "1740-5240","1740-7260","1820-5460","1820-7520","1860-6400","1880-5780","2020-7700","2040-4800","2060-7080","2100-3620","2120-4680","2120-6420","2140-3260","2220-3100","2320-3440","2340-2840","2340-3580","2420-7500","2540-7440","2620-7340","2700-7520","2740-7980","2820-8120","3060-3120","3540-8700","3640-8620","3800-8600","3860-8720","4020-9060","4480-8920","4560-9040","5220-8660","6160-8320","6320-7980","6540-7780","6720-7760","6800-7420" }, displayID = 51146, event = 4 }; --Monstrous Spineclaw
	[73167] = { zoneID = 554, artID = { 571 }, x = 5662, y = 5582, overlay = { "5740-5780","6500-5720","6540-3620","6600-5880","6660-5760","6720-5900","6860-5840","6940-5740","7240-5440","7300-5080","7420-4160","7440-4360","5662-5582" }, displayID = 51161, event = 4 }; --Huolon <The Black Wind>
	[73169] = { zoneID = 554, artID = { 571 }, x = 5330, y = 8315, overlay = { "5300-8240" }, displayID = 51210, event = 4 }; --Jakur of Ordon
	[73170] = { zoneID = 554, artID = { 571 }, x = 5758, y = 7676, overlay = { "5720-7640" }, displayID = 51211, event = 4 }; --Watcher Osu
	[73171] = { zoneID = 554, artID = { 571 }, x = 7100, y = 4720, overlay = { "6060-4840","6100-4660","6140-4540","6240-4420","6420-4120","6420-4240","6540-4260","6540-6020","6640-5840","6660-4260","6720-5740","6780-4180","6820-4420","6840-5480","6840-5680","6920-5840","6940-4560","6960-4440","6960-5500","7020-5200","7040-4920","7040-5080","7080-4760","7100-4480","7100-4640","6820-4300" }, displayID = 51202, event = 4 }; --Champion of the Black Flame
	[73172] = { zoneID = 554, artID = { 571 }, x = 4868, y = 3566, overlay = { "4040-2640","4080-2780","4380-3340","4640-3980","4840-3620","5540-3800" }, displayID = 51193, event = 4 }; --Flintlord Gairan
	[73173] = { zoneID = 554, artID = { 571 }, x = 4435, y = 2705, overlay = { "4340-2600","4460-2540","4435-2705" }, displayID = 51194, event = 4 }; --Urdur the Cauterizer
	[73174] = { zoneID = 554, artID = { 571 }, x = 5808, y = 2504, overlay = { "4840-3280","4960-3360","4980-2360","5040-2240","5060-2460","5540-3520","5660-2420","5660-3540","5720-2700","5800-2520" }, displayID = 51203, event = 4 }; --Archiereus of Flame
	[73175] = { zoneID = 554, artID = { 571 }, x = 5460, y = 5380, overlay = { "5400-5240","5440-5360" }, displayID = 51192, event = 4 }; --Cinderfall
	[73277] = { zoneID = 554, artID = { 571 }, x = 6725, y = 4421, overlay = { "6720-4400" }, displayID = 51206, event = 4 }; --Leafmender
	[73279] = { zoneID = 554, artID = { 571 }, x = 3937, y = 9623, overlay = { "1360-3620","1400-3760","1400-5800","1420-2960","1420-5240","1440-4340","1440-4460","1460-5960","1480-5680","1540-6220","1560-2660","1620-6320","1640-2380","1680-2240","1740-2060","1760-6760","1820-6880","1920-7040","1940-7240","1960-1480","2080-7400","2080-7580","2200-7740","2220-7860","2380-0840","2400-8280","2620-8540","2700-0560","2840-8720","2880-0380","3120-8940","3260-9000","3640-9340","3920-9580","4040-9680","4160-0320","4460-9760","4580-0320","4920-9780","5080-9760","5700-0640","5900-9680","6140-9680","6360-9520","6500-9340","7100-8760","7440-1780","7600-2100","7820-2580","8020-3400","1420-4860","5660-9680" }, displayID = 37338, event = 4 }; --Evermaw <Gnawing Hunger of the Deep>
	[73281] = { zoneID = 554, artID = { 571 }, x = 2600, y = 2340, overlay = { "2600-2340" }, displayID = 51213, event = 4 }; --Dread Ship Vazuvius
	[73282] = { zoneID = 554, artID = { 571 }, x = 6500, y = 2740, overlay = { "6320-3000","6400-2720","6420-2840" }, displayID = 51214, event = 4 }; --Garnia
	[73293] = { zoneID = 554, artID = { 571 }, x = 4280, y = 5940, overlay = { "3500-5240","4000-6300","4140-4740","4260-5960" }, friendly = { "A","H" }, displayID = 37498, event = 4 }; --Whizzig <Merchant of Time>
	[73666] = { zoneID = 554, artID = { 571 }, x = 3460, y = 3160, overlay = { "3420-3140","3440-3020" }, displayID = 51203, event = 4 }; --Archiereus of Flame
	[73704] = { zoneID = 554, artID = { 571 }, x = 7119, y = 8260, overlay = { "7120-8240" }, displayID = 51813, event = 4 }; --Stinkbraid <Southsea Captain>
	[72769] = { zoneID = 555, artID = { 572 }, x = 7480, y = 3460, overlay = { "4800-6120","4840-6380","5240-7260","5360-7160","5400-6800","5600-2880","5600-3080","6220-3380","6220-3800","6240-3500","6400-4780","6400-6320","6500-6440","6920-6100","7020-6220","7280-2860","7380-3100","7440-3240","7480-3460" }, displayID = 51316, event = 4 }; --Spirit of Jadefire
	[73157] = { zoneID = 555, artID = { 572 }, x = 4207, y = 3230, overlay = { "4200-3320","4240-3200","4360-3440","4400-3000","4400-3260","4520-3120","4540-3260","4580-2140","4640-3360","4660-3240","4700-3480","4740-3620","4840-3040","4940-3560","4980-2760","5000-2940","4380-3120" }, displayID = 51118, event = 4 }; --Rock Moss
}
