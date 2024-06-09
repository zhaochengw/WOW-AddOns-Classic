--[[	ChatLinkIcons - Tradeskill Link Processor
	by SDPhantom
	https://www.wowinterface.com/forums/member.php?u=34145
	https://www.curseforge.com/members/sdphantomgamer/projects	]]
--------------------------------------------------------------------------

local AddOn=select(2,...);

AddOn.Options.Links_Tradeskill=true;

AddOn.Options_CreateOptionButton(1,"Links_Tradeskill");

AddOn.LinkConverter_RegisterLinkProcessor("enchant",function(_,id,text,enchantid)--	(type,id,text,...)
	if not AddOn.Options.Links_Tradeskill then return; end
	AddOn.LinkProcessorTools_CreateTextureMarkupFromSpellID(tonumber(enchantid));
end);

AddOn.LinkConverter_RegisterLinkProcessor("trade",function(_,id,text,_,spellid)--	(type,id,text,...)
	if not AddOn.Options.Links_Tradeskill then return; end
	AddOn.LinkProcessorTools_CreateTextureMarkupFromSpellID(tonumber(spellid));
end);
