local _, addonTable = ...;
-----------------------------------
local fuFrame=Pig_Options_RF_TAB_3_UI
----------------------------------
local function CombatPlus_Zhuizong()
	if Zhuizong_UI==nil then
		local Width,Height = 33,33;

		local Zhuizong = CreateFrame("Frame", "Zhuizong_UI", UIParent);
		Zhuizong:SetSize(Width,Height);
		Zhuizong:SetPoint("TOPLEFT", Minimap, "TOPLEFT", -25, -20);

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

		Zhuizong.xiala = CreateFrame("Frame", nil, Zhuizong, "UIDropDownMenuTemplate")
		Zhuizong.xiala:SetPoint("TOP", Zhuizong.Button_UI, "BOTTOM")
		Zhuizong.Button = CreateFrame("Button", nil, Zhuizong, "SecureHandlerClickTemplate");
		Zhuizong.Button:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight");
		Zhuizong.Button:SetSize(Width*1.14,Height*1.14);
		Zhuizong.Button:SetPoint("TOPLEFT", Zhuizong, "TOPLEFT", 0, 0);
		Zhuizong.Button:RegisterForClicks("LeftButtonUp","RightButtonUp");
		Zhuizong.Button:SetScript("OnClick", function (self, event)
			if event=="LeftButton" then
				local menu ={}
				local spells ={1494,19883,19884,19885,19880,19878,19882,19879,5225,5500,5502,2383,2580,2481}
				YOUxuexi=nil;
				local Bufficon = GetTrackingTexture()
				for key,spellId in ipairs(spells) do
					local spellName = GetSpellInfo(spellId)
					if IsPlayerSpell(spellId) then
						local icon = GetSpellTexture(spellId)
						if Bufficon==icon then
							xuanzhongzhi=true
						else
							xuanzhongzhi=false
						end
						YOUxuexi=true;
						table.insert(menu,
						{
							text = spellName,
							value = spellId,
							icon = GetSpellTexture(spellId),
							checked = xuanzhongzhi,
							func = function()
								CastSpellByID(spellId)
							end,
						})
					end
				end
				if YOUxuexi==nil then
					table.insert(menu,{text = "还未学习追踪技能！", isTitle = true,}) 
				end
				EasyMenu(menu, Zhuizong.xiala, Zhuizong.Button, -70 , 0, "MENU");
				DropDownList1:SetScale(1);
			end
			if event=="RightButton" then
				CancelTrackingBuff();
				Zhuizong.Border:Show()
				Zhuizong.Border_Se:Show()
			end
		end)
		if YOUxuexi==nil then
			Zhuizong.Border:Show()
			Zhuizong.Border_Se:Show()
		end
	end
end
----------
local _, _, _, tocversion = GetBuildInfo()
fuFrame.Zhuizong = CreateFrame("CheckButton", nil, fuFrame, "ChatConfigCheckButtonTemplate");
fuFrame.Zhuizong:SetSize(30,32);
fuFrame.Zhuizong:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",20,-140);
fuFrame.Zhuizong.Text:SetText("追踪技能整合(60)");
if tocversion>19999 then fuFrame.Zhuizong:Disable() fuFrame.Zhuizong.Text:SetTextColor(0.4, 0.4, 0.4, 1); end
fuFrame.Zhuizong.tooltip = "把追踪类技能整合到一起，左键点击小地图追踪技能按钮选择其他追踪技能！";
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
		if tocversion<20000 then
			CombatPlus_Zhuizong()
		end
	end
end