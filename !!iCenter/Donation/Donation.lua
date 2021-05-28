if GetLocale() == "zhCN" then
    DonationText = "感谢支持！";
elseif GetLocale() == "zhTW" then
    DonationText = "感謝支持！";
else
    DonationText = "Thank you!";
end

--main frame
local donation = CreateFrame("Frame", "donation", UIParent);
donation:SetFrameLevel(7);
donation:SetWidth(256);
donation:SetHeight(256);
donation:ClearAllPoints();
donation:SetPoint("BOTTOM", UIParent, "CENTER", 0, 0);
donation:SetClampedToScreen(true);
donation:SetMovable(true);
donation:EnableMouse(true);
donation:RegisterForDrag("LeftButton");
donation:SetScript("OnDragStart", function(self)
    donation:StartMoving();
end)
donation:SetScript("OnDragStop", function(self)
    donation:StopMovingOrSizing();
end)
donation:SetScript("OnEnter", function(self)
    GameTooltip:SetOwner(self, "ANCHOR_CURSOR");
    GameTooltip:SetText(DonationText);
    GameTooltip:Show();
end)
donation:SetScript("OnLeave", function(self)
    GameTooltip:Hide();
end)
donation:Hide();

--image
donation.image = donation:CreateTexture(nil, "ARTWORK");
donation.image:SetTexture("Interface\\AddOns\\!!iCenter\\Donation\\WeChat");
donation.image:SetWidth(256);
donation.image:SetHeight(256);
donation.image:ClearAllPoints();
donation.image:SetPoint("CENTER", donation, "CENTER", 0, 0);

--close button
donation.close = CreateFrame("button", nil, donation, "UIPanelCloseButton");
donation.close:SetWidth(32);
donation.close:SetHeight(32);
donation.close:ClearAllPoints();
donation.close:SetPoint("TOPRIGHT", donation, "TOPRIGHT", 5, 5);

--command
function Donation_SlashHandler(arg)
    if donation:IsShown() then
        donation:Hide();
    else
        donation:Show();
    end
end
SlashCmdList["Donation"] = Donation_SlashHandler;
SLASH_Donation1 = "/donation";
