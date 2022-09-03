local _, addonTable = ...;
local fuFrame=List_R_F_1_2
local _, _, _, tocversion = GetBuildInfo()
-------------------------------------------
--（关闭语言过滤器）
--/console SET portal "TW"    /console SET profanityFilter "0" 
-----------------
local yuyanguolv = CreateFrame("FRAME")
yuyanguolv:SetScript("OnEvent", function(self) --（关闭语言过滤器）
	if PIG['ChatFrame']['Guolv']=="ON" then
		if GetCVar("portal") == "CN" then
			ConsoleExec("portal TW") 
			SetCVar("profanityFilter", "0") 
		end
		self:UnregisterEvent("ADDON_LOADED")
		if tocversion>90000 then
			local Old_fun = C_BattleNet.GetFriendGameAccountInfo
			C_BattleNet.GetFriendGameAccountInfo = function(...)
				local gameAccountInfo = Old_fun(...)
				gameAccountInfo.isInCurrentRegion = true
				return gameAccountInfo;
			end
		else
			local OLD_BNGetFriendInfo = BNGetFriendInfo
			BNGetFriendInfo = function(...)
				local bnetIDAccount, accountName, battleTag, isBattleTagPresence, characterName, bnetIDGameAccount, client, isOnline, lastOnline, isAFK, isDND, messageText, noteText, isRIDFriend, messageTime, canSoR, isReferAFriend, canSummonFriend = OLD_BNGetFriendInfo(...)
				local canSummonFriend = true
				return bnetIDAccount, accountName, battleTag, isBattleTagPresence, characterName, bnetIDGameAccount, client, isOnline, lastOnline, isAFK, isDND, messageText, noteText, isRIDFriend, messageTime, canSoR, isReferAFriend, canSummonFriend;
			end
		end
	end 
end)
---------------------
fuFrame.Guolv = CreateFrame("CheckButton", nil, fuFrame, "ChatConfigCheckButtonTemplate");
fuFrame.Guolv:SetSize(30,32);
fuFrame.Guolv:SetHitRectInsets(0,-150,0,0);
fuFrame.Guolv:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",20,-20);
fuFrame.Guolv.Text:SetText("强制关闭语言过滤器");
fuFrame.Guolv.tooltip = "强制关闭系统选项中无法设置的语言过滤器！";
fuFrame.Guolv_title1 = fuFrame.Guolv:CreateFontString();--
fuFrame.Guolv_title1:SetPoint("LEFT", fuFrame.Guolv.Text, "RIGHT", 4, 0);
fuFrame.Guolv_title1:SetFontObject(GameFontNormal);
fuFrame.Guolv_title1:SetText('***更改后需重新登录游戏生效***')
fuFrame.Guolv:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG['ChatFrame']['Guolv']="ON";
		yuyanguolv:RegisterEvent("ADDON_LOADED") 
	else
		PIG['ChatFrame']['Guolv']="OFF";
		yuyanguolv:UnregisterEvent("ADDON_LOADED") 
	end
end);
--=========================================================
--输入框光标优化
local function ChatFrame_AltEX_Open()
	if PIG['ChatFrame']['AltEX']=="ON" then
		for i = 1, NUM_CHAT_WINDOWS do
			_G["ChatFrame"..i.."EditBox"]:SetAltArrowKeyMode(false) --只按方向键即可控制输入框光标 
		end
	end
	if PIG['ChatFrame']['AltEX']=="OFF" then
		for i = 1, NUM_CHAT_WINDOWS do
			_G["ChatFrame"..i.."EditBox"]:SetAltArrowKeyMode(true) --只按方向键即可控制输入框光标 
		end
	end
end
---------------------
fuFrame.AltEX = CreateFrame("CheckButton", nil, fuFrame, "ChatConfigCheckButtonTemplate");
fuFrame.AltEX:SetSize(30,32);
fuFrame.AltEX:SetHitRectInsets(0,-100,0,0);
fuFrame.AltEX:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",20,-60);
fuFrame.AltEX.Text:SetText("输入框光标优化");
fuFrame.AltEX.tooltip = "只按方向键即可控制输入框光标，正常系统是需要按住ALT键才可移动光标！";
fuFrame.AltEX:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG['ChatFrame']['AltEX']="ON";	
	else
		PIG['ChatFrame']['AltEX']="OFF";
	end
	ChatFrame_AltEX_Open();
end);
--=========================================================
--移除聊天文字渐隐
local function ChatFrame_Jianyin_Open()
	if PIG['ChatFrame']['Jianyin']=="ON" then
		for i = 1, NUM_CHAT_WINDOWS do
			_G["ChatFrame"..i]:SetFading(false) --关闭文字渐隐 
		end
	end
	if PIG['ChatFrame']['Jianyin']=="OFF" then
		for i = 1, NUM_CHAT_WINDOWS do
			_G["ChatFrame"..i]:SetFading(true) --开启文字渐隐  
		end
	end
end
---------------------
fuFrame.Jianyin = CreateFrame("CheckButton", nil, fuFrame, "ChatConfigCheckButtonTemplate");
fuFrame.Jianyin:SetSize(30,32);
fuFrame.Jianyin:SetHitRectInsets(0,-120,0,0);
fuFrame.Jianyin:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",300,-60);
fuFrame.Jianyin.Text:SetText("关闭聊天栏文字渐隐");
fuFrame.Jianyin.tooltip = "移除聊天栏文字渐隐效果！";
fuFrame.Jianyin:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG['ChatFrame']['Jianyin']="ON";	
	else
		PIG['ChatFrame']['Jianyin']="OFF";
	end
	ChatFrame_Jianyin_Open();
end);

--============================================================
--增加放大缩小字体按钮
local ChatFontSizeList = {12,14,16,18,20,22,23,24,25,26};

local function ChatFrame_MinMaxB_Open()
	local ChatFontMin =ChatFontSizeList[1]
	local ChatFontMax =ChatFontSizeList[#ChatFontSizeList]
	if MinB_UI then return end
	local fff = ChatFrame1
	local www,hhh = ChatFrameMenuButton:GetWidth(),ChatFrameMenuButton:GetHeight()
	fff.MinB = CreateFrame("Button","MinB_UI",UIParent, "UIMenuButtonStretchTemplate"); 
	fff.MinB:SetHighlightTexture("");
	fff.MinB:SetFrameStrata("LOW")
	if tocversion<40000 then
		fff.MinB:SetSize(www-5.4,hhh-7);
		fff.MinB:SetPoint("BOTTOM",ChatFrame1ButtonFrameBottomButton,"TOP",-1,5);
		for id=1,NUM_CHAT_WINDOWS,1 do
			_G["ChatFrame"..id.."ButtonFrameUpButton"]:Hide()
			_G["ChatFrame"..id.."ButtonFrameDownButton"]:Hide()
		end
	else
		fff.MinB:SetSize(www-4.4,hhh-6);
		fff.MinB:SetPoint("BOTTOM",ChatFrameMenuButton,"TOP",0,5);
	end
	fff.MinB.HighlightTex = fff.MinB:CreateTexture(nil,"HIGHLIGHT");
	fff.MinB.HighlightTex:SetTexture("Interface/BUTTONS/UI-Common-MouseHilight");
	fff.MinB.HighlightTex:SetSize(www,hhh);
	fff.MinB.HighlightTex:SetPoint("CENTER", 0, 0);
	fff.MinB.HighlightTex:SetBlendMode("ADD")
	fff.MinB.Tex = fff.MinB:CreateTexture();
	fff.MinB.Tex:SetTexture(136483);
	fff.MinB.Tex:SetSize(14,6);
	fff.MinB.Tex:SetPoint("CENTER", 0, 0);
	fff.MinB.Tex:SetTexCoord(0.31,0.71,0.41,0.56);
	fff.MinB:SetScript("OnMouseDown",  function(self)
		local _,fontSize = GetChatWindowInfo(1);
		if fontSize>ChatFontMin then
			self.Tex:SetPoint("CENTER", -1, -1);
		end
	end)
	fff.MinB:SetScript("OnMouseUp",  function(self)
		self.Tex:SetPoint("CENTER", 0, 0);
	end)
	fff.MaxB = CreateFrame("Button","MaxB_UI",UIParent, "UIMenuButtonStretchTemplate");
	fff.MaxB:SetHighlightTexture("");
	if tocversion<40000 then
		fff.MaxB:SetSize(www-5.4,hhh-7);
	else
		fff.MaxB:SetSize(www-4.4,hhh-6);
	end
	fff.MaxB:SetFrameStrata("LOW")
	fff.MaxB:SetPoint("BOTTOM",fff.MinB,"TOP",0,3);
	fff.MaxB.HighlightTex = fff.MaxB:CreateTexture(nil,"HIGHLIGHT");
	fff.MaxB.HighlightTex:SetTexture("Interface/BUTTONS/UI-Common-MouseHilight");
	fff.MaxB.HighlightTex:SetSize(www,hhh);
	fff.MaxB.HighlightTex:SetPoint("CENTER", 0, 0);
	fff.MaxB.HighlightTex:SetBlendMode("ADD")
	fff.MaxB.Tex = fff.MaxB:CreateTexture();
	fff.MaxB.Tex:SetTexture(136480);
	fff.MaxB.Tex:SetSize(13,12);
	fff.MaxB.Tex:SetPoint("CENTER", 0, 0);
	fff.MaxB.Tex:SetTexCoord(0.34,0.69,0.31,0.66);
	fff.MaxB:SetScript("OnMouseDown",  function(self)
		local _,fontSize = GetChatWindowInfo(1);
		if fontSize<ChatFontMax then
			self.Tex:SetPoint("CENTER", -1, -1);
		end
	end)
	fff.MaxB:SetScript("OnMouseUp",  function(self)
		self.Tex:SetPoint("CENTER", 0, 0);
	end)
	fff.MinB:SetScript("OnClick", function(self)
		fff.MaxB.Tex:SetTexture(136480);
		local _,fontSize = GetChatWindowInfo(1);
		if fontSize>ChatFontMin then
			local NEwZITI = fontSize-2
			for id=1,NUM_CHAT_WINDOWS,1 do
				FCF_SetChatWindowFontSize(nil, _G["ChatFrame"..id], NEwZITI);
			end
			if ChatFrame99 then
				FCF_SetChatWindowFontSize(nil, ChatFrame99, NEwZITI);
			end
			if NEwZITI==ChatFontMin then self.Tex:SetTexture(136481); end
		end
	end);
	fff.MaxB:SetScript("OnClick", function(self)
		fff.MinB.Tex:SetTexture(136483);
		local _,fontSize = GetChatWindowInfo(1);
		if fontSize<ChatFontMax then
			local NEwZITI = fontSize+2
			for id=1,NUM_CHAT_WINDOWS,1 do
				FCF_SetChatWindowFontSize(nil, _G["ChatFrame"..id], NEwZITI);	
			end
			if ChatFrame99 then
				FCF_SetChatWindowFontSize(nil, ChatFrame99, NEwZITI);
			end
			if NEwZITI==ChatFontMax then self.Tex:SetTexture(136478); end
		end
	end);
	local _,fontSize = GetChatWindowInfo(1);
	if fontSize==ChatFontMin then MinB_UI.Tex:SetTexture(136481); end
	if fontSize==ChatFontMax then MaxB_UI.Tex:SetTexture(136478); end
end
---------------------
fuFrame.MinMaxB = CreateFrame("CheckButton", nil, fuFrame, "ChatConfigCheckButtonTemplate");
fuFrame.MinMaxB:SetSize(30,32);
fuFrame.MinMaxB:SetHitRectInsets(0,-150,0,0);
fuFrame.MinMaxB:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",20,-100);
fuFrame.MinMaxB.Text:SetText("添加放大缩小字体按钮");
fuFrame.MinMaxB.tooltip = "在聊天栏右上方添加放大缩小字体按钮！";
fuFrame.MinMaxB:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG['ChatFrame']['MinMaxB']="ON";
		ChatFrame_MinMaxB_Open();		
	else
		PIG['ChatFrame']['MinMaxB']="OFF";
		Pig_Options_RLtishi_UI:Show()
	end
end);
--========================================================
--设置聊天字体大小
local function ChatFrame_FontSize_ST()
	for id=1,NUM_CHAT_WINDOWS,1 do
		FCF_SetChatWindowFontSize(nil, _G["ChatFrame"..id], PIG['ChatFrame']['FontSize_value']);
	end
	if ChatFrame99 then
		FCF_SetChatWindowFontSize(nil, ChatFrame99, PIG['ChatFrame']['FontSize_value']);
	end
	local _,fontSize = GetChatWindowInfo(1);
	if fontSize==ChatFontMin then MinB_UI.Tex:SetTexture(136481); end
	if fontSize==ChatFontMax then MaxB_UI.Tex:SetTexture(136478); end
end
local function PigUI_ChatFrame_FontSize_Open()
	C_Timer.After(0.6, ChatFrame_FontSize_ST);
end
-----------------------
fuFrame.FontSize = CreateFrame("CheckButton", nil, fuFrame, "ChatConfigCheckButtonTemplate");
fuFrame.FontSize:SetSize(30,32);
fuFrame.FontSize:SetHitRectInsets(0,-120,0,0);
fuFrame.FontSize:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",300,-100);
fuFrame.FontSize.Text:SetText("设置聊天字体大小为:");
fuFrame.FontSize.tooltip = "开启后将在每次登录时恢复聊天字体大小为设置值，如果想自定义单独聊天窗字体大小请关闭此选项。";
fuFrame.FontSize:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG['ChatFrame']['FontSize']="ON";
		ChatFrame_FontSize_ST();
	else
		PIG['ChatFrame']['FontSize']="OFF";
	end
end);
--字号下拉菜单
fuFrame.ChatFontSize = CreateFrame("FRAME", nil, fuFrame, "UIDropDownMenuTemplate")
fuFrame.ChatFontSize:SetPoint("LEFT",fuFrame.FontSize.Text,"RIGHT",-16,-4)
UIDropDownMenu_SetWidth(fuFrame.ChatFontSize, 58)

local function ChatFontSize_Up()
	local info = UIDropDownMenu_CreateInfo()
	info.func = fuFrame.ChatFontSize.SetValue
	for i=1,#ChatFontSizeList,1 do
	    info.text, info.arg1, info.checked = ChatFontSizeList[i].."pt", ChatFontSizeList[i], ChatFontSizeList[i] == PIG['ChatFrame']['FontSize_value'];
		UIDropDownMenu_AddButton(info)
	end 
end
function fuFrame.ChatFontSize:SetValue(newValue)
	UIDropDownMenu_SetText(fuFrame.ChatFontSize, newValue.."pt")
	for id=1,NUM_CHAT_WINDOWS,1 do
		FCF_SetChatWindowFontSize(nil, _G["ChatFrame"..id], newValue);
	end
	if ChatFrame99 then
		FCF_SetChatWindowFontSize(nil, ChatFrame99, newValue);
	end
	PIG['ChatFrame']['FontSize_value'] = newValue;
	CloseDropDownMenus()--关闭下拉
end
--粘连回车
fuFrame.zhanlianxian = fuFrame:CreateLine()
fuFrame.zhanlianxian:SetColorTexture(0.8,0.8,0.8,0.5)
fuFrame.zhanlianxian:SetThickness(1);
fuFrame.zhanlianxian:SetStartPoint("TOPLEFT",2,-200)
fuFrame.zhanlianxian:SetEndPoint("TOPRIGHT",-2,-200)
fuFrame.zhanliantxt = fuFrame:CreateFontString();--
fuFrame.zhanliantxt:SetPoint("TOPLEFT",fuFrame.zhanlianxian,"TOPLEFT",20,-20);
fuFrame.zhanliantxt:SetFontObject(GameFontNormal);
fuFrame.zhanliantxt:SetText('粘连回车|cff00ff00(取消粘连回车的频道，发言后回车不会返回此频道)|r')
-- local chatpindao = {"SAY","PARTY","RAID","INSTANCE","GUILD","OFFICER","WHISPER","BN_WHISPER"}
-- local chatpindaoName = {"说","队伍","团队","副本","公会","官员","密语","战网密语"}
--70/60
local chatpindao = {"SAY","PARTY","RAID","GUILD","OFFICER","WHISPER","BN_WHISPER"}
local chatpindaoName = {"说","队伍","团队","公会","官员","密语","战网密语"}
for i=1,#chatpindao do
	fuFrame.zhanlian = CreateFrame("CheckButton", "Pig_pindaozhanlian"..i, fuFrame, "ChatConfigCheckButtonTemplate");
	fuFrame.zhanlian:SetSize(30,32);
	fuFrame.zhanlian:SetHitRectInsets(0,-20,0,0);
	fuFrame.zhanlian.Text:SetText(chatpindaoName[i]);
	fuFrame.zhanlian.tooltip = "勾选粘连【"..chatpindaoName[i].."】频道到回车，取消勾选解除粘连";
	if i==1 then
		fuFrame.zhanlian:SetPoint("TOPLEFT",fuFrame.zhanliantxt,"BOTTOMLEFT",2,-10);
	elseif i==2 then
		fuFrame.zhanlian:SetPoint("LEFT",_G["Pig_pindaozhanlian"..(i-1)],"RIGHT",22,0);
	else
		fuFrame.zhanlian:SetPoint("LEFT",_G["Pig_pindaozhanlian"..(i-1)],"RIGHT",35,0);
	end
	fuFrame.zhanlian:SetScript("OnClick", function (self)
		if self:GetChecked() then
			ChatTypeInfo[chatpindao[i]]["sticky"]=1
			PIG['ChatFrame']['chatZhanlian'][chatpindao[i]]=1
		else
			ChatTypeInfo[chatpindao[i]]["sticky"]=0
			PIG['ChatFrame']['chatZhanlian'][chatpindao[i]]=0
		end
	end);
end
----鼠标指向链接显示物品属性
local linktypes = {item = true, enchant = true, spell = true, quest = true, unit = true, talent = true, achievement = true, glyph = true}
local function linkEnter(self, linkData, link)
	local linktype = linkData:match("^([^:]+)")
	if linktype and linktypes[linktype] then
		GameTooltip:SetOwner(self, "ANCHOR_CURSOR")
		GameTooltip:SetHyperlink(link)
		GameTooltip:Show()
	end
end
local function linkLeave()
	GameTooltip:Hide()
end
local function chat_SHow()
	for i = 1, NUM_CHAT_WINDOWS do
		local frame = _G["ChatFrame"..i]
		frame:SetScript("OnHyperlinkEnter", linkEnter)
		frame:SetScript("OnHyperlinkLeave", linkLeave)
	end
end
---
fuFrame.shubiaohuaguo = CreateFrame("CheckButton", nil, fuFrame, "ChatConfigCheckButtonTemplate");
fuFrame.shubiaohuaguo:SetSize(30,32);
fuFrame.shubiaohuaguo:SetHitRectInsets(0,-120,0,0);
fuFrame.shubiaohuaguo:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",20,-140);
fuFrame.shubiaohuaguo.Text:SetText("鼠标指向链接显示物品属性");
fuFrame.shubiaohuaguo.tooltip = "鼠标指向链接显示物品属性，正常需要点击物品链接。";
fuFrame.shubiaohuaguo:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG['ChatFrame']['zhixiangShow']="ON";
		chat_SHow()
	else
		PIG['ChatFrame']['zhixiangShow']="OFF";
		Pig_Options_RLtishi_UI:Show();
	end
end);
--聊天窗口可以移动到屏幕边缘
local function ChatFrame_Bianju_Open()
	for i = 1, NUM_CHAT_WINDOWS do 
		_G["ChatFrame"..i]:SetClampRectInsets(-35, 0, 0, 0) --可拖动至紧贴屏幕边缘 
	end
end
---------------------
fuFrame.Bianju = CreateFrame("CheckButton", nil, fuFrame, "ChatConfigCheckButtonTemplate");
fuFrame.Bianju:SetSize(30,32);
fuFrame.Bianju:SetHitRectInsets(0,-120,0,0);
fuFrame.Bianju:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",300,-140);
fuFrame.Bianju.Text:SetText("移除聊天窗口的边距");
fuFrame.Bianju.tooltip = "移除聊天窗口的系统默认边距，使之可以移动到屏幕最边缘！";
fuFrame.Bianju:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG['ChatFrame']['Bianju']="ON";
		ChatFrame_Bianju_Open();
	else
		PIG['ChatFrame']['Bianju']="OFF";
		Pig_Options_RLtishi_UI:Show()
	end
end);
fuFrame:HookScript("OnShow", function ()
	UIDropDownMenu_SetText(fuFrame.ChatFontSize, PIG['ChatFrame']['FontSize_value'].."pt")
	UIDropDownMenu_Initialize(fuFrame.ChatFontSize, ChatFontSize_Up)
	for i=1,#chatpindao do
		if PIG['ChatFrame']['chatZhanlian'][chatpindao[i]]==0 then
			ChatTypeInfo[chatpindao[i]]["sticky"]=0
		elseif PIG['ChatFrame']['chatZhanlian'][chatpindao[i]]==1 then
			_G["Pig_pindaozhanlian"..i]:SetChecked(true);
			ChatTypeInfo[chatpindao[i]]["sticky"]=1
		end
	end
end);
--=====================================
addonTable.ChatFrame_Qita = function()
	PIG['ChatFrame']['chatZhanlian']=PIG['ChatFrame']['chatZhanlian'] or addonTable.Default['ChatFrame']['chatZhanlian']
	if PIG['ChatFrame']['FontSize']=="ON" then
		fuFrame.FontSize:SetChecked(true);
		PigUI_ChatFrame_FontSize_Open()
	end
	if PIG['ChatFrame']['MinMaxB']=="ON" then
		fuFrame.MinMaxB:SetChecked(true);
		ChatFrame_MinMaxB_Open();
	end
	if PIG['ChatFrame']['Jianyin']=="ON" then
		fuFrame.Jianyin:SetChecked(true);
		ChatFrame_Jianyin_Open();
	end
	if PIG['ChatFrame']['Guolv']=="ON" then
		fuFrame.Guolv:SetChecked(true);
		yuyanguolv:RegisterEvent("ADDON_LOADED") 
	end
	if PIG['ChatFrame']['AltEX']=="ON" then
		fuFrame.AltEX:SetChecked(true);
		ChatFrame_AltEX_Open();
	end
	if PIG['ChatFrame']['zhixiangShow']=="ON" then
		fuFrame.shubiaohuaguo:SetChecked(true);
		chat_SHow()
	end
	if PIG['ChatFrame']['Bianju']=="ON" then
		fuFrame.Bianju:SetChecked(true);
		ChatFrame_Bianju_Open();
	end
end