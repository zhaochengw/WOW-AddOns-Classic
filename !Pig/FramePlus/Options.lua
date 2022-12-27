local _, addonTable = ...;
local fuFrame=List_R_F_1_5
local _, _, _, tocversion = GetBuildInfo()
local ADD_Checkbutton=addonTable.ADD_Checkbutton
---------------------
local RenwuFrame_Open=addonTable.RenwuFrame_Open
fuFrame.Renwu=ADD_Checkbutton(nil,fuFrame,-100,"TOPLEFT",fuFrame,"TOPLEFT",20,-20,"任务界面扩展","")
if tocversion<30000 then
	fuFrame.Renwu.tooltip= "扩展任务界面为两列,左边任务列表，右边任务详情,显示任务等级";
elseif tocversion<40000 then
	fuFrame.Renwu.tooltip= "任务列表显示任务等级";
else
	PIGDisable(fuFrame.Renwu)
end
fuFrame.Renwu:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG["FramePlus"]["ExtFrame_Renwu"]="ON";	
	else
		PIG["FramePlus"]["ExtFrame_Renwu"]="OFF";
		Pig_Options_RLtishi_UI:Show()
	end
	RenwuFrame_Open();
end);
--
local ZhuanyeFrame_Open=addonTable.ZhuanyeFrame_Open
fuFrame.Zhuanye=ADD_Checkbutton(nil,fuFrame,-60,"TOPLEFT",fuFrame,"TOPLEFT",300,-20,"专业界面扩展","扩展专业技能界面为两列；左边配方列表，右边配方详情")
if tocversion>40000 then
	PIGDisable(fuFrame.Zhuanye)
end
fuFrame.Zhuanye:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG["FramePlus"]["ExtFrame_Zhuanye"]="ON";
		ZhuanyeFrame_Open();
	else
		PIG["FramePlus"]["ExtFrame_Zhuanye"]="OFF";
		Pig_Options_RLtishi_UI:Show()
	end
end);
-----------------------
local ZhuanyeQKBUT_Open=addonTable.ZhuanyeQKBUT_Open
fuFrame.QuickQH=ADD_Checkbutton(nil,fuFrame,-60,"TOPLEFT",fuFrame,"TOPLEFT",300,-60,"专业快速切换按钮","在专业界面显示便捷切换专业按钮")
fuFrame.QuickQH:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG["FramePlus"]["ExtFrame_ZhuanyeQKBUT"]=true;
		ZhuanyeQKBUT_Open();
	else
		PIG["FramePlus"]["ExtFrame_ZhuanyeQKBUT"]=false;
		Pig_Options_RLtishi_UI:Show()
	end
end);
local TalentFrame_Open=addonTable.TalentFrame_Open
fuFrame.TalentFrame=ADD_Checkbutton(nil,fuFrame,-60,"TOPLEFT",fuFrame,"TOPLEFT",20,-100,"天赋面板扩展","")
if tocversion<30000 then
	fuFrame.TalentFrame.tooltip= "在一页显示三系天赋";
elseif tocversion<40000 then
	fuFrame.TalentFrame.tooltip= "在一页显示三系天赋和雕文";
else
	PIGDisable(fuFrame.TalentFrame)
end
fuFrame.TalentFrame:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG["FramePlus"]["ExtFrame_Talent"]="ON";
		TalentFrame_Open()
	else
		PIG["FramePlus"]["ExtFrame_Talent"]="OFF";
		Pig_Options_RLtishi_UI:Show()
	end
end);
--=====================================
fuFrame:HookScript("OnShow", function (self)
	if PIG["FramePlus"]["ExtFrame_Renwu"]=="ON" then
		fuFrame.Renwu:SetChecked(true);
	end
	if PIG["FramePlus"]["ExtFrame_Zhuanye"]=="ON" then
		fuFrame.Zhuanye:SetChecked(true);
	end
	if PIG["FramePlus"]["ExtFrame_ZhuanyeQKBUT"] then
		fuFrame.QuickQH:SetChecked(true);
	end
	if PIG["FramePlus"]["ExtFrame_Talent"]=="ON" then
		fuFrame.TalentFrame:SetChecked(true);
	end
end);
addonTable.FramePlus = function()
	if PIG["FramePlus"]["ExtFrame_Renwu"]=="ON" then
		if fuFrame.Renwu:IsEnabled() then
			RenwuFrame_Open();
		end
	end
	if PIG["FramePlus"]["ExtFrame_Zhuanye"]=="ON" then
		if fuFrame.Zhuanye:IsEnabled() then
			ZhuanyeFrame_Open();
		end
	end
	if PIG["FramePlus"]["ExtFrame_ZhuanyeQKBUT"] then
		ZhuanyeQKBUT_Open();
	end
	if PIG["FramePlus"]["ExtFrame_Talent"]=="ON" then
		TalentFrame_Open()
	end
end