-- set language display
local _, addon = ...
local L = addon.L

-- Create an input box for the user to enter the achievement ID
local GetAchievementLinkBox = CreateFrame("EditBox", "GetAchievementLinkBox", GetInfoFrame, "InputBoxTemplate");
GetAchievementLinkBox:SetPoint("TOPLEFT", GetInfoFrame, "TOPLEFT", 15, -120);
GetAchievementLinkBox:SetSize(100, 20);
GetAchievementLinkBox:SetAutoFocus(false);

-- Define input box name
local GetAchievementLinkLabel = GetAchievementLinkBox:CreateFontString(nil, "OVERLAY", "GameFontNormal");
GetAchievementLinkLabel:SetPoint("BOTTOM", GetAchievementLinkBox, "TOP", 0, 5);
GetAchievementLinkLabel:SetText(L['achievement_label_text']);

-- When the user presses the Enter key, show the achievement link
GetAchievementLinkBox:SetScript("OnEnterPressed", function(self)
    local achievementID = tonumber(self:GetText())
    if achievementID ~= nil then
        local achievementLink = GetAchievementLink(achievementID)
        if achievementLink ~= nil and achievementLink ~= '' then
            DEFAULT_CHAT_FRAME:AddMessage(L['search_result_done'] .. achievementLink)
        else
            DEFAULT_CHAT_FRAME:AddMessage(L['search_result_fail'] .. L['invalid_text'])
        end
    end
    self:SetText(""); -- Clear the text content in the input box
    self:ClearFocus(); -- Clear focus
end)