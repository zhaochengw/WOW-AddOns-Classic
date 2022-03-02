local addonName, addonTable = ...;
local fuFrame=Pig_Options_RF_TAB_10_UI
local gongnengName="时空之门";
--=============================================================
Pig_OptionsUI.PlaneInvite = CreateFrame("Button",nil,Pig_OptionsUI, "UIPanelButtonTemplate");  
Pig_OptionsUI.PlaneInvite:SetSize(90,28);
Pig_OptionsUI.PlaneInvite:SetPoint("TOPLEFT",Pig_OptionsUI,"TOPLEFT",470,-24);
Pig_OptionsUI.PlaneInvite:SetText("时空之门");
Pig_OptionsUI.PlaneInvite:Disable();
Pig_OptionsUI.PlaneInvite:SetMotionScriptsWhileDisabled(true)
Pig_OptionsUI.PlaneInvite:SetScript("OnClick", function ()
	PlaneInvite_UI:SetFrameLevel(10)
	PlaneInvite_UI:Show();
	Pig_OptionsUI:Hide();
end);
Pig_OptionsUI.PlaneInvite:SetScript("OnEnter", function (self)
	GameTooltip:ClearLines();
	GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT",0,0);
	if not self:IsEnabled() then
		GameTooltip:AddLine(gongnengName.."尚未启用，请在功能模块内启用")
	end
	GameTooltip:Show();
end);
Pig_OptionsUI.PlaneInvite:SetScript("OnLeave", function ()
	GameTooltip:ClearLines();
	GameTooltip:Hide()
end);
local function ADD_PlaneInviteFrame()
	if PlaneInvite_UI~=nil then return end
	---设置主面板------------------------------------------------
	local Width,Height=880,520;
	local PlaneInvite = CreateFrame("Frame", "PlaneInvite_UI", UIParent);
	PlaneInvite:SetSize(Width,Height);
	PlaneInvite:SetPoint("CENTER",UIParent,"CENTER",0,80);
	PlaneInvite:EnableMouse(true)
	PlaneInvite:SetMovable(true)
	PlaneInvite:SetClampedToScreen(true)
	PlaneInvite:Hide()
	tinsert(UISpecialFrames,"PlaneInvite_UI");
	PlaneInvite.yidong = CreateFrame("Frame", nil, PlaneInvite);
	PlaneInvite.yidong:SetSize(200,24);
	PlaneInvite.yidong:SetPoint("TOP", PlaneInvite, "TOP", 0, 0);
	PlaneInvite.yidong:EnableMouse(true)
	PlaneInvite.yidong:RegisterForDrag("LeftButton")
	PlaneInvite.yidong:SetScript("OnDragStart",function()
		PlaneInvite:StartMoving()
	end)
	PlaneInvite.yidong:SetScript("OnDragStop",function()
		PlaneInvite:StopMovingOrSizing()
	end)
	PlaneInvite.yidong.text0 = PlaneInvite.yidong:CreateFontString();
	PlaneInvite.yidong.text0:SetPoint("CENTER", PlaneInvite.yidong, "CENTER", 0,0);
	PlaneInvite.yidong.text0:SetFontObject(GameFontNormal);
	PlaneInvite.yidong.text0:SetText(gongnengName);
	PlaneInvite.Close = CreateFrame("Button",nil,PlaneInvite, "UIPanelCloseButton");  
	PlaneInvite.Close:SetSize(32,32);
	PlaneInvite.Close:SetPoint("TOPRIGHT", PlaneInvite, "TOPRIGHT", 5, 4);
	PlaneInvite.TOP1 = PlaneInvite:CreateTexture(nil, "BORDER");
	PlaneInvite.TOP1:SetTexture("interface/worldmap/ui-worldmap-top1.blp");
	PlaneInvite.TOP1:SetSize(Width/4,Height/2);
	PlaneInvite.TOP1:SetPoint("TOPLEFT",PlaneInvite,"TOPLEFT",0,0);
	PlaneInvite.TOP2 = PlaneInvite:CreateTexture(nil, "BORDER");
	PlaneInvite.TOP2:SetTexture("interface/worldmap/ui-worldmap-top2.blp");
	PlaneInvite.TOP2:SetSize(Width/4,Height/2);
	PlaneInvite.TOP2:SetPoint("TOPLEFT",PlaneInvite.TOP1,"TOPRIGHT",0,0);
	PlaneInvite.TOP3 = PlaneInvite:CreateTexture(nil, "BORDER");
	PlaneInvite.TOP3:SetTexture("interface/worldmap/ui-worldmap-top3.blp");
	PlaneInvite.TOP3:SetSize(Width/4,Height/2);
	PlaneInvite.TOP3:SetPoint("TOPLEFT",PlaneInvite.TOP2,"TOPRIGHT",0,0);
	PlaneInvite.TOP4 = PlaneInvite:CreateTexture(nil, "BORDER");
	PlaneInvite.TOP4:SetTexture("interface/worldmap/ui-worldmap-top4.blp");
	PlaneInvite.TOP4:SetSize(Width/4,Height/2);
	PlaneInvite.TOP4:SetPoint("TOPLEFT",PlaneInvite.TOP3,"TOPRIGHT",0,0);
	---
	PlaneInvite.BOTTOM1 = PlaneInvite:CreateTexture(nil, "BORDER");
	PlaneInvite.BOTTOM1:SetTexture("interface/worldmap/ui-worldmap-bottom1.blp");
	PlaneInvite.BOTTOM1:SetSize(Width/4,Height/2);
	PlaneInvite.BOTTOM1:SetPoint("TOPLEFT",PlaneInvite.TOP1,"BOTTOMLEFT",0,0);
	PlaneInvite.BOTTOM2 = PlaneInvite:CreateTexture(nil, "BORDER");
	PlaneInvite.BOTTOM2:SetTexture("interface/worldmap/ui-worldmap-bottom2.blp");
	PlaneInvite.BOTTOM2:SetSize(Width/4,Height/2);
	PlaneInvite.BOTTOM2:SetPoint("TOPLEFT",PlaneInvite.BOTTOM1,"TOPRIGHT",0,0);
	PlaneInvite.BOTTOM3 = PlaneInvite:CreateTexture(nil, "BORDER");
	PlaneInvite.BOTTOM3:SetTexture("interface/worldmap/ui-worldmap-bottom3.blp");
	PlaneInvite.BOTTOM3:SetSize(Width/4,Height/2);
	PlaneInvite.BOTTOM3:SetPoint("TOPLEFT",PlaneInvite.BOTTOM2,"TOPRIGHT",0,0);
	PlaneInvite.BOTTOM4 = PlaneInvite:CreateTexture(nil, "BORDER");
	PlaneInvite.BOTTOM4:SetTexture("interface/worldmap/ui-worldmap-bottom4.blp");
	PlaneInvite.BOTTOM4:SetSize(Width/4,Height/2);
	PlaneInvite.BOTTOM4:SetPoint("TOPLEFT",PlaneInvite.BOTTOM3,"TOPRIGHT",0,0);
	----------
	PlaneInvite.NR = CreateFrame("Frame", nil, PlaneInvite,"BackdropTemplate");
	PlaneInvite.NR:SetBackdrop({bgFile = "interface/raidframe/ui-raidframe-groupbg.blp",tile = false,tileSize = 0});
	PlaneInvite.NR:SetSize(Width-8,Height-69);
	PlaneInvite.NR:SetPoint("TOP",PlaneInvite,"TOP",0,-66);
	--TAB
	local TabWidth,TabHeight = 110,26;
	--local TabName = {"位面","车队","乘客"};
	local TabName = {"位面","车队"};
	for id=1,#TabName do
		local Tablist = CreateFrame("Button","PlaneInviteTAB_"..id,PlaneInvite, "TruncatedButtonTemplate",id);
		Tablist:SetSize(TabWidth,TabHeight);
		if id==1 then
			Tablist:SetPoint("TOPLEFT", PlaneInvite, "BOTTOMLEFT", 30,3);
		else
			Tablist:SetPoint("LEFT", _G["PlaneInviteTAB_"..(id-1)], "RIGHT", 20,0);
		end
		Tablist.Tex = Tablist:CreateTexture(nil, "BORDER");
		Tablist.Tex:SetTexture("interface/paperdollinfoframe/ui-character-inactivetab.blp");
		Tablist.Tex:SetPoint("TOP", Tablist, "TOP", 0,0);
		Tablist.title = Tablist:CreateFontString();
		Tablist.title:SetPoint("TOP", Tablist, "TOP", 0,-5);
		Tablist.title:SetFontObject(GameFontNormalSmall);
		Tablist.title:SetText(TabName[id]);
		Tablist.highlight = Tablist:CreateTexture(nil, "BORDER");
		Tablist.highlight:SetTexture("interface/paperdollinfoframe/ui-character-tab-highlight.blp");
		Tablist.highlight:SetBlendMode("ADD")
		Tablist.highlight:SetPoint("CENTER", Tablist.title, "CENTER", 0,0);
		Tablist.highlight:SetSize(TabWidth-12,TabHeight+4);
		Tablist.highlight:Hide();
		Tablist:SetScript("OnEnter", function (self)
			if not _G["PlaneInviteFrame_"..self:GetID()]:IsShown() then
				self.title:SetTextColor(1, 1, 1, 1);
				self.highlight:Show();
			end
		end);
		Tablist:SetScript("OnLeave", function (self)
			if not _G["PlaneInviteFrame_"..self:GetID()]:IsShown() then
				self.title:SetTextColor(1, 215/255, 0, 1);
			end
			self.highlight:Hide();
		end);
		Tablist:HookScript("OnMouseDown", function (self)
			if not _G["PlaneInviteFrame_"..self:GetID()]:IsShown() then
				self.title:SetPoint("CENTER", self, "CENTER", 2, -2);
			end
		end);
		Tablist:HookScript("OnMouseUp", function (self)
			if not _G["PlaneInviteFrame_"..self:GetID()]:IsShown() then
				self.title:SetPoint("CENTER", self, "CENTER", 0, 0);
			end
		end);
		local PlaneInviteFrame = CreateFrame("Frame", "PlaneInviteFrame_"..id,PlaneInvite.NR);
		PlaneInviteFrame:SetAllPoints(PlaneInvite.NR)
		PlaneInviteFrame:Hide();
		---------
		PlaneInviteTAB_1.Tex:SetTexture("interface/paperdollinfoframe/ui-character-activetab.blp");
		PlaneInviteTAB_1.Tex:SetPoint("TOP", PlaneInviteTAB_1, "TOP", 0,2);
		PlaneInviteTAB_1.title:SetTextColor(1, 1, 1, 1);
		PlaneInviteFrame_1:Show();
		---------
		Tablist:SetScript("OnClick", function (self)
			for x=1,#TabName do
				_G["PlaneInviteTAB_"..x].Tex:SetTexture("interface/paperdollinfoframe/ui-character-inactivetab.blp");
				_G["PlaneInviteTAB_"..x].Tex:SetPoint("TOP", _G["PlaneInviteTAB_"..x], "TOP", 0,0);
				_G["PlaneInviteTAB_"..x].title:SetTextColor(1, 215/255, 0, 1);
				_G["PlaneInviteFrame_"..x]:Hide();
			end
			self.Tex:SetTexture("interface/paperdollinfoframe/ui-character-activetab.blp");
			self.Tex:SetPoint("TOP", self, "TOP", 0,2);
			self.title:SetTextColor(1, 1, 1, 1);
			self.highlight:Hide();
			_G["PlaneInviteFrame_"..self:GetID()]:Show();
		end);
	end
	------------------------------------
	addonTable.ADD_Plane_Frame()
	addonTable.ADD_Chedui_Frame()
end
--=============================================================
--添加快捷打开按钮
local function ADD_PlaneInvite_but()
	PIG['PlaneInvite']=PIG['PlaneInvite'] or addonTable.Default['PlaneInvite']
	PIG['PlaneInvite']['Kaiqi']=PIG['PlaneInvite']['Kaiqi'] or addonTable.Default['PlaneInvite']['Kaiqi']
	if PIG['PlaneInvite']["AddBut"]=="ON" then
		fuFrame_PlaneInvite_ADD_UI:SetChecked(true);
	end
	if PIG['Classes']['Assistant']=="ON" and PIG['PlaneInvite']["Kaiqi"]=="ON" then
		fuFrame_PlaneInvite_ADD_UI:Enable();
	else
		fuFrame_PlaneInvite_ADD_UI:Disable();
	end
	if PIG['Classes']['Assistant']=="ON" and PIG['PlaneInvite']["Kaiqi"]=="ON" and PIG['PlaneInvite']["AddBut"]=="ON" then
		if PlaneInvite_but_UI==nil then
			local aciWidth = ActionButton1:GetWidth()
			local Width,Height=aciWidth,aciWidth;
			local PlaneInvite_but = CreateFrame("Button", "PlaneInvite_but_UI", Classes_UI.nr);
			PlaneInvite_but:SetNormalTexture("interface/icons/ability_townwatch.blp");
			PlaneInvite_but:SetHighlightTexture(130718);
			PlaneInvite_but:SetSize(Width-1,Height-1);
			local geshu = {Classes_UI.nr:GetChildren()};
			if #geshu==0 then
				PlaneInvite_but:SetPoint("LEFT",Classes_UI.nr,"LEFT",0,0);
			else
				local Width=Width+2
				PlaneInvite_but:SetPoint("LEFT",Classes_UI.nr,"LEFT",#geshu*Width-Width,0);
			end
			PlaneInvite_but:RegisterForClicks("LeftButtonUp","RightButtonUp");

			PlaneInvite_but:SetScript("OnEnter", function ()
				GameTooltip:ClearLines();
				GameTooltip:SetOwner(PlaneInvite_but, "ANCHOR_TOPLEFT",2,4);
				GameTooltip:AddLine("左击-|cff00FFFF打开"..gongnengName.."|r")
				GameTooltip:Show();
			end);
			PlaneInvite_but:SetScript("OnLeave", function ()
				GameTooltip:ClearLines();
				GameTooltip:Hide() 
			end);
			PlaneInvite_but.Border = PlaneInvite_but:CreateTexture(nil, "BORDER");
			PlaneInvite_but.Border:SetTexture(130841);
			PlaneInvite_but.Border:ClearAllPoints();
			PlaneInvite_but.Border:SetPoint("TOPLEFT",PlaneInvite_but,"TOPLEFT",-Width*0.38,Height*0.39);
			PlaneInvite_but.Border:SetPoint("BOTTOMRIGHT",PlaneInvite_but,"BOTTOMRIGHT",Width*0.4,-Height*0.4);

			PlaneInvite_but.Down = PlaneInvite_but:CreateTexture(nil, "OVERLAY");
			PlaneInvite_but.Down:SetTexture(130839);
			PlaneInvite_but.Down:SetAllPoints(PlaneInvite_but)
			PlaneInvite_but.Down:Hide();
			PlaneInvite_but:SetScript("OnMouseDown", function (self)
				self.Down:Show();
				GameTooltip:ClearLines();
				GameTooltip:Hide() 
			end);
			PlaneInvite_but:SetScript("OnMouseUp", function (self)
				self.Down:Hide();
			end);
			PlaneInvite_but:SetScript("OnClick", function()
				if PlaneInvite_UI:IsShown() then
					PlaneInvite_UI:Hide();
				else
					PlaneInvite_UI:SetFrameLevel(10)
					PlaneInvite_UI:Show();
				end
			end);
		end
		addonTable.Classes_gengxinkuanduinfo()
	end
end
addonTable.ADD_PlaneInvite_but=ADD_PlaneInvite_but
-- ---------
fuFrame.shikongmenxian = fuFrame:CreateLine()
fuFrame.shikongmenxian:SetColorTexture(1,1,1,0.4)
fuFrame.shikongmenxian:SetThickness(1);
fuFrame.shikongmenxian:SetStartPoint("TOPLEFT",2,-150)
fuFrame.shikongmenxian:SetEndPoint("TOPRIGHT",-2,-150)
--------
fuFrame.PlaneInvite_ADD = CreateFrame("CheckButton", "fuFrame_PlaneInvite_ADD_UI", fuFrame, "ChatConfigCheckButtonTemplate");
fuFrame.PlaneInvite_ADD:SetSize(28,30);
fuFrame.PlaneInvite_ADD:SetHitRectInsets(0,-100,0,0);
fuFrame.PlaneInvite_ADD:SetMotionScriptsWhileDisabled(true) 
fuFrame.PlaneInvite_ADD:SetPoint("TOPLEFT",fuFrame.shikongmenxian,"TOPLEFT",300,-12);
fuFrame.PlaneInvite_ADD.Text:SetText("添加"..gongnengName.."到快捷按钮");
fuFrame.PlaneInvite_ADD.tooltip = "添加"..gongnengName.."到快捷按钮中，方便打开关闭。\n|cff00FF00注意：此功能需先打开快捷按钮功能|r";
fuFrame.PlaneInvite_ADD:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG['PlaneInvite']["AddBut"]="ON"
		ADD_PlaneInvite_but()
	else
		PIG['PlaneInvite']["AddBut"]="OFF"
		Pig_Options_RLtishi_UI:Show();
	end
end);
-------
fuFrame.PlaneInvite = CreateFrame("CheckButton", nil, fuFrame, "ChatConfigCheckButtonTemplate");
fuFrame.PlaneInvite:SetSize(28,30);
fuFrame.PlaneInvite:SetHitRectInsets(0,-80,0,0);
fuFrame.PlaneInvite:SetPoint("TOPLEFT",fuFrame.shikongmenxian,"TOPLEFT",20,-12);
fuFrame.PlaneInvite.Text:SetText(gongnengName);
fuFrame.PlaneInvite.tooltip = "方便你迁跃到其他位面";
fuFrame.PlaneInvite:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG['PlaneInvite']['Kaiqi']="ON";
		ADD_PlaneInviteFrame()
		Pig_OptionsUI.PlaneInvite:Enable();
	else
		PIG['PlaneInvite']['Kaiqi']="OFF";
		Pig_OptionsUI.PlaneInvite:Disable();
		Pig_Options_RLtishi_UI:Show()
	end
	ADD_PlaneInvite_but()
end);
--------------------------------------------
addonTable.PlaneInvite = function()
	PIG['PlaneInvite']=PIG['PlaneInvite'] or addonTable.Default['PlaneInvite']
	PIG['PlaneInvite']['Kaiqi']=PIG['PlaneInvite']['Kaiqi'] or addonTable.Default['PlaneInvite']['Kaiqi']
	if PIG['PlaneInvite']['Kaiqi']=="ON" then
		fuFrame.PlaneInvite:SetChecked(true);
		ADD_PlaneInviteFrame()
		Pig_OptionsUI.PlaneInvite:Enable();
	end
end