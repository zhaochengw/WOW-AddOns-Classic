local ldb = LibStub:GetLibrary("LibDataBroker-1.1")
local FL = LibStub:GetLibrary("LibFishing-1.0")

local FBAPI = LibStub("FishingBuddyApi-1.0", true);

-- Temporary, until we're pretty sure everyone has upgraded
local function RegisterHandlers(...)
	if (FBAPI) then
		return FBAPI:RegisterHandlers(...);
	elseif ( FishingBuddy and FishingBuddy.API ) then
		return FishingBuddy.API.RegisterHandlers(...);
	end
end

local function Do_OnClick(self, button)
	if ( FishingBuddy and FishingBuddy.IsLoaded() ) then
		if ( button == "LeftButton" ) then
			if ( FishingBuddy.IsSwitchClick() ) then
				FishingBuddy.Command(FBConstants.SWITCH)
			else
				FishingBuddy.Command("")
			end
		else
			local switchSetting = "ClickToSwitch";
			local menu;
			
			if (FishingBuddy.GetDropDown) then
				menu = FishingBuddy.GetDropDown(FBConstants.CLICKTOSWITCH_ONOFF, switchSetting)
			else
				menu = FB_Broker_Menu
				if (not menu) then
					menu = CreateFrame("FRAME", "FB_Broker_Menu", self, "UIDropDownMenuTemplate")
					UIDropDownMenu_Initialize(menu,
											  function()
												FishingBuddy.MakeDropDown(FBConstants.CLICKTOSWITCH_ONOFF, switchSetting)
											  end,
											  "MENU")
				end
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
    if ( FishingBuddy and FishingBuddy.IsLoaded() ) then
		if ( FishingBuddy.IsSwitchClick() ) then
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
	local isfishing = (FishingBuddy and FishingBuddy.AreWeFishing and FishingBuddy.AreWeFishing());
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
	FishingEvents[FBConstants.FISHING_ENABLED_EVT] = function()
		f.dataobj:UpdateSkill()
	end
	
	FishingEvents[FBConstants.FISHING_DISABLED_EVT] = function(started)
		f.dataobj:UpdateSkill()
	end
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
