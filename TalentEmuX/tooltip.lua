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
	local hooksecurefunc = hooksecurefunc;
	local strmatch, format = string.match, string.format;
	local max = math.max;
	local concat = table.concat;
	local tonumber = tonumber;
	local UnitName = UnitName;
	local UnitIsPlayer, UnitFactionGroup, UnitIsConnected = UnitIsPlayer, UnitFactionGroup, UnitIsConnected;
	local NotifyInspect = NotifyInspect;
	local GetSpellBookItemName = GetSpellBookItemName;
	local GetActionInfo = GetActionInfo;
	local GetMacroSpell = GetMacroSpell;
	local _G = _G;
	local GameTooltip = GameTooltip;
	local ItemRefTooltip = ItemRefTooltip;

-->
	local l10n = CT.l10n;

-->		constant
-->
MT.BuildEnv('TOOLTIP');
-->		predef
-->		TOOLTIP
	--
	local TooltipUpdateFrame = {  };
	local PrevTipUnitName = {  };
	--
	local NumReservedLines = 5;
	local ReservedLinePlaceHolder = {  };
	local ReservedLine = {  };
	for i = 1, NumReservedLines do
		local ReservedText = "__[[Reserved Line Place Holder]]__ = " .. i;
		ReservedLinePlaceHolder[i] = ReservedText;
		ReservedLinePlaceHolder[ReservedText] = i;
		ReservedLine[i] = {  };
	end
	local function AddReservedLines(Tooltip)
		for i = 1, NumReservedLines do
			Tooltip:AddLine(ReservedLinePlaceHolder[i]);
			ReservedLine[i][Tooltip] = nil;
		end
		-- Tooltip:Show();
		local List = MT.TipTextLeft[Tooltip];
		for i = 1, Tooltip:NumLines() do
			local Line = List[i];
			if Line then
				local Text = Line:GetText();
				local index = ReservedLinePlaceHolder[Text];
				if index then
					ReservedLine[index][Tooltip] = Line;
				end
			end
		end
		for i = 1, NumReservedLines do
			ReservedLine[i][Tooltip]:SetText(nil);
		end
		-- Tooltip:Show();
	end
	local function TipAddTalentInfo(Tooltip, _name)
		local cache = VT.TQueryCache[_name];
		if cache ~= nil then
			local TalData = cache.TalData;
			local class = cache.class;
			if TalData ~= nil and TalData.num ~= nil and class ~= nil then
				if TalData.num > 0 then
					if VT.SET.talents_in_tip_icon then
						ReservedLine[1][Tooltip]:SetText(" ");
					end
					for group = 1, TalData.num do
						local line = group == TalData.active and "|cff00ff00>|r" or "|cff000000>|r";
						local stats = MT.CountTreePoints(TalData[group], class);
						local SpecList = DT.ClassSpec[class];
						local cap = -1;
						if stats[1] ~= stats[2] or stats[1] ~= stats[3] then
							cap = max(stats[1], stats[2], stats[3]);
						end
						for TreeIndex = 1, 3 do
							local SpecID = SpecList[TreeIndex];
							if cap == stats[TreeIndex] then
								if VT.SET.talents_in_tip_icon then
									line = line .. "  |T" .. (DT.TalentSpecIcon[SpecID] or CT.TEXTUREUNK) .. format(":16|t |cffff7f1f%2d|r", stats[TreeIndex]);
								else
									line = line .. "  |cffff7f1f" .. l10n.SPEC[SpecID] .. format(":%2d|r", stats[TreeIndex]);
								end
							else
								if VT.SET.talents_in_tip_icon then
									line = line .. "  |T" .. (DT.TalentSpecIcon[SpecID] or CT.TEXTUREUNK) .. format(":16|t |cffffffff%2d|r", stats[TreeIndex]);
								else
									line = line .. "  |cffbfbfff" .. l10n.SPEC[SpecID] .. format(":%2d|r", stats[TreeIndex]);
								end
							end
						end
						line = line .. (group == TalData.active and "  |cff00ff00<|r" or "  |cff000000<|r");
						ReservedLine[group + 1][Tooltip]:SetText(line);
					end
				end
				if VT.__supreme and cache.PakData[1] ~= nil then
					local _, info = VT.__dep.__emulib.DecodeAddOnPackData(cache.PakData[1]);
					if info ~= nil then
						local line = "|cffffffffPack|r: " .. info;
						ReservedLine[5][Tooltip]:SetText(line);
					end
				end
				Tooltip:Show();
			end
		end
	end
	local function TipAddItemInfo(Tooltip, _name)
		local cache = VT.TQueryCache[_name];
		if cache ~= nil then
			local EquData = cache.EquData;
			if EquData ~= nil then
				local Line = ReservedLine[4][Tooltip];
				if EquData.AverageItemLevel_OKay then
					local Text = format(l10n.Tooltip_ItemLevel, MT.ColorItemLevel(EquData.AverageItemLevel));
					Line:SetText(Text);
					Tooltip:Show();
				end
			end
		end
	end
	local function TipAddInfo(Tooltip, _name)
		local _, unit = Tooltip:GetUnit();
		if unit ~= nil then
			local name, realm = UnitName(unit);
			if realm ~= nil and realm ~= "" and realm ~= CT.SELFREALM then
				name = name .. "-" .. realm;
			end
			if name == _name then
				PrevTipUnitName[Tooltip] = name;
				if VT.SET.talents_in_tip then
					TipAddTalentInfo(Tooltip, _name);
				end
				if VT.SET.itemlevel_in_tip then
					TipAddItemInfo(Tooltip, _name);
				end
				return true;
			end
		end
	end
	local function OnTalentDataRecv(name)
		if VT.SET.talents_in_tip or VT.SET.itemlevel_in_tip then
			TipAddInfo(GameTooltip, name);
			TipAddInfo(ItemRefTooltip, name);
		end
	end
	local function OnTooltipSetUnitImmdiate(Tooltip)
		if VT.SET.talents_in_tip or VT.SET.itemlevel_in_tip then
			PrevTipUnitName[Tooltip] = nil;
			local _, unit = Tooltip:GetUnit();
			if unit == 'player' then
				AddReservedLines(Tooltip);
				--
				MT.SendQueryRequest(CT.SELFNAME, CT.SELFREALM, false, false, true, true, true);
			elseif unit ~= nil and UnitIsPlayer(unit) and UnitIsConnected(unit) and UnitFactionGroup(unit) == CT.SELFFACTION then
				AddReservedLines(Tooltip);
				--
				local name, realm = UnitName(unit);
				if realm ~= nil and realm ~= "" and realm ~= CT.SELFREALM then
					name = name .. "-" .. realm;
				end
				local _, tal, gly, inv = MT.CacheEmulateComm(name, realm, false, VT.SET.talents_in_tip, VT.SET.itemlevel_in_tip, VT.SET.itemlevel_in_tip);
				if not tal or not inv then
					TooltipUpdateFrame[Tooltip]:Waiting(name, realm);
					if UnitFactionGroup(unit) == CT.SELFFACTION then
						MT.SendQueryRequest(name, realm, false, false, not tal, not inv, not inv and not gly);
					end
					if MT.CanInspect(unit) then
						NotifyInspect(unit);
					end
				end
			end
		end
	end
	local function OnTooltipSetUnit(Tooltip)
		if VT.SET.talents_in_tip or VT.SET.itemlevel_in_tip then
			PrevTipUnitName[Tooltip] = nil;
			local _, unit = Tooltip:GetUnit();
			if unit == 'player' then
				AddReservedLines(Tooltip);
				--
				MT.SendQueryRequest(CT.SELFNAME, CT.SELFREALM, false, false, true, true, true);
			elseif unit ~= nil and UnitIsPlayer(unit) and UnitIsConnected(unit) then
				AddReservedLines(Tooltip);
				--
				local name, realm = UnitName(unit);
				if realm ~= nil and realm ~= "" and realm ~= CT.SELFREALM then
					name = name .. "-" .. realm;
				end
				local _, tal, gly, inv = MT.CacheEmulateComm(name, realm, false, VT.SET.talents_in_tip, VT.SET.itemlevel_in_tip, VT.SET.itemlevel_in_tip);
				if not tal or not inv then
					TooltipUpdateFrame[Tooltip]:Waiting(name, realm);
					if MT.CanInspect(unit) then
						NotifyInspect(unit);
					end
				end
			end
		end
	end

	local function TipAddSpellInfo(self, SpellID)
		local class, TreeIndex, SpecID, TalentSeq, row, col, rank = MT.QueryTalentInfoBySpellID(SpellID);
		if class ~= nil then
			local color = CT.RAID_CLASS_COLORS[class];
			self:AddDoubleLine(l10n.TALENT, l10n.CLASS[class] .. "-" .. l10n.SPEC[SpecID] .. " R" .. (row + 1) .. "-C" .. (col + 1) .. "-L" .. rank, 1.0, 1.0, 1.0, color.r, color.g, color.b);
			self:Show();
		end
	end
	local function HookSetHyperlink(self, link)
		local SpellID = strmatch(link, "spell:(%d+)");
		SpellID = tonumber(SpellID);
		if SpellID ~= nil then
			TipAddSpellInfo(self, SpellID);
		end
	end
	local function HookSetSpellBookItem(self, spellBookId, bookType)
		local _, _, SpellID = GetSpellBookItemName(spellBookId, bookType);
		SpellID = tonumber(SpellID);
		if SpellID ~= nil then
			TipAddSpellInfo(self, SpellID);
		end
	end
	local function HookSetSpellByID(self, SpellID)
		SpellID = tonumber(SpellID);
		if SpellID ~= nil then
			TipAddSpellInfo(self, SpellID);
		end
	end
	local function HookSetAction(self, slot)
		local actionType, id, subType = GetActionInfo(slot);
		if actionType == "spell" then
			TipAddSpellInfo(self, id);
		elseif actionType == "macro" then
			local SpellID = GetMacroSpell(id);
			if SpellID ~= nil then
				TipAddSpellInfo(self, SpellID);
			end
		end
	end

	local function UpdateFrameOnUpdate(UpdateFrame, elasped)
		if UpdateFrame.Tooltip:IsVisible() then
			UpdateFrame.wait = UpdateFrame.wait + elasped;
			if UpdateFrame.wait >= CT.TOOLTIP_WAIT_BEFORE_QUERY_UNIT then
				if PrevTipUnitName[UpdateFrame.Tooltip] ~= nil then
					UpdateFrame:Hide();
				end
				UpdateFrame.wait = 0.0;
				local _, unit = UpdateFrame.Tooltip:GetUnit();
				if unit ~= nil and UnitIsPlayer(unit) and UnitIsConnected(unit) then
					local name, realm = UnitName(unit);
					if realm ~= nil and realm ~= "" and realm ~= CT.SELFREALM then
						name = name .. "-" .. realm;
					end
					if name == UpdateFrame.name and realm == UpdateFrame.realm then
						local _, tal, gly, inv = MT.CacheEmulateComm(name, realm, false, VT.SET.talents_in_tip, VT.SET.itemlevel_in_tip, VT.SET.itemlevel_in_tip);
						if not tal or not inv then
							if UnitFactionGroup(unit) == CT.SELFFACTION then
								MT.SendQueryRequest(name, realm, false, false, not tal, not inv, not inv and not gly);
							end
							if MT.CanInspect(unit) then
								NotifyInspect(unit);
							end
						else
							UpdateFrame:Hide();
						end
					end
				else
					UpdateFrame:Hide();
				end
			end
		else
			UpdateFrame:Hide();
		end
	end
	local function UpdateFrameWaiting(UpdateFrame, name, realm)
		UpdateFrame.name = name;
		UpdateFrame.realm = realm;
		UpdateFrame.wait = 0;
		UpdateFrame:Show();
	end

	local function HookTooltip(Tooltip, OnTooltipSetUnit)
		--	hooksecurefunc(Tooltip, "SetUnit", OnTooltipSetUnit);
		Tooltip:HookScript("OnTooltipSetUnit", OnTooltipSetUnit);
		--
		hooksecurefunc(Tooltip, "SetHyperlink", HookSetHyperlink);
		hooksecurefunc(Tooltip, "SetSpellBookItem", HookSetSpellBookItem);
		hooksecurefunc(Tooltip, "SetSpellByID", HookSetSpellByID);
		hooksecurefunc(Tooltip, "SetAction", HookSetAction);

		UpdateFrame = CreateFrame('FRAME');
		UpdateFrame:Hide();
		UpdateFrame:SetSize(1, 1);
		UpdateFrame:SetAlpha(0);
		UpdateFrame:EnableMouse(false);
		UpdateFrame:SetPoint("BOTTOM");
		UpdateFrame:SetScript("OnUpdate", UpdateFrameOnUpdate);
		UpdateFrame.Tooltip = Tooltip;
		UpdateFrame.Waiting = UpdateFrameWaiting;
		TooltipUpdateFrame[Tooltip] = UpdateFrame;
	end
	MT.RegisterOnInit('TOOLTIP', function(LoggedIn)
		MT._RegisterCallback("CALLBACK_TALENT_DATA_RECV", OnTalentDataRecv);
		MT._RegisterCallback("CALLBACK_AVERAGE_ITEM_LEVEL_OK", OnTalentDataRecv);

		HookTooltip(GameTooltip, OnTooltipSetUnit);
		HookTooltip(ItemRefTooltip, OnTooltipSetUnitImmdiate);
	end);
	MT.RegisterOnLogin('TOOLTIP', function(LoggedIn)
	end);

-->
