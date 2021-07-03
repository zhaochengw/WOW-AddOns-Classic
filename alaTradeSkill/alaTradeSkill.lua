--[[--
	by ALA @ 163UI
	##	TODO	--	let them sunk in shit
		Communication Func, query from others or broadcast to others
		query skill & query specified sid
		supreme craft
--]]--
----------------------------------------------------------------------------------------------------
local ADDON, NS = ...;
_G.__ala_meta__ = _G.__ala_meta__ or {  };
__ala_meta__.prof = NS;

local _G = _G;
do
	if NS.__fenv == nil then
		NS.__fenv = setmetatable({  },
				{
					__index = _G,
					__newindex = function(t, key, value)
						rawset(t, key, value);
						print("atf assign global", key, value);
						return value;
					end,
				}
			);
	end
	setfenv(1, NS.__fenv);
end

local curPhase = NS.curPhase;
----------------------------------------------------------------------------------------------------upvalue
	----------------------------------------------------------------------------------------------------LUA
	local math, table, string, bit = math, table, string, bit;
	local type, tonumber, tostring = type, tonumber, tostring;
	local getfenv, setfenv, pcall, xpcall, assert, error, loadstring = getfenv, setfenv, pcall, xpcall, assert, error, loadstring;
	local abs, ceil, floor, max, min, random, sqrt = abs, ceil, floor, max, min, random, sqrt;
	local format, gmatch, gsub, strbyte, strchar, strfind, strlen, strlower, strmatch, strrep, strrev, strsub, strupper, strtrim, strsplit, strjoin, strconcat =
			format, gmatch, gsub, strbyte, strchar, strfind, strlen, strlower, strmatch, strrep, strrev, strsub, strupper, strtrim, strsplit, strjoin, strconcat;
	local getmetatable, setmetatable, rawget, rawset = getmetatable, setmetatable, rawget, rawset;
	local next, ipairs, pairs, sort, tContains, tinsert, tremove, wipe, unpack = next, ipairs, pairs, sort, tContains, tinsert, tremove, wipe, unpack;
	local tConcat = table.concat;
	local select = select;
	local date, time = date, time;
	----------------------------------------------------------------------------------------------------GAME
	local print = print;
	local GetServerTime = GetServerTime;
	local CreateFrame = CreateFrame;
	local IsAltKeyDown = IsAltKeyDown;
	local IsControlKeyDown = IsControlKeyDown;
	local IsShiftKeyDown = IsShiftKeyDown;
	--------------------------------------------------
	local RequestLoadSpellData = RequestLoadSpellData or C_Spell.RequestLoadSpellData;
	local RequestLoadItemDataByID = RequestLoadItemDataByID or C_Item.RequestLoadItemDataByID;
	--------------------------------------------------
	local RegisterAddonMessagePrefix = RegisterAddonMessagePrefix or C_ChatInfo.RegisterAddonMessagePrefix;
	local IsAddonMessagePrefixRegistered = IsAddonMessagePrefixRegistered or C_ChatInfo.IsAddonMessagePrefixRegistered;
	local GetRegisteredAddonMessagePrefixes = GetRegisteredAddonMessagePrefixes or C_ChatInfo.GetRegisteredAddonMessagePrefixes;
	local SendAddonMessage = SendAddonMessage or C_ChatInfo.SendAddonMessage;
	local SendAddonMessageLogged = SendAddonMessageLogged or C_ChatInfo.SendAddonMessageLogged;
	--------------------------------------------------
	local RAID_CLASS_COLORS = RAID_CLASS_COLORS;
	local _ = nil;
	local function _log_(...)
		-- print(date('\124cff00ff00%H:%M:%S\124r'), ...);
	end
	local function _error_(header, child, ...)
		-- print(date('\124cffff0000%H:%M:%S\124r'), header, child, ...);
		-- if alaTradeSkillSV then
		-- 	local err = alaTradeSkillSV.err;
		-- 	if not err then
		-- 		err = {  };
		-- 		alaTradeSkillSV.err = err;
		-- 	end
		-- 	err[header] = err[header] or {  };
		-- 	err[header][child] = (err[header][child] or 0) + 1;
		-- end
	end
	local function _noop_()
	end
----------------------------------------------------------------------------------------------------
	-- "Interface\\Buttons\\WHITE8X8",	-- "Interface\\Tooltips\\UI-Tooltip-Background", -- "Interface\\ChatFrame\\ChatFrameBackground"
	local ui_style = {
		texture_white = "Interface\\Buttons\\WHITE8X8",
		texture_unk = "Interface\\Icons\\inv_misc_questionmark",
		texture_highlight = "Interface\\Buttons\\UI-Common-MouseHilight",
		texture_triangle = "interface\\transmogrify\\transmog-tooltip-arrow",
		texture_color_select = "Interface\\AddOns\\alaTradeSkill\\ARTWORK\\ColorSelect",
		texture_alpha_ribbon = "Interface\\AddOns\\alaTradeSkill\\ARTWORK\\AlphaRibbon",
		texture_config = "interface\\buttons\\ui-optionsbutton",
		texture_explorer = "Interface\\AddOns\\alaTradeSkill\\ARTWORK\\explorer",

		texture_modern_arrow_down = "Interface\\AddOns\\alaTradeSkill\\ARTWORK\\ArrowDown",
		texture_modern_arrow_up = "Interface\\AddOns\\alaTradeSkill\\ARTWORK\\ArrowUp",
		texture_modern_arrow_left = "Interface\\AddOns\\alaTradeSkill\\ARTWORK\\ArrowLeft",
		texture_modern_arrow_right = "Interface\\AddOns\\alaTradeSkill\\ARTWORK\\ArrowRight",
		texture_modern_button_minus = "Interface\\AddOns\\alaTradeSkill\\ARTWORK\\MinusButton",
		texture_modern_button_plus = "Interface\\AddOns\\alaTradeSkill\\ARTWORK\\PlusButton",
		texture_modern_button_close = "Interface\\AddOns\\alaTradeSkill\\ARTWORK\\Close",
		texture_modern_check_button_border = "Interface\\AddOns\\alaTradeSkill\\ARTWORK\\CheckButtonBorder",
		texture_modern_check_button_center = "Interface\\AddOns\\alaTradeSkill\\ARTWORK\\CheckButtonCenter",

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
			edgeFile = "Interface\\Dialogframe\\UI-DialogBox-Border",
			tile = false,
			tileSize = 32,
			edgeSize = 24,
			insets = { left = 4, right = 4, top = 4, bottom = 4, },
		},
		frameBackdrop = {
			bgFile = "Interface\\Buttons\\WHITE8X8",
			edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
			tile = false,
			tileSize = 16,
			edgeSize = 2,
			insets = { left = 2, right = 2, top = 2, bottom = 2, },
		},
		frameBackdropColor = { 0.05, 0.05, 0.05, 1.0, },
		frameBackdropBorderColor = { 0.0, 0.0, 0.0, 1.0, },
		modernDividerColor = { 0.75, 1.0, 1.0, 0.125, },

		scrollBackdrop = {
			bgFile = nil,
			edgeFile = "Interface\\Buttons\\WHITE8X8",
			tile = false,
			tileSize = 16,
			edgeSize = 1,
			insets = { left = 0, right = 0, top = 0, bottom = 0, },
		},
		modernScrollBackdropBorderColor = { 0.25, 0.25, 0.25, 1.0, },
		blzScrollBackdropBorderColor = { 0.5, 0.5, 0.5, 0.5, },

		textureButtonColorNormal = { 0.75, 0.75, 0.75, 0.75, },
		textureButtonColorPushed = { 0.25, 0.25, 0.25, 1.0, },
		textureButtonColorHighlight= { 0.25, 0.25, 0.75, 1.0, },
		textureButtonColorDisabled= { 0.5, 0.5, 0.5, 0.25, },
		modernButtonBackdrop = {
			bgFile = "Interface\\Buttons\\WHITE8X8",
			edgeFile = "Interface\\Buttons\\WHITE8X8",
			tile = false,
			tileSize = 16,
			edgeSize = 1,
			insets = { left = 1, right = 1, top = 1, bottom = 1, },
		},
		modernButtonBackdropColor = { 0.0, 0.0, 0.0, 0.25, },
		modernButtonBackdropBorderColor = { 0.75, 1.0, 1.0, 0.25, },
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
		supremeListButtonHeight = 32,
		listButtonBackdrop = {
			bgFile = "Interface\\Buttons\\WHITE8X8",
			edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
			tile = false,
			tileSize = 16,
			edgeSize = 1,
			insets = { left = 1, right = 1, top = 1, bottom = 1 },
		},
		listButtonBackdropColor_Enabled = { 0.0, 0.0, 0.0, 0.0, },
		listButtonBackdropColor_Disabled = { 0.5, 0.25, 0.25, 0.5, },
		listButtonBackdropBorderColor = { 0.0, 0.0, 0.0, 0.0, },
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
	local BIG_NUMBER = 4294967295;
	local ICON_FOR_NO_CID = 135913;
	local PERIODIC_UPDATE_PERIOD = 1.0;
	local MAXIMUM_VAR_UPDATE_PERIOD = 4.0;
	--[[
		alaTradeSkillSV = {
			var = {
				[GUID] = {
					[pid] = {
						{ sid, },			--	list
						{ [sid] = index, },	--	hash
						{ [sid] = cd, },	--	cd
						update = bool,
						max_rank = number,
						cur_rank = number,
					},
					realm_id = number,
					realm_name = string,
				},
			},
			set = {
				[pid] = { 
					shown = true,
					showSet = false,
					showProfit = false,
					--
					showKnown = true,
					showUnkown = true,
					showHighRank = false,
					showItemInsteadOfSpell = false,
					showRank = true,
					haveMaterials = false,
					phase = curPhase,
					--
					searchText = "",
					--
					costOnly = false,
					--
				},
				board = {
					shown = true,
					locked = true,
					pos = { board:GetPoint() },
				},
				explorer = {
					showSet = true,
					showProfit = false,
					--
					showKnown = true,
					showUnkown = false,
					showHighRank = false,
					showItemInsteadOfSpell = false,
					showRank = true,
					phase = curPhase,
					--
					filter = {
						-- realm = nil,
						skill = nil,
						type = nil,
						subType = nil,
						eqLoc = nil,
					},
					searchText = "",
					--
					costOnly = false,
				},
				expand = false,
				blz_style = false,
				bg_color = { 0.0, 0.0, 0.0, 0.5, },
				show_tradeskill_frame_price_info = true,
				show_tradeskill_frame_rank_info = true,
				show_tradeskill_tip_craft_item_price = true,
				show_tradeskill_tip_craft_spell_price = true,
				show_tradeskill_tip_recipe_price = true,
				show_tradeskill_tip_recipe_account_learned = true,
				default_skill_button_tip = true,
				colored_rank_for_unknown = false,
				regular_exp = false,
				char_list = {  },
				show_call = true,
				show_tab = true,
				portrait_button = true,
				show_board = true,
				lock_board = false,
				board_pos = { "TOP", 0, -20, },
				hide_mtsl = false,
			},
			fav = {
				[sid] = 1,
			},
			_version = number,
		}
	]]
----------------------------------------------------------------------------------------------------
local LOCALE = GetLocale();
local L = NS.L;

local rank_color = {
	[0] = { 1.0, 0.0, 0.0, 1.0, },
	[1] = { 1.0, 0.5, 0.35, 1.0, },
	[2] = { 1.0, 1.0, 0.25, 1.0, },
	[3] = { 0.25, 1.0, 0.25, 1.0, },
	[4] = { 0.5, 0.5, 0.5, 1.0, },
	[BIG_NUMBER] = { 0.0, 0.0, 0.0, 1.0, },
};
local rank_index = {
	['optimal'] = 1,
	['medium'] = 2,
	['easy'] = 3,
	['trivial'] = 4,
};
---------------------------------------------------------------------------------------------------
local AVAR, VAR, SET, FAV, CMM = nil, nil, nil, nil, nil;
local merc = nil;
local gui = {  };
NS.gui = gui;

local PLAYER_REALM_ID = tonumber(GetRealmID());
local PLAYER_REALM_NAME = GetRealmName();
local PLAYER_GUID = UnitGUID('player');
local PLAYER_NAME = UnitName('player');

do	--	InsertLink
	if not _G.ALA_HOOK_ChatEdit_InsertLink then
		local handlers_name = {  };
		local handlers_link = {  };
		function _G.ALA_INSERT_LINK(link, ...)
			if not link then return; end
			local num = #handlers_link;
			if num > 0 then
				for index = 1, num do
					if handlers_link[index](link, ...) then
						return true;
					end
				end
			end
		end
		function _G.ALA_INSERT_NAME(name, ...)
			if not name then return; end
			local num = #handlers_name;
			if num > 0 then
				for index = 1, num do
					if handlers_name[index](name, ...) then
						return true;
					end
				end
			end
		end
		function _G.ALA_HOOK_ChatEdit_InsertName(func)
			for index = 1, #handlers_name do
				if func == handlers_name[index] then
					return;
				end
			end
			tinsert(handlers_name, func);
		end
		function _G.ALA_UNHOOK_ChatEdit_InsertName(func)
			for index = 1, #handlers_name do
				if func == handlers_name[index] then
					tremove(handlers_name, i);
					return;
				end
			end
		end
		function _G.ALA_HOOK_ChatEdit_InsertLink(func)
			for index = 1, #handlers_link do
				if func == handlers_link[index] then
					return;
				end
			end
			tinsert(handlers_link, func);
		end
		function _G.ALA_UNHOOK_ChatEdit_InsertLink(func)
			for index = 1, #handlers_link do
				if func == handlers_link[index] then
					tremove(handlers_link, index);
					return;
				end
			end
		end
		local __ChatEdit_InsertLink = ChatEdit_InsertLink;
		function _G.ChatEdit_InsertLink(link, addon, ...)
			if not link then return; end
			if addon == false then
				return __ChatEdit_InsertLink(link, addon, ...);
			end
			local editBox = ChatEdit_ChooseBoxForSend();
			if not editBox:HasFocus() then
				if _G.ALA_INSERT_LINK(link, addon, ...) then
					return true;
				end
			end
			return __ChatEdit_InsertLink(link, addon, ...);
		end
	end
end

local function button_info_OnEnter(self)
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
	local info_lines = self.info_lines;
	if info_lines then
		for index = 1, #info_lines do
			GameTooltip:AddLine(info_lines[index]);
		end
	end
	GameTooltip:Show();
end
local function button_info_OnLeave(self)
	if GameTooltip:IsOwned(self) then
		GameTooltip:Hide();
	end
end

local _EventHandler = CreateFrame("FRAME");
do	--	EventHandler
	local function OnEvent(self, event, ...)
		return NS[event](...);
	end
	function _EventHandler:FireEvent(event, ...)
		local func = NS[event];
		if func then
			return func(...);
		end
	end
	function _EventHandler:RegEvent(event)
		NS[event] = NS[event] or _noop_;
		self:RegisterEvent(event);
		self:SetScript("OnEvent", OnEvent);
	end
	function _EventHandler:UnregEvent(event)
		self:UnregisterEvent(event);
	end
end

local function safe_call(func, ...)
	local success, result = xpcall(func,
		function(msg)
			geterrorhandler()(msg);
		end,
		...
	);
	if success then
		return true, result;
	else
		return false;
	end
end

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
	local index_rid = 16;
	local index_quest = 17;
	local index_object = 18;
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

do	--	MAIN
	local GetSpellCooldown = GetSpellCooldown;
	function __ala_meta__.GetSpellModifiedCooldown(sid, formatStr)
		local start, duration, enabled, modRate = GetSpellCooldown(sid);
		if start and start > 0 then
			local now = GetTime();
			if start > now then
				start = start - 4294967.28;
			end
			if formatStr then
				local cd = duration + start - now;
				local d = floor(cd / 86400);
				cd = cd % 86400;
				local h = floor(cd / 3600);
				cd = cd % 3600;
				local m = floor(cd / 60);
				cd = cd % 60;
				if d > 0 then
					formatStr = format("%dd %02dh %02dm %02ds", d, h, m, cd);
				elseif h > 0 then
					formatStr = format("%dh %02dm %02ds", h, m, cd);
				elseif m > 0 then
					formatStr = format("%dm %02ds", m, cd);
				else
					formatStr = format("%ds", cd);
				end
			else
				formatStr = nil;
			end
			return true, start, duration, enabled, modRate, formatStr;
		else
			return false, 0, 0, enabled, modRate, nil;
		end
	end

	do	--	db
		--	skill list
		local tradeskill_id = NS.tradeskill_id;
		local tradeskill_name = {  };						--	[pid] = prof_name
		local tradeskill_hash = {  };						--	[prof_name] = pid
		local tradeskill_texture = NS.tradeskill_texture;
		local tradeskill_check_id = NS.tradeskill_check_id;	--	[pid] = p_check_sid
		local tradeskill_check_name = {  };					--	[pid] = p_check_sname
		local tradeskill_has_win = NS.tradeskill_has_win;	--	[pid] = bool
		--	recipe db
		local recipe_info = NS.recipe_info;
		--[[	recipe_info[sid] = {
					1_validated, 2_phase, 3_pid, 4_sid, 5_cid,
					6_learn, 7_yellow, 8_green, 9_grey,
					10_made, 11_made, 12_reagents_id, 13_reagents_count, 
					14_trainer, 15_train_price, 16_rid, 17_quest, 18_object
				}
		--]]
		local recipe_sid_list_by_pid = NS.recipe_sid_list_by_pid;
		local pid_sname_to_sid = {  };	--	[pid][sname] = { sid }
		local cid_to_sid = {  };		--	[cid] = { sid }
		local cid_pid_to_sid = {  };	--	[cid][pid] = { sid }
		local rid_to_sid = {  };		--	[rid] = sid
		--	id list
		local recipe_sid_list = {  };	--	{ sid }			--	actually unused
		local recipe_cid_list = {  };	--	{ cid }			--	actually unused
		--
		local reagent_to_sid = {  };
		--	cached
		local spell_info = {  };		--	[sid] = { 1_name, 2_name_lower, 3_link, 4_link_lower, 5_string }
		local item_info = {  };			--	[iid] = info{ 1_name, 2_link, 3_rarity, 4_loc, 5_icon, 6_sellPrice, 7_typeID, 8_subTypeId, 9_bindType, 10_name_lower, 11_link_lower, 12_string }
		--
		function NS.db_cache_spell(sid)
			local sname = GetSpellInfo(sid);
			if sname then
				local sname_lower = strlower(sname);
				local sinfo = {
					sname,
					sname_lower,
					"\124cff71d5ff\124Hspell:" .. sid .. "\124h[" .. sname .. "]\124h\124r",
					"\124cff71d5ff\124hspell:" .. sid .. "\124h[" .. sname_lower .. "]\124h\124r",
					"\124cff71d5ff[" .. sname .. "]\124r",
				};
				spell_info[sid] = sinfo;
				local info = recipe_info[sid];
				if info then
					local pid = info[index_pid];
					local pt = pid_sname_to_sid[pid];
					if pt == nil then
						pt = {  };
						pid_sname_to_sid[pid] = pt;
					end
					local ptn = pt[sname];
					if ptn == nil then
						ptn = {  };
						pt[sname] = ptn;
					end
					pt[sname_lower] = ptn;
					tinsert(ptn, sid);
				end
				return sinfo;
			-- else
				-- RequestLoadSpellData(sid);
			end
		end
		function NS.db_cache_item(iid)
			local iname, ilink, rarity, level, pLevel, type, subType, stackCount, loc, icon, sellPrice,
					typeID, subTypeID, bindType, expacID, setID, isReagent = GetItemInfo(iid); 
			if iname and ilink then
				local iname_lower = strlower(iname);
				local ilink_lower = strlower(ilink);
				local str = nil;
				if ITEM_QUALITY_COLORS then
					local c = ITEM_QUALITY_COLORS[rarity];
					if c then
						str = c.hex .. "[" .. iname .. "]\124r";
					end
				end
				str = str or "[" .. iname .. "]";
				local info = {
					[index_i_name]			= iname,
					[index_i_link]			= ilink,
					[index_i_rarity]		= rarity,
					[index_i_loc]			= loc,
					[index_i_icon]			= icon,
					[index_i_sellPrice]		= sellPrice,
					[index_i_typeID]		= typeID,
					[index_i_subTypeID]		= subTypeID,
					[index_i_bindType]		= bindType,
					[index_i_name_lower]	= iname_lower,
					[index_i_link_lower]	= ilink_lower,
					[index_i_string]		= str,
				};
				item_info[iid] = info;
				return info;
			else
				-- RequestLoadItemDataByID(iid);
				-- _error_("SPELL_DATA_LOAD_RESULT#1", iid);
			end
		end
		do	--	PRELOAD
			function NS.SPELL_DATA_LOAD_RESULT(sid, success)
				if success then
					--	trade skill line
					local pid = tradeskill_hash[sid];
					if pid then
						local pname = GetSpellInfo(sid);
						if pname then
							local pname_lower = strlower(pname);
							tradeskill_hash[sid] = nil;
							if tradeskill_id[pid] == sid then
								if L.extra_skill_name[pid] == nil then
									tradeskill_hash[pname] = pid;
									tradeskill_hash[pname_lower] = pid;
								else
									tradeskill_hash[L.extra_skill_name[pid]] = pid;
									tradeskill_hash[strlower(L.extra_skill_name[pid])] = pid;
								end
								tradeskill_name[pid] = pname;
							end
							if tradeskill_check_id[pid] == sid then
								tradeskill_check_name[pid] = pname;
							end
							spell_info[sid] = {
								pname,
								pname_lower,
								"\124cff71d5ff\124Hspell:" .. sid .. "\124h[" .. pname .. "]\124h\124r",
								"\124cff71d5ff\124hspell:" .. sid .. "\124h[" .. pname_lower .. "]\124h\124r",
								"\124cff71d5ff[" .. pname .. "]\124r",
							};
						-- else
							-- RequestLoadSpellData(sid);
						end
						return;
					end
					--	trade skill recipe
					if NS.db_is_tradeskill_sid(sid) then
						NS.db_cache_spell(sid);
					end
				-- else
					-- local info = recipe_info[sid];
					-- RequestLoadSpellData(sid);
					-- _error_("SPELL_DATA_LOAD_RESULT#0", sid);
				end
			end
			local function preload_check_spell()
				local completed = true;
				local maxonce = IsInRaid() and 500 or (IsInGroup() and 1000 or 10000);
				for pid = NS.db_min_pid(), NS.db_max_pid() do
					local sid = tradeskill_id[pid];
					if not tradeskill_name[pid] then
						RequestLoadSpellData(sid);
						tradeskill_hash[sid] = pid;
						local csid = tradeskill_check_id[pid];
						if csid and csid ~= sid then
							RequestLoadSpellData(csid);
							tradeskill_hash[csid] = pid;
						end
						completed = false;
						maxonce = maxonce - 1;
						if maxonce <= 0 then
							return false;
						end
					end
				end
				for sid, info in next, recipe_info do
					if not spell_info[sid] then
						RequestLoadSpellData(sid);
						completed = false;
						maxonce = maxonce - 1;
						if maxonce <= 0 then
							return false;
						end
					end
				end
				return completed;
			end
			local temp_iid_list = {  };	--	[iid] = 1	--	temp
			function NS.ITEM_DATA_LOAD_RESULT(iid, success)
				if temp_iid_list[iid] then
					if success then
						NS.db_cache_item(iid);
					else
						-- RequestLoadItemDataByID(iid);
						-- _error_("SPELL_DATA_LOAD_RESULT#0", iid);
					end
				end
			end
			local function preload_check_item()
				local completed = true;
				local maxonce = IsInRaid() and 500 or (IsInGroup() and 1000 or 10000);
				for sid, info in next, recipe_info do
					local cid = info[index_cid];
					if cid then
						if not item_info[cid] then
							RequestLoadItemDataByID(cid);
							temp_iid_list[cid] = 1;
							completed = false;
							maxonce = maxonce - 1;
							if maxonce <= 0 then
								return false;
							end
						end
					end
					local rid = info[index_rid]
					if rid then
						if not item_info[rid] then
							RequestLoadItemDataByID(rid);
							temp_iid_list[rid] = 1;
							completed = false;
							maxonce = maxonce - 1;
							if maxonce <= 0 then
								return false;
							end
						end
					end
					local reagent_ids = info[index_reagents_id];
					if reagent_ids then
						for index2 = 1, #reagent_ids do
							local rid = reagent_ids[index2];
							if not item_info[rid] then
								RequestLoadItemDataByID(rid);
								temp_iid_list[rid] = 1;
								completed = false;
								maxonce = maxonce - 1;
								if maxonce <= 0 then
									return false;
								end
							end
						end
					end
				end
				if completed then
					wipe(temp_iid_list);
					temp_iid_list = nil;
				end
				return completed;
			end
			local preload_check_spell_times = 0;
			local function PRELOAD_SPELL()
				if preload_check_spell() then
					_EventHandler:UnregEvent("SPELL_DATA_LOAD_RESULT");
					_EventHandler:FireEvent("USER_EVENT_SPELL_DATA_LOADED");
				else
					_EventHandler:RegEvent("SPELL_DATA_LOAD_RESULT");	--	Events registered before loading screen went out may not work well. So reg here everytime.
					C_Timer.After(2.0, PRELOAD_SPELL);
					preload_check_spell_times = preload_check_spell_times + 1;
					if preload_check_spell_times >= 10 then
						_error_("PRELOAD_SPELL#0", preload_check_spell_times);
					end
				end
			end
			local preload_check_item_times = 0;
			local function PRELOAD_ITEM()
				if preload_check_item() then
					_EventHandler:UnregEvent("ITEM_DATA_LOAD_RESULT");
					_EventHandler:FireEvent("USER_EVENT_ITEM_DATA_LOADED");
				else
					_EventHandler:RegEvent("ITEM_DATA_LOAD_RESULT");	--	Events registered before loading screen went out may not work well. So reg here everytime.
					C_Timer.After(2.0, PRELOAD_ITEM);
					preload_check_item_times = preload_check_item_times + 1;
					if preload_check_item_times >= 10 then
						_error_("PRELOAD_ITEM#0", preload_check_item_times);
					end
				end
			end
			function NS.db_preload()
				PRELOAD_SPELL();
				PRELOAD_ITEM();
			end
		end
		function NS.db_init()
			for pid = NS.db_min_pid(), NS.db_max_pid() do
				local list = recipe_sid_list_by_pid[pid];
				if list then
					pid_sname_to_sid[pid] = {  };
					cid_pid_to_sid[pid] = cid_pid_to_sid[pid] or {  };
					for index = 1, #list do
						local sid = list[index];
						local info = recipe_info[sid];
						info[index_validated] = true;
						local cid = info[index_cid];
						if cid then
							local h1 = cid_to_sid[cid];
							if not h1 then
								h1 = {  };
								cid_to_sid[cid] = h1;
							end
							tinsert(h1, sid);
							local h2 = cid_pid_to_sid[pid][cid];
							if not h2 then
								h2 = {  };
								cid_pid_to_sid[pid][cid] = h2;
							end
							tinsert(h2, sid);
						end
						local rid = info[index_rid];
						if rid then
							rid_to_sid[rid] = sid;
						end
						--	list
						tinsert(recipe_sid_list, sid);
						if cid then
							tinsert(recipe_cid_list, cid);
						end
						--	material
						local regeants_id = info[index_reagents_id];
						local reagents_num = info[index_reagents_count];
						for index = 1, #regeants_id do
							local reagent_id = regeants_id[index];
							local val = reagent_to_sid[reagent_id];
							if val == nil then
								val = { {  }, {  }, };
								reagent_to_sid[reagent_id] = val;
							end
							tinsert(val[1], sid);
							tinsert(val[2], reagents_num[index]);
						end
					end
				end
			end
			for sid, info in next, recipe_info do
				if not info[index_validated] then
					recipe_info[sid] = nil;
				end
			end
			if IsInRaid() then
				C_Timer.After(4, NS.db_preload);
			elseif IsInGroup() then
				C_Timer.After(2, NS.db_preload);
			else
				NS.db_preload();
			end
		end
		--	GET TABLE
			--	| tradeskill_check_id{ [pid] = p_check_sid }
			function NS.db_table_tradeskill_check_id()
				return tradeskill_check_id;
			end
			--	| tradeskill_check_name{ [pid] = p_check_sname }
			function NS.db_table_tradeskill_check_name()
				return tradeskill_check_name;
			end
		--	QUERY RECIPE DB
			--	pid | is_tradeskill
			function NS.db_is_pid(pid)
				return pid ~= nil and tradeskill_id[pid] ~= nil;
			end
			--	pname | pid
			function NS.db_get_pid_by_pname(pname)
				if pname ~= nil then
					return tradeskill_hash[pname];
				end
			end
			--	pid | pname
			function NS.db_get_pname_by_pid(pid)
				if pid ~= nil then
					return tradeskill_name[pid];
				end
			end
			--	pid | ptexture
			function NS.db_get_texture_by_pid(pid)
				if pid ~= nil then
					return tradeskill_texture[pid];
				end
			end
			--	pid | has_win
			function NS.db_is_pid_has_win(pid)
				if NS.db_is_pid(pid) then
					return tradeskill_has_win[pid];
				end
			end
			--	pid | check_id
			function NS.db_get_check_id_by_pid(pid)
				if pid ~= nil then
					return tradeskill_check_id[pid];
				end
			end
			--	pid | check_name
			function NS.db_get_check_name_by_pid(pid)
				if pid ~= nil then
					return tradeskill_check_name[pid];
				end
			end
			--	sid | is_tradeskill
			function NS.db_is_tradeskill_sid(sid)
				return sid ~= nil and recipe_info[sid] ~= nil;
			end
			--	pid | list{ sid, }
			function NS.db_get_list_by_pid(pid)
				if pid ~= nil then
					return recipe_sid_list_by_pid[pid];
				end
			end
			--	<query_recipe_info
			--	sid | info{  }
			function NS.db_get_info_by_sid(sid)
				if sid ~= nil then
					return recipe_info[sid];
				end
			end
			--	sid | phase
			function NS.db_get_phase_by_sid(sid)
				if sid ~= nil then
					local info = recipe_info[sid];
					if info then
						return info[index_phase];
					end
				end
			end
			--	sid | pid
			function NS.db_get_pid_by_sid(sid)
				if sid ~= nil then
					local info = recipe_info[sid];
					if info then
						return info[index_pid];
					end
				end
			end
			--	sid | cid
			function NS.db_get_cid_by_sid(sid)
				if sid ~= nil then
					local info = recipe_info[sid];
					if info then
						return info[index_cid];
					end
				end
			end
			--	sid | learn_rank
			function NS.db_get_learn_rank_by_sid(sid)
				if sid ~= nil then
					local info = recipe_info[sid];
					if info then
						return info[index_learn_rank];
					end
				end
			end
			--	sid | learn_rank, yellow_rank, green_rank, grey_rank
			function NS.db_get_difficulty_rank_list_by_sid(sid)
				if sid ~= nil then
					local info = recipe_info[sid];
					if info then
						return info[index_learn_rank], info[index_yellow_rank], info[index_green_rank], info[index_grey_rank];
					end
				end
			end
			--	sid | text"[[red ]yellow green grey]"
			function NS.db_get_difficulty_rank_list_text_by_sid(sid)
				if sid ~= nil then
					local red, yellow, green, grey = NS.db_get_difficulty_rank_list_by_sid(sid);
					if red and yellow and green and grey then
						if red < yellow then
							return "\124cffff8f00" .. red .. " \124cffffff00" .. yellow .. " \124cff8fff00" .. green .. " \124cff8f8f8f" .. grey;
						else
							return "\124cffffff00" .. yellow .. " \124cff8fff00" .. green .. " \124cff8f8f8f" .. grey;
						end
					end
				end
				return "";
			end
			--	sid | difficulty	--	rank: red-1, yellow-2, green-3, grey-4
			function NS.db_get_difficulty_rank_by_sid(sid, cur)
				if sid ~= nil then
					local info = recipe_info[sid];
					if info then
						if cur >= info[index_grey_rank] then
							return 4;
						elseif cur >= info[index_green_rank] then
							return 3;
						elseif cur >= info[index_yellow_rank] then
							return 2;
						elseif cur >= info[index_learn_rank] then
							return 1;
						else
							return 0;
						end
					end
				end
				return BIG_NUMBER;
			end
			--	sid | avg_made, min_made, max_made
			function NS.db_get_num_made_by_sid(sid)
				if sid ~= nil then
					local info = recipe_info[sid];
					if info then
						return (info[index_num_made_min] + info[index_num_made_max]) / 2, info[index_num_made_min], info[index_num_made_max];
					end
				end
			end
			--	sid | reagent_ids{  }, reagent_nums{  }
			function NS.db_get_reagents_by_sid(sid)
				if sid ~= nil then
					local info = recipe_info[sid];
					if info then
						return info[index_reagents_id], info[index_reagents_count];
					end
				end
			end
			--	query_recipe_info>
			--	pid, sname | num, pids{  }
			function NS.db_get_sid_by_pid_sname(pid, sname)
				if pid ~= nil and sname ~= nil then
					local pt = pid_sname_to_sid[pid];
					if pt then
						local ptn = pt[sname];
						if ptn then
							return #ptn, ptn;
						end
					end
				end
				return 0;
			end
			--	pid, sname, cid | sid
			function NS.db_get_sid_by_pid_sname_cid(pid, sname, cid)
				if pid ~= nil and sname ~= nil and cid ~= nil then
					local nsids, sids = NS.db_get_sid_by_pid_sname(pid, sname);
					local index_xid = pid == 10 and index_sid or index_cid;
					if nsids > 0 then
						for index = 1, #sids do
							local sid = sids[index];
							local info = recipe_info[sid];
							if info and cid == info[index_xid] then
								return sid;
							end
						end
					end
				end
			end
			--	cid | is_tradeskill
			function NS.db_is_tradeskill_cid(cid)
				return cid ~= nil and cid_to_sid[cid] ~= nil;
			end
			--	cid | nsids, sids{  }
			function NS.db_get_sid_by_cid(cid)
				if cid ~= nil then
					local sids = cid_to_sid[cid];
					if sids then
						return #sids, sids;
					end
				end
				return 0;
			end
			--	pid, cid | nsids, sids{  }
			function NS.db_get_sid_by_pid_cid(pid, cid)
				if pid ~= nil and cid ~= nil then
					local p = cid_pid_to_sid[pid];
					if p then
						local sids = p[cid];
						return #sids, sids;
					end
				end
				return 0;
			end
			function NS.db_get_sid_by_rid(rid)
				if rid ~= nil then
					return rid_to_sid[rid];
				end
			end
			function NS.db_get_sid_by_reagent(iid)
				if iid ~= nil then
					return reagent_to_sid[iid];
				end
			end
		--	QUERY OBJ INFO
			function NS.__db_spell_info(sid)
				if sid ~= nil then
					local info = spell_info[sid];
					if info == nil then
						return NS.db_cache_spell(sid);
					else
						return info;
					end
				end
			end
			function NS.db_spell_name(sid)
				local info = NS.__db_spell_info(sid);
				if info ~= nil then
					return info[1];
				end
			end
			function NS.db_spell_name_lower(sid)
				local info = NS.__db_spell_info(sid);
				if info ~= nil then
					return info[2];
				end
			end
			function NS.db_spell_link(sid)
				local info = NS.__db_spell_info(sid);
				if info ~= nil then
					return info[3];
				end
			end
			function NS.db_spell_link_lower(sid)
				local info = NS.__db_spell_info(sid);
				if info ~= nil then
					return info[4];
				end
			end
			function NS.db_spell_string(sid)
				local info = NS.__db_spell_info(sid);
				if info ~= nil then
					return info[5];
				end
			end
			--
			function NS.__db_item_info(iid)
				if iid ~= nil then
					local info = item_info[iid];
					if info == nil then
						return NS.db_cache_item(iid);
					else
						return info;
					end
				end
			end
			function NS.db_item_info(iid)
				local info = NS.__db_item_info(iid);
				if info ~= nil then
					return unpack(info);
				end
			end
			function NS.db_item_name(iid)
				local info = NS.__db_item_info(iid);
				if info ~= nil then
					return info[index_i_name];
				end
			end
			function NS.db_item_link(iid)
				local info = NS.__db_item_info(iid);
				if info ~= nil then
					return info[index_i_link];
				end
			end
			function NS.db_item_rarity(iid)
				local info = NS.__db_item_info(iid);
				if info ~= nil then
					return info[index_i_rarity];
				end
			end
			function NS.db_item_loc(iid)
				local info = NS.__db_item_info(iid);
				if info ~= nil then
					return info[index_i_loc];
				end
			end
			function NS.db_item_icon(iid)
				local info = NS.__db_item_info(iid);
				if info ~= nil then
					return info[index_i_icon];
				end
			end
			function NS.db_item_sellPrice(iid)
				local info = NS.__db_item_info(iid);
				if info ~= nil then
					return info[index_i_sellPrice];
				end
			end
			function NS.db_item_typeID(iid)
				local info = NS.__db_item_info(iid);
				if info ~= nil then
					return info[index_i_typeID];
				end
			end
			function NS.db_item_subTypeID(iid)
				local info = NS.__db_item_info(iid);
				if info ~= nil then
					return info[index_i_subTypeID];
				end
			end
			function NS.db_item_bindType(iid)
				local info = NS.__db_item_info(iid);
				if info ~= nil then
					return info[index_i_bindType];
				end
			end
			function NS.db_item_name_lower(iid)
				local info = NS.__db_item_info(iid);
				if info ~= nil then
					return info[index_i_name];
				end
			end
			function NS.db_item_link_lower(iid)
				local info = NS.__db_item_info(iid);
				if info ~= nil then
					return info[index_i_link];
				end
			end
			function NS.db_item_string(iid)
				local info = NS.__db_item_info(iid);
				if info ~= nil then
					return info[index_i_string];
				end
			end
			--	secure
			function NS.db_spell_name_s(sid)
				return NS.db_spell_name(sid) or ("spellId:" .. sid);
			end
			function NS.db_spell_link_s(sid)
				return NS.db_spell_link(sid) or ("spellId:" .. sid);
			end
			function NS.db_spell_string_s(sid)
				return NS.db_spell_string(sid) or ("spellId:" .. sid);
			end
			function NS.db_item_name_s(iid)
				return NS.db_item_name(iid) or ("itemId:" .. iid);
			end
			function NS.db_item_link_s(iid)
				return NS.db_item_link(iid) or ("itemId:" .. iid);
			end
			function NS.db_item_string_s(iid)
				return NS.db_item_string(iid) or ("itemId:" .. iid);
			end
		--	MTSL
			local tradeskill_mtsl_name = {
				[1] = "First Aid",
				[2] = "Blacksmithing",
				[3] = "Leatherworking",
				[4] = "Alchemy",
				[6] = "Cooking",
				[7] = "Mining",
				[8] = "Tailoring",
				[9] = "Engineering",
				[10] = "Enchanting",
			};
			function NS.db_get_mtsl_pname(pid)
				if pid ~= nil then
					return tradeskill_mtsl_name[pid];
				else
					return nil;
				end
			end
		--	pid, list, check_hash, phase, rank, rankReversed, showKnown, showUnkown, showHighRank, donot_wipe_list | list{ sid, }
		function NS.db_get_ordered_list(pid, list, check_hash, phase, rank, rankReversed, showKnown, showUnkown, showHighRank, donot_wipe_list)
			if pid == nil then
				_log_("NS.db_get_ordered_list\124cff00ff00#1L1\124r");
				if not donot_wipe_list then
					wipe(list);
				end
				for pid = NS.db_min_pid(), NS.db_max_pid() do
					if recipe_sid_list_by_pid[pid] then
						NS.db_get_ordered_list(pid, list, check_hash, phase, rank, rankReversed, showKnown, showUnkown, showHighRank, true);
					end
				end
			elseif recipe_sid_list_by_pid[pid] ~= nil then
				_log_("NS.db_get_ordered_list\124cff00ff00#1L2\124r", pid);
				local recipe = recipe_sid_list_by_pid[pid];
				if not donot_wipe_list then
					wipe(list);
				end
				phase = phase or curPhase;
				if check_hash ~= nil and rank ~= nil then
					if showKnown and showUnkown then
						if rankReversed then
							for i = 1, #recipe do
								local sid = recipe[i];
								local info = recipe_info[sid]
								if info[index_phase] <= phase and info[index_grey_rank] <= rank then
									tinsert(list, sid);
								end
							end
							for i = 1, #recipe do
								local sid = recipe[i];
								local info = recipe_info[sid]
								if info[index_phase] <= phase and info[index_green_rank] <= rank and info[index_grey_rank] > rank then
									tinsert(list, sid);
								end
							end
							for i = 1, #recipe do
								local sid = recipe[i];
								local info = recipe_info[sid]
								if info[index_phase] <= phase and info[index_yellow_rank] <= rank and info[index_green_rank] > rank then
									tinsert(list, sid);
								end
							end
							for i = 1, #recipe do
								local sid = recipe[i];
								local info = recipe_info[sid]
								if info[index_phase] <= phase and info[index_learn_rank] <= rank and info[index_yellow_rank] > rank then
									tinsert(list, sid);
								end
							end
							if showHighRank then
								for i = 1, #recipe do
									local sid = recipe[i];
									local info = recipe_info[sid]
									if info[index_phase] <= phase and info[index_learn_rank] > rank then
										tinsert(list, sid);
									end
								end
							end
						else
							if showHighRank then
								for i = #recipe, 1, -1 do
									local sid = recipe[i];
									local info = recipe_info[sid]
									if info[index_phase] <= phase and info[index_learn_rank] > rank then
										tinsert(list, sid);
									end
								end
							end
							for i = #recipe, 1, -1 do
								local sid = recipe[i];
								local info = recipe_info[sid]
								if info[index_phase] <= phase and info[index_learn_rank] <= rank and info[index_yellow_rank] > rank then
									tinsert(list, sid);
								end
							end
							for i = #recipe, 1, -1 do
								local sid = recipe[i];
								local info = recipe_info[sid]
								if info[index_phase] <= phase and info[index_yellow_rank] <= rank and info[index_green_rank] > rank then
									tinsert(list, sid);
								end
							end
							for i = #recipe, 1, -1 do
								local sid = recipe[i];
								local info = recipe_info[sid]
								if info[index_phase] <= phase and info[index_green_rank] <= rank and info[index_grey_rank] > rank then
									tinsert(list, sid);
								end
							end
							for i = #recipe, 1, -1 do
								local sid = recipe[i];
								local info = recipe_info[sid]
								if info[index_phase] <= phase and info[index_grey_rank] <= rank then
									tinsert(list, sid);
								end
							end
						end
					elseif showKnown then
						if rankReversed then
							for i = 1, #recipe do
								local sid = recipe[i];
								local info = recipe_info[sid]
								if info[index_phase] <= phase and check_hash[sid] ~= nil and info[index_grey_rank] <= rank then
									tinsert(list, sid);
								end
							end
							for i = 1, #recipe do
								local sid = recipe[i];
								local info = recipe_info[sid]
								if info[index_phase] <= phase and check_hash[sid] ~= nil and info[index_green_rank] <= rank and info[index_grey_rank] > rank then
									tinsert(list, sid);
								end
							end
							for i = 1, #recipe do
								local sid = recipe[i];
								local info = recipe_info[sid]
								if info[index_phase] <= phase and check_hash[sid] ~= nil and info[index_yellow_rank] <= rank and info[index_green_rank] > rank then
									tinsert(list, sid);
								end
							end
							for i = 1, #recipe do
								local sid = recipe[i];
								local info = recipe_info[sid]
								if info[index_phase] <= phase and check_hash[sid] ~= nil and info[index_learn_rank] <= rank and info[index_yellow_rank] > rank then
									tinsert(list, sid);
								end
							end
						else
							for i = #recipe, 1, -1 do
								local sid = recipe[i];
								local info = recipe_info[sid]
								if info[index_phase] <= phase and check_hash[sid] ~= nil and info[index_learn_rank] <= rank and info[index_yellow_rank] > rank then
									tinsert(list, sid);
								end
							end
							for i = #recipe, 1, -1 do
								local sid = recipe[i];
								local info = recipe_info[sid]
								if info[index_phase] <= phase and check_hash[sid] ~= nil and info[index_yellow_rank] <= rank and info[index_green_rank] > rank then
									tinsert(list, sid);
								end
							end
							for i = #recipe, 1, -1 do
								local sid = recipe[i];
								local info = recipe_info[sid]
								if info[index_phase] <= phase and check_hash[sid] ~= nil and info[index_green_rank] <= rank and info[index_grey_rank] > rank then
									tinsert(list, sid);
								end
							end
							for i = #recipe, 1, -1 do
								local sid = recipe[i];
								local info = recipe_info[sid]
								if info[index_phase] <= phase and check_hash[sid] ~= nil and info[index_grey_rank] <= rank then
									tinsert(list, sid);
								end
							end
						end
					elseif showUnkown then
						if rankReversed then
							for i = 1, #recipe do
								local sid = recipe[i];
								local info = recipe_info[sid]
								if info[index_phase] <= phase and check_hash[sid] == nil and info[index_grey_rank] <= rank then
									tinsert(list, sid);
								end
							end
							for i = 1, #recipe do
								local sid = recipe[i];
								local info = recipe_info[sid]
								if info[index_phase] <= phase and check_hash[sid] == nil and info[index_green_rank] <= rank and info[index_grey_rank] > rank then
									tinsert(list, sid);
								end
							end
							for i = 1, #recipe do
								local sid = recipe[i];
								local info = recipe_info[sid]
								if info[index_phase] <= phase and check_hash[sid] == nil and info[index_yellow_rank] <= rank and info[index_green_rank] > rank then
									tinsert(list, sid);
								end
							end
							for i = 1, #recipe do
								local sid = recipe[i];
								local info = recipe_info[sid]
								if info[index_phase] <= phase and check_hash[sid] == nil and info[index_learn_rank] <= rank and info[index_yellow_rank] > rank then
									tinsert(list, sid);
								end
							end
							if showHighRank then
								for i = 1, #recipe do
									local sid = recipe[i];
									local info = recipe_info[sid]
									if info[index_phase] <= phase and check_hash[sid] == nil and info[index_learn_rank] > rank then
										tinsert(list, sid);
									end
								end
							end
						else
							if showHighRank then
								for i = #recipe, 1, -1 do
									local sid = recipe[i];
									local info = recipe_info[sid]
									if info[index_phase] <= phase and check_hash[sid] == nil and info[index_learn_rank] > rank then
										tinsert(list, sid);
									end
								end
							end
							for i = #recipe, 1, -1 do
								local sid = recipe[i];
								local info = recipe_info[sid]
								if info[index_phase] <= phase and check_hash[sid] == nil and info[index_learn_rank] <= rank and info[index_yellow_rank] > rank then
									tinsert(list, sid);
								end
							end
							for i = #recipe, 1, -1 do
								local sid = recipe[i];
								local info = recipe_info[sid]
								if info[index_phase] <= phase and check_hash[sid] == nil and info[index_yellow_rank] <= rank and info[index_green_rank] > rank then
									tinsert(list, sid);
								end
							end
							for i = #recipe, 1, -1 do
								local sid = recipe[i];
								local info = recipe_info[sid]
								if info[index_phase] <= phase and check_hash[sid] == nil and info[index_green_rank] <= rank and info[index_grey_rank] > rank then
									tinsert(list, sid);
								end
							end
							for i = #recipe, 1, -1 do
								local sid = recipe[i];
								local info = recipe_info[sid]
								if info[index_phase] <= phase and check_hash[sid] == nil and info[index_grey_rank] <= rank then
									tinsert(list, sid);
								end
							end
						end
					end
				elseif check_hash ~= nil then
					if showKnown and showUnkown then
						if rankReversed then
							for i = 1, #recipe do
								local sid = recipe[i];
								tinsert(list, sid);
							end
						else
							for i = #recipe, 1, -1 do
								local sid = recipe[i];
								tinsert(list, sid);
							end
						end
					elseif showKnown then
						if rankReversed then
							for i = 1, #recipe do
								local sid = recipe[i];
								if check_hash[sid] ~= nil then
									tinsert(list, sid);
								end
							end
						else
							for i = #recipe, 1, -1 do
								local sid = recipe[i];
								if check_hash[sid] ~= nil then
									tinsert(list, sid);
								end
							end
						end
					elseif showUnkown then
						if rankReversed then
							for i = 1, #recipe do
								local sid = recipe[i];
								if check_hash[sid] == nil then
									tinsert(list, sid);
								end
							end
						else
							for i = #recipe, 1, -1 do
								local sid = recipe[i];
								if check_hash[sid] == nil then
									tinsert(list, sid);
								end
							end
						end
					end
				elseif rank ~= nil then
					if rankReversed then
						for i = 1, #recipe do
							local sid = recipe[i];
							local info = recipe_info[sid]
							if info[index_phase] <= phase and info[index_grey_rank] <= rank then
								tinsert(list, sid);
							end
						end
						for i = 1, #recipe do
							local sid = recipe[i];
							local info = recipe_info[sid]
							if info[index_phase] <= phase and info[index_green_rank] <= rank and info[index_grey_rank] > rank then
								tinsert(list, sid);
							end
						end
						for i = 1, #recipe do
							local sid = recipe[i];
							local info = recipe_info[sid]
							if info[index_phase] <= phase and info[index_yellow_rank] <= rank and info[index_green_rank] > rank then
								tinsert(list, sid);
							end
						end
						for i = 1, #recipe do
							local sid = recipe[i];
							local info = recipe_info[sid]
							if info[index_phase] <= phase and info[index_learn_rank] <= rank and info[index_yellow_rank] > rank then
								tinsert(list, sid);
							end
						end
						if showHighRank then
							for i = 1, #recipe do
								local sid = recipe[i];
								local info = recipe_info[sid]
								if info[index_phase] <= phase and info[index_learn_rank] > rank then
									tinsert(list, sid);
								end
							end
						end
					else
						if showHighRank then
							for i = #recipe, 1, -1 do
								local sid = recipe[i];
								local info = recipe_info[sid]
								if info[index_phase] <= phase and info[index_learn_rank] > rank then
									tinsert(list, sid);
								end
							end
						end
						for i = #recipe, 1, -1 do
							local sid = recipe[i];
							local info = recipe_info[sid]
							if info[index_phase] <= phase and info[index_learn_rank] <= rank and info[index_yellow_rank] > rank then
								tinsert(list, sid);
							end
						end
						for i = #recipe, 1, -1 do
							local sid = recipe[i];
							local info = recipe_info[sid]
							if info[index_phase] <= phase and info[index_yellow_rank] <= rank and info[index_green_rank] > rank then
								tinsert(list, sid);
							end
						end
						for i = #recipe, 1, -1 do
							local sid = recipe[i];
							local info = recipe_info[sid]
							if info[index_phase] <= phase and info[index_green_rank] <= rank and info[index_grey_rank] > rank then
								tinsert(list, sid);
							end
						end
						for i = #recipe, 1, -1 do
							local sid = recipe[i];
							local info = recipe_info[sid]
							if info[index_phase] <= phase and info[index_grey_rank] <= rank then
								tinsert(list, sid);
							end
						end
					end
				else
					if rankReversed then
						Mixin(list, recipe);
					else
						for i = #recipe, 1, -1 do
							local sid = recipe[i];
							tinsert(list, sid);
						end
					end
				end
			else
				_log_("NS.db_get_ordered_list\124cff00ff00#1L3\124r", pid);
			end
			return list;
		end
		--
		-- if select(2, BNGetInfo()) == 'alex#516722' then
			function NS.link_db()	--	recipe_info, spell_info, item_info
				return recipe_info, spell_info, item_info;
			end
		-- end
	end

	local explorer_hash = {  };
	local explorer_stat_list = { skill = {  }, type = {  }, subType = {  }, eqLoc = {  }, };
	do	--	func
		local function func_add_known_recipe(sid, GUID)
			local list = explorer_hash[sid];
			if list == nil then
				list = {  };
				explorer_hash[sid] = list;
			end
			list[GUID] = 1;
		end
		local function func_sub_known_recipe(sid, GUID)
			local list = explorer_hash[sid];
			if list then
				list[GUID] = nil;
			end
			for _ in next, list do
				return;
			end
			explorer_hash[sid] = nil;
		end
		--
		function NS.init_hash_known_recipe()
			for GUID, VAR in next, AVAR do
				if VAR.realm_id == PLAYER_REALM_ID then
					for pid = NS.db_min_pid(), NS.db_max_pid() do
						local var = rawget(VAR, pid);
						if var and NS.db_is_pid(pid) then
							local list = var[1];
							for index = 1, #list do
								func_add_known_recipe(list[index], GUID);
							end
						end
					end
				end
			end
		end
		--
		function NS.SKILL_LINES_CHANGED()	--	Donot process the first trigger after login. And wait for 1sec.
			local func_SKILL_LINES_CHANGED = function()
				local check_name = NS.db_table_tradeskill_check_name();
				for pid = NS.db_min_pid(), NS.db_max_pid() do
					local cpname = check_name[pid];
					if cpname then
						if not GetSpellInfo(cpname) then
							rawset(VAR, pid, nil);
						end
					end
				end
				for index = 1, GetNumSkillLines() do
					local pname, header, expanded, cur_rank, _, _, max_rank  = GetSkillLineInfo(index);
					if not header then
						local pid = NS.db_get_pid_by_pname(pname);
						if pid then
							local var = VAR[pid];
							var.update = true;
							var.cur_rank, var.max_rank = cur_rank, max_rank;
							NS.cooldown_check(pid, var);
						end
					end
				end
				local tf = gui.Blizzard_TradeSkillUI;
				local cf = gui.Blizzard_CraftUI;
				if tf then
					tf.tabFrame:Update();
					tf.switch:Update();
				end
				if cf then
					cf.tabFrame:Update();
					cf.switch:Update();
				end
			end
			C_Timer.After(1.0, function()
				func_SKILL_LINES_CHANGED();
				NS.SKILL_LINES_CHANGED = func_SKILL_LINES_CHANGED;
				func_SKILL_LINES_CHANGED = nil;
			end);
		end
		function NS.NEW_RECIPE_LEARNED(sid)
			local pid = NS.db_get_pid_by_sid(sid);
			if pid then
				local var = VAR[pid];
				var.update = true;
				tinsert(var[1], sid);
				var[2][sid] = -1;
				func_add_known_recipe(sid, PLAYER_GUID);
				_EventHandler:FireEvent("USER_EVENT_RECIPE_LIST_UPDATE");
			else
				_error_("NS.NEW_RECIPE_LEARNED#0", sid);
			end
		end
		--------
		local function process_search(list, searchText, searchNameOnly)
			local item_func = searchNameOnly and NS.db_item_name_lower or NS.db_item_link_lower;
			local spell_func = searchNameOnly and NS.db_spell_name_lower or NS.db_spell_link_lower;
			for index = #list, 1, -1 do
				local sid = list[index];
				local info = NS.db_get_info_by_sid(sid);
				if info then
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
		local function safe_process_search(frame, regular_exp, list, searchText, searchNameOnly)
			if regular_exp then
				searchText = strlower(searchText);
				local result, ret = pcall(process_search, list, searchText, searchNameOnly);
				if result then
					frame:SearchEditValid();
				else
					frame:SearchEditInvalid();
				end
			else
				searchText = gsub(strlower(searchText), "[%^%$%%%.%+%-%*%?%[%]%(%)]", "%%%1");
				process_search(list, searchText, searchNameOnly);
				frame:SearchEditValid();
			end
		end
		function NS.process_update(frame)
			-- if frame.mute_update then
			-- 	return;
			-- end
			-- frame.mute_update = true;
			if frame.hooked_frame:IsShown() then
				local skillName, cur_rank, max_rank = frame.pinfo();
				local pid = NS.db_get_pid_by_pname(skillName);
				frame.flag = pid;
				if pid then
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
					-- if frame.prev_pid ~= pid then
						if set.shown then
							frame:Show();
							frame.call:SetText(L["Close"]);
						else
							frame:Hide();
							frame.call:SetText(L["Open"]);
						end
					-- end
					if SET.show_call then
						frame.call:Show();
					end
					if frame:IsShown() then
						if update_list then
							local sids = var[1];
							local hash = var[2];
							if update_var then
								_log_("NS.process_update\124cff00ff00#1L1\124r");
								local num = frame.recipe_num();
								if num <= 0 then
									-- frame.mute_update = false;
									return;
								end
								var.cur_rank = cur_rank;
								for index = 1, #sids do
									func_sub_known_recipe(sids[index], PLAYER_GUID);
								end
								wipe(sids);
								wipe(hash);
								for index = 1, num do
									local sname, srank = frame.recipe_info(index);
									if sname and srank and srank ~= 'header' then
										local cid = frame.recipe_itemId(index);
										if cid then
											local sid = NS.db_get_sid_by_pid_sname_cid(pid, sname, cid);
											local info = NS.db_get_info_by_sid(sid);
											if info then
												if hash[sid] then
													_error_("NS.process_update#0E3", pid .. "#" .. cid .. "#" .. sname .. "#" .. sid);
												else
													tinsert(sids, sid);
													hash[sid] = index;
													func_add_known_recipe(sid, PLAYER_GUID);
												end
												if index == frame.get_select() then
													frame.selected_sid = sid;
												end
											else
												_error_("NS.process_update#0E2", pid .. "#" .. cid .. "#" .. sname);
											end
										else
											_error_("NS.process_update#0E1", pid .. "#" .. sname);
										end
									end
								end
								var.update = nil;
								frame.update = nil;
							else
								_log_("NS.process_update\124cff00ff00#1L2\124r");
							end
							if #sids > 0 then
								if frame.prev_pid ~= pid then
									if set.showProfit then
										frame.profitFrame:Show();
									else
										frame.profitFrame:Hide();
									end
									if set.showSet then
										-- frame.setFrame:Show();
										frame:ShowSetFrame(true);
									else
										-- frame.setFrame:Hide();
										frame:HideSetFrame();
									end
									frame.searchEditNameOnly:SetChecked(set.searchNameOnly);
								end
								frame.prev_pid = pid;
								frame.hash = hash;
								local list = frame.list;
								NS.db_get_ordered_list(pid, list, hash, set.phase, cur_rank, set.rankReversed, set.showKnown, set.showUnkown, set.showHighRank);
								if set.haveMaterials then
									for i = #list, 1, -1 do
										local sid = list[i];
										local index = hash[sid];
										if index == nil or select(3, frame.recipe_info(index)) <= 0 then
											tremove(list, i);
										end
									end
								end
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
								local searchText = set.searchText;
								if searchText then
									safe_process_search(frame, SET.regular_exp, list, searchText, set.searchNameOnly);
								else
									frame:SearchEditValid();
								end
								frame.scroll:SetNumValue(#list);
								frame.scroll:Update();
								frame:RefreshSetFrame();
								frame:RefreshSearchEdit();
								NS.process_profit_update(frame);
								set.update = nil;
								_EventHandler:FireEvent("USER_EVENT_RECIPE_LIST_UPDATE");
							else
								var.update = true;
								-- frame.mute_update = false;
							end
						else
							_log_("NS.process_update\124cff00ff00#2L1\124r");
							if #var[1] > 0 then
								frame.scroll:Update();
								if frame.profitFrame:IsShown() then
									frame.profitScroll:Update();
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
								_log_("NS.process_update\124cff00ff00#1L1\124r");
								local num = frame.recipe_num();
								if num <= 0 then
									-- frame.mute_update = false;
									return;
								end
								var.cur_rank = cur_rank;
								for index = 1, num do
									local sname, srank = frame.recipe_info(index);
									if sname and srank and srank ~= 'header' then
										local cid = frame.recipe_itemId(index);
										if cid then
											local sid = NS.db_get_sid_by_pid_sname_cid(pid, sname, cid);
											local info = NS.db_get_info_by_sid(sid);
											if info then
												if hash[sid] == nil then
													tinsert(sids, sid);
													hash[sid] = index;
													func_add_known_recipe(sid, PLAYER_GUID);
												end
											else
												_error_("NS.process_update#0E2", pid .. "#" .. cid .. "#" .. sname);
											end
										else
											_error_("NS.process_update#0E1", pid .. "#" .. sname);
										end
									end
								end
								var.update = nil;
								frame.update = nil;
							end
						end
					end
					var.max_rank = max_rank;
					NS.cooldown_check(pid, var);
				else
					frame:Hide();
					frame.call:Hide();
				end
			end
			-- frame.mute_update = false;
		end
		function NS.process_profit_update_list(frame, list, only_cost)
			local sid_list = frame.list;
			wipe(list);
			if merc then
				local pid = frame.flag or NS.db_get_pid_by_pname(frame.pname());
				if only_cost and frame.flag ~= 'explorer' then
					local var = rawget(VAR, pid);
					local cur_rank = var and var.cur_rank or 0;
					for index = 1, #sid_list do
						local sid = sid_list[index];
						local price_a_product, price_a_material, price_a_material_known, missing = NS.price_gen_info_by_sid(SET[pid].phase, sid, NS.db_get_num_made_by_sid(sid), nil);
						if price_a_material then
							tinsert(list, { sid, price_a_material, NS.db_get_difficulty_rank_by_sid(sid, cur_rank), });
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
						local price_a_product, price_a_material, price_a_material_known, missing = NS.price_gen_info_by_sid(SET[pid].phase, sid, NS.db_get_num_made_by_sid(sid), nil);
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
		function NS.process_profit_update(frame)
			local profitFrame = frame.profitFrame;
			if profitFrame:IsVisible() then
				_log_("NS.process_profit_update\124cff00ff00#1L1\124r");
				local list = profitFrame.list;
				local pid = frame.flag or NS.db_get_pid_by_pname(frame.pname());
				if profitFrame.costOnly then
					local only_cost = SET[pid].costOnly;
					NS.process_profit_update_list(frame, list, only_cost);
					profitFrame.costOnly:SetChecked(only_cost);
				else
					NS.process_profit_update_list(frame, list);
				end
				profitFrame.scroll:SetNumValue(#list);
				profitFrame.scroll:Update();
			end
		end
		--
			local loc_to_lid = {
				["INVTYPE_AMMO"] = 0,	            --	Ammo
				["INVTYPE_HEAD"] = 1,	            --	Head
				["INVTYPE_NECK"] = 2,	            --	Neck
				["INVTYPE_SHOULDER"] = 3,	        --	Shoulder
				["INVTYPE_BODY"] = 4,	            --	Shirt
				["INVTYPE_CHEST"] = 5,	        --	Chest
				["INVTYPE_ROBE"] = 5,	            --	Chest
				["INVTYPE_WAIST"] = 6,	        --	Waist
				["INVTYPE_LEGS"] = 7,	            --	Legs
				["INVTYPE_FEET"] = 8,	            --	Feet
				["INVTYPE_WRIST"] = 9,	        --	Wrist
				["INVTYPE_HAND"] = 10,	        --	Hands
				["INVTYPE_FINGER"] = 11,	        --	Fingers
				["INVTYPE_TRINKET"] = 13,	        --	Trinkets
				["INVTYPE_CLOAK"] = 15,	        --	Cloaks
				["INVTYPE_WEAPON"] = 21,	        --	16  One-Hand
				["INVTYPE_SHIELD"] = 17,	        --	Shield
				["INVTYPE_2HWEAPON"] = 22,	    --	16  Two-Handed
				["INVTYPE_WEAPONMAINHAND"] = 16,	--	Main-Hand Weapon
				["INVTYPE_WEAPONOFFHAND"] = 17,	--	Off-Hand Weapon
				["INVTYPE_HOLDABLE"] = 17,	    --	Held In Off-Hand
				["INVTYPE_RANGED"] = 18,	        --	Bows
				["INVTYPE_THROWN"] = 18,	        --	Ranged
				["INVTYPE_RANGEDRIGHT"] = 18,	    --	Wands, Guns, and Crossbows
				["INVTYPE_RELIC"] = 18,	        --	Relics
				["INVTYPE_TABARD"] = 19,	        --	Tabard
				["INVTYPE_BAG"] = 20,	            --	Containers
				["INVTYPE_QUIVER"] = 20,	        --	Quivers
			};
			local no_one_learned_skill = {  };
			local filter_key = { "type", "subType", "eqLoc", };
			local filter_func = {
				type = NS.db_item_typeID,
				subType = NS.db_item_subTypeID,
				eqLoc = function(iid)
					local loc = NS.db_item_loc(iid);
					return loc and loc_to_lid[loc];
				end,
			};
		function NS.process_explorer_update_list(frame, stat, filter, searchText, searchNameOnly, list, check_hash, phase, rank, rankReversed, showKnown, showUnkown, showHighRank, donot_wipe_list)
			NS.db_get_ordered_list(filter.skill, list, check_hash, phase, rank, rankReversed, showKnown, showUnkown, showHighRank, donot_wipe_list);
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
			for index = 1, #filter_key do
				local key = filter_key[index];
				local val = filter[key];
				local func = filter_func[key];
				if val and func then
					for index = #list, 1, -1 do
						local sid = list[index];
						local cid = NS.db_get_cid_by_sid(sid);
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
				safe_process_search(frame, SET.regular_exp, list, searchText, searchNameOnly)
			else
				frame:SearchEditValid();
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
					local info = NS.db_get_info_by_sid(sid);
					if info then
						local pid = info[index_pid];
						skill_hash[pid] = explorer_hash[sid] or no_one_learned_skill;
						local cid = info[index_cid];
						if cid then
							local _type = NS.db_item_typeID(cid);
							local _subType = NS.db_item_subTypeID(cid);
							local _eqLoc = NS.db_item_loc(cid);
							local _eqLid = loc_to_lid[_eqLoc];
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
		function NS.process_explorer_update(frame, update_list)
			if frame:IsVisible() then
				local set = SET.explorer;
				local hash = frame.hash;
				local list = frame.list;
				if update_list then
					_log_("NS.process_explorer_update\124cff00ff00#1L1\124r");
					if set.showProfit then
						frame.profitFrame:Show();
					else
						frame.profitFrame:Hide();
					end
					if set.showSet then
						frame.setFrame:Show();
					else
						frame.setFrame:Hide();
					end
					frame.searchEditNameOnly:SetChecked(set.searchNameOnly);
					NS.process_explorer_update_list(frame, explorer_stat_list, set.filter, set.searchText, set.searchNameOnly,
												list, hash, set.phase, nil, set.rankReversed, set.showKnown, set.showUnkown, set.showHighRank);
					NS.process_profit_update(frame);
				else
					_log_("NS.process_explorer_update\124cff00ff00#1L2\124r");
				end
				frame.scroll:SetNumValue(#list);
				frame.scroll:Update();
				frame:RefreshSetFrame();
				frame:RefreshSearchEdit();
			end
		end
		--
		function NS.func_add_char(key, VAR, before_initialized)
			if key and VAR and AVAR[key] == nil then
				for index = #SET.char_list, 1, -1 do
					if SET.char_list[index] == key then
						tremove(SET.char_list, index);
					end
				end
				AVAR[key] = VAR;
				tinsert(SET.char_list, key);
				if not before_initialized then
					NS.ui_update_all();
				end
			end
		end
		function NS.func_del_char(index)
			local list = SET.char_list;
			if index and index <= #list then
				local key = list[index];
				if key ~= PLAYER_GUID then
					tremove(list, index);
					AVAR[key] = nil;
					NS.ui_update_all();
				end
			end
		end
		function NS.func_del_char_by_key(key)
			if key then
				local list = SET.char_list;
				for index = 1, #list do
					if list[index] == key then
						NS.func_del_char(index);
						break;
					end
				end
			end
		end
		function NS.enchant_link(sid)
			local name = GetSpellInfo(sid);
			if name then
				return "\124cffffffff\124Henchant:" .. sid .. "\124h[" .. name .. "]\124h\124r";
			else
				return nil;
			end
		end
		function NS.change_set_with_update(set, key, val)
			set[key] = val;
			set.update = true;
		end
		--
		local frames = {  };
		function NS.merc_AddFrame(frame)
			frames[frame] = true;
			if merc and merc.add_cache_callback then
				merc.add_cache_callback(function()
					frame.scroll:Update();
					NS.process_profit_update(frame);
					frame:updatePriceInfoInFrame();
				end);
			end
		end
		function NS.merc_RegAllFrames()
			for frame, _ in next, frames do
				NS.merc_AddFrame(frame);
			end
		end
	end

	local mouse_focus_sid = nil;
	local mouse_focus_phase = curPhase;
	do	--	hook ui
		--
			--	obj style
				function NS.ui_hide_permanently(obj)
					obj._SetAlpha = obj._SetAlpha or obj.SetAlpha;
					obj._EnableMouse = obj._EnableMouse or obj.EnableMouse;
					obj:_SetAlpha(0.0);
					obj:_EnableMouse(false);
				end
				function NS.ui_unhide_permanently(obj)
					obj._SetAlpha = obj._SetAlpha or obj.SetAlpha;
					obj._EnableMouse = obj._EnableMouse or obj.EnableMouse;
					obj:_SetAlpha(1.0);
					obj:_EnableMouse(true);
				end
				function NS.ui_ModernBackdrop(frame)
					frame:SetBackdrop(ui_style.modernFrameBackdrop);
					frame:SetBackdropColor(unpack(SET.bg_color));
				end
				function NS.ui_BlzBackdrop(frame)
					frame:SetBackdrop(ui_style.blzFrameBackdrop);
					frame:SetBackdropColor(1.0, 1.0, 1.0, 1.0);
					frame:SetBackdropBorderColor(1.0, 1.0, 1.0, 1.0);
				end
				function NS.ui_ModernButton(button, bak, texture)
					if button.Left then
						button.Left:SetAlpha(0.0);
					end
					if button.Middle then
						button.Middle:SetAlpha(0.0);
					end
					if button.Right then
						button.Right:SetAlpha(0.0);
					end
					local ntex = button:GetNormalTexture();
					local ptex = button:GetPushedTexture();
					local htex = button:GetHighlightTexture();
					local dtex = button:GetDisabledTexture();
					if bak and not bak._got then
						bak[1] = ntex and ntex:GetTexture() or nil;
						bak[2] = ptex and ptex:GetTexture() or nil;
						bak[3] = htex and htex:GetTexture() or nil;
						bak[4] = dtex and dtex:GetTexture() or nil;
						bak._got = true;
					end
					ntex = ntex or button:SetNormalTexture(ui_style.texture_unk) or button:GetNormalTexture();
					ptex = ptex or button:SetPushedTexture(ui_style.texture_unk) or button:GetPushedTexture();
					htex = htex or button:SetHighlightTexture(ui_style.texture_unk) or button:GetHighlightTexture();
					dtex = dtex or button:SetDisabledTexture(ui_style.texture_unk) or button:GetDisabledTexture();
					if texture then
						button:SetBackdrop(nil);
						button:SetNormalTexture(texture);
						button:SetPushedTexture(texture);
						button:SetHighlightTexture(texture);
						button:SetDisabledTexture(texture);
						ntex = ntex or button:GetNormalTexture();
						ptex = ptex or button:GetPushedTexture();
						htex = htex or button:GetHighlightTexture();
						dtex = dtex or button:GetDisabledTexture();
						ntex:SetVertexColor(unpack(ui_style.textureButtonColorNormal));
						ptex:SetVertexColor(unpack(ui_style.textureButtonColorPushed));
						htex:SetVertexColor(unpack(ui_style.textureButtonColorHighlight));
						dtex:SetVertexColor(unpack(ui_style.textureButtonColorDisabled));
					else
						button:SetBackdrop(ui_style.modernButtonBackdrop);
						button:SetBackdropColor(unpack(ui_style.modernButtonBackdropColor));
						button:SetBackdropBorderColor(unpack(ui_style.modernButtonBackdropBorderColor));
						button:SetPushedTextOffset(0.0, 0.0);
						if ntex then ntex:SetColorTexture(unpack(ui_style.modernColorButtonColorNormal)); end
						if ptex then ptex:SetColorTexture(unpack(ui_style.modernColorButtonColorPushed)); end
						if htex then htex:SetColorTexture(unpack(ui_style.modernColorButtonColorHighlight)); end
						if dtex then dtex:SetColorTexture(unpack(ui_style.modernColorButtonColorDisabled)); end
					end
				end
				function NS.ui_BlzButton(button, bak)
					if button.Left then
						button.Left:SetAlpha(1.0);
					end
					if button.Middle then
						button.Middle:SetAlpha(1.0);
					end
					if button.Right then
						button.Right:SetAlpha(1.0);
					end
					if bak then
						button:SetNormalTexture(bak[1]);
						button:SetPushedTexture(bak[2]);
						button:SetHighlightTexture(bak[3]);
						button:SetDisabledTexture(bak[4]);
					end
					button:SetBackdrop(nil);
					button:SetPushedTextOffset(1.55, -1.55);
					local ntex = button:GetNormalTexture();
					local ptex = button:GetPushedTexture();
					local htex = button:GetHighlightTexture();
					local dtex = button:GetDisabledTexture();
					if ntex then ntex:SetVertexColor(1.0, 1.0, 1.0, 1.0); end
					if ptex then ptex:SetVertexColor(1.0, 1.0, 1.0, 1.0); end
					if htex then htex:SetVertexColor(1.0, 1.0, 1.0, 1.0); end
					if dtex then dtex:SetVertexColor(1.0, 1.0, 1.0, 1.0); end
				end
				function NS.ui_ModifyALAScrollFrame(scroll)
					local children = { scroll:GetChildren() };
					for index = 1, #children do
						local obj = children[index];
						if strupper(obj:GetObjectType()) == 'SLIDER' then
							scroll.ScrollBar = obj;
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
							obj:SetPoint("TOPRIGHT", scroll, "TOPRIGHT", 0, -16);
							obj:SetPoint("BOTTOMRIGHT", scroll, "BOTTOMRIGHT", 0, 16);
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
							local function hook_OnValueChanged(self, val)
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
							obj:HookScript("OnValueChanged", hook_OnValueChanged);
							hooksecurefunc(scroll, "SetNumValue", function(self)
								hook_OnValueChanged(obj);
							end);
							break;
						end
					end
				end
				function NS.ui_ModernScrollFrame(scroll)
					local regions = { scroll:GetRegions() };
					for index = 1, #regions do
						local obj = regions[index];
						if strupper(obj:GetObjectType()) == 'TEXTURE' then
							obj._Show = obj._Show or obj.Show;
							obj.Show = _noop_;
							obj:Hide();
						end
					end
					--
					local bar = scroll.ScrollBar;
					bar:SetBackdrop(ui_style.scrollBackdrop);
					bar:SetBackdropBorderColor(unpack(ui_style.modernScrollBackdropBorderColor));
					local thumb = bar:GetThumbTexture();
					if thumb == nil then
						bar:SetThumbTexture("Interface\\Buttons\\UI-ScrollBar-Knob");
						thumb = bar:GetThumbTexture();
					end
					thumb:SetColorTexture(unpack(ui_style.modernScrollBackdropBorderColor));
					thumb:SetWidth(bar:GetWidth());
					local up = bar.ScrollUpButton;
					up:SetNormalTexture(ui_style.texture_modern_arrow_up);
					up:GetNormalTexture():SetTexCoord(0.0, 1.0, 0.0, 1.0);
					up:GetNormalTexture():SetVertexColor(unpack(ui_style.textureButtonColorNormal));
					up:SetPushedTexture(ui_style.texture_modern_arrow_up);
					up:GetPushedTexture():SetTexCoord(0.0, 1.0, 0.0, 1.0);
					up:GetPushedTexture():SetVertexColor(unpack(ui_style.textureButtonColorPushed));
					up:SetHighlightTexture(ui_style.texture_modern_arrow_up);
					up:GetHighlightTexture():SetTexCoord(0.0, 1.0, 0.0, 1.0);
					up:GetHighlightTexture():SetVertexColor(unpack(ui_style.textureButtonColorHighlight));
					up:SetDisabledTexture(ui_style.texture_modern_arrow_up);
					up:GetDisabledTexture():SetTexCoord(0.0, 1.0, 0.0, 1.0);
					up:GetDisabledTexture():SetVertexColor(unpack(ui_style.textureButtonColorDisabled));
					local down = bar.ScrollDownButton;
					down:SetNormalTexture(ui_style.texture_modern_arrow_down);
					down:GetNormalTexture():SetTexCoord(0.0, 1.0, 0.0, 1.0);
					down:GetNormalTexture():SetVertexColor(unpack(ui_style.textureButtonColorNormal));
					down:SetPushedTexture(ui_style.texture_modern_arrow_down);
					down:GetPushedTexture():SetTexCoord(0.0, 1.0, 0.0, 1.0);
					down:GetPushedTexture():SetVertexColor(unpack(ui_style.textureButtonColorPushed));
					down:SetHighlightTexture(ui_style.texture_modern_arrow_down);
					down:GetHighlightTexture():SetTexCoord(0.0, 1.0, 0.0, 1.0);
					down:GetHighlightTexture():SetVertexColor(unpack(ui_style.textureButtonColorHighlight));
					down:SetDisabledTexture(ui_style.texture_modern_arrow_down);
					down:GetDisabledTexture():SetTexCoord(0.0, 1.0, 0.0, 1.0);
					down:GetDisabledTexture():SetVertexColor(unpack(ui_style.textureButtonColorDisabled));
				end
				function NS.ui_BlzScrollFrame(scroll)
					local regions = { scroll:GetRegions() };
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
					local bar = scroll.ScrollBar;
					bar:SetBackdrop(ui_style.scrollBackdrop);
					bar:SetBackdropBorderColor(unpack(ui_style.blzScrollBackdropBorderColor));
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
				function NS.ui_Re_LayoutDropDownMenu(drop)
					drop.hooked = true;
					drop:SetWidth(135);
					drop.Left:ClearAllPoints();
					drop.Left:SetPoint("LEFT", -17, -1);
					local button = drop.Button;
					button:ClearAllPoints();
					button:SetPoint("CENTER", drop, "RIGHT", -12, 0);
					button:GetNormalTexture():SetAllPoints();
					button:GetPushedTexture():SetAllPoints();
					button:GetHighlightTexture():SetAllPoints();
					button:GetDisabledTexture():SetAllPoints();
					drop:SetScale(0.9);
					drop._SetHeight = drop.SetHeight;
					drop.SetHeight = _noop_;
					drop:_SetHeight(22);
				end
				function NS.ui_ModernDropDownMenu(drop)
					if not drop.hooked then
						NS.ui_Re_LayoutDropDownMenu(drop);
					end
					drop.Left:Hide();
					drop.Middle:Hide();
					drop.Right:Hide();
					drop:SetBackdrop(ui_style.modernButtonBackdrop);
					drop:SetBackdropColor(unpack(ui_style.modernButtonBackdropColor));
					drop:SetBackdropBorderColor(unpack(ui_style.modernButtonBackdropBorderColor));
					local button = drop.Button;
					button:SetSize(17, 16);
					button:SetNormalTexture(ui_style.texture_modern_arrow_down);
					button:SetPushedTexture(ui_style.texture_modern_arrow_down);
					button:SetHighlightTexture(ui_style.texture_modern_arrow_down);
					button:SetDisabledTexture(ui_style.texture_modern_arrow_down);
					button:GetNormalTexture():SetVertexColor(unpack(ui_style.textureButtonColorNormal));
					button:GetPushedTexture():SetVertexColor(unpack(ui_style.textureButtonColorPushed));
					button:GetHighlightTexture():SetVertexColor(unpack(ui_style.textureButtonColorHighlight));
					button:GetDisabledTexture():SetVertexColor(unpack(ui_style.textureButtonColorDisabled));
				end
				function NS.ui_BlzDropDownMenu(drop)
					drop.Left:Show();
					drop.Middle:Show();
					drop.Right:Show();
					drop:SetBackdrop(nil);
					local button = drop.Button;
					button:SetSize(24, 24);
					button:SetNormalTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Up");
					button:SetPushedTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Down");
					button:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight");
					button:SetDisabledTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Disabled");
					button:GetNormalTexture():SetVertexColor(1.0, 1.0, 1.0, 1.0);
					button:GetPushedTexture():SetVertexColor(1.0, 1.0, 1.0, 1.0);
					button:GetHighlightTexture():SetVertexColor(1.0, 1.0, 1.0, 1.0);
					button:GetDisabledTexture():SetVertexColor(1.0, 1.0, 1.0, 1.0);
				end
				function NS.ui_ModernEditBox(edit)
					local regions = { edit:GetRegions() };
					for index = 1, #regions do
						local obj = regions[index];
						if strupper(obj:GetObjectType()) == "TEXTURE" then
							obj:Hide();
						end
					end
					edit:SetBackdrop(ui_style.modernButtonBackdrop);
					edit:SetBackdropColor(unpack(ui_style.modernButtonBackdropColor));
					edit:SetBackdropBorderColor(unpack(ui_style.modernButtonBackdropBorderColor));
				end
				function NS.ui_BlzEditBox(edit)
					local regions = { edit:GetRegions() };
					for index = 1, #regions do
						regions[index]:Show();
					end
					edit:SetBackdrop(nil);
				end
				function NS.ui_ModernCheckButton(check)
					check:SetNormalTexture(ui_style.texture_modern_check_button_border);
					check:GetNormalTexture():SetVertexColor(unpack(ui_style.modernCheckButtonColorNormal));
					check:SetPushedTexture(ui_style.texture_modern_check_button_center);
					check:GetPushedTexture():SetVertexColor(unpack(ui_style.modernCheckButtonColorPushed));
					check:SetHighlightTexture(ui_style.texture_modern_check_button_border);
					check:GetHighlightTexture():SetVertexColor(unpack(ui_style.modernCheckButtonColorHighlight));
					check:SetCheckedTexture(ui_style.texture_modern_check_button_center);
					check:GetCheckedTexture():SetVertexColor(unpack(ui_style.modernCheckButtonColorChecked));
					check:SetDisabledTexture(ui_style.texture_modern_check_button_border);
					check:GetDisabledTexture():SetVertexColor(unpack(ui_style.modernCheckButtonColorDisabled));
					check:GetDisabledTexture():SetDesaturated(false);
					check:SetDisabledCheckedTexture(ui_style.texture_modern_check_button_border);
					check:GetDisabledCheckedTexture():SetVertexColor(unpack(ui_style.modernCheckButtonColorDisabledChecked));
				end
				function NS.ui_BlzCheckButton(check)
					check:SetNormalTexture("Interface\\Buttons\\UI-CheckBox-Up");
					check:GetNormalTexture():SetVertexColor(1.0, 1.0, 1.0, 1.0);
					check:SetPushedTexture("Interface\\Buttons\\UI-CheckBox-Down");
					check:GetPushedTexture():SetVertexColor(1.0, 1.0, 1.0, 1.0);
					check:SetHighlightTexture("Interface\\Buttons\\UI-CheckBox-Highlight");
					check:GetHighlightTexture():SetVertexColor(1.0, 1.0, 1.0, 1.0);
					check:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check");
					check:GetCheckedTexture():SetVertexColor(1.0, 1.0, 1.0, 1.0);
					check:SetDisabledTexture("Interface\\Buttons\\UI-CheckBox-Up");
					check:GetDisabledTexture():SetDesaturated(true);
					check:SetDisabledCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check-Disabled");
					check:GetDisabledCheckedTexture():SetVertexColor(1.0, 1.0, 1.0, 1.0);
				end
				--
					local skillButton_TextureHash = {
						["Interface\\Buttons\\UI-MinusButton-Up"] = ui_style.texture_modern_button_minus,
						["Interface\\Buttons\\UI-PlusButton-Up"] = ui_style.texture_modern_button_plus,
						["Interface\\Buttons\\UI-PlusButton-Hilight"] = ui_style.texture_modern_button_plus,
					};
					local function _SetTexture(self, tex)
						self:_SetTexture(skillButton_TextureHash[tex] or tex);
					end
					local function _SetNormalTexture(self, tex)
						tex = skillButton_TextureHash[tex] or tex;
						self:_SetNormalTexture(tex);
						self:_SetHighlightTexture(tex);
					end
					local function _SetPushedTexture(self, tex)
						self:_SetPushedTexture(skillButton_TextureHash[tex] or tex);
					end
					local function _SetHighlightTexture(self, tex)
						-- self:_SetHighlightTexture(skillButton_TextureHash[tex] or tex);
					end
					local function _SetDisabledTexture(self, tex)
						self:_SetDisabledTexture(skillButton_TextureHash[tex] or tex);
					end
				function NS.ui_ModernSkillButton(button)
					button._SetNormalTexture = button._SetNormalTexture or button.SetNormalTexture;
					button.SetNormalTexture = _SetNormalTexture;
					local NormalTexture = button:GetNormalTexture();
					if NormalTexture then
						NormalTexture._SetTexture = NormalTexture._SetTexture or NormalTexture.SetTexture;
						NormalTexture.SetTexture = _SetTexture;
					end
					--
					button._SetPushedTexture = button._SetPushedTexture or button.SetPushedTexture;
					button.SetPushedTexture = _SetPushedTexture;
					local PushedTexture = button:GetPushedTexture();
					if PushedTexture then
						PushedTexture._SetTexture = PushedTexture._SetTexture or PushedTexture.SetTexture;
						PushedTexture.SetTexture = _SetTexture;
					end
					--
					button._SetHighlightTexture = button._SetHighlightTexture or button.SetHighlightTexture;
					button.SetHighlightTexture = _SetHighlightTexture;
					local HighlightTexture = button:GetHighlightTexture();
					if HighlightTexture then
						HighlightTexture._SetTexture = HighlightTexture._SetTexture or HighlightTexture.SetTexture;
						HighlightTexture.SetTexture = _noop_;
					end
					--
					button._SetDisabledTexture = button._SetDisabledTexture or button.SetDisabledTexture;
					button.SetDisabledTexture = _SetDisabledTexture;
					local DisabledTexture = button:GetDisabledTexture();
					if DisabledTexture then
						DisabledTexture._SetTexture = DisabledTexture._SetTexture or DisabledTexture.SetTexture;
						DisabledTexture.SetTexture = _SetTexture;
					end
					button:SetPushedTextOffset(0.0, 0.0);
				end
				function NS.ui_BlzSkillButton(button)
					if button._SetNormalTexture then
						button.SetNormalTexture = button._SetNormalTexture;
					end
					local NormalTexture = button:GetNormalTexture();
					if NormalTexture and NormalTexture._SetTexture then
						NormalTexture.SetTexture = NormalTexture._SetTexture;
					end
					if button._SetPushedTexture then
						button.SetPushedTexture = button._SetPushedTexture;
					end
					local PushedTexture = button:GetPushedTexture();
					if PushedTexture and PushedTexture._SetTexture then
						PushedTexture.SetTexture = PushedTexture._SetTexture;
					end
					if button._SetHighlightTexture then
						button.SetHighlightTexture = button._SetHighlightTexture;
					end
					local HighlightTexture = button:GetHighlightTexture();
					if HighlightTexture and HighlightTexture._SetTexture then
						HighlightTexture.SetTexture = HighlightTexture._SetTexture;
					end
					if button._SetDisabledTexture then
						button.SetDisabledTexture = button._SetDisabledTexture;
					end
					local DisabledTexture = button:GetDisabledTexture();
					if DisabledTexture and DisabledTexture._SetTexture then
						DisabledTexture.SetTexture = DisabledTexture._SetTexture;
					end
					button:SetPushedTextOffset(1.55, -1.55);
				end
				--
				function NS.ui_ModernALADropButton(drop)
					drop:SetNormalTexture(ui_style.texture_modern_arrow_down);
					drop:GetNormalTexture():SetTexCoord(0.0, 1.0, 0.0, 1.0);
					drop:GetNormalTexture():SetVertexColor(unpack(ui_style.textureButtonColorNormal));
					drop:SetPushedTexture(ui_style.texture_modern_arrow_down);
					drop:GetPushedTexture():SetTexCoord(0.0, 1.0, 0.0, 1.0);
					drop:GetPushedTexture():SetVertexColor(unpack(ui_style.textureButtonColorPushed));
					drop:SetHighlightTexture(ui_style.texture_modern_arrow_down);
					drop:GetHighlightTexture():SetTexCoord(0.0, 1.0, 0.0, 1.0);
					drop:GetHighlightTexture():SetVertexColor(unpack(ui_style.textureButtonColorHighlight));
					drop:SetDisabledTexture(ui_style.texture_modern_arrow_down);
					drop:GetDisabledTexture():SetTexCoord(0.0, 1.0, 0.0, 1.0);
					drop:GetDisabledTexture():SetVertexColor(unpack(ui_style.textureButtonColorDisabled));
				end
				function NS.ui_BlzALADropButton(drop)
					drop:SetNormalTexture("interface\\mainmenubar\\ui-mainmenu-scrolldownbutton-up");
					drop:GetNormalTexture():SetTexCoord(6 / 32, 26 / 32, 6 / 32, 26 / 32);
					drop:GetNormalTexture():SetVertexColor(1.0, 1.0, 1.0, 1.0);
					drop:SetPushedTexture("interface\\mainmenubar\\ui-mainmenu-scrolldownbutton-up");
					drop:GetPushedTexture():SetTexCoord(6 / 32, 26 / 32, 6 / 32, 26 / 32);
					drop:GetPushedTexture():SetVertexColor(unpack(ui_style.textureButtonColorPushed));
					drop:SetHighlightTexture("interface\\mainmenubar\\ui-mainmenu-scrolldownbutton-up");
					drop:GetHighlightTexture():SetTexCoord(6 / 32, 26 / 32, 6 / 32, 26 / 32);
					drop:GetHighlightTexture():SetVertexColor(unpack(ui_style.textureButtonColorHighlight));
					drop:SetDisabledTexture("interface\\mainmenubar\\ui-mainmenu-scrolldownbutton-up");
					drop:GetDisabledTexture():SetTexCoord(6 / 32, 26 / 32, 6 / 32, 26 / 32);
					drop:GetDisabledTexture():SetVertexColor(unpack(ui_style.textureButtonColorDisabled));
				end
			--	list button handler
				local function query_who_can_craft_it(_, frame, pid, sid)
					NS.cmm_Query_sid(sid);
				end
				local function add_to_fav(_, frame, pid, sid)
					SET[pid].update = true;
					FAV[sid] = 1;
					frame.update_func();
				end
				local function sub_to_fav(_, frame, pid, sid)
					SET[pid].update = true;
					FAV[sid] = nil;
					frame.update_func();
				end
				local list_drop_add_fav = {
					handler = add_to_fav,
					text = L["add_fav"],
					para = {  },
				};
				local list_drop_sub_fav = {
					handler = sub_to_fav,
					text = L["sub_fav"],
					para = {  },
				};
				local list_drop_query_who_can_craft_it = {
					handler = query_who_can_craft_it,
					text = L["query_who_can_craft_it"],
					para = {  },
				};
				local list_drop_meta = {
					handler = _noop_,
					elements = {
						-- [2] =list_drop_query_who_can_craft_it,
					},
				};
				if select(2, BNGetInfo()) == 'alex#516722' or select(2, BNGetInfo()) == '单酒窝#51637' then
					list_drop_meta.elements[2] =list_drop_query_who_can_craft_it;
				end
			--
			function NS.ui_skillListButton_OnEnter(self)
				local frame = self.frame;
				local sid = self.list[self:GetDataIndex()];
				if type(sid) == 'table' then
					sid = sid[1];
				end
				local pid = self.flag or NS.db_get_pid_by_sid(sid);
				if pid then
					local set = SET[pid];
					mouse_focus_sid = sid;
					mouse_focus_phase = set.phase;
					GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
					local info = NS.db_get_info_by_sid(sid);
					if info then
						if set.showItemInsteadOfSpell and info[index_cid] then
							GameTooltip:SetItemByID(info[index_cid]);
						else
							GameTooltip:SetSpellByID(sid);
						end
						local phase = info[index_phase];
						if phase > curPhase then
							GameTooltip:AddLine("\124cffff0000" .. L["available_in_phase_"] .. phase .. "\124r");
						end
						GameTooltip:Show();
					else
						GameTooltip:SetSpellByID(sid);
					end
					local text = NS.db_get_difficulty_rank_list_text_by_sid(sid);
					if text then
						GameTooltip:AddDoubleLine(L["LABEL_RANK_LEVEL"], text);
						GameTooltip:Show();
					end
					local data = frame.hash[sid];
					if pid == 'explorer' then
						local hash = explorer_hash[sid];
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
									name = format("\124cff%.2x%.2x%.2x", classColorTable.r * 255, classColorTable.g * 255, classColorTable.b * 255) .. name .. "\124r";
									str = str .. " " .. name;
								else
									str = str .. " " .. GUID;
								end
								index = index + 1;
							end
							GameTooltip:AddLine(str);
							GameTooltip:Show();
						else
						end
						data = data and data[PLAYER_GUID];
					end
					if not data then
						NS.ui_set_tooltip_mtsl(sid);
					end
				end
			end
			function NS.ui_skillListButton_OnLeave(self)
				mouse_focus_sid = nil;
				button_info_OnLeave(self);
			end
			function NS.ui_listButton_OnClick(self, button)
				local frame = self.frame;
				local sid = self.list[self:GetDataIndex()];
				if type(sid) == 'table' then
					sid = sid[1];
				end
				local data = frame.hash[sid];
				if button == "LeftButton" then
					if IsShiftKeyDown() then
						local cid = NS.db_get_cid_by_sid(sid);
						if cid then
							ChatEdit_InsertLink(NS.db_item_link(cid), ADDON);
						else
							ChatEdit_InsertLink(NS.enchant_link(sid), ADDON);
						end
					elseif IsAltKeyDown() then
						local text1 = nil;
						local text2 = nil;
						if data then
							local n = frame.reagent_num(data);
							if n and n > 0 then
								local m1, m2 = frame.recipe_num_made(data);
								if m1 == m2 then
									text1 = frame.recipe_link(data) .. "x" .. m1 .. L["PRINT_MATERIALS: "];
								else
									text1 = frame.recipe_link(data) .. "x" .. m1 .. "-" .. m2 .. L["PRINT_MATERIALS: "];
								end
								text2 = "";
								if n > 4 then
									for i = 1, n do
										text2 = text2 .. frame.reagent_info(data, i) .. "x" .. select(3, frame.reagent_info(data, i));
									end
								else
									for i = 1, n do
										text2 = text2 .. frame.reagent_link(data, i) .. "x" .. select(3, frame.reagent_info(data, i));
									end
								end
							end
						else
							local info = NS.db_get_info_by_sid(sid);
							local cid = info[index_cid];
							if info then
								if cid then
									text1 = NS.db_item_link_s(cid) .. "x" .. (info[index_num_made_min] == info[index_num_made_max] and info[index_num_made_min] or (info[index_num_made_min] .. "-" .. info[index_num_made_max])) .. L["PRINT_MATERIALS: "];
								else
									text1 = NS.db_spell_name_s(sid) .. L["PRINT_MATERIALS: "];
								end
								text2 = "";
								local rinfo = info[index_reagents_id];
								if #rinfo > 4 then
									for i = 1, #rinfo do
										text2 = text2 .. NS.db_item_name_s(rinfo[i]) .. "x" .. info[index_reagents_count][i];
									end
								else
									for i = 1, #rinfo do
										text2 = text2 .. NS.db_item_link_s(rinfo[i]) .. "x" .. info[index_reagents_count][i];
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
						local cid = NS.db_get_cid_by_sid(sid);
						if cid then
							local link = NS.db_item_link(cid);
							if link then
								DressUpItemLink(link);
							end
						end
					else
						if data and type(data) == 'number' then
							frame.select_func(data);
							frame.hooked_frame.numAvailable = select(3, frame.recipe_info(data));
							frame.selected_sid = sid;
							frame.update_func();
							frame.searchEdit:ClearFocus();
							local scroll = frame.hooked_scrollBar;
							local num = frame.recipe_num();
							local minVal, maxVal = scroll:GetMinMaxValues();
							local step = scroll:GetValueStep();
							local cur = scroll:GetValue() + step;
							local value = step * (data - 1);
							if value < cur or value > (cur + num * step - maxVal) then
								scroll:SetValue(min(maxVal, value));
							end
							frame.scroll:Update();
							if frame.profitFrame:IsShown() then
								frame.profitScroll:Update();
							end
						end
					end
				elseif button == "RightButton" then
					frame.searchEdit:ClearFocus();
					local pid = NS.db_get_pid_by_sid(sid);
					if FAV[sid] then
						list_drop_sub_fav.para[1] = frame;
						list_drop_sub_fav.para[2] = pid;
						list_drop_sub_fav.para[3] = sid;
						list_drop_meta.elements[1] = list_drop_sub_fav;
					else
						list_drop_add_fav.para[1] = frame;
						list_drop_add_fav.para[2] = pid;
						list_drop_add_fav.para[3] = sid;
						list_drop_meta.elements[1] = list_drop_add_fav;
					end
					list_drop_query_who_can_craft_it.para[1] = frame;
					list_drop_query_who_can_craft_it.para[2] = pid;
					list_drop_query_who_can_craft_it.para[3] = sid;
					ALADROP(self, "BOTTOMLEFT", list_drop_meta);
				end
			end
			function NS.ui_CreateProfitSkillListButton(parent, index, buttonHeight)
				local button = CreateFrame("BUTTON", nil, parent);
				button:SetHeight(buttonHeight);
				button:SetBackdrop(ui_style.listButtonBackdrop);
				button:SetBackdropColor(unpack(ui_style.listButtonBackdropColor_Enabled));
				button:SetBackdropBorderColor(unpack(ui_style.listButtonBackdropBorderColor));
				button:SetHighlightTexture(ui_style.texture_white);
				button:GetHighlightTexture():SetVertexColor(unpack(ui_style.listButtonHighlightColor));
				button:EnableMouse(true);
				button:Show();

				local icon = button:CreateTexture(nil, "BORDER");
				icon:SetTexture(ui_style.texture_unk);
				icon:SetSize(buttonHeight - 4, buttonHeight - 4);
				icon:SetPoint("LEFT", 8, 0);
				button.icon = icon;

				local title = button:CreateFontString(nil, "OVERLAY");
				title:SetFont(ui_style.frameFont, ui_style.frameFontSize, ui_style.frameFontOutline);
				title:SetPoint("LEFT", icon, "RIGHT", 4, 0);
				-- title:SetWidth(160);
				title:SetMaxLines(1);
				title:SetJustifyH("LEFT");
				button.title = title;

				local note = button:CreateFontString(nil, "ARTWORK");
				note:SetFont(ui_style.frameFont, ui_style.frameFontSize, ui_style.frameFontOutline);
				note:SetPoint("RIGHT", -4, 0);
				button.note = note;

				title:SetPoint("RIGHT", note, "LEFT", - 4, 0);

				local quality_glow = button:CreateTexture(nil, "ARTWORK");
				quality_glow:SetTexture("Interface\\Buttons\\UI-ActionButton-Border");
				quality_glow:SetBlendMode("ADD");
				quality_glow:SetTexCoord(0.25, 0.75, 0.25, 0.75);
				quality_glow:SetSize(buttonHeight - 2, buttonHeight - 2);
				quality_glow:SetPoint("CENTER", icon);
				-- quality_glow:SetAlpha(0.75);
				quality_glow:Show();
				button.quality_glow = quality_glow;

				local star = button:CreateTexture(nil, "OVERLAY");
				star:SetTexture("interface\\collections\\collections");
				star:SetTexCoord(100 / 512, 118 / 512, 10 / 512, 28 / 512);
				star:SetSize(buttonHeight * 0.75, buttonHeight * 0.75);
				star:SetPoint("CENTER", button, "TOPLEFT", buttonHeight * 0.25, - buttonHeight * 0.25);
				star:Hide();
				button.star = star;

				local glow = button:CreateTexture(nil, "OVERLAY");
				glow:SetTexture(ui_style.texture_white);
				-- glow:SetTexCoord(0.25, 0.75, 0.25, 0.75);
				glow:SetVertexColor(unpack(ui_style.listButtonSelectedColor));
				glow:SetAllPoints();
				glow:SetBlendMode("ADD");
				glow:Hide();
				button.glow = glow;

				button:SetScript("OnEnter", NS.ui_skillListButton_OnEnter);
				button:SetScript("OnLeave", NS.ui_skillListButton_OnLeave);
				button:RegisterForClicks("AnyUp");
				button:SetScript("OnClick", NS.ui_listButton_OnClick);
				button:RegisterForDrag("LeftButton");
				button:SetScript("OnHide", ALADROP);

				function button:Select()
					glow:Show();
				end
				function button:Deselect()
					glow:Hide();
				end

				local frame = parent:GetParent():GetParent();
				button.frame = frame:GetParent();
				button.list = frame.list;
				button.flag = frame.flag;

				return button;
			end
			function NS.ui_SetProfitSkillListButton(button, data_index)
				local frame = button.frame;
				local list = button.list;
				local hash = frame.hash;
				if data_index <= #list then
					local sid = list[data_index][1];
					local cid = NS.db_get_cid_by_sid(sid);
					local data = hash[sid];
					if data then
						if frame.flag == 'explorer' then
							button:Show();
							local _, quality, icon;
							if cid then
								_, _, quality, _, icon = NS.db_item_info(cid);
							else
								quality = nil;
								icon = ICON_FOR_NO_CID;
							end
							button:SetBackdropColor(unpack(ui_style.listButtonBackdropColor_Enabled));
							button.icon:SetTexture(icon);
							button.icon:SetVertexColor(1.0, 1.0, 1.0, 1.0);
							button.title:SetText(NS.db_spell_name_s(sid));
							button.title:SetTextColor(0.0, 1.0, 0.0, 1.0);
							button.note:SetText(merc.MoneyString(list[data_index][2]));
							if quality then
								local r, g, b, code = GetItemQualityColor(quality);
								button.quality_glow:SetVertexColor(r, g, b);
								button.quality_glow:Show();
							else
								button.quality_glow:Hide();
							end
							if FAV[sid] then
								button.star:Show();
							else
								button.star:Hide();
							end
							button:Deselect();
						else
							local name, rank, num = frame.recipe_info(data);
							if name and rank ~= 'header' then
								button:Show();
								button:SetBackdropColor(unpack(ui_style.listButtonBackdropColor_Enabled));
								local _, quality, icon;
								if cid then
									_, _, quality, _, icon = NS.db_item_info(cid);
								else
									quality = nil;
									icon = ICON_FOR_NO_CID;
								end
								button.icon:SetTexture(frame.recipe_icon(data));
								button.icon:SetVertexColor(1.0, 1.0, 1.0, 1.0);
								if num > 0 then
									button.title:SetText(name .. " [" .. num .. "]");
								else
									button.title:SetText(name);
								end
								button.title:SetTextColor(unpack(rank_color[rank_index[rank]] or ui_style.color_white));
								button.note:SetText(merc.MoneyString(list[data_index][2]));
								if quality then
									local r, g, b, code = GetItemQualityColor(quality);
									button.quality_glow:SetVertexColor(r, g, b);
									button.quality_glow:Show();
								else
									button.quality_glow:Hide();
								end
								if FAV[sid] then
									button.star:Show();
								else
									button.star:Hide();
								end
								if GetMouseFocus() == button then
									NS.ui_skillListButton_OnEnter(button);
								end
								if sid == frame.selected_sid then
									button:Select();
								else
									button:Deselect();
								end
							else
								button:Hide();
							end
						end
					else
						button:Show();
						if SET.colored_rank_for_unknown and frame.flag ~= 'explorer' then
							button:SetBackdropColor(unpack(ui_style.listButtonBackdropColor_Disabled));
						else
							button:SetBackdropColor(unpack(ui_style.listButtonBackdropColor_Enabled));
						end
						local _, quality, icon;
						if cid then
							_, _, quality, _, icon = NS.db_item_info(cid);
						else
							quality = nil;
							icon = ICON_FOR_NO_CID;
						end
						button.icon:SetTexture(icon);
						button.icon:SetVertexColor(1.0, 0.0, 0.0, 1.0);
						button.title:SetText(NS.db_spell_name_s(sid));
						if SET.colored_rank_for_unknown and frame.flag ~= 'explorer' then
							local pid = NS.db_get_pid_by_sid(sid);
							local var = rawget(VAR, pid);
							local cur_rank = var and var.cur_rank or 0;
							button.title:SetTextColor(unpack(rank_color[NS.db_get_difficulty_rank_by_sid(sid, cur_rank)] or ui_style.color_white));
						else
							button.title:SetTextColor(1.0, 0.0, 0.0, 1.0);
						end
						button.note:SetText(merc.MoneyString(list[data_index][2]));
						if quality then
							local r, g, b, code = GetItemQualityColor(quality);
							button.quality_glow:SetVertexColor(r, g, b);
							button.quality_glow:Show();
						else
							button.quality_glow:Hide();
						end
						if FAV[sid] then
							button.star:Show();
						else
							button.star:Hide();
						end
						button:Deselect();
					end
					if GetMouseFocus() == button then
						NS.ui_skillListButton_OnEnter(button);
					end
					if button.prev_sid ~= sid then
						ALADROP(button);
						button.prev_sid = sid;
					end
				else
					ALADROP(button);
					button:Hide();
				end
			end
			function NS.ui_CreateSkillListButton(parent, index, buttonHeight)
				local button = CreateFrame("BUTTON", nil, parent);
				button:SetHeight(buttonHeight);
				button:SetBackdrop(ui_style.listButtonBackdrop);
				button:SetBackdropColor(unpack(ui_style.listButtonBackdropColor_Enabled));
				button:SetBackdropBorderColor(unpack(ui_style.listButtonBackdropBorderColor));
				button:SetHighlightTexture(ui_style.texture_white);
				button:GetHighlightTexture():SetVertexColor(unpack(ui_style.listButtonHighlightColor));
				button:EnableMouse(true);
				button:Show();

				local icon = button:CreateTexture(nil, "BORDER");
				icon:SetTexture(ui_style.texture_unk);
				icon:SetSize(buttonHeight - 4, buttonHeight - 4);
				icon:SetPoint("LEFT", 8, 0);
				button.icon = icon;

				local title = button:CreateFontString(nil, "OVERLAY");
				title:SetFont(ui_style.frameFont, ui_style.frameFontSize, ui_style.frameFontOutline);
				title:SetPoint("LEFT", icon, "RIGHT", 4, 0);
				-- title:SetWidth(160);
				title:SetMaxLines(1);
				title:SetJustifyH("LEFT");
				button.title = title;

				local note = button:CreateFontString(nil, "ARTWORK");
				note:SetFont(ui_style.frameFont, ui_style.frameFontSize - 1, ui_style.frameFontOutline);
				note:SetPoint("RIGHT", -4, 0);
				button.note = note;

				title:SetPoint("RIGHT", note, "LEFT", - 4, 0);

				local quality_glow = button:CreateTexture(nil, "ARTWORK");
				quality_glow:SetTexture("Interface\\Buttons\\UI-ActionButton-Border");
				quality_glow:SetBlendMode("ADD");
				quality_glow:SetTexCoord(0.25, 0.75, 0.25, 0.75);
				quality_glow:SetSize(buttonHeight - 2, buttonHeight - 2);
				quality_glow:SetPoint("CENTER", icon);
				-- quality_glow:SetAlpha(0.75);
				quality_glow:Show();
				button.quality_glow = quality_glow;

				local star = button:CreateTexture(nil, "OVERLAY");
				star:SetTexture("interface\\collections\\collections");
				star:SetTexCoord(100 / 512, 118 / 512, 10 / 512, 28 / 512);
				star:SetSize(buttonHeight * 0.75, buttonHeight * 0.75);
				star:SetPoint("CENTER", button, "TOPLEFT", buttonHeight * 0.25, - buttonHeight * 0.25);
				star:Hide();
				button.star = star;

				local glow = button:CreateTexture(nil, "OVERLAY");
				glow:SetTexture(ui_style.texture_white);
				-- glow:SetTexCoord(0.25, 0.75, 0.25, 0.75);
				glow:SetVertexColor(unpack(ui_style.listButtonSelectedColor));
				glow:SetAllPoints();
				glow:SetBlendMode("ADD");
				glow:Hide();
				button.glow = glow;

				button:SetScript("OnEnter", NS.ui_skillListButton_OnEnter);
				button:SetScript("OnLeave", NS.ui_skillListButton_OnLeave);
				button:RegisterForClicks("AnyUp");
				button:SetScript("OnClick", NS.ui_listButton_OnClick);
				button:RegisterForDrag("LeftButton");
				button:SetScript("OnHide", ALADROP);

				function button:Select()
					glow:Show();
				end
				function button:Deselect()
					glow:Hide();
				end

				local frame = parent:GetParent():GetParent();
				button.frame = frame;
				button.list = frame.list;
				button.flag = frame.flag;

				return button;
			end
			function NS.ui_SetSkillListButton(button, data_index)
				local frame = button.frame;
				local list = button.list;
				local hash = frame.hash;
				if data_index <= #list then
					local sid = list[data_index];
					local pid = frame.flag or NS.db_get_pid_by_sid(sid);
					local set = SET[pid];
					local cid = NS.db_get_cid_by_sid(sid);
					local data = hash[sid];
					if data then
						local name, rank, num = frame.recipe_info(data);
						if name and rank ~= 'header' then
							button:Show();
							button:SetBackdropColor(unpack(ui_style.listButtonBackdropColor_Enabled));
							local quality = cid and NS.db_item_rarity(cid);
							button.icon:SetTexture(frame.recipe_icon(data));
							button.icon:SetVertexColor(1.0, 1.0, 1.0, 1.0);
							if num > 0 then
								button.title:SetText(name .. " [" .. num .. "]");
							else
								button.title:SetText(name);
							end
							button.title:SetTextColor(unpack(rank_color[rank_index[rank]] or ui_style.color_white));
							if set.showRank then
								button.note:SetText(NS.db_get_difficulty_rank_list_text_by_sid(sid));
							else
								button.note:SetText("");
							end
							if quality then
								local r, g, b, code = GetItemQualityColor(quality);
								button.quality_glow:SetVertexColor(r, g, b);
								button.quality_glow:Show();
							else
								button.quality_glow:Hide();
							end
							if FAV[sid] then
								button.star:Show();
							else
								button.star:Hide();
							end
							if sid == frame.selected_sid then
								button:Select();
							else
								button:Deselect();
							end
						else
							button:Hide();
						end
					else
						button:Show();
						if SET.colored_rank_for_unknown then
							button:SetBackdropColor(unpack(ui_style.listButtonBackdropColor_Disabled));
						else
							button:SetBackdropColor(unpack(ui_style.listButtonBackdropColor_Enabled));
						end
						local _, quality, icon;
						if cid then
							_, _, quality, _, icon = NS.db_item_info(cid);
						else
							quality = nil;
							icon = ICON_FOR_NO_CID;
						end
						button.icon:SetTexture(icon);
						button.icon:SetVertexColor(1.0, 0.0, 0.0, 1.0);
						button.title:SetText(NS.db_spell_name_s(sid));
						if SET.colored_rank_for_unknown then
							local var = rawget(VAR, pid);
							button.title:SetTextColor(unpack(rank_color[NS.db_get_difficulty_rank_by_sid(sid, var and var.cur_rank or 0)] or ui_style.color_white));
						else
							button.title:SetTextColor(1.0, 0.0, 0.0, 1.0);
						end
						if set.showRank then
							button.note:SetText(NS.db_get_difficulty_rank_list_text_by_sid(sid));
						else
							button.note:SetText("");
						end
						if quality then
							local r, g, b, code = GetItemQualityColor(quality);
							button.quality_glow:SetVertexColor(r, g, b);
							button.quality_glow:Show();
						else
							button.quality_glow:Hide();
						end
						if FAV[sid] then
							button.star:Show();
						else
							button.star:Hide();
						end
						button:Deselect();
					end
					if GetMouseFocus() == button then
						NS.ui_skillListButton_OnEnter(button);
					end
					if button.prev_sid ~= sid then
						ALADROP(button);
						button.prev_sid = sid;
					end
				else
					ALADROP(button);
					button:Hide();
				end
			end
			function NS.ui_defaultSkillListButton_OnEnter(self)
				if SET.default_skill_button_tip then
					local frame = self.frame;
					local index = self:GetID();
					local link = frame.recipe_link(index);
					if link then
						GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
						GameTooltip:SetHyperlink(link);
						GameTooltip:Show();
					else
						GameTooltip:Hide();
					end
				end
			end
			function NS.ui_updatePriceInfoInFrame(frame)
				local price_info_in_frame = frame.price_info_in_frame;
				if merc and SET.show_tradeskill_frame_price_info then
					local sid = frame.selected_sid;
					if sid == nil or sid <= 0 then
						price_info_in_frame[1]:SetText(nil);
						price_info_in_frame[2]:SetText(nil);
						price_info_in_frame[3]:SetText(nil);
						return;
					end
					local info = NS.db_get_info_by_sid(sid);
					if info then
						local pid = info[index_pid];
						local nMade = (info[index_num_made_min] + info[index_num_made_max]) / 2;
						local price_a_product, _, price_a_material, unk_in, cid = NS.price_gen_info_by_sid(SET[pid].phase, sid, nMade);
						if price_a_material > 0 then
							price_info_in_frame[2]:SetText(
								L["COST_PRICE"] .. ": " ..
								(unk_in > 0 and (merc.MoneyString(price_a_material) .. " (\124cffff0000" .. unk_in .. L["ITEMS_UNK"] .. "\124r)") or merc.MoneyString(price_a_material))
							);
						else
							price_info_in_frame[2]:SetText(
								L["COST_PRICE"] .. ": " ..
								"\124cffff0000" .. L["PRICE_UNK"] .. "\124r"
							);
						end

						if cid then
							-- local price_a_product = merc.query_ah_price_by_id(cid);
							local price_v_product = NS.db_item_sellPrice(info[index_cid]);
							-- local minMade, maxMade = frame.num_made(index);
							-- local nMade = (minMade + maxMade) / 2;
							-- price_a_product = price_a_product and price_a_product * nMade;
							price_v_product = price_v_product and price_v_product * nMade;
							if price_a_product and price_a_product > 0 then
								price_info_in_frame[1]:SetText(
									L["AH_PRICE"] .. ": " ..
									merc.MoneyString(price_a_product) .. " (" .. L["VENDOR_RPICE"] .. (price_v_product and merc.MoneyString(price_v_product) or L["NEED_UPDATE"]) .. ")"
								);
								if price_a_material > 0 then
									local diff = price_a_product - price_a_material;
									if diff > 0 then
										price_info_in_frame[3]:SetText(L["PRICE_DIFF+"] .. ": " .. merc.MoneyString(diff));
									elseif diff < 0 then
										price_info_in_frame[3]:SetText(L["PRICE_DIFF-"] .. ": " .. merc.MoneyString(-diff));
									else
										price_info_in_frame[3]:SetText(L["PRICE_DIFF0"]);
									end
								else
									price_info_in_frame[3]:SetText(nil);
								end
							else
								local bindType = NS.db_item_bindType(cid);
								if bindType == 1 or bindType == 4 then
									price_info_in_frame[1]:SetText(
										L["AH_PRICE"] .. ": " ..
										L["BOP"] .. " (" .. L["VENDOR_RPICE"] .. (price_v_product and merc.MoneyString(price_v_product) or L["NEED_UPDATE"]) .. ")"
									);
								else
									price_info_in_frame[1]:SetText(
										L["AH_PRICE"] .. ": " ..
										"\124cffff0000" .. L["PRICE_UNK"] .. "\124r (" .. L["VENDOR_RPICE"] .. (price_v_product and merc.MoneyString(price_v_product) or L["NEED_UPDATE"]) .. ")"
									);
								end
								price_info_in_frame[3]:SetText(nil);
							end
						end
					else
						price_info_in_frame[1]:SetText(nil);
						price_info_in_frame[2]:SetText(nil);
						price_info_in_frame[3]:SetText(nil);
					end
				else
					price_info_in_frame[1]:SetText(nil);
					price_info_in_frame[2]:SetText(nil);
					price_info_in_frame[3]:SetText(nil);
				end
			end
			function NS.ui_updateRankInfoInFrame(frame)
				if SET.show_tradeskill_frame_rank_info then
					frame.rank_info_in_frame:SetText(NS.db_get_difficulty_rank_list_text_by_sid(frame.selected_sid));
				else
					frame.rank_info_in_frame:SetText(nil);
				end
			end
			--
			function NS.ui_CreateSearchBox(frame)
				local searchEdit = CreateFrame("EDITBOX", nil, frame);
				searchEdit:SetHeight(16);
				searchEdit:SetFont(ui_style.frameFont, ui_style.frameFontSize, ui_style.frameFontOutline);
				searchEdit:SetAutoFocus(false);
				searchEdit:SetJustifyH("LEFT");
				searchEdit:Show();
				searchEdit:EnableMouse(true);
				searchEdit:ClearFocus();
				searchEdit:SetScript("OnEnterPressed", function(self) self:ClearFocus(); end);
				searchEdit:SetScript("OnEscapePressed", function(self) self:ClearFocus(); end);
				frame.searchEdit = searchEdit;
				local searchEditTexture = searchEdit:CreateTexture(nil, "ARTWORK");
				searchEditTexture:SetPoint("TOPLEFT");
				searchEditTexture:SetPoint("BOTTOMRIGHT");
				searchEditTexture:SetTexture("Interface\\Buttons\\greyscaleramp64");
				searchEditTexture:SetTexCoord(0.0, 0.25, 0.0, 0.25);
				searchEditTexture:SetAlpha(0.75);
				searchEditTexture:SetBlendMode("ADD");
				searchEditTexture:SetVertexColor(0.25, 0.25, 0.25);
				local searchEditNote = searchEdit:CreateFontString(nil, "OVERLAY");
				searchEditNote:SetFont(ui_style.frameFont, ui_style.frameFontSize);
				searchEditNote:SetTextColor(1.0, 1.0, 1.0, 0.5);
				searchEditNote:SetPoint("LEFT", 4, 0);
				searchEditNote:SetText(L["Search"]);
				searchEditNote:Show();
				local searchCancel = CreateFrame("BUTTON", nil, searchEdit);
				searchCancel:SetSize(16, 16);
				searchCancel:SetPoint("RIGHT", searchEdit);
				searchCancel:Hide();
				searchCancel:SetNormalTexture("interface\\petbattles\\deadpeticon")
				searchCancel:SetScript("OnClick", function(self) searchEdit:SetText(""); frame:Search(""); searchEdit:ClearFocus(); end);

				local searchEditOK = CreateFrame("BUTTON", nil, frame);
				searchEditOK:SetSize(32, 16);
				searchEditOK:Disable();
				searchEditOK:SetNormalTexture(ui_style.texture_unk);
				searchEditOK:GetNormalTexture():SetColorTexture(0.25, 0.25, 0.25, 0.5);
				searchEditOK:Disable();
				local searchEditOKText = searchEditOK:CreateFontString(nil, "OVERLAY");
				searchEditOKText:SetFont(ui_style.frameFont, ui_style.frameFontSize);
				searchEditOKText:SetTextColor(1.0, 1.0, 1.0, 0.5);
				searchEditOKText:SetPoint("CENTER");
				searchEditOKText:SetText(L["OK"]);
				searchEditOK:SetFontString(searchEditOKText);
				searchEditOK:SetPushedTextOffset(0, - 1);
				searchEditOK:SetScript("OnClick", function(self) searchEdit:ClearFocus(); end);
				searchEditOK:SetScript("OnEnable", function(self) searchEditOKText:SetTextColor(1.0, 1.0, 1.0, 1.0); end);
				searchEditOK:SetScript("OnDisable", function(self) searchEditOKText:SetTextColor(1.0, 1.0, 1.0, 0.5); end);

				local searchEditNameOnly = CreateFrame("CHECKBUTTON", nil, frame, "OptionsBaseCheckButtonTemplate");
				searchEditNameOnly:SetSize(24, 24);
				searchEditNameOnly:SetHitRectInsets(0, 0, 0, 0);
				searchEditNameOnly:Show();
				searchEditNameOnly:SetChecked(false);
				searchEditNameOnly.info_lines = { L["TIP_SEARCH_NAME_ONLY_INFO"], };
				searchEditNameOnly:SetScript("OnEnter", button_info_OnEnter);
				searchEditNameOnly:SetScript("OnLeave", button_info_OnLeave);
				searchEditNameOnly:SetScript("OnClick", function(self)
					local pid = frame.flag or NS.db_get_pid_by_pname(frame.pname());
					if pid then
						NS.change_set_with_update(SET[pid], "searchNameOnly", self:GetChecked());
					end
					frame.update_func();
				end);
				frame.searchEditNameOnly = searchEditNameOnly;

				function frame:Search(text)
					local pid = self.flag or NS.db_get_pid_by_pname(self.pname());
					if pid then
						if text == "" then
							NS.change_set_with_update(SET[pid], "searchText", nil);
							if not searchEdit:HasFocus() then
								searchEditNote:Show();
							end
							searchCancel:Hide();
						else
							NS.change_set_with_update(SET[pid], "searchText", text);
							searchCancel:Show();
							searchEditNote:Hide();
						end
					end
					frame.update_func();
				end
				function frame:RefreshSearchEdit()
					local pid = self.flag or NS.db_get_pid_by_pname(self.pname());
					if pid then
						local searchText = SET[pid].searchText or "";
						if searchEdit:GetText() ~= searchText then
							searchEdit:SetText(searchText);
						end
						if searchText == "" then
							if not searchEdit:HasFocus() then
								searchEditNote:Show();
							end
							searchCancel:Hide();
						else
							searchCancel:Show();
							searchEditNote:Hide();
						end
					end
				end
				function frame:SearchEditValid()
					searchEditTexture:SetVertexColor(0.25, 0.25, 0.25);
				end
				function frame:SearchEditInvalid()
					searchEditTexture:SetVertexColor(0.25, 0.0, 0.0);
				end
				searchEdit:SetScript("OnTextChanged", function(self, isUserInput)
					if isUserInput then
						frame:Search(self:GetText());
					end
				end);
				searchEdit:SetScript("OnEditFocusGained", function(self)
					searchEditNote:Hide();
					searchEditOK:Enable();
				end);
				searchEdit:SetScript("OnEditFocusLost", function(self)
					if self:GetText() == "" then
						searchEditNote:Show();
					end
					searchEditOK:Disable();
				end);

				return searchEdit, searchEditOK, searchEditNameOnly;
			end
			--
			function NS.ui_hook(meta)
				local hooked_frame = meta.hooked_frame;
				local frame = CreateFrame("FRAME", nil, hooked_frame);

				do	--	frame & hooked_frame
					--	frame
						frame:SetFrameStrata("HIGH");
						frame:EnableMouse(true);
						Mixin(frame, meta);
						function frame.update_func()
							NS.process_update(frame);
						end
						frame:SetScript("OnShow", function(self)
							self:with_ui_obj(NS.ui_hide_permanently);
							self.hooked_scroll:Hide();
							self.clear_filter();
							for name, func in next, self.inoperative_func do
								_G[name] = _noop_;
							end
						end);
						frame:SetScript("OnHide", function(self)
							self:with_ui_obj(NS.ui_unhide_permanently);
							self.hooked_scroll:Show();
							for name, func in next, self.inoperative_func do
								_G[name] = func;
							end
							self.hooked_frame_update_func()
						end);
						if meta.events_update then
							for index = 1, #meta.events_update do
								frame:RegisterEvent(meta.events_update[index]);
							end
							frame:SetScript("OnEvent", function(self, event, _1, ...)
								_EventHandler:frame_update_on_next_tick(self);
							end);
						end
						C_Timer.NewTicker(PERIODIC_UPDATE_PERIOD, frame.update_func);
						frame.list = {  };
						frame.prev_var_update_time = GetTime() - MAXIMUM_VAR_UPDATE_PERIOD;
						hooked_frame.frame = frame;

						local scroll = ALASCR(frame, nil, nil, ui_style.skillListButtonHeight, NS.ui_CreateSkillListButton, NS.ui_SetSkillListButton);
						scroll:SetPoint("BOTTOMLEFT", 4, 0);
						scroll:SetPoint("TOPRIGHT", - 4, - 28);
						NS.ui_ModifyALAScrollFrame(scroll);
						frame.scroll = scroll;

						local call = CreateFrame("BUTTON", nil, hooked_frame, "UIPanelButtonTemplate");
						call:SetSize(70, 18);
						call:SetPoint("RIGHT", meta.normal_anchor_top, "LEFT", - 2, 0);
						call:SetFrameLevel(127);
						call:SetScript("OnClick", function(self)
							local pid = frame.flag or NS.db_get_pid_by_pname(frame.pname());
							if frame:IsShown() then
								frame:Hide();
								call:SetText(L["Open"]);
								if pid then
									SET[pid].shown = false;
								end
							else
								frame:Show();
								call:SetText(L["Close"]);
								if pid then
									SET[pid].shown = true;
								end
								frame.update = true;
								frame.update_func();
							end
						end);
						-- call:SetScript("OnEnter", Info_OnEnter);
						-- call:SetScript("OnLeave", Info_OnLeave);
						frame.call = call;
					--

					hooked_frame:HookScript("OnHide", function(self)
						frame:Hide();
					end);
					--	variable
					for index = 1, #meta.inoperative_name do
						local name = meta.inoperative_name[index];
						meta.inoperative_func[name] = _G[name];
					end
					local LAYOUT = meta.layout;
					for _, layout in next, LAYOUT do
						if layout.anchor then
							for index = 1, #layout.anchor do
								local point = layout.anchor[index];
								if point[2] == nil then
									point[2] = frame;
								end
							end
						end
						if layout.scroll_anchor then
							for index = 1, #layout.scroll_anchor do
								local point = layout.scroll_anchor[index];
								if point[2] == nil then
									point[2] = frame;
								end
							end
						end
						if layout.detail_anchor then
							for index = 1, #layout.detail_anchor do
								local point = layout.detail_anchor[index];
								if point[2] == nil then
									point[2] = frame;
								end
							end
						end
					end
					local hooked_frame_objects = meta.hooked_frame_objects;

					--	hide hooked_frame texture
						hooked_frame:SetHitRectInsets(15, 33, 13, 71);
						local regions = { hooked_frame:GetRegions() };
						for index = 1, #regions do
							local obj = regions[index];
							local name = obj:GetName();
							if obj ~= hooked_frame_objects.portrait and strupper(obj:GetObjectType()) == 'TEXTURE' then
								obj._Show = obj.Show;
								obj.Show = _noop_;
								obj:Hide();
							end
						end
					--	portrait
						hooked_frame_objects.portrait:ClearAllPoints();
						hooked_frame_objects.portrait:SetPoint("TOPLEFT", 7, -4);
						local portraitBorder = hooked_frame:CreateTexture(nil, "ARTWORK");
						portraitBorder:SetSize(70, 70);
						portraitBorder:SetPoint("CENTER", hooked_frame_objects.portrait);
						portraitBorder:SetTexture("Interface\\Tradeskillframe\\CapacitanceUIGeneral");
						portraitBorder:SetTexCoord(65 / 256, 117 / 256, 45 / 128, 97 / 128);
						portraitBorder:Show();
						frame.portraitBorder = portraitBorder;
					--	objects
						local drop_list = hooked_frame_objects.drop;
						if drop_list then
							local InvSlotDropDown = drop_list.InvSlotDropDown;
							if InvSlotDropDown then
								NS.ui_Re_LayoutDropDownMenu(InvSlotDropDown);
								InvSlotDropDown:ClearAllPoints();
								InvSlotDropDown:SetPoint("RIGHT", hooked_frame, "TOPLEFT", 342 / 0.9, -81 / 0.9);
							end
							local SubClassDropDown = drop_list.SubClassDropDown;
							if SubClassDropDown then
								NS.ui_Re_LayoutDropDownMenu(SubClassDropDown);
								SubClassDropDown:ClearAllPoints();
								SubClassDropDown:SetPoint("RIGHT", InvSlotDropDown, "LEFT", -4 / 0.9, 0);
							end
						end
						local button_list = hooked_frame_objects.button;
						do
							button_list.CancelButton:SetSize(72, 18);
							button_list.CreateButton:SetSize(72, 18);
							button_list.CancelButton:ClearAllPoints();
							button_list.CreateButton:ClearAllPoints();
							button_list.CancelButton:SetPoint("TOPRIGHT", -42, -415);
							button_list.CreateButton:SetPoint("RIGHT", button_list.CancelButton, "LEFT", -7, 0);
							button_list.CloseButton:ClearAllPoints();
							button_list.CloseButton:SetPoint("CENTER", hooked_frame, "TOPRIGHT", -51, -24);
							button_list.Call = call;
						end
						local edit_list = hooked_frame_objects.edit;
						if edit_list and edit_list.InputBox then
							local Left = getglobal(edit_list.InputBox:GetName() .. "Left");
							Left:ClearAllPoints();
							Left:SetPoint("LEFT", 0, 0);
							edit_list.InputBox:SetTextInsets(3, 0, 0, 0);
							button_list.CreateAllButton:SetSize(72, 18);
							button_list.IncrementButton:ClearAllPoints();
							edit_list.InputBox:ClearAllPoints();
							button_list.DecrementButton:ClearAllPoints();
							button_list.CreateAllButton:ClearAllPoints();
							button_list.IncrementButton:SetPoint("CENTER", button_list.CreateButton, "LEFT", -16, 0);
							edit_list.InputBox:SetHeight(18);
							edit_list.InputBox:SetPoint("RIGHT", button_list.IncrementButton, "CENTER", -16, 0);
							button_list.DecrementButton:SetPoint("CENTER", edit_list.InputBox, "LEFT", -16, 0);
							button_list.CreateAllButton:SetPoint("RIGHT", button_list.DecrementButton, "LEFT", -7, 0);
						end
						local CollapseAllButton = hooked_frame_objects.CollapseAllButton;
						if CollapseAllButton then
							CollapseAllButton:SetParent(hooked_frame);
							CollapseAllButton:ClearAllPoints();
							CollapseAllButton:SetPoint("BOTTOMLEFT", meta.hooked_scroll, "TOPLEFT", 0, 4);
						end
						local hooked_rank = meta.hooked_rank;
						do
							hooked_rank:ClearAllPoints();
							hooked_rank:SetPoint("TOP", 0, -42);
							local rankName = getglobal(hooked_rank:GetName() .. "SkillName");
							if rankName then rankName:Hide(); end
							local rankRank = getglobal(hooked_rank:GetName() .. "SkillRank");
							if rankRank then
								rankRank:ClearAllPoints();
								rankRank:SetPoint("CENTER");
								rankRank:SetJustifyH("CENTER");
							end
							local rankBorder = getglobal(hooked_rank:GetName() .. "Border");
							if rankBorder then
								rankBorder:ClearAllPoints();
								rankBorder:SetPoint("TOPLEFT", -5, 8);
								rankBorder:SetPoint("BOTTOMRIGHT", 5, -8);
							end
							function hooked_rank:Modern()
								rankBorder:Hide();
								self:SetBackdrop(ui_style.scrollBackdrop);
								self:SetBackdropBorderColor(unpack(ui_style.modernScrollBackdropBorderColor));
							end
							function hooked_rank:Blz()
								rankBorder:Show();
								self:SetBackdrop(nil);
							end
						end
					--	BACKGROUND and DEVIDER
						local background = CreateFrame("FRAME", nil, hooked_frame);
						background:SetPoint("TOPLEFT", 15, -13);
						background:SetPoint("BOTTOMRIGHT", -33, 75);
						background:SetFrameLevel(0);
						frame.BG = background;
						local line1 = background:CreateTexture(nil, "BACKGROUND");
						line1:SetDrawLayer("BACKGROUND", 7);
						line1:SetHorizTile(true);
						line1:SetHeight(4);
						line1:SetPoint("LEFT", 2, 0);
						line1:SetPoint("RIGHT", -2, 0);
						line1:SetPoint("BOTTOM", hooked_frame, "TOP", 0, -38);
						local line2 = background:CreateTexture(nil, "BACKGROUND");
						line2:SetDrawLayer("BACKGROUND", 7);
						line2:SetHorizTile(true);
						line2:SetHeight(4);
						line2:SetPoint("LEFT", 2, 0);
						line2:SetPoint("RIGHT", -2, 0);
						line2:SetPoint("TOP", hooked_frame, "TOP", 0, -61);
						local line3 = background:CreateTexture(nil, "BACKGROUND");
						line3:SetDrawLayer("BACKGROUND", 7);
						line3:SetHorizTile(true);
						line3:SetHeight(4);
						line3:SetPoint("LEFT", 2, 0);
						line3:SetPoint("RIGHT", -2, 0);
						line3:SetPoint("BOTTOM", meta.hooked_detail, "TOP", 0, 2);
						frame.line1 = line1;
						frame.line2 = line2;
						frame.line3 = line3;
					--	skillListButton
						local skillListButtons = {  };
						frame.skillListButtons = skillListButtons;
						for index = 1, getglobal(LAYOUT.skillListButton_num_name) do
							skillListButtons[index] = getglobal(hooked_frame_objects.skillListButton_name .. index);
						end
						for index = getglobal(LAYOUT.skillListButton_num_name) + 1, LAYOUT.expand.scroll_button_num do
							local button = CreateFrame("BUTTON", hooked_frame_objects.skillListButton_name .. index, hooked_frame, hooked_frame_objects.skillListButton_inherits);
							button:SetPoint("TOPLEFT", skillListButtons[index - 1], "BOTTOMLEFT", 0, 0);
							button:Hide();
							skillListButtons[index] = button;
						end
						skillListButtons[1]:ClearAllPoints();
						skillListButtons[1]:SetPoint("TOPLEFT", meta.hooked_scroll);
						for index = 1, #skillListButtons do
							local button = skillListButtons[index];
							button:SetScript("OnEnter", NS.ui_defaultSkillListButton_OnEnter);
							button:SetScript("OnLeave", button_info_OnLeave);
							button:SetID(index);
							button.frame = frame;
							button.scroll = meta.hooked_scroll;
						end
					--	reagentButton & productButton
						local reagentButtons = {  };
						frame.reagentButtons = reagentButtons;
						for index = 1, 8 do
							local button = getglobal(hooked_frame_objects.reagentButton_name .. index);
							reagentButtons[index] = button;
							button:HookScript("OnClick", function(self)
								if IsShiftKeyDown() then
									local editBox = ChatEdit_ChooseBoxForSend();
									if not editBox:HasFocus() then
										local name = frame.reagent_info(frame.get_select(), self:GetID());
										if name and name ~= "" then
											ALA_INSERT_NAME(name);
										end
									end
								end
							end);
							button.frame = frame;
						end
						hooked_frame_objects.productButton:HookScript("OnClick", function(self)
							if IsShiftKeyDown() then
								local editBox = ChatEdit_ChooseBoxForSend();
								if not editBox:HasFocus() then
									local name = frame.recipe_info(frame.get_select());
									if name and name ~= "" then
										ALA_INSERT_NAME(name);
									end
								end
							end
						end);
						hooked_frame_objects.productButton.frame = frame;
					--

					function frame:Expand(expanded)
						local LAYOUT = self.layout;
						local layout = LAYOUT[expanded and 'expand' or 'normal'];
						self:ClearAllPoints();
						for index = 1, #layout.anchor do
							self:SetPoint(unpack(layout.anchor[index]));
						end
						self:SetSize(unpack(layout.size));
						self.hooked_frame:SetSize(unpack(layout.frame_size));
						self.hooked_scroll:ClearAllPoints();
						for index = 1, #layout.scroll_anchor do
							self.hooked_scroll:SetPoint(unpack(layout.scroll_anchor[index]));
						end
						self.hooked_scroll:SetSize(unpack(layout.scroll_size));
						self.hooked_detail:ClearAllPoints();
						for index = 1, #layout.detail_anchor do
							self.hooked_detail:SetPoint(unpack(layout.detail_anchor[index]));
						end
						self.hooked_detail:SetSize(unpack(layout.detail_size));
						self.hooked_detail:UpdateScrollChildRect();
						if expanded then
							self.line3:Hide();
							self.hooked_rank:SetWidth(360);
							SetUIPanelAttribute(self.hooked_frame, 'width', 684);
							setglobal(LAYOUT.skillListButton_num_name, layout.scroll_button_num);
							self.hooked_frame_update_func();
						else
							self.line3:Show();
							self.hooked_rank:SetWidth(240);
							SetUIPanelAttribute(self.hooked_frame, 'width', 353);
							setglobal(LAYOUT.skillListButton_num_name, layout.scroll_button_num);
							for index = layout.scroll_button_num + 1, LAYOUT.expand.scroll_button_num do
								self.skillListButtons[index]:Hide();
							end
						end
					end
					local buttonTextureList = {
						CloseButton = ui_style.texture_modern_button_close,
						IncrementButton = ui_style.texture_modern_arrow_right,
						DecrementButton = ui_style.texture_modern_arrow_left,
					};
					frame.buttonTextureList = buttonTextureList;
					function frame:BlzStyle(blz_style, loading)
						if blz_style then
							NS.ui_BlzScrollFrame(self.scroll);
							NS.ui_BlzCheckButton(self.searchEditNameOnly);
							self.searchEditNameOnly:SetSize(24, 24);
							local setFrame = self.setFrame;
							setFrame:SetWidth(344);
							NS.ui_BlzBackdrop(setFrame);
							local checkBoxes = setFrame.checkBoxes;
							for index = 1, #checkBoxes do
								local check = checkBoxes[index];
								NS.ui_BlzCheckButton(check);
								check:SetSize(24, 24);
							end
							local profitFrame = self.profitFrame;
							NS.ui_BlzBackdrop(profitFrame);
							NS.ui_BlzScrollFrame(profitFrame.scroll);
							NS.ui_BlzCheckButton(profitFrame.costOnly);
							profitFrame.costOnly:SetSize(24, 24);

							self.hooked_frame:SetHitRectInsets(11, 29, 9, 67);
							self.BG:ClearAllPoints();
							self.BG:SetPoint("TOPLEFT", 11, -7);
							self.BG:SetPoint("BOTTOMRIGHT", -29, 67);
							NS.ui_BlzBackdrop(self.BG);
							self.line1:SetTexture("Interface\\Dialogframe\\UI-Dialogbox-Divider", "MIRROR");
							self.line1:SetTexCoord(4 / 256, 188 / 256, 5 / 32, 13 / 32);
							self.line1:SetHeight(4);
							self.line2:SetTexture("Interface\\Dialogframe\\UI-Dialogbox-Divider", "MIRROR");
							self.line2:SetTexCoord(4 / 256, 188 / 256, 5 / 32, 13 / 32);
							self.line2:SetHeight(4);
							self.line3:SetTexture("Interface\\Dialogframe\\UI-Dialogbox-Divider", "MIRROR");
							self.line3:SetTexCoord(4 / 256, 188 / 256, 5 / 32, 13 / 32);
							self.line3:SetHeight(4);

							NS.ui_BlzScrollFrame(self.hooked_scroll);
							NS.ui_BlzScrollFrame(self.hooked_detail);
							self.hooked_rank:Blz();
							self.portraitBorder:Show();
							local hooked_frame_objects = self.hooked_frame_objects;
							local button_list = hooked_frame_objects.button;
							if button_list.IncrementButton then
								button_list.IncrementButton:SetSize(23, 22);
							end
							if button_list.DecrementButton then
								button_list.DecrementButton:SetSize(23, 22);
							end
							button_list.CloseButton:SetSize(32, 32);
							local backup = hooked_frame_objects.backup;
							for _, button in next, button_list do
								local name = button:GetName();
								if name == nil then
									button.name = _;
									name = _;
								end
								NS.ui_BlzButton(button, not loading and backup[name] or nil);
							end
							local drop_list = hooked_frame_objects.drop;
							if drop_list then
								for _, drop in next, drop_list do
									NS.ui_BlzDropDownMenu(drop);
								end
							end
							local edit_list = hooked_frame_objects.edit;
							if edit_list then
								for _, edit in next, edit_list do
									NS.ui_BlzEditBox(edit);
								end
							end
							for index = 1, #self.skillListButtons do
								NS.ui_BlzSkillButton(self.skillListButtons[index]);
							end
							if hooked_frame_objects.CollapseAllButton then
								NS.ui_BlzSkillButton(hooked_frame_objects.CollapseAllButton);
							end
							self.hooked_frame_update_func();
						else
							NS.ui_ModernScrollFrame(self.scroll);
							NS.ui_ModernCheckButton(self.searchEditNameOnly);
							self.searchEditNameOnly:SetSize(14, 14);
							local setFrame = self.setFrame;
							setFrame:SetWidth(332);
							NS.ui_ModernBackdrop(setFrame);
							local checkBoxes = setFrame.checkBoxes;
							for index = 1, #checkBoxes do
								local check = checkBoxes[index];
								NS.ui_ModernCheckButton(check);
								check:SetSize(14, 14);
							end
							local profitFrame = self.profitFrame;
							NS.ui_ModernBackdrop(profitFrame);
							NS.ui_ModernScrollFrame(profitFrame.scroll);
							NS.ui_ModernCheckButton(profitFrame.costOnly);
							profitFrame.costOnly:SetSize(14, 14);

							self.hooked_frame:SetHitRectInsets(17, 35, 11, 73);
							self.BG:ClearAllPoints();
							self.BG:SetPoint("TOPLEFT", 17, -11);
							self.BG:SetPoint("BOTTOMRIGHT", -35, 73);
							NS.ui_ModernBackdrop(self.BG);
							self.line1:SetColorTexture(unpack(ui_style.modernDividerColor));
							self.line1:SetHeight(1);
							self.line2:SetColorTexture(unpack(ui_style.modernDividerColor));
							self.line2:SetHeight(1);
							self.line3:SetColorTexture(unpack(ui_style.modernDividerColor));
							self.line3:SetHeight(1);

							NS.ui_ModernScrollFrame(self.hooked_scroll);
							NS.ui_ModernScrollFrame(self.hooked_detail);
							self.hooked_rank:Modern();
							self.portraitBorder:Hide();
							local hooked_frame_objects = self.hooked_frame_objects;
							local button_list = hooked_frame_objects.button;
							if button_list.IncrementButton then
								button_list.IncrementButton:SetSize(14, 14);
							end
							if button_list.DecrementButton then
								button_list.DecrementButton:SetSize(14, 14);
							end
							button_list.CloseButton:SetSize(16, 16);
							local backup = hooked_frame_objects.backup;
							for _, button in next, button_list do
								local name = button:GetName();
								if name == nil then
									button.name = _;
									name = _;
								end
								if backup[name] == nil then
									local bak = {  };
									backup[name] = bak;
									NS.ui_ModernButton(button, bak, buttonTextureList[_]);
								else
									NS.ui_ModernButton(button, nil, buttonTextureList[_]);
								end
							end
							local drop_list = hooked_frame_objects.drop;
							if drop_list then
								for _, drop in next, drop_list do
									NS.ui_ModernDropDownMenu(drop);
								end
							end
							local edit_list = hooked_frame_objects.edit;
							if edit_list then
								for _, edit in next, edit_list do
									NS.ui_ModernEditBox(edit);
								end
							end
							for index = 1, #self.skillListButtons do
								NS.ui_ModernSkillButton(self.skillListButtons[index]);
							end
							if hooked_frame_objects.CollapseAllButton then
								NS.ui_ModernSkillButton(hooked_frame_objects.CollapseAllButton);
							end
							self.hooked_frame_update_func();
						end
					end
				end

				do	--	switch & tab
					local drop_meta = {
						handler = function(_, frame, name)
							if name == '@explorer' then
								NS.ui_toggleGUI("EXPLORER");
							elseif name == '@config' then
								NS.ui_toggleGUI("CONFIG");
							else
								CastSpellByName(name);
							end
						end,
						elements = {  },
					};
					local switch = CreateFrame("BUTTON", nil, hooked_frame);
					switch:SetSize(42, 42);
					switch:SetPoint("CENTER", meta.hooked_frame_objects.portrait);
					switch:RegisterForClicks("AnyUp");
					switch:SetScript("OnClick", function(self)
						ALADROP(self, "BOTTOM", drop_meta);
					end);
					function switch:Update()
						local elements = drop_meta.elements;
						wipe(elements);
						local pname = frame.pname();
						for pid = NS.db_min_pid(), NS.db_max_pid() do
							if rawget(VAR, pid) and NS.db_is_pid_has_win(pid) then
								local name = NS.db_get_check_name_by_pid(pid);
								if name and name ~= pname then
									local element = { text = name, para = { frame, name, }, };
									tinsert(elements, element);
								end
							end
						end
						tinsert(elements, { text = "explorer", para = { frame, '@explorer', }, });
						tinsert(elements, { text = "config", para = { frame, '@config', }, });
					end
					frame.switch = switch;
					--
					local tabFrame = CreateFrame("FRAME", nil, hooked_frame);
					tabFrame:SetBackdrop(ui_style.frameBackdrop);
					tabFrame:SetBackdropColor(unpack(ui_style.frameBackdropColor));
					tabFrame:SetBackdropBorderColor(unpack(ui_style.frameBackdropBorderColor));
					tabFrame:SetFrameStrata("HIGH");
					tabFrame:SetHeight(ui_style.tabSize + ui_style.tabInterval * 2);
					tabFrame:SetPoint("LEFT", frame);
					tabFrame:SetPoint("BOTTOM", meta.normal_anchor_top, "TOP", 0, -4);
					tabFrame:SetPoint("LEFT", meta.tab_anchor_left, "LEFT", 0, 0);
					tabFrame:Show();
					local tabs = {  };
					function tabFrame:CreateTab(index)
						local tab = CreateFrame("BUTTON", nil, tabFrame);
						tab:SetSize(ui_style.tabSize, ui_style.tabSize);
						tab:SetNormalTexture(ui_style.texture_unk);
						-- tab:GetNormalTexture():SetTexCoord(0.0625, 1.0, 0.0625, 1.0);
						tab:SetPushedTexture(ui_style.texture_unk);
						-- tab:GetPushedTexture():SetTexCoord(0.0, 0.9375, 0.0, 0.9375);
						tab:GetPushedTexture():SetVertexColor(unpack(ui_style.textureButtonColorPushed));
						tab:SetHighlightTexture(ui_style.texture_highlight);
						-- tab:GetHighlightTexture():SetTexCoord(0.25, 0.75, 0.25, 0.75);
						-- tab:GetHighlightTexture():SetBlendMode("BLEND");
						tab:GetHighlightTexture():SetVertexColor(unpack(ui_style.textureButtonColorHighlight));
						tab.frame = frame;
						tab:EnableMouse(true);
						tab:SetScript("OnClick", function(self)
							local pname = self.pname;
							if pname and pname ~= frame.pname() then
								if pname == '@explorer' then
									NS.ui_toggleGUI("EXPLORER");
								elseif pname == '@config' then
									NS.ui_toggleGUI("CONFIG");
								else
									CastSpellByName(pname);
								end
							end
						end);
						tabs[index] = tab;
						if index == 1 then
							tab:SetPoint("LEFT", tabFrame, "LEFT", ui_style.tabInterval, 0);
						else
							tab:SetPoint("LEFT", tabs[index - 1], "RIGHT", ui_style.tabInterval, 0);
						end
						return tab;
					end
					function tabFrame:SetNumTabs(num)
						if #tabs > num then
							for index = num + 1, #tabs do
								tabs[index]:Hide();
							end
						else
							for index = 1, #tabs do
								tabs[index]:Show();
							end
							for index = #tabs + 1, num do
								self:CreateTab(index):Show();
							end
						end
						tabFrame:SetWidth(ui_style.tabSize * num + ui_style.tabInterval * (num + 1));
					end
					function tabFrame:SetTab(index, pname, ptexture)
						local tab = tabs[index] or self:CreateTab(index);
						tab:Show();
						tab.pname = pname;
						tab:SetNormalTexture(ptexture);
						tab:SetHighlightTexture(ptexture);
						tab:SetPushedTexture(ptexture);
					end
					function tabFrame:Update()
						local numSkill = 0;
						for pid = NS.db_min_pid(), NS.db_max_pid() do
							if rawget(VAR, pid) and NS.db_is_pid_has_win(pid) then
								numSkill = numSkill + 1;
								self:SetTab(numSkill, NS.db_get_check_name_by_pid(pid), NS.db_get_texture_by_pid(pid));
							end
						end
						numSkill = numSkill + 1;
						self:SetTab(numSkill, '@explorer', ui_style.texture_explorer);
						numSkill = numSkill + 1;
						self:SetTab(numSkill, '@config', ui_style.texture_config);
						self:SetNumTabs(numSkill);
					end
					frame.tabFrame = tabFrame;
					tabFrame.tabs = tabs;
				end

				do	--	search_box
					local searchEdit, searchEditOK, searchEditNameOnly = NS.ui_CreateSearchBox(frame);
					searchEdit:SetPoint("TOPLEFT", frame, "TOPLEFT", 4, - 6);
					searchEdit:SetPoint("RIGHT", searchEditNameOnly, "LEFT", - 4, 0);
					searchEditNameOnly:SetPoint("RIGHT", searchEditOK, "LEFT", - 4, 0);
					searchEditOK:SetPoint("TOPRIGHT", frame, "TOPRIGHT", - 46, - 6);
				end

				do	--	profit_frame
					local profitFrame = CreateFrame("FRAME", nil, frame);
					profitFrame:SetFrameStrata("HIGH");
					profitFrame:EnableMouse(true);
					profitFrame:Hide();
					profitFrame:SetSize(320, 320);
					profitFrame:SetPoint("TOPLEFT", hooked_frame, "TOPRIGHT", -36, -68);
					profitFrame.list = {  };
					frame.profitFrame = profitFrame;

					local call = CreateFrame("BUTTON", nil, frame);
					call:SetSize(20, 20);
					call:SetNormalTexture("interface\\buttons\\ui-grouploot-coin-up");
					call:SetPushedTexture("interface\\buttons\\ui-grouploot-coin-down");
					call:SetHighlightTexture("interface\\buttons\\ui-grouploot-coin-highlight");
					call:SetPoint("TOPRIGHT", frame, "TOPRIGHT", - 24, -6);
					call:SetScript("OnEnter", button_info_OnEnter);
					call:SetScript("OnLeave", button_info_OnLeave);
					call.info_lines = { L["TIP_PROFIT_FRAME_CALL_INFO"] };
					call:SetScript("OnClick", function(self)
						if merc then
							local pid = frame.flag or NS.db_get_pid_by_pname(frame.pname());
							if profitFrame:IsShown() then
								profitFrame:Hide();
								if pid then
									SET[pid].showProfit = false;
								end
							else
								profitFrame:Show();
								if pid then
									SET[pid].showProfit = true;
								end
							end
						end
					end);
					profitFrame.call = call;
					frame.profitCall = call;

					profitFrame:SetScript("OnShow", function(self)
						if merc then
							NS.process_profit_update(frame);
							call:SetNormalTexture("interface\\buttons\\ui-grouploot-coin-down");
							call:SetPushedTexture("interface\\buttons\\ui-grouploot-coin-up");
						else
							self:Hide();
						end
					end);
					profitFrame:SetScript("OnHide", function()
						call:SetNormalTexture("interface\\buttons\\ui-grouploot-coin-up");
						call:SetPushedTexture("interface\\buttons\\ui-grouploot-coin-down");
					end);

					local scroll = ALASCR(profitFrame, nil, nil, ui_style.skillListButtonHeight, NS.ui_CreateProfitSkillListButton, NS.ui_SetProfitSkillListButton);
					scroll:SetPoint("BOTTOMLEFT", 4, 4);
					scroll:SetPoint("TOPRIGHT", - 4, - 20);
					profitFrame.scroll = scroll;
					frame.profitScroll = scroll;

					local costOnly = CreateFrame("CHECKBUTTON", nil, profitFrame, "OptionsBaseCheckButtonTemplate");
					costOnly:SetSize(24, 24);
					costOnly:SetHitRectInsets(0, 0, 0, 0);
					costOnly:SetPoint("CENTER", profitFrame, "TOPLEFT", 17, -10);
					costOnly:Show();
					local str = profitFrame:CreateFontString(nil, "ARTWORK");
					str:SetFont(ui_style.frameFont, ui_style.frameFontSize, "OUTLINE");
					str:SetPoint("LEFT", costOnly, "CENTER", 10, 0);
					str:SetText(L["costOnly"]);
					costOnly.fontString = str;
					costOnly:SetScript("OnClick", function(self)
						local checked = self:GetChecked();
						local pid = frame.flag or NS.db_get_pid_by_pname(frame.pname());
						if pid then
							SET[pid].costOnly = checked;
							NS.process_profit_update(frame);
						end
					end);
					profitFrame.costOnly = costOnly;

					local close = CreateFrame("BUTTON", nil, profitFrame);
					close:SetSize(16, 16);
					close:SetNormalTexture("interface\\buttons\\ui-stopbutton");
					close:SetPushedTexture("interface\\buttons\\ui-stopbutton");
					close:GetPushedTexture():SetVertexColor(unpack(ui_style.textureButtonColorPushed));
					close:SetHighlightTexture("interface\\buttons\\ui-stopbutton");
					close:GetHighlightTexture():SetVertexColor(unpack(ui_style.textureButtonColorHighlight));
					close:SetPoint("TOPRIGHT", profitFrame, "TOPRIGHT", -4, -2);
					close:SetScript("OnClick", function()
						local pid = frame.flag or NS.db_get_pid_by_pname(frame.pname());
						if pid then
							SET[pid].showProfit = false;
						end
						profitFrame:Hide();
					end);
					profitFrame.close = close;

					NS.ui_ModifyALAScrollFrame(scroll);
				end

				do	--	set_frame
					local setFrame = CreateFrame("FRAME", nil, frame);
					setFrame:SetFrameStrata("HIGH");
					setFrame:SetSize(332, 48);
					setFrame:Hide();
					frame.setFrame = setFrame;

					local call = CreateFrame("BUTTON", nil, frame);
					call:SetSize(16, 16);
					call:SetNormalTexture(ui_style.texture_config);
					call:SetPushedTexture(ui_style.texture_config);
					call:GetPushedTexture():SetVertexColor(unpack(ui_style.textureButtonColorPushed));
					call:SetHighlightTexture(ui_style.texture_config);
					call:GetHighlightTexture():SetVertexColor(unpack(ui_style.textureButtonColorHighlight));
					call:SetPoint("TOPRIGHT", frame, "TOPRIGHT", - 4, - 6);
					call:SetScript("OnClick", function(self)
						local pid = frame.flag or NS.db_get_pid_by_pname(frame.pname());
						if setFrame:IsShown() then
							frame:HideSetFrame();
							if pid then
								SET[pid].showSet = false;
							end
						else
							frame:ShowSetFrame(true);
							if pid then
								SET[pid].showSet = true;
							end
						end
					end);
					setFrame.call = call;
					frame.setCall = call;

					setFrame:SetScript("OnShow", function(self)
						call:GetNormalTexture():SetVertexColor(1.0, 1.0, 1.0, 1.0);
					end);
					setFrame:SetScript("OnHide", function(self)
						call:GetNormalTexture():SetVertexColor(1.0, 1.0, 1.0, 1.0);
					end);

					local checkBoxes = {  };
					local keyTables = { "showUnkown", "showKnown", "showHighRank", "showItemInsteadOfSpell", "showRank", "haveMaterials", };
					for index = 1, #keyTables do
						local key = keyTables[index];
						local check = CreateFrame("CHECKBUTTON", nil, setFrame, "OptionsBaseCheckButtonTemplate");
						check:SetSize(24, 24);
						check:SetHitRectInsets(0, 0, 0, 0);
						check:Show();
						check:SetChecked(false);
						local str = setFrame:CreateFontString(nil, "ARTWORK");
						str:SetFont(ui_style.frameFont, ui_style.frameFontSize, "OUTLINE");
						str:SetText(L[key]);
						check.fontString = str;
						str:SetPoint("LEFT", check, "RIGHT", 0, 0);
						if index % 3 == 1 then
							if index == 1 then
								check:SetPoint("CENTER", setFrame, "TOPLEFT", 16, -12);
							else
								check:SetPoint("CENTER", checkBoxes[index - 3], "CENTER", 0, -24);
							end
						else
							check:SetPoint("CENTER", checkBoxes[index - 1], "CENTER", 102, 0);
						end
						if index == 1 or index == 2 or index == 3 or index == 6 then
							check:SetScript("OnClick", function(self)
								local pid = frame.flag or NS.db_get_pid_by_pname(frame.pname());
								if pid then
									NS.change_set_with_update(SET[pid], key, self:GetChecked());
								end
								frame.update_func();
							end);
						else
							check:SetScript("OnClick", function(self)
								local pid = frame.flag or NS.db_get_pid_by_pname(frame.pname());
								if pid then
									NS.change_set_with_update(SET[pid], key, self:GetChecked());
								end
								frame.scroll:Update();
							end);
						end
						check.key = key;
						check.frame = frame;
						tinsert(checkBoxes, check);
					end
					setFrame.checkBoxes = checkBoxes;

					local phaseSlider = CreateFrame("SLIDER", nil, setFrame, "OptionsSliderTemplate");
					phaseSlider:SetPoint("BOTTOM", setFrame, "TOP", 0, 12);
					phaseSlider:SetPoint("LEFT", 4, 0);
					phaseSlider:SetPoint("RIGHT", -4, 0);
					phaseSlider:SetHeight(20);
					phaseSlider:SetMinMaxValues(1, NS.maxPhase)
					phaseSlider:SetValueStep(1);
					phaseSlider:SetObeyStepOnDrag(true);
					phaseSlider.Text:ClearAllPoints();
					phaseSlider.Text:SetPoint("TOP", phaseSlider, "BOTTOM", 0, 3);
					phaseSlider.Low:ClearAllPoints();
					phaseSlider.Low:SetPoint("TOPLEFT", phaseSlider, "BOTTOMLEFT", 4, 3);
					phaseSlider.High:ClearAllPoints();
					phaseSlider.High:SetPoint("TOPRIGHT", phaseSlider, "BOTTOMRIGHT", -4, 3);
					phaseSlider.Low:SetText("\124cff00ff001\124r");
					phaseSlider.High:SetText("\124cffff0000" .. NS.maxPhase .. "\124r");
					phaseSlider:HookScript("OnValueChanged", function(self, value, userInput)
						if userInput then
							local pid = frame.flag or NS.db_get_pid_by_pname(frame.pname());
							if pid then
								NS.change_set_with_update(SET[pid], "phase", value);
								frame.update_func();
							end
						end
						self.Text:SetText("\124cffffff00" .. L["phase"] .. "\124r " .. value);
					end);
					phaseSlider.frame = frame;
					setFrame.phaseSlider = phaseSlider;

					function frame:ShowSetFrame(show)
						if SET.show_tab then
							setFrame:ClearAllPoints();
							setFrame:SetPoint("LEFT", self.BG);
							-- setFrame:SetPoint("RIGHT", self);
							setFrame:SetPoint("BOTTOM", self.tabFrame, "TOP", 0, 2);
						else
							setFrame:ClearAllPoints();
							setFrame:SetPoint("LEFT", self.BG);
							-- setFrame:SetPoint("RIGHT", self);
							setFrame:SetPoint("BOTTOM", self.BG, "TOP", 0, 2);
						end
						if show then
							setFrame:Show();
						end
					end
					function frame:HideSetFrame()
						setFrame:Hide();
					end
					function frame:RefreshSetFrame()
						local pid = frame.flag or NS.db_get_pid_by_pname(self.pname());
						if pid then
							local set = SET[pid];
							for index = 1, #checkBoxes do
								local check = checkBoxes[index];
								check:SetChecked(set[check.key]);
							end
							phaseSlider:SetValue(set.phase);
						end
					end
				end

				do	--	info_in_frame
					local rank_info_in_frame = frame.hooked_detailChild:CreateFontString(nil, "OVERLAY");
					rank_info_in_frame:SetFont(GameFontNormal:GetFont());
					rank_info_in_frame:SetPoint("TOPLEFT", frame.hooked_detailChild, "TOPLEFT", 5, -50);
					frame.rank_info_in_frame = rank_info_in_frame;

					local price_info_in_frame = {  };
					price_info_in_frame[1] = frame.hooked_detailChild:CreateFontString(nil, "OVERLAY");
					price_info_in_frame[1]:SetFont(GameFontNormal:GetFont());
					price_info_in_frame[1]:SetPoint("TOPLEFT", rank_info_in_frame, "BOTTOMLEFT", 0, -3);
					price_info_in_frame[2] = frame.hooked_detailChild:CreateFontString(nil, "OVERLAY");
					price_info_in_frame[2]:SetFont(GameFontNormal:GetFont());
					price_info_in_frame[2]:SetPoint("TOPLEFT", price_info_in_frame[1], "BOTTOMLEFT", 0, 0);
					price_info_in_frame[3] = frame.hooked_detailChild:CreateFontString(nil, "OVERLAY");
					price_info_in_frame[3]:SetFont(GameFontNormal:GetFont());
					price_info_in_frame[3]:SetPoint("TOPLEFT", price_info_in_frame[2], "BOTTOMLEFT", 0, 0);
					frame.price_info_in_frame = price_info_in_frame;

					frame.info_in_frame_anchor:ClearAllPoints();
					frame.info_in_frame_anchor:SetPoint("TOPLEFT", price_info_in_frame[3], "BOTTOMLEFT", 0, -3);

					local function delayUpdateInfoInFrame()
						frame:updatePriceInfoInFrame();
						frame:updateRankInfoInFrame();
					end
					local prev_sid = nil;
					hooksecurefunc(frame.func_name.select_func, function()
						if not frame:IsShown() then
							local index = frame.get_select();
							if index then
								frame.selected_sid = NS.db_get_sid_by_pid_sname_cid(NS.db_get_pid_by_pname(frame.pname()), frame.recipe_info(index), frame.recipe_itemId(index));
							end
						end
						if prev_sid ~= frame.selected_sid then
							prev_sid = frame.selected_sid;
							price_info_in_frame[1]:SetText(nil);
							price_info_in_frame[2]:SetText(nil);
							price_info_in_frame[3]:SetText(nil);
						end
						C_Timer.After(0.5, delayUpdateInfoInFrame);
					end);
					frame.select_func = _G[frame.func_name.select_func];
					frame.updatePriceInfoInFrame = NS.ui_updatePriceInfoInFrame;
					frame.updateRankInfoInFrame = NS.ui_updateRankInfoInFrame;
				end

				ALA_HOOK_ChatEdit_InsertLink(function(link, addon)
					if frame:IsVisible() and addon ~= ADDON and not (BrowseName and BrowseName:IsVisible()) then
						local name, _, _, _, _, _, _, _, loc = GetItemInfo(link);
						if name and name ~= "" then
							local pid = frame.flag or NS.db_get_pid_by_pname(frame.pname());
							frame.searchEdit:ClearFocus();
							if pid == 10 and loc and loc ~= "" then
								local id = tonumber(select(3, strfind(link, "item:(%d+)")));
								if id ~= 11287 and id ~= 11288 and id ~= 11289 and id ~= 11290 then
									if L.ENCHANT_FILTER[loc] then
										frame:Search(L.ENCHANT_FILTER[loc]);
									else
										frame:Search(L.ENCHANT_FILTER.NONE);
									end
								else
									frame:Search(name);
								end
							else
								frame:Search(name);
							end
							return true;
						end
					end
				end);
				ALA_HOOK_ChatEdit_InsertName(function(name, addon)
					if frame:IsVisible() and addon ~= ADDON and not (BrowseName and BrowseName:IsVisible()) then
						if name and name ~= "" then
							frame.searchEdit:SetText(name);
							frame.searchEdit:ClearFocus();
							frame:Search(name);
							return true;
						end
					end
				end);

				NS.merc_AddFrame(frame);

				return frame;
			end
			function NS.ui_initial_set(frame)
				for key, name in next, frame.func_name do
					frame[key] = _G[key] or frame[key];
				end
				--
				frame.tabFrame:Update();
				frame.switch:Update();
				frame:Expand(SET.expand);
				frame:BlzStyle(SET.blz_style, true);
				if SET.show_call then
					frame.call:Show();
				else
					frame.call:Hide();
				end
				if SET.show_tab then
					frame.tabFrame:Show();
				else
					frame.tabFrame:Hide();
				end
				if SET.portrait_button then
					frame.switch:Show();
				else
					frame.switch:Hide();
				end
				--
				local ticker = nil;
				ticker = C_Timer.NewTicker(0.1, function()
					if frame.hooked_frame_objects.portrait:GetTexture() == nil then
						SetPortraitTexture(frame.hooked_frame_objects.portrait, "player");
					else
						ticker:Cancel();
						ticker = nil;
					end
				end);
			end
		--
		function NS.ui_hook_Blizzard_TradeSkillUI(addon)
			local meta = {
				hooked_frame = TradeSkillFrame,
				hooked_detail = TradeSkillDetailScrollFrame,
				hooked_detailBar = TradeSkillDetailScrollFrameScrollBar,
				hooked_detailChild = TradeSkillDetailScrollChildFrame,
				hooked_scroll = TradeSkillListScrollFrame,
				hooked_scrollBar = TradeSkillListScrollFrameScrollBar,
				hooked_rank = TradeSkillRankFrame,
				with_ui_obj = function(self, func)
					func(TradeSkillCollapseAllButton);
					func(TradeSkillInvSlotDropDown);
					func(TradeSkillSubClassDropDown);
					func(TradeSkillListScrollFrame);
					func(TradeSkillListScrollFrameScrollBar)
					func(TradeSkillHighlightFrame);
					local skillListButtons = self.skillListButtons;
					if skillListButtons then
						for index = 1, #skillListButtons do
							func(skillListButtons[index]);
						end
					end
				end,
				layout = {
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
					skillListButton_num_name = "TRADE_SKILLS_DISPLAYED",
				},
				normal_anchor_top = TradeSkillFrameCloseButton,
				tab_anchor_left = TradeSkillRankFrameBorder,
				info_in_frame_anchor = TradeSkillReagentLabel,
				hooked_frame_objects = {
					backup = {  },
					portrait = TradeSkillFramePortrait,
					skillListButton_name = "TradeSkillSkill",
					skillListButton_inherits = "TradeSkillSkillButtonTemplate",
					productButton = TradeSkillSkillIcon,
					reagentButton_name = "TradeSkillReagent",
					button = {
						CancelButton = TradeSkillCancelButton,
						CreateButton = TradeSkillCreateButton,
						IncrementButton = TradeSkillIncrementButton,
						DecrementButton = TradeSkillDecrementButton,
						CreateAllButton = TradeSkillCreateAllButton,
						CloseButton = TradeSkillFrameCloseButton,
					},
					CollapseAllButton = TradeSkillCollapseAllButton,
					drop = {
						InvSlotDropDown = TradeSkillInvSlotDropDown,
						SubClassDropDown = TradeSkillSubClassDropDown,
					},
					edit = {
						InputBox = TradeSkillInputBox,
					},
				},

				select_func = TradeSkillFrame_SetSelection,		-- SelectTradeSkill
				get_select = GetTradeSkillSelectionIndex,
				-- expand = ExpandTradeSkillSubClass,
				-- collapse = CollapseTradeSkillSubClass,
				clear_filter = function()
					SetTradeSkillSubClassFilter(0, 1, 1);
					UIDropDownMenu_SetSelectedID(TradeSkillSubClassDropDown, 1);
					SetTradeSkillInvSlotFilter(0, 1, 1);
					UIDropDownMenu_SetSelectedID(TradeSkillInvSlotDropDown, 1);
					ExpandTradeSkillSubClass(0);
					if TradeSkillCollapseAllButton then
						TradeSkillCollapseAllButton.collapsed = nil;
					end
				end,
				craft = DoTradeSkill,
				close = CloseTradeSkill,

				pname = GetTradeSkillLine,
				pinfo = GetTradeSkillLine,
					--	skillName, cur_rank, max_rank

				recipe_num = GetNumTradeSkills,
				recipe_info = GetTradeSkillInfo,
					--	skillName, difficult & header, numAvailable, isExpanded = GetTradeSkillInfo(skillIndex)
				recipe_itemId = function(arg1) local link = GetTradeSkillItemLink(arg1); return link and tonumber(select(3, strfind(link, "[a-zA-Z]:(%d+)"))) or 0; end,
				recipe_link = GetTradeSkillItemLink,
				recipe_icon = GetTradeSkillIcon,
				recipe_desc = function() return ""; end,
				recipe_need = GetTradeSkillTools,
				recipe_cool = GetTradeSkillCooldown,
				recipe_num_made = GetTradeSkillNumMade,
					--	num_Made_Min, num_Made_Max

				reagent_num = GetTradeSkillNumReagents,
				reagent_link = GetTradeSkillReagentItemLink,
				reagent_id = function(i, j) return tonumber(select(3, strfind(GetTradeSkillReagentItemLink(i, j), "[a-zA-Z]:(%d+)"))); end,
				reagent_info = GetTradeSkillReagentInfo,
					--	name, texture, numRequired, numHave = GetTradeSkillReagentInfo(tradeSkillRecipeId, reagentId);

				hooked_frame_update_func = TradeSkillFrame_Update,
				events_update = {
					-- "NEW_RECIPE_LEARNED",
					-- "TRADE_SKILL_SHOW",
					"TRADE_SKILL_UPDATE",
				},
				inoperative_func = {  },
				inoperative_name = {
					"CollapseTradeSkillSubClass",
					-- "ExpandTradeSkillSubClass",
					"SetTradeSkillSubClassFilter",
					"SetTradeSkillInvSlotFilter",
				},
				func_name = {
					select_func = "TradeSkillFrame_SetSelection",
					hooked_frame_update_func = "TradeSkillFrame_Update",
				},
			};
			local frame = NS.ui_hook(meta);
			gui[addon] = frame;
			NS.ui_initial_set(frame);
			--
			TradeSkillExpandButtonFrame:Hide();
			--
			NS.ElvUI_Blizzard_TradeSkillUI();
			NS.CloudyTradeSkill_Blizzard_TradeSkillUI();
		end
		function NS.ui_hook_Blizzard_CraftUI(addon)
			local meta = {
				hooked_frame = CraftFrame,
				hooked_detail = CraftDetailScrollFrame,
				hooked_detailBar = CraftDetailScrollFrameScrollBar,
				hooked_detailChild = CraftDetailScrollChildFrame,
				hooked_scroll = CraftListScrollFrame,
				hooked_scrollBar = CraftListScrollFrameScrollBar,
				hooked_rank = CraftRankFrame,
				with_ui_obj = function(self, func)
					func(CraftListScrollFrame);
					func(CraftListScrollFrameScrollBar);
					func(CraftHighlightFrame);
					local skillListButtons = self.skillListButtons;
					if skillListButtons then
						for index = 1, #skillListButtons do
							func(skillListButtons[index]);
						end
					end
				end,
				layout = {
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
					skillListButton_num_name = "CRAFTS_DISPLAYED",
				},
				normal_anchor_top = CraftFrameCloseButton,
				tab_anchor_left = CraftRankFrameBorder,
				info_in_frame_anchor = CraftDescription,
				hooked_frame_objects = {
					backup = {  },
					portrait = CraftFramePortrait,
					skillListButton_name = "Craft",
					skillListButton_inherits = "CraftButtonTemplate",
					productButton = CraftIcon,
					reagentButton_name = "CraftReagent",
					button = {
						CancelButton = CraftCancelButton,
						CreateButton = CraftCreateButton,
						CloseButton = CraftFrameCloseButton,
					},
				},

				select = CraftFrame_SetSelection,		-- SelectCraft
				get_select = GetCraftSelectionIndex,
				-- expand = ExpandCraftSkillLine,
				-- collapse = CollapseCraftSkillLine,
				clear_filter = _noop_,
				-- craft = DoCraft,
				close = CloseCraft,

				pname = GetCraftName,
				pinfo = GetCraftDisplaySkillLine,
					--	skillName, cur_rank, max_rank

				recipe_num = GetNumCrafts,
				recipe_info = function(arg1) local _1, _2, _3, _4, _5, _6, _7 = GetCraftInfo(arg1); return _1, _3, _4, _5, _6, _7; end,
					--	craftName, craftSubSpellName(""), difficult, numAvailable, isExpanded, trainingPointCost, requiredLevel = GetCraftInfo(index)
				recipe_itemId = function(arg1) local link = GetCraftItemLink(arg1); return link and tonumber(select(3, strfind(link, "[a-zA-Z]:(%d+)"))) or 0; end,
				recipe_link = GetCraftItemLink,
				recipe_icon = GetCraftIcon,
				recipe_desc = GetCraftDescription,
				recipe_need = GetCraftSpellFocus,
				recipe_cool = function() return nil; end,
				recipe_num_made = function() return 1, 1; end,

				reagent_num = GetCraftNumReagents,
				reagent_link = GetCraftReagentItemLink,
				reagent_id = function(i, j) return tonumber(select(3, strfind(GetCraftReagentItemLink(i, j), "[a-zA-Z]:(%d+)"))); end,
				reagent_info = GetCraftReagentInfo,
					-- name, texture, numRequired, numHave = GetCraftReagentInfo(tradeSkillRecipeId, reagentId);

				hooked_frame_update_func = CraftFrame_Update,
				events_update = {
					-- "NEW_RECIPE_LEARNED",
					-- "CRAFT_SHOW",
					"CRAFT_UPDATE",
				},
				inoperative_func = {  },
				inoperative_name = {
					"CollapseCraftSkillLine",
					-- "ExpandCraftSkillLine",
				},
				func_name = {
					select_func = "CraftFrame_SetSelection",
					hooked_frame_update_func = "CraftFrame_Update",
				},
			};
			local frame = NS.ui_hook(meta);
			gui[addon] = frame;
			NS.ui_initial_set(frame);
			do	-- auto filter recipe when trading
				local function process_link()
					local link = GetTradeTargetItemLink(7);
					if link then
						local loc = select(9, GetItemInfo(link));
						if loc and L.ENCHANT_FILTER[loc] then
							frame.searchEdit:SetText(L.ENCHANT_FILTER[loc]);
							frame:Search(L.ENCHANT_FILTER[loc]);
						else
							frame.searchEdit:SetText(L.ENCHANT_FILTER.NONE);
							frame:Search(L.ENCHANT_FILTER.NONE);
						end
					end
				end
				function NS.TRADE_CLOSED()
					frame.searchEdit:SetText("");
				end
				function NS.TRADE_TARGET_ITEM_CHANGED(_1)
					if _1 == 7 then
						process_link();
					end
				end
				function NS.TRADE_UPDATE()
					process_link();
				end
				-- _EventHandler:RegEvent("TRADE_SHOW");
				_EventHandler:RegEvent("TRADE_CLOSED");
				_EventHandler:RegEvent("TRADE_UPDATE");
				_EventHandler:RegEvent("TRADE_TARGET_ITEM_CHANGED");
				frame:HookScript("OnShow", function()
					if CraftFrame and CraftFrame:IsShown() then
						_EventHandler:run_on_next_tick(process_link);
					end
				end);
			end
			NS.ElvUI_Blizzard_CraftUI();
			NS.CloudyTradeSkill_Blizzard_CraftUI();
		end
		--
			function NS.ui_CreateExplorerSkillListButton(parent, index, buttonHeight)
				local button = CreateFrame("BUTTON", nil, parent);
				button:SetHeight(buttonHeight);
				button:SetBackdrop(ui_style.listButtonBackdrop);
				button:SetBackdropColor(unpack(ui_style.listButtonBackdropColor_Enabled));
				button:SetBackdropBorderColor(unpack(ui_style.listButtonBackdropBorderColor));
				button:SetHighlightTexture(ui_style.texture_white);
				button:GetHighlightTexture():SetVertexColor(unpack(ui_style.listButtonHighlightColor));
				button:EnableMouse(true);
				button:Show();

				local icon = button:CreateTexture(nil, "BORDER");
				icon:SetTexture(ui_style.texture_unk);
				icon:SetSize(buttonHeight - 4, buttonHeight - 4);
				icon:SetPoint("LEFT", 8, 0);
				button.icon = icon;

				local title = button:CreateFontString(nil, "OVERLAY");
				title:SetFont(ui_style.frameFont, ui_style.frameFontSize, ui_style.frameFontOutline);
				title:SetPoint("LEFT", icon, "RIGHT", 4, 0);
				-- title:SetWidth(160);
				title:SetMaxLines(1);
				title:SetJustifyH("LEFT");
				button.title = title;

				local note = button:CreateFontString(nil, "ARTWORK");
				note:SetFont(ui_style.frameFont, ui_style.frameFontSize, ui_style.frameFontOutline);
				note:SetPoint("RIGHT", -4, 0);
				button.note = note;

				title:SetPoint("RIGHT", note, "LEFT", - 4, 0);

				local quality_glow = button:CreateTexture(nil, "ARTWORK");
				quality_glow:SetTexture("Interface\\Buttons\\UI-ActionButton-Border");
				quality_glow:SetBlendMode("ADD");
				quality_glow:SetTexCoord(0.25, 0.75, 0.25, 0.75);
				quality_glow:SetSize(buttonHeight - 2, buttonHeight - 2);
				quality_glow:SetPoint("CENTER", icon);
				-- quality_glow:SetAlpha(0.75);
				quality_glow:Show();
				button.quality_glow = quality_glow;

				local star = button:CreateTexture(nil, "OVERLAY");
				star:SetTexture("interface\\collections\\collections");
				star:SetTexCoord(100 / 512, 118 / 512, 10 / 512, 28 / 512);
				star:SetSize(buttonHeight * 0.75, buttonHeight * 0.75);
				star:SetPoint("CENTER", button, "TOPLEFT", buttonHeight * 0.25, - buttonHeight * 0.25);
				star:Hide();
				button.star = star;

				local glow = button:CreateTexture(nil, "OVERLAY");
				glow:SetTexture(ui_style.texture_white);
				-- glow:SetTexCoord(0.25, 0.75, 0.25, 0.75);
				glow:SetVertexColor(unpack(ui_style.listButtonSelectedColor));
				glow:SetAllPoints();
				glow:SetBlendMode("ADD");
				glow:Hide();
				button.glow = glow;

				button:SetScript("OnEnter", NS.ui_skillListButton_OnEnter);
				button:SetScript("OnLeave", NS.ui_skillListButton_OnLeave);
				button:RegisterForClicks("AnyUp");
				button:SetScript("OnClick", NS.ui_listButton_OnClick);
				button:RegisterForDrag("LeftButton");
				button:SetScript("OnHide", ALADROP);

				function button:Select()
					glow:Show();
				end
				function button:Deselect()
					glow:Hide();
				end

				local frame = parent:GetParent():GetParent();
				button.frame = frame;
				button.list = frame.list;
				button.flag = frame.flag;

				return button;
			end
			function NS.ui_SetExplorerSkillListButton(button, data_index)
				local frame = button.frame;
				local list = button.list;
				local hash = frame.hash;
				if data_index <= #list then
					local sid = list[data_index];
					local cid = NS.db_get_cid_by_sid(sid);
					button:Show();
					local _, quality, icon;
					if cid then
						_, _, quality, _, icon = NS.db_item_info(cid);
					else
						quality = nil;
						icon = ICON_FOR_NO_CID;
					end
					button.icon:SetTexture(icon);
					button.title:SetText(NS.db_spell_name_s(sid));
					if hash[sid] then
						button.icon:SetVertexColor(1.0, 1.0, 1.0, 1.0);
						button.title:SetTextColor(0.0, 1.0, 0.0, 1.0);
					else
						button.icon:SetVertexColor(1.0, 0.0, 0.0, 1.0);
						button.title:SetTextColor(1.0, 0.0, 0.0, 1.0);
					end
					local set = SET.explorer;
					if set.showRank then
						button.note:SetText(NS.db_get_difficulty_rank_list_text_by_sid(sid));
					else
						button.note:SetText("");
					end
					if quality then
						local r, g, b, code = GetItemQualityColor(quality);
						button.quality_glow:SetVertexColor(r, g, b);
						button.quality_glow:Show();
					else
						button.quality_glow:Hide();
					end
					if FAV[sid] then
						button.star:Show();
					else
						button.star:Hide();
					end
					if GetMouseFocus() == button then
						NS.ui_skillListButton_OnEnter(button);
					end
					button:Deselect();
					if button.prev_sid ~= sid then
						ALADROP(button);
						button.prev_sid = sid;
					end
				else
					ALADROP(button);
					button:Hide();
				end
			end
			--	set button handler
				--	L.TRADESKILL_NAME
				--	L.ITEM_TYPE_LIST
				--	L.ITEM_SUB_TYPE_LIST
				local index_bound = { skill = { BIG_NUMBER, -1, }, type = { BIG_NUMBER, -1, }, subType = {  }, eqLoc = { BIG_NUMBER, -1, }, };
				for index, _ in next, L.TRADESKILL_NAME do
					if index < index_bound.skill[1] then
						index_bound.skill[1] = index;
					end
					if index > index_bound.skill[2] then
						index_bound.skill[2] = index;
					end
				end
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
					index_bound.subType[index1] = { BIG_NUMBER, -1, };
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
				local explorer_set_drop_meta = {
					handler = function(_, frame, key, val)
						SET.explorer.filter[key] = val;
						if key == 'type' then
							SET.explorer.filter.subType = nil;
						end
						frame.update_func();
					end,
					elements = {  },
				};
				local temp_filter = {  };
				local temp_list = {  };
				local temp_stat_list = { skill = {  }, type = {  }, subType = {  }, eqLoc = {  }, };
				function NS.ui_explorerSetDrop_OnClick(self)
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
						wipe(temp_filter);
						Mixin(temp_filter, filter);
						temp_filter[key] = nil;
						if key == 'type' then
							temp_filter.subType = nil;
						end
						NS.process_explorer_update_list(frame, temp_stat_list, temp_filter, set.searchText, set.searchNameOnly,
													temp_list, frame.hash, set.phase, nil, set.rankReversed, set.showKnown, set.showUnkown, set.showHighRank);
						stat_list = temp_stat_list;
					else
						stat_list = explorer_stat_list;
					end
					local elements = explorer_set_drop_meta.elements;
					wipe(elements);
					elements[1] = { text = L["EXPLORER_CLEAR_FILTER"], para = { frame, key, nil, }, };
					local stat = stat_list[key];
					if key == 'skill' then
						for index = bound[1], bound[2] do
							if stat[index] then
								tinsert(elements, { text = L.TRADESKILL_NAME[index], para = { frame, key, index, }, });
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
					ALADROP(self, "BOTTOMRIGHT", explorer_set_drop_meta);
				end
			--
		--
		function NS.ui_CreateExplorer()
			local frame = CreateFrame("FRAME", "ALA_TRADESKILL_EXPLORER", UIParent);
			tinsert(UISpecialFrames, "ALA_TRADESKILL_EXPLORER");

			do
				frame:SetSize(ui_style.explorerWidth, ui_style.explorerHeight);
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
					frame.update_func();
				end);
				frame:Hide();

				function frame.update_func()
					NS.process_explorer_update(frame, true);
				end
				frame.list = {  };
				frame.hash = explorer_hash;
				frame.flag = 'explorer';

				local title = frame:CreateFontString(nil, "ARTWORK");
				title:SetFont(ui_style.frameFont, ui_style.frameFontSize);
				title:SetPoint("TOP", 0, -4);
				title:SetText(L["EXPLORER_TITLE"]);

				local scroll = ALASCR(frame, nil, nil, ui_style.skillListButtonHeight, NS.ui_CreateExplorerSkillListButton, NS.ui_SetExplorerSkillListButton);
				scroll:SetPoint("BOTTOMLEFT", 4, 4);
				scroll:SetPoint("TOPRIGHT", - 4, - 40);
				frame.scroll = scroll;

				local close = CreateFrame("BUTTON", nil, frame);
				close:SetSize(16, 16);
				close:SetNormalTexture("interface\\buttons\\ui-stopbutton");
				close:SetPushedTexture("interface\\buttons\\ui-stopbutton");
				close:GetPushedTexture():SetVertexColor(unpack(ui_style.textureButtonColorPushed));
				close:SetHighlightTexture("interface\\buttons\\ui-stopbutton");
				close:GetHighlightTexture():SetVertexColor(unpack(ui_style.textureButtonColorHighlight));
				close:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -4, -4);
				close:SetScript("OnClick", function()
					frame:Hide();
				end);
				frame.close = close;

				NS.ui_ModifyALAScrollFrame(scroll);

				function frame:BlzStyle(blz_style, loading)
					if blz_style then
						NS.ui_BlzBackdrop(self);
						NS.ui_BlzCheckButton(self.searchEditNameOnly);
						self.searchEditNameOnly:SetSize(24, 24);
						NS.ui_BlzScrollFrame(self.scroll);
						local setFrame = self.setFrame;
						NS.ui_BlzBackdrop(setFrame);
						local checkBoxes = setFrame.checkBoxes;
						for index = 1, #checkBoxes do
							local check = checkBoxes[index];
							NS.ui_BlzCheckButton(check);
							check:SetSize(24, 24);
						end
						local dropDowns = setFrame.dropDowns;
						for index = 1, #dropDowns do
							local drop = dropDowns[index];
							NS.ui_BlzALADropButton(drop);
							drop:SetSize(20, 20);
						end
						NS.ui_BlzBackdrop(self.profitFrame);
						NS.ui_BlzScrollFrame(self.profitFrame.scroll);
						-- NS.ui_BlzButton(button, not loading and backup[name] or nil);
					else
						NS.ui_ModernBackdrop(self);
						NS.ui_ModernCheckButton(self.searchEditNameOnly);
						self.searchEditNameOnly:SetSize(14, 14);
						NS.ui_ModernScrollFrame(self.scroll);
						local setFrame = self.setFrame;
						NS.ui_ModernBackdrop(setFrame);
						local checkBoxes = setFrame.checkBoxes;
						for index = 1, #checkBoxes do
							local check = checkBoxes[index];
							NS.ui_ModernCheckButton(check);
							check:SetSize(14, 14);
						end
						local dropDowns = setFrame.dropDowns;
						for index = 1, #dropDowns do
							local drop = dropDowns[index];
							NS.ui_ModernALADropButton(drop);
							drop:SetSize(14, 14);
						end
						NS.ui_ModernBackdrop(self.profitFrame);
						NS.ui_ModernScrollFrame(self.profitFrame.scroll);
						-- NS.ui_ModernButton(button, bak, self.buttonTextureList[_]);
					end
				end

			end

			do	--	search_box
				local searchEdit, searchEditOK, searchEditNameOnly = NS.ui_CreateSearchBox(frame);
				searchEdit:SetPoint("TOPLEFT", frame, "TOPLEFT", 8, - 24);
				searchEdit:SetPoint("RIGHT", searchEditNameOnly, "LEFT", - 4, 0);
				searchEditNameOnly:SetPoint("RIGHT", searchEditOK, "LEFT", - 4, 0);
				searchEditOK:SetPoint("TOPRIGHT", frame, "TOPRIGHT", - 46, - 24);
			end

			do	--	profit_frame
				local profitFrame = CreateFrame("FRAME", nil, frame);
				profitFrame:SetFrameStrata("HIGH");
				profitFrame:EnableMouse(true);
				profitFrame:Hide();
				profitFrame:SetWidth(320);
				profitFrame:SetPoint("TOPLEFT", frame, "TOPRIGHT", 2, 0);
				profitFrame:SetPoint("BOTTOMLEFT", frame, "BOTTOMRIGHT", 2, 0);
				profitFrame.list = {  };
				profitFrame.flag = 'explorer';
				frame.profitFrame = profitFrame;

				local call = CreateFrame("BUTTON", nil, frame);
				call:SetSize(20, 20);
				call:SetNormalTexture("interface\\buttons\\ui-grouploot-coin-up");
				call:SetPushedTexture("interface\\buttons\\ui-grouploot-coin-down");
				call:SetHighlightTexture("interface\\buttons\\ui-grouploot-coin-highlight");
				call:SetPoint("TOPRIGHT", frame, "TOPRIGHT", - 24, - 24);
				call:SetScript("OnEnter", button_info_OnEnter);
				call:SetScript("OnLeave", button_info_OnLeave);
				call.info_lines = { L["TIP_PROFIT_FRAME_CALL_INFO"] };
				call:SetScript("OnClick", function(self)
					if merc then
						if profitFrame:IsShown() then
							profitFrame:Hide();
							SET.explorer.showProfit = false;
						else
							profitFrame:Show();
							SET.explorer.showProfit = true;
						end
					end
				end);
				profitFrame.call = call;
				frame.profitCall = call;

				profitFrame:SetScript("OnShow", function(self)
					if merc then
						NS.process_profit_update(frame);
						call:SetNormalTexture("interface\\buttons\\ui-grouploot-coin-down");
						call:SetPushedTexture("interface\\buttons\\ui-grouploot-coin-up");
					else
						self:Hide();
					end
				end);
				profitFrame:SetScript("OnHide", function()
					call:SetNormalTexture("interface\\buttons\\ui-grouploot-coin-up");
					call:SetPushedTexture("interface\\buttons\\ui-grouploot-coin-down");
				end);

				local scroll = ALASCR(profitFrame, nil, nil, ui_style.skillListButtonHeight, NS.ui_CreateProfitSkillListButton, NS.ui_SetProfitSkillListButton);
				scroll:SetPoint("BOTTOMLEFT", 4, 4);
				scroll:SetPoint("TOPRIGHT", - 4, - 20);
				profitFrame.scroll = scroll;
				frame.profitScroll = scroll;

				-- local costOnly = CreateFrame("CHECKBUTTON", nil, profitFrame, "OptionsBaseCheckButtonTemplate");
				-- costOnly:SetSize(24, 24);
				-- costOnly:SetHitRectInsets(0, 0, 0, 0);
				-- costOnly:SetPoint("CENTER", profitFrame, "TOPLEFT", 17, -10);
				-- costOnly:Show();
				-- local str = profitFrame:CreateFontString(nil, "ARTWORK");
				-- str:SetFont(ui_style.frameFont, ui_style.frameFontSize, "OUTLINE");
				-- str:SetPoint("LEFT", costOnly, "RIGHT", 2, 0);
				-- str:SetText(L["costOnly"]);
				-- costOnly.fontString = str;
				-- costOnly:SetScript("OnClick", function(self)
				-- 	local checked = self:GetChecked();
				-- 	SET.explorer.costOnly = checked;
				-- 	NS.process_profit_update(frame);
				-- end);
				-- profitFrame.costOnly = costOnly;

				local close = CreateFrame("BUTTON", nil, profitFrame);
				close:SetSize(16, 16);
				close:SetNormalTexture("interface\\buttons\\ui-stopbutton");
				close:SetPushedTexture("interface\\buttons\\ui-stopbutton");
				close:GetPushedTexture():SetVertexColor(unpack(ui_style.textureButtonColorPushed));
				close:SetHighlightTexture("interface\\buttons\\ui-stopbutton");
				close:GetHighlightTexture():SetVertexColor(unpack(ui_style.textureButtonColorHighlight));
				close:SetPoint("TOPRIGHT", profitFrame, "TOPRIGHT", -4, -2);
				close:SetScript("OnClick", function()
					SET.explorer.showProfit = false;
					profitFrame:Hide();
				end);
				profitFrame.close = close;

				NS.ui_ModifyALAScrollFrame(frame.profitFrame.scroll);
			end

			do	--	set_frame
				local setFrame = CreateFrame("FRAME", nil, frame);
				setFrame:SetFrameStrata("HIGH");
				setFrame:SetHeight(64);
				setFrame:SetPoint("LEFT", frame);
				setFrame:SetPoint("RIGHT", frame);
				setFrame:SetPoint("BOTTOM", frame, "TOP", 0, 2);
				setFrame:Hide();
				frame.setFrame = setFrame;

				local call = CreateFrame("BUTTON", nil, frame);
				call:SetSize(16, 16);
				call:SetNormalTexture(ui_style.texture_config);
				call:SetPushedTexture(ui_style.texture_config);
				call:GetPushedTexture():SetVertexColor(unpack(ui_style.textureButtonColorPushed));
				call:SetHighlightTexture(ui_style.texture_config);
				call:GetHighlightTexture():SetVertexColor(unpack(ui_style.textureButtonColorHighlight));
				call:SetPoint("TOPRIGHT", frame, "TOPRIGHT", - 4, - 24);
				call:SetScript("OnClick", function(self)
					if setFrame:IsShown() then
						setFrame:Hide();
						SET.explorer.showSet = false;
						self:GetNormalTexture():SetVertexColor(1.0, 1.0, 1.0, 1.0);
					else
						setFrame:Show();
						SET.explorer.showSet = true;
						self:GetNormalTexture():SetVertexColor(0.75, 0.75, 0.75, 1.0);
					end
				end);
				setFrame.call = call;
				frame.setCall = call;

				setFrame:SetScript("OnShow", function(self)
					call:GetNormalTexture():SetVertexColor(1.0, 1.0, 1.0, 1.0);
				end);
				setFrame:SetScript("OnHide", function(self)
					call:GetNormalTexture():SetVertexColor(1.0, 1.0, 1.0, 1.0);
				end);

				local checkBoxes = {  };
				local keyTables = { "showUnkown", "showKnown", "showItemInsteadOfSpell", "showRank", };
				for index = 1, #keyTables do
					local key = keyTables[index];
					local check = CreateFrame("CHECKBUTTON", nil, setFrame, "OptionsBaseCheckButtonTemplate");
					check:SetSize(24, 24);
					check:SetHitRectInsets(0, 0, 0, 0);
					check:Show();
					check:SetChecked(false);
					local str = setFrame:CreateFontString(nil, "ARTWORK");
					str:SetFont(ui_style.frameFont, ui_style.frameFontSize, "OUTLINE");
					str:SetText(L[key]);
					check.fontString = str;
					str:SetPoint("LEFT", check, "RIGHT", 0, 0);
					if index % 4 == 1 then
						if index == 1 then
							check:SetPoint("CENTER", setFrame, "TOPLEFT", 16, -12);
						else
							check:SetPoint("CENTER", checkBoxes[index - 3], "CENTER", 0, -24);
						end
					else
						check:SetPoint("CENTER", checkBoxes[index - 1], "CENTER", 94, 0);
					end
					if index <= 2 then
						check:SetScript("OnClick", function(self)
							SET.explorer[key] = self:GetChecked()
							frame.update_func();
						end);
					else
						check:SetScript("OnClick", function(self)
							SET.explorer[key] = self:GetChecked()
							frame.scroll:Update();
						end);
					end
					check.key = key;
					tinsert(checkBoxes, check);
				end
				setFrame.checkBoxes = checkBoxes;

				local dropDowns = {  };
				local keyTables = { "skill", "type", "subType", "eqLoc", };
				for index = 1, #keyTables do
					local key = keyTables[index];
					local drop = CreateFrame("BUTTON", nil, setFrame);
					drop:SetSize(20, 20);
					drop:EnableMouse(true);
					drop:SetNormalTexture("interface\\mainmenubar\\ui-mainmenu-scrolldownbutton-up");
					drop:GetNormalTexture():SetTexCoord(6 / 32, 26 / 32, 6 / 32, 26 / 32);
					drop:SetPushedTexture("interface\\mainmenubar\\ui-mainmenu-scrolldownbutton-up");
					drop:GetPushedTexture():SetTexCoord(6 / 32, 26 / 32, 6 / 32, 26 / 32);
					drop:GetPushedTexture():SetVertexColor(unpack(ui_style.textureButtonColorPushed));
					drop:SetHighlightTexture("interface\\mainmenubar\\ui-mainmenu-scrolldownbutton-up");
					drop:GetHighlightTexture():SetTexCoord(6 / 32, 26 / 32, 6 / 32, 26 / 32);
					drop:GetHighlightTexture():SetVertexColor(unpack(ui_style.textureButtonColorHighlight));

					local label = setFrame:CreateFontString(nil, "ARTWORK");
					label:SetFont(ui_style.frameFont, ui_style.frameFontSize, "OUTLINE");
					label:SetText(L.EXPLORER_SET[key]);
					label:SetPoint("LEFT", drop, "RIGHT", 0, 0);
					drop.label = label;

					local cancel = CreateFrame("BUTTON", nil, setFrame);
					cancel:SetSize(16, 16);
					cancel:SetNormalTexture("interface\\buttons\\ui-grouploot-pass-up");
					cancel:SetPushedTexture("interface\\buttons\\ui-grouploot-pass-up");
					cancel:GetPushedTexture():SetVertexColor(unpack(ui_style.textureButtonColorPushed));
					cancel:SetHighlightTexture("interface\\buttons\\ui-grouploot-pass-up");
					cancel:GetHighlightTexture():SetVertexColor(unpack(ui_style.textureButtonColorHighlight));
					cancel:SetPoint("TOP", drop, "BOTTOM", 0, -1);
					cancel:SetScript("OnClick", function(self)
						local filter = SET.explorer.filter;
						if filter[key] ~= nil then
							filter[key] = nil;
							if key == 'type' then
								filter.subType = nil;
							end
							frame.update_func();
						end
					end);
					cancel.key = key;
					drop.cancel = cancel;

					local str = setFrame:CreateFontString(nil, "ARTWORK");
					str:SetFont(ui_style.frameFont, ui_style.frameFontSize, "OUTLINE");
					str:SetText(L[key]);
					str:SetPoint("LEFT", cancel, "RIGHT", 2, 0);
					str:SetVertexColor(0.0, 1.0, 0.0, 1.0);
					drop.fontString = str;
					if index % 4 == 1 then
						if index == 1 then
							drop:SetPoint("CENTER", checkBoxes[1], "CENTER", 0, -24);
						else
							drop:SetPoint("TOPLEFT", dropDowns[index - 3], "BOTTOMLEFT", 0, 0);
						end
					else
						drop:SetPoint("CENTER", dropDowns[index - 1], "CENTER", 94, 0);
					end
					drop:SetScript("OnClick", NS.ui_explorerSetDrop_OnClick);
					drop.key = key;
					drop.frame = frame;
					tinsert(dropDowns, drop);
				end
				setFrame.dropDowns = dropDowns;

				local phaseSlider = CreateFrame("SLIDER", nil, setFrame, "OptionsSliderTemplate");
				phaseSlider:SetPoint("BOTTOM", setFrame, "TOP", 0, 12);
				phaseSlider:SetPoint("LEFT", 4, 0);
				phaseSlider:SetPoint("RIGHT", -4, 0);
				phaseSlider:SetHeight(20);
				phaseSlider:SetMinMaxValues(1, NS.maxPhase)
				phaseSlider:SetValueStep(1);
				phaseSlider:SetObeyStepOnDrag(true);
				phaseSlider.Text:ClearAllPoints();
				phaseSlider.Text:SetPoint("TOP", phaseSlider, "BOTTOM", 0, 3);
				phaseSlider.Low:ClearAllPoints();
				phaseSlider.Low:SetPoint("TOPLEFT", phaseSlider, "BOTTOMLEFT", 4, 3);
				phaseSlider.High:ClearAllPoints();
				phaseSlider.High:SetPoint("TOPRIGHT", phaseSlider, "BOTTOMRIGHT", -4, 3);
				phaseSlider.Low:SetText("\124cff00ff001\124r");
				phaseSlider.High:SetText("\124cffff0000" .. NS.maxPhase .. "\124r");
				phaseSlider:HookScript("OnValueChanged", function(self, value, userInput)
					if userInput then
						SET.explorer.phase = value;
						frame.update_func();
					end
					self.Text:SetText("\124cffffff00" .. L["phase"] .. "\124r " .. value);
				end);
				setFrame.phaseSlider = phaseSlider;

				function frame:RefreshSetFrame()
					local set = SET.explorer;
					for index = 1, #checkBoxes do
						local check = checkBoxes[index];
						check:SetChecked(set[check.key]);
					end
					local filter = set.filter;
					if filter.skill == nil then
						dropDowns[1].fontString:SetText("-");
						dropDowns[1].cancel:Hide();
					else
						dropDowns[1].fontString:SetText(L.TRADESKILL_NAME[filter.skill]);
						dropDowns[1].cancel:Show();
					end
					if filter.type == nil then
						dropDowns[2].fontString:SetText("-");
						dropDowns[3].fontString:SetText("-");
						dropDowns[2].cancel:Hide();
						dropDowns[3].cancel:Hide();
					else
						dropDowns[2].fontString:SetText(L.ITEM_TYPE_LIST[filter.type]);
						dropDowns[2].cancel:Show();
						if filter.subType == nil then
							dropDowns[3].fontString:SetText("-");
							dropDowns[3].cancel:Hide();
						else
							dropDowns[3].fontString:SetText(L.ITEM_SUB_TYPE_LIST[filter.type][filter.subType]);
							dropDowns[3].cancel:Show();
						end
					end
					if filter.eqLoc == nil then
						dropDowns[4].fontString:SetText("-");
						dropDowns[4].cancel:Hide();
					else
						dropDowns[4].fontString:SetText(L.ITEM_EQUIP_LOC[filter.eqLoc]);
						dropDowns[4].cancel:Show();
					end
					phaseSlider:SetValue(set.phase);
				end

			end

			ALA_HOOK_ChatEdit_InsertLink(function(link, addon)
				if frame:IsShown() and addon ~= ADDON and not (BrowseName and BrowseName:IsVisible()) then
					local name = GetItemInfo(link);
					if name and name ~= "" then
						frame.searchEdit:SetText(name);
						frame.searchEdit:ClearFocus();
						frame:Search(name);
						return true;
					end
				end
			end);
			ALA_HOOK_ChatEdit_InsertName(function(name, addon)
				if frame:IsShown() and addon ~= ADDON and not (BrowseName and BrowseName:IsVisible()) then
					if name and name ~= "" then
						frame.searchEdit:SetText(name);
						frame.searchEdit:ClearFocus();
						frame:Search(name);
						return true;
					end
				end
			end);

			frame.updatePriceInfoInFrame = _noop_;
			NS.merc_AddFrame(frame);

			return frame;
		end
		--
			local drop_menu_table = {
				handler = _noop_,
				elements = {
					{
						handler = function()
							SET.lock_board = true;
							gui["BOARD"]:lock();
						end,
						para = {  },
						text = L["BOARD_LOCK"],
					},
					{
						handler = function()
							SET.show_board = false;
							gui["BOARD"]:Hide();
						end,
						para = {  },
						text = L["BOARD_CLOSE"],
					},
				},
			};
			local function seconds_to_colored_formatted_time_len(sec)
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
			local function calendar_head(sid)			--	tex, coord, title, color
				return NS.db_get_texture_by_pid(NS.db_get_pid_by_sid(sid)), nil, NS.db_spell_name_s(sid), nil;
			end
			local function calendar_Line(sid, GUID)		--	tex, coord, title, color_title, cool, color_cool
				local lClass, class, lRace, race, sex, name = GetPlayerInfoByGUID(GUID);
				local cool;
				do
					local pid = NS.db_get_pid_by_sid(sid);
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
												cool = seconds_to_colored_formatted_time_len(diff);
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
			local function update_func()
				local board = gui["BOARD"];
				if board:IsShown() then
					board:Clear();
					for GUID, VAR in next, AVAR do
						local add_label = true;
						for pid = NS.db_min_pid(), NS.db_max_pid() do
							local var = rawget(VAR, pid);
							if var and NS.db_is_pid(pid) then
								local cool = var[3];
								if cool and next(cool) ~= nil then
									if add_label then
										add_label = false;
										local lClass, class, lRace, race, sex, name = GetPlayerInfoByGUID(GUID);
										if name and class then
											local classColorTable = RAID_CLASS_COLORS[strupper(class)];
											name = format(">>\124cff%.2x%.2x%.2x", classColorTable.r * 255, classColorTable.g * 255, classColorTable.b * 255) .. name .. "\124r<<";
											board:AddLine(nil, name);
										else
											board:AddLine(nil, GUID);
										end
									end
									local texture = NS.db_get_texture_by_pid(pid);
									if var.cur_rank and var.max_rank then
										board:AddLine("\124T" .. (texture or ui_style.texture_unk) .. ":12:12:0:0\124t " .. (NS.db_get_pname_by_pid(pid) or ""), nil, var.cur_rank .. " / " .. var.max_rank);
									else
										board:AddLine("\124T" .. (texture or ui_style.texture_unk) .. ":12:12:0:0\124t " .. (NS.db_get_pname_by_pid(pid) or ""));
									end
									for sid, c in next, cool do
										local texture = NS.db_item_icon(NS.db_get_cid_by_sid(sid));
										local sname = "\124T" .. (texture or ui_style.texture_unk) .. ":12:12:0:0\124t " .. NS.db_spell_name_s(sid);
										if c > 0 then
											local diff = c - GetServerTime();
											if diff > 0 then
												board:AddLine(sname, nil, seconds_to_colored_formatted_time_len(diff));
											else
												cool[sid] = -1;
												board:AddLine(sname, nil, L["COOLDOWN_EXPIRED"]);
											end
										else
											board:AddLine(sname, nil, L["COOLDOWN_EXPIRED"]);
										end
									end
								end
							end
						end
					end
					board:Update();
				end
				local cal = __ala_meta__.cal;
				if cal then
					cal.ext_Reset();
					for pid, list in next, NS.cooldown_list do
						if NS.db_is_pid(pid) then
							for index = 1, #list do
								local sid = list[index];
								local add_label = true;
								for GUID, VAR in next, AVAR do
									local var = rawget(VAR, pid);
									if var then
										local cool = var[3];
										if cool and cool[sid[1]] then
											if add_label then
												cal.ext_RegHeader(sid[1], calendar_head);
											end
											cal.ext_AddLine(sid[1], GUID, calendar_Line);
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
		function NS.ui_CreateBoard()
			local board = CreateFrame("FRAME", nil, UIParent);
			if LOCALE == 'zhCN' or LOCALE == 'zhTW' or LOCALE == 'koKR' then
				board:SetWidth(260);
			else
				board:SetWidth(320);
			end
			board:SetBackdrop({
				bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
				edgeFile = "Interface\\ChatFrame\\ChatFrameBackground",
				tile = true,
				edgeSize = 1,
				tileSize = 5,
			});
			board:SetMovable(true);
			-- board:EnableMouse(true);
			-- board:RegisterForDrag("LeftButton");
			function board:lock()
				self:EnableMouse(false);
				self:SetBackdropColor(0.0, 0.0, 0.0, 0.0);
				self:SetBackdropBorderColor(0.0, 0.0, 0.0, 0.0);
			end
			function board:unlock()
				self:EnableMouse(true);
				self:SetBackdropColor(0.0, 0.0, 0.0, 0.5);
				self:SetBackdropBorderColor(0.0, 0.0, 0.0, 0.5);
			end
			board:SetScript("OnMouseDown", function(self, button)
				if button == "LeftButton" then
					self:StartMoving();
				else
					ALADROP(self, "BOTTOMLEFT", drop_menu_table);
				end
			end);
			board:SetScript("OnMouseUp", function(self, button)
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
			board:SetScript("OnEnter", button_info_OnEnter);
			board:SetScript("OnLeave", button_info_OnLeave);
			function board:AddLine(textL, textM, textR)
				local lines = self.lines;
				local index = self.curLine + 1;
				self.curLine = index;
				local line = lines[index];
				if not line then
					local lineL = self:CreateFontString(nil, "OVERLAY");
					lineL:SetFont(GameFontNormal:GetFont());
					lineL:SetPoint("TOPLEFT", self, "TOPLEFT", 0, - 16 * (index - 1));
					local lineM = self:CreateFontString(nil, "OVERLAY");
					lineM:SetFont(GameFontNormal:GetFont());
					lineM:SetPoint("TOP", self, "TOP", 0, - 16 * (index - 1));
					local lineR = self:CreateFontString(nil, "OVERLAY");
					lineR:SetFont(GameFontNormal:GetFont());
					lineR:SetPoint("TOPRIGHT", self, "TOPRIGHT", 0, - 16 * (index - 1));
					line = { lineL, lineM, lineR, };
					lines[index] = line;
				end
				if textL then
					line[1]:Show();
					line[1]:SetText(textL);
				else
					line[1]:Hide();
				end
				if textM then
					line[2]:Show()
					line[2]:SetText(textM);
				else
					line[2]:Hide();
				end
				if textR then
					line[3]:Show()
					line[3]:SetText(textR);
				else
					line[3]:Hide();
				end
			end
			function board:Clear()
				local lines = self.lines;
				for index = 1, self.curLine do
					lines[index][1]:Hide();
					lines[index][2]:Hide();
					lines[index][3]:Hide();
					self:SetHeight(16);
				end
				self.curLine = 0;
			end
			function board:Update()
				self:SetHeight(16 * max(self.curLine, 1));
			end
			board.info_lines = { L["BOARD_TIP"], };
			board.lines = {  };
			board.curLine = 0;
			C_Timer.NewTicker(1.0, update_func);
			if SET.show_board then
				board:Show();
			else
				board:Hide();
			end
			if SET.lock_board then
				board:lock();
			else
				board:unlock();
			end
			if SET.board_pos then
				board:SetPoint(unpack(SET.board_pos));
			else
				board:SetPoint("TOP", 0, -20);
			end
			return board;
		end
		--
			local char_drop_meta_del = {
				text = L.CHAR_DEL,
				para = {  },
			};
			local char_drop_meta = {
				handler = function(_, index)
					NS.func_del_char(index);
				end,
				elements = {
					char_drop_meta_del,
				},
			};
			function NS.ui_configCharListButton_OnClick(self, button)
				local list = SET.char_list;
				local data_index = self:GetDataIndex();
				if data_index <= #list then
					local key = list[data_index];
					if key ~= PLAYER_GUID then
						char_drop_meta_del.para[1] = data_index;
						ALADROP(self, "BOTTOM", char_drop_meta);
					end
				end
			end
			function NS.ui_configCharListButton_OnEnter(self)
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
					for pid = NS.db_min_pid(), NS.db_max_pid() do
						local var = rawget(VAR, pid);
						if var and NS.db_is_pid(pid) then
							if add_blank then
								GameTooltip:AddLine(" ");
								add_blank = false;
							end
							local right = var.cur_rank;
							if var.max_rank then
								right = (right or "") .. "/" .. var.max_rank;
							end
							if right then
								GameTooltip:AddDoubleLine("    " .. (NS.db_get_pname_by_pid(pid) or pid), right .. "    ", 1.0, 1.0, 1.0, 1.0, 1.0, 1.0);
							else
								GameTooltip:AddLine("    " .. (NS.db_get_pname_by_pid(pid) or pid), 1.0, 1.0, 1.0);
							end
						end
					end
					-- if VAR.PLAYER_LEVEL then
					-- 	button.note:SetText(VAR.PLAYER_LEVEL);
					-- else
					-- 	button.note:SetText(nil);
					-- end
					GameTooltip:Show();
				end
			end
			function NS.ui_CreateCharListButton(parent, index, buttonHeight)
				local button = CreateFrame("BUTTON", nil, parent);
				button:SetHeight(buttonHeight);
				button:SetBackdrop(ui_style.listButtonBackdrop);
				button:SetBackdropColor(unpack(ui_style.listButtonBackdropColor_Enabled));
				button:SetBackdropBorderColor(unpack(ui_style.listButtonBackdropBorderColor));
				button:SetHighlightTexture(ui_style.texture_white);
				button:GetHighlightTexture():SetVertexColor(unpack(ui_style.listButtonHighlightColor));
				button:EnableMouse(true);
				button:RegisterForClicks("AnyUp");

				local icon = button:CreateTexture(nil, "BORDER");
				icon:SetTexture(ui_style.texture_unk);
				icon:SetSize(buttonHeight - 4, buttonHeight - 4);
				icon:SetPoint("LEFT", 8, 0);
				icon:SetTexture("interface\\targetingframe\\ui-classes-circles");
				button.icon = icon;

				local title = button:CreateFontString(nil, "OVERLAY");
				title:SetFont(ui_style.frameFont, ui_style.frameFontSize, ui_style.frameFontOutline);
				title:SetPoint("LEFT", icon, "RIGHT", 4, 0);
				-- title:SetWidth(160);
				title:SetMaxLines(1);
				title:SetJustifyH("LEFT");
				button.title = title;

				local note = button:CreateFontString(nil, "OVERLAY");
				note:SetFont(ui_style.frameFont, ui_style.frameFontSize, ui_style.frameFontOutline);
				note:SetPoint("RIGHT", button, "RIGHT", -4, 0);
				-- note:SetWidth(160);
				note:SetMaxLines(1);
				note:SetJustifyH("LEFT");
				note:SetVertexColor(1.0, 0.25, 0.25, 1.0);
				button.note = note;

				button:SetScript("OnClick", NS.ui_configCharListButton_OnClick);
				button:SetScript("OnEnter", NS.ui_configCharListButton_OnEnter);
				button:SetScript("OnLeave", info_OnLeave);

				local frame = parent:GetParent():GetParent();
				button.frame = frame;

				return button;
			end
			function NS.ui_SetCharListButton(button, data_index)
				local list = SET.char_list;
				if data_index <= #list then
					local key = list[data_index];
					local VAR = AVAR[key];
					local lClass, class, lRace, race, sex, name, realm = GetPlayerInfoByGUID(key);
					if name and class then
						class = strupper(class);
						local coord = CLASS_ICON_TCOORDS[class];
						if coord then
							button.icon:Show();
							button.icon:SetTexCoord(coord[1] + 1 / 256, coord[2] - 1 / 256, coord[3] + 1 / 256, coord[4] - 1 / 256);
						else
							button.icon:Show();
						end
						if realm ~= nil and realm ~= "" then
							name = name .. "-" .. realm;
						end
						button.title:SetText(name);
						local classColorTable = RAID_CLASS_COLORS[class];
						if classColorTable then
							button.title:SetVertexColor(classColorTable.r, classColorTable.g, classColorTable.b, 1.0);
						else
							button.title:SetVertexColor(0.75, 0.75, 0.75, 1.0);
						end
					else
						button.icon:Hide();
						button.title:SetText(key);
						button.title:SetVertexColor(0.75, 0.75, 0.75, 1.0);
					end
					if VAR.PLAYER_LEVEL then
						button.note:SetText(VAR.PLAYER_LEVEL);
					else
						button.note:SetText(nil);
					end
					button:Show();
				else
					button:Hide();
				end
			end
			function NS.ui_config_CreateCheck(parent, key, text, OnClick)
				local check = CreateFrame("CHECKBUTTON", nil, parent, "OptionsBaseCheckButtonTemplate");
				check:SetSize(24, 24);
				check:SetHitRectInsets(0, 0, 0, 0);
				check:Show();
				local str = check:CreateFontString(nil, "ARTWORK");
				str:SetFont(ui_style.frameFont, ui_style.frameFontSize, "NORMAL");
				str:SetText(text);
				check.fontString = str;
				str:SetPoint("LEFT", check, "RIGHT", 0, 0);
				check.key = key;
				check:SetScript("OnClick", OnClick);
				function check:SetVal(val)
					self:SetChecked(val);
				end
				check.right = str;
				return check;
			end
			function NS.ui_configDrop_OnClick(self)
				ALADROP(self, "BOTTOM", self.meta);
			end 
			function NS.ui_config_CreateDrop(parent, key, text, meta)
				local drop = CreateFrame("BUTTON", nil, parent);
				drop:SetSize(20, 20);
				drop:EnableMouse(true);
				drop:SetNormalTexture("interface\\mainmenubar\\ui-mainmenu-scrolldownbutton-up");
				drop:GetNormalTexture():SetTexCoord(6 / 32, 26 / 32, 6 / 32, 26 / 32);
				drop:SetPushedTexture("interface\\mainmenubar\\ui-mainmenu-scrolldownbutton-up");
				drop:GetPushedTexture():SetTexCoord(6 / 32, 26 / 32, 6 / 32, 26 / 32);
				drop:GetPushedTexture():SetVertexColor(unpack(ui_style.textureButtonColorPushed));
				drop:SetHighlightTexture("interface\\mainmenubar\\ui-mainmenu-scrolldownbutton-up");
				drop:GetHighlightTexture():SetTexCoord(6 / 32, 26 / 32, 6 / 32, 26 / 32);
				drop:GetHighlightTexture():SetVertexColor(unpack(ui_style.textureButtonColorHighlight));
				local label = drop:CreateFontString(nil, "ARTWORK");
				label:SetFont(ui_style.frameFont, ui_style.frameFontSize, "NORMAL");
				label:SetText(gsub(text, "%%[a-z]", ""));
				label:SetPoint("LEFT", drop, "RIGHT", 0, 0);
				drop.label = label;
				local str = drop:CreateFontString(nil, "ARTWORK");
				str:SetFont(ui_style.frameFont, ui_style.frameFontSize, "NORMAL");
				str:SetPoint("TOPLEFT", label, "BOTTOMLEFT", 0, -2);
				str:SetVertexColor(0.0, 1.0, 0.0, 1.0);
				drop.fontString = str;
				drop.key = key;
				drop.meta = meta;
				local elements = meta.elements;
				for index = 1, #elements do
					elements[index].para[1] = drop;
				end
				drop:SetScript("OnClick", NS.ui_configDrop_OnClick);
				function drop:SetVal(val)
					local elements = self.meta.elements;
					for index = 1, #elements do
						local element = elements[index];
						if element.para[2] == val then
							self.fontString:SetText(element.text);
							break;
						end
					end
				end
				drop.right = label;
				return drop;
			end
			function NS.ui_config_CreateSlider(parent, key, text, minVal, maxVal, step, OnValueChanged)
				local slider = CreateFrame("SLIDER", nil, parent, "OptionsSliderTemplate");
				local label = slider:CreateFontString(nil, "ARTWORK");
				label:SetFont(ui_style.frameFont, ui_style.frameFontSize, "NORMAL");
				label:SetText(gsub(text, "%%[a-z]", ""));
				slider:SetWidth(200);
				slider:SetHeight(20);
				slider:SetMinMaxValues(minVal, maxVal)
				slider:SetValueStep(step);
				slider:SetObeyStepOnDrag(true);
				slider:SetPoint("LEFT", label, "LEFT", 60, 0);
				slider.Text:ClearAllPoints();
				slider.Text:SetPoint("TOP", slider, "BOTTOM", 0, 3);
				slider.Low:ClearAllPoints();
				slider.Low:SetPoint("TOPLEFT", slider, "BOTTOMLEFT", 4, 3);
				slider.High:ClearAllPoints();
				slider.High:SetPoint("TOPRIGHT", slider, "BOTTOMRIGHT", -4, 3);
				slider.Low:SetText(minVal);
				slider.High:SetText(maxVal);
				slider.key = key;
				slider.label = label;
				slider:HookScript("OnValueChanged", OnValueChanged);
				function slider:SetVal(val)
					self:SetValue(val);
				end
				function slider:SetStr(str)
					self.Text:SetText(str);
				end
				slider._SetPoint = slider.SetPoint;
				function slider:SetPoint(...)
					self.label:SetPoint(...);
				end
				slider.right = slider;
				return slider;
			end
			function NS.ui_config_CreateColor4(parent, key, text, OnColor)
				local button = CreateFrame("BUTTON", nil, parent);
				button:SetSize(20, 20);
				button:EnableMouse(true);
				button:SetNormalTexture(ui_style.texture_color_select);
				button:GetNormalTexture():SetVertexColor(1.0, 1.0, 1.0, 1.0);
				button:SetPushedTexture(ui_style.texture_color_select);
				button:GetPushedTexture():SetVertexColor(unpack(ui_style.textureButtonColorPushed));
				button:SetHighlightTexture(ui_style.texture_color_select);
				button:GetHighlightTexture():SetVertexColor(unpack(ui_style.textureButtonColorHighlight));
				local valStr = button:CreateTexture(nil, "OVERLAY");
				valStr:SetAllPoints(true);
				local left = button:CreateFontString(nil, "ARTWORK");
				left:SetFont(ui_style.frameFont, ui_style.frameFontSize, "NORMAL");
				left:SetText(">>");
				left:SetPoint("RIGHT", button, "LEFT", -2, 0);
				local label = button:CreateFontString(nil, "ARTWORK");
				label:SetFont(ui_style.frameFont, ui_style.frameFontSize, "NORMAL");
				label:SetText("<<" .. gsub(text, "%%[a-z]", ""));
				label:SetPoint("LEFT", button, "RIGHT", 2, 0);
				button.label = label;
				button.key = key;
				button.valStr = valStr;
				local bakup = nil;
				button.func = function()
					local r, g, b = ColorPickerFrame:GetColorRGB();
					local a = 1.0 - OpacitySliderFrame:GetValue();
					OnColor(r, g, b, a);
					-- ColorPickerFrame.Alpha.bg:SetVertexColor(r, g, b);
				end
				button.opacityFunc = function()
					local r, g, b = ColorPickerFrame:GetColorRGB();
					local a = 1.0 - OpacitySliderFrame:GetValue();
					OnColor(r, g, b, a);
				end
				button.cancelFunc = function()
					if bakup then
						OnColor(unpack(bakup));
						bakup = nil;
					end
				end
				button:SetScript("OnClick", function(self)
					bakup = SET[self.key];
					-- ColorPickerFrame.Alpha:Show();
					ColorPickerFrame.func = button.func;
					ColorPickerFrame.hasOpacity = true;
					ColorPickerFrame.opacityFunc = button.opacityFunc;
					ColorPickerFrame.opacity = 1.0 - bakup[4];
					-- ColorPickerFrame.previousValues = { r = bakup[1], g = bakup[2], b = bakup[3], opacity = bakup[4], };
					ColorPickerFrame.cancelFunc = button.cancelFunc;
					ColorPickerFrame:ClearAllPoints();
					ColorPickerFrame:SetPoint("TOPLEFT", button, "BOTTOMRIGHT", 12, 12);
					ColorPickerFrame:SetColorRGB(unpack(bakup));
					ShowUIPanel(ColorPickerFrame);
				end);
				function button:SetVal(val)
					valStr:SetColorTexture(val[1], val[2], val[3], val[4] or 1.0);
				end
				button.right = label;
				return button;
			end
		--
		function NS.ui_CreateConfigFrame()
			local frame = CreateFrame("FRAME", "ALA_TRADESKILL_CONFIG", UIParent);
			tinsert(UISpecialFrames, "ALA_TRADESKILL_CONFIG");
			frame:SetBackdrop(ui_style.frameBackdrop);
			frame:SetBackdropColor(unpack(ui_style.frameBackdropColor));
			frame:SetBackdropBorderColor(unpack(ui_style.frameBackdropBorderColor));
			frame:SetSize(450, 250);
			frame:SetFrameStrata("DIALOG");
			frame:SetPoint("CENTER");
			frame:EnableMouse(true);
			frame:SetMovable(true);
			frame:RegisterForDrag("LeftButton");
			frame:SetScript("OnDragStart", function(self)
				self:StartMoving();
			end);
			frame:SetScript("OnDragStop", function(self)
				self:StopMovingOrSizing();
			end);
			frame:Hide();
			--
			local close = CreateFrame("BUTTON", nil, frame);
			close:SetSize(20, 20);
			close:SetNormalTexture("interface\\buttons\\ui-stopbutton");
			close:SetPushedTexture("interface\\buttons\\ui-stopbutton");
			close:GetPushedTexture():SetVertexColor(unpack(ui_style.textureButtonColorPushed));
			close:SetHighlightTexture("interface\\buttons\\ui-stopbutton");
			close:GetHighlightTexture():SetVertexColor(unpack(ui_style.textureButtonColorHighlight));
			close:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -2, -2);
			close:SetScript("OnClick", function()
				frame:Hide();
			end);
			close:SetScript("OnEnter", info_OnEnter);
			close:SetScript("OnLeave", info_OnLeave);
			close.info_lines = { L.CLOSE, };
			close.frame = frame;
			frame.close = close;
			--
			local set_objects = {  };
			local px, py, h = 0, 0, 1;
			local set_cmd_list = NS.set_cmd_list;
			for index = 1, #set_cmd_list do
				local cmd = set_cmd_list[index];
				if px >= 1 then
					px = 0;
					py = py + h;
					h = 1;
				end
				local key = cmd[3];
				if cmd[1] == 'bool' then
					local check = NS.ui_config_CreateCheck(frame, key, L.SLASH_NOTE[key], cmd[8]);
					check:SetPoint("TOPLEFT", frame, "TOPLEFT", 10 + 150 * px, -25 - 25 * py);
					set_objects[key] = check;
					px = px + 1;
					h = max(h, 1);
				elseif cmd[7] == 'drop' then
					local drop = NS.ui_config_CreateDrop(frame, key, L.SLASH_NOTE[key], cmd[8]);
					drop:SetPoint("TOPLEFT", frame, "TOPLEFT", 10 + 150 * px, -25 - 25 * py);
					set_objects[key] = drop;
					px = px + 1;
					h = max(h, 2);
				elseif cmd[7] == 'slider' then
					if px > 2 then
						px = 0;
						py = py + h;
						h = 1;
					end
					local slider = NS.ui_config_CreateSlider(frame, key, L.SLASH_NOTE[key], cmd[9][1], cmd[9][2], cmd[9][3], cmd[8]);
					slider:SetPoint("TOPLEFT", frame, "TOPLEFT", 10 + 150 * px, -25 - 25 * py);
					set_objects[key] = slider;
					px = px + 2;
					h = max(h, 2);
				end
				local extra_list = cmd[10];
				if extra_list then
					local father = set_objects[key];
					local children_key = {  };
					father.children_key = children_key;
					for val, extra in next, extra_list do
						local exkey = extra[3];
						children_key[exkey] = val;
						if extra[7] == 'bool' then
							local check = NS.ui_config_CreateCheck(frame, exkey, L.SLASH_NOTE[exkey], extra[8]);
							check:SetPoint("LEFT", father.right, "RIGHT", 20, 0);
							set_objects[exkey] = check;
						elseif extra[7] == 'drop' then
							local drop = NS.ui_config_CreateDrop(frame, exkey, L.SLASH_NOTE[exkey], extra[8]);
							drop:SetPoint("LEFT", father.right, "RIGHT", 20, 0);
							set_objects[exkey] = drop;
						elseif extra[7] == 'slider' then
							local slider = NS.ui_config_CreateSlider(frame, exkey, L.SLASH_NOTE[exkey], extra[9][1], extra[9][2], extra[9][3], extra[8]);
							slider:SetPoint("LEFT", father.right, "RIGHT", 20, 0);
							set_objects[exkey] = slider;
						elseif extra[7] == 'color4' then
							local color4 = NS.ui_config_CreateColor4(frame, exkey, L.SLASH_NOTE[exkey], extra[8]);
							color4:SetPoint("LEFT", father.right, "RIGHT", 40, 0);
							set_objects[exkey] = color4;
						end
					end
				end
			end
			frame.set_objects = set_objects;
			if px ~= 0 then
				px = 0;
				py = py + h;
				h = 1;
			end
			do	--	character list
				local char_list = CreateFrame("FRAME", nil, frame);
				char_list:SetBackdrop(ui_style.frameBackdrop);
				char_list:SetBackdropColor(unpack(ui_style.frameBackdropColor));
				char_list:SetBackdropBorderColor(unpack(ui_style.frameBackdropBorderColor));
				char_list:SetSize(240, 400);
				char_list:SetPoint("BOTTOMLEFT", frame, "BOTTOMRIGHT", 2, 0);
				char_list:EnableMouse(true);
				char_list:SetMovable(false);
				-- char_list:RegisterForDrag("LeftButton");
				-- char_list:SetScript("OnDragStart", function(self)
				-- 	self:GetParent():StartMoving();
				-- end);
				-- char_list:SetScript("OnDragStop", function(self)
				-- 	self:GetParent():StopMovingOrSizing();
				-- end);
				char_list:Hide();

				local scroll = ALASCR(char_list, nil, nil, ui_style.charListButtonHeight, NS.ui_CreateCharListButton, NS.ui_SetCharListButton);
				scroll:SetPoint("BOTTOMLEFT", 4, 12);
				scroll:SetPoint("TOPRIGHT", - 4, - 24);
				char_list.scroll = scroll;
				scroll:SetNumValue(#SET.char_list);

				char_list:SetScript("OnShow", function(self)
					gui["CONFIG"].call_char_list:Texture(true);
				end);
				char_list:SetScript("OnHide", function(self)
					gui["CONFIG"].call_char_list:Texture(false);
				end);
				frame.char_list = char_list;

				local call = CreateFrame("BUTTON", nil, frame);
				call:SetSize(20, 20);
				call:SetNormalTexture(ui_style.texture_triangle);
				call:GetNormalTexture():SetVertexColor(0.5, 0.5, 0.5, 1.0);
				call:GetNormalTexture():SetBlendMode("ADD");
				call:SetPushedTexture(ui_style.texture_triangle);
				call:GetPushedTexture():SetVertexColor(0.25, 0.25, 0.25, 1.0);
				call:GetPushedTexture():SetBlendMode("ADD");
				call:SetHighlightTexture(ui_style.texture_triangle);
				call:GetHighlightTexture():SetAlpha(0.25);
				call:SetPoint("TOPLEFT", 420, -25 - 25 * py);
				function call:Texture(bool)
					if bool then
						self:GetNormalTexture():SetTexCoord(1.0, 0.0, 0.0, 1.0);
						self:GetPushedTexture():SetTexCoord(1.0, 0.0, 0.0, 1.0);
						self:GetHighlightTexture():SetTexCoord(1.0, 0.0, 0.0, 1.0);
					else
						self:GetNormalTexture():SetTexCoord(0.0, 1.0, 0.0, 1.0);
						self:GetPushedTexture():SetTexCoord(0.0, 1.0, 0.0, 1.0);
						self:GetHighlightTexture():SetTexCoord(0.0, 1.0, 0.0, 1.0);
					end
				end
				call:Texture(false);
				call.char_list = char_list;
				call:SetScript("OnClick", function(self)
					local char_list = self.char_list;
					if char_list:IsShown() then
						char_list:Hide();
					else
						char_list:Show();
					end
				end);
				frame.call_char_list = call;
				local str = call:CreateFontString(nil, "OVERLAY");
				str:SetFont(ui_style.frameFont, ui_style.frameFontSize, "NORMAL");
				str:SetPoint("RIGHT", call, "LEFT", -2, 0);
				str:SetVertexColor(1.0, 1.0, 1.0, 1.0);
				str:SetText(L.CHAR_LIST);
				call.fontString = str;
				function char_list:update_func()
					self.scroll:SetNumValue(#SET.char_list);
					self.scroll:Update();
				end
			end
			function frame:Refresh()
				for key, obj in next, set_objects do
					obj:SetVal(SET[key]);
					local children_key = obj.children_key;
					if children_key then
						for exkey, val in next, children_key do
							local obj2 = set_objects[exkey];
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
			function frame:update_func()
				-- self:Refresh();
				self.char_list:update_func();
			end
			frame:SetScript("OnShow", function(self)
				self:Refresh();
			end);
			frame:SetHeight(25 + py * 25 + 25);
			return frame;
		end
	end

	do	--	supreme craft
			function NS.ui_supremeListButton_OnEnter(self)
				local frame = self.frame;
				local sid = self.list[self:GetDataIndex()];
				if type(sid) == 'table' then
					sid = sid[1];
				end
				-- local pid = NS.db_get_pid_by_pname(frame.pname());
				local pid = self.flag or NS.db_get_pid_by_sid(sid);
				if pid then
					local set = SET[pid];
					mouse_focus_sid = sid;
					mouse_focus_phase = set.phase;
					GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
					local info = NS.db_get_info_by_sid(sid);
					if info then
						if set.showItemInsteadOfSpell and info[index_cid] then
							GameTooltip:SetItemByID(info[index_cid]);
						else
							GameTooltip:SetSpellByID(sid);
						end
						local phase = info[index_phase];
						if phase > curPhase then
							GameTooltip:AddLine("\124cffff0000" .. L["available_in_phase_"] .. phase .. "\124r");
						end
						GameTooltip:Show();
					else
						GameTooltip:SetSpellByID(sid);
					end
					local text = NS.db_get_difficulty_rank_list_text_by_sid(sid);
					if text then
						GameTooltip:AddDoubleLine(L["LABEL_RANK_LEVEL"], text);
						GameTooltip:Show();
					end
					local data = frame.hash[sid];
					if pid == 'explorer' then
						local hash = explorer_hash[sid];
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
									name = format("\124cff%.2x%.2x%.2x", classColorTable.r * 255, classColorTable.g * 255, classColorTable.b * 255) .. name .. "\124r";
									str = str .. " " .. name;
								else
									str = str .. " " .. GUID;
								end
								index = index + 1;
							end
							GameTooltip:AddLine(str);
							GameTooltip:Show();
						else
						end
						data = data and data[PLAYER_GUID];
					end
					if not data then
						NS.ui_set_tooltip_mtsl(sid);
					end
				end
			end
			function NS.ui_supremeListButton_OnLeave(self)
				mouse_focus_sid = nil;
				button_info_OnLeave(self);
			end
			function NS.ui_supremeListButton_OnClick(self, button)
				local frame = self.frame;
				local sid = self.list[self:GetDataIndex()];
				if type(sid) == 'table' then
					sid = sid[1];
				end
				local data = frame.hash[sid];
				if button == "LeftButton" then
					if IsShiftKeyDown() then
						local cid = NS.db_get_cid_by_sid(sid);
						if cid then
							ChatEdit_InsertLink(NS.db_item_link(cid), ADDON);
						else
							ChatEdit_InsertLink(NS.enchant_link(sid), ADDON);
						end
					elseif IsAltKeyDown() then
						local text1 = nil;
						local text2 = nil;
						if data then
							local n = frame.reagent_num(data);
							if n and n > 0 then
								local m1, m2 = frame.recipe_num_made(data);
								if m1 == m2 then
									text1 = frame.recipe_link(data) .. "x" .. m1 .. L["PRINT_MATERIALS: "];
								else
									text1 = frame.recipe_link(data) .. "x" .. m1 .. "-" .. m2 .. L["PRINT_MATERIALS: "];
								end
								text2 = "";
								if n > 4 then
									for i = 1, n do
										text2 = text2 .. frame.reagent_info(data, i) .. "x" .. select(3, frame.reagent_info(data, i));
									end
								else
									for i = 1, n do
										text2 = text2 .. frame.reagent_link(data, i) .. "x" .. select(3, frame.reagent_info(data, i));
									end
								end
							end
						else
							local info = NS.db_get_info_by_sid(sid);
							local cid = info[index_cid];
							if info then
								if cid then
									text1 = NS.db_item_link_s(cid) .. "x" .. (info[index_num_made_min] == info[index_num_made_max] and info[index_num_made_min] or (info[index_num_made_min] .. "-" .. info[index_num_made_max])) .. L["PRINT_MATERIALS: "];
								else
									text1 = NS.db_spell_name_s(sid) .. L["PRINT_MATERIALS: "];
								end
								text2 = "";
								local rinfo = info[index_reagents_id];
								if #rinfo > 4 then
									for i = 1, #rinfo do
										text2 = text2 .. NS.db_item_name_s(rinfo[i]) .. "x" .. info[index_reagents_count][i];
									end
								else
									for i = 1, #rinfo do
										text2 = text2 .. NS.db_item_link_s(rinfo[i]) .. "x" .. info[index_reagents_count][i];
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
						local cid = NS.db_get_cid_by_sid(sid);
						if cid then
							local link = NS.db_item_link(cid);
							if link then
								DressUpItemLink(link);
							end
						end
					else
						if data and type(data) == 'number' then
							frame.select_func(data);
							frame.hooked_frame.numAvailable = select(3, frame.recipe_info(data));
							frame.selected_sid = sid;
							frame.update_func();
							frame.searchEdit:ClearFocus();
							local scroll = frame.hooked_scrollBar;
							local num = frame.recipe_num();
							local minVal, maxVal = scroll:GetMinMaxValues();
							local step = scroll:GetValueStep();
							local cur = scroll:GetValue() + step;
							local value = step * (data - 1);
							if value < cur or value > (cur + num * step - maxVal) then
								scroll:SetValue(min(maxVal, value));
							end
							frame.scroll:Update();
							if frame.profitFrame:IsShown() then
								frame.profitScroll:Update();
							end
						end
					end
				elseif button == "RightButton" then
					frame.searchEdit:ClearFocus();
					local pid = NS.db_get_pid_by_sid(sid);
					if FAV[sid] then
						list_drop_sub_fav.para[1] = frame;
						list_drop_sub_fav.para[2] = pid;
						list_drop_sub_fav.para[3] = sid;
						list_drop_meta.elements[1] = list_drop_sub_fav;
					else
						list_drop_add_fav.para[1] = frame;
						list_drop_add_fav.para[2] = pid;
						list_drop_add_fav.para[3] = sid;
						list_drop_meta.elements[1] = list_drop_add_fav;
					end
					list_drop_query_who_can_craft_it.para[1] = frame;
					list_drop_query_who_can_craft_it.para[2] = pid;
					list_drop_query_who_can_craft_it.para[3] = sid;
					ALADROP(self, "BOTTOMLEFT", list_drop_meta);
				end
			end
			function NS.ui_CreateSupremeListButton(parent, index, buttonHeight)
				local frame = parent:GetParent():GetParent();

				local button = CreateFrame("BUTTON", nil, parent);
				button:SetHeight(buttonHeight);
				button:SetBackdrop(ui_style.listButtonBackdrop);
				button:SetBackdropColor(unpack(ui_style.listButtonBackdropColor_Enabled));
				button:SetBackdropBorderColor(unpack(ui_style.listButtonBackdropBorderColor));
				button:SetHighlightTexture(ui_style.texture_white);
				button:GetHighlightTexture():SetVertexColor(unpack(ui_style.listButtonHighlightColor));
				button:EnableMouse(true);
				button:Show();

				local del = CreateFrame("BUTTON", nil, button);
				del:SetSize(buttonHeight / 2, buttonHeight / 2);
				del:SetPoint("LEFT", 4, 0);
				NS.ui_ModernButton(del, nil, ui_style.texture_modern_button_close);
				del:SetScript("OnClick", frame.del);
				button.del = del;

				local icon = button:CreateTexture(nil, "BORDER");
				icon:SetTexture(ui_style.texture_unk);
				icon:SetSize(buttonHeight - 8, buttonHeight - 8);
				icon:SetPoint("LEFT", del, "RIGHT", 8, 0);
				button.icon = icon;

				local title = button:CreateFontString(nil, "OVERLAY");
				title:SetFont(ui_style.frameFont, ui_style.frameFontSize, ui_style.frameFontOutline);
				title:SetPoint("LEFT", icon, "RIGHT", 4, 0);
				-- title:SetWidth(160);
				title:SetMaxLines(1);
				title:SetJustifyH("LEFT");
				title:SetPoint("LEFT", icon, "RIGHT", 8, 0);
				button.title = title;

				local num = CreateFrame("EDITBOX", nil, button);
				num:SetHeight(16);
				num:SetFont(ui_style.frameFont, ui_style.frameFontSize, ui_style.frameFontOutline);
				num:SetAutoFocus(false);
				num:SetJustifyH("LEFT");
				num:Show();
				num:EnableMouse(true);
				num:ClearFocus();
				num:SetPoint("LEFT", title, "RIGHT", 48, 0);
				local numBG = num:CreateTexture(nil, "ARTWORK");
				numBG:SetPoint("TOPLEFT");
				numBG:SetPoint("BOTTOMRIGHT");
				numBG:SetTexture("Interface\\Buttons\\greyscaleramp64");
				numBG:SetTexCoord(0.0, 0.25, 0.0, 0.25);
				numBG:SetAlpha(0.75);
				numBG:SetBlendMode("ADD");
				numBG:SetVertexColor(0.25, 0.25, 0.25);
				num.BG = numBG;
				num:SetScript("OnEditFocusGained", function(self) self.BG:Show(); end);
				num:SetScript("OnEditFocusLost", function(self) self.BG:Hide(); end);
				num:SetScript("OnEnterPressed", function(self) self:ClearFocus(); end);
				num:SetScript("OnEscapePressed", function(self) self:ClearFocus(); end);
				button.num = num;
				
				local up = CreateFrame("BUTTON", nil, button);
				up:SetSize(buttonHeight / 2 - 3, buttonHeight / 2 - 3);
				up:SetPoint("TOPRIGHT", -4, -2);
				NS.ui_ModernButton(up, nil, ui_style.texture_modern_arrow_up);
				up:SetScript("OnClick", frame.change_order_up);
				button.up = up;

				local down = CreateFrame("BUTTON", nil, button);
				down:SetSize(buttonHeight / 2 - 3, buttonHeight / 2 - 3);
				down:SetPoint("BOTTOMRIGHT", -4, 2);
				NS.ui_ModernButton(down, nil, ui_style.texture_modern_arrow_down);
				down:SetScript("OnClick", frame.change_order_down);
				button.down = down;

				local quality_glow = button:CreateTexture(nil, "ARTWORK");
				quality_glow:SetTexture("Interface\\Buttons\\UI-ActionButton-Border");
				quality_glow:SetBlendMode("ADD");
				quality_glow:SetTexCoord(0.25, 0.75, 0.25, 0.75);
				quality_glow:SetSize(buttonHeight - 2, buttonHeight - 2);
				quality_glow:SetPoint("CENTER", icon);
				-- quality_glow:SetAlpha(0.75);
				quality_glow:Show();
				button.quality_glow = quality_glow;

				button:SetScript("OnEnter", NS.ui_supremeListButton_OnEnter);
				button:SetScript("OnLeave", NS.ui_supremeListButton_OnLeave);
				button:RegisterForClicks("AnyUp");
				button:SetScript("OnClick", NS.ui_supremeListButton_OnClick);
				button:RegisterForDrag("LeftButton");
				button:SetScript("OnHide", ALADROP);

				button.frame = frame;

				return button;
			end
			function NS.ui_SetSupremeListButton(button, data_index)
				local frame = button.frame;
				local list = frame.list;
				local hash = frame.hash;
				if data_index <= #list then
					local pid = NS.db_get_pid_by_pname(frame.pname());
					if pid then
						local set = SET[pid];
						local sid = list[data_index];
						local cid = NS.db_get_cid_by_sid(sid);
						local data = hash[sid];
						if data then
							local name, rank, num = frame.recipe_info(data);
							if name and rank ~= 'header' then
								button:Show();
								button:SetBackdropColor(unpack(ui_style.listButtonBackdropColor_Enabled));
								local quality = cid and NS.db_item_rarity(cid);
								button.icon:SetTexture(frame.recipe_icon(data));
								button.icon:SetVertexColor(1.0, 1.0, 1.0, 1.0);
								if num > 0 then
									button.title:SetText(name .. " [" .. num .. "]");
								else
									button.title:SetText(name);
								end
								button.title:SetTextColor(unpack(rank_color[rank_index[rank]] or ui_style.color_white));
								if set.showRank then
									button.note:SetText(NS.db_get_difficulty_rank_list_text_by_sid(sid));
								else
									button.note:SetText("");
								end
								if quality then
									local r, g, b, code = GetItemQualityColor(quality);
									button.quality_glow:SetVertexColor(r, g, b);
									button.quality_glow:Show();
								else
									button.quality_glow:Hide();
								end
								if FAV[sid] then
									button.star:Show();
								else
									button.star:Hide();
								end
								if sid == frame.selected_sid then
									button:Select();
								else
									button:Deselect();
								end
							else
								button:Hide();
							end
						else
							button:Show();
							if SET.colored_rank_for_unknown then
								button:SetBackdropColor(unpack(ui_style.listButtonBackdropColor_Disabled));
							else
								button:SetBackdropColor(unpack(ui_style.listButtonBackdropColor_Enabled));
							end
							local _, quality, icon;
							if cid then
								_, _, quality, _, icon = NS.db_item_info(cid);
							else
								quality = nil;
								icon = ICON_FOR_NO_CID;
							end
							button.icon:SetTexture(icon);
							button.icon:SetVertexColor(1.0, 0.0, 0.0, 1.0);
							button.title:SetText(NS.db_spell_name_s(sid));
							if SET.colored_rank_for_unknown then
								local var = rawget(VAR, pid);
								button.title:SetTextColor(unpack(rank_color[NS.db_get_difficulty_rank_by_sid(sid, var and var.cur_rank or 0)] or ui_style.color_white));
							else
								button.title:SetTextColor(1.0, 0.0, 0.0, 1.0);
							end
							if set.showRank then
								button.note:SetText(NS.db_get_difficulty_rank_list_text_by_sid(sid));
							else
								button.note:SetText("");
							end
							if quality then
								local r, g, b, code = GetItemQualityColor(quality);
								button.quality_glow:SetVertexColor(r, g, b);
								button.quality_glow:Show();
							else
								button.quality_glow:Hide();
							end
							if FAV[sid] then
								button.star:Show();
							else
								button.star:Hide();
							end
							button:Deselect();
						end
						if GetMouseFocus() == button then
							NS.ui_skillListButton_OnEnter(button);
						end
						if button.prev_sid ~= sid then
							ALADROP(button);
							button.prev_sid = sid;
						end
					else
						ALADROP(button);
						button:Hide();
					end
				else
					ALADROP(button);
					button:Hide();
				end
			end
		function NS.ui_CreateSupreme(hooked_frame)
			local supreme = CreateFrame("FRAME", nil, hooked_frame);
			--	supreme
				supreme:SetFrameStrata("HIGH");
				supreme:EnableMouse(true);
				supreme:SetSize(256, 256);
				function supreme.update_func()
					supreme.scroll:SetNumValue(#list);
					supreme.scroll:Update();
				end
				function supreme.del(button)
					local index = button:GetDataIndex();
				end
				function supreme.set_num(edit)
					local index = edit:GetParent():GetDataIndex();
				end
				function supreme.change_order_up(button)
					local index = button:GetDataIndex();
				end
				function supreme.change_order_down(button)
					local index = button:GetDataIndex();
				end
				supreme:SetScript("OnShow", function(self)
				end);
				supreme:SetScript("OnHide", function(self)
				end);
				supreme.list = SET.supreme_list;
				supreme.hooked_frame = hooked_frame;
				supreme.frame = hooked_frame.frame;
				hooked_frame.supreme = supreme;

				local scroll = ALASCR(supreme, nil, nil, ui_style.supremeListButtonHeight, NS.ui_CreateSupremeListButton, NS.ui_SetSupremeListButton);
				scroll:SetPoint("BOTTOMLEFT", 4, 0);
				scroll:SetPoint("TOPRIGHT", - 4, - 28);
				NS.ui_ModifyALAScrollFrame(scroll);
				supreme.scroll = scroll;

				local call = CreateFrame("BUTTON", nil, hooked_frame, "UIPanelButtonTemplate");
				call:SetSize(18, 18);
				call:SetPoint("LEFT", hooked_frame, "RIGHT", - 2, 0);
				call:SetFrameLevel(127);
				call:SetScript("OnClick", function(self)
					if supreme:IsShown() then
						supreme:Hide();
						call:SetText(L["Open"]);
						SET.show_supreme = false;
					else
						supreme:Show();
						call:SetText(L["Close"]);
						SET.show_supreme = true;
						supreme.update_func();
					end
				end);
				-- call:SetScript("OnEnter", Info_OnEnter);
				-- call:SetScript("OnLeave", Info_OnLeave);
				supreme.call = call;
			--
			return supreme;
		end
	end

	do	-- 	tooltip
		local recipe_black_list_sid = NS.recipe_black_list_sid;
		local recipe_black_list_cid = NS.recipe_black_list_cid;
		local space_table = setmetatable({}, {
			__index = function(t, k)
				local str = "\124cff000000" .. strrep("*", 2 * k) .. "\124r";
				t[k] = str;
				return str;
			end,
		});
		--	return price, cost, cost_known, missing, cid
		function NS.price_gen_info_by_sid(phase, sid, num, lines, stack_level, is_enchanting, ...)	--	merc not checked
			local info = NS.db_get_info_by_sid(sid);
			if info then
				num = num or 1;
				stack_level = stack_level or 0;
				local cid = info[index_cid];
				local cost = nil;
				local cost_known = 0;
				local missing = 0;
				local detail_lines = lines and {  };
				if stack_level == 0 then
					phase = max(info[index_phase], phase);
				end
				if stack_level <= 4 then
					local pid = info[index_pid];
					if info[index_phase] <= phase then
						local reagid = info[index_reagents_id];
						local reagnum = info[index_reagents_count];
						cost = 0;
						for i = 1, #reagid do
							local iid = reagid[i];
							local num = reagnum[i];
							local p, c = nil, nil;
							local got = false;
							if not recipe_black_list_cid[iid] then
								if iid == cid then
									got = true;
									c = 0;
								else
									for index = 1, select("#", ...) do
										if iid == select(index, ...) then
											got = true;
											break;
										end
									end
								end
								if got then
									got = false;
								else
									local nsids, sids = NS.db_get_sid_by_cid(iid);
									if nsids > 0 then
										for index = 1, #sids do
											local sid = sids[index];
											if NS.db_get_pid_by_sid(sid) == pid then
												local p2, c2 = NS.price_gen_info_by_sid(phase, sid, num, detail_lines, stack_level + 1, nil, cid, ...);
												p = p or p2;
												if c2 then
													if c and c > c2 or not c then
														c = c2;
													end
												end
												got = true;
											end
										end
									end
								end
							end
							if not got then
								local name = merc.query_name_by_id(iid) or NS.db_item_name_s(iid);
								local quality = merc.query_quality_by_id(iid) or NS.db_item_rarity(iid);
								if quality then
									local _, _, _, code = GetItemQualityColor(quality);
									name = "\124c" .. code .. name .. "\124r";
								end
								if iid ~= cid then
									p = merc.query_ah_price_by_id(iid);
									local v = merc.get_material_vendor_price_by_id(iid);
									if v then
										if p == nil or p > v then
											p = v;
										end
									end
									if p then
										p = p * num;
										if detail_lines then
											tinsert(detail_lines, space_table[stack_level + 1] .. name .. "x" .. num);
											tinsert(detail_lines, merc.MoneyString(p));
										end
									else
										if detail_lines then
											local bindType = NS.db_item_bindType(iid);
											if bindType == 1 or bindType == 4 then
												tinsert(detail_lines, space_table[stack_level + 1] .. name .. "x" .. num);
												tinsert(detail_lines, L["BOP"]);
											else
												tinsert(detail_lines, space_table[stack_level + 1] .. name .. "x" .. num);
												tinsert(detail_lines, L["UNKOWN_PRICE"]);
											end
										end
									end
								else
									if detail_lines then
										tinsert(detail_lines, space_table[stack_level + 1] .. name .. "x" .. num);
										tinsert(detail_lines, "-");
									end
								end
							end
							if not p and not c then
								cost = nil;
								if stack_level > 0 then
									break;
								end
								missing = missing + 1;
							else
								if p then
									if c and p > c then
										p = c;
									end
								else
									p = c;
								end
								if cost then
									cost = cost + p;
								end
								cost_known = cost_known + p;
							end
						end
					end
				end
				local vendorPrice = cid and merc.get_material_vendor_price_by_id(cid);
				local price = cid and merc.query_ah_price_by_id(cid);
				if vendorPrice then
					if price == nil or vendorPrice < price then
						price = vendorPrice;
					end
				end
				price = price and price * num;
				local nMade = (info[index_num_made_min] + info[index_num_made_max]) / 2;
				cost = cost and cost * num / nMade;
				cost_known = cost_known and cost_known * num / nMade;
				local name = cid and (merc.query_name_by_id(cid) or NS.db_item_name_s(cid));
				local quality = cid and (merc.query_quality_by_id(cid) or NS.db_item_rarity(cid));
				if quality then
					local _, _, _, code = GetItemQualityColor(quality);
					name = name and ("\124c" .. code .. name .. "\124r") or "";
				else
					name = name or "";
				end
				if stack_level == 0 then
					if lines then
						for index = 1, #detail_lines do
							tinsert(lines, detail_lines[index]);
						end
						if is_enchanting then
							if cost then
								tinsert(lines, "\124cffff7f00**\124r" .. "\124cffffffff" .. NS.db_spell_name_s(sid) .. "\124r" or L["COST_PRICE"]);
								tinsert(lines, L["COST_PRICE"] .. merc.MoneyString(cost));
							else
								tinsert(lines, "\124cffff7f00**\124r" .. "\124cffffffff" .. NS.db_spell_name_s(sid) .. "\124r" or L["COST_PRICE"]);
								tinsert(lines, L["COST_PRICE_KNOWN"] .. merc.MoneyString(cost_known));
							end
						else
							if cost then
								tinsert(lines, "\124cffff7f00**\124r" .. name .. "x" .. num);
								tinsert(lines, L["COST_PRICE"] .. merc.MoneyString(cost));
							else
								tinsert(lines, "\124cffff7f00**\124r" .. name .. "x" .. num);
								tinsert(lines, L["COST_PRICE_KNOWN"] .. merc.MoneyString(cost_known));
							end
							if price then
								tinsert(lines, "\124cff00ff00**\124r" .. name .. "x" .. num);
								tinsert(lines, L["AH_PRICE"] .. merc.MoneyString(price));
							end
							if cost and price then
								local diff = price - cost;
								if diff > 0 then
									tinsert(lines, "\124cff00ff00**\124r" .. L["PRICE_DIFF+"]);
									tinsert(lines, L["PRICE_DIFF_INFO+"] .. merc.MoneyString(diff));
								elseif diff < 0 then
									tinsert(lines, "\124cffff0000**\124r" .. L["PRICE_DIFF-"]);
									tinsert(lines, L["PRICE_DIFF_INFO-"] .. merc.MoneyString(-diff));
								end
							end
						end
					end
				else
					if price and (not cost or cost >= price) then
						if lines then
							tinsert(lines, space_table[stack_level] .. name .. "x" .. num);
							tinsert(lines, merc.MoneyString(price));
						end
					elseif cost and (not price or cost < price) then
						if lines then
							tinsert(lines, space_table[stack_level] .. name .. "x" .. num);
							tinsert(lines, merc.MoneyString(cost));
							for index = 1, #detail_lines do
								tinsert(lines, detail_lines[index]);
							end
						end
						price = nil;
					else
						if lines then
							local bindType = NS.db_item_bindType(cid);
							if bindType == 1 or bindType == 4 then
								tinsert(lines, space_table[stack_level] .. name .. "x" .. num);
								tinsert(lines, L["BOP"]);
							else
								tinsert(lines, space_table[stack_level] .. name .. "x" .. num);
								tinsert(lines, L["UNKOWN_PRICE"]);
							end
						end
					end
				end
				return price, cost, cost_known, missing, cid;
			end
		end
		local function set_tip_by_sid(tip, sid)
			local info = NS.db_get_info_by_sid(sid);
			if info then
				tip:AddLine(L["CRAFT_INFO"]);
				local cid = info[index_cid];
				local pid = info[index_pid];
				local texture = NS.db_get_texture_by_pid(pid);
				local rank = info[index_learn_rank];
				local name = NS.db_get_pname_by_pid(pid);
				if texture then
					name = "\124T" .. texture .. ":12:12:0:0\124t " .. name;
				end
				if rank then
					name = name .. "(" .. rank .. ")";
				end
				tip:AddLine("\124cff00afff" .. name .. "\124r");
				local detail_lines = {  };
				NS.price_gen_info_by_sid(mouse_focus_sid == sid and mouse_focus_phase or curPhase, sid, (info[index_num_made_min] + info[index_num_made_max]) / 2, detail_lines, 0, cid == nil);
				if #detail_lines > 0 then
					for i = 1, #detail_lines, 2 do
						tip:AddDoubleLine(detail_lines[i], detail_lines[i + 1]);
					end
					tip:Show();
				end
			end
		end
		local function set_tip_by_cid(tip, cid)
			local nsids, sids = NS.db_get_sid_by_cid(cid);
			if nsids > 0 then
				tip:AddLine(L["CRAFT_INFO"]);
				for index = 1, #sids do
					local sid = sids[index];
					local info = NS.db_get_info_by_sid(sid);
					if info then
						local pid = info[index_pid];
						local texture = NS.db_get_texture_by_pid(pid);
						local rank = info[index_learn_rank];
						local name = NS.db_get_pname_by_pid(pid) or "";
						if texture then
							name = "\124T" .. texture .. ":12:12:0:0\124t " .. name;
						end
						if rank then
							name = name .. "(" .. rank .. ")";
						end
						tip:AddLine("\124cff00afff" .. name .. "\124r");
						local detail_lines = {  };
						NS.price_gen_info_by_sid(mouse_focus_sid == sid and mouse_focus_phase or curPhase, sid, (info[index_num_made_min] + info[index_num_made_max]) / 2, detail_lines, 0, false);
						if #detail_lines > 0 then
							for i = 1, #detail_lines, 2 do
								tip:AddDoubleLine(detail_lines[i], detail_lines[i + 1]);
							end
						end
					end
				end
				tip:Show();
			end
		end
		local function add_account_recipe_learned_info(tip, rid, sid)
			sid = sid or NS.db_get_sid_by_rid(rid);
			if sid then
				local info = NS.db_get_info_by_sid(sid);
				if info then
					local pid = info[index_pid];
					local add_head = true;
					local learn_rank = info[index_learn_rank];
					for GUID, VAR in next, AVAR do
						-- if PLAYER_GUID ~= GUID then
							local var = rawget(VAR, pid);
							if var then
								if add_head then
									tip:AddLine(L["LABEL_ACCOUT_RECIPE_LEARNED"]);
									add_head = false;
								end
								local lClass, class, lRace, race, sex, name = GetPlayerInfoByGUID(GUID);
								if name and class then
									local classColorTable = RAID_CLASS_COLORS[strupper(class)];
									name = format("\124cff%.2x%.2x%.2x", classColorTable.r * 255, classColorTable.g * 255, classColorTable.b * 255) .. name .. "\124r";
								else
									name = GUID;
								end
								if var[2][sid] then
									name = space_table[1] .. L["RECIPE_LEARNED"] .. "  " .. name .. "  \124cffffffff" .. var.cur_rank .. "/" .. var.max_rank .. "\124r";
								else
									name = space_table[1] .. L["RECIPE_NOT_LEARNED"] .. "  " .. name
												.. ((var.cur_rank >= learn_rank) and "  \124cff00ff00" or "  \124cffff0000") .. var.cur_rank
												.. ((var.max_rank >= learn_rank) and "\124r\124cffffffff/\124r\124cff00ff00" or "\124r\124cffffffff/\124r\124cffff0000") .. var.max_rank .. "\124r";
									-- if var.cur_rank >= learn_rank then
									-- 	name = space_table[1] .. L["RECIPE_NOT_LEARNED"] .. "  " .. name .. "  \124cff00ff00" .. var.cur_rank .. "\124r\124cffffffff/" .. var.max_rank .. "\124r";
									-- else
									-- 	name = space_table[1] .. L["RECIPE_NOT_LEARNED"] .. "  " .. name .. "  \124cffff0000" .. var.cur_rank .. "\124r\124cffffffff/" .. var.max_rank .. "\124r";
									-- end
								end
								tip:AddLine(name);
							end
						-- end
					end
					tip:Show();
				end
			end
		end
		local function add_material_craft_info(tip, iid)
			local data = NS.db_get_sid_by_reagent(iid);
			if data then
				local not_show_all = not IsShiftKeyDown();
				tip:AddLine(L["LABEL_USED_AS_MATERIAL_IN"]);
				local lineL = nil;
				local lineR = nil;
				local nLines = 0;
				local sids, nums = data[1], data[2];
				for index = 1, #sids do
					local sid = sids[index];
					local num = nums[index];
					if not_show_all and nLines >= 8 then
						tip:AddLine(space_table[1] .. "\124cffff0000...\124r");
						break;
					end
					local info = NS.db_get_info_by_sid(sid);
					if info then
						local cid = info[index_cid];
						if cid then
							lineL = space_table[1] .. NS.db_item_string_s(cid) .. "x" .. num;
							lineR = "\124cff00afff" .. NS.db_get_pname_by_pid(info[index_pid]) .. info[index_learn_rank] .. "\124r";
						else
							lineL = space_table[1] .. NS.db_spell_string_s(sid) .. "x" .. num;
							lineR = "\124cff00afff" .. NS.db_get_pname_by_pid(info[index_pid]) .. info[index_learn_rank] .. "\124r";
						end
						tip:AddDoubleLine(lineL, lineR);
						nLines = nLines + 1;
					end
				end
				tip:Show();
			end
		end
		function NS.tooltip_Hyperlink(tip, link)
			local _, sid = tip:GetSpell();
			if sid then
				NS.tooltip_SpellByID(tip, sid);
				return;
			end
			if link then
				local cid = tonumber(select(3, strfind(link, "item:(%d+)")) or nil);
				if cid then
					NS.tooltip_ItemByID(tip, cid);
				end
			end
		end
		function NS.tooltip_SpellByID(tip, sid)
			if merc then
				if SET.show_tradeskill_tip_craft_spell_price then
					if sid and NS.db_is_tradeskill_sid(sid) then
						set_tip_by_sid(tip, sid);
					end
				end
			end
		end
		function NS.tooltip_ItemByID(tip, iid)
			if SET.show_tradeskill_tip_recipe_account_learned then
				add_account_recipe_learned_info(tip, iid);
			end
			if SET.show_tradeskill_tip_material_craft_info then
				add_material_craft_info(tip, iid);
			end
			if merc then
				if SET.show_tradeskill_tip_craft_item_price then
					if iid and NS.db_is_tradeskill_cid(iid) then
						set_tip_by_cid(tip, iid);
					end
				end
				if SET.show_tradeskill_tip_recipe_price then
					local sid = NS.db_get_sid_by_rid(iid);
					if sid then
						set_tip_by_sid(tip, sid);
					end
				end
			end
		end
		function NS.tooltip_GUISpell(tip)
			local _, sid = tip:GetSpell();
			if sid then
				NS.tooltip_SpellByID(tip, sid);
			end
		end
		function NS.tooltip_GUIItem(tip)
			local _, link = tip:GetItem();
			if link then
				local iid = tonumber(select(3, strfind(link, "item:(%d+)")) or nil);
				if iid then
					NS.tooltip_ItemByID(tip, iid);
				end
			end
		end
		function NS.tooltip_CraftSpell(tip)
			local _, sid = tip:GetSpell();
			if sid then
				NS.tooltip_SpellByID(tip, sid);
			else
				local _, link = tip:GetItem();
				local iid = link and tonumber(select(3, strfind(link, "item:(%d+)")) or nil);
				if iid then
					NS.tooltip_ItemByID(tip, iid);
				end
			end
		end
		function NS.hook_tooltip()
			hooksecurefunc(GameTooltip, "SetHyperlink", NS.tooltip_Hyperlink);
			hooksecurefunc(ItemRefTooltip, "SetHyperlink", NS.tooltip_Hyperlink);
			hooksecurefunc(GameTooltip, "SetSpellByID", NS.tooltip_SpellByID);
			hooksecurefunc(ItemRefTooltip, "SetSpellByID", NS.tooltip_SpellByID);
			hooksecurefunc(GameTooltip, "SetItemByID", NS.tooltip_ItemByID);
			hooksecurefunc(ItemRefTooltip, "SetItemByID", NS.tooltip_ItemByID);
			hooksecurefunc(GameTooltip, "SetCraftSpell", NS.tooltip_CraftSpell);
			hooksecurefunc(ItemRefTooltip, "SetCraftSpell", NS.tooltip_CraftSpell);
			hooksecurefunc(GameTooltip, "SetMerchantItem", NS.tooltip_GUIItem);
			hooksecurefunc(GameTooltip, "SetBuybackItem", NS.tooltip_GUIItem);
			hooksecurefunc(GameTooltip, "SetBagItem", NS.tooltip_GUIItem);
			hooksecurefunc(GameTooltip, "SetAuctionItem", NS.tooltip_GUIItem);
			hooksecurefunc(GameTooltip, "SetAuctionSellItem", NS.tooltip_GUIItem);
			hooksecurefunc(GameTooltip, "SetLootItem", NS.tooltip_GUIItem);
			hooksecurefunc(GameTooltip, "SetLootRollItem", NS.tooltip_GUIItem);
			hooksecurefunc(GameTooltip, "SetInventoryItem", NS.tooltip_GUIItem);
			hooksecurefunc(GameTooltip, "SetTradePlayerItem", NS.tooltip_GUIItem);
			hooksecurefunc(GameTooltip, "SetTradeTargetItem", NS.tooltip_GUIItem);
			hooksecurefunc(GameTooltip, "SetQuestItem", NS.tooltip_GUIItem);
			hooksecurefunc(GameTooltip, "SetQuestLogItem", NS.tooltip_GUIItem);
			hooksecurefunc(GameTooltip, "SetInboxItem", NS.tooltip_GUIItem);
			hooksecurefunc(GameTooltip, "SetSendMailItem", NS.tooltip_GUIItem);
			hooksecurefunc(GameTooltip, "SetTradeSkillItem", NS.tooltip_GUIItem);
			hooksecurefunc(GameTooltip, "SetCraftItem", function(tip, recipe_index, reagent_index)
				local link = GetCraftReagentItemLink(recipe_index, reagent_index);
				if link then
					local iid = tonumber(select(3, strfind(link, "item:(%d+)")) or nil);
					if iid then
						NS.tooltip_ItemByID(tip, iid);
					end
				end
			end);
			hooksecurefunc(GameTooltip, "SetTrainerService", NS.tooltip_GUIItem);
		end
		--	mtsl
		local mtsl_locale_list = {
			def = "English",
			["frFR"] = "French",
			["deDE"] = "German",
			["ruRU"] = "Russian",
			["koKR"] = "Korean",
			["zhCN"] = "Chinese",
			["zhTW"] = "Chinese",
			["esES"] = "Spanish",
			["ptBR"] = "Portuguese",
		};
		local MTSL_LOCALE = mtsl_locale_list[LOCALE] or mtsl_locale_list.def;
		local tooltip_set_quest;
		local tooltip_set_item;
		local tooltip_set_object;
		local tooltip_set_npc;
		local function add_reputation_line(reputation)
			local line = nil;
			local fid = reputation.faction_id;
			for _, fv in next, MTSL_DATA["factions"] do
				if fv.id == fid then
					local name = fv.name[MTSL_LOCALE];
					if name then
						line = "\124cffff7f00" .. name .. "\124r";
					end
					break;
				end
			end
			line = line or "factionID: " .. fid;
			local lid = reputation.level_id;
			for _, lv in next, MTSL_DATA["reputation_levels"] do
				if lv.id == lid then
					local name = lv.name[MTSL_LOCALE];
					if name then
						line = line .. format("\124cff%.2xff00", min(255, max(0, 64 * (8 - lid) - 1))) .. name .. "\124r";
					end
					break;
				end
			end
			GameTooltip:AddDoubleLine(" ", line);
			GameTooltip:Show();
		end
		local npc_prefix = {	--	== "Alliance"
			[true] = {
				Alliance = ": \124Tinterface\\timer\\Alliance-logo:20\124t\124cff00ff00",
				Horde = ": \124Tinterface\\timer\\Horde-logo:20\124t\124cffff0000",
				Neutral = ": \124cffffff00",
				Hostile = ": \124cffff0000",
				["*"] = ": \124cffffffff",
			},
			[false] = {
				Alliance = ": \124Tinterface\\timer\\Alliance-logo:20\124t\124cffff0000",
				Horde = ": \124Tinterface\\timer\\Horde-logo:20\124t\124cff00ff00",
				Neutral = ": \124cffffff00",
				Hostile = ": \124cffff0000",
				["*"] = ": \124cffffffff",
			},
		};
		tooltip_set_npc = function(pid, nid, label, alliance_green, prefix, suffix, stack_size)
			if stack_size < 8 then
				if MTSL_DATA then
					local npcs = MTSL_DATA["npcs"];
					if npcs then
						local got_one_data = false;
						for _, nv in next, npcs do
							if nv.id == nid then
								got_one_data = true;
								local colorTable = npc_prefix[alliance_green];
								local line = prefix .. (colorTable[nv.reacts] or colorTable["*"]);
								local name = nv.name[MTSL_LOCALE];
								if name then
									line = line .. name;
								else
									line = line .. "npcID: " .. nid;
								end
								local xp_level = nv.xp_level;
								if xp_level then
									if xp_level.min ~= xp_level.max then
										line = line .. "Lv" .. xp_level.min .. "-" .. xp_level.max;
									else
										line = line .. "Lv" .. xp_level.min;
									end
									if xp_level.is_elite > 0 then
										line = line .. L["elite"];
									end
								end
								line = line .. " [" .. C_Map.GetAreaInfo(nv.zone_id) or L["unknown area"];
								local location = nv.location;
								if location and location.x ~= "-" and location.y ~= "-" then
									line = line .. " " .. location.x .. ", " .. location.y .. "]";
								else
									line = line .. "]";
								end
								local phase = nv.phase;
								if phase and phase > curPhase then
									line = line .. " " .. L["phase"] .. phase;
								end
								GameTooltip:AddDoubleLine(label, line);
								local special_action = nv.special_action;
								if special_action then
									local sav = MTSL_DATA["special_actions"][special_action];
									if sav and sav.name then
										local sa = sav.name[MTSL_LOCALE];
										if sa then
											GameTooltip:AddDoubleLine(" ", sa);
										end
									end
								end
								line = line .. suffix;
								break;
							end
						end
						if not got_one_data then
							GameTooltip:AddDoubleLine(" ", L["sold_by"] .. ": \124cffff0000unknown\124r, npcID: " .. nid);
						end
						GameTooltip:Show();
					end
				end
			end
		end
		tooltip_set_quest = function(pid, qid, label, stack_size)
			if stack_size <= 8 then
				if MTSL_DATA then
					local quests = MTSL_DATA["quests"];
					if quests then
						local got_one_data = false;
						for _, qv in next, quests do
							if qv.id == qid then
								got_one_data = true;
								local line = "[";
								local name = qv.name[MTSL_LOCALE];
								if name then
									line = line .. qv.name[MTSL_LOCALE] .. "]";
								else
									line = line .. "\124cffffff00" .. L["quest"] .. "\124r ID: " .. qid .. "]";
								end
								local min_xp_level = qv.min_xp_level;
								if min_xp_level then
									line = line .. "Lv" .. min_xp_level;
								end
								local phase = qv.phase;
								if phase and phase > curPhase then
									line = line .. " " .. L["phase"] .. phase;
								end
								GameTooltip:AddDoubleLine(label, L["quest_reward"] .. ": \124cffffff00" .. line .. "\124r");
								if qv.npcs then
									for _, nid in next, qv.npcs do
										tooltip_set_npc(pid, nid, " ", UnitFactionGroup('player') == "Alliance", L["quest_accepted_from"], "\124r", stack_size + 1);
									end
								end
								if qv.items then
									for _, iid in next, qv.items do
										tooltip_set_item(pid, iid, " ", stack_size + 1);
									end
								end
								if qv.objects then
									for _, oid in next, qv.objects do
										tooltip_set_object(pid, oid, " ", stack_size + 1);
									end
								end
								if qv.reputation then
									add_reputation_line(qv.reputation);
								end
								local special_action = qv.special_action;
								if special_action then
									local sav = MTSL_DATA["special_actions"][special_action];
									if sav and sav.name then
										local sa = sav.name[MTSL_LOCALE];
										if sa then
											GameTooltip:AddDoubleLine(" ", "\124cffffffff" .. sa .. "\124r");
										end
									end
								end
								break;
							end
						end
						if not got_one_data then
							GameTooltip:AddDoubleLine(label, "\124cffffff00" .. L["quest"] .. "\124r ID: " .. qid);
						end
					end
					GameTooltip:Show();
				end
			end
		end
		tooltip_set_item = function(pid, iid, label, stack_size)
			if stack_size <= 8 then
				local _, line, _, _, _, _, _, _, bind = NS.db_item_info(iid);
				if not line then
					line = "\124cffffffff" .. L["item"] .. "\124r ID: " .. iid;
				end
				if bind ~= 1 and bind ~= 4 then
					line = line .. "(\124cff00ff00" .. L["tradable"] .. "\124r)";
					if merc then
						local price = merc.query_ah_price_by_id(iid);
						if price and price > 0 then
							line = line .. " \124cff00ff00AH\124r " .. merc.MoneyString(price);
						end
					end
				else
					line = line .. "(\124cffff0000" .. L["non_tradable"] .. "\124r)";
				end
				GameTooltip:AddDoubleLine(label, line);
				if MTSL_DATA then
					local pname = NS.db_get_mtsl_pname(pid);
					local data = MTSL_DATA["items"][pname];
					if data then
						for i, iv in next, data do
							if iv.id == iid then
								local vendors = iv.vendors;
								if vendors then
									for _, nid in next, vendors.sources do
										tooltip_set_npc(pid, nid, " ", UnitFactionGroup('player') == "Alliance", L["sold_by"], "\124r", stack_size + 1);
									end
								end
								local drops = iv.drops;
								if drops then
									if drops.sources then
										for _, nid in next, drops.sources do
											tooltip_set_npc(pid, nid, " ", UnitFactionGroup('player') ~= "Alliance", L["dropped_by"], "\124r", stack_size + 1);
										end
									end
									local range = drops.range;
									if range then
										if range.min_xp_level and range.max_xp_level then
											local line = range.min_xp_level .. "-" .. range.max_xp_level;
											GameTooltip:AddDoubleLine(" ", L["world_drop"] .. ": \124cffff0000" .. L["dropped_by_mod_level"] .. line .. "\124r");
										else
											GameTooltip:AddDoubleLine(" ", L["world_drop"]);
										end
									end
								end
								if iv.quests then
									for _, qid in next, iv.quests do
										tooltip_set_quest(pid, qid, " ", stack_size + 1);
									end
								end
								if iv.objects then
									for _, oid in next, iv.objects do
										tooltip_set_object(pid, oid, " ", stack_size + 1);
									end
								end
								if iv.reputation then
									add_reputation_line(iv.reputation);
								end
								local line2 = nil;
								local holiday = iv.holiday;
								if holiday then
									for _, hv in next, MTSL_DATA["holidays"] do
										if hv.id == holiday then
											local h = hv.name[MTSL_LOCALE];
											if h then
												-- GameTooltip:AddDoubleLine(" ", h);
												line2 = "\124cff00ffff" .. h .. "\124r";
											end
											break;
										end
									end
								end
								local special_action = iv.special_action;
								if special_action then
									local sav = MTSL_DATA["special_actions"][special_action];
									if sav and sav.name then
										local sa = sav.name[MTSL_LOCALE];
										if sa then
											-- GameTooltip:AddDoubleLine(" ", sa);
											if line2 then
												line2 = line2 .. "\124cffffffff" .. sa .. "\124r";
											else
												line2 = "\124cffffffff" .. sa .. "\124r";
											end
										end
									end
								end
								if line2 then
									GameTooltip:AddDoubleLine(" ", line2);
								end
								break;
							end
						end
					end
				end
				GameTooltip:Show();
			end
		end
		tooltip_set_object = function(pid, oid, label, stack_size)
			if stack_size <= 8 then
				if MTSL_DATA then
					local objects = MTSL_DATA["objects"];
					if objects then
						local got_one_data = false;
						for _, ov in next, objects do
							if ov.id == oid then
								got_one_data = true;
								local line = ov.name[MTSL_LOCALE] or ("\124cffffffff" .. L["object"] .. "\124r ID: " .. oid);
								line = line .. " [" .. C_Map.GetAreaInfo(ov.zone_id);
								local location = ov.location;
								if location and location.x ~= "-" and location.y ~= "-" then
									line = line .. " " .. location.x .. ", " .. location.y .. "]";
								else
									line = line .. "]";
								end
								local phase = ov.phase;
								if phase and phase > curPhase then
									line = line .. " " .. L["phase"] .. phase;
								end
								GameTooltip:AddDoubleLine(label, L["object"] .. ": \124cffffffff" .. line .. "\124r");
								local special_action = ov.special_action;
								if special_action then
									local sav = MTSL_DATA["special_actions"][special_action];
									if sav and sav.name then
										local sa = sav.name[MTSL_LOCALE];
										if sa then
											GameTooltip:AddDoubleLine(" ", "\124cffffffff" .. sa .. "\124r");
										end
									end
								end
								break;
							end
						end
						if not got_one_data then
							GameTooltip:AddDoubleLine(label, "\124cffffffff" .. L["object"] .. "\124r ID: " .. oid);
						end
						GameTooltip:Show();
					end
				end
			end
		end
		function NS.ui_set_tooltip_mtsl(sid)
			local info = NS.db_get_info_by_sid(sid);
			if info then
				if info[index_trainer] then			-- trainer
					GameTooltip:AddDoubleLine(L["LABEL_GET_FROM"], "\124cffff00ff" .. L["trainer"] .. "\124r");
					GameTooltip:Show();
				end
				if info[index_rid] then					-- recipe
					tooltip_set_item(info[index_pid], info[index_rid], L["LABEL_GET_FROM"], 1)
				end
				if info[index_quest] then			-- quests
					for _, qid in next, info[index_quest] do
						tooltip_set_quest(info[index_pid], qid, L["LABEL_GET_FROM"], 1);
					end
				end
				if info[index_object] then			-- objects
					if type(info[index_object]) == 'table' then
						for _, oid in next, info[index_object] do
							tooltip_set_object(info[index_pid], oid, L["LABEL_GET_FROM"], 1);
						end
					else
						tooltip_set_object(info[index_pid], info[index_object], L["LABEL_GET_FROM"], 1);
					end
				end
				--
				if MTSL_DATA then
					local pname = NS.db_get_mtsl_pname(info[index_pid]);
					local data = MTSL_DATA["skills"][pname];
					if data then
						for _, sv in next, data do
							if sv.id == sid then
								local specialisation = sv.specialisation;
								if specialisation then
									local stable = MTSL_DATA["specialisations"][pname];
									if stable then
										for _, spv in next, stable do
											if spv.id == specialisation then
												GameTooltip:AddDoubleLine(" ", "\124cffffffff" .. spv.name[MTSL_LOCALE] .. "\124r");
												GameTooltip:Show();
											end
										end
									end
								end
								local reputation = sv.reputation;
								if reputation then
									add_reputation_line(reputation);
								end
								break;
							end
						end
					end
				end
			end
		end
	end

	do	--	check cooldown
		for pid, list in next, NS.cooldown_list do
			for index = 1, #list do
				local data = list[index];
				data[2] = NS.db_get_learn_rank_by_sid(data[1]) or data[2];
			end
		end
		local GetSpellModifiedCooldown = __ala_meta__.GetSpellModifiedCooldown;
		function NS.cooldown_check(pid, var)
			local list = NS.cooldown_list[pid];
			if list then
				local cool = var[3];
				if cool then
					wipe(cool);
				else
					cool = {  };
					var[3] = cool;
				end
				for index = 1, #list do
					local data = list[index];
					local sid = data[1];
					if var.cur_rank >= data[2] then
						local cooling, start, duration = GetSpellModifiedCooldown(sid);
						if cooling then
							cool[sid] = GetServerTime() + duration + start - GetTime();
						else
							cool[sid] = -1;
						end
					else
						cool[sid] = nil;
					end
				end
			end
		end
		function NS.BAG_UPDATE_COOLDOWN(...)
			for pid = NS.db_min_pid(), NS.db_max_pid() do
				local var = rawget(VAR, pid);
				if var and NS.db_is_pid(pid) then
					NS.cooldown_check(pid, var);
				end
			end
		end
	end

	do	--	COMMUNICATION
		local ADDON_PREFIX = "ALATSK";
		local ADDON_MSG_CONTROL_CODE_LEN = 6;
		local ADDON_MSG_SKILL_BROADCAST = "_b_skl";
		local ADDON_MSG_QUERY_SKILL = "_q_skl";
		local ADDON_MSG_REPLY_SKILL = "_r_skl";
		local ADDON_MSG_QUERY_RECIPE = "_q_rcp";
		local ADDON_MSG_REPLY_RECIPE = "_r_rcp";
		local ADDON_MSG_QUERY_SKILL_RECIPES = "_q_src";
		local ADDON_MSG_REPLY_SKILL_RECIPES = "_r_src";
		local ADDON_MSG_BROADCAST_BEGIN = "_p_beg";
		local ADDON_MSG_BROADCAST_BODY = "_p_bod";
		local ADDON_MSG_BROADCAST_END = "_p_end";
		--------------------------------------------------
		local queue_guild_msg = {  };
		local queue_whisper_msg = {  };
		local queried_sid = setmetatable({  }, {
			__index = function(t, k)
				local temp = setmetatable({  }, {
					__index = function(t1, k1)
						local temp1 = {  };
						t[k1] = temp1;
						return temp1;
					end,
					__call = function(t1, k1)
						local temp1 = rawget(t1, k1);
						if temp1 then
							wipe(temp1);
						else
							temp1 = t1[k1];
						end
						return temp1;
					end
				});
				t[k] = temp;
				return temp;
			end,
			__call = function(t, k)
				local temp = rawget(t, k);
				if temp then
					wipe(temp);
				else
					temp = t[k];
				end
				return temp;
			end
		});
		local function skill_msg(header)	--	head#pid:cur:max
			local msg = header;
			local valid = false;
			for pid = NS.db_min_pid(), NS.db_max_pid() do
				local var = rawget(VAR, pid);
				if var and NS.db_is_pid(pid) then
					if var.cur_rank and var.max_rank then
						msg = msg .. "#" .. PLAYER_GUID .. "#" .. pid .. ":" .. var.cur_rank .. ":" .. var.max_rank;
						valid = true;
					end
				end
			end
			return valid, msg;
		end
		local function skill_broadcast()
			if IsInGuild() then
				local valid, msg = skill_msg(ADDON_MSG_REPLY_SKILL);
				if valid then
					SendAddonMessage(ADDON_PREFIX, msg, "GUILD");
				end
			end
		end
		local function get_ColoredName(GUID)
			local lClass, class, lRace, race, sex, name = GetPlayerInfoByGUID(GUID);
			if name and class then
				local classColorTable = RAID_CLASS_COLORS[strupper(class)];
				return format("\124cff%.2x%.2x%.2x", classColorTable.r * 255, classColorTable.g * 255, classColorTable.b * 255) .. name .. "\124r";
			end
		end
		local function get_PlayerLink(GUID)
			local lClass, class, lRace, race, sex, name = GetPlayerInfoByGUID(GUID);
			if name and class then
				local classColorTable = RAID_CLASS_COLORS[strupper(class)];
				return "\124Hplayer:" .. name .. ":0:WHISPER\124h" .. 
							format("\124cff%.2x%.2x%.2x[", classColorTable.r * 255, classColorTable.g * 255, classColorTable.b * 255) .. name .. "]\124r"
							.. "\124h";
			end
		end
		function NS.CHAT_MSG_ADDON(prefix, msg, channel, sender, target, zoneChannelID, localID, name, instanceID)
			if prefix == ADDON_PREFIX then
				local name, realm = strsplit("-", sender);
				if name and (realm == nil or realm == "" or realm == PLAYER_REALM_NAME) then
					local control_code = strsub(msg, 1, ADDON_MSG_CONTROL_CODE_LEN);
					local body = strsub(msg, ADDON_MSG_CONTROL_CODE_LEN + 2, - 1);
					if body == "" then
						return;
					end
					--[[if control_code == ADDON_MSG_QUERY_SKILL then
						local valid, msg = skill_msg(ADDON_MSG_REPLY_SKILL);
						if valid then
							SendAddonMessage(ADDON_PREFIX, msg, "WHISPER", sender);
						end
					else--]]if control_code == ADDON_MSG_SKILL_BROADCAST or control_code == ADDON_MSG_REPLY_SKILL then
						local _, _, GUID, val = strfind(body, "^([^#^:]+)#(.+)$");
						if GUID then
							local cmm = CMM[GUID];
							if cmm == nil then
								cmm = {  };
								CMM[GUID] = cmm;
							end
							local data = { strsplit("#", val) };
							for index = 1, #data do
								local skill = data[index];
								local _, _, pid, cur_rank, max_rank = strfind(skill, "^(%d+):([0-9%-]+):([0-9%-]+)$");
								if pid then
									pid = tonumber(pid);
									cur_rank = tonumber(cur_rank);
									max_rank = tonumber(max_rank);
									cmm[pid] = { cur_rank, max_rank, };
								end
							end
						end
					elseif control_code == ADDON_MSG_QUERY_RECIPE then
						if name ~= PLAYER_NAME then
							local sid = tonumber(body);
							if sid then
								local pid = NS.db_get_pid_by_sid(sid);
								if pid then
									local reply = PLAYER_GUID;
									local found = false;
									for GUID, VAR in next, AVAR do
										local var = rawget(VAR, pid);
										if var and var[2] and var[2][sid] then
											reply = reply .. "#" .. GUID;
											found = true;
										end
									end
									if found then
										SendAddonMessage(ADDON_PREFIX, ADDON_MSG_REPLY_RECIPE .. "#" .. sid .. "#" .. reply, "WHISPER", sender);
									end
								end
							end
						end
					elseif control_code == ADDON_MSG_REPLY_RECIPE then
						local _, _, sid, rGUID, val = strfind(body, "^([0-9]+)#([^#]+)#(.+)$");
						if sid then
							sid = tonumber(sid);
							if sid and NS.db_is_tradeskill_sid(sid) then
								local cid = NS.db_get_cid_by_sid(sid);
								local result = queried_sid[sid](rGUID);
								local data = { strsplit("#", val) };
								local output = get_PlayerLink(rGUID);
								local ok = output ~= nil;
								output = output ~= nil and (output .. ":");
								for index = 1, #data do
									local mGUID = data[index];
									result[mGUID] = true;
									-- print(rGUID, mGUID, GetPlayerInfoByGUID(mGUID));
									if ok then
										local name = get_ColoredName(mGUID);
										if name ~= nil then
											output = output .. " " .. name;
										else
											ok = false;
										end
									end
								end
								if ok then
									local link = cid and (NS.db_item_link_s(cid)) or NS.enchant_link(sid);
									if link then
										print(link, output);
									end
								end
							end
						end
					elseif control_code == ADDON_MSG_QUERY_SKILL_RECIPES then
					elseif control_code == ADDON_MSG_REPLY_SKILL_RECIPES then
					elseif control_code == ADDON_MSG_BROADCAST_BEGIN then
					elseif control_code == ADDON_MSG_BROADCAST_BODY then
					elseif control_code == ADDON_MSG_BROADCAST_END then
					end
				end
			end
		end
		NS.CHAT_MSG_ADDON_LOGGED = NS.CHAT_MSG_ADDON;
		function NS.cmm_Query_sid(sid)
			local t = GetServerTime();
			if IsInGuild() then
				SendAddonMessage(ADDON_PREFIX, ADDON_MSG_QUERY_RECIPE .. "#" .. sid, "GUILD");
			end
		end
		function NS.cmm_Broadcast(pid, list, channel, target)
			tinsert(queue_guild_msg, ADDON_MSG_BROADCAST_BEGIN .. "#" .. pid .. "#" .. #list);
			local msg = ADDON_MSG_BROADCAST_BODY .. "#".. pid;
			for index = 1, #list do
				msg = msg .. "#" .. list[index];
				if index % 40 == 0 then
					tinsert(queue_guild_msg, msg);
					msg = ADDON_MSG_BROADCAST_BODY .. "#" .. pid;
				end
			end
			--	#msg <= 250
			tinsert(queue_guild_msg, ADDON_MSG_BROADCAST_END .. "#" .. pid);
		end
		function NS.cmm_InitAddonMessage()
			if RegisterAddonMessagePrefix(ADDON_PREFIX) then
				_EventHandler:RegEvent("CHAT_MSG_ADDON");
				_EventHandler:RegEvent("CHAT_MSG_ADDON_LOGGED");
				do
					-- C_Timer.NewTicker(0.1, function()
					-- 	if IsInGuild() then
					-- 		local work = tremove(queue_guild_msg, 1);
					-- 		if work then
					-- 			SendAddonMessage(ADDON_PREFIX, work, "GUILD");
					-- 		end
					-- 	end
					-- end);
					-- C_Timer.NewTicker(0.02, function()
					-- 	if IsInGuild() then
					-- 		local work = tremove(queue_whisper_msg, 1);
					-- 		if work then
					-- 			SendAddonMessage(ADDON_PREFIX, work[1], "GUILD", work[2]);
					-- 		end
					-- 	end
					-- end);
					C_Timer.NewTicker(60.0, skill_broadcast);
				end
			else
				_error_("RegisterAddonMessagePrefix", ADDON_PREFIX);
			end
		end
	end

	function NS.USER_EVENT_SPELL_DATA_LOADED()
		NS.SKILL_LINES_CHANGED();
	end
	function NS.USER_EVENT_ITEM_DATA_LOADED()
	end
	function NS.USER_EVENT_RECIPE_LIST_UPDATE()
		NS.ui_update_all();
	end

	do	--	ElvUI
		function NS.ElvUI_Blizzard_TradeSkillUI()
			local t = gui.Blizzard_TradeSkillUI;
			if t and ElvUI and ElvUI[1] then
				local S = ElvUI[1]:GetModule('Skins');
				if S then
					if t.call then
						S:HandleButton(t.call);
						-- if t.profitFrame and t.profitFrame.costOnly then
							-- S:HandleCheckBox(t.profitFrame.costOnly);
						-- end
						NS.ElvUI_Blizzard_TradeSkillUI = _noop_;
					end
				end
			end
		end
		function NS.ElvUI_Blizzard_CraftUI()
			local c = gui.Blizzard_CraftUI;
			if c and ElvUI and ElvUI[1] then
				local S = ElvUI[1]:GetModule('Skins');
				if S then
					if c.call then
						S:HandleButton(c.call);
						-- if c.profitFrame and c.profitFrame.costOnly then
						-- 	S:HandleCheckBox(c.profitFrame.costOnly);
						-- end
						NS.ElvUI_Blizzard_CraftUI = _noop_;
					end
				end
			end
		end
		function NS.ElvUI()
			NS.ElvUI_Blizzard_TradeSkillUI();
			NS.ElvUI_Blizzard_CraftUI();
		end
	end

	do	--	CloudyTradeSkill
		function NS.CloudyTradeSkill_Blizzard_TradeSkillUI()
			C_Timer.After(1.0, function()
				local t = gui.Blizzard_TradeSkillUI;
				local opt = _G["CTSOption-TradeSkillFrame"];
				if t and opt and t.call then
					t.call:ClearAllPoints();
					t.call:SetPoint("RIGHT", opt, "LEFT", -2, 0);
				end
			end);
		end
		function NS.CloudyTradeSkill_Blizzard_CraftUI()
			C_Timer.After(1.0, function()
				local c = gui.Blizzard_CraftUI;
				local opt = _G["CTSOption-CraftFrame"];
				if c and opt and c.call then
					c.call:ClearAllPoints();
					c.call:SetPoint("RIGHT", opt, "LEFT", -2, 0);
				end
			end);
		end
		function NS.CloudyTradeSkill()
			NS.CloudyTradeSkill_Blizzard_TradeSkillUI();
			NS.CloudyTradeSkill_Blizzard_CraftUI();
		end
	end

	do	--	mtsl
		function NS.toggle_mtsl(hide)
			if hide then
				MTSLUI_TOGGLE_BUTTON.ui_frame:SetAlpha(0);
				MTSLUI_TOGGLE_BUTTON.ui_frame:EnableMouse(false);
				MTSLUI_TOGGLE_BUTTON.ui_frame:Hide();
				MTSLUI_MISSING_TRADESKILLS_FRAME.ui_frame:SetAlpha(0);
				MTSLUI_MISSING_TRADESKILLS_FRAME.ui_frame:EnableMouse(false);
				MTSLUI_MISSING_TRADESKILLS_FRAME.ui_frame:Hide();
			else
				MTSLUI_TOGGLE_BUTTON.ui_frame:SetAlpha(1);
				MTSLUI_TOGGLE_BUTTON.ui_frame:EnableMouse(true);
				MTSLUI_TOGGLE_BUTTON.ui_frame:Show();
				MTSLUI_MISSING_TRADESKILLS_FRAME.ui_frame:SetAlpha(1);
				MTSLUI_MISSING_TRADESKILLS_FRAME.ui_frame:EnableMouse(true);
				-- MTSLUI_MISSING_TRADESKILLS_FRAME.ui_frame:Show();
			end
		end
		function NS.hide_mtsl(val)
			if IsAddOnLoaded("MissingTradeSkillsList") then
				NS.toggle_mtsl(val);
			end
		end
	end

	do	--	ADDON_LOADED
		local handler_table = {
			["ElvUI"] = NS.ElvUI,
			["CloudyTradeSkill"] = NS.CloudyTradeSkill,
			["MissingTradeSkillsList"] = function()
				if SET then
					C_Timer.After(1.0, NS.hide_mtsl(SET.hide_mtsl));
				end
			end,
			["alaTrade"] = function()
				merc = __ala_meta__.merc;
				NS.merc_RegAllFrames();
			end,
			["Auctionator"] = function()
				merc = NS.meta_alt_merc_Auctionator();
				NS.merc_RegAllFrames();
			end,
			["aux-addon"] = function()
				merc = NS.meta_alt_merc_aux();
				NS.merc_RegAllFrames();
			end,
			["AuctionFaster"] = function()
				merc = NS.meta_alt_merc_AuctionFaster();
				NS.merc_RegAllFrames();
			end,
			["AuctionMaster"] = function()
				merc = NS.meta_alt_merc_AuctionMaster();
				NS.merc_RegAllFrames();
			end,
			["Leatrix_Plus"] = function()
				if LeaPlusDB then
					LeaPlusDB["EnhanceProfessions"] = "Off";
				end
			end,
		};
		function NS.ADDON_LOADED(addon)
			local handler = handler_table[addon];
			if handler then
				handler(addon);
			end
		end
		function NS.add_AddonLoadedHandler(addon, handler)
			handler_table[addon] = handler;
		end
	end

	--	ui
		function NS.ui_toggleGUI(key, on)
			local frame = gui[key];
			if frame then
				if frame:IsShown() or on == false then
					frame:Hide();
					return false;
				else
					frame:Show();
					return true;
				end
			end
		end
		function NS.ui_toggleCall(on)
			local t = gui["Blizzard_TradeSkillUI"];
			if t then
				if on then
					t.call:Show();
				else
					t.call:Hide();
				end
			end
			local c = gui["Blizzard_CraftUI"];
			if c then
				if on then
					c.call:Show();
				else
					c.call:Hide();
				end
			end
		end
		function NS.ui_toggleTab(on)
			local t = gui["Blizzard_TradeSkillUI"];
			if t then
				if on then
					t.tabFrame:Show();
				else
					t.tabFrame:Hide();
				end
				t:ShowSetFrame(false);
			end
			local c = gui["Blizzard_CraftUI"];
			if c then
				if on then
					c.tabFrame:Show();
				else
					c.tabFrame:Hide();
				end
				c:ShowSetFrame(false);
			end
		end
		function NS.ui_togglePortraitButton(on)
			local t = gui["Blizzard_TradeSkillUI"];
			if t then
				if on then
					t.switch:Show();
				else
					t.switch:Hide();
				end
			end
			local c = gui["Blizzard_CraftUI"];
			if c then
				if on then
					c.switch:Show();
				else
					c.switch:Hide();
				end
			end
		end
		function NS.ui_lock_board(on)
			if on then
				gui["BOARD"]:lock();
			else
				gui["BOARD"]:unlock();
			end
		end
		function NS.ui_update_all()
			local t = gui["Blizzard_TradeSkillUI"];
			if t then
				t:update_func();
			end
			local c = gui["Blizzard_CraftUI"];
			if c then
				c:update_func();
			end
			gui["EXPLORER"]:update_func();
			-- gui["CONFIG"]:update_func();
		end
		function NS.ui_refresh_all()
			local t = gui["Blizzard_TradeSkillUI"];
			if t then
				t.scroll:Update();
				local p = t.profitFrame;
				if p then
					p.scroll:Update();
				end
			end
			local c = gui["Blizzard_CraftUI"];
			if c then
				c.scroll:Update();
				local p = c.profitFrame;
				if p then
					p.scroll:Update();
				end
			end
			local e = gui["EXPLORER"];
			if e then
				e.scroll:Update();
				local p = e.profitFrame;
				if p then
					p.scroll:Update();
				end
			end
		end
		function NS.ui_refresh_style(loading)
			local t = gui["Blizzard_TradeSkillUI"];
			if t then
				t:BlzStyle(SET.blz_style, loading);
			end
			local c = gui["Blizzard_CraftUI"];
			if c then
				c:BlzStyle(SET.blz_style, loading);
			end
			local e = gui["EXPLORER"];
			if e then
				e:BlzStyle(SET.blz_style, loading);
			end
		end
		function NS.ui_refresh_config()
			gui["CONFIG"]:Refresh();
		end
	--

	function NS.ON_SET_CHANGED(key, val, loading)
		if key == 'expand' then
			local t = gui["Blizzard_TradeSkillUI"];
			if t then
				t:Expand(val);
			end
			local c = gui["Blizzard_CraftUI"];
			if c then
				c:Expand(val);
			end
		elseif key == 'blz_style' then
			NS.ui_refresh_style(loading);
		elseif key == 'bg_color' then
			NS.ui_refresh_style(loading);
		elseif key == 'show_tradeskill_frame_price_info' then
			local t = gui["Blizzard_TradeSkillUI"];
			if t then
				t:updatePriceInfoInFrame();
			end
			local c = gui["Blizzard_CraftUI"];
			if c then
				c:updatePriceInfoInFrame();
			end
		elseif key == 'show_tradeskill_frame_rank_info' then
			local t = gui["Blizzard_TradeSkillUI"];
			if t then
				t:updateRankInfoInFrame();
			end
			local c = gui["Blizzard_CraftUI"];
			if c then
				c:updateRankInfoInFrame();
			end
		elseif key == 'colored_rank_for_unknown' then
			NS.ui_refresh_all();
		elseif key == 'regular_exp' then
			for pid, set in next, SET do
				if NS.db_is_pid(pid) or pid == 'explorer' then
					set.update = true;
				end
			end
			NS.ui_update_all();
		elseif key == 'hide_mtsl' then
			NS.hide_mtsl(val);
		else
		end
		if not loading then
			NS.ui_refresh_config();
		end
	end
	function NS.init_regEvent()
		_EventHandler:RegEvent("SKILL_LINES_CHANGED");
		_EventHandler:RegEvent("NEW_RECIPE_LEARNED");
		_EventHandler:RegEvent("BAG_UPDATE_COOLDOWN");
	end
	function NS.init_hook()
	end
	function NS.init_createGUI()
		----	hook TradeSkillUI CraftUI
			if IsAddOnLoaded("Blizzard_TradeSkillUI") then
				NS.ui_hook_Blizzard_TradeSkillUI("Blizzard_TradeSkillUI");
			else
				NS.add_AddonLoadedHandler("Blizzard_TradeSkillUI", NS.ui_hook_Blizzard_TradeSkillUI);
			end
			if IsAddOnLoaded("Blizzard_CraftUI") then
				NS.ui_hook_Blizzard_CraftUI("Blizzard_CraftUI");
			else
				NS.add_AddonLoadedHandler("Blizzard_CraftUI", NS.ui_hook_Blizzard_CraftUI);
			end
		----
		_, gui["EXPLORER"] = safe_call(NS.ui_CreateExplorer);
		_, gui["CONFIG"] = safe_call(NS.ui_CreateConfigFrame);
		_, gui["BOARD"] = safe_call(NS.ui_CreateBoard);
	end

end

do	--	INITIALIZE
	local default_SET = {
		expand = false,
		blz_style = false,
		bg_color = { 0.0, 0.0, 0.0, 0.75, },
		show_tradeskill_frame_price_info = true,
		show_tradeskill_frame_rank_info = true,
		show_tradeskill_tip_craft_item_price = true,
		show_tradeskill_tip_craft_spell_price = true,
		show_tradeskill_tip_recipe_price = true,
		show_tradeskill_tip_recipe_account_learned = true,
		show_tradeskill_tip_material_craft_info = true,
		default_skill_button_tip = true,
		colored_rank_for_unknown = false,
		regular_exp = false,
		char_list = {  },
		show_call = true,
		show_tab = true,
		portrait_button = true,
		show_board = false,
		lock_board = false,
		board_pos = { "TOP", "UIParent", "BOTTOM", 260, 190, },
		hide_mtsl = false,
	};
	local default_set = {
		shown = true,
		showSet = false,
		showProfit = false,
		--
		showKnown = true,
		showUnkown = true,
		showHighRank = false,
		showItemInsteadOfSpell = false,
		showRank = true,
		haveMaterials = false,
		phase = curPhase,
		--
		searchText = "",
		searchNameOnly = false,
		--
		costOnly = false,
		--
	};
	local default_var = {
	};
	local default_explorer_set = {
		showSet = true,
		showProfit = false,
		--
		showKnown = true,
		showUnkown = false,
		showHighRank = false,
		showItemInsteadOfSpell = false,
		showRank = true,
		phase = curPhase,
		--
		filter = {
			-- realm = nil,
			skill = nil,
			type = nil,
			subType = nil,
			eqLoc = nil,
		},
		searchText = "",
		--
		-- costOnly = false,
	};
	function NS.MODIFY_SAVED_VARIABLE()
		if alaTradeSkillSV == nil or alaTradeSkillSV._version == nil or alaTradeSkillSV._version < 210605.1 then
			_G.alaTradeSkillSV = {
				set = {
					explorer = default_explorer_set,
				},
				var = {  },
				fav = alaTradeSkillSV ~= nil and alaTradeSkillSV.fav or {  },
				cmm = {  },
			};
		else
		end
		alaTradeSkillSV._version = 210605.1;
		SET = setmetatable(alaTradeSkillSV.set, {
			__index = function(t, pid)
				if NS.db_is_pid(pid) then
					local temp = Mixin({  }, default_set);
					t[pid] = temp;
					return temp;
				end
				return nil;
			end,
		});
		for key, val in next, default_SET do
			if rawget(SET, key) == nil then
				rawset(SET, key, val);
			end
		end
		for pid, set in next, SET do
			if NS.db_is_pid(pid) or pid == 'explorer' then
				set.update = true;
				if set.phase == nil or set.phase < curPhase then
					set.phase = curPhase;
				end
			end
		end
		AVAR = alaTradeSkillSV.var;
		for index = 1, #SET.char_list do
			if AVAR[SET.char_list[index]] == nil then
				SET.char_list[index] = nil;
			end
		end
		for GUID, VAR in next, AVAR do
			for pid = NS.db_min_pid(), NS.db_max_pid() do
				local var = rawget(VAR, pid);
				if var and NS.db_is_pid(pid) then
					var.cur_rank = var.cur_rank or "-";
					var.max_rank = var.max_rank or "-";
				end
			end
			local found = false;
			for index = 1, #SET.char_list do
				if SET.char_list[index] == GUID then
					found = true;
					break;
				end
			end
			if not found then
				tinsert(SET.char_list, GUID);
			end
		end
		if AVAR[PLAYER_GUID] == nil then
			NS.func_add_char(PLAYER_GUID, { realm_id = PLAYER_REALM_ID, realm_name = PLAYER_REALM_NAME, supreme_list = {  }, }, true);
		end
		VAR = setmetatable(AVAR[PLAYER_GUID], {
			__index = function(t, pid)
				if NS.db_is_pid(pid) then
					local temp = { {  }, {  }, update = true, };
					t[pid] = temp;
					return temp;
				else
					return default_var[pid];
				end
			end,
		});
		for pid = NS.db_min_pid(), NS.db_max_pid() do
			local var = rawget(VAR, pid);
			if var and NS.db_is_pid(pid) then
				var.update = true;
			end
		end
		FAV = alaTradeSkillSV.fav;
		CMM = alaTradeSkillSV.cmm[PLAYER_REALM_ID];
		if CMM == nil then
			CMM = {  };
			alaTradeSkillSV.cmm[PLAYER_REALM_ID] = CMM;
		end
	end
	local initialized = false;
	local function init()
		DisableAddOn("alaTradeFrame");
		if initialized then
			return;
		else
			initialized = true;
		end
		local success, err;
		safe_call(NS.db_init);		--	!!!must be run earlier than any others!!!
		success = safe_call(NS.MODIFY_SAVED_VARIABLE);
		if not success then
			local fav = alaTradeSkillSV.fav;
			alaTradeSkillSV = nil;
			success, err = safe_call(NS.MODIFY_SAVED_VARIABLE);
			if success then
				if type(fav) == 'table' then
					FAV = fav;
					alaTradeSkillSV.fav = fav;
				end
			else
				print("\124cffff0000alaTradeSkill fetal error", err);
			end
		end
		safe_call(NS.init_hash_known_recipe);
		safe_call(NS.init_regEvent);
		safe_call(NS.init_hook);
		safe_call(NS.init_createGUI);
		safe_call(NS.hook_tooltip);
		for GUID, _ in next, AVAR do
			GetPlayerInfoByGUID(GUID);
		end
		safe_call(NS.cmm_InitAddonMessage);
		merc = merc or __ala_meta__.merc or NS.meta_alt_merc_Auctionator() or NS.meta_alt_merc_aux() or NS.meta_alt_merc_AuctionFaster() or NS.meta_alt_merc_AuctionMaster();
		for key, val in next, SET do
			if type(val) ~= 'table' then
				NS.ON_SET_CHANGED(key, val, true);
			end
		end
		if __ala_meta__.initpublic then __ala_meta__.initpublic(); end
	end
	function NS.PLAYER_ENTERING_WORLD()
		_EventHandler:UnregEvent("PLAYER_ENTERING_WORLD");
		C_Timer.After(1.0, init);
	end
	function NS.LOADING_SCREEN_ENABLED()
		_EventHandler:UnregEvent("LOADING_SCREEN_ENABLED");
	end
	function NS.LOADING_SCREEN_DISABLED()
		_EventHandler:UnregEvent("LOADING_SCREEN_DISABLED");
		C_Timer.After(1.0, init);
	end
	-- _EventHandler:RegEvent("PLAYER_ENTERING_WORLD");
	-- _EventHandler:RegEvent("LOADING_SCREEN_ENABLED");
	_EventHandler:RegEvent("LOADING_SCREEN_DISABLED");
	_EventHandler:RegEvent("ADDON_LOADED");
	-->		fix for Leatrix_Plus
		function NS.VARIABLES_LOADED()
			_EventHandler:UnregEvent("VARIABLES_LOADED");
			if LeaPlusDB then
				LeaPlusDB["EnhanceProfessions"] = "Off";
			end
		end
		function NS.PLAYER_LOGIN()
			_EventHandler:UnregEvent("PLAYER_LOGIN");
			if LeaPlusDB then
				LeaPlusDB["EnhanceProfessions"] = "Off";
			end
		end
		_EventHandler:RegEvent("VARIABLES_LOADED");
		_EventHandler:RegEvent("PLAYER_LOGIN");
	-->
end

do	--	SLASH
	local function set_handler(cmd, val)
		if cmd[6] then
			val = cmd[6](val);
		end
		if val ~= nil then
			if SET[cmd[3]] ~= val then
				if not cmd.donotset then
					SET[cmd[3]] = val;
				end
				if cmd[4] then
					if type(cmd[4]) == 'function' then
						print(cmd[4](cmd[3], val));
					else
						print(cmd[4], val);
					end
				else
					print(cmd[3], val);
				end
				if cmd[5] then
					cmd[5](cmd[3], val);
				end
				NS.ON_SET_CHANGED(cmd[3], val);
			end
		else
			print(L["INVALID_COMMANDS"]);
		end
	end
	--	pattern, key, note, func(key, val)
	local SEPARATOR = "[ %`%~%!%@%#%$%%%^%&%*%(%)%-%_%=%+%[%{%]%}%\\%|%;%:%\'%\"%,%<%.%>%/%?]*";
	--	1type, 2pattern, 3key, 4note(string or func), 5proc_func(key, val), 6func_to_mod_val, 7config_type(nil for check), 8cmd_for_config / drop_meta, 9para[slider:{min, max, step}], 10sub_config_on_val
	NS.set_cmd_list = {
		{	--	expand
			'bool',
			"^expand" .. SEPARATOR .. "(.*)" .. SEPARATOR .. "$",
			"expand",
			L.SLASH_NOTE["expand"],
			nil,
			[8] = function(self)
				if self:GetChecked() then
					SlashCmdList["ALATRADEFRAME"]("setexpand1");
				else
					SlashCmdList["ALATRADEFRAME"]("setexpand0");
				end
			end,
		},
		{	--	blz_style
			'bool',
			"^blz" .. SEPARATOR .. "style" .. SEPARATOR .. "(.*)" .. SEPARATOR .. "$",
			"blz_style",
			L.SLASH_NOTE["blz_style"],
			nil,
			[8] = function(self)
				if self:GetChecked() then
					SlashCmdList["ALATRADEFRAME"]("setblzstyle1");
				else
					SlashCmdList["ALATRADEFRAME"]("setblzstyle0");
				end
			end,
			[10] = {
				[false] = {
					'table',
					nil,
					'bg_color',
					L.SLASH_NOTE["bg_color"],
					[7] = 'color4',
					[8] = function(r, g, b, a)
						SET.bg_color = { r or 1.0, g or 1.0, b or 1.0, a or 1.0, };
						NS.ON_SET_CHANGED('bg_color', SET.bg_color);
					end,
				},
			},
		},
		{	--	show_tradeskill_frame_price_info
			'bool',
			"^price" .. SEPARATOR .. "info" .. SEPARATOR .. "(.*)" .. SEPARATOR .. "$",
			"show_tradeskill_frame_price_info",
			L.SLASH_NOTE["show_tradeskill_frame_price_info"],
			nil,
			[8] = function(self)
				if self:GetChecked() then
					SlashCmdList["ALATRADEFRAME"]("setpriceinfo1");
				else
					SlashCmdList["ALATRADEFRAME"]("setpriceinfo0");
				end
			end,
		},
		{	--	show_tradeskill_frame_rank_info
			'bool',
			"^rank" .. SEPARATOR .. "(.*)" .. SEPARATOR .. "$",
			"show_tradeskill_frame_rank_info",
			L.SLASH_NOTE["show_tradeskill_frame_rank_info"],
			nil,
			[8] = function(self)
				if self:GetChecked() then
					SlashCmdList["ALATRADEFRAME"]("setrank1");
				else
					SlashCmdList["ALATRADEFRAME"]("setrank0");
				end
			end,
		},
		{	--	show_tradeskill_tip_craft_item_price
			'bool',
			"^tip" .. SEPARATOR .. "item" .. SEPARATOR .. "(.*)" .. SEPARATOR .. "$",
			"show_tradeskill_tip_craft_item_price",
			L.SLASH_NOTE["show_tradeskill_tip_craft_item_price"],
			nil,
			[8] = function(self)
				if self:GetChecked() then
					SlashCmdList["ALATRADEFRAME"]("settipitem1");
				else
					SlashCmdList["ALATRADEFRAME"]("settipitem0");
				end
			end,
		},
		{	--	show_tradeskill_tip_craft_spell_price
			'bool',
			"^tip" .. SEPARATOR .. "spell" .. SEPARATOR .. "(.*)" .. SEPARATOR .. "$",
			"show_tradeskill_tip_craft_spell_price",
			L.SLASH_NOTE["show_tradeskill_tip_craft_spell_price"],
			nil,
			[8] = function(self)
				if self:GetChecked() then
					SlashCmdList["ALATRADEFRAME"]("settipspell1");
				else
					SlashCmdList["ALATRADEFRAME"]("settipspell0");
				end
			end,
		},
		{	--	show_tradeskill_tip_recipe_price
			'bool',
			"^tip" .. SEPARATOR .. "recipe" .. SEPARATOR .. "(.*)" .. SEPARATOR .. "$",
			"show_tradeskill_tip_recipe_price",
			L.SLASH_NOTE["show_tradeskill_tip_recipe_price"],
			nil,
			[8] = function(self)
				if self:GetChecked() then
					SlashCmdList["ALATRADEFRAME"]("settiprecipe1");
				else
					SlashCmdList["ALATRADEFRAME"]("settiprecipe0");
				end
			end,
		},
		{	--	show_tradeskill_tip_recipe_account_learned
			'bool',
			"^tip" .. SEPARATOR .. "learned" .. SEPARATOR .. "(.*)" .. SEPARATOR .. "$",
			"show_tradeskill_tip_recipe_account_learned",
			L.SLASH_NOTE["show_tradeskill_tip_recipe_account_learned"],
			nil,
			[8] = function(self)
				if self:GetChecked() then
					SlashCmdList["ALATRADEFRAME"]("settiplearned1");
				else
					SlashCmdList["ALATRADEFRAME"]("settiplearned0");
				end
			end,
		},
		{	--	show_tradeskill_tip_material_craft_info
			'bool',
			"^tip" .. SEPARATOR .. "material" .. SEPARATOR .. "(.*)" .. SEPARATOR .. "$",
			"show_tradeskill_tip_material_craft_info",
			L.SLASH_NOTE["show_tradeskill_tip_material_craft_info"],
			nil,
			[8] = function(self)
				if self:GetChecked() then
					SlashCmdList["ALATRADEFRAME"]("settipmaterial1");
				else
					SlashCmdList["ALATRADEFRAME"]("settipmaterial0");
				end
			end,
		},
		{	--	default_skill_button_tip
			'bool',
			"^tip" .. SEPARATOR .. "default" .. SEPARATOR .. "(.*)" .. SEPARATOR .. "$",
			"default_skill_button_tip",
			L.SLASH_NOTE["default_skill_button_tip"],
			nil,
			[8] = function(self)
				if self:GetChecked() then
					SlashCmdList["ALATRADEFRAME"]("settipdefault1");
				else
					SlashCmdList["ALATRADEFRAME"]("settipdefault0");
				end
			end,
		},
		{	--	colored_rank_for_unknown
			'bool',
			"^style" .. SEPARATOR .. "(.*)" .. SEPARATOR .. "$",
			"colored_rank_for_unknown",
			L.SLASH_NOTE["colored_rank_for_unknown"],
			nil,
			[8] = function(self)
				if self:GetChecked() then
					SlashCmdList["ALATRADEFRAME"]("setstyle1");
				else
					SlashCmdList["ALATRADEFRAME"]("setstyle0");
				end
			end,
		},
		{	--	regular_exp
			'bool',
			"^regular" .. SEPARATOR .. "expression" .. SEPARATOR .. "(.*)" .. SEPARATOR .. "$",
			"regular_exp",
			L.SLASH_NOTE["regular_exp"],
			nil,
			[8] = function(self)
				if self:GetChecked() then
					SlashCmdList["ALATRADEFRAME"]("setregularexpression1");
				else
					SlashCmdList["ALATRADEFRAME"]("setregularexpression0");
				end
			end,
		},
		{	--	show_call
			'bool',
			"^show" .. SEPARATOR .. "call" .. SEPARATOR .. "(.+)" .. SEPARATOR .. "$",
			"show_call",
			L.SLASH_NOTE["show_call"],
			function(key, val)
				NS.ui_toggleCall(val);
			end,
			[8] = function(self)
				if self:GetChecked() then
					SlashCmdList["ALATRADEFRAME"]("setshowcall1");
				else
					SlashCmdList["ALATRADEFRAME"]("setshowcall0");
				end
			end,
		},
		{	--	show_tab
			'bool',
			"^show" .. SEPARATOR .. "tab" .. SEPARATOR .. "(.+)" .. SEPARATOR .. "$",
			"show_tab",
			L.SLASH_NOTE["show_tab"],
			function(key, val)
				NS.ui_toggleTab(val);
			end,
			[8] = function(self)
				if self:GetChecked() then
					SlashCmdList["ALATRADEFRAME"]("setshowtab1");
				else
					SlashCmdList["ALATRADEFRAME"]("setshowtab0");
				end
			end,
		},
		{	--	portrait_button
			'bool',
			"^portrait" .. SEPARATOR .. "(.+)" .. SEPARATOR .. "$",
			"portrait_button",
			L.SLASH_NOTE["portrait_button"],
			function(key, val)
				NS.ui_togglePortraitButton(val);
			end,
			[8] = function(self)
				if self:GetChecked() then
					SlashCmdList["ALATRADEFRAME"]("setportrait1");
				else
					SlashCmdList["ALATRADEFRAME"]("setportrait0");
				end
			end,
		},
		{	--	show_board		--	save var by itself
			'bool',
			"^show" .. SEPARATOR .. "board" .. SEPARATOR .. "(.+)" .. SEPARATOR .. "$",
			"show_board",
			L.SLASH_NOTE["show_board"],
			function(key, val)
				NS.ui_toggleGUI("BOARD", val);
			end,
			[8] = function(self)
				if self:GetChecked() then
					SlashCmdList["ALATRADEFRAME"]("setshowboard1");
				else
					SlashCmdList["ALATRADEFRAME"]("setshowboard0");
				end
			end,
		},
		{	--	lock_board		--	save var by itself
			'bool',
			"^lock" .. SEPARATOR .. "board" .. SEPARATOR .. "(.+)" .. SEPARATOR .. "$",
			"lock_board",
			L.SLASH_NOTE["lock_board"],
			function(key, val)
				NS.ui_lock_board(val);
			end,
			[8] = function(self)
				if self:GetChecked() then
					SlashCmdList["ALATRADEFRAME"]("setlockboard1");
				else
					SlashCmdList["ALATRADEFRAME"]("setlockboard0");
				end
			end,
		},
		{	--	hide_mtsl
			'bool',
			"^hide" .. SEPARATOR .. "mtsl" .. SEPARATOR .. "(.+)" .. SEPARATOR .. "$",
			"hide_mtsl",
			L.SLASH_NOTE["hide_mtsl"],
			nil,
			[8] = function(self)
				if self:GetChecked() then
					SlashCmdList["ALATRADEFRAME"]("sethidemtsl1");
				else
					SlashCmdList["ALATRADEFRAME"]("sethidemtsl0");
				end
			end,
		},
	};
	_G.SLASH_ALATRADEFRAME1 = "/alatradeframe";
	_G.SLASH_ALATRADEFRAME2 = "/alatf";
	_G.SLASH_ALATRADEFRAME3 = "/atf";
	local SET_PATTERN = "^" .. SEPARATOR .. "set" .. SEPARATOR .. "(.+)" .. SEPARATOR .. "$";
	local UI_PATTERN = "^" .. SEPARATOR .. "ui" .. SEPARATOR .. "(.+)" .. SEPARATOR .. "$";
	local DUMP_PATTERN = "^" .. SEPARATOR .. "dump" .. SEPARATOR .. "(.+)" .. SEPARATOR .. "$";
	SlashCmdList["ALATRADEFRAME"] = function(msg)
		msg = strlower(msg);
		--	set
		local _, pattern;
		_, _, pattern = strfind(msg, SET_PATTERN);
		if pattern then
			local set_cmd_list = NS.set_cmd_list;
			for index = 1, #set_cmd_list do
				local cmd = set_cmd_list[index];
				local _, _, pattern2 = strfind(pattern, cmd[2]);
				if pattern2 then
					if cmd[1] == 'bool' then
						local val = nil;
						if pattern2 == "true" or pattern2 == "ture" or pattern2 == "treu" or pattern2 == "1" or pattern2 == "on" or pattern2 == "enable" then
							val = true;
						elseif pattern2 == "false" or pattern2 == "flase" or pattern2 == "fales" or pattern2 == "0" or pattern2 == "off" or pattern2 == "disable" then
							val = false;
						end
						if cmd[6] then
							val = cmd[6](val);
						end
						if val ~= nil then
							if SET[cmd[3]] ~= val then
								if not cmd.donotset then
									SET[cmd[3]] = val;
								end
								if cmd[4] then
									if type(cmd[4]) == 'function' then
										print(cmd[4](cmd[3], val));
									else
										print(cmd[4], val);
									end
								else
									print(cmd[3], val);
								end
								if cmd[5] then
									cmd[5](cmd[3], val);
								end
								NS.ON_SET_CHANGED(cmd[3], val);
							end
						else
							print(L["INVALID_COMMANDS"]);
						end
					elseif cmd[1] == 'num' then
						local val = tonumber(pattern2);
						if val then
							if cmd[6] then
								val = cmd[6](val);
							end
							if val then
								if SET[cmd[3]] ~= val then
									if not cmd.donotset then
										SET[cmd[3]] = val;
									end
									if cmd[4] then
										if type(cmd[4]) == 'function' then
											print(cmd[4](cmd[3], val));
										else
											print(cmd[4], val);
										end
									else
										print(cmd[3], val);
									end
									if cmd[5] then
										cmd[5](cmd[3], val);
									end
									NS.ON_SET_CHANGED(cmd[3], val);
								end
							else
								print("\124cffff0000Invalid parameter: ", pattern2);
							end
						end
					end
					return;
				end
			end
			return;
		end
		_, _, pattern = strfind(msg, UI_PATTERN);
		if pattern then
			if strfind(pattern, 'exp') then
				NS.ui_toggleGUI("EXPLORER");
			elseif strfind(pattern, 'conf') then
				NS.ui_toggleGUI("CONFIG");
			end
			return;
		end
		_, _, pattern = strfind(msg, DUMP_PATTERN);
		if pattern then
			print("PriceDB Status: ", merc ~= nil);
			return;
		end
		--	default
		if strfind(msg, "[A-Za-z0-9]+" ) then
			print("Invalid command: [[", msg, "]] Use: ");
			print("  /atf setexpand on/off");
			print("  /atf setblzstyle on/off");
			print("  /atf setpriceinfo on/off");
			print("  /atf setrank on/off");
			print("  /atf settipitem on/off");
			print("  /atf settipspell on/off");
			print("  /atf settiprecipe on/off");
			print("  /atf settiplearned on/off");
			print("  /atf settipmaterial on/off");
			print("  /atf settipdefault on/off");
			print("  /atf setstyle on/off");
			print("  /atf setregularexpression on/off");
			print("  /atf setshowcall on/off");
			print("  /atf setshowtab on/off");
			print("  /atf setportrait on/off");
			print("  /atf setshowboard on/off");
			print("  /atf setlockboard on/off");
			print("  /atf sethidemtsl on/off");
		else
			-- NS.ui_toggleGUI("CONFIG");
			NS.ui_toggleGUI("CONFIG");
		end
	end
end

do	--	run_on_next_tick	--	execute two ticks later
	local min_ticker_duration = 0.1;
	if false then	--	a universal method, unnecessary here
		local DELAY = 5;
		local delay_run_funcs = {  };
		for index = 1, DELAY do
			delay_run_funcs[index] = {  };
		end
		local timer = 0.0;
		local function delay_run_handler(self, elasped)
			timer = timer + elasped;
			if timer >= min_ticker_duration * DELAY then
				timer = 0.0;
				local funcs = delay_run_funcs[1];
				while true do
					local func = tremove(funcs, 1);
					if func then
						func();
					else
						break;
					end
				end
				for index = 2, DELAY do
					if #delay_run_funcs[index] > 0 then
						tinsert(delay_run_funcs, tremove(delay_run_funcs));
						return;
					end
				end
				_EventHandler:SetScript("OnUpdate", nil);
			end
		end
		function _EventHandler:delay_run(func, delay)
			delay = delay and max(min(delay, DELAY), 1) or 1;
			local dIndex = DELAY - delay + 1;
			for index = 1, DELAY do
				if index ~= dIndex then
					local funcs = delay_run_funcs[index];
					for i = 1, #funcs do
						if func == funcs[i] then
							tremove(funcs, i);
							break;
						end
					end
				end
			end
			local funcs = delay_run_funcs[dIndex];
			for index = 1, #funcs do
				if func == funcs[index] then
					return;
				end
			end
			tinsert(funcs, func);
			_EventHandler:SetScript("OnUpdate", delay_run_handler);
		end
		function _EventHandler:frame_delay_update(frame, delay)
			_EventHandler:delay_run(frame.update_func, delay);
		end
	end
	--
	local run_on_next_tick_func_1 = {  };
	local run_on_next_tick_func_2 = {  };
	local timer = 0.0;
	local function run_on_next_tick_handler(self, elasped)
		timer = timer + elasped;
		if timer >= min_ticker_duration * 2 then
			timer = 0.0;
			while true do
				local func = tremove(run_on_next_tick_func_1, 1);
				if func then
					func();
				else
					break;
				end
			end
			if #run_on_next_tick_func_1 + #run_on_next_tick_func_2 == 0 then
				_EventHandler:SetScript("OnUpdate", nil);
			else
				run_on_next_tick_func_1, run_on_next_tick_func_2 = run_on_next_tick_func_2, run_on_next_tick_func_1;
			end
		end
	end
	function _EventHandler:run_on_next_tick(func)
		for index = 1, #run_on_next_tick_func_1 do
			if func == run_on_next_tick_func_1[index] then
				tremove(run_on_next_tick_func_1, index);
				break;
			end
		end
		for index = 1, #run_on_next_tick_func_2 do
			if func == run_on_next_tick_func_2[index] then
				return;
			end
		end
		tinsert(run_on_next_tick_func_2, func);
		_EventHandler:SetScript("OnUpdate", run_on_next_tick_handler);
	end
	function _EventHandler:frame_update_on_next_tick(frame)
		_EventHandler:run_on_next_tick(frame.update_func);
	end
end

local extern_setting = {  };
__ala_meta__.prof.extern_setting = extern_setting;
do	--	EXTERN SETTING
	function extern_setting.toggle_tradeskill_frame_rank(on)
		SET.show_tradeskill_frame_rank_info = on;
		NS.ON_SET_CHANGED('show_tradeskill_frame_rank_info', on);
	end
	function extern_setting.toggle_tradeskill_frame_price_info(on)
		SET.show_tradeskill_frame_price_info = on;
		NS.ON_SET_CHANGED('show_tradeskill_frame_price_info', on);
	end
	function extern_setting.toggle_tradeskill_tip_craft_spell_price(on)
		SET.show_tradeskill_tip_craft_spell_price = on;
	end
	function extern_setting.toggle_tradeskill_tip_craft_item_price(on)
		SET.show_tradeskill_tip_craft_item_price = on;
	end
	function extern_setting.toggle_tradeskill_tip_recipe_price(on)
		SET.show_tradeskill_tip_recipe_price = on;
	end
	function extern_setting.toggle_tradeskill_tip_recipe_account_learned(on)
		SET.show_tradeskill_tip_recipe_account_learned = on;
	end
	function extern_setting.toggle_tradeskill_board_shown(on)
		SET.show_board = on;
		NS.ui_toggleGUI("BOARD", on);
	end
	function extern_setting.toggle_tradeskill_board_lock(on)
		SET.lock_board = on;
		NS.ui_lock_board(on);
	end
	function extern_setting.toggle_tradeskill_blz_style(on)
		SET.blz_style = on;
		NS.ui_refresh_style();
	end

	function extern_setting.set_tradeskill_bg_color(r, g, b, a)
		SET.bg_color[1] = r or SET.bg_color[1];
		SET.bg_color[2] = g or SET.bg_color[2];
		SET.bg_color[3] = b or SET.bg_color[3];
		SET.bg_color[4] = a or SET.bg_color[4];
		NS.ON_SET_CHANGED('bg_color', SET.bg_color);
	end

	function extern_setting.get_tradeskill_frame_price_info()
		return SET.show_tradeskill_frame_price_info;
	end
	function extern_setting.get_tradeskill_tip_craft_spell_price()
		return SET.show_tradeskill_tip_craft_spell_price;
	end
	function extern_setting.get_tradeskill_tip_craft_item_price()
		return SET.show_tradeskill_tip_craft_item_price;
	end
	function extern_setting.get_tradeskill_tip_recipe_price()
		return SET.show_tradeskill_tip_recipe_price;
	end
	function extern_setting.get_tradeskill_tip_recipe_account_learned()
		return SET.show_tradeskill_tip_recipe_account_learned;
	end
	function extern_setting.get_tradeskill_board_shown()
		return SET.show_board;
	end
	function extern_setting.get_tradeskill_board_lock()
		return SET.lock_board;
	end
	function extern_setting.get_tradeskill_blz_style()
		return SET.blz_style;
	end

	if select(2, GetAddOnInfo('\33\33\33\49\54\51\85\73\33\33\33')) then
		_G._163_tradeskill_frame_price_toggle = extern_setting.toggle_tradeskill_frame_price_info;
		_G._163_tradeskill_tip_craft_spell_price_toggle = extern_setting.toggle_tradeskill_tip_craft_spell_price;
		_G._163_tradeskill_tip_craft_item_toggle = extern_setting.toggle_tradeskill_tip_craft_item_price;
		_G._163_tradeskill_tip_recipe_toggle = extern_setting.toggle_tradeskill_tip_recipe_price;
		_G._163_tradeskill_tip_recipe_account_learned_toggle = extern_setting.toggle_tradeskill_tip_recipe_account_learned;
		_G._163_tradeskill_board_shown_toggle = extern_setting.toggle_tradeskill_board_shown;
		_G._163_tradeskill_board_lock_toggle = extern_setting.toggle_tradeskill_board_lock;
		_G._163_tradeskill_board_blz_style_toggle = extern_setting.toggle_tradeskill_blz_style;

		_G._163_tradeskill_bg_color_set = extern_setting.set_tradeskill_bg_color;

		_G._163_tradeskill_frame_price_get = extern_setting.get_tradeskill_frame_price_info;
		_G._163_tradeskill_tip_craft_spell_price_get = extern_setting.get_tradeskill_tip_craft_spell_price;
		_G._163_tradeskill_tip_crafted_item_get = extern_setting.get_tradeskill_tip_craft_item_price;
		_G._163_tradeskill_tip_recipe_get = extern_setting.get_tradeskill_tip_recipe_price;
		_G._163_tradeskill_tip_recipe_account_learned_get = extern_setting.get_tradeskill_tip_recipe_account_learned;
		_G._163_tradeskill_board_shown_get = extern_setting.get_tradeskill_board_shown;
		_G._163_tradeskill_board_lock_get = extern_setting.get_tradeskill_board_lock;
		_G._163_tradeskill_blz_style_get = extern_setting.get_tradeskill_blz_style;
	end
end

do	--	EXTERN SUPPORT
	local alt_merc = {  };
	-- CREDIT Auctionator
	local material_sold_by_vendor = NS.material_sold_by_vendor;
	local material_sold_by_vendor_by_name = {  };
	local function cache_item_info(id)
		local name = GetItemInfo(id);
		if name then
			material_sold_by_vendor_by_name[name] = material_sold_by_vendor[id];
			return true;
		else
			return false;
		end
	end
	do
		local num_material_sold_by_vendor = 0;
		for id, price in next, material_sold_by_vendor do
			num_material_sold_by_vendor = num_material_sold_by_vendor + 1;
		end
		local frame = CreateFrame("FRAME");
		frame:RegisterEvent("ITEM_DATA_LOAD_RESULT");
		frame:SetScript("OnEvent", function(self, event, arg1, arg2)
			if material_sold_by_vendor[arg1] then
				if arg2 and cache_item_info(arg1) then
					num_material_sold_by_vendor = num_material_sold_by_vendor - 1;
				else
					RequestLoadItemDataByID(arg1);
				end
				if num_material_sold_by_vendor <= 0 then
					self:SetScript("OnEvent", nil);
					self:UnregisterAllEvents();
					frame = nil;
				end
			end
		end);
		for id, price in next, material_sold_by_vendor do
			RequestLoadItemDataByID(id);
		end
	end
	--
	function alt_merc.get_material_vendor_price_by_link(link, num)
		local id = tonumber(select(3, strfind(link, "item:(%d+)")));
		return id and alt_merc.get_material_vendor_price_by_id(id, num);
	end
	function alt_merc.get_material_vendor_price_by_id(id, num)
		local p = material_sold_by_vendor[id];
		if p then
			if num then
				return p * num;
			else
				return p;
			end
		else
			return nil;
		end
	end
	function alt_merc.get_material_vendor_price_by_name(name, num)
		local p = material_sold_by_vendor_by_name[name];
		if p then
			if num then
				return p * num;
			else
				return p;
			end
		else
			return nil;
		end
	end

	function alt_merc.query_name_by_id(id)
		return nil;
	end
	function alt_merc.query_quality_by_id(id)
		return nil;
	end
	local goldicon    = "\124TInterface\\MoneyFrame\\UI-GoldIcon:12:12:0:0\124t"
	local silvericon  = "\124TInterface\\MoneyFrame\\UI-SilverIcon:12:12:0:0\124t"
	local coppericon  = "\124TInterface\\MoneyFrame\\UI-CopperIcon:12:12:0:0\124t"
	function alt_merc.MoneyString(copper)
		-- GetCoinTextureString
		local g = floor(copper / 10000);
		copper = copper % 10000;
		local s = floor(copper / 100);
		copper = copper % 100;
		local c = floor(copper);
		if g > 0 then
			return format("%d%s %02d%s %02d%s", g, goldicon, s, silvericon, c, coppericon);
		elseif s > 0 then
			return format("%d%s %02d%s", s, silvericon, c, coppericon);
		else
			return format("%d%s", c, coppericon);
		end
	end
	----------------
	do	--	Auctionator
		local function query_ah_price_by_name(name, num)
			if not name then return nil; end
			num = num or 1;
			local vp = alt_merc.get_material_vendor_price_by_name(name, num);
			if vp then
				return vp;
			end
			if Atr_GetAuctionPrice then
				local ap = Atr_GetAuctionPrice(name);
				if ap then
					return ap * num;
				end
			end
			return nil;
		end
		local function query_ah_price_by_id(id, num)
			if not id then return nil; end
			num = num or 1;
			local vp = alt_merc.get_material_vendor_price_by_id(id, num);
			if vp then
				return vp;
			end
			if Atr_GetAuctionPrice then
				local name = GetItemInfo(id);
				if name then
					local ap = Atr_GetAuctionPrice(name);
					if ap and ap > 0 then
						return ap * num;
					end
				end
			end
		end
		function NS.meta_alt_merc_Auctionator()
			if IsAddOnLoaded("Auctionator") then
				return Mixin({ query_ah_price_by_name = query_ah_price_by_name, query_ah_price_by_id = query_ah_price_by_id, }, alt_merc);
			end
		end
	end
	--------
	do	--	AUX
		local history = nil;
		local function query_ah_price_by_name(name, num)
			return nil;
		end
		local function query_ah_price_by_id(id, num)
			if not id then return nil; end
			num = num or 1;
			local vp = alt_merc.get_material_vendor_price_by_id(id, num);
			if vp then
				return vp;
			end
			if history then
				local ap = history.market_value(id .. ":0");
				if ap and ap > 0 then
					return ap * num;
				end
			end
		end
		function NS.meta_alt_merc_aux()
			if IsAddOnLoaded("aux-addon") then
				if require then
					history = require 'aux.core.history';
				end
				return Mixin({ query_ah_price_by_name = query_ah_price_by_name, query_ah_price_by_id = query_ah_price_by_id, }, alt_merc);
			end
		end
	end
	--------
	do	--	AuctionFaster
		local GetItemFromCache = nil;
		local function query_ah_price_by_name(name, num)
			return nil;
		end
		local function query_ah_price_by_id(id, num)
			if not id then return nil; end
			num = num or 1;
			local vp = alt_merc.get_material_vendor_price_by_id(id, num);
			if vp then
				return vp;
			end
			if GetItemFromCache then
				local name = GetItemInfo(id);
				if name then
					local cacheItem = GetItemFromCache(nil, id, name, true);
					if cacheItem then
						local ap = cacheItem.buy;
						if ap and ap > 0 then
							return ap * num;
						end
					end
				end
			end
		end
		function NS.meta_alt_merc_AuctionFaster()
			if IsAddOnLoaded("AuctionFaster") then
				GetItemFromCache = AuctionFaster.modules.ItemCache.GetItemFromCache;
				return Mixin({ query_ah_price_by_name = query_ah_price_by_name, query_ah_price_by_id = query_ah_price_by_id, }, alt_merc);
			end
		end
	end
	--------
	do	--	AuctionMaster
		local function query_ah_price_by_name(name, num)
			return nil;
		end
		local function query_ah_price_by_id(id, num)
			if not id then return nil; end
			num = num or 1;
			local vp = alt_merc.get_material_vendor_price_by_id(id, num);
			if vp then
				return vp;
			end
			if AucMasGetCurrentAuctionInfo then
				local _, link = GetItemInfo(id);
				if link then
					local _, _, bid, ap = AucMasGetCurrentAuctionInfo(link)
					if ap and ap > 0 then
						return ap * num;
					end
				end
			end
		end
		function NS.meta_alt_merc_AuctionMaster()
			if IsAddOnLoaded("AuctionMaster") then
				return Mixin({ query_ah_price_by_name = query_ah_price_by_name, query_ah_price_by_id = query_ah_price_by_id, add_cache_callback = AucMasRegisterStatisticCallback, }, alt_merc);
			end
		end
	end
	--------
end

do	--	DEV
	function _G.ATS_DEBUG(on)
		if on or on == nil then
			_log_ = function(...)
				print(date('\124cff00ff00%H:%M:%S\124r'), ...);
			end
		else
			_log_ = _noop_;
		end		
	end
	--	dev
		function _G.alatsdev_mtsl()
			if MTSL_DATA then
				local db, sinfo, iinfo = NS.link_db();	--	recipe_info, spell_info, item_info
				if db then
					local mtsl = MTSL_DATA["skills"];
					for p, mdb in next, mtsl do
						for _, m in next, mdb do
							local sid = m.id;
							if sid then
								local info = db[sid];
								if info then
									if m.phase ~= info[index_phase] then
										print(p, sid, 'phase', m.phase, info[index_phase]);
									end
									if m.min_skill and m.min_skill ~= info[index_learn_rank] then
										print(p, sid, 'min_skill', m.min_skill, info[index_learn_rank]);
									end
									if m.items and #m.items > 0 then
										if #m.items > 1 then
											print(p, sid, 'items', #m.items);
										end
										if info[index_rid] ~= m.items[1] then
											print(p, sid, 'items', info[index_rid], m.items[1]);
										end
									end
									if m.quests and #m.quests > 0 then
										if info[index_quest] and #info[index_quest] then
											if #m.quests == #info[index_quest] then
												for index = 1, #m.quests do
													if m.quests[index] ~= info[index_quest][index] then
														print(p, sid, 'quests', 'seq');
														break;
													end
												end
											else
												print(p, sid, 'quests#', #m.quests, #info[index_quest]);
											end
										else
											print(p, sid, 'quests');
										end
									end
									if m.objects and #m.objects > 0 then
										if #m.objects > 1 then
											print(p, sid, 'objects', #m.objects);
										end
										if info[index_object] ~= m.objects[1] then
											print(p, sid, 'objects', info[index_object], m.objects[1]);
										end
									end
									if m.trainers then
										if info[index_train_price] ~= m.trainers.price then
											print(p, sid, 'trainprice', info[index_train_price], m.trainers.price)
										end
										if info[index_trainer] then
											if #m.trainers.sources == #info[index_trainer] then
												for index = 1, #m.trainers.sources do
													if m.trainers.sources[index] ~= info[index_trainer][index] then
														print(p, sid, 'trainers', 'seq');
														break;
													end
												end
											else
												print(p, sid, 'trainers#', #m.trainers.sources, #info[index_trainer]);
											end
										else
											print(p, sid, 'trainers');
										end
									end
								else
									print(p, sid, 'missing');
								end
							else
								print(p, sid);
							end
						end
					end
				end
			end
		end
		function _G.alatsdev_atlas()
			if AtlasLoot and AtlasLoot.Data then
				local db, sinfo, iinfo = NS.link_db();	--	recipe_info, spell_info, item_info
				if db then
					_G.alaDevSV = alaDevSV or {  };
					alaDevSV.atf = alaDevSV.atf or {  };
					local atf = alaDevSV.atf;
					local function _print_(key, ...)
						print(key, ...)
						local t = atf[key];
						if t == nil then
							t = {  };
							atf[key] = t;
						end
						tinsert(t, { ... })
					end
					local atlasPhase = AtlasLoot.Data.ContentPhase;
					local atlasDB = AtlasLoot.Data.Profession;
					for sid, info in next, db do
						local pid = info[index_pid];
						local p = info[index_phase];
						if true then
							local cid = info[index_cid];
							local rid = info[index_rid];
							if cid == nil then
								if rid == nil then
									if p ~= 1 then
										_print_('p', pid, sid, 1, p)
									end
								else
									local p3 = atlasPhase:GetForItemID(rid);
									if (p > 4 and (p ~= p3)) or (p == 4 and p3 and p3 ~= 4) or (p < 4 and p3) then
										_print_('p', pid, sid, 2, p, p2);
									end
								end
							else
								if rid == nil then
									local p2 = atlasPhase:GetForItemID(cid);
									if (p > 4 and (p ~= p2)) or (p == 4 and p2 and p2 ~= 4) or (p < 4 and p2) then
										_print_('p', pid, sid, 3, p, p2);
									end
								else
									local p2 = atlasPhase:GetForItemID(cid);
									local p3 = atlasPhase:GetForItemID(rid);
									if p2 and p3 and p2 ~= p3 then
										_print_('p', pid, sid, 4, p, p2, p3);
									end
									if (p > 4 and (p ~= p3)) or (p == 4 and p3 and p3 ~= 4) or (p < 4 and p3) then
										_print_('p', pid, sid, 5, p, p2, p3);
									end
								end
							end
						end
						if true then
							local info2 = atlasDB.GetProfessionData(sid);
							-- [spellID] = { createdItemID, prof, minLvl, lowLvl, highLvl, reagents{}, reagentsCount{}, numCreatedItems }
							if info2 then
								if info2[1] ~= info[index_cid] then
									_print_('c', pid, sid, info[index_cid], info2[1]);
								end
								if info2[3] ~= info[index_learn_rank] then
									_print_('l', pid, sid, info[index_learn_rank], info2[3]);
								end
								if info2[4] ~= info[index_yellow_rank] then
									_print_('y', pid, sid, info[index_yellow_rank], info2[4]);
								end
								if info2[5] ~= info[index_grey_rank] then
									_print_('g', pid, sid, info[index_grey_rank], info2[5]);
								end
								if #info2[6] ~= #info[index_reagents_id] then
									_print_('r', pid, sid, 1, #info[index_reagents_id], #info2[6], #info2[7]);
								else
									if #info2[7] ~= #info2[6] then
										_print_('r', pid, sid, 2, #info2[7], #info2[6]);
									else
										for idx1, id1 in next, info[index_reagents_id] do
											local val = false;
											for idx2, id2 in next, info2[6] do
												if id1 == id2 then
													val = true;
													if info[index_reagents_count][idx1] ~= info2[7][idx2] then
														_print_('r', pid, sid, 3, info[index_reagents_count][idx1], info2[7][idx2]);
													end
													break;
												end
											end
											if not val then
												_print_('r', pid, sid, 4, idx1, id1);
											end
										end
									end
								end
								if info2[8] then
									if info[index_num_made_min] and info[index_num_made_max] then
										if info2[8] * 2 ~= info[index_num_made_min] + info[index_num_made_max] then
											_print_('n', pid, sid, 1, (info[index_num_made_min] + info[index_num_made_max]) * 0.5, info2[8]);
										end
									else
										_print_('n', pid, sid, 2, info2[8]);
									end
								end
							else
								_print_('m', pid, sid);
							end
						end
					end
				end
			end
		end
		function _G.alatsdev_atlas_recipe()
			_G.alaDevSV = alaDevSV or {  };
			alaDevSV.atf = alaDevSV.atf or {  };
			alaDevSV.atf.rid = {}
			local recipe = alaDevSV.atf.rid;
			local RECIPE = {};	--	manual
			local db, sinfo, iinfo = NS.link_db();	--	recipe_info, spell_info, item_info
			for rid, v in next, RECIPE do
				local sid = v[3];
				local info = db[sid];
				if info then
					local rid1 = info[index_rid];
					if rid1 == nil then
						tinsert(recipe, {'m', sid, rid})
					elseif rid1 ~= rid then
						tinsert(recipe, {'d', sid, rid, rid1})
					end
				else
					tinsert(recipe, {'e',sid,rid})
				end
			end
		end			
	--
	-- WorldFrame:EnableKeyboard();
	-- WorldFrame:HookScript("OnKeyDown", function(self, key)
	-- 	print(key, "D");
	-- end);
	-- WorldFrame:HookScript("OnKeyUp", function(self, key)
	-- 	print(key, "U");
	-- end);
	-- WorldFrame:GetScript("OnKeyDown")(WorldFrame, "W")
end

StackSplitFrame:SetFrameStrata("TOOLTIP");
