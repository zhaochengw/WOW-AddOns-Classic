local _, AutoLoggerClassic = ...

local GetInstanceInfo, LoggingCombat = GetInstanceInfo, LoggingCombat

-- UI variables.
local X_START = 16
local X_SPACING = 200
local Y_SPACING = -25
local BUTTONS_PER_ROW = 3

-- Variables.
local hasInitialized = false -- true if init has been called.
local minimapIcon = LibStub("LibDBIcon-1.0")
local buttons = {}
local classicRaids = {
    [249] = "Onyxia's Lair",
    [409] = "Molten Core",
    [309] = "Zul'Gurub",
    [469] = "Blackwing Lair",
    [509] = "AQ20",
    [531] = "AQ40",
    [533] = "Naxxramas",
}
local tbcRaids = {
    [532] = "Karazhan",
    [544] = "Magtheridon's Lair",
    [565] = "Gruul's Lair",
    [548] = "Serpentshrine Cavern",
    [550] = "Tempest Keep",
    [534] = "Battle for Mount Hyjal",
    [564] = "Black Temple",
    [568] = "Zul'Aman",
    [580] = "Sunwell Plateau"
}

local tbcDungeons = {
    [269] = "The Black Morass",
    [540] = "The Shattered Halls",
    [542] = "The Blood Furnace",
    [543] = "Hellfire Ramparts",
    [545] = "The Steamvault",
    [546] = "The Underbog",
    [547] = "The Slave Pens",
    [552] = "The Arcatraz",
    [553] = "The Botanica",
    [554] = "The Mechanar",
    [555] = "Shadow Labyrinth",
    [556] = "Sethekk Halls",
    [557] = "Mana-Tombs",
    [558] = "Auchenai Crypts",
    [560] = "Old Hillsbrad Foothills",
    [585] = "Magisters' Terrace"
}

local wlkRaids = {
    [615] = "黑曜石圣殿",
    [616] = "永恒之眼",
    [533] = "纳克萨玛斯",
    [624] = "阿尔卡冯的宝库",
    [603] = "奥杜尔",
    [649] = "十字军的试炼",
    [249] = "奥妮克希亚的巢穴",
    [631] = "冰冠堡垒",
    [724] = "晶红圣殿",

}

-- Shows or hides the addon.
local function toggleFrame()
    if AutoLoggerClassicFrame:IsVisible() then
        AutoLoggerClassicFrame:Hide()
    else
        AutoLoggerClassicFrame:Show()
    end
end

-- Shows or hides the minimap button.
local function toggleMinimapButton()
    ALCOptions.minimapTable.hide = not ALCOptions.minimapTable.hide
    if ALCOptions.minimapTable.hide then
        minimapIcon:Hide("AutoLoggerClassic")
        print("|cFFFFFF00AutoLoggerClassic:|r Minimap button hidden. Type /alc minimap to show it again.")
    else
        minimapIcon:Show("AutoLoggerClassic")
    end
end

-- Initializes the minimap button.
local function initMinimapButton()
    local obj = LibStub:GetLibrary("LibDataBroker-1.1"):NewDataObject("AutoLoggerClassic", {
        type = "launcher",
        text = "AutoLoggerClassic",
        icon = "Interface/ICONS/Trade_Engineering",
        OnClick = function(self, button)
            if button == "LeftButton" then
                toggleFrame()
            elseif button == "RightButton" then
                toggleMinimapButton()
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
        end
    })
    minimapIcon:Register("AutoLoggerClassic", obj, ALCOptions.minimapTable)
end

-- Sets slash commands.
local function initSlash()
    SLASH_AutoLoggerClassic1 = "/AutoLoggerClassic"
    SLASH_AutoLoggerClassic2 = "/alc"
    SlashCmdList["AutoLoggerClassic"] = function(msg)
        msg = msg:lower()
        if msg == "minimap" then
            toggleMinimapButton()
            return
        end
        toggleFrame()
    end
end

-- Initializes all checkboxes.
local function initCheckButtons(yStart, raidTable)
    local index = 1
    for k, v in pairs(raidTable) do
        -- Checkbuttons.
        local checkButton = CreateFrame("CheckButton", nil, AutoLoggerClassicFrame, "UICheckButtonTemplate")
        local x = X_START + X_SPACING * ((index - 1) % BUTTONS_PER_ROW)
        local y = yStart + Y_SPACING * math.ceil(index / BUTTONS_PER_ROW) - 10
        checkButton:SetPoint("TOPLEFT", x, y)
        checkButton:SetScript("OnClick", AutoLoggerClassicCheckButton_OnClick)
        checkButton.instance = k
        checkButton:SetChecked(ALCOptions.instances[k])
        buttons[#buttons + 1] = checkButton
        -- Strings.
        local string = AutoLoggerClassicFrame:CreateFontString(nil, "ARTWORK", "AutoLoggerClassicStringTemplate")
        string:SetPoint("LEFT", checkButton, "RIGHT", 5, 0)
        string:SetText(v)
        index = index + 1
    end
end

-- Initializes everything.
local function init()
    initMinimapButton()
    initSlash()
    initCheckButtons(0, tbcRaids)
    initCheckButtons(-106, tbcDungeons)
    initCheckButtons(-286, classicRaids)
    initCheckButtons(-386, wlkRaids)
    tinsert(UISpecialFrames, AutoLoggerClassicFrame:GetName())
end

local function shouldLogCurrentInstance()
    local _, instanceType, _, difficulty, _, _, _, id = GetInstanceInfo()
    return ALCOptions.instances[id] and (instanceType == "raid" or (instanceType == "party" and difficulty == "Heroic"))
end

-- Toggles logging if player is not logging and is in the right instance.
local function toggleLogging()
    if not LoggingCombat() and shouldLogCurrentInstance() then
        LoggingCombat(true)
        print("|cFFFFFF00AutoLoggerClassic|r: Combat logging enabled.")
    elseif LoggingCombat() and not shouldLogCurrentInstance() then
        LoggingCombat(false)
        print("|cFFFFFF00AutoLoggerClassic|r: Combat logging disabled.")
    end
end

-- Called when player clicks a checkbutton.
function AutoLoggerClassicCheckButton_OnClick(self)
    ALCOptions.instances[self.instance] = not ALCOptions.instances[self.instance]
    toggleLogging()
end

-- Called when addon has been loaded.
function AutoLoggerClassic_OnLoad(self)
    self:RegisterForDrag("LeftButton")
    self:RegisterEvent("ADDON_LOADED")
    self:RegisterEvent("PLAYER_ENTERING_WORLD")
    self:RegisterEvent("RAID_INSTANCE_WELCOME")
    self:RegisterEvent("UPDATE_INSTANCE_INFO")
end

-- Handles all events.
function AutoLoggerClassic_OnEvent(self, event, ...)
    if event == "ADDON_LOADED" and ... == "AutoLoggerClassic" then
        ALCOptions = ALCOptions or {}
        ALCOptions.minimapTable = ALCOptions.minimapTable or {}
        if not ALCOptions.instances or ALCOptions.instances[269] == nil then -- Check for 269 because if player had addon already all TBC heroic raids will be off by default.
            ALCOptions.instances = {
                -- Classic raids:
                [249] = true, -- Onyxia's Lair
                [409] = true, -- Molten Core
                [309] = true, -- Zul'Gurub
                [469] = true, -- Blackwing Lair
                [509] = true, -- Ruins of Ahn'Qiraj (AQ20)
                [531] = true, -- Temple of Ahn'Qiraj (AQ40)
                [533] = true, -- Naxxramas
                -- The Burning Crusade raids:
                [532] = true, -- Karazhan
                [544] = true, -- Magtheridon's Lair
                [565] = true, -- Gruul's Lair
                [548] = true, -- Serpentshrine Cavern
                [550] = true, -- Tempest Keep
                [534] = true, -- Battle for Mount Hyjal
                [564] = true, -- Black Temple
                [568] = true, -- Zul'Aman
                [580] = true, -- Sunwell Plateau
                [615] = true, -- The Obsidian Sanctum
                -- The Burning Crusade dungeons:
                [269] = true, -- The Black Morass
                [540] = true, -- The Shattered Halls
                [542] = true, -- The Blood Furnace
                [543] = true, -- Hellfire Ramparts
                [545] = true, -- The Steamvault
                [546] = true, -- The Underbog
                [547] = true, -- The Slave Pens
                [552] = true, -- The Arcatraz
                [553] = true, -- The Botanica
                [554] = true, -- The Mechanar
                [555] = true, -- Shadow Labyrinth
                [556] = true, -- Sethekk Halls
                [557] = true, -- Mana-Tombs
                [558] = true, -- Auchenai Crypts
                [560] = true, -- Old Hillsbrad Foothills
                [585] = true, -- Magisters' Terrace
                -- WLKraids
                [615] = true, --黑曜石圣殿
                [616] = true, --永恒之眼
                [533] = true, --纳克萨玛斯
                [624] = true, --阿尔卡冯的宝库
                [603] = true, --奥杜尔
                [649] = true, --十字军的试炼
                [249] = true, --奥妮克希亚的巢穴
                [631] = true, --冰冠堡垒
                [724] = true, --晶红圣殿
            }
        end
        print("|cFFFFFF00AutoLoggerClassic|r loaded! Type /alc to toggle options. Remember to enable advanced combat logging in Interface > Network and clear your combat log often.")
    elseif event == "RAID_INSTANCE_WELCOME" or event == "UPDATE_INSTANCE_INFO" then
        -- PLAYER_ENTERING_WORLD fires on dungeon entry. The difficulty value is
        -- not available until an UPDATE_INSTANCE_INFO event fires.
        -- On dungeon exit combat logging may be automatically disabled and the
        -- message will not display in this case. This is not consistent.
        toggleLogging()
    elseif event == "PLAYER_ENTERING_WORLD" then
        if not hasInitialized then
            init()
            AutoLoggerClassicFrame:Hide()
            hasInitialized = true
        end
        toggleLogging()
    end
end
