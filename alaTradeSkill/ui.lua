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
	local hooksecurefunc = hooksecurefunc;
	local select = select;
	local type = type;
	local tonumber = tonumber;
	local rawset = rawset;
	local rawget = rawget;
	local next = next;
	local unpack = unpack;

	local max = math.max;
	local min = math.min;
	local strsub = string.sub;
	local strlower = string.lower;
	local strupper = string.upper;
	local strmatch = string.match;
	local strfind = string.find;
	local format = string.format;
	local gsub = string.gsub;
	local tinsert = table.insert;
	local tremove = table.remove;
	local sort = table.sort;
	local wipe = table.wipe;

	local CreateFrame = CreateFrame;
	local GetMouseFocus = GetMouseFocus;
	local IsShiftKeyDown = IsShiftKeyDown;
	local IsAltKeyDown = IsAltKeyDown;
	local IsControlKeyDown = IsControlKeyDown;
	local GetTime = GetTime;
	local GetServerTime = GetServerTime;

	local GetNumSkillLines = GetNumSkillLines;
	local GetSkillLineInfo = GetSkillLineInfo;
	-- local IsSpellKnown = IsSpellKnown;
	local GetSpellInfo = GetSpellInfo;
	local GetItemInfo = GetItemInfo;
	local GetTradeTargetItemLink = GetTradeTargetItemLink;
	local GetPlayerInfoByGUID = GetPlayerInfoByGUID;
	local GetItemQualityColor = GetItemQualityColor;
	local CastSpellByName = CastSpellByName;
	local RAID_CLASS_COLORS = RAID_CLASS_COLORS;
	local CLASS_ICON_TCOORDS = CLASS_ICON_TCOORDS;

	local SetPortraitTexture = SetPortraitTexture;
	local SetUIPanelAttribute = SetUIPanelAttribute;
	local DressUpItemLink = DressUpItemLink;
	local GameTooltip = GameTooltip;
	local UIParent = UIParent;
	local ChatEdit_ChooseBoxForSend = ChatEdit_ChooseBoxForSend;
	local UISpecialFrames = UISpecialFrames;

	local _G = _G;
	local SystemFont_Shadow_Med1 = SystemFont_Shadow_Med1;

-->
	local DataAgent = DT.DataAgent;
	local l10n = CT.l10n;

-->
MT.BuildEnv("ui");
-->		predef
	local index_validated = 1;
	local index_phase = 2;
	local index_pid = 3;
	local index_sid = 4;
	local index_cid = 5;
	local index_learn_rank = 6;
	local index_yellow_rank = 7;
	local index_green_rank = 8;
	local index_grey_rank = 9;
	local index_num_made_min = 10;
	local index_num_made_max = 11;
	local index_reagents_id = 12;
	local index_reagents_count = 13;
	local index_trainer = 14;
	local index_train_price = 15;
	local index_recipe = 16;
	local index_quest = 17;
	local index_object = 18;
	local index_class = 19;
	local index_spec = 20;
	--
	-- 1itemName, 2itemLink, 3itemRarity, 4itemLevel, 5itemMinLevel, 6itemType, 7itemSubType, 8itemStackCount,
	-- 9itemEquipLoc, 10itemIcon, 11itemSellPrice, 12itemClassID, 13itemSubClassID, 14bindType, 15expacID, 16itemSetID, 
	-- 17isCraftingReagent = GetItemInfo(itemID or "itemString" or "itemName" or "itemLink") 
	local index_i_name = 1;			--	1
	local index_i_link = 2;			--	2
	local index_i_rarity = 3;		--	3
	local index_i_loc = 4;			--	9
	local index_i_icon = 5;			--	10
	local index_i_sellPrice = 6;	--	11
	local index_i_typeID = 7;		--	12
	local index_i_subTypeID = 8;	--	13
	local index_i_bindType = 9;		--	14	--	0 - none; 1 - on pickup; 2 - on equip; 3 - on use; 4 - quest.
	-- local index_i_ilevel = 4;		--	4
	-- local index_i_plevel = 5;		--	5
	-- local index_i_type = 6;			--	6
	-- local index_i_subType = 7;		--	7
	-- local index_i_stackCount = 7;	--	8
	local index_i_name_lower = 10;
	local index_i_link_lower = 11;
	local index_i_string = 12;
-->
local ICON_FOR_NO_CID = 135913;
local PERIODIC_UPDATE_PERIOD = 1.0;
local MAXIMUM_VAR_UPDATE_PERIOD = 4.0;
local F = CreateFrame('FRAME');
F:SetScript("OnEvent", function(self, event, ...)
	return self[event](...);
end);

local SkillTip = GameTooltip;	--	CreateFrame('GAMETOOLTIP', "_TradeSkillTooltip", UIParent, "GameTooltipTemplate");

local T_UIDefinition = {
	texture_white = [[Interface\Buttons\WHITE8X8]],
	texture_unk = [[Interface\Icons\inv_misc_questionmark]],
	texture_highlight = [[Interface\Buttons\UI-Common-MouseHilight]],
	texture_triangle = [[Interface\Transmogrify\Transmog-Tooltip-Arrow]],
	texture_color_select = CT.TEXTUREPATH .. [[ColorSelect]],
	texture_alpha_ribbon = CT.TEXTUREPATH .. [[AlphaRibbon]],
	texture_config = [[Interface\Buttons\UI-OptionsButton]],
	texture_profit = [[Interface\Buttons\UI-GroupLoot-Coin-UP]],
	texture_explorer = CT.TEXTUREPATH .. [[explorer]],
	texture_toggle = CT.TEXTUREPATH .. [[UI]],

	texture_modern_arrow_down = CT.TEXTUREPATH .. [[ArrowDown]],
	texture_modern_arrow_up = CT.TEXTUREPATH .. [[ArrowUp]],
	texture_modern_arrow_left = CT.TEXTUREPATH .. [[ArrowLeft]],
	texture_modern_arrow_right = CT.TEXTUREPATH .. [[ArrowRight]],
	texture_modern_button_minus = CT.TEXTUREPATH .. [[MinusButton]],
	texture_modern_button_plus = CT.TEXTUREPATH .. [[PlusButton]],
	texture_modern_button_close = CT.TEXTUREPATH .. [[Close]],
	texture_modern_check_button_border = CT.TEXTUREPATH .. [[CheckButtonBorder]],
	texture_modern_check_button_center = CT.TEXTUREPATH .. [[CheckButtonCenter]],

	texture_expand = CT.TEXTUREPATH .. [[ArrowRight]],
	texture_shrink = CT.TEXTUREPATH .. [[ArrowLeft]],

	color_white = { 1.0, 1.0, 1.0, 1.0, },

	modernFrameBackdrop = {
		bgFile = [[Interface\Buttons\WHITE8X8]],
		edgeFile = nil,
		tile = false,
		tileSize = 16,
		edgeSize = 16,
		insets = { left = 0, right = 0, top = 0, bottom = 0, },
	},
	blzFrameBackdrop = {
		bgFile = [[Interface\FrameGeneral\UI-BackGround-Marble]],
		edgeFile = [[Interface\Tooltips\UI-Tooltip-Border]],
		tile = false,
		tileSize = 32,
		edgeSize = 24,
		insets = { left = 4, right = 4, top = 4, bottom = 4, },
	},
	modernDividerColor = { 0.75, 1.0, 1.0, 0.125, },

	textureButtonColorNormal = { 0.75, 0.75, 0.75, 0.75, },
	textureButtonColorPushed = { 0.25, 0.25, 0.25, 1.0, },
	textureButtonColorHighlight= { 0.25, 0.25, 0.75, 1.0, },
	textureButtonColorDisabled= { 0.5, 0.5, 0.5, 0.25, },
	modernColorButtonColorNormal = { 0.0, 0.0, 0.0, 0.25, },
	modernColorButtonColorPushed = { 0.75, 1.0, 1.0, 0.125, },
	modernColorButtonColorHighlight = { 0.75, 1.0, 1.0, 0.125, },
	modernColorButtonColorDisabled = { 0.5, 0.5, 0.5, 0.25, },

	modernCheckButtonColorNormal = { 0.75, 1.0, 1.0, 0.25, },
	modernCheckButtonColorPushed = { 0.75, 1.0, 1.0, 0.50, },
	modernCheckButtonColorHighlight = { 0.75, 1.0, 1.0, 0.25, },
	modernCheckButtonColorChecked = { 0.75, 1.0, 1.0, 0.50, },
	modernCheckButtonColorDisabled = { 0.5, 0.5, 0.5, 0.25, },
	modernCheckButtonColorDisabledChecked = { 0.5, 0.5, 0.5, 0.4, },


	skillListButtonHeight = 15,
	listButtonHighlightColor = { 0.5, 0.5, 0.75, 0.25, },
	listButtonSelectedColor = { 0.5, 0.5, 0.5, 0.25, },

	frameNormalFont = SystemFont_Shadow_Med1:GetFont(),	--	"Fonts\ARKai_T.ttf"
	frameNormalFontSize = min(select(2, SystemFont_Shadow_Med1:GetFont()) + 1, 15),
	frameNormalFontFlag = "",

	tabSize = 24,
	tabInterval = 2,

	explorerWidth = 360,
	explorerHeight = 480,

	charListButtonHeight = 20,
};

local LT_SharedMethod = {  };
local LT_ExplorerStat = { Skill = {  }, Type = {  }, SubType = {  }, EquipLoc = {  }, };
local LT_LinkedSkillVar = { {  }, {  }, };


function LT_SharedMethod.ButtonInfoOnEnter(self)
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
	local info_lines = self.info_lines;
	if info_lines then
		for index = 1, #info_lines do
			GameTooltip:AddLine(info_lines[index]);
		end
	end
	GameTooltip:Show();
end
function LT_SharedMethod.ButtonInfoOnLeave(self)
	if GameTooltip:IsOwned(self) then
		GameTooltip:Hide();
	end
end

--	Update
	function LT_SharedMethod.ProfitFilterList(Frame, list, only_cost)
		local sid_list = Frame.list;
		wipe(list);
		if VT.AuctionMod ~= nil then
			local pid = Frame.flag or DataAgent.get_pid_by_pname(Frame.F_GetSkillName());
			if only_cost and Frame.flag ~= 'explorer' then
				local var = rawget(VT.VAR, pid);
				local cur_rank = var and var.cur_rank or 0;
				for index = 1, #sid_list do
					local sid = sid_list[index];
					local price_a_product, price_a_material, price_a_material_known, missing = MT.GetPriceInfoBySID(VT.SET[pid].phase, sid, DataAgent.get_num_made_by_sid(sid), nil);
					if price_a_material then
						list[#list + 1] = { sid, price_a_material, DataAgent.get_difficulty_rank_by_sid(sid, cur_rank), };
					end
				end
				sort(list, function(v1, v2)
					if v1[3] < v2[3] then
						return true;
					elseif v1[3] == v2[3] then
						return v1[2] < v2[2];
					else
						return false;
					end
				end);
			else
				for index = 1, #sid_list do
					local sid = sid_list[index];
					local price_a_product, price_a_material, price_a_material_known, missing = MT.GetPriceInfoBySID(VT.SET[pid].phase, sid, DataAgent.get_num_made_by_sid(sid), nil);
					if price_a_product and price_a_material then
						if price_a_product > price_a_material then
							list[#list + 1] = { sid, price_a_product - price_a_material, };
						end
					end
				end
				sort(list, function(v1, v2) return v1[2] > v2[2]; end);
			end
		end
		return list;
	end
	function LT_SharedMethod.UpdateProfitFrame(Frame)
		local ProfitFrame = Frame.ProfitFrame;
		if ProfitFrame:IsVisible() then
			MT.Debug("UpdateProfitFrame|cff00ff00#1L1|r");
			local list = ProfitFrame.list;
			local pid = Frame.flag or DataAgent.get_pid_by_pname(Frame.F_GetSkillName());
			if ProfitFrame.CostOnlyCheck then
				local only_cost = VT.SET[pid].PROFIT_SHOW_COST_ONLY;
				LT_SharedMethod.ProfitFilterList(Frame, list, only_cost);
				ProfitFrame.CostOnlyCheck:SetChecked(only_cost);
			else
				LT_SharedMethod.ProfitFilterList(Frame, list);
			end
			ProfitFrame.ScrollFrame:SetNumValue(#list);
			ProfitFrame.ScrollFrame:Update();
		end
	end
	function LT_SharedMethod.ProcessTextFilter(list, searchText, searchNameOnly)
		local item_func = searchNameOnly and DataAgent.item_name_lower or DataAgent.item_link_lower;
		local spell_func = searchNameOnly and DataAgent.spell_name_lower or DataAgent.spell_link_lower;
		for index = #list, 1, -1 do
			local sid = list[index];
			local info = DataAgent.get_info_by_sid(sid);
			if info ~= nil then
				local removed = true;
				local cid = info[index_cid];
				local spell_lower = spell_func(sid);
				local item_lower = cid and item_func(cid);
				if (spell_lower and strfind(spell_lower, searchText)) or (item_lower and strfind(item_lower, searchText)) then
					removed = false;
				else
					local reagent_ids = info[index_reagents_id];
					if reagent_ids then
						for index2 = 1, #reagent_ids do
							local item_lower = item_func(reagent_ids[index2]);
							if item_lower and strfind(item_lower, searchText) then
								removed = false;
							end
						end
					end
				end
				if removed then
					tremove(list, index);
				end
			end
		end
	end
	function LT_SharedMethod.FrameFilterList(Frame, regular_exp, list, searchText, searchNameOnly)
		if strlower(strsub(searchText, 1, 5)) == "rexp:" then
			regular_exp = true;
			searchText = strsub(searchText, 6);
		end
		if regular_exp then
			searchText = strlower(searchText);
			local result, ret = pcall(LT_SharedMethod.ProcessTextFilter, list, searchText, searchNameOnly);
			if result then
				Frame:F_SearchEditValid();
			else
				Frame:F_SearchEditInvalid();
			end
		else
			searchText = gsub(strlower(searchText), "[%^%$%%%.%+%-%*%?%[%]%(%)]", "%%%1");
			LT_SharedMethod.ProcessTextFilter(list, searchText, searchNameOnly);
			Frame:F_SearchEditValid();
		end
	end
	function LT_SharedMethod.UpdateFrame(Frame)
		-- if Frame.mute_update then
		-- 	return;
		-- end
		-- Frame.mute_update = true;
		if Frame.HookedFrame:IsShown() then
			local notlinked = not Frame.F_IsLinked();
			Frame:F_LayoutOnShow();
			local skillName, cur_rank, max_rank = Frame.F_GetSkillInfo();
			local pid = DataAgent.get_pid_by_pname(skillName);
			Frame.flag = pid;
			Frame.notlinked = notlinked;
			if pid ~= nil then
				local set = VT.SET[pid];
				local var = notlinked and VT.VAR[pid] or LT_LinkedSkillVar;
				local update_var = var.update or Frame.prev_pid ~= pid or var.cur_rank ~= cur_rank or Frame.update;
				if not update_var then
					local t = GetTime();
					if t - Frame.prev_var_update_time > MAXIMUM_VAR_UPDATE_PERIOD then
						Frame.prev_var_update_time = t;
						update_var = true;
					end
				end
				var.update = update_var;	--	Redundancy for error
				local update_list = update_var or set.update;
				set.update = update_list;	--	Redundancy for error
				Frame.HaveMaterialsCheck:SetChecked(set.haveMaterials);
				if set.shown then
					Frame:Show();
					Frame.ToggleButton:SetText(l10n["OVERRIDE_CLOSE"]);
				else
					Frame:Hide();
					Frame.ToggleButton:SetText(l10n["OVERRIDE_OPEN"]);
				end
				if VT.SET.show_call then
					Frame.ToggleButton:Show();
				end
				if CT.VGT3X then
					if pid == 10 then
						Frame.FilterDropdown:Show();
					else
						Frame.FilterDropdown:Hide();
					end
				end
				Frame:F_ToggleOnSkill(true);
				var.max_rank = max_rank;
				if Frame:IsShown() then
					if update_list then
						local sids = var[1];
						local hash = var[2];
						if update_var then
							MT.Debug("UpdateFrame|cff00ff00#1L1|r");
							local num = Frame.F_GetRecipeNumAvailable();
							if num <= 0 then
								-- Frame.mute_update = false;
								return;
							end
							var.cur_rank = cur_rank;
							for index = 1, #sids do
								DataAgent.CancelMarkKnown(sids[index], CT.SELFGUID);
							end
							wipe(sids);
							wipe(hash);
							for index = 1, num do
								local sname, srank = Frame.F_GetRecipeInfo(index);
								if sname ~= nil and srank ~= nil and srank ~= 'header' then
									local sid = Frame.F_GetRecipeSpellID ~= nil and Frame.F_GetRecipeSpellID(index) or nil;
									if sid == nil then
										local cid = Frame.F_GetRecipeItemID(index);
										if cid ~= nil then
											local sid = DataAgent.get_sid_by_pid_sname_cid(pid, sname, cid);
											local info = DataAgent.get_info_by_sid(sid);
											if info ~= nil then
												if hash[sid] ~= nil then
													MT.Debug("UpdateFrame#0E3", pid .. "#" .. cid .. "#" .. sname .. "#" .. sid);
												else
													sids[#sids + 1] = sid;
													hash[sid] = index;
													if notlinked then
														DataAgent.MarkKnown(sid, CT.SELFGUID);
													end
												end
												if index == Frame.F_GetSelection() then
													Frame.selected_sid = sid;
												end
											else
												MT.Debug("UpdateFrame#0E2", pid .. "#" .. cid .. "#" .. sname, sid or "_NIL");
											end
										else
											MT.Debug("UpdateFrame#0E1", pid .. "#" .. sname);
										end
									else
										sids[#sids + 1] = sid;
										hash[sid] = index;
										DataAgent.DynamicCreateInfo(Frame, pid, cur_rank, index, sid, srank);
										if notlinked then
											DataAgent.MarkKnown(sid, CT.SELFGUID);
										end
									end
								end
							end
							var.update = nil;
							Frame.update = nil;
						else
							MT.Debug("UpdateFrame|cff00ff00#1L2|r");
						end
						if #sids > 0 then
							if Frame.prev_pid ~= pid then
								if set.showProfit then
									Frame:F_ShowProfitFrame();
								else
									Frame:F_HideProfitFrame();
								end
								if set.showSet then
									Frame:F_ShowSetFrame(true);
								else
									Frame:F_HideSetFrame();
								end
								Frame.SearchEditBoxNameOnly:SetChecked(set.searchNameOnly);
							end
							Frame.prev_pid = pid;
							Frame.hash = hash;
							local list = Frame.list;
							DataAgent.get_ordered_list(pid, list, hash, set.phase, cur_rank, set.rankoffset, set.rankReversed, set.showKnown, set.showUnkown, set.showHighRank, set.filterClass, set.filterSpec);
							if set.haveMaterials then
								for i = #list, 1, -1 do
									local sid = list[i];
									local index = hash[sid];
									if index == nil or select(3, Frame.F_GetRecipeInfo(index)) <= 0 then
										tremove(list, i);
									end
								end
							end
							do
								local C_top = 1;
								for index = 1, #list do
									local sid = list[index];
									if VT.FAV[sid] ~= nil then
										tremove(list, index);
										tinsert(list, C_top, sid);
										C_top = C_top + 1;
									end
								end
							end
							local searchText = set.searchText;
							if searchText ~= nil then
								LT_SharedMethod.FrameFilterList(Frame, VT.SET.regular_exp, list, searchText, set.searchNameOnly);
							else
								Frame:F_SearchEditValid();
							end
							Frame.ScrollFrame:SetNumValue(#list);
							Frame.ScrollFrame:Update();
							Frame:F_RefreshSetFrame();
							Frame:F_RefreshSearchEdit();
							Frame:F_RefreshRankOffset();
							LT_SharedMethod.UpdateProfitFrame(Frame);
							set.update = nil;
							MT.FireCallback("USER_EVENT_RECIPE_LIST_UPDATE");
						else
							var.update = true;
							-- Frame.mute_update = false;
						end
					else
						MT.Debug("UpdateFrame|cff00ff00#2L1|r");
						if #var[1] > 0 then
							Frame.ScrollFrame:Update();
							if Frame.ProfitFrame:IsShown() then
								Frame.ProfitFrame.ScrollFrame:Update();
							end
						end
					end
				else
					Frame.prev_pid = pid;
					var.cur_rank = cur_rank;
					set.update = nil;
					var.update = nil;
					Frame.update = nil;
					if update_list then
						local sids = var[1];
						local hash = var[2];
						if update_var then
							MT.Debug("UpdateFrame|cff00ff00#1L1|r");
							local num = Frame.F_GetRecipeNumAvailable();
							if num <= 0 then
								-- Frame.mute_update = false;
								return;
							end
							var.cur_rank = cur_rank;
							for index = 1, num do
								local sname, srank = Frame.F_GetRecipeInfo(index);
								if sname ~= nil and srank ~= nil and srank ~= 'header' then
									local sid = Frame.F_GetRecipeSpellID ~= nil and Frame.F_GetRecipeSpellID(index) or nil;
									if sid == nil then
										local cid = Frame.F_GetRecipeItemID(index);
										if cid ~= nil then
											local sid = DataAgent.get_sid_by_pid_sname_cid(pid, sname, cid);
											local info = DataAgent.get_info_by_sid(sid);
											if info ~= nil then
												if hash[sid] == nil then
													sids[#sids + 1] = sid;
													hash[sid] = index;
													if notlinked then
														DataAgent.MarkKnown(sid, CT.SELFGUID);
													end
												end
											else
												MT.Debug("UpdateFrame#0E2", pid .. "#" .. cid .. "#" .. sname);
											end
										else
											MT.Debug("UpdateFrame#0E1", pid .. "#" .. sname);
										end
									else
										sids[#sids + 1] = sid;
										hash[sid] = index;
										if notlinked then
											DataAgent.MarkKnown(sid, CT.SELFGUID);
										end
										DataAgent.DynamicCreateInfo(Frame, pid, cur_rank, index, sid, srank);
									end
								end
							end
							var.update = nil;
							Frame.update = nil;
						end
					end
				end
				if notlinked then
					MT.CheckCooldown(pid, var);
					if update_var then
						Frame.PortraitButton:F_Update();
					end
				end
			else
				Frame:Hide();
				Frame.ToggleButton:Hide();
				Frame:F_ToggleOnSkill(false);
			end
		end
		-- Frame.mute_update = false;
	end
	--
		local T_EquipLoc2ID = {
			["INVTYPE_AMMO"] = 0,				--	Ammo
			["INVTYPE_HEAD"] = 1,				--	Head
			["INVTYPE_NECK"] = 2,				--	Neck
			["INVTYPE_SHOULDER"] = 3,			--	Shoulder
			["INVTYPE_BODY"] = 4,				--	Shirt
			["INVTYPE_CHEST"] = 5,				--	Chest
			["INVTYPE_ROBE"] = 5,				--	Chest
			["INVTYPE_WAIST"] = 6,				--	Waist
			["INVTYPE_LEGS"] = 7,				--	Legs
			["INVTYPE_FEET"] = 8,				--	Feet
			["INVTYPE_WRIST"] = 9,				--	Wrist
			["INVTYPE_HAND"] = 10,				--	Hands
			["INVTYPE_FINGER"] = 11,			--	Fingers
			["INVTYPE_TRINKET"] = 13,			--	Trinkets
			["INVTYPE_CLOAK"] = 15,				--	Cloaks
			["INVTYPE_WEAPON"] = 21,			--	16  One-Hand
			["INVTYPE_SHIELD"] = 17,			--	Shield
			["INVTYPE_2HWEAPON"] = 22,			--	16  Two-Handed
			["INVTYPE_WEAPONMAINHAND"] = 16,	--	Main-Hand Weapon
			["INVTYPE_WEAPONOFFHAND"] = 17,		--	Off-Hand Weapon
			["INVTYPE_HOLDABLE"] = 17,			--	Held In Off-Hand
			["INVTYPE_RANGED"] = 18,			--	Bows
			["INVTYPE_THROWN"] = 18,			--	Ranged
			["INVTYPE_RANGEDRIGHT"] = 18,		--	Wands, Guns, and Crossbows
			["INVTYPE_RELIC"] = 18,				--	Relics
			["INVTYPE_TABARD"] = 19,			--	Tabard
			["INVTYPE_BAG"] = 20,				--	Containers
			["INVTYPE_QUIVER"] = 20,			--	Quivers
		};
		local T_Filter = {
			{
				"Type",
				DataAgent.item_typeID,
			},
			{
				"SubType",
				DataAgent.item_subTypeID,
			},
			{
				"EquipLoc",
				function(iid)
					local loc = DataAgent.item_loc(iid);
					return loc and T_EquipLoc2ID[loc];
				end,
			},
		};
	function LT_SharedMethod.ExplorerFilterList(Frame, stat, filter, searchText, searchNameOnly, list, check_hash, phase, rank, rankReversed, showKnown, showUnkown, showHighRank, filterClass, filterSpec, donot_wipe_list)
		DataAgent.get_ordered_list(filter.Skill, list, check_hash, phase, rank, nil, rankReversed, showKnown, showUnkown, showHighRank, filterClass, filterSpec, donot_wipe_list);
		do
			local C_top = 1;
			for index = 1, #list do
				local sid = list[index];
				if VT.FAV[sid] then
					tremove(list, index);
					tinsert(list, C_top, sid);
					C_top = C_top + 1;
				end
			end
		end
		for index = 1, #T_Filter do
			local v = T_Filter[index];
			local key = v[1];
			local val = filter[key];
			local func = v[2];
			if val and func then
				for index = #list, 1, -1 do
					local sid = list[index];
					local cid = DataAgent.get_cid_by_sid(sid);
					if cid then
						if func(cid) ~= val then
							tremove(list, index);
						end
					else
						tremove(list, index);
					end
				end
			end
		end
		if searchText ~= nil then
			LT_SharedMethod.FrameFilterList(Frame, VT.SET.regular_exp, list, searchText, searchNameOnly)
		else
			Frame:F_SearchEditValid();
		end
		do
			local Skill_Hash = stat.Skill;
			local Type_Hash = stat.Type;
			local SubType_Hash = stat.SubType;
			local EquipLoc_Hash = stat.EquipLoc;
			wipe(Skill_Hash);
			wipe(Type_Hash);
			wipe(SubType_Hash);
			wipe(EquipLoc_Hash);
			for index = 1, #list do
				local sid = list[index];
				local info = DataAgent.get_info_by_sid(sid);
				if info ~= nil then
					local pid = info[index_pid];
					Skill_Hash[pid] = DataAgent.LearnedRecipesHash[sid] or {  };
					local cid = info[index_cid];
					if cid then
						local _type = DataAgent.item_typeID(cid);
						local _subType = DataAgent.item_subTypeID(cid);
						local _eqLoc = DataAgent.item_loc(cid);
						local _eqLid = T_EquipLoc2ID[_eqLoc];
						Type_Hash[_type] = 1;
						SubType_Hash[_subType] = 1;
						if _eqLid then
							EquipLoc_Hash[_eqLid] = 1;
						end
					end
				end
			end
		end
		return stat;
	end
	function LT_SharedMethod.UpdateExplorerFrame(Frame, update_list)
		if Frame:IsVisible() then
			local set = VT.SET.explorer;
			local hash = Frame.hash;
			local list = Frame.list;
			if update_list then
				MT.Debug("UpdateExplorerFrame|cff00ff00#1L1|r");
				if set.showProfit then
					Frame:F_ShowProfitFrame();
				else
					Frame:F_HideProfitFrame();
				end
				if set.showSet then
					Frame:F_ShowSetFrame(true);
				else
					Frame:F_HideSetFrame();
				end
				Frame.SearchEditBoxNameOnly:SetChecked(set.searchNameOnly);
				LT_SharedMethod.ExplorerFilterList(Frame, LT_ExplorerStat, set.filter, set.searchText, set.searchNameOnly,
											list, hash, set.phase, nil, set.rankReversed, set.showKnown, set.showUnkown, set.showHighRank, set.filterClass, set.filterSpec);
				LT_SharedMethod.UpdateProfitFrame(Frame);
			else
				MT.Debug("UpdateExplorerFrame|cff00ff00#1L2|r");
			end
			Frame.ScrollFrame:SetNumValue(#list);
			Frame.ScrollFrame:Update();
			Frame:F_RefreshSetFrame();
			Frame:F_RefreshSearchEdit();
		end
	end
--
--	Shared
	function LT_SharedMethod.SelectRecipe(Frame, sid)
		local recipeindex = Frame.hash[sid];
		if recipeindex then
			Frame.F_SetSelection(recipeindex);
			Frame.HookedFrame.numAvailable = select(3, Frame.F_GetRecipeInfo(recipeindex));
			Frame.selected_sid = sid;
			Frame.F_Update();
			Frame.SearchEditBox:ClearFocus();
			local HookedScrollBar = Frame.HookedScrollBar;
			local num = Frame.F_GetRecipeNumAvailable();
			local minVal, maxVal = HookedScrollBar:GetMinMaxValues();
			local step = HookedScrollBar:GetValueStep();
			local cur = HookedScrollBar:GetValue() + step;
			local value = step * (recipeindex - 1);
			if value < cur or value > (cur + num * step - maxVal) then
				HookedScrollBar:SetValue(min(maxVal, value));
			end
			Frame.ScrollFrame:Update();
			if Frame.ProfitFrame:IsShown() then
				Frame.ProfitFrame.ScrollFrame:Update();
			end
		end
	end
	--	obj style
		function LT_SharedMethod.WidgetHidePermanently(obj)
			obj._SetAlpha = obj._SetAlpha or obj.SetAlpha;
			obj._EnableMouse = obj._EnableMouse or obj.EnableMouse;
			obj:_SetAlpha(0.0);
			obj:_EnableMouse(false);
		end
		function LT_SharedMethod.WidgetUnhidePermanently(obj)
			obj._SetAlpha = obj._SetAlpha or obj.SetAlpha;
			obj._EnableMouse = obj._EnableMouse or obj.EnableMouse;
			obj:_SetAlpha(1.0);
			obj:_EnableMouse(true);
		end
		function LT_SharedMethod.ModifyALAScrollFrame(ScrollFrame)
			local children = { ScrollFrame:GetChildren() };
			for index = 1, #children do
				local obj = children[index];
				if strupper(obj:GetObjectType()) == 'SLIDER' then
					ScrollFrame.ScrollBar = obj;
					local regions = { obj:GetRegions() };
					for index2 = 1, #regions do
						local obj2 = regions[index2];
						if strupper(obj2:GetObjectType()) == 'TEXTURE' then
							obj2:Hide();
						end
						obj:GetThumbTexture():Show();
					end
					obj:SetWidth(16);
					obj:ClearAllPoints();
					obj:SetPoint("TOPRIGHT", ScrollFrame, "TOPRIGHT", 0, -16);
					obj:SetPoint("BOTTOMRIGHT", ScrollFrame, "BOTTOMRIGHT", 0, 16);
					local up = CreateFrame('BUTTON', nil, obj);
					up:SetSize(18, 16);
					up:SetPoint("BOTTOM", obj, "TOP");
					up:SetScript("OnClick", function(self)
						obj:SetValue(obj:GetValue() - obj:GetValueStep());
					end);
					obj.ScrollUpButton = up;
					local down = CreateFrame('BUTTON', nil, obj);
					down:SetSize(18, 16);
					down:SetPoint("TOP", obj, "BOTTOM");
					down:SetScript("OnClick", function(self)
						obj:SetValue(obj:GetValue() + obj:GetValueStep());
					end);
					obj.ScrollDownButton = down;
					local function LF_HookALAScrollBarOnValueChanged(self, val)
						val = val or self:GetValue();
						local minVal, maxVal = self:GetMinMaxValues();
						if minVal >= val then
							up:Disable();
						else
							up:Enable();
						end
						if maxVal <= val then
							down:Disable();
						else
							down:Enable();
						end
					end
					obj:HookScript("OnValueChanged", LF_HookALAScrollBarOnValueChanged);
					hooksecurefunc(ScrollFrame, "SetNumValue", function(self)
						LF_HookALAScrollBarOnValueChanged(obj);
					end);
					break;
				end
			end
		end
		--	style
		function LT_SharedMethod.StyleModernBackdrop(Frame)
			VT.__uireimp._SetBackdrop(Frame, T_UIDefinition.modernFrameBackdrop);
			VT.__uireimp._SetBackdropColor(Frame, unpack(VT.SET.bg_color));
		end
		function LT_SharedMethod.StyleBLZBackdrop(Frame)
			VT.__uireimp._SetBackdrop(Frame, T_UIDefinition.blzFrameBackdrop);
			VT.__uireimp._SetBackdropColor(Frame, 1.0, 1.0, 1.0, 1.0);
			VT.__uireimp._SetBackdropBorderColor(Frame, 1.0, 1.0, 1.0, 1.0);
		end
		function LT_SharedMethod.StyleModernButton(Button, bak, texture)
			if Button.Left then
				Button.Left:SetAlpha(0.0);
			end
			if Button.Middle then
				Button.Middle:SetAlpha(0.0);
			end
			if Button.Right then
				Button.Right:SetAlpha(0.0);
			end
			local ntex = Button:GetNormalTexture();
			local ptex = Button:GetPushedTexture();
			local htex = Button:GetHighlightTexture();
			local dtex = Button:GetDisabledTexture();
			if bak and not bak._got then
				bak[1] = ntex and ntex:GetTexture() or nil;
				bak[2] = ptex and ptex:GetTexture() or nil;
				bak[3] = htex and htex:GetTexture() or nil;
				bak[4] = dtex and dtex:GetTexture() or nil;
				bak._got = true;
			end
			ntex = ntex or Button:SetNormalTexture(T_UIDefinition.texture_unk) or Button:GetNormalTexture();
			ptex = ptex or Button:SetPushedTexture(T_UIDefinition.texture_unk) or Button:GetPushedTexture();
			htex = htex or Button:SetHighlightTexture(T_UIDefinition.texture_unk) or Button:GetHighlightTexture();
			dtex = dtex or Button:SetDisabledTexture(T_UIDefinition.texture_unk) or Button:GetDisabledTexture();
			if texture ~= nil then
				VT.__uireimp._SetSimpleBackdrop(Button, 0, 1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
				Button:SetNormalTexture(texture);
				Button:SetPushedTexture(texture);
				Button:SetHighlightTexture(texture);
				Button:SetDisabledTexture(texture);
				ntex = ntex or Button:GetNormalTexture();
				ptex = ptex or Button:GetPushedTexture();
				htex = htex or Button:GetHighlightTexture();
				dtex = dtex or Button:GetDisabledTexture();
				ntex:SetVertexColor(unpack(T_UIDefinition.textureButtonColorNormal));
				ptex:SetVertexColor(unpack(T_UIDefinition.textureButtonColorPushed));
				htex:SetVertexColor(unpack(T_UIDefinition.textureButtonColorHighlight));
				dtex:SetVertexColor(unpack(T_UIDefinition.textureButtonColorDisabled));
			else
				VT.__uireimp._SetSimpleBackdrop(Button, 0, 1, 0.0, 0.0, 0.0, 0.25, 0.75, 1.0, 1.0, 0.25);
				Button:SetPushedTextOffset(0.0, 0.0);
				if ntex then ntex:SetColorTexture(unpack(T_UIDefinition.modernColorButtonColorNormal)); end
				if ptex then ptex:SetColorTexture(unpack(T_UIDefinition.modernColorButtonColorPushed)); end
				if htex then htex:SetColorTexture(unpack(T_UIDefinition.modernColorButtonColorHighlight)); end
				if dtex then dtex:SetColorTexture(unpack(T_UIDefinition.modernColorButtonColorDisabled)); end
			end
		end
		function LT_SharedMethod.StyleBLZButton(Button, bak)
			if Button.Left then
				Button.Left:SetAlpha(1.0);
			end
			if Button.Middle then
				Button.Middle:SetAlpha(1.0);
			end
			if Button.Right then
				Button.Right:SetAlpha(1.0);
			end
			if bak ~= nil then
				if bak[1] ~= nil then
					Button:SetNormalTexture(bak[1]);
				else
					Button:ClearNormalTexture();
				end
				if bak[2] ~= nil then
					Button:SetPushedTexture(bak[2]);
				else
					Button:ClearPushedTexture();
				end
				if bak[3] ~= nil then
					Button:SetHighlightTexture(bak[3]);
				else
					Button:ClearHighlightTexture();
				end
				if bak[4] ~= nil then
					Button:SetDisabledTexture(bak[4]);
				else
					Button:ClearDisabledTexture();
				end
			end
			local ntex = Button:GetNormalTexture();
			local ptex = Button:GetPushedTexture();
			local htex = Button:GetHighlightTexture();
			local dtex = Button:GetDisabledTexture();
			VT.__uireimp._SetSimpleBackdrop(Button, 0, 1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
			Button:SetPushedTextOffset(1.55, -1.55);
			if ntex then ntex:SetVertexColor(1.0, 1.0, 1.0, 1.0); end
			if ptex then ptex:SetVertexColor(1.0, 1.0, 1.0, 1.0); end
			if htex then htex:SetVertexColor(1.0, 1.0, 1.0, 1.0); end
			if dtex then dtex:SetVertexColor(1.0, 1.0, 1.0, 1.0); end
		end
		function LT_SharedMethod.StyleModernScrollFrame(ScrollFrame)
			local regions = { ScrollFrame:GetRegions() };
			for index = 1, #regions do
				local obj = regions[index];
				if strupper(obj:GetObjectType()) == 'TEXTURE' then
					obj._Show = obj._Show or obj.Show;
					obj.Show = MT.noop;
					obj:Hide();
				end
			end
			--
			local bar = ScrollFrame.ScrollBar;
			VT.__uireimp._SetSimpleBackdrop(bar, 0, 1, 0.0, 0.0, 0.0, 0.0, 0.25, 0.25, 0.25, 1.0);
			local thumb = bar:GetThumbTexture();
			if thumb == nil then
				bar:SetThumbTexture([[Interface\Buttons\UI-ScrollBar-Knob]]);
				thumb = bar:GetThumbTexture();
			end
			thumb:SetColorTexture(0.25, 0.25, 0.25, 1.0);
			thumb:SetWidth(bar:GetWidth());
			local up = bar.ScrollUpButton;
			up:SetNormalTexture(T_UIDefinition.texture_modern_arrow_up);
			up:GetNormalTexture():SetTexCoord(0.0, 1.0, 0.0, 1.0);
			up:GetNormalTexture():SetVertexColor(unpack(T_UIDefinition.textureButtonColorNormal));
			up:SetPushedTexture(T_UIDefinition.texture_modern_arrow_up);
			up:GetPushedTexture():SetTexCoord(0.0, 1.0, 0.0, 1.0);
			up:GetPushedTexture():SetVertexColor(unpack(T_UIDefinition.textureButtonColorPushed));
			up:SetHighlightTexture(T_UIDefinition.texture_modern_arrow_up);
			up:GetHighlightTexture():SetTexCoord(0.0, 1.0, 0.0, 1.0);
			up:GetHighlightTexture():SetVertexColor(unpack(T_UIDefinition.textureButtonColorHighlight));
			up:SetDisabledTexture(T_UIDefinition.texture_modern_arrow_up);
			up:GetDisabledTexture():SetTexCoord(0.0, 1.0, 0.0, 1.0);
			up:GetDisabledTexture():SetVertexColor(unpack(T_UIDefinition.textureButtonColorDisabled));
			local down = bar.ScrollDownButton;
			down:SetNormalTexture(T_UIDefinition.texture_modern_arrow_down);
			down:GetNormalTexture():SetTexCoord(0.0, 1.0, 0.0, 1.0);
			down:GetNormalTexture():SetVertexColor(unpack(T_UIDefinition.textureButtonColorNormal));
			down:SetPushedTexture(T_UIDefinition.texture_modern_arrow_down);
			down:GetPushedTexture():SetTexCoord(0.0, 1.0, 0.0, 1.0);
			down:GetPushedTexture():SetVertexColor(unpack(T_UIDefinition.textureButtonColorPushed));
			down:SetHighlightTexture(T_UIDefinition.texture_modern_arrow_down);
			down:GetHighlightTexture():SetTexCoord(0.0, 1.0, 0.0, 1.0);
			down:GetHighlightTexture():SetVertexColor(unpack(T_UIDefinition.textureButtonColorHighlight));
			down:SetDisabledTexture(T_UIDefinition.texture_modern_arrow_down);
			down:GetDisabledTexture():SetTexCoord(0.0, 1.0, 0.0, 1.0);
			down:GetDisabledTexture():SetVertexColor(unpack(T_UIDefinition.textureButtonColorDisabled));
		end
		function LT_SharedMethod.StyleBLZScrollFrame(ScrollFrame)
			local regions = { ScrollFrame:GetRegions() };
			for index = 1, #regions do
				local obj = regions[index];
				if strupper(obj:GetObjectType()) == 'TEXTURE' then
					obj._Show = obj._Show or obj.Show;
					obj.Show = MT.noop;
					obj:Hide();
					-- if obj._Show then
					-- 	obj.Show = obj._Show;
					-- end
					-- obj:Show();
				end
			end
			--
			local bar = ScrollFrame.ScrollBar;
			VT.__uireimp._SetSimpleBackdrop(bar, 0, 1, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 0.5);
			bar:SetThumbTexture([[Interface\Buttons\UI-ScrollBar-Knob]]);
			bar:GetThumbTexture():SetWidth(bar:GetWidth());
			local up = bar.ScrollUpButton;
			up:SetNormalTexture([[Interface\Buttons\UI-ScrollBar-ScrollUpButton-Up]]);
			up:GetNormalTexture():SetTexCoord(0.2, 0.8, 0.25, 0.75);
			up:GetNormalTexture():SetVertexColor(1.0, 1.0, 1.0, 1.0);
			up:SetPushedTexture([[Interface\Buttons\UI-ScrollBar-ScrollUpButton-Down]]);
			up:GetPushedTexture():SetTexCoord(0.2, 0.8, 0.25, 0.75);
			up:GetPushedTexture():SetVertexColor(1.0, 1.0, 1.0, 1.0);
			up:SetHighlightTexture([[Interface\Buttons\UI-ScrollBar-ScrollUpButton-Highlight]]);
			up:GetHighlightTexture():SetTexCoord(0.2, 0.8, 0.25, 0.75);
			up:GetHighlightTexture():SetVertexColor(1.0, 1.0, 1.0, 1.0);
			up:SetDisabledTexture([[Interface\Buttons\UI-ScrollBar-ScrollUpButton-Disabled]]);
			up:GetDisabledTexture():SetTexCoord(0.2, 0.8, 0.25, 0.75);
			up:GetDisabledTexture():SetVertexColor(1.0, 1.0, 1.0, 1.0);
			local down = bar.ScrollDownButton;
			down:SetNormalTexture([[Interface\Buttons\UI-ScrollBar-ScrollDownButton-Up]]);
			down:GetNormalTexture():SetTexCoord(0.2, 0.8, 0.25, 0.75);
			down:GetNormalTexture():SetVertexColor(1.0, 1.0, 1.0, 1.0);
			down:SetPushedTexture([[Interface\Buttons\UI-ScrollBar-ScrollDownButton-Down]]);
			down:GetPushedTexture():SetTexCoord(0.2, 0.8, 0.25, 0.75);
			down:GetPushedTexture():SetVertexColor(1.0, 1.0, 1.0, 1.0);
			down:SetHighlightTexture([[Interface\Buttons\UI-ScrollBar-ScrollDownButton-Highlight]]);
			down:GetHighlightTexture():SetTexCoord(0.2, 0.8, 0.25, 0.75);
			down:GetHighlightTexture():SetVertexColor(1.0, 1.0, 1.0, 1.0);
			down:SetDisabledTexture([[Interface\Buttons\UI-ScrollBar-ScrollDownButton-Disabled]]);
			down:GetDisabledTexture():SetTexCoord(0.2, 0.8, 0.25, 0.75);
			down:GetDisabledTexture():SetVertexColor(1.0, 1.0, 1.0, 1.0);
		end
		function LT_SharedMethod.RelayoutDropDownMenu(Dropdown)
			Dropdown.hooked = true;
			Dropdown:SetWidth(135);
			Dropdown.Left:ClearAllPoints();
			Dropdown.Left:SetPoint("LEFT", -17, -1);
			local Button = Dropdown.Button;
			Button:ClearAllPoints();
			Button:SetPoint("CENTER", Dropdown, "RIGHT", -12, 0);
			Button:GetNormalTexture():SetAllPoints();
			Button:GetPushedTexture():SetAllPoints();
			Button:GetHighlightTexture():SetAllPoints();
			Button:GetDisabledTexture():SetAllPoints();
			Dropdown:SetScale(0.9);
			Dropdown._SetHeight = Dropdown.SetHeight;
			Dropdown.SetHeight = MT.noop;
			Dropdown:_SetHeight(22);
		end
		function LT_SharedMethod.StyleModernDropDownMenu(Dropdown)
			if not Dropdown.hooked then
				LT_SharedMethod.RelayoutDropDownMenu(Dropdown);
			end
			Dropdown.Left:Hide();
			Dropdown.Middle:Hide();
			Dropdown.Right:Hide();
			VT.__uireimp._SetSimpleBackdrop(Dropdown, 0, 1, 0.0, 0.0, 0.0, 0.25, 0.75, 1.0, 1.0, 0.25);
			local Button = Dropdown.Button;
			Button:SetSize(17, 16);
			Button:SetNormalTexture(T_UIDefinition.texture_modern_arrow_down);
			Button:SetPushedTexture(T_UIDefinition.texture_modern_arrow_down);
			Button:SetHighlightTexture(T_UIDefinition.texture_modern_arrow_down);
			Button:SetDisabledTexture(T_UIDefinition.texture_modern_arrow_down);
			Button:GetNormalTexture():SetVertexColor(unpack(T_UIDefinition.textureButtonColorNormal));
			Button:GetPushedTexture():SetVertexColor(unpack(T_UIDefinition.textureButtonColorPushed));
			Button:GetHighlightTexture():SetVertexColor(unpack(T_UIDefinition.textureButtonColorHighlight));
			Button:GetDisabledTexture():SetVertexColor(unpack(T_UIDefinition.textureButtonColorDisabled));
		end
		function LT_SharedMethod.StyleBLZDropDownMenu(Dropdown)
			Dropdown.Left:Show();
			Dropdown.Middle:Show();
			Dropdown.Right:Show();
			VT.__uireimp._SetSimpleBackdrop(Dropdown, 0, 1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
			local Button = Dropdown.Button;
			Button:SetSize(24, 24);
			Button:SetNormalTexture([[Interface\ChatFrame\UI-ChatIcon-ScrollDown-Up]]);
			Button:SetPushedTexture([[Interface\ChatFrame\UI-ChatIcon-ScrollDown-Down]]);
			Button:SetHighlightTexture([[Interface\Buttons\UI-Common-MouseHilight]]);
			Button:SetDisabledTexture([[Interface\ChatFrame\UI-ChatIcon-ScrollDown-Disabled]]);
			Button:GetNormalTexture():SetVertexColor(1.0, 1.0, 1.0, 1.0);
			Button:GetPushedTexture():SetVertexColor(1.0, 1.0, 1.0, 1.0);
			Button:GetHighlightTexture():SetVertexColor(1.0, 1.0, 1.0, 1.0);
			Button:GetDisabledTexture():SetVertexColor(1.0, 1.0, 1.0, 1.0);
		end
		function LT_SharedMethod.StyleModernEditBox(EditBox)
			local regions = { EditBox:GetRegions() };
			for index = 1, #regions do
				local obj = regions[index];
				if strupper(obj:GetObjectType()) == "TEXTURE" then
					obj:Hide();
				end
			end
			VT.__uireimp._SetSimpleBackdrop(EditBox, 0, 1, 0.0, 0.0, 0.0, 0.25, 0.75, 1.0, 1.0, 0.25);
		end
		function LT_SharedMethod.StyleBLZEditBox(EditBox)
			local regions = { EditBox:GetRegions() };
			for index = 1, #regions do
				regions[index]:Show();
			end
			VT.__uireimp._SetSimpleBackdrop(EditBox, 0, 1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
		end
		function LT_SharedMethod.StyleModernCheckButton(CheckButton)
			CheckButton:SetNormalTexture(T_UIDefinition.texture_modern_check_button_border);
			CheckButton:GetNormalTexture():SetVertexColor(unpack(T_UIDefinition.modernCheckButtonColorNormal));
			CheckButton:SetPushedTexture(T_UIDefinition.texture_modern_check_button_center);
			CheckButton:GetPushedTexture():SetVertexColor(unpack(T_UIDefinition.modernCheckButtonColorPushed));
			CheckButton:SetHighlightTexture(T_UIDefinition.texture_modern_check_button_border);
			CheckButton:GetHighlightTexture():SetVertexColor(unpack(T_UIDefinition.modernCheckButtonColorHighlight));
			CheckButton:SetCheckedTexture(T_UIDefinition.texture_modern_check_button_center);
			CheckButton:GetCheckedTexture():SetVertexColor(unpack(T_UIDefinition.modernCheckButtonColorChecked));
			CheckButton:SetDisabledTexture(T_UIDefinition.texture_modern_check_button_border);
			CheckButton:GetDisabledTexture():SetVertexColor(unpack(T_UIDefinition.modernCheckButtonColorDisabled));
			CheckButton:GetDisabledTexture():SetDesaturated(false);
			CheckButton:SetDisabledCheckedTexture(T_UIDefinition.texture_modern_check_button_border);
			CheckButton:GetDisabledCheckedTexture():SetVertexColor(unpack(T_UIDefinition.modernCheckButtonColorDisabledChecked));
		end
		function LT_SharedMethod.StyleBLZCheckButton(CheckButton)
			CheckButton:SetNormalTexture([[Interface\Buttons\UI-CheckBox-Up]]);
			CheckButton:GetNormalTexture():SetVertexColor(1.0, 1.0, 1.0, 1.0);
			CheckButton:SetPushedTexture([[Interface\Buttons\UI-CheckBox-Down]]);
			CheckButton:GetPushedTexture():SetVertexColor(1.0, 1.0, 1.0, 1.0);
			CheckButton:SetHighlightTexture([[Interface\Buttons\UI-CheckBox-Highlight]]);
			CheckButton:GetHighlightTexture():SetVertexColor(1.0, 1.0, 1.0, 1.0);
			CheckButton:SetCheckedTexture([[Interface\Buttons\UI-CheckBox-Check]]);
			CheckButton:GetCheckedTexture():SetVertexColor(1.0, 1.0, 1.0, 1.0);
			CheckButton:SetDisabledTexture([[Interface\Buttons\UI-CheckBox-Up]]);
			CheckButton:GetDisabledTexture():SetDesaturated(true);
			CheckButton:SetDisabledCheckedTexture([[Interface\Buttons\UI-CheckBox-Check-Disabled]]);
			CheckButton:GetDisabledCheckedTexture():SetVertexColor(1.0, 1.0, 1.0, 1.0);
		end
		--
			local SkillButton_TextureHash = {
				[ [[Interface\Buttons\UI-MinusButton-Up]] ] = T_UIDefinition.texture_modern_button_minus,
				[ [[Interface\Buttons\UI-PlusButton-Up]] ] = T_UIDefinition.texture_modern_button_plus,
				[ [[Interface\Buttons\UI-PlusButton-Hilight]] ] = T_UIDefinition.texture_modern_button_plus,
			};
			local SetTextureReplaced = {
				SetTexture = function(self, tex, hookcall)
					if not hookcall and not VT.SET.blz_style then
						self:SetTexture(SkillButton_TextureHash[tex] or tex);
					end
				end,
				SetNormalTexture = function(self, tex, hookcall)
					if not hookcall and not VT.SET.blz_style then
						tex = SkillButton_TextureHash[tex] or tex;
						self:SetNormalTexture(tex, true);
						-- self:SetHighlightTexture(tex);
					end
				end,
				ClearNormalTexture = function(self, hookcall)
					if not hookcall and not VT.SET.blz_style then
						self:ClearNormalTexture(true);
						self:ClearHighlightTexture(true);
					end
				end,
				SetPushedTexture = function(self, tex, hookcall)
					if not hookcall and not VT.SET.blz_style then
						self:SetPushedTexture(SkillButton_TextureHash[tex] or tex, true);
					end
				end,
				--[[SetHighlightTexture = function(self, tex, hookcall)
					if not hookcall and not VT.SET.blz_style then
						self:SetHighlightTexture(SkillButton_TextureHash[tex] or tex, true);
					end
				end,--]]
				SetDisabledTexture = function(self, tex, hookcall)
					if not hookcall and not VT.SET.blz_style then
						self:SetDisabledTexture(SkillButton_TextureHash[tex] or tex, true);
					end
				end,
			};
			local THookedButton = {  };
		function LT_SharedMethod.StyleModernSkillButton(Button)
			if THookedButton[Button] == nil then
				THookedButton[Button] = true;
				hooksecurefunc(Button, "SetNormalTexture", SetTextureReplaced.SetNormalTexture);
				hooksecurefunc(Button, "ClearNormalTexture", SetTextureReplaced.ClearNormalTexture);
				hooksecurefunc(Button, "SetPushedTexture", SetTextureReplaced.SetPushedTexture);
				-- hooksecurefunc(Button, "SetHighlightTexture", SetTextureReplaced.SetHighlightTexture);
				hooksecurefunc(Button, "SetDisabledTexture", SetTextureReplaced.SetDisabledTexture);
			end
			--[[Button._SetNormalTexture = Button._SetNormalTexture or Button.SetNormalTexture;
			Button.SetNormalTexture = SetTextureReplaced._SetNormalTexture;
			local NormalTexture = Button:GetNormalTexture();
			if NormalTexture then
				NormalTexture._SetTexture = NormalTexture._SetTexture or NormalTexture.SetTexture;
				NormalTexture.SetTexture = SetTextureReplaced._SetTexture;
			end
			Button._ClearNormalTexture = Button._ClearNormalTexture or Button.ClearNormalTexture;
			Button.ClearNormalTexture = SetTextureReplaced._ClearNormalTexture;
			--
			Button._SetPushedTexture = Button._SetPushedTexture or Button.SetPushedTexture;
			Button.SetPushedTexture = SetTextureReplaced._SetPushedTexture;
			local PushedTexture = Button:GetPushedTexture();
			if PushedTexture then
				PushedTexture._SetTexture = PushedTexture._SetTexture or PushedTexture.SetTexture;
				PushedTexture.SetTexture = SetTextureReplaced._SetTexture;
			end
			--
			Button._SetHighlightTexture = Button._SetHighlightTexture or Button.SetHighlightTexture;
			Button.SetHighlightTexture = SetTextureReplaced._SetHighlightTexture;
			local HighlightTexture = Button:GetHighlightTexture();
			if HighlightTexture then
				HighlightTexture._SetTexture = HighlightTexture._SetTexture or HighlightTexture.SetTexture;
				HighlightTexture.SetTexture = MT.noop;
			end
			--
			Button._SetDisabledTexture = Button._SetDisabledTexture or Button.SetDisabledTexture;
			Button.SetDisabledTexture = SetTextureReplaced._SetDisabledTexture;
			local DisabledTexture = Button:GetDisabledTexture();
			if DisabledTexture then
				DisabledTexture._SetTexture = DisabledTexture._SetTexture or DisabledTexture.SetTexture;
				DisabledTexture.SetTexture = SetTextureReplaced._SetTexture;
			end--]]
			Button:SetPushedTextOffset(0.0, 0.0);
		end
		function LT_SharedMethod.StyleBLZSkillButton(Button)
			--[[if Button._SetNormalTexture then
				Button.SetNormalTexture = Button._SetNormalTexture;
			end
			local NormalTexture = Button:GetNormalTexture();
			if NormalTexture and NormalTexture._SetTexture then
				NormalTexture.SetTexture = NormalTexture._SetTexture;
			end
			if Button._SetPushedTexture then
				Button.SetPushedTexture = Button._SetPushedTexture;
			end
			local PushedTexture = Button:GetPushedTexture();
			if PushedTexture and PushedTexture._SetTexture then
				PushedTexture.SetTexture = PushedTexture._SetTexture;
			end
			if Button._SetHighlightTexture then
				Button.SetHighlightTexture = Button._SetHighlightTexture;
			end
			local HighlightTexture = Button:GetHighlightTexture();
			if HighlightTexture and HighlightTexture._SetTexture then
				HighlightTexture.SetTexture = HighlightTexture._SetTexture;
			end
			if Button._SetDisabledTexture then
				Button.SetDisabledTexture = Button._SetDisabledTexture;
			end
			local DisabledTexture = Button:GetDisabledTexture();
			if DisabledTexture and DisabledTexture._SetTexture then
				DisabledTexture.SetTexture = DisabledTexture._SetTexture;
			end--]]
			Button:SetPushedTextOffset(1.55, -1.55);
		end
		--
		function LT_SharedMethod.StyleModernSlider(Slider)
		end
		function LT_SharedMethod.StyleBLZSlider(Slider)
		end
		--
		function LT_SharedMethod.StyleModernALADropButton(Dropdown)
			Dropdown:SetNormalTexture(T_UIDefinition.texture_modern_arrow_down);
			Dropdown:GetNormalTexture():SetTexCoord(0.0, 1.0, 0.0, 1.0);
			Dropdown:GetNormalTexture():SetVertexColor(unpack(T_UIDefinition.textureButtonColorNormal));
			Dropdown:SetPushedTexture(T_UIDefinition.texture_modern_arrow_down);
			Dropdown:GetPushedTexture():SetTexCoord(0.0, 1.0, 0.0, 1.0);
			Dropdown:GetPushedTexture():SetVertexColor(unpack(T_UIDefinition.textureButtonColorPushed));
			Dropdown:SetHighlightTexture(T_UIDefinition.texture_modern_arrow_down);
			Dropdown:GetHighlightTexture():SetTexCoord(0.0, 1.0, 0.0, 1.0);
			Dropdown:GetHighlightTexture():SetVertexColor(unpack(T_UIDefinition.textureButtonColorHighlight));
			Dropdown:SetDisabledTexture(T_UIDefinition.texture_modern_arrow_down);
			Dropdown:GetDisabledTexture():SetTexCoord(0.0, 1.0, 0.0, 1.0);
			Dropdown:GetDisabledTexture():SetVertexColor(unpack(T_UIDefinition.textureButtonColorDisabled));
		end
		function LT_SharedMethod.StyleBLZALADropButton(Dropdown)
			Dropdown:SetNormalTexture([[Interface\MainMenuBar\UI-MainMenu-ScrollDownButton-UP]]);
			Dropdown:GetNormalTexture():SetTexCoord(6 / 32, 26 / 32, 6 / 32, 26 / 32);
			Dropdown:GetNormalTexture():SetVertexColor(1.0, 1.0, 1.0, 1.0);
			Dropdown:SetPushedTexture([[Interface\MainMenuBar\UI-MainMenu-ScrollDownButton-UP]]);
			Dropdown:GetPushedTexture():SetTexCoord(6 / 32, 26 / 32, 6 / 32, 26 / 32);
			Dropdown:GetPushedTexture():SetVertexColor(unpack(T_UIDefinition.textureButtonColorPushed));
			Dropdown:SetHighlightTexture([[Interface\MainMenuBar\UI-MainMenu-ScrollDownButton-UP]]);
			Dropdown:GetHighlightTexture():SetTexCoord(6 / 32, 26 / 32, 6 / 32, 26 / 32);
			Dropdown:GetHighlightTexture():SetVertexColor(unpack(T_UIDefinition.textureButtonColorHighlight));
			Dropdown:SetDisabledTexture([[Interface\MainMenuBar\UI-MainMenu-ScrollDownButton-UP]]);
			Dropdown:GetDisabledTexture():SetTexCoord(6 / 32, 26 / 32, 6 / 32, 26 / 32);
			Dropdown:GetDisabledTexture():SetVertexColor(unpack(T_UIDefinition.textureButtonColorDisabled));
		end
	--
	function LT_SharedMethod.UICreateSearchBox(Frame)
		local SearchEditBox = CreateFrame('EDITBOX', nil, Frame);
		SearchEditBox:SetHeight(16);
		SearchEditBox:SetFont(T_UIDefinition.frameNormalFont, T_UIDefinition.frameNormalFontSize, T_UIDefinition.frameNormalFontFlag);
		SearchEditBox:SetAutoFocus(false);
		SearchEditBox:SetJustifyH("LEFT");
		SearchEditBox:Show();
		SearchEditBox:EnableMouse(true);
		SearchEditBox:ClearFocus();
		SearchEditBox:SetScript("OnEnterPressed", function(self) self:ClearFocus(); end);
		SearchEditBox:SetScript("OnEscapePressed", function(self) self:ClearFocus(); end);
		Frame.SearchEditBox = SearchEditBox;

		local SearchEditBoxTexture = SearchEditBox:CreateTexture(nil, "ARTWORK");
		SearchEditBoxTexture:SetPoint("TOPLEFT");
		SearchEditBoxTexture:SetPoint("BOTTOMRIGHT");
		SearchEditBoxTexture:SetTexture([[Interface\Buttons\GreyScaleramp64]]);
		SearchEditBoxTexture:SetTexCoord(0.0, 0.25, 0.0, 0.25);
		SearchEditBoxTexture:SetAlpha(0.75);
		SearchEditBoxTexture:SetBlendMode("ADD");
		SearchEditBoxTexture:SetVertexColor(0.25, 0.25, 0.25);

		local SearchEditBoxNote = SearchEditBox:CreateFontString(nil, "OVERLAY");
		SearchEditBoxNote:SetFont(T_UIDefinition.frameNormalFont, T_UIDefinition.frameNormalFontSize, T_UIDefinition.frameNormalFontFlag);
		SearchEditBoxNote:SetTextColor(1.0, 1.0, 1.0, 0.5);
		SearchEditBoxNote:SetPoint("LEFT", 4, 0);
		SearchEditBoxNote:SetText(l10n["Search"]);
		SearchEditBoxNote:Show();

		local SearchEditBoxCancel = CreateFrame('BUTTON', nil, SearchEditBox);
		SearchEditBoxCancel:SetSize(16, 16);
		SearchEditBoxCancel:SetPoint("RIGHT", SearchEditBox);
		SearchEditBoxCancel:Hide();
		SearchEditBoxCancel:SetNormalTexture(T_UIDefinition.texture_modern_button_close);
		SearchEditBoxCancel:SetScript("OnClick", function(self) SearchEditBox:SetText(""); Frame:F_Search(""); SearchEditBox:ClearFocus(); end);

		local SearchEditBoxOK = CreateFrame('BUTTON', nil, Frame);
		SearchEditBoxOK:SetSize(32, 16);
		SearchEditBoxOK:Disable();
		SearchEditBoxOK:SetNormalTexture(T_UIDefinition.texture_unk);
		SearchEditBoxOK:GetNormalTexture():SetColorTexture(0.25, 0.25, 0.25, 0.5);
		local SearchEditBoxOKText = SearchEditBoxOK:CreateFontString(nil, "OVERLAY");
		SearchEditBoxOKText:SetFont(T_UIDefinition.frameNormalFont, T_UIDefinition.frameNormalFontSize, T_UIDefinition.frameNormalFontFlag);
		SearchEditBoxOKText:SetTextColor(1.0, 1.0, 1.0, 0.5);
		SearchEditBoxOKText:SetPoint("CENTER");
		SearchEditBoxOKText:SetText(l10n["OK"]);

		SearchEditBoxOK:SetFontString(SearchEditBoxOKText);
		SearchEditBoxOK:SetPushedTextOffset(0, -1);
		SearchEditBoxOK:SetScript("OnClick", function(self) SearchEditBox:ClearFocus(); end);
		SearchEditBoxOK:SetScript("OnEnable", function(self) SearchEditBoxOKText:SetTextColor(1.0, 1.0, 1.0, 1.0); end);
		SearchEditBoxOK:SetScript("OnDisable", function(self) SearchEditBoxOKText:SetTextColor(1.0, 1.0, 1.0, 0.5); end);
		SearchEditBoxOK:Disable();
		Frame.SearchEditBoxOK = SearchEditBoxOK;

		local SearchEditBoxNameOnly = CreateFrame('CHECKBUTTON', nil, Frame, "OptionsBaseCheckButtonTemplate");
		SearchEditBoxNameOnly:SetSize(24, 24);
		SearchEditBoxNameOnly:SetHitRectInsets(0, 0, 0, 0);
		SearchEditBoxNameOnly:Show();
		SearchEditBoxNameOnly:SetChecked(false);
		SearchEditBoxNameOnly.info_lines = { l10n["TIP_SEARCH_NAME_ONLY_INFO"], };
		SearchEditBoxNameOnly:SetScript("OnEnter", LT_SharedMethod.ButtonInfoOnEnter);
		SearchEditBoxNameOnly:SetScript("OnLeave", LT_SharedMethod.ButtonInfoOnLeave);
		SearchEditBoxNameOnly:SetScript("OnClick", function(self)
			local pid = Frame.flag or DataAgent.get_pid_by_pname(Frame.F_GetSkillName());
			if pid ~= nil then
				MT.ChangeSetWithUpdate(VT.SET[pid], "searchNameOnly", self:GetChecked());
			end
			Frame.F_Update();
		end);
		Frame.SearchEditBoxNameOnly = SearchEditBoxNameOnly;

		function Frame:F_Search(text)
			local pid = Frame.flag or DataAgent.get_pid_by_pname(Frame.F_GetSkillName());
			if pid ~= nil then
				if text == "" then
					MT.ChangeSetWithUpdate(VT.SET[pid], "searchText", nil);
					if not SearchEditBox:HasFocus() then
						SearchEditBoxNote:Show();
					end
					SearchEditBoxCancel:Hide();
				else
					MT.ChangeSetWithUpdate(VT.SET[pid], "searchText", text);
					SearchEditBoxCancel:Show();
					SearchEditBoxNote:Hide();
				end
			end
			Frame.F_Update();
		end
		function Frame:F_RefreshSearchEdit(pid)
			local pid = Frame.flag or DataAgent.get_pid_by_pname(Frame.F_GetSkillName());
			if pid ~= nil then
				local searchText = VT.SET[pid].searchText or "";
				if SearchEditBox:GetText() ~= searchText then
					SearchEditBox:SetText(searchText);
				end
				if searchText == "" then
					if not SearchEditBox:HasFocus() then
						SearchEditBoxNote:Show();
					end
					SearchEditBoxCancel:Hide();
				else
					SearchEditBoxCancel:Show();
					SearchEditBoxNote:Hide();
				end
			end
		end
		function Frame:F_SearchEditValid()
			SearchEditBoxTexture:SetVertexColor(0.25, 0.25, 0.25);
		end
		function Frame:F_SearchEditInvalid()
			SearchEditBoxTexture:SetVertexColor(0.25, 0.0, 0.0);
		end
		SearchEditBox:SetScript("OnTextChanged", function(self, isUserInput)
			if isUserInput then
				Frame:F_Search(self:GetText());
			end
		end);
		SearchEditBox:SetScript("OnEditFocusGained", function(self)
			SearchEditBoxNote:Hide();
			SearchEditBoxOK:Enable();
		end);
		SearchEditBox:SetScript("OnEditFocusLost", function(self)
			if self:GetText() == "" then
				SearchEditBoxNote:Show();
			end
			SearchEditBoxOK:Disable();
		end);

		return SearchEditBox, SearchEditBoxOK, SearchEditBoxNameOnly;
	end
	function LT_SharedMethod.SkillListButton_SendReagents(Frame, sid)
		local recipeindex = Frame and Frame.hash[sid];
		local text1 = nil;
		local text2 = nil;
		if recipeindex and DataAgent.T_TradeSkill_ID[Frame.flag] ~= nil then
			local n = Frame.F_GetRecipeNumReagents(recipeindex);
			if n and n > 0 then
				local m1, m2 = Frame.F_GetRecipeNumMade(recipeindex);
				if m1 == m2 then
					text1 = Frame.F_GetRecipeItemLink(recipeindex) .. "x" .. m1 .. l10n["PRINT_MATERIALS: "];
				else
					text1 = Frame.F_GetRecipeItemLink(recipeindex) .. "x" .. m1 .. "-" .. m2 .. l10n["PRINT_MATERIALS: "];
				end
				text2 = "";
				if n > 4 then
					for i = 1, n do
						text2 = text2 .. Frame.F_GetRecipeReagentInfo(recipeindex, i) .. "x" .. select(3, Frame.F_GetRecipeReagentInfo(recipeindex, i));
					end
				else
					for i = 1, n do
						text2 = text2 .. Frame.F_GetRecipeReagentLink(recipeindex, i) .. "x" .. select(3, Frame.F_GetRecipeReagentInfo(recipeindex, i));
					end
				end
			end
		else
			local info = DataAgent.get_info_by_sid(sid);
			local cid = info[index_cid];
			if info ~= nil then
				if cid then
					text1 = DataAgent.item_link_s(cid) .. "x" .. (info[index_num_made_min] == info[index_num_made_max] and info[index_num_made_min] or (info[index_num_made_min] .. "-" .. info[index_num_made_max])) .. l10n["PRINT_MATERIALS: "];
				else
					text1 = DataAgent.spell_name_s(sid) .. l10n["PRINT_MATERIALS: "];
				end
				text2 = "";
				local rinfo = info[index_reagents_id];
				if #rinfo > 4 then
					for i = 1, #rinfo do
						text2 = text2 .. DataAgent.item_name_s(rinfo[i]) .. "x" .. info[index_reagents_count][i];
					end
				else
					for i = 1, #rinfo do
						text2 = text2 .. DataAgent.item_link_s(rinfo[i]) .. "x" .. info[index_reagents_count][i];
					end
				end
			end
		end
		if text1 and text2 then
			local editBox = ChatEdit_ChooseBoxForSend();
			editBox:Show();
			editBox:SetFocus();
			editBox:Insert(text1 .. " " .. text2);
			-- ChatEdit_InsertLink(text1 .. " " .. text2, false);
		end
	end
	--	list button handler
		local T_SkillListDropList = {
			SendReagents = {
				handler = function(self, param1, param2)
					LT_SharedMethod.SkillListButton_SendReagents(param1[1], param1[3]);
				end,
				text = l10n["SEND_REAGENTS"],
			},
			AddFav = {
				handler = function(self, param1, param2)
					VT.SET[param1[2]].update = true;
					VT.FAV[param1[3]] = 1;
					param1[1].F_Update();
				end,
				text = l10n["ADD_FAV"],
			},
			SubFav = {
				handler = function(self, param1, param2)
					VT.SET[param1[2]].update = true;
					VT.FAV[param1[3]] = nil;
					param1[1].F_Update();
				end,
				text = l10n["SUB_FAV"],
			},
			QueryWhoCanCraftIt = {
				handler = function(self, param1, param2)
					MT.CommQuerySpell(param1[3]);
				end,
				text = l10n["QUERY_WHO_CAN_CRAFT_IT"],
			},
		};
		local T_SkillListDropMeta = {
			param = {  },
			num = 0,
		};
	--
	function LT_SharedMethod.SkillListButton_OnEnter(self)
		local Frame = self.Frame;
		local sid = self.list[self:GetDataIndex()];
		if type(sid) == 'table' then
			sid = sid[1];
		end
		local pid = Frame.flag or DataAgent.get_pid_by_sid(sid) or DataAgent.get_pid_by_pname(Frame.F_GetSkillName());
		if pid ~= nil then
			local set = VT.SET[pid];
			SkillTip.__phase = set.phase;
			SkillTip:SetOwner(self, "ANCHOR_RIGHT");
			local info = DataAgent.get_info_by_sid(sid);
			if info ~= nil then
				if set.showItemInsteadOfSpell and info[index_cid] then
					SkillTip:SetItemByID(info[index_cid]);
				else
					SkillTip:SetSpellByID(sid);
				end
				local phase = info[index_phase];
				if phase > DataAgent.CURPHASE then
					SkillTip:AddLine("|cffff0000" .. l10n["AVAILABLE_IN_PHASE_"] .. phase .. "|r");
				end
				SkillTip:Show();
			else
				SkillTip:SetSpellByID(sid);
			end
			local text = DataAgent.get_difficulty_rank_list_text_by_sid(sid, true);
			if text ~= nil then
				SkillTip:AddDoubleLine(l10n["LABEL_RANK_LEVEL"], text);
				SkillTip:Show();
			end
			local recipeindex = Frame.hash[sid];
			if pid == 'explorer' then
				local hash = DataAgent.LearnedRecipesHash[sid];
				if hash then
					local str = l10n["RECIPE_LEARNED"] .. ": ";
					local pos = 0;
					for GUID, _ in next, hash do
						if pos ~= 0 and pos % 3 == 0 then
							str = str .. "\n        ";
						end
						local lClass, class, lRace, race, sex, name = GetPlayerInfoByGUID(GUID);
						if name and class then
							local classColorTable = RAID_CLASS_COLORS[strupper(class)];
							name = format("|cff%.2x%.2x%.2x", classColorTable.r * 255, classColorTable.g * 255, classColorTable.b * 255) .. name .. "|r";
							str = str .. " " .. name;
						else
							str = str .. " " .. GUID;
						end
						pos = pos + 1;
					end
					SkillTip:AddLine(str);
					SkillTip:Show();
				else
				end
				recipeindex = recipeindex and recipeindex[CT.SELFGUID];
			end
			if recipeindex == nil then
				MT.TooltipAddSource(SkillTip, sid);
			end
		end
	end
	function LT_SharedMethod.SkillListButton_OnLeave(self)
		SkillTip:Hide();
	end
	function LT_SharedMethod.SkillListButton_OnClick(self, button)
		if button == "LeftButton" then
			if IsShiftKeyDown() then
				local sid = self.list[self:GetDataIndex()];
				if type(sid) == 'table' then
					sid = sid[1];
				end
				MT.HandleShiftClick(self.flag or DataAgent.get_pid_by_sid(sid), sid);
			elseif IsAltKeyDown() then
				local Frame = self.Frame;
				local sid = self.list[self:GetDataIndex()];
				if type(sid) == 'table' then
					sid = sid[1];
				end
				LT_SharedMethod.SkillListButton_SendReagents(Frame, sid);
			elseif IsControlKeyDown() then
				local sid = self.list[self:GetDataIndex()];
				if type(sid) == 'table' then
					sid = sid[1];
				end
				local cid = DataAgent.get_cid_by_sid(sid);
				if cid then
					local link = DataAgent.item_link(cid);
					if link then
						DressUpItemLink(link);
					end
				end
			else
				local Frame = self.Frame;
				if Frame.flag ~= 'explorer' then
					local sid = self.list[self:GetDataIndex()];
					if type(sid) == 'table' then
						sid = sid[1];
					end
					LT_SharedMethod.SelectRecipe(Frame, sid);
				end
			end
		elseif button == "RightButton" then
			local Frame = self.Frame;
			local sid = self.list[self:GetDataIndex()];
			if type(sid) == 'table' then
				sid = sid[1];
			end
			Frame.SearchEditBox:ClearFocus();
			local pid = Frame.flag or DataAgent.get_pid_by_sid(sid) or DataAgent.get_pid_by_pname(Frame.F_GetSkillName());
			T_SkillListDropMeta.param[1] = Frame;
			T_SkillListDropMeta.param[2] = pid;
			T_SkillListDropMeta.param[3] = sid;
			T_SkillListDropMeta[1] = T_SkillListDropList.SendReagents;
			if VT.FAV[sid] then
				T_SkillListDropMeta[2] = T_SkillListDropList.SubFav;
			else
				T_SkillListDropMeta[2] = T_SkillListDropList.AddFav;
			end
			if CT.BNTAG == 'alex#516722' or CT.BNTAG == '单酒窝#51637' then
				T_SkillListDropMeta[3] = T_SkillListDropList.QueryWhoCanCraftIt;
				T_SkillListDropMeta.num = 3;
			else
				T_SkillListDropMeta.num = 2;
			end
			VT.__menulib.ShowMenu(self, "BOTTOMLEFT", T_SkillListDropMeta, T_SkillListDropMeta.param);
		end
	end
	function LT_SharedMethod.ProfitCreateSkillListButton(parent, index, buttonHeight)
		local Button = CreateFrame('BUTTON', nil, parent);
		Button:SetHeight(buttonHeight);
		VT.__uireimp._SetSimpleBackdrop(Button, 0, 1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
		Button:SetHighlightTexture(T_UIDefinition.texture_white);
		Button:GetHighlightTexture():SetVertexColor(unpack(T_UIDefinition.listButtonHighlightColor));
		Button:EnableMouse(true);
		Button:Show();

		local Icon = Button:CreateTexture(nil, "BORDER");
		Icon:SetTexture(T_UIDefinition.texture_unk);
		Icon:SetSize(buttonHeight - 4, buttonHeight - 4);
		Icon:SetPoint("LEFT", 8, 0);
		Button.Icon = Icon;

		local Title = Button:CreateFontString(nil, "OVERLAY");
		Title:SetFont(T_UIDefinition.frameNormalFont, T_UIDefinition.frameNormalFontSize, T_UIDefinition.frameNormalFontFlag);
		Title:SetPoint("LEFT", Icon, "RIGHT", 4, 0);
		-- Title:SetWidth(160);
		Title:SetMaxLines(1);
		Title:SetJustifyH("LEFT");
		Button.Title = Title;

		local Num = Button:CreateFontString(nil, "OVERLAY");
		Num:SetFont(T_UIDefinition.frameNormalFont, T_UIDefinition.frameNormalFontSize, T_UIDefinition.frameNormalFontFlag);
		Num:SetPoint("LEFT", Title, "RIGHT", 2, 0);
		-- Num:SetWidth(160);
		Num:SetMaxLines(1);
		Num:SetJustifyH("LEFT");
		Button.Num = Num;

		local Note = Button:CreateFontString(nil, "ARTWORK");
		Note:SetFont(T_UIDefinition.frameNormalFont, T_UIDefinition.frameNormalFontSize, T_UIDefinition.frameNormalFontFlag);
		Note:SetPoint("RIGHT", -4, 0);
		Button.Note = Note;

		-- Title:SetPoint("RIGHT", Note, "LEFT", -4, 0);

		local QualityGlow = Button:CreateTexture(nil, "ARTWORK");
		QualityGlow:SetTexture([[Interface\Buttons\UI-ActionButton-Border]]);
		QualityGlow:SetBlendMode("ADD");
		QualityGlow:SetTexCoord(0.25, 0.75, 0.25, 0.75);
		QualityGlow:SetSize(buttonHeight - 2, buttonHeight - 2);
		QualityGlow:SetPoint("CENTER", Icon);
		-- QualityGlow:SetAlpha(0.75);
		QualityGlow:Show();
		Button.QualityGlow = QualityGlow;

		local Star = Button:CreateTexture(nil, "OVERLAY");
		Star:SetTexture([[Interface\Collections\Collections]]);
		Star:SetTexCoord(100 / 512, 118 / 512, 10 / 512, 28 / 512);
		Star:SetSize(buttonHeight * 0.75, buttonHeight * 0.75);
		Star:SetPoint("CENTER", Button, "TOPLEFT", buttonHeight * 0.25, -buttonHeight * 0.25);
		Star:Hide();
		Button.Star = Star;

		local SelectionGlow = Button:CreateTexture(nil, "OVERLAY");
		SelectionGlow:SetTexture(T_UIDefinition.texture_white);
		-- SelectionGlow:SetTexCoord(0.25, 0.75, 0.25, 0.75);
		SelectionGlow:SetVertexColor(unpack(T_UIDefinition.listButtonSelectedColor));
		SelectionGlow:SetAllPoints();
		SelectionGlow:SetBlendMode("ADD");
		SelectionGlow:Hide();
		Button.SelectionGlow = SelectionGlow;

		Button:SetScript("OnEnter", LT_SharedMethod.SkillListButton_OnEnter);
		Button:SetScript("OnLeave", LT_SharedMethod.SkillListButton_OnLeave);
		Button:RegisterForClicks("AnyUp");
		Button:SetScript("OnClick", LT_SharedMethod.SkillListButton_OnClick);
		Button:RegisterForDrag("LeftButton");
		Button:SetScript("OnHide", VT.__menulib.ShowMenu);

		function Button:Select()
			SelectionGlow:Show();
		end
		function Button:Deselect()
			SelectionGlow:Hide();
		end

		local Frame = parent:GetParent():GetParent();
		Button.Frame = Frame:GetParent();
		Button.list = Frame.list;
		Button.flag = Frame.flag;

		return Button;
	end
	function LT_SharedMethod.ProfitSetSkillListButton(Button, data_index)
		local Frame = Button.Frame;
		local list = Button.list;
		local hash = Frame.hash;
		if data_index <= #list then
			local val = list[data_index];
			local sid = val[1];
			local cid = DataAgent.get_cid_by_sid(sid);
			local recipeindex = hash[sid];
			if recipeindex ~= nil then
				if Frame.flag == 'explorer' then
					Button:Show();
					local _, quality, icon;
					if cid ~= nil then
						_, _, quality, _, icon = DataAgent.item_info(cid);
					else
						quality = nil;
						icon = ICON_FOR_NO_CID;
					end
					VT.__uireimp._SetSimpleBackdropCenter(Button, 0, 1, 0.0, 0.0, 0.0, 1.0);
					Button.Icon:SetTexture(icon);
					Button.Icon:SetVertexColor(1.0, 1.0, 1.0, 1.0);
					Button.Title:SetText(DataAgent.spell_name_s(sid));
					Button.Title:SetTextColor(0.0, 1.0, 0.0, 1.0);
					Button.Title:SetWidth(230);
					Button.Note:SetText(MT.GetMoneyString(val[2]));
					if quality ~= nil then
						local r, g, b, code = GetItemQualityColor(quality);
						Button.QualityGlow:SetVertexColor(r, g, b);
						Button.QualityGlow:Show();
					else
						Button.QualityGlow:Hide();
					end
					if VT.FAV[sid] ~= nil then
						Button.Star:Show();
					else
						Button.Star:Hide();
					end
					Button:Deselect();
				else
					local name, rank, num = Frame.F_GetRecipeInfo(recipeindex);
					if name ~= nil and rank ~= 'header' then
						Button:Show();
						VT.__uireimp._SetSimpleBackdropCenter(Button, 0, 1, 0.0, 0.0, 0.0, 1.0);
						local _, quality, icon;
						if cid ~= nil then
							_, _, quality, _, icon = DataAgent.item_info(cid);
						else
							quality = nil;
							icon = ICON_FOR_NO_CID;
						end
						Button.Icon:SetTexture(Frame.F_GetRecipeIcon(recipeindex));
						Button.Icon:SetVertexColor(1.0, 1.0, 1.0, 1.0);
						Button.Title:SetWidth(0);
						Button.Title:SetText(name);
						Button.Title:SetTextColor(unpack(CT.T_RankColor[CT.T_RankIndex[rank]] or T_UIDefinition.color_white));
						if num > 0 then
							if Button.Title:GetWidth() > 210 then
								Button.Title:SetWidth(210);
							end
							Button.Num:SetText("[" .. num .. "]");
							Button.Num:SetTextColor(unpack(CT.T_RankColor[CT.T_RankIndex[rank]] or T_UIDefinition.color_white));
						else
							Button.Title:SetWidth(230);
							Button.Num:SetText("");
						end
						Button.Note:SetText(MT.GetMoneyString(val[2]));
						if quality ~= nil then
							local r, g, b, code = GetItemQualityColor(quality);
							Button.QualityGlow:SetVertexColor(r, g, b);
							Button.QualityGlow:Show();
						else
							Button.QualityGlow:Hide();
						end
						if VT.FAV[sid] ~= nil then
							Button.Star:Show();
						else
							Button.Star:Hide();
						end
						if GetMouseFocus() == Button then
							LT_SharedMethod.SkillListButton_OnEnter(Button);
						end
						if sid == Frame.selected_sid then
							Button:Select();
						else
							Button:Deselect();
						end
					else
						Button:Hide();
					end
				end
			else
				Button:Show();
				if VT.SET.colored_rank_for_unknown and Frame.flag ~= 'explorer' then
					VT.__uireimp._SetSimpleBackdropCenter(Button, 0, 1, 0.5, 0.25, 0.25, 0.5);
				else
					VT.__uireimp._SetSimpleBackdropCenter(Button, 0, 1, 0.0, 0.0, 0.0, 1.0);
				end
				local _, quality, icon;
				if cid ~= nil then
					_, _, quality, _, icon = DataAgent.item_info(cid);
				else
					quality = nil;
					icon = ICON_FOR_NO_CID;
				end
				Button.Icon:SetTexture(icon);
				Button.Icon:SetVertexColor(1.0, 0.0, 0.0, 1.0);
				Button.Title:SetWidth(0);
				Button.Title:SetText(DataAgent.spell_name_s(sid));
				if VT.SET.colored_rank_for_unknown and Frame.flag ~= 'explorer' then
					local pid = Frame.flag or DataAgent.get_pid_by_sid(sid) or DataAgent.get_pid_by_pname(Frame.F_GetSkillName());
					local var = rawget(VT.VAR, pid);
					local cur_rank = var and var.cur_rank or 0;
					Button.Title:SetTextColor(unpack(CT.T_RankColor[DataAgent.get_difficulty_rank_by_sid(sid, cur_rank)] or T_UIDefinition.color_white));
				else
					Button.Title:SetTextColor(1.0, 0.0, 0.0, 1.0);
				end
				Button.Title:SetWidth(230);
				Button.Num:SetText("");
				Button.Note:SetText(MT.GetMoneyString(val[2]));
				if quality ~= nil then
					local r, g, b, code = GetItemQualityColor(quality);
					Button.QualityGlow:SetVertexColor(r, g, b);
					Button.QualityGlow:Show();
				else
					Button.QualityGlow:Hide();
				end
				if VT.FAV[sid] ~= nil then
					Button.Star:Show();
				else
					Button.Star:Hide();
				end
				Button:Deselect();
			end
			if GetMouseFocus() == Button then
				LT_SharedMethod.SkillListButton_OnEnter(Button);
			end
			if Button.prev_sid ~= sid then
				VT.__menulib.ShowMenu(Button);
				Button.prev_sid = sid;
			end
			Button.val = val;
		else
			VT.__menulib.ShowMenu(Button);
			Button:Hide();
			Button.val = nil;
		end
	end
--
--	Method
	local LT_FrameMethod = {  };
	local LT_WidgetMethod = {  };
	--
	function LT_FrameMethod.F_UpdatePriceInfo(Frame)
		local T_PriceInfoInFrame = Frame.T_PriceInfoInFrame;
		if VT.AuctionMod ~= nil and VT.SET.show_tradeskill_frame_price_info then
			local sid = Frame.selected_sid;
			if sid == nil or sid <= 0 then
				T_PriceInfoInFrame[1]:SetText("");
				T_PriceInfoInFrame[2]:SetText("");
				T_PriceInfoInFrame[3]:SetText("");
				return;
			end
			local info = DataAgent.get_info_by_sid(sid);
			if info ~= nil then
				local pid = info[index_pid];
				local nMade = DataAgent.get_num_made_by_sid(sid);
				local price_a_product, _, price_a_material, unk_in, cid = MT.GetPriceInfoBySID(VT.SET[pid].phase, sid, nMade);
				if price_a_material > 0 then
					T_PriceInfoInFrame[2]:SetText(
						l10n["COST_PRICE"] .. ": " ..
						(unk_in > 0 and (MT.GetMoneyString(price_a_material) .. " (|cffff0000" .. unk_in .. l10n["ITEMS_UNK"] .. "|r)") or MT.GetMoneyString(price_a_material))
					);
				else
					T_PriceInfoInFrame[2]:SetText(
						l10n["COST_PRICE"] .. ": " ..
						"|cffff0000" .. l10n["PRICE_UNK"] .. "|r"
					);
				end

				if cid ~= nil then
					-- local price_a_product = VT.AuctionMod.F_QueryPriceByID(cid);
					local price_v_product = DataAgent.item_sellPrice(info[index_cid]);
					-- local minMade, maxMade = Frame.num_made(index);
					-- local nMade = (minMade + maxMade) / 2;
					-- price_a_product = price_a_product and price_a_product * nMade;
					price_v_product = price_v_product and price_v_product * nMade;
					if price_a_product and price_a_product > 0 then
						T_PriceInfoInFrame[1]:SetText(
							l10n["AH_PRICE"] .. ": " ..
							MT.GetMoneyString(price_a_product) .. " (" .. l10n["VENDOR_RPICE"] .. (price_v_product and MT.GetMoneyString(price_v_product) or l10n["NEED_UPDATE"]) .. ")"
						);
						if price_a_material > 0 then
							local diff = price_a_product - price_a_material;
							local diffAH = price_a_product * 0.95 - price_a_material;
							if diff > 0 then
								if diffAH > 0 then
									T_PriceInfoInFrame[3]:SetText(l10n["PRICE_DIFF+"] .. ": " .. MT.GetMoneyString(diff) .. " (" .. l10n["PRICE_DIFF_AH+"] .. " " .. MT.GetMoneyString(diffAH) .. ")");
								elseif diffAH < 0 then
									T_PriceInfoInFrame[3]:SetText(l10n["PRICE_DIFF+"] .. ": " .. MT.GetMoneyString(diff) .. " (" .. l10n["PRICE_DIFF_AH-"] .. " " .. MT.GetMoneyString(-diffAH) .. ")");
								else
									T_PriceInfoInFrame[3]:SetText(l10n["PRICE_DIFF+"] .. ": " .. MT.GetMoneyString(diff) .. " (" .. l10n["PRICE_DIFF_AH0"] .. " " .. l10n["PRICE_DIFF0"] .. ")");
								end
							elseif diff < 0 then
								T_PriceInfoInFrame[3]:SetText(l10n["PRICE_DIFF-"] .. ": " .. MT.GetMoneyString(-diff) .. " (" .. l10n["PRICE_DIFF_AH-"] .. " " .. MT.GetMoneyString(-diffAH) .. ")");
							else
								if diffAH < 0 then
									T_PriceInfoInFrame[3]:SetText(l10n["PRICE_DIFF0"] .. " (" .. l10n["PRICE_DIFF_AH-"] .. " " .. MT.GetMoneyString(-diffAH) .. ")");
								else
								end
							end
						else
							T_PriceInfoInFrame[3]:SetText("");
						end
					else
						local bindType = DataAgent.item_bindType(cid);
						if bindType == 1 or bindType == 4 then
							T_PriceInfoInFrame[1]:SetText(
								l10n["AH_PRICE"] .. ": " ..
								l10n["BOP"] .. " (" .. l10n["VENDOR_RPICE"] .. (price_v_product and MT.GetMoneyString(price_v_product) or l10n["NEED_UPDATE"]) .. ")"
							);
						else
							T_PriceInfoInFrame[1]:SetText(
								l10n["AH_PRICE"] .. ": " ..
								"|cffff0000" .. l10n["PRICE_UNK"] .. "|r (" .. l10n["VENDOR_RPICE"] .. (price_v_product and MT.GetMoneyString(price_v_product) or l10n["NEED_UPDATE"]) .. ")"
							);
						end
						T_PriceInfoInFrame[3]:SetText("");
					end
				end
			else
				T_PriceInfoInFrame[1]:SetText("");
				T_PriceInfoInFrame[2]:SetText("");
				T_PriceInfoInFrame[3]:SetText("");
			end
		else
			T_PriceInfoInFrame[1]:SetText("");
			T_PriceInfoInFrame[2]:SetText("");
			T_PriceInfoInFrame[3]:SetText("");
		end
	end
	function LT_FrameMethod.F_UpdateRankInfo(Frame)
		if VT.SET.show_tradeskill_frame_rank_info then
			Frame.RankInfoInFrame:SetText(DataAgent.get_difficulty_rank_list_text_by_sid(Frame.selected_sid, true));
		else
			Frame.RankInfoInFrame:SetText("");
		end
	end
	--
	function LT_FrameMethod.F_Expand(Frame, expanded)
		local T_StyleLayout = Frame.T_StyleLayout;
		local layout = T_StyleLayout[expanded and 'expand' or 'normal'];
		Frame:ClearAllPoints();
		for index = 1, #layout.anchor do
			Frame:SetPoint(unpack(layout.anchor[index]));
		end
		Frame:SetSize(unpack(layout.size));
		Frame.HookedFrame:SetSize(unpack(layout.frame_size));
		Frame.HookedScrollFrame:ClearAllPoints();
		for index = 1, #layout.scroll_anchor do
			Frame.HookedScrollFrame:SetPoint(unpack(layout.scroll_anchor[index]));
		end
		Frame.HookedScrollFrame:SetSize(unpack(layout.scroll_size));
		Frame.HookedDetailFrame:ClearAllPoints();
		for index = 1, #layout.detail_anchor do
			Frame.HookedDetailFrame:SetPoint(unpack(layout.detail_anchor[index]));
		end
		Frame.HookedDetailFrame:SetSize(unpack(layout.detail_size));
		Frame.HookedDetailFrame:UpdateScrollChildRect();
		if expanded then
			Frame.ExpandButton:Hide();
			Frame.ShrinkButton:Show();
			Frame.TextureLineBottom:Hide();
			Frame.HookedRankFrame:SetWidth(360);
			SetUIPanelAttribute(Frame.HookedFrame, 'width', 684);
			_G[T_StyleLayout.C_VariableName_NumSkillListButton] = layout.scroll_button_num;
			Frame.F_HookedFrameUpdate();
		else
			Frame.ExpandButton:Show();
			Frame.ShrinkButton:Hide();
			Frame.TextureLineBottom:Show();
			Frame.HookedRankFrame:SetWidth(240);
			SetUIPanelAttribute(Frame.HookedFrame, 'width', 353);
			_G[T_StyleLayout.C_VariableName_NumSkillListButton] = layout.scroll_button_num;
			for index = layout.scroll_button_num + 1, T_StyleLayout.expand.scroll_button_num do
				Frame.T_SkillListButtons[index]:Hide();
			end
		end
	end
	function LT_FrameMethod.F_SetStyle(Frame, blz_style, loading)
		if blz_style then
			LT_SharedMethod.StyleBLZScrollFrame(Frame.ScrollFrame);
			local FilterDropdown = Frame.FilterDropdown;
			if FilterDropdown ~= nil then
				LT_SharedMethod.StyleBLZALADropButton(FilterDropdown, not loading and FilterDropdown.backup or nil);
			end
			LT_SharedMethod.StyleBLZCheckButton(Frame.HaveMaterialsCheck);
			Frame.HaveMaterialsCheck:SetSize(24, 24);
			LT_SharedMethod.StyleBLZCheckButton(Frame.SearchEditBoxNameOnly);
			Frame.SearchEditBoxNameOnly:SetSize(24, 24);
			local SetFrame = Frame.SetFrame;
			SetFrame:SetWidth(344);
			LT_SharedMethod.StyleBLZBackdrop(SetFrame);
			local T_CheckButtons = SetFrame.T_CheckButtons;
			for index = 1, #T_CheckButtons do
				local CheckButton = T_CheckButtons[index];
				LT_SharedMethod.StyleBLZCheckButton(CheckButton);
				CheckButton:SetSize(24, 24);
			end
			local ProfitFrame = Frame.ProfitFrame;
			LT_SharedMethod.StyleBLZBackdrop(ProfitFrame);
			LT_SharedMethod.StyleBLZScrollFrame(ProfitFrame.ScrollFrame);
			LT_SharedMethod.StyleBLZCheckButton(ProfitFrame.CostOnlyCheck);
			ProfitFrame.CostOnlyCheck:SetSize(24, 24);
			local ProfitFrameCloseButton = ProfitFrame.CloseButton;
			ProfitFrameCloseButton:SetSize(32, 32);
			LT_SharedMethod.StyleBLZButton(ProfitFrameCloseButton, not loading and ProfitFrameCloseButton.backup or nil);

			Frame.HookedFrame:SetHitRectInsets(11, 29, 9, 67);
			local TextureBackground = Frame.TextureBackground;
			TextureBackground:ClearAllPoints();
			TextureBackground:SetPoint("TOPLEFT", 11, -7);
			TextureBackground:SetPoint("BOTTOMRIGHT", -29, 67);
			LT_SharedMethod.StyleBLZBackdrop(TextureBackground);
			local TextureLineTop = Frame.TextureLineTop;
			TextureLineTop:SetTexture([[Interface\Dialogframe\UI-Dialogbox-Divider]], "MIRROR");
			TextureLineTop:SetTexCoord(4 / 256, 188 / 256, 5 / 32, 13 / 32);
			TextureLineTop:SetHeight(2);
			local TextureLineMiddle = Frame.TextureLineMiddle;
			TextureLineMiddle:SetTexture([[Interface\Dialogframe\UI-Dialogbox-Divider]], "MIRROR");
			TextureLineMiddle:SetTexCoord(4 / 256, 188 / 256, 5 / 32, 13 / 32);
			TextureLineMiddle:SetHeight(2);
			local TextureLineBottom = Frame.TextureLineBottom;
			TextureLineBottom:SetTexture([[Interface\Dialogframe\UI-Dialogbox-Divider]], "MIRROR");
			TextureLineBottom:SetTexCoord(4 / 256, 188 / 256, 5 / 32, 13 / 32);
			TextureLineBottom:SetHeight(2);

			LT_SharedMethod.StyleBLZScrollFrame(Frame.HookedScrollFrame);
			LT_SharedMethod.StyleBLZScrollFrame(Frame.HookedDetailFrame);
			local HookedRankFrame = Frame.HookedRankFrame;
			HookedRankFrame.Border:Show();
			VT.__uireimp._SetSimpleBackdrop(HookedRankFrame, 0, 1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
			Frame.PortraitBorder:Show();
			local T_HookedFrameWidgets = Frame.T_HookedFrameWidgets;
			local T_HookedFrameButtons = T_HookedFrameWidgets.T_HookedFrameButtons;
			if T_HookedFrameButtons.IncrementButton then
				T_HookedFrameButtons.IncrementButton:SetSize(23, 22);
			end
			if T_HookedFrameButtons.DecrementButton then
				T_HookedFrameButtons.DecrementButton:SetSize(23, 22);
			end
			T_HookedFrameButtons.CloseButton:SetSize(32, 32);
			T_HookedFrameButtons.RankOffsetButton:SetSize(40, 20);
			local backup = T_HookedFrameWidgets.backup;
			for _, Button in next, T_HookedFrameButtons do
				local name = Button:GetName();
				if name == nil then
					Button.name = _;
					name = _;
				end
				LT_SharedMethod.StyleBLZButton(Button, not loading and backup[name] or nil);
			end
			local T_HookedFrameDropdowns = T_HookedFrameWidgets.T_HookedFrameDropdowns;
			if T_HookedFrameDropdowns ~= nil then
				for _, Dropdown in next, T_HookedFrameDropdowns do
					LT_SharedMethod.StyleBLZDropDownMenu(Dropdown);
				end
			end
			local T_HookedFrameChecks = T_HookedFrameWidgets.T_HookedFrameChecks;
			if T_HookedFrameChecks ~= nil then
				for _, Check in next, T_HookedFrameChecks do
					local name = Check:GetName();
					if name == nil then
						Check.name = _;
						name = _;
					end
					if loading then
						LT_SharedMethod.StyleBLZCheckButton(Check);
					else
						local bak = backup[name];
						if bak == nil then
							LT_SharedMethod.StyleBLZCheckButton(Check);
						else
							local size = bak.size;
							if size ~= nil then
								Check:SetSize(size[1] or 24, size[2] or 24);
							end
							LT_SharedMethod.StyleBLZCheckButton(Check, bak);
						end
					end
				end
			end
			local T_HookedFrameEditboxes = T_HookedFrameWidgets.T_HookedFrameEditboxes;
			if T_HookedFrameEditboxes ~= nil then
				for _, EditBox in next, T_HookedFrameEditboxes do
					LT_SharedMethod.StyleBLZEditBox(EditBox);
				end
			end
			for index = 1, #Frame.T_SkillListButtons do
				LT_SharedMethod.StyleBLZSkillButton(Frame.T_SkillListButtons[index]);
			end
			if T_HookedFrameWidgets.CollapseAllButton ~= nil then
				LT_SharedMethod.StyleBLZSkillButton(T_HookedFrameWidgets.CollapseAllButton);
			end
			Frame.F_HookedFrameUpdate();
		else
			LT_SharedMethod.StyleModernScrollFrame(Frame.ScrollFrame);
			local FilterDropdown = Frame.FilterDropdown;
			if FilterDropdown ~= nil then
				LT_SharedMethod.StyleModernALADropButton(FilterDropdown);
			end
			LT_SharedMethod.StyleModernCheckButton(Frame.HaveMaterialsCheck);
			Frame.HaveMaterialsCheck:SetSize(14, 14);
			LT_SharedMethod.StyleModernCheckButton(Frame.SearchEditBoxNameOnly);
			Frame.SearchEditBoxNameOnly:SetSize(14, 14);
			local SetFrame = Frame.SetFrame;
			SetFrame:SetWidth(332);
			LT_SharedMethod.StyleModernBackdrop(SetFrame);
			local T_CheckButtons = SetFrame.T_CheckButtons;
			for index = 1, #T_CheckButtons do
				local CheckButton = T_CheckButtons[index];
				LT_SharedMethod.StyleModernCheckButton(CheckButton);
				CheckButton:SetSize(14, 14);
			end
			local ProfitFrame = Frame.ProfitFrame;
			LT_SharedMethod.StyleModernBackdrop(ProfitFrame);
			LT_SharedMethod.StyleModernScrollFrame(ProfitFrame.ScrollFrame);
			LT_SharedMethod.StyleModernCheckButton(ProfitFrame.CostOnlyCheck);
			ProfitFrame.CostOnlyCheck:SetSize(14, 14);
			local ProfitFrameCloseButton = ProfitFrame.CloseButton;
			ProfitFrameCloseButton:SetSize(16, 16);
			if ProfitFrameCloseButton.backup == nil then
				ProfitFrameCloseButton.backup = {  };
				LT_SharedMethod.StyleModernButton(ProfitFrameCloseButton, ProfitFrameCloseButton.backup, T_UIDefinition.texture_modern_button_close);
			else
				LT_SharedMethod.StyleModernButton(ProfitFrameCloseButton, nil, T_UIDefinition.texture_modern_button_close);
			end

			Frame.HookedFrame:SetHitRectInsets(17, 35, 11, 73);
			local TextureBackground = Frame.TextureBackground;
			TextureBackground:ClearAllPoints();
			TextureBackground:SetPoint("TOPLEFT", 11, -12);
			TextureBackground:SetPoint("BOTTOMRIGHT", -32, 76);
			LT_SharedMethod.StyleModernBackdrop(TextureBackground);
			local TextureLineTop = Frame.TextureLineTop;
			TextureLineTop:SetColorTexture(unpack(T_UIDefinition.modernDividerColor));
			TextureLineTop:SetHeight(1);
			local TextureLineMiddle = Frame.TextureLineMiddle;
			TextureLineMiddle:SetColorTexture(unpack(T_UIDefinition.modernDividerColor));
			TextureLineMiddle:SetHeight(1);
			local TextureLineBottom = Frame.TextureLineBottom;
			TextureLineBottom:SetColorTexture(unpack(T_UIDefinition.modernDividerColor));
			TextureLineBottom:SetHeight(1);

			LT_SharedMethod.StyleModernScrollFrame(Frame.HookedScrollFrame);
			LT_SharedMethod.StyleModernScrollFrame(Frame.HookedDetailFrame);
			local HookedRankFrame = Frame.HookedRankFrame;
			HookedRankFrame.Border:Hide();
			VT.__uireimp._SetSimpleBackdrop(HookedRankFrame, 0, 1, 0.0, 0.0, 0.0, 0.0, 0.25, 0.25, 0.25, 1.0);
			Frame.PortraitBorder:Hide();
			local T_HookedFrameWidgets = Frame.T_HookedFrameWidgets;
			local T_HookedFrameButtons = T_HookedFrameWidgets.T_HookedFrameButtons;
			if T_HookedFrameButtons.IncrementButton ~= nil then
				T_HookedFrameButtons.IncrementButton:SetSize(14, 14);
			end
			if T_HookedFrameButtons.DecrementButton ~= nil then
				T_HookedFrameButtons.DecrementButton:SetSize(14, 14);
			end
			T_HookedFrameButtons.CloseButton:SetSize(16, 16);
			T_HookedFrameButtons.RankOffsetButton:SetSize(32, 14);
			local backup = T_HookedFrameWidgets.backup;
			local T_ButtonModernTexture = T_HookedFrameWidgets.T_ButtonModernTexture;
			for _, Button in next, T_HookedFrameButtons do
				local name = Button:GetName();
				if name == nil then
					Button.name = _;
					name = _;
				end
				if backup[name] == nil then
					local bak = {  };
					backup[name] = bak;
					LT_SharedMethod.StyleModernButton(Button, bak, T_ButtonModernTexture[_]);
				else
					LT_SharedMethod.StyleModernButton(Button, nil, T_ButtonModernTexture[_]);
				end
			end
			local T_HookedFrameDropdowns = T_HookedFrameWidgets.T_HookedFrameDropdowns;
			if T_HookedFrameDropdowns ~= nil then
				for _, Dropdown in next, T_HookedFrameDropdowns do
					LT_SharedMethod.StyleModernDropDownMenu(Dropdown);
				end
			end
			local T_HookedFrameChecks = T_HookedFrameWidgets.T_HookedFrameChecks;
			if T_HookedFrameChecks ~= nil then
				for _, Check in next, T_HookedFrameChecks do
					local name = Check:GetName();
					if name == nil then
						Check.name = _;
						name = _;
					end
					if backup[name] == nil then
						local bak = {  };
						backup[name] = bak;
						bak.size = bak.size or { Check:GetSize() };
						Check:SetSize(16, 16);
						LT_SharedMethod.StyleModernCheckButton(Check, bak);
					else
						LT_SharedMethod.StyleModernCheckButton(Check);
					end
					LT_SharedMethod.StyleModernCheckButton(Check);
				end
			end
			local T_HookedFrameEditboxes = T_HookedFrameWidgets.T_HookedFrameEditboxes;
			if T_HookedFrameEditboxes ~= nil then
				for _, EditBox in next, T_HookedFrameEditboxes do
					LT_SharedMethod.StyleModernEditBox(EditBox);
				end
			end
			for index = 1, #Frame.T_SkillListButtons do
				LT_SharedMethod.StyleModernSkillButton(Frame.T_SkillListButtons[index]);
			end
			if T_HookedFrameWidgets.CollapseAllButton ~= nil then
				LT_SharedMethod.StyleModernSkillButton(T_HookedFrameWidgets.CollapseAllButton);
			end
			Frame.F_HookedFrameUpdate();
		end
	end
	function LT_FrameMethod.F_ExplorerSetStyle(Frame, blz_style, loading)
		if blz_style then
			LT_SharedMethod.StyleBLZBackdrop(Frame);
			local CloseButton = Frame.CloseButton;
			CloseButton:SetSize(32, 32);
			LT_SharedMethod.StyleBLZButton(CloseButton, not loading and CloseButton.backup or nil);
			LT_SharedMethod.StyleBLZCheckButton(Frame.SearchEditBoxNameOnly);
			Frame.SearchEditBoxNameOnly:SetSize(24, 24);
			LT_SharedMethod.StyleBLZScrollFrame(Frame.ScrollFrame);
			local SetFrame = Frame.SetFrame;
			LT_SharedMethod.StyleBLZBackdrop(SetFrame);
			local T_CheckButtons = SetFrame.T_CheckButtons;
			for index = 1, #T_CheckButtons do
				local CheckButton = T_CheckButtons[index];
				LT_SharedMethod.StyleBLZCheckButton(CheckButton);
				CheckButton:SetSize(24, 24);
			end
			local T_Dropdowns = SetFrame.T_Dropdowns;
			for index = 1, #T_Dropdowns do
				local Dropdown = T_Dropdowns[index];
				LT_SharedMethod.StyleBLZALADropButton(Dropdown);
				Dropdown:SetSize(20, 20);
			end
			local ProfitFrame = Frame.ProfitFrame;
			LT_SharedMethod.StyleBLZBackdrop(ProfitFrame);
			LT_SharedMethod.StyleBLZScrollFrame(ProfitFrame.ScrollFrame);
			local ProfitFrameCloseButton = ProfitFrame.CloseButton;
			ProfitFrameCloseButton:SetSize(32, 32);
			LT_SharedMethod.StyleBLZButton(ProfitFrameCloseButton, not loading and ProfitFrameCloseButton.backup or nil);
		else
			LT_SharedMethod.StyleModernBackdrop(Frame);
			local CloseButton = Frame.CloseButton;
			CloseButton:SetSize(16, 16);
			if CloseButton.backup == nil then
				CloseButton.backup = {  };
				LT_SharedMethod.StyleModernButton(CloseButton, CloseButton.backup, T_UIDefinition.texture_modern_button_close);
			else
				LT_SharedMethod.StyleModernButton(CloseButton, nil, T_UIDefinition.texture_modern_button_close);
			end
			LT_SharedMethod.StyleModernCheckButton(Frame.SearchEditBoxNameOnly);
			Frame.SearchEditBoxNameOnly:SetSize(14, 14);
			LT_SharedMethod.StyleModernScrollFrame(Frame.ScrollFrame);
			local SetFrame = Frame.SetFrame;
			LT_SharedMethod.StyleModernBackdrop(SetFrame);
			local T_CheckButtons = SetFrame.T_CheckButtons;
			for index = 1, #T_CheckButtons do
				local CheckButton = T_CheckButtons[index];
				LT_SharedMethod.StyleModernCheckButton(CheckButton);
				CheckButton:SetSize(14, 14);
			end
			local T_Dropdowns = SetFrame.T_Dropdowns;
			for index = 1, #T_Dropdowns do
				local Dropdown = T_Dropdowns[index];
				LT_SharedMethod.StyleModernALADropButton(Dropdown);
				Dropdown:SetSize(14, 14);
			end
			local ProfitFrame = Frame.ProfitFrame;
			LT_SharedMethod.StyleModernBackdrop(ProfitFrame);
			LT_SharedMethod.StyleModernScrollFrame(ProfitFrame.ScrollFrame);
			local ProfitFrameCloseButton = ProfitFrame.CloseButton;
			ProfitFrameCloseButton:SetSize(16, 16);
			if ProfitFrameCloseButton.backup == nil then
				ProfitFrameCloseButton.backup = {  };
				LT_SharedMethod.StyleModernButton(ProfitFrameCloseButton, ProfitFrameCloseButton.backup, T_UIDefinition.texture_modern_button_close);
			else
				LT_SharedMethod.StyleModernButton(ProfitFrameCloseButton, nil, T_UIDefinition.texture_modern_button_close);
			end
		end
	end
	function LT_FrameMethod.F_FixSkillList(Frame, expanded)
		local layout = Frame.T_StyleLayout[expanded and 'expand' or 'normal'];
		local pref = Frame.T_HookedFrameWidgets.C_SkillListButtonNamePrefix;
		local index = layout.scroll_button_num + 1;
		while true do
			local Skill = _G[pref .. index];
			if Skill == nil then
				return;
			end
			Skill:Hide();
			Frame.T_SkillListButtons[index] = Frame.T_SkillListButtons[index] or Skill;
			index = index + 1;
		end
	end
	function LT_FrameMethod.F_LayoutOnShow(Frame)
		local HookedFrame = Frame.HookedFrame;
		local T_HookedFrameWidgets = Frame.T_HookedFrameWidgets;
		local T_HookedFrameButtons = T_HookedFrameWidgets.T_HookedFrameButtons;
		T_HookedFrameButtons.CancelButton:SetSize(72, 18);
		T_HookedFrameButtons.CancelButton:ClearAllPoints();
		T_HookedFrameButtons.CancelButton:SetPoint("TOPRIGHT", -42, -415);
		T_HookedFrameButtons.CreateButton:SetSize(72, 18);
		T_HookedFrameButtons.CreateButton:ClearAllPoints();
		T_HookedFrameButtons.CreateButton:SetPoint("RIGHT", T_HookedFrameButtons.CancelButton, "LEFT", -7, 0);
		T_HookedFrameButtons.CloseButton:ClearAllPoints();
		T_HookedFrameButtons.CloseButton:SetPoint("CENTER", HookedFrame, "TOPRIGHT", -51, -24);
	end
	function LT_FrameMethod.F_ToggleOnSkill(Frame, val)
		val = not val;
		local T_ToggleOnSkill = Frame.T_ToggleOnSkill;
		for index = 1, #T_ToggleOnSkill do
			T_ToggleOnSkill[index]:SetShown(val);
		end
	end
	function LT_FrameMethod.F_RefreshRankOffset(Frame)
		local pid = Frame.flag or DataAgent.get_pid_by_pname(Frame.F_GetSkillName());
		if pid ~= nil then
			local set = VT.SET[pid];
			local var = Frame.notlinked and VT.VAR[pid] or LT_LinkedSkillVar;
			Frame.RankOffsetSlider:SetMinMaxValues(1, var.max_rank ~= nil and var.max_rank > 1 and var.max_rank or 75);
			if set.rankoffset ~= nil and set.rankoffset > 0 then
				Frame.RankOffsetButton:SetText("+" .. set.rankoffset);
				Frame.RankOffsetSlider:SetValue(var.cur_rank + set.rankoffset);
			else
				Frame.RankOffsetButton:SetText("+0");
				Frame.RankOffsetSlider:SetValue(var.cur_rank);
			end
		end
	end
	function LT_FrameMethod.F_ShowSetFrame(Frame, show)
		local SetFrame = Frame.SetFrame;
		if VT.SET.show_tab then
			SetFrame:ClearAllPoints();
			SetFrame:SetPoint("LEFT", Frame.TextureBackground);
			-- SetFrame:SetPoint("RIGHT", Frame);
			SetFrame:SetPoint("BOTTOM", Frame.TabFrame, "TOP", 0, -4);
		else
			SetFrame:ClearAllPoints();
			SetFrame:SetPoint("LEFT", Frame.TextureBackground);
			-- SetFrame:SetPoint("RIGHT", Frame);
			SetFrame:SetPoint("BOTTOM", Frame.TextureBackground, "TOP", 0, 1);
		end
		if show ~= false then
			SetFrame:Show();
			LT_WidgetMethod.SetFrame_OnShow(SetFrame);
		end
	end
	function LT_FrameMethod.F_HideSetFrame(Frame)
		local SetFrame = Frame.SetFrame;
		SetFrame:Hide();
		LT_WidgetMethod.SetFrame_OnHide(SetFrame);
	end
	function LT_FrameMethod.F_ShowProfitFrame(Frame, show)
		local ProfitFrame = Frame.ProfitFrame;
		if show ~= false then
			ProfitFrame:Show();
			LT_WidgetMethod.ProfitFrame_OnShow(ProfitFrame);
		end
	end
	function LT_FrameMethod.F_HideProfitFrame(Frame)
		local ProfitFrame = Frame.ProfitFrame;
		ProfitFrame:Hide();
		LT_WidgetMethod.ProfitFrame_OnHide(ProfitFrame);
	end
	function LT_FrameMethod.F_ExplorerShowSetFrame(Frame, show)
		local SetFrame = Frame.SetFrame;
		if show ~= false then
			SetFrame:Show();
			LT_WidgetMethod.SetFrame_OnShow(SetFrame);
		end
	end
	function LT_FrameMethod.F_ExplorerHideSetFrame(Frame)
		local SetFrame = Frame.SetFrame;
		SetFrame:Hide();
		LT_WidgetMethod.SetFrame_OnHide(SetFrame);
	end
	function LT_FrameMethod.F_ExplorerShowProfitFrame(Frame, show)
		local ProfitFrame = Frame.ProfitFrame;
		if show ~= false then
			ProfitFrame:Show();
			LT_WidgetMethod.ProfitFrame_OnShow(ProfitFrame);
		end
	end
	function LT_FrameMethod.F_ExplorerHideProfitFrame(Frame)
		local ProfitFrame = Frame.ProfitFrame;
		ProfitFrame:Hide();
		LT_WidgetMethod.ProfitFrame_OnHide(ProfitFrame);
	end
	function LT_FrameMethod.F_RefreshSetFrame(Frame)
		local pid = Frame.flag or DataAgent.get_pid_by_pname(Frame.F_GetSkillName());
		if pid ~= nil then
			local SetFrame = Frame.SetFrame;
			local set = VT.SET[pid];
			for index = 1, #SetFrame.T_CheckButtons do
				local CheckButton = SetFrame.T_CheckButtons[index];
				CheckButton:SetChecked(set[CheckButton.key]);
			end
			SetFrame.PhaseSlider:SetValue(set.phase);
		end
	end
	function LT_FrameMethod.F_ExplorerRefreshSetFrame(Frame)
		local SetFrame = Frame.SetFrame;
		local set = VT.SET.explorer;
		for index = 1, #SetFrame.T_CheckButtons do
			local CheckButton = SetFrame.T_CheckButtons[index];
			CheckButton:SetChecked(set[CheckButton.key]);
		end
		local filter = set.filter;
		if filter.Skill == nil then
			SetFrame.T_Dropdowns[1].Text:SetText("-");
			SetFrame.T_Dropdowns[1].Cancel:Hide();
		else
			SetFrame.T_Dropdowns[1].Text:SetText(DataAgent.get_pname_by_pid(filter.Skill));
			SetFrame.T_Dropdowns[1].Cancel:Show();
		end
		if filter.Type == nil then
			SetFrame.T_Dropdowns[2].Text:SetText("-");
			SetFrame.T_Dropdowns[3].Text:SetText("-");
			SetFrame.T_Dropdowns[2].Cancel:Hide();
			SetFrame.T_Dropdowns[3].Cancel:Hide();
		else
			SetFrame.T_Dropdowns[2].Text:SetText(l10n.ITEM_TYPE_LIST[filter.Type]);
			SetFrame.T_Dropdowns[2].Cancel:Show();
			if filter.SubType == nil then
				SetFrame.T_Dropdowns[3].Text:SetText("-");
				SetFrame.T_Dropdowns[3].Cancel:Hide();
			else
				SetFrame.T_Dropdowns[3].Text:SetText(l10n.ITEM_SUB_TYPE_LIST[filter.Type][filter.SubType]);
				SetFrame.T_Dropdowns[3].Cancel:Show();
			end
		end
		if filter.EquipLoc == nil then
			SetFrame.T_Dropdowns[4].Text:SetText("-");
			SetFrame.T_Dropdowns[4].Cancel:Hide();
		else
			SetFrame.T_Dropdowns[4].Text:SetText(l10n.ITEM_EQUIP_LOC[filter.EquipLoc]);
			SetFrame.T_Dropdowns[4].Cancel:Show();
		end
		SetFrame.PhaseSlider:SetValue(set.phase);
	end
	function LT_FrameMethod._OnShow(Frame)
		Frame:F_WithDisabledFrame(LT_SharedMethod.WidgetHidePermanently);
		-- Frame.HookedScrollFrame:Hide();
		Frame.F_ClearFilter();
		for name, func in next, Frame.T_DisabledFunc do
			_G[name] = MT.noop;
		end
	end
	function LT_FrameMethod._OnHide(Frame)
		Frame:F_WithDisabledFrame(LT_SharedMethod.WidgetUnhidePermanently);
		-- Frame.HookedScrollFrame:Show();
		for name, func in next, Frame.T_DisabledFunc do
			_G[name] = func;
		end
		Frame.F_HookedFrameUpdate()
	end
	function LT_FrameMethod._OnEvent(Frame, event, _1, ...)
		Frame.update = true;
		MT._TimerStart(Frame.F_Update, 0.2, 1);
	end
	function LT_WidgetMethod.BLZSkillListButton_OnEnter(self)
		if VT.SET.default_skill_button_tip then
			local Frame = self.Frame;
			local index = self:GetID();
			local link = Frame.F_GetRecipeItemLink(index) or (Frame.F_GetRecipeSpellLink ~= nil and Frame.F_GetRecipeSpellLink(index)) or nil;
			if link ~= nil then
				SkillTip.__phase = DataAgent.CURPHASE;
				SkillTip:SetOwner(self, "ANCHOR_RIGHT");
				SkillTip:SetHyperlink(link);
				SkillTip:Show();
			else
				SkillTip:Hide();
			end
		end
	end
	function LT_WidgetMethod.ToggleFrame(self)
		local Frame = self.Frame;
		local pid = Frame.flag or DataAgent.get_pid_by_pname(Frame.F_GetSkillName());
		if Frame:IsShown() then
			Frame:Hide();
			Frame.ToggleButton:SetText(l10n["OVERRIDE_OPEN"]);
			if pid ~= nil then
				VT.SET[pid].shown = false;
			end
		else
			Frame:Show();
			Frame.ToggleButton:SetText(l10n["OVERRIDE_CLOSE"]);
			if pid ~= nil then
				VT.SET[pid].shown = true;
			end
			Frame.update = true;
			Frame.F_Update();
		end
	end
	function LT_WidgetMethod.ExpandButton_OnClick(self)
		self.Frame:F_Expand(true);
	end
	function LT_WidgetMethod.ShrinkButton_OnClick(self)
		self.Frame:F_Expand(false);
	end
	function LT_WidgetMethod.RankOffsetSlider__OnValueChanged(self, value, userInput)
		if userInput then
			local Frame = self.Frame;
			local pid = Frame.flag or DataAgent.get_pid_by_pname(Frame.F_GetSkillName());
			if pid ~= nil then
				local set = VT.SET[pid];
				local var = Frame.notlinked and VT.VAR[pid] or LT_LinkedSkillVar;
				value = value + 0.5; value = value - value % 1.0;
				value = value - var.cur_rank;
				value = value + 0.1; value = value - value % 5.0 + 5;
				set.rankoffset = value;
				Frame.update = true;
				MT._TimerStart(Frame.F_Update, 0.2, 1);
			end
		end
	end
	function LT_WidgetMethod.ReagentButton__OnClick(self)
		if IsShiftKeyDown() then
			local Frame = self.Frame;
			local editBox = ChatEdit_ChooseBoxForSend();
			if not editBox:HasFocus() then
				local name = Frame.F_GetRecipeReagentInfo(Frame.F_GetSelection(), self:GetID());
				if name ~= nil and name ~= "" then
					ALA_INSERT_NAME(name);
				end
			end
		elseif IsControlKeyDown() then
		elseif IsAltKeyDown() then
		else
			local Frame = self.Frame;
			local pid = Frame.flag or DataAgent.get_pid_by_pname(Frame.F_GetSkillName());
			local cid = Frame.F_GetRecipeReagentID(Frame.F_GetSelection(), self:GetID());
			if cid ~= nil then
				local nsids, sids = DataAgent.get_sid_by_pid_cid(pid, cid);
				if nsids > 0 then
					LT_SharedMethod.SelectRecipe(Frame, sids[1]);
				end
			end
		end
	end
	function LT_WidgetMethod.ProductionIcon__OnClick(self)
		if IsShiftKeyDown() then
			local editBox = ChatEdit_ChooseBoxForSend();
			if not editBox:HasFocus() then
				local Frame = self.Frame;
				local name = Frame.F_GetRecipeInfo(Frame.F_GetSelection());
				if name ~= nil and name ~= "" then
					ALA_INSERT_NAME(name);
				end
			end
		end
	end
	function LT_WidgetMethod.PortraitButton_Update(self)
		local Frame = self.Frame;
		local T_PortraitDropMeta = self.T_PortraitDropMeta;
		T_PortraitDropMeta.num = 0;
		local pname = Frame.F_GetSkillName();
		for pid = DataAgent.DBMINPID, DataAgent.DBMAXPID do
			if rawget(VT.VAR, pid) ~= nil and DataAgent.is_pid_has_win(pid) then
				local name = DataAgent.get_check_name_by_pid(pid);
				if name ~= nil and name ~= pname then
					T_PortraitDropMeta.num = T_PortraitDropMeta.num + 1;
					T_PortraitDropMeta[T_PortraitDropMeta.num] = {
						text = name,
						param = { Frame, name, },
					};
				end
			end
		end
		T_PortraitDropMeta.num = T_PortraitDropMeta.num + 1;
		T_PortraitDropMeta[T_PortraitDropMeta.num] = {
			text = "explorer",
			param = { Frame, '@explorer', },
		};
		T_PortraitDropMeta.num = T_PortraitDropMeta.num + 1;
		T_PortraitDropMeta[T_PortraitDropMeta.num] = {
			text = "config",
			param = { Frame, '@config', },
		};
	end
	function LT_WidgetMethod.PortraitButton_OnClick(self)
		VT.__menulib.ShowMenu(self, "BOTTOM", self.T_PortraitDropMeta);
	end
	function LT_WidgetMethod.TabFrame_CreateTab(TabFrame, index)
		local Frame = TabFrame.Frame;
		local Tab = CreateFrame('BUTTON', nil, TabFrame);
		Tab:SetSize(T_UIDefinition.tabSize, T_UIDefinition.tabSize);
		Tab:SetNormalTexture(T_UIDefinition.texture_unk);
		-- Tab:GetNormalTexture():SetTexCoord(0.0625, 1.0, 0.0625, 1.0);
		Tab:SetPushedTexture(T_UIDefinition.texture_unk);
		-- Tab:GetPushedTexture():SetTexCoord(0.0, 0.9375, 0.0, 0.9375);
		Tab:GetPushedTexture():SetVertexColor(unpack(T_UIDefinition.textureButtonColorPushed));
		Tab:SetHighlightTexture(T_UIDefinition.texture_highlight);
		-- Tab:GetHighlightTexture():SetTexCoord(0.25, 0.75, 0.25, 0.75);
		-- Tab:GetHighlightTexture():SetBlendMode("BLEND");
		Tab:GetHighlightTexture():SetVertexColor(unpack(T_UIDefinition.textureButtonColorHighlight));
		Tab:EnableMouse(true);
		Tab:SetScript("OnClick", function(self)
			local pname = self.pname;
			if pname ~= nil and not DataAgent.is_name_same_skill(pname, Frame.F_GetSkillName()) then
				if pname == '@explorer' then
					MT.ToggleFrame("EXPLORER");
				elseif pname == '@config' then
					MT.ToggleFrame("CONFIG");
				elseif pname == '@toggle' then
					LT_WidgetMethod.ToggleFrame(self);
				else
					CastSpellByName(pname);
				end
			end
		end);
		TabFrame.T_Tabs[index] = Tab;
		Tab.Frame = Frame;
		if index == 1 then
			Tab:SetPoint("LEFT", TabFrame, "LEFT", T_UIDefinition.tabInterval, 0);
		else
			Tab:SetPoint("LEFT", TabFrame.T_Tabs[index - 1], "RIGHT", T_UIDefinition.tabInterval, 0);
		end
		--
		local L = Tab:CreateTexture(nil, "OVERLAY");
		L:SetSize(2, T_UIDefinition.tabSize - 2);
		L:SetPoint("BOTTOMLEFT", Tab, "BOTTOMLEFT", 0, 0);
		L:SetColorTexture(0.0, 0.0, 0.0, 1.0);
		local T = Tab:CreateTexture(nil, "OVERLAY");
		T:SetSize(T_UIDefinition.tabSize - 2, 2);
		T:SetPoint("TOPLEFT", Tab, "TOPLEFT", 0, 0);
		T:SetColorTexture(0.0, 0.0, 0.0, 1.0);
		local R = Tab:CreateTexture(nil, "OVERLAY");
		R:SetSize(2, T_UIDefinition.tabSize - 2);
		R:SetPoint("TOPRIGHT", Tab, "TOPRIGHT", 0, 0);
		R:SetColorTexture(0.0, 0.0, 0.0, 1.0);
		local B = Tab:CreateTexture(nil, "OVERLAY");
		B:SetSize(T_UIDefinition.tabSize - 2, 2);
		B:SetPoint("BOTTOMRIGHT", Tab, "BOTTOMRIGHT", 0, 0);
		B:SetColorTexture(0.0, 0.0, 0.0, 1.0);
		--
		return Tab;
	end
	function LT_WidgetMethod.TabFrame_SetNumTabs(TabFrame, num)
		local T_Tabs = TabFrame.T_Tabs;
		local cap = #T_Tabs;
		if cap > num then
			for index = num + 1, cap do
				T_Tabs[index]:Hide();
			end
		else
			for index = 1, cap do
				T_Tabs[index]:Show();
			end
			for index = cap + 1, num do
				self:F_CreateTab(index):Show();
			end
		end
		TabFrame:SetWidth(T_UIDefinition.tabSize * num + T_UIDefinition.tabInterval * (num + 1));
	end
	function LT_WidgetMethod.TabFrame_SetTab(TabFrame, index, pname, ptexture)
		local Tab = TabFrame.T_Tabs[index] or TabFrame:F_CreateTab(index);
		Tab:Show();
		Tab.pname = pname;
		Tab:SetNormalTexture(ptexture);
		Tab:SetHighlightTexture(ptexture);
		Tab:SetPushedTexture(ptexture);
	end
	function LT_WidgetMethod.TabFrame_Update(TabFrame)
		local numSkill = 0;
		for pid = DataAgent.DBMINPID, DataAgent.DBMAXPID do
			if rawget(VT.VAR, pid) ~= nil and DataAgent.is_pid_has_win(pid) then
				local pname = DataAgent.get_check_name_by_pid(pid);
				if pname ~= nil then
					numSkill = numSkill + 1;
					TabFrame:F_SetTab(numSkill, pname, DataAgent.get_texture_by_pid(pid));
				end
			end
		end
		numSkill = numSkill + 1;
		TabFrame:F_SetTab(numSkill, '@explorer', T_UIDefinition.texture_explorer);
		numSkill = numSkill + 1;
		TabFrame:F_SetTab(numSkill, '@config', T_UIDefinition.texture_config);
		numSkill = numSkill + 1;
		TabFrame:F_SetTab(numSkill, '@toggle', T_UIDefinition.texture_toggle);
		TabFrame:F_SetNumTabs(numSkill);
	end
	function LT_WidgetMethod.ProfitFrame_OnShow(self)
		if VT.AuctionMod ~= nil then
			LT_SharedMethod.UpdateProfitFrame(self.Frame);
			self.ToggleButton:GetNormalTexture():SetVertexColor(1.0, 1.0, 1.0, 1.0);
		else
			self:Hide();
		end
	end
	function LT_WidgetMethod.ProfitFrame_OnHide(self)
		self.ToggleButton:GetNormalTexture():SetVertexColor(0.5, 0.5, 0.5, 1.0);
	end
	function LT_WidgetMethod.ProfitFrameToggleButton_OnClick(self)
		if VT.AuctionMod ~= nil then
			local Frame = self.Frame;
			local ProfitFrame = self.ProfitFrame;
			local pid = Frame.flag or DataAgent.get_pid_by_pname(Frame.F_GetSkillName());
			if ProfitFrame:IsShown() then
				Frame:F_HideProfitFrame();
				if pid ~= nil then
					VT.SET[pid].showProfit = false;
				end
			else
				Frame:F_ShowProfitFrame();
				if pid ~= nil then
					VT.SET[pid].showProfit = true;
				end
			end
		end
	end
	function LT_WidgetMethod.ProfitFrameCostOnlyCheck_OnClick(self)
		local Frame = self.Frame;
		local checked = self:GetChecked();
		local pid = Frame.flag or DataAgent.get_pid_by_pname(Frame.F_GetSkillName());
		if pid ~= nil then
			VT.SET[pid].PROFIT_SHOW_COST_ONLY = checked;
			LT_SharedMethod.UpdateProfitFrame(Frame);
		end
	end
	function LT_WidgetMethod.ProfitFrameCloseButton_OnClick(self)
		local Frame = self.Frame;
		local pid = Frame.flag or DataAgent.get_pid_by_pname(Frame.F_GetSkillName());
		if pid ~= nil then
			VT.SET[pid].showProfit = false;
		end
		Frame:F_HideProfitFrame();
	end
	function LT_WidgetMethod.SetFrame_OnShow(self)
		self.ToggleButton:GetNormalTexture():SetVertexColor(1.0, 1.0, 1.0, 1.0);
	end
	function LT_WidgetMethod.SetFrame_OnHide(self)
		self.ToggleButton:GetNormalTexture():SetVertexColor(0.5, 0.5, 0.5, 1.0);
	end
	function LT_WidgetMethod.SetFrameToggleButton_OnClick(self)
		local Frame = self.Frame;
		local pid = Frame.flag or DataAgent.get_pid_by_pname(Frame.F_GetSkillName());
		if self.SetFrame:IsShown() then
			Frame:F_HideSetFrame();
			if pid ~= nil then
				VT.SET[pid].showSet = false;
			end
		else
			Frame:F_ShowSetFrame(true);
			if pid ~= nil then
				VT.SET[pid].showSet = true;
			end
		end
	end
	function LT_WidgetMethod.SetFrameCheckButton_OnClick_WithUpdate(self)
		local Frame = self.Frame;
		local pid = Frame.flag or DataAgent.get_pid_by_pname(Frame.F_GetSkillName());
		if pid ~= nil then
			MT.ChangeSetWithUpdate(VT.SET[pid], self.key, self:GetChecked());
		end
		Frame.F_Update();
	end
	function LT_WidgetMethod.SetFrameCheckButton_OnClick(self)
		local Frame = self.Frame;
		local pid = Frame.flag or DataAgent.get_pid_by_pname(Frame.F_GetSkillName());
		if pid ~= nil then
			MT.ChangeSetWithUpdate(VT.SET[pid], self.key, self:GetChecked());
		end
		Frame.ScrollFrame:Update();
	end
	function LT_WidgetMethod.SetFrameCheckButton_OnEnter(self)
		self.TipInfo:SetText(self.TipText);
	end
	function LT_WidgetMethod.SetFrameCheckButton_OnLeave(self)
		self.TipInfo:SetText("");
	end
	--
		--	l10n.ITEM_TYPE_LIST
		--	l10n.ITEM_SUB_TYPE_LIST
		local index_bound = { Skill = { DataAgent.DBMINPID, DataAgent.DBMAXPID, }, Type = { CT.BIGNUMBER, -1, }, SubType = {  }, EquipLoc = { CT.BIGNUMBER, -1, }, };
		for index, _ in next, l10n.ITEM_TYPE_LIST do
			if index < index_bound.Type[1] then
				index_bound.Type[1] = index;
			end
			if index > index_bound.Type[2] then
				index_bound.Type[2] = index;
			end
		end
		for index1, sub in next, l10n.ITEM_SUB_TYPE_LIST do
			if index1 < index_bound.Type[1] then
				index_bound.Type[1] = index1;
			end
			if index1 > index_bound.Type[2] then
				index_bound.Type[2] = index1;
			end
			index_bound.SubType[index1] = { CT.BIGNUMBER, -CT.BIGNUMBER, };
			for index2, _ in next, sub do
				if index2 < index_bound.SubType[index1][1] then
					index_bound.SubType[index1][1] = index2;
				end
				if index2 > index_bound.SubType[index1][2] then
					index_bound.SubType[index1][2] = index2;
				end
			end
		end
		for index, _ in next, l10n.ITEM_EQUIP_LOC do
			if index < index_bound.EquipLoc[1] then
				index_bound.EquipLoc[1] = index;
			end
			if index > index_bound.EquipLoc[2] then
				index_bound.EquipLoc[2] = index;
			end
		end
		----
		local T_ExplorerSetMeta = {
			handler = function(_, _, param)
				VT.SET.explorer.filter[param[2]] = param[3];
				if param[2] == 'Type' then
					VT.SET.explorer.filter.SubType = nil;
				end
				param[1].F_Update();
			end,
			num = 0,
		};
	--
	function LT_WidgetMethod.ExplorerSetFrameDropdown_OnClick(self)
		local key = self.key;
		local set = VT.SET.explorer;
		local filter = set.filter;
		local bound = nil;
		if key == 'SubType' then
			local key0 = filter.Type;
			if key0 == nil then
				return;
			end
			bound = index_bound[key][key0];
		else
			bound = index_bound[key];
		end
		local Frame = self.Frame;
		local stat_list = nil;
		if filter[key] then
			local temp_filter = {  };
			for key, val in next, filter do
				temp_filter[key] = val;
			end
			temp_filter[key] = nil;
			if key == 'Type' then
				temp_filter.SubType = nil;
			end
			stat_list = { Skill = {  }, Type = {  }, SubType = {  }, EquipLoc = {  }, };
			LT_SharedMethod.ExplorerFilterList(Frame, stat_list, temp_filter, set.searchText, set.searchNameOnly,
										{  }, Frame.hash, set.phase, nil, set.rankReversed, set.showKnown, set.showUnkown, set.showHighRank, false, false);
		else
			stat_list = LT_ExplorerStat;
		end
		T_ExplorerSetMeta[1] = { text = l10n["EXPLORER_CLEAR_FILTER"], param = { Frame, key, nil, }, };
		T_ExplorerSetMeta.num = 1;
		local stat = stat_list[key];
		if key == 'Skill' then
			for index = bound[1], bound[2] do
				if stat[index] then
					T_ExplorerSetMeta.num = T_ExplorerSetMeta.num + 1;
					T_ExplorerSetMeta[T_ExplorerSetMeta.num] = {
						text = DataAgent.get_pname_by_pid(index),
						param = { Frame, key, index, },
					};
				end
			end
		elseif key == 'Type' then
			for index = bound[1], bound[2] do
				if stat[index] then
					T_ExplorerSetMeta.num = T_ExplorerSetMeta.num + 1;
					T_ExplorerSetMeta[T_ExplorerSetMeta.num] = {
						text = l10n.ITEM_TYPE_LIST[index],
						param = { Frame, key, index, },
					};
				end
			end
		elseif key == 'SubType' then
			local key0 = filter.Type;
			for index = bound[1], bound[2] do
				if stat[index] then
					T_ExplorerSetMeta.num = T_ExplorerSetMeta.num + 1;
					T_ExplorerSetMeta[T_ExplorerSetMeta.num] = {
						text = l10n.ITEM_SUB_TYPE_LIST[key0][index],
						param = { Frame, key, index, },
					};
				end
			end
		elseif key == 'EquipLoc' then
			for index = bound[1], bound[2] do
				if stat[index] then
					T_ExplorerSetMeta.num = T_ExplorerSetMeta.num + 1;
					T_ExplorerSetMeta[T_ExplorerSetMeta.num] = {
						text = l10n.ITEM_EQUIP_LOC[index],
						param = { Frame, key, index, },
					};
				end
			end
		end
		VT.__menulib.ShowMenu(self, "BOTTOMRIGHT", T_ExplorerSetMeta);
	end
	function LT_WidgetMethod.SetFramePhaseSlider__OnValueChanged(self, value, userInput)
		if userInput then
			local Frame = self.Frame;
			local pid = Frame.flag or DataAgent.get_pid_by_pname(Frame.F_GetSkillName());
			if pid ~= nil then
				MT.ChangeSetWithUpdate(VT.SET[pid], "phase", value);
				Frame.F_Update();
			end
		end
		self.Text:SetText("|cffffff00" .. l10n["phase"] .. "|r " .. value);
	end
	function LT_WidgetMethod.HaveMaterialsCheck_OnClick(self)
		local Frame = self.Frame;
		local pid = Frame.flag or DataAgent.get_pid_by_pname(Frame.F_GetSkillName());
		if pid ~= nil then
			MT.ChangeSetWithUpdate(VT.SET[pid], "haveMaterials", self:GetChecked());
		end
		Frame.F_Update();
	end
--
--	SkillFrame
	local function LF_CreateSkillListButton(parent, index, buttonHeight)
		local Button = CreateFrame('BUTTON', nil, parent);
		Button:SetHeight(buttonHeight);
		VT.__uireimp._SetSimpleBackdrop(Button, 0, 1, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0);
		Button:SetHighlightTexture(T_UIDefinition.texture_white);
		Button:GetHighlightTexture():SetVertexColor(unpack(T_UIDefinition.listButtonHighlightColor));
		Button:EnableMouse(true);
		Button:Show();

		local Icon = Button:CreateTexture(nil, "BORDER");
		Icon:SetTexture(T_UIDefinition.texture_unk);
		Icon:SetSize(buttonHeight - 4, buttonHeight - 4);
		Icon:SetPoint("LEFT", 8, 0);
		Button.Icon = Icon;

		local Title = Button:CreateFontString(nil, "OVERLAY");
		Title:SetFont(T_UIDefinition.frameNormalFont, T_UIDefinition.frameNormalFontSize, T_UIDefinition.frameNormalFontFlag);
		Title:SetPoint("LEFT", Icon, "RIGHT", 2, 0);
		-- Title:SetWidth(160);
		Title:SetMaxLines(1);
		Title:SetJustifyH("LEFT");
		Button.Title = Title;

		local Num = Button:CreateFontString(nil, "OVERLAY");
		Num:SetFont(T_UIDefinition.frameNormalFont, T_UIDefinition.frameNormalFontSize, T_UIDefinition.frameNormalFontFlag);
		Num:SetPoint("LEFT", Title, "RIGHT", 2, 0);
		-- Num:SetWidth(160);
		Num:SetMaxLines(1);
		Num:SetJustifyH("LEFT");
		Button.Num = Num;

		local Note = Button:CreateFontString(nil, "ARTWORK");
		Note:SetFont(T_UIDefinition.frameNormalFont, T_UIDefinition.frameNormalFontSize - 1, T_UIDefinition.frameNormalFontFlag);
		Note:SetPoint("RIGHT", -4, 0);
		Button.Note = Note;

		local QualityGlow = Button:CreateTexture(nil, "ARTWORK");
		QualityGlow:SetTexture([[Interface\Buttons\UI-ActionButton-Border]]);
		QualityGlow:SetBlendMode("ADD");
		QualityGlow:SetTexCoord(0.25, 0.75, 0.25, 0.75);
		QualityGlow:SetSize(buttonHeight - 2, buttonHeight - 2);
		QualityGlow:SetPoint("CENTER", Icon);
		-- QualityGlow:SetAlpha(0.75);
		QualityGlow:Show();
		Button.QualityGlow = QualityGlow;

		local Star = Button:CreateTexture(nil, "OVERLAY");
		Star:SetTexture([[Interface\Collections\Collections]]);
		Star:SetTexCoord(100 / 512, 118 / 512, 10 / 512, 28 / 512);
		Star:SetSize(buttonHeight * 0.75, buttonHeight * 0.75);
		Star:SetPoint("CENTER", Button, "TOPLEFT", buttonHeight * 0.25, -buttonHeight * 0.25);
		Star:Hide();
		Button.Star = Star;

		local SelectionGlow = Button:CreateTexture(nil, "OVERLAY");
		SelectionGlow:SetTexture(T_UIDefinition.texture_white);
		-- SelectionGlow:SetTexCoord(0.25, 0.75, 0.25, 0.75);
		SelectionGlow:SetVertexColor(unpack(T_UIDefinition.listButtonSelectedColor));
		SelectionGlow:SetAllPoints();
		SelectionGlow:SetBlendMode("ADD");
		SelectionGlow:Hide();
		Button.SelectionGlow = SelectionGlow;

		Button:SetScript("OnEnter", LT_SharedMethod.SkillListButton_OnEnter);
		Button:SetScript("OnLeave", LT_SharedMethod.SkillListButton_OnLeave);
		Button:RegisterForClicks("AnyUp");
		Button:SetScript("OnClick", LT_SharedMethod.SkillListButton_OnClick);
		Button:RegisterForDrag("LeftButton");
		Button:SetScript("OnHide", VT.__menulib.ShowMenu);

		function Button:Select()
			SelectionGlow:Show();
		end
		function Button:Deselect()
			SelectionGlow:Hide();
		end

		local Frame = parent:GetParent():GetParent();
		Button.Frame = Frame;
		Button.list = Frame.list;
		Button.flag = Frame.flag;

		return Button;
	end
	local function LF_SetSkillListButton(Button, data_index)
		local Frame = Button.Frame;
		local list = Button.list;
		local hash = Frame.hash;
		if data_index <= #list then
			local sid = list[data_index];
			local pid = Frame.flag or DataAgent.get_pid_by_sid(sid) or DataAgent.get_pid_by_pname(Frame.F_GetSkillName());
			local set = VT.SET[pid];
			local cid = DataAgent.get_cid_by_sid(sid);
			local recipeindex = hash[sid];
			if recipeindex ~= nil then
				local name, rank, num = Frame.F_GetRecipeInfo(recipeindex);
				if name ~= nil and rank ~= 'header' then
					Button:Show();
					VT.__uireimp._SetSimpleBackdropCenter(Button, 0, 1, 0.0, 0.0, 0.0, 1.0);
					local quality = cid and DataAgent.item_rarity(cid);
					Button.Icon:SetTexture(Frame.F_GetRecipeIcon(recipeindex));
					Button.Icon:SetVertexColor(1.0, 1.0, 1.0, 1.0);
					Button.Title:SetWidth(0);
					Button.Title:SetText(name);
					Button.Title:SetTextColor(unpack(CT.T_RankColor[CT.T_RankIndex[rank]] or T_UIDefinition.color_white));
					if num > 0 then
						if Button.Title:GetWidth() > 150 then
							Button.Title:SetWidth(150);
						end
						Button.Num:SetText("[" .. num .. "]");
						Button.Num:SetTextColor(unpack(CT.T_RankColor[CT.T_RankIndex[rank]] or T_UIDefinition.color_white));
					else
						Button.Title:SetWidth(160);
						Button.Num:SetText("");
					end
					if set.showRank then
						Button.Note:SetText(DataAgent.get_difficulty_rank_list_text_by_sid(sid, false));
					else
						Button.Note:SetText("");
					end
					if quality ~= nil then
						local r, g, b, code = GetItemQualityColor(quality);
						Button.QualityGlow:SetVertexColor(r, g, b);
						Button.QualityGlow:Show();
					else
						Button.QualityGlow:Hide();
					end
					if VT.FAV[sid] ~= nil then
						Button.Star:Show();
					else
						Button.Star:Hide();
					end
					if sid == Frame.selected_sid then
						Button:Select();
					else
						Button:Deselect();
					end
				else
					Button:Hide();
				end
			else
				Button:Show();
				if VT.SET.colored_rank_for_unknown then
					VT.__uireimp._SetSimpleBackdropCenter(Button, 0, 1, 0.5, 0.25, 0.25, 0.5);
				else
					VT.__uireimp._SetSimpleBackdropCenter(Button, 0, 1, 0.0, 0.0, 0.0, 1.0);
				end
				local _, quality, icon;
				if cid ~= nil then
					_, _, quality, _, icon = DataAgent.item_info(cid);
				else
					quality = nil;
					icon = ICON_FOR_NO_CID;
				end
				Button.Icon:SetTexture(icon);
				Button.Icon:SetVertexColor(1.0, 0.0, 0.0, 1.0);
				Button.Title:SetText(DataAgent.spell_name_s(sid));
				if VT.SET.colored_rank_for_unknown then
					local var = rawget(VT.VAR, pid);
					Button.Title:SetTextColor(unpack(CT.T_RankColor[DataAgent.get_difficulty_rank_by_sid(sid, var and var.cur_rank or 0)] or T_UIDefinition.color_white));
				else
					Button.Title:SetTextColor(1.0, 0.0, 0.0, 1.0);
				end
				Button.Title:SetWidth(160);
				Button.Num:SetText("");
				if set.showRank then
					Button.Note:SetText(DataAgent.get_difficulty_rank_list_text_by_sid(sid, false));
				else
					Button.Note:SetText("");
				end
				if quality ~= nil then
					local r, g, b, code = GetItemQualityColor(quality);
					Button.QualityGlow:SetVertexColor(r, g, b);
					Button.QualityGlow:Show();
				else
					Button.QualityGlow:Hide();
				end
				if VT.FAV[sid] ~= nil then
					Button.Star:Show();
				else
					Button.Star:Hide();
				end
				Button:Deselect();
			end
			if GetMouseFocus() == Button then
				LT_SharedMethod.SkillListButton_OnEnter(Button);
			end
			if Button.prev_sid ~= sid then
				VT.__menulib.ShowMenu(Button);
				Button.prev_sid = sid;
			end
		else
			VT.__menulib.ShowMenu(Button);
			Button:Hide();
		end
	end
--
local function LF_HookFrame(addon, meta)
	local HookedFrame = meta.HookedFrame;
	local Frame = CreateFrame('FRAME', nil, HookedFrame);
	HookedFrame.Frame = Frame;

	for index = 1, #meta.T_DisabledFuncName do
		local name = meta.T_DisabledFuncName[index];
		meta.T_DisabledFunc[name] = _G[name];
	end
	local T_StyleLayout = meta.T_StyleLayout;
	for _, layout in next, T_StyleLayout do
		if layout.anchor ~= nil then
			for index = 1, #layout.anchor do
				local point = layout.anchor[index];
				if point[2] == nil then
					point[2] = Frame;
				end
			end
		end
		if layout.scroll_anchor ~= nil then
			for index = 1, #layout.scroll_anchor do
				local point = layout.scroll_anchor[index];
				if point[2] == nil then
					point[2] = Frame;
				end
			end
		end
		if layout.detail_anchor ~= nil then
			for index = 1, #layout.detail_anchor do
				local point = layout.detail_anchor[index];
				if point[2] == nil then
					point[2] = Frame;
				end
			end
		end
	end
	for key, val in next, meta do
		Frame[key] = val;
	end

	do	--	Frame & HookedFrame
		--	Frame
			Frame:SetFrameStrata("HIGH");
			Frame:EnableMouse(true);
			function Frame.F_Update()
				LT_SharedMethod.UpdateFrame(Frame);
			end
			Frame:SetScript("OnShow", LT_FrameMethod._OnShow);
			Frame:SetScript("OnHide", LT_FrameMethod._OnHide);
			if meta.T_MonitoredEvents then
				for index = 1, #meta.T_MonitoredEvents do
					Frame:RegisterEvent(meta.T_MonitoredEvents[index]);
				end
				Frame:SetScript("OnEvent", LT_FrameMethod._OnEvent);
			end
			MT._TimerStart(Frame.F_Update, PERIODIC_UPDATE_PERIOD);
			Frame.list = {  };
			Frame.prev_var_update_time = GetTime() - MAXIMUM_VAR_UPDATE_PERIOD;

			local ScrollFrame = VT.__scrolllib.CreateScrollFrame(Frame, nil, nil, T_UIDefinition.skillListButtonHeight, LF_CreateSkillListButton, LF_SetSkillListButton);
			ScrollFrame:SetPoint("BOTTOMLEFT", 4, 0);
			ScrollFrame:SetPoint("TOPRIGHT", -4, -28);
			LT_SharedMethod.ModifyALAScrollFrame(ScrollFrame);
			Frame.ScrollFrame = ScrollFrame;

			local ToggleButton = CreateFrame('BUTTON', nil, HookedFrame, "UIPanelButtonTemplate");
			ToggleButton:SetSize(70, 18);
			ToggleButton:SetPoint("RIGHT", meta.Widget_AnchorTop, "LEFT", -2, 0);
			-- ToggleButton:SetPoint("TOPRIGHT", -2, -42);
			ToggleButton:SetFrameLevel(127);
			ToggleButton:SetScript("OnClick", LT_WidgetMethod.ToggleFrame);
			-- ToggleButton:SetScript("OnEnter", Info_OnEnter);
			-- ToggleButton:SetScript("OnLeave", Info_OnLeave);
			Frame.ToggleButton = ToggleButton;
			ToggleButton.Frame = Frame;

			local ExpandButton = CreateFrame('BUTTON', nil, HookedFrame);
			ExpandButton:SetSize(18, 18);
			ExpandButton:SetNormalTexture(T_UIDefinition.texture_expand);
			ExpandButton:SetPushedTexture(T_UIDefinition.texture_expand);
			ExpandButton:SetHighlightTexture(T_UIDefinition.texture_expand);
			ExpandButton:SetPoint("CENTER", Frame, "TOPRIGHT", 4, -356);
			ExpandButton:SetFrameLevel(127);
			ExpandButton:SetScript("OnClick", LT_WidgetMethod.ExpandButton_OnClick);
			Frame.ExpandButton = ExpandButton;
			ExpandButton.Frame = Frame;
			local ShrinkButton = CreateFrame('BUTTON', nil, HookedFrame);
			ShrinkButton:SetSize(18, 18);
			ShrinkButton:SetNormalTexture(T_UIDefinition.texture_shrink);
			ShrinkButton:SetPushedTexture(T_UIDefinition.texture_shrink);
			ShrinkButton:SetHighlightTexture(T_UIDefinition.texture_shrink);
			ShrinkButton:SetPoint("CENTER", Frame, "TOPRIGHT", 4, -356);
			ShrinkButton:SetFrameLevel(127);
			ShrinkButton:SetScript("OnClick", LT_WidgetMethod.ShrinkButton_OnClick);
			Frame.ShrinkButton = ShrinkButton;
			ShrinkButton.Frame = Frame;
		--

		HookedFrame:HookScript("OnHide", function(HookedFrame)
			Frame:Hide();
		end);
		--	variable
		local T_HookedFrameWidgets = meta.T_HookedFrameWidgets;

		--	hide HookedFrame texture
			HookedFrame:SetHitRectInsets(15, 33, 13, 71);
			local regions = { HookedFrame:GetRegions() };
			for index = 1, #regions do
				local obj = regions[index];
				local name = obj:GetName();
				if obj ~= meta.HookedPortrait and strupper(obj:GetObjectType()) == 'TEXTURE' then
					obj._Show = obj.Show;
					obj.Show = MT.noop;
					obj:Hide();
				end
			end
		--	Portrait
			meta.HookedPortrait:ClearAllPoints();
			meta.HookedPortrait:SetPoint("TOPLEFT", 7, -4);
			local PortraitBorder = HookedFrame:CreateTexture(nil, "ARTWORK");
			PortraitBorder:SetSize(70, 70);
			PortraitBorder:SetPoint("CENTER", meta.HookedPortrait);
			PortraitBorder:SetTexture([[Interface\Tradeskillframe\CapacitanceUIGeneral]]);
			PortraitBorder:SetTexCoord(65 / 256, 117 / 256, 45 / 128, 97 / 128);
			PortraitBorder:Show();
			Frame.PortraitBorder = PortraitBorder;
		--	Rank Offset
			local HookedRankFrame = meta.HookedRankFrame;
			local RankOffsetButton = CreateFrame('BUTTON', nil, Frame, "UIPanelButtonTemplate");
			RankOffsetButton:SetSize(40, 20);
			RankOffsetButton:SetPoint("CENTER", HookedRankFrame, "RIGHT", 18, 0);
			RankOffsetButton:SetText("+0");
			Frame.RankOffsetButton = RankOffsetButton;
			local RankOffsetSlider = CreateFrame('SLIDER', nil, Frame);
			RankOffsetSlider:SetOrientation("HORIZONTAL");
			RankOffsetSlider:SetThumbTexture([[Interface\Buttons\UI-SliderBar-Button-Horizontal]]);
			local Thumb = RankOffsetSlider:GetThumbTexture();
			Thumb:SetWidth(1);
			Thumb:SetHeight(12);
			Thumb:SetColorTexture(0.6, 1.0, 0.8, 1.0);
			RankOffsetSlider:SetPoint("LEFT", HookedRankFrame, "LEFT", 0, 0);
			RankOffsetSlider:SetPoint("RIGHT", HookedRankFrame, "RIGHT", 0, 0);
			RankOffsetSlider:SetHeight(16);
			RankOffsetSlider:SetMinMaxValues(1, 450);
			RankOffsetSlider:SetValueStep(1);
			RankOffsetSlider:SetObeyStepOnDrag(true);
			RankOffsetSlider:HookScript("OnValueChanged", LT_WidgetMethod.RankOffsetSlider__OnValueChanged);
			Frame.RankOffsetSlider = RankOffsetSlider;
			RankOffsetSlider.Frame = Frame;
			Frame.F_RefreshRankOffset = LT_FrameMethod.F_RefreshRankOffset;
		--	objects
			local T_HookedFrameDropdowns = T_HookedFrameWidgets.T_HookedFrameDropdowns;
			if T_HookedFrameDropdowns ~= nil then
				local InvSlotDropDown = T_HookedFrameDropdowns.InvSlotDropDown;
				if InvSlotDropDown ~= nil then
					LT_SharedMethod.RelayoutDropDownMenu(InvSlotDropDown);
					InvSlotDropDown:ClearAllPoints();
					InvSlotDropDown:SetPoint("RIGHT", HookedFrame, "TOPLEFT", 342 / 0.9, -81 / 0.9);
				end
				local SubClassDropDown = T_HookedFrameDropdowns.SubClassDropDown;
				if SubClassDropDown ~= nil then
					LT_SharedMethod.RelayoutDropDownMenu(SubClassDropDown);
					SubClassDropDown:ClearAllPoints();
					SubClassDropDown:SetPoint("RIGHT", InvSlotDropDown, "LEFT", -4 / 0.9, 0);
				end
			end
			local T_HookedFrameButtons = T_HookedFrameWidgets.T_HookedFrameButtons;
			T_HookedFrameButtons.CancelButton:SetSize(72, 18);
			T_HookedFrameButtons.CancelButton:ClearAllPoints();
			T_HookedFrameButtons.CancelButton:SetPoint("TOPRIGHT", -42, -415);
			T_HookedFrameButtons.CreateButton:SetSize(72, 18);
			T_HookedFrameButtons.CreateButton:ClearAllPoints();
			T_HookedFrameButtons.CreateButton:SetPoint("RIGHT", T_HookedFrameButtons.CancelButton, "LEFT", -7, 0);
			T_HookedFrameButtons.CloseButton:ClearAllPoints();
			T_HookedFrameButtons.CloseButton:SetPoint("CENTER", HookedFrame, "TOPRIGHT", -51, -24);
			T_HookedFrameButtons.ToggleButton = ToggleButton;
			T_HookedFrameButtons.RankOffsetButton = RankOffsetButton;
			local T_HookedFrameEditboxes = T_HookedFrameWidgets.T_HookedFrameEditboxes;
			if T_HookedFrameEditboxes ~= nil and T_HookedFrameEditboxes.InputBox then
				local Left = _G[T_HookedFrameEditboxes.InputBox:GetName() .. "Left"];
				Left:ClearAllPoints();
				Left:SetPoint("LEFT", 0, 0);
				T_HookedFrameEditboxes.InputBox:SetTextInsets(3, 0, 0, 0);
				T_HookedFrameButtons.CreateAllButton:SetSize(72, 18);
				T_HookedFrameButtons.IncrementButton:ClearAllPoints();
				T_HookedFrameEditboxes.InputBox:ClearAllPoints();
				T_HookedFrameButtons.DecrementButton:ClearAllPoints();
				T_HookedFrameButtons.CreateAllButton:ClearAllPoints();
				T_HookedFrameButtons.IncrementButton:SetPoint("CENTER", T_HookedFrameButtons.CreateButton, "LEFT", -16, 0);
				T_HookedFrameEditboxes.InputBox:SetHeight(18);
				T_HookedFrameEditboxes.InputBox:SetPoint("RIGHT", T_HookedFrameButtons.IncrementButton, "CENTER", -16, 0);
				T_HookedFrameButtons.DecrementButton:SetPoint("CENTER", T_HookedFrameEditboxes.InputBox, "LEFT", -16, 0);
				T_HookedFrameButtons.CreateAllButton:SetPoint("RIGHT", T_HookedFrameButtons.DecrementButton, "LEFT", -7, 0);
			end
			local CollapseAllButton = T_HookedFrameWidgets.CollapseAllButton;
			if CollapseAllButton ~= nil then
				CollapseAllButton:SetParent(HookedFrame);
				CollapseAllButton:ClearAllPoints();
				CollapseAllButton:SetPoint("BOTTOMLEFT", meta.HookedScrollFrame, "TOPLEFT", 0, 4);
			end
			local HookedRankFrame = meta.HookedRankFrame;
			HookedRankFrame:ClearAllPoints();
			HookedRankFrame:SetPoint("TOP", 0, -42);
			local HookedRankFrameName = HookedRankFrame:GetName();
			local HookedRankFrameSkillName = _G[HookedRankFrameName .. "SkillName"];
			if HookedRankFrameSkillName ~= nil then HookedRankFrameSkillName:Hide(); end
			local HookedRankFrameSkillRank = _G[HookedRankFrameName .. "SkillRank"];
			if HookedRankFrameSkillRank ~= nil then
				HookedRankFrameSkillRank:ClearAllPoints();
				HookedRankFrameSkillRank:SetPoint("CENTER");
				HookedRankFrameSkillRank:SetJustifyH("CENTER");
			end
			local HookedRankFrameBorder = _G[HookedRankFrameName .. "Border"];
			if HookedRankFrameBorder ~= nil then
				HookedRankFrameBorder:ClearAllPoints();
				HookedRankFrameBorder:SetPoint("TOPLEFT", -5, 8);
				HookedRankFrameBorder:SetPoint("BOTTOMRIGHT", 5, -8);
			end
			HookedRankFrame.Border = HookedRankFrameBorder;
		--	BACKGROUND and DEVIDER
			local TextureBackground = CreateFrame('FRAME', nil, HookedFrame);
			TextureBackground:SetPoint("TOPLEFT", 11, -12);
			TextureBackground:SetPoint("BOTTOMRIGHT", -32, 76);
			TextureBackground:SetFrameLevel(0);
			Frame.TextureBackground = TextureBackground;

			local TextureLineTop = TextureBackground:CreateTexture(nil, "BACKGROUND");
			TextureLineTop:SetDrawLayer("BACKGROUND", 7);
			TextureLineTop:SetHorizTile(true);
			TextureLineTop:SetHeight(4);
			TextureLineTop:SetPoint("LEFT", 2, 0);
			TextureLineTop:SetPoint("RIGHT", -2, 0);
			TextureLineTop:SetPoint("BOTTOM", HookedFrame, "TOP", 0, -38);
			Frame.TextureLineTop = TextureLineTop;

			local TextureLineMiddle = TextureBackground:CreateTexture(nil, "BACKGROUND");
			TextureLineMiddle:SetDrawLayer("BACKGROUND", 7);
			TextureLineMiddle:SetHorizTile(true);
			TextureLineMiddle:SetHeight(4);
			TextureLineMiddle:SetPoint("LEFT", 2, 0);
			TextureLineMiddle:SetPoint("RIGHT", -2, 0);
			TextureLineMiddle:SetPoint("TOP", HookedFrame, "TOP", 0, -61);
			Frame.TextureLineMiddle = TextureLineMiddle;

			local TextureLineBottom = TextureBackground:CreateTexture(nil, "BACKGROUND");
			TextureLineBottom:SetDrawLayer("BACKGROUND", 7);
			TextureLineBottom:SetHorizTile(true);
			TextureLineBottom:SetHeight(4);
			TextureLineBottom:SetPoint("LEFT", 2, 0);
			TextureLineBottom:SetPoint("RIGHT", -2, 0);
			TextureLineBottom:SetPoint("BOTTOM", meta.HookedDetailFrame, "TOP", 0, 2);
			Frame.TextureLineBottom = TextureLineBottom;
		--	SkillListButtons
			local T_SkillListButtons = {  };
			Frame.T_SkillListButtons = T_SkillListButtons;
			local NumDisplayed = _G[T_StyleLayout.C_VariableName_NumSkillListButton];
			for index = 1, NumDisplayed do
				T_SkillListButtons[index] = _G[T_HookedFrameWidgets.C_SkillListButtonNamePrefix .. index];
			end
			for index = NumDisplayed + 1, T_StyleLayout.expand.scroll_button_num do
				local name = T_HookedFrameWidgets.C_SkillListButtonNamePrefix .. index;
				local Button = _G[name] or CreateFrame('BUTTON', name, HookedFrame, T_HookedFrameWidgets.C_SkillListButtonTemplate);
				Button:SetPoint("TOPLEFT", T_SkillListButtons[index - 1], "BOTTOMLEFT", 0, 0);
				Button:Hide();
				T_SkillListButtons[index] = Button;
			end
			T_SkillListButtons[1]:ClearAllPoints();
			T_SkillListButtons[1]:SetPoint("TOPLEFT", meta.HookedScrollFrame);
			local FrameLevel = meta.HookedScrollFrame:GetFrameLevel() + 2;
			for index = 1, #T_SkillListButtons do
				local Button = T_SkillListButtons[index];
				Button:SetScript("OnEnter", LT_WidgetMethod.BLZSkillListButton_OnEnter);
				Button:SetScript("OnLeave", LT_SharedMethod.SkillListButton_OnLeave);
				Button:SetID(index);
				Button:SetFrameLevel(FrameLevel);
				Button.Frame = Frame;
				Button.ScrollFrame = meta.HookedScrollFrame;
			end
		--	reagentButton & ProductionIcon
			local T_ReagentButtons = {  };
			Frame.T_ReagentButtons = T_ReagentButtons;
			for index = 1, 8 do
				local Button = _G[T_HookedFrameWidgets.C_ReagentButtonNamePrefix .. index];
				T_ReagentButtons[index] = Button;
				Button.Frame = Frame;
				Button:HookScript("OnClick", LT_WidgetMethod.ReagentButton__OnClick);
			end
			T_HookedFrameWidgets.ProductionIcon.Frame = Frame;
			T_HookedFrameWidgets.ProductionIcon:HookScript("OnClick", LT_WidgetMethod.ProductionIcon__OnClick);
		--

		Frame.F_LayoutOnShow = LT_FrameMethod.F_LayoutOnShow;
		Frame.F_Expand = LT_FrameMethod.F_Expand;
		Frame.F_FixSkillList = LT_FrameMethod.F_FixSkillList;
		Frame.F_SetStyle = LT_FrameMethod.F_SetStyle;
		if meta.T_ToggleOnSkill == nil then
			Frame.F_ToggleOnSkill = MT.noop;
		else
			Frame.F_ToggleOnSkill = LT_FrameMethod.F_ToggleOnSkill;
		end
	end

	do	--	PortraitButton
		local PortraitButton = CreateFrame('BUTTON', nil, HookedFrame);
		PortraitButton:SetSize(42, 42);
		PortraitButton:SetPoint("CENTER", meta.HookedPortrait);
		PortraitButton:RegisterForClicks("AnyUp");
		PortraitButton.T_PortraitDropMeta = {
			handler = function(_, _, param)
				if param[2] == '@explorer' then
					MT.ToggleFrame("EXPLORER");
				elseif param[2] == '@config' then
					MT.ToggleFrame("CONFIG");
				else
					CastSpellByName(param[2]);
				end
			end,
			num = 0,
		};
		PortraitButton:SetScript("OnClick", LT_WidgetMethod.PortraitButton_OnClick);
		PortraitButton.F_Update = LT_WidgetMethod.PortraitButton_Update;
		Frame.PortraitButton = PortraitButton;
		PortraitButton.Frame = Frame;
	end

	do	--	TabFrame
		local TabFrame = CreateFrame('FRAME', nil, HookedFrame);
		TabFrame:SetFrameStrata("HIGH");
		TabFrame:SetHeight(T_UIDefinition.tabSize + T_UIDefinition.tabInterval * 2);
		TabFrame:SetPoint("LEFT", Frame);
		TabFrame:SetPoint("BOTTOM", meta.Widget_AnchorTop, "TOP", 0, -4);
		TabFrame:SetPoint("LEFT", meta.Widget_AnchorLeftOfTabFrame, "LEFT", 0, 0);
		TabFrame:Show();
		TabFrame.T_Tabs = {  };
		TabFrame.F_CreateTab = LT_WidgetMethod.TabFrame_CreateTab;
		TabFrame.F_SetNumTabs = LT_WidgetMethod.TabFrame_SetNumTabs;
		TabFrame.F_SetTab = LT_WidgetMethod.TabFrame_SetTab;
		TabFrame.F_Update = LT_WidgetMethod.TabFrame_Update;
		Frame.TabFrame = TabFrame;
		TabFrame.Frame = Frame;
	end

	do	--	search_box
		local SearchEditBox, SearchEditBoxOK, SearchEditBoxNameOnly = LT_SharedMethod.UICreateSearchBox(Frame);
		SearchEditBox:SetPoint("TOPLEFT", Frame, "TOPLEFT", 4, -6);
		SearchEditBox:SetPoint("RIGHT", SearchEditBoxNameOnly, "LEFT", -4, 0);
		SearchEditBoxNameOnly:SetPoint("RIGHT", SearchEditBoxOK, "LEFT", -4, 0);
		SearchEditBoxOK:SetPoint("TOPRIGHT", Frame, "TOPRIGHT", -68, -6);
	end

	do	--	ProfitFrame
		local ProfitFrame = CreateFrame('FRAME', nil, Frame);
		ProfitFrame:SetFrameStrata("HIGH");
		ProfitFrame:EnableMouse(true);
		ProfitFrame:Hide();
		ProfitFrame:SetSize(400, 360);
		ProfitFrame:SetPoint("TOPLEFT", HookedFrame, "TOPRIGHT", -30, -76);
		ProfitFrame.list = {  };
		Frame.ProfitFrame = ProfitFrame;
		ProfitFrame.Frame = Frame;

		local ToggleButton = CreateFrame('BUTTON', nil, Frame);
		ToggleButton:SetSize(20, 20);
		ToggleButton:SetNormalTexture(T_UIDefinition.texture_profit);
		ToggleButton:SetPushedTexture(T_UIDefinition.texture_profit);
		ToggleButton:GetPushedTexture():SetVertexColor(unpack(T_UIDefinition.textureButtonColorPushed));
		ToggleButton:SetHighlightTexture(T_UIDefinition.texture_profit);
		ToggleButton:GetHighlightTexture():SetVertexColor(unpack(T_UIDefinition.textureButtonColorHighlight));
		ToggleButton:SetPoint("TOPRIGHT", Frame, "TOPRIGHT", -24, -6);
		ToggleButton:SetScript("OnEnter", LT_SharedMethod.ButtonInfoOnEnter);
		ToggleButton:SetScript("OnLeave", LT_SharedMethod.ButtonInfoOnLeave);
		ToggleButton.info_lines = { l10n["TIP_PROFIT_FRAME_CALL_INFO"] };
		ToggleButton:SetScript("OnClick", LT_WidgetMethod.ProfitFrameToggleButton_OnClick);
		ProfitFrame.ToggleButton = ToggleButton;
		ToggleButton.ProfitFrame = ProfitFrame;
		ToggleButton.Frame = Frame;

		ProfitFrame:SetScript("OnShow", LT_WidgetMethod.ProfitFrame_OnShow);
		ProfitFrame:SetScript("OnHide", LT_WidgetMethod.ProfitFrame_OnHide);

		local ScrollFrame = VT.__scrolllib.CreateScrollFrame(ProfitFrame, nil, nil, T_UIDefinition.skillListButtonHeight, LT_SharedMethod.ProfitCreateSkillListButton, LT_SharedMethod.ProfitSetSkillListButton);
		ScrollFrame:SetPoint("BOTTOMLEFT", 4, 8);
		ScrollFrame:SetPoint("TOPRIGHT", -8, -28);
		ProfitFrame.ScrollFrame = ScrollFrame;

		local CostOnlyCheck = CreateFrame('CHECKBUTTON', nil, ProfitFrame, "OptionsBaseCheckButtonTemplate");
		CostOnlyCheck:SetSize(24, 24);
		CostOnlyCheck:SetHitRectInsets(0, 0, 0, 0);
		CostOnlyCheck:SetPoint("CENTER", ProfitFrame, "TOPLEFT", 18, -14);
		CostOnlyCheck:Show();
		local Text = ProfitFrame:CreateFontString(nil, "ARTWORK");
		Text:SetFont(T_UIDefinition.frameNormalFont, T_UIDefinition.frameNormalFontSize, T_UIDefinition.frameNormalFontFlag);
		Text:SetPoint("LEFT", CostOnlyCheck, "CENTER", 10, 0);
		Text:SetText(l10n["PROFIT_SHOW_COST_ONLY"]);
		CostOnlyCheck.Text = Text;
		CostOnlyCheck:SetScript("OnClick", LT_WidgetMethod.ProfitFrameCostOnlyCheck_OnClick);
		ProfitFrame.CostOnlyCheck = CostOnlyCheck;
		CostOnlyCheck.ProfitFrame = ProfitFrame;
		CostOnlyCheck.Frame = Frame;

		local CloseButton = CreateFrame('BUTTON', nil, ProfitFrame, "UIPanelCloseButton");
		CloseButton:SetSize(32, 32);
		CloseButton:SetPoint("CENTER", ProfitFrame, "TOPRIGHT", -18, -14);
		CloseButton:SetScript("OnClick", LT_WidgetMethod.ProfitFrameCloseButton_OnClick);
		ProfitFrame.CloseButton = CloseButton;
		CloseButton.ProfitFrame = ProfitFrame;
		CloseButton.Frame = Frame;

		LT_SharedMethod.ModifyALAScrollFrame(ScrollFrame);

		Frame.F_ShowProfitFrame = LT_FrameMethod.F_ShowProfitFrame;
		Frame.F_HideProfitFrame = LT_FrameMethod.F_HideProfitFrame;
	end

	do	--	SetFrame
		local SetFrame = CreateFrame('FRAME', nil, Frame);
		SetFrame:SetFrameStrata("HIGH");
		SetFrame:SetSize(332, 66);
		SetFrame:Hide();
		Frame.SetFrame = SetFrame;
		SetFrame.Frame = Frame;

		local TipInfo = SetFrame:CreateFontString(nil, "ARTWORK");
		TipInfo:SetFont(T_UIDefinition.frameNormalFont, T_UIDefinition.frameNormalFontSize - 1, T_UIDefinition.frameNormalFontFlag);
		TipInfo:SetPoint("RIGHT", SetFrame, "BOTTOMRIGHT", -2, 9);
		SetFrame.TipInfo = TipInfo;

		local ToggleButton = CreateFrame('BUTTON', nil, Frame);
		ToggleButton:SetSize(16, 16);
		ToggleButton:SetNormalTexture(T_UIDefinition.texture_config);
		ToggleButton:SetPushedTexture(T_UIDefinition.texture_config);
		ToggleButton:GetPushedTexture():SetVertexColor(unpack(T_UIDefinition.textureButtonColorPushed));
		ToggleButton:SetHighlightTexture(T_UIDefinition.texture_config);
		ToggleButton:GetHighlightTexture():SetVertexColor(unpack(T_UIDefinition.textureButtonColorHighlight));
		ToggleButton:SetPoint("TOPRIGHT", Frame, "TOPRIGHT", -4, -6);
		ToggleButton:SetScript("OnClick", LT_WidgetMethod.SetFrameToggleButton_OnClick);
		SetFrame.ToggleButton = ToggleButton;
		ToggleButton.SetFrame = SetFrame;
		ToggleButton.Frame = Frame;

		SetFrame:SetScript("OnShow", LT_WidgetMethod.SetFrame_OnShow);
		SetFrame:SetScript("OnHide", LT_WidgetMethod.SetFrame_OnHide);

		local T_CheckButtons = {  };
		local T_KeyTables = { "showUnkown", "showKnown", "showHighRank", "filterClass", "filterSpec", "showItemInsteadOfSpell", "showRank", "haveMaterials", };
		for index = 1, #T_KeyTables do
			local key = T_KeyTables[index];
			local CheckButton = CreateFrame('CHECKBUTTON', nil, SetFrame, "OptionsBaseCheckButtonTemplate");
			CheckButton:SetSize(24, 24);
			CheckButton:SetHitRectInsets(0, 0, 0, 0);
			CheckButton:Show();
			CheckButton:SetChecked(false);
			local Text = SetFrame:CreateFontString(nil, "ARTWORK");
			Text:SetFont(T_UIDefinition.frameNormalFont, T_UIDefinition.frameNormalFontSize, T_UIDefinition.frameNormalFontFlag);
			Text:SetText(l10n[key]);
			CheckButton.Text = Text;
			Text:SetPoint("LEFT", CheckButton, "RIGHT", 0, 0);
			if index % 4 == 1 then
				if index == 1 then
					CheckButton:SetPoint("CENTER", SetFrame, "TOPLEFT", 16, -12);
				else
					CheckButton:SetPoint("CENTER", T_CheckButtons[index - 4], "CENTER", 0, -24);
				end
			else
				CheckButton:SetPoint("CENTER", T_CheckButtons[index - 1], "CENTER", 80, 0);
			end
			if index == 1 or index == 2 or index == 3 or index == 4 or index == 5 or index == 8 then
				CheckButton:SetScript("OnClick", LT_WidgetMethod.SetFrameCheckButton_OnClick_WithUpdate);
			else
				CheckButton:SetScript("OnClick", LT_WidgetMethod.SetFrameCheckButton_OnClick);
			end
			CheckButton.key = key;
			local TipText = l10n[key .. "Tip"];
			if TipText ~= nil then
				CheckButton.TipText = TipText;
				CheckButton:SetScript("OnEnter", LT_WidgetMethod.SetFrameCheckButton_OnEnter);
				CheckButton:SetScript("OnLeave", LT_WidgetMethod.SetFrameCheckButton_OnLeave);
			end
			T_CheckButtons[#T_CheckButtons + 1] = CheckButton;
			CheckButton.TipInfo = TipInfo;
			CheckButton.Frame = Frame;
		end
		SetFrame.T_CheckButtons = T_CheckButtons;

		local PhaseSlider = CreateFrame('SLIDER', nil, SetFrame, "OptionsSliderTemplate");
		PhaseSlider:SetPoint("BOTTOM", SetFrame, "TOP", 0, 10);
		PhaseSlider:SetPoint("LEFT", 4, 0);
		PhaseSlider:SetPoint("RIGHT", -4, 0);
		PhaseSlider:SetHeight(16);
		PhaseSlider:SetMinMaxValues(1, DataAgent.MAXPHASE);
		PhaseSlider:SetValueStep(1);
		PhaseSlider:SetObeyStepOnDrag(true);
		PhaseSlider.Text:ClearAllPoints();
		PhaseSlider.Text:SetPoint("TOP", PhaseSlider, "BOTTOM", 0, 4);
		PhaseSlider.Low:ClearAllPoints();
		PhaseSlider.Low:SetPoint("TOPLEFT", PhaseSlider, "BOTTOMLEFT", 4, 3);
		PhaseSlider.High:ClearAllPoints();
		PhaseSlider.High:SetPoint("TOPRIGHT", PhaseSlider, "BOTTOMRIGHT", -4, 3);
		PhaseSlider.Low:SetText("|cff00ff001|r");
		PhaseSlider.High:SetText("|cffff0000" .. DataAgent.MAXPHASE .. "|r");
		PhaseSlider:HookScript("OnValueChanged", LT_WidgetMethod.SetFramePhaseSlider__OnValueChanged);
		SetFrame.PhaseSlider = PhaseSlider;
		PhaseSlider.SetFrame = SetFrame;
		PhaseSlider.Frame = Frame;

		Frame.F_ShowSetFrame = LT_FrameMethod.F_ShowSetFrame;
		Frame.F_HideSetFrame = LT_FrameMethod.F_HideSetFrame;
		Frame.F_RefreshSetFrame = LT_FrameMethod.F_RefreshSetFrame;
	end

	do	--	HaveMaterialsCheck
		local HaveMaterialsCheck = CreateFrame('CHECKBUTTON', nil, Frame, "OptionsBaseCheckButtonTemplate");
		HaveMaterialsCheck:SetSize(24, 24);
		HaveMaterialsCheck:SetHitRectInsets(0, 0, 0, 0);
		HaveMaterialsCheck:Show();
		HaveMaterialsCheck:SetChecked(false);
		HaveMaterialsCheck:SetPoint("CENTER", Frame, "TOPRIGHT", -54, -14);
		HaveMaterialsCheck:SetScript("OnClick", LT_WidgetMethod.HaveMaterialsCheck_OnClick);
		HaveMaterialsCheck.info_lines = { l10n["haveMaterialsTip"], };
		HaveMaterialsCheck:SetScript("OnEnter", LT_SharedMethod.ButtonInfoOnEnter);
		HaveMaterialsCheck:SetScript("OnLeave", LT_SharedMethod.ButtonInfoOnLeave);
		Frame.HaveMaterialsCheck = HaveMaterialsCheck;
		HaveMaterialsCheck.Frame = Frame;
	end

	do	--	InfoInFrame
		local RankInfoInFrame = Frame.HookedDetailChild:CreateFontString(nil, "OVERLAY");
		RankInfoInFrame:SetFont(T_UIDefinition.frameNormalFont, T_UIDefinition.frameNormalFontSize, T_UIDefinition.frameNormalFontFlag);
		RankInfoInFrame:SetPoint("TOPLEFT", Frame.HookedDetailChild, "TOPLEFT", 5, -50);
		Frame.RankInfoInFrame = RankInfoInFrame;

		local T_PriceInfoInFrame = {  };
		T_PriceInfoInFrame[1] = Frame.HookedDetailChild:CreateFontString(nil, "OVERLAY");
		T_PriceInfoInFrame[1]:SetFont(T_UIDefinition.frameNormalFont, T_UIDefinition.frameNormalFontSize, T_UIDefinition.frameNormalFontFlag);
		T_PriceInfoInFrame[1]:SetPoint("TOPLEFT", RankInfoInFrame, "BOTTOMLEFT", 0, -3);
		T_PriceInfoInFrame[2] = Frame.HookedDetailChild:CreateFontString(nil, "OVERLAY");
		T_PriceInfoInFrame[2]:SetFont(T_UIDefinition.frameNormalFont, T_UIDefinition.frameNormalFontSize, T_UIDefinition.frameNormalFontFlag);
		T_PriceInfoInFrame[2]:SetPoint("TOPLEFT", T_PriceInfoInFrame[1], "BOTTOMLEFT", 0, 0);
		T_PriceInfoInFrame[3] = Frame.HookedDetailChild:CreateFontString(nil, "OVERLAY");
		T_PriceInfoInFrame[3]:SetFont(T_UIDefinition.frameNormalFont, T_UIDefinition.frameNormalFontSize, T_UIDefinition.frameNormalFontFlag);
		T_PriceInfoInFrame[3]:SetPoint("TOPLEFT", T_PriceInfoInFrame[2], "BOTTOMLEFT", 0, 0);
		Frame.T_PriceInfoInFrame = T_PriceInfoInFrame;

		Frame.Widget_PositionSkippedByInfoInFrame:ClearAllPoints();
		Frame.Widget_PositionSkippedByInfoInFrame:SetPoint("TOPLEFT", T_PriceInfoInFrame[3], "BOTTOMLEFT", 0, -3);

		local function LF_DelayUpdateInfoInFrame()
			Frame:F_UpdatePriceInfo();
			Frame:F_UpdateRankInfo();
		end
		local prev_sid = nil;
		local function LF_OnSelection()
			if not Frame:IsShown() then
				local index = Frame.F_GetSelection();
				if index ~= nil then
					Frame.selected_sid = 
						Frame.F_GetRecipeSpellID ~= nil and Frame.F_GetRecipeSpellID(index) or
						DataAgent.get_sid_by_pid_sname_cid(DataAgent.get_pid_by_pname(Frame.F_GetSkillName()), Frame.F_GetRecipeInfo(index), Frame.F_GetRecipeItemID(index));
				end
			end
			if prev_sid ~= Frame.selected_sid then
				prev_sid = Frame.selected_sid;
				T_PriceInfoInFrame[1]:SetText("");
				T_PriceInfoInFrame[2]:SetText("");
				T_PriceInfoInFrame[3]:SetText("");
			end
			MT.After(0.5, LF_DelayUpdateInfoInFrame);
		end
		hooksecurefunc(Frame.T_FunctionName.F_SetSelection, LF_OnSelection);
		Frame.F_OnSelection = LF_OnSelection;
		Frame.F_SetSelection = _G[Frame.T_FunctionName.F_SetSelection];
		Frame.F_UpdatePriceInfo = LT_FrameMethod.F_UpdatePriceInfo;
		Frame.F_UpdateRankInfo = LT_FrameMethod.F_UpdateRankInfo;
	end

	ALA_HOOK_ChatEdit_InsertLink(function(link, addon)
		if Frame:IsVisible() and addon ~= __addon and not (BrowseName ~= nil and BrowseName:IsVisible()) then
			local name, _, _, _, _, _, _, _, loc = GetItemInfo(link);
			if name ~= nil and name ~= "" then
				local pid = Frame.flag or DataAgent.get_pid_by_pname(Frame.F_GetSkillName());
				Frame.SearchEditBox:ClearFocus();
				if pid == 10 and loc and loc ~= "" then
					local id = tonumber(strmatch(link, "item:(%d+)"));
					if id ~= 11287 and id ~= 11288 and id ~= 11289 and id ~= 11290 then
						if l10n.ENCHANT_FILTER[loc] ~= nil then
							Frame:F_Search(l10n.ENCHANT_FILTER[loc]);
						else
							Frame:F_Search(l10n.ENCHANT_FILTER.NONE);
						end
					else
						Frame:F_Search(name);
					end
				else
					Frame:F_Search(name);
				end
				return true;
			end
		end
	end);
	ALA_HOOK_ChatEdit_InsertName(function(name, addon)
		if Frame:IsVisible() and addon ~= __addon and not (BrowseName ~= nil and BrowseName:IsVisible()) then
			if name ~= nil and name ~= "" then
				Frame.SearchEditBox:SetText(name);
				Frame.SearchEditBox:ClearFocus();
				Frame:F_Search(name);
				return true;
			end
		end
	end);

	local function callback()
		Frame.ScrollFrame:Update();
		LT_SharedMethod.UpdateProfitFrame(Frame);
		Frame:F_UpdatePriceInfo();
	end
	-- if VT.AuctionMod ~= nil and VT.AuctionMod.F_OnDBUpdate ~= nil then
	-- 	VT.AuctionMod.F_OnDBUpdate(callback);
	-- end
	MT.AddCallback("AUCTION_MOD_LOADED", function(mod)
		if mod ~= nil then
			if mod.F_OnDBUpdate then
				mod.F_OnDBUpdate(callback);
			end
			-- callback();
		end
	end);
	MT.AddCallback("UI_MOD_LOADED", function(mod)
		if mod ~= nil and mod.Skin ~= nil then
			mod.Skin(addon, Frame);
		end
	end);

	return Frame;
end
local function LF_FrameApplySetting(Frame)
	for key, name in next, Frame.T_FunctionName do
		Frame[key] = _G[key] or Frame[key];
	end
	--
	Frame.TabFrame:F_Update();
	Frame.PortraitButton:F_Update();
	Frame:F_Expand(VT.SET.expand);
	Frame:F_FixSkillList(VT.SET.expand);
	Frame:F_SetStyle(VT.SET.blz_style, true);
	if VT.SET.show_call then
		Frame.ToggleButton:Show();
	else
		Frame.ToggleButton:Hide();
	end
	if VT.SET.show_tab then
		Frame.TabFrame:Show();
	else
		Frame.TabFrame:Hide();
	end
	if VT.SET.portrait_button then
		Frame.PortraitButton:Show();
	else
		Frame.PortraitButton:Hide();
	end
	--
	local function Ticker()
		if Frame.HookedPortrait:GetTexture() == nil then
			SetPortraitTexture(Frame.HookedPortrait, "player");
		else
			MT._TimerHalt(Ticker);
		end
	end
	MT._TimerStart(Ticker, 0.1);
end
--
local function LF_AddOnCallback_Blizzard_TradeSkillUI(addon)
	-->
		local ExpandTradeSkillSubClass = _G.ExpandTradeSkillSubClass;
		local SetTradeSkillSubClassFilter = _G.SetTradeSkillSubClassFilter;
		local SetTradeSkillInvSlotFilter = _G.SetTradeSkillInvSlotFilter;
		local SetTradeSkillItemNameFilter = _G.SetTradeSkillItemNameFilter;
		local SetTradeSkillItemLevelFilter = _G.SetTradeSkillItemLevelFilter;

		local IsTradeSkillLinked = _G.IsTradeSkillLinked or function() return false; end;
		local GetTradeSkillLine = _G.GetTradeSkillLine;
		local GetNumTradeSkills = _G.GetNumTradeSkills;
		local DoTradeSkill = _G.DoTradeSkill;
		local CloseTradeSkill = _G.CloseTradeSkill;
		local TradeSkillFrame_SetSelection = _G.TradeSkillFrame_SetSelection;
		local GetTradeSkillSelectionIndex = _G.GetTradeSkillSelectionIndex;
		--
		local GetTradeSkillInfo = _G.GetTradeSkillInfo;
		local GetTradeSkillRecipeLink = _G.GetTradeSkillRecipeLink;
		local GetTradeSkillItemLink = _G.GetTradeSkillItemLink;
		local GetTradeSkillIcon = _G.GetTradeSkillIcon;
		--
		local GetTradeSkillTools = _G.GetTradeSkillTools;
		local GetTradeSkillCooldown = _G.GetTradeSkillCooldown;
		local GetTradeSkillNumMade = _G.GetTradeSkillNumMade;
		local GetTradeSkillNumReagents = _G.GetTradeSkillNumReagents;
		local GetTradeSkillReagentItemLink = _G.GetTradeSkillReagentItemLink;
		local GetTradeSkillReagentInfo = _G.GetTradeSkillReagentInfo;
		local TradeSkillFrame_Update = _G.TradeSkillFrame_Update;


		local TradeSkillFrame = _G.TradeSkillFrame;
		local TradeSkillFramePortrait = _G.TradeSkillFramePortrait;
		local TradeSkillFrameCloseButton = _G.TradeSkillFrameCloseButton;
		local TradeSkillRankFrame = _G.TradeSkillRankFrame;
		local TradeSkillRankFrameBorder = _G.TradeSkillRankFrameBorder;
		local TradeSkillFrameAvailableFilterCheckButton = _G.TradeSkillFrameAvailableFilterCheckButton;
		local TradeSearchInputBox = _G.TradeSearchInputBox or _G.TradeSkillFrameEditBox;
		local TradeSkillListScrollFrame = _G.TradeSkillListScrollFrame;
		local TradeSkillListScrollFrameScrollBar = _G.TradeSkillListScrollFrameScrollBar;
		local TradeSkillHighlightFrame = _G.TradeSkillHighlightFrame;
		local TradeSkillDetailScrollFrame = _G.TradeSkillDetailScrollFrame;
		local TradeSkillDetailScrollChildFrame = _G.TradeSkillDetailScrollChildFrame;
		local TradeSkillDetailScrollFrameScrollBar = _G.TradeSkillDetailScrollFrameScrollBar;

		local TradeSkillSkillIcon = _G.TradeSkillSkillIcon;

		local TradeSkillCreateAllButton = _G.TradeSkillCreateAllButton;
		local TradeSkillDecrementButton = _G.TradeSkillDecrementButton;
		local TradeSkillInputBox = _G.TradeSkillInputBox;
		local TradeSkillIncrementButton = _G.TradeSkillIncrementButton;
		local TradeSkillCreateButton = _G.TradeSkillCreateButton;
		local TradeSkillCancelButton = _G.TradeSkillCancelButton;

		local TradeSkillCollapseAllButton = _G.TradeSkillCollapseAllButton;
		local TradeSkillExpandButtonFrame = _G.TradeSkillExpandButtonFrame;
		local TradeSkillSubClassDropDown = _G.TradeSkillSubClassDropDown;
		local TradeSkillInvSlotDropDown = _G.TradeSkillInvSlotDropDown;
		local TradeSkillDescription = _G.TradeSkillDescription;
		local TradeSkillReagentLabel = _G.TradeSkillReagentLabel;


		local UIDropDownMenu_SetSelectedID = _G.UIDropDownMenu_SetSelectedID;
	-->

	local meta = {
		HookedFrame = TradeSkillFrame,
		HookedDetailFrame = TradeSkillDetailScrollFrame,
		HookedDetailBar = TradeSkillDetailScrollFrameScrollBar,
		HookedDetailChild = TradeSkillDetailScrollChildFrame,
		HookedScrollFrame = TradeSkillListScrollFrame,
		HookedScrollBar = TradeSkillListScrollFrameScrollBar,
		HookedRankFrame = TradeSkillRankFrame,
		HookedPortrait = TradeSkillFramePortrait,
		T_StyleLayout = {
			normal = {
				frame_size = { 384, 512, },
				anchor = {
					{ "TOPLEFT", TradeSkillFrame, "TOPLEFT", 18, -68, },
					-- { "BOTTOMRIGHT", TradeSkillFrame, "TOPRIGHT", -38, -230, },
				},
				size = { 328, 156, },
				scroll_anchor = {
					{ "TOPLEFT", TradeSkillFrame, "TOPLEFT", 22, -96, },
				},
				scroll_size = { 298, 128, },
				scroll_button_num = 8,
				detail_anchor = {
					{ "TOPLEFT", TradeSkillFrame, "TOPLEFT", 22, -234, },
				},
				detail_size = { 298, 176 },
			},
			expand = {
				frame_size = { 715, 512, },
				anchor = {
					{ "TOPLEFT", TradeSkillFrame, "TOPLEFT", 18, -68, },
				},
				size = { 328, 366, },
				scroll_anchor = {
					{ "TOPLEFT", TradeSkillFrame, "TOPLEFT", 22, -96, },
				},
				scroll_size = { 298, 21 * 16, },
				scroll_button_num = 21,
				detail_anchor = {
					{ "TOPLEFT", nil, "TOPRIGHT", 2, -4, },
				},
				detail_size = { 298, 318, },
			},
			C_VariableName_NumSkillListButton = "TRADE_SKILLS_DISPLAYED",
		},
		Widget_AnchorTop = TradeSkillFrameCloseButton,
		Widget_AnchorLeftOfTabFrame = TradeSkillRankFrameBorder,
		Widget_PositionSkippedByInfoInFrame = TradeSkillDescription or TradeSkillReagentLabel,
		T_HookedFrameWidgets = {
			backup = {  },
			C_SkillListButtonNamePrefix = "TradeSkillSkill",
			C_SkillListButtonTemplate = "TradeSkillSkillButtonTemplate",
			ProductionIcon = TradeSkillSkillIcon,
			C_ReagentButtonNamePrefix = "TradeSkillReagent",
			T_HookedFrameButtons = {
				CancelButton = TradeSkillCancelButton,
				CreateButton = TradeSkillCreateButton,
				IncrementButton = TradeSkillIncrementButton,
				DecrementButton = TradeSkillDecrementButton,
				CreateAllButton = TradeSkillCreateAllButton,
				CloseButton = TradeSkillFrameCloseButton,
			},
			T_ButtonModernTexture = {
				CloseButton = T_UIDefinition.texture_modern_button_close,
				IncrementButton = T_UIDefinition.texture_modern_arrow_right,
				DecrementButton = T_UIDefinition.texture_modern_arrow_left,
			},
			T_HookedFrameDropdowns = {
				InvSlotDropDown = TradeSkillInvSlotDropDown,
				SubClassDropDown = TradeSkillSubClassDropDown,
			},
			T_HookedFrameEditboxes = {
				InputBox = TradeSkillInputBox,
				SearchInputBox = TradeSearchInputBox,
			},
			T_HookedFrameChecks = {
				AvailableFilterCheckButton = TradeSkillFrameAvailableFilterCheckButton,
			},
			CollapseAllButton = TradeSkillCollapseAllButton,
		},

		-- expand = ExpandTradeSkillSubClass,
		-- collapse = CollapseTradeSkillSubClass,
		F_ClearFilter = function()
			SetTradeSkillSubClassFilter(0, 1, 1);
			UIDropDownMenu_SetSelectedID(TradeSkillSubClassDropDown, 1);
			SetTradeSkillInvSlotFilter(0, 1, 1);
			if CT.VGT2X then
				SetTradeSkillItemNameFilter(nil);
				SetTradeSkillItemLevelFilter(0, 0);
			end
			UIDropDownMenu_SetSelectedID(TradeSkillInvSlotDropDown, 1);
			ExpandTradeSkillSubClass(0);
			if CT.VGT2X then
				TradeSkillFrameAvailableFilterCheckButton:SetChecked(false);
			end
			if TradeSkillCollapseAllButton ~= nil then
				TradeSkillCollapseAllButton.collapsed = nil;
			end
		end,

		F_IsLinked = IsTradeSkillLinked,
		F_GetSkillName = GetTradeSkillLine,
		F_GetSkillInfo = GetTradeSkillLine,
		-- F_GetSkillInfo = function(...) return GetTradeSkillLine(...), DataAgent.MAXRANK, DataAgent.MAXRANK; end,
			--	skillName, cur_rank, max_rank

		F_GetRecipeNumAvailable = GetNumTradeSkills,
		F_DoTradeCraft = DoTradeSkill,
		F_CloseSkill = CloseTradeSkill,
		F_SetSelection = TradeSkillFrame_SetSelection,		-- SelectTradeSkill
		F_GetSelection = GetTradeSkillSelectionIndex,

		F_GetRecipeInfo = GetTradeSkillInfo,
			--	skillName, difficult & header, numAvailable, isExpanded = GetTradeSkillInfo(skillIndex)
		F_GetRecipeSpellID = CT.VGT3X and function(arg1) local link = GetTradeSkillRecipeLink(arg1); return link and tonumber(strmatch(link, "[a-zA-Z]:(%d+)")) or nil; end or nil,
		F_GetRecipeSpellLink = CT.VGT3X and GetTradeSkillRecipeLink or nil;
		F_GetRecipeItemID = function(arg1) local link = GetTradeSkillItemLink(arg1); return link and tonumber(strmatch(link, "[a-zA-Z]:(%d+)")) or nil; end,
		F_GetRecipeItemLink = GetTradeSkillItemLink,
		F_GetRecipeIcon = GetTradeSkillIcon,
		F_GetRecipeDesc = function() return ""; end,
		F_GetRecipeTools = GetTradeSkillTools,
		F_GetRecipeCooldown = GetTradeSkillCooldown,
		F_GetRecipeNumMade = GetTradeSkillNumMade,
			--	num_Made_Min, num_Made_Max

		F_GetRecipeNumReagents = GetTradeSkillNumReagents,
		F_GetRecipeReagentLink = GetTradeSkillReagentItemLink,
		F_GetRecipeReagentID = function(i, j) return tonumber(strmatch(GetTradeSkillReagentItemLink(i, j), "[a-zA-Z]:(%d+)")); end,
		F_GetRecipeReagentInfo = GetTradeSkillReagentInfo,
			--	name, texture, numRequired, numHave = GetTradeSkillReagentInfo(tradeSkillRecipeId, reagentId);

		F_HookedFrameUpdate = TradeSkillFrame_Update,
		T_MonitoredEvents = {
			-- "NEW_RECIPE_LEARNED",
			-- "TRADE_SKILL_SHOW",
			"TRADE_SKILL_UPDATE",
		},

		F_WithDisabledFrame = function(self, func)
			if CT.VGT2X then
				func(TradeSkillFrameAvailableFilterCheckButton);
				func(TradeSearchInputBox);
				TradeSearchInputBox:ClearFocus();
			end
			func(TradeSkillCollapseAllButton);
			func(TradeSkillInvSlotDropDown);
			func(TradeSkillSubClassDropDown);
			func(TradeSkillListScrollFrame);
			func(TradeSkillListScrollFrameScrollBar);
			func(TradeSkillHighlightFrame);
			local T_SkillListButtons = self.T_SkillListButtons;
			if T_SkillListButtons ~= nil then
				for index = 1, #T_SkillListButtons do
					func(T_SkillListButtons[index]);
				end
			end
		end,
		T_DisabledFunc = {  },
		T_DisabledFuncName = {
			"CollapseTradeSkillSubClass",
			-- "ExpandTradeSkillSubClass",
			"SetTradeSkillSubClassFilter",
			"SetTradeSkillInvSlotFilter",
		},

		T_FunctionName = {
			F_SetSelection = "TradeSkillFrame_SetSelection",
		},
	};
	local Frame = LF_HookFrame(addon, meta);
	VT.UIFrames[addon] = Frame;
	--
	if CT.VGT2X then
		TradeSkillFrameAvailableFilterCheckButton:ClearAllPoints();
		TradeSkillFrameAvailableFilterCheckButton:SetPoint("TOPLEFT", TradeSkillFrame, "TOPLEFT", 68, -56);
	end
	TradeSkillExpandButtonFrame:Hide();
	--
	if CT.VGT3X then
		local ENCHANT_FILTER = l10n.ENCHANT_FILTER;
	--	Dropdown Filter
		local T_TradeSkillFrameFilterMeta = {
			handler = function(_, _, key)
				local text = ENCHANT_FILTER[key];
				if text ~= nil then
					Frame:F_Search(text);
				end
			end,
			num = 7,
			{	--	"披风"
				text = ENCHANT_FILTER.INVTYPE_CLOAK,
				param = "INVTYPE_CLOAK",
			},
			{	--	"胸甲"
				text = ENCHANT_FILTER.INVTYPE_CHEST,
				param = "INVTYPE_CHEST",
			},
			{	--	"护腕"
				text = ENCHANT_FILTER.INVTYPE_WRIST,
				param = "INVTYPE_WRIST",
			},
			{	--	"手套"
				text = ENCHANT_FILTER.INVTYPE_HAND,
				param = "INVTYPE_HAND",
			},
			{	--	"靴"
				text = ENCHANT_FILTER.INVTYPE_FEET,
				param = "INVTYPE_FEET",
			},
			{	--	"武器"
				text = ENCHANT_FILTER.INVTYPE_WEAPON,
				param = "INVTYPE_WEAPON",
			},
			{	--	"盾牌"
				text = ENCHANT_FILTER.INVTYPE_SHIELD,
				param = "INVTYPE_SHIELD",
			},
			-- {	--	"没有匹配的附魔"
			-- 	text = ENCHANT_FILTER.NONE,
			-- 	param = "NONE",
			-- },
		};
		local FilterDropdown = CreateFrame('BUTTON', nil, Frame);
		FilterDropdown:SetSize(16, 16);
		FilterDropdown:EnableMouse(true);
		FilterDropdown:SetNormalTexture([[Interface\MainMenuBar\UI-MainMenu-ScrollDownButton-UP]]);
		FilterDropdown:GetNormalTexture():SetTexCoord(6 / 32, 26 / 32, 6 / 32, 26 / 32);
		FilterDropdown:SetPushedTexture([[Interface\MainMenuBar\UI-MainMenu-ScrollDownButton-UP]]);
		FilterDropdown:GetPushedTexture():SetTexCoord(6 / 32, 26 / 32, 6 / 32, 26 / 32);
		FilterDropdown:GetPushedTexture():SetVertexColor(unpack(T_UIDefinition.textureButtonColorPushed));
		FilterDropdown:SetHighlightTexture([[Interface\MainMenuBar\UI-MainMenu-ScrollDownButton-UP]]);
		FilterDropdown:GetHighlightTexture():SetTexCoord(6 / 32, 26 / 32, 6 / 32, 26 / 32);
		FilterDropdown:GetHighlightTexture():SetVertexColor(unpack(T_UIDefinition.textureButtonColorHighlight));
		FilterDropdown:SetScript("OnClick", function(self, button)
			VT.__menulib.ShowMenu(self, "BOTTOMRIGHT", T_TradeSkillFrameFilterMeta);
		end);

		-- Frame.SearchEditBoxOK:SetPoint("TOPRIGHT", Frame, "TOPRIGHT", -46, -6);
		Frame.SearchEditBox:SetPoint("RIGHT", FilterDropdown, "LEFT", -2, 0);
		FilterDropdown:SetPoint("RIGHT", Frame.SearchEditBoxNameOnly, "LEFT", -2, 0);
		Frame.FilterDropdown = FilterDropdown;
	--	Auto filter recipe when trading
		local function LF_ProcessTradeTargetItemLink()
			if Frame.flag == 10 then
				local link = GetTradeTargetItemLink(7);
				if link ~= nil then
					local loc = select(9, GetItemInfo(link));
					if loc ~= nil and ENCHANT_FILTER[loc] then
						Frame.SearchEditBox:SetText(ENCHANT_FILTER[loc]);
						Frame:F_Search(ENCHANT_FILTER[loc]);
					else
						Frame.SearchEditBox:SetText(ENCHANT_FILTER.NONE);
						Frame:F_Search(ENCHANT_FILTER.NONE);
					end
				end
			end
		end
		local EventDriver = CreateFrame('FRAME');
		EventDriver:SetScript("OnEvent", function(self, event, ...)
			return self[event](...);
		end);
		function EventDriver.TRADE_CLOSED()
			Frame.SearchEditBox:SetText("");
		end
		function EventDriver.TRADE_TARGET_ITEM_CHANGED(_1)
			if _1 == 7 then
				LF_ProcessTradeTargetItemLink();
			end
		end
		function EventDriver.TRADE_UPDATE()
			LF_ProcessTradeTargetItemLink();
		end
		-- EventDriver:RegisterEvent("TRADE_SHOW");
		EventDriver:RegisterEvent("TRADE_CLOSED");
		EventDriver:RegisterEvent("TRADE_UPDATE");
		EventDriver:RegisterEvent("TRADE_TARGET_ITEM_CHANGED");
		Frame.EventDriver = EventDriver;
		Frame:HookScript("OnShow", function()
			if TradeSkillFrame:IsShown() then
				MT._TimerStart(LF_ProcessTradeTargetItemLink, 0.2, 1);
			end
		end);
	end
	--
	LF_FrameApplySetting(Frame);
end
local function LF_AddOnCallback_Blizzard_CraftUI(addon)
	-->
		local SetCraftFilter = _G.SetCraftFilter;
		local CraftOnlyShowMakeable = _G.CraftOnlyShowMakeable;

		--
		local GetCraftName = _G.GetCraftName;
		local GetCraftDisplaySkillLine = _G.GetCraftDisplaySkillLine;
		local GetNumCrafts = _G.GetNumCrafts;
		local CloseCraft = _G.CloseCraft;
		local CraftFrame_SetSelection = _G.CraftFrame_SetSelection;
		local GetCraftSelectionIndex = _G.GetCraftSelectionIndex;
		--
		local GetCraftInfo = _G.GetCraftInfo;
		local GetCraftRecipeLink = _G.GetCraftRecipeLink;
		local GetCraftItemLink = _G.GetCraftItemLink;
		local GetCraftIcon = _G.GetCraftIcon;
		local GetCraftDescription = _G.GetCraftDescription;
		local GetCraftSpellFocus = _G.GetCraftSpellFocus;
		--
		--
		local GetCraftNumReagents = _G.GetCraftNumReagents;
		local GetCraftReagentItemLink = _G.GetCraftReagentItemLink;
		local GetCraftReagentInfo = _G.GetCraftReagentInfo;
		local CraftFrame_Update = _G.CraftFrame_Update;


		local CraftFrame = _G.CraftFrame;
		local CraftFramePortrait = _G.CraftFramePortrait;
		local CraftFrameCloseButton = _G.CraftFrameCloseButton;
		local CraftRankFrame = _G.CraftRankFrame;
		local CraftRankFrameBorder = _G.CraftRankFrameBorder;
		local CraftFrameAvailableFilterCheckButton = _G.CraftFrameAvailableFilterCheckButton;
		local CraftFrameFilterDropDown = _G.CraftFrameFilterDropDown;
		local CraftListScrollFrame = _G.CraftListScrollFrame;
		local CraftListScrollFrameScrollBar = _G.CraftListScrollFrameScrollBar;
		local CraftHighlightFrame = _G.CraftHighlightFrame;
		local CraftDetailScrollFrame = _G.CraftDetailScrollFrame;
		local CraftDetailScrollChildFrame = _G.CraftDetailScrollChildFrame;
		local CraftDetailScrollFrameScrollBar = _G.CraftDetailScrollFrameScrollBar;
		local CraftDescription = _G.CraftDescription;

		local CraftIcon = _G.CraftIcon;

		local CraftCreateButton = _G.CraftCreateButton;
		local CraftCancelButton = _G.CraftCancelButton;
	-->

	local meta = {
		HookedFrame = CraftFrame,
		HookedDetailFrame = CraftDetailScrollFrame,
		HookedDetailBar = CraftDetailScrollFrameScrollBar,
		HookedDetailChild = CraftDetailScrollChildFrame,
		HookedScrollFrame = CraftListScrollFrame,
		HookedScrollBar = CraftListScrollFrameScrollBar,
		HookedRankFrame = CraftRankFrame,
		HookedPortrait = CraftFramePortrait,
		T_StyleLayout = {
			normal = {
				frame_size = { 384, 512, },
				anchor = {
					{ "TOPLEFT", CraftFrame, "TOPLEFT", 18, -68, },
					-- { "BOTTOMRIGHT", CraftFrame, "TOPRIGHT", -38, -230, },
				},
				size = { 328, 156, },
				scroll_anchor = {
					{ "TOPLEFT", CraftFrame, "TOPLEFT", 22, -96, },
				},
				scroll_size = { 298, 128, },
				scroll_button_num = 8,
				detail_anchor = {
					{ "TOPLEFT", CraftFrame, "TOPLEFT", 22, -234, },
				},
				detail_size = { 298, 176 },
			},
			expand = {
				frame_size = { 715, 512, },
				anchor = {
					{ "TOPLEFT", CraftFrame, "TOPLEFT", 18, -68, },
				},
				size = { 328, 366, },
				scroll_anchor = {
					{ "TOPLEFT", CraftFrame, "TOPLEFT", 22, -96, },
				},
				scroll_size = { 298, 21 * 16, },
				scroll_button_num = 21,
				detail_anchor = {
					{ "TOPLEFT", nil, "TOPRIGHT", 2, -4, },
				},
				detail_size = { 298, 318, },
			},
			C_VariableName_NumSkillListButton = "CRAFTS_DISPLAYED",
		},
		Widget_AnchorTop = CraftFrameCloseButton,
		Widget_AnchorLeftOfTabFrame = CraftRankFrameBorder,
		Widget_PositionSkippedByInfoInFrame = CraftDescription,
		T_HookedFrameWidgets = {
			backup = {  },
			C_SkillListButtonNamePrefix = "Craft",
			C_SkillListButtonTemplate = "CraftButtonTemplate",
			ProductionIcon = CraftIcon,
			C_ReagentButtonNamePrefix = "CraftReagent",
			T_HookedFrameButtons = {
				CancelButton = CraftCancelButton,
				CreateButton = CraftCreateButton,
				CloseButton = CraftFrameCloseButton,
			},
			T_ButtonModernTexture = {
				CloseButton = T_UIDefinition.texture_modern_button_close,
				IncrementButton = T_UIDefinition.texture_modern_arrow_right,
				DecrementButton = T_UIDefinition.texture_modern_arrow_left,
			},
			T_HookedFrameDropdowns = {
				FilterDropDown = CraftFrameFilterDropDown,
			},
			T_HookedFrameChecks = {
				AvailableFilterCheckButton = CraftFrameAvailableFilterCheckButton,
			},
		},
		T_ToggleOnSkill = {
			CraftFramePointsLabel,
			CraftFramePointsText,
		},

		-- expand = ExpandCraftSkillLine,
		-- collapse = CollapseCraftSkillLine,
		F_ClearFilter = CT.VGT2X and function()
			CraftOnlyShowMakeable(false);
			CraftFrameAvailableFilterCheckButton:SetChecked(false);
			SetCraftFilter(1);
			UIDropDownMenu_SetSelectedID(CraftFrameFilterDropDown, 1);
		end or MT.noop,

		F_IsLinked = function() return false; end,
		F_GetSkillName = GetCraftName,
		F_GetSkillInfo = GetCraftDisplaySkillLine,
		-- F_GetSkillInfo = function(...) return GetCraftDisplaySkillLine(...), DataAgent.MAXRANK, DataAgent.MAXRANK; end,
			--	skillName, cur_rank, max_rank

		F_GetRecipeNumAvailable = GetNumCrafts,
		-- F_DoTradeCraft = DoCraft,
		F_CloseSkill = CloseCraft,
		F_SetSelection = CraftFrame_SetSelection,		-- SelectCraft
		F_GetSelection = GetCraftSelectionIndex,

		F_GetRecipeInfo = function(arg1) local _1, _2, _3, _4, _5, _6, _7 = GetCraftInfo(arg1); return _1, _3, _4, _5, _6, _7; end,
			--	craftName, craftSubSpellName(""), difficult, numAvailable, isExpanded, trainingPointCost, requiredLevel = GetCraftInfo(index)
		F_GetRecipeSpellID = CT.VGT3X and function(arg1) local link = GetCraftRecipeLink(arg1); return link and tonumber(strmatch(link, "[a-zA-Z]:(%d+)")) or nil; end or nil,
		F_GetRecipeItemID = function(arg1) local link = GetCraftItemLink(arg1); return link and tonumber(strmatch(link, "[a-zA-Z]:(%d+)")) or nil; end,
		F_GetRecipeItemLink = GetCraftItemLink,
		F_GetRecipeIcon = GetCraftIcon,
		F_GetRecipeDesc = GetCraftDescription,
		F_GetRecipeTools = GetCraftSpellFocus,
		F_GetRecipeCooldown = function() return nil; end,
		F_GetRecipeNumMade = function() return 1, 1; end,

		F_GetRecipeNumReagents = GetCraftNumReagents,
		F_GetRecipeReagentLink = GetCraftReagentItemLink,
		F_GetRecipeReagentID = function(i, j) return tonumber(strmatch(GetCraftReagentItemLink(i, j), "[a-zA-Z]:(%d+)")); end,
		F_GetRecipeReagentInfo = GetCraftReagentInfo,
			-- name, texture, numRequired, numHave = GetCraftReagentInfo(tradeSkillRecipeId, reagentId);

		F_HookedFrameUpdate = CraftFrame_Update,
		T_MonitoredEvents = {
			-- "NEW_RECIPE_LEARNED",
			-- "CRAFT_SHOW",
			"CRAFT_UPDATE",
		},

		F_WithDisabledFrame = function(self, func)
			if CT.VGT2X then
				func(CraftFrameAvailableFilterCheckButton);
				func(CraftFrameFilterDropDown);
			end
			func(CraftListScrollFrame);
			func(CraftListScrollFrameScrollBar);
			func(CraftHighlightFrame);
			local T_SkillListButtons = self.T_SkillListButtons;
			if T_SkillListButtons ~= nil then
				for index = 1, #T_SkillListButtons do
					func(T_SkillListButtons[index]);
				end
			end
		end,
		T_DisabledFunc = {  },
		T_DisabledFuncName = {
			"CollapseCraftSkillLine",
			-- "ExpandCraftSkillLine",
		},

		T_FunctionName = {
			F_SetSelection = "CraftFrame_SetSelection",
		},
	};
	local Frame = LF_HookFrame(addon, meta);
	VT.UIFrames[addon] = Frame;
	--
	if CT.VGT2X then
		CraftFrameAvailableFilterCheckButton:ClearAllPoints();
		CraftFrameAvailableFilterCheckButton:SetPoint("TOPLEFT", CraftFrame, "TOPLEFT", 68, -56);
		CraftFrameAvailableFilterCheckButton:SetSize(20, 20);
		CraftFrameFilterDropDown:ClearAllPoints();
		CraftFrameFilterDropDown:SetPoint("RIGHT", CraftFrame, "TOPLEFT", 359, -82);
	end
	--
	local ENCHANT_FILTER = l10n.ENCHANT_FILTER;
	--	Dropdown Filter
		local T_CraftFrameFilterMeta = {
			handler = function(_, _, key)
				local text = ENCHANT_FILTER[key];
				if text ~= nil then
					Frame:F_Search(text);
				end
			end,
			num = 7,
			{	--	"披风"
				text = ENCHANT_FILTER.INVTYPE_CLOAK,
				param = "INVTYPE_CLOAK",
			},
			{	--	"胸甲"
				text = ENCHANT_FILTER.INVTYPE_CHEST,
				param = "INVTYPE_CHEST",
			},
			{	--	"护腕"
				text = ENCHANT_FILTER.INVTYPE_WRIST,
				param = "INVTYPE_WRIST",
			},
			{	--	"手套"
				text = ENCHANT_FILTER.INVTYPE_HAND,
				param = "INVTYPE_HAND",
			},
			{	--	"靴"
				text = ENCHANT_FILTER.INVTYPE_FEET,
				param = "INVTYPE_FEET",
			},
			{	--	"武器"
				text = ENCHANT_FILTER.INVTYPE_WEAPON,
				param = "INVTYPE_WEAPON",
			},
			{	--	"盾牌"
				text = ENCHANT_FILTER.INVTYPE_SHIELD,
				param = "INVTYPE_SHIELD",
			},
			-- {	--	"没有匹配的附魔"
			-- 	text = ENCHANT_FILTER.NONE,
			-- 	param = "NONE",
			-- },
		};
		local FilterDropdown = CreateFrame('BUTTON', nil, Frame);
		FilterDropdown:SetSize(16, 16);
		FilterDropdown:EnableMouse(true);
		FilterDropdown:SetNormalTexture([[Interface\MainMenuBar\UI-MainMenu-ScrollDownButton-UP]]);
		FilterDropdown:GetNormalTexture():SetTexCoord(6 / 32, 26 / 32, 6 / 32, 26 / 32);
		FilterDropdown:SetPushedTexture([[Interface\MainMenuBar\UI-MainMenu-ScrollDownButton-UP]]);
		FilterDropdown:GetPushedTexture():SetTexCoord(6 / 32, 26 / 32, 6 / 32, 26 / 32);
		FilterDropdown:GetPushedTexture():SetVertexColor(unpack(T_UIDefinition.textureButtonColorPushed));
		FilterDropdown:SetHighlightTexture([[Interface\MainMenuBar\UI-MainMenu-ScrollDownButton-UP]]);
		FilterDropdown:GetHighlightTexture():SetTexCoord(6 / 32, 26 / 32, 6 / 32, 26 / 32);
		FilterDropdown:GetHighlightTexture():SetVertexColor(unpack(T_UIDefinition.textureButtonColorHighlight));
		FilterDropdown:SetScript("OnClick", function(self, button)
			VT.__menulib.ShowMenu(self, "BOTTOMRIGHT", T_CraftFrameFilterMeta);
		end);

		-- Frame.SearchEditBoxOK:SetPoint("TOPRIGHT", Frame, "TOPRIGHT", -46, -6);
		Frame.SearchEditBox:SetPoint("RIGHT", FilterDropdown, "LEFT", -2, 0);
		FilterDropdown:SetPoint("RIGHT", Frame.SearchEditBoxNameOnly, "LEFT", -2, 0);
		Frame.FilterDropdown = FilterDropdown;
	--	Auto filter recipe when trading
		local function LF_ProcessTradeTargetItemLink()
			local link = GetTradeTargetItemLink(7);
			if link ~= nil then
				local loc = select(9, GetItemInfo(link));
				if loc ~= nil and ENCHANT_FILTER[loc] then
					Frame.SearchEditBox:SetText(ENCHANT_FILTER[loc]);
					Frame:F_Search(ENCHANT_FILTER[loc]);
				else
					Frame.SearchEditBox:SetText(ENCHANT_FILTER.NONE);
					Frame:F_Search(ENCHANT_FILTER.NONE);
				end
			end
		end
		local EventDriver = CreateFrame('FRAME');
		EventDriver:SetScript("OnEvent", function(self, event, ...)
			return self[event](...);
		end);
		function EventDriver.TRADE_CLOSED()
			Frame.SearchEditBox:SetText("");
		end
		function EventDriver.TRADE_TARGET_ITEM_CHANGED(_1)
			if _1 == 7 then
				LF_ProcessTradeTargetItemLink();
			end
		end
		function EventDriver.TRADE_UPDATE()
			LF_ProcessTradeTargetItemLink();
		end
		-- EventDriver:RegisterEvent("TRADE_SHOW");
		EventDriver:RegisterEvent("TRADE_CLOSED");
		EventDriver:RegisterEvent("TRADE_UPDATE");
		EventDriver:RegisterEvent("TRADE_TARGET_ITEM_CHANGED");
		Frame.EventDriver = EventDriver;
		Frame:HookScript("OnShow", function()
			if CraftFrame:IsShown() then
				MT._TimerStart(LF_ProcessTradeTargetItemLink, 0.2, 1);
			end
		end);
	--
	LF_FrameApplySetting(Frame);
end
--	Explorer
	local function LF_ExplorerCreateSkillListButton(parent, index, buttonHeight)
		local Button = CreateFrame('BUTTON', nil, parent);
		Button:SetHeight(buttonHeight);
		VT.__uireimp._SetSimpleBackdrop(Button, 0, 1, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0);
		Button:SetHighlightTexture(T_UIDefinition.texture_white);
		Button:GetHighlightTexture():SetVertexColor(unpack(T_UIDefinition.listButtonHighlightColor));
		Button:EnableMouse(true);
		Button:Show();

		local Icon = Button:CreateTexture(nil, "BORDER");
		Icon:SetTexture(T_UIDefinition.texture_unk);
		Icon:SetSize(buttonHeight - 4, buttonHeight - 4);
		Icon:SetPoint("LEFT", 8, 0);
		Button.Icon = Icon;

		local Title = Button:CreateFontString(nil, "OVERLAY");
		Title:SetFont(T_UIDefinition.frameNormalFont, T_UIDefinition.frameNormalFontSize, T_UIDefinition.frameNormalFontFlag);
		Title:SetPoint("LEFT", Icon, "RIGHT", 4, 0);
		-- Title:SetWidth(160);
		Title:SetMaxLines(1);
		Title:SetJustifyH("LEFT");
		Button.Title = Title;

		local Note = Button:CreateFontString(nil, "ARTWORK");
		Note:SetFont(T_UIDefinition.frameNormalFont, T_UIDefinition.frameNormalFontSize, T_UIDefinition.frameNormalFontFlag);
		Note:SetPoint("RIGHT", -4, 0);
		Button.Note = Note;

		Title:SetPoint("RIGHT", Note, "LEFT", -4, 0);

		local QualityGlow = Button:CreateTexture(nil, "ARTWORK");
		QualityGlow:SetTexture([[Interface\Buttons\UI-ActionButton-Border]]);
		QualityGlow:SetBlendMode("ADD");
		QualityGlow:SetTexCoord(0.25, 0.75, 0.25, 0.75);
		QualityGlow:SetSize(buttonHeight - 2, buttonHeight - 2);
		QualityGlow:SetPoint("CENTER", Icon);
		-- QualityGlow:SetAlpha(0.75);
		QualityGlow:Show();
		Button.QualityGlow = QualityGlow;

		local Star = Button:CreateTexture(nil, "OVERLAY");
		Star:SetTexture([[Interface\Collections\Collections]]);
		Star:SetTexCoord(100 / 512, 118 / 512, 10 / 512, 28 / 512);
		Star:SetSize(buttonHeight * 0.75, buttonHeight * 0.75);
		Star:SetPoint("CENTER", Button, "TOPLEFT", buttonHeight * 0.25, -buttonHeight * 0.25);
		Star:Hide();
		Button.Star = Star;

		local SelectionGlow = Button:CreateTexture(nil, "OVERLAY");
		SelectionGlow:SetTexture(T_UIDefinition.texture_white);
		-- SelectionGlow:SetTexCoord(0.25, 0.75, 0.25, 0.75);
		SelectionGlow:SetVertexColor(unpack(T_UIDefinition.listButtonSelectedColor));
		SelectionGlow:SetAllPoints();
		SelectionGlow:SetBlendMode("ADD");
		SelectionGlow:Hide();
		Button.SelectionGlow = SelectionGlow;

		Button:SetScript("OnEnter", LT_SharedMethod.SkillListButton_OnEnter);
		Button:SetScript("OnLeave", LT_SharedMethod.SkillListButton_OnLeave);
		Button:RegisterForClicks("AnyUp");
		Button:SetScript("OnClick", LT_SharedMethod.SkillListButton_OnClick);
		Button:RegisterForDrag("LeftButton");
		Button:SetScript("OnHide", VT.__menulib.ShowMenu);

		function Button:Select()
			SelectionGlow:Show();
		end
		function Button:Deselect()
			SelectionGlow:Hide();
		end

		local Frame = parent:GetParent():GetParent();
		Button.Frame = Frame;
		Button.list = Frame.list;
		Button.flag = Frame.flag;

		return Button;
	end
	local function LF_ExplorerSetSkillListButton(Button, data_index)
		local Frame = Button.Frame;
		local list = Button.list;
		local hash = Frame.hash;
		if data_index <= #list then
			local sid = list[data_index];
			local cid = DataAgent.get_cid_by_sid(sid);
			Button:Show();
			local _, quality, icon;
			if cid then
				_, _, quality, _, icon = DataAgent.item_info(cid);
			else
				quality = nil;
				icon = ICON_FOR_NO_CID;
			end
			Button.Icon:SetTexture(icon);
			Button.Title:SetText(DataAgent.spell_name_s(sid));
			if hash[sid] then
				Button.Icon:SetVertexColor(1.0, 1.0, 1.0, 1.0);
				Button.Title:SetTextColor(0.0, 1.0, 0.0, 1.0);
			else
				Button.Icon:SetVertexColor(1.0, 0.0, 0.0, 1.0);
				Button.Title:SetTextColor(1.0, 0.0, 0.0, 1.0);
			end
			local set = VT.SET.explorer;
			if set.showRank then
				Button.Note:SetText(DataAgent.get_difficulty_rank_list_text_by_sid(sid, false));
			else
				Button.Note:SetText("");
			end
			if quality then
				local r, g, b, code = GetItemQualityColor(quality);
				Button.QualityGlow:SetVertexColor(r, g, b);
				Button.QualityGlow:Show();
			else
				Button.QualityGlow:Hide();
			end
			if VT.FAV[sid] then
				Button.Star:Show();
			else
				Button.Star:Hide();
			end
			if GetMouseFocus() == Button then
				LT_SharedMethod.SkillListButton_OnEnter(Button);
			end
			Button:Deselect();
			if Button.prev_sid ~= sid then
				VT.__menulib.ShowMenu(Button);
				Button.prev_sid = sid;
			end
		else
			VT.__menulib.ShowMenu(Button);
			Button:Hide();
		end
	end
--
local function LF_CreateExplorerFrame()
	local Frame = CreateFrame('FRAME', "ALA_TRADESKILL_EXPLORER", UIParent);
	tinsert(UISpecialFrames, "ALA_TRADESKILL_EXPLORER");

	do	--	Frame
		Frame:SetSize(T_UIDefinition.explorerWidth, T_UIDefinition.explorerHeight);
		Frame:SetFrameStrata("HIGH");
		Frame:SetPoint("CENTER", 0, 0);
		Frame:EnableMouse(true);
		Frame:SetMovable(true);
		Frame:RegisterForDrag("LeftButton");
		Frame:SetScript("OnDragStart", function(self)
			self:StartMoving();
		end);
		Frame:SetScript("OnDragStop", function(self)
			self:StopMovingOrSizing();
		end);
		Frame:SetScript("OnShow", function(self)
			Frame.F_Update();
		end);
		Frame:Hide();

		function Frame.F_Update()
			LT_SharedMethod.UpdateExplorerFrame(Frame, true);
		end
		Frame.list = {  };
		Frame.hash = DataAgent.LearnedRecipesHash;
		Frame.flag = 'explorer';

		local Title = Frame:CreateFontString(nil, "ARTWORK");
		Title:SetFont(T_UIDefinition.frameNormalFont, T_UIDefinition.frameNormalFontSize, T_UIDefinition.frameNormalFontFlag);
		Title:SetPoint("CENTER", Frame, "TOP", 0, -16);
		Title:SetText(l10n["EXPLORER_TITLE"]);

		local ScrollFrame = VT.__scrolllib.CreateScrollFrame(Frame, nil, nil, T_UIDefinition.skillListButtonHeight, LF_ExplorerCreateSkillListButton, LF_ExplorerSetSkillListButton);
		ScrollFrame:SetPoint("BOTTOMLEFT", 6, 12);
		ScrollFrame:SetPoint("TOPRIGHT", -10, -56);
		Frame.ScrollFrame = ScrollFrame;

		local CloseButton = CreateFrame('BUTTON', nil, Frame, "UIPanelCloseButton");
		CloseButton:SetSize(32, 32);
		CloseButton:SetPoint("CENTER", Frame, "TOPRIGHT", -18, -16);
		CloseButton:SetScript("OnClick", function()
			Frame:Hide();
		end);
		Frame.CloseButton = CloseButton;

		LT_SharedMethod.ModifyALAScrollFrame(ScrollFrame);

		Frame.F_SetStyle = LT_FrameMethod.F_ExplorerSetStyle;
	end

	do	--	search_box
		local SearchEditBox, SearchEditBoxOK, SearchEditBoxNameOnly = LT_SharedMethod.UICreateSearchBox(Frame);
		SearchEditBox:SetPoint("TOPLEFT", Frame, "TOPLEFT", 10, -32);
		SearchEditBox:SetPoint("RIGHT", SearchEditBoxNameOnly, "LEFT", -4, 0);
		SearchEditBoxNameOnly:SetPoint("RIGHT", SearchEditBoxOK, "LEFT", -4, 0);
		SearchEditBoxOK:SetPoint("TOPRIGHT", Frame, "TOPRIGHT", -52, -32);
	end

	do	--	ProfitFrame
		local ProfitFrame = CreateFrame('FRAME', nil, Frame);
		ProfitFrame:SetFrameStrata("HIGH");
		ProfitFrame:EnableMouse(true);
		ProfitFrame:Hide();
		ProfitFrame:SetWidth(400);
		ProfitFrame:SetPoint("TOPLEFT", Frame, "TOPRIGHT", 2, 0);
		ProfitFrame:SetPoint("BOTTOMLEFT", Frame, "BOTTOMRIGHT", 2, 0);
		ProfitFrame.list = {  };
		ProfitFrame.flag = 'explorer';
		Frame.ProfitFrame = ProfitFrame;
		ProfitFrame.Frame = Frame;

		local ToggleButton = CreateFrame('BUTTON', nil, Frame);
		ToggleButton:SetSize(20, 20);
		ToggleButton:SetNormalTexture(T_UIDefinition.texture_profit);
		ToggleButton:SetPushedTexture(T_UIDefinition.texture_profit);
		ToggleButton:GetPushedTexture():SetVertexColor(unpack(T_UIDefinition.textureButtonColorPushed));
		ToggleButton:SetHighlightTexture(T_UIDefinition.texture_profit);
		ToggleButton:GetHighlightTexture():SetVertexColor(unpack(T_UIDefinition.textureButtonColorHighlight));
		ToggleButton:SetPoint("TOPRIGHT", Frame, "TOPRIGHT", -30, -32);
		ToggleButton:SetScript("OnEnter", LT_SharedMethod.ButtonInfoOnEnter);
		ToggleButton:SetScript("OnLeave", LT_SharedMethod.ButtonInfoOnLeave);
		ToggleButton.info_lines = { l10n["TIP_PROFIT_FRAME_CALL_INFO"] };
		ToggleButton:SetScript("OnClick", LT_WidgetMethod.ProfitFrameToggleButton_OnClick);
		ProfitFrame.ToggleButton = ToggleButton;
		ToggleButton.ProfitFrame = ProfitFrame;
		ToggleButton.Frame = Frame;

		ProfitFrame:SetScript("OnShow", LT_WidgetMethod.ProfitFrame_OnShow);
		ProfitFrame:SetScript("OnHide", LT_WidgetMethod.ProfitFrame_OnHide);

		local ScrollFrame = VT.__scrolllib.CreateScrollFrame(ProfitFrame, nil, nil, T_UIDefinition.skillListButtonHeight, LT_SharedMethod.ProfitCreateSkillListButton, LT_SharedMethod.ProfitSetSkillListButton);
		ScrollFrame:SetPoint("BOTTOMLEFT", 4, 8);
		ScrollFrame:SetPoint("TOPRIGHT", -8, -28);
		ProfitFrame.ScrollFrame = ScrollFrame;

		--[[
		local CostOnlyCheck = CreateFrame('CHECKBUTTON', nil, ProfitFrame, "OptionsBaseCheckButtonTemplate");
		CostOnlyCheck:SetSize(24, 24);
		CostOnlyCheck:SetHitRectInsets(0, 0, 0, 0);
		CostOnlyCheck:SetPoint("CENTER", ProfitFrame, "TOPLEFT", 17, -10);
		CostOnlyCheck:Show();
		local Text = ProfitFrame:CreateFontString(nil, "ARTWORK");
		Text:SetFont(T_UIDefinition.frameNormalFont, T_UIDefinition.frameNormalFontSize, T_UIDefinition.frameNormalFontFlag);
		Text:SetPoint("LEFT", CostOnlyCheck, "RIGHT", 2, 0);
		Text:SetText(l10n["PROFIT_SHOW_COST_ONLY"]);
		CostOnlyCheck.Text = Text;
		CostOnlyCheck:SetScript("OnClick", function(self)
			local checked = self:GetChecked();
			VT.SET.explorer.PROFIT_SHOW_COST_ONLY = checked;
			LT_SharedMethod.UpdateProfitFrame(Frame);
		end);
		ProfitFrame.CostOnlyCheck = CostOnlyCheck;
		--]]

		local CloseButton = CreateFrame('BUTTON', nil, ProfitFrame, "UIPanelCloseButton");
		CloseButton:SetSize(32, 32);
		CloseButton:SetPoint("CENTER", ProfitFrame, "TOPRIGHT", -18, -14);
		CloseButton:SetScript("OnClick", LT_WidgetMethod.ProfitFrameCloseButton_OnClick);
		ProfitFrame.CloseButton = CloseButton;
		CloseButton.Frame = Frame;

		LT_SharedMethod.ModifyALAScrollFrame(Frame.ProfitFrame.ScrollFrame);

		Frame.F_ShowProfitFrame = LT_FrameMethod.F_ExplorerShowProfitFrame;
		Frame.F_HideProfitFrame = LT_FrameMethod.F_ExplorerHideProfitFrame;
	end

	do	--	SetFrame
		local SetFrame = CreateFrame('FRAME', nil, Frame);
		SetFrame:SetFrameStrata("HIGH");
		SetFrame:SetHeight(82);
		SetFrame:SetPoint("LEFT", Frame);
		SetFrame:SetPoint("RIGHT", Frame);
		SetFrame:SetPoint("BOTTOM", Frame, "TOP", 0, 1);
		SetFrame:Hide();
		Frame.SetFrame = SetFrame;
		SetFrame.Frame = Frame;

		local TipInfo = SetFrame:CreateFontString(nil, "ARTWORK");
		TipInfo:SetFont(T_UIDefinition.frameNormalFont, T_UIDefinition.frameNormalFontSize - 1, T_UIDefinition.frameNormalFontFlag);
		TipInfo:SetPoint("RIGHT", SetFrame, "BOTTOMRIGHT", -2, 9);
		SetFrame.TipInfo = TipInfo;

		local ToggleButton = CreateFrame('BUTTON', nil, Frame);
		ToggleButton:SetSize(16, 16);
		ToggleButton:SetNormalTexture(T_UIDefinition.texture_config);
		ToggleButton:SetPushedTexture(T_UIDefinition.texture_config);
		ToggleButton:GetPushedTexture():SetVertexColor(unpack(T_UIDefinition.textureButtonColorPushed));
		ToggleButton:SetHighlightTexture(T_UIDefinition.texture_config);
		ToggleButton:GetHighlightTexture():SetVertexColor(unpack(T_UIDefinition.textureButtonColorHighlight));
		ToggleButton:SetPoint("TOPRIGHT", Frame, "TOPRIGHT", -10, -32);
		ToggleButton:SetScript("OnClick", LT_WidgetMethod.SetFrameToggleButton_OnClick);
		SetFrame.ToggleButton = ToggleButton;
		ToggleButton.SetFrame = SetFrame;
		ToggleButton.Frame = Frame;

		SetFrame:SetScript("OnShow", LT_WidgetMethod.SetFrame_OnShow);
		SetFrame:SetScript("OnHide", LT_WidgetMethod.SetFrame_OnHide);

		local T_CheckButtons = {  };
		local T_KeyTables = { "showUnkown", "showKnown", "showItemInsteadOfSpell", "showRank", };
		for index = 1, #T_KeyTables do
			local key = T_KeyTables[index];
			local CheckButton = CreateFrame('CHECKBUTTON', nil, SetFrame, "OptionsBaseCheckButtonTemplate");
			CheckButton:SetSize(24, 24);
			CheckButton:SetHitRectInsets(0, 0, 0, 0);
			CheckButton:Show();
			CheckButton:SetChecked(false);

			local Text = SetFrame:CreateFontString(nil, "ARTWORK");
			Text:SetFont(T_UIDefinition.frameNormalFont, T_UIDefinition.frameNormalFontSize, T_UIDefinition.frameNormalFontFlag);
			Text:SetText(l10n[key]);
			Text:SetPoint("LEFT", CheckButton, "RIGHT", 0, 0);
			CheckButton.Text = Text;

			if index % 4 == 1 then
				if index == 1 then
					CheckButton:SetPoint("CENTER", SetFrame, "TOPLEFT", 16, -12);
				else
					CheckButton:SetPoint("CENTER", T_CheckButtons[index - 3], "CENTER", 0, -24);
				end
			else
				CheckButton:SetPoint("CENTER", T_CheckButtons[index - 1], "CENTER", 94, 0);
			end
			if index == 1 or index == 2 then
				CheckButton:SetScript("OnClick", function(self)
					VT.SET.explorer[key] = self:GetChecked()
					Frame.F_Update();
				end);
			else
				CheckButton:SetScript("OnClick", function(self)
					VT.SET.explorer[key] = self:GetChecked()
					Frame.ScrollFrame:Update();
				end);
			end
			CheckButton.key = key;
			local TipText = l10n[key .. "Tip"];
			if TipText ~= nil then
				CheckButton.TipText = TipText;
				CheckButton:SetScript("OnEnter", LT_WidgetMethod.SetFrameCheckButton_OnEnter);
				CheckButton:SetScript("OnLeave", LT_WidgetMethod.SetFrameCheckButton_OnLeave);
			end
			local TipText = l10n[key .. "Tip"];
			T_CheckButtons[#T_CheckButtons + 1] = CheckButton;
			CheckButton.TipInfo = TipInfo;
			CheckButton.Frame = Frame;
		end
		SetFrame.T_CheckButtons = T_CheckButtons;

		local T_Dropdowns = {  };
		local T_KeyTables = { "Skill", "Type", "SubType", "EquipLoc", };
		for index = 1, #T_KeyTables do
			local key = T_KeyTables[index];
			local Dropdown = CreateFrame('BUTTON', nil, SetFrame);
			Dropdown:SetSize(20, 20);
			Dropdown:EnableMouse(true);
			Dropdown:SetNormalTexture([[Interface\MainMenuBar\UI-MainMenu-ScrollDownButton-UP]]);
			Dropdown:GetNormalTexture():SetTexCoord(6 / 32, 26 / 32, 6 / 32, 26 / 32);
			Dropdown:SetPushedTexture([[Interface\MainMenuBar\UI-MainMenu-ScrollDownButton-UP]]);
			Dropdown:GetPushedTexture():SetTexCoord(6 / 32, 26 / 32, 6 / 32, 26 / 32);
			Dropdown:GetPushedTexture():SetVertexColor(unpack(T_UIDefinition.textureButtonColorPushed));
			Dropdown:SetHighlightTexture([[Interface\MainMenuBar\UI-MainMenu-ScrollDownButton-UP]]);
			Dropdown:GetHighlightTexture():SetTexCoord(6 / 32, 26 / 32, 6 / 32, 26 / 32);
			Dropdown:GetHighlightTexture():SetVertexColor(unpack(T_UIDefinition.textureButtonColorHighlight));

			local Label = SetFrame:CreateFontString(nil, "ARTWORK");
			Label:SetFont(T_UIDefinition.frameNormalFont, T_UIDefinition.frameNormalFontSize, T_UIDefinition.frameNormalFontFlag);
			Label:SetText(l10n.EXPLORER_SET[key]);
			Label:SetPoint("LEFT", Dropdown, "RIGHT", 0, 0);
			Dropdown.Label = Label;

			local Cancel = CreateFrame('BUTTON', nil, SetFrame);
			Cancel:SetSize(16, 16);
			Cancel:SetNormalTexture([[Interface\Buttons\UI-GroupLoot-Pass-UP]]);
			Cancel:SetPushedTexture([[Interface\Buttons\UI-GroupLoot-Pass-UP]]);
			Cancel:GetPushedTexture():SetVertexColor(unpack(T_UIDefinition.textureButtonColorPushed));
			Cancel:SetHighlightTexture([[Interface\Buttons\UI-GroupLoot-Pass-UP]]);
			Cancel:GetHighlightTexture():SetVertexColor(unpack(T_UIDefinition.textureButtonColorHighlight));
			Cancel:SetPoint("TOP", Dropdown, "BOTTOM", 0, -1);
			Cancel:SetScript("OnClick", function(self)
				local filter = VT.SET.explorer.filter;
				if filter[key] ~= nil then
					filter[key] = nil;
					if key == 'Type' then
						filter.SubType = nil;
					end
					Frame.F_Update();
				end
			end);
			Cancel.key = key;
			Dropdown.Cancel = Cancel;

			local Text = SetFrame:CreateFontString(nil, "ARTWORK");
			Text:SetFont(T_UIDefinition.frameNormalFont, T_UIDefinition.frameNormalFontSize, T_UIDefinition.frameNormalFontFlag);
			Text:SetText(l10n[key]);
			Text:SetPoint("LEFT", Cancel, "RIGHT", 2, 0);
			Text:SetVertexColor(0.0, 1.0, 0.0, 1.0);
			Dropdown.Text = Text;

			if index % 4 == 1 then
				if index == 1 then
					Dropdown:SetPoint("CENTER", T_CheckButtons[1], "CENTER", 0, -24);
				else
					Dropdown:SetPoint("TOPLEFT", T_Dropdowns[index - 3], "BOTTOMLEFT", 0, 0);
				end
			else
				Dropdown:SetPoint("CENTER", T_Dropdowns[index - 1], "CENTER", 94, 0);
			end
			Dropdown:SetScript("OnClick", LT_WidgetMethod.ExplorerSetFrameDropdown_OnClick);
			Dropdown.key = key;
			Dropdown.Frame = Frame;
			T_Dropdowns[#T_Dropdowns + 1] = Dropdown;
		end
		SetFrame.T_Dropdowns = T_Dropdowns;

		local PhaseSlider = CreateFrame('SLIDER', nil, SetFrame, "OptionsSliderTemplate");
		PhaseSlider:SetPoint("BOTTOM", SetFrame, "TOP", 0, 12);
		PhaseSlider:SetPoint("LEFT", 4, 0);
		PhaseSlider:SetPoint("RIGHT", -4, 0);
		PhaseSlider:SetHeight(20);
		PhaseSlider:SetMinMaxValues(1, DataAgent.MAXPHASE);
		PhaseSlider:SetValueStep(1);
		PhaseSlider:SetObeyStepOnDrag(true);
		PhaseSlider.Text:ClearAllPoints();
		PhaseSlider.Text:SetPoint("TOP", PhaseSlider, "BOTTOM", 0, 3);
		PhaseSlider.Low:ClearAllPoints();
		PhaseSlider.Low:SetPoint("TOPLEFT", PhaseSlider, "BOTTOMLEFT", 4, 3);
		PhaseSlider.High:ClearAllPoints();
		PhaseSlider.High:SetPoint("TOPRIGHT", PhaseSlider, "BOTTOMRIGHT", -4, 3);
		PhaseSlider.Low:SetText("|cff00ff001|r");
		PhaseSlider.High:SetText("|cffff0000" .. DataAgent.MAXPHASE .. "|r");
		PhaseSlider:HookScript("OnValueChanged", function(self, value, userInput)
			if userInput then
				VT.SET.explorer.phase = value;
				Frame.F_Update();
			end
			self.Text:SetText("|cffffff00" .. l10n["phase"] .. "|r " .. value);
		end);
		SetFrame.PhaseSlider = PhaseSlider;

		Frame.F_ShowSetFrame = LT_FrameMethod.F_ExplorerShowSetFrame;
		Frame.F_HideSetFrame = LT_FrameMethod.F_ExplorerHideSetFrame;
		Frame.F_RefreshSetFrame = LT_FrameMethod.F_ExplorerRefreshSetFrame;

	end

	ALA_HOOK_ChatEdit_InsertLink(function(link, addon)
		if Frame:IsShown() and addon ~= __addon and not (BrowseName ~= nil and BrowseName:IsVisible()) then
			local name = GetItemInfo(link);
			if name and name ~= "" then
				Frame.SearchEditBox:SetText(name);
				Frame.SearchEditBox:ClearFocus();
				Frame:F_Search(name);
				return true;
			end
		end
	end);
	ALA_HOOK_ChatEdit_InsertName(function(name, addon)
		if Frame:IsShown() and addon ~= __addon and not (BrowseName ~= nil and BrowseName:IsVisible()) then
			if name and name ~= "" then
				Frame.SearchEditBox:SetText(name);
				Frame.SearchEditBox:ClearFocus();
				Frame:F_Search(name);
				return true;
			end
		end
	end);

	local function callback()
		Frame.ScrollFrame:Update();
		LT_SharedMethod.UpdateProfitFrame(Frame);
	end
	-- if VT.AuctionMod ~= nil and VT.AuctionMod.F_OnDBUpdate ~= nil then
	-- 	VT.AuctionMod.F_OnDBUpdate(callback);
	-- end
	MT.AddCallback("AUCTION_MOD_LOADED", function(mod)
		if mod ~= nil then
			if mod.F_OnDBUpdate then
				mod.F_OnDBUpdate(callback);
			end
			-- callback();
		end
	end);

	return Frame;
end
--	Board
	local T_BoardDropMeta = {
		num = 2,
		{
			handler = function()
				VT.SET.lock_board = true;
				VT.UIFrames["BOARD"]:F_Lock();
			end,
			param = {  },
			text = l10n["BOARD_LOCK"],
		},
		{
			handler = function()
				VT.SET.show_board = false;
				VT.UIFrames["BOARD"]:Hide();
			end,
			param = {  },
			text = l10n["BOARD_CLOSE"],
		},
	};
	local function LF_FormatTime(sec)
		local p = max(0.0, 1.0 - sec / 1800);
		local r = 0.0;
		local g = 0.0;
		if p > 0.5 then
			r = (1.0 - p) * 255.0;
			g = 255.0;
		else
			r = 255.0;
			g = p * 255;
		end
		--
		local d = sec / 86400;
		d = d - d % 1.0;
		sec = sec % 86400;
		local h = sec / 3600;
		h = h - h % 1.0;
		sec = sec % 3600;
		local m = sec / 60;
		m = m - m % 1.0;
		sec = sec % 60;
		if d > 0 then
			return format(l10n["COLORED_FORMATTED_TIME_LEN"][1], r, g, d, h, m, sec);
		elseif h > 0 then
			return format(l10n["COLORED_FORMATTED_TIME_LEN"][2], r, g, h, m, sec);
		elseif m > 0 then
			return format(l10n["COLORED_FORMATTED_TIME_LEN"][3], r, g, m, sec);
		else
			return format(l10n["COLORED_FORMATTED_TIME_LEN"][4], r, g, sec);
		end
	end
	local function LF_CalendarSetHeader(sid)			--	tex, coord, title, color
		return DataAgent.get_texture_by_pid(DataAgent.get_pid_by_sid(sid)), nil, DataAgent.spell_name_s(sid), nil;
	end
	local function LF_CalendarSetLine(sid, GUID)		--	tex, coord, title, color_title, cool, color_cool
		local lClass, class, lRace, race, sex, name = GetPlayerInfoByGUID(GUID);
		local cool;
		do
			local pid = DataAgent.get_pid_by_sid(sid);
			if pid ~= nil then
				local VAR = VT.AVAR[GUID];
				if VAR ~= nil then
					local var = rawget(VAR, pid);
					if var ~= nil then
						local c = var[3];
						if c ~= nil then
							cool = c[sid];
							if cool ~= nil then
								if cool > 0 then
									local diff = cool - GetServerTime();
									if diff > 0 then
										cool = LF_FormatTime(diff);
									else
										cool = l10n["COOLDOWN_EXPIRED"];
									end
								else
									cool = l10n["COOLDOWN_EXPIRED"];
								end
							end
						end
					end
				end
			end
		end
		if cool then
			if name and class then
				return nil, nil, name, RAID_CLASS_COLORS[strupper(class)], cool;
			else
				return nil, nil, GUID, nil, cool;
			end
		else
			if name and class then
				return nil, nil, name, RAID_CLASS_COLORS[strupper(class)];
			else
				return nil, nil, GUID, nil;
			end
		end
	end
	local function LF_UpdateBoard()
		local Frame = VT.UIFrames["BOARD"];
		if Frame:IsShown() then
			Frame:F_Clear();
			for GUID, VAR in next, VT.AVAR do
				local add_label = true;
				for pid = DataAgent.DBMINPID, DataAgent.DBMAXPID do
					local var = rawget(VAR, pid);
					if var and DataAgent.is_pid(pid) then
						local cool = var[3];
						if cool and next(cool) ~= nil then
							if add_label then
								add_label = false;
								local lClass, class, lRace, race, sex, name = GetPlayerInfoByGUID(GUID);
								if name and class then
									local classColorTable = RAID_CLASS_COLORS[strupper(class)];
									name = format(">>|cff%.2x%.2x%.2x", classColorTable.r * 255, classColorTable.g * 255, classColorTable.b * 255) .. name .. "|r<<";
									Frame:F_AddLine(nil, name);
								else
									Frame:F_AddLine(nil, GUID);
								end
							end
							local texture = DataAgent.get_texture_by_pid(pid);
							if var.cur_rank and var.max_rank then
								Frame:F_AddLine("|T" .. (texture or T_UIDefinition.texture_unk) .. ":12:12:0:0|t " .. (DataAgent.get_pname_by_pid(pid) or ""), nil, var.cur_rank .. " / " .. var.max_rank);
							else
								Frame:F_AddLine("|T" .. (texture or T_UIDefinition.texture_unk) .. ":12:12:0:0|t " .. (DataAgent.get_pname_by_pid(pid) or ""));
							end
							for sid, c in next, cool do
								local texture = DataAgent.item_icon(DataAgent.get_cid_by_sid(sid));
								local sname = "|T" .. (texture or T_UIDefinition.texture_unk) .. ":12:12:0:0|t " .. DataAgent.spell_name_s(sid);
								if c > 0 then
									local diff = c - GetServerTime();
									if diff > 0 then
										Frame:F_AddLine(sname, nil, LF_FormatTime(diff));
									else
										cool[sid] = -1;
										Frame:F_AddLine(sname, nil, l10n["COOLDOWN_EXPIRED"]);
									end
								else
									Frame:F_AddLine(sname, nil, l10n["COOLDOWN_EXPIRED"]);
								end
							end
						end
					end
				end
			end
			Frame:F_Update();
		end
		local cal = VT.__super.cal;
		if cal then
			cal.ext_Reset();
			for pid, list in next, DataAgent.T_TradeSkill_CooldownList do
				if DataAgent.is_pid(pid) then
					for index = 1, #list do
						local data = list[index];
						local add_label = true;
						for GUID, VAR in next, VT.AVAR do
							local var = rawget(VAR, pid);
							if var then
								local cool = var[3];
								if cool and cool[data[1]] then
									if add_label then
										cal.ext_RegHeader(data[1], LF_CalendarSetHeader);
									end
									cal.ext_AddLine(data[1], GUID, LF_CalendarSetLine);
								end
							end
						end
					end
				end
			end
			cal.ext_UpdateBoard();
		end
	end
--
local function LF_CreateBoard()
	local Frame = CreateFrame('FRAME', nil, UIParent);
	Frame:SetClampedToScreen(true);
	if CT.LOCALE == 'zhCN' or CT.LOCALE == 'zhTW' or CT.LOCALE == 'koKR' then
		Frame:SetWidth(260);
	else
		Frame:SetWidth(320);
	end
	Frame:SetMovable(true);
	-- Frame:EnableMouse(true);
	-- Frame:RegisterForDrag("LeftButton");
	function Frame:F_Lock()
		self:EnableMouse(false);
		VT.__uireimp._SetSimpleBackdrop(self, 0, 1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
	end
	function Frame:F_Unlock()
		self:EnableMouse(true);
		VT.__uireimp._SetSimpleBackdrop(self, 0, 1, 0.0, 0.0, 0.0, 0.5, 0.0, 0.0, 0.0, 0.5);
	end
	Frame:SetScript("OnMouseDown", function(self, button)
		if button == "LeftButton" then
			self:StartMoving();
		else
			VT.__menulib.ShowMenu(self, "BOTTOMLEFT", T_BoardDropMeta);
		end
	end);
	Frame:SetScript("OnMouseUp", function(self, button)
		self:StopMovingOrSizing();
		local pos = { self:GetPoint(), };
		for index = 1, #pos do
			local val = pos[index];
			if type(val) == 'table' then
				pos[index] = val:GetName();
			end
		end
		VT.SET.board_pos = pos;
	end);
	Frame:SetScript("OnEnter", LT_SharedMethod.ButtonInfoOnEnter);
	Frame:SetScript("OnLeave", LT_SharedMethod.ButtonInfoOnLeave);
	function Frame:F_AddLine(textL, textM, textR)
		local T_Lines = self.T_Lines;
		local index = self.curLine + 1;
		self.curLine = index;
		local Line = T_Lines[index];
		if not Line then
			local LineL = self:CreateFontString(nil, "OVERLAY");
			LineL:SetFont(T_UIDefinition.frameNormalFont, T_UIDefinition.frameNormalFontSize, T_UIDefinition.frameNormalFontFlag);
			LineL:SetPoint("TOPLEFT", self, "TOPLEFT", 0, -16 * (index - 1));
			local LineM = self:CreateFontString(nil, "OVERLAY");
			LineM:SetFont(T_UIDefinition.frameNormalFont, T_UIDefinition.frameNormalFontSize, T_UIDefinition.frameNormalFontFlag);
			LineM:SetPoint("TOP", self, "TOP", 0, -16 * (index - 1));
			local LineR = self:CreateFontString(nil, "OVERLAY");
			LineR:SetFont(T_UIDefinition.frameNormalFont, T_UIDefinition.frameNormalFontSize, T_UIDefinition.frameNormalFontFlag);
			LineR:SetPoint("TOPRIGHT", self, "TOPRIGHT", 0, -16 * (index - 1));
			Line = { LineL, LineM, LineR, };
			T_Lines[index] = Line;
		end
		if textL then
			Line[1]:Show();
			Line[1]:SetText(textL);
		else
			Line[1]:Hide();
		end
		if textM then
			Line[2]:Show()
			Line[2]:SetText(textM);
		else
			Line[2]:Hide();
		end
		if textR then
			Line[3]:Show()
			Line[3]:SetText(textR);
		else
			Line[3]:Hide();
		end
	end
	function Frame:F_Clear()
		local T_Lines = self.T_Lines;
		for index = 1, self.curLine do
			T_Lines[index][1]:Hide();
			T_Lines[index][2]:Hide();
			T_Lines[index][3]:Hide();
			self:SetHeight(16);
			self:SetClampRectInsets(200, -200, 0, 0);
		end
		self.curLine = 0;
	end
	function Frame:F_Update()
		local h = 16 * max(self.curLine, 1);
		self:SetHeight(h);
		self:SetClampRectInsets(200, -200, 16 - h, h - 16);
	end
	Frame.info_lines = { l10n["BOARD_TIP"], };
	Frame.T_Lines = {  };
	Frame.curLine = 0;
	MT._TimerStart(LF_UpdateBoard, 1.0);
	if VT.SET.show_board then
		Frame:Show();
	else
		Frame:Hide();
	end
	if VT.SET.lock_board then
		Frame:F_Lock();
	else
		Frame:F_Unlock();
	end
	if VT.SET.board_pos then
		Frame:SetPoint(unpack(VT.SET.board_pos));
	else
		Frame:SetPoint("TOP", 0, -20);
	end
	return Frame;
end
--	Config
	local T_CharListDrop_Del = {
		text = l10n.CHAR_DEL,
		param = {  },
	};
	local T_CharListDropMeta = {
		handler = function(_, _, param)
			MT.DelChar(param[1]);
			param[2].ScrollFrame:Update();
		end,
		T_CharListDrop_Del,
	};
	local function LF_ConfigCharListButton_OnClick(self, button)
		local list = VT.SET.char_list;
		local data_index = self:GetDataIndex();
		if data_index <= #list then
			local key = list[data_index];
			if key ~= CT.SELFGUID then
				T_CharListDrop_Del.param[1] = data_index;
				T_CharListDrop_Del.param[2] = self.Frame;
				VT.__menulib.ShowMenu(self, "BOTTOM", T_CharListDropMeta);
			end
		end
	end
	local function LF_ConfigCharListButton_OnEnter(self)
		local list = VT.SET.char_list;
		local data_index = self:GetDataIndex();
		if data_index <= #list then
			local key = list[data_index];
			local VAR = VT.AVAR[key];
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
			local lClass, class, lRace, race, sex, name, realm = GetPlayerInfoByGUID(key);
			if name and class then
				class = strupper(class);
				if realm ~= nil and realm ~= "" then
					name = name .. "-" .. realm;
				end
				local classColorTable = RAID_CLASS_COLORS[class];
				if classColorTable then
					GameTooltip:AddLine(name, classColorTable.r, classColorTable.g, classColorTable.b);
				else
					GameTooltip:AddLine(name, 1.0, 1.0, 1.0);
				end
			else
				GameTooltip:AddLine(key, 1.0, 1.0, 1.0);
			end
			local add_blank = true;
			for pid = DataAgent.DBMINPID, DataAgent.DBMAXPID do
				local var = rawget(VAR, pid);
				if var and DataAgent.is_pid(pid) then
					if add_blank then
						GameTooltip:AddLine(" ");
						add_blank = false;
					end
					local right = var.cur_rank;
					if var.max_rank then
						right = (right or "") .. "/" .. var.max_rank;
					end
					if right then
						GameTooltip:AddDoubleLine("    " .. (DataAgent.get_pname_by_pid(pid) or pid), right .. "    ", 1.0, 1.0, 1.0, 1.0, 1.0, 1.0);
					else
						GameTooltip:AddLine("    " .. (DataAgent.get_pname_by_pid(pid) or pid), 1.0, 1.0, 1.0);
					end
				end
			end
			-- if VAR.PLAYER_LEVEL then
			-- 	self.Note:SetText(VAR.PLAYER_LEVEL);
			-- else
			-- 	self.Note:SetText("");
			-- end
			GameTooltip:Show();
		end
	end
	local function LF_ConfigCreateCharListButton(parent, index, buttonHeight)
		local Button = CreateFrame('BUTTON', nil, parent);
		Button:SetHeight(buttonHeight);
		VT.__uireimp._SetSimpleBackdrop(Button, 0, 1, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0);
		Button:SetHighlightTexture(T_UIDefinition.texture_white);
		Button:GetHighlightTexture():SetVertexColor(unpack(T_UIDefinition.listButtonHighlightColor));
		Button:EnableMouse(true);
		Button:RegisterForClicks("AnyUp");

		local Icon = Button:CreateTexture(nil, "BORDER");
		Icon:SetTexture(T_UIDefinition.texture_unk);
		Icon:SetSize(buttonHeight - 4, buttonHeight - 4);
		Icon:SetPoint("LEFT", 8, 0);
		Icon:SetTexture([[Interface\TargetingFrame\UI-Classes-Circles]]);
		Button.Icon = Icon;

		local Title = Button:CreateFontString(nil, "OVERLAY");
		Title:SetFont(T_UIDefinition.frameNormalFont, T_UIDefinition.frameNormalFontSize, T_UIDefinition.frameNormalFontFlag);
		Title:SetPoint("LEFT", Icon, "RIGHT", 4, 0);
		-- Title:SetWidth(160);
		Title:SetMaxLines(1);
		Title:SetJustifyH("LEFT");
		Button.Title = Title;

		local Note = Button:CreateFontString(nil, "OVERLAY");
		Note:SetFont(T_UIDefinition.frameNormalFont, T_UIDefinition.frameNormalFontSize, T_UIDefinition.frameNormalFontFlag);
		Note:SetPoint("RIGHT", Button, "RIGHT", -4, 0);
		-- Note:SetWidth(160);
		Note:SetMaxLines(1);
		Note:SetJustifyH("LEFT");
		Note:SetVertexColor(1.0, 0.25, 0.25, 1.0);
		Button.Note = Note;

		Button:SetScript("OnClick", LF_ConfigCharListButton_OnClick);
		Button:SetScript("OnEnter", LF_ConfigCharListButton_OnEnter);
		Button:SetScript("OnLeave", LT_SharedMethod.ButtonInfoOnLeave);

		local Frame = parent:GetParent():GetParent();
		Button.Frame = Frame;

		return Button;
	end
	local function LF_ConfigSetCharListButton(Button, data_index)
		local list = VT.SET.char_list;
		if data_index <= #list then
			local key = list[data_index];
			local VAR = VT.AVAR[key];
			local lClass, class, lRace, race, sex, name, realm = GetPlayerInfoByGUID(key);
			if name and class then
				class = strupper(class);
				local coord = CLASS_ICON_TCOORDS[class];
				if coord then
					Button.Icon:Show();
					Button.Icon:SetTexCoord(coord[1] + 1 / 256, coord[2] - 1 / 256, coord[3] + 1 / 256, coord[4] - 1 / 256);
				else
					Button.Icon:Show();
				end
				if realm ~= nil and realm ~= "" then
					name = name .. "-" .. realm;
				end
				Button.Title:SetText(name);
				local classColorTable = RAID_CLASS_COLORS[class];
				if classColorTable then
					Button.Title:SetVertexColor(classColorTable.r, classColorTable.g, classColorTable.b, 1.0);
				else
					Button.Title:SetVertexColor(0.75, 0.75, 0.75, 1.0);
				end
			else
				Button.Icon:Hide();
				Button.Title:SetText(key);
				Button.Title:SetVertexColor(0.75, 0.75, 0.75, 1.0);
			end
			if VAR.PLAYER_LEVEL then
				Button.Note:SetText(VAR.PLAYER_LEVEL);
			else
				Button.Note:SetText("");
			end
			Button:Show();
		else
			Button:Hide();
		end
	end
	local function LF_ConfigCreateCheckButton(parent, key, text, OnClick)
		local CheckButton = CreateFrame('CHECKBUTTON', nil, parent, "OptionsBaseCheckButtonTemplate");
		CheckButton:SetNormalTexture(T_UIDefinition.texture_modern_check_button_border);
		CheckButton:SetPushedTexture(T_UIDefinition.texture_modern_check_button_center);
		CheckButton:SetHighlightTexture(T_UIDefinition.texture_modern_check_button_border);
		CheckButton:SetCheckedTexture(T_UIDefinition.texture_modern_check_button_center);
		CheckButton:GetNormalTexture():SetVertexColor(1.0, 1.0, 1.0, 0.5);
		CheckButton:GetPushedTexture():SetVertexColor(1.0, 1.0, 1.0, 0.25);
		CheckButton:GetHighlightTexture():SetVertexColor(1.0, 1.0, 1.0, 0.5);
		CheckButton:GetCheckedTexture():SetVertexColor(0.0, 0.5, 1.0, 0.75);
		CheckButton:SetSize(16, 16);
		CheckButton:SetHitRectInsets(0, 0, 0, 0);
		CheckButton:Show();

		local Text = CheckButton:CreateFontString(nil, "ARTWORK");
		Text:SetFont(T_UIDefinition.frameNormalFont, T_UIDefinition.frameNormalFontSize, T_UIDefinition.frameNormalFontFlag);
		Text:SetText(text);
		Text:SetPoint("LEFT", CheckButton, "CENTER", 12, 0);
		CheckButton.Text = Text;

		CheckButton.key = key;
		CheckButton:SetScript("OnClick", OnClick);
		function CheckButton:SetVal(val)
			self:SetChecked(val);
		end
		CheckButton.Right = Text;
		return CheckButton;
	end
	local function LF_ConfigDrop_OnClick(self)
		if type(self.meta) == 'function' then
			VT.__menulib.ShowMenu(self, "BOTTOM", self.meta());
		else
			VT.__menulib.ShowMenu(self, "BOTTOM", self.meta);
		end
	end 
	local function LF_ConfigCreateDrop(parent, key, text, meta)
		local Dropdown = CreateFrame('BUTTON', nil, parent);
		Dropdown:SetSize(12, 12);
		Dropdown:EnableMouse(true);
		Dropdown:SetNormalTexture(T_UIDefinition.texture_modern_arrow_down);
		Dropdown:SetPushedTexture(T_UIDefinition.texture_modern_arrow_down);
		Dropdown:GetPushedTexture():SetVertexColor(0.5, 0.5, 0.5, 1.0);
		Dropdown:SetHighlightTexture(T_UIDefinition.texture_modern_arrow_down);
		Dropdown:GetHighlightTexture():SetVertexColor(0.0, 0.5, 1.0, 0.25);

		local Label = Dropdown:CreateFontString(nil, "ARTWORK");
		Label:SetFont(T_UIDefinition.frameNormalFont, T_UIDefinition.frameNormalFontSize, T_UIDefinition.frameNormalFontFlag);
		Label:SetText(gsub(text, "%%[a-z]", ""));
		Label:SetPoint("LEFT", Dropdown, "RIGHT", 0, 0);
		Dropdown.Label = Label;

		local Text = Dropdown:CreateFontString(nil, "ARTWORK");
		Text:SetFont(T_UIDefinition.frameNormalFont, T_UIDefinition.frameNormalFontSize, T_UIDefinition.frameNormalFontFlag);
		Text:SetPoint("TOPLEFT", Label, "BOTTOMLEFT", 0, -2);
		Text:SetVertexColor(0.0, 1.0, 0.0, 1.0);
		Dropdown.Text = Text;

		Dropdown.key = key;
		Dropdown.meta = meta;
		function Dropdown:SetVal(val)
		end
		Dropdown:SetScript("OnClick", LF_ConfigDrop_OnClick);
		Dropdown.Right = Label;
		return Dropdown;
	end
	local function LF_ConfigCreateSlider(parent, key, text, minVal, maxVal, step, OnValueChanged)
		local Slider = CreateFrame('SLIDER', nil, parent, "OptionsSliderTemplate");
		local Label = Slider:CreateFontString(nil, "ARTWORK");
		Label:SetFont(T_UIDefinition.frameNormalFont, T_UIDefinition.frameNormalFontSize, T_UIDefinition.frameNormalFontFlag);
		Label:SetText(gsub(text, "%%[a-z]", ""));
		Slider:SetWidth(200);
		Slider:SetHeight(20);
		Slider:SetMinMaxValues(minVal, maxVal)
		Slider:SetValueStep(step);
		Slider:SetObeyStepOnDrag(true);
		Slider:SetPoint("LEFT", Label, "LEFT", 60, 0);
		Slider.Text:ClearAllPoints();
		Slider.Text:SetPoint("TOP", Slider, "BOTTOM", 0, 3);
		Slider.Low:ClearAllPoints();
		Slider.Low:SetPoint("TOPLEFT", Slider, "BOTTOMLEFT", 4, 3);
		Slider.High:ClearAllPoints();
		Slider.High:SetPoint("TOPRIGHT", Slider, "BOTTOMRIGHT", -4, 3);
		Slider.Low:SetText(minVal);
		Slider.High:SetText(maxVal);
		Slider.key = key;
		Slider.Label = Label;
		Slider:HookScript("OnValueChanged", OnValueChanged);
		function Slider:SetVal(val)
			self:SetValue(val);
		end
		function Slider:SetStr(str)
			self.Text:SetText(str);
		end
		Slider._SetPoint = Slider.SetPoint;
		function Slider:SetPoint(...)
			self.Label:SetPoint(...);
		end
		Slider.Right = Slider;
		return Slider;
	end
	local function LF_ConfigCreateColor4(parent, key, text, OnColor)
		local ColorPickerFrame = _G.ColorPickerFrame;
		local OpacitySliderFrame = _G.OpacitySliderFrame;
		local Button = CreateFrame('BUTTON', nil, parent);
		Button:SetSize(20, 20);
		Button:EnableMouse(true);
		Button:SetNormalTexture(T_UIDefinition.texture_color_select);
		Button:GetNormalTexture():SetVertexColor(1.0, 1.0, 1.0, 1.0);
		Button:SetPushedTexture(T_UIDefinition.texture_color_select);
		Button:GetPushedTexture():SetVertexColor(unpack(T_UIDefinition.textureButtonColorPushed));
		Button:SetHighlightTexture(T_UIDefinition.texture_color_select);
		Button:GetHighlightTexture():SetVertexColor(unpack(T_UIDefinition.textureButtonColorHighlight));
		local valStr = Button:CreateTexture(nil, "OVERLAY");
		valStr:SetAllPoints(true);
		local left = Button:CreateFontString(nil, "ARTWORK");
		left:SetFont(T_UIDefinition.frameNormalFont, T_UIDefinition.frameNormalFontSize, T_UIDefinition.frameNormalFontFlag);
		left:SetText(">>");
		left:SetPoint("RIGHT", Button, "LEFT", -2, 0);
		local Label = Button:CreateFontString(nil, "ARTWORK");
		Label:SetFont(T_UIDefinition.frameNormalFont, T_UIDefinition.frameNormalFontSize, T_UIDefinition.frameNormalFontFlag);
		Label:SetText("<<" .. gsub(text, "%%[a-z]", ""));
		Label:SetPoint("LEFT", Button, "RIGHT", 2, 0);
		Button.Label = Label;
		Button.key = key;
		Button.valStr = valStr;
		local backup = nil;
		Button.func = function()
			local r, g, b = ColorPickerFrame:GetColorRGB();
			local a = 1.0 - OpacitySliderFrame:GetValue();
			OnColor(r, g, b, a);
			-- ColorPickerFrame.Alpha.bg:SetVertexColor(r, g, b);
		end
		Button.opacityFunc = function()
			local r, g, b = ColorPickerFrame:GetColorRGB();
			local a = 1.0 - OpacitySliderFrame:GetValue();
			OnColor(r, g, b, a);
		end
		Button.cancelFunc = function()
			if backup then
				OnColor(unpack(backup));
				backup = nil;
			end
		end
		Button:SetScript("OnClick", function(self)
			backup = VT.SET[self.key];
			-- ColorPickerFrame.Alpha:Show();
			ColorPickerFrame.func = Button.func;
			ColorPickerFrame.hasOpacity = true;
			ColorPickerFrame.opacityFunc = Button.opacityFunc;
			ColorPickerFrame.opacity = 1.0 - backup[4];
			-- ColorPickerFrame.previousValues = { r = backup[1], g = backup[2], b = backup[3], opacity = backup[4], };
			ColorPickerFrame.cancelFunc = Button.cancelFunc;
			ColorPickerFrame:ClearAllPoints();
			ColorPickerFrame:SetPoint("TOPLEFT", Button, "BOTTOMRIGHT", 12, 12);
			ColorPickerFrame:SetColorRGB(unpack(backup));
			ColorPickerFrame:Show();
		end);
		function Button:SetVal(val)
			valStr:SetColorTexture(val[1], val[2], val[3], val[4] or 1.0);
		end
		Button.Right = Label;
		return Button;
	end
--
local function LF_CreateConfigFrame()
	local SettingUIFreeContainer, SettingUIInterfaceOptionsFrameContainer;
	local Frame = CreateFrame('FRAME', nil, UIParent);
	Frame:SetSize(450, 250);
	Frame:SetFrameStrata("DIALOG");
	Frame:Hide();
	--
	SettingUIFreeContainer = CreateFrame('FRAME', "ALATRADESKILL_SETTING_UI_C", UIParent);
	SettingUIFreeContainer:Hide();
	SettingUIFreeContainer:SetFrameStrata("DIALOG");
	SettingUIFreeContainer:SetPoint("CENTER");
	SettingUIFreeContainer:EnableMouse(true);
	SettingUIFreeContainer:SetMovable(true);
	SettingUIFreeContainer:RegisterForDrag("LeftButton");
	SettingUIFreeContainer:SetScript("OnDragStart", function(self)
		self:StartMoving();
	end);
	SettingUIFreeContainer:SetScript("OnDragStop", function(self)
		self:StopMovingOrSizing();
	end);
	SettingUIFreeContainer:SetScript("OnShow", function(self)
		SettingUIInterfaceOptionsFrameContainer:Hide();
		self:SetSize(Frame:GetWidth(), Frame:GetHeight());
		Frame:_Show();
		Frame:ClearAllPoints();
		Frame:SetPoint("BOTTOM", self, "BOTTOM");
		Frame.Container = self;
	end);
	SettingUIFreeContainer:SetScript("OnHide", function()
		if not SettingUIInterfaceOptionsFrameContainer:IsShown() then
			Frame:_Hide();
			Frame:ClearAllPoints();
		end
	end);
	tinsert(UISpecialFrames, "ALATRADESKILL_SETTING_UI_C");
	VT.__uireimp._SetSimpleBackdrop(SettingUIFreeContainer, 0, 1, 0.05, 0.05, 0.05, 1.0, 0.0, 0.0, 0.0, 1.0);
	--
	local Close = CreateFrame('BUTTON', nil, SettingUIFreeContainer);
	Close:SetSize(20, 20);
	LT_SharedMethod.StyleModernButton(Close, nil, T_UIDefinition.texture_modern_button_close);
	Close:SetPoint("TOPRIGHT", SettingUIFreeContainer, "TOPRIGHT", -2, -2);
	Close:SetScript("OnClick", function()
		SettingUIFreeContainer:Hide();
	end);
	Close:SetScript("OnEnter", LT_SharedMethod.ButtonInfoOnEnter);
	Close:SetScript("OnLeave", LT_SharedMethod.ButtonInfoOnLeave);
	Close.info_lines = { l10n.CLOSE, };
	SettingUIFreeContainer.Close = Close;
	--
	SettingUIInterfaceOptionsFrameContainer = CreateFrame('FRAME');
	SettingUIInterfaceOptionsFrameContainer:Hide();
	SettingUIInterfaceOptionsFrameContainer:SetSize(1, 1);
	SettingUIInterfaceOptionsFrameContainer.name = __addon;
	SettingUIInterfaceOptionsFrameContainer:SetScript("OnShow", function(self)
		SettingUIFreeContainer:Hide();
		Frame:_Show();
		Frame:ClearAllPoints();
		Frame:SetPoint("TOPLEFT", self, "TOPLEFT", 4, 0);
		Frame.Container = self;
	end);
	SettingUIInterfaceOptionsFrameContainer:SetScript("OnHide", function()
		if not SettingUIFreeContainer:IsShown() then
			Frame:_Hide();
			Frame:ClearAllPoints();
		end
	end);
	InterfaceOptions_AddCategory(SettingUIInterfaceOptionsFrameContainer);
	--
	Frame._Show = Frame.Show;
	Frame._Hide = Frame.Hide;
	Frame._IsShown = Frame.IsShown;
	function Frame:Show()
		if InterfaceOptionsFrame:IsShown() then
			InterfaceOptionsFrame_OpenToCategory(__addon);
		else
			SettingUIFreeContainer:Show();
		end
	end
	function Frame:Hide()
		if InterfaceOptionsFrame:IsShown() then
			InterfaceOptionsFrame:Hide();
		else
			SettingUIFreeContainer:Hide();
		end
	end
	function Frame:IsShown()
		return SettingUIFreeContainer:IsShown() or SettingUIInterfaceOptionsFrameContainer:IsVisible();
	end
	--
	local T_SetWidgets = {  };
	local px, py, h = 0, 0, 1;
	for index = 1, #VT.SetCommandList do
		local cmd = VT.SetCommandList[index];
		if px >= 1 then
			px = 0;
			py = py + h;
			h = 1;
		end
		local key = cmd[3];
		if cmd[1] == 'bool' then
			local CheckButton = LF_ConfigCreateCheckButton(Frame, key, l10n.SLASH_NOTE[key], cmd[8]);
			CheckButton:SetPoint("TOPLEFT", Frame, "TOPLEFT", 10 + 150 * px, -25 - 25 * py);
			T_SetWidgets[key] = CheckButton;
			px = px + 1;
			h = max(h, 1);
		elseif cmd[7] == 'drop' then
			local Dropdown = LF_ConfigCreateDrop(Frame, key, l10n.SLASH_NOTE[key], cmd[8]);
			Dropdown:SetPoint("TOPLEFT", Frame, "TOPLEFT", 10 + 150 * px, -25 - 25 * py);
			T_SetWidgets[key] = Dropdown;
			px = px + 1;
			h = max(h, 1);
		elseif cmd[7] == 'slider' then
			if px > 2 then
				px = 0;
				py = py + h;
				h = 1;
			end
			local Slider = LF_ConfigCreateSlider(Frame, key, l10n.SLASH_NOTE[key], cmd[9][1], cmd[9][2], cmd[9][3], cmd[8]);
			Slider:SetPoint("TOPLEFT", Frame, "TOPLEFT", 10 + 150 * px, -25 - 25 * py);
			T_SetWidgets[key] = Slider;
			px = px + 2;
			h = max(h, 2);
		end
		local extra_list = cmd[10];
		if extra_list then
			local father = T_SetWidgets[key];
			local children_key = {  };
			father.children_key = children_key;
			for val, extra in next, extra_list do
				local exkey = extra[3];
				children_key[exkey] = val;
				if extra[7] == 'bool' then
					local CheckButton = LF_ConfigCreateCheckButton(Frame, exkey, l10n.SLASH_NOTE[exkey], extra[8]);
					CheckButton:SetPoint("LEFT", father.Right, "RIGHT", 20, 0);
					T_SetWidgets[exkey] = CheckButton;
				elseif extra[7] == 'drop' then
					local Dropdown = LF_ConfigCreateDrop(Frame, exkey, l10n.SLASH_NOTE[exkey], extra[8]);
					Dropdown:SetPoint("LEFT", father.Right, "RIGHT", 20, 0);
					T_SetWidgets[exkey] = Dropdown;
				elseif extra[7] == 'slider' then
					local Slider = LF_ConfigCreateSlider(Frame, exkey, l10n.SLASH_NOTE[exkey], extra[9][1], extra[9][2], extra[9][3], extra[8]);
					Slider:SetPoint("LEFT", father.Right, "RIGHT", 20, 0);
					T_SetWidgets[exkey] = Slider;
				elseif extra[7] == 'color4' then
					local color4 = LF_ConfigCreateColor4(Frame, exkey, l10n.SLASH_NOTE[exkey], extra[8]);
					color4:SetPoint("LEFT", father.Right, "RIGHT", 40, 0);
					T_SetWidgets[exkey] = color4;
				end
			end
		end
	end
	Frame.T_SetWidgets = T_SetWidgets;
	if px ~= 0 then
		px = 0;
		py = py + h;
		h = 1;
	end
	do	--	character list
		local CharList = CreateFrame('FRAME', nil, Frame);
		VT.__uireimp._SetSimpleBackdrop(CharList, 0, 1, 0.05, 0.05, 0.05, 1.0, 0.0, 0.0, 0.0, 1.0);
		CharList:SetSize(240, 400);
		CharList:SetPoint("BOTTOMLEFT", Frame, "BOTTOMRIGHT", 2, 0);
		CharList:EnableMouse(true);
		CharList:SetMovable(false);
		-- CharList:RegisterForDrag("LeftButton");
		-- CharList:SetScript("OnDragStart", function(self)
		-- 	self:GetParent():StartMoving();
		-- end);
		-- CharList:SetScript("OnDragStop", function(self)
		-- 	self:GetParent():StopMovingOrSizing();
		-- end);
		CharList:Hide();

		local ScrollFrame = VT.__scrolllib.CreateScrollFrame(CharList, nil, nil, T_UIDefinition.charListButtonHeight, LF_ConfigCreateCharListButton, LF_ConfigSetCharListButton);
		ScrollFrame:SetPoint("BOTTOMLEFT", 4, 12);
		ScrollFrame:SetPoint("TOPRIGHT", -4, -24);
		CharList.ScrollFrame = ScrollFrame;
		ScrollFrame:SetNumValue(#VT.SET.char_list);

		CharList:SetScript("OnShow", function(self)
			VT.UIFrames["CONFIG"].CharListToggleButton:F_SetStatusTexture(true);
		end);
		CharList:SetScript("OnHide", function(self)
			VT.UIFrames["CONFIG"].CharListToggleButton:F_SetStatusTexture(false);
		end);
		Frame.CharList = CharList;

		local ToggleButton = CreateFrame('BUTTON', nil, Frame);
		ToggleButton:SetSize(12, 12);
		ToggleButton:SetNormalTexture(T_UIDefinition.texture_modern_arrow_right);
		ToggleButton:SetPushedTexture(T_UIDefinition.texture_modern_arrow_right);
		ToggleButton:GetPushedTexture():SetVertexColor(0.5, 0.5, 0.5, 1.0);
		ToggleButton:SetHighlightTexture(T_UIDefinition.texture_modern_arrow_right);
		ToggleButton:GetHighlightTexture():SetVertexColor(0.0, 0.5, 1.0, 0.25);
		ToggleButton:SetPoint("TOPLEFT", 420, -25 - 25 * py);
		function ToggleButton:F_SetStatusTexture(bool)
			if bool then
				self:SetNormalTexture(T_UIDefinition.texture_modern_arrow_left);
				self:SetPushedTexture(T_UIDefinition.texture_modern_arrow_left);
				self:SetHighlightTexture(T_UIDefinition.texture_modern_arrow_left);
			else
				self:SetNormalTexture(T_UIDefinition.texture_modern_arrow_right);
				self:SetPushedTexture(T_UIDefinition.texture_modern_arrow_right);
				self:SetHighlightTexture(T_UIDefinition.texture_modern_arrow_right);
			end
		end
		ToggleButton:F_SetStatusTexture(false);
		ToggleButton.CharList = CharList;
		ToggleButton:SetScript("OnClick", function(self)
			local CharList = self.CharList;
			if CharList:IsShown() then
				CharList:Hide();
			else
				CharList:Show();
			end
		end);
		Frame.CharListToggleButton = ToggleButton;

		local Text = ToggleButton:CreateFontString(nil, "OVERLAY");
		Text:SetFont(T_UIDefinition.frameNormalFont, T_UIDefinition.frameNormalFontSize, T_UIDefinition.frameNormalFontFlag);
		Text:SetPoint("RIGHT", ToggleButton, "LEFT", -2, 0);
		Text:SetVertexColor(1.0, 1.0, 1.0, 1.0);
		Text:SetText(l10n.CHAR_LIST);
		ToggleButton.Text = Text;

		function CharList:F_Update()
			self.ScrollFrame:SetNumValue(#VT.SET.char_list);
			self.ScrollFrame:Update();
		end
	end
	function Frame:F_Refresh()
		for key, obj in next, T_SetWidgets do
			obj:SetVal(VT.SET[key]);
			local children_key = obj.children_key;
			if children_key then
				for exkey, val in next, children_key do
					local obj2 = T_SetWidgets[exkey];
					if obj2 then
						if VT.SET[key] == val then
							obj2:Show();
						else
							obj2:Hide();
						end
					end
				end
			end
		end
	end
	function Frame:F_Update()
		-- self:F_Refresh();
		self.CharList:F_Update();
	end
	Frame:SetScript("OnShow", function(self)
		self:F_Refresh();
	end);
	Frame:SetHeight(25 + py * 25 + 25);
	return Frame;
end


function MT.MarkSkillToUpdate(pid)
	VT.SET[pid].update = true;
end

-->		external
	function MT.ToggleFrame(key, val)
		local Frame = VT.UIFrames[key];
		if Frame ~= nil then
			if Frame:IsShown() or val == false then
				Frame:Hide();
				return false;
			else
				Frame:Show();
				return true;
			end
		end
	end
	function MT.ToggleFrameCall(val)
		local TFrame = VT.UIFrames["BLIZZARD_TRADESKILLUI"];
		if TFrame ~= nil then
			if val then
				TFrame.ToggleButton:Show();
			else
				TFrame.ToggleButton:Hide();
			end
		end
		local CFrame = VT.UIFrames["BLIZZARD_CRAFTUI"];
		if CFrame ~= nil then
			if val then
				CFrame.ToggleButton:Show();
			else
				CFrame.ToggleButton:Hide();
			end
		end
	end
	function MT.ToggleFrameTab(val)
		local TFrame = VT.UIFrames["BLIZZARD_TRADESKILLUI"];
		if TFrame ~= nil then
			if val then
				TFrame.TabFrame:Show();
			else
				TFrame.TabFrame:Hide();
			end
			TFrame:F_ShowSetFrame(false);
		end
		local CFrame = VT.UIFrames["BLIZZARD_CRAFTUI"];
		if CFrame ~= nil then
			if val then
				CFrame.TabFrame:Show();
			else
				CFrame.TabFrame:Hide();
			end
			CFrame:F_ShowSetFrame(false);
		end
	end
	function MT.ToggleFramePortraitButton(val)
		local TFrame = VT.UIFrames["BLIZZARD_TRADESKILLUI"];
		if TFrame ~= nil then
			if val then
				TFrame.PortraitButton:Show();
			else
				TFrame.PortraitButton:Hide();
			end
		end
		local CFrame = VT.UIFrames["BLIZZARD_CRAFTUI"];
		if CFrame ~= nil then
			if val then
				CFrame.PortraitButton:Show();
			else
				CFrame.PortraitButton:Hide();
			end
		end
	end
	function MT.LockBoard(val)
		if val then
			VT.UIFrames["BOARD"]:F_Lock();
		else
			VT.UIFrames["BOARD"]:F_Unlock();
		end
	end
	function MT.UpdateAllFrames()
		local TFrame = VT.UIFrames["BLIZZARD_TRADESKILLUI"];
		if TFrame ~= nil then
			TFrame:F_Update();
		end
		local CFrame = VT.UIFrames["BLIZZARD_CRAFTUI"];
		if CFrame ~= nil then
			CFrame:F_Update();
		end
		local EFrame = VT.UIFrames["EXPLORER"];
		if EFrame ~= nil then
			EFrame:F_Update();
		end
	end
	function MT.RefreshAllFrames()
		local TFrame = VT.UIFrames["BLIZZARD_TRADESKILLUI"];
		if TFrame ~= nil then
			TFrame.ScrollFrame:Update();
			local ProfitFrame = TFrame.ProfitFrame;
			if ProfitFrame ~= nil then
				ProfitFrame.ScrollFrame:Update();
			end
		end
		local CFrame = VT.UIFrames["BLIZZARD_CRAFTUI"];
		if CFrame ~= nil then
			CFrame.ScrollFrame:Update();
			local ProfitFrame = CFrame.ProfitFrame;
			if ProfitFrame ~= nil then
				ProfitFrame.ScrollFrame:Update();
			end
		end
		local EFrame = VT.UIFrames["EXPLORER"];
		if EFrame ~= nil then
			EFrame.ScrollFrame:Update();
			local ProfitFrame = EFrame.ProfitFrame;
			if ProfitFrame ~= nil then
				ProfitFrame.ScrollFrame:Update();
			end
		end
	end
	function MT.RefreshFramesStyle(loading)
		local TFrame = VT.UIFrames["BLIZZARD_TRADESKILLUI"];
		if TFrame ~= nil then
			TFrame:F_SetStyle(VT.SET.blz_style, loading);
		end
		local CFrame = VT.UIFrames["BLIZZARD_CRAFTUI"];
		if CFrame ~= nil then
			CFrame:F_SetStyle(VT.SET.blz_style, loading);
		end
		local EFrame = VT.UIFrames["EXPLORER"];
		if EFrame ~= nil then
			EFrame:F_SetStyle(VT.SET.blz_style, loading);
		end
	end
	function MT.RefreshConfigFrame()
		VT.UIFrames["CONFIG"]:F_Refresh();
	end
	function MT.ToggleFrameExpand(val)
		local TFrame = VT.UIFrames["BLIZZARD_TRADESKILLUI"];
		if TFrame ~= nil then
			TFrame:F_Expand(val);
		end
		local CFrame = VT.UIFrames["BLIZZARD_CRAFTUI"];
		if CFrame ~= nil then
			CFrame:F_Expand(val);
		end
	end
	function MT.FrameFixSkillList()
		local TFrame = VT.UIFrames["BLIZZARD_TRADESKILLUI"];
		if TFrame ~= nil then
			TFrame:F_FixSkillList(VT.SET.expand);
		end
		local CFrame = VT.UIFrames["BLIZZARD_CRAFTUI"];
		if CFrame ~= nil then
			CFrame:F_FixSkillList(VT.SET.expand);
		end
	end
	function MT.ToggleFrameRankInfo(val)
		local TFrame = VT.UIFrames["BLIZZARD_TRADESKILLUI"];
		if TFrame ~= nil then
			TFrame:F_UpdateRankInfo();
		end
		local CFrame = VT.UIFrames["BLIZZARD_CRAFTUI"];
		if CFrame ~= nil then
			CFrame:F_UpdateRankInfo();
		end
	end
	function MT.ToggleFramePriceInfo(val)
		local TFrame = VT.UIFrames["BLIZZARD_TRADESKILLUI"];
		if TFrame ~= nil then
			TFrame:F_UpdatePriceInfo();
		end
		local CFrame = VT.UIFrames["BLIZZARD_CRAFTUI"];
		if CFrame ~= nil then
			CFrame:F_UpdatePriceInfo();
		end
	end
-->

function F.SKILL_LINES_CHANGED_Alt()
	-- local check_id = DataAgent.table_tradeskill_check_id();
	-- for pid = DataAgent.DBMINPID, DataAgent.DBMAXPID do
	-- 	local cpid = check_id[pid];
	-- 	if cpid ~= nil then
	-- 		if not IsSpellKnown(cpid) then
	-- 			rawset(VT.VAR, pid, nil);
	-- 		end
	-- 	end
	-- end
	local check_name = DataAgent.table_tradeskill_check_name();
	for pid = DataAgent.DBMINPID, DataAgent.DBMAXPID do
		local cpname = check_name[pid];
		if cpname ~= nil then
			if GetSpellInfo(cpname) == nil then
				rawset(VT.VAR, pid, nil);
			end
		end
	end
	for index = 1, GetNumSkillLines() do
		local pname, header, expanded, cur_rank, _, _, max_rank  = GetSkillLineInfo(index);
		if not header then
			local pid = DataAgent.get_pid_by_pname(pname);
			if pid ~= nil then
				local var = VT.VAR[pid];
				var.update = true;
				var.cur_rank, var.max_rank = cur_rank, max_rank;
				MT.CheckCooldown(pid, var);
			end
		end
	end
	local TFrame = VT.UIFrames.BLIZZARD_TRADESKILLUI;
	local CFrame = VT.UIFrames.BLIZZARD_CRAFTUI;
	if TFrame then
		TFrame.TabFrame:F_Update();
		TFrame.PortraitButton:F_Update();
	end
	if CFrame then
		CFrame.TabFrame:F_Update();
		CFrame.PortraitButton:F_Update();
	end
end
function F.SKILL_LINES_CHANGED()	--	Donot process at the first trigger. Do it after 1sec.
	if F.scheduled_SKILL_LINES_CHANGED then
		return;
	end
	F.scheduled_SKILL_LINES_CHANGED = true;
	--
	MT.After(1.0, function()
		F.scheduled_SKILL_LINES_CHANGED = nil;
		F.SKILL_LINES_CHANGED = F.SKILL_LINES_CHANGED_Alt;
		return F.SKILL_LINES_CHANGED_Alt();
	end);
end
function F.NEW_RECIPE_LEARNED(sid)
	local pid = DataAgent.get_pid_by_sid(sid);
	if pid ~= nil then
		local var = VT.VAR[pid];
		var.update = true;
		var[1][#var[1] + 1] = sid;
		var[2][sid] = -1;
		DataAgent.MarkKnown(sid, CT.SELFGUID);
		MT.FireCallback("USER_EVENT_RECIPE_LIST_UPDATE");
	end
end


MT.RegisterOnInit('ui', function(LoggedIn)
	for GUID, VAR in next, VT.AVAR do
		if VAR.realm_id == CT.SELFREALMID then
			for pid = DataAgent.DBMINPID, DataAgent.DBMAXPID do
				local var = rawget(VAR, pid);
				if var and DataAgent.is_pid(pid) then
					local list = var[1];
					for index = 1, #list do
						DataAgent.MarkKnown(list[index], GUID);
					end
				end
			end
		end
	end
	local _;
	_, VT.UIFrames["EXPLORER"] = MT.SafeCall(LF_CreateExplorerFrame);
	_, VT.UIFrames["CONFIG"] = MT.SafeCall(LF_CreateConfigFrame);
	_, VT.UIFrames["BOARD"] = MT.SafeCall(LF_CreateBoard);
	F:RegisterEvent("SKILL_LINES_CHANGED");
	F:RegisterEvent("NEW_RECIPE_LEARNED");
	MT.HookTooltip(SkillTip);
	MT.AddCallback("USER_EVENT_DATA_LOADED", function()
		F.SKILL_LINES_CHANGED();
		local TFrame = VT.UIFrames["BLIZZARD_TRADESKILLUI"];
		if TFrame ~= nil then
			if TFrame:IsShown() then
				TFrame.F_OnSelection();
			end
			TFrame.TabFrame:F_Update();
		end
		local CFrame = VT.UIFrames["BLIZZARD_CRAFTUI"];
		if CFrame ~= nil then
			if CFrame:IsShown() then
				CFrame.F_OnSelection();
			end
			CFrame.TabFrame:F_Update();
		end
	end);
	MT.AddCallback("USER_EVENT_RECIPE_LIST_UPDATE", MT.UpdateAllFrames);
	MT.RegisterOnAddOnLoaded("BLIZZARD_TRADESKILLUI", LF_AddOnCallback_Blizzard_TradeSkillUI);
	if not CT.VG3X then
		MT.RegisterOnAddOnLoaded("BLIZZARD_CRAFTUI", LF_AddOnCallback_Blizzard_CraftUI);
	end
end);
