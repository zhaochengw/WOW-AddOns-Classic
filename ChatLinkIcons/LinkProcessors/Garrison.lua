--[[	ChatLinkIcons - Garrison Link Processor
	by SDPhantom
	https://www.wowinterface.com/forums/member.php?u=34145
	https://www.curseforge.com/members/sdphantomgamer/projects	]]
--------------------------------------------------------------------------

local AddOn=select(2,...);

AddOn.Options.Links_GarrisonFollower=true;
AddOn.Options.Links_GarrisonFollower_Ability=true;

AddOn.Options_CreateOptionButton(1,"Links_GarrisonFollower");
AddOn.Options_CreateOptionButton("Links_GarrisonFollower","Links_GarrisonFollower_Ability");

AddOn.LinkConverter_RegisterLinkProcessor("conduit",function(type,id,text,conduitid,conduitrank)--	(type,id,text,...)
	if not (AddOn.Options.Links_GarrisonFollower and AddOn.Options.Links_GarrisonFollower_Ability) then return; end
	return AddOn.LinkProcessorTools_CreateTextureMarkupFromSpellID(C_Soulbinds.GetConduitSpellID(tonumber(conduitid),conduitrank and tonumber(conduitrank)));
end);

AddOn.LinkConverter_RegisterLinkProcessor("garrfollower",function(_,_,_,followerid)
	if not AddOn.Options.Links_GarrisonFollower then return; end
	return AddOn.LinkProcessorTools_CreateTextureMarkup(C_Garrison.GetFollowerPortraitIconIDByID(tonumber(followerid)));
end);

AddOn.LinkConverter_RegisterLinkProcessor("garrfollowerability",function(_,_,_,abilityid)--	(type,id,text,...)
	if not (AddOn.Options.Links_GarrisonFollower and AddOn.Options.Links_GarrisonFollower_Ability) then return; end
	return AddOn.LinkProcessorTools_CreateTextureMarkup(C_Garrison.GetFollowerAbilityIcon(tonumber(abilityid)));
end);
