--[[	ChatLinkIcons - Achievement Link Processor
	by SDPhantom
	https://www.wowinterface.com/forums/member.php?u=34145
	https://www.curseforge.com/members/sdphantomgamer/projects	]]
--------------------------------------------------------------------------

local AddOn=select(2,...);

AddOn.Options.Links_Achievement=true;

AddOn.Options_CreateOptionButton(1,"Links_Achievement");

AddOn.LinkConverter_RegisterLinkProcessor("achievement",function(_,_,_,achievementid)--	(type,id,text,...)
	if not AddOn.Options.Links_Achievement then return; end
	return AddOn.LinkProcessorTools_CreateTextureMarkup(select(10,GetAchievementInfo(tonumber(achievementid))));
end);
