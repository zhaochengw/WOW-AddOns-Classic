local AddonName, Addon = ...

local L = Addon.L --Localization

local Frame = CreateFrame("Frame", nil, UIParent)
Frame:Hide()

local CastSpellByID = CastSpellByID
local UnitAffectingCombat = UnitAffectingCombat
local UnitIsDeadOrGhost = UnitIsDeadOrGhost
local CastingInfo = CastingInfo
local ChannelInfo = ChannelInfo
local GetTime = GetTime
local IsMounted = IsMounted

local AddonEnable = 0
local AddonSwitch = false
-- local Tracking = {
--     [(GetSpellInfo(2580))] = true,
--     [(GetSpellInfo(2383))] = true,
-- }
local Miner = 2580
local Herb = 2383
local Switch = "Miner"
local Mounted = false
local IsMoving = false
local IsInTravelMode = false

local LastScan = 0

local function OnUpdate(self, lastupdate)
    if AddonEnable ~= 3 then
        Frame:Hide()
        return
    end
    local NowScan = math.floor(GetTime()*10)/10
    if NowScan - LastScan <= GatherBotDB.Time then
        return
    end
    LastScan = NowScan
    if not IsMoving  then
        return
    end
    if not UnitAffectingCombat("player") and not UnitIsDeadOrGhost("player") and not (CastingInfo()) and not (ChannelInfo()) then
        if Switch == "Miner" then
            CastSpellByID(Herb)
            Switch = "Herb"
        elseif Switch == "Herb" then
            CastSpellByID(Miner)
            Switch = "Miner"
        end
    end
end

local function OnEnterGame()
    local HaveMiner, HaveHerb = IsPlayerSpell(Miner), IsPlayerSpell(Herb)
    if HaveMiner or HaveHerb then
        local find = false
        for i = 1, GetNumTrackingTypes() do
            local _, _, active, type = GetTrackingInfo(i)
            if active and type == "spell" then
                find = true
                break
            end
        end
        if not find then
            if HaveMiner and HaveHerb then
                Switch = "Miner"
                CastSpellByID(Miner)
                AddonEnable = 3
            elseif HaveMiner and not HaveHerb then
                Switch = "Miner"
                CastSpellByID(Miner)
                AddonEnable = 2
            elseif not HaveMiner and HaveHerb then
                Switch = "Herb"
                CastSpellByID(Herb)
                AddonEnable = 1
            end
        end
    end
end

Frame:SetScript("OnUpdate", OnUpdate)

Frame:RegisterEvent("ADDON_LOADED")
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

function Frame:PLAYER_ENTERING_WORLD()
    OnEnterGame()
end

function Frame:ADDON_LOADED(Name)
    if Name ~= AddonName then
        return
    end
    if not GatherBotDB then
        GatherBotDB = {
            ["Time"] = 5,
        }
    end
    OnEnterGame()
    self:UnregisterEvent("ADDON_LOADED")
end

function Frame:PLAYER_STARTED_MOVING()
    IsMoving = true
end

function Frame:PLAYER_STOPPED_MOVING()
    IsMoving = false
end

function Frame:PLAYER_ALIVE()
    if select(4, GetBuildInfo()) > 20000 then return end
    if UnitIsDeadOrGhost("player") then return end
    if select(2, IsInInstance()) ~= "none" then return end
    if AddonEnable == 0 then
        return
    elseif AddonEnable == 1 then
        CastSpellByID(Herb)
    elseif AddonEnable == 2 then
        CastSpellByID(Miner)
    elseif AddonEnable == 3 then
        CastSpellByID(Miner)
    end
end

function Frame:PLAYER_UNGHOST()
    if select(4, GetBuildInfo()) > 20000 then return end
    if UnitIsDeadOrGhost("player") then return end
    if select(2, IsInInstance()) ~= "none" then return end
    if AddonEnable == 0 then
        return
    elseif AddonEnable == 1 then
        CastSpellByID(Herb)
    elseif AddonEnable == 2 then
        CastSpellByID(Miner)
    elseif AddonEnable == 3 then
        CastSpellByID(Miner)
    end
end

function Frame:UNIT_AURA(unit)
    if AddonEnable ~= 3 then return end
    if unit ~= "player" then return end
    if select(2, IsInInstance()) ~= "none" then return end
    if UnitIsDeadOrGhost("player") then return end
    if (select(2, UnitClass("player"))) == "DRUID" or (select(2, UnitClass("player"))) == "SHAMAN" then
        IsInTravelMode  = false
        for i = 1, 40 do
            local SpellID = (select(10, UnitAura("player", i, "HELPFUL")))
            if SpellID == 2645 or SpellID == 783 then
                IsInTravelMode = true
                break
            end
        end
    end

    if (IsMounted() or IsInTravelMode) and not Mounted and not Frame:IsShown() and select(2, IsInInstance()) == "none" then
        Mounted = true
        print(L["<|cFFBA55D3GB|r>Switch the Resource Tracking when you Mounted."])
        Frame:Show()
    elseif not (IsMounted() or IsInTravelMode) and Mounted then
        Mounted = false
        if not AddonSwitch then
            print(L["<|cFFBA55D3GB|r>Switch the Resource Tracking when you Dismounted."])
            Frame:Hide()
        end
    end
end

SLASH_GBC1 = "/gatherbot"
SLASH_GBC2 = "/gb"

SlashCmdList["GBC"] = function(Input)
    if Input ~= "" then
        if Input:lower() == "default" then
            GatherBotDB.Time = 5
            print(string.format(L["<|cFFBA55D3GB|r>Set Switch Time to every [%s] seconds."], GatherBotDB.Time))
        elseif tonumber(Input) and tonumber(Input) <= 20 and tonumber(Input) >= 3 then
            GatherBotDB.Time = tonumber(Input)
            print(string.format(L["<|cFFBA55D3GB|r>Set Switch Time to every [%s] seconds."], GatherBotDB.Time))
        else
            print(L["<|cFFBA55D3GB|r>Wrong Input: Please use |cFF00FF00/gb default|r or |cFF00FF00/gb number|r |cFFBEBEBE(3 to 20)|r."])
        end
    else
        if AddonEnable == 3 then
            if AddonSwitch then
                AddonSwitch = false
                print(L["<|cFFBA55D3GB|r>Truned the Resource Tracking Auto Switch to OFF."])
                Frame:Hide()
            else
                AddonSwitch = true
                print(L["<|cFFBA55D3GB|r>Truned the Resource Tracking Auto Switch to ON."])
                Frame:Show()
            end
        else
            print(L["<|cFFBA55D3GB|r>No Resource Tracking Spell."])
        end
    end
end