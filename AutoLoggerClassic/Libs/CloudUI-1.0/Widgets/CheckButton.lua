local version, widget = 1, "CHECKBUTTON"
local CUI = LibStub and LibStub("CloudUI-1.0")
if not CUI or CUI:GetWidgetVersion(widget) >= version then
    return
end

-- Called when the user clicks the check button.
local function OnClick(self, button)
    self:SetChecked(not self.checked)
    local callbacks = self.callbacks
    if callbacks and #callbacks > 0 then
        for i = 1, #callbacks do
            callbacks[i](self, button)
        end
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

-- Toggles the texture for the check button on or off.
local function ToggleTexture(self)
    if self.checked then
        PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
        self.checkTexture:Show()
    else
        PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_OFF)
        self.checkTexture:Hide()
    end
end

local function SetTexture(self, checkTexture)
    local texture = self:CreateTexture(nil, "ARTWORK")
    texture:SetTexture(checkTexture)
    texture:SetAllPoints()
    self.ToggleTexture = ToggleTexture
    self.checkTexture = texture
end

-- Sets the check button check status to true or false.
local function SetChecked(self, checked)
    self.checked = checked
    if self.checkTexture then
        self:ToggleTexture()
    end
end

-- Creates and returns a CheckButton with the given parent frame, name, callbacks, and checkmark texture.
function CUI:CreateCheckButton(parentFrame, frameName, callbacks, checkTexture)
    if callbacks then
        assert(type(callbacks) == "table" and #callbacks > 0, "CreateCheckButton: 'callbacks' needs to be a non-empty table")
    end
    local checkButton = CreateFrame("CheckButton", frameName, parentFrame or UIParent)
    checkButton.callbacks = callbacks or {}
    if not CUI:ApplyTemplate(checkButton, CUI.templates.BorderedFrameTemplate) then
        return false
    end
    if not CUI:ApplyTemplate(checkButton, CUI.templates.HighlightFrameTemplate) then
        return false
    end
    if not CUI:ApplyTemplate(checkButton, CUI.templates.BackgroundFrameTemplate) then
        return false
    end
    if not CUI:ApplyTemplate(checkButton, CUI.templates.PushableFrameTemplate) then
        return false
    end
    if not CUI:ApplyTemplate(checkButton, CUI.templates.DisableableFrameTemplate) then
        return false
    end
    checkButton:SetSize(16, 16)
    checkButton.SetChecked = SetChecked
    checkButton.SetCallbacks = SetCallbacks
    checkButton.RegisterCallback = RegisterCallback
    checkButton.UnregisterCallback = UnregisterCallback
    checkButton.SetTexture = SetTexture
    if not checkButton:HookScript("OnClick", OnClick) then
        return false
    end
    if checkTexture then
        checkButton:SetTexture(checkTexture)
    end
    return checkButton
end

CUI:RegisterWidgetVersion(widget, version)
