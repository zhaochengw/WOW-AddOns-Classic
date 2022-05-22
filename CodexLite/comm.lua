--[[--
	by ALA @ 163UI/网易有爱, http://wowui.w.163.com/163ui/
	CREDIT shagu/pfQuest(MIT LICENSE) @ https://github.com/shagu
--]]--
----------------------------------------------------------------------------------------------------
local __addon, __ns = ...;

local _G = _G;
local _ = nil;
----------------------------------------------------------------------------------------------------
--[=[dev]=]	if __ns.__is_dev then __ns._F_devDebugProfileStart('module.comm'); end

-->		variables
	local GetTime = GetTime;
	local next = next;
	local tonumber = tonumber;
	local tremove, wipe = table.remove, table.wipe;
	local strlen, strupper, strsplit, strsub, strmatch, gsub = string.len, string.upper, string.split, string.sub, string.match, string.gsub;
	local GetFactionInfoByID = GetFactionInfoByID;
	local Ambiguate = Ambiguate;
	local RegisterAddonMessagePrefix = RegisterAddonMessagePrefix or C_ChatInfo.RegisterAddonMessagePrefix;
	local IsAddonMessagePrefixRegistered = IsAddonMessagePrefixRegistered or C_ChatInfo.IsAddonMessagePrefixRegistered;
	local GetRegisteredAddonMessagePrefixes = GetRegisteredAddonMessagePrefixes or C_ChatInfo.GetRegisteredAddonMessagePrefixes;
	local SendAddonMessage = SendAddonMessage or C_ChatInfo.SendAddonMessage;
	local SendAddonMessageLogged = SendAddonMessageLogged or C_ChatInfo.SendAddonMessageLogged;
	local IsInGroup, IsInRaid = IsInGroup, IsInRaid;
	local GetNumGroupMembers = GetNumGroupMembers;
	local GetRaidRosterInfo = GetRaidRosterInfo;
	local UnitName = UnitName;
	local UnitClassBase = UnitClassBase;
	local UnitExists = UnitExists;
	local UnitInBattleground = UnitInBattleground;
	local UnitIsConnected = UnitIsConnected;
	local ChatFrame_AddMessageEventFilter = ChatFrame_AddMessageEventFilter;
	local LE_PARTY_CATEGORY_HOME = LE_PARTY_CATEGORY_HOME;

	local __db = __ns.db;
	local __db_quest = __db.quest;
	local __db_unit = __db.unit;
	local __db_item = __db.item;
	local __db_object = __db.object;
	local __db_refloot = __db.refloot;
	local __db_event = __db.event;
	local __db_avl_quest_list = __db.avl_quest_list;
	local __db_avl_quest_hash = __db.avl_quest_hash;
	local __db_blacklist_item = __db.blacklist_item;
	local __db_large_pin = __db.large_pin;
	local __db_chain_prev_quest = __db.chain_prev_quest;

	local __loc_object = __ns.L.object;

	local __core = __ns.core;
	local _F_SafeCall = __core._F_SafeCall;
	local __eventHandler = __core.__eventHandler;
	local __const = __core.__const;
	local PreloadCoords = __core.PreloadCoords;
	local IMG_INDEX = __core.IMG_INDEX;
	local GetQuestStartTexture = __core.GetQuestStartTexture;

	local __core_meta = __ns.__core_meta;

	local UnitHelpFac = __core.UnitHelpFac;
	local _log_ = __ns._log_;

	local SET = nil;

-->
if __ns.__is_dev then
	__ns:BuildEnv("comm");
end
-->		MAIN
	local ADDON_PREFIX = "CDXLT";
	local ADDON_PREFIX_V1 = ADDON_PREFIX .. "1";
	local ADDON_PREFIX_V2 = ADDON_PREFIX .. "2";
	local ADDON_MSG_HEAD_PUSHQUEST_V2 = "Q";
	local ADDON_MSG_HEAD_PUSHLINE_V2 = "L";
	local ADDON_MSG_HEAD_PULL_V2 = "P";
	local ADDON_MSG_HEAD_RESET_V2 = "R";
	local ADDON_MSG_HEAD_ONLINE_V2 = "O";
	local META = {  };	--	[quest_id] = { [flag:whether_nodes_added], [completed], [num_lines], [line(1, 2, 3, ...)] = { shown, objective_type, objective_id, description, finished, is_large_pin, progress, required, }, }
	local OBJ_LOOKUP = {  };
	__ns.__comm_meta = META;
	__ns.__comm_obj_lookup = OBJ_LOOKUP;
	local GROUP_MEMBERS = {  };
	__ns.__comm_group_members = GROUP_MEMBERS;
	local GROUP_MEMBERS_INFO = {  };
	__ns.__comm_group_members_info = GROUP_MEMBERS_INFO;
	local _Inited = {  };
	-->		function predef
		local CommDelUUID, CommAddUUID, CommSubUUID, CommGetUUID, ResetUUID;
		local GetVariedNodeTexture, AddCommonNodes, DelCommonNodes, AddLargeNodes, DelLargeNodes, AddVariedNodes, DelVariedNodes;
		local AddSpawn, DelSpawn, AddUnit, DelUnit, AddObject, DelObject, AddRefloot, DelRefloot, AddItem, DelItem, AddEvent, DelEvent;
		local AddQuester_VariedTexture, DelQuester_VariedTexture, AddQuestStart, DelQuestStart, AddQuestEnd, DelQuestEnd;
		local AddLine, DelLine;
		local AddExtra, DelExtra;
		local MessageTicker, ScheduleMessage;
		local PushReset, PushAddQuest, PushDelQuest, PushAddLine, PushFlushBuffer;
		local PushResetSingle, PushAddQuestSingle, PushDelQuestSingle, PushAddLineSingle, PushFlushBufferSingle;
		local PushSingle, PullSingle, BroadcastOnline;
		local DisableComm, EnableComm;
		local UpdateGroupMembers;
	-->
	local noop = function() end
	local is_comm_enabled = false;
	-->		--	uuid:{ 1type, 2id, 3color3(run-time), 4{ [quest] = { [line] = TEXTURE, }, }, }
	-->		--	line:	'start', 'end', >=1:line_quest_leader, 'extra'
	-->		--	uuid 对应单位/对象类型，储存任务-行信息，对应META_COMMON表坐标设置一次即可
		local _UUID = {  };
		function CommDelUUID(name)
			_UUID[name] = nil;
		end
		function CommAddUUID(name, _T, _id, _quest, _line, _val)
			local UUID = _UUID[name];
			if UUID == nil then
				UUID = { event = {  }, item = {  }, object = {  }, quest = {  }, unit = {  }, };
				_UUID[name] = UUID;
			end
			local uuid = UUID[_T][_id];
			if uuid == nil then
				uuid = { _T, _id, nil, {  }, };
				UUID[_T][_id] = uuid;
			end
			local ref = uuid[4][_quest];
			if ref == nil then
				ref = { [_line] = _val or 1, };
				uuid[4][_quest] = ref;
			else
				ref[_line] = _val or 1;
			end
			return uuid;
		end
		function CommSubUUID(name, _T, _id, _quest, _line, total_del)
			local UUID = _UUID[name];
			if UUID ~= nil then
				local uuid = UUID[_T][_id];
				if uuid ~= nil then
					local ref = uuid[4][_quest];
					if ref ~= nil then
						local val = ref[_line];
						if val ~= nil then
							ref[_line] = nil;
							if next(ref) == nil then
								uuid[4][_quest] = nil;
							end
							if next(uuid[4]) == nil then
								if not total_del then
									ref[_line] = 0;
									uuid[4][_quest] = ref;
								end
								return uuid, true;
							else
								if not total_del then
									ref[_line] = 0;
									uuid[4][_quest] = ref;
								end
								return uuid, false;
							end
						else
							if next(ref) == nil then
								uuid[4][_quest] = nil;
							end
							if next(uuid[4]) == nil then
								return uuid, true;
							else
								return uuid, false;
							end
						end
					else
						if next(uuid[4]) == nil then
							return uuid, true;
						else
							return uuid, false;
						end
					end
				end
				return uuid;
			end
		end
		function CommGetUUID(name, _T, _id)
			local UUID = _UUID[name];
			if UUID ~= nil then
				return UUID[_T][_id];
			end
		end
		function ResetUUID()
			wipe(_UUID);
		end
		__ns.CommAddUUID = CommAddUUID;
		__ns.CommSubUUID = CommSubUUID;
		__ns.CommGetUUID = CommGetUUID;
	-->
	-->		send data to ui
		local COMMON_UUID_FLAG = {  };
		local LARGE_UUID_FLAG = {  };
		local VARIED_UUID_FLAG = {  };
		function GetVariedNodeTexture(texture_list)
			local TEXTURE = 0;
			for quest, list in next, texture_list do
				for _, texture in next, list do
					if texture > TEXTURE then
						TEXTURE = texture;
					end
				end
			end
			return TEXTURE ~= 0 and TEXTURE or nil;
		end
		--	common_objective pin
		function AddCommonNodes(name, _T, _id, _quest, _line, coords_table)
			local uuid = CommAddUUID(name, _T, _id, _quest, _line, -9998);
			if COMMON_UUID_FLAG[uuid] == nil then
				if coords_table ~= nil then
					__ns.MapAddCommonNodes(uuid, coords_table);
				end
				COMMON_UUID_FLAG[uuid] = true;
			end
		end
		function DelCommonNodes(name, _T, _id, _quest, _line, total_del)
			local uuid, del = CommSubUUID(name, _T, _id, _quest, _line, total_del);
			if del == false then
				del = true;
				for _, ref in next, uuid[4] do
					for line, val in next, ref do
						if val == -9998 then
							del = false;
							break;
						end
					end
				end
			end
			if del == true then
				__ns.MapDelCommonNodes(uuid);
				COMMON_UUID_FLAG[uuid] = nil;
			end
		end
		--	large_objective pin
		function AddLargeNodes(name, _T, _id, _quest, _line, coords_table)
			local uuid = CommAddUUID(name, _T, _id, _quest, _line, -9999);
			if LARGE_UUID_FLAG[uuid] == nil then
				if coords_table ~= nil then
					__ns.MapAddLargeNodes(uuid, coords_table);
				end
				LARGE_UUID_FLAG[uuid] = true;
			end
		end
		function DelLargeNodes(name, _T, _id, _quest, _line, total_del)
			local uuid, del = CommSubUUID(name, _T, _id, _quest, _line, total_del);
			if del == false then
				del = true;
				for _, ref in next, uuid[4] do
					for line, val in next, ref do
						if val == -9999 then
							del = false;
							break;
						end
					end
				end
			end
			if del == true then
				__ns.MapDelLargeNodes(uuid);
				LARGE_UUID_FLAG[uuid] = nil;
			end
		end
		--	varied_objective pin
		function AddVariedNodes(name, _T, _id, _quest, _line, coords_table, varied_texture)
			local uuid = CommAddUUID(name, _T, _id, _quest, _line, varied_texture);
			local TEXTURE = GetVariedNodeTexture(uuid[4]);
			if uuid[5] ~= TEXTURE then
				uuid[5] = TEXTURE;
				__ns.MapAddVariedNodes(uuid, coords_table, VARIED_UUID_FLAG[uuid]);
				VARIED_UUID_FLAG[uuid] = true;
			end
		end
		function DelVariedNodes(name, _T, _id, _quest, _line)
			local uuid, del = CommSubUUID(name, _T, _id, _quest, _line, true);
			if del == true then
				uuid[5] = nil;
				if VARIED_UUID_FLAG[uuid] ~= nil then
					__ns.MapDelVariedNodes(uuid);
					VARIED_UUID_FLAG[uuid] = nil;
				end
			elseif del == false then
				local TEXTURE = GetVariedNodeTexture(uuid[4]);
				if uuid[5] ~= TEXTURE then
					uuid[5] = TEXTURE;
					if VARIED_UUID_FLAG[uuid] ~= nil then
						__ns.MapAddVariedNodes(uuid, nil, true);
					end
				end
			end
		end
	-->
	-->		send quest data
		function AddSpawn(name, quest, line, spawn, show_coords, showFriend)
			if spawn.U ~= nil then
				for unit, _ in next, spawn.U do
					local large_pin = __db_large_pin:Check(quest, 'unit', unit);
					AddUnit(name, quest, line, unit, show_coords, large_pin, showFriend);
				end
			end
			if spawn.O ~= nil then
				for object, _ in next, spawn.O do
					local large_pin = __db_large_pin:Check(quest, 'object', object);
					AddObject(name, quest, line, object, show_coords, large_pin);
				end
			end
		end
		function DelSpawn(name, quest, line, spawn, total_del)
			if spawn.U ~= nil then
				for unit, _ in next, spawn.U do
					local large_pin = __db_large_pin:Check(quest, 'unit', unit);
					DelUnit(name, quest, line, unit, total_del, large_pin);
				end
			end
			if spawn.O ~= nil then
				for object, _ in next, spawn.O do
					local large_pin = __db_large_pin:Check(quest, 'object', object);
					DelObject(name, quest, line, object, total_del, large_pin);
				end
			end
		end
		function AddUnit(name, quest, line, uid, show_coords, large_pin, showFriend)
			local info = __db_unit[uid];
			if info ~= nil then
				if showFriend ~= nil then
					local isFriend = nil;
					if info.fac == nil then
						if info.facId ~= nil then
							local _, _, standing_rank, _, _, val = GetFactionInfoByID(info.facId);
							if val ~= nil and val > 0 then
								isFriend = true;
							else		--	if val <= -3000 then	--	冷淡不会招致主动攻击，敌对开始主动攻击
								isFriend = false;
							end
						else
							isFriend = false;
						end
					else
						isFriend = UnitHelpFac[info.fac];
					end
					if not showFriend ~= not isFriend then
						return;
					end
				end
				if large_pin then
					AddLargeNodes(name, 'unit', uid, quest, line, nil);
				else
					AddCommonNodes(name, 'unit', uid, quest, line, nil);
				end
				local spawn = info.spawn;
				if spawn ~= nil then
					AddSpawn(name, quest, line, spawn, show_coords, showFriend);
				end
			end
		end
		function DelUnit(name, quest, line, uid, total_del, large_pin)
			local info = __db_unit[uid];
			if info ~= nil then
				if large_pin then
					DelLargeNodes(name, 'unit', uid, quest, line, total_del);
				else
					DelCommonNodes(name, 'unit', uid, quest, line, total_del);
				end
				local spawn = info.spawn;
				if spawn ~= nil then
					DelSpawn(name, quest, line, spawn, total_del);
				end
			end
		end
		function AddObject(name, quest, line, oid, show_coords, large_pin)
			local info = __db_object[oid];
			if info ~= nil then
				if large_pin then
					AddLargeNodes(name, 'object', oid, quest, line, nil);
				else
					AddCommonNodes(name, 'object', oid, quest, line, nil);
				end
				local spawn = info.spawn;
				if spawn ~= nil then
					AddSpawn(name, quest, line, spawn, show_coords);
				end
			end
			local name = __loc_object[oid];
			if name ~= nil then
				OBJ_LOOKUP[name] = oid;
			end
		end
		function DelObject(name, quest, line, oid, total_del, large_pin)
			local info = __db_object[oid];
			if info ~= nil then
				if large_pin then
					DelLargeNodes(name, 'object', oid, quest, line, total_del);
				else
					DelCommonNodes(name, 'object', oid, quest, line, total_del);
				end
				local spawn = info.spawn;
				if spawn ~= nil then
					DelSpawn(name, quest, line, spawn, total_del);
				end
			end
		end
		function AddRefloot(name, quest, line, rid, show_coords, large_pin)
			local info = __db_refloot[rid];
			if info ~= nil then
				if info.U ~= nil then
					for uid, _ in next, info.U do
						AddUnit(name, quest, line, uid, show_coords, large_pin, false);
					end
				end
				if info.O ~= nil then
					for oid, _ in next, info.O do
						AddObject(name, quest, line, oid, show_coords, large_pin);
					end
				end
			end
		end
		function DelRefloot(name, quest, line, rid, total_del, large_pin)
			local info = __db_refloot[rid];
			if info ~= nil then
				if info.U ~= nil then
					for uid, _ in next, info.U do
						DelUnit(name, quest, line, uid, total_del, large_pin);
					end
				end
				if info.O ~= nil then
					for oid, _ in next, info.O do
						DelObject(name, quest, line, oid, total_del, large_pin);
					end
				end
			end
		end
		function AddItem(name, quest, line, iid, show_coords, large_pin)
			if __db_blacklist_item[iid] ~= nil then
				return;
			end
			local info = __db_item[iid];
			if info ~= nil then
				if info.U ~= nil then
					for uid, rate in next, info.U do
						if rate >= SET.min_rate then
							AddUnit(name, quest, line, uid, show_coords, large_pin, false);
						end
					end
				end
				if info.O ~= nil then
					for oid, rate in next, info.O do
						if rate >= SET.min_rate then
							AddObject(name, quest, line, oid, show_coords, large_pin);
						end
					end
				end
				if info.R ~= nil then
					for rid, rate in next, info.R do
						if rate >= SET.min_rate then
							AddRefloot(name, quest, line, rid, show_coords, large_pin);
						end
					end
				end
				if info.V ~= nil then
					for vid, _ in next, info.V do
						AddUnit(name, quest, line, vid, show_coords, large_pin, true);
					end
				end
				if info.I ~= nil then
					local line2 = line > 0 and -line or line;
					for iid2, _ in next, info.I do
						AddItem(name, quest, line2, iid2, show_coords, large_pin);
					end
				end
			end
		end
		function DelItem(name, quest, line, iid, total_del, large_pin)
			if __db_blacklist_item[iid] ~= nil then
				return;
			end
			local info = __db_item[iid];
			if info ~= nil then
				if info.U ~= nil then
					for uid, rate in next, info.U do
						DelUnit(name, quest, line, uid, total_del, large_pin);
					end
				end
				if info.O ~= nil then
					for oid, rate in next, info.O do
						DelObject(name, quest, line, oid, total_del, large_pin);
					end
				end
				if info.R ~= nil then
					for rid, _ in next, info.R do
						DelRefloot(name, quest, line, rid, total_del, large_pin);
					end
				end
				if info.V ~= nil then
					for vid, _ in next, info.V do
						DelUnit(name, quest, line, vid, total_del, large_pin);
					end
				end
				if info.I ~= nil then
					local line2 = line > 0 and -line or line;
					for iid2, _ in next, info.I do
						DelItem(name, quest, line, iid2, total_del, large_pin);
					end
				end
			end
		end
		function AddEvent(name, quest, line, eid, show_coords, large_pin)
			local info = __db_event[eid];
			if info ~= nil then
				PreloadCoords(info);
				if large_pin then
					AddLargeNodes(name, 'event', eid, quest, line, nil);
				else
					AddCommonNodes(name, 'event', eid, quest, line, nil);
				end
				local spawn = info.spawn;
				if spawn ~= nil then
					AddSpawn(name, quest, line, spawn, false);
				end
			end
		end
		function DelEvent(name, quest, line, eid, total_del, large_pin)
			local info = __db_event[eid];
			if info ~= nil then
				if large_pin then
					DelLargeNodes(name, 'event', eid, quest, line, total_del);
				else
					DelCommonNodes(name, 'event', eid, quest, line, total_del);
				end
				local spawn = info.spawn;
				if spawn ~= nil then
					DelSpawn(name, quest, line, spawn, total_del);
				end
			end
		end
		--
		function AddQuester_VariedTexture(name, quest, info, which, TEXTURE)
			if info ~= nil then
				local O = info.O;
				if O ~= nil then
					for index = 1, #O do
						local oid = O[index];
						local info = __db_object[oid];
						if info ~= nil then
							AddVariedNodes(name, 'object', oid, quest, which, nil, TEXTURE);
						end
						local name = __loc_object[oid];
						if name ~= nil then
							OBJ_LOOKUP[name] = oid;
						end
					end
				end
				local U = info.U;
				if U ~= nil then
					for index = 1, #U do
						local uid = U[index];
						local info = __db_unit[uid];
						if info ~= nil then
							AddVariedNodes(name, 'unit', uid, quest, which, nil, TEXTURE);
						end
					end
				end
			end
		end
		function DelQuester_VariedTexture(name, quest, info, which)
			if info ~= nil then
				local O = info.O;
				if O ~= nil then
					for index = 1, #O do
						DelVariedNodes(name, 'object', O[index], quest, which);
					end
				end
				local U = info.U;
				if U ~= nil then
					for index = 1, #U do
						DelVariedNodes(name, 'unit', U[index], quest, which);
					end
				end
			end
		end
		function AddQuestStart(name, quest, info, TEXTURE)
			AddQuester_VariedTexture(name, quest, info.start, 'start', TEXTURE or GetQuestStartTexture(info));
		end
		function DelQuestStart(name, quest, info)
			DelQuester_VariedTexture(name, quest, info.start, 'start');
		end
		function AddQuestEnd(name, quest, info, TEXTURE)
			AddQuester_VariedTexture(name, quest, info["end"], 'end', TEXTURE);
		end
		function DelQuestEnd(name, quest, info)
			DelQuester_VariedTexture(name, quest, info["end"], 'end');
		end
	-->
	-->		line	-1 = Quest Giver	-2 = Quest Completer	0 = event
		function AddLine(name, quest_id, _line, _type, _id, finished)
			-- if finished then
			-- 	_log_('AddLine-T_T', name, _type, _id);
			-- else
			-- 	_log_('AddLine-T_F', name, _type, _id);
			-- end
			if _type == 'monster' then
				local large_pin = __db_large_pin:Check(quest_id, 'unit', _id);
				AddUnit(name, quest_id, _line, _id, not finished, large_pin, true);
				return true, _id, large_pin;
			elseif _type == 'item' then
				local large_pin = __db_large_pin:Check(quest_id, 'item', _id);
				AddItem(name, quest_id, _line, _id, not finished, large_pin);
				return true, _id, large_pin;
			elseif _type == 'object' then
				local large_pin = __db_large_pin:Check(quest_id, 'object', _id);
				AddObject(name, quest_id, _line, _id, not finished, large_pin);
				return true, _id, large_pin;
			elseif _type == 'event' or _type == 'log' then
				local info = __db_quest[quest_id];
				if info ~= nil and info.obj ~= nil and info.obj.E ~= nil then
					local events = info.obj.E;
					for i = 1, #events do
						local event = events[i];
						AddEvent(name, quest_id, _line, event, false, true);
					end
				end
				return true, 'event', true;
			elseif _type == 'reputation' then
			elseif _type == 'player' or _type == 'progressbar' then
			else
				_log_('comm_objective_type', quest_id, finished, _type);
			end
			return true;
		end
		function DelLine(name, quest_id, _line, _type, _id, total_del)
			if _type == 'monster' then
				local large_pin = __db_large_pin:Check(quest_id, 'unit', _id);
				DelUnit(name, quest_id, _line, _id, total_del, large_pin);
				return true, _id, large_pin;
			elseif _type == 'item' then
				local large_pin = __db_large_pin:Check(quest_id, 'item', _id);
				DelItem(name, quest_id, _line, _id, total_del, large_pin);
				return true, _id, large_pin;
			elseif _type == 'object' then
				local large_pin = __db_large_pin:Check(quest_id, 'object', _id);
				DelObject(name, quest_id, _line, _id, total_del, large_pin);
				return true, _id, large_pin;
			elseif _type == 'event' or _type == 'log' then
				local info = __db_quest[quest_id];
				if info ~= nil and info.obj ~= nil and info.obj.E ~= nil then
					local events = info.obj.E;
					for i = 1, #events do
						local event = events[i];
						DelEvent(name, quest_id, _line, event, total_del, true);
					end
				end
				return true, 'event', true;
			elseif _type == 'reputation' then
			elseif _type == 'player' or _type == 'progressbar' then
			else
				_log_('comm_objective_type', quest_id, _type, _id);
			end
			return true;
		end
		function AddExtra(name, quest_id, extra, text, completed)
			if extra.U ~= nil then
				for uid, check in next, extra.U do
					local large_pin = __db_large_pin:Check(quest_id, 'unit', uid);
					if check == completed or check == 'always' then
						AddUnit(name, quest_id, 'extra', uid, true, large_pin, true);
					else
						DelUnit(name, quest_id, 'extra', uid, false, large_pin);
					end
				end
			end
			if extra.I ~= nil then
				for iid, check in next, extra.I do
					local large_pin = __db_large_pin:Check(quest_id, 'unit', iid);
					if check == completed or check == 'always' then
						AddItem(name, quest_id, 'extra', iid, true, large_pin);
					else
						DelItem(name, quest_id, 'extra', iid, false, large_pin);
					end
				end
			end
			if extra.O ~= nil then
				for oid, check in next, extra.O do
					OBJ_LOOKUP[__loc_object[oid]] = oid;
					local large_pin = __db_large_pin:Check(quest_id, 'object', oid);
					if check == completed or check == 'always' then
						AddObject(name, quest_id, 'extra', oid, true, large_pin);
					else
						DelObject(name, quest_id, 'extra', oid, false, large_pin);
					end
				end
			end
			if extra.E ~= nil then
				for eid, check in next, extra.E do
					if check == completed or check == 'always' then
						AddEvent(name, quest_id, 'extra', eid, true, true);
					else
						DelEvent(name, quest_id, 'extra', eid, false, true);
					end
				end
			end
		end
		function DelExtra(name, quest_id, extra)
			if extra.U ~= nil then
				for uid, check in next, extra.U do
					local large_pin = __db_large_pin:Check(quest_id, 'unit', uid);
					DelUnit(name, quest_id, 'extra', uid, true, large_pin);
				end
			end
			if extra.I ~= nil then
				for iid, check in next, extra.I do
					local large_pin = __db_large_pin:Check(quest_id, 'unit', iid);
					DelItem(name, quest_id, 'extra', iid, true, large_pin);
				end
			end
			if extra.O ~= nil then
				for oid, check in next, extra.O do
					local large_pin = __db_large_pin:Check(quest_id, 'object', oid);
					DelObject(name, quest_id, 'extra', oid, true, large_pin);
				end
			end
			if extra.E ~= nil then
				for eid, check in next, extra.E do
					DelEvent(name, quest_id, 'extra', eid, true, true);
				end
			end
		end
	-->
	-->		net buffer
		local MessageBuffer = {  };
		local MessageTop = 0;
		local SchedulerRunning = false;
		local SentTarget = {  };
		function MessageTicker()
			local msg = tremove(MessageBuffer, 1);
			MessageTop = MessageTop - 1;
			if MessageBuffer[1] ~= nil then
				SchedulerRunning = true;
				__ns.After(0.02, MessageTicker);
			else
				SchedulerRunning = false;
			end
			SendAddonMessage(msg[1], msg[2], msg[3], msg[4]);
			SentTarget[strupper(Ambiguate(msg[3], 'none'))] = GetTime();
		end
		function ScheduleMessage(prefix, msg, channel, target)
			MessageTop = MessageTop + 1;
			MessageBuffer[MessageTop] = { prefix, msg, channel, target, };
			if not SchedulerRunning then
				SchedulerRunning = true;
				__ns.After(0.02, MessageTicker);
			end
		end
		-->		Message Filter
			--	ERR_CHAT_PLAYER_NOT_FOUND_S
			local C_String = _G.ERR_CHAT_PLAYER_NOT_FOUND_S;
			local C_Pattern = gsub(C_String, "%%s", "(.+)");
			local function F_Filter(self, event, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, line, arg12, arg13, arg14, ...)
				if C_String ~= _G.ERR_CHAT_PLAYER_NOT_FOUND_S then
					C_String = _G.ERR_CHAT_PLAYER_NOT_FOUND_S;
					C_Pattern = gsub(C_String, "%%s", "(.+)");
				end
				local name = strmatch(arg1, C_Pattern);
				if name ~= nil then
					name = strupper(Ambiguate(name, 'none'));
					local t = SentTarget[name];
					if t ~= nil then
						if GetTime() - t < 2.0 then
							return true;
						else
							SentTarget[name] = nil;
						end
					end
				end
				return false;
			end
			ChatFrame_AddMessageEventFilter("CHAT_MSG_SYSTEM", F_Filter);
		-->
		__ns.ScheduleMessage = ScheduleMessage;
	-->
	-->		comm
		--
		local _CommBuffer = {  };
		local _CommBufferLen = {  };
		--
		local function PushMessage(msg)
			local len = strlen(msg);
			local mem = _CommBuffer["*"];
			local mel = _CommBufferLen["*"];
			if mem == nil then
				_CommBuffer["*"] = msg;
				_CommBufferLen["*"] = len;
			elseif mel < 249 - len then
				_CommBuffer["*"] = mem .. "\001" .. msg;
				_CommBufferLen["*"] = mel + 1 + len;
			else
				for name, val in next, GROUP_MEMBERS do
					if val then
						ScheduleMessage(ADDON_PREFIX_V2, mem, "WHISPER", name);
					end
				end
				_CommBuffer["*"] = msg;
				_CommBufferLen["*"] = len;
			end
		end
		function PushReset()
			PushMessage(ADDON_MSG_HEAD_RESET_V2);
		end
		function PushAddQuest(_quest, _completed, title, num_lines)
			PushMessage(ADDON_MSG_HEAD_PUSHQUEST_V2 .. "\001" .. _quest .. "\0011\001" .. _completed .. "\001" .. num_lines .. "\001" .. title);
		end
		function PushDelQuest(_quest, _completed)
			PushMessage(ADDON_MSG_HEAD_PUSHQUEST_V2 .. "\001" .. _quest .. "\001-1\001" .. _completed);
		end
		function PushAddLine(_quest, _line, _finished, _type, _id, _text)
			if _type == 'event' or _type == 'log' then
				local info = __db_quest[_quest];
				if info ~= nil and info.obj ~= nil and info.obj.E ~= nil then
					local events = info.obj.E;
					if events ~= nil then
						for i = 1, #events do
							local _id = events[i];
							PushMessage(ADDON_MSG_HEAD_PUSHLINE_V2 .. "\001" .. _quest .. (_finished and "\0011\001" or "\0010\001") .. _line .. "\001event\001" .. _id .. "\001" .. _text);
						end
					end
				end
			else
				PushMessage(ADDON_MSG_HEAD_PUSHLINE_V2 .. "\001" .. _quest .. (_finished and "\0011\001" or "\0010\001") .. _line .. "\001" .. _type .. "\001" .. _id .. "\001" .. _text);
			end
		end
		function PushFlushBuffer()
			local mem = _CommBuffer["*"];
			if mem ~= nil then
				for name, val in next, GROUP_MEMBERS do
					if val then
						ScheduleMessage(ADDON_PREFIX_V2, mem, "WHISPER", name);
					end
				end
				_CommBuffer["*"] = nil;
				_CommBufferLen["*"] = nil;
			end
		end
		--
		local function PushMessageSingle(name, msg)
			local len = strlen(msg);
			local mem = _CommBuffer[name];
			local mel = _CommBufferLen[name];
			if mem == nil then
				_CommBuffer[name] = msg;
				_CommBufferLen[name] = len;
			elseif mel < 249 - len then
				_CommBuffer[name] = mem .. "\001" .. msg;
				_CommBufferLen[name] = mel + 1 + len;
			else
				ScheduleMessage(ADDON_PREFIX_V2, mem, "WHISPER", name);
				_CommBuffer[name] = msg;
				_CommBufferLen[name] = len;
			end
		end
		function PushResetSingle(name)
			PushMessageSingle(name, ADDON_MSG_HEAD_RESET_V2);
		end
		function PushAddQuestSingle(name, _quest, _completed, title, num_lines)
			PushMessageSingle(name, ADDON_MSG_HEAD_PUSHQUEST_V2 .. "\001" .. _quest .. "\0011\001" .. _completed .. "\001" .. num_lines .. "\001" .. title);
		end
		function PushDelQuestSingle(name, _quest, _completed)
			PushMessageSingle(name, ADDON_MSG_HEAD_PUSHQUEST_V2 .. "\001" .. _quest .. "\001-1\001" .. _completed);
		end
		function PushAddLineSingle(name, _quest, _line, _finished, _type, _id, _text)
			PushMessageSingle(name, ADDON_MSG_HEAD_PUSHLINE_V2 .. "\001" .. _quest .. (_finished and "\0011\001" or "\0010\001") .. _line .. "\001" .. _type .. "\001" .. _id .. "\001" .. _text);
		end
		function PushFlushBufferSingle(name)
			local mem = _CommBuffer[name];
			if mem ~= nil then
				ScheduleMessage(ADDON_PREFIX_V2, mem, "WHISPER", name);
				_CommBuffer[name] = nil;
				_CommBufferLen[name] = nil;
			end
		end
		--
		function PushSingle(name, immediate)
			_log_('comm.|cffff0000PushSingle|r', name);
			PushResetSingle(name);
			for quest, meta in next, __core_meta do
				PushAddQuestSingle(name, quest, meta.completed, meta.title, meta.num_lines);
				for line = 1, #meta do
					local meta_line = meta[line];
					if meta_line[3] ~= nil then
						PushAddLineSingle(name, quest, line, meta_line[5], meta_line[2], meta_line[3], meta_line[4]);
					end
				end
			end
			if immediate then
				PushFlushBufferSingle(name);
			end
		end
		function PullSingle(name, immediate)
			_log_('comm.|cffff0000PullSingle|r', name);
			if immediate then
				ScheduleMessage(ADDON_PREFIX_V2, ADDON_MSG_HEAD_PULL_V2, "WHISPER", name);
			else
				PushMessageSingle(name, ADDON_MSG_HEAD_PULL_V2);
			end
		end
		function BroadcastOnline()
			_log_('comm.|cffff0000BroadcastOnline|r');
			for name, val in next, GROUP_MEMBERS do
				ScheduleMessage(ADDON_PREFIX_V2, ADDON_MSG_HEAD_ONLINE_V2, "WHISPER", name);
			end
		end
	--		OnComm
		--[==[
			_completed	--	-1 = failed, 0 = uncompleted, 1 = completed
		--]==]
		local function OnCommInit(name)
			if META[name] ~= nil then
				for quest, meta in next, META[name] do
					for index = 1, meta.num_lines do
						local meta_line = meta[index];
						if meta_line ~= nil then
							DelLine(name, quest, index, meta_line[2], meta_line[3], true);
						end
					end
					local info = __db_quest[quest];
					if info ~= nil then
						-- DelQuestStart(name, quest, info);
						DelQuestEnd(name, quest, info);
					end
				end
			end
			META[name] = {  };
		end
		local function OnCommQuestAdd(name, quest, completed, num_lines, title)
			local pmeta = META[name];
			local meta = pmeta[quest];
			if meta == nil then
				pmeta[quest] = { completed = completed, title = title, num_lines = num_lines, };
			else
				meta.completed = completed;
				meta.title = title;
			end
			local info = __db_quest[quest];
			if info ~= nil then
				-- AddQuestStart(name, quest, info);
				AddQuestEnd(name, quest, info, completed == 1 and IMG_INDEX.IMG_E_COMPLETED or IMG_INDEX.IMG_E_UNCOMPLETED);
				if info.extra ~= nil then
					AddExtra(name, quest, info.extra, title, completed);
				end
			end
		end
		local function OnCommQuestDel(name, quest)
			local pmeta = META[name];
			local meta = pmeta[quest];
			if meta ~= nil then
				pmeta[quest] = nil;
				for index = 1, meta.num_lines do
					local meta_line = meta[index];
					if meta_line ~= nil then
						DelLine(name, quest, index, meta_line[2], meta_line[3], true);
					end
				end
				local info = __db_quest[quest];
				if info ~= nil then
					-- DelQuestStart(name, quest, info);
					DelQuestEnd(name, quest, info);
					if info.extra ~= nil then
						DelExtra(name, quest, info.extra);
					end
				end
			end
		end
		local function OnCommQuestLine(name, quest, line, type, id, text, finished)
			local pmeta = META[name];
			local meta = pmeta[quest];
			if meta ~= nil then
				local meta_line = meta[line];
				if meta_line == nil then
					meta[line] = { nil, type, id, text, finished, };
				else
					meta_line[2] = type;
					meta_line[3] = id;
					meta_line[4] = text;
					meta_line[5] = finished;
				end
				if type == 'object' and __loc_object[id] ~= nil then
					OBJ_LOOKUP[__loc_object[id]] = id;
				end
				AddLine(name, quest, line, type, id, finished);
			end
		end
		local function OnCommCodexLiteV1(prefix, msg, channel, sender, target, zoneChannelID, localID, name, instanceID)
			_log_('|cff00ff7fOnCommCodexLiteV1|r', msg, name);
			local control_code = strsub(msg, 1, 6);
			if control_code == "_push_" then
				if META[name] ~= nil then
				--  local _, _head, _quest, _done, _val, _type, _id, _text = strsplit("^", msg);
					local _, _head, _quest, _1,    _2,   _3,    _4,  _5 = strsplit("^", msg);
					if _head == "QUEST" then
						--	_1 : _completed		_2 : _act		_3 : _num_lines		_4 : _title
						_quest = tonumber(_quest);
						local _act = tonumber(_2);			--	1 = add, -1 = del
						if _act == -1 then
							OnCommQuestDel(name, _quest);
							_log_('|cff00ff7fV1-Quest|r|cffff0000Del|r', name, _quest, _1);
						elseif _act == 1 then
							OnCommQuestAdd(name, _quest, tonumber(_1), tonumber(_3), _4);
							_log_('|cff00ff7fV1-Quest|r|cff00ff00Add|r', name, _quest, _1, _3, _4);
						else
							_log_('|cff00ff7fV1|r |cffff0000Invalid act|r', name, _act, msg);
						end
					elseif _head == "LINE" then
						--	_1 : finished		_2 : _line		_3 : _type			_4 : _id		_5 : _text
						_quest = tonumber(_quest);
						local meta = META[name][_quest];
						if meta ~= nil then
							OnCommQuestLine(name, _quest, tonumber(_2) or _2, _3, tonumber(_4), _5, _1 == "1");
							_log_('|cff00ff7fV1-Quest|r|cff00ffffLine|r', name, _quest, _2, _3, _4, _1, _5);
						end
					else
						_log_('|cff00ff7fV2|r |cffff0000Invalid head|r', name, _head, msg);
					end
				end
			elseif control_code == "_pull_" then
				if _Inited[name] == nil then
					ScheduleMessage(ADDON_PREFIX_V1, "_pull_", "WHISPER", name);
				end
				-- PushSingle(name);
			elseif control_code == "_rst__" then
				OnCommInit(name);
				_Inited[name] = GetTime();
				_log_('|cff00ff7fV1-Quest|r|cffff7f00Reset|r', name);
			elseif control_code == "_conn_" then
				_log_('|cff00ff7fV1-Quest|r|cff00ff7fOnline|r', name);
			end
		end
		local _NextPushSingle = {  };
		local function OnCommCodexLiteV2(prefix, msg, channel, sender, target, zoneChannelID, localID, name, instanceID)
			local _SEQ = { strsplit("\001", msg) };
			local _LEN = #_SEQ;
			local _pos = 1;
			while _pos <= _LEN do
				local _head = _SEQ[_pos];
				_pos = _pos + 1;
				if _head == ADDON_MSG_HEAD_PUSHQUEST_V2 then
					local _act = _SEQ[_pos + 1];			--	1 = add, -1 = del
					--	_1 : _act		_2 : _completed		_3 : _num_lines		_4 : _title
					if _act == "1" then
						if META[name] ~= nil then
							local _quest = tonumber(_SEQ[_pos]);
							local _completed = tonumber(_SEQ[_pos + 2]);
							local _num_lines = tonumber(_SEQ[_pos + 3]);
							local _title = _SEQ[_pos + 4];
							OnCommQuestAdd(name, _quest, _completed, _num_lines, _title);
							_log_('|cff00ff7fV2-Q|r|cff00ff00Add|r', name, _quest, _completed, _num_lines, _title);
						end
						_pos = _pos + 5;
					elseif _act == "-1" then
						if META[name] ~= nil then
							local _quest = tonumber(_SEQ[_pos]);
							local _completed = tonumber(_SEQ[_pos + 2]);
							OnCommQuestDel(name, _quest);
							_log_('|cff00ff7fV2-Q|r|cffff0000Del|r', name, _quest, _completed);
						end
						_pos = _pos + 3;
					else
						_log_('|cff00ff7fV2|r |cffff0000Invalid act|r', name, _head, _pos, _act, msg);
						break;
					end
				elseif _head == ADDON_MSG_HEAD_PUSHLINE_V2 then
					local pmeta = META[name];
					if pmeta ~= nil then
						--	_1 : finished		_2 : _line		_3 : _type			_4 : _id		_5 : _text
						local _quest = tonumber(_SEQ[_pos]);
						_pos = _pos + 1;
						if pmeta[_quest] ~= nil then
							local _finished = _SEQ[_pos] == "1";
							local _line = _SEQ[_pos + 1];
							local _type = _SEQ[_pos + 2];
							local _id = _SEQ[_pos + 3];
							local _text = _SEQ[_pos + 4];
							OnCommQuestLine(name, _quest, tonumber(_line) or _line, _type, tonumber(_id) or _id, _text, _finished);
							-- _log_('|cff00ff7fV2-Q|r|cff00ffffLine|r', name, _quest, _line, _type, _id, _finished, _text);
						end
					end
					_pos = _pos + 5;
				elseif _head == ADDON_MSG_HEAD_PULL_V2 then
					local _prev = _NextPushSingle[name];
					if _prev == nil or _prev < GetTime() then
						_NextPushSingle[name] = GetTime() + 4;
						PushSingle(name);
					end
					if _Inited[name] == nil then
						PullSingle(name);
					end
					PushFlushBufferSingle(name);
				elseif _head == ADDON_MSG_HEAD_RESET_V2 then
					OnCommInit(name);
					_Inited[name] = GetTime();
					_log_('|cff00ff7fV2-Q|r|cffff7f00Reset|r', name);
				elseif _head == ADDON_MSG_HEAD_ONLINE_V2 then
					_log_('|cff00ff7fV2-Q|r|cff00ff7fOnline|r', name);
				else
					_log_('|cff00ff7fV2|r |cffff0000Invalid head|r', name, _pos - 1, _head, msg, strlen(msg));
					break;
				end
			end
		end
		local function OnCommQuestie(prefix, msg, channel, sender, target, zoneChannelID, localID, name, instanceID)
			-- _log_('|cff00ff7fOnCommQuestie|r', msg, name);
			__ns.ExternalQuestie._OnComm(msg, name, channel);
		end
	-->		control
		function DisableComm()
			is_comm_enabled = false;
			wipe(META);
			ResetUUID();
			__ns.PushAddQuest = noop;
			__ns.PushDelQuest = noop;
			__ns.PushAddLine = noop;
			__ns.PushFlushBuffer = noop;
			wipe(GROUP_MEMBERS);
		end
		function EnableComm()
			is_comm_enabled = true;
			__ns.PushAddQuest = PushAddQuest;
			__ns.PushDelQuest = PushDelQuest;
			__ns.PushAddLine = PushAddLine;
			__ns.PushFlushBuffer = PushFlushBuffer;
		end
	-->		group cache
		local PartyUnitsList = { 'party1', 'party2', 'party3', 'party4', };
		function UpdateGroupMembers()
			if is_comm_enabled then
				local _GROUP_MEMBERS = {  };
				for index = 1, 4 do
					local unit = PartyUnitsList[index];
					if UnitExists(unit) then
						local name, realm = UnitName(unit);
						if name == nil or name == "" then
							__eventHandler:run_on_next_tick(UpdateGroupMembers);
							return;
						end
						if realm ~= nil and realm ~= "" then
							name = name .. "-" .. realm;
						end
						local isconnected = UnitIsConnected(unit);
						if isconnected then
							if not GROUP_MEMBERS[name] then
								--	Add
								META[name] = {  };
								PullSingle(name, true);
								__ns.ExternalQuestie._PullSingle(name);
								PushSingle(name);
							end
							_GROUP_MEMBERS[name] = true;
						else
							if GROUP_MEMBERS[name] then
								--	Del
								CommDelUUID(name);
								META[name] = nil;
								_Inited[name] = nil;
								__ns.ExternalQuestie._DelUnit(name);
							end
							_GROUP_MEMBERS[name] = false;
						end
						GROUP_MEMBERS_INFO[name] = { index, unit, name, UnitClassBase(unit), };
					end
				end
				for name, val in next, GROUP_MEMBERS do
					if val and _GROUP_MEMBERS[name] == nil then
						--	Del
						CommDelUUID(name);
						META[name] = nil;
						_Inited[name] = nil;
						__ns.ExternalQuestie._DelUnit(name);
					end
				end
				GROUP_MEMBERS = _GROUP_MEMBERS;
				__ns.__comm_group_members = _GROUP_MEMBERS;
			end
		end
	-->		events and hooks
		-->		QUEST^questId^completed^action^numLines^title
		--			[completed]	-1 = failed, 0 = uncompleted, 1 = completed
		--			[action]	-1 = sub, 1 = add
		-->		LINE ^questId^finished ^line^type^id^text
		function __ns.CHAT_MSG_ADDON(prefix, msg, channel, sender, target, zoneChannelID, localID, name, instanceID)
			if prefix == ADDON_PREFIX_V2 then
				local name = Ambiguate(sender, 'none');
				if name ~= __core._PLAYER_NAME and GROUP_MEMBERS[name] ~= nil then
					OnCommCodexLiteV2(prefix, msg, channel, sender, target, zoneChannelID, localID, name, instanceID);
				end
			elseif prefix == ADDON_PREFIX_V1 then
				local name = Ambiguate(sender, 'none');
				if name ~= __core._PLAYER_NAME and GROUP_MEMBERS[name] ~= nil then
					OnCommCodexLiteV1(prefix, msg, channel, sender, target, zoneChannelID, localID, name, instanceID);
				end
			elseif prefix == "questie" then
				local name = Ambiguate(sender, 'none');
				if name ~= __core._PLAYER_NAME and GROUP_MEMBERS[name] ~= nil then
					OnCommQuestie(prefix, msg, channel, sender, target, zoneChannelID, localID, name, instanceID);
				end
			end
		end
		function __ns.GROUP_ROSTER_UPDATE()
			if IsInRaid(LE_PARTY_CATEGORY_HOME) or UnitInBattleground('player') then
				DisableComm();
			else
				_log_('|cff00ff7fGROUP_ROSTER_UPDATE|r');
				EnableComm();
				__eventHandler:run_on_next_tick(UpdateGroupMembers);
			end
		end
		function __ns.GROUP_FORMED(category, partyGUID)
			if IsInRaid(LE_PARTY_CATEGORY_HOME) or UnitInBattleground('player') then
				DisableComm();
			else
				_log_('|cff00ff7fGROUP_JOINED|r', category, partyGUID);
				EnableComm();
			end
		end
		function __ns.GROUP_JOINED(category, partyGUID)
			if IsInRaid(LE_PARTY_CATEGORY_HOME) or UnitInBattleground('player') then
				DisableComm();
			else
				_log_('|cff00ff7fGROUP_JOINED|r', category, partyGUID);
				EnableComm();
				__eventHandler:run_on_next_tick(UpdateGroupMembers);
			end
		end
		function __ns.GROUP_LEFT(category, partyGUID)
			_log_('|cff00ff7fGROUP_LEFT|r', category, partyGUID);
			DisableComm();
		end
		function __ns.UNIT_CONNECTION(unit, isConnected)
			if is_comm_enabled then
				UpdateGroupMembers();
			end
		end
	-->
	function __ns.comm_setup()
		SET = __ns.__setting;
		DisableComm();
		local r1, r2 = RegisterAddonMessagePrefix(ADDON_PREFIX_V1), RegisterAddonMessagePrefix(ADDON_PREFIX_V2);
		if r1 or r2 then
			__eventHandler:RegEvent("CHAT_MSG_ADDON");
			-- __eventHandler:RegEvent("CHAT_MSG_ADDON_LOGGED");
			__eventHandler:RegEvent("GROUP_ROSTER_UPDATE");
			-- __eventHandler:RegEvent("GROUP_FORMED");
			__eventHandler:RegEvent("GROUP_JOINED");
			__eventHandler:RegEvent("GROUP_LEFT");
			__eventHandler:RegEvent("UNIT_CONNECTION");
			if IsInGroup(LE_PARTY_CATEGORY_HOME) and not IsInRaid(LE_PARTY_CATEGORY_HOME) and not UnitInBattleground('player') then
				EnableComm();
				__eventHandler:run_on_next_tick(UpdateGroupMembers);
				_log_("comm.init.ingroup");
			end
		end
		__ns.ExternalQuestie._Init(_Inited, META, OnCommInit, OnCommQuestAdd, OnCommQuestDel, OnCommQuestLine);
	end
-->

--[=[dev]=]	if __ns.__is_dev then __ns.__performance_log_tick('module.comm'); end
