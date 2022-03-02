local addonName, addonTable = ...;
local gsub = _G.string.gsub 
------------
local Pig_Options = CreateFrame("Frame", "Pig_OptionsUI", UIParent,"BackdropTemplate")
Pig_Options:SetBackdrop({
    bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
    edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
    tile = true,tileSize = 32,edgeSize = 32,
    insets = { left = 8, right = 8, top = 8, bottom = 8 }
})
Pig_Options:SetSize(800, 540)
Pig_Options:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
Pig_Options:EnableMouse(true)
Pig_Options:SetMovable(true)
Pig_Options:SetClampedToScreen(true)
Pig_Options:SetFrameStrata("HIGH")
Pig_Options:SetFrameLevel(999)
tinsert(UISpecialFrames,"Pig_OptionsUI");

Pig_Options.TOPT = CreateFrame("Frame", nil, Pig_Options)
Pig_Options.TOPT:SetSize(170, 46)
Pig_Options.TOPT:SetPoint("TOP", Pig_Options, "TOP", 0, 22)
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


Pig_Options.COS1 = Pig_Options:CreateTexture(nil, "ARTWORK")
Pig_Options.COS1:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Header")
Pig_Options.COS1:SetTexCoord(0.31, 0.67, 0, 0.66)
Pig_Options.COS1:SetSize(16, 41)
Pig_Options.COS1:SetPoint("TOPRIGHT", Pig_Options, "TOPRIGHT", -30, 11)
Pig_Options.COS2 = Pig_Options:CreateTexture(nil, "ARTWORK")
Pig_Options.COS2:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Header")
Pig_Options.COS2:SetTexCoord(0.235, 0.275, 0, 0.66)
Pig_Options.COS2:SetPoint("RIGHT", Pig_Options.COS1, "LEFT",0,0)
Pig_Options.COS2:SetSize(10, 41)
Pig_Options.COS3 = Pig_Options:CreateTexture(nil, "ARTWORK")
Pig_Options.COS3:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Header")
Pig_Options.COS3:SetTexCoord(0.72, 0.76, 0, 0.66)
Pig_Options.COS3:SetPoint("LEFT", Pig_Options.COS1, "RIGHT",0,0)
Pig_Options.COS3:SetSize(10, 41)
Pig_Options.Close = CreateFrame("Button",nil,Pig_Options, "UIPanelCloseButton");  
Pig_Options.Close:SetSize(32,32);
Pig_Options.Close:SetPoint("CENTER",Pig_Options.COS1,"CENTER",0,0);

--========================================================================
--tab Normal----------------------
Pig_Options.Tab={"交互增强","聊天增强","战斗辅助","头像增强","显示增强","界面布局","快捷按钮","额外动作条","小地图管理","功能模块[++]","游戏内置设置","系统团队框架","反馈工具","配 置","关 于"};
local Tab_N=#Pig_Options.Tab;
--左侧菜单
Pig_Options.LF = CreateFrame("Frame", nil, Pig_Options, "BackdropTemplate")
Pig_Options.LF:SetBackdrop( {
	bgFile = "Interface/DialogFrame/UI-DialogBox-Background", 
	edgeFile = "Interface/Tooltips/UI-Tooltip-Border",edgeSize = 12, 
	insets = { left = 2, right = 2, top = 2, bottom = 2 } 
});
Pig_Options.LF:SetBackdropColor(0, 0, 0, 0.6);
Pig_Options.LF:SetBackdropBorderColor(1, 1, 1, 0.8);
Pig_Options.LF:SetSize(Pig_Options:GetWidth()*0.23-22, Pig_Options:GetHeight()-100)
Pig_Options.LF:SetPoint("TOPLEFT", Pig_Options, "TOPLEFT", 20, -60)

Pig_Options.LF.highlight = Pig_Options.LF:CreateTexture(nil, "BORDER");
Pig_Options.LF.highlight:SetTexture("interface/buttons/ui-listbox-highlight.blp");
Pig_Options.LF.highlight:SetSize(Pig_Options.LF:GetWidth()-6,24);
Pig_Options.LF.highlight:SetAlpha(0.9);

local function xuanzhongList(self)
	Pig_Options.LF.highlight:SetAllPoints(self);
	self.highlight:Hide();
	for i=1, Tab_N, 1 do
		_G["Options_LF_TAB_"..i].Title:SetTextColor(1,0.82,0,1);
	end
	self.Title:SetTextColor(1,1,1,1);
	for i=1, Tab_N, 1 do
		_G["Pig_Options_RF_TAB_"..i.."_UI"]:Hide();
	end
	_G["Pig_Options_RF_TAB_"..self:GetID().."_UI"]:Show();
end

for i=1, Tab_N, 1 do
	Pig_Options.LF.TAB = CreateFrame("Button", "Options_LF_TAB_"..i, Pig_Options.LF,nil,i);
	Pig_Options.LF.TAB:SetSize(Pig_Options.LF:GetWidth()-6,24);
	if i==1 then
		Pig_Options.LF.TAB:SetPoint("TOP", Pig_Options.LF, "TOP", 0, -4);
		Pig_Options.LF.highlight:SetAllPoints(Pig_Options.LF.TAB);
	else
		Pig_Options.LF.TAB:SetPoint("TOP", _G["Options_LF_TAB_"..(i-1)], "BOTTOM", 0, 0);
	end
	Pig_Options.LF.TAB:RegisterForClicks("LeftButtonUp", "RightButtonUp");
	Pig_Options.LF.TAB:SetScript("OnClick", xuanzhongList)

	Pig_Options.LF.TAB.Title = Pig_Options.LF.TAB:CreateFontString("Pig_Options.LF.TAB_"..i.."_UI_Title");
	Pig_Options.LF.TAB.Title:SetPoint("LEFT", Pig_Options.LF.TAB, "LEFT", 4, 0);
	Pig_Options.LF.TAB.Title:SetFontObject(GameFontNormal);
	if i==1 then
		Pig_Options.LF.TAB.Title:SetTextColor(1,1,1,1);
	end
	Pig_Options.LF.TAB.Title:SetText(Pig_Options.Tab[i]);
	Pig_Options.LF.TAB.highlight = Pig_Options.LF.TAB:CreateTexture(nil, "BORDER");
	Pig_Options.LF.TAB.highlight:SetTexture("interface/buttons/ui-listbox-highlight2.blp");
	Pig_Options.LF.TAB.highlight:SetBlendMode("ADD")
	Pig_Options.LF.TAB.highlight:SetPoint("CENTER", Pig_Options.LF.TAB, "CENTER", 0,0);
	Pig_Options.LF.TAB.highlight:SetSize(Pig_Options.LF:GetWidth()-6,24);
	Pig_Options.LF.TAB.highlight:SetAlpha(0.4);
	Pig_Options.LF.TAB.highlight:Hide();
	Pig_Options.LF.TAB:SetScript("OnEnter", function (self)
		if not _G["Pig_Options_RF_TAB_"..i.."_UI"]:IsShown() then
			self.Title:SetTextColor(1,1,1,1);
			self.highlight:Show();
		end
	end);
	Pig_Options.LF.TAB:SetScript("OnLeave", function (self)
		if not _G["Pig_Options_RF_TAB_"..i.."_UI"]:IsShown() then
			self.Title:SetTextColor(1,0.82,0,1);	
		end
		self.highlight:Hide();
	end);
end
--===============================================================================
--右侧菜单
Pig_Options.RF = CreateFrame("Frame", nil, Pig_Options, "BackdropTemplate")
Pig_Options.RF:SetBackdrop( {
	bgFile = "Interface/DialogFrame/UI-DialogBox-Background", 
	edgeFile = "Interface/Tooltips/UI-Tooltip-Border",edgeSize = 12, 
	insets = { left = 2, right = 2, top = 2, bottom = 2 } 
});
Pig_Options.RF:SetBackdropColor(0, 0, 0, 0.6);
Pig_Options.RF:SetBackdropBorderColor(1, 1, 1, 0.8);
Pig_Options.RF:SetSize(Pig_Options:GetWidth()*0.76-22, Pig_Options:GetHeight()-100)
Pig_Options.RF:SetPoint("TOPRIGHT", Pig_Options, "TOPRIGHT", -20, -60)

---------------------
for i=1, Tab_N, 1 do
	Pig_Options.RF.TAB = CreateFrame("Frame", "Pig_Options_RF_TAB_"..i.."_UI", Pig_Options.RF)
	Pig_Options.RF.TAB:SetSize(Pig_Options.RF:GetWidth(), Pig_Options.RF:GetHeight())
	Pig_Options.RF.TAB:SetPoint("TOP", Pig_Options.RF, "TOP", 0, 0)
	if i>1 then
		Pig_Options.RF.TAB:Hide();
	end	
end
--///////////////////////////////////////////////////////////////////////////
--界面选项插件菜单
local PIG_AddOn = {};
PIG_AddOn.panel = CreateFrame( "Frame", "PIG_AddOnPanel", UIParent );
PIG_AddOn.panel.name = "!Pig";
InterfaceOptions_AddCategory(PIG_AddOn.panel);
--子页
PIG_AddOn.childpanel = CreateFrame( "Frame", "PIG_AddOnChild", PIG_AddOn.panel);
PIG_AddOn.childpanel.name = "猪猪加油";
--指定归属父级
PIG_AddOn.childpanel.parent = PIG_AddOn.panel.name;
InterfaceOptions_AddCategory(PIG_AddOn.childpanel);
--小地图按钮
PIG_AddOnPanel.MinimapB = CreateFrame("CheckButton", nil, PIG_AddOnPanel, "ChatConfigCheckButtonTemplate");
PIG_AddOnPanel.MinimapB:SetSize(30,32);
PIG_AddOnPanel.MinimapB:SetPoint("TOPLEFT",PIG_AddOnPanel,"TOPLEFT",20,-20);
PIG_AddOnPanel.MinimapB.Text:SetText("显示小地图按钮");
PIG_AddOnPanel.MinimapB.tooltip = "显示插件的小地图按钮。";
PIG_AddOnPanel.MinimapB:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG["Other"]['MinimapB']="ON";
		addonTable.Panel_MinimapButton_Open()
	else
		PIG["Other"]['MinimapB']="OFF";
		ReloadUI();
	end
end);
addonTable.Panel_MinimapB = function()
	if PIG["Other"]['MinimapB']=="ON" then
		PIG_AddOnPanel.MinimapB:SetChecked(true);
	elseif PIG["Other"]['MinimapB']=="OFF" then
		PIG_AddOnPanel.MinimapB:SetChecked(false);
	end
end
--打开设置面板
PIG_AddOnPanel.Openshezhi = CreateFrame("Button", nil, PIG_AddOnPanel, "UIPanelButtonTemplate");
PIG_AddOnPanel.Openshezhi:SetSize(80,28);
PIG_AddOnPanel.Openshezhi:SetPoint("TOPLEFT",PIG_AddOnPanel,"TOPLEFT",20,-60);
PIG_AddOnPanel.Openshezhi:SetText("设置");
PIG_AddOnPanel.Openshezhi:SetScript("OnClick", function ()
	if Pig_OptionsUI:IsShown() then	
		Pig_OptionsUI:Hide();
	else
		InterfaceOptionsFrame:Hide()
		Pig_OptionsUI:Show();
	end
end)
-- PIG_AddOnPanel.okay = function (self) SC_ChaChingPanel_Close(); end;
-- PIG_AddOnPanel.cancel = function (self) SC_ChaChingPanel_CancelOrLoad();  end;
--子页内容
local QQqun="QQ群\124cff00ff0027397148\124r,2群\124cff00ff00117883385\124r";
addonTable.QQqun=QQqun
local PigAbout="玩家交流\124cff00ff00YY频道113213\124r,\n\n 插件问题反馈:"..QQqun..
				"\n\n经典怀旧-辛洛斯-LM-猪猪加油\n\n正式服-火烟之谷-BL-猪猪加油";
PIG_AddOnChild.title = PIG_AddOnChild:CreateFontString();
PIG_AddOnChild.title:SetPoint("TOP",PIG_AddOnChild,"TOP",0,-40);
PIG_AddOnChild.title:SetFont(ChatFontNormal:GetFont(), 16, "OUTLINE");
PIG_AddOnChild.title:SetText(PigAbout);
---
--重载提示
Pig_Options.RF.tishi = CreateFrame("Frame", "Pig_Options_RLtishi_UI", Pig_Options.RF)
Pig_Options.RF.tishi:SetSize(520, 28)
Pig_Options.RF.tishi:SetPoint("TOP", Pig_Options.RF, "BOTTOM", 0, 0)
Pig_Options.RF.tishi:Hide()
--Pig_Options_RLtishi_UI:Show()
Pig_Options.RF.tishi.txt = Pig_Options.RF.tishi:CreateFontString();
Pig_Options.RF.tishi.txt:SetPoint("CENTER", Pig_Options.RF.tishi, "CENTER", -20, 0);
Pig_Options.RF.tishi.txt:SetFont(ChatFontNormal:GetFont(), 14,"OUTLINE")
Pig_Options.RF.tishi.txt:SetText("\124cffffff00***配置已更改，请重载UI界面以应用新配置***\124r");
Pig_Options.RF.tishi.Tex = Pig_Options.RF.tishi:CreateTexture(nil, "BORDER");
Pig_Options.RF.tishi.Tex:SetTexture("interface/helpframe/helpicon-reportabuse.blp");
Pig_Options.RF.tishi.Tex:SetSize(30,30);
Pig_Options.RF.tishi.Tex:SetPoint("RIGHT",Pig_Options.RF.tishi.txt,"LEFT", 0, 0);
Pig_Options.RF.tishi.Button = CreateFrame("Button",nil,Pig_Options.RF.tishi, "UIPanelButtonTemplate");  
Pig_Options.RF.tishi.Button:SetSize(64,28);
Pig_Options.RF.tishi.Button:SetPoint("LEFT",Pig_Options.RF.tishi.txt,"RIGHT",0,0);
Pig_Options.RF.tishi.Button:SetText("重载UI");
local buttonFont=Pig_Options.RF.tishi.Button:GetFontString()
buttonFont:SetFont(ChatFontNormal:GetFont(), 13);
buttonFont:SetTextColor(1, 1, 1, 1);
Pig_Options.RF.tishi.Button:SetScript("OnClick", function ()
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
				print("|cff00FFFF!Pig:|r|cffFFFF00插件已过期,请到"..QQqun.."获取新版本！|r")
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
						print("|cff00FFFF!Pig:|r|cffFFFF00插件已过期,请到"..QQqun.."获取新版本！|r")
						PIG["NEW_Version"]=arg2xxx					
					end	
				end
			end
		end
	end
end)
----