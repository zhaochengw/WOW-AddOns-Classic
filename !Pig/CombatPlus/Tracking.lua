local _, addonTable = ...;
-----------------------------------
local fuFrame=List_R_F_1_3
local PIGDownMenu=addonTable.PIGDownMenu
local ADD_Checkbutton=addonTable.ADD_Checkbutton
local _, _, _, tocversion = GetBuildInfo()
----------------------------------
local function CombatPlus_Zhuizong()
	if Zhuizong_UI then return end

	local Width,Height = 33,33;

	local Zhuizong = CreateFrame("Frame", "Zhuizong_UI", UIParent);
	Zhuizong:SetSize(Width,Height);
	Zhuizong:SetPoint("TOPLEFT", Minimap, "TOPLEFT", -15, 0);

	Zhuizong.Border_Se = Zhuizong:CreateTexture(nil, "BORDER");
	Zhuizong.Border_Se:SetTexture("interface/common/ui-searchbox-icon.blp");
	Zhuizong.Border_Se:SetSize(Width*0.6,Height*0.6);
	Zhuizong.Border_Se:SetPoint("CENTER",Zhuizong,"CENTER",3,-3);
	Zhuizong.Border_Se:Hide()

	Zhuizong.Border = Zhuizong:CreateTexture(nil, "BORDER");
	Zhuizong.Border:SetTexture("Interface/Minimap/MiniMap-TrackingBorder");
	Zhuizong.Border:SetPoint("TOPLEFT",Zhuizong,"TOPLEFT",0,0);
	Zhuizong.Border:Hide()
	
	Zhuizong:RegisterEvent("PLAYER_ENTERING_WORLD");
	Zhuizong:RegisterEvent("SPELL_UPDATE_COOLDOWN");
	Zhuizong:SetScript("OnEvent", function ()
		if GetTrackingTexture() then
			MiniMapTrackingFrame:Show()
			MiniMapTrackingIcon:SetTexture(GetTrackingTexture())
			Zhuizong.Border:Hide()
			Zhuizong.Border_Se:Hide()
		else
			Zhuizong.Border:Show()
			Zhuizong.Border_Se:Show()
		end
	end)
	Zhuizong.xiala=PIGDownMenu(nil,{wwgg,hhgg},Zhuizong,{"TOPLEFT",Zhuizong, "CENTER", -80,-10},"EasyMenu")
	Zhuizong.xiala.Button:HookScript("OnClick", function(self, button)
		if button=="LeftButton" then
		else
			CancelTrackingBuff();
			Zhuizong.Border:Show()
			Zhuizong.Border_Se:Show()
		end
	end)
	function Zhuizong.xiala:PIGDownMenu_Update_But(self, level, menuList)
		local spells ={1494,19883,19884,19885,19880,19878,19882,19879,5225,5500,5502,2383,2580,2481}
		local info = {}
		local Bufficon = GetTrackingTexture()
		for i=1,#spells,1 do
			if IsPlayerSpell(spells[i]) then
				local spellName = GetSpellInfo(spells[i])
			    info.text, info.arg1 = spellName, spells[i]
			    info.icon = GetSpellTexture(spells[i])
			    if Bufficon==info.icon then
					info.checked = true
				else
					info.checked = false
				end
				info.func = function()
					CastSpellByID(spells[i])
					PIGCloseDropDownMenus()
				end
				Zhuizong.xiala:PIGDownMenu_AddButton(info)
			end
		end 
	end
end
----------
local tooltip = "把追踪类技能整合到一起，左键点击小地图追踪技能按钮选择其他追踪技能！";
fuFrame.Zhuizong = ADD_Checkbutton(nil,fuFrame,-100,"TOPLEFT",fuFrame,"TOPLEFT",20,-140,"追踪技能整合(60)",tooltip)
if tocversion>19999 then fuFrame.Zhuizong:Disable() fuFrame.Zhuizong.Text:SetTextColor(0.4, 0.4, 0.4, 1); end
fuFrame.Zhuizong:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG['CombatPlus']['Zhuizong']="ON";
		CombatPlus_Zhuizong()
	else
		PIG['CombatPlus']['Zhuizong']="OFF";
		Pig_Options_RLtishi_UI:Show()
	end
end);
addonTable.CombatPlus_Zhuizong = function()
	if PIG['CombatPlus']['Zhuizong']=="ON" then
		fuFrame.Zhuizong:SetChecked(true);
		if fuFrame.Zhuizong:IsEnabled() then
			CombatPlus_Zhuizong()
		end
	end
end