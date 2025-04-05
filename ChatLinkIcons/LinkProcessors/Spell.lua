--[[	ChatLinkIcons - Spell Link Processor
	by SDPhantom
	https://www.wowinterface.com/forums/member.php?u=34145
	https://www.curseforge.com/members/sdphantomgamer/projects	]]
--------------------------------------------------------------------------

local AddOn=select(2,...);

AddOn.Options.Links_Spell=true;

AddOn.Options_CreateOptionButton(1,"Links_Spell");

AddOn.LinkConverter_RegisterLinkProcessor("azessence",function(_,_,_,essenceid)--	(type,id,text,...)
	if not AddOn.Options.Links_Spell then return; end
	local info=C_AzeriteEssence.GetEssenceInfo(tonumber(essenceid));
	return info and AddOn.LinkProcessorTools_CreateTextureMarkup(info.icon);
end);

AddOn.LinkConverter_RegisterLinkProcessor("spell",function(_,_,_,spellid)--	(type,id,text,...)
	if not AddOn.Options.Links_Spell then return; end
	return AddOn.LinkProcessorTools_CreateTextureMarkupFromSpellID(tonumber(spellid));
end);

if WOW_PROJECT_ID==WOW_PROJECT_MAINLINE then
	AddOn.LinkConverter_RegisterLinkProcessor("talent",function(_,_,_,talentid)--	(type,id,text,...)
		if not AddOn.Options.Links_Spell then return; end
		return AddOn.LinkProcessorTools_CreateTextureMarkup(select(3,GetTalentInfoByID(tonumber(talentid))));
	end);
end
