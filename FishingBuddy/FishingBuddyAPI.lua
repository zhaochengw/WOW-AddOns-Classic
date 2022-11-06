--[[
Name: FishingBuddyApi-1.0
Maintainers: Sutorix <sutorix@hotmail.com>
Description: A library for the Fishing Buddy functions usable by plugins and other code.
Copyright (c) by Bob Schumaker
Licensed under a Creative Commons "Attribution Non-Commercial Share Alike" License
--]]

local MAJOR_VERSION = "FishingBuddyApi-1.0"
local MINOR_VERSION = 90000 + tonumber(("$Rev: 676 $"):match("%d+"))

if not LibStub then error(MAJOR_VERSION .. " requires LibStub") end

local FBAPI, oldLib = LibStub:NewLibrary(MAJOR_VERSION, MINOR_VERSION)
if not FBAPI then
	return
end

local FL = LibStub("LibFishing-1.0");

-- 5.0.4 has a problem with a global "_"
local _

-- Event handler support
function FBAPI:RegisterHandlers(handlers)
	FishingBuddy.RegisterHandlers(handlers);
end

function FBAPI:GetHandlers(what)
	return FishingBuddy.GetHandlers(what);
end

-- Settings support
function FBAPI:GetSettingBool(setting)
	return FishingBuddy.GetSettingBool(setting);
end

function FBAPI:GetSetting(setting)
	return FishingBuddy.GetSetting(setting);
end

function FBAPI:GetDefault(setting)
	return FishingBuddy.GetDefault(setting);
end

-- Identify Fishing Buddy
function FBAPI:GetKey()
	local key = FishingBuddy_Info["FishingBuddyKey"];
	if ( not key ) then
		-- This was removed in 3.1, lets just assume we have enough randomness already
		-- math.randomseed(time());
		-- generate a random key to identify this instance of the plugin
		local n = 16 + random(4) + random(4);
		key = "";
		for idx=1,n do
			key = key .. string.char(64+math.random(26));
		end
		FishingBuddy_Info["FishingBuddyKey"] = key;
	end
	return key;
end

function FBAPI:CheckForeignKey(foreignKey, foreignDate, saveKey)
	if ( not FishingBuddy_Info["ForeignKeys"] ) then
		FishingBuddy_Info["ForeignKeys"] = {};
	end
	if ( saveKey ) then
		FishingBuddy_Info["ForeignKeys"][foreignKey] = foreignDate;
		return;
	end
	if ( not FishingBuddy_Info["ForeignKeys"][foreignKey] ) then
		FishingBuddy_Info["ForeignKeys"][foreignKey] = foreignDate;
		return true;
	end
	return ( FishingBuddy_Info["ForeignKeys"][foreignKey] < foreignDate );
end

function FBAPI:ResetKey()
	FishingBuddy_Info["FishingBuddyKey"] = nil;
	local key = GetKey();
	if (FB_MergeDatabase) then
		FB_MergeDatabase.key = key;
	end
	FishingBuddy.Message("Key reset.");
	return key;
end

-- Miscellaneous functions
function FBAPI:IsSwitchClick(setting)
	if ( not setting ) then
		setting = "ClickToSwitch";
	end
	local a = IsShiftKeyDown();
	local b = FishingBuddy.GetSettingBool(setting);
	return ( (a and (not b)) or ((not a) and b) );
end

function FBAPI:IsQuestFish(id)
	return FishingBuddy.IsQuestFish(id);
end

function FBAPI:IsCountedFish(id)
	return FishingBuddy.IsCountedFish(id);
end

function FBAPI:ReadyForFishing()
	return FishingBuddy.ReadyForFishing();
end

function FBAPI:AreWeFishing()
	return FishingBuddy.AreWeFishing();
end
