--[[--
	by ALA @ 163UI/网易有爱, http://wowui.w.163.com/163ui/
	CREDIT shagu/pfQuest(MIT LICENSE) @ https://github.com/shagu
--]]--
----------------------------------------------------------------------------------------------------
local _G = _G;
local __ala_meta__ = _G.__ala_meta__;

local __addon, __ns = ...;
__ala_meta__.quest = __ns;

local __core = {  };
__ns.core = __core;
__ns.____bn_tag = select(2, BNGetInfo());
__ns.__is_dev = select(2, GetAddOnInfo("!!!!!DebugMe")) ~= nil;
__ns.__toc = select(4, GetBuildInfo());
__ns.__expansion = GetExpansionLevel();
__ns.__maxLevel = GetMaxLevelForExpansionLevel(__ns.__expansion);
__ns.__locale = GetLocale();
__ns.After = C_Timer.After;
__ns.NewTicker = C_Timer.NewTicker;
__ns.NewTimer = C_Timer.NewTimer;

-->		Dev
	local setfenv = setfenv;
	local rawset = rawset;
	local next = next;
	local _GlobalRef = {  };
	local _GlobalAssign = {  };
	function __ns:BuildEnv(category)
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
	function __ns:MergeGlobal(DB)
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
-->

local _ = nil;
--------------------------------------------------

-->		upvalue
	local xpcall = xpcall;
	local debugprofilestart, debugprofilestop = debugprofilestart, debugprofilestop;
	local geterrorhandler = geterrorhandler;
	local hooksecurefunc = hooksecurefunc;
	local date = date;
	local GetTimePreciseSec = GetTimePreciseSec;
	local next, ipairs = next, ipairs;
	local select = select;
	local setmetatable = setmetatable;
	local tremove, table_concat = table.remove, table.concat;
	local strbyte, strmatch, format, gsub = string.byte, string.match, string.format, string.gsub;
	local min = math.min;
	local _bit_band = bit.band;
	local loadstring = loadstring;
	local tostring = tostring;
	local CreateFrame = CreateFrame;
	local GetQuestTagInfo = GetQuestTagInfo;
	local UnitPosition = UnitPosition;
	local C_Map = C_Map;
	local CreateVector2D = CreateVector2D;

	local _PLAYER_GUID = UnitGUID('player');
	local _PLAYER_NAME = UnitName('player');
	local _PLAYER_RACE, _PLAYER_RACEFILE, _PLAYER_RACEID = UnitRace('player');
	local _PLAYER_CLASS = UnitClassBase('player');
	local _PLAYER_FACTIONGROUP = UnitFactionGroup('player');
	__core._PLAYER_GUID = _PLAYER_GUID;
	__core._PLAYER_NAME = _PLAYER_NAME;
	__core._PLAYER_RACE = _PLAYER_RACE;
	__core._PLAYER_RACEFILE = _PLAYER_RACEFILE;
	__core._PLAYER_RACEID = _PLAYER_RACEID;
	__core._PLAYER_CLASS = _PLAYER_CLASS;
	__core._PLAYER_FACTIONGROUP = _PLAYER_FACTIONGROUP;
-->

if __ns.__is_dev then
	__ns:BuildEnv("init");
end

-->		Time
	local _debugprofilestart, _debugprofilestop = debugprofilestart, debugprofilestop;
	local TheFuckingAccurateTime = _G.AccurateTime;
	--	Fuck the fucking idiot's code. I think his head is full of bullshit.
	if TheFuckingAccurateTime ~= nil then
		_debugprofilestart = TheFuckingAccurateTime._debugprofilestart or _debugprofilestart;
		_debugprofilestop = TheFuckingAccurateTime._debugprofilestop or _debugprofilestop;
	end
	--
	local _LT_devDebugProfilePoint = {
		["*"] = 0,
	};
	local function _F_devDebugProfileStart(key)
		_LT_devDebugProfilePoint[key] = _debugprofilestop();
	end
	local function _F_devDebugProfileTick(key)
		local _val = _LT_devDebugProfilePoint[key];
		if _val ~= nil then
			_val = _debugprofilestop() - _val;
			_val = _val - _val % 0.0001;
			return _val;
		end
	end
	__ns._F_devDebugProfileStart = _F_devDebugProfileStart;
	__ns._F_devDebugProfileTick = _F_devDebugProfileTick;
	local _LN_devTheLastDebugProfilePoint = _debugprofilestop();
	function _G.debugprofilestart()
		_LN_devTheLastDebugProfilePoint = _debugprofilestop();
	end
	function _G.debugprofilestop()
		return _debugprofilestop() - _LN_devTheLastDebugProfilePoint;
	end
	-->		Time
	if GetTimePreciseSec == nil then
		_F_devDebugProfileStart("_sys._1core.time.alternative");
		GetTimePreciseSec = function()
			return _F_devDebugProfileTick("_sys._1core.time.alternative");
		end
		_G.GetTimePreciseSec = GetTimePreciseSec;
	end
	local _LN_devBaseTime = GetTimePreciseSec();
	function __ns._F_devGetPreciseTime()
		local _now = GetTimePreciseSec() - _LN_devBaseTime + 0.00005;
		return _now - _now % 0.0001;
	end
-->

--[=[dev]=]	if __ns.__is_dev then __ns._F_devDebugProfileStart('module.init'); end

local SET = nil;

-->		SafeCall
	local _F_ErrorHandler = geterrorhandler();
	hooksecurefunc("seterrorhandler", function(handler)
		_F_ErrorHandler = handler;
	end);
	function __core._F_SafeCall(func, ...)
		return xpcall(func, _F_ErrorHandler, ...);
	end
-->

-->		EventHandler
	local _EventHandler = CreateFrame('FRAME');
	__core.__eventHandler = _EventHandler;
	local function _noop_()
	end
	-->		Simple Event Dispatcher
		local function OnEvent(self, event, ...)
			return __ns[event](...);
		end
		function _EventHandler:FireEvent(event, ...)
			local func = __ns[event];
			if func then
				return func(...);
			end
		end
		function _EventHandler:RegEvent(event, func)
			__ns[event] = func or __ns[event] or _noop_;
			self:RegisterEvent(event);
			self:SetScript("OnEvent", OnEvent);
		end
		function _EventHandler:UnregEvent(event)
			self:UnregisterEvent(event);
		end
	-->		run_on_next_tick	--	execute 0.2s ~ 0.3s later
		local run_on_next_tick_func_1 = {  };
		local run_on_next_tick_func_2 = {  };
		local run_on_next_tick_hash_1 = {  };
		local run_on_next_tick_hash_2 = {  };
		local timer = 0.0;
		--	run in sequence of 'insert'
		local function run_on_next_tick_handler(self, elasped)
			timer = timer + elasped;
			if timer >= 0.15 then
				timer = 0.0;
				local func = tremove(run_on_next_tick_func_2, 1);
				while func ~= nil do
					if run_on_next_tick_hash_2[func] ~= nil then
						func();
						-- run_on_next_tick_hash_2[func] = nil;
					end
					func = tremove(run_on_next_tick_func_2, 1);
				end
				if run_on_next_tick_func_1[1] == nil then
					_EventHandler:SetScript("OnUpdate", nil);
					run_on_next_tick_hash_1 = {  };
					run_on_next_tick_hash_2 = {  };
				else
					run_on_next_tick_func_1, run_on_next_tick_func_2 = run_on_next_tick_func_2, run_on_next_tick_func_1;
					-- run_on_next_tick_hash_1, run_on_next_tick_hash_2 = run_on_next_tick_hash_2, run_on_next_tick_hash_1;
					run_on_next_tick_hash_2 = run_on_next_tick_hash_1;
					run_on_next_tick_hash_1 = {  };
				end
			end
		end
		function _EventHandler:run_on_next_tick(func)
			if run_on_next_tick_hash_1[func] ~= nil then
				return false;
			end
			-- if run_on_next_tick_hash_2[func] ~= nil then
			-- 	return false;
			-- end
			local index = #run_on_next_tick_func_1 + 1;
			run_on_next_tick_func_1[index] = func;
			run_on_next_tick_hash_1[func] = index;
			self:SetScript("OnUpdate", run_on_next_tick_handler);
			return true;
		end
	-->
-->

-->		Const
	__core.__const = {
		TAG_DEFAULT = '__pin_tag_default',
		TAG_WM_COMMON = '__pin_tag_wm_common',
		TAG_WM_LARGE = '__pin_tag_wm_large',
		TAG_WM_VARIED = '__pin_tag_wm_varied',
		TAG_MM_COMMON = '__pin_tag_mm_common',
		TAG_MM_LARGE = '__pin_tag_mm_large',
		TAG_MM_VARIED = '__pin_tag_mm_varied',
	};
-->

-->		Restricted Implementation
	local _F_SafeCall = __core._F_SafeCall;
	local _LT_CorePrint_Method_Env = {
		select = select,
		tostring = tostring,
		format = format,
		table_concat = table_concat,
		__DefaultMessageFrame = _G.DEFAULT_CHAT_FRAME,
	};
	local _LT_CorePrint_Method = setmetatable(
		{
			[0] = setfenv(
				function()
					__DefaultMessageFrame:AddMessage("|cff00ff00>|r nil");
				end,
				_LT_CorePrint_Method_Env
			),
			["*"] = setfenv(
				function(...)
					local _nargs = select("#", ...);
					local _argsv = { ... };
					for _index = _nargs, 1, -1 do
						if _argsv[_index] ~= nil then
							_nargs = _index;
							break;
						end
					end
					for _index = 1, _nargs do
						_argsv[_index] = tostring(_argsv[_index]);
					end
					__DefaultMessageFrame:AddMessage("|cff00ff00>|r " .. table_concat(_argsv, " "));
				end,
				_LT_CorePrint_Method_Env
			),
		},
		{
			__index = function(tbl, nargs)
				if nargs > 0 and nargs < 8 then
					local _head = [[local tostring = tostring;\nreturn function(arg1]];
					local _body = [[) __DefaultMessageFrame:AddMessage("|cff00ff00>|r " .. tostring(arg1)]];
					local _tail = [[); end]];
					for _index = 2, nargs do
						_head = _head .. [[, arg]] .. _index;
						_body = _body .. [[ .. " " .. tostring(arg]] .. _index .. [[)]];
					end
					local _func0, _err = loadstring(_head .. _body .. _tail);
					if _func0 == nil then
						local _func = tbl["*"];
						tbl[nargs] = _func;
						return _func;
					else
						local _, _func = _F_SafeCall(_func0);
						if _func == nil then
							_func = tbl["*"];
						else
							setfenv(_func, _LT_CorePrint_Method_Env);
						end
						tbl[nargs] = _func;
						return _func;
					end
				else
					local _func = tbl["*"];
					tbl[nargs] = _func;
					return _func;
				end
			end,
		}
	);
	for _index = 1, 8 do
		local _func = _LT_CorePrint_Method[_index];
	end
	local function _F_CorePrint(...)
		local _func = _LT_CorePrint_Method[select('#', ...)];
		if _func ~= nil then
			_func(...);
		end
	end
	__ns._F_CorePrint = _F_CorePrint;
-->
local _F_CorePrint = __ns._F_CorePrint;

-->		string
	local function BuildRegularExp(pattern)
		--	escape magic characters
		pattern = gsub(pattern, "([%+%-%*%(%)%?%[%]%^])", "%%%1");
		--	remove capture indexes
		pattern = gsub(pattern, "%d%$", "");
		--	catch all characters
		pattern = gsub(pattern, "(%%%a)", "%(%1+%)");
		--	convert all %s to .+
		pattern = gsub(pattern, "%%s%+", ".+");
		--	set priority to numbers over strings
		pattern = gsub(pattern, "%(.%+%)%(%%d%+%)", "%(.-%)%(%%d%+%)");

		return pattern;
	end
	__core.__L_QUEST_MONSTERS_KILLED = BuildRegularExp(_G.QUEST_MONSTERS_KILLED);
	__core.__L_QUEST_ITEMS_NEEDED = BuildRegularExp(_G.QUEST_ITEMS_NEEDED);
	__core.__L_QUEST_OBJECTS_FOUND = BuildRegularExp(_G.QUEST_OBJECTS_FOUND);
	if strmatch(_G.QUEST_MONSTERS_KILLED, "：") then
		__core.__L_QUEST_DEFAULT_PATTERN = "(.+)：";
	else
		__core.__L_QUEST_DEFAULT_PATTERN = "(.+):";
	end 

	local LevenshteinDistance;
	--[[if __ns.__locale == "zhCN" or __ns.__locale == "zhTW" or __ns.__locale == "koKR" then
			--	modified https://gist.github.com/Badgerati/3261142
			local function CutUTF8Str(str)
				local tstr = {  };
				local tlen = 0;
				local len = #str;
				local pos = 1;
				while pos < len do
					local b = strbyte(str, pos);
					if b >= 0xfc then		--	11111100	6
						tlen = tlen + 1;
						tstr[tlen] = strsub(str, pos, pos + 5);
						pos = pos + 6;
					elseif b >= 0xf8 then	--	11111000	5
						tlen = tlen + 1;
						tstr[tlen] = strsub(str, pos, pos + 4);
						pos = pos + 5;
					elseif b >= 0xf0 then	--	11110000	4
						tlen = tlen + 1;
						tstr[tlen] = strsub(str, pos, pos + 3);
						pos = pos + 4;
					elseif b >= 0xe0 then	--	11100000	3
						tlen = tlen + 1;
						tstr[tlen] = strsub(str, pos, pos + 2);
						pos = pos + 3;
					elseif b >= 0xc0 then	--	11000000	2
						tlen = tlen + 1;
						tstr[tlen] = strsub(str, pos, pos + 1);
						pos = pos + 2;
					elseif b >= 0x80 then	--	10000000	error
					else					--	00000000	1
						tlen = tlen + 1;
						tstr[tlen] = strsub(str, pos, pos);
						pos = pos + 1;
					end
				end
				return tstr, tlen;
			end
			function LevenshteinDistance(str1, str2)
				--	quick cut-offs to save time
				if str1 == "" then
					return #str2;
				elseif str2 == "" then
					return #str1;
				elseif str1 == str2 then
					return 0;
				end

				local tstr1, tlen1 = CutUTF8Str(str1);
				local tstr2, tlen2 = CutUTF8Str(str2);
				local matrix = {  };

				--	initialise the base matrix values
				for i = 0, tlen1 do
					matrix[i] = {  };
					matrix[i][0] = i;
				end
				for j = 0, tlen2 do
					matrix[0][j] = j;
				end

				--	actual Levenshtein algorithm
				for i = 1, tlen1 do
					for j = 1, tlen2 do
						if tstr1[i] == tstr2[j] then
							matrix[i][j] = min(matrix[i - 1][j] + 1, matrix[i][j - 1] + 1, matrix[i - 1][j - 1]);
						else
							matrix[i][j] = min(matrix[i - 1][j] + 1, matrix[i][j - 1] + 1, matrix[i - 1][j - 1] + 1);
						end
					end
				end

				--	return the last value - this is the Levenshtein distance
				return matrix[tlen1][tlen2];
			end
	else--]]
		if _G.CalculateStringEditDistance ~= nil then
			LevenshteinDistance = _G.CalculateStringEditDistance;
		else
			--	credit https://gist.github.com/Badgerati/3261142
			function LevenshteinDistance(str1, str2)
				--	quick cut-offs to save time
				if str1 == "" then
					return #str2;
				elseif str2 == "" then
					return #str1;
				elseif str1 == str2 then
					return 0;
				end

				local len1 = #str1;
				local len2 = #str2;
				local matrix = {  };

				--	initialise the base matrix values
				for i = 0, len1 do
					matrix[i] = {  };
					matrix[i][0] = i;
				end
				for j = 0, len2 do
					matrix[0][j] = j;
				end

				--	actual Levenshtein algorithm
				for i = 1, len1 do
					for j = 1, len2 do
						if strbyte(str1, i) == strbyte(str2, j) then
							matrix[i][j] = min(matrix[i - 1][j] + 1, matrix[i][j - 1] + 1, matrix[i - 1][j - 1]);
						else
							matrix[i][j] = min(matrix[i - 1][j] + 1, matrix[i][j - 1] + 1, matrix[i - 1][j - 1] + 1);
						end
					end
				end

				--	return the last value - this is the Levenshtein distance
				return matrix[len1][len2];
			end
		end
	-- end

	local BIG_NUMBER = 4294967295;
	local function FindMinLevenshteinDistance(str, loc, ids)
		local bestDistance = BIG_NUMBER;
		local bestIndex = -1;
		local bestTextLen = nil;
		for index = 1, #ids do
			local id = ids[index];
			local text = loc[id];
			if text ~= nil then
				local distance = LevenshteinDistance(str, text);
				if distance < bestDistance or (distance == bestDistance and #text < bestTextLen) then
					bestDistance = distance;
					bestIndex = index;
					bestTextLen = #text;
				end
			end
		end
		return ids[bestIndex], bestIndex, bestDistance;
	end

	__core.LevenshteinDistance = LevenshteinDistance;
	__core.FindMinLevenshteinDistance = FindMinLevenshteinDistance;
-->

-->		bit-data
	local bitrace = {
		["Human"] = 1,
		["Orc"] = 2,
		["Dwarf"] = 4,
		["NightElf"] = 8,
		["Scourge"] = 16,
		["Tauren"] = 32,
		["Gnome"] = 64,
		["Troll"] = 128,
		["Goblin"] = 256,
		["BloodElf"] = 512,
		["Draenei"] = 1024,
	};
	local racebit = {  }; for _race, _bit in next, bitrace do racebit[_bit] = _race; end
	local bitclass = {
		["WARRIOR"] = 1,
		["PALADIN"] = 2,
		["HUNTER"] = 4,
		["ROGUE"] = 8,
		["PRIEST"] = 16,
		["SHAMAN"] = 64,
		["MAGE"] = 128,
		["WARLOCK"] = 256,
		["DRUID"] = 1024,
	};
	local classbit = {  }; for _class, _bit in next, bitclass do classbit[_bit] = _class; end
	local _PLAYER_RACEBIT = bitrace[_PLAYER_RACEFILE];
	local _PLAYER_CLASSBIT = bitclass[_PLAYER_CLASS];
	local function bit_check(_b1, _b2)
		return _bit_band(_b1, _b2) ~= 0;
	end
	local function bit_check_race(_b)
		return _bit_band(_b, _PLAYER_RACEBIT) ~= 0;
	end
	local function bit_check_class(_b)
		return _bit_band(_b, _PLAYER_CLASSBIT) ~= 0;
	end
	local function bit_check_race_class(_b1, _b2)
		return _bit_band(_b1, _PLAYER_RACEBIT) ~= 0 and _bit_band(_b2, _PLAYER_CLASSBIT) ~= 0;
	end
	__core.__bitrace = bitrace;
	__core.__racebit = racebit;
	__core.__bitclass = bitclass;
	__core.__classbit = classbit;
	__core._PLAYER_RACEBIT = _PLAYER_RACEBIT;
	__core._PLAYER_CLASSBIT = _PLAYER_CLASSBIT;
	__core.__bit_check = bit_check;
	__core.__bit_check_race = bit_check_race;
	__core.__bit_check_class = bit_check_class;
	__core.__bit_check_race_class = bit_check_race_class;
-->

-->		Map			--	坐标系转换方法，参考自HandyNotes	--	C_Map效率非常低，可能因为构建太多Mixin(CreateVector2D)
	--
	--[[
		mapType
			0 = COSMIS
			1 = WORLD
			2 = CONTINENT
			3 = ZONE
			4 = DUNGEON
			5 = MICRO
			6 = ORPHAN
	]]
	local C_Map_GetBestMapForUnit = C_Map.GetBestMapForUnit;
	local C_Map_GetWorldPosFromMapPos = C_Map.GetWorldPosFromMapPos;
	local C_Map_GetMapChildrenInfo = C_Map.GetMapChildrenInfo;
	local C_Map_GetMapGroupID = C_Map.GetMapGroupID;
	local C_Map_GetMapGroupMembersInfo = C_Map.GetMapGroupMembersInfo;
	local C_Map_GetMapInfo = C_Map.GetMapInfo;
	local C_Map_GetMapInfoAtPosition = C_Map.GetMapInfoAtPosition;
	--
	local WORLD_MAP_ID = C_Map.GetFallbackWorldMapID() or 947;		--	947
	local MapTypeDungeon = Enum.UIMapType.Dungeon;
	local mapMeta = {  };		--	[map] = { 1width, 2height, 3left, 4top, [instance], [name], [mapType], [parent], [children], [adjoined], }
	local worldMapData = nil;		--	[instance] = { 1width, 2height, 3left, 4top, }
	if __ns.__toc < 20000 then
		worldMapData= {		--	[instance] = { 1width, 2height, 3left, 4top, }
			[0] = { 44688.53, 29795.11, 32601.04, 9894.93 },	--	Eastern Kingdoms
			[1] = { 44878.66, 29916.10, 8723.96, 14824.53 },	--	Kalimdor
		};
	elseif __ns.__toc < 30000 then
		worldMapData= {		--	[instance] = { 1width, 2height, 3left, 4top, }
			[0] = { 44688.53, 29791.24, 32681.47, 11479.44 },	--	Eastern Kingdoms
			[1] = { 44878.66, 29916.10,  8723.96, 14824.53 },	--	Kalimdor
		};
	end
	local TransformMeta = {  };
	-->		TransformData from HBD
		local transformData;
		if __ns.__toc >= 20000 and __ns.__toc < 30000 then
			transformData = {
				{ 530, 0, 4800, 16000, -10133.3, -2666.67, -2400, 2662.8 },
				{ 530, 1, -6933.33, 533.33, -16000, -8000, 10339.7, 17600 },
			};
		else
			transformData = {
				{ 530, 1, -6933.33, 533.33, -16000, -8000, 9916, 17600 },
				{ 530, 0, 4800, 16000, -10133.3, -2666.67, -2400, 2400 },
				{ 732, 0, -3200, 533.3, -533.3, 2666.7, -611.8, 3904.3 },
				{ 1064, 870, 5391, 8148, 3518, 7655, -2134.2, -2286.6 },
				{ 1208, 1116, -2666, -2133, -2133, -1600, 10210.7, 2411.4 },
				{ 1460, 1220, -1066.7, 2133.3, 0, 3200, -2333.9, 966.7 },
				{ 1599, 1, 4800, 5866.7, -4266.7, -3200, -490.6, -0.4 },
				{ 1609, 571, 6400, 8533.3, -1600, 533.3, 512.8, 545.3 },
			};
		end
		for _, transform in next, transformData do
			local instance = transform[1];
			local meta = TransformMeta[instance]
			if TransformMeta[instance] == nil then
				meta = {
					{
						newInstanceID = transform[2],
						minY = transform[3],
						maxY = transform[4],
						minX = transform[5],
						maxX = transform[6],
						offsetY = transform[7],
						offsetX = transform[8],
					},
				};
				TransformMeta[instance] = meta;
			else
				meta[#meta + 1] = {
					newInstanceID = transform[2],
					minY = transform[3],
					maxY = transform[4],
					minX = transform[5],
					maxX = transform[6],
					offsetY = transform[7],
					offsetX = transform[8],
				};
			end
		end
	-->
	local function TransformCoord(instance, x, y)
		if TransformMeta[instance] then
			for _, data in ipairs(TransformMeta[instance]) do
				if x <= data.maxX and x >= data.minX and y <= data.maxY and y >= data.minY then
					instance = data.newInstanceID;
					x = x + data.offsetX;
					y = y + data.offsetY;
					break;
				end
			end
		end
		return instance, x, y;
	end
	local function TransformScope(instance, left, right, top, bottom)
		if TransformMeta[instance] then
			for _, data in ipairs(TransformMeta[instance]) do
				if left <= data.maxX and right >= data.minX and top <= data.maxY and bottom >= data.minY then
					instance = data.newInstanceID;
					left   = left   + data.offsetX;
					right  = right  + data.offsetX;
					top    = top    + data.offsetY;
					bottom = bottom + data.offsetY;
					break;
				end
			end
		end
		return instance, left, right, top, bottom;
	end
	local __player_map_id = C_Map_GetBestMapForUnit('player');
	function __ns.InitMapAgent()
		local mapHandler = CreateFrame('FRAME');
		mapHandler:SetScript("OnEvent", function(self, event)
			local map = C_Map_GetBestMapForUnit('player');
			if __player_map_id ~= map then
				__player_map_id = map;
				_EventHandler:FireEvent("__PLAYER_ZONE_CHANGED", map);
			end
		end);
		mapHandler:UnregisterAllEvents();
		mapHandler:RegisterEvent("ZONE_CHANGED_NEW_AREA");
		mapHandler:RegisterEvent("ZONE_CHANGED");
		mapHandler:RegisterEvent("ZONE_CHANGED_INDOORS");
		mapHandler:RegisterEvent("NEW_WMO_CHUNK");
		mapHandler:RegisterEvent("PLAYER_ENTERING_WORLD");
		--	地图坐标系【右手系，右下为0】(x, y, z) >> 地图坐标系【左手系,左上为0】(-y, -x, z)
		local vector0000 = CreateVector2D(0, 0);
		local vector0505 = CreateVector2D(0.5, 0.5);
		local processMap = nil;
		processMap = function(map)
			local meta = mapMeta[map];
			if meta == nil then
				local data = C_Map_GetMapInfo(map);
				if data ~= nil and data.mapType ~= MapTypeDungeon then
					--	get two positions from the map, we use 0/0 and 0.5/0.5 to avoid issues on some maps where 1/1 is translated inaccurately
					local instance, x00y00 = C_Map_GetWorldPosFromMapPos(map, vector0000);
					local _, x05y05 = C_Map_GetWorldPosFromMapPos(map, vector0505);
					if x00y00 ~= nil and x05y05 ~= nil then
						local top, left = x00y00:GetXY();
						local bottom, right = x05y05:GetXY();
						bottom = top + (bottom - top) * 2;
						right = left + (right - left) * 2;
						instance, left, right, top, bottom = TransformScope(instance, left, right, top, bottom);
						meta = { left - right, top - bottom, left, top, instance = instance,       name = data.name, mapType = data.mapType, };
						mapMeta[map] = meta;
					else
						meta = { 0, 0, 0, 0,                            instance = instance or -1, name = data.name, mapType = data.mapType, };
						mapMeta[map] = meta;
					end
					local pmap = data.parentMapID;
					if pmap ~= nil then
						local pmeta = processMap(pmap);
						if pmeta ~= nil then
							meta.parent = pmap;
							local cmaps = pmeta.children;
							if cmaps == nil then
								cmaps = {  };
								pmeta.children = cmaps;
							end
							cmaps[map] = 1;
						end
					end
					local children = C_Map_GetMapChildrenInfo(map);
					if children ~= nil and children[1] ~= nil then
						for index = 1, #children do
							local cmap = children[index].mapID;
							if cmap ~= nil then
								local cmeta = processMap(cmap);
								if cmeta ~= nil then
									local cmaps = meta.children;
									if cmaps == nil then
										cmaps = {  };
										meta.children = cmaps;
									end
									cmaps[cmap] = 1;
									cmeta.parent = map;
								end
							end
						end
					end
					--	process sibling maps (in the same group)
					--	in some cases these are not discovered by GetMapChildrenInfo above
					-->		Maybe classic doesnot use it.
					local groupID = C_Map_GetMapGroupID(map);
					if groupID then
						local groupMembers = C_Map_GetMapGroupMembersInfo(groupID);
						if groupMembers ~= nil and groupMembers[1] ~= nil then
							for index = 1, #groupMembers do
								local mmap = groupMembers[index].mapID;
								if mmap ~= nil then
									processMap(mmap);
								end
							end
						end
					end
					for x = 0.00, 1.00, 0.25 do
						for y = 0.00, 1.00, 0.25 do
							local adata = C_Map_GetMapInfoAtPosition(map, x, y);
							if adata ~= nil then
								local amap = adata.mapID;
								if amap ~= nil and amap ~= map then
									local ameta = processMap(amap);
									if ameta ~= nil and ameta.parent ~= map then
										local amaps = meta.adjoined;
										if amaps == nil then
											amaps = { [amap] = 1, };
											meta.adjoined = amaps;
										else
											amaps[amap] = 1;
										end
									end
								end
							end
						end
					end
				end
			end
			return meta;
		end
		--	find all maps in well known structures
		processMap(WORLD_MAP_ID);
		--	try to fill in holes in the map list
		for map = 1, 2000 do
			processMap(map);
		end
		if __ns.__toc >= 20000 and __ns.__toc < 30000 then
			local data = {
				[1438] = { 1457, },	--	泰达希尔
				[1457] = { 1438, },	--	达纳苏斯
				--
				[1944] = { 1946, 1951, 1952, },				--	地狱火半岛
				[1946] = { 1944, 1949, 1951, 1952, 1955, },	--	赞加沼泽
				[1948] = { 1952, },							--	影月谷
				[1949] = { 1946, 1953, },					--	刀锋山
				[1951] = { 1944, 1946, 1952, 1955, },		--	纳格兰
				[1952] = { 1944, 1946, 1948, 1951, 1955, },	--	泰罗卡森林
				[1953] = { 1949, },							--	虚空风暴
				[1955] = { 1946, 1951, 1952, },				--	沙塔斯城
						--
				[1947] = { 1943, },	--	埃索达
				[1950] = { 1943, },	--	秘血岛
				[1943] = { 1947, },	--	秘蓝岛
				[1941] = { 1942, 1954, },	--	永歌森林
				[1942] = { 1941, },	--	幽魂之地
				[1954] = { 1941, },	--	银月城
			};
			for map, list in next, data do
				local meta = mapMeta[map];
				if meta ~= nil then
					local amaps = meta.adjoined;
					for _, val in next, list do
						if mapMeta[val] ~= nil then
							if amaps == nil then
								amaps = { [val] = 1, };
								meta.adjoined = amaps;
							else
								amaps[val] = 1;
							end
						end
					end
				end
			end
		end
		--	fill in continent and planet
		local function FillInChildren(which, map, children)
			for cmap, _ in next, children do
				local cmeta = mapMeta[cmap];
				if cmeta ~= nil then
					cmeta[which] = map;
					if cmeta.children ~= nil then
						FillInChildren(which, map, cmeta.children)
					end
				end
			end
		end
		local function FillIn(which, map)
			local meta = mapMeta[map];
			if meta ~= nil and meta.children ~= nil then
				FillInChildren(which, map, meta.children);
			end
		end
		FillIn("universe", 946);
		FillIn("planet", 947);
		FillIn("planet", 1945);
		FillIn("continent", 1414);
		FillIn("continent", 1415);
		FillIn("continent", 1945);
	end
	__core.ContinentMapID = {
		[946] = "Universe",
		[947] = "Azeroth",
		[1414] = "Kalimdor",
		[1415] = "Eastern Kingdoms",
		[1945] = "Outland",
	};
	--	return map, x, y
	local function GetUnitPosition(unit)
		local y, x, _z, map = UnitPosition(unit);
		return TransformCoord(map, x, y);
		-- return map, y, x;
	end
	--	return map, x, y	-->	bound to [0.0, 1.0]
	local function GetZonePositionFromWorldPosition(map, x, y)
		local data = mapMeta[map];
		if data ~= nil and data[2] ~= 0 then
			x, y = (data[3] - x) / data[1], (data[4] - y) / data[2];
			if x <= 1.0 and x >= 0.0 and y <= 1.0 and y >= 0.0 then
				return map, x, y;
			end
		end
		return nil, nil, nil;
	end
	--	return instance, x[0.0, 1.0], y[0.0, 1.0]
	local function GetWorldPositionFromZonePosition(map, x, y)
		local data = mapMeta[map];
		if data ~= nil then
			x, y = data[3] - data[1] * x, data[4] - data[2] * y;
			return data.instance, x, y;
		end
		return nil, nil, nil;
	end
	--	return instance, x, y
	local function GetWorldPositionFromAzerothWorldMapPosition(instance, x, y)
		local data = worldMapData[instance]
		if data ~= nil then
			x, y = data[3] - data[1] * x, data[4] - data[2] * y;
			return instance, x, y;
		end
		return nil, nil, nil;
	end
	--	return instance, x, y
	local function GetAzerothWorldMapPositionFromWorldPosition(instance, x, y)
		local data = worldMapData[instance]
		if data ~= nil then
			x, y = (data[3] - x) / data[1], (data[4] - y) / data[2];
			if x <= 1.0 and x >= 0.0 and y <= 1.0 and y >= 0.0 then
				return instance, x, y;
			end
		end
		return nil, nil, nil;
	end

	--	return map, x, y
	local function GetUnitZonePosition(unit)
		-- local y, x, _z, map = UnitPosition(unit);
		local map, x, y = GetUnitPosition(unit);
		if x ~= nil and y ~= nil then
			return GetZonePositionFromWorldPosition(C_Map_GetBestMapForUnit(unit), x, y);
		end
	end
	local function GetPlayerZone()
		return __player_map_id;
	end
	--	return map, x, y
	local function GetPlayerZonePosition()
		-- local y, x, _z, map = UnitPosition('player');
		local map, x, y = GetUnitPosition('player');
		if x ~= nil and y ~= nil then
			return GetZonePositionFromWorldPosition(__player_map_id, x, y);
		end
	end

	local function GetAllMapMetas()
		return mapMeta;
	end
	local function GetMapMeta(map)
		return mapMeta[map];
	end
	local function GetMapParent(map)
		local meta = mapMeta[map];
		if meta ~= nil then
			return meta.parent;
		end
	end
	local function GetMapAdjoined(map)
		local meta = mapMeta[map];
		if meta ~= nil then
			return meta.adjoined;
		end
	end
	local function GetMapChildren(map)
		local meta = mapMeta[map];
		if meta ~= nil then
			return meta.children;
		end
	end
	local function GetMapContinent(map)
		local meta = mapMeta[map];
		if meta ~= nil then
			return meta.continent;
		end
	end

	__core.GetUnitPosition = GetUnitPosition;
	__core.GetZonePositionFromWorldPosition = GetZonePositionFromWorldPosition;
	__core.GetWorldPositionFromZonePosition = GetWorldPositionFromZonePosition;
	__core.GetWorldPositionFromAzerothWorldMapPosition = GetWorldPositionFromAzerothWorldMapPosition;
	__core.GetAzerothWorldMapPositionFromWorldPosition = GetAzerothWorldMapPositionFromWorldPosition;
	__core.GetUnitZonePosition = GetUnitZonePosition;
	__core.GetPlayerZone = GetPlayerZone;
	__core.GetPlayerZonePosition = GetPlayerZonePosition;
	---/run ac=__ala_meta__.quest.core
	---/print ac.GetWorldPositionFromZonePosition(ac.GetPlayerZonePosition())
	---/print UnitPosition('player')
	---/print ac.GetPlayerZonePosition()
	---/print LibStub("HereBeDragons-2.0"):GetPlayerZonePosition()
	---/print C_Map.GetWorldPosFromMapPos(1416, CreateVector2D(0.184, 0.88))
	---/print ac.GetWorldPositionFromZonePosition(1416, 0.184, 0.88)
	---/print ac.GetZonePositionFromWorldPosition(1416,select(2,ac.GetWorldPositionFromZonePosition(1416, 0.184, 0.88)))

	__core.GetAllMapMetas = GetAllMapMetas;
	__core.GetMapMeta = GetMapMeta;
	__core.GetMapParent = GetMapParent;
	__core.GetMapAdjoined = GetMapAdjoined;
	__core.GetMapChildren = GetMapChildren;
	__core.GetMapContinent = GetMapContinent;
	--
	local function PreloadCoordsFunc(coords, wcoords)
		local num_coords = #coords;
		local index = 1;
		while index <= num_coords do
			local coord = coords[index];
			if coord[1] >= 0 or coord[2] >= 0 then
				local instance, x, y = GetWorldPositionFromZonePosition(coord[3], coord[1] * 0.01, coord[2] * 0.01);
				-- local instance, v = C_Map.GetWorldPosFromMapPos(coord[3], CreateVector2D(coord[1], coord[2]));	--	VERY SLOW, 90ms vs 1200ms
				-- coord[5] = x;
				-- coord[6] = y;
				-- coord[7] = instance;
				if x ~= nil and y ~= nil and instance ~= nil then
					local wcoord = { x, y, instance, coord[4], };
					wcoords[index] = wcoord;
					coord[5] = wcoord;
					index = index + 1;
				else
					tremove(coords, index);
					num_coords = num_coords - 1;
				end
			else
				tremove(coords, index);
				num_coords = num_coords - 1;
			end
		end
		local pos = num_coords + 1;
		for index = 1, num_coords do
			local coord = coords[index];
			local wcoord = wcoords[index];
			local map = coord[3];
			local amaps = GetMapAdjoined(map);
			if amaps ~= nil then
				for amap, _ in next, amaps do
					local amap, x, y = GetZonePositionFromWorldPosition(amap, wcoord[1], wcoord[2]);
					if amap ~= nil then
						coords[pos] = { x * 100.0, y * 100.0, amap, coord[4], wcoord, };
						pos = pos + 1;
					end
				end
			end
			local cmaps = GetMapChildren(map);
			if cmaps ~= nil then
				for cmap, _ in next, cmaps do
					local cmap, x, y = GetZonePositionFromWorldPosition(cmap, wcoord[1], wcoord[2]);
					if cmap ~= nil then
						coords[pos] = { x * 100.0, y * 100.0, cmap, coord[4], wcoord, };
						pos = pos + 1;
					end
				end
			end
			-- local pmap = GetMapParent(map);
			-- if pmap ~= nil then
			-- 	local pmap, x, y = GetZonePositionFromWorldPosition(pmap, wcoord[1], wcoord[2]);
			-- 	if pmap ~= nil then
			-- 		coords[pos] = { x * 100.0, y * 100.0, pmap, coord[4], wcoord, };
			-- 		pos = pos + 1;
			-- 	end
			-- end
			-- if SET.show_in_continent then
				local cmap = GetMapContinent(map);
				if cmap ~= nil then
					local cmap, x, y = GetZonePositionFromWorldPosition(cmap, wcoord[1], wcoord[2]);
					if cmap ~= nil then
						coords[pos] = { x * 100.0, y * 100.0, cmap, coord[4], wcoord, };
						pos = pos + 1;
					end
				end
			-- end
		end
	end
	local function PreloadCoords(info)
		local coords = info.coords;
		local wcoords = info.wcoords;
		if coords ~= nil and wcoords == nil then
			wcoords = {  };
			info.wcoords = wcoords;
			PreloadCoordsFunc(coords, wcoords);
		end
		local waypoints = info.waypoints;
		local wwaypoints = info.wwaypoints;
		if waypoints ~= nil and wwaypoints == nil then
			wwaypoints = {  };
			info.wwaypoints = wwaypoints;
			PreloadCoordsFunc(waypoints, wwaypoints);
		end
	end
	__core.PreloadCoords = PreloadCoords;
-->

-->		Texture
	local IMG_PATH = "Interface\\AddOns\\CodexLite\\img\\";

	local IMG_INDEX = {
		IMG_DEF = 1,
		IMG_S_HIGH_LEVEL = 2,
		IMG_S_COMMING = 3,
		IMG_S_LOW_LEVEL = 4,
		IMG_S_REPEATABLE = 5,
		IMG_E_UNCOMPLETED = 6,
		IMG_S_VERY_HARD = 7,
		IMG_S_EASY = 8,
		IMG_S_HARD = 9,
		IMG_S_NORMAL = 10,
		IMG_E_COMPLETED = 11,
	};
	local IMG_PATH_PIN = IMG_PATH .. "PIN";
	local IMG_PATH_AVL = IMG_PATH .. "AVL";
	local IMG_PATH_CPL = IMG_PATH .. "CPL";
	local IMG_LIST = {
		[IMG_INDEX.IMG_DEF] 			= { IMG_PATH_PIN,  nil,  nil,  nil, "ffffffff", 0, 0, },
		[IMG_INDEX.IMG_S_HIGH_LEVEL] 	= { IMG_PATH_AVL, 1.00, 0.10, 0.10, "ffffffff", 1, 1, },
		[IMG_INDEX.IMG_S_COMMING] 		= { IMG_PATH_AVL, 1.00, 0.25, 0.25, "ffffffff", 2, 2, },
		[IMG_INDEX.IMG_S_LOW_LEVEL] 	= { IMG_PATH_AVL, 0.65, 0.65, 0.65, "ffffffff", 3, 3, },
		[IMG_INDEX.IMG_S_REPEATABLE] 	= { IMG_PATH_AVL, 0.25, 0.50, 0.75, "ffffffff", 4, 4, },
		[IMG_INDEX.IMG_E_UNCOMPLETED] 	= { IMG_PATH_CPL, 0.65, 0.65, 0.65, "ffffffff", 5, 5, },
		[IMG_INDEX.IMG_S_VERY_HARD]		= { IMG_PATH_AVL, 1.00, 0.25, 0.00, "ffffffff", 6, 6, },
		[IMG_INDEX.IMG_S_EASY] 			= { IMG_PATH_AVL, 0.25, 0.75, 0.25, "ffffffff", 7, 7, },
		[IMG_INDEX.IMG_S_HARD] 			= { IMG_PATH_AVL, 1.00, 0.60, 0.00, "ffffffff", 8, 8, },
		[IMG_INDEX.IMG_S_NORMAL] 		= { IMG_PATH_AVL, 1.00, 1.00, 0.00, "ffffffff", 9, 9, },
		[IMG_INDEX.IMG_E_COMPLETED] 	= { IMG_PATH_CPL, 1.00, 0.90, 0.00, "ffffffff", 10, 10, },
	};
	for _, texture in next, IMG_LIST do
		if texture[2] ~= nil and texture[3] ~= nil and texture[4] ~= nil then
			texture[5] = format("ff%.2x%.2x%.2x", texture[2] * 255, texture[3] * 255, texture[4] * 255);
		end
	end
	local TIP_IMG_LIST = {  };
	for index, info in next, IMG_LIST do
		if (info[2] ~= nil and info[3] ~= nil and info[4] ~= nil) and (info[2] ~= 1.0 or info[3] ~= 1.0 or info[4] ~= 1.0) then
			TIP_IMG_LIST[index] = format("|T%s:0:0:0:0:1:1:0:1:0:1:%d:%d:%d|t", info[1], info[2] * 255, info[3] * 255, info[4] * 255);
		else
			TIP_IMG_LIST[index] = format("|T%s:0|t", info[1]);
		end
	end
	local function GetQuestStartTexture(info)
		local TEXTURE = IMG_INDEX.IMG_S_NORMAL;
		local min = info.min;
		local diff = min < 0 and 0 or (min - __ns.__player_level);
		if diff > 0 then
			if diff > 1 then
				TEXTURE = IMG_INDEX.IMG_S_HIGH_LEVEL;
			else
				TEXTURE = IMG_INDEX.IMG_S_COMMING;
			end
		else
			local flag = info.flag;
			local exflag = info.exflag;
			if (exflag ~= nil and _bit_band(exflag, 1) ~= 0) or (flag ~= nil and _bit_band(flag, 4096) ~= 0) then
				TEXTURE = IMG_INDEX.IMG_S_REPEATABLE;
			else
				local lvl = info.lvl;
				lvl = lvl >= 0 and lvl or __ns.__player_level;
				if lvl >= SET.quest_lvl_red then
					TEXTURE = IMG_INDEX.IMG_S_VERY_HARD;
				elseif lvl >= SET.quest_lvl_orange then
					TEXTURE = IMG_INDEX.IMG_S_HARD;
				elseif lvl >= SET.quest_lvl_yellow then
					TEXTURE = IMG_INDEX.IMG_S_NORMAL;
				elseif lvl >= SET.quest_lvl_green then
					TEXTURE = IMG_INDEX.IMG_S_EASY;
				else
					TEXTURE = IMG_INDEX.IMG_S_LOW_LEVEL;
				end
			end
		end
		return TEXTURE;
	end
	__core.IMG_INDEX = IMG_INDEX;
	__core.IMG_PATH = IMG_PATH;
	__core.IMG_PATH_PIN = IMG_PATH_PIN;
	__core.IMG_LIST = IMG_LIST;
	__core.TIP_IMG_LIST = TIP_IMG_LIST;
	__core.GetQuestStartTexture = GetQuestStartTexture;
-->

-->		Quest
	local QuestTagCache = {
		[373] = 81,
		[4146] = 81,
		[5342] = 0,
		[5344] = 0,
		[6846] = 41,
		[6901] = 41,
		[7001] = 41,
		[7027] = 41,
		[7161] = 41,
		[7162] = 41,
		[7841] = 0,
		[7842] = 0,
		[7843] = 0,
		[8122] = 41,
		[8386] = 41,
		[8404] = 41,
		[8405] = 41,
		[8406] = 41,
		[8407] = 41,
		[8408] = 41,
	};
	function __ns.GetQuestTagInfo(quest)
		local tag = QuestTagCache[quest];
		if tag == nil then
			tag = GetQuestTagInfo(quest);
			if tag ~= nil then
				QuestTagCache[quest] = tag;
			end
		end
		return tag;
	end
-->

-->		Misc
	local UnitHelpFac = { AH = 1, };
	if _PLAYER_FACTIONGROUP == "Alliance" then
		UnitHelpFac.A = 1;
	else
		UnitHelpFac.H = 1;
	end
	__core.UnitHelpFac = UnitHelpFac;
	local date = date;
	local function _log_(...)
		if __ns.__is_dev then
			_F_CorePrint(date('|cff00ff00%H:%M:%S|r cl'), ...);
		end
	end
	__ns._log_ = _log_;
-->

-->		performance
	local __PERFORMANCE_LOG_TAGS = {	--	[tag] = check_bigger_than_10.0
		[''] = false,
		['*'] = false,
		['#'] = false,
		['@'] = false,
		['$'] = false,
		['^'] = false,
		[':'] = false,
		['-'] = false,
		['+'] = false,
		--
		['module.init'] = false,
			['module.init.init'] = true,
				['module.init.init.patch'] = true,
				['module.init.init.extra_db'] = true,
					['module.init.init.extra_db.faction'] = true,
					['module.init.init.extra_db.item2quest'] = true,
					['module.init.init.extra_db.del_unused'] = true,
				['module.init.init.setting'] = true,
				['module.init.init.core'] = true,
				['module.init.init.agent'] = true,
				['module.init.init.map'] = true,
				['module.init.init.comm'] = true,
				['module.init.init.util'] = true,
		['module.db-extra'] = false,
		['module.patch'] = false,
		['module.core'] = false,
			['module.core.UpdateQuests'] = false,
			['module.core.|cffff0000UpdateQuests|r'] = false,
			['module.core.UpdateQuestGivers'] = true,
		['module.map'] = false,
			['module.map.Minimap_DrawNodesMap'] = true,
			['module.map.OnMapChanged'] = true,
			['module.map.OnCanvasScaleChanged'] = true,
		['module.util'] = false,
	};
	__ns.__performance_start = _F_devDebugProfileStart;
	function __ns.__performance_log_tick(tag, ex1, ex2, ex3)
		local val = __PERFORMANCE_LOG_TAGS[tag];
		if val ~= nil then
			local cost = __ns._F_devDebugProfileTick(tag);
			if val == false or cost >= 10.0 then
				cost = cost - cost % 0.0001;
				_F_CorePrint(date('|cff00ff00%H:%M:%S|r cl'), tag, cost, ex1, ex2, ex3);
			end
		end
	end
	function __ns.__opt_log(tag, ...)
		_F_CorePrint(date('|cff00ff00%H:%M:%S|r cl'), tag, ...);
	end
-->

-->		INITIALIZE
	local function init()
		--[=[dev]=]	if __ns.__is_dev then __ns.__performance_start('module.init.init'); end
		--[=[dev]=]	if __ns.__is_dev then __ns.__performance_start('module.init.init.patch'); end
		__ns.apply_patch();
		--[=[dev]=]	if __ns.__is_dev then __ns.__performance_log_tick('module.init.init.patch'); end
		--[=[dev]=]	if __ns.__is_dev then __ns.__performance_start('module.init.init.extra_db'); end
		__ns.load_extra_db();
		--[=[dev]=]	if __ns.__is_dev then __ns.__performance_log_tick('module.init.init.extra_db'); end
		--[=[dev]=]	if __ns.__is_dev then __ns.__performance_start('module.init.init.setting'); end
		__ns.setting_setup();
		--[=[dev]=]	if __ns.__is_dev then __ns.__performance_log_tick('module.init.init.setting'); end
		SET = __ns.__setting;
		--[=[dev]=]	if __ns.__is_dev then __ns.__performance_start('module.init.init.agent'); end
		__ns.InitMapAgent();
		--[=[dev]=]	if __ns.__is_dev then __ns.__performance_log_tick('module.init.init.agent'); end
		--[=[dev]=]	if __ns.__is_dev then __ns.__performance_start('module.init.init.map'); end
		__ns.map_setup();
		--[=[dev]=]	if __ns.__is_dev then __ns.__performance_log_tick('module.init.init.map'); end
		--[=[dev]=]	if __ns.__is_dev then __ns.__performance_start('module.init.init.comm'); end
		__ns.comm_setup();
		--[=[dev]=]	if __ns.__is_dev then __ns.__performance_log_tick('module.init.init.comm'); end
		--[=[dev]=]	if __ns.__is_dev then __ns.__performance_start('module.init.init.core'); end
		__ns.core_setup();
		--[=[dev]=]	if __ns.__is_dev then __ns.__performance_log_tick('module.init.init.core'); end
		--[=[dev]=]	if __ns.__is_dev then __ns.__performance_start('module.init.init.util'); end
		__ns.util_setup();
		--[=[dev]=]	if __ns.__is_dev then __ns.__performance_log_tick('module.init.init.util'); end
		--[=[dev]=]	if __ns.__is_dev then __ns.__performance_log_tick('module.init.init'); end

		__ns:MergeGlobal(__ns.__svar);
		if __ala_meta__.initpublic then __ala_meta__.initpublic(); end
	end
	function __ns.PLAYER_ENTERING_WORLD()
		_EventHandler:UnregEvent("PLAYER_ENTERING_WORLD");
		__ns.After(0.1, init);
	end
	function __ns.LOADING_SCREEN_ENABLED()
		_EventHandler:UnregEvent("LOADING_SCREEN_ENABLED");
	end
	function __ns.LOADING_SCREEN_DISABLED()
		_EventHandler:UnregEvent("LOADING_SCREEN_DISABLED");
		__ns.After(0.1, init);
	end
	-- _EventHandler:RegEvent("PLAYER_ENTERING_WORLD");
	-- _EventHandler:RegEvent("LOADING_SCREEN_ENABLED");
	_EventHandler:RegEvent("LOADING_SCREEN_DISABLED");
-->

--[=[dev]=]	if __ns.__is_dev then __ns.__performance_log_tick('module.init'); end
