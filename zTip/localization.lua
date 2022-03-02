local addname,addon = ...
L = addon.loc

if GetLocale() == "zhCN" then
	L={
			["Rare"] 			= "稀有",
			["Targeting"]		= TARGET,
			["YOU"]				= ">> 你 <<",
			["Self"]			= "自己",
			["NotSpecified"]	= "未指定",
			["Specified"]		= "神秘物种",
			["TargetedBy"]		= "关注",
			["ResetCache"]		= "天赋缓存已清空",
			["ItemLevel"]		= "装等",
			["zTip Options"] = "zTip Options",
			["Positions"] = "锚点位置",
			["Offsets"] = "偏移值（按Enter键生效）",
			["Original Position Offsets"] = "原始位置偏移",
			["Target"] = TARGET,
			["Fade"] = "渐隐",
			["PVPName"] = "头衔",
			["Reputation"] = "声望",
			["RealmName"] = "服务器名",
			["IsPlayer"] = "标识(玩家)",
			["ClassIcon"] = "职业图标",
			["VividMask"] = "立体化",
			["ShowTalent"] = "天赋",
			["HealthBAR"] = "生命条",
			["ManaBAR"] = "法力条",
			["NPCClass"] = "NPC职业",
			["Scale"] = "缩放",
			["FollowCursor"] = "鼠标右下",
			["FollowCursorA"] = "鼠标右下/右下角",
			["RootOnTop"] = "屏幕上方",
			["OnCursorTop"] = "鼠标上方",
			["RightBottom"] = "右下角",
			["OffsetX"] = "水平",
			["OffsetY"] = "垂直",
			["OrigPosX"] = "水平",
			["OrigPosY"] = "垂直",
			["TalentIcon"] = "天赋图标",
			["CombatHide"] = "BOSS战斗中隐藏",
			["FactionName"] = "隐藏阵营标志",
			["ShowBarNum"] = "显示数值",
			["TTarget"] = "目标的目标",
			["BarTexture"] = "切换材质",
			["GuildInfo"] = "公会会阶",
			["ShowLegend"] = "橙装数量",
			["MiniNum"] = "切换数值",
			["MiniNumTooltip"] = "|cff00ffff会造成其他类似数值都被改变!|r",
			["ShowRc"] = "显示距离",
			["ShowRcTooltip"] = "如果开启了LibRangeCheck",
		}
elseif GetLocale() == "zhTW" then
	L={
		["Petlevel"] = "Pet level",
		["Rare"] = "Rare",
		["Targeting"] = TARGET,
		["YOU"] = ">> U <<",
		["Self"] = "Self",
		["NotSpecified"] = "Not specified",
		["TargetedBy"] = "TargetedBy",
		["ItemLevel"] = "Item Level",
		["zTip Options"] = "zTip Options",
		["Positions"] = "Positions",
		["Offsets"] = "Offsets(ENTER to apply)",
		["Original Position Offsets"] = "Original Position Offsets",
		["Target"] = "Target",
		["Fade"] = "Fade",
		["PVPName"] = "PVPName",
		["Reputation"] = "Reputation",
		["RealmName"] = "RealmName",
		["IsPlayer"] = "Mark(Player)",
		["ClassIcon"] = "ClassIcon",
		["VividMask"] = "VividMask",
		["ShowTalent"] = "ShowTalent",
		["ManaBAR"] = "Mana Bar",
		["NPCClass"] = "NPC Class",
		["Scale"] = "Scale",
		["FollowCursor"] = "FollowCursor",
		["RootOnTop"] = "RootOnTop",
		["OnCursorTop"] = "OnCursorTop",
		["RightBottom"] = "RightBottom",
		["OffsetX"] = "X",
		["OffsetY"] = "Y",
		["OrigPosX"] = "X",
		["OrigPosY"] = "Y",
		["ShowLegend"] = "Legend Num",
		["ShowRc"] = "Show Range",
		["ShowRcTooltip"] = "if has LibRangeCheck",
	}
else
	L={
		["Petlevel"] = "Pet level",
		["Rare"] = "Rare",
		["Targeting"] = TARGET,
		["YOU"] = ">> U <<",
		["Self"] = "Self",
		["NotSpecified"] = "Not specified",
		["TargetedBy"] = "TargetedBy",
		["ItemLevel"] = "Item Level",
		["zTip Options"] = "zTip Options",
		["Positions"] = "Positions",
		["Offsets"] = "Offsets(ENTER to apply)",
		["Original Position Offsets"] = "Original Position Offsets",
		["Target"] = "Target",
		["Fade"] = "Fade",
		["PVPName"] = "PVPName",
		["Reputation"] = "Reputation",
		["RealmName"] = "RealmName",
		["IsPlayer"] = "Mark(Player)",
		["ClassIcon"] = "ClassIcon",
		["VividMask"] = "VividMask",
		["ShowTalent"] = "ShowTalent",
		["ManaBAR"] = "Mana Bar",
		["NPCClass"] = "NPC Class",
		["Scale"] = "Scale",
		["FollowCursor"] = "FollowCursor",
		["RootOnTop"] = "RootOnTop",
		["OnCursorTop"] = "OnCursorTop",
		["RightBottom"] = "RightBottom",
		["OffsetX"] = "X",
		["OffsetY"] = "Y",
		["OrigPosX"] = "X",
		["OrigPosY"] = "Y",
		["ShowLegend"] = "Legend Num",
		["ShowRc"] = "Show Range",
		["ShowRcTooltip"] = "if has LibRangeCheck",
	}
end

if DUNGEON_SCORE then
	L["ShowDungeons"] = DUNGEON_SCORE
end

local Imp = {"ManaBAR","MiniNum","ShowBarNum"}
local id,value;
for id,value in pairs(Imp) do
	if (L[value]) then 
		L[value] = "|cffFF0000"..L[value].."|r"
		if not (L[value.."Tooltip"]) then
			L[value.."Tooltip"] = "|cffFF0000需要重载插件\r\n输入/reload|r";
		else
			L[value.."Tooltip"] = L[value.."Tooltip"].."\r\n".."|cffFF0000需要重载插件\r\n输入/reload|r";
		end
	end
end