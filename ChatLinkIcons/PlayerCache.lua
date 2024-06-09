--[[	ChatLinkIcons - Player Cache
	by SDPhantom
	https://www.wowinterface.com/forums/member.php?u=34145
	https://www.curseforge.com/members/sdphantomgamer/projects	]]
--------------------------------------------------------------------------

local AddOn=select(2,...);
AddOn.PlayerCache_OnPlayerAdded=AddOn.Callbacks_New();

local PlayerCache={};

local GuildRoster=GuildRoster or C_GuildInfo.GuildRoster;--	Blizzard removed the legacy location of this function in 9.0 while C_GuildInfo isn't available in Classic

------------------
--[[	API	]]
------------------
local function NormalizePlayerName(name) return (name:find("%-") and name) or (ServerTag and ("%s-%s"):format(name,ServerTag)); end

function AddOn.PlayerCache_AddPlayer(name,guid)
	if not (name and guid) then return; end
	name=NormalizePlayerName(name);
	if name and PlayerCache[name]~=guid then
		PlayerCache[name]=guid;
		AddOn.PlayerCache_OnPlayerAdded:Fire();
	end
end

function AddOn.PlayerCache_GetPlayerGUID(name)
	if not name then return; end
	name=NormalizePlayerName(name);
	return name and PlayerCache[name];
end

--------------------------
--[[	Event Handlers	]]
--------------------------
AddOn.Events_RegisterEvent("PLAYER_LOGIN",function(self,...)
	ServerTag=GetNormalizedRealmName();--	Update server tag
	AddOn.PlayerCache_AddPlayer(UnitName("player"),UnitGUID("player"));--	Register player GUID
	C_FriendList.ShowFriends();--	Request friend list
	GuildRoster();--	Request guild roster

	AddOn.Events_UnregisterEvent(self,"PLAYER_LOGIN");
end);

AddOn.Events_RegisterEvent("PLAYER_GUILD_UPDATE",function(self)
	GuildRoster();--	Player joined/left guild
end);

AddOn.Events_RegisterEvent("FRIENDLIST_UPDATE",function(self)
	for i=1,C_FriendList.GetNumFriends() do
		local info=C_FriendList.GetFriendInfoByIndex(i);
		if info and info.name and info.guid then AddOn.PlayerCache_AddPlayer(info.name,info.guid); end--	Register friend
	end
end);

AddOn.Events_RegisterEvent("GUILD_ROSTER_UPDATE",function(self,...)
--	(...) is true if the a refresh is needed, false if a refresh has been done
	if (...) then GuildRoster(); else
		for i=1,(GetNumGuildMembers()) do
			local name,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,guid=GetGuildRosterInfo(i);
			if name and guid then AddOn.PlayerCache_AddPlayer(name,guid); end--	Register guildmate
		end
	end
end);

do--	Chat Events
	local function OnChatEvent(self,_,name,_,_,_,_,_,_,_,_,_,guid)
		if (name or "")~="" and (guid or "")~="" then AddOn.PlayerCache_AddPlayer(name,guid); end
	end

--	CHAT_MSG_CHANNEL is registered by ChatFrame_OnLoad() and isn't included in the event tables
	if not ChatTypeGroupInverted.CHAT_MSG_CHANNEL then AddOn.Events_RegisterEvent("CHAT_MSG_CHANNEL",OnChatEvent); end
	for event in pairs(ChatTypeGroupInverted) do
		if event:find("^CHAT_MSG_") then AddOn.Events_RegisterEvent(event,OnChatEvent); end
	end
end
