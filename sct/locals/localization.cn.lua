--***********
--Chinese Translation
--2008.3.25 Valkyrie
--***********

if GetLocale() ~= "zhCN" then return end 

-- Static Messages
SCT.LOCALS.LowHP= "血量过低！";					-- Message to be displayed when HP is low
SCT.LOCALS.LowMana= "法力过低！";					-- Message to be displayed when Mana is Low
SCT.LOCALS.SelfFlag = "*";								-- Icon to show self hits
SCT.LOCALS.Crushchar = "^";
SCT.LOCALS.Glancechar = "~";
SCT.LOCALS.Combat = "进入战斗";						-- Message to be displayed when entering combat
SCT.LOCALS.NoCombat = "离开战斗";					-- Message to be displayed when leaving combat
SCT.LOCALS.ComboPoint = "星";			  		-- Message to be displayed when gaining a combo point
SCT.LOCALS.CPMaxMessage = "5星终结！"; -- Message to be displayed when you have max combo points
SCT.LOCALS.ExtraAttack = "额外攻击！"; -- Message to be displayed when time to execute
SCT.LOCALS.KillingBlow = "击杀！"; -- Message to be displayed when you kill something
SCT.LOCALS.Interrupted = "打断！"; -- Message to be displayed when you are interrupted
SCT.LOCALS.Rampage = "狂暴"; -- Message to be displayed when rampage is needed

--Option messages
SCT.LOCALS.STARTUP = "插件已载入。您可以输入/sct显示参数";
SCT.LOCALS.Option_Crit_Tip = "将此事件以致命一击效果显示";
SCT.LOCALS.Option_Msg_Tip = "将此事件以静态讯息显示，覆盖其致命一击效果";
SCT.LOCALS.Frame1_Tip = "在动画框体1中显示此事件";
SCT.LOCALS.Frame2_Tip = "在动画框体2中显示此事件";

--Warnings
SCT.LOCALS.Version_Warning= "|cff00ff00SCT警告|r\n\n你当前的存档为旧版本SCT的设置。如果遇到错误或者不正常现象，请按“重置”按钮或请输入/sctreset恢复默认设置。";
SCT.LOCALS.Load_Error = "|cff00ff00载入SCT设置菜单时发生错误，设置模块可能禁用了。|r 錯誤：";

--nouns
SCT.LOCALS.TARGET = "目标 ";
SCT.LOCALS.PROFILE = "载入SCT配置：|cff00ff00";
SCT.LOCALS.PROFILE_DELETE = "刪除SCT配置：|cff00ff00";
SCT.LOCALS.PROFILE_NEW = "新建SCT配置：|cff00ff00";
SCT.LOCALS.WARRIOR = "战士";
SCT.LOCALS.ROGUE = "潜行者";
SCT.LOCALS.HUNTER = "猎人";
SCT.LOCALS.MAGE = "法师";
SCT.LOCALS.WARLOCK = "术士";
SCT.LOCALS.DRUID = "德鲁伊";
SCT.LOCALS.PRIEST = "牧师";
SCT.LOCALS.SHAMAN = "萨满祭司";
SCT.LOCALS.PALADIN = "圣骑士";

--Useage
SCT.LOCALS.DISPLAY_USEAGE = "SCT语法：\n";
SCT.LOCALS.DISPLAY_USEAGE = SCT.LOCALS.DISPLAY_USEAGE .. "/sctdisplay '信息'（白色文字）\n";
SCT.LOCALS.DISPLAY_USEAGE = SCT.LOCALS.DISPLAY_USEAGE .. "/sctdisplay '信息' 红(0-10) 绿(0-10) 蓝(0-10)\n";
SCT.LOCALS.DISPLAY_USEAGE = SCT.LOCALS.DISPLAY_USEAGE .. "例如：/sctdisplay '治疗我' 10 0 0\n将会以红色字来显示“治疗我”警告信息\n";
SCT.LOCALS.DISPLAY_USEAGE = SCT.LOCALS.DISPLAY_USEAGE .. "一些常用颜色值：红 = 10 0 0, 绿 = 0 10 0, 蓝 = 0 0 10，\n黃 = 10 10 0, 紫 = 10 0 10, 青 = 0 10 10";

--Fonts
SCT.LOCALS.FONTS = { 
	[1] = { name="数字", path="Fonts\\ZYKAI.TTF"},
	[2] = { name="任务", path="Fonts\\ZYKAI_C.TTF"},
	[3] = { name="物品", path="Fonts\\ZYKAI_T.TTF"},
	[4] = { name="提示", path="Fonts\\ZYHEI.TTF"},
	[5] = { name="信息", path="Fonts\\ZYHEI.TTF"},
	[6] = { name="暗黑破坏神", path="Interface\\Addons\\sct\\fonts\\Avqest.ttf"},
}

-- Cosmos button
SCT.LOCALS.CB_NAME			= "Scrolling Combat Text".." "..SCT.Version;
SCT.LOCALS.CB_SHORT_DESC	= "by Grayhoof";
SCT.LOCALS.CB_LONG_DESC	= "单击打开SCT设置菜单";
SCT.LOCALS.CB_ICON			= "Interface\\Icons\\Spell_Shadow_FarSight"; -- "Interface\\Icons\\Spell_Shadow_FarSight"
