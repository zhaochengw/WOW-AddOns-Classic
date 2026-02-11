--[[--
	by ALA
--]]--
----------------------------------------------------------------------------------------------------
local __addon, __private = ...;
local MT = __private.MT;
local CT = __private.CT;
local VT = __private.VT;
local DT = __private.DT;

--		upvalue
	local type = type;
	local next = next;
	local tremove = table.remove;
	local UnitLevel = UnitLevel;
	local IsAltKeyDown = IsAltKeyDown;
	local IsShiftKeyDown = IsShiftKeyDown;
	local CreateFrame = CreateFrame;
	local StaticPopupDialogs = StaticPopupDialogs;
	local StaticPopup_Show = StaticPopup_Show;

-->
	local l10n = CT.l10n;

-->
MT.BuildEnv('UI-SubObjects');
-->		predef
-->		SubObjects
	MT._SideFunc = {  };
	--	Header
	function MT._SideFunc.CloseButton_OnClick(self, button)
		self.Frame:Hide();
	end
	function MT._SideFunc.ResetToEmuButton_OnClick(self)
		local Frame = self.Frame;
		MT.UI.FrameSetName(Frame, nil);
		MT.UI.FrameSetTalent(Frame, nil);
		MT.UI.FrameSetLevel(Frame, DT.MAX_LEVEL);
		self:Hide();
	end
	function MT._SideFunc.ResetToSetButton_OnClick(self)
		local Frame = self.Frame;
		local class, level, TalData, activeGroup, name, readOnly, rule =  Frame.class, Frame.level, Frame.TalData, Frame.activeGroup, Frame.name, Frame.readOnly, Frame.rule;
		local ShowEquip = Frame.EquipmentFrameContainer:IsShown();
		MT.UI.FrameReset(Frame);
		MT.UI.FrameSetInfo(Frame, class, level, TalData, activeGroup, name, readOnly, rule);
		if ShowEquip then
			Frame.EquipmentFrameContainer:Show();
			MT.Debug("EquipFrame", "ResetToSet Show");
		end
		MT.CALLBACK.OnInventoryDataRecv(name);
		self:Hide();
	end
	VT.TalentGroupSelectMenuDefinition = {
		handler = function(button, Frame, val)
			local class, level, TalData, activeGroup, name, readOnly, rule =  Frame.class, Frame.level, Frame.TalData, Frame.activeGroup, Frame.name, Frame.readOnly, Frame.rule;
			local ShowEquip = Frame.EquipmentFrameContainer:IsShown();
			MT.UI.FrameReset(Frame);
			MT.UI.FrameSetInfo(Frame, class, level, TalData, val, name, readOnly, rule);
			if ShowEquip then
				Frame.EquipmentFrameContainer:Show();
				MT.Debug("EquipFrame", "TalentGroupSelect Show");
			end
			return MT.CALLBACK.OnInventoryDataRecv(name);
		end,
		num = 0,
	};
	function MT._SideFunc.TalentGroupSelect_OnClick(self)
		local Frame = self.Frame;
		local TalData = Frame.TalData;
		if TalData.num > 1 then
			for group = 1, TalData.num do
				VT.TalentGroupSelectMenuDefinition[group] = {
					param = group,
					text = (group == Frame.activeGroup) and ("|cff00ff00>|r" .. MT.GenerateTitle(Frame.class, TalData[group]) .. "|cff00ff00<|r") or ("|cff000000>|r" .. MT.GenerateTitle(Frame.class, TalData[group]) .. "|cff000000<|r"),
				};
			end
			VT.TalentGroupSelectMenuDefinition.num = TalData.num;
			VT.__dep.__menulib.ShowMenu(self, "BOTTOMRIGHT", VT.TalentGroupSelectMenuDefinition, self.Frame, false, true);
		end
	end
	--	Footer
	function MT._SideFunc.ExpandButton_OnClick(self)
		local Frame = self.Frame;
		if Frame.style ~= 2 then
			MT.UI.FrameSetStyle(Frame, 2);
			if VT.SET.singleFrame then
				VT.SET.style = 2;
			end
		else
			MT.UI.FrameSetStyle(Frame, 1);
			if VT.SET.singleFrame then
				VT.SET.style = 1;
			end
		end
	end
	function MT._SideFunc.ResetAllButton_OnClick(self)
		MT.UI.FrameResetTalents(self.Frame);
	end
	function MT._SideFunc.TreeButton_OnClick(self)
		MT.UI.TreeUpdate(self.Frame, self.id);
	end
	--	side
	VT.ClassButtonMenuDefinition = {
		handler = function(button, Frame, val)
			if IsShiftKeyDown() then
				VT.VAR.savedTalent[val[1]] = nil;
			else
				VT.ImportIndex = VT.ImportIndex + 1;
				MT:ImportCode(Frame, val[2], "#" .. l10n.Import .. "[" .. VT.ImportIndex .. "] " .. val[1]);
			end
		end,
		num = 0,
	};
	function MT._SideFunc.ClassButton_OnClick(self, button)
		if button == "LeftButton" then
			local Frame = self.Frame;
			if Frame.class ~= self.class then
				MT.UI.FrameReset(Frame);
				MT.UI.FrameSetClass(Frame, self.class);
				local objects = Frame.objects;
				objects.CurClassIndicator:Show();
				objects.CurClassIndicator:ClearAllPoints();
				objects.CurClassIndicator:SetPoint("CENTER", Frame.ClassButtons[DT.ClassToIndex[Frame.class]]);
			end
		elseif button == "RightButton" then
			local class = self.class;
			if next(VT.VAR.savedTalent) == nil then
				return;
			end
			local Frame = self.Frame;
			local pos = 0;
			for title, code in next, VT.VAR.savedTalent do
				if VT.__dep.__emulib.GetClass(code) == class then
					pos = pos + 1;
					VT.ClassButtonMenuDefinition[pos] = {
						param = { title, code, },
						text = title,
					};
				end
			end
			VT.ClassButtonMenuDefinition.num = pos;
			if pos > 0 then
				VT.__dep.__menulib.ShowMenu(self, "TOPRIGHT", VT.ClassButtonMenuDefinition, Frame);
			end
		end
	end
	function MT._SideFunc.SpellListButton_OnClick(self)
		MT.UI.SpellListFrameToggle(self.Frame);
	end
	StaticPopupDialogs["TalentEmu_ApplyTalents"] = {
		text = l10n.ApplyTalentsButton_Notify,
		button1 = l10n.OKAY,
		button2 = l10n.CANCEL,
		--	OnShow = function(self) end,
		OnAccept = function(self, Frame)
			MT.ApplyTalents(Frame);
		end,
		OnHide = function(self)
			self.which = nil;
		end,
		timeout = 0,
		whileDead = true,
		hideOnEscape = true,
		preferredIndex = 1,
	};
	function MT._SideFunc.ApplyTalentsButton_OnClick(self)
		if UnitLevel('player') >= 10 then
			StaticPopup_Show("TalentEmu_ApplyTalents", nil, nil, self.Frame);
		end
	end
	function MT._SideFunc.SettingButton_OnClick(self)
		MT.OpenSetting();
	end
	function MT._SideFunc.ImportButton_OnClick(self)
		local EditBox = self.Frame.EditBox;
		if EditBox:IsShown() and EditBox.Parent == self then
			EditBox:Hide();
		else
			EditBox:ClearAllPoints();
			EditBox:SetPoint("LEFT", self, "RIGHT", CT.TUISTYLE.EditBoxYSize + 4, 0);
			EditBox:SetText("");
			EditBox:Show();
			EditBox:SetFocus();
			EditBox.OKayButton:ClearAllPoints();
			EditBox.OKayButton:SetPoint("LEFT", self, "RIGHT", 4, 0);
			--	EditBox.OKayButton:Show();
			EditBox.Parent = self;
			EditBox.type = "import";
		end
	end
	VT.ExportButtonMenuDefinition = {
		handler = function(button, Frame, codec)
			local code = codec:ExportCode(Frame);
			if code ~= nil then
				local EditBox = Frame.EditBox;
				EditBox:SetText(code);
				EditBox:Show();
				EditBox:SetFocus();
				EditBox:HighlightText();
				EditBox.type = "export";
			end
		end,
		num = 1,
		[1] = {
			param = MT,
			text = l10n.ExportButton_AllData,
		},
	};
	function MT._SideFunc.ExportButton_OnClick(self, button)
		local Frame = self.Frame;
		local EditBox = Frame.EditBox;
		if EditBox:IsShown() and EditBox.Parent == self then
			EditBox:Hide();
		else
			EditBox:ClearAllPoints();
			EditBox:SetPoint("LEFT", self, "RIGHT", 4, 0);
			EditBox.OKayButton:ClearAllPoints();
			EditBox.OKayButton:SetPoint("LEFT", EditBox, "RIGHT", 0, 0);
			EditBox.Parent = self;
			if button == "LeftButton" then
				EditBox:SetText(MT.EncodeTalent(Frame));
				EditBox:Show();
				EditBox:SetFocus();
				EditBox:HighlightText();
				EditBox.type = "export";
			elseif button == "RightButton" then
				if VT.ExportButtonMenuDefinition.num > 0 then
					VT.__dep.__menulib.ShowMenu(self, "TOPRIGHT", VT.ExportButtonMenuDefinition, Frame);
				end
			end
		end
	end
	VT.SaveButtonMenuDefinition = {
		handler = function(button, Frame, val)
			if IsShiftKeyDown() then
				VT.VAR.savedTalent[val[1]] = nil;
			else
				VT.ImportIndex = VT.ImportIndex + 1;
				MT:ImportCode(Frame, val[2], "#" .. l10n.Import .. "[" .. VT.ImportIndex .. "] " .. val[1]);
			end
		end,
		num = 0,
	};
	VT.SaveButtonMenuAltDefinition = {
		handler = function(button, Frame, val)
			if IsShiftKeyDown() then
				VT.VAR[val[1]] = nil;
				for index = VT.SaveButtonMenuAltDefinition.num, 1, -1 do
					if VT.SaveButtonMenuAltDefinition[index].param[1] == val[1] then
						tremove(VT.SaveButtonMenuAltDefinition, index);
						VT.SaveButtonMenuAltDefinition.num = VT.SaveButtonMenuAltDefinition.num - 1;
					end
				end
			else
				VT.ImportIndex = VT.ImportIndex + 1;
				MT:ImportCode(Frame, val[2], "#" .. l10n.Import .. "[" .. VT.ImportIndex .. "] " .. val[3]);
			end
		end,
		num = 0,
	}
	function MT._SideFunc.SaveButton_OnClick(self, button)
		if button == "LeftButton" then
			local Frame = self.Frame;
			local EditBox = Frame.EditBox;
			if EditBox:IsShown() and EditBox.Parent == self then
				EditBox:Hide();
			else
				EditBox:ClearAllPoints();
				EditBox:SetPoint("LEFT", self, "RIGHT", CT.TUISTYLE.EditBoxYSize + 4, 0);
				EditBox:SetText(MT.GenerateTitleFromRawData(Frame));
				EditBox:Show();
				EditBox.OKayButton:ClearAllPoints();
				EditBox.OKayButton:SetPoint("LEFT", self, "RIGHT", 4, 0);
				EditBox.Parent = self;
				EditBox.type = "save";
			end
		elseif button == "RightButton" then
			if IsAltKeyDown() then
				if VT.SaveButtonMenuAltDefinition.num > 0 then
					VT.__dep.__menulib.ShowMenu(self, "TOPRIGHT", VT.SaveButtonMenuAltDefinition, self.Frame);
				end
			else
				if next(VT.VAR.savedTalent) == nil then
					return;
				end
				local pos = 0;
				for title, code in next, VT.VAR.savedTalent do
					pos = pos + 1;
					VT.SaveButtonMenuDefinition[pos] = {
						param = { title, code, },
						text = title,
					};
				end
				VT.SaveButtonMenuDefinition.num = pos;
				if pos > 0 then
					VT.__dep.__menulib.ShowMenu(self, "TOPRIGHT", VT.SaveButtonMenuDefinition, self.Frame);
				end
			end
		end
	end
	local channel_list = {
		"PARTY",
		"GUILD",
		"RAID",
		"BATTLEGROUND",
		"WHISPER",
	};
	VT.SendButtonMenuDefinition = {
		handler = function(button, Frame, val)
			return MT.CreateEmulator(Frame, val[1], val[2], val[3], l10n.message, false, false);
		end,
		num = 0,
	};
	function MT._SideFunc.SendButton_OnClick(self, button)
		local Frame = self.Frame;
		if button == "LeftButton" then
			MT.SendTalents(Frame);
		elseif button == "RightButton" then
			if VT.SendButtonMenuDefinition.num > 0 then
				VT.__dep.__menulib.ShowMenu(self, "TOPRIGHT", VT.SendButtonMenuDefinition, Frame);
			end
		end
	end
	function MT._SideFunc.EditBox_OnEnterPressed(self)
		if self.type == nil then
			return;
		end
		local Type = self.type;
		self.type = nil;
		self:ClearFocus();
		self:Hide();
		if Type == "import" then
			local code = self:GetText();
			if code ~= nil and code ~= "" then
				for media, codec in next, VT.ExternalCodec do
					local class, level, data = codec:ImportCode(code);
					if class ~= nil then
						VT.ImportIndex = VT.ImportIndex + 1;
						return MT.UI.FrameSetInfo(self.Frame, class, level, { data, nil, num = 1, active = 1, }, 1, "#" .. l10n.Import .. "[" .. VT.ImportIndex .. "]");
					end
				end
				VT.ImportIndex = VT.ImportIndex + 1;
				return MT:ImportCode(self.Frame, code, "#" .. l10n.Import .. "[" .. VT.ImportIndex .. "]");
			end
		elseif Type == "save" then
			local title = self:GetText();
			if title == nil or title == "" then
				title = #VT.VAR.savedTalent + 1;
			end
			VT.VAR.savedTalent[title] = MT.EncodeTalent(self.Frame);
		end
	end
	function MT._SideFunc.EditBoxOKayButton_OnClick(self)
		return MT._SideFunc.EditBox_OnEnterPressed(self.EditBox);
	end
	function MT._SideFunc.EditBox_OnEscapePressed(EditBox)
		EditBox:SetText("");
		EditBox:ClearFocus();
		EditBox:Hide();
	end
	function MT._SideFunc.EditBox_OnShow(EditBox)
		EditBox.type = nil;
		EditBox.charChanged = nil;
	end
	function MT._SideFunc.EditBox_OnHide(EditBox)
		EditBox.type = nil;
		EditBox.charChanged = nil;
	end
	function MT._SideFunc.EditBox_OnChar(EditBox)
		EditBox.charChanged = true;
	end

	function MT._SideFunc.EquipmentFrameButton_OnClick(self)
		MT.UI.EquipmentFrameToggle(self.Frame);
	end

	function MT.UI.CreateHeaderObject(Frame)
		local objects = Frame.objects;

		local Header = CreateFrame('FRAME', nil, Frame);
		Header:SetPoint("TOPLEFT");
		Header:SetPoint("TOPRIGHT");
		Header:SetHeight(CT.TUISTYLE.FrameHeaderYSize);
		Frame.Header = Header;
		local Background = Header:CreateTexture(nil, "BACKGROUND");
		Background:SetAllPoints();
		Background:SetColorTexture(0.0, 0.0, 0.0, 0.5);
		Header.Background = Background;

		local CloseButton = CreateFrame('BUTTON', nil, Header);
		CloseButton:SetSize(CT.TUISTYLE.ControlButtonSize, CT.TUISTYLE.ControlButtonSize);
		MT._TextureFunc.SetNormalTexture(CloseButton, CT.TTEXTURESET.CLOSE, nil, nil, CT.TTEXTURESET.CONTROL.NORMAL_COLOR);
		MT._TextureFunc.SetPushedTexture(CloseButton, CT.TTEXTURESET.CLOSE, nil, nil, CT.TTEXTURESET.CONTROL.PUSHED_COLOR);
		MT._TextureFunc.SetHighlightTexture(CloseButton, CT.TTEXTURESET.CLOSE, nil, nil, CT.TTEXTURESET.CONTROL.HIGHLIGHT_COLOR);
		CloseButton:SetPoint("CENTER", Header, "RIGHT", -CT.TUISTYLE.FrameHeaderYSize * 0.5, 0);
		CloseButton:Show();
		CloseButton:SetScript("OnClick", MT._SideFunc.CloseButton_OnClick);
		CloseButton:SetScript("OnEnter", MT.GeneralOnEnter);
		CloseButton:SetScript("OnLeave", MT.GeneralOnLeave);
		CloseButton.Frame = Frame;
		CloseButton.information = l10n.CloseButton;
		objects.CloseButton = CloseButton;

		local Name = Header:CreateFontString(nil, "ARTWORK");
		Name:SetFont(CT.TUISTYLE.FrameFont, CT.TUISTYLE.FrameFontSize, CT.TUISTYLE.FrameFontOutline);
		Name:SetText(l10n.Emulator);
		Name:SetPoint("CENTER", Header, "CENTER", 0, 0);
		Name.Points1 = { "CENTER", Header, "CENTER", 0, 0, };
		Name.Points2 = { "BOTTOM", Header, "TOP", 0, 4, };
		objects.Name = Name;

		local ResetToEmuButton = CreateFrame('BUTTON', nil, Header);
		ResetToEmuButton:SetSize(CT.TUISTYLE.ControlButtonSize, CT.TUISTYLE.ControlButtonSize);
		MT._TextureFunc.SetNormalTexture(ResetToEmuButton, CT.TTEXTURESET.RESETTOEMU, nil, nil, CT.TTEXTURESET.CONTROL.NORMAL_COLOR);
		MT._TextureFunc.SetPushedTexture(ResetToEmuButton, CT.TTEXTURESET.RESETTOEMU, nil, nil, CT.TTEXTURESET.CONTROL.PUSHED_COLOR);
		MT._TextureFunc.SetHighlightTexture(ResetToEmuButton, CT.TTEXTURESET.RESETTOEMU, nil, nil, CT.TTEXTURESET.CONTROL.HIGHLIGHT_COLOR);
		ResetToEmuButton:SetFrameLevel(ResetToEmuButton:GetFrameLevel() + 1);
		ResetToEmuButton:SetPoint("RIGHT", Name, "LEFT", 0, 0);
		ResetToEmuButton:SetScript("OnClick", MT._SideFunc.ResetToEmuButton_OnClick);
		ResetToEmuButton:SetScript("OnEnter", MT.GeneralOnEnter);
		ResetToEmuButton:SetScript("OnLeave", MT.GeneralOnLeave);
		ResetToEmuButton.Frame = Frame;
		ResetToEmuButton.information = l10n.ResetToEmuButton;
		objects.ResetToEmuButton = ResetToEmuButton;

		local PackLabel = Header:CreateFontString(nil, "ARTWORK");
		PackLabel:SetFont(CT.TUISTYLE.FrameFont, CT.TUISTYLE.FrameFontSizeLarge, CT.TUISTYLE.FrameFontOutline);
		PackLabel:SetText("");
		PackLabel:SetPoint("BOTTOM", Name, "TOP", 0, 4);
		PackLabel:Hide();
		objects.PackLabel = PackLabel;

		local Label = Header:CreateFontString(nil, "ARTWORK");
		Label:SetFont(CT.TUISTYLE.FrameFont, CT.TUISTYLE.FrameFontSize, CT.TUISTYLE.FrameFontOutline);
		Label:SetPoint("CENTER", Header, "CENTER", 0, 0);
		Label:Hide();
		objects.Label = Label;

		local ResetToSetButton = CreateFrame('BUTTON', nil, Header);
		ResetToSetButton:SetSize(CT.TUISTYLE.ControlButtonSize, CT.TUISTYLE.ControlButtonSize);
		MT._TextureFunc.SetNormalTexture(ResetToSetButton, CT.TTEXTURESET.RESETTOSET, nil, nil, CT.TTEXTURESET.CONTROL.NORMAL_COLOR);
		MT._TextureFunc.SetPushedTexture(ResetToSetButton, CT.TTEXTURESET.RESETTOSET, nil, nil, CT.TTEXTURESET.CONTROL.PUSHED_COLOR);
		MT._TextureFunc.SetHighlightTexture(ResetToSetButton, CT.TTEXTURESET.RESETTOSET, nil, nil, CT.TTEXTURESET.CONTROL.PUSHED_COLOR);
		ResetToSetButton:SetFrameLevel(ResetToSetButton:GetFrameLevel() + 1);
		ResetToSetButton:SetPoint("LEFT", Label, "RIGHT", 0, 0);
		ResetToSetButton:SetScript("OnClick", MT._SideFunc.ResetToSetButton_OnClick);
		ResetToSetButton:SetScript("OnEnter", MT.GeneralOnEnter);
		ResetToSetButton:SetScript("OnLeave", MT.GeneralOnLeave);
		ResetToSetButton.Frame = Frame;
		ResetToSetButton.information = l10n.ResetToSetButton;
		objects.ResetToSetButton = ResetToSetButton;

		local TalentGroupSelect = CreateFrame('BUTTON', nil, Header);
		TalentGroupSelect:SetSize(CT.TUISTYLE.ControlButtonSize * 0.75, CT.TUISTYLE.ControlButtonSize);
		MT._TextureFunc.SetNormalTexture(TalentGroupSelect, CT.TTEXTURESET.DROP, nil, nil, CT.TTEXTURESET.CONTROL.NORMAL_COLOR);
		MT._TextureFunc.SetPushedTexture(TalentGroupSelect, CT.TTEXTURESET.DROP, nil, nil, CT.TTEXTURESET.CONTROL.PUSHED_COLOR);
		MT._TextureFunc.SetHighlightTexture(TalentGroupSelect, CT.TTEXTURESET.DROP, nil, nil, CT.TTEXTURESET.CONTROL.PUSHED_COLOR);
		TalentGroupSelect:SetPoint("RIGHT", Label, "LEFT", 0, 0);
		TalentGroupSelect:SetScript("OnClick", MT._SideFunc.TalentGroupSelect_OnClick);
		TalentGroupSelect:SetScript("OnEnter", MT.GeneralOnEnter);
		TalentGroupSelect:SetScript("OnLeave", MT.GeneralOnLeave);
		TalentGroupSelect:Hide();
		TalentGroupSelect.Frame = Frame;
		TalentGroupSelect.information = l10n.TalentGroupSelect;
		objects.TalentGroupSelect = TalentGroupSelect;
	end
	function MT.UI.CreateFooterControl(Frame)
		local objects = Frame.objects;

		if CT.TOCVERSION < 50000 then
			local ExpandButton = CreateFrame('BUTTON', nil, Frame);
			ExpandButton:SetSize(CT.TUISTYLE.ControlButtonSize, CT.TUISTYLE.ControlButtonSize);
			MT._TextureFunc.SetNormalTexture(ExpandButton, CT.TTEXTURESET.EXPAND, nil, nil, CT.TTEXTURESET.CONTROL.NORMAL_COLOR);
			MT._TextureFunc.SetPushedTexture(ExpandButton, CT.TTEXTURESET.EXPAND, nil, nil, CT.TTEXTURESET.CONTROL.PUSHED_COLOR);
			MT._TextureFunc.SetHighlightTexture(ExpandButton, CT.TTEXTURESET.EXPAND, nil, nil, CT.TTEXTURESET.CONTROL.PUSHED_COLOR);
			ExpandButton:SetPoint("BOTTOMRIGHT", Frame, "BOTTOMRIGHT", -2, (CT.TUISTYLE.FrameFooterYSize - CT.TUISTYLE.ControlButtonSize) * 0.5);
			ExpandButton:Show();
			ExpandButton:SetScript("OnClick", MT._SideFunc.ExpandButton_OnClick);
			ExpandButton:SetScript("OnEnter", MT.GeneralOnEnter);
			ExpandButton:SetScript("OnLeave", MT.GeneralOnLeave);
			ExpandButton.Frame = Frame;
			ExpandButton.information = l10n.ExpandButton;
			objects.ExpandButton = ExpandButton;
		end

		local ResetAllButton = CreateFrame('BUTTON', nil, Frame);
		ResetAllButton:SetSize(CT.TUISTYLE.ControlButtonSize, CT.TUISTYLE.ControlButtonSize);
		MT._TextureFunc.SetNormalTexture(ResetAllButton, CT.TTEXTURESET.RESETALL, nil, nil, CT.TTEXTURESET.CONTROL.NORMAL_COLOR);
		MT._TextureFunc.SetPushedTexture(ResetAllButton, CT.TTEXTURESET.RESETALL, nil, nil, CT.TTEXTURESET.CONTROL.PUSHED_COLOR);
		MT._TextureFunc.SetHighlightTexture(ResetAllButton, CT.TTEXTURESET.RESETALL, nil, nil, CT.TTEXTURESET.CONTROL.PUSHED_COLOR);
		ResetAllButton:SetPoint("BOTTOMLEFT", Frame, "BOTTOMLEFT", 2, (CT.TUISTYLE.FrameFooterYSize - CT.TUISTYLE.ControlButtonSize) * 0.5);
		ResetAllButton:Show();
		ResetAllButton:SetScript("OnClick", MT._SideFunc.ResetAllButton_OnClick);
		ResetAllButton:SetScript("OnEnter", MT.GeneralOnEnter);
		ResetAllButton:SetScript("OnLeave", MT.GeneralOnLeave);
		ResetAllButton.Frame = Frame;
		ResetAllButton.information = l10n.ResetAllButton;
		objects.ResetAllButton = ResetAllButton;

		if CT.TOCVERSION < 50000 then
			local CurPointsRemainingLabel = Frame:CreateFontString(nil, "ARTWORK");
			CurPointsRemainingLabel:SetFont(CT.TUISTYLE.FrameFont, CT.TUISTYLE.FrameFontSizeMedium, CT.TUISTYLE.FrameFontOutline);
			CurPointsRemainingLabel:SetText(l10n.PointsRemaining);
			CurPointsRemainingLabel:SetPoint("CENTER", Frame, "BOTTOM", -15, CT.TUISTYLE.FrameFooterYSize * 0.5);
			local PointsRemaining = Frame:CreateFontString(nil, "ARTWORK");
			PointsRemaining:SetFont(CT.TUISTYLE.FrameFont, CT.TUISTYLE.FrameFontSize, CT.TUISTYLE.FrameFontOutline);
			PointsRemaining:SetText("51");
			PointsRemaining:SetPoint("LEFT", CurPointsRemainingLabel, "RIGHT", 2, 0);
			CurPointsRemainingLabel:SetTextColor(0.5, 1.0, 1.0, 1.0);
			PointsRemaining:SetTextColor(0.5, 1.0, 1.0, 1.0);

			local PointsUsed = Frame:CreateFontString(nil, "ARTWORK");
			PointsUsed:SetFont(CT.TUISTYLE.FrameFont, CT.TUISTYLE.FrameFontSize, CT.TUISTYLE.FrameFontOutline);
			PointsUsed:SetText("0");
			PointsUsed:SetPoint("RIGHT", CurPointsRemainingLabel, "LEFT", -8, 0);
			local CurPointsUsedLabel = Frame:CreateFontString(nil, "ARTWORK");
			CurPointsUsedLabel:SetFont(CT.TUISTYLE.FrameFont, CT.TUISTYLE.FrameFontSize, CT.TUISTYLE.FrameFontOutline);
			CurPointsUsedLabel:SetText(l10n.PointsUsed);
			CurPointsUsedLabel:SetPoint("RIGHT", PointsUsed, "LEFT", -2, 0);
			CurPointsUsedLabel:SetTextColor(0.5, 1.0, 0.5, 1.0);
			PointsUsed:SetTextColor(0.5, 1.0, 0.5, 1.0);

			local CurPointsReqLevelLabel = Frame:CreateFontString(nil, "ARTWORK");
			CurPointsReqLevelLabel:SetFont(CT.TUISTYLE.FrameFont, CT.TUISTYLE.FrameFontSize, CT.TUISTYLE.FrameFontOutline);
			CurPointsReqLevelLabel:SetText(l10n.PointsToLevel);
			CurPointsReqLevelLabel:SetPoint("LEFT", PointsRemaining, "RIGHT", 8, 0);
			local PointsToLevel = Frame:CreateFontString(nil, "ARTWORK");
			PointsToLevel:SetFont(CT.TUISTYLE.FrameFont, CT.TUISTYLE.FrameFontSize, CT.TUISTYLE.FrameFontOutline);
			PointsToLevel:SetText("10");
			PointsToLevel:SetPoint("LEFT", CurPointsReqLevelLabel, "RIGHT", 2, 0);
			CurPointsReqLevelLabel:SetTextColor(1.0, 1.0, 0.5, 1.0);
			PointsToLevel:SetTextColor(1.0, 1.0, 0.5, 1.0);

			objects.CurPointsRemainingLabel = CurPointsRemainingLabel;
			objects.PointsRemaining = PointsRemaining;
			objects.CurPointsUsedLabel = CurPointsUsedLabel;
			objects.PointsUsed = PointsUsed;
			objects.CurPointsReqLevelLabel = CurPointsReqLevelLabel;
			objects.PointsToLevel = PointsToLevel;
		end
	end
	function MT.UI.CreateFooterTreeButtons(Frame)
		local objects = Frame.objects;

		local TreeButtonsBar = CreateFrame('FRAME', nil, Frame);
		TreeButtonsBar:SetPoint("CENTER", Frame, "BOTTOM", 0, CT.TUISTYLE.FrameFooterYSize + CT.TUISTYLE.TreeButtonsBarYSize * 0.5);
		TreeButtonsBar:SetSize(CT.TUISTYLE.TreeButtonXSize * 3 + CT.TUISTYLE.TreeButtonGap * 2, CT.TUISTYLE.TreeButtonYSize);
		Frame.TreeButtonsBar = TreeButtonsBar;
		local TreeButtons = {  };
		for TreeIndex = 1, 4 do
			local TreeButton = CreateFrame('BUTTON', nil, TreeButtonsBar);
			TreeButton:SetSize(CT.TUISTYLE.TreeButtonXSize, CT.TUISTYLE.TreeButtonYSize);
			MT._TextureFunc.SetNormalTexture(TreeButton, CT.TTEXTURESET.TREEBUTTON.Normal);
			MT._TextureFunc.SetPushedTexture(TreeButton, CT.TTEXTURESET.TREEBUTTON.Pushed);
			MT._TextureFunc.SetHighlightTexture(TreeButton, CT.TTEXTURESET.TREEBUTTON.Highlight, CT.TTEXTURESET.NORMAL_HIGHLIGHT);
			TreeButton:Show();
			TreeButton:SetScript("OnClick", MT._SideFunc.TreeButton_OnClick);
			TreeButton:SetScript("OnEnter", MT.GeneralOnEnter);
			TreeButton:SetScript("OnLeave", MT.GeneralOnLeave);
			TreeButton.id = TreeIndex;
			TreeButton.information = nil;
			local Title = TreeButton:CreateFontString(nil, "OVERLAY");
			Title:SetFont(CT.TUISTYLE.TreeButtonsFont, CT.TUISTYLE.TreeButtonsFontSize, CT.TUISTYLE.TreeButtonsFontOutline);
			Title:SetTextColor(0.9, 0.9, 0.9, 1.0);
			Title:SetPoint("CENTER");
			Title:SetWidth(CT.TUISTYLE.TreeButtonXSize);
			Title:SetMaxLines(1);
			TreeButton.Frame = Frame;
			TreeButton.Title = Title;
			TreeButtons[TreeIndex] = TreeButton;
		end
		TreeButtons[2]:SetPoint("CENTER", TreeButtonsBar, "CENTER", 0, 0);
		TreeButtons[1]:SetPoint("RIGHT", TreeButtons[2], "LEFT", -CT.TUISTYLE.TreeButtonGap, 0);
		TreeButtons[3]:SetPoint("LEFT", TreeButtons[2], "RIGHT", CT.TUISTYLE.TreeButtonGap, 0);
		TreeButtons[4]:SetPoint("LEFT", TreeButtons[3], "RIGHT", CT.TUISTYLE.TreeButtonGap, 0);
		TreeButtons[4]:Hide();
		Frame.TreeButtons = TreeButtons;

		local CurTreeIndicator = TreeButtonsBar:CreateTexture(nil, "OVERLAY");
		CurTreeIndicator:SetSize(CT.TUISTYLE.TreeButtonXSize + 4, CT.TUISTYLE.TreeButtonYSize + 4);
		CurTreeIndicator:SetBlendMode("ADD");
		MT._TextureFunc.SetTexture(CurTreeIndicator, CT.TTEXTURESET.TREEBUTTON.Indicator, CT.TTEXTURESET.SQUARE_HIGHLIGHT);
		CurTreeIndicator:Hide();
		TreeButtonsBar.CurTreeIndicator = CurTreeIndicator;
	end
	function MT.UI.CreateFooterObject(Frame)
		MT.UI.CreateFooterControl(Frame);
		MT.UI.CreateFooterTreeButtons(Frame);
	end
	function MT.UI.CreateSideClass(Frame)
		local objects = Frame.objects;

		local ClassButtons = {  };--DT.IndexToClass
		for index = 1, #DT.IndexToClass do
			local class = DT.IndexToClass[index];
			local ClassButton = CreateFrame('BUTTON', nil, Frame.SideAnchorTop);
			ClassButton:SetSize(CT.TUISTYLE.SideButtonSize, CT.TUISTYLE.SideButtonSize);
			local coord = CT.CLASS_ICON_TCOORDS[class];
			if coord then
				MT._TextureFunc.SetNormalTexture(ClassButton, CT.TTEXTURESET.CLASS.Normal, nil, { coord[1] + 1 / 256, coord[2] - 1 / 256, coord[3] + 1 / 256, coord[4] - 1 / 256, });
				MT._TextureFunc.SetPushedTexture(ClassButton, CT.TTEXTURESET.CLASS.Pushed, nil, { coord[1] + 1 / 256, coord[2] - 1 / 256, coord[3] + 0 / 256, coord[4] - 2 / 256, }, CT.TTEXTURESET.CONTROL.PUSHED_COLOR);
			else
				MT._TextureFunc.SetNormalTexture(ClassButton, CT.TTEXTURESET.CLASS.Normal, nil, { 0.75, 1.00, 0.75, 1.00, });
				MT._TextureFunc.SetPushedTexture(ClassButton, CT.TTEXTURESET.CLASS.Pushed, nil, { 0.75, 1.00, 0.75, 1.00, }, CT.TTEXTURESET.CONTROL.PUSHED_COLOR);
			end
			MT._TextureFunc.SetHighlightTexture(ClassButton, CT.TTEXTURESET.CLASS.Highlight);
			ClassButton:SetPoint("TOPLEFT", Frame.SideAnchorTop, "TOPLEFT", 0, -(CT.TUISTYLE.SideButtonSize + CT.TUISTYLE.SideButtonGap) * (index - 1));
			ClassButton:Show();
			ClassButton:RegisterForClicks("LeftButtonUp", "RightButtonUp");
			ClassButton:SetScript("OnClick", MT._SideFunc.ClassButton_OnClick);
			ClassButton:SetScript("OnEnter", MT.GeneralOnEnter);
			ClassButton:SetScript("OnLeave", MT.GeneralOnLeave);
			ClassButton.id = index;
			ClassButton.class = class;
			ClassButton.Frame = Frame;
			ClassButton.information = "|c" .. CT.RAID_CLASS_COLORS[class].colorStr .. l10n.CLASS[class] .. "|r" .. l10n.ClassButton;
			ClassButtons[index] = ClassButton;
		end
		Frame.ClassButtons = ClassButtons;

		local CurClassIndicator = Frame:CreateTexture(nil, "OVERLAY");
		CurClassIndicator:SetSize(CT.TUISTYLE.CurClassIndicatorSize, CT.TUISTYLE.CurClassIndicatorSize);
		CurClassIndicator:SetBlendMode("ADD");
		MT._TextureFunc.SetTexture(CurClassIndicator, CT.TTEXTURESET.CLASS.Indicator);
		CurClassIndicator:Show();
		Frame.objects.CurClassIndicator = CurClassIndicator;
	end
	function MT.UI.CreateSideControl(Frame)
		local objects = Frame.objects;

		local SpellListButton = CreateFrame('BUTTON', nil, Frame.SideAnchorBottom);
		SpellListButton:SetSize(CT.TUISTYLE.SideButtonSize, CT.TUISTYLE.SideButtonSize);
		MT._TextureFunc.SetNormalTexture(SpellListButton, CT.TTEXTURESET.SPELLTAB, nil, nil, CT.TTEXTURESET.CONTROL.NORMAL_COLOR);
		MT._TextureFunc.SetPushedTexture(SpellListButton, CT.TTEXTURESET.SPELLTAB, nil, nil, CT.TTEXTURESET.CONTROL.PUSHED_COLOR);
		MT._TextureFunc.SetHighlightTexture(SpellListButton, CT.TTEXTURESET.SPELLTAB, nil, nil, CT.TTEXTURESET.CONTROL.PUSHED_COLOR);
		SpellListButton:SetPoint("BOTTOMLEFT", Frame.SideAnchorBottom, "BOTTOMLEFT", 0, 0);
		SpellListButton:Show();
		SpellListButton:SetScript("OnClick", MT._SideFunc.SpellListButton_OnClick);
		SpellListButton:SetScript("OnEnter", MT.GeneralOnEnter);
		SpellListButton:SetScript("OnLeave", MT.GeneralOnLeave);
		SpellListButton.Frame = Frame;
		SpellListButton.information = l10n.SpellListButton;
		Frame.SpellListButton = SpellListButton;

		local ApplyTalentsButton = CreateFrame('BUTTON', nil, Frame.SideAnchorBottom);
		ApplyTalentsButton:SetSize(CT.TUISTYLE.SideButtonSize, CT.TUISTYLE.SideButtonSize);
		MT._TextureFunc.SetNormalTexture(ApplyTalentsButton, CT.TTEXTURESET.APPLY, nil, nil, CT.TTEXTURESET.CONTROL.NORMAL_COLOR);
		MT._TextureFunc.SetPushedTexture(ApplyTalentsButton, CT.TTEXTURESET.APPLY, nil, nil, CT.TTEXTURESET.CONTROL.PUSHED_COLOR);
		MT._TextureFunc.SetHighlightTexture(ApplyTalentsButton, CT.TTEXTURESET.APPLY, nil, nil, CT.TTEXTURESET.CONTROL.PUSHED_COLOR);
		MT._TextureFunc.SetDisabledTexture(ApplyTalentsButton, CT.TTEXTURESET.APPLY, nil, nil, CT.TTEXTURESET.CONTROL.DISABLED_COLOR);
		ApplyTalentsButton:SetPoint("BOTTOM", SpellListButton, "TOP", 0, CT.TUISTYLE.SideButtonGap);
		ApplyTalentsButton:Show();
		ApplyTalentsButton:SetScript("OnClick", MT._SideFunc.ApplyTalentsButton_OnClick);
		ApplyTalentsButton:SetScript("OnEnter", MT.GeneralOnEnter);
		ApplyTalentsButton:SetScript("OnLeave", MT.GeneralOnLeave);
		ApplyTalentsButton.Frame = Frame;
		ApplyTalentsButton.information = l10n.ApplyTalentsButton;
		Frame.ApplyTalentsButton = ApplyTalentsButton;
		local ApplyTalentsButtonProgress = ApplyTalentsButton:CreateFontString(nil, "ARTWORK");
		ApplyTalentsButtonProgress:SetFont(CT.TUISTYLE.FrameFont, CT.TUISTYLE.FrameFontSizeMedium, CT.TUISTYLE.FrameFontOutline);
		ApplyTalentsButtonProgress:SetPoint("LEFT", ApplyTalentsButton, "RIGHT", 4, 0);
		ApplyTalentsButton.Progress = ApplyTalentsButtonProgress;
		Frame.ApplyTalentsProgress = ApplyTalentsButtonProgress;
		if CT.TOCVERSION >= 50000 then
			ApplyTalentsButton:Hide();
		end

		local SettingButton = CreateFrame('BUTTON', nil, Frame.SideAnchorBottom);
		SettingButton:SetSize(CT.TUISTYLE.SideButtonSize, CT.TUISTYLE.SideButtonSize);
		MT._TextureFunc.SetNormalTexture(SettingButton, CT.TTEXTURESET.SETTING, nil, nil, CT.TTEXTURESET.CONTROL.NORMAL_COLOR);
		MT._TextureFunc.SetPushedTexture(SettingButton, CT.TTEXTURESET.SETTING, nil, nil, CT.TTEXTURESET.CONTROL.PUSHED_COLOR);
		MT._TextureFunc.SetHighlightTexture(SettingButton, CT.TTEXTURESET.SETTING, nil, nil, CT.TTEXTURESET.CONTROL.PUSHED_COLOR);
		SettingButton:SetPoint("BOTTOM", ApplyTalentsButton, "TOP", 0, CT.TUISTYLE.SideButtonGap);
		SettingButton:Show();
		SettingButton:RegisterForClicks("LeftButtonUp", "RightButtonUp");
		SettingButton:SetScript("OnClick", MT._SideFunc.SettingButton_OnClick);
		SettingButton:SetScript("OnEnter", MT.GeneralOnEnter);
		SettingButton:SetScript("OnLeave", MT.GeneralOnLeave);
		SettingButton.Frame = Frame;
		SettingButton.information = l10n.SettingButton;
		Frame.SettingButton = SettingButton;

		local EditBox = CreateFrame('EDITBOX', nil, Frame);
		EditBox:SetSize(CT.TUISTYLE.EditBoxXSize, CT.TUISTYLE.EditBoxYSize);
		EditBox:SetFont(CT.TUISTYLE.FrameFont, CT.TUISTYLE.FrameFontSizeLarge, CT.TUISTYLE.FrameFontOutline);
		EditBox:SetAutoFocus(false);
		EditBox:SetJustifyH("LEFT");
		EditBox:Hide();
		EditBox:EnableMouse(true);
		EditBox:SetScript("OnEnterPressed", MT._SideFunc.EditBox_OnEnterPressed);
		EditBox:SetScript("OnEscapePressed", MT._SideFunc.EditBox_OnEscapePressed);
		EditBox:SetScript("OnShow", MT._SideFunc.EditBox_OnShow);
		EditBox:SetScript("OnHide", MT._SideFunc.EditBox_OnHide);
		EditBox:SetScript("OnChar", MT._SideFunc.EditBox_OnChar);
		EditBox.Frame = Frame;
		Frame.EditBox = EditBox;
		local Texture = EditBox:CreateTexture(nil, "ARTWORK");
		Texture:SetPoint("TOPLEFT");
		Texture:SetPoint("BOTTOMRIGHT");
		Texture:SetTexture("Interface\\Buttons\\buttonhilight-square");
		Texture:SetTexCoord(0.25, 0.75, 0.25, 0.75);
		Texture:SetAlpha(0.36);
		Texture:SetVertexColor(1.0, 1.0, 1.0);
		EditBox.Texture = Texture;
		local EditBoxOKayButton = CreateFrame('BUTTON', nil, EditBox);
		EditBoxOKayButton:SetSize(CT.TUISTYLE.EditBoxYSize, CT.TUISTYLE.EditBoxYSize);
		MT._TextureFunc.SetNormalTexture(EditBoxOKayButton, CT.TTEXTURESET.EDIT_OKAY, nil, nil, CT.TTEXTURESET.CONTROL.NORMAL_COLOR);
		MT._TextureFunc.SetPushedTexture(EditBoxOKayButton, CT.TTEXTURESET.EDIT_OKAY, nil, nil, CT.TTEXTURESET.CONTROL.PUSHED_COLOR);
		MT._TextureFunc.SetHighlightTexture(EditBoxOKayButton, CT.TTEXTURESET.EDIT_OKAY, nil, nil, CT.TTEXTURESET.CONTROL.PUSHED_COLOR);
		EditBoxOKayButton:SetPoint("LEFT", EditBox, "RIGHT", 0, 4);
		EditBoxOKayButton:Show();
		EditBoxOKayButton:SetScript("OnClick", MT._SideFunc.EditBoxOKayButton_OnClick);
		EditBoxOKayButton:SetScript("OnEnter", MT.GeneralOnEnter);
		EditBoxOKayButton:SetScript("OnLeave", MT.GeneralOnLeave);
		EditBoxOKayButton.EditBox = EditBox;
		EditBoxOKayButton.information = l10n.EditBoxOKayButton;
		EditBox.OKayButton = EditBoxOKayButton;

		local ImportButton = CreateFrame('BUTTON', nil, Frame.SideAnchorBottom);
		ImportButton:SetSize(CT.TUISTYLE.SideButtonSize, CT.TUISTYLE.SideButtonSize);
		MT._TextureFunc.SetNormalTexture(ImportButton, CT.TTEXTURESET.IMPORT, nil, nil, CT.TTEXTURESET.CONTROL.NORMAL_COLOR);
		MT._TextureFunc.SetPushedTexture(ImportButton, CT.TTEXTURESET.IMPORT, nil, nil, CT.TTEXTURESET.CONTROL.PUSHED_COLOR);
		MT._TextureFunc.SetHighlightTexture(ImportButton, CT.TTEXTURESET.IMPORT, nil, nil, CT.TTEXTURESET.CONTROL.PUSHED_COLOR);
		ImportButton:SetPoint("BOTTOM", SettingButton, "TOP", 0, CT.TUISTYLE.SideButtonGap);
		ImportButton:Show();
		ImportButton:RegisterForClicks("LeftButtonUp", "RightButtonUp");
		ImportButton:SetScript("OnClick", MT._SideFunc.ImportButton_OnClick);
		ImportButton:SetScript("OnEnter", MT.GeneralOnEnter);
		ImportButton:SetScript("OnLeave", MT.GeneralOnLeave);
		ImportButton.Frame = Frame;
		ImportButton.information = l10n.ImportButton;
		Frame.ImportButton = ImportButton;

		local ExportButton = CreateFrame('BUTTON', nil, Frame.SideAnchorBottom);
		ExportButton:SetSize(CT.TUISTYLE.SideButtonSize, CT.TUISTYLE.SideButtonSize);
		MT._TextureFunc.SetNormalTexture(ExportButton, CT.TTEXTURESET.EXPORT, nil, nil, CT.TTEXTURESET.CONTROL.NORMAL_COLOR);
		MT._TextureFunc.SetPushedTexture(ExportButton, CT.TTEXTURESET.EXPORT, nil, nil, CT.TTEXTURESET.CONTROL.PUSHED_COLOR);
		MT._TextureFunc.SetHighlightTexture(ExportButton, CT.TTEXTURESET.EXPORT, nil, nil, CT.TTEXTURESET.CONTROL.PUSHED_COLOR);
		ExportButton:SetPoint("BOTTOM", ImportButton, "TOP", 0, CT.TUISTYLE.SideButtonGap);
		ExportButton:Show();
		ExportButton:RegisterForClicks("LeftButtonUp", "RightButtonUp");
		ExportButton:SetScript("OnClick", MT._SideFunc.ExportButton_OnClick);
		ExportButton:SetScript("OnEnter", MT.GeneralOnEnter);
		ExportButton:SetScript("OnLeave", MT.GeneralOnLeave);
		ExportButton.Frame = Frame;
		ExportButton.information = l10n.ExportButton;
		Frame.ExportButton = ExportButton;

		local SaveButton = CreateFrame('BUTTON', nil, Frame.SideAnchorBottom);
		SaveButton:SetSize(CT.TUISTYLE.SideButtonSize, CT.TUISTYLE.SideButtonSize);
		MT._TextureFunc.SetNormalTexture(SaveButton, CT.TTEXTURESET.SAVE, nil, nil, CT.TTEXTURESET.CONTROL.NORMAL_COLOR);
		MT._TextureFunc.SetPushedTexture(SaveButton, CT.TTEXTURESET.SAVE, nil, nil, CT.TTEXTURESET.CONTROL.PUSHED_COLOR);
		MT._TextureFunc.SetHighlightTexture(SaveButton, CT.TTEXTURESET.SAVE, nil, nil, CT.TTEXTURESET.CONTROL.PUSHED_COLOR);
		SaveButton:SetPoint("BOTTOM", ExportButton, "TOP", 0, CT.TUISTYLE.SideButtonGap);
		SaveButton:Show();
		SaveButton:RegisterForClicks("LeftButtonUp", "RightButtonUp");
		SaveButton:SetScript("OnClick", MT._SideFunc.SaveButton_OnClick);
		SaveButton:SetScript("OnEnter", MT.GeneralOnEnter);
		SaveButton:SetScript("OnLeave", MT.GeneralOnLeave);
		SaveButton.Frame = Frame;
		SaveButton.information = l10n.SaveButton;
		Frame.SaveButton = SaveButton;

		local SendButton = CreateFrame('BUTTON', nil, Frame.SideAnchorBottom);
		SendButton:SetSize(CT.TUISTYLE.SideButtonSize, CT.TUISTYLE.SideButtonSize);
		MT._TextureFunc.SetNormalTexture(SendButton, CT.TTEXTURESET.SEND, nil, nil, CT.TTEXTURESET.CONTROL.NORMAL_COLOR);
		MT._TextureFunc.SetPushedTexture(SendButton, CT.TTEXTURESET.SEND, nil, nil, CT.TTEXTURESET.CONTROL.PUSHED_COLOR);
		MT._TextureFunc.SetHighlightTexture(SendButton, CT.TTEXTURESET.SEND, nil, nil, CT.TTEXTURESET.CONTROL.PUSHED_COLOR);
		SendButton:SetPoint("BOTTOM", SaveButton, "TOP", 0, CT.TUISTYLE.SideButtonGap);
		SendButton:Show();
		SendButton:RegisterForClicks("LeftButtonUp", "RightButtonUp");
		SendButton:SetScript("OnClick", MT._SideFunc.SendButton_OnClick);
		SendButton:SetScript("OnEnter", MT.GeneralOnEnter);
		SendButton:SetScript("OnLeave", MT.GeneralOnLeave);
		SendButton.Frame = Frame;
		SendButton.information = l10n.SendButton;
		Frame.SendButton = SendButton;
	end
	function MT.UI.CreateSideLeft(Frame)
		local objects = Frame.objects;

		local EquipmentFrameButton = CreateFrame('BUTTON', nil, Frame);
		EquipmentFrameButton:SetSize(CT.TUISTYLE.SideButtonSize, CT.TUISTYLE.SideButtonSize);
		MT._TextureFunc.SetNormalTexture(EquipmentFrameButton, CT.TTEXTURESET.EQUIPMENTTOGGLE, nil, nil, CT.TTEXTURESET.CONTROL.NORMAL_COLOR);
		MT._TextureFunc.SetPushedTexture(EquipmentFrameButton, CT.TTEXTURESET.EQUIPMENTTOGGLE, nil, nil, CT.TTEXTURESET.CONTROL.PUSHED_COLOR);
		MT._TextureFunc.SetHighlightTexture(EquipmentFrameButton, CT.TTEXTURESET.EQUIPMENTTOGGLE, nil, nil, CT.TTEXTURESET.CONTROL.PUSHED_COLOR);
		EquipmentFrameButton:SetPoint("BOTTOMRIGHT", Frame, "BOTTOMLEFT", -2, 0);
		EquipmentFrameButton:Hide();
		EquipmentFrameButton:SetScript("OnClick", MT._SideFunc.EquipmentFrameButton_OnClick);
		EquipmentFrameButton:SetScript("OnEnter", MT.GeneralOnEnter);
		EquipmentFrameButton:SetScript("OnLeave", MT.GeneralOnLeave);
		EquipmentFrameButton.information = l10n.EquipmentListButton;
		EquipmentFrameButton.Frame = Frame;
		Frame.objects.EquipmentFrameButton = EquipmentFrameButton;
	end
	function MT.UI.CreateSideObject(Frame)
		local objects = Frame.objects;

		local SideAnchorTop = CreateFrame('FRAME', nil, Frame);
		SideAnchorTop:SetWidth(1);
		Frame.SideAnchorTop = SideAnchorTop;
		SideAnchorTop:SetPoint("TOPLEFT", Frame, "TOPRIGHT", 2, 0);
		SideAnchorTop:SetPoint("BOTTOMLEFT", Frame, "BOTTOMRIGHT", 2, 0);

		local SideAnchorBottom = CreateFrame('FRAME', nil, Frame);
		SideAnchorBottom:SetWidth(1);
		Frame.SideAnchorBottom = SideAnchorBottom;
		SideAnchorBottom:SetPoint("TOPLEFT", Frame, "TOPRIGHT", 2, 0);
		SideAnchorBottom:SetPoint("BOTTOMLEFT", Frame, "BOTTOMRIGHT", 2, 0);

		MT.UI.CreateSideClass(Frame);
		MT.UI.CreateSideControl(Frame);
		MT.UI.CreateSideLeft(Frame);
	end
	function MT.UI.CreateFrameSubObject(Frame)
		local objects = {  };
		Frame.objects = objects;

		MT.UI.CreateHeaderObject(Frame);
		MT.UI.CreateFooterObject(Frame);
		MT.UI.CreateSideObject(Frame);
	end

-->
