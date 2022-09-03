
--option panel
CritSound_OptionsFrame = CreateFrame("Frame", "CritSound_OptionsFrame", UIParent);
CritSound_OptionsFrame.name = "CritSound";
InterfaceOptions_AddCategory(CritSound_OptionsFrame);
CritSound_OptionsFrame:SetScript("OnShow", function()
	CritSound_OptionPanel_OnShow();
end)

local CritSoundModeDropDown = {CRITSOUND_SINGLE, CRITSOUND_SEQUENCE, CRITSOUND_RANDOM};

local function CritSoundMode_OnClick(self)
	UIDropDownMenu_SetSelectedID(CritSound_CritSoundModeDropDown, self:GetID());
	CritSoundMode = self:GetID();
	if CritSoundMode == 2 then
		BlizzardOptionsPanel_Slider_Enable(CritSound_AgingTimeSlider);
		CritSound_AgingTimeSliderText:SetTextColor(1, 1, 1);
	else
		BlizzardOptionsPanel_Slider_Disable(CritSound_AgingTimeSlider);
	end
end

local function CritSoundMode_Init()
	local i, info, text, func;
	for i = 1, 3 do
		info = {
			text = CritSoundModeDropDown[i];
			func = CritSoundMode_OnClick;
		};
		UIDropDownMenu_AddButton(info);
	end
end

do
	local critsoundtitletext, critsoundmodetext, critsoundmoduletext, critsoundblacklisttext;

	critsoundtitletext = CritSound_OptionsFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
	critsoundtitletext:SetPoint("TOPLEFT", 16, -16);
	critsoundtitletext:SetText(CRITSOUND_TITLE);

	critsoundmodetext = CritSound_OptionsFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
	critsoundmodetext:SetPoint("TOPLEFT", critsoundtitletext, "TOPLEFT", 0, -40);
	critsoundmodetext:SetText(CRITSOUND_MODE);

	CreateFrame("CheckButton", "CritSound_CritSoundModeDropDown", CritSound_OptionsFrame, "UIDropDownMenuTemplate");
	CritSound_CritSoundModeDropDown:SetPoint("TOPLEFT", critsoundmodetext, "TOPLEFT", 0, -30);
	CritSound_CritSoundModeDropDown:SetHitRectInsets(0, 0, 0, 0);
	UIDropDownMenu_SetWidth(CritSound_CritSoundModeDropDown, 100);
	UIDropDownMenu_Initialize(CritSound_CritSoundModeDropDown, CritSoundMode_Init);
	UIDropDownMenu_SetSelectedID(CritSound_CritSoundModeDropDown, CritSoundMode);

	CreateFrame("Slider", "CritSound_AgingTimeSlider", CritSound_OptionsFrame, "OptionsSliderTemplate");
	CritSound_AgingTimeSlider:SetWidth(120);
	CritSound_AgingTimeSlider:SetHeight(16);
	CritSound_AgingTimeSlider:SetPoint("TOPLEFT", CritSound_CritSoundModeDropDown, "TOPLEFT", 170, -6);
	CritSound_AgingTimeSliderText:SetText(CRITSOUND_AGING..CritSoundAgingTime);
	CritSound_AgingTimeSliderLow:SetText("1");
	CritSound_AgingTimeSliderHigh:SetText("60");
	CritSound_AgingTimeSlider:SetMinMaxValues(1, 60);
	CritSound_AgingTimeSlider:SetValueStep(1);
	CritSound_AgingTimeSlider:SetScript("OnValueChanged", function(self, value)
		CritSoundAgingTime = value;
		CritSound_AgingTimeSliderText:SetText(CRITSOUND_AGING..CritSoundAgingTime);
	end)

	critsoundmoduletext = CritSound_OptionsFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
	critsoundmoduletext:SetPoint("TOPLEFT", CritSound_CritSoundModeDropDown, "TOPLEFT", 0, -50);
	critsoundmoduletext:SetText(CRITSOUND_ACTIVE);

	CreateFrame("CheckButton", "CritSound_Spell", CritSound_OptionsFrame, "InterfaceOptionsCheckButtonTemplate");
	CritSound_Spell:SetPoint("TOPLEFT", critsoundmoduletext, "TOPLEFT", 16, -30);
	CritSound_Spell:SetHitRectInsets(0, -100, 0, 0);
	CritSound_SpellText:SetText(CRITSOUND_SPELL);
	CritSound_Spell:SetScript("OnClick", function(self)
		CritSoundSwitch["spell"] = 1 - CritSoundSwitch["spell"];
		self:SetChecked(CritSoundSwitch["spell"]==1);
	end)

	CreateFrame("CheckButton", "CritSound_Shield", CritSound_OptionsFrame, "InterfaceOptionsCheckButtonTemplate");
	CritSound_Shield:SetPoint("TOPLEFT", CritSound_Spell, "TOPLEFT", 0, -30);
	CritSound_Shield:SetHitRectInsets(0, -100, 0, 0);
	CritSound_ShieldText:SetText(CRITSOUND_SHIELD);
	CritSound_Shield:SetScript("OnClick", function(self)
		CritSoundSwitch["shield"] = 1 - CritSoundSwitch["shield"];
		self:SetChecked(CritSoundSwitch["shield"]==1);
	end)

	CreateFrame("CheckButton", "CritSound_Swing", CritSound_OptionsFrame, "InterfaceOptionsCheckButtonTemplate");
	CritSound_Swing:SetPoint("TOPLEFT", CritSound_Shield, "TOPLEFT", 0, -30);
	CritSound_Swing:SetHitRectInsets(0, -100, 0, 0);
	CritSound_SwingText:SetText(CRITSOUND_SWING);
	CritSound_Swing:SetScript("OnClick", function(self)
		CritSoundSwitch["swing"] = 1 - CritSoundSwitch["swing"];
		self:SetChecked(CritSoundSwitch["swing"]==1);
	end)

	CreateFrame("CheckButton", "CritSound_Range", CritSound_OptionsFrame, "InterfaceOptionsCheckButtonTemplate");
	CritSound_Range:SetPoint("TOPLEFT", CritSound_Swing, "TOPLEFT", 0, -30);
	CritSound_Range:SetHitRectInsets(0, -100, 0, 0);
	CritSound_RangeText:SetText(CRITSOUND_RANGE);
	CritSound_Range:SetScript("OnClick", function(self)
		CritSoundSwitch["range"] = 1 - CritSoundSwitch["range"];
		self:SetChecked(CritSoundSwitch["range"]==1);
	end)

	CreateFrame("CheckButton", "CritSound_Heal", CritSound_OptionsFrame, "InterfaceOptionsCheckButtonTemplate");
	CritSound_Heal:SetPoint("TOPLEFT", CritSound_Range, "TOPLEFT", 0, -30);
	CritSound_Heal:SetHitRectInsets(0, -100, 0, 0);
	CritSound_HealText:SetText(CRITSOUND_HEAL);
	CritSound_Heal:SetScript("OnClick", function(self)
		CritSoundSwitch["heal"] = 1 - CritSoundSwitch["heal"];
		self:SetChecked(CritSoundSwitch["heal"]==1);
	end)

	critsoundblacklisttext = CritSound_OptionsFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
	critsoundblacklisttext:SetPoint("TOPLEFT", CritSound_Heal, "TOPLEFT", -16, -50);
	critsoundblacklisttext:SetText(CRITSOUND_BLACKLIST);

	critsoundblacklistaddtext = CritSound_OptionsFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
	critsoundblacklistaddtext:SetPoint("TOPLEFT", critsoundblacklisttext, "TOPLEFT", 16, -30);
	critsoundblacklistaddtext:SetText(CRITSOUND_ADDSPELL);

	CreateFrame("EditBox", "CritSound_BlacklistAdd", CritSound_OptionsFrame, "InputBoxTemplate");
	CritSound_BlacklistAdd:SetPoint("TOPLEFT", critsoundblacklistaddtext, "TOPLEFT", 0, -16);
	CritSound_BlacklistAdd:SetWidth(150);
	CritSound_BlacklistAdd:SetHeight(25);
	CritSound_BlacklistAdd:SetAutoFocus(false)
	CritSound_BlacklistAdd:ClearFocus()
	CritSound_BlacklistAdd:SetScript("OnEnterPressed", function()
		local spellname = CritSound_BlacklistAdd:GetText();
		if spellname ~= "" and type(tonumber(spellname)) ~= "number" then
			local _, _, enable = GetSpellCooldown(spellname);
			if enable ~= nil then
				local unitexist = CritSound_BlackListCheck(spellname);
				if unitexist == false then
					table.insert(CritSoundBlackList, spellname);
					print("|cFFFFFF99\"|R|cFFFF0000"..spellname.."|R|cFFFFFF99\" "..CRITSOUND_ADDINFO.."|R");
				else
					print("|cFFFFFF99\"|R|cFFFF0000"..spellname.."|R|cFFFFFF99\" "..CRITSOUND_ADDFALSE.."|R");
				end
				CritSound_BlacklistAdd:SetText("")
			else
				print("|cFFFFFF99"..CRITSOUND_BADNAME.."|R|cFFFF0000"..spellname.."|R");
			end
		else
			print("|cFFFFFF99"..CRITSOUND_BADNAME.."|R|cFFFF0000"..spellname.."|R");
		end
		CritSound_BlacklistAdd:ClearFocus()
	end)
	CritSound_BlacklistAdd:SetScript("OnEscapePressed", function()
		CritSound_BlacklistAdd:SetText("")
		CritSound_BlacklistAdd:ClearFocus()
	end)
	CritSound_BlacklistAdd:SetScript("OnEnter",function(self)
		GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", -6, 18);
		GameTooltip:AddLine(CRITSOUND_ADDTIP);
		GameTooltip:Show();
	end);
	CritSound_BlacklistAdd:SetScript("OnLeave",function()
		GameTooltip:Hide();
	end);

	CreateFrame("Button", "CritSound_BlacklistShow", CritSound_OptionsFrame, "OptionsButtonTemplate");
	CritSound_BlacklistShow:SetPoint("TOPLEFT", CritSound_BlacklistAdd, "TOPLEFT", 160, 0);
	CritSound_BlacklistShow:SetWidth(100)
	CritSound_BlacklistShow:SetHeight(25)
	CritSound_BlacklistShowText:SetText(CRITSOUND_SHOWALL);
	CritSound_BlacklistShow:SetScript("OnClick", function(self)
		print("|cFFFFFF99"..CRITSOUND_BLACKLIST.."|R")
		local id;
		for id in pairs(CritSoundBlackList) do
			print(CritSoundBlackList[id])
		end
	end)

	critsoundblacklistremtext = CritSound_OptionsFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
	critsoundblacklistremtext:SetPoint("TOPLEFT", CritSound_BlacklistAdd, "TOPLEFT", 0, -35);
	critsoundblacklistremtext:SetText(CRITSOUND_REMSPELL);

	CreateFrame("EditBox", "CritSound_BlacklistRem", CritSound_OptionsFrame, "InputBoxTemplate");
	CritSound_BlacklistRem:SetPoint("TOPLEFT", critsoundblacklistremtext, "TOPLEFT", 0, -16);
	CritSound_BlacklistRem:SetWidth(150);
	CritSound_BlacklistRem:SetHeight(25);
	CritSound_BlacklistRem:SetAutoFocus(false)
	CritSound_BlacklistRem:ClearFocus()
	CritSound_BlacklistRem:SetScript("OnEnterPressed", function()
		local spellname = CritSound_BlacklistRem:GetText();
		if spellname ~= "" and type(tonumber(spellname)) ~= "number" then
			local _, _, enable = GetSpellCooldown(spellname);
			if enable ~= nil then
				local id;
				local unitexist = false;
				local len = table.getn(CritSoundBlackList);
				for id = 1, len, 1 do
					if CritSoundBlackList[id] == spellname then
						unitexist = true;
						if CritSoundBlackList[id+1] then
							CritSoundBlackList[id] = CritSoundBlackList[id+1];
						else
							CritSoundBlackList[id] = nil;
						end
						print("|cFFFFFF99\"|R|cFFFF0000"..spellname.."|R|cFFFFFF99\" "..CRITSOUND_REMINFO.."|R");
					else
						if unitexist == true then
							if CritSoundBlackList[id+1] then
								CritSoundBlackList[id] = CritSoundBlackList[id+1];
							else
								CritSoundBlackList[id] = nil;
							end
						end
					end
				end
				if unitexist == false then
					print("|cFFFFFF99\"|R|cFFFF0000"..spellname.."|R|cFFFFFF99\" "..CRITSOUND_MISS.."|R");
				end
				CritSound_BlacklistRem:SetText("")
			else
				print("|cFFFFFF99"..CRITSOUND_BADNAME.."|R|cFFFF0000"..spellname.."|R");
			end
		else
			print("|cFFFFFF99"..CRITSOUND_BADNAME.."|R|cFFFF0000"..spellname.."|R");
		end
		CritSound_BlacklistRem:ClearFocus()
	end)
	CritSound_BlacklistRem:SetScript("OnEscapePressed", function()
		CritSound_BlacklistRem:SetText("")
		CritSound_BlacklistRem:ClearFocus()
	end)
	CritSound_BlacklistRem:SetScript("OnEnter",function(self)
		GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", -6, 18);
		GameTooltip:AddLine(CRITSOUND_REMTIP);
		GameTooltip:Show();
	end);
	CritSound_BlacklistRem:SetScript("OnLeave",function()
		GameTooltip:Hide();
	end);

	CreateFrame("Button", "CritSound_BlacklistClear", CritSound_OptionsFrame, "OptionsButtonTemplate");
	CritSound_BlacklistClear:SetPoint("TOPLEFT", CritSound_BlacklistRem, "TOPLEFT", 160, 0);
	CritSound_BlacklistClear:SetWidth(100)
	CritSound_BlacklistClear:SetHeight(25)
	CritSound_BlacklistClearText:SetText(CRITSOUND_CLEAR);
	CritSound_BlacklistClear:SetScript("OnClick", function(self)
		local id;
		for id in pairs(CritSoundBlackList) do
			CritSoundBlackList[id] = nil;
		end
		print("|cFFFF0000"..CRITSOUND_CLEARINFO.."|R")
	end)
end

function CritSound_OptionPanel_OnShow()
	CritSound_CritSoundModeDropDownText:SetText(CritSoundModeDropDown[CritSoundMode]);
	if CritSoundMode ~= 2 then
		BlizzardOptionsPanel_Slider_Disable(CritSound_AgingTimeSlider);
	end
	CritSound_AgingTimeSlider:SetValue(CritSoundAgingTime);
	CritSound_Spell:SetChecked(CritSoundSwitch["spell"]==1);
	CritSound_Shield:SetChecked(CritSoundSwitch["shield"]==1);
	CritSound_Swing:SetChecked(CritSoundSwitch["swing"]==1);
	CritSound_Range:SetChecked(CritSoundSwitch["range"]==1);
	CritSound_Heal:SetChecked(CritSoundSwitch["heal"]==1);
	CritSound_BlacklistAdd:SetText("")
	CritSound_BlacklistRem:SetText("")
end
