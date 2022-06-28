--[[--
	by ALA @ 163UI
	Please Keep WOW Addon open-source & Reduce barriers for others.
	复用代码请在显著位置标注来源【ALA@网易有爱】
	请勿加密、乱码、删除空格tab换行符、设置加载依赖
	BaudAuction.lua		by Baudzilla
--]]--
----------------------------------------------------------------------------------------------------
local ADDON, NS = ...;
_G.__ala_meta__ = _G.__ala_meta__ or {  };
__ala_meta__.merc = NS;

local _G = _G;
do
	if NS.__fenv == nil then
		NS.__fenv = setmetatable({  },
				{
					__index = _G,
					__newindex = function(t, key, value)
						rawset(t, key, value);
						print("atd assign global", key, value);
						return value;
					end,
				}
			);
	end
	setfenv(1, NS.__fenv);
end

local L = NS.L;
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
	local select = select;
	local date, time = date, time;
	local C_Timer = C_Timer;
	----------------------------------------------------------------------------------------------------GAME
	local print = print;
	local GetServerTime = GetServerTime;
	local CreateFrame = CreateFrame;
	local GetCursorPosition = GetCursorPosition;
	local IsAltKeyDown = IsAltKeyDown;
	local IsControlKeyDown = IsControlKeyDown;
	local IsShiftKeyDown = IsShiftKeyDown;
	--------------------------------------------------
	local RegisterAddonMessagePrefix = RegisterAddonMessagePrefix or C_ChatInfo.RegisterAddonMessagePrefix;
	local IsAddonMessagePrefixRegistered = IsAddonMessagePrefixRegistered or C_ChatInfo.IsAddonMessagePrefixRegistered;
	local GetRegisteredAddonMessagePrefixes = GetRegisteredAddonMessagePrefixes or C_ChatInfo.GetRegisteredAddonMessagePrefixes;
	local SendAddonMessage = SendAddonMessage or C_ChatInfo.SendAddonMessage;
	local SendAddonMessageLogged = SendAddonMessageLogged or C_ChatInfo.SendAddonMessageLogged;
	--------------------------------------------------
	local _ = nil;
	local UNK_TEXTURE = "Interface\\Icons\\inv_misc_questionmark";
	local function _log_(...)
		-- print(date('\124cff00ff00%H:%M:%S\124r'), ...);
	end
	local function _error_(...)
		print(date('\124cffff0000%H:%M:%S\124r'), ...);
	end
	local function _noop_()
	end
	--------------------------------------------------
	local ADDON_PREFIX = "ALATRADE";
	local ADDON_MSG_CONTROL_CODE_LEN = 6;
	local ADDON_MSG_QUERY = "_q_pr_";
	local ADDON_MSG_REPLY = "_r_pr_";
	--in second
	local PRICE_USEFUL_CYCLE = 3600;
	local PRICE_CREDIBLE_CYCLE = 1200;
	local MINIMUM_CACHE_INTERVAL = 600;
	local MIN_ID_QUERY_INTERVAL = 60;
	local MAX_FORWARDING_TIMEOUT = 4;
	local MIN_ID_FORWARDING_INTERVAL = 30;
	local MIN_MSG_FORWARDING_INTERVAL = 60;
	--
	local BATCH_PER_PAGE = 50;
	local BIG_NUMBER = 4294967295;
	local SCAN_NORMAL_INTERVAL = 4;
	local SCAN_FULL_INTERVAL = 900;
	local MAX_WAIT_TIME = 30;
	--
	local ui_style = {
		frame_width = 360,
		frame_width_narrow = 240;
		button_height = 16,

		frameBackdrop = {
			bgFile = "Interface\\ChatFrame\\ChatFrameBackground",	-- "Interface\\Buttons\\WHITE8X8",	-- "Interface\\Tooltips\\UI-Tooltip-Background", -- "Interface\\ChatFrame\\ChatFrameBackground"
			edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
			tile = true,
			tileSize = 2,
			edgeSize = 2,
			insets = { left = 0, right = 0, top = 0, bottom = 0, }
		},
		frameBackdropColor = { 0.05, 0.05, 0.05, 1.0, },
		frameBackdropBorderColor = { 0.0, 0.0, 0.0, 1.0, },
		buttonBackdrop = {
			bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
			edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
			tile = true,
			tileSize = 2,
			edgeSize = 2,
			insets = { left = 0, right = 0, top = 0, bottom = 0 }
		};
		buttonBackdropColor = { 0.25, 0.25, 0.25, 0.75 };
		buttonBackdropBorderColor = { 0.0, 0.0, 0.0, 1.0 };

		frameFont = SystemFont_Shadow_Med1:GetFont(),--=="Fonts\ARKai_T.ttf"
		frameFontSize = min(select(2, SystemFont_Shadow_Med1:GetFont()) + 1, 15),
		frameFontOutline = "NORMAL",
		smallFontSize = max(select(2, SystemFont_Shadow_Med1:GetFont()) - 3, 12),
	};
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
local SET = nil;
local FAV = nil;
local cache = nil;
local cache2 = nil;	-- [name] = id
local cache3 = nil;	-- { id, }
local gui = {  };
NS.gui = gui;

local PLAYER_GUID = UnitGUID('player');
local PLAYER_NAME = UnitName('player');
local PLAYER_REALM_NAME = GetRealmName();

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
			local num = #handlers_name;
			for index = 1, num do
				if func == handlers_name[index] then
					return;
				end
			end
			handlers_name[num + 1] = func;
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
			local num = #handlers_link;
			for index = 1, num do
				if func == handlers_link[index] then
					return;
				end
			end
			handlers_link[num + 1] = func;
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
	local goldicon    = "\124TInterface\\MoneyFrame\\UI-GoldIcon:12:12:0:0\124t"
	local silvericon  = "\124TInterface\\MoneyFrame\\UI-SilverIcon:12:12:0:0\124t"
	local coppericon  = "\124TInterface\\MoneyFrame\\UI-CopperIcon:12:12:0:0\124t"
	function NS.MoneyString_Dec(copper)
		-- GetCoinTextureString
		local g = floor(copper / 10000);
		copper = copper % 10000;
		local s = floor(copper / 100);
		copper = copper % 100;
		local c = floor(copper);
		local r = (copper - c) * 100;
		if g > 0 then
			if r >= 5 then
				return format("%d%s %02d%s %02d%s \124cff7f7f7f%02d\124r", g, goldicon, s, silvericon, c, coppericon, r);
			else
				return format("%d%s %02d%s %02d%s \124cff7f7f7f00\124r", g, goldicon, s, silvericon, c, coppericon);
			end
		elseif s > 0 then
			if r >= 5 then
				return format("%d%s %02d%s \124cff7f7f7f%02d\124r", s, silvericon, c, coppericon, r);
			else
				return format("%d%s %02d%s \124cff7f7f7f00\124r", s, silvericon, c, coppericon);
			end
		else
			if r >= 5 then
				return format("%d%s \124cff7f7f7f%02d\124r", c, coppericon, r);
			else
				return format("%d%s \124cff7f7f7f00\124r", c, coppericon);
			end
		end
	end
	function NS.MoneyString_Dec_Char(copper)
		-- GetCoinTextureString
		local g = floor(copper / 10000);
		copper = copper % 10000;
		local s = floor(copper / 100);
		copper = copper % 100;
		local c = floor(copper);
		local r = (copper - c) * 100;
		if g > 0 then
			return format(L["MoneyString_Dec_Char_Format"][1], g, s, c, r);
		elseif s > 0 then
			return format(L["MoneyString_Dec_Char_Format"][2], s, c, r);
		else
			return format(L["MoneyString_Dec_Char_Format"][3], c, r);
		end
	end
	function NS.MoneyString(copper)
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
	function NS.MoneyString_Short(copper)
		-- GetCoinTextureString
		local g = floor(copper / 10000);
		copper = copper % 10000;
		local s = floor(copper / 100);
		copper = copper % 100;
		local c = floor(copper);
		if g >= 10000 then
			return format("%d%s", g, goldicon);
		elseif g >= 100 then
			return format("%d%s%02d%s", g, goldicon, s, silvericon);
		elseif g > 0 then
			return format("%d%s%02d%s%02d%s", g, goldicon, s, silvericon, c, coppericon);
		elseif s > 0 then
			return format("%d%s%02d%s", s, silvericon, c, coppericon);
		else
			return format("%d%s", c, coppericon);
		end
	end
	function NS.seconds_to_colored_formatted_time_len(sec)
		local p = max(0.0, 1.0 - sec / SET.data_valid_time);
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
	local _callback_after_cache = {  };
	local _num_callback_after_cache = 0;
	local time_zone_ofs = 0;
	do
		local l = date("*t");
		local u = date("!*t");
		if l.year == u.year then
			if l.month == u.month then
				if l.day == u.day then
					time_zone_ofs = l.hour - u.hour;
				else
					time_zone_ofs = (l.day - u.day) * 24 + l.hour - u.hour;
				end
			else
				time_zone_ofs = (l.month - u.month) * 24 + l.hour - u.hour;
			end
		else
			time_zone_ofs = (l.year - u.year) * 24 + l.hour - u.hour;
		end
	end

	----	index
		local index_name = 1;
		local index_link = 2;
		local index_quality = 3;
		local index_texture = 4;
		local index_level = 5;
		local index_vendorPrice = 6;
		local index_buyoutPriceSingle = 7;
		local index_count = 8;
		local index_cacheTime = 9;
		local index_temp = 10;
		local index_history = 11;
		--	temp_table
		local index_buyoutPrice = 6;
		local index_bidPrice = 9;
		local index_bidPriceSingle = 10;
		local index_timeLeft = 11;
		local index_owner = 12;
		local index_bidState = 13;
		local index_page = 14;
		local index_index = 15;
		local index_id = 16;
	----

	do	--	communication func
		local query_queue = {  };
		local forward_table = {  };
		local forward_id_history = {  };
		local forward_msg_history = {  };
		local ticker_running = nil;
		local function ticker_clean()
			local continue = false;
			local t0 = GetServerTime() - MIN_ID_FORWARDING_INTERVAL;
			for id, t in next, forward_id_history do
				if t < t0 then
					forward_id_history[id] = nil;
				else
					continue = true;
				end
			end
			t0 = GetServerTime() - MIN_MSG_FORWARDING_INTERVAL;
			for msg, t in next, forward_msg_history do
				if t < t0 then
					forward_msg_history[msg] = nil;
				else
					continue = true;
				end
			end
			if continue then
				ticker_running = true;
				C_Timer.After(MIN_ID_FORWARDING_INTERVAL * 0.5, ticker_clean);
			else
				ticker_running = false;
			end
		end
		local function should_forward(id, t)
			if forward_id_history[id] and t - forward_id_history[id] < MIN_ID_FORWARDING_INTERVAL then
				return false
			else
				forward_id_history[id] = t;
				if not ticker_running then
					ticker_running = true;
					C_Timer.After(MIN_ID_FORWARDING_INTERVAL * 0.5, ticker_clean);
				end
				return true;
			end
		end
		----------------
		function NS.InitAddonMessage()
			if RegisterAddonMessagePrefix(ADDON_PREFIX) then
				_EventHandler:RegisterEvent("CHAT_MSG_ADDON");
				_EventHandler:RegisterEvent("CHAT_MSG_ADDON_LOGGED");
				C_Timer.NewTicker(0.02, function()
					if SET.query_online then
						local work = tremove(query_queue);
						if work then
							NS.QueryPrice(work[1], work[2]);
						end
					end
				end);
			else
				_log_("Init", "RegisterAddonMessagePrefix", ADDON_PREFIX);
			end
		end
		function NS.CHAT_MSG_ADDON(prefix, msg, channel, sender, target, zoneChannelID, localID, name, instanceID)
			if prefix == ADDON_PREFIX then
				local t = GetServerTime();
				if forward_msg_history[msg] then
					return;
				end
				forward_msg_history[msg] = t;
				local control_code = strsub(msg, 1, ADDON_MSG_CONTROL_CODE_LEN);
				local n, r = strsplit("-", sender);
				if n and n ~= PLAYER_NAME and (r == nil or r == "" or r == PLAYER_REALM_NAME) then
					sender = n;
					if control_code == ADDON_MSG_QUERY then
						local text = strsub(msg, ADDON_MSG_CONTROL_CODE_LEN + 1, - 1);
						local _, _, id, old_cache_time, dead_time, orig_sender = strfind(text, "^#ID(%d+)#CT(%d+)#DT(%d+)#SR(.+)#");
						if orig_sender == PLAYER_NAME then
							return;
						end
						id = tonumber(id);
						if id then
							dead_time = tonumber(dead_time);
							if dead_time > t then
								old_cache_time = tonumber(old_cache_time);
								local price, count, cache_time, credible = NS.query_ah_useful_db_by_id(id);
								if price and cache_time > old_cache_time then
									SendAddonMessage(ADDON_PREFIX, ADDON_MSG_REPLY .. "#ID" .. id .. "#PR" .. price .. "#CN" .. count .. "#CT" .. cache_time, "WHISPER", orig_sender);
									_log_("SENT", orig_sender, id, price, cache_time);
								end
								if not credible then
									if should_forward(id, t) then
										NS.Forward(msg, channel == "GUILD");
									end
								end
							end
						end
					elseif control_code == ADDON_MSG_REPLY then
						local text = strsub(msg, ADDON_MSG_CONTROL_CODE_LEN + 1, - 1);
						local _, _, id, price, count, cache_time = strfind(text, "^#ID(%d+)#PR([0-9%.]+)#CN(%d+)#CT(%d+)");
						id = tonumber(id);
						if id then
							price = tonumber(price);
							count = tonumber(count);
							cache_time = tonumber(cache_time);
							if price and count and cache_time then
								_log_("RECV", sender, id, price, count, cache_time);
								NS.insert_from_foreign(id, price, count, cache_time);
							end
						end
					end
				end
			end
		end
		NS.CHAT_MSG_ADDON_LOGGED = NS.CHAT_MSG_ADDON;
		local queried_id_history = {  };
		function NS.Forward(msg, toGroup)
			if not toGroup and IsInGuild() then
				_log_("FORW", msg, "GUILD");
				SendAddonMessage(ADDON_PREFIX, msg, "GUILD");
			end
			if toGroup and IsInGroup(LE_PARTY_CATEGORY_HOME) then
				if IsInRaid() then
					_log_("FORW", msg, "RAID");
					SendAddonMessage(ADDON_PREFIX, msg, "RAID");
				else
					_log_("FORW", msg, "PARTY");
					SendAddonMessage(ADDON_PREFIX, msg, "PARTY");
				end
				if IsInGroup(LE_PARTY_CATEGORY_INSTANCE) then
					SendAddonMessage(ADDON_PREFIX, msg, "INSTANCE_CHAT");
				end
			end
		end
		local function gen_msg(id, cache_time, t)
			return ADDON_MSG_QUERY .. "#ID" .. id .. "#CT" .. cache_time .. "#DT" .. (t + MAX_FORWARDING_TIMEOUT) .. "#SR" .. PLAYER_NAME .. "#";
		end
		function NS.QueryPrice(id, cache_time)
			local t = GetServerTime();
			if IsInGuild() then
				_log_("SENT", id, "GUILD");
				SendAddonMessage(ADDON_PREFIX, gen_msg(id, cache_time, t), "GUILD");
			end
			if IsInGroup(LE_PARTY_CATEGORY_HOME) then
				if IsInRaid() then
					_log_("SENT", id, "RAID");
					SendAddonMessage(ADDON_PREFIX, gen_msg(id, cache_time, t), "RAID");
				else
					_log_("SENT", id, "PARTY");
					SendAddonMessage(ADDON_PREFIX, gen_msg(id, cache_time, t), "PARTY");
				end
			end
			if IsInGroup(LE_PARTY_CATEGORY_INSTANCE) then
				SendAddonMessage(ADDON_PREFIX, gen_msg(id, cache_time, t), "INSTANCE_CHAT");
			end
		end
		function NS.NotifyQueryPrice(id, cache_time)
			if SET.query_online then
				local t = GetServerTime();
				if cache_time == nil or (t - cache_time > PRICE_CREDIBLE_CYCLE) then
					if queried_id_history[id] and t - queried_id_history[id] < MIN_ID_QUERY_INTERVAL then
						return;
					else
						queried_id_history[id] = t;
					end
					if id then
						query_queue[#query_queue + 1] = { id, cache_time or -1 };
					end
				end
			end
		end
		function NS.FlushQueryQueue()
			wipe(query_queue);
		end
	end

	do	--	query auction
		--
		local _is_full_scan = false;
		local _last_query_string = "";
		local _last_query_page = nil;
		local _last_query_queryString_page0 = nil;
		local _do_cache_next = false;
		local _processing_cache = false;
		--
		local _do_cache_temp_table = false;
		local _cache_temp_table = {  };
		--
		function NS.cleanup_cache_temp()
			for id, c in next, cache do
				local temp = c[index_temp];
				if temp then
					wipe(temp);
				end
			end
		end
		do	-- hook API
			local _processing_scan = false;
			do	-- reset in MAX_WAIT_TIME after querying
				local update_frame = CreateFrame("FRAME");
				local update_frame_timer = 0.0;
				local function update_frame_ticker(_, elasped)
					update_frame_timer = update_frame_timer + elasped;
					if update_frame_timer > MAX_WAIT_TIME then
						update_frame:SetScript("OnUpdate", nil);
						if _processing_scan then
							_processing_scan = false;
							-- do something
						end
						update_frame_timer = 0.0;
					end
				end
				function NS.record_scan_start()
					_processing_scan = true;
					update_frame_timer = 0;
					update_frame:SetScript("OnUpdate", update_frame_ticker);
				end
				function NS.record_scan_done()
					_processing_scan = false;
					update_frame:SetScript("OnUpdate", nil);
				end
			end
			do	-- record queried pages
				local Q = {  };
				function NS.cleanup_queried_pages()
					wipe(Q);
				end
				function NS.record_last_page()
					Q[_last_query_page + 1] = GetServerTime();
				end
				function NS.validated_records()
					local e = BIG_NUMBER;
					local l = -1;
					for index = 1, #Q do
						local t = Q[index];
						e = min(e, t);
						l = max(l, t);
					end
					if l - e > MAX_WAIT_TIME * #Q then
						return -1;
					end
					return #Q;
				end
				function NS.num_valid_records()
				end
			end
			local ____CanSendAuctionQuery = CanSendAuctionQuery;
			local ____QueryAuctionItems = QueryAuctionItems;
			local function hook_scan_full()
				NS.record_scan_start();
				_is_full_scan = true;
				_last_query_page = nil;
				NS.cleanup_cache_temp();
				_log_("wipe hook");
				_do_cache_next = true;
				_log_("hook_scan_full", queryString, current_page, scan_full, exactMatch);
			end
			local function hook_scan_normal(queryString, current_page)
				NS.record_scan_start();
				_is_full_scan = false;
				_last_query_page = current_page;
				if current_page == 0 or _last_query_queryString_page0 ~= queryString then
					_last_query_queryString_page0 = queryString;
					NS.cleanup_cache_temp();
					_log_("wipe hook");
				end
				_do_cache_next = true;
				-- if current_page == 0 then
				-- 	NS.cleanup_cache_temp();
				-- 	_log_("wipe hook");
				-- 	_do_cache_next = true;
				-- else
				-- 	if _last_query_queryString_page0 ~= queryString then
				-- 		_do_cache_next = false;
				-- 	end
				-- end
				_log_("hook_scan_normal", queryString, current_page, scan_full, exactMatch);
			end
			-- hooksecurefunc("QueryAuctionItems", hooked);
			function _G.CanSendAuctionQuery()
				if _processing_scan or _processing_cache then
					return false, false;
				end
				return ____CanSendAuctionQuery();
			end
			function _G.QueryAuctionItems(queryString, minLevel, maxLevel, current_page, can_use, quality, scan_full, exactMatch, filter)
				if scan_full then
					if not select(2, CanSendAuctionQuery()) then
						return;
					end
					hook_scan_full();
				else
					if not CanSendAuctionQuery() then
						return;
					end
					current_page = current_page or 0;
					hook_scan_normal(queryString, current_page);
				end
				_last_query_string = queryString;
				if type(_last_query_string) ~= 'string' then
					_last_query_string = "";
				end
				-- hooked(queryString, minLevel, maxLevel, current_page, can_use, quality, scan_full, exactMatch, filter);
				return ____QueryAuctionItems(queryString, minLevel, maxLevel, current_page, can_use, quality, scan_full, exactMatch, filter);
			end
			function NS.abandon()
				NS.halt_scan_normal();
				NS.cleanup_queried_pages();
				NS.record_scan_done();
				_do_cache_next = false;
				_processing_cache = false;
				NS.halt_cache();
				NS.wipe_cache_temp();
			end
			function NS.last_query_page()
				return _last_query_page;
			end
			do
				-- local _last_selected_page = nil;
				-- hooksecurefunc("SetSelectedAuctionItem", function(T, index)
				-- 	if not conflicted_addons_list["BaudAuction"] and BaudAuctionFrame then
				-- 		return;
				-- 	end
				-- 	if T == 'list' and index > 0 then
				-- 		_last_selected_page = _last_query_page;
				-- 		_log_("SetSelectedAuctionItem", T, index)
				-- 	end
				-- end);
				-- hooksecurefunc("PlaceAuctionBid", function(T, index, bid)
				-- 	if not conflicted_addons_list["BaudAuction"] and BaudAuctionFrame then
				-- 		return;
				-- 	end
				-- 	_log_("PlaceAuctionBid", T, index, bid);
				-- 	tremove(_cache_temp_table, _last_query_page * BATCH_PER_PAGE + index);
				-- 	_last_query_page = _last_selected_page - 1;
				-- 	_do_cache_next = false;
				-- 	_last_selected_page = nil;
				-- 	NS.scan_normal_once();
				-- end);
			end
		end
		local __QueryAuctionItems = QueryAuctionItems;
		local __CanSendAuctionQuery = CanSendAuctionQuery;
		do	-- cache
			local _cache_time = nil;
			local update_frame = CreateFrame("FRAME");
			local _head = nil;
			local _tail = nil;
			local _count = nil;
			function NS.insert_from_foreign(id, price, count, cache_time)
				local c = cache[id];
				if c then
					if c[index_cacheTime] == nil or abs(c[index_cacheTime] - cache_time) > MINIMUM_CACHE_INTERVAL then
						if SET.cache_history and c[index_cacheTime] then
							c[index_history] = c[index_history] or {  };
							local h = c[index_history];
							local n = #h;
							if (n > 0 and h[n][1]) or c[index_buyoutPriceSingle] then
								h[n + 1] = { c[index_buyoutPriceSingle], c[index_count], c[index_cacheTime], };
							end
						end
					end
				else
					c = {  };
					cache[id] = c;
					NS.notify_cache_item_info(id);
				end
				c[index_buyoutPriceSingle] = price;
				c[index_count] = count;
				c[index_cacheTime] = cache_time;
			end
			function NS.apply_cache_temp()
				local pattern = gsub(_last_query_string, "[%^%$%%%.%+%-%*%?%[%]%(%)]","%%%1");
				for id, c in next, cache do
					local temp = c[index_temp];
					if temp[3] then
						if SET.cache_history and c[index_cacheTime] and abs(c[index_cacheTime] - _cache_time) > MINIMUM_CACHE_INTERVAL then
							c[index_history] = c[index_history] or {  };
							local h = c[index_history];
							local n = #h;
							if (n > 0 and h[n][1]) or c[index_buyoutPriceSingle] then
								h[n + 1] = { c[index_buyoutPriceSingle], c[index_count], c[index_cacheTime], };
							end
						end
						c[index_buyoutPriceSingle] = temp[1];
						c[index_count] = temp[2];
						c[index_cacheTime] = temp[3];
						wipe(temp);
					elseif _is_full_scan or c[index_name] and strfind(c[index_name], pattern) then
						if SET.cache_history and c[index_cacheTime] then
							c[index_history] = c[index_history] or {  };
							local h = c[index_history];
							local n = #h;
							if (n > 0 and h[n][1]) or c[index_buyoutPriceSingle] then
								h[n + 1] = { c[index_buyoutPriceSingle], c[index_count], c[index_cacheTime], };
							end
						end
						c[index_buyoutPriceSingle] = nil;
						c[index_count] = 0;
						c[index_cacheTime] = _cache_time;
					end
				end
				NS.proc_cache();
				_log_("apply_cache_temp");
			end
			function NS.wipe_cache_temp()
				for id, c in next, cache do
					wipe(c[index_temp]);
				end
				_log_("wipe_cache_temp");
			end
			local function ticker_cache_auction_item(head, tail)
				if _processing_cache then
					local p0 = debugprofilestop();
					for i = head, tail do
						local name, texture, count, quality, canUse, level, huh, minBid, minIncrement, buyoutPrice,
							bidAmount, highBidder, bidderFullName, owner, ownerFullName, saleStatus, id, hasAllInfo = GetAuctionItemInfo("list", i);
						if id > 0 then
							local buyoutPriceSingle = nil;
							if buyoutPrice and buyoutPrice > 0 then
								local c = cache[id];
								buyoutPriceSingle = buyoutPrice / count;
								if c then
									local temp = c[index_temp];
									if not temp then
										temp = {  };
										c[index_temp] = temp;
									end
									if c[index_name] == nil or c[index_name] == "" then
										c[index_name] = name;
									end
									c[index_quality] = c[index_quality] or quality;
									if c[index_texture] == nil or c[index_texture] == 0 or c[index_texture] == "" then
										c[index_texture] = texture;
									end
									if c[index_level] == nil or c[index_level] < 0 then
										c[index_level] = level;
									end
									if c[index_vendorPrice] == nil then
										NS.notify_cache_item_info(id);
									end;
									-- c[index_vendorPrice] = c[index_vendorPrice] or select(11, GetItemInfo(id));
									if temp[1] then
										if temp[1] > buyoutPriceSingle then
											temp[1] = buyoutPriceSingle;
											temp[2] = temp[2] + count;
											temp[3] = _cache_time;
										else
											temp[2] = temp[2] + count;
										end
									else
										temp[1] = buyoutPriceSingle;
										temp[2] = (temp[2] or 0) + count;
										temp[3] = _cache_time;
									end
								else
									local c = {  };
									c[index_name] = name;
									c[index_quality] = quality;
									c[index_texture] = texture;
									c[index_level] = level;
									NS.notify_cache_item_info(id);
									-- c[index_vendorPrice] = select(11, GetItemInfo(id));
									c[index_temp] = { buyoutPriceSingle, count, _cache_time, };
									cache[id] = c;
									cache3[#cache3 + 1] = id;
								end
							else
								buyoutPrice = nil;
								local c = cache[id];
								if c then
									local temp = c[index_temp];
									if not temp then
										temp = {  };
										c[index_temp] = temp;
									end
									if c[index_name] == nil or c[index_name] == "" then
										c[index_name] = name;
									end
									c[index_quality] = c[index_quality] or quality;
									if c[index_texture] == nil or c[index_texture] == 0 or c[index_texture] == "" then
										c[index_texture] = texture;
									end
									if c[index_level] == nil or c[index_level] < 0 then
										c[index_level] = level;
									end
									if c[index_vendorPrice] == nil then
										NS.notify_cache_item_info(id);
									end;
									-- c[index_vendorPrice] = c[index_vendorPrice] or select(11, GetItemInfo(id));
									temp[2] = (temp[2] or 0) + count;
								else
									local c = {  };
									c[index_name] = name;
									c[index_quality] = quality;
									c[index_texture] = texture;
									c[index_level] = level;
									NS.notify_cache_item_info(id);
									-- c[index_vendorPrice] = select(11, GetItemInfo(id));
									c[index_temp] = { nil, count, nil, };
									cache[id] = c;
									cache3[#cache3 + 1] = id;
								end
							end
							if name and name ~= "" then
								cache2[name] = id;
							end
							local singleBid = bidAmount and bidAmount > 0 and (bidAmount / count) or (minBid / count);
							if _do_cache_temp_table then
								local link = GetAuctionItemLink("list", i);
								if type(link) ~= 'string' or link == "" then
									link = nil;
								end
								local ele = {  };
								ele[index_name] = name;
								ele[index_link] = link;
								ele[index_quality] = quality;
								ele[index_texture] = texture;
								ele[index_level] = level;
								ele[index_buyoutPrice] = buyoutPrice;
								ele[index_buyoutPriceSingle] = buyoutPriceSingle;
								ele[index_count] = count;
								ele[index_bidPrice] = bidAmount;
								ele[index_bidPriceSingle] = singleBid;
								ele[index_timeLeft] = GetAuctionItemTimeLeft("list", i);
								ele[index_owner] = owner;
								ele[index_bidState] = bidAmount and (highBidder and 1 or -1) or 0;
								ele[index_page] = _last_query_page;
								ele[index_index] = i;
								ele[index_id] = id;
								buyoutPrice = buyoutPrice or BIG_NUMBER;
								buyoutPriceSingle = buyoutPriceSingle or BIG_NUMBER;
								-- _cache_temp_table[i + _last_query_page * BATCH_PER_PAGE] = ele;
								_cache_temp_table[#_cache_temp_table + 1] = ele;
							end
						end
						if SET.avoid_stuck and (i % 50 == 0) and (debugprofilestop() - p0 > SET.avoid_stuck_cost / 10) then
							return i;
						end
					end
					return tail;
				end
				return -1;
			end
			local function update_func()
				_head = ticker_cache_auction_item(_head + 1, _tail);
				_log_("cache_update_func", _head, _tail);
				if _head == -1 then
					_processing_cache = false;
					update_frame:SetScript("OnUpdate", nil);
				else
					if _is_full_scan then
						NS.notify_scan_full_progress(_head, _tail);
						if _head >= _tail then
							_processing_cache = false;
							update_frame:SetScript("OnUpdate", nil);
							NS.apply_cache_temp();
							NS.notify_scan_full_done();
						end
					else
						local nPage = ceil(_count / BATCH_PER_PAGE);
						NS.notify_scan_normal_progress(nPage);
						if _head >= _tail then
							_processing_cache = false;
							update_frame:SetScript("OnUpdate", nil);
							if NS.validated_records() >= nPage then
								NS.apply_cache_temp();
								NS.notify_scan_normal_all_done();
							else
								NS.notify_scan_normal_page_done();
							end
						end
					end
				end
			end
			function NS.do_cache_auction_item(batch, count)
				_cache_time = GetServerTime();
				_head = 0;
				_tail = batch;
				_count = count;
				_processing_cache = true;
				update_frame:SetScript("OnUpdate", update_func);
			end
			function NS.AUCTION_ITEM_LIST_UPDATE()
				NS.clearAuctionBrowseSelect();
				NS.record_scan_done();
				if _do_cache_next then
					_do_cache_next = false;
					local batch, count = GetNumAuctionItems("list");
					if _is_full_scan then
						if batch > BATCH_PER_PAGE or batch == count then
							_log_("AUCTION_ITEM_LIST_UPDATE", batch, count);
							NS.do_cache_auction_item(batch, count);
						end
					else
						NS.record_last_page();
						_log_("AUCTION_ITEM_LIST_UPDATE", batch, count);
						NS.do_cache_auction_item(batch, count);
					end
				end
			end
			function NS.halt_cache()
				update_frame:SetScript("OnUpdate", nil);
			end
		end
		do	-- send scan_full
			function NS.notify_scan_full_done()
				for index = 1, _num_callback_after_cache do
					_callback_after_cache[index]();
				end
				if NS.BaudAuctionFrame then
					NS.BaudAuctionFrame:_RegisterEvent("AUCTION_ITEM_LIST_UPDATE");
				elseif BaudAuctionFrame then
					BaudAuctionFrame:RegisterEvent("AUCTION_ITEM_LIST_UPDATE");
				end
				PlaySound(SOUNDKIT.AUCTION_WINDOW_CLOSE);
			end
			function NS.notify_scan_full_progress(cur, tail)
				NS.ShowProgress(cur, tail);
			end
			function NS.scan_full()
				if select(2, __CanSendAuctionQuery()) then
					if BaudAuctionFrame then
						BaudAuctionFrame:UnregisterEvent("AUCTION_ITEM_LIST_UPDATE");
					elseif NS.BaudAuctionFrame then
						NS.BaudAuctionFrame:UnregisterEvent("AUCTION_ITEM_LIST_UPDATE");
					end
					NS.abandon();
					_do_cache_temp_table = false;
					SortAuctionClearSort("list");
					__QueryAuctionItems("", nil, nil, 0, 0, 0, true);
					NS.HideProgress();
					return true;
				end
				return false;
			end
		end
		do	-- send scan_normal
			local update_frame = CreateFrame("FRAME");
			local _processing_normal_scan = false;
			local _para = {  };
			local _call_back = nil;
			local function update_func()
				if _processing_normal_scan and __CanSendAuctionQuery() then
					if _last_query_page then
						_para[4] = _last_query_page + 1;
						__QueryAuctionItems(_para[1], _para[2], _para[3], _para[4], _para[5], _para[6], _para[7], _para[8], _para[9]);
						update_frame:SetScript("OnUpdate", nil);
					end
					__QueryAuctionItems(_para[1], _para[2], _para[3], _para[4], _para[5], _para[6], _para[7], _para[8], _para[9]);
					update_frame:SetScript("OnUpdate", nil);
				end
			end
			local function update_func_once()
				if _last_query_page then
					if __CanSendAuctionQuery() then
						__QueryAuctionItems(_para[1], _para[2], _para[3], _last_query_page, _para[5], _para[6], _para[7], _para[8], _para[9]);
						update_frame:SetScript("OnUpdate", nil);
					end
				else
					update_frame:SetScript("OnUpdate", nil);
				end
			end
			function NS.notify_scan_normal_all_done()
				_log_("notify_scan_normal_all_done", _do_cache_temp_table);
				_processing_normal_scan = false;
				if _call_back then
					_call_back(_para[1], _cache_temp_table, true);
					_call_back = nil;
				end
				for index = 1, _num_callback_after_cache do
					_callback_after_cache[index]();
				end
				PlaySound(SOUNDKIT.AUCTION_WINDOW_CLOSE);
			end
			function NS.notify_scan_normal_page_done()
				if _call_back then
					_call_back(_para[1], _cache_temp_table, false);
				end
				if _processing_normal_scan then
					update_frame:SetScript("OnUpdate", update_func);
				end
			end
			function NS.notify_scan_normal_progress(nPage)
				if _processing_normal_scan then
					NS.ShowProgress(_para[4] + 1, nPage);
				end
			end
			local function do_scan_normal()
			end
			function NS.scan_normal_once()
				if _processing_normal_scan then
					update_frame:SetScript("OnUpdate", update_func);
				else
					update_frame:SetScript("OnUpdate", update_func_once);
				end
			end
			function NS.scan_normal_detail(name, minLevel, maxLevel, can_use, quality, scan_full, exact, filter, cache_temp, call_back)
				NS.abandon();
				_processing_normal_scan = true;
				_para[1] = name;
				_para[2] = minLevel;
				_para[3] = maxLevel;
				_para[4] = 0;
				_para[5] = can_use;
				_para[6] = quality;
				_para[7] = scan_full;
				_para[8] = exact;
				_para[9] = filter;
				_call_back = call_back;
				if cache_temp then
					_do_cache_temp_table = true;
					wipe(_cache_temp_table);
				end
				_last_query_page = nil;
				if __CanSendAuctionQuery() then
					__QueryAuctionItems(name, minLevel, maxLevel, 0, can_use, quality, scan_full, exact, filter);
					-- _para[4] = 1;
					update_frame:SetScript("OnUpdate", nil);
					_log_("scan_normal");
				else
					-- _para[4] = 0;
					update_frame:SetScript("OnUpdate", update_func);
				end
				NS.HideProgress();
				_log_("scan_normal");
				return true;
			end
			function NS.scan_normal(name, exact, cache_temp, call_back)
				return NS.scan_normal_detail(name, nil, nil, nil, nil, false, exact, nil, cache_temp, call_back)
			end
			function NS.halt_scan_normal()
				_processing_normal_scan = false;
				update_frame:SetScript("OnUpdate", nil);
			end
		end
		local __QueryAuctionItems = QueryAuctionItems;
		local __CanSendAuctionQuery = CanSendAuctionQuery;
		--
		function NS.AUCTION_HOUSE_SHOW()
			if NS.BaudAuctionFrame then
				NS.BaudAuctionFrame:_RegisterEvent("AUCTION_ITEM_LIST_UPDATE");
			elseif BaudAuctionFrame then
				BaudAuctionFrame:RegisterEvent("AUCTION_ITEM_LIST_UPDATE");
			end
		end
		function NS.AUCTION_HOUSE_CLOSED()
			wipe(_cache_temp_table);
			if NS.BaudAuctionFrame then
				NS.BaudAuctionFrame:_RegisterEvent("AUCTION_ITEM_LIST_UPDATE");
			elseif BaudAuctionFrame then
				BaudAuctionFrame:RegisterEvent("AUCTION_ITEM_LIST_UPDATE");
			end
		end
	end

	do	--	record sell
		local _history_sell_price = {  };
		local __PostAuction = _G.PostAuction;
		function _G.PostAuction(startStackPrice, buyoutStackPrice, duration, stackSize, numStacks)
			local name, texture, count, quality, canUse, price, pricePerUnit, stackCount, totalCount, itemID = GetAuctionSellItemInfo();
			_history_sell_price[itemID] = { GetServerTime(), startStackPrice / stackSize, buyoutStackPrice / stackSize };
			__PostAuction(startStackPrice, buyoutStackPrice, duration, stackSize, numStacks);
		end
		function NS.GetHistorySellPrice(id, LIFE_PERIOD)
			local info = _history_sell_price[id];
			if info ~= nil then
				LIFE_PERIOD = LIFE_PERIOD or BIG_NUMBER;
				if GetServerTime() - info[1] <= LIFE_PERIOD then
					return info[2], info[3];
				end
			end
		end
	end

	do	--	query price
		function NS.query_ah_useful_db_by_id(id)
			local c = cache[id];
			if c and c[index_cacheTime] then
				local p = GetServerTime() - c[index_cacheTime];
				if c[index_buyoutPriceSingle] and p < PRICE_USEFUL_CYCLE then
					return c[index_buyoutPriceSingle], c[index_count], c[index_cacheTime], p < PRICE_CREDIBLE_CYCLE;
				end
			end
		end
		function NS.query_ah_price_by_id(id, offline)
			local c = cache[id];
			if c then
				-- if not offline then
				-- 	NS.NotifyQueryPrice(id, c[index_cacheTime]);
				-- end
				if c[index_buyoutPriceSingle] then
					return c[index_buyoutPriceSingle], GetServerTime() - c[index_cacheTime];
				else
					local H = c[index_history];
					if H then
						for i = #H, 1, -1 do
							if H[i][1] then
								return H[i][1], GetServerTime() - H[i][3];
							end
						end
					end
				end
			else
				-- if not offline then
				-- 	NS.NotifyQueryPrice(id, - BIG_NUMBER);
				-- end
			end
		end
		function NS.query_ah_price_by_id_detailed(id, offline)
			local c = cache[id];
			if c then
				-- if not offline then
				-- 	NS.NotifyQueryPrice(id, c[index_cacheTime]);
				-- end
				if c[index_buyoutPriceSingle] then
					local t = GetServerTime() - c[index_cacheTime];
					return c[index_buyoutPriceSingle], t, NS.seconds_to_colored_formatted_time_len(t);
				else
					local H = c[index_history];
					if H then
						for i = #H, 1, -1 do
							if H[i][1] then
								local t = GetServerTime() - H[i][3];
								return H[i][1], t, NS.seconds_to_colored_formatted_time_len(t);
							end
						end
					end
				end
			else
				-- if not offline then
				-- 	NS.NotifyQueryPrice(id, - BIG_NUMBER);
				-- end
			end
		end
		function NS.query_ah_price_by_name(name, offline)
			local id = cache2[name];
			if id then
				return NS.query_ah_price_by_id(id, offline);
			end
		end
		----------------------------------------------------------------
		local material_sold_by_vendor = {
			--	BLACKSMITHING	ENGINEERING
			-- [5956] = 18,		-- 铁匠之锤
			-- [2901] = 81,		-- 矿工锄
			[2880] = 100,		-- 弱效助熔剂
			[3466] = 2000,		-- 强效助熔剂
			[3857] = 500,		-- 煤块
			[18567] = 150000,	-- 元素助熔剂
			[4399] = 200,		-- 木柴
			[4400] = 2000,		-- 沉重的树干
			[10648] = 500,		-- 空白的羊皮纸
			[10647] = 2000,		-- 墨水
			[6530] = 100,		-- 夜色虫
			--	ALCHEMY
			[3371] = 4,			-- 空瓶
			[3372] = 40,		-- 铅瓶
			[8925] = 500,		-- 水晶瓶
			[18256] = 6000,	-- 灌魔之瓶
			--	ENCHANGING
			[6217] = 124,		-- 铜棒
			[4470] = 38,		-- 普通木柴
			[11291] = 4500,		-- 星木
			--	TAILORING	LEATHERWORKING
			[2320] = 10,		-- 粗线
			[2321] = 100,		-- 细线
			[4291] = 500,		-- 丝线
			[8343] = 2000,		-- 粗丝线
			[14341] = 5000,		-- 符文线
			[2324] = 25,		-- 漂白剂
			[2604] = 50,		-- 红色染料
			[6260] = 50,		-- 蓝色染料
			[2605] = 100,		-- 绿色染料
			[4341] = 500,		-- 黄色染料
			[4340] = 350,		-- 灰色染料
			[6261] = 1000,		-- 橙色染料
			[2325] = 1000,		-- 灰色染料
			[4342] = 2500,		-- 紫色染料
			[10290] = 2500,		-- 粉红燃料
			[4289] = 50,		-- 盐
			--	COOKING
			[159] = 5,			-- 清凉的泉水
			[1179] = 125,		-- 冰镇牛奶
			[2678] = 2,			-- 甜香料
			[2692] = 40,		-- 辣椒
			[3713] = 160,		-- 舒心草
			[2596] = 120,		-- 矮人烈酒
			--	POISION
			[2928] = 20,		--	蚀骨灰
			[5140] = 25,		--	闪光粉
			[2930] = 50,		--	痛苦精华
			[2931] = 1000,		--	魔女之毒
			[8924] = 100,		--	堕落之尘
			[5173] = 100,		--	丧命草
			[8923] = 200,		--	苦楚精华
			--
			[5565] = 5000,		--	地狱火石
			[16583] = 10000,	--	恶魔雕像
			[17020] = 1000,		--	魔粉
			[17021] = 700,		--	野生浆果
			[17026] = 1000,		--	野生棘根草
			[17028] = 700,		--	圣洁蜡烛
			[17029] = 1000,		--	神圣蜡烛
			[17030] = 2000,		--	十字章
			[17031] = 1000,		--	传送符文
			[17032] = 2000,		--	传送门符文
			[17033] = 2000,		--	神圣符印
			[17034] = 200,		--	枫树种子
			[17035] = 400,		--	荆棘种子
			[17036] = 800,		--	灰木种子
			[17037] = 1400,		--	角树种子
			[17038] = 2000,		--	铁木种子
			[21177] = 300,		--	王者印记
		};
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
						C_Item.RequestLoadItemDataByID(arg1);
					end
					if num_material_sold_by_vendor <= 0 then
						self:SetScript("OnEvent", nil);
						self:UnregisterAllEvents();
						frame = nil;
					end
				end
			end);
			for id, price in next, material_sold_by_vendor do
				C_Item.RequestLoadItemDataByID(id);
			end
		end
		--
		function NS.get_material_vendor_price_by_link(link, num)
			local id = tonumber(select(3, strfind(link, "item:(%d+)")));
			return id and NS.get_material_vendor_price_by_id(id, num);
		end
		function NS.get_material_vendor_price_by_id(id, num)
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
		function NS.get_material_vendor_price_by_name(name, num)
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
	end

	do	--	misc query
		function NS.query_last_cache_time_by_id(id)
			local c = cache[id];
			if c then
				if c[index_buyoutPriceSingle] then
					return c[index_cacheTime];
				else
					local H = c[index_history];
					if H then
						for i = #H, 1, -1 do
							if H[i][1] then
								return H[i][3];
							end
						end
					end
				end
			end
		end
		function NS.query_quality_by_id(id)
			if cache[id] then
				return cache[id][index_quality];
			end
		end
		function NS.query_id_by_name(name)
			return cache2[name];
		end
		function NS.query_quality_by_name(name)
			local id = cache2[name];
			if id and cache[id] then
				return cache[id][index_quality];
			end
		end
		function NS.query_name_by_id(id)
			return cache[id] and cache[id][index_name] or nil;
		end
	end

	-- CREDIT Auctionator
	do	--	disenchant db
		-- select(12, GetItemInfo(x))	-- item type	LE_ITEM_CLASS_ARMOR, LE_ITEM_CLASS_WEAPON
		-- select(3, GetItemInfo(x))	-- item rarity	0 - 8
		local DB = {  };
		local ITEM = {  };
		local function cache_item_info(id)
			local name, link, quality = GetItemInfo(id);
			if name then
				local _, _, _, code = GetItemQualityColor(quality);
				ITEM[id] = "\124c" .. code .. name .. "\124r";
				return true;
			else
				ITEM[id] = false;
				return false;
			end
		end
		do
			local ORIG_DB = {
				[LE_ITEM_CLASS_ARMOR or 4] = {
					[2] = {
						{  5, 15, 40, 1, 10940, 40, 2, 10940, 10, 1, 10938, 10, 2, 10938, },
						{ 16, 20, 37.5, 2, 10940, 37.5, 3, 10940, 10, 1, 10939, 10, 2, 10939, 5, 1, 10978, },
						{ 21, 25, 25, 4, 10940, 25, 5, 10940, 25, 6, 10940, 7.5, 1, 10998, 7.5, 2, 10998, 10, 1, 10978, },
						{ 26, 30, 37.5, 1, 11083, 37.5, 2, 11083, 10, 1, 11082, 10, 2, 11082, 5, 1, 11084, },
						{ 31, 35, 18.75, 2, 11083, 18.75, 3, 11083, 18.75, 4, 11083, 18.75, 5, 11083, 10, 1, 11134, 10, 2, 11134, 5, 1, 11138, },
						{ 36, 40, 37.5, 1, 11137, 37.5, 2, 11137, 10, 1, 11135, 10, 2, 11135, 5, 1, 11139, },
						{ 41, 45, 18.75, 2, 11137, 18.75, 3, 11137, 18.75, 4, 11137, 18.75, 5, 11137, 10, 1, 11174, 10, 2, 11174, 5, 1, 11177, },
						{ 46, 50, 37.5, 1, 11176, 37.5, 2, 11176, 10, 1, 11175, 10, 2, 11175, 5, 1, 11178, },
						{ 51, 55, 18.75, 2, 11176, 18.75, 3, 11176, 18.75, 4, 11176, 18.75, 5, 11176, 10, 1, 16202, 10, 2, 16202, 5, 1, 14343, },
						{ 56, 60, 37.5, 1, 16204, 37.5, 2, 16204, 10, 1, 16203, 10, 2, 16203, 5, 1, 14344, },
						{ 61, 65, 18.75, 2, 16204, 18.75, 3, 16204, 18.75, 4, 16204, 18.75, 5, 16204, 10, 2, 16203, 10, 3, 16203, 5, 1, 14344, },
						{ 66, 80, 25, 1, 22445, 25, 2, 22445, 25, 3, 22445, 7.3333333333333, 1, 22447, 7.3333333333333, 2, 22447, 7.3333333333333, 3, 22447, 3, 1, 22448, },
						{ 81, 99, 37.5, 2, 22445, 37.5, 3, 22445, 11, 2, 22447, 11, 3, 22447, 3, 1, 22448, },
						{ 100, 120, 18.75, 2, 22445, 18.75, 3, 22445, 18.75, 4, 22445, 18.75, 5, 22445, 11, 1, 22446, 11, 2, 22446, 3, 1, 22449, },
						{ 121, 151, 25, 1, 34054, 25, 2, 34054, 25, 3, 34054, 11, 1, 34056, 11, 2, 34056, 3, 1, 34053, },
						{ 152, 200, 18.75, 4, 34054, 18.75, 5, 34054, 18.75, 6, 34054, 18.75, 7, 34054, 11, 1, 34055, 11, 2, 34055, 3, 1, 34052, },
						{ 272, 272, 34, 1, 52555, 41, 2, 52555, 13, 1, 52718, 12, 2, 52718, },
						{ 278, 278, 31, 1, 52555, 20, 2, 52555, 22, 3, 52555, 9, 1, 52718, 11, 2, 52718, 6, 3, 52718, },
						{ 283, 283, 28, 1, 52555, 21, 2, 52555, 24, 3, 52555, 1, 4, 52555, 8, 1, 52718, 9, 2, 52718, 9, 3, 52718, },
						{ 285, 285, 28, 1, 52555, 25, 2, 52555, 20, 3, 52555, 0, 4, 52555, 7, 1, 52718, 9, 2, 52718, 10, 3, 52718, 0, 6, 52718, },
						{ 289, 289, 25, 1, 52555, 25, 2, 52555, 25, 3, 52555, 0, 4, 52555, 0, 5, 52555, 7, 1, 52718, 9, 2, 52718, 8, 3, 52718, 0, 5, 52718, },
						{ 295, 295, 21, 1, 52555, 19, 2, 52555, 22, 3, 52555, 17, 4, 52555, 7, 2, 52718, 8, 3, 52718, 6, 4, 52718, },
						{ 300, 300, 18, 1, 52555, 20, 2, 52555, 19, 3, 52555, 19, 4, 52555, 0, 6, 52555, 8, 2, 52718, 10, 3, 52718, 7, 4, 52718, },
						{ 305, 305, 15, 1, 52555, 12, 2, 52555, 26, 3, 52555, 20, 4, 52555, 9, 2, 52718, 10, 3, 52718, 9, 4, 52718, },
						{ 306, 306, 24, 2, 52555, 26, 3, 52555, 26, 4, 52555, 12, 1, 52719, 12, 2, 52719, },
						{ 312, 312, 29, 2, 52555, 30, 3, 52555, 20, 4, 52555, 11, 1, 52719, 11, 2, 52719, },
						{ 316, 316, 18, 2, 52555, 18, 3, 52555, 22, 4, 52555, 16, 5, 52555, 14, 2, 52719, 12, 3, 52719, },
						{ 318, 318, 14, 2, 52555, 21, 3, 52555, 22, 4, 52555, 18, 5, 52555, 12, 2, 52719, 13, 3, 52719, },
						{ 325, 325, 17, 3, 52555, 17, 4, 52555, 17, 5, 52555, 50, 2, 52719, },
						{ 333, 333, 12, 2, 52555, 24, 3, 52555, 12, 4, 52555, 29, 5, 52555, 18, 2, 52719, 6, 3, 52719, },
						{ 364, 380, 85, 2, 74249, 15, 1, 74250, },
						{ 381, 390, 85, 2.5, 74249, 15, 1, 74250, },
						{ 391, 410, 85, 3, 74249, 15, 1.5, 74250, },
						{ 411, 483, 85, 3.5, 74249, 15, 2, 74250, },
						{ 484, 625, 100, 2.5, 109693, },
						{ 626, 900, 100, 2.5, 124440, },
					},
					[3] = {
						{ 11, 25, 100, 1, 10978, },
						{ 26, 30, 100, 1, 11084, },
						{ 31, 35, 100, 1, 11138, },
						{ 36, 40, 100, 1, 11139, },
						{ 41, 45, 100, 1, 11177, },
						{ 46, 50, 100, 1, 11178, },
						{ 51, 55, 100, 1, 14343, },
						{ 56, 65, 99.5, 1, 14344, 0.5, 1, 20725, },
						{ 66, 99, 99.5, 1, 22448, 0.5, 1, 20725, },
						{ 100, 120, 99.5, 1, 22449, 0.5, 1, 22450, },
						{ 121, 164, 99.5, 1, 34053, 0.5, 1, 34057, },
						{ 165, 280, 99.5, 1, 34052, 0.5, 1, 34057, },
						{ 288, 288, 100, 1, 52720, },
						{ 292, 292, 100, 1, 52720, },
						{ 300, 300, 95, 1, 52720, 5, 2, 52720, },
						{ 308, 308, 100, 1, 52720, },
						{ 316, 316, 100, 1, 52720, },
						{ 318, 318, 100, 1, 52721, },
						{ 325, 325, 100, 1, 52721, },
						{ 333, 333, 97, 1, 52721, 3, 2, 52721, },
						{ 339, 339, 98, 1, 52721, 2, 2, 52721, },
						{ 346, 346, 99, 1, 52721, 1, 2, 52721, },
						{ 352, 380, 100, 1, 52721, },
						{ 381, 424, 100, 1, 74252, },
						{ 425, 449, 100, 1, 74247, },
						{ 450, 450, 20, 1, 74247, 80, 1, 74252, },
						{ 451, 476, 100, 1, 74247, },
						{ 477, 685, 90, 9, 109693, 10, 1, 111245, },
						{ 686, 850, 30, 3, 124440, 70, 1, 124441, }
					},
					[4] = {
						{ 40, 45, 33.33, 2, 11177, 33.33, 3, 11177, 33.33, 4, 11177, },
						{ 46, 50, 33.33, 2, 11178, 33.33, 3, 11178, 33.33, 4, 11178, },
						{ 51, 55, 33.33, 2, 14343, 33.33, 3, 14343, 33.33, 4, 14343, },
						{ 56, 60, 100, 1, 20725, },
						{ 61, 80, 50, 1, 20725, 50, 2, 20725, },
						{ 95, 100, 50, 1, 22450, 50, 2, 22450, },
						{ 105, 164, 33.3, 1, 22450, 66.6, 2, 22450, },
						{ 165, 280, 100, 1, 34057, },
						{ 281, 450, 100, 1, 52722, },
						{ 420, 600, 100, 1, 74248, },
						{ 601, 834, 100, 1, 113588, },
						{ 835, 950, 100, 1, 124442, }
					},
				},
				[LE_ITEM_CLASS_WEAPON or 2] = {
					[2] = {
						{  6, 15, 10, 1, 10940, 10, 2, 10940, 40, 1, 10938, 40, 2, 10938, },
						{ 16, 20, 10, 2, 10940, 10, 3, 10940, 37.5, 1, 10939, 37.5, 2, 10939, 5, 1, 10978, },
						{ 21, 25, 5, 4, 10940, 5, 5, 10940, 5, 6, 10940, 37.5, 1, 10998, 37.5, 2, 10998, 10, 1, 10978, },
						{ 26, 30, 10, 1, 11083, 10, 2, 11083, 37.5, 1, 11082, 37.5, 2, 11082, 5, 1, 11084, },
						{ 31, 35, 5, 2, 11083, 5, 3, 11083, 5, 4, 11083, 5, 5, 11083, 37.5, 1, 11134, 37.5, 2, 11134, 5, 1, 11138, },
						{ 36, 40, 10, 1, 11137, 10, 2, 11137, 37.5, 1, 11135, 37.5, 2, 11135, 5, 1, 11139, },
						{ 41, 45, 5, 2, 11137, 5, 3, 11137, 5, 4, 11137, 5, 5, 11137, 37.5, 1, 11174, 37.5, 2, 11174, 5, 1, 11177, },
						{ 46, 50, 10, 1, 11176, 10, 2, 11176, 37.5, 1, 11175, 37.5, 2, 11175, 5, 1, 11178, },
						{ 51, 55, 5.5, 2, 11176, 5.5, 3, 11176, 5.5, 4, 11176, 5.5, 5, 11176, 37.5, 1, 16202, 37.5, 2, 16202, 5, 1, 14343, },
						{ 56, 60, 11, 1, 16204, 11, 2, 16204, 37.5, 1, 16203, 37.5, 2, 16203, 5, 1, 14344, },
						{ 61, 65, 5.5, 2, 16204, 5.5, 3, 16204, 5.5, 4, 16204, 5.5, 5, 16204, 37.5, 2, 16203, 37.5, 3, 16203, 5, 1, 14344, },
						{ 66, 99, 11, 2, 22445, 11, 3, 22445, 37.5, 2, 22447, 37.5, 3, 22447, 3, 1, 22448, },
						{ 100, 120, 5.5, 2, 22445, 5.5, 3, 22445, 5.5, 4, 22445, 5.5, 5, 22445, 37.5, 1, 22446, 37.5, 2, 22446, 3, 1, 22449, },
						{ 121, 151, 7.3333333333333, 1, 34054, 7.3333333333333, 2, 34054, 7.3333333333333, 3, 34054, 37.5, 1, 34056, 37.5, 2, 34056, 3, 1, 34053, },
						{ 152, 200, 5.5, 4, 34054, 5.5, 5, 34054, 5.5, 6, 34054, 5.5, 7, 34054, 37.5, 1, 34055, 37.5, 2, 34055, 3, 1, 34052, },
						{ 272, 272, 12, 1, 52555, 11, 2, 52555, 33, 1, 52718, 45, 2, 52718, },
						{ 278, 278, 16, 1, 52555, 8, 2, 52555, 4, 3, 52555, 16, 1, 52718, 28, 2, 52718, 28, 3, 52718, },
						{ 283, 283, 7, 1, 52555, 5, 2, 52555, 17, 3, 52555, 22, 1, 52718, 22, 2, 52718, 25, 3, 52718, },
						{ 289, 289, 8, 1, 52555, 8, 2, 52555, 25, 1, 52718, 33, 2, 52718, 27, 3, 52718, },
						{ 295, 295, 2, 1, 52555, 16, 2, 52555, 5, 3, 52555, 3, 4, 52555, 17, 2, 52718, 30, 3, 52718, 28, 4, 52718, },
						{ 300, 300, 4, 1, 52555, 10, 2, 52555, 10, 3, 52555, 8, 4, 52555, 25, 2, 52718, 16, 3, 52718, 27, 4, 52718, },
						{ 305, 305, 25, 2, 52555, 25, 3, 52555, 37, 3, 52718, 12, 4, 52718, },
						{ 306, 306, 11, 2, 52555, 8, 3, 52555, 11, 4, 52555, 36, 1, 52719, 35, 2, 52719, },
						{ 312, 312, 11, 2, 52555, 7, 3, 52555, 8, 4, 52555, 42, 1, 52719, 31, 2, 52719, },
						{ 317, 317, 6, 2, 52555, 7, 3, 52555, 7, 4, 52555, 6, 5, 52555, 37, 2, 52719, 36, 3, 52719, 1, 5, 52719, },
						{ 318, 318, 21, 3, 52555, 5, 5, 52555, 42, 2, 52719, 32, 3, 52719, },
						{ 351, 380, 85, 2.5, 74249, 15, 1, 74250, },
						{ 381, 390, 85, 3, 74249, 15, 1, 74250, },
						{ 391, 410, 85, 3.5, 74249, 15, 1.5, 74250, },
						{ 411, 483, 85, 4, 74249, 15, 2, 74250, },
						{ 484, 700, 100, 2.5, 109693, }
					},
					[3] = {
						{ 11, 25, 100, 1, 10978, },
						{ 26, 30, 100, 1, 11084, },
						{ 31, 35, 100, 1, 11138, },
						{ 36, 40, 100, 1, 11139, },
						{ 41, 45, 100, 1, 11177, },
						{ 46, 50, 100, 1, 11178, },
						{ 51, 55, 100, 1, 14343, },
						{ 56, 65, 99.5, 1, 14344, 0.5, 1, 20725, },
						{ 66, 99, 99.5, 1, 22448, 0.5, 1, 20725, },
						{ 100, 120, 99.5, 1, 22449, 0.5, 1, 22450, },
						{ 121, 164, 99.5, 1, 34053, 0.5, 1, 34057, },
						{ 165, 280, 99.5, 1, 34052, 0.5, 1, 34057, },
						{ 308, 308, 100, 1, 52720, },
						{ 316, 316, 100, 1, 52720, },
						{ 318, 318, 100, 1, 52721, },
						{ 333, 333, 100, 1, 52721, },
						{ 346, 346, 93, 1, 52721, 7, 2, 52721, },
						{ 381, 424, 100, 1, 74252, },
						{ 425, 449, 100, 1, 74247, },
						{ 450, 450, 20, 1, 74247, 80, 1, 74252, },
						{ 451, 476, 100, 1, 74247, },
						{ 477, 800, 90, 9, 109693, 10, 1, 111245, }
					},
					[4] = {
						{ 40, 45, 33.33, 2, 11177, 33.33, 3, 11177, 33.33, 4, 11177, },
						{ 46, 50, 33.33, 2, 11178, 33.33, 3, 11178, 33.33, 4, 11178, },
						{ 51, 55, 33.33, 2, 14343, 33.33, 3, 14343, 33.33, 4, 14343, },
						{ 56, 60, 100, 1, 20725, },
						{ 61, 80, 33.3, 1, 20725, 66.6, 2, 20725, },
						{ 95, 100, 50, 1, 22450, 50, 2, 22450, },
						{ 105, 164, 33.3, 1, 22450, 66.6, 2, 22450, },
						{ 165, 280, 100, 1, 34057, },
						{ 281, 450, 100, 1, 52722, },
						{ 420, 600, 100, 1, 74248, },
						{ 601, 800, 100, 1, 113588, }
					},
				},
			};
			local frame = CreateFrame("FRAME");
			frame:RegisterEvent("GET_ITEM_INFO_RECEIVED");
			frame:SetScript("OnEvent", function(self, event, arg1, arg2)
				if arg2 and ITEM[arg1] ~= nil then
					cache_item_info(arg1);
					for _, v in next, ITEM do
						if ITEM == false then
							return;
						end
					end
					frame:SetScript("OnEvent", nil);
					frame:UnregisterAllEvents();
					frame = nil;
					ORIG_DB = nil;
				end
			end);
			for T, VT in next, ORIG_DB do
				DB[T] = {  };
				for R, VR in next, VT do
					DB[T][R] = {  };
					for _, v in next, VR do
						local t = { select(3, unpack(v)) };
						for i = v[1], v[2] do
							DB[T][R][i] = t;
						end
					end
				end
			end
			local function cache()
				if not ORIG_DB then
					return;
				end
				local finished = true;
				for T, VT in next, ORIG_DB do
					for R, VR in next, VT do
						for _, v in next, VR do
							for i = 3, #v, 3 do
								local id = v[i];
								if not ITEM[id] then
									finished = cache_item_info(id) and finished;
								end
							end
						end
					end
				end
				if finished then
					if frame then
						frame:SetScript("OnEvent", nil);
						frame:UnregisterAllEvents();
						frame = nil;
						ORIG_DB = nil;
					end
				end
				return finished;
			end
			if not cache() then
				C_Timer.After(1.0, cache);
			end
		end
		function NS.get_disenchant_info(rarity, item_type, item_level)	-- { rate, num, id, }
			if DB[item_type] and DB[item_type][rarity] and DB[item_type][rarity][item_level] then
				return DB[item_type][rarity][item_level];
			end
		end
		function NS.get_disenchant_meterial_name(id)
			if not ITEM[id] then
				cache_item_info(id);
			end
			return ITEM[id];
		end
	end

	do	--	hook tooltip
		-- price
		local function AddPrice(tip, id, num)
			local name, link, rarity, item_level, _, _, _, _, _, _, vdp, item_type, _, bind_type = GetItemInfo(id);
			if SET.show_vendor_price then
				if vdp and vdp > 0 then
					if num > 1 then
						tip:AddDoubleLine(L["VENDOR_PRICE"] .. " x 1", NS.MoneyString(vdp), 1, 0.5, 0, 1, 1, 1);
					else
						tip:AddDoubleLine(L["VENDOR_PRICE"], NS.MoneyString(vdp), 1, 0.5, 0, 1, 1, 1);
					end
				end
			end
			if num > 1 and SET.show_vendor_price_multi then
				if vdp and vdp > 0 then
					tip:AddDoubleLine(L["VENDOR_PRICE"] .. " x " .. num, NS.MoneyString(vdp * num), 1, 0.5, 0, 1, 1, 1);
				end
			end
			if SET.show_ah_price or SET.show_ah_price_multi then
				if bind_type == 1 then
					tip:AddDoubleLine(L["AH_PRICE"], L["BOP_ITEM"], 1, 0.5, 0, 1, 1, 1);
				elseif bind_type == 4 then
					tip:AddDoubleLine(L["AH_PRICE"], L["QUEST_ITEM"], 1, 0.5, 0, 1, 1, 1);
				else
					local ahp, timediff, timedifftext = NS.query_ah_price_by_id_detailed(id);
					if ahp then
						if timediff > SET.data_valid_time then
							if SET.show_ah_price then
								if num > 1 then
									tip:AddDoubleLine(L["AH_PRICE"] .. " x 1", timedifftext .. " " .. NS.MoneyString(ahp), 1, 0.5, 0, 1, 1, 1);
								else
									tip:AddDoubleLine(L["AH_PRICE"], timedifftext .. " " .. NS.MoneyString(ahp), 1, 0.5, 0, 1, 1, 1);
								end
							end
							if num > 1 and SET.show_ah_price_multi then
								tip:AddDoubleLine(L["AH_PRICE"] .. " x " .. num, timedifftext .. " " .. NS.MoneyString(ahp * num), 1, 0.5, 0, 1, 1, 1);
							end
						else
							if SET.show_ah_price then
								if num > 1 then
									tip:AddDoubleLine(L["AH_PRICE"] .. " x 1", timedifftext .. " " .. NS.MoneyString(ahp), 1, 0.5, 0, 1, 1, 1);
								else
									tip:AddDoubleLine(L["AH_PRICE"], timedifftext .. " " .. NS.MoneyString(ahp), 1, 0.5, 0, 1, 1, 1);
								end
							end
							if num > 1 and SET.show_ah_price_multi then
								tip:AddDoubleLine(L["AH_PRICE"] .. " x " .. num, timedifftext .. " " .. NS.MoneyString(ahp * num), 1, 0.5, 0, 1, 1, 1);
							end
						end
					else
						tip:AddDoubleLine(L["AH_PRICE"], L["UNKOWN"], 1, 0.5, 0, 1, 1, 1);
					end
				end
			end
			local deinfo = NS.get_disenchant_info(rarity, item_type, item_level);
			if deinfo then
				if SET.show_disenchant_price then
					local disenchant_price = 0;
					for i = 1, #deinfo, 3 do
						local rate, num, id = deinfo[i], deinfo[i + 1], deinfo[i + 2];
						local p = NS.query_ah_price_by_id(id);
						if p then
							disenchant_price = disenchant_price + p * num * rate * 0.01;
						end
					end
					if disenchant_price > 0 then
						tip:AddDoubleLine(L["Disenchant"], NS.MoneyString(disenchant_price), 1, 0.5, 0, 1, 1, 1);
					else
						tip:AddDoubleLine(L["Disenchant"], L["UNKOWN"], 1, 0.5, 0, 1, 1, 1);
					end
				end
				if SET.show_disenchant_detail then
					if not SET.show_disenchant_price then
						tip:AddLine(L["Disenchant"], 1, 0.5, 0);
					end
					for i = 1, #deinfo, 3 do
						local rate, num, id = deinfo[i], deinfo[i + 1], deinfo[i + 2];
						tip:AddDoubleLine("    " .. rate .. "%", (NS.get_disenchant_meterial_name(id) or L["UNKOWN"]) .. " x " .. num .. "    ", 1, 1, 1);
					end
				end
			end
			tip:Show();
			-- _log_("hook_tooltip", id, num);
		end
		local function HookTooltip(Tooltip)
			hooksecurefunc(Tooltip, "SetMerchantItem",
				function(Tooltip, index)
					-- local link = GetMerchantItemLink(index);
					local id = GetMerchantItemID(index);
					local name, _, _, num = GetMerchantItemInfo(index);
					if id then
						AddPrice(Tooltip, id, num);
					end
				end
			);
			hooksecurefunc(Tooltip, "SetBuybackItem",
				function(Tooltip, index)
					local link = GetBuybackItemLink(index);
					if link then
						local id = tonumber(select(3, strfind(link, "item:(%d+)")) or nil);
						local name, _, _, num = GetBuybackItemInfo(index);
						AddPrice(Tooltip, id, num);
					end
				end
			);
			hooksecurefunc(Tooltip, "SetBagItem",
				function(Tooltip, bag, slot)
					local _, num, _, _, _, _, link, _, _, id = GetContainerItemInfo(bag, slot);
					if id then
						-- local _, _, name = strfind(link, "%[([^]]+)%]")
						AddPrice(Tooltip, id, num);
					end
				end
			);
			hooksecurefunc(Tooltip, "SetAuctionItem",
				function(Tooltip, type, index)
					local name, _, num, _, _, _, _, _, _, _, _, _, _, _, _, _, id = GetAuctionItemInfo(type, index);
					if id then
						-- local link = GetAuctionItemLink(type, index);
						AddPrice(Tooltip, id, num);
					end
				end
			);
			hooksecurefunc(Tooltip, "SetAuctionSellItem",
				function(Tooltip)
					local name, _, num, _, _, _, _, _, _, id = GetAuctionSellItemInfo();
					if id then
						-- local name, link, _, _, _, _, _, _, _, _, _, _, _, bind_type = GetItemInfo(id);
						AddPrice(Tooltip, id, num);
					end
				end
			);
			hooksecurefunc(Tooltip, "SetLootItem",
				function(Tooltip, slot)
					if LootSlotHasItem(slot) and GetLootSlotType(slot) == LOOT_SLOT_ITEM then
						local link = GetLootSlotLink(slot);
						if link then
							local _, name, num = GetLootSlotInfo(slot);
							local id = tonumber(select(3, strfind(link, "item:(%d+)")) or nil);
							AddPrice(Tooltip, id, num);
						end
					end
				end
			);
			hooksecurefunc(Tooltip, "SetLootRollItem",
				function(Tooltip, slot)
					local link = GetLootRollItemLink(slot);
					if link then
						local _, name, num = GetLootRollItemInfo(slot);
						local id = tonumber(select(3, strfind(link, "item:(%d+)")) or nil);
						AddPrice(Tooltip, id, num);
					end
				end
			);
			hooksecurefunc(Tooltip, "SetInventoryItem",
				function(Tooltip, unit, slot)
					-- local link = GetInventoryItemLink(unit, slot);
					-- if link then
						local id = GetInventoryItemID(unit, slot);
						-- local _, _, name = strfind(link, "%[([^]]+)%]")
						if id then
							local num = GetInventoryItemCount(unit, slot);
							AddPrice(Tooltip, id, num);
						end
					-- end
				end
			);
			hooksecurefunc(Tooltip, "SetTradePlayerItem",
				function(Tooltip, index)
					local link = GetTradePlayerItemLink(index);
					if link then
						local id = tonumber(select(3, strfind(link, "item:(%d+)")) or nil);
						local name, _, num = GetTradePlayerItemInfo(index);
						AddPrice(Tooltip, id, num);
					end
				end
			);
			hooksecurefunc(Tooltip, "SetTradeTargetItem",
				function(Tooltip, index)
					local link = GetTradeTargetItemLink(index);
					if link then
						local id = tonumber(select(3, strfind(link, "item:(%d+)")) or nil);
						local name, _, num = GetTradeTargetItemInfo(index);
						AddPrice(Tooltip, id, num);
					end
				end
			);
			hooksecurefunc(Tooltip, "SetQuestItem",
				function(Tooltip, type, index)
					local link = GetQuestItemLink(type, index);
					if link then
						local id = tonumber(select(3, strfind(link, "item:(%d+)")) or nil);
						local name, _, num = GetQuestItemInfo(type, index);
						AddPrice(Tooltip, id, num);
					end
				end
			);
			hooksecurefunc(Tooltip, "SetQuestLogItem",
				function(Tooltip, type, index)
					local name, num, id, _;
					if type == "choice" then
						name, _, num, _, _, id = GetQuestLogChoiceInfo(index);
					else
						name, _, num, _, _, id = GetQuestLogRewardInfo(index)
					end
					if id then
						-- local link = GetQuestLogItemLink(type, index);
						AddPrice(Tooltip, id, num);
					end
				end
			);
			hooksecurefunc(Tooltip, "SetInboxItem",
				function(Tooltip, index, index2)
					index2 = index2 or 1;
					local name, id, _, num = GetInboxItem(index, index2);
					if id then
						-- local link = GetInboxItemLink(index, index2);
						AddPrice(Tooltip, id, num);
					end
				end
			);
			hooksecurefunc(Tooltip, "SetSendMailItem",
				function(Tooltip, index)
					-- local link = GetSendMailItemLink(index);
					local name, id, _, num = GetSendMailItem(index);
					if id then
						AddPrice(Tooltip, id, num);
					end
				end
			);
			hooksecurefunc(Tooltip, "SetTradeSkillItem",
				function(Tooltip, index, reagent)
					local link, name, num, _;
					if reagent then
						link = GetTradeSkillReagentItemLink(index, reagent);
						name, _, num = GetTradeSkillReagentInfo(index, reagent);
					else
						link = GetTradeSkillItemLink(index);
						local n1, n2 = GetTradeSkillNumMade(index);
						num = (n1 + n2) / 2;
					end
					if link then
						local id = tonumber(select(3, strfind(link, "item:(%d+)")) or nil);
						AddPrice(Tooltip, id, num);
					end
				end
			);
			hooksecurefunc(Tooltip, "SetCraftItem",
				function(Tooltip, index, reagent)
					local link = GetCraftReagentItemLink(index, reagent);
					if link then
						local id = tonumber(select(3, strfind(link, "item:(%d+)")) or nil);
						local name, _, num = GetCraftReagentInfo(index, reagent);
						AddPrice(Tooltip, id, num);
					end
				end
			);
			hooksecurefunc(Tooltip, "SetHyperlink",
				function(Tooltip, itemstring, num)
					-- local name, link, _, _, _, _, _, _, _, _, _, _, _, bind_type = GetItemInfo(itemstring);
					-- if link then
					-- 	local id = tonumber(select(3, strfind(link, "item:(%d+)")));
					-- 	AddPrice(Tooltip, id, 1);
					-- end
					local id = tonumber(select(3, strfind(itemstring, "item:(%d+)")) or nil);
					if id then
						AddPrice(Tooltip, id, 1);
					end
				end
			);
			hooksecurefunc(Tooltip, "SetItemByID",
				function(Tooltip, id)
					if id then
						AddPrice(Tooltip, id, 1);
					end
				end
			);
			hooksecurefunc(Tooltip, "SetTrainerService",
				function(Tooltip, service)
					local _, itemstring = Tooltip:GetItem();
					if itemstring ~= nil then
						local id = tonumber(select(3, strfind(itemstring, "item:(%d+)")) or nil);
						if id then
							AddPrice(Tooltip, id, 1);
						end
					end
				end
			);
			hooksecurefunc(Tooltip, "SetGuildBankItem", function(Tooltip, tab, index)
				local link = GetGuildBankItemLink(tab, index);
				if link ~= nil then
					local id = tonumber(strmatch(link, "item:(%d+)") or nil);
					if id ~= nil then
						local _, num = GetGuildBankItemInfo(tab, index);
						AddPrice(Tooltip, id, num);
					end
				end
			end);
			--[[
				hooksecurefunc(Tooltip, 'SetRecipeResultItem',
					function(Tooltip, itemId)
						local link = C_TradeSkillUI.GetRecipeItemLink(itemId)
						local count = C_TradeSkillUI.GetRecipeNumItemsProduced(itemId)

						Atr_ShowTipWithPricing(Tooltip, link, count)
					end
				);
				hooksecurefunc(Tooltip, 'SetRecipeReagentItem',
					function(Tooltip, itemId, index)
						local link = C_TradeSkillUI.GetRecipeReagentItemLink(itemId, index)
						local count = select(3, C_TradeSkillUI.GetRecipeReagentInfo(itemId, index))

						Atr_ShowTipWithPricing(Tooltip, link, count)
					end
				);
			]]--
			hooksecurefunc(Tooltip, "SetCompareItem",
				function(Tooltip, Tooltip2, service)
					local _, itemstring = Tooltip:GetItem();
					if itemstring ~= nil then
						local id = tonumber(select(3, strfind(itemstring, "item:(%d+)")) or nil);
						if id then
							AddPrice(Tooltip, id, 1);
						end
					end
					local _, itemstring = Tooltip2:GetItem();
					if itemstring ~= nil then
						local id = tonumber(select(3, strfind(itemstring, "item:(%d+)")) or nil);
						if id then
							AddPrice(Tooltip2, id, 1);
						end
					end
				end
			);
		end
		function NS.hook_tooltip()
			HookTooltip(GameTooltip);
			HookTooltip(ItemRefTooltip);
			if ShoppingTooltip1 then
				HookTooltip(ShoppingTooltip1);
			end
			if ShoppingTooltip2 then
				HookTooltip(ShoppingTooltip2);
			end
		end
	end

	do	--	hook Auction
		do
			local ____QueryAuctionItems = QueryAuctionItems;
			function _G.QueryAuctionItems(name, minL, maxL, _arg4, usable, q, all, exact, selected, ...)
				if all then
					return ____QueryAuctionItems(name, minL, maxL, _arg4, usable, q, all, exact, selected, ...);
				elseif AuctionFrameBrowse:IsShown() then
					return ____QueryAuctionItems(name, minL, maxL, _arg4, usable, q, all, AuctionFrameBrowse_ExactQuery and AuctionFrameBrowse_ExactQuery:GetChecked(), selected, ...);
				else
					return ____QueryAuctionItems(name, minL, maxL, _arg4, usable, q, all, exact, selected, ...);
				end
			end
		end
		local function SCAN_UI()
			-- if conflicted_addons_list["BaudAuction"] then
				-- NS.scan_normal_detail(BrowseName:GetText(), BrowseMinLevel:GetNumber(), BrowseMaxLevel:GetNumber(), IsUsableCheckButton:GetChecked(), BrowseDropDown.selectedValue, false, nil, nil, true, NS.Browse_CALLBACK);
			-- else
				QueryAuctionItems(BrowseName:GetText(), BrowseMinLevel:GetNumber(), BrowseMaxLevel:GetNumber(), 0, IsUsableCheckButton:GetChecked(), BrowseDropDown.selectedValue, false, nil, nil);
			-- end
		end
		local SearchProgress = nil;
		local PRICE_TYPE_UNIT = 1;
		local PRICE_TYPE_STACK = 2;
		local function set_start_price(copper)
			MoneyInputFrame_SetCopper(StartPrice, copper);
		end
		local function set_buyout_price(copper)
			MoneyInputFrame_SetCopper(BuyoutPrice, copper);
		end
		local function set_price(bidPrice, buyoutPrice, cut)
			if buyoutPrice then
				if cut then
					buyoutPrice = floor(buyoutPrice) - 1;
				else
					buyoutPrice = floor(buyoutPrice);
				end
				bidPrice = bidPrice and floor(bidPrice) or buyoutPrice;
				local name, texture, count, quality, canUse, price, pricePerUnit, stackCount, totalCount, itemID = GetAuctionSellItemInfo();
				if AuctionFrameAuctions.priceType == PRICE_TYPE_UNIT then
					set_buyout_price(buyoutPrice);
					set_start_price(bidPrice);
				elseif AuctionFrameAuctions.priceType == PRICE_TYPE_STACK then
					set_buyout_price(buyoutPrice * count);
					set_start_price(bidPrice * count);
				end
			end
		end
		function NS.HideProgress()
			SearchProgress:Hide();
			SearchProgress:SetScript("OnUpdate", nil);
		end
		function NS.ShowProgress(curVal, maxVal)
			if curVal and maxVal then
				SearchProgress:Show();
				if maxVal == 0 and curVal > maxVal then
					SearchProgress:SetMinMaxValues(0, 1);
					SearchProgress:SetValue(1);
				else
					SearchProgress:SetMinMaxValues(0, maxVal);
					SearchProgress:SetValue(curVal);
				end
				if curVal >= maxVal then
					SearchProgress:SetStatusBarColor(0.0, 1.0, 0.0, 0.5);
				else
					SearchProgress:SetStatusBarColor(1.0, 1.0, 0.0, 0.5);
				end
			else
				NS.HideProgress();
			end
		end
		do	-- hook Blizzard_AuctionUI
			-- _cache_temp_table { 1_buyoutPrice_single_item, 2_bidPrice_single_item, 3_count, 4_owner, 5_timeLeft, 6_texture, 7_link, 8_page, 9_buyoutPrice, }
			--	BROWSE
			local BrowseDisplay = nil;
			local BrowseDisplayScroll = nil;
			local CACHES = nil;
			local INDICES = {  };
			local _selected_index = nil;
			local SORT_METHOD_NAME = 1;
			local SORT_METHOD_LEVEL = 2;
			local SORT_METHOD_TIMELEFT = 3;
			local SORT_METHOD_OWNER = 4;
			local SORT_METHOD_BID = 5;
			local SORT_METHOD_BUYOUT = 6;
			local t_sort_method = {
				[SORT_METHOD_NAME] = {
					[true] = function(v1, v2)
						return CACHES[v1][index_name] < CACHES[v2][index_name];
					end,
					[false] = function(v1, v2)
						return CACHES[v1][index_name] > CACHES[v2][index_name];
					end,
				},
				[SORT_METHOD_LEVEL] = {
					[true] = function(v1, v2)
						return CACHES[v1][index_level] < CACHES[v2][index_level];
					end,
					[false] = function(v1, v2)
						return CACHES[v1][index_level] > CACHES[v2][index_level];
					end,
				},
				[SORT_METHOD_TIMELEFT] = {
					[true] = function(v1, v2)
						return CACHES[v1][index_timeLeft] < CACHES[v2][index_timeLeft];
					end,
					[false] = function(v1, v2)
						return CACHES[v1][index_timeLeft] > CACHES[v2][index_timeLeft];
					end,
				},
				[SORT_METHOD_OWNER] = {
					[true] = function(v1, v2)
						return CACHES[v1][index_owner] < CACHES[v2][index_owner];
					end,
					[false] = function(v1, v2)
						return CACHES[v1][index_owner] > CACHES[v2][index_owner];
					end,
				},
				[SORT_METHOD_BID] = {
					[true] = function(v1, v2)
						return (CACHES[v1][index_bidPriceSingle] or BIG_NUMBER) < (CACHES[v2][index_bidPriceSingle] or BIG_NUMBER);
					end,
					[false] = function(v1, v2)
						return (CACHES[v1][index_bidPriceSingle] or BIG_NUMBER) > (CACHES[v2][index_bidPriceSingle] or BIG_NUMBER);
					end,
				},
				[SORT_METHOD_BUYOUT] = {
					[true] = function(v1, v2)
						return (CACHES[v1][index_buyoutPriceSingle] or BIG_NUMBER) < (CACHES[v2][index_buyoutPriceSingle] or BIG_NUMBER);
					end,
					[false] = function(v1, v2)
						return (CACHES[v1][index_buyoutPriceSingle] or BIG_NUMBER) > (CACHES[v2][index_buyoutPriceSingle] or BIG_NUMBER);
					end,
				},
			};
			local function func_sort_cache(sort_method, sort_method_seq)
				if sort_method then
					local method = t_sort_method[sort_method];
					if method then
						sort(INDICES, method[sort_method_seq > 0]);
					end
				end
			end
			function NS.Browse_CALLBACK(_name, _caches, _finished)
				_log_("Browse_CALLBACK", _name);
				if AuctionFrameBrowse:IsShown() then
					CACHES = _caches;
					wipe(INDICES);
					for i = 1, #CACHES do
						INDICES[i] = i;
					end
					func_sort_cache(SORT_METHOD_BUYOUT, 1);
					SetSelectedAuctionItem("list", 0);
					_selected_index = nil;
					BrowseDisplayScroll:SetNumValue(#_caches);
				end
			end
			local update_frame = CreateFrame("FRAME");
			local _name = nil;
			local function update_func()
				if _selected_index then
					local data = CACHES[index];
				else
				end
			end
			function NS.update_Browse_Button()
				if GetSelectedAuctionItem("list") == 0 then
					BrowseBidButton:Disable();
					BrowseBuyoutButton:Disable();
				else
					local data = CACHES[_selected_index];
					AuctionFrame.buyoutPrice = data[index_buyoutPrice];
					BrowseBidButton:Enable();
					if AuctionFrame.buyoutPrice > 0 then
						BrowseBuyoutButton:Enable();
					else
						BrowseBuyoutButton:Disable();
					end
				end
			end
			function NS.clearAuctionBrowseSelect()
				SetSelectedAuctionItem("list", 0);
				NS.update_Browse_Button();
			end
			local function BrowseDisplayButton_OnClick(self)
				local dataIndex = self:GetDataIndex();
				local index = INDICES[dataIndex];
				local data = CACHES[index];
				if data then
					_selected_index = index;
					local last_query_page = NS.last_query_page();
					if last_query_page == data[index_page] then
						local name, texture, count, quality, canUse, level, huh, minBid, minIncrement, buyoutPrice,
							bidAmount, highBidder, bidderFullName, owner, ownerFullName, saleStatus, id, hasAllInfo = GetAuctionItemInfo("list", data[index_index]);
						if buyoutPrice and buyoutPrice <= 0 then
							buyoutPrice = nil;
						end
						print(data[index_name], data[index_count], data[index_buyoutPrice], data[index_owner], data[index_link]);
						print(name, count, buyoutPrice, owner, GetAuctionItemLink("list", data[index_index]));
						if name == data[index_name] and count == data[index_count] and buyoutPrice == data[index_buyoutPrice] and (owner == nil or owner == data[index_owner])
							and (data[index_link] == nil or data[index_link] == GetAuctionItemLink("list", data[index_index])) then
							SetSelectedAuctionItem("list", data[index_index]);
							NS.update_Browse_Button();
							BrowseDisplayScroll:Update();
						else
							SetSelectedAuctionItem("list", 0);
							NS.update_Browse_Button();
							BrowseDisplayScroll:Update();
						end
					else
						SetSelectedAuctionItem("list", 0);
						NS.update_Browse_Button();
						BrowseDisplayScroll:Update();
					end
				end
			end
			local function BrowseDisplayButton_OnEnter(self)
				local dataIndex = self:GetDataIndex();
				local index = INDICES[dataIndex]
				if CACHES[index] then
					GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
					GameTooltip:SetHyperlink(CACHES[index][index_link]);
					GameTooltip:Show();
				end
			end
			local function BrowseDisplayButton_OnLeave(self)
				if GameTooltip:IsOwned(self) then
					GameTooltip:Hide();
				end
			end
			local function funcToCreateButton_Browse(parent, index, buttonHeight)
				local button = CreateFrame("BUTTON", nil, parent, "BackdropTemplate");
				button:SetHeight(buttonHeight);
				button:SetBackdrop({
					bgFile = "Interface\\Buttons\\WHITE8X8",	-- "Interface\\Buttons\\WHITE8X8",	-- "Interface\\Tooltips\\UI-Tooltip-Background", -- "Interface\\ChatFrame\\ChatFrameBackground"
					edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
					tile = true,
					tileSize = 2,
					edgeSize = 2,
					insets = { left = 0, right = 0, top = 0, bottom = 0 }
				});
				button:SetBackdropColor(0.25, 0.25, 0.25, 0.5);
				button:SetBackdropBorderColor(0.0, 0.0, 0.0, 1.0);
				button:SetHighlightTexture("Interface\\FriendsFrame\\UI-FriendsFrame-HighlightBar");
				button:EnableMouse(true);
				button:Show();

				local icon = button:CreateTexture(nil, "OVERLAY");
				icon:SetTexture(UNK_TEXTURE);
				icon:SetSize(buttonHeight - 1, buttonHeight - 1);
				icon:SetPoint("LEFT", 5, 0);
				button.icon = icon;

				local title = button:CreateFontString(nil, "OVERLAY");
				title:SetFont(ui_style.frameFont, ui_style.frameFontSize, "NORMAL");
				title:SetWidth(160);
				title:SetJustifyH("LEFT");
				title:SetMaxLines(1);
				title:SetPoint("LEFT", icon, "RIGHT", 5, 0);
				button.title = title;

				local level = button:CreateFontString(nil, "OVERLAY");
				level:SetFont(ui_style.frameFont, ui_style.smallFontSize, "NORMAL");
				level:SetWidth(15);
				level:SetJustifyH("LEFT");
				level:SetMaxLines(1);
				level:SetPoint("LEFT", icon, "RIGHT", 170, 0);
				button.level = level;

				local timeLeft = button:CreateFontString(nil, "OVERLAY");
				timeLeft:SetFont(ui_style.frameFont, ui_style.smallFontSize, "NORMAL");
				timeLeft:SetWidth(80);
				timeLeft:SetJustifyH("LEFT");
				timeLeft:SetMaxLines(1);
				timeLeft:SetPoint("LEFT", icon, "RIGHT", 190, 0);
				button.timeLeft = timeLeft;

				local owner = button:CreateFontString(nil, "OVERLAY");
				owner:SetFont(ui_style.frameFont, ui_style.smallFontSize, "NORMAL");
				owner:SetWidth(70);
				owner:SetJustifyH("LEFT");
				owner:SetMaxLines(1);
				owner:SetPoint("LEFT", icon, "RIGHT", 275, 0);
				button.owner = owner;

				local bid = button:CreateFontString(nil, "OVERLAY");
				bid:SetFont(ui_style.frameFont, ui_style.smallFontSize, "NORMAL");
				bid:SetWidth(75);
				bid:SetJustifyH("RIGHT");
				bid:SetMaxLines(1);
				bid:SetPoint("BOTTOMLEFT", icon, "BOTTOMRIGHT", 350, 0);
				button.bid = bid;

				local buyout = button:CreateFontString(nil, "OVERLAY");
				buyout:SetFont(ui_style.frameFont, ui_style.smallFontSize, "NORMAL");
				buyout:SetWidth(75);
				buyout:SetJustifyH("RIGHT");
				buyout:SetMaxLines(1);
				buyout:SetPoint("BOTTOMLEFT", icon, "BOTTOMRIGHT", 430, 0);
				button.buyout = buyout;

				local buyoutTotal = button:CreateFontString(nil, "OVERLAY");
				buyoutTotal:SetFont(ui_style.frameFont, ui_style.smallFontSize, "NORMAL");
				buyoutTotal:SetWidth(75);
				buyoutTotal:SetJustifyH("RIGHT");
				buyoutTotal:SetMaxLines(1);
				buyoutTotal:SetPoint("BOTTOMLEFT", icon, "BOTTOMRIGHT", 510, 0);
				button.buyoutTotal = buyoutTotal;

				button:SetScript("OnClick", BrowseDisplayButton_OnClick);
				button:SetScript("OnEnter", BrowseDisplayButton_OnEnter);
				button:SetScript("OnLeave", BrowseDisplayButton_OnLeave);

				return button;
			end
			local function functToSetButton_Browse(button, dataIndex)
				local index = INDICES[dataIndex]
				if CACHES and CACHES[index] then
					local data = CACHES[index];
					button.icon:SetTexture(data[index_texture]);
					button.title:SetText(data[index_name]);
					local r, g, b, code = GetItemQualityColor(data[index_quality]);
					button.title:SetTextColor(r, g, b, 1);
					button.level:SetText(data[index_level]);
					button.timeLeft:SetText(L["timeLeft"][data[index_timeLeft]]);
					if data[index_owner] == PLAYER_NAME then
						button.owner:SetText("\124cff00ff00" .. data[index_owner] .. "\124r");
					else
						button.owner:SetText(data[index_owner]);
					end
					if data[index_bidPriceSingle] and data[index_bidPriceSingle] > 0 then
						button.bid:SetText(NS.MoneyString_Short(data[index_bidPriceSingle]));
					else
						button.bid:SetText("");
					end
					if data[index_buyoutPriceSingle] and data[index_buyoutPriceSingle] > 0 then
						button.buyout:SetText(NS.MoneyString_Short(data[index_buyoutPriceSingle]));
					else
						button.buyout:SetText("");
					end
					if data[index_buyoutPrice] and data[index_buyoutPrice] > 0 then
						button.buyoutTotal:SetText(NS.MoneyString_Short(data[index_buyoutPrice]));
					else
						button.buyoutTotal:SetText("");
					end
					button:Show();
					if index == _selected_index then
						button:LockHighlight();
					else
						button:UnlockHighlight();
					end
					if GetMouseFocus() == button then
						BrowseDisplayButton_OnEnter(button);
					end
				else
					button:Hide();
				end
			end
			local function hook_AuctionFrameBrowse()
				local ExactQueryCheckButton = CreateFrame("CHECKBUTTON", "AuctionFrameBrowse_ExactQuery", AuctionFrameBrowse, "UICheckButtonTemplate");
				ExactQueryCheckButton:SetSize(24, 24);
				ExactQueryCheckButton:SetHitRectInsets(0, 0, 0, 0);
				ExactQueryCheckButton:SetPoint("BOTTOM", IsUsableCheckButton, "TOP", 0, 0);
				local ExactQueryCheckButton_text = ExactQueryCheckButton:CreateFontString(nil, "OVERLAY");
				ExactQueryCheckButton_text:SetFont(GameFontHighlightSmall:GetFont());
				ExactQueryCheckButton_text:SetPoint("RIGHT", ExactQueryCheckButton, "LEFT", -2, 0);
				ExactQueryCheckButton_text:SetText(L["ExactQuery"]);
				gui.ExactQueryCheckButton = ExactQueryCheckButton;
				--
				local ResetButton = CreateFrame("BUTTON", nil, AuctionFrameBrowse, "UIPanelButtonTemplate");
				ResetButton:SetPoint("BOTTOM", BrowseSearchButton, "TOP", 0, 0);
				ResetButton:SetSize(80, 22);
				ResetButton:SetText(L["Reset"]);
				ResetButton:SetScript("OnClick", function()
					AuctionFrameBrowse_Reset({ Disable = function() end, });
				end);
				gui.ResetButton = ResetButton;
				do return end
				--
				BrowseNoResultsText:SetAlpha(0.0);
				BrowseSearchCountText:SetAlpha(0.0);
				BrowseSearchDotsText:SetAlpha(0.0);
				local HideBlz = {
					BrowseQualitySort,
					BrowseLevelSort,
					BrowseDurationSort,
					BrowseHighBidderSort,
					BrowseCurrentBidSort,
					BrowsePrevPageButton,
					BrowseNextPageButton,
					BrowseNameSort
				};
				for _, f in next, HideBlz do
					f:Hide();
					f:SetAlpha(0);
					f:EnableMouse(false);
					f:SetScript("OnUpdate", nil);
					f:SetScript("OnEvent", nil);
					f:SetScript("OnShow", nil);
				end
				BrowseScrollFrame:Hide();
				BrowseScrollFrame:SetAlpha(0.0);
				BrowseScrollFrame:EnableMouse(false);
				for i = 1, NUM_BROWSE_TO_DISPLAY do
					local f = _G["BrowseButton" .. i];
					if f then
						f:Hide();
						f:SetAlpha(0);
						f:EnableMouse(false);
					end
				end
				_G.NUM_BROWSE_TO_DISPLAY = 0;
				AuctionFrameBrowse:UnregisterEvent("AUCTION_ITEM_LIST_UPDATE");
				--
				do return end
				BrowseSearchButton:SetScript("OnClick", SCAN_UI);
				--
				BrowseDisplay = CreateFrame("FRAME", nil, AuctionFrameBrowse, "BackdropTemplate");
				BrowseDisplay:SetSize(634, 306);
				BrowseDisplay:SetPoint("TOPRIGHT", AuctionFrameBrowse, "TOPRIGHT", 65, -100);
				BrowseDisplay:SetBackdrop({
					bgFile = "Interface\\Buttons\\WHITE8X8",	-- "Interface\\Buttons\\WHITE8X8",	-- "Interface\\Tooltips\\UI-Tooltip-Background", -- "Interface\\ChatFrame\\ChatFrameBackground"
					edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
					tile = true,
					tileSize = 2,
					edgeSize = 2,
					insets = { left = 0, right = 0, top = 0, bottom = 0, }
				});
				BrowseDisplay:SetBackdropColor(0.0, 0.0, 0.0, 1.0);
				BrowseDisplay:EnableMouse(true);
				BrowseDisplay:Show();
				BrowseDisplay:SetFrameLevel(255);
				BrowseDisplayScroll = ALASCR(BrowseDisplay, BrowseDisplay:GetWidth(), BrowseDisplay:GetHeight(), 16, funcToCreateButton_Browse, functToSetButton_Browse);
				BrowseDisplayScroll:SetPoint("BOTTOM", BrowseDisplay);
				--
			end
			--	SELL
			local AuctionsTimeDropDown = nil;
			local AuctionDisplay = nil;
			local AuctionDisplayScroll = nil;
			local _sell_item_id = nil;
			local function NEW_AUCTION_UPDATE_CALLBACK(_name, _caches, _finished)
				_log_("NEW_AUCTION_UPDATE_CALLBACK", _name, #_caches);
				local name, texture, count, quality, canUse, price, pricePerUnit, stackCount, totalCount, itemID = GetAuctionSellItemInfo();
				AuctionDisplay:Show();
				if name and _name == name and _caches[1] then
					CACHES = _caches;
					wipe(INDICES);
					local index = 1;
					while CACHES[index] do
						if CACHES[index][index_id] ~= _sell_item_id then
							tremove(CACHES, index);
						else
							INDICES[index] = index;
							index = index + 1;
						end
					end
					func_sort_cache(SORT_METHOD_BUYOUT, 1);
					_selected_index = nil;
					AuctionDisplayScroll:SetNumValue(#CACHES);
					local c1 = CACHES[INDICES[1]];
					if _finished and c1[index_buyoutPriceSingle] then
						set_price(nil, c1[index_buyoutPriceSingle], c1[index_owner] ~= PLAYER_NAME);
					end
				else
					CACHES = nil;
					_selected_index = nil;
					AuctionDisplayScroll:SetNumValue(0);
				end
			end
			local function AuctionDisplayButton_OnClick(self)
				local dataIndex = self:GetDataIndex();
				local index = INDICES[dataIndex]
				if CACHES[index] then
					set_price(nil, CACHES[index][index_buyoutPriceSingle], CACHES[index][index_owner] ~= PLAYER_NAME);
				end
			end
			local function AuctionDisplayButton_OnEnter(self)
				local dataIndex = self:GetDataIndex();
				local index = INDICES[dataIndex]
				if CACHES[index] then
					GameTooltip:SetOwner(self, "ANCHOR_TOP");
					GameTooltip:SetHyperlink(CACHES[index][index_link]);
					GameTooltip:Show();
				end
			end
			local function AuctionDisplayButton_OnLeave(self)
				if GameTooltip:IsOwned(self) then
					GameTooltip:Hide();
				end
			end
			local function funcToCreateButton_Auction(parent, index, buttonHeight)
				local button = CreateFrame("BUTTON", nil, parent, "BackdropTemplate");
				button:SetHeight(buttonHeight);
				button:SetBackdrop({
					bgFile = "Interface\\Buttons\\WHITE8X8",	-- "Interface\\Buttons\\WHITE8X8",	-- "Interface\\Tooltips\\UI-Tooltip-Background", -- "Interface\\ChatFrame\\ChatFrameBackground"
					edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
					tile = true,
					tileSize = 2,
					edgeSize = 2,
					insets = { left = 0, right = 0, top = 0, bottom = 0 }
				});
				button:SetBackdropColor(0.25, 0.25, 0.25, 0.5);
				button:SetBackdropBorderColor(0.0, 0.0, 0.0, 1.0);
				button:SetHighlightTexture("Interface\\FriendsFrame\\UI-FriendsFrame-HighlightBar");
				button:EnableMouse(true);
				button:Show();

				local icon = button:CreateTexture(nil, "ARTWORK");
				icon:SetTexture(UNK_TEXTURE);
				icon:SetSize(buttonHeight - 4, buttonHeight - 4);
				icon:SetPoint("LEFT", 5, 0);
				button.icon = icon;

				local count = button:CreateFontString(nil, "OVERLAY");
				count:SetFont(ui_style.frameFont, ui_style.smallFontSize, "NORMAL");
				count:SetJustifyH("CENTER");
				count:SetMaxLines(1);
				count:SetPoint("BOTTOMRIGHT", icon, "BOTTOMRIGHT", -1, -1);
				button.count = count;

				local title = button:CreateFontString(nil, "OVERLAY");
				title:SetFont(ui_style.frameFont, ui_style.frameFontSize, "NORMAL");
				title:SetWidth(160);
				title:SetJustifyH("LEFT");
				title:SetMaxLines(1);
				title:SetPoint("LEFT", icon, "RIGHT", 5, 0);
				button.title = title;

				local timeLeft = button:CreateFontString(nil, "OVERLAY");
				timeLeft:SetFont(ui_style.frameFont, ui_style.frameFontSize, "NORMAL");
				timeLeft:SetWidth(100);
				timeLeft:SetJustifyH("LEFT");
				timeLeft:SetMaxLines(1);
				timeLeft:SetPoint("LEFT", icon, "RIGHT", 170, 0);
				button.timeLeft = timeLeft;

				local owner = button:CreateFontString(nil, "OVERLAY");
				owner:SetFont(ui_style.frameFont, ui_style.frameFontSize, "NORMAL");
				owner:SetWidth(100);
				owner:SetJustifyH("LEFT");
				owner:SetMaxLines(1);
				owner:SetPoint("LEFT", icon, "RIGHT", 275, 0);
				button.owner = owner;

				local bid = button:CreateFontString(nil, "OVERLAY");
				bid:SetFont(ui_style.frameFont, ui_style.smallFontSize, "NORMAL");
				bid:SetWidth(170);
				bid:SetJustifyH("RIGHT");
				bid:SetMaxLines(1);
				bid:SetPoint("TOPLEFT", icon, "TOPRIGHT", 380, -2);
				button.bid = bid;

				local buyout = button:CreateFontString(nil, "OVERLAY");
				buyout:SetFont(ui_style.frameFont, ui_style.smallFontSize, "NORMAL");
				buyout:SetWidth(170);
				buyout:SetJustifyH("RIGHT");
				buyout:SetMaxLines(1);
				buyout:SetPoint("BOTTOMLEFT", icon, "BOTTOMRIGHT", 380, 2);
				button.buyout = buyout;

				button:SetScript("OnClick", AuctionDisplayButton_OnClick);
				button:SetScript("OnEnter", AuctionDisplayButton_OnEnter);
				button:SetScript("OnLeave", AuctionDisplayButton_OnLeave);

				return button;
			end
			local function functToSetButton_Auction(button, dataIndex)
				local index = INDICES[dataIndex]
				if CACHES and CACHES[index] then
					local data = CACHES[index];
					button.icon:SetTexture(data[index_texture]);
					button.count:SetText(data[index_count]);
					button.title:SetText(data[index_name]);
					local r, g, b, code = GetItemQualityColor(data[index_quality]);
					button.title:SetTextColor(r, g, b, 1);
					button.timeLeft:SetText(L["timeLeft"][data[index_timeLeft]]);
					if data[index_owner] == PLAYER_NAME then
						button.owner:SetText("\124cff00ff00" .. data[index_owner] .. "\124r");
					else
						button.owner:SetText(data[index_owner]);
					end
					button.bid:SetText(NS.MoneyString(data[index_bidPriceSingle]));
					if data[index_buyoutPriceSingle] and data[index_buyoutPriceSingle] < BIG_NUMBER then
						button.buyout:SetText(L["buyout"] .. NS.MoneyString(data[index_buyoutPriceSingle]));
					else
						button.buyout:SetText("");
					end
					button:Show();
					if GetMouseFocus() == button then
						AuctionDisplayButton_OnEnter(button);
					end
				else
					button:Hide();
				end
			end
			local function TimeDropDown_OnClick(self)
				AuctionFrameAuctions.duration = self.value;
				UIDropDownMenu_SetSelectedValue(AuctionFrameAuctions_Time, self.value);
				UpdateDeposit();
			end
			local function TimeDropDown_Initialize()
				local info = UIDropDownMenu_CreateInfo();
				info.text = "12" .. HOURS;
				info.value = 1;
				info.checked = nil;
				info.func = TimeDropDown_OnClick;
				UIDropDownMenu_AddButton(info);
				info.text = "24" .. HOURS;
				info.value = 2;
				info.checked = nil;
				info.func = TimeDropDown_OnClick;
				UIDropDownMenu_AddButton(info);
				info.text = "48" .. HOURS;
				info.value = 3;
				info.checked = nil;
				info.func = TimeDropDown_OnClick;
				UIDropDownMenu_AddButton(info);
			end
			local function hook_AuctionFrameAuctions()
				AuctionsItemText:ClearAllPoints();
				AuctionsItemText:SetPoint("TOPLEFT", 28, -78);
				AuctionsStackSizeEntry:Show();
				AuctionsStackSizeEntry:ClearAllPoints();
				AuctionsStackSizeEntry:SetPoint("TOPLEFT", AuctionFrameAuctions, "TOPLEFT", 33, -155);
				AuctionsStackSizeMaxButton:Show();
				AuctionsNumStacksEntry:Show();
				AuctionsNumStacksEntry:ClearAllPoints();
				AuctionsNumStacksEntry:SetPoint("TOPLEFT", AuctionsStackSizeEntry, "BOTTOMLEFT", 0, -20);
				AuctionsNumStacksMaxButton:Show();
				PriceDropDown:Show();
				PriceDropDown:ClearAllPoints();
				PriceDropDown:SetPoint("TOPRIGHT", AuctionFrameAuctions, "TOPLEFT", 217, -215);
				StartPrice:ClearAllPoints();
				StartPrice:SetPoint("BOTTOMLEFT", AuctionFrameAuctions, "BOTTOMLEFT", 30, 170);
				BuyoutPrice:ClearAllPoints();
				BuyoutPrice:SetPoint("BOTTOMLEFT", AuctionFrameAuctions, "BOTTOMLEFT", 30, 135);
				AuctionsDurationText:Hide();
				AuctionsShortAuctionButton:Hide();
				AuctionsMediumAuctionButton:Hide();
				AuctionsLongAuctionButton:Hide();
				AuctionsDurationText:SetAlpha(0);
				AuctionsShortAuctionButton:SetAlpha(0);
				AuctionsMediumAuctionButton:SetAlpha(0);
				AuctionsLongAuctionButton:SetAlpha(0);
				AuctionsShortAuctionButton:EnableMouse(false);
				AuctionsMediumAuctionButton:EnableMouse(false);
				AuctionsLongAuctionButton:EnableMouse(false);
				AuctionsTimeDropDown = CreateFrame("FRAME", "AuctionFrameAuctions_Time", AuctionFrameAuctions, "UIDropDownMenuTemplate");
				UIDropDownMenu_SetWidth(AuctionsTimeDropDown, 80);
				AuctionsTimeDropDown:SetScript("OnShow", function(self)
					UIDropDownMenu_Initialize(self, TimeDropDown_Initialize);
				end);
				UIDropDownMenu_SetSelectedValue(AuctionsTimeDropDown, AuctionFrameAuctions.duration);
				AuctionsTimeDropDown:SetPoint("TOPRIGHT", AuctionFrameAuctions, "TOPLEFT", 217, -320);
				local AuctionsTimeDropDown_Text = AuctionsTimeDropDown:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall");
				AuctionsTimeDropDown_Text:SetText(L["DURATION"]);
				AuctionsTimeDropDown_Text:SetPoint("LEFT", AuctionsTimeDropDown, "RIGHT", -192, 3);
				hooksecurefunc("AuctionFrameTab_OnClick", function(self, button, down, index)
					local index = self:GetID();
					if index == 3 then
						AuctionFrameBotLeft:SetTexture("Interface\\Addons\\alaTrade\\ARTWORK\\UI-AuctionFrame-Auction-BotLeft");
						UIDropDownMenu_SetSelectedValue(AuctionsTimeDropDown, AuctionFrameAuctions.duration);
					end
				end);
				AuctionsItemButton.stackCount = 0;
				AuctionsItemButton.totalCount = 0;
				--
				AuctionDisplay = CreateFrame("FRAME", nil, AuctionFrameAuctions, "BackdropTemplate");
				AuctionDisplay:SetSize(610, 360);
				AuctionDisplay:SetPoint("TOPRIGHT", AuctionFrameAuctions, "TOPRIGHT", 65, -50);
				AuctionDisplay:SetBackdrop({
					bgFile = "Interface\\Buttons\\WHITE8X8",	-- "Interface\\Buttons\\WHITE8X8",	-- "Interface\\Tooltips\\UI-Tooltip-Background", -- "Interface\\ChatFrame\\ChatFrameBackground"
					edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
					tile = true,
					tileSize = 2,
					edgeSize = 2,
					insets = { left = 0, right = 0, top = 0, bottom = 0, }
				});
				AuctionDisplay:SetBackdropColor(0.0, 0.0, 0.0, 1.0);
				AuctionDisplay:EnableMouse(true);
				AuctionDisplay:Show();
				AuctionDisplay:SetFrameLevel(255);
				AuctionDisplayScroll = ALASCR(AuctionDisplay, AuctionDisplay:GetWidth(), AuctionDisplay:GetHeight(), 36, funcToCreateButton_Auction, functToSetButton_Auction);
				AuctionDisplayScroll:SetPoint("BOTTOM", AuctionDisplay);
				AuctionDisplay:Hide();
				gui.AuctionDisplay = AuctionDisplay;
				--
			end
			local update_frame = CreateFrame("FRAME");
			local _name = nil;
			local function update_func()
				if NS.scan_normal(_name, true, true, NEW_AUCTION_UPDATE_CALLBACK) then
					update_frame:SetScript("OnUpdate", nil);
					_log_("NEW_AUCTION_UPDATE", _name, "sent");
				end
			end
			function NS.NEW_AUCTION_UPDATE(...)
				local name, texture, count, quality, canUse, price, pricePerUnit, stackCount, totalCount, itemID = GetAuctionSellItemInfo();
				_log_("NEW_AUCTION_UPDATE", name);
				CACHES = nil;
				_selected_index = nil;
				NS.abandon();
				if name then
					if C_WowTokenPublic.IsAuctionableWowToken(itemID) then
						AuctionsTimeDropDown:Hide();
					else
						AuctionsStackSizeEntry:Show();
						AuctionsStackSizeMaxButton:Show();
						AuctionsStackSizeMaxButton:Enable();
						AuctionsNumStacksEntry:Show();
						AuctionsNumStacksMaxButton:Show();
						AuctionsNumStacksMaxButton:Enable();
						PriceDropDown:Show();		
						AuctionsTimeDropDown:Show();
						AuctionsDurationText:Hide();
						AuctionsShortAuctionButton:Hide();
						AuctionsMediumAuctionButton:Hide();
						AuctionsLongAuctionButton:Hide();
						--
						AuctionDisplay:Show();
						AuctionDisplayScroll:SetNumValue(0);
						_name = name;
						_sell_item_id = itemID;
						update_frame:SetScript("OnUpdate", update_func);
						local start, buyout = NS.GetHistorySellPrice(itemID);
						if start and buyout then
							set_price(start, buyout);
						end
					end
				else
					-- _error_("NEW_AUCTION_UPDATE", "CLEARED");
					AuctionDisplay:Hide();
				end
			end
			--
			local function CacheAll_update(self)
				local t = GetServerTime() - SET.prev_cache_all;
				if t > 600 and select(2, CanSendAuctionQuery()) then
					_log_("FULL_SCAN_AVAILABLE", t, select(2, CanSendAuctionQuery()));
					self:Enable();
					self:SetText(L["CacheAll"]);
					self:SetScript("OnUpdate", nil);
				else
					t = SCAN_FULL_INTERVAL - t;
					self:SetText(format("%02d:%02d", floor(t / 60), (t % 60)));
				end
			end
			local function hook_Blizzard_AuctionUI()
				_EventHandler:RegEvent("AUCTION_ITEM_LIST_UPDATE");
				_EventHandler:RegEvent("AUCTION_HOUSE_SHOW");
				_EventHandler:RegEvent("AUCTION_HOUSE_CLOSED");
				_EventHandler:RegEvent("NEW_AUCTION_UPDATE");
		
				local CacheAll = CreateFrame("BUTTON", nil, AuctionFrame, "UIPanelButtonTemplate");
				CacheAll:SetSize(80, 22);
				CacheAll:SetText(L["CacheAll"]);
				CacheAll:SetPoint("RIGHT", AuctionFrameCloseButton, "LEFT", -6, 0);
				CacheAll:SetScript("OnClick", function()
					if NS.scan_full() then
						SET.prev_cache_all = GetServerTime();
						CacheAll:Disable();
						CacheAll:SetScript("OnUpdate", CacheAll_update);
					end
				end);
				if select(2, CanSendAuctionQuery()) then
					CacheAll:Enable();
					CacheAll:SetScript("OnUpdate", nil);
				else
					SET.prev_cache_all = SET.prev_cache_all or GetServerTime();
					CacheAll:Disable();
					CacheAll:SetScript("OnUpdate", CacheAll_update);
				end
				gui.CacheAll = CacheAll;
				--
				local configButton = CreateFrame("BUTTON", nil, AuctionFrame, "UIPanelButtonTemplate");
				configButton:SetSize(80, 22);
				configButton:SetText(L["configButton"]);
				configButton:SetPoint("BOTTOM", CacheAll, "TOP", 0, 2);
				configButton:SetScript("OnClick", function()
					NS.toggle_config();
				end);
				gui.configButton = configButton;
				--
				SearchProgress = CreateFrame("STATUSBAR", nil, AuctionFrame, "BackdropTemplate");
				SearchProgress:SetHeight(16);
				SearchProgress:SetPoint("TOP", CacheAll, 0, -3);
				SearchProgress:SetPoint("RIGHT", CacheAll, "LEFT", -5, 0);
				SearchProgress:SetPoint("LEFT", 75, 0);
				SearchProgress:SetStatusBarTexture("Interface\\targetingframe\\ui-statusbar", "BACKGROUND");
				SearchProgress:SetBackdrop({
					bgFile = nil,	-- "Interface\\Buttons\\WHITE8X8",	-- "Interface\\Tooltips\\UI-Tooltip-Background", -- "Interface\\ChatFrame\\ChatFrameBackground"
					edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
					tile = true,
					tileSize = 2,
					edgeSize = 2,
					insets = { left = 8, right = 8, top = 8, bottom = 8, }
				});
				SearchProgress:SetBackdropBorderColor(1.0, 1.0, 1.0, 1.0);
				SearchProgress:Show();
				SearchProgress:EnableMouse(false);
				SearchProgress:SetValue(0);
				SearchProgress:Hide();
				-- SearchProgress:SetStatusBarColor(0.0, 1.0, 0.0, 0.5);
				SearchProgress:SetMinMaxValues(0, 1);
				SearchProgress:SetValue(0);
				gui.SearchProgress = SearchProgress;
				--
				--
				hook_AuctionFrameAuctions();
				hook_AuctionFrameBrowse();
				if IsAddOnLoaded("ElvUI") then
					NS.ElvUI();
				end
				--
				AuctionFrameAuctions.priceType = PRICE_TYPE_UNIT;
			end
			function NS.hook_Blizzard_AuctionUI()
				if IsAddOnLoaded("Blizzard_AuctionUI") then
					hook_Blizzard_AuctionUI();
					NS.CreateBaudAuctionFrame(SET.BaudAuctionFrame);
				else
					local frame = CreateFrame("FRAME");
					frame:RegisterEvent("ADDON_LOADED");
					frame:SetScript("OnEvent", function(self, event, addon)
						if addon == "Blizzard_AuctionUI" then
							hook_Blizzard_AuctionUI();
							NS.CreateBaudAuctionFrame(SET.BaudAuctionFrame);
							frame:UnregisterAllEvents();
							frame:SetScript("OnEvent", nil);
							frame = nil;
						end
					end);
				end
			end
		end

		ALA_HOOK_ChatEdit_InsertLink(function(link, ...)
			if BrowseName and BrowseName:IsVisible() then
				if strfind(link, "item:", 1, true) then
					local name = GetItemInfo(link);
					if name and name ~= "" then
						BrowseName:SetText(name);
						-- QueryAuctionItems(name, BrowseMinLevel:GetNumber(), BrowseMaxLevel:GetNumber(), 0, IsUsableCheckButton:GetChecked(), BrowseDropDown.selectedValue, false, nil, nil);
						SCAN_UI();
						return true;
					end
				end
			end
		end);
		ALA_HOOK_ChatEdit_InsertName(function(name)
			if BrowseName and BrowseName:IsVisible() then
				if name and name ~= "" then
					BrowseName:SetText(name);
					-- QueryAuctionItems(name, BrowseMinLevel:GetNumber(), BrowseMaxLevel:GetNumber(), 0, IsUsableCheckButton:GetChecked(), BrowseDropDown.selectedValue, false, nil, nil);
					SCAN_UI();
					return true;
				end
			end
		end);
		function NS.PLAYER_LOGIN()
			SET.prev_cache_all = -1;
		end
		function NS.PLAYER_LOGOUT()
			-- SET.prev_cache_all = -1;
		end
	end

	do	--	UI
		local uimethod = {  };
		local ui = nil;
		local configFrame = nil;
		local SORT_METHOD_ID = 1;
		local SORT_METHOD_QUALITY = 2;
		local SORT_METHOD_NAME = 3;
		local SORT_METHOD_PRICE = 4;
		local SORT_METHOD_TIME = 5;
		local SORT_METHOD_LEVEL = 6;
		local W = 360;
		local H = 240;
		local w = 1;
		local N = W / w;
		local COLOR_PRICE_1 = { 0.0, 1.0, 0.0, 1.0, };
		local COLOR_PRICE_2 = { 1.0, 0.0, 0.0, 1.0, };
		local COLOR_LINE = { 0.75, 0.75, 0.25, 1.0, };
		local function graph_OnUpdate(self, elasped)
			local l, r, t, b = self:GetLeft(), self:GetRight(), self:GetTop(), self:GetBottom();
			local x, y = GetCursorPosition();
			local s = self:GetEffectiveScale();
			x = x / s;
			y = y / s;
			local focus_h = self.focus_h;
			local focus_w = self.focus_w;
			local tip = self.tip;
			if x >= l and x <= r and y >= b and y <= t then
				x = x - l;
				y = y - b;
				local w = r - l;
				local h = t - b;
				local pos = x / w * N;
				focus_h:SetPoint("LEFT", pos, 0);
				focus_h:Show();
				local meta = self.list;
				local pos_time = self.minHVal + (self.maxHVal - self.minHVal) * pos / W;
				local index = nil;
				for i = 1, meta[0] do
					if meta[i][1] >= pos_time then
						if i == 1 or meta[i - 1][2] == nil then
							focus_w:SetPoint("BOTTOM", 0, 0);
						else
							local p = floor((meta[i - 1][2] - self.minVVal) / (self.maxVVal - self.minVVal) * H);
							focus_w:SetPoint("BOTTOM", 0, p);
						end
						index = i - 1;
						break;
					end
				end
				if not index then
					if meta[meta[0]][2] then
						local p = floor((meta[meta[0]][2] - self.minVVal) / (self.maxVVal - self.minVVal) * H);
						focus_w:SetPoint("BOTTOM", 0, p);
					else
						focus_w:SetPoint("BOTTOM", 0, 0);
					end
					index = meta[0];
				end
				if index then
					focus_w:Show();
					tip:ClearAllPoints();
					if y * 2 > (t - b) then
						if x * 2 > (r - l) then
							tip:SetPoint("BOTTOMLEFT", 4, 24);
						else
							tip:SetPoint("BOTTOMRIGHT", - 4, 24);
						end
					else
						if x * 2 > (r - l) then
							tip:SetPoint("TOPLEFT", 4, - 24);
						else
							tip:SetPoint("TOPRIGHT", - 4, - 24);
						end
					end
					local info = meta[index];
					if index ~= 0 and info[2] then
						tip:SetText(NS.MoneyString(info[2]) .. "\n" .. L["ITEM_COUNT"] .. info[3] .. "\n" .. NS.seconds_to_formatted_time(info[1]));
					else
						tip:SetText(L["PRCIE_NOT_CACHED"]);
					end
				end
			else
				focus_h:Hide();
				focus_w:Hide();
				tip:SetText("");
				tip:ClearAllPoints();
				tip:SetPoint("CENTER");
			end
		end
		local function round_price(copper)
			local units = { 10000, 100, };
			for i = 1, #units do
				local int = copper / units[i];
				if int >= 1 and int <= 99 then
					return floor(int) * units[i], ceil(int) * units[i];
				end
			end
			local units2 = { 100000000, 10000000, 1000000, 100000, 1000, 10 };
			for i = 1, #units2 do
				local int = copper / units2[i];
				if int >= 10 and int <= 99 then
					return floor(int) * units2[i], ceil(int) * units2[i];
				end
			end
			return copper, copper;
		end
		local function graph_SetValue(graph, meta, minHVal, maxHVal, minVVal, maxVVal)
			-- { { time, data_price, count, }, }
			local n = meta[0];
			local cells = graph.cells;
			if n == 0 then
				for j = 1, N do
					cells[j]:SetPoint("BOTTOM", 0);
					cells[j]:SetColorTexture(1.0, 0.0, 0.0, 1.0);
				end
				graph.title:SetText(nil);
				graph.minH:SetText(nil);
				graph.maxH:SetText(nil);
				graph.minV:SetText(nil);
				graph.maxV:SetText(nil);
				return;
			end
			local curPrice = meta[n][2];
			local lastTime = meta[n][1];
			local curTime = GetServerTime();
			if not minVVal or not maxVVal then
				if n == 1 then
					minVVal = minVVal or 0;
					maxVVal = maxVVal or curPrice and curPrice * 2 or 1;
				else
					local minPrice = curPrice;
					local maxPrice = curPrice or 0;
					for i = 1, n - 1 do
						if meta[i][2] then
							if meta[i][2] > maxPrice then
								maxPrice = meta[i][2];
							elseif minPrice == nil or meta[i][2] < minPrice then
								minPrice = meta[i][2];
							end
						end
					end
					minVVal = minVVal or minPrice or 0;
					maxVVal = maxVVal or maxPrice or 1;
				end
			end
			if minVVal == maxVVal then
				maxVVal = max(minVVal * 2, 1);
				minVVal = 0;
			else
				minVVal = max(0, floor(minVVal - (maxVVal - minVVal) / 4));
				maxVVal = floor(maxVVal + (maxVVal - minVVal) / 4);
			end
			minVVal = round_price(minVVal);
			_, maxVVal = round_price(maxVVal);

			if not minHVal or not maxHVal then
				if i == 1 then
					minHVal = minHVal or lastTime;
					maxHVal = maxHVal or curTime;
				else
					local minTime = lastTime;
					local maxTime = lastTime;
					for i = 1, n - 1 do
						if meta[i][1] > maxTime then
							maxTime = meta[i][1];
						elseif meta[i][1] < minTime then
							minTime = meta[i][1];
						end
					end
					minHVal = minHVal or minTime;
					maxHVal = maxHVal or maxTime;
				end
			end
			-- if minHVal == maxHVal then
				-- maxHVal = max(minHVal * 2, 1);
				-- minHVal = 0;
			-- else
				-- minHVal = max(0, floor(minHVal - (maxHVal - minHVal) / 4));
				-- maxHVal = floor(maxHVal + (maxHVal - minHVal) / 4);
			-- end
			maxHVal = (floor((max(maxHVal, curTime) + time_zone_ofs * 3600) / 86400) + 1) * 86400 - time_zone_ofs * 3600;
			local info = meta.id and cache[meta.id];
			if info then
				graph.title:SetText("\124c" .. (select(4, GetItemQualityColor(info[index_quality])) or "ffffffff") .. (info[index_name] or ("ITEM" .. meta.id)) .. "\124r");
			end
			graph.minH:SetText(NS.seconds_to_formatted_time(minHVal));
			graph.maxH:SetText(NS.seconds_to_formatted_time(maxHVal));
			graph.minV:SetText(NS.MoneyString(minVVal));
			graph.maxV:SetText(NS.MoneyString(maxVVal));
			maxVVal = max(maxVVal, 1);
			minVVal = max(minVVal, 0);
			local rangeV = maxVVal - minVVal;
			local rangeH = maxHVal - minHVal;
			graph.minHVal = minHVal;
			graph.maxHVal = maxHVal;
			graph.minVVal = minVVal;
			graph.maxVVal = maxVVal;
			local prevEnd = 0;
			local prevprevEnd = 0;
			local prevP = 0;
			local prevprevP = 0;
			for i = 1, n do
				if prevEnd == prevprevEnd then
					prevP = prevprevP;
				end
				if i == 1 then
					local v1 = meta[1];
					local s = prevEnd + 1;
					prevEnd = floor((v1[1] - minHVal + 1) / rangeH * N);
					for j = s, prevEnd do
						cells[j]:SetSize(w, w);
						cells[j]:SetPoint("BOTTOM", 0, 0);
						cells[j]:SetColorTexture(COLOR_PRICE_2[1], COLOR_PRICE_2[2], COLOR_PRICE_2[3], COLOR_PRICE_2[4]);
					end
				else
					local v1 = meta[i - 1];
					local v2 = meta[i];
					local s = prevEnd + 1;
					prevprevEnd = prevEnd;
					prevEnd = floor((v2[1] - minHVal + 1) / rangeH * N);
					if v1[2] then
						local p = floor((v1[2] - minVVal) / rangeV * H);
						if p > prevP then
							cells[s]:SetSize(w, p - prevP + 1);
							cells[s]:SetPoint("BOTTOM", 0, prevP);
							cells[s]:SetColorTexture(COLOR_PRICE_1[1], COLOR_PRICE_1[2], COLOR_PRICE_1[3], COLOR_PRICE_1[4]);
						elseif p < prevP then
							cells[s]:SetSize(w, prevP - p + 1);
							cells[s]:SetPoint("BOTTOM", 0, p);
							cells[s]:SetColorTexture(COLOR_PRICE_1[1], COLOR_PRICE_1[2], COLOR_PRICE_1[3], COLOR_PRICE_1[4]);
						else
							cells[s]:SetSize(w, w);
							cells[s]:SetPoint("BOTTOM", 0, p);
							cells[s]:SetColorTexture(COLOR_PRICE_1[1], COLOR_PRICE_1[2], COLOR_PRICE_1[3], COLOR_PRICE_1[4]);
						end
						prevprevP = prevP;
						prevP = p;
						for j = s + 1, prevEnd do
							-- cells[j]:ClearAllPoints();
							cells[j]:SetSize(w, w);
							cells[j]:SetPoint("BOTTOM", 0, p);
							-- cells[j]:SetPoint("LEFT", (j - 1) * w, 0);
							cells[j]:SetColorTexture(COLOR_PRICE_1[1], COLOR_PRICE_1[2], COLOR_PRICE_1[3], COLOR_PRICE_1[4]);
						end
					else
						cells[s]:SetSize(w, prevP + 1);
						cells[s]:SetPoint("BOTTOM", 0, 0);
						cells[s]:SetColorTexture(COLOR_PRICE_2[1], COLOR_PRICE_2[2], COLOR_PRICE_2[3], COLOR_PRICE_2[4]);
						prevprevP = prevP;
						prevP = 0;
						for j = s + 1, prevEnd do
							-- cells[j]:ClearAllPoints();
							cells[j]:SetSize(w, w);
							cells[j]:SetPoint("BOTTOM", 0, 0);
							-- cells[j]:SetPoint("LEFT", (j - 1) * w, 0);
							cells[j]:SetColorTexture(COLOR_PRICE_2[1], COLOR_PRICE_2[2], COLOR_PRICE_2[3], COLOR_PRICE_2[4]);
						end
					end
				end
			end
			do
				local v1 = meta[n];
				local s = prevEnd + 1;
				prevprevEnd = prevEnd;
				prevEnd = N;
				if s < N then
					if v1[2] then
						local p = floor((v1[2] - minVVal) / rangeV * H);
						if p > prevP then
							cells[s]:SetSize(w, p - prevP + 1);
							cells[s]:SetPoint("BOTTOM", 0, prevP);
							cells[s]:SetColorTexture(COLOR_PRICE_1[1], COLOR_PRICE_1[2], COLOR_PRICE_1[3], COLOR_PRICE_1[4]);
						elseif p < prevP then
							cells[s]:SetSize(w, prevP - p + 1);
							cells[s]:SetPoint("BOTTOM", 0, p);
							cells[s]:SetColorTexture(COLOR_PRICE_1[1], COLOR_PRICE_1[2], COLOR_PRICE_1[3], COLOR_PRICE_1[4]);
						else
							cells[s]:SetSize(w, w);
							cells[s]:SetPoint("BOTTOM", 0, p);
							cells[s]:SetColorTexture(COLOR_PRICE_1[1], COLOR_PRICE_1[2], COLOR_PRICE_1[3], COLOR_PRICE_1[4]);
						end
						prevprevP = prevP;
						prevP = p;
						for j = s + 1, prevEnd do
							-- cells[j]:ClearAllPoints();
							cells[j]:SetSize(w, w);
							cells[j]:SetPoint("BOTTOM", 0, p);
							-- cells[j]:SetPoint("LEFT", (j - 1) * w, 0);
							cells[j]:SetColorTexture(COLOR_PRICE_1[1], COLOR_PRICE_1[2], COLOR_PRICE_1[3], COLOR_PRICE_1[4]);
						end
					else
						cells[s]:SetSize(w, prevP + 1);
						cells[s]:SetPoint("BOTTOM", 0, 0);
						cells[s]:SetColorTexture(COLOR_PRICE_2[1], COLOR_PRICE_2[2], COLOR_PRICE_2[3], COLOR_PRICE_2[4]);
						prevprevP = prevP;
						prevP = 0;
						for j = s + 1, prevEnd do
							-- cells[j]:ClearAllPoints();
							cells[j]:SetSize(w, w);
							cells[j]:SetPoint("BOTTOM", 0, 0);
							-- cells[j]:SetPoint("LEFT", (j - 1) * w, 0);
							cells[j]:SetColorTexture(COLOR_PRICE_2[1], COLOR_PRICE_2[2], COLOR_PRICE_2[3], COLOR_PRICE_2[4]);
						end
					end
				end
			end
			if curPrice then
				local p = floor((curPrice - minVVal) / rangeV * H);
				graph.curIndicator:SetPoint("BOTTOM", 0, p);
				graph.curPrice:SetText(NS.MoneyString_Dec(curPrice));
				graph.curIndicator:Show();
				graph.curPrice:Show();
			else
				graph.curIndicator:Hide();
				graph.curPrice:Hide();
			end
		end
		local function DBIcon_OnClick(self, button)
			if button == "LeftButton" then
				if ui:IsShown() then
					ui:Hide();
				else
					ui:Show();
				end
			else
				NS.toggle_config();
			end
		end
		local function button_OnEnter(self)
			local list = self.list;
			local data_index = self:GetDataIndex();
			if data_index <= #list then
				local id = list[data_index];
				GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
				GameTooltip:SetItemByID(id);
				GameTooltip:Show();
			else
				GameTooltip:Hide();
			end
		end
		local function button_OnLeave(self)
			if GameTooltip:IsOwned(self) then
				GameTooltip:Hide();
			end
		end
		local function insert_meta(meta, n, v1, v2, v3)
			meta[n] = meta[n] or {  };
			meta[n][1] = v1;
			meta[n][2] = v2;
			meta[n][3] = v3;
		end
		local function button_OnClick(self, button)
			local list = self.list;
			local data_index = self:GetDataIndex();
			if data_index <= #list then
				local id = list[data_index];
				local info = cache[id];
				if info then
					info[index_link] = select(2, GetItemInfo(id)) or info[index_link];
					if IsShiftKeyDown() then
						ChatEdit_InsertLink(info[index_link] or info[index_name], ADDON);
					elseif IsAltKeyDown() then
						local p, t = NS.query_ah_price_by_id(id, true);
						local editBox = ChatEdit_ChooseBoxForSend();
						editBox:Show();
						editBox:SetFocus();
						if info[index_buyoutPriceSingle] then
							editBox:Insert((info[index_link] or info[index_name]) .. " " .. L["PRICE"] .. NS.MoneyString_Dec_Char(info[index_buyoutPriceSingle]) .. " " .. L["CACHE_TIME"] .. NS.seconds_to_formatted_time_len(GetServerTime() - info[index_cacheTime]));
						else
							if p then
								editBox:Insert((info[index_link] or info[index_name]) .. " " .. L["HISTORY_PRICE"] .. NS.MoneyString_Dec_Char(p) .. " " .. L["CACHE_TIME"] .. NS.seconds_to_formatted_time_len(t));
							else
								editBox:Insert((info[index_link] or info[index_name]) .. " " .. L["PRCIE_NOT_CACHED"]);
							end
						end
					elseif IsControlKeyDown() then
						--	IsDressableItem
						local link = info[index_link];
						if link then
							DressUpItemLink(link);
						end
					elseif button == "LeftButton" then
						if SET.cache_history then
							local meta = ui.graph.list;
							local n = 0;
							local H = info[index_history];
							if H then
								for i = 1, #H do
									n = n + 1;
									insert_meta(meta, n, H[i][3], H[i][1], H[i][2]);
								end
							end
							if info[index_cacheTime] then
								n = n + 1;
								insert_meta(meta, n, info[index_cacheTime], info[index_buyoutPriceSingle], info[index_count]);
							end
							meta[0] = n;
							meta.id = id;
							ui.graph_container:Show();
							graph_SetValue(ui.graph, meta);
						end
					else
						FAV[id] = FAV[id] == nil and true or nil;
						uimethod.func_update_ui();
					end
				end
			end
		end
		local button_elements_width = {
			[SORT_METHOD_ID] = 60,
			[SORT_METHOD_NAME] = 100,
			[SORT_METHOD_QUALITY] = 65,
			[SORT_METHOD_LEVEL] = 40,
			[SORT_METHOD_PRICE] = 180,
			[SORT_METHOD_TIME] = 140,
		};
		local ui_width = 4 + 4 -2 + 24; for _, w in next, button_elements_width do ui_width = ui_width + w + 2; end
		local function funcToCreateButton(parent, index, buttonHeight)
			local Button = CreateFrame("BUTTON", nil, parent, "BackdropTemplate");
			Button:SetHeight(buttonHeight);
			Button:SetBackdrop(ui_style.buttonBackdrop);
			Button:SetBackdropColor(unpack(ui_style.buttonBackdropColor));
			Button:SetBackdropBorderColor(unpack(ui_style.buttonBackdropBorderColor));
			Button:SetHighlightTexture("Interface\\FriendsFrame\\UI-FriendsFrame-HighlightBar");
			Button:EnableMouse(true);
			Button:Show();

			local itemID = Button:CreateFontString(nil, "OVERLAY");
			itemID:SetFont(ui_style.frameFont, ui_style.frameFontSize, ui_style.frameFontOutline);
			itemID:SetPoint("LEFT", 2, 0);
			itemID:SetWidth(button_elements_width[SORT_METHOD_ID]);
			itemID:SetMaxLines(1);
			itemID:SetJustifyH("LEFT");
			Button.itemID = itemID;

			local icon = Button:CreateTexture(nil, "BORDER");
			icon:SetTexture(UNK_TEXTURE);
			icon:SetSize(buttonHeight - 2, buttonHeight - 2);
			icon:SetPoint("LEFT", itemID, "RIGHT", 2, 0);
			Button.icon = icon;

			local name = Button:CreateFontString(nil, "OVERLAY");
			name:SetFont(ui_style.frameFont, ui_style.frameFontSize, ui_style.frameFontOutline);
			name:SetPoint("LEFT", icon, "RIGHT", 2, 0);
			name:SetWidth(button_elements_width[SORT_METHOD_NAME] + button_elements_width[SORT_METHOD_QUALITY] + 2 - buttonHeight);
			name:SetMaxLines(1);
			name:SetJustifyH("LEFT");
			Button.name = name;

			local level = Button:CreateFontString(nil, "OVERLAY");
			level:SetFont(ui_style.frameFont, ui_style.frameFontSize, ui_style.frameFontOutline);
			level:SetPoint("LEFT", name, "RIGHT", 2, 0);
			level:SetWidth(button_elements_width[SORT_METHOD_LEVEL]);
			level:SetMaxLines(1);
			level:SetJustifyH("LEFT");
			Button.level = level;

			local buyoutPriceSingle = Button:CreateFontString(nil, "ARTWORK");
			buyoutPriceSingle:SetFont(ui_style.frameFont, ui_style.frameFontSize, ui_style.frameFontOutline);
			buyoutPriceSingle:SetPoint("LEFT", level, "RIGHT", 2, 0);
			buyoutPriceSingle:SetWidth(button_elements_width[SORT_METHOD_PRICE]);
			buyoutPriceSingle:SetMaxLines(1);
			buyoutPriceSingle:SetJustifyH("RIGHT");
			Button.buyoutPriceSingle = buyoutPriceSingle;

			local cache_time = Button:CreateFontString(nil, "OVERLAY");
			cache_time:SetFont(ui_style.frameFont, ui_style.frameFontSize, ui_style.frameFontOutline);
			cache_time:SetPoint("LEFT", buyoutPriceSingle, "RIGHT", 2, 0);
			cache_time:SetWidth(button_elements_width[SORT_METHOD_TIME]);
			cache_time:SetMaxLines(1);
			cache_time:SetJustifyH("RIGHT");
			Button.cache_time = cache_time;

			local quality_glow = Button:CreateTexture(nil, "ARTWORK");
			quality_glow:SetTexture("Interface\\Buttons\\UI-ActionButton-Border");
			quality_glow:SetBlendMode("ADD");
			quality_glow:SetTexCoord(0.25, 0.75, 0.25, 0.75);
			quality_glow:SetSize(buttonHeight - 2, buttonHeight - 2);
			quality_glow:SetPoint("CENTER", icon);
			-- quality_glow:SetAlpha(0.75);
			quality_glow:Show();
			Button.quality_glow = quality_glow;

			local glow = Button:CreateTexture(nil, "OVERLAY");
			glow:SetTexture("Interface\\Buttons\\WHITE8X8");
			-- glow:SetTexCoord(0.25, 0.75, 0.25, 0.75);
			glow:SetVertexColor(0.25, 0.25, 0.25, 0.75);
			glow:SetAllPoints();
			glow:SetBlendMode("ADD");
			glow:Hide();
			Button.glow = glow;

			local Star = Button:CreateTexture(nil, "OVERLAY");
			Star:SetTexture("interface\\collections\\collections");
			Star:SetTexCoord(100 / 512, 118 / 512, 10 / 512, 28 / 512);
			Star:SetSize(buttonHeight * 0.75, buttonHeight * 0.75);
			Star:SetPoint("CENTER", Button, "TOPLEFT", buttonHeight * 0.25, -buttonHeight * 0.25);
			Star:Hide();
			Button.Star = Star;

			Button:SetScript("OnEnter", button_OnEnter);
			Button:SetScript("OnLeave", button_OnLeave);
			Button:RegisterForClicks("AnyUp");
			Button:SetScript("OnClick", button_OnClick);
			Button:RegisterForDrag("LeftButton");
			Button:SetScript("OnHide", function()
				ALADROP(Button);
			end);

			function Button:Select()
				glow:Show();
			end
			function Button:Deselect()
				glow:Hide();
			end

			local frame = parent:GetParent():GetParent();
			Button.frame = frame;
			Button.list = frame.list;
			Button.searchEdit = frame.searchEdit;

			return Button;
		end
		local function funcToSetButton(Button, data_index)
			local list = Button.list;
			ALADROP(Button);
			if data_index <= #list then
				local id = list[data_index];
				local info = cache[id];
				if info then
					Button.itemID:SetText(id);
					Button.icon:SetTexture(info[index_texture]);
					Button.name:SetText((info[index_name] == nil or info[index_name] == "") and ("ITEM" .. id) or info[index_name]);
					if info[index_level] >= 0 then
						Button.level:SetText(info[index_level]);
					else
						Button.level:SetText(nil);
					end
					if info[index_buyoutPriceSingle] then
						Button.buyoutPriceSingle:SetText(NS.MoneyString_Dec(info[index_buyoutPriceSingle]));
						Button.cache_time:SetText(NS.seconds_to_colored_formatted_time_len(GetServerTime() - info[index_cacheTime]));
					else
						local H = info[index_history];
						local found_valid = false;
						if H then
							for i = #H, 1, -1 do
								if H[i][1] then
									found_valid = true;
									Button.buyoutPriceSingle:SetText(NS.MoneyString_Dec(H[i][1]));
									Button.cache_time:SetText(NS.seconds_to_colored_formatted_time_len(GetServerTime() - H[i][3]));
									break;
								end
							end
						end
						if not found_valid then
							Button.buyoutPriceSingle:SetText(L["UNKOWN"]);
							Button.cache_time:SetText(L["TIME_NA"]);
						end
					end
					if info[index_quality] then
						local r, g, b, code = GetItemQualityColor(info[index_quality]);
						Button.name:SetTextColor(r, g, b, 1);
						Button.quality_glow:SetVertexColor(r, g, b);
						Button.quality_glow:Show();
					else
						Button.name:SetTextColor(1, 1, 1, 1);
						Button.quality_glow:Hide();
					end
					Button:Show();
					if FAV[id] then
						Button.Star:Show();
					else
						Button.Star:Hide();
					end
					if GetMouseFocus() == Button then
						button_OnEnter(Button);
					end
				else
					Button:Hide();
				end
			else
				Button:Hide();
			end
		end
		local t_sort_method = {
			[SORT_METHOD_ID] = {
				[true] = function(v1, v2)
					return (FAV[v1] ~= nil and FAV[v2] == nil) or ((FAV[v1] ~= nil or FAV[v2] == nil) and (v1 < v2));
				end,
				[false] = function(v1, v2)
					return (FAV[v1] ~= nil and FAV[v2] == nil) or ((FAV[v1] ~= nil or FAV[v2] == nil) and (v1 > v2));
				end,
			},
			SORT_METHOD_QUALITY = {
				[true] = function(v1, v2)
					return (FAV[v1] ~= nil and FAV[v2] == nil) or ((FAV[v1] ~= nil or FAV[v2] == nil) and (cache[v1][index_quality] < cache[v2][index_quality]));
				end,
				[false] = function(v1, v2)
					return (FAV[v1] ~= nil and FAV[v2] == nil) or ((FAV[v1] ~= nil or FAV[v2] == nil) and (cache[v1][index_quality] > cache[v2][index_quality]));
				end,
			},
			SORT_METHOD_NAME = {
				[true] = function(v1, v2)
					return (FAV[v1] ~= nil and FAV[v2] == nil) or ((FAV[v1] ~= nil or FAV[v2] == nil) and (cache[v1][index_name] < cache[v2][index_name]));
				end,
				[false] = function(v1, v2)
					return (FAV[v1] ~= nil and FAV[v2] == nil) or ((FAV[v1] ~= nil or FAV[v2] == nil) and (cache[v1][index_name] > cache[v2][index_name]));
				end,
			},
			SORT_METHOD_PRICE = {
				[true] = function(v1, v2)
					return (FAV[v1] ~= nil and FAV[v2] == nil) or ((FAV[v1] ~= nil or FAV[v2] == nil) and ((NS.query_ah_price_by_id(v1, true) or BIG_NUMBER) < (NS.query_ah_price_by_id(v2, true) or BIG_NUMBER)));
				end,
				[false] = function(v1, v2)
					return (FAV[v1] ~= nil and FAV[v2] == nil) or ((FAV[v1] ~= nil or FAV[v2] == nil) and ((NS.query_ah_price_by_id(v1, true) or BIG_NUMBER) > (NS.query_ah_price_by_id(v2, true) or BIG_NUMBER)));
				end,
			},
			SORT_METHOD_TIME = {
				[true] = function(v1, v2)
					return (FAV[v1] ~= nil and FAV[v2] == nil) or ((FAV[v1] ~= nil or FAV[v2] == nil) and ((NS.query_last_cache_time_by_id(v1) or -1) < (NS.query_last_cache_time_by_id(v2) or -1)));
				end,
				[false] = function(v1, v2)
					return (FAV[v1] ~= nil and FAV[v2] == nil) or ((FAV[v1] ~= nil or FAV[v2] == nil) and ((NS.query_last_cache_time_by_id(v1) or -1) > (NS.query_last_cache_time_by_id(v2) or -1)));
				end,
			},
			SORT_METHOD_LEVEL = {
				[true] = function(v1, v2)
					return (FAV[v1] ~= nil and FAV[v2] == nil) or ((FAV[v1] ~= nil or FAV[v2] == nil) and (cache[v1][index_level] < cache[v2][index_level]));
				end,
				[false] = function(v1, v2)
					return (FAV[v1] ~= nil and FAV[v2] == nil) or ((FAV[v1] ~= nil or FAV[v2] == nil) and (cache[v1][index_level] > cache[v2][index_level]));
				end,
			},
		};
		function uimethod.func_sort_list(list, sort_method, sort_method_seq)
			if sort_method then
				local method = t_sort_method[sort_method];
				if method then
					sort(list, method[sort_method_seq > 0]);
				end
			end
		end
		function uimethod.process_search(list, cache, str)
			local top = 0;
			if SET.showEmpty then
				if SET.searchNameOnly then
					for id, info in next, cache do
						if (info[index_name] and strfind(info[index_name], str)) then
							top = top + 1;
							list[top] = id;
						end
					end
				else
					for id, info in next, cache do
						if (info[index_name] and strfind(info[index_name], str)) or strfind(id, str) then
							top = top + 1;
							list[top] = id;
						end
					end
				end
			else
				if SET.searchNameOnly then
					for id, info in next, cache do
						if (NS.query_ah_price_by_id(id, true) ~= nil) and ((info[index_name] and strfind(info[index_name], str))) then
							top = top + 1;
							list[top] = id;
						end
					end
				else
					for id, info in next, cache do
						if (NS.query_ah_price_by_id(id, true) ~= nil) and ((info[index_name] and strfind(info[index_name], str)) or strfind(id, str)) then
							top = top + 1;
							list[top] = id;
						end
					end
				end
			end
		end
		function uimethod.func_update_ui()
			if not ui:IsShown() then
				return;
			end
			local list = ui.list;
			wipe(list);
			local str = ui.searchEdit:GetText();
			if str and str ~= "" then
				if SET.regular_exp then
					local result, ret = pcall(uimethod.process_search, list, cache, str);
					if result then
						ui:SearchEditValid();
					else
						ui:SearchEditInvalid();
					end
				else
					str = gsub(strlower(str), "[%^%$%%%.%+%-%*%?%[%]%(%)]","%%%1");
					uimethod.process_search(list, cache, str);
					ui:SearchEditValid();
				end
			else
				local top = 0;
				for id, info in next, cache do
					if NS.query_ah_price_by_id(id, true) ~= nil or SET.showEmpty then
						top = top + 1;
						list[top] = id;
					end
				end
				ui:SearchEditValid();
			end
			uimethod.func_sort_list(list, SET.sort_method, SET.sort_method_seq);
			ui.scroll:SetNumValue(#list);
			ui.scroll:Update();
		end
		function NS.ui_scroll_Update()
			ui.scroll:Update();
		end
		local function sortButton_OnClick(self)
			local method = self.method;
			if method == SET.sort_method then
				SET.sort_method_seq = - SET.sort_method_seq;
			else
				SET.sort_method = method;
			end
			for _, button in next, self.sortButtons do
				if button == self then
					button.texture:SetColorTexture(0.75, 0.75, 0.25, 0.5);
					button.seq:Show();
					if SET.sort_method_seq > 0 then
						button.seq:SetTexture("interface\\buttons\\arrow-down-up");
					else
						button.seq:SetTexture("interface\\buttons\\arrow-up-up");
					end
				else
					button.texture:SetColorTexture(0.25, 0.25, 0.25, 0.5);
					button.seq:Hide();
				end
			end
			uimethod.func_update_ui();
		end
		local function sortButton_OnShow(self)
			if SET and SET.sort_method == method then
				self.texture:SetColorTexture(0.75, 0.75, 0.25, 0.5);
				self.seq:Show();
				if SET.sort_method_seq > 0 then
					self.seq:SetTexture("interface\\buttons\\arrow-down-up");
				else
					self.seq:SetTexture("interface\\buttons\\arrow-up-up");
				end
			else
				self.texture:SetColorTexture(0.25, 0.25, 0.25, 0.5);
				self.seq:Hide();
			end
		end
		local function create_sortButtons(sortButtons, method)
			if not method then
				return;
			end
			local width = button_elements_width[method];
			local button = CreateFrame("BUTTON", nil, ui);
			button.method = method;
			-- button:SetBackdrop({
			-- 	bgFile = "Interface\\Buttons\\WHITE8X8",
			-- 	-- "Interface\\Buttons\\WHITE8X8",	-- "Interface\\Tooltips\\UI-Tooltip-Background", -- "Interface\\ChatFrame\\ChatFrameBackground"
			-- 	edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
			-- 	tile = true,
			-- 	tileSize = 2,
			-- 	edgeSize = 2,
			-- 	insets = { left = 0, right = 0, top = 0, bottom = 0 }
			-- });
			-- button:SetBackdropColor(0.15, 0.15, 0.15, 1.0);
			-- button:SetBackdropBorderColor(0.0, 0.0, 0.0, 1.0);
			button:SetSize(width, 18);
			local buttonTexture = button:CreateTexture(nil, "ARTWORK");
			buttonTexture:SetPoint("TOPLEFT");
			buttonTexture:SetPoint("BOTTOMRIGHT");
			buttonTexture:SetAlpha(0.75);
			buttonTexture:SetBlendMode("ADD");
			button.texture = buttonTexture;
			local buttonText = button:CreateFontString(nil, "OVERLAY");
			buttonText:SetFont(ui_style.frameFont, ui_style.frameFontSize);
			buttonText:SetTextColor(1.0, 1.0, 1.0, 0.5);
			buttonText:SetPoint("LEFT");
			buttonText:SetText(L["SORT_METHOD"][method]);
			button.text = buttonText;
			local seq = button:CreateTexture(nil, "ARTWORK");
			seq:SetPoint("RIGHT");
			-- seq:SetTexCoord(0.0, 1.0, 0.0, 0.5);
			button.seq = seq;
			button:SetFontString(buttonText);
			button:SetPushedTextOffset(1, - 1);
			button:SetScript("OnClick", sortButton_OnClick);
			button:SetScript("OnShow", sortButton_OnShow);
			button.sortButtons = sortButtons;
			sortButtons[method] = button;
			return button;
		end
		local function ticker_update_ui()
			if ui:IsShown() then
				ui.scroll:Update();
			end
		end
		function NS.initUI()
			do	-- UI
				ui = CreateFrame("FRAME", "ALA_TRADE_UI", UIParent, "BackdropTemplate");
				tinsert(UISpecialFrames, "ALA_TRADE_UI");
				ui.list = {  };
				ui:SetSize(ui_width, 480);
				ui:SetPoint("CENTER", UIParent);
				ui:SetFrameStrata("MEDIUM");
				ui:SetBackdrop({
					bgFile = "Interface\\Buttons\\WHITE8X8",
					-- "Interface\\Buttons\\WHITE8X8",	-- "Interface\\Tooltips\\UI-Tooltip-Background", -- "Interface\\ChatFrame\\ChatFrameBackground"
					edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
					tile = true,
					tileSize = 2,
					edgeSize = 2,
					insets = { left = 0, right = 0, top = 0, bottom = 0 }
				});
				ui:SetBackdropColor(0.15, 0.15, 0.15, 1.0);
				ui:SetBackdropBorderColor(0.0, 0.0, 0.0, 1.0);
				ui:EnableMouse(true);
				ui:SetMovable(true);
				ui:RegisterForDrag("LeftButton");
				ui:SetScript("OnDragStart", function(self)
					self:StartMoving();
				end);
				ui:SetScript("OnDragStop", function(self)
					self:StopMovingOrSizing();
				end);
				ui:SetScript("OnShow", uimethod.func_update_ui);
				ui:Hide();

				local title = ui:CreateFontString(nil, "OVERLAY");
				title:SetFont(ui_style.frameFont, ui_style.frameFontSize);
				title:SetTextColor(1.0, 1.0, 1.0, 1.0);
				title:SetPoint("TOP", 0, - 4);
				title:SetText(L["UI_TITLE"]);
				ui.title = title;

				local close = CreateFrame("BUTTON", nil, ui);
				close:SetSize(16, 16);
				close:SetNormalTexture("interface\\buttons\\ui-stopbutton");
				close:SetPushedTexture("interface\\buttons\\ui-stopbutton");
				close:GetPushedTexture():SetVertexColor(0.5, 0.5, 0.5, 0.5);
				close:SetHighlightTexture("interface\\buttons\\ui-stopbutton");
				close:GetHighlightTexture():SetVertexColor(0.5, 0.5, 0.5, 0.5);
				close:SetPoint("TOPRIGHT", - 5, - 3);
				close:SetScript("OnClick", function()
					ui:Hide();
				end);
				ui.close = close;

				local scroll = ALASCR(ui, nil, nil, ui_style.button_height, funcToCreateButton, funcToSetButton);
				scroll:SetPoint("BOTTOMLEFT", 4, 24);
				scroll:SetPoint("TOPRIGHT", - 4, - 62);
				ui.scroll = scroll;

				local showEmpty = CreateFrame("CHECKBUTTON", nil, ui, "OptionsBaseCheckButtonTemplate");
				showEmpty:SetHitRectInsets(0, 0, 0, 0);
				showEmpty:SetScript("OnClick", function(self)
					SET["showEmpty"] = self:GetChecked();
					uimethod.func_update_ui();
				end);
				local label = ui:CreateFontString(nil, "ARTWORK", "GameFontHighlight");
				label:SetText(L["showEmpty"]);
				label:SetPoint("RIGHT", showEmpty, "LEFT", - 4, 0);
				showEmpty:SetPoint("CENTER", ui, "BOTTOMRIGHT", - 10, 13);
				ui.showEmpty = showEmpty;
				showEmpty:SetChecked(SET.showEmpty);

				NS.add_cache_callback(uimethod.func_update_ui);
				C_Timer.NewTicker(1.0, ticker_update_ui);
				-- ui:SetScript("OnShow", function()
				-- 	ui.graph:Hide();
				-- end);
			end

			do	-- graph
				local graph_container = CreateFrame("FRAME", nil, UIParent, "BackdropTemplate");
				ui.graph_container = graph_container;
				graph_container:SetFrameLevel(255);
				graph_container:SetSize(W + 120, H + 72);
				graph_container:SetBackdrop({
					bgFile = "Interface\\Buttons\\WHITE8X8",
					-- "Interface\\Buttons\\WHITE8X8",	-- "Interface\\Tooltips\\UI-Tooltip-Background", -- "Interface\\ChatFrame\\ChatFrameBackground"
					edgeFile = "Interface\\Buttons\\WHITE8X8",
					-- "Interface\\Tooltips\\UI-Tooltip-Border",
					tile = true,
					tileSize = 2,
					edgeSize = 2,
					insets = { left = 0, right = 0, top = 0, bottom = 0 }
				});
				graph_container:SetBackdropColor(0.25, 0.25, 0.15, 1.0);
				graph_container:SetBackdropBorderColor(COLOR_LINE[1], COLOR_LINE[2], COLOR_LINE[3], COLOR_LINE[4]);
				graph_container:EnableMouse(true);
				graph_container:SetMovable(true);
				graph_container:SetPoint("CENTER");
				graph_container:RegisterForDrag("LeftButton");
				graph_container:SetScript("OnDragStart", function(self)
					self:StartMoving();
				end);
				graph_container:SetScript("OnDragStop", function(self)
					self:StopMovingOrSizing();
				end);
				graph_container:Hide();

				local title = graph_container:CreateFontString(nil, "OVERLAY");
				title:SetFont(ui_style.frameFont, ui_style.frameFontSize);
				title:SetPoint("TOP", graph_container, "TOP", 0, - 6);
				graph_container.title = title;

				local graph = CreateFrame("FRAME", nil, graph_container, "BackdropTemplate");
				ui.graph = graph;
				graph.list = { [0] = 0, };
				graph:SetSize(W, H);
				graph:SetBackdrop({
					bgFile = "Interface\\Buttons\\WHITE8X8",
					-- "Interface\\Buttons\\WHITE8X8",	-- "Interface\\Tooltips\\UI-Tooltip-Background", -- "Interface\\ChatFrame\\ChatFrameBackground"
					edgeFile = "Interface\\Buttons\\WHITE8X8",
					-- "Interface\\Tooltips\\UI-Tooltip-Border",
					tile = true,
					tileSize = 2,
					edgeSize = 1,
					insets = { left = 0, right = 0, top = 0, bottom = 0 }
				});
				graph:SetBackdropColor(0.15, 0.15, 0.15, 1.0);
				graph:SetBackdropBorderColor(0.25, 0.25, 0.15, 1.0);
				graph:EnableMouse(true);
				graph:SetMovable(true);
				graph:SetPoint("TOPRIGHT", 0, - 24);
				graph:RegisterForDrag("LeftButton");
				graph:SetScript("OnDragStart", function(self)
					graph_container:StartMoving();
				end);
				graph:SetScript("OnDragStop", function(self)
					graph_container:StopMovingOrSizing();
				end);
				graph:SetScript("OnUpdate", graph_OnUpdate);
				graph:Show();

				local close = CreateFrame("BUTTON", nil, graph_container);
				close:SetSize(16, 16);
				close:SetNormalTexture("interface\\buttons\\ui-stopbutton");
				close:GetNormalTexture():SetTexCoord(0.025, 0.975, 0.05, 1.0);
				close:SetPushedTexture("interface\\buttons\\ui-stopbutton");
				close:GetPushedTexture():SetTexCoord(0.025, 0.975, 0.0, 0.95);
				close:SetPoint("TOPRIGHT", - 4, - 4);
				close:SetScript("OnClick", function()
					graph_container:Hide();
				end);
				graph_container.close = close;

				graph.title = title;

				local tip = graph:CreateFontString(nil, "OVERLAY");
				tip:SetFont(ui_style.frameFont, ui_style.frameFontSize);
				graph.tip = tip;
				tip:SetPoint("CENTER");

				local cells = {  };
				for i = 1, N do
					local T = graph:CreateTexture(nil, "ARTWORK");
					T:SetSize(w, w);
					T:SetPoint("LEFT", (i - 1) * w, 0);
					T:SetColorTexture(1.0, 1.0, 1.0, 1.0);
					T:SetAlpha(1.0);
					T:Show();
					cells[i] = T;
				end
				graph.cells = cells;

				local focus_h = graph:CreateTexture(nil, "OVERLAY");
				focus_h:SetSize(w, H);
				focus_h:SetPoint("BOTTOM");
				focus_h:SetColorTexture(1.0, 1.0, 1.0, 0.25);
				focus_h:Hide();
				graph.focus_h = focus_h;

				local focus_w = graph:CreateTexture(nil, "OVERLAY");
				focus_w:SetSize(W, w);
				focus_w:SetPoint("LEFT");
				focus_w:SetColorTexture(1.0, 1.0, 1.0, 0.25);
				focus_w:Hide();
				graph.focus_w = focus_w;

				local minHIndicator = graph:CreateTexture(nil, "ARTWORK");
				minHIndicator:SetSize(w, H + 48);
				minHIndicator:SetPoint("TOPLEFT", graph, "TOPLEFT", 0, 0);
				minHIndicator:SetColorTexture(COLOR_LINE[1], COLOR_LINE[2], COLOR_LINE[3], COLOR_LINE[4]);
				minHIndicator:Show();
				graph.minHIndicator = minHIndicator;
				local minH = graph:CreateFontString(nil, "OVERLAY");
				minH:SetFont(ui_style.frameFont, ui_style.frameFontSize);
				minH:SetTextColor(1.0, 1.0, 1.0, 1.0);
				minH:SetPoint("TOPLEFT", minHIndicator, "TOPRIGHT", 2, - H - 8);
				graph.minH = minH;

				local maxHIndicator = graph:CreateTexture(nil, "ARTWORK");
				maxHIndicator:SetSize(w, H + 48);
				maxHIndicator:SetPoint("TOPRIGHT", graph, "TOPRIGHT", 0, 0);
				maxHIndicator:SetColorTexture(COLOR_LINE[1], COLOR_LINE[2], COLOR_LINE[3], COLOR_LINE[4]);
				maxHIndicator:Show();
				graph.maxHIndicator = maxHIndicator;
				local maxH = graph:CreateFontString(nil, "OVERLAY");
				maxH:SetFont(ui_style.frameFont, ui_style.frameFontSize);
				maxH:SetTextColor(1.0, 1.0, 1.0, 1.0);
				maxH:SetPoint("TOPRIGHT", maxHIndicator, "TOPLEFT", - 2, - H - 8);
				graph.maxH = maxH;

				local minVIndicator = graph:CreateTexture(nil, "ARTWORK");
				minVIndicator:SetSize(120, w);
				minVIndicator:SetPoint("BOTTOMRIGHT", graph, "BOTTOMLEFT", 0, 0);
				minVIndicator:SetColorTexture(COLOR_LINE[1], COLOR_LINE[2], COLOR_LINE[3], COLOR_LINE[4]);
				minVIndicator:Show();
				graph.minVIndicator = minVIndicator;
				local minV = graph:CreateFontString(nil, "OVERLAY");
				minV:SetFont(ui_style.frameFont, ui_style.frameFontSize);
				minV:SetTextColor(1.0, 1.0, 1.0, 1.0);
				minV:SetPoint("BOTTOMRIGHT", minVIndicator, "TOPRIGHT", - 1, 0);
				graph.minV = minV;

				local maxVIndicator = graph:CreateTexture(nil, "ARTWORK");
				maxVIndicator:SetSize(W + 120, w);
				maxVIndicator:SetPoint("TOPRIGHT", graph, "TOPRIGHT", 0, 0);
				maxVIndicator:SetColorTexture(COLOR_LINE[1], COLOR_LINE[2], COLOR_LINE[3], COLOR_LINE[4]);
				maxVIndicator:Show();
				graph.maxVIndicator = maxVIndicator;
				local maxV = graph:CreateFontString(nil, "OVERLAY");
				maxV:SetFont(ui_style.frameFont, ui_style.frameFontSize);
				maxV:SetTextColor(1.0, 1.0, 1.0, 1.0);
				maxV:SetPoint("TOPRIGHT", maxVIndicator, "BOTTOMRIGHT", - W - 1, 0);
				graph.maxV = maxV;

				local curIndicator = graph:CreateTexture(nil, "ARTWORK");
				curIndicator:SetSize(W + 120, w);
				curIndicator:SetPoint("RIGHT", 0, 0);
				curIndicator:SetColorTexture(0.0, 1.0, 0.0, 0.25);
				curIndicator:Hide();
				graph.curIndicator = curIndicator;
				local curPrice = graph:CreateFontString(nil, "OVERLAY");
				curPrice:SetFont(ui_style.frameFont, ui_style.frameFontSize);
				curPrice:SetTextColor(1.0, 1.0, 1.0, 1.0);
				curPrice:SetPoint("TOPRIGHT", curIndicator, "BOTTOMRIGHT", - W - 1, 0);
				graph.curPrice = curPrice;

			end

			do	-- search_box
				local searchEditOK = CreateFrame("BUTTON", nil, ui);
				searchEditOK:SetSize(32, 18);
				searchEditOK:SetPoint("TOPRIGHT", ui, "TOPRIGHT", - 26, - 22);
				searchEditOK:Disable();
				local searchEditOKTexture = searchEditOK:CreateTexture(nil, "ARTWORK");
				searchEditOKTexture:SetPoint("TOPLEFT");
				searchEditOKTexture:SetPoint("BOTTOMRIGHT");
				searchEditOKTexture:SetColorTexture(0.25, 0.25, 0.25, 0.5);
				searchEditOKTexture:SetAlpha(0.75);
				searchEditOKTexture:SetBlendMode("ADD");
				local searchEditOKText = searchEditOK:CreateFontString(nil, "OVERLAY");
				searchEditOKText:SetFont(ui_style.frameFont, ui_style.frameFontSize);
				searchEditOKText:SetTextColor(1.0, 1.0, 1.0, 0.5);
				searchEditOKText:SetPoint("CENTER");
				searchEditOKText:SetText(L["OK"]);
				searchEditOK:SetFontString(searchEditOKText);
				searchEditOK:SetPushedTextOffset(0, - 1);

				local searchEditNameOnly = CreateFrame("CHECKBUTTON", nil, ui, "OptionsBaseCheckButtonTemplate");
				searchEditNameOnly:SetSize(24, 24);
				searchEditNameOnly:SetHitRectInsets(0, 0, 0, 0);
				searchEditNameOnly:Show();
				searchEditNameOnly:SetChecked(false);
				searchEditNameOnly:SetPoint("RIGHT", searchEditOK, "LEFT", - 4, 0)
				searchEditNameOnly.info_lines = { L["TIP_SEARCH_NAME_ONLY_INFO"], };
				searchEditNameOnly:SetScript("OnEnter", button_info_OnEnter);
				searchEditNameOnly:SetScript("OnLeave", button_info_OnLeave);
				searchEditNameOnly:SetScript("OnClick", function(self)
					SET.searchNameOnly = self:GetChecked();
					NS.F_ScheduleDelayCall(uimethod.func_update_ui);
				end);
				ui.searchEditNameOnly = searchEditNameOnly;
				searchEditNameOnly:SetChecked(SET.searchNameOnly);

				local searchEdit = CreateFrame("EDITBOX", nil, ui);
				searchEdit:SetHeight(18);
				searchEdit:SetFont(ui_style.frameFont, ui_style.frameFontSize, ui_style.frameFontOutline);
				searchEdit:SetAutoFocus(false);
				searchEdit:SetJustifyH("LEFT");
				searchEdit:Show();
				searchEdit:EnableMouse(true);
				searchEdit:SetPoint("TOPLEFT", ui, "TOPLEFT", 4, - 22);
				searchEdit:SetPoint("RIGHT", searchEditNameOnly, "LEFT", - 4, 0);
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
				searchCancel:SetSize(18, 18);
				searchCancel:SetPoint("RIGHT", searchEdit);
				searchCancel:Hide();
				searchCancel:SetNormalTexture("interface\\petbattles\\deadpeticon")

				searchCancel:SetScript("OnClick", function(self) searchEdit:SetText(""); searchEdit:ClearFocus(); end);
				searchEditOK:SetScript("OnClick", function(self) searchEdit:ClearFocus(); end);
				searchEditOK:SetScript("OnEnable", function(self) searchEditOKText:SetTextColor(1.0, 1.0, 1.0, 1.0); end);
				searchEditOK:SetScript("OnDisable", function(self) searchEditOKText:SetTextColor(1.0, 1.0, 1.0, 0.5); end);

				function ui:SearchEditValid()
					searchEditTexture:SetVertexColor(0.25, 0.25, 0.25);
				end
				function ui:SearchEditInvalid()
					searchEditTexture:SetVertexColor(0.25, 0.0, 0.0);
				end
				searchEdit:SetScript("OnEnterPressed", function(self) self:ClearFocus(); end);
				searchEdit:SetScript("OnEscapePressed", function(self) self:ClearFocus(); end);
				searchEdit:SetScript("OnTextChanged", function(self, isUserInput)
					NS.F_ScheduleDelayCall(uimethod.func_update_ui);
					if self:GetText() == "" then
						searchCancel:Hide();
					else
						searchCancel:Show();
					end
				end);
				searchEdit:SetScript("OnEditFocusGained", function(self)
					searchEditNote:Hide();
					searchEditOK:Enable();
				end);
				searchEdit:SetScript("OnEditFocusLost", function(self)
					if searchEdit:GetText() == "" then
						searchEditNote:Show();
					end
					searchEditOK:Disable();
				end);
				searchEdit:ClearFocus();
				ui.searchEdit = searchEdit;
				ui.searchEditOK = searchEditOK;
			end

			do	-- sort_button
				local sortButtons = {  };
				ui.sortButtons = sortButtons;
				create_sortButtons(sortButtons, SORT_METHOD_ID):SetPoint("BOTTOMLEFT", ui.scroll, "TOPLEFT", 2, 2);
				create_sortButtons(sortButtons, SORT_METHOD_NAME):SetPoint("LEFT", sortButtons[SORT_METHOD_ID], "RIGHT", 2, 0);
				create_sortButtons(sortButtons, SORT_METHOD_QUALITY):SetPoint("LEFT", sortButtons[SORT_METHOD_NAME], "RIGHT", 2, 0);
				create_sortButtons(sortButtons, SORT_METHOD_LEVEL):SetPoint("LEFT", sortButtons[SORT_METHOD_QUALITY], "RIGHT", 2, 0);
				create_sortButtons(sortButtons, SORT_METHOD_PRICE):SetPoint("LEFT", sortButtons[SORT_METHOD_LEVEL], "RIGHT", 2, 0);
				create_sortButtons(sortButtons, SORT_METHOD_TIME):SetPoint("LEFT", sortButtons[SORT_METHOD_PRICE], "RIGHT", 2, 0);
			end

			local configButton = CreateFrame("BUTTON", nil, ui);
			configButton:SetSize(18, 18);
			configButton:SetNormalTexture("interface\\buttons\\ui-optionsbutton");
			configButton:SetPushedTexture("interface\\buttons\\ui-optionsbutton");
			configButton:GetPushedTexture():SetVertexColor(0.5, 0.5, 0.5, 0.5);
			configButton:SetHighlightTexture("interface\\buttons\\ui-optionsbutton");
			configButton:GetHighlightTexture():SetVertexColor(0.5, 0.5, 0.5, 0.5);
			configButton:SetPoint("TOPRIGHT", ui, "TOPRIGHT", - 4, - 22);
			configButton:SetScript("OnClick", NS.toggle_config);

			do	-- DBIcon
				if LibStub then
					local icon = LibStub("LibDBIcon-1.0", true);
					if icon then
						icon:Register("ALATRADE",
							{
								icon = "interface\\icons\\inv_hammer_unique_sulfuras",
								OnClick = DBIcon_OnClick,
								text = L["DBIcon_Text"],
								OnTooltipShow = function(tt)
										tt:AddLine("\124cffffffffALA TRADE\124r");
										tt:AddLine(L["DBIcon_Text"]);
									end
							},
							{
								minimapPos = SET.minimapPos,
							}
						);
					end
					if SET.show_DBIcon then
						icon:Show("ALATRADE");
					else
						icon:Hide("ALATRADE");
					end
					local mb = icon:GetMinimapButton("ALATRADE");
					mb:RegisterEvent("PLAYER_LOGOUT");
					mb:SetScript("OnEvent", function(self)
						SET.minimapPos = self.minimapPos or self.db.minimapPos;
					end);
				end
			end
		end
		do	-- config_frame
			local config_callback = {  };
			NS.config_callback = config_callback;
			configFrame = CreateFrame("FRAME", nil, UIParent, "BackdropTemplate");
			configFrame:SetSize(480, 360);
			configFrame:SetPoint("CENTER", UIParent);
			configFrame:SetFrameStrata("DIALOG");
			configFrame:SetBackdrop({
				bgFile = "Interface\\Buttons\\WHITE8X8",
				-- "Interface\\Buttons\\WHITE8X8",	-- "Interface\\Tooltips\\UI-Tooltip-Background", -- "Interface\\ChatFrame\\ChatFrameBackground"
				edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
				tile = true,
				tileSize = 2,
				edgeSize = 2,
				insets = { left = 0, right = 0, top = 0, bottom = 0 }
			});
			configFrame:SetBackdropColor(0.25, 0.25, 0.25, 1.0);
			configFrame:SetBackdropBorderColor(0.0, 0.0, 0.0, 1.0);
			configFrame:EnableMouse(true);
			configFrame:SetMovable(true);
			configFrame:RegisterForDrag("LeftButton");
			configFrame:SetScript("OnDragStart", function(self)
				self:StartMoving();
			end);
			configFrame:SetScript("OnDragStop", function(self)
				self:StopMovingOrSizing();
			end);
			configFrame:Hide();
			local close = CreateFrame("BUTTON", nil, configFrame, "UIPanelButtonTemplate");
			close:SetText(L["close"]);
			close:SetSize(48, 22);
			close:SetPoint("TOPRIGHT");
			close:SetScript("OnClick", function()
				configFrame:Hide();
			end);
			local ct = {
				-- { "avoid_stuck", },
				-- { "query_online",
				-- 	function(on)
				-- 		if not on then
				-- 			NS.FlushQueryQueue();
				-- 		end
				-- 	end,
				-- },
				{ "show_DBIcon",
					function(on)
						if LibStub then
							local icon = LibStub("LibDBIcon-1.0", true);
							if icon then
								if on then
									icon:Show("ALATRADE");
								else
									icon:Hide("ALATRADE");
								end
							end
						end
					end,
				},
				{ "show_vendor_price", },
				{ "show_vendor_price_multi", },
				{ "show_ah_price", },
				{ "show_ah_price_multi", },
				{ "show_disenchant_price", },
				{ "show_disenchant_detail", },
				{ "cache_history", },
				{ "BaudAuctionFrame",
					function(on)
						if NS.BaudAuctionFrame then
							if on then
								NS.EnableBaudAuctionFrame(NS.BaudAuctionFrame);
							else
								NS.DisableBaudAuctionFrame(NS.BaudAuctionFrame);
							end
						end
					end,
				},
				{ "regular_exp", uimethod.func_update_ui, },
			};
			local cbs = {  };
			local pos_x = 0;
			local pos_y = 0;
			for i, val in next, ct do
				local key = val[1];
				local func = val[2];
				local cb = CreateFrame("CHECKBUTTON", nil, configFrame, "OptionsBaseCheckButtonTemplate");
				cb:SetHitRectInsets(0, 0, 0, 0);
				cb:SetScript("OnClick", function(self)
					SET[key] = self:GetChecked();
					if func then
						func(SET[key]);
					end
				end);
				if func then
					config_callback[key] = func;
				end
				local label = configFrame:CreateFontString(nil, "ARTWORK", "GameFontHighlight");
				label:SetText(L[key]);
				label:SetPoint("LEFT", cb, "RIGHT", 4, 0);
				cb:SetPoint("TOPLEFT", configFrame, "TOPLEFT", 4 + 240 * pos_x, - 20 - pos_y * 36);
				cbs[i] = cb;
				pos_x = pos_x + 1;
				if pos_x > 1 then
					pos_x = 0;
					pos_y = pos_y + 1;
				end
			end
			if pos_x > 0 then
				pos_x = 0;
				pos_y = pos_y + 1.5;
			else
				pos_y = pos_y + 0.5
			end
			local st = {
				{ "avoid_stuck_cost", 1, 500, 1, },
				{ "data_valid_time", 900, 86400, 300, L["TIME900"], L["TIME86400"], function(self, value, userInput)
					if userInput then
						SET.data_valid_time = value;
						ui.scroll:Update();
					end
					self.Text:SetText(NS.seconds_to_colored_formatted_time_len(value));
				end },
				{ "auto_clean_time", 0, 2592000, 43200, L["close"], L["TIME2592000"], function(self, value, userInput)
					if userInput then
						SET.auto_clean_time = value;
					end
					if value == 0 then
						self.Text:SetText("\124cffff0000" .. L["close"] .. "\124r");
					else
						self.Text:SetText(NS.seconds_to_colored_formatted_time_len(value));
					end
				end},
			};
			local sls = {  };
			for i, val in next, st do
				local label = configFrame:CreateFontString(nil, "ARTWORK", "GameFontHighlight");
				label:SetText(L[val[1]]);
				label:SetPoint("TOPLEFT", configFrame, "TOPLEFT", 4, -12 - pos_y * 36);
				local sl = CreateFrame("SLIDER", nil, configFrame, "OptionsSliderTemplate");
				sl:SetWidth(464);
				sl:SetMinMaxValues(val[2], val[3]);
				sl:SetValueStep(val[4]);
				sl:SetObeyStepOnDrag(true);
				sl:SetPoint("TOPLEFT", label, "BOTTOMLEFT", 4, -2);
				sl.Text:ClearAllPoints();
				sl.Text:SetPoint("TOP", sl, "BOTTOM", 0, 3);
				sl.Low:ClearAllPoints();
				sl.Low:SetPoint("TOPLEFT", sl, "BOTTOMLEFT", 4, 3);
				sl.High:ClearAllPoints();
				sl.High:SetPoint("TOPRIGHT", sl, "BOTTOMRIGHT", -4, 3);
				sl.Low:SetText(val[5] or val[2]);
				sl.High:SetText(val[6] or val[3]);
				sl:SetScript("OnValueChanged", val[7] or function(self, value, userInput)
					self.Text:SetText(value);
					if userInput then
						SET[val[1]] = value;
					end
				end);
				if val[7] then
					config_callback[val[1]] = val[7];
				end
				sls[i] = sl;
				pos_y = pos_y + 1.5;
			end

			configFrame:SetHeight(12 + pos_y * 36);

			configFrame:SetScript("OnShow", function()
				for i, val in next, ct do
					cbs[i]:SetChecked(SET[val[1]]);
				end
				for i, val in next, st do
					sls[i]:SetValue(SET[val[1]]);
				end
				-- data_valid_time_Slider:SetValue(SET.data_valid_time);
				-- auto_clean_time_Slider:SetValue(SET.auto_clean_time);
			end);

			gui.configFrame = configFrame;
		end
		function NS.toggle_ui()
			if ui:IsShown() then
				ui:Hide();
			else
				ui:Show();
			end
		end
		function NS.toggle_config()
			if configFrame:IsShown() then
				configFrame:Hide();
			else
				configFrame:Show();
			end
		end

		ALA_HOOK_ChatEdit_InsertLink(function(link, addon)
			if ui.searchEdit:IsShown() and addon ~= ADDON and ui and ui.searchEdit and ui.searchEdit:IsVisible() then
				if strfind(link, "item:", 1, true) then
					local name = GetItemInfo(link);
					if name and name ~= "" then
						ui.searchEdit:SetText(name);
						return true;
					end
				end
			end
		end);
		ALA_HOOK_ChatEdit_InsertName(function(name, addon)
			if ui.searchEdit:IsShown() and addon ~= ADDON and ui and ui.searchEdit and ui.searchEdit:IsVisible() then
				if name and name ~= "" then
					ui.searchEdit:SetText(name);
					return true;
				end
			end
		end);
	end

	do	--	cache
		function NS.cache_item_info(id)
			local info = cache[id];
			if info then
				local name, link, quality, _, reqLevel, _, _, _, _, texture, vendorPrice = GetItemInfo(id);
				if name and name ~= "" then
					info[index_name] = name;
					info[index_quality] = quality;
					info[index_texture] = texture;
					info[index_level] = reqLevel;
					info[index_vendorPrice] = vendorPrice;
					info[index_link] = link;
					cache2[name] = id;
					return true;
				end
			end
			return false;
		end
		local NUM_PER_SECOND = 100;
		local num = 0;
		local todo1, todo2 = {  }, {  };
		C_Timer.NewTicker(1.0, function()
			for i = num + 1, NUM_PER_SECOND do
				local id = tremove(todo1);
				if id == nil then
					if #todo2 == 0 then
						break;
					else
						todo1, todo2 = todo2, todo1;
					end
				else
					if not NS.cache_item_info(id) then
						tinsert(todo2, 1, id);
					end
				end
			end
			num = 0;
		end);
		function NS.notify_cache_item_info(id)
			if num < NUM_PER_SECOND then
				if not NS.cache_item_info(id) then
					todo2[#todo2 + 1] = id;
				end
				num = num + 1;
			else
				todo2[#todo1 + 1] = id;
			end
		end
		function NS.GET_ITEM_INFO_RECEIVED(self, event, arg1, arg2)
			if arg2 then
				if NS.cache_item_info(arg1) then
					if ui:IsShown() then
						NS.F_ScheduleDelayCall(NS.ui_scroll_Update);
					end
				end
			end
		end
	end

	function NS.proc_cache()
		do	-- history data by date
			for id, info in next, cache do
				local H = info[index_history];
				if H then
					local pos = 1;
					while H[pos] do
						local c = H[pos];
						local d = floor((c[3] + time_zone_ofs * 3600) / 86400);
						local pos2 = pos + 1;
						while H[pos2] do
							local c2 = H[pos2];
							local d2 = floor((c2[3] + time_zone_ofs * 3600) / 86400);
							if d2 ~= d then
								break;
							end
							if c[1] and c2[1] then
								if c2[1] < c[1] then
									c[1] = c2[1];
									c[3] = c2[3];
								end
								c[2] = max(c[2], c2[2]);
							else
								if c2[1] then
									c[1] = c2[1];
									c[2] = c2[2];
									c[3] = c2[3];
								end
							end
							tremove(H, pos2);
						end
						pos = pos + 1;
					end
				end
			end
		end
		do	-- validate & modify db
			if SET.auto_clean_time > 0 then
				local expired = GetServerTime() - SET.auto_clean_time;
				for id, info in next, cache do
					local H = info[index_history];
					if H then
						if info[index_buyoutPriceSingle] then
							while true do
								if H[1] and H[1][3] < expired then
									tremove(H, 1);
								else
									break;
								end
							end
						else
							while true do
								if H[2] and H[1][3] < expired then
									tremove(H, 1);
								else
									break;
								end
							end
						end
					end
				end
			end
			for id, info in next, cache do
				local H = info[index_history];
				if H then
					for i = #H, 1, -1 do
						if not H[i][3] then
							tremove(H, i);
						end
					end
				end
			end
		end
		for id, info in next, cache do
			if type(info[index_name]) ~= 'string' or info[index_name] == "" then
				info[index_name] = nil;
			end
			if type(info[index_link]) ~= 'string' or info[index_link] == "" then
				info[index_link] = nil;
			end
			if (type(info[index_link]) ~= 'string' and type(info[index_link]) ~= 'number') or info[index_texture] == "" or info[index_texture] == 0 then
				info[index_texture] = nil;
			end
			if info[index_name] == nil or
				info[index_link] == nil or
				info[index_quality] == nil or
				info[index_texture] == nil or
				info[index_level] < 0 or
				info[index_vendorPrice] == nil then
				NS.notify_cache_item_info(id);
			end
		end
	end
	function NS.ElvUI()
		if ElvUI and ElvUI[1] then
			local S = ElvUI[1]:GetModule('Skins');
			if S then
				if gui.ResetButton then
					S:HandleButton(gui.ResetButton);
				end
				if gui.ExactQueryCheckButton then
					S:HandleCheckBox(gui.ExactQueryCheckButton);
				end
				if gui.CacheAll then
					S:HandleButton(gui.CacheAll);
				end
				if gui.configButton then
					S:HandleButton(gui.configButton);
				end
				if AuctionFrameAuctions_Time then
					S:HandleDropDownBox(AuctionFrameAuctions_Time);
				end
			end
		--gui.ResetButton
		--gui.ExactQueryCheckButton
		--gui.CacheAll
		--AuctionFrameAuctions_Time
		--gui.configButton
		end
	end

	local conflicted_addons_list = {
		["Auctionator"] = 1,
		["AuctionLite"] = 1,
		["TradeSkillMaster"] = 1,
		["AuctionFaster"] = 1,
		["AuctionMaster"] = 1,
		["aux-addon"] = 1,
		["BaudAuction"] = 1,
	};

	for addon, _ in next, conflicted_addons_list do
		-- if GetAddOnEnableState(PLAYER_NAME, addon) ~= 0 then
			-- DisableAddOn(addon);
		-- end
	end
	function NS.Disable(addon)
		_error_(L["CONFLICT"], addon);
	end
	function NS.ADDON_LOADED(addon)
		if conflicted_addons_list[addon] then
			return NS.Disable(addon);
		end
		if addon == 'ElvUI' then
			NS.ElvUI();
		end
	end

	function NS.add_cache_callback(func)
		if type(func) == 'function' then
			for i = _num_callback_after_cache, 1, -1 do
				if _callback_after_cache[i] == func then
					return;
				end
			end
			_num_callback_after_cache = _num_callback_after_cache + 1;
			_callback_after_cache[_num_callback_after_cache] = func;
		end
	end
	function NS.remove_cache_callback(func)
		if type(func) == 'function' then
			for i = _num_callback_after_cache, 1, -1 do
				if _callback_after_cache[i] == func then
					tremove(_callback_after_cache, i);
					_num_callback_after_cache = _num_callback_after_cache - 1;
				end
			end
		end
	end
end

do	--	INITIALIZE
	local default_set = {
		-- query_online = false,
		avoid_stuck = true,
		avoid_stuck_cost = 100,
		show_vendor_price = true,
		show_vendor_price_multi = true,
		show_ah_price = true,
		show_ah_price_multi = true,
		show_disenchant_price = true,
		show_disenchant_detail = true,
		prev_cache_all = GetServerTime(),		-- un-configurable
		sort_method = 1,		-- auto
		sort_method_seq = -1,	-- auto
		cache_history = true,
		regular_exp = false,
		data_valid_time = 3600,	-- in second
		auto_clean_time = 0,
		minimapPos = 165,		-- auto
		show_DBIcon = true,	--
		showEmpty = false,
		BaudAuctionFrame = true,
		searchNameOnly = true,
	};
	function NS.PLAYER_ENTERING_WORLD()
		_EventHandler:UnregisterEvent("PLAYER_ENTERING_WORLD");
		do	-- initialze saved_var
			local alaTradeSV = _G.alaTradeSV;
			if alaTradeSV then
				if alaTradeSV._version < 200214.0 then
					for id, info in next, alaTradeSV.cache do
						info[11] = info[0];
						info[0] = nil;
						info[10] = info.temp or {  };
						info.temp = nil;
						info[9] = info[7];
						info[7] = info[2];
						info[2] = info[8];
						info[8] = info[3];
						info[3] = info[4];
						info[4] = info[6];
						info[6] = info[5];
						info[5] = -1;
						if info[11] then
							for i = #info[11], 1, -1 do
								local v = info[11][i];
								if v[3] == nil then
									tremove(info[11], i);
								end
							end
						end
					end
				end
				if alaTradeSV._version < 200220.0 then
					local rc = alaTradeSV.cache or {  };
					alaTradeSV.cache = {  };
					alaTradeSV.cache[PLAYER_REALM_NAME] = rc;
				end
				if alaTradeSV._version < 200525.0 then
					alaTradeSV.config.avoid_stuck_cost = default_set.avoid_stuck_cost;
					alaTradeSV.config.regular_exp = default_set.regular_exp;
				end
				alaTradeSV.fav = alaTradeSV.fav or {  };
				alaTradeSV.cache = alaTradeSV.cache or {  };
				alaTradeSV.cache[PLAYER_REALM_NAME] = alaTradeSV.cache[PLAYER_REALM_NAME] or {  };
			else
				alaTradeSV = { config = {  }, fav = {  }, cache = { [PLAYER_REALM_NAME] = {  }, }, cache2 = {  }, cache3 = {  }, };
				_G.alaTradeSV = alaTradeSV;
			end
			SET = alaTradeSV.config;
			FAV = alaTradeSV.fav;
			cache = alaTradeSV.cache[PLAYER_REALM_NAME];
			cache2 = alaTradeSV.cache2;
			cache3 = alaTradeSV.cache3;
			for k, v in next, default_set do
				if SET[k] == nil then
					SET[k] = v;
				end
			end
			for k, _ in next, SET do
				if default_set[k] == nil then
					SET[k] = nil;
				end
			end
			alaTradeSV._version = 200525.0;
		end
		_EventHandler:RegEvent("PLAYER_LOGIN");
		_EventHandler:RegEvent("PLAYER_LOGOUT");
		_EventHandler:RegEvent("GET_ITEM_INFO_RECEIVED");
		NS.hook_tooltip();
		NS.initUI();
		NS.hook_Blizzard_AuctionUI();
		-- NS.InitAddonMessage();
		-- NS.init_ADDON_MESSAGE();
		C_Timer.After(2.0, NS.proc_cache);
		if __ala_meta__.initpublic then __ala_meta__.initpublic(); end
	end

	_EventHandler:RegEvent("PLAYER_ENTERING_WORLD");
	_EventHandler:RegEvent("ADDON_LOADED");
end

NS.set_config = function(key, val)
	if SET[key] ~= nil then
		SET[key] = val;
		if NS.config_callback[key] then
			NS.config_callback[key](val);
		end
	end
end
NS.get_config = function(key)
	return SET[key];
end

_G.ALA_AUC_ADD_CALLBACK = NS.add_cache_callback;
_G.ALA_AUC_REMOVE_CALLBACK = NS.remove_cache_callback;
_G.ALA_GET_PRICE = NS.query_ah_price_by_id;
_G.ALA_GET_PRICE_BY_NAME = NS.query_ah_price_by_name;

if select(2, GetAddOnInfo('\33\33\33\49\54\51\85\73\33\33\33')) then
	_G._163_ALA_TRADE_SET_CONFIG = NS.set_config;
	_G._163_ALA_TRADE_GET_CONFIG = NS.get_config;
	_G._163_ALA_TRADE_TOGGLE_UI = NS.toggle_ui;
	_G._163_ALA_TRADE_TOGGLE_CONFIG = NS.toggle_config;
end

--[[
	NS.query_ah_price_by_id(id, offline)
		return price_single_item
	NS.query_ah_price_by_name(name, offline)
	NS.query_ah_price_by_id_detailed(id, offline)
		return price_single_item, seconds_since_cache, formatted_time_since_cache
	NS.get_material_vendor_price_by_link(link, num)
	NS.get_material_vendor_price_by_id(id, num)
	NS.get_material_vendor_price_by_name(name, num)
		return price_sold_by_vendor

]]
