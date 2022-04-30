--[[--
	by ALA @ 163UI
--]]--
----------------------------------------------------------------------------------------------------
local _G = _G;
local __ala_meta__ = _G.__ala_meta__;
local uireimp = __ala_meta__.uireimp;
local __raidlib = __ala_meta__.__raidlib;

local ADDON, NS = ...;
__ala_meta__.cal = NS;
local __isdev = select(2, GetAddOnInfo("!!!!!DebugMe")) ~= nil;

local _G = _G;
local setfenv = setfenv;
local rawset = rawset;
local next = next;
local _GlobalRef = {  };
local _GlobalAssign = {  };
function NS:BuildEnv(category)
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
function NS:MergeGlobal(DB)
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


local LOCALE = GetLocale();
----------------------------------------------------------------------------------------------------upvalue
	----------------------------------------------------------------------------------------------------LUA
	local date, time = date, time;
	local select, next, inext = select, next, ipairs({  });
	local type, tonumber, tostring = type, tonumber, tostring;
	local getfenv, setfenv, pcall = getfenv, setfenv, pcall;
	local abs, ceil, floor, max, min = abs, ceil, floor, max, min;
	local format, gsub, strlen, strlower, strmatch, strsub, strupper, strsplit = format, gsub, string.len, string.lower, string.match, string.sub, string.upper, string.split;
	local getmetatable, setmetatable, rawget, rawset = getmetatable, setmetatable, rawget, rawset;
	local tinsert, tremove, wipe, unpack = tinsert, tremove, wipe, unpack;
	----------------------------------------------------------------------------------------------------GAME
	local C_Timer = C_Timer;
	local print = print;
	local GetServerTime = GetServerTime;
	local CreateFrame = CreateFrame;
	--------------------------------------------------
	local RegisterAddonMessagePrefix = RegisterAddonMessagePrefix or C_ChatInfo.RegisterAddonMessagePrefix;
	local IsAddonMessagePrefixRegistered = IsAddonMessagePrefixRegistered or C_ChatInfo.IsAddonMessagePrefixRegistered;
	local GetRegisteredAddonMessagePrefixes = GetRegisteredAddonMessagePrefixes or C_ChatInfo.GetRegisteredAddonMessagePrefixes;
	local SendAddonMessage = SendAddonMessage or C_ChatInfo.SendAddonMessage;
	local SendAddonMessageLogged = SendAddonMessageLogged or C_ChatInfo.SendAddonMessageLogged;
	--------------------------------------------------
	local Ambiguate = Ambiguate;
	local C_Map = C_Map;
	local C_QuestLog = C_QuestLog;
	local GetGossipAvailableQuests = GetGossipAvailableQuests;
	local UnitGUID = UnitGUID;
	local GetQuestID = GetQuestID;
	local IsInRaid, IsInGroup = IsInRaid, IsInGroup;
	local GetGuildInfo = GetGuildInfo;
	local GetPlayerInfoByGUID = GetPlayerInfoByGUID;
	local LE_PARTY_CATEGORY_HOME, LE_PARTY_CATEGORY_INSTANCE = LE_PARTY_CATEGORY_HOME, LE_PARTY_CATEGORY_INSTANCE;
	local GetDailyQuestsCompleted, GetMaxDailyQuests = GetDailyQuestsCompleted, GetMaxDailyQuests;
	local GetQuestResetTime = GetQuestResetTime;
	local GetQuestsCompleted = GetQuestsCompleted;
	local GetNumSavedInstances, GetSavedInstanceInfo, GetSavedInstanceEncounterInfo = GetNumSavedInstances, GetSavedInstanceInfo, GetSavedInstanceEncounterInfo;
	--------------------------------------------------
	local GameTooltip = GameTooltip;
	local RAID_CLASS_COLORS = RAID_CLASS_COLORS;
	local CLASS_ICON_TCOORDS = CLASS_ICON_TCOORDS;
	local _ = nil;
	local function _log_(...)
		print(date('\124cff00ffff%H:%M:%S\124r cal'), ...);
	end
	local function _noop_()
	end
	--------------------------------------------------
	local NUM_ROW = 6;
	local NUM_COL = 7;
	local ui_style = {
		texture_white = "Interface\\Buttons\\WHITE8X8",
		texture_unk = "Interface\\Icons\\inv_misc_questionmark",
		texture_highlight = "Interface\\Buttons\\UI-Common-MouseHilight",
		texture_triangle = "interface\\transmogrify\\transmog-tooltip-arrow",
		texture_arrowleft = "Interface\\AddOns\\alaCalendar\\ARTWORK\\ArrowLeft",
		texture_arrowright = "Interface\\AddOns\\alaCalendar\\ARTWORK\\ArrowRight",
		texture_collapsed = "Interface\\AddOns\\alaCalendar\\ARTWORK\\PlusButtonClear",
		texture_expanded = "Interface\\AddOns\\alaCalendar\\ARTWORK\\MinusButtonClear",
		texture_claw = "interface\\timer\\panda-logo",
		texture_config = "Interface\\AddOns\\alaCalendar\\ARTWORK\\Config",
		texture_triangle_normal_color = { 0.5, 0.5, 0.5, 1.0, },
		texture_triangle_pushed_color = { 0.25, 0.25, 0.25, 1.0, },
		texture_close = "Interface\\AddOns\\alaCalendar\\ARTWORK\\Close",
		texture_reset = "Interface\\Buttons\\UI-RefreshButton",

		frameTitle_YSize = 48,

		cal_XToBorder = 4,
		cal_YToBorder = 4,

		weekTitle_YSize = 30,
		weekTitle_BG = "Interface\\Calendar\\CalendarBackground",
		weekTitle_BG_Coord = { 0.0, 0.3515625, 0.72265625, 0.81640625, },

		cell_YToWeekTitle = 4,
		cell_XSize = 90,
		cell_YSize = 90,
		cell_XInt = 0,
		cell_YInt = 0,
		cell_BG = "Interface\\Calendar\\CalendarBackground",
		cell_BG_Coord = { 0.0, 0.3515625, 0.0, 0.3515625, },
		cell_this_month_maskColor = { 0.25, 0.25, 0.25, 0.5, },
		cell_today_mask_color = { 1.0, 0.5, 0.0, 1.0, },
		cell_Highlight = "interface\\buttons\\checkbuttonhilight",
		cell_HighlightCoord = { 0.05, 0.95, 0.05, 0.95, },

		--
		board_XSize = 360,
		board_YSize = 600,

		board_buttonHeight = 24,
		buttonHighlightColor = { 0.5, 0.5, 0.0, 0.25, },
		buttonGlowColor = { 0.0, 0.25, 0.0, 0.15, },

		char_buttonHeight = 32,

		frameFont = SystemFont_Shadow_Med1:GetFont(),--=="Fonts\ARKai_T.ttf"
		frameFontSize = min(select(2, SystemFont_Shadow_Med1:GetFont()) + 1, 15),
		frameFontOutline = "NORMAL",
		weekTitleFontSize = min(select(2, SystemFont_Shadow_Med1:GetFont()) + 5, 18),
		cellTitleFontSize = min(select(2, SystemFont_Shadow_Med1:GetFont()) + 5, 18),
		bigFontSize = 32,
		smallFontSize = select(2, SystemFont_Shadow_Med1:GetFont()),

		today_color = { 0.5, 0.75, 1.0, 0.9, },
		ad_color = { 0.25, 0.5, 0.75, 0.9, },

	};
	ui_style.cal_XSize = ui_style.cell_XSize * (NUM_COL) + ui_style.cell_XInt * (NUM_COL - 1);
	ui_style.cal_YSize = ui_style.weekTitle_YSize + ui_style.cell_YToWeekTitle + ui_style.cell_YSize * (NUM_ROW) + ui_style.cell_YInt * (NUM_ROW - 1);
	ui_style.frame_XSize = ui_style.cal_XToBorder * 2 + ui_style.cal_XSize;
	ui_style.frame_YSize = ui_style.frameTitle_YSize + ui_style.cal_YToBorder * 2 + ui_style.cal_YSize;
	ui_style.festival_Size = min(ui_style.cell_XSize, ui_style.cell_YSize) * 0.45;
	ui_style.cell_inst_Size = min(ui_style.cell_XSize * 0.25, ui_style.cell_YSize * 0.25);
	--
	_G.ala_cal_ui_style = ui_style;
	--
	local BIG_NUMBER = 4294967295;
	--[[
		-- "Interface\\Buttons\\WHITE8X8",
		-- "Interface\\Tooltips\\UI-Tooltip-Background",
		-- "Interface\\ChatFrame\\ChatFrameBackground"
		alaCalendarSV = {
			var = {
				[GUID] = {
					[instance] = bool,
					realm_id = number,
					realm_name = string,
				},
			},
			set = {
				first_col_day = bool,
				[instance] = bool,
			},
			_version = number,
		}
	]]
----------------------------------------------------------------------------------------------------
local L = NS.L;
L.INSTANCE = __raidlib.__raid_meta.L[LOCALE] or __raidlib.__raid_meta.L['*'];

local ARTWORK_ICON_PATH = "Interface\\AddOns\\alaCalendar\\ARTWORK\\ICON";
---------------------------------------------------------------------------------------------------
local AVAR, VAR, SET = nil, nil, nil;
local gui = {  };
local DB = nil;

local PLAYER_GUID = UnitGUID('player');
local PLAYER_NAME = UnitName('player');
local PLAYER_REALM_ID = tonumber(GetRealmID());
local PLAYER_REALM_NAME = GetRealmName();
local PLAYER_FULLNAME = PLAYER_NAME .. "-" .. PLAYER_REALM_NAME;

local function info_OnEnter(self)
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
	if self.info_lines then
		for _, v in next, self.info_lines do
			GameTooltip:AddLine(v);
		end
	end
	GameTooltip:Show();
end
local function info_OnLeave(self)
	if GameTooltip:IsOwned(self) then
		GameTooltip:Hide();
	end
end
local function IsEastAsiaFormat()
	return LOCALE == "zhCN" or LOCALE == "zhTW" or LOCALE == "koKR";
end

NS:BuildEnv("cal");

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
local T_Scheduler = setmetatable({  }, { __mode = 'k', })
function NS.F_ScheduleDelayCall(func, delay)
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
	C_Timer.After(delay or 0.2, sch[1]);
end

do	--	util
	local data_valid_time = 86400;
	function NS.seconds_to_colored_formatted_time_len(sec)
		local p = max(0.0, 1.0 - sec / data_valid_time);
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
	function NS.seconds_to_formatted_time(sec)
		if sec and type(sec) == 'number' then
			return date(L["FORMATTED_TIME"], sec);
		end
	end
	function NS.seconds_to_formatted_time_len(sec)
		local d = floor(sec / 86400);
		sec = sec % 86400;
		local h = floor(sec / 3600);
		sec = sec % 3600;
		local m = floor(sec / 60);
		sec = sec % 60;
		if d > 0 then
			return format(L["FORMATTED_TIME_LEN"][1], d, h, m, sec);
		elseif h > 0 then
			return format(L["FORMATTED_TIME_LEN"][2], h, m, sec);
		elseif m > 0 then
			return format(L["FORMATTED_TIME_LEN"][3], m, sec);
		else
			return format(L["FORMATTED_TIME_LEN"][4], sec);
		end
	end
end

do	--	MAIN
	local date_engine = {  };
	do	--	date_engine
		local const_epoch = { 1970, 1, 1, 0, 0, 0, 4, 0, };
		do
			const_epoch[8] = const_epoch[8] - const_epoch[6] - const_epoch[5] * 60 - const_epoch[4] * 3600;
			const_epoch[4] = 0;
			const_epoch[5] = 0;
			const_epoch[6] = 0;
			if const_epoch[2] ~= 1 or const_epoch[3] ~= 1 then
				local ofs_days = date_engine.get_year_day_index(const_epoch[1], const_epoch[2], const_epoch[3]) - 1;
				const_epoch[2] = 1;
				const_epoch[3] = 1;
				const_epoch[7] = (const_epoch[7] - ofs_days) % NUM_COL;
				const_epoch[8] = const_epoch[8] - ofs_days * 86400;
			end
		end
		local month_days = { 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31, };
		function date_engine.time()
			return GetServerTime();
		end
		function date_engine.date(_format, _time)
			_time = _time or date_engine.time();
			return date(_format, _time);
		end
		function date_engine.built_in_date(_format, _time)
			_time = _time or date_engine.time();
			local Y, m, d, W, R = date_engine.get_localized_ofs_date_val(_time);
			local H = floor(R / 3600);
			local M = floor((R % 3600) / 60);
			local S = R % 60;
			_format = gsub(_format, "%%[Yy]", Y);
			_format = gsub(_format, "%%m", format("%02d", m));
			_format = gsub(_format, "%%[Bb]", L.MONTH[m]);
			_format = gsub(_format, "%%d", format("%02d", d));
			_format = gsub(_format, "%%H", format("%02d", H));
			_format = gsub(_format, "%%M", format("%02d", M));
			_format = gsub(_format, "%%S", format("%02d", S));
			_format = gsub(_format, "%%w", W);
			_format = gsub(_format, "%%lw", L.WEEKTITLE[W]);
			_format = gsub(_format, "%%%%", "%%");
			return _format;
		end
		function date_engine.get_user_time_zone()
			local utc = date("!*t");
			local loc = date("*t");
			--	year, month, day, hour, min, sec, wday, yday, isdst
			local sec = ((loc.year == utc.year) and (loc.yday - utc.yday) * 86400 or ((loc.year > utc.year) and 86400 or -86400)) +
						(loc.hour - utc.hour) * 3600 + (loc.min - utc.min) * 60 + (loc.sec - utc.sec);
			if sec == 0 then
				return 0;
			elseif sec > 0 then
				return floor((sec + 1800) / 3600);
			else
				return ceil((sec - 1800) / 3600);
			end
		end
		function date_engine.get_month_days(Y, M)
			if M == 2 then
				--	mod4 = 0 and mod100 ~= 0
				--	mod400 == 0 and mod3200 ~= 0
				--	mod172800 == 0
				--[[if Y % 172800 == 0 then
					return 29;
				elseif Y % 3200 == 0 then
					return 28;
				else--]]if Y % 400 == 0 then
					return 29;
				elseif Y % 100 == 0 then
					return 28;
				elseif Y % 4 == 0 then
					return 29;
				else
					return 28;
				end
			else
				return month_days[M];
			end
		end
		function date_engine.get_year_days(Y)
				--	mod4 = 0 and mod100 ~= 0
				--	mod400 == 0 and mod3200 ~= 0
				--	mod172800 == 0
				--[[if Y % 172800 == 0 then
					return 366;
				elseif Y % 3200 == 0 then
					return 365;
				else--]]if Y % 400 == 0 then
					return 366;
				elseif Y % 100 == 0 then
					return 365;
				elseif Y % 4 == 0 then
					return 366;
				else
					return 365;
				end
		end
		function date_engine.get_year_remaining_days(Y, M, D)
			local days = date_engine.get_month_days(Y, M) - D + 1;
			for month = M + 1, 12 do
				days = days + date_engine.get_month_days(Y, month);
			end
			return days;
		end
		function date_engine.get_year_day_index(Y, M, D)
			local days = 0;
			for month = 1, M - 1 do
				days = days + date_engine.get_month_days(Y, month);
			end
			days = days + D;
			return days;
		end
		function date_engine.localized_ofs(val)
			if SET.dst then
				return val - (date_engine.timeZone + 1) * 3600;
			else
				return val - date_engine.timeZone * 3600;
			end
		end
		function date_engine.get_localized_ofs_date_val(val)		--	localized_ofs time modified by timeZone offset [time - timeZone * 3600]
			-- val = date_engine.localized_ofs(val);
			local Y, M, D, h, m, s, w, ofs = unpack(const_epoch);
			ofs = date_engine.localized_ofs(ofs);
			--	M, D are always 1	h, m, s are always 0
			w = (w + floor((val - ofs) / 86400)) % NUM_COL;
			while true do
				local yhs = date_engine.get_year_days(Y) * 86400;
				if ofs + yhs < val then
					Y = Y + 1;
					ofs = ofs + yhs;
				elseif ofs + yhs == val then
					Y = Y + 1;
					return Y, 1, 1, w, 0;
				else
					while true do
						local mhs = date_engine.get_month_days(Y, M) * 86400;
						if ofs + mhs < val then
							M = M + 1;
							ofs = ofs + mhs;
						elseif ofs + mhs == val then
							M = M + 1;
							return Y, M, 1, w, 0;
						else
							local diff = val - ofs;
							return Y, M, 1 + floor(diff / 86400), w, diff % 86400;
						end
					end
				end
			end
		end
		function date_engine.get_localized_start_of_day(val)
			val = val or date_engine.time();
			if SET.dst then
				return val - (val + (date_engine.timeZone + 1) * 3600) % 86400;
			else
				return val - (val + date_engine.timeZone * 3600) % 86400;
			end
		end

		function NS.set_time_zone()
			date_engine.timeZone = SET.use_realm_time_zone and NS.realmTimeZone or date_engine.userTimeZone;
		end
		function NS.InitTimeZone()
			local userTimeZone = date_engine.get_user_time_zone();
			date_engine.userTimeZone = userTimeZone;
			NS.apply_region[SET.region]();
			NS.set_time_zone();
		end
		function date_engine.inst_next_reset(inst)
			local val = NS.milestone[inst];
			if val ~= nil then
				if val.type == "fixed_cycle" then
					return val[1] + floor((date_engine.time() + val[2] - val[1]) / val[2]) * val[2];
				else
				end
			end
		end
	end
	NS.date_engine = date_engine;

	local extern_list = {  };
	do	--	external
		function NS.ext_Reset()
			wipe(extern_list);
		end
		--	inst	= 'string' or 'number' or table{ tex, coord, title, color, } or function(text)return tex, coord, title, color
		--	text	= 'string' or 'number' or table{ tex, coord, title, color, } or function(inst)return tex, coord, title, color
		function NS.ext_RegHeader(inst, text)
			if extern_list[inst] == nil then
				extern_list[inst] = { text = text, };
				return;
			else
				return false;
			end
		end
		--	key		= 'string' or 'number' or table{ tex, coord, title, color_title, } or function(inst, val)return tex, coord, title, color_title
		--	val		= 'string' or 'number' or table{ tex, coord, title, color_title, cool, color_cool, } or function(inst, key)return tex, coord, title, color_title, cool, color_cool
		function NS.ext_AddLine(inst, key, val)
			local list = extern_list[inst];
			if list then
				list[key] = val;
				return true;
			else
				return false;
			end
		end
		function NS.ext_UpdateBoard()
			local board = gui["BOARD"];
			if board then
				board:update_list();
				if board:IsShown() then
					board:update_func();
				end
			end
		end
	end

	do	--	func
		local function cal_and_val(Y1, M1, D1, W1)
			while M1 <= 0 do
				M1 = M1 + 12;
				Y1 = Y1 - 1;
			end
			while M1 > 12 do
				M1 = M1 - 12;
				Y1 = Y1 + 1;
			end
			local N1 = date_engine.get_month_days(Y1, M1);
			local W1S = (W1 - D1 + 1) % NUM_COL;
			local W1E = (W1 - D1 + N1) % NUM_COL;
			local PS1 = (W1S - SET.first_col_day) % NUM_COL + 1;
			local PE1 = (W1E - SET.first_col_day) % NUM_COL + 1;	--	((SET.first_col_day - 1) % NUM_COL - W1E) % NUM_COL;
			local L1 = (PS1 - 1 + N1 + NUM_COL - PE1) / NUM_COL;
			return Y1, M1, D1, N1, W1S, W1E, PS1, PE1, L1;
		end
		function NS.proc_update_calendar(frame)
			--	local
				local var = frame.var;
				local now = date_engine.time();
				local Y, M, D, W, R = date_engine.get_localized_ofs_date_val(now);							--	TODAY
				local Y1, M1, D1, W1, N1, W1S, W1E, PS1, PE1, L1 = Y, M, 1, (W + 1 - D) % NUM_COL;		--	BASE DATE OF PROCESSING
				local NOW1 = now - R - (D - 1) * 86400;
				local Y0, M0, D0, N0, NOW0;																--	DATE of cell{ col = 1, row = 1 }
			--	proc var
				local month_ofs = var.month_ofs;
				local line_ofs = var.line_ofs;
				if month_ofs ~= 0 then
					local M1days = 0;
					if month_ofs > 0 then
						for ofs = 0, month_ofs - 1 do
							M1days = M1days + date_engine.get_month_days(Y1, M1);
							M1 = M1 + 1;
							if M1 > 12 then
								Y1 = Y1 + 1;
								M1 = 1;
							end
						end
					else
						for ofs = 0, month_ofs + 1, -1 do
							M1 = M1 - 1;
							if M1 <= 0 then
								Y1 = Y1 - 1;
								M1 = 12;
							end
							M1days = M1days - date_engine.get_month_days(Y1, M1);
						end
					end
					W1 = (W1 + M1days) % NUM_COL;
					NOW1 = NOW1 + M1days * 86400;
				end
				Y1, M1, D1, N1, W1S, W1E, PS1, PE1, L1 = cal_and_val(Y1, M1, D1, W1);
				-- _log_("1#B", Y1 .. '-' .. M1 .. '-' .. D1 .. '#' .. W1, month_ofs, line_ofs, N1, "S" .. W1S, "E" .. W1E);
				--
				if line_ofs < 0 then
					while true do
						local tm1 = M1 - 1;
						local ty1 = Y1;
						if tm1 <= 0 then
							tm1 = 12;
							ty1 = ty1 - 1;
						end
						local tM1days = date_engine.get_month_days(ty1, tm1);
						local tW1 = (W1 - tM1days) % NUM_COL;
						local tY1, tM1, tD1, tN1, tW1S, tW1E, tPS1, tPE1, tL1 = cal_and_val(ty1, tm1, D1, tW1);
						if -line_ofs >= tL1 then
							month_ofs = month_ofs - 1;
							line_ofs = line_ofs + tL1;
							if PS1 ~= 1 then
								line_ofs = line_ofs - 1;
							end
							W1 = tW1;
							Y1, M1, D1, N1, W1S, W1E, PS1, PE1, L1 = tY1, tM1, tD1, tN1, tW1S, tW1E, tPS1, tPE1, tL1;
							NOW1 = NOW1 - tM1days * 86400;
						else
							local days0 = - line_ofs * NUM_COL + PS1 - 1;
							if days0 > NUM_COL * NUM_ROW * 0.5 then
								month_ofs = month_ofs - 1;
								line_ofs = line_ofs + tL1; 
								if PS1 ~= 1 then
									line_ofs = line_ofs - 1;
								end
								W1 = tW1;
								Y1, M1, D1, N1, W1S, W1E, PS1, PE1, L1 = tY1, tM1, tD1, tN1, tW1S, tW1E, tPS1, tPE1, tL1;
								NOW1 = NOW1 - tM1days * 86400;
							else
								break;
							end
						end
					end
				elseif line_ofs > 0 then
					while true do
						if line_ofs >= L1 then
							local M1days = date_engine.get_month_days(Y1, M1);
							month_ofs = month_ofs + 1;
							line_ofs = line_ofs - L1;
							W1 = (W1 + M1days) % NUM_COL;
							Y1, M1, D1, N1, W1S, W1E, PS1, PE1, L1 = cal_and_val(Y1, M1 + 1, D1, W1);
							NOW1 = NOW1 + M1days * 86400;
							if PS1 ~= 1 then
								line_ofs = line_ofs + 1;
							end
						else
							local days0 = (L1 - 1 - line_ofs) * NUM_COL + PE1;
							if days0 < NUM_COL * NUM_ROW * 0.5 then
								local M1days = date_engine.get_month_days(Y1, M1);
								month_ofs = month_ofs + 1;
								line_ofs = line_ofs - L1;
								W1 = (W1 + M1days) % NUM_COL;
								Y1, M1, D1, N1, W1S, W1E, PS1, PE1, L1 = cal_and_val(Y1, M1 + 1, D1, W1);
								NOW1 = NOW1 + M1days * 86400;
								if PS1 ~= 1 then
									line_ofs = line_ofs + 1;
								end
							else
								break;
							end
						end
					end
				end
				-- _log_("2#B", Y1 .. '-' .. M1 .. '-' .. D1 .. '#' .. W1, month_ofs, line_ofs, N1, "S" .. W1S, "E" .. W1E);
				if line_ofs > 0 then
					Y0, M0, N0 = Y1, M1, N1;
					D0 = (line_ofs - 1) * NUM_COL + NUM_COL - PS1 + 1 + 1;
					NOW0 = NOW1 + (D0 - D1) * 86400;
				elseif line_ofs < 0 then
					M0 = M1 - 1;
					if M0 <= 0 then
						Y0 = Y1 - 1;
						M0 = 12;
					else
						Y0 = Y1;
					end
					N0 = date_engine.get_month_days(Y0, M0);
					D0 = N0 + 1 - (- line_ofs) * NUM_COL - PS1 + D1;
					NOW0 = NOW1 - (N0 - D0 + D1) * 86400;
				else
					if PS1 == 1 then
						Y0, M0, D0, N0, NOW0 = Y1, M1, D1, N1, NOW1;
					else
						M0 = M1 - 1;
						if M0 <= 0 then
							Y0 = Y1 - 1;
							M0 = 12;
						else
							Y0 = Y1;
						end
						N0 = date_engine.get_month_days(Y0, M0);
						D0 = N0 + 1 - PS1 + D1;
						NOW0 = NOW1 - (N0 - D0 + D1) * 86400;
					end
				end
				var.month_ofs = month_ofs;
				var.line_ofs = line_ofs;
				var.first_cell_time = { Y0, M0, D0, N0, NOW0, };
				var.center_cell_time = { Y1, M1, D1, N1, NOW1, };
			--	gui
				if IsEastAsiaFormat() then
					frame:SetDateLeftText(format(L.YEAR_FORMAT, Y1));
					frame:SetDateRightText(format(L.MONTH_FORMAT, L.MONTH[M1]));
				else
					frame:SetDateRightText(format(L.YEAR_FORMAT, Y1));
					frame:SetDateLeftText(format(L.MONTH_FORMAT, L.MONTH[M1]));
				end
				local cells = frame.cells;
				local ofs = 0;
				local dst_ofs = SET.dst and 3600 or 0;
				--
				for col = 1, NUM_ROW do
					local rc = cells[col];
					for row = 1, NUM_COL do
						local cell = rc[row];
						cell:SetTitle(M0 .. "-" .. D0);
						if M0 == M1 then
							cell:Bright();
						else
							cell:Dark();
						end
						if Y0 == Y and M0 == M and D0 == D then
							cell:Today();
						else
							cell:NotToday();
						end
						cell.now = NOW0;
						cell:HideFestival1Tex();
						cell:HideFestival2Tex();
						cell:HideCurtain1Tex();
						cell:HideCurtain2Tex();
						local info = nil;
						local info_line_num = 0;
						cell:ResetInstance();
						local state = cell.state;
						wipe(state);
						for _, inst in inext, NS.milestone_list, 0 do
							if SET.inst_hash[inst] then
								local val = NS.milestone[inst];
								if val and val.phase <= NS.CUR_PHASE then
									local first_seen = val.dst and (val[1] - dst_ofs) or val[1];
									local start_of_day_first_seen = date_engine.get_localized_start_of_day(first_seen);
									if NOW0 >= start_of_day_first_seen then
										if val.type == "fixed_cycle" then
											local diff = (NOW0 - start_of_day_first_seen) % val[2];
											local end_time_ofs = val[5] + first_seen - start_of_day_first_seen;
											if diff <= max(end_time_ofs, 86400 - 1) then			--	in the range of dur, at least one day
												if diff < 86400 then						--	the first day
													if val.festival then
														if val.texture_channel2 then
															cell:SetFestival2Tex(val[6]);
															if val[9] then
																cell:SetFestival2TexCoord(unpack(val[9]));
															end
														else
															cell:SetFestival1Tex(val[6]);
															if val[9] then
																cell:SetFestival1TexCoord(unpack(val[9]));
															end
														end
													end
													if end_time_ofs < 86400 then
														state[inst] = 2;
													else
														state[inst] = 1;
													end
												else
													local last_day_remaining = end_time_ofs % 86400;
													if last_day_remaining == 0 then
														last_day_remaining = 86400;
													end
													if diff + 86400 > end_time_ofs - last_day_remaining then
														state[inst] = -1;
													else
														state[inst] = 0;
													end
												end
												if val[7] then
													if val.curtain_channel2 then
														cell:SetCurtain2Tex(val[7]);
														if val[10] then
															cell:SetCurtain2TexCoord(unpack(val[10]));
														end
													else
														cell:SetCurtain1Tex(val[7]);
														if val[10] then
															cell:SetCurtain1TexCoord(unpack(val[10]));
														end
													end
												end
												if val.instance then
													if SET.instance_icon then
														cell:AddInstance(val[6], val[9]);
													end
													if SET.instance_text then
														if info_line_num >= 2 then
															info = info and (info .. "\n" .. inst) or inst;
															info_line_num = 1;
														else
															info = info and (info .. ", " .. inst) or inst;
															info_line_num = info_line_num + 1;
														end
													end
												end
											end
										elseif val.type == "month_week_day" then
											local fit = false;
											if val[2] and val[2] > 1 then
												local y, m = date_engine.get_localized_ofs_date_val(first_seen);
												local n_month = (Y0 - y) * 12 + (M0 - m);
												fit = n_month % val[2] == 0;
											else
												fit = true;
											end
											if fit then
												local day_check = (val[3] - ((row + SET.first_col_day - 1) % NUM_COL - D0 + 1) % NUM_COL + 1) % NUM_COL;
												day_check = day_check == 0 and 7 or day_check;
												local diff = (D0 - day_check) * 86400;-- + (to_ddate_engineate.timeZone - NS.realmTimeZone) * 3600;
												local start_ofs = val[4] + (date_engine.timeZone - NS.realmTimeZone) * 3600;
												if (diff + 86400 - 1) >= start_ofs and diff < (start_ofs + val[5]) then
													if diff < (floor(start_ofs / 86400) * 86400 + 86400) then		--	the first day
														if val.festival then
															if val.texture_channel2 then
																cell:SetFestival2Tex(val[6]);
																if val[9] then
																	cell:SetFestival2TexCoord(unpack(val[9]));
																end
															else
																cell:SetFestival1Tex(val[6]);
																if val[9] then
																	cell:SetFestival1TexCoord(unpack(val[9]));
																end
															end
														end
														if (start_ofs + val[5]) < (diff + 86400) then
															state[inst] = 2;
														else
															state[inst] = 1;
														end
													else
														if diff < (start_ofs + val[5] - 86400) then
															if val[7] then
																if val.curtain_channel2 then
																	cell:SetCurtain2Tex(val[7]);
																	if val[10] then
																		cell:SetCurtain2TexCoord(unpack(val[10]));
																	end
																else
																	cell:SetCurtain1Tex(val[7]);
																	if val[10] then
																		cell:SetCurtain1TexCoord(unpack(val[10]));
																	end
																end
															end
															state[inst] = 0;
														else
															if val[7] then
																if val.texture_channel2 then
																	cell:SetFestival2Tex(val[8]);
																	if val[11] then
																		cell:SetFestival2TexCoord(unpack(val[11]));
																	end
																else
																	cell:SetFestival1Tex(val[8]);
																	if val[11] then
																		cell:SetFestival1TexCoord(unpack(val[11]));
																	end
																end
															end
															state[inst] = -1;
														end
													end
													if val.instance then
														if SET.instance_icon then
															cell:AddInstance(val[6], val[9]);
														end
														if SET.instance_text then
															info = info and (info .. "\n" .. inst) or inst;
														end
													end
												end
											end
										end
									end
								end
							end
						end
						cell:RefreshInstance();
						if SET.instance_text and info ~= nil then
							cell:SetInfo("\124cffbfffff" .. info .. "\124r");
						else
							cell:SetInfo(nil);
						end
						D0 = D0 + 1;
						NOW0 = NOW0 + 86400;
						if D0 > N0 then
							M0 = M0 + 1;
							if M0 > 12 then
								Y0 = Y0 + 1;
								M0 = 1;
							end
							D0 = 1;
							N0 = date_engine.get_month_days(Y0, M0);
						end
					end
				end
		end
		--
		local function clean_up()
			local now = date_engine.time()
			local earliest = BIG_NUMBER;
			for GUID, VAR in next, AVAR do
				for _, inst in next, SET.raid_list do
					local var = VAR[inst];
					if var[2] then
						if var[2] <= now then
							wipe(var);
						else
							earliest = min(earliest, var[2]);
						end
					end
				end
			end
			return earliest;
		end
		local instance_name_hash = __raidlib.__raid_meta.hash;
		function NS.proc_locked_down_instance()
			for _, inst in next, SET.raid_list do
				wipe(VAR[inst]);
			end
			local earliest = BIG_NUMBER;
			local now = date_engine.time()
			for instanceIndex = 1, GetNumSavedInstances() do
				local name, id, reset, difficulty, locked, extended, instanceIDMostSig, isRaid, maxPlayers, difficultyName, numEncounters, encounterProgress = GetSavedInstanceInfo(instanceIndex);
				if locked and isRaid then
					local inst = instance_name_hash[name];
					if inst then
						local t = now + reset;
						local var = VAR[inst];
						var[1] = id;
						var[2] = t;
						var[3] = numEncounters;
						var[4] = encounterProgress;
						earliest = min(earliest, t);
						for encounterIndex = 1, numEncounters do
							local bossName, fileDataID, isKilled, unknown4 = GetSavedInstanceEncounterInfo(instanceIndex, encounterIndex);
							var[4 + encounterIndex * 2 - 1] = bossName;
							var[4 + encounterIndex * 2] = isKilled;
						end
					else
					end
				end
			end
			C_Timer.After(min(earliest - now + 1, 3600, clean_up() - now), NS.proc_locked_down_instance);
			--
			NS.ui_update_board();
		end
		function NS.InitInstance()
			for _, inst in next, SET.raid_list do
				if VAR[inst] == nil then
					VAR[inst] = {  };
				end
			end
			C_Timer.After(0.1, NS.proc_locked_down_instance);
		end
		function NS.PLAYER_LOGOUT(...)
			VAR.PLAYER_LEVEL = UnitLevel('player');
			NS.proc_locked_down_instance();
		end
		function NS.ENCOUNTER_END()
			NS.F_ScheduleDelayCall(NS.proc_locked_down_instance);
		end
		function NS.BOSS_KILL()
			NS.F_ScheduleDelayCall(NS.proc_locked_down_instance);
		end
		function NS.UPDATE_INSTANCE_INFO()
			NS.F_ScheduleDelayCall(NS.proc_locked_down_instance);
		end
		function NS.PLAYER_LEVEL_UP(level)
			VAR.PLAYER_LEVEL = level;
		end
		function NS.init_var(VAR)
			for _, inst in next, SET.raid_list do
				if VAR[inst] == nil then
					VAR[inst] = {  };
				end
			end
			return VAR;
		end
		function NS.add_char(key, VAR, before_initialized)
			if key and VAR and AVAR[key] == nil then
				for index = #SET.char_list, 1, -1 do
					if SET.char_list[index] == key then
						tremove(SET.char_list, index);
					end
				end
				AVAR[key] = VAR;
				if VAR.manual then
					tinsert(SET.char_list, key);
				else
					tinsert(SET.char_list, 1, key);
				end
				if not before_initialized then
					NS.ui_update_board();
					NS.ui_update_config_char_list();
				end
			end
		end
		function NS.del_char(index)
			local list = SET.char_list;
			if index and index <= #list then
				local key = list[index];
				tremove(list, index);
				AVAR[key] = nil;
				NS.ui_update_board();
				NS.ui_update_config_char_list();
			end
		end
		function NS.del_char_by_key(key)
			if key then
				local list = SET.char_list;
				for index, k in next, list do
					if k == key then
						NS.del_char(index);
						break;
					end
				end
			end
		end
	end

	do	--	ui
		function NS.ui_save_frame_pos()
			local cal = gui["CALENDAR"];
			local w, h = UIParent:GetSize();
			SET.cal_pos[1] = (cal:GetLeft() + cal:GetRight() - w) / 2;
			SET.cal_pos[2] = (cal:GetTop() + cal:GetBottom() - h) / 2;
		end
		--
			local function region_select(_, val)
				SET.region = val;
				NS.apply_region[val]();
				NS.ui_update_calendar();
				NS.ui_refresh_config();
				NS.ON_SET_CHANGED("region", val);
			end
			local list_drop_meta = {
				handler = region_select,
				elements = {  },
			};
			for region = 1, 6 do
				local drop = {
					text = L.REGION[region],
					para = { region, },
				};
				tinsert(list_drop_meta.elements, drop);
			end
			local function cell_OnEnter(self)
				local now = self.now;
				if now then
					GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
					GameTooltip:AddLine(date_engine.built_in_date(L.FORMAT_DATE_TODAY, now), 1.0, 1.0, 1.0);
					local state = self.state;
					local dst_ofs = SET.dst and 3600 or 0;
					for _, inst in next, NS.milestone_list do
						local s = state[inst];
						if s then
							local val = NS.milestone[inst];
							local first_seen = val.dst and (val[1] - dst_ofs) or val[1];
							if val.instance then
								GameTooltip:AddDoubleLine(L.INSTANCE[inst] .. L.INSTANCE_RESET, date_engine.built_in_date(L.FORMAT_CLOCK, (first_seen % 86400)), 1.0, 1.0, 1.0);
							elseif val.festival then
								if s == 2 then
									GameTooltip:AddDoubleLine(L.INSTANCE[inst], date_engine.built_in_date(L.FORMAT_CLOCK, first_seen % 86400) .. " - " ..  date_engine.built_in_date(L.FORMAT_CLOCK, first_seen % 86400 + val[5]), 1.0, 1.0, 1.0);
								elseif s == 1 then
									GameTooltip:AddDoubleLine(L.INSTANCE[inst] .. L.FESTIVAL_START, date_engine.built_in_date(L.FORMAT_CLOCK, (first_seen % 86400)), 1.0, 1.0, 1.0);
								elseif s == -1 then
									GameTooltip:AddDoubleLine(L.INSTANCE[inst] .. L.FESTIVAL_END, date_engine.built_in_date(L.FORMAT_CLOCK, ((first_seen + val[5]) % 86400)), 1.0, 1.0, 1.0);
								else
									GameTooltip:AddLine(L.INSTANCE[inst], 1.0, 1.0, 1.0);
								end
							end
						end
					end
					GameTooltip:Show();
				else
					info_OnLeave(self);
				end
			end
			local function cal_OnMouseWheel(self, delta)
				local frame = self:GetParent();
				frame.var.line_ofs = frame.var.line_ofs - delta;
				NS.proc_update_calendar(frame);
			end
			local function cell_OnMouseWheel(self, delta)
				cal_OnMouseWheel(self:GetParent(), delta)
			end
			local function createCell(parent)
				local cell = CreateFrame("BUTTON", nil, parent);
				cell:SetSize(ui_style.cell_XSize, ui_style.cell_YSize);
				cell:SetHighlightTexture(ui_style.cell_Highlight);
				cell:GetHighlightTexture():SetTexCoord(unpack(ui_style.cell_HighlightCoord));
				cell:GetHighlightTexture():SetAlpha(0.5);
				cell:EnableMouse(true);
				cell:RegisterForDrag("LeftButton");
				cell:SetScript("OnDragStart", function(self)
					self.frame:StartMoving();
				end);
				cell:SetScript("OnDragStop", function(self)
					self.frame:StopMovingOrSizing();
					NS.ui_save_frame_pos()
				end);
				cell:SetScript("OnEnter", cell_OnEnter);
				cell:SetScript("OnLeave", info_OnLeave);
				-- cell:SetScript("OnMouseWheel", cell_OnMouseWheel);
				cell:Show();
				cell.frame = parent:GetParent();
				cell.state = {  };

				local bg = cell:CreateTexture(nil, "BACKGROUND");
				bg:SetDrawLayer("BACKGROUND", 0);
				bg:SetPoint("CENTER");
				bg:SetAllPoints();
				bg:SetTexture(ui_style.cell_BG);
				bg:SetTexCoord(unpack(ui_style.cell_BG_Coord));

				do	--	festival
					local festival = cell:CreateTexture(nil, "BORDER");
					festival:SetDrawLayer("BORDER", 1);
					festival:SetPoint("TOPLEFT");
					-- festival:SetSize(ui_style.festival_Size, ui_style.festival_Size);
					festival:SetAllPoints();
					festival:Hide();
					function cell:SetFestival1Tex(...)
						festival:SetTexture(...);
						festival:Show();
					end
					function cell:SetFestival1TexCoord(...)
						festival:SetTexCoord(...);
					end
					function cell:HideFestival1Tex()
						festival:Hide();
					end

					local curtain = cell:CreateTexture(nil, "ARTWORK");
					curtain:SetDrawLayer("ARTWORK", 1);
					curtain:SetPoint("CENTER");
					curtain:SetAllPoints();
					-- curtain:SetBlendMode("ADD");
					curtain:Hide();
					function cell:SetCurtain1Tex(...)
						curtain:SetTexture(...);
						curtain:Show();
					end
					function cell:SetCurtain1TexCoord(...)
						curtain:SetTexCoord(...);
					end
					function cell:HideCurtain1Tex()
						curtain:Hide();
					end
				end

				do	--	festival2
					local festival2 = cell:CreateTexture(nil, "BORDER");
					festival2:SetDrawLayer("BORDER", 2);
					festival2:SetPoint("BOTTOMLEFT");
					-- festival2:SetSize(ui_style.festival_Size, ui_style.festival_Size);
					festival2:SetAllPoints();
					festival2:Hide();
					function cell:SetFestival2Tex(...)
						festival2:SetTexture(...);
						festival2:Show();
					end
					function cell:SetFestival2TexCoord(...)
						festival2:SetTexCoord(...);
					end
					function cell:HideFestival2Tex()
						festival2:Hide();
					end

					local curtain2 = cell:CreateTexture(nil, "ARTWORK");
					curtain2:SetDrawLayer("ARTWORK", 2);
					curtain2:SetPoint("CENTER");
					curtain2:SetAllPoints();
					-- curtain2:SetBlendMode("ADD");
					curtain2:Hide();
					function cell:SetCurtain2Tex(...)
						curtain2:SetTexture(...);
						curtain2:Show();
					end
					function cell:SetCurtain2TexCoord(x1, x2, y1, y2)
						curtain2:SetTexCoord(x1, x2, y1, y2);
					end
					function cell:HideCurtain2Tex()
						curtain2:Hide();
					end
				end

				local title = cell:CreateFontString(nil, "ARTWORK");
				title:SetDrawLayer("ARTWORK", 7);
				title:SetFont(ui_style.frameFont, ui_style.cellTitleFontSize, "OUTLINE");
				title:SetPoint("TOPLEFT", 4, -2);
				function cell:SetTitle(...)
					title:SetText(...);
				end

				local info = cell:CreateFontString(nil, "ARTWORK");
				info:SetDrawLayer("ARTWORK", 7);
				info:SetJustifyH("LEFT");
				info:SetFont(ui_style.frameFont, ui_style.smallFontSize, "OUTLINE");
				info:SetPoint("BOTTOMLEFT", 4, 4);
				function cell:SetInfo(...)
					info:SetText(...);
				end

				local this_month_mask = cell:CreateTexture(nil, "OVERLAY");
				this_month_mask:SetDrawLayer("OVERLAY", 7);
				this_month_mask:SetPoint("CENTER");
				this_month_mask:SetAllPoints();
				this_month_mask:SetColorTexture(unpack(ui_style.cell_this_month_maskColor));
				this_month_mask:Hide();
				function cell:Bright()
					this_month_mask:Hide();
				end
				function cell:Dark()
					this_month_mask:Show();
				end

				local today_mask = cell:CreateTexture(nil, "OVERLAY");
				today_mask:SetDrawLayer("OVERLAY", 7);
				today_mask:SetPoint("CENTER");
				today_mask:SetAllPoints();
				today_mask:SetTexture(ui_style.cell_Highlight);
				today_mask:SetTexCoord(unpack(ui_style.cell_HighlightCoord));
				today_mask:SetBlendMode("ADD");
				today_mask:SetVertexColor(unpack(ui_style.cell_today_mask_color));
				today_mask:Hide();
				function cell:Today()
					today_mask:Show();
				end
				function cell:NotToday()
					today_mask:Hide();
				end

				local instances = {  };
				local instances_mask = {  };
				local last_instance = 0;
				function cell:ResetInstance()
					last_instance = 0;
				end
				function cell:AddInstance(tex, coord)
					last_instance = last_instance + 1;
					local inst = instances[last_instance];
					if inst == nil then
						-- inst = CreateFrame("BUTTON", nil, cell);
						inst = cell:CreateTexture(nil, "ARTWORK");
						inst:SetDrawLayer("ARTWORK", 0);
						inst:SetSize(ui_style.cell_inst_Size, ui_style.cell_inst_Size);
						inst:SetAlpha(0.75);
						inst:SetVertexColor(1.0, 1.0, 1.0, 0.75);
						inst:Show();
						instances[last_instance] = inst;
						local inst_mask = cell:CreateTexture(nil, "ARTWORK");
						inst_mask:SetDrawLayer("ARTWORK", 1);
						inst_mask:SetSize(ui_style.cell_inst_Size, ui_style.cell_inst_Size);
						inst_mask:SetTexture("interface\\buttons\\ui-quickslot-depress");
						inst_mask:SetTexCoord(4 / 64, 60 / 64, 4 / 64, 60 / 64);
						inst_mask:SetBlendMode("MOD");
						inst_mask:Show();
						inst_mask:SetPoint("CENTER", inst);
						instances_mask[last_instance] = inst_mask;
						-- inst:SetNormalTexture(135913);
						-- -- inst:GetNormalTexture():SetVertexColor(1.0, 1.0, 1.0, 0.75);
						-- inst:SetHighlightTexture("interface\\buttons\\ui-quickslot-depress");
						-- inst:GetHighlightTexture():SetTexCoord(2 / 64, 62 / 64, 2 / 64, 62 / 64);
						-- inst:GetHighlightTexture():SetBlendMode("MOD");
						-- inst:LockHighlight();
						if last_instance == 1 then
							inst:SetPoint("BOTTOMLEFT", 6, 6);
						elseif last_instance % 3 == 1 then
							inst:SetPoint("BOTTOM", instances[last_instance - 3], "TOP", 0, 0);
						else
							inst:SetPoint("LEFT", instances[last_instance - 1], "RIGHT", 0, 0);
						end
					else
						inst:Show();
						instances_mask[last_instance]:Show();
					end
					-- inst:SetNormalTexture(tex);
					inst:SetTexture(tex);
					if coord then
						-- inst:GetNormalTexture():SetTexCoord(unpack(coord));
						inst:SetTexCoord(unpack(coord));
					end
				end
				function cell:RefreshInstance()
					for index = last_instance + 1, #instances do
						instances[index]:Hide();
						instances_mask[index]:Hide();
					end
				end

				return cell;
			end
			local function createWeekTitle(parent)
				local bg = parent:CreateTexture(nil, "ARTWORK");
				bg:SetSize(ui_style.cell_XSize, ui_style.weekTitle_YSize);
				bg:SetTexture(ui_style.weekTitle_BG);
				bg:SetTexCoord(unpack(ui_style.weekTitle_BG_Coord));
				bg:Show();
				local str = parent:CreateFontString(nil, "OVERLAY");
				str:SetFont(ui_style.frameFont, ui_style.weekTitleFontSize);
				str:SetPoint("CENTER", bg);
				str:Show();
				local wt = { bg, str, };
				function wt:SetText(...)
					self[2]:SetText(...);
				end
				function wt:SetTexture(...)
					self[1]:SetTexture(...);
				end
				function wt:Show()
					self[1]:Show();
					self[2]:Show();
				end
				function wt:Hide()
					self[1]:Hide();
					self[2]:Hide();
				end
				function wt:SetVertexColor(...)
					self[1]:SetVertexColor(...);
					self[2]:SetVertexColor(...);
				end
				function wt:SetTextColor(...)
					self[2]:SetVertexColor(...);
				end
				function wt:ClearAllPoints()
					self[1]:ClearAllPoints();
				end
				function wt:SetPoint(...)
					self[1]:SetPoint(...);
				end
				return wt;
			end
		--
		function NS.ui_refreshWeekTitle(frame)
			local weekTitles = frame.weekTitles;
			for col = 1, NUM_COL do
				local wt = weekTitles[col];
				local day = (col + SET.first_col_day - 1) % NUM_COL;
				wt:SetText(L.WEEKTITLE[day]);
			end
		end
		function NS.ui_CreateCalendar()
			--	frame
				local frame = CreateFrame("FRAME", "ALA_CALENDAR", UIParent);
				if SET.hide_calendar_on_esc then
					tinsert(UISpecialFrames, "ALA_CALENDAR");
				end
				uireimp._SetSimpleBackdrop(frame, 0, 1, 0.15, 0.15, 0.15, 0.9, 0.0, 0.0, 0.0, 1.0);
				frame:SetSize(ui_style.frame_XSize, ui_style.frame_YSize);
				frame:SetFrameStrata("HIGH");
				frame:SetPoint("CENTER", UIParent, "CENTER", SET.cal_pos[1], SET.cal_pos[2]);
				frame:SetScale(SET.scale);
				frame:SetAlpha(SET.alpha);
				frame:EnableMouse(true);
				frame:SetMovable(true);
				frame:RegisterForDrag("LeftButton");
				frame:SetScript("OnDragStart", function(self)
					self:StartMoving();
				end);
				frame:SetScript("OnDragStop", function(self)
					self:StopMovingOrSizing();
					NS.ui_save_frame_pos();
				end);
				frame:Hide();
				frame.var = {
					month_ofs = 0,
					line_ofs = 0,
				};
				local StartMoving = frame.StartMoving;
				function frame.StartMoving(self)
					self:ClearAllPoints();
					local board = gui["BOARD"];
					board:ClearAllPoints();
					board:SetPoint("TOPLEFT", self, "TOPRIGHT", 1, 0);
					StartMoving(self);
				end
			--

			do	--	title
				local title = frame:CreateFontString(nil, "ARTWORK");
				title:SetFont(ui_style.frameFont, ui_style.frameFontSize, ui_style.frameFontOutline);
				title:SetPoint("TOP", 0, -1);
				title:SetText(L["CALENDAR_TITLE"]);
				frame.title = title;

				function frame:SetTitleText(...)
					title:SetText(...);
				end
			end

			do	--	date & clock
				local clock = frame:CreateFontString(nil, "OVERLAY");
				clock:SetFont(ui_style.frameFont, ui_style.bigFontSize);
				clock:SetPoint("TOP", frame, "TOPLEFT", (ui_style.frame_XSize / 2 - 4 - 48 - 12 - 24) / 2, -2);
				clock:Show();
				frame.clock = clock;

				local today = frame:CreateFontString(nil, "OVERLAY");
				today:SetFont(ui_style.frameFont, ui_style.smallFontSize);
				today:SetPoint("BOTTOM", frame, "TOPLEFT", (ui_style.frame_XSize / 2 - 4 - 48 - 12 - 24) / 2, - (ui_style.frameTitle_YSize + ui_style.cal_YToBorder));
				today:SetVertexColor(unpack(ui_style.today_color));
				today:Show();
				frame.today = today;

				function frame:SetClockText(...)
					clock:SetText(...);
				end
				function frame:SetWhatDayText(...)
					today:SetText(...);
				end
				C_Timer.NewTicker(0.1, function()
					if frame:IsShown() then
						today:SetText(date_engine.built_in_date(L.FORMAT_DATE_TODAY));
						clock:SetText(date_engine.built_in_date(L.FORMAT_CLOCK));
					end
				end);

				local reset =  CreateFrame("BUTTON", nil, frame);
				-- reset:SetSize(20, 20);
				reset:SetPoint("TOPLEFT", today, "TOPLEFT", 0, 0);
				reset:SetPoint("BOTTOMRIGHT", today, "BOTTOMRIGHT", 0, 0);
				reset:SetScript("OnClick", function()
					frame.var.line_ofs = 0;
					frame.var.month_ofs = 0;
					frame.update_func();
				end);
				reset:SetScript("OnEnter", function()
					today:SetVertexColor(1.0, 1.0, 1.0, 1.0);
				end);
				reset:SetScript("OnLeave", function()
					today:SetVertexColor(unpack(ui_style.today_color));
				end);
				reset:SetFontString(today);
				reset:SetPushedTextOffset(0, -1);
				frame.reset = reset;
			end

			do	--	year & month explorer
				local drop_table_year = {
					handler = function(_, frame, val)
						local var = frame.var;
						var.month_ofs = var.month_ofs + val * 12;
						frame.update_func();
					end,
					elements = {  },
				};
				for index = 1, 10 do
					drop_table_year.elements[index] = { para = { frame, index - 5, }, };
				end
				local drop_table_month = {
					handler = function(_, frame, val)
						local var = frame.var;
						var.month_ofs = var.month_ofs - var.center_cell_time[2] + val;
						var.line_ofs = 0;
						frame.update_func();
					end,
					elements = {  },
				};
				for index = 1, 12 do
					drop_table_month.elements[index] = { para = { frame, index, }, text = L.MONTH[index], };
				end

				local date_title_L = CreateFrame("BUTTON", nil, frame);
				date_title_L:SetSize(48, 24);
				date_title_L:SetPoint("TOPRIGHT", frame, "TOP", 0, -16);
				date_title_L:SetScript("OnClick", function(self)
					if IsEastAsiaFormat() then
						local Y1 = frame.var.center_cell_time[1];
						local elements = drop_table_year.elements;
						for index = 1, 10 do
							local Y = Y1 + index - 5;
							elements[index].text = tostring(Y);
						end
						ALADROP(self, "BOTTOM", drop_table_year);
					else
						ALADROP(self, "BOTTOM", drop_table_month);
					end
				end);
				date_title_L:SetScript("OnMouseWheel", function(self, delta)
					if IsEastAsiaFormat() then
						local var = frame.var;
						var.month_ofs = var.month_ofs + delta * 12;
						var.line_ofs = 0;
						frame.update_func();
					else
						local var = frame.var;
						var.month_ofs = var.month_ofs + delta;
						var.line_ofs = 0;
						frame.update_func();
					end
				end);
				local date_title_L_str = date_title_L:CreateFontString(nil, "ARTWORK");
				date_title_L_str:SetFont(ui_style.frameFont, ui_style.frameFontSize, ui_style.frameFontOutline);
				date_title_L_str:SetPoint("RIGHT");
				frame.date_title_L = date_title_L;

				local date_title_R = CreateFrame("BUTTON", nil, frame);
				date_title_R:SetSize(48, 24);
				date_title_R:SetPoint("TOPLEFT", frame, "TOP", 0, -16);
				date_title_R:SetScript("OnClick", function(self)
					if IsEastAsiaFormat() then
						ALADROP(self, "BOTTOM", drop_table_month);
					else
						local Y1 = frame.var.center_cell_time[1];
						local elements = drop_table_year.elements;
						for index = 1, 10 do
							local Y = Y1 + index - 5;
							elements[index].text = tostring(Y);
						end
						ALADROP(self, "BOTTOM", drop_table_year);
					end
				end);
				date_title_R:SetScript("OnMouseWheel", function(self, delta)
					if IsEastAsiaFormat() then
						local var = frame.var;
						var.month_ofs = var.month_ofs + delta;
						var.line_ofs = 0;
						frame.update_func();
					else
						local var = frame.var;
						var.month_ofs = var.month_ofs + delta * 12;
						var.line_ofs = 0;
						frame.update_func();
					end
				end);
				local date_title_R_str = date_title_R:CreateFontString(nil, "ARTWORK");
				date_title_R_str:SetFont(ui_style.frameFont, ui_style.frameFontSize, ui_style.frameFontOutline);
				date_title_R_str:SetPoint("LEFT");
				frame.date_title_R = date_title_R;

				local prev = CreateFrame("BUTTON", nil, frame);
				prev:SetSize(16, 16);
				prev:SetNormalTexture(ui_style.texture_arrowleft);
				prev:GetNormalTexture():SetVertexColor(unpack(ui_style.texture_triangle_normal_color));
				prev:GetNormalTexture():SetBlendMode("ADD");
				prev:SetPushedTexture(ui_style.texture_arrowleft);
				prev:GetPushedTexture():SetVertexColor(unpack(ui_style.texture_triangle_pushed_color));
				prev:GetPushedTexture():SetBlendMode("ADD");
				prev:SetHighlightTexture(ui_style.texture_arrowleft);
				prev:GetHighlightTexture():SetAlpha(0.25);
				prev:SetPoint("RIGHT", date_title_L, "LEFT", -6, 0);
				prev:SetScript("OnClick", function()
					local var = frame.var;
					if var.line_ofs <= 0 then
						var.month_ofs = var.month_ofs - 1;
					end
					var.line_ofs = 0;
					frame.update_func();
				end);
				frame.prev = prev;

				local next = CreateFrame("BUTTON", nil, frame);
				next:SetSize(16, 16);
				next:SetNormalTexture(ui_style.texture_arrowright);
				next:GetNormalTexture():SetVertexColor(unpack(ui_style.texture_triangle_normal_color));
				next:GetNormalTexture():SetBlendMode("ADD");
				next:SetPushedTexture(ui_style.texture_arrowright);
				next:GetPushedTexture():SetVertexColor(unpack(ui_style.texture_triangle_pushed_color));
				next:GetPushedTexture():SetBlendMode("ADD");
				next:SetHighlightTexture(ui_style.texture_arrowright);
				next:GetHighlightTexture():SetAlpha(0.25);
				next:SetPoint("LEFT", date_title_R, "RIGHT", 6, 0);
				next:SetScript("OnClick", function()
					local var = frame.var;
					if var.line_ofs >= 0 then
						var.month_ofs = var.month_ofs + 1;
					end
					var.line_ofs = 0;
					frame.update_func();
				end);
				frame.next = next;

				function frame:SetDateLeftText(...)
					date_title_L_str:SetText(...);
				end
				function frame:SetDateLeftColor(...)
					date_title_L_str:SetVertexColor(...);
				end
				function frame:SetDateRightText(...)
					date_title_R_str:SetText(...);
				end
				function frame:SetDateRightColor(...)
					date_title_R_str:SetVertexColor(...);
				end
			end

			do	--	calendar
				local cal = CreateFrame("FRAME", nil, frame);
				cal:SetSize(ui_style.cal_XSize, ui_style.cal_YSize);
				cal:SetPoint("TOPLEFT", frame, "TOPLEFT", ui_style.cal_XToBorder, - (ui_style.frameTitle_YSize + ui_style.cal_YToBorder));
				cal:EnableMouse(true);
				cal:RegisterForDrag("LeftButton");
				cal:SetScript("OnShow", frame.update_func);
				cal:SetScript("OnMouseWheel", cal_OnMouseWheel);
				cal:Show();
				cal:SetScript("OnDragStart", function(self)
					self:GetParent():StartMoving();
				end);
				cal:SetScript("OnDragStop", function(self)
					self:GetParent():StopMovingOrSizing();
					NS.ui_save_frame_pos()
				end);
				frame.cal = cal;

				local weekTitles = {  };
				frame.weekTitles = weekTitles;
				for col = 1, NUM_COL do
					local wt = createWeekTitle(cal);
					wt:SetPoint("TOPLEFT", cal, "TOPLEFT", (ui_style.cell_XSize + ui_style.cell_XInt) * (col - 1), 0);
					weekTitles[col] = wt;
				end
				NS.ui_refreshWeekTitle(frame);

				local cells = {  };
				frame.cells = cells;
				for row = 1, NUM_ROW do
					local rc = {  };
					cells[row] = rc;
					for col = 1, NUM_COL do
						local cell = createCell(cal);
						cell:SetPoint("TOPLEFT", cal, "TOPLEFT",
										(ui_style.cell_XSize + ui_style.cell_XInt) * (col - 1),
										- (ui_style.weekTitle_YSize + ui_style.cell_YToWeekTitle + (ui_style.cell_YSize + ui_style.cell_YInt) * (row - 1))
						);
						cell.row = row;
						cell.col = col;
						cell.index = (row - 1) * NUM_COL + col;
						rc[col] = cell;
					end
				end
			end

			do	--	ele
				local close = CreateFrame("BUTTON", nil, frame);
				close:SetSize(20, 20);
				close:SetNormalTexture(ui_style.texture_close);
				close:SetPushedTexture(ui_style.texture_close);
				close:GetPushedTexture():SetVertexColor(0.5, 0.5, 0.5, 0.5);
				close:SetHighlightTexture(ui_style.texture_close);
				close:GetHighlightTexture():SetVertexColor(0.5, 0.5, 0.5, 0.5);
				close:SetPoint("CENTER", frame, "TOPRIGHT", -11, -11);
				close:SetScript("OnClick", function()
					frame:Hide();
				end);
				close:SetScript("OnEnter", info_OnEnter);
				close:SetScript("OnLeave", info_OnLeave);
				close.info_lines = { L.CLOSE, };
				frame.close = close;

				local region = CreateFrame("BUTTON", nil, frame);
				region:SetHeight(20);
				region:SetPoint("TOP", frame, "TOPRIGHT", -135, -6);
				local region_str = region:CreateFontString(nil, "OVERLAY");
				region_str:SetFont(ui_style.frameFont, ui_style.smallFontSize, ui_style.frameFontOutline);
				region_str:SetPoint("CENTER");
				region_str:SetText(L.REGION[SET.region]);
				region.str = region_str;
				region:SetWidth(region_str:GetWidth() + 8);
				region:SetScript("OnClick", function(self)
					ALADROP(self, "BOTTOMLEFT", NS.set_cmd_list[1][8]);
				end);
				frame.region = region;

				local dst = CreateFrame("CHECKBUTTON", nil, frame, "OptionsBaseCheckButtonTemplate");	--	oppositive value
				dst:SetHeight(2);
				dst:SetHitRectInsets(0, 0, 0, 0);
				-- dst:GetNormalTexture():SetColorTexture(0.5, 0.5, 0.5, 0.75);
				-- dst:GetHighlightTexture():SetColorTexture(0.25, 0.25, 0.25, 0.75);
				-- dst:GetPushedTexture():SetColorTexture(0.25, 0.25, 0.25, 0.75);
				-- -- dst:GetCheckedTexture():SetTexture(ui_style.texture_claw);
				-- dst:GetCheckedTexture():SetColorTexture(0.75, 0.75, 0.75, 1.0);
				dst:GetNormalTexture():SetColorTexture(0.5, 0.5, 0.5, 0.0);
				dst:GetHighlightTexture():SetColorTexture(0.25, 0.25, 0.25, 0.0);
				dst:GetPushedTexture():SetColorTexture(0.25, 0.25, 0.25, 0.5);
				-- dst:GetCheckedTexture():SetTexture(ui_style.texture_claw);
				dst:GetCheckedTexture():SetColorTexture(0.5, 0.75, 0.75, 1.0);
				dst:GetCheckedTexture():SetDrawLayer("OVERLAY", 7);
				dst:SetHitRectInsets(0, 0, -ui_style.smallFontSize / 2 + 2, -ui_style.smallFontSize / 2);
				dst:SetPoint("BOTTOMLEFT", frame, "TOPLEFT", (ui_style.frame_XSize / 2 - 4 - 48 - 6 - 16 - 66), -2 - ui_style.bigFontSize + 8);
				dst:SetChecked(not SET.dst);
				local dst_str = dst:CreateFontString(nil, "ARTWORK");
				dst_str:SetFont(ui_style.frameFont, ui_style.smallFontSize, ui_style.frameFontOutline);
				dst_str:SetPoint("CENTER", 0, 1);
				dst_str:SetVertexColor(0.5, 0.75, 0.75, 1.0);
				dst_str:SetText("DST");
				dst.str = dst_str;
				dst:SetWidth(dst_str:GetWidth());
				dst:SetScript("OnClick", function(self)
					SET.dst = not self:GetChecked();
					NS.set_time_zone();
					NS.ui_update_calendar();
					NS.ui_refresh_config();
				end);
				frame.dst = dst;

				local ad = frame:CreateFontString(nil, "OVERLAY");
				ad:SetFont(ui_style.frameFont, ui_style.smallFontSize, ui_style.frameFontOutline);
				ad:SetVertexColor(unpack(ui_style.ad_color));
				ad:SetPoint("BOTTOM", frame, "TOPRIGHT", -135, - (ui_style.frameTitle_YSize + ui_style.cal_YToBorder) + 6);
				ad:SetText(L.AD_TEXT);
				frame.ad = ad;

				local call_board = CreateFrame("BUTTON", nil, frame);
				call_board:SetSize(20, 20);
				call_board:SetNormalTexture(ui_style.texture_arrowright);
				call_board:GetNormalTexture():SetVertexColor(unpack(ui_style.texture_triangle_normal_color));
				call_board:GetNormalTexture():SetBlendMode("ADD");
				call_board:SetPushedTexture(ui_style.texture_arrowright);
				call_board:GetPushedTexture():SetVertexColor(unpack(ui_style.texture_triangle_pushed_color));
				call_board:GetPushedTexture():SetBlendMode("ADD");
				call_board:SetHighlightTexture(ui_style.texture_arrowright);
				call_board:GetHighlightTexture():SetAlpha(0.25);
				call_board:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -2, -28);
				function call_board:Texture(bool)
					if bool then
						self:SetNormalTexture(ui_style.texture_arrowleft);
						self:SetPushedTexture(ui_style.texture_arrowleft);
						self:SetHighlightTexture(ui_style.texture_arrowleft);
					else
						self:SetNormalTexture(ui_style.texture_arrowright);
						self:SetPushedTexture(ui_style.texture_arrowright);
						self:SetHighlightTexture(ui_style.texture_arrowright);
					end
				end
				call_board:Texture(false);
				call_board:SetScript("OnClick", function(self)
					NS.ui_toggleGUI("BOARD");
				end);
				call_board:SetScript("OnEnter", info_OnEnter);
				call_board:SetScript("OnLeave", info_OnLeave);
				call_board.info_lines = { L.CALL_BOARD, };
				-- local call_board_str = call_board:CreateFontString(nil, "ARTWORK");
				-- call_board_str:SetFont(ui_style.frameFont, ui_style.smallFontSize, "OUTLINE");
				-- call_board_str:SetText(L["BOARD"]);
				-- call_board_str:SetPoint("RIGHT", call_board, "LEFT", -2, 0);
				-- call_board.str = call_board_str;
				-- call_board:SetHitRectInsets(-call_board_str:GetWidth(), 0, 0, 0);
				frame.call_board = call_board;
			end

			function frame.update_func()
				NS.proc_update_calendar(frame);
			end
			frame:SetScript("OnShow", function()
				frame.update_func();
				gui["BOARD"].call_calendar:Texture(true);
			end);
			frame:SetScript("OnHide", function(self)
				self.var.month_ofs = 0;
				self.var.line_ofs = 0;
				gui["BOARD"].call_calendar:Texture(false);
			end);

			return frame;
		end
		--
			local board_drop_meta_add ={
				text = L.LOCKDOWN_ADD,
				para = { 1, },
			};
			local board_drop_meta_del ={
				text = L.LOCKDOWN_DEL,
				para = { 2, },
			};
			local board_drop_meta = {
				handler = function(_, action, key, inst)
					if action == 1 then
						local VAR = AVAR[key];
						local var = VAR[inst];
						var[1] = true;
						var[2] = date_engine.inst_next_reset(inst);
						gui["BOARD"].scroll:Update();
					elseif action == 2 then
						local VAR = AVAR[key];
						local var = VAR[inst];
						var[1] = false;
						var[2] = nil;
						gui["BOARD"].scroll:Update();
					end
				end,
				elements = {  },
			};
			local function board_button_OnClick(self, button)
				local frame = self.frame;
				local display_list = frame.display_list;
				local data_index = self:GetDataIndex();
				local head, key, inst = display_list[data_index * 3 - 2], display_list[data_index * 3 - 1], display_list[data_index * 3];
				if head == 'header' or head == 'extern_head' then
					if button == "LeftButton" then
						local collapsed = SET.collapsed;
						collapsed[inst] = not collapsed[inst];
						frame:update_func();
					end
				elseif head == 'GUID' then
					local VAR = AVAR[key];
					if VAR.manual then
						local var = VAR[inst];
						if var[1] then
							board_drop_meta_del.para[2] = key;
							board_drop_meta_del.para[3] = inst;
							board_drop_meta.elements[1] = board_drop_meta_del;
						else
							board_drop_meta_add.para[2] = key;
							board_drop_meta_add.para[3] = inst;
							board_drop_meta.elements[1] = board_drop_meta_add;
						end
						ALADROP(self, "BOTTOM", board_drop_meta);
					end
				end
			end
			local function board_button_OnEnter(self)
				local frame = self.frame;
				local display_list = frame.display_list;
				local data_index = self:GetDataIndex();
				local head, val, inst = display_list[data_index * 3 - 2], display_list[data_index * 3 - 1], display_list[data_index * 3];
				if head == 'GUID' then
					local VAR = AVAR[val];
					if VAR then
						GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
						GameTooltip:AddLine(L.INSTANCE[inst], 1.0, 1.0, 1.0);
						local var = VAR[inst];
						if VAR.manual then
							if var[1] then
								GameTooltip:AddLine(L.INSTANCE_LOCKED_DOWN, 1.0, 0.0, 0.0);
							end
						else
							for index = 1, (#var - 4) / 2 do
								local bossName, isKilled = var[3 + index * 2], var[4 + index * 2];
								if isKilled then
									GameTooltip:AddLine(bossName, 1.0, 0.0, 0.0);
								else
									GameTooltip:AddLine(bossName, 0.0, 1.0, 0.0);
								end
							end
						end
						GameTooltip:Show();
					else
						GameTooltip:Hide();
					end
				else
					GameTooltip:Hide();
				end
			end
			local function funcToCreateBoardButton(parent, index, buttonHeight)
				local button = CreateFrame("BUTTON", nil, parent);
				button:SetHeight(buttonHeight);
				button:SetHighlightTexture(ui_style.texture_white);
				button:GetHighlightTexture():SetVertexColor(unpack(ui_style.buttonHighlightColor));
				button:EnableMouse(true);
				button:RegisterForClicks("AnyUp");

				local sep = button:CreateTexture(nil, "OVERLAY");
				sep:SetHeight(1);
				sep:SetPoint("TOPLEFT", 0, -2);
				sep:SetPoint("TOPRIGHT", 0, -2);
				sep:SetColorTexture(1.0, 1.0, 1.0, 0.5);
				button.sep = sep;

				local glow = button:CreateTexture(nil, "ARTWORK");
				glow:SetTexture(ui_style.texture_white);
				glow:SetVertexColor(unpack(ui_style.buttonGlowColor));
				glow:SetBlendMode("ADD");
				glow:SetAllPoints();
				button.glow = glow;

				local collapse = button:CreateTexture(nil, "BORDER");
				collapse:SetTexture(ui_style.texture_collapsed);
				collapse:SetSize(buttonHeight - 4, buttonHeight - 4);
				collapse:SetPoint("LEFT", 8, 0);
				button.collapse = collapse;

				local icon = button:CreateTexture(nil, "BORDER");
				icon:SetTexture(ui_style.texture_unk);
				icon:SetSize(buttonHeight - 4, buttonHeight - 4);
				icon:SetPoint("LEFT", collapse, "RIGHT", 4, 0);
				button.icon = icon;

				local title = button:CreateFontString(nil, "OVERLAY");
				title:SetFont(ui_style.frameFont, ui_style.frameFontSize, ui_style.frameFontOutline);
				title:SetPoint("LEFT", icon, "RIGHT", 4, 0);
				-- title:SetWidth(160);
				title:SetMaxLines(1);
				title:SetJustifyH("LEFT");
				button.title = title;

				local cool = button:CreateFontString(nil, "OVERLAY");
				cool:SetFont(ui_style.frameFont, ui_style.frameFontSize, ui_style.frameFontOutline);
				cool:SetPoint("RIGHT", button, "RIGHT", -4, 0);
				-- cool:SetWidth(160);
				cool:SetMaxLines(1);
				cool:SetJustifyH("LEFT");
				cool:SetVertexColor(1.0, 0.25, 0.25, 1.0);
				button.cool = cool;

				button:SetScript("OnClick", board_button_OnClick);
				button:SetScript("OnEnter", board_button_OnEnter);
				button:SetScript("OnLeave", info_OnLeave);

				local frame = parent:GetParent():GetParent();
				button.frame = frame;
				button.list = frame.list;

				return button;
			end
			local function funcToSetBoardButton(button, data_index)
				local frame = button.frame;
				local display_list = frame.display_list;
				local head, key, inst = display_list[data_index * 3 - 2], display_list[data_index * 3 - 1], display_list[data_index * 3];
				if head and key and inst then
					local collapsed = SET.collapsed;
					if head == 'header' then
						button.sep:Show();
						button.glow:Show();
						if collapsed[inst] then
							button.collapse:SetTexture(ui_style.texture_collapsed);
						else
							button.collapse:SetTexture(ui_style.texture_expanded);
						end
						button.collapse:Show();
						local val = NS.milestone[inst];
						if val then
							button.icon:SetTexture(val[6]);
							if val[7] then
								button.icon:SetTexCoord(unpack(val[7]));
							else
								button.icon:SetTexCoord(0.0, 1.0, 0.0, 1.0);
							end
							button.icon:Show();
							button.cool:SetText(NS.seconds_to_formatted_time_len(val[2] - (date_engine.time() - val[1]) % val[2]));
							button.cool:SetVertexColor(1.0, 0.25, 0.25, 1.0);
						else
							button.icon:Hide();
							button.cool:SetText(nil);
						end
						button.title:SetText(L.INSTANCE[inst]);
						button.title:SetVertexColor(1.0, 1.0, 1.0, 1.0);
					elseif head == 'GUID' then
						button.sep:Hide();
						button.glow:Hide();
						button.collapse:Hide();
						local VAR = AVAR[key];
						local var = VAR[inst];
						if VAR.manual then
							button.icon:Show();
							button.icon:SetTexture(ui_style.texture_claw);
							button.title:SetText(key);
							if VAR.class then
								local classColorTable = RAID_CLASS_COLORS[strupper(VAR.class)];
								if classColorTable then
									button.title:SetVertexColor(classColorTable.r, classColorTable.g, classColorTable.b, 1.0);
								else
									button.title:SetVertexColor(0.75, 0.75, 0.75, 1.0);
								end
							else
								button.title:SetVertexColor(0.75, 0.75, 0.75, 1.0);
							end
							if var and var[1] then
								button.cool:SetText(L.INSTANCE_LOCKED_DOWN);
								button.cool:SetVertexColor(1.0, 0.25, 0.25, 1.0);
							else
								button.cool:SetText(L["COOLDOWN_EXPIRED"]);
								button.cool:SetVertexColor(0.0, 1.0, 0.0, 1.0);
							end
						else
							button.icon:Hide();
							local lClass, class, lRace, race, sex, name, realm = GetPlayerInfoByGUID(key);
							if name and class then
								local classColorTable = RAID_CLASS_COLORS[strupper(class)];
								if realm ~= nil and realm ~= "" then
									name = name .. "-" .. realm;
								end
								button.title:SetText(name);
								button.title:SetVertexColor(classColorTable.r, classColorTable.g, classColorTable.b, 1.0);
							else
								button.title:SetText(key);
								button.title:SetVertexColor(0.75, 0.75, 0.75, 1.0);
								C_Timer.After(0.5, function() funcToSetBoardButton(button, data_index); end);
							end
							if var and var[1] then
								button.cool:SetText(var[4] .. "/" .. var[3] .. '  \124cffffffffid: ' .. var[1]);
								button.cool:SetVertexColor(1.0, 0.25, 0.25, 1.0);
							else
								button.cool:SetText(L["COOLDOWN_EXPIRED"]);
								button.cool:SetVertexColor(0.0, 1.0, 0.0, 1.0);
							end
						end
					elseif head == 'extern_head' then
						button.sep:Show();
						button.glow:Show();
						if collapsed[inst] then
							button.collapse:SetTexture(ui_style.texture_collapsed);
						else
							button.collapse:SetTexture(ui_style.texture_expanded);
						end
						button.collapse:Show();
						local text = extern_list[inst].text;
						local tex, coord, title, color_title;
						if type(text) == 'function' then
							tex, coord, title, color_title = text(inst);
						elseif type(inst) == 'function' then
							tex, coord, title, color_title = inst(text);
						elseif type(text) == 'table' then
							tex, coord, title, color_title = unpack(text);
						elseif type(inst) == 'table' then
							tex, coord, title, color_title = unpack(inst);
						else
							title = text;
						end
						if tex then
							button.icon:SetTexture(tex);
							if coord then
								button.icon:SetTexCoord(coord[1] or coord.r, coord[2] or coord.g, coord[3] or coord.b, coord[4] or 1.0);
							else
								button.icon:SetTexCoord(0.0, 1.0, 0.0, 1.0);
							end
							button.icon:Show();
						else
							button.icon:Hide();
						end
						if title then
							button.title:SetText(title);
							if color_title then
								button.title:SetVertexColor(color_title[1] or color_title.r, color_title[2] or color_title.g, color_title[3] or color_title.b, color_title[4] or 1.0);
							else
								button.title:SetVertexColor(1.0, 1.0, 1.0, 1.0);
							end
						else
							button.title:SetText(nil);
						end
						button.cool:SetText(nil);
					elseif head == 'extern_key' then
						button.sep:Hide();
						button.glow:Hide();
						button.collapse:Hide();
						local val = extern_list[inst][key];
						local tex, coord, title, color_title, cool, color_cool;
						if type(val) == 'function' then
							tex, coord, title, color_title, cool, color_cool = val(inst, key);
						elseif type(key) == 'function' then
							tex, coord, title, color_title = key(inst, val);
						elseif type(val) == 'table' then
							tex, coord, title, color_title, cool, color_cool = unpack(val);
						elseif type(key) == 'table' then
							tex, coord, title, color_title, cool, color_cool = unpack(key);
						else
							title = key;
							cool = val;
						end
						if tex then
							button.icon:SetTexture(tex);
							if coord then
								button.icon:SetTexCoord(coord[1] or coord.r, coord[2] or coord.g, coord[3] or coord.b, coord[4] or 1.0);
							else
								button.icon:SetTexCoord(0.0, 1.0, 0.0, 1.0);
							end
							button.icon:Show();
						else
							button.icon:Hide();
						end
						if title then
							button.title:SetText(title);
							if color_title then
								button.title:SetVertexColor(color_title[1] or color_title.r, color_title[2] or color_title.g, color_title[3] or color_title.b, color_title[4] or 1.0);
							else
								button.title:SetVertexColor(0.75, 0.75, 0.75, 1.0);
							end
						else
							button.title:SetText(nil);
						end
						if cool then
							button.cool:SetText(cool);
							if color_cool then
								button.cool:SetVertexColor(color_cool[1] or color_cool.r, color_cool[2] or color_cool.g, color_cool[3] or color_cool.b, color_cool[4] or 1.0);
							else
								button.cool:SetVertexColor(0.75, 0.75, 0.75, 1.0);
							end
						else
							button.cool:SetText(nil);
						end
					end
					button:Show();
				else
					button:Hide();
				end
			end
		--
		function NS.ui_CreateBoard()
			--	frame
				local frame = CreateFrame("FRAME", "ALA_CALENDAR_BOARD", UIParent);
				if SET.hide_board_on_esc then
					tinsert(UISpecialFrames, "ALA_CALENDAR_BOARD");
				end
				uireimp._SetSimpleBackdrop(frame, 0, 1, 0.15, 0.15, 0.15, 0.9, 0.0, 0.0, 0.0, 1.0);
				frame:SetSize(ui_style.board_XSize, ui_style.board_YSize);
				frame:SetFrameStrata("HIGH");
				frame:SetPoint("TOPLEFT", gui["CALENDAR"], "TOPRIGHT", 1, 0);
				frame:SetScale(SET.scale);
				frame:SetAlpha(SET.alpha);
				frame:EnableMouse(true);
				frame:SetMovable(true);
				frame:RegisterForDrag("LeftButton");
				frame:SetScript("OnDragStart", function(self)
					self:StartMoving();
				end);
				frame:SetScript("OnDragStop", function(self)
					self:StopMovingOrSizing();
					NS.ui_save_frame_pos();
				end);
				frame:Hide();
				frame.list = {  };
				frame.display_list = {  };
				local StartMoving = frame.StartMoving;
				function frame.StartMoving(self)
					self:ClearAllPoints();
					local cal = gui["CALENDAR"];
					cal:ClearAllPoints();
					cal:SetPoint("TOPRIGHT", self, "TOPLEFT", -1, 0);
					StartMoving(self);
				end

				local scroll = ALASCR(frame, nil, nil, ui_style.board_buttonHeight, funcToCreateBoardButton, funcToSetBoardButton);
				scroll:SetPoint("BOTTOMLEFT", 4, 28);
				scroll:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -4, - (ui_style.frameTitle_YSize + ui_style.cal_YToBorder));
				-- scroll:SetPoint("TOPRIGHT", - 4, - 4);
				frame.scroll = scroll;
			--

			do	--	ele
				local close = CreateFrame("BUTTON", nil, frame);
				close:SetSize(20, 20);
				close:SetNormalTexture(ui_style.texture_close);
				close:SetPushedTexture(ui_style.texture_close);
				close:GetPushedTexture():SetVertexColor(0.5, 0.5, 0.5, 0.5);
				close:SetHighlightTexture(ui_style.texture_close);
				close:GetHighlightTexture():SetVertexColor(0.5, 0.5, 0.5, 0.5);
				close:SetPoint("CENTER", frame, "TOPLEFT", 11, -11);
				close:SetScript("OnClick", function()
					frame:Hide();
				end);
				close:SetScript("OnEnter", info_OnEnter);
				close:SetScript("OnLeave", info_OnLeave);
				close.info_lines = { L.CLOSE, };
				frame.close = close;

				local call_calendar = CreateFrame("BUTTON", nil, frame);
				call_calendar:SetSize(20, 20);
				call_calendar:SetNormalTexture(ui_style.texture_arrowright);
				call_calendar:GetNormalTexture():SetVertexColor(unpack(ui_style.texture_triangle_normal_color));
				call_calendar:GetNormalTexture():SetBlendMode("ADD");
				call_calendar:SetPushedTexture(ui_style.texture_arrowright);
				call_calendar:GetPushedTexture():SetVertexColor(unpack(ui_style.texture_triangle_pushed_color));
				call_calendar:GetPushedTexture():SetBlendMode("ADD");
				call_calendar:SetHighlightTexture(ui_style.texture_arrowright);
				call_calendar:GetHighlightTexture():SetAlpha(0.25);
				call_calendar:SetPoint("TOPLEFT", frame, "TOPLEFT", 2, -28);
				function call_calendar:Texture(bool)
					if bool then
						self:SetNormalTexture(ui_style.texture_arrowright);
						self:SetPushedTexture(ui_style.texture_arrowright);
						self:SetHighlightTexture(ui_style.texture_arrowright);
					else
						self:SetNormalTexture(ui_style.texture_arrowleft);
						self:SetPushedTexture(ui_style.texture_arrowleft);
						self:SetHighlightTexture(ui_style.texture_arrowleft);
					end
				end
				call_calendar:Texture(false);
				call_calendar:SetScript("OnClick", function(self)
					NS.ui_toggleGUI("CALENDAR");
				end);
				call_calendar:SetScript("OnEnter", info_OnEnter);
				call_calendar:SetScript("OnLeave", info_OnLeave);
				call_calendar.info_lines = { L.CALL_CALENDAR, };
				local call_calendar_str = call_calendar:CreateFontString(nil, "ARTWORK");
				call_calendar_str:SetFont(ui_style.frameFont, ui_style.smallFontSize, "OUTLINE");
				call_calendar_str:SetText(L["CALENDAR"]);
				call_calendar_str:SetPoint("LEFT", call_calendar, "RIGHT", -2, 0);
				call_calendar.str = call_calendar_str;
				call_calendar:SetHitRectInsets(0, -call_calendar_str:GetWidth(), 0, 0);
				frame.call_calendar = call_calendar;

				local call_config = CreateFrame("BUTTON", nil, frame);
				call_config:SetSize(20, 20);
				call_config:SetNormalTexture(ui_style.texture_config);
				call_config:GetNormalTexture():SetVertexColor(unpack(ui_style.texture_triangle_normal_color));
				call_config:GetNormalTexture():SetBlendMode("ADD");
				call_config:SetPushedTexture(ui_style.texture_config);
				call_config:GetPushedTexture():SetVertexColor(unpack(ui_style.texture_triangle_pushed_color));
				call_config:GetPushedTexture():SetBlendMode("ADD");
				call_config:SetHighlightTexture(ui_style.texture_config);
				call_config:GetHighlightTexture():SetAlpha(0.25);
				call_config:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -2, -2);
				call_config:SetScript("OnClick", function(self)
					NS.ui_toggleGUI("CONFIG");
				end);
				call_config:SetScript("OnEnter", info_OnEnter);
				call_config:SetScript("OnLeave", info_OnLeave);
				call_config.info_lines = { L.CALL_CONFIG, };
				frame.call_config = call_config;

				local call_char_list = CreateFrame("BUTTON", nil, frame);
				call_char_list:SetSize(20, 20);
				call_char_list:SetNormalTexture(ui_style.texture_arrowright);
				call_char_list:GetNormalTexture():SetVertexColor(unpack(ui_style.texture_triangle_normal_color));
				call_char_list:GetNormalTexture():SetBlendMode("ADD");
				call_char_list:SetPushedTexture(ui_style.texture_arrowright);
				call_char_list:GetPushedTexture():SetVertexColor(unpack(ui_style.texture_triangle_pushed_color));
				call_char_list:GetPushedTexture():SetBlendMode("ADD");
				call_char_list:SetHighlightTexture(ui_style.texture_arrowright);
				call_char_list:GetHighlightTexture():SetAlpha(0.25);
				call_char_list:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 2, 4);
				function call_char_list:Texture(bool)
					if bool then
						self:SetNormalTexture(ui_style.texture_arrowright);
						self:SetPushedTexture(ui_style.texture_arrowright);
						self:SetHighlightTexture(ui_style.texture_arrowright);
					else
						self:SetNormalTexture(ui_style.texture_arrowleft);
						self:SetPushedTexture(ui_style.texture_arrowleft);
						self:SetHighlightTexture(ui_style.texture_arrowleft);
					end
				end
				call_char_list:Texture(false);
				call_char_list:SetScript("OnClick", function(self)
					local char_list = gui["CHAR_LIST"];
					if char_list:IsShown() and char_list:GetParent() == self:GetParent() then
						char_list:Hide();
						self:Texture(false);
					else
						char_list:SetParent(self:GetParent());
						char_list:ClearAllPoints();
						char_list:SetPoint("BOTTOMRIGHT", self:GetParent(), "BOTTOMLEFT", -2, 0);
						char_list:Show();
						self:Texture(true);
					end
					gui["CONFIG"].call_char_list:Texture(false);
				end);
				call_char_list:SetScript("OnEnter", info_OnEnter);
				call_char_list:SetScript("OnLeave", info_OnLeave);
				call_char_list.info_lines = { L.CALL_CALENDAR, };
				local call_char_list_str = call_char_list:CreateFontString(nil, "ARTWORK");
				call_char_list_str:SetFont(ui_style.frameFont, ui_style.smallFontSize, "OUTLINE");
				call_char_list_str:SetText(L["CHAR_LIST"]);
				call_char_list_str:SetPoint("LEFT", call_char_list, "RIGHT", -2, 0);
				call_char_list.str = call_char_list_str;
				call_char_list:SetHitRectInsets(0, -call_char_list_str:GetWidth(), 0, 0);
				frame.call_char_list = call_char_list;
			end

			function frame:update_list()
				local list = self.list;
				wipe(list);
				for _, inst in next, SET.raid_list do
					local add_head = true;
					for _, key in next, SET.char_list do
						local VAR = AVAR[key];
						local var = VAR[inst];
						local ms = NS.milestone[inst];
						if ms and ms.phase <= NS.CUR_PHASE and SET.inst_hash[inst] then
							if (var and var[1]) or (SET.show_unlocked and VAR.PLAYER_LEVEL and VAR.PLAYER_LEVEL >= ms.min) or VAR.manual then
								if add_head then
									tinsert(list, 'header');
									tinsert(list, inst);
									add_head = false;
								end
								tinsert(list, 'GUID');
								tinsert(list, key);
							end
						end
					end
				end
				for head, ext in next, extern_list do
					local add_head = true;
					for key, val in next, ext do
						if key ~= 'text' then
							if add_head then
								tinsert(list, 'extern_head');
								tinsert(list, head);
								add_head = false;
							end
							tinsert(list, 'extern_key');
							tinsert(list, key);
						end
					end
				end
			end
			function frame:update_func()
				local collapsed = SET.collapsed;
				local list = self.list;
				local display_list = self.display_list;
				wipe(display_list);
				do
					local index = 1;
					local inst = nil;
					while true do
						if list[index] == nil then
							break;
						elseif list[index] == 'header' then
							inst = list[index + 1];
							tinsert(display_list, 'header');
							tinsert(display_list, inst);
							tinsert(display_list, inst);
						elseif list[index] == 'extern_head' then
							inst = list[index + 1];
							tinsert(display_list, 'extern_head');
							tinsert(display_list, inst);
							tinsert(display_list, inst);
						else
							if not collapsed[inst] then
								tinsert(display_list, list[index]);
								tinsert(display_list, list[index + 1]);
								tinsert(display_list, inst);
							end
						end
						index = index + 2;
					end
				end
				scroll:SetNumValue(#display_list / 3);
				scroll:Update();
			end
			frame:SetScript("OnShow", function(self)
				self:update_func();
				gui["CALENDAR"].call_board:Texture(true);
			end);
			frame:SetScript("OnHide", function(self)
				gui["CALENDAR"].call_board:Texture(false);
			end);
			C_Timer.NewTicker(0.2, function()
				if frame:IsShown() then
					scroll:Update();
				end
			end);

			return frame;
		end
		--
			local manual_drop_meta = {
				handler = function(_, manual, class, drop, text)
					manual.class = class;
					drop.label:SetText(text);
				end,
				elements = {  },
			};
			local char_drop_meta_del = {
				text = L.CHAR_DEL,
				para = { 1, },
			};
			local char_drop_meta_mod = {
				text = L.CHAR_MOD,
				para = { 2, },
			};
			local char_drop_meta = {
				handler = function(_, action, index)
					if action == 1 then
						NS.del_char(index);
					elseif action == 2 then
						gui["CONFIG"]:OpenManual(_, SET.char_list[index]);
					end
				end,
				elements = {
					char_drop_meta_del,
				},
			};
			local function char_button_OnClick(self, button)
				local list = SET.char_list;
				local data_index = self:GetDataIndex() - 1;
				if data_index == 0 then
					gui["CONFIG"]:OpenManual(self);
				elseif data_index <= #list then
					local key = list[data_index];
					if key ~= PLAYER_GUID then
						local VAR = AVAR[key];
						char_drop_meta_del.para[2] = data_index;
						if VAR.manual then
							char_drop_meta.elements[2] = char_drop_meta_mod;
							char_drop_meta_mod.para[2] = data_index;
						else
							char_drop_meta.elements[2] = nil;
						end
						ALADROP(self, "BOTTOM", char_drop_meta);
					end
				end
			end
			local function char_button_OnEnter(self)
			end
			local function funcToCreateCharButton(parent, index, buttonHeight)
				local button = CreateFrame("BUTTON", nil, parent);
				button:SetHeight(buttonHeight);
				button:SetHighlightTexture(ui_style.texture_white);
				button:GetHighlightTexture():SetVertexColor(unpack(ui_style.buttonHighlightColor));
				button:EnableMouse(true);
				button:RegisterForClicks("AnyUp");

				local icon = button:CreateTexture(nil, "BORDER");
				icon:SetTexture(ui_style.texture_unk);
				icon:SetSize(buttonHeight - 4, buttonHeight - 4);
				icon:SetPoint("LEFT", 8, 0);
				if index == 1 then
					icon:SetTexture(ui_style.texture_claw);
				else
					icon:SetTexture("interface\\targetingframe\\ui-classes-circles");
				end
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

				button:SetScript("OnClick", char_button_OnClick);
				button:SetScript("OnEnter", char_button_OnEnter);
				button:SetScript("OnLeave", info_OnLeave);

				local frame = parent:GetParent():GetParent();
				button.frame = frame;

				return button;
			end
			local function funcToSetCharButton(button, data_index)
				local list = SET.char_list;
				data_index = data_index - 1;
				if data_index == 0 then
					button.icon:Show();
					button.title:SetText(L.CHAR_ADD);
					button.note:SetText(nil);
				elseif data_index <= #list then
					local key = list[data_index];
					local VAR = AVAR[key];
					if VAR.manual then
						button.title:SetText(key);
						if VAR.class then
							local class = strupper(VAR.class);
							local coord = CLASS_ICON_TCOORDS[class];
							if coord then
								button.icon:Show();
								button.icon:SetTexCoord(coord[1] + 1 / 256, coord[2] - 1 / 256, coord[3] + 1 / 256, coord[4] - 1 / 256);
							else
								button.icon:Show();
							end
							local classColorTable = RAID_CLASS_COLORS[class];
							if classColorTable then
								button.title:SetVertexColor(classColorTable.r, classColorTable.g, classColorTable.b, 1.0);
							else
								button.title:SetVertexColor(0.75, 0.75, 0.75, 1.0);
							end
						else
							button.icon:Hide();
							button.title:SetVertexColor(0.75, 0.75, 0.75, 1.0);
						end
						button.note:SetText(L.CHAR_ADD);
					else
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
					end
					button:Show();
				else
					button:Hide();
				end
			end
			local function ui_config_CreateCheck(parent, key, text, OnClick)
				local check = CreateFrame("CHECKBUTTON", nil, parent, "OptionsBaseCheckButtonTemplate");
				check:SetSize(24, 24);
				check:SetHitRectInsets(0, 0, 0, 0);
				check:Show();
				local str = parent:CreateFontString(nil, "ARTWORK");
				str:SetFont(ui_style.frameFont, ui_style.frameFontSize, "NORMAL");
				str:SetText(text);
				check.fontString = str;
				str:SetPoint("LEFT", check, "RIGHT", 0, 0);
				check.key = key;
				check:SetScript("OnClick", OnClick);
				function check:SetVal(val)
					self:SetChecked(val);
				end
				return check;
			end
			local function drop_OnClick(self)
				ALADROP(self, "BOTTOM", self.meta);
			end 
			local function ui_config_CreateDrop(parent, key, text, meta)
				local drop = CreateFrame("BUTTON", nil, parent);
				drop:SetSize(20, 20);
				drop:EnableMouse(true);
				drop:SetNormalTexture("interface\\mainmenubar\\ui-mainmenu-scrolldownbutton-up");
				drop:GetNormalTexture():SetTexCoord(6 / 32, 26 / 32, 6 / 32, 26 / 32);
				drop:SetPushedTexture("interface\\mainmenubar\\ui-mainmenu-scrolldownbutton-up");
				drop:GetPushedTexture():SetTexCoord(6 / 32, 26 / 32, 6 / 32, 26 / 32);
				drop:GetPushedTexture():SetVertexColor(0.5, 0.5, 0.5, 0.5);
				drop:SetHighlightTexture("interface\\mainmenubar\\ui-mainmenu-scrolldownbutton-up");
				drop:GetHighlightTexture():SetTexCoord(6 / 32, 26 / 32, 6 / 32, 26 / 32);
				drop:GetHighlightTexture():SetVertexColor(0.5, 0.5, 0.5, 0.5);
				local label = parent:CreateFontString(nil, "ARTWORK");
				label:SetFont(ui_style.frameFont, ui_style.frameFontSize, "NORMAL");
				label:SetText(gsub(text, "%%[a-z]", ""));
				label:SetPoint("LEFT", drop, "RIGHT", 0, 0);
				drop.label = label;
				local str = parent:CreateFontString(nil, "ARTWORK");
				str:SetFont(ui_style.frameFont, ui_style.frameFontSize, "NORMAL");
				str:SetPoint("TOPLEFT", label, "BOTTOMLEFT", 0, -2);
				str:SetVertexColor(0.0, 1.0, 0.0, 1.0);
				drop.fontString = str;
				drop.key = key;
				drop.meta = meta;
				for _, v in next, meta.elements do
					v.para[1] = drop;
				end
				drop:SetScript("OnClick", drop_OnClick);
				function drop:SetVal(val)
					for _, v in next, self.meta.elements do
						if v.para[2] == val then
							self.fontString:SetText(v.text);
							break;
						end
					end
				end
				return drop;
			end
			local function ui_config_CreateSlider(parent, key, text, minVal, maxVal, step, OnValueChanged)
				local label = parent:CreateFontString(nil, "ARTWORK");
				label:SetFont(ui_style.frameFont, ui_style.frameFontSize, "NORMAL");
				label:SetText(gsub(text, "%%[a-z]", ""));
				local slider = CreateFrame("SLIDER", nil, parent, "OptionsSliderTemplate");
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
				return slider;
			end
			StaticPopupDialogs["alaCalendar_RestAllSettings"] = {
				text = L.RESET_ALL_SETTINGS_NOTIFY,
				button1 = YES,
				button2 = OK,
				-- OnShow = function(self) end,
				OnAccept = function(self)
					NS.reset_all_settings();
				end,
				OnHide = function(self)
					self.which = nil;
				end,
				timeout = 0,
				whileDead = true,
				hideOnEscape = true,
				preferredIndex = 1,
			};
		--
		function NS.ui_CreateConfigFrame()
			local frame = CreateFrame("FRAME", "ALA_CALENDAR_CONFIG", UIParent);
			tinsert(UISpecialFrames, "ALA_CALENDAR_CONFIG");
			uireimp._SetSimpleBackdrop(frame, 0, 1, 0.15, 0.15, 0.15, 0.9, 0.0, 0.0, 0.0, 1.0);
			frame:SetSize(620, 250);
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
			close:SetNormalTexture(ui_style.texture_close);
			close:SetPushedTexture(ui_style.texture_close);
			close:GetPushedTexture():SetVertexColor(0.5, 0.5, 0.5, 0.5);
			close:SetHighlightTexture(ui_style.texture_close);
			close:GetHighlightTexture():SetVertexColor(0.5, 0.5, 0.5, 0.5);
			close:SetPoint("CENTER", frame, "TOPRIGHT", -11, -11);
			close:SetScript("OnClick", function(self)
				self.frame:Hide();
			end);
			close:SetScript("OnEnter", info_OnEnter);
			close:SetScript("OnLeave", info_OnLeave);
			close.info_lines = { L.CLOSE, };
			close.frame = frame;
			frame.close = close;
			--
			local reset = CreateFrame("BUTTON", nil, frame);
			reset:SetSize(20, 20);
			reset:SetNormalTexture(ui_style.texture_reset);
			reset:SetPushedTexture(ui_style.texture_reset);
			reset:GetPushedTexture():SetVertexColor(0.5, 0.5, 0.5, 0.5);
			reset:SetHighlightTexture(ui_style.texture_reset);
			reset:GetHighlightTexture():SetVertexColor(0.5, 0.5, 0.5, 0.5);
			reset:SetPoint("TOPLEFT", frame, "TOPLEFT", 2, -2);
			reset:SetScript("OnClick", function()
				StaticPopup_Show("alaCalendar_RestAllSettings");
			end);
			reset:SetScript("OnEnter", info_OnEnter);
			reset:SetScript("OnLeave", info_OnLeave);
			reset.info_lines = { L.RESET_ALL_SETTINGS, };
			frame.reset = reset;
			--
			local set_objects = {  };
			local px, py, h = 0, 0, 1;
			for _, val in next, NS.set_cmd_list do
				if px >= 4 then
					px = 0;
					py = py + h;
					h = 1;
				end
				local key = val[3];
				if val[1] == 'bool' then
					local check = ui_config_CreateCheck(frame, key, L.SLASH_NOTE[key], val[8]);
					check:SetPoint("TOPLEFT", frame, "TOPLEFT", 10 + 150 * px, -25 - 25 * py);
					set_objects[key] = check;
					px = px + 1;
					h = max(h, 2);
				elseif val[7] == 'drop' then
					local drop = ui_config_CreateDrop(frame, key, L.SLASH_NOTE[key], val[8]);
					drop:SetPoint("TOPLEFT", frame, "TOPLEFT", 10 + 150 * px, -25 - 25 * py);
					set_objects[key] = drop;
					px = px + 1;
					h = max(h, 2);
				elseif val[7] == 'slider' then
					if px > 2 then
						px = 0;
						py = py + h;
						h = 1;
					end
					local slider = ui_config_CreateSlider(frame, key, L.SLASH_NOTE[key], val[9][1], val[9][2], val[9][3], val[8]);
					slider:SetPoint("TOPLEFT", frame, "TOPLEFT", 10 + 150 * px, -25 - 25 * py);
					set_objects[key] = slider;
					px = px + 2;
					h = max(h, 2);
				end
			end
			frame.set_objects = set_objects;
			if px ~= 0 then
				px = 0;
				py = py + 2;
				h = 1;
			end
			local inst_objects = {  };
			local function set_instance(self)
				SET.inst_hash[self.key] = self:GetChecked();
				NS.ui_update_calendar();
			end
			for _, key in next, NS.milestone_list do
				local val = SET.inst_hash;
				if px >= 4 then
					px = 0;
					py = py + h;
					h = 1;
				end
				local check = ui_config_CreateCheck(frame, key, L.INSTANCE[key], set_instance);
				check:SetPoint("TOPLEFT", frame, "TOPLEFT", 10 + 150 * px, -25 - 25 * py);
				check:SetChecked(val);
				inst_objects[key] = check;
				px = px + 1;
				h = max(h, 2);
			end
			frame.inst_objects = inst_objects;
			if px ~= 0 then
				px = 0;
				py = py + 2;
				h = 1;
			end
			do	--	character list
				--	char_list
					local char_list = CreateFrame("FRAME", nil, frame);
					uireimp._SetSimpleBackdrop(char_list, 0, 1, 0.15, 0.15, 0.15, 0.9, 0.0, 0.0, 0.0, 1.0);
					char_list:SetSize(360, 400);
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
					frame.char_list = char_list;

					local scroll = ALASCR(char_list, nil, nil, ui_style.char_buttonHeight, funcToCreateCharButton, funcToSetCharButton);
					scroll:SetPoint("BOTTOMLEFT", 4, 12);
					scroll:SetPoint("TOPRIGHT", - 4, - 24);
					char_list.scroll = scroll;
					scroll:SetNumValue(#SET.char_list + 1);

					char_list:SetScript("OnShow", function(self)
						local board = gui["BOARD"];
						if self:GetParent() == board then
							board.call_char_list:Texture(true);
						end
						local config = gui["CONFIG"];
						if self:GetParent() == config then
							config.call_char_list:Texture(true);
						end
					end);
					char_list:SetScript("OnHide", function(self)
						gui["BOARD"].call_char_list:Texture(false);
						gui["CONFIG"].call_char_list:Texture(false);
						self.manual:Hide();
					end);

					local call = CreateFrame("BUTTON", nil, frame);
					call:SetSize(20, 20);
					call:SetNormalTexture(ui_style.texture_arrowright);
					call:GetNormalTexture():SetVertexColor(unpack(ui_style.texture_triangle_normal_color));
					call:GetNormalTexture():SetBlendMode("ADD");
					call:SetPushedTexture(ui_style.texture_arrowright);
					call:GetPushedTexture():SetVertexColor(unpack(ui_style.texture_triangle_pushed_color));
					call:GetPushedTexture():SetBlendMode("ADD");
					call:SetHighlightTexture(ui_style.texture_arrowright);
					call:GetHighlightTexture():SetAlpha(0.25);
					call:SetPoint("TOPLEFT", 10 + 150 * 4 - 20, -25 - 25 * py);
					function call:Texture(bool)
						if bool then
							self:SetNormalTexture(ui_style.texture_arrowleft);
							self:SetPushedTexture(ui_style.texture_arrowleft);
							self:SetHighlightTexture(ui_style.texture_arrowleft);
						else
							self:SetNormalTexture(ui_style.texture_arrowright);
							self:SetPushedTexture(ui_style.texture_arrowright);
							self:SetHighlightTexture(ui_style.texture_arrowright);
						end
					end
					call:Texture(false);
					call:SetScript("OnClick", function(self)
						local char_list = gui["CHAR_LIST"];
						if char_list:IsShown() and char_list:GetParent() == self:GetParent() then
							char_list:Hide();
							self:Texture(false);
						else
							char_list:SetParent(self:GetParent());
							char_list:ClearAllPoints();
							char_list:SetPoint("BOTTOMLEFT", self:GetParent(), "BOTTOMRIGHT", 2, 0);
							char_list:Show();
							self:Texture(true);
						end
						gui["BOARD"].call_char_list:Texture(false);
					end);
					frame.call_char_list = call;
					local str = call:CreateFontString(nil, "OVERLAY");
					str:SetFont(ui_style.frameFont, ui_style.frameFontSize, "NORMAL");
					str:SetPoint("RIGHT", call, "LEFT", -2, 0);
					str:SetVertexColor(1.0, 1.0, 1.0, 1.0);
					str:SetText(L.CHAR_LIST);
					call.fontString = str;
				--
				--	manual
					local manual = CreateFrame("FRAME", nil, char_list);
					uireimp._SetSimpleBackdrop(manual, 0, 1, 0.15, 0.15, 0.15, 0.9, 0.0, 0.0, 0.0, 1.0);
					manual:SetSize(280, 32);
					manual:SetPoint("BOTTOMLEFT", char_list, "TOPLEFT", 0, 2);
					manual:EnableMouse(true);
					manual:SetMovable(true);
					manual:RegisterForDrag("LeftButton");
					manual:Hide();
					manual:SetScript("OnDragStart", function(self)
						self:GetParent():StartMoving();
					end);
					manual:SetScript("OnDragStop", function(self)
						self:GetParent():StopMovingOrSizing();
					end);
					char_list.manual = manual;

					local nameEdit = CreateFrame("EDITBOX", nil, manual);
					nameEdit:SetHeight(24);
					nameEdit:SetFont(ui_style.frameFont, ui_style.frameFontSize, "NORMAL");
					nameEdit:SetAutoFocus(false);
					nameEdit:SetJustifyH("LEFT");
					nameEdit:Show();
					nameEdit:EnableMouse(true);
					nameEdit:SetPoint("LEFT", manual, "LEFT", 4, 0);
					nameEdit:SetWidth(120);
					nameEdit:SetScript("OnEnterPressed", function(self) self:ClearFocus(); end);
					nameEdit:SetScript("OnEscapePressed", function(self) self:ClearFocus(); end);
					nameEdit:ClearFocus();
					nameEdit:SetScript("OnTextChanged", function(self, isUserInput)
						local text = self:GetText();
						if text and text ~= "" then
							self.ok:Enable();
						else
							self.ok:Disable();
						end
					end);
					local nameEditTexture = nameEdit:CreateTexture(nil, "ARTWORK");
					nameEditTexture:SetPoint("TOPLEFT");
					nameEditTexture:SetPoint("BOTTOMRIGHT");
					nameEditTexture:SetTexture("Interface\\Buttons\\greyscaleramp64");
					nameEditTexture:SetTexCoord(0.0, 0.25, 0.0, 0.25);
					nameEditTexture:SetAlpha(0.75);
					nameEditTexture:SetBlendMode("ADD");
					nameEditTexture:SetVertexColor(0.25, 0.25, 0.25);
					manual.nameEdit = nameEdit;

					local classDrop = CreateFrame("BUTTON", nil, manual);
					classDrop:SetSize(20, 20);
					classDrop:SetPoint("LEFT", nameEdit, "RIGHT", 4, 0);
					classDrop:EnableMouse(true);
					classDrop:SetNormalTexture("interface\\mainmenubar\\ui-mainmenu-scrolldownbutton-up");
					classDrop:GetNormalTexture():SetTexCoord(6 / 32, 26 / 32, 6 / 32, 26 / 32);
					classDrop:SetPushedTexture("interface\\mainmenubar\\ui-mainmenu-scrolldownbutton-up");
					classDrop:GetPushedTexture():SetTexCoord(6 / 32, 26 / 32, 6 / 32, 26 / 32);
					classDrop:GetPushedTexture():SetVertexColor(0.5, 0.5, 0.5, 0.5);
					classDrop:SetHighlightTexture("interface\\mainmenubar\\ui-mainmenu-scrolldownbutton-up");
					classDrop:GetHighlightTexture():SetTexCoord(6 / 32, 26 / 32, 6 / 32, 26 / 32);
					classDrop:GetHighlightTexture():SetVertexColor(0.5, 0.5, 0.5, 0.5);
					local label = classDrop:CreateFontString(nil, "ARTWORK");
					label:SetFont(ui_style.frameFont, ui_style.frameFontSize, "NORMAL");
					label:SetPoint("LEFT", classDrop, "RIGHT", 0, 0);
					classDrop.label = label;
					for class, lClass in next, L.COLORED_CLASS do
						tinsert(manual_drop_meta.elements, { text = lClass, para = { manual, class, classDrop, lClass, }, });
					end
					classDrop.meta = manual_drop_meta;
					classDrop:SetScript("OnClick", drop_OnClick);
					manual.classDrop = classDrop;

					local ok = CreateFrame("BUTTON", nil, manual);
					ok:SetSize(20, 20);
					ok:SetPoint("RIGHT", manual, "RIGHT", -4, 0);
					ok:EnableMouse(true);
					ok:SetNormalTexture("interface\\raidframe\\readycheck-ready");
					ok:SetPushedTexture("interface\\raidframe\\readycheck-ready");
					ok:GetPushedTexture():SetVertexColor(0.5, 0.5, 0.5, 0.5);
					ok:SetHighlightTexture("interface\\raidframe\\readycheck-ready");
					ok:GetHighlightTexture():SetVertexColor(0.5, 0.5, 0.5, 0.5);
					ok:SetDisabledTexture("interface\\raidframe\\readycheck-ready");
					ok:GetDisabledTexture():SetVertexColor(0.25, 0.25, 0.25, 1.0);
					ok:SetScript("OnClick", function(self)
						local manual = self:GetParent();
						local key = manual.nameEdit:GetText();
						if manual.key == nil then
							if AVAR[key] == nil then
								NS.add_char(key, NS.init_var({ PLAYER_LEVEL = 60, class = manual.class, manual = true, }));
								manual:Hide();
							else
								print(key, L.EXISTED);
							end
						else
							if AVAR[key] == nil or key == manual.key then
								local orig = AVAR[manual.key];
								NS.del_char_by_key(manual.key);
								orig.class = manual.class;
								NS.add_char(key, orig);
								manual:Hide();
							else
								print(key, L.EXISTED);
							end
						end
					end);
					manual.ok = ok;
					nameEdit.ok = ok;
					local cancel = CreateFrame("BUTTON", nil, manual);
					cancel:SetSize(20, 20);
					cancel:SetPoint("RIGHT", ok, "LEFT", -4, 0);
					cancel:EnableMouse(true);
					cancel:SetNormalTexture("interface\\raidframe\\readycheck-notready");
					cancel:SetPushedTexture("interface\\raidframe\\readycheck-notready");
					cancel:GetPushedTexture():SetVertexColor(0.5, 0.5, 0.5, 0.5);
					cancel:SetHighlightTexture("interface\\raidframe\\readycheck-notready");
					cancel:GetHighlightTexture():SetVertexColor(0.5, 0.5, 0.5, 0.5);
					cancel:SetDisabledTexture("interface\\raidframe\\readycheck-notready");
					cancel:GetDisabledTexture():SetVertexColor(0.25, 0.25, 0.25, 1.0);
					cancel:SetScript("OnClick", function(self)
						local manual = self:GetParent();
						manual:Hide();
					end);
					manual.cancel = cancel;

					frame.manual = manual;
					function frame:OpenManual(anchor, key)
						local manual = self.manual;
						if anchor then
							-- manual:SetParent(anchor);
							-- manual:ClearAllPoints();
							-- manual:SetPoint("CENTER", anchor, "CENTER", 0, -4);
							-- manual:ClearAllPoints();
						end
						if key then
							local VAR = AVAR[key];
							if VAR then
								manual.nameEdit:SetText(key);
								if VAR.class then
									manual.classDrop.label:SetText(L.COLORED_CLASS[VAR.class]);
									manual.class = VAR.class;
								else
									manual.classDrop.label:SetText("");
									manual.class = nil;
								end
								manual.key = key;
								manual:Show();
							end
						else
							manual.nameEdit:SetText("");
							manual.classDrop.label:SetText("");
							manual.class = nil;
							manual.key = nil;
							manual:Show();
						end
					end
				--
			end
			function frame:Refresh()
				local set_objects = self.set_objects;
				for key, obj in next, set_objects do
					obj:SetVal(SET[key]);
				end
				local inst_objects = self.inst_objects;
				for key, obj in next, inst_objects do
					obj:SetVal(SET.inst_hash[key]);
				end
			end
			frame:SetHeight(25 + py * 25 + 25);
			frame:SetScript("OnShow", function(self)
				self:Refresh();
			end);
			return frame;
		end
	end

	local ADDON_PREFIX = "ALACAL";
	local ADDON_MSG_CONTROL_CODE_LEN = 6;
	local ADDON_MSG_QUERY = "_q_cal";
	local ADDON_MSG_REPLY = "_r_cal";
	local ADDON_MSG_BCMDAILY = "_b_dlu";
	local ADDON_MSG_VER = 1;
	local ADDON_MSG_MIN_VER = 1;
	local ADDON_MSG_MAX_VER = 1;
	do	--	comm
		--	GUID#INST# index-count #id#t#numEncounters#encounterProgress#bossName#isKilled
		local function encode_data(cache, max_len, GUID, inst, var)
			if var and var[1] then
				local prefix = GUID .. "#" .. inst .. "#";
				local data = tostring(var[1]);
				for index = 2, #var do
					data = data .. "#" .. tostring(var[index]);
				end
				local len1 = strlen(prefix);
				local len2 = strlen(data);
				if len1 + len2 + 6 <= max_len then
					tinsert(cache, prefix .. "0-0#" .. data);
				else
					local len3 = max_len - len1 - 8;
					local num = ceil(len2 / len3);
					for index = 1, num do
						tinsert(cache, prefix .. tostring(index) .. "-" .. tostring(num) .. "#" .. strsub(data, (index - 1) * len3 + 1, min(index * len3, len2)));
					end
				end
			end
		end
		local function decode_data(data)
			local val = { strsplit("#", data) };
			val[1] = tonumber(val[1]);
			val[2] = tonumber(val[2]);
			val[3] = tonumber(val[3]);
			val[4] = tonumber(val[4]);
			for index = 5, #val, 2 do
				if val[index] == "true" then
					val[index] = true;
				else
					val[index] = false;
				end
			end
			return val;
		end
		local function cache_received(cache, data)
			local GUID, inst, index, count, val = strmatch(data, "([^#]+)#([^#]+)#([^#^-]+)%-([^#^-]+)#(.+)");
			if GUID then
				index = tonumber(index);
				count = tonumber(count);
				if index and count then
					local C = cache[GUID];
					if C == nil then C = {  }; cache[GUID] = C; end
					local c = C[inst];
					if c == nil then c = {  }; C[inst] = c; end
					c[index] = val;
					if #c == count then
						c[0] = tConcat(c, "", 1, count);
						return true, true;
					end
					return true, false;
				end
			end
			return false;
		end
		function NS.CHAT_MSG_ADDON(prefix, msg, channel, sender, target, zoneChannelID, localID, name, instanceID)
			local name, realm = strsplit("-", sender);
			if realm == nil or realm == PLAYER_REALM_NAME then
				sender = name;
				if prefix == ADDON_PREFIX then
					local control_code = strsub(msg, 1, ADDON_MSG_CONTROL_CODE_LEN);
					if control_code == ADDON_MSG_BCMDAILY then
						local _, MinVer, MaxVer, NID, NTime, NSRC, HID, HTime, HSRC, CID, CTime, CSRC, FID, FTime, FSRC = strsplit("#", msg);
						MinVer = tonumber(MinVer) or 999999;
						MaxVer = tonumber(MaxVer) or -1;
						if ADDON_MSG_VER >= MinVer and ADDON_MSG_VER <= MaxVer then
							NS.DailyOnComm(
								channel, sender,
								NID, NTime, NSRC,
								HID, HTime, HSRC,
								CID, CTime, CSRC,
								FID, FTime, FSRC
							);
						end
					end
				-- elseif prefix == "REPUTABLE" then
					-- local action, version, NID, _, HID, _, CID, _, FID, _, PvP, _ = strsplit(":", msg);
					-- if action ~= nil then
					-- 	NS.DailyOnComm(
					-- 		nil,
					-- 		NID, -1,
					-- 		HID, -1,
					-- 		CID, -1,
					-- 		FID, -1,
					-- 		channel, sender
					-- 	);
					-- end
				end
			end
		end
		NS.CHAT_MSG_ADDON_LOGGED = NS.CHAT_MSG_ADDON;
		function NS.InitComm()
			-- local r1, r2 = RegisterAddonMessagePrefix(ADDON_PREFIX), RegisterAddonMessagePrefix("REPUTABLE");
			-- if r1 or r2 then
			if RegisterAddonMessagePrefix(ADDON_PREFIX) then
				_EventHandler:RegEvent("CHAT_MSG_ADDON");
				_EventHandler:RegEvent("CHAT_MSG_ADDON_LOGGED");
			end
		end
	end

	do	--	daily
		local DLY = nil;
		local LT_DailyInfo = {  };
		local LT_QuestList = NS.DailyQuests;
		local LT_QuestCompleted = {  };
		local LT_QuestName2ID = {  };
		local LT_ValidNPC = nil;
		local LT_BCMCD = {
			GROUP = GetServerTime() - 8,
			GUILD = GetServerTime() - 8,
			YELL = GetServerTime() - 16,
		};
		local function GetCalMessage()
			--	ADDON_MSG_BCMDAILY#ID#FLAG#TIME
			-- local reputable = "send:1.27-bcc";
			local msg = ADDON_MSG_BCMDAILY .. "#" .. ADDON_MSG_MIN_VER .. "#" .. ADDON_MSG_MAX_VER;
			for index = 1, 4 do
				local D = DLY[index];
				if D ~= nil and D[1] ~= nil then
					-- reputable = reputable .. ":" .. D[1] .. ":" .. GetQuestResetTime();
					msg = msg .. "#" .. D[1] .. "#" .. (D[2] or -1) .. "#" .. (D[3] or "*");
				else
					-- reputable = reputable .. "::";
					msg = msg .. "###";
				end
			end
			-- reputable = reputable .. "::";
			return msg;
		end
		local function PeriodicCheck()
			local now = GetServerTime();
			local valid = false;
			local nextreset = now + GetQuestResetTime();
			local prevreset = nextreset - 86400;
			for index = 1, 4 do
				local D = DLY[index];
				if D ~= nil and D[2] ~= nil and prevreset <= D[2] then
					valid = true;
				elseif D ~= nil then
					if next(D) ~= nil then
						if __isdev then
							if D[2] ~= nil then
								_log_("daily clean #" .. index .. " id: " .. (D[1] or -1) .. date(" %Y-%m-%d %H:%M:%S", D[2]));
							else
								_log_("daily clean #" .. index .. " id: " .. (D[1] or -1));
							end
						end
						wipe(D);
					end
				else
					if __isdev then
						_log_("daily clean #" .. index);
					end
					DLY[index] = {  };
				end
			end
			if valid then
				local calmsg = nil;
				if IsInGroup(LE_PARTY_CATEGORY_HOME) and LT_BCMCD.GROUP < now then
					LT_BCMCD.GROUP = now + 16;
					calmsg = calmsg or GetCalMessage();
					if IsInRaid(LE_PARTY_CATEGORY_HOME) then
						SendAddonMessage(ADDON_PREFIX, calmsg, "RAID");
					else
						SendAddonMessage(ADDON_PREFIX, calmsg, "PARTY");
					end
				end
				if GetGuildInfo('player') ~= nil and LT_BCMCD.GUILD < now then
					LT_BCMCD.GUILD = now + 16;
					calmsg = calmsg or GetCalMessage();
					SendAddonMessage(ADDON_PREFIX, calmsg, "GUILD");
				end
				if LT_BCMCD.YELL < now then
					LT_BCMCD.YELL = now + 32;
					calmsg = calmsg or GetCalMessage();
					SendAddonMessage(ADDON_PREFIX, calmsg, "YELL");
				end
			end
		end
		function NS.InitDaily()
			if LT_QuestList ~= nil then
				local list = LT_QuestList[1];
				for id, val in next, list do
					local name = C_QuestLog.GetQuestInfo(id) or val[1];
					local area = C_Map.GetAreaInfo(val[2]);
					LT_DailyInfo[id] = { "  |Tinterface\\lfgframe\\battlenetworking9:0:0:0:-2:64:64:11:52:12:53|t" .. (DUNGEON_DIFFICULTY1 or "Normal"), area .. "  ", 1, };
					LT_QuestName2ID[name] = id;
				end
				local list = LT_QuestList[2];
				for id, val in next, list do
					local name = C_QuestLog.GetQuestInfo(id) or val[1];
					local area = C_Map.GetAreaInfo(val[2]);
					LT_DailyInfo[id] = { "  |Tinterface\\lfgframe\\lfg:0:0:0:-2:64:32:2:29:2:29|t" .. (DUNGEON_DIFFICULTY2 or "Heroic"), area .. "  ", 2, };
					LT_QuestName2ID[name] = id;
				end
				local list = LT_QuestList[3];
				for id, val in next, list do
					local name = C_QuestLog.GetQuestInfo(id) or val[1];
					LT_DailyInfo[id] = { "  |T133971:0:0:0:-2:64:64:3:61:3:61|t" .. (PROFESSIONS_COOKING or "Cooking"), name .. "  ", 3, };
					LT_QuestName2ID[name] = id;
				end
				local list = LT_QuestList[4];
				for id, val in next, list do
					local name = C_QuestLog.GetQuestInfo(id) or val[1];
					LT_DailyInfo[id] = { "  |T136245:0:0:0:-2:64:64:3:61:3:61|t" .. (PROFESSIONS_FISHING or "Fishing"), name .. "  ", 4, };
					LT_QuestName2ID[name] = id;
				end
				LT_ValidNPC = LT_QuestList.MonitoredNPC;
				--
				DLY = DB.daily;
				--
				GetQuestsCompleted(LT_QuestCompleted);
				-- local completed = GetQuestsCompleted();
				-- for id, info in next, LT_DailyInfo do
				-- 	LT_QuestCompleted[id] = completed[id];
				-- end
				--
				_EventHandler:RegEvent("GOSSIP_SHOW");
				_EventHandler:RegEvent("QUEST_DETAIL");
				_EventHandler:RegEvent("QUEST_TURNED_IN");
				--
				C_Timer.NewTicker(4, PeriodicCheck);
			else
				NS.AddDailyInfo = function() end
			end
		end
		local function ProcQuests(...)
			--	titleText, level, isTrivial, frequency, isRepeatable, isLegendary, isIgnored
			local num = select("#", ...) / 7;
			num = num - num % 1.0;
			for index = 1, num do
				local name = select(index * 7 - 6, ...);
				local id = LT_QuestName2ID[name];
				if id ~= nil and LT_DailyInfo[id] ~= nil then
					local info = LT_DailyInfo[id];
					DLY[info[3]] = { id, GetServerTime(), PLAYER_FULLNAME, };
				end
			end
		end
		local function DelayProcQuests()
			local GUID = UnitGUID('npc');
			if GUID ~= nil then
				local _, _, _, _, _, id = strsplit("-", GUID);
				if LT_ValidNPC[id] then
					ProcQuests(GetGossipAvailableQuests());
				end
			end
		end
		function NS.GOSSIP_SHOW()
			local GUID = UnitGUID('npc');
			if GUID ~= nil then
				local _, _, _, _, _, id = strsplit("-", GUID);
				if LT_ValidNPC[id] then
					ProcQuests(GetGossipAvailableQuests());
					C_Timer.After(0.2, DelayProcQuests);
				end
			end
		end
		function NS.QUEST_DETAIL()
			local GUID = UnitGUID('npc');
			if GUID ~= nil then
				local _, _, _, _, _, id = strsplit("-", GUID);
				if LT_ValidNPC[id] then
					local id = GetQuestID();
					local info = LT_DailyInfo[id];
					if info ~= nil then
						DLY[info[3]] = { id, GetServerTime(), PLAYER_FULLNAME, };
					end
				end
			end
		end
		function NS.QUEST_TURNED_IN(id)
			if LT_DailyInfo[id] ~= nil then
				LT_QuestCompleted[id] = true;
				C_Timer.After(1.0, function() GetQuestsCompleted(LT_QuestCompleted); end);
			end
		end
		local DONE = DONE or "DONE";
		local DAILY = DAILY or QUESTS_LABEL or "Daily";
		local RESETS_IN = RESETS_IN or "Reset in "
		function NS.AddDailyInfo(Tooltip)
			local got = false;
			Tooltip:AddDoubleLine(DAILY, GetDailyQuestsCompleted() .. " / " ..  GetMaxDailyQuests(), 1, 1, 0, 1, 1, 1);
			for index = 1, 4 do
				local D = DLY[index];
				if D ~= nil and D[1] ~= nil then
					if got == false then
						got = true;
						Tooltip:AddDoubleLine(RESETS_IN, NS.seconds_to_colored_formatted_time_len(GetQuestResetTime()), 1, 1, 0, 1, 1, 1);
					end
					local info = LT_DailyInfo[D[1]];
					if LT_QuestCompleted[D[1]] then
						Tooltip:AddDoubleLine(info[1] .. "(" .. DONE .. ")", info[2], 0, 1, 0, 1, 1, 1);
					else
						Tooltip:AddDoubleLine(info[1], info[2], 1, 0, 0, 1, 1, 1);
					end
					if __isdev and D[3] ~= nil then
						Tooltip:AddDoubleLine(" ", D[3], 0, 0, 0, 0.25, 0.25, 0.25);
					end
				end
			end
			if got then
				Tooltip:AddLine(" ");
			end
		end
		local function CheckComm(index, id, time, src, sender)
			local D = DLY[index];
			id = tonumber(id);
			time = tonumber(time);
			if id ~= nil and id > 0 then
				if D == nil then
					DLY[index] = { val, time, };
					if __isdev then
						_log_("recv add #" .. index .. " id: " .. id .. " src:" .. src .. " @" .. sender .. date(" %Y-%m-%d %H:%M:%S", time));
					end
				elseif D[1] == nil or D[2] == nil or D[2] < time then
					if __isdev then
						_log_("recv ref #" .. index .. " prev: " .. (D[1] or -1));
					end
					D[1] = id;
					D[2] = time;
					D[3] = src;
					if __isdev then
						_log_("recv ref #" .. index .. " id: " .. id .. " src:" .. src .. " @" .. sender .. date(" %Y-%m-%d %H:%M:%S", time));
					end
				elseif D[1] ~= id then
					return 1;
				end
			end
			return 0;
		end
		function NS.DailyOnComm(channel, sender, NID, NTime, NSRC, HID, HTime, HSRC, CID, CTime, CSRC, FID, FTime, FSRC)
			local v = CheckComm(1, NID, NTime, NSRC, sender) + CheckComm(2, HID, HTime, HSRC, sender) + CheckComm(3, CID, CTime, CSRC, sender) + CheckComm(4, FID, FTime, FSRC, sender);
			if (v <= 0) and channel == "YELL" then
				LT_BCMCD.YELL = min(LT_BCMCD.YELL + 16, GetServerTime() + 32);
			end
		end
	end

	function NS.RegInstanceEvent()
		_EventHandler:RegEvent("PLAYER_LOGOUT");
		_EventHandler:RegEvent("PLAYER_LEVEL_UP");
		_EventHandler:RegEvent("ENCOUNTER_END");
		_EventHandler:RegEvent("BOSS_KILL");
		_EventHandler:RegEvent("UPDATE_INSTANCE_INFO");
	end
	local function icon_OnClick(self, button)
		if button == "RightButton" then
			if gui["BOARD"]:IsShown() then
				gui["BOARD"]:Hide();
			else
				gui["BOARD"]:Show();
			end
		else
			if gui["CALENDAR"]:IsShown() then
				gui["CALENDAR"]:Hide();
			else
				gui["CALENDAR"]:Show();
			end
		end
	end
	function NS.CreateUI()
		--	GUI
			local calendar = NS.ui_CreateCalendar();
			gui["CALENDAR"] = calendar;
			local board = NS.ui_CreateBoard();
			gui["BOARD"] = board;
			local config = NS.ui_CreateConfigFrame();
			gui["CONFIG"] = config;
			gui["CHAR_LIST"] = config.char_list;
			--
			if GameTimeFrame then
				GameTimeFrame:SetScript("OnMouseUp", icon_OnClick);
				if GameTimeFrame_UpdateTooltip ~= nil then
					hooksecurefunc("GameTimeFrame_UpdateTooltip", function()
						GameTooltip:AddLine(" ");
						NS.AddDailyInfo(GameTooltip);
						for _, text in next, L.TooltipLines do
							GameTooltip:AddLine(text);
						end
						GameTooltip:Show();
					end);
				end
				if SET.show_indicator then
					local TEXTURE = "interface\\minimap\\supertrackerarrow";
					local NUM_TEX = 8;
					local SPEED = 16;
					local w, h = GameTimeFrame:GetHeight() * 4, GameTimeFrame:GetHeight();
					local step = ceil(w / NUM_TEX);
					w = step * NUM_TEX;
					local indicator = CreateFrame("FRAME", nil, GameTimeFrame);
					indicator:SetSize(w, h);
					indicator:SetPoint("RIGHT", GameTimeFrame, "LEFT", 0, 0);
					indicator:EnableMouse(false);
					local textures = {  };
					for index = 1, NUM_TEX do
						local texture = indicator:CreateTexture(nil, "OVERLAY");
						texture:SetSize(h / 2, h);
						texture:SetTexture(TEXTURE);
						texture:SetTexCoord(6 / 32, 26 / 32, 26 / 32, 26 / 32, 6 / 32, 6 / 32, 26 / 32, 6 / 32);
						texture:SetBlendMode("ADD");
						textures[index] = texture;
					end
					local timer = 0;
					indicator:SetScript("OnUpdate", function(self, elasped)
						timer = timer + elasped;
						for index = 1, NUM_TEX do
							local texture = textures[index];
							texture:ClearAllPoints();
							local temp = (SPEED * timer) % step;
							texture:SetPoint("RIGHT", indicator, "RIGHT", -(step * (index - 1) - abs(temp - step * 0.5) * 2), 0);
						end
					end);
					--
					calendar:HookScript("OnShow", function()
						indicator:Hide();
						SET.show_indicator = false;
					end);
					board:HookScript("OnShow", function()
						indicator:Hide();
						SET.show_indicator = false;
					end);
				end
			end
		--	External Lib
			if LibStub then
				--	DBICON
					local LDI = LibStub("LibDBIcon-1.0", true);
					if LDI then
						LDI:Register("alaCalendar",
							{
								icon = ARTWORK_ICON_PATH,
								OnClick = icon_OnClick,
								text = L.DBIcon_Text,
								OnTooltipShow = function(tt)
										tt:AddLine("alaCalendar");
										tt:AddLine(" ");
										-- NS.AddDailyInfo(tt);
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
							LDI:Show("alaCalendar");
						else
							LDI:Hide("alaCalendar");
						end
						local mb = LDI:GetMinimapButton("alaCalendar");
						mb:RegisterEvent("PLAYER_LOGOUT");
						mb:HookScript("OnEvent", function(self)
							SET.minimapPos = self.minimapPos or self.db.minimapPos;
						end);
						mb:HookScript("OnDragStop", function(self)
							SET.minimapPos = self.minimapPos or self.db.minimapPos;
						end);
					end
				--	LDB
					local LDB = LibStub:GetLibrary("LibDataBroker-1.1");
					if LDB then
						local obj = LDB:NewDataObject("alacal", {
							type = "launcher",
							icon = ARTWORK_ICON_PATH,
							OnClick = icon_OnClick,
							OnTooltipShow = function(tt)
								tt:AddLine("alaCalendar");
								tt:AddLine(" ");
								for _, text in next, L.TooltipLines do
									tt:AddLine(text);
								end
								tt:Show();
							end,
						});
					end
			end
		--
	end
	--
	function NS.ui_toggleGUI(key, on)
		local frame = gui[key];
		if frame then
			if frame:IsShown() or on == false then
				frame:Hide();
				return frame, false;
			else
				frame:Show();
				return frame, true;
			end
		end
	end
	function NS.ui_update_calendar()
		local calendar = gui["CALENDAR"];
		NS.ui_refreshWeekTitle(calendar);
		calendar:update_func();
	end
	function NS.ui_update_board()
		local board = gui["BOARD"];
		board:update_list();
		if board:IsShown() then
			board:update_func();
		end
	end
	function NS.ui_update_config_char_list()
		local cs = gui["CHAR_LIST"].scroll;
		if cs:IsShown() then
			cs:SetNumValue(#SET.char_list + 1);
			cs:Update();
		end
	end
	function NS.ui_refresh_calendar()
		NS.ui_refreshWeekTitle(gui["CALENDAR"]);
	end
	function NS.ui_refresh_config()
		gui["CONFIG"]:Refresh();
	end
	function NS.ON_SET_CHANGED(att, val)
		if att == "region" then
			local region = gui["CALENDAR"].region;
			region.str:SetText(L.REGION[SET.region]);
			region:SetWidth(region.str:GetWidth() + 8);
		elseif att == "dst" then
			local dst = gui["CALENDAR"].dst;
			dst:SetChecked(not val);
		elseif att == "scale" then
			gui["CALENDAR"]:SetScale(SET.scale);
			gui["BOARD"]:SetScale(SET.scale);
		elseif att == "alpha" then
			gui["CALENDAR"]:SetAlpha(SET.alpha);
			gui["BOARD"]:SetAlpha(SET.alpha);
		end
		NS.ui_refresh_config();
	end
end

do	--	INITIALIZE
	--	1 = US Pacific, 3 = Europe, 4 = Taiwan, 5 = China, 6 = US Eastern
	local temp = {
		enUS = 1,
		koKR = 3,
		zhTW = 5,
		zhCN = 6,
	};
	local default_set = {
		region = temp[LOCALE] or 4,
		dst = false;
		use_realm_time_zone = false,
		first_col_day = IsEastAsiaFormat() and 1 or 0;
		instance_icon = true,
		instance_text = false,
		show_indicator = true,
		show_DBIcon = true,
		minimapPos = 215,
		scale = 1.0,
		alpha = 1.0,
		cal_pos = { 0, 0, };
		show_unlocked = false,
		hide_calendar_on_esc = true,
		hide_board_on_esc = true,
	};
	if LOCALE == 'zhCN' or LOCALE == 'zhTW' or LOCALE == 'koKR' then
		default_set.dst = false;
	else
		default_set.dst = true;
	end
	local function MODIFY_SAVED_VARIABLE()
		DB = alaCalendarSV;
		if DB == nil or DB._version == nil or DB._version < 210606.01 then
			DB = {
				set = {
					raid_list = Mixin({  }, NS.raid_list),
					inst_hash = Mixin({  }, NS.instances_hash),
					char_list = {  },
					collapsed = {  },
				},
				var = {  },
				daily = {  };
			};
			_G.alaCalendarSV = DB;
		elseif DB._version < 220308.01 then
			for GUID, VAR in next, DB.var do
				for _, inst in next, NS.raid_list do
					if VAR[inst] == nil then
						VAR[inst] = {  };
					end
				end
			end
			DB.daily = {  };
		end
		DB._version = 220308.01;
		NS:MergeGlobal(DB);
		--
		DB.set = DB.set or {
			raid_list = Mixin({  }, NS.raid_list),
			inst_hash = Mixin({  }, NS.instances_hash),
			char_list = {  },
			collapsed = {  },
		};
		DB.var = DB.var or {  };
		DB.daily = DB.daily or {  };
		--
		SET = setmetatable(DB.set, { __index = default_set, });
		AVAR = DB.var;
		VAR = AVAR[PLAYER_GUID];
		if VAR == nil then
			VAR = NS.init_var({ PLAYER_LEVEL = UnitLevel('player'), realm_id = PLAYER_REALM_ID, realm_name = PLAYER_REALM_NAME, });
			NS.add_char(PLAYER_GUID, VAR, true);
		end
		VAR.PLAYER_LEVEL = UnitLevel('player');
		do	--	VALIDATE
			Mixin(SET.raid_list, NS.raid_list);
			for index = #SET.raid_list, 1, -1 do
				local inst = SET.raid_list[index];
				if NS.instances_hash[inst] == nil then
					tremove(SET.raid_list, index);
				end
			end
			--
			-- Mixin(SET.inst_hash, NS.instances_hash);
			for inst, v in next, NS.instances_hash do
				if SET.inst_hash[inst] == nil then
					SET.inst_hash[inst] = v;
				end
			end
			for inst, v in next, SET.inst_hash do
				if NS.instances_hash[inst] == nil then
					SET.inst_hash[inst] = nil;
				end
			end
			--
			local char_list = SET.char_list;
			for index = #char_list, 1, -1 do
				if AVAR[char_list[index]] == nil then
					tremove(char_list, index);
				end
			end
			for key, VAR in next, AVAR do
				local found = false;
				for index, k in next, char_list do
					if k == key then
						found = true;
						break;
					end
				end
				if not found then
					if VAR.manual then
						tinsert(char_list, key);
					else
						tinsert(char_list, 1, key);
					end
				end
			end
		end
		for GUID, VAR in next, AVAR do
			if not VAR.manual then
				GetPlayerInfoByGUID(GUID);
			end
		end
		if DB.__overridedev == false then
			__isdev = false;
		end
	end
	local function init()
		--	NS.db_init();
		NS.InitTimeZone();
		NS.RegInstanceEvent();
		NS.InitDaily();
		NS.CreateUI();
		NS.InitInstance();
		NS.InitComm();
		--
		if __ala_meta__.initpublic then __ala_meta__.initpublic(); end
	end
	function NS.reset_all_settings()
		_G.alaCalendarSV = nil;
		MODIFY_SAVED_VARIABLE();
		NS.InitTimeZone();
		NS.InitInstance();
		for _, v in next, NS.set_cmd_list do
			if v[5] then
				v[5](v[3], SET[v[3]]);
			end
		end
		SET.show_indicator = false;
		NS.ui_refresh_config();
	end
	function NS.PLAYER_ENTERING_WORLD()
		_EventHandler:UnregEvent("PLAYER_ENTERING_WORLD");
		if not NS.initializeddb then
			NS.ADDON_LOADED(ADDON);
		end
		init();
	end
	_EventHandler:RegEvent("PLAYER_ENTERING_WORLD");
	function NS.ADDON_LOADED(addon)
		if addon == ADDON then
			_EventHandler:UnregEvent("ADDON_LOADED");
			if not NS.initializeddb then
				MODIFY_SAVED_VARIABLE();
			end
		end
	end
	_EventHandler:RegEvent("ADDON_LOADED");
end

do	--	SLASH
	local SEPARATOR = "[ %`%~%!%@%#%$%%%^%&%*%(%)%-%_%=%+%[%{%]%}%\\%|%;%:%\'%\"%,%<%.%>%/%?]*";
	--	1type, 2pattern, 3key, 4note(string or func), 5proc_func(key, val), 6func_to_mod_val(val), 7config_type(nil for check), 8cmd_for_config / drop_meta, 9para[sldier:{min, max, step}]
	NS.set_cmd_list = {
		{	--	region
			'num',
			"^region" .. SEPARATOR .. "(.*)" .. SEPARATOR .. "$",
			"region",
			function(key, val)
				return format(L.SLASH_NOTE["region"], L.REGION[val]);
			end,
			function(key, val)
				NS.apply_region[val]();
				NS.ui_update_calendar();
			end,
			function(val)
				if val >= 1 and val <= 6 then
					return floor(val);
				end
			end,
			[7] = 'drop',
			[8] = {
				handler = function(_, drop, val)
					SlashCmdList["ALACALENDAR"]("setregion" .. val);
					drop:SetVal(val);
				end,
				elements = {
					{
						text = L.REGION[1],
						para = { nil, 1, },
					},
					{
						text = L.REGION[2],
						para = { nil, 2, },
					},
					{
						text = L.REGION[3],
						para = { nil, 3, },
					},
					{
						text = L.REGION[4],
						para = { nil, 4, },
					},
					{
						text = L.REGION[5],
						para = { nil, 5, },
					},
					{
						text = L.REGION[6],
						para = { nil, 6, },
					},
				},
			},
		},
		{	--	dst
			'bool',
			"^dst" .. SEPARATOR .. "(.*)" .. SEPARATOR .. "$",
			"dst",
			L.SLASH_NOTE["dst"],
			function(key, val)
				NS.set_time_zone();
				NS.ui_update_calendar();
			end,
			[8] = function(self)
				if self:GetChecked() then
					SlashCmdList["ALACALENDAR"]("setdst1");
				else
					SlashCmdList["ALACALENDAR"]("setdst0");
				end
			end,
		},
		{	--	use_realm_time_zone
			'bool',
			"^use" .. SEPARATOR .. "realm" .. SEPARATOR .. "time" .. SEPARATOR .. "zone" .. SEPARATOR .. "(.*)" .. SEPARATOR .. "$",
			"use_realm_time_zone",
			L.SLASH_NOTE["use_realm_time_zone"],
			function(key, val)
				NS.set_time_zone();
				NS.ui_update_calendar();
			end,
			[8] = function(self)
				if self:GetChecked() then
					SlashCmdList["ALACALENDAR"]("setuse_realm_time_zone1");
				else
					SlashCmdList["ALACALENDAR"]("setuse_realm_time_zone0");
				end
			end,
		},
		{	--	first_col_day
			'num',
			"^first" .. SEPARATOR .. "col" .. SEPARATOR .. "day" .. SEPARATOR .. "(.*)" .. SEPARATOR .. "$",
			"first_col_day",
			function(key, val)
				return format(L.SLASH_NOTE["first_col_day"], L.WEEKTITLE[val]);
			end,
			function(key, val)
				NS.ui_update_calendar();
			end,
			function(val)
				return floor(val % NUM_COL);
			end,
			[7] = 'drop',
			[8] = {
				handler = function(_, drop, val)
					SlashCmdList["ALACALENDAR"]("setfirst_col_day" .. val);
					drop:SetVal(floor(val % NUM_COL));
				end,
				elements = {
					{
						text = L.WEEKTITLE[1],
						para = { nil, 1, },
					},
					{
						text = L.WEEKTITLE[2],
						para = { nil, 2, },
					},
					{
						text = L.WEEKTITLE[3],
						para = { nil, 3, },
					},
					{
						text = L.WEEKTITLE[4],
						para = { nil, 4, },
					},
					{
						text = L.WEEKTITLE[5],
						para = { nil, 5, },
					},
					{
						text = L.WEEKTITLE[6],
						para = { nil, 6, },
					},
					{
						text = L.WEEKTITLE[0],
						para = { nil, 0, },
					},
				},
			},
		},
		{	--	instance_icon
			'bool',
			"^instance" .. SEPARATOR .. "icon" .. SEPARATOR .. "(.*)" .. SEPARATOR .. "$",
			"instance_icon",
			L.SLASH_NOTE["instance_icon"],
			function(key, val)
				NS.ui_update_calendar();
			end,
			[8] = function(self)
				if self:GetChecked() then
					SlashCmdList["ALACALENDAR"]("setinstance_icon1");
				else
					SlashCmdList["ALACALENDAR"]("setinstance_icon0");
				end
			end,
		},
		{	--	instance_text
			'bool',
			"^instance" .. SEPARATOR .. "text" .. SEPARATOR .. "(.*)" .. SEPARATOR .. "$",
			"instance_text",
			L.SLASH_NOTE["instance_text"],
			function(key, val)
				NS.ui_update_calendar();
			end,
			[8] = function(self)
				if self:GetChecked() then
					SlashCmdList["ALACALENDAR"]("setinstance_text1");
				else
					SlashCmdList["ALACALENDAR"]("setinstance_text0");
				end
			end,
		},
		{	--	dbicon
			'bool',
			"^show" .. SEPARATOR .. "db" .. SEPARATOR .. "icon" .. SEPARATOR .. "(.*)" .. SEPARATOR .. "$",
			"show_DBIcon",
			L.SLASH_NOTE["show_DBIcon"],
			function(key, val)
				if val then
					LibStub("LibDBIcon-1.0", true):Show("alaCalendar");
				else
					LibStub("LibDBIcon-1.0", true):Hide("alaCalendar");
				end
			end,
			[8] = function(self)
				if self:GetChecked() then
					SlashCmdList["ALACALENDAR"]("setshow_DBIcon1");
				else
					SlashCmdList["ALACALENDAR"]("setshow_DBIcon0");
				end
			end,
		},
		{	--	scale
			'num',
			"^scale" .. SEPARATOR .. "(.*)" .. SEPARATOR .. "$",
			"scale",
			L.SLASH_NOTE["scale"],
			function(key, val)
			end,
			function(val)
				val = max(min(10.0, val), 0.1);
				return floor(val * 100 + 0.5) * 0.01;
			end,
			[7] = 'slider',
			[8] = function(self, val, userInput)
				if userInput and val ~= SET.scale then
					SlashCmdList["ALACALENDAR"]("setscale" .. val);
				end
				self:SetStr(format("%.2f", val));
			end,
			[9] = { 0.1, 10.0, 0.1, },
		},
		{	--	alpha
			'num',
			"^alpha" .. SEPARATOR .. "(.*)" .. SEPARATOR .. "$",
			"alpha",
			L.SLASH_NOTE["alpha"],
			function(key, val)
			end,
			function(val)
				val = max(min(1.0, val), 0.0);
				return floor(val * 100 + 0.5) * 0.01;
			end,
			[7] = 'slider',
			[8] = function(self, val, userInput)
				if userInput and val ~= SET.alpha then
					SlashCmdList["ALACALENDAR"]("setalpha" .. val);
				end
				self:SetStr(format("%.2f", val));
			end,
			[9] = { 0.0, 1.0, 0.05, },
		},
		{	--	show_unlocked
			'bool',
			"^show" .. SEPARATOR .. "unlocked" .. SEPARATOR .. "(.*)" .. SEPARATOR .. "$",
			"show_unlocked",
			L.SLASH_NOTE["show_unlocked"],
			function(key, val)
				NS.ui_update_board();
			end,
			[8] = function(self)
				if self:GetChecked() then
					SlashCmdList["ALACALENDAR"]("setshow_unlocked1");
				else
					SlashCmdList["ALACALENDAR"]("setshow_unlocked0");
				end
			end,
		},
		{	--	hide_calendar_on_esc
			'bool',
			"^hide" .. SEPARATOR .. "calendar" .. SEPARATOR .. "on" .. SEPARATOR .. "esc" .. SEPARATOR .. "(.*)" .. SEPARATOR .. "$",
			"hide_calendar_on_esc",
			L.SLASH_NOTE["hide_calendar_on_esc"],
			function(key, val)
				if val then
					tinsert(UISpecialFrames, "ALA_CALENDAR");
				else
					for index = #UISpecialFrames, 1, -1 do
						if UISpecialFrames[index] == "ALA_CALENDAR" then
							tremove(UISpecialFrames, index);
						end
					end
				end
			end,
			[8] = function(self)
				if self:GetChecked() then
					SlashCmdList["ALACALENDAR"]("sethide_calendar_on_esc1");
				else
					SlashCmdList["ALACALENDAR"]("sethide_calendar_on_esc0");
				end
			end,
		},
		{	--	hide_board_on_esc
			'bool',
			"^hide" .. SEPARATOR .. "board" .. SEPARATOR .. "on" .. SEPARATOR .. "esc" .. SEPARATOR .. "(.*)" .. SEPARATOR .. "$",
			"hide_board_on_esc",
			L.SLASH_NOTE["hide_board_on_esc"],
			function(key, val)
				if val then
					tinsert(UISpecialFrames, "ALA_CALENDAR_BOARD");
				else
					for index = #UISpecialFrames, 1, -1 do
						if UISpecialFrames[index] == "ALA_CALENDAR_BOARD" then
							tremove(UISpecialFrames, index);
						end
					end
				end
			end,
			[8] = function(self)
				if self:GetChecked() then
					SlashCmdList["ALACALENDAR"]("sethide_board_on_esc1");
				else
					SlashCmdList["ALACALENDAR"]("sethide_board_on_esc0");
				end
			end,
		},
	};
	_G.SLASH_ALACALENDAR1 = "/alacalendar";
	_G.SLASH_ALACALENDAR2 = "/alacal";
	_G.SLASH_ALACALENDAR3 = "/acal";
	local SET_PATTERN = "^" .. SEPARATOR .. "set" .. SEPARATOR .. "(.+)" .. SEPARATOR .. "$";
	SlashCmdList["ALACALENDAR"] = function(msg)
		msg = strlower(msg);
		--	set
		local pattern = strmatch(msg, SET_PATTERN);
		if pattern then
			for _, cmd in next, NS.set_cmd_list do
				local pattern2 = strmatch(pattern, cmd[2]);
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
		--	default
		if strmatch(msg, "[A-Za-z0-9]+" ) then
			print("Invalid command: [[", msg, "]] Use: ");
			print("  /acal set region 1/2/3/4/5");
			print("  /acal set dst on/off");
			print("  /acal set userealmtimezone on/off");
			print("  /acal set firstcolday 0/1/2/3/4/5/6");
			print("  /acal set instanceicon on/off");
			print("  /acal set instancetext on/off");
			print("  /acal set showdbicon 0/1");
			print("  /acal set scale 0.1~10.0");
			print("  /acal set alpha 0.0~1.0");
			print("  /acal set showunlocked on/off");
			print("  /acal set hidecalendaronesc on/off");
			print("  /acal set hideboardonesc on/off");
		else
			NS.ui_toggleGUI("CONFIG");
		end
	end
end

do	--	EXTERN
end

do	--	DEV
	if false then
		local t = time();
		-- function NS.date_engine.time()
		-- 	return 1587918600 + time() - t;
		-- end
		function NS.date_engine.get_user_time_zone()
			return 1;
		end
		NS.date_engine.date = NS.date_engine.built_in_date;
	end
end


--	something else
	local buttons = {  };
	for i = 1, MAX_RAID_INFOS do
		local b = _G["RaidInfoInstance" .. i];
		buttons[i] = b;
		b:EnableMouse(true);
		b.__ID = i;
		b.__HL = b:CreateTexture(nil, "OVERLAY");
		b.__HL:SetAllPoints();
		b.__HL:SetColorTexture(1.0, 0.75, 0.5, 0.25);
		b.__HL:SetBlendMode("ADD");
		b.__HL:Hide();
		b:SetScript("OnEnter", function(self)
			self.__HL:Show();
			if self.__ID <= GetNumSavedInstances() then
				local name, id, reset, difficulty, locked, extended, instanceIDMostSig, isRaid, maxPlayers, difficultyName, numEncounters, encounterProgress = GetSavedInstanceInfo(self.__ID);
				if name ~= nil then
					GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
					GameTooltip:AddDoubleLine(name, id, 1.0, 1.0, 1.0, 0.35, 0.35, 0.35);
					if locked then
						GameTooltip:AddLine(RESETS_IN .. " " .. SecondsToTime(reset), 0.5, 0.5, 0.5);
						GameTooltip:AddLine(" ");
						-- var[1] = id;
						-- var[2] = t;
						-- var[3] = numEncounters;
						-- var[4] = encounterProgress;
						for encounterIndex = 1, numEncounters do
							local bossName, fileDataID, isKilled, unknown4 = GetSavedInstanceEncounterInfo(self.__ID, encounterIndex);
							-- var[4 + encounterIndex * 2 - 1] = bossName;
							-- var[4 + encounterIndex * 2] = isKilled;
							if isKilled then
								GameTooltip:AddDoubleLine(bossName, BOSS_DEAD, 0.875, 0.875, 0.875, 1.0, 0.0, 0.0);
							else
								GameTooltip:AddDoubleLine(bossName, BOSS_ALIVE, 0.875, 0.875, 0.875, 0.0, 1.0, 0.0);
							end
						end
					end
					GameTooltip:Show();
				end
			end
		end);
		b:SetScript("OnLeave", function(self)
			self.__HL:Hide();
			GameTooltip:Hide();
		end);
	end
--
