local version, widget = 1, "BASETEMPLATES"
local CUI = LibStub and LibStub("CloudUI-1.0")
if not CUI or CUI:GetWidgetVersion(widget) >= version then
    return
end

-- Variables.
local fontSmall, fontNormal, fontBig, fontHuge

-- Script handlers.

-- Called when the given frame is disabled.
local function DisableableFrame_OnDisable(self)
    self.isDisabled = true
    if self.CUIHighlightTexture then
        self.CUIHighlightTexture:Hide()
    end
    if self.CUIPushTexture then
        self.CUIPushTexture:Hide()
    end
end

-- Called when the given frame is enabled.
local function DisableableFrame_OnEnable(self)
    self.isDisabled = false
    if self.CUIHighlightTexture then
        self.CUIHighlightTexture:Show()
    end
    if self.CUIPushTexture then
        self.CUIPushTexture:Show()
    end
end

-- Called when the mouse enters the given frame.
local function HighlightFrame_OnEnter(self)
    if not self.isDisabled then
        self.CUIHighlightTexture:Show()
    end
end

-- Called then the mouse leaves the given frame.
local function HighlightFrame_OnLeave(self)
    self.CUIHighlightTexture:Hide()
end

-- Called when a mouse button is pressed on the given frame.
local function PushableFrame_OnMouseDown(self, button)
    if not self.isDisabled then
        if self.CUIHighlightTexture then
            self.CUIHighlightTexture:Hide()
        end
        self.CUIPushTexture:Show()
    end
end

-- Called when a mouse button is released on the given frame.
local function PushableFrame_OnMouseUp(self)
    self.CUIPushTexture:Hide()
    if self.CUIHighlightTexture then
        self.CUIHighlightTexture:Show()
    end
end

-- Template functions.

-- Returns true if the given frame is disabled, false otherwise.
local function IsDisabled(self)
    return self.isDisabled
end

-- Sets the color of the frame's background texture to the given values.
local function SetBackgroundColor(self, r, g, b, a)
    self.CUIBackgroundTexture:SetColorTexture(r, g, b, a)
end

-- Resets the given frame's background texture color.
local function ResetBackgroundColor(self)
    self.CUIBackgroundTexture:SetColorTexture(0, 0, 0, 1)
end

-- Sets the colors of the given frame's border textures to the given values.
local function SetBorderColor(self, r, g, b, a)
    self.CUITopBorderTexture:SetColorTexture(r, g, b, a)
    self.CUIRightBorderTexture:SetColorTexture(r, g, b, a)
    self.CUIBottomBorderTexture:SetColorTexture(r, g, b, a)
    self.CUILeftBorderTexture:SetColorTexture(r, g, b, a)
end

-- Resets the given frame's border textures' color.
local function ResetBorderColor(self)
    self:SetBorderColor(1, 1, 1, 1)
end

-- Sets the given frame's highlight texture color to the given values.
local function SetHighlightColor(self, r, g, b, a)
    self.CUIHighlightTexture:SetColorTexture(r, g, b, a)
end

-- Resets the given frame's highlight texture color.
local function ResetHighlightColor(self)
    self.CUIHighlightTexture:SetColorTexture(1, 1, 1, 0.3)
end

-- Sets the given frame's push texture color to the given values.
local function SetPushColor(self, r, g, b, a)
    self.CUIPushTexture:SetColorTexture(r, g, b, a)
end

-- Resets the given frame's push texture color.
local function ResetPushColor(self)
    self.CUIPushTexture:SetColorTexture(1, 1, 1, 0.6)
end

-- Applies the given template to the given frame. Returns true if successful, false otherwise.
function CUI:ApplyTemplate(frame, template)
    assert(CUI.templates[template], "ApplyTemplate: 'template' needs to be a valid template e.g. CUI.templates.BackgroundFrameTemplate")
    local frameName = frame:GetName()
    if template == CUI.templates.DisableableFrameTemplate then
        if frame.disableableFrameTemplate then
            -- We've already applied this template.
            return false
        end
        if not frame:HookScript("OnDisable", DisableableFrame_OnDisable) then
            -- HookScript() returns false if the hook was unsuccessful.
            return false
        end
        if not frame:HookScript("OnEnable", DisableableFrame_OnEnable) then
            return false
        end
        -- Frame should be disableable regardless of if it's already enableable (buttons etc).
        frame.isDisabled = frame.IsEnabled and not frame:IsEnabled() or false
        frame.IsDisabled = IsDisabled
        frame.disableableFrameTemplate = true
    elseif template == CUI.templates.BackgroundFrameTemplate then
        if frame.backgroundFrameTemplate then
            return false
        end
        local CUIBackgroundTexture = frame:CreateTexture(frameName and frameName .. "CUIBackgroundTexture" or nil, "BACKGROUND")
        CUIBackgroundTexture:SetColorTexture(0, 0, 0, 1)
        CUIBackgroundTexture:SetAllPoints(frame)
        frame.CUIBackgroundTexture = CUIBackgroundTexture
        frame.SetBackgroundColor = SetBackgroundColor
        frame.ResetBackgroundColor = ResetBackgroundColor
        frame.backgroundFrameTemplate = true
    elseif template == CUI.templates.BorderedFrameTemplate then
        if frame.borderedFrameTemplate then
            return false
        end
        local CUITopBorderTexture = frame:CreateTexture(frameName and frameName .. "CUITopBorderTexture" or nil, "BORDER")
        CUITopBorderTexture:SetColorTexture(1, 1, 1, 1)
        CUITopBorderTexture:SetPoint("BOTTOMLEFT", frame, "TOPLEFT", -1, 0)
        CUITopBorderTexture:SetPoint("BOTTOMRIGHT", frame, "TOPRIGHT", 1, 0)
        frame.CUITopBorderTexture = CUITopBorderTexture
        local CUIRightBorderTexture = frame:CreateTexture(frameName and frameName .. "CUIRightBorderTexture" or nil, "BORDER")
        CUIRightBorderTexture:SetColorTexture(1, 1, 1, 1)
        CUIRightBorderTexture:SetPoint("BOTTOMLEFT", frame, "BOTTOMRIGHT", 0, -1)
        CUIRightBorderTexture:SetPoint("TOPLEFT", frame, "TOPRIGHT", 0, 1)
        frame.CUIRightBorderTexture = CUIRightBorderTexture
        local CUIBottomBorderTexture = frame:CreateTexture(frameName and frameName .. "CUIBottomBorderTexture" or nil, "BORDER")
        CUIBottomBorderTexture:SetColorTexture(1, 1, 1, 1)
        CUIBottomBorderTexture:SetPoint("TOPLEFT", frame, "BOTTOMLEFT", -1, 0)
        CUIBottomBorderTexture:SetPoint("TOPRIGHT", frame, "BOTTOMRIGHT", 1, 0)
        frame.CUIBottomBorderTexture = CUIBottomBorderTexture
        local CUILeftBorderTexture = frame:CreateTexture(frameName and frameName .. "CUILeftBorderTexture" or nil, "BORDER")
        CUILeftBorderTexture:SetColorTexture(1, 1, 1, 1)
        CUILeftBorderTexture:SetPoint("BOTTOMRIGHT", frame, "BOTTOMLEFT", 0, -1)
        CUILeftBorderTexture:SetPoint("TOPRIGHT", frame, "TOPLEFT", 0, 1)
        frame.CUILeftBorderTexture = CUILeftBorderTexture
        frame.SetBorderColor = SetBorderColor
        frame.ResetBorderColor = ResetBorderColor
        frame.borderedFrameTemplate = true
    elseif template == CUI.templates.HighlightFrameTemplate then
        if frame.highlightFrameTemplate then
            return false
        end
        local CUIHighlightTexture = frame:CreateTexture(frameName and frameName .. "CUIHighlightTexture" or nil, "HIGHLIGHT")
        CUIHighlightTexture:SetColorTexture(1, 1, 1, 0.3)
        CUIHighlightTexture:SetAllPoints(frame)
        CUIHighlightTexture:Hide()
        frame.CUIHighlightTexture = CUIHighlightTexture
        frame.SetHighlightColor = SetHighlightColor
        frame.ResetHighlightColor = ResetHighlightColor
        if not frame:HookScript("OnEnter", HighlightFrame_OnEnter) then
            return false
        end
        if not frame:HookScript("OnLeave", HighlightFrame_OnLeave) then
            return false
        end
        frame.highlightFrameTemplate = true
    elseif template == CUI.templates.PushableFrameTemplate then
        if frame.pushableFrameTemplate then
            return false
        end
        local CUIPushTexture = frame:CreateTexture(frameName and frameName .. "CUIPushTexture" or nil, "HIGHLIGHT")
        CUIPushTexture:SetColorTexture(1, 1, 1, 0.6)
        CUIPushTexture:SetAllPoints(frame)
        CUIPushTexture:Hide()
        frame.CUIPushTexture = CUIPushTexture
        frame.SetPushColor = SetPushColor
        frame.ResetPushColor = ResetPushColor
        if not frame:HookScript("OnMouseDown", PushableFrame_OnMouseDown) then
            return false
        end
        if not frame:HookScript("OnMouseUp", PushableFrame_OnMouseUp) then
            return false
        end
        frame.pushableFrameTemplate = true
    end
    return true
end

-- Initializes the base templates.
local function InitFonts()
    -- Fonts.
    fontSmall = CreateFont("CUIFontSmallTemplate")
    fontSmall:SetFont("Fonts/FRIZQT__.ttf", 10, "OUTLINE")
    fontNormal = CreateFont("CUIFontNormalTemplate")
    fontNormal:SetFont("Fonts/FRIZQT__.ttf", 12, "OUTLINE")
    fontBig = CreateFont("CUIFontBigTemplate")
    fontBig:SetFont("Fonts/FRIZQT__.ttf", 14, "OUTLINE")
    fontHuge = CreateFont("CUIFontHugeTemplate")
    fontHuge:SetFont("Fonts/FRIZQT__.ttf", 16, "OUTLINE")
    -- Frames.
    local disableableFrame = CreateFrame("Frame", "CUIDisableableFrameTemplate", UIParent)
end

-- Returns the small font object.
function CUI:GetFontSmall()
    return fontSmall
end

-- Returns the normal font object.
function CUI:GetFontNormal()
    return fontNormal
end

-- Returns the big font object.
function CUI:GetFontBig()
    return fontBig
end

-- Returns the huge font object.
function CUI:GetFontHuge()
    return fontHuge
end

InitFonts()

CUI:RegisterWidgetVersion(widget, version)
