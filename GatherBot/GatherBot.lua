--[[
    GatherBot v2.00:
    Add GUI Config
    Add MinimapButton
    Add custom Tracking Spell Setting
]]

local AddonName, Addon = ...

local L = Addon.L --Localization

Addon.Frame = CreateFrame("Frame", nil, UIParent)
local Frame = Addon.Frame

-- Version String
Addon.Version = C_AddOns.GetAddOnMetadata(AddonName, "Version")

-- GUI and MinimapButton
Addon.SetWindow = {}
Addon.MinimapIcon = {}

local SetWindow = Addon.SetWindow
local MinimapIcon = Addon.MinimapIcon

-- Config Setting
local Default = {
    ["Enabled"] = false,
    ["MountSwitch"] = true,
    ["SwitchTime"] = 5,
    ["Always"] = false,
    ["MountedCombat"] = true,
    ["MinimapIconAngle"] = 355,
    ["SwitchSpells"] = {
        [2580] = true, -- Miner
        [2383] = true, -- Herb
    },
    ["ShowMinimapIcon"] = true,
    ["CurrentStatus"] = false,
}
Addon.Config = {}
local Config = Addon.Config

-- API localization (Improve API running efficiency)
local CastSpellByID = CastSpellByID
local UnitAffectingCombat = UnitAffectingCombat
local UnitIsDeadOrGhost = UnitIsDeadOrGhost
local UnitClass = UnitClass
local UnitBuff = UnitBuff
local CastingInfo = CastingInfo
local ChannelInfo = ChannelInfo
local GetTime = GetTime
local IsMounted = IsMounted
local IsInInstance = IsInInstance

-- Variables
local TrackingSpellsInTable = {}
Addon.TrackingSpellsNum = 0

local IsMoving = false
Addon.IsInTravelMode = false
local IsInTravelMode = Addon.IsInTravelMode

-- Merge(update) Table
function Addon:UpdateTable(Target, Source)
    for k, v in pairs(Source) do
        if type(v) == "table" then
            if type(Target[k]) == "table" then
                self:UpdateTable(Target[k], v)
            else
                Target[k] = self:UpdateTable({}, v)
            end
        elseif type(Target[k]) ~= "table" then
            Target[k] = v
        end
    end
    return Target
end
-- Get Tracking Spells
function Addon:GetCurrentSpells()
    TrackingSpellsInTable = {}
    local i = 1
    if next(Config.SwitchSpells) then
        for k in pairs(Config.SwitchSpells) do
            TrackingSpellsInTable[i] = k
            i = i + 1
        end
        Addon.TrackingSpellsNum = #TrackingSpellsInTable
    end
end
-- Show Spell Table
function Addon:ShowSpellInfo()
    for k in pairs(Config.SwitchSpells) do
        if not IsPlayerSpell(k) then
            Config.SwitchSpells[k] = nil
        end
    end
    Addon:GetCurrentSpells()
    do
        local i = 1
        for k in pairs(Config.SwitchSpells) do
            local msg = " " .. (GetSpellLink(k)) .. " (ID = " .. tostring(k) .. ")"
            SetWindow.DisplayGroup[i]:SetText(msg)
            i = i + 1
        end
        if i > 10 then
            return
        end
        for j = i, 10 do
            SetWindow.DisplayGroup[j]:SetText("")
        end
    end
end

-- OnUpdate
do
    local LastScan = 0
    local Tracking = 1

    local function OnUpdate(self, lastupdate)
        if not Config.Enabled or Addon.TrackingSpellsNum <= 1 then
            Frame:Hide()
            return
        end
        if not Config.CurrentStatus then
            Frame:Hide()
            return
        end
        if UnitIsDeadOrGhost("player") then
            return
        end
        local NowScan = math.floor(GetTime()*10)/10
        if NowScan - LastScan <= Config.SwitchTime then
            return
        end
        LastScan = NowScan
        if not Config.Always then
            if not IsMoving  then
                return
            end
        end
--[[        
        if UnitAffectingCombat("player") then
            if not Config.MountedCombat then
                return
            else
                if not (IsMounted() or IsInTravelMode) then
                    return
                end
            end
        end
]]
        if Tracking > Addon.TrackingSpellsNum then
            Tracking = 1
        end
        if not UnitIsDeadOrGhost("player") and not (CastingInfo()) and not (ChannelInfo()) then
            CastSpellByID(TrackingSpellsInTable[Tracking])
        end
        Tracking = Tracking + 1
    end

    Frame:SetScript("OnUpdate", OnUpdate)
end

Frame:RegisterEvent("ADDON_LOADED")
Frame:RegisterEvent("PLAYER_LEAVING_WORLD")
Frame:RegisterEvent("PLAYER_LOGOUT")
Frame:RegisterEvent("UNIT_AURA")
Frame:RegisterEvent("PLAYER_ENTERING_WORLD")
Frame:RegisterEvent("PLAYER_ALIVE")
Frame:RegisterEvent("PLAYER_UNGHOST")
Frame:RegisterEvent("PLAYER_STARTED_MOVING")
Frame:RegisterEvent("PLAYER_STOPPED_MOVING")

--Event处理分配
Frame:SetScript(
	"OnEvent",
	function(self, event, ...)
		if type(self[event]) == "function" then
			return self[event](self, ...)
		end
	end
)

function Frame:ADDON_LOADED(Name)
    if Name ~= AddonName then
        return
    end
    if not GatherBotDB then
        GatherBotDB = {}
        Addon:UpdateTable(Config, Default)
    else
        Addon:UpdateTable(Config, GatherBotDB)
    end
    if Addon.TrackingSpellsNum >= 1 then
        local find = false
        for i = 1, GetNumTrackingTypes() do
            local _, _, active, type = GetTrackingInfo(i)
            if active and type == "spell" then
                find = true
                break
            end
        end
        if not find then
            CastSpellByID(TrackingSpellsInTable[1])
        end
        if Addon.TrackingSpellsNum == 1 then
            Frame:Hide()
        end
    else
        Frame:Hide()
    end
    -- Initialize Setting Window
    SetWindow:Initialize()
    -- UnregisterEvent
    self:UnregisterEvent("ADDON_LOADED")
end

function Frame:PLAYER_LEAVING_WORLD()
    -- Save Config Variables
    GatherBotDB = {}
    Addon:UpdateTable(GatherBotDB, Config)
    if Addon.LDB and Addon.LDBIcon then
        GatherBotDB.MinimapIconAngle = MinimapIcon.minimap.minimapPos
    end
end
function Frame:PLAYER_LOGOUT()
    -- Save Config Variables
    GatherBotDB = {}
    Addon:UpdateTable(GatherBotDB, Config)
    if Addon.LDB and Addon.LDBIcon then
        GatherBotDB.MinimapIconAngle = MinimapIcon.minimap.minimapPos
    end
end

function Frame:PLAYER_ENTERING_WORLD(isLogin, isReload)
    -- Initialize MinimapButton
    if isLogin or isReload then
        if Addon.LDB and Addon.LDBIcon then
            MinimapIcon:InitBroker()
        else
            -- 初始化小地图按钮
            MinimapIcon:Initialize()
            -- 小地图按钮
            if Config.ShowMinimapIcon then
                Addon:UpdatePosition(Config.MinimapIconAngle)
                MinimapIcon.Minimap:Show()
            else
                MinimapIcon.Minimap:Hide()
            end
        end
        Addon:ShowSpellInfo()
        if Config.CurrentStatus then
            Frame:Show()
        else
            Frame:Hide()
        end
    end
    if select(2, IsInInstance()) ~= "none" then
        if Config.CurrentStatus then
            Config.CurrentStatus = false
            Frame:Hide()
        end
    else
        if Config.Enabled and not Config.CurrentStatus then
            Config.CurrentStatus = true
            Frame:Show()
        end
    end
end

function Frame:PLAYER_STARTED_MOVING()
    IsMoving = true
end

function Frame:PLAYER_STOPPED_MOVING()
    IsMoving = false
end

function Frame:PLAYER_ALIVE()
    if select(4, GetBuildInfo()) > 20000 then
        Frame:UnregisterEvent("PLAYER_ALIVE")
        return
    end
    if UnitIsDeadOrGhost("player") then return end
    if select(2, IsInInstance()) ~= "none" then return end
    Addon:GetCurrentSpells()
    if Addon.TrackingSpellsNum > 0 then
        CastSpellByID(TrackingSpellsInTable[1])
    end
end

function Frame:PLAYER_UNGHOST()
    if select(4, GetBuildInfo()) > 20000 then
        Frame:UnregisterEvent("PLAYER_UNGHOST")
        return
    end
    if UnitIsDeadOrGhost("player") then return end
    if select(2, IsInInstance()) ~= "none" then return end
    Addon:GetCurrentSpells()
    if Addon.TrackingSpellsNum > 0 then
        CastSpellByID(TrackingSpellsInTable[1])
    end
end

function Frame:UNIT_AURA(unit)
    if not Config.MountSwitch then
        return
    end
    if unit ~= "player" then
        return
    end
    Addon:GetCurrentSpells()
    if Addon.TrackingSpellsNum <= 1 then
        return
    end
    if (select(2, UnitClass("player"))) == "DRUID" or (select(2, UnitClass("player"))) == "SHAMAN" then
        IsInTravelMode  = false
        for i = 1, 40 do
            local SpellID = (select(10, UnitBuff("player", i)))
            if SpellID == 2645 or SpellID == 783 or SpellID == 33943 or SpellID == 40120 then
                IsInTravelMode = true
                break
            end
        end
    end
    if (IsMounted() or IsInTravelMode) and not Config.CurrentStatus and not Frame:IsShown() and select(2, IsInInstance()) == "none" then
        Config.CurrentStatus = true
        UIErrorsFrame:AddMessage(L["<|cFFBA55D3GB|r>Auto Switch the Tracking when you Mounted."])
        Frame:Show()
    elseif not (IsMounted() or IsInTravelMode) and Frame:IsShown() then
        if not Config.Enabled then
            Config.CurrentStatus = false
            UIErrorsFrame:AddMessage(L["<|cFFBA55D3GB|r>Stop Switch the Tracking when you Dismounted."])
            Frame:Hide()
        end
    end
end

SLASH_GBC1 = "/gatherbot"
SLASH_GBC2 = "/gb"

SlashCmdList["GBC"] = function(Input)
    Addon:ShowSpellInfo()
    SetWindow.background:Show()
end