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
	local floor = math.floor;
	local random = math.random;
	local GetItemInfo = GetItemInfo;
	local GetSpellInfo = GetSpellInfo;
	local GetMouseFocus = VT._comptb.GetMouseFocus;
	local SetPortraitToTexture = SetPortraitToTexture;
	local UIParent = UIParent;

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
			local TreeFrames = Frame.TreeFrames;
			for TreeIndex = 1, #TreeFrames do
				wipe(TreeFrames[TreeIndex].TalentChanged);
			end
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
		MT.UI.FrameUpdateFooterText(Frame);
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
			local TreeFrames = Frame.TreeFrames;
			local TreeButtons = Frame.TreeButtons;
			for TreeIndex = 1, #SpecList do
				local TreeFrame = TreeFrames[TreeIndex];
				local TreeNodes = TreeFrame.TreeNodes;
				local SpecID = SpecList[TreeIndex];
				local TreeTDB = ClassTDB[SpecID];
				TreeFrame.SpecID = SpecID;

				local SpecTexture = DT.TalentSpecIcon[SpecID];
				local TreeButton = TreeButtons[TreeIndex];
				if SpecTexture ~= nil then
					TreeButton:SetNormalTexture(SpecTexture);
					TreeButton:SetPushedTexture(SpecTexture);
					TreeButton:SetHighlightTexture(SpecTexture);
					TreeButton.information = l10n.SPEC[SpecID];
					TreeButton.Title:SetText(l10n.SPEC[SpecID]);
				else
					TreeButton:SetNormalTexture(CT.TTEXTURESET.UNK);
					TreeButton:SetPushedTexture(CT.TTEXTURESET.UNK);
					TreeButton:SetHighlightTexture(CT.TTEXTURESET.UNK);
				end
				TreeFrame.Background:SetTexture(DT.SpecBackground[SpecID]);
				TreeFrame.TreeLabel:SetText(l10n.SPEC[SpecID]);
				-- TreeFrame.TreeLabelBackground:SetTexture(SpecTexture);
				SetPortraitToTexture(TreeFrame.TreeLabelBackground, SpecTexture)
				for TalentSeq = 1, #TreeTDB do
					local TalentDef = TreeTDB[TalentSeq];
					if TalentDef[1] ~= nil then
						local Node = TreeNodes[TalentDef[10]];
						Node.TalentSeq = TalentSeq;
						Node:Show();
						local _, _, texture = GetSpellInfo(TalentDef[8][1]);
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
						Node.MaxVal:SetText(TalentDef[4]);
						Node.CurVal:SetText("0");

						local DepTSeq = TalentDef[11];
						if DepTSeq ~= nil then
							local Arrow = MT.UI.DependArrowGet(TreeFrame);
							MT.UI.DependArrowSet(Arrow, TalentDef[1] - TalentDef[5], TalentDef[2] - TalentDef[6], false, Node, TreeNodes[TreeTDB[DepTSeq][10]]);
							local DepArrows = TreeFrame.NodeDependArrows[DepTSeq];
							DepArrows[#DepArrows + 1] = Arrow;
						end

						if TalentDef[1] == 0 then
							if TalentDef[5] == nil then
								MT.UI.TreeNodeActivate(Node);
							end
						end
					end
				end
				TreeFrame.TreeTDB = TreeTDB;
			end

			local color = CT.RAID_CLASS_COLORS[class];
			Frame.objects.Name:SetTextColor(color.r, color.g, color.b, 1.0);
			Frame.objects.Label:SetTextColor(color.r, color.g, color.b, 1.0);
			Frame.Background:SetTexture(DT.ClassBackground[class][random(1, #DT.ClassBackground[class])]);

			Frame.class = class;
			Frame.ClassTDB = ClassTDB;
			Frame.initialized = true;

			if CT.SELFCLASS == class then
				Frame.ApplyTalentsButton:Show();
			else
				Frame.ApplyTalentsButton:Hide();
			end

			MT.UI.SpellListFrameUpdate(Frame.SpellListFrame, class, MT.GetPointsReqLevel(class, Frame.TotalUsedPoints));
			MT.UI.FrameUpdateFooterText(Frame);
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
			local TreeFrames = Frame.TreeFrames;
			local len = #seldata;
			local pos = 1;

			local sum = { 0, 0, 0, };
			for TreeIndex = 1, 3 do
				if pos > len then
					break;
				end
				local TreeFrame = TreeFrames[TreeIndex];
				local TreeTDB = TreeFrame.TreeTDB;
				for TalentSeq = 1, #TreeTDB do
					if pos > len then
						break;
					end
					local TalentDef = TreeTDB[TalentSeq];
					if TalentDef[1] ~= nil then
						local val = strsub(seldata, pos, pos);
						val = tonumber(val);
						sum[TreeIndex] = sum[TreeIndex] + val;
					end
					pos = pos + 1;
				end
			end
			-- local primaryTreeIndex = nil;
			local TreeSeq = nil;
			local TreeOffset = nil;
			local o1, o2 = #TreeFrames[1].TreeTDB, #TreeFrames[2].TreeTDB;
			if CT.TOCVERSION >= 40000 and (sum[1] > 0 or sum[2] > 0 or sum[3] > 0) then
				if sum[1] >= sum[2] then
					if sum[1] >= sum[3] then
						-- primaryTreeIndex = 1;
						TreeSeq = { 1, 2, 3, };
						TreeOffset = { 0, o1, o1 + o2, };
					else
						-- primaryTreeIndex = 3
						TreeSeq = { 3, 1, 2, };
						TreeOffset = { o1 + o2, 0, o1, };
					end
				else
					if sum[2] >= sum[3] then
						-- primaryTreeIndex = 2;
						TreeSeq = { 2, 1, 3, };
						TreeOffset = { o1, 0, o1 + o2, };
					else
						-- primaryTreeIndex = 3;
						TreeSeq = { 3, 1, 2, };
						TreeOffset = { o1 + o2, 0, o1, };
					end
				end
			else
				TreeSeq = { 1, 2, 3, };
				TreeOffset = { 0, o1, o1 + o2, };
			end

			for i = 1, 3 do
				local TreeIndex = TreeSeq[i];
				local offset = TreeOffset[i];
				pos = offset + 1;
				if pos > len then
					break;
				end
				local TreeFrame = TreeFrames[TreeIndex];
				local TreeNodes = TreeFrame.TreeNodes;
				local TreeTDB = TreeFrame.TreeTDB;
				local TalentSet = TreeFrame.TalentSet;
				for TalentSeq = 1, #TreeTDB do
					if pos > len then
						break;
					end
					local TalentDef = TreeTDB[TalentSeq];
					if TalentDef[1] ~= nil then
						local val = strsub(seldata, pos, pos);
						val = tonumber(val);
						if val ~= 0 then
							local DepTSeq = TalentDef[11];
							if DepTSeq ~= nil and DepTSeq <= len then
								local depval = strsub(seldata, offset + DepTSeq, offset + DepTSeq);
								if depval ~= "0" then
									depval = tonumber(depval);
									local deppts = depval - TalentSet[DepTSeq];
									if deppts > 0 then
										MT.UI.TreeNodeChangePoint(TreeNodes[TreeTDB[DepTSeq][10]], deppts);
									end
								end
							end
							local pts = val - TalentSet[TalentSeq];
							if pts > 0 then
								local ret = MT.UI.TreeNodeChangePoint(TreeNodes[TalentDef[10]], pts);
								if ret < 0 then
									MT.Debug("MT.UI.FrameSetTalent", 4, ret, "tab", TreeIndex, "tier", TalentDef[1], "col", TalentDef[2], "maxPoints", TalentDef[4], "set", val, TalentDef, pos);
								elseif ret > 0 then
									MT.Debug("MT.UI.FrameSetTalent", 5, ret, "tab", TreeIndex, "tier", TalentDef[1], "col", TalentDef[2], "maxPoints", TalentDef[4], "set", val, TalentDef, pos);
								end
							end
						end
					end
					pos = pos + 1;
				end
			end

			if TalData.num > 1 then
				local Points = Frame.objects.Name.Points2;
				Frame.objects.Name:ClearAllPoints();
				Frame.objects.Name:SetPoint(Points[1], Points[2], Points[3], Points[4], Points[5]);
				local val = TalData[Frame.activeGroup];
				local stats = MT.CountTreePoints(val, Frame.class);
				Frame.label = stats[1] .. "-" .. stats[2] .. "-" .. stats[3];
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
		local TreeFrames = Frame.TreeFrames;
		if rule then
			for TreeIndex = 1, 3 do
				local TreeFrame = TreeFrames[TreeIndex];
				local TreeNodes = TreeFrame.TreeNodes;
				local TalentSet = TreeFrame.TalentSet;
				local TreeTDB = TreeFrame.TreeTDB;
				for TalentSeq = 1, #TreeTDB do
					if TalentSet[TalentSeq] == 0 then
						local TalentDef = TreeTDB[TalentSeq];
						if TalentDef[1] ~= nil then
							MT.UI.TreeNodeSetTextColorUnavailable(TreeNodes[TalentDef[10]]);
						end
					end
				end
			end
		else
			for TreeIndex = 1, 3 do
				local TreeFrame = TreeFrames[TreeIndex];
				local TreeNodes = TreeFrame.TreeNodes;
				local TreeTDB = TreeFrame.TreeTDB;
				for TalentSeq = 1, #TreeTDB do
					local TalentDef = TreeTDB[TalentSeq];
					if TalentDef[1] ~= nil and TalentDef[1] == 0 then
						if TalentDef[5] == nil then
							MT.UI.TreeNodeSetTextColorAvailable(TreeNodes[TalentDef[10]]);
						end
					else
						break;
					end
				end
			end
			MT.UI.FrameResetTalents(Frame);
		end
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
	function MT.UI.TreeNodeChangePoint(Node, numPoints)		--	POINTS CHANGED HERE ONLY
		if not Node.active then
			return -1;
		end
		local TreeFrame = Node.Parent;
		local Frame = TreeFrame.Frame;
		if Frame.readOnly then
			return -1;
		end
		if numPoints == 0 then
			return 1;
		elseif numPoints > 0 then	--	caps to available points
			local remainingPoints = Frame.TotalAvailablePoints - Frame.TotalUsedPoints;
			if remainingPoints <= 0 then
				return 2;
			elseif remainingPoints < numPoints then
				numPoints = remainingPoints;
			end
		end

		local TalentSet = TreeFrame.TalentSet;
		local TreeTDB = TreeFrame.TreeTDB;
		local TalentSeq = Node.TalentSeq;
		local TalentDef = TreeTDB[TalentSeq];	--	没必要验证，因为无效定义没有按钮

		if (numPoints > 0 and TalentSet[TalentSeq] == TalentDef[4]) or (numPoints < 0 and TalentSet[TalentSeq] == 0) then	--	increased from max_rank OR decreased from min_rank
			return 2;
		end

		if Node.free_edit then
			local ret = 0;

			if TalentSet[TalentSeq] + numPoints >= TalentDef[4] then
				if TalentSet[TalentSeq] + numPoints > TalentDef[4] then
					ret = 4;
				end
				numPoints = TalentDef[4] - TalentSet[TalentSeq];
				TalentSet[TalentSeq] = TalentDef[4];
				MT.UI.TreeNodeSetTextColorMaxRank(Node);
				MT.UI.TreeNodeLight(Node);
			elseif TalentSet[TalentSeq] + numPoints <= 0 then
				if TalentSet[TalentSeq] + numPoints < 0 then
					ret = 5;
				end
				numPoints = -TalentSet[TalentSeq];
				TalentSet[TalentSeq] = 0;
				MT.UI.TreeNodeUnlight(Node);
				MT.UI.TreeNodeSetTextColorUnavailable(Node);
			else
				TalentSet[TalentSeq] = TalentSet[TalentSeq] + numPoints;
				MT.UI.TreeNodeSetTextColorAvailable(Node);
				if numPoints > 0 then
					MT.UI.TreeNodeLight(Node);
					MT.UI.TreeNodeSetTextColorAvailable(Node);
				end
			end
			Node.CurVal:SetText(TalentSet[TalentSeq]);

			return ret;
		else
			local tier = TalentDef[1];
			local depby = TalentDef[12];
			if numPoints < 0 then	--	whether it can be decreased
				if depby ~= nil then		--	depended on by other
					for i = 1, #depby do
						if TalentSet[depby[i]] > 0 then
							return 3;
						end
					end
				end
				if TalentSet.TopCheckedTier >= tier + 1 then
					local numPointsLowerTier = 0;
					for i = 0, tier do
						numPointsLowerTier = numPointsLowerTier + TalentSet.CountByTier[i];
					end
					for i = tier + 1, TalentSet.TopCheckedTier do
						numPoints = max(numPoints, i * CT.NUM_POINTS_NEXT_TIER - numPointsLowerTier);
						if numPoints == 0 then
							return 3;
						end
						numPointsLowerTier = numPointsLowerTier + TalentSet.CountByTier[i];
					end
				end
				if CT.TOCVERSION >= 40000 then
					if TalentSet.Total >= DT.PointsNeeded4SecondaryTree then
						local secondary = false;
						local TreeFrames = Frame.TreeFrames;
						for TreeIndex = 1, 3 do
							local TFrame = TreeFrames[TreeIndex];
							if TFrame ~= TreeFrame and TFrame.TalentSet.Total > 0 then
								secondary = true;
								break;
							end
						end
						if secondary and TalentSet.Total + numPoints < DT.PointsNeeded4SecondaryTree then
							numPoints = DT.PointsNeeded4SecondaryTree - TalentSet.Total;
							if numPoints == 0 then
								return 3;
							end
						end
					end
				end
			end

			local ret = 0;

			if TalentSet[TalentSeq] + numPoints >= TalentDef[4] then
				if TalentSet[TalentSeq] + numPoints > TalentDef[4] then
					ret = 4;
				end
				numPoints = TalentDef[4] - TalentSet[TalentSeq];
				TalentSet[TalentSeq] = TalentDef[4];
				MT.UI.TreeNodeSetTextColorMaxRank(Node);
				MT.UI.TreeNodeLight(Node);
				if depby ~= nil then
					for i = 1, #depby do
						MT.UI.TreeNodeActivate_RecheckPoint(TreeFrame.TreeNodes[TreeTDB[depby[i]][10]]);
					end
					local Arrows = TreeFrame.NodeDependArrows[TalentSeq];
					for i = 1, #Arrows do
						MT.UI.DependArrowSetTexCoord(Arrows[i], true);
					end
				end
			elseif TalentSet[TalentSeq] + numPoints <= 0 then
				if TalentSet[TalentSeq] + numPoints < 0 then
					ret = 5;
				end
				numPoints = -TalentSet[TalentSeq];
				TalentSet[TalentSeq] = 0;
				MT.UI.TreeNodeUnlight(Node);
				MT.UI.TreeNodeSetTextColorAvailable(Node);
			else
				TalentSet[TalentSeq] = TalentSet[TalentSeq] + numPoints;
				MT.UI.TreeNodeSetTextColorAvailable(Node);
				if numPoints > 0 then
					MT.UI.TreeNodeLight(Node);
				end
			end
			Node.CurVal:SetText(TalentSet[TalentSeq]);

			if numPoints < 0 and depby ~= nil then	--	deactive talents that depend on this
				for i = 1, #depby do
					MT.UI.TreeNodeDeactive(TreeFrame.TreeNodes[TreeTDB[depby[i]][10]]);
				end
				local Arrows = TreeFrame.NodeDependArrows[TalentSeq];
				for i = 1, #Arrows do
					MT.UI.DependArrowSetTexCoord(Arrows[i], false);
				end
			end

			if CT.TOCVERSION >= 40000 then
				if TalentSet.Total >= DT.PointsNeeded4SecondaryTree then
					if numPoints < 0 and TalentSet.Total + numPoints < DT.PointsNeeded4SecondaryTree then
						local TreeFrames = Frame.TreeFrames;
						for TreeIndex = 1, 3 do
							local TFrame = TreeFrames[TreeIndex];
							if TFrame ~= TreeFrame then
								MT.UI.TreeNodesDeactiveTier(TFrame.TreeNodes, 0);
							end
						end
					end
				elseif TalentSet.Total + numPoints >= DT.PointsNeeded4SecondaryTree then
						local TreeFrames = Frame.TreeFrames;
						for TreeIndex = 1, 3 do
							local TFrame = TreeFrames[TreeIndex];
							if TFrame ~= TreeFrame then
								MT.UI.TreeNodesActivateTier(TFrame.TreeNodes, 0);
							end
						end
				elseif TalentSet.Total > 0 then
					if TalentSet.Total + numPoints <= 0 then
						local TreeFrames = Frame.TreeFrames;
						for TreeIndex = 1, 3 do
							local TFrame = TreeFrames[TreeIndex];
							if TFrame ~= TreeFrame then
								MT.UI.TreeNodesActivateTier(TFrame.TreeNodes, 0);
							end
						end
					end
				elseif TalentSet.Total == 0 then
					if numPoints > 0 then
						local TreeFrames = Frame.TreeFrames;
						local isPrimary = true;
						for TreeIndex = 1, 3 do
							local TFrame = TreeFrames[TreeIndex];
							if TFrame ~= TreeFrame and TFrame.TalentSet.Total > 0 then
								isPrimary = false;
								break;
							end
						end
						if isPrimary then
						for TreeIndex = 1, 3 do
							local TFrame = TreeFrames[TreeIndex];
							if TFrame ~= TreeFrame then
								MT.UI.TreeNodesDeactiveTier(TFrame.TreeNodes, 0);
							end
						end
						end
					end
				end
			end
			--	CountByTier			index begin from 0
			--	TopAvailableTier	begin from 0
			--	TopCheckedTier		begin from 0
			TalentSet.Total = TalentSet.Total + numPoints;
			TreeFrame.TreePoints:SetText(TalentSet.Total);
			TalentSet.CountByTier[TalentDef[1]] = TalentSet.CountByTier[TalentDef[1]] + numPoints;

			local TopAvailableTier = min(floor(TalentSet.Total / CT.NUM_POINTS_NEXT_TIER), DT.MAX_NUM_TIER - 1);
			if TopAvailableTier > TalentSet.TopAvailableTier then
				MT.UI.TreeNodesActivateTier(TreeFrame.TreeNodes, TopAvailableTier);
				TalentSet.TopAvailableTier = TopAvailableTier;
			elseif TopAvailableTier < TalentSet.TopAvailableTier then
				MT.UI.TreeNodesDeactiveTier(TreeFrame.TreeNodes, TalentSet.TopAvailableTier);
				TalentSet.TopAvailableTier = TopAvailableTier;
			end

			if numPoints < 0 then
				if Frame.TotalAvailablePoints == Frame.TotalUsedPoints then
					MT.UI.FrameHasRemainingPoints(Frame);
				end
				Frame.TotalUsedPoints = Frame.TotalUsedPoints + numPoints;
			else
				Frame.TotalUsedPoints = Frame.TotalUsedPoints + numPoints;
				if Frame.TotalAvailablePoints == Frame.TotalUsedPoints then
					MT.UI.FrameNoRemainingPoints(Frame);
				end
			end

			TalentSet.TopCheckedTier = 0;
			for i = TopAvailableTier, 0, -1 do
				if TalentSet.CountByTier[i] > 0 then
					TalentSet.TopCheckedTier = i;
					break;
				end
			end
			--	if TalentSet.CountByTier[TalentSet.TopAvailableTier] == 0 then
			--		TalentSet.TopCheckedTier = TalentSet.TopAvailableTier - 1;
			--	else
			--		TalentSet.TopCheckedTier = TalentSet.TopAvailableTier;
			--	end

			if Frame.name ~= nil then
				local TalentChanged = TreeFrame.TalentChanged;
				if TalentChanged[TalentSeq] ~= nil then
					TalentChanged[TalentSeq] = TalentChanged[TalentSeq] + numPoints;
					if TalentChanged[TalentSeq] == 0 then
						TalentChanged[TalentSeq] = nil;
					end
				else
					TalentChanged[TalentSeq] = numPoints;
				end
			end

			MT.UI.SpellListFrameUpdate(Frame.SpellListFrame, Frame.class, MT.GetPointsReqLevel(Frame.class, Frame.TotalUsedPoints));

			local EditBox = Frame.EditBox;
			if EditBox.type == "save" and not EditBox.charChanged then
				EditBox:SetText(MT.GenerateTitleFromRawData(Frame));
			end

			MT.UI.FrameUpdateLabelText(Frame);
			if GetMouseFocus() == Node then
				MT.UI.TooltipFrameSetTalent(VT.TooltipFrame, Node, TreeFrame.SpecID, TalentDef[1] * 5, TreeFrame.TalentSet.Total, TalentDef[8], TalentSet[TalentSeq], TalentDef[4])
			end

			return ret;
		end
	end
	function MT.UI.TreeFrameResetTalentDependTree(TreeFrame, TalentSeq)
		local TalentSet = TreeFrame.TalentSet;
		local TreeTDB = TreeFrame.TreeTDB;
		if TalentSet[TalentSeq] > 0 then
			local depby = TreeTDB[TalentSeq][12];
			if depby then
				for index = 1, #depby do
					MT.UI.TreeFrameResetTalentDependTree(TreeFrame, depby[index]);
				end
			end
			MT.UI.TreeNodeChangePoint(TreeFrame.TreeNodes[TreeTDB[TalentSeq][10]], -TalentSet[TalentSeq]);
		end
	end
	function MT.UI.TreeFrameResetTalents(TreeFrame)
		local TreeTDB = TreeFrame.TreeTDB;
		for TalentSeq = #TreeTDB, 1, -1 do
			MT.UI.TreeFrameResetTalentDependTree(TreeFrame, TalentSeq);
		end
	end
	function MT.UI.FrameResetTalents(Frame)
		local TreeFrames = Frame.TreeFrames;
		for TreeIndex = 1, 3 do
			local TreeFrame = TreeFrames[TreeIndex];
			MT.UI.TreeFrameResetTalents(TreeFrame);
		end
	end
	function MT.UI.FrameReset(Frame, ResetData, ResetName, ResetSetting)
		if ResetData ~= false then
			local TreeFrames = Frame.TreeFrames;
			for TreeIndex = 1, 3 do
				local TreeFrame = TreeFrames[TreeIndex];

				local TreeNodes = TreeFrame.TreeNodes;
				for i = 1, DT.MAX_NUM_TALENTS do
					TreeNodes[i]:Hide();
					TreeNodes[i].TalentSeq = nil;
					MT.UI.TreeNodeDeactive(TreeNodes[i]);
				end

				local TalentSet = TreeFrame.TalentSet;
				for i = 1, DT.MAX_NUM_TALENTS do
					TalentSet[i] = 0;
				end
				for Tier = 0, DT.MAX_NUM_TIER do
					TalentSet.CountByTier[Tier] = 0;
				end
				TalentSet.Total = 0;
				TalentSet.TopAvailableTier = 0;
				TalentSet.TopCheckedTier = 0;

				for i = 1, DT.MAX_NUM_TALENTS do
					wipe(TreeFrame.NodeDependArrows[i]);
				end

				local DependArrows = TreeFrame.DependArrows;
				for i = 1, #DependArrows do
					DependArrows[i]:Hide();
					DependArrows[i]:ClearAllPoints();
					DependArrows[i].Branch1:Hide();
					DependArrows[i].Branch1:ClearAllPoints();
					DependArrows[i].Corner:Hide();
					DependArrows[i].Branch2:Hide();
					DependArrows[i].Branch2:ClearAllPoints();
				end
				DependArrows.used = 0;

				TreeFrame.TreePoints:SetText("0");
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
	function MT.UI.FrameNoRemainingPoints(Frame)
		local TreeFrames = Frame.TreeFrames;
		for TreeIndex = 1, 3 do
			local TreeFrame = TreeFrames[TreeIndex];
			local TreeTDB = TreeFrame.TreeTDB;
			local TalentSet = TreeFrame.TalentSet;
			local TreeNodes = TreeFrame.TreeNodes;
			for TalentSeq = 1, #TreeTDB do
				local TalentDef = TreeTDB[TalentSeq];
				if TalentDef[1] ~= nil and TalentDef[4] ~= TalentSet[TalentSeq] then
					MT.UI.TreeNodeSetTextColorUnavailable(TreeNodes[MT.GetTreeNodeIndex(TalentDef)]);
				end
			end
		end
	end
	function MT.UI.FrameHasRemainingPoints(Frame)
		local TreeFrames = Frame.TreeFrames;
		for TreeIndex = 1, 3 do
			local TreeFrame = TreeFrames[TreeIndex];
			local TreeTDB = TreeFrame.TreeTDB;
			local TalentSet = TreeFrame.TalentSet;
			local TreeNodes = TreeFrame.TreeNodes;
			for TalentSeq = 1, #TreeTDB do
				local TalentDef = TreeTDB[TalentSeq];
				if TalentDef[1] ~= nil then
					if TalentDef[4] == TalentSet[TalentSeq] then
						--	MT.UI.TreeNodeSetTextColorMaxRank(TreeNodes[MT.GetTreeNodeIndex(TalentDef)]);
					elseif TalentSet[TalentSeq] > 0 or TalentDef[1] == 0 then
						MT.UI.TreeNodeSetTextColorAvailable(TreeNodes[MT.GetTreeNodeIndex(TalentDef)]);
					else
						local numPointsLowerTier = 0;
						for j = 0, TalentDef[1] - 1 do
							numPointsLowerTier = numPointsLowerTier + TalentSet.CountByTier[j];
						end
						if numPointsLowerTier >= TalentDef[1] * CT.NUM_POINTS_NEXT_TIER then
							MT.UI.TreeNodeActivate_RecheckReq(TreeNodes[MT.GetTreeNodeIndex(TalentDef)]);
						end
					end
				end
			end
		end
	end
	function MT.UI.FrameUpdateLabelText(Frame)
		local objects = Frame.objects;
		if Frame.name ~= nil then
			local should_show = false;
			for TreeIndex = 1, 3 do
				local TreeFrame = Frame.TreeFrames[TreeIndex];
				local TalentChanged = TreeFrame.TalentChanged;
				local TreeTDB = TreeFrame.TreeTDB;
				for TalentSeq = 1, #TreeTDB do
					if TalentChanged[TalentSeq] then
						should_show = true;
						break;
					end
				end
			end
			if should_show then
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
		MT.UI.FrameUpdateFooterText(Frame);
	end
	function MT.UI.FrameUpdateFooterText(Frame)
		local objects = Frame.objects;
		objects.PointsUsed:SetText(Frame.TotalUsedPoints);
		objects.PointsToLevel:SetText(MT.GetPointsReqLevel(Frame.class, Frame.TotalUsedPoints));
		objects.PointsRemaining:SetText(MT.GetLevelAvailablePoints(Frame.class, Frame.level) - Frame.TotalUsedPoints);
	end
	function MT.UI.FrameSetStyle(Frame, style)
		local TreeFrames = Frame.TreeFrames;
		if Frame.style ~= style then
			Frame.style = style;
			if style == 1 then
				TreeFrames[1]:Show();
				TreeFrames[2]:Show();
				TreeFrames[3]:Show();
				TreeFrames[2]:ClearAllPoints();
				TreeFrames[2]:SetPoint("TOP", Frame, "TOP", 0, -CT.TUISTYLE.TreeFrameYToBorder - CT.TUISTYLE.FrameHeaderYSize);
				TreeFrames[1]:ClearAllPoints();
				TreeFrames[1]:SetPoint("TOPRIGHT", TreeFrames[2], "TOPLEFT");
				TreeFrames[1]:SetPoint("BOTTOMRIGHT", TreeFrames[2], "BOTTOMLEFT");
				TreeFrames[3]:ClearAllPoints();
				TreeFrames[3]:SetPoint("TOPLEFT", TreeFrames[2], "TOPRIGHT");
				TreeFrames[3]:SetPoint("BOTTOMLEFT", TreeFrames[2], "BOTTOMRIGHT");
				TreeFrames[1].TreeLabel:Show();
				TreeFrames[2].TreeLabel:Show();
				TreeFrames[3].TreeLabel:Show();
				TreeFrames[1].TreeLabelBackground:Show();
				TreeFrames[2].TreeLabelBackground:Show();
				TreeFrames[3].TreeLabelBackground:Show();
				Frame.TreeButtonsBar:Hide();
				if Frame.SetResizeBounds ~= nil then
					Frame:SetResizeBounds(CT.TUISTYLE.FrameXSizeMin_Style1, CT.TUISTYLE.FrameYSizeMin_Style1, 9999, 9999);
				else
					Frame:SetMinResize(CT.TUISTYLE.FrameXSizeMin_Style1, CT.TUISTYLE.FrameYSizeMin_Style1);
				end

				local scale = (Frame:GetHeight() - CT.TUISTYLE.TreeFrameYToBorder * 2) / (CT.TUISTYLE.TreeFrameYSize + CT.TUISTYLE.FrameHeaderYSize + CT.TUISTYLE.FrameFooterYSize);
				Frame.ObjectScale = scale;
				Frame:SetWidth(scale * CT.TUISTYLE.TreeFrameXSizeTriple + CT.TUISTYLE.TreeFrameXToBorder * 2);

				MT._TextureFunc.SetNormalTexture(Frame.objects.ExpandButton, CT.TTEXTURESET.SHRINK, nil, nil, CT.TTEXTURESET.CONTROL.NORMAL_COLOR);
				MT._TextureFunc.SetPushedTexture(Frame.objects.ExpandButton, CT.TTEXTURESET.SHRINK, nil, nil, CT.TTEXTURESET.CONTROL.PUSHED_COLOR);
				MT._TextureFunc.SetHighlightTexture(Frame.objects.ExpandButton, CT.TTEXTURESET.SHRINK, nil, nil, CT.TTEXTURESET.CONTROL.PUSHED_COLOR);
			elseif style == 2 then
				TreeFrames[1]:Hide();
				TreeFrames[2]:Hide();
				TreeFrames[3]:Hide();
				TreeFrames[Frame.CurTreeIndex]:Show();
				TreeFrames[2]:ClearAllPoints();
				TreeFrames[2]:SetPoint("TOP", Frame, "TOP", 0, -CT.TUISTYLE.TreeFrameYToBorder - CT.TUISTYLE.FrameHeaderYSize);
				TreeFrames[1]:ClearAllPoints();
				TreeFrames[1]:SetPoint("TOPLEFT", TreeFrames[2], "TOPLEFT");
				TreeFrames[1]:SetPoint("BOTTOMRIGHT", TreeFrames[2], "BOTTOMRIGHT");
				TreeFrames[3]:ClearAllPoints();
				TreeFrames[3]:SetPoint("TOPLEFT", TreeFrames[2], "TOPLEFT");
				TreeFrames[3]:SetPoint("BOTTOMRIGHT", TreeFrames[2], "BOTTOMRIGHT");
				TreeFrames[1].TreeLabel:Hide();
				TreeFrames[2].TreeLabel:Hide();
				TreeFrames[3].TreeLabel:Hide();
				TreeFrames[1].TreeLabelBackground:Hide();
				TreeFrames[2].TreeLabelBackground:Hide();
				TreeFrames[3].TreeLabelBackground:Hide();
				Frame.TreeButtonsBar:Show();
				if Frame.SetResizeBounds ~= nil then
					Frame:SetResizeBounds(CT.TUISTYLE.FrameXSizeMin_Style2, CT.TUISTYLE.FrameYSizeMin_Style2, 9999, 9999);
				else
					Frame:SetMinResize(CT.TUISTYLE.FrameXSizeMin_Style2, CT.TUISTYLE.FrameYSizeMin_Style2);
				end

				local scale = (Frame:GetHeight() - CT.TUISTYLE.TreeFrameYToBorder * 2) / (CT.TUISTYLE.TreeFrameYSize + CT.TUISTYLE.FrameHeaderYSize + CT.TUISTYLE.FrameFooterYSize);
				Frame.ObjectScale = scale;
				Frame:SetWidth(scale * CT.TUISTYLE.TreeFrameXSizeSingle + CT.TUISTYLE.TreeFrameXToBorder * 2);

				MT._TextureFunc.SetNormalTexture(Frame.objects.ExpandButton, CT.TTEXTURESET.EXPAND, nil, nil, CT.TTEXTURESET.CONTROL.NORMAL_COLOR);
				MT._TextureFunc.SetPushedTexture(Frame.objects.ExpandButton, CT.TTEXTURESET.EXPAND, nil, nil, CT.TTEXTURESET.CONTROL.PUSHED_COLOR);
				MT._TextureFunc.SetHighlightTexture(Frame.objects.ExpandButton, CT.TTEXTURESET.EXPAND, nil, nil, CT.TTEXTURESET.CONTROL.PUSHED_COLOR);
			else
				return;
			end
			MT.UI.TreeUpdate(Frame, Frame.CurTreeIndex, true);
			local PScale = UIParent:GetEffectiveScale();
			local FScale = Frame:GetEffectiveScale();
			if Frame:GetRight() * FScale <= UIParent:GetLeft() * PScale + 16 then
				Frame:ClearAllPoints();
				Frame:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMLEFT", Frame:GetBottom() * FScale / PScale, 16 * FScale / PScale);
			elseif Frame:GetLeft() * FScale >= UIParent:GetRight() * PScale - 16 then
				Frame:ClearAllPoints();
				Frame:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMRIGHT", Frame:GetBottom() * FScale / PScale, -16 * FScale / PScale);
			end
		end
	end
	function MT.UI.TreeNodeLight(Node)
		Node:GetNormalTexture():SetVertexColor(CT.TTEXTURESET.ICON_LIGHT_COLOR[1], CT.TTEXTURESET.ICON_LIGHT_COLOR[2], CT.TTEXTURESET.ICON_LIGHT_COLOR[3], CT.TTEXTURESET.ICON_LIGHT_COLOR[4]);
		Node:GetPushedTexture():SetVertexColor(CT.TTEXTURESET.ICON_LIGHT_COLOR[1], CT.TTEXTURESET.ICON_LIGHT_COLOR[2], CT.TTEXTURESET.ICON_LIGHT_COLOR[3], CT.TTEXTURESET.ICON_LIGHT_COLOR[4]);
	end
	function MT.UI.TreeNodeUnlight(Node)
		Node:GetNormalTexture():SetVertexColor(CT.TTEXTURESET.ICON_UNLIGHT_COLOR[1], CT.TTEXTURESET.ICON_UNLIGHT_COLOR[2], CT.TTEXTURESET.ICON_UNLIGHT_COLOR[3], CT.TTEXTURESET.ICON_UNLIGHT_COLOR[4]);
		Node:GetPushedTexture():SetVertexColor(CT.TTEXTURESET.ICON_UNLIGHT_COLOR[1], CT.TTEXTURESET.ICON_UNLIGHT_COLOR[2], CT.TTEXTURESET.ICON_UNLIGHT_COLOR[3], CT.TTEXTURESET.ICON_UNLIGHT_COLOR[4]);
	end
	function MT.UI.TreeNodeSetTextColorAvailable(Node)
		Node.Split:SetTextColor(CT.TUISTYLE.IconTextAvailableColor[1], CT.TUISTYLE.IconTextAvailableColor[2], CT.TUISTYLE.IconTextAvailableColor[3], CT.TUISTYLE.IconTextAvailableColor[4]);
		Node.MaxVal:SetTextColor(CT.TUISTYLE.IconTextAvailableColor[1], CT.TUISTYLE.IconTextAvailableColor[2], CT.TUISTYLE.IconTextAvailableColor[3], CT.TUISTYLE.IconTextAvailableColor[4]);
		Node.CurVal:SetTextColor(CT.TUISTYLE.IconTextAvailableColor[1], CT.TUISTYLE.IconTextAvailableColor[2], CT.TUISTYLE.IconTextAvailableColor[3], CT.TUISTYLE.IconTextAvailableColor[4]);
	end
	function MT.UI.TreeNodeSetTextColorUnavailable(Node)
		Node.Split:SetTextColor(CT.TUISTYLE.IconTextDisabledColor[1], CT.TUISTYLE.IconTextDisabledColor[2], CT.TUISTYLE.IconTextDisabledColor[3], CT.TUISTYLE.IconTextDisabledColor[4]);
		Node.MaxVal:SetTextColor(CT.TUISTYLE.IconTextDisabledColor[1], CT.TUISTYLE.IconTextDisabledColor[2], CT.TUISTYLE.IconTextDisabledColor[3], CT.TUISTYLE.IconTextDisabledColor[4]);
		Node.CurVal:SetTextColor(CT.TUISTYLE.IconTextDisabledColor[1], CT.TUISTYLE.IconTextDisabledColor[2], CT.TUISTYLE.IconTextDisabledColor[3], CT.TUISTYLE.IconTextDisabledColor[4]);
	end
	function MT.UI.TreeNodeSetTextColorMaxRank(Node)
		Node.Split:SetTextColor(CT.TUISTYLE.IconTextMaxRankColor[1], CT.TUISTYLE.IconTextMaxRankColor[2], CT.TUISTYLE.IconTextMaxRankColor[3], CT.TUISTYLE.IconTextMaxRankColor[4]);
		Node.MaxVal:SetTextColor(CT.TUISTYLE.IconTextMaxRankColor[1], CT.TUISTYLE.IconTextMaxRankColor[2], CT.TUISTYLE.IconTextMaxRankColor[3], CT.TUISTYLE.IconTextMaxRankColor[4]);
		Node.CurVal:SetTextColor(CT.TUISTYLE.IconTextMaxRankColor[1], CT.TUISTYLE.IconTextMaxRankColor[2], CT.TUISTYLE.IconTextMaxRankColor[3], CT.TUISTYLE.IconTextMaxRankColor[4]);
	end
	function MT.UI.TreeNodeActivate(Node)	--	Light Node when points increased from 0 instead of activated
		Node.active = true;
		MT.UI.TreeNodeSetTextColorAvailable(Node);
	end
	function MT.UI.TreeNodeActivateMaxRank(Node)	--	Light Node when points increased from 0 instead of activated
		Node.active = true;
		MT.UI.TreeNodeSetTextColorMaxRank(Node);
	end
	function MT.UI.TreeNodeDeactive(Node)	--	Unlight Node certainly when deactived
		Node.active = false;
		MT.UI.TreeNodeSetTextColorUnavailable(Node);
		MT.UI.TreeNodeUnlight(Node);
	end
	function MT.UI.TreeNodeActivate_RecheckReq(Node)
		local TalentSeq = Node.TalentSeq;
		if TalentSeq ~= nil then
			local TreeFrame = Node.Parent;
			local TalentSet = TreeFrame.TalentSet;
			local TreeTDB = TreeFrame.TreeTDB;
			local TalentDef = TreeTDB[TalentSeq];
			local DepTSeq = TalentDef[11];
			if DepTSeq == nil or TreeFrame.TalentSet[DepTSeq] == TreeTDB[DepTSeq][4] then
				if TalentSet[TalentSeq] >= TreeTDB[TalentSeq][4] then
					MT.UI.TreeNodeActivateMaxRank(Node)
				else
					MT.UI.TreeNodeActivate(Node);
				end
			end
		end
	end
	function MT.UI.TreeNodeActivate_RecheckPoint(Node)
		local TalentSeq = Node.TalentSeq;
		if TalentSeq > 0 then
			local TreeFrame = Node.Parent;
			local TreeTDB = TreeFrame.TreeTDB;
			local TalentSet = TreeFrame.TalentSet;
			local TalentDef = TreeTDB[TalentSeq];
			if TalentDef[1] == 0 then
				MT.UI.TreeNodeActivate(Node);
			end
			local numPointsLowerTier = 0;
			for Tier = 0, TalentDef[1] - 1 do
				numPointsLowerTier = numPointsLowerTier + TalentSet.CountByTier[Tier];
			end
			if numPointsLowerTier >= TalentDef[1] * CT.NUM_POINTS_NEXT_TIER then
				MT.UI.TreeNodeActivate(Node);
			end
		end
	end
	function MT.UI.TreeNodesActivateTier(TreeNodes, tier)
		for i = tier * DT.MAX_NUM_COL + 1, (tier + 1) * DT.MAX_NUM_COL do
			MT.UI.TreeNodeActivate_RecheckReq(TreeNodes[i]);
		end
	end
	function MT.UI.TreeNodesDeactiveTier(TreeNodes, tier)
		for i = tier * DT.MAX_NUM_COL + 1, (tier + 1) * DT.MAX_NUM_COL do
			MT.UI.TreeNodeDeactive(TreeNodes[i]);
		end
	end
	function MT.UI.DependArrowSetTexCoord(Arrow, enabled)
		local Branch1, Corner, Branch2, coordFamily = Arrow.Branch1, Arrow.Corner, Arrow.Branch2, Arrow.coordFamily;
		if coordFamily == 11 then
			if enabled then
				Arrow:SetTexCoord(CT.TTEXTURESET.ARROW_COORD[4][1], CT.TTEXTURESET.ARROW_COORD[4][2], CT.TTEXTURESET.ARROW_COORD[4][3], CT.TTEXTURESET.ARROW_COORD[4][4]);
				Branch1:SetTexCoord(CT.TTEXTURESET.BRANCH_COORD[4][1], CT.TTEXTURESET.BRANCH_COORD[4][2], CT.TTEXTURESET.BRANCH_COORD[4][3], CT.TTEXTURESET.BRANCH_COORD[4][4]);
			else
				Arrow:SetTexCoord(CT.TTEXTURESET.ARROW_COORD[3][1], CT.TTEXTURESET.ARROW_COORD[3][2], CT.TTEXTURESET.ARROW_COORD[3][3], CT.TTEXTURESET.ARROW_COORD[3][4]);
				Branch1:SetTexCoord(CT.TTEXTURESET.BRANCH_COORD[3][1], CT.TTEXTURESET.BRANCH_COORD[3][2], CT.TTEXTURESET.BRANCH_COORD[3][3], CT.TTEXTURESET.BRANCH_COORD[3][4]);
			end
		elseif coordFamily == 12 then
			if enabled then
				Arrow:SetTexCoord(CT.TTEXTURESET.ARROW_COORD[4][2], CT.TTEXTURESET.ARROW_COORD[4][1], CT.TTEXTURESET.ARROW_COORD[4][3], CT.TTEXTURESET.ARROW_COORD[4][4]);
				Branch1:SetTexCoord(CT.TTEXTURESET.BRANCH_COORD[4][1], CT.TTEXTURESET.BRANCH_COORD[4][2], CT.TTEXTURESET.BRANCH_COORD[4][3], CT.TTEXTURESET.BRANCH_COORD[4][4]);
			else
				Arrow:SetTexCoord(CT.TTEXTURESET.ARROW_COORD[3][2], CT.TTEXTURESET.ARROW_COORD[3][1], CT.TTEXTURESET.ARROW_COORD[3][3], CT.TTEXTURESET.ARROW_COORD[3][4]);
				Branch1:SetTexCoord(CT.TTEXTURESET.BRANCH_COORD[3][1], CT.TTEXTURESET.BRANCH_COORD[3][2], CT.TTEXTURESET.BRANCH_COORD[3][3], CT.TTEXTURESET.BRANCH_COORD[3][4]);
			end
		elseif coordFamily == 21 then
			if enabled then
				Arrow:SetTexCoord(CT.TTEXTURESET.ARROW_COORD[2][1], CT.TTEXTURESET.ARROW_COORD[2][2], CT.TTEXTURESET.ARROW_COORD[2][3], CT.TTEXTURESET.ARROW_COORD[2][4]);
				Branch1:SetTexCoord(CT.TTEXTURESET.BRANCH_COORD[2][1], CT.TTEXTURESET.BRANCH_COORD[2][2], CT.TTEXTURESET.BRANCH_COORD[2][3], CT.TTEXTURESET.BRANCH_COORD[2][4]);
			else
				Arrow:SetTexCoord(CT.TTEXTURESET.ARROW_COORD[1][1], CT.TTEXTURESET.ARROW_COORD[1][2], CT.TTEXTURESET.ARROW_COORD[1][3], CT.TTEXTURESET.ARROW_COORD[1][4]);
				Branch1:SetTexCoord(CT.TTEXTURESET.BRANCH_COORD[1][1], CT.TTEXTURESET.BRANCH_COORD[1][2], CT.TTEXTURESET.BRANCH_COORD[1][3], CT.TTEXTURESET.BRANCH_COORD[1][4]);
			end
		elseif coordFamily == 22 then
			if enabled then
				Arrow:SetTexCoord(CT.TTEXTURESET.ARROW_COORD[2][1], CT.TTEXTURESET.ARROW_COORD[2][2], CT.TTEXTURESET.ARROW_COORD[2][3], CT.TTEXTURESET.ARROW_COORD[2][4]);
				Branch1:SetTexCoord(CT.TTEXTURESET.BRANCH_COORD[2][1], CT.TTEXTURESET.BRANCH_COORD[2][2], CT.TTEXTURESET.BRANCH_COORD[2][3], CT.TTEXTURESET.BRANCH_COORD[2][4]);
			else
				Arrow:SetTexCoord(CT.TTEXTURESET.ARROW_COORD[1][1], CT.TTEXTURESET.ARROW_COORD[1][2], CT.TTEXTURESET.ARROW_COORD[1][3], CT.TTEXTURESET.ARROW_COORD[1][4]);
				Branch1:SetTexCoord(CT.TTEXTURESET.BRANCH_COORD[1][1], CT.TTEXTURESET.BRANCH_COORD[1][2], CT.TTEXTURESET.BRANCH_COORD[1][3], CT.TTEXTURESET.BRANCH_COORD[1][4]);
			end
		elseif coordFamily == 31 then
			if enabled then
				Arrow:SetTexCoord(CT.TTEXTURESET.ARROW_COORD[2][1], CT.TTEXTURESET.ARROW_COORD[2][2], CT.TTEXTURESET.ARROW_COORD[2][3], CT.TTEXTURESET.ARROW_COORD[2][4]);
				Branch1:SetTexCoord(CT.TTEXTURESET.BRANCH_COORD[2][1], CT.TTEXTURESET.BRANCH_COORD[2][2], CT.TTEXTURESET.BRANCH_COORD[2][3], CT.TTEXTURESET.BRANCH_COORD[2][4]);
			else
				Arrow:SetTexCoord(CT.TTEXTURESET.ARROW_COORD[1][1], CT.TTEXTURESET.ARROW_COORD[1][2], CT.TTEXTURESET.ARROW_COORD[1][3], CT.TTEXTURESET.ARROW_COORD[1][4]);
				Branch1:SetTexCoord(CT.TTEXTURESET.BRANCH_COORD[1][1], CT.TTEXTURESET.BRANCH_COORD[1][2], CT.TTEXTURESET.BRANCH_COORD[1][3], CT.TTEXTURESET.BRANCH_COORD[1][4]);
			end
		elseif coordFamily == 32 then
			if enabled then
				Arrow:SetTexCoord(CT.TTEXTURESET.ARROW_COORD[2][1], CT.TTEXTURESET.ARROW_COORD[2][2], CT.TTEXTURESET.ARROW_COORD[2][3], CT.TTEXTURESET.ARROW_COORD[2][4]);
				Branch1:SetTexCoord(CT.TTEXTURESET.BRANCH_COORD[2][1], CT.TTEXTURESET.BRANCH_COORD[2][2], CT.TTEXTURESET.BRANCH_COORD[2][3], CT.TTEXTURESET.BRANCH_COORD[2][4]);
			else
				Arrow:SetTexCoord(CT.TTEXTURESET.ARROW_COORD[1][1], CT.TTEXTURESET.ARROW_COORD[1][2], CT.TTEXTURESET.ARROW_COORD[1][3], CT.TTEXTURESET.ARROW_COORD[1][4]);
				Branch1:SetTexCoord(CT.TTEXTURESET.BRANCH_COORD[1][1], CT.TTEXTURESET.BRANCH_COORD[1][2], CT.TTEXTURESET.BRANCH_COORD[1][3], CT.TTEXTURESET.BRANCH_COORD[1][4]);
			end
		elseif coordFamily == 41 then
			if enabled then
				Arrow:SetTexCoord(CT.TTEXTURESET.ARROW_COORD[2][1], CT.TTEXTURESET.ARROW_COORD[2][2], CT.TTEXTURESET.ARROW_COORD[2][4], CT.TTEXTURESET.ARROW_COORD[2][3]);
				Branch1:SetTexCoord(CT.TTEXTURESET.BRANCH_COORD[2][1], CT.TTEXTURESET.BRANCH_COORD[2][2], CT.TTEXTURESET.BRANCH_COORD[2][3], CT.TTEXTURESET.BRANCH_COORD[2][4]);
			else
				Arrow:SetTexCoord(CT.TTEXTURESET.ARROW_COORD[1][1], CT.TTEXTURESET.ARROW_COORD[1][2], CT.TTEXTURESET.ARROW_COORD[1][3], CT.TTEXTURESET.ARROW_COORD[1][4]);
				Branch1:SetTexCoord(CT.TTEXTURESET.BRANCH_COORD[1][1], CT.TTEXTURESET.BRANCH_COORD[1][2], CT.TTEXTURESET.BRANCH_COORD[1][3], CT.TTEXTURESET.BRANCH_COORD[1][4]);
			end
		elseif coordFamily == 42 then
			if enabled then
				Arrow:SetTexCoord(CT.TTEXTURESET.ARROW_COORD[2][1], CT.TTEXTURESET.ARROW_COORD[2][2], CT.TTEXTURESET.ARROW_COORD[2][4], CT.TTEXTURESET.ARROW_COORD[2][3]);
				Branch1:SetTexCoord(CT.TTEXTURESET.BRANCH_COORD[2][1], CT.TTEXTURESET.BRANCH_COORD[2][2], CT.TTEXTURESET.BRANCH_COORD[2][3], CT.TTEXTURESET.BRANCH_COORD[2][4]);
			else
				Arrow:SetTexCoord(CT.TTEXTURESET.ARROW_COORD[1][1], CT.TTEXTURESET.ARROW_COORD[1][2], CT.TTEXTURESET.ARROW_COORD[1][3], CT.TTEXTURESET.ARROW_COORD[1][4]);
				Branch1:SetTexCoord(CT.TTEXTURESET.BRANCH_COORD[1][1], CT.TTEXTURESET.BRANCH_COORD[1][2], CT.TTEXTURESET.BRANCH_COORD[1][3], CT.TTEXTURESET.BRANCH_COORD[1][4]);
			end
		end
		if coordFamily == 31 then
			if enabled then
				Corner:SetTexCoord(CT.TTEXTURESET.BRANCH_COORD[6][1], CT.TTEXTURESET.BRANCH_COORD[6][2], CT.TTEXTURESET.BRANCH_COORD[6][3], CT.TTEXTURESET.BRANCH_COORD[6][4]);
				Branch2:SetTexCoord(CT.TTEXTURESET.BRANCH_COORD[4][1], CT.TTEXTURESET.BRANCH_COORD[4][2], CT.TTEXTURESET.BRANCH_COORD[4][3], CT.TTEXTURESET.BRANCH_COORD[4][4]);
			else
				Corner:SetTexCoord(CT.TTEXTURESET.BRANCH_COORD[5][1], CT.TTEXTURESET.BRANCH_COORD[5][2], CT.TTEXTURESET.BRANCH_COORD[5][3], CT.TTEXTURESET.BRANCH_COORD[5][4]);
				Branch2:SetTexCoord(CT.TTEXTURESET.BRANCH_COORD[3][1], CT.TTEXTURESET.BRANCH_COORD[3][2], CT.TTEXTURESET.BRANCH_COORD[3][3], CT.TTEXTURESET.BRANCH_COORD[3][4]);
			end
		elseif coordFamily == 32 then
			if enabled then
				Corner:SetTexCoord(CT.TTEXTURESET.BRANCH_COORD[6][2], CT.TTEXTURESET.BRANCH_COORD[6][1], CT.TTEXTURESET.BRANCH_COORD[6][3], CT.TTEXTURESET.BRANCH_COORD[6][4]);
				Branch2:SetTexCoord(CT.TTEXTURESET.BRANCH_COORD[4][1], CT.TTEXTURESET.BRANCH_COORD[4][2], CT.TTEXTURESET.BRANCH_COORD[4][3], CT.TTEXTURESET.BRANCH_COORD[4][4]);
			else
				Corner:SetTexCoord(CT.TTEXTURESET.BRANCH_COORD[5][2], CT.TTEXTURESET.BRANCH_COORD[5][1], CT.TTEXTURESET.BRANCH_COORD[5][3], CT.TTEXTURESET.BRANCH_COORD[5][4]);
				Branch2:SetTexCoord(CT.TTEXTURESET.BRANCH_COORD[3][1], CT.TTEXTURESET.BRANCH_COORD[3][2], CT.TTEXTURESET.BRANCH_COORD[3][3], CT.TTEXTURESET.BRANCH_COORD[3][4]);
			end
		elseif coordFamily == 41 then
			if enabled then
				Corner:SetTexCoord(CT.TTEXTURESET.BRANCH_COORD[6][1], CT.TTEXTURESET.BRANCH_COORD[6][2], CT.TTEXTURESET.BRANCH_COORD[6][4], CT.TTEXTURESET.BRANCH_COORD[6][3]);
				Branch2:SetTexCoord(CT.TTEXTURESET.BRANCH_COORD[4][1], CT.TTEXTURESET.BRANCH_COORD[4][2], CT.TTEXTURESET.BRANCH_COORD[4][3], CT.TTEXTURESET.BRANCH_COORD[4][4]);
			else
				Corner:SetTexCoord(CT.TTEXTURESET.BRANCH_COORD[5][1], CT.TTEXTURESET.BRANCH_COORD[5][2], CT.TTEXTURESET.BRANCH_COORD[5][4], CT.TTEXTURESET.BRANCH_COORD[5][3]);
				Branch2:SetTexCoord(CT.TTEXTURESET.BRANCH_COORD[3][1], CT.TTEXTURESET.BRANCH_COORD[3][2], CT.TTEXTURESET.BRANCH_COORD[3][3], CT.TTEXTURESET.BRANCH_COORD[3][4]);
			end
		elseif coordFamily == 42 then
			if enabled then
				Corner:SetTexCoord(CT.TTEXTURESET.BRANCH_COORD[6][2], CT.TTEXTURESET.BRANCH_COORD[6][1], CT.TTEXTURESET.BRANCH_COORD[6][4], CT.TTEXTURESET.BRANCH_COORD[6][3]);
				Branch2:SetTexCoord(CT.TTEXTURESET.BRANCH_COORD[4][1], CT.TTEXTURESET.BRANCH_COORD[4][2], CT.TTEXTURESET.BRANCH_COORD[4][3], CT.TTEXTURESET.BRANCH_COORD[4][4]);
			else
				Corner:SetTexCoord(CT.TTEXTURESET.BRANCH_COORD[5][2], CT.TTEXTURESET.BRANCH_COORD[5][1], CT.TTEXTURESET.BRANCH_COORD[5][4], CT.TTEXTURESET.BRANCH_COORD[5][3]);
				Branch2:SetTexCoord(CT.TTEXTURESET.BRANCH_COORD[3][1], CT.TTEXTURESET.BRANCH_COORD[3][2], CT.TTEXTURESET.BRANCH_COORD[3][3], CT.TTEXTURESET.BRANCH_COORD[3][4]);
			end
		end
	end
	function MT.UI.DependArrowSet(Arrow, verticalDist, horizontalDist, enabled, Node, DepNode)
		local Branch1, Corner, Branch2 = Arrow.Branch1, Arrow.Corner, Arrow.Branch2;
		local coordFamily = nil;
		if verticalDist == 0 then		--horizontal
			if horizontalDist > 0 then
				Arrow:SetPoint("CENTER", Node, "LEFT", -CT.TUISTYLE.TalentDepArrowXSize / 6, 0);
				Branch1:SetSize(CT.TUISTYLE.TreeNodeXSize * (horizontalDist - 1) + CT.TUISTYLE.TreeNodeXGap * horizontalDist, CT.TUISTYLE.TalentDepBranchXSize);
				Branch1:SetPoint("LEFT", DepNode, "RIGHT");
				Branch1:SetPoint("RIGHT", Arrow, "CENTER");
				coordFamily = 11;
			elseif horizontalDist < 0 then
				horizontalDist = -horizontalDist;
				Arrow:SetPoint("CENTER", Node, "RIGHT", CT.TUISTYLE.TalentDepArrowXSize / 6, 0);
				Branch1:SetSize(CT.TUISTYLE.TreeNodeXSize * (horizontalDist - 1) + CT.TUISTYLE.TreeNodeXGap * horizontalDist, CT.TUISTYLE.TalentDepBranchXSize);
				Branch1:SetPoint("RIGHT", DepNode, "LEFT");
				Branch1:SetPoint("LEFT", Arrow, "CENTER");
				coordFamily = 12;
			end
			Corner:Hide();
			Branch2:Hide();
		elseif horizontalDist == 0 then	--vertical
			if verticalDist > 0 then
				Arrow:SetPoint("CENTER", Node, "TOP", 0, CT.TUISTYLE.TalentDepArrowYSize / 6);
				Branch1:SetSize(CT.TUISTYLE.TalentDepBranchXSize, CT.TUISTYLE.TreeNodeYSize * (verticalDist - 1) + CT.TUISTYLE.TreeNodeYGap * verticalDist);
				Branch1:SetPoint("TOP", DepNode, "BOTTOM");
				Branch1:SetPoint("BOTTOM", Arrow, "CENTER");
				coordFamily = 21;
			elseif verticalDist < 0 then
				verticalDist = -verticalDist;
				Arrow:SetPoint("CENTER", Node, "BOTTOM", 0, -CT.TUISTYLE.TalentDepArrowYSize / 6);
				Branch1:SetSize(CT.TUISTYLE.TalentDepBranchXSize, CT.TUISTYLE.TreeNodeYSize * (verticalDist - 1) + CT.TUISTYLE.TreeNodeYGap * verticalDist);
				Branch1:SetPoint("BOTTOM", DepNode, "TOP");
				Branch1:SetPoint("TOP", Arrow, "CENTER");
				coordFamily = 22;
			end
			Corner:Hide();
			Branch2:Hide();
		else	--TODO
			if verticalDist > 0 then
				Arrow:SetPoint("CENTER", Node, "TOP", 0, CT.TUISTYLE.TalentDepArrowYSize / 6);
				Branch1:SetHeight(CT.TUISTYLE.TreeNodeYSize * (verticalDist - 1) + CT.TUISTYLE.TreeNodeYGap * verticalDist + CT.TUISTYLE.TreeNodeYSize * 0.5 - CT.TUISTYLE.TalentDepBranchXSize);
				--Branch1:SetPoint("TOP", DepNode, "CENTER");
				Branch1:SetPoint("BOTTOM", Arrow, "CENTER");
				Corner:SetPoint("BOTTOM", Branch1, "TOP");
				-- Branch2:SetWidth(CT.TUISTYLE.TreeNodeXSize * (horizontalDist - 1) + CT.TUISTYLE.TreeNodeXGap * horizontalDist + CT.TUISTYLE.TreeNodeXSize * 0.5);
				if horizontalDist > 0 then
					Branch2:SetPoint("LEFT", DepNode, "RIGHT");
					Branch2:SetPoint("BOTTOMRIGHT", Branch1, "TOPLEFT");
					coordFamily = 31;
				else
					Branch2:SetPoint("RIGHT", DepNode, "LEFT");
					Branch2:SetPoint("BOTTOMLEFT", Branch1, "TOPRIGHT");
					coordFamily = 32;
				end
			else
				verticalDist = -verticalDist;
				Arrow:SetPoint("CENTER", Node, "BOTTOM", 0, -CT.TUISTYLE.TalentDepArrowYSize / 6);
				Branch1:SetHeight(CT.TUISTYLE.TreeNodeYSize * (verticalDist - 1) + CT.TUISTYLE.TreeNodeYGap * verticalDist + CT.TUISTYLE.TreeNodeYSize * 0.5 - CT.TUISTYLE.TalentDepBranchXSize);
				--Branch1:SetPoint("BOTTOM", DepNode, "CENTER");
				Branch1:SetPoint("TOP", Arrow, "CENTER");
				Corner:SetPoint("BOTTOM", Branch1, "TOP");
				-- Branch2:SetWidth(CT.TUISTYLE.TreeNodeXSize * (horizontalDist - 1) + CT.TUISTYLE.TreeNodeXGap * horizontalDist + CT.TUISTYLE.TreeNodeXSize * 0.5);
				if horizontalDist > 0 then
					Branch2:SetPoint("LEFT", DepNode, "RIGHT");
					Branch2:SetPoint("TOPRIGHT", Branch1, "BOTTOMLEFT");
					coordFamily = 41;
				else
					Branch2:SetPoint("RIGHT", DepNode, "LEFT");
					Branch2:SetPoint("TOPLEFT", Branch1, "BOTTOMRIGHT");
					coordFamily = 42;
				end
			end
			Branch2:Show();
			Corner:Show();
		end
		Arrow:Show();
		Branch1:Show();
		Arrow.coordFamily = coordFamily;
		MT.UI.DependArrowSetTexCoord(Arrow, enabled);
	end
	function MT.UI.DependArrowCreate(TreeFrame)
		local Arrow = TreeFrame:CreateTexture(nil, "OVERLAY");
		Arrow:SetTexture(CT.TTEXTURESET.ARROW);
		Arrow:SetSize(CT.TUISTYLE.TalentDepArrowXSize, CT.TUISTYLE.TalentDepArrowYSize);

		local Branch1 = TreeFrame:CreateTexture(nil, "ARTWORK");
		Branch1:SetWidth(CT.TUISTYLE.TalentDepBranchXSize);
		Branch1:SetTexture(CT.TTEXTURESET.BRANCH);

		local Corner = TreeFrame:CreateTexture(nil, "ARTWORK");
		Corner:SetSize(CT.TUISTYLE.TalentDepBranchXSize, CT.TUISTYLE.TalentDepBranchXSize);
		Corner:SetTexture(CT.TTEXTURESET.BRANCH);
		Corner:Hide();

		local Branch2 = TreeFrame:CreateTexture(nil, "ARTWORK");
		Branch2:SetHeight(CT.TUISTYLE.TalentDepBranchXSize);
		Branch2:SetTexture(CT.TTEXTURESET.BRANCH);
		Branch2:Hide();

		Arrow.Branch1 = Branch1;
		Arrow.Corner = Corner;
		Arrow.Branch2 = Branch2;

		return Arrow;
	end
	function MT.UI.DependArrowGet(TreeFrame)
		local DependArrows = TreeFrame.DependArrows;
		DependArrows.used = DependArrows.used + 1;
		if DependArrows.used > #DependArrows then
			DependArrows[DependArrows.used] = MT.UI.DependArrowCreate(TreeFrame);
		end
		return DependArrows[DependArrows.used];
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
			TooltipFrame:SetHeight(TooltipFrame.Tooltip1LabelLeft:GetHeight() + Tooltip1:GetHeight() + TooltipFrame.Tooltip1FooterRight:GetHeight());
			TooltipFrame:SetAlpha(1.0);
			Tooltip1:SetAlpha(1.0);
		else
			TooltipFrame:Hide();
		end
	end
	local function TooltipFrame_OnUpdate_Tooltip12(TooltipFrame, elasped)
		TooltipFrame.delay = TooltipFrame.delay - elasped;
		if TooltipFrame.delay > 0 then
			return;
		end
		TooltipFrame:SetScript("OnUpdate", nil);
		local Tooltip1 = TooltipFrame.Tooltip1;
		local Tooltip2 = TooltipFrame.Tooltip2;
		if Tooltip1:IsShown() or Tooltip2:IsShown() then
			if TooltipFrame.WoWeuCN_TooltipsSetSpellTooltip ~= nil then
				TooltipFrame.WoWeuCN_TooltipsSetSpellTooltip(Tooltip1, Tooltip1.SpellID);
				TooltipFrame.WoWeuCN_TooltipsSetSpellTooltip(Tooltip2, Tooltip2.SpellID);
			end
			--Tooltip1:Show();
			--Tooltip2:Show();
			TooltipFrame:SetWidth(max(Tooltip1:GetWidth(), Tooltip2:GetWidth()));
			TooltipFrame:SetHeight(TooltipFrame.Tooltip1LabelLeft:GetHeight() + Tooltip1:GetHeight() + TooltipFrame.Tooltip1FooterLeft:GetHeight() + TooltipFrame.Tooltip2LabelLeft:GetHeight() + Tooltip2:GetHeight() + TooltipFrame.Tooltip2FooterLeft:GetHeight() - 8);
			TooltipFrame:SetAlpha(1.0);
			Tooltip1:SetAlpha(1.0);
			Tooltip2:SetAlpha(1.0);
		else
			TooltipFrame:Hide();
		end
	end
	function MT.UI.TooltipFrameSetTalent(TooltipFrame, Node, SpecID, reqPts, pts, spellTable, CurRank, MaxRank)
		local Tooltip1LabelLeft = TooltipFrame.Tooltip1LabelLeft;
		local Tooltip1LabelRight = TooltipFrame.Tooltip1LabelRight;
		local Tooltip1 = TooltipFrame.Tooltip1;

		local Tooltip1FooterLeft = TooltipFrame.Tooltip1FooterLeft;
		local Tooltip1FooterRight = TooltipFrame.Tooltip1FooterRight;

		local Tooltip2LabelLeft = TooltipFrame.Tooltip2LabelLeft;
		local Tooltip2LabelRight = TooltipFrame.Tooltip2LabelRight;
		local Tooltip2 = TooltipFrame.Tooltip2;

		local Tooltip2FooterLeft = TooltipFrame.Tooltip2FooterLeft;
		local Tooltip2FooterRight = TooltipFrame.Tooltip2FooterRight;

		TooltipFrame.OwnerFrame = Node.Parent.Frame;
		TooltipFrame:ClearAllPoints();
		TooltipFrame:SetPoint("BOTTOMRIGHT", Node, "TOPLEFT", -4, 4);
		TooltipFrame:Show();
		TooltipFrame:SetAlpha(0.0);
		if CurRank == 0 then
			Tooltip1LabelLeft:Show();
			Tooltip1LabelLeft:SetText(l10n.NextRank);
			if Node.active then
				Tooltip1LabelLeft:SetTextColor(CT.TUISTYLE.IconToolTipNextRankColor[1], CT.TUISTYLE.IconToolTipNextRankColor[2], CT.TUISTYLE.IconToolTipNextRankColor[3], CT.TUISTYLE.IconToolTipNextRankColor[4]);
				Tooltip1LabelRight:Hide();
			else
				Tooltip1LabelLeft:SetTextColor(CT.TUISTYLE.IconToolTipNextRankDisabledColor[1], CT.TUISTYLE.IconToolTipNextRankDisabledColor[2], CT.TUISTYLE.IconToolTipNextRankDisabledColor[3], CT.TUISTYLE.IconToolTipNextRankDisabledColor[4]);
				if reqPts > pts then
					Tooltip1LabelRight:SetTextColor(CT.TUISTYLE.IconToolTipNextRankDisabledColor[1], CT.TUISTYLE.IconToolTipNextRankDisabledColor[2], CT.TUISTYLE.IconToolTipNextRankDisabledColor[3], CT.TUISTYLE.IconToolTipNextRankDisabledColor[4]);
					Tooltip1LabelRight:Show();
					Tooltip1LabelRight:SetText(format(l10n.ReqPoints, pts, reqPts, l10n.SPEC[SpecID] or SpecID));
				end
			end
			--Tooltip1:Show();
			Tooltip1:SetOwner(TooltipFrame, "ANCHOR_NONE");
			Tooltip1:SetPoint("TOPLEFT", Tooltip1LabelLeft, "BOTTOMLEFT", 0, 6);
			Tooltip1:SetSpellByID(spellTable[1]);
			Tooltip1:SetAlpha(0.0);
			Tooltip1.SpellID = spellTable[1];
			Tooltip1FooterLeft:Show();
			Tooltip1FooterRight:Show();
			Tooltip1FooterRight:SetText(tostring(spellTable[1]));

			Tooltip2LabelLeft:Hide();
			Tooltip2LabelRight:Hide();
			Tooltip2:Hide();
			Tooltip2FooterLeft:Hide();
			Tooltip2FooterRight:Hide();

			TooltipFrame.delay = CT.TOOLTIP_UPDATE_DELAY;
			TooltipFrame:SetScript("OnUpdate", TooltipFrame_OnUpdate_Tooltip1);
		elseif CurRank == MaxRank then
			Tooltip1LabelLeft:Show();
			Tooltip1LabelLeft:SetText(l10n.MaxRank);
			Tooltip1LabelLeft:SetTextColor(CT.TUISTYLE.IconToolTipMaxRankColor[1], CT.TUISTYLE.IconToolTipMaxRankColor[2], CT.TUISTYLE.IconToolTipMaxRankColor[3], CT.TUISTYLE.IconToolTipMaxRankColor[4]);
			Tooltip1LabelRight:Show();
			Tooltip1LabelRight:SetText(CurRank .. "/" .. MaxRank);
			Tooltip1LabelRight:SetTextColor(CT.TUISTYLE.IconToolTipMaxRankColor[1], CT.TUISTYLE.IconToolTipMaxRankColor[2], CT.TUISTYLE.IconToolTipMaxRankColor[3], CT.TUISTYLE.IconToolTipMaxRankColor[4]);
			--Tooltip1:Show();
			Tooltip1:SetOwner(TooltipFrame, "ANCHOR_NONE");
			Tooltip1:SetPoint("TOPLEFT", Tooltip1LabelLeft, "BOTTOMLEFT", 0, 6);
			Tooltip1:SetSpellByID(spellTable[MaxRank]);
			Tooltip1:SetAlpha(0.0);
			Tooltip1.SpellID = spellTable[MaxRank];
			Tooltip1FooterLeft:Show();
			Tooltip1FooterRight:Show();
			Tooltip1FooterRight:SetText(tostring(spellTable[MaxRank]));

			Tooltip2LabelLeft:Hide();
			Tooltip2LabelRight:Hide();
			Tooltip2:Hide();
			Tooltip2FooterLeft:Hide();
			Tooltip2FooterRight:Hide();

			TooltipFrame.delay = CT.TOOLTIP_UPDATE_DELAY;
			TooltipFrame:SetScript("OnUpdate", TooltipFrame_OnUpdate_Tooltip1);
		else
			Tooltip1LabelLeft:Show();
			Tooltip1LabelLeft:SetText(l10n.CurRank);
			Tooltip1LabelLeft:SetTextColor(CT.TUISTYLE.IconToolTipCurRankColor[1], CT.TUISTYLE.IconToolTipCurRankColor[2], CT.TUISTYLE.IconToolTipCurRankColor[3], CT.TUISTYLE.IconToolTipCurRankColor[4]);
			Tooltip1LabelRight:Show();
			Tooltip1LabelRight:SetText(CurRank .. "/" .. MaxRank);
			Tooltip1LabelRight:SetTextColor(CT.TUISTYLE.IconToolTipCurRankColor[1], CT.TUISTYLE.IconToolTipCurRankColor[2], CT.TUISTYLE.IconToolTipCurRankColor[3], CT.TUISTYLE.IconToolTipCurRankColor[4]);
			--Tooltip1:Show();
			Tooltip1:SetOwner(TooltipFrame, "ANCHOR_NONE");
			Tooltip1:SetPoint("TOPLEFT", Tooltip1LabelLeft, "BOTTOMLEFT", 0, 6);
			Tooltip1:SetSpellByID(spellTable[CurRank]);
			Tooltip1:SetAlpha(0.0);
			Tooltip1.SpellID = spellTable[CurRank];
			Tooltip1FooterLeft:Show();
			Tooltip1FooterRight:Show();
			Tooltip1FooterRight:SetText(tostring(spellTable[CurRank]));

			Tooltip2LabelLeft:Show();
			Tooltip2LabelLeft:SetText(l10n.NextRank);
			if Node.active then
				if CurRank + 1 == MaxRank then
					Tooltip2LabelLeft:SetTextColor(CT.TUISTYLE.IconToolTipMaxRankColor[1], CT.TUISTYLE.IconToolTipMaxRankColor[2], CT.TUISTYLE.IconToolTipMaxRankColor[3], CT.TUISTYLE.IconToolTipMaxRankColor[4]);
				else
					Tooltip2LabelLeft:SetTextColor(CT.TUISTYLE.IconToolTipNextRankColor[1], CT.TUISTYLE.IconToolTipNextRankColor[2], CT.TUISTYLE.IconToolTipNextRankColor[3], CT.TUISTYLE.IconToolTipNextRankColor[4]);
				end
			else
				Tooltip2LabelLeft:SetTextColor(CT.TUISTYLE.IconToolTipNextRankDisabledColor[1], CT.TUISTYLE.IconToolTipNextRankDisabledColor[2], CT.TUISTYLE.IconToolTipNextRankDisabledColor[3], CT.TUISTYLE.IconToolTipNextRankDisabledColor[4]);
			end
			Tooltip2LabelRight:Show();
			Tooltip2LabelRight:SetText((CurRank + 1) .. "/" .. MaxRank);
			if Node.active then
				if CurRank + 1 == MaxRank then
					Tooltip2LabelRight:SetTextColor(CT.TUISTYLE.IconToolTipMaxRankColor[1], CT.TUISTYLE.IconToolTipMaxRankColor[2], CT.TUISTYLE.IconToolTipMaxRankColor[3], CT.TUISTYLE.IconToolTipMaxRankColor[4]);
				else
					Tooltip2LabelRight:SetTextColor(CT.TUISTYLE.IconToolTipNextRankColor[1], CT.TUISTYLE.IconToolTipNextRankColor[2], CT.TUISTYLE.IconToolTipNextRankColor[3], CT.TUISTYLE.IconToolTipNextRankColor[4]);
				end
			else
				Tooltip2LabelRight:SetTextColor(CT.TUISTYLE.IconToolTipNextRankDisabledColor[1], CT.TUISTYLE.IconToolTipNextRankDisabledColor[2], CT.TUISTYLE.IconToolTipNextRankDisabledColor[3], CT.TUISTYLE.IconToolTipNextRankDisabledColor[4]);
			end
			--Tooltip2:Show();
			Tooltip2:SetOwner(TooltipFrame, "ANCHOR_NONE");
			Tooltip2:SetPoint("TOPLEFT", Tooltip2LabelLeft, "BOTTOMLEFT", 0, 6);
			Tooltip2:SetSpellByID(spellTable[CurRank + 1]);
			Tooltip2:SetAlpha(0.0);
			Tooltip2.SpellID = spellTable[CurRank + 1];
			Tooltip2FooterLeft:Show();
			Tooltip2FooterRight:Show();
			Tooltip2FooterRight:SetText(tostring(spellTable[CurRank + 1]));

			TooltipFrame.delay = CT.TOOLTIP_UPDATE_DELAY;
			TooltipFrame:SetScript("OnUpdate", TooltipFrame_OnUpdate_Tooltip12);
		end
	end
	function MT.UI.SetTooltip(Node)
		local TreeFrame = Node.Parent;
		local TalentSeq = Node.TalentSeq;
		local TalentDef = TreeFrame.TreeTDB[TalentSeq];
		if TalentDef ~= nil then
			MT.UI.TooltipFrameSetTalent(VT.TooltipFrame, Node, TreeFrame.SpecID, TalentDef[1] * 5, TreeFrame.TalentSet.Total, TalentDef[8], TreeFrame.TalentSet[TalentSeq], TalentDef[4]);
		else
			MT.UI.HideTooltip(Node);
		end
	end
	function MT.UI.HideTooltip(Node)
		local TooltipFrame = VT.TooltipFrame;
		TooltipFrame:Hide();
		TooltipFrame.Tooltip1:Hide();
		TooltipFrame.Tooltip2:Hide();
	end
	function MT.UI.SpellListFrameUpdate(SpellListFrame, class, level)
		local list = SpellListFrame.list;
		wipe(list);
		local pos = 0;
		list.class = class;
		local showAll = SpellListFrame.ShowAllSpell:GetChecked();
		local search = SpellListFrame.SearchEdit:GetText();
		if search == "" then search = nil; end
		local TreeFrames = SpellListFrame.Frame.TreeFrames;
		local ClassSDB = DT.SpellDB[class];
		if ClassSDB ~= nil then
			for index = 1, #ClassSDB do
				local SpellDef = ClassSDB[index];
				if not SpellDef.talent or TreeFrames[SpellDef.requireSpecIndex].TalentSet[SpellDef.requireIndex] > 0 then
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
				Node.Texture = info[4];
				Node.Glyph:Hide();
				local d0 = Node.d0;
				if CT.BUILD == "WRATH" then
					Node.Background:SetTexCoord(d0[7], d0[8], d0[9], d0[10]);
				end
			end
		end
	end
	function MT.UI.TreeFrameUpdateSize(Frame, width, height)
		local TreeFrames = Frame.TreeFrames;
		local style = Frame.style;
		if style == 1 then
			local scale = min(
					(width) / (CT.TUISTYLE.TreeFrameXSizeTriple + CT.TUISTYLE.TreeFrameXToBorder * 2),
					(height - CT.TUISTYLE.FrameHeaderYSize - CT.TUISTYLE.FrameFooterYSize) / (CT.TUISTYLE.TreeFrameYSize + CT.TUISTYLE.TreeFrameYToBorder * 2)
				);
			TreeFrames[1]:SetScale(scale);
			TreeFrames[2]:SetScale(scale);
			TreeFrames[3]:SetScale(scale);
			Frame.ObjectScale = scale;
		elseif style == 2 then
			local scale = min(
					(width) / (CT.TUISTYLE.TreeFrameXSizeSingle + CT.TUISTYLE.TreeFrameXToBorder * 2),
					(height - CT.TUISTYLE.FrameHeaderYSize - CT.TUISTYLE.FrameFooterYSize) / (CT.TUISTYLE.TreeFrameYSize + CT.TUISTYLE.TreeFrameYToBorder * 2)
				);
			TreeFrames[1]:SetScale(scale);
			TreeFrames[2]:SetScale(scale);
			TreeFrames[3]:SetScale(scale);
			Frame.ObjectScale = scale;
		end
	end
	function MT.UI.TreeUpdate(Frame, TreeIndex, force_update)
		if Frame.style ~= 2 then
			return;
		end
		if TreeIndex <= 0 or TreeIndex > 3 then
			Frame.TreeButtonsBar.CurTreeIndicator:Hide();
			return;
		end
		local TreeFrames = Frame.TreeFrames;
		local TreeButtons = Frame.TreeButtons;
		if Frame.CurTreeIndex ~= TreeIndex or force_update then
			TreeFrames[Frame.CurTreeIndex]:Hide();
			TreeFrames[TreeIndex]:Show();
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
	end

-->
