local addonName, addonTable = ...;
local gsub = _G.string.gsub
local ADD_Frame=addonTable.ADD_Frame
local ADD_Button=addonTable.ADD_Button
local ADD_Checkbutton=addonTable.ADD_Checkbutton
local _, _, _, tocversion = GetBuildInfo()
---===================================
local Pig_Options=ADD_Frame("Pig_OptionsUI",UIParent,800, 540,"CENTER",UIParent,"CENTER",0,0,true,false,true,true,true)
Pig_Options:SetBackdrop({bgFile = "Interface/DialogFrame/UI-DialogBox-Background",
    edgeFile = "Interface/DialogFrame/UI-DialogBox-Border",
    tile = true,tileSize = 32,edgeSize = 32, insets = { left = 8, right = 8, top = 8, bottom = 8 }
})
Pig_Options:SetFrameStrata("HIGH")

Pig_Options.TOPT = CreateFrame("Frame", nil, Pig_Options)
Pig_Options.TOPT:SetSize(170, 46)
Pig_Options.TOPT:SetPoint("TOP", Pig_Options, "TOP", 0, 26)
Pig_Options.TOPT:EnableMouse(true)
Pig_Options.TOPT:RegisterForDrag("LeftButton")
Pig_Options.TOPT:SetScript("OnDragStart",function()
	Pig_Options:StartMoving()
end)
Pig_Options.TOPT:SetScript("OnDragStop",function()
	Pig_Options:StopMovingOrSizing()
end)

Pig_Options.TOPT.Border = Pig_Options.TOPT:CreateTexture(nil, "ARTWORK")
Pig_Options.TOPT.Border:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Header")
Pig_Options.TOPT.Border:SetSize(280, 80)
Pig_Options.TOPT.Border:SetPoint("TOP", Pig_Options.TOPT, "TOP", 0, 0)

Pig_Options.TOPT.title = Pig_Options.TOPT:CreateFontString();
Pig_Options.TOPT.title:SetPoint("TOP", Pig_Options.TOPT, "TOP", 0, -17);
Pig_Options.TOPT.title:SetFontObject(GameFontNormal);

Pig_Options.Close = CreateFrame("Button",nil,Pig_Options, "UIPanelCloseButton");
if tocversion<100000 then
	Pig_Options.Close:SetSize(32,32);
	Pig_Options.Close:SetPoint("TOPRIGHT", Pig_Options, "TOPRIGHT", -30, 14);
else
	Pig_Options.Close:SetSize(25,25);
	Pig_Options.Close:SetPoint("TOPRIGHT", Pig_Options, "TOPRIGHT", -30, 11);
end 
Pig_Options.C = Pig_Options:CreateTexture(nil, "ARTWORK")
Pig_Options.C:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Header")
Pig_Options.C:SetTexCoord(0.31, 0.67, 0, 0.66)
Pig_Options.C:SetSize(16, 41)
Pig_Options.C:SetPoint("CENTER", Pig_Options.Close, "CENTER", -1, -0.8)
Pig_Options.L = Pig_Options:CreateTexture(nil, "ARTWORK")
Pig_Options.L:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Header")
Pig_Options.L:SetTexCoord(0.235, 0.275, 0, 0.66)
Pig_Options.L:SetPoint("RIGHT", Pig_Options.C, "LEFT",0,0)
Pig_Options.L:SetSize(10, 41)
Pig_Options.R = Pig_Options:CreateTexture(nil, "ARTWORK")
Pig_Options.R:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Header")
Pig_Options.R:SetTexCoord(0.72, 0.76, 0, 0.66)
Pig_Options.R:SetPoint("LEFT", Pig_Options.C, "RIGHT",0,0)
Pig_Options.R:SetSize(10, 41)
--========================================================================
local OptionsW,OptionsH = Pig_Options:GetWidth(),Pig_Options:GetHeight()
--左侧内容
Pig_Options.LF = CreateFrame("Frame", nil, Pig_Options, "BackdropTemplate")
Pig_Options.LF:SetBackdrop( {edgeFile = "Interface/Tooltips/UI-Tooltip-Border",edgeSize = 12});
Pig_Options.LF:SetSize(OptionsW*0.23-22, OptionsH-100)
Pig_Options.LF:SetPoint("TOPLEFT", Pig_Options, "TOPLEFT", 20, -60)
Pig_Options.LF.TopEdge:Hide()
Pig_Options.LF.TopRR = Pig_Options.LF:CreateTexture(nil, "BORDER");
Pig_Options.LF.TopRR:SetTexture("interface/optionsframe/ui-optionsframe-spacer.blp");
Pig_Options.LF.TopRR:SetWidth(6);
Pig_Options.LF.TopRR:SetPoint("TOPRIGHT", Pig_Options.LF, "TOPRIGHT", -12,8);
--右侧内容
Pig_Options.RF = CreateFrame("Frame", nil, Pig_Options, "BackdropTemplate")
Pig_Options.RF:SetBackdrop( {edgeFile = "Interface/Tooltips/UI-Tooltip-Border",edgeSize = 12});
Pig_Options.RF:SetSize(OptionsW*0.76-18, OptionsH-100)
Pig_Options.RF:SetPoint("TOPRIGHT", Pig_Options, "TOPRIGHT", -20, -60)
------

local Tab_L={"基础","功能"};
local Tab_LW,Tab_LH,Tab_JG=50,28,16
local LF_W,LF_H=Pig_Options.LF:GetWidth()-6,Pig_Options.LF:GetHeight();
local LR_W,LR_H=Pig_Options.RF:GetWidth(),Pig_Options.RF:GetHeight();
local TabN="interface/optionsframe/ui-optionsframe-inactivetab.blp"
local TabY="interface/optionsframe/ui-optionsframe-activetab.blp"
for i=1, #Tab_L, 1 do
	local TAB = CreateFrame("Button", "LF_TAB_"..i, Pig_Options.LF,nil,i);
	TAB:SetSize(Tab_LW,Tab_LH);
	if i==1 then
		TAB:SetPoint("BOTTOMLEFT", Pig_Options.LF, "TOPLEFT", 14, 0);
	else
		TAB:SetPoint("LEFT", _G["LF_TAB_"..(i-1)], "RIGHT", Tab_JG, 0);
	end
	TAB:HookScript("OnEnter", function (self)
		if not _G["LF_TAB_F_"..self:GetID()]:IsShown() then
			self.t:SetTextColor(1, 1, 1, 1);
			self.highlight:Show();
		end
	end);
	TAB:HookScript("OnLeave", function (self)
		if not _G["LF_TAB_F_"..self:GetID()]:IsShown() then
			self.t:SetTextColor(0, 1, 1, 1);
		end
		self.highlight:Hide();
	end);
	TAB:HookScript("OnMouseDown", function (self)
		if not _G["LF_TAB_F_"..self:GetID()]:IsShown() then
			self.t:SetPoint("TOP", self, "TOP", 1.5,-13.5);
		end
	end);
	TAB:HookScript("OnMouseUp", function (self)
		if not _G["LF_TAB_F_"..self:GetID()]:IsShown() then
			self.t:SetPoint("TOP", self, "TOP", 0,-12);
		end
	end);
	TAB:SetScript("OnClick", function(self)
		for x=1,#Tab_L do
			local fujiF = _G["LF_TAB_"..x]
			fujiF.TexL:SetTexture(TabN);
			fujiF.TexR:SetTexture(TabN);
			fujiF.TexL:SetPoint("LEFT", fujiF, "LEFT", -(Tab_LW*0.2),-2);
			fujiF.TexBot:Show();
			fujiF.t:SetTextColor(0, 1, 1, 1);
			fujiF.t:SetPoint("TOP", fujiF, "TOP", 0,-12);
			_G["LF_TAB_F_"..x]:Hide();
		end
		self.TexL:SetTexture(TabY);
		self.TexR:SetTexture(TabY);
		self.TexL:SetPoint("LEFT", self, "LEFT", -(Tab_LW*0.2),-3.8);
		self.TexBot:Hide();
		self.t:SetTextColor(1, 1, 1, 1);
		self.t:SetPoint("TOP", TAB, "TOP", 0,-10);
		self.highlight:Hide();
		_G["LF_TAB_F_"..self:GetID()]:Show();
	end)	
	TAB.TexL = TAB:CreateTexture(nil, "BORDER");
	TAB.TexL:SetTexture(TabN);
	TAB.TexL:SetTexCoord(0,0.3,0,1);
	TAB.TexL:SetSize(Tab_LW*0.7,Tab_LH);
	TAB.TexL:SetPoint("LEFT", TAB, "LEFT", -(Tab_LW*0.2),-2);
	TAB.TexR = TAB:CreateTexture(nil, "BORDER");
	TAB.TexR:SetTexture(TabN);
	TAB.TexR:SetTexCoord(0.7,1,0,1);
	TAB.TexR:SetSize(Tab_LW*0.7,Tab_LH);
	TAB.TexR:SetPoint("LEFT", TAB.TexL, "RIGHT", 0,0);
	TAB.TexBot = TAB:CreateTexture(nil, "BORDER");
	TAB.TexBot:SetTexture("interface/optionsframe/ui-optionsframe-spacer.blp");
	TAB.TexBot:SetWidth(Tab_LW+4);
	TAB.TexBot:SetPoint("BOTTOM", TAB, "BOTTOM", 0,-8);
	TAB.TexRR = TAB:CreateTexture(nil, "BORDER");
	TAB.TexRR:SetTexture("interface/optionsframe/ui-optionsframe-spacer.blp");
	TAB.TexRR:SetWidth(Tab_JG-4);
	TAB.TexRR:SetPoint("BOTTOMLEFT", TAB, "BOTTOMRIGHT", 2,-8);
	TAB.TexTishi = TAB:CreateTexture(nil, "BORDER");
	TAB.TexTishi:SetTexture("interface/vehicles/arrow.blp");
	TAB.TexTishi:SetBlendMode("ADD")
	PIGRotation(TAB.TexTishi, 180)
	TAB.TexTishi:SetPoint("LEFT", TAB, "RIGHT", 4,-6);
	TAB.TexTishi:Hide();

	TAB.t = TAB:CreateFontString();
	TAB.t:SetPoint("TOP", TAB, "TOP", 0,-12);
	TAB.t:SetFontObject(GameFontNormal);
	TAB.t:SetTextColor(0, 1, 1, 1);
	TAB.t:SetText(Tab_L[i]);
	TAB.highlight = TAB:CreateTexture(nil, "BORDER");
	TAB.highlight:SetTexture("interface/paperdollinfoframe/ui-character-tab-highlight.blp");
	TAB.highlight:SetBlendMode("ADD")
	TAB.highlight:SetPoint("CENTER", TAB.t, "CENTER", 0,0);
	TAB.highlight:SetSize(Tab_LW,Tab_LH);
	TAB.highlight:Hide();
	local TAB_F = CreateFrame("Frame", "LF_TAB_F_"..i, Pig_Options.LF)
	TAB_F:SetSize(LF_W, LF_H)
	TAB_F:SetPoint("TOP", Pig_Options.LF, "TOP", 0, 0)
	TAB_F:Hide();
	if i==1 then
		TAB.TexL:SetTexture(TabY);
		TAB.TexL:SetPoint("LEFT", TAB, "LEFT", -(Tab_LW*0.2),-3.8);
		TAB.TexR:SetTexture(TabY);
		TAB.TexBot:Hide();
		TAB.t:SetTextColor(1, 1, 1, 1);
		TAB.t:SetPoint("TOP", TAB, "TOP", 0,-10);
		TAB_F:Show();
	end	
end

--左边选项内容
local Tab_L_List={
	{"交互增强","聊天增强","战斗辅助","头像增强","显示增强","界面布局","快捷按钮栏","小地图/地图","游戏参数设置","测试功能","露露缇娅","开发工具","配 置","关 于"},
	{"背包整合","拍卖增强","额外动作条","快捷跟随","输出提示","技能监控","售卖助手","专业 C D","时空之门","开团助手","带本助手","离开屏保"},
}
local List_ButH = 24
for i=1, #Tab_L, 1 do
	local L_F_List=_G["LF_TAB_F_"..i]
	for ii=1, #Tab_L_List[i], 1 do
		local List_But = CreateFrame("Button", "List_But_"..i.."_"..ii, L_F_List);
		List_But:SetSize(LF_W,List_ButH);
		if ii==1 then
			List_But:SetPoint("TOP", L_F_List, "TOP", 0, -8);
		else
			List_But:SetPoint("TOP", _G["List_But_"..i.."_"..(ii-1)], "BOTTOM", 0, 0);
		end
		List_But:RegisterForClicks("LeftButtonUp", "RightButtonUp");

		List_But.highlight1 = List_But:CreateTexture(nil, "BORDER");
		List_But.highlight1:SetTexture("interface/buttons/ui-listbox-highlight2.blp");
		List_But.highlight1:SetBlendMode("ADD")
		List_But.highlight1:SetPoint("CENTER", List_But, "CENTER", 0,0);
		List_But.highlight1:SetSize(LF_W-6,List_ButH);
		List_But.highlight1:SetAlpha(0.4);
		List_But.highlight1:Hide();
		List_But.highlight2 = List_But:CreateTexture(nil, "BORDER");
		List_But.highlight2:SetTexture("interface/buttons/ui-listbox-highlight.blp");
		List_But.highlight2:SetBlendMode("ADD")
		List_But.highlight2:SetSize(LF_W-6,List_ButH);
		List_But.highlight2:SetPoint("CENTER", List_But, "CENTER", 0,0);
		List_But.highlight2:SetAlpha(0.6);
		List_But.highlight2:Hide();
		List_But.t = List_But:CreateFontString();
		List_But.t:SetPoint("LEFT", List_But, "LEFT", 4, 0);
		List_But.t:SetFontObject(GameFontNormal);
		List_But.t:SetText(Tab_L_List[i][ii]);

		--右侧内容显示区域-----
		local List_R_F = CreateFrame("Frame", "List_R_F_"..i.."_"..ii, Pig_Options.RF)
		List_R_F:SetSize(LR_W,LR_H)
		List_R_F:SetPoint("TOP", Pig_Options.RF, "TOP", 0, 0)
		List_R_F:Hide();

		List_But:SetScript("OnEnter", function (self)
			if not _G["List_R_F_"..i.."_"..ii]:IsShown() then
				self.t:SetTextColor(1,1,1,1);
				self.highlight1:Show();
			end
		end);
		List_But:SetScript("OnLeave", function (self)
			if not _G["List_R_F_"..i.."_"..ii]:IsShown() then
				self.t:SetTextColor(1,0.82,0,1);	
			end
			self.highlight1:Hide();
		end);
		List_But:HookScript("OnMouseDown", function (self)
			if not _G["List_R_F_"..i.."_"..ii]:IsShown() then
				self.t:SetPoint("LEFT", self, "LEFT", 5.5,-1.5);
			end
		end);
		List_But:HookScript("OnMouseUp", function (self)
			if not _G["List_R_F_"..i.."_"..ii]:IsShown() then
				self.t:SetPoint("LEFT", self, "LEFT", 4,0);
			end
		end);
		List_But:SetScript("OnClick", function(self)
			for x=1, #Tab_L, 1 do
				for xx=1,#Tab_L_List[x] do
					local fujiF = _G["List_But_"..x.."_"..xx]
					fujiF.highlight2:Hide();
					fujiF.t:SetTextColor(1,0.82,0,1);
					_G["List_R_F_"..x.."_"..xx]:Hide();
				end
			end
			self.t:SetTextColor(1, 1, 1, 1);
			self.highlight1:Hide();
			self.highlight2:Show();
			_G["List_R_F_"..i.."_"..ii]:Show();
		end)
		if i==1 and ii==1 then
			List_But.t:SetTextColor(1,1,1,1);
			List_But.highlight2:Show();
			List_R_F_1_1:Show();
		end
	end
end

--快捷按钮栏=================================
local ActionW = ActionButton1:GetWidth()
local QuickButton = CreateFrame("Frame", "QuickButtonUI", UIParent);
QuickButton:SetSize(ActionW*10+12,ActionW);
QuickButton:SetMovable(true)
QuickButton:SetClampedToScreen(true)
QuickButton:Hide()
QuickButton.yidong = CreateFrame("Frame", nil, QuickButton,"BackdropTemplate")
QuickButton.yidong:SetBackdrop({
	bgFile = "Interface/DialogFrame/UI-DialogBox-Background", edgeFile = "Interface/Tooltips/UI-Tooltip-Border", tile = true, edgeSize = 6
});
QuickButton.yidong:SetBackdropColor(0.4, 0.4, 0.4, 0.5);
QuickButton.yidong:SetBackdropBorderColor(1, 1, 1, 1);
QuickButton.yidong:SetSize(14,ActionW+4)
QuickButton.yidong:SetPoint("LEFT", QuickButton, "LEFT", 0, 0);
QuickButton.yidong:EnableMouse(true)
QuickButton.yidong:RegisterForDrag("LeftButton")
QuickButton.yidong.title = QuickButton.yidong:CreateFontString();
QuickButton.yidong.title:SetAllPoints(QuickButton.yidong)
QuickButton.yidong.title:SetFont(ChatFontNormal:GetFont(), 11)
QuickButton.yidong.title:SetTextColor(0.6, 0.6, 0.6, 1)
QuickButton.yidong.title:SetText("拖\n动")
QuickButton.yidong:SetScript("OnDragStart",function()
	QuickButton:StartMoving()
end)
QuickButton.yidong:SetScript("OnDragStop",function()
	QuickButton:StopMovingOrSizing()
	QuickButton:SetUserPlaced(false)
	local point, relativeTo, relativePoint, xOfs, yOfs = QuickButton:GetPoint()
	PIG['QuickButton']['Point']={point, relativePoint, xOfs, yOfs};
end)
QuickButton.nr = CreateFrame("Frame", nil, QuickButton,"BackdropTemplate");
QuickButton.nr:SetBackdrop({
	bgFile = "Interface/DialogFrame/UI-DialogBox-Background", edgeFile = "Interface/Tooltips/UI-Tooltip-Border", tile = true, edgeSize = 6
});
QuickButton.nr:SetBackdropColor(0.4, 0.4, 0.4, 0.5);
QuickButton.nr:SetBackdropBorderColor(0.4, 0.4, 0.4, 0.5);
QuickButton.nr:SetSize(ActionW*10,ActionW+4);
QuickButton.nr:SetPoint("LEFT",QuickButton,"LEFT",14,0);

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
--小地图按钮
PIG_AddOnPanel.MinimapB=ADD_Checkbutton(nil,PIG_AddOnPanel,-80,"TOPLEFT",PIG_AddOnPanel,"TOPLEFT",20,-20,"显示小地图按钮","显示插件的小地图按钮")
PIG_AddOnPanel.MinimapB:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG.Map.MinimapBut=true;
		addonTable.Panel_MinimapButton_Open()
	else
		PIG.Map.MinimapBut=false;
		ReloadUI();
	end
end);
PIG_AddOnPanel:HookScript("OnShow", function ()
	if PIG.Map.MinimapBut then
		PIG_AddOnPanel.MinimapB:SetChecked(true);
	end
end)
--打开设置面板
PIG_AddOnPanel.Openshezhi = ADD_Button("设置",nil,PIG_AddOnPanel,80,28,"TOPLEFT",PIG_AddOnPanel,"TOPLEFT",20,-60)
PIG_AddOnPanel.Openshezhi:SetScript("OnClick", function ()
	if Pig_OptionsUI:IsShown() then	
		Pig_OptionsUI:Hide();
	else
		InterfaceOptionsFrame:Hide()
		GameMenuFrame:Hide()
		Pig_OptionsUI:Show();
	end
end)
-- PIG_AddOnPanel.okay = function (self) SC_ChaChingPanel_Close(); end;
-- PIG_AddOnPanel.cancel = function (self) SC_ChaChingPanel_CancelOrLoad();  end;
--子页内容
local Pigtxt={
	["BT"]="|cff00ff00本插件为|r|cff00FFFF<猪猪加油|r [服务器:凤凰之神-部落]>|cff00ff00定制插件|r|cffffff00(已公开分享)|r\n|cffFF0000(本插件完全免费,网络购物平台出售的皆为骗子)。|r",	
	["YY"]="玩家交流\124cff00ff00YY频道113213\124r",
	["QQ"]="QQ群\124cff00ff0027397148\124r,2群\124cff00ff00117883385\124r",
}
addonTable.Pigtxt=Pigtxt
PIG_AddOnChild.title = PIG_AddOnChild:CreateFontString();
PIG_AddOnChild.title:SetPoint("TOP",PIG_AddOnChild,"TOP",0,-40);
PIG_AddOnChild.title:SetFont(ChatFontNormal:GetFont(), 16, "OUTLINE");
PIG_AddOnChild.title:SetText(Pigtxt.BT.."\n\n"..Pigtxt.YY.."\n\n"..Pigtxt.QQ);


--重载提示
Pig_Options.tishi = CreateFrame("Frame", "Pig_Options_RLtishi_UI", Pig_Options)
Pig_Options.tishi:SetSize(520, 28)
Pig_Options.tishi:SetPoint("BOTTOM", Pig_Options, "BOTTOM", 80, 12)
Pig_Options.tishi:Hide()
Pig_Options.tishi.txt = Pig_Options.tishi:CreateFontString();
Pig_Options.tishi.txt:SetPoint("CENTER", Pig_Options.tishi, "CENTER", -20, 0);
Pig_Options.tishi.txt:SetFont(ChatFontNormal:GetFont(), 14,"OUTLINE")
Pig_Options.tishi.txt:SetText("\124cffffff00***配置已更改，请重载UI界面以应用新配置***\124r");
Pig_Options.tishi.Tex = Pig_Options.tishi:CreateTexture(nil, "BORDER");
Pig_Options.tishi.Tex:SetTexture("interface/helpframe/helpicon-reportabuse.blp");
Pig_Options.tishi.Tex:SetSize(30,30);
Pig_Options.tishi.Tex:SetPoint("RIGHT",Pig_Options.tishi.txt,"LEFT", 0, 0);
Pig_Options.tishi.Button = CreateFrame("Button",nil,Pig_Options.tishi, "UIPanelButtonTemplate");  
Pig_Options.tishi.Button:SetSize(64,24);
Pig_Options.tishi.Button:SetPoint("LEFT",Pig_Options.tishi.txt,"RIGHT",0,0);
Pig_Options.tishi.Button:SetText("重载UI");
local buttonFont=Pig_Options.tishi.Button:GetFontString()
buttonFont:SetFont(ChatFontNormal:GetFont(), 13);
buttonFont:SetTextColor(1, 1, 1, 1);
Pig_Options.tishi.Button:SetScript("OnClick", function ()
	ReloadUI();
end);
--标头版本信息
local benjibanbenhao=GetAddOnMetadata(addonName, "Version")
Pig_Options.TOPT.title:SetText("|cffFF00FF!Pig|r-"..benjibanbenhao);

--版本提示
local benji_banbenhaoV=benjibanbenhao:gsub("%.","0");--本机
local benji_banbenhaoV=tonumber(benji_banbenhaoV);--本机
local biaotou='!Pig-Version';
local banbengengxin='版本更新';
local banbengengxinkaiqi=true;
C_ChatInfo.RegisterAddonMessagePrefix(biaotou)
local Version_tishi = CreateFrame("Frame")
Version_tishi:RegisterEvent('CHAT_MSG_ADDON'); 
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
			if arg2=="版本更新" then
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