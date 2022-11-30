local _, addonTable = ...;
local fuFrame=List_R_F_1_3
local _, _, _, tocversion = GetBuildInfo()
local ADD_Checkbutton=addonTable.ADD_Checkbutton
--///动作条按键范围着色/////////////
local function CombatPlus_ActionBar_Ranse_Open()
	if fuFrame.Ranse:IsEnabled() then
		if tocversion<40000 then
			hooksecurefunc("ActionButton_OnUpdate", function(self, elapsed)
				if self.rangeTimer == TOOLTIP_UPDATE_TIME and self.action then
					local range = false
					if IsActionInRange(self.action) == false then 
						_G[self:GetName().."Icon"]:SetVertexColor(0.5, 0.1, 0.1)
						range = true
					end;
					if self.range ~= range and range == false then
						ActionButton_UpdateUsable(self)
					end;
					self.range = range
				end
			end)
		else
			hooksecurefunc("ActionButton_UpdateRangeIndicator", function(self, checksRange, inRange)
				if self.action == nil then return end
				local isUsable, notEnoughMana = IsUsableAction(self.action)
				if ( checksRange and not inRange ) then
					_G[self:GetName().."Icon"]:SetVertexColor(0.5, 0.1, 0.1)
				elseif isUsable ~= true or notEnoughMana == true then
					_G[self:GetName().."Icon"]:SetVertexColor(0.4, 0.4, 0.4)
				else
					_G[self:GetName().."Icon"]:SetVertexColor(1, 1, 1)
				end
			end)
		end
	end
end
---------------------
fuFrame.Ranse = ADD_Checkbutton(nil,fuFrame,-100,"TOPLEFT",fuFrame,"TOPLEFT",20,-20,"动作条按键范围着色","根据技能范围染色动作条按键颜色")
fuFrame.Ranse:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG['CombatPlus']['ActionBar_Ranse']="ON";
		CombatPlus_ActionBar_Ranse_Open();
	else
		PIG['CombatPlus']['ActionBar_Ranse']="OFF";
		Pig_Options_RLtishi_UI:Show()
	end
end);

--=====================================
addonTable.CombatPlus_ActionBar_Ranse = function()
	if PIG['CombatPlus']['ActionBar_Ranse']=="ON" then
		fuFrame.Ranse:SetChecked(true);
		if tocversion>39999 then
            fuFrame.Cailiao:Disable() fuFrame.Cailiao.Text:SetTextColor(0.4, 0.4, 0.4, 1)
        end
		CombatPlus_ActionBar_Ranse_Open();
	end
end