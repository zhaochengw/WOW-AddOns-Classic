--[[--
	by ALA @ 163UI/网易有爱, http://wowui.w.163.com/163ui/
	CREDIT shagu/pfQuest(MIT LICENSE) @ https://github.com/shagu
--]]--
----------------------------------------------------------------------------------------------------
local __addon, __ns = ...;

if __ns.__dev then
	setfenv(1, __ns.__fenv);
end
local _G = _G;
local _ = nil;
----------------------------------------------------------------------------------------------------
--[=[dev]=]	if __ns.__dev then __ns._F_devDebugProfileStart('module.comm'); end

-->		variables
	local strfind = strfind;
	local next = next;
	local bit_band = bit.band;
	local Ambiguate = Ambiguate;
	local RegisterAddonMessagePrefix = RegisterAddonMessagePrefix or C_ChatInfo.RegisterAddonMessagePrefix;
	local IsAddonMessagePrefixRegistered = IsAddonMessagePrefixRegistered or C_ChatInfo.IsAddonMessagePrefixRegistered;
	local GetRegisteredAddonMessagePrefixes = GetRegisteredAddonMessagePrefixes or C_ChatInfo.GetRegisteredAddonMessagePrefixes;
	local SendAddonMessage = SendAddonMessage or C_ChatInfo.SendAddonMessage;
	local SendAddonMessageLogged = SendAddonMessageLogged or C_ChatInfo.SendAddonMessageLogged;
	local IsInGroup, IsInRaid = IsInGroup, IsInRaid;
	local LE_PARTY_CATEGORY_HOME = LE_PARTY_CATEGORY_HOME;
	local GetNumGroupMembers = GetNumGroupMembers;
	local GetRaidRosterInfo = GetRaidRosterInfo;

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

	local _F_SafeCall = __ns.core._F_SafeCall;
	local __eventHandler = __ns.core.__eventHandler;
	local __const = __ns.core.__const;
	local PreloadCoords = __ns.core.PreloadCoords;
	local IMG_INDEX = __ns.core.IMG_INDEX;
	local GetQuestStartTexture = __ns.core.GetQuestStartTexture;

	local __core_meta = __ns.__core_meta;

	local UnitHelpFac = __ns.core.UnitHelpFac;
	local _log_ = __ns._log_;

	local SET = nil;
	local PLAYER_NAME = UnitName('player');

-->		MAIN
	local ADDON_PREFIX = "CDXLT1";
	local ADDON_MSG_CONTROL_CODE_LEN = 6;
	local ADDON_MSG_CTRLCODE_PUSH = "_push_";
	local ADDON_MSG_CTRLCODE_PULL = "_pull_";
	local ADDON_MSG_CTRLCODE_RESET = "_rst__";
	local ADDON_MSG_CTRLCODE_ONLINE = "_conn_";
	local META = {  };	--	[quest_id] = { [flag:whether_nodes_added], [completed], [num_lines], [line(1, 2, 3, ...)] = { shown, objective_type, objective_id, description, finished, is_large_pin, progress, required, }, }
	local OBJ_LOOKUP = {  };
	__ns.__comm_meta = META;
	__ns.__comm_obj_lookup = OBJ_LOOKUP;
	local GROUP_MEMBERS = {  };
	__ns.__comm_group_members = GROUP_MEMBERS;
	local GROUP_MEMBERS_INFO = {  };
	__ns.__comm_group_members_info = GROUP_MEMBERS_INFO;
	-->		function predef
		local CommDelUUID, CommAddUUID, CommSubUUID, CommGetUUID, ResetUUID;
		local GetVariedNodeTexture, AddCommonNodes, DelCommonNodes, AddLargeNodes, DelLargeNodes, AddVariedNodes, DelVariedNodes;
		local AddUnit, DelUnit, AddObject, DelObject, AddRefloot, DelRefloot, AddItem, DelItem, AddEvent, DelEvent;
		local AddQuester_VariedTexture, DelQuester_VariedTexture, AddQuestStart, DelQuestStart, AddQuestEnd, DelQuestEnd;
		local AddLine, DelLine;
		local MessageTicker, ScheduleMessage;
		local PushReset, PushAddQuest, PushDelQuest, PushAddLine, PushResetSingle, PushAddQuestSingle, PushDelQuestSingle, PushAddLineSingle, Push, Pull, PushSingle, PullSingle, BroadcastOnline;
		local DisableComm, EnableComm;
		local UpdateGroupMembers;
	-->
	local noop = function() end
	local is_comm_enabled = false;
	-->		--	uuid:{ 1type, 2id, 3color3(run-time), 4{ [quest] = { [line] = TEXTURE, }, }, }
	-->		--	line:	'start', 'end', >=1:line_quest_leader, 'event'
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
		function AddUnit(name, quest, line, uid, show_coords, large_pin, showFriend)
			local info = __db_unit[uid];
			if info ~= nil then
				if showFriend ~= nil then
					local isFriend = nil;
					if info.fac == nil then
						if info.facId ~= nil then
							local _, _, standing_rank, _, _, val = GetFactionInfoByID(info.facId);
							if val > 0 then
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
			end
		end
		function DelUnit(name, quest, line, uid, total_del, large_pin)
			if large_pin then
				DelLargeNodes(name, 'unit', uid, quest, line, total_del);
			else
				DelCommonNodes(name, 'unit', uid, quest, line, total_del);
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
			end
			local name = __loc_object[oid];
			if name ~= nil then
				OBJ_LOOKUP[name] = oid;
			end
		end
		function DelObject(name, quest, line, oid, total_del, large_pin)
			if large_pin then
				DelLargeNodes(name, 'object', oid, quest, line, total_del);
			else
				DelCommonNodes(name, 'object', oid, quest, line, total_del);
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
		function AddEvent(name, quest)
			local info = __db_quest[quest];
			local obj = info.obj;
			if obj ~= nil then
				local E = obj.E;
				if E ~= nil then
					local coords = E.coords;
					if coords == nil then
						coords = {  };
						for index = 1, #E do
							local event = __db_event[E[index]];
							if event ~= nil then
								local cs = event.coords;
								if cs ~= nil and cs[1] ~= nil then
									for j = 1, #cs do
										coords[#coords + 1] = cs[j];
									end
								end
							end
						end
						E.coords = coords;
						PreloadCoords(E);
					end
					if coords ~= nil and coords[1] ~= nil then
						AddLargeNodes(name, 'event', quest, quest, 'event', nil);
					end
				end
			end
		end
		function DelEvent(name, quest)
			local info = __db_quest[quest];
			local obj = info.obj;
			if obj ~= nil then
				local E = obj.E;
				if E ~= nil then
					local coords = E.coords;
					if coords ~= nil and coords[1] ~= nil then
						DelLargeNodes(name, 'event', quest, quest, 'event');
					end
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
		function AddQuestStart(name, quest_id, info, TEXTURE)
			AddQuester_VariedTexture(name, quest_id, info.start, 'start', TEXTURE or GetQuestStartTexture(info));
		end
		function DelQuestStart(name, quest_id, info)
			DelQuester_VariedTexture(name, quest_id, info.start, 'start');
		end
		function AddQuestEnd(name, quest_id, info, TEXTURE)
			AddQuester_VariedTexture(name, quest_id, info["end"], 'end', TEXTURE);
		end
		function DelQuestEnd(name, quest_id, info)
			DelQuester_VariedTexture(name, quest_id, info["end"], 'end');
		end
	-->
	-->		line	-1 = Quest Giver	-2 = Quest Completer	0 = event
		function AddLine(name, _quest, _line, _type, _id, finished)
			if finished then
				_log_('AddLine-T_T', name, _type, _id);
			else
				_log_('AddLine-T_F', name, _type, _id);
			end
			if _type == 'monster' then
				local large_pin = __db_large_pin:Check(_quest, 'unit', _id);
				AddUnit(name, _quest, _line, _id, not finished, large_pin, nil);
				return true, _id, large_pin;
			elseif _type == 'item' then
				local large_pin = __db_large_pin:Check(_quest, 'item', _id);
				AddItem(name, _quest, _line, _id, not finished, large_pin);
				return true, _id, large_pin;
			elseif _type == 'object' then
				local large_pin = __db_large_pin:Check(_quest, 'object', _id);
				AddObject(name, _quest, _line, _id, not finished, large_pin);
				return true, _id, large_pin;
			elseif _type == 'event' or _type == 'log' then
				AddEvent(name, _quest);
			elseif _type == 'reputation' then
			elseif _type == 'player' or _type == 'progressbar' then
			else
				_log_('comm_objective_type', _quest, finished, _type);
			end
			return true;
		end
		function DelLine(name, _quest, _line, _type, _id, total_del)
			if _type == 'monster' then
				local large_pin = __db_large_pin:Check(_quest, 'unit', _id);
				DelUnit(name, _quest, _line, _id, total_del, large_pin);
				return true, _id, large_pin;
			elseif _type == 'item' then
				local large_pin = __db_large_pin:Check(_quest, 'item', _id);
				DelItem(name, _quest, _line, _id, total_del, large_pin);
				return true, _id, large_pin;
			elseif _type == 'object' then
				local large_pin = __db_large_pin:Check(_quest, 'object', _id);
				DelObject(name, _quest, _line, _id, total_del, large_pin);
				return true, _id, large_pin;
			elseif _type == 'event' or _type == 'log' then
			elseif _type == 'reputation' then
			elseif _type == 'player' or _type == 'progressbar' then
			else
				_log_('comm_objective_type', _quest, _type, _id);
			end
			return true;
		end
	-->
	-->		net buffer
		local C_Timer_After = C_Timer.After;
		local MessageBuffer = {  };
		local MessageTop = 0;
		local SchedulerRunning = false;
		function MessageTicker()
			local msg = tremove(MessageBuffer, 1);
			MessageTop = MessageTop - 1;
			if MessageBuffer[1] ~= nil then
				SchedulerRunning = true;
				C_Timer_After(0.02, MessageTicker);
			else
				SchedulerRunning = false;
			end
			SendAddonMessage(ADDON_PREFIX, msg[1], msg[2], msg[3]);
		end
		function ScheduleMessage(msg, channel, target)
			MessageTop = MessageTop + 1;
			MessageBuffer[MessageTop] = { msg, channel, target, };
			if not SchedulerRunning then
				SchedulerRunning = true;
				C_Timer_After(0.02, MessageTicker);
			end
		end
	-->
	-->		comm
		function PushReset()
			for name, val in next, GROUP_MEMBERS do
				if val then
					ScheduleMessage(ADDON_MSG_CTRLCODE_RESET, "WHISPER", name);
				end
			end
		end
		function PushAddQuest(_quest, _completed, title, num_lines)
			local msg = ADDON_MSG_CTRLCODE_PUSH .. "^QUEST^" .. _quest .. "^" .. _completed .. "^1^" .. num_lines .. "^" .. title;
			for name, val in next, GROUP_MEMBERS do
				if val then
					ScheduleMessage(msg, "WHISPER", name);
				end
			end
			_log_('comm.PushAddQuest', msg);
		end
		function PushDelQuest(_quest, _completed)
			local msg = ADDON_MSG_CTRLCODE_PUSH .. "^QUEST^" .. _quest .. "^" .. _completed .. "^-1";
			for name, val in next, GROUP_MEMBERS do
				if val then
					ScheduleMessage(msg, "WHISPER", name);
				end
			end
			_log_('comm.PushAddQuest', msg);
		end
		function PushAddLine(_quest, _line, _finished, _type, _id, _text)
			local msg = ADDON_MSG_CTRLCODE_PUSH .. "^LINE^" .. _quest .. (_finished and "^1^" or "^0^") .. _line .. "^" .. _type .. "^" .. _id .. "^" .. _text;
			for name, val in next, GROUP_MEMBERS do
				if val then
					ScheduleMessage(msg, "WHISPER", name);
				end
			end
			_log_('comm.PushAddLine', msg);
		end
		--
		function PushResetSingle(name)
			ScheduleMessage(ADDON_MSG_CTRLCODE_RESET, "WHISPER", name);
		end
		function PushAddQuestSingle(name, _quest, _completed, title, num_lines)
			local msg = ADDON_MSG_CTRLCODE_PUSH .. "^QUEST^" .. _quest .. "^" .. _completed .. "^1^" .. num_lines .. "^" .. title;
			ScheduleMessage(msg, "WHISPER", name);
			_log_('comm.PushAddQuest', msg);
		end
		function PushDelQuestSingle(name, _quest, _completed)
			local msg = ADDON_MSG_CTRLCODE_PUSH .. "^QUEST^" .. _quest .. "^" .. _completed .. "^-1";
			ScheduleMessage(msg, "WHISPER", name);
			_log_('comm.PushAddQuest', msg);
		end
		function PushAddLineSingle(name, _quest, _line, _finished, _type, _id, _text)
			local msg = ADDON_MSG_CTRLCODE_PUSH .. "^LINE^" .. _quest .. (_finished and "^1^" or "^0^") .. _line .. "^" .. _type .. "^" .. _id .. "^" .. _text;
			ScheduleMessage(msg, "WHISPER", name);
			_log_('comm.PushAddLine', msg);
		end
		--
		function Push()
			_log_('comm.|cffff0000Push|r');
			PushReset();
			for quest, meta in next, __core_meta do
				PushAddQuest(quest, meta.completed, meta.title, meta.num_lines);
				for line = 1, #meta do
					local meta_line = meta[line];
					if meta_line[3] ~= nil then
						PushAddLine(quest, line, meta_line[5], meta_line[2], meta_line[3], meta_line[4]);
					end
				end
			end
		end
		function Pull()
			_log_('comm.|cffff0000Pull|r');
			for name, val in next, GROUP_MEMBERS do
				ScheduleMessage(ADDON_MSG_CTRLCODE_PULL, "WHISPER", name);
			end
		end
		function PushSingle(name)
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
		end
		function PullSingle(name)
			_log_('comm.|cffff0000PullSingle|r', name);
			ScheduleMessage(ADDON_MSG_CTRLCODE_PULL, "WHISPER", name);
		end
		function BroadcastOnline()
			_log_('comm.|cffff0000BroadcastOnline|r');
			for name, val in next, GROUP_MEMBERS do
				ScheduleMessage(ADDON_MSG_CTRLCODE_ONLINE, "WHISPER", name);
			end
		end
	-->		control
		function DisableComm()
			is_comm_enabled = false;
			wipe(META);
			ResetUUID();
			__ns.PushAddQuest = noop;
			__ns.PushDelQuest = noop;
			__ns.PushAddLine = noop;
		end
		function EnableComm()
			is_comm_enabled = true;
			__ns.PushAddQuest = PushAddQuest;
			__ns.PushDelQuest = PushDelQuest;
			__ns.PushAddLine = PushAddLine;
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
								PullSingle(name);
								PushSingle(name);
							end
							_GROUP_MEMBERS[name] = true;
						else
							if GROUP_MEMBERS[name] then
								--	Del
								CommDelUUID(name);
								META[name] = nil;
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
			if prefix == ADDON_PREFIX then
				local name = Ambiguate(sender, 'none');
				if name ~= PLAYER_NAME then
					_log_('|cff00ff7fMSGA|r', msg, name);
					local control_code = strsub(msg, 1, ADDON_MSG_CONTROL_CODE_LEN);
					if control_code == ADDON_MSG_CTRLCODE_PUSH then
					--  local _, _head, _quest, _done, _val, _type, _id, _text = strsplit("^", msg);
						local _, _head, _quest, _1,    _2,   _3,    _4,  _5 = strsplit("^", msg);
						local meta_table = META[name];
						if meta_table ~= nil then
							if _head == "QUEST" then
								_quest = tonumber(_quest);
								local _completed = tonumber(_1);	--	-1 = failed, 0 = uncompleted, 1 = completed
								local _act = tonumber(_2);			--	1 = add, -1 = del
								local _num_lines = tonumber(_3);	--	num_lines
								local _title = _4;					--	title
								if _act == -1 then
									local meta = meta_table[_quest];
									meta_table[_quest] = nil;
									for index2 = 1, meta.num_lines do
										local meta_line = meta[index2];
										if meta_line ~= nil then
											DelLine(name, _quest, index2, meta_line[2], meta_line[3], true);
										end
									end
									local info = __db_quest[_quest];
									if info ~= nil then
										-- DelQuestStart(name, _quest, info);
										DelQuestEnd(name, _quest, info);
									end
								elseif _act == 1 then
									local meta = meta_table[_quest];
									if meta == nil then
										meta_table[_quest] = { completed = _completed, title = _title, num_lines = _num_lines, };
									else
										meta.completed = _completed;
										meta.title = _title;
									end
									local info = __db_quest[_quest];
									if info ~= nil then
										-- AddQuestStart(name, _quest, info);
										AddQuestEnd(name, _quest, info, _completed == 1 and IMG_INDEX.IMG_E_COMPLETED or IMG_INDEX.IMG_E_UNCOMPLETED);
									end
								end
							elseif _head == "LINE" then
								_quest = tonumber(_quest);
								local meta = meta_table[_quest];
								if meta ~= nil then
									local finished = _1 == "1";
									local _line = tonumber(_2) or _2;
									local _type = _3;
									local _id = tonumber(_4);
									local _text = _5;
									local meta_line = meta[_line];
									if meta_line == nil then
										meta[_line] = { nil, _type, _id, _text, finished, };
									else
										meta_line[2] = _type;
										meta_line[3] = _id;
										meta_line[4] = _text;
										meta_line[5] = finished;
									end
									if _type == 'object' and __loc_object[id] ~= nil then
										OBJ_LOOKUP[__loc_object[id]] = id;
									end
									AddLine(name, _quest, _line, _type, _id, finished);
								end
							else
							end
						end
					elseif control_code == ADDON_MSG_CTRLCODE_PULL then
						if GROUP_MEMBERS[name] then
							PushSingle(name);
						end
					elseif control_code == ADDON_MSG_CTRLCODE_RESET then
						if META[name] ~= nil then
							for _quest, meta in next, META[name] do
								for index2 = 1, meta.num_lines do
									local meta_line = meta[index2];
									if meta_line ~= nil then
										DelLine(name, _quest, index2, meta_line[2], meta_line[3], true);
									end
								end
								local info = __db_quest[_quest];
								if info ~= nil then
									-- DelQuestStart(name, _quest, info);
									DelQuestEnd(name, _quest, info);
								end
							end
						end
						META[name] = {  };
					elseif control_code == ADDON_MSG_CTRLCODE_ONLINE then
					end
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
		if RegisterAddonMessagePrefix(ADDON_PREFIX) then
			__eventHandler:RegEvent("CHAT_MSG_ADDON");
			-- __eventHandler:RegEvent("CHAT_MSG_ADDON_LOGGED");
			__eventHandler:RegEvent("GROUP_ROSTER_UPDATE");
			-- __eventHandler:RegEvent("GROUP_FORMED");
			__eventHandler:RegEvent("GROUP_JOINED");
			__eventHandler:RegEvent("GROUP_LEFT");
			__eventHandler:RegEvent("UNIT_CONNECTION");
			if IsInGroup(LE_PARTY_CATEGORY_HOME) and not IsInRaid(LE_PARTY_CATEGORY_HOME) then
				EnableComm();
				__eventHandler:run_on_next_tick(UpdateGroupMembers);
				_log_("comm.init.ingroup");
			end
		end
	end
-->

--[=[dev]=]	if __ns.__dev then __ns.__performance_log_tick('module.comm'); end
