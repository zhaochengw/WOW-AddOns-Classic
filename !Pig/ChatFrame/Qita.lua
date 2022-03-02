local _, addonTable = ...;
local fuFrame=Pig_Options_RF_TAB_2_UI
-------------------------------------------
--（关闭语言过滤器）
--/console SET portal "TW"    /console SET profanityFilter "0" 
local function guanbiguolv(self) --（关闭语言过滤器）
	if PIG['ChatFrame']['Guolv']=="ON" then
		if GetCVar("portal") == "CN" then 
			ConsoleExec("portal TW") 
		end
		SetCVar("profanityFilter", 0) 
		self:UnregisterEvent("ADDON_LOADED") 
	end 
end 

local yuyanguolv = CreateFrame("FRAME")
yuyanguolv:SetScript("OnEvent", guanbiguolv)
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
fuFrame.Guolv_title1:SetText('*更改后需大退重新登录游戏生效*')
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
local function ChatFrame_MinMaxB_Open()
	if MinB_UI==nil then
		local MinB = CreateFrame("Button","MinB_UI",UIParent, "UIMenuButtonStretchTemplate"); 
		MinB:SetSize(27,26);
		MinB:SetFrameStrata("LOW")
		MinB:SetPoint("BOTTOM",ChatFrameChannelButton,"TOP",0,3);
		MinB.Texture = MinB:CreateTexture(nil, "OVERLAY");
		MinB.Texture:SetTexture(136483);
		MinB.Texture:SetSize(14,6);
		MinB.Texture:SetPoint("CENTER", 0, 0);
		MinB.Texture:SetTexCoord(0.31,0.71,0.41,0.56);

		local MaxB = CreateFrame("Button","MaxB_UI",UIParent, "UIMenuButtonStretchTemplate");
		MaxB:SetSize(27,26);
		MaxB:SetFrameStrata("LOW")
		MaxB:SetPoint("BOTTOM",MinB,"TOP",0,0);
		MaxB.Texture = MaxB:CreateTexture(nil, "OVERLAY");
		MaxB.Texture:SetTexture(136480);
		MaxB.Texture:SetSize(13,12);
		MaxB.Texture:SetPoint("CENTER", 0, 0);
		MaxB.Texture:SetTexCoord(0.34,0.69,0.31,0.66);

		MinB:SetScript("OnMouseDown",  function(self)
			self.Texture:SetPoint("CENTER", -1, -1.5);
		end)
		MinB:SetScript("OnMouseUp",  function(self)
			self.Texture:SetPoint("CENTER", 0, 0);
		end)
		MinB:SetScript("OnClick", function()
			MaxB.Texture:SetTexture(136480);
			local _,fontSize = GetChatWindowInfo(1);
			if fontSize>12 then
				local NEwZITI = fontSize-2
				for id=1,NUM_CHAT_WINDOWS,1 do
					FCF_SetChatWindowFontSize(nil, _G["ChatFrame"..id], NEwZITI);
				end
				if ChatFrame99 then
					FCF_SetChatWindowFontSize(nil, ChatFrame99, NEwZITI);
				end
				if NEwZITI==12 then MinB.Texture:SetTexture(136481); end
			end
		end);
		MaxB:SetScript("OnMouseDown",  function(self)
			self.Texture:SetPoint("CENTER", -1, -1.5);
		end)
		MaxB:SetScript("OnMouseUp",  function(self)
			self.Texture:SetPoint("CENTER", 0, 0);
		end)
		MaxB:SetScript("OnClick", function()
			local _,fontSize = GetChatWindowInfo(1);
			MinB.Texture:SetTexture(136483);
			if fontSize<18 then
				local NEwZITI = fontSize+2
				for id=1,NUM_CHAT_WINDOWS,1 do
					FCF_SetChatWindowFontSize(nil, _G["ChatFrame"..id], NEwZITI);	
				end
				if ChatFrame99 then
					FCF_SetChatWindowFontSize(nil, ChatFrame99, NEwZITI);
				end
				if NEwZITI==18 then MaxB.Texture:SetTexture(136478); end
			end
		end);
		local _,fontSize = GetChatWindowInfo(1);
		if fontSize==12 then MinB.Texture:SetTexture(136481); end
		if fontSize==18 then MaxB.Texture:SetTexture(136478); end
	end
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
local ChatFontSizeList = {12,14,16,18};
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
local function chatzhanlian_fun()
	for i=1,#chatpindao do
		if PIG['ChatFrame']['chatZhanlian'][chatpindao[i]]==0 then
			ChatTypeInfo[chatpindao[i]]["sticky"]=0
		elseif PIG['ChatFrame']['chatZhanlian'][chatpindao[i]]==1 then
			_G["Pig_pindaozhanlian"..i]:SetChecked(true);
			ChatTypeInfo[chatpindao[i]]["sticky"]=1
		end
	end
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
--=====================================
addonTable.ChatFrame_Qita = function()
	PIG['ChatFrame']['chatZhanlian']=PIG['ChatFrame']['chatZhanlian'] or addonTable.Default['ChatFrame']['chatZhanlian']
	chatzhanlian_fun()
	UIDropDownMenu_SetText(fuFrame.ChatFontSize, PIG['ChatFrame']['FontSize_value'].."pt")--设定下拉默认选中
	UIDropDownMenu_Initialize(fuFrame.ChatFontSize, ChatFontSize_Up)--初始化下拉
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
end