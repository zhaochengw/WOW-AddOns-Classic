local _, addonTable = ...;
local fuFrame=List_R_F_1_6
local _, _, _, tocversion = GetBuildInfo()
-------------------------------------------------
--隐藏狮鹫图标
local function Hide_yingbiao()
	if PIG['PigUI']['Hide_shijiu']=="ON" then
		fuFrame.HideShijiu:SetChecked(true);
		MainMenuBarArtFrame.RightEndCap:Hide();--隐藏右侧鹰标 
		MainMenuBarArtFrame.LeftEndCap:Hide();--隐藏左侧鹰标
	elseif PIG['PigUI']['Hide_shijiu']=="OFF" then
		fuFrame.HideShijiu:SetChecked(false);
		MainMenuBarArtFrame.RightEndCap:Show();--隐藏右侧鹰标 
		MainMenuBarArtFrame.LeftEndCap:Show();--隐藏左侧鹰标
	end
end
fuFrame.HideShijiu = CreateFrame("CheckButton", nil, fuFrame, "ChatConfigCheckButtonTemplate");
fuFrame.HideShijiu:SetSize(30,32);
fuFrame.HideShijiu:SetHitRectInsets(0,-100,0,0);
fuFrame.HideShijiu:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",20,-10);
fuFrame.HideShijiu.Text:SetText("隐藏狮鹫图标");
fuFrame.HideShijiu.tooltip = "隐藏动作条两边的狮鹫图标。";
fuFrame.HideShijiu:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG['PigUI']['Hide_shijiu']="ON";
	else
		PIG['PigUI']['Hide_shijiu']="OFF";
	end
	Hide_yingbiao()
end);
----隐藏动作条背景
local function Hide_barBG()
	if PIG['PigUI']['Hide_ActionBG']=="ON" then
		fuFrame.barBG:SetChecked(true);
		MainMenuBarArtFrameBackground:Hide();
	elseif PIG['PigUI']['Hide_ActionBG']=="OFF" then
		fuFrame.barBG:SetChecked(false);
		MainMenuBarArtFrameBackground:Show();
	end
end
fuFrame.barBG = CreateFrame("CheckButton", nil, fuFrame, "ChatConfigCheckButtonTemplate");
fuFrame.barBG:SetSize(30,32);
fuFrame.barBG:SetHitRectInsets(0,-100,0,0);
fuFrame.barBG:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",250,-10);
fuFrame.barBG.Text:SetText("隐藏动作条背景");
fuFrame.barBG.tooltip = "隐藏动作条背景。";
fuFrame.barBG:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG['PigUI']['Hide_ActionBG']="ON";
	else
		PIG['PigUI']['Hide_ActionBG']="OFF";
	end
	Hide_barBG()
end);
--==============================================
local kuangjF = {"MainMenuBarBackpackButton","CharacterBag0Slot","CharacterBag1Slot","CharacterBag2Slot","CharacterBag3Slot",
	"CharacterMicroButton","SpellbookMicroButton","TalentMicroButton","AchievementMicroButton","QuestLogMicroButton",
	"GuildMicroButton","LFDMicroButton","CollectionsMicroButton","EJMicroButton","StoreMicroButton","MainMenuMicroButton"}
local function shuaxin_MenuBag()
	local suofangbi =PIG['PigUI']['MenuBag_bili_value'] or 0.9
	fuFrame.MenuBag_bili_Slider:SetValue(suofangbi);
	fuFrame.MenuBag_bili_Slider.Text:SetText(suofangbi);
	MicroButtonAndBagsBar.MicroBagBar:Hide();--背包背景
	if PIG['PigUI']['MenuBag'] then 
		for i=1,#kuangjF do
			local Fname =_G[kuangjF[i]]
			Fname:SetParent(UIParent)
			if kuangjF[i]=="MainMenuBarBackpackButton" then
				Fname:SetScale(suofangbi*0.79)
			else
				Fname:SetScale(suofangbi)
			end
		end

		local WowWidth=GetScreenWidth()
		if WowWidth>1440 then
			for i=1,#kuangjF do
				local Fname =_G[kuangjF[i]]
				Fname:ClearAllPoints();
				if i==1 then
					Fname:SetPoint("BOTTOMLEFT",UIParent,"BOTTOMLEFT",0,0);
				else
					local Fnamexx =_G[kuangjF[i-1]]
					if i==6 then
						Fname:SetPoint("LEFT",Fnamexx,"RIGHT",-1,0);
					elseif i<6 then
						local Fnamexx =_G[kuangjF[i-1]]
						Fname:SetPoint("LEFT",Fnamexx,"RIGHT",0,0);
					else
						local Fnamexx =_G[kuangjF[i-1]]
						Fname:SetPoint("LEFT",Fnamexx,"RIGHT",-4,0);
					end
				end
			end
		else
			for i=6,#kuangjF do
				local Fname =_G[kuangjF[i]]
				Fname:ClearAllPoints();
				if i==6 then
					Fname:SetPoint("BOTTOMLEFT",UIParent,"BOTTOMLEFT",0,0);
				else
					local Fnamexx =_G[kuangjF[i-1]]
					Fname:SetPoint("LEFT",Fnamexx,"RIGHT",-4,0);
				end
			end
			for i=1,5 do
				local Fname =_G[kuangjF[i]]
				Fname:ClearAllPoints();
				if i==1 then
					Fname:SetPoint("BOTTOMLEFT",CharacterMicroButton,"TOPLEFT",3,0);
				else
					local Fnamexx =_G[kuangjF[i-1]]
					Fname:SetPoint("LEFT",Fnamexx,"RIGHT",1,0);
				end
			end
		end
	else
		for i=1,#kuangjF do
			local Fname =_G[kuangjF[i]]
			Fname:SetParent(UIParent)
			if kuangjF[i]=="MainMenuBarBackpackButton" then
				Fname:SetScale(suofangbi*0.79)
			else
				Fname:SetScale(suofangbi)
			end
		end

		local WowWidth=GetScreenWidth()
		if WowWidth>1440 then
			for i=1,5 do
				local Fname =_G[kuangjF[i]]
				Fname:ClearAllPoints();
				if i==1 then
					Fname:SetPoint("BOTTOMRIGHT",UIParent,"BOTTOMRIGHT",0,1);
				else
					local Fnamexx =_G[kuangjF[i-1]]
					Fname:SetPoint("RIGHT",Fnamexx,"LEFT",1,0);
				end
			end
			for i=#kuangjF,6,-1 do
				local Fname =_G[kuangjF[i]]
				Fname:ClearAllPoints();
				if i==#kuangjF then
					Fname:SetPoint("RIGHT",CharacterBag3Slot,"LEFT",-1,-1);
				else
					local Fnamexx =_G[kuangjF[i+1]]
					Fname:SetPoint("RIGHT",Fnamexx,"LEFT",4,0);
				end
			end
		else
			for i=1,5 do
				local Fname =_G[kuangjF[i]]
				Fname:ClearAllPoints();
				if i==1 then
					Fname:SetPoint("BOTTOMLEFT",MainMenuMicroButton,"TOPLEFT",-8,0);
				else
					local Fnamexx =_G[kuangjF[i-1]]
					Fname:SetPoint("RIGHT",Fnamexx,"LEFT",-1,0);
				end
			end
			for i=#kuangjF,6,-1 do
				local Fname =_G[kuangjF[i]]
				Fname:ClearAllPoints();
				if i==#kuangjF then
					Fname:SetPoint("BOTTOMRIGHT",UIParent,"BOTTOMRIGHT",0,0);
				else
					local Fnamexx =_G[kuangjF[i+1]]
					Fname:SetPoint("RIGHT",Fnamexx,"LEFT",4,0);
				end
			end
		end
	end
end
local likaijiezuFFF = CreateFrame("Frame")
local function yidongMenuBag()
	if PIG['PigUI']['MenuBag'] then
		shuaxin_MenuBag()
		fuFrame.MenuBag:SetChecked(true);
		likaijiezuFFF:RegisterEvent("UNIT_EXITED_VEHICLE");
		likaijiezuFFF:RegisterEvent("UNIT_EXITING_VEHICLE");
		--likaijiezuFFF:RegisterEvent("VEHICLE_UPDATE");
		likaijiezuFFF:RegisterEvent("STOP_MOVIE");
		likaijiezuFFF:RegisterEvent("CINEMATIC_STOP");
		likaijiezuFFF:HookScript("OnEvent", function(self,event,arg1)
			shuaxin_MenuBag()
		end);
		MainMenuBar:HookScript("OnShow", function()
			shuaxin_MenuBag()
		end);
	else
		fuFrame.MenuBag:SetChecked(false);
		likaijiezuFFF:UnregisterEvent("UNIT_EXITED_VEHICLE");
		likaijiezuFFF:UnregisterEvent("UNIT_EXITING_VEHICLE");
		--likaijiezuFFF:UnregisterEvent("VEHICLE_UPDATE");
		likaijiezuFFF:UnregisterEvent("STOP_MOVIE");
		likaijiezuFFF:UnregisterEvent("CINEMATIC_STOP");
	end
end
-- ---------------------
fuFrame.MenuBag = CreateFrame("CheckButton", nil, fuFrame, "ChatConfigCheckButtonTemplate");
fuFrame.MenuBag:SetSize(30,32);
fuFrame.MenuBag:SetHitRectInsets(0,-100,0,0);
fuFrame.MenuBag:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",20,-50);
fuFrame.MenuBag.Text:SetText("移动菜单背包到左下");
fuFrame.MenuBag.tooltip = "移动并重排菜单背包布局。(当WOW窗口小于1440时背包和菜单两行显示)";
fuFrame.MenuBag:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG['PigUI']['MenuBag']=true;
	else
		PIG['PigUI']['MenuBag']=false;
		Pig_Options_RLtishi_UI:Show()
	end
	yidongMenuBag()
end);
-- 动作条缩放比例
fuFrame.MenuBag_bili_T = fuFrame:CreateFontString();
fuFrame.MenuBag_bili_T:SetPoint("LEFT",fuFrame.MenuBag.Text,"RIGHT",6,-0);
fuFrame.MenuBag_bili_T:SetFont(ChatFontNormal:GetFont(), 14,"OUTLINE")
fuFrame.MenuBag_bili_T:SetTextColor(0, 1, 0, 1);
fuFrame.MenuBag_bili_T:SetText("菜单背包比例")
local MB_min,MB_max,MB_step = 0.6,1.4,0.1
fuFrame.MenuBag_bili_Slider = CreateFrame("Slider", nil, fuFrame, "OptionsSliderTemplate")
fuFrame.MenuBag_bili_Slider:SetSize(100,14)
fuFrame.MenuBag_bili_Slider:SetPoint("LEFT",fuFrame.MenuBag_bili_T,"RIGHT",6,0);
fuFrame.MenuBag_bili_Slider.tooltipText = '拖动滑块或者用鼠标滚轮调整菜单背包缩放比例';
fuFrame.MenuBag_bili_Slider:SetMinMaxValues(MB_min, MB_max);
fuFrame.MenuBag_bili_Slider:SetValueStep(MB_step);
fuFrame.MenuBag_bili_Slider:SetObeyStepOnDrag(true);
fuFrame.MenuBag_bili_Slider.Low:SetText(MB_min);
fuFrame.MenuBag_bili_Slider.High:SetText(MB_max);
fuFrame.MenuBag_bili_Slider:EnableMouseWheel(true);
fuFrame.MenuBag_bili_Slider:SetScript("OnMouseWheel", function(self, arg1)
	if fuFrame.MenuBag_bili_Slider:IsEnabled() then
		local sliderMin, sliderMax = self:GetMinMaxValues()
		local value = self:GetValue()
		local step = MB_step * arg1
		if step > 0 then
			self:SetValue(min(value + step, sliderMax))
		else
			self:SetValue(max(value + step, sliderMin))
		end
	end
end)
fuFrame.MenuBag_bili_Slider:SetScript('OnValueChanged', function(self)
	local Newval = floor(self:GetValue()*10+0.5)/10
	PIG['PigUI']['MenuBag_bili_value']=Newval;
	shuaxin_MenuBag()
end)

--动作条-------
local pianyiV,toppianyi = 34,6
local function StanceBar_yidong()
	StanceBarLeft:SetAlpha(0)
	StanceBarMiddle:SetAlpha(0)
	StanceBarRight:SetAlpha(0)
	if not InCombatLockdown() then
		if StanceBarFrame then---姿态条/变形条
			if SHOW_MULTI_ACTIONBAR_1 and SHOW_MULTI_ACTIONBAR_2 then
				StanceButton1:ClearAllPoints()
				StanceButton1:SetPoint("BOTTOMLEFT", MultiBarBottomRightButton1,"TOPLEFT", pianyiV, toppianyi)
			elseif SHOW_MULTI_ACTIONBAR_1 then
				StanceButton1:ClearAllPoints()
				StanceButton1:SetPoint("BOTTOMLEFT", MultiBarBottomLeftButton1,"TOPLEFT", pianyiV, toppianyi)
			else
				StanceButton1:ClearAllPoints()
				StanceButton1:SetPoint("BOTTOMLEFT", ActionButton1,"TOPLEFT", pianyiV, toppianyi)
			end
		end
	end
end
local function PetActionBar_yidong()
	if not InCombatLockdown() then
		if PetActionBarFrame then----宠物动作条
			if SHOW_MULTI_ACTIONBAR_1 and SHOW_MULTI_ACTIONBAR_2 then
				PetActionButton1:ClearAllPoints()
				PetActionButton1:SetPoint("BOTTOMLEFT", MultiBarBottomRightButton1,"TOPLEFT", pianyiV, toppianyi)
			elseif SHOW_MULTI_ACTIONBAR_1 then
				PetActionButton1:ClearAllPoints()
				PetActionButton1:SetPoint("BOTTOMLEFT", MultiBarBottomLeftButton1,"TOPLEFT", pianyiV, toppianyi)
			else
				PetActionButton1:ClearAllPoints()
				PetActionButton1:SetPoint("BOTTOMLEFT", ActionButton1,"TOPLEFT", pianyiV, toppianyi)
			end
		end
	end
end
--取消飞行
local function quxiaofeixing()
	if not InCombatLockdown() then
		if MainMenuBarVehicleLeaveButton then
			if SHOW_MULTI_ACTIONBAR_1 and SHOW_MULTI_ACTIONBAR_2 then
				MainMenuBarVehicleLeaveButton:ClearAllPoints()
				MainMenuBarVehicleLeaveButton:SetPoint("BOTTOMLEFT", MultiBarBottomRightButton1,"TOPLEFT",-4, toppianyi)
			elseif SHOW_MULTI_ACTIONBAR_1 then
				MainMenuBarVehicleLeaveButton:ClearAllPoints()
				MainMenuBarVehicleLeaveButton:SetPoint("BOTTOMLEFT", MultiBarBottomLeftButton1,"TOPLEFT", -4, toppianyi)
			else
				MainMenuBarVehicleLeaveButton:ClearAllPoints()
				MainMenuBarVehicleLeaveButton:SetPoint("BOTTOMLEFT", ActionButton1,"TOPLEFT", -4, toppianyi)
			end
		end
	end
end

local function ActionBar_bili_gengxin()
	local suofangbi =PIG['PigUI']['ActionBar_bili_value']
	StatusTrackingBarManager:SetScale(suofangbi/0.92)
	fuFrame.ActionBar_bili_Slider:SetValue(suofangbi);
	fuFrame.ActionBar_bili_Slider.Text:SetText(suofangbi);
	MainMenuBarArtFrame:SetScale(suofangbi)
	StanceBarFrame:SetScale(suofangbi);
	PetActionBarFrame:SetScale(suofangbi);
	VerticalMultiBarsContainer:SetScale(suofangbi);
	for i=1, 12 do
		_G["MultiBarLeftButton"..i]:SetScale(suofangbi)
	end
end
local function PigUI_layout()
	if PIG['PigUI']['ActionBar']=="ON" then
		ActionBar_bili_gengxin()
		fuFrame.ActionBar:SetChecked(true);
		PIG['PigUI']['Hide_shijiu']="ON";
		PIG['PigUI']['Hide_ActionBG']="ON";
		fuFrame.ActionBar_bili_Slider:Enable()
		fuFrame.ActionBar_bili_Slider.Low:SetTextColor(1, 1, 1, 1);
		fuFrame.ActionBar_bili_Slider.High:SetTextColor(1, 1, 1, 1);
		fuFrame.ActionBar_bili_Slider.Text:SetTextColor(1, 1, 1, 1);
		Hide_yingbiao()
		Hide_barBG()
		ActionBarUpButton:ClearAllPoints();
		ActionBarUpButton:SetPoint("RIGHT",ActionButton1,"LEFT",-2,10);
		MainMenuBarArtFrame.PageNumber:Hide();
		--ActionButton1:ClearAllPoints();
		ActionButton1:SetPoint("BOTTOMLEFT",MainMenuBarArtFrameBackground,"BOTTOMLEFT",-8,4);
		MultiBarBottomLeftButton1:ClearAllPoints();
		MultiBarBottomLeftButton1:SetPoint("BOTTOM",ActionButton1,"TOP",0,6);
		--下方右侧动作条
		MultiBarBottomRightButton1:ClearAllPoints();
		MultiBarBottomRightButton1:SetPoint("BOTTOM",MultiBarBottomLeftButton1,"TOP",0,6);
		MultiBarBottomRightButton7:ClearAllPoints();
		MultiBarBottomRightButton7:SetPoint("LEFT",MultiBarBottomRightButton6,"RIGHT",6,0);
		--右方右
		for i=1, 12 do
			_G["MultiBarRightButton"..i]:SetAttribute("flyoutDirection","UP");
			_G["MultiBarRightButton"..i]:ClearAllPoints();
			if i==1 then
				_G["MultiBarRightButton"..i]:SetPoint("LEFT",MultiBarBottomRightButton12,"RIGHT",10,0);
			elseif i==5 then
				_G["MultiBarRightButton"..i]:SetPoint("TOP",MultiBarRightButton1,"BOTTOM",0,-6);
			elseif i==9 then
				_G["MultiBarRightButton"..i]:SetPoint("TOP",MultiBarRightButton5,"BOTTOM",0,-6);
			else
				_G["MultiBarRightButton"..i]:SetPoint("LEFT",_G["MultiBarRightButton"..(i-1)],"RIGHT",6,0);
			end
		end
		for i=1, 12 do
			_G["MultiBarLeftButton"..i]:SetAttribute("flyoutDirection","UP");
			_G["MultiBarLeftButton"..i]:ClearAllPoints();
			if i==1 then
				_G["MultiBarLeftButton"..i]:SetPoint("LEFT",MultiBarRightButton4,"RIGHT",10,0);
			elseif i==5 then
				_G["MultiBarLeftButton"..i]:SetPoint("TOP",MultiBarLeftButton1,"BOTTOM",0,-6);
			elseif i==9 then
				_G["MultiBarLeftButton"..i]:SetPoint("TOP",MultiBarLeftButton5,"BOTTOM",0,-6);
			else
				_G["MultiBarLeftButton"..i]:SetPoint("LEFT",_G["MultiBarLeftButton"..(i-1)],"RIGHT",6,0);
			end
		end
		local function shuaxinsuoyouweizhi()
			StanceBar_yidong()
			PetActionBar_yidong()
			quxiaofeixing()
		end
		shuaxinsuoyouweizhi()
		--其他姿态/宠物动作条
		hooksecurefunc ("StanceBar_Update",function()
			shuaxinsuoyouweizhi()
		end);
		hooksecurefunc("PetActionBar_Update",function()
			shuaxinsuoyouweizhi()
		end);
		hooksecurefunc("MainMenuBarVehicleLeaveButton_Update",function()
			shuaxinsuoyouweizhi()
		end)
		hooksecurefunc("MultiActionBar_Update",function()
			shuaxinsuoyouweizhi()
		end);
	else
		fuFrame.ActionBar:SetChecked(false);
		fuFrame.ActionBar_bili_Slider:Disable()
		fuFrame.ActionBar_bili_Slider.Low:SetTextColor(0.3, 0.3, 0.3, 1);
		fuFrame.ActionBar_bili_Slider.High:SetTextColor(0.3, 0.3, 0.3, 1);
		fuFrame.ActionBar_bili_Slider.Text:SetTextColor(0.3, 0.3, 0.3, 1);
	end
end
-- ---------------------
fuFrame.ActionBar = CreateFrame("CheckButton", nil, fuFrame, "ChatConfigCheckButtonTemplate");
fuFrame.ActionBar:SetSize(30,32);
fuFrame.ActionBar:SetHitRectInsets(0,-100,0,0);
fuFrame.ActionBar:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",20,-100);
fuFrame.ActionBar.Text:SetText("移动右边动作条");
fuFrame.ActionBar.tooltip = "移动右边竖向动作条到下方动作条之上";
fuFrame.ActionBar:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG['PigUI']['ActionBar']="ON";
	else
		PIG['PigUI']['ActionBar']="OFF";
		Pig_Options_RLtishi_UI:Show()
	end
	PigUI_layout();
end);
-- 动作条缩放比例
fuFrame.ActionBar_bili_T = fuFrame:CreateFontString();
fuFrame.ActionBar_bili_T:SetPoint("LEFT",fuFrame.ActionBar.Text,"RIGHT",20,0);
fuFrame.ActionBar_bili_T:SetFont(ChatFontNormal:GetFont(), 14,"OUTLINE")
fuFrame.ActionBar_bili_T:SetTextColor(0, 1, 0, 1);
fuFrame.ActionBar_bili_T:SetText("动作条比例")
local S_min,S_max,S_step = 0.6,1.4,0.1
fuFrame.ActionBar_bili_Slider = CreateFrame("Slider", nil, fuFrame, "OptionsSliderTemplate")
fuFrame.ActionBar_bili_Slider:SetSize(100,14)
fuFrame.ActionBar_bili_Slider:SetPoint("LEFT",fuFrame.ActionBar_bili_T,"RIGHT",6,0);
fuFrame.ActionBar_bili_Slider.tooltipText = '拖动滑块或者用鼠标滚轮调整动作条缩放比例,注意此设置和系统的UI缩放不同，只调整动作条比例';
fuFrame.ActionBar_bili_Slider:SetMinMaxValues(S_min, S_max);
fuFrame.ActionBar_bili_Slider:SetValueStep(S_step);
fuFrame.ActionBar_bili_Slider:SetObeyStepOnDrag(true);
fuFrame.ActionBar_bili_Slider.Low:SetText(S_min);
fuFrame.ActionBar_bili_Slider.High:SetText(S_max);
fuFrame.ActionBar_bili_Slider:EnableMouseWheel(true);
fuFrame.ActionBar_bili_Slider:Disable();
fuFrame.ActionBar_bili_Slider.Low:SetTextColor(0.3, 0.3, 0.3, 1);
fuFrame.ActionBar_bili_Slider.High:SetTextColor(0.3, 0.3, 0.3, 1);
fuFrame.ActionBar_bili_Slider.Text:SetTextColor(0.3, 0.3, 0.3, 1);
fuFrame.ActionBar_bili_Slider:SetScript("OnMouseWheel", function(self, arg1)
	if fuFrame.ActionBar_bili_Slider:IsEnabled() then
		local sliderMin, sliderMax = self:GetMinMaxValues()
		local value = self:GetValue()
		local step = S_step * arg1
		if step > 0 then
			self:SetValue(min(value + step, sliderMax))
		else
			self:SetValue(max(value + step, sliderMin))
		end
	end
end)
fuFrame.ActionBar_bili_Slider:SetScript('OnValueChanged', function(self)
	local Newval = floor(self:GetValue()*10+0.5)/10
	PIG['PigUI']['ActionBar_bili_value']=Newval;
	ActionBar_bili_gengxin()
end)
----------------------------------------------
addonTable.PigUI_ActionBar = function()
	Hide_yingbiao();
	Hide_barBG()
	yidongMenuBag()
	PigUI_layout();
end