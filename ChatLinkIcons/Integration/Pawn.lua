--[[	ChatLinkIcons - Pawn Integration
	by SDPhantom
	https://www.wowinterface.com/forums/member.php?u=34145
	https://www.curseforge.com/members/sdphantomgamer/projects	]]
--------------------------------------------------------------------------

local AddOn=select(2,...);

AddOn.Options.Integration_Pawn=true;

local Loaded=IsAddOnLoaded("Pawn");
local Button=AddOn.Options_CreateOptionButton(2,"Integration_Pawn",AddOn.IntegrationTools_FormatOptionLabel("Pawn"));
Button:SetEnabled(Loaded);
if not Loaded then return; end

local UpgradeIcon=CreateAtlasMarkup("bags-greenarrow");
local function IsItemUpgrade(link)--	Modified PawnIsItemIDAnUpgrade() (Allows full links to compare upgraded items)
	if not (PawnIsLoaded and PawnIsReady() and link) then return nil; end
	local item=PawnGetItemData(link);
	if not item then return nil; end
	return PawnIsItemAnUpgrade(item) and true or false;
end

AddOn.LinkConverter_RegisterLinkProcessor("item",function(_,id)
	if AddOn.Options.Integrations_Pawn and IsItemUpgrade("item:"..id) then
		return nil,UpgradeIcon;
	end
end);

AddOn.Events_RegisterEvent("PLAYER_EQUIPMENT_CHANGED",AddOn.IntegrationTools_MessageUpdateDispatcher);
