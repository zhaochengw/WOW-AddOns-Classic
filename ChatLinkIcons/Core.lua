--[[	ChatLinkIcons Core
	by SDPhantom
	https://www.wowinterface.com/forums/member.php?u=34145
	https://www.curseforge.com/members/sdphantomgamer/projects	]]
--------------------------------------------------------------------------

--------------------------
--[[	Namespace	]]
--------------------------
local AddOn=select(2,...);

--------------------------
--[[	Other Locals	]]
--------------------------
local Signature="|c00434c49|r";--	Hex code for "CLI" as our signature (Lets us identify strings we processed already with a hidden tag)

local PawnIsLoaded=IsAddOnLoaded("Pawn");
local PawnUpgradeIcon=CreateAtlasMarkup("bags-greenarrow");

local OptionTypeLookup={
	currency="item";
	transmogappearance="item";

	BNplayer="player";
	BNplayerCommunity="player";
	playerCommunity="player";
	playerGM="player";

	enchant="spell";
	trade="spell";
	unit="player";
};

----------------------------------
--[[	PlayerCache Prescan	]]--	Prescan helps system messages get icons when someone logs in
----------------------------------
local GuildRoster=GuildRoster or C_GuildInfo.GuildRoster;--	Blizzard removed the legacy location of this function in 9.0 while C_GuildInfo isn't available in Classic

local ServerTag;
local PlayerCache=setmetatable({},{
	__index=function(t,k) return ServerTag and rawget(t,("%s-%s"):format(k,ServerTag)); end;
	__newindex=function(t,k,v)--	k=Name v=GUID
		if not k:find("%-") then
			if not ServerTag then return; end
			k=("%s-%s"):format(k,ServerTag);
		end
		rawset(t,k,v);
	end;
});

local EventFrame=CreateFrame("Frame");
EventFrame:RegisterEvent("PLAYER_LOGIN");
EventFrame:RegisterEvent("PLAYER_GUILD_UPDATE");
EventFrame:RegisterEvent("FRIENDLIST_UPDATE");
EventFrame:RegisterEvent("GUILD_ROSTER_UPDATE");
EventFrame:SetScript("OnEvent",function(self,event,...)
	if event=="PLAYER_LOGIN" then
		ServerTag=GetNormalizedRealmName();--	Update server tag
		PlayerCache[UnitName("player")]=UnitGUID("player");--	Register player GUID
		C_FriendList.ShowFriends();--	Request friend list
		GuildRoster();--	Request guild roster
	elseif event=="PLAYER_GUILD_UPDATE" then GuildRoster();--	Player joined/left guild
	elseif event=="FRIENDLIST_UPDATE" then
		for i=1,C_FriendList.GetNumFriends() do
			local info=C_FriendList.GetFriendInfoByIndex(i);
			if info and info.name and info.guid then PlayerCache[info.name]=info.guid; end--	Register friend
		end
	elseif event=="GUILD_ROSTER_UPDATE" then
--		(...) is true if the a refresh is needed, false if a refresh has been done
		if (...) then GuildRoster(); else
			for i=1,(GetNumGuildMembers()) do
				local name,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,guid=GetGuildRosterInfo(i);
				if name and guid then PlayerCache[name]=guid; end--	Register guildmate
			end
		end
	end
end);

--------------------------
--[[	Link Transform	]]
--------------------------
local function IsItemUpgrade(link)--	Modified PawnIsItemIDAnUpgrade() (Allows full links to compare upgraded items)
	if not (PawnIsLoaded and PawnIsReady() and link) then return nil; end
	local item=PawnGetItemData(link);
	if not item then return nil; end
	return PawnIsItemAnUpgrade(item) and true or false;
end

local function IconsFromGUID(guid)
	if not guid then return "",""; end
	local _,class,_,race,gender=GetPlayerInfoByGUID(guid);
	return (race and gender) and AddOn.RaceIcons[race..gender] or "",class and AddOn.ClassIcons[class] or "";
end

--	Texture generation functions
local TextureFunctions={
	achievement=function(id,text) return "|T"..select(10,GetAchievementInfo(tonumber(id:match("%d+"))))..":0|t"; end;
	calendarEvent=function(id,text)
		local offset,day,index=string.split(":",id);
		local event=C_Calendar.GetDayEvent(tonumber(offset),tonumber(day),tonumber(index));
		return event or ("|T%s:0|t"):format(event.iconTexture);
	end;

	currency=function(id,text)
		local info=C_CurrencyInfo.GetCurrencyInfo(tonumber(id:match("%d+")))
		return info and ("|T%s:0|t"):format(info.iconFileID);
	end;

	item=function(id,text) return ("|T%s:0|t"):format(GetItemIcon(tonumber(id:match("%d+")))); end;
	transmogappearance=function(id,text) return ("|T%s:0|t"):format(GetItemIcon(tonumber(select(6,C_TransmogCollection.GetAppearanceSourceInfo(tonumber(id))):match("|Hitem:(%d+)")))); end;

--[[	Disabled for now; This was always experimental as I've never had a way to reliably test it
	BNplayer=function(id,text)
		local bnetaccountid,client,online,guid=tonumber(id:match(":(%d+)"));
		if WOW_PROJECT_ID==WOW_PROJECT_MAINLINE then
			local accountinfo=C_BattleNet.GetAccountInfoByID(bnetaccountid);
			local gameinfo=accountinfo and accountinfo.gameAccountInfo;
			client,online,guid=gameinfo.clientProgram,gameinfo.isOnline,gameinfo.playerGuid;
		else
			local _,gameaccountid;
			_,_,_,_,_,gameaccountid,client,online=BNGetFriendInfoByID(bnetaccountid);
			_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,guid=BNGetGameAccountInfo(gameaccountid);
		end

		if not online then return BNet_GetClientEmbeddedTexture(nil); end
		if client~=BNET_CLIENT_WOW or not guid then return BNet_GetClientEmbeddedTexture(client); end

		local race,class=IconsFromGUID(guid);
		return (AddOn.Options.Icons.Race and race or "")..(AddOn.Options.Icons.Class and class or "");
	end;
--]]
	player=function(id,text) local race,class=IconsFromGUID(PlayerCache[id:match("[^:]+")]); return (AddOn.Options.Icons.Race and race or "")..(AddOn.Options.Icons.Class and class or ""); end;
	unit=function(id,text) local race,class=IconsFromGUID(id:match("[^:]+")); return (AddOn.Options.Icons.Race and race or "")..(AddOn.Options.Icons.Class and class or ""); end;

	spell=function(id,text) local icon=GetSpellTexture(tonumber(id:match("%d+"))); return icon and ("|T%s:0|t"):format(icon) or ""; end;
	trade=function(id,text) local icon=GetSpellTexture(tonumber(id:match(":(%d+)"))); return icon and ("|T%s:0|t"):format(icon) or ""; end;
};

if WOW_PROJECT_ID==WOW_PROJECT_MAINLINE then
	OptionTypeLookup.talent="spell";
	TextureFunctions.talent=function(id,text) return ("|T%s:0|t"):format(select(3,GetTalentInfoByID(tonumber(id:match("%d+"))))); end;
end

--	Shared functions
TextureFunctions["BNplayerCommunity"]=TextureFunctions["BNplayer"];
TextureFunctions["enchant"]=TextureFunctions["spell"];
TextureFunctions["playerCommunity"]=TextureFunctions["player"];
TextureFunctions["playerGM"]=TextureFunctions["player"];

local ConvertLinks; do--	function(str)
	local LinkPattern="(|H([^:|]+):([^|]-)|h(.-)|h)";

	local function Callback(link,type,id,text)--	Conversion Function
		local func=TextureFunctions[type];

--		Pawn Itegration (Append after all textures)
		local upgradeicon=(type=="item" and AddOn.Options.PawnIntegration and IsItemUpgrade("item:"..id)) and PawnUpgradeIcon or "";

--		Return if no function or link type is disabled
		if not func or AddOn.Options.Links[OptionTypeLookup[type] or type]==false then return link..upgradeicon; end

--		Rarely, the game doesn't give us the icons we need in the time we need them
--		Leting any error halt conversion and return
		local ok,pre,post=xpcall(func,CallErrorHandler,id,text);
		if not ok then return link..upgradeicon; end

--		Return modified link
		return ("%s%s%s%s"):format(pre or "",link,post or "",upgradeicon);
	end

	function ConvertLinks(str)
		local fix; str,fix=str:gsub(LinkPattern,Callback);
		if fix>0 then
--			Fix some links relinking with textures and blocking the ability to send them (Blizzard seems to have fixed this, but still doing it to preserve legacy behavior)
			repeat str,fix=str:gsub("(|c%x%x%x%x%x%x%x%x)(%s*|T[^|]*|t%s*)","%2%1"); until fix<=0
			repeat str,fix=str:gsub("(%s*|T[^|]*|t%s*)(|r)","%2%1"); until fix<=0
		end
		return str;
	end
end

--------------------------
--[[	Message Hooks	]]
--------------------------
hooksecurefunc("GetColoredName",function(_,_,name,_,_,_,_,_,_,_,_,_,guid)
	if (name or "")~="" and (guid or "")~="" then PlayerCache[name]=guid; end
end);

local function ScrollingMessageFrame_HistoryBuffer_OnPush(self,element) element.message=ConvertLinks(element.message); end
hooksecurefunc(ScrollingMessageFrameMixin,"OnPreLoad",function(self)
	hooksecurefunc(self.historyBuffer,"PushFront",ScrollingMessageFrame_HistoryBuffer_OnPush);
	hooksecurefunc(self.historyBuffer,"PushBack",ScrollingMessageFrame_HistoryBuffer_OnPush);
end);
for i=1,NUM_CHAT_WINDOWS do
	if i~=2 then--	Skip combat log
		local chatframe=_G["ChatFrame"..i];
		hooksecurefunc(chatframe.historyBuffer,"PushFront",ScrollingMessageFrame_HistoryBuffer_OnPush);
		hooksecurefunc(chatframe.historyBuffer,"PushBack",ScrollingMessageFrame_HistoryBuffer_OnPush);
	end
end
