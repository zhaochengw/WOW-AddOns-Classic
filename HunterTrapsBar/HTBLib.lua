-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this file,
-- You can obtain one at http://mozilla.org/MPL/2.0/.

-- Some shared functions
-- Prevent multi-loading
if not HTBLIB_VERSION or HTBLIB_VERSION < 1.41 then

	local _
	local NUM_SPELL_SLOTS = 10;
	local SCHOOL_COLORS = { 1.0, 0.7, 0.0 };
	
	HTBLIB_VERSION = 1.41;
	
	HTBLIB_ACTIVATE_SPEC = GetSpellInfo(200749);
	
	StaticPopupDialogs["HTBLIB_CONFIRM_RESET"] = {
		text = HTBLIB_CONFIRM_RESET,
		button1 = YES,
		button2 = NO,
		OnAccept = function(self, varName)
			_G[varName] = nil;
			ReloadUI();
		end,
		timeout = 0,
		whileDead = 1,
		hideOnEscape = 1,
	};
	
	-- Loads LibButtonFacade
	local LBF = nil;
	if LibStub then
		LBF = LibStub('Masque', true);
	end
	
	-- Reset addon
	function HTBLib_ResetAddon(addonName)
	
		local dialog = StaticPopup_Show("HTBLIB_CONFIRM_RESET", addonName);
		if dialog then
			dialog.data = string.upper(addonName.."_OPTIONS");
		end
	
	end
	
	-- Show borders on a frame
	function HTBLib_ShowBorders(self)
		if self.Backdrop == nil then
			Mixin(self, BackdropTemplateMixin);
		end
		
		self:SetBackdrop( { bgFile = "Interface/Tooltips/UI-Tooltip-Background", 
							edgeFile = "Interface/Tooltips/UI-Tooltip-Border", 
							tile = true,
							tileSize = 16,
							edgeSize = 16,
							insets = { left = 5, right = 5, top = 5, bottom = 5 } });
		-- Cosmetic
		if self.settings and self.settings.color then
			local r, g, b, a = unpack(self.settings.color);
			self:SetBackdropBorderColor((r + 1.0)/2.0, (g + 1.0)/2.0, (b + 1.0)/2.0);
			self:SetBackdropColor(r, g, b, a);
		else
			self:SetBackdropBorderColor(0.5, 0.5, 0.5);
			self:SetBackdropColor(TOOLTIP_DEFAULT_BACKGROUND_COLOR.r, TOOLTIP_DEFAULT_BACKGROUND_COLOR.g, TOOLTIP_DEFAULT_BACKGROUND_COLOR.b, 0.7);
		end
	
	end
	
	-- Hide borders on a frame
	function HTBLib_HideBorders(self)
		self:SetBackdrop(nil);
	end
	
	-- Copy content of src into dst, preserve existing values, recursive
	function HTBLib_CopyPreserve(src, dst)
	
		local k, v;
		for k, v in pairs(src) do
			if dst[k] == nil then
				if type(v) == "table" then
					dst[k] = {};
					HTBLib_CopyPreserve(v, dst[k]);
				else
					dst[k] = v;
				end
			elseif type(v) == "table" and type(dst[k]) == "table" then
				HTBLib_CopyPreserve(v, dst[k]);
			end
		end
	end
	
	-- Init an array of integers from 1 to n
	function HTBLib_Identity(n)
	
		local tmp = {};
		local i;
	
		for i = 1, n do
			tmp[i] = i;
		end
	
		return tmp;
	end
	
	
	-- Swap 2 vals in an integer indexed array
	function HTBLib_Swap(tab, val1, val2)
	
		local idx1, idx2, i;
		
		for i = 1, #tab do
			if tab[i] == val1 then
				idx1 = i;
			end
			if tab[i] == val2 then
				idx2 = i;
			end
		end
	
		if not idx1 and idx2 then
			-- one of the value not found, do nothing
			return;
		end
		tab[idx2] = val1;
		tab[idx1] = val2;
	
	end
	
	
	-- Update the bindings
	function HTBLib_UpdateBindings(self, bindingPrefix)
	
		if InCombatLockdown() then
			return;
		end
	
		local key1, key2, i;
		local buttonPrefix = self:GetName().."Button";
	
		ClearOverrideBindings(self);
	
		for i = 1, 10 do
			key1, key2 = GetBindingKey(bindingPrefix.."BUTTON"..i);
			if key1 then
				SetOverrideBindingClick(self, true, key1, buttonPrefix..i);
			end
			if key2 then
				SetOverrideBindingClick(self, true, key2, buttonPrefix..i);
			end
		end
	end
	
	-- Common receive drag function
	function HTBLib_ReceiveDrag(self, releaseCursor)
	
		if InCombatLockdown() then
			return;
		end
	
		local cursorType, index, info, i;
	
		cursorType, index, info = GetCursorInfo();
	
		if cursorType ~= "spell" or info ~= BOOKTYPE_SPELL then
			return;
		end
	
		local button = self;
		local newspell = GetSpellBookItemName(index, info);
		self = self:GetParent();
	
		-- find the spell in the curent list
		for i = 1, #self.availableSpells do
			if self.availableSpells[i].name == newspell then
				if releaseCursor then
					ClearCursor();
				end
				HTBLib_Swap(self.settings.buttonsOrder, self.settings.buttonsOrder[button:GetID()], i);
				HTBLib_Setup(self);
				break;
			end
		end
	
	end
	
	-- Check if a glyph is active
	function HTBLib_IsGlyphActive(glyphId)
			for i = 1, NUM_GLYPH_SLOTS do
					local enabled, _, _, glyphSpellID, _ = GetGlyphSocketInfo(i);
					if enabled and glyphSpellID == glyphId then
							return true;
					end
			end
			return false;
	end
	
	-- Return the rank of a talent
	function HTBLib_GetTalentRank(talentName, tree)
	
		local nt = GetNumTalents(tree);
		local n, r, m, i;
	
		for i = 1, nt do
			n, _, _, _, r, m = GetTalentInfo(tree, i);
			if n == talentName then
				return r, m;
			end
		end
		return 0, 0;
	end
	
	-- Show/hide a spell
	function HTBLib_ToggleSpell(self, bar, idx)
	
		if bar.settings.hiddenSpells[idx] then
			bar.settings.hiddenSpells[idx] = nil;
		else
			bar.settings.hiddenSpells[idx] = 1;
		end
	
		HTBLib_Setup(bar);
	end
	
	-- Setup the spell in a Bar
	function HTBLib_Setup(self)
	
		-- Protection if no settings
		if not self.settings then
			return;
		end
	
		local numSpells = 0;
		local button, coutdown;
		local isKnown, spell;
		local i = 1;
		local id, j, n;
	
		self.spells = {};
	
		-- Check already positionned spells
		while self.settings.buttonsOrder[i] do
	
			local n = self.settings.buttonsOrder[i];
	
			isKnown = false;
			if not self.settings.hiddenSpells[n] then
				spell = self.availableSpells[n];
				isKnown = spell and GetSpellInfo(GetSpellInfo(spell.id)) ~= nil;
			end
	
			if isKnown then
				spell.name, spell.addName, spell.texture = GetSpellInfo(spell.id);
				if spell.talented and not spell.talentedName then
					spell.talentedName = GetSpellInfo(spell.talented);
				end
				self:SetupSpell(spell, i);
				i = i + 1;
			else
				-- this spell is unavailable, shift the remaining indexes by 1
				for j = i, #self.settings.buttonsOrder do
					self.settings.buttonsOrder[j] = self.settings.buttonsOrder[j+1];
				end
			end
	
		end
	
		numSpells = i - 1;
	
		for n = 1, #self.availableSpells do
	
			if numSpells > NUM_SPELL_SLOTS then
				break;
			end
	
			spell = self.availableSpells[n];
			spell.name, spell.addName, spell.texture = GetSpellInfo(spell.id);
			if spell.talented and not spell.talentedName then
				spell.talentedName = GetSpellInfo(spell.talented);
			end
	
			-- Check if this spell is already positionned
			i = nil;
			for j = 1, #self.settings.buttonsOrder do
				if self.settings.buttonsOrder[j] == n then
					i = 1;
					break;
				end
			end
	
			if not i then
				isKnown = false;
				if not self.settings.hiddenSpells[n] then
					isKnown = GetSpellInfo(GetSpellInfo(spell.id)) ~= nil;
				end
				if isKnown then
	
					numSpells = numSpells + 1;
	
					self:SetupSpell(spell, numSpells);
					self.settings.buttonsOrder[numSpells] = n;
				end
			end
		end
	
		-- Avoid tainting
		if not InCombatLockdown() then
			if numSpells > 0 then
	
				self:Show();
				if self.hideCooldowns then
					self:SetWidth(numSpells * 35 + 9 );
				elseif self.sharedCooldown then
					self:SetWidth(numSpells * 35 + 21 );
				else
					self:SetWidth(numSpells * 42 + 12 );
				end
	
				local group;
				if LBF then
					group = LBF:Group('HunterTrapsBar');
				end
	
				for i=1, NUM_SPELL_SLOTS do
					button = _G[self:GetName().."Button"..i];
					countdown = _G[self:GetName().."Countdown"..i];
	
					if self.sharedCooldown and i == 1 then
						countdown:SetWidth(6);
					end
					
					-- Add the button to ButtonFacade
					if group then
						group:AddButton(button);
					end
	
					if self.hideCooldowns or self.sharedCooldown and i > 1 then
						button:SetPoint("LEFT", countdown, "LEFT", 0, 0);
					end
					if i <= numSpells then
						button:Show();
						if self.hideCooldowns or self.sharedCooldown and i > 1 then
							countdown:Hide();
						else
							countdown:Show();
						end
					else
						button:Hide();
						countdown:Hide();
					end
				end
			else
				self:Hide();
			end
		end
	
		if self.OnSetup then
			self:OnSetup();
		end
		HTBLib_UpdateState(self);
	end
	
	-- Update the state of the buttons in a Bar
	function HTBLib_UpdateState(self)
	
		local numSpells = #self.spells;
		local spell, cooldown, normalTexture, icon;
		local start, duration, enable, charges, maxCharges, isUsable, noMana;
		local start2, duration2, enable2;
		local i;
	
		for i=1, numSpells do
	
			if self.UpdateState then
				self:UpdateState(i);
			end
	
			spell = self.spells[i];
	
			--Cooldown stuffs
			cooldown = _G[self:GetName().."Button"..i.."Cooldown"];
			local _, _, _, _, _, _, maxRankId = GetSpellInfo(GetSpellInfo(spell.id));
			start, duration, enable, charges, maxCharges = GetSpellCooldown(maxRankId);
			if spell.talented then
				start2, duration2, enable2 = GetSpellCooldown(spell.talented);
				if start > 0 and start2 > 0 then
					start = math.min(start, start2);
				else
					start = start + start2;
				end
				duration = math.max(duration, duration2);
			end
	
			if cooldown.currentCooldownType ~= COOLDOWN_TYPE_NORMAL then
				cooldown:SetEdgeTexture("Interface\\Cooldown\\edge");
				cooldown:SetSwipeColor(0, 0, 0);
				cooldown:SetHideCountdownNumbers(false);
				cooldown.currentCooldownType = COOLDOWN_TYPE_NORMAL;
			end
			CooldownFrame_Set(cooldown, start, duration, enable, charges, maxCharges);
	
			--Castable stuffs
			normalTexture = _G[self:GetName().."Button"..i.."NormalTexture"];
			icon = _G[self:GetName().."Button"..i.."Icon"];
			isUsable, noMana = IsUsableSpell(maxRankId);
	
			if isUsable then
				icon:SetVertexColor(1.0, 1.0, 1.0);
				normalTexture:SetVertexColor(1.0, 1.0, 1.0);
			elseif noMana then
				icon:SetVertexColor(0.5, 0.5, 1.0);
				normalTexture:SetVertexColor(0.5, 0.5, 1.0);
			else
				icon:SetVertexColor(0.4, 0.4, 0.4);
				normalTexture:SetVertexColor(1.0, 1.0, 1.0);
			end
	
		end
	
	end
	
	function HTBLib_Button_SetTooltip(self)
		if GetCVar("UberTooltips") == "1" then
			if self:GetParent().settings.position ~= "auto" then
				GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
				--GameTooltip_SetDefaultAnchor(GameTooltip, self);
			else
				GameTooltip:SetOwner(self, "ANCHOR_NONE");
				GameTooltip:SetPoint("BOTTOMRIGHT", "UIParent", "BOTTOMRIGHT", -CONTAINER_OFFSET_X - 13, CONTAINER_OFFSET_Y + self:GetHeight());
				GameTooltip.default = 1;
			end
		else
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
		end
		local spell = self:GetParent().spells[self:GetID()];
		if spell then
			-- get id of max rank
			local _, _, _, _, _, _, maxRankId = GetSpellInfo(GetSpellInfo(spell.id));
			--Display the tooltip
			GameTooltip:SetSpellByID(maxRankId);
			GameTooltip:Show();
		end
	end
	
	function HTBLib_StartTimer(self, guid, spellid)
	
		local founded = false;
		local name, startTime, duration;
		local countdown;
		local i;
	
		name = GetSpellInfo(spellid)
	
		-- Find spell
		for i = 1, #self.spells do
			if self.spells[i].name == name or self.spells[i].talentedName == name then
				founded = i;
				duration = self.spells[i].duration;
				startTime = GetTime();
				break;
			end
		end
	
		if founded then
	
			if self.sharedCooldown then
				i = 1
			else
				i = founded
			end
			self["activeSpell"..i] = founded;
			self["startTime"..i] = startTime;
	
			countdown = _G[self:GetName().."Countdown"..i];
			if countdown and not self.hideCooldowns then
				countdown:SetMinMaxValues(0, duration);
				countdown:SetStatusBarColor(unpack(SCHOOL_COLORS));
			end
			HTBLib_OnUpdate(self);
		end
	end
	
	function HTBLib_ResetTimer(self, pos)
	
		if self.sharedCooldown then
			pos = 1
		end
		self["startTime"..pos] = 0;
		HTBLib_OnUpdate(self);
	end
	
	function HTBLib_OnUpdate(self)
	
		local isActive;
		local button;
		local countdown;
		local timeleft;
		local duration;
		local name, spell;
		local i;
	
		for i=1, #self.spells do
	
			name = self:GetName();
			button = _G[name.."Button"..i];
	
			spell = self.spells[i];
	
			isActive = false;
	
			if self.sharedCooldown then
				pos = 1
			else
				pos = i
			end
			if self["activeSpell"..pos] == i then
	
				countdown = _G[name.."Countdown"..pos];
				if countdown then
					timeleft = self["startTime"..pos];
					if not self.hideCooldowns then
						_, duration = countdown:GetMinMaxValues();
	
						timeleft = timeleft + duration - GetTime();
					end
					isActive = timeleft > 0;
	
					if (isActive) then
						countdown:SetValue(timeleft);
					else
						self["activeSpell"..pos] = nil;
						countdown:SetValue(0);
					end
				else
					isActive = self["startTime"..pos] ~= 0;
				end
			end
	
			if isActive then
				button:SetChecked(true);
			else
				button:SetChecked(false);
			end
		end
	end
	
	-- Bar Dropdown
	function HTBLib_BarDropDown_OnLoad(self)
		UIDropDownMenu_Initialize(self, HTBLib_BarDropDown_Initialize, "MENU");
		UIDropDownMenu_SetButtonWidth(self, 20);
		UIDropDownMenu_SetWidth(self, 20);
	end
	
	function HTBLib_BarDropDown_Initialize(frame, level, menuList)
	
		local info, i, spell;
		local bar = frame:GetParent();
	
		-- If level 3
		if UIDROPDOWNMENU_MENU_LEVEL == 3 then
			return;
		end
	
		-- If level 2
		if UIDROPDOWNMENU_MENU_LEVEL == 2 then
	
			-- If this is the position menu
			if UIDROPDOWNMENU_MENU_VALUE == "position" then
	
				-- Add the possible values to the menu
				for value, text in pairs(HTBLIB_POSITIONS) do
					info = UIDropDownMenu_CreateInfo();
					info.text = text;
					info.value = value;
					info.func = bar.menuHooks.SetPosition;
					info.arg1 = bar;
					info.arg2 = value;
	
					if value == bar.settings.position then
						info.checked = 1;
					end
					UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
				end
	
			-- If this is the layout menu
			elseif UIDROPDOWNMENU_MENU_VALUE == "layout" then
	
				-- Use the provided hook to populate the menu
				bar.menuHooks.SetLayoutMenu();
	
			-- If this is the spell menu
			elseif UIDROPDOWNMENU_MENU_VALUE == "spells" then
	
				-- Add the possible values to the menu
				for i, spell in ipairs(bar.availableSpells) do
					info = UIDropDownMenu_CreateInfo();
					info.text = spell.name;
					info.value = i;
					info.func = HTBLib_ToggleSpell;
					info.arg1 = bar;
					info.arg2 = i;
	
					if not bar.settings.hiddenSpells[i] then
						info.checked = 1;
					end
					UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
				end
	
			end
			return;
		end
	
		-- Position menu
		if bar.menuHooks and bar.menuHooks.SetPosition then
			info = UIDropDownMenu_CreateInfo();
			info.text = HTBLIB_POSITION;
			info.value = "position";
			info.hasArrow = 1;
			info.func = nil;
			UIDropDownMenu_AddButton(info);
		end
	
		-- Layout menu
		if bar.menuHooks and bar.menuHooks.SetLayoutMenu then
			info = UIDropDownMenu_CreateInfo();
			info.text = HTBLIB_LAYOUT;
			info.value = "layout";
			info.hasArrow = 1;
			info.func = nil;
			UIDropDownMenu_AddButton(info);
		end
	
		-- Spells menu
		if bar.menuHooks then
			info = UIDropDownMenu_CreateInfo();
			info.text = SPELLS;
			info.value = "spells";
			info.hasArrow = 1;
			info.func = nil;
			UIDropDownMenu_AddButton(info);
		end
	
		-- Border options
		if bar.menuHooks and bar.menuHooks.SetBorders then
			info = UIDropDownMenu_CreateInfo();
			info.text = HTBLIB_SHOWBORDERS;
			info.func = bar.menuHooks.SetBorders;
			info.arg1 = not bar.globalSettings.borders;
	
			if bar.globalSettings.borders then
				info.checked = 1;
			end
			UIDropDownMenu_AddButton(info);
		end
	
		-- Background
		if bar.menuHooks then
			info = UIDropDownMenu_CreateInfo();
			info.text = BACKGROUND;
			info.hasColorSwatch = 1;
			info.r = bar.settings.color[1];
			info.g = bar.settings.color[2];
			info.b = bar.settings.color[3];
			-- Done because the slider is reversed
			info.opacity = 1.0 - bar.settings.color[4];
			info.swatchFunc = HTBLib_BarDropDown_SetBackGroundColor;
			info.func = UIDropDownMenuButton_OpenColorPicker;
			info.hasOpacity = 1;
			info.opacityFunc = HTBLib_BarDropDown_SetOpacity;
			info.cancelFunc = HTBLib_BarDropDown_CancelColorSettings;
			UIDropDownMenu_AddButton(info);
		end
	
	end
	
	function HTBLib_BarDropDown_SetBackGroundColor()
		local r,g,b = ColorPickerFrame:GetColorRGB();
		local bar = UIDropDownMenu_GetCurrentDropDown():GetParent();
	
		bar.settings.color[1] = r;
		bar.settings.color[2] = g;
		bar.settings.color[3] = b;
	
		if bar.globalSettings.borders then
			HTBLib_ShowBorders(bar)
		end
	end
	
	function HTBLib_BarDropDown_SetOpacity()
		local a = 1.0 - OpacitySliderFrame:GetValue();
		local bar = UIDropDownMenu_GetCurrentDropDown():GetParent();
	
		bar.settings.color[4] = a;
	
		if bar.globalSettings.borders then
			HTBLib_ShowBorders(bar)
		end
	end
	
	function HTBLib_BarDropDown_CancelColorSettings(previous)
		local bar = UIDropDownMenu_GetCurrentDropDown():GetParent();
	
		bar.settings.color[1] = previous.r;
		bar.settings.color[2] = previous.g;
		bar.settings.color[3] = previous.b;
		bar.settings.color[4] = 1.0 - previous.opacity;
	
		if bar.globalSettings.borders then
			HTBLib_ShowBorders(bar)
		end
	end
	
	function HTBLib_BarDropDown_Show(self, button)
	
		-- If Rightclick bring up the options menu
		if button == "RightButton" then
			GameTooltip:Hide();
			self:StopMovingOrSizing();
			ToggleDropDownMenu(1, nil, _G[self:GetName().."DropDown"], self:GetName(), 0, 0);
			return;
		end
	
		-- Close all dropdowns
		CloseDropDownMenus();
	end
	
	function HTBLib_UnitHasBuff(unit, name)
	
		local i = 1;
		local buff = UnitBuff(unit, i);
		while buff do
			if buff == name then
				return true;
			end
			i = i + 1;
			buff = UnitBuff(unit, i);
		end
		return false;
	end
	
	end
	
