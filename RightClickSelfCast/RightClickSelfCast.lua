-- RightClickSelfCast
-- Makes right-click on action buttons self-cast on the player

local ADDON_NAME, addon = ...
if not _G[ADDON_NAME] then
    _G[ADDON_NAME] = CreateFrame(
        "Frame",
        ADDON_NAME,
        UIParent,
        BackdropTemplateMixin and "BackdropTemplate"
    )
end
addon = _G[ADDON_NAME]

local function SafeRegisterEvent(frame, event)
    pcall(frame.RegisterEvent, frame, event)
end

local function SafeUnregisterEvent(frame, event)
    pcall(frame.UnregisterEvent, frame, event)
end

local actionbarEvents = {
    "ACTIONBAR_SLOT_CHANGED",
    "ACTIONBAR_PAGE_CHANGED",
    "ACTIONBAR_UPDATE_STATE",
    "UPDATE_MULTI_ACTIONBAR",
    "UPDATE_BONUS_ACTIONBAR",
    "UPDATE_OVERRIDE_ACTIONBAR",
    "UPDATE_VEHICLE_ACTIONBAR",
    "UPDATE_SHAPESHIFT_BAR",
    "UPDATE_POSSESS_BAR",
    "UPDATE_EXTRA_ACTIONBAR",
}

SafeRegisterEvent(addon, "PLAYER_LOGIN")
SafeRegisterEvent(addon, "PLAYER_REGEN_ENABLED")
for _, event in ipairs(actionbarEvents) do
    SafeRegisterEvent(addon, event)
end

-------------------------------------------------------
-- Button Queue System for Combat Safety
-------------------------------------------------------
local queuedButtons = {} -- Queue of buttons that need unit2 set to "player"

local function QueueButtonForSelfCast(button)
    if not button or not button.GetName then return end
    local buttonName = button:GetName()
    if buttonName and not queuedButtons[buttonName] then
        queuedButtons[buttonName] = true
    end
end

local function ProcessButtonQueue()
    if InCombatLockdown() or UnitAffectingCombat("player") then
        return false
    end

    for buttonName, _ in pairs(queuedButtons) do
        local button = _G[buttonName]
        if button and button.GetAttribute and button.SetAttribute then
            local success, _ = pcall(function()
                if button:GetAttribute("type") == "action" and button:GetAttribute("unit2") ~= "player" then
                    button:SetAttribute("unit2", "player")
                end
            end)
            -- Remove from queue regardless of success/failure to avoid infinite loop
            queuedButtons[buttonName] = nil
        else
            -- Button no longer valid, remove from queue
            queuedButtons[buttonName] = nil
        end
    end

    return true
end

-------------------------------------------------------
-- Core logic
-------------------------------------------------------
local blizzardBars = {
    "MainMenuBarArtFrame",
    "MainMenuBar",
    "MultiBarBottomLeft",
    "MultiBarBottomRight",
    "MultiBarRight",
    "MultiBarLeft",
    "MultiBar5",
    "MultiBar6",
    "MultiBar7",
    "MultiBar8",
    "PossessBarFrame",
}

local function ApplyBlizzardBarFallback()
    if InCombatLockdown() or UnitAffectingCombat("player") then
        return false
    end

    for _, barName in ipairs(blizzardBars) do
        local bar = _G[barName]
        if bar and bar.GetAttribute and bar.SetAttribute then
            if bar:GetAttribute("unit2") ~= "player" then
                bar:SetAttribute("unit2", "player")
            end
        end
    end

    return true
end

local fallbackApplied = false
local lastFallbackAttempt = 0
local fallbackThrottleSeconds = 1.0

local function EnsureBlizzardFallback(self)
    if fallbackApplied then
        return
    end
    local now = GetTime and GetTime() or 0
    if now > 0 and (now - lastFallbackAttempt) < fallbackThrottleSeconds then
        return
    end
    lastFallbackAttempt = now
    if not ApplyBlizzardBarFallback() then
        self:RegisterEvent("PLAYER_REGEN_ENABLED")
        return
    end
    fallbackApplied = true
    for _, event in ipairs(actionbarEvents) do
        SafeUnregisterEvent(self, event)
    end
end

local function ApplySelfCast(button)
    if not button or not button.GetAttribute or not button.SetAttribute then return end
    if button:GetAttribute("type") ~= "action" then return end

    -- Cannot call SetAttribute during combat due to taint protection
    if InCombatLockdown() then
        -- Queue the button to be processed when it's safe
        if button:GetAttribute("unit2") ~= "player" then
            QueueButtonForSelfCast(button)
        end
        return
    end

    -- Apply only if needed
    if button:GetAttribute("unit2") ~= "player" then
        button:SetAttribute("unit2", "player")
    end
end

-------------------------------------------------------
-- Secure click hook (single authoritative path)
-------------------------------------------------------
if type(SecureActionButton_OnClick) == "function" then
    hooksecurefunc("SecureActionButton_OnClick", function(self, mouseButton)
        if mouseButton ~= "RightButton" then return end
        ApplySelfCast(self)
    end)
end

-------------------------------------------------------
-- Events
-------------------------------------------------------
addon:SetScript("OnEvent", function(self, event)
    if event == "PLAYER_LOGIN" then
        EnsureBlizzardFallback(self)
        ProcessButtonQueue()
        local ver = C_AddOns.GetAddOnMetadata(ADDON_NAME, "Version") or "1.0"
        DEFAULT_CHAT_FRAME:AddMessage(
            string.format("|cFF99CC33%s|r [v|cFF20ff20%s|r] loaded", ADDON_NAME, ver)
        )
        return
    end
    if event == "PLAYER_REGEN_ENABLED" then
        EnsureBlizzardFallback(self)
        ProcessButtonQueue()
        if fallbackApplied and next(queuedButtons) == nil then
            self:UnregisterEvent("PLAYER_REGEN_ENABLED")
        end
        return
    end
    EnsureBlizzardFallback(self)
end)
