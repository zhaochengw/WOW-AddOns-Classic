--[[	ChatLinkIcons - WIM Integration
	by SDPhantom
	https://www.wowinterface.com/forums/member.php?u=34145
	https://www.curseforge.com/members/sdphantomgamer/projects	]]
--------------------------------------------------------------------------

if not WIM then return; end
local AddOn=select(2,...);

hooksecurefunc(WIM,"CallModuleFunction",function(funcname,frame)
	if funcname=="OnWindowCreated" and frame then
--		Already checks if hooked before
		AddOn.Integration_DefaultUI_HookScrollingMessageFrame(frame.widgets.chat_display);
	end
end);
