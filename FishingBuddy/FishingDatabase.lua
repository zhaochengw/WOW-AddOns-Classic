-- FBI
--
-- Handle collecting data about fishies.
local addonName, FBStorage = ...
local  FBI = FBStorage
local FBConstants = FBI.FBConstants;

-- 5.0.4 has a problem with a global "_" (see some for loops below)
local _

local FL = LibStub("LibFishing-1.0");
local LO = LibStub("LibOptionsFrame-1.0");

local zmto = function(...) return FBI:ZoneMarkerTo(...); end;
local zmex = function(...) return FBI:ZoneMarkerEx(...); end;

-- Nat Pagle fish
local PagleFish = {};
PagleFish[86545] = {
	["enUS"] = "Mimic Octopus",
	quest = 31446,
};
PagleFish[86544] = {
	["enUS"] = "Spinefish Alpha",
	quest = 31444,
};
PagleFish[86542] = {
	["enUS"] = "Flying Tiger Gourami",
	quest = 31443,
};

-- Lunkers
PagleFish[116817] = {
	["enUS"] = "Blackwater Whiptail Lunker",
	lunker = true,
};
PagleFish[116818] = {
	["enUS"] = "Abyssal Gulper Lunker",
	lunker = true,
};
PagleFish[116819] = {
	["enUS"] = "Fire Ammonite Lunker",
	lunker = true,
};
PagleFish[116820] = {
	["enUS"] = "Blind Lake Lunker",
	lunker = true,
};
PagleFish[116821] = {
	["enUS"] = "Fat Sleeper Lunker",
	lunker = true,
};
PagleFish[116822] = {
	["enUS"] = "Jawless Skulker Lunker",
	lunker = true,
};
PagleFish[127994] = {
	["enUS"] = "Felmouth Frenzy Lunker",
	lunker = true,
};

PagleFish[116158] = {
	["enUS"] = "Lunarfall Carp",
	limit = 5
};
PagleFish[112633] = {
	["enUS"] = "Frostdeep Minnow",
};
PagleFish[122696] = {
	["enUS"] = "Sea Scorpion Minnow",
};
PagleFish[110508] = {
	["enUS"] = "Sea Scorpion Minnow",
};

FBI.PagleFish = PagleFish;

-- we should collect these, but then they would be in the cache
local QuestItems = {};
	QuestItems[6717] = {
		["enUS"] = "Gaffer Jack",
		["deDE"] = "Klemm-Muffen",
		["esES"] = "Mecanismo el�ctrico",
		["frFR"] = "Rouage �lectrique",
	};
	QuestItems[6718] = {
		["enUS"] = "Electropeller",
		["deDE"] = "Elektropeller",
		["esES"] = "Electromuelle",
		["frFR"] = "Electropeller",
	};
	QuestItems[16970] = {
		["enUS"] = "Misty Reed Mahi Mahi",
		["deDE"] = "Nebelschilf-Mahi-Mahi",
		["frFR"] = "Mahi Mahi de Brumejonc",
	};
	QuestItems[16968] = {
		["enUS"] = "Sar'theris Striker",
		["deDE"] = "Sar'theris-Barsch",
		["frFR"] = "Frappeur Sar'theris",
	};
	QuestItems[16969] = {
		["enUS"] = "Savage Coast Blue Sailfin",
		["deDE"] = "Blauwimpel von der ungez�hmten K�ste",
		["frFR"] = "Sailfin bleu de la C�te sauvage",
	};
	QuestItems[16967] = {
		["enUS"] = "Feralas Ahi",
		["frFR"] = "Ahi de Feralas",
	};
	QuestItems[34865] = {
		["enUS"] = "Blackfin Darter",
	};
	QuestItems[45328] = {
		["enUS"] = "Bloated Slippery Eel",
		open = true,
	};
	QuestItems[35313] = {
		["enUS"] = "Bloated Barbed Gill Trout",
		open = true,
	};
	QuestItems[58856] = {
		["enUS"] = "Royal Monkfish",
		open = true,
	};
	QuestItems[69914] = {
		["enUS"] = "Giant Catfish",
		open = true,
	};
	QuestItems[69956] = {
		["enUS"] = "Blind Cavefish",
		open = true,
	};
	FBI.QuestItems = QuestItems;

-- handle the vagaries of zones and subzones
local subzonemapping;

function FBI:ResetMappings()
	subzonemapping = nil;
end

local function initmappings()
	if ( not subzonemapping ) then
		subzonemapping = {};
		for mapId,_ in pairs(FishingBuddy_Info["KnownZones"]) do
			local zidm = zmto(mapId,0);
			local count = FishingBuddy_Info["SubZones"][zidm];
			if ( count and count > 0 ) then
				subzonemapping[mapId] = {};
				for s=1,count,1 do
					zidm = zmto(mapId, s);
					local sz = FishingBuddy_Info["SubZones"][zidm];
					subzonemapping[mapId][sz] = s;
				end
			end
		end
	end
end

-- map an old map number to a new mapId for internal data
-- tables in Classic
local oldToNewMapId = {
	[4] = 1,
	[9] = 7,
	[11] = 10,
	[13] = 12,
	[14] = 13,
	[16] = 14,
	[17] = 15,
	[19] = 17,
	[20] = 18,
	[21] = 21,
	[22] = 22,
	[23] = 23,
	[24] = 25,
	[26] = 26,
	[27] = 27,
	[28] = 32,
	[29] = 36,
	[30] = 37,
	[32] = 42,
	[886] = 456,
	[1014] = 625,
	[887] = 457,
	[1015] = 630,
	[888] = 460,
	[381] = 89,
	[889] = 461,
	[1017] = 634,
	[890] = 462,
	[1018] = 641,
	[382] = 998,
	[891] = 463,
	[510] = 127,
	[40] = 56,
	[892] = 465,
	[1020] = 645,
	[893] = 467,
	[1021] = 646,
	[894] = 468,
	[1022] = 649,
	[895] = 469,
	[512] = 128,
	[640] = 207,
	[1024] = 650,
	[321] = 85,
	[1026] = 661,
	[161] = 71,
	[1027] = 671,
	[1028] = 672,
	[1031] = 676,
	[81] = 65,
	[1033] = 680,
	[1034] = 694,
	[1037] = 696,
	[1038] = 697,
	[521] = 130,
	[1041] = 703,
	[1042] = 706,
	[906] = 483,
	[1044] = 709,
	[1046] = 713,
	[41] = 57,
	[1047] = 714,
	[1048] = 715,
	[781] = 333,
	[1050] = 717,
	[1051] = 718,
	[1052] = 719,
	[911] = 486,
	[528] = 142,
	[912] = 487,
	[529] = 147,
	[1057] = 726,
	[530] = 153,
	[1059] = 728,
	[914] = 488,
	[531] = 155,
	[1065] = 731,
	[1067] = 733,
	[919] = 490,
	[1071] = 738,
	[920] = 498,
	[1072] = 739,
	[793] = 337,
	[461] = 93,
	[795] = 338,
	[462] = 94,
	[1078] = 748,
	[42] = 62,
	[796] = 339,
	[1080] = 750,
	[463] = 95,
	[1082] = 757,
	[1084] = 758,
	[464] = 97,
	[544] = 174,
	[800] = 367,
	[928] = 504,
	[545] = 179,
	[673] = 210,
	[401] = 91,
	[929] = 507,
	[1090] = 773,
	[201] = 78,
	[1092] = 776,
	[466] = 101,
	[1096] = 790,
	[101] = 66,
	[933] = 516,
	[1099] = 793,
	[807] = 376,
	[935] = 519,
	[808] = 378,
	[1104] = 799,
	[341] = 87,
	[809] = 379,
	[937] = 520,
	[810] = 388,
	[811] = 390,
	[939] = 523,
	[35] = 48,
	[684] = 217,
	[940] = 524,
	[685] = 218,
	[813] = 397,
	[471] = 103,
	[1114] = 806,
	[686] = 219,
	[1116] = 823,
	[816] = 398,
	[281] = 83,
	[689] = 224,
	[945] = 534,
	[141] = 70,
	[946] = 535,
	[819] = 399,
	[947] = 539,
	[1126] = 824,
	[820] = 401,
	[948] = 542,
	[949] = 543,
	[950] = 550,
	[823] = 407,
	[951] = 554,
	[824] = 409,
	[1136] = 834,
	[697] = 233,
	[953] = 556,
	[1139] = 837,
	[1140] = 838,
	[699] = 234,
	[955] = 571,
	[36] = 49,
	[700] = 241,
	[1144] = 843,
	[1145] = 844,
	[479] = 109,
	[1149] = 858,
	[480] = 110,
	[1150] = 859,
	[1151] = 860,
	[1152] = 861,
	[1153] = 862,
	[481] = 111,
	[1154] = 863,
	[1155] = 864,
	[962] = 572,
	[482] = 112,
	[708] = 244,
	[1160] = 871,
	[709] = 245,
	[1161] = 872,
	[121] = 69,
	[1162] = 875,
	[1163] = 876,
	[1164] = 877,
	[1165] = 878,
	[485] = 113,
	[1170] = 882,
	[1171] = 885,
	[970] = 577,
	[486] = 114,
	[1174] = 891,
	[1175] = 895,
	[61] = 64,
	[1176] = 896,
	[717] = 247,
	[1177] = 897,
	[973] = 582,
	[1178] = 903,
	[488] = 115,
	[720] = 249,
	[1183] = 904,
	[1184] = 994,
	[1185] = 906,
	[1186] = 907,
	[181] = 76,
	[1187] = 908,
	[978] = 588,
	[1188] = 909,
	[362] = 88,
	[851] = 416,
	[490] = 116,
	[1190] = 921,
	[1191] = 922,
	[980] = 590,
	[1192] = 923,
	[1193] = 924,
	[491] = 117,
	[1194] = 925,
	[182] = 77,
	[1195] = 926,
	[1196] = 927,
	[1197] = 928,
	[492] = 118,
	[1198] = 929,
	[1199] = 930,
	[1200] = 931,
	[1201] = 932,
	[493] = 119,
	[1202] = 933,
	[858] = 422,
	[986] = 594,
	[1205] = 936,
	[38] = 51,
	[605] = 194,
	[733] = 273,
	[495] = 120,
	[606] = 198,
	[734] = 274,
	[1211] = 939,
	[607] = 199,
	[1213] = 942,
	[496] = 121,
	[1214] = 943,
	[736] = 275,
	[1215] = 971,
	[1216] = 972,
	[737] = 276,
	[610] = 201,
	[1219] = 974,
	[994] = 610,
	[1220] = 981,
	[613] = 203,
	[499] = 122,
	[614] = 204,
	[615] = 205,
	[467] = 102,
	[540] = 169,
	[983] = 592,
	[34] = 47,
	[1210] = 938,
	[1087] = 761,
	[873] = 433,
	[501] = 123,
	[473] = 104,
	[477] = 107,
	[476] = 106,
	[941] = 525,
	[775] = 329,
	[747] = 277,
	[609] = 200,
	[502] = 124,
	[39] = 52,
	[1086] = 760,
	[866] = 427,
	[1091] = 775,
	[43] = 63,
	[1135] = 830,
	[877] = 443,
	[856] = 417,
	[261] = 81,
	[37] = 50,
	[878] = 447,
	[862] = 424,
	[864] = 425,
	[751] = 948,
	[1056] = 725,
	[1007] = 619,
	[541] = 170,
	[465] = 100,
	[880] = 448,
	[1008] = 620,
	[602] = 184,
	[301] = 84,
	[881] = 449,
	[1009] = 622,
	[626] = 206,
	[475] = 105,
	[882] = 450,
	[1010] = 623,
	[789] = 335,
	[241] = 80,
	[883] = 451,
	[1011] = 624,
	[857] = 418,
	[478] = 108,
	[884] = 452,
	[1077] = 747,
	[611] = 202,
	[772] = 327,
	[443] = 92,
	[806] = 371,
}

local function GetNewMapId(mapId)
	return oldToNewMapId[mapId] or mapId
end

function FBI:GetCurrentMapIdInfo()
	local mapId, subzone = FL:GetZoneInfo()
	return GetNewMapId(mapId) or mapId, subzone
end

function FBI:GetZoneIndex(mapId, subzone, marker)
	initmappings();
	if ( not subzonemapping[mapId] ) then
		subzonemapping[mapId] = {};
	end

	subzone = FL:GetBaseSubZone(subzone);
	if ( subzone == "The Great Sea" ) then
		-- Not sure what to do here, but we might be able to do something...
	end

	if ( not subzone or not subzonemapping[mapId][subzone] ) then
		if ( marker ) then
			return zmto(mapId, 0);
		else
			return mapId;
		end
	end

	if ( marker ) then
		return zmto(mapId, subzonemapping[mapId][subzone]);
	else
		return mapId, subzonemapping[mapId][subzone];
	end
end

function FBI:GetCurrentZoneIndex(marker)
	initmappings();
	local mapId, subzone = self:GetCurrentMapIdInfo();
	return self:GetZoneIndex(mapId, subzone, marker)
end

function FBI:AddZoneIndex(mapId, subzone, marker)
	if ( not mapId ) then
		mapId, subzone = self:GetCurrentMapIdInfo();
	end
	subzone = FL:GetBaseSubZone(subzone);
	FishingBuddy_Info["KnownZones"][mapId] = subzone

	local loczone = FL:GetLocZone(mapId);
	local zidx, sidx = self:GetZoneIndex(mapId, subzone);

	if ( FBI.SortedZones ) then
		if not FBI.MappedZones[loczone] then
			tinsert(FBI.SortedZones, loczone);
			table.sort(FBI.SortedZones);
		end
		FBI.MappedZones[loczone] = mapId
	end

	local zidm = zmto(zidx, 0);
	if ( not subzone ) then
		if ( marker ) then
			return zidm;
		else
			return zidx;
		end
	end

	initmappings();
	local locsubzone = FL:GetLocSubZone(subzone);
	if ( not subzonemapping[zidx] ) then
		subzonemapping[zidx] = {};
	end
	local newsubzone = false;
	if ( not subzonemapping[zidx][subzone] ) then
		newsubzone = true;
		sidx = FishingBuddy_Info["SubZones"][zidm];
		if ( not sidx ) then
			sidx = 1;
		else
			sidx = sidx + 1;
		end
		FishingBuddy_Info["SubZones"][zidm] = sidx;
		local sidm = zmto(zidx, sidx);
		FishingBuddy_Info["SubZones"][sidm] = subzone;
		subzonemapping[zidx][subzone] = sidx;
	end
	-- keep sort helpers up to date
	if ( newsubzone and FBI.SortedByZone ) then
		if ( not FBI.SortedByZone[loczone] ) then
			FBI.SortedByZone[loczone] = {};
		end
		tinsert(FBI.SortedByZone[loczone], locsubzone);
		table.sort(FBI.SortedByZone[loczone]);

		if ( not FBI.UniqueSubZones[locsubzone] ) then
			FBI.UniqueSubZones[locsubzone] = 1;
			tinsert(FBI.SortedSubZones, locsubzone);
			table.sort(FBI.SortedSubZones);
		end

		if ( not FBI.SubZoneMap[subzone] ) then
			FBI.SubZoneMap[subzone] = {};
		end
		local sidm = zmto(zidx, sidx);
		FBI.SubZoneMap[subzone][sidm] = 1;
	end
	if ( marker ) then
		return zmto(zidx, subzonemapping[zidx][subzone]);
	else
		return zidx, subzonemapping[zidx][subzone];
	end
end

-- User interface handling
local function IsRareFish(id, forced)
	-- always skip extravaganza fish
	if ( FBI.Extravaganza and FBI.Extravaganza.Fish[id] ) then
		return true;
	end
	return ( not forced and QuestItems[id] );
end

function FBI:IsQuestFish(id)
	if ( FishingBuddy_Info["Fishies"][id].quest or QuestItems[id] ) then
		return true;
	end
	-- return nil;
end

function FBI:IsCountedFish(id)
	id = tonumber(id);
	if ( self:IsQuestFish(id) or IsRareFish(id) or FL:IsMissedFish(id) ) then
		return false;
	end
	if ( id == 40199 ) then
		return false; -- Pygmy Suckerfish
	end
	return true;
end

local questType = _G.GetItemClassInfo(Enum.ItemClass.Questitem);
local CurLoc = GetLocale();
function FBI:AddFishie(color, id, name, mapId, subzone, texture, quantity, quality, level, it, st, poolhint)
	local GSB = function(...) return FBI:GetSettingBool(...); end;
	if ( id and not FishingBuddy_Info["Fishies"][id] ) then
		if ( not color ) then
			local _,_,_,hex = GetItemQualityColor(quality);
			_,_,color = string.find(hex, "|c(%a+)");
		end
		FishingBuddy_Info["Fishies"][id] = { };
		FishingBuddy_Info["Fishies"][id][CurLoc] = name;
		FishingBuddy_Info["Fishies"][id].texture = texture;
		FishingBuddy_Info["Fishies"][id].quality = quality;
		if ( color ~= "ffffffff" ) then
			FishingBuddy_Info["Fishies"][id].color = color;
		end
		if ( FBI.SortedFishies ) then
			tinsert(FBI.SortedFishies, { text = name, id = id });
			FBI.FishSort(FBI.SortedFishies, true);
		end
	end
	if ( name and not FishingBuddy_Info["Fishies"][id][CurLoc] ) then
		FishingBuddy_Info["Fishies"][id][CurLoc] = name;
	end
	-- Only quest items have matching itemType and subType values, as well
	if ( (it and it == questType) or QuestItems[id] ) then
		-- subtype is Quest as well
		if ( FishingBuddy_Info["Fishies"][id].canopen == nil ) then
			FishingBuddy_Info["Fishies"][id].quest = true;
			local canopen, locked;
			if ( QuestItems[id] and QuestItems[id].open ) then
				canopen = QuestItems[id].open;
			else
				canopen, locked = FL:IsOpenable(id);
			end
			-- if it's locked, let's not deal with it (not that I can think of any
			-- quest items that are locked and openable...)
			if ( not locked ) then
				FishingBuddy_Info["Fishies"][id].canopen = canopen;
			end
		end
		if ( FishingBuddy_Info["Fishies"][id].canopen ) then
			table.insert(FBI.OpenThisFishId, id);
		end
	end

	if ( not subzone ) then
		_, subzone = self:GetCurrentMapIdInfo();
	end

	local zidx, sidx = self:AddZoneIndex(mapId, subzone);
	local idx = zmto(zidx, sidx);

	local ft = FishingBuddy_Info["FishTotals"];
	local totidx = zmto(zidx, 0);
	if( not ft[totidx] ) then
		ft[totidx] = quantity;
	else
		ft[totidx] = ft[totidx] + quantity;
	end
	if( not ft[idx] ) then
		ft[idx] = quantity;
	else
		ft[idx] = ft[idx] + quantity;
	end

	local fh = FishingBuddy_Info["FishingHoles"];
	if ( not fh[idx] ) then
		fh[idx] = {};
	end
	if ( not fh[idx][id] ) then
		fh[idx][id] = quantity;
		if ( GSB("ShowNewFishies") ) then
			FBI:Print(FBConstants.ADDFISHINFOMSG, name or UNKNOWN, subzone or FL:GetLocZone(mapId));
		end
	else
		fh[idx][id] = fh[idx][id] + quantity;
	end

	if ( FBI.ByFishie ) then
		if ( not FBI.ByFishie[id] ) then
			FBI.ByFishie[id] = {};
		end
		if ( not FBI.ByFishie[id][idx] ) then
			FBI.ByFishie[id][idx] = quantity;
		else
			FBI.ByFishie[id][idx] = FBI.ByFishie[id][idx] + quantity;
		end
	end

	if ( level ) then
		if ( not FishingBuddy_Info["Fishies"][id].level or
				  level < FishingBuddy_Info["Fishies"][id].level ) then
			FishingBuddy_Info["Fishies"][id].level = level;
		else
			level = FishingBuddy_Info["Fishies"][id].level;
		end
	end

	local fs = FishingBuddy_Info["FishingSkill"];
	if ( not fs[idx] ) then
		fs[idx] = 0;
	end
	local skill, mods, _ = FL:GetCurrentSkill();
	local skillcheck = 0;
	if ( not skillcheck ) then
		skillcheck = skill + mods;
	end

	if ( skillcheck > 0 ) then
		if ( not fs[idx] or skillcheck < fs[idx] ) then
			fs[idx] = skillcheck;
		end
		if ( id ) then
			if ( not FishingBuddy_Info["Fishies"][id].level or
				  skillcheck < FishingBuddy_Info["Fishies"][id].level ) then
				FishingBuddy_Info["Fishies"][id].level = skillcheck;
				FishingBuddy_Info["Fishies"][id].skill = skill;
				FishingBuddy_Info["Fishies"][id].mods = mods;
			end
		end
	end

	FBI:RunHandlers(FBConstants.ADD_FISHIE_EVT, id, name, mapId, subzone, texture, quantity, quality, level, idx, poolhint);
end

-- we want to dismiss the loot window as fast as possible
local lootframe = CreateFrame("Frame");
lootframe:Hide();

local lootcache = {}
local lootcheck = false;
local lootcount = 0;
local function ProcessFishLoot()
	local mapId, subzone = FBI:GetCurrentMapIdInfo();
	while (table.getn(lootcache) > 0) do
		local info = table.remove(lootcache)
		local texture, fishie, quantity, quality = info.texture, info.fishie, info.quantity, info.quality;
		local nm,link,it,st,el,il = FL:GetItemInfoFields(info.link, FL.ITEM_NAME, FL.ITEM_LINK, FL.ITEM_TYPE, FL.ITEM_SUBTYPE, FL.ITEM_EQUIPLOC, FL.ITEM_LEVEL);
		local color, id, name = FL:SplitLink(link, true);

		-- handle things we can't actually count that might be in our fish (e.g. Garrison Resources)
		if (id) then
			-- Fishing pool check? poolhint and (index == 1)
			FBI:AddFishie(color, id, name, mapId, subzone, texture, quantity, quality, nil, it, st, false);
		end
		lootcount = lootcount + 1;
		lootcheck = true;
	end
	lootframe:Hide();
	lootcache = {};
end
lootframe:SetScript("OnUpdate", ProcessFishLoot);

function FBI:GetLootState()
	return lootcount, lootcheck;
end

function FBI:AddLootCache(texture, fishie, quantity, quality, link, poolhint)
	tinsert(lootcache, {texture = texture, fishie = fishie, quantity = quantity, quality = quality, link = link, poolhint = poolhint});
	lootframe:Show()
end

FBI.Commands[FBConstants.UPDATEDB] = {};
FBI.Commands[FBConstants.UPDATEDB].help = FBConstants.UPDATEDB_HELP;
FBI.Commands[FBConstants.UPDATEDB].func =
	function(what)
		local ff = FishingBuddy_Info["Fishies"];
		local forced;
		if ( what and what == FBConstants.FORCE ) then
			forced = true;
		end
		FishingBuddyTooltip:SetOwner(FishingBuddyFrame, "ANCHOR_RIGHT");
		FishingBuddyTooltip:Show();
		local count = 0;
		for id,info in pairs(ff) do
			local item = id..":0:0:0";
			if ( forced or not FL:IsLinkableItem(item) or not info.name ) then
				if ( not IsRareFish(id, forced) ) then
					local link = "item:"..item;
					-- fetch the data (may disconnect)
					FishingBuddyTooltip:SetHyperlink(link);
					-- now that we have it in our cache, get the name
					local nm, it, st = FL:GetItemInfoFields(link, FL.ITEM_NAME, FL.ITEM_TYPE, FL.ITEM_SUBTYPE);
					if ( nm ) then
						count = count + 1;
						FishingBuddy_Info["Fishies"][id][CurLoc] = nm;
						FishingBuddy_Info["Fishies"][id].quest = (it == st);
					end
				end
			end
		end
		FBI:Print(FBConstants.UPDATEDB_MSG, count);
		return true;
	end;

