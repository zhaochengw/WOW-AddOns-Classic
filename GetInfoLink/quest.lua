-- set language display
local _, addon = ...
local L = addon.L

-- Create an input box for the user to enter the quest ID
local GetQuestLinkBox = CreateFrame("EditBox", "GetQuestLinkBox", GetInfoFrame, "InputBoxTemplate");
GetQuestLinkBox:SetPoint("TOPLEFT", GetInfoFrame, "TOPLEFT", 135, -100);
GetQuestLinkBox:SetSize(100, 20);
GetQuestLinkBox:SetAutoFocus(false);

-- Define input box name
local GetQuestLinkLabel = GetQuestLinkBox:CreateFontString(nil, "OVERLAY", "GameFontNormal");
GetQuestLinkLabel:SetPoint("BOTTOM", GetQuestLinkBox, "TOP", 0, 5);
GetQuestLinkLabel:SetText(L['quest_label_text']);

-- When the user presses the Enter key, show the quest link
GetQuestLinkBox:SetScript("OnEnterPressed", function(self)
    local questID = tonumber(self:GetText())
    if questID ~= nil then
        local questLink = GetQuestLink(questID)
        if questLink ~= nil and questLink ~= '' then
            DEFAULT_CHAT_FRAME:AddMessage(L['search_result_done'] .. questLink)
        else
            DEFAULT_CHAT_FRAME:AddMessage(L['search_result_fail'] .. L['invalid_text'])
        end
    end
    self:SetText("")
end)