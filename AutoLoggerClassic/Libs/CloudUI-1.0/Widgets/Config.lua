local version, widget = 1, "CONFIG"
local CUI = LibStub and LibStub("CloudUI-1.0")
if not CUI or CUI:GetWidgetVersion(widget) >= version then
    return
end

-- Variables.
local MAX_WIDTH = 200
local MIN_HEIGHT = 200
local MAX_HEIGHT = 600
local WIDGET_MARGIN = 50
local WIDGET_Y_START = -16
local WIDGET_X_START = 10
local currIndex = 1
local scrollParent
local scrollChild
local slider

-- Called when any widget is hovered over.
local function Widget_OnEnter(self)
    self.OnEnter(self)
end

-- Called when mouse leaves a widget.
local function Widget_OnLeave(self)
    self.OnLeave(self)
end

-- Called when the mouse is down on the frame.
local function OnMouseDown(self)
    self:StartMoving()
end

-- Called when the mouse has been released from the frame.
local function OnMouseUp(self)
    self:StopMovingOrSizing()
end

-- Called when the main frame is shown.
local function OnShow(self)
    PlaySound(SOUNDKIT.IG_CHARACTER_INFO_TAB)
end

-- Called when the main frame is hidden.
local function OnHide(self)
    PlaySound(SOUNDKIT.IG_MAINMENU_CLOSE)
end

-- Called when the close button is clicked.
local function CloseButton_OnClick(self)
    scrollParent:Hide()
end

-- Called when the resize button is held.
local function ResizeButton_OnMouseDown(self)
    scrollParent:StartSizing()
end

-- Called when the resize button is released.
local function ResizeButton_OnMouseUp(self)
    scrollParent:StopMovingOrSizing()
end

-- Called when user scrolls in the frame.
local function OnMouseWheel(_, delta)
    -- Dividing by delta is done only to achieve the correct sign (negative/positive). Delta is always 1.
    slider:SetValue(slider:GetValue() - slider:GetValueStep() / delta)
end

-- Called when the slider value changes (either due to scroll, clicking the up/down buttons or manually dragging the knob).
local function Slider_OnValueChanged(self, value)
    scrollParent:SetVerticalScroll(value)
end

-- Add the given widgets to the frame.
local function AddWidgets(self, widgets)
    assert(type(widgets) == "table" and #widgets > 0, "CreateLinkButton: 'widgets' needs to be a non-empty table")
    local fontInstance = CUI:GetFontNormal()
    local maxWidth = MAX_WIDTH
    while (currIndex <= #widgets) do
        local widget = widgets[currIndex]
        if not widget:HookScript("OnEnter", Widget_OnEnter) then
            return
        end
        if not widget:HookScript("OnLeave", Widget_OnLeave) then
            return
        end
        local desc = widget:CreateFontString(nil, "BACKGROUND", fontInstance:GetName())
        desc:SetText(widget.desc)
        desc:SetPoint("TOPLEFT", scrollChild, "TOPLEFT", WIDGET_X_START, -WIDGET_MARGIN * currIndex - WIDGET_Y_START)
        widget.fontString = desc
        widget:SetPoint("TOPLEFT", desc, "BOTTOMLEFT", 3, -4)
        if widget:GetWidth() > maxWidth then
            maxWidth = widget:GetWidth()
        elseif desc:GetWidth() > maxWidth then
            maxWidth = desc:GetWidth()
        end
        currIndex = currIndex + 1
    end
    MAX_WIDTH = maxWidth > MAX_WIDTH and maxWidth + 20 + slider:GetWidth() or MAX_WIDTH
    scrollParent:SetResizeBounds(MAX_WIDTH, MIN_HEIGHT, MAX_WIDTH, MAX_HEIGHT)
    scrollParent:SetSize(MAX_WIDTH, MIN_HEIGHT)
end

-- Called when the scroll range has changed for the scroll frame.
local function OnScrollRangeChanged(self, _, yrange)
    slider:SetMinMaxValues(1, yrange + 16)
end

-- Creates a config frame that will automatically add the given widgets to it in the order given. Will automatically resize all widgets.
function CUI:CreateConfig(parentFrame, frameName, titleText, closeButtonTexture, minValue, maxValue, thumbTexture, upTexture, downTexture)
    -- The scroll frame.
    scrollParent = CreateFrame("ScrollFrame", frameName and frameName .. "ScrollFrame", parentFrame or UIParent)
    scrollParent:SetMovable(true)
    scrollParent:SetResizable(true)
    scrollParent:SetClampedToScreen(true)
    scrollParent:SetFrameStrata("HIGH")
    scrollParent:SetPoint("CENTER")
    if not CUI:ApplyTemplate(scrollParent, CUI.templates.BorderedFrameTemplate) then
        return
    end
    if not CUI:ApplyTemplate(scrollParent, CUI.templates.BackgroundFrameTemplate) then
        return
    end
    if not scrollParent:HookScript("OnMouseDown", OnMouseDown) then
        return
    end
    if not scrollParent:HookScript("OnMouseUp", OnMouseUp) then
        return
    end
    if not scrollParent:HookScript("OnShow", OnShow) then
        return
    end
    if not scrollParent:HookScript("OnHide", OnHide) then
        return
    end
    if not scrollParent:HookScript("OnMouseWheel", OnMouseWheel) then
        return
    end
    if not scrollParent:HookScript("OnScrollRangeChanged", OnScrollRangeChanged) then
        return
    end
    tinsert(UISpecialFrames, scrollParent:GetName())
    scrollParent.AddWidgets = AddWidgets

    -- Title frame.
    local titleFrame = CreateFrame("Frame", frameName and frameName .. "TitleFrame", scrollParent)
    titleFrame:SetSize(1, 24)
    titleFrame:SetPoint("TOPLEFT")
    titleFrame:SetPoint("TOPRIGHT")
    if not CUI:ApplyTemplate(titleFrame, CUI.templates.BorderedFrameTemplate) then
        return
    end
    if not CUI:ApplyTemplate(titleFrame, CUI.templates.BackgroundFrameTemplate) then
        return
    end
    local title = titleFrame:CreateFontString(nil, "BACKGROUND", CUI:GetFontBig():GetName())
    title:SetText(titleText)
    title:SetPoint("TOPLEFT", 4, -6)

    -- Close button.
    if closeButtonTexture then
        local closeButton = CreateFrame("Button", frameName and frameName .. "CloseButton", titleFrame)
        if not CUI:ApplyTemplate(closeButton, CUI.templates.HighlightFrameTemplate) then
            return
        end
        if not CUI:ApplyTemplate(closeButton, CUI.templates.PushableFrameTemplate) then
            return
        end
        if not CUI:ApplyTemplate(closeButton, CUI.templates.BorderedFrameTemplate) then
            return
        end
        local size = titleFrame:GetHeight()
        closeButton:SetSize(size, size)
        local texture = closeButton:CreateTexture(nil, "ARTWORK")
        texture:SetTexture(closeButtonTexture)
        texture:SetAllPoints()
        closeButton.texture = texture
        closeButton:SetPoint("TOPRIGHT")
        if not closeButton:HookScript("OnClick", CloseButton_OnClick) then
            return
        end
    end

    -- Slider.
    slider = CUI:CreateSlider(scrollParent, frameName and frameName .. "Slider", minValue, maxValue, false,
                              "Interface/Addons/ClassicGuideMaker/Media/ThumbTexture", "Interface/Addons/ClassicGuideMaker/Media/UpButton",
                              "Interface/Addons/ClassicGuideMaker/Media/DownButton", false, {Slider_OnValueChanged})
    slider:SetPoint("TOPRIGHT", 0, -titleFrame:GetHeight() - 19)
    slider:SetPoint("BOTTOMRIGHT", 0, 18)
    slider:SetValueStep(50)
    scrollParent.slider = slider

    if title:GetWidth() > MAX_WIDTH then
        MAX_WIDTH = title:GetWidth() + 20 + slider:GetWidth()
    end
    scrollParent:SetResizeBounds(MAX_WIDTH, MIN_HEIGHT, MAX_WIDTH, MAX_HEIGHT)
    scrollParent:SetSize(MAX_WIDTH, MIN_HEIGHT)

    -- Child frame.
    scrollChild = CreateFrame("Frame", frameName, scrollParent)
    scrollParent:SetScrollChild(scrollChild)
    scrollChild:SetSize(MAX_WIDTH, 1)
    scrollParent.widgetFrame = scrollChild

    -- Resize button.
    local resizeButton = CreateFrame("Button", frameName and frameName .. "ResizeButton", scrollParent)
    resizeButton:SetFrameLevel(3)
    resizeButton:SetSize(16, 16)
    resizeButton:SetPoint("BOTTOMRIGHT", -slider:GetWidth(), -1)
    resizeButton:SetNormalTexture("Interface/ChatFrame/UI-ChatIM-SizeGrabber-Up")
    resizeButton:SetHighlightTexture("Interface/ChatFrame/UI-ChatIM-SizeGrabber-Highlight")
    resizeButton:SetPushedTexture("Interface/ChatFrame/UI-ChatIM-SizeGrabber-Down")
    if not resizeButton:HookScript("OnMouseDown", ResizeButton_OnMouseDown) then
        return
    end
    if not resizeButton:HookScript("OnMouseUp", ResizeButton_OnMouseUp) then
        return
    end

    return scrollParent
end
