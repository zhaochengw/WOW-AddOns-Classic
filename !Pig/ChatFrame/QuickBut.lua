local addonName, addonTable = ...;
local fuFrame=List_R_F_1_2
local gsub = _G.string.gsub
local sub = _G.string.sub
local find = _G.string.find
--/////聊天快捷按钮--------
local QuickChat_biaoqingName = {
	{"{rt1}","INTERFACE\\TARGETINGFRAME\\UI-RAIDTARGETINGICON_1"}, {"{rt2}","INTERFACE\\TARGETINGFRAME\\UI-RAIDTARGETINGICON_2"}, 
	{"{rt3}","INTERFACE\\TARGETINGFRAME\\UI-RAIDTARGETINGICON_3"}, {"{rt4}","INTERFACE\\TARGETINGFRAME\\UI-RAIDTARGETINGICON_4"}, 
	{"{rt5}","INTERFACE\\TARGETINGFRAME\\UI-RAIDTARGETINGICON_5"}, {"{rt6}","INTERFACE\\TARGETINGFRAME\\UI-RAIDTARGETINGICON_6"}, 
	{"{rt7}","INTERFACE\\TARGETINGFRAME\\UI-RAIDTARGETINGICON_7"}, {"{rt8}","INTERFACE\\TARGETINGFRAME\\UI-RAIDTARGETINGICON_8"},
	{"{天使}","Interface\\AddOns\\"..addonName.."\\ChatFrame\\icon\\angel.tga"},{"{生气}","Interface\\AddOns\\"..addonName.."\\ChatFrame\\icon\\angry.tga"},
	{"{大笑}","Interface\\AddOns\\"..addonName.."\\ChatFrame\\icon\\biglaugh.tga"},{"{鼓掌}","Interface\\AddOns\\"..addonName.."\\ChatFrame\\icon\\clap.tga"},
	{"{酷}","Interface\\AddOns\\"..addonName.."\\ChatFrame\\icon\\cool.tga"},{"{哭}","Interface\\AddOns\\"..addonName.."\\ChatFrame\\icon\\cry.tga"},
	{"{可爱}","Interface\\AddOns\\"..addonName.."\\ChatFrame\\icon\\cutie.tga"},{"{鄙视}","Interface\\AddOns\\"..addonName.."\\ChatFrame\\icon\\despise.tga"},
	{"{美梦}","Interface\\AddOns\\"..addonName.."\\ChatFrame\\icon\\dreamsmile.tga"},{"{尴尬}","Interface\\AddOns\\"..addonName.."\\ChatFrame\\icon\\embarrass.tga"},
	{"{邪恶}","Interface\\AddOns\\"..addonName.."\\ChatFrame\\icon\\evil.tga"},{"{兴奋}","Interface\\AddOns\\"..addonName.."\\ChatFrame\\icon\\excited.tga"},
	{"{晕}","Interface\\AddOns\\"..addonName.."\\ChatFrame\\icon\\faint.tga"},{"{打架}","Interface\\AddOns\\"..addonName.."\\ChatFrame\\icon\\fight.tga"},
	{"{流感}","Interface\\AddOns\\"..addonName.."\\ChatFrame\\icon\\flu.tga"},{"{呆}","Interface\\AddOns\\"..addonName.."\\ChatFrame\\icon\\freeze.tga"},
	{"{皱眉}","Interface\\AddOns\\"..addonName.."\\ChatFrame\\icon\\frown.tga"},{"{致敬}","Interface\\AddOns\\"..addonName.."\\ChatFrame\\icon\\greet.tga"},
	{"{鬼脸}","Interface\\AddOns\\"..addonName.."\\ChatFrame\\icon\\grimace.tga"},{"{龇牙}","Interface\\AddOns\\"..addonName.."\\ChatFrame\\icon\\growl.tga"},
	{"{开心}","Interface\\AddOns\\"..addonName.."\\ChatFrame\\icon\\happy.tga"},{"{心}","Interface\\AddOns\\"..addonName.."\\ChatFrame\\icon\\heart.tga"},
	{"{恐惧}","Interface\\AddOns\\"..addonName.."\\ChatFrame\\icon\\horror.tga"},{"{生病}","Interface\\AddOns\\"..addonName.."\\ChatFrame\\icon\\ill.tga"},
	{"{无辜}","Interface\\AddOns\\"..addonName.."\\ChatFrame\\icon\\Innocent.tga"},{"{功夫}","Interface\\AddOns\\"..addonName.."\\ChatFrame\\icon\\kongfu.tga"},
	{"{花痴}","Interface\\AddOns\\"..addonName.."\\ChatFrame\\icon\\love.tga"},{"{邮件}","Interface\\AddOns\\"..addonName.."\\ChatFrame\\icon\\mail.tga"},
	{"{化妆}","Interface\\AddOns\\"..addonName.."\\ChatFrame\\icon\\makeup.tga"},{"{马里奥}","Interface\\AddOns\\"..addonName.."\\ChatFrame\\icon\\mario.tga"},
	{"{沉思}","Interface\\AddOns\\"..addonName.."\\ChatFrame\\icon\\meditate.tga"},{"{可怜}","Interface\\AddOns\\"..addonName.."\\ChatFrame\\icon\\miserable.tga"},
	{"{好}","Interface\\AddOns\\"..addonName.."\\ChatFrame\\icon\\okay.tga"},{"{漂亮}","Interface\\AddOns\\"..addonName.."\\ChatFrame\\icon\\pretty.tga"},
	{"{吐}","Interface\\AddOns\\"..addonName.."\\ChatFrame\\icon\\puke.tga"},{"{握手}","Interface\\AddOns\\"..addonName.."\\ChatFrame\\icon\\shake.tga"},
	{"{喊}","Interface\\AddOns\\"..addonName.."\\ChatFrame\\icon\\shout.tga"},{"{闭嘴}","Interface\\AddOns\\"..addonName.."\\ChatFrame\\icon\\shuuuu.tga"},
	{"{害羞}","Interface\\AddOns\\"..addonName.."\\ChatFrame\\icon\\shy.tga"},{"{睡觉}","Interface\\AddOns\\"..addonName.."\\ChatFrame\\icon\\sleep.tga"},
	{"{微笑}","Interface\\AddOns\\"..addonName.."\\ChatFrame\\icon\\smile.tga"},{"{吃惊}","Interface\\AddOns\\"..addonName.."\\ChatFrame\\icon\\suprise.tga"},
	{"{失败}","Interface\\AddOns\\"..addonName.."\\ChatFrame\\icon\\surrender.tga"},{"{流汗}","Interface\\AddOns\\"..addonName.."\\ChatFrame\\icon\\sweat.tga"},
	{"{流泪}","Interface\\AddOns\\"..addonName.."\\ChatFrame\\icon\\tear.tga"},{"{悲剧}","Interface\\AddOns\\"..addonName.."\\ChatFrame\\icon\\tears.tga"},
	{"{想}","Interface\\AddOns\\"..addonName.."\\ChatFrame\\icon\\think.tga"},{"{偷笑}","Interface\\AddOns\\"..addonName.."\\ChatFrame\\icon\\Titter.tga"},
	{"{猥琐}","Interface\\AddOns\\"..addonName.."\\ChatFrame\\icon\\ugly.tga"},{"{胜利}","Interface\\AddOns\\"..addonName.."\\ChatFrame\\icon\\victory.tga"},
	{"{雷锋}","Interface\\AddOns\\"..addonName.."\\ChatFrame\\icon\\volunteer.tga"},{"{委屈}","Interface\\AddOns\\"..addonName.."\\ChatFrame\\icon\\wronged.tga"},
};
addonTable.QuickChat_biaoqingName=QuickChat_biaoqingName
---更新按钮的屏蔽状态
local zijianpindaoMAX = 8
local function Update_ChatBut_icon()
	if PIG['ChatFrame']['QuickChat']=="ON" then
		local chaozhaopindao = {
			{QuickChatFFF_UI.CHANNEL_1.X,"综合"},
			{QuickChatFFF_UI.CHANNEL_2.X,"寻求组队"},
			{QuickChatFFF_UI.CHANNEL_3.X,"PIG"},
			{QuickChatFFF_UI.CHANNEL_4.X,"大脚世界频道"},
		}
		for i=1,#chaozhaopindao do
			chaozhaopindao[i][1]:Show();
		end
		local Showchatmulu = {GetChatWindowChannels(1)}
		for i=1,#chaozhaopindao do
			for ii=1,#Showchatmulu do
				if chaozhaopindao[i][2]==Showchatmulu[ii] then
					chaozhaopindao[i][1]:Hide();
				end
				if chaozhaopindao[i][2]=="PIG" or chaozhaopindao[i][2]=="大脚世界频道" then
					for x=1,zijianpindaoMAX do
						local newpindaoname = chaozhaopindao[i][2]..x
						if Showchatmulu[ii]==newpindaoname then
							chaozhaopindao[i][1]:Hide();
							break
						end
					end
				end
			end
		end
	end
end
addonTable.Update_ChatBut_icon=Update_ChatBut_icon
local function tihuanliaotianxinxineirong(self,event,arg1,...)
	for i=1,#QuickChat_biaoqingName do
		if arg1:find(QuickChat_biaoqingName[i][1]) then
			arg1 = arg1:gsub(QuickChat_biaoqingName[i][1], "\124T" .. QuickChat_biaoqingName[i][2] .. ":" ..(PIG['ChatFrame']['FontSize_value']+2) .. "\124t");
		end
	end
	return false, arg1, ...
end
-------------
local Width,Height,jiangejuli,hangshu = 24,24,0,10;
local function ADD_chatbut(fuF,pdtype,name,chatID,Color)
	local PIGTemplate
	if PIG["ChatFrame"]["QuickChat_style"]==1 then
		PIGTemplate="TruncatedButtonTemplate"
	elseif PIG["ChatFrame"]["QuickChat_style"]==2 then
		PIGTemplate="UIMenuButtonStretchTemplate"
	end
	local ziframe = {fuF:GetChildren()}
	local chatbut = CreateFrame("Button",nil,fuF, PIGTemplate);  
	chatbut:SetSize(Width,Height);
	chatbut:SetPoint("LEFT",fuF,"LEFT",#ziframe*Width,0);
	chatbut:SetFrameStrata("LOW")
	if pdtype=="bq" then
		chatbut.Tex = chatbut:CreateTexture(nil, "BORDER");
		chatbut.Tex:SetTexture("Interface/AddOns/"..addonName.."/ChatFrame/icon/happy.tga");
		chatbut.Tex:SetPoint("CENTER",0,0);
		chatbut.Tex:SetSize(Width-10,Height-10);
			chatbut:SetScript("OnMouseDown", function (self)
			self.Tex:SetPoint("CENTER",1,-1);
		end);
		chatbut:SetScript("OnMouseUp", function (self)
			self.Tex:SetPoint("CENTER",0,0);
		end);
		chatbut:SetScript("OnClick", function(self)
			if self.F:IsShown() then
				self.F:Hide()
			else
				self.F:Show()
				self.F.xiaoshidaojishi = 1.5;
				self.F.zhengzaixianshi = true;
			end
		end);
	elseif pdtype=="Mes" or pdtype=="CHANNEL" then		
		chatbut:SetText(name);
		chatbut:SetNormalFontObject(ChatFontNormal);
		if Color then
			chatbut.Text:SetTextColor(Color[1], Color[2], Color[3], 1);
		end
		chatbut.Text:SetPoint("CENTER",chatbut,"CENTER",0.5,0.3);
		if pdtype=="Mes" then	
			chatbut:SetScript("OnClick", function()
				local editBox = ChatEdit_ChooseBoxForSend();
				local hasText = editBox:GetText()
				if editBox:HasFocus() then
					editBox:SetText("/"..chatID.." " .. hasText);
				else
					ChatEdit_ActivateChat(editBox)
					editBox:SetText("/"..chatID.." " .. hasText);
				end
			end);
		elseif pdtype=="CHANNEL" then
			chatbut:SetScript("OnEnter", function (self)
				--C_Timer.After(0.8,function()		
					GameTooltip:ClearLines();
					GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT",0,0);
					GameTooltip:SetText("|cff00FFff左键-|r|cffFFFF00加入/发言\n|cff00FFff右键-|r|cffFFFF00屏蔽频道消息|r");
					GameTooltip:Show();
					GameTooltip:FadeOut()
				--end)
			end);
			chatbut:SetScript("OnLeave", function (self)
				GameTooltip:ClearLines();
				GameTooltip:Hide() 
			end);
			chatbut:RegisterForClicks("LeftButtonUp", "RightButtonUp");
			chatbut.X = chatbut:CreateTexture(nil, "OVERLAY");
			chatbut.X:SetTexture("interface/common/voicechat-muted.blp");
			chatbut.X:SetSize(16,16);
			chatbut.X:SetAlpha(0.7);
			chatbut.X:SetPoint("CENTER",0,0);
			chatbut.X:Hide()
			chatbut:SetScript("OnClick", function(self, event)
				self.channel,self.channelName= GetChannelName(chatID)
				if not self.channelName then
					if chatID=="大脚世界频道" or chatID=="PIG" then
						for i=1,zijianpindaoMAX do
							self.channel,self.channelName= GetChannelName(chatID..i)
							if self.channelName then
								break
							end
						end
					end
				end
				local channel,channelName = self.channel,self.channelName
				--local chatFrame = SELECTED_DOCK_FRAME--当前选择聊天框架
				if event=="LeftButton" then
					if not channelName then
						JoinPermanentChannel(chatID, nil, DEFAULT_CHAT_FRAME:GetID(), 1);
						ChatFrame_AddChannel(DEFAULT_CHAT_FRAME, chatID)--订购一个聊天框以显示先前加入的聊天频道
						ChatFrame_RemoveMessageGroup(DEFAULT_CHAT_FRAME, "CHANNEL")--屏蔽人员进入频道提示
						print("|cff00FFFF!Pig:|r|cffFFFF00已加入"..chatID.."频道，右键屏蔽频道消息！|r");
					else
						ChatFrame_AddChannel(DEFAULT_CHAT_FRAME, channelName)
						local editBox = ChatEdit_ChooseBoxForSend();
						local hasText = editBox:GetText()
						if editBox:HasFocus() then
							editBox:SetText("/"..channel.." " ..hasText);
						else
							ChatEdit_ActivateChat(editBox)
							editBox:SetText("/"..channel.." " ..hasText);
						end
					end
					chatbut.X:Hide();
				else
					local pindaomulu = {GetChatWindowChannels(1)}
					for i=1,#pindaomulu do
						if pindaomulu[i]==channelName then
							ChatFrame_RemoveChannel(DEFAULT_CHAT_FRAME, channelName);
							self.X:Show();
							print("|cff00FFFF!Pig:|r|cffFFFF00已屏蔽"..channelName.."频道消息！|r");
							return
						end
					end
					ChatFrame_AddChannel(DEFAULT_CHAT_FRAME, channelName)
					self.X:Hide();
					print("|cff00FFFF!Pig:|r|cffFFFF00已解除"..channelName.."频道消息屏蔽！|r");
				end
			end);
		end
	end
	return chatbut
end
local function ChatFrame_QuickChat_Open(QuickChat_maodianList)
	if QuickChatFFF_UI==nil then
		ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL", tihuanliaotianxinxineirong)
		ChatFrame_AddMessageEventFilter("CHAT_MSG_SAY", tihuanliaotianxinxineirong)
		ChatFrame_AddMessageEventFilter("CHAT_MSG_YELL", tihuanliaotianxinxineirong)
		ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER", tihuanliaotianxinxineirong)
		ChatFrame_AddMessageEventFilter("CHAT_MSG_BN_WHISPER", tihuanliaotianxinxineirong)
		ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER_INFORM", tihuanliaotianxinxineirong)
		ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID", tihuanliaotianxinxineirong)
		ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID_LEADER", tihuanliaotianxinxineirong)
		ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID_WARNING", tihuanliaotianxinxineirong)
		ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY", tihuanliaotianxinxineirong)
		ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY_LEADER", tihuanliaotianxinxineirong)
		ChatFrame_AddMessageEventFilter("CHAT_MSG_GUILD", tihuanliaotianxinxineirong)
		ChatFrame_AddMessageEventFilter("CHAT_MSG_OFFICER", tihuanliaotianxinxineirong)
		ChatFrame_AddMessageEventFilter("CHAT_MSG_AFK", tihuanliaotianxinxineirong)
		ChatFrame_AddMessageEventFilter("CHAT_MSG_EMOTE", tihuanliaotianxinxineirong)
		ChatFrame_AddMessageEventFilter("CHAT_MSG_DND", tihuanliaotianxinxineirong)
		ChatFrame_AddMessageEventFilter("CHAT_MSG_COMMUNITIES_CHANNEL", tihuanliaotianxinxineirong)
		-----------------------
		local QuickChatFFF = CreateFrame("Frame", "QuickChatFFF_UI", UIParent);
		QuickChatFFF:SetSize(Width,Height);
		QuickChatFFF:SetPoint(QuickChat_maodianList[PIG['ChatFrame']['QuickChat_maodian']][1],ChatFrame1,QuickChat_maodianList[PIG['ChatFrame']['QuickChat_maodian']][2],QuickChat_maodianList[PIG['ChatFrame']['QuickChat_maodian']][3],QuickChat_maodianList[PIG['ChatFrame']['QuickChat_maodian']][4]);
		QuickChatFFF:SetFrameStrata("LOW")
		-------
		QuickChatFFF.biaoqing = ADD_chatbut(QuickChatFFF,"bq")

		QuickChatFFF.biaoqing.F = CreateFrame("Frame", nil, QuickChatFFF.biaoqing,"BackdropTemplate");
		QuickChatFFF.biaoqing.F:SetBackdrop( { 
			bgFile = "Interface/Tooltips/UI-Tooltip-Background",tile = false, tileSize = 0,
			edgeFile = "Interface/Tooltips/UI-Tooltip-Border",edgeSize = 8, 
			insets = { left = 2, right = 2, top = 2, bottom = 2 }});
		QuickChatFFF.biaoqing.F:SetBackdropBorderColor(0.5, 0.5, 0.5, 0.8);
		QuickChatFFF.biaoqing.F:SetBackdropColor(0.5, 0.5, 0.5, 0.8);
		QuickChatFFF.biaoqing.F:SetSize((Width+2)*hangshu+10,Height*6+20);
		QuickChatFFF.biaoqing.F:SetPoint("BOTTOMLEFT",QuickChatFFF.biaoqing,"TOPLEFT", 0, 0);
		QuickChatFFF.biaoqing.F:Hide()
		QuickChatFFF.biaoqing.F:SetFrameStrata("HIGH")
		QuickChatFFF.biaoqing.F.xiaoshidaojishi = 0;
		QuickChatFFF.biaoqing.F.zhengzaixianshi = nil;

		QuickChatFFF.biaoqing.F:SetScript("OnUpdate", function(self, ssss)
			if QuickChatFFF.biaoqing.F.zhengzaixianshi==nil then
				return;
			else
				if QuickChatFFF.biaoqing.F.zhengzaixianshi==true then
					if QuickChatFFF.biaoqing.F.xiaoshidaojishi<= 0 then
						QuickChatFFF.biaoqing.F:Hide();
						QuickChatFFF.biaoqing.F.zhengzaixianshi = nil;
					else
						QuickChatFFF.biaoqing.F.xiaoshidaojishi = QuickChatFFF.biaoqing.F.xiaoshidaojishi - ssss;	
					end
				end
			end

		end)
		QuickChatFFF.biaoqing.F:SetScript("OnEnter", function()
			QuickChatFFF.biaoqing.F.zhengzaixianshi = nil;
		end)
		QuickChatFFF.biaoqing.F:SetScript("OnLeave", function()
			QuickChatFFF.biaoqing.F.xiaoshidaojishi = 1.5;
			QuickChatFFF.biaoqing.F.zhengzaixianshi = true;
		end)

		for i=1,#QuickChat_biaoqingName do
			QuickChatFFF.biaoqing.F.list = CreateFrame("Button","biaoqing_list"..i.."_UI",QuickChatFFF.biaoqing.F,nil,i);
			QuickChatFFF.biaoqing.F.list:SetSize(Width,Height);
			if i==1 then
				QuickChatFFF.biaoqing.F.list:SetPoint("TOPLEFT",QuickChatFFF.biaoqing.F,"TOPLEFT", 5, -5);
			elseif i<hangshu+1 then
				QuickChatFFF.biaoqing.F.list:SetPoint("LEFT",_G["biaoqing_list"..(i-1).."_UI"],"RIGHT", 2, 0);
			elseif i==hangshu+1 then
				QuickChatFFF.biaoqing.F.list:SetPoint("TOPLEFT",_G["biaoqing_list1_UI"],"BOTTOMLEFT", 0, -2);
			elseif i<hangshu*2+1 then
				QuickChatFFF.biaoqing.F.list:SetPoint("LEFT",_G["biaoqing_list"..(i-1).."_UI"],"RIGHT", 2, 0);
			elseif i==hangshu*2+1 then
				QuickChatFFF.biaoqing.F.list:SetPoint("TOPLEFT",_G["biaoqing_list11_UI"],"BOTTOMLEFT", 0, -2);
			elseif i<hangshu*3+1 then
				QuickChatFFF.biaoqing.F.list:SetPoint("LEFT",_G["biaoqing_list"..(i-1).."_UI"],"RIGHT", 2, 0);
			elseif i==hangshu*3+1 then
				QuickChatFFF.biaoqing.F.list:SetPoint("TOPLEFT",_G["biaoqing_list21_UI"],"BOTTOMLEFT", 0, -2);
			elseif i<hangshu*4+1 then
				QuickChatFFF.biaoqing.F.list:SetPoint("LEFT",_G["biaoqing_list"..(i-1).."_UI"],"RIGHT", 2, 0);
			elseif i==hangshu*4+1 then
				QuickChatFFF.biaoqing.F.list:SetPoint("TOPLEFT",_G["biaoqing_list31_UI"],"BOTTOMLEFT", 0, -2);
			elseif i<hangshu*5+1 then
				QuickChatFFF.biaoqing.F.list:SetPoint("LEFT",_G["biaoqing_list"..(i-1).."_UI"],"RIGHT", 2, 0);
			elseif i==hangshu*5+1 then
				QuickChatFFF.biaoqing.F.list:SetPoint("TOPLEFT",_G["biaoqing_list41_UI"],"BOTTOMLEFT", 0, -2);
			elseif i<hangshu*6+1 then
				QuickChatFFF.biaoqing.F.list:SetPoint("LEFT",_G["biaoqing_list"..(i-1).."_UI"],"RIGHT", 2, 0);
			end
			QuickChatFFF.biaoqing.F.list.Tex = QuickChatFFF.biaoqing.F.list:CreateTexture();
			QuickChatFFF.biaoqing.F.list.Tex:SetTexture(QuickChat_biaoqingName[i][2]);
			QuickChatFFF.biaoqing.F.list.Tex:SetPoint("CENTER",0,0);
			QuickChatFFF.biaoqing.F.list.Tex:SetSize(Width,Height);
			QuickChatFFF.biaoqing.F.list:SetScript("OnEnter", function()
				QuickChatFFF.biaoqing.F.zhengzaixianshi=nil
			end)
			QuickChatFFF.biaoqing.F.list:SetScript("OnLeave", function()
				QuickChatFFF.biaoqing.F.xiaoshidaojishi = 1.5;
				QuickChatFFF.biaoqing.F.zhengzaixianshi = true;
			end)
			QuickChatFFF.biaoqing.F.list:SetScript("OnClick", function(self)
				local editBox = ChatEdit_ChooseBoxForSend();
				local hasText = editBox:GetText()..QuickChat_biaoqingName[self:GetID()][1]
				if editBox:HasFocus() then
					editBox:SetText(hasText);
				else
					ChatEdit_ActivateChat(editBox)
					editBox:SetText(hasText);
				end
				QuickChatFFF.biaoqing.F:Hide();
			end)

		end
		--说--
		QuickChatFFF.SAY = ADD_chatbut(QuickChatFFF,"Mes","说","s")
		--喊--
		QuickChatFFF.YALL = ADD_chatbut(QuickChatFFF,"Mes","喊","y",{1, 64/255, 64/255})
		--队伍--
		QuickChatFFF.PARTY = ADD_chatbut(QuickChatFFF,"Mes","队","p",{170/255, 170/255, 1})
		--公会--
		QuickChatFFF.GUILD = ADD_chatbut(QuickChatFFF,"Mes","会","g",{64/255, 1, 64/255})
		--团队--
		QuickChatFFF.RAID = ADD_chatbut(QuickChatFFF,"Mes","团","ra",{1, 127/255, 0})
		--团队通知--
		QuickChatFFF.RAID_WARNING = ADD_chatbut(QuickChatFFF,"Mes","通","rw",{1, 72/255, 0})
		--战场--
		QuickChatFFF.BATTLEGROUND = ADD_chatbut(QuickChatFFF,"Mes","战","bg",{1, 127/255, 0})
		--CHANNEL--
		QuickChatFFF.CHANNEL_1 = ADD_chatbut(QuickChatFFF,"CHANNEL","综","综合",{0.888, 0.668, 0.668})
		QuickChatFFF.CHANNEL_2 = ADD_chatbut(QuickChatFFF,"CHANNEL","组","寻求组队",{0.888, 0.668, 0.668})
		QuickChatFFF.CHANNEL_3 = ADD_chatbut(QuickChatFFF,"CHANNEL","P","PIG",{102/255,1,204/255})
		QuickChatFFF.CHANNEL_4 = ADD_chatbut(QuickChatFFF,"CHANNEL","世","大脚世界频道",{0.888, 0.668, 0.668})
		---下移输入框=======
		if PIG['ChatFrame']['QuickChat_maodian']==1 then
			ChatFrame1EditBox:ClearAllPoints();
			ChatFrame1EditBox:SetPoint("BOTTOMLEFT",ChatFrame1,"TOPLEFT",-5,-0);
			ChatFrame1EditBox:SetPoint("BOTTOMRIGHT",ChatFrame1,"TOPRIGHT",5,-0);
		elseif PIG['ChatFrame']['QuickChat_maodian']==2 then
			ChatFrame1EditBox:ClearAllPoints();
			ChatFrame1EditBox:SetPoint("TOPLEFT",ChatFrame1,"BOTTOMLEFT",-5,-23);
			ChatFrame1EditBox:SetPoint("TOPRIGHT",ChatFrame1,"BOTTOMRIGHT",5,-23);
		end
		--
		addonTable.ADD_QuickBut_Jilu()
		addonTable.ADD_QuickBut_Keyword()
		addonTable.ADD_QuickBut_Roll()
		addonTable.ADD_QuickBut_jiuwei()
		Update_ChatBut_icon()
	end
end
addonTable.ChatFrame_QuickChat_Open = ChatFrame_QuickChat_Open