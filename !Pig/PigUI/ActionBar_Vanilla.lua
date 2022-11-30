local _, addonTable = ...;
local fuFrame=List_R_F_1_6
local _, _, _, tocversion = GetBuildInfo()
local ADD_Checkbutton=addonTable.ADD_Checkbutton
-------------------------------------------------
----隐藏鹰标
local function PigUI_ShhijiuIcon()
	if PIG["PigUI"]["Hide_shijiu"]=="ON" then
		fuFrame.HideShijiu:SetChecked(true);
		MainMenuBarRightEndCap:Hide();--隐藏右侧鹰标 
		MainMenuBarLeftEndCap:Hide();--隐藏左侧鹰标 
	elseif PIG["PigUI"]["Hide_shijiu"]=="OFF" then
		fuFrame.HideShijiu:SetChecked(false);
		MainMenuBarRightEndCap:Show();
		MainMenuBarLeftEndCap:Show();
	end
end
fuFrame.HideShijiu = ADD_Checkbutton(nil,fuFrame,-80,"TOPLEFT",fuFrame,"TOPLEFT",10,-10,"隐藏狮鹫图标","隐藏动作条两边的狮鹫图标")
fuFrame.HideShijiu:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG["PigUI"]["Hide_shijiu"]="ON";
	else
		PIG["PigUI"]["Hide_shijiu"]="OFF";
	end
	PigUI_ShhijiuIcon()
end);
--===================================
--主动作条缩放比例
local function ActionBar_bili_gengxin()
	fuFrame.ActionBar_bili_Slider:SetValue(PIG["PigUI"]["ActionBar_bili_value"]*10);
	fuFrame.ActionBar_bili_Slider.Text:SetText(PIG["PigUI"]["ActionBar_bili_value"]);
	if PIG["PigUI"]["ActionBar_bili"]=="ON" then
		fuFrame.ActionBar_bili_Slider:Enable();
		fuFrame.ActionBar_bili_Slider.Low:SetTextColor(1, 1, 1, 1);
		fuFrame.ActionBar_bili_Slider.High:SetTextColor(1, 1, 1, 1);
		fuFrame.ActionBar_bili_Slider.Text:SetTextColor(1, 1, 1, 1);
		fuFrame.ActionBar_bili_ck:SetChecked(true);
		MainMenuBar:SetScale(PIG["PigUI"]["ActionBar_bili_value"]);
		VerticalMultiBarsContainer:SetScale(PIG["PigUI"]["ActionBar_bili_value"]);
		for i=1, 12 do
			_G["MultiBarLeftButton"..i]:SetScale(PIG["PigUI"]["ActionBar_bili_value"])
			--_G["MultiBarRightButton"..i]:SetScale(PIG["PigUI"]["ActionBar_bili_value"])
		end
	elseif PIG["PigUI"]["ActionBar_bili"]=="OFF" then
		fuFrame.ActionBar_bili_ck:SetChecked(false);
		fuFrame.ActionBar_bili_Slider:Disable();
		fuFrame.ActionBar_bili_Slider.Low:SetTextColor(0.8, 0.8, 0.8, 0.5);
		fuFrame.ActionBar_bili_Slider.High:SetTextColor(0.8, 0.8, 0.8, 0.5);
		fuFrame.ActionBar_bili_Slider.Text:SetTextColor(0.8, 0.8, 0.8, 0.5);
	end
end
fuFrame.ActionBar_bili_ck = ADD_Checkbutton(nil,fuFrame,-80,"TOPLEFT",fuFrame,"TOPLEFT",280,-50,"缩放动作条","启用缩放动作条,注意此设置和系统高级里面的UI缩放不同，只调整动作条比例")
fuFrame.ActionBar_bili_ck:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG["PigUI"]["ActionBar_bili"]="ON";	
	else
		PIG["PigUI"]["ActionBar_bili"]="OFF";
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
	PIG["PigUI"]["ActionBar_bili_value"]=Newval;
	ActionBar_bili_gengxin()
end)
--==============================================
--竖动作栏-------
if not IsXPUserDisabled then
	function IsXPUserDisabled() return false end
end
local function GetExpWatched()
	local name, reaction, min, max, value, factionID = GetWatchedFactionInfo();
	local newLevel = UnitLevel("player");
	local showXP = newLevel < GetMaxPlayerLevel() and not IsXPUserDisabled();
	if name then
		return showXP,true
	else
		return showXP,false
	end
end
local function PigUI_ActionBar_up()
	local function Pig_MultiBar_Update()
		if not InCombatLockdown() then
			for i=1, 12 do
				_G["MultiBarLeftButton"..i]:ClearAllPoints();
				_G["MultiBarLeftButton"..i]:SetPoint("BOTTOM",_G["MultiBarBottomLeftButton"..i],"TOP",0,6);
				_G["MultiBarRightButton"..i]:ClearAllPoints();
				_G["MultiBarRightButton"..i]:SetPoint("BOTTOM",_G["MultiBarBottomRightButton"..i],"TOP",0,6);
			end
			VerticalMultiBarsContainer:SetSize(0, 0);
		end
	end
	Pig_MultiBar_Update()

	local function StanceBar_Update(self)
		if self:IsShown() then
			if SHOW_MULTI_ACTIONBAR_1 or SHOW_MULTI_ACTIONBAR_2 or SHOW_MULTI_ACTIONBAR_3 or SHOW_MULTI_ACTIONBAR_4 then		
				if SHOW_MULTI_ACTIONBAR_4 and SHOW_MULTI_ACTIONBAR_3 and SHOW_MULTI_ACTIONBAR_1 then
					if not self:IsUserPlaced() then
						if InCombatLockdown() then
							self:RegisterEvent("PLAYER_REGEN_ENABLED");
							PIG_print("部分移动会在战斗结束后执行")
						else
							local point, relativeTo, relativePoint, xOfs, yOfs = self:GetPoint()
							self:SetMovable(true)
							self:SetPoint("BOTTOMLEFT", self:GetParent(),"TOPLEFT", xOfs, yOfs+42)
							self:SetUserPlaced(true)
						end 
					end
				else
					self:SetMovable(true)
					self:SetUserPlaced(false)
					self:SetMovable(false)
				end
			end
		end
	end
	StanceBar_Update(StanceBarFrame)
	StanceBarFrame:HookScript("OnEvent", function (self,event)
		if event=="PLAYER_REGEN_ENABLED" then
			if SHOW_MULTI_ACTIONBAR_4 and SHOW_MULTI_ACTIONBAR_3 and SHOW_MULTI_ACTIONBAR_1 then
				if not self:IsUserPlaced() then
					local point, relativeTo, relativePoint, xOfs, yOfs = self:GetPoint()
					self:SetMovable(true)
					self:SetPoint("BOTTOMLEFT", self:GetParent(),"TOPLEFT", xOfs, yOfs+42)
					self:SetUserPlaced(true)
				end
			end
			self:UnregisterEvent("PLAYER_REGEN_ENABLED");
		end
	end);
	
	-- hooksecurefunc("UIParent_ManageFramePositions",function()

	-- end);
	-- hooksecurefunc("UIParent_UpdateTopFramePositions",function()

	-- end);
	local function PetBar_Update(self)
		if self:IsShown() then
			if InCombatLockdown() then return end
			if SHOW_MULTI_ACTIONBAR_1 or SHOW_MULTI_ACTIONBAR_2 or SHOW_MULTI_ACTIONBAR_3 or SHOW_MULTI_ACTIONBAR_4 then
				local showXP,showRep = GetExpWatched()
				self:SetMovable(true)
				if SHOW_MULTI_ACTIONBAR_4 and SHOW_MULTI_ACTIONBAR_3 and SHOW_MULTI_ACTIONBAR_1 then
					if showXP and showRep then
						self:SetPoint("BOTTOMLEFT", self:GetParent(),"TOPLEFT", PETACTIONBAR_XPOS, 96)
					elseif showXP or showRep then
						self:SetPoint("BOTTOMLEFT", self:GetParent(),"TOPLEFT", PETACTIONBAR_XPOS, 86)
					else
						self:SetPoint("BOTTOMLEFT", self:GetParent(),"TOPLEFT", PETACTIONBAR_XPOS, 84)
					end	
				else
					if SHOW_MULTI_ACTIONBAR_1 then
						if showXP and showRep then
							self:SetPoint("BOTTOMLEFT", self:GetParent(),"TOPLEFT", PETACTIONBAR_XPOS, 54)
						elseif showXP or showRep then
							self:SetPoint("BOTTOMLEFT", self:GetParent(),"TOPLEFT", PETACTIONBAR_XPOS, 45)
						else
							self:SetPoint("BOTTOMLEFT", self:GetParent(),"TOPLEFT", PETACTIONBAR_XPOS, 42)
						end
					else
						if showXP and showRep then
							self:SetPoint("BOTTOMLEFT", self:GetParent(),"TOPLEFT", PETACTIONBAR_XPOS, 12)
						elseif showXP or showRep then
							self:SetPoint("BOTTOMLEFT", self:GetParent(),"TOPLEFT", PETACTIONBAR_XPOS, 4)
						else
							self:SetPoint("BOTTOMLEFT", self:GetParent(),"TOPLEFT", PETACTIONBAR_XPOS, 0)
						end
					end
				end
				self:SetUserPlaced(true)
			end
		end
	end

	hooksecurefunc("MainMenuBar_UpdateExperienceBars",function(newLevel)
		StanceBar_Update(StanceBarFrame)
		PetBar_Update(PetActionBarFrame)
	end);
	hooksecurefunc("MultiActionBar_Update",function()	
		Pig_MultiBar_Update()
		StanceBar_Update(StanceBarFrame)
		PetBar_Update(PetActionBarFrame)
	end);
end
---------------------
fuFrame.ActionBar = ADD_Checkbutton(nil,fuFrame,-80,"TOPLEFT",fuFrame,"TOPLEFT",10,-50,"移动右边动作条","移动右边竖向动作条到下方动作条之上")
fuFrame.ActionBar:SetScript("OnClick", function ()
	if fuFrame.ActionBar:GetChecked() then
		PIG["PigUI"]["ActionBar"]="ON";
		PigUI_ActionBar_up();
	else
		PIG["PigUI"]["ActionBar"]="OFF";
		Pig_Options_RLtishi_UI:Show()
	end
end);
----
fuFrame:HookScript("OnShow", function ()
	if PIG["PigUI"]["ActionBar"]=="ON" then
		fuFrame.ActionBar:SetChecked(true);
	end
end);
----------------------------------------------
addonTable.PigUI_ActionBar = function()
	PigUI_ShhijiuIcon();
	ActionBar_bili_gengxin()
	if PIG["PigUI"]["ActionBar"]=="ON" then
		PigUI_ActionBar_up();
	end
end