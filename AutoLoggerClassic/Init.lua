local ADDON_NAME, ns = ...

-- Variables.
local minimapButton = LibStub("LibDBIcon-1.0")
local isLogging = false

-- Localized stuff
local GetInstanceInfo, LoggingCombat = GetInstanceInfo, LoggingCombat

-- Shows or hides the minimap button.
local function ToggleMinimapButton()
    ALCOptions.minimapTable.hide = not ALCOptions.minimapTable.hide
    if ALCOptions.minimapTable.hide then
        minimapButton:Hide("AutoLoggerClassic")
        print("|cFFFFFF00AutoLoggerClassic:|r Minimap button hidden. Type /alc minimap to show it again.")
    else
        minimapButton:Show("AutoLoggerClassic")
    end
end

-- Initializes the minimap button.
local function InitMinimapButton()
    local obj = LibStub:GetLibrary("LibDataBroker-1.1"):NewDataObject("AutoLoggerClassic", {
        type = "launcher",
        text = "AutoLoggerClassic",
        icon = "Interface/ICONS/Trade_Engineering",
        OnClick = function(self, button)
            if button == "LeftButton" then
                ns:ToggleFrame()
            elseif button == "RightButton" then
                ToggleMinimapButton()
            end
        end,
        OnEnter = function(self)
            GameTooltip:SetOwner(self, "ANCHOR_LEFT")
            GameTooltip:AddLine("|cFFFFFFFFAutoLoggerClassic|r")
            GameTooltip:AddLine("Left click to open options.")
            GameTooltip:AddLine("Right click to hide this minimap button.")
            GameTooltip:Show()
        end,
        OnLeave = function(self)
            GameTooltip:Hide()
        end,
    })
    minimapButton:Register("AutoLoggerClassic", obj, ALCOptions.minimapTable)
end

-- Initializes slash commands.
local function InitSlash()
    SLASH_AutoLoggerClassic1 = "/AutoLoggerClassic"
    SLASH_AutoLoggerClassic2 = "/alc"
    SlashCmdList["AutoLoggerClassic"] = function(msg)
        msg = msg:lower()
        if msg == "minimap" then
            ToggleMinimapButton()
            return
        end
        ns:ToggleFrame()
    end
end

-- Loads all saved variables.
local function LoadVariables()
    ALCOptions = ALCOptions or {}
    ALCOptions.minimapTable = ALCOptions.minimapTable or {}
    if not ALCOptions.instances then
        ALCOptions.instances = {}
        -- Default raids to true and dungeons to false.
        for instanceID in pairs(ns.RAIDS) do
            ALCOptions.instances[instanceID] = true
        end
    else
        -- Default new raids to true and dungeons to false.
        for instanceID in pairs(ns.RAIDS) do
            if ALCOptions.instances[instanceID] == nil then
                ALCOptions.instances[instanceID] = true
            end
        end
    end
end

-- Toggles logging if player is not logging and is in the right instance.
function ns:ToggleLogging()
    local id = select(8, GetInstanceInfo())
    if not isLogging and ALCOptions.instances[id] then
        LoggingCombat(true)
        isLogging = true
        print("|cFFFFFF00AutoLoggerClassic|r: Combat logging enabled.")
    elseif isLogging and not ALCOptions.instances[id] then
        LoggingCombat(false)
        isLogging = false
        print("|cFFFFFF00AutoLoggerClassic|r: Combat logging disabled.")
    end
end

-- Called when entering a raid.
function ns:OnRaidInstanceWelcome()
    ns:ToggleLogging()
end

-- Called when most game data is available.
function ns:OnPlayerEnteringWorld()
    ns:ToggleLogging()
end

-- Called on ADDON_LOADED.
function ns:OnAddonLoaded(addonName)
    if addonName == ADDON_NAME then
        LoadVariables()
        InitMinimapButton()
        InitSlash()
        ns:InitMainFrame()
        print(
            "|cFFFFFF00AutoLoggerClassic|r loaded! Type /alc to toggle options. Remember to enable advanced combat logging in Options > Network and clear your combat log often.")
        -- LoggingCombat() can return nil seemingly randomly
        isLogging = LoggingCombat() or false
    end
end

-- Registers for events.
local function Initialize()
    ns.eventFrame = CreateFrame("Frame")
    ns:RegisterAllEvents(ns.eventFrame)
end

Initialize()
