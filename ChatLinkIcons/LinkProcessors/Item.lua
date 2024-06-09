--[[	ChatLinkIcons - Item Link Processor
	by SDPhantom
	https://www.wowinterface.com/forums/member.php?u=34145
	https://www.curseforge.com/members/sdphantomgamer/projects	]]
--------------------------------------------------------------------------

local AddOn=select(2,...);

AddOn.Options.Links_Item=true;

AddOn.Options_CreateOptionButton(1,"Links_Item");

AddOn.LinkConverter_RegisterLinkProcessor("currency",function(_,_,_,currencyid)--	(type,id,text,...)
	if not AddOn.Options.Links_Item then return; end
	local info=C_CurrencyInfo.GetCurrencyInfo(tonumber(currencyid));
	return info and AddOn.LinkProcessorTools_CreateTextureMarkup(info.iconFileID);
end);

AddOn.LinkConverter_RegisterLinkProcessor("item",function(_,_,_,itemid)--	(type,id,text,...)
	if not AddOn.Options.Links_Item then return; end
	return AddOn.LinkProcessorTools_CreateTextureMarkupFromItemID(tonumber(itemid));
end);
