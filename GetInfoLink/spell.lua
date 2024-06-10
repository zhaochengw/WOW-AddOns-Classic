-- set language display
local _, addon = ...
local L = addon.L

-- Create an input box for the user to enter the spell ID
local GetSpellLinkBox = CreateFrame("EditBox", "GetSpellLinkBox", GetInfoFrame, "InputBoxTemplate");
GetSpellLinkBox:SetPoint("TOPLEFT", GetInfoFrame, "TOPLEFT", 140, -60);
GetSpellLinkBox:SetSize(100, 20);
GetSpellLinkBox:SetAutoFocus(false);

-- Define input box name
local GetSpellLinkLabel = GetSpellLinkBox:CreateFontString(nil, "OVERLAY", "GameFontNormal");
GetSpellLinkLabel:SetPoint("BOTTOM", GetSpellLinkBox, "TOP", 0, 5);
GetSpellLinkLabel:SetText(L['spell_label_text']);

-- When the user presses the Enter key, show the spell link
GetSpellLinkBox:SetScript("OnEnterPressed", function(self)
    local spellID = tonumber(self:GetText())
    if spellID ~= nil then
        local spellLink = GetSpellLink(spellID)
        if spellLink ~= nil and spellLink ~= '' then
            DEFAULT_CHAT_FRAME:AddMessage(L['search_result_done'] .. spellLink)
        else
            DEFAULT_CHAT_FRAME:AddMessage(L['search_result_fail'] .. L['invalid_text'])
        end
    end
    self:SetText(""); -- Clear the text content in the input box
    self:ClearFocus(); -- Clear focus
end)