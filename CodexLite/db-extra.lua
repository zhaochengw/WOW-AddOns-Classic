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
--------------------------------------------------
--[=[dev]=]	if __ns.__dev then __ns._F_devDebugProfileStart('module.db-extra'); end

local tremove = tremove;
local __db = __ns.db;
local __db_quest = __db.quest;
local __db_unit = __db.unit;
local __db_item = __db.item;
local __db_object = __db.object;
local __db_refloot = __db.refloot;
local __db_event = __db.event;

local __bit_check_race = __ns.core.__bit_check_race;
local __bit_check_class = __ns.core.__bit_check_class;
local __bit_check_race_class = __ns.core.__bit_check_race_class;

local blacklist_quest = __db.blacklist_quest;
local blacklist_item = __db.blacklist_item;

local chain_prev_quest = {  };
__db.chain_prev_quest = chain_prev_quest;

local item_related_quest = {  };
__db.item_related_quest = item_related_quest;

local avl_quest_list = {  };
local avl_quest_hash = {  };
__db.avl_quest_list = avl_quest_list;
__db.avl_quest_hash = avl_quest_hash;
local strfind = strfind;
local function check(tbl, key, str)
	if tbl.U then
		for _, unit in next, tbl.U do
			local uinfo = __db_unit[unit];
			if uinfo ~= nil and uinfo[key] ~= -1 then
				return true;
			end
		end
	end
	if tbl.O then
		for _, obj in next, tbl.O do
			local oinfo = __db_object[obj];
			if oinfo ~= nil then
				local fac = oinfo['fac'];
				if fac == nil or strfind(fac, str) then
					return true;
				end
			end
		end
	end
	return false;
end
local function load_extra_db()
	for quest, info in next, __db_quest do
		local _next = info.next;
		if _next ~= nil then
			chain_prev_quest[_next] = quest;
		end
	end
	--[=[dev]=]	if __ns.__dev then __ns.__performance_start('module.init.init.extra_db.faction'); end
	-->		faction quest list
		local key = UnitFactionGroup('player') == "Alliance" and "facA" or "facH";
		local str = UnitFactionGroup('player') == "Alliance" and "A" or "H";
		for quest, info in next, __db_quest do
			if blacklist_quest[quest] == nil then
				local info = __db_quest[quest];
				local race = info.race;
				local class = info.class;
				if (race == nil or __bit_check_race(race)) and (class == nil or __bit_check_class(class)) then
					local _start = info['start'];
					local _end = info['end'];
					if (_start and check(_start, key, str)) or (_end and check(_end, key, str)) then
						avl_quest_list[#avl_quest_list + 1] = quest;
						avl_quest_hash[quest] = 1;
					end
				end
			end
		end
	-->
	--[=[dev]=]	if __ns.__dev then __ns.__performance_log_tick('module.init.init.extra_db.faction'); end
	--[=[dev]=]	if __ns.__dev then __ns.__performance_start('module.init.init.extra_db.item2quest'); end
	-->		item to quest
		for quest, info in next, __db_quest do
			if blacklist_quest[quest] == nil then
				local _obj = info['obj'];
				if _obj ~= nil then
					if _obj.I ~= nil then
						for _obj, item in next, _obj.I do
							local v = item_related_quest[item];
							if v == nil then
								v = {  };
								item_related_quest[item] = v;
							end
							v[#v + 1] = quest;
						end
					end
				end
				local _start = info['start'];
				if _start ~= nil then
					if _start.I ~= nil then
						for _start, item in next, _start.I do
							local v = item_related_quest[item];
							if v == nil then
								v = {  };
								item_related_quest[item] = v;
							end
							v[#v + 1] = quest;
						end
					end
				end
			end
		end
	-->
	--[=[dev]=]	if __ns.__dev then __ns.__performance_log_tick('module.init.init.extra_db.item2quest'); end
	--[=[dev]=]	if __ns.__dev then __ns.__performance_start('module.init.init.extra_db.del_unused'); end
	-->		del unused
		-->		cache
		local temp_U = {  };
		local temp_I = {  };
		local temp_O = {  };
		for quest, info in next, __db_quest do
			local _obj = info['obj'];
			if _obj ~= nil then
				if _obj.U ~= nil then
					for _, v in next, _obj.U do
						temp_U[v] = 1;
					end
				end
				if _obj.I ~= nil then
					for _, v in next, _obj.I do
						temp_I[v] = 1;
					end
				end
				if _obj.O ~= nil then
					for _, v in next, _obj.O do
						temp_O[v] = 1;
					end
				end
			end
			local _start = info['start'];
			if _start ~= nil then
				if _start.U ~= nil then
					for _, v in next, _start.U do
						temp_U[v] = 1;
					end
				end
				if _start.I ~= nil then
					for _, v in next, _start.I do
						temp_I[v] = 1;
					end
				end
				if _start.O ~= nil then
					for _, v in next, _start.O do
						temp_O[v] = 1;
					end
				end
			end
			local _end = info['end'];
			if _end ~= nil then
				if _end.U ~= nil then
					for _, v in next, _end.U do
						temp_U[v] = 1;
					end
				end
				if _end.O ~= nil then
					for _, v in next, _end.O do
						temp_O[v] = 1;
					end
				end
			end
		end
		local temp_R = {  };
		for item, _ in next, temp_I do
			local info = __db_item[item];
			if info ~= nil then
				if info.I ~= nil then
					for v, _ in next, info.I do
						temp_I[v] = 1;
					end
				end
				if info.R ~= nil then
					for v, _ in next, info.R do
						temp_R[v] = 1;
					end
				end
			end
		end
		for item, _ in next, temp_I do
			local info = __db_item[item];
			if info ~= nil then
				if info.U ~= nil then
					for v, _ in next, info.U do
						temp_U[v] = 1;
					end
				end
				if info.O ~= nil then
					for v, _ in next, info.O do
						temp_O[v] = 1;
					end
				end
				if info.V ~= nil then
					for v, _ in next, info.V do
						temp_U[v] = 1;
					end
				end
			end
		end
		for ref, _ in next, temp_R do
			local info = __db_refloot[ref];
			if info ~= nil then
				if info.U ~= nil then
					for v, _ in next, info.U do
						temp_U[v] = 1;
					end
				end
				if info.O ~= nil then
					for v, _ in next, info.O do
						temp_O[v] = 1;
					end
				end
			end
		end
		-->		del
		for unit, _ in next, __db_unit do
			if temp_U[unit] == nil then
				__db_unit[unit] = nil;
			end
		end
		for item, _ in next, __db_item do
			if temp_I[item] == nil then
				__db_item[item] = nil;
			end
		end
		for obj, _ in next, __db_object do
			if temp_O[obj] == nil then
				__db_object[obj] = nil;
			end
		end
		for ref, _ in next, __db_refloot do
			if temp_R[ref] == nil then
				__db_refloot[ref] = nil;
			end
		end
		-->
		collectgarbage('collect');
	-->
	--[=[dev]=]	if __ns.__dev then __ns.__performance_log_tick('module.init.init.extra_db.del_unused'); end
end

__ns.load_extra_db = load_extra_db;

--[=[dev]=]	if __ns.__dev then __ns.__performance_log_tick('module.db-extra'); end
