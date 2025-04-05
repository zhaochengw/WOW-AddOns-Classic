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

if GetLocale() ~= "zhCN" then return;end

BINDING_CATEGORY_ALATALENTEMU = "<|cff00ff00TalentEmu|r>天赋模拟器";
BINDING_NAME_ALARAIDTOOL_NEWWINDOW = "新建模拟器";
BINDING_NAME_ALARAIDTOOL_QUERY = "查看目标天赋";

l10n.Locale = "zhCN";


l10n.TALENT = TALENT or "天赋";
l10n.OKAY = OKAY or "确定";
l10n.CANCEL = CANCEL or "取消";
l10n.TooltipLines = {
	"|cff00ff00左键|r|cffffffff新建模拟器|r",
	"|cff00ff00右键|r|cffffffff打开成员检查|r",
};

--	中间
l10n.Import = "导入";
l10n.Emulator = "模拟器";
l10n.message = "*聊天信息";
l10n.LabelPointsChanged = "(|cffff0000修改|r)";
l10n.ResetToSetButton = "重置到初始状态";
l10n.CloseButton = "关闭窗口";
l10n.CurRank = "当前等级";
l10n.NextRank = "下一等级";
l10n.MaxRank = "最高等级";
l10n.ReqPoints = "%d/%d点%s";
l10n.ResetButton = "重置本栏天赋";
l10n.ResetAllButton = "重置所有天赋";
l10n.PointsUsed = "已用";
l10n.PointsRemaining = "剩余";
l10n.PointsToLevel = "等级";
l10n.ExpandButton = "扩展";

--	左
l10n.EquipmentListButton = "装备列表";
l10n.EquipmentList_AverageItemLevel = "装等 ";
l10n.EquipmentList_MissingEnchant = "|cffff0000缺少附魔|r";
l10n.EquipmentList_Gem = {
	Red = "|cffff0000红|r",
	Blue = "|cff007fff蓝|r",
	Yellow = "|cffffcf00黄|r",
	Purple = "|cffff00ff紫|r",
	Green = "|cff00ff00绿|r",
	Orange = "|cffff7f00橙|r",
	Meta = "|cffffffff彩|r",
	Prismatic = "|cffffffff棱|r",
};
l10n.EquipmentList_MissGem = {
	["?"] = "|cff7f7f7f？|r",
	Red = "|cff7f7f7f红|r",
	Blue = "|cff7f7f7f蓝|r",
	Yellow = "|cff7f7f7f黄|r",
	Purple = "|cff7f7f7f紫|r",
	Green = "|cff7f7f7f绿|r",
	Orange = "|cff7f7f7f橙|r",
	Meta = "|cff7f7f7f彩|r",
	Prismatic = "|cff7f7f7f棱|r",
};
l10n.MAJOR_GLYPH = MAJOR_GLYPH;
l10n.MINOR_GLYPH = MINOR_GLYPH;
l10n.PRIME_GLYPH = PRIME_GLYPH;

--	右
l10n.ClassButton = "\n|cff00ff00左键|r切换职业\n|cff00ff00右键|r加载已保存的天赋\n|cff00ff00子菜单中Shift+左键|r删除保存的天赋";
l10n.SendButton = "|cff00ff00左键|r发送天赋到聊天\n|cff00ff00右键|r查看最近聊天中的天赋";
l10n.SaveButton = "|cff00ff00左键|r保存天赋设置\n|cff00ff00右键|r加载已保存的天赋\n|cff00ff00ALT+右键|r加载其他角色天赋雕文装备\n|cff00ff00子菜单中Shift+左键|r删除天赋";
l10n.ExportButton = "|cff00ff00左键|r导出字符串\n|cff00ff00右键|r导出到|cffff0000wowhead/nfu|r网页链接";
l10n.ExportButton_AllData = "天赋+雕文+装备";
l10n.ImportButton = "导入字符串或wowhead/nfu/yxrank链接";
l10n.SettingButton = "设置";
l10n.ApplyTalentsButton = "应用当前天赋";
l10n.ApplyTalentsButton_Notify = "确定应用当前天赋？";
l10n.ApplyTalentsButton_Finished = "天赋已应用";
l10n["CANNOT APPLY : ERROR CATA."] = "无法应用天赋: 天赋数据错误（大灾变）";
l10n["CANNOT APPLY : NEED MORE TALENT POINTS."] = "无法应用天赋: 需要更多天赋点数";
l10n["CANNOT APPLY : TALENTS IN CONFLICT."] = "无法应用天赋: 与当前天赋冲突";
l10n["CANNOT APPLY : UNABLE TO GENERATE TALENT MAP."] = "无法应用天赋: 创建天赋映射表发生错误";
l10n["CANNOT APPLY : TALENT MAP ERROR."] = "无法应用天赋: 读取天赋映射表发生错误";
l10n["TalentDB Error : DB SIZE IS NOT EQUAL TO TalentFrame SIZE."] = "数据错误: 与天赋面板的天赋数量不一样";
l10n.SpellListButton = "技能列表";

--	设置
l10n.Setting_AutoShowEquipmentFrame = "自动显示装备列表";
l10n.Setting_IconOnMinimap = "显示小地图图标";
l10n.Setting_ResizableBorder = "允许调整大小";
l10n.Setting_SingleFrame = "单窗口显示";
l10n.Setting_TripleTrees = "三列天赋";
l10n.Setting_SingleTree = "单列天赋";
l10n.Setting_TalentsInTip = "鼠标提示显示天赋";
l10n.Setting_TalentsInTipIcon = "鼠标提示图标天赋";
l10n.Setting_ItemLevelInTip = "鼠标提示显示装等";

--	技能列表
l10n.SpellList_Search = "搜索";
l10n.SpellList_SearchOKay = "确定";
l10n.SpellList_GTTSpellLevel = "技能等级: ";
l10n.SpellList_GTTReqLevel = "需要等级: ";
l10n.SpellList_GTTAvailable = "|cff00ff00技能可用|r";
l10n.SpellList_GTTUnavailable = "|cffff0000技能不可用|r";
l10n.SpellList_GTTTrainCost = "训练费用 ";
l10n.SpellList_Hide = "隐藏";
l10n.SpellList_ShowAllSpell = "显示所有等级";

--	Raid Tool
l10n.RaidTool_LableItemLevel = "装等";
l10n.RaidTool_LableItemSummary = "装备";
l10n.RaidTool_LableEnchantSummary = "附魔";
l10n.RaidTool_LableGemSummary = "宝石";
l10n.RaidTool_LableBossModInfo = "DBM版本";
l10n.RaidTool_EmptySlot = "|cffff0000未装备|r";
l10n.RaidTool_MissingEnchant = "|cffff0000缺少附魔|r";
l10n.GuildList = "公会列表";

--	Data
l10n.CLASS = {
	DEATHKNIGHT = "死亡骑士",
	DRUID = "德鲁伊",
	HUNTER = "猎人",
	MAGE = "法师",
	PALADIN = "圣骑士",
	PRIEST = "牧师",
	ROGUE = "盗贼",
	SHAMAN = "萨满",
	WARLOCK = "术士",
	WARRIOR = "战士",
};
l10n.SPEC = {
	[398] = "鲜血",
	[399] = "冰霜",
	[400] = "邪恶",
	[283] = "平衡",
	[281] = "野性战斗",
	[282] = "恢复",
	[361] = "野兽控制",
	[363] = "射击",
	[362] = "生存",
	[81] = "奥术",
	[41] = "火焰",
	[61] = "冰霜",
	[382] = "神圣",
	[383] = "防护",
	[381] = "惩戒",
	[201] = "戒律",
	[202] = "神圣",
	[203] = "暗影",
	[182] = "刺杀",
	[181] = "战斗",
	[183] = "敏锐",
	[261] = "元素",
	[263] = "增强",
	[262] = "恢复",
	[302] = "痛苦",
	[303] = "恶魔学识",
	[301] = "毁灭",
	[161] = "武器",
	[164] = "狂怒",
	[163] = "防护",

	-- [398] = "鲜血",
	-- [399] = "冰霜",
	-- [400] = "邪恶",
	[752] = "平衡",
	[750] = "野性战斗",
	[748] = "恢复",
	[811] = "野兽控制",
	[807] = "射击",
	[809] = "生存",
	[799] = "奥术",
	[851] = "火焰",
	[823] = "冰霜",
	[831] = "神圣",
	[839] = "防护",
	[855] = "惩戒",
	[760] = "戒律",
	[813] = "神圣",
	[795] = "暗影",
	-- [182] = "刺杀",
	-- [181] = "战斗",
	-- [183] = "敏锐",
	-- [261] = "元素",
	-- [263] = "增强",
	-- [262] = "恢复",
	[871] = "痛苦",
	[867] = "恶魔学识",
	[865] = "毁灭",
	[746] = "武器",
	[815] = "狂怒",
	[845] = "防护",
};
l10n.SCENE = {
	H = "|cff00ff00治疗|r",
	D = "|cffff0000输出|r",
	T = "|cffafafff坦克|r",
	P = "|cffff0000PVP|r",
	E = "|cffffff00PVE|r",
};
l10n.RACE = {
	RACE = "种族",
	["HUMAN|DWARF|NIGHTELF|GNOME|DRAENEI"] = "联盟",
	["ORC|SCOURGE|TAUREN|TROLL|BLOODELF"] = "部落",
	["HUMAN"] = "人类",
	["DWARF"] = "矮人",
	["NIGHTELF"] = "暗夜精灵",
	["GNOME"] = "侏儒",
	["DRAENEI"] = "德莱尼",
	["ORC"] = "兽族",
	["SCOURGE"] = "亡灵",
	["TAUREN"] = "牛头人",
	["TROLL"] = "巨魔",
	["BLOODELF"] = "血精灵",
};
l10n.SLOT = {
	[0] = "子弹",
	[1] = "头部",
	[2] = "颈部",
	[3] = "肩部",
	[4] = "衬衣",
	[5] = "胸甲",
	[6] = "腰带",
	[7] = "腿部",
	[8] = "靴子",
	[9] = "护腕",
	[10] = "手套",
	[11] = "戒指",
	[12] = "戒指",
	[13] = "饰品",
	[14] = "饰品",
	[15] = "披风",
	[16] = "主手",
	[17] = "副手",
	[18] = "远程",
	[19] = "战袍",
};
l10n.SLOTSHORT = {
	[0] = "弹",
	[1] = "头",
	[2] = "颈",
	[3] = "肩",
	[4] = "衬",
	[5] = "胸",
	[6] = "腰",
	[7] = "腿",
	[8] = "脚",
	[9] = "腕",
	[10] = "手",
	[11] = "戒",
	[12] = "戒",
	[13] = "饰",
	[14] = "饰",
	[15] = "披",
	[16] = "主",
	[17] = "副",
	[18] = "远",
	[19] = "袍",
};

--	其它
l10n.Tooltip_CalaculatingItemLevel = "|cffffffff装等|r|cff9f9f9f:|r |cff9f9f9f正在读取...|r";
l10n.Tooltip_ItemLevel = "|cffffffff装等|r|cff9f9f9f:|r |cffffffff%s|r";


l10n.PopupQuery = "|cffff7f00查询天赋|r";


l10n.TalentFrameCallButton = "打开天赋模拟器";
l10n.TalentFrameCallButtonString = "模拟器";


--	emulib
l10n["WOW VERSION"] = "不是当前版本客户端的天赋";
l10n["NO DECODER"] = "无法解析天赋数据";
