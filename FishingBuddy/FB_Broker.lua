local ldb = LibStub:GetLibrary("LibDataBroker-1.1")
local FL = LibStub:GetLibrary("LibFishing-1.0")

local FBAPI = LibStub("FishingBuddyApi-1.0", true);
local FBConstants = FBAPI.FBConstants;

-- Temporary, until we're pretty sure everyone has upgraded
local function RegisterHandlers(...)
	if (FBAPI) then
		return FBAPI:RegisterHandlers(...);
	end
end

local function Do_OnClick(self, button)
	if ( FBAPI and FBAPI:IsLoaded() ) then
		if ( button == "LeftButton" ) then
			if ( FBAPI:IsSwitchClick() ) then
				FBAPI:Command(FBConstants.SWITCH)
			else
				FBAPI:Command("")
			end
		else
			local enu = FB_Broker_Menu
			if (not menu) then
				menu = CreateFrame("FRAME", "FB_Broker_Menu", self, "UIDropDownMenuTemplate")
				UIDropDownMenu_Initialize(menu,
											function()
												FBAPI:MakeDropDown(FBConstants.CLICKTOSWITCH_ONOFF, "ClickToSwitch")
											end,
											"MENU")
			end
			menu.point = "TOPRIGHT"
			menu.relativePoint = "CENTER"
			ToggleDropDownMenu(1, nil, menu, self, 0, 0)
		end
	end
end

local dataobj = ldb:NewDataObject("Fishing Broker", {
    type = "data source",
    icon = "Interface\\Icons\\Trade_Fishing",
    OnClick = Do_OnClick,
    tocname = "FB_Broker",
    label = PROFESSIONS_FISHING
})

local f = CreateFrame("frame")
f.dataobj = dataobj

f:RegisterEvent("VARIABLES_LOADED")

function dataobj:OnTooltipShow()
    local hint
    if ( FBAPI and FBAPI:IsLoaded() ) then
		if ( FBAPI:IsSwitchClick() ) then
			hint = FBConstants.TOOLTIP_HINTSWITCH
		else
			hint = FBConstants.TOOLTIP_HINTTOGGLE
		end
	else
		local _, fishing = FL:GetFishingSpellInfo()
		hint = CHAT_MSG_SKILL.." ("..fishing..")"
	end
	self:AddLine(FL:Green(hint))
end

function dataobj:UpdateSkill()
	local isfishing = (FBAPI and FBAPI:AreWeFishing());
    local line = FL:GetFishingSkillLine(1, false, isfishing)
    local caughtSoFar, needed = FL:GetSkillUpInfo()
	if ( needed and caughtSoFar ) then
		line = line.." ("..caughtSoFar.."/~"..needed..")"
	end
	self.text = line
	self.label = PROFESSIONS_FISHING
end

local FishingEvents = {};
if ( FBConstants ) then
	EventRegistry:RegisterCallback(FBConstants.FISHING_ENABLED_EVT, function()
		f.dataobj:UpdateSkill()
	end)
	
	EventRegistry:RegisterCallback(FBConstants.FISHING_DISABLED_EVT, function(started)
		f.dataobj:UpdateSkill()
	end)
end

FL.RegisterCallback('FB_Broker', FL.PLAYER_SKILL_READY, function()
	f.dataobj:UpdateSkill()
end);

f:SetScript("OnEvent", function(self, event, ...)
	if ( event == "VARIABLES_LOADED" ) then
		if ( not FB_BrokerData ) then
			FB_BrokerData = {};
		end
		self:RegisterEvent("SKILL_LINES_CHANGED")
		self:RegisterEvent("CHAT_MSG_SKILL")
		self:RegisterEvent("ZONE_CHANGED")
		self:RegisterEvent("ZONE_CHANGED_INDOORS")
		self:RegisterEvent("ZONE_CHANGED_NEW_AREA")
		self:RegisterEvent("LOOT_CLOSED")

		if ( FBConstants ) then
			RegisterHandlers(FishingEvents);
		end
	else
		self.dataobj:UpdateSkill()
	end
end)
