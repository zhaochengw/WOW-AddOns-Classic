--[=[
	by ALA
--]=]

local __version = 240715.0;

local _G = _G;
_G.__ala_meta__ = _G.__ala_meta__ or {  };
local __ala_meta__ = _G.__ala_meta__;

local Private = {  };
-->			versioncheck
	local __ctranslib = __ala_meta__.__ctranslib;
	if __ctranslib ~= nil and __ctranslib.__minor >= __version then
		return;
	elseif __ctranslib == nil then
		__ctranslib = {  };
		__ala_meta__.__ctranslib = __ctranslib;
	else
		if __ctranslib.Halt ~= nil then
			Private = __ctranslib:Halt() or Private;
		end
	end
	__ctranslib.__minor = __version;
-->


local tostring = tostring;
local next = next;
local strlen, strbyte, strchar, strsplit, strsub = string.len, string.byte, string.char, string.split, string.sub;
local bitand = bit.band;
local CreateFrame = CreateFrame;
local Ambiguate  = Ambiguate;
local RegisterAddonMessagePrefix = C_ChatInfo ~= nil and C_ChatInfo.RegisterAddonMessagePrefix or RegisterAddonMessagePrefix;
local IsAddonMessagePrefixRegistered = C_ChatInfo ~= nil and C_ChatInfo.IsAddonMessagePrefixRegistered or IsAddonMessagePrefixRegistered;
local GetRegisteredAddonMessagePrefixes = C_ChatInfo ~= nil and C_ChatInfo.GetRegisteredAddonMessagePrefixes or GetRegisteredAddonMessagePrefixes;
local SendAddonMessage = C_ChatInfo ~= nil and C_ChatInfo.SendAddonMessage or SendAddonMessage;
local _G = _G;

local SELFGUID = UnitGUID('player');
local DELIMITER = "\255";
local COMM_PREFIX = "CTRANS";
local ValidChatType = {  };
local ValidChatEvent = {
	["CHAT_MSG_WHISPER"]				= "WHISPER",
	["CHAT_MSG_GUILD"]					= "GUILD",
	["CHAT_MSG_PARTY"]					= "PARTY",
	["CHAT_MSG_PARTY_LEADER"]			= "PARTY",
	["CHAT_MSG_RAID"]					= "RAID",
	["CHAT_MSG_RAID_LEADER"]			= "RAID",
	["CHAT_MSG_RAID_WARNING"]			= "RAID_WARNING",
	["CHAT_MSG_INSTANCE_CHAT"]			= "INSTANCE_CHAT",
	["CHAT_MSG_INSTANCE_CHAT_LEADER"]	= "INSTANCE_CHAT",
	-- ["CHAT_MSG_BN_WHISPER"]				= "BN_WHISPER",
};
local CheckDelay = 0.5;
local CacheExpiration = max(CheckDelay * 2, 4.0);
--	[ctype][GUID][msg] = time
local _TChatMsgCache = {  };
--	[ctype][GUID][msgid] = { time, msg, splitted, }
local _TAddOnMsgCache = {  };
local _TWhisperCache = {  };
local _TGUIDCache = { [SELFGUID] = UnitName('player'), };

Private.Print = print;
function Private.Debug(...)
	Private.Print(">>", ...);
end
Private.GetTime = GetTime;
Private.After = C_Timer.After;

Private._NumDistributors = Private._NumDistributors or 0;
Private._CommDistributor = Private._CommDistributor or {  };
function __ctranslib.RegisterCommmDistributor(Distributor, Version)
	if Private._CommDistributor[Distributor] == nil then
		Private._NumDistributors = Private._NumDistributors + 1;
		Private._CommDistributor[Private._NumDistributors] = Distributor;
		Private._CommDistributor[Distributor] = Version or -1;
	end
end


local msgid = 1;
function Private.SendComm(msg, ctype, target, r1, r2, r3, r4)
	if ctype == "WHISPER" then
		_TWhisperCache[tostring(msgid)] = { Private.GetTime(), msg, };
	end
	if ctype == "RAID_WARNING" then
		ctype = "RAID";
	end
	local header = DELIMITER .. SELFGUID ..
					DELIMITER .. msgid ..
					DELIMITER .. (r1 or "") ..
					DELIMITER .. (r2 or "") ..
					DELIMITER .. (r3 or "") ..
					DELIMITER .. (r4 or "") ..
					DELIMITER;
	msgid = msgid + 1;
	if msgid > 9999 then
		msgid = 1;
	end
	local hdrlen = strlen(header) + 1;
	local ttllen = #msg;
	if ttllen + hdrlen <= 255 then
		SendAddonMessage(COMM_PREFIX, "\254" .. header .. msg, ctype, target);
	else
		local blklen = 255 - hdrlen;
		local num = ceil(ttllen / blklen);
		for i = 0, num - 1 do
			SendAddonMessage(COMM_PREFIX, strchar(num - i) .. header .. strsub(msg, i * blklen + 1, i * blklen + blklen), ctype, target);
		end
	end
end
function Private.OnEvent(Driver, event, ...)
	if event == "CHAT_MSG_ADDON" and ... == COMM_PREFIX then
		local prefix, msg, ctype, sender, target, zoneChannelID, localID, name, instanceID = ...;
		local idx, GUID, msgid, r1, r2, r3, r4, part = strsplit(DELIMITER, msg);
		if GUID ~= nil and _TGUIDCache[GUID] == nil then
			_TGUIDCache[GUID] = Ambiguate(sender, "none");
			if _TGUIDCache[GUID] == "" then
				_TGUIDCache[GUID] = nil;
			end
		end
		if r1 ~= "" then
			r1 = strbyte(r1);
			if bitand(r1, 1) == 1 then
				local name = _TGUIDCache[GUID];
				local cache = _TWhisperCache[part];
				if cache ~= nil then
					for index = 1, Private._NumDistributors do
						local proc = Private._CommDistributor[index].OnDelayCheckFailure;
						if proc ~= nil then
							pcall(proc, "WHISPER_INFORM", GUID, name, cache[2]);
						end
					end
				end
				return;
			end
		end
		--
		_TAddOnMsgCache[ctype][GUID] = _TAddOnMsgCache[ctype][GUID] or {  };
		local cache = _TAddOnMsgCache[ctype][GUID];
		idx = strbyte(idx);
		-- Private.Debug(idx, GUID, msgid, "reserved", part);
		if idx == 254 then	--	single message
			cache[msgid] = { Private.GetTime(), part, };
			-- Private.Debug("SAMSG", "\n[1] =", idx, "\n[2] =", GUID, "\n[3] =", msgid, "\n[4] =", part);
			for index = 1, Private._NumDistributors do
				local proc = Private._CommDistributor[index].OnComm;
				if proc ~= nil then
					pcall(proc, ctype, GUID, _TGUIDCache[GUID], part);
				end
			end
		else	--	splitted message
			-- Private.Debug("MAMSG", "\n[1] =", idx, "\n[2] =", GUID, "\n[3] =", msgid, "\n[4] =", part);
			local dst = cache[msgid];
			if dst == nil then
				cache[msgid] = { nil, { [idx] = part, }, idx, };
			elseif dst[3] ~= nil then
				dst[2][idx] = part;
				if idx > dst[3] then
					dst[3] = idx;
				end
				for i = 1, dst[3] do
					if dst[2][i] == nil then
						return;
					end
				end
				part = dst[2][1];
				for i = 2, dst[3] do
					part = dst[2][i] .. part;
				end
				dst[1] = Private.GetTime();
				dst[2] = part;
				dst[3] = nil;
				-- Private.Debug("MDONE", "\n[1] =", idx, "\n[2] =", GUID, "\n[3] =", msgid, "\n[4] =", part);
				for index = 1, Private._NumDistributors do
					local proc = Private._CommDistributor[index].OnComm;
					if proc ~= nil then
						pcall(proc, ctype, GUID, _TGUIDCache[GUID], part);
					end
				end
			end
		end
	-- elseif event == BN_CHAT_MSG_ADDON then
	-- 	local prefix, msg, ctype, senderID = ...;
	else
		local ctype = ValidChatEvent[event];
		if ctype ~= nil then
			local msg, sender, lang, channelName, player2, Flags, zoneChannelID, channelIndex, channelBaseName, langID, lineID, GUID, bnSenderID = ...;
			if GUID ~= nil and _TGUIDCache[GUID] == nil then
				_TGUIDCache[GUID] = Ambiguate(sender, "none");
				if _TGUIDCache[GUID] == "" then
					_TGUIDCache[GUID] = nil;
				end
			end
			_TChatMsgCache[ctype][GUID] = _TChatMsgCache[ctype][GUID] or {  };
			local cache = _TChatMsgCache[ctype][GUID];
			cache[msg] = Private.GetTime();
		end
	end
end
function Private.PeriodicProc()
	if Private.IsDead then
		return;
	end
	Private.After(0.1, Private.PeriodicProc);
	local now = Private.GetTime();
	for ctype, AC in next, _TAddOnMsgCache do
		local CC = _TChatMsgCache[ctype];
		for GUID, ac in next, AC do
			local cc = CC[GUID];
			for msgid, cache in next, ac do
				if cache[3] == nil and now - cache[1] >= CheckDelay then
					ac[msgid] = nil;
					if cc == nil or cc[cache[2]] == nil then
						local name = _TGUIDCache[GUID];
						if ctype == "WHISPER" then
							Private.SendComm(msgid, "WHISPER", name, "\001");
						end
						for index = 1, Private._NumDistributors do
							local proc = Private._CommDistributor[index].OnDelayCheckFailure;
							if proc ~= nil then
								pcall(proc, ctype, GUID, name, cache[2]);
							end
						end
					else
						local name = _TGUIDCache[GUID];
						for index = 1, Private._NumDistributors do
							local proc = Private._CommDistributor[index].OnDelayCheckSuccess;
							if proc ~= nil then
								pcall(proc, ctype, GUID, name, cache[2]);
							end
						end
					end
				end
			end
		end
	end
	for ctype, CC in next, _TChatMsgCache do
		for GUID, cc in next, CC do
			for msg, when in next, cc do
				if now - when >= CacheExpiration then
					cc[msg] = nil;
				end
			end
		end
	end
	for msgid, cache in next, _TWhisperCache do
		if now - cache[1] >= CacheExpiration then
			_TWhisperCache[msgid] = nil;
		end
	end
end
--	only send addon msg when player sends chat message. so if wow got kicked offline, it's player's fault.
--	因时效性和正常玩家发送消息的频率，不限制通讯频率
--	单次发送以 "\254" 开头
--	拆分发送以 "\00x" 开头，倒序
--	\00x\255GUID\255magic\255reserved8\255part
function Private.OnSendChatMessage(msg, ctype, languageID, target)
	if Private.IsDead then
		return;
	end
	if ValidChatType[ctype] ~= nil then
		Private.SendComm(msg, ctype, target);
	end
end

local _Driver = CreateFrame('FRAME');
_Driver:RegisterEvent("PLAYER_LOGIN");
_Driver:SetScript("OnEvent", function(self, event, param)
	self:UnregisterEvent("PLAYER_LOGIN");
	if IsAddonMessagePrefixRegistered(COMM_PREFIX) or RegisterAddonMessagePrefix(COMM_PREFIX) then
		self:RegisterEvent("CHAT_MSG_ADDON");
		local encode = 1;
		for event, ctype in next, ValidChatEvent do
			self:RegisterEvent(event);
			ValidChatType[ctype] = true;
			encode = encode + 1;
			_TChatMsgCache[ctype] = { [SELFGUID] = {  }, };
			_TAddOnMsgCache[ctype] = { [SELFGUID] = {  }, };
		end
		self:SetScript("OnEvent", Private.OnEvent);
		hooksecurefunc("SendChatMessage", Private.OnSendChatMessage);
		Private.After(0.1, Private.PeriodicProc);
	end
end);

function __ctranslib:Halt()
	_Driver:UnregisterAllEvents();
	self.Dead = true;
	return Private;
end

-- __ala_meta__.__ctranslib.Private = Private;
-- __ctranslib.Private = Private;
-- Private._TChatMsgCache = _TChatMsgCache;
-- Private._TAddOnMsgCache = _TAddOnMsgCache;
-- Private._TWhisperCache = _TWhisperCache;
