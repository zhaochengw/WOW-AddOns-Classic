local addonName, ns = ...

local f = CreateFrame("Frame", "ClassicSpellActivations") --, UIParent)

f:SetScript("OnEvent", function(self, event, ...)
    return self[event](self, event, ...)
end)

local APILevel = math.floor(select(4,GetBuildInfo())/10000)

local UnitGUID = UnitGUID
local bit_band = bit.band
local CombatLogGetCurrentEventInfo = CombatLogGetCurrentEventInfo
local AFFILIATION_MINE = COMBATLOG_OBJECT_AFFILIATION_MINE
local _, class = UnitClass("player")
ns.configs = {}

local procCombatLog
local registeredFrames = {}
local activations = {}

local LocalizedOverpower = GetSpellInfo(7384)
local LocalizedRevenge = GetSpellInfo(6572)
local LocalizedRampage = GetSpellInfo(29801)
local LocalizedRiposte = GetSpellInfo(14251)
local LocalizedCounterattack = GetSpellInfo(19306)
-- local LocalizedExecute = GetSpellInfo(20662)
-- local LocalizedShadowBolt = GetSpellInfo(686)
local LocalizedMongooseBite = GetSpellInfo(1495)
local LocalizedEarthShock = GetSpellInfo(8042)
local LocalizedFlameShock = GetSpellInfo(8050)
local LocalizedFrostShock = GetSpellInfo(8056)
local LBG
local LCG

local spellNamesByID = {}
local reverseSpellRanks = {}
local function AddSpellName(name, ...)
    local ranks = { ... }
    local numArgs = #ranks
    for i=1, #ranks do
        local spellID = select(i, ...)
        spellNamesByID[spellID] = name
    end
    reverseSpellRanks[name] = ranks
end
-- Wrath
-- Priest: Serendipity
-- Druid: Predatory Swiftness, Eclipses
-- DK: Frost procs

AddSpellName("VictoryRush", 34428 )
AddSpellName("Overpower", 11585, 11584, 7887, 7384 ) -- 7384 - only Wrath rank
AddSpellName("Rampage", 30033, 30030, 29801 ) -- TBC only
AddSpellName("Riposte", 14251 )
AddSpellName("Counterattack", 27067, 20910, 20909, 19306 )
AddSpellName("KillCommand", 34026 )
AddSpellName("MongooseBite", 36916, 14271, 14270, 14269, 1495 )

AddSpellName("FrostShock", 49236, 49235, 25464, 10473, 10472, 8058, 8056)
AddSpellName("FlameShock", 49233, 49232, 29228, 25457, 10448, 10447, 8053, 8052, 8050)
AddSpellName("EarthShock", 49231, 49230, 25454, 10414, 10413, 10412, 8046, 8045, 8044, 8042)

AddSpellName("HammerOfWrath", 48806, 48805, 27180, 24274, 24239, 24275)
AddSpellName("Exorcism", 48801, 48800, 27138, 10314, 10313, 10312, 5615, 5614, 879)

AddSpellName("ShadowBolt", 47809, 47808, 27209, 25307, 11661, 11660, 11659, 7641, 1106, 1088, 705, 695, 686)
AddSpellName("Incinerate", 47838, 47837, 32231, 29722)

AddSpellName("Execute", 47471, 47470, 25236, 25234, 20662, 20661, 20660, 20658, 5308)
AddSpellName("Revenge", 57823, 30357, 25288, 25269, 11601, 11600, 7379, 6574, 6572)
AddSpellName("ShieldSlam", 47488, 47487, 30356, 25258, 23925, 23924, 23923, 23922)

AddSpellName("ArcaneMissiles", 42846, 42843, 38704, 38699, 27075, 25345, 10212, 10211, 8417, 8416, 5145, 5144, 5143)
AddSpellName("FrostBolt", 42842, 42841, 38697, 27072, 27071, 25304, 10181, 10180, 10179, 8408, 8407, 8406, 7322, 837, 205, 116)
AddSpellName("IceLance", 42914, 42913, 30455)
AddSpellName("FrostfireBolt", 47610, 44614 )
AddSpellName("Fireball", 42833, 42832, 38692, 27070, 25306, 10151, 10150, 10149, 10148, 8402, 8401, 8400, 3140, 145, 143, 133)
AddSpellName("Pyroblast", 42891, 42890, 33938, 27132, 18809, 12526, 12525, 12524, 12523, 12522, 12505, 11366)
AddSpellName("Flamestrike", 42926, 42925, 27086, 10216, 10215, 8423, 8422, 2121, 2120)

AddSpellName("FlashOfLight", 48785, 48784, 27137, 19943, 19942, 19941, 19940, 19939, 19750)
AddSpellName("DrainSoul", 47855, 27217, 11675, 8289, 8288, 1120)
AddSpellName("SoulFire", 47825, 47824, 30545, 27211, 17924, 6353)

AddSpellName("Starfire", 48465, 48464, 26986, 25298, 9876, 9875, 8951, 8950, 8949, 2912)
AddSpellName("Wrath", 48461, 48459, 26985, 26984, 9912, 8905, 6780, 5180, 5179, 5178, 5177, 5176)
AddSpellName("GreaterHeal", 48063, 48062, 25314, 25213, 25210, 10965, 10964, 10963, 2060)


local function OnAuraStateChange(conditionFunc, actions)
    local state = -1
    return function()
        local name, _, count, _, duration, expirationTime = conditionFunc()
        local newState = name ~= nil
        if newState ~= state then
            actions(newState, duration, expirationTime)
            state = newState
        end
    end
end


f:RegisterEvent("PLAYER_LOGIN")
function f:PLAYER_LOGIN()

    -- if class == "WARRIOR" or class == "ROGUE" or class == "HUNTER" or class == "WARLOCK" or class == "PALADIN" or class == "SHAMAN" then
    if true then
        self:RegisterEvent("SPELLS_CHANGED")
        self:SPELLS_CHANGED()

        local bars = {"ActionButton","MultiBarBottomLeftButton","MultiBarBottomRightButton","MultiBarLeftButton","MultiBarRightButton"}
        for _,bar in ipairs(bars) do
            for i = 1,12 do
                local btn = _G[bar..i]
                self:RegisterForActivations(btn)
            end
        end

        hooksecurefunc("ActionButton_UpdateOverlayGlow", function(self)
            ns.UpdateOverlayGlow(self)
        end)

        local LAB = LibStub("LibActionButton-1.0", true) -- Bartener support
        if LAB then
            LBG = LibStub("LibButtonGlow-1.0", true)
            self:RegisterForActivations(LAB.eventFrame)
            LAB:RegisterCallback("OnButtonUpdate", function(event, self)
                ns.LAB_UpdateOverlayGlow(self)
            end)
        end

        local LAB2 = LibStub("LibActionButton-1.0-ElvUI", true) -- ElvUI support
        if LAB2 then
            LCG = LibStub("LibCustomGlow-1.0", true)
            self:RegisterForActivations(LAB2.eventFrame)
            LAB2:RegisterCallback("OnButtonUpdate", function(event, self)
                ns.LAB_UpdateOverlayGlowLibCustomGlow(self)
            end)
        end

        if IsAddOnLoaded("Dominos") then
            local dominosPrefix = "DominosActionButton"
            for i = 1, 72 do
                local btnName = dominosPrefix..i
                local btn = _G[btnName]
                if btn then
                    self:RegisterForActivations(btn)
                end
            end
        end

        -- if Neuron then
        --     for i,bar in ipairs(Neuron.BARIndex) do
        --         for btnID, btn in pairs(bar.buttons) do
        --             if btn.objType == "ACTIONBUTTON" then
        --                 self:RegisterForActivations(btn)
        --             end
        --         end
        --     end
        -- end
    end
    -- self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")


end

local UnitAura = UnitAura
local function FindAura(unit, spellID, filter)
    for i=1, 100 do
        local name, icon, count, debuffType, duration, expirationTime, unitCaster, canStealOrPurge, nameplateShowPersonal, auraSpellID = UnitAura(unit, i, filter)
        if not name then return nil end
        if spellID == auraSpellID then
            return name, icon, count, debuffType, duration, expirationTime, unitCaster, canStealOrPurge, nameplateShowPersonal, auraSpellID
        end
    end
end

function f:SPELLS_CHANGED()
    local config = ns.configs[class]
    if config then
        config(self)
    end
end

function f:RegisterForActivations(frame)
    registeredFrames[frame] = true
    -- registeredFrames:GetScript("OnEvent")
end
local function IsSpellOverlayed(spellID)
    local spellName = spellNamesByID[spellID]
    if not spellName then return false end
    local state = activations[spellName]
    if state then return state.active end
end

local GetActionInfo = _G.GetActionInfo
local GetMacroSpell = _G.GetMacroSpell
local ActionButton_ShowOverlayGlow = _G.ActionButton_ShowOverlayGlow
local ActionButton_HideOverlayGlow = _G.ActionButton_HideOverlayGlow
function ns.UpdateOverlayGlow(self)
    local spellType, id, subType  = GetActionInfo(self.action);
    if ( spellType == "spell" and IsSpellOverlayed(id) ) then
        ActionButton_ShowOverlayGlow(self);
    elseif ( spellType == "macro" ) then
        local spellId = GetMacroSpell(id);
        if ( spellId and IsSpellOverlayed(spellId) ) then
            ActionButton_ShowOverlayGlow(self);
        else
            ActionButton_HideOverlayGlow(self);
        end
    else
        ActionButton_HideOverlayGlow(self);
    end
end

function ns.LAB_UpdateOverlayGlow(self)
    local spellId = self:GetSpellId()
    if spellId and IsSpellOverlayed(spellId) then
        if LBG then
            LBG.ShowOverlayGlow(self)
        end
    else
        if LBG then
            LBG.HideOverlayGlow(self)
        end
    end
end

function ns.LAB_UpdateOverlayGlowLibCustomGlow(self)
    local spellId = self:GetSpellId()
    if spellId and IsSpellOverlayed(spellId) then
        if LCG then
            LCG.ButtonGlow_Start(self)
        end
    else
        if LCG then
            LCG.ButtonGlow_Stop(self)
        end
    end
end

function f:FanoutEvent(event, ...)
    for frame, _ in pairs(registeredFrames) do
        local eventHandler = frame:GetScript("OnEvent")
        if eventHandler then
            eventHandler(frame, event, ...)
        end
    end
end


function ns.findHighestRank(spellName)
    for _, spellID in ipairs(reverseSpellRanks[spellName]) do
        if IsPlayerSpell(spellID) then return spellID end
    end
end
local findHighestRank = ns.findHighestRank

function f:Activate(spellName, actID, duration, keepExpiration)
    local states = activations[spellName]
    if not states then
        activations[spellName] = {}
        states = activations[spellName]
    end
    local state = states[actID]
    if not state then
        states[actID] = {}
        state = states[actID]
    end
    local expirationTime = state
    if not state.active then
        state.active = true
        state.expirationTime = duration and GetTime() + duration

        local highestRankSpellID = findHighestRank(spellName)
        self:FanoutEvent("SPELL_ACTIVATION_OVERLAY_GLOW_SHOW", highestRankSpellID)
    elseif not keepExpiration then
        state.expirationTime = duration and GetTime() + duration
    end
end
function f:Deactivate(spellName, actID)
    local states = activations[spellName]
    if not states then return end
    local state = states[actID]
    if state and state.active == true then
        states[actID] = nil
        -- state.active = false
        -- state.expirationTime = nil
    end

    if not next(states) then
        local highestRankSpellID = findHighestRank(spellName)
        self:FanoutEvent("SPELL_ACTIVATION_OVERLAY_GLOW_HIDE", highestRankSpellID)
    end
end

local _OnUpdateCounter = 0
local periodicCheck = nil
function f.timerOnUpdate(self, elapsed)
    _OnUpdateCounter = _OnUpdateCounter + elapsed
    if _OnUpdateCounter < 0.2 then return end
    _OnUpdateCounter = 0


    if periodicCheck then
        periodicCheck()
    end

    local now = GetTime()
    for spellName, states in pairs(activations) do
        for actID, state in pairs(states) do
            if state.expirationTime and now >= state.expirationTime then
                f:Deactivate(spellName, actID)
            end
        end
    end
end

function f:COMBAT_LOG_EVENT_UNFILTERED(event)
    local timestamp, eventType, hideCaster,
    srcGUID, srcName, srcFlags, srcFlags2,
    dstGUID, dstName, dstFlags, dstFlags2,
    arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10 = CombatLogGetCurrentEventInfo()

    local isSrcPlayer = srcGUID == UnitGUID("player") -- bit_band(srcFlags, AFFILIATION_MINE) == AFFILIATION_MINE
    local isDstPlayer = dstGUID == UnitGUID("player")

    procCombatLog(eventType, isSrcPlayer, isDstPlayer, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10)
end

-----------------
-- WARRIOR
-----------------

function ns.ExecuteCheck(self, event, unit)
    if UnitExists("target") and not UnitIsFriend("player", "target") then
        local h = UnitHealth("target")
        local hm = UnitHealthMax("target")
        local executeID = ns.findHighestRank("Execute")

        if h > 0 and (h/hm < 0.2 or IsUsableSpell(executeID)) then
            f:Activate("Execute", "Health", 10)
        else
            f:Deactivate("Execute", "Health")
        end
    else
        f:Deactivate("Execute", "Health")
    end
end

function ns.CheckOverpower(eventType, isSrcPlayer, isDstPlayer, ...)
    if isSrcPlayer then
        if eventType == "SWING_MISSED" or eventType == "SPELL_MISSED" then
            local missedType
            if eventType == "SWING_MISSED" then
                missedType = select(1, ...)
            elseif eventType == "SPELL_MISSED" then
                missedType = select(4, ...)
            end
            if missedType == "DODGE" then
                f:Activate("Overpower", "Dodge", 5)
            end

        end

        if eventType == "SPELL_CAST_SUCCESS" then
            local spellName = select(2, ...)
            if spellName == LocalizedOverpower then
                f:Deactivate("Overpower", "Dodge")
                f:Deactivate("Overpower", "TasteForBlood")
            end
        end
    end
end

function ns.CheckRevenge(eventType, isSrcPlayer, isDstPlayer, ...)
    if isDstPlayer then
        if eventType == "SWING_MISSED" or eventType == "SPELL_MISSED" then
            local missedType
            if eventType == "SWING_MISSED" then
                missedType = select(1, ...)
            elseif eventType == "SPELL_MISSED" then
                missedType = select(4, ...)
            end
            if missedType == "BLOCK" or missedType == "DODGE" or missedType == "PARRY" then
                f:Activate("Revenge", "Parry", 5)
            end
        end
        if eventType == "SWING_DAMAGE" then
            local blocked = select(5, ...)
            if blocked then
                f:Activate("Revenge", "Parry", 5)
            end
        end
    end

    if isSrcPlayer and eventType == "SPELL_CAST_SUCCESS" then
        local spellName = select(2, ...)
        if spellName == LocalizedRevenge then
            f:Deactivate("Revenge", "Parry")
        end
    end
end

function ns.CheckRampage(eventType, isSrcPlayer, isDstPlayer, ...)
    if isSrcPlayer then
        if eventType == "SWING_DAMAGE" or eventType == "SPELL_DAMAGE" then
            local isCrit
            if eventType == "SWING_DAMAGE" then
                isCrit = select(7, ...)
            elseif eventType == "SPELL_DAMAGE" then
                isCrit = select(10, ...)
            end
            if isCrit == true then
                f:Activate("Rampage", "Crit", 5)
            end

        end
    end
end

local CheckTasteForBlood = OnAuraStateChange(function() return FindAura("player", 60503, "HELPFUL") end,
    function(present, duration)
        if present then
            f:Activate("Overpower", "TasteForBlood", duration, true)
        else
            f:Deactivate("Overpower", "TasteForBlood")
        end
    end
)
local CheckSuddenDeath = OnAuraStateChange(function() return FindAura("player", 52437, "HELPFUL") end,
    function(present, duration)
        if present then
            f:Activate("Execute", "SuddenDeath", duration, true)
        else
            f:Deactivate("Execute", "SuddenDeath")
        end
    end
)
local CheckSwordAndBoard = OnAuraStateChange(function() return FindAura("player", 50227, "HELPFUL") end,
    function(present, duration)
        if present then
            f:Activate("ShieldSlam", "Reset", duration, true)
        else
            f:Deactivate("ShieldSlam", "Reset")
        end
    end
)

ns.configs.WARRIOR = function(self)
    self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
    self:SetScript("OnUpdate", self.timerOnUpdate)

    local hasOverpower = ns.findHighestRank("Overpower")
    local hasRevenge = ns.findHighestRank("Revenge")
    local hasRampage = ns.findHighestRank("Rampage")
    local hasVictoryRush = ns.findHighestRank("VictoryRush")
    local hasShieldSlam = ns.findHighestRank("ShieldSlam")

    local CheckOverpower = ns.CheckOverpower
    local CheckRevenge = ns.CheckRevenge
    local CheckRampage = ns.CheckRampage
    procCombatLog = function(...)
        if hasOverpower then
            CheckOverpower(...)
        end
        if hasRevenge then
            CheckRevenge(...)
        end
        if hasRampage then
            CheckRampage(...)
        end
    end

    if not hasOverpower and not hasRevenge and not hasRampage then
        self:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
        self:SetScript("OnUpdate", nil)
    end

    if ns.findHighestRank("Execute") then
        self:RegisterEvent("PLAYER_TARGET_CHANGED")
        self:RegisterUnitEvent("UNIT_HEALTH", "target")
        self.PLAYER_TARGET_CHANGED = ns.ExecuteCheck
        self.UNIT_HEALTH = ns.ExecuteCheck
    else
        self:UnregisterEvent("PLAYER_TARGET_CHANGED")
        self:UnregisterEvent("UNIT_HEALTH")
    end

    if hasVictoryRush or ns.findHighestRank("Execute") then
        self:RegisterEvent("SPELL_UPDATE_USABLE")
        local wasUsable = IsUsableSpell(34428)
        local wasUsableExecute = IsUsableSpell("Execute")
        self.SPELL_UPDATE_USABLE = function()
            local isUsable = IsUsableSpell(34428)
            if wasUsable ~= isUsable then
                if isUsable then
                    f:Activate("VictoryRush", "Usable", 20, true)
                else
                    f:Deactivate("VictoryRush", "Usable")
                end
                wasUsable = isUsable
            end
        end
    end

    local hasTasteForBloodTalent = IsPlayerSpell(56636) or IsPlayerSpell(56637) or IsPlayerSpell(56638)
    local hasSuddenDeathTalent = IsPlayerSpell(29723) or IsPlayerSpell(29725) or IsPlayerSpell(29724)
    local hasSwordAndBoardTalent = IsPlayerSpell(46951) or IsPlayerSpell(46952) or IsPlayerSpell(46953)
    if hasTasteForBloodTalent or hasSuddenDeathTalent or hasSwordAndBoardTalent then
        self:RegisterUnitEvent("UNIT_AURA", "player")
        self.UNIT_AURA = function(self, event, unit)
            if hasTasteForBloodTalent then
                CheckTasteForBlood()
            end
            if hasSuddenDeathTalent then
                CheckSuddenDeath()
            end
            if hasSwordAndBoardTalent then
                CheckSwordAndBoard()
            end
        end
    else
        self:UnregisterEvent("UNIT_AURA")
    end
end

-----------------
-- ROGUE
-----------------

function ns.CheckRiposte(eventType, isSrcPlayer, isDstPlayer, ...)
    if isDstPlayer then
        if eventType == "SWING_MISSED" or eventType == "SPELL_MISSED" then
            local missedType
            if eventType == "SWING_MISSED" then
                missedType = select(1, ...)
            elseif eventType == "SPELL_MISSED" then
                missedType = select(4, ...)
            end
            if missedType == "PARRY" then
                f:Activate("Riposte", "Parry", 5)
            end
        end
    end

    if isSrcPlayer and eventType == "SPELL_CAST_SUCCESS" then
        local spellName = select(2, ...)
        if spellName == LocalizedRiposte then -- Riposte
            f:Deactivate("Riposte", "Parry")
        end
    end
end

ns.configs.ROGUE = function(self)
    if ns.findHighestRank("Riposte") then
        self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
        procCombatLog = ns.CheckRiposte
        self:SetScript("OnUpdate", self.timerOnUpdate)
    else
        self:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
        self:SetScript("OnUpdate", nil)
    end
end

-----------------
-- HUNTER
-----------------

function ns.CheckCounterattack(eventType, isSrcPlayer, isDstPlayer, ...)
    if isDstPlayer then
        if eventType == "SWING_MISSED" or eventType == "SPELL_MISSED" then
            local missedType
            if eventType == "SWING_MISSED" then
                missedType = select(1, ...)
            elseif eventType == "SPELL_MISSED" then
                missedType = select(4, ...)
            end
            if missedType == "PARRY" then
                f:Activate("Counterattack", "Parry", 5)
            end
        end
    end

    if isSrcPlayer and eventType == "SPELL_CAST_SUCCESS" then
        local spellName = select(2, ...)
        if spellName == LocalizedCounterattack then
            f:Deactivate("Counterattack", "Parry", 5)
        end
    end
end

function ns.CheckMongooseBite(eventType, isSrcPlayer, isDstPlayer, ...)
    if isDstPlayer then
        if eventType == "SWING_MISSED" or eventType == "SPELL_MISSED" then
            local missedType
            if eventType == "SWING_MISSED" then
                missedType = select(1, ...)
            elseif eventType == "SPELL_MISSED" then
                missedType = select(4, ...)
            end
            if missedType == "DODGE" then
                f:Activate("MongooseBite", "Dodge", 5)
            end
        end
    end

    if isSrcPlayer and eventType == "SPELL_CAST_SUCCESS" then
        local spellName = select(2, ...)
        if spellName == LocalizedMongooseBite then
            f:Deactivate("MongooseBite", "Dodge", 5)
        end
    end
end


function ns.CheckKillCommand(eventType, isSrcPlayer, isDstPlayer, ...)
    if isSrcPlayer then
        if eventType == "RANGE_DAMAGE" or eventType == "SWING_DAMAGE" or eventType == "SPELL_DAMAGE" then
            local isCrit
            if eventType == "SWING_DAMAGE" then
                isCrit = select(7, ...)
            elseif eventType == "RANGE_DAMAGE" then
                isCrit = select(10, ...)
            elseif eventType == "SPELL_DAMAGE" then
                isCrit = select(10, ...)
            end
            if isCrit == true then
                f:Activate("KillCommand", "Crit", 5)
            end

        end
    end
end

ns.configs.HUNTER = function(self)
    local hasMongooseBite = APILevel <= 2 ns.findHighestRank("MongooseBite")
    local hasCounterattack = ns.findHighestRank("Counterattack")
    local hasKillCommand = APILevel == 2 and ns.findHighestRank("KillCommand")

    self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
    self:SetScript("OnUpdate", self.timerOnUpdate)
    if hasMongooseBite or hasCounterattack or hasKillCommand then
        local CheckCounterattack = ns.CheckCounterattack
        local CheckMongooseBite = ns.CheckMongooseBite
        local CheckKillCommand = ns.CheckKillCommand
        procCombatLog = function(...)
            if hasCounterattack then
                CheckCounterattack(...)
            end
            if hasMongooseBite then
                CheckMongooseBite(...)
            end
            if hasKillCommand then
                CheckKillCommand(...)
            end
        end
    else
        self:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
        self:SetScript("OnUpdate", nil)
    end
end

-----------------
-- PALADIN
-----------------

do
    local LocalDemonTypes = { "Demon", "Dämon", "Demonio", "Demonio", "Démon", "Demone", "Demônio", "Демон", "악마", "恶魔", "惡魔" }
    local LocalUndeadTypes = { "Undead", "Untoter", "No-muerto", "No-muerto", "Mort-vivant", "Non Morto", "Renegado", "Нежить", "언데드", "亡灵", "不死族" }
    local LocIDs = {
        ["enUS"] = 1,
        ["deDE"] = 2,
        ["esES"] = 3,
        ["esMX"] = 4,
        ["frFR"] = 5,
        ["itIT"] = 6,
        ["ptBR"] = 7,
        ["ruRU"] = 8,
        ["koKR"] = 9,
        ["zhCN"] = 10,
        ["zhTW"] = 11,
    }
    local UndeadType
    local DemonType
    local locID = LocIDs[GetLocale()]
    if locID then
        UndeadType = LocalUndeadTypes[locID]
        DemonType = LocalDemonTypes[locID]
    end

    local exorcismTicker
    local exorcismCooldownState
    local exorcismTickerFunc = function()
        local startTime, duration, enabled = GetSpellCooldown(8092) -- fistt Rank
        local newState
        if duration <= 1.5 then
            newState = false
        else
            newState = true
        end

        if newState ~= exorcismCooldownState then
            if newState == false then
                f:Activate("Exorcism", "NPCType", 5)
            else
                f:Deactivate("Exorcism", "NPCType")
            end
        end
        exorcismCooldownState = newState
    end

    function ns.PaladinExorcismCheck(self, event)
        if UnitExists("target") and (UnitCreatureType("target") == UndeadType or UnitCreatureType("target") == DemonType) then
            exorcismCooldownState = not exorcismCooldownState
            exorcismTickerFunc()
            periodicCheck = exorcismTickerFunc
        else
            f:Deactivate("Exorcism", "NPCType")
            periodicCheck = nil
        end
    end
end

function ns.HOWCheck(self, event, unit)
    if UnitExists("target") and not UnitIsFriend("player", "target") then
        local h = UnitHealth("target")
        local hm = UnitHealthMax("target")
        if h > 0 and h/hm <= 0.2 then
            f:Activate("HammerOfWrath", "Health", 10)
        else
            f:Deactivate("HammerOfWrath", "Health")
        end
    else
        f:Deactivate("HammerOfWrath", "Health")
    end
end

local CheckArtOfWar = OnAuraStateChange(function() return FindAura("player", 59578, "HELPFUL") end,
    function(present, duration)
        if present then
            f:Activate("FlashOfLight", "ArtOfWar", duration, true)
            f:Activate("Exorcism", "ArtOfWar", duration, true)
        else
            f:Deactivate("FlashOfLight", "ArtOfWar")
            f:Deactivate("Exorcism", "ArtOfWar")
        end
    end
)

ns.configs.PALADIN = function(self)
    self:SetScript("OnUpdate", self.timerOnUpdate)

    if ns.findHighestRank("Exorcism") then
        self:RegisterEvent("PLAYER_TARGET_CHANGED")
        self.PLAYER_TARGET_CHANGED = ns.PaladinExorcismCheck

        if ns.findHighestRank("HammerOfWrath") then
            self:RegisterUnitEvent("UNIT_HEALTH", "target")
            self.PLAYER_TARGET_CHANGED = function(...)
                ns.PaladinExorcismCheck(...)
                ns.HOWCheck(...)
            end
            self.UNIT_HEALTH = ns.HOWCheck
        end
    end

    local hasArtOfWar = IsPlayerSpell(53486) or IsPlayerSpell(53488)
    if hasArtOfWar then
        self:RegisterUnitEvent("UNIT_AURA", "player")
        self:SetScript("OnUpdate", self.timerOnUpdate)
        self.UNIT_AURA = function(self, event, unit)
            if hasArtOfWar then
                CheckArtOfWar()
            end
        end
    else
        self:UnregisterEvent("UNIT_AURA")
    end
end

-----------------
-- WARLOCK
-----------------
local CheckNightfall = OnAuraStateChange(function() return FindAura("player", 17941, "HELPFUL") end,
    function(present, duration)
        if present then
            f:Activate("ShadowBolt", "Nightfall", duration, true)
        else
            f:Deactivate("ShadowBolt", "Nightfall")
        end
    end
)
local CheckBacklash = OnAuraStateChange(function() return FindAura("player", 34936, "HELPFUL") end,
    function(present, duration)
        if present then
            f:Activate("ShadowBolt", "Backlash", duration, true)
            f:Activate("Incinerate", "Backlash", duration, true)
        else
            f:Deactivate("ShadowBolt", "Backlash")
            f:Deactivate("Incinerate", "Backlash")
        end
    end
)
local CheckDecimation = OnAuraStateChange(function() return FindAura("player", 63167, "HELPFUL") end,
    function(present, duration)
        if present then
            f:Activate("SoulFire", "Decimation", duration, true)
        else
            f:Deactivate("SoulFire", "Decimation")
        end
    end
)

function ns.DrainSoulExecuteCheck(self, event, unit)
    if UnitExists("target") and not UnitIsFriend("player", "target") then
        local h = UnitHealth("target")
        local hm = UnitHealthMax("target")
        local executeID = ns.findHighestRank("DrainSoul")

        if h > 0 and (h/hm < 0.25) then
            f:Activate("DrainSoul", "Health", 10)
        else
            f:Deactivate("DrainSoul", "Health")
        end
    else
        f:Deactivate("DrainSoul", "Health")
    end
end

ns.configs.WARLOCK = function(self)
    self:SetScript("OnUpdate", self.timerOnUpdate)


    if ns.findHighestRank("DrainSoul") then
        self:RegisterEvent("PLAYER_TARGET_CHANGED")
        self:RegisterUnitEvent("UNIT_HEALTH", "target")
        self.PLAYER_TARGET_CHANGED = ns.DrainSoulExecuteCheck
        self.UNIT_HEALTH = ns.DrainSoulExecuteCheck
    else
        self:UnregisterEvent("PLAYER_TARGET_CHANGED")
        self:UnregisterEvent("UNIT_HEALTH")
    end

    local hasNightfallTalent = IsPlayerSpell(18094) or IsPlayerSpell(18095) -- for all classic game versions
    local hasBacklashTalent = IsPlayerSpell(34939) or IsPlayerSpell(34938) or IsPlayerSpell(34935) -- starts with BC
    local hasDecimation = IsPlayerSpell(63156) or IsPlayerSpell(63158)

    if hasNightfallTalent or hasBacklashTalent or hasDecimation then
        self:RegisterUnitEvent("UNIT_AURA", "player")
        self:SetScript("OnUpdate", self.timerOnUpdate)
        self.UNIT_AURA = function(self, event, unit)
            if hasNightfallTalent then
                CheckNightfall()
            end
            if hasBacklashTalent then
                CheckBacklash()
            end
            if hasDecimation then
                CheckDecimation()
            end
        end
    else
        self:SetScript("OnUpdate", nil)
        self:UnregisterEvent("UNIT_AURA")
    end
end


-----------------
-- SHAMAN
-----------------
if APILevel == 2 then

local CheckShamanisticFocus = OnAuraStateChange(function() return FindAura("player", 43339, "HELPFUL") end,
    function(present, duration)
        if present then
            f:Activate("EarthShock", "ShamFocus", duration, true)
            f:Activate("FlameShock", "ShamFocus", duration, true)
            f:Activate("FrostShock", "ShamFocus", duration, true)
        else
            f:Deactivate("EarthShock", "ShamFocus")
            f:Deactivate("FlameShock", "ShamFocus")
            f:Deactivate("FrostShock", "ShamFocus")
        end
    end
)

ns.configs.SHAMAN = function(self)
    self:SetScript("OnUpdate", self.timerOnUpdate)
    local hasShamanisticFocusTalent = IsPlayerSpell(43338)
    if hasShamanisticFocusTalent then
        self:RegisterUnitEvent("UNIT_AURA", "player")
        self:SetScript("OnUpdate", self.timerOnUpdate)
        self.UNIT_AURA = function(self, event, unit)
            if hasShamanisticFocusTalent then
                CheckShamanisticFocus()
            end
        end
    else
        self:SetScript("OnUpdate", nil)
        self:UnregisterEvent("UNIT_AURA")
    end
end

end


-----------------
-- MAGE
-----------------

if APILevel == 3 then
    local CheckFingers = OnAuraStateChange(function() return FindAura("player", 74396, "HELPFUL") end,
        function(present, duration)
            if present then
                f:Activate("IceLance", "Fingers", duration, true)
            else
                f:Deactivate("IceLance", "Fingers")
            end
        end
    )
    local CheckBarrage = OnAuraStateChange(function() return FindAura("player", 44401, "HELPFUL") end,
        function(present, duration)
            if present then
                f:Activate("ArcaneMissiles", "Barrage", duration, true)
            else
                f:Deactivate("ArcaneMissiles", "Barrage")
            end
        end
    )
    local CheckBrainFreeze = OnAuraStateChange(function() return FindAura("player", 57761, "HELPFUL") end,
        function(present, duration)
            if present then
                f:Activate("Fireball", "BrainFreeze", duration, true)
                f:Activate("FrostfireBolt", "BrainFreeze", duration, true)
            else
                f:Deactivate("Fireball", "BrainFreeze")
                f:Deactivate("FrostfireBolt", "BrainFreeze")
            end
        end
    )
    local CheckHotStreak = OnAuraStateChange(function() return FindAura("player", 48108, "HELPFUL") end,
        function(present, duration)
            if present then
                f:Activate("Pyroblast", "HotStreak", duration, true)
            else
                f:Deactivate("Pyroblast", "HotStreak")
            end
        end
    )
    local CheckFirestarter = OnAuraStateChange(function() return FindAura("player", 54741, "HELPFUL") end,
        function(present, duration)
            if present then
                f:Activate("Flamestrike", "Firestarter", duration, true)
            else
                f:Deactivate("Flamestrike", "Firestarter")
            end
        end
    )
    ns.configs.MAGE = function(self)
        self:SetScript("OnUpdate", self.timerOnUpdate)
        local hasFingersOfFrost = IsPlayerSpell(44543) or IsPlayerSpell(44545)
        local hasMissileBarrage = IsPlayerSpell(44404) or IsPlayerSpell(54486) or IsPlayerSpell(54488) or IsPlayerSpell(54489) or IsPlayerSpell(54490)
        local hasBrainFreeze = IsPlayerSpell(44546) or IsPlayerSpell(44548) or IsPlayerSpell(44549)
        local hasHotStreak = IsPlayerSpell(44445) or IsPlayerSpell(44446) or IsPlayerSpell(44448)
        local hasFirestarter = IsPlayerSpell(44442) or IsPlayerSpell(44443)

        -- if hasFingersOfFrost then

        self:RegisterUnitEvent("UNIT_AURA", "player")
        self:SetScript("OnUpdate", self.timerOnUpdate)
        self.UNIT_AURA = function(self, event, unit)
            if hasFingersOfFrost then
                CheckFingers()
            end
            if hasMissileBarrage then
                CheckBarrage()
            end
            if hasBrainFreeze then
                CheckBrainFreeze()
            end
            if hasHotStreak then
                CheckHotStreak()
            end
            if hasFirestarter then
                CheckFirestarter()
            end
        end
        -- else
        --     self:SetScript("OnUpdate", nil)
        --     self:UnregisterEvent("UNIT_AURA")
        -- end
    end

end


-----------------
-- DRUID
-----------------

if APILevel == 3 then
    local CheckSolarEclipse = OnAuraStateChange(function() return FindAura("player", 48517, "HELPFUL") end,
        function(present, duration)
            if present then
                f:Activate("Wrath", "SolarEclipse", duration, true)
            else
                f:Deactivate("Wrath", "SolarEclipse")
            end
        end
    )
    local CheckLunarEclipse = OnAuraStateChange(function() return FindAura("player", 48518, "HELPFUL") end,
        function(present, duration)
            if present then
                f:Activate("Starfire", "SolarEclipse", duration, true)
            else
                f:Deactivate("Starfire", "SolarEclipse")
            end
        end
    )

    ns.configs.DRUID = function(self)
        self:SetScript("OnUpdate", self.timerOnUpdate)
        local hasEclipse = IsPlayerSpell(48516) or IsPlayerSpell(48521) or IsPlayerSpell(48525)
        if hasEclipse then
            self:RegisterUnitEvent("UNIT_AURA", "player")
            self:SetScript("OnUpdate", self.timerOnUpdate)
            self.UNIT_AURA = function(self, event, unit)
                if hasEclipse then
                    CheckSolarEclipse()
                    CheckLunarEclipse()
                end
            end
        else
            self:SetScript("OnUpdate", nil)
            self:UnregisterEvent("UNIT_AURA")
        end
    end

end

-----------------
-- PRIEST
-----------------

if APILevel == 3 then
    local CheckSerendipity = OnAuraStateChange(
        function()
            local name, _, count, _, duration, expirationTime = FindAura("player", 63734, "HELPFUL")
            if count == 3 then
                return name, _, count, _, duration, expirationTime
            end
        end,
        function(present, duration)
            if present then
                f:Activate("GreaterHeal", "Serendipity", duration, true)
            else
                f:Deactivate("GreaterHeal", "Serendipity")
            end
        end
    )

    ns.configs.PRIEST = function(self)
        self:SetScript("OnUpdate", self.timerOnUpdate)
        local hasSerendipityRank3 = IsPlayerSpell(63737)
        if hasSerendipityRank3 then
            self:RegisterUnitEvent("UNIT_AURA", "player")
            self:SetScript("OnUpdate", self.timerOnUpdate)
            self.UNIT_AURA = function(self, event, unit)
                if hasSerendipityRank3 then
                    CheckSerendipity()
                end
            end
        else
            self:SetScript("OnUpdate", nil)
            self:UnregisterEvent("UNIT_AURA")
        end
    end

end