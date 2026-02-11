local AddonName, AddonTable = ...
local L = AddonTable.Localize
local AddonTitle = select(2, GetAddOnInfo(AddonName))
local PlainAddonTitle = AddonTitle:gsub("|c........", ""):gsub("|r", "")

local TextOnXPBar = MainMenuExpBar:CreateFontString("ExperienceLeft", "OVERLAY", "GameTooltipText")
TextOnXPBar:SetFont("Fonts\\ARIALN.TTF", 14, "THINOUTLINE")
TextOnXPBar:SetPoint("CENTER", 0, 0)
TextOnXPBar:SetTextColor(1,1,1,1)

local XPBarTextFrame = CreateFrame("Frame")
XPBarTextFrame:RegisterEvent("ADDON_LOADED")
XPBarTextFrame:RegisterEvent("PLAYER_XP_UPDATE")
XPBarTextFrame:RegisterEvent("PLAYER_LEVEL_UP")
XPBarTextFrame:RegisterEvent("UPDATE_EXHAUSTION")
XPBarTextFrame:RegisterEvent("UNIT_PET")
XPBarTextFrame:RegisterEvent("UNIT_PET_EXPERIENCE")

-- I'm not sure if these ones are even needed, but having them seems to prevent
-- the Lua errors that occasionally popped up on the screen for no reason.

XPBarTextFrame:RegisterEvent("ZONE_CHANGED")
XPBarTextFrame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
XPBarTextFrame:RegisterEvent("PLAYER_CONTROL_LOST")
XPBarTextFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
XPBarTextFrame:RegisterEvent("PLAYER_LEAVING_WORLD")
XPBarTextFrame:RegisterEvent("CINEMATIC_START")
XPBarTextFrame:RegisterEvent("CINEMATIC_STOP")

function XPBTeventHandler(self, event, arg1)

if event == "ADDON_LOADED" and arg1 == "XPBarText" then
	DEFAULT_CHAT_FRAME:AddMessage("|cFFFF8000[XP Bar Text]|r v" .. GetAddOnMetadata("XPBarText","Version") .. " - " .. L["use /xpt to access the configuration window."])

	if XPTConfig == nil then XPTConfig = {
		["ShowMoreInfo"] = 'YES',
		["ShowPetInfo"] = 'YES',
		["AlwaysShowInfo"] = 'YES',
		["FormatNumbers"] = 'NO',
		["ShowXPTicker"] = 'NO'
		} 
	end
	if XPTConfig.ShowPetInfo == nil then XPTConfig.ShowPetInfo = 'YES' end
	if XPTConfig.AlwaysShowInfo == nil then XPTConfig.AlwaysShowInfo = 'YES' end
	if XPTConfig.FormatNumbers == nil then XPTConfig.FormatNumbers = 'NO' end
	if XPTConfig.ShowXPTicker == nil then XPTConfig.ShowXPTicker = 'NO' end
	
	UpdateXPBarText()
	UpdateXPTicker()
elseif event == "PLAYER_XP_UPDATE" or event == "PLAYER_LEVEL_UP"  or event == "UPDATE_EXHAUSTION" or event == "UNIT_PET" and arg1 == "player" or event == "UNIT_PET_EXPERIENCE" or event == "ZONE_CHANGED" or event == "ZONE_CHANGED_NEW_AREA" or event == "PLAYER_CONTROL_LOST" or event == "CINEMATIC_START" or event == "CINEMATIC_STOP" or event == "PLAYER_ENTERING_WORLD" then
	UpdateXPBarText()
	UpdateXPTicker()
end

end

XPBarTextFrame:SetScript("OnEvent", XPBTeventHandler)

MainMenuExpBar:HookScript("OnEnter", function(self)
	if XPTConfig.AlwaysShowInfo == "YES" then
		MainMenuBarExpText:Hide()
		GameTooltip:Hide()
	elseif XPTConfig.AlwaysShowInfo == "NO" then
		MainMenuBarExpText:Hide()
		GameTooltip:Hide()
		TextOnXPBar:SetTextColor(1,1,1,1)
	end
end)

MainMenuExpBar:HookScript("OnLeave", function(self)
	GameTooltip:Show()
	
	if XPTConfig.AlwaysShowInfo == "YES" then
		GameTooltip:Show()
	elseif XPTConfig.AlwaysShowInfo == "NO" then
		TextOnXPBar:SetTextColor(1,1,1,0)
	end
end)

-- UPDATE TEXT ON XP BAR

function UpdateXPBarText()

localizedClass, englishClass, classIndex = UnitClass("player")
local playerLevel = UnitLevel("player")

local currentXP = GetCurrentXP()
local levelupXP = GetNextLevelXP()

local percentage = math.ceil(((UnitXP("player") / UnitXPMax("player"))) * 100)

local remainingXP = GetRemainingXP()

local retVal = GetPlayerXPExhaustion()

restid, restname, mult = GetRestState()

if playerLevel < 90 then
	if restid == 2 then
		if XPTConfig.ShowMoreInfo == "YES" then
			TextOnXPBar:SetText(currentXP .. "/" .. levelupXP .. "XP (" .. percentage .. "%) | " .. remainingXP .. "XP to next level | (" .. restname .. ")")
		elseif XPTConfig.ShowMoreInfo == "NO" then
			TextOnXPBar:SetText(currentXP .. "/" .. levelupXP .. "XP")
		end
	elseif restid == 1 then		
		if XPTConfig.ShowMoreInfo == "YES" then
			TextOnXPBar:SetText(currentXP .. "/" .. levelupXP .. "XP (" .. percentage .. "%) | " .. remainingXP .. "XP to next level | (" .. retVal .. " " .. restname .. " XP)")
		elseif XPTConfig.ShowMoreInfo == "NO" then
			TextOnXPBar:SetText(currentXP .. "/" .. levelupXP .. "XP")
		end			
	end
elseif playerLevel == 90 then
	TextOnXPBar:SetTextColor(1,1,1,0)
end

if XPTConfig.AlwaysShowInfo == "YES" then
	TextOnXPBar:SetTextColor(1,1,1,1)
elseif XPTConfig.AlwaysShowInfo == "NO" then
	TextOnXPBar:SetTextColor(1,1,1,0)
end

end

-- XP FUNCTIONS

function GetCurrentXP()

local currentplayerXP = tonumber(UnitXP("player"))

if XPTConfig.FormatNumbers == "NO" then
	return currentplayerXP
elseif XPTConfig.FormatNumbers == "YES" then
	return comma_val(currentplayerXP)
end

end

function GetNextLevelXP()

local playernextlvlXP = tonumber(UnitXPMax("player"))

if XPTConfig.FormatNumbers == "NO" then
	return playernextlvlXP
elseif XPTConfig.FormatNumbers == "YES" then
	return comma_val(playernextlvlXP)
end

end

function GetPlayerPetExperience()

currentPetXP, nextPetXP = GetPetExperience()

if XPTConfig.FormatNumbers == "NO" then
	return currentPetXP, nextPetXP
elseif XPTConfig.FormatNumbers == "YES" then
	return comma_val(currentPetXP), comma_val(nextPetXP)
end

end

function GetPlayerXPExhaustion()

local retVal = GetXPExhaustion()

if retVal == nil then
	return
else
	if XPTConfig.FormatNumbers == "NO" then
		return retVal
	elseif XPTConfig.FormatNumbers == "YES" then
		return comma_val(retVal)
	end
end

end

function GetRemainingXP()
	local xpleft = UnitXPMax("player") - UnitXP("player")
	
	if XPTConfig.FormatNumbers == "NO" then
		return xpleft
	elseif XPTConfig.FormatNumbers == "YES" then
		return comma_val(xpleft)
	end
end

-- COMMA SPLICING

function comma_val(n)
	--Found on http://lua-users.org/wiki/FormattingNumbers
	-- All credit goes to Richard Warburton (http://richard.warburton.it)
	
	local left,num,right = string.match(n,'^([^%d]*%d)(%d*)(.-)$')
	return left..(num:reverse():gsub('(%d%d%d)','%1,'):reverse())..right
end

-- REP BAR TEXT

ReputationWatchBar:HookScript("OnShow", function(self)

if XPTConfig.AlwaysShowInfo == "YES" then
	ReputationWatchBar.OverlayFrame.Text:Show()
elseif XPTConfig.AlwaysShowInfo == "NO" then
	ReputationWatchBar.OverlayFrame.Text:Hide()
end

end)

ReputationWatchBar:HookScript("OnEnter", function(self)

if XPTConfig.AlwaysShowInfo == "YES" then
	ReputationWatchBar.OverlayFrame.Text:Show()
elseif XPTConfig.AlwaysShowInfo == "NO" then
	ReputationWatchBar.OverlayFrame.Text:Hide()
end

end)

ReputationWatchBar:HookScript("OnLeave", function(self)

if XPTConfig.AlwaysShowInfo == "YES" then
	ReputationWatchBar.OverlayFrame.Text:Show()
elseif XPTConfig.AlwaysShowInfo == "NO" then
	ReputationWatchBar.OverlayFrame.Text:Hide()
end

end)

function UpdateXPTicker()
	if XPTConfig.ShowXPTicker == "YES" then
		ExhaustionTick:Show()
	elseif XPTConfig.ShowXPTicker == "NO" then
		ExhaustionTick:Hide()
	end
end