ExoLink = LibStub("AceAddon-3.0"):NewAddon("ExoLink")

local addonName, addonTable = ...

local eventframe = CreateFrame("FRAME", addonName .. "Events")
local isGuildRoll = false

local function getPlayerName(nameWithRealm)
	local name, realm = strsplit("-", nameWithRealm)
	if realm == GetRealmName() then
		name = strsplit("-", nameWithRealm)
	end
	return name
end

local function onEvent(self,event,...)
    if event == "CHAT_MSG_SYSTEM" then
		local message = ...
		local playername = UnitName("player")
		
		if string.match(message, playername .. "Roll") then
			eventframe:UnregisterEvent("CHAT_MSG_SYSTEM")
			local roll = string.match(message, "%d+")
			local nameWithRealm
			
			if (isGuildRoll) then
				nameWithRealm = GetGuildRosterInfo(roll)
			else
				nameWithRealm = GetRaidRosterInfo(roll)
			end
			
			DEFAULT_CHAT_FRAME:AddMessage(getPlayerName(nameWithRealm) .. " 赢得了roll点")
		end
--	elseif event == "CHAT_MSG_ADDON" then
--		local prefix, message, distributionType, sender = ...
--		
--		if prefix == addonName then
--			if message == "SYNC" then
--				DEFAULT_CHAT_FRAME:AddMessage("Ok " .. sender .. " I will sync")
--			end
--		end
    end
end

local function roll(isGuild, rollMax)
	eventframe:RegisterEvent("CHAT_MSG_SYSTEM")
	isGuildRoll = isGuild
	RandomRoll(1, rollMax)
end

eventframe:RegisterEvent("CHAT_MSG_ADDON")
eventframe:SetScript("OnEvent", onEvent)

SLASH_GUILDROLL1 = '/guildroll'
SLASH_RAIDROLL1 = '/raidroll'
--SLASH_EXO1 = '/exo'


--function SlashCmdList.EXO(msg)
--	C_ChatInfo.SendAddonMessage(addonName, msg, "GUILD" )
--end

function SlashCmdList.GUILDROLL(msg)
	GuildRoster()
	local _, _, numOnline = GetNumGuildMembers()
	if numOnline == 0 then
		DEFAULT_CHAT_FRAME:AddMessage("You're not in a guild.")
	else
		roll(true, numOnline)
	end
end

function SlashCmdList.RAIDROLL(msg)
	local number = GetNumGroupMembers()
	if number == 0 then
		DEFAULT_CHAT_FRAME:AddMessage("You're not in a group.")
	else
		roll(false, number)
	end
end