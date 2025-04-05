local version, widget = 1, "LINKBUTTON"
local CUI = LibStub and LibStub("CloudUI-1.0")
if not CUI or CUI:GetWidgetVersion(widget) >= version then
    return
end

-- Script handlers.

-- Called when the user clicks the given button.
local function Button_OnClick(self, button)
    local link = self:GetLink()
    if link and button == "LeftButton" and IsModifiedClick("CHATLINK") then
        ChatEdit_InsertLink(link)
    else
        local callbacks = self.callbacks
        if callbacks and #callbacks > 0 then
            for i = 1, #callbacks do
                callbacks[i](self, button)
            end
        end
    end
end

-- Called when the user's mouse enters the given frame.
local function Button_OnEnter(self)
    local link = self:GetLink()
    if link then
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetHyperlink(link)
        GameTooltip:Show()
    end
end

-- Called when the user's mouse leaves the given frame.
local function Button_OnLeave(self)
    GameTooltip:Hide()
end

-- Template functions.

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

-- Sets the link for the given frame.
local function SetLink(self, link, shouldSetColor, shouldSetIcon)
    self.link = link
    if link then
        local _, _, quality, _, _, _, _, _, _, texture = GetItemInfo(link)
        if shouldSetColor then
            local c = ITEM_QUALITY_COLORS[quality]
            self:SetBorderColor(c.r, c.g, c.b)
        end
        if shouldSetIcon then
            self:SetIcon(texture)
        end
        self:Show()
    else
        self:SetIcon(nil)
        self:ResetBorderColor()
        self:Hide()
    end
end

-- Gets the link for the given frame.
local function GetLink(self)
    return self.link
end

-- Sets the given frame's icon to the given texture.
local function SetIcon(self, texture)
    self.icon:SetTexture(texture)
    if texture then
        self.icon:Show()
    else
        self.icon:Hide()
    end
end

-- Creates a link button in the given parent frame and with the given name, callbacks, and link. Returns false if creating failed.
function CUI:CreateLinkButton(parentFrame, frameName, template, callbacks, link)
    if template then
        assert(type(template) == "string", "CreateLinkButton: 'template' needs to be a string")
    end
    if callbacks then
        assert(type(callbacks) == "table", "CreateLinkButton: 'callbacks' needs to be a table")
    end
    local button = CreateFrame("Button", frameName, parentFrame or UIParent, template)
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
    local icon = button:CreateTexture(frameName and frameName .. "CUILinkButtonIcon" or nil, "ARTWORK")
    icon:SetTexCoord(0.07, 0.93, 0.07, 0.93)
    icon:SetAllPoints()
    icon:Hide()
    button.icon = icon
    -- Default size.
    button:SetSize(34, 34)
    button.SetCallbacks = SetCallbacks
    button.RegisterCallback = RegisterCallback
    button.UnregisterCallback = UnregisterCallback
    button.SetLink = SetLink
    button.GetLink = GetLink
    button.SetIcon = SetIcon
    if link then
        assert(type(link) == "string", "CreateLinkButton: 'link' needs to be a string")
        button:SetLink(link)
    end
    if not button:HookScript("OnClick", Button_OnClick) then
        return false
    end
    if not button:HookScript("OnEnter", Button_OnEnter) then
        return false
    end
    if not button:HookScript("OnLeave", Button_OnLeave) then
        return false
    end
    return button
end

CUI:RegisterWidgetVersion(widget, version)
