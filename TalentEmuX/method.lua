--[[--
	by ALA
--]]--
----------------------------------------------------------------------------------------------------
local __addon, __private = ...;
local MT = __private.MT;
local CT = __private.CT;
local VT = __private.VT;
local DT = __private.DT;

-->		upvalue
	local pcall = pcall;
	local type = type;
	local next = next;
	local select = select;
	local tremove, concat = table.remove, table.concat;
	local strtrim, strupper, strsub, strmatch, format, gsub = string.trim, string.upper, string.sub, string.match, string.format, string.gsub;
	local min, max = math.min, math.max;
	local band = bit.band;
	local tonumber = tonumber;
	local random = random;
	local UnitLevel = UnitLevel;
	local UnitIsDeadOrGhost = UnitIsDeadOrGhost;
	local GetSpellInfo = GetSpellInfo;
	local GetTalentTabInfo, GetNumTalents, GetTalentInfo, LearnTalent = GetTalentTabInfo, GetNumTalents, GetTalentInfo, LearnTalent;
	local GetPrimaryTalentTree, SetPrimaryTalentTree = GetPrimaryTalentTree, SetPrimaryTalentTree;
	local GetItemInfoInstant = GetItemInfoInstant;
	local GetItemInfo = GetItemInfo;
	local GetItemInventoryTypeByID = C_Item and C_Item.GetItemInventoryTypeByID;
	local GetItemSetInfo = C_Item and C_Item.GetItemSetInfo or GetItemSetInfo;
	local InCombatLockdown = InCombatLockdown;
	local CheckInteractDistance = CheckInteractDistance;
	local CanInspect = CanInspect;
	local CreateFrame = CreateFrame;
	local _G = _G;
	local UIParent = UIParent;
	local GameTooltip = GameTooltip;

-->
	local l10n = CT.l10n;

-->		constant
-->
MT.BuildEnv('METHOD');
-->		predef
-->		METHOD
	--
	-->		Touch Item Tooltip
		local TouchTipName = "Emu_TouchTip" .. (MT.GetUnifiedTime() + 1) .. random(1000000, 10000000);
		local TouchTip = CreateFrame('GAMETOOLTIP', TouchTipName, UIParent, "GameTooltipTemplate");
		function MT.TouchItemTip(item)
			TouchTip:SetOwner(UIParent, "ANCHOR_RIGHT");
			TouchTip:SetHyperlink(item);
			TouchTip:Show();
			TouchTip:Hide();
		end
	-->		ItemLevel
		local _ItemTryTimes = {  };
		function MT.CalcItemLevel(class, EquData)
			local slots = { 1, 2, 3, 5, 6, 7, 8,9, 10, 11, 12, 13, 14, 15, };
			if class ~= "DRUID" and class ~= "PALADIN" and class ~= "SHAMAN" then
				slots[#slots + 1] = 18;
			end
			slots[#slots + 1] = 16;
			slots[#slots + 1] = 17;		--	make it the last in table
			--	16MainHand, 17OffHand, 18Ranged
			local refresh_again = false;
			local total = 0;
			local num1, num2 = 0, 0;
			for index = 1, #slots do
				num1 = num1 + 1;
				local slot = slots[index];
				local item = EquData[slot];
				if item ~= nil and item ~= "" then
					local _, _, _, level, _, _, _, _, loc = GetItemInfo(item);
					if level ~= nil then
						total = total + level;
						num2 = num2 + 1;
					else
						_ItemTryTimes[item] = (_ItemTryTimes[item] or 0) + 1;
						if _ItemTryTimes[item] < 10 then
							refresh_again = true;
						end
					end
					if slot == 16 and loc == "INVTYPE_2HWEAPON" then
						break;
					end
				end
			end
			if num1 == 0 or num2 == 0 then
				return;
			end
			local lv1 = total / num1 + 0.05;
			lv1 = lv1 - lv1 % 0.1;
			local lv2 = total / num2 + 0.05;
			lv2 = lv2 - lv2 % 0.1;
			return lv1, lv2, refresh_again;
		end
		local function _CalcItemLevel()
			local continue = false;
			for name, cache in next, VT.TQueryCache do
				local class = cache.class
				local EquData = cache.EquData;
				if class and EquData and not EquData.AverageItemLevel_OKay then
					local itemLevel1, itemLevel2, refresh_again = MT.CalcItemLevel(class, EquData);
					EquData.AverageItemLevel = itemLevel1;
					EquData.AverageItemLevel_ = itemLevel2;
					if not refresh_again then
						if itemLevel1 ~= nil then
							EquData.AverageItemLevel_OKay = true;
						end
						MT.CALLBACK.OnInventoryDataRecv(name, false, false);
						MT._TriggerCallback("CALLBACK_AVERAGE_ITEM_LEVEL_OK", name);
					else
						continue = true;
					end
				end
			end
			if continue then
				MT._TimerStart(_CalcItemLevel, 0.2, 1);
			end
		end
		function MT.ScheduleCalcItemLevel()
			MT._TimerStart(_CalcItemLevel, 0.2, 1);
		end
		local _ColorStep = DT.ItemLevelColor.step;
		local _ColorList = DT.ItemLevelColor.list;
		local _ColorLen = min(#_ColorStep, #_ColorList);
		function MT.GetItemLevelColor(level)
			if not level or level <= _ColorStep[1] then
				local c = _ColorList[1];
				return c[1], c[2], c[3];
			elseif level > _ColorStep[_ColorLen] then
				local c = _ColorList[_ColorLen];
				return c[1], c[2], c[3];
			else
				for i = 2, _ColorLen do
					if level == _ColorStep[i] then
						local c = _ColorList[i];
						return c[1], c[2], c[3];
					elseif level < _ColorStep[i] then
						local c1 = _ColorList[i - 1];
						local c2 = _ColorList[i];
						local r = (level - _ColorStep[i - 1]) / (_ColorStep[i] - _ColorStep[i - 1]);
						return c1[1] + r * (c2[1] - c1[1]), c1[2] + r * (c2[2] - c1[2]), c1[3] + r * (c2[3] - c1[3]);
					end
				end
			end
			return 1.0, 0.0, 0.0;
		end
		function MT.ColorItemLevel(level)
			local r, g, b = MT.GetItemLevelColor(level);
			return format("|cff%.2x%.2x%.2x%.1f|r", r * 255, g * 255, b * 255, level or 0);
		end
	-->		ItemSet Tooltip
		--[[
			ItemSet
				ID(1)	ItemID(6-22)
			ItemSetSpell
				Threshold(4)	SetID(5)
		--]]
		--	ITEM_SET_BONUS_GRAY = "(%d) 套装: %s"
		local ITEM_SET_BONUS_GRAY = ITEM_SET_BONUS_GRAY;
		--	ITEM_SET_BONUS = "套装: %s"
		local ITEM_SET_BONUS = ITEM_SET_BONUS;
		local pattern_threshold_grey = gsub(gsub(ITEM_SET_BONUS_GRAY, "%(%%d%)", "%%((%%d+)%%)"), "%%s", "(.+)");
		local pattern_threshold = gsub(ITEM_SET_BONUS, "%%s", "(.+)");
		function MT.ColorItemSet(Node, Tooltip)
			local _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, setID = GetItemInfo(Node.link);
			if not setID then
				return;
			end
			local setName = GetItemSetInfo(setID);
			if not setName then
				return
			end
			local cache = VT.TQueryCache[Node.EquipmentContainer.Frame.name];
			if cache == nil then
				return;
			end
			local EquData = cache.EquData;
			if EquData.SetInfo == nil then
				return;
			end
			local val = EquData.SetInfo[setID] or 0;
			local pattern = '^(' .. setName .. '.+)(%d+)/(%d+)(.+)$';
			local List = MT.TipTextLeft[Tooltip];
			for index = 2, Tooltip:NumLines() do
				local Line = List[index];
				if Line then
					local Text = Line:GetText();
					if Text and Text ~= "" then
						local pre, _, cap, suf = strmatch(Text, pattern);
						if pre then
							Line:SetText(pre .. val .. "/" .. cap .. suf);
							local SetInfo = DT.ItemSet[setID];
							if SetInfo then
								local hash = {  };
								for i = 1, #SetInfo do
									hash[SetInfo[i]] = i;
								end
								for slot = 1, 18 do
									local item = EquData[slot];
									if item then
										local _, link, _, _, _, _, _, _, loc, _, _, _, _, _, _, set = GetItemInfo(item);
										if set == setID and SetInfo[loc] then
											local Line = List[index + SetInfo[loc]];
											if Line then
												Line:SetTextColor(1.0, 1.0, 0.6);
											end
											local id = SetInfo[SetInfo[loc]];
											hash[id] = nil;
										else
											local id = GetItemInfoInstant(item);
											if id and hash[id] then
												local Line = List[index + hash[id]];
												if Line then
													Line:SetTextColor(1.0, 1.0, 0.6);
												end
												hash[id] = nil;
											end
										end
									end
								end
								for id, i in next, hash do
									List[index + i]:SetTextColor(0.5, 0.5, 0.5);
								end
								local ThresholdInfo = DT.ItemSetThreshold[setID];
								if ThresholdInfo then
									local pos = 0;
									for i = index + #SetInfo + 1, Tooltip:NumLines() do
										local Line = List[i];
										if Line then
											local Text = Line:GetText();
											if Text and Text ~= "" then
												local count, desc = strmatch(Text, pattern_threshold_grey);
												if not count then
													desc = strmatch(Text, pattern_threshold);
												end
												if desc then
													pos = pos + 1;
													count = ThresholdInfo[pos];
													if val >= count then
														Line:SetText(format(ITEM_SET_BONUS, desc));
														Line:SetTextColor(0.1, 1, 0.1)
													else
														Line:SetText(format(ITEM_SET_BONUS_GRAY, count, desc));
														Line:SetTextColor(0.5, 0.5, 0.5);
													end
													if pos == #ThresholdInfo then
														break;
													end
												end
											end
										end
									end
								end
							end
							break;
						end
					end
				end
			end
		end
	-->		Enchant
		--[[
			SpellEffect
				Effect(4)==53	EffectMiscValue_0(26) = EnchantID   SpellID(last)
			SpellEquippedItems
				SpellID(2)	EquippedItemClass(3)	EquippedItemInvTypes(4)	EquippedItemSubclass(5)
			ItemEffect
				SpellID(8)	ParentItemID(10, also the last)

			local function bitflag(x, y)
				x = x / y;
				return (x - x % 1) % 2 > 0;
			end
		--]]
		function MT.GetEnchantInfo(class, slot, item)
			-- local itemID, class, subClass, loc, icon, classID, subClassID = GetItemInfoInstant(item);
			-- local itemName, link, quality, level, _, class, subClass, stack, loc, icon, price, classID, subClassID, bindType, _, set, isReagent = GetItemInfo(item);
			local _, link, _, level, _, _, _, _, loc, _, _, classID, subClassID = GetItemInfo(item);
			if link == nil then
				return;
			end
			local enchantable = DT.EnchantableByLoc[loc];
			local UnE = DT.UnenchantableByType[classID];
			if UnE then
				local u = UnE[subClassID];
				if u == 1 then
					enchantable = false;
				elseif u ~= nil and u ~= class then
					enchantable = false;
				end
			end
			local itemID, enchantID = strmatch(item, "item:(%d+):(%d+):");
			if enchantID == nil then
				return enchantable, false, link or item, level or 0;
			end
			enchantID = tonumber(enchantID);
			local invType = GetItemInventoryTypeByID(item);
			local D = DT.EnchantDB[classID];
			if D == nil then
				return enchantable, true, link or item, level or 0, "Enchant: " .. enchantID;
			end
			D = D[enchantID];
			if D == nil then
				return true, true, link or item, level or 0, "Enchant: " .. enchantID;
			end
			for i = 1, #D do
				local d = D[i];
				if (d[1] == nil or band(d[1], subClassID * 2)) and (d[2] == nil or band(d[2], invType * 2)) then
					if d[4] then
						return true, true, link or item, level or 0, GetItemInfo(d[4]) or (d[3] and GetSpellInfo(d[3])) or ("Item: " .. d[4]);
					elseif d[3] then
						return true, true, link or item, level or 0, GetSpellInfo(d[3]) or ("Spell:: " .. d[3]);
					else
						return true, true, link or item, level or 0, "Enchant: " .. enchantID;
					end
				end
			end
			return true, true, link or item, level or 0, "Enchant: " .. enchantID;
		end
	-->		Gem
	if VT.__support_gem then
		--
		local Enum = _G.Enum;
		local CLASSID_GEM = Enum.ItemClass.Gem;
		local ItemGemSubclass = Enum.ItemGemSubclass;
		--[[
			Red = 0,
			Blue = 1,
			Yellow = 2,
			Purple = 3,
			Green = 4,
			Orange = 5,
			Meta = 6,
			Simple = 7,
			Prismatic = 8,
		--]]
		--
		local ScanTipName = "Emu_ScanTip" .. (MT.GetUnifiedTime() + 1) .. random(1000000, 10000000);
		local ScanTip = CreateFrame('GAMETOOLTIP', ScanTipName, UIParent, "GameTooltipTemplate");
		local ScanTipTextures = {  };
		local ScanTipTexturePrefix = ScanTipName .. "Texture";
		for index = 1, 10 do
			ScanTipTextures[index] = _G[ScanTipTexturePrefix .. index];
		end
		local _GemInfoCache = {  };
		function MT.ScanGemInfo(item, returnStr)
			local v = _GemInfoCache[item];
			if v ~= nil and (v[7] ~= nil or not returnStr) then
				return v[1], v[2], v[3], v[4], v[5], v[6], v[7];
			end
			ScanTip:SetOwner(UIParent, "ANCHOR_RIGHT");
			ScanTip:SetHyperlink(item);
			ScanTip:Show();
			local A = 0;
			local T, M, R, Y, B = 0, 0, 0, 0, 0;
			local S = { strmatch(item, "item:%d+:?[-%d]*:?(%d*):?(%d*):?(%d*):?(%d*)") };
			if returnStr then
				returnStr = "";
			end
			for index = 1, 4 do
				local v = S[index];
				if v ~= "" and v ~= nil then
					local id, class, subClass, _, icon, classID, subClassID = GetItemInfoInstant(v);
					if classID == CLASSID_GEM then
						if subClassID == ItemGemSubclass.Red then
							S[index] = l10n.EquipmentList_Gem.Red;
						elseif subClassID == ItemGemSubclass.Orange then
							S[index] = l10n.EquipmentList_Gem.Orange;
						elseif subClassID == ItemGemSubclass.Yellow then
							S[index] = l10n.EquipmentList_Gem.Yellow;
						elseif subClassID == ItemGemSubclass.Green then
							S[index] = l10n.EquipmentList_Gem.Green;
						elseif subClassID == ItemGemSubclass.Blue then
							S[index] = l10n.EquipmentList_Gem.Blue;
						elseif subClassID == ItemGemSubclass.Purple then
							S[index] = l10n.EquipmentList_Gem.Purple;
						elseif subClassID == ItemGemSubclass.Prismatic then
							S[index] = l10n.EquipmentList_Gem.Prismatic;
						elseif subClassID == ItemGemSubclass.Meta then
							S[index] = l10n.EquipmentList_Gem.Meta;
						else
						end
					else
						S[index] = nil;
					end
				else
					S[index] = nil;
				end
			end
			for index = 1, 10 do
				local Texture = ScanTipTextures[index] or _G[ScanTipTexturePrefix .. index];
				ScanTipTextures[index] = Texture;
				if Texture == nil or not Texture:IsShown() then
					break;
				end
				if S[index] ~= nil then
					A = A + 1;
					if returnStr then
						returnStr = returnStr .. S[index];
					end
				else
					local v = Texture:GetTexture();
					if v == 136256 then			--	B	136256	Inerface\ItemSocketingFrame\UI-EmptySocket-Meta.blp
						T = T + 1;
						B = B + 1;
						if returnStr then
							returnStr = returnStr .. l10n.EquipmentList_MissGem.Blue;
						end
					elseif v == 136257 then		--	M	136257	Inerface\ItemSocketingFrame\UI-EmptySocket-Blue.blp
						T = T + 1;
						M = M + 1;
						if returnStr then
							returnStr = returnStr .. l10n.EquipmentList_MissGem.Meta;
						end
					elseif v == 136258 then		--	R	136258	Inerface\ItemSocketingFrame\UI-EmptySocket-Red.blp
						T = T + 1;
						R = R + 1;
						if returnStr then
							returnStr = returnStr .. l10n.EquipmentList_MissGem.Red;
						end
					elseif v == 136259 then		--	Y	136259	Inerface\ItemSocketingFrame\UI-EmptySocket-Yellow.blp
						T = T + 1;
						Y = Y + 1;
						if returnStr then
							returnStr = returnStr .. l10n.EquipmentList_MissGem.Yellow;
						end
					else
						if returnStr then
							returnStr = returnStr .. l10n.EquipmentList_MissGem["?"];
						end
					end
				end
			end
			ScanTip:Hide();
			if v ~= nil then
				v[1] = A;
				v[2] = T;
				v[3] = M;
				v[4] = R;
				v[5] = Y;
				v[6] = B;
				v[7] = returnStr or v[7];
			else
				_GemInfoCache[item] = { A, T, M, R, Y, B, returnStr, };
			end
			return A, T, M, R, Y, B, returnStr;
		end
		function MT.SummaryGem(EquData)
			local GemStat = {
				[ItemGemSubclass.Red] = 0,
				[ItemGemSubclass.Yellow] = 0,
				[ItemGemSubclass.Blue] = 0,
			};
			local r, y, b = 0, 0, 0;
			for slot = 1, 18 do
				local item = EquData[slot];
				if item then
					local S = { strmatch(item, "item:%d+:?[-%d]*:?(%d*):?(%d*):?(%d*):?(%d*)") };
					for index = 1, 4 do
						local v = S[index];
						if v ~= "" and v ~= nil then
							local id, _, _, _, _, classID, subClassID = GetItemInfoInstant(v);
							if classID == CLASSID_GEM then
								if subClassID == ItemGemSubclass.Red then
									GemStat[ItemGemSubclass.Red] = GemStat[ItemGemSubclass.Red] + 1;
								elseif subClassID == ItemGemSubclass.Orange then
									GemStat[ItemGemSubclass.Red] = GemStat[ItemGemSubclass.Red] + 1;
									GemStat[ItemGemSubclass.Yellow] = GemStat[ItemGemSubclass.Yellow] + 1;
								elseif subClassID == ItemGemSubclass.Yellow then
									GemStat[ItemGemSubclass.Yellow] = GemStat[ItemGemSubclass.Yellow] + 1;
								elseif subClassID == ItemGemSubclass.Green then
									GemStat[ItemGemSubclass.Yellow] = GemStat[ItemGemSubclass.Yellow] + 1;
									GemStat[ItemGemSubclass.Blue] = GemStat[ItemGemSubclass.Blue] + 1;
								elseif subClassID == ItemGemSubclass.Blue then
									GemStat[ItemGemSubclass.Blue] = GemStat[ItemGemSubclass.Blue] + 1;
								elseif subClassID == ItemGemSubclass.Purple then
									GemStat[ItemGemSubclass.Red] = GemStat[ItemGemSubclass.Red] + 1;
									GemStat[ItemGemSubclass.Blue] = GemStat[ItemGemSubclass.Blue] + 1;
								elseif subClassID == ItemGemSubclass.Prismatic then
									GemStat[ItemGemSubclass.Red] = GemStat[ItemGemSubclass.Red] + 1;
									GemStat[ItemGemSubclass.Yellow] = GemStat[ItemGemSubclass.Yellow] + 1;
									GemStat[ItemGemSubclass.Blue] = GemStat[ItemGemSubclass.Blue] + 1;
								elseif subClassID == ItemGemSubclass.Meta then
								else
								end
							end
						end
					end
				end
			end
			EquData.GemStat = { r, y, b, };
		end
		local pattern = "|cff%x%x%x%x%x%x" .. ENCHANT_CONDITION_REQUIRES;
		--	ENCHANT_CONDITION_MORE_VALUE = "至少%d颗%s宝石"
		local pattern1 = gsub(gsub(ENCHANT_CONDITION_MORE_VALUE, "%%s", "(.+)"), "%%d", "(%%d+)");
		--	ENCHANT_CONDITION_MORE_COMPARE = "%s宝石的数量多余%s宝石"
		local pattern2 = gsub(ENCHANT_CONDITION_MORE_COMPARE, "%%s", "(.+)");
		local GemReverse = {
			[RED_GEM] = Enum.ItemGemSubclass.Red,
			[YELLOW_GEM] = Enum.ItemGemSubclass.Yellow,
			[BLUE_GEM] = Enum.ItemGemSubclass.Blue,
		};
		local function IsGemOK(Text, GemStat)
			local p1, p2 = strmatch(Text, pattern1);
			if p1 then
				p1 = tonumber(p1) or 0;
				p2 = GemStat[GemReverse[p2]] or 0;
				if p1 >= p2 then
					return true;
				end
			else
				p1, p2 = strmatch(Text, pattern2);
				if p1 then
					p1 = GemStat[GemReverse[p1]] or 0;
					p2 = GemStat[GemReverse[p2]] or 0;
					if p1 > p2 then
						return true;
					end
				end
			end
			return false;
		end
		function MT.ColorMetaGem(Node, Tooltip)
			local _, _, _, loc = GetItemInfoInstant(Node.link);
			if loc ~= "INVTYPE_HEAD" then
				return;
			end
			local cache = VT.TQueryCache[Node.EquipmentContainer.Frame.name];
			if cache == nil then
				return;
			end
			local GemStat = cache.EquData.GemStat;
			if GemStat == nil then
				return;
			end
			local List = MT.TipTextLeft[Tooltip];
			for index = 4, Tooltip:NumLines() do
				local Line = List[index];
				if Line then
					local Text = Line:GetText();
					if Text and strfind(Text, pattern) then
						local S = { strsplit("\n", Text) };
						for i = #S, 1, -1 do
							if S[i] == "" or S[i] == nil then
								tremove(S, i);
							end
						end
						local ok = true;
						for i = 2, #S do
							if IsGemOK(S[i], GemStat) then
								S[i] = gsub(S[i], "|cff%x%x%x%x%x%x", "|cffffffff");
							else
								S[i] = gsub(S[i], "|cff%x%x%x%x%x%x", "|cff808080");
								ok = false;
							end
						end
						if ok then
							S[1] = gsub(S[1], "|cff%x%x%x%x%x%x", "|cffffffff");
						else
							S[1] = gsub(S[1], "|cff%x%x%x%x%x%x", "|cff808080");
						end
						Line:SetText(concat(S, "\n"));
					end
				end
			end
		end
	else
		function MT.ScanGemInfo()
			return 0, 0, 0, 0, 0, 0, "";
		end
		function MT.SummaryGem()
		end
		function MT.ColorMetaGem()
		end
	end
	-->

	function MT.GeneralOnEnter(self, motion)
		if self.information then
			GameTooltip:SetOwner(self, "ANCHOR_LEFT");
			GameTooltip:SetText(self.information, 1.0, 1.0, 1.0);
		end
	end
	function MT.GeneralOnLeave(self, motion)
		if GameTooltip:IsOwned(self) then
			GameTooltip:Hide();
		end
	end
	local function BuildPoints2Level(Level2Points, Points2Level)
		Points2Level = Points2Level or {  };
		for level = #Level2Points, 1, -1 do
			Points2Level[Level2Points[level]] = level;
		end
		for points = Level2Points[DT.MAX_LEVEL], 1, -1 do
			if Points2Level[points] == nil then
				Points2Level[points] = Points2Level[points + 1];
			end
		end
		Points2Level[0] = Points2Level[1];
		return Points2Level;
	end
	DT.PointsRequiredLevelTable = BuildPoints2Level(DT.LevelAvailablePointsTable);
	if DT.LevelAvailablePointsTableClass ~= nil then
		for class, Level2Points in next, DT.LevelAvailablePointsTableClass do
			DT.PointsRequiredLevelTable[class] = BuildPoints2Level(Level2Points);
		end
	else
		DT.LevelAvailablePointsTableClass = {  };
	end
	function MT.GetPointsReqLevel(class, points)
		-- return max(10, 9 + numPoints);
		local ref = DT.PointsRequiredLevelTable[class] or DT.PointsRequiredLevelTable;
		return ref[points] or DT.MAX_LEVEL;
	end
	function MT.GetLevelAvailablePoints(class, level)
		-- return max(0, level - 9);
		local ref = DT.LevelAvailablePointsTableClass[class] or DT.LevelAvailablePointsTable;
		return ref[level] or 0;
	end
	function MT.CountTreePoints(data, class)
		local ClassTDB = DT.TalentDB[class];
		local SpecList = DT.ClassSpec[class];
		local pos = 1;
		local len = #data;
		local stats = { 0, 0, 0, };
		for TreeIndex = 1, 3 do
			local total = 0;
			for j = 1, #ClassTDB[SpecList[TreeIndex]] do
				if pos > len then
					break;
				end
				local val = strsub(data, pos, pos);
				total = total + tonumber(val);
				pos = pos + 1;
			end
			stats[TreeIndex] = total;
		end
		return stats;
	end
	function MT.GenerateTitle(class, stats, uncolored)
		local SpecList = DT.ClassSpec[class];
		if uncolored then
			local title = l10n.CLASS[class];
			for TreeIndex = 1, 3 do
				title = title .. " " .. l10n.SPEC[SpecList[TreeIndex]] .. format("%2d", stats[TreeIndex]);
			end
			return title;
		else
			local title = "|c" .. CT.RAID_CLASS_COLORS[class].colorStr .. l10n.CLASS[class] .. "|r-";
			local temp = max(stats[1], stats[2], stats[3]);
			if temp == stats[1] and temp == stats[2] and temp == stats[3] then
				temp = temp + 1023;
			end
			for TreeIndex = 1, 3 do
				if temp == stats[TreeIndex] then
					title = title .. " |cff7fbfff" .. l10n.SPEC[SpecList[TreeIndex]] .. format("%2d|r", stats[TreeIndex]);
				else
					title = title .. " " .. l10n.SPEC[SpecList[TreeIndex]] .. format("%2d", stats[TreeIndex]);
				end
			end
			return title;
		end
	end
	function MT.GenerateTitleFromRawData(data, class, uncolored)
		local Type = type(data);
		if Type == 'table' then
			local TreeFrames = data.TreeFrames;
			return MT.GenerateTitle(data.class, { TreeFrames[1].TalentSet.Total, TreeFrames[2].TalentSet.Total, TreeFrames[3].TalentSet.Total, }, uncolored);
		elseif Type == 'string' and type(class) == 'string' and DT.TalentDB[class] ~= nil then
			return MT.GenerateTitle(class, MT.CountTreePoints(data, class), uncolored);
		end
	end
	function MT.GenerateLink(title, class, code)
		return "|Hemu:" .. code .. "|h|c" .. CT.RAID_CLASS_COLORS[class].colorStr .. "[" .. title .. "]|r|h";
	end
	function MT.GetTreeNodeIndex(TalentDef)
		return TalentDef[1] * DT.MAX_NUM_COL + TalentDef[2] + 1;
	end

	function MT.TalentConversion(class, level, numGroup, activeGroup, data1, data2)
		if CT.TOCVERSION < 30000 then
			return class, level, numGroup, activeGroup, data1, data2;
		end
		local ClassTDB = DT.TalentDB[class];
		local SpecList = DT.ClassSpec[class];
		local Map = VT.__dep.__emulib.GetTalentMap(class) or VT.MAP[class] or (DT.TalentMap ~= nil and DT.TalentMap[class]) or nil;
		if Map == nil then
			local ofs = 0;
			for SpecIndex = 1, 3 do
				local TreeTDB = ClassTDB[SpecList[SpecIndex]];
				local num = #TreeTDB;
				for TalentSeq = 1, num do
					local val = tonumber(strsub(data1, ofs + TalentSeq, ofs + TalentSeq)) or 0;
					if val > TreeTDB[TalentSeq][4] then
						return nil;
					end
				end
				ofs = ofs + num;
			end
			return class, level, 1, 1, data1;
		end
		local conv = {  };
		local pos = 0;
		local VMap = Map.VMap;
		local ofs = 0;
		local len = #data1;
		for SpecIndex = 1, 3 do
			local TreeTDB = ClassTDB[SpecList[SpecIndex]];
			local VM = VMap[SpecIndex];
			local num = #VM;
			for TalentSeq = 1, num do
				local TalentIndex = VM[TalentSeq];
				local val = tonumber(strsub(data1, ofs + TalentIndex, ofs + TalentIndex)) or 0;
				if val > TreeTDB[TalentSeq][4] then
					return class, level, 1, 1, data1;
				end
				pos = pos + 1;
				conv[pos] = val;
			end
			ofs = ofs + num;
		end
		return class, level, 1, 1, concat(conv);
	end
	--	arg			code, useCodeLevel
	--	return		class, level, data
	function MT.DecodeTalent(code)
		local version, class, level, numGroup, activeGroup, data1, data2 = VT.__dep.__emulib.DecodeTalentData(code);
		if version == "V1" and CT.TOCVERSION >= 30000 and class ~= nil then
			return MT.TalentConversion(class, level, numGroup, activeGroup, data1, data2);
		else
			return class, level, numGroup, activeGroup, data1, data2;
		end
	end
	--	arg			[Frame] or [class, level, data]
	--	return		code
	function MT.EncodeTalent(class, level, data)
		local TypeClass = type(class);
		if TypeClass == 'table' then
			local Frame = class;
			local TreeFrames = Frame.TreeFrames;
			if type(TreeFrames) == 'table' and
						type(TreeFrames[1]) == 'table' and type(TreeFrames[1].TalentSet) == 'table' and
						type(TreeFrames[2]) == 'table' and type(TreeFrames[2].TalentSet) == 'table' and
						type(TreeFrames[3]) == 'table' and type(TreeFrames[3].TalentSet) == 'table'
				then
				--
				local activeGroup = Frame.activeGroup;
				local TalData = Frame.TalData;
				if activeGroup ~= nil and TalData ~= nil and TalData.num ~= nil then
					if TalData.num == 2 then
						local T2 = activeGroup == 1 and TalData[2] or TalData[1];
						if T2 ~= nil then
							local D1, D2, D3, N1, N2, N3 = TreeFrames[1].TalentSet, TreeFrames[2].TalentSet, TreeFrames[3].TalentSet,
										#TreeFrames[1].TreeTDB, #TreeFrames[2].TreeTDB, #TreeFrames[3].TreeTDB
							local T1 = {  };
							local len = 0;
							for index = 1, N1 do len = len + 1; T1[len] = D1[index] or 0; end
							for index = 1, N2 do len = len + 1; T1[len] = D2[index] or 0; end
							for index = 1, N3 do len = len + 1; T1[len] = D3[index] or 0; end
							local code1, data1, lenc1, lend1 = VT.__dep.__emulib.EncodeTalentBlock(T1, len);
							local code2, data2, lenc2, lend2 = VT.__dep.__emulib.EncodeTalentBlock(T2, #T2);
							if activeGroup == 1 then
							return VT.__dep.__emulib.MergeTalentCodeV2(DT.ClassToIndex[Frame.class], Frame.level, activeGroup, 2, T1, len, T2, #T2);
							else
							return VT.__dep.__emulib.MergeTalentCodeV2(DT.ClassToIndex[Frame.class], Frame.level, activeGroup, 2, T2, #T2, T1, len);
							end
						else
							return VT.__dep.__emulib.EncodeFrameTalentDataV2(DT.ClassToIndex[Frame.class], Frame.level,
										TreeFrames[1].TalentSet, TreeFrames[2].TalentSet, TreeFrames[3].TalentSet,
										#TreeFrames[1].TreeTDB, #TreeFrames[2].TreeTDB, #TreeFrames[3].TreeTDB
									);
						end
					else
							return VT.__dep.__emulib.EncodeFrameTalentDataV2(DT.ClassToIndex[Frame.class], Frame.level,
										TreeFrames[1].TalentSet, TreeFrames[2].TalentSet, TreeFrames[3].TalentSet,
										#TreeFrames[1].TreeTDB, #TreeFrames[2].TreeTDB, #TreeFrames[3].TreeTDB
									);
					end
				else
							return VT.__dep.__emulib.EncodeFrameTalentDataV2(DT.ClassToIndex[Frame.class], Frame.level,
										TreeFrames[1].TalentSet, TreeFrames[2].TalentSet, TreeFrames[3].TalentSet,
										#TreeFrames[1].TreeTDB, #TreeFrames[2].TreeTDB, #TreeFrames[3].TreeTDB
									);
				end
				--
			else
				MT.Debug("MT.EncodeTalent", 1, "class", 'table');
				return nil;
			end
		else
			local classIndex = nil;
			if TypeClass == 'number' then
				classIndex = class;
				class = DT.IndexToClass[class];
				if classIndex == nil then
					MT.Debug("MT.EncodeTalent", 2, "class", 'number', class);
					return nil;
				end
			elseif TypeClass == 'string' then
				classIndex = DT.ClassToIndex[class];
				if classIndex == nil then
					MT.Debug("MT.EncodeTalent", 3, "class", 'string', class);
					return nil;
				end
			else
				MT.Debug("MT.EncodeTalent", 4, "class", TypeClass, class);
				return nil;
			end
			local TypeData = type(data);
			if TypeData == 'string' then
				local ClassTDB = DT.TalentDB[class];
				local SpecList = DT.ClassSpec[class];
				return VT.__dep.__emulib.EncodeFrameTalentDataV2(classIndex, (level ~= nil and tonumber(level)) or DT.MAX_LEVEL,
							data,
							#ClassTDB[SpecList[1]], #ClassTDB[SpecList[2]], #ClassTDB[SpecList[3]]);
			elseif TypeData == 'table' and type(data[1]) == 'table' and type(data[2]) == 'table' and type(data[3]) == 'table' then
				local ClassTDB = DT.TalentDB[class];
				local SpecList = DT.ClassSpec[class];
				return VT.__dep.__emulib.EncodeFrameTalentDataV2(classIndex, (level ~= nil and tonumber(level)) or DT.MAX_LEVEL,
							data[1], data[2], data[3],
							#ClassTDB[SpecList[1]], #ClassTDB[SpecList[2]], #ClassTDB[SpecList[3]]);
			else
				MT.Debug("MT.EncodeTalent", 5, "data type", TypeData);
				return nil;
			end
		end
	end
	function MT.EncodeGlyph(Frame)
		local GlyphContainer = Frame.GlyphContainer;
		if GlyphContainer ~= nil then
			local GlyphNodes = GlyphContainer.GlyphNodes;
			local data = {  };
			for index = 1, 6 do
				local Node = GlyphNodes[index];
				if Node.SpellID ~= nil then
					data[index] = { 1, Node.Type, Node.SpellID, Node.Texture, };
				end
			end
			return VT.__dep.__emulib.EncodeGlyphDataV2(1, 1, data);
		end
		return nil;
	end
	function MT.EncodeEquipment(Frame)
		local EquipmentNodes = Frame.EquipmentContainer.EquipmentNodes;
		local DataTable = {  };
		for slot = 1, 19 do
			DataTable[slot] = EquipmentNodes[slot].item;
		end
		return VT.__dep.__emulib.EncodeEquipmentDataV2(DataTable);
	end

	local function SetPackIteratorFunc(Frame, name)
		if Frame.name == name then
			MT.UI.FrameSetName(Frame, name);
		end
	end
	function MT.SetPack(name)
		if VT.__supreme then
			MT.UI.IteratorFrames(SetPackIteratorFunc, name);
		end
	end

	function MT.ImportSimpleCode(Frame, code, name)
		if type(Frame) == 'string' then
			code = Frame;
			Frame = nil;
		end
		local class, level, numGroup, activeGroup, data1, data2 = MT.DecodeTalent(code);
		if class ~= nil then
			Frame = Frame or MT.UI.GetFrame(VT.SET.singleFrame and 1 or nil);
			if not MT.UI.FrameSetInfo(Frame, class, level, { data1, data2, num = numGroup, active = activeGroup, }, nil, name) then
				Frame:Hide();
				return false;
			end
			return true;
		elseif level ~= nil then
			MT.Notice(l10n[level]);
		end
		return false;
	end
	function MT.ExportSimpleCode(_1, _2, _3)
		if not _1 then
			return nil;
		elseif type(_1) == 'number' then
			if type(_2) == 'string' then
				return MT.EncodeTalent(_1, _2, _3);
			else
				_1 = MT.UI.GetFrame(_1);
				if not _1 then
					return nil;
				end
				return MT.EncodeTalent(_1, _2, _3);
			end
		else
			return MT.EncodeTalent(_1, _2, _3);
		end
	end
	function MT:ImportCode(Frame, code, name)
		local Tick = MT.GetUnifiedTime();
		if name == nil then
			VT.ImportIndex = VT.ImportIndex + 1;
			name = "#" .. l10n.Import .. "[" .. VT.ImportIndex .. "]";
		end
		VT.QuerySent[name] = Tick;
		VT.AutoShowEquipmentFrameOnComm[name] = Tick;
		VT.ImportTargetFrame[name] = { Frame, };
		local verkey = strsub(code, 1, 1);
		if verkey ~= "_" and verkey ~= "!" then
			return MT._CommDistributor.OnTalent("", name, code, "V1", VT.__dep.__emulib.DecodeTalentDataV1, false);
		end
		return VT.__dep.__emulib.CHAT_MSG_ADDON(VT.__dep.__emulib.CT.COMM_PREFIX, code, "WHISPER", name);
	end
	function MT:ExportCode(Frame)
		if Frame == nil then
			return nil;
		end
		local Type = type(Frame);
		if Type == 'table' and Frame.GetObjectType ~= nil then
			local T = MT.EncodeTalent(Frame);
			local G = MT.EncodeGlyph(Frame);
			local E = MT.EncodeEquipment(Frame);
			if T ~= nil or E ~= nil or G ~= nil then
				return (T or "") .. (G or "") .. (E or "");
			end
		else
			if Type == 'table' then
				Frame = Frame.name;
				Type = 'string';
			end
			if Type == 'string' then
			end
		end
	end

	function MT.QueryTalentSpellID(class, TreeIndex, TalentSeq, level)
		if class ~= nil and TreeIndex ~= nil and TalentSeq ~= nil then
			class = strupper(class);
			local ClassTDB = DT.TalentDB[class];
			if ClassTDB ~= nil then
				local SpecID = DT.ClassSpec[class][TreeIndex];
				if ClassTDB[SpecID] ~= nil then
					local TalentDef = ClassTDB[SpecID][TalentSeq];
					if TalentDef ~= nil then
						if level == nil or level <= 0 or level > 5 then
							level = 1;
						end
						return TalentDef[8][level];
					end
				end
			end
		end
		return nil;
	end
	function MT.QueryTalentInfoBySpellID(SpellID, class, TreeIndex)
		if SpellID == nil then
			return nil;
		end
		SpellID = tonumber(SpellID);
		if SpellID == nil then
			return nil;
		end
		if class ~= nil then
			class = strupper(class);
			local ClassTDB = DT.TalentDB[class];
			local SpecList = DT.ClassSpec[class];
			if ClassTDB ~= nil and SpecList ~= nil then
				if TreeIndex ~= nil then
					local SpecID = SpecList[TreeIndex];
					local TreeTDB = ClassTDB[SpecID];
					for TalentSeq = 1, #TreeTDB do
						local TalentDef = TreeTDB[TalentSeq];
						local SpellIDs = TalentDef[8];
						for j = 1, TalentDef[4] do
							if SpellIDs[j] == SpellID then
								return class, TreeIndex, SpecID, TalentSeq, TalentDef[1], TalentDef[2], j;
							end
						end
					end
				else
					for TreeIndex = 1, 3 do
						local SpecID = SpecList[TreeIndex];
						local TreeTDB = ClassTDB[SpecID];
						for TalentSeq = 1, #TreeTDB do
							local TalentDef = TreeTDB[TalentSeq];
							local SpellIDs = TalentDef[8];
							for j = 1, TalentDef[4] do
								if SpellIDs[j] == SpellID then
									return class, TreeIndex, SpecID, TalentSeq, TalentDef[1], TalentDef[2], j;
								end
							end
						end
					end
				end
			end
		else
			for C, ClassTDB in next, DT.TalentDB do
				if C ~= class then
					local SpecList = DT.ClassSpec[C];
					for TreeIndex = 1, 3 do
						local SpecID = SpecList[TreeIndex];
						local TreeTDB = ClassTDB[SpecID];
						for TalentSeq = 1, #TreeTDB do
							local TalentDef = TreeTDB[TalentSeq];
							local SpellIDs = TalentDef[8];
							for j = 1, TalentDef[4] do
								if SpellIDs[j] == SpellID then
									return C, TreeIndex, SpecID, TalentSeq, TalentDef[1], TalentDef[2], j;
								end
							end
						end
					end
				end
			end
		end
		return nil;
	end

	function MT.CreateEmulator(Frame, class, level, data, name, readOnly, rule, style)
		Frame = Frame or MT.UI.GetFrame(VT.SET.singleFrame and 1 or nil);
		MT.UI.FrameSetStyle(Frame, style or VT.SET.style);
		Frame:Show();
		if class == nil or class == "" then
			class = CT.SELFCLASS;
		end
		if not MT.UI.FrameSetInfo(Frame, class, tonumber(level) or DT.MAX_LEVEL, data, nil, name, readOnly, rule) then
			Frame:Hide();
			return nil;
		end
		return Frame.id;
	end

	function MT.UpdateApplyingTalentsStatus(Frame)
		local Frames = VT.Frames;
		if not VT.ApplyingTalents.Frame ~= not Frame then
			VT.ApplyingTalents.Frame = Frame;
			if Frame ~= nil then
				for i = 1, Frames.num do
					local Frame = Frames[i];
					Frame.ApplyTalentsButton:Disable();
				end
			else
				for i = 1, Frames.num do
					local Frame = Frames[i];
					Frame.ApplyTalentsButton:Enable();
				end
			end
		end
	end
	local function TryLearn(TreeIndex, TalentSeq, TalentSet, TreeTDB)
		local VM = VT.ApplyingTalents.VMap[TreeIndex];
		local name, iconTexture, tier, column, rank, maxRank, isExceptional, available = GetTalentInfo(TreeIndex, VM[TalentSeq]);
		if TalentSet[TalentSeq] > rank then
			local DepTSeq = TreeTDB[TalentSeq][11];
			if DepTSeq ~= nil then
				local name, iconTexture, tier, column, rank, maxRank, isExceptional, available = GetTalentInfo(TreeIndex, VM[DepTSeq]);
				if TalentSet[DepTSeq] > rank then
					LearnTalent(TreeIndex, VM[DepTSeq]);
					return true;
				end
			end
			if TalentSet[TalentSeq] > rank then
				LearnTalent(TreeIndex, VM[TalentSeq]);
				return true;
			end
		end
		return false;
	end
	local function ApplyTalentsTicker()
		local ApplyingTalents = VT.ApplyingTalents;
		local Frame = ApplyingTalents.Frame;
		local TreeFrames = Frame.TreeFrames;
		local PrimaryTreeIndex = ApplyingTalents.PrimaryTreeIndex;
		if PrimaryTreeIndex ~= nil then	--	always nil if non-cata
			local curPrimary = GetPrimaryTalentTree(false, false);
			if curPrimary == nil then
				SetPrimaryTalentTree(PrimaryTreeIndex)
				return;
			elseif curPrimary ~= PrimaryTreeIndex then
				MT._TimerHalt(ApplyTalentsTicker);
				Frame.ApplyTalentsProgress:SetText("");
				MT.UpdateApplyingTalentsStatus(nil);
				return MT.Notice(l10n["CANNOT APPLY : ERROR CATA."], primaryTreeIndex, curPrimary);
			else
				local TreeFrame = TreeFrames[PrimaryTreeIndex];
				local TalentSet = TreeFrame.TalentSet;
				local TreeTDB = TreeFrame.TreeTDB;
				for TalentSeq = ApplyingTalents.TalentSeq, #TreeTDB do
					ApplyingTalents.TalentSeq = TalentSeq;
					if TryLearn(PrimaryTreeIndex, TalentSeq, TalentSet, TreeTDB) then
						local num = VT._comptb.GetTreeNumPoints(1) + VT._comptb.GetTreeNumPoints(2) + VT._comptb.GetTreeNumPoints(3);
						Frame.ApplyTalentsProgress:SetText(num .. "/" .. ApplyingTalents.Total);
						return;
					end
				end
				ApplyingTalents.TalentSeq = 1;
			end
		end
		for TreeIndex = ApplyingTalents.TreeIndex, 3 do
			if TreeIndex ~= PrimaryTreeIndex then
				ApplyingTalents.TreeIndex = TreeIndex;
				local TreeFrame = TreeFrames[TreeIndex];
				local TalentSet = TreeFrame.TalentSet;
				local TreeTDB = TreeFrame.TreeTDB;
				for TalentSeq = ApplyingTalents.TalentSeq, #TreeTDB do
					ApplyingTalents.TalentSeq = TalentSeq;
					if TryLearn(TreeIndex, TalentSeq, TalentSet, TreeTDB) then
						local num = VT._comptb.GetTreeNumPoints(1) + VT._comptb.GetTreeNumPoints(2) + VT._comptb.GetTreeNumPoints(3);
						Frame.ApplyTalentsProgress:SetText(num .. "/" .. ApplyingTalents.Total);
						return;
					end
				end
				ApplyingTalents.TalentSeq = 1;
			end
		end
		--
		MT._TimerHalt(ApplyTalentsTicker);
		MT.Notice(l10n.ApplyTalentsButton_Finished);
		Frame.ApplyTalentsProgress:SetText("");
		MT.UpdateApplyingTalentsStatus(nil);
	end
	function MT.ApplyTalents(Frame)
		if CT.SELFCLASS == Frame.class then
			local TalentFrame_Update = _G.TalentFrame_Update;
			if TalentFrame_Update ~= nil then
				pcall(TalentFrame_Update);
			end
			if MT.GetPointsReqLevel(Frame.class, Frame.TotalUsedPoints) > UnitLevel('player') then
				return MT.Notice(l10n["CANNOT APPLY : NEED MORE TALENT POINTS."]);
			end
			local Map = VT.__dep.__emulib.GetTalentMap(CT.SELFCLASS);
			if Map == nil then
				return MT.Notice(l10n["CANNOT APPLY : UNABLE TO GENERATE TALENT MAP."]);
			end
			local VMap = Map.VMap;
			local TreeFrames = Frame.TreeFrames;
			local confilicted = false;
			local total = 0;
			local primaryTreeIndex = nil;
			if CT.TOCVERSION >= 40000 then
				local v1, v2, v3 = TreeFrames[1].TalentSet.Total, TreeFrames[2].TalentSet.Total, TreeFrames[3].TalentSet.Total;
				local usedTree = 0;
				local usedAny = nil;
				for TreeIndex = 1, 3 do
					local v = TreeFrames[TreeIndex].TalentSet.Total;
					if v >= DT.PointsNeeded4SecondaryTree then
						primaryTreeIndex = TreeIndex;
						break;
					elseif v > 0 then
						usedTree = usedTree + 1;
						usedAny = TreeIndex;
					end
				end
				if primaryTreeIndex ~= nil then
					local curPrimary = GetPrimaryTalentTree(false, false);
					if curPrimary ~= nil and primaryTreeIndex ~= curPrimary then
						return MT.Notice(l10n["CANNOT APPLY : ERROR CATA."], usedTree, primaryTreeIndex, curPrimary);
					end
				elseif usedTree >= 2 then
					return MT.Notice(l10n["CANNOT APPLY : ERROR CATA."], usedTree);
				elseif usedTree == 1 then
					primaryTreeIndex = usedAny;
				end
			end
			for TreeIndex = 1, 3 do
				local VM = VMap[TreeIndex];
				local TreeFrame = TreeFrames[TreeIndex];
				local TalentSet = TreeFrame.TalentSet;
				local TreeTDB = TreeFrame.TreeTDB;
				local NumTalents = #TreeTDB;
				if NumTalents ~= GetNumTalents(TreeIndex, false) then
					return MT.Notice(l10n["TalentDB Error : DB SIZE IS NOT EQUAL TO TalentFrame SIZE."], CT.SELFCLASS, TreeIndex, NumTalents, GetNumTalents(TreeIndex, false));
				end
				for TalentSeq = 1, NumTalents do
					local TalentIndex = VM[TalentSeq];
					if TalentIndex == nil then
						return MT.Notice(l10n["CANNOT APPLY : TALENT MAP ERROR."]);
					end
					local name, iconTexture, tier, column, rank, maxRank, isExceptional, available = GetTalentInfo(TreeIndex, TalentIndex);
					if rank > TalentSet[TalentSeq] then
						confilicted = true;
						break;
					end
					local TalentDef = TreeTDB[TalentSeq];
					if TalentDef[1] ~= nil and (tier ~= TalentDef[1] + 1 or column ~= TalentDef[2] + 1 or maxRank ~= TalentDef[4]) then
						confilicted = true;
						break;
					end
					total = total + TalentSet[TalentSeq];
				end
				if confilicted then
					break;
				end
			end
			if confilicted then
				return MT.Notice(l10n["CANNOT APPLY : TALENTS IN CONFLICT."]);
			else
				MT.UpdateApplyingTalentsStatus(Frame);
				VT.ApplyingTalents.VMap = VMap;
				VT.ApplyingTalents.TreeIndex = 1;
				VT.ApplyingTalents.TalentSeq = 1;
				VT.ApplyingTalents.Total = total;
				VT.ApplyingTalents.PrimaryTreeIndex = primaryTreeIndex;
				MT._TimerStart(ApplyTalentsTicker, 0.1);
			end
		end
	end

	function MT.CanInspect(unit)
		if unit == nil or UnitIsDeadOrGhost('player') or UnitIsDeadOrGhost(unit) or InCombatLockdown() or not CheckInteractDistance(unit, 1) or not CanInspect(unit) then
			return false;
		end
		local InspectFrame = _G.InspectFrame;
		if InspectFrame and InspectFrame:IsShown() then
			return false;
		end
		return true;
	end

	function MT.CALLBACK.OnTalentDataRecv(name, iscomm)
		local cache = VT.TQueryCache[name];
		if cache ~= nil then
			local Tick = MT.GetUnifiedTime();
			if VT.QuerySent[name] ~= nil and Tick - VT.QuerySent[name] <= CT.INSPECT_WAIT_TIME then
				MT.Debug("MT.CALLBACK.OnTalentDataRecv", cache.TalData.num);
				local readOnly = false;
				if name ~= CT.SELFNAME then
					readOnly = true;
				end
				local Frames = VT.ImportTargetFrame[name] or MT.UI.FrameGetNameBinding(name);
				if Frames ~= nil and Frames[1] ~= nil then
					local AnyShown = false;
					for i = 1, #Frames do
						if Frames[i]:IsShown() then
							MT.UI.FrameSetInfo(Frames[i], cache.class, DT.MAX_LEVEL, cache.TalData, nil, name, readOnly);
							AnyShown = true;
						end
					end
					if not AnyShown then
						MT.CreateEmulator(nil, cache.class, DT.MAX_LEVEL, cache.TalData, name, readOnly, false);
					end
				else
					MT.CreateEmulator(nil, cache.class, DT.MAX_LEVEL, cache.TalData, name, readOnly, false);
				end
			end
			VT.QuerySent[name] = nil;
		end
	end
	function MT.CALLBACK.OnGlyphDataRecv(name, iscomm, ascomm)
		local cache = VT.TQueryCache[name];
		if cache ~= nil and VT.SET.show_equipment then
			local Frames = VT.ImportTargetFrame[name] or MT.UI.FrameGetNameBinding(name);
			if Frames ~= nil and Frames[1] ~= nil then
				local popup = (iscomm or ascomm) and VT.SET.autoShowEquipmentFrame;
				MT.Debug("EquipFrame", "CALLBACK-G", popup, iscomm, ascomm, VT.SET.autoShowEquipmentFrame);
				if popup then
					local T = VT.AutoShowEquipmentFrameOnComm[name];
					if T ~= nil and MT.GetUnifiedTime() - T < 10 then
						for i = 1, #Frames do
							Frames[i].EquipmentFrameContainer:Show();
						end
					end
					VT.AutoShowEquipmentFrameOnComm[name] = nil;
				end
				for i = 1, #Frames do
					Frames[i].objects.EquipmentFrameButton:Show();
					if Frames[i].EquipmentFrameContainer:IsShown() then
						MT.UI.GlyphContainerUpdate(Frames[i].GlyphContainer, cache.GlyData);
					end
				end
			end
		end
	end
	function MT.CALLBACK.OnInventoryDataRecv(name, iscomm, ascomm)
		local cache = VT.TQueryCache[name];
		if cache ~= nil and VT.SET.show_equipment then
			local Frames = VT.ImportTargetFrame[name] or MT.UI.FrameGetNameBinding(name);
			if Frames ~= nil and Frames[1] ~= nil then
				local popup = (iscomm or ascomm) and VT.SET.autoShowEquipmentFrame;
				MT.Debug("EquipFrame", "CALLBACK-E", popup, iscomm, ascomm, VT.SET.autoShowEquipmentFrame);
				if popup then
					local T = VT.AutoShowEquipmentFrameOnComm[name];
					if T ~= nil and MT.GetUnifiedTime() - T < 10 then
						for i = 1, #Frames do
							Frames[i].EquipmentFrameContainer:Show();
						end
					end
					VT.AutoShowEquipmentFrameOnComm[name] = nil;
				end
				for i = 1, #Frames do
					Frames[i].objects.EquipmentFrameButton:Show();
					if Frames[i].EquipmentFrameContainer:IsShown() then
						MT.UI.EquipmentContainerUpdate(Frames[i].EquipmentContainer, cache);
						MT.UI.EngravingContainerUpdate(Frames[i].EquipmentContainer, cache);
					end
				end
			end
		end
	end
	function MT.CALLBACK.OnEngravingDataRecv(name, iscomm, ascomm)
		local cache = VT.TQueryCache[name];
		if cache ~= nil and VT.SET.show_equipment then
			local Frames = VT.ImportTargetFrame[name] or MT.UI.FrameGetNameBinding(name);
			if Frames ~= nil and Frames[1] ~= nil then
				local popup = (iscomm or ascomm) and VT.SET.autoShowEquipmentFrame;
				MT.Debug("EquipFrame", "CALLBACK-E", popup, iscomm, ascomm, VT.SET.autoShowEquipmentFrame);
				if popup then
					local T = VT.AutoShowEquipmentFrameOnComm[name];
					if T ~= nil and MT.GetUnifiedTime() - T < 10 then
						for i = 1, #Frames do
							Frames[i].EquipmentFrameContainer:Show();
						end
					end
					VT.AutoShowEquipmentFrameOnComm[name] = nil;
				end
				for i = 1, #Frames do
					Frames[i].objects.EquipmentFrameButton:Show();
					if Frames[i].EquipmentFrameContainer:IsShown() then
						MT.UI.EngravingContainerUpdate(Frames[i].EquipmentContainer, cache);
					end
				end
			end
		end
	end
	function MT.CALLBACK.OnInventoryDataChanged(name)
		local cache = VT.TQueryCache[name];
		if cache then
			cache.EquData.AverageItemLevel = nil;
			cache.EquData.AverageItemLevel_ = nil;
			cache.EquData.AverageItemLevel_OKay = nil;
			MT.ScheduleCalcItemLevel();
			MT.SummaryGem(cache.EquData);
		end
	end

-->
