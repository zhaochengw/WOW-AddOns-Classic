local version, widget = 1, "SLIDER"
local CUI = LibStub and LibStub("CloudUI-1.0")
if not CUI or CUI:GetWidgetVersion(widget) >= version then
    return
end

-- Variables.
local THUMB_PADDING = 2
local DEFAULT_SIZE = 16
local DEFAULT_LENGTH = 168

-- Script handlers.

-- Called when the slider's size changes.
local function Slider_OnSizeChanged(self, width, height)
    if self.isHorizontal then
        if self.upButton then
            self.upButton:SetSize(height, height)
        end
        if self.downButton then
            self.downButton:SetSize(height, height)
        end
        self:GetThumbTexture():SetSize(height, height)
    else
        if self.upButton then
            self.upButton:SetSize(width, width)
        end
        if self.downButton then
            self.downButton:SetSize(width, width)
        end
        -- I don't know why padding is needed here but not for horizontal sliders.
        self:GetThumbTexture():SetSize(width - THUMB_PADDING, width - THUMB_PADDING)
    end
end

-- Called when the slider is disabled.
local function Slider_OnDisable(self)
    self:GetThumbTexture():SetColorTexture(self.disableR, self.disableG, self.disableB, self.disableA)
end

-- Called when the slider is enabled.
local function Slider_OnEnable(self)
    self:GetThumbTexture():SetColorTexture(self.normalR, self.normalG, self.normalB, self.normalA)
end

-- Called when the slider value is changed.
local function Slider_OnValueChanged(self, value)
    -- Disable/enable buttons.
    local _, maxValue = self:GetMinMaxValues()
    if value <= self:GetMinMaxValues() then
        if self.upButton then
            self.upButton:Disable()
        end
        if self.downButton then
            self.downButton:Enable()
        end
    elseif value >= maxValue then
        if self.upButton then
            self.upButton:Enable()
        end
        if self.downButton then
            self.downButton:Disable()
        end
    else
        if self.upButton then
            self.upButton:Enable()
        end
        if self.downButton then
            self.downButton:Enable()
        end
    end
    if self.callbacks then
        for _, callback in pairs(self.callbacks) do
            callback(self, value)
        end
    end
end

-- Called when a button is disabled.
local function Button_OnDisable(self)
    local parent = self:GetParent()
    local r, g, b, a
    if parent then
        r, g, b, a = parent.disableR, parent.disableG, parent.disableB, parent.disableA
    else
        r, g, b, a = 0.3, 0.3, 0.3, 1
    end
    self.texture:SetVertexColor(r, g, b, a)
end

-- Called when a button is enabled.
local function Button_OnEnable(self)
    local parent = self:GetParent()
    local r, g, b, a
    if parent then
        r, g, b, a = parent.normalR, parent.normalG, parent.normalB, parent.normalA
    else
        r, g, b, a = 1, 1, 1, 1
    end
    self.texture:SetVertexColor(r, g, b, a)
end

-- Called when the up button is clicked.
local function UpButton_OnClick(self)
    local slider = self:GetParent()
    slider:SetValue(slider:GetValue() - slider:GetValueStep())
    PlaySound(SOUNDKIT.U_CHAT_SCROLL_BUTTON)
end

-- Called when the down button is clicked.
local function DownButton_OnClick(self)
    local slider = self:GetParent()
    slider:SetValue(slider:GetValue() + slider:GetValueStep())
    PlaySound(SOUNDKIT.U_CHAT_SCROLL_BUTTON)
end

-- Template functions.

-- Sets the normal (enabled) color for the given frame to the given values.
local function SetNormalColor(self, r, g, b, a)
    self.normalR, self.normalG, self.normalB, self.normalA = r, g, b, a
    if not self:IsDisabled() then
        self:GetThumbTexture():SetColorTexture(r, g, b, a)
    end
end

-- Resets the normal (enabled) color for the given frame.
local function ResetNormalColor(self)
    self:SetNormalColor(1, 1, 1, 1)
end

-- Sets the disabled color for the given frame to the given values.
local function SetDisableColor(self, r, g, b, a)
    self.disabledR, self.disabledG, self.disabledB, self.disabledA = r, g, b, a
    if self:IsDisabled() then
        self:GetThumbTexture():SetColorTexture(r, g, b, a)
    end
end

-- Resets the disabled color for the given frame.
local function ResetDisableColor(self)
    self.disableR, self.disableG, self.disableB, self.disableA = 0.3, 0.3, 0.3, 1
end

-- Creates and returns a slider in the given parent frame and with the given name, minValue, and maxValue. No default textures so they have to be given.
function CUI:CreateSlider(parentFrame, frameName, minValue, maxValue, obeyStep, thumbTexture, upTexture, downTexture, isHorizontal, callbacks)
    assert(thumbTexture and type(thumbTexture) == "string", "CreateSlider: 'thumbTexture' needs to be a string")
    assert(type(upTexture) == "string" or type(upTexture) == "nil", "CreateSlider: 'upTexture' needs to be a string or nil")
    assert(type(downTexture) == "string" or type(downTexture) == "nil", "CreateSlider: 'downTexture' needs to be a string or nil")
    if callbacks then
        assert(type(callbacks) == "table" and #callbacks > 0, "CreateSlider: 'callbacks' needs to be a non-empty table")
    end
    -- Slider.
    local slider = CreateFrame("Slider", frameName, parentFrame or UIParent)
    slider.callbacks = callbacks
    if not CUI:ApplyTemplate(slider, CUI.templates.DisableableFrameTemplate) then
        return false
    end
    if not CUI:ApplyTemplate(slider, CUI.templates.BackgroundFrameTemplate) then
        return false
    end
    if not CUI:ApplyTemplate(slider, CUI.templates.BorderedFrameTemplate) then
        return false
    end
    -- Manually set positions of background and borders if it's vertical because sliders are weird.
    if not isHorizontal then
        slider.CUITopBorderTexture:SetPoint("BOTTOMLEFT", slider, "TOPLEFT", -1, 1)
        slider.CUITopBorderTexture:SetPoint("BOTTOMRIGHT", slider, "TOPRIGHT", 1, 1)
        slider.CUIRightBorderTexture:SetPoint("BOTTOMLEFT", slider, "BOTTOMRIGHT", 0, -2)
        slider.CUIRightBorderTexture:SetPoint("TOPLEFT", slider, "TOPRIGHT", 0, 2)
        slider.CUIBottomBorderTexture:SetPoint("TOPLEFT", slider, "BOTTOMLEFT", -1, -1)
        slider.CUIBottomBorderTexture:SetPoint("TOPRIGHT", slider, "BOTTOMRIGHT", 1, -1)
        slider.CUILeftBorderTexture:SetPoint("BOTTOMRIGHT", slider, "BOTTOMLEFT", 0, -2)
        slider.CUILeftBorderTexture:SetPoint("TOPRIGHT", slider, "TOPLEFT", 0, 2)
        slider.CUIBackgroundTexture:SetPoint("TOPLEFT", slider, "TOPLEFT", 0, 1)
        slider.CUIBackgroundTexture:SetPoint("BOTTOMRIGHT", slider, "BOTTOMRIGHT", 0, -1)
    end
    slider.isHorizontal = isHorizontal
    if isHorizontal then
        slider:SetOrientation("HORIZONTAL")
        slider:SetSize(DEFAULT_LENGTH, DEFAULT_SIZE)
    else
        slider:SetOrientation("VERTICAL")
        slider:SetSize(DEFAULT_SIZE, DEFAULT_LENGTH)
    end
    if minValue then
        assert(type(minValue) == "number", "CreateSlider: 'minValue' needs to be a number")
    else
        -- Default.
        minValue = 1
    end
    if maxValue then
        assert(type(maxValue) == "number" and maxValue >= minValue, "CreateSlider: 'maxValue' needs to be a number >= 'minValue'")
    else
        -- Default.
        maxValue = 10
    end
    slider:SetObeyStepOnDrag(obeyStep)
    slider:SetMinMaxValues(minValue, maxValue)
    slider:SetValue(minValue)
    slider:SetValueStep(1)
    slider:SetThumbTexture(thumbTexture)
    local size = isHorizontal and slider:GetHeight() - THUMB_PADDING or slider:GetWidth() - THUMB_PADDING
    slider:GetThumbTexture():SetSize(size, size)
    slider.disableR = 0.3
    slider.disableG = 0.3
    slider.disableB = 0.3
    slider.disableA = 1
    slider.normalR = 1
    slider.normalG = 1
    slider.normalB = 1
    slider.normalA = 1
    slider.SetNormalColor = SetNormalColor
    slider.ResetNormalColor = ResetNormalColor
    slider.SetDisableColor = SetDisableColor
    slider.ResetDisableColor = ResetDisableColor
    if not slider:HookScript("OnSizeChanged", Slider_OnSizeChanged) then
        return
    end
    if not slider:HookScript("OnDisable", Slider_OnDisable) then
        return
    end
    if not slider:HookScript("OnEnable", Slider_OnEnable) then
        return
    end
    if not slider:HookScript("OnValueChanged", Slider_OnValueChanged) then
        return
    end
    -- Up button.
    if upTexture then
        local upButton = CreateFrame("Button", frameName and frameName .. "CUIUpButton", slider)
        if not CUI:ApplyTemplate(upButton, CUI.templates.HighlightFrameTemplate) then
            return
        end
        if not CUI:ApplyTemplate(upButton, CUI.templates.BorderedFrameTemplate) then
            return
        end
        if not CUI:ApplyTemplate(upButton, CUI.templates.PushableFrameTemplate) then
            return
        end
        upButton:SetSize(DEFAULT_SIZE, DEFAULT_SIZE)
        local texture = upButton:CreateTexture(nil, "BACKGROUND")
        texture:SetTexture(upTexture)
        texture:SetAllPoints(upButton)
        upButton.texture = texture
        if not isHorizontal then
            upButton:SetPoint("BOTTOM", slider, "TOP", 0, 2)
        else
            upButton:SetPoint("BOTTOMRIGHT", slider, "BOTTOMLEFT", -1, 0)
        end
        if not upButton:HookScript("OnDisable", Button_OnDisable) then
            return
        end
        if not upButton:HookScript("OnEnable", Button_OnEnable) then
            return
        end
        if not upButton:HookScript("OnClick", UpButton_OnClick) then
            return
        end
        upButton:Disable()
        slider.upButton = upButton
    end
    -- Down button.
    if downTexture then
        local downButton = CreateFrame("Button", frameName and frameName .. "CUIDownButton", slider)
        if not CUI:ApplyTemplate(downButton, CUI.templates.HighlightFrameTemplate) then
            return
        end
        if not CUI:ApplyTemplate(downButton, CUI.templates.BorderedFrameTemplate) then
            return
        end
        if not CUI:ApplyTemplate(downButton, CUI.templates.PushableFrameTemplate) then
            return
        end
        downButton:SetSize(DEFAULT_SIZE, DEFAULT_SIZE)
        local texture = downButton:CreateTexture(nil, "BACKGROUND")
        texture:SetTexture(downTexture)
        texture:SetAllPoints(downButton)
        downButton.texture = texture
        if not isHorizontal then
            downButton:SetPoint("TOP", slider, "BOTTOM", 0, -2)
        else
            downButton:SetPoint("BOTTOMLEFT", slider, "BOTTOMRIGHT", 1, 0)
        end
        if not downButton:HookScript("OnDisable", Button_OnDisable) then
            return
        end
        if not downButton:HookScript("OnEnable", Button_OnEnable) then
            return
        end
        if not downButton:HookScript("OnClick", DownButton_OnClick) then
            return
        end
        slider.downButton = downButton
    end
    return slider
end

CUI:RegisterWidgetVersion(widget, version)
