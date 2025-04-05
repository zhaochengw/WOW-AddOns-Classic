
local __addon, __private = ...;
local GS = {};
__private.GS = GS;

local GS_ItemTypes = {
	["INVTYPE_RELIC"] = { ["SlotMOD"] = 0.3164, ["ItemSlot"] = 18 },
	["INVTYPE_TRINKET"] = { ["SlotMOD"] = 0.5625, ["ItemSlot"] = 33 },
	["INVTYPE_2HWEAPON"] = { ["SlotMOD"] = 2.000, ["ItemSlot"] = 16 },
	["INVTYPE_WEAPONMAINHAND"] = { ["SlotMOD"] = 1.0000, ["ItemSlot"] = 16 },
	["INVTYPE_WEAPONOFFHAND"] = { ["SlotMOD"] = 1.0000, ["ItemSlot"] = 17 },
	["INVTYPE_RANGED"] = { ["SlotMOD"] = 0.3164, ["ItemSlot"] = 18 },
	["INVTYPE_THROWN"] = { ["SlotMOD"] = 0.3164, ["ItemSlot"] = 18 },
	["INVTYPE_RANGEDRIGHT"] = { ["SlotMOD"] = 0.3164, ["ItemSlot"] = 18 },
	["INVTYPE_SHIELD"] = { ["SlotMOD"] = 1.0000, ["ItemSlot"] = 17 },
	["INVTYPE_WEAPON"] = { ["SlotMOD"] = 1.0000, ["ItemSlot"] = 36 },
	["INVTYPE_HOLDABLE"] = { ["SlotMOD"] = 1.0000, ["ItemSlot"] = 17 },
	["INVTYPE_HEAD"] = { ["SlotMOD"] = 1.0000, ["ItemSlot"] = 1 },
	["INVTYPE_NECK"] = { ["SlotMOD"] = 0.5625, ["ItemSlot"] = 2 },
	["INVTYPE_SHOULDER"] = { ["SlotMOD"] = 0.7500, ["ItemSlot"] = 3 },
	["INVTYPE_CHEST"] = { ["SlotMOD"] = 1.0000, ["ItemSlot"] = 5 },
	["INVTYPE_ROBE"] = { ["SlotMOD"] = 1.0000, ["ItemSlot"] = 5 },
	["INVTYPE_WAIST"] = { ["SlotMOD"] = 0.7500, ["ItemSlot"] = 6 },
	["INVTYPE_LEGS"] = { ["SlotMOD"] = 1.0000, ["ItemSlot"] = 7 },
	["INVTYPE_FEET"] = { ["SlotMOD"] = 0.75, ["ItemSlot"] = 8 },
	["INVTYPE_WRIST"] = { ["SlotMOD"] = 0.5625, ["ItemSlot"] = 9 },
	["INVTYPE_HAND"] = { ["SlotMOD"] = 0.7500, ["ItemSlot"] = 10 },
	["INVTYPE_FINGER"] = { ["SlotMOD"] = 0.5625, ["ItemSlot"] = 31 },
	["INVTYPE_CLOAK"] = { ["SlotMOD"] = 0.5625, ["ItemSlot"] = 15 },
}




local GS_DefaultSettings = {
	["Player"] = 1,
	["Item"] = 1,
	["Show"] = 1,
	["Special"] = 1,
	["Compare"] = -1,
	["Level"] = -1,
	["Average"] = -1,
}


local GS_Special = {
	["A"] = "Author of GearScore",
	["B"] = "Official Sponsor of GearScore",
	["C"] = "Official GearScore Guild",
 	["Pauladin"] = { ["Realm"] = "Elune", ["Type"] = "B" },
 	
 	["Wolfric"] = { ["Realm"] = "Khaz'Goroth", ["Type"] = "B" },
 	["Coastar"] = { ["Realm"] = "Khaz'Goroth", ["Type"] = "B" },
 	["Alekzander"] = { ["Realm"] = "Agamaggan", ["Type"] = "B" },
 	["Decks"] = { ["Realm"] = "Detheroc", ["Type"] = "B" },
 	["Pauladin"] = { ["Realm"] = "Elune", ["Type"] = "B" },
 	["Dram"] = { ["Realm"] = "Duskwood", ["Type"] = "B" },
 	["Moophasa"] = { ["Realm"] = "Silver Hand", ["Type"] = "B" },
 	["Spirts"] = { ["Realm"] = "Khaz'Goroth", ["Type"] = "B" },
 	["Wizzardly"] = { ["Realm"] = "Khaz'Goroth", ["Type"] = "B" },
 	["Cloroangel"] = { ["Realm"] = "Khaz'Goroth", ["Type"] = "B" },
 	["Aeonel"] = { ["Realm"] = "Proudmoore", ["Type"] = "B" },
	["Lollygimon"] = { ["Realm"] = "Caelestrasz", ["Type"] = "B" },  		
	["Midshipman"] = { ["Realm"] = "Fenris", ["Type"] = "B" },  		
	["Saruk"] = { ["Realm"] = "Mal'Ganis", ["Type"] = "B" },  		
	["Volstormbrew"] = { ["Realm"] = "Detheroc", ["Type"] = "B" },  		
	["Shinnobe"] = { ["Realm"] = "Stormreaver", ["Type"] = "B" },  		
	["Spontaneous"] = { ["Realm"] = "Stormreaver", ["Type"] = "B" },  		
	["Nias"] = { ["Realm"] = "Stormreaver", ["Type"] = "B" },  		
	["Yaks"] = { ["Realm"] = "Balnazzar", ["Type"] = "B" },  		
	["Andresh"] = { ["Realm"] = "Uldaman", ["Type"] = "B" },  		
	["Atelyn"] = { ["Realm"] = "Thunderhorn", ["Type"] = "B" },  		
	["Jubali"] = { ["Realm"] = "Frostmourne", ["Type"] = "B" },  		
 	
	["Arxkanite"] = { ["Realm"] = "Detheroc", ["Type"] = "A" },
	["Josephsmith"] = { ["Realm"] = "Detheroc", ["Type"] = "B" },
	["Choku"] = { ["Realm"] = "Magtheridon", ["Type"] = "B" },
	["Murmilude"] = { ["Realm"] = "Blade's Edge", ["Type"] = "B" },
	["Rangitor"] = { ["Realm"] = "Khaz'Goroth", ["Type"] = "B" },
	["Keightie"] = { ["Realm"] = "Detheroc", ["Type"] = "B" },
    	--["Kymax"] = { ["Realm"] = "Detheroc", ["Type"] = "A" },
    	["Zanier"] = { ["Realm"] = "Cairne", ["Type"] = "B" },    
    	--["Cuppycakes"] = { ["Realm"] = "Detheroc", ["Type"] = "A" },
    	["Sausagefest"] = { ["Realm"] = "Detheroc", ["Type"] = "B" },
    	["Rogue Angels"] = { ["Realm"] = "Detheroc", ["Type"] = "C" },
}

local GS_Rarity = {
	[0] = { Red = 0.55,	Green = 0.55, Blue = 0.55 },
	[1] = {	Red = 1.00,	Green = 1.00, Blue = 1.00 },
	[2] = {	Red = 0.12,	Green = 1.00, Blue = 0.00 },
	[3] = {	Red = 0.00,	Green = 0.50, Blue = 1.00 },
	[4] = {	Red = 0.69, Green = 0.28, Blue = 0.97 },
	[5] = { Red = 0.94,	Green = 0.09, Blue = 0.00 },
	[6] = {	Red = 1.00,	Green = 0.00, Blue = 0.00 },
	[7] = {	Red = 0.90,	Green = 0.80, Blue = 0.50 },
}

local GS_Formula = {
	["A"] = {	
		[4] = { ["A"] = 26.0000, ["B"] = 1.2000 },
		[3] = { ["A"] = 0.7500, ["B"] = 1.8000 },
		[2] = { ["A"] = 8.0000, ["B"] = 2.0000 },
		[1] = { ["A"] = 0.0000, ["B"] = 2.2500 }
	},
	["B"] = {		
		[4] = { ["A"] = 91.4500, ["B"] = 0.6500 },
		[3] = { ["A"] = 81.3750, ["B"] = 0.8125 },
		[2] = { ["A"] = 73.0000, ["B"] = 1.0000 }
	},	
	["C"]  = {		
		[4] = { ["A"] = 91.4500, ["B"] = 0.6500},
		[3] = { ["A"] = 91.4500, ["B"] = 0.6500},
		[2] = { ["A"] = 91.4500, ["B"] = 0.6500 },
	},
}

local GS_Quality = {
	[7000] = { 
		["Red"] = { ["A"] = 0.99, ["B"] = 6000, ["C"] = 0.00000, ["D"] = 1 }, 
		["Green"] = { ["A"] = 0.01, ["B"] = 6000, ["C"] = 0.00001, ["D"] = -1 }, 
		["Blue"] = { ["A"] = 0, ["B"] = 0, ["C"] = 0, ["D"] = 0 }, 
		["Description"] = "Legendary" 
	}, 
	[6000] = {
		["Red"] = { ["A"] = 0.94, ["B"] = 5000, ["C"] = 0.00006, ["D"] = 1 },
		["Green"] = { ["A"] = 0.47, ["B"] = 5000, ["C"] = 0.00047, ["D"] = -1 },
		["Blue"] = { ["A"] = 0, ["B"] = 0, ["C"] = 0, ["D"] = 0 },
		["Description"] = "Legendary"
	},
	[5000] = {
		["Red"] = { ["A"] = 0.69, ["B"] = 4000, ["C"] = 0.00025, ["D"] = 1 },
		["Green"] = { ["A"] = 0.28, ["B"] = 4000, ["C"] = 0.00019, ["D"] = 1 },
		["Blue"] = { ["A"] = 0.97, ["B"] = 4000, ["C"] = 0.00096, ["D"] = -1 },
		["Description"] = "Epic"
	},
	[4000] = {
		["Red"] = { ["A"] = 0.0, ["B"] = 3000, ["C"] = 0.00069, ["D"] = 1 },
		["Green"] = { ["A"] = 0.5, ["B"] = 3000, ["C"] = 0.00022, ["D"] = -1 },
		["Blue"] = { ["A"] = 1, ["B"] = 3000, ["C"] = 0.00003, ["D"] = -1 },
		["Description"] = "Superior"
	},
	[3000] = {
		["Red"] = { ["A"] = 0.12, ["B"] = 2000, ["C"] = 0.00012, ["D"] = -1 },
		["Green"] = { ["A"] = 1, ["B"] = 2000, ["C"] = 0.00050, ["D"] = -1 },
		["Blue"] = { ["A"] = 0, ["B"] = 2000, ["C"] = 0.001, ["D"] = 1 },
		["Description"] = "Uncommon"
	},
	[2000] = {
		["Red"] = { ["A"] = 1, ["B"] = 1000, ["C"] = 0.00088, ["D"] = -1 },
		["Green"] = { ["A"] = 1, ["B"] = 000, ["C"] = 0.00000, ["D"] = 0 },
		["Blue"] = { ["A"] = 1, ["B"] = 1000, ["C"] = 0.001, ["D"] = -1 },
		["Description"] = "Common"
	},
	[1000] = {
		["Red"] = { ["A"] = 0.55, ["B"] = 0, ["C"] = 0.00045, ["D"] = 1 },
		["Green"] = { ["A"] = 0.55, ["B"] = 0, ["C"] = 0.00045, ["D"] = 1 },
		["Blue"] = { ["A"] = 0.55, ["B"] = 0, ["C"] = 0.00045, ["D"] = 1 },
		["Description"] = "Trash"
	},
}


---------------------------------------------------------------

-------------------------- 判断装备是否附魔 -------------------------------------
function GearScore_IsItemEnchant(itemLink)
	if (not itemLink or type(itemLink) ~= "string") then
		return false;
	end
	
	local enchantID = itemLink:match("item:%d+:(%d+):");
	if (tonumber(enchantID) == 0) then
		return false;
	else
		return true;
	end
end

-------------------------------- Get Quality ----------------------------------

function GearScore_GetQuality(ItemScore)
	if ( ItemScore == 0 ) then return .1, .1, .1;end;
	local color = {};
	local index = 0;
	local ColorArray = {
		[0] = { .55, .55, .55  },
		[1] = { .55, .55, .55 },
		[2] = { 1, 1, 1 },
		[3] = { .12, 1, 0 },
		[4] = { 0, .5, 1 },
		[5] = { .69, .28, .97 },
		[6] = { .94, .47, 0 },
		[7] = { 1, 0, 0 },
		[8] = { 1, 0, 0 },
	};
	ItemScore = floor( ItemScore / 2);
	if ( ItemScore >= 6000 ) then ItemScore = 5999; end;
	local a = floor(ItemScore / 1e3) + 1;
	local b = a + 1;
	local c = mod(ItemScore, 1e3);
	for i = 1,3 do
		local d = ( ColorArray[b][i] - ColorArray[a][i]) / 1e3;
		color[i] = ColorArray[a][i] + (d * c);
	end;
	return unpack(color);
end
-------------------------------------------------------------------------------


function GearScore_GetItemScore(ItemLink)
	GearScore_ScoreBuff = GearScore_ScoreBuff or {}
	if GearScore_ScoreBuff[ItemLink] then return unpack(GearScore_ScoreBuff[ItemLink]) end
	local QualityScale = 1; local PVPScale = 1; local PVPScore = 0; local GearScore = 0
	if not ( ItemLink ) then
		return 0, 0; 
	end
	local AltItemScore = 0;
	local ItemName, link, ItemRarity, ItemLevel, ItemMinLevel, ItemType, ItemSubType, ItemStackCount, ItemEquipLoc, ItemTexture = GetItemInfo(ItemLink);
	local Table = {};
	--local Scale = 1.8618
	local Scale = 1.8291
 	if ( ItemRarity == 5 ) then 
		QualityScale = 1.3; 
		ItemRarity = 4;
	elseif ( ItemRarity == 1 ) then 
		QualityScale = 0.005; 
		ItemRarity = 2
	elseif ( ItemRarity == 0 ) then 
		QualityScale = 0.005; 
		ItemRarity = 2
	end

	if ( ItemRarity == 7 ) then 
		ItemRarity = 3; 
		ItemLevel = 187.05; 
	end

	if ( GS_ItemTypes[ItemEquipLoc] ) then
		if ( ItemLevel > 277 ) then
			Table = GS_Formula["C"]
		elseif ( ItemLevel > 120 ) then 
			Table = GS_Formula["B"]; 
		else 
			Table = GS_Formula["A"]; 
		end
		if ( ItemRarity >= 2 ) and ( ItemRarity <= 4 )then
			local Red, Green, Blue = GearScore_GetQuality((floor(((ItemLevel - Table[ItemRarity].A) / Table[ItemRarity].B) * 1 * Scale)) * 11.25 )
			GearScore = floor(((ItemLevel - Table[ItemRarity].A) / Table[ItemRarity].B) * GS_ItemTypes[ItemEquipLoc].SlotMOD * Scale * QualityScale)
			if ( ItemLevel == 187.05 ) then 
				ItemLevel = 0; 
			end
			if ( GearScore < 0 ) then 
				GearScore = 0;  
				Red, Green, Blue = GearScore_GetQuality(1); 
			end
			if ( PVPScale == 0.75 ) then 
				PVPScore = 1; 
				GearScore = GearScore * 1; 
			else
				PVPScore = GearScore * 0; 
			end
			GearScore = floor(GearScore);
			PVPScore = floor(PVPScore);			
			
			if (GearScore_IsItemEnchant(ItemLink)) then
				AltItemScore = GearScore * 0.03;
			end
	
			AltItemScore = floor(AltItemScore);
			GearScore = GearScore + AltItemScore; -- 修正GS

			GearScore_ScoreBuff[ItemLink] = {GearScore, AltItemScore, GS_ItemTypes[ItemEquipLoc].ItemSlot, Red, Green, Blue, PVPScore, ItemEquipLoc}
			return GearScore, AltItemScore, GS_ItemTypes[ItemEquipLoc].ItemSlot, Red, Green, Blue, PVPScore, ItemEquipLoc;
		end
  	end
	GearScore_ScoreBuff[ItemLink] = {-1, AltItemScore, 50, 1, 1, 1, PVPScore, ItemEquipLoc}
	return -1, AltItemScore, 50, 1, 1, 1, PVPScore, ItemEquipLoc
end


GS.GearScore_GetItemScore = function (ItemLink)
	return GearScore_GetItemScore(ItemLink)
end