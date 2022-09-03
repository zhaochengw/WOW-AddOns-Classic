local _, addonTable = ...;
local fuFrame=List_R_F_1_6
local _, _, _, tocversion = GetBuildInfo()
-------------------------------------------------
----隐藏鹰标
local function PigUI_ShhijiuIcon()
	if PIG['PigUI']['ShhijiuIcon']=="ON" then
		fuFrame.HideShijiu:SetChecked(true);
		MainMenuBarRightEndCap:Hide();--隐藏右侧鹰标 
		MainMenuBarLeftEndCap:Hide();--隐藏左侧鹰标 
	elseif PIG['PigUI']['ShhijiuIcon']=="OFF" then
		fuFrame.HideShijiu:SetChecked(false);
		MainMenuBarRightEndCap:Show();--隐藏右侧鹰标 
		MainMenuBarLeftEndCap:Show();--隐藏左侧鹰标 
	end
end
fuFrame.HideShijiu = CreateFrame("CheckButton", nil, fuFrame, "ChatConfigCheckButtonTemplate");
fuFrame.HideShijiu:SetSize(30,32);
fuFrame.HideShijiu:SetHitRectInsets(0,-100,0,0);
fuFrame.HideShijiu:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",10,-10);
fuFrame.HideShijiu.Text:SetText("隐藏狮鹫图标");
fuFrame.HideShijiu.tooltip = "隐藏动作条两边的狮鹫图标。";
fuFrame.HideShijiu:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG['PigUI']['ShhijiuIcon']="ON";
	else
		PIG['PigUI']['ShhijiuIcon']="OFF";
	end
	PigUI_ShhijiuIcon()
end);
--===================================
--主动作条缩放比例
local function ActionBar_bili_gengxin()
	fuFrame.ActionBar_bili_Slider:SetValue(PIG['PigUI']['ActionBar_bili_value']*10);
	fuFrame.ActionBar_bili_Slider.Text:SetText(PIG['PigUI']['ActionBar_bili_value']);
	if PIG['PigUI']['ActionBar_bili']=="ON" then
		fuFrame.ActionBar_bili_Slider:Enable();
		fuFrame.ActionBar_bili_Slider.Low:SetTextColor(1, 1, 1, 1);
		fuFrame.ActionBar_bili_Slider.High:SetTextColor(1, 1, 1, 1);
		fuFrame.ActionBar_bili_Slider.Text:SetTextColor(1, 1, 1, 1);
		fuFrame.ActionBar_bili_ck:SetChecked(true);
		MainMenuBar:SetScale(PIG['PigUI']['ActionBar_bili_value']);
		VerticalMultiBarsContainer:SetScale(PIG['PigUI']['ActionBar_bili_value']);
		for i=1, 12 do
			_G["MultiBarLeftButton"..i]:SetScale(PIG['PigUI']['ActionBar_bili_value'])
			--_G["MultiBarRightButton"..i]:SetScale(PIG['PigUI']['ActionBar_bili_value'])
		end
	elseif PIG['PigUI']['ActionBar_bili']=="OFF" then
		fuFrame.ActionBar_bili_ck:SetChecked(false);
		fuFrame.ActionBar_bili_Slider:Disable();
		fuFrame.ActionBar_bili_Slider.Low:SetTextColor(0.8, 0.8, 0.8, 0.5);
		fuFrame.ActionBar_bili_Slider.High:SetTextColor(0.8, 0.8, 0.8, 0.5);
		fuFrame.ActionBar_bili_Slider.Text:SetTextColor(0.8, 0.8, 0.8, 0.5);
	end
end
fuFrame.ActionBar_bili_ck = CreateFrame("CheckButton", nil, fuFrame, "ChatConfigCheckButtonTemplate");
fuFrame.ActionBar_bili_ck:SetSize(30,32);
fuFrame.ActionBar_bili_ck:SetHitRectInsets(0,-80,0,0);
fuFrame.ActionBar_bili_ck:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",280,-50);
fuFrame.ActionBar_bili_ck.Text:SetText("缩放动作条:");
fuFrame.ActionBar_bili_ck.tooltip = "启用缩放动作条,注意此设置和系统高级里面的UI缩放不同，只调整动作条比例.";
fuFrame.ActionBar_bili_ck:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG['PigUI']['ActionBar_bili']="ON";	
	else
		PIG['PigUI']['ActionBar_bili']="OFF";
		Pig_Options_RLtishi_UI:Show()
	end
	ActionBar_bili_gengxin()
end);
-------
fuFrame.ActionBar_bili_Slider = CreateFrame("Slider", nil, fuFrame, "OptionsSliderTemplate")
fuFrame.ActionBar_bili_Slider:SetWidth(140)
fuFrame.ActionBar_bili_Slider:SetHeight(15)
fuFrame.ActionBar_bili_Slider:SetPoint("LEFT",fuFrame.ActionBar_bili_ck,"RIGHT",96,0);
fuFrame.ActionBar_bili_Slider:Show()
fuFrame.ActionBar_bili_Slider.tooltipText = '拖动滑块或者用鼠标滚轮调整动作条缩放比例,注意此设置和系统高级里面的UI缩放不同，只调整动作条比例';
fuFrame.ActionBar_bili_Slider:SetMinMaxValues(6, 14);
fuFrame.ActionBar_bili_Slider:SetValueStep(1);
fuFrame.ActionBar_bili_Slider:SetObeyStepOnDrag(true);
fuFrame.ActionBar_bili_Slider.Low:SetText('0.6');
fuFrame.ActionBar_bili_Slider.High:SetText('1.4');
--启用鼠标滚轮调整
fuFrame.ActionBar_bili_Slider:EnableMouseWheel(true);
fuFrame.ActionBar_bili_Slider:SetScript("OnMouseWheel", function(self, arg1)
	if fuFrame.ActionBar_bili_Slider:IsEnabled() then
		local step = 1 * arg1
		local value = self:GetValue()
		if step > 0 then
			self:SetValue(min(value + step, 14))
		else
			self:SetValue(max(value + step, 6))
		end
	end
end)
fuFrame.ActionBar_bili_Slider:SetScript('OnValueChanged', function(self)
	local Newval = (self:GetValue()/10)
	PIG['PigUI']['ActionBar_bili_value']=Newval;
	ActionBar_bili_gengxin()
end)
--==============================================
--动作条
local function StanceBar_yidong()
	if not InCombatLockdown()==true then
		if StanceBarFrame then---姿态条/变形条
			if SHOW_MULTI_ACTIONBAR_4 and SHOW_MULTI_ACTIONBAR_3 and SHOW_MULTI_ACTIONBAR_1 then
				StanceBarFrame:ClearAllPoints()
				StanceBarFrame:SetMovable(true)
				StanceBarFrame:SetPoint("BOTTOMLEFT", MultiBarLeftButton1,"TOPLEFT", 20, 2)
				StanceBarFrame:SetUserPlaced(true)
			else
				if SHOW_MULTI_ACTIONBAR_1 then
					StanceBarFrame:ClearAllPoints()
					StanceBarFrame:SetMovable(true)
					StanceBarFrame:SetPoint("BOTTOMLEFT", MultiBarBottomLeft,"TOPLEFT", 20, 1)
					StanceBarFrame:SetUserPlaced(true)
				else
					StanceBarFrame:ClearAllPoints()
					StanceBarFrame:SetMovable(true)
					if ReputationWatchBar and ReputationWatchBar:IsShown() then
						StanceBarFrame:SetPoint("BOTTOMLEFT", MainMenuBar,"TOPLEFT", 30, 9)
					else
						StanceBarFrame:SetPoint("BOTTOMLEFT", MainMenuBar,"TOPLEFT", 30, 0)
					end
					StanceBarFrame:SetUserPlaced(true)
				end
			end
		end
	end
end
local function PetActionBar_yidong()
	if not InCombatLockdown()==true then
		if PetActionBarFrame then----宠物动作条
			if SHOW_MULTI_ACTIONBAR_4 and SHOW_MULTI_ACTIONBAR_3 and SHOW_MULTI_ACTIONBAR_1 then
				PetActionBarFrame:ClearAllPoints()
				PetActionBarFrame:SetMovable(true)
				PetActionBarFrame:SetPoint("BOTTOMLEFT", MainMenuBar,"TOPLEFT", 30, 84)
				PetActionBarFrame:SetUserPlaced(true)
			else
				if SHOW_MULTI_ACTIONBAR_1 then
					PetActionBarFrame:ClearAllPoints()
					PetActionBarFrame:SetMovable(true)
					PetActionBarFrame:SetPoint("BOTTOMLEFT", MainMenuBar,"TOPLEFT", 30, 40)
					PetActionBarFrame:SetUserPlaced(true)
				else
					PetActionBarFrame:ClearAllPoints()
					PetActionBarFrame:SetMovable(true)
					PetActionBarFrame:SetPoint("BOTTOMLEFT", MainMenuBar,"TOPLEFT", 30, 0)
					PetActionBarFrame:SetUserPlaced(true)
				end
			end
		end
	end
end
local function PigUI_ActionBar_up()
	--竖动作栏-------
	for i=1, 12 do
		_G["MultiBarLeftButton"..i]:ClearAllPoints();
		_G["MultiBarLeftButton"..i]:SetPoint("BOTTOM",_G["MultiBarBottomLeftButton"..i],"TOP",0,6);
		_G["MultiBarRightButton"..i]:ClearAllPoints();
		_G["MultiBarRightButton"..i]:SetPoint("BOTTOM",_G["MultiBarBottomRightButton"..i],"TOP",0,6);
	end
	--其他姿态/宠物动作条
	hooksecurefunc ("StanceBar_Update",function()
		StanceBar_yidong()
	end);
	hooksecurefunc("PetActionBar_Update",function()
		PetActionBar_yidong()
	end);
	hooksecurefunc ("MultiActionBar_Update",function()
		StanceBar_yidong()
		PetActionBar_yidong()
	end);
end

---------------------
fuFrame.ActionBar = CreateFrame("CheckButton", nil, fuFrame, "ChatConfigCheckButtonTemplate");
fuFrame.ActionBar:SetSize(30,32);
fuFrame.ActionBar:SetHitRectInsets(0,-100,0,0);
fuFrame.ActionBar:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",10,-50);
fuFrame.ActionBar.Text:SetText("移动右边动作条");
fuFrame.ActionBar.tooltip = "移动右边竖向动作条到下方动作条之上。";
fuFrame.ActionBar:SetScript("OnClick", function ()
	if fuFrame.ActionBar:GetChecked() then
		PIG['PigUI']['ActionBar']="ON";
		PigUI_ActionBar_up();
		StanceBar_yidong()
		PetActionBar_yidong()
	else
		PIG['PigUI']['ActionBar']="OFF";
		Pig_Options_RLtishi_UI:Show()
	end
end);

----------------------------------------------
addonTable.PigUI_ActionBar = function()
	PigUI_ShhijiuIcon();
	if PIG['PigUI']['ActionBar']=="ON" then
		fuFrame.ActionBar:SetChecked(true);
		PigUI_ActionBar_up();
		StanceBar_yidong()
		PetActionBar_yidong()
	end
	ActionBar_bili_gengxin()
end