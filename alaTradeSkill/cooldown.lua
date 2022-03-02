--[[--
	by ALA @ 163UI
--]]--

local __addon__, __namespace__ = ...;
local __db__ = __namespace__.__db__;

-->		upvalue
	local rawget = rawget;
	local next = next;
	local wipe = table.wipe;
	local GetServerTime, GetTime = GetServerTime, GetTime;

	local _G = _G;
-->


local GetSpellModifiedCooldown = __ala_meta__.GetSpellModifiedCooldown;


local VAR = nil;


local F = CreateFrame('FRAME');
F:SetScript("OnEvent", function(self, event, ...)
	return self[event](...);
end);


-->		****************
__namespace__:BuildEnv("cooldown");
-->		****


local T_TradeSkill_CooldownList = __db__.T_TradeSkill_CooldownList;

for pid, list in next, T_TradeSkill_CooldownList do
	for index = 1, #list do
		local data = list[index];
		data[2] = __db__.get_learn_rank_by_sid(data[1]) or data[2];
	end
end

local function F_CheckCooldown(pid, var)
	local list = T_TradeSkill_CooldownList[pid];
	if list ~= nil then
		local cool = var[3];
		if cool ~= nil then
			wipe(cool);
		else
			cool = {  };
			var[3] = cool;
		end
		for index = 1, #list do
			local data = list[index];
			local sid = data[1];
			if var.cur_rank ~= nil and var.cur_rank >= data[2] then
				local cooling, start, duration = GetSpellModifiedCooldown(sid);
				if cooling then
					cool[sid] = GetServerTime() + duration + start - GetTime();
				else
					cool[sid] = -1;
				end
			else
				cool[sid] = nil;
			end
		end
	end
end

function F.BAG_UPDATE_COOLDOWN(...)
	for pid = __db__.DBMINPID, __db__.DBMAXPID do
		local var = rawget(VAR, pid);
		if var and __db__.is_pid(pid) then
			F_CheckCooldown(pid, var);
		end
	end
end

__namespace__.F_CheckCooldown = F_CheckCooldown;
function __namespace__.init_cooldown()
	VAR = __namespace__.VAR;
	F:RegisterEvent("BAG_UPDATE_COOLDOWN");
end
