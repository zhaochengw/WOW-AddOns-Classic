local _, addonTable = ...;
local fuFrame=List_R_F_1_2
local gsub = _G.string.gsub
local match = _G.string.match --查找是否包含
local _, _, _, tocversion = GetBuildInfo()
local ADD_Checkbutton=addonTable.ADD_Checkbutton
local Create=addonTable.Create
local PIGDownMenu=Create.PIGDownMenu
-------------------------------------------
fuFrame.Scroll = CreateFrame("ScrollFrame",nil,fuFrame, "UIPanelScrollFrameTemplate");  
fuFrame.Scroll:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",6,-6);
fuFrame.Scroll:SetPoint("BOTTOMRIGHT",fuFrame,"BOTTOMRIGHT",-26,5);
fuFrame.nr = CreateFrame("Frame", nil, fuFrame.scroll)
fuFrame.nr:SetWidth(fuFrame.Scroll:GetWidth())
fuFrame.nr:SetHeight(10) 
fuFrame.Scroll:SetScrollChild(fuFrame.nr)
local fuFrame = fuFrame.nr
local Xpianyi,Ypianyi,chushiY = 14,-36,-10
--------------
local QuickChat_maodianID = {1,2};
local QuickChat_maodianListCN = {"附着于聊天栏上方","附着于聊天栏下方"};
local ChatFrame_QuickChat_Open=addonTable.ChatFrame_QuickChat_Open
fuFrame.QuickChat = ADD_Checkbutton(nil,fuFrame,-100,"TOPLEFT",fuFrame,"TOPLEFT",Xpianyi,chushiY,"快捷切换频道按钮","在聊天栏增加一排频道快捷切换按钮，可快速切换频道！")
fuFrame.QuickChat:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG["ChatFrame"]["QuickChat"]="ON";
		ChatFrame_QuickChat_Open()
	else
		PIG["ChatFrame"]["QuickChat"]="OFF";
		Pig_Options_RLtishi_UI:Show()
	end
end);

fuFrame.QuickChat_maodian =PIGDownMenu(nil,{160,nil},fuFrame.QuickChat,{"LEFT",fuFrame.QuickChat.Text,"RIGHT",10,-2})
function fuFrame.QuickChat_maodian:PIGDownMenu_Update_But(self)
	local info = {}
	info.func = self.PIGDownMenu_SetValue
	for i=1,#QuickChat_maodianListCN,1 do
	    info.text, info.arg1, info.checked = QuickChat_maodianListCN[i], i, i == PIG["ChatFrame"]['QuickChat_maodian']
		fuFrame.QuickChat_maodian:PIGDownMenu_AddButton(info)
	end 
end
function fuFrame.QuickChat_maodian:PIGDownMenu_SetValue(value,arg1,arg2)
	fuFrame.QuickChat_maodian:PIGDownMenu_SetText(value)
	PIG["ChatFrame"]['QuickChat_maodian']=arg1
	addonTable.Update_QuickChatEditBox(arg1)
	PIGCloseDropDownMenus()
end
---
local QuickChat_style = {"样式1","样式2"};
fuFrame.QuickChat_style =PIGDownMenu(nil,{80,nil},fuFrame.QuickChat,{"LEFT",fuFrame.QuickChat_maodian,"RIGHT",30,0})
function fuFrame.QuickChat_style:PIGDownMenu_Update_But(self)
	local info = {}
	info.func = self.PIGDownMenu_SetValue
	for i=1,#QuickChat_style,1 do
	    info.text, info.arg1, info.checked = QuickChat_style[i], i, i == PIG["ChatFrame"]["QuickChat_style"]
		fuFrame.QuickChat_style:PIGDownMenu_AddButton(info)
	end 
end
function fuFrame.QuickChat_style:PIGDownMenu_SetValue(value,arg1,arg2)
	fuFrame.QuickChat_style:PIGDownMenu_SetText(value)
	PIG["ChatFrame"]["QuickChat_style"]=arg1
	Pig_Options_RLtishi_UI:Show()
	PIGCloseDropDownMenus()
end
------------
fuFrame.xian0 = fuFrame:CreateLine()
fuFrame.xian0:SetColorTexture(0.8,0.8,0.8,0.5)
fuFrame.xian0:SetThickness(1);
fuFrame.xian0:SetStartPoint("TOPLEFT",0,-48)
fuFrame.xian0:SetEndPoint("TOPRIGHT",0,-48)
--（关闭语言过滤器）
--/console SET portal "TW"    /console SET profanityFilter "0" 
local yuyanguolv = CreateFrame("FRAME")
yuyanguolv:SetScript("OnEvent", function(self,event) --（关闭语言过滤器）
	if PIG["ChatFrame"]["Guolv"]=="ON" then
		if GetLocale() == "zhCN" then
			if GetCVar("portal") == "CN" then
				ConsoleExec("portal TW") 
				SetCVar("profanityFilter", "0")
			end
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
		local ADD_Button=addonTable.ADD_Button
		local guanbiguolvqi=ADD_Button("无法访问点这里然后重新登录游戏",nil,HelpFrame,280,20,"TOPRIGHT", HelpFrame, "TOPRIGHT", -50, -0.4)
		guanbiguolvqi:SetScript("OnClick", function (self)
			PIG["ChatFrame"]["Guolv"]="OFF"
			self:SetText("请退出游戏重新登录")
			self:Disable()
		end);
	end 
end)
---------------------
fuFrame.Guolv = ADD_Checkbutton(nil,fuFrame,-150,"TOPLEFT",fuFrame.xian0,"TOPLEFT",Xpianyi,chushiY,"强制关闭语言过滤器","强制关闭系统选项中无法设置的语言过滤器")
fuFrame.Guolv_title1 = fuFrame.Guolv:CreateFontString();
fuFrame.Guolv_title1:SetPoint("LEFT", fuFrame.Guolv.Text, "RIGHT", 4, 0);
fuFrame.Guolv_title1:SetFontObject(GameFontNormal);
fuFrame.Guolv_title1:SetText('***更改后需重新登录游戏生效***')
fuFrame.Guolv:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG["ChatFrame"]["Guolv"]="ON";
		yuyanguolv:RegisterEvent("ADDON_LOADED") 
	else
		PIG["ChatFrame"]["Guolv"]="OFF";
		yuyanguolv:UnregisterEvent("ADDON_LOADED") 
	end
end);

--输入框光标优化
local function ChatFrame_AltEX_Open()
	if PIG["ChatFrame"]["AltEX"]=="ON" then
		for i = 1, NUM_CHAT_WINDOWS do
			_G["ChatFrame"..i.."EditBox"]:SetAltArrowKeyMode(false) --只按方向键即可控制输入框光标 
		end
	end
	if PIG["ChatFrame"]["AltEX"]=="OFF" then
		for i = 1, NUM_CHAT_WINDOWS do
			_G["ChatFrame"..i.."EditBox"]:SetAltArrowKeyMode(true) --只按方向键即可控制输入框光标 
		end
	end
end
---------------------
fuFrame.AltEX = ADD_Checkbutton(nil,fuFrame,-100,"TOPLEFT",fuFrame.xian0,"TOPLEFT",Xpianyi,Ypianyi*1+chushiY,"输入框光标优化","只按方向键即可控制输入框光标，正常系统是需要按住ALT键才可移动光标")
fuFrame.AltEX:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG["ChatFrame"]["AltEX"]="ON";	
	else
		PIG["ChatFrame"]["AltEX"]="OFF";
	end
	ChatFrame_AltEX_Open();
end);

--移除聊天文字渐隐
local function ChatFrame_Jianyin_Open()
	if PIG["ChatFrame"]["Jianyin"]=="ON" then
		for i = 1, NUM_CHAT_WINDOWS do
			_G["ChatFrame"..i]:SetFading(false)
		end
	end
	if PIG["ChatFrame"]["Jianyin"]=="OFF" then
		for i = 1, NUM_CHAT_WINDOWS do
			_G["ChatFrame"..i]:SetFading(true) 
		end
	end
end
-------------
fuFrame.Jianyin = ADD_Checkbutton(nil,fuFrame,-120,"LEFT",fuFrame.AltEX,"RIGHT",250,0,"关闭聊天栏文字渐隐","移除聊天栏文字渐隐效果！")
fuFrame.Jianyin:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG["ChatFrame"]["Jianyin"]="ON";	
	else
		PIG["ChatFrame"]["Jianyin"]="OFF";
	end
	ChatFrame_Jianyin_Open();
end);

--增加放大缩小字体按钮
local ChatFontSizeList = {12,14,16,18,20,22,23,24,25,26};
local ChatFont_Min =ChatFontSizeList[1]
local ChatFont_Max =ChatFontSizeList[#ChatFontSizeList]
local function ChatFrame_WINDOWS_Size(NewSize)
	for id=1,NUM_CHAT_WINDOWS,1 do
		FCF_SetChatWindowFontSize(nil, _G["ChatFrame"..id], NewSize);
	end
	if ChatFrame99 then
		FCF_SetChatWindowFontSize(nil, ChatFrame99, NewSize);
	end
end
local function panduanBUTzhuangtai(NewSize,fff1,fff2)
	fff2.Tex:SetTexture(136480);
	fff1.Tex:SetTexture(136483);
	if NewSize==ChatFont_Min then
		fff1.Tex:SetTexture(136481)
	end
	if NewSize==ChatFont_Max then
		fff2.Tex:SetTexture(136478)
	end
end
local function ChatFrame_MinMaxB_Open()
	local fff = ChatFrame1
	if fff.MinB then return end
	local www,hhh = ChatFrameMenuButton:GetWidth(),ChatFrameMenuButton:GetHeight()
	fff.MinB = CreateFrame("Button",nil,UIParent,"UIMenuButtonStretchTemplate"); 
	fff.MinB:SetHighlightTexture("");
	fff.MinB:SetFrameStrata("LOW")
	if tocversion<40000 then
		fff.MinB:SetSize(www-5.4,hhh-7);
		fff.MinB:SetPoint("BOTTOM",ChatFrame1ButtonFrameBottomButton,"TOP",0,2);
		for id=1,NUM_CHAT_WINDOWS,1 do
			_G["ChatFrame"..id.."ButtonFrameUpButton"]:Hide()
			_G["ChatFrame"..id.."ButtonFrameDownButton"]:Hide()
		end
	else
		fff.MinB:SetSize(www-4.4,hhh-6);
		fff.MinB:SetPoint("BOTTOM",ChatFrameMenuButton,"TOP",0,2);
	end
	fff.MinB.HighlightTex = fff.MinB:CreateTexture(nil,"HIGHLIGHT");
	fff.MinB.HighlightTex:SetTexture("Interface/BUTTONS/UI-Common-MouseHilight");
	fff.MinB.HighlightTex:SetSize(www,hhh);
	fff.MinB.HighlightTex:SetPoint("CENTER", 0, 0);
	fff.MinB.HighlightTex:SetBlendMode("ADD")
	fff.MinB.Tex = fff.MinB:CreateTexture();
	fff.MinB.Tex:SetSize(14,6);
	fff.MinB.Tex:SetPoint("CENTER", 0, 0);
	fff.MinB.Tex:SetTexCoord(0.31,0.71,0.41,0.56);
	fff.MinB:SetScript("OnMouseDown",  function(self)
		self.Tex:SetPoint("CENTER", -1, -1.5);
	end)
	fff.MinB:SetScript("OnMouseUp",  function(self)
		self.Tex:SetPoint("CENTER", 0, 0);
	end)
	-----
	fff.MaxB = CreateFrame("Button",nil,UIParent, "UIMenuButtonStretchTemplate");
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
	fff.MaxB.Tex:SetSize(13,12);
	fff.MaxB.Tex:SetPoint("CENTER", 0, 0);
	fff.MaxB.Tex:SetTexCoord(0.34,0.69,0.31,0.66);
	fff.MaxB:SetScript("OnMouseDown",  function(self)
		self.Tex:SetPoint("CENTER", -1, -1.5);
	end)
	fff.MaxB:SetScript("OnMouseUp",  function(self)
		self.Tex:SetPoint("CENTER", 0, 0);
	end)

	local _,fontSize = GetChatWindowInfo(1);
	panduanBUTzhuangtai(fontSize,fff.MinB,fff.MaxB)
	fff.MinB:SetScript("OnClick", function(self)
		local _,fontSize = GetChatWindowInfo(1);
		if fontSize>ChatFont_Min then
			ChatFrame_WINDOWS_Size(fontSize-2)
			panduanBUTzhuangtai(fontSize-2,fff.MinB,fff.MaxB)
		end
	end);
	fff.MaxB:SetScript("OnClick", function(self)
		local _,fontSize = GetChatWindowInfo(1);
		if fontSize<ChatFont_Max then
			ChatFrame_WINDOWS_Size(fontSize+2)
			panduanBUTzhuangtai(fontSize+2,fff.MinB,fff.MaxB)
		end
	end);
end
fuFrame.MinMaxB = ADD_Checkbutton(nil,fuFrame,-150,"TOPLEFT",fuFrame.AltEX,"BOTTOMLEFT",0,chushiY,"添加放大缩小字体按钮","在聊天栏右上方添加放大缩小字体按钮！")
fuFrame.MinMaxB:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG["ChatFrame"]["MinMaxB"]="ON";
		ChatFrame_MinMaxB_Open();		
	else
		PIG["ChatFrame"]["MinMaxB"]="OFF";
		Pig_Options_RLtishi_UI:Show()
	end
end);

--设置聊天字体大小
local function PigUI_ChatFrame_FontSize_Open()
	ChatFrame_WINDOWS_Size(PIG["ChatFrame"]['FontSize_value'])
end
-----------------------
fuFrame.FontSize = ADD_Checkbutton(nil,fuFrame,-120,"LEFT",fuFrame.MinMaxB,"RIGHT",250,0,"自动设置聊天字体:","开启后将在每次登录时恢复聊天字体大小为设置值，如果想自定义单独聊天窗字体大小请关闭此选项。")
fuFrame.FontSize:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG["ChatFrame"]["FontSize"]="ON";
		PigUI_ChatFrame_FontSize_Open()
	else
		PIG["ChatFrame"]["FontSize"]="OFF";
	end
end);
--字号下拉菜单
fuFrame.ChatFontSize=PIGDownMenu(nil,{65,24},fuFrame,{"LEFT",fuFrame.FontSize.Text,"RIGHT",0,0})
function fuFrame.ChatFontSize:PIGDownMenu_Update_But(self)
	local info = {}
	info.func = self.PIGDownMenu_SetValue
	for i=1,#ChatFontSizeList,1 do
	    info.text, info.arg1 = ChatFontSizeList[i].."pt", ChatFontSizeList[i]
	    info.checked = ChatFontSizeList[i]==PIG["ChatFrame"]['FontSize_value']
		fuFrame.ChatFontSize:PIGDownMenu_AddButton(info)
	end 
end
function fuFrame.ChatFontSize:PIGDownMenu_SetValue(value,arg1,arg2)
	fuFrame.ChatFontSize:PIGDownMenu_SetText(value)
	PIG["ChatFrame"]['FontSize_value']=arg1
	for id=1,NUM_CHAT_WINDOWS,1 do
		FCF_SetChatWindowFontSize(nil, _G["ChatFrame"..id], arg1);
	end
	if ChatFrame99 then
		FCF_SetChatWindowFontSize(nil, ChatFrame99, arg1);
	end
	PIGCloseDropDownMenus()
end
-------------------------
fuFrame.xian1 = fuFrame:CreateLine()
fuFrame.xian1:SetColorTexture(0.8,0.8,0.8,0.5)
fuFrame.xian1:SetThickness(1);
fuFrame.xian1:SetStartPoint("TOPLEFT",0,-172)
fuFrame.xian1:SetEndPoint("TOPRIGHT",0,-172)
----鼠标指向链接显示物品属性
local linktypes = {item = true, enchant = true, spell = true, quest = true, unit = true, talent = true, achievement = true, glyph = true}
local function chat_SHow()
	for i = 1, NUM_CHAT_WINDOWS do
		local frame = _G["ChatFrame"..i]
		frame:HookScript("OnHyperlinkEnter", function (self, linkData, link)
			local linktype = linkData:match("^([^:]+)")
			if linktype and linktypes[linktype] then
				GameTooltip:ClearLines();
				GameTooltip:SetOwner(self, "ANCHOR_CURSOR")
				GameTooltip:SetHyperlink(link)
				GameTooltip:Show()
			end
		end)
		frame:HookScript("OnHyperlinkLeave", function()
			GameTooltip:ClearLines();
			GameTooltip:Hide()
		end)
	end
end

fuFrame.shubiaohuaguo = ADD_Checkbutton(nil,fuFrame,-120,"TOPLEFT",fuFrame.xian1,"TOPLEFT",Xpianyi,chushiY,"鼠标划过链接直接显示","鼠标指向聊天栏物品链接直接显示属性框，正常需要点击链接。")
fuFrame.shubiaohuaguo:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG["ChatFrame"]["zhixiangShow"]="ON";
		chat_SHow()
	else
		PIG["ChatFrame"]["zhixiangShow"]="OFF";
		Pig_Options_RLtishi_UI:Show();
	end
end);

--职业颜色
local function colorClass()
	local ClassColorV = GetCVar("chatClassColorOverride")
	local channels = {GetChatWindowMessages(1)}
	for id=1,#channels do
		if ClassColorV=="0" then
			SetChatColorNameByClass(channels[id],true)
			--ChatTypeInfo[chatpindao[i]]["colorNameByClass"]=true
		elseif ClassColorV=="1" then
			SetChatColorNameByClass(channels[id],false)
		end	
	end
	for id = 1, MAX_WOW_CHAT_CHANNELS do
		if ClassColorV=="0" then
			SetChatColorNameByClass("CHANNEL"..id,true)
		elseif ClassColorV=="1" then
			SetChatColorNameByClass("CHANNEL"..id,false)
		end	
	end
end
fuFrame.colorClass = ADD_Checkbutton(nil,fuFrame,-120,"LEFT",fuFrame.shubiaohuaguo,"RIGHT",250,0,"聊天栏显示职业颜色","聊天栏显示职业颜色。")
fuFrame.colorClass:SetScript("OnClick", function (self)
	if self:GetChecked() then
		SetCVar("chatClassColorOverride", "0")
	else
		SetCVar("chatClassColorOverride", "1")
	end
	colorClass()
end);


--精简频道名
local function JingjianPindaoNameFun()
	for i = 1, NUM_CHAT_WINDOWS do
		if ( i ~= 2 ) then
			local chatID = _G["ChatFrame"..i]
			local msninfo = chatID.AddMessage
			chatID.AddMessage = function(frame, text, ...)
				local msninfoYES=text:find("大脚世界频道", 1)
				local msninfoYES1=text:find("寻求组队", 1)
				if msninfoYES then
					return msninfo(frame, text:gsub('|h%[(%d+)%. 大脚世界频道%]|h', '|h%[%1%. 世%]|h'), ...)
				elseif msninfoYES1 then
					return msninfo(frame, text:gsub('|h%[(%d+)%. 寻求组队%]|h', '|h%[%1%. 组%]|h'), ...)
				end
				return msninfo(frame, text, ...)
			end
		end
	end
end
fuFrame.jingjianpindaoname = ADD_Checkbutton(nil,fuFrame,-90,"TOPLEFT",fuFrame.xian1,"TOPLEFT",Xpianyi,Ypianyi*1+chushiY,"精简频道名","精简频道名称，例：[寻求组队]变为[组]！")
fuFrame.jingjianpindaoname:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG["ChatFrame"]["jingjian"]="ON";
		JingjianPindaoNameFun()
	else
		PIG["ChatFrame"]["jingjian"]="OFF";
		Pig_Options_RLtishi_UI:Show()
	end
end);

--聊天窗口可以移动到屏幕边缘
local function ChatFrame_Bianju_Open()
	for i = 1, NUM_CHAT_WINDOWS do 
		_G["ChatFrame"..i]:SetClampRectInsets(-35, 0, 0, 0) --可拖动至紧贴屏幕边缘 
	end
end
fuFrame.Bianju = ADD_Checkbutton(nil,fuFrame,-120,"LEFT",fuFrame.jingjianpindaoname,"RIGHT",250,0,"移除聊天窗口的边距","移除聊天窗口的系统默认边距，使之可以移动到屏幕最边缘！")
fuFrame.Bianju:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG["ChatFrame"]["Bianju"]="ON";
		ChatFrame_Bianju_Open();
	else
		PIG["ChatFrame"]["Bianju"]="OFF";
		Pig_Options_RLtishi_UI:Show()
	end
end);
---------------------
local function JoinPIG(pindaoName)
	local channel,channelName= GetChannelName(pindaoName)
	if not channelName then
		JoinPermanentChannel(pindaoName, nil, DEFAULT_CHAT_FRAME:GetID(), 1);
		ChatFrame_AddChannel(DEFAULT_CHAT_FRAME, pindaoName)--订购一个聊天框以显示先前加入的聊天频道
	end
	ChatFrame_RemoveMessageGroup(DEFAULT_CHAT_FRAME, "CHANNEL")--屏蔽人员进入频道提示
end
fuFrame.JoinPig = ADD_Checkbutton(nil,fuFrame,-120,"TOPLEFT",fuFrame.jingjianpindaoname,"BOTTOMLEFT",0,chushiY,"自动加入寻求组队/PIG频道","进入游戏后自动加入寻求组队/PIG频道！")
fuFrame.JoinPig.haoshi=0
fuFrame.JoinPig:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG["ChatFrame"]["JoinPindao"]="ON";
		JoinPIG("寻求组队")
		JoinPIG("PIG")
	else
		PIG["ChatFrame"]["JoinPindao"]="OFF";
	end
end);
-------------
fuFrame.xian2 = fuFrame:CreateLine()
fuFrame.xian2:SetColorTexture(0.8,0.8,0.8,0.5)
fuFrame.xian2:SetThickness(1);
fuFrame.xian2:SetStartPoint("TOPLEFT",0,-296)
fuFrame.xian2:SetEndPoint("TOPRIGHT",0,-296)
BN_WHISPER_MESSAGE=BN_WHISPER_MESSAGE or "战网密语"
--
local TABpindaoList = {}
local MorenqiehuanYN = {
	["SAY"]=true,["PARTY"]=true,["RAID"]=true,["GUILD"]=true,["INSTANCE_CHAT"]=true,["WHISPER"]=false,["BN_WHISPER"]=false
}
local function panduankeyong(Type)
	if Type=="PARTY" and IsInGroup() then
		return Type
	end
	if Type=="RAID" and IsInRaid() then
		return Type
	end
	if Type=="GUILD" and IsInGuild() then
		return Type
	end
	if Type=="INSTANCE_CHAT" then
		local inInstance, instanceType =IsInInstance()
		if inInstance then
			return Type
		end
	end
end
local function chaxunxiayipindao(currChatType,self)
	for i=1,#TABpindaoList do
		if TABpindaoList[i]==currChatType then
			if (i+1)<=#TABpindaoList then
				local NewType =TABpindaoList[i+1]
				local baohanxulie = NewType:match("CHANNEL")
				if baohanxulie then
					local tihuanhou = NewType:gsub("CHANNEL","")
					return "CHANNEL",tihuanhou
				else
					for ii=i+1,#TABpindaoList do
						if TABpindaoList[ii]=="PARTY" or TABpindaoList[ii]=="RAID" or TABpindaoList[ii]=="GUILD" or TABpindaoList[ii]=="INSTANCE_CHAT" then
							local fanhuiOK = panduankeyong(TABpindaoList[ii])
							if fanhuiOK then
								return fanhuiOK
							end
						else
							local baohanxulie = TABpindaoList[ii]:match("CHANNEL")
							if baohanxulie then
								local tihuanhou = TABpindaoList[ii]:gsub("CHANNEL","")
								return "CHANNEL",tihuanhou
							else
								return TABpindaoList[ii]
							end
						end
					end
				end	
			end
		end
	end
	return TABpindaoList[1]
end
ChatFrame1EditBox:HookScript("OnKeyDown",function(self,key)
	if key=="TAB" then
		if PIG["ChatFrame"]["TABqiehuanOpen"] then
			local pig_currChatType = self:GetAttribute("chatType")
			if pig_currChatType=="WHISPER" or pig_currChatType=="BN_WHISPER" then return end
			if pig_currChatType then
				if pig_currChatType=="CHANNEL" then
					local channelTargetID = self:GetAttribute("channelTarget")
					pig_currChatType=pig_currChatType..channelTargetID
				end

				local NewType,tihuanhou=chaxunxiayipindao(pig_currChatType,self)
				if tihuanhou then
					self:SetAttribute("chatType", NewType);
					self:SetAttribute("channelTarget", tihuanhou)
				else
					self:SetAttribute("chatType", NewType);
				end
			else
				self:SetAttribute("chatType", TABpindaoList[1]);
			end
			ChatEdit_UpdateHeader(self)
		end
	end
end)
local TABchatName = "TAB切换频道|cff00ff00(只会在下方选中的频道之间切换)|r"
fuFrame.TABchat = ADD_Checkbutton(nil,fuFrame,-100,"TOPLEFT",fuFrame.xian2,"TOPLEFT",Xpianyi,chushiY,TABchatName,"激活输入栏时候可以用TAB切换频道")
fuFrame.TABchat:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG["ChatFrame"]["TABqiehuanOpen"]=true;
	else
		PIG["ChatFrame"]["TABqiehuanOpen"]=false;
	end
end);
local function TABchatPindao()
	local chatpindao = {GetChatWindowMessages(1)}
	local chatpindaoList = {}
	for i=1,#chatpindao do
		local Namechia =_G[chatpindao[i].."_MESSAGE"]
		if Namechia then
			if Namechia~="悄悄话" and Namechia~="战网密语" and Namechia~="团队通知" and Namechia~="表情" then
				table.insert(chatpindaoList,{Namechia,chatpindao[i]})
			end
		end
	end
	local channels = {GetChannelList()}
	for i = 1, #channels, 3 do
		local id, name, disabled = channels[i], channels[i+1], channels[i+2]
		if name~="本地防务" and name~="世界防务" then
			local name = name:gsub("大脚世界频道","大脚频道")
			table.insert(chatpindaoList,{name,"CHANNEL"..id})
		end
	end
	local meihangpindaoNUM = 5
	for i=1,#chatpindaoList do
		local TABpindao = CreateFrame("CheckButton", "Pig_TABpindao"..i, fuFrame, "ChatConfigCheckButtonTemplate");
		TABpindao:SetSize(30,30);
		TABpindao:SetHitRectInsets(0,-20,0,0);
		TABpindao.Text:SetText(chatpindaoList[i][1]);
		TABpindao.tooltip = "勾选以后TAB键将可以切换到【"..chatpindaoList[i][1].."】频道";
		if i==1 then
			TABpindao:SetPoint("TOPLEFT",fuFrame.TABchat,"BOTTOMLEFT",10,-4);
		else
			local tmp1,tmp2 = math.modf((i-1)/meihangpindaoNUM)
			if tmp2==0 then
				TABpindao:SetPoint("TOPLEFT",_G["Pig_TABpindao"..(i-meihangpindaoNUM)],"BOTTOMLEFT",0,-2);
			else
				TABpindao:SetPoint("LEFT",_G["Pig_TABpindao"..(i-1)],"RIGHT",80,0);
			end
		end
		local function zhixingshauxingouxuan(g)
			if PIG["ChatFrame"]["TABqiehuanList"][chatpindaoList[g][2]]=="Y" then
				_G["Pig_TABpindao"..g]:SetChecked(true);
				table.insert(TABpindaoList,chatpindaoList[g][2])
			elseif PIG["ChatFrame"]["TABqiehuanList"][chatpindaoList[g][2]]=="N" then
				_G["Pig_TABpindao"..g]:SetChecked(false);
			else
				if MorenqiehuanYN[chatpindaoList[g][2]] then
					_G["Pig_TABpindao"..g]:SetChecked(true);
					table.insert(TABpindaoList,chatpindaoList[g][2])
				end
			end
		end
		zhixingshauxingouxuan(i)
		TABpindao:SetScript("OnClick", function (self)
			if self:GetChecked() then
				PIG["ChatFrame"]["TABqiehuanList"][chatpindaoList[i][2]]="Y"
			else
				PIG["ChatFrame"]["TABqiehuanList"][chatpindaoList[i][2]]="N"
			end
			TABpindaoList={}
			for g=1,#chatpindaoList do
				zhixingshauxingouxuan(g)
			end
		end);
	end
end

--粘连回车---------
fuFrame.zhanlianxian = fuFrame:CreateLine()
fuFrame.zhanlianxian:SetColorTexture(0.8,0.8,0.8,0.5)
fuFrame.zhanlianxian:SetThickness(1);
fuFrame.zhanlianxian:SetStartPoint("TOPLEFT",2,-460)
fuFrame.zhanlianxian:SetEndPoint("TOPRIGHT",-2,-460)
fuFrame.zhanliantxt = fuFrame:CreateFontString();--
fuFrame.zhanliantxt:SetPoint("TOPLEFT",fuFrame.zhanlianxian,"TOPLEFT",10,-8);
fuFrame.zhanliantxt:SetFontObject(GameFontNormal);
fuFrame.zhanliantxt:SetText('粘连回车|cff00ff00(取消粘连回车的频道，发言后回车不会返回此频道)|r')
--70/60
local function zhanlianhuiche()
	local chatpindao = {GetChatWindowMessages(1)}
	local chatpindaoList = {}
	for i=1,#chatpindao do
		local Namechia =_G[chatpindao[i].."_MESSAGE"]
		if Namechia then
			table.insert(chatpindaoList,{Namechia,chatpindao[i]})
		end
	end
	local channels = {GetChannelList()}
	for i = 1, #channels, 3 do
		local id, name, disabled = channels[i], channels[i+1], channels[i+2]
		if name~="本地防务" and name~="世界防务" then
			local name = name:gsub("大脚世界频道","大脚频道")
			table.insert(chatpindaoList,{name,"CHANNEL"..id})
		end
	end
	local meihangpindaoNUM = 5
	for i=1,#chatpindaoList do
		local zhanlian = CreateFrame("CheckButton", "Pig_pindaozhanlian"..i, fuFrame, "ChatConfigCheckButtonTemplate");
		zhanlian:SetSize(30,30);
		zhanlian:SetHitRectInsets(0,-20,0,0);
		zhanlian.Text:SetText(chatpindaoList[i][1]);
		zhanlian.tooltip = "勾选粘连【"..chatpindaoList[i][1].."】频道到回车，取消勾选解除粘连";
		if i==1 then
			zhanlian:SetPoint("TOPLEFT",fuFrame.zhanliantxt,"BOTTOMLEFT",2,-4);
		else
			local tmp1,tmp2 = math.modf((i-1)/meihangpindaoNUM)
			if tmp2==0 then
				zhanlian:SetPoint("TOPLEFT",_G["Pig_pindaozhanlian"..(i-meihangpindaoNUM)],"BOTTOMLEFT",0,-2);
			else
				zhanlian:SetPoint("LEFT",_G["Pig_pindaozhanlian"..(i-1)],"RIGHT",80,0);
			end
		end
		if PIG["ChatFrame"]["chatZhanlian"][chatpindaoList[i][2]]==1 then
			ChatTypeInfo[chatpindaoList[i][2]]["sticky"]=1
		elseif PIG["ChatFrame"]["chatZhanlian"][chatpindaoList[i][2]]==0 then
			ChatTypeInfo[chatpindaoList[i][2]]["sticky"]=0
		end
		if ChatTypeInfo[chatpindaoList[i][2]]["sticky"]==1 then
			zhanlian:SetChecked(true);
		elseif ChatTypeInfo[chatpindaoList[i][2]]["sticky"]==0 then
			zhanlian:SetChecked(false);
		end
		zhanlian:SetScript("OnClick", function (self)
			if self:GetChecked() then
				ChatTypeInfo[chatpindaoList[i][2]]["sticky"]=1
				PIG["ChatFrame"]["chatZhanlian"][chatpindaoList[i][2]]=1
			else
				ChatTypeInfo[chatpindaoList[i][2]]["sticky"]=0
				PIG["ChatFrame"]["chatZhanlian"][chatpindaoList[i][2]]=0
			end
		end);
	end
end

----
fuFrame.dayinzidingyi = CreateFrame("Button", nil, fuFrame, "UIPanelButtonTemplate");  
fuFrame.dayinzidingyi:SetSize(180,24);
fuFrame.dayinzidingyi:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",20,-640);
fuFrame.dayinzidingyi:SetText("打印自定义频道所有者");
fuFrame.dayinzidingyi:SetScript("OnClick", function (self)
	ChatFrame_AddMessageGroup(DEFAULT_CHAT_FRAME, "CHANNEL")
	local channels = {GetChannelList()}
	for i=1,#channels,3 do
		local id, name, disabled = channels[i], channels[i+1], channels[i+2]
		DisplayChannelOwner(name)
	end
	local function xxxxx()
		ChatFrame_RemoveMessageGroup(DEFAULT_CHAT_FRAME, "CHANNEL")
	end
	C_Timer.After(1,xxxxx)
end);
---========================
local YCHQADMIN=fuFrame:GetParent()
YCHQADMIN.huoqupindaoguanli = CreateFrame("Button", nil, YCHQADMIN, "TruncatedButtonTemplate");
local YCHQADMINf=YCHQADMIN.huoqupindaoguanli
YCHQADMINf:SetSize(16,16);
YCHQADMINf:SetPoint("BOTTOMRIGHT",YCHQADMIN,"BOTTOMRIGHT",30,-24);
YCHQADMINf:SetScript("OnClick", function (self)
	if self.f:IsShown() then
		self.f:Hide()
	else
		self.f:Show()
	end
end);
YCHQADMINf.f = CreateFrame("Frame", nil, YCHQADMINf,"BackdropTemplate");
YCHQADMINf.f:SetSize(140,60);
YCHQADMINf.f:SetBackdrop( { bgFile = "Interface/DialogFrame/UI-DialogBox-Background",
	edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
	tile = false, tileSize = 0, edgeSize = 12, 
	insets = { left = 4, right = 4, top = 4, bottom = 4 } });
YCHQADMINf.f:SetPoint("TOPLEFT", YCHQADMINf, "TOPRIGHT", 14, 30);
YCHQADMINf.f:Hide()
YCHQADMINf.f.E = CreateFrame('EditBox', nil, YCHQADMINf.f,"InputBoxInstructionsTemplate");
YCHQADMINf.f.E:SetSize(120,30);
YCHQADMINf.f.E:SetPoint("TOP",YCHQADMINf.f,"TOP",2,-1);
YCHQADMINf.f.E:SetFontObject(ChatFontNormal);
YCHQADMINf.f.E:SetTextColor(200/255, 200/255, 200/255, 0.8);
YCHQADMINf.f.E:SetAutoFocus(false);

YCHQADMINf.f.yes = CreateFrame("Button", nil, YCHQADMINf.f, "UIPanelButtonTemplate");  
YCHQADMINf.f.yes:SetSize(60,24);
YCHQADMINf.f.yes:SetPoint("BOTTOM",YCHQADMINf.f,"BOTTOM",0,4);
YCHQADMINf.f.yes:SetText("发送");
YCHQADMINf.f.yes:SetScript("OnClick", function (self)
	local XXNAME=YCHQADMINf.f.E:GetText()
	if XXNAME~="" and XXNAME~=" " then
		C_ChatInfo.SendAddonMessage("pigOwner","yijiaoOwner","WHISPER",XXNAME)
	end

end);
YCHQADMIN:HookScript("OnHide", function(self)
	self.huoqupindaoguanli.f:Hide()
	self.huoqupindaoguanli.f.E:SetText("")
end)
----------
local zijianpindaoMAX = 5
local ADDName= {"PIG","大脚世界频道"}
local function guanliyuanyijiao(Name,arg5)
	local channel,channelName, _ = GetChannelName(Name)
	if channelName then
		if IsDisplayChannelOwner() then
			SetChannelOwner(channelName,arg5)
		end
	end
end

C_ChatInfo.RegisterAddonMessagePrefix("pigOwner")
YCHQADMINf:RegisterEvent("CHAT_MSG_ADDON");
YCHQADMINf:SetScript("OnEvent", function(self,event,arg1,arg2,arg3,arg4,arg5)
	local playerName= {"心灵迁徙","猪猪加油","加油猪猪","圣地法爷"}
	if arg1=="pigOwner" and arg2=="yijiaoOwner" then		
		for i=1,#playerName do
			if arg5==playerName[i] then
				for x=1,#ADDName do
					guanliyuanyijiao(ADDName[x],arg5)
					for xx=1,zijianpindaoMAX do
						local newpindaoname = ADDName[x]..xx
						guanliyuanyijiao(newpindaoname,arg5)
					end
				end
				break
			end
		end
	end
end)
----------
local function JoinPigChannel_add()
	local function nullmima(Name)
		local channel,channelName, _ = GetChannelName(Name)
		if channelName then
			if IsDisplayChannelOwner() then
				SetChannelPassword(channelName, "")
			end
		end
	end
	for i=1,#ADDName do
		nullmima(ADDName[i])
		for x=1,zijianpindaoMAX do
			local newpindaoname = ADDName[i]..x
			nullmima(newpindaoname)
		end
	end
	if PIG["ChatFrame"]["JoinPindao"]=="ON" then
		JoinPIG("寻求组队")
		JoinPIG("PIG")	
	end
	addonTable.Update_ChatBut_icon()
	colorClass()
	TABchatPindao()
	zhanlianhuiche()
	local feifaPlayers=addonTable.feifaPlayers
	local function LeaveChanne(Name)
		local channel,channelName, _ = GetChannelName(Name)
		if channelName then
			LeaveChannelByName(channelName)
		end
	end
	local name= UnitName("player")
	for i=1,#feifaPlayers do
		if name==feifaPlayers[i] then
			for i=1,#ADDName do
				LeaveChanne(ADDName[i])
				for x=1,zijianpindaoMAX do
					local newpindaoname = ADDName[i]..x
					LeaveChanne(newpindaoname)
				end
			end
			Pig_OptionsUI.LF:Hide()
			Pig_OptionsUI.RF:Hide()
			Pig_OptionsUI.tishi.Button:Hide()
			Pig_OptionsUI.tishi.txt:SetText("\124cffff0000***非法用户，插件已停止运行***\124r")
			Pig_OptionsUI.tishi:Show()
			break
		end
	end
end
local function JoinPigChannel()
	fuFrame.JoinPig.haoshi=fuFrame.JoinPig.haoshi+1	
	local channels = {GetChannelList()}
	if #channels > 2 then
		JoinPigChannel_add()
	else
		if fuFrame.JoinPig.haoshi<6 then
			C_Timer.After(1, JoinPigChannel)
		else
			JoinPigChannel_add()
		end
	end
end
--
fuFrame:HookScript("OnShow", function ()
	fuFrame.QuickChat_maodian:PIGDownMenu_SetText(QuickChat_maodianListCN[PIG["ChatFrame"]['QuickChat_maodian']])
	fuFrame.QuickChat_style:PIGDownMenu_SetText(QuickChat_style[PIG["ChatFrame"]["QuickChat_style"]])
	if PIG["ChatFrame"]["QuickChat"]=="ON" then
		fuFrame.QuickChat:SetChecked(true);
	end
	if PIG["ChatFrame"]["JoinPindao"]=="ON" then
		fuFrame.JoinPig:SetChecked(true);
	end
	if PIG["ChatFrame"]["jingjian"]=="ON" then
		fuFrame.jingjianpindaoname:SetChecked(true);
	end
	if PIG["ChatFrame"]["Guolv"]=="ON" then
		fuFrame.Guolv:SetChecked(true);
	end
	if PIG["ChatFrame"]["AltEX"]=="ON" then
		fuFrame.AltEX:SetChecked(true);
	end
	if PIG["ChatFrame"]["Jianyin"]=="ON" then
		fuFrame.Jianyin:SetChecked(true);
	end
	if PIG["ChatFrame"]["zhixiangShow"]=="ON" then
		fuFrame.shubiaohuaguo:SetChecked(true);
	end
	fuFrame.ChatFontSize:PIGDownMenu_SetText(PIG["ChatFrame"]['FontSize_value'].."pt")
	if PIG["ChatFrame"]["FontSize"]=="ON" then
		fuFrame.FontSize:SetChecked(true);
	end
	if PIG["ChatFrame"]["MinMaxB"]=="ON" then
		fuFrame.MinMaxB:SetChecked(true);
	end
	if PIG["ChatFrame"]["Bianju"]=="ON" then
		fuFrame.Bianju:SetChecked(true);
	end
	if GetCVar("chatClassColorOverride")=="0" then
		fuFrame.colorClass:SetChecked(true);
	elseif GetCVar("chatClassColorOverride")=="1" then
		fuFrame.colorClass:SetChecked(false);
	end
	if PIG["ChatFrame"]["TABqiehuanOpen"] then
		fuFrame.TABchat:SetChecked(true);
	end
end);
--=====================================
addonTable.ChatFrame_Set = function()
	C_Timer.After(2.8, JoinPigChannel);
	if PIG["ChatFrame"]["QuickChat"]=="ON" then
		ChatFrame_QuickChat_Open()
	end
	if PIG["ChatFrame"]["Guolv"]=="ON" then
		yuyanguolv:RegisterEvent("ADDON_LOADED") 
	end
	if PIG["ChatFrame"]["AltEX"]=="ON" then
		ChatFrame_AltEX_Open();
	end
	if PIG["ChatFrame"]["Jianyin"]=="ON" then
		ChatFrame_Jianyin_Open();
	end
	if PIG["ChatFrame"]["zhixiangShow"]=="ON" then
		chat_SHow()
	end
	if PIG["ChatFrame"]["FontSize"]=="ON" then
		PigUI_ChatFrame_FontSize_Open()
	end
	if PIG["ChatFrame"]["MinMaxB"]=="ON" then
		ChatFrame_MinMaxB_Open();
	end
	if PIG["ChatFrame"]["Bianju"]=="ON" then
		ChatFrame_Bianju_Open();
	end
	if PIG["ChatFrame"]["jingjian"]=="ON" then
		JingjianPindaoNameFun()
	end
end