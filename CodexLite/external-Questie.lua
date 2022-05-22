--[[--
	Read communication of Questie
	by ALA @ 163UI/网易有爱, http://wowui.w.163.com/163ui/
	CREDIT shagu/pfQuest(MIT LICENSE) @ https://github.com/shagu
--]]--
----------------------------------------------------------------------------------------------------
local __addon, __ns = ...;

local _G = _G;
local _ = nil;
----------------------------------------------------------------------------------------------------
--[=[dev]=]	if __ns.__is_dev then __ns._F_devDebugProfileStart('module.external-Questie'); end

-->		variables
	local GetTime = GetTime;
	local setmetatable = setmetatable;
	local next = next;
	local table_concat = table.concat;
	local strbyte, strchar, strlen, strsub, strfind = string.byte, string.char, string.len, string.sub, string.find;
	local bit_band, bit_lshift, bit_rshift = bit.band, bit.lshift, bit.rshift;
	local floor, frexpm ldexp = math.floor, math.frexp, math.ldexp;
	local tonumber = tonumber;
	local huge = math.huge;
	local RegisterAddonMessagePrefix = RegisterAddonMessagePrefix or C_ChatInfo.RegisterAddonMessagePrefix;
	local IsAddonMessagePrefixRegistered = IsAddonMessagePrefixRegistered or C_ChatInfo.IsAddonMessagePrefixRegistered;
	local GetRegisteredAddonMessagePrefixes = GetRegisteredAddonMessagePrefixes or C_ChatInfo.GetRegisteredAddonMessagePrefixes;
	local SendAddonMessage = SendAddonMessage or C_ChatInfo.SendAddonMessage;
	local SendAddonMessageLogged = SendAddonMessageLogged or C_ChatInfo.SendAddonMessageLogged;

	local __core = __ns.core;
	local __loc = __ns.L;
	local __loc_quest = __loc.quest;
	local __loc_unit = __loc.unit;
	local __loc_item = __loc.item;
	local __loc_object = __loc.object;
	local __loc_profession = __loc.profession;

	local _log_ = __ns._log_;
-->
if __ns.__is_dev then
	__ns:BuildEnv("external-Questie");
end
-->		MAIN
	--
	local ExternalQuestie = {  };
	--		Decompress
		--
		local _HT = {  };
		local function _Hash(value)
			local len = strlen(value);
			if len <= 0 then
				return 0
			end
			local h = 5381;
			for i = 1, len do
				h = bit_band((31 * h + strbyte(value, i)), 4294967295);
			end
			return h;
		end
		local function _AddHash(value)
			local hash = _Hash(value);
			_HT[hash] = value;
			_HT[value] = hash;
		end
		--
		local function floatBitsToInt(n)
			local sign = 0
			if n < 0.0 then
				sign = 0x80
				n = -n
			end
			local mant, expo = frexp(n)
			if mant ~= mant then
				-- return _pack(0xFF, 0x88, 0x00, 0x00) -- nan
				return 0xFF880000;
			elseif mant == huge or expo > 0x80 then
				if sign == 0 then
					-- return _pack(0x7F, 0x80, 0x00, 0x00) -- inf
					return 0x7F800000;
				else
					-- return _pack(0xFF, 0x80, 0x00, 0x00) -- -inf
					return 0xFF800000;
				end
			elseif (mant == 0.0 and expo == 0) or expo < -0x7E then
				-- return _pack(sign, 0x00, 0x00, 0x00)-- zero
				return bit_lshift(sign, 24);
			else
				expo = expo + 0x7E
				mant = floor((mant * 2.0 - 1.0) * ldexp(0.5, 24))
				return 
					bit_lshift(sign + floor(expo / 0x2), 24)
					+ bit_lshift((expo % 0x2) * 0x80 + floor(mant / 0x10000), 16)
					+ bit_lshift(floor(mant / 0x100) % 0x100, 8)
					+ mant % 0x100;
			end
		end
		local function intBitsToFloat(int)
			local b1 = bit_rshift(val, 24) % 256;
			local b2 = bit_rshift(val, 16) % 256;
			local b3 = bit_rshift(val, 8) % 256;
			local b4 = val % 256;
			local sign = b1 > 0x7F
			local expo = (b1 % 0x80) * 0x2 + floor(b2 / 0x80)
			local mant = ((b2 % 0x80) * 0x100 + b3) * 0x100 + b4
			if sign then
				sign = -1
			else
				sign = 1
			end
			local n
			if mant == 0 and expo == 0 then
				n = sign * 0.0
			elseif expo == 0xFF then
				if mant == 0 then
					n = sign * huge
				else
					n = 0.0 / 0.0
				end
			else
				n = sign * ldexp(1.0 + mant / 0x800000, expo - 0x7F)
			end
			return n
		end
		--
		local _ReadByte, _ReadShort, _ReadInt, _ReadLong, _ReadTinyString, _ReadShortString;
		local _ReadObject, _ReadTable, _ReadArray;
		--
		function _ReadByte(buffer)
			local val = buffer[buffer.ptr];
			buffer.ptr = buffer.ptr + 1;
			if val == 238 then
				return 0;
			elseif val == 237 then
				val = buffer[buffer.ptr];
				buffer.ptr = buffer.ptr + 1;
				if val == 1 then
					return 237;
				elseif val == 2 then
					return 238;
				end
			else
				return val;
			end
		end
		function _ReadShort(buffer)
			return bit_lshift(_ReadByte(buffer), 8) + _ReadByte(buffer);
		end
		function _ReadInt(buffer)
			return bit_lshift(_ReadByte(buffer), 24) + bit_lshift(_ReadByte(buffer), 16) + bit_lshift(_ReadByte(buffer), 8) + _ReadByte(buffer);
		end
		function _ReadLong(buffer)
			return bit_lshift(_ReadByte(buffer), 56) + bit_lshift(_ReadByte(buffer), 48) + bit_lshift(_ReadByte(buffer), 40) + bit_lshift(_ReadByte(buffer), 32)
				+ bit_lshift(_ReadByte(buffer), 24) + bit_lshift(_ReadByte(buffer), 16) + bit_lshift(_ReadByte(buffer), 8) + _ReadByte(buffer);
		end
		function _ReadTinyString(buffer)
			local len = _ReadByte(buffer);
			local str = {  };
			for i = 1, len do
				str[i] = strchar(_ReadByte(buffer));
			end
			return table_concat(str);
		end
		function _ReadShortString(buffer)
			local len = _ReadShort(buffer);
			local str = {  };
			for i = 1, len do
				str[i] = strchar(_ReadByte(buffer));
			end
			return table_concat(str);
		end
		--
		local _MethodTable = {
			[1] = function(buff)
				return nil;
			end,
			[2] = _ReadInt,
			[3] = function(buffer)
				return -_ReadInt(buffer);
			end,
			[4] = _ReadLong,
			[5] = function(buffer)
				return -_ReadLong(buffer);
			end,
			[6] = function(buffer)
				return intBitsToFloat(_ReadInt(buffer));
			end,

			[7] = _ReadTinyString,
			[8] = _ReadShortString,
			[9] = function(buffer)
				return _HT[_ReadInt(buffer)];
			end,

			[10] = function(buffer)
				return _ReadTable(buffer, _ReadByte(buffer));
			end,
			[11] = function(buffer)
				return _ReadTable(buffer, _ReadShort(buffer));
			end,

			[12] = _ReadByte,
			[13] = function(buffer)
				return -_ReadByte(buffer);
			end,
			[14] = _ReadShort,
			[15] = function(buffer)
				return -_ReadShort(buffer);
			end,

			[16] = function(buffer)
				return false;
			end,
			[17] = function(buffer)
				return true;
			end,

			[18] = function(buffer)
				return nil;
			end,
			[19] = function(buffer)
				return nil;
			end,

			[20] = function(buffer)
				return _ReadArray(buffer, _ReadByte(buffer));
			end,
			[21] = function(buffer)
				return _ReadArray(buffer, _ReadShort(buffer));
			end,
			[22] = function(buffer)
				return _ReadArray(buffer, _ReadInt(buffer));
			end,

			--up to 31

		};
		function _ReadObject(buffer)
			local method = _ReadByte(buffer);
				-- print('byte', method, buffer.ptr);
			if method > 31 then
				return method - 32;
			else
				return _MethodTable[method](buffer);
			end
		end
		function _ReadTable(buffer, num)
			local tbl = {  };
			local key, val;
			buffer.tbl = buffer.tbl or tbl;
			for index = 1, num do
				key = _ReadObject(buffer);
				val = _ReadObject(buffer);
				tbl[key] = val;
				-- print(key, val, buffer.ptr);
			end
			return tbl;
		end
		function _ReadArray(buffer, num)
			local tbl = {  };
			local val;
			for index = 1, num do
				val = _ReadObject(buffer);
				tbl[index] = val;
				-- print(index, val, buffer.ptr);
			end
			return tbl;
		end
		--
	--
	--C_ChatInfo.SendAddonMessage("questie", '\33\10\3\7\3\118\101\114\7\5\54\46\56\46\49\7\6\109\115\103\86\101\114\37\7\5\109\115\103\73\100\43', 'WHISPER', '兔灰灰');
	--	'\33\10\3\7\3\118\101\114\7\5\54\46\56\46\49\7\6\109\115\103\86\101\114\37\7\5\109\115\103\73\100\43'
	--	'\33\10\3\7\3 v   e   r  \7\5 6  .  8  .  1 \7\6 m   s   g   V  e   r  \37\7\5 m   s   g   I  d  \43'
	--	'\33\10\3\7\3' .. 'ver' .. '\7\5' .. '6.8.1' .. '\7\6' .. 'msgVer' .. '\37' .. '\7\5' .. 'msgId' .. '\43'
	local COLON = strfind(_G.QUEST_MONSTERS_KILLED, "：") and "：" or ": ";
	local TypeList = {
		m = 'monster',
		i = 'item',
		o = 'object',
		e = 'event',
	};
	local LocList = {
		m = __loc_unit,
		i = __loc_item,
		o = __loc_object,
		e = setmetatable({  }, { __index = function() return "event"; end, }),
	};
	local _Inited, _META, _OnCommInit, _OnCommQuestAdd, _OnCommQuestDel, _OnCommQuestLine;
	local function AddQuest(name, QuestInfo)
		local quest = QuestInfo.id;
		if quest == nil then
			return;
		end
			-- print("Quest: ", quest);
		local objectives = QuestInfo.objectives;
		if objectives ~= nil then
			local num_lines = #objectives;
			local completed = 1;
			for line = 1, num_lines do
				local obj = objectives[line];
				if obj.ful ~= nil and obj.req ~= nil and obj.ful < obj.req then
					completed = 0;
				end
			end
			local title = __loc_quest[quest];
			if title ~= nil then
				title = title[1];
			end
			title = title or ("quest:" .. quest);
			_OnCommQuestAdd(name, quest, completed, num_lines, title);
			_log_('|cff00ff7fQ-Q|r|cff00ff00Add|r', name, quest, completed, num_lines, title);
			for line = 1, num_lines do
				local obj = objectives[line];
				local type = obj.typ;
				local id = obj.id;
				local cur = obj.ful;
				local req = obj.req;
					-- print("  ", type, id, cur, req);
				local text = LocList[type];
				if text ~= nil and id ~= nil then
					text = text[id] or type;
				else
					text = type;
				end
				if req ~= nil and cur ~= nil and req > 0 then
					text = text .. COLON .. cur .. "/" .. req;
				end
				_OnCommQuestLine(name, quest, line, TypeList[type], id, text, cur == nil or req == nil or cur >= req);
				-- _log_('|cff00ff7fQ-Q|r|cff00ffffLine|r', name, quest, line, TypeList[type], id, cur == nil or req == nil or cur >= req, text);
			end
		else
			local title = __loc_quest[quest];
			if title ~= nil then
				title = title[1];
			end
			title = title or ("quest:" .. quest);
			_OnCommQuestAdd(name, quest, 1, 0, title);
			_log_('|cff00ff7fQ-Q|r|cff00ff00Add|r', name, quest, 1, 0, title);
		end
	end
	local function DelQuest(name, Info)
		-- print("DelQuest", Info.id);
		_OnCommQuestDel(name, Info.id);
		_log_('|cff00ff7fQ-Q|r|cffff0000Del|r', name, Info.id);
	end
	local function PullSingle(name, ver, msgVer)
		-- local msg = '\33\10\3\7\3\118\101\114\7\5\54\46\56\46\49\7\6\109\115\103\86\101\114\37\7\5\109\115\103\73\100\43';
		local msg = '\33\10\3\7\3' .. 'ver' .. '\7' .. strchar(strlen(ver)) .. ver .. '\7\6' .. 'msgVer' .. strchar(32 + msgVer) .. '\7\5' .. 'msgId' .. '\43';
		__ns.ScheduleMessage("questie", msg, 'WHISPER', name);
	end
	local function OnComm(msg, name, channel)
		if _META[name] ~= nil then
			local buffer = { ptr = 1, len = strlen(msg), strbyte(msg, 1, -1) };
				-- local len = strlen(msg);
				-- print(len);
				-- for i = 1, len / 16 do
				-- 	print(strbyte(msg, i * 16 - 15, i * 16));
				-- end
			-- do return end
			if channel ~= "YELL" then
				ExternalQuestie.__prev = buffer;
				local val = _ReadTable(buffer, 1);
				if val ~= nil then
					-- _log_('|cff00ff7fOnCommQuestie|r', val, name);
					val = val[1];
					if val ~= nil then
						local msgId = val.msgId;
						if msgId == 1 then
							local QuestInfo = val.quest;
							if QuestInfo ~= nil then
								AddQuest(name, QuestInfo);
							end
						elseif msgId == 2 then
							DelQuest(name, val);
						elseif  msgId == 11 then
							ExternalQuestie._PullSingle(name);
						elseif msgId == 12 then
							_Inited[name] = GetTime();
							local data = val[1];
							local NumQuest = data[1];
							local pos = 2;
								-- print("NumQuest", data[1]);
							for QuestIndex = 1, NumQuest do
								local quest = data[pos];
								local num = data[pos + 1] or 0;
								pos = pos + 2;
								local QuestInfo = {
									id = quest,
									objectives = num > 0 and {  } or nil,
								};
								local index = 0;
								while index < num and data[pos + 1] ~= nil do
									index = index + 1;
									QuestInfo.objectives[index] = {
										typ = strchar(data[pos + 1]),
										id = data[pos],
										ful = data[pos + 2],
										req = data[pos + 3],
									};
									pos = pos + 4;
								end
								AddQuest(name, QuestInfo);
							end
						end
					end
				end
			end
		end
	end
	local CommCache = {  };
	local function OnCommFirst(msg, name, channel)
		CommCache[name] = CommCache[name] or {  };
		CommCache[name][channel] = msg;
	end
	local function OnCommNext(msg, name, channel)
		local cache = CommCache[name];
		if cache[channel] ~= nil then
			cache[channel] = cache[channel] .. msg;
		end
	end
	local function OnCommLast(msg, name, channel)
		local cache = CommCache[name];
		if cache[channel] ~= nil then
			OnComm(cache[channel] .. msg, name, channel)
		end
	end
	--
	function ExternalQuestie._DelUnit(name)
		_Inited[name] = nil;
	end
	function ExternalQuestie._PullSingle(name)
		if _Inited[name] == nil then
			PullSingle(name, '6.8.1', 5);
		end
	end
	function ExternalQuestie._OnComm(msg, name, channel)
		local cc = strbyte(msg, 1, 1);
		if cc >= 1 and cc <= 9 then
			if cc == 1 then			--	FIRST
				OnCommFirst(strsub(msg, 2), name, channel);
			elseif cc == 2 then		--	NEXT
				OnCommNext(strsub(msg, 2), name, channel);
			elseif cc == 3 then		--	LAST
				OnCommLast(strsub(msg, 2), name, channel);
			elseif cc == 4 then		--	ESCAPE
				OnComm(strsub(msg, 2), name, channel);
			end
		else
			OnComm(msg, name, channel);
		end
	end
	function ExternalQuestie._Init(Inited, META, OnCommInit, OnCommQuestAdd, OnCommQuestDel, OnCommQuestLine)
		if RegisterAddonMessagePrefix("questie") then
			_Inited = Inited;
			_META = META;
			_OnCommInit = OnCommInit;
			_OnCommQuestAdd = OnCommQuestAdd;
			_OnCommQuestDel = OnCommQuestDel;
			_OnCommQuestLine = OnCommQuestLine;
		end
	end
	__ns.ExternalQuestie = ExternalQuestie;
-->

--[=[dev]=]	if __ns.__is_dev then __ns.__performance_log_tick('module.external-Questie'); end
