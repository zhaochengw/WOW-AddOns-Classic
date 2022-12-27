local _, addonTable = ...;
---------.
local fuFrame=List_R_F_2_6
--=============================================================
local Create = addonTable.Create
local PIGModbutton=Create.PIGModbutton
local ADD_Frame=addonTable.ADD_Frame
local GnName,GnUI = "技能监控","SpellJK_UI";
local FrameLevel=30
local Options_Spell_CD = PIGModbutton(GnName,GnUI,FrameLevel,1)
--==========================
local Width,Height=660,500
local SpellJK=ADD_Frame("SpellJK_UI",UIParent,Width,Height,"CENTER",UIParent,"CENTER",0,50,true,false,true,true,true,"BG2")
SpellJK.Biaoti = SpellJK:CreateFontString();
SpellJK.Biaoti:SetPoint("TOP", SpellJK, "TOP", 0,-2);
SpellJK.Biaoti:SetFontObject(GameFontNormal);
SpellJK.Biaoti:SetText(GnName);
--提示
SpellJK.tishi = CreateFrame("Frame", nil, SpellJK);
SpellJK.tishi:SetSize(22,22);
SpellJK.tishi:SetPoint("TOPLEFT",SpellJK,"TOPLEFT",0,0);
SpellJK.tishi.Texture = SpellJK.tishi:CreateTexture(nil, "BORDER");
SpellJK.tishi.Texture:SetTexture("interface/common/help-i.blp");
SpellJK.tishi.Texture:SetSize(28,28);
SpellJK.tishi.Texture:SetPoint("CENTER",0,0);
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
---------
SpellJK.ceshi = CreateFrame("Button",nil,SpellJK, "UIPanelButtonTemplate");  
SpellJK.ceshi:SetSize(84,18);
SpellJK.ceshi:SetPoint("TOPRIGHT",SpellJK,"TOPRIGHT",-40,-1);
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
SpellJK:HookScript("OnHide", function()
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
------------------------------
SpellJK.F= CreateFrame("Frame", nil, SpellJK,"BackdropTemplate");
SpellJK.F:SetBackdrop({bgFile = "interface/raidframe/ui-raidframe-groupbg.blp"})
SpellJK.F:SetPoint("TOPLEFT", SpellJK, "TOPLEFT", 2,-22);
SpellJK.F:SetPoint("BOTTOMRIGHT", SpellJK, "BOTTOMRIGHT", -4,2);
----
local tab_Width,tab_Height=110,26
local TAB_Name={"BUFF缺失","自身控制","队友冷却","目标BUFF","敌对控制"} 
for i=1,#TAB_Name do
	SpellJK.F.TAB= CreateFrame("Button", "SpellJK.F_TAB_"..i, SpellJK.F,nil,i);
	SpellJK.F.TAB:SetSize(tab_Width,tab_Height);
	if i==1 then
		SpellJK.F.TAB:SetPoint("TOPLEFT", SpellJK.F, "BOTTOMLEFT", 10,2);
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

--============================================
local ADD_ModCheckbutton =addonTable.ADD_ModCheckbutton
local Tooltip = "监控技能CD/BUFF缺失获得！";
local Cfanwei,xulieID = -80, 0
local OptionsModF_Spell_JK = ADD_ModCheckbutton(GnName,Tooltip,fuFrame,Cfanwei,xulieID)
---
local ADD_QuickButton=addonTable.ADD_QuickButton
local function ADD_QuickButton_SpellJK()
	local ckbut = OptionsModF_Spell_JK.ADD
	if PIG_Per["SpellJK"]["AddBut"]=="ON" then
		ckbut:SetChecked(true);
	end
	if PIG['QuickButton']['Open'] and PIG_Per["SpellJK"]["Kaiqi"]=="ON" then
		ckbut:Enable();
	else
		ckbut:Disable();
	end
	if PIG['QuickButton']['Open'] and PIG_Per["SpellJK"]["Kaiqi"]=="ON" and PIG_Per["SpellJK"]["AddBut"]=="ON" then
		local QkBut = "QkBut_SpellCD"
		if _G[QkBut] then return end
		local Icon=136106
		local Tooltip = "点击-|cff00FFFF打开"..GnName.."监控|r"
		local QkBut=ADD_QuickButton(QkBut,Tooltip,Icon)
		QkBut:SetScript("OnClick", function(self,button)
			if _G[GnUI]:IsShown() then
				_G[GnUI]:Hide();
			else
				_G[GnUI]:SetFrameLevel(FrameLevel)
				_G[GnUI]:Show();
			end
		end);
	end
end
addonTable.ADD_QuickButton_SpellJK=ADD_QuickButton_SpellJK
---
OptionsModF_Spell_JK:SetScript("OnClick", function (self)
	if self:GetChecked() then
		Options_Spell_CD:Enable();
		PIG_Per['SpellJK']['Kaiqi']="ON";
	else
		Options_Spell_CD:Disable();
		PIG_Per['SpellJK']['Kaiqi']="OFF";
		Pig_Options_RLtishi_UI:Show()
	end
	ADD_QuickButton_SpellJK()
end);

OptionsModF_Spell_JK.ADD:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG_Per["SpellJK"]["AddBut"]="ON"
		ADD_QuickButton_SpellJK()
	else
		PIG_Per["SpellJK"]["AddBut"]="OFF"
		Pig_Options_RLtishi_UI:Show();
	end
end);
-------
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
	if PIG_Per['SpellJK']['Kaiqi']=="ON" then
		OptionsModF_Spell_JK:SetChecked(true);
		Options_Spell_CD:Enable();
	end
	addonTable.zishenBUFF()
	addonTable.zishenCC()
	addonTable.duiyouCD()
	addonTable.mubiaoBUFF()
end