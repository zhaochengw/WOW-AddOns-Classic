--[[--
	by ALA @ 163UI/网易有爱, http://wowui.w.163.com/163ui/
	CREDIT shagu/pfQuest(MIT LICENSE) @ https://github.com/shagu
--]]--
----------------------------------------------------------------------------------------------------
local __addon, __ns = ...;

local _G = _G;
local _ = nil;
--------------------------------------------------
--[=[dev]=]	if __ns.__is_dev then __ns._F_devDebugProfileStart('module.patch'); end

-->		variables
local next = next;
local tremove = table.remove;

local __db = __ns.db;
local __db_quest = __db.quest;
local __db_unit = __db.unit;
local __db_item = __db.item;
local __db_object = __db.object;
local __db_refloot = __db.refloot;
local __db_event = __db.event;
local __core = __ns.core;

if __ns.__is_dev then
	__ns:BuildEnv("patch");
end

-->		patch
	local function patchDB(fix)
		for key, patch in next, fix do
			local db = __db[key];
			if db ~= nil then
				for id, val in next, patch do
					local t = db[id];
					if t ~= nil then
						for k, v in next, val do
							if v == "_NIL" then
								t[k] = nil;
							else
								t[k] = v;
							end
						end
					else
						db[id] = val;
					end
				end
			end
		end
	end
	local function apply_patch()
		patchDB(__db.fix);
		if __core._PLAYER_FACTIONGROUP == "Alliance" then
			patchDB(__db.fix_alliance);
		else
			patchDB(__db.fix_horde);
		end
		for id, val in next, __db.waypoints do
			local waypoints = {  };
			for _, tbl in next, val do
				for _, p in next, tbl do
					waypoints[#waypoints + 1] = p;
				end
			end
			__db_unit[id] = __db_unit[id] or {  };
			__db_unit[id].waypoints = waypoints;
		end
	end
-->

-->
	local PreloadCoords = __core.PreloadCoords;
	local function PreloadAllCoords()
		local DB = { obj = __db_object, unit = __db_unit, };
		for key, db in next, DB do
			for id, info in next, db do
				PreloadCoords(info);
			end
		end
	end
	__core.PreloadAllCoords = PreloadAllCoords;
-->

__ns.apply_patch = apply_patch;

--[=[dev]=]	if __ns.__is_dev then __ns.__performance_log_tick('module.patch'); end
