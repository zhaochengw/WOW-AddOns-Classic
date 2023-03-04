local _, L = ...;

local LibDD = LibStub:GetLibrary("LibUIDropDownMenu-4.0");

----------------------------------------------------------------------------------
----------------------------- OPTION PANEL FUNCTIONS -----------------------------
----------------------------------------------------------------------------------

-- Creating Interface/AddOns options tab
function MCF_CreateOptionsFrame()
    MCF.OptionsFrame = CreateFrame("Frame", "MCF_OptionsFrame", nil, "MCF_OptionsFrameTemplate");

    -- Manually create drop-down menu using lib
    MCF_OptionsFrame_TTIntegration_GSTextTypeDropDown_Setup();
end
-- OPTIONS FRAME FUNCTIONS
function MCF_OptionsFrame_OnLoad(self)
    self.name = "Modern Character Frame";
    InterfaceOptions_AddCategory(self);
    
    _G[self:GetName().."SubText"]:SetText(L["MCF_OPTIONS_DESCRIPTION"]);
    _G[self:GetName().."TacoTipIntegrationTitle"]:SetText(L["MCF_OPTIONS_TT_INTEGRATION_TITLE"]);
end
function MCF_OptionsFrame_Update()
    local optionsFrame = MCF_OptionsFrame;
    local TTIntegration = _G[optionsFrame:GetName().."TacoTipIntegration"];
    local TTEnableButton = _G[TTIntegration:GetName().."EnableButton"];
    local TTGSDropDown = _G[TTIntegration:GetName().."GSStatTypeDropDown"];
    local TTColorButton = _G[TTIntegration:GetName().."GSColorEnableButton"];

    if ( not MCF_GetSettings("TT_IntegrationEnabled") ) then
        -- TT Integration Enable button
        TTEnableButton:SetChecked(false);
    else
        TTEnableButton:SetChecked(true);
    end

    TTGSDropDown:SetValue(TTGSDropDown.defaultValue);
    MCF_OptionsFrameGSTextTypeDropDown_OnLoad(TTGSDropDown);

    if ( not MCF_GetSettings("TT_IntegrationColorEnabled") ) then
        TTColorButton:SetChecked(false);
    else
        TTColorButton:SetChecked(true);
    end

    if ( not IsAddOnLoaded("TacoTip") ) then
        TTEnableButton:Disable();
        TTEnableButton.Text:SetFontObject(GameFontDisable);

        LibDD:UIDropDownMenu_DisableDropDown(TTGSDropDown);

        TTColorButton:Disable();
        TTColorButton.Text:SetFontObject(GameFontDisable);
    elseif ( TTEnableButton:GetChecked() ) then
        LibDD:UIDropDownMenu_EnableDropDown(TTGSDropDown);

        TTColorButton:Enable();
        TTColorButton.Text:SetFontObject(GameFontHighlight);
    end
end

-- ITEM QUALITY COLORS
function MCF_OptionsFrame_ItemSlotColorButton_OnLoad(self)
    self.Text:SetText(L["MCF_OPTIONS_COLOR_ITEMSLOT_BUTTON_TEXT"]);
    self.tooltip = L["MCF_OPTIONS_COLOR_ITEMSLOT_BUTTON_TOOLTIP"];
    if MCF_GetSettings("enableItemSlotColoring") then
        self:SetChecked(true);
    else
        self:SetChecked(false);
    end
    self:HookScript("OnClick", function(self) MCF_OptionsFrame_ItemSlotColorButton_HookOnClick(self); end);
end
function MCF_OptionsFrame_ItemSlotColorButton_HookOnClick(self)
    if self:GetChecked() then
        MCF_SetSettings("enableItemSlotColoring", true);
    else
        MCF_SetSettings("enableItemSlotColoring", false);
    end
    for id,_ in pairs(MCF_ItemSlotNames) do
        MCF_SetItemQuality(id);
    end
end

-- REPAIR COST
function MCF_OptionsFrame_RepairCostButton_OnLoad(self)
    self.Text:SetText(L["MCF_OPTIONS_REPAIR_BUTTON_TEXT"]);
    self.tooltip = L["MCF_OPTIONS_REPAIR_BUTTON_TOOLTIP"];
    if MCF_GetSettings("showRepairCost") then
        self:SetChecked(true);
    else
        self:SetChecked(false);
    end
    self:HookScript("OnClick", function(self) MCF_OptionsFrame_RepairCostButton_HookOnClick(self); end);
end
function MCF_OptionsFrame_RepairCostButton_HookOnClick(self)
    if self:GetChecked() then
        MCF_SetSettings("showRepairCost", true);
    else
        MCF_SetSettings("showRepairCost", false);
    end
end


-- TACOTIP INTEGRATION ENABLE BUTTON FUNCTIONS
function MCF_OptionsFrameTTEnableButton_OnLoad(self)
    self.Text:SetText(L["MCF_OPTIONS_TT_INTEGRATION_ENABLE_LABEL"]);
    self.tooltip = L["MCF_OPTIONS_TT_INTEGRATION_ENABLE_TOOLTIP"];

    if ( not MCF_GetSettings("TT_IntegrationEnabled") ) then
        self:SetChecked(false);
    else
        self:SetChecked(true);
    end

    self:HookScript("OnClick", function(self) MCF_OptionsFrameTTEnableButton_HookOnClick(self); end);
end
function MCF_OptionsFrameTTEnableButton_OnShow(self)
    if ( not IsAddOnLoaded("TacoTip") ) then
        self:Disable();
        self.Text:SetFontObject(GameFontDisable);
        _G[self:GetParent():GetName().."Title"]:SetText(L["MCF_OPTIONS_TT_INTEGRATION_TITLE_DISABLED"]);
    end
end
function MCF_OptionsFrameTTEnableButton_HookOnClick(self)
    local ColorEnableButton = _G[self:GetParent():GetName().."GSColorEnableButton"];
    if ( self:GetChecked() ) then
        MCF_SetSettings("TT_IntegrationEnabled", true);
        ColorEnableButton:Enable();
        ColorEnableButton.Text:SetFontObject(GameFontHighlight);
        LibDD:UIDropDownMenu_EnableDropDown(MCF_OptionsFrameTacoTipIntegrationGSStatTypeDropDown);
    else
        MCF_SetSettings("TT_IntegrationEnabled", false);
        ColorEnableButton:Disable();
        ColorEnableButton.Text:SetFontObject(GameFontDisable);
        LibDD:UIDropDownMenu_DisableDropDown(MCF_OptionsFrameTacoTipIntegrationGSStatTypeDropDown);
    end
end

-- TACOTIP GEARSCORE TEXT TYPE DROPDOWN MENU FUNCTIONS
function MCF_OptionsFrame_TTIntegration_GSTextTypeDropDown_Setup()
    local optionsFrame   = MCF_OptionsFrame;
    local TTIntegration  = optionsFrame:GetName().."TacoTipIntegration";
    local TTEnableButton = TTIntegration.."EnableButton";
    local TTGSDropDown   = TTIntegration.."GSStatTypeDropDown";
    local TTColorButton  = TTIntegration.."GSColorEnableButton";

    -- Create drop-down menu
    local DropDown = LibDD:Create_UIDropDownMenu(TTGSDropDown, _G[TTIntegration]);
    DropDown:SetPoint("TOPLEFT", _G[TTEnableButton], "BOTTOMLEFT", 5, -15);
    -- Create drop-down menu label
    local DropDownLabel = DropDown:CreateFontString(DropDown:GetName().."Label", "BACKGROUND", "GameFontHighlightSmall");
    DropDownLabel:SetPoint("BOTTOMLEFT", DropDown, "TOPLEFT", 16, 3);
    -- Set drop-down menu scripts
    DropDown:SetScript("OnLoad", MCF_OptionsFrameGSTextTypeDropDown_OnLoad);
    DropDown:SetScript("OnShow", MCF_OptionsFrameGSTextTypeDropDown_OnShow);
    DropDown:SetScript("OnEnter", MCF_OptionsFrameGSTextTypeDropDown_OnEnter);
    DropDown:SetScript("OnLeave", GameTooltip_Hide);
    -- Immitate frame loading
    MCF_OptionsFrameGSTextTypeDropDown_OnLoad(DropDown);

    -- Manually set up GS coloring button position
    _G[TTColorButton]:SetPoint("TOPLEFT", DropDown, "BOTTOMLEFT", 16, 2);
end
function MCF_OptionsFrameGSTextTypeDropDown_OnLoad(self)
    _G[self:GetName().."Label"]:SetText(L["MCF_OPTIONS_TT_INTEGRATION_GSTYPE_LABEL"]);

    self.defaultValue = 1;
    self.oldValue = MCF_GetSettings("TT_IntegrationType");
    self.value = self.oldValue;
    self.tooltip = L["MCF_OPTIONS_TT_INTEGRATION_GSTYPE_TOOLTIP"];

    LibDD:UIDropDownMenu_SetWidth(self, 90);
    LibDD:UIDropDownMenu_Initialize(self, MCF_OptionsFrameGSTextTypeDropDown_Initialize);
    LibDD:UIDropDownMenu_SetSelectedValue(self, self.value);

    self.SetValue =
        function(self, value)
            self.value = value;
            LibDD:UIDropDownMenu_SetSelectedValue(self, value);
            MCF_SetSettings("TT_IntegrationType", value);
        end;
    self.GetValue =
        function(self)
            return LibDD:UIDropDownMenu_GetSelectedValue(self);
        end;
    self.RefreshValue =
        function(self)
            LibDD:UIDropDownMenu_Initialize(self, MCF_OptionsFrameGSTextTypeDropDown_Initialize);
            LibDD:UIDropDownMenu_SetSelectedValue(self, self.value);
        end;
end
function MCF_OptionsFrameGSTextTypeDropDown_Initialize()
    local selectedValue = LibDD:UIDropDownMenu_GetSelectedValue(MCF_OptionsFrameTacoTipIntegrationGSStatTypeDropDown);
    local info = LibDD:UIDropDownMenu_CreateInfo();

    info.func = MCF_OptionsFrameGSTextTypeDropDown_OnClick;

    info.text = "ILVL / GS";
    info.value = 1;
    info.checked = info.value == selectedValue;
    LibDD:UIDropDownMenu_AddButton(info);

    info.text = "ILVL (GS)";
    info.value = 2;
    info.checked = info.value == selectedValue;
    LibDD:UIDropDownMenu_AddButton(info);

    info.text = "GS";
    info.value = 3;
    info.checked = info.value == selectedValue;
    LibDD:UIDropDownMenu_AddButton(info);


end
function MCF_OptionsFrameGSTextTypeDropDown_OnShow(self)
    local EnableButton = _G[self:GetParent():GetName().."EnableButton"];
    if ( (not EnableButton:GetChecked()) or (not EnableButton:IsEnabled()) ) then
        LibDD:UIDropDownMenu_DisableDropDown(self);
        self.Text:SetFontObject(GameFontDisable);
    end
end
function MCF_OptionsFrameGSTextTypeDropDown_OnClick(self)
	MCF_OptionsFrameTacoTipIntegrationGSStatTypeDropDown:SetValue(self.value);
end
function MCF_OptionsFrameGSTextTypeDropDown_OnEnter(self)
    local EnableButton = _G[self:GetParent():GetName().."EnableButton"]
    if ( EnableButton:GetChecked() and EnableButton:IsEnabled()) then
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT", -120, 0);
        GameTooltip:SetText(self.tooltip, nil, nil, nil, nil, true);
    end
end

-- TACOTIP GEARSCORE COLOR ENABLE BUTTON FUNCTIONS
function MCF_OptionsFrameGSColorEnableButton_OnLoad(self)
    self.Text:SetText(L["MCF_OPTIONS_TT_INTEGRATION_COLOR_LABEL"]);
    self.tooltip = L["MCF_OPTIONS_TT_INTEGRATION_COLOR_TOOLTIP"];

    if ( not MCF_GetSettings("TT_IntegrationColorEnabled") ) then
        self:SetChecked(false);
    else
        self:SetChecked(true);
    end

    self:HookScript("OnClick", function(self) MCF_OptionsFrameGSColorEnableButton_HookOnClick(self); end);
end
function MCF_OptionsFrameGSColorEnableButton_OnShow(self)
    local EnableButton = _G[self:GetParent():GetName().."EnableButton"];
    if ( (not EnableButton:GetChecked()) or (not EnableButton:IsEnabled()) ) then
        self:Disable();
        self.Text:SetFontObject(GameFontDisable);
    end
end
function MCF_OptionsFrameGSColorEnableButton_HookOnClick(self)
    if ( self:GetChecked() ) then
        MCF_SetSettings("TT_IntegrationColorEnabled", true);
    else
        MCF_SetSettings("TT_IntegrationColorEnabled", false);
    end
end

-- RESET SETTINGS BUTTON FUNCTIONS
function MCF_OptionsFrameResetSettingsButton_OnLoad(self)
    self.text:SetText(L["MCF_OPTIONS_RESET_BUTTON_TEXT"]);

    self.tooltip = L["MCF_OPTIONS_RESET_BUTTON_TOOLTIP"];
    self:SetWidth(self.text:GetWidth() + 40);
end
function MCF_OptionsFrameResetSettingsButton_OnShow(self)
    self:Enable();
end
function MCF_OptionsFrameResetSettingsButton_OnClick(self)
    StaticPopupDialogs["MCF_RESET_SETTINGS"] = {
        text = L["MCF_OPTIONS_CONFIRM_RESET"],
        button1 = YES,
        button2 = NO,
        OnAccept = function()
            MCF_ResetSettings();
            MCF_OptionsFrame_Update();
            SendSystemMessage(L["MCF_OPTIONS_RESETED_MESSAGE"]);
            self:Disable();
        end,
        OnCancel = function()
            self:Enable();
        end,
        timeout = 0,
        whileDead = true,
        hideOnEscape = true,
    }

    StaticPopup_Show("MCF_RESET_SETTINGS", self);
end