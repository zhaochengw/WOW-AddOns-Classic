--[=[
	INIT
--]=]
----------------------------------------------------------------------------------------------------
local __addon, __private = ...;
local MT = {  }; __private.MT = MT;		--	method
local CT = {  }; __private.CT = CT;		--	constant
local VT = {  }; __private.VT = VT;		--	variables
local DT = {  }; __private.DT = DT;		--	data

-->		upvalue
	local setfenv = setfenv;
	local loadstring, pcall, xpcall = loadstring, pcall, xpcall;
	local geterrorhandler = geterrorhandler;
	local hooksecurefunc = hooksecurefunc;
	local print, date = print, date;
	local type = type;
	local tostring = tostring;
	local select = select;
	local setmetatable = setmetatable;
	local rawset = rawset;
	local next = next;
	local unpack = unpack;
	local tconcat = table.concat;
	local strupper, strsub, strrep, format = string.upper, string.sub, string.rep, string.format;
	local IsLoggedIn = IsLoggedIn;
	local SendChatMessage = SendChatMessage;
	local GetSpellInfo = GetSpellInfo;
	local GetSpellCooldown = GetSpellCooldown;
	local IsAddOnLoaded = IsAddOnLoaded;
	local CreateFrame = CreateFrame;
	local GetTime = GetTime;
	local _G = _G;
	local ChatEdit_InsertLink = ChatEdit_InsertLink;

-->
	local __ala_meta__ = _G.__ala_meta__;
	__ala_meta__.prof = __private;
	VT.__super = __ala_meta__;
	VT.__uireimp = __ala_meta__.uireimp;
	VT.__menulib = __ala_meta__.__menulib;
	VT.__scrolllib = _G.alaScrollList;

-->		Dev
	local _GlobalRef = {  };
	local _GlobalAssign = {  };
	function MT.BuildEnv(category)
		local _G = _G;
		local Ref = _GlobalRef[category] or {  };
		local Assign = _GlobalAssign[category] or {  };
		setfenv(2, setmetatable(
			{  },
			{
				__index = function(tbl, key, val)
					Ref[key] = (Ref[key] or 0) + 1;
					_GlobalRef[category] = Ref;
					return _G[key];
				end,
				__newindex = function(tbl, key, value)
					rawset(tbl, key, value);
					Assign[key] = (Assign[key] or 0) + 1;
					_GlobalAssign[category] = Assign;
					return value;
				end,
			}
		));
	end
	function MT.MergeGlobal(DB)
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

-->		constant
	CT.CLIENTVERSION, CT.BUILDNUMBER, CT.BUILDDATE, CT.TOCVERSION = GetBuildInfo();
	CT.ISCLASSIC = CT.TOCVERSION >= 11400 and CT.TOCVERSION < 20000;
	CT.ISBCC = CT.TOCVERSION >= 20500 and CT.TOCVERSION < 30000;
	CT.ISWLK = CT.TOCVERSION >= 30400 and CT.TOCVERSION < 40000;
	CT.ISCATA = CT.TOCVERSION >= 40400 and CT.TOCVERSION < 90000;
	CT.VGT2X = CT.ISBCC or CT.ISWLK or CT.ISCATA;
	CT.VGT3X = CT.ISWLK or CT.ISCATA;
	CT.ISRETAIL = CT.TOCVERSION >= 90000;
	CT.LOCALE = GetLocale();
	CT.BNTAG = select(2, BNGetInfo());
	CT.SELFREALM = GetRealmName();
	CT.SELFREALMID = tonumber(GetRealmID());
	CT.SELFGUID = UnitGUID('player');
	CT.SELFLCLASS, CT.SELFCLASS = UnitClass('player');
	CT.SELFNAME = UnitName('player');
	CT.SELFFACTION = UnitFactionGroup('player');
	CT.SELFISHORDE = CT.SELFFACTION == "Horde";
	CT.SELFISALLIANCE = CT.SELFFACTION == "Alliance";
	CT.SELFRACE, CT.SELFRACEFILE, CT.SELFRACEID = UnitRace('player');
	CT.FONT = GameFontNormal:GetFont();
	CT.BIGNUMBER = 4294967295;
	local UTC, LT = date("!*t"), date("*t");
	CT.LOCALTIMEDIFF = 86400 - ((LT.hour - UTC.hour) * 3600 + (LT.min - UTC.min) * 60 + LT.sec - UTC.sec);
	CT.REPEATEDSTRING = setmetatable(
		{
			--	Prevent to destroy /tinspect
			GetParent = false,
			SetShown = false,
			GetDebugName = false,
			IsObjectType = false,
			GetChildren = false,
			GetRegions = false,
		},
		{
			__index = function(tbl, char)
				if type(char) == 'string' then
					local v = setmetatable(
						{
							[0] = "",
							[1] = char,
						},
						{
							__index = function(tbl, key)
								if type(key) == 'number' and key >= 0 then
									local str = strrep(char, key);
									tbl[key] = str;
									return str;
								end
							end,
						}
					);
					tbl[char] = v;
					return v;
				end
			end,
		}
	);
	CT.MEDIAPATH =  [[Interface\AddOns\]] .. __addon .. [[\Media\]];
	CT.TEXTUREPATH =  CT.MEDIAPATH .. [[Textures\]];
	CT.l10n = {  };
	CT.T_RankColor = {
		[0] = { 1.0, 0.0, 0.0, 1.0, },
		[1] = { 1.0, 0.5, 0.35, 1.0, },
		[2] = { 1.0, 1.0, 0.25, 1.0, },
		[3] = { 0.25, 1.0, 0.25, 1.0, },
		[4] = { 0.5, 0.5, 0.5, 1.0, },
		[CT.BIGNUMBER] = { 0.0, 0.0, 0.0, 1.0, },
	};
	CT.T_RankIndex = {
		['difficult'] = 0,
		['optimal'] = 1,
		['medium'] = 2,
		['easy'] = 3,
		['trivial'] = 4,
	};

-->		control
	VT.__is_dev = CT.BNTAG == 'alex#516722';

-->
MT.BuildEnv('Init');
-->		predef
	MT.GetUnifiedTime = _G.GetTimePreciseSec;

	MT.Print = print;
	function MT.Error(...)
		return MT.Print(date('|cff00ff00%H:%M:%S|r'), ...);
	end
	function MT.DebugDev(...)
		return MT.Print(date('|cff00ff00%H:%M:%S|r'), ...);
	end
	function MT.DebugRelease(...)
	end
	function MT.Notice(...)
		return MT.Print(date('|cffff0000%H:%M:%S|r'), ...);
	end

	MT.After = _G.C_Timer.After;
	local _TimerPrivate = {  };		--	[callback] = { periodic, int, running, halting, limit, };
	function MT._TimerStart(callback, int, limit)
		if callback ~= nil and type(callback) == 'function' then
			local P = _TimerPrivate[callback];
			if P == nil then
				P = {
					[1] = function()	--	periodic
						if P[4] then
							P[3] = false;
						elseif P[5] == nil then
							MT.After(P[2], P[1]);
							callback();
						elseif P[5] > 1 then
							P[5] = P[5] - 1;
							MT.After(P[2], P[1]);
							callback();
						elseif P[5] > 0 then
							P[3] = false;
							callback();
						else
							P[3] = false;
						end
					end,
					[2] = int or 1.0,	--	int
					[3] = true,			--	isrunning
					[4] = false,		--	ishalting
					[5] = limit,
				};
				_TimerPrivate[callback] = P;
				return MT.After(P[2], P[1]);
			elseif not P[3] then
				P[2] = int or 1.0;
				P[3] = true;
				P[4] = false;
				P[5] = limit;
				return MT.After(P[2], P[1]);
			else
				P[2] = int or P[2];
				P[4] = false;
				P[5] = limit;
			end
		end
	end
	function MT._TimerHalt(callback)
		local P = _TimerPrivate[callback];
		if P ~= nil and P[3] then
			P[4] = true;
		end
	end

	function MT.TimeString(len)
		if len < 1.0 then
			return format("%.1fs", len);
		elseif len < 10.0 then
			return format("%.1fs", len);
		elseif len < 60.0 then
			return format("%.1fs", len);
		elseif len < 3600.0 then
			return format("%dm%ds", len / 60, len % 60);
		else
			return format("%dh%dm%ds", len / 3600, len / 60, len % 60);
		end
	end

	MT.ErrorHandler = geterrorhandler();
	hooksecurefunc("seterrorhandler", function(ErrorHandler)
		MT.ErrorHandler = ErrorHandler;
	end);
	function MT.SafeCall(func, ...)
		local success, result = xpcall(
			func,
			MT.ErrorHandler,
			...
		);
		if success then
			return true, result;
		else
			return false;
		end
	end

	local _CallBackPrivate = {  };
	local _FireStackPrivate = {  };
	--	event, callback(..), method: 'prepend'[, 'append']
	function MT.AddCallback(event, callback, method)
		local new = false;
		local mem = _CallBackPrivate[event];
		if mem == nil then
			mem = {
				["*"] = function(...)
					for index = 1, mem.__num do
						MT.SafeCall(mem[index], ...);
					end
				end,
				callback,
				[callback] = true,
				__num = 1,
			};
			_CallBackPrivate[event] = mem;
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
		if new then
			local Stack = _FireStackPrivate[event];
			if Stack ~= nil then
				for index = 1, Stack.__num do
					MT.SafeCall(callback, unpack(Stack[index]));
				end
			end
		end
	end
	function MT.DelCallback(event, callback)
		local mem = _CallBackPrivate[event];
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
	function MT.FireCallback(event, ...)
		local Stack = _FireStackPrivate[event];
		if Stack == nil then
			_FireStackPrivate[event] = { __num = 1, [1] = { ... }, };
		else
			Stack.__num = Stack.__num + 1;
			Stack[Stack.__num] = { ... };
		end
		local mem = _CallBackPrivate[event];
		if mem ~= nil then
			return MT.SafeCall(mem["*"], ...);
		end
	end

	function MT.noop()
	end

	local _GoldIcon    = "|TInterface\\MoneyFrame\\UI-GoldIcon:12:12:0:0|t";
	local _SilverIcon  = "|TInterface\\MoneyFrame\\UI-SilverIcon:12:12:0:0|t";
	local _CopperIcon  = "|TInterface\\MoneyFrame\\UI-CopperIcon:12:12:0:0|t";
	function MT.GetMoneyString(copper)
		-- GetCoinTextureString
		local G = copper / 10000;
		G = G - G % 1.0;
		copper = copper % 10000;
		local S = copper / 100;
		S = S - S % 1.0;
		copper = copper % 100;
		local C = copper;
		C = C - C % 1.0;
		if G > 0 then
			return format("%d%s %02d%s %02d%s", G, _GoldIcon, S, _SilverIcon, C, _CopperIcon);
		elseif S > 0 then
			return format("%d%s %02d%s", S, _SilverIcon, C, _CopperIcon);
		else
			return format("%d%s", C, _CopperIcon);
		end
	end

	if CT.ISCLASSIC then
		function MT.GetSkillLink(sid)
			local name = GetSpellInfo(sid);
			if name then
				return "|cffffffff|Henchant:" .. sid .. "|h[" .. name .. "]|h|r";
			else
				return nil;
			end
		end
		function MT.HandleShiftClick(pid, sid)
			local set = VT.SET[pid];
			if set.showItemInsteadOfSpell then
				local cid = DT.DataAgent.get_cid_by_sid(sid);
				if cid then
					ChatEdit_InsertLink(DT.DataAgent.item_link(cid), __addon);
				else
					ChatEdit_InsertLink(MT.GetSkillLink(sid), __addon);
				end
			else
				ChatEdit_InsertLink(MT.GetSkillLink(sid), __addon);
			end
		end
	elseif CT.VGT2X then
		function MT.GetSkillLink(sid)
			local name = GetSpellInfo(sid);
			if name then
				return "|cffffd000|Henchant:" .. sid .. "|h[" .. name .. "]|h|r";
			else
				return nil;
			end
		end
		function MT.HandleShiftClick(pid, sid)
			local set = VT.SET[pid];
			if set.showItemInsteadOfSpell then
				local cid = DT.DataAgent.get_cid_by_sid(sid);
				if cid then
					ChatEdit_InsertLink(DT.DataAgent.item_link(cid), __addon);
				else
					ChatEdit_InsertLink(MT.GetSkillLink(sid), __addon);
				end
			else
				ChatEdit_InsertLink(MT.GetSkillLink(sid), __addon);
			end
		end
	else
		function MT.GetSkillLink(sid)
			return nil;
		end
		function MT.HandleShiftClick(pid, sid)
		end
	end

	function MT.GetTradeSkillSpellModifiedCooldown(sid, formatStr)
		local start, duration, enabled, modRate = GetSpellCooldown(sid);
		if start ~= nil and start > 0 then
			local now = GetTime();
			if start > now then
				start = start - 4294967.28;
			end
			if formatStr then
				local sec = duration + start - now;
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
					formatStr = format("%dd %02dh %02dm %02ds", d, h, m, sec);
				elseif h > 0 then
					formatStr = format("%dh %02dm %02ds", h, m, sec);
				elseif m > 0 then
					formatStr = format("%dm %02ds", m, sec);
				else
					formatStr = format("%ds", sec);
				end
			else
				formatStr = nil;
			end
			return true, start, duration, enabled, modRate, formatStr;
		else
			return false, 0, 0, enabled, modRate, nil;
		end
	end

-->
	DT.DataAgent = {  };
	VT.UIFrames = {  };
	VT.AuctionMods = {  };

-->		Main
	local __beforeinit = {  };
	local __oninit = {  };
	local __afterinit = {  };
	local __onlogin = {  };
	local __onquit = {  };
	local __onaddonloaded = {  };
	function MT.RegisterBeforeInit(key, method)
		if type(key) == 'string' and type(method) == 'function' then
			__beforeinit[#__beforeinit + 1] = key;
			__beforeinit[key] = method;
		end
	end
	function MT.RegisterOnInit(key, method)
		if type(key) == 'string' and type(method) == 'function' then
			__oninit[#__oninit + 1] = key;
			__oninit[key] = method;
		end
	end
	function MT.CallOnInit(key)
		local method = __oninit[key];
		if method ~= nil then
			return method();
		end
	end
	function MT.RegisterAfterInit(key, method)
		if type(key) == 'string' and type(method) == 'function' then
			__afterinit[#__afterinit + 1] = key;
			__afterinit[key] = method;
		end
	end
	function MT.RegisterOnLogin(key, method)
		if type(key) == 'string' and type(method) == 'function' then
			__onlogin[#__onlogin + 1] = key;
			__onlogin[key] = method;
		end
	end
	function MT.RegisterOnQuit(key, method)
		if type(key) == 'string' and type(method) == 'function' then
			__onquit[#__onquit + 1] = key;
			__onquit[key] = method;
		end
	end
	function MT.RegisterOnAddOnLoaded(addon, callback)
		addon = strupper(addon);
		local callbacks = __onaddonloaded[addon];
		if callbacks == nil then
			__onaddonloaded[addon] = { callback, };
		else
			callbacks[#callbacks + 1] = callback;
		end
		if VT.__is_loggedin and VT.__is_this_loaded and IsAddOnLoaded(addon) then
			return MT.SafeCall(callback, addon);
		end
	end

	MT.GetUnifiedTime();		--	initialized after call once
	local Driver = CreateFrame('FRAME');
	Driver:RegisterEvent("ADDON_LOADED");
	Driver:RegisterEvent("PLAYER_LOGOUT");
	Driver:RegisterEvent("PLAYER_LOGIN");
	Driver:SetScript("OnEvent", function(Driver, event, addon)
		if event == "ADDON_LOADED" then
			if addon == __addon then
				VT.__is_loggedin = IsLoggedIn();
				--
				for index = 1, #__beforeinit do
					local key = __beforeinit[index];
					local method = __beforeinit[key];
					xpcall(method, MT.ErrorHandler, VT.__is_loggedin);
				end
				for index = 1, #__oninit do
					local key = __oninit[index];
					local method = __oninit[key];
					xpcall(method, MT.ErrorHandler, VT.__is_loggedin);
					--[==[local success, message = pcall(method);
					if not success then
						MT.ErrorHandler(message or (__addon .. " INIT SCRIPT [[" .. key .. "]] ERROR."));
					end]==]
				end
				for index = 1, #__afterinit do
					local key = __afterinit[index];
					local method = __afterinit[key];
					xpcall(method, MT.ErrorHandler, VT.__is_loggedin);
				end
				VT.__is_this_loaded = true;
				if VT.__is_loggedin then
					return Driver:GetScript("OnEvent")(Driver, "PLAYER_LOGIN");
				end
			else
				addon = strupper(addon);
				local callbacks = __onaddonloaded[addon];
				if callbacks ~= nil then
					for i = 1, #callbacks do
						MT.SafeCall(callbacks[i], addon);
					end
				end
			end
		elseif event == "PLAYER_LOGIN" then
			if VT.__is_this_loaded then
				Driver:UnregisterEvent("PLAYER_LOGIN");
				VT.__is_loggedin = true;
				for index = 1, #__onlogin do
					local key = __onlogin[index];
					local method = __onlogin[key];
					xpcall(method, MT.ErrorHandler, true);
				end
				for addon, callbacks in next, __onaddonloaded do
					if IsAddOnLoaded(addon) then
						for i = 1, #callbacks do
							MT.SafeCall(callbacks[i], addon);
						end
					end
				end
			end
		elseif event == "PLAYER_LOGOUT" then
			for index = 1, #__onquit do
				local key = __onquit[index];
				local method = __onquit[key];
				xpcall(method, MT.ErrorHandler);
			end
		end
	end);

	VT.__is_loggedin = IsLoggedIn();
	VT.__is_this_loaded = false;

	if VT.__is_dev then
		MT.Debug = MT.DebugDev;
	else
		MT.Debug = MT.DebugRelease;
	end
	MT.AddCallback("AUCTION_MOD_LOADED", function(mod)
		if mod ~= nil then
			VT.AuctionMod = mod;
			if VT.AuctionMods[mod] == nil then
				local index = #VT.AuctionMods + 1;
				VT.AuctionMods[index] = mod;
				VT.AuctionMods[mod] = index;
			end
		end
	end);

-->
