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
	local type = type;
	local tonumber = tonumber;
	local select = select;
	local setmetatable = setmetatable;
	local rawget = rawget;
	local rawset = rawset;
	local next = next;

	local strfind = string.find;
	local strlower = string.lower;
	local strupper = string.upper;
	local format = string.format;
	local tremove = table.remove;
	local tinsert = table.insert;

	local IsAddOnLoaded = IsAddOnLoaded;

	local GetPlayerInfoByGUID = GetPlayerInfoByGUID;
	local SlashCmdList = SlashCmdList;


	local GetAddOnInfo = GetAddOnInfo;

	local CreateFrame = CreateFrame;
	local _G = _G;

-->
	local DataAgent = DT.DataAgent;
	local l10n = CT.l10n;

-->
MT.BuildEnv("setting");

--		Saved Variables
	function MT.ChangeSetWithUpdate(set, key, val)
		set[key] = val;
		set.update = true;
	end
	function MT.AddChar(key, VAR, before_initialized)
		if key ~= nil and VAR ~= nil and VT.AVAR[key] == nil then
			local list = VT.SET.char_list;
			for index = #list, 1, -1 do
				if list[index] == key then
					tremove(list, index);
				end
			end
			VT.AVAR[key] = VAR;
			list[#list + 1] = key;
			if not before_initialized then
				MT.UpdateAllFrames();
			end
		end
	end
	function MT.DelChar(index)
		local list = VT.SET.char_list;
		if index ~= nil and index <= #list then
			local key = list[index];
			if key ~= CT.SELFGUID then
				tremove(list, index);
				VT.AVAR[key] = nil;
				MT.UpdateAllFrames();
			end
		end
	end
	function MT.DelCharByKey(key)
		if key ~= nil then
			local list = VT.SET.char_list;
			for index = 1, #list do
				if list[index] == key then
					MT.DelChar(index);
					break;
				end
			end
		end
	end
	--
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
		hide_mtsl = false,
		show_DBIcon = true,
		minimapPos = 0,
		first_auction_mod = "*",
		show_queue_button = true,
		show_queue = false,
	};
	local default_set = {
		shown = true,
		showSet = false,
		showProfit = false,
		--
		overrideminrank = 0,
		rankoffset = 0,
		showKnown = true,
		showUnkown = true,
		showHighRank = false,
		filterClass = true,
		filterSpec = true,
		showItemInsteadOfSpell = false,
		showRank = true,
		haveMaterials = false,
		phase = DataAgent.CURPHASE,
		--
		searchText = "",
		searchNameOnly = false,
		--
		PROFIT_SHOW_COST_ONLY = false,
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
		phase = DataAgent.CURPHASE,
		--
		filter = {
			-- realm = nil,
			Skill = nil,
			Type = nil,
			SubType = nil,
			EquipLoc = nil,
		},
		searchText = "",
		--
		-- PROFIT_SHOW_COST_ONLY = false,
	};
	local default_board_set = {
		pos = { 800, 400, },
		scale = 1.0,
		show = true,
		showscale = false,
	};
	local function LF_ModifySavedVariable()
		local alaTradeSkillSV = _G.alaTradeSkillSV;
		if alaTradeSkillSV == nil or alaTradeSkillSV._version == nil or alaTradeSkillSV._version < 240101.1 then
			alaTradeSkillSV = {
				set = {
					explorer = default_explorer_set,
					board = default_board_set,
				},
				var = {  },
				fav = alaTradeSkillSV ~= nil and alaTradeSkillSV.fav or {  },
				cmm = {  },
				cache = {  },
				queue = {
					list = {  },
					todo = {  },
				},
			};
			_G.alaTradeSkillSV = alaTradeSkillSV;
		else
			if alaTradeSkillSV._version < 241010.1 then
				alaTradeSkillSV.set.board = default_board_set;
				alaTradeSkillSV.set.board.pos = default_board_set.pos;
			end
			if alaTradeSkillSV._version < 250320.1 then
				alaTradeSkillSV.queue = {
					list = {  },
					todo = {  },
				};
			end
		end
		alaTradeSkillSV._version = 250320.1;
		MT.MergeGlobal(alaTradeSkillSV);
		VT.SET = alaTradeSkillSV.set;
		for pid = DataAgent.DBMINPID, DataAgent.DBMAXPID do
			local set = rawget(VT.SET, pid);
			if set ~= nil then
				for key, val in next, default_set do
					if set[key] == nil then
						set[key] = val;
					end
				end
			end
		end
		setmetatable(VT.SET, {
			__index = function(t, pid)
				if DataAgent.is_pid(pid) then
					local set = {  };
					for key, val in next, default_set do
						set[key] = val;
					end
					t[pid] = set;
					return set;
				end
				return nil;
			end,
		});
		for key, val in next, default_SET do
			if rawget(VT.SET, key) == nil then
				rawset(VT.SET, key, val);
			end
		end
		for pid, set in next, VT.SET do
			if DataAgent.is_pid(pid) or pid == 'explorer' then
				set.update = true;
				-- if set.phase == nil or set.phase < DataAgent.CURPHASE then
					set.phase = DataAgent.CURPHASE;
				-- end
			end
		end
		VT.AVAR = alaTradeSkillSV.var;
		local list = VT.SET.char_list;
		for index = #list, 1, -1 do
			if VT.AVAR[list[index]] == nil then
				tremove(list, index);
			end
		end
		for GUID, VAR in next, VT.AVAR do
			for pid = DataAgent.DBMINPID, DataAgent.DBMAXPID do
				local var = rawget(VAR, pid);
				if var ~= nil and DataAgent.is_pid(pid) then
					var.cur_rank = var.cur_rank or "-";
					var.max_rank = var.max_rank or "-";
				end
			end
			local found = false;
			for index = 1, #list do
				if list[index] == GUID then
					found = true;
					break;
				end
			end
			if not found then
				list[#list + 1] = GUID;
			end
		end
		if VT.AVAR[CT.SELFGUID] == nil then
			MT.AddChar(CT.SELFGUID, { realm_id = CT.SELFREALMID, realm_name = CT.SELFREALM, supreme_list = {  }, }, true);
		end
		VT.VAR = setmetatable(VT.AVAR[CT.SELFGUID], {
			__index = function(t, pid)
				if DataAgent.is_pid(pid) then
					local temp = { {  }, {  }, update = true, };
					t[pid] = temp;
					return temp;
				else
					return default_var[pid];
				end
			end,
		});
		for pid = DataAgent.DBMINPID, DataAgent.DBMAXPID do
			local var = rawget(VT.VAR, pid);
			if var ~= nil and DataAgent.is_pid(pid) then
				var.update = true;
			end
		end
		VT.FAV = alaTradeSkillSV.fav;
		VT.CMM = alaTradeSkillSV.cmm[CT.SELFREALMID];
		if VT.CMM == nil then
			VT.CMM = {  };
			alaTradeSkillSV.cmm[CT.SELFREALMID] = VT.CMM;
		end
		VT.SVAR = alaTradeSkillSV;
		VT.CACHE = alaTradeSkillSV.cache;
		VT.QUEUE = alaTradeSkillSV.queue;
	end
-->

function MT.OnSettingChanged(key, val, loading)
	if key == 'expand' then
		MT.ToggleFrameExpand(val);
	elseif key == 'blz_style' then
		MT.RefreshFramesStyle(loading);
	elseif key == 'bg_color' then
		MT.RefreshFramesStyle(loading);
	elseif key == 'show_tradeskill_frame_rank_info' then
		MT.ToggleFrameRankInfo(val);
	elseif key == 'show_tradeskill_frame_price_info' then
		MT.ToggleFramePriceInfo(val);
	elseif key == 'show_queue_button' then
		MT.ToggleQueueButton(val);
	elseif key == 'colored_rank_for_unknown' then
		MT.RefreshAllFrames();
	elseif key == 'regular_exp' then
		for pid, set in next, VT.SET do
			if DataAgent.is_pid(pid) or pid == 'explorer' then
				set.update = true;
			end
		end
		MT.UpdateAllFrames();
	elseif key == 'hide_mtsl' then
		MT.MTSL_Hide(val);
	else
	end
	if not loading then
		MT.RefreshConfigFrame();
	end
end

do	--	SLASH
	local function set_handler(cmd, val)
		if cmd[6] then
			val = cmd[6](val);
		end
		if val ~= nil then
			if VT.SET[cmd[3]] ~= val then
				if not cmd.donotset then
					VT.SET[cmd[3]] = val;
				end
				if cmd[4] then
					if type(cmd[4]) == 'function' then
						MT.Print(cmd[4](cmd[3], val));
					else
						MT.Print(cmd[4], val);
					end
				else
					MT.Print(cmd[3], val);
				end
				if cmd[5] then
					cmd[5](cmd[3], val);
				end
				MT.OnSettingChanged(cmd[3], val);
			end
		else
			MT.Print(l10n["INVALID_COMMANDS"]);
		end
	end
	--	pattern, key, note, func(key, val)
	local SEPARATOR = "[ %`%~%!%@%#%$%%%^%&%*%(%)%-%_%=%+%[%{%]%}%\\%|%;%:%\'%\"%,%<%.%>%/%?]*";
	--	1type, 2pattern, 3key, 4note(string or func), 5proc_func(key, val), 6func_to_mod_val, 7config_type(nil for check), 8cmd_for_config / drop_meta, 9para[slider:{min, max, step}], 10sub_config_on_val
	VT.SetCommandList = {
		{	--	expand
			'bool',
			"^expand" .. SEPARATOR .. "(.*)" .. SEPARATOR .. "$",
			"expand",
			l10n.SLASH_NOTE["expand"],
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
			l10n.SLASH_NOTE["blz_style"],
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
					l10n.SLASH_NOTE["bg_color"],
					[7] = 'color4',
					[8] = function(r, g, b, a)
						VT.SET.bg_color = { r or 1.0, g or 1.0, b or 1.0, a or 1.0, };
						MT.OnSettingChanged('bg_color', VT.SET.bg_color);
					end,
				},
			},
		},
		{	--	show_tradeskill_frame_price_info
			'bool',
			"^price" .. SEPARATOR .. "info" .. SEPARATOR .. "(.*)" .. SEPARATOR .. "$",
			"show_tradeskill_frame_price_info",
			l10n.SLASH_NOTE["show_tradeskill_frame_price_info"],
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
			l10n.SLASH_NOTE["show_tradeskill_frame_rank_info"],
			nil,
			[8] = function(self)
				if self:GetChecked() then
					SlashCmdList["ALATRADEFRAME"]("setrank1");
				else
					SlashCmdList["ALATRADEFRAME"]("setrank0");
				end
			end,
		},
		{	--	show_queue_button
			'bool',
			"^queue" .. SEPARATOR .. "(.*)" .. SEPARATOR .. "$",
			"show_queue_button",
			l10n.SLASH_NOTE["show_queue_button"],
			nil,
			[8] = function(self)
				if self:GetChecked() then
					SlashCmdList["ALATRADEFRAME"]("setqueue1");
				else
					SlashCmdList["ALATRADEFRAME"]("setqueue0");
				end
			end,
		},
		{	--	show_tradeskill_tip_craft_item_price
			'bool',
			"^tip" .. SEPARATOR .. "itemprice" .. SEPARATOR .. "(.*)" .. SEPARATOR .. "$",
			"show_tradeskill_tip_craft_item_price",
			l10n.SLASH_NOTE["show_tradeskill_tip_craft_item_price"],
			nil,
			[8] = function(self)
				if self:GetChecked() then
					SlashCmdList["ALATRADEFRAME"]("settipitemprice1");
				else
					SlashCmdList["ALATRADEFRAME"]("settipitemprice0");
				end
			end,
		},
		{	--	show_tradeskill_tip_craft_spell_price
			'bool',
			"^tip" .. SEPARATOR .. "spellprice" .. SEPARATOR .. "(.*)" .. SEPARATOR .. "$",
			"show_tradeskill_tip_craft_spell_price",
			l10n.SLASH_NOTE["show_tradeskill_tip_craft_spell_price"],
			nil,
			[8] = function(self)
				if self:GetChecked() then
					SlashCmdList["ALATRADEFRAME"]("settipspellprice1");
				else
					SlashCmdList["ALATRADEFRAME"]("settipspellprice0");
				end
			end,
		},
		{	--	show_tradeskill_tip_recipe_price
			'bool',
			"^tip" .. SEPARATOR .. "recipe" .. SEPARATOR .. "(.*)" .. SEPARATOR .. "$",
			"show_tradeskill_tip_recipe_price",
			l10n.SLASH_NOTE["show_tradeskill_tip_recipe_price"],
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
			l10n.SLASH_NOTE["show_tradeskill_tip_recipe_account_learned"],
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
			l10n.SLASH_NOTE["show_tradeskill_tip_material_craft_info"],
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
			l10n.SLASH_NOTE["default_skill_button_tip"],
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
			l10n.SLASH_NOTE["colored_rank_for_unknown"],
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
			l10n.SLASH_NOTE["regular_exp"],
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
			l10n.SLASH_NOTE["show_call"],
			function(key, val)
				MT.ToggleFrameCall(val);
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
			l10n.SLASH_NOTE["show_tab"],
			function(key, val)
				MT.ToggleFrameTab(val);
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
			l10n.SLASH_NOTE["portrait_button"],
			function(key, val)
				MT.ToggleFramePortraitButton(val);
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
			l10n.SLASH_NOTE["show_board"],
			function(key, val)
				MT.ToggleFrame("BOARD", val);
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
			l10n.SLASH_NOTE["lock_board"],
			function(key, val)
				MT.LockBoard(val);
			end,
			[8] = function(self)
				if self:GetChecked() then
					SlashCmdList["ALATRADEFRAME"]("setlockboard1");
				else
					SlashCmdList["ALATRADEFRAME"]("setlockboard0");
				end
			end,
		},
		{	--	show_DBIcon
			'bool',
			"^show" .. SEPARATOR .. "dbicon" .. SEPARATOR .. "(.+)" .. SEPARATOR .. "$",
			"show_DBIcon",
			l10n.SLASH_NOTE["show_DBIcon"],
			function(key, val)
				local LDI = LibStub("LibDBIcon-1.0", true);
				if LDI ~= nil then
					if val then
						LDI:Show("alaTradeSkill");
					else
						LDI:Hide("alaTradeSkill");
					end
				end
			end,
			[8] = function(self)
				if self:GetChecked() then
					SlashCmdList["ALATRADEFRAME"]("setshowdbicon1");
				else
					SlashCmdList["ALATRADEFRAME"]("setshowdbicon0");
				end
			end,
		},
		{	--	hide_mtsl
			'bool',
			"^hide" .. SEPARATOR .. "mtsl" .. SEPARATOR .. "(.+)" .. SEPARATOR .. "$",
			"hide_mtsl",
			l10n.SLASH_NOTE["hide_mtsl"],
			nil,
			[8] = function(self)
				if self:GetChecked() then
					SlashCmdList["ALATRADEFRAME"]("sethidemtsl1");
				else
					SlashCmdList["ALATRADEFRAME"]("sethidemtsl0");
				end
			end,
		},
		{	--	first_auction_mod
			'string',
			"^hide" .. SEPARATOR .. "mtsl" .. SEPARATOR .. "(.+)" .. SEPARATOR .. "$",
			"first_auction_mod",
			l10n.SLASH_NOTE["first_auction_mod"],
			nil,
			nil,
			'drop',
			[8] = function(self)
				return MT.GetAuctionModListDropMeta();
			end,
		},
	};
	_G.SLASH_ALATRADEFRAME1 = "/alatradeskill";
	_G.SLASH_ALATRADEFRAME2 = "/alats";
	_G.SLASH_ALATRADEFRAME3 = "/ats";
	local SET_PATTERN = "^" .. SEPARATOR .. "set" .. SEPARATOR .. "(.+)" .. SEPARATOR .. "$";
	local UI_PATTERN = "^" .. SEPARATOR .. "ui" .. SEPARATOR .. "(.+)" .. SEPARATOR .. "$";
	local DUMP_PATTERN = "^" .. SEPARATOR .. "dump" .. SEPARATOR .. "(.+)" .. SEPARATOR .. "$";
	SlashCmdList["ALATRADEFRAME"] = function(msg)
		msg = strlower(msg);
		--	set
		local _, pattern;
		_, _, pattern = strfind(msg, SET_PATTERN);
		if pattern then
			local SetCommandList = VT.SetCommandList;
			for index = 1, #SetCommandList do
				local cmd = SetCommandList[index];
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
							if VT.SET[cmd[3]] ~= val then
								if not cmd.donotset then
									VT.SET[cmd[3]] = val;
								end
								if cmd[4] then
									if type(cmd[4]) == 'function' then
										MT.Print(cmd[4](cmd[3], val));
									else
										MT.Print(cmd[4], val);
									end
								else
									MT.Print(cmd[3], val);
								end
								if cmd[5] then
									cmd[5](cmd[3], val);
								end
								MT.OnSettingChanged(cmd[3], val);
							end
						else
							MT.Print(l10n["INVALID_COMMANDS"]);
						end
					elseif cmd[1] == 'num' then
						local val = tonumber(pattern2);
						if val then
							if cmd[6] then
								val = cmd[6](val);
							end
							if val then
								if VT.SET[cmd[3]] ~= val then
									if not cmd.donotset then
										VT.SET[cmd[3]] = val;
									end
									if cmd[4] then
										if type(cmd[4]) == 'function' then
											MT.Print(cmd[4](cmd[3], val));
										else
											MT.Print(cmd[4], val);
										end
									else
										MT.Print(cmd[3], val);
									end
									if cmd[5] then
										cmd[5](cmd[3], val);
									end
									MT.OnSettingChanged(cmd[3], val);
								end
							else
								MT.Print("|cffff0000Invalid parameter: ", pattern2);
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
				MT.ToggleFrame("EXPLORER");
			elseif strfind(pattern, 'conf') then
				MT.ToggleFrame("CONFIG");
			end
			return;
		end
		_, _, pattern = strfind(msg, DUMP_PATTERN);
		if pattern then
			MT.Print("AuctionMod Status: ", MT.GetAuctionMod() ~= nil);
			return;
		end
		--	default
		if strfind(msg, "[A-Za-z0-9]+" ) then
			MT.Print("Invalid command: [[", msg, "]] Use: ");
			MT.Print("  /atf setexpand on/off");
			MT.Print("  /atf setblzstyle on/off");
			MT.Print("  /atf setpriceinfo on/off");
			MT.Print("  /atf setrank on/off");
			MT.Print("  /atf settipitem on/off");
			MT.Print("  /atf settipspell on/off");
			MT.Print("  /atf settiprecipe on/off");
			MT.Print("  /atf settiplearned on/off");
			MT.Print("  /atf settipmaterial on/off");
			MT.Print("  /atf settipdefault on/off");
			MT.Print("  /atf setstyle on/off");
			MT.Print("  /atf setregularexpression on/off");
			MT.Print("  /atf setshowcall on/off");
			MT.Print("  /atf setshowtab on/off");
			MT.Print("  /atf setportrait on/off");
			MT.Print("  /atf setshowboard on/off");
			MT.Print("  /atf setlockboard on/off");
			MT.Print("  /atf sethidemtsl on/off");
		else
			-- MT.ToggleFrame("CONFIG");
			MT.ToggleFrame("CONFIG");
		end
	end
end

local SettingMethd = {  };
__private.SettingMethd = SettingMethd;
do	--	EXTERN SETTING
	function SettingMethd.Toggle_TradeSkillFrameRank(on)
		VT.SET.show_tradeskill_frame_rank_info = on;
		MT.OnSettingChanged('show_tradeskill_frame_rank_info', on);
	end
	function SettingMethd.Toggle_TradeSkillFramePriceInfo(on)
		VT.SET.show_tradeskill_frame_price_info = on;
		MT.OnSettingChanged('show_tradeskill_frame_price_info', on);
	end
	function SettingMethd.Toggle_TradeSkillSpellTipPrice(on)
		VT.SET.show_tradeskill_tip_craft_spell_price = on;
	end
	function SettingMethd.Toggle_TradeSkillItemTipPrice(on)
		VT.SET.show_tradeskill_tip_craft_item_price = on;
	end
	function SettingMethd.Toggle_TradeSkillRecipeTipPrice(on)
		VT.SET.show_tradeskill_tip_recipe_price = on;
	end
	function SettingMethd.Toggle_TradeSkillRecipeTipAccountLearned(on)
		VT.SET.show_tradeskill_tip_recipe_account_learned = on;
	end
	function SettingMethd.Toggle_TradeSkillBoardShown(on)
		VT.SET.show_board = on;
		MT.ToggleFrame("BOARD", on);
	end
	function SettingMethd.Toggle_TradeSkillBoardLock(on)
		VT.SET.lock_board = on;
		MT.LockBoard(on);
	end
	function SettingMethd.Toggle_TradeSkillFrameStyle(on)
		VT.SET.blz_style = on;
		MT.RefreshFramesStyle();
	end

	function SettingMethd.Set_TradeSkillFrameBgColor(r, g, b, a)
		VT.SET.bg_color[1] = r or VT.SET.bg_color[1];
		VT.SET.bg_color[2] = g or VT.SET.bg_color[2];
		VT.SET.bg_color[3] = b or VT.SET.bg_color[3];
		VT.SET.bg_color[4] = a or VT.SET.bg_color[4];
		MT.OnSettingChanged('bg_color', VT.SET.bg_color);
	end

	function SettingMethd.GetVar_TradeSkillFramePriceInfo()
		return VT.SET.show_tradeskill_frame_price_info;
	end
	function SettingMethd.GetVar_TradeSkillSpellTipPrice()
		return VT.SET.show_tradeskill_tip_craft_spell_price;
	end
	function SettingMethd.GetVar_TradeSkillItemTipPrice()
		return VT.SET.show_tradeskill_tip_craft_item_price;
	end
	function SettingMethd.GetVar_TradeSkillRecipeTipPrice()
		return VT.SET.show_tradeskill_tip_recipe_price;
	end
	function SettingMethd.GetVar_TradeSkillRecipeTipAccountLearned()
		return VT.SET.show_tradeskill_tip_recipe_account_learned;
	end
	function SettingMethd.GetVar_TradeSkillBoardShown()
		return VT.SET.show_board;
	end
	function SettingMethd.GetVar_TradeSkillBoardLocked()
		return VT.SET.lock_board;
	end
	function SettingMethd.GetVar_TradeSkillFrameStyle()
		return VT.SET.blz_style;
	end
end


MT.RegisterBeforeInit('setting', function(LoggedIn)
	if not MT.SafeCall(LF_ModifySavedVariable) then
		local fav = alaTradeSkillSV.fav;
		alaTradeSkillSV = nil;
		if MT.SafeCall(LF_ModifySavedVariable) then
			if type(fav) == 'table' then
				VT.FAV = fav;
				alaTradeSkillSV.fav = fav or {  };
			end
		else
			MT.Error("|cffff0000alaTradeSkill fetal error");
		end
	end
end);
MT.RegisterOnInit('setting', function(LoggedIn)
	for GUID, _ in next, VT.AVAR do
		GetPlayerInfoByGUID(GUID);
	end
	-- MT.SafeCall(__private.cmm_InitAddOnMessage);
	for key, val in next, VT.SET do
		if type(val) ~= 'table' then
			MT.OnSettingChanged(key, val, true);
		end
	end
	EnableAddOn("MissingTradeSkillsList_TBC_Data");
	LoadAddOn("MissingTradeSkillsList_TBC_Data");
end);
MT.RegisterOnLogin('setting', function(LoggedIn)
	local LibStub = _G.LibStub;
	if LibStub ~= nil then
		local LDI = LibStub("LibDBIcon-1.0", true);
		if LDI ~= nil then
			LDI:Register("alaTradeSkill",
				{
					icon = CT.TEXTUREPATH .. [[alaTradeSkill]],
					OnClick = function(self, button)
						if button == "RightButton" then
							MT.ToggleFrame("CONFIG");
						else
							MT.ToggleFrame("EXPLORER");
						end
					end,
					text = l10n.DBIcon_Text,
					OnTooltipShow = function(tt)
						tt:AddLine("alaTradeSkill");
						tt:AddLine(" ");
						for _, text in next, l10n.TooltipLines do
							tt:AddLine(text);
						end
					end
				},
				{
					minimapPos = VT.SET.minimapPos,
				}
			);
			if VT.SET.show_DBIcon then
				LDI:Show("alaTradeSkill");
			else
				LDI:Hide("alaTradeSkill");
			end
			local mb = LDI:GetMinimapButton("alaTradeSkill");
			mb:RegisterEvent("PLAYER_LOGOUT");
			mb:HookScript("OnEvent", function(self)
				VT.SET.minimapPos = self.minimapPos or self.db.minimapPos;
			end);
			mb:HookScript("OnDragStop", function(self)
				VT.SET.minimapPos = self.minimapPos or self.db.minimapPos;
			end);
		end
	end
end);
