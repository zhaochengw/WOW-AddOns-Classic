local _, addonTable = ...;
--------
local fuFrame = Pig_Options_RF_TAB_7_UI
--=======================================
fuFrame.gensuiF = CreateFrame("Frame", nil, fuFrame,"BackdropTemplate")
fuFrame.gensuiF:SetBackdrop( {bgFile = "Interface/DialogFrame/UI-DialogBox-Background", 
	edgeFile = "Interface/Tooltips/UI-Tooltip-Border",edgeSize = 12, insets = { left = 2, right = 2, top = 2, bottom = 2 } });
fuFrame.gensuiF:SetBackdropColor(0, 0, 0, 0.6);
fuFrame.gensuiF:SetBackdropBorderColor(0.5, 0.5, 0.5, 1);
fuFrame.gensuiF:SetSize(fuFrame:GetWidth()-40, 170)
fuFrame.gensuiF:SetPoint("TOPLEFT", fuFrame, "TOPLEFT", 30, -160)
----便捷跟随=====================================
---主动跟随函数
local function Classes_Gensui_Z()
	local name,_ = UnitName("player");
	--判断指定输入框
	if PIG["Classes"]["GensuiName"]~=nil and PIG["Classes"]["GensuiName"]~="" then
		if PIG["Classes"]["GensuiName"]~=name then
			if CheckInteractDistance(PIG["Classes"]["GensuiName"], 4) then --跟随距离
				FollowUnit(PIG["Classes"]["GensuiName"]);
				--print(CheckInteractDistance(PIG["Classes"]["GensuiName"], 4))
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
	-- if IsInGroup()==true then
	-- 	local duiyou1,_ = UnitName("party1")		
	-- 	if duiyou1 and UnitIsConnected("Party1") then --玩家未离线
	-- 		if CheckInteractDistance("party1", 4) then					
	-- 			FollowUnit(duiyou1);
	-- 			return
	-- 		end
	-- 	end
	-- end
	-- if IsInGroup()==true then
	-- 	local duiyou2,_ = UnitName("party2")		
	-- 	if duiyou2 and UnitIsConnected("Party2") then --玩家未离线
	-- 		if CheckInteractDistance("party2", 4) then					
	-- 			FollowUnit(duiyou2);
	-- 			return
	-- 		end
	-- 	end
	-- end
	-- if IsInGroup()==true then
	-- 	local duiyou3,_ = UnitName("party3")		
	-- 	if duiyou3 and UnitIsConnected("Party3") then --玩家未离线
	-- 		if CheckInteractDistance("party3", 4) then					
	-- 			FollowUnit(duiyou3);
	-- 			return
	-- 		end
	-- 	end
	-- end
	-- if IsInGroup()==true then
	-- 	local duiyou4,_ = UnitName("party4")		
	-- 	if duiyou4 and UnitIsConnected("Party4") then --玩家未离线
	-- 		if CheckInteractDistance("party4", 4) then					
	-- 			FollowUnit(duiyou4);
	-- 			return
	-- 		end
	-- 	end
	-- end
end
---被动跟随函数
local function Classes_Gensui_B()
	if gensui_B_UI:GetChecked() then
		gensui_B_UI:RegisterEvent("CHAT_MSG_PARTY");--收到组队信息
		gensui_B_UI:RegisterEvent("CHAT_MSG_PARTY_LEADER");--当组长发送或接收消息时触发。
		gensui_B_UI:RegisterEvent("CHAT_MSG_RAID");--收到团队信息
		gensui_B_UI:RegisterEvent("CHAT_MSG_RAID_LEADER");--收到团队领导信息
		gensui_B_UI:RegisterEvent("CHAT_MSG_WHISPER");--当收到其他玩家的耳语时触发
		PIG_Per['Classes']['beidongkaiqi']=true
		gensui_B_tishi_UI:Show()
		gensui_Z_UI:Disable();
		gensui_B_CMD_UI:Disable();
		if zhixingzdgensui then zhixingzdgensui:Cancel() end
		if zhixingzBDensui then zhixingzBDensui:Cancel() end
		if IsInGroup() then
			if IsInRaid() then
				SendChatMessage('[!Pig] 已开启被动跟随,收到指令 '..PIG["Classes"]["GensuiKaishi"]..' 跟随；收到 '..PIG["Classes"]["GensuiJieshu"]..' 停止', "RAID", nil);
			else
				SendChatMessage('[!Pig] 已开启被动跟随,收到指令 '..PIG["Classes"]["GensuiKaishi"]..' 跟随；收到 '..PIG["Classes"]["GensuiJieshu"]..' 停止', "PARTY", nil);
			end
		end
	else
		PIG_Per['Classes']['beidongkaiqi']=false
		gensui_B_tishi_UI:Hide();
		gensui_Z_UI:Enable();
		gensui_B_CMD_UI:Enable();
		local name,_ = UnitName("player");
		if zhixingzdgensui then zhixingzdgensui:Cancel() end
		if zhixingzBDensui then zhixingzBDensui:Cancel() end
		FollowUnit(name);
		if IsInGroup() then
			SendChatMessage("[!Pig] 已关闭被动跟随！", "PARTY", nil);
		end
		gensui_B_UI:UnregisterEvent("CHAT_MSG_PARTY");--收到组队信息
		gensui_B_UI:UnregisterEvent("CHAT_MSG_PARTY_LEADER");--当组长发送或接收消息时触发。
		gensui_B_UI:UnregisterEvent("CHAT_MSG_RAID");--收到团队信息
		gensui_B_UI:UnregisterEvent("CHAT_MSG_RAID_LEADER");--收到团队领导信息
		gensui_B_UI:UnregisterEvent("CHAT_MSG_WHISPER");--当收到其他玩家的耳语时触发
	end
	gensui_B_UI:SetScript("OnEvent",function (self,event,arg1,_,_,_,arg5)
		self.wanjiaming=arg5
		local zijirealm = GetRealmName()
		local wanjia, wanjiarealm = strsplit("-", arg5);
		if zijirealm==wanjiarealm then self.wanjiaming=wanjia end
		local function Classes_Gensui_Z_shuaxin()
			FollowUnit(self.wanjiaming);
		end
		if PIG['Classes']['Duizhang']=="ON" then
			if event == "CHAT_MSG_RAID_LEADER" or event == "CHAT_MSG_PARTY_LEADER" or event == "CHAT_MSG_WHISPER" and UnitIsGroupLeader(self.wanjiaming) then
				if arg1 == PIG["Classes"]["GensuiKaishi"] then
					if CheckInteractDistance(self.wanjiaming, 4) then
						if zhixingzdgensui then zhixingzdgensui:Cancel() end
						if zhixingzBDensui then zhixingzBDensui:Cancel() end
						if PIG['Classes']['qianglimoshi']=="ON" then
							zhixingzBDensui=C_Timer.NewTicker(0.5, Classes_Gensui_Z_shuaxin)
						else
							FollowUnit(self.wanjiaming);
						end
						if PIG['Classes']['gensuitishi']=="ON" then
							if event == "CHAT_MSG_RAID" or event == "CHAT_MSG_RAID_LEADER" then
								SendChatMessage("[!Pig] 开始跟随玩家《"..self.wanjiaming.."》，发送"..PIG["Classes"]["GensuiJieshu"].."将停止跟随!", "RAID", nil);
							elseif event == "CHAT_MSG_PARTY" or event == "CHAT_MSG_PARTY_LEADER"then 
								SendChatMessage("[!Pig] 开始跟随玩家《"..self.wanjiaming.."》，发送"..PIG["Classes"]["GensuiJieshu"].."将停止跟随!", "PARTY", nil);
							elseif event == "CHAT_MSG_WHISPER" then
								SendChatMessage("[!Pig] 我已开始跟随你，发送"..PIG["Classes"]["GensuiJieshu"].."将停止跟随！", "WHISPER", nil, self.wanjiaming)
							end
						end
					else
						if PIG['Classes']['gensuitishi']=="ON" then
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
				if arg1 == PIG["Classes"]["GensuiJieshu"] then
					if zhixingzdgensui then zhixingzdgensui:Cancel() end
					if zhixingzBDensui then zhixingzBDensui:Cancel() end
					FollowUnit("player");
					if PIG['Classes']['gensuitishi']=="ON" then		
						if event == "CHAT_MSG_RAID" or event == "CHAT_MSG_RAID_LEADER" then
							SendChatMessage("[!Pig] 停止跟随玩家《"..self.wanjiaming.."》，发送"..PIG["Classes"]["GensuiKaishi"].."将再次跟随", "RAID", nil);
						elseif event == "CHAT_MSG_PARTY" or event == "CHAT_MSG_PARTY_LEADER"then 
							SendChatMessage("[!Pig] 停止跟随玩家《"..self.wanjiaming.."》，发送"..PIG["Classes"]["GensuiKaishi"].."将再次跟随", "PARTY", nil);
						elseif event == "CHAT_MSG_WHISPER" then
							SendChatMessage("[!Pig] 已停止跟随你，发送"..PIG["Classes"]["GensuiKaishi"].."将再次跟随！", "WHISPER", nil, self.wanjiaming);
						end
					end		
				end		
			end
		else
			if event=="CHAT_MSG_RAID" or event=="CHAT_MSG_RAID_LEADER" or event=="CHAT_MSG_PARTY" or event=="CHAT_MSG_PARTY_LEADER" or event=="CHAT_MSG_WHISPER" then
				if not UnitInParty(self.wanjiaming) then return end
				if arg1 == PIG["Classes"]["GensuiKaishi"] then
					if CheckInteractDistance(self.wanjiaming, 4) then
						if zhixingzdgensui then zhixingzdgensui:Cancel() end
						if zhixingzBDensui then zhixingzBDensui:Cancel() end
						if PIG['Classes']['qianglimoshi']=="ON" then
							zhixingzBDensui=C_Timer.NewTicker(0.5, Classes_Gensui_Z_shuaxin)
						else
							FollowUnit(self.wanjiaming);
						end
						if PIG['Classes']['gensuitishi']=="ON" then
							if event == "CHAT_MSG_RAID" or event == "CHAT_MSG_RAID_LEADER" then
								SendChatMessage("[!Pig] 开始跟随玩家《"..self.wanjiaming.."》，发送"..PIG["Classes"]["GensuiJieshu"].."将停止跟随!", "RAID", nil);
							elseif event == "CHAT_MSG_PARTY" or event == "CHAT_MSG_PARTY_LEADER"then 
								SendChatMessage("[!Pig] 开始跟随玩家《"..self.wanjiaming.."》，发送"..PIG["Classes"]["GensuiJieshu"].."将停止跟随!", "PARTY", nil);
							elseif event == "CHAT_MSG_WHISPER" then
								SendChatMessage("[!Pig] 我已开始跟随你，发送"..PIG["Classes"]["GensuiJieshu"].."将停止跟随！", "WHISPER", nil, self.wanjiaming)
							end
						end
					else
						if PIG['Classes']['gensuitishi']=="ON" then
							if event == "CHAT_MSG_RAID" or event == "CHAT_MSG_RAID_LEADER" then
								SendChatMessage("[!Pig] 跟随玩家《"..self.wanjiaming.."》失败，超出距离，请靠近一些!", "RAID", nil);
							elseif event == "CHAT_MSG_PARTY" or event == "CHAT_MSG_PARTY_LEADER"then 
								SendChatMessage("[!Pig] 跟随玩家《"..self.wanjiaming.."》失败，超出距离，请靠近一些!", "PARTY", nil);
							elseif event == "CHAT_MSG_WHISPER" then
								SendChatMessage("[!Pig] 跟随你失败，超出距离，请靠近一些！", "WHISPER", nil, self.wanjiaming)
							end
						end
					end
				elseif (arg1 == PIG["Classes"]["GensuiJieshu"]) then
					if zhixingzdgensui then zhixingzdgensui:Cancel() end
					if zhixingzBDensui then zhixingzBDensui:Cancel() end
					FollowUnit("player");
					if PIG['Classes']['gensuitishi']=="ON" then
						if event == "CHAT_MSG_RAID" or event == "CHAT_MSG_RAID_LEADER" then
							SendChatMessage("[!Pig] 停止跟随玩家《"..self.wanjiaming.."》，发送"..PIG["Classes"]["GensuiKaishi"].."将再次跟随", "RAID", nil);
						elseif event == "CHAT_MSG_PARTY" or event == "CHAT_MSG_PARTY_LEADER"then 
							SendChatMessage("[!Pig] 停止跟随玩家《"..self.wanjiaming.."》，发送"..PIG["Classes"]["GensuiKaishi"].."将再次跟随", "PARTY", nil);
						elseif event == "CHAT_MSG_WHISPER" then
							SendChatMessage("[!Pig] 已停止跟随你，发送"..PIG["Classes"]["GensuiKaishi"].."将再次跟随！", "WHISPER", nil, self.wanjiaming);
						end
					end		
				end		
			end
		end
	end);
end
local gensuizidongjiuweiFFF = CreateFrame("Frame");
local function Classes_Gensui()
	local ZiFuFamre =Classes_UI.nr
	local aciWidth = ActionButton1:GetWidth()
	local Width,Height=aciWidth,aciWidth;
	if PIG["Classes"]["GensuiName"]==nil or PIG["Classes"]["GensuiName"]=="" then
		ST_Z_EUI:SetText("");
	else
		ST_Z_EUI:SetText(PIG["Classes"]["GensuiName"]);
	end
	if PIG["Classes"]["GensuiKaishi"]==nil or PIG["Classes"]["GensuiKaishi"]=="" then
		ST_B_E_UI:SetText("");
	else
		ST_B_E_UI:SetText(PIG["Classes"]["GensuiKaishi"]);
	end
	if PIG["Classes"]["GensuiJieshu"]==nil or PIG["Classes"]["GensuiJieshu"]=="" then
		ST_B_E_E_UI:SetText("");
	else
		ST_B_E_E_UI:SetText(PIG["Classes"]["GensuiJieshu"]);
	end
	if gensui_Z_UI==nil then
		--主动
		ZiFuFamre.gensui_Z = CreateFrame("CheckButton", "gensui_Z_UI", ZiFuFamre, "ChatConfigCheckButtonTemplate");
		ZiFuFamre.gensui_Z:SetSize(Width-2,Height-2);
		local LEFTjuli = {ZiFuFamre:GetChildren()};
		ZiFuFamre.gensui_Z:SetPoint("LEFT",ZiFuFamre,"LEFT",(#LEFTjuli-1)*(Width+2)+4,-3);
		ZiFuFamre.gensui_Z:SetHitRectInsets(0,0,0,0);
		ZiFuFamre.gensui_Z.Text:SetText("主");
		ZiFuFamre.gensui_Z.Text:ClearAllPoints();
		ZiFuFamre.gensui_Z.Text:SetTextColor(0, 1, 0, 0.8);
		ZiFuFamre.gensui_Z.Text:SetPoint("TOP",ZiFuFamre.gensui_Z,"TOP",0,4);
		ZiFuFamre.gensui_Z.tooltip = "|cff00FF00主动跟随|r\n|cff00FFFF开启后将自动跟随特定目标！\n跟随目标优先级:自定义角色>当前目标！|r\n可自定义优先跟随角色/自动确认就位，跟随指令会定时刷新！";

		local gensui_Z_tishi = CreateFrame("Frame", "gensui_Z_tishi_UI", UIParent)
		gensui_Z_tishi:SetSize(200,50);
		gensui_Z_tishi:SetPoint("CENTER", UIParent, "CENTER", 0, 50);
		gensui_Z_tishi:Hide();
		gensui_Z_tishi.t = gensui_Z_tishi:CreateFontString();
		gensui_Z_tishi.t:SetPoint("CENTER", gensui_Z_tishi, "CENTER", 0, 0);
		gensui_Z_tishi.t:SetFont(GameFontNormal:GetFont(), 30,"OUTLINE")
		gensui_Z_tishi.t:SetTextColor(0/255, 215/255, 255/255, 1);
		gensui_Z_tishi.t:SetText('|cff00FF00主动|r跟随中...');
		ZiFuFamre.gensui_Z:SetScript("OnClick", function (self)
			if self:GetChecked() then
				if zhixingzdgensui then zhixingzdgensui:Cancel() end
				if zhixingzBDensui then zhixingzBDensui:Cancel() end
				zhixingzdgensui=C_Timer.NewTicker(0.5, Classes_Gensui_Z)
				gensui_Z_tishi:Show()
				gensui_B_UI:Disable();
			else
				gensui_Z_tishi:Hide();
				gensui_B_UI:Enable();
				if zhixingzdgensui then zhixingzdgensui:Cancel() end
				if zhixingzBDensui then zhixingzBDensui:Cancel() end
				local name,_ = UnitName("player");
				FollowUnit(name);
			end
		end);
		--被动
		ZiFuFamre.gensui_B = CreateFrame("CheckButton", "gensui_B_UI", ZiFuFamre, "ChatConfigCheckButtonTemplate");
		ZiFuFamre.gensui_B:SetSize(Width-2,Height-2);
		ZiFuFamre.gensui_B:SetPoint("LEFT",ZiFuFamre.gensui_Z,"RIGHT",0,0);
		ZiFuFamre.gensui_B:SetHitRectInsets(0,0,0,0);
		ZiFuFamre.gensui_B.Text:SetText("被");
		ZiFuFamre.gensui_B.Text:ClearAllPoints();
		ZiFuFamre.gensui_B.Text:SetTextColor(1, 1, 0, 0.8);
		ZiFuFamre.gensui_B.Text:SetPoint("TOP",ZiFuFamre.gensui_B,"TOP",0,4);
		ZiFuFamre.gensui_B.tooltip = "|cffffFF00被动跟随|r\n|cff00FFFF开启后收到预设指令将自动开始或停止跟随指令目标！|r\n可在设置内自定义跟随指令/自动确认就位/只跟随队长！";

		local gensui_B_tishi = CreateFrame("Frame", "gensui_B_tishi_UI", UIParent)
		gensui_B_tishi:SetSize(200,50);
		gensui_B_tishi:SetPoint("CENTER", UIParent, "CENTER", 0, 50);
		gensui_B_tishi:Hide();
		gensui_B_tishi.t = gensui_B_tishi:CreateFontString();
		gensui_B_tishi.t:SetPoint("CENTER", gensui_B_tishi, "CENTER", 0, 0);
		gensui_B_tishi.t:SetFont(GameFontNormal:GetFont(), 30,"OUTLINE")
		gensui_B_tishi.t:SetTextColor(0/255, 215/255, 255/255, 1);
		gensui_B_tishi.t:SetText('|cffffFF00被动|r跟随中...');
		ZiFuFamre.gensui_B_CMD = CreateFrame("Button", "gensui_B_CMD_UI", ZiFuFamre, "UIPanelButtonTemplate");
		ZiFuFamre.gensui_B_CMD:SetSize(Width-2,Height-2);
		ZiFuFamre.gensui_B_CMD:SetPoint("LEFT",ZiFuFamre.gensui_B,"RIGHT",0,3); 
		ZiFuFamre.gensui_B_CMD:SetText("被");
		ZiFuFamre.gensui_B_CMD:RegisterForClicks("LeftButtonUp","RightButtonUp")
		ZiFuFamre.gensui_B:SetScript("OnClick", function (self)
			Classes_Gensui_B()
		end);
		ZiFuFamre.gensui_B_CMD:SetScript("OnEnter", function ()
			GameTooltip:ClearLines();
			GameTooltip:SetOwner(ZiFuFamre.gensui_B_CMD, "ANCHOR_TOPLEFT",2,4);
			GameTooltip:AddLine("左键-|cff00FFFF发送开始跟随指令|r\n右击-|cff00FFFF发送停止跟随指令|r")
			GameTooltip:Show();
		end);
		ZiFuFamre.gensui_B_CMD:SetScript("OnLeave", function ()
			GameTooltip:ClearLines();
			GameTooltip:Hide() 
		end);
		ZiFuFamre.gensui_B_CMD:SetScript("OnClick", function (self,botton)
			if botton=="LeftButton" then
				if IsInGroup() then
					if IsInRaid() then
						SendChatMessage(PIG["Classes"]["GensuiKaishi"], "RAID", nil);
					else
						SendChatMessage(PIG["Classes"]["GensuiKaishi"], "PARTY", nil);
					end
				end
			else
				if IsInGroup() then
					if IsInRaid() then
						SendChatMessage(PIG["Classes"]["GensuiJieshu"], "RAID", nil);
					else
						SendChatMessage(PIG["Classes"]["GensuiJieshu"], "PARTY", nil);
					end
				end
			end
		end);
	end
	addonTable.Classes_gengxinkuanduinfo()
	if PIG_Per['Classes']['beidongkaiqi'] then
		ZiFuFamre.gensui_B:SetChecked(true);
		Classes_Gensui_B()
	end
end

--=============================
--跟随
fuFrame.gensuiF.Gensui = CreateFrame("CheckButton", nil, fuFrame.gensuiF, "ChatConfigCheckButtonTemplate");
fuFrame.gensuiF.Gensui:SetSize(30,32);
fuFrame.gensuiF.Gensui:SetHitRectInsets(0,-100,0,0);
fuFrame.gensuiF.Gensui:SetPoint("BOTTOMLEFT",fuFrame.gensuiF,"TOPLEFT",-10,0);
fuFrame.gensuiF.Gensui.Text:SetText("快捷跟随按钮");
fuFrame.gensuiF.Gensui.tooltip = "启动快捷跟随按钮";
fuFrame.gensuiF.Gensui:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG['Classes']['Gensui']="ON";
		Classes_Gensui()	
		ST_B_Duizhang_UI:Enable();
		ST_B_tishi_UI:Enable();
	else
		PIG['Classes']['Gensui']="OFF";
		Pig_Options_RLtishi_UI:Show()
		ST_B_Duizhang_UI:Disable();
		ST_B_tishi_UI:Disable();
	end
end);
---------------------------------------
--自动就位
gensuizidongjiuweiFFF:SetScript("OnEvent",function (self,event)
	if PIG['Classes']['Assistant']=="ON" then
		if PIG['Classes']['gensuijiuwei']=="ON" then
			if gensui_B_UI or gensui_Z_UI then
				if gensui_B_UI:GetChecked() or gensui_Z_UI:GetChecked() then
					ConfirmReadyCheck(true)
				end
			end
		end
	end
end)
fuFrame.gensuiF.gensuijiuwei = CreateFrame("CheckButton", nil, fuFrame.gensuiF, "ChatConfigCheckButtonTemplate");
fuFrame.gensuiF.gensuijiuwei:SetSize(30,32);
fuFrame.gensuiF.gensuijiuwei:SetHitRectInsets(0,-100,0,0);
fuFrame.gensuiF.gensuijiuwei:SetPoint("TOPLEFT",fuFrame.gensuiF,"TOPLEFT",10,-10);
fuFrame.gensuiF.gensuijiuwei.Text:SetText("跟随开启时自动就位");
fuFrame.gensuiF.gensuijiuwei.tooltip = "开启后，跟随开启后将自动确认就位确认";
fuFrame.gensuiF.gensuijiuwei:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG['Classes']['gensuijiuwei']="ON";
		gensuizidongjiuweiFFF:RegisterEvent("READY_CHECK");
	else
		PIG['Classes']['gensuijiuwei']="OFF";
		gensuizidongjiuweiFFF:UnregisterEvent("READY_CHECK");
	end
end);
--自动交接队长
local yijiaoduizhangFFFF = CreateFrame("Frame");
yijiaoduizhangFFFF:SetScript("OnEvent",function (self,event,arg1,_,_,_,arg5)
	if PIG['Classes']['Assistant']=="ON" then
		if PIG['Classes']['yijiaoduizhang']=="ON" then
			if UnitIsGroupLeader("player") then
				if gensui_B_UI or gensui_Z_UI then
					if gensui_B_UI:GetChecked() or gensui_Z_UI:GetChecked() then
						if string.match(arg1,"队长") or string.match(arg1,"团长") then		
							PromoteToLeader(arg5)
						end
					end
				end
			end
		end
	end
end)
fuFrame.gensuiF.yijiaoduizhang = CreateFrame("CheckButton", nil, fuFrame.gensuiF, "ChatConfigCheckButtonTemplate");
fuFrame.gensuiF.yijiaoduizhang:SetSize(30,32);
fuFrame.gensuiF.yijiaoduizhang:SetHitRectInsets(0,-100,0,0);
fuFrame.gensuiF.yijiaoduizhang:SetPoint("LEFT",fuFrame.gensuiF.gensuijiuwei,"RIGHT",170,0);
fuFrame.gensuiF.yijiaoduizhang.Text:SetText("跟随开启时自动移交队长/团长");
fuFrame.gensuiF.yijiaoduizhang.tooltip = "开启后，跟随开启时收到密语内容为[队长]/[团长]，将自动移交队长/团长给对方";
fuFrame.gensuiF.yijiaoduizhang:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG['Classes']['yijiaoduizhang']="ON";
		if IsInGroup() then
			SendChatMessage('[!Pig] 已开启跟随时自动移交队长,收到密语内容为“队长”将自动移交队长', "PARTY", nil);
		end
		yijiaoduizhangFFFF:RegisterEvent("CHAT_MSG_WHISPER");
	else
		PIG['Classes']['yijiaoduizhang']="OFF";
		yijiaoduizhangFFFF:UnregisterEvent("CHAT_MSG_WHISPER");
	end
end);
----设置主动跟随
fuFrame.gensuiF.ST_Z_t = fuFrame.gensuiF:CreateFontString();
fuFrame.gensuiF.ST_Z_t:SetPoint("TOPLEFT", fuFrame.gensuiF, "TOPLEFT", 14, -44);
fuFrame.gensuiF.ST_Z_t:SetFontObject(GameFontNormalSmall);
fuFrame.gensuiF.ST_Z_t:SetText('|cff00FFFF主动跟随设置|r');
fuFrame.gensuiF.ST_Z_t.ST_Z_E_t = fuFrame.gensuiF:CreateFontString();
fuFrame.gensuiF.ST_Z_t.ST_Z_E_t:SetPoint("LEFT", fuFrame.gensuiF.ST_Z_t, "RIGHT", 20, 0);
fuFrame.gensuiF.ST_Z_t.ST_Z_E_t:SetFontObject(GameFontNormalSmall);
fuFrame.gensuiF.ST_Z_t.ST_Z_E_t:SetText('优先跟随角色：');
fuFrame.gensuiF.ST_Z_E = CreateFrame('EditBox', 'ST_Z_EUI', fuFrame.gensuiF,"BackdropTemplate");
fuFrame.gensuiF.ST_Z_E:SetSize(150,30);
fuFrame.gensuiF.ST_Z_E:SetBackdrop({ bgFile = "interface/common/common-input-border.blp",insets = {left = -6,right = 0,top = 2,bottom = -13}})
fuFrame.gensuiF.ST_Z_E:SetPoint("LEFT",fuFrame.gensuiF.ST_Z_t.ST_Z_E_t,"RIGHT",10,0);
fuFrame.gensuiF.ST_Z_E:SetFontObject(ChatFontNormal);
fuFrame.gensuiF.ST_Z_E:SetAutoFocus(false);
fuFrame.gensuiF.ST_Z_E:EnableMouse(true)
fuFrame.gensuiF.ST_Z_E:SetTextColor(200/255, 200/255, 200/255, 0.8);
fuFrame.gensuiF.ST_Z_E:SetScript("OnEscapePressed", function()
	fuFrame.gensuiF.ST_Z_E:ClearFocus();ST_Z_E_b_UI:Hide();
	fuFrame.gensuiF.ST_Z_E:SetTextColor(200/255, 200/255, 200/255, 0.8); 
end);
fuFrame.gensuiF.ST_Z_E:SetScript("OnEditFocusGained", function() fuFrame.gensuiF.ST_Z_E:SetTextColor(255/255, 255/255, 255/255, 1);ST_Z_E_b_UI:Show(); end);
fuFrame.gensuiF.ST_Z_E:SetScript("OnEditFocusLost", function()
	ST_Z_E_b_UI:Hide(); 
	fuFrame.gensuiF.ST_Z_E:SetTextColor(200/255, 200/255, 200/255, 0.8); 
	PIG["Classes"]["GensuiName"]=fuFrame.gensuiF.ST_Z_E:GetText();
end);
--输入确定
fuFrame.gensuiF.ST_Z_E_b = CreateFrame("Button","ST_Z_E_b_UI",fuFrame.gensuiF, "UIPanelButtonTemplate");  
fuFrame.gensuiF.ST_Z_E_b:SetSize(40,22);
fuFrame.gensuiF.ST_Z_E_b:SetPoint("LEFT",fuFrame.gensuiF.ST_Z_E,"RIGHT",0,0);
fuFrame.gensuiF.ST_Z_E_b:SetText("确定");
fuFrame.gensuiF.ST_Z_E_b:Hide();
fuFrame.gensuiF.ST_Z_E_b:RegisterForClicks("LeftButtonUp", "RightButtonUp");
fuFrame.gensuiF.ST_Z_E_b:SetScript("OnClick", function ()
	fuFrame.gensuiF.ST_Z_E:ClearFocus()
	fuFrame.gensuiF.ST_Z_E:SetTextColor(200/255, 200/255, 200/255, 0.8);
	ST_Z_E_b_UI:Hide();
end);
----------------------------------------
----设置被动跟随
fuFrame.gensuiF.ST_B_t = fuFrame.gensuiF:CreateFontString();
fuFrame.gensuiF.ST_B_t:SetPoint("TOPLEFT", fuFrame.gensuiF, "TOPLEFT", 14, -74);
fuFrame.gensuiF.ST_B_t:SetFontObject(GameFontNormalSmall);
fuFrame.gensuiF.ST_B_t:SetText('|cff00FFFF被动跟随设置|r(收到指定队友发言或密语将自动跟随对方)');
--开始指令
fuFrame.gensuiF.ST_B_E_t = fuFrame.gensuiF:CreateFontString();
fuFrame.gensuiF.ST_B_E_t:SetPoint("TOPLEFT", fuFrame.gensuiF, "TOPLEFT", 30, -100);
fuFrame.gensuiF.ST_B_E_t:SetFontObject(GameFontNormalSmall);
fuFrame.gensuiF.ST_B_E_t:SetText('开始指令：');
fuFrame.gensuiF.ST_B_E = CreateFrame('EditBox', 'ST_B_E_UI', fuFrame.gensuiF,"BackdropTemplate");
fuFrame.gensuiF.ST_B_E:SetSize(100,30);
fuFrame.gensuiF.ST_B_E:SetBackdrop({ bgFile = "interface/common/common-input-border.blp",insets = {left = -6,right = 0,top = 2,bottom = -13}})
fuFrame.gensuiF.ST_B_E:SetPoint("LEFT",fuFrame.gensuiF.ST_B_E_t,"RIGHT",10,0);
fuFrame.gensuiF.ST_B_E:SetFontObject(ChatFontNormal);
fuFrame.gensuiF.ST_B_E:SetAutoFocus(false);
fuFrame.gensuiF.ST_B_E:EnableMouse(true)
fuFrame.gensuiF.ST_B_E:SetTextColor(200/255, 200/255, 200/255, 0.8); 
fuFrame.gensuiF.ST_B_E:SetScript("OnEscapePressed", function() 
	fuFrame.gensuiF.ST_B_E:ClearFocus();ST_B_E_b_UI:Hide(); 
	fuFrame.gensuiF.ST_B_E:SetTextColor(200/255, 200/255, 200/255, 0.8); 
end);
fuFrame.gensuiF.ST_B_E:SetScript("OnEditFocusGained", function() fuFrame.gensuiF.ST_B_E:SetTextColor(255/255, 255/255, 255/255, 1);ST_B_E_b_UI:Show(); end);
fuFrame.gensuiF.ST_B_E:SetScript("OnEditFocusLost", function() 
	ST_B_E_b_UI:Hide(); 
	fuFrame.gensuiF.ST_B_E:SetTextColor(200/255, 200/255, 200/255, 0.8); 
	PIG["Classes"]["GensuiKaishi"]=fuFrame.gensuiF.ST_B_E:GetText();
end);
--输入确定
fuFrame.gensuiF.ST_B_E_b = CreateFrame("Button","ST_B_E_b_UI",fuFrame.gensuiF, "UIPanelButtonTemplate");  
fuFrame.gensuiF.ST_B_E_b:SetSize(40,22);
fuFrame.gensuiF.ST_B_E_b:SetPoint("LEFT",fuFrame.gensuiF.ST_B_E,"RIGHT",0,0);
fuFrame.gensuiF.ST_B_E_b:SetText("确定");
fuFrame.gensuiF.ST_B_E_b:Hide();
fuFrame.gensuiF.ST_B_E_b:RegisterForClicks("LeftButtonUp", "RightButtonUp");
fuFrame.gensuiF.ST_B_E_b:SetScript("OnClick", function ()
		fuFrame.gensuiF.ST_B_E:ClearFocus()
		fuFrame.gensuiF.ST_B_E:SetTextColor(200/255, 200/255, 200/255, 0.8);
		ST_B_E_b_UI:Hide();
end);

--结束指令
fuFrame.gensuiF.ST_B_E_t_E = fuFrame.gensuiF:CreateFontString();
fuFrame.gensuiF.ST_B_E_t_E:SetPoint("TOPLEFT", fuFrame.gensuiF, "TOPLEFT", 280, -100);
fuFrame.gensuiF.ST_B_E_t_E:SetFontObject(GameFontNormalSmall);
fuFrame.gensuiF.ST_B_E_t_E:SetText('停止指令：');
fuFrame.gensuiF.ST_B_E_E = CreateFrame('EditBox', 'ST_B_E_E_UI', fuFrame.gensuiF,"BackdropTemplate");
fuFrame.gensuiF.ST_B_E_E:SetSize(100,30);
fuFrame.gensuiF.ST_B_E_E:SetBackdrop({ bgFile = "interface/common/common-input-border.blp",insets = {left = -6,right = 0,top = 2,bottom = -13}})
fuFrame.gensuiF.ST_B_E_E:SetPoint("LEFT",fuFrame.gensuiF.ST_B_E_t_E,"RIGHT",10,0);
fuFrame.gensuiF.ST_B_E_E:SetFontObject(ChatFontNormal);
fuFrame.gensuiF.ST_B_E_E:SetAutoFocus(false);
fuFrame.gensuiF.ST_B_E_E:EnableMouse(true)
fuFrame.gensuiF.ST_B_E_E:SetTextColor(200/255, 200/255, 200/255, 0.8); 
fuFrame.gensuiF.ST_B_E_E:SetScript("OnEscapePressed", function() 
	fuFrame.gensuiF.ST_B_E_E:ClearFocus();ST_B_E_b_E_UI:Hide();
	fuFrame.gensuiF.ST_B_E_E:SetTextColor(200/255, 200/255, 200/255, 0.8); 
end);
fuFrame.gensuiF.ST_B_E_E:SetScript("OnEditFocusGained", function() fuFrame.gensuiF.ST_B_E_E:SetTextColor(255/255, 255/255, 255/255, 1);ST_B_E_b_E_UI:Show(); end);
fuFrame.gensuiF.ST_B_E_E:SetScript("OnEditFocusLost", function() 
	ST_B_E_b_E_UI:Hide(); 
	fuFrame.gensuiF.ST_B_E_E:SetTextColor(200/255, 200/255, 200/255, 0.8); 
	PIG["Classes"]["GensuiJieshu"]=fuFrame.gensuiF.ST_B_E_E:GetText();
end);
--输入确定
fuFrame.gensuiF.ST_B_E_b_E = CreateFrame("Button","ST_B_E_b_E_UI",fuFrame.gensuiF, "UIPanelButtonTemplate");  
fuFrame.gensuiF.ST_B_E_b_E:SetSize(40,22);
fuFrame.gensuiF.ST_B_E_b_E:SetPoint("LEFT",fuFrame.gensuiF.ST_B_E_E,"RIGHT",0,0);
fuFrame.gensuiF.ST_B_E_b_E:SetText("确定");
fuFrame.gensuiF.ST_B_E_b_E:Hide();
fuFrame.gensuiF.ST_B_E_b_E:RegisterForClicks("LeftButtonUp", "RightButtonUp");
fuFrame.gensuiF.ST_B_E_b_E:SetScript("OnClick", function ()
	fuFrame.gensuiF.ST_B_E_E:ClearFocus()
	fuFrame.gensuiF.ST_B_E_E:SetTextColor(200/255, 200/255, 200/255, 0.8);
	ST_B_E_b_E_UI:Hide();
end);
-------------------------
fuFrame.gensuiF.ST_B_Duizhang = CreateFrame("CheckButton", "ST_B_Duizhang_UI", fuFrame.gensuiF, "ChatConfigCheckButtonTemplate");
fuFrame.gensuiF.ST_B_Duizhang:SetSize(30,32);
fuFrame.gensuiF.ST_B_Duizhang:SetHitRectInsets(0,-100,0,0);
fuFrame.gensuiF.ST_B_Duizhang:SetPoint("TOPLEFT",fuFrame.gensuiF,"TOPLEFT",20,-130);
fuFrame.gensuiF.ST_B_Duizhang.Text:SetText("只接受队长跟随指令");
fuFrame.gensuiF.ST_B_Duizhang.tooltip = "只接受来自队长跟随指令。";
fuFrame.gensuiF.ST_B_Duizhang:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG['Classes']['Duizhang']="ON";
	else
		PIG['Classes']['Duizhang']="OFF";
	end
end);
--关闭提示
fuFrame.gensuiF.ST_B_tishi = CreateFrame("CheckButton", "ST_B_tishi_UI", fuFrame.gensuiF, "ChatConfigCheckButtonTemplate");
fuFrame.gensuiF.ST_B_tishi:SetSize(30,32);
fuFrame.gensuiF.ST_B_tishi:SetHitRectInsets(0,-100,0,0);
fuFrame.gensuiF.ST_B_tishi:SetPoint("LEFT",fuFrame.gensuiF.ST_B_Duizhang,"RIGHT",160,0);
fuFrame.gensuiF.ST_B_tishi.Text:SetText("跟随状态提示");
fuFrame.gensuiF.ST_B_tishi.tooltip = "开启后，跟随成功/失败会在队伍/私聊频道提示";
fuFrame.gensuiF.ST_B_tishi:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG['Classes']['gensuitishi']="ON";
	else
		PIG['Classes']['gensuitishi']="OFF";
	end
end);
--强力模式
fuFrame.gensuiF.qianglimoshi = CreateFrame("CheckButton", "ST_B_tishi_UI", fuFrame.gensuiF, "ChatConfigCheckButtonTemplate");
fuFrame.gensuiF.qianglimoshi:SetSize(30,32);
fuFrame.gensuiF.qianglimoshi:SetHitRectInsets(0,-80,0,0);
fuFrame.gensuiF.qianglimoshi:SetPoint("LEFT",fuFrame.gensuiF.ST_B_tishi,"RIGHT",120,0);
fuFrame.gensuiF.qianglimoshi.Text:SetText("强力模式");
fuFrame.gensuiF.qianglimoshi.tooltip = "开启后，在未收到停止指令前不会停止跟随";
fuFrame.gensuiF.qianglimoshi:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG['Classes']['qianglimoshi']="ON";
	else
		PIG['Classes']['qianglimoshi']="OFF";
	end
end);
--=================================================
addonTable.Classes_Gensui = function()
	PIG['Classes']['gensuijiuwei']=PIG['Classes']['gensuijiuwei'] or addonTable.Default['Classes']['gensuijiuwei']
	PIG['Classes']['qianglimoshi']=PIG['Classes']['qianglimoshi'] or addonTable.Default['Classes']['qianglimoshi']
	PIG['Classes']['yijiaoduizhang']=PIG['Classes']['yijiaoduizhang'] or addonTable.Default['Classes']['yijiaoduizhang']
	if PIG['Classes']['Gensui']=="ON" then
		fuFrame.gensuiF.Gensui:SetChecked(true);
	end
	if PIG['Classes']['Duizhang']=="ON" then
		ST_B_Duizhang_UI:SetChecked(true);
	end
	if PIG['Classes']['gensuitishi']=="ON" then
		ST_B_tishi_UI:SetChecked(true);
	end
	if PIG['Classes']['qianglimoshi']=="ON" then
		fuFrame.gensuiF.qianglimoshi:SetChecked(true);
	end
	if PIG['Classes']['gensuijiuwei']=="ON" then
		fuFrame.gensuiF.gensuijiuwei:SetChecked(true);
		gensuizidongjiuweiFFF:RegisterEvent("READY_CHECK");
	end
	if PIG['Classes']['yijiaoduizhang']=="ON" then
		fuFrame.gensuiF.yijiaoduizhang:SetChecked(true);
		yijiaoduizhangFFFF:RegisterEvent("CHAT_MSG_WHISPER");
	end
	if PIG['Classes']['Assistant']=="ON" then
		fuFrame.gensuiF.Gensui:Enable();
		ST_B_Duizhang_UI:Enable();
		ST_B_tishi_UI:Enable();
		if PIG['Classes']['Gensui']=="ON" then
			Classes_Gensui()
		end
	elseif PIG['Classes']['Assistant']=="OFF" then
		fuFrame.gensuiF.Gensui:Disable();
		ST_B_Duizhang_UI:Disable();
		ST_B_tishi_UI:Disable();
	end
end