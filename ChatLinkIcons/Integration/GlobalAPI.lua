--[[	ChatLinkIcons - Global API Bridge
	by SDPhantom
	https://www.wowinterface.com/forums/member.php?u=34145
	https://www.curseforge.com/members/sdphantomgamer/projects	]]
--------------------------------------------------------------------------

local AddOn=select(2,...);
ChatLinkIcons={};

ChatLinkIcons.ConvertLinks=AddOn.LinkConverter_ConvertLinks;
function ChatLinkIcons.RegisterForLinkUpates(func) AddOn.IntegrationTools_MessageUpdateDispatcher:Register(func); end
function ChatLinkIcons.UnregisterForLinkUpates(func) AddOn.IntegrationTools_MessageUpdateDispatcher:Unregister(func); end
