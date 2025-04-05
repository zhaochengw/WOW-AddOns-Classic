local version, widget = 1, "EDITBOX"
local CUI = LibStub and LibStub("CloudUI-1.0")
if not CUI or CUI:GetWidgetVersion(widget) >= version then
    return
end

-- Variables.
local tabGroups = {}

-- Script handlers.

-- Called when enter is pressed inside the given frame.
local function EditBox_OnEnterPressed(self)
    if self.callbacks and #self.callbacks > 0 then
        for i = 1, #self.callbacks do
            self.callbacks[i](self, self:GetText())
        end
    end
end

-- Called when escape is pressed inside the given frame.
local function EditBox_OnEscapePressed(self)
    self:ClearFocus()
end

-- Called when tab is pressed inside the given frame.
local function EditBox_OnTabPressed(self)
    local t = tabGroups[self.tabGroup]
    if t and t.tabCount > 0 then
        local isShiftDown = IsShiftKeyDown()
        local incr = isShiftDown and -1 or 1
        for i = t.currentTabIndex, isShiftDown and t.minTabIndex or t.maxTabIndex, incr do
            -- If the next index is out of bounds, we reach around to the first frame again and vice versa.
            local nextIndex = i + incr > t.maxTabIndex and t.minTabIndex or i + incr < t.minTabIndex and t.maxTabIndex or i + incr
            if t[nextIndex] then
                t.currentTabIndex = nextIndex
                t[t.currentTabIndex]:SetFocus()
                break
            end
        end
    end
end

-- Called when the given frame is given focus.
local function EditBox_OnEditFocusGained(self)
    local t = tabGroups[self.tabGroup]
    if t and t.tabCount > 0 then
        t.currentTabIndex = t[self]
    end
end

-- Called when the given frame is disabled.
local function EditBox_OnDisable(self)
    self:SetTextColor(self.disableR, self.disableG, self.disableB, self.disableA)
end

-- Called when the given frame is enabled.
local function EditBox_OnEnable(self)
    self:SetTextColor(self.normalR, self.normalG, self.normalB, self.normalA)
end

-- Template functions.

-- Sets the normal (enabled) color for the given frame to the given values.
local function SetNormalColor(self, r, g, b, a)
    self.normalR, self.normalG, self.normalB, self.normalA = r, g, b, a
    if not self:IsDisabled() then
        self:SetBackgroundColor(r, g, b, a)
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
        self:SetBackgroundColor(r, g, b, a)
    end
end

-- Resets the disabled color for the given frame.
local function ResetDisableColor(self)
    self.disableR, self.disableG, self.disableB, self.disableA = 0.7, 0.7, 0.7, 1
end

-- Sets the callbacks for the given frame.
local function SetCallbacks(self, callbacks)
    assert(callbacks and type(callbacks) == "table" and #callbacks > 0, "SetCallbacks: 'callbacks' needs to be a non-empty table")
    self.callbacks = callbacks
end

-- Registers the given callback for the given frame.
local function RegisterCallback(self, callback)
    assert(callback and type(callback) == "function", "RegisterCallback: 'callback' needs to be a function")
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

-- Sets the tab index for the given frame within the given tab group.
local function SetTabIndex(self, tabIndex, tabGroup)
    assert(type(self) == "table" and self:GetObjectType() == "EditBox", "SetTabIndex: the frame needs to be an EditBox")
    assert(type(tabGroup) == "string" or type(self.tabGroup) == "string", "SetTabIndex: 'tabGroup' needs to be a string")
    -- If the frame already is in a different tab group than the provided one, remove it from the current tab group.
    if self.tabGroup and tabGroup and self.tabGroup ~= tabGroup then
        local t = tabGroups[self.tabGroup]
        -- The tab group has no members so gc the entire tab group.
        if t.tabCount == 1 then
            tabGroups[self.tabGroup] = nil
        else
            -- Remove the [k, v] and [v, k] pairs otherwise we can tab into the new tab group but get stuck there.
            local index = t[self]
            t[self] = nil
            t[index] = nil
        end
    end
    -- Will always prioritize the new tab group over a potential old one.
    tabGroup = tabGroup or self.tabGroup
    self.tabGroup = tabGroup
    tabGroups[tabGroup] = tabGroups[tabGroup] or {}
    local t = tabGroups[tabGroup]
    t.count = t.count or 0
    t.maxTabIndex = t.maxTabIndex or 0
    t.minTabIndex = t.minTabIndex or 0
    t.tabCount = t.tabCount or 0
    local newIndex
    if tabIndex then
        assert(type(tabIndex) == "number" and tabIndex <= 100 and tabIndex >= -100,
               "SetTabIndex: 'tabIndex' needs to be a number between -100 and 100")
        newIndex = tabIndex
    else
        -- If no tab index is given, assign it whatever the maximum is + 1.
        newIndex = t.maxTabIndex + 1
    end
    -- If the given frame already has an index, remove that index so frames don't have double indeces.
    local oldIndex = t[self]
    if oldIndex then
        t[oldIndex] = nil
    else
        t.tabCount = t.tabCount + 1
    end
    t.maxTabIndex = t.tabCount == 1 and newIndex or newIndex > t.maxTabIndex and newIndex or t.maxTabIndex
    t.minTabIndex = t.tabCount == 1 and newIndex or newIndex < t.minTabIndex and newIndex or t.minTabIndex
    t[newIndex] = self
    t[self] = newIndex
end

-- Returns an EditBox with the given frame as parent and with the given name.
-- If providing a tab group, a tab index is required and vice versa. Assigns the editbox the given tab index in the given tab group, otherwise sets a default
-- incremental tab index. Change tab index/tab group using editBox:SetTabIndex(index[, tabGroup]). Returns false if something went wrong when creating.
function CUI:CreateEditBox(parentFrame, frameName, callbacks, tabGroup, tabIndex)
    if callbacks then
        assert(type(callbacks) == "table" and #callbacks > 0, "CreateEditBox: 'callbacks' needs to be a non-empty table")
    end
    if tabGroup then
        assert(type(tabGroup) == "string", "CreateEditBox: 'tabGroup' needs to be a string")
        if tabIndex then
            assert(type(tabGroup) == "number", "CreateEditBox: 'tabIndex' needs to be a number between -100 and 100")
        end
    end
    -- If parentFrame is nil, the size will be fucked.
    local editBox = CreateFrame("EditBox", frameName, parentFrame or UIParent)
    if not CUI:ApplyTemplate(editBox, CUI.templates.BorderedFrameTemplate) then
        return false
    end
    if not CUI:ApplyTemplate(editBox, CUI.templates.HighlightFrameTemplate) then
        return false
    end
    if not CUI:ApplyTemplate(editBox, CUI.templates.BackgroundFrameTemplate) then
        return false
    end
    if not CUI:ApplyTemplate(editBox, CUI.templates.DisableableFrameTemplate) then
        return false
    end
    editBox:SetAutoFocus(false)
    editBox:SetSize(200, 20)
    editBox:SetFontObject(self:GetFontBig())
    editBox:SetTextInsets(2, 0, 0, 0)
    editBox.callbacks = callbacks or {}
    editBox.disableR = 0.7
    editBox.disableG = 0.7
    editBox.disableB = 0.7
    editBox.disableA = 1
    editBox.normalR = 1
    editBox.normalG = 1
    editBox.normalB = 1
    editBox.normalA = 1
    editBox.SetNormalColor = SetNormalColor
    editBox.ResetNormalColor = ResetNormalColor
    editBox.SetDisableColor = SetDisableColor
    editBox.ResetDisableColor = ResetDisableColor
    editBox.SetCallbacks = SetCallbacks
    editBox.RegisterCallback = RegisterCallback
    editBox.UnregisterCallback = UnregisterCallback
    editBox.SetTabIndex = SetTabIndex
    if not editBox:HookScript("OnEnterPressed", EditBox_OnEnterPressed) then
        return false
    end
    if not editBox:HookScript("OnEscapePressed", EditBox_OnEscapePressed) then
        return false
    end
    if not editBox:HookScript("OnTabPressed", EditBox_OnTabPressed) then
        return false
    end
    if not editBox:HookScript("OnEditFocusGained", EditBox_OnEditFocusGained) then
        return false
    end
    if not editBox:HookScript("OnDisable", EditBox_OnDisable) then
        return false
    end
    if not editBox:HookScript("OnEnable", EditBox_OnEnable) then
        return false
    end
    -- User will have to manually assign their own tab index later if not provided here.
    if tabGroup then
        -- Will assign an index equal to the current max index in the tab group + 1 if tabIndex is nil.
        editBox:SetTabIndex(tabIndex, tabGroup)
    end
    return editBox
end

CUI:RegisterWidgetVersion(widget, version)
