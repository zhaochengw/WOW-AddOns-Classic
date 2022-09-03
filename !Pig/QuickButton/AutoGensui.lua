local _, addonTable = ...;
local _, _, _, tocversion = GetBuildInfo()
--------
local fuFrame = List_R_F_2_4
local ADD_Checkbutton=addonTable.ADD_Checkbutton
--=======================================
local function DisableFrame(self)
	if tocversion>30000 and tocversion<39999 then self:Disable() end
end
---主动跟随函数
local function Classes_Gensui_Z()
	local name,_ = UnitName("player");
	--判断指定输入框
	if PIG["Gensui"]["GensuiName"]~=nil and PIG["Gensui"]["GensuiName"]~="" then
		if PIG["Gensui"]["GensuiName"]~=name then
			if CheckInteractDistance(PIG["Gensui"]["GensuiName"], 4) then --跟随距离
				FollowUnit(PIG["Gensui"]["GensuiName"]);
				--print(CheckInteractDistance(PIG["Gensui"]["GensuiName"], 4))
				return
			end
		end
	end
	local mubiaoname,_ = UnitName("target");
	if UnitIsPlayer("target") then --是否为玩家
		if mubiaoname~=name then
			if CheckInteractDistance("target", 4) then --判断距离
				FollowUnit(mubiaoname);
				return
			end
		end
	end
	--跟随队友
	if IsInGroup()==true then
		local duiyou1,_ = UnitName("party1")		
		if duiyou1 and UnitIsConnected("Party1") then --玩家未离线
			if CheckInteractDistance("party1", 4) then					
				FollowUnit(duiyou1);
				return
			end
		end
	end
	if IsInGroup()==true then
		local duiyou2,_ = UnitName("party2")		
		if duiyou2 and UnitIsConnected("Party2") then --玩家未离线
			if CheckInteractDistance("party2", 4) then					
				FollowUnit(duiyou2);
				return
			end
		end
	end
	if IsInGroup()==true then
		local duiyou3,_ = UnitName("party3")		
		if duiyou3 and UnitIsConnected("Party3") then --玩家未离线
			if CheckInteractDistance("party3", 4) then					
				FollowUnit(duiyou3);
				return
			end
		end
	end
	if IsInGroup()==true then
		local duiyou4,_ = UnitName("party4")		
		if duiyou4 and UnitIsConnected("Party4") then --玩家未离线
			if CheckInteractDistance("party4", 4) then					
				FollowUnit(duiyou4);
				return
			end
		end
	end
end
---被动跟随函数
local function Classes_Gensui_B(Booleans)
	if Booleans then
		fuFrame.gensuiF:RegisterEvent("CHAT_MSG_PARTY");--收到组队信息
		fuFrame.gensuiF:RegisterEvent("CHAT_MSG_PARTY_LEADER");--当组长发送或接收消息时触发。
		fuFrame.gensuiF:RegisterEvent("CHAT_MSG_RAID");--收到团队信息
		fuFrame.gensuiF:RegisterEvent("CHAT_MSG_RAID_LEADER");--收到团队领导信息
		fuFrame.gensuiF:RegisterEvent("CHAT_MSG_WHISPER");--当收到其他玩家的耳语时触发
		gensuiB_UI_tishi:Show()
		if Gensui_Z_UI then Gensui_Z_UI:Disable() end
		if Gensui_B_CMD_UI then Gensui_B_CMD_UI:Disable() end
		if zhixingzdgensui then zhixingzdgensui:Cancel() end
		if zhixingzBDensui then zhixingzBDensui:Cancel() end
		if IsInGroup() then
			if IsInRaid() then
				SendChatMessage('[!Pig] 已开启被动跟随,收到指令 '..PIG["Gensui"]["GensuiKaishi"]..' 跟随；收到 '..PIG["Gensui"]["GensuiJieshu"]..' 停止', "RAID", nil);
			else
				SendChatMessage('[!Pig] 已开启被动跟随,收到指令 '..PIG["Gensui"]["GensuiKaishi"]..' 跟随；收到 '..PIG["Gensui"]["GensuiJieshu"]..' 停止', "PARTY", nil);
			end
		end
	else
		gensuiB_UI_tishi:Hide();
		if Gensui_Z_UI then Gensui_Z_UI:Enable() end
		if Gensui_B_CMD_UI then Gensui_B_CMD_UI:Enable() end
		local name,_ = UnitName("player");
		if zhixingzdgensui then zhixingzdgensui:Cancel() end
		if zhixingzBDensui then zhixingzBDensui:Cancel() end
		FollowUnit(name);
		if IsInGroup() then
			SendChatMessage("[!Pig] 已关闭被动跟随！", "PARTY", nil);
		end
		fuFrame.gensuiF:UnregisterEvent("CHAT_MSG_PARTY");--收到组队信息
		fuFrame.gensuiF:UnregisterEvent("CHAT_MSG_PARTY_LEADER");--当组长发送或接收消息时触发。
		fuFrame.gensuiF:UnregisterEvent("CHAT_MSG_RAID");--收到团队信息
		fuFrame.gensuiF:UnregisterEvent("CHAT_MSG_RAID_LEADER");--收到团队领导信息
		fuFrame.gensuiF:UnregisterEvent("CHAT_MSG_WHISPER");--当收到其他玩家的耳语时触发
	end
	fuFrame.gensuiF:SetScript("OnEvent",function (self,event,arg1,_,_,_,arg5)
		self.wanjiaming=arg5
		local zijirealm = GetRealmName()
		local wanjia, wanjiarealm = strsplit("-", arg5);
		if zijirealm==wanjiarealm then self.wanjiaming=wanjia end
		local function Classes_Gensui_Z_shuaxin()
			FollowUnit(self.wanjiaming);
		end
		if PIG['Gensui']['Duizhang']=="ON" then
			if event == "CHAT_MSG_RAID_LEADER" or event == "CHAT_MSG_PARTY_LEADER" or event == "CHAT_MSG_WHISPER" and UnitIsGroupLeader(self.wanjiaming) then
				if arg1 == PIG["Gensui"]["GensuiKaishi"] then
					if CheckInteractDistance(self.wanjiaming, 4) then
						if zhixingzdgensui then zhixingzdgensui:Cancel() end
						if zhixingzBDensui then zhixingzBDensui:Cancel() end
						if PIG['Gensui']['qianglimoshi']=="ON" then
							zhixingzBDensui=C_Timer.NewTicker(0.5, Classes_Gensui_Z_shuaxin)
						else
							FollowUnit(self.wanjiaming);
						end
						if PIG['Gensui']['gensuitishi']=="ON" then
							if event == "CHAT_MSG_RAID" or event == "CHAT_MSG_RAID_LEADER" then
								SendChatMessage("[!Pig] 开始跟随玩家《"..self.wanjiaming.."》，发送"..PIG["Gensui"]["GensuiJieshu"].."将停止跟随!", "RAID", nil);
							elseif event == "CHAT_MSG_PARTY" or event == "CHAT_MSG_PARTY_LEADER"then 
								SendChatMessage("[!Pig] 开始跟随玩家《"..self.wanjiaming.."》，发送"..PIG["Gensui"]["GensuiJieshu"].."将停止跟随!", "PARTY", nil);
							elseif event == "CHAT_MSG_WHISPER" then
								SendChatMessage("[!Pig] 我已开始跟随你，发送"..PIG["Gensui"]["GensuiJieshu"].."将停止跟随！", "WHISPER", nil, self.wanjiaming)
							end
						end
					else
						if PIG['Gensui']['gensuitishi']=="ON" then
							if event == "CHAT_MSG_RAID" or event == "CHAT_MSG_RAID_LEADER" then
								SendChatMessage("[!Pig] 跟随玩家《"..self.wanjiaming.."》失败，超出距离，请靠近一些!", "RAID", nil);
							elseif event == "CHAT_MSG_PARTY" or event == "CHAT_MSG_PARTY_LEADER"then 
								SendChatMessage("[!Pig] 跟随玩家《"..self.wanjiaming.."》失败，超出距离，请靠近一些!", "PARTY", nil);
							elseif event == "CHAT_MSG_WHISPER" then
								SendChatMessage("[!Pig] 跟随你失败，超出距离，请靠近一些！", "WHISPER", nil, self.wanjiaming)
							end
						end
					end
				end
				if arg1 == PIG["Gensui"]["GensuiJieshu"] then
					if zhixingzdgensui then zhixingzdgensui:Cancel() end
					if zhixingzBDensui then zhixingzBDensui:Cancel() end
					FollowUnit("player");
					if PIG['Gensui']['gensuitishi']=="ON" then		
						if event == "CHAT_MSG_RAID" or event == "CHAT_MSG_RAID_LEADER" then
							SendChatMessage("[!Pig] 停止跟随玩家《"..self.wanjiaming.."》，发送"..PIG["Gensui"]["GensuiKaishi"].."将再次跟随", "RAID", nil);
						elseif event == "CHAT_MSG_PARTY" or event == "CHAT_MSG_PARTY_LEADER"then 
							SendChatMessage("[!Pig] 停止跟随玩家《"..self.wanjiaming.."》，发送"..PIG["Gensui"]["GensuiKaishi"].."将再次跟随", "PARTY", nil);
						elseif event == "CHAT_MSG_WHISPER" then
							SendChatMessage("[!Pig] 已停止跟随你，发送"..PIG["Gensui"]["GensuiKaishi"].."将再次跟随！", "WHISPER", nil, self.wanjiaming);
						end
					end		
				end		
			end
		else
			if event=="CHAT_MSG_RAID" or event=="CHAT_MSG_RAID_LEADER" or event=="CHAT_MSG_PARTY" or event=="CHAT_MSG_PARTY_LEADER" or event=="CHAT_MSG_WHISPER" then
				if not UnitInParty(self.wanjiaming) then return end
				if arg1 == PIG["Gensui"]["GensuiKaishi"] then
					if CheckInteractDistance(self.wanjiaming, 4) then
						if zhixingzdgensui then zhixingzdgensui:Cancel() end
						if zhixingzBDensui then zhixingzBDensui:Cancel() end
						if PIG['Gensui']['qianglimoshi']=="ON" then
							zhixingzBDensui=C_Timer.NewTicker(0.5, Classes_Gensui_Z_shuaxin)
						else
							FollowUnit(self.wanjiaming);
						end
						if PIG['Gensui']['gensuitishi']=="ON" then
							if event == "CHAT_MSG_RAID" or event == "CHAT_MSG_RAID_LEADER" then
								SendChatMessage("[!Pig] 开始跟随玩家《"..self.wanjiaming.."》，发送"..PIG["Gensui"]["GensuiJieshu"].."将停止跟随!", "RAID", nil);
							elseif event == "CHAT_MSG_PARTY" or event == "CHAT_MSG_PARTY_LEADER"then 
								SendChatMessage("[!Pig] 开始跟随玩家《"..self.wanjiaming.."》，发送"..PIG["Gensui"]["GensuiJieshu"].."将停止跟随!", "PARTY", nil);
							elseif event == "CHAT_MSG_WHISPER" then
								SendChatMessage("[!Pig] 我已开始跟随你，发送"..PIG["Gensui"]["GensuiJieshu"].."将停止跟随！", "WHISPER", nil, self.wanjiaming)
							end
						end
					else
						if PIG['Gensui']['gensuitishi']=="ON" then
							if event == "CHAT_MSG_RAID" or event == "CHAT_MSG_RAID_LEADER" then
								SendChatMessage("[!Pig] 跟随玩家《"..self.wanjiaming.."》失败，超出距离，请靠近一些!", "RAID", nil);
							elseif event == "CHAT_MSG_PARTY" or event == "CHAT_MSG_PARTY_LEADER"then 
								SendChatMessage("[!Pig] 跟随玩家《"..self.wanjiaming.."》失败，超出距离，请靠近一些!", "PARTY", nil);
							elseif event == "CHAT_MSG_WHISPER" then
								SendChatMessage("[!Pig] 跟随你失败，超出距离，请靠近一些！", "WHISPER", nil, self.wanjiaming)
							end
						end
					end
				elseif (arg1 == PIG["Gensui"]["GensuiJieshu"]) then
					if zhixingzdgensui then zhixingzdgensui:Cancel() end
					if zhixingzBDensui then zhixingzBDensui:Cancel() end
					FollowUnit("player");
					if PIG['Gensui']['gensuitishi']=="ON" then
						if event == "CHAT_MSG_RAID" or event == "CHAT_MSG_RAID_LEADER" then
							SendChatMessage("[!Pig] 停止跟随玩家《"..self.wanjiaming.."》，发送"..PIG["Gensui"]["GensuiKaishi"].."将再次跟随", "RAID", nil);
						elseif event == "CHAT_MSG_PARTY" or event == "CHAT_MSG_PARTY_LEADER"then 
							SendChatMessage("[!Pig] 停止跟随玩家《"..self.wanjiaming.."》，发送"..PIG["Gensui"]["GensuiKaishi"].."将再次跟随", "PARTY", nil);
						elseif event == "CHAT_MSG_WHISPER" then
							SendChatMessage("[!Pig] 已停止跟随你，发送"..PIG["Gensui"]["GensuiKaishi"].."将再次跟随！", "WHISPER", nil, self.wanjiaming);
						end
					end		
				end		
			end
		end
	end);
end
--创建快捷按钮
local function QuickButton_Gensui()
	if Gensui_Z_UI then return end
	local QkbutF = QuickButtonUI.nr
	local butW = QkbutF:GetHeight()
	if tocversion>30000 and tocversion<40000 then
		local gensuiZ  = CreateFrame("Button", "Gensui_Z_UI", QkbutF, "UIPanelButtonTemplate");
		gensuiZ:SetSize(butW-6,butW-6);
		local Children = {QkbutF:GetChildren()};
		local geshu = #Children;
		gensuiZ:SetPoint("LEFT",QkbutF,"LEFT",(geshu-1)*(butW),0);
		gensuiZ:SetText("主");
		gensuiZ:RegisterForClicks("LeftButtonUp","RightButtonUp")
		gensuiZ:SetScript("OnEnter", function (self)
			GameTooltip:ClearLines();
			GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT",2,4);
			GameTooltip:AddLine("左键-|cff00FFFF跟随当前目标|r\n右击-|cff00FFFF跟随优先级:自定义角色>当前目标>队友1/2/3/4！|r")
			GameTooltip:Show();
		end);
		gensuiZ:SetScript("OnLeave", function ()
			GameTooltip:ClearLines();
			GameTooltip:Hide() 
		end);
		gensuiZ:SetScript("OnClick", function (self,botton)
			if botton=="LeftButton" then
				FollowUnit("target");
			else
				Classes_Gensui_Z()
			end
		end);
	else
		--主动
		local gensuiZ  = CreateFrame("CheckButton", "Gensui_Z_UI", QkbutF, "ChatConfigCheckButtonTemplate");
		gensuiZ:SetSize(butW,butW);
		local Children = {QkbutF:GetChildren()};
		local geshu = #Children;
		gensuiZ:SetPoint("LEFT",QkbutF,"LEFT",(geshu-1)*(butW),-3);
		gensuiZ:SetHitRectInsets(0,0,0,0);
		gensuiZ.Text:SetText("主");
		gensuiZ.Text:ClearAllPoints();
		gensuiZ.Text:SetTextColor(0, 1, 0, 0.8);
		gensuiZ.Text:SetPoint("TOP",gensuiZ,"TOP",0,4);
		gensuiZ.tooltip = "|cff00FF00主动跟随|r\n|cff00FFFF开启后将自动跟随特定目标！\n跟随目标优先级:自定义角色>当前目标！|r\n可自定义优先跟随角色/自动确认就位，跟随指令会定时刷新！";
		gensuiZ:SetScript("OnClick", function (self)
			if self:GetChecked() then
				fuFrame.gensuiFZ.Z_Open:SetChecked(true)
				Gensui_Z_UI_tishi:Show()
				if Gensui_B_UI then Gensui_B_UI:Disable() end
				if zhixingzdgensui then zhixingzdgensui:Cancel() end
				if zhixingzBDensui then zhixingzBDensui:Cancel() end
				zhixingzdgensui=C_Timer.NewTicker(0.5, Classes_Gensui_Z)
			else
				fuFrame.gensuiFZ.Z_Open:SetChecked(false)
				Gensui_Z_UI_tishi:Hide();
				if Gensui_B_UI then Gensui_B_UI:Enable() end
				if zhixingzdgensui then zhixingzdgensui:Cancel() end
				if zhixingzBDensui then zhixingzBDensui:Cancel() end
				local name,_ = UnitName("player");
				FollowUnit(name);
			end
		end);
		--被动
		local gensuiB = CreateFrame("CheckButton", "Gensui_B_UI", QkbutF, "ChatConfigCheckButtonTemplate");
		gensuiB:SetSize(butW,butW);
		gensuiB:SetPoint("LEFT",gensuiZ,"RIGHT",0,0);
		gensuiB:SetHitRectInsets(0,0,0,0);
		gensuiB.Text:SetText("被");
		gensuiB.Text:ClearAllPoints();
		gensuiB.Text:SetTextColor(1, 1, 0, 0.8);
		gensuiB.Text:SetPoint("TOP",gensuiB,"TOP",0,4);
		gensuiB.tooltip = "|cffffFF00被动跟随|r\n|cff00FFFF开启后收到预设指令将自动开始或停止跟随指令目标！|r\n可在设置内自定义跟随指令/自动确认就位/只跟随队长！";
		gensuiB:SetScript("OnClick", function (self)
			if self:GetChecked() then
				fuFrame.gensuiF.B_Open:SetChecked(true)
				PIG_Per['Gensui']['beidongkaiqi']=true
				Classes_Gensui_B(true)
			else
				fuFrame.gensuiF.B_Open:SetChecked(false)
				PIG_Per['Gensui']['beidongkaiqi']=false
				Classes_Gensui_B(false)
			end
		end);

		----
		local gensuiCMD = CreateFrame("Button", "Gensui_B_CMD_UI", QkbutF, "UIPanelButtonTemplate");
		gensuiCMD:SetSize(butW-6,butW-6);
		gensuiCMD:SetPoint("LEFT",gensuiB,"RIGHT",0,3); 
		gensuiCMD:SetText("被");
		gensuiCMD:RegisterForClicks("LeftButtonUp","RightButtonUp")
		gensuiCMD:SetScript("OnEnter", function (self)
			GameTooltip:ClearLines();
			GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT",2,4);
			GameTooltip:AddLine("左键-|cff00FFFF发送开始跟随指令|r\n右击-|cff00FFFF发送停止跟随指令|r")
			GameTooltip:Show();
		end);
		gensuiCMD:SetScript("OnLeave", function ()
			GameTooltip:ClearLines();
			GameTooltip:Hide() 
		end);
		gensuiCMD:SetScript("OnClick", function (self,botton)
			if botton=="LeftButton" then
				if IsInGroup() then
					if IsInRaid() then
						SendChatMessage(PIG["Gensui"]["GensuiKaishi"], "RAID", nil);
					else
						SendChatMessage(PIG["Gensui"]["GensuiKaishi"], "PARTY", nil);
					end
				end
			else
				if IsInGroup() then
					if IsInRaid() then
						SendChatMessage(PIG["Gensui"]["GensuiJieshu"], "RAID", nil);
					else
						SendChatMessage(PIG["Gensui"]["GensuiJieshu"], "PARTY", nil);
					end
				end
			end
		end);
		if PIG_Per['Gensui']['beidongkaiqi'] then Gensui_B_UI:SetChecked(true) Gensui_B_CMD_UI:Disable() end
	end
	local Qfff = QuickButtonUI
	Qfff:Show();
	local Children = {QkbutF:GetChildren()};
	local geshu = #Children;
	local NewWidth = butW*(geshu+2);
	Qfff.nr:SetWidth(NewWidth);
	Qfff:SetWidth(NewWidth+12);
end
fuFrame.GensuiOpen=ADD_Checkbutton("添加<智能跟随开关>到快捷按钮栏","在快捷按钮栏显示跟随开关按钮",fuFrame,-60,fuFrame,20,-20)
--DisableFrame(fuFrame.GensuiOpen)
fuFrame.GensuiOpen:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG['Gensui']['Open']=true;
		QuickButton_Gensui()
	else
		PIG['Gensui']['Open']=false;
		Pig_Options_RLtishi_UI:Show()
	end
end);
-----------------------------
local gensuizidongjiuweiFFF = CreateFrame("Frame");
gensuizidongjiuweiFFF:SetScript("OnEvent",function (self,event,arg1,_,_,_,arg5)
	if PIG['Gensui']['Open'] then
		--自动就位
		if PIG['Gensui']['gensuijiuwei'] then
			if Gensui_B_UI or Gensui_B_UI then
				if Gensui_B_UI:GetChecked() or Gensui_B_UI:GetChecked() then
					ConfirmReadyCheck(true)
				end
			end
		end
		--自动交接队长
		if PIG['Gensui']['yijiaoduizhang'] then
			if UnitIsGroupLeader("player") then
				if Gensui_B_UI or Gensui_B_UI then
					if Gensui_B_UI:GetChecked() or Gensui_B_UI:GetChecked() then
						if string.match(arg1,"队长") or string.match(arg1,"团长") then		
							PromoteToLeader(arg5)
						end
					end
				end
			end
		end
	end
end)
fuFrame.gensuijiuwei=ADD_Checkbutton("跟随开启时自动就位","开启后，跟随开启后将自动确认就位确认",fuFrame,-100,fuFrame,20,-60)
DisableFrame(fuFrame.gensuijiuwei)
fuFrame.gensuijiuwei:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG['Gensui']['gensuijiuwei']=true;
		gensuizidongjiuweiFFF:RegisterEvent("READY_CHECK");
	else
		PIG['Gensui']['gensuijiuwei']=false;
		gensuizidongjiuweiFFF:UnregisterEvent("READY_CHECK");
	end
end);
fuFrame.yijiaoduizhang=ADD_Checkbutton("跟随开启时自动移交队长/团长","开启后，跟随开启时收到密语内容为[队长]/[团长]，将自动移交队长/团长给对方",fuFrame,-100,fuFrame,20,-100)
DisableFrame(fuFrame.yijiaoduizhang)
fuFrame.yijiaoduizhang:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG['Gensui']['yijiaoduizhang']=true;
		if IsInGroup() then
			SendChatMessage('[!Pig] 已开启跟随时自动移交队长,收到密语内容为“队长”将自动移交队长', "PARTY", nil);
		end
		gensuizidongjiuweiFFF:RegisterEvent("CHAT_MSG_WHISPER");
	else
		PIG['Gensui']['yijiaoduizhang']=false;
		gensuizidongjiuweiFFF:UnregisterEvent("CHAT_MSG_WHISPER");
	end
end);

-------------
fuFrame.gensuiF = CreateFrame("Frame", nil, fuFrame,"BackdropTemplate")
fuFrame.gensuiF:SetBackdrop( {edgeFile = "Interface/Tooltips/UI-Tooltip-Border",edgeSize = 12 });
fuFrame.gensuiF:SetBackdropBorderColor(0.5, 0.5, 0.5, 0.8);
fuFrame.gensuiF:SetSize(fuFrame:GetWidth()-40, 160)
fuFrame.gensuiF:SetPoint("TOP", fuFrame, "TOP", 0, -140)

--Show
local function Showbianji_E(Frame1,Frame2,data1,data2)
	Frame1:SetTextColor(1, 1, 1, 1);
	Frame2:Show(); 
end
--ESC
local function ESCbianji_E(Frame1,Frame2,data1,data2)
	Frame1:ClearFocus();Frame2:Hide();
	Frame1:SetTextColor(200/255, 200/255, 200/255, 0.8);
	Frame1:SetText(PIG[data1][data2]);
end
--save
local function baocunbianji_E(Frame1,Frame2,data1,data2)
	PIG[data1][data2]=Frame1:GetText()
	Frame1:ClearFocus()
	Frame1:SetTextColor(200/255, 200/255, 200/255, 0.8);
	Frame2:Hide();
end
----设置被动跟随===============
local gensuiB_tishi = CreateFrame("Frame", "gensuiB_UI_tishi", UIParent)
gensuiB_tishi:SetSize(200,50);
gensuiB_tishi:SetPoint("CENTER", UIParent, "CENTER", 0, 50);
gensuiB_tishi:Hide();
gensuiB_tishi.t = gensuiB_tishi:CreateFontString();
gensuiB_tishi.t:SetPoint("CENTER", gensuiB_tishi, "CENTER", 0, 0);
gensuiB_tishi.t:SetFont(GameFontNormal:GetFont(), 40,"OUTLINE")
gensuiB_tishi.t:SetText('|cffffFF00被动|r|cff00D7FF跟随中...|r');

fuFrame.gensuiF.ST_B_t = fuFrame.gensuiF:CreateFontString();
fuFrame.gensuiF.ST_B_t:SetPoint("TOPLEFT", fuFrame.gensuiF, "TOPLEFT", 10, -10);
fuFrame.gensuiF.ST_B_t:SetFontObject(GameFontNormalSmall);
fuFrame.gensuiF.ST_B_t:SetText('|cff00FFFF被动跟随设置|r(收到队友发言或密语将自动跟随对方)');

fuFrame.gensuiF.B_Open=ADD_Checkbutton("开启被动跟随","收到队友发言或密语将自动跟随对方",fuFrame.gensuiF,-100,fuFrame.gensuiF,20,-40)
DisableFrame(fuFrame.gensuiF.B_Open)
fuFrame.gensuiF.B_Open:SetScript("OnClick", function (self)
	if self:GetChecked() then
		if Gensui_B_UI then Gensui_B_UI:SetChecked(true) end
		if Gensui_Z_UI then Gensui_Z_UI:Disable() end
		fuFrame.gensuiFZ.Z_Open:Disable()
		PIG_Per['Gensui']['beidongkaiqi']=true
		Classes_Gensui_B(true)
	else
		if Gensui_B_UI then Gensui_B_UI:SetChecked(false) end
		if Gensui_Z_UI then Gensui_Z_UI:Enable() end
		fuFrame.gensuiFZ.Z_Open:Enable()
		PIG_Per['Gensui']['beidongkaiqi']=false
		Classes_Gensui_B(false)
	end
end)
--开始指令
fuFrame.gensuiF.ST_B_E_t = fuFrame.gensuiF:CreateFontString();
fuFrame.gensuiF.ST_B_E_t:SetPoint("TOPLEFT", fuFrame.gensuiF.B_Open, "BOTTOMLEFT", 6, -15);
fuFrame.gensuiF.ST_B_E_t:SetFontObject(GameFontNormalSmall);
fuFrame.gensuiF.ST_B_E_t:SetText('开始指令：');
fuFrame.gensuiF.ST_B_E = CreateFrame('EditBox', nil, fuFrame.gensuiF,"InputBoxInstructionsTemplate");
fuFrame.gensuiF.ST_B_E:SetSize(100,30);
fuFrame.gensuiF.ST_B_E:SetPoint("LEFT",fuFrame.gensuiF.ST_B_E_t,"RIGHT",10,0);
fuFrame.gensuiF.ST_B_E:SetFontObject(ChatFontNormal);
fuFrame.gensuiF.ST_B_E:SetAutoFocus(false);
fuFrame.gensuiF.ST_B_E:EnableMouse(true)
fuFrame.gensuiF.ST_B_E:SetTextColor(200/255, 200/255, 200/255, 0.8); 
fuFrame.gensuiF.ST_B_E:SetScript("OnEditFocusGained", function(self)
	Showbianji_E(self,fuFrame.gensuiF.ST_B_E_b)
end);
fuFrame.gensuiF.ST_B_E:SetScript("OnEscapePressed", function(self) 
	ESCbianji_E(self,fuFrame.gensuiF.ST_B_E_b,"Gensui","GensuiKaishi")
end);
fuFrame.gensuiF.ST_B_E:SetScript("OnEnterPressed", function(self)
	baocunbianji_E(self,fuFrame.gensuiF.ST_B_E_b,"Gensui","GensuiKaishi")
end);
fuFrame.gensuiF.ST_B_E_b = CreateFrame("Button",nil,fuFrame.gensuiF, "UIPanelButtonTemplate");  
fuFrame.gensuiF.ST_B_E_b:SetSize(40,22);
fuFrame.gensuiF.ST_B_E_b:SetPoint("LEFT",fuFrame.gensuiF.ST_B_E,"RIGHT",0,0);
fuFrame.gensuiF.ST_B_E_b:SetText("确定");
fuFrame.gensuiF.ST_B_E_b:Hide();
fuFrame.gensuiF.ST_B_E_b:RegisterForClicks("LeftButtonUp", "RightButtonUp");
fuFrame.gensuiF.ST_B_E_b:SetScript("OnClick", function (self)
	baocunbianji_E(fuFrame.gensuiF.ST_B_E,self,"Gensui","GensuiKaishi")
end);
--结束指令
fuFrame.gensuiF.ST_B_E_t_E = fuFrame.gensuiF:CreateFontString();
fuFrame.gensuiF.ST_B_E_t_E:SetPoint("LEFT", fuFrame.gensuiF.ST_B_E_t, "RIGHT", 180, 0);
fuFrame.gensuiF.ST_B_E_t_E:SetFontObject(GameFontNormalSmall);
fuFrame.gensuiF.ST_B_E_t_E:SetText('停止指令：');
fuFrame.gensuiF.ST_B_E_E = CreateFrame('EditBox', nil, fuFrame.gensuiF,"InputBoxInstructionsTemplate");
fuFrame.gensuiF.ST_B_E_E:SetSize(100,30);
fuFrame.gensuiF.ST_B_E_E:SetPoint("LEFT",fuFrame.gensuiF.ST_B_E_t_E,"RIGHT",10,0);
fuFrame.gensuiF.ST_B_E_E:SetFontObject(ChatFontNormal);
fuFrame.gensuiF.ST_B_E_E:SetAutoFocus(false);
fuFrame.gensuiF.ST_B_E_E:EnableMouse(true)
fuFrame.gensuiF.ST_B_E_E:SetTextColor(200/255, 200/255, 200/255, 0.8); 
fuFrame.gensuiF.ST_B_E_E:SetScript("OnEditFocusGained", function(self)
	Showbianji_E(self,fuFrame.gensuiF.ST_B_E_b_E)
end);
fuFrame.gensuiF.ST_B_E_E:SetScript("OnEscapePressed", function(self) 
	ESCbianji_E(self,fuFrame.gensuiF.ST_B_E_b_E,"Gensui","GensuiJieshu")
end);
fuFrame.gensuiF.ST_B_E_E:SetScript("OnEnterPressed", function(self)
	baocunbianji_E(self,fuFrame.gensuiF.ST_B_E_b_E,"Gensui","GensuiJieshu")
end);
fuFrame.gensuiF.ST_B_E_b_E = CreateFrame("Button",nil,fuFrame.gensuiF, "UIPanelButtonTemplate");  
fuFrame.gensuiF.ST_B_E_b_E:SetSize(40,22);
fuFrame.gensuiF.ST_B_E_b_E:SetPoint("LEFT",fuFrame.gensuiF.ST_B_E_E,"RIGHT",0,0);
fuFrame.gensuiF.ST_B_E_b_E:SetText("确定");
fuFrame.gensuiF.ST_B_E_b_E:Hide();
fuFrame.gensuiF.ST_B_E_b_E:RegisterForClicks("LeftButtonUp", "RightButtonUp");
fuFrame.gensuiF.ST_B_E_b_E:SetScript("OnClick", function (self)
	baocunbianji_E(fuFrame.gensuiF.ST_B_E_E,self,"Gensui","GensuiJieshu")
end);
fuFrame.gensuiF:HookScript("OnHide", function(self)
	ESCbianji_E(fuFrame.gensuiF.ST_B_E,fuFrame.gensuiF.ST_B_E_b,"Gensui","GensuiKaishi")
	ESCbianji_E(fuFrame.gensuiF.ST_B_E_E,fuFrame.gensuiF.ST_B_E_b_E,"Gensui","GensuiJieshu")
end);
-------------------------
fuFrame.gensuiF.ST_B_Duizhang=ADD_Checkbutton("只接受队长跟随指令","只接受来自队长跟随指令",fuFrame.gensuiF,-100,fuFrame.gensuiF,22,-120)
DisableFrame(fuFrame.gensuiF.ST_B_Duizhang)
fuFrame.gensuiF.ST_B_Duizhang:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG['Gensui']['Duizhang']=true;
	else
		PIG['Gensui']['Duizhang']=false;
	end
end);
--关闭提示
fuFrame.gensuiF.ST_B_tishi=ADD_Checkbutton("跟随状态提示","开启后，跟随成功/失败会在队伍/私聊频道提示",fuFrame.gensuiF,-100,fuFrame.gensuiF.ST_B_Duizhang,220,0)
DisableFrame(fuFrame.gensuiF.ST_B_tishi)
fuFrame.gensuiF.ST_B_tishi:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG['Gensui']['gensuitishi']=true;
	else
		PIG['Gensui']['gensuitishi']=false;
	end
end);
--强力模式
fuFrame.gensuiF.qianglimoshi=ADD_Checkbutton("强力模式","开启后，在未收到停止指令前不会停止跟随",fuFrame.gensuiF,-100,fuFrame.gensuiF.ST_B_tishi,160,0)
DisableFrame(fuFrame.gensuiF.qianglimoshi)
fuFrame.gensuiF.qianglimoshi:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG['Gensui']['qianglimoshi']=true;
	else
		PIG['Gensui']['qianglimoshi']=false;
	end
end);
----设置主动跟随==================
local gensuiZ_tishi = CreateFrame("Frame", "Gensui_Z_UI_tishi", UIParent)
gensuiZ_tishi:SetSize(200,50);
gensuiZ_tishi:SetPoint("CENTER", UIParent, "CENTER", 0, 50);
gensuiZ_tishi:Hide();
gensuiZ_tishi.t = gensuiZ_tishi:CreateFontString();
gensuiZ_tishi.t:SetPoint("CENTER", gensuiZ_tishi, "CENTER", 0, 0);
gensuiZ_tishi.t:SetFont(GameFontNormal:GetFont(), 40,"OUTLINE")
gensuiZ_tishi.t:SetText('|cff00FF00主动|r|cff00D7FF跟随中...|r');

fuFrame.gensuiFZ = CreateFrame("Frame", nil, fuFrame,"BackdropTemplate")
fuFrame.gensuiFZ:SetBackdrop( {edgeFile = "Interface/Tooltips/UI-Tooltip-Border",edgeSize = 12 });
fuFrame.gensuiFZ:SetBackdropBorderColor(0.5, 0.5, 0.5, 0.8);
fuFrame.gensuiFZ:SetSize(fuFrame:GetWidth()-40, 120)
fuFrame.gensuiFZ:SetPoint("TOP", fuFrame, "TOP", 0, -310)

fuFrame.gensuiFZ.ST_Z_t = fuFrame.gensuiFZ:CreateFontString();
fuFrame.gensuiFZ.ST_Z_t:SetPoint("TOPLEFT", fuFrame.gensuiFZ, "TOPLEFT", 15, -15);
fuFrame.gensuiFZ.ST_Z_t:SetFontObject(GameFontNormalSmall);
fuFrame.gensuiFZ.ST_Z_t:SetText('|cff00FFFF主动跟随设置|r(跟随特定目标,优先级:自定义角色>当前目标)');

fuFrame.gensuiFZ.Z_Open=ADD_Checkbutton("开启主动跟随","|cff00FFFF开启后将自动跟随特定目标！\n跟随目标优先级:自定义角色>当前目标！|r\n可自定义优先跟随角色/自动确认就位，跟随指令会定时刷新！",fuFrame.gensuiFZ,-100,fuFrame.gensuiFZ,20,-40)
DisableFrame(fuFrame.gensuiFZ.Z_Open)
fuFrame.gensuiFZ.Z_Open:SetScript("OnClick", function (self)
	if self:GetChecked() then
		fuFrame.gensuiF.B_Open:Disable()
		Gensui_Z_UI_tishi:Show()
		if Gensui_Z_UI then Gensui_Z_UI:SetChecked(true) end
		if Gensui_B_UI then Gensui_B_UI:Disable() end
		if zhixingzdgensui then zhixingzdgensui:Cancel() end
		if zhixingzBDensui then zhixingzBDensui:Cancel() end
		zhixingzdgensui=C_Timer.NewTicker(0.5, Classes_Gensui_Z)
	else
		fuFrame.gensuiF.B_Open:Enable()
		Gensui_Z_UI_tishi:Hide();
		if Gensui_Z_UI then Gensui_Z_UI:SetChecked(false) end
		if Gensui_B_UI then Gensui_B_UI:Enable() end
		if zhixingzdgensui then zhixingzdgensui:Cancel() end
		if zhixingzBDensui then zhixingzBDensui:Cancel() end
		local name,_ = UnitName("player");
		FollowUnit(name);
	end
end)

fuFrame.gensuiFZ.ST_Z_t.ST_Z_E_t = fuFrame.gensuiFZ:CreateFontString();
fuFrame.gensuiFZ.ST_Z_t.ST_Z_E_t:SetPoint("TOPLEFT", fuFrame.gensuiFZ.Z_Open, "BOTTOMLEFT", 4, -10);
fuFrame.gensuiFZ.ST_Z_t.ST_Z_E_t:SetFontObject(GameFontNormalSmall);
fuFrame.gensuiFZ.ST_Z_t.ST_Z_E_t:SetText('优先跟随角色：');
fuFrame.gensuiFZ.ST_Z_E = CreateFrame('EditBox', nil, fuFrame.gensuiFZ,"InputBoxInstructionsTemplate");
fuFrame.gensuiFZ.ST_Z_E:SetSize(150,30);
fuFrame.gensuiFZ.ST_Z_E:SetPoint("LEFT",fuFrame.gensuiFZ.ST_Z_t.ST_Z_E_t,"RIGHT",10,0);
fuFrame.gensuiFZ.ST_Z_E:SetFontObject(ChatFontNormal);
fuFrame.gensuiFZ.ST_Z_E:SetAutoFocus(false);
fuFrame.gensuiFZ.ST_Z_E:EnableMouse(true)
fuFrame.gensuiFZ.ST_Z_E:SetTextColor(200/255, 200/255, 200/255, 0.8);
fuFrame.gensuiFZ.ST_Z_E:SetScript("OnEditFocusGained", function(self)
	Showbianji_E(self,fuFrame.gensuiFZ.ST_Z_E_b)
end);
fuFrame.gensuiFZ.ST_Z_E:SetScript("OnEscapePressed", function(self)
	ESCbianji_E(self,fuFrame.gensuiFZ.ST_Z_E_b,"Gensui","GensuiName")
end);
fuFrame.gensuiFZ.ST_Z_E:SetScript("OnEnterPressed", function(self)
	baocunbianji_E(self,fuFrame.gensuiFZ.ST_Z_E_b,"Gensui","GensuiName")
end);
fuFrame.gensuiFZ.ST_Z_E_b = CreateFrame("Button",nil,fuFrame.gensuiFZ, "UIPanelButtonTemplate");  
fuFrame.gensuiFZ.ST_Z_E_b:SetSize(40,22);
fuFrame.gensuiFZ.ST_Z_E_b:SetPoint("LEFT",fuFrame.gensuiFZ.ST_Z_E,"RIGHT",0,0);
fuFrame.gensuiFZ.ST_Z_E_b:SetText("确定");
fuFrame.gensuiFZ.ST_Z_E_b:Hide();
fuFrame.gensuiFZ.ST_Z_E_b:RegisterForClicks("LeftButtonUp", "RightButtonUp");
fuFrame.gensuiFZ.ST_Z_E_b:SetScript("OnClick", function (self)
	baocunbianji_E(fuFrame.gensuiFZ.ST_Z_E,self,"Gensui","GensuiName")
end);
fuFrame.gensuiFZ:HookScript("OnHide", function(self)
	ESCbianji_E(fuFrame.gensuiFZ.ST_Z_E,fuFrame.gensuiFZ.ST_Z_E_b,"Gensui","GensuiName")
end);
--=============================
local function gengxinDATA()
	PIG['Gensui']=PIG['Gensui'] or addonTable.Default['Gensui']
	PIG_Per['Gensui']=PIG_Per['Gensui'] or addonTable.Default_Per['Gensui']
	if PIG['Gensui']['gensuijiuwei'] then
		gensuizidongjiuweiFFF:RegisterEvent("READY_CHECK");
	else
		gensuizidongjiuweiFFF:UnregisterEvent("READY_CHECK");
	end
	if PIG['Gensui']['yijiaoduizhang'] then
		gensuizidongjiuweiFFF:RegisterEvent("CHAT_MSG_WHISPER");
	else
		gensuizidongjiuweiFFF:UnregisterEvent("CHAT_MSG_WHISPER");
	end
	if PIG['QuickButton']['Open'] then
		if PIG['Gensui']['Open'] then
			QuickButton_Gensui()
		end
	end
	if PIG_Per['Gensui']['beidongkaiqi'] then
		if Gensui_B_UI then Gensui_B_UI:SetChecked(true) end
		fuFrame.gensuiF.B_Open:SetChecked(true);
		Classes_Gensui_B(true)
	end
end
fuFrame:HookScript("OnShow", function(self)
	if PIG['Gensui']['Open'] then
		fuFrame.GensuiOpen:SetChecked(true);
	end
	fuFrame.gensuiFZ.ST_Z_E:SetText(PIG["Gensui"]["GensuiName"]);
	fuFrame.gensuiF.ST_B_E:SetText(PIG["Gensui"]["GensuiKaishi"]);
	fuFrame.gensuiF.ST_B_E_E:SetText(PIG["Gensui"]["GensuiJieshu"]);
	if PIG['Gensui']['Duizhang'] then
		fuFrame.gensuiF.ST_B_Duizhang:SetChecked(true);
	end
	if PIG['Gensui']['gensuitishi'] then
		fuFrame.gensuiF.ST_B_tishi:SetChecked(true);
	end
	if PIG['Gensui']['qianglimoshi'] then
		fuFrame.gensuiF.qianglimoshi:SetChecked(true);
	end
	if PIG['Gensui']['gensuijiuwei'] then
		fuFrame.gensuijiuwei:SetChecked(true);
	end
	if PIG['Gensui']['yijiaoduizhang'] then
		fuFrame.yijiaoduizhang:SetChecked(true);
	end
end)
addonTable.AutoGensui = gengxinDATA