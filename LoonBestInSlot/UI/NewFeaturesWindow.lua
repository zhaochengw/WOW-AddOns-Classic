LBIS.NewFeaturesWindow = {
};

local function showNewFeature(window) 
			
	local headerText = window:CreateFontString(nil, nil, "GameFontNormalLarge");
	headerText:SetText("New Custom Item Lists !");
	headerText:SetPoint("TOP", window, 0, -35);

	local bodyText = window:CreateFontString(nil, nil, "GameFontNormal");
	bodyText:SetText("Enable in the Loon Best In Slot interface settings\n\n\n\n\n\n\n\n" ..
    "Look at the new Custom tab to see your items\n" ..
    "Go to the Edit tab to customize your lists\n\n\n\n\n\n\n\n" ..
    "View Custom Items on tooltip\n");
	bodyText:SetPoint("TOP", window, 0, -75);

    local t3 = CreateFrame("Frame", nil, window, "BackdropTemplate")
    t3:SetPoint("TOP", -2, -100);
    t3:SetBackdrop({ bgFile = "Interface/AddOns/LoonBestInSlot/Icons/new_feature3.tga", 
                    edgeFile = "Interface/Tooltips/UI-Tooltip-Border", 
                    tile = false, edgeSize = 10, tileSize = 10, 
                    insets = { left = 1, right = 1, top = 1, bottom = 1, }, });
    t3:SetSize(256, 64);

    local t1 = CreateFrame("Frame", nil, window, "BackdropTemplate")
    t1:SetPoint("TOP", -2, -200);
    t1:SetBackdrop({ bgFile = "Interface/AddOns/LoonBestInSlot/Icons/new_feature1.tga",
                    edgeFile = "Interface/Tooltips/UI-Tooltip-Border", 
                    tile = false, edgeSize = 10, tileSize = 10, 
                    insets = { left = 1, right = 1, top = 1, bottom = 1, }, });
    t1:SetSize(256, 64);

    local t2 = CreateFrame("Frame", nil, window, "BackdropTemplate")
    t2:SetPoint("TOP", -2, -300);
    t2:SetBackdrop({ bgFile = "Interface/AddOns/LoonBestInSlot/Icons/new_feature2.tga",
                    edgeFile = "Interface/Tooltips/UI-Tooltip-Border", 
                    tile = false, edgeSize = 10, tileSize = 10, 
                    insets = { left = 1, right = 1, top = 1, bottom = 1, }, });
    t2:SetSize(256, 64);
end

function LBIS.NewFeaturesWindow:CreateAndShowWindow()

    if LBIS.NewFeaturesWindow.Window == nil then
        
        local window = CreateFrame("Frame", "NewFeaturesWindow", UIParent, "InsetFrameTemplate");

        local windowCloseButton = CreateFrame("Button", "NewFeaturesWindowCloseButton", window)
        windowCloseButton:SetPoint("TOPRIGHT", window, "TOPRIGHT", 0, 0)
        windowCloseButton:SetSize(32, 32);
        windowCloseButton:SetNormalTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Up");
        windowCloseButton:SetPushedTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Down")
        windowCloseButton:SetScript("OnClick", function(self)
            window:Hide();
        end);

        --parent frame 
        window:SetSize(400, 400);
        window:SetPoint("CENTER", 0, 0);
        window:SetToplevel(true);
        window:SetMovable(true);
        window:EnableMouse(true);
        window:EnableMouseWheel(true);
        window:SetFrameStrata("DIALOG");

        window:RegisterForDrag("LeftButton");

        local header = window:CreateFontString(nil, nil, "GameFontHighlightMed2");
        header:SetText(LBIS.L["New Features"]);
        header:SetPoint("TOP", window, 0, -10);

        local topLine = window:CreateLine();
        topLine:SetColorTexture(1,1,1,0.5);
        topLine:SetThickness(2);
        topLine:SetStartPoint("TOPLEFT", 10, -29);
        topLine:SetEndPoint("TOPRIGHT", -10, -29);

        window:SetScript("OnDragStart", function(self) self:StartMoving() end);
        window:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end);

        showNewFeature(window);

        LBIS.NewFeaturesWindow.Window = window;
    end

    LBIS.NewFeaturesWindow.Window:Show();
end