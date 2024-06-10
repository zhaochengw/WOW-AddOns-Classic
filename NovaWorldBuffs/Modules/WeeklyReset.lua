-------------------
---NovaWorldBuffs--
-------------------

local addonName, addon = ...;
local NWB = addon.a;
local L = LibStub("AceLocale-3.0"):GetLocale("NovaWorldBuffs");

local regionName;
function NWB:setRegionName()
	regionName = NWB.LibRealmInfo:GetCurrentRegion();
end

function NWB:getWeeklyReset()
	local serverTime = GetServerTime();
	if (not serverTime) then
		--If for some reason get server time fails do nothing and try again later.
		return;
	end
	local nextWeeklyReset, lastWeeklyReset;
	if (C_DateAndTime and C_DateAndTime.GetSecondsUntilWeeklyReset) then
		nextWeeklyReset = GetServerTime() + C_DateAndTime.GetSecondsUntilWeeklyReset();
		lastWeeklyReset = nextWeeklyReset - 604800;
	else
		local timeOfDay = serverTime + GetQuestResetTime();
		--Try get region by server namne first, for people playing EU client on US servers etc.
		if (not regionName) then
			regionName = NWB.LibRealmInfo:GetCurrentRegion();
		end
		--If lib fails use wow client api, less reliable since people can play cross region.
		if (not regionName) then
			local regions = {"US", "KR", "EU", "TW", "CN"}
			regionName = regions[GetCurrentRegion()]
		end
		local regionDays = {
	    	["US"] = "Tuesday",
	    	["EU"] = "Wednesday",
	    	["KR"] = "Thursday",
	    	["TW"] = "Thursday",
	    	["CN"] = "Thursday",
		}
		local resetDay = regionDays[regionName];
		--If all fails just default to Tuesday.
		if (not resetDay) then
			resetDay = "Tuesday";
		end
		local day = date("!%A", timeOfDay);
		local nextWeeklyReset;
		if (day == resetDay) then
			--Current day is reset day.
			nextWeeklyReset = timeOfDay;
		else
			--If not current day then loop till we find it.
			for i = 1, 7 do
				timeOfDay = timeOfDay + 86400
				day = date("!%A", timeOfDay);
				if (day == resetDay) then
					--We're at reset day GMT in the loop, set the time.
					nextWeeklyReset = timeOfDay;
				end
			end
		end
		lastWeeklyReset = nextWeeklyReset - 604800;
	end
	--print("Next reset: " .. date("!%c", nextWeeklyReset));
	--print("Last reset: " .. date("!%c", lastWeeklyReset));
	--Round time back 1 second to show 02:00:00 instead of 02:00:01.
	return nextWeeklyReset, lastWeeklyReset;
end;

--Static timestamps in the past for each region when a 3 day reset happened to calc from.
local threeDayResetTimes = {
	["US"] = 1648479600, --Monday, March 28, 2022 15:00:00 UTC.
	--["EU"] = 1648717200, --Thursday, March 31, 2022 9:00:00 UTC. Given by a player, wrong I think?
	["EU"] = 1648717200, --Thursday, March 31, 2022 7:00:00 UTC.
	["KR"] = 0,
	["TW"] = 1648767600, --Thursday, March 31, 2022 23:00:00 UTC.
	["CN"] = 0,
};

function NWB:getThreeDayReset()
	--Try get region by server name first, for people playing EU client on US servers etc.
	if (not regionName) then
		regionName = NWB.LibRealmInfo:GetCurrentRegion();
	end
	--If lib fails use wow client api, less reliable since people can play cross region.
	if (not regionName) then
		local regions = {"US", "KR", "EU", "TW", "CN"}
		regionName = regions[GetCurrentRegion()]
	end
	--Get our static reset timestamp from the past.
	local staticPastResetTime = threeDayResetTimes[regionName] or 0;
	if (staticPastResetTime < 1) then
		return;
	end
	--Get current epoch.
	local utc = GetServerTime();
	local secondsSinceFirstReset = utc - staticPastResetTime;
	--Divide seconds elapsed since our static timestamp in the past by the cycle time (3 days).
	--Get the floor of secondsSinceFirstReset / cycle time
	--Divide seconds elapsed since our static timestamp in the past by the cycle time (3 days).
	--Get the floor of that result (which would be last reset if multipled by cycle time) then add 1 for next reset, then multiply by cycle time.
	local nextReset = staticPastResetTime + ((math.floor(secondsSinceFirstReset / 259200) + 1) * 259200);
	local lastReset = nextReset - 259200;
	return nextReset, lastReset;
end