-------------------------------------------------------------------------------
-- AddOn namespace.
-------------------------------------------------------------------------------
local FOLDER_NAME, private = ...

private.CONTAINER_INFO = {
	[211990] = { zoneID = 371, artID = { 383 }, x = 2638, y = 2834, overlay = { "2638-2834" }, reset = false, achievementID = { 6850 }, minieventID = 28, criteria = 1 }; --Hozen Speech
	[213327] = { zoneID = 371, artID = { 383 }, x = 6770, y = 2950, overlay = { "6770-2950" }, reset = false, achievementID = { 6716 }, minieventID = 32, criteria = 1 }; --The Saurok
	[213333] = { zoneID = 371, artID = { 383 }, x = 4228, y = 1747, overlay = { "4228-1747" }, reset = false, achievementID = { 6754 }, minieventID = 31, criteria = 3 }; --Spirit Binders
	[213362] = { zoneID = 371, artID = { 383 }, x = 5100, y = 9999, overlay = { "5100-9999" }, reset = false, questID = { 31396 }, achievementID = { 7997 }, minieventID = 27 }; --Ship's Locker
	[213363] = { zoneID = 371, artID = { 383 }, x = 3942, y = 0723, overlay = { "3942-0723" }, reset = false, questID = { 31397 }, achievementID = { 7284 }, minieventID = 26 }; --Wodin's Mantid Shanker
	[213364] = { zoneID = {
				[371] = { x = 4414, y = 2852, artID = { 383 }, overlay = { "4414-2852" } };
				[373] = { x = 4028, y = 4175, artID = { 385 }, overlay = { "4028-4175","3921-7080","3353-7785","6440-5941","4626-2314","3721-2393" } };
			  }, reset = false, questID = { 31399 }, achievementID = { 7284 }, minieventID = 26 }; --null
	[213366] = { zoneID = 371, artID = { 383 }, x = 2622, y = 3235, overlay = { "2622-3235" }, reset = false, questID = { 31400 }, achievementID = { 7997 }, minieventID = 27 }; --Ancient Pandaren Tea Pot
	[213368] = { zoneID = 371, artID = { 383 }, x = 3196, y = 2776, overlay = { "3196-2776" }, reset = false, questID = { 31401 }, achievementID = { 7997 }, minieventID = 27 }; --Lucky Pandaren Coin
	[213415] = { zoneID = 371, artID = { 383 }, x = 3576, y = 3047, overlay = { "3576-3047" }, reset = false, achievementID = { 6858 }, minieventID = 29, criteria = 3 }; --The First Monks
	[213421] = { zoneID = 371, artID = { 383 }, x = 5590, y = 5680, overlay = { "5590-5680" }, reset = false, achievementID = { 6855 }, minieventID = 33, criteria = 3 }; --The Emperor's Burden - Part 3
	[213512] = { zoneID = 371, artID = { 383 }, x = 3738, y = 3012, overlay = { "3738-3012" }, reset = false, achievementID = { 7230 }, minieventID = 30, criteria = 2 }; --Xin Wo Yin the Broken Hearted
	[213741] = { zoneID = 371, artID = { 383 }, x = 4490, y = 6460, overlay = { "4490-6460","4640-6530","4700-6738","4640-7010" }, reset = false, questID = { 31402 }, minieventID = 26 }; --Ancient Jinyu Staff
	[213742] = { zoneID = 371, artID = { 383 }, x = 4122, y = 1385, overlay = { "4122-1385","4300-1160","4180-1770" }, reset = false, questID = { 31403 }, achievementID = { 7284 }, minieventID = 26 }; --Hammer of Ten Thunders
	[213748] = { zoneID = 371, artID = { 383 }, x = 2349, y = 3506, overlay = { "2349-3506" }, reset = false, questID = { 31404 }, achievementID = { 7997 }, minieventID = 27 }; --Pandaren Ritual Stone
	[214337] = { zoneID = 371, artID = { 383 }, x = 6245, y = 2753, overlay = { "6245-2753" }, reset = false, questID = { 31866 }, achievementID = { 7997 }, minieventID = 27 }; --Stash of Gems
	[214338] = { zoneID = 371, artID = { 383 }, x = 4630, y = 8070, overlay = { "4630-8070" }, reset = false, questID = { 31865 }, achievementID = { 7997 }, minieventID = 27 }; --Offering of Remembrance
	[214339] = { zoneID = 371, artID = { 383 }, x = 2463, y = 5327, overlay = { "2463-5327" }, reset = false, questID = { 31864 }, achievementID = { 7997 }, minieventID = 27 }; --Chest of Supplies
	[215779] = { zoneID = 371, artID = { 383 }, x = 6601, y = 8758, overlay = { "6601-8758" }, reset = false, achievementID = { 6846 }, minieventID = 34, criteria = 1 }; --Watersmithing
	[215799] = { zoneID = 371, artID = { 383 }, x = 4710, y = 4510, overlay = { "4710-4510" }, reset = false, achievementID = { 6855 }, minieventID = 33, criteria = 1 }; --The Emperor's Burden - Part 1
	[64272] = { zoneID = 371, artID = { 383 }, x = 3920, y = 4660, overlay = { "3920-4660" }, reset = false, questID = { 31307 }, achievementID = { 7284 }, minieventID = 26 }; --Jade Warrior Statue
	[213413] = { zoneID = 376, artID = { 388 }, x = 1883, y = 3168, overlay = { "1883-3168" }, reset = false, achievementID = { 6858 }, minieventID = 29, criteria = 1 }; --Pandaren Fighting Tactics
	[213459] = { zoneID = 376, artID = { 388 }, x = 2021, y = 5589, overlay = { "2021-5589" }, reset = false, achievementID = { 6856 }, minieventID = 35, criteria = 1 }; --The Birthplace of Liu Lang
	[213460] = { zoneID = 376, artID = { 388 }, x = 5506, y = 4713, overlay = { "5506-4713" }, reset = false, achievementID = { 6856 }, minieventID = 35, criteria = 2 }; --A Most Famous Bill of Sale
	[213461] = { zoneID = 376, artID = { 388 }, x = 3459, y = 6383, overlay = { "3459-6383" }, reset = false, achievementID = { 6856 }, minieventID = 35, criteria = 3 }; --The Wandering Widow
	[213649] = { zoneID = 376, artID = { 388 }, x = 4361, y = 3748, overlay = { "4361-3748" }, reset = false, questID = { 31406 }, minieventID = 26 }; --Cache of Pilfered Goods
	[213650] = { zoneID = 376, artID = { 388 }, x = 2372, y = 2833, overlay = { "2372-2833" }, reset = false, questID = { 31405 }, minieventID = 27 }; --Virmen Treasure Cache
	[213749] = { zoneID = 376, artID = { 388 }, x = 1540, y = 2910, overlay = { "1540-2910","1910-3790","1750-3570","1500-3370","1900-4250" }, reset = false, questID = { 31407 }, minieventID = 26 }; --Staff of the Hidden Master
	[213750] = { zoneID = 376, artID = { 388 }, x = 7510, y = 5510, overlay = { "7510-5510" }, reset = false, questID = { 31408 }, minieventID = 27 }; --Saurok Stone Tablet
	[214340] = { zoneID = 376, artID = { 388 }, x = 9209, y = 3908, overlay = { "9209-3908" }, reset = false, questID = { 31869 }, minieventID = 27 }; --Boat-Building Instructions
	[215780] = { zoneID = 376, artID = { 388 }, x = 6119, y = 3467, overlay = { "6119-3467" }, reset = false, achievementID = { 6846 }, minieventID = 34, criteria = 2 }; --Waterspeakers
	[215785] = { zoneID = 376, artID = { 388 }, x = 8324, y = 2116, overlay = { "8324-2116" }, reset = false, achievementID = { 6850 }, minieventID = 28, criteria = 3 }; --Embracing the Passions
	[64004] = { zoneID = 376, artID = { 388 }, x = 4680, y = 2460, overlay = { "4680-2460" }, reset = false, questID = { 31284 }, minieventID = 26 }; --Ghostly Pandaren Fisherman <Fisherman>
	[64191] = { zoneID = 376, artID = { 388 }, x = 4541, y = 3838, overlay = { "4541-3838" }, reset = false, questID = { 31292 }, minieventID = 26 }; --Ghostly Pandaren Craftsman <Woodcrafter>
	[211994] = { zoneID = 379, artID = { 391 }, x = 4574, y = 6188, overlay = { "4574-6188" }, reset = false, achievementID = { 6850 }, minieventID = 28, criteria = 4 }; --The Hozen Ravage
	[213328] = { zoneID = {
				[379] = { x = 7751, y = 9531, artID = { 391 }, overlay = { "7751-9531" } };
				[433] = { x = 4603, y = 0410, artID = { 445 }, overlay = { "4603-0410" } };
				[434] = { x = 5512, y = 1590, artID = { 446 }, overlay = { "5512-1590" } };
			  }, reset = false, achievementID = { 6716 }, minieventID = 32, criteria = 2 }; --null
	[213331] = { zoneID = {
				[379] = { x = 5059, y = 4799, artID = { 391 }, overlay = { "5059-4799" } };
				[385] = { x = 5830, y = 7145, artID = { 396 }, overlay = { "5830-7145" } };
			  }, reset = false, achievementID = { 6754 }, minieventID = 31, criteria = 1 }; --null
	[213417] = { zoneID = 379, artID = { 391 }, x = 5029, y = 7929, overlay = { "5029-7929" }, reset = false, achievementID = { 6847 }, minieventID = 36, criteria = 1 }; --Yaungol Tactics
	[213438] = { zoneID = 379, artID = { 391 }, x = 4467, y = 5240, overlay = { "4467-5240" }, reset = false, achievementID = { 7230 }, minieventID = 30, criteria = 3 }; --Ren Yun the Blind
	[213443] = { zoneID = 379, artID = { 391 }, x = 6777, y = 4834, overlay = { "6777-4834" }, reset = false, achievementID = { 6855 }, minieventID = 33, criteria = 6 }; --The Emperor's Burden - Part 6
	[213455] = { zoneID = 379, artID = { 391 }, x = 4100, y = 4236, overlay = { "4100-4236" }, reset = false, achievementID = { 6855 }, minieventID = 33, criteria = 7 }; --The Emperor's Burden - Part 7
	[213511] = { zoneID = 379, artID = { 391 }, x = 6303, y = 4081, overlay = { "6303-4081" }, reset = false, achievementID = { 6858 }, minieventID = 29, criteria = 5 }; --Victory in Kun-Lai
	[213751] = { zoneID = {
				[379] = { x = 7471, y = 7486, artID = { 391 }, overlay = { "7471-7486" } };
				[381] = { x = 5532, y = 7020, artID = { 395 }, overlay = { "5532-7020" } };
			  }, reset = false, questID = { 31412 }, minieventID = 26 }; --null
	[213765] = { zoneID = 379, artID = { 391 }, x = 4470, y = 5240, overlay = { "4470-5240" }, reset = false, questID = { 31417 }, minieventID = 26 }; --Tablet of Ren Yun
	[213768] = { zoneID = {
				[379] = { x = 5148, y = 7392, artID = { 391 }, overlay = { "5148-7392" } };
				[384] = { x = 2401, y = 6780, artID = { 393 }, overlay = { "2401-6780" } };
			  }, reset = false, questID = { 31413 }, minieventID = 26 }; --null
	[213769] = { zoneID = {
				[379] = { x = 4944, y = 5931, artID = { 391 }, overlay = { "4944-5931" } };
				[382] = { x = 5195, y = 2738, artID = { 394 }, overlay = { "5195-2738" } };
			  }, reset = false, questID = { 31414 }, minieventID = 27 }; --null
	[213770] = { zoneID = {
				[379] = { x = 5598, y = 4947, artID = { 391 }, overlay = { "5598-4947" } };
				[380] = { x = 3126, y = 5003, artID = { 397 }, overlay = { "3126-5003" } };
			  }, reset = false, questID = { 31415 }, minieventID = 27 }; --null
	[213771] = { zoneID = 379, artID = { 391 }, x = 7201, y = 3398, overlay = { "7201-3398" }, reset = false, questID = { 31416 }, minieventID = 27 }; --Statue of Xuen
	[213774] = { zoneID = 379, artID = { 391 }, x = 3674, y = 7982, overlay = { "3674-7982" }, reset = false, questID = { 31418 }, minieventID = 27 }; --Lost Adventurer's Belongings
	[213782] = { zoneID = 379, artID = { 391 }, x = 5780, y = 7630, overlay = { "5780-7630","5700-7540","5840-7340","5920-7440" }, reset = false, questID = { 31422 }, minieventID = 27 }; --Terracotta Head
	[213793] = { zoneID = 379, artID = { 391 }, x = 5256, y = 5155, overlay = { "5256-5155" }, reset = false, questID = { 31419 }, minieventID = 27 }; --Rikktik's Tiny Chest
	[213842] = { zoneID = 379, artID = { 391 }, x = 7120, y = 6260, overlay = { "7120-6260","7010-6390" }, reset = false, questID = { 31421 }, minieventID = 26 }; --Stash of Yaungol Weapons
	[214407] = { zoneID = 379, artID = { 391 }, x = 4790, y = 7347, overlay = { "4790-7347" }, reset = false, questID = { 31868 }, minieventID = 27 }; --Mo-Mo's Treasure Chest
	[214438] = { zoneID = 379, artID = { 391 }, x = 6421, y = 4511, overlay = { "6421-4511" }, reset = false, questID = { 31420 }, minieventID = 27 }; --Ancient Mogu Tablet
	[215783] = { zoneID = 379, artID = { 391 }, x = 7446, y = 8352, overlay = { "7446-8352" }, reset = false, achievementID = { 6846 }, minieventID = 34, criteria = 4 }; --Role Call
	[215797] = { zoneID = 379, artID = { 391 }, x = 4383, y = 5122, overlay = { "4383-5122" }, reset = false, achievementID = { 6855 }, minieventID = 33, criteria = 2 }; --The Emperor's Burden - Part 2
	[215798] = { zoneID = 379, artID = { 391 }, x = 7174, y = 6301, overlay = { "7174-6301" }, reset = false, achievementID = { 6847 }, minieventID = 36, criteria = 3 }; --Yaungoil
	[64227] = { zoneID = 379, artID = { 391 }, x = 3517, y = 7632, overlay = { "3517-7632" }, reset = false, questID = { 31304 }, minieventID = 26 }; --Frozen Trail Packer
	[213418] = { zoneID = 388, artID = { 400 }, x = 6540, y = 4998, overlay = { "6540-4998" }, reset = false, achievementID = { 6847 }, minieventID = 36, criteria = 2 }; --Dominance
	[213420] = { zoneID = 388, artID = { 400 }, x = 8410, y = 7284, overlay = { "8410-7284" }, reset = false, achievementID = { 6847 }, minieventID = 36, criteria = 4 }; --Trapped in a Strange Land
	[213445] = { zoneID = 388, artID = { 400 }, x = 3775, y = 6290, overlay = { "3775-6290" }, reset = false, achievementID = { 6855 }, minieventID = 33, criteria = 5 }; --The Emperor's Burden - Part 5
	[213844] = { zoneID = 388, artID = { 400 }, x = 6580, y = 8610, overlay = { "6580-8610" }, reset = false, questID = { 31426 }, minieventID = 27 }; --Amber Encased Moth
	[213956] = { zoneID = {
				[388] = { x = 3646, y = 6123, artID = { 400 }, overlay = { "3646-6123" } };
				[389] = { x = 5648, y = 6458, artID = { 401 }, overlay = { "5648-6458" } };
			  }, reset = false, questID = { 31423 }, minieventID = 27 }; --null
	[213959] = { zoneID = 388, artID = { 400 }, x = 5116, y = 5733, overlay = { "5116-5733","5250-5770","5280-5620","5560-6100","5590-5550","5740-5670" }, reset = false, questID = { 31424 }, achievementID = { 7997 }, minieventID = 27 }; --Hardened Sap of Kri'vess
	[213960] = { zoneID = 388, artID = { 400 }, x = 6630, y = 4470, overlay = { "6630-4470","6680-4800" }, reset = false, questID = { 31425 }, minieventID = 26 }; --Yaungol Fire Carrier
	[213961] = { zoneID = 388, artID = { 400 }, x = 6282, y = 3405, overlay = { "6282-3405" }, reset = false, questID = { 31427 }, minieventID = 27 }; --Abandoned Crate of Goods
	[213334] = { zoneID = 390, artID = { 1972,402 }, x = 4025, y = 7748, overlay = { "4025-7748" }, reset = false, achievementID = { 6754 }, minieventID = 31, criteria = 4 }; --The Thunder King
	[213414] = { zoneID = 390, artID = { 1972,402 }, x = 5291, y = 6872, overlay = { "5291-6872" }, reset = false, achievementID = { 6858 }, minieventID = 29, criteria = 2 }; --Always Remember
	[213416] = { zoneID = 390, artID = { 1972,402 }, x = 2661, y = 2148, overlay = { "2661-2148" }, reset = false, achievementID = { 6858 }, minieventID = 29, criteria = 4 }; --Together, We Are Strong
	[213456] = { zoneID = 390, artID = { 1972,402 }, x = 6770, y = 4429, overlay = { "6770-4429" }, reset = false, achievementID = { 6855 }, minieventID = 33, criteria = 8 }; --The Emperor's Burden - Part 8
	[211993] = { zoneID = 418, artID = { 430, 499 }, x = 5242, y = 8770, overlay = { "5242-8770" }, reset = false, achievementID = { 6850 }, minieventID = 28, criteria = 2 }; --Hozen Maturity
	[213330] = { zoneID = 418, artID = { 430, 499 }, x = 3282, y = 2942, overlay = { "3282-2942" }, reset = false, achievementID = { 6716 }, minieventID = 32, criteria = 4 }; --The Last Stand
	[213332] = { zoneID = 418, artID = { 430, 499 }, x = 5095, y = 3165, overlay = { "5095-3165" }, reset = false, achievementID = { 6754 }, minieventID = 31, criteria = 2 }; --The Lost Dynasty
	[213407] = { zoneID = 418, artID = { 430, 499 }, x = 8140, y = 1142, overlay = { "8140-1142" }, reset = false, achievementID = { 7230 }, minieventID = 30, criteria = 1 }; --Quan Tou Kuo the Two Fisted
	[213422] = { zoneID = 418, artID = { 430, 499 }, x = 4047, y = 5665, overlay = { "4047-5665" }, reset = false, achievementID = { 6855 }, minieventID = 33, criteria = 4 }; --The Emperor's Burden - Part 4
	[213651] = { zoneID = 418, artID = { 430, 499 }, x = 4228, y = 9195, overlay = { "4228-9195" }, reset = false, questID = { 31410 }, minieventID = 26 }; --Equipment Locker
	[213653] = { zoneID = 418, artID = { 430, 499 }, x = 5080, y = 4930, overlay = { "5080-4930" }, reset = false, questID = { 31409 }, minieventID = 26 }; --Pandaren Fishing Spear
	[214403] = { zoneID = 418, artID = { 430, 499 }, x = 5216, y = 7341, overlay = { "5216-7341" }, reset = false, questID = { 31863 }, minieventID = 27 }; --Stack of Papers
	[214439] = { zoneID = 418, artID = { 430, 499 }, x = 5237, y = 8865, overlay = { "5237-8865" }, reset = false, questID = { 31411 }, minieventID = 26 }; --Barrel of Banana Infused Rum
	[215765] = { zoneID = 418, artID = { 430, 499 }, x = 7220, y = 3097, overlay = { "7220-3097" }, reset = false, achievementID = { 6856 }, minieventID = 35, criteria = 4 }; --Waiting for the Turtle
	[215782] = { zoneID = 418, artID = { 430, 499 }, x = 3053, y = 3863, overlay = { "3053-3863" }, reset = false, achievementID = { 6846 }, minieventID = 34, criteria = 3 }; --Origins
	[213329] = { zoneID = 422, artID = { 434 }, x = 6743, y = 6080, overlay = { "6743-6080" }, reset = false, achievementID = { 6716 }, minieventID = 32, criteria = 3 }; --The Deserters
	[213409] = { zoneID = 422, artID = { 434 }, x = 4835, y = 3285, overlay = { "4835-3285" }, reset = false, achievementID = { 6857 }, minieventID = 37, criteria = 1 }; --Cycle of the Mantid
	[213410] = { zoneID = 422, artID = { 434 }, x = 5991, y = 5514, overlay = { "5991-5514" }, reset = false, achievementID = { 6857 }, minieventID = 37, criteria = 2 }; --Mantid Society
	[213411] = { zoneID = 422, artID = { 434 }, x = 5250, y = 1003, overlay = { "5250-1003" }, reset = false, achievementID = { 6857 }, minieventID = 37, criteria = 3 }; --Amber
	[213412] = { zoneID = 422, artID = { 434 }, x = 3553, y = 3261, overlay = { "3553-3261" }, reset = false, achievementID = { 6857 }, minieventID = 37, criteria = 4 }; --The Empress
	[213962] = { zoneID = 422, artID = { 434 }, x = 7180, y = 3610, overlay = { "7180-3610" }, reset = false, questID = { 31666 }, minieventID = 26 }; --Wind-Reaver's Dagger of Quick Strikes
	[213964] = { zoneID = 422, artID = { 434 }, x = 4870, y = 3000, overlay = { "4870-3000" }, reset = false, questID = { 31430 }, minieventID = 26 }; --Malik's Stalwart Spear
	[213966] = { zoneID = 422, artID = { 434 }, x = 3300, y = 3010, overlay = { "3300-3010" }, reset = false, questID = { 31431 }, minieventID = 26 }; --Amber Encased Necklace
	[213967] = { zoneID = 422, artID = { 434 }, x = 6630, y = 6653, overlay = { "6630-6653" }, reset = false, questID = { 31433 }, minieventID = 26 }; --Blade of the Prime
	[213968] = { zoneID = 422, artID = { 434 }, x = 5680, y = 7760, overlay = { "5680-7760" }, reset = false, questID = { 31434 }, minieventID = 26 }; --Swarming Cleaver of Ka'roz
	[213969] = { zoneID = 422, artID = { 434 }, x = 3020, y = 9080, overlay = { "3020-9080" }, reset = false, questID = { 31435 }, minieventID = 26 }; --Dissector's Staff of Mutation
	[213970] = { zoneID = 422, artID = { 434 }, x = 2596, y = 5024, overlay = { "2596-5024" }, reset = false, questID = { 31436 }, minieventID = 26 }; --Bloodsoaked Chitin Fragment
	[213971] = { zoneID = 422, artID = { 434 }, x = 5429, y = 5636, overlay = { "5429-5636" }, reset = false, questID = { 31437 }, minieventID = 26 }; --Swarmkeeper's Medallion
	[213972] = { zoneID = 422, artID = { 434 }, x = 2880, y = 4190, overlay = { "2880-4190" }, reset = false, questID = { 31438 }, minieventID = 26 }; --Blade of the Poisoned Mind
	[65552] = { zoneID = 422, artID = { 434 }, x = 4200, y = 6220, overlay = { "4080-6340","4120-6460","4200-6220","4220-6380" }, reset = false, questID = { 31432 }, minieventID = 26 }; --Glinting Rapana Whelk
	[213845] = { zoneID = 433, artID = { 445 }, x = 7492, y = 7647, overlay = { "7492-7647" }, reset = false, questID = { 31428 }, minieventID = 27 }; --The Hammer of Folly
	[214325] = { zoneID = 433, artID = { 445 }, x = 5468, y = 7129, overlay = { "5468-7129" }, reset = false, questID = { 31867 }, minieventID = 27 }; --Forgotten Lockbox
	[218427] = { zoneID = 504, artID = { 521 }, x = 3530, y = 7020, overlay = { "3530-7020" }, reset = false, achievementID = { 8049 }, minieventID = 38, criteria = 1, event= 4 }; --Coming of Age
	[218428] = { zoneID = 504, artID = { 521 }, x = 6602, y = 4462, overlay = { "6602-4462" }, reset = false, achievementID = { 8049 }, minieventID = 38, criteria = 2, event= 4 }; --For Council and King
	[218429] = { zoneID = 504, artID = { 521 }, x = 3630, y = 7035, overlay = { "3630-7035" }, reset = false, achievementID = { 8049 }, minieventID = 38, criteria = 3, event= 4 }; --Shadows of the Loa
	[218430] = { zoneID = 504, artID = { 521 }, x = 5265, y = 4138, overlay = { "5265-4138" }, reset = false, achievementID = { 8049 }, minieventID = 38, criteria = 4, event= 4 }; --The Dark Prophet Zul
	[218431] = { zoneID = 504, artID = { 521 }, x = 4018, y = 4075, overlay = { "4018-4075" }, reset = false, achievementID = { 8050 }, minieventID = 39, criteria = 1, event= 4 }; --Lei Shen
	[218432] = { zoneID = 504, artID = { 521 }, x = 4707, y = 5991, overlay = { "4707-5991" }, reset = false, achievementID = { 8050 }, minieventID = 39, criteria = 2, event= 4 }; --The Sacred Mount
	[218433] = { zoneID = 504, artID = { 521 }, x = 3489, y = 6559, overlay = { "3489-6559" }, reset = false, achievementID = { 8050 }, minieventID = 39, criteria = 3, event= 4 }; --Unity at a Price
	[218434] = { zoneID = 504, artID = { 521 }, x = 6075, y = 6878, overlay = { "6075-6878" }, reset = false, achievementID = { 8050 }, minieventID = 39, criteria = 4, event= 4 }; --The Pandaren Problem
	[218435] = { zoneID = 504, artID = { 521 }, x = 3583, y = 5471, overlay = { "3583-5471" }, reset = false, achievementID = { 8051 }, minieventID = 40, criteria = 1, event= 4 }; --Agents of Order
	[218436] = { zoneID = 504, artID = { 521 }, x = 5929, y = 2626, overlay = { "5929-2626" }, reset = false, achievementID = { 8051 }, minieventID = 40, criteria = 2, event= 4 }; --Shadow, Storm, and Stone
	[218437] = { zoneID = 504, artID = { 521 }, x = 4992, y = 2035, overlay = { "4992-2035" }, reset = false, achievementID = { 8051 }, minieventID = 40, criteria = 3, event= 4 }; --The Curse and the Silence
	[218438] = { zoneID = 504, artID = { 521 }, x = 6253, y = 3772, overlay = { "6253-3772" }, reset = false, achievementID = { 8051 }, minieventID = 40, criteria = 4, event= 4 }; --Age of a Hundred Kings
	[220832] = { zoneID = 554, artID = { 571 }, x = 4033, y = 9317, overlay = { "4033-9317" }, weeklyReset = true, questID = { 32957 }, event= 4 }; --Sunken Treasure
	[220901] = { zoneID = 554, artID = { 571 }, x = 4965, y = 6940, overlay = { "4970-6950" }, weeklyReset = true, questID = { 32969 }, event= 4 }; --Gleaming Treasure Chest
	[220902] = { zoneID = 554, artID = { 571 }, x = 5393, y = 4722, overlay = { "5380-4750" }, weeklyReset = true, questID = { 32968 }, event= 4 }; --Rope-Bound Treasure Chest
	[220986] = { zoneID = 554, artID = { 571 }, x = 2280, y = 5895, overlay = { "2280-5895" }, weeklyReset = true, questID = { 32956 }, event= 4 }; --Blackguard's Jetsam
	[221036] = { zoneID = 554, artID = { 571 }, x = 7060, y = 8092, overlay = { "7052-8093" }, weeklyReset = true, questID = { 32970 }, event= 4 }; --Gleaming Treasure Satchel
}