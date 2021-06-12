local ADDON_NAME = ...

--[[
    IN THEORY THIS ADDON WILL NOT BE REQUIRED FOR TBC, ONCE BLIZZARD FIXES THEIR UI BUGS
]]

local function TargetStatusText_Fixed_UnitFrameHealthBar_Update(statusbar, unit)
-- This code is mostly from UnitFrameHealthBar_Update, we're simply fixing a BlizzardUI Bug
    if ( not statusbar or statusbar.lockValues ) then
        return;
    end

    if ( unit == statusbar.unit ) then
        local maxValue = UnitHealthMax(unit);

        statusbar.showPercentage = false;

        -- Safety check to make sure we never get an empty bar.
        statusbar.forceHideText = false;
        if ( maxValue == 0 ) then
            maxValue = 1;
            statusbar.forceHideText = true;
        elseif ( maxValue == 100 and not ShouldKnowUnitHealth(unit) ) then -- BlizzardUI Bug: previously this was OR, should have been AND
            if TargetHealthDB.forcePercentages then
                --This should be displayed as percentage.
                statusbar.showPercentage = true;
            end
        end
    end
    TextStatusBar_UpdateTextString(statusbar);
end

---------------------------------------------
-- INITIALIZE
---------------------------------------------
local frame = CreateFrame("frame")
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(self, event, addonName)
    if ( event == "ADDON_LOADED" and addonName == ADDON_NAME ) then
        TargetHealthDB = TargetHealthDB or { version=1, forcePercentages=false }
        hooksecurefunc("UnitFrameHealthBar_Update", TargetStatusText_Fixed_UnitFrameHealthBar_Update)

        SLASH_TARGETHEALTH1 = "/targethealth"
        SlashCmdList["TARGETHEALTH"] = function(cmd)
            cmd = cmd:match("^%s*(.-)%s*$"):lower()
            if cmd == "enableforcepercentages" then
                TargetHealthDB.forcePercentages = true
                print("[TargetHealth] forcePercentages is now " .. (TargetHealthDB.forcePercentages and "ENABLED" or "DISABLED"))
                UnitFrameHealthBar_Update(TargetFrame.healthbar, TargetFrame.unit);
            elseif cmd == "disableforcepercentages" then
                TargetHealthDB.forcePercentages = false
                print("[TargetHealth] forcePercentages is now " .. (TargetHealthDB.forcePercentages and "ENABLED" or "DISABLED"))
                UnitFrameHealthBar_Update(TargetFrame.healthbar, TargetFrame.unit);
            else
                print("[TargetHealth] Unknown command: " .. cmd)
                cmd = "help" -- show the help message
            end

            if cmd == "" or cmd == "help" then
                print("TargetHealth help:")
                print("  /targethealth enableForcePercentages    - Force percentages to show when actual values are not available")
                print("  /targethealth disableForcePercentages   - Do not force percentages to show when actual values are not available")
                print("  /targethealth help                      - Show this help message")
            end
        end
    end
end)
