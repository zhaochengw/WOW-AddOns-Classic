local AddonName, AddonTable = ...
local L = AddonTable.Localize
local AddonTitle = select(2, C_AddOns.GetAddOnInfo(AddonName))
local PlainAddonTitle = AddonTitle:gsub("|c........", ""):gsub("|r", "")

local TextOnXPBar = MainStatusTrackingBarContainer:CreateFontString("MainStatusTrackingBarContainer", "OVERLAY", "GameTooltipText")
TextOnXPBar:SetFont("Fonts\\ARIALN.TTF", 14, "THINOUTLINE")
TextOnXPBar:SetPoint("TOP", 0, 0)
TextOnXPBar:SetTextColor(1,1,1,1)

local XPBarTextFrame = CreateFrame("Frame")
XPBarTextFrame:RegisterEvent("ADDON_LOADED")
XPBarTextFrame:RegisterEvent("PLAYER_XP_UPDATE")
XPBarTextFrame:RegisterEvent("PLAYER_LEVEL_UP")
XPBarTextFrame:RegisterEvent("UPDATE_EXHAUSTION")

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
	DEFAULT_CHAT_FRAME:AddMessage("|cFFFF8000[XP Bar Text]|r v" .. C_AddOns.GetAddOnMetadata("XPBarText","Version") .. " - " .. L["use /xpt to access the configuration window."])

	if XPTConfig == nil then XPTConfig = {
		["ShowMoreInfo"] = 'YES',
		["AlwaysShowInfo"] = 'YES',
		["FormatNumbers"] = 'NO'
		} 
	end
	if XPTConfig.AlwaysShowInfo == nil then XPTConfig.AlwaysShowInfo = 'YES' end
	if XPTConfig.FormatNumbers == nil then XPTConfig.FormatNumbers = 'NO' end
	
	UpdateXPBarText()
	UpdateRepBar()
	
	C_CVar.SetCVar("XpBarText", 0)
elseif event == "PLAYER_XP_UPDATE" or event == "PLAYER_LEVEL_UP"  or event == "UPDATE_EXHAUSTION" or event == "ZONE_CHANGED" or event == "ZONE_CHANGED_NEW_AREA" or event == "PLAYER_CONTROL_LOST" or event == "CINEMATIC_START" or event == "CINEMATIC_STOP" or event == "PLAYER_ENTERING_WORLD" then
	UpdateXPBarText()
	UpdateRepBar()
end

end

XPBarTextFrame:SetScript("OnEvent", XPBTeventHandler)

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
			if XPTConfig.FormatNumbers == "YES" then
				TextOnXPBar:SetText(comma_val(currentXP) .. "/" .. comma_val(levelupXP) .. "XP (" .. percentage .. "%) | " .. comma_val(remainingXP) .. "XP to next level | (" .. restname .. ")")
			elseif XPTConfig.FormatNumbers == "NO" then
				TextOnXPBar:SetText(currentXP .. "/" .. levelupXP .. "XP (" .. percentage .. "%) | " .. remainingXP .. "XP to next level | (" .. restname .. ")")
			end
		elseif XPTConfig.ShowMoreInfo == "NO" then
			if XPTConfig.FormatNumbers == "YES" then
				TextOnXPBar:SetText(comma_val(currentXP) .. "/" .. comma_val(levelupXP) .. "XP")
			elseif XPTConfig.FormatNumbers == "NO" then
				TextOnXPBar:SetText(currentXP .. "/" .. levelupXP .. "XP")
			end
		end
	elseif restid == 1 then		
		if XPTConfig.ShowMoreInfo == "YES" then
			if XPTConfig.FormatNumbers == "YES" then
				TextOnXPBar:SetText(comma_val(currentXP) .. "/" .. comma_val(levelupXP) .. "XP (" .. percentage .. "%) | " .. comma_val(remainingXP) .. "XP to next level | (" .. comma_val(retVal) .. " " .. restname .. " XP)")
			elseif XPTConfig.FormatNumbers == "NO" then
				TextOnXPBar:SetText(currentXP .. "/" .. levelupXP .. "XP (" .. percentage .. "%) | " .. remainingXP .. "XP to next level | (" .. retVal .. " " .. restname .. " XP)")
			end
		elseif XPTConfig.ShowMoreInfo == "NO" then
			if XPTConfig.FormatNumbers == "YES" then
				TextOnXPBar:SetText(comma_val(currentXP) .. "/" .. comma_val(levelupXP) .. "XP")
			elseif XPTConfig.FormatNumbers == "NO" then
				TextOnXPBar:SetText(currentXP .. "/" .. levelupXP .. "XP")
			end
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

SecondaryStatusTrackingBarContainer:HookScript("OnShow", function(self)

for _, bar in pairs(SecondaryStatusTrackingBarContainer.bars) do
    if bar.OverlayFrame then
        local repbar = bar.OverlayFrame
		
		if XPTConfig.AlwaysShowInfo == "YES" then
			repbar.Text:Show()
		elseif XPTConfig.AlwaysShowInfo == "NO" then
			repbar.Text:Hide()
		end
    end
end

end)

SecondaryStatusTrackingBarContainer:HookScript("OnEnter", function(self)

for _, bar in pairs(SecondaryStatusTrackingBarContainer.bars) do
    if bar.OverlayFrame then
        local repbar = bar.OverlayFrame
		
		if XPTConfig.AlwaysShowInfo == "YES" then
			repbar.Text:Show()
		elseif XPTConfig.AlwaysShowInfo == "NO" then
			repbar.Text:Hide()
		end
    end
end

end)

SecondaryStatusTrackingBarContainer:HookScript("OnLeave", function(self)

for _, bar in pairs(SecondaryStatusTrackingBarContainer.bars) do
    if bar.OverlayFrame then
        local repbar = bar.OverlayFrame
		
		if XPTConfig.AlwaysShowInfo == "YES" then
			repbar.Text:Show()
		elseif XPTConfig.AlwaysShowInfo == "NO" then
			repbar.Text:Hide()
		end
    end
end

end)

-- SHOW/HIDE RESTED XP TICKER

function UpdateXPTicker()
	for _, bar in pairs(MainStatusTrackingBarContainer.bars) do
		if bar.ExhaustionTick then 
			local tick = bar.ExhaustionTick
			hooksecurefunc(tick, "UpdateTickPosition", function()
				if XPTConfig.ShowXPTicker == "YES" then
					tick:Show()
				elseif XPTConfig.ShowXPTicker == "NO" then
					tick:Hide()
				end
			end)
			if XPTConfig.ShowXPTicker == "YES" then
			tick:Show()
			elseif XPTConfig.ShowXPTicker == "NO" then
			tick:Hide()
			end
		end
	end
end

-- HIDE IN-GAME XP BAR TEXT WHEN VIEWING CHARACTER WINDOW

CharacterFrame:HookScript("OnShow", function(self)

	for _, bar in pairs(MainStatusTrackingBarContainer.bars) do
		if bar.OverlayFrame then
			local repbar = bar.OverlayFrame
			repbar.Text:Hide()
		end
	end

end)

-- UPDATE REP BAR

function UpdateRepBar()

	if SecondaryStatusTrackingBarContainer:IsVisible() == true then
		for _, bar in pairs(SecondaryStatusTrackingBarContainer.bars) do
			if bar.OverlayFrame then
				local repbar = bar.OverlayFrame
				
				if XPTConfig.AlwaysShowInfo == "YES" then
					repbar.Text:Show()
				elseif XPTConfig.AlwaysShowInfo == "NO" then
					repbar.Text:Hide()
				end
			end
		end
	end

end