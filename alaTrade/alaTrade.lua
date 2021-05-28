--[[--
	alex/ALA	Please Keep WOW Addon open-source & Reduce barriers for others.
	复用代码请在显著位置标注来源【ALA@网易有爱】
	喜欢加密和乱码的亲，请ALT+F4
--]]--
----------------------------------------------------------------------------------------------------
do return end
local ADDON, NS = ...;
_G.__ala_meta__ = _G.__ala_meta__ or {  };
local control_independent = false;

do
	local _G = _G;
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

-- local L = NS.L;
-- if not L then return;end
local curPhase = 3;
----------------------------------------------------------------------------------------------------upvalue
	----------------------------------------------------------------------------------------------------LUA
	local math, table, string, bit = math, table, string, bit;
	local type = type;
	local assert, collectgarbage, date, difftime, error, getfenv, getmetatable, loadstring, next, newproxy, pcall, select, setfenv, setmetatable, time, type, unpack, xpcall, rawequal, rawget, rawset =
			assert, collectgarbage, date, difftime, error, getfenv, getmetatable, loadstring, next, newproxy, pcall, select, setfenv, setmetatable, time, type, unpack, xpcall, rawequal, rawget, rawset;
	local abs, acos, asin, atan, atan2, ceil, cos, deg, exp, floor, fmod, frexp,ldexp, log, log10, max, min, mod, rad, random, sin, sqrt, tan, fastrandom =
			abs, acos, asin, atan, atan2, ceil, cos, deg, exp, floor, fmod or math.fmod, frexp,ldexp, log, log10, max, min, mod, rad, random, sin, sqrt, tan, fastrandom;
	local format, gmatch, gsub, strbyte, strchar, strfind, strlen, strlower, strmatch, strrep, strrev, strsub, strupper, tonumber, tostring =
			format, gmatch, gsub, strbyte, strchar, strfind, strlen, strlower, strmatch, strrep, strrev, strsub, strupper, tonumber, tostring;
	local strcmputf8i, strlenutf8, strtrim, strsplit, strjoin, strconcat, tostringall = strcmputf8i, strlenutf8, strtrim, strsplit, strjoin, strconcat, tostringall;
	local ipairs, pairs, sort, tContains, tinsert, tremove, wipe = ipairs, pairs, sort, tContains, tinsert, tremove, wipe;
	local gcinfo, foreach, foreachi, getn = gcinfo, foreach, foreachi, getn;	-- Deprecated
	----------------------------------------------------------------------------------------------------GAME
	local _G = _G;
	local print = print;
	local GetTime = GetTime;
	local CreateFrame = CreateFrame;
	local GetCursorPosition = GetCursorPosition;
	local IsAltKeyDown = IsAltKeyDown;
	local IsControlKeyDown = IsControlKeyDown;
	local IsShiftKeyDown = IsShiftKeyDown;
	local InCombatLockdown = InCombatLockdown;
	--------------------------------------------------
	local RegisterAddonMessagePrefix = RegisterAddonMessagePrefix or C_ChatInfo.RegisterAddonMessagePrefix;
	local IsAddonMessagePrefixRegistered = IsAddonMessagePrefixRegistered or C_ChatInfo.IsAddonMessagePrefixRegistered;
	local GetRegisteredAddonMessagePrefixes = GetRegisteredAddonMessagePrefixes or C_ChatInfo.GetRegisteredAddonMessagePrefixes;
	local SendAddonMessage = SendAddonMessage or C_ChatInfo.SendAddonMessage;
	local SendAddonMessageLogged = SendAddonMessageLogged or C_ChatInfo.SendAddonMessageLogged;
	local RAID_CLASS_COLORS = RAID_CLASS_COLORS;
	--------------------------------------------------
	local function _noop_()
	end
----------------------------------------------------------------------------------------------------
local LOCALE = GetLocale();
local L = {  };
do	-- LOCALE
	if LOCALE == "zhCN" or LOCALE == "zhTW" then
		L["pop_status"] = "清理...";
		L["Scan full finished."] = "扫描完成";
		L["Scan normal finished."] = "扫描完成";
		L["pages"] = "页面: 当前/已缓存/总共 ";
		L["PRICE"] = "价格";
		L["HISTORY_PRICE"] = "历史价格";
		L["AH_PRICE"] = "拍卖";
		L["VENDOR_PRICE"] = "商人";
		L["CACHE_TIME"] = "缓存时间";
		L["UNKOWN"] = "未知";
		L["BOP_ITEM"] = "拾取绑定";
		L["QUEST_ITEM"] = "任务物品";
		L["6H"] = "\124cffffff006小时前\124r";
		L["24H"] = "\124cffff000024小时前\124r";
		L["Disenchant"] = "分解";
		L["DURATION"] = "持续时间";
		L["ExactQuery"] = "精确匹配";
		L["Reset"] = "重置";
		L["CacheAll"] = "扫描全部";
		L["timeLeft"] = {
			[1] = "\124cffff0000小于30分钟\124r",
			[2] = "\124cffff7f7f30分钟-2小时\124r",
			[3] = "\124cffffff002小时-8小时\124r",
			[4] = "\124cff00ff008小时-24小时\124r",
		};
		L["buyout"] = "一口价 ";
		L["configButton"] = "设置";
		L["close"] = "关闭";
		L["OK"] = "确定";
		L["showEmpty"] = "显示无价格记录的物品";
		L["show_vendor_price"] = "显示商人价格（单个物品）";
		L["show_vendor_price_multi"] = "显示商人价格（当前数量）";
		L["show_ah_price"] = "显示拍卖价格（单个物品）";
		L["show_ah_price_multi"] = "显示拍卖价格（当前数量）";
		L["show_disenchant_price"] = "显示分解价格";
		L["show_disenchant_detail"] = "显示分解详细信息";
		L["cache_history"] = "保存历史价格\124cff00ff00占用很多内存\124r";
		L["show_DBIcon"] = "显示小地图按钮";
		L["avoid_stuck_cost"] = "全局扫描速度\124cffff0000警告: 人口较多的服务器请降低此数值\124r";
		L["data_valid_time"] = "日期着色的基准时间";
		L["auto_clean_time"] = "自动清理超过以下时间的数据";
		L["TIME900"] = "15分钟";
		L["TIME86400"] = "24小时";
		L["TIME43200"] = "12小时";
		L["TIME2592000"] = "30天";
		L["SORT_METHOD"] = {
			[1] = "ID",
			[2] = "品质",
			[3] = "名字",
			[4] = "单价",
			[5] = "缓存时间",
		};
		L["COLORED_FORMATTED_TIME_LEN"] = {
			"\124cff%.2x%.2x00%d天%02d时%02d分%02d秒\124r",
			"\124cff%.2x%.2x00%d时%02d分%02d秒\124r",
			"\124cff%.2x%.2x00%d分%02d秒\124r",
			"\124cff%.2x%.2x00%d秒\124r",
		};
		L["FORMATTED_TIME_LEN"] = {
			"%d天%02d时%02d分%02d秒",
			"%d时%02d分%02d秒",
			"%d分%02d秒",
			"%d秒",
		};
		L["FORMATTED_TIME"] = "%Y年%m月%d日\n%H:%M:%S";
		L["TIME_NA"] = "\124cffff0000未知\124r";
		L["UI_TITLE"] = "ALA TRADE UI \124cff00ff00随机附魔的绿装无法保存属性和词缀\124r";
		L["DBIcon_Text"] = "\124cff00ff00左键\124r 搜索缓存的物品价格\n\124cff00ff00右键\124r 打开设置界面";
		L["PRCIE_NOT_CACHED"] = "无数据";
		L["ITEM_COUNT"] = "物品数";
		L["MoneyString_Dec_Char_Format"] = {
			"%d金%02d银%02d.%02d铜",
			"%d银%02d.%02d铜",
			"%d.%02d铜",
		};
	else
		L["pop_status"] = "Cleaning up...";
		L["Scan full finished."] = "Scan finished";
		L["Scan normal finished."] = "Scan finished";
		L["pages"] = "Pages: current/cached/total ";
		L["PRICE"] = "Price";
		L["HISTORY_PRICE"] = "History Price";
		L["AH_PRICE"] = "AH";
		L["VENDOR_PRICE"] = "VENDOR";
		L["CACHE_TIME"] = "Cache Time";
		L["UNKOWN"] = "Unkown";
		L["BOP_ITEM"] = "BOP";
		L["QUEST_ITEM"] = "Quest items";
		L["6H"] = "\124cffffff006hours ago\124r";
		L["24H"] = "\124cffff000024hours ago\124r";
		L["Disenchant"] = "Disenchant";
		L["DURATION"] = "Duration";
		L["ExactQuery"] = "Exact";
		L["Reset"] = "Reset";
		L["CacheAll"] = "CacheAll";
		L["timeLeft"] = {
			[1] = "\124cffff0000Less than 30min\124r",
			[2] = "\124cffff7f7f30mins-2hours\124r",
			[3] = "\124cffffff002hours-8hours\124r",
			[4] = "\124cff00ff008hours-24hours\124r",
		};
		L["buyout"] = "buyout ";
		L["configButton"] = "config";
		L["close"] = "close";
		L["OK"] = "OK";
		L["showEmpty"] = "Show items unrecorded prices";
		L["show_vendor_price"] = "Show vendor price (for single item)";
		L["show_vendor_price_multi"] = "Show vendor price (for current stack size)";
		L["show_ah_price"] = "Show AH price (for single item)";
		L["show_ah_price_multi"] = "Show AH price (for current stack size)";
		L["show_disenchant_price"] = "Show disenchant price ";
		L["show_disenchant_detail"] = "Show disenchant details";
		L["cache_history"] = "Cache history price. \124cff00ff00Take up a lot of ram\124r";
		L["show_DBIcon"] = "Show icon around minimap";
		L["avoid_stuck_cost"] = "Speed of full scan \124cffff0000Warning: Pls make this value lower if the realm contains too many players.\124r";
		L["data_valid_time"] = "Baseline of time display";
		L["auto_clean_time"] = "Auto clean data older than ";
		L["TIME900"] = "15mins";
		L["TIME43200"] = "12hours";
		L["TIME86400"] = "24hours";
		L["TIME2592000"] = "30days";
		L["SORT_METHOD"] = {
			[1] = "ID",
			[2] = "Quality",
			[3] = "Name",
			[4] = "Price",
			[5] = "Cached time",
		};
		L["COLORED_FORMATTED_TIME_LEN"] = {
			"\124cff%.2x%.2x00%dd %02dh %02dm %02ds\124r",
			"\124cff%.2x%.2x00%dh %02dm %02ds\124r",
			"\124cff%.2x%.2x00%dm %02ds\124r",
			"\124cff%.2x%.2x00%ds\124r",
		};
		L["FORMATTED_TIME_LEN"] = {
			"%dd %02dh %02dm %02ds",
			"%dh %02dm %02ds",
			"%dm %02dsr",
			"%ds",
		};
		L["FORMATTED_TIME"] = "%Y-%m-%d\n%H:%M:%S";
		L["TIME_NA"] = "\124cffff0000NA\124r";
		L["UI_TITLE"] = "ALA TRADE UI \124cff00ff00Inaccurate for random-enchat green\124r";
		L["DBIcon_Text"] = "\124cff00ff00Left click\124r Search cached price.\n\124cff00ff00Right Click\124r Configure.";
		L["PRCIE_NOT_CACHED"] = "No data";
		L["ITEM_COUNT"] = "Item count";
		L["MoneyString_Dec_Char_Format"] = {
			"%dG%02dS%02d.%02dC",
			"%dS%02d.%02dC",
			"%d.%02dC",
		};
	end
end


local setting = {
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
	frameFontSize = 15,
	frameFontOutline = "NORMAL",
};

local function _log_(...)
	-- print(date('\124cff00ff00%H:%M:%S\124r'), ...);
end
local function _error_(...)
	print(date('\124cffff0000%H:%M:%S\124r'), ...);
end
local function _noop_()
end

local ADDON_PREFIX = "ALATRADE";
local ADDON_MSG_CONTROL_CODE_LEN = 6;
local ADDON_MSG_QUERY = "_query";
local ADDON_MSG_REPLY = "_reply";
local ADDON_MSG_PUSH = "_push_";
local ADDON_MSG_PULL = "_pull_";

local BATCH_PER_PAGE = 50;
local BIG_NUMBER = 4294967295;
local SCAN_NORMAL_INTERVAL = 4;		-- ACTUALLY 4
local SCAN_FULL_INTERVAL = 900;		-- ACTUALLY 900
----------------------------------------------------------------------------------------------------
local merc = {  };
_G.__ala_meta__.merc = merc;
local _EventHandler = CreateFrame("Frame");
local config = nil;
-- [id] = { name, buyoutPriceSingle, count, quality, vendorPrice, texture, cache_time, link, [0] = history{ { buyoutPriceSingle, count, cache_time }, },  }
local cache = nil;
-- [name] = id
local cache2 = nil;
-- { id, }
local cache3 = nil;
local default = {
	avoid_stuck = true,
	avoid_stuck_cost = 1,
	show_vendor_price = true,
	show_vendor_price_multi = true,
	show_ah_price = true,
	show_ah_price_multi = true,
	show_disenchant_price = true,
	show_disenchant_detail = true,
	prev_cache_all = time(),		-- un-configurable
	sort_method = 1,		-- auto
	sort_method_seq = -1,	-- auto
	cache_history = true,
	data_valid_time = 3600,	-- in second
	auto_clean_time = 0,
	minimapPos = 165,		-- auto
	show_DBIcon = false,	-- 163 ONLY
	showEmpty = false,
};
local _callback_after_cache = {  };

do	-- MISC
	local temp_identify = 0;
	function merc.gen_identify()
		temp_identify = temp_identify + 1;
		return temp_identify;
	end
	function _G._163_ALA_TRADE_ENABLE_UI()
		default.show_DBIcon = true;
	end
end

do	-- util
	local goldicon    = "\124TInterface\\MoneyFrame\\UI-GoldIcon:12:12:0:0\124t"
	local silvericon  = "\124TInterface\\MoneyFrame\\UI-SilverIcon:12:12:0:0\124t"
	local coppericon  = "\124TInterface\\MoneyFrame\\UI-CopperIcon:12:12:0:0\124t"
	function merc.MoneyString_Dec(copper)
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
	function merc.MoneyString(copper)
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
	function merc.MoneyString_Dec_Char(copper)
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
	function merc.seconds_to_colored_formatted_time_len(sec)
		local p = max(0.0, 1.0 - sec / config.data_valid_time);
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
	function merc.seconds_to_colored_formatted_time(sec)
		if sec and type(sec) == 'number' then
			return date(L["FORMATTED_TIME"], sec);
		end
	end
	function merc.seconds_to_formatted_time_len(sec)
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

do	-- InsertLink
	if not _G.ALA_HOOK_ChatEdit_InsertLink then
		local handlers_name = {  };
		local handlers_link = {  };
		function _G.ALA_INSERT_LINK(link, ...)
			if not link then return; end
			if #handlers_link > 0 then
				for _, func in next, handlers_link do
					if func(link, ...) then
						return true;
					end
				end
			end
		end
		function _G.ALA_INSERT_NAME(name, ...)
			if not name then return; end
			if #handlers_name > 0 then
				for _, func in next, handlers_name do
					if func(name, ...) then
						return true;
					end
				end
			end
		end
		function _G.ALA_HOOK_ChatEdit_InsertName(func)
			for _, v in next, handlers_name do
				if func == v then
					return;
				end
			end
			tinsert(handlers_name, func);
		end
		function _G.ALA_UNHOOK_ChatEdit_InsertName(func)
			for i, v in next, handlers_name do
				if func == v then
					tremove(handlers_name, i);
					return;
				end
			end
		end
		function _G.ALA_HOOK_ChatEdit_InsertLink(func)
			for _, v in next, handlers_link do
				if func == v then
					return;
				end
			end
			tinsert(handlers_link, func);
		end
		function _G.ALA_UNHOOK_ChatEdit_InsertLink(func)
			for i, v in next, handlers_link do
				if func == v then
					tremove(handlers_link, i);
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

do	-- query auction
	local _processing_cache = false;
	local _processing_scan_full = false;
	local _processing_scan_normal = false;
	local _processing_scan__GLOBAL = false;
	local cache_time = nil;
	local _do_cache_temp_table = false;
	local _cache_temp_table = {  };
	local _prev_queryString_page0 = nil;
	local _cur_queryString_nPages = 0;
	local _do_caching_next = true;
	local function scanning()
		return _processing_scan__GLOBAL;
	end
	local function cleanup_cache_temp()
		for id, info in next, cache do
			local temp = info.temp;
			if temp then
				wipe(temp);
			end
		end
	end
	local _cleanup_hash = {  };
	local _last_query_page = nil;
	do	-- hook API
		local function hooked(queryString, minLevel, maxLevel, current_page, can_use, quality, scan_full, exactMatch, filter)
			_last_query_page = current_page;
			if scan_full or current_page == 0 then
				wipe(_cleanup_hash);
				cleanup_cache_temp();
				_log_("wipe hook");
			end
			if not scan_full then
				merc.halt_scan_full();
				if current_page == 0 then
					_prev_queryString_page0 = queryString;
					_do_caching_next = true;
					_cur_queryString_nPages = 0;
				else
					if _prev_queryString_page0 ~= queryString then
						_do_caching_next = false;
					else
						_cur_queryString_nPages = _cur_queryString_nPages + 1;
					end
				end
			else
				_processing_scan_normal = false;
				_do_cache_temp_table = false;
				_do_caching_next = true;
			end
			-- _processing_scan_full = scan_full;
			-- if not scan_full then
				_processing_scan__GLOBAL = true;
			-- end
			_log_(queryString, current_page, scan_full, exactMatch);
		end
		-- hooksecurefunc("QueryAuctionItems", hooked);
		local ____CanSendAuctionQuery = CanSendAuctionQuery;
		function _G.CanSendAuctionQuery()
			if _processing_cache then
				return false, false;
			end
			return ____CanSendAuctionQuery();
		end
		local ____QueryAuctionItems = QueryAuctionItems;
		function _G.QueryAuctionItems(queryString, minLevel, maxLevel, current_page, can_use, quality, scan_full, exactMatch, filter)
			if scan_full then
				if not select(2, CanSendAuctionQuery()) then
					return;
				end
			else
				if not CanSendAuctionQuery() then
					return;
				end
			end
			hooked(queryString, minLevel, maxLevel, current_page, can_use, quality, scan_full, exactMatch, filter);
			return ____QueryAuctionItems(queryString, minLevel, maxLevel, current_page, can_use, quality, scan_full, exactMatch, filter);
		end
	end
	local __QueryAuctionItems = QueryAuctionItems;
	local __CanSendAuctionQuery = CanSendAuctionQuery;
	--
	do	-- frame event status stack
		local status = {  };
		function merc.push_status(frame, event)
			if frame:IsEventRegistered(event) then
				frame:UnregisterEvent(event);
				tinsert(status, frame);
				tinsert(status, event);
			end
		end
		function merc.pop_status()
			if #status > 0 then
				_log_(L["pop_status"]);
				for i = #status, 2, -2 do
					status[i - 1]:RegisterEvent(status[i]);
					tremove(status, i);
					tremove(status, i - 1);
				end
			end
		end
		function merc.push_known()
			if AuctionFrameBrowse then
				merc.push_status(AuctionFrameBrowse, "AUCTION_ITEM_LIST_UPDATE");
			end
			if BaudAuctionFrame then
				merc.push_status(BaudAuctionFrame, "AUCTION_ITEM_LIST_UPDATE");
			end
			if Atr_core then
				merc.push_status(Atr_core, "AUCTION_ITEM_LIST_UPDATE");
			end
		end
	end
	do	-- cache
		local update_frame = CreateFrame("Frame");
		local head = nil;
		local tail = nil;
		local cur_nPage = nil;
		local function ticker_cache_auction_item(head, tail)
			local p0 = debugprofilestop();
			for i = head, tail do
				local name, texture, count, quality, canUse, level, huh, minBid, minIncrement, buyoutPrice,
					bidAmount, highBidder, bidderFullName, owner, ownerFullName, saleStatus, id, unk_bool = GetAuctionItemInfo("list", i);
				if id > 0 then
					local singlePrice, singleBid;
					if buyoutPrice and buyoutPrice > 0 then
						local c = cache[id];
						singlePrice = buyoutPrice / count;
						if c then
							local temp = c.temp;
							if not temp then
								temp = {  };
								c.temp = temp;
							end
							if c[1] == nil or c[1] == "" then
								c[1] = name;
							end
							-- c[2] = singlePrice;
							-- c[3] = count;
							c[4] = c[4] or quality;
							c[5] = c[5] or select(11, GetItemInfo(id));
							if c[6] == nil or c[6] == 0 or c[6] == "" then
								c[6] = texture;
							end
							-- c[7] = cache_time;
							if not _cleanup_hash[id] then
								temp[1] = singlePrice;
								temp[2] = count;
								temp[3] = cache_time;
							elseif temp[1] > singlePrice then
								temp[1] = singlePrice;
								temp[2] = temp[2] + count;
								temp[3] = cache_time;
							else
								temp[2] = temp[2] + count;
							end
						else
							cache[id] = {
								name,
								nil,-- singlePrice,
								nil,-- count,
								quality,
								select(11, GetItemInfo(id)),
								texture,
								nil,-- cache_time,
								temp = { singlePrice, count, cache_time, },
							};
							tinsert(cache3, id);
						end
						_cleanup_hash[id] = true;
					end
					if name and name ~= "" then
						cache2[name] = id;
					end
					singlePrice = singlePrice or BIG_NUMBER;
					singleBid = bidAmount and (bidAmount / count) or 0;
					if _do_cache_temp_table then
						--	1_buyoutPrice_single_item, 2_bidPrice_single_item, 3_count, 4_owner, 5_timeLeft, 6_texture, 7_link, 8_page, 9_buyoutPrice
						_cache_temp_table.name = name;
						local ele = { singlePrice, singleBid, count, owner, GetAuctionItemTimeLeft("list", i), texture, GetAuctionItemLink("list", i), _last_query_page, buyoutPrice, };
						if _cache_temp_table[1] == nil then
							_cache_temp_table[1] = ele;
						elseif _cache_temp_table[#_cache_temp_table][1] < singlePrice then
							tinsert(_cache_temp_table, ele);
						else
							for i, v in ipairs(_cache_temp_table) do
								if v[1] == singlePrice then
									for j = i, #_cache_temp_table do
										local v2 = _cache_temp_table[j];
										if v2[1] > singlePrice or (v2[1] == singlePrice and v2[2] >= singleBid) then
											tinsert(_cache_temp_table, j, ele);
											break;
										end
									end
									break;
								elseif v[1] > singlePrice then
									tinsert(_cache_temp_table, i, ele);
									break;
								end
							end
						end
					end
				end
				if config.avoid_stuck and (i % 100 == 0) and (debugprofilestop() - p0 > config.avoid_stuck_cost) then
					return i;
				end
			end
			return tail;
		end
		local function update_func()
			head = ticker_cache_auction_item(head, tail) + 1;
			merc.notify_progress_full_scan(head, tail);
			_log_("cache_update_func", head, tail);
			if head > tail then
				merc.halt_cache();
				merc.notify_finish_scan__GLOBAL();	-- query sent by other addon
				merc.notify_finish_scan_normal_page();
				merc.notify_finish_scan_full();	-- full scan trigger event only one time
			end
		end
		function merc.cache_auction_item(batch)
			cache_time = time();
			head = 1;
			tail = batch;
			_processing_cache = true;
			update_frame:SetScript("OnUpdate", update_func);
		end
		function merc.AUCTION_ITEM_LIST_UPDATE()
			if not _do_caching_next then
				return;
			end
			if scanning() then
				local batch, count = GetNumAuctionItems("list");
				if not merc.validate_full_scan_full(batch > BATCH_PER_PAGE) then
					-- _log_("validate full failed")
					return;
				end
				cur_nPage = ceil(count / BATCH_PER_PAGE);
				if not merc.validate_scan_normal(cur_nPage) then
					-- _log_("validate normal failed")
					return;
				end
				_log_("AUCTION_ITEM_LIST_UPDATE", batch, count);
				merc.cache_auction_item(batch);
			end
		end
		function merc.finish_cache()
			for id, c in next, cache do
				local temp = c.temp;
				if temp then
					if config.cache_history and c[2] then
						c[0] = c[0] or {  };
						tinsert(c[0], { c[2], c[3], c[7], });
					end
					c[2] = temp[1];
					c[3] = temp[2];
					c[7] = temp[3];
					wipe(temp);
				end
			end
		end
		function merc.halt_cache()
			update_frame:SetScript("OnUpdate", nil);
			_processing_cache = false;
			if _processing_scan_full or (cur_nPage == _cur_queryString_nPages + 1 and _cur_queryString_nPages == _last_query_page) then
				merc.finish_cache();
				cur_nPage = nil;
				_cur_queryString_nPages = 0;
				_last_query_page = nil;
			end
			-- cache_time = nil;
			-- head = nil;
			-- tail = nil;
		end
		function merc.caching()
			return _processing_cache;
		end
	end
	do	-- scan full
		local update_frame = CreateFrame("Frame");
		local _scan_full_waiting_for_paid_back = false;		-- to make it hanle only once
		local _prev_finish_scan_full = time() - 36000;
		local function pop_func()
			update_frame:SetScript("OnUpdate", nil);
			merc.pop_status();
		end
		local function update_func()
			if CanSendAuctionQuery() then
				__QueryAuctionItems("abcdefghxyz", 43, 43, 0, 7, 0);
				update_frame:SetScript("OnUpdate", pop_func);
			end
		end
		function merc.validate_full_scan_full(check)
			if not _processing_scan_full and not check then
				return true;
			end
			if time() - _prev_finish_scan_full < 600 then
				return false;
			end
			if _scan_full_waiting_for_paid_back then
				_scan_full_waiting_for_paid_back = false;
				return true;
			end
			return false;
		end
		function merc.scan_full()
			if select(2, __CanSendAuctionQuery()) then
				AuctionFrameBrowse.isSearching = 1;
				update_frame:SetScript("OnUpdate", nil);
				_processing_scan_full = true;
				_do_cache_temp_table = false;
				_scan_full_waiting_for_paid_back = true;
				merc.push_known();
				wipe(_cleanup_hash);
				SortAuctionClearSort("list");
				__QueryAuctionItems("", nil, nil, 0, 0, 0, true);
				--__QueryAuctionItems(queryString, minLevel, maxLevel, current_page, nil, nil, false, exactMatch, filter)
				-- name, 最小等级筛选, 最大等级筛选, 第几页?,  可用物品筛选, 品质筛选, 查询所有拍卖数据, 精确匹配,  选择的左侧按钮, 
				merc.HideProgress();
				return true;
			end
			return false;
		end
		function merc.notify_progress_full_scan(curVal, maxVal)
			if _processing_scan_full then
				merc.ShowProgress(curVal - 1, maxVal);
			end
		end
		local function history_db_scan_full()
			for id, v in next, cache do
				if not v[7] then
					v[2] = nil;
					v[3] = 0;
				elseif v[2] and cache_time - v[7] > 900 then
					if config.cache_history then
						v[0] = v[0] or {  };
						tinsert(v[0], { v[2], v[3], v[7], });
					end
					v[2] = nil;
					v[3] = 0;
					v[7] = cache_time;
				end
			end
		end
		function merc.notify_finish_scan_full()
			if _processing_scan_full then
				history_db_scan_full();
				merc.halt_scan_full(true);
				_prev_finish_scan_full = time();
				for _, func in next, _callback_after_cache do
					func();
				end
				_log_(L["Scan full finished."]);
				PlaySound(SOUNDKIT.AUCTION_WINDOW_CLOSE);
				merc.CacheAll_Disable();
			end
		end
		function merc.halt_scan_full(clear)
			_processing_scan_full = false;
			_scan_full_waiting_for_paid_back = false;
			AuctionFrameBrowse.isSearching = nil;
			if clear then
				update_frame:SetScript("OnUpdate", update_func);
			end
		end
	end
	do	-- scan normal
		local update_frame = CreateFrame("Frame");
		local _npage = nil;
		local _cached_pages = nil;
		local _name = nil;
		local _exact = nil;
		local function update_func()
			if not _npage then
				return;
			end
			if _cached_pages < _npage then
				if __CanSendAuctionQuery() then
					__QueryAuctionItems(_name, nil, nil, _cached_pages, nil, nil, false, _exact, nil);
				end
			else
				update_frame:SetScript("OnUpdate", nil);
				_name = nil;
				_exact = nil;
			end
		end
		function merc.validate_scan_normal(npage)
			if not _processing_scan_normal then
				return true;
			end
			if not _cached_pages then
				return false;
			end
			_npage = npage;
			return true;
		end
		function merc.scan_normal(name, exact, cache_temp)
			if _processing_cache then
				return false;
			end
			_log_("scan_normal");
			_processing_scan_normal = true;
			_name = name;
			_exact = exact;
			if cache_temp then
				_do_cache_temp_table = true;
				wipe(_cache_temp_table);
			end
			merc.push_known();
			wipe(_cleanup_hash);
			if __CanSendAuctionQuery() then
				AuctionFrameBrowse.isSearching = 1;
				_cached_pages = 0;
				_npage = nil;
				__QueryAuctionItems(name, nil, nil, 0, nil, nil, false, exact, nil);
			else
				_cached_pages = 0;
				_npage = BIG_NUMBER;
				update_frame:SetScript("OnUpdate", update_func);
			end
			merc.HideProgress();
			return true;
		end
		function merc.notify_finish_scan_normal_page()
			if _processing_scan_normal then
				_cached_pages = _cached_pages + 1;
				merc.ShowProgress(_cached_pages, _npage);
				merc.notify_scan_for_sell_pages(_cached_pages, _npage);
				_log_("notify_finish_scan_normal_page", _cached_pages, _npage);
				if _cached_pages >= _npage then
					merc.notify_finish_scan_normal();
					update_frame:SetScript("OnUpdate", nil);
				else
					update_frame:SetScript("OnUpdate", update_func);
				end
			end
		end
		local function history_db_scan_normal()
			local id = cache2[_name];
			if id then
				local v = cache[id];
				if v and (cache_time - v[7] > 10) then
					if config.cache_history then
						v[0] = v[0] or {  };
						tinsert(v[0], { v[2], v[3], v[7], });
					end
					v[2] = nil;
					v[3] = 0;
					v[7] = cache_time;
				end
			end
		end
		function merc.notify_finish_scan_normal()
			if _processing_scan_normal then
				_log_("notify_finish_scan_normal");
				history_db_scan_normal();
				merc.notify_finish_scan_for_sell();
				merc.halt_scan_normal();
				_log_(L["Scan normal finished."]);
				PlaySound(SOUNDKIT.AUCTION_WINDOW_CLOSE);
				for _, func in next, _callback_after_cache do
					func();
				end
			end
		end
		function merc.halt_scan_normal()
			_log_("halt_scan_normal");
			_processing_scan_normal = false;
			_do_cache_temp_table = false;
			update_frame:SetScript("OnUpdate", nil);
			_name = nil;
			_exact = nil;
			AuctionFrameBrowse.isSearching = nil;
			merc.pop_status();
		end
	end
	function merc.notify_finish_scan__GLOBAL()
		_processing_scan__GLOBAL = false;
	end
	do	-- scan normal for sell
		local _scanning_name = nil;
		local _call_back = nil;
		function merc.scan_for_sell(name, callback)
			if merc.scan_normal(name, true, true) then
				_scanning_name = name;
				_call_back = callback;
				merc.HideProgress();
				return true;
			else
				return false;
			end
		end
		function merc.notify_scan_for_sell_pages(_cached_pages, _npage)
			if _call_back then
				_call_back(_scanning_name, _cache_temp_table, false, _cached_pages, _npage);
			end
		end
		function merc.notify_finish_scan_for_sell()
			if _scanning_name then
				if _call_back then
					_call_back(_scanning_name, _cache_temp_table, true);
				end
			end
			merc.halt_scan_for_sell();
		end
		function merc.halt_scan_for_sell()
			_scanning_name = nil;
			_call_back = nil;
		end
	end
	function merc.AUCTION_HOUSE_SHOW()
		merc.halt_cache();
		merc.halt_scan_normal();
		merc.halt_scan_full();
		merc.halt_scan_for_sell();
		merc.notify_finish_scan__GLOBAL();
	end
	function merc.AUCTION_HOUSE_CLOSED()
		merc.halt_cache();
		merc.halt_scan_normal();
		merc.halt_scan_full(true);
		merc.halt_scan_for_sell();
		merc.notify_finish_scan__GLOBAL();
	end
end

do	-- query price
	function merc.query_ah_price_by_id_simple(id)
		local c = cache[id];
		if c then
			if c[2] then
				return c[2];
			else
				local H = c[0];
				if H then
					for i = #H, 1, -1 do
						if H[i][1] then
							return H[i][1];
						end
					end
				end
			end
		end
	end
	function merc.query_ah_price_by_id(id)
		local c = cache[id];
		if c then
			if c[2] then
				local t = time() - c[7];
				return c[2], t, merc.seconds_to_colored_formatted_time_len(t);
			else
				local H = c[0];
				if H then
					for i = #H, 1, -1 do
						if H[i][1] then
							local t = time() - H[i][3];
							return H[i][1], t, merc.seconds_to_colored_formatted_time_len(t);
						end
					end
				end
			end
		end
	end
	function merc.query_ah_price_by_name(name)
		local id = cache2[name];
		if id then
			return merc.query_ah_price_by_id(id);
		end
	end
	----------------------------------------------------------------
	local material_sold_by_vendor = {
		[2880] = 100,		-- 弱效助熔剂
		[3466] = 2000,		-- 强效助熔剂
		[3857] = 500,		-- 煤块
		[18567] = 150000,	-- 元素助熔剂
		[3371] = 4,			-- 空瓶
		[3372] = 40,		-- 铅瓶
		[8925] = 500,		-- 水晶瓶
		[6217] = 124,		-- 铜棒
		[4470] = 38,		-- 普通木柴
		[11291] = 4500,		-- 星木
		[159] = 5,			-- 清凉的泉水
		[2678] = 2,			-- 甜香料
		[2692] = 40,		-- 辣椒
		[3713] = 160,		-- 舒心草
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
		[4399] = 200,		-- 木柴
		[4400] = 2000,		-- 沉重的树干
		[6530] = 100,		-- 夜色虫
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
		local frame = CreateFrame("Frame");
		frame:RegisterEvent("GET_ITEM_INFO_RECEIVED");
		frame:SetScript("OnEvent", function(self, event, arg1, arg2)
			if arg2 and material_sold_by_vendor[arg1] then
				if not cache_item_info(arg1) then
					return;
				end
				local n = 0;
				for _ in next, material_sold_by_vendor_by_name do
					n = n + 1;
				end
				if n >= num_material_sold_by_vendor then
					self:SetScript("OnEvent", nil);
					self:UnregisterAllEvents();
					frame = nil;
				end
			end
		end);
		local function cache()
			local n = 0;
			for id, price in next, material_sold_by_vendor do
				if cache_item_info(id) then
					n = n + 1;
				end
			end
			if n >= num_material_sold_by_vendor then
				if frame then
					frame:SetScript("OnEvent", nil);
					frame:UnregisterAllEvents();
					frame = nil;
				end
				return true;
			end
			return false;
		end
		if not cache() then
			C_Timer.After(1.0, cache);
		end
	end
	--
	function merc.get_material_vendor_price_by_link(link, num)
		local id = tonumber(select(3, strfind(link, "item:(%d+)")));
		return id and merc.get_material_vendor_price_by_id(id, num);
	end
	function merc.get_material_vendor_price_by_id(id, num)
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
	function merc.get_material_vendor_price_by_name(name, num)
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

do	-- misc query
	function merc.query_last_cache_time_by_id(id)
		local c = cache[id];
		if c then
			if c[2] then
				return c[7];
			else
				local H = c[0];
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
	function merc.query_quality_by_id(id)
		if cache[id] then
			return cache[id][4];
		end
	end
	function merc.query_id_by_name(name)
		local id = cache2[name];
		return id;
	end
	function merc.query_quality_by_name(name)
		local id = cache2[name];
		if id and cache[id] then
			return cache[id][4];
		end
	end
	function merc.query_name_by_id(id)
		return cache[id] and cache[id][1] or nil;
	end
end

-- CREDIT Auctionator
do	-- disenchant db
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
			[LE_ITEM_CLASS_ARMOR] = {
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
					-- { 66, 99, 99.5, 1, 22448, 0.5, 1, 20725, },
				},
				[4] = {
					{ 40, 45, 33.33, 2, 11177, 33.33, 3, 11177, 33.33, 4, 11177, },
					{ 46, 50, 33.33, 2, 11178, 33.33, 3, 11178, 33.33, 4, 11178, },
					{ 51, 55, 33.33, 2, 14343, 33.33, 3, 14343, 33.33, 4, 14343, },
					{ 56, 60, 100, 1, 20725, },
					{ 61, 94, 50, 1, 20725, 50, 2, 20725, },
					-- { 61, 80, 50, 1, 20725, 50, 2, 20725, },
					-- { 95, 100, 50, 1, 22450, 50, 2, 22450, },
				},
			},
			[LE_ITEM_CLASS_WEAPON] = {
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
					-- { 66, 99, 99.5, 1, 22448, 0.5, 1, 20725, },
				},
				[4] = {
					{ 40, 45, 33.33, 2, 11177, 33.33, 3, 11177, 33.33, 4, 11177, },
					{ 46, 50, 33.33, 2, 11178, 33.33, 3, 11178, 33.33, 4, 11178, },
					{ 51, 55, 33.33, 2, 14343, 33.33, 3, 14343, 33.33, 4, 14343, },
					{ 56, 60, 100, 1, 20725, },
					{ 61, 94, 33.33, 1, 20725, 66.66, 2, 20725, },
					-- { 61, 80, 33.3, 1, 20725, 66.6, 2, 20725, },
					-- { 95, 100, 50, 1, 22450, 50, 2, 22450, },
				},
			},
		};
		local frame = CreateFrame("Frame");
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
	function merc.get_disenchant_info(rarity, item_type, item_level)	-- { rate, num, id, }
		if DB[item_type] and DB[item_type][rarity] and DB[item_type][rarity][item_level] then
			return DB[item_type][rarity][item_level];
		end
	end
	function merc.get_disenchant_meterial_name(id)
		if not ITEM[id] then
			cache_item_info(id);
		end
		return ITEM[id];
	end
end

do	-- hook tooltip
	-- price
	local function merc_hook_tooltip(tip, id, num)
		local name, link, rarity, item_level, _, _, _, _, _, _, vdp, item_type, _, bind_type = GetItemInfo(id);
		if config.show_vendor_price then
			if vdp and vdp > 0 then
				if num > 1 then
					tip:AddDoubleLine(L["VENDOR_PRICE"] .. " x 1", merc.MoneyString(vdp), 1, 0.5, 0, 1, 1, 1);
				else
					tip:AddDoubleLine(L["VENDOR_PRICE"], merc.MoneyString(vdp), 1, 0.5, 0, 1, 1, 1);
				end
			end
		end
		if num > 1 and config.show_vendor_price_multi then
			tip:AddDoubleLine(L["VENDOR_PRICE"] .. " x " .. num, merc.MoneyString(vdp * num), 1, 0.5, 0, 1, 1, 1);
		end
		if config.show_ah_price or config.show_ah_price_multi then
			if bind_type == 1 then
				tip:AddDoubleLine(L["AH_PRICE"], L["BOP_ITEM"], 1, 0.5, 0, 1, 1, 1);
			elseif bind_type == 4 then
				tip:AddDoubleLine(L["AH_PRICE"], L["QUEST_ITEM"], 1, 0.5, 0, 1, 1, 1);
			else
				local ahp, timediff, timedifftext = merc.query_ah_price_by_id(id);
				if ahp then
					if timediff > config.data_valid_time then
						if config.show_ah_price then
							if num > 1 then
								tip:AddDoubleLine(L["AH_PRICE"] .. " x 1", timedifftext .. " " .. merc.MoneyString(ahp), 1, 0.5, 0, 1, 1, 1);
							else
								tip:AddDoubleLine(L["AH_PRICE"], timedifftext .. " " .. merc.MoneyString(ahp), 1, 0.5, 0, 1, 1, 1);
							end
						end
						if num > 1 and config.show_ah_price_multi then
							tip:AddDoubleLine(L["AH_PRICE"] .. " x " .. num, timedifftext .. " " .. merc.MoneyString(ahp * num), 1, 0.5, 0, 1, 1, 1);
						end
					else
						if config.show_ah_price then
							if num > 1 then
								tip:AddDoubleLine(L["AH_PRICE"] .. " x 1", timedifftext .. " " .. merc.MoneyString(ahp), 1, 0.5, 0, 1, 1, 1);
							else
								tip:AddDoubleLine(L["AH_PRICE"], timedifftext .. " " .. merc.MoneyString(ahp), 1, 0.5, 0, 1, 1, 1);
							end
						end
						if num > 1 and config.show_ah_price_multi then
							tip:AddDoubleLine(L["AH_PRICE"] .. " x " .. num, timedifftext .. " " .. merc.MoneyString(ahp * num), 1, 0.5, 0, 1, 1, 1);
						end
					end
				else
					tip:AddDoubleLine(L["AH_PRICE"], L["UNKOWN"], 1, 0.5, 0, 1, 1, 1);
				end
			end
		end
		local deinfo = merc.get_disenchant_info(rarity, item_type, item_level);
		if deinfo then
			if config.show_disenchant_price then
				local disenchant_price = 0;
				for i = 1, #deinfo, 3 do
					local rate, num, id = deinfo[i], deinfo[i + 1], deinfo[i + 2];
					local p = merc.query_ah_price_by_id(id);
					if p then
						disenchant_price = disenchant_price + p * num * rate * 0.01;
					end
				end
				if disenchant_price > 0 then
					tip:AddDoubleLine(L["Disenchant"], merc.MoneyString(disenchant_price), 1, 0.5, 0, 1, 1, 1);
				else
					tip:AddDoubleLine(L["Disenchant"], L["UNKOWN"], 1, 0.5, 0, 1, 1, 1);
				end
			end
			if config.show_disenchant_detail then
				if not config.show_disenchant_price then
					tip:AddLine(L["Disenchant"], 1, 0.5, 0);
				end
				for i = 1, #deinfo, 3 do
					local rate, num, id = deinfo[i], deinfo[i + 1], deinfo[i + 2];
					tip:AddDoubleLine("    " .. rate .. "%", (merc.get_disenchant_meterial_name(id) or L["UNKOWN"]) .. " x " .. num .. "    ", 1, 1, 1);
				end
			end
		end
		tip:Show();
	end
	function merc.hook_tooltip()
		hooksecurefunc(GameTooltip, "SetMerchantItem",
			function(tip, index)
				-- local link = GetMerchantItemLink(index);
				local id = GetMerchantItemID(index);
				local name, _, _, num = GetMerchantItemInfo(index);
				if id then
					merc_hook_tooltip(tip, id, num);
				end
			end
		);
		hooksecurefunc(GameTooltip, "SetBuybackItem",
			function(tip, index)
				local link = GetBuybackItemLink(index);
				if link then
					local id = tonumber(select(3, strfind(link, "item:(%d+)")) or nil);
					local name, _, _, num = GetBuybackItemInfo(index);
					merc_hook_tooltip(tip, id, num);
				end
			end
		);
		hooksecurefunc(GameTooltip, "SetBagItem",
			function(tip, bag, slot)
				local _, num, _, _, _, _, link, _, _, id = GetContainerItemInfo(bag, slot);
				if id then
					-- local _, _, name = strfind(link, "%[([^]]+)%]")
					merc_hook_tooltip(tip, id, num);
				end
			end
		);
		hooksecurefunc(GameTooltip, "SetAuctionItem",
			function(tip, type, index)
				local name, _, num, _, _, _, _, _, _, _, _, _, _, _, _, _, id = GetAuctionItemInfo(type, index);
				if id then
					-- local link = GetAuctionItemLink(type, index);
					merc_hook_tooltip(tip, id, num);
				end
			end
		);
		hooksecurefunc(GameTooltip, "SetAuctionSellItem",
			function(tip)
				local name, _, num, _, _, _, _, _, _, id = GetAuctionSellItemInfo();
				if id then
					-- local name, link, _, _, _, _, _, _, _, _, _, _, _, bind_type = GetItemInfo(id);
					merc_hook_tooltip(tip, id, num);
				end
			end
		);
		hooksecurefunc(GameTooltip, "SetLootItem",
			function(tip, slot)
				if LootSlotHasItem(slot) and GetLootSlotType(slot) == LOOT_SLOT_ITEM then
					local link = GetLootSlotLink(slot);
					if link then
						local _, name, num = GetLootSlotInfo(slot);
						local id = tonumber(select(3, strfind(link, "item:(%d+)")) or nil);
						merc_hook_tooltip(tip, id, num);
					end
				end
			end
		);
		hooksecurefunc(GameTooltip, "SetLootRollItem",
			function(tip, slot)
				local link = GetLootRollItemLink(slot);
				if link then
					local _, name, num = GetLootRollItemInfo(slot);
					local id = tonumber(select(3, strfind(link, "item:(%d+)")) or nil);
					merc_hook_tooltip(tip, id, num);
				end
			end
		);
		hooksecurefunc(GameTooltip, "SetInventoryItem",
			function(tip, unit, slot)
				-- local link = GetInventoryItemLink(unit, slot);
				-- if link then
					local id = GetInventoryItemID(unit, slot);
					-- local _, _, name = strfind(link, "%[([^]]+)%]")
					if id then
						local num = GetInventoryItemCount(unit, slot);
						merc_hook_tooltip(tip, id, num);
					end
				-- end
			end
		);
		hooksecurefunc(GameTooltip, "SetTradePlayerItem",
			function(tip, index)
				local link = GetTradePlayerItemLink(index);
				if link then
					local id = tonumber(select(3, strfind(link, "item:(%d+)")) or nil);
					local name, _, num = GetTradePlayerItemInfo(index);
					merc_hook_tooltip(tip, id, num);
				end
			end
		);
		hooksecurefunc(GameTooltip, "SetTradeTargetItem",
			function(tip, index)
				local link = GetTradeTargetItemLink(index);
				if link then
					local id = tonumber(select(3, strfind(link, "item:(%d+)")) or nil);
					local name, _, num = GetTradeTargetItemInfo(index);
					merc_hook_tooltip(tip, id, num);
				end
			end
		);
		hooksecurefunc(GameTooltip, "SetQuestItem",
			function(tip, type, index)
				local link = GetQuestItemLink(type, index);
				if link then
					local id = tonumber(select(3, strfind(link, "item:(%d+)")) or nil);
					local name, _, num = GetQuestItemInfo(type, index);
					merc_hook_tooltip(tip, id, num);
				end
			end
		);
		hooksecurefunc(GameTooltip, "SetQuestLogItem",
			function(tip, type, index)
				local name, num, id, _;
				if type == "choice" then
					name, _, num, _, _, id = GetQuestLogChoiceInfo(index);
				else
					name, _, num, _, _, id = GetQuestLogRewardInfo(index)
				end
				if id then
					-- local link = GetQuestLogItemLink(type, index);
					merc_hook_tooltip(tip, id, num);
				end
			end
		);
		hooksecurefunc(GameTooltip, "SetInboxItem",
			function(tip, index, index2)
				index2 = index2 or 1;
				local name, id, _, num = GetInboxItem(index, index2);
				if id then
					-- local link = GetInboxItemLink(index, index2);
					merc_hook_tooltip(tip, id, num);
				end
			end
		);
		--[[
		hooksecurefunc("InboxFrameItem_OnEnter",
			function(self)
				local itemCount = select(8, GetInboxHeaderInfo(self.index))
				local tooltipEnabled = AUCTIONATOR_SHOW_MAILBOX_TIPS == 1 and (
				AUCTIONATOR_V_TIPS == 1 or AUCTIONATOR_A_TIPS == 1 or AUCTIONATOR_D_TIPS == 1
				)

				if tooltipEnabled and itemCount and itemCount > 1 then
				for numIndex = 1, ATTACHMENTS_MAX_RECEIVE do
					local name, _, _, num = GetInboxItem(self.index, numIndex)

					if name then
					local attachLink = GetInboxItemLink(self.index, numIndex) or name

					GameTooltip:AddLine(attachLink)

					if num > 1 then
						Atr_ShowTipWithPricing(GameTooltip, attachLink, num)
					else
						Atr_ShowTipWithPricing(GameTooltip, attachLink)
					end
					end
				end
				end
			end
		);
		--]]
		hooksecurefunc(GameTooltip, "SetSendMailItem",
			function(tip, index)
				-- local link = GetSendMailItemLink(index);
				local name, id, _, num = GetSendMailItem(index);
				if id then
					merc_hook_tooltip(tip, id, num);
				end
			end
		);
		hooksecurefunc(GameTooltip, "SetTradeSkillItem",
			function(tip, index, reagent)
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
					merc_hook_tooltip(tip, id, num);
				end
			end
		);
		hooksecurefunc(GameTooltip, "SetCraftItem",
			function(tip, index, reagent)
				local link = GetCraftReagentItemLink(index, reagent);
				if link then
					local id = tonumber(select(3, strfind(link, "item:(%d+)")) or nil);
					local name, _, num = GetCraftReagentInfo(index, reagent);
					merc_hook_tooltip(tip, id, num);
				end
			end
		);
		hooksecurefunc(GameTooltip, "SetHyperlink",
			function(tip, itemstring, num)
				-- local name, link, _, _, _, _, _, _, _, _, _, _, _, bind_type = GetItemInfo(itemstring);
				-- if link then
				-- 	local id = tonumber(select(3, strfind(link, "item:(%d+)")));
				-- 	merc_hook_tooltip(tip, id, 1);
				-- end
				local id = tonumber(select(3, strfind(itemstring, "item:(%d+)")) or nil);
				if id then
					merc_hook_tooltip(tip, id, 1);
				end
			end
		);
		hooksecurefunc(ItemRefTooltip, "SetHyperlink",
			function(tip, itemstring)
				-- local name, link, _, _, _, _, _, _, _, _, _, _, _, bind_type = GetItemInfo(itemstring);
				-- if link then
				-- 	local id = tonumber(select(3, strfind(link, "item:(%d+)")));
				-- 	merc_hook_tooltip(tip, id, 1);
				-- end
				local id = tonumber(select(3, strfind(itemstring, "item:(%d+)")) or nil);
				if id then
					merc_hook_tooltip(tip, id, 1);
				end
			end
		);
		hooksecurefunc(GameTooltip, "SetItemByID",
			function(tip, id)
				if id then
					merc_hook_tooltip(tip, id, 1);
				end
			end
		);
		hooksecurefunc(ItemRefTooltip, "SetItemByID",
			function(tip, id)
				if id then
					merc_hook_tooltip(tip, id, 1);
				end
			end
		);
		--[[
		hooksecurefunc(GameTooltip, "SetGuildBankItem",
			function(tip, tab, slot)
				local _, num = GetGuildBankItemInfo(tab, slot);
				merc_hook_tooltip(tip, id, 1);
			end
		);
		hooksecurefunc(GameTooltip, 'SetRecipeResultItem',
			function(tip, itemId)
				local link = C_TradeSkillUI.GetRecipeItemLink(itemId)
				local count  = C_TradeSkillUI.GetRecipeNumItemsProduced(itemId)

				Atr_ShowTipWithPricing(tip, link, count)
			end
		);
		hooksecurefunc(GameTooltip, 'SetRecipeReagentItem',
			function(tip, itemId, index)
				local link = C_TradeSkillUI.GetRecipeReagentItemLink(itemId, index)
				local count = select(3, C_TradeSkillUI.GetRecipeReagentInfo(itemId, index))

				Atr_ShowTipWithPricing(tip, link, count)
			end
		);
		]]--
	end
end

do	-- hook Auction
	local CacheAll = nil;
	local SearchDisplay = nil;
	local SearchDisplayScroll = nil;
	local SearchProgress = nil;
	local ExactQueryCheckButton = nil;
	local ResetButton = nil;
	local TimeDropDown = nil;
	local ____QueryAuctionItems = QueryAuctionItems;
	-- name, 最小等级筛选, 最大等级筛选, 第几页?,  可用物品筛选, 品质筛选, 查询所有拍卖数据, 精确匹配,  选择的左侧按钮, 
	function _G.QueryAuctionItems(name, minL, maxL, _arg4, usable, q, all, exact, selected, ...)
		if all then
			return ____QueryAuctionItems(name, minL, maxL, _arg4, usable, q, all, exact, selected, ...);
		elseif AuctionFrameBrowse:IsShown() then
			return ____QueryAuctionItems(name, minL, maxL, _arg4, usable, q, all, ExactQueryCheckButton:GetChecked(), selected, ...);
		else
			return ____QueryAuctionItems(name, minL, maxL, _arg4, usable, q, all, exact, selected, ...);
		end
	end
	local PRICE_TYPE_UNIT = 1;
	local PRICE_TYPE_STACK = 2;
	local CACHES = nil;
	local function set_price(buyoutPrice, cut)
		local name, texture, count, quality, canUse, price, pricePerUnit, stackCount, totalCount, itemID = GetAuctionSellItemInfo();
		if AuctionFrameAuctions.priceType == PRICE_TYPE_UNIT then
			if cut then
				merc.set_buyout_price(buyoutPrice - 1);
				merc.set_start_price(buyoutPrice - 1);
			else
				merc.set_buyout_price(buyoutPrice);
				merc.set_start_price(buyoutPrice);
			end
		elseif AuctionFrameAuctions.priceType == PRICE_TYPE_STACK then
			if cut then
				merc.set_buyout_price(buyoutPrice * count - 1);
				merc.set_start_price(buyoutPrice * count - 1);
			else
				merc.set_buyout_price(buyoutPrice * count);
				merc.set_start_price(buyoutPrice * count);
			end
		end
	end
	function merc.HideProgress()
		SearchProgress:Hide();
		SearchProgress:SetScript("OnUpdate", nil);
	end
	function merc.ShowProgress(curVal, maxVal)
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
	end
	local function NEW_AUCTION_UPDATE_CALLBACK(_name, _caches, _finished, _cached_pages, _npage)
		local name, texture, count, quality, canUse, price, pricePerUnit, stackCount, totalCount, itemID = GetAuctionSellItemInfo();
		SearchDisplay:Show();
		if name and _name == name and _caches[1] then
			CACHES = _caches;
			SearchDisplayScroll:SetNumValue(#_caches);
			if not _finished then
				merc.ShowProgress(_cached_pages, _npage);
			end
			if _finished and _caches[1][1] then
				set_price(_caches[1][1], _caches[1][4] ~= UnitName('player'));
			end
		else
			CACHES = nil;
			SearchDisplayScroll:SetNumValue(0);
		end
	end
	local function TimeDropDown_OnClick(self)
		AuctionFrameAuctions.duration = self.value;
		UIDropDownMenu_SetSelectedValue(TimeDropDown, self.value);
	end
	local function TimeDropDown_Initialize()
		local info = UIDropDownMenu_CreateInfo();
		info.text = "2" .. HOURS;
		info.value = 1;
		info.checked = nil;
		info.func = TimeDropDown_OnClick;
		UIDropDownMenu_AddButton(info);
		info.text = "8" .. HOURS;
		info.value = 2;
		info.checked = nil;
		info.func = TimeDropDown_OnClick;
		UIDropDownMenu_AddButton(info);
		info.text = "24" .. HOURS;
		info.value = 3;
		info.checked = nil;
		info.func = TimeDropDown_OnClick;
		UIDropDownMenu_AddButton(info);
	end
	local function SearchDisplayButton_OnClick(self)
		local index = self:GetDataIndex();
		if CACHES[index] then
			set_price(CACHES[index][1], CACHES[index][4] ~= UnitName('player'));
		end
	end
	local function SearchDisplayButton_OnEnter(self)
		local index = self:GetDataIndex();
		if CACHES[index] then
			GameTooltip:SetOwner(self, "ANCHOR_TOP");
			GameTooltip:SetHyperlink(CACHES[index][7]);
			GameTooltip:Show();
		end
	end
	local function SearchDisplayButton_OnLeave(self)
		if GameTooltip:IsOwned(self) then
			GameTooltip:Hide();
		end
	end
	local function funcToCreateButton(parent, index, buttonHeight)
		local button = CreateFrame("Button", nil, parent);
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
		icon:SetTexture("Interface\\Icons\\inv_misc_questionmark");
		icon:SetSize(buttonHeight - 4, buttonHeight - 4);
		icon:SetPoint("LEFT", 5, 0);
		button.icon = icon;
	
		local title = button:CreateFontString(nil, "OVERLAY");
		title:SetFont(SystemFont_Shadow_Med1:GetFont(), 15, "NORMAL");
		title:SetPoint("LEFT", icon, "RIGHT", 5, 0);
		title:SetWidth(160);
		title:SetJustifyH("LEFT");
		title:SetMaxLines(1);
		button.title = title;

		local timeLeft = button:CreateFontString(nil, "OVERLAY");
		timeLeft:SetFont(SystemFont_Shadow_Med1:GetFont(), 15, "NORMAL");
		timeLeft:SetWidth(100);
		timeLeft:SetJustifyH("LEFT");
		timeLeft:SetMaxLines(1);
		timeLeft:SetPoint("LEFT", icon, "RIGHT", 170, 0);
		button.timeLeft = timeLeft;

		local owner = button:CreateFontString(nil, "OVERLAY");
		owner:SetFont(SystemFont_Shadow_Med1:GetFont(), 14, "NORMAL");
		owner:SetWidth(100);
		owner:SetJustifyH("LEFT");
		owner:SetMaxLines(1);
		owner:SetPoint("LEFT", icon, "RIGHT", 275, 0);
		button.owner = owner;

		local bid = button:CreateFontString(nil, "OVERLAY");
		bid:SetFont(SystemFont_Shadow_Med1:GetFont(), 12, "NORMAL");
		bid:SetWidth(170);
		bid:SetJustifyH("RIGHT");
		bid:SetMaxLines(1);
		bid:SetPoint("TOPLEFT", icon, "TOPRIGHT", 380, -2);
		button.bid = bid;
	
		local buyout = button:CreateFontString(nil, "OVERLAY");
		buyout:SetFont(SystemFont_Shadow_Med1:GetFont(), 12, "NORMAL");
		buyout:SetWidth(170);
		buyout:SetJustifyH("RIGHT");
		buyout:SetMaxLines(1);
		buyout:SetPoint("BOTTOMLEFT", icon, "BOTTOMRIGHT", 380, 2);
		button.buyout = buyout;

		button:SetScript("OnClick", SearchDisplayButton_OnClick);
		button:SetScript("OnEnter", SearchDisplayButton_OnEnter);
		button:SetScript("OnLeave", SearchDisplayButton_OnLeave);

		return button;
	end
	local function functToSetButton(button, data_index)
		if CACHES and CACHES[data_index] then
			local data = CACHES[data_index];
			button.icon:SetTexture(data[6]);
			button.title:SetText(data[7]);
			button.timeLeft:SetText(L["timeLeft"][data[5]]);
			if data[4] == UnitName('player') then
				button.owner:SetText("\124cff00ff00" .. data[4] .. "\124r");
			else
				button.owner:SetText(data[4]);
			end
			button.bid:SetText(merc.MoneyString(data[2]));
			if data[1] and data[1] < BIG_NUMBER then
				button.buyout:SetText(L["buyout"] .. merc.MoneyString(data[1]));
			else
				button.buyout:SetText("");
			end
			button:Show();
			if GetMouseFocus() == button then
				SearchDisplayButton_OnEnter(button);
			end
		else
			button:Hide();
		end
	end
	local function CacheAll_update()
		local t = time() - config.prev_cache_all;
		if t > 600 and select(2, CanSendAuctionQuery()) then
			_log_("FULL_SCAN_AVAILABLE", t, select(2, CanSendAuctionQuery()));
			CacheAll:Enable();
			CacheAll:SetText(L["CacheAll"]);
			CacheAll:SetScript("OnUpdate", nil);
			merc.halt_scan_full();
		else
			t = SCAN_FULL_INTERVAL - t;
			CacheAll:SetText(format("%02d:%02d", floor(t / 60), (t % 60)));
		end
	end
	function merc.CacheAll_Disable()
		CacheAll:Disable();
		CacheAll:SetScript("OnUpdate", CacheAll_update);
	end
	local function hook_Blizzard_AuctionUI()
		ExactQueryCheckButton = CreateFrame("CheckButton", "163UI_Auction_Exact_Query_CheckButton", AuctionFrameBrowse, "UICheckButtonTemplate");
		ExactQueryCheckButton:SetSize(24, 24);
		ExactQueryCheckButton:SetHitRectInsets(0, 0, 0, 0);
		ExactQueryCheckButton:SetPoint("BOTTOM", IsUsableCheckButton, "TOP", 0, 0);
		local ExactQueryCheckButton_text = ExactQueryCheckButton:CreateFontString(nil, "OVERLAY");
		ExactQueryCheckButton_text:SetFont(GameFontNormal:GetFont(), 15);
		ExactQueryCheckButton_text:SetPoint("RIGHT", ExactQueryCheckButton, "LEFT", -2, 0);
		ExactQueryCheckButton_text:SetText(L["ExactQuery"]);
		--
		ResetButton = CreateFrame("Button", nil, AuctionFrameBrowse, "UIPanelButtonTemplate");
		ResetButton:SetPoint("BOTTOM", BrowseSearchButton, "TOP", 0, 0);
		ResetButton:SetSize(80, 22);
		ResetButton:SetText(L["Reset"]);
		ResetButton:SetScript("OnClick", function()
			AuctionFrameBrowse_Reset({ Disable = function() end, });
		end);

		CacheAll = CreateFrame("Button", nil, AuctionFrame, "UIPanelButtonTemplate");
		CacheAll:SetSize(80, 22);
		CacheAll:SetText(L["CacheAll"]);
		CacheAll:SetPoint("RIGHT", AuctionFrameCloseButton, "LEFT", -6, 0);
		CacheAll:SetScript("OnClick", function()
			if merc.scan_full() then
				config.prev_cache_all = time();
				merc.CacheAll_Disable();
			end
		end);
		if select(2, CanSendAuctionQuery()) then
			CacheAll:Enable();
			CacheAll:SetScript("OnUpdate", nil);
		else
			config.prev_cache_all = config.prev_cache_all or time();
			merc.CacheAll_Disable();
		end
		local configButton = CreateFrame("Button", nil, AuctionFrame, "UIPanelButtonTemplate");
		configButton:SetSize(80, 22);
		configButton:SetText(L["configButton"]);
		configButton:SetPoint("BOTTOM", CacheAll, "TOP", 0, 2);
		configButton:SetScript("OnClick", function()
			merc.toggle_config();
		end);
		SearchProgress = CreateFrame("StatusBar", nil, AuctionFrame);
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
		TimeDropDown = CreateFrame("Frame", nil, AuctionFrameAuctions, "UIDropDownMenuTemplate");
		UIDropDownMenu_SetWidth(TimeDropDown, 80);
		TimeDropDown:SetScript("OnShow", function(self)
			UIDropDownMenu_Initialize(self, TimeDropDown_Initialize);
		end);
		UIDropDownMenu_SetSelectedValue(TimeDropDown, AuctionFrameAuctions.duration);
		TimeDropDown:SetPoint("TOPRIGHT", AuctionFrameAuctions, "TOPLEFT", 217, -320);
		local TDDT = TimeDropDown:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall");
		TDDT:SetText(L["DURATION"]);
		TDDT:SetPoint("LEFT", TimeDropDown, "RIGHT", -192, 3);
		hooksecurefunc("AuctionFrameTab_OnClick", function(self, button, down, index)
			local index = self:GetID();
			if index == 3 then
				AuctionFrameBotLeft:SetTexture("Interface\\Addons\\alaTrade\\ARTWORK\\UI-AuctionFrame-Auction-BotLeft");
				UIDropDownMenu_SetSelectedValue(TimeDropDown, AuctionFrameAuctions.duration);
			end
		end);
		AuctionsItemButton.stackCount = 0;
		AuctionsItemButton.totalCount = 0;

		SearchDisplay = CreateFrame("Frame", nil, AuctionFrameAuctions);
		SearchDisplay:SetSize(610, 360);
		SearchDisplay:SetPoint("TOPRIGHT", AuctionFrameAuctions, "TOPRIGHT", 65, -50);
		SearchDisplay:SetBackdrop({
			bgFile = "Interface\\Buttons\\WHITE8X8",	-- "Interface\\Buttons\\WHITE8X8",	-- "Interface\\Tooltips\\UI-Tooltip-Background", -- "Interface\\ChatFrame\\ChatFrameBackground"
			edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
			tile = true,
			tileSize = 2,
			edgeSize = 2,
			insets = { left = 0, right = 0, top = 0, bottom = 0, }
		});
		SearchDisplay:SetBackdropColor(0.0, 0.0, 0.0, 1.0);
		SearchDisplay:EnableMouse(true);
		SearchDisplay:Show();
		SearchDisplay:SetFrameLevel(255);
		SearchDisplayScroll = ALASCR(SearchDisplay, SearchDisplay:GetWidth(), SearchDisplay:GetHeight(), 36, funcToCreateButton, functToSetButton);
		SearchDisplayScroll:SetPoint("BOTTOM", SearchDisplay);
		SearchDisplay:Hide();
	end
	function merc.set_start_price(copper)
		MoneyInputFrame_SetCopper(StartPrice, copper);
	end
	function merc.set_buyout_price(copper)
		MoneyInputFrame_SetCopper(BuyoutPrice, copper);
	end
	if IsAddOnLoaded("Blizzard_AuctionUI") then
		hook_Blizzard_AuctionUI();
	else
		local frame = CreateFrame("Frame");
		frame:RegisterEvent("ADDON_LOADED");
		frame:SetScript("OnEvent", function(self, event, addon)
			if addon == "Blizzard_AuctionUI" then
				hook_Blizzard_AuctionUI();
				frame:UnregisterAllEvents();
				frame:SetScript("OnEvent", nil);
				frame = nil;
			end
		end);
	end

	ALA_HOOK_ChatEdit_InsertLink(function(link, ...)
		if BrowseName and BrowseName:IsVisible() then
			if strfind(link, "item:", 1, true) then
				local name = GetItemInfo(link);
				if name and name ~= "" then
					BrowseName:SetText(name);
					QueryAuctionItems(name, BrowseMinLevel:GetNumber(), BrowseMaxLevel:GetNumber(), 0, IsUsableCheckButton:GetChecked(), BrowseDropDown.selectedValue, false, nil, nil);
					return true;
				end
			end
		end
	end);
	ALA_HOOK_ChatEdit_InsertName(function(name)
		if BrowseName and BrowseName:IsVisible() then
			if name and name ~= "" then
				BrowseName:SetText(name);
				QueryAuctionItems(name, BrowseMinLevel:GetNumber(), BrowseMaxLevel:GetNumber(), 0, IsUsableCheckButton:GetChecked(), BrowseDropDown.selectedValue, false, nil, nil);
				return true;
			end
		end
	end);
	local update_frame = CreateFrame("Frame");
	local NEW_AUCTION_UPDATE_name = nil;
	local function NEW_AUCTION_UPDATE_update_func()
		if merc.caching() then
			return;
		end
		if merc.scan_for_sell(NEW_AUCTION_UPDATE_name, NEW_AUCTION_UPDATE_CALLBACK) then
			update_frame:SetScript("OnUpdate", nil);
		end
	end
	function merc.NEW_AUCTION_UPDATE(...)
		local name, texture, count, quality, canUse, price, pricePerUnit, stackCount, totalCount, itemID = GetAuctionSellItemInfo();
		_log_("NEW_AUCTION_UPDATE", name);
		merc.halt_scan_normal();
		CACHES = nil;
		if name then
			SearchDisplay:Show();
			SearchDisplayScroll:SetNumValue(0);
			NEW_AUCTION_UPDATE_name = name;
			update_frame:SetScript("OnUpdate", NEW_AUCTION_UPDATE_update_func);
		else
			SearchDisplay:Hide();
		end
	end
	function merc.PLAYER_LOGIN()
		config.prev_cache_all = -1;
	end
	function merc.PLAYER_LOGOUT()
		-- config.prev_cache_all = -1;
	end
end

do	-- UI
	local ui = nil;
	local configFrame = nil;
	local SORT_METHOD_ID = 1;
	local SORT_METHOD_QUALITY = 2;
	local SORT_METHOD_NAME = 3;
	local SORT_METHOD_PRICE = 4;
	local SORT_METHOD_TIME = 5;
	local W = 360;
	local H = 240;
	local w = 1;
	local N = W / w;
	local COLOR_PRICE_1 = { 0.0, 1.0, 0.0, 1.0, };
	local COLOR_PRICE_2 = { 1.0, 0.0, 0.0, 1.0, };
	local COLOR_LINE = { 0.75, 0.75, 0.25, 1.0, };
	local _ = nil;
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
					tip:SetText(merc.MoneyString(info[2]) .. "\n" .. L["ITEM_COUNT"] .. info[3] .. "\n" .. merc.seconds_to_colored_formatted_time(info[1]));
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
		local curTime = time();
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
				maxHVal = maxHVal or time();
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
		if minHVal == maxHVal then
			maxHVal = max(minHVal * 2, 1);
			minHVal = 0;
		else
			minHVal = max(0, floor(minHVal - (maxHVal - minHVal) / 4));
			maxHVal = floor(maxHVal + (maxHVal - minHVal) / 4);
		end
		local info = meta.id and cache[meta.id];
		if info then
			graph.title:SetText("\124c" .. (select(4, GetItemQualityColor(info[4])) or "ffffffff") .. (info[1] or ("ITEM" .. meta.id)) .. "\124r");
		end
		graph.minH:SetText(merc.seconds_to_colored_formatted_time(minHVal));
		graph.maxH:SetText(merc.seconds_to_colored_formatted_time(maxHVal));
		graph.minV:SetText(merc.MoneyString(minVVal));
		graph.maxV:SetText(merc.MoneyString(maxVVal));
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
			graph.curPrice:SetText(merc.MoneyString_Dec(curPrice));
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
			merc.toggle_config();
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
	local function button_OnClick(self)
		local list = self.list;
		local data_index = self:GetDataIndex();
		if data_index <= #list then
			local id = list[data_index];
			local info = cache[id];
			if info then
				if IsShiftKeyDown() then
					info[8] = info[8] or select(2, GetItemInfo(id));
					ChatEdit_InsertLink(info[8] or info[1], ADDON);
				elseif IsAltKeyDown() then
					local p, _, e = merc.query_ah_price_by_id(id);
					info[8] = info[8] or select(2, GetItemInfo(id));
					local editBox = ChatEdit_ChooseBoxForSend();
					editBox:Show();
					editBox:SetFocus();
					if info[2] then
						editBox:Insert((info[8] or info[1]) .. " "  .. L["PRICE"] .. merc.MoneyString_Dec_Char(info[2]) .. " " .. L["CACHE_TIME"] .. merc.seconds_to_formatted_time_len(time() - info[7]));
					else
						if p then
							editBox:Insert((info[8] or info[1]) .. " "  .. L["HISTORY_PRICE"] .. merc.MoneyString_Dec_Char(e) .. " "  .. L["CACHE_TIME"] .. e);
						else
							editBox:Insert((info[8] or info[1]) .. " "  .. L["PRCIE_NOT_CACHED"]);
						end
					end
				elseif config.cache_history then
					local meta = ui.graph.list;
					local n = 0;
					local H = info[0];
					if H then
						for i = 1, #H do
							n = n + 1;
							insert_meta(meta, n, H[i][3], H[i][1], H[i][2]);
						end
					end
					if info[2] then
						n = n + 1;
						insert_meta(meta, n, info[7], info[2], info[3]);
					end
					meta[0] = n;
					meta.id = id;
					ui.graph_container:Show();
					graph_SetValue(ui.graph, meta);
				end
			end
		end
	end
	local function funcToCreateButton(parent, index, buttonHeight)
		local button = CreateFrame("Button", nil, parent);
		button:SetHeight(buttonHeight);
		button:SetBackdrop(setting.buttonBackdrop);
		button:SetBackdropColor(unpack(setting.buttonBackdropColor));
		button:SetBackdropBorderColor(unpack(setting.buttonBackdropBorderColor));
		button:SetHighlightTexture("Interface\\FriendsFrame\\UI-FriendsFrame-HighlightBar");
		button:EnableMouse(true);
		button:Show();

		local itemID = button:CreateFontString(nil, "OVERLAY");
		itemID:SetFont(setting.frameFont, setting.frameFontSize, setting.frameFontOutline);
		itemID:SetPoint("LEFT", 4, 0);
		itemID:SetWidth(45);
		itemID:SetMaxLines(1);
		itemID:SetJustifyH("LEFT");
		button.itemID = itemID;

		local icon = button:CreateTexture(nil, "BORDER");
		icon:SetTexture("Interface\\Icons\\inv_misc_questionmark");
		icon:SetSize(buttonHeight - 4, buttonHeight - 4);
		icon:SetPoint("LEFT", itemID, "RIGHT", 4, 0);
		button.icon = icon;

		local name = button:CreateFontString(nil, "OVERLAY");
		name:SetFont(setting.frameFont, setting.frameFontSize, setting.frameFontOutline);
		name:SetPoint("LEFT", icon, "RIGHT", 4, 0);
		name:SetWidth(150);
		name:SetMaxLines(1);
		name:SetJustifyH("LEFT");
		button.name = name;

		local buyoutPriceSingle = button:CreateFontString(nil, "ARTWORK");
		buyoutPriceSingle:SetFont(setting.frameFont, setting.frameFontSize, setting.frameFontOutline);
		buyoutPriceSingle:SetPoint("LEFT", name, "RIGHT", 4, 0);
		buyoutPriceSingle:SetWidth(150);
		buyoutPriceSingle:SetMaxLines(1);
		buyoutPriceSingle:SetJustifyH("RIGHT");
		button.buyoutPriceSingle = buyoutPriceSingle;

		local cache_time = button:CreateFontString(nil, "OVERLAY");
		cache_time:SetFont(setting.frameFont, setting.frameFontSize, setting.frameFontOutline);
		cache_time:SetPoint("LEFT", buyoutPriceSingle, "RIGHT", 4, 0);
		cache_time:SetWidth(140);
		cache_time:SetMaxLines(1);
		cache_time:SetJustifyH("RIGHT");
		button.cache_time = cache_time;

		local quality_glow = button:CreateTexture(nil, "ARTWORK");
		quality_glow:SetTexture("Interface\\Buttons\\UI-ActionButton-Border");
		quality_glow:SetBlendMode("ADD");
		quality_glow:SetTexCoord(0.25, 0.75, 0.25, 0.75);
		quality_glow:SetSize(buttonHeight - 2, buttonHeight - 2);
		quality_glow:SetPoint("CENTER", icon);
		-- quality_glow:SetAlpha(0.75);
		quality_glow:Show();
		button.quality_glow = quality_glow;

		local glow = button:CreateTexture(nil, "OVERLAY");
		glow:SetTexture("Interface\\Buttons\\WHITE8X8");
		-- glow:SetTexCoord(0.25, 0.75, 0.25, 0.75);
		glow:SetVertexColor(0.25, 0.25, 0.25, 0.75);
		glow:SetAllPoints(true);
		glow:SetBlendMode("ADD");
		glow:Hide();
		button.glow = glow;

		button:SetScript("OnEnter", button_OnEnter);
		button:SetScript("OnLeave", button_OnLeave);
		button:RegisterForClicks("AnyUp");
		button:SetScript("OnClick", button_OnClick);
		button:RegisterForDrag("LeftButton");
		button:SetScript("OnHide", function()
			ALADROP(button);
		end);

		function button:Select()
			glow:Show();
		end
		function button:Deselect()
			glow:Hide();
		end

		local frame = parent:GetParent():GetParent();
		button.frame = frame;
		button.list = frame.list;
		button.searchEdit = frame.searchEdit;

		return button;
	end
	local function funcToSetButton(button, data_index)
		local list = button.list;
		ALADROP(button);
		if data_index <= #list then
			local id = list[data_index];
			local info = cache[id];
			if info then
				button.itemID:SetText(id);
				button.icon:SetTexture(info[6]);
				button.name:SetText((info[1] == nil or info[1] == "") and ("ITEM" .. id .. data_index) or info[1]);
				if info[2] then
					button.buyoutPriceSingle:SetText(merc.MoneyString_Dec(info[2]));
					button.cache_time:SetText(merc.seconds_to_colored_formatted_time_len(time() - info[7]));
				else
					local H = info[0];
					local found_valid = false;
					if H then
						for i = #H, 1, -1 do
							if H[i][1] then
								found_valid = true;
								button.buyoutPriceSingle:SetText(merc.MoneyString_Dec(H[i][1]));
								button.cache_time:SetText(merc.seconds_to_colored_formatted_time_len(time() - H[i][3]));
								break;
							end
						end
					end
					if not found_valid then
						button.buyoutPriceSingle:SetText(L["UNKOWN"]);
						button.cache_time:SetText(L["TIME_NA"]);
					end
				end
				if info[4] then
					local r, g, b, code = GetItemQualityColor(info[4]);
					button.name:SetTextColor(r, g, b, 1);
					button.quality_glow:SetVertexColor(r, g, b);
					button.quality_glow:Show();
				else
					button.name:SetTextColor(1, 1, 1, 1);
					button.quality_glow:Hide();
				end
				button:Show();
				if GetMouseFocus() == button then
					button_OnEnter(button);
				end
			else
				button:Hide();
			end
		else
			button:Hide();
		end
	end
	local function func_update_ui()
		if not ui:IsShown() then
			return;
		end
		local list = ui.list;
		wipe(list);
		local str = ui.searchEdit:GetText();
		if str and str ~= "" then
			for id, v in next, cache do
				if (merc.query_ah_price_by_id_simple(id) ~= nil or config.showEmpty) and (strfind(v[1], str) or strfind(id, str)) then
					tinsert(list, id);
				end
			end
		else
			for id, v in next, cache do
				if merc.query_ah_price_by_id_simple(id) ~= nil or config.showEmpty then
					tinsert(list, id);
				end
			end
		end
		if config.sort_method then
			if config.sort_method == SORT_METHOD_ID then
				if config.sort_method_seq > 0 then
					sort(list, function(v1, v2) return v1 < v2; end);
				else
					sort(list, function(v1, v2) return v1 > v2; end);
				end
			elseif config.sort_method == SORT_METHOD_QUALITY then
				if config.sort_method_seq > 0 then
					sort(list, function(v1, v2) return cache[v1][4] < cache[v2][4]; end);
				else
					sort(list, function(v1, v2) return cache[v1][4] > cache[v2][4]; end);
				end
			elseif config.sort_method == SORT_METHOD_NAME then
				if config.sort_method_seq > 0 then
					sort(list, function(v1, v2) return cache[v1][1] < cache[v2][1]; end);
				else
					sort(list, function(v1, v2) return cache[v1][1] > cache[v2][1]; end);
				end
			elseif config.sort_method == SORT_METHOD_PRICE then
				if config.sort_method_seq > 0 then
					sort(list, function(v1, v2) return (merc.query_ah_price_by_id_simple(v1) or BIG_NUMBER) < (merc.query_ah_price_by_id_simple(v2) or BIG_NUMBER); end);
				else
					sort(list, function(v1, v2) return (merc.query_ah_price_by_id_simple(v1) or BIG_NUMBER) > (merc.query_ah_price_by_id_simple(v2) or BIG_NUMBER); end);
				end
			elseif config.sort_method == SORT_METHOD_TIME then
				if config.sort_method_seq > 0 then
					sort(list, function(v1, v2) return (merc.query_last_cache_time_by_id(v1) or -1) < (merc.query_last_cache_time_by_id(v2) or -1); end);
				else
					sort(list, function(v1, v2) return (merc.query_last_cache_time_by_id(v1) or -1) > (merc.query_last_cache_time_by_id(v2) or -1); end);
				end
			end
		end
		ui.scroll:SetNumValue(#list);
		ui.scroll:Update();
	end
	function merc.cache_item_info(id)
		local v = cache[id];
		if v then
			local name, link, quality, _, _, _, _, _, _, texture, vendorPrice = GetItemInfo(id);
			if name then
				v[1] = name;
				v[4] = quality;
				v[5] = vendorPrice;
				v[6] = texture;
				v[8] = link;
				cache2[name] = id;
				return true;
			end
		end
		return false;
	end
	local function GET_ITEM_INFO_RECEIVED(self, event, arg1, arg2)
		if arg2 then
			if merc.cache_item_info(arg1) then
				if ui:IsShown() then
					_EventHandler:run_on_next_tick(function() ui.scroll:Update(); end);
				end
			end
		end
	end
	local function sortButton_OnClick(self)
		local method = self.method;
		if method == config.sort_method then
			config.sort_method_seq = - config.sort_method_seq;
		else
			config.sort_method = method;
		end
		for _, button in next, self.sortButtons do
			if button == self then
				button.texture:SetColorTexture(0.75, 0.75, 0.25, 0.5);
				button.seq:Show();
				if config.sort_method_seq > 0 then
					button.seq:SetTexture("interface\\buttons\\arrow-down-up");
				else
					button.seq:SetTexture("interface\\buttons\\arrow-up-up");
				end
			else
				button.texture:SetColorTexture(0.25, 0.25, 0.25, 0.5);
				button.seq:Hide();
			end
		end
		func_update_ui();
	end
	local function sortButton_OnShow(self)
		if config and config.sort_method == method then
			self.texture:SetColorTexture(0.75, 0.75, 0.25, 0.5);
			self.seq:Show();
			if config.sort_method_seq > 0 then
				self.seq:SetTexture("interface\\buttons\\arrow-down-up");
			else
				self.seq:SetTexture("interface\\buttons\\arrow-up-up");
			end
		else
			self.texture:SetColorTexture(0.25, 0.25, 0.25, 0.5);
			self.seq:Hide();
		end
	end
	local function create_sortButtons(sortButtons, method, width)
		if not method then
			return;
		end
		local button = CreateFrame("Button", nil, ui);
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
		buttonText:SetFont(setting.frameFont, setting.frameFontSize);
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
	function merc.initUI()
		do	-- UI
			ui = CreateFrame("Frame", "ALA_TRADE_UI", UIParent);
			tinsert(UISpecialFrames, "ALA_TRADE_UI");
			ui.list = {  };
			ui:SetSize(550, 480);
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
			ui:SetScript("OnShow", func_update_ui);
			ui:Hide();

			local title = ui:CreateFontString(nil, "OVERLAY");
			title:SetFont(setting.frameFont, setting.frameFontSize);
			title:SetTextColor(1.0, 1.0, 1.0, 1.0);
			title:SetPoint("TOP", 0, - 2);
			title:SetText(L["UI_TITLE"]);
			ui.title = title;

			local close = CreateFrame("Button", nil, ui);
			close:SetSize(16, 16);
			close:SetNormalTexture("interface\\buttons\\ui-stopbutton");
			close:GetNormalTexture():SetTexCoord(0.025, 0.975, 0.05, 1.0);
			close:SetPushedTexture("interface\\buttons\\ui-stopbutton");
			close:GetPushedTexture():SetTexCoord(0.025, 0.975, 0.0, 0.95);
			close:SetPoint("TOPRIGHT", - 5, - 3);
			close:SetScript("OnClick", function()
				ui:Hide();
			end);
			ui.close = close;

			local scroll = ALASCR(ui, nil, nil, setting.button_height, funcToCreateButton, funcToSetButton);
			scroll:SetPoint("BOTTOMLEFT", 4, 24);
			scroll:SetPoint("TOPRIGHT", - 4, - 62);
			ui.scroll = scroll;

			local showEmpty = CreateFrame("CheckButton", nil, ui, "OptionsBaseCheckButtonTemplate");
			showEmpty:SetHitRectInsets(0, 0, 0, 0);
			showEmpty:SetScript("OnClick", function(self)
				config["showEmpty"] = self:GetChecked();
				func_update_ui();
			end);
			local label = ui:CreateFontString(nil, "ARTWORK", "GameFontHighlight");
			label:SetText(L["showEmpty"]);
			label:SetPoint("RIGHT", showEmpty, "LEFT", - 4, 0);
			showEmpty:SetPoint("BOTTOMRIGHT", ui, "BOTTOMRIGHT", - 4, - 2);
			ui.showEmpty = showEmpty;
			showEmpty:SetChecked(config.showEmpty);

			merc.add_cache_callback(func_update_ui);
			C_Timer.NewTicker(1.0, ticker_update_ui);
			ui:RegisterEvent("GET_ITEM_INFO_RECEIVED");
			ui:SetScript("OnEvent", GET_ITEM_INFO_RECEIVED);
			-- ui:SetScript("OnShow", function()
			-- 	ui.graph:Hide();
			-- end);
		end
		do	-- graph
			local graph_container = CreateFrame("Frame", nil, UIParent);
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
			title:SetFont(setting.frameFont, setting.frameFontSize);
			title:SetPoint("TOP", graph_container, "TOP", 0, - 6);
			graph_container.title = title;

			local graph = CreateFrame("Frame", nil, graph_container);
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

			local close = CreateFrame("Button", nil, graph_container);
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
			tip:SetFont(setting.frameFont, setting.frameFontSize);
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
			minH:SetFont(setting.frameFont, setting.frameFontSize);
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
			maxH:SetFont(setting.frameFont, setting.frameFontSize);
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
			minV:SetFont(setting.frameFont, setting.frameFontSize);
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
			maxV:SetFont(setting.frameFont, setting.frameFontSize);
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
			curPrice:SetFont(setting.frameFont, setting.frameFontSize);
			curPrice:SetTextColor(1.0, 1.0, 1.0, 1.0);
			curPrice:SetPoint("TOPRIGHT", curIndicator, "BOTTOMRIGHT", - W - 1, 0);
			graph.curPrice = curPrice;

		end

		do	-- search_box
			local searchEditOK = CreateFrame("Button", nil, ui);
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
			searchEditOKText:SetFont(setting.frameFont, setting.frameFontSize);
			searchEditOKText:SetTextColor(1.0, 1.0, 1.0, 0.5);
			searchEditOKText:SetPoint("CENTER");
			searchEditOKText:SetText(L["OK"]);
			searchEditOK:SetFontString(searchEditOKText);
			searchEditOK:SetPushedTextOffset(1, - 1);

			local searchEdit = CreateFrame("EditBox", nil, ui);
			searchEdit:SetHeight(18);
			searchEdit:SetFont(setting.frameFont, setting.frameFontSize, setting.frameFontOutline);
			searchEdit:SetAutoFocus(false);
			searchEdit:SetJustifyH("LEFT");
			searchEdit:Show();
			searchEdit:EnableMouse(true);
			searchEdit:SetPoint("TOPLEFT", ui, "TOPLEFT", 4, - 22);
			searchEdit:SetPoint("RIGHT", searchEditOK, "LEFT", - 4, 0);
			local searchEditTexture = searchEdit:CreateTexture(nil, "ARTWORK");
			searchEditTexture:SetPoint("TOPLEFT");
			searchEditTexture:SetPoint("BOTTOMRIGHT");
			searchEditTexture:SetTexture("Interface\\Buttons\\greyscaleramp64");
			searchEditTexture:SetTexCoord(0.0, 0.25, 0.0, 0.25);
			searchEditTexture:SetAlpha(0.75);
			searchEditTexture:SetBlendMode("ADD");
			searchEditTexture:SetVertexColor(0.25, 0.25, 0.25);
			local searchEditNote = searchEdit:CreateFontString(nil, "OVERLAY");
			searchEditNote:SetFont(setting.frameFont, setting.frameFontSize);
			searchEditNote:SetTextColor(1.0, 1.0, 1.0, 0.5);
			searchEditNote:SetPoint("LEFT", 4, 0);
			searchEditNote:SetText(L["Search"]);
			searchEditNote:Show();
			local searchCancel = CreateFrame("Button", nil, searchEdit);
			searchCancel:SetSize(18, 18);
			searchCancel:SetPoint("RIGHT", searchEdit);
			searchCancel:Hide();
			searchCancel:SetNormalTexture("interface\\petbattles\\deadpeticon")

			searchCancel:SetScript("OnClick", function(self) searchEdit:SetText(""); searchEdit:ClearFocus(); end);
			searchEditOK:SetScript("OnClick", function(self) searchEdit:ClearFocus(); end);
			searchEditOK:SetScript("OnEnable", function(self) searchEditOKText:SetTextColor(1.0, 1.0, 1.0, 1.0); end);
			searchEditOK:SetScript("OnDisable", function(self) searchEditOKText:SetTextColor(1.0, 1.0, 1.0, 0.5); end);

			searchEdit:SetScript("OnEnterPressed", function(self) self:ClearFocus(); end);
			searchEdit:SetScript("OnEscapePressed", function(self) self:ClearFocus(); end);
			searchEdit:SetScript("OnTextChanged", function(self, isUserInput)
				_EventHandler:run_on_next_tick(func_update_ui);
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
			create_sortButtons(sortButtons, SORT_METHOD_ID, 47):SetPoint("BOTTOMLEFT", ui.scroll, "TOPLEFT", 4, 2);
			create_sortButtons(sortButtons, SORT_METHOD_QUALITY, 60):SetPoint("LEFT", sortButtons[SORT_METHOD_ID], "RIGHT", 2, 0);
			create_sortButtons(sortButtons, SORT_METHOD_NAME, 106):SetPoint("LEFT", sortButtons[SORT_METHOD_QUALITY], "RIGHT", 2, 0);
			create_sortButtons(sortButtons, SORT_METHOD_PRICE, 152):SetPoint("LEFT", sortButtons[SORT_METHOD_NAME], "RIGHT", 2, 0);
			create_sortButtons(sortButtons, SORT_METHOD_TIME, 140):SetPoint("LEFT", sortButtons[SORT_METHOD_PRICE], "RIGHT", 2, 0);
		end

		local configButton = CreateFrame("Button", nil, ui);
		configButton:SetSize(18, 18);
		configButton:SetNormalTexture("interface\\buttons\\ui-optionsbutton");
		configButton:SetPoint("TOPRIGHT", ui, "TOPRIGHT", - 4, - 22);
		configButton:SetScript("OnClick", merc.toggle_config);

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
							minimapPos = config.minimapPos,
						}
					);
				end
				if config.show_DBIcon then
					icon:Show("ALATRADE");
				else
					icon:Hide("ALATRADE");
				end
				local mb = icon:GetMinimapButton("ALATRADE");
				mb:RegisterEvent("PLAYER_LOGOUT");
				mb:SetScript("OnEvent", function(self)
					config.minimapPos = self.minimapPos or self.db.minimapPos;
				end);
			end
		end
	end
	do	-- config_frame
		local config_callback = {  };
		merc.config_callback = config_callback;
		configFrame = CreateFrame("Frame", nil, UIParent);
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
		local close = CreateFrame("Button", nil, configFrame, "UIPanelButtonTemplate");
		close:SetText(L["close"]);
		close:SetSize(48, 22);
		close:SetPoint("TOPRIGHT");
		close:SetScript("OnClick", function()
			configFrame:Hide();
		end);
		local ct = {
			-- { "avoid_stuck", },
			{ "show_vendor_price", },
			{ "show_vendor_price_multi", },
			{ "show_ah_price", },
			{ "show_ah_price_multi", },
			{ "show_disenchant_price", },
			{ "show_disenchant_detail", },
			{ "cache_history", },
			{ "show_DBIcon", function(on)
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
		};
		local cbs = {  };
		local pos_x = 0;
		local pos_y = 0;
		for i, val in next, ct do
			local key = val[1];
			local func = val[2];
			local cb = CreateFrame("CheckButton", nil, configFrame, "OptionsBaseCheckButtonTemplate");
			cb:SetHitRectInsets(0, 0, 0, 0);
			cb:SetScript("OnClick", function(self)
				config[key] = self:GetChecked();
				if func then
					func(config[key]);
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
			{ "avoid_stuck_cost", 1, 50, 1, },
			{ "data_valid_time", 900, 86400, 300, L["TIME900"], L["TIME86400"], function(self, value, userInput)
				if userInput then
					config.data_valid_time = value;
					ui.scroll:Update();
				end
				self.Text:SetText(L["data_valid_time"] .. merc.seconds_to_colored_formatted_time_len(value));
			end },
			{ "auto_clean_time", 0, 2592000, 43200, L["close"], L["TIME2592000"], function(self, value, userInput)
				if userInput then
					config.auto_clean_time = value;
				end
				if value == 0 then
					self.Text:SetText(L["auto_clean_time"] .. "\124cffff0000" .. L["close"] .. "\124r");
				else
					self.Text:SetText(L["auto_clean_time"] .. merc.seconds_to_colored_formatted_time_len(value));
				end
			end},
		};
		local sls = {  };
		for i, val in next, st do
			local label = configFrame:CreateFontString(nil, "ARTWORK", "GameFontHighlight");
			label:SetText(L[val[1]]);
			label:SetPoint("TOPLEFT", configFrame, "TOPLEFT", 4, -12 - pos_y * 36);
			local sl = CreateFrame("Slider", nil, configFrame, "OptionsSliderTemplate");
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
					config[val[1]] = value;
				end
			end);
			if val[7] then
				config_callback[val[1]] = val[7];
			end
			sls[i] = sl;
			pos_y = pos_y + 1.5;
		end

		configFrame:SetScript("OnShow", function()
			for i, val in next, ct do
				cbs[i]:SetChecked(config[val[1]]);
			end
			for i, val in next, st do
				sls[i]:SetValue(config[val[1]]);
			end
			-- data_valid_time_Slider:SetValue(config.data_valid_time);
			-- auto_clean_time_Slider:SetValue(config.auto_clean_time);
		end);

	end
	function merc.toggle_ui()
		if ui:IsShown() then
			ui:Hide();
		else
			ui:Show();
		end
	end
	function merc.toggle_config()
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

do	-- COMMUNICATION	-- TODO
	local prev_push = { time(), };
	local function broadcast_price(cache_time, id, name, link, quality, price, count, vendorPrice, texture)
		local msg = "$" .. cache_time .. "#" .. id .. "#" .. name .. "#" .. link .. "#" .. quality .. "#" .. format("%.3f", price) .. "#" .. count .. "#" .. vendorPrice .. "#" .. texture .. "^";
		SendAddonMessage(ADDON_PREFIX, msg, "GUILD");
	end
	local function reply_price(target, cache_time, id, name, link, quality, price, count, vendorPrice, texture)
		local msg = "$" .. cache_time .. "#" .. id .. "#" .. name .. "#" .. link .. "#" .. quality .. "#" .. format("%.3f", price) .. "#" .. count .. "#" .. vendorPrice .. "#" .. texture .. "^";
		SendAddonMessage(ADDON_PREFIX, msg, "WHISPER", target);
	end
	function merc.init_ADDON_MESSAGE()
		do return end
		if not RegisterAddonMessagePrefix(ADDON_PREFIX) then
			_log_("Init", "RegisterAddonMessagePrefix", ADDON_PREFIX);
		end
	end
	local function CHAT_MSG_ADDON(self, event, prefix, text, channel, sender, target, zoneChannelID, localID, name, instanceID)
		if prefix == ADDON_PREFIX then
			local control_code = strsub(text, 1, ADDON_MSG_CONTROL_CODE_LEN);
		end
	end
	local frame = CreateFrame("Frame");
	frame:RegisterEvent("CHAT_MSG_ADDON");
	frame:RegisterEvent("CHAT_MSG_ADDON_LOGGED");
	frame:SetScript("OnEvent", CHAT_MSG_ADDON);
	--
	local function ticker_push()
	end
	function merc.push_to_guild()
		tinsert(prev_push, time());
	end
end

local function OnEvent(self, event, ...)
	return merc[event](...);
end
local function RegEvent(frame, event)
	merc[event] = merc[event] or _noop_;
	frame:RegisterEvent(event);
	frame:SetScript("OnEvent", OnEvent);
end
local function PLAYER_ENTERING_WORLD()
	_EventHandler:UnregisterEvent("PLAYER_ENTERING_WORLD");
	_EventHandler:SetScript("OnEvent", nil);
	do	-- initialze saved_var
		if alaTradeSV then
			if alaTradeSV._version < 200107.1 then
				wipe(alaTradeSV.cache);
				wipe(alaTradeSV.cache2);
			end
			if alaTradeSV._version < 200109.0 then
				alaTradeSV.cache3 = {  };
				for iid, _ in next, alaTradeSV.cache do
					tinsert(alaTradeSV.cache3, iid);
				end
			end
		else
			_G.alaTradeSV = { cache = {  }, cache2 = {  }, cache3 = {  }, config = {  }, };
		end
		cache = alaTradeSV.cache;
		cache2 = alaTradeSV.cache2;
		cache3 = alaTradeSV.cache3;
		config = alaTradeSV.config;
		for k, v in next, default do
			if config[k] == nil then
				config[k] = v;
			end
		end
		for k, _ in next, config do
			if default[k] == nil then
				config[k] = nil;
			end
		end
		alaTradeSV._version = 200109.0;
	end
	do	-- 
		for id, v in next, cache do
			local H = v[0];
			-- { price, count, time, }
			if H then
				local pos = 1;
				while H[pos] do
					local c = H[pos];
					local d = floor((c[3] + 28800) / 86400);
					local pos2 = pos + 1;
					while H[pos2] do
						local c2 = H[pos2];
						local d2 = floor((c2[3] + 28800) / 86400);
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
		if config.auto_clean_time > 0 then
			local expired = time() - config.auto_clean_time;
			for id, v in next, cache do
				local H = v[0];
				if H then
					if v[2] then
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
		for id, v in next, cache do
			if v[1] ~= nil and type(v[1]) ~= 'string' then
				v[1] = nil;
			end
			if v[8] ~= nil and type(v[8]) ~= 'string' then
				v[8] = nil;
			end
			local H = v[0];
			if H then
				for i = #H, 1, -1 do
					if not H[i][3] then
						tremove(H, i);
					end
				end
			end
		end
	end
	RegEvent(_EventHandler, "AUCTION_ITEM_LIST_UPDATE");
	RegEvent(_EventHandler, "AUCTION_HOUSE_SHOW");
	RegEvent(_EventHandler, "AUCTION_HOUSE_CLOSED");
	RegEvent(_EventHandler, "NEW_AUCTION_UPDATE");
	RegEvent(_EventHandler, "PLAYER_LOGIN");
	RegEvent(_EventHandler, "PLAYER_LOGOUT");
	merc.hook_tooltip();
	merc.initUI();
	merc.init_ADDON_MESSAGE();
	for id, v in next, cache do
		if v[1] == nil or v[1] == "" or v[4] == nil or v[5] == nil or v[6] == nil or v[6] == "" or v[6] == 0 then
			merc.cache_item_info(id);
		end
	end
end

_EventHandler:RegisterEvent("PLAYER_ENTERING_WORLD");
_EventHandler:SetScript("OnEvent", PLAYER_ENTERING_WORLD);
local run_on_next_tick_func = {  };
local function run_on_next_tick_handler()
	_EventHandler:SetScript("OnUpdate", nil);
	for i = #run_on_next_tick_func, 1, -1 do
		tremove(run_on_next_tick_func, i)();
	end
end
function _EventHandler:run_on_next_tick(func)
	for i = 1, #run_on_next_tick_func do
		if func == run_on_next_tick_func[i] then
			return;
		end
	end
	_EventHandler:SetScript("OnUpdate", run_on_next_tick_handler);
	tinsert(run_on_next_tick_func, func);
end
function _EventHandler:frame_update_on_next_tick(frame)
	if not frame.mute_update then
		_EventHandler:run_on_next_tick(frame.update_func);
	end
end

function merc.add_cache_callback(func)
	if type(func) == 'function' then
		for i = #_callback_after_cache, 1, -1 do
			if _callback_after_cache[i] == func then
				return;
			end
		end
		tinsert(_callback_after_cache, func);
	end
end
function merc.remove_cache_callback(func)
	if type(func) == 'function' then
		for i = #_callback_after_cache, 1, -1 do
			if _callback_after_cache[i] == func then
				tremove(_callback_after_cache, i);
			end
		end
	end
end

_G.alaTrade = {
	set_config = function(key, val)
		if config[key] ~= nil then
			config[key] = val;
			if merc.config_callback[key] then
				merc.config_callback[key](val);
			end
		end
	end,
	toggle_config = merc.toggle_config,
	toggle_ui = merc.toggle_ui,
};

_G.ALA_AUC_ADD_CALLBACK = merc.add_cache_callback;
_G.ALA_AUC_REMOVE_CALLBACK = merc.remove_cache_callback;
_G.ALA_GET_PRICE = merc.query_ah_price_by_id;
_G.ALA_GET_PRICE_BY_NAME = merc.query_ah_price_by_name;

_G._163_ALA_TRADE_SET_CONFIG = alaTrade.set_config;



