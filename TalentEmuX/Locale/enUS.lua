--[[--
	alex@0
--]]--
----------------------------------------------------------------------------------------------------
local __addon, __private = ...;
local MT = __private.MT;
local CT = __private.CT;
local VT = __private.VT;
local DT = __private.DT;
local l10n = CT.l10n;

if l10n.Locale ~= nil and l10n.Locale ~= "" then return;end

BINDING_CATEGORY_ALATALENTEMU = "<|cff00ff00TalentEmu|r>";
BINDING_NAME_ALARAIDTOOL_NEWWINDOW = "Create an emulator";
BINDING_NAME_ALARAIDTOOL_QUERY = "Inspect target";

l10n.Locale = "enUS";


l10n.TALENT = TALENT or "Talent";
l10n.OKAY = OKAY or "OK";
l10n.CANCEL = CANCEL or "CANCEL";
l10n.TooltipLines = {
	"|cff00ff00LeftClick|r Create an emulator",
	"RightClick|r Explorer group member",
};

--	Center
l10n.Import = "IMPORT";
l10n.Emulator = "Emu";
l10n.message = "*CHAT";
l10n.LabelPointsChanged = "(|cffff0000Modified|r)";
l10n.ResetToSetButton = "Reset";
l10n.CloseButton = "Close";
l10n.CurRank = "Current Rank";
l10n.NextRank = "Next Rank";
l10n.MaxRank = "Top Rank";
l10n.ReqPoints = "%d/%d in %s";
l10n.ResetButton = "Reset this tree";
l10n.ResetAllButton = "Reset";
l10n.PointsUsed = "Used";
l10n.PointsRemaining = "Idle";
l10n.PointsToLevel = "Lv";
l10n.ExpandButton = "Expand";

--	Left
l10n.EquipmentListButton = "Equipment list";
l10n.EquipmentList_AverageItemLevel = "AverageItemLevel: ";
l10n.EquipmentList_MissingEnchant = "|cffff0000Miss enchant|r";
l10n.EquipmentList_Gem = {
	Red = "|cffff0000R|r",
	Blue = "|cff007fffB|r",
	Yellow = "|cfffcff00Y|r",
	Purple = "|cffff00ffP|r",
	Green = "|cff00ff00G|r",
	Orange = "|cffff7f00O|r",
	Meta = "|cffffffffM|r",
	Prismatic = "|cffffffffP|r",
};
l10n.EquipmentList_MissGem = {
	["?"] = "|cff7f7f7f?|r",
	Red = "|cff7f7f7fR|r",
	Blue = "|cff7f7f7fB|r",
	Yellow = "|cff7f7f7fY|r",
	Purple = "|cff7f7f7fP|r",
	Green = "|cff7f7f7fG|r",
	Orange = "|cff7f7f7fO|r",
	Meta = "|cff7f7f7fM|r",
	Prismatic = "|cff7f7f7fP|r",
};
l10n.MAJOR_GLYPH = MAJOR_GLYPH;
l10n.MINOR_GLYPH = MINOR_GLYPH;
l10n.PRIME_GLYPH = PRIME_GLYPH;

--	Right
l10n.ClassButton = "\n|cff00ff00LeftClick|r Toggle class\n|cff00ff00RightClick|r Load saved talents\n|cff00ff00Shift and LeftClick in Menu|r Delete saved talent";
l10n.SendButton = "|cff00ff00LeftClick|r Send talents\n|cff00ff00RightClick|r Browse talents in chat";
l10n.SaveButton = "|cff00ff00LeftClick|r Save talents\n|cff00ff00RightClick|r Load saved talents\n|cff00ff00ALT+RightClick|r Load another character's talent\n|cff00ff00Shift and LeftClick in Menu|r Del";
l10n.ExportButton = "|cff00ff00LeftClick|r Export code\n|cff00ff00RightClick|r Export to |cffff0000wowhead/nfu|r url";
l10n.ExportButton_AllData = "ExportButton_AllData";
l10n.ImportButton = "Import from code or wowhead/nfu/yxrank url";
l10n.SettingButton = "Settings";
l10n.ApplyTalentsButton = "Apply talents";
l10n.ApplyTalentsButton_Notify = "Apply these talents?";
l10n.ApplyTalentsButton_Finished = "Talents applied";
l10n["CANNOT APPLY : ERROR CATA."] = "CANNOT APPLY : WRONG TALENTS (CATA).";
l10n["CANNOT APPLY : NEED MORE TALENT POINTS."] = "CANNOT APPLY : NEED MORE TALENT POINTS.";
l10n["CANNOT APPLY : TALENTS IN CONFLICT."] = "CANNOT APPLY : TALENTS IN CONFLICT.";
l10n["CANNOT APPLY : UNABLE TO GENERATE TALENT MAP."] = "CANNOT APPLY : UNABLE TO GENERATE TALENT MAP.";
l10n["CANNOT APPLY : TALENT MAP ERROR."] = "CANNOT APPLY : TALENT MAP ERROR.";
l10n["TalentDB Error : DB SIZE IS NOT EQUAL TO TalentFrame SIZE."] = "TalentDB Error : DB SIZE IS NOT EQUAL TO TalentFrame SIZE.";
l10n.SpellListButton = "Spell List";

--	Setting
l10n.Setting_AutoShowEquipmentFrame = "Show Equipments Automatically";
l10n.Setting_IconOnMinimap = "Show DBIcon";
l10n.Setting_ResizableBorder = "Resizing by Dragging";
l10n.Setting_SingleFrame = "Single Window";
l10n.Setting_TripleTrees = "Triple talent trees";
l10n.Setting_SingleTree = "Single talent tree";
l10n.Setting_TalentsInTip = "Talents in tip";
l10n.Setting_TalentsInTipIcon = "Texture talents in tip";
l10n.Setting_ItemLevelInTip = "Average Item Level in Tip";

--	Spell List
l10n.SpellList_Search = "Search";
l10n.SpellList_SearchOKay = "OK";
l10n.SpellList_GTTSpellLevel = "Spell level: ";
l10n.SpellList_GTTReqLevel = "Level: ";
l10n.SpellList_GTTAvailable = "|cff00ff00Available|r";
l10n.SpellList_GTTUnavailable = "|cffff0000Not Available|r";
l10n.SpellList_GTTTrainCost = "Train Cost ";
l10n.SpellList_Hide = "Hide";
l10n.SpellList_ShowAllSpell = "All ranks";

--	Raid Tool
l10n.RaidTool_LableItemLevel = "ItemLv";
l10n.RaidTool_LableItemSummary = "Items";
l10n.RaidTool_LableEnchantSummary = "Encs";
l10n.RaidTool_LableGemSummary = "Gems";
l10n.RaidTool_LableBossModInfo = "Version of DBM";
l10n.RaidTool_EmptySlot = "|cffff0000Empty|r";
l10n.RaidTool_MissingEnchant = "|cffff0000Miss enchant|r";
l10n.GuildList = "Guild Roster List";

--	Data
l10n.CLASS = {
	DEATHKNIGHT = "deathknight",
	DRUID = "druid",
	HUNTER = "hunter",
	MAGE = "mage",
	PALADIN = "paladin",
	PRIEST = "priest",
	ROGUE = "rogue",
	SHAMAN = "shaman",
	WARLOCK = "warlock",
	WARRIOR = "warrior",
};
l10n.SPEC = {
	[398] = "Blood",
	[399] = "Frost",
	[400] = "Unholy",
	[283] = "Balance",
	[281] = "Feral",
	[282] = "Restoration",
	[361] = "BeastMastery",
	[363] = "Marksmanship",
	[362] = "Survival",
	[81] = "Arcane",
	[41] = "Fire",
	[61] = "Frost",
	[382] = "Holy",
	[383] = "Protection",
	[381] = "Retribution",
	[201] = "Discipline",
	[202] = "Holy",
	[203] = "Shadow",
	[182] = "Assassination",
	[181] = "Combat",
	[183] = "Subtlety",
	[261] = "Elemental",
	[263] = "Enhancement",
	[262] = "Restoration",
	[302] = "Affliction",
	[303] = "Demonology",
	[301] = "Destruction",
	[161] = "Arms",
	[164] = "Fury",
	[163] = "Protection",

	-- [398] = "Blood",
	-- [399] = "Frost",
	-- [400] = "Unholy",
	[752] = "Balance",
	[750] = "Feral",
	[748] = "Restoration",
	[811] = "BeastMastery",
	[807] = "Marksmanship",
	[809] = "Survival",
	[799] = "Arcane",
	[851] = "Fire",
	[823] = "Frost",
	[831] = "Holy",
	[839] = "Protection",
	[855] = "Retribution",
	[760] = "Discipline",
	[813] = "Holy",
	[795] = "Shadow",
	-- [182] = "Assassination",
	-- [181] = "Combat",
	-- [183] = "Subtlety",
	-- [261] = "Elemental",
	-- [263] = "Enhancement",
	-- [262] = "Restoration",
	[871] = "Affliction",
	[867] = "Demonology",
	[865] = "Destruction",
	[746] = "Arms",
	[815] = "Fury",
	[845] = "Protection",
};
l10n.SCENE = {
	H = "|cff00ff00Healer|r",
	D = "|cffff0000DPS|r",
	T = "|cffafafffTANK|r",
	P = "|cffff0000PVP|r",
	E = "|cffffff00PVE|r",
};
l10n.RACE = {
	RACE = "RACE",
	["HUMAN|DWARF|NIGHTELF|GNOME|DRAENEI"] = "Alliance",
	["ORC|SCOURGE|TAUREN|TROLL|BLOODELF"] = "Horde",
	["HUMAN"] = "Human",
	["DWARF"] = "Dwarf",
	["NIGHTELF"] = "NightElf",
	["GNOME"] = "Gnome",
	["DRAENEI"] = "Draenei",
	["ORC"] = "Orc",
	["SCOURGE"] = "Scourge",
	["TAUREN"] = "Tauren",
	["TROLL"] = "Troll",
	["BLOODELF"] = "BloodElf",
};
l10n.SLOT = {
	[0] = "Ammo",
	[1] = "Head",
	[2] = "Neck",
	[3] = "Shoulder",
	[4] = "Skirt",
	[5] = "Chest",
	[6] = "Waist",
	[7] = "Leg",
	[8] = "Feet",
	[9] = "Wrist",
	[10] = "Glove",
	[11] = "Finger",
	[12] = "Finger",
	[13] = "Trinet",
	[14] = "Trinet",
	[15] = "Cloak",
	[16] = "MainHand",
	[17] = "OffHand",
	[18] = "Ranged",
	[19] = "Tabard",
};
l10n.SLOTSHORT = {
	[0] = "Ammo",
	[1] = "Head",
	[2] = "Neck",
	[3] = "Shoulder",
	[4] = "Skirt",
	[5] = "Chest",
	[6] = "Waist",
	[7] = "Leg",
	[8] = "Feet",
	[9] = "Wrist",
	[10] = "Glove",
	[11] = "Finger",
	[12] = "Finger",
	[13] = "Trinet",
	[14] = "Trinet",
	[15] = "Cloak",
	[16] = "Main",
	[17] = "Off",
	[18] = "Ranged",
	[19] = "Tabard",
};

--	Others
l10n.Tooltip_CalaculatingItemLevel = "|cffffffffItemLevel|r|cff9f9f9f:|r |cff9f9f9fInspecting...|r";
l10n.Tooltip_ItemLevel = "|cffffffffItemLevel|r|cff9f9f9f:|r |cffffffff%s|r";


l10n.PopupQuery = "|cffff7f00Inspect|r";


l10n.TalentFrameCallButton = "Open TalentEmu";
l10n.TalentFrameCallButtonString = "Emu";


--	emulib
l10n["WOW VERSION"] = "The talents does not fit che client";
l10n["NO DECODER"] = "Unable to decode talent data";
