-- set language display
local _, addon = ...
local L = addon.L

-- Create an input box for the user to enter the item ID
local GetItemLinkBox = CreateFrame("EditBox", "GetItemLinkBox", GetInfoFrame, "InputBoxTemplate");
GetItemLinkBox:SetPoint("TOPLEFT", GetInfoFrame, "TOPLEFT", 20, -40);
GetItemLinkBox:SetSize(100, 20);
GetItemLinkBox:SetAutoFocus(false);

-- Define input box name
local GetItemLinkLabel = GetItemLinkBox:CreateFontString(nil, "OVERLAY", "GameFontNormal");
GetItemLinkLabel:SetPoint("BOTTOM", GetItemLinkBox, "TOP", 0, 5);
GetItemLinkLabel:SetText(L['item_label_text']);

-- When the user presses the Enter key, show the item link
GetItemLinkBox:SetScript("OnEnterPressed", function(self)
    local itemID = tonumber(self:GetText())
    if itemID ~= nil then
        local itemLink = select(2, GetItemInfo(itemID))
        if itemLink ~= nil and itemLink ~= '' then
            DEFAULT_CHAT_FRAME:AddMessage(L['search_result_done'] .. itemLink)
        else
            DEFAULT_CHAT_FRAME:AddMessage(L['search_result_fail'] .. L['invalid_text'])
        end
    end
    self:SetText("")
end)