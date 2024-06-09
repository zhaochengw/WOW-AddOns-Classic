--[[	ChatLinkIcons - Battle Pet Link Processor
	by SDPhantom
	https://www.wowinterface.com/forums/member.php?u=34145
	https://www.curseforge.com/members/sdphantomgamer/projects	]]
--------------------------------------------------------------------------

local AddOn=select(2,...);

AddOn.Options.Links_BattlePet=true;
AddOn.Options.Links_BattlePet_Ability=true;

AddOn.Options_CreateOptionButton(1,"Links_BattlePet");
AddOn.Options_CreateOptionButton("Links_BattlePet","Links_BattlePet_Ability");

AddOn.LinkConverter_RegisterLinkProcessor("battlepet",function(_,_,_,speciesid)--	(type,id,text,...)
	if not AddOn.Options.Links_BattlePet then return; end
	local info=C_PetJournal.GetPetInfoBySpeciesID(tonumber(speciesid));
	return info and AddOn.LinkProcessorTools_CreateTextureMarkup(select(2,info.speciesIcon));
end);

AddOn.LinkConverter_RegisterLinkProcessor("battlePetAbil",function(_,_,_,abilityid)--	(type,id,text,...)
	if not (AddOn.Options.Links_BattlePet and AddOn.Options.Links_BattlePet_Ability) then return; end
	return AddOn.LinkProcessorTools_CreateTextureMarkup(select(2,C_PetJournal.GetPetAbilityInfo(tonumber(abilityid))));
end);
