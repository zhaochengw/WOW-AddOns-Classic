local addonName, addonTable = ...;
local fuFrame=List_R_F_1_2
local gsub = _G.string.gsub
local sub = _G.string.sub
local find = _G.string.find
--/////聊天快捷按钮--------
local ADD_Checkbutton=addonTable.ADD_Checkbutton
--
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
local function Update_ChatBut_icon()
	if PIG['ChatFrame']['QuickChat']=="ON" then
		local chaozhaopindao = {"综合","寻求组队","PIG","大脚世界频道"}
		local chaozhaopindaoName = {QuickChatFFF_UI.CHANNEL_1.X,QuickChatFFF_UI.CHANNEL_2.X,QuickChatFFF_UI.CHANNEL_3.X,QuickChatFFF_UI.CHANNEL_4.X}
		local pindaomulu = {GetChatWindowChannels(1)}
		for ii=1,#chaozhaopindao do
			chaozhaopindaoName[ii]:Show();
		end
		for i=1,#pindaomulu do
			for ii=1,#chaozhaopindao do
				if pindaomulu[i]==chaozhaopindao[ii] then
					chaozhaopindaoName[ii]:Hide();
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
local Width,Height,jiangejuli = 24,24,0;
local WidthB,HeightB,hangshu = 24,24,10;
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
		QuickChatFFF.biankuang="UIMenuButtonStretchTemplate"
		if PIG['ChatFrame']['wubiankuang']=="ON" then
			QuickChatFFF.biankuang="TruncatedButtonTemplate"
		end
		QuickChatFFF.biaoqing = CreateFrame("Button",nil,QuickChatFFF, QuickChatFFF.biankuang);  
		QuickChatFFF.biaoqing:SetSize(Width,Height);
		QuickChatFFF.biaoqing:SetPoint("LEFT",QuickChatFFF,"LEFT",0,0);
		QuickChatFFF.biaoqing.Tex = QuickChatFFF.biaoqing:CreateTexture(nil, "BORDER");
		QuickChatFFF.biaoqing.Tex:SetTexture("Interface/AddOns/"..addonName.."/ChatFrame/icon/happy.tga");
		QuickChatFFF.biaoqing.Tex:SetPoint("CENTER",0,0);
		QuickChatFFF.biaoqing.Tex:SetSize(Width-10,Height-10);
		QuickChatFFF.biaoqing:SetScript("OnMouseDown", function (self)
			self.Tex:SetPoint("CENTER",1,-1);
		end);
		QuickChatFFF.biaoqing:SetScript("OnMouseUp", function (self)
			self.Tex:SetPoint("CENTER",0,0);
		end);

		local biaoqingFrame = CreateFrame("Frame", "biaoqingFrame_UI", UIParent,"BackdropTemplate");
		biaoqingFrame:SetBackdrop( { bgFile = "Interface/Tooltips/UI-Tooltip-Background",
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
		tile = false, tileSize = 0, edgeSize = 12, 
		insets = { left = 2, right = 2, top = 2, bottom = 2 } });
		biaoqingFrame:SetBackdropColor(0, 0, 0, 0.6);
		biaoqingFrame:SetSize((WidthB+2)*hangshu+10,HeightB*6+20);
		biaoqingFrame:SetPoint("BOTTOMLEFT",QuickChatFFF.biaoqing,"TOPLEFT", 0, 0);
		biaoqingFrame:Hide()
		biaoqingFrame:SetFrameStrata("HIGH")
		biaoqingFrame.xiaoshidaojishi = 0;
		biaoqingFrame.zhengzaixianshi = nil;
		QuickChatFFF.biaoqing:SetScript("OnClick", function()
			if biaoqingFrame:IsShown() then
				biaoqingFrame:Hide()
			else
				biaoqingFrame:Show()
				biaoqingFrame.xiaoshidaojishi = 1.5;
				biaoqingFrame.zhengzaixianshi = true;
			end
		end);
		biaoqingFrame:SetScript("OnUpdate", function(self, ssss)
			if biaoqingFrame.zhengzaixianshi==nil then
				return;
			else
				if biaoqingFrame.zhengzaixianshi==true then
					if biaoqingFrame.xiaoshidaojishi<= 0 then
						biaoqingFrame:Hide();
						biaoqingFrame.zhengzaixianshi = nil;
					else
						biaoqingFrame.xiaoshidaojishi = biaoqingFrame.xiaoshidaojishi - ssss;	
					end
				end
			end

		end)
		biaoqingFrame:SetScript("OnEnter", function()
			biaoqingFrame.zhengzaixianshi = nil;
		end)
		biaoqingFrame:SetScript("OnLeave", function()
			biaoqingFrame.xiaoshidaojishi = 1.5;
			biaoqingFrame.zhengzaixianshi = true;
		end)

		for i=1,#QuickChat_biaoqingName do
			biaoqingFrame.list = CreateFrame("Button","biaoqing_list"..i.."_UI",biaoqingFrame,nil,i);
			biaoqingFrame.list:SetSize(WidthB,HeightB);
			if i==1 then
				biaoqingFrame.list:SetPoint("TOPLEFT",biaoqingFrame,"TOPLEFT", 5, -5);
			elseif i<hangshu+1 then
				biaoqingFrame.list:SetPoint("LEFT",_G["biaoqing_list"..(i-1).."_UI"],"RIGHT", 2, 0);
			elseif i==hangshu+1 then
				biaoqingFrame.list:SetPoint("TOPLEFT",_G["biaoqing_list1_UI"],"BOTTOMLEFT", 0, -2);
			elseif i<hangshu*2+1 then
				biaoqingFrame.list:SetPoint("LEFT",_G["biaoqing_list"..(i-1).."_UI"],"RIGHT", 2, 0);
			elseif i==hangshu*2+1 then
				biaoqingFrame.list:SetPoint("TOPLEFT",_G["biaoqing_list11_UI"],"BOTTOMLEFT", 0, -2);
			elseif i<hangshu*3+1 then
				biaoqingFrame.list:SetPoint("LEFT",_G["biaoqing_list"..(i-1).."_UI"],"RIGHT", 2, 0);
			elseif i==hangshu*3+1 then
				biaoqingFrame.list:SetPoint("TOPLEFT",_G["biaoqing_list21_UI"],"BOTTOMLEFT", 0, -2);
			elseif i<hangshu*4+1 then
				biaoqingFrame.list:SetPoint("LEFT",_G["biaoqing_list"..(i-1).."_UI"],"RIGHT", 2, 0);
			elseif i==hangshu*4+1 then
				biaoqingFrame.list:SetPoint("TOPLEFT",_G["biaoqing_list31_UI"],"BOTTOMLEFT", 0, -2);
			elseif i<hangshu*5+1 then
				biaoqingFrame.list:SetPoint("LEFT",_G["biaoqing_list"..(i-1).."_UI"],"RIGHT", 2, 0);
			elseif i==hangshu*5+1 then
				biaoqingFrame.list:SetPoint("TOPLEFT",_G["biaoqing_list41_UI"],"BOTTOMLEFT", 0, -2);
			elseif i<hangshu*6+1 then
				biaoqingFrame.list:SetPoint("LEFT",_G["biaoqing_list"..(i-1).."_UI"],"RIGHT", 2, 0);
			end
			biaoqingFrame.list.Tex = biaoqingFrame.list:CreateTexture("biaoqing_list_Tex"..i.."_UI", "BORDER");
			biaoqingFrame.list.Tex:SetTexture(QuickChat_biaoqingName[i][2]);
			biaoqingFrame.list.Tex:SetPoint("CENTER",0,0);
			biaoqingFrame.list.Tex:SetSize(WidthB,HeightB);
			biaoqingFrame.list:SetScript("OnClick", function(self)
				local editBox = ChatEdit_ChooseBoxForSend();
				local hasText = editBox:GetText()..QuickChat_biaoqingName[self:GetID()][1]
				if editBox:HasFocus() then
					editBox:SetText(hasText);
				else
					ChatEdit_ActivateChat(editBox)
					editBox:SetText(hasText);
				end
				biaoqingFrame:Hide();
			end)
			_G["biaoqing_list"..i.."_UI"]:SetScript("OnEnter", function()
				biaoqingFrame.zhengzaixianshi=nil
			end)
			_G["biaoqing_list"..i.."_UI"]:SetScript("OnLeave", function()
				biaoqingFrame.xiaoshidaojishi = 1.5;
				biaoqingFrame.zhengzaixianshi = true;
			end)
		end
		--说--
		QuickChatFFF.SAY = CreateFrame("Button",nil,QuickChatFFF, QuickChatFFF.biankuang);  
		QuickChatFFF.SAY:SetSize(Width,Height);
		QuickChatFFF.SAY:SetPoint("LEFT",QuickChatFFF.biaoqing,"RIGHT",jiangejuli,0);
		QuickChatFFF.SAY:SetText("说");
		QuickChatFFF.SAY:SetFrameStrata("LOW")
		QuickChatFFF.SAY:SetNormalFontObject(ChatFontNormal);
		QuickChatFFF.SAY.Text:SetPoint("CENTER",QuickChatFFF.SAY,"CENTER",0.5,0.3);
		QuickChatFFF.SAY:SetScript("OnClick", function()
			local editBox = ChatEdit_ChooseBoxForSend();
			local hasText = editBox:GetText()
			if editBox:HasFocus() then
				editBox:SetText("/s " .. hasText);
			else
				ChatEdit_ActivateChat(editBox)
				editBox:SetText("/s " .. hasText);
			end
		end);
		--喊--
		QuickChatFFF.YALL = CreateFrame("Button",nil,QuickChatFFF, QuickChatFFF.biankuang);  
		QuickChatFFF.YALL:SetSize(Width,Height);
		QuickChatFFF.YALL:SetPoint("LEFT",QuickChatFFF.SAY,"RIGHT",jiangejuli,0);
		QuickChatFFF.YALL:SetText("喊");
		QuickChatFFF.YALL:SetFrameStrata("LOW")
		QuickChatFFF.YALL:SetNormalFontObject(ChatFontNormal);
		QuickChatFFF.YALL.Text:SetTextColor(1, 64/255, 64/255, 1.0);
		QuickChatFFF.YALL.Text:SetPoint("CENTER",QuickChatFFF.YALL,"CENTER",0.5,0.3);
		QuickChatFFF.YALL:SetScript("OnClick", function()
			local editBox = ChatEdit_ChooseBoxForSend();
			local hasText = editBox:GetText()
			if editBox:HasFocus() then
				editBox:SetText("/y " .. hasText);
			else
				ChatEdit_ActivateChat(editBox)
				editBox:SetText("/y " .. hasText);
			end
		end);
		--队伍--
		QuickChatFFF.PARTY = CreateFrame("Button",nil,QuickChatFFF, QuickChatFFF.biankuang);  
		QuickChatFFF.PARTY:SetSize(Width,Height);
		QuickChatFFF.PARTY:SetPoint("LEFT",QuickChatFFF.YALL,"RIGHT",jiangejuli,0);
		QuickChatFFF.PARTY:SetText("队");
		QuickChatFFF.PARTY:SetFrameStrata("LOW")
		QuickChatFFF.PARTY:SetNormalFontObject(ChatFontNormal);
		QuickChatFFF.PARTY.Text:SetTextColor(170/255, 170/255, 1, 1);
		QuickChatFFF.PARTY.Text:SetPoint("CENTER",QuickChatFFF.PARTY,"CENTER",0.7,0.3);
		QuickChatFFF.PARTY:SetScript("OnClick", function()
			local editBox = ChatEdit_ChooseBoxForSend();
			local hasText = editBox:GetText()
			if editBox:HasFocus() then
				editBox:SetText("/p " .. hasText);
			else
				ChatEdit_ActivateChat(editBox)
				editBox:SetText("/p " .. hasText);
			end
		end);
		--公会--
		QuickChatFFF.GUILD = CreateFrame("Button",nil,QuickChatFFF, QuickChatFFF.biankuang);  
		QuickChatFFF.GUILD:SetSize(Width,Height);
		QuickChatFFF.GUILD:SetPoint("LEFT",QuickChatFFF.PARTY,"RIGHT",jiangejuli,0);
		QuickChatFFF.GUILD:SetText("会");
		QuickChatFFF.GUILD:SetFrameStrata("LOW")
		QuickChatFFF.GUILD:SetNormalFontObject(ChatFontNormal);
		QuickChatFFF.GUILD.Text:SetTextColor(64/255, 1, 64/255, 1.0);
		QuickChatFFF.GUILD.Text:SetPoint("CENTER",QuickChatFFF.GUILD,"CENTER",0.5,0.3);
		QuickChatFFF.GUILD:SetScript("OnClick", function()
			local editBox = ChatEdit_ChooseBoxForSend();
			local hasText = editBox:GetText()
			if editBox:HasFocus() then
				editBox:SetText("/g " .. hasText);
			else
				ChatEdit_ActivateChat(editBox)
				editBox:SetText("/g " .. hasText);
			end
		end);
		--团队--
		QuickChatFFF.RAID = CreateFrame("Button",nil,QuickChatFFF, QuickChatFFF.biankuang);  
		QuickChatFFF.RAID:SetSize(Width,Height);
		QuickChatFFF.RAID:SetPoint("LEFT",QuickChatFFF.GUILD,"RIGHT",jiangejuli,0);
		QuickChatFFF.RAID:SetText("团");
		QuickChatFFF.RAID:SetFrameStrata("LOW")
		QuickChatFFF.RAID:SetNormalFontObject(ChatFontNormal);
		QuickChatFFF.RAID.Text:SetTextColor(1, 127/255, 0, 1);
		QuickChatFFF.RAID.Text:SetPoint("CENTER",QuickChatFFF.RAID,"CENTER",0.3,0.3);
		QuickChatFFF.RAID:SetScript("OnClick", function()
			local editBox = ChatEdit_ChooseBoxForSend();
			local hasText = editBox:GetText()
			if editBox:HasFocus() then
				editBox:SetText("/ra " .. hasText);
			else
				ChatEdit_ActivateChat(editBox)
				editBox:SetText("/ra " .. hasText);
			end
		end);
		--团队通知--
		QuickChatFFF.RAID_WARNING = CreateFrame("Button",nil,QuickChatFFF, QuickChatFFF.biankuang);  
		QuickChatFFF.RAID_WARNING:SetSize(Width,Height);
		QuickChatFFF.RAID_WARNING:SetPoint("LEFT",QuickChatFFF.RAID,"RIGHT",jiangejuli,0);
		QuickChatFFF.RAID_WARNING:SetText("通");
		QuickChatFFF.RAID_WARNING:SetFrameStrata("LOW")
		QuickChatFFF.RAID_WARNING:SetNormalFontObject(ChatFontNormal);
		QuickChatFFF.RAID_WARNING.Text:SetTextColor(1, 72/255, 0, 1.0);
		QuickChatFFF.RAID_WARNING.Text:SetPoint("CENTER",QuickChatFFF.RAID_WARNING,"CENTER",0.6,0.3);
		QuickChatFFF.RAID_WARNING:RegisterForClicks("LeftButtonUp", "RightButtonUp");
		QuickChatFFF.RAID_WARNING:SetScript("OnClick", function()
			local editBox = ChatEdit_ChooseBoxForSend();
			local hasText = editBox:GetText()
			if editBox:HasFocus() then
				editBox:SetText("/rw " .. hasText);
			else
				ChatEdit_ActivateChat(editBox)
				editBox:SetText("/rw " .. hasText);
			end
		end);
		--战场--
		QuickChatFFF.BATTLEGROUND = CreateFrame("Button",nil,QuickChatFFF, QuickChatFFF.biankuang);  
		QuickChatFFF.BATTLEGROUND:SetSize(Width,Height);
		QuickChatFFF.BATTLEGROUND:SetPoint("LEFT",QuickChatFFF.RAID_WARNING,"RIGHT",jiangejuli,0);
		QuickChatFFF.BATTLEGROUND:SetText("战");
		QuickChatFFF.BATTLEGROUND:SetFrameStrata("LOW")
		QuickChatFFF.BATTLEGROUND:SetNormalFontObject(ChatFontNormal);
		QuickChatFFF.BATTLEGROUND.Text:SetTextColor(1, 127/255, 0, 1);
		QuickChatFFF.BATTLEGROUND.Text:SetPoint("CENTER",QuickChatFFF.BATTLEGROUND,"CENTER",0.5,0.3);
		QuickChatFFF.BATTLEGROUND:RegisterForClicks("LeftButtonUp", "RightButtonUp");
		QuickChatFFF.BATTLEGROUND:SetScript("OnClick", function()
			local editBox = ChatEdit_ChooseBoxForSend();
			local hasText = editBox:GetText()
			if editBox:HasFocus() then
				editBox:SetText("/bg " .. hasText);
			else
				ChatEdit_ActivateChat(editBox)
				editBox:SetText("/bg " .. hasText);			
			end
		end);
		---------------------------编号频道---------------------------------
		--综合--
		QuickChatFFF.CHANNEL_1 = CreateFrame("Button",nil,QuickChatFFF, QuickChatFFF.biankuang);  
		QuickChatFFF.CHANNEL_1:SetSize(Width,Height);
		QuickChatFFF.CHANNEL_1:SetPoint("LEFT",QuickChatFFF.BATTLEGROUND,"RIGHT",jiangejuli+4,0);
		QuickChatFFF.CHANNEL_1:SetText("综");
		QuickChatFFF.CHANNEL_1:SetFrameStrata("LOW")
		QuickChatFFF.CHANNEL_1:SetNormalFontObject(ChatFontNormal);
		QuickChatFFF.CHANNEL_1.Text:SetTextColor(0.888, 0.668, 0.668, 1.0);
		QuickChatFFF.CHANNEL_1.Text:SetPoint("CENTER",QuickChatFFF.CHANNEL_1,"CENTER",0.5,0.3);
		QuickChatFFF.CHANNEL_1:RegisterForClicks("LeftButtonUp", "RightButtonUp");
		QuickChatFFF.CHANNEL_1.X = QuickChatFFF.CHANNEL_1:CreateTexture(nil, "OVERLAY");
		QuickChatFFF.CHANNEL_1.X:SetTexture("interface/common/voicechat-muted.blp");
		QuickChatFFF.CHANNEL_1.X:SetSize(16,16);
		QuickChatFFF.CHANNEL_1.X:SetAlpha(0.6);
		QuickChatFFF.CHANNEL_1.X:SetPoint("CENTER",0,0);
		QuickChatFFF.CHANNEL_1.X:Hide()
		QuickChatFFF.CHANNEL_1:SetScript("OnClick", function(self, event)
			local ADDName= "综合"
			local channel,channelName, _ = GetChannelName(ADDName)
			--local chatFrame = SELECTED_DOCK_FRAME--当前选择聊天框架
			local chatFrame = DEFAULT_CHAT_FRAME--默认聊天框架
			if event=="LeftButton" then
				if channelName == nil then
					JoinPermanentChannel(ADDName, nil, chatFrame:GetID(), 1);
					ChatFrame_AddChannel(chatFrame, ADDName)--订购一个聊天框以显示先前加入的聊天频道
					ChatFrame_RemoveMessageGroup(chatFrame, "CHANNEL")--屏蔽人员进入频道提示
					print("|cff00FFFF!Pig:|r|cffFFFF00已加入"..ADDName.."频道，右键屏蔽频道消息！|r");
				else
					ChatFrame_AddChannel(chatFrame, ADDName)
					local editBox = ChatEdit_ChooseBoxForSend();
					local hasText = editBox:GetText()
					if editBox:HasFocus() then
						editBox:SetText("/"..channel.." " ..hasText);
					else
						ChatEdit_ActivateChat(editBox)
						editBox:SetText("/"..channel.." " ..hasText);
					end
				end
				QuickChatFFF.CHANNEL_1.X:Hide();
			end
			if event=="RightButton" then
				local pindaomulu = {GetChatWindowChannels(1)}
				for i=1,#pindaomulu do
					if pindaomulu[i]==ADDName then
						ChatFrame_RemoveChannel(chatFrame, ADDName);
						self.X:Show();
						print("|cff00FFFF!Pig:|r|cffFFFF00已屏蔽"..ADDName.."频道消息！|r");
						return
					end
				end
				local pindaomulu = {GetChatWindowChannels(1)}
				for i=1,#pindaomulu do
					if pindaomulu[i]==ADDName then
						ChatFrame_RemoveChannel(chatFrame, ADDName);
						self.X:Show();
						print("|cff00FFFF!Pig:|r|cffFFFF00已屏蔽"..ADDName.."频道消息！|r");
						return
					end
				end
				ChatFrame_AddChannel(chatFrame, ADDName)
				self.X:Hide();
				print("|cff00FFFF!Pig:|r|cffFFFF00已解除"..ADDName.."频道消息屏蔽！|r");
			end
		end);
		--寻求组队--
		QuickChatFFF.CHANNEL_2 = CreateFrame("Button",nil,QuickChatFFF, QuickChatFFF.biankuang);  
		QuickChatFFF.CHANNEL_2:SetSize(Width,Height);
		QuickChatFFF.CHANNEL_2:SetPoint("LEFT",QuickChatFFF.CHANNEL_1,"RIGHT",jiangejuli,0);
		QuickChatFFF.CHANNEL_2:SetText("组");
		QuickChatFFF.CHANNEL_2:SetFrameStrata("LOW")
		QuickChatFFF.CHANNEL_2:SetNormalFontObject(ChatFontNormal);
		QuickChatFFF.CHANNEL_2.Text:SetTextColor(0.888, 0.668, 0.668, 1.0);
		QuickChatFFF.CHANNEL_2.Text:SetPoint("CENTER",QuickChatFFF.CHANNEL_2,"CENTER",0.8,0.3);
		QuickChatFFF.CHANNEL_2:RegisterForClicks("LeftButtonUp", "RightButtonUp");
		QuickChatFFF.CHANNEL_2.X = QuickChatFFF.CHANNEL_2:CreateTexture(nil, "OVERLAY");
		QuickChatFFF.CHANNEL_2.X:SetTexture("interface/common/voicechat-muted.blp");
		QuickChatFFF.CHANNEL_2.X:SetSize(16,16);
		QuickChatFFF.CHANNEL_2.X:SetAlpha(0.6);
		QuickChatFFF.CHANNEL_2.X:SetPoint("CENTER",0,0);
		QuickChatFFF.CHANNEL_2.X:Hide()
		QuickChatFFF.CHANNEL_2:SetScript("OnClick", function(self, event)
			local ADDName= "寻求组队"
			local channel,channelName, _ = GetChannelName(ADDName)
			--local chatFrame = SELECTED_DOCK_FRAME--当前选择聊天框架
			local chatFrame = DEFAULT_CHAT_FRAME--默认聊天框架
			if event=="LeftButton" then
				if channelName == nil then
					JoinPermanentChannel(ADDName, nil, chatFrame:GetID(), 1);
					ChatFrame_AddChannel(chatFrame, ADDName)--订购一个聊天框以显示先前加入的聊天频道
					ChatFrame_RemoveMessageGroup(chatFrame, "CHANNEL")--屏蔽人员进入频道提示
					print("|cff00FFFF!Pig:|r|cffFFFF00已加入"..ADDName.."频道，右键屏蔽频道消息！|r");
				else
					ChatFrame_AddChannel(chatFrame, ADDName)
					local editBox = ChatEdit_ChooseBoxForSend();
					local hasText = editBox:GetText()
					if editBox:HasFocus() then
						editBox:SetText("/"..channel.." " ..hasText);
					else
						ChatEdit_ActivateChat(editBox)
						editBox:SetText("/"..channel.." " ..hasText);
					end
				end
				QuickChatFFF.CHANNEL_2.X:Hide();
			end
			if event=="RightButton" then
				local pindaomulu = {GetChatWindowChannels(1)}
				for i=1,#pindaomulu do
					if pindaomulu[i]==ADDName then
						ChatFrame_RemoveChannel(chatFrame, ADDName);
						self.X:Show();
						print("|cff00FFFF!Pig:|r|cffFFFF00已屏蔽"..ADDName.."频道消息！|r");
						return
					end
				end
				ChatFrame_AddChannel(chatFrame, ADDName)
				self.X:Hide();
				print("|cff00FFFF!Pig:|r|cffFFFF00已解除"..ADDName.."频道消息屏蔽！|r");
			end
		end);
		--PIG--
		QuickChatFFF.CHANNEL_3 = CreateFrame("Button",nil,QuickChatFFF, QuickChatFFF.biankuang);  
		QuickChatFFF.CHANNEL_3:SetSize(Width,Height);
		QuickChatFFF.CHANNEL_3:SetPoint("LEFT",QuickChatFFF.CHANNEL_2,"RIGHT",jiangejuli,0);
		QuickChatFFF.CHANNEL_3:SetText("P");
		QuickChatFFF.CHANNEL_3:SetFrameStrata("LOW")
		QuickChatFFF.CHANNEL_3:SetNormalFontObject(ChatFontNormal);
		QuickChatFFF.CHANNEL_3.Text:SetTextColor(102/255,1,204/255, 1);--#49e8e8
		QuickChatFFF.CHANNEL_3.Text:SetPoint("CENTER",QuickChatFFF.CHANNEL_3,"CENTER",0.8,0.3);
		QuickChatFFF.CHANNEL_3:RegisterForClicks("LeftButtonUp", "RightButtonUp");
		QuickChatFFF.CHANNEL_3.X = QuickChatFFF.CHANNEL_3:CreateTexture(nil, "OVERLAY");
		QuickChatFFF.CHANNEL_3.X:SetTexture("interface/common/voicechat-muted.blp");
		QuickChatFFF.CHANNEL_3.X:SetSize(16,16);
		QuickChatFFF.CHANNEL_3.X:SetAlpha(0.6);
		QuickChatFFF.CHANNEL_3.X:SetPoint("CENTER",0,0);
		QuickChatFFF.CHANNEL_3.X:Hide()
		QuickChatFFF.CHANNEL_3:SetScript("OnClick", function(self, event)
			local ADDName= "PIG"
			local channel,channelName, _ = GetChannelName(ADDName)
			--local chatFrame = SELECTED_DOCK_FRAME--当前选择聊天框架
			local chatFrame = DEFAULT_CHAT_FRAME--默认聊天框架			
			if event=="LeftButton" then
				if channelName == nil then
					JoinPermanentChannel(ADDName, nil, chatFrame:GetID(), 1);
					ChatFrame_AddChannel(chatFrame, ADDName)--订购一个聊天框以显示先前加入的聊天频道
					ChatFrame_RemoveMessageGroup(chatFrame, "CHANNEL")--屏蔽人员进入频道提示
					print("|cff00FFFF!Pig:|r|cffFFFF00已加入"..ADDName.."频道，右键屏蔽频道消息！|r");
				else
					ChatFrame_AddChannel(chatFrame, ADDName)
					local editBox = ChatEdit_ChooseBoxForSend();
					local hasText = editBox:GetText()
					if editBox:HasFocus() then
						editBox:SetText("/"..channel.." " ..hasText);
					else
						ChatEdit_ActivateChat(editBox)
						editBox:SetText("/"..channel.." " ..hasText);
					end
				end
				QuickChatFFF.CHANNEL_3.X:Hide();
			end
			if event=="RightButton" then
				local pindaomulu = {GetChatWindowChannels(1)}
				for i=1,#pindaomulu do
					if pindaomulu[i]==ADDName then
						ChatFrame_RemoveChannel(chatFrame, ADDName);
						self.X:Show();
						print("|cff00FFFF!Pig:|r|cffFFFF00已屏蔽"..ADDName.."频道消息！|r");
						return
					end
				end
				ChatFrame_AddChannel(chatFrame, ADDName)
				self.X:Hide();
				print("|cff00FFFF!Pig:|r|cffFFFF00已解除"..ADDName.."频道消息屏蔽！|r");
			end
		end);

		--大脚世界频道--
		QuickChatFFF.CHANNEL_4 = CreateFrame("Button",nil,QuickChatFFF, QuickChatFFF.biankuang);  
		QuickChatFFF.CHANNEL_4:SetSize(Width,Height);
		QuickChatFFF.CHANNEL_4:SetPoint("LEFT",QuickChatFFF.CHANNEL_3,"RIGHT",jiangejuli,0);
		QuickChatFFF.CHANNEL_4:SetText("世");
		QuickChatFFF.CHANNEL_4:SetFrameStrata("LOW")
		QuickChatFFF.CHANNEL_4:SetNormalFontObject(ChatFontNormal);
		QuickChatFFF.CHANNEL_4.Text:SetTextColor(0.888, 0.668, 0.668, 1.0);
		QuickChatFFF.CHANNEL_4.Text:SetPoint("CENTER",QuickChatFFF.CHANNEL_4,"CENTER",0.3,0.3);
		QuickChatFFF.CHANNEL_4:RegisterForClicks("LeftButtonUp", "RightButtonUp");
		QuickChatFFF.CHANNEL_4.X = QuickChatFFF.CHANNEL_4:CreateTexture(nil, "OVERLAY");
		QuickChatFFF.CHANNEL_4.X:SetTexture("interface/common/voicechat-muted.blp");
		QuickChatFFF.CHANNEL_4.X:SetSize(16,16);
		QuickChatFFF.CHANNEL_4.X:SetAlpha(0.6);
		QuickChatFFF.CHANNEL_4.X:SetPoint("CENTER",0,0);
		QuickChatFFF.CHANNEL_4.X:Hide()
		QuickChatFFF.CHANNEL_4:SetScript("OnClick", function(self, event)
			local ADDName= "大脚世界频道"
			local channel,channelName, _ = GetChannelName(ADDName)
			--local chatFrame = SELECTED_DOCK_FRAME--当前选择聊天框架
			local chatFrame = DEFAULT_CHAT_FRAME--默认聊天框架
			if event=="LeftButton" then
				if channelName == nil then	
					JoinPermanentChannel(ADDName, nil, chatFrame:GetID(), 1);
					ChatFrame_AddChannel(chatFrame, ADDName)--订购一个聊天框以显示先前加入的聊天频道
					ChatFrame_RemoveMessageGroup(chatFrame, "CHANNEL")--屏蔽人员进入频道提示
					print("|cff00FFFF!Pig:|r|cffFFFF00已加入"..ADDName.."频道，右键屏蔽频道消息！|r");
				else
					ChatFrame_AddChannel(chatFrame, ADDName)
					local editBox = ChatEdit_ChooseBoxForSend();
					local hasText = editBox:GetText()
					if editBox:HasFocus() then
						editBox:SetText("/"..channel.." " ..hasText);
					else
						ChatEdit_ActivateChat(editBox)
						editBox:SetText("/"..channel.." " ..hasText);
					end
				end
				self.X:Hide();
			end
			if event=="RightButton" then
				local pindaomulu = {GetChatWindowChannels(1)}
				for i=1,#pindaomulu do
					if pindaomulu[i]==ADDName then
						ChatFrame_RemoveChannel(chatFrame, ADDName);
						self.X:Show();
						print("|cff00FFFF!Pig:|r|cffFFFF00已屏蔽"..ADDName.."频道消息！|r");
						return
					end
				end
				ChatFrame_AddChannel(chatFrame, ADDName)
				self.X:Hide();
				print("|cff00FFFF!Pig:|r|cffFFFF00已解除"..ADDName.."频道消息屏蔽！|r");
			end
		end);
		---下移输入框================================
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
		addonTable.Update_ChatBut_icon()
	end
end
addonTable.ChatFrame_QuickChat_Open = ChatFrame_QuickChat_Open