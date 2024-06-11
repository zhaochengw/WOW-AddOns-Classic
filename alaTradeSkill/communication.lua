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
	local tonumber = tonumber;
	local rawget = rawget;
	local setmetatable = setmetatable;
	local print = print;

	local strupper = string.upper;
	local strsplit = string.split;
	local strsub = string.sub;
	local strfind = string.find;
	local format = string.format;
	local wipe = table.wipe;

	local CreateFrame = CreateFrame;
	local IsInGuild = IsInGuild;
	local GetPlayerInfoByGUID = GetPlayerInfoByGUID;
	local RAID_CLASS_COLORS = RAID_CLASS_COLORS;
	local GetServerTime = GetServerTime;

	local RegisterAddonMessagePrefix = RegisterAddonMessagePrefix or C_ChatInfo.RegisterAddonMessagePrefix;
	local IsAddonMessagePrefixRegistered = IsAddonMessagePrefixRegistered or C_ChatInfo.IsAddonMessagePrefixRegistered;
	local GetRegisteredAddonMessagePrefixes = GetRegisteredAddonMessagePrefixes or C_ChatInfo.GetRegisteredAddonMessagePrefixes;
	local SendAddonMessage = SendAddonMessage or C_ChatInfo.SendAddonMessage;
	local SendAddonMessageLogged = SendAddonMessageLogged or C_ChatInfo.SendAddonMessageLogged;

	local _G = _G;

-->
	local DataAgent = DT.DataAgent;

-->
MT.BuildEnv("communication");
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


local F = CreateFrame('FRAME');
F:SetScript("OnEvent", function(self, event, ...)
	return self[event](...);
end);


local T_QueuedMessageGuild = {  };
local T_QueuedMessageWhisper = {  };

local _metamethod__index = function(t, k)
	local temp = {  };
	t[k] = temp;
	return temp;
end
local _metamethod__call = function(t, k)
	local temp = rawget(t, k);
	if temp then
		wipe(temp);
	else
		temp = t[k];
	end
	return temp;
end
local T_QueriedCache = setmetatable({  }, {
	__index = function(t, k)
		local temp = setmetatable({  }, {
			__index = _metamethod__index,
			__call = _metamethod__call,
		});
		t[k] = temp;
		return temp;
	end,
	__call = _metamethod__call,
});

local function LF_FormatMessage(header)	--	head#pid:cur:max
	local msg = header;
	local valid = false;
	for pid = DataAgent.DBMINPID, DataAgent.DBMAXPID do
		local var = rawget(VT.VAR, pid);
		if var and DataAgent.is_pid(pid) then
			if var.cur_rank and var.max_rank then
				msg = msg .. "#" .. CT.SELFGUID .. "#" .. pid .. ":" .. var.cur_rank .. ":" .. var.max_rank;
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
		if name and (realm == nil or realm == "" or realm == CT.SELFREALM) then
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
					local cmm = VT.CMM[GUID];
					if cmm == nil then
						cmm = {  };
						VT.CMM[GUID] = cmm;
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
				if name ~= CT.SELFNAME then
					local sid = tonumber(body);
					if sid then
						local pid = DataAgent.get_pid_by_sid(sid);
						if pid then
							local reply = CT.SELFGUID;
							local found = false;
							for GUID, VAR in next, VT.AVAR do
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
					if sid and DataAgent.is_tradeskill_sid(sid) then
						local cid = DataAgent.get_cid_by_sid(sid);
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
							local link = cid and (DataAgent.item_link_s(cid)) or MT.GetSkillLink(sid);
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

function MT.CommQuerySpell(sid)
	local t = GetServerTime();
	if IsInGuild() then
		SendAddonMessage(ADDON_PREFIX, ADDON_MSG_QUERY_RECIPE .. "#" .. sid, "GUILD");
	end
end
local function LF_cmmBroadcast(pid, list, channel, target)
	T_QueuedMessageGuild[#T_QueuedMessageGuild + 1] = ADDON_MSG_BROADCAST_BEGIN .. "#" .. pid .. "#" .. #list;
	local msg = ADDON_MSG_BROADCAST_BODY .. "#".. pid;
	for index = 1, #list do
		msg = msg .. "#" .. list[index];
		if index % 40 == 0 then
			T_QueuedMessageGuild[#T_QueuedMessageGuild + 1] = msg;
			msg = ADDON_MSG_BROADCAST_BODY .. "#" .. pid;
		end
	end
	--	#msg <= 250
	T_QueuedMessageGuild[#T_QueuedMessageGuild + 1] = ADDON_MSG_BROADCAST_END .. "#" .. pid;
end

MT.RegisterOnInit('communication', function(LoggedIn)
	if RegisterAddonMessagePrefix(ADDON_PREFIX) then
		F:RegisterEvent("CHAT_MSG_ADDON");
		F:RegisterEvent("CHAT_MSG_ADDON_LOGGED");
		-- MT._TimerStart(0.1, function()
		-- 	if IsInGuild() then
		-- 		local work = tremove(T_QueuedMessageGuild, 1);
		-- 		if work then
		-- 			SendAddonMessage(ADDON_PREFIX, work, "GUILD");
		-- 		end
		-- 	end
		-- end, 0.1);
		-- MT._TimerStart(0.02, function()
		-- 	if IsInGuild() then
		-- 		local work = tremove(T_QueuedMessageWhisper, 1);
		-- 		if work then
		-- 			SendAddonMessage(ADDON_PREFIX, work[1], "GUILD", work[2]);
		-- 		end
		-- 	end
		-- end, 0.02);
		-- MT._TimerStart(LF_Broadcast, 60.0);
	else
		MT.Error("RegisterAddonMessagePrefix", ADDON_PREFIX);
	end
end);

