-- PetChecker_Config.lua
-- PetChecker v2.0.10.24.2025-STABLE
-- Config panel with HUD/Text color pickers (no warning picker), tooltips, reset button, and safe color saving

local panel = CreateFrame("Frame", "PetCheckerOptionsPanel", UIParent, "BackdropTemplate")
panel.name = "PetChecker v2.0.10.24.2025"

panel:SetBackdrop({
    bgFile = "Interface/DialogFrame/UI-DialogBox-Background-Dark",
    edgeFile = "Interface/DialogFrame/UI-DialogBox-Border",
    edgeSize = 16,
    insets = { left = 4, right = 4, top = 4, bottom = 4 }
})
panel:SetBackdropBorderColor(1, 0.82, 0, 1)

local title = panel:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
title:SetPoint("TOPLEFT", 16, -16)
title:SetText("PetChecker Settings")

local y = -50

-------------------------------------------------
-- ✅ Checkbox builder with tooltips
-------------------------------------------------
local function MakeCheckbox(label, settingKey, tooltip)
local cb = CreateFrame("CheckButton", nil, panel, "InterfaceOptionsCheckButtonTemplate")
cb.Text:SetText(label)
cb:SetPoint("TOPLEFT", 20, y)
y = y - 30

cb:SetScript("OnClick", function(self)
if not PetCheckerDB then PetCheckerDB = {} end
    if type(PetCheckerDB.settings) ~= "table" then PetCheckerDB.settings = {} end
        PetCheckerDB.settings[settingKey] = self:GetChecked() and true or false
        if PetChecker_UpdateHUDText then PetChecker_UpdateHUDText() end
            if PetChecker_UpdateHUDVisual then PetChecker_UpdateHUDVisual() end
                end)

if PetCheckerDB and PetCheckerDB.settings then
    cb:SetChecked(PetCheckerDB.settings[settingKey])
    else
        cb:SetChecked(false)
        end

        if tooltip then
            cb.tooltipText = tooltip
            cb:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:ClearLines()
            GameTooltip:AddLine(self.tooltipText, 1, 0.82, 0, true)
            GameTooltip:Show()
            end)
            cb:SetScript("OnLeave", function() GameTooltip:Hide() end)
            end

            return cb
            end

            -------------------------------------------------
            -- Checkboxes
            -------------------------------------------------
            MakeCheckbox("Enable HUD", "enableHUD", "Show the pet status HUD box.")
            MakeCheckbox("Enable Visual Warnings", "enableVisuals", "Show giant yellow screen warnings.")
            MakeCheckbox("Show HUD Out of Combat", "showOutOfCombat", "Keep HUD visible even when not fighting.")
            MakeCheckbox("Lock HUD Position", "lockHUD", "Prevents you from dragging the HUD.")

            -------------------------------------------------
            -- Reset HUD Position Button
            -------------------------------------------------
            local resetBtn = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
            resetBtn:SetSize(160, 22)
            resetBtn:SetPoint("TOPLEFT", 20, y)
            resetBtn:SetText("Reset HUD Position")
            y = y - 35
            resetBtn:SetScript("OnClick", function()
            if not PetCheckerDB then PetCheckerDB = {} end
                PetCheckerDB.hudPoint = { "CENTER", "CENTER", 0, -200 }
                if PetChecker_RestoreHUDPosition then PetChecker_RestoreHUDPosition() end
                    if PetChecker_UpdateHUDText then PetChecker_UpdateHUDText() end
                        end)

            -------------------------------------------------
            -- HUD Scale Slider
            -------------------------------------------------
            local scaleText = panel:CreateFontString(nil, "OVERLAY", "GameFontNormal")
            scaleText:SetPoint("TOPLEFT", 20, y)
            scaleText:SetText("HUD Scale")
            y = y - 25

            local scaleSlider = CreateFrame("Slider", "PetCheckerHUDScaleSlider", panel, "OptionsSliderTemplate")
            scaleSlider:SetWidth(200)
            scaleSlider:SetPoint("TOPLEFT", 20, y)
            scaleSlider:SetMinMaxValues(0.8, 1.5)
            scaleSlider:SetValueStep(0.05)
            scaleSlider:SetObeyStepOnDrag(true)
            _G[scaleSlider:GetName().."Low"]:SetText("0.8")
            _G[scaleSlider:GetName().."High"]:SetText("1.5")

            scaleSlider:SetScript("OnValueChanged", function(self, value)
            if not PetCheckerDB then PetCheckerDB = {} end
                if type(PetCheckerDB.settings) ~= "table" then PetCheckerDB.settings = {} end
                    PetCheckerDB.settings.hudScale = value
                    _G[self:GetName().."Text"]:SetText(string.format("%.2f", value))
                    if PetChecker_UpdateHUDVisual then PetChecker_UpdateHUDVisual() end
                        end)

            scaleSlider:SetValue((PetCheckerDB.settings and PetCheckerDB.settings.hudScale) or 1.0)
            _G[scaleSlider:GetName().."Text"]:SetText(string.format("%.2f", (PetCheckerDB.settings and PetCheckerDB.settings.hudScale) or 1.0))
            y = y - 50

            -------------------------------------------------
            -- Low HP Threshold Slider
            -------------------------------------------------
            local hpText = panel:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
            hpText:SetPoint("TOPLEFT", 20, y)
            hpText:SetText("Low HP Threshold (%)")
            y = y - 25

            local hpSlider = CreateFrame("Slider", "PetCheckerHPThresholdSlider", panel, "OptionsSliderTemplate")
            hpSlider:SetWidth(200)
            hpSlider:SetPoint("TOPLEFT", 20, y)
            hpSlider:SetMinMaxValues(10, 60)
            hpSlider:SetValueStep(1)
            hpSlider:SetObeyStepOnDrag(true)
            _G[hpSlider:GetName().."Low"]:SetText("10")
            _G[hpSlider:GetName().."High"]:SetText("60")

            hpSlider:SetScript("OnValueChanged", function(self, value)
            if not PetCheckerDB then PetCheckerDB = {} end
                if type(PetCheckerDB.settings) ~= "table" then PetCheckerDB.settings = {} end
                    PetCheckerDB.settings.lowHPThreshold = math.floor(value)
                    local valText = _G[self:GetName().."Text"]
                    valText:ClearAllPoints()
                    valText:SetPoint("TOP", hpSlider, "BOTTOM", 0, -4)
                    valText:SetText(PetCheckerDB.settings.lowHPThreshold .. "%")
                    end)

            hpSlider:SetValue((PetCheckerDB.settings and PetCheckerDB.settings.lowHPThreshold) or 30)
            local valText = _G[hpSlider:GetName().."Text"]
            valText:ClearAllPoints()
            valText:SetPoint("TOP", hpSlider, "BOTTOM", 0, -4)
            valText:SetText(((PetCheckerDB.settings and PetCheckerDB.settings.lowHPThreshold) or 30) .. "%")
            y = y - 60

            -------------------------------------------------
            -- 🎨 Color Picker Function (HUD & Text only, Safe Save)
            -------------------------------------------------

            if not ColorPickerFrame._pcHooked then
                ColorPickerFrame:HookScript("OnHide", function(self)
                if self._pcApply and not self._pcCancelled then
                    pcall(self._pcApply)
                    end
                    self._pcApply = nil
                    self._pcCancelled = nil
                    self._pcKey = nil
                    end)
                ColorPickerFrame._pcHooked = true
                end

                local function CreateColorButton(label, colorKey)
                local btn = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
                btn:SetSize(160, 22)
                btn:SetText(label)

                btn.tooltipText = "Click to choose a color for " .. label:lower() .. "."
                btn:SetScript("OnEnter", function(self)
                GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
                GameTooltip:ClearLines()
                GameTooltip:AddLine(self.tooltipText, 1, 0.82, 0, true)
                GameTooltip:Show()
                end)
                btn:SetScript("OnLeave", function() GameTooltip:Hide() end)

                local preview = btn:CreateTexture(nil, "OVERLAY")
                preview:SetSize(40, 12)
                preview:SetPoint("RIGHT", btn, "LEFT", -6, 0)
                btn.preview = preview

                local function UpdatePreview()
                if not PetCheckerDB or not PetCheckerDB.settings then return end
                    local c = PetCheckerDB.settings[colorKey] or {r=1, g=1, b=1}
                    preview:SetColorTexture(c.r, c.g, c.b, 1)
                    end

                    btn:SetScript("OnShow", UpdatePreview)
                    btn:SetScript("OnClick", function()
                    if not PetCheckerDB or not PetCheckerDB.settings then return end
                        local c = PetCheckerDB.settings[colorKey] or {r=1, g=1, b=1}

                        local function applyColor()
                        local r, g, b = ColorPickerFrame:GetColorRGB()
                        PetCheckerDB.settings[colorKey] = {r=r, g=g, b=b}
                        UpdatePreview()
                        if PetChecker_UpdateColors then PetChecker_UpdateColors() end
                            end

                            local function cancelColor(prev)
                            ColorPickerFrame._pcCancelled = true
                            if prev and type(prev.r) == "number" then
                                PetCheckerDB.settings[colorKey] = {r=prev.r, g=prev.g, b=prev.b}
                                UpdatePreview()
                                if PetChecker_UpdateColors then PetChecker_UpdateColors() end
                                    end
                                    end

                                    ColorPickerFrame.hasOpacity = false
                                    ColorPickerFrame:SetColorRGB(c.r, c.g, c.b)
                                    ColorPickerFrame.func = applyColor
                                    ColorPickerFrame.swatchFunc = applyColor
                                    ColorPickerFrame.cancelFunc = cancelColor
                                    ColorPickerFrame.previousValues = {r=c.r, g=c.g, b=c.b}

                                    ColorPickerFrame._pcApply = applyColor
                                    ColorPickerFrame._pcCancelled = false
                                    ColorPickerFrame._pcKey = colorKey

                                    ColorPickerFrame:Hide()
                                    ColorPickerFrame:Show()
                                    end)

                    return btn
                    end

                    -- HUD border color
                    local hudBtn = CreateColorButton("HUD Border Color", "hudColor")
                    hudBtn:SetPoint("TOPLEFT", 20, y)
                    y = y - 30

                    -- HUD text color
                    local textBtn = CreateColorButton("HUD Text Color", "textColor")
                    textBtn:SetPoint("TOPLEFT", 20, y)
                    y = y - 40

                    -------------------------------------------------
                    -- 🎨 Reset Colors to Default Button
                    -------------------------------------------------
                    local resetColorsBtn = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
                    resetColorsBtn:SetSize(160, 22)
                    resetColorsBtn:SetPoint("TOPLEFT", 20, y)
                    resetColorsBtn:SetText("Reset Colors to Default")
                    y = y - 35
                    resetColorsBtn:SetScript("OnClick", function()
                    if not PetCheckerDB or type(PetCheckerDB.settings) ~= "table" then return end
                        PetCheckerDB.settings.hudColor  = {r = 1, g = 0.82, b = 0}
                        PetCheckerDB.settings.textColor = {r = 1, g = 1, b = 0.9}
                        if PetChecker_UpdateColors then PetChecker_UpdateColors() end
                            if hudBtn.preview then hudBtn.preview:SetColorTexture(1, 0.82, 0, 1) end
                                if textBtn.preview then textBtn.preview:SetColorTexture(1, 1, 0.9, 1) end
                                    end)

                    -------------------------------------------------
                    -- ✅ Universal-safe AddOn registration
                    -------------------------------------------------
                    if Settings and type(Settings.RegisterAddOnCategory) == "function" then
                        local category = Settings.RegisterCanvasLayoutCategory(panel, panel.name)
                        Settings.RegisterAddOnCategory(category)
                        elseif type(InterfaceOptions_AddCategory) == "function" then
                            InterfaceOptions_AddCategory(panel)
                            else
                                print("|cffff0000PetChecker: Unable to register options panel.|r")
                                end
