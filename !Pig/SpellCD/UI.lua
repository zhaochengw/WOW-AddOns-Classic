local _, addonTable = ...;
---------.
local fuFrame=Pig_Options_RF_TAB_10_UI
--=============================================================
local gongnengName = "技能监控";
---设置主面板
Pig_OptionsUI.Spell_CD = CreateFrame("Button",nil,Pig_OptionsUI, "UIPanelButtonTemplate");  
Pig_OptionsUI.Spell_CD:SetSize(90,28);
Pig_OptionsUI.Spell_CD:SetPoint("TOPLEFT",Pig_OptionsUI,"TOPLEFT",360,-24);
Pig_OptionsUI.Spell_CD:SetText(gongnengName);
Pig_OptionsUI.Spell_CD:Disable();
Pig_OptionsUI.Spell_CD:SetMotionScriptsWhileDisabled(true)
Pig_OptionsUI.Spell_CD:SetScript("OnClick", function ()
	SpellJK_UI:SetFrameLevel(30)
	SpellJK_UI:Show();
	Pig_OptionsUI:Hide();
end);
Pig_OptionsUI.Spell_CD:SetScript("OnEnter", function (self)
	GameTooltip:ClearLines();
	GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT",0,0);
	if not self:IsEnabled() then
		GameTooltip:AddLine(gongnengName.."尚未启用，请在功能模块内启用")
	end
	GameTooltip:Show();
end);
Pig_OptionsUI.Spell_CD:SetScript("OnLeave", function ()
	GameTooltip:ClearLines();
	GameTooltip:Hide()
end);
--==========================
local Width,Height=660,500
local SpellJK = CreateFrame("Frame", "SpellJK_UI", UIParent,"BackdropTemplate");
SpellJK:SetBackdrop( { bgFile = "interface/raidframe/ui-raidframe-groupbg.blp",
	edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
	tile = false, tileSize = 0, edgeSize = 14, 
	insets = { left = 4, right = 4, top = 4, bottom = 4 } });
SpellJK:SetSize(Width,Height);
SpellJK:SetPoint("CENTER",UIParent,"CENTER",0,50);
SpellJK:EnableMouse(true)
SpellJK:SetMovable(true)
SpellJK:SetClampedToScreen(true)
SpellJK:Hide()
tinsert(UISpecialFrames,"SpellJK_UI");
SpellJK.yidong = CreateFrame("Frame", nil, SpellJK);
SpellJK.yidong:SetSize(200,26);
SpellJK.yidong:SetPoint("TOP", SpellJK, "TOP", 0, 0);
SpellJK.yidong:EnableMouse(true)
SpellJK.yidong:RegisterForDrag("LeftButton")
SpellJK.yidong:SetScript("OnDragStart",function()
	SpellJK:StartMoving()
end)
SpellJK.yidong:SetScript("OnDragStop",function()
	SpellJK:StopMovingOrSizing()
end)
SpellJK.Biaoti = SpellJK:CreateFontString();
SpellJK.Biaoti:SetPoint("TOP", SpellJK, "TOP", 0,-7);
SpellJK.Biaoti:SetFontObject(GameFontNormal);
SpellJK.Biaoti:SetText(gongnengName);
SpellJK.Close = CreateFrame("Button",nil,SpellJK, "UIPanelCloseButton");  
SpellJK.Close:SetSize(30,30);
SpellJK.Close:SetPoint("TOPRIGHT",SpellJK,"TOPRIGHT",0,1);
SpellJK.line = SpellJK:CreateLine()
SpellJK.line:SetColorTexture(1,1,1,0.6)
SpellJK.line:SetThickness(1);
SpellJK.line:SetStartPoint("TOPLEFT",3,-26)
SpellJK.line:SetEndPoint("TOPRIGHT",-2,-26)

SpellJK.F= CreateFrame("Frame", nil, SpellJK);
SpellJK.F:SetPoint("TOPLEFT", SpellJK, "TOPLEFT", 0,-28);
SpellJK.F:SetPoint("BOTTOMRIGHT", SpellJK, "BOTTOMRIGHT", 0,0);
----========================================================
local tab_Width,tab_Height=110,26
local TAB_Name={"BUFF缺失提醒","自身控制时长","队友技能冷却","目标BUFF监控","敌对控制冷却"} 
for i=1,#TAB_Name do
	SpellJK.F.TAB= CreateFrame("Button", "SpellJK.F_TAB_"..i, SpellJK.F,nil,i);
	SpellJK.F.TAB:SetSize(tab_Width,tab_Height);
	if i==1 then
		SpellJK.F.TAB:SetPoint("TOPLEFT", SpellJK.F, "BOTTOMLEFT", 10,4);
	else
		SpellJK.F.TAB:SetPoint("LEFT", _G["SpellJK.F_TAB_"..(i-1)], "RIGHT", 20,0);
	end
	SpellJK.F.TAB.Tex = SpellJK.F.TAB:CreateTexture(nil, "BORDER");
	if i==1 then
		SpellJK.F.TAB.Tex:SetTexture("interface/paperdollinfoframe/ui-character-activetab.blp");
	else
		SpellJK.F.TAB.Tex:SetTexture("interface/paperdollinfoframe/ui-character-inactivetab.blp");
	end
	SpellJK.F.TAB.Tex:SetPoint("TOP", SpellJK.F.TAB, "TOP", 0,0);
	SpellJK.F.TAB.title = SpellJK.F.TAB:CreateFontString();
	SpellJK.F.TAB.title:SetPoint("TOP", SpellJK.F.TAB, "TOP", 0,-5);
	SpellJK.F.TAB.title:SetFontObject(GameFontNormalSmall);
	SpellJK.F.TAB.title:SetText(TAB_Name[i]);
	if i==1 then
		SpellJK.F.TAB.title:SetTextColor(1, 1, 1, 1);
	else
		SpellJK.F.TAB.title:SetTextColor(1, 215/255, 0, 1);
	end
	SpellJK.F.TAB.highlight = SpellJK.F.TAB:CreateTexture(nil, "BORDER");
	SpellJK.F.TAB.highlight:SetTexture("interface/paperdollinfoframe/ui-character-tab-highlight.blp");
	SpellJK.F.TAB.highlight:SetBlendMode("ADD")
	SpellJK.F.TAB.highlight:SetPoint("CENTER", SpellJK.F.TAB.title, "CENTER", 0,0);
	SpellJK.F.TAB.highlight:SetSize(tab_Width,tab_Height);
	SpellJK.F.TAB.highlight:Hide();
	SpellJK.F.TAB:SetScript("OnEnter", function (self)
		if not _G["SpellJK_F_TabFrame_"..self:GetID()]:IsShown() then
			self.title:SetTextColor(1, 1, 1, 1);
			self.highlight:Show();
		end
	end);
	SpellJK.F.TAB:SetScript("OnLeave", function (self)
		if not _G["SpellJK_F_TabFrame_"..self:GetID()]:IsShown() then
			self.title:SetTextColor(1, 215/255, 0, 1);	
		end
		self.highlight:Hide();
	end);
	----------
	SpellJK.F.TabFrame= CreateFrame("Frame", "SpellJK_F_TabFrame_"..i, SpellJK.F);
	SpellJK.F.TabFrame:SetPoint("TOPLEFT", SpellJK.F, "TOPLEFT", 0,0);
	SpellJK.F.TabFrame:SetPoint("BOTTOMRIGHT", SpellJK.F, "BOTTOMRIGHT", 0,0);
	if i~=1 then
		SpellJK.F.TabFrame:Hide()
	end
	---------------
	SpellJK.F.TAB:SetScript("OnClick", function (self)
		for x=1,#TAB_Name do
			_G["SpellJK.F_TAB_"..x].Tex:SetTexture("interface/paperdollinfoframe/ui-character-inactivetab.blp");
			_G["SpellJK.F_TAB_"..x].title:SetTextColor(1, 215/255, 0, 1);
			_G["SpellJK_F_TabFrame_"..x]:Hide();
		end
		self.Tex:SetTexture("interface/paperdollinfoframe/ui-character-activetab.blp");
		self.title:SetTextColor(1, 1, 1, 1);
		self.highlight:Hide();
		_G["SpellJK_F_TabFrame_"..self:GetID()]:Show();
	end);
end
--=====================================
SpellJK.ceshi = CreateFrame("Button",nil,SpellJK, "UIPanelButtonTemplate");  
SpellJK.ceshi:SetSize(84,22);
SpellJK.ceshi:SetPoint("TOPRIGHT",SpellJK,"TOPRIGHT",-40,-3);
SpellJK.ceshi:SetText("调试模式");
SpellJK.ceshi:SetScript("OnClick", function ()
	if SpellJK.ceshi:GetText()=="调试模式" then
		SpellJK.ceshi:SetText("关闭调试");
		SpellJK:SetHeight(28)
		SpellJK_UI.F:Hide();
		if zishenBUFF_UI then
			zishenBUFF_UI.yidong:Show()
		end
		if zishenJiankong_UI then
			zishenJiankong_UI.yidong:Show()
		end
		if duiyouJiankong_UI then
			duiyouJiankong_UI.yidong:Show()
		end
		if mubiaoBUFF_UI then
			mubiaoBUFF_UI.yidong:Show()
		end
	elseif SpellJK.ceshi:GetText()=="关闭调试" then
		SpellJK.ceshi:SetText("调试模式");
		SpellJK:SetHeight(Height)
		SpellJK_UI.F:Show();
		if zishenBUFF_UI then
			zishenBUFF_UI.yidong:Hide()
		end
		if zishenJiankong_UI then
			zishenJiankong_UI.yidong:Hide()
		end
		if duiyouJiankong_UI then
			duiyouJiankong_UI.yidong:Hide()
		end
		if mubiaoBUFF_UI then
			mubiaoBUFF_UI.yidong:Hide()
		end
	end
end);
SpellJK:SetScript("OnHide", function()
	SpellJK.ceshi:SetText("调试模式");
	SpellJK:SetHeight(Height)
	SpellJK_UI.F:Show();
	if zishenBUFF_UI then
		zishenBUFF_UI.yidong:Hide()
	end
	if zishenJiankong_UI then
		zishenJiankong_UI.yidong:Hide()
	end
	if duiyouJiankong_UI then
		duiyouJiankong_UI.yidong:Hide()
	end
end)
--=================================================================================
--提示
SpellJK.tishi = CreateFrame("Frame", nil, SpellJK);
SpellJK.tishi:SetSize(30,30);
SpellJK.tishi:SetPoint("TOPLEFT",SpellJK,"TOPLEFT",0,0);
SpellJK.tishi.Texture = SpellJK.tishi:CreateTexture(nil, "BORDER");
SpellJK.tishi.Texture:SetTexture("interface/common/help-i.blp");
SpellJK.tishi.Texture:SetAllPoints(SpellJK.tishi)
SpellJK.tishi:SetScript("OnEnter", function ()
	GameTooltip:ClearLines();
	GameTooltip:SetOwner(SpellJK.tishi, "ANCHOR_TOPLEFT",0,0);
	GameTooltip:AddLine("提示：")
	GameTooltip:AddLine("\124cff00ff00注意战斗记录无法获取玩家施放技能等级，\n如果冷却时间不正确，请添加正确的技能等级ID。\n同名技能只能添加一个，建议直接添加技能最高等级ID。\124r")
	GameTooltip:Show();
end);
SpellJK.tishi:SetScript("OnLeave", function ()
	GameTooltip:ClearLines();
	GameTooltip:Hide() 
end);
--===============================
--添加快捷打开按钮
local function ADD_SpellCD_but()
	PIG_Per['SpellJK']=PIG_Per['SpellJK'] or addonTable.Default_Per['SpellJK']
	PIG_Per['SpellJK']['Kaiqi']=PIG_Per['SpellJK']['Kaiqi'] or addonTable.Default_Per['SpellJK']['Kaiqi']
	PIG_Per['SpellJK']['AddBut']=PIG_Per['SpellJK']['AddBut'] or addonTable.Default_Per['SpellJK']['AddBut']
	if PIG_Per["SpellJK"]["AddBut"]=="ON" then
		fuFrame_Spell_Open_ADD_UI:SetChecked(true);
	end
	if PIG['Classes']['Assistant']=="ON" and PIG_Per["SpellJK"]["Kaiqi"]=="ON" then
		fuFrame_Spell_Open_ADD_UI:Enable();
	else
		fuFrame_Spell_Open_ADD_UI:Disable();
	end
	if PIG['Classes']['Assistant']=="ON" and PIG_Per["SpellJK"]["Kaiqi"]=="ON" and PIG_Per["SpellJK"]["AddBut"]=="ON" then
		if Spell_but_UI==nil then
			local aciWidth = ActionButton1:GetWidth()
			local Width,Height=aciWidth,aciWidth;
			local Spell_but = CreateFrame("Button", "Spell_but_UI", Classes_UI.nr);
			Spell_but:SetNormalTexture("interface/icons/spell_nature_timestop.blp");
			Spell_but:SetHighlightTexture(130718);
			Spell_but:SetSize(Width-1,Height-1);
			local geshu = {Classes_UI.nr:GetChildren()};
			if #geshu==0 then
				Spell_but:SetPoint("LEFT",Classes_UI.nr,"LEFT",0,0);
			else
				local Width=Width+2
				Spell_but:SetPoint("LEFT",Classes_UI.nr,"LEFT",#geshu*Width-Width,0);
			end
			Spell_but:RegisterForClicks("LeftButtonUp","RightButtonUp");

			Spell_but:SetScript("OnEnter", function ()
				GameTooltip:ClearLines();
				GameTooltip:SetOwner(Spell_but, "ANCHOR_TOPLEFT",2,4);
				GameTooltip:AddLine("左击-|cff00FFFF打开技能CD监控|r")
				GameTooltip:Show();
			end);
			Spell_but:SetScript("OnLeave", function ()
				GameTooltip:ClearLines();
				GameTooltip:Hide() 
			end);
			Spell_but.Border = Spell_but:CreateTexture(nil, "BORDER");
			Spell_but.Border:SetTexture(130841);
			Spell_but.Border:ClearAllPoints();
			Spell_but.Border:SetPoint("TOPLEFT",Spell_but,"TOPLEFT",-Width*0.38,Height*0.39);
			Spell_but.Border:SetPoint("BOTTOMRIGHT",Spell_but,"BOTTOMRIGHT",Width*0.4,-Height*0.4);

			Spell_but.Down = Spell_but:CreateTexture(nil, "OVERLAY");
			Spell_but.Down:SetTexture(130839);
			Spell_but.Down:SetAllPoints(Spell_but)
			Spell_but.Down:Hide();
			Spell_but:SetScript("OnMouseDown", function (self)
				self.Down:Show();
				GameTooltip:ClearLines();
				GameTooltip:Hide() 
			end);
			Spell_but:SetScript("OnMouseUp", function (self)
				self.Down:Hide();
			end);
			Spell_but:SetScript("OnClick", function()
				if SpellJK_UI:IsShown() then
					SpellJK_UI:Hide();
				else
					SpellJK_UI:SetFrameLevel(30)
					SpellJK_UI:Show();
				end
			end);
		end
		addonTable.Classes_gengxinkuanduinfo()
	end
end
addonTable.ADD_SpellCD_but=ADD_SpellCD_but
-- ---------
fuFrame.jinengjiankxian = fuFrame:CreateLine()
fuFrame.jinengjiankxian:SetColorTexture(1,1,1,0.4)
fuFrame.jinengjiankxian:SetThickness(1);
fuFrame.jinengjiankxian:SetStartPoint("TOPLEFT",2,-100)
fuFrame.jinengjiankxian:SetEndPoint("TOPRIGHT",-2,-100)
--------
fuFrame.Spell_Open_ADD = CreateFrame("CheckButton", "fuFrame_Spell_Open_ADD_UI", fuFrame, "ChatConfigCheckButtonTemplate");
fuFrame.Spell_Open_ADD:SetSize(28,30);
fuFrame.Spell_Open_ADD:SetHitRectInsets(0,-100,0,0);
fuFrame.Spell_Open_ADD:SetMotionScriptsWhileDisabled(true) 
fuFrame.Spell_Open_ADD:SetPoint("TOPLEFT",fuFrame.jinengjiankxian,"TOPLEFT",300,-12);
fuFrame.Spell_Open_ADD.Text:SetText("添加"..gongnengName.."到快捷按钮");
fuFrame.Spell_Open_ADD.tooltip = "添加"..gongnengName.."到快捷按钮中，方便打开关闭。\n|cff00FF00注意：此功能需先打开快捷按钮功能|r";
fuFrame.Spell_Open_ADD:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG_Per["SpellJK"]["AddBut"]="ON"
		ADD_SpellCD_but()
	else
		PIG_Per["SpellJK"]["AddBut"]="OFF"
		Pig_Options_RLtishi_UI:Show();
	end
end);
-------
fuFrame.Spell_Open = CreateFrame("CheckButton", nil, fuFrame, "ChatConfigCheckButtonTemplate");
fuFrame.Spell_Open:SetSize(28,30);
fuFrame.Spell_Open:SetHitRectInsets(0,-80,0,0);
fuFrame.Spell_Open:SetPoint("TOPLEFT",fuFrame.jinengjiankxian,"TOPLEFT",20,-12);
fuFrame.Spell_Open.Text:SetText(gongnengName);
fuFrame.Spell_Open.tooltip = "监控技能CD！";
fuFrame.Spell_Open:SetScript("OnClick", function (self)
	if self:GetChecked() then
		Pig_OptionsUI.Spell_CD:Enable();
		PIG_Per['SpellJK']['Kaiqi']="ON";
	else
		Pig_OptionsUI.Spell_CD:Disable();
		PIG_Per['SpellJK']['Kaiqi']="OFF";
		Pig_Options_RLtishi_UI:Show()
	end
	ADD_SpellCD_but()
end);
StaticPopupDialogs["PIG_Reload_UI"] = {
	text = "需要重载界面使配置生效，确定重载?",
	button1 = "确定",
	button2 = "取消",
	OnAccept = function()
		ReloadUI()
	end,
	timeout = 0,
	whileDead = true,
	hideOnEscape = true,
}
--=====================================
addonTable.Spell_CD_JK = function()
	PIG_Per['SpellJK']=PIG_Per['SpellJK'] or addonTable.Default_Per['SpellJK']
	PIG_Per['SpellJK']['Kaiqi']=PIG_Per['SpellJK']['Kaiqi'] or addonTable.Default_Per['SpellJK']['Kaiqi']
	PIG_Per['SpellJK']['AddBut']=PIG_Per['SpellJK']['AddBut'] or addonTable.Default_Per['SpellJK']['AddBut']
	if PIG_Per['SpellJK']['Kaiqi']=="ON" then
		fuFrame.Spell_Open:SetChecked(true);
		Pig_OptionsUI.Spell_CD:Enable();
	end
	if PIG_Per['SpellJK']['AddBut']=="ON" then
		fuFrame.Spell_Open_ADD:SetChecked(true);
	end
	addonTable.zishenBUFF()
	addonTable.zishenCC()
	addonTable.duiyouCD()
	addonTable.mubiaoBUFF()
end