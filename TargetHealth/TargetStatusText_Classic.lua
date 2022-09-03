local ADDON_NAME = ...


---------------------------------------------
-- HealthBar
---------------------------------------------
TargetFrameTextureFrame:CreateFontString("TargetFrameHealthBarText", "BORDER", "TextStatusBarText")
TargetFrameHealthBarText:SetPoint("CENTER", TargetFrameTextureFrame, "CENTER", -50, 3)

TargetFrameTextureFrame:CreateFontString("TargetFrameHealthBarTextLeft", "BORDER", "TextStatusBarText")
TargetFrameHealthBarTextLeft:SetPoint("LEFT", TargetFrameTextureFrame, "LEFT", 8, 3)

TargetFrameTextureFrame:CreateFontString("TargetFrameHealthBarTextRight", "BORDER", "TextStatusBarText")
TargetFrameHealthBarTextRight:SetPoint("RIGHT", TargetFrameTextureFrame, "RIGHT", -110, 3)


---------------------------------------------
-- ManaBar
---------------------------------------------
TargetFrameTextureFrame:CreateFontString("TargetFrameManaBarText", "BORDER", "TextStatusBarText")
TargetFrameManaBarText:SetPoint("CENTER", TargetFrameTextureFrame, "CENTER", -50, -8)

TargetFrameTextureFrame:CreateFontString("TargetFrameManaBarTextLeft", "BORDER", "TextStatusBarText")
TargetFrameManaBarTextLeft:SetPoint("LEFT", TargetFrameTextureFrame, "LEFT", 8, -8)

TargetFrameTextureFrame:CreateFontString("TargetFrameManaBarTextRight", "BORDER", "TextStatusBarText")
TargetFrameManaBarTextRight:SetPoint("RIGHT", TargetFrameTextureFrame, "RIGHT", -110, -8)


---------------------------------------------
-- INITIALIZE
---------------------------------------------
local frame = CreateFrame("frame")
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(self, event, addonName)
    if ( event == "ADDON_LOADED" and addonName == ADDON_NAME ) then
        TargetHealthDB = TargetHealthDB or { version=1, forcePercentages=false }

        TargetFrameHealthBar.LeftText = TargetFrameHealthBarTextLeft;
        TargetFrameHealthBar.RightText = TargetFrameHealthBarTextRight
        TargetFrameManaBar.LeftText = TargetFrameManaBarTextLeft;
        TargetFrameManaBar.RightText = TargetFrameManaBarTextRight;

        UnitFrameHealthBar_Initialize("target", TargetFrameHealthBar, TargetFrameHealthBarText, true);
        UnitFrameManaBar_Initialize("target", TargetFrameManaBar, TargetFrameManaBarText, true);

        SLASH_TARGETHEALTH1 = "/targethealth"
        SlashCmdList["TARGETHEALTH"] = function(cmd)
		    cmd = cmd:match("^%s*(.-)%s*$"):lower()
            if cmd == "enableforcepercentages" then
                TargetHealthDB.forcePercentages = true
                print("[TargetHealth] forcePercentages is now " .. (TargetHealthDB.forcePercentages and "ENABLED" or "DISABLED"))
            elseif cmd == "disableforcepercentages" then
                TargetHealthDB.forcePercentages = false
                print("[TargetHealth] forcePercentages is now " .. (TargetHealthDB.forcePercentages and "ENABLED" or "DISABLED"))
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
