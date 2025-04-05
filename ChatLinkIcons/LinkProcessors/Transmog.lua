--[[	ChatLinkIcons - Transmog Link Processor
	by SDPhantom
	https://www.wowinterface.com/forums/member.php?u=34145
	https://www.curseforge.com/members/sdphantomgamer/projects	]]
--------------------------------------------------------------------------

local AddOn=select(2,...);

AddOn.Options.Links_Transmog=true;

AddOn.Options_CreateOptionButton(1,"Links_Transmog");

AddOn.LinkConverter_RegisterLinkProcessor("transmogappearance",function(_,_,_,sourceid)--	(type,id,text,...)
	if not AddOn.Options.Links_Transmog then return; end
	return AddOn.LinkProcessorTools_CreateTextureMarkup(select(4,C_TransmogCollection.GetAppearanceSourceInfo(tonumber(sourceid))));
end);

AddOn.LinkConverter_RegisterLinkProcessor("transmogillusion",function(_,_,_,illusionid)--	(type,id,text,...)
	if not AddOn.Options.Links_Transmog then return; end
	local info=C_TransmogCollection.GetIllusionInfo(tonumber(illusionid));
	return info and AddOn.LinkProcessorTools_CreateTextureMarkup(info.icon);
end);
