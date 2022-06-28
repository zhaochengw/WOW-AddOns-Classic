--[[--
	by ALA @ 163UI/网易有爱, http://wowui.w.163.com/163ui/
	CREDIT shagu/pfQuest(MIT LICENSE) @ https://github.com/shagu
--]]--
----------------------------------------------------------------------------------------------------
local __addon, __ns = ...;

local _G = _G;
local _ = nil;
--------------------------------------------------
--[=[dev]=]	if __ns.__is_dev then __ns._F_devDebugProfileStart('module.db-extra'); end

-->		variables
local collectgarbage = collectgarbage;
local date = date;
local next = next;
local tremove = table.remove;
local strfind = string.find;

local __db = __ns.db;
local __db_quest = __db.quest;
local __db_unit = __db.unit;
local __db_item = __db.item;
local __db_object = __db.object;
local __db_refloot = __db.refloot;
local __db_event = __db.event;

local __loc = __ns.L;

local __core = __ns.core;
local __bit_check_race = __core.__bit_check_race;
local __bit_check_class = __core.__bit_check_class;
local __bit_check_race_class = __core.__bit_check_race_class;

local blacklist_quest = __db.blacklist_quest;
local blacklist_item = __db.blacklist_item;

local _F_CorePrint = __ns._F_CorePrint;

local chain_prev_quest = {  };
__db.chain_prev_quest = chain_prev_quest;

local item_related_quest = {  };
__db.item_related_quest = item_related_quest;

local avl_quest_list = {  };
local avl_quest_hash = {  };
__db.avl_quest_list = avl_quest_list;
__db.avl_quest_hash = avl_quest_hash;

if __ns.__is_dev then
	__ns:BuildEnv("db-extra");
end

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

local EmptyInfo = {
	unit = { ["coords"] = {  }, },
	item = {},
	object = { ["coords"] = {  }, },
	refloot = {},
	event = { ["coords"] = {  }, },
};
local function MarkItemRelation(quest, item)
	local v = item_related_quest[item];
	if v == nil then
		v = {  };
		item_related_quest[item] = v;
	end
	local num = #v;
	for i = 1, num do
		if v[i] == quest then
			return;
		end
	end
	v[num + 1] = quest;
end
local MarkUnit, MarkItem, MarkObject, MarkRefloot, MarkEvent;
local HashUnit, HashItem, HashObject, HashRefloot, HashEvent = {  }, {  }, {  }, {  }, {  };
local Hash = { unit = HashUnit, item = HashItem, object = HashObject, refloot = HashRefloot, event = HashEvent, };
function MarkUnit(quest, unit)
	-- if HashUnit[unit] == nil then
		HashUnit[unit] = 1;
		local info = __db_unit[unit];
		if info ~= nil then
			local spawn = info.spawn;
			if spawn ~= nil then
				if spawn.U ~= nil then
					for unit, _ in next, spawn.U do
						MarkUnit(quest, unit);
					end
				end
				if spawn.O ~= nil then
					for object, _ in next, spawn.O do
						MarkObject(quest, object);
					end
				end
				if spawn.I ~= nil then
					for item, _ in next, spawn.I do
						MarkItem(quest, item);
					end
				end
			end
		end
	-- end
end
function MarkItem(quest, item, spawned)
	-- if HashItem[item] == nil then
		HashItem[item] = 1;
		local info = __db_item[item];
		if info ~= nil then
			if info.U ~= nil then
				for unit, _ in next, info.U do
					MarkUnit(quest, unit);
				end
			end
			if info.O ~= nil then
				for object, _ in next, info.O do
					MarkObject(quest, object);
				end
			end
			if info.I ~= nil then
				for item, _ in next, info.I do
					MarkItem(quest, item);
				end
			end
			if info.R ~= nil then
				for ref, _ in next, info.R do
					MarkRefloot(quest, ref);
				end
			end
			if info.V ~= nil then
				for unit, _ in next, info.V do
					MarkUnit(quest, unit);
				end
			end
		end
	-- end
	if spawned == nil or spawned < 2 then
		MarkItemRelation(quest, item);
	end
end
function MarkObject(quest, object)
	-- if HashObject[object] == nil then
		HashObject[object] = 1;
		local info = __db_object[object];
		if info ~= nil then
			local spawn = info.spawn;
			if spawn ~= nil then
				if spawn.U ~= nil then
					for unit, _ in next, spawn.U do
						MarkUnit(quest, unit);
					end
				end
				if spawn.O ~= nil then
					for object, _ in next, spawn.O do
						MarkObject(quest, object);
					end
				end
				if spawn.I ~= nil then
					for item, _ in next, spawn.I do
						MarkItem(quest, item);
					end
				end
			end
		end
	-- end
end
function MarkRefloot(quest, ref)
	-- if HashRefloot[ref] == nil then
		local info = __db_refloot[ref];
		if info ~= nil then
			if info.U ~= nil then
				for unit, _ in next, info.U do
					MarkUnit(quest, unit);
				end
			end
			if info.O ~= nil then
				for object, _ in next, info.O do
					MarkObject(quest, object);
				end
			end
		end
	-- end
end
function MarkEvent(quest, event)
	HashEvent[event] = 1;
		local info = __db_event[event];
		if info ~= nil then
			local spawn = info.spawn;
			if spawn ~= nil then
				if spawn.U ~= nil then
					for unit, _ in next, spawn.U do
						MarkUnit(quest, unit);
					end
				end
				if spawn.O ~= nil then
					for object, _ in next, spawn.O do
						MarkObject(quest, object);
					end
				end
				if spawn.I ~= nil then
					for item, _ in next, spawn.I do
						MarkItem(quest, item);
					end
				end
			end
		end
end
local function load_extra_db()
	for quest, info in next, __db_quest do
		local _next = info.next;
		if _next ~= nil then
			chain_prev_quest[_next] = quest;
		end
	end
	local __db_worldevent = __db.worldevent;
	local __db_worldeventperiod = __db.worldeventperiod;
	local today = date("*t");
	local year, month, day, wday = today.year, today.month, today.day, today.wday;
	for event, limits in next, __db_worldeventperiod do
		local limit = limits[year] or limits["*"];
		if limit == nil or
			(limit[1] <= limit[3] and (month < limit[1] or month > limit[3])) or
			(month < limit[1] and month > limit[3]) or
			(month == limit[1] and day < limit[2]) or
			(month == limit[3] and day > limit[4])
		then
		else
			local eventquests = __db_worldevent[event];
			for _, quest in next, eventquests do
				blacklist_quest[quest] = nil;
			end
		end
	end
	--[=[dev]=]	if __ns.__is_dev then __ns.__performance_start('module.init.init.extra_db.faction'); end
	-->		faction quest list
		local key = __core._PLAYER_FACTIONGROUP == "Alliance" and "facA" or "facH";
		local str = __core._PLAYER_FACTIONGROUP == "Alliance" and "A" or "H";
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
	--[=[dev]=]	if __ns.__is_dev then __ns.__performance_log_tick('module.init.init.extra_db.faction'); end
	--[=[dev]=]	if __ns.__is_dev then __ns.__performance_start('module.init.init.extra_db.mark'); end
	-->		mark
		-->		cache
		for quest, info in next, __db_quest do
			local _obj = info['obj'];
			if _obj ~= nil then
				if _obj.U ~= nil then
					for _, unit in next, _obj.U do
						MarkUnit(quest, unit);
					end
				end
				if _obj.I ~= nil then
					for _, item in next, _obj.I do
						MarkItem(quest, item);
					end
				end
				if _obj.IR ~= nil then
					for _, item in next, _obj.IR do
						-- HashItem[item] = 1;
						MarkItemRelation(quest, item);
					end
				end
				if _obj.O ~= nil then
					for _, object in next, _obj.O do
						MarkObject(quest, object);
					end
				end
				if _obj.E ~= nil then
					for _, event in next, _obj.E do
						MarkEvent(quest, event);
					end
				end
			end
			local _start = info['start'];
			if _start ~= nil then
				if _start.U ~= nil then
					for _, unit in next, _start.U do
						MarkUnit(quest, unit);
					end
				end
				if _start.I ~= nil then
					for _, item in next, _start.I do
						MarkItem(quest, item);
					end
				end
				if _start.O ~= nil then
					for _, object in next, _start.O do
						MarkObject(quest, object);
					end
				end
			end
			local _end = info['end'];
			if _end ~= nil then
				if _end.U ~= nil then
					for _, unit in next, _end.U do
						MarkUnit(quest, unit);
					end
				end
				if _end.O ~= nil then
					for _, object in next, _end.O do
						MarkObject(quest, object);
					end
				end
			end
			local _extra = info['extra'];
			if _extra ~= nil then
				if _extra.U ~= nil then
					for unit in next, _extra.U do
						MarkUnit(quest, unit);
					end
				end
				if _extra.I ~= nil then
					for item in next, _extra.I do
						MarkItem(quest, item);
					end
				end
				if _extra.IR ~= nil then
					for item in next, _extra.IR do
						-- HashItem[item] = 1;
						MarkItemRelation(quest, item);
					end
				end
				if _extra.O ~= nil then
					for object in next, _extra.O do
						MarkObject(quest, object);
					end
				end
				if _extra.E ~= nil then
					for event in next, _extra.E do
						MarkEvent(quest, event);
					end
				end
			end
		end
		-->		proc db
		for which, hash in next, Hash do
			local info = EmptyInfo[which];
			local db = __db[which];
			local loc = __loc[which];
			if loc == nil then
				for id, _ in next, hash do
					db[id] = db[id] or info;
				end
			else
				for id, _ in next, hash do
					db[id] = db[id] or info;
					loc[id] = loc[id] or which .. ":" .. id;
				end
			end
			for id, _ in next, db do
				if hash[id] == nil then
					db[id] = nil;
				end
			end
		end
		-->
		MarkUnit, MarkItem, MarkObject, MarkRefloot, MarkEvent = nil;
		HashUnit, HashItem, HashObject, HashRefloot, HashEvent = nil;
		Hash = nil;
		-->
		collectgarbage('collect');
	-->
	-->		item-drop
		for iid, info in next, __db_item do
			if info.U ~= nil then
				local throttle = false;
				local U = info.U;
				local O = info.O;
				if O ~= nil then
					for oid, r in next, O do
						if r >= 25 then
							throttle = true;
							break;
						end
					end
				end
				if not throttle then
					for uid, r in next, U do
						if r >= 25 then
							throttle = true;
							break;
						end
					end
				end
				if throttle then
					for uid, r in next, U do
						if r <= 2 then
							U[uid] = nil;
						end
					end
					if O ~= nil then
						for oid, r in next, O do
							if r <= 2 then
								O[oid] = nil;
							end
						end
					end
				end
			end
		end
	-->
	--[=[dev]=]	if __ns.__is_dev then __ns.__performance_log_tick('module.init.init.extra_db.mark'); end
end


local function VerifyData()
	_F_CorePrint("|cffff7f00Start|r |cffff0000VerifyData|r");
	local vitem, vobject, vunit, vrefloot;
	local VI, VO, VU, VR = {  }, {  }, {  }, {  };
	function vitem(t, k, id, hu, hi, ho, path)
		if blacklist_item[id] or VI[id] then
			return;
		end
		path = path .. " item:" .. id;
		local spawn = __db_item[id];
			if spawn ~= nil then
				if hi[id] then
					return _F_CorePrint("|cffff0000SpawnError|r", path, hi[id]);
				end
				hi[id] = true;
				if spawn.U ~= nil then
					for unit, _ in next, spawn.U do
						vunit(t, k, unit, hu, hi, ho, path);
					end
				end
				if spawn.O ~= nil then
					for object, _ in next, spawn.O do
						vobject(t, k, object, hu, hi, ho, path);
					end
				end
				if spawn.I ~= nil then
					for item, _ in next, spawn.I do
						vitem(t, k, item, hu, hi, ho, path);
					end
				end
				hi[id] = nil;
			end
		VI[id] = true;
	end
	function vobject(t, k, id, hu, hi, ho, path)
		if VO[id] then
			return;
		end
		path = path .. " object:" .. id;
		local info = __db_object[id];
		if info ~= nil then
			local spawn = info.spawn;
			if spawn ~= nil then
				if ho[id] then
					return _F_CorePrint("|cffff0000SpawnError|r", path, ho[id]);
				end
				ho[id] = true;
				if spawn.U ~= nil then
					for unit, _ in next, spawn.U do
						vunit(t, k, unit, hu, hi, ho, path);
					end
				end
				if spawn.O ~= nil then
					for object, _ in next, spawn.O do
						vobject(t, k, object, hu, hi, ho, path);
					end
				end
				if spawn.I ~= nil then
					for item, _ in next, spawn.I do
						vitem(t, k, item, hu, hi, ho, path);
					end
				end
				ho[id] = nil;
			end
		end
		VO[id] = true;
	end
	function vunit(t, k, id, hu, hi, ho, path)
		if VU[id] then
			return;
		end
		path = path .. " unit:" .. id;
		local info = __db_unit[id];
		if info ~= nil then
			local spawn = info.spawn;
			if spawn ~= nil then
				if hu[id] then
					return _F_CorePrint("|cffff0000SpawnError|r", path, hu[id]);
				end
				hu[id] = true;
				if spawn.U ~= nil then
					for unit, _ in next, spawn.U do
						vunit(t, k, unit, hu, hi, ho, path);
					end
				end
				if spawn.O ~= nil then
					for object, _ in next, spawn.O do
						vobject(t, k, object, hu, hi, ho, path);
					end
				end
				if spawn.I ~= nil then
					for item, _ in next, spawn.I do
						vitem(t, k, item, hu, hi, ho, path);
					end
				end
				hu[id] = nil;
			end
		end
		VU[id] = true;
	end
	function vrefloot(t, k, id, hu, hi, ho, path)
		if VR[id] then
			return;
		end
		path = path .. " refloot:" .. id;
		local info = __db_refloot[id];
		if info ~= nil then
			if info.U ~= nil then
				for unit, _ in next, info.U do
					vunit(t, k, unit, hu, hi, ho, path);
				end
			end
			if info.O ~= nil then
				for object, _ in next, info.O do
					vobject(t, k, object, hu, hi, ho, path);
				end
			end
		end
		VR[id] = true;
	end
	for unit, info in next, __db_unit do
		vunit('unit', unit, unit, {  }, {  }, {  }, "");
	end
	for item, info in next, __db_item do
		vitem('item', item, item, {  }, {  }, {  }, "");
	end
	for object, info in next, __db_object do
		vobject('object', object, object, {  }, {  }, {  }, "");
	end
	_F_CorePrint("|cff00ff00Finish|r |cffff0000VerifyData|r");
end


__ns.load_extra_db = function()
	if __ns.__is_dev then
		VerifyData();
	end
	load_extra_db();
end

--[=[dev]=]	if __ns.__is_dev then __ns.__performance_log_tick('module.db-extra'); end
