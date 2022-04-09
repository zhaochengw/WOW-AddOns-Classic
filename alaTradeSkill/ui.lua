--[[--
	by ALA @ 163UI
--]]--
----------------------------------------------------------------------------------------------------
local _G = _G;
local __ala_meta__ = _G.__ala_meta__;
local uireimp = __ala_meta__.uireimp;

local __addon__, __namespace__ = ...;
local __db__ = __namespace__.__db__;
local L = __namespace__.L;

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
	local floor = math.floor;
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


	local C_Timer_After = C_Timer.After;
	local C_Timer_NewTicker = C_Timer.NewTicker;
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
	local ChatEdit_ChooseBoxForSend = ChatEdit_ChooseBoxForSend;

	local _G = _G;
	--[[
		local GetLocale = GetLocale;
		local BNGetInfo = BNGetInfo;
		local UISpecialFrames = UISpecialFrames;
		local UIParent = UIParent;
		SystemFont_Shadow_Med1
	]]
-->


local CURPHASE = __db__.CURPHASE;
local MAXPHASE = __db__.MAXPHASE;

local BIG_NUMBER = 4294967295;
local ICON_FOR_NO_CID = 135913;
local PERIODIC_UPDATE_PERIOD = 1.0;
local MAXIMUM_VAR_UPDATE_PERIOD = 4.0;
local PLAYER_GUID = UnitGUID('player');

local _noop_, _log_, _error_ = __namespace__._noop_, __namespace__._log_, __namespace__._error_;
local T_uiFrames = {  };


local AVAR, VAR, SET, FAV = nil, nil, nil, nil;
local AuctionMod = nil;


----	index
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
----
local F = CreateFrame('FRAME');
F:SetScript("OnEvent", function(self, event, ...)
	return self[event](...);
end);

local SkillTip = GameTooltip;	--	CreateFrame('GAMETOOLTIP', "_TradeSkillTooltip", UIParent, "GameTooltipTemplate");

local TEXTURE_PATH = [[Interface\AddOns\alaTradeSkill\Media\Textures\]];
local T_UIDefinition = {
	texture_white = "Interface\\Buttons\\WHITE8X8",
	texture_unk = "Interface\\Icons\\inv_misc_questionmark",
	texture_highlight = "Interface\\Buttons\\UI-Common-MouseHilight",
	texture_triangle = "interface\\transmogrify\\transmog-tooltip-arrow",
	texture_color_select = TEXTURE_PATH .. [[ColorSelect]],
	texture_alpha_ribbon = TEXTURE_PATH .. [[AlphaRibbon]],
	texture_config = "interface\\buttons\\ui-optionsbutton",
	texture_explorer = TEXTURE_PATH .. [[explorer]],
	texture_toggle = TEXTURE_PATH .. [[UI]],

	texture_modern_arrow_down = TEXTURE_PATH .. [[ArrowDown]],
	texture_modern_arrow_up = TEXTURE_PATH .. [[ArrowUp]],
	texture_modern_arrow_left = TEXTURE_PATH .. [[ArrowLeft]],
	texture_modern_arrow_right = TEXTURE_PATH .. [[ArrowRight]],
	texture_modern_button_minus = TEXTURE_PATH .. [[MinusButton]],
	texture_modern_button_plus = TEXTURE_PATH .. [[PlusButton]],
	texture_modern_button_close = TEXTURE_PATH .. [[Close]],
	texture_modern_check_button_border = TEXTURE_PATH .. [[CheckButtonBorder]],
	texture_modern_check_button_center = TEXTURE_PATH .. [[CheckButtonCenter]],

	color_white = { 1.0, 1.0, 1.0, 1.0, },

	modernFrameBackdrop = {
		bgFile = "Interface\\Buttons\\WHITE8X8",
		edgeFile = nil,
		tile = false,
		tileSize = 16,
		edgeSize = 16,
		insets = { left = 0, right = 0, top = 0, bottom = 0, },
	},
	blzFrameBackdrop = {
		bgFile = "Interface\\FrameGeneral\\UI-BackGround-Marble",
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",	--	"Interface\\Dialogframe\\UI-DialogBox-Border",
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

	frameFont = SystemFont_Shadow_Med1:GetFont(),	--	"Fonts\ARKai_T.ttf"
	frameFontSize = min(select(2, SystemFont_Shadow_Med1:GetFont()) + 1, 15),
	frameFontOutline = "NORMAL",

	tabSize = 24,
	tabInterval = 2,

	explorerWidth = 360,
	explorerHeight = 480,

	charListButtonHeight = 20,
};
local T_RankColor = {
	[0] = { 1.0, 0.0, 0.0, 1.0, },
	[1] = { 1.0, 0.5, 0.35, 1.0, },
	[2] = { 1.0, 1.0, 0.25, 1.0, },
	[3] = { 0.25, 1.0, 0.25, 1.0, },
	[4] = { 0.5, 0.5, 0.5, 1.0, },
	[BIG_NUMBER] = { 0.0, 0.0, 0.0, 1.0, },
};
local T_RankIndex = {
	['optimal'] = 1,
	['medium'] = 2,
	['easy'] = 3,
	['trivial'] = 4,
};


-->		****************
__namespace__:BuildEnv("ui");
-->		****************


local LT_SharedMethod = {  };

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

local T_LearnedRecipesHash = {  };
local T_ExplorerStat = { skill = {  }, type = {  }, subType = {  }, eqLoc = {  }, };
function LT_SharedMethod.MarkKnown(sid, GUID)
	local list = T_LearnedRecipesHash[sid];
	if list == nil then
		list = {  };
		T_LearnedRecipesHash[sid] = list;
	end
	list[GUID] = 1;
end
function LT_SharedMethod.CancelMarkKnown(sid, GUID)
	local list = T_LearnedRecipesHash[sid];
	if list ~= nil then
		list[GUID] = nil;
		for _ in next, list do
			return;
		end
		T_LearnedRecipesHash[sid] = nil;
	end
end


--	Update
	function LT_SharedMethod.ProfitFilterList(frame, list, only_cost)
		local sid_list = frame.list;
		wipe(list);
		if AuctionMod ~= nil then
			local pid = frame.flag or __db__.get_pid_by_pname(frame.F_GetSkillName());
			if only_cost and frame.flag ~= 'explorer' then
				local var = rawget(VAR, pid);
				local cur_rank = var and var.cur_rank or 0;
				for index = 1, #sid_list do
					local sid = sid_list[index];
					local price_a_product, price_a_material, price_a_material_known, missing = __namespace__.F_GetPriceInfoBySID(SET[pid].phase, sid, __db__.get_num_made_by_sid(sid), nil);
					if price_a_material then
						tinsert(list, { sid, price_a_material, __db__.get_difficulty_rank_by_sid(sid, cur_rank), });
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
					local price_a_product, price_a_material, price_a_material_known, missing = __namespace__.F_GetPriceInfoBySID(SET[pid].phase, sid, __db__.get_num_made_by_sid(sid), nil);
					if price_a_product and price_a_material then
						if price_a_product > price_a_material then
							tinsert(list, { sid, price_a_product - price_a_material, });
						end
					end
				end
				sort(list, function(v1, v2) return v1[2] > v2[2]; end);
			end
		end
		return list;
	end
	function LT_SharedMethod.UpdateProfitFrame(frame)
		local ProfitFrame = frame.ProfitFrame;
		if ProfitFrame:IsVisible() then
			_log_("UpdateProfitFrame|cff00ff00#1L1|r");
			local list = ProfitFrame.list;
			local pid = frame.flag or __db__.get_pid_by_pname(frame.F_GetSkillName());
			if ProfitFrame.CostOnlyCheck then
				local only_cost = SET[pid].costOnly;
				LT_SharedMethod.ProfitFilterList(frame, list, only_cost);
				ProfitFrame.CostOnlyCheck:SetChecked(only_cost);
			else
				LT_SharedMethod.ProfitFilterList(frame, list);
			end
			ProfitFrame.ScrollFrame:SetNumValue(#list);
			ProfitFrame.ScrollFrame:Update();
		end
	end
	function LT_SharedMethod.ProcessTextFilter(list, searchText, searchNameOnly)
		local item_func = searchNameOnly and __db__.item_name_lower or __db__.item_link_lower;
		local spell_func = searchNameOnly and __db__.spell_name_lower or __db__.spell_link_lower;
		for index = #list, 1, -1 do
			local sid = list[index];
			local info = __db__.get_info_by_sid(sid);
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
	function LT_SharedMethod.FrameFilterList(frame, regular_exp, list, searchText, searchNameOnly)
		if regular_exp then
			searchText = strlower(searchText);
			local result, ret = pcall(LT_SharedMethod.ProcessTextFilter, list, searchText, searchNameOnly);
			if result then
				frame:F_SearchEditValid();
			else
				frame:F_SearchEditInvalid();
			end
		else
			searchText = gsub(strlower(searchText), "[%^%$%%%.%+%-%*%?%[%]%(%)]", "%%%1");
			LT_SharedMethod.ProcessTextFilter(list, searchText, searchNameOnly);
			frame:F_SearchEditValid();
		end
	end
	function LT_SharedMethod.UpdateFrame(frame)
		-- if frame.mute_update then
		-- 	return;
		-- end
		-- frame.mute_update = true;
		if frame.HookedFrame:IsShown() then
			frame:F_LayoutOnShow();
			local skillName, cur_rank, max_rank = frame.F_GetSkillInfo();
			local pid = __db__.get_pid_by_pname(skillName);
			frame.flag = pid;
			if pid ~= nil then
				local set = SET[pid];
				local var = VAR[pid];
				local update_var = var.update or frame.prev_pid ~= pid or var.cur_rank ~= cur_rank or frame.update;
				if not update_var then
					local t = GetTime();
					if t - frame.prev_var_update_time > MAXIMUM_VAR_UPDATE_PERIOD then
						frame.prev_var_update_time = t;
						update_var = true;
					end
				end
				var.update = update_var;	--	Redundancy for error
				local update_list = update_var or set.update;
				set.update = update_list;	--	Redundancy for error
				frame.HaveMaterialsCheck:SetChecked(set.haveMaterials);
				if set.shown then
					frame:Show();
					frame.ToggleButton:SetText(L["Close"]);
				else
					frame:Hide();
					frame.ToggleButton:SetText(L["Open"]);
				end
				if SET.show_call then
					frame.ToggleButton:Show();
				end
				frame:F_ToggleOnSkill(true);
				if frame:IsShown() then
					if update_list then
						local sids = var[1];
						local hash = var[2];
						if update_var then
							_log_("UpdateFrame|cff00ff00#1L1|r");
							local num = frame.F_GetRecipeNumAvailable();
							if num <= 0 then
								-- frame.mute_update = false;
								return;
							end
							var.cur_rank = cur_rank;
							for index = 1, #sids do
								LT_SharedMethod.CancelMarkKnown(sids[index], PLAYER_GUID);
							end
							wipe(sids);
							wipe(hash);
							for index = 1, num do
								local sname, srank = frame.F_GetRecipeInfo(index);
								if sname ~= nil and srank ~= nil and srank ~= 'header' then
									local cid = frame.F_GetRecipeItemID(index);
									if cid ~= nil then
										local sid = __db__.get_sid_by_pid_sname_cid(pid, sname, cid);
										local info = __db__.get_info_by_sid(sid);
										if info ~= nil then
											if hash[sid] ~= nil then
												_error_("UpdateFrame#0E3", pid .. "#" .. cid .. "#" .. sname .. "#" .. sid);
											else
												tinsert(sids, sid);
												hash[sid] = index;
												LT_SharedMethod.MarkKnown(sid, PLAYER_GUID);
											end
											if index == frame.F_GetSelection() then
												frame.selected_sid = sid;
											end
										else
											_error_("UpdateFrame#0E2", pid .. "#" .. cid .. "#" .. sname);
										end
									else
										_error_("UpdateFrame#0E1", pid .. "#" .. sname);
									end
								end
							end
							var.update = nil;
							frame.update = nil;
						else
							_log_("UpdateFrame|cff00ff00#1L2|r");
						end
						if #sids > 0 then
							if frame.prev_pid ~= pid then
								if set.showProfit then
									frame.ProfitFrame:Show();
								else
									frame.ProfitFrame:Hide();
								end
								if set.showSet then
									frame:F_ShowSetFrame(true);
								else
									frame:F_HideSetFrame();
								end
								frame.SearchEditBoxNameOnly:SetChecked(set.searchNameOnly);
							end
							frame.prev_pid = pid;
							frame.hash = hash;
							local list = frame.list;
							__db__.get_ordered_list(pid, list, hash, set.phase, cur_rank, set.rankReversed, set.showKnown, set.showUnkown, set.showHighRank, set.filterClass, set.filterSpec);
							if set.haveMaterials then
								for i = #list, 1, -1 do
									local sid = list[i];
									local index = hash[sid];
									if index == nil or select(3, frame.F_GetRecipeInfo(index)) <= 0 then
										tremove(list, i);
									end
								end
							end
							do
								local C_top = 1;
								for index = 1, #list do
									local sid = list[index];
									if FAV[sid] ~= nil then
										tremove(list, index);
										tinsert(list, C_top, sid);
										C_top = C_top + 1;
									end
								end
							end
							local searchText = set.searchText;
							if searchText ~= nil then
								LT_SharedMethod.FrameFilterList(frame, SET.regular_exp, list, searchText, set.searchNameOnly);
							else
								frame:F_SearchEditValid();
							end
							frame.ScrollFrame:SetNumValue(#list);
							frame.ScrollFrame:Update();
							frame:F_RefreshSetFrame();
							frame:F_RefreshSearchEdit();
							LT_SharedMethod.UpdateProfitFrame(frame);
							set.update = nil;
							__namespace__:FireEvent("USER_EVENT_RECIPE_LIST_UPDATE");
						else
							var.update = true;
							-- frame.mute_update = false;
						end
					else
						_log_("UpdateFrame|cff00ff00#2L1|r");
						if #var[1] > 0 then
							frame.ScrollFrame:Update();
							if frame.ProfitFrame:IsShown() then
								frame.ProfitFrame.ScrollFrame:Update();
							end
						end
					end
				else
					frame.prev_pid = pid;
					var.cur_rank = cur_rank;
					set.update = nil;
					var.update = nil;
					frame.update = nil;
					if update_list then
						local sids = var[1];
						local hash = var[2];
						if update_var then
							_log_("UpdateFrame|cff00ff00#1L1|r");
							local num = frame.F_GetRecipeNumAvailable();
							if num <= 0 then
								-- frame.mute_update = false;
								return;
							end
							var.cur_rank = cur_rank;
							for index = 1, num do
								local sname, srank = frame.F_GetRecipeInfo(index);
								if sname ~= nil and srank ~= nil and srank ~= 'header' then
									local cid = frame.F_GetRecipeItemID(index);
									if cid ~= nil then
										local sid = __db__.get_sid_by_pid_sname_cid(pid, sname, cid);
										local info = __db__.get_info_by_sid(sid);
										if info ~= nil then
											if hash[sid] == nil then
												tinsert(sids, sid);
												hash[sid] = index;
												LT_SharedMethod.MarkKnown(sid, PLAYER_GUID);
											end
										else
											_error_("UpdateFrame#0E2", pid .. "#" .. cid .. "#" .. sname);
										end
									else
										_error_("UpdateFrame#0E1", pid .. "#" .. sname);
									end
								end
							end
							var.update = nil;
							frame.update = nil;
						end
					end
				end
				var.max_rank = max_rank;
				__namespace__.F_CheckCooldown(pid, var);
			else
				frame:Hide();
				frame.ToggleButton:Hide();
				frame:F_ToggleOnSkill(false);
			end
		end
		-- frame.mute_update = false;
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
				"type",
				__db__.item_typeID,
			},
			{
				"subType",
				__db__.item_subTypeID,
			},
			{
				"eqLoc",
				function(iid)
					local loc = __db__.item_loc(iid);
					return loc and T_EquipLoc2ID[loc];
				end,
			},
		};
	function LT_SharedMethod.ExplorerFilterList(frame, stat, filter, searchText, searchNameOnly, list, check_hash, phase, rank, rankReversed, showKnown, showUnkown, showHighRank, filterClass, filterSpec, donot_wipe_list)
		__db__.get_ordered_list(filter.skill, list, check_hash, phase, rank, rankReversed, showKnown, showUnkown, showHighRank, filterClass, filterSpec, donot_wipe_list);
		do
			local C_top = 1;
			for index = 1, #list do
				local sid = list[index];
				if FAV[sid] then
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
					local cid = __db__.get_cid_by_sid(sid);
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
		if searchText then
			LT_SharedMethod.FrameFilterList(frame, SET.regular_exp, list, searchText, searchNameOnly)
		else
			frame:F_SearchEditValid();
		end
		do
			local skill_hash = stat.skill;
			local type_hash = stat.type;
			local subType_hash = stat.subType;
			local eqLoc_hash = stat.eqLoc;
			wipe(skill_hash);
			wipe(type_hash);
			wipe(subType_hash);
			wipe(eqLoc_hash);
			for index = 1, #list do
				local sid = list[index];
				local info = __db__.get_info_by_sid(sid);
				if info ~= nil then
					local pid = info[index_pid];
					skill_hash[pid] = T_LearnedRecipesHash[sid] or {  };
					local cid = info[index_cid];
					if cid then
						local _type = __db__.item_typeID(cid);
						local _subType = __db__.item_subTypeID(cid);
						local _eqLoc = __db__.item_loc(cid);
						local _eqLid = T_EquipLoc2ID[_eqLoc];
						type_hash[_type] = 1;
						subType_hash[_subType] = 1;
						if _eqLid then
							eqLoc_hash[_eqLid] = 1;
						end
					end
				end
			end
		end
		return stat;
	end
	function LT_SharedMethod.UpdateExplorerFrame(frame, update_list)
		if frame:IsVisible() then
			local set = SET.explorer;
			local hash = frame.hash;
			local list = frame.list;
			if update_list then
				_log_("UpdateExplorerFrame|cff00ff00#1L1|r");
				if set.showProfit then
					frame.ProfitFrame:Show();
				else
					frame.ProfitFrame:Hide();
				end
				if set.showSet then
					frame.SetFrame:Show();
				else
					frame.SetFrame:Hide();
				end
				frame.SearchEditBoxNameOnly:SetChecked(set.searchNameOnly);
				LT_SharedMethod.ExplorerFilterList(frame, T_ExplorerStat, set.filter, set.searchText, set.searchNameOnly,
											list, hash, set.phase, nil, set.rankReversed, set.showKnown, set.showUnkown, set.showHighRank, set.filterClass, set.filterSpec);
				LT_SharedMethod.UpdateProfitFrame(frame);
			else
				_log_("UpdateExplorerFrame|cff00ff00#1L2|r");
			end
			frame.ScrollFrame:SetNumValue(#list);
			frame.ScrollFrame:Update();
			frame:F_RefreshSetFrame();
			frame:F_RefreshSearchEdit();
		end
	end
--
--	Shared
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
					local up = CreateFrame("BUTTON", nil, obj);
					up:SetSize(18, 16);
					up:SetPoint("BOTTOM", obj, "TOP");
					up:SetScript("OnClick", function(self)
						obj:SetValue(obj:GetValue() - obj:GetValueStep());
					end);
					obj.ScrollUpButton = up;
					local down = CreateFrame("BUTTON", nil, obj);
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
		function LT_SharedMethod.StyleModernBackdrop(frame)
			uireimp._SetBackdrop(frame, T_UIDefinition.modernFrameBackdrop);
			uireimp._SetBackdropColor(frame, unpack(SET.bg_color));
		end
		function LT_SharedMethod.StyleBLZBackdrop(frame)
			uireimp._SetBackdrop(frame, T_UIDefinition.blzFrameBackdrop);
			uireimp._SetBackdropColor(frame, 1.0, 1.0, 1.0, 1.0);
			uireimp._SetBackdropBorderColor(frame, 1.0, 1.0, 1.0, 1.0);
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
			if texture then
				uireimp._SetSimpleBackdrop(Button, 0, 1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
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
				uireimp._SetSimpleBackdrop(Button, 0, 1, 0.0, 0.0, 0.0, 0.25, 0.75, 1.0, 1.0, 0.25);
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
			if bak then
				Button:SetNormalTexture(bak[1]);
				Button:SetPushedTexture(bak[2]);
				Button:SetHighlightTexture(bak[3]);
				Button:SetDisabledTexture(bak[4]);
			end
			uireimp._SetSimpleBackdrop(Button, 0, 1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
			Button:SetPushedTextOffset(1.55, -1.55);
			local ntex = Button:GetNormalTexture();
			local ptex = Button:GetPushedTexture();
			local htex = Button:GetHighlightTexture();
			local dtex = Button:GetDisabledTexture();
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
					obj.Show = _noop_;
					obj:Hide();
				end
			end
			--
			local bar = ScrollFrame.ScrollBar;
			uireimp._SetSimpleBackdrop(bar, 0, 1, 0.0, 0.0, 0.0, 0.0, 0.25, 0.25, 0.25, 1.0);
			local thumb = bar:GetThumbTexture();
			if thumb == nil then
				bar:SetThumbTexture("Interface\\Buttons\\UI-ScrollBar-Knob");
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
					obj.Show = _noop_;
					obj:Hide();
					-- if obj._Show then
					-- 	obj.Show = obj._Show;
					-- end
					-- obj:Show();
				end
			end
			--
			local bar = ScrollFrame.ScrollBar;
			uireimp._SetSimpleBackdrop(bar, 0, 1, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 0.5);
			bar:SetThumbTexture("Interface\\Buttons\\UI-ScrollBar-Knob");
			bar:GetThumbTexture():SetWidth(bar:GetWidth());
			local up = bar.ScrollUpButton;
			up:SetNormalTexture("Interface\\Buttons\\UI-ScrollBar-ScrollUpButton-Up");
			up:GetNormalTexture():SetTexCoord(0.2, 0.8, 0.25, 0.75);
			up:GetNormalTexture():SetVertexColor(1.0, 1.0, 1.0, 1.0);
			up:SetPushedTexture("Interface\\Buttons\\UI-ScrollBar-ScrollUpButton-Down");
			up:GetPushedTexture():SetTexCoord(0.2, 0.8, 0.25, 0.75);
			up:GetPushedTexture():SetVertexColor(1.0, 1.0, 1.0, 1.0);
			up:SetHighlightTexture("Interface\\Buttons\\UI-ScrollBar-ScrollUpButton-Highlight");
			up:GetHighlightTexture():SetTexCoord(0.2, 0.8, 0.25, 0.75);
			up:GetHighlightTexture():SetVertexColor(1.0, 1.0, 1.0, 1.0);
			up:SetDisabledTexture("Interface\\Buttons\\UI-ScrollBar-ScrollUpButton-Disabled");
			up:GetDisabledTexture():SetTexCoord(0.2, 0.8, 0.25, 0.75);
			up:GetDisabledTexture():SetVertexColor(1.0, 1.0, 1.0, 1.0);
			local down = bar.ScrollDownButton;
			down:SetNormalTexture("Interface\\Buttons\\UI-ScrollBar-ScrollDownButton-Up");
			down:GetNormalTexture():SetTexCoord(0.2, 0.8, 0.25, 0.75);
			down:GetNormalTexture():SetVertexColor(1.0, 1.0, 1.0, 1.0);
			down:SetPushedTexture("Interface\\Buttons\\UI-ScrollBar-ScrollDownButton-Down");
			down:GetPushedTexture():SetTexCoord(0.2, 0.8, 0.25, 0.75);
			down:GetPushedTexture():SetVertexColor(1.0, 1.0, 1.0, 1.0);
			down:SetHighlightTexture("Interface\\Buttons\\UI-ScrollBar-ScrollDownButton-Highlight");
			down:GetHighlightTexture():SetTexCoord(0.2, 0.8, 0.25, 0.75);
			down:GetHighlightTexture():SetVertexColor(1.0, 1.0, 1.0, 1.0);
			down:SetDisabledTexture("Interface\\Buttons\\UI-ScrollBar-ScrollDownButton-Disabled");
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
			Dropdown.SetHeight = _noop_;
			Dropdown:_SetHeight(22);
		end
		function LT_SharedMethod.StyleModernDropDownMenu(Dropdown)
			if not Dropdown.hooked then
				LT_SharedMethod.RelayoutDropDownMenu(Dropdown);
			end
			Dropdown.Left:Hide();
			Dropdown.Middle:Hide();
			Dropdown.Right:Hide();
			uireimp._SetSimpleBackdrop(Dropdown, 0, 1, 0.0, 0.0, 0.0, 0.25, 0.75, 1.0, 1.0, 0.25);
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
			uireimp._SetSimpleBackdrop(Dropdown, 0, 1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
			local Button = Dropdown.Button;
			Button:SetSize(24, 24);
			Button:SetNormalTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Up");
			Button:SetPushedTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Down");
			Button:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight");
			Button:SetDisabledTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Disabled");
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
			uireimp._SetSimpleBackdrop(EditBox, 0, 1, 0.0, 0.0, 0.0, 0.25, 0.75, 1.0, 1.0, 0.25);
		end
		function LT_SharedMethod.StyleBLZEditBox(EditBox)
			local regions = { EditBox:GetRegions() };
			for index = 1, #regions do
				regions[index]:Show();
			end
			uireimp._SetSimpleBackdrop(EditBox, 0, 1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
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
			CheckButton:SetNormalTexture("Interface\\Buttons\\UI-CheckBox-Up");
			CheckButton:GetNormalTexture():SetVertexColor(1.0, 1.0, 1.0, 1.0);
			CheckButton:SetPushedTexture("Interface\\Buttons\\UI-CheckBox-Down");
			CheckButton:GetPushedTexture():SetVertexColor(1.0, 1.0, 1.0, 1.0);
			CheckButton:SetHighlightTexture("Interface\\Buttons\\UI-CheckBox-Highlight");
			CheckButton:GetHighlightTexture():SetVertexColor(1.0, 1.0, 1.0, 1.0);
			CheckButton:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check");
			CheckButton:GetCheckedTexture():SetVertexColor(1.0, 1.0, 1.0, 1.0);
			CheckButton:SetDisabledTexture("Interface\\Buttons\\UI-CheckBox-Up");
			CheckButton:GetDisabledTexture():SetDesaturated(true);
			CheckButton:SetDisabledCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check-Disabled");
			CheckButton:GetDisabledCheckedTexture():SetVertexColor(1.0, 1.0, 1.0, 1.0);
		end
		--
			local SkillButton_TextureHash = {
				["Interface\\Buttons\\UI-MinusButton-Up"] = T_UIDefinition.texture_modern_button_minus,
				["Interface\\Buttons\\UI-PlusButton-Up"] = T_UIDefinition.texture_modern_button_plus,
				["Interface\\Buttons\\UI-PlusButton-Hilight"] = T_UIDefinition.texture_modern_button_plus,
			};
			local SetTextureReplaced = {
				_SetTexture = function(self, tex)
					self:_SetTexture(SkillButton_TextureHash[tex] or tex);
				end,
				_SetNormalTexture = function(self, tex)
					tex = SkillButton_TextureHash[tex] or tex;
					self:_SetNormalTexture(tex);
					self:_SetHighlightTexture(tex);
				end,
				_SetPushedTexture = function(self, tex)
					self:_SetPushedTexture(SkillButton_TextureHash[tex] or tex);
				end,
				_SetHighlightTexture = function(self, tex)
					-- self:_SetHighlightTexture(SkillButton_TextureHash[tex] or tex);
				end,
				_SetDisabledTexture = function(self, tex)
					self:_SetDisabledTexture(SkillButton_TextureHash[tex] or tex);
				end,
			};
		function LT_SharedMethod.StyleModernSkillButton(Button)
			Button._SetNormalTexture = Button._SetNormalTexture or Button.SetNormalTexture;
			Button.SetNormalTexture = SetTextureReplaced._SetNormalTexture;
			local NormalTexture = Button:GetNormalTexture();
			if NormalTexture then
				NormalTexture._SetTexture = NormalTexture._SetTexture or NormalTexture.SetTexture;
				NormalTexture.SetTexture = SetTextureReplaced._SetTexture;
			end
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
				HighlightTexture.SetTexture = _noop_;
			end
			--
			Button._SetDisabledTexture = Button._SetDisabledTexture or Button.SetDisabledTexture;
			Button.SetDisabledTexture = SetTextureReplaced._SetDisabledTexture;
			local DisabledTexture = Button:GetDisabledTexture();
			if DisabledTexture then
				DisabledTexture._SetTexture = DisabledTexture._SetTexture or DisabledTexture.SetTexture;
				DisabledTexture.SetTexture = SetTextureReplaced._SetTexture;
			end
			Button:SetPushedTextOffset(0.0, 0.0);
		end
		function LT_SharedMethod.StyleBLZSkillButton(Button)
			if Button._SetNormalTexture then
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
			end
			Button:SetPushedTextOffset(1.55, -1.55);
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
			Dropdown:SetNormalTexture("interface\\mainmenubar\\ui-mainmenu-scrolldownbutton-up");
			Dropdown:GetNormalTexture():SetTexCoord(6 / 32, 26 / 32, 6 / 32, 26 / 32);
			Dropdown:GetNormalTexture():SetVertexColor(1.0, 1.0, 1.0, 1.0);
			Dropdown:SetPushedTexture("interface\\mainmenubar\\ui-mainmenu-scrolldownbutton-up");
			Dropdown:GetPushedTexture():SetTexCoord(6 / 32, 26 / 32, 6 / 32, 26 / 32);
			Dropdown:GetPushedTexture():SetVertexColor(unpack(T_UIDefinition.textureButtonColorPushed));
			Dropdown:SetHighlightTexture("interface\\mainmenubar\\ui-mainmenu-scrolldownbutton-up");
			Dropdown:GetHighlightTexture():SetTexCoord(6 / 32, 26 / 32, 6 / 32, 26 / 32);
			Dropdown:GetHighlightTexture():SetVertexColor(unpack(T_UIDefinition.textureButtonColorHighlight));
			Dropdown:SetDisabledTexture("interface\\mainmenubar\\ui-mainmenu-scrolldownbutton-up");
			Dropdown:GetDisabledTexture():SetTexCoord(6 / 32, 26 / 32, 6 / 32, 26 / 32);
			Dropdown:GetDisabledTexture():SetVertexColor(unpack(T_UIDefinition.textureButtonColorDisabled));
		end
	--
	function LT_SharedMethod.UICreateSearchBox(frame)
		local SearchEditBox = CreateFrame("EDITBOX", nil, frame);
		SearchEditBox:SetHeight(16);
		SearchEditBox:SetFont(T_UIDefinition.frameFont, T_UIDefinition.frameFontSize, T_UIDefinition.frameFontOutline);
		SearchEditBox:SetAutoFocus(false);
		SearchEditBox:SetJustifyH("LEFT");
		SearchEditBox:Show();
		SearchEditBox:EnableMouse(true);
		SearchEditBox:ClearFocus();
		SearchEditBox:SetScript("OnEnterPressed", function(self) self:ClearFocus(); end);
		SearchEditBox:SetScript("OnEscapePressed", function(self) self:ClearFocus(); end);
		frame.SearchEditBox = SearchEditBox;

		local SearchEditBoxTexture = SearchEditBox:CreateTexture(nil, "ARTWORK");
		SearchEditBoxTexture:SetPoint("TOPLEFT");
		SearchEditBoxTexture:SetPoint("BOTTOMRIGHT");
		SearchEditBoxTexture:SetTexture("Interface\\Buttons\\greyscaleramp64");
		SearchEditBoxTexture:SetTexCoord(0.0, 0.25, 0.0, 0.25);
		SearchEditBoxTexture:SetAlpha(0.75);
		SearchEditBoxTexture:SetBlendMode("ADD");
		SearchEditBoxTexture:SetVertexColor(0.25, 0.25, 0.25);

		local SearchEditBoxNote = SearchEditBox:CreateFontString(nil, "OVERLAY");
		SearchEditBoxNote:SetFont(T_UIDefinition.frameFont, T_UIDefinition.frameFontSize);
		SearchEditBoxNote:SetTextColor(1.0, 1.0, 1.0, 0.5);
		SearchEditBoxNote:SetPoint("LEFT", 4, 0);
		SearchEditBoxNote:SetText(L["Search"]);
		SearchEditBoxNote:Show();

		local SearchEditBoxCancel = CreateFrame("BUTTON", nil, SearchEditBox);
		SearchEditBoxCancel:SetSize(16, 16);
		SearchEditBoxCancel:SetPoint("RIGHT", SearchEditBox);
		SearchEditBoxCancel:Hide();
		SearchEditBoxCancel:SetNormalTexture(T_UIDefinition.texture_modern_button_close);	--	("interface\\petbattles\\deadpeticon");
		SearchEditBoxCancel:SetScript("OnClick", function(self) SearchEditBox:SetText(""); frame:F_Search(""); SearchEditBox:ClearFocus(); end);

		local SearchEditBoxOK = CreateFrame("BUTTON", nil, frame);
		SearchEditBoxOK:SetSize(32, 16);
		SearchEditBoxOK:Disable();
		SearchEditBoxOK:SetNormalTexture(T_UIDefinition.texture_unk);
		SearchEditBoxOK:GetNormalTexture():SetColorTexture(0.25, 0.25, 0.25, 0.5);
		local SearchEditBoxOKText = SearchEditBoxOK:CreateFontString(nil, "OVERLAY");
		SearchEditBoxOKText:SetFont(T_UIDefinition.frameFont, T_UIDefinition.frameFontSize);
		SearchEditBoxOKText:SetTextColor(1.0, 1.0, 1.0, 0.5);
		SearchEditBoxOKText:SetPoint("CENTER");
		SearchEditBoxOKText:SetText(L["OK"]);

		SearchEditBoxOK:SetFontString(SearchEditBoxOKText);
		SearchEditBoxOK:SetPushedTextOffset(0, -1);
		SearchEditBoxOK:SetScript("OnClick", function(self) SearchEditBox:ClearFocus(); end);
		SearchEditBoxOK:SetScript("OnEnable", function(self) SearchEditBoxOKText:SetTextColor(1.0, 1.0, 1.0, 1.0); end);
		SearchEditBoxOK:SetScript("OnDisable", function(self) SearchEditBoxOKText:SetTextColor(1.0, 1.0, 1.0, 0.5); end);
		SearchEditBoxOK:Disable();
		frame.SearchEditBoxOK = SearchEditBoxOK;

		local SearchEditBoxNameOnly = CreateFrame("CHECKBUTTON", nil, frame, "OptionsBaseCheckButtonTemplate");
		SearchEditBoxNameOnly:SetSize(24, 24);
		SearchEditBoxNameOnly:SetHitRectInsets(0, 0, 0, 0);
		SearchEditBoxNameOnly:Show();
		SearchEditBoxNameOnly:SetChecked(false);
		SearchEditBoxNameOnly.info_lines = { L["TIP_SEARCH_NAME_ONLY_INFO"], };
		SearchEditBoxNameOnly:SetScript("OnEnter", LT_SharedMethod.ButtonInfoOnEnter);
		SearchEditBoxNameOnly:SetScript("OnLeave", LT_SharedMethod.ButtonInfoOnLeave);
		SearchEditBoxNameOnly:SetScript("OnClick", function(self)
			local pid = frame.flag or __db__.get_pid_by_pname(frame.F_GetSkillName());
			if pid then
				__namespace__.F_ChangeSetWithUpdate(SET[pid], "searchNameOnly", self:GetChecked());
			end
			frame.F_Update();
		end);
		frame.SearchEditBoxNameOnly = SearchEditBoxNameOnly;

		function frame:F_Search(text)
			local pid = self.flag or __db__.get_pid_by_pname(self.F_GetSkillName());
			if pid then
				if text == "" then
					__namespace__.F_ChangeSetWithUpdate(SET[pid], "searchText", nil);
					if not SearchEditBox:HasFocus() then
						SearchEditBoxNote:Show();
					end
					SearchEditBoxCancel:Hide();
				else
					__namespace__.F_ChangeSetWithUpdate(SET[pid], "searchText", text);
					SearchEditBoxCancel:Show();
					SearchEditBoxNote:Hide();
				end
			end
			self.F_Update();
		end
		function frame:F_RefreshSearchEdit()
			local pid = self.flag or __db__.get_pid_by_pname(self.F_GetSkillName());
			if pid then
				local searchText = SET[pid].searchText or "";
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
		function frame:F_SearchEditValid()
			SearchEditBoxTexture:SetVertexColor(0.25, 0.25, 0.25);
		end
		function frame:F_SearchEditInvalid()
			SearchEditBoxTexture:SetVertexColor(0.25, 0.0, 0.0);
		end
		SearchEditBox:SetScript("OnTextChanged", function(self, isUserInput)
			if isUserInput then
				frame:F_Search(self:GetText());
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
	--	list button handler
		local T_SkillListDropList = {
			AddFav = {
				handler = function(_, frame, pid, sid)
					SET[pid].update = true;
					FAV[sid] = 1;
					frame.F_Update();
				end,
				text = L["add_fav"],
				para = {  },
			},
			SubFav = {
				handler = function(_, frame, pid, sid)
					SET[pid].update = true;
					FAV[sid] = nil;
					frame.F_Update();
				end,
				text = L["sub_fav"],
				para = {  },
			},
			QueryWhoCanCraftIt = {
				handler = function(_, frame, pid, sid)
					__namespace__.F_cmmQuerySpell(sid);
				end,
				text = L["query_who_can_craft_it"],
				para = {  },
			},
		};
		local T_SkillListDropMeta = {
			handler = _noop_,
			elements = {
			},
		};
		if select(2, _G.BNGetInfo()) == 'alex#516722' or select(2, _G.BNGetInfo()) == '单酒窝#51637' then
			T_SkillListDropMeta.elements[2] = T_SkillListDropList.QueryWhoCanCraftIt;
		end
	--
	function LT_SharedMethod.SkillListButton_OnEnter(self)
		local frame = self.frame;
		local sid = self.list[self:GetDataIndex()];
		if type(sid) == 'table' then
			sid = sid[1];
		end
		local pid = self.flag or __db__.get_pid_by_sid(sid);
		if pid ~= nil then
			local set = SET[pid];
			SkillTip.__phase = set.phase;
			SkillTip:SetOwner(self, "ANCHOR_RIGHT");
			local info = __db__.get_info_by_sid(sid);
			if info ~= nil then
				if set.showItemInsteadOfSpell and info[index_cid] then
					SkillTip:SetItemByID(info[index_cid]);
				else
					SkillTip:SetSpellByID(sid);
				end
				local phase = info[index_phase];
				if phase > CURPHASE then
					SkillTip:AddLine("|cffff0000" .. L["available_in_phase_"] .. phase .. "|r");
				end
				SkillTip:Show();
			else
				SkillTip:SetSpellByID(sid);
			end
			local text = __db__.get_difficulty_rank_list_text_by_sid(sid, true);
			if text ~= nil then
				SkillTip:AddDoubleLine(L["LABEL_RANK_LEVEL"], text);
				SkillTip:Show();
			end
			local data = frame.hash[sid];
			if pid == 'explorer' then
				local hash = T_LearnedRecipesHash[sid];
				if hash then
					local str = L["RECIPE_LEARNED"] .. ": ";
					local index = 0;
					for GUID, _ in next, hash do
						if index ~= 0 and index % 3 == 0 then
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
						index = index + 1;
					end
					SkillTip:AddLine(str);
					SkillTip:Show();
				else
				end
				data = data and data[PLAYER_GUID];
			end
			if data == nil then
				__namespace__.F_TooltipAddSource(SkillTip, sid);
			end
		end
	end
	function LT_SharedMethod.SkillListButton_OnLeave(self)
		SkillTip:Hide();
	end
	function LT_SharedMethod.SkillListButton_OnClick(self, button)
		local frame = self.frame;
		local sid = self.list[self:GetDataIndex()];
		if type(sid) == 'table' then
			sid = sid[1];
		end
		local data = frame.hash[sid];
		if button == "LeftButton" then
			if IsShiftKeyDown() then
				__namespace__.F_HandleShiftClick(self.flag or __db__.get_pid_by_sid(sid), sid);
			elseif IsAltKeyDown() then
				local text1 = nil;
				local text2 = nil;
				if data and __db__.T_TradeSkill_ID[frame.flag] ~= nil then
					local n = frame.F_GetRecipeNumReagents(data);
					if n and n > 0 then
						local m1, m2 = frame.F_GetRecipeNumMade(data);
						if m1 == m2 then
							text1 = frame.F_GetRecipeItemLink(data) .. "x" .. m1 .. L["PRINT_MATERIALS: "];
						else
							text1 = frame.F_GetRecipeItemLink(data) .. "x" .. m1 .. "-" .. m2 .. L["PRINT_MATERIALS: "];
						end
						text2 = "";
						if n > 4 then
							for i = 1, n do
								text2 = text2 .. frame.F_GetRecipeReagentInfo(data, i) .. "x" .. select(3, frame.F_GetRecipeReagentInfo(data, i));
							end
						else
							for i = 1, n do
								text2 = text2 .. frame.F_GetRecipeReagentLink(data, i) .. "x" .. select(3, frame.F_GetRecipeReagentInfo(data, i));
							end
						end
					end
				else
					local info = __db__.get_info_by_sid(sid);
					local cid = info[index_cid];
					if info ~= nil then
						if cid then
							text1 = __db__.item_link_s(cid) .. "x" .. (info[index_num_made_min] == info[index_num_made_max] and info[index_num_made_min] or (info[index_num_made_min] .. "-" .. info[index_num_made_max])) .. L["PRINT_MATERIALS: "];
						else
							text1 = __db__.spell_name_s(sid) .. L["PRINT_MATERIALS: "];
						end
						text2 = "";
						local rinfo = info[index_reagents_id];
						if #rinfo > 4 then
							for i = 1, #rinfo do
								text2 = text2 .. __db__.item_name_s(rinfo[i]) .. "x" .. info[index_reagents_count][i];
							end
						else
							for i = 1, #rinfo do
								text2 = text2 .. __db__.item_link_s(rinfo[i]) .. "x" .. info[index_reagents_count][i];
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
			elseif IsControlKeyDown() then
				local cid = __db__.get_cid_by_sid(sid);
				if cid then
					local link = __db__.item_link(cid);
					if link then
						DressUpItemLink(link);
					end
				end
			else
				if data and type(data) == 'number' then
					frame.F_SetSelection(data);
					frame.HookedFrame.numAvailable = select(3, frame.F_GetRecipeInfo(data));
					frame.selected_sid = sid;
					frame.F_Update();
					frame.SearchEditBox:ClearFocus();
					local HookedScrollBar = frame.HookedScrollBar;
					local num = frame.F_GetRecipeNumAvailable();
					local minVal, maxVal = HookedScrollBar:GetMinMaxValues();
					local step = HookedScrollBar:GetValueStep();
					local cur = HookedScrollBar:GetValue() + step;
					local value = step * (data - 1);
					if value < cur or value > (cur + num * step - maxVal) then
						HookedScrollBar:SetValue(min(maxVal, value));
					end
					frame.ScrollFrame:Update();
					if frame.ProfitFrame:IsShown() then
						frame.ProfitFrame.ScrollFrame:Update();
					end
				end
			end
		elseif button == "RightButton" then
			frame.SearchEditBox:ClearFocus();
			local pid = __db__.get_pid_by_sid(sid);
			if FAV[sid] then
				T_SkillListDropList.SubFav.para[1] = frame;
				T_SkillListDropList.SubFav.para[2] = pid;
				T_SkillListDropList.SubFav.para[3] = sid;
				T_SkillListDropMeta.elements[1] = T_SkillListDropList.SubFav;
			else
				T_SkillListDropList.AddFav.para[1] = frame;
				T_SkillListDropList.AddFav.para[2] = pid;
				T_SkillListDropList.AddFav.para[3] = sid;
				T_SkillListDropMeta.elements[1] = T_SkillListDropList.AddFav;
			end
			T_SkillListDropList.QueryWhoCanCraftIt.para[1] = frame;
			T_SkillListDropList.QueryWhoCanCraftIt.para[2] = pid;
			T_SkillListDropList.QueryWhoCanCraftIt.para[3] = sid;
			ALADROP(self, "BOTTOMLEFT", T_SkillListDropMeta);
		end
	end
	function LT_SharedMethod.ProfitCreateSkillListButton(parent, index, buttonHeight)
		local Button = CreateFrame("BUTTON", nil, parent);
		Button:SetHeight(buttonHeight);
		uireimp._SetSimpleBackdrop(Button, 0, 1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
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
		Title:SetFont(T_UIDefinition.frameFont, T_UIDefinition.frameFontSize, T_UIDefinition.frameFontOutline);
		Title:SetPoint("LEFT", Icon, "RIGHT", 4, 0);
		-- Title:SetWidth(160);
		Title:SetMaxLines(1);
		Title:SetJustifyH("LEFT");
		Button.Title = Title;

		local Note = Button:CreateFontString(nil, "ARTWORK");
		Note:SetFont(T_UIDefinition.frameFont, T_UIDefinition.frameFontSize, T_UIDefinition.frameFontOutline);
		Note:SetPoint("RIGHT", -4, 0);
		Button.Note = Note;

		Title:SetPoint("RIGHT", Note, "LEFT", -4, 0);

		local QualityGlow = Button:CreateTexture(nil, "ARTWORK");
		QualityGlow:SetTexture("Interface\\Buttons\\UI-ActionButton-Border");
		QualityGlow:SetBlendMode("ADD");
		QualityGlow:SetTexCoord(0.25, 0.75, 0.25, 0.75);
		QualityGlow:SetSize(buttonHeight - 2, buttonHeight - 2);
		QualityGlow:SetPoint("CENTER", Icon);
		-- QualityGlow:SetAlpha(0.75);
		QualityGlow:Show();
		Button.QualityGlow = QualityGlow;

		local Star = Button:CreateTexture(nil, "OVERLAY");
		Star:SetTexture("interface\\collections\\collections");
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
		Button:SetScript("OnHide", ALADROP);

		function Button:Select()
			SelectionGlow:Show();
		end
		function Button:Deselect()
			SelectionGlow:Hide();
		end

		local frame = parent:GetParent():GetParent();
		Button.frame = frame:GetParent();
		Button.list = frame.list;
		Button.flag = frame.flag;

		return Button;
	end
	function LT_SharedMethod.ProfitSetSkillListButton(Button, data_index)
		local frame = Button.frame;
		local list = Button.list;
		local hash = frame.hash;
		if data_index <= #list then
			local val = list[data_index];
			local sid = val[1];
			local cid = __db__.get_cid_by_sid(sid);
			local data = hash[sid];
			if data ~= nil then
				if frame.flag == 'explorer' then
					Button:Show();
					local _, quality, icon;
					if cid ~= nil then
						_, _, quality, _, icon = __db__.item_info(cid);
					else
						quality = nil;
						icon = ICON_FOR_NO_CID;
					end
					uireimp._SetSimpleBackdropCenter(Button, 0, 1, 0.0, 0.0, 0.0, 1.0);
					Button.Icon:SetTexture(icon);
					Button.Icon:SetVertexColor(1.0, 1.0, 1.0, 1.0);
					Button.Title:SetText(__db__.spell_name_s(sid));
					Button.Title:SetTextColor(0.0, 1.0, 0.0, 1.0);
					Button.Note:SetText(AuctionMod.F_GetMoneyString(val[2]));
					if quality ~= nil then
						local r, g, b, code = GetItemQualityColor(quality);
						Button.QualityGlow:SetVertexColor(r, g, b);
						Button.QualityGlow:Show();
					else
						Button.QualityGlow:Hide();
					end
					if FAV[sid] ~= nil then
						Button.Star:Show();
					else
						Button.Star:Hide();
					end
					Button:Deselect();
				else
					local name, rank, num = frame.F_GetRecipeInfo(data);
					if name ~= nil and rank ~= 'header' then
						Button:Show();
						uireimp._SetSimpleBackdropCenter(Button, 0, 1, 0.0, 0.0, 0.0, 1.0);
						local _, quality, icon;
						if cid ~= nil then
							_, _, quality, _, icon = __db__.item_info(cid);
						else
							quality = nil;
							icon = ICON_FOR_NO_CID;
						end
						Button.Icon:SetTexture(frame.F_GetRecipeIcon(data));
						Button.Icon:SetVertexColor(1.0, 1.0, 1.0, 1.0);
						if num > 0 then
							Button.Title:SetText(name .. " [" .. num .. "]");
						else
							Button.Title:SetText(name);
						end
						Button.Title:SetTextColor(unpack(T_RankColor[T_RankIndex[rank]] or T_UIDefinition.color_white));
						Button.Note:SetText(AuctionMod.F_GetMoneyString(val[2]));
						if quality ~= nil then
							local r, g, b, code = GetItemQualityColor(quality);
							Button.QualityGlow:SetVertexColor(r, g, b);
							Button.QualityGlow:Show();
						else
							Button.QualityGlow:Hide();
						end
						if FAV[sid] ~= nil then
							Button.Star:Show();
						else
							Button.Star:Hide();
						end
						if GetMouseFocus() == Button then
							LT_SharedMethod.SkillListButton_OnEnter(Button);
						end
						if sid == frame.selected_sid then
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
				if SET.colored_rank_for_unknown and frame.flag ~= 'explorer' then
					uireimp._SetSimpleBackdropCenter(Button, 0, 1, 0.5, 0.25, 0.25, 0.5);
				else
					uireimp._SetSimpleBackdropCenter(Button, 0, 1, 0.0, 0.0, 0.0, 1.0);
				end
				local _, quality, icon;
				if cid ~= nil then
					_, _, quality, _, icon = __db__.item_info(cid);
				else
					quality = nil;
					icon = ICON_FOR_NO_CID;
				end
				Button.Icon:SetTexture(icon);
				Button.Icon:SetVertexColor(1.0, 0.0, 0.0, 1.0);
				Button.Title:SetText(__db__.spell_name_s(sid));
				if SET.colored_rank_for_unknown and frame.flag ~= 'explorer' then
					local pid = __db__.get_pid_by_sid(sid);
					local var = rawget(VAR, pid);
					local cur_rank = var and var.cur_rank or 0;
					Button.Title:SetTextColor(unpack(T_RankColor[__db__.get_difficulty_rank_by_sid(sid, cur_rank)] or T_UIDefinition.color_white));
				else
					Button.Title:SetTextColor(1.0, 0.0, 0.0, 1.0);
				end
				Button.Note:SetText(AuctionMod.F_GetMoneyString(val[2]));
				if quality ~= nil then
					local r, g, b, code = GetItemQualityColor(quality);
					Button.QualityGlow:SetVertexColor(r, g, b);
					Button.QualityGlow:Show();
				else
					Button.QualityGlow:Hide();
				end
				if FAV[sid] ~= nil then
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
				ALADROP(Button);
				Button.prev_sid = sid;
			end
			Button.val = val;
		else
			ALADROP(Button);
			Button:Hide();
			Button.val = nil;
		end
	end
--
--	SkillFrame
	local function LF_BLZSkillListButton_OnEnter(self)
		if SET.default_skill_button_tip then
			local frame = self.frame;
			local index = self:GetID();
			local link = frame.F_GetRecipeItemLink(index);
			if link ~= nil then
				SkillTip.__phase = CURPHASE;
				SkillTip:SetOwner(self, "ANCHOR_RIGHT");
				SkillTip:SetHyperlink(link);
				SkillTip:Show();
			else
				SkillTip:Hide();
			end
		end
	end
	local function LF_CreateSkillListButton(parent, index, buttonHeight)
		local Button = CreateFrame("BUTTON", nil, parent);
		Button:SetHeight(buttonHeight);
		uireimp._SetSimpleBackdrop(Button, 0, 1, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0);
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
		Title:SetFont(T_UIDefinition.frameFont, T_UIDefinition.frameFontSize, T_UIDefinition.frameFontOutline);
		Title:SetPoint("LEFT", Icon, "RIGHT", 2, 0);
		-- Title:SetWidth(160);
		Title:SetMaxLines(1);
		Title:SetJustifyH("LEFT");
		Button.Title = Title;

		local Num = Button:CreateFontString(nil, "OVERLAY");
		Num:SetFont(T_UIDefinition.frameFont, T_UIDefinition.frameFontSize, T_UIDefinition.frameFontOutline);
		Num:SetPoint("LEFT", Title, "RIGHT", 2, 0);
		-- Num:SetWidth(160);
		Num:SetMaxLines(1);
		Num:SetJustifyH("LEFT");
		Button.Num = Num;

		local Note = Button:CreateFontString(nil, "ARTWORK");
		Note:SetFont(T_UIDefinition.frameFont, T_UIDefinition.frameFontSize - 1, T_UIDefinition.frameFontOutline);
		Note:SetPoint("RIGHT", -4, 0);
		Button.Note = Note;

		local QualityGlow = Button:CreateTexture(nil, "ARTWORK");
		QualityGlow:SetTexture("Interface\\Buttons\\UI-ActionButton-Border");
		QualityGlow:SetBlendMode("ADD");
		QualityGlow:SetTexCoord(0.25, 0.75, 0.25, 0.75);
		QualityGlow:SetSize(buttonHeight - 2, buttonHeight - 2);
		QualityGlow:SetPoint("CENTER", Icon);
		-- QualityGlow:SetAlpha(0.75);
		QualityGlow:Show();
		Button.QualityGlow = QualityGlow;

		local Star = Button:CreateTexture(nil, "OVERLAY");
		Star:SetTexture("interface\\collections\\collections");
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
		Button:SetScript("OnHide", ALADROP);

		function Button:Select()
			SelectionGlow:Show();
		end
		function Button:Deselect()
			SelectionGlow:Hide();
		end

		local frame = parent:GetParent():GetParent();
		Button.frame = frame;
		Button.list = frame.list;
		Button.flag = frame.flag;

		return Button;
	end
	local function LF_SetSkillListButton(Button, data_index)
		local frame = Button.frame;
		local list = Button.list;
		local hash = frame.hash;
		if data_index <= #list then
			local sid = list[data_index];
			local pid = frame.flag or __db__.get_pid_by_sid(sid);
			local set = SET[pid];
			local cid = __db__.get_cid_by_sid(sid);
			local data = hash[sid];
			if data ~= nil then
				local name, rank, num = frame.F_GetRecipeInfo(data);
				if name ~= nil and rank ~= 'header' then
					Button:Show();
					uireimp._SetSimpleBackdropCenter(Button, 0, 1, 0.0, 0.0, 0.0, 1.0);
					local quality = cid and __db__.item_rarity(cid);
					Button.Icon:SetTexture(frame.F_GetRecipeIcon(data));
					Button.Icon:SetVertexColor(1.0, 1.0, 1.0, 1.0);
					Button.Title:SetWidth(0);
					Button.Title:SetText(name);
					Button.Title:SetTextColor(unpack(T_RankColor[T_RankIndex[rank]] or T_UIDefinition.color_white));
					if num > 0 then
						if Button.Title:GetWidth() > 150 then
							Button.Title:SetWidth(150);
						end
						Button.Num:SetText("[" .. num .. "]");
						Button.Num:SetTextColor(unpack(T_RankColor[T_RankIndex[rank]] or T_UIDefinition.color_white));
					else
						Button.Title:SetWidth(160);
						Button.Num:SetText(nil);
					end
					if set.showRank then
						Button.Note:SetText(__db__.get_difficulty_rank_list_text_by_sid(sid, false));
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
					if FAV[sid] ~= nil then
						Button.Star:Show();
					else
						Button.Star:Hide();
					end
					if sid == frame.selected_sid then
						Button:Select();
					else
						Button:Deselect();
					end
				else
					Button:Hide();
				end
			else
				Button:Show();
				if SET.colored_rank_for_unknown then
					uireimp._SetSimpleBackdropCenter(Button, 0, 1, 0.5, 0.25, 0.25, 0.5);
				else
					uireimp._SetSimpleBackdropCenter(Button, 0, 1, 0.0, 0.0, 0.0, 1.0);
				end
				local _, quality, icon;
				if cid ~= nil then
					_, _, quality, _, icon = __db__.item_info(cid);
				else
					quality = nil;
					icon = ICON_FOR_NO_CID;
				end
				Button.Icon:SetTexture(icon);
				Button.Icon:SetVertexColor(1.0, 0.0, 0.0, 1.0);
				Button.Title:SetText(__db__.spell_name_s(sid));
				if SET.colored_rank_for_unknown then
					local var = rawget(VAR, pid);
					Button.Title:SetTextColor(unpack(T_RankColor[__db__.get_difficulty_rank_by_sid(sid, var and var.cur_rank or 0)] or T_UIDefinition.color_white));
				else
					Button.Title:SetTextColor(1.0, 0.0, 0.0, 1.0);
				end
				Button.Num:SetText(nil);
				if set.showRank then
					Button.Note:SetText(__db__.get_difficulty_rank_list_text_by_sid(sid, false));
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
				if FAV[sid] ~= nil then
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
				ALADROP(Button);
				Button.prev_sid = sid;
			end
		else
			ALADROP(Button);
			Button:Hide();
		end
	end
	local function F_FrameUpdatePriceInfo(frame)
		local T_PriceInfoInFrame = frame.T_PriceInfoInFrame;
		if AuctionMod ~= nil and SET.show_tradeskill_frame_price_info then
			local sid = frame.selected_sid;
			if sid == nil or sid <= 0 then
				T_PriceInfoInFrame[1]:SetText(nil);
				T_PriceInfoInFrame[2]:SetText(nil);
				T_PriceInfoInFrame[3]:SetText(nil);
				return;
			end
			local info = __db__.get_info_by_sid(sid);
			if info ~= nil then
				local pid = info[index_pid];
				local nMade = (info[index_num_made_min] + info[index_num_made_max]) / 2;
				local price_a_product, _, price_a_material, unk_in, cid = __namespace__.F_GetPriceInfoBySID(SET[pid].phase, sid, nMade);
				if price_a_material > 0 then
					T_PriceInfoInFrame[2]:SetText(
						L["COST_PRICE"] .. ": " ..
						(unk_in > 0 and (AuctionMod.F_GetMoneyString(price_a_material) .. " (|cffff0000" .. unk_in .. L["ITEMS_UNK"] .. "|r)") or AuctionMod.F_GetMoneyString(price_a_material))
					);
				else
					T_PriceInfoInFrame[2]:SetText(
						L["COST_PRICE"] .. ": " ..
						"|cffff0000" .. L["PRICE_UNK"] .. "|r"
					);
				end

				if cid ~= nil then
					-- local price_a_product = AuctionMod.F_QueryPriceByID(cid);
					local price_v_product = __db__.item_sellPrice(info[index_cid]);
					-- local minMade, maxMade = frame.num_made(index);
					-- local nMade = (minMade + maxMade) / 2;
					-- price_a_product = price_a_product and price_a_product * nMade;
					price_v_product = price_v_product and price_v_product * nMade;
					if price_a_product and price_a_product > 0 then
						T_PriceInfoInFrame[1]:SetText(
							L["AH_PRICE"] .. ": " ..
							AuctionMod.F_GetMoneyString(price_a_product) .. " (" .. L["VENDOR_RPICE"] .. (price_v_product and AuctionMod.F_GetMoneyString(price_v_product) or L["NEED_UPDATE"]) .. ")"
						);
						if price_a_material > 0 then
							local diff = price_a_product - price_a_material;
							local diffAH = price_a_product * 0.95 - price_a_material;
							if diff > 0 then
								if diffAH > 0 then
									T_PriceInfoInFrame[3]:SetText(L["PRICE_DIFF+"] .. ": " .. AuctionMod.F_GetMoneyString(diff) .. " (" .. L["PRICE_DIFF_AH+"] .. " " .. AuctionMod.F_GetMoneyString(diffAH) .. ")");
								elseif diffAH < 0 then
									T_PriceInfoInFrame[3]:SetText(L["PRICE_DIFF+"] .. ": " .. AuctionMod.F_GetMoneyString(diff) .. " (" .. L["PRICE_DIFF_AH-"] .. " " .. AuctionMod.F_GetMoneyString(-diffAH) .. ")");
								else
									T_PriceInfoInFrame[3]:SetText(L["PRICE_DIFF+"] .. ": " .. AuctionMod.F_GetMoneyString(diff) .. " (" .. L["PRICE_DIFF_AH0"] .. " " .. L["PRICE_DIFF0"] .. ")");
								end
							elseif diff < 0 then
								T_PriceInfoInFrame[3]:SetText(L["PRICE_DIFF-"] .. ": " .. AuctionMod.F_GetMoneyString(-diff) .. " (" .. L["PRICE_DIFF_AH-"] .. " " .. AuctionMod.F_GetMoneyString(-diffAH) .. ")");
							else
								if diffAH < 0 then
									T_PriceInfoInFrame[3]:SetText(L["PRICE_DIFF0"] .. " (" .. L["PRICE_DIFF_AH-"] .. " " .. AuctionMod.F_GetMoneyString(-diffAH) .. ")");
								else
								end
							end
						else
							T_PriceInfoInFrame[3]:SetText(nil);
						end
					else
						local bindType = __db__.item_bindType(cid);
						if bindType == 1 or bindType == 4 then
							T_PriceInfoInFrame[1]:SetText(
								L["AH_PRICE"] .. ": " ..
								L["BOP"] .. " (" .. L["VENDOR_RPICE"] .. (price_v_product and AuctionMod.F_GetMoneyString(price_v_product) or L["NEED_UPDATE"]) .. ")"
							);
						else
							T_PriceInfoInFrame[1]:SetText(
								L["AH_PRICE"] .. ": " ..
								"|cffff0000" .. L["PRICE_UNK"] .. "|r (" .. L["VENDOR_RPICE"] .. (price_v_product and AuctionMod.F_GetMoneyString(price_v_product) or L["NEED_UPDATE"]) .. ")"
							);
						end
						T_PriceInfoInFrame[3]:SetText(nil);
					end
				end
			else
				T_PriceInfoInFrame[1]:SetText(nil);
				T_PriceInfoInFrame[2]:SetText(nil);
				T_PriceInfoInFrame[3]:SetText(nil);
			end
		else
			T_PriceInfoInFrame[1]:SetText(nil);
			T_PriceInfoInFrame[2]:SetText(nil);
			T_PriceInfoInFrame[3]:SetText(nil);
		end
	end
	local function F_FrameUpdateRankInfo(frame)
		if SET.show_tradeskill_frame_rank_info then
			frame.RankInfoInFrame:SetText(__db__.get_difficulty_rank_list_text_by_sid(frame.selected_sid, true));
		else
			frame.RankInfoInFrame:SetText(nil);
		end
	end
	--
	local function LF_FrameExpand(frame, expanded)
		local T_StyleLayout = frame.T_StyleLayout;
		local layout = T_StyleLayout[expanded and 'expand' or 'normal'];
		frame:ClearAllPoints();
		for index = 1, #layout.anchor do
			frame:SetPoint(unpack(layout.anchor[index]));
		end
		frame:SetSize(unpack(layout.size));
		frame.HookedFrame:SetSize(unpack(layout.frame_size));
		frame.HookedScrollFrame:ClearAllPoints();
		for index = 1, #layout.scroll_anchor do
			frame.HookedScrollFrame:SetPoint(unpack(layout.scroll_anchor[index]));
		end
		frame.HookedScrollFrame:SetSize(unpack(layout.scroll_size));
		frame.HookedDetailFrame:ClearAllPoints();
		for index = 1, #layout.detail_anchor do
			frame.HookedDetailFrame:SetPoint(unpack(layout.detail_anchor[index]));
		end
		frame.HookedDetailFrame:SetSize(unpack(layout.detail_size));
		frame.HookedDetailFrame:UpdateScrollChildRect();
		if expanded then
			frame.TextureLineBottom:Hide();
			frame.HookedRankFrame:SetWidth(360);
			SetUIPanelAttribute(frame.HookedFrame, 'width', 684);
			_G[T_StyleLayout.C_VariableName_NumSkillListButton] = layout.scroll_button_num;
			frame.F_HookedFrameUpdate();
		else
			frame.TextureLineBottom:Show();
			frame.HookedRankFrame:SetWidth(240);
			SetUIPanelAttribute(frame.HookedFrame, 'width', 353);
			_G[T_StyleLayout.C_VariableName_NumSkillListButton] = layout.scroll_button_num;
			for index = layout.scroll_button_num + 1, T_StyleLayout.expand.scroll_button_num do
				frame.T_SkillListButtons[index]:Hide();
			end
		end
	end
	local function LF_FrameBlzStyle(frame, blz_style, loading)
		if blz_style then
			LT_SharedMethod.StyleBLZScrollFrame(frame.ScrollFrame);
			local FilterDropdown = frame.FilterDropdown;
			if FilterDropdown ~= nil then
				LT_SharedMethod.StyleBLZALADropButton(FilterDropdown, not loading and FilterDropdown.backup or nil);
			end
			LT_SharedMethod.StyleBLZCheckButton(frame.HaveMaterialsCheck);
			frame.HaveMaterialsCheck:SetSize(24, 24);
			LT_SharedMethod.StyleBLZCheckButton(frame.SearchEditBoxNameOnly);
			frame.SearchEditBoxNameOnly:SetSize(24, 24);
			local SetFrame = frame.SetFrame;
			SetFrame:SetWidth(344);
			LT_SharedMethod.StyleBLZBackdrop(SetFrame);
			local T_CheckButtons = SetFrame.T_CheckButtons;
			for index = 1, #T_CheckButtons do
				local CheckButton = T_CheckButtons[index];
				LT_SharedMethod.StyleBLZCheckButton(CheckButton);
				CheckButton:SetSize(24, 24);
			end
			local ProfitFrame = frame.ProfitFrame;
			LT_SharedMethod.StyleBLZBackdrop(ProfitFrame);
			LT_SharedMethod.StyleBLZScrollFrame(ProfitFrame.ScrollFrame);
			LT_SharedMethod.StyleBLZCheckButton(ProfitFrame.CostOnlyCheck);
			ProfitFrame.CostOnlyCheck:SetSize(24, 24);
			local ProfitFrameCloseButton = ProfitFrame.CloseButton;
			ProfitFrameCloseButton:SetSize(32, 32);
			LT_SharedMethod.StyleBLZButton(ProfitFrameCloseButton, not loading and ProfitFrameCloseButton.backup or nil);

			frame.HookedFrame:SetHitRectInsets(11, 29, 9, 67);
			local TextureBackground = frame.TextureBackground;
			TextureBackground:ClearAllPoints();
			TextureBackground:SetPoint("TOPLEFT", 11, -7);
			TextureBackground:SetPoint("BOTTOMRIGHT", -29, 67);
			LT_SharedMethod.StyleBLZBackdrop(TextureBackground);
			local TextureLineTop = frame.TextureLineTop;
			TextureLineTop:SetTexture("Interface\\Dialogframe\\UI-Dialogbox-Divider", "MIRROR");
			TextureLineTop:SetTexCoord(4 / 256, 188 / 256, 5 / 32, 13 / 32);
			TextureLineTop:SetHeight(2);
			local TextureLineMiddle = frame.TextureLineMiddle;
			TextureLineMiddle:SetTexture("Interface\\Dialogframe\\UI-Dialogbox-Divider", "MIRROR");
			TextureLineMiddle:SetTexCoord(4 / 256, 188 / 256, 5 / 32, 13 / 32);
			TextureLineMiddle:SetHeight(2);
			local TextureLineBottom = frame.TextureLineBottom;
			TextureLineBottom:SetTexture("Interface\\Dialogframe\\UI-Dialogbox-Divider", "MIRROR");
			TextureLineBottom:SetTexCoord(4 / 256, 188 / 256, 5 / 32, 13 / 32);
			TextureLineBottom:SetHeight(2);

			LT_SharedMethod.StyleBLZScrollFrame(frame.HookedScrollFrame);
			LT_SharedMethod.StyleBLZScrollFrame(frame.HookedDetailFrame);
			local HookedRankFrame = frame.HookedRankFrame;
			HookedRankFrame.Border:Show();
			uireimp._SetSimpleBackdrop(HookedRankFrame, 0, 1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
			frame.PortraitBorder:Show();
			local T_HookedFrameWidgets = frame.T_HookedFrameWidgets;
			local T_HookedFrameButtons = T_HookedFrameWidgets.T_HookedFrameButtons;
			if T_HookedFrameButtons.IncrementButton then
				T_HookedFrameButtons.IncrementButton:SetSize(23, 22);
			end
			if T_HookedFrameButtons.DecrementButton then
				T_HookedFrameButtons.DecrementButton:SetSize(23, 22);
			end
			T_HookedFrameButtons.CloseButton:SetSize(32, 32);
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
			for index = 1, #frame.T_SkillListButtons do
				LT_SharedMethod.StyleBLZSkillButton(frame.T_SkillListButtons[index]);
			end
			if T_HookedFrameWidgets.CollapseAllButton ~= nil then
				LT_SharedMethod.StyleBLZSkillButton(T_HookedFrameWidgets.CollapseAllButton);
			end
			frame.F_HookedFrameUpdate();
		else
			LT_SharedMethod.StyleModernScrollFrame(frame.ScrollFrame);
			local FilterDropdown = frame.FilterDropdown;
			if FilterDropdown ~= nil then
				LT_SharedMethod.StyleModernALADropButton(FilterDropdown);
			end
			LT_SharedMethod.StyleModernCheckButton(frame.HaveMaterialsCheck);
			frame.HaveMaterialsCheck:SetSize(14, 14);
			LT_SharedMethod.StyleModernCheckButton(frame.SearchEditBoxNameOnly);
			frame.SearchEditBoxNameOnly:SetSize(14, 14);
			local SetFrame = frame.SetFrame;
			SetFrame:SetWidth(332);
			LT_SharedMethod.StyleModernBackdrop(SetFrame);
			local T_CheckButtons = SetFrame.T_CheckButtons;
			for index = 1, #T_CheckButtons do
				local CheckButton = T_CheckButtons[index];
				LT_SharedMethod.StyleModernCheckButton(CheckButton);
				CheckButton:SetSize(14, 14);
			end
			local ProfitFrame = frame.ProfitFrame;
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

			frame.HookedFrame:SetHitRectInsets(17, 35, 11, 73);
			local TextureBackground = frame.TextureBackground;
			TextureBackground:ClearAllPoints();
			TextureBackground:SetPoint("TOPLEFT", 11, -12);
			TextureBackground:SetPoint("BOTTOMRIGHT", -32, 76);
			LT_SharedMethod.StyleModernBackdrop(TextureBackground);
			local TextureLineTop = frame.TextureLineTop;
			TextureLineTop:SetColorTexture(unpack(T_UIDefinition.modernDividerColor));
			TextureLineTop:SetHeight(1);
			local TextureLineMiddle = frame.TextureLineMiddle;
			TextureLineMiddle:SetColorTexture(unpack(T_UIDefinition.modernDividerColor));
			TextureLineMiddle:SetHeight(1);
			local TextureLineBottom = frame.TextureLineBottom;
			TextureLineBottom:SetColorTexture(unpack(T_UIDefinition.modernDividerColor));
			TextureLineBottom:SetHeight(1);

			LT_SharedMethod.StyleModernScrollFrame(frame.HookedScrollFrame);
			LT_SharedMethod.StyleModernScrollFrame(frame.HookedDetailFrame);
			local HookedRankFrame = frame.HookedRankFrame;
			HookedRankFrame.Border:Hide();
			uireimp._SetSimpleBackdrop(HookedRankFrame, 0, 1, 0.0, 0.0, 0.0, 0.0, 0.25, 0.25, 0.25, 1.0);
			frame.PortraitBorder:Hide();
			local T_HookedFrameWidgets = frame.T_HookedFrameWidgets;
			local T_HookedFrameButtons = T_HookedFrameWidgets.T_HookedFrameButtons;
			if T_HookedFrameButtons.IncrementButton ~= nil then
				T_HookedFrameButtons.IncrementButton:SetSize(14, 14);
			end
			if T_HookedFrameButtons.DecrementButton ~= nil then
				T_HookedFrameButtons.DecrementButton:SetSize(14, 14);
			end
			T_HookedFrameButtons.CloseButton:SetSize(16, 16);
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
			for index = 1, #frame.T_SkillListButtons do
				LT_SharedMethod.StyleModernSkillButton(frame.T_SkillListButtons[index]);
			end
			if T_HookedFrameWidgets.CollapseAllButton ~= nil then
				LT_SharedMethod.StyleModernSkillButton(T_HookedFrameWidgets.CollapseAllButton);
			end
			frame.F_HookedFrameUpdate();
		end
	end
	local function LF_FrameFixSkillList(frame, expanded)
		local layout = frame.T_StyleLayout[expanded and 'expand' or 'normal'];
		local pref = frame.T_HookedFrameWidgets.C_SkillListButtonNamePrefix;
		local index = layout.scroll_button_num + 1;
		while true do
			local Skill = _G[pref .. index];
			if Skill == nil then
				return;
			end
			Skill:Hide();
			frame.T_SkillListButtons[index] = frame.T_SkillListButtons[index] or Skill;
			index = index + 1;
		end
	end
	local function LF_HookFrame(addon, meta)
		local HookedFrame = meta.HookedFrame;
		local frame = CreateFrame("FRAME", nil, HookedFrame);
		HookedFrame.frame = frame;

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
						point[2] = frame;
					end
				end
			end
			if layout.scroll_anchor ~= nil then
				for index = 1, #layout.scroll_anchor do
					local point = layout.scroll_anchor[index];
					if point[2] == nil then
						point[2] = frame;
					end
				end
			end
			if layout.detail_anchor ~= nil then
				for index = 1, #layout.detail_anchor do
					local point = layout.detail_anchor[index];
					if point[2] == nil then
						point[2] = frame;
					end
				end
			end
		end
		for key, val in next, meta do
			frame[key] = val;
		end

		local function LF_ToggleFrame()
			local pid = frame.flag or __db__.get_pid_by_pname(frame.F_GetSkillName());
			if frame:IsShown() then
				frame:Hide();
				frame.ToggleButton:SetText(L["Open"]);
				if pid ~= nil then
					SET[pid].shown = false;
				end
			else
				frame:Show();
				frame.ToggleButton:SetText(L["Close"]);
				if pid ~= nil then
					SET[pid].shown = true;
				end
				frame.update = true;
				frame.F_Update();
			end
		end
		do	--	frame & HookedFrame
			--	frame
				frame:SetFrameStrata("HIGH");
				frame:EnableMouse(true);
				function frame.F_Update()
					LT_SharedMethod.UpdateFrame(frame);
				end
				frame:SetScript("OnShow", function(self)
					self:F_WithDisabledFrame(LT_SharedMethod.WidgetHidePermanently);
					-- self.HookedScrollFrame:Hide();
					self.F_ClearFilter();
					for name, func in next, self.T_DisabledFunc do
						_G[name] = _noop_;
					end
				end);
				frame:SetScript("OnHide", function(self)
					self:F_WithDisabledFrame(LT_SharedMethod.WidgetUnhidePermanently);
					-- self.HookedScrollFrame:Show();
					for name, func in next, self.T_DisabledFunc do
						_G[name] = func;
					end
					self.F_HookedFrameUpdate()
				end);
				if meta.T_MonitoredEvents then
					for index = 1, #meta.T_MonitoredEvents do
						frame:RegisterEvent(meta.T_MonitoredEvents[index]);
					end
					frame:SetScript("OnEvent", function(self, event, _1, ...)
						self.update = true;
						__namespace__.F_ScheduleDelayCall(self.F_Update);
					end);
				end
				C_Timer_NewTicker(PERIODIC_UPDATE_PERIOD, frame.F_Update);
				frame.list = {  };
				frame.prev_var_update_time = GetTime() - MAXIMUM_VAR_UPDATE_PERIOD;

				local ScrollFrame = ALASCR(frame, nil, nil, T_UIDefinition.skillListButtonHeight, LF_CreateSkillListButton, LF_SetSkillListButton);
				ScrollFrame:SetPoint("BOTTOMLEFT", 4, 0);
				ScrollFrame:SetPoint("TOPRIGHT", -4, -28);
				LT_SharedMethod.ModifyALAScrollFrame(ScrollFrame);
				frame.ScrollFrame = ScrollFrame;

				local ToggleButton = CreateFrame("BUTTON", nil, HookedFrame, "UIPanelButtonTemplate");
				ToggleButton:SetSize(70, 18);
				ToggleButton:SetPoint("RIGHT", meta.Widget_AnchorTop, "LEFT", -2, 0);
				-- ToggleButton:SetPoint("TOPRIGHT", -2, -42);
				ToggleButton:SetFrameLevel(127);
				ToggleButton:SetScript("OnClick", function(self)
					LF_ToggleFrame();
				end);
				-- ToggleButton:SetScript("OnEnter", Info_OnEnter);
				-- ToggleButton:SetScript("OnLeave", Info_OnLeave);
				frame.ToggleButton = ToggleButton;
			--

			HookedFrame:HookScript("OnHide", function(self)
				frame:Hide();
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
						obj.Show = _noop_;
						obj:Hide();
					end
				end
			--	Portrait
				meta.HookedPortrait:ClearAllPoints();
				meta.HookedPortrait:SetPoint("TOPLEFT", 7, -4);
				local PortraitBorder = HookedFrame:CreateTexture(nil, "ARTWORK");
				PortraitBorder:SetSize(70, 70);
				PortraitBorder:SetPoint("CENTER", meta.HookedPortrait);
				PortraitBorder:SetTexture("Interface\\Tradeskillframe\\CapacitanceUIGeneral");
				PortraitBorder:SetTexCoord(65 / 256, 117 / 256, 45 / 128, 97 / 128);
				PortraitBorder:Show();
				frame.PortraitBorder = PortraitBorder;
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
				local TextureBackground = CreateFrame("FRAME", nil, HookedFrame);
				TextureBackground:SetPoint("TOPLEFT", 11, -12);
				TextureBackground:SetPoint("BOTTOMRIGHT", -32, 76);
				TextureBackground:SetFrameLevel(0);
				frame.TextureBackground = TextureBackground;

				local TextureLineTop = TextureBackground:CreateTexture(nil, "BACKGROUND");
				TextureLineTop:SetDrawLayer("BACKGROUND", 7);
				TextureLineTop:SetHorizTile(true);
				TextureLineTop:SetHeight(4);
				TextureLineTop:SetPoint("LEFT", 2, 0);
				TextureLineTop:SetPoint("RIGHT", -2, 0);
				TextureLineTop:SetPoint("BOTTOM", HookedFrame, "TOP", 0, -38);
				frame.TextureLineTop = TextureLineTop;

				local TextureLineMiddle = TextureBackground:CreateTexture(nil, "BACKGROUND");
				TextureLineMiddle:SetDrawLayer("BACKGROUND", 7);
				TextureLineMiddle:SetHorizTile(true);
				TextureLineMiddle:SetHeight(4);
				TextureLineMiddle:SetPoint("LEFT", 2, 0);
				TextureLineMiddle:SetPoint("RIGHT", -2, 0);
				TextureLineMiddle:SetPoint("TOP", HookedFrame, "TOP", 0, -61);
				frame.TextureLineMiddle = TextureLineMiddle;

				local TextureLineBottom = TextureBackground:CreateTexture(nil, "BACKGROUND");
				TextureLineBottom:SetDrawLayer("BACKGROUND", 7);
				TextureLineBottom:SetHorizTile(true);
				TextureLineBottom:SetHeight(4);
				TextureLineBottom:SetPoint("LEFT", 2, 0);
				TextureLineBottom:SetPoint("RIGHT", -2, 0);
				TextureLineBottom:SetPoint("BOTTOM", meta.HookedDetailFrame, "TOP", 0, 2);
				frame.TextureLineBottom = TextureLineBottom;
			--	SkillListButtons
				local T_SkillListButtons = {  };
				frame.T_SkillListButtons = T_SkillListButtons;
				local NumDisplayed = _G[T_StyleLayout.C_VariableName_NumSkillListButton];
				for index = 1, NumDisplayed do
					T_SkillListButtons[index] = _G[T_HookedFrameWidgets.C_SkillListButtonNamePrefix .. index];
				end
				for index = NumDisplayed + 1, T_StyleLayout.expand.scroll_button_num do
					local name = T_HookedFrameWidgets.C_SkillListButtonNamePrefix .. index;
					local Button = _G[name] or CreateFrame("BUTTON", name, HookedFrame, T_HookedFrameWidgets.C_SkillListButtonTemplate);
					Button:SetPoint("TOPLEFT", T_SkillListButtons[index - 1], "BOTTOMLEFT", 0, 0);
					Button:Hide();
					T_SkillListButtons[index] = Button;
				end
				T_SkillListButtons[1]:ClearAllPoints();
				T_SkillListButtons[1]:SetPoint("TOPLEFT", meta.HookedScrollFrame);
				for index = 1, #T_SkillListButtons do
					local Button = T_SkillListButtons[index];
					Button:SetScript("OnEnter", LF_BLZSkillListButton_OnEnter);
					Button:SetScript("OnLeave", LT_SharedMethod.SkillListButton_OnLeave);
					Button:SetID(index);
					Button.frame = frame;
					Button.ScrollFrame = meta.HookedScrollFrame;
				end
			--	reagentButton & ProductionIcon
				local T_ReagentButtons = {  };
				frame.T_ReagentButtons = T_ReagentButtons;
				for index = 1, 8 do
					local Button = _G[T_HookedFrameWidgets.C_ReagentButtonNamePrefix .. index];
					T_ReagentButtons[index] = Button;
					Button:HookScript("OnClick", function(self)
						if IsShiftKeyDown() then
							local editBox = ChatEdit_ChooseBoxForSend();
							if not editBox:HasFocus() then
								local name = frame.F_GetRecipeReagentInfo(frame.F_GetSelection(), self:GetID());
								if name ~= nil and name ~= "" then
									ALA_INSERT_NAME(name);
								end
							end
						end
					end);
				end
				T_HookedFrameWidgets.ProductionIcon:HookScript("OnClick", function(self)
					if IsShiftKeyDown() then
						local editBox = ChatEdit_ChooseBoxForSend();
						if not editBox:HasFocus() then
							local name = frame.F_GetRecipeInfo(frame.F_GetSelection());
							if name ~= nil and name ~= "" then
								ALA_INSERT_NAME(name);
							end
						end
					end
				end);
			--

			function frame:F_LayoutOnShow()
				local HookedFrame = self.HookedFrame;
				local T_HookedFrameWidgets = self.T_HookedFrameWidgets;
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
			frame.F_Expand = LF_FrameExpand;
			frame.F_FixSkillList = LF_FrameFixSkillList;
			frame.F_BlzStyle = LF_FrameBlzStyle;
			if meta.T_ToggleOnSkill == nil then
				frame.F_ToggleOnSkill = _noop_;
			else
				function frame:F_ToggleOnSkill(val)
					val = not val;
					local T_ToggleOnSkill = frame.T_ToggleOnSkill;
					for index = 1, #T_ToggleOnSkill do
						T_ToggleOnSkill[index]:SetShown(val);
					end
				end
			end
		end

		do	--	PortraitButton
			local T_PortraitDropMeta = {
				handler = function(_, frame, name)
					if name == '@explorer' then
						__namespace__.F_uiToggleFrame("EXPLORER");
					elseif name == '@config' then
						__namespace__.F_uiToggleFrame("CONFIG");
					else
						CastSpellByName(name);
					end
				end,
				elements = {  },
			};
			local PortraitButton = CreateFrame("BUTTON", nil, HookedFrame);
			PortraitButton:SetSize(42, 42);
			PortraitButton:SetPoint("CENTER", meta.HookedPortrait);
			PortraitButton:RegisterForClicks("AnyUp");
			PortraitButton:SetScript("OnClick", function(self)
				ALADROP(self, "BOTTOM", T_PortraitDropMeta);
			end);
			function PortraitButton:F_Update()
				local elements = T_PortraitDropMeta.elements;
				wipe(elements);
				local pname = frame.F_GetSkillName();
				for pid = __db__.DBMINPID, __db__.DBMAXPID do
					if rawget(VAR, pid) ~= nil and __db__.is_pid_has_win(pid) then
						local name = __db__.get_check_name_by_pid(pid);
						if name ~= nil and name ~= pname then
							local element = { text = name, para = { frame, name, }, };
							tinsert(elements, element);
						end
					end
				end
				tinsert(elements, { text = "explorer", para = { frame, '@explorer', }, });
				tinsert(elements, { text = "config", para = { frame, '@config', }, });
			end
			frame.PortraitButton = PortraitButton;
		end

		do	--	TabFrame
			local TabFrame = CreateFrame("FRAME", nil, HookedFrame);
			TabFrame:SetFrameStrata("HIGH");
			TabFrame:SetHeight(T_UIDefinition.tabSize + T_UIDefinition.tabInterval * 2);
			TabFrame:SetPoint("LEFT", frame);
			TabFrame:SetPoint("BOTTOM", meta.Widget_AnchorTop, "TOP", 0, -4);
			TabFrame:SetPoint("LEFT", meta.Widget_AnchorLeftOfTabFrame, "LEFT", 0, 0);
			TabFrame:Show();
			local T_Tabs = {  };
			function TabFrame:F_CreateTab(index)
				local Tab = CreateFrame("BUTTON", nil, self);
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
					if pname ~= nil and not __db__.is_name_same_skill(pname, frame.F_GetSkillName()) then
						if pname == '@explorer' then
							__namespace__.F_uiToggleFrame("EXPLORER");
						elseif pname == '@config' then
							__namespace__.F_uiToggleFrame("CONFIG");
						elseif pname == '@toggle' then
							LF_ToggleFrame();
						else
							CastSpellByName(pname);
						end
					end
				end);
				T_Tabs[index] = Tab;
				if index == 1 then
					Tab:SetPoint("LEFT", self, "LEFT", T_UIDefinition.tabInterval, 0);
				else
					Tab:SetPoint("LEFT", T_Tabs[index - 1], "RIGHT", T_UIDefinition.tabInterval, 0);
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
			function TabFrame:F_SetNumTabs(num)
				local n = #T_Tabs;
				if n > num then
					for index = num + 1, n do
						T_Tabs[index]:Hide();
					end
				else
					for index = 1, n do
						T_Tabs[index]:Show();
					end
					for index = n + 1, num do
						self:F_CreateTab(index):Show();
					end
				end
				self:SetWidth(T_UIDefinition.tabSize * num + T_UIDefinition.tabInterval * (num + 1));
			end
			function TabFrame:F_SetTab(index, pname, ptexture)
				local Tab = T_Tabs[index] or self:F_CreateTab(index);
				Tab:Show();
				Tab.pname = pname;
				Tab:SetNormalTexture(ptexture);
				Tab:SetHighlightTexture(ptexture);
				Tab:SetPushedTexture(ptexture);
			end
			function TabFrame:F_Update()
				local numSkill = 0;
				for pid = __db__.DBMINPID, __db__.DBMAXPID do
					if rawget(VAR, pid) ~= nil and __db__.is_pid_has_win(pid) then
						local pname = __db__.get_check_name_by_pid(pid);
						if pname ~= nil then
							numSkill = numSkill + 1;
							self:F_SetTab(numSkill, pname, __db__.get_texture_by_pid(pid));
						end
					end
				end
				numSkill = numSkill + 1;
				self:F_SetTab(numSkill, '@explorer', T_UIDefinition.texture_explorer);
				numSkill = numSkill + 1;
				self:F_SetTab(numSkill, '@config', T_UIDefinition.texture_config);
				numSkill = numSkill + 1;
				self:F_SetTab(numSkill, '@toggle', T_UIDefinition.texture_toggle);
				self:F_SetNumTabs(numSkill);
			end
			frame.TabFrame = TabFrame;
			TabFrame.T_Tabs = T_Tabs;
		end

		do	--	search_box
			local SearchEditBox, SearchEditBoxOK, SearchEditBoxNameOnly = LT_SharedMethod.UICreateSearchBox(frame);
			SearchEditBox:SetPoint("TOPLEFT", frame, "TOPLEFT", 4, -6);
			SearchEditBox:SetPoint("RIGHT", SearchEditBoxNameOnly, "LEFT", -4, 0);
			SearchEditBoxNameOnly:SetPoint("RIGHT", SearchEditBoxOK, "LEFT", -4, 0);
			SearchEditBoxOK:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -68, -6);
		end

		do	--	ProfitFrame
			local ProfitFrame = CreateFrame("FRAME", nil, frame);
			ProfitFrame:SetFrameStrata("HIGH");
			ProfitFrame:EnableMouse(true);
			ProfitFrame:Hide();
			ProfitFrame:SetSize(320, 320);
			ProfitFrame:SetPoint("TOPLEFT", HookedFrame, "TOPRIGHT", -36, -68);
			ProfitFrame.list = {  };
			frame.ProfitFrame = ProfitFrame;

			local ToggleButton = CreateFrame("BUTTON", nil, frame);
			ToggleButton:SetSize(20, 20);
			ToggleButton:SetNormalTexture("interface\\buttons\\ui-grouploot-coin-up");
			ToggleButton:SetPushedTexture("interface\\buttons\\ui-grouploot-coin-down");
			ToggleButton:SetHighlightTexture("interface\\buttons\\ui-grouploot-coin-highlight");
			ToggleButton:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -24, -6);
			ToggleButton:SetScript("OnEnter", LT_SharedMethod.ButtonInfoOnEnter);
			ToggleButton:SetScript("OnLeave", LT_SharedMethod.ButtonInfoOnLeave);
			ToggleButton.info_lines = { L["TIP_PROFIT_FRAME_CALL_INFO"] };
			ToggleButton:SetScript("OnClick", function(self)
				if AuctionMod ~= nil then
					local pid = frame.flag or __db__.get_pid_by_pname(frame.F_GetSkillName());
					if ProfitFrame:IsShown() then
						ProfitFrame:Hide();
						if pid ~= nil then
							SET[pid].showProfit = false;
						end
					else
						ProfitFrame:Show();
						if pid ~= nil then
							SET[pid].showProfit = true;
						end
					end
				end
			end);
			ProfitFrame.ToggleButton = ToggleButton;

			ProfitFrame:SetScript("OnShow", function(self)
				if AuctionMod ~= nil then
					LT_SharedMethod.UpdateProfitFrame(frame);
					ToggleButton:SetNormalTexture("interface\\buttons\\ui-grouploot-coin-down");
					ToggleButton:SetPushedTexture("interface\\buttons\\ui-grouploot-coin-up");
				else
					self:Hide();
				end
			end);
			ProfitFrame:SetScript("OnHide", function()
				ToggleButton:SetNormalTexture("interface\\buttons\\ui-grouploot-coin-up");
				ToggleButton:SetPushedTexture("interface\\buttons\\ui-grouploot-coin-down");
			end);

			local ScrollFrame = ALASCR(ProfitFrame, nil, nil, T_UIDefinition.skillListButtonHeight, LT_SharedMethod.ProfitCreateSkillListButton, LT_SharedMethod.ProfitSetSkillListButton);
			ScrollFrame:SetPoint("BOTTOMLEFT", 4, 8);
			ScrollFrame:SetPoint("TOPRIGHT", -8, -28);
			ProfitFrame.ScrollFrame = ScrollFrame;

			local CostOnlyCheck = CreateFrame("CHECKBUTTON", nil, ProfitFrame, "OptionsBaseCheckButtonTemplate");
			CostOnlyCheck:SetSize(24, 24);
			CostOnlyCheck:SetHitRectInsets(0, 0, 0, 0);
			CostOnlyCheck:SetPoint("CENTER", ProfitFrame, "TOPLEFT", 18, -14);
			CostOnlyCheck:Show();
			local Text = ProfitFrame:CreateFontString(nil, "ARTWORK");
			Text:SetFont(T_UIDefinition.frameFont, T_UIDefinition.frameFontSize, "OUTLINE");
			Text:SetPoint("LEFT", CostOnlyCheck, "CENTER", 10, 0);
			Text:SetText(L["costOnly"]);
			CostOnlyCheck.Text = Text;
			CostOnlyCheck:SetScript("OnClick", function(self)
				local checked = self:GetChecked();
				local pid = frame.flag or __db__.get_pid_by_pname(frame.F_GetSkillName());
				if pid ~= nil then
					SET[pid].costOnly = checked;
					LT_SharedMethod.UpdateProfitFrame(frame);
				end
			end);
			ProfitFrame.CostOnlyCheck = CostOnlyCheck;

			local CloseButton = CreateFrame("BUTTON", nil, ProfitFrame, "UIPanelCloseButton");
			CloseButton:SetSize(32, 32);
			CloseButton:SetPoint("CENTER", ProfitFrame, "TOPRIGHT", -18, -14);
			CloseButton:SetScript("OnClick", function()
				local pid = frame.flag or __db__.get_pid_by_pname(frame.F_GetSkillName());
				if pid ~= nil then
					SET[pid].showProfit = false;
				end
				ProfitFrame:Hide();
			end);
			ProfitFrame.CloseButton = CloseButton;

			LT_SharedMethod.ModifyALAScrollFrame(ScrollFrame);
		end

		do	--	SetFrame
			local SetFrame = CreateFrame("FRAME", nil, frame);
			SetFrame:SetFrameStrata("HIGH");
			SetFrame:SetSize(332, 66);
			SetFrame:Hide();
			frame.SetFrame = SetFrame;

			local TipInfo = SetFrame:CreateFontString(nil, "ARTWORK");
			TipInfo:SetFont(T_UIDefinition.frameFont, T_UIDefinition.frameFontSize - 1);
			TipInfo:SetPoint("RIGHT", SetFrame, "BOTTOMRIGHT", -2, 9);
			SetFrame.TipInfo = TipInfo;

			local ToggleButton = CreateFrame("BUTTON", nil, frame);
			ToggleButton:SetSize(16, 16);
			ToggleButton:SetNormalTexture(T_UIDefinition.texture_config);
			ToggleButton:SetPushedTexture(T_UIDefinition.texture_config);
			ToggleButton:GetPushedTexture():SetVertexColor(unpack(T_UIDefinition.textureButtonColorPushed));
			ToggleButton:SetHighlightTexture(T_UIDefinition.texture_config);
			ToggleButton:GetHighlightTexture():SetVertexColor(unpack(T_UIDefinition.textureButtonColorHighlight));
			ToggleButton:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -4, -6);
			ToggleButton:SetScript("OnClick", function(self)
				local pid = frame.flag or __db__.get_pid_by_pname(frame.F_GetSkillName());
				if SetFrame:IsShown() then
					frame:F_HideSetFrame();
					if pid ~= nil then
						SET[pid].showSet = false;
					end
				else
					frame:F_ShowSetFrame(true);
					if pid ~= nil then
						SET[pid].showSet = true;
					end
				end
			end);
			SetFrame.ToggleButton = ToggleButton;

			SetFrame:SetScript("OnShow", function(self)
				ToggleButton:GetNormalTexture():SetVertexColor(1.0, 1.0, 1.0, 1.0);
			end);
			SetFrame:SetScript("OnHide", function(self)
				ToggleButton:GetNormalTexture():SetVertexColor(1.0, 1.0, 1.0, 1.0);
			end);

			local T_CheckButtons = {  };
			local T_KeyTables = { "showUnkown", "showKnown", "showHighRank", "filterClass", "filterSpec", "showItemInsteadOfSpell", "showRank", "haveMaterials", };
			for index = 1, #T_KeyTables do
				local key = T_KeyTables[index];
				local CheckButton = CreateFrame("CHECKBUTTON", nil, SetFrame, "OptionsBaseCheckButtonTemplate");
				CheckButton:SetSize(24, 24);
				CheckButton:SetHitRectInsets(0, 0, 0, 0);
				CheckButton:Show();
				CheckButton:SetChecked(false);
				local Text = SetFrame:CreateFontString(nil, "ARTWORK");
				Text:SetFont(T_UIDefinition.frameFont, T_UIDefinition.frameFontSize, "OUTLINE");
				Text:SetText(L[key]);
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
					CheckButton:SetScript("OnClick", function(self)
						local pid = frame.flag or __db__.get_pid_by_pname(frame.F_GetSkillName());
						if pid ~= nil then
							__namespace__.F_ChangeSetWithUpdate(SET[pid], key, self:GetChecked());
						end
						frame.F_Update();
					end);
				else
					CheckButton:SetScript("OnClick", function(self)
						local pid = frame.flag or __db__.get_pid_by_pname(frame.F_GetSkillName());
						if pid ~= nil then
							__namespace__.F_ChangeSetWithUpdate(SET[pid], key, self:GetChecked());
						end
						frame.ScrollFrame:Update();
					end);
				end
				CheckButton.key = key;
				local TipText = L[key .. "Tip"];
				if TipText ~= nil then
					CheckButton:SetScript("OnEnter", function(self)
						TipInfo:SetText(TipText);
					end);
					CheckButton:SetScript("OnLeave", function(self)
						TipInfo:SetText(nil);
					end);
				end
				tinsert(T_CheckButtons, CheckButton);
			end
			SetFrame.T_CheckButtons = T_CheckButtons;

			local PhaseSlider = CreateFrame("SLIDER", nil, SetFrame, "OptionsSliderTemplate");
			PhaseSlider:SetPoint("BOTTOM", SetFrame, "TOP", 0, 10);
			PhaseSlider:SetPoint("LEFT", 4, 0);
			PhaseSlider:SetPoint("RIGHT", -4, 0);
			PhaseSlider:SetHeight(16);
			PhaseSlider:SetMinMaxValues(1, MAXPHASE)
			PhaseSlider:SetValueStep(1);
			PhaseSlider:SetObeyStepOnDrag(true);
			PhaseSlider.Text:ClearAllPoints();
			PhaseSlider.Text:SetPoint("TOP", PhaseSlider, "BOTTOM", 0, 4);
			PhaseSlider.Low:ClearAllPoints();
			PhaseSlider.Low:SetPoint("TOPLEFT", PhaseSlider, "BOTTOMLEFT", 4, 3);
			PhaseSlider.High:ClearAllPoints();
			PhaseSlider.High:SetPoint("TOPRIGHT", PhaseSlider, "BOTTOMRIGHT", -4, 3);
			PhaseSlider.Low:SetText("|cff00ff001|r");
			PhaseSlider.High:SetText("|cffff0000" .. MAXPHASE .. "|r");
			PhaseSlider:HookScript("OnValueChanged", function(self, value, userInput)
				if userInput then
					local pid = frame.flag or __db__.get_pid_by_pname(frame.F_GetSkillName());
					if pid ~= nil then
						__namespace__.F_ChangeSetWithUpdate(SET[pid], "phase", value);
						frame.F_Update();
					end
				end
				self.Text:SetText("|cffffff00" .. L["phase"] .. "|r " .. value);
			end);
			SetFrame.PhaseSlider = PhaseSlider;

			function frame:F_ShowSetFrame(show)
				if SET.show_tab then
					SetFrame:ClearAllPoints();
					SetFrame:SetPoint("LEFT", self.TextureBackground);
					-- SetFrame:SetPoint("RIGHT", self);
					SetFrame:SetPoint("BOTTOM", self.TabFrame, "TOP", 0, -4);
				else
					SetFrame:ClearAllPoints();
					SetFrame:SetPoint("LEFT", self.TextureBackground);
					-- SetFrame:SetPoint("RIGHT", self);
					SetFrame:SetPoint("BOTTOM", self.TextureBackground, "TOP", 0, 1);
				end
				if show then
					SetFrame:Show();
				end
			end
			function frame:F_HideSetFrame()
				SetFrame:Hide();
			end
			function frame:F_RefreshSetFrame()
				local pid = self.flag or __db__.get_pid_by_pname(self.F_GetSkillName());
				if pid ~= nil then
					local set = SET[pid];
					for index = 1, #T_CheckButtons do
						local CheckButton = T_CheckButtons[index];
						CheckButton:SetChecked(set[CheckButton.key]);
					end
					PhaseSlider:SetValue(set.phase);
				end
			end
		end

		do	--	HaveMaterialsCheck
			local HaveMaterialsCheck = CreateFrame("CHECKBUTTON", nil, frame, "OptionsBaseCheckButtonTemplate");
			HaveMaterialsCheck:SetSize(24, 24);
			HaveMaterialsCheck:SetHitRectInsets(0, 0, 0, 0);
			HaveMaterialsCheck:Show();
			HaveMaterialsCheck:SetChecked(false);
			HaveMaterialsCheck:SetPoint("CENTER", frame, "TOPRIGHT", -54, -14);
			HaveMaterialsCheck:SetScript("OnClick", function(self)
				local pid = frame.flag or __db__.get_pid_by_pname(frame.F_GetSkillName());
				if pid ~= nil then
					__namespace__.F_ChangeSetWithUpdate(SET[pid], "haveMaterials", self:GetChecked());
				end
				frame.F_Update();
			end);
			HaveMaterialsCheck.info_lines = { L["haveMaterialsTip"], };
			HaveMaterialsCheck:SetScript("OnEnter", LT_SharedMethod.ButtonInfoOnEnter);
			HaveMaterialsCheck:SetScript("OnLeave", LT_SharedMethod.ButtonInfoOnLeave);
			frame.HaveMaterialsCheck = HaveMaterialsCheck;
		end

		do	--	InfoInFrame
			local RankInfoInFrame = frame.HookedDetailChild:CreateFontString(nil, "OVERLAY");
			RankInfoInFrame:SetFont(T_UIDefinition.frameFont, T_UIDefinition.frameFontSize);
			RankInfoInFrame:SetPoint("TOPLEFT", frame.HookedDetailChild, "TOPLEFT", 5, -50);
			frame.RankInfoInFrame = RankInfoInFrame;

			local T_PriceInfoInFrame = {  };
			T_PriceInfoInFrame[1] = frame.HookedDetailChild:CreateFontString(nil, "OVERLAY");
			T_PriceInfoInFrame[1]:SetFont(T_UIDefinition.frameFont, T_UIDefinition.frameFontSize);
			T_PriceInfoInFrame[1]:SetPoint("TOPLEFT", RankInfoInFrame, "BOTTOMLEFT", 0, -3);
			T_PriceInfoInFrame[2] = frame.HookedDetailChild:CreateFontString(nil, "OVERLAY");
			T_PriceInfoInFrame[2]:SetFont(T_UIDefinition.frameFont, T_UIDefinition.frameFontSize);
			T_PriceInfoInFrame[2]:SetPoint("TOPLEFT", T_PriceInfoInFrame[1], "BOTTOMLEFT", 0, 0);
			T_PriceInfoInFrame[3] = frame.HookedDetailChild:CreateFontString(nil, "OVERLAY");
			T_PriceInfoInFrame[3]:SetFont(T_UIDefinition.frameFont, T_UIDefinition.frameFontSize);
			T_PriceInfoInFrame[3]:SetPoint("TOPLEFT", T_PriceInfoInFrame[2], "BOTTOMLEFT", 0, 0);
			frame.T_PriceInfoInFrame = T_PriceInfoInFrame;

			frame.Widget_PositionSkippedByInfoInFrame:ClearAllPoints();
			frame.Widget_PositionSkippedByInfoInFrame:SetPoint("TOPLEFT", T_PriceInfoInFrame[3], "BOTTOMLEFT", 0, -3);

			local function LF_DelayUpdateInfoInFrame()
				frame:F_FrameUpdatePriceInfo();
				frame:F_FrameUpdateRankInfo();
			end
			local prev_sid = nil;
			local function LF_OnSelection()
				if not frame:IsShown() then
					local index = frame.F_GetSelection();
					if index ~= nil then
						frame.selected_sid = __db__.get_sid_by_pid_sname_cid(__db__.get_pid_by_pname(frame.F_GetSkillName()), frame.F_GetRecipeInfo(index), frame.F_GetRecipeItemID(index));
					end
				end
				if prev_sid ~= frame.selected_sid then
					prev_sid = frame.selected_sid;
					T_PriceInfoInFrame[1]:SetText(nil);
					T_PriceInfoInFrame[2]:SetText(nil);
					T_PriceInfoInFrame[3]:SetText(nil);
				end
				C_Timer_After(0.5, LF_DelayUpdateInfoInFrame);
			end
			hooksecurefunc(frame.T_FunctionName.F_SetSelection, LF_OnSelection);
			frame.F_OnSelection = LF_OnSelection;
			frame.F_SetSelection = _G[frame.T_FunctionName.F_SetSelection];
			frame.F_FrameUpdatePriceInfo = F_FrameUpdatePriceInfo;
			frame.F_FrameUpdateRankInfo = F_FrameUpdateRankInfo;
		end

		ALA_HOOK_ChatEdit_InsertLink(function(link, addon)
			if frame:IsVisible() and addon ~= __addon__ and not (BrowseName ~= nil and BrowseName:IsVisible()) then
				local name, _, _, _, _, _, _, _, loc = GetItemInfo(link);
				if name ~= nil and name ~= "" then
					local pid = frame.flag or __db__.get_pid_by_pname(frame.F_GetSkillName());
					frame.SearchEditBox:ClearFocus();
					if pid == 10 and loc and loc ~= "" then
						local id = tonumber(strmatch(link, "item:(%d+)"));
						if id ~= 11287 and id ~= 11288 and id ~= 11289 and id ~= 11290 then
							if L.ENCHANT_FILTER[loc] ~= nil then
								frame:F_Search(L.ENCHANT_FILTER[loc]);
							else
								frame:F_Search(L.ENCHANT_FILTER.NONE);
							end
						else
							frame:F_Search(name);
						end
					else
						frame:F_Search(name);
					end
					return true;
				end
			end
		end);
		ALA_HOOK_ChatEdit_InsertName(function(name, addon)
			if frame:IsVisible() and addon ~= __addon__ and not (BrowseName ~= nil and BrowseName:IsVisible()) then
				if name ~= nil and name ~= "" then
					frame.SearchEditBox:SetText(name);
					frame.SearchEditBox:ClearFocus();
					frame:F_Search(name);
					return true;
				end
			end
		end);

		local function callback()
			frame.ScrollFrame:Update();
			LT_SharedMethod.UpdateProfitFrame(frame);
			frame:F_FrameUpdatePriceInfo();
		end
		-- if AuctionMod ~= nil and AuctionMod.F_OnDBUpdate ~= nil then
		-- 	AuctionMod.F_OnDBUpdate(callback);
		-- end
		__namespace__:AddCallback("AUCTION_MOD_LOADED", function(mod)
			if mod ~= nil then
				AuctionMod = mod;
				if mod.F_OnDBUpdate then
					mod.F_OnDBUpdate(callback);
				end
				-- callback();
			end
		end);
		__namespace__:AddCallback("UI_MOD_LOADED", function(mod)
			if mod ~= nil and mod.Skin ~= nil then
				mod.Skin(addon, frame);
			end
		end);

		return frame;
	end
	local function LF_FrameApplySetting(frame)
		for key, name in next, frame.T_FunctionName do
			frame[key] = _G[key] or frame[key];
		end
		--
		frame.TabFrame:F_Update();
		frame.PortraitButton:F_Update();
		frame:F_Expand(SET.expand);
		frame:F_FixSkillList(SET.expand);
		frame:F_BlzStyle(SET.blz_style, true);
		if SET.show_call then
			frame.ToggleButton:Show();
		else
			frame.ToggleButton:Hide();
		end
		if SET.show_tab then
			frame.TabFrame:Show();
		else
			frame.TabFrame:Hide();
		end
		if SET.portrait_button then
			frame.PortraitButton:Show();
		else
			frame.PortraitButton:Hide();
		end
		--
		local ticker = nil;
		ticker = C_Timer_NewTicker(0.1, function()
			if frame.HookedPortrait:GetTexture() == nil then
				SetPortraitTexture(frame.HookedPortrait, "player");
			else
				ticker:Cancel();
				ticker = nil;
			end
		end);
	end
--
local function LF_AddOnCallback_Blizzard_TradeSkillUI(addon)
	-->
		local ExpandTradeSkillSubClass = _G.ExpandTradeSkillSubClass;
		local SetTradeSkillSubClassFilter = _G.SetTradeSkillSubClassFilter;
		local SetTradeSkillInvSlotFilter = _G.SetTradeSkillInvSlotFilter;
		local SetTradeSkillItemNameFilter = _G.SetTradeSkillItemNameFilter;
		local SetTradeSkillItemLevelFilter = _G.SetTradeSkillItemLevelFilter;

		local TradeSkillFrame_SetSelection = _G.TradeSkillFrame_SetSelection;
		local GetTradeSkillSelectionIndex = _G.GetTradeSkillSelectionIndex;
		--
		local DoTradeSkill = _G.DoTradeSkill;
		local CloseTradeSkill = _G.CloseTradeSkill;
		--
		local GetTradeSkillLine = _G.GetTradeSkillLine;
		local GetNumTradeSkills = _G.GetNumTradeSkills;
		local GetTradeSkillInfo = _G.GetTradeSkillInfo;
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
		local TradeSearchInputBox = _G.TradeSearchInputBox;
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
		Widget_PositionSkippedByInfoInFrame = TradeSkillReagentLabel,
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

		F_SetSelection = TradeSkillFrame_SetSelection,		-- SelectTradeSkill
		F_GetSelection = GetTradeSkillSelectionIndex,
		-- expand = ExpandTradeSkillSubClass,
		-- collapse = CollapseTradeSkillSubClass,
		F_ClearFilter = function()
			SetTradeSkillSubClassFilter(0, 1, 1);
			UIDropDownMenu_SetSelectedID(TradeSkillSubClassDropDown, 1);
			SetTradeSkillInvSlotFilter(0, 1, 1);
			if __namespace__.__is_bcc then
				SetTradeSkillItemNameFilter(nil);
				SetTradeSkillItemLevelFilter(0, 0);
			end
			UIDropDownMenu_SetSelectedID(TradeSkillInvSlotDropDown, 1);
			ExpandTradeSkillSubClass(0);
			if __namespace__.__is_bcc then
				TradeSkillFrameAvailableFilterCheckButton:SetChecked(false);
			end
			if TradeSkillCollapseAllButton ~= nil then
				TradeSkillCollapseAllButton.collapsed = nil;
			end
		end,
		F_DoTradeCraft = DoTradeSkill,
		F_CloseSkill = CloseTradeSkill,

		F_GetSkillName = GetTradeSkillLine,
		F_GetSkillInfo = GetTradeSkillLine,
		-- F_GetSkillInfo = function(...) return GetTradeSkillLine(...), __db__.MAXRANK, __db__.MAXRANK; end,
			--	skillName, cur_rank, max_rank

		F_GetRecipeNumAvailable = GetNumTradeSkills,
		F_GetRecipeInfo = GetTradeSkillInfo,
			--	skillName, difficult & header, numAvailable, isExpanded = GetTradeSkillInfo(skillIndex)
		F_GetRecipeItemID = function(arg1) local link = GetTradeSkillItemLink(arg1); return link and tonumber(strmatch(link, "[a-zA-Z]:(%d+)")) or 0; end,
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
			if __namespace__.__is_bcc then
				func(TradeSkillFrameAvailableFilterCheckButton);
				func(TradeSearchInputBox);
				TradeSearchInputBox:ClearFocus();
			end
			func(TradeSkillCollapseAllButton);
			func(TradeSkillInvSlotDropDown);
			func(TradeSkillSubClassDropDown);
			func(TradeSkillListScrollFrame);
			func(TradeSkillListScrollFrameScrollBar)
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
	local frame = LF_HookFrame(addon, meta);
	T_uiFrames[addon] = frame;
	--
	if __namespace__.__is_bcc then
		TradeSkillFrameAvailableFilterCheckButton:ClearAllPoints();
		TradeSkillFrameAvailableFilterCheckButton:SetPoint("TOPLEFT", TradeSkillFrame, "TOPLEFT", 68, -56);
	end
	TradeSkillExpandButtonFrame:Hide();
	--
	LF_FrameApplySetting(frame);
end
local function LF_AddOnCallback_Blizzard_CraftUI(addon)
	-->
		local SetCraftFilter = _G.SetCraftFilter;
		local CraftOnlyShowMakeable = _G.CraftOnlyShowMakeable;

		local CraftFrame_SetSelection = _G.CraftFrame_SetSelection;
		local GetCraftSelectionIndex = _G.GetCraftSelectionIndex;
		--
		local CloseCraft = _G.CloseCraft;
		local GetCraftName = _G.GetCraftName;
		local GetCraftDisplaySkillLine = _G.GetCraftDisplaySkillLine;
		local GetNumCrafts = _G.GetNumCrafts;
		local GetCraftInfo = _G.GetCraftInfo;
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

		F_SetSelection = CraftFrame_SetSelection,		-- SelectCraft
		F_GetSelection = GetCraftSelectionIndex,
		-- expand = ExpandCraftSkillLine,
		-- collapse = CollapseCraftSkillLine,
		F_ClearFilter = __namespace__.__is_bcc and function()
			CraftOnlyShowMakeable(false);
			CraftFrameAvailableFilterCheckButton:SetChecked(false);
			SetCraftFilter(1);
			UIDropDownMenu_SetSelectedID(CraftFrameFilterDropDown, 1);
		end or _noop_,
		-- F_DoTradeCraft = DoCraft,
		F_CloseSkill = CloseCraft,

		F_GetSkillName = GetCraftName,
		F_GetSkillInfo = GetCraftDisplaySkillLine,
		-- F_GetSkillInfo = function(...) return GetCraftDisplaySkillLine(...), __db__.MAXRANK, __db__.MAXRANK; end,
			--	skillName, cur_rank, max_rank

		F_GetRecipeNumAvailable = GetNumCrafts,
		F_GetRecipeInfo = function(arg1) local _1, _2, _3, _4, _5, _6, _7 = GetCraftInfo(arg1); return _1, _3, _4, _5, _6, _7; end,
			--	craftName, craftSubSpellName(""), difficult, numAvailable, isExpanded, trainingPointCost, requiredLevel = GetCraftInfo(index)
		F_GetRecipeItemID = function(arg1) local link = GetCraftItemLink(arg1); return link and tonumber(strmatch(link, "[a-zA-Z]:(%d+)")) or 0; end,
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
			if __namespace__.__is_bcc then
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
	local frame = LF_HookFrame(addon, meta);
	T_uiFrames[addon] = frame;
	--
	if __namespace__.__is_bcc then
		CraftFrameAvailableFilterCheckButton:ClearAllPoints();
		CraftFrameAvailableFilterCheckButton:SetPoint("TOPLEFT", CraftFrame, "TOPLEFT", 68, -56);
		CraftFrameAvailableFilterCheckButton:SetSize(20, 20);
		CraftFrameFilterDropDown:ClearAllPoints();
		CraftFrameFilterDropDown:SetPoint("RIGHT", CraftFrame, "TOPLEFT", 359, -82);
	end
	--
	local ENCHANT_FILTER = L.ENCHANT_FILTER;
	--	Dropdown Filter
		local T_CraftFrameFilterMeta = {
			handler = function(_, key)
				local text = ENCHANT_FILTER[key];
				if text ~= nil then
					frame:F_Search(text);
				end
			end,
			elements = {
				{	--	"披风"
					text = ENCHANT_FILTER.INVTYPE_CLOAK,
					para = { "INVTYPE_CLOAK", },
				},
				{	--	"胸甲"
					text = ENCHANT_FILTER.INVTYPE_CHEST,
					para = { "INVTYPE_CHEST", },
				},
				{	--	"护腕"
					text = ENCHANT_FILTER.INVTYPE_WRIST,
					para = { "INVTYPE_WRIST", },
				},
				{	--	"手套"
					text = ENCHANT_FILTER.INVTYPE_HAND,
					para = { "INVTYPE_HAND", },
				},
				{	--	"靴"
					text = ENCHANT_FILTER.INVTYPE_FEET,
					para = { "INVTYPE_FEET", },
				},
				{	--	"武器"
					text = ENCHANT_FILTER.INVTYPE_WEAPON,
					para = { "INVTYPE_WEAPON", },
				},
				{	--	"盾牌"
					text = ENCHANT_FILTER.INVTYPE_SHIELD,
					para = { "INVTYPE_SHIELD", },
				},
				-- {	--	"没有匹配的附魔"
				-- 	text = ENCHANT_FILTER.NONE,
				-- 	para = { "NONE", },
				-- },
			},
		};
		local FilterDropdown = CreateFrame("BUTTON", nil, frame);
		FilterDropdown:SetSize(16, 16);
		FilterDropdown:EnableMouse(true);
		FilterDropdown:SetNormalTexture("interface\\mainmenubar\\ui-mainmenu-scrolldownbutton-up");
		FilterDropdown:GetNormalTexture():SetTexCoord(6 / 32, 26 / 32, 6 / 32, 26 / 32);
		FilterDropdown:SetPushedTexture("interface\\mainmenubar\\ui-mainmenu-scrolldownbutton-up");
		FilterDropdown:GetPushedTexture():SetTexCoord(6 / 32, 26 / 32, 6 / 32, 26 / 32);
		FilterDropdown:GetPushedTexture():SetVertexColor(unpack(T_UIDefinition.textureButtonColorPushed));
		FilterDropdown:SetHighlightTexture("interface\\mainmenubar\\ui-mainmenu-scrolldownbutton-up");
		FilterDropdown:GetHighlightTexture():SetTexCoord(6 / 32, 26 / 32, 6 / 32, 26 / 32);
		FilterDropdown:GetHighlightTexture():SetVertexColor(unpack(T_UIDefinition.textureButtonColorHighlight));
		FilterDropdown:SetScript("OnClick", function(self, button)
			ALADROP(self, "BOTTOMRIGHT", T_CraftFrameFilterMeta);
		end);

		-- frame.SearchEditBoxOK:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -46, -6);
		frame.SearchEditBox:SetPoint("RIGHT", FilterDropdown, "LEFT", -2, 0);
		FilterDropdown:SetPoint("RIGHT", frame.SearchEditBoxNameOnly, "LEFT", -2, 0);
		frame.FilterDropdown = FilterDropdown;
	--	Auto filter recipe when trading
		local function LF_ProcessTradeTargetItemLink()
			local link = GetTradeTargetItemLink(7);
			if link ~= nil then
				local loc = select(9, GetItemInfo(link));
				if loc ~= nil and ENCHANT_FILTER[loc] then
					frame.SearchEditBox:SetText(ENCHANT_FILTER[loc]);
					frame:F_Search(ENCHANT_FILTER[loc]);
				else
					frame.SearchEditBox:SetText(ENCHANT_FILTER.NONE);
					frame:F_Search(ENCHANT_FILTER.NONE);
				end
			end
		end
		function F.TRADE_CLOSED()
			frame.SearchEditBox:SetText("");
		end
		function F.TRADE_TARGET_ITEM_CHANGED(_1)
			if _1 == 7 then
				LF_ProcessTradeTargetItemLink();
			end
		end
		function F.TRADE_UPDATE()
			LF_ProcessTradeTargetItemLink();
		end
		-- F:RegisterEvent("TRADE_SHOW");
		F:RegisterEvent("TRADE_CLOSED");
		F:RegisterEvent("TRADE_UPDATE");
		F:RegisterEvent("TRADE_TARGET_ITEM_CHANGED");
		frame:HookScript("OnShow", function()
			if CraftFrame:IsShown() then
				__namespace__.F_ScheduleDelayCall(LF_ProcessTradeTargetItemLink);
			end
		end);
	--
	LF_FrameApplySetting(frame);
end
--	Explorer
	local function LF_ExplorerCreateSkillListButton(parent, index, buttonHeight)
		local Button = CreateFrame("BUTTON", nil, parent);
		Button:SetHeight(buttonHeight);
		uireimp._SetSimpleBackdrop(Button, 0, 1, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0);
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
		Title:SetFont(T_UIDefinition.frameFont, T_UIDefinition.frameFontSize, T_UIDefinition.frameFontOutline);
		Title:SetPoint("LEFT", Icon, "RIGHT", 4, 0);
		-- Title:SetWidth(160);
		Title:SetMaxLines(1);
		Title:SetJustifyH("LEFT");
		Button.Title = Title;

		local Note = Button:CreateFontString(nil, "ARTWORK");
		Note:SetFont(T_UIDefinition.frameFont, T_UIDefinition.frameFontSize, T_UIDefinition.frameFontOutline);
		Note:SetPoint("RIGHT", -4, 0);
		Button.Note = Note;

		Title:SetPoint("RIGHT", Note, "LEFT", -4, 0);

		local QualityGlow = Button:CreateTexture(nil, "ARTWORK");
		QualityGlow:SetTexture("Interface\\Buttons\\UI-ActionButton-Border");
		QualityGlow:SetBlendMode("ADD");
		QualityGlow:SetTexCoord(0.25, 0.75, 0.25, 0.75);
		QualityGlow:SetSize(buttonHeight - 2, buttonHeight - 2);
		QualityGlow:SetPoint("CENTER", Icon);
		-- QualityGlow:SetAlpha(0.75);
		QualityGlow:Show();
		Button.QualityGlow = QualityGlow;

		local Star = Button:CreateTexture(nil, "OVERLAY");
		Star:SetTexture("interface\\collections\\collections");
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
		Button:SetScript("OnHide", ALADROP);

		function Button:Select()
			SelectionGlow:Show();
		end
		function Button:Deselect()
			SelectionGlow:Hide();
		end

		local frame = parent:GetParent():GetParent();
		Button.frame = frame;
		Button.list = frame.list;
		Button.flag = frame.flag;

		return Button;
	end
	local function LF_ExplorerSetSkillListButton(Button, data_index)
		local frame = Button.frame;
		local list = Button.list;
		local hash = frame.hash;
		if data_index <= #list then
			local sid = list[data_index];
			local cid = __db__.get_cid_by_sid(sid);
			Button:Show();
			local _, quality, icon;
			if cid then
				_, _, quality, _, icon = __db__.item_info(cid);
			else
				quality = nil;
				icon = ICON_FOR_NO_CID;
			end
			Button.Icon:SetTexture(icon);
			Button.Title:SetText(__db__.spell_name_s(sid));
			if hash[sid] then
				Button.Icon:SetVertexColor(1.0, 1.0, 1.0, 1.0);
				Button.Title:SetTextColor(0.0, 1.0, 0.0, 1.0);
			else
				Button.Icon:SetVertexColor(1.0, 0.0, 0.0, 1.0);
				Button.Title:SetTextColor(1.0, 0.0, 0.0, 1.0);
			end
			local set = SET.explorer;
			if set.showRank then
				Button.Note:SetText(__db__.get_difficulty_rank_list_text_by_sid(sid, false));
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
			if FAV[sid] then
				Button.Star:Show();
			else
				Button.Star:Hide();
			end
			if GetMouseFocus() == Button then
				LT_SharedMethod.SkillListButton_OnEnter(Button);
			end
			Button:Deselect();
			if Button.prev_sid ~= sid then
				ALADROP(Button);
				Button.prev_sid = sid;
			end
		else
			ALADROP(Button);
			Button:Hide();
		end
	end
	--	set button handler
		--	L.ITEM_TYPE_LIST
		--	L.ITEM_SUB_TYPE_LIST
		local index_bound = { skill = { __db__.DBMINPID, __db__.DBMAXPID, }, type = { BIG_NUMBER, -1, }, subType = {  }, eqLoc = { BIG_NUMBER, -1, }, };
		for index, _ in next, L.ITEM_TYPE_LIST do
			if index < index_bound.type[1] then
				index_bound.type[1] = index;
			end
			if index > index_bound.type[2] then
				index_bound.type[2] = index;
			end
		end
		for index1, sub in next, L.ITEM_SUB_TYPE_LIST do
			if index1 < index_bound.type[1] then
				index_bound.type[1] = index1;
			end
			if index1 > index_bound.type[2] then
				index_bound.type[2] = index1;
			end
			index_bound.subType[index1] = { BIG_NUMBER, -BIG_NUMBER, };
			for index2, _ in next, sub do
				if index2 < index_bound.subType[index1][1] then
					index_bound.subType[index1][1] = index2;
				end
				if index2 > index_bound.subType[index1][2] then
					index_bound.subType[index1][2] = index2;
				end
			end
		end
		for index, _ in next, L.ITEM_EQUIP_LOC do
			if index < index_bound.eqLoc[1] then
				index_bound.eqLoc[1] = index;
			end
			if index > index_bound.eqLoc[2] then
				index_bound.eqLoc[2] = index;
			end
		end
		----
		local T_ExplorerSetMeta = {
			handler = function(_, frame, key, val)
				SET.explorer.filter[key] = val;
				if key == 'type' then
					SET.explorer.filter.subType = nil;
				end
				frame.F_Update();
			end,
			elements = {  },
		};
		local function F_ExplorerSetFrameDropdown_OnClick(self)
			local key = self.key;
			local set = SET.explorer;
			local filter = set.filter;
			local bound = nil;
			if key == 'subType' then
				local key0 = filter.type;
				if key0 == nil then
					return;
				end
				bound = index_bound[key][key0];
			else
				bound = index_bound[key];
			end
			local frame = self.frame;
			local stat_list = nil;
			if filter[key] then
				local temp_filter = {  };
				for key, val in next, filter do
					temp_filter[key] = val;
				end
				temp_filter[key] = nil;
				if key == 'type' then
					temp_filter.subType = nil;
				end
				stat_list = { skill = {  }, type = {  }, subType = {  }, eqLoc = {  }, };
				LT_SharedMethod.ExplorerFilterList(frame, stat_list, temp_filter, set.searchText, set.searchNameOnly,
											{  }, frame.hash, set.phase, nil, set.rankReversed, set.showKnown, set.showUnkown, set.showHighRank, false, false);
			else
				stat_list = T_ExplorerStat;
			end
			local elements = T_ExplorerSetMeta.elements;
			wipe(elements);
			elements[1] = { text = L["EXPLORER_CLEAR_FILTER"], para = { frame, key, nil, }, };
			local stat = stat_list[key];
			if key == 'skill' then
				for index = bound[1], bound[2] do
					if stat[index] then
						tinsert(elements, { text = __db__.get_pname_by_pid(index), para = { frame, key, index, }, });
					end
				end
			elseif key == 'type' then
				for index = bound[1], bound[2] do
					if stat[index] then
						tinsert(elements, { text = L.ITEM_TYPE_LIST[index], para = { frame, key, index, }, });
					end
				end
			elseif key == 'subType' then
				local key0 = filter.type;
				for index = bound[1], bound[2] do
					if stat[index] then
						tinsert(elements, { text = L.ITEM_SUB_TYPE_LIST[key0][index], para = { frame, key, index, }, });
					end
				end
			elseif key == 'eqLoc' then
				for index = bound[1], bound[2] do
					if stat[index] then
						tinsert(elements, { text = L.ITEM_EQUIP_LOC[index], para = { frame, key, index, }, });
					end
				end
			end
			ALADROP(self, "BOTTOMRIGHT", T_ExplorerSetMeta);
		end
	--
	local function LF_ExplorerBlzStyle(frame, blz_style, loading)
		if blz_style then
			LT_SharedMethod.StyleBLZBackdrop(frame);
			local CloseButton = frame.CloseButton;
			CloseButton:SetSize(32, 32);
			LT_SharedMethod.StyleBLZButton(CloseButton, not loading and CloseButton.backup or nil);
			LT_SharedMethod.StyleBLZCheckButton(frame.SearchEditBoxNameOnly);
			frame.SearchEditBoxNameOnly:SetSize(24, 24);
			LT_SharedMethod.StyleBLZScrollFrame(frame.ScrollFrame);
			local SetFrame = frame.SetFrame;
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
			local ProfitFrame = frame.ProfitFrame;
			LT_SharedMethod.StyleBLZBackdrop(ProfitFrame);
			LT_SharedMethod.StyleBLZScrollFrame(ProfitFrame.ScrollFrame);
			local ProfitFrameCloseButton = ProfitFrame.CloseButton;
			ProfitFrameCloseButton:SetSize(32, 32);
			LT_SharedMethod.StyleBLZButton(ProfitFrameCloseButton, not loading and ProfitFrameCloseButton.backup or nil);
		else
			LT_SharedMethod.StyleModernBackdrop(frame);
			local CloseButton = frame.CloseButton;
			CloseButton:SetSize(16, 16);
			if CloseButton.backup == nil then
				CloseButton.backup = {  };
				LT_SharedMethod.StyleModernButton(CloseButton, CloseButton.backup, T_UIDefinition.texture_modern_button_close);
			else
				LT_SharedMethod.StyleModernButton(CloseButton, nil, T_UIDefinition.texture_modern_button_close);
			end
			LT_SharedMethod.StyleModernCheckButton(frame.SearchEditBoxNameOnly);
			frame.SearchEditBoxNameOnly:SetSize(14, 14);
			LT_SharedMethod.StyleModernScrollFrame(frame.ScrollFrame);
			local SetFrame = frame.SetFrame;
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
			local ProfitFrame = frame.ProfitFrame;
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
--
local function LF_CreateExplorerFrame()
	local frame = CreateFrame("FRAME", "ALA_TRADESKILL_EXPLORER", UIParent);
	tinsert(UISpecialFrames, "ALA_TRADESKILL_EXPLORER");

	do	--	frame
		frame:SetSize(T_UIDefinition.explorerWidth, T_UIDefinition.explorerHeight);
		frame:SetFrameStrata("HIGH");
		frame:SetPoint("CENTER", 0, 0);
		frame:EnableMouse(true);
		frame:SetMovable(true);
		frame:RegisterForDrag("LeftButton");
		frame:SetScript("OnDragStart", function(self)
			self:StartMoving();
		end);
		frame:SetScript("OnDragStop", function(self)
			self:StopMovingOrSizing();
		end);
		frame:SetScript("OnShow", function(self)
			frame.F_Update();
		end);
		frame:Hide();

		function frame.F_Update()
			LT_SharedMethod.UpdateExplorerFrame(frame, true);
		end
		frame.list = {  };
		frame.hash = T_LearnedRecipesHash;
		frame.flag = 'explorer';

		local Title = frame:CreateFontString(nil, "ARTWORK");
		Title:SetFont(T_UIDefinition.frameFont, T_UIDefinition.frameFontSize);
		Title:SetPoint("CENTER", frame, "TOP", 0, -16);
		Title:SetText(L["EXPLORER_TITLE"]);

		local ScrollFrame = ALASCR(frame, nil, nil, T_UIDefinition.skillListButtonHeight, LF_ExplorerCreateSkillListButton, LF_ExplorerSetSkillListButton);
		ScrollFrame:SetPoint("BOTTOMLEFT", 6, 12);
		ScrollFrame:SetPoint("TOPRIGHT", -10, -56);
		frame.ScrollFrame = ScrollFrame;

		local CloseButton = CreateFrame("BUTTON", nil, frame, "UIPanelCloseButton");
		CloseButton:SetSize(32, 32);
		CloseButton:SetPoint("CENTER", frame, "TOPRIGHT", -18, -16);
		CloseButton:SetScript("OnClick", function()
			frame:Hide();
		end);
		frame.CloseButton = CloseButton;

		LT_SharedMethod.ModifyALAScrollFrame(ScrollFrame);

		frame.F_BlzStyle = LF_ExplorerBlzStyle;
	end

	do	--	search_box
		local SearchEditBox, SearchEditBoxOK, SearchEditBoxNameOnly = LT_SharedMethod.UICreateSearchBox(frame);
		SearchEditBox:SetPoint("TOPLEFT", frame, "TOPLEFT", 10, -32);
		SearchEditBox:SetPoint("RIGHT", SearchEditBoxNameOnly, "LEFT", -4, 0);
		SearchEditBoxNameOnly:SetPoint("RIGHT", SearchEditBoxOK, "LEFT", -4, 0);
		SearchEditBoxOK:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -52, -32);
	end

	do	--	ProfitFrame
		local ProfitFrame = CreateFrame("FRAME", nil, frame);
		ProfitFrame:SetFrameStrata("HIGH");
		ProfitFrame:EnableMouse(true);
		ProfitFrame:Hide();
		ProfitFrame:SetWidth(320);
		ProfitFrame:SetPoint("TOPLEFT", frame, "TOPRIGHT", 2, 0);
		ProfitFrame:SetPoint("BOTTOMLEFT", frame, "BOTTOMRIGHT", 2, 0);
		ProfitFrame.list = {  };
		ProfitFrame.flag = 'explorer';
		frame.ProfitFrame = ProfitFrame;

		local ToggleButton = CreateFrame("BUTTON", nil, frame);
		ToggleButton:SetSize(20, 20);
		ToggleButton:SetNormalTexture("interface\\buttons\\ui-grouploot-coin-up");
		ToggleButton:SetPushedTexture("interface\\buttons\\ui-grouploot-coin-down");
		ToggleButton:SetHighlightTexture("interface\\buttons\\ui-grouploot-coin-highlight");
		ToggleButton:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -30, -32);
		ToggleButton:SetScript("OnEnter", LT_SharedMethod.ButtonInfoOnEnter);
		ToggleButton:SetScript("OnLeave", LT_SharedMethod.ButtonInfoOnLeave);
		ToggleButton.info_lines = { L["TIP_PROFIT_FRAME_CALL_INFO"] };
		ToggleButton:SetScript("OnClick", function(self)
			if AuctionMod ~= nil then
				if ProfitFrame:IsShown() then
					ProfitFrame:Hide();
					SET.explorer.showProfit = false;
				else
					ProfitFrame:Show();
					SET.explorer.showProfit = true;
				end
			end
		end);
		ProfitFrame.ToggleButton = ToggleButton;

		ProfitFrame:SetScript("OnShow", function(self)
			if AuctionMod ~= nil then
				LT_SharedMethod.UpdateProfitFrame(frame);
				ToggleButton:SetNormalTexture("interface\\buttons\\ui-grouploot-coin-down");
				ToggleButton:SetPushedTexture("interface\\buttons\\ui-grouploot-coin-up");
			else
				self:Hide();
			end
		end);
		ProfitFrame:SetScript("OnHide", function()
			ToggleButton:SetNormalTexture("interface\\buttons\\ui-grouploot-coin-up");
			ToggleButton:SetPushedTexture("interface\\buttons\\ui-grouploot-coin-down");
		end);

		local ScrollFrame = ALASCR(ProfitFrame, nil, nil, T_UIDefinition.skillListButtonHeight, LT_SharedMethod.ProfitCreateSkillListButton, LT_SharedMethod.ProfitSetSkillListButton);
		ScrollFrame:SetPoint("BOTTOMLEFT", 4, 8);
		ScrollFrame:SetPoint("TOPRIGHT", -8, -28);
		ProfitFrame.ScrollFrame = ScrollFrame;

		-- local CostOnlyCheck = CreateFrame("CHECKBUTTON", nil, ProfitFrame, "OptionsBaseCheckButtonTemplate");
		-- CostOnlyCheck:SetSize(24, 24);
		-- CostOnlyCheck:SetHitRectInsets(0, 0, 0, 0);
		-- CostOnlyCheck:SetPoint("CENTER", ProfitFrame, "TOPLEFT", 17, -10);
		-- CostOnlyCheck:Show();
		-- local Text = ProfitFrame:CreateFontString(nil, "ARTWORK");
		-- Text:SetFont(T_UIDefinition.frameFont, T_UIDefinition.frameFontSize, "OUTLINE");
		-- Text:SetPoint("LEFT", CostOnlyCheck, "RIGHT", 2, 0);
		-- Text:SetText(L["costOnly"]);
		-- CostOnlyCheck.Text = Text;
		-- CostOnlyCheck:SetScript("OnClick", function(self)
		-- 	local checked = self:GetChecked();
		-- 	SET.explorer.costOnly = checked;
		-- 	LT_SharedMethod.UpdateProfitFrame(frame);
		-- end);
		-- ProfitFrame.CostOnlyCheck = CostOnlyCheck;

		local CloseButton = CreateFrame("BUTTON", nil, ProfitFrame, "UIPanelCloseButton");
		CloseButton:SetSize(32, 32);
		CloseButton:SetPoint("CENTER", ProfitFrame, "TOPRIGHT", -18, -14);
		CloseButton:SetScript("OnClick", function()
			SET.explorer.showProfit = false;
			ProfitFrame:Hide();
		end);
		ProfitFrame.CloseButton = CloseButton;

		LT_SharedMethod.ModifyALAScrollFrame(frame.ProfitFrame.ScrollFrame);
	end

	do	--	SetFrame
		local SetFrame = CreateFrame("FRAME", nil, frame);
		SetFrame:SetFrameStrata("HIGH");
		SetFrame:SetHeight(82);
		SetFrame:SetPoint("LEFT", frame);
		SetFrame:SetPoint("RIGHT", frame);
		SetFrame:SetPoint("BOTTOM", frame, "TOP", 0, 1);
		SetFrame:Hide();
		frame.SetFrame = SetFrame;

		local TipInfo = SetFrame:CreateFontString(nil, "ARTWORK");
		TipInfo:SetFont(T_UIDefinition.frameFont, T_UIDefinition.frameFontSize - 1);
		TipInfo:SetPoint("RIGHT", SetFrame, "BOTTOMRIGHT", -2, 9);
		SetFrame.TipInfo = TipInfo;

		local ToggleButton = CreateFrame("BUTTON", nil, frame);
		ToggleButton:SetSize(16, 16);
		ToggleButton:SetNormalTexture(T_UIDefinition.texture_config);
		ToggleButton:SetPushedTexture(T_UIDefinition.texture_config);
		ToggleButton:GetPushedTexture():SetVertexColor(unpack(T_UIDefinition.textureButtonColorPushed));
		ToggleButton:SetHighlightTexture(T_UIDefinition.texture_config);
		ToggleButton:GetHighlightTexture():SetVertexColor(unpack(T_UIDefinition.textureButtonColorHighlight));
		ToggleButton:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -10, -32);
		ToggleButton:SetScript("OnClick", function(self)
			if SetFrame:IsShown() then
				SetFrame:Hide();
				SET.explorer.showSet = false;
				self:GetNormalTexture():SetVertexColor(1.0, 1.0, 1.0, 1.0);
			else
				SetFrame:Show();
				SET.explorer.showSet = true;
				self:GetNormalTexture():SetVertexColor(0.75, 0.75, 0.75, 1.0);
			end
		end);
		SetFrame.ToggleButton = ToggleButton;

		SetFrame:SetScript("OnShow", function(self)
			ToggleButton:GetNormalTexture():SetVertexColor(1.0, 1.0, 1.0, 1.0);
		end);
		SetFrame:SetScript("OnHide", function(self)
			ToggleButton:GetNormalTexture():SetVertexColor(1.0, 1.0, 1.0, 1.0);
		end);

		local T_CheckButtons = {  };
		local T_KeyTables = { "showUnkown", "showKnown", "showItemInsteadOfSpell", "showRank", };
		for index = 1, #T_KeyTables do
			local key = T_KeyTables[index];
			local CheckButton = CreateFrame("CHECKBUTTON", nil, SetFrame, "OptionsBaseCheckButtonTemplate");
			CheckButton:SetSize(24, 24);
			CheckButton:SetHitRectInsets(0, 0, 0, 0);
			CheckButton:Show();
			CheckButton:SetChecked(false);

			local Text = SetFrame:CreateFontString(nil, "ARTWORK");
			Text:SetFont(T_UIDefinition.frameFont, T_UIDefinition.frameFontSize, "OUTLINE");
			Text:SetText(L[key]);
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
					SET.explorer[key] = self:GetChecked()
					frame.F_Update();
				end);
			else
				CheckButton:SetScript("OnClick", function(self)
					SET.explorer[key] = self:GetChecked()
					frame.ScrollFrame:Update();
				end);
			end
			CheckButton.key = key;
			local TipText = L[key .. "Tip"];
			if TipText ~= nil then
				CheckButton:SetScript("OnEnter", function(self)
					TipInfo:SetText(TipText);
				end);
				CheckButton:SetScript("OnLeave", function(self)
					TipInfo:SetText(nil);
				end);
			end
			tinsert(T_CheckButtons, CheckButton);
		end
		SetFrame.T_CheckButtons = T_CheckButtons;

		local T_Dropdowns = {  };
		local T_KeyTables = { "skill", "type", "subType", "eqLoc", };
		for index = 1, #T_KeyTables do
			local key = T_KeyTables[index];
			local Dropdown = CreateFrame("BUTTON", nil, SetFrame);
			Dropdown:SetSize(20, 20);
			Dropdown:EnableMouse(true);
			Dropdown:SetNormalTexture("interface\\mainmenubar\\ui-mainmenu-scrolldownbutton-up");
			Dropdown:GetNormalTexture():SetTexCoord(6 / 32, 26 / 32, 6 / 32, 26 / 32);
			Dropdown:SetPushedTexture("interface\\mainmenubar\\ui-mainmenu-scrolldownbutton-up");
			Dropdown:GetPushedTexture():SetTexCoord(6 / 32, 26 / 32, 6 / 32, 26 / 32);
			Dropdown:GetPushedTexture():SetVertexColor(unpack(T_UIDefinition.textureButtonColorPushed));
			Dropdown:SetHighlightTexture("interface\\mainmenubar\\ui-mainmenu-scrolldownbutton-up");
			Dropdown:GetHighlightTexture():SetTexCoord(6 / 32, 26 / 32, 6 / 32, 26 / 32);
			Dropdown:GetHighlightTexture():SetVertexColor(unpack(T_UIDefinition.textureButtonColorHighlight));

			local Label = SetFrame:CreateFontString(nil, "ARTWORK");
			Label:SetFont(T_UIDefinition.frameFont, T_UIDefinition.frameFontSize, "OUTLINE");
			Label:SetText(L.EXPLORER_SET[key]);
			Label:SetPoint("LEFT", Dropdown, "RIGHT", 0, 0);
			Dropdown.Label = Label;

			local Cancel = CreateFrame("BUTTON", nil, SetFrame);
			Cancel:SetSize(16, 16);
			Cancel:SetNormalTexture("interface\\buttons\\ui-grouploot-pass-up");
			Cancel:SetPushedTexture("interface\\buttons\\ui-grouploot-pass-up");
			Cancel:GetPushedTexture():SetVertexColor(unpack(T_UIDefinition.textureButtonColorPushed));
			Cancel:SetHighlightTexture("interface\\buttons\\ui-grouploot-pass-up");
			Cancel:GetHighlightTexture():SetVertexColor(unpack(T_UIDefinition.textureButtonColorHighlight));
			Cancel:SetPoint("TOP", Dropdown, "BOTTOM", 0, -1);
			Cancel:SetScript("OnClick", function(self)
				local filter = SET.explorer.filter;
				if filter[key] ~= nil then
					filter[key] = nil;
					if key == 'type' then
						filter.subType = nil;
					end
					frame.F_Update();
				end
			end);
			Cancel.key = key;
			Dropdown.Cancel = Cancel;

			local Text = SetFrame:CreateFontString(nil, "ARTWORK");
			Text:SetFont(T_UIDefinition.frameFont, T_UIDefinition.frameFontSize, "OUTLINE");
			Text:SetText(L[key]);
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
			Dropdown:SetScript("OnClick", F_ExplorerSetFrameDropdown_OnClick);
			Dropdown.key = key;
			Dropdown.frame = frame;
			tinsert(T_Dropdowns, Dropdown);
		end
		SetFrame.T_Dropdowns = T_Dropdowns;

		local PhaseSlider = CreateFrame("SLIDER", nil, SetFrame, "OptionsSliderTemplate");
		PhaseSlider:SetPoint("BOTTOM", SetFrame, "TOP", 0, 12);
		PhaseSlider:SetPoint("LEFT", 4, 0);
		PhaseSlider:SetPoint("RIGHT", -4, 0);
		PhaseSlider:SetHeight(20);
		PhaseSlider:SetMinMaxValues(1, MAXPHASE)
		PhaseSlider:SetValueStep(1);
		PhaseSlider:SetObeyStepOnDrag(true);
		PhaseSlider.Text:ClearAllPoints();
		PhaseSlider.Text:SetPoint("TOP", PhaseSlider, "BOTTOM", 0, 3);
		PhaseSlider.Low:ClearAllPoints();
		PhaseSlider.Low:SetPoint("TOPLEFT", PhaseSlider, "BOTTOMLEFT", 4, 3);
		PhaseSlider.High:ClearAllPoints();
		PhaseSlider.High:SetPoint("TOPRIGHT", PhaseSlider, "BOTTOMRIGHT", -4, 3);
		PhaseSlider.Low:SetText("|cff00ff001|r");
		PhaseSlider.High:SetText("|cffff0000" .. MAXPHASE .. "|r");
		PhaseSlider:HookScript("OnValueChanged", function(self, value, userInput)
			if userInput then
				SET.explorer.phase = value;
				frame.F_Update();
			end
			self.Text:SetText("|cffffff00" .. L["phase"] .. "|r " .. value);
		end);
		SetFrame.PhaseSlider = PhaseSlider;

		function frame:F_RefreshSetFrame()
			local set = SET.explorer;
			for index = 1, #T_CheckButtons do
				local CheckButton = T_CheckButtons[index];
				CheckButton:SetChecked(set[CheckButton.key]);
			end
			local filter = set.filter;
			if filter.skill == nil then
				T_Dropdowns[1].Text:SetText("-");
				T_Dropdowns[1].Cancel:Hide();
			else
				T_Dropdowns[1].Text:SetText(__db__.get_pname_by_pid(filter.skill));
				T_Dropdowns[1].Cancel:Show();
			end
			if filter.type == nil then
				T_Dropdowns[2].Text:SetText("-");
				T_Dropdowns[3].Text:SetText("-");
				T_Dropdowns[2].Cancel:Hide();
				T_Dropdowns[3].Cancel:Hide();
			else
				T_Dropdowns[2].Text:SetText(L.ITEM_TYPE_LIST[filter.type]);
				T_Dropdowns[2].Cancel:Show();
				if filter.subType == nil then
					T_Dropdowns[3].Text:SetText("-");
					T_Dropdowns[3].Cancel:Hide();
				else
					T_Dropdowns[3].Text:SetText(L.ITEM_SUB_TYPE_LIST[filter.type][filter.subType]);
					T_Dropdowns[3].Cancel:Show();
				end
			end
			if filter.eqLoc == nil then
				T_Dropdowns[4].Text:SetText("-");
				T_Dropdowns[4].Cancel:Hide();
			else
				T_Dropdowns[4].Text:SetText(L.ITEM_EQUIP_LOC[filter.eqLoc]);
				T_Dropdowns[4].Cancel:Show();
			end
			PhaseSlider:SetValue(set.phase);
		end

	end

	ALA_HOOK_ChatEdit_InsertLink(function(link, addon)
		if frame:IsShown() and addon ~= __addon__ and not (BrowseName ~= nil and BrowseName:IsVisible()) then
			local name = GetItemInfo(link);
			if name and name ~= "" then
				frame.SearchEditBox:SetText(name);
				frame.SearchEditBox:ClearFocus();
				frame:F_Search(name);
				return true;
			end
		end
	end);
	ALA_HOOK_ChatEdit_InsertName(function(name, addon)
		if frame:IsShown() and addon ~= __addon__ and not (BrowseName ~= nil and BrowseName:IsVisible()) then
			if name and name ~= "" then
				frame.SearchEditBox:SetText(name);
				frame.SearchEditBox:ClearFocus();
				frame:F_Search(name);
				return true;
			end
		end
	end);

	local function callback()
		frame.ScrollFrame:Update();
		LT_SharedMethod.UpdateProfitFrame(frame);
	end
	-- if AuctionMod ~= nil and AuctionMod.F_OnDBUpdate ~= nil then
	-- 	AuctionMod.F_OnDBUpdate(callback);
	-- end
	__namespace__:AddCallback("AUCTION_MOD_LOADED", function(mod)
		if mod ~= nil then
			AuctionMod = mod;
			if AuctionMod.F_OnDBUpdate then
				AuctionMod.F_OnDBUpdate(callback);
			end
			-- callback();
		end
	end);

	return frame;
end
--	Board
	local T_BoardDropMeta = {
		handler = _noop_,
		elements = {
			{
				handler = function()
					SET.lock_board = true;
					T_uiFrames["BOARD"]:F_Lock();
				end,
				para = {  },
				text = L["BOARD_LOCK"],
			},
			{
				handler = function()
					SET.show_board = false;
					T_uiFrames["BOARD"]:Hide();
				end,
				para = {  },
				text = L["BOARD_CLOSE"],
			},
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
		local d = floor(sec / 86400);
		sec = sec % 86400;
		local h = floor(sec / 3600);
		sec = sec % 3600;
		local m = floor(sec / 60);
		sec = sec % 60;
		if d > 0 then
			return format(L["COLORED_FORMATTED_TIME_LEN"][1], r, g, d, h, m, sec);
		elseif h > 0 then
			return format(L["COLORED_FORMATTED_TIME_LEN"][2], r, g, h, m, sec);
		elseif m > 0 then
			return format(L["COLORED_FORMATTED_TIME_LEN"][3], r, g, m, sec);
		else
			return format(L["COLORED_FORMATTED_TIME_LEN"][4], r, g, sec);
		end
	end
	local function LF_CalendarSetHeader(sid)			--	tex, coord, title, color
		return __db__.get_texture_by_pid(__db__.get_pid_by_sid(sid)), nil, __db__.spell_name_s(sid), nil;
	end
	local function LF_CalendarSetLine(sid, GUID)		--	tex, coord, title, color_title, cool, color_cool
		local lClass, class, lRace, race, sex, name = GetPlayerInfoByGUID(GUID);
		local cool;
		do
			local pid = __db__.get_pid_by_sid(sid);
			if sid == 19566 then
				pid = 3;
			end
			if pid then
				local VAR = AVAR[GUID];
				if VAR then
					local var = rawget(VAR, pid);
					if var then
						local c = var[3];
						if c then
							cool = c[sid];
							if cool then
								if cool > 0 then
									local diff = cool - GetServerTime();
									if diff > 0 then
										cool = LF_FormatTime(diff);
									else
										cool = L["COOLDOWN_EXPIRED"];
									end
								else
									cool = L["COOLDOWN_EXPIRED"];
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
		local frame = T_uiFrames["BOARD"];
		if frame:IsShown() then
			frame:F_Clear();
			for GUID, VAR in next, AVAR do
				local add_label = true;
				for pid = __db__.DBMINPID, __db__.DBMAXPID do
					local var = rawget(VAR, pid);
					if var and __db__.is_pid(pid) then
						local cool = var[3];
						if cool and next(cool) ~= nil then
							if add_label then
								add_label = false;
								local lClass, class, lRace, race, sex, name = GetPlayerInfoByGUID(GUID);
								if name and class then
									local classColorTable = RAID_CLASS_COLORS[strupper(class)];
									name = format(">>|cff%.2x%.2x%.2x", classColorTable.r * 255, classColorTable.g * 255, classColorTable.b * 255) .. name .. "|r<<";
									frame:F_AddLine(nil, name);
								else
									frame:F_AddLine(nil, GUID);
								end
							end
							local texture = __db__.get_texture_by_pid(pid);
							if var.cur_rank and var.max_rank then
								frame:F_AddLine("|T" .. (texture or T_UIDefinition.texture_unk) .. ":12:12:0:0|t " .. (__db__.get_pname_by_pid(pid) or ""), nil, var.cur_rank .. " / " .. var.max_rank);
							else
								frame:F_AddLine("|T" .. (texture or T_UIDefinition.texture_unk) .. ":12:12:0:0|t " .. (__db__.get_pname_by_pid(pid) or ""));
							end
							for sid, c in next, cool do
								local texture = __db__.item_icon(__db__.get_cid_by_sid(sid));
								local sname = "|T" .. (texture or T_UIDefinition.texture_unk) .. ":12:12:0:0|t " .. __db__.spell_name_s(sid);
								if c > 0 then
									local diff = c - GetServerTime();
									if diff > 0 then
										frame:F_AddLine(sname, nil, LF_FormatTime(diff));
									else
										cool[sid] = -1;
										frame:F_AddLine(sname, nil, L["COOLDOWN_EXPIRED"]);
									end
								else
									frame:F_AddLine(sname, nil, L["COOLDOWN_EXPIRED"]);
								end
							end
						end
					end
				end
			end
			frame:F_Update();
		end
		local cal = __ala_meta__.cal;
		if cal then
			cal.ext_Reset();
			for pid, list in next, __db__.T_TradeSkill_CooldownList do
				if __db__.is_pid(pid) then
					for index = 1, #list do
						local sid = list[index];
						local add_label = true;
						for GUID, VAR in next, AVAR do
							local var = rawget(VAR, pid);
							if var then
								local cool = var[3];
								if cool and cool[sid[1]] then
									if add_label then
										cal.ext_RegHeader(sid[1], LF_CalendarSetHeader);
									end
									cal.ext_AddLine(sid[1], GUID, LF_CalendarSetLine);
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
	local frame = CreateFrame("FRAME", nil, UIParent);
	frame:SetClampedToScreen(true);
	local LOCALE = GetLocale();
	if LOCALE == 'zhCN' or LOCALE == 'zhTW' or LOCALE == 'koKR' then
		frame:SetWidth(260);
	else
		frame:SetWidth(320);
	end
	frame:SetMovable(true);
	-- frame:EnableMouse(true);
	-- frame:RegisterForDrag("LeftButton");
	function frame:F_Lock()
		self:EnableMouse(false);
		uireimp._SetSimpleBackdrop(self, 0, 1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
	end
	function frame:F_Unlock()
		self:EnableMouse(true);
		uireimp._SetSimpleBackdrop(self, 0, 1, 0.0, 0.0, 0.0, 0.5, 0.0, 0.0, 0.0, 0.5);
	end
	frame:SetScript("OnMouseDown", function(self, button)
		if button == "LeftButton" then
			self:StartMoving();
		else
			ALADROP(self, "BOTTOMLEFT", T_BoardDropMeta);
		end
	end);
	frame:SetScript("OnMouseUp", function(self, button)
		self:StopMovingOrSizing();
		local pos = { self:GetPoint(), };
		for index = 1, #pos do
			local val = pos[index];
			if type(val) == 'table' then
				pos[index] = val:GetName();
			end
		end
		SET.board_pos = pos;
	end);
	frame:SetScript("OnEnter", LT_SharedMethod.ButtonInfoOnEnter);
	frame:SetScript("OnLeave", LT_SharedMethod.ButtonInfoOnLeave);
	function frame:F_AddLine(textL, textM, textR)
		local T_Lines = self.T_Lines;
		local index = self.curLine + 1;
		self.curLine = index;
		local Line = T_Lines[index];
		if not Line then
			local LineL = self:CreateFontString(nil, "OVERLAY");
			LineL:SetFont(T_UIDefinition.frameFont, T_UIDefinition.frameFontSize);
			LineL:SetPoint("TOPLEFT", self, "TOPLEFT", 0, -16 * (index - 1));
			local LineM = self:CreateFontString(nil, "OVERLAY");
			LineM:SetFont(T_UIDefinition.frameFont, T_UIDefinition.frameFontSize);
			LineM:SetPoint("TOP", self, "TOP", 0, -16 * (index - 1));
			local LineR = self:CreateFontString(nil, "OVERLAY");
			LineR:SetFont(T_UIDefinition.frameFont, T_UIDefinition.frameFontSize);
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
	function frame:F_Clear()
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
	function frame:F_Update()
		local h = 16 * max(self.curLine, 1);
		self:SetHeight(h);
		self:SetClampRectInsets(200, -200, 16 - h, h - 16);
	end
	frame.info_lines = { L["BOARD_TIP"], };
	frame.T_Lines = {  };
	frame.curLine = 0;
	C_Timer_NewTicker(1.0, LF_UpdateBoard);
	if SET.show_board then
		frame:Show();
	else
		frame:Hide();
	end
	if SET.lock_board then
		frame:F_Lock();
	else
		frame:F_Unlock();
	end
	if SET.board_pos then
		frame:SetPoint(unpack(SET.board_pos));
	else
		frame:SetPoint("TOP", 0, -20);
	end
	return frame;
end
--	Config
	local T_CharListDrop_Del = {
		text = L.CHAR_DEL,
		para = {  },
	};
	local T_CharListDropMeta = {
		handler = function(_, index, frame)
			__namespace__.F_DelChar(index);
			frame.ScrollFrame:Update();
		end,
		elements = {
			T_CharListDrop_Del,
		},
	};
	local function LF_ConfigCharListButton_OnClick(self, button)
		local list = SET.char_list;
		local data_index = self:GetDataIndex();
		if data_index <= #list then
			local key = list[data_index];
			if key ~= PLAYER_GUID then
				T_CharListDrop_Del.para[1] = data_index;
				T_CharListDrop_Del.para[2] = self.frame;
				ALADROP(self, "BOTTOM", T_CharListDropMeta);
			end
		end
	end
	local function LF_ConfigCharListButton_OnEnter(self)
		local list = SET.char_list;
		local data_index = self:GetDataIndex();
		if data_index <= #list then
			local key = list[data_index];
			local VAR = AVAR[key];
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
			for pid = __db__.DBMINPID, __db__.DBMAXPID do
				local var = rawget(VAR, pid);
				if var and __db__.is_pid(pid) then
					if add_blank then
						GameTooltip:AddLine(" ");
						add_blank = false;
					end
					local right = var.cur_rank;
					if var.max_rank then
						right = (right or "") .. "/" .. var.max_rank;
					end
					if right then
						GameTooltip:AddDoubleLine("    " .. (__db__.get_pname_by_pid(pid) or pid), right .. "    ", 1.0, 1.0, 1.0, 1.0, 1.0, 1.0);
					else
						GameTooltip:AddLine("    " .. (__db__.get_pname_by_pid(pid) or pid), 1.0, 1.0, 1.0);
					end
				end
			end
			-- if VAR.PLAYER_LEVEL then
			-- 	self.Note:SetText(VAR.PLAYER_LEVEL);
			-- else
			-- 	self.Note:SetText(nil);
			-- end
			GameTooltip:Show();
		end
	end
	local function LF_ConfigCreateCharListButton(parent, index, buttonHeight)
		local Button = CreateFrame("BUTTON", nil, parent);
		Button:SetHeight(buttonHeight);
		uireimp._SetSimpleBackdrop(Button, 0, 1, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0);
		Button:SetHighlightTexture(T_UIDefinition.texture_white);
		Button:GetHighlightTexture():SetVertexColor(unpack(T_UIDefinition.listButtonHighlightColor));
		Button:EnableMouse(true);
		Button:RegisterForClicks("AnyUp");

		local Icon = Button:CreateTexture(nil, "BORDER");
		Icon:SetTexture(T_UIDefinition.texture_unk);
		Icon:SetSize(buttonHeight - 4, buttonHeight - 4);
		Icon:SetPoint("LEFT", 8, 0);
		Icon:SetTexture("interface\\targetingframe\\ui-classes-circles");
		Button.Icon = Icon;

		local Title = Button:CreateFontString(nil, "OVERLAY");
		Title:SetFont(T_UIDefinition.frameFont, T_UIDefinition.frameFontSize, T_UIDefinition.frameFontOutline);
		Title:SetPoint("LEFT", Icon, "RIGHT", 4, 0);
		-- Title:SetWidth(160);
		Title:SetMaxLines(1);
		Title:SetJustifyH("LEFT");
		Button.Title = Title;

		local Note = Button:CreateFontString(nil, "OVERLAY");
		Note:SetFont(T_UIDefinition.frameFont, T_UIDefinition.frameFontSize, T_UIDefinition.frameFontOutline);
		Note:SetPoint("RIGHT", Button, "RIGHT", -4, 0);
		-- Note:SetWidth(160);
		Note:SetMaxLines(1);
		Note:SetJustifyH("LEFT");
		Note:SetVertexColor(1.0, 0.25, 0.25, 1.0);
		Button.Note = Note;

		Button:SetScript("OnClick", LF_ConfigCharListButton_OnClick);
		Button:SetScript("OnEnter", LF_ConfigCharListButton_OnEnter);
		Button:SetScript("OnLeave", LT_SharedMethod.ButtonInfoOnLeave);

		local frame = parent:GetParent():GetParent();
		Button.frame = frame;

		return Button;
	end
	local function LF_ConfigSetCharListButton(Button, data_index)
		local list = SET.char_list;
		if data_index <= #list then
			local key = list[data_index];
			local VAR = AVAR[key];
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
				Button.Note:SetText(nil);
			end
			Button:Show();
		else
			Button:Hide();
		end
	end
	local function LF_ConfigCreateCheckButton(parent, key, text, OnClick)
		local CheckButton = CreateFrame("CHECKBUTTON", nil, parent, "OptionsBaseCheckButtonTemplate");
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
		Text:SetFont(T_UIDefinition.frameFont, T_UIDefinition.frameFontSize, "NORMAL");
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
			ALADROP(self, "BOTTOM", self.meta());
		else
			ALADROP(self, "BOTTOM", self.meta);
		end
	end 
	local function LF_ConfigCreateDrop(parent, key, text, meta)
		local Dropdown = CreateFrame("BUTTON", nil, parent);
		Dropdown:SetSize(12, 12);
		Dropdown:EnableMouse(true);
		Dropdown:SetNormalTexture(T_UIDefinition.texture_modern_arrow_down);
		Dropdown:SetPushedTexture(T_UIDefinition.texture_modern_arrow_down);
		Dropdown:GetPushedTexture():SetVertexColor(0.5, 0.5, 0.5, 1.0);
		Dropdown:SetHighlightTexture(T_UIDefinition.texture_modern_arrow_down);
		Dropdown:GetHighlightTexture():SetVertexColor(0.0, 0.5, 1.0, 0.25);

		local Label = Dropdown:CreateFontString(nil, "ARTWORK");
		Label:SetFont(T_UIDefinition.frameFont, T_UIDefinition.frameFontSize, "NORMAL");
		Label:SetText(gsub(text, "%%[a-z]", ""));
		Label:SetPoint("LEFT", Dropdown, "RIGHT", 0, 0);
		Dropdown.Label = Label;

		local Text = Dropdown:CreateFontString(nil, "ARTWORK");
		Text:SetFont(T_UIDefinition.frameFont, T_UIDefinition.frameFontSize, "NORMAL");
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
		local Slider = CreateFrame("SLIDER", nil, parent, "OptionsSliderTemplate");
		local Label = Slider:CreateFontString(nil, "ARTWORK");
		Label:SetFont(T_UIDefinition.frameFont, T_UIDefinition.frameFontSize, "NORMAL");
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
		local Button = CreateFrame("BUTTON", nil, parent);
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
		left:SetFont(T_UIDefinition.frameFont, T_UIDefinition.frameFontSize, "NORMAL");
		left:SetText(">>");
		left:SetPoint("RIGHT", Button, "LEFT", -2, 0);
		local Label = Button:CreateFontString(nil, "ARTWORK");
		Label:SetFont(T_UIDefinition.frameFont, T_UIDefinition.frameFontSize, "NORMAL");
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
			backup = SET[self.key];
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
	local frame = CreateFrame("FRAME", nil, UIParent);
	frame:SetSize(450, 250);
	frame:SetFrameStrata("DIALOG");
	frame:Hide();
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
		self:SetSize(frame:GetWidth(), frame:GetHeight());
		frame:_Show();
		frame:ClearAllPoints();
		frame:SetPoint("BOTTOM", self, "BOTTOM");
		frame.Container = self;
	end);
	SettingUIFreeContainer:SetScript("OnHide", function()
		if not SettingUIInterfaceOptionsFrameContainer:IsShown() then
			frame:_Hide();
			frame:ClearAllPoints();
		end
	end);
	tinsert(UISpecialFrames, "ALATRADESKILL_SETTING_UI_C");
	uireimp._SetSimpleBackdrop(SettingUIFreeContainer, 0, 1, 0.05, 0.05, 0.05, 1.0, 0.0, 0.0, 0.0, 1.0);
	--
	local Close = CreateFrame("BUTTON", nil, SettingUIFreeContainer);
	Close:SetSize(20, 20);
	LT_SharedMethod.StyleModernButton(Close, nil, T_UIDefinition.texture_modern_button_close);
	Close:SetPoint("TOPRIGHT", SettingUIFreeContainer, "TOPRIGHT", -2, -2);
	Close:SetScript("OnClick", function()
		SettingUIFreeContainer:Hide();
	end);
	Close:SetScript("OnEnter", LT_SharedMethod.ButtonInfoOnEnter);
	Close:SetScript("OnLeave", LT_SharedMethod.ButtonInfoOnLeave);
	Close.info_lines = { L.CLOSE, };
	SettingUIFreeContainer.Close = Close;
	--
	SettingUIInterfaceOptionsFrameContainer = CreateFrame('FRAME');
	SettingUIInterfaceOptionsFrameContainer:Hide();
	SettingUIInterfaceOptionsFrameContainer:SetSize(1, 1);
	SettingUIInterfaceOptionsFrameContainer.name = __addon__;
	SettingUIInterfaceOptionsFrameContainer:SetScript("OnShow", function(self)
		SettingUIFreeContainer:Hide();
		frame:_Show();
		frame:ClearAllPoints();
		frame:SetPoint("TOPLEFT", self, "TOPLEFT", 4, 0);
		frame.Container = self;
	end);
	SettingUIInterfaceOptionsFrameContainer:SetScript("OnHide", function()
		if not SettingUIFreeContainer:IsShown() then
			frame:_Hide();
			frame:ClearAllPoints();
		end
	end);
	InterfaceOptions_AddCategory(SettingUIInterfaceOptionsFrameContainer);
	--
	frame._Show = frame.Show;
	frame._Hide = frame.Hide;
	frame._IsShown = frame.IsShown;
	function frame:Show()
		if InterfaceOptionsFrame:IsShown() then
			InterfaceOptionsFrame_OpenToCategory(__addon__);
		else
			SettingUIFreeContainer:Show();
		end
	end
	function frame:Hide()
		if InterfaceOptionsFrame:IsShown() then
			InterfaceOptionsFrame:Hide();
		else
			SettingUIFreeContainer:Hide();
		end
	end
	function frame:IsShown()
		return SettingUIFreeContainer:IsShown() or SettingUIInterfaceOptionsFrameContainer:IsVisible();
	end
	--
	local T_SetWidgets = {  };
	local px, py, h = 0, 0, 1;
	for index = 1, #__namespace__.T_SetCommandList do
		local cmd = __namespace__.T_SetCommandList[index];
		if px >= 1 then
			px = 0;
			py = py + h;
			h = 1;
		end
		local key = cmd[3];
		if cmd[1] == 'bool' then
			local CheckButton = LF_ConfigCreateCheckButton(frame, key, L.SLASH_NOTE[key], cmd[8]);
			CheckButton:SetPoint("TOPLEFT", frame, "TOPLEFT", 10 + 150 * px, -25 - 25 * py);
			T_SetWidgets[key] = CheckButton;
			px = px + 1;
			h = max(h, 1);
		elseif cmd[7] == 'drop' then
			local Dropdown = LF_ConfigCreateDrop(frame, key, L.SLASH_NOTE[key], cmd[8]);
			Dropdown:SetPoint("TOPLEFT", frame, "TOPLEFT", 10 + 150 * px, -25 - 25 * py);
			T_SetWidgets[key] = Dropdown;
			px = px + 1;
			h = max(h, 1);
		elseif cmd[7] == 'slider' then
			if px > 2 then
				px = 0;
				py = py + h;
				h = 1;
			end
			local Slider = LF_ConfigCreateSlider(frame, key, L.SLASH_NOTE[key], cmd[9][1], cmd[9][2], cmd[9][3], cmd[8]);
			Slider:SetPoint("TOPLEFT", frame, "TOPLEFT", 10 + 150 * px, -25 - 25 * py);
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
					local CheckButton = LF_ConfigCreateCheckButton(frame, exkey, L.SLASH_NOTE[exkey], extra[8]);
					CheckButton:SetPoint("LEFT", father.Right, "RIGHT", 20, 0);
					T_SetWidgets[exkey] = CheckButton;
				elseif extra[7] == 'drop' then
					local Dropdown = LF_ConfigCreateDrop(frame, exkey, L.SLASH_NOTE[exkey], extra[8]);
					Dropdown:SetPoint("LEFT", father.Right, "RIGHT", 20, 0);
					T_SetWidgets[exkey] = Dropdown;
				elseif extra[7] == 'slider' then
					local Slider = LF_ConfigCreateSlider(frame, exkey, L.SLASH_NOTE[exkey], extra[9][1], extra[9][2], extra[9][3], extra[8]);
					Slider:SetPoint("LEFT", father.Right, "RIGHT", 20, 0);
					T_SetWidgets[exkey] = Slider;
				elseif extra[7] == 'color4' then
					local color4 = LF_ConfigCreateColor4(frame, exkey, L.SLASH_NOTE[exkey], extra[8]);
					color4:SetPoint("LEFT", father.Right, "RIGHT", 40, 0);
					T_SetWidgets[exkey] = color4;
				end
			end
		end
	end
	frame.T_SetWidgets = T_SetWidgets;
	if px ~= 0 then
		px = 0;
		py = py + h;
		h = 1;
	end
	do	--	character list
		local CharList = CreateFrame("FRAME", nil, frame);
		uireimp._SetSimpleBackdrop(CharList, 0, 1, 0.05, 0.05, 0.05, 1.0, 0.0, 0.0, 0.0, 1.0);
		CharList:SetSize(240, 400);
		CharList:SetPoint("BOTTOMLEFT", frame, "BOTTOMRIGHT", 2, 0);
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

		local ScrollFrame = ALASCR(CharList, nil, nil, T_UIDefinition.charListButtonHeight, LF_ConfigCreateCharListButton, LF_ConfigSetCharListButton);
		ScrollFrame:SetPoint("BOTTOMLEFT", 4, 12);
		ScrollFrame:SetPoint("TOPRIGHT", -4, -24);
		CharList.ScrollFrame = ScrollFrame;
		ScrollFrame:SetNumValue(#SET.char_list);

		CharList:SetScript("OnShow", function(self)
			T_uiFrames["CONFIG"].CharListToggleButton:F_SetStatusTexture(true);
		end);
		CharList:SetScript("OnHide", function(self)
			T_uiFrames["CONFIG"].CharListToggleButton:F_SetStatusTexture(false);
		end);
		frame.CharList = CharList;

		local ToggleButton = CreateFrame("BUTTON", nil, frame);
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
		frame.CharListToggleButton = ToggleButton;

		local Text = ToggleButton:CreateFontString(nil, "OVERLAY");
		Text:SetFont(T_UIDefinition.frameFont, T_UIDefinition.frameFontSize, "NORMAL");
		Text:SetPoint("RIGHT", ToggleButton, "LEFT", -2, 0);
		Text:SetVertexColor(1.0, 1.0, 1.0, 1.0);
		Text:SetText(L.CHAR_LIST);
		ToggleButton.Text = Text;

		function CharList:F_Update()
			self.ScrollFrame:SetNumValue(#SET.char_list);
			self.ScrollFrame:Update();
		end
	end
	function frame:F_Refresh()
		for key, obj in next, T_SetWidgets do
			obj:SetVal(SET[key]);
			local children_key = obj.children_key;
			if children_key then
				for exkey, val in next, children_key do
					local obj2 = T_SetWidgets[exkey];
					if obj2 then
						if SET[key] == val then
							obj2:Show();
						else
							obj2:Hide();
						end
					end
				end
			end
		end
	end
	function frame:F_Update()
		-- self:F_Refresh();
		self.CharList:F_Update();
	end
	frame:SetScript("OnShow", function(self)
		self:F_Refresh();
	end);
	frame:SetHeight(25 + py * 25 + 25);
	return frame;
end


function __namespace__.F_uiMarkToUpdate(pid)
	SET[pid].update = true;
end

-->		external
	function __namespace__.F_uiToggleFrame(key, val)
		local frame = T_uiFrames[key];
		if frame ~= nil then
			if frame:IsShown() or val == false then
				frame:Hide();
				return false;
			else
				frame:Show();
				return true;
			end
		end
	end
	function __namespace__.F_uiToggleFrameCall(val)
		local TFrame = T_uiFrames["BLIZZARD_TRADESKILLUI"];
		if TFrame ~= nil then
			if val then
				TFrame.ToggleButton:Show();
			else
				TFrame.ToggleButton:Hide();
			end
		end
		local CFrame = T_uiFrames["BLIZZARD_CRAFTUI"];
		if CFrame ~= nil then
			if val then
				CFrame.ToggleButton:Show();
			else
				CFrame.ToggleButton:Hide();
			end
		end
	end
	function __namespace__.F_uiToggleFrameTab(val)
		local TFrame = T_uiFrames["BLIZZARD_TRADESKILLUI"];
		if TFrame ~= nil then
			if val then
				TFrame.TabFrame:Show();
			else
				TFrame.TabFrame:Hide();
			end
			TFrame:F_ShowSetFrame(false);
		end
		local CFrame = T_uiFrames["BLIZZARD_CRAFTUI"];
		if CFrame ~= nil then
			if val then
				CFrame.TabFrame:Show();
			else
				CFrame.TabFrame:Hide();
			end
			CFrame:F_ShowSetFrame(false);
		end
	end
	function __namespace__.F_uiToggleFramePortraitButton(val)
		local TFrame = T_uiFrames["BLIZZARD_TRADESKILLUI"];
		if TFrame ~= nil then
			if val then
				TFrame.PortraitButton:Show();
			else
				TFrame.PortraitButton:Hide();
			end
		end
		local CFrame = T_uiFrames["BLIZZARD_CRAFTUI"];
		if CFrame ~= nil then
			if val then
				CFrame.PortraitButton:Show();
			else
				CFrame.PortraitButton:Hide();
			end
		end
	end
	function __namespace__.F_uiLockBoard(val)
		if val then
			T_uiFrames["BOARD"]:F_Lock();
		else
			T_uiFrames["BOARD"]:F_Unlock();
		end
	end
	function __namespace__.F_uiUpdateAllFrames()
		local TFrame = T_uiFrames["BLIZZARD_TRADESKILLUI"];
		if TFrame ~= nil then
			TFrame:F_Update();
		end
		local CFrame = T_uiFrames["BLIZZARD_CRAFTUI"];
		if CFrame ~= nil then
			CFrame:F_Update();
		end
		local EFrame = T_uiFrames["EXPLORER"];
		if EFrame ~= nil then
			EFrame:F_Update();
		end
	end
	function __namespace__.F_uiRefreshAllFrames()
		local TFrame = T_uiFrames["BLIZZARD_TRADESKILLUI"];
		if TFrame ~= nil then
			TFrame.ScrollFrame:Update();
			local ProfitFrame = TFrame.ProfitFrame;
			if ProfitFrame ~= nil then
				ProfitFrame.ScrollFrame:Update();
			end
		end
		local CFrame = T_uiFrames["BLIZZARD_CRAFTUI"];
		if CFrame ~= nil then
			CFrame.ScrollFrame:Update();
			local ProfitFrame = CFrame.ProfitFrame;
			if ProfitFrame ~= nil then
				ProfitFrame.ScrollFrame:Update();
			end
		end
		local EFrame = T_uiFrames["EXPLORER"];
		if EFrame ~= nil then
			EFrame.ScrollFrame:Update();
			local ProfitFrame = EFrame.ProfitFrame;
			if ProfitFrame ~= nil then
				ProfitFrame.ScrollFrame:Update();
			end
		end
	end
	function __namespace__.F_uiRefreshFramesStyle(loading)
		local TFrame = T_uiFrames["BLIZZARD_TRADESKILLUI"];
		if TFrame ~= nil then
			TFrame:F_BlzStyle(SET.blz_style, loading);
		end
		local CFrame = T_uiFrames["BLIZZARD_CRAFTUI"];
		if CFrame ~= nil then
			CFrame:F_BlzStyle(SET.blz_style, loading);
		end
		local EFrame = T_uiFrames["EXPLORER"];
		if EFrame ~= nil then
			EFrame:F_BlzStyle(SET.blz_style, loading);
		end
	end
	function __namespace__.F_uiRefreshConfigFrame()
		T_uiFrames["CONFIG"]:F_Refresh();
	end
	function __namespace__.F_uiToggleFrameExpand(val)
		local TFrame = T_uiFrames["BLIZZARD_TRADESKILLUI"];
		if TFrame ~= nil then
			TFrame:F_Expand(val);
		end
		local CFrame = T_uiFrames["BLIZZARD_CRAFTUI"];
		if CFrame ~= nil then
			CFrame:F_Expand(val);
		end
	end
	function __namespace__.F_uiFrameFixSkillList()
		local TFrame = T_uiFrames["BLIZZARD_TRADESKILLUI"];
		if TFrame ~= nil then
			TFrame:F_FixSkillList(SET.expand);
		end
		local CFrame = T_uiFrames["BLIZZARD_CRAFTUI"];
		if CFrame ~= nil then
			CFrame:F_FixSkillList(SET.expand);
		end
	end
	function __namespace__.F_uiToggleFrameRankInfo(val)
		local TFrame = T_uiFrames["BLIZZARD_TRADESKILLUI"];
		if TFrame ~= nil then
			TFrame:F_FrameUpdateRankInfo();
		end
		local CFrame = T_uiFrames["BLIZZARD_CRAFTUI"];
		if CFrame ~= nil then
			CFrame:F_FrameUpdateRankInfo();
		end
	end
	function __namespace__.F_uiToggleFramePriceInfo(val)
		local TFrame = T_uiFrames["BLIZZARD_TRADESKILLUI"];
		if TFrame ~= nil then
			TFrame:F_FrameUpdatePriceInfo();
		end
		local CFrame = T_uiFrames["BLIZZARD_CRAFTUI"];
		if CFrame ~= nil then
			CFrame:F_FrameUpdatePriceInfo();
		end
	end
-->

function F.SKILL_LINES_CHANGED()	--	Donot process at the first trigger. Do it after 1sec.
	if F.scheduled_SKILL_LINES_CHANGED then
		return;
	end
	F.scheduled_SKILL_LINES_CHANGED = true;
	local LF_SKILL_LINES_CHANGED = function()
		-- local check_id = __db__.table_tradeskill_check_id();
		-- for pid = __db__.DBMINPID, __db__.DBMAXPID do
		-- 	local cpid = check_id[pid];
		-- 	if cpid ~= nil then
		-- 		if not IsSpellKnown(cpid) then
		-- 			rawset(VAR, pid, nil);
		-- 		end
		-- 	end
		-- end
		local check_name = __db__.table_tradeskill_check_name();
		for pid = __db__.DBMINPID, __db__.DBMAXPID do
			local cpname = check_name[pid];
			if cpname ~= nil then
				if GetSpellInfo(cpname) == nil then
					rawset(VAR, pid, nil);
				end
			end
		end
		for index = 1, GetNumSkillLines() do
			local pname, header, expanded, cur_rank, _, _, max_rank  = GetSkillLineInfo(index);
			if not header then
				local pid = __db__.get_pid_by_pname(pname);
				if pid ~= nil then
					local var = VAR[pid];
					var.update = true;
					var.cur_rank, var.max_rank = cur_rank, max_rank;
					__namespace__.F_CheckCooldown(pid, var);
				end
			end
		end
		local TFrame = T_uiFrames.Blizzard_TradeSkillUI;
		local CFrame = T_uiFrames.Blizzard_CraftUI;
		if TFrame then
			TFrame.TabFrame:F_Update();
			TFrame.PortraitButton:F_Update();
		end
		if CFrame then
			CFrame.TabFrame:F_Update();
			CFrame.PortraitButton:F_Update();
		end
	end
	--
	C_Timer_After(1.0, function()
		LF_SKILL_LINES_CHANGED();
		F.SKILL_LINES_CHANGED = LF_SKILL_LINES_CHANGED;
		LF_SKILL_LINES_CHANGED = nil;
		F.scheduled_SKILL_LINES_CHANGED = nil;
	end);
end
function F.NEW_RECIPE_LEARNED(sid)
	local pid = __db__.get_pid_by_sid(sid);
	if pid then
		local var = VAR[pid];
		var.update = true;
		tinsert(var[1], sid);
		var[2][sid] = -1;
		LT_SharedMethod.MarkKnown(sid, PLAYER_GUID);
		__namespace__:FireEvent("USER_EVENT_RECIPE_LIST_UPDATE");
	end
end


function __namespace__.init_ui()
	AVAR, VAR, SET, FAV = __namespace__.AVAR, __namespace__.VAR, __namespace__.SET, __namespace__.FAV;
	local PLAYER_REALM_ID = tonumber(GetRealmID());
	for GUID, VAR in next, AVAR do
		if VAR.realm_id == PLAYER_REALM_ID then
			for pid = __db__.DBMINPID, __db__.DBMAXPID do
				local var = rawget(VAR, pid);
				if var and __db__.is_pid(pid) then
					local list = var[1];
					for index = 1, #list do
						LT_SharedMethod.MarkKnown(list[index], GUID);
					end
				end
			end
		end
	end
	local _;
	_, T_uiFrames["EXPLORER"] = __namespace__.F_SafeCall(LF_CreateExplorerFrame);
	_, T_uiFrames["CONFIG"] = __namespace__.F_SafeCall(LF_CreateConfigFrame);
	_, T_uiFrames["BOARD"] = __namespace__.F_SafeCall(LF_CreateBoard);
	F:RegisterEvent("SKILL_LINES_CHANGED");
	F:RegisterEvent("NEW_RECIPE_LEARNED");
	__namespace__.F_HookTooltip(SkillTip);
	__namespace__:AddCallback("USER_EVENT_DATA_LOADED", function()
		F.SKILL_LINES_CHANGED();
		local TFrame = T_uiFrames["BLIZZARD_TRADESKILLUI"];
		if TFrame ~= nil then
			if TFrame:IsShown() then
				TFrame.F_OnSelection();
			end
			TFrame.TabFrame:F_Update();
		end
		local CFrame = T_uiFrames["BLIZZARD_CRAFTUI"];
		if CFrame ~= nil then
			if CFrame:IsShown() then
				CFrame.F_OnSelection();
			end
			CFrame.TabFrame:F_Update();
		end
	end);
	__namespace__:AddCallback("USER_EVENT_RECIPE_LIST_UPDATE", __namespace__.F_uiUpdateAllFrames);
	__namespace__:AddCallback("AUCTION_MOD_LOADED", function(mod)
		if mod ~= nil then
			AuctionMod = mod;
		end
	end);
	__namespace__:AddAddOnCallback("BLIZZARD_TRADESKILLUI", LF_AddOnCallback_Blizzard_TradeSkillUI);
	__namespace__:AddAddOnCallback("BLIZZARD_CRAFTUI", LF_AddOnCallback_Blizzard_CraftUI);
end
