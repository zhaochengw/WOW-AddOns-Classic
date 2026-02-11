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
	local select = select;
	local wipe = table.wipe;
	local strsub = string.sub;
	local strupper = string.upper;
	local strmatch = string.match;
	local format = string.format;
	local tostring = tostring;
	local tonumber = tonumber;
	local min = math.min;
	local max = math.max;
	local random = math.random;
	local GetItemInfo = GetItemInfo;
	local GetSpellInfo = GetSpellInfo;
	local GetSpecializationInfoByID = GetSpecializationInfoByID;				--	(id)	--	id, name, description, icon, role, class, loc-class
	local SetPortraitToTexture = SetPortraitToTexture;

-->
	local l10n = CT.l10n;

-->
MT.BuildEnv('UI-Method');
-->		predef
-->		Method
	function MT.UI.FrameSetName(Frame, name)				--	NAME CHANGED HERE ONLY	--	and MT.UI.FrameUpdateLabelText
		Frame.name = name;
		if name ~= nil then
			local cache = VT.TQueryCache[name];
			local objects = Frame.objects;
			objects.Name:SetText(name);
			if VT.__supreme and cache ~= nil and cache.PakData[1] ~= nil then
				local _, info = VT.__dep.__emulib.DecodeAddOnPackData(cache.PakData[1]);
				if info then
					objects.PackLabel:SetText(info);
					objects.PackLabel:Show();
				else
					objects.PackLabel:Hide();
				end
			else
				objects.PackLabel:Hide();
			end
			objects.ResetToEmuButton:Show();
			objects.ResetToSetButton:Hide();
			local ClassButtons = Frame.ClassButtons;
			for index = 1, #DT.IndexToClass do
				ClassButtons[index]:Hide();
			end
			objects.CurClassIndicator:Hide();
			local TreeFrame = Frame.TreeFrames[1];
			if name ~= l10n.message then
				MT.UI.FrameSetBinding(Frame, name);
				if cache == nil or cache.EquData.Tick == nil then
					Frame.objects.EquipmentFrameButton:Hide();
					Frame.EquipmentFrameContainer:Hide();
					MT.Debug("EquipFrame", "MT.UI.FrameSetName Hide");
				else
					Frame.objects.EquipmentFrameButton:Show();
				end
			else
				Frame.objects.EquipmentFrameButton:Hide();
				Frame.EquipmentFrameContainer:Hide();
				MT.Debug("EquipFrame", "MT.UI.FrameSetName Hide");
			end
		else
			local objects = Frame.objects;
			objects.Name:SetText(l10n.Emulator);
			objects.PackLabel:Hide();
			objects.ResetToEmuButton:Hide();
			objects.ResetToSetButton:Hide();
			local ClassButtons = Frame.ClassButtons;
			for index = 1, #DT.IndexToClass do
				ClassButtons[index]:Show();
			end
			objects.CurClassIndicator:Show();
			objects.CurClassIndicator:ClearAllPoints();
			objects.CurClassIndicator:SetPoint("CENTER", ClassButtons[DT.ClassToIndex[Frame.class]]);
			MT.UI.FrameReleaseBinding(Frame);
			Frame.objects.EquipmentFrameButton:Hide();
			Frame.EquipmentFrameContainer:Hide();
			MT.Debug("EquipFrame", "MT.UI.FrameSetName Hide");
		end
	end
	function MT.UI.FrameSetLevel(Frame, level)				--	LEVEL CHANGED HERE ONLY
		if level == nil then
			Frame.level = DT.MAX_LEVEL;
			Frame.TotalUsedPoints = 0;
			Frame.TotalAvailablePoints = MT.GetLevelAvailablePoints(Frame.class, DT.MAX_LEVEL);
		else
			if type(level) == 'string' then
				level = tonumber(level);
			end
			Frame.level = level;
			Frame.TotalAvailablePoints = MT.GetLevelAvailablePoints(Frame.class, level);
		end
	end
	function MT.UI.FrameSetClass(Frame, class)				--	CLASS CHANGED HERE ONLY
		if class == nil then
			Frame.class = nil;
			Frame.ClassTDB = nil;
			Frame.initialized = false;
			Frame.objects.Name:SetTextColor(1.0, 1.0, 1.0, 1.0);
			Frame.objects.Label:SetTextColor(1.0, 1.0, 1.0, 1.0);
		else
			--	check class value
				local Type = type(class);
				if Type == 'number' then
					if DT.IndexToClass[class] == nil then
						MT.Debug("MT.UI.FrameSetClass", 1, "class", "number", class);
						return false;
					end
					class = DT.IndexToClass[class];
				elseif Type == 'table' then
					class = class.class;
					Type = type(class);
					if Type == 'number' then
						if DT.IndexToClass[class] == nil then
							MT.Debug("MT.UI.FrameSetClass", 2, "class", "table", "number", class);
							return false;
						end
						class = DT.IndexToClass[class];
					elseif Type ~= 'string' then
						MT.Debug("MT.UI.FrameSetClass", 3, "class", "table", Type, class);
						return false;
					else
						class = strupper(class);
						if DT.ClassToIndex[class] == nil then
							MT.Debug("MT.UI.FrameSetClass", 4, "class", "table", "string", class);
							return false;
						end
					end
				elseif Type == 'string' then
					class = strupper(class);
					if DT.ClassToIndex[class] == nil then
						local index = tonumber(class);
						if index ~= nil then
							class = DT.IndexToClass[index];
							if class == nil then
								MT.Debug("MT.UI.FrameSetClass", 5, "class", "string", index);
								return false;
							end
						end
					end
				else
					MT.Debug("MT.UI.FrameSetClass", 6, "class", Type);
					return false;
				end
			--

			local SpecList = DT.ClassSpec[class];
			if SpecList == nil then
				MT.Debug("MT.UI.FrameSetClass", 7, class, "SpecList == nil");
				return false;
			end
			local ClassTDB = DT.TalentDB[class];
			if ClassTDB == nil then
				MT.Debug("MT.UI.FrameSetClass", 8, class, "ClassTDB == nil");
				return false;
			end

			local TreeButtons = Frame.TreeButtons;
			for SpecIndex = 1, #SpecList do
				local SpecID = SpecList[SpecIndex];

				local TreeButton = TreeButtons[SpecIndex];
				local _, name, _, icon = GetSpecializationInfoByID(SpecID);
				TreeButton.information = name or l10n.SPEC[0] .. " (" .. SpecIndex .. ")";
				TreeButton.Title:SetText(name or l10n.SPEC[0] .. " (" .. SpecIndex .. ")");
				local SpecIcon = icon or DT.TalentSpecIcon[SpecID] or CT.TEXTUREUNK;
				local TreeButton = TreeButtons[SpecIndex];
				if SpecIcon ~= nil then
					TreeButton:SetNormalTexture(SpecIcon);
					TreeButton:SetPushedTexture(SpecIcon);
					TreeButton:SetHighlightTexture(SpecIcon);
				else
					TreeButton:SetNormalTexture(CT.TTEXTURESET.UNK);
					TreeButton:SetPushedTexture(CT.TTEXTURESET.UNK);
					TreeButton:SetHighlightTexture(CT.TTEXTURESET.UNK);
				end
				-- TreeFrame.Background:SetTexture(DT.SpecBackground[SpecID]);
			end
			if #SpecList == 4 then
				TreeButtons[2]:ClearAllPoints();
				TreeButtons[2]:SetPoint("RIGHT", Frame.TreeButtonsBar, "CENTER", -CT.TUISTYLE.TreeButtonGap * 0.5, 0);
				TreeButtons[1]:SetPoint("RIGHT", TreeButtons[2], "LEFT", -CT.TUISTYLE.TreeButtonGap, 0);
				TreeButtons[3]:ClearAllPoints();
				TreeButtons[3]:SetPoint("LEFT", Frame.TreeButtonsBar, "CENTER", CT.TUISTYLE.TreeButtonGap * 0.5, 0);
				TreeButtons[4]:Show();
			else
				TreeButtons[2]:ClearAllPoints();
				TreeButtons[2]:SetPoint("CENTER", Frame.TreeButtonsBar, "CENTER", 0, 0);
				TreeButtons[1]:SetPoint("RIGHT", TreeButtons[2], "LEFT", -CT.TUISTYLE.TreeButtonXSize * 0.25 - CT.TUISTYLE.TreeButtonGap, 0);
				TreeButtons[3]:ClearAllPoints();
				TreeButtons[3]:SetPoint("LEFT", TreeButtons[2], "RIGHT", CT.TUISTYLE.TreeButtonXSize * 0.25 + CT.TUISTYLE.TreeButtonGap, 0);
				TreeButtons[4]:Hide();
			end

			local TreeFrame = Frame.TreeFrames[1];
			local TreeNodes = TreeFrame.TreeNodes;
			for TalentSeq = 1, #ClassTDB do
				local TalentDef = ClassTDB[TalentSeq];
				if TalentDef[1] ~= nil then
					local Node = TreeNodes[TalentDef[10]];
					Node.TalentSeq = TalentSeq;
					Node:Show();
					local name, _, texture = GetSpellInfo(TalentDef[8]);
					if name ~= nil then
						Node.Name:SetText(name);
					else
						Node.Name:SetText("");
					end
					if texture ~= nil then
						Node:SetNormalTexture(texture);
						Node:SetPushedTexture(texture);
						-- SetPortraitToTexture(Node:GetNormalTexture(), texture);
						-- SetPortraitToTexture(Node:GetPushedTexture(), texture);
					elseif TalentDef[9] ~= nil then
						Node:SetNormalTexture(TalentDef[9]);
						Node:SetPushedTexture(TalentDef[9]);
						-- SetPortraitToTexture(Node:GetNormalTexture(), TalentDef[9]);
						-- SetPortraitToTexture(Node:GetPushedTexture(), TalentDef[9]);
					else
						Node:SetNormalTexture(CT.TTEXTURESET.UNK);
						Node:SetPushedTexture(CT.TTEXTURESET.UNK);
						-- SetPortraitToTexture(Node:GetNormalTexture(), CT.TTEXTURESET.UNK);
						-- SetPortraitToTexture(Node:GetPushedTexture(), CT.TTEXTURESET.UNK);
					end

				end
			end

			local color = CT.RAID_CLASS_COLORS[class];
			Frame.objects.Name:SetTextColor(color.r, color.g, color.b, 1.0);
			Frame.objects.Label:SetTextColor(color.r, color.g, color.b, 1.0);
			Frame.Background:SetTexture(DT.ClassBackground[class][random(1, #DT.ClassBackground[class])]);

			MT.UI.TreeUpdate(Frame, 0);

			Frame.class = class;
			Frame.ClassTDB = ClassTDB;
			Frame.initialized = true;

			-- if CT.SELFCLASS == class then
			-- 	Frame.ApplyTalentsButton:Show();
			-- else
			-- 	Frame.ApplyTalentsButton:Hide();
			-- end

			MT.UI.SpellListFrameUpdate(Frame.SpellListFrame, class, MT.GetPointsReqLevel(class, Frame.TotalUsedPoints));
		end

		return true;
	end
	function MT.UI.FrameSetTalent(Frame, TalData, activeGroup)	--	TALENTDATA CHANGED HERE ONLY
		if TalData == nil or TalData == "" then
			Frame.TalData = nil;
			local Points = Frame.objects.Name.Points1;
			Frame.objects.Name:ClearAllPoints();
			Frame.objects.Name:SetPoint(Points[1], Points[2], Points[3], Points[4], Points[5]);
			Frame.label = nil;
			Frame.objects.Label:Hide();
			Frame.objects.ResetToSetButton:ClearAllPoints();
			Frame.objects.ResetToSetButton:SetPoint("LEFT", Frame.objects.Name, "RIGHT", 0, 0);
			Frame.objects.TalentGroupSelect:Hide();
		else
			--	check point value
				if not Frame.initialized then
					MT.Debug("MT.UI.FrameSetTalent", 1, "not initialized");
					return false;
				end
				if type(TalData) ~= 'table' then
					MT.Debug("MT.UI.FrameSetTalent", 2, type(TalData));
					return false;
				end
				if TalData[1] ~= "" and tonumber(TalData[1]) == nil then
					MT.Debug("MT.UI.FrameSetTalent", 3, TalData);
					return false;
				end
			--

			Frame.TalData = TalData;
			Frame.activeGroup = activeGroup or TalData.active or 1;

			local seldata = TalData[Frame.activeGroup];
			local TreeFrame = Frame.TreeFrames[1];

			MT.UI.TreeUpdate(Frame, tonumber(strsub(seldata, 1, 1)) or 0);

			for tier = 0, DT.MAX_NUM_TIER - 1 do
				local value = tonumber(strsub(seldata, tier + 2, tier + 2)) or 0;
				MT.UI.TreeNodeChangePoint(TreeFrame, tier, value);
			end

			if TalData.num > 1 then
				local Points = Frame.objects.Name.Points2;
				Frame.objects.Name:ClearAllPoints();
				Frame.objects.Name:SetPoint(Points[1], Points[2], Points[3], Points[4], Points[5]);
				local val = TalData[Frame.activeGroup];
				Frame.label = MT.GenerateTitle(Frame.class, val);
				Frame.objects.Label:SetText(Frame.label);
				Frame.objects.Label:Show();
				Frame.objects.ResetToSetButton:ClearAllPoints();
				Frame.objects.ResetToSetButton:SetPoint("LEFT", Frame.objects.Label, "RIGHT", 0, 0);
				Frame.objects.TalentGroupSelect:Show();
			else
				local Points = Frame.objects.Name.Points1;
				Frame.objects.Name:ClearAllPoints();
				Frame.objects.Name:SetPoint(Points[1], Points[2], Points[3], Points[4], Points[5]);
				Frame.label = nil;
				Frame.objects.Label:Hide();
				Frame.objects.ResetToSetButton:ClearAllPoints();
				Frame.objects.ResetToSetButton:SetPoint("LEFT", Frame.objects.Name, "RIGHT", 0, 0);
				Frame.objects.TalentGroupSelect:Hide();
			end
		end

		return true;
	end
	function MT.UI.FrameSetEditByRule(Frame, rule)			--	LOCKED CHANGED HERE ONLY
		rule = not not rule;
		if Frame.rule == rule then
			return;
		end
		Frame.rule = rule;
		--	all icons processed in 'SetClass'
		--	all icons but tie 1 processed in 'ChangePoint'
	end
	function MT.UI.FrameSetInfo(Frame, class, level, TalData, activeGroup, name, readOnly, rule)
		MT.UI.FrameReset(Frame, true, false, true);
		if not MT.UI.FrameSetClass(Frame, class) then
			Frame:Hide();
			return false;
		end
		if TalData ~= nil then
			MT.UI.FrameSetTalent(Frame, TalData, activeGroup);
		end
		MT.UI.FrameSetLevel(Frame, level);
		MT.UI.FrameSetEditByRule(Frame, rule);
		MT.UI.FrameSetName(Frame, name);

		return true;
	end
	function MT.UI.TreeNodeChangePoint(TreeFrame, tier, value)		--	POINTS CHANGED HERE ONLY
		local TreeNodes = TreeFrame.TreeNodes;
		for i = 1, 3 do
			local Node = TreeNodes[tier * DT.MAX_NUM_COL + i];
			if i == value then
				MT.UI.TreeNodeLight(Node);
			else
				MT.UI.TreeNodeUnlight(Node);
			end
		end
		local TalentSet = TreeFrame.TalentSet;
		TalentSet[tier + 1] = value;

		MT.UI.FrameUpdateLabelText(TreeFrame.Frame);
	end
	function MT.UI.FrameResetTalents(Frame)
		local TreeFrame = Frame.TreeFrames[1];
		local TalentSet = TreeFrame.TalentSet;
		for id = 1, DT.MAX_NUM_TALENTS do
			MT.UI.TreeNodeUnlight(TreeFrame.TreeNodes[id]);
		end
		for tier = 0, DT.MAX_NUM_TIER - 1 do
			TalentSet[tier + 1] = 0;
		end
	end
	function MT.UI.FrameReset(Frame, ResetData, ResetName, ResetSetting)
		if ResetData ~= false then
			local TreeFrame = Frame.TreeFrames[1];

			local TreeNodes = TreeFrame.TreeNodes;
			for id = 1, DT.MAX_NUM_TALENTS do
				MT.UI.TreeNodeUnlight(TreeNodes[id]);
			end

			local TalentSet = TreeFrame.TalentSet;
			for tier = 0, DT.MAX_NUM_TIER - 1 do
				TalentSet[tier + 1] = 0;
			end

			MT.UI.FrameSetClass(Frame, nil);
			MT.UI.FrameSetLevel(Frame, nil);
			MT.UI.FrameSetTalent(Frame, nil);
		end
		if ResetName ~= false then
			MT.UI.FrameSetName(Frame, nil);
		end
		if ResetSetting ~= false then
			MT.UI.FrameSetEditByRule(Frame, false);
		end

		MT.UI.FrameUpdateLabelText(Frame);

		Frame.initialized = false;
	end
	function MT.UI.FrameUpdateLabelText(Frame)
		local objects = Frame.objects;
		if Frame.name ~= nil and Frame.TalData ~= nil then
			if MT.GetFrameData(Frame) ~= Frame.TalData[Frame.activeGroup] then
				objects.ResetToSetButton:Show();
				if Frame.label ~= nil then
					objects.Label:SetText(Frame.label .. l10n.LabelPointsChanged);
				else
					objects.Name:SetText(Frame.name .. l10n.LabelPointsChanged);
				end
			else
				objects.ResetToSetButton:Hide();
				if Frame.label ~= nil then
					objects.Label:SetText(Frame.label);
				else
					objects.Name:SetText(Frame.name);
				end
			end
		end
	end
	function MT.UI.FrameSetStyle(Frame, style)
	end
	function MT.UI.TreeNodeLight(Node)
		Node:GetNormalTexture():SetVertexColor(CT.TTEXTURESET.ICON_LIGHT_COLOR[1], CT.TTEXTURESET.ICON_LIGHT_COLOR[2], CT.TTEXTURESET.ICON_LIGHT_COLOR[3], CT.TTEXTURESET.ICON_LIGHT_COLOR[4]);
		Node:GetPushedTexture():SetVertexColor(CT.TTEXTURESET.ICON_LIGHT_COLOR[1], CT.TTEXTURESET.ICON_LIGHT_COLOR[2], CT.TTEXTURESET.ICON_LIGHT_COLOR[3], CT.TTEXTURESET.ICON_LIGHT_COLOR[4]);
		Node.Name:SetTextColor(1.0, 1.0, 1.0, 1.0);
		Node.Border:SetColorTexture(1.0, 0.5, 0.25, 0.75);
	end
	function MT.UI.TreeNodeUnlight(Node)
		Node:GetNormalTexture():SetVertexColor(CT.TTEXTURESET.ICON_UNLIGHT_COLOR[1], CT.TTEXTURESET.ICON_UNLIGHT_COLOR[2], CT.TTEXTURESET.ICON_UNLIGHT_COLOR[3], CT.TTEXTURESET.ICON_UNLIGHT_COLOR[4]);
		Node:GetPushedTexture():SetVertexColor(CT.TTEXTURESET.ICON_UNLIGHT_COLOR[1], CT.TTEXTURESET.ICON_UNLIGHT_COLOR[2], CT.TTEXTURESET.ICON_UNLIGHT_COLOR[3], CT.TTEXTURESET.ICON_UNLIGHT_COLOR[4]);
		Node.Name:SetTextColor(0.75, 0.75, 0.75, 1.0);
		Node.Border:SetColorTexture(0.0, 0.0, 0.0, 1.0);
	end

	local function TooltipFrame_OnUpdate_Tooltip1(TooltipFrame, elasped)
		TooltipFrame.delay = TooltipFrame.delay - elasped;
		if TooltipFrame.delay > 0 then
			return;
		end
		TooltipFrame:SetScript("OnUpdate", nil);
		local Tooltip1 = TooltipFrame.Tooltip1;
		if Tooltip1:IsShown() then
			if TooltipFrame.WoWeuCN_TooltipsSetSpellTooltip ~= nil then
				TooltipFrame.WoWeuCN_TooltipsSetSpellTooltip(Tooltip1, Tooltip1.SpellID);
			end
			--Tooltip1:Show();
			TooltipFrame:SetWidth(Tooltip1:GetWidth());
			TooltipFrame:SetHeight(Tooltip1:GetHeight() + TooltipFrame.Tooltip1FooterRight:GetHeight());
			TooltipFrame:SetAlpha(1.0);
			Tooltip1:SetAlpha(1.0);
		else
			TooltipFrame:Hide();
		end
	end
	function MT.UI.TooltipFrameSetTalent(TooltipFrame, Node, SpellID)
		local Tooltip1 = TooltipFrame.Tooltip1;

		local Tooltip1FooterRight = TooltipFrame.Tooltip1FooterRight;

		TooltipFrame.OwnerFrame = Node.Parent.Frame;
		TooltipFrame:ClearAllPoints();
		TooltipFrame:SetPoint("BOTTOMRIGHT", Node, "TOPLEFT", -4, 4);
		TooltipFrame:Show();
		TooltipFrame:SetAlpha(0.0);
		Tooltip1:SetOwner(TooltipFrame, "ANCHOR_NONE");
		Tooltip1:SetPoint("TOPLEFT", TooltipFrame, "TOPLEFT", 0, 0);
		Tooltip1:SetSpellByID(SpellID);
		Tooltip1:SetAlpha(0.0);
		Tooltip1.SpellID = SpellID;
		Tooltip1FooterRight:Show();
		Tooltip1FooterRight:SetText(tostring(SpellID));

		TooltipFrame.delay = CT.TOOLTIP_UPDATE_DELAY;
		TooltipFrame:SetScript("OnUpdate", TooltipFrame_OnUpdate_Tooltip1);
	end
	function MT.UI.SetTooltip(Node)
		if Node.SpellID then
			MT.UI.TooltipFrameSetTalent(VT.TooltipFrame, Node, Node.SpellID);
		else
			local TalentDef = DT.TalentDB[Node.Parent.Frame.class][Node.TalentSeq];
			if TalentDef ~= nil then
				MT.UI.TooltipFrameSetTalent(VT.TooltipFrame, Node, TalentDef[8]);
			else
				MT.UI.HideTooltip(Node);
			end
		end
	end
	function MT.UI.HideTooltip(Node)
		local TooltipFrame = VT.TooltipFrame;
		TooltipFrame:Hide();
		TooltipFrame.Tooltip1:Hide();
	end
	function MT.UI.SpellListFrameUpdate(SpellListFrame, class, level)
		local list = SpellListFrame.list;
		wipe(list);
		local pos = 0;
		list.class = class;
		local showAll = SpellListFrame.ShowAllSpell:GetChecked();
		local search = SpellListFrame.SearchEdit:GetText();
		if search == "" then search = nil; end
		local TreeFrame = SpellListFrame.Frame.TreeFrames[1];
		local ClassSDB = DT.SpellDB[class];
		if ClassSDB ~= nil then
			for index = 1, #ClassSDB do
				local SpellDef = ClassSDB[index];
				if not SpellDef.talent or TreeFrame.TalentSet[SpellDef.requireIndex] > 0 then
					local NumLevel = #SpellDef;
					for Level = 1, NumLevel do
						local v = SpellDef[Level];
						if search == nil or strmatch(GetSpellInfo(v[2]), search) or strmatch(tostring(v[2]), search) then
							if v[1] <= level then
								if showAll then
									pos = pos + 1;
									list[pos] = v;
								elseif Level == NumLevel then
									pos = pos + 1;
									list[pos] = v;
								end
							else
								if not showAll then
									if Level > 1 then
										pos = pos + 1;
										list[pos] = SpellDef[Level - 1];
									end
								end
								break;
							end
						end
					end
				end
			end
			if not SpellListFrame.ScrollList:SetNumValue(#list) then
				SpellListFrame.ScrollList:Update();
			end
		end
	end
	function MT.UI.SpellListFrameToggle(Frame)
		local SpellListFrame, SpellListFrameContainer = Frame.SpellListFrame, Frame.SpellListFrameContainer;
		local SideAnchorTop = Frame.SideAnchorTop;
		local SideAnchorBottom = Frame.SideAnchorBottom;
		if SpellListFrameContainer:IsShown() then
			SpellListFrameContainer:Hide();
			SideAnchorTop:ClearAllPoints();
			SideAnchorTop:SetPoint("TOPLEFT", Frame, "TOPRIGHT", 2, 0);
			SideAnchorTop:SetPoint("BOTTOMLEFT", Frame, "BOTTOMRIGHT", 2, 0);
			SideAnchorBottom:ClearAllPoints();
			SideAnchorBottom:SetPoint("TOPLEFT", Frame, "TOPRIGHT", 2, 0);
			SideAnchorBottom:SetPoint("BOTTOMLEFT", Frame, "BOTTOMRIGHT", 2, 0);
		else
			SpellListFrameContainer:Show();
			MT.UI.SpellListFrameUpdate(SpellListFrame, Frame.class, MT.GetPointsReqLevel(Frame.class, Frame.TotalUsedPoints));
			SideAnchorTop:ClearAllPoints();
			SideAnchorTop:SetPoint("TOPLEFT", SpellListFrameContainer, "TOPRIGHT", 2, 0);
			SideAnchorTop:SetPoint("BOTTOMLEFT", SpellListFrameContainer, "BOTTOMRIGHT", 2, 0);
			SideAnchorBottom:ClearAllPoints();
			SideAnchorBottom:SetPoint("TOPLEFT", SpellListFrameContainer, "TOPRIGHT", 2, 0);
			SideAnchorBottom:SetPoint("BOTTOMLEFT", SpellListFrameContainer, "BOTTOMRIGHT", 2, 0);
		end
	end
	function MT.UI.EquipmentFrameContainerResize(EquipmentFrameContainer)
		local ObjectScale = EquipmentFrameContainer.Frame.ObjectScale;
		local EquipmentContainer = EquipmentFrameContainer.EquipmentContainer;
		local EquipmentNodes = EquipmentContainer.EquipmentNodes;
		local s = CT.TUISTYLE.EquipmentNodeXToBorder * 2 + CT.TUISTYLE.EquipmentNodeSize * 2 + CT.TUISTYLE.EquipmentNodeTextGap * 2 + 8;
		local v = CT.TUISTYLE.EquipmentFrameXSize - s;
		local L, R, B = CT.TUISTYLE.EquipmentNodeLayout.L, CT.TUISTYLE.EquipmentNodeLayout.R, CT.TUISTYLE.EquipmentNodeLayout.B;
		local n = min(#L, #R);
		local m = -1;
		for i = 1, n do
			local l = EquipmentNodes[L[i]];
			local r = EquipmentNodes[R[i]];
			m = max(m, l.Ench:GetWidth() + r.Ench:GetWidth(), l.Name:GetWidth() + r.Gem:GetWidth(), l.Gem:GetWidth() + r.Name:GetWidth());
		end
		m = min(m, CT.TUISTYLE.EquipmentFrameXMaxSize);
		if m > v then
			EquipmentContainer:SetWidth(m + s);
			EquipmentFrameContainer:SetWidth((m + s) * ObjectScale);
		else
			EquipmentContainer:SetWidth(CT.TUISTYLE.EquipmentFrameXSize);
			EquipmentFrameContainer:SetWidth(CT.TUISTYLE.EquipmentFrameXSize * ObjectScale);
		end
		EquipmentContainer:SetScale(ObjectScale);
		if VT.__support_glyph then
			EquipmentFrameContainer.GlyphContainer:SetScale(ObjectScale);
		end
	end
	local EquipmentFrameDelayUpdateList = {  };
	local function EquipmentFrameDelayUpdate()
		for EquipmentContainer, cache in next, EquipmentFrameDelayUpdateList do
			EquipmentFrameDelayUpdateList[EquipmentContainer] = nil;
			if EquipmentContainer.Frame:IsShown() then
				MT.UI.EquipmentContainerUpdate(EquipmentContainer, cache);
			end
		end
	end
	function MT.UI.EquipmentContainerUpdate(EquipmentContainer, cache)
		local EquData = cache.EquData;
		MT._TimerHalt(EquipmentFrameDelayUpdate);
		if EquData.AverageItemLevel_OKay then
			EquipmentContainer.AverageItemLevel:SetText(MT.ColorItemLevel(EquData.AverageItemLevel));
		else
			EquipmentContainer.AverageItemLevel:SetText(nil);
		end
		local recache = false;
		local EquipmentNodes = EquipmentContainer.EquipmentNodes;
		local SetInfo = {  };
		for slot = 0, 19 do
			local Node = EquipmentNodes[slot];
			local item = EquData[slot];
			Node.item = item;
			if item ~= nil then
				local name, link, quality, level, _, _, _, _, _, texture, _, _, _, _, _, setID = GetItemInfo(item);
				if link ~= nil then
					Node:SetNormalTexture(texture);
					local color = CT.ITEM_QUALITY_COLORS[quality];
					local r, g, b = color.r, color.g, color.b;
					Node.Glow:SetVertexColor(r, g, b);
					Node.Glow:Show();
					Node.ILvl:SetVertexColor(MT.GetItemLevelColor(level));
					Node.ILvl:SetText(level);
					Node.Name:SetVertexColor(r, g, b);
					Node.Name:SetText(name);
					local enchantable, enchanted, link, level, estr = MT.GetEnchantInfo(cache.class, slot, item);
					if enchantable then
						Node.Ench:SetText(enchanted and estr or l10n.EquipmentList_MissingEnchant);
					else
						Node.Ench:SetText("");
					end
					if VT.__support_gem then
						local A, T, M, R, Y, B, gstr = MT.ScanGemInfo(item, true);
						Node.Gem:SetText(gstr);
					end
					Node.link = link;
					if setID then
						SetInfo[setID] = (SetInfo[setID] or 0) + 1;
					end
				else
					Node:SetNormalTexture(CT.TTEXTURESET.EQUIPMENT.Empty[Node.slot]);
					Node.Glow:Hide();
					Node.ILvl:SetText("");
					Node.Name:SetText("");
					Node.Ench:SetText("");
					Node.Gem:SetText("");
					Node.link = nil;
					recache = true;
				end
			else
				Node:SetNormalTexture(CT.TTEXTURESET.EQUIPMENT.Empty[Node.slot]);
				Node.Glow:Hide();
				Node.ILvl:SetText("");
				Node.Name:SetText("");
				Node.Ench:SetText("");
				Node.Gem:SetText("");
				Node.link = nil;
			end
		end
		if recache then
			EquData.SetInfo = nil;
			EquipmentFrameDelayUpdateList[EquipmentContainer] = cache;
			MT._TimerStart(EquipmentFrameDelayUpdate, 0.5, 1);
		else
			EquData.SetInfo = SetInfo;
			for slot = 1, 18 do
				if EquData[slot] then
					MT.TouchItemTip(EquData[slot]);
				end
			end
		end
		MT.UI.EquipmentFrameContainerResize(EquipmentContainer.EquipmentFrameContainer);
	end
	function MT.UI.EngravingContainerUpdate(EquipmentContainer, cache)
		local EngData = cache.EngData;
		local EngravingNodes = EquipmentContainer.EngravingNodes;
		for slot = 0, 19 do
			local Node = EngravingNodes[slot];
			local info = EngData[slot];
			if info ~= nil and info[1] ~= nil then
				Node:Show();
				Node.id = info[1];
				Node:SetNormalTexture(info[2] or select(3, GetSpellInfo(info[1])) or CT.TTEXTURESET.ENGRAVING_UNK);
			else
				Node:Hide();
			end
		end
		MT.UI.EquipmentFrameContainerResize(EquipmentContainer.EquipmentFrameContainer);
	end
	function MT.UI.EquipmentFrameToggle(Frame)
		local EquipmentFrameContainer = Frame.EquipmentFrameContainer;
		if EquipmentFrameContainer:IsShown() then
			EquipmentFrameContainer:Hide();
		else
			EquipmentFrameContainer:Show();
		end
	end
	function MT.UI.GlyphContainerUpdate(GlyphContainer, GlyData)
		local activeGroup = GlyphContainer.Frame.activeGroup;
		local GlyphNodes = GlyphContainer.GlyphNodes;
		if GlyData ~= nil and GlyData[activeGroup] ~= nil then
			local data = GlyData[activeGroup];
			for index = 1, #GlyphNodes do
				local Node = GlyphNodes[index];
				local info = data[index];
				Node.info = info;
				if info ~= nil then
					Node.SpellID = info[3];
					Node.Texture = info[4];
					Node.Glyph:Show();
					Node.Glyph:SetTexture(info[4]);
					-- SetPortraitToTexture(Node.Glyph, info[4]);
					local def = Node.def;
					if CT.BUILD == "WRATH" then
						Node.Background:SetTexCoord(def[7], def[8], def[9], def[10]);
					end
				else
					Node.SpellID = nil;
					Node.Texture = nil;
					Node.Glyph:Hide();
					local d0 = Node.d0;
					if CT.BUILD == "WRATH" then
						Node.Background:SetTexCoord(d0[7], d0[8], d0[9], d0[10]);
					end
				end
			end
		else
			for index = 1, #GlyphNodes do
				local Node = GlyphNodes[index];
				Node.info = nil;
				Node.SpellID = nil;
				Node.Texture = nil;
				Node.Glyph:Hide();
				local d0 = Node.d0;
				if CT.BUILD == "WRATH" then
					Node.Background:SetTexCoord(d0[7], d0[8], d0[9], d0[10]);
				end
			end
		end
	end
	function MT.UI.TreeFrameUpdateSize(Frame, width, height)
		local TreeFrame = Frame.TreeFrames[1];
		local scale = min(
				(width) / (CT.TUISTYLE.TreeFrameXSizeSingle + CT.TUISTYLE.TreeFrameXToBorder * 2),
				(height - CT.TUISTYLE.FrameHeaderYSize - CT.TUISTYLE.FrameFooterYSize) / (CT.TUISTYLE.TreeFrameYSize + CT.TUISTYLE.TreeFrameYToBorder * 2 + Frame.SpecSpellFrame:GetHeight() + CT.TUISTYLE.SpecSpellFrameYToBorder * 2 + CT.TUISTYLE.TreeButtonsBarYSize)
			);
		TreeFrame:SetScale(scale);
		Frame.ObjectScale = scale;
	end
	function MT.UI.TreeUpdate(Frame, TreeIndex, force_update)
		if Frame.class == nil or DT.ClassSpec[Frame.class] == nil or TreeIndex <= 0 or TreeIndex > #DT.ClassSpec[Frame.class] then
			Frame.CurTreeIndex = 0;
			Frame.TreeButtonsBar.CurTreeIndicator:Hide();
			MT._SpecSpellFunc.SetSpellList(Frame.SpecSpellFrame, {  });
			return;
		end
		local TreeButtons = Frame.TreeButtons;
		if Frame.CurTreeIndex ~= TreeIndex or force_update then
			Frame.CurTreeIndex = TreeIndex;
			local CurTreeIndicator = Frame.TreeButtonsBar.CurTreeIndicator;
			CurTreeIndicator:Show();
			CurTreeIndicator:ClearAllPoints();
			CurTreeIndicator:SetPoint("CENTER", TreeButtons[TreeIndex]);
			--	CurTreeIndicator:SetScale(1.5);
			--	for i = 1, 3 do
			--		if i == TreeIndex then
			--			TreeButtons[i]:SetSize(CT.TUISTYLE.TreeButtonXSize * 1.28, CT.TUISTYLE.TreeButtonYSize * 1.28);
			--		else
			--			TreeButtons[i]:SetSize(CT.TUISTYLE.TreeButtonXSize * 0.86, CT.TUISTYLE.TreeButtonYSize * 0.86);
			--		end
			--	end
		end
		local SpecList = DT.ClassSpec[Frame.class];
		local SpecID = SpecList[TreeIndex];
		if SpecID and DT.SPEC_SPELLS_DISPLAY[SpecID] then
			MT._SpecSpellFunc.SetSpellList(Frame.SpecSpellFrame, DT.SPEC_SPELLS_DISPLAY[SpecID]);
		else
			MT._SpecSpellFunc.SetSpellList(Frame.SpecSpellFrame, {  });
		end
		MT.UI.FrameUpdateLabelText(Frame);
	end

-->
