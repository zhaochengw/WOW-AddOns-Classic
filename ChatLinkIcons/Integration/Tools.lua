--[[	ChatLinkIcons - Integration Tools
	by SDPhantom
	https://www.wowinterface.com/forums/member.php?u=34145
	https://www.curseforge.com/members/sdphantomgamer/projects	]]
--------------------------------------------------------------------------

local AddOn=select(2,...);
AddOn.IntegrationTools_MessageUpdateDispatcher=AddOn.Callbacks_New(); do
	AddOn.PlayerCache_OnPlayerAdded:Register(AddOn.IntegrationTools_MessageUpdateDispatcher);
	AddOn.Options_OnOptionsUpdate:Register(AddOn.IntegrationTools_MessageUpdateDispatcher);
end

function AddOn.IntegrationTools_FormatOptionLabel(addon)
	local name,title,_,_,reason=GetAddOnInfo(addon);
	return AddOn.Localization.OptionsSetting_Integration_Format:format(
		title or name or addon
		,reason and "ff0000" or "00ff00"
		,reason and _G["ADDON_"..reason] or AddOn.Localization.OptionsSetting_Integration_Loaded
	);
end
