--[[--
	by ALA @ 163UI
--]]--

local __addon__, __namespace__ = ...;
local __db__ = __namespace__.__db__;

-->		upvalue
	local tonumber = tonumber;
	local rawget = rawget;
	local setmetatable = setmetatable;
	local print = print;

	local strupper = string.upper;
	local strsplit = string.split;
	local strsub = string.sub;
	local strfind = string.find;
	local format = string.format;
	local tinsert = table.insert;
	local wipe = table.wipe;

	local GetRealmName = GetRealmName;
	local UnitGUID = UnitGUID;
	local UnitName = UnitName;
	local CreateFrame = CreateFrame;
	local IsInGuild = IsInGuild;
	local GetPlayerInfoByGUID = GetPlayerInfoByGUID;
	local RAID_CLASS_COLORS = RAID_CLASS_COLORS;
	local GetServerTime = GetServerTime;
	local C_Timer_NewTicker = C_Timer.NewTicker;

	local RegisterAddonMessagePrefix = RegisterAddonMessagePrefix or C_ChatInfo.RegisterAddonMessagePrefix;
	local IsAddonMessagePrefixRegistered = IsAddonMessagePrefixRegistered or C_ChatInfo.IsAddonMessagePrefixRegistered;
	local GetRegisteredAddonMessagePrefixes = GetRegisteredAddonMessagePrefixes or C_ChatInfo.GetRegisteredAddonMessagePrefixes;
	local SendAddonMessage = SendAddonMessage or C_ChatInfo.SendAddonMessage;
	local SendAddonMessageLogged = SendAddonMessageLogged or C_ChatInfo.SendAddonMessageLogged;

	local _G = _G;
-->


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
local PLAYER_REALM_NAME = GetRealmName();
local PLAYER_GUID = UnitGUID('player');
local PLAYER_NAME = UnitName('player');

local _noop_, _log_, _error_ = __namespace__._noop_, __namespace__._log_, __namespace__._error_;


local AVAR, VAR, CMM = nil, nil, nil, nil, nil;


local F = CreateFrame('FRAME');
F:SetScript("OnEvent", function(self, event, ...)
	return self[event](...);
end);


-->		****************
__namespace__:BuildEnv("communication");
-->		****************


local T_QueuedMessageGuild = {  };
local T_QueuedMessageWhisper = {  };

local __index = function(t1, k1)
	local temp1 = {  };
	t[k1] = temp1;
	return temp1;
end
local __call = function(t1, k1)
	local temp1 = rawget(t1, k1);
	if temp1 then
		wipe(temp1);
	else
		temp1 = t1[k1];
	end
	return temp1;
end
local T_QueriedCache = setmetatable({  }, {
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
			end,
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

local function LF_FormatMessage(header)	--	head#pid:cur:max
	local msg = header;
	local valid = false;
	for pid = __db__.DBMINPID, __db__.DBMAXPID do
		local var = rawget(VAR, pid);
		if var and __db__.is_pid(pid) then
			if var.cur_rank and var.max_rank then
				msg = msg .. "#" .. PLAYER_GUID .. "#" .. pid .. ":" .. var.cur_rank .. ":" .. var.max_rank;
				valid = true;
			end
		end
	end
	return valid, msg;
end
local function LF_Broadcast()
	if IsInGuild() then
		local valid, msg = LF_FormatMessage(ADDON_MSG_REPLY_SKILL);
		if valid then
			SendAddonMessage(ADDON_PREFIX, msg, "GUILD");
		end
	end
end
local function LF_GetColoredName(GUID)
	local lClass, class, lRace, race, sex, name = GetPlayerInfoByGUID(GUID);
	if name and class then
		local classColorTable = RAID_CLASS_COLORS[strupper(class)];
		return format("|cff%.2x%.2x%.2x", classColorTable.r * 255, classColorTable.g * 255, classColorTable.b * 255) .. name .. "|r";
	end
end
local function LF_GetPlayerLink(GUID)
	local lClass, class, lRace, race, sex, name = GetPlayerInfoByGUID(GUID);
	if name and class then
		local classColorTable = RAID_CLASS_COLORS[strupper(class)];
		return "|Hplayer:" .. name .. ":0:WHISPER|h" .. 
					format("|cff%.2x%.2x%.2x[", classColorTable.r * 255, classColorTable.g * 255, classColorTable.b * 255) .. name .. "]|r"
					.. "|h";
	end
end

function F.CHAT_MSG_ADDON(prefix, msg, channel, sender, target, zoneChannelID, localID, name, instanceID)
	if prefix == ADDON_PREFIX then
		local name, realm = strsplit("-", sender);
		if name and (realm == nil or realm == "" or realm == PLAYER_REALM_NAME) then
			local control_code = strsub(msg, 1, ADDON_MSG_CONTROL_CODE_LEN);
			local body = strsub(msg, ADDON_MSG_CONTROL_CODE_LEN + 2, - 1);
			if body == "" then
				return;
			end
			--[[if control_code == ADDON_MSG_QUERY_SKILL then
				local valid, msg = LF_FormatMessage(ADDON_MSG_REPLY_SKILL);
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
						local pid = __db__.get_pid_by_sid(sid);
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
					if sid and __db__.is_tradeskill_sid(sid) then
						local cid = __db__.get_cid_by_sid(sid);
						local result = T_QueriedCache[sid](rGUID);
						local data = { strsplit("#", val) };
						local output = LF_GetPlayerLink(rGUID);
						local ok = output ~= nil;
						output = output ~= nil and (output .. ":");
						for index = 1, #data do
							local mGUID = data[index];
							result[mGUID] = true;
							-- print(rGUID, mGUID, GetPlayerInfoByGUID(mGUID));
							if ok then
								local name = LF_GetColoredName(mGUID);
								if name ~= nil then
									output = output .. " " .. name;
								else
									ok = false;
								end
							end
						end
						if ok then
							local link = cid and (__db__.item_link_s(cid)) or __namespace__.F_GetSkillLink(sid);
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
F.CHAT_MSG_ADDON_LOGGED = F.CHAT_MSG_ADDON;

function __namespace__.F_cmmQuerySpell(sid)
	local t = GetServerTime();
	if IsInGuild() then
		SendAddonMessage(ADDON_PREFIX, ADDON_MSG_QUERY_RECIPE .. "#" .. sid, "GUILD");
	end
end
local function LF_cmmBroadcast(pid, list, channel, target)
	tinsert(T_QueuedMessageGuild, ADDON_MSG_BROADCAST_BEGIN .. "#" .. pid .. "#" .. #list);
	local msg = ADDON_MSG_BROADCAST_BODY .. "#".. pid;
	for index = 1, #list do
		msg = msg .. "#" .. list[index];
		if index % 40 == 0 then
			tinsert(T_QueuedMessageGuild, msg);
			msg = ADDON_MSG_BROADCAST_BODY .. "#" .. pid;
		end
	end
	--	#msg <= 250
	tinsert(T_QueuedMessageGuild, ADDON_MSG_BROADCAST_END .. "#" .. pid);
end

function __namespace__.init_communication()
	AVAR, VAR, CMM = __namespace__.AVAR, __namespace__.VAR, __namespace__.CMM;
	if RegisterAddonMessagePrefix(ADDON_PREFIX) then
		F:RegisterEvent("CHAT_MSG_ADDON");
		F:RegisterEvent("CHAT_MSG_ADDON_LOGGED");
		-- C_Timer_NewTicker(0.1, function()
		-- 	if IsInGuild() then
		-- 		local work = tremove(T_QueuedMessageGuild, 1);
		-- 		if work then
		-- 			SendAddonMessage(ADDON_PREFIX, work, "GUILD");
		-- 		end
		-- 	end
		-- end);
		-- C_Timer_NewTicker(0.02, function()
		-- 	if IsInGuild() then
		-- 		local work = tremove(T_QueuedMessageWhisper, 1);
		-- 		if work then
		-- 			SendAddonMessage(ADDON_PREFIX, work[1], "GUILD", work[2]);
		-- 		end
		-- 	end
		-- end);
		-- C_Timer_NewTicker(60.0, LF_Broadcast);
	else
		_error_("RegisterAddonMessagePrefix", ADDON_PREFIX);
	end
end

