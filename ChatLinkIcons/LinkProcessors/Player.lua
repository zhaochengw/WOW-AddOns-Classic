--[[	ChatLinkIcons - Player Link Processor
	by SDPhantom
	https://www.wowinterface.com/forums/member.php?u=34145
	https://www.curseforge.com/members/sdphantomgamer/projects	]]
--------------------------------------------------------------------------

local AddOn=select(2,...);

AddOn.Options.Links_Player=true;
AddOn.Options.Links_Player_Race=true;
AddOn.Options.Links_Player_Class=true;

AddOn.Options_CreateOptionButton(1,"Links_Player");
AddOn.Options_CreateOptionButton("Links_Player","Links_Player_Race",AddOn.Localization.OptionsSetting_Links_Player_RaceGender);
AddOn.Options_CreateOptionButton("Links_Player","Links_Player_Class");

local function PlayerProcessor(_,_,_,name)--	(type,id,text,...)
	if not AddOn.Options.Links_Player then return; end
	return AddOn.LinkProcessorTools_CreateTextureMarkupFromPlayerName(name);
end

AddOn.LinkConverter_RegisterLinkProcessor("player",PlayerProcessor);
AddOn.LinkConverter_RegisterLinkProcessor("playerCommunity",PlayerProcessor);
AddOn.LinkConverter_RegisterLinkProcessor("playerGM",PlayerProcessor);
AddOn.LinkConverter_RegisterLinkProcessor("unit",function(_,_,_,guid)--	(type,id,text,...)
	if not AddOn.Options.Links_Player then return; end
	return AddOn.LinkProcessorTools_CreateTextureMarkupFromPlayerGUID(guid);
end);

--[[	Disabled for now; This was always experimental as I've never had a way to reliably test it
local function BNPlayerProcessor(_,_,_,_,bnetaccountid)--	(type,id,text,...)
	if not AddOn.Options.Links_Player then return; end

	local client,online,guid;
	if WOW_PROJECT_ID==WOW_PROJECT_MAINLINE then
		local accountinfo=C_BattleNet.GetAccountInfoByID(tonumber(bnetaccountid));
		local gameinfo=accountinfo and accountinfo.gameAccountInfo;
		client,online,guid=gameinfo.clientProgram,gameinfo.isOnline,gameinfo.playerGuid;
	else
		local _,gameaccountid;
		_,_,_,_,_,gameaccountid,client,online=BNGetFriendInfoByID(tonumber(bnetaccountid));
		_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,guid=BNGetGameAccountInfo(gameaccountid);
	end

	if not online then return BNet_GetClientEmbeddedTexture(nil); end
	if client~=BNET_CLIENT_WOW or not guid then return BNet_GetClientEmbeddedTexture(client); end

	return AddOn.LinkProcessorTools_CreateTextureMarkupFromPlayerGUID(guid);
end

AddOn.LinkConverter_RegisterLinkProcessor("BNplayer",BNPlayerProcessor);
AddOn.LinkConverter_RegisterLinkProcessor("BNplayerCommunity",BNPlayerProcessor);
--]]
