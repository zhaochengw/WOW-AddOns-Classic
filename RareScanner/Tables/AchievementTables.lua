-------------------------------------------------------------------------------
-- AddOn namespace.
-------------------------------------------------------------------------------
local FOLDER_NAME, private = ...

private.ACHIEVEMENT_ZONE_IDS = {
	[1948] = { 1312 }; --Shadowmoon valley (BC)
	[1953] = { 1312 }; --Netherstorm (BC)
	[1944] = { 1312 }; --Hellfire peninsula (BC)
	[1949] = { 1312 }; --Blades edge mountains (BC)
	[1946] = { 1312 }; --Zangarmarsh (BC)
	[1952] = { 1312 }; --Terokkar forest (BC)
	[1951] = { 1312 }; --Nagrand (BC)
	[119] = { 2257 }; --Sholazar basin (WOLK)
	[120] = { 2257 }; --The storm peaks (WOLK)
	[114] = { 2257 }; --Borean tundra (WOLK)
	[117] = { 2257 }; --Howling fjord (WOLK)
	[121] = { 2257 }; --Zul drak (WOLK)
	[115] = { 2257 }; --Dragonblight (WOLK)
	[118] = { 2257 }; --Icecrown (WOLK)
	[116] = { 2257 }; --Grizzly hills (WOLK)
}

private.ACHIEVEMENT_TARGET_IDS = {
	[1312] = { 18695, 18697, 18694, 18686, 18678, 18692, 18680, 18690, 18685, 18683, 18682, 18681, 18689, 18698, 17144, 18696, 18677, 20932, 18693, 18679 }; --Bloody Rare (Burning Crusade)
	[2257] = { 32517, 32495, 32358, 32377, 32398, 32409, 32422, 32438, 32471, 32481, 32630, 32487, 32501, 32357, 32361, 32386, 32400, 32417, 32429, 32447, 32475, 32485, 32500 }; --Frostbitten (Wrath of the Lich king)
}
