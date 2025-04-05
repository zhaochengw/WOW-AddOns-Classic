local version, widget = 1, "TEXTBUTTON"
local CUI = LibStub and LibStub("CloudUI-1.0")
if not CUI or CUI:GetWidgetVersion(widget) >= version then
    return
end

-- Script handlers.

-- Called when the user clicks the given button.
local function Button_OnClick(self, button)
    local callbacks = self.callbacks
    if callbacks and #callbacks > 0 then
        for i = 1, #callbacks do
            callbacks[i](self, button)
        end
    end
end

-- Template functions.

-- Automatically sizes the button to the current text.
local function AutoSize(self)
    local fontString = self:GetFontString()
    if fontString then
        local textWidth, textHeight = fontString:GetSize()
        local buttonWidth, buttonHeight = self:GetSize()
        if buttonHeight < textHeight then
            -- Minimum 20 in height.
            self:SetHeight(textHeight > 20 and textHeight + 2 or 20)
        end
        self:SetWidth(textWidth + 2)
    end
end

-- Set the given frame's callbacks.
local function SetCallbacks(self, callbacks)
    assert(callbacks and type(callbacks) == "table" and #callbacks > 0, "SetCallbacks: 'callbacks' needs to be a non-empty table")
    self.callbacks = callbacks
end

-- Register the given callback to the given frame.
local function RegisterCallback(self, callback)
    assert(callback and type(callback) == "table" and #callback > 0, "RegisterCallback: 'callback' needs to be a non-empty table")
    self.callbacks[#self.callbacks + 1] = callback
end

-- Unregisters the given callback from the given frame.
local function UnregisterCallback(self, callback)
    if self.callbacks and #self.callbacks > 0 then
        assert(callback and type(callback) == "function", "UnregisterCallback: 'callback' needs to be a function")
        for i = 1, #self.callbacks do
            if self.callbacks[i] == callback then
                table.remove(self.callbacks, i)
            end
        end
    end
end

-- Creates a new button with the given name within the given parent frame and returns it (or false if the button couldn't be created).
-- Callbacks, text, and color code are optional. Callbacks will be called whenever the user clicks the button.
-- If set to true, the button will automatically resize every time the text changes.
function CUI:CreateTextButton(parentFrame, frameName, callbacks, text)
    if callbacks then
        assert(type(callbacks) == "table" and #callbacks > 0, "CreateTextButton: 'callbacks' needs to be a non-empty table")
    end
    local button = CreateFrame("Button", frameName, parentFrame or UIParent)
    button.callbacks = callbacks or {}
    if not CUI:ApplyTemplate(button, CUI.templates.BorderedFrameTemplate) then
        return false
    end
    if not CUI:ApplyTemplate(button, CUI.templates.HighlightFrameTemplate) then
        return false
    end
    if not CUI:ApplyTemplate(button, CUI.templates.PushableFrameTemplate) then
        return false
    end
    if not CUI:ApplyTemplate(button, CUI.templates.BackgroundFrameTemplate) then
        return false
    end
    local fontString = button:CreateFontString(nil, "OVERLAY", CUI:GetFontBig():GetName())
    fontString:SetJustifyH("LEFT")
    fontString:SetPoint("LEFT", 2, 0)
    button:SetFontString(fontString)
    -- Default size.
    button:SetSize(100, 20)
    if text then
        assert(type(text) == "string", "CreateTextButton: 'text' needs to be a string")
        button:SetText(text)
    end
    button.AutoSize = AutoSize
    button.SetCallbacks = SetCallbacks
    button.RegisterCallback = RegisterCallback
    button.UnregisterCallback = UnregisterCallback
    if not button:HookScript("OnClick", Button_OnClick) then
        return false
    end
    return button
end

CUI:RegisterWidgetVersion(widget, version)
