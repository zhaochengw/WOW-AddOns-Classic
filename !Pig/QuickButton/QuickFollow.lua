local _, addonTable = ...;
--------
local fuFrame = List_R_F_2_4
local ADD_Checkbutton=addonTable.ADD_Checkbutton
--=======================================
---主动跟随函数
local function Classes_Gensui_Z(botton)
	if botton=="LeftButton" then
		if PIG["QuickFollow"]["Name"]~=nil and PIG["QuickFollow"]["Name"]~="" then
			local isRecognized = IsRecognizedName(PIG["QuickFollow"]["Name"], AUTOCOMPLETE_FLAG_ONLINE, AUTOCOMPLETE_FLAG_NONE)
			if isRecognized then
				FollowUnit(PIG["QuickFollow"]["Name"]);
			end
		end
	else
		local name,_ = UnitName("player");
		--判断目标
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
end
---被动跟随函数
local Macro_FollowName = "PIGFOLLOW"

local function kaishiMsg()
	if IsInGroup() then
		if IsInRaid() then
			SendChatMessage('[!Pig] 开始接收指令,发送 '..PIG["QuickFollow"]["Jieshu"]..' 停止接收', "RAID", nil);
		else
			SendChatMessage('[!Pig] 开始接收指令,发送 '..PIG["QuickFollow"]["Jieshu"]..' 停止接收', "PARTY", nil);
		end
	end
end
local function jieshuMsg()
	if IsInGroup() then
		if IsInRaid() then
			SendChatMessage('[!Pig] 停止接收指令,发送 '..PIG["QuickFollow"]["Kaishi"]..' 开始接收', "RAID", nil);
		else
			SendChatMessage('[!Pig] 停止接收指令,发送 '..PIG["QuickFollow"]["Kaishi"]..' 开始接收', "PARTY", nil);
		end
	end
end

local function Classes_Gensui_B(Booleans)
	local macroSlot = GetMacroIndexByName(Macro_FollowName)
	if macroSlot==0 then
		if Gensui_B_UI then Gensui_B_UI:SetChecked(false) end
		fuFrame.gensuiF.B_Open:SetChecked(false);
		PIG_print("没有检测到跟随宏")
		PIG_Per["QuickFollow"]["beidongOpen"]=false
		return
	end
	if Booleans then
		if Gensui_B_UI then Gensui_B_UI:SetChecked(true) end
		fuFrame.gensuiF.B_Open:SetChecked(true);
		fuFrame.gensuiF:RegisterEvent("AUTOFOLLOW_BEGIN");
		fuFrame.gensuiF:RegisterEvent("AUTOFOLLOW_END");
		fuFrame.gensuiF:RegisterEvent("READY_CHECK");
		fuFrame.gensuiF:RegisterEvent("CHAT_MSG_PARTY");--收到组队信息
		fuFrame.gensuiF:RegisterEvent("CHAT_MSG_PARTY_LEADER");--当组长发送或接收消息时触发。
		fuFrame.gensuiF:RegisterEvent("CHAT_MSG_RAID");--收到团队信息
		fuFrame.gensuiF:RegisterEvent("CHAT_MSG_RAID_LEADER");--收到团队领导信息
		fuFrame.gensuiF:RegisterEvent("CHAT_MSG_WHISPER");--当收到其他玩家的耳语时触发
		gensuiB_UI_tishi:Show()
		if Gensui_B_CMD_UI then Gensui_B_CMD_UI:Disable() end
		if PIG["QuickFollow"]["Yijiao"] and IsInGroup() then
			SendChatMessage('[!Pig] 已开启自动移交队长,收到密语内容为“队长”将自动移交队长', "PARTY", nil);
		end
		kaishiMsg()
	else
		if Gensui_B_UI then Gensui_B_UI:SetChecked(false) end
		fuFrame.gensuiF.B_Open:SetChecked(false);
		fuFrame.gensuiF:UnregisterEvent("AUTOFOLLOW_BEGIN");
		fuFrame.gensuiF:UnregisterEvent("AUTOFOLLOW_END");
		fuFrame.gensuiF:UnregisterEvent("READY_CHECK");
		fuFrame.gensuiF:UnregisterEvent("CHAT_MSG_PARTY");--收到组队信息
		fuFrame.gensuiF:UnregisterEvent("CHAT_MSG_PARTY_LEADER");--当组长发送或接收消息时触发。
		fuFrame.gensuiF:UnregisterEvent("CHAT_MSG_RAID");--收到团队信息
		fuFrame.gensuiF:UnregisterEvent("CHAT_MSG_RAID_LEADER");--收到团队领导信息
		fuFrame.gensuiF:UnregisterEvent("CHAT_MSG_WHISPER");--当收到其他玩家的耳语时触发
		gensuiB_UI_tishi:Hide();
		if Gensui_B_CMD_UI then Gensui_B_CMD_UI:Enable() end
		FollowUnit("player");
		jieshuMsg()
	end
	fuFrame.gensuiF:SetScript("OnEvent",function (self,event,arg1,_,_,_,arg5)
		if event=="READY_CHECK" then
			if PIG["QuickFollow"]["Jiuwei"] then
				ConfirmReadyCheck(true)--自动就位
			end
		elseif event=="AUTOFOLLOW_BEGIN" then
			if PIG["QuickFollow"]["Tishi"] then
				if IsInGroup() then
					if IsInRaid() then
						SendChatMessage("[!Pig] 开始跟随玩家《"..arg1.."》", "RAID", nil);
					else 
						SendChatMessage("[!Pig] 开始跟随玩家《"..arg1.."》", "PARTY", nil);
					end
				end
			end	
		elseif event=="AUTOFOLLOW_END" then
			if PIG["QuickFollow"]["Tishi"] then
				if IsInGroup() then
					if IsInRaid() then
						SendChatMessage("[!Pig] 已停止跟随", "RAID", nil);
					else 
						SendChatMessage("[!Pig] 已停止跟随", "PARTY", nil);
					end
				end
			end
		else
			local feizidonghuifu=arg1:find("[!Pig]", 1)
			if feizidonghuifu then return end
			if event=="CHAT_MSG_WHISPER" then
				if PIG["QuickFollow"]["Yijiao"] then
					if UnitIsGroupLeader("player") then
						if string.match(arg1,"队长") or string.match(arg1,"团长") then		
							PromoteToLeader(arg5)--自动交接队长
						end
					end
				end
			end
			--
			if arg1 ~= PIG["QuickFollow"]["Kaishi"] and arg1 ~= PIG["QuickFollow"]["Jieshu"] then
				return 
			end
			local wanjiamingpp=arg5
			local zijirealm = GetRealmName()
			local wanjia, wanjiarealm = strsplit("-", arg5);
			if wanjiarealm and zijirealm==wanjiarealm then wanjiamingpp=wanjia end
			if not UnitInParty(wanjiamingpp) and not UnitInRaid(wanjiamingpp) then
				EditMacro(macroSlot, nil, nil, "/follow player")
				return 
			end

			local macroSlot = GetMacroIndexByName(Macro_FollowName)
			if arg1 == PIG["QuickFollow"]["Kaishi"] then
				if PIG["QuickFollow"]["Duizhang"] then
					if UnitIsGroupLeader(wanjiamingpp,"LE_PARTY_CATEGORY_HOME") then
						EditMacro(macroSlot, nil, nil, "/follow "..wanjiamingpp)
					end
				else
					EditMacro(macroSlot, nil, nil, "/follow "..wanjiamingpp)
				end
			elseif arg1 == PIG["QuickFollow"]["Jieshu"] then
				EditMacro(macroSlot, nil, nil, "/follow player")
			end
		end
	end);
end
-------------------
--创建快捷按钮
local function QuickButton_Gensui()
	if Gensui_Z_UI then return end
	local QkbutF = QuickButtonUI.nr
	local butW = QkbutF:GetHeight()
	--主动
	local gensuiZ  = CreateFrame("Button", "Gensui_Z_UI", QkbutF, "UIPanelButtonTemplate");
	gensuiZ:SetSize(butW-5,butW-5);
	local Children = {QkbutF:GetChildren()};
	local geshu = #Children;
	gensuiZ:SetPoint("LEFT",QkbutF,"LEFT",(geshu-1)*(butW),1);
	gensuiZ:SetText("主");
	gensuiZ:RegisterForClicks("LeftButtonUp","RightButtonUp")
	gensuiZ:SetScript("OnEnter", function (self)
		GameTooltip:ClearLines();
		GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT",2,4);
		GameTooltip:AddLine("左键-|cff00FFFF跟随自定义角色！|r\n右击-|cff00FFFF随机跟随,目标优先级:当前目标>队友1/2/3/4|r")
		GameTooltip:Show();
	end);
	gensuiZ:SetScript("OnLeave", function ()
		GameTooltip:ClearLines();
		GameTooltip:Hide() 
	end);
	gensuiZ:SetScript("OnClick", function (self,botton)
		Classes_Gensui_Z(botton)
	end);
	--被动
	local gensuiB = CreateFrame("CheckButton", "Gensui_B_UI", QkbutF, "ChatConfigCheckButtonTemplate");
	gensuiB:SetSize(butW,butW);
	gensuiB:SetPoint("LEFT",gensuiZ,"RIGHT",0,-4);
	gensuiB:SetHitRectInsets(0,0,0,0);
	gensuiB.Text:SetText("宏");
	gensuiB.Text:ClearAllPoints();
	gensuiB.Text:SetTextColor(1, 1, 0, 0.8);
	gensuiB.Text:SetPoint("TOP",gensuiB,"TOP",0,4);
	gensuiB.tooltip = "|cffffFF00动态切换宏跟随目标|r\n|cff00FFFF创建宏以后，可以根据接收到指令修改宏内的跟随目标(在插件设置创建宏)|r\n注意跟随还是需要手动点击宏！";
	gensuiB:SetScript("OnClick", function (self)
		if self:GetChecked() then
			fuFrame.gensuiF.B_Open:SetChecked(true)
			PIG_Per["QuickFollow"]["beidongOpen"]=true
		else
			fuFrame.gensuiF.B_Open:SetChecked(false)
			PIG_Per["QuickFollow"]["beidongOpen"]=false
		end
		Classes_Gensui_B(PIG_Per["QuickFollow"]["beidongOpen"])
	end);

	----
	local gensuiCMD = CreateFrame("Button", "Gensui_B_CMD_UI", QkbutF, "UIPanelButtonTemplate");
	gensuiCMD:SetSize(butW-5,butW-5);
	gensuiCMD:SetPoint("LEFT",gensuiB,"RIGHT",0,3); 
	gensuiCMD:SetText("令");
	gensuiCMD:RegisterForClicks("LeftButtonUp","RightButtonUp")
	gensuiCMD:SetScript("OnEnter", function (self)
		GameTooltip:ClearLines();
		GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT",2,4);
		GameTooltip:AddLine("左键-|cff00FFFF发送开始切换指令|r\n右击-|cff00FFFF发送停止切换指令|r")
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
					SendChatMessage(PIG["QuickFollow"]["Kaishi"], "RAID", nil);
				else
					SendChatMessage(PIG["QuickFollow"]["Kaishi"], "PARTY", nil);
				end
			end
		else
			if IsInGroup() then
				if IsInRaid() then
					SendChatMessage(PIG["QuickFollow"]["Jieshu"], "RAID", nil);
				else
					SendChatMessage(PIG["QuickFollow"]["Jieshu"], "PARTY", nil);
				end
			end
		end
	end);
	if PIG_Per["QuickFollow"]["beidongOpen"] then Gensui_B_UI:SetChecked(true) Gensui_B_CMD_UI:Disable() end
	local Qfff = QuickButtonUI
	Qfff:Show();
	local NewWidth = butW*(geshu+2);
	Qfff.nr:SetWidth(NewWidth);
	Qfff:SetWidth(NewWidth+12);
end
fuFrame.QuickBut=ADD_Checkbutton(nil,fuFrame,-60,"TOPLEFT",fuFrame,"TOPLEFT",20,-20,"添加<跟随开关>到快捷按钮栏","在快捷按钮栏显示跟随开关按钮\n|cff00FF00注意：此功能需先打开快捷按钮栏功能|r")
fuFrame.QuickBut:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG["QuickFollow"]["QuickBut"]=true;
		QuickButton_Gensui()
	else
		PIG["QuickFollow"]["QuickBut"]=false;
		Pig_Options_RLtishi_UI:Show()
	end
end);
-----------------------------
fuFrame.gensuijiuwei=ADD_Checkbutton(nil,fuFrame,-100,"TOPLEFT",fuFrame,"TOPLEFT",20,-60,"跟随时自动就位","开启后，跟随时将自动确认就位确认")
fuFrame.gensuijiuwei:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG["QuickFollow"]["Jiuwei"]=true;
	else
		PIG["QuickFollow"]["Jiuwei"]=false;
	end
end);
fuFrame.yijiaoduizhang=ADD_Checkbutton(nil,fuFrame,-100,"TOPLEFT",fuFrame,"TOPLEFT",300,-60,"跟随时自动移交队长/团长","开启后，跟随时收到密语内容为[队长]/[团长]，将自动移交队长/团长给对方")
fuFrame.yijiaoduizhang:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG["QuickFollow"]["Yijiao"]=true;
	else
		PIG["QuickFollow"]["Yijiao"]=false;
	end
end);
--提示
fuFrame.GensuiTishi=ADD_Checkbutton(nil,fuFrame,-100,"TOPLEFT",fuFrame,"TOPLEFT",300,-20,"开始和停止跟随提示","开启后，开始和停止跟随会在队伍/私聊频道提示")
fuFrame.GensuiTishi:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG["QuickFollow"]["Tishi"]=true;
	else
		PIG["QuickFollow"]["Tishi"]=false;
	end
end);
fuFrame.wlktishi = fuFrame:CreateFontString();
fuFrame.wlktishi:SetPoint("TOPLEFT", fuFrame, "TOPLEFT", 26, -110);
fuFrame.wlktishi:SetFont(ChatFontNormal:GetFont(), 16,"OUTLINE")
fuFrame.wlktishi:SetTextColor(1, 0, 0, 1);
fuFrame.wlktishi:SetText('注意：暴雪已不允许远程激活跟随命令，现在跟随命令只响应硬件事件');
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
gensuiB_tishi.t:SetText('|cffffFF00接收|r|cff00D7FF切换指令中...|r');

fuFrame.gensuiF.ST_B_t = fuFrame.gensuiF:CreateFontString();
fuFrame.gensuiF.ST_B_t:SetPoint("TOPLEFT", fuFrame.gensuiF, "TOPLEFT", 10, -10);
fuFrame.gensuiF.ST_B_t:SetFontObject(GameFontNormalSmall);
fuFrame.gensuiF.ST_B_t:SetText('|cff00FFFF跟随宏|r(根据队友发言指令切换宏命令内的跟随目标)');

fuFrame.gensuiF.B_Open=ADD_Checkbutton(nil,fuFrame.gensuiF,-100,"TOPLEFT",fuFrame.gensuiF,"TOPLEFT",20,-40,"开启动态切换跟随目标","根据队友发言指令切换宏命令的跟随目标")
fuFrame.gensuiF.B_Open:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG_Per["QuickFollow"]["beidongOpen"]=true
		if Gensui_B_UI then Gensui_B_UI:SetChecked(true) end
	else
		PIG_Per["QuickFollow"]["beidongOpen"]=false
		if Gensui_B_UI then Gensui_B_UI:SetChecked(false) end
	end
	Classes_Gensui_B(PIG_Per["QuickFollow"]["beidongOpen"])
end)
fuFrame.gensuiF.ST_B_Duizhang=ADD_Checkbutton(nil,fuFrame.gensuiF,-100,"TOPLEFT",fuFrame.gensuiF,"TOPLEFT",300,-40,"只接受队长切换指令","只接受来自队长切换指令")
fuFrame.gensuiF.ST_B_Duizhang:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG["QuickFollow"]["Duizhang"]=true;
	else
		PIG["QuickFollow"]["Duizhang"]=false;
	end
end);
--开始指令
fuFrame.gensuiF.ST_B_E_t = fuFrame.gensuiF:CreateFontString();
fuFrame.gensuiF.ST_B_E_t:SetPoint("TOPLEFT", fuFrame.gensuiF.B_Open, "BOTTOMLEFT", 6, -15);
fuFrame.gensuiF.ST_B_E_t:SetFontObject(GameFontNormalSmall);
fuFrame.gensuiF.ST_B_E_t:SetText('开始切换指令：');
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
	ESCbianji_E(self,fuFrame.gensuiF.ST_B_E_b,"QuickFollow","Kaishi")
end);
fuFrame.gensuiF.ST_B_E:SetScript("OnEnterPressed", function(self)
	baocunbianji_E(self,fuFrame.gensuiF.ST_B_E_b,"QuickFollow","Kaishi")
end);
fuFrame.gensuiF.ST_B_E_b = CreateFrame("Button",nil,fuFrame.gensuiF, "UIPanelButtonTemplate");  
fuFrame.gensuiF.ST_B_E_b:SetSize(40,22);
fuFrame.gensuiF.ST_B_E_b:SetPoint("LEFT",fuFrame.gensuiF.ST_B_E,"RIGHT",0,0);
fuFrame.gensuiF.ST_B_E_b:SetText("确定");
fuFrame.gensuiF.ST_B_E_b:Hide();
fuFrame.gensuiF.ST_B_E_b:RegisterForClicks("LeftButtonUp", "RightButtonUp");
fuFrame.gensuiF.ST_B_E_b:SetScript("OnClick", function (self)
	baocunbianji_E(fuFrame.gensuiF.ST_B_E,self,"QuickFollow","Kaishi")
end);
--结束指令
fuFrame.gensuiF.ST_B_E_t_E = fuFrame.gensuiF:CreateFontString();
fuFrame.gensuiF.ST_B_E_t_E:SetPoint("LEFT", fuFrame.gensuiF.ST_B_E_t, "RIGHT", 170, 0);
fuFrame.gensuiF.ST_B_E_t_E:SetFontObject(GameFontNormalSmall);
fuFrame.gensuiF.ST_B_E_t_E:SetText('停止切换指令：');
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
	ESCbianji_E(self,fuFrame.gensuiF.ST_B_E_b_E,"QuickFollow","Jieshu")
end);
fuFrame.gensuiF.ST_B_E_E:SetScript("OnEnterPressed", function(self)
	baocunbianji_E(self,fuFrame.gensuiF.ST_B_E_b_E,"QuickFollow","Jieshu")
end);
fuFrame.gensuiF.ST_B_E_b_E = CreateFrame("Button",nil,fuFrame.gensuiF, "UIPanelButtonTemplate");  
fuFrame.gensuiF.ST_B_E_b_E:SetSize(40,22);
fuFrame.gensuiF.ST_B_E_b_E:SetPoint("LEFT",fuFrame.gensuiF.ST_B_E_E,"RIGHT",0,0);
fuFrame.gensuiF.ST_B_E_b_E:SetText("确定");
fuFrame.gensuiF.ST_B_E_b_E:Hide();
fuFrame.gensuiF.ST_B_E_b_E:RegisterForClicks("LeftButtonUp", "RightButtonUp");
fuFrame.gensuiF.ST_B_E_b_E:SetScript("OnClick", function (self)
	baocunbianji_E(fuFrame.gensuiF.ST_B_E_E,self,"QuickFollow","Jieshu")
end);
fuFrame.gensuiF:HookScript("OnHide", function(self)
	ESCbianji_E(fuFrame.gensuiF.ST_B_E,fuFrame.gensuiF.ST_B_E_b,"QuickFollow","Kaishi")
	ESCbianji_E(fuFrame.gensuiF.ST_B_E_E,fuFrame.gensuiF.ST_B_E_b_E,"QuickFollow","Jieshu")
end);
-------------------------
fuFrame.gensuiF.New_hong = CreateFrame("Button",nil,fuFrame.gensuiF, "UIPanelButtonTemplate");  
fuFrame.gensuiF.New_hong:SetSize(140,24);
fuFrame.gensuiF.New_hong:SetPoint("TOPLEFT",fuFrame.gensuiF,"TOPLEFT",20,-120);
fuFrame.gensuiF.New_hong:SetText('创建跟随宏');
fuFrame.gensuiF.New_hong:SetScript("OnClick", function ()
	local macroSlot = GetMacroIndexByName(Macro_FollowName)
	if macroSlot>0 then
		StaticPopup_Show ("ADD_GENSUI_HONG");
	else
		local global, perChar = GetNumMacros()
		if global<120 then
			StaticPopup_Show ("ADD_GENSUI_HONG");
		else
			print("|cff00FFFF!Pig:|r|cffFFFF00你的宏数量已达最大值120，请删除一些再尝试。|r");
		end
	end
end)
---
local function NEW_hong()
	local macroSlot = GetMacroIndexByName(Macro_FollowName)
	local hanhuaneirong1="/follow 猪猪加油";
	if macroSlot==0 then
		CreateMacro(Macro_FollowName, 135994, hanhuaneirong1, nil)
	else
		EditMacro(macroSlot, nil, 135994, hanhuaneirong1)
	end
end
StaticPopupDialogs["ADD_GENSUI_HONG"] = {
	text = "将创建一个跟随宏，请拖拽到动作条使用\n\n确定创建吗？\n\n",
	button1 = "确定",
	button2 = "取消",
	OnAccept = function()
		NEW_hong()
	end,
	timeout = 0,
	whileDead = true,
	hideOnEscape = true,
}
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
fuFrame.gensuiFZ.ST_Z_t:SetText('|cff00FFFF主动跟随设置|r');

fuFrame.gensuiFZ.ST_Z_t.ST_Z_E_t = fuFrame.gensuiFZ:CreateFontString();
fuFrame.gensuiFZ.ST_Z_t.ST_Z_E_t:SetPoint("TOPLEFT", fuFrame.gensuiFZ.ST_Z_t, "BOTTOMLEFT", 4, -20);
fuFrame.gensuiFZ.ST_Z_t.ST_Z_E_t:SetFontObject(GameFontNormalSmall);
fuFrame.gensuiFZ.ST_Z_t.ST_Z_E_t:SetText('自定义跟随角色：');
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
	ESCbianji_E(self,fuFrame.gensuiFZ.ST_Z_E_b,"QuickFollow","Name")
end);
fuFrame.gensuiFZ.ST_Z_E:SetScript("OnEnterPressed", function(self)
	baocunbianji_E(self,fuFrame.gensuiFZ.ST_Z_E_b,"QuickFollow","Name")
end);
fuFrame.gensuiFZ.ST_Z_E_b = CreateFrame("Button",nil,fuFrame.gensuiFZ, "UIPanelButtonTemplate");  
fuFrame.gensuiFZ.ST_Z_E_b:SetSize(40,22);
fuFrame.gensuiFZ.ST_Z_E_b:SetPoint("LEFT",fuFrame.gensuiFZ.ST_Z_E,"RIGHT",0,0);
fuFrame.gensuiFZ.ST_Z_E_b:SetText("确定");
fuFrame.gensuiFZ.ST_Z_E_b:Hide();
fuFrame.gensuiFZ.ST_Z_E_b:RegisterForClicks("LeftButtonUp", "RightButtonUp");
fuFrame.gensuiFZ.ST_Z_E_b:SetScript("OnClick", function (self)
	baocunbianji_E(fuFrame.gensuiFZ.ST_Z_E,self,"QuickFollow","Name")
end);
fuFrame.gensuiFZ:HookScript("OnHide", function(self)
	ESCbianji_E(fuFrame.gensuiFZ.ST_Z_E,fuFrame.gensuiFZ.ST_Z_E_b,"QuickFollow","Name")
end);
--=============================
fuFrame:HookScript("OnShow", function(self)
	if PIG["QuickFollow"]["QuickBut"] then
		fuFrame.QuickBut:SetChecked(true);
	end
	fuFrame.gensuiFZ.ST_Z_E:SetText(PIG["QuickFollow"]["Name"]);
	fuFrame.gensuiF.ST_B_E:SetText(PIG["QuickFollow"]["Kaishi"]);
	fuFrame.gensuiF.ST_B_E_E:SetText(PIG["QuickFollow"]["Jieshu"]);
	if PIG["QuickFollow"]["Duizhang"] then
		fuFrame.gensuiF.ST_B_Duizhang:SetChecked(true);
	end
	if PIG["QuickFollow"]["Tishi"] then
		fuFrame.GensuiTishi:SetChecked(true);
	end
	if PIG["QuickFollow"]["Jiuwei"] then
		fuFrame.gensuijiuwei:SetChecked(true);
	end
	if PIG["QuickFollow"]["Yijiao"] then
		fuFrame.yijiaoduizhang:SetChecked(true);
	end
end)
----------
local function ADD_QuickButton_QuickFollow()
	if PIG["QuickButton"]["Open"] then
		fuFrame.QuickBut:Enable()
		if PIG.QuickFollow.QuickBut then
			QuickButton_Gensui()
		end
	else
		fuFrame.QuickBut:Disable()
	end
	if PIG_Per["QuickFollow"]["beidongOpen"] then
		local function Classes_Gensui_B_yanchi()
			Classes_Gensui_B(true)
		end
		C_Timer.After(3,Classes_Gensui_B_yanchi)
	end
end
addonTable.ADD_QuickButton_QuickFollow = ADD_QuickButton_QuickFollow