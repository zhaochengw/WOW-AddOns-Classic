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
	local rawget = rawget;
	local next = next;
	local tremove, wipe = table.remove, table.wipe;
	local GetServerTime, GetTime = GetServerTime, GetTime;
	local CreateFrame = CreateFrame;

	local _G = _G;

-->
	local DataAgent = DT.DataAgent;

-->
MT.BuildEnv("cooldown");
-->

local GetSpellModifiedCooldown = MT.GetTradeSkillSpellModifiedCooldown;

local F = CreateFrame('FRAME');
F:SetScript("OnEvent", function(self, event, ...)
	return self[event](...);
end);

local T_TradeSkill_CooldownList = DataAgent.T_TradeSkill_CooldownList;

for pid, list in next, T_TradeSkill_CooldownList do
	for index = #list, 1, -1 do
		local data = list[index];
		data[2] = data[2] or DataAgent.get_learn_rank_by_sid(data[1]);
		if data[2] == nil then
			tremove(list, index);
		end
	end
end

function MT.CheckCooldown(pid, var)
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
	for pid = DataAgent.DBMINPID, DataAgent.DBMAXPID do
		local var = rawget(VT.VAR, pid);
		if var and DataAgent.is_pid(pid) then
			MT.CheckCooldown(pid, var);
		end
	end
end

MT.RegisterOnInit('cooldown', function(LoggedIn)
	F:RegisterEvent("BAG_UPDATE_COOLDOWN");
end);
