-- set language display
local _, addon = ...
local L = addon.L

-- Create a frame called "GetInfoFrame"
local GetInfoFrame = CreateFrame("Frame", "GetInfoFrame", UIParent);
GetInfoFrame:SetFrameStrata("DIALOG");
GetInfoFrame:SetSize(250, 150);
GetInfoFrame:SetPoint("CENTER");
GetInfoFrame:SetClampedToScreen(true);
GetInfoFrame:Hide();

-- Create GetInfoFrame title tags
local GetInfoFrameLabel = GetInfoFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge");
GetInfoFrameLabel:SetPoint("TOPLEFT", GetInfoFrame, "TOPLEFT", 0, -8);
GetInfoFrameLabel:SetPoint("TOPRIGHT", GetInfoFrame, "TOPRIGHT", 0, -8);
GetInfoFrameLabel:SetText(L['main_label_text']);
GetInfoFrameLabel:SetJustifyH("CENTER");

-- Create GetInfoFrame title background texture
-- local GetInfoFrameLabelBg = GetInfoFrame:CreateTexture(nil, "BACKGROUND");
-- GetInfoFrameLabelBg:SetTexture(136548) --"Interface\\PaperDollInfoFrame\\UI-Character-CharacterTab-L1"
-- GetInfoFrameLabelBg:SetPoint("TOPLEFT", GetInfoFrameLabel, "TOPLEFT", -6, 20);
-- GetInfoFrameLabelBg:SetPoint("BOTTOMRIGHT", GetInfoFrameLabel, "BOTTOMRIGHT", 20, -6);
-- GetInfoFrameLabelBg:SetTexCoord(0.255, 1, 0.29, 1)

-- Create GetInfoFrame close button
 local CloseButton = CreateFrame("Button", "GetInfoFrameCloseButton", GetInfoFrame, "UIPanelCloseButton");
 CloseButton:SetPoint("TOPRIGHT", GetInfoFrame, "TOPRIGHT", 0, 0);

-- Set the click event of the GetInfoFrame close button
CloseButton:SetScript("OnClick", function()
    GetInfoFrame:Hide();
end)

-- Create GetInfoFrame background
local GetInfoFramebg = GetInfoFrame:CreateTexture(nil, "BACKGROUND")
GetInfoFramebg:SetTexture(136548) --"Interface\\PaperDollInfoFrame\\UI-Character-CharacterTab-L1"
GetInfoFramebg:SetPoint("TOPLEFT", 0, 0)
GetInfoFramebg:SetPoint("BOTTOMRIGHT", 0, 0)
GetInfoFramebg:SetTexCoord(0.255, 1, 0.29, 1)

-- Set the drag of Get Info Frame
GetInfoFrame:SetMovable(true);
GetInfoFrame:EnableMouse(true);
GetInfoFrame:SetScript("OnMouseDown", function(self, button)
    if button == "LeftButton" then
        self:StartMoving();
    end
end);
GetInfoFrame:SetScript("OnMouseUp", function(self, button)
    self:StopMovingOrSizing();
end);

-- Show usage instructions in the chat box
local function ShowUsage()
    print(L['usage_text']);
end

-- Create a minimap button
local miniButton = LibStub("LibDataBroker-1.1"):NewDataObject("GetInfoLinkButton", {
    type = "data source",
    text = "Get Info Link",
    icon = "Interface/AddOns/GetInfoLink/Icon/getinfolink",
    OnClick = function(self, btn)
        if GetInfoFrame:IsVisible() then
            GetInfoFrame:Hide();
        else
            GetInfoFrame:Show();
            ShowUsage();
        end
    end,
    OnTooltipShow = function(tooltip)
        if not tooltip or not tooltip.AddLine then return end
        tooltip:AddLine(L['mini_button_text']);
        tooltip:AddLine(L['mini_button_click']);
    end,
})

local icon = LibStub("LibDBIcon-1.0", true)
icon:Register("GetInfoLinkButton", miniButton, {
    minimapPos = 220,
})