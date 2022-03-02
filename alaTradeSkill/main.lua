--[[--
	by ALA @ 163UI
	##	TODO	--	let them sunk in shit
		Communication Func, query from others or broadcast to others
		query skill & query specified sid
		supreme craft
--]]--
local __ala_meta__ = _G.__ala_meta__;

local __addon__, __namespace__ = ...;
__ala_meta__.prof = __namespace__;

local __db__ = __namespace__.__db__;
local L = __namespace__.L;
__namespace__.__is_dev = select(2, GetAddOnInfo("!!!!!DebugMe")) ~= nil;
__namespace__.__is_classic = WOW_PROJECT_ID == WOW_PROJECT_CLASSIC;
__namespace__.__is_bcc = WOW_PROJECT_ID == WOW_PROJECT_BURNING_CRUSADE_CLASSIC;

-->		upvalue
	local geterrorhandler = geterrorhandler;
	local xpcall = xpcall;
	local hooksecurefunc = hooksecurefunc;
	local select = select;
	local type = type;
	local tonumber = tonumber;
	local setmetatable = setmetatable;
	local rawget = rawget;
	local rawset = rawset;
	local next = next;
	local unpack = unpack;

	local floor = math.floor;
	local strfind = string.find;
	local strlower = string.lower;
	local strupper = string.upper;
	local format = string.format;
	local tremove = table.remove;
	local tinsert = table.insert;

	local print = print;
	local date = date;

	local IsAddOnLoaded = IsAddOnLoaded;
	local C_Timer_After = C_Timer.After;
	local GetRealmID = GetRealmID;

	local GetPlayerInfoByGUID = GetPlayerInfoByGUID;
	local SlashCmdList = SlashCmdList;

	local GetTime = GetTime;
	local GetSpellInfo = GetSpellInfo;

	local ChatEdit_InsertLink = ChatEdit_InsertLink;

	local _G = _G;
	--[[
		local GetLocale = GetLocale;
		local UnitGUID = UnitGUID;
		local GetRealmName = GetRealmName;
		local CreateFrame = CreateFrame;
		local GetAddOnInfo = GetAddOnInfo;
	]]
-->


local setfenv = setfenv;
local _GlobalRef = {  };
local _GlobalAssign = {  };
function __namespace__:BuildEnv(category)
	local _G = _G;
	_GlobalRef[category] = _GlobalRef[category] or {  };
	_GlobalAssign[category] = _GlobalAssign[category] or {  };
	local Ref = _GlobalRef[category];
	local Assign = _GlobalAssign[category];
	setfenv(2, setmetatable(
		{  },
		{
			__index = function(tbl, key, val)
				Ref[key] = (Ref[key] or 0) + 1;
				return _G[key];
			end,
			__newindex = function(tbl, key, value)
				rawset(tbl, key, value);
				Assign[key] = (Assign[key] or 0) + 1;
				return value;
			end,
		}
	));
end
function __namespace__:MergeGlobal(DB)
	local _Ref = DB._GlobalRef;
	if _Ref ~= nil then
		for category, db in next, _Ref do
			local to = _GlobalRef[category];
			if to == nil then
				_GlobalRef[category] = db;
			else
				for key, val in next, db do
					to[key] = (to[key] or 0) + val;
				end
			end
		end
	end
	DB._GlobalRef = _GlobalRef;
	local _Assign = DB._GlobalAssign;
	if _Assign ~= nil then
		for category, db in next, _Assign do
			local to = _GlobalAssign[category];
			if to == nil then
				_GlobalAssign[category] = db;
			else
				for key, val in next, db do
					to[key] = (to[key] or 0) + val;
				end
			end
		end
	end
	DB._GlobalAssign = _GlobalAssign;
end

local CURPHASE = __db__.CURPHASE;

local LOCALE = GetLocale();
local PLAYER_REALM_ID = tonumber(GetRealmID());
local PLAYER_GUID = UnitGUID('player');


local AVAR, VAR, SET, FAV, CMM = nil, nil, nil, nil, nil;


-->		****************
__namespace__:BuildEnv("main");
-->		****************


-->		Core Function
	-->		SafeCall
	local _ErrorHandler = geterrorhandler();
	hooksecurefunc("seterrorhandler", function(ErrorHandler)
		_ErrorHandler = ErrorHandler;
	end);
	function __namespace__.F_SafeCall(func, ...)
		local success, result = xpcall(func,
			function(msg)
				_ErrorHandler(msg);
			end,
			...
		);
		if success then
			return true, result;
		else
			return false;
		end
	end
	local F_SafeCall = __namespace__.F_SafeCall;
	-->		Scheduler
	local T_Scheduler = setmetatable({  }, { __mode = 'k', })
	function __namespace__.F_ScheduleDelayCall(func, delay)
		local sch = T_Scheduler[func];
		if sch == nil then
			sch = {  };
			sch[1] = function()
				func();
				sch[2] = false;
			end;
		elseif sch[2] then
			return;
		end
		sch[2] = true;
		C_Timer_After(delay or 0.2, sch[1]);
	end
	if __namespace__.__is_dev then
		__namespace__._noop_ = function() end;
		__namespace__._log_ = function(...)
			-- print(date('|cff00ff00%H:%M:%S|r'), ...);
		end
		__namespace__._error_ = function(header, child, ...)
			print(date('|cffff0000%H:%M:%S|r'), header, child, ...);
		end
	else
		__namespace__._noop_ = function() end;
		__namespace__._log_ = __namespace__._noop_;
		__namespace__._error_ = __namespace__._noop_;
	end
	-->		Dispatcher
	local F = _G.CreateFrame('FRAME');
	F:SetScript("OnEvent", function(self, event, ...)
		return self[event](...);
	end);
	function __namespace__:RegisterEvent(event, callback)
		F:RegisterEvent(event);
		F[event] = callback or F[event];
	end
	function __namespace__:UnregisterEvent(event)
		F:UnregisterEvent(event);
	end
	local T_FireStack = {  };
	function __namespace__:FireEvent(event, ...)
		local Stack = T_FireStack[event];
		if Stack == nil then
			T_FireStack[event] = { __num = 1, [1] = { ... }, };
		else
			Stack.__num = Stack.__num + 1;
			Stack[Stack.__num] = { ... };
		end
		local func = F[event];
		if func ~= nil then
			return F_SafeCall(func, ...);
		end
	end
	local T_EventCallback = {  };
	--	event, callback(..), method: 'prepend'[, 'append']
	function __namespace__:AddCallback(event, callback, method)
		local new = false;
		local mem = T_EventCallback[event];
		if mem == nil then
			mem = { callback, [callback] = true, __num = 1, };
			T_EventCallback[event] = mem;
			new = true;
		elseif mem[callback] == nil then
			mem.__num = mem.__num + 1;
			if method == 'prepend' then
				tinsert(mem, 1, callback);
			else
				mem[mem.__num] = callback;
			end
			mem[callback] = true;
			new = true;
		elseif method == 'prepend' then
			if mem[1] ~= callback then
				for index = mem.__num, 2, -1 do
					if mem[index] == callback then
						tremove(mem, index);
						mem.__num = mem.__num - 1;
					end
				end
				mem.__num = mem.__num + 1;
				tinsert(mem, 1, callback);
			end
		elseif method == 'append' then
			if mem[mem.__num] ~= callback then
				for index = mem.__num - 1, 1, -1 do
					if mem[index] == callback then
						tremove(mem, index);
						mem.__num = mem.__num - 1;
					end
				end
				mem.__num = mem.__num + 1;
				mem[mem.__num] = callback;
			end
		end
		F[event] = F[event] or function(...)
			for index = 1, mem.__num do
				F_SafeCall(mem[index], ...);
			end
		end
		if new then
			local Stack = T_FireStack[event];
			if Stack ~= nil then
				for index = 1, Stack.__num do
					F_SafeCall(callback, unpack(Stack[index]));
				end
			end
		end
	end
	function __namespace__:DelCallback(event, callback)
		local mem = T_EventCallback[event];
		if mem ~= nil and mem[callback] ~= nil then
			for index = mem.__num, 1, -1 do
				if mem[index] == callback then
					tremove(mem, index);
					mem.__num = mem.__num - 1;
				end
			end
			mem[callback] = nil;
		end
	end
	-->		ADDON_LOADED
	local B_MonitoringAddOnLoad = false;
	local T_AddOnCallback = {  };
	function F.ADDON_LOADED(addon)
		addon = strupper(addon);
		local callback = T_AddOnCallback[addon];
		if callback then
			callback(addon);
		end
	end
	function __namespace__:AddAddOnCallback(addon, callback)
		addon = strupper(addon);
		T_AddOnCallback[addon] = callback;
		if B_MonitoringAddOnLoad and IsAddOnLoaded(addon) then
			return F_SafeCall(callback, addon);
		end
	end
	local function LF_StartMonitoringAddOnLoad()
		F:RegisterEvent("ADDON_LOADED");
		B_MonitoringAddOnLoad = true;
		for addon, callback in next, T_AddOnCallback do
			if IsAddOnLoaded(addon) then
				F_SafeCall(callback, addon);
			end
		end
	end
-->
local F_SafeCall = __namespace__.F_SafeCall;


--		Saved Variables
	function __namespace__.F_ChangeSetWithUpdate(set, key, val)
		set[key] = val;
		set.update = true;
	end
	function __namespace__.F_AddChar(key, VAR, before_initialized)
		if key ~= nil and VAR ~= nil and AVAR[key] == nil then
			local list = SET.char_list;
			for index = #list, 1, -1 do
				if list[index] == key then
					tremove(list, index);
				end
			end
			AVAR[key] = VAR;
			tinsert(list, key);
			if not before_initialized then
				__namespace__.F_uiUpdateAllFrames();
			end
		end
	end
	function __namespace__.F_DelChar(index)
		local list = SET.char_list;
		if index ~= nil and index <= #list then
			local key = list[index];
			if key ~= PLAYER_GUID then
				tremove(list, index);
				AVAR[key] = nil;
				__namespace__.F_uiUpdateAllFrames();
			end
		end
	end
	function __namespace__.F_DelCharByKey(key)
		if key ~= nil then
			local list = SET.char_list;
			for index = 1, #list do
				if list[index] == key then
					__namespace__.F_DelChar(index);
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
		board_pos = { "TOP", "UIParent", "BOTTOM", 260, 190, },
		hide_mtsl = false,
		show_DBIcon = true,
		minimapPos = 0,
		first_auction_mod = "*",
	};
	local default_set = {
		shown = true,
		showSet = false,
		showProfit = false,
		--
		showKnown = true,
		showUnkown = true,
		showHighRank = false,
		filterClass = true,
		filterSpec = true,
		showItemInsteadOfSpell = false,
		showRank = true,
		haveMaterials = false,
		phase = CURPHASE,
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
		phase = CURPHASE,
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
	local function LF_ModifySavedVariable()
		local alaTradeSkillSV = _G.alaTradeSkillSV;
		if alaTradeSkillSV == nil or alaTradeSkillSV._version == nil or alaTradeSkillSV._version < 210605.1 then
			alaTradeSkillSV = {
				set = {
					explorer = default_explorer_set,
				},
				var = {  },
				fav = alaTradeSkillSV ~= nil and alaTradeSkillSV.fav or {  },
				cmm = {  },
				cache = {  },
			};
			_G.alaTradeSkillSV = alaTradeSkillSV;
		elseif alaTradeSkillSV._version < 211227.0 then
			alaTradeSkillSV.cache = {  };
		end
		alaTradeSkillSV._version = 211227.0;
		__namespace__:MergeGlobal(alaTradeSkillSV);
		SET = alaTradeSkillSV.set;
		for pid = __db__.DBMINPID, __db__.DBMAXPID do
			local set = rawget(SET, pid);
			if set ~= nil then
				for key, val in next, default_set do
					if set[key] == nil then
						set[key] = val;
					end
				end
			end
		end
		setmetatable(SET, {
			__index = function(t, pid)
				if __db__.is_pid(pid) then
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
			if rawget(SET, key) == nil then
				rawset(SET, key, val);
			end
		end
		for pid, set in next, SET do
			if __db__.is_pid(pid) or pid == 'explorer' then
				set.update = true;
				-- if set.phase == nil or set.phase < CURPHASE then
					set.phase = CURPHASE;
				-- end
			end
		end
		AVAR = alaTradeSkillSV.var;
		local list = SET.char_list;
		for index = #list, 1, -1 do
			if AVAR[list[index]] == nil then
				tremove(list, index);
			end
		end
		for GUID, VAR in next, AVAR do
			for pid = __db__.DBMINPID, __db__.DBMAXPID do
				local var = rawget(VAR, pid);
				if var ~= nil and __db__.is_pid(pid) then
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
				tinsert(list, GUID);
			end
		end
		if AVAR[PLAYER_GUID] == nil then
			__namespace__.F_AddChar(PLAYER_GUID, { realm_id = PLAYER_REALM_ID, realm_name = _G.GetRealmName(), supreme_list = {  }, }, true);
		end
		VAR = setmetatable(AVAR[PLAYER_GUID], {
			__index = function(t, pid)
				if __db__.is_pid(pid) then
					local temp = { {  }, {  }, update = true, };
					t[pid] = temp;
					return temp;
				else
					return default_var[pid];
				end
			end,
		});
		for pid = __db__.DBMINPID, __db__.DBMAXPID do
			local var = rawget(VAR, pid);
			if var ~= nil and __db__.is_pid(pid) then
				var.update = true;
			end
		end
		FAV = alaTradeSkillSV.fav;
		CMM = alaTradeSkillSV.cmm[PLAYER_REALM_ID];
		if CMM == nil then
			CMM = {  };
			alaTradeSkillSV.cmm[PLAYER_REALM_ID] = CMM;
		end
		__namespace__.SavedVar = alaTradeSkillSV;
		__namespace__.AVAR, __namespace__.VAR, __namespace__.SET, __namespace__.FAV, __namespace__.CMM = AVAR, VAR, SET, FAV, CMM;
		__namespace__.CACHE = alaTradeSkillSV.cache;
	end
-->		Initialize
	local isInitialized = false;
	local function LF_Init()
		if not isInitialized then
			isInitialized = true;
			if not F_SafeCall(LF_ModifySavedVariable) then
				local fav = alaTradeSkillSV.fav;
				alaTradeSkillSV = nil;
				if F_SafeCall(LF_ModifySavedVariable) then
					if type(fav) == 'table' then
						FAV = fav;
						alaTradeSkillSV.fav = fav;
					end
				else
					__namespace__._error_("|cffff0000alaTradeSkill fetal error");
				end
			end
			--
			F_SafeCall(__namespace__.init_db);		--	!!!must be earlier than any others!!!
			F_SafeCall(__namespace__.init_ui);
			F_SafeCall(__namespace__.init_tooltip);
			F_SafeCall(__namespace__.init_cooldown);
			F_SafeCall(__namespace__.init_communication);
			F_SafeCall(__namespace__.init_auctionmod);
			F_SafeCall(LF_StartMonitoringAddOnLoad);
			F_SafeCall(__namespace__.init_libentry);
			for GUID, _ in next, AVAR do
				GetPlayerInfoByGUID(GUID);
			end
			-- F_SafeCall(__namespace__.cmm_InitAddOnMessage);
			for key, val in next, SET do
				if type(val) ~= 'table' then
					__namespace__.ON_SET_CHANGED(key, val, true);
				end
			end
			EnableAddOn("MissingTradeSkillsList_TBC_Data");
			LoadAddOn("MissingTradeSkillsList_TBC_Data");
		end
	end
	local function LOADING_SCREEN_DISABLED()
		__namespace__:UnregisterEvent("LOADING_SCREEN_DISABLED");
		C_Timer_After(1.0, LF_Init);
	end
	__namespace__:RegisterEvent("LOADING_SCREEN_DISABLED", LOADING_SCREEN_DISABLED);
-->



function __namespace__.ON_SET_CHANGED(key, val, loading)
	if key == 'expand' then
		__namespace__.F_uiToggleFrameExpand(val);
	elseif key == 'blz_style' then
		__namespace__.F_uiRefreshFramesStyle(loading);
	elseif key == 'bg_color' then
		__namespace__.F_uiRefreshFramesStyle(loading);
	elseif key == 'show_tradeskill_frame_rank_info' then
		__namespace__.F_uiToggleFrameRankInfo(val);
	elseif key == 'show_tradeskill_frame_price_info' then
		__namespace__.F_uiToggleFramePriceInfo(val);
	elseif key == 'colored_rank_for_unknown' then
		__namespace__.F_uiRefreshAllFrames();
	elseif key == 'regular_exp' then
		for pid, set in next, SET do
			if __db__.is_pid(pid) or pid == 'explorer' then
				set.update = true;
			end
		end
		__namespace__.F_uiUpdateAllFrames();
	elseif key == 'hide_mtsl' then
		__namespace__.hide_mtsl(val);
	else
	end
	if not loading then
		__namespace__.F_uiRefreshConfigFrame();
	end
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
				__namespace__.ON_SET_CHANGED(cmd[3], val);
			end
		else
			print(L["INVALID_COMMANDS"]);
		end
	end
	--	pattern, key, note, func(key, val)
	local SEPARATOR = "[ %`%~%!%@%#%$%%%^%&%*%(%)%-%_%=%+%[%{%]%}%\\%|%;%:%\'%\"%,%<%.%>%/%?]*";
	--	1type, 2pattern, 3key, 4note(string or func), 5proc_func(key, val), 6func_to_mod_val, 7config_type(nil for check), 8cmd_for_config / drop_meta, 9para[slider:{min, max, step}], 10sub_config_on_val
	__namespace__.T_SetCommandList = {
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
						__namespace__.ON_SET_CHANGED('bg_color', SET.bg_color);
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
				__namespace__.F_uiToggleFrameCall(val);
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
				__namespace__.F_uiToggleFrameTab(val);
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
				__namespace__.F_uiToggleFramePortraitButton(val);
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
				__namespace__.F_uiToggleFrame("BOARD", val);
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
				__namespace__.F_uiLockBoard(val);
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
			L.SLASH_NOTE["show_DBIcon"],
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
		{	--	first_auction_mod
			'string',
			"^hide" .. SEPARATOR .. "mtsl" .. SEPARATOR .. "(.+)" .. SEPARATOR .. "$",
			"first_auction_mod",
			L.SLASH_NOTE["first_auction_mod"],
			nil,
			nil,
			'drop',
			[8] = function(self)
				return __namespace__.F_GetAuctionListDropMeta();
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
			local T_SetCommandList = __namespace__.T_SetCommandList;
			for index = 1, #T_SetCommandList do
				local cmd = T_SetCommandList[index];
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
								__namespace__.ON_SET_CHANGED(cmd[3], val);
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
									__namespace__.ON_SET_CHANGED(cmd[3], val);
								end
							else
								print("|cffff0000Invalid parameter: ", pattern2);
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
				__namespace__.F_uiToggleFrame("EXPLORER");
			elseif strfind(pattern, 'conf') then
				__namespace__.F_uiToggleFrame("CONFIG");
			end
			return;
		end
		_, _, pattern = strfind(msg, DUMP_PATTERN);
		if pattern then
			print("AuctionMod Status: ", __namespace__.F_GetAuctionMod() ~= nil);
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
			-- __namespace__.F_uiToggleFrame("CONFIG");
			__namespace__.F_uiToggleFrame("CONFIG");
		end
	end
end

local function DBIcon_OnClick(self, button)
	if button == "RightButton" then
		__namespace__.F_uiToggleFrame("CONFIG");
	else
		__namespace__.F_uiToggleFrame("EXPLORER");
	end
end
function __namespace__.init_libentry()
	if LibStub ~= nil then
		local LDI = LibStub("LibDBIcon-1.0", true);
		if LDI ~= nil then
			LDI:Register("alaTradeSkill",
				{
					icon = [[Interface\AddOns\alaTradeSkill\Media\Textures\alaTradeSkill]],
					OnClick = DBIcon_OnClick,
					text = L.DBIcon_Text,
					OnTooltipShow = function(tt)
						tt:AddLine("alaTradeSkill");
						tt:AddLine(" ");
						for _, text in next, L.TooltipLines do
							tt:AddLine(text);
						end
					end
				},
				{
					minimapPos = SET.minimapPos,
				}
			);
			if SET.show_DBIcon then
				LDI:Show("alaTradeSkill");
			else
				LDI:Hide("alaTradeSkill");
			end
			local mb = LDI:GetMinimapButton("alaTradeSkill");
			mb:RegisterEvent("PLAYER_LOGOUT");
			mb:HookScript("OnEvent", function(self)
				SET.minimapPos = self.minimapPos or self.db.minimapPos;
			end);
			mb:HookScript("OnDragStop", function(self)
				SET.minimapPos = self.minimapPos or self.db.minimapPos;
			end);
		end
	end
end

local extern_setting = {  };
__ala_meta__.prof.extern_setting = extern_setting;
do	--	EXTERN SETTING
	function extern_setting.toggle_tradeskill_frame_rank(on)
		SET.show_tradeskill_frame_rank_info = on;
		__namespace__.ON_SET_CHANGED('show_tradeskill_frame_rank_info', on);
	end
	function extern_setting.toggle_tradeskill_frame_price_info(on)
		SET.show_tradeskill_frame_price_info = on;
		__namespace__.ON_SET_CHANGED('show_tradeskill_frame_price_info', on);
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
		__namespace__.F_uiToggleFrame("BOARD", on);
	end
	function extern_setting.toggle_tradeskill_board_lock(on)
		SET.lock_board = on;
		__namespace__.F_uiLockBoard(on);
	end
	function extern_setting.toggle_tradeskill_blz_style(on)
		SET.blz_style = on;
		__namespace__.F_uiRefreshFramesStyle();
	end

	function extern_setting.set_tradeskill_bg_color(r, g, b, a)
		SET.bg_color[1] = r or SET.bg_color[1];
		SET.bg_color[2] = g or SET.bg_color[2];
		SET.bg_color[3] = b or SET.bg_color[3];
		SET.bg_color[4] = a or SET.bg_color[4];
		__namespace__.ON_SET_CHANGED('bg_color', SET.bg_color);
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

	if select(2, _G.GetAddOnInfo('\33\33\33\49\54\51\85\73\33\33\33')) then
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


-->		Definition
local GetSpellCooldown = _G.GetSpellCooldown;
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


if __namespace__.__is_classic then
	local function F_GetSkillLink(sid)
		local name = GetSpellInfo(sid);
		if name then
			return "|cffffffff|Henchant:" .. sid .. "|h[" .. name .. "]|h|r";
		else
			return nil;
		end
	end
	__namespace__.F_GetSkillLink = F_GetSkillLink;
	function __namespace__.F_HandleShiftClick(pid, sid)
		local set = SET[pid];
		local cid = __db__.get_cid_by_sid(sid);
		if cid then
			ChatEdit_InsertLink(__db__.item_link(cid), __addon__);
		else
			ChatEdit_InsertLink(F_GetSkillLink(sid), __addon__);
		end
	end
elseif __namespace__.__is_bcc then
	local function F_GetSkillLink(sid)
		local name = GetSpellInfo(sid);
		if name then
			return "|cffffd000|Henchant:" .. sid .. "|h[" .. name .. "]|h|r";
		else
			return nil;
		end
	end
	__namespace__.F_GetSkillLink = F_GetSkillLink;
	function __namespace__.F_HandleShiftClick(pid, sid)
		local set = SET[pid];
		if set.showItemInsteadOfSpell then
			local cid = __db__.get_cid_by_sid(sid);
			if cid then
				ChatEdit_InsertLink(__db__.item_link(cid), __addon__);
			else
				ChatEdit_InsertLink(F_GetSkillLink(sid), __addon__);
			end
		else
			ChatEdit_InsertLink(F_GetSkillLink(sid), __addon__);
		end
	end
else
	local function F_GetSkillLink(sid)
		return nil;
	end
	__namespace__.F_GetSkillLink = F_GetSkillLink;
	function __namespace__.F_HandleShiftClick(pid, sid)
	end
end

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
	local __ChatEdit_InsertLink = _G.ChatEdit_InsertLink;
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

-->
