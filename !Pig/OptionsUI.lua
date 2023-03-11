local addonName, addonTable = ...;
local gsub = _G.string.gsub
local _, _, _, tocversion = GetBuildInfo()
-------
local Create = addonTable.Create
local PIGFrame=Create.PIGFrame
local PIGButton=Create.PIGButton
local PIGTabBut=Create.PIGTabBut
---===================================
local OptionsW,OptionsH,OptionsJG,BottomHHH = 800,600,14,40
local Pig_Options=PIGFrame(UIParent,{OptionsW,OptionsH},{"CENTER",UIParent,"CENTER",0,0},"Pig_OptionsUI",true)
Pig_Options:PIGSetBackdrop()
Pig_Options:SetFrameStrata("HIGH")
--左侧内容
local OptionsLFW =160
Pig_Options.L = CreateFrame("Frame", nil, Pig_Options)
Pig_Options.L:SetWidth(OptionsLFW);
Pig_Options.L:SetPoint("TOPLEFT", Pig_Options, "TOPLEFT", 0, 0)
Pig_Options.L:SetPoint("BOTTOMLEFT", Pig_Options, "BOTTOMLEFT", 0, 0)
Pig_Options.L.top = PIGFrame(Pig_Options.L)
--Pig_Options.L.top:PIGSetBackdrop()
Pig_Options.L.top:SetHeight(40)
Pig_Options.L.top:SetPoint("TOPLEFT", Pig_Options.L, "TOPLEFT", 2, -2)
Pig_Options.L.top:SetPoint("TOPRIGHT", Pig_Options.L, "TOPRIGHT", 0, 0)
Pig_Options.L.top:PIGSetMovable(Pig_Options)
Pig_Options.L.top.title = Pig_Options.L.top:CreateFontString();
Pig_Options.L.top.title:SetPoint("LEFT", Pig_Options.L.top, "LEFT", 12, 2);
Pig_Options.L.top.title:SetFont(GameFontNormal:GetFont(), 28)
Pig_Options.L.top.title:SetText("|cffFF4500!Pig|r");
Pig_Options.L.top.title1 = Pig_Options.L.top:CreateFontString();
Pig_Options.L.top.title1:SetPoint("BOTTOMLEFT", Pig_Options.L.top.title, "BOTTOMRIGHT", 10, 0);
Pig_Options.L.top.title1:SetFont(GameFontNormal:GetFont(), 15)
Pig_Options.L.top.title1:SetText("|cffFF00FF猪猪加油|r");

Pig_Options.L.F = PIGFrame(Pig_Options.L)
Pig_Options.L.F:PIGSetBackdrop()
Pig_Options.L.F:SetPoint("TOPLEFT", Pig_Options.L.top, "BOTTOMLEFT", 0, -40)
Pig_Options.L.F:SetPoint("BOTTOMRIGHT", Pig_Options.L, "BOTTOMRIGHT", 0, BottomHHH)
--右侧内容
Pig_Options.R = CreateFrame("Frame", nil, Pig_Options)
Pig_Options.R:SetPoint("TOPLEFT", Pig_Options, "TOPLEFT", OptionsLFW+OptionsJG, 0)
Pig_Options.R:SetPoint("BOTTOMRIGHT", Pig_Options, "BOTTOMRIGHT", 0, BottomHHH)

Pig_Options.R.top = PIGFrame(Pig_Options.R)
Pig_Options.R.top:SetHeight(24)
Pig_Options.R.top:SetPoint("TOPLEFT", Pig_Options.R, "TOPLEFT", 0, -2)
Pig_Options.R.top:SetPoint("TOPRIGHT", Pig_Options.R, "TOPRIGHT", -2, 0)
Pig_Options.R.top:PIGSetBackdrop()
Pig_Options.R.top:PIGSetMovable(Pig_Options)
Pig_Options.R.top:PIGClose(25,25,Pig_Options)
Pig_Options.R.top.Ver = CreateFrame("Frame", nil, Pig_Options.R.top)
Pig_Options.R.top.Ver:SetPoint("TOPLEFT", Pig_Options.R.top, "TOPLEFT", 0, 0)
Pig_Options.R.top.Ver:SetPoint("BOTTOMRIGHT", Pig_Options.R.top, "BOTTOMRIGHT", -30, 0)

Pig_Options.R.top.Ver.PigVer = Pig_Options.R.top.Ver:CreateFontString();
Pig_Options.R.top.Ver.PigVer:SetPoint("LEFT", Pig_Options.R.top.Ver, "LEFT", 6, 0);
Pig_Options.R.top.Ver.PigVer:SetFontObject(ChatFontNormal);
local benjibanbenhao=GetAddOnMetadata(addonName, "Version")
Pig_Options.R.top.Ver.PigVer:SetText("|cffFFD700版本:|r |cff00FF00"..benjibanbenhao.."|r");

Pig_Options.R.F = PIGFrame(Pig_Options.R)
Pig_Options.R.F:PIGSetBackdrop()
Pig_Options.R.F:SetPoint("TOPLEFT", Pig_Options.R, "TOPLEFT", 0, -60)
Pig_Options.R.F:SetPoint("BOTTOMRIGHT", Pig_Options.R, "BOTTOMRIGHT", -2, 0)
------
local Tab_L={"基础","功能"};
local Tab_LW,Tab_LH=54,24
local LR_W,LR_H=Pig_Options.R.F:GetWidth(),Pig_Options.R.F:GetHeight();
local TabN="interface/optionsframe/ui-optionsframe-inactivetab.blp"
local TabY="interface/optionsframe/ui-optionsframe-activetab.blp"
for i=1, #Tab_L, 1 do
	local TAB = PIGTabBut(Tab_L[i],"LF_TAB_"..i,Pig_Options.L.F,{Tab_LW,Tab_LH},nil,i)
	TAB:SetFrameLevel(Pig_Options.L.F:GetFrameLevel()-1)
	if i==1 then
		TAB:SetPoint("BOTTOMLEFT", Pig_Options.L.F, "TOPLEFT", 14, -1);
	else
		TAB:SetPoint("BOTTOMLEFT", Pig_Options.L.F, "TOPLEFT", 90, -1);
	end
	TAB:SetScript("OnClick", function(self)
		for x=1,#Tab_L do
			local fagg = _G["LF_TAB_"..x]
			local point, relativeTo, relativePoint, xOfs, yOfs = fagg:GetPoint()
			fagg:SetPoint(point, relativeTo, relativePoint, xOfs, -1);
			fagg:NotSelected()
			_G["LF_TAB_F_"..x]:Hide();
		end
		local point, relativeTo, relativePoint, xOfs, yOfs = self:GetPoint()
		self:SetPoint(point, relativeTo, relativePoint, xOfs, 0);
		self:Selected()
		_G["LF_TAB_F_"..self:GetID()]:Show();
	end)	
	local TAB_F = CreateFrame("Frame", "LF_TAB_F_"..i, Pig_Options.L.F)
	TAB_F:SetPoint("TOPLEFT", Pig_Options.L.F, "TOPLEFT", 0, 0)
	TAB_F:SetPoint("BOTTOMRIGHT", Pig_Options.L.F, "BOTTOMRIGHT", 0, 0)
	TAB_F:Hide();
	if i==1 then
		TAB:Selected()
		TAB:SetPoint("BOTTOMLEFT", Pig_Options.L.F, "TOPLEFT", 14, 0);	
		TAB_F:Show();
	elseif i==2 then
		TAB.TexTishi = TAB:CreateTexture(nil, "BORDER");
		TAB.TexTishi:SetTexture("interface/vehicles/arrow.blp");
		TAB.TexTishi:SetBlendMode("ADD")
		PIGRotation(TAB.TexTishi, 180)
		TAB.TexTishi:SetPoint("LEFT", TAB, "RIGHT", 4,0);
		TAB.TexTishi:Hide();
	end	
end
--左边选项内容
local Tab_L_List={
	{"交互增强","聊天增强","战斗辅助","头像增强","显示增强","界面布局","快捷按钮栏","小地图/地图","游戏设置(CVars)","测试功能","露露缇娅","开发工具","配 置","关 于"},
	{"背包整合","拍卖增强","额外动作条","快捷跟随","输出提示","技能监控","售卖助手","专业 C D","时空之门","开团助手","带本助手","离开屏保"},
}
local List_ButH = 26
for i=1, #Tab_L, 1 do
	local L_F_List=_G["LF_TAB_F_"..i]
	for ii=1, #Tab_L_List[i], 1 do
		local List_But = PIGTabBut(Tab_L_List[i][ii],"List_But_"..i.."_"..ii,L_F_List,{Pig_Options.L.F:GetWidth()-4,List_ButH})
		if ii==1 then
			List_But:SetPoint("TOP", L_F_List, "TOP", 0, -8);
		else
			List_But:SetPoint("TOP", _G["List_But_"..i.."_"..(ii-1)], "BOTTOM", 0, -2);
		end
		--右侧内容
		local List_R_F = CreateFrame("Frame", "List_R_F_"..i.."_"..ii, Pig_Options.R.F)
		List_R_F:SetPoint("TOPLEFT", Pig_Options.R.F, "TOPLEFT", 0, 0)
		List_R_F:SetPoint("BOTTOMRIGHT", Pig_Options.R.F, "BOTTOMRIGHT", 0, 0)
		List_R_F:Hide();
		---
		List_But:SetScript("OnClick", function(self)
			for x=1, #Tab_L, 1 do
				for xx=1,#Tab_L_List[x] do
					local fagg = _G["List_But_"..x.."_"..xx]
					fagg:NotSelected()
					_G["List_R_F_"..x.."_"..xx]:Hide();
				end
			end
			self:Selected()
			_G["List_R_F_"..i.."_"..ii]:Show();
		end)
		if i==1 and ii==1 then
			List_But:Selected()
			List_R_F:Show();
		end
	end
end

--界面选项插件菜单==============================================================
local PIG_AddOn = {};
PIG_AddOn.panel = CreateFrame( "Frame", "PIG_AddOnPanel", UIParent );
PIG_AddOn.panel:Hide()
PIG_AddOn.panel.name = "!Pig";
InterfaceOptions_AddCategory(PIG_AddOn.panel);
--子页
PIG_AddOn.childpanel = CreateFrame( "Frame", "PIG_AddOnChild", PIG_AddOn.panel);
PIG_AddOn.childpanel.name = "猪猪加油";
--指定归属父级
PIG_AddOn.childpanel.parent = PIG_AddOn.panel.name;
InterfaceOptions_AddCategory(PIG_AddOn.childpanel);

--打开设置面板
PIG_AddOnPanel.Openshezhi = PIGButton("设置",nil,PIG_AddOnPanel,{80,24},{"TOPLEFT",PIG_AddOnPanel,"TOPLEFT",20,-20})
PIG_AddOnPanel.Openshezhi:SetScript("OnClick", function ()
	HideUIPanel(InterfaceOptionsFrame);
	HideUIPanel(SettingsPanel);
	HideUIPanel(GameMenuFrame);
	Pig_OptionsUI:Show();
end)
-- PIG_AddOnPanel.okay = function (self) SC_ChaChingPanel_Close(); end;
-- PIG_AddOnPanel.cancel = function (self) SC_ChaChingPanel_CancelOrLoad();  end;
--子页内容
local Pigtxt={
	["BT"]="|cff00ff00作者哔哩哔哩账号：|r|cff00FFFFgeligasi|r       |cff00ff00作者抖音账号：|r|cff00ffffgeligasi|r\n\n|cffFF0000***本插件完全免费,网络购物平台出售的皆为骗子***|r",	
	["YY"]="|cff00ff00YY频道\124cff00FFFF113213\124r",
	["QQ"]="|cff00ff00QQ群|r\124cff00FFFF27397148\124r,|cff00ff002群|r\124cff00FFFF117883385\124r",
}
addonTable.Pigtxt=Pigtxt
PIG_AddOnChild.title = PIG_AddOnChild:CreateFontString();
PIG_AddOnChild.title:SetPoint("TOP",PIG_AddOnChild,"TOP",0,-40);
PIG_AddOnChild.title:SetFont(ChatFontNormal:GetFont(), 16, "OUTLINE");
PIG_AddOnChild.title:SetText(Pigtxt.BT.."\n\n"..Pigtxt.YY.."\n\n"..Pigtxt.QQ);

--重载提示
Pig_Options.tishi = CreateFrame("Frame", "Pig_Options_RLtishi_UI", Pig_Options)
Pig_Options.tishi:SetSize(520, 28)
Pig_Options.tishi:SetPoint("BOTTOM", Pig_Options, "BOTTOM", 80, 8)
Pig_Options.tishi:Hide()
Pig_Options.tishi.txt = Pig_Options.tishi:CreateFontString();
Pig_Options.tishi.txt:SetPoint("CENTER", Pig_Options.tishi, "CENTER", -20, 0);
Pig_Options.tishi.txt:SetFont(ChatFontNormal:GetFont(), 14)
Pig_Options.tishi.txt:SetText("\124cffffff00***配置已更改，请重载UI界面以应用新配置***\124r");
Pig_Options.tishi.Tex = Pig_Options.tishi:CreateTexture(nil, "BORDER");
Pig_Options.tishi.Tex:SetTexture("interface/helpframe/helpicon-reportabuse.blp");
Pig_Options.tishi.Tex:SetSize(30,30);
Pig_Options.tishi.Tex:SetPoint("RIGHT",Pig_Options.tishi.txt,"LEFT", 0, 0);
Pig_Options.tishi.Button = PIGButton("重载UI",nil,Pig_Options.tishi,{64,24},{"LEFT",Pig_Options.tishi.txt,"RIGHT",4,0})
Pig_Options.tishi.Button.Text:SetTextColor(1, 0, 1, 1);
Pig_Options.tishi.Button:SetScript("OnClick", function ()
	ReloadUI();
end);

--版本提示
local benji_banbenhaoV=benjibanbenhao:gsub("%.","0");--本机
local benji_banbenhaoV=tonumber(benji_banbenhaoV);--本机
local biaotou="!Pig-Version";
local banbengengxin="NewVersion";
local banbengengxinkaiqi=true;
C_ChatInfo.RegisterAddonMessagePrefix(biaotou)
local Version_tishi = CreateFrame("Frame")
Version_tishi:RegisterEvent("CHAT_MSG_ADDON"); 
Version_tishi:RegisterEvent("PLAYER_LOGIN");            
Version_tishi:SetScript("OnEvent",function(self, event, arg1, arg2, arg3, arg4, arg5)
	if event=="PLAYER_LOGIN" then
		if PIG["NEW_Version"] then
			if PIG["NEW_Version"]>benji_banbenhaoV then
				banbengengxinkaiqi=false;
				print("|cff00FFFF!Pig:|r|cffFFFF00插件已过期,请到"..Pigtxt.QQ.."获取新版本！|r")
			end
		end
		if banbengengxinkaiqi then
			C_ChatInfo.SendAddonMessage(biaotou,banbengengxin,"SAY")
			C_ChatInfo.SendAddonMessage(biaotou,banbengengxin,"YELL")
			if IsInGuild() then C_ChatInfo.SendAddonMessage(biaotou,banbengengxin,"GUILD") end
			if IsInGroup() then C_ChatInfo.SendAddonMessage(biaotou,banbengengxin,"PARTY") end
			if IsInRaid("LE_PARTY_CATEGORY_HOME") then C_ChatInfo.SendAddonMessage(biaotou,banbengengxin,"RAID") end
			if IsInRaid("LE_PARTY_CATEGORY_INSTANCE") then C_ChatInfo.SendAddonMessage(biaotou,banbengengxin,"INSTANCE_CHAT") end
		end
	end
	---
	if event=="CHAT_MSG_ADDON" and arg1 == biaotou then
		local name=GetUnitName("player", true)
		if arg5~=name then
			if arg2==banbengengxin then
				C_ChatInfo.SendAddonMessage(biaotou,benji_banbenhaoV,"WHISPER",arg5)
				return
			end
			if banbengengxinkaiqi then
				local arg2xxx=tonumber(arg2);
				if arg2xxx then
					if arg2xxx>benji_banbenhaoV then
						banbengengxinkaiqi=false;
						print("|cff00FFFF!Pig:|r|cffFFFF00插件已过期,请到"..Pigtxt.QQ.."获取新版本！|r")
						PIG["NEW_Version"]=arg2xxx					
					end	
				end
			end
		end
	end
end)
----
--/run print( GetMouseFocus():GetName() )
--/run print( GetMouseFocus():GetTexture() )
-- local ButtonXX = CreateFrame("Button","ButtonXX_UI",UIParent, "UIPanelButtonTemplate");
-- ButtonXX:SetSize(100,29);
-- ButtonXX:SetPoint("CENTER",UIParent,"CENTER",0,-2);
-- ButtonXX:SetText("GetTexture");
-- ButtonXX:SetScript("OnClick", function(self, button)
-- 		-- local hh = {TargetFrameToT:GetChildren()} 
-- 		local fffff = HelpFrameTopLeftCorner
-- 		--local fffff = HelpFrameTopBorder
-- 		local Icon = fffff:GetTexture()
-- 		print(Icon)
-- 		local zipboap = {fffff:GetTexCoord()}
-- 		--print(fffff:GetTexCoord())
-- 		local kuandu =fffff:GetWidth()
-- 		local gaodu =fffff:GetHeight()
-- 		print(kuandu,gaodu)
-- 		local caijiannr = ""
-- 		for i=1,#zipboap do
-- 			if i==#zipboap then
-- 				caijiannr=caijiannr..zipboap[i]
-- 			else
-- 				caijiannr=caijiannr..zipboap[i]..","
-- 			end
-- 		end
-- 		local editBox = ChatEdit_ChooseBoxForSend();
-- 		if editBox:HasFocus() then			
-- 			editBox:SetText(caijiannr);
-- 			editBox:HighlightText()
-- 		else
-- 			ChatEdit_ActivateChat(editBox)
-- 			editBox:Insert(caijiannr)
-- 			editBox:HighlightText()
-- 		end
-- end)