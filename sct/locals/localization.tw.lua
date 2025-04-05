--***************************************
-- zhTW Chinese Traditional
-- 2007/05/24 艾娜羅沙@奧妮克希亞
-- 如拿本文修改，請保留本翻譯作者名，謝謝
-- 2008/7/16修訂 天明@眾星之子
--***************************************

if GetLocale() ~= "zhTW" then return end 
-- Static Messages
SCT.LOCALS.LowHP= "生命過低！";					-- Message to be displayed when HP is low
SCT.LOCALS.LowMana= "法力過低！";					-- Message to be displayed when Mana is Low
SCT.LOCALS.SelfFlag = "*";								-- Icon to show self hits
SCT.LOCALS.Crushchar = "^";
SCT.LOCALS.Glancechar = "~";
SCT.LOCALS.Combat = "進入戰鬥";						-- Message to be displayed when entering combat
SCT.LOCALS.NoCombat = "脫離戰鬥";					-- Message to be displayed when leaving combat
SCT.LOCALS.ComboPoint = "連擊點";			  		-- Message to be displayed when gaining a combo point
SCT.LOCALS.CPMaxMessage = "終結它！！"; -- Message to be displayed when you have max combo points
SCT.LOCALS.ExtraAttack = "額外攻擊！"; -- Message to be displayed when time to execute
SCT.LOCALS.KillingBlow = "擊殺！"; -- "Killing Blow" Message to be displayed when you kill something
SCT.LOCALS.Interrupted = "被中斷！"; -- Message to be displayed when you are interrupted
SCT.LOCALS.Dispel = "被移除!"; -- Message to be displayed when you dispel
SCT.LOCALS.DispelFailed = "驅散失敗!"; -- Message to be displayed when your dispel failed
SCT.LOCALS.Rampage = "暴怒"; -- "Rampage" Message to be displayed when rampage is needed

--Option messages
SCT.LOCALS.STARTUP = "SCT（Scrolling Combat Text）"..SCT.Version.."插件已載入。輸入/sct顯示可用的指令。";
SCT.LOCALS.Option_Crit_Tip = "將此事件一律以致命一擊效果顯示";
SCT.LOCALS.Option_Msg_Tip = "將此事件一律以靜態訊息顯示，忽略其致命一擊效果";
SCT.LOCALS.Frame1_Tip = "在動畫框架1中顯示此事件";
SCT.LOCALS.Frame2_Tip = "在動畫框架2中顯示此事件"; 

--Warnings
SCT.LOCALS.Version_Warning= "|cff00ff00SCT警告|r\n\n你當前的存檔是舊版本SCT的設定。如果遇到錯誤或不正常現象，請按“重置”按鈕或輸入/sctreset恢復預設設定。";
SCT.LOCALS.Load_Error = "|cff00ff00載入SCT設定選單SCT - Damage（SCTD）時發生錯誤。設定插件可能被禁用了。|r 錯誤：";

--nouns
SCT.LOCALS.TARGET = "目標 ";
SCT.LOCALS.PROFILE = "載入SCT設定檔：|cff00ff00";
SCT.LOCALS.PROFILE_DELETE = "刪除SCT設定檔：|cff00ff00";
SCT.LOCALS.PROFILE_NEW = "新增SCT設定檔：|cff00ff00";
SCT.LOCALS.WARRIOR = "戰士";
SCT.LOCALS.ROGUE = "盜賊";
SCT.LOCALS.HUNTER = "獵人";
SCT.LOCALS.MAGE = "法師";
SCT.LOCALS.WARLOCK = "術士";
SCT.LOCALS.DRUID = "德魯伊";
SCT.LOCALS.PRIEST = "牧師";
SCT.LOCALS.SHAMAN = "薩滿";
SCT.LOCALS.PALADIN = "聖騎士";

--Useage
SCT.LOCALS.DISPLAY_USEAGE = "SCT語法：\n";
SCT.LOCALS.DISPLAY_USEAGE = SCT.LOCALS.DISPLAY_USEAGE .. "/sctdisplay '訊息'（顯示白色字）\n";
SCT.LOCALS.DISPLAY_USEAGE = SCT.LOCALS.DISPLAY_USEAGE .. "/sctdisplay '訊息' red(0-10) green(0-10) blue(0-10)\n";
SCT.LOCALS.DISPLAY_USEAGE = SCT.LOCALS.DISPLAY_USEAGE .. "例如：/sctdisplay '治療我' 10 0 0\n將顯示紅色字的『治療我』訊息\n";
SCT.LOCALS.DISPLAY_USEAGE = SCT.LOCALS.DISPLAY_USEAGE .. "某些常用顏色：紅 = 10 0 01綠 = 0 10 0, 藍 = 0 0 10，\n黃 = 10 10 0, 紫 = 10 0 10, 青 = 0 10 10";

--Fonts
SCT.LOCALS.FONTS = { 
	[1] = { name="數字", path="Fonts\\FZJZJW.TTF"},
	[2] = { name="任務", path="Fonts\\FZBWJW.TTF"},
	[3] = { name="物品", path="Fonts\\FZLBJW.TTF"},
	[4] = { name="提示", path="Fonts\\FZXHJW.TTF"},
	[5] = { name="訊息", path="Fonts\\FZXHLJW.TTF"},
	[6] = { name="暗黑破壞神", path="Interface\\Addons\\sct\\fonts\\Avqest.ttf"},
}

-- Cosmos button
SCT.LOCALS.CB_NAME			= "Scrolling Combat Text".." "..SCT.Version;
SCT.LOCALS.CB_SHORT_DESC	= "by Grayhoof";
SCT.LOCALS.CB_LONG_DESC	= "按此開啟SCT設定畫面";
SCT.LOCALS.CB_ICON			= "Interface\\Icons\\Spell_Shadow_EvilEye"; -- "Interface\\Icons\\Spell_Shadow_FarSight"
