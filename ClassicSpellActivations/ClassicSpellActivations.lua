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

local spellNamesByID = {
    [7384] = "Overpower",
    -- TBC and Clasic ranks
    [7887] = "Overpower",
    [11584] = "Overpower",
    [11585] = "Overpower",

    -- TBC
    [29801] = "Rampage",
    [30030] = "Rampage",
    [30033] = "Rampage",

    [34428] = "VictoryRush",

    [14251] = "Riposte",

    [19306] = "Counterattack",
    [20909] = "Counterattack",
    [20910] = "Counterattack",
    [27067] = "Counterattack",

    [34026] = "KillCommand",

    [1495] = "MongooseBite",
    [14269] = "MongooseBite",
    [14270] = "MongooseBite",
    [14271] = "MongooseBite",
    [36916] = "MongooseBite",
}
local function AddSpellName(name, ...)
    local numArgs = select("#",...)
    for i=1, numArgs do
        local spellID = select(i, ...)
        spellNamesByID[spellID] = name
    end
end

-- Wrath
-- Mage: Missile Barrage (arcane), Hot Streak (instant pyro), Firestarter(instant Flamestrik), Brain Freeze, Fingers of Frost, Deep Freeze?
-- Warlock:
    -- Demo:Molten Core, Decimation
    -- Afflication: Drain Soul execute
    -- Destruction: Backlash
-- Priest: Serendipity
-- Druid: Predatory Swiftness, Eclipses
-- DK: Frost procs

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


f:RegisterEvent("PLAYER_LOGIN")
function f:PLAYER_LOGIN()

    if class == "WARRIOR" or class == "ROGUE" or class == "HUNTER" or class == "WARLOCK" or class == "PALADIN" or class == "SHAMAN" then
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
            LBG = LibStub("LibButtonGlow-1.0", true)
            self:RegisterForActivations(LAB2.eventFrame)
            LAB2:RegisterCallback("OnButtonUpdate", function(event, self)
                ns.LAB_UpdateOverlayGlow(self)
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

local hadTasteForBlood
local hadSuddenDeath
local hadSwordAndBoard
local hadShadowTrance
local hadFocused
local hadBacklash
function f:SPELLS_CHANGED()
    if class == "WARRIOR" then
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

        if hasVictoryRush or ns.findHighestRank("Execute") then
            self:RegisterEvent("SPELL_UPDATE_USABLE")
            local wasUsable = IsUsableSpell(34428)
            local wasUsableExecute = IsUsableSpell("Execute")
            self.SPELL_UPDATE_USABLE = function()
                local isUsable = IsUsableSpell(34428)
                if wasUsable ~= isUsable then
                    if isUsable then
                        f:Activate("VictoryRush", 20, true)
                    else
                        f:Deactivate("VictoryRush")
                    end
                    wasUsable = isUsable
                end

                local isUsableExecute = IsUsableSpell("Execute")
                if wasUsableExecute ~= isUsableExecute then
                    if isUsableExecute then
                        f:Activate("Execute", 10, true)
                    else
                        f:Deactivate("Execute")
                    end
                    wasUsableExecute = isUsableExecute
                end
            end
        end

        local hasTasteForBloodTalent = IsPlayerSpell(56636) or IsPlayerSpell(56637) or IsPlayerSpell(56638)
        local hasSuddenDeathTalent = IsPlayerSpell(29723) or IsPlayerSpell(29725) or IsPlayerSpell(29724)
        local hasSwordAndBoardTalent = IsPlayerSpell(46951) or IsPlayerSpell(46952) or IsPlayerSpell(46953)
        if hasTasteForBloodTalent or hasSuddenDeathTalent or hasSwordAndBoardTalent then
            self:RegisterUnitEvent("UNIT_AURA", "player")
            self:SetScript("OnUpdate", self.timerOnUpdate)
            self.UNIT_AURA = function(self, event, unit)
                if hasTasteForBloodTalent then
                    local name, _, _, _, duration, expirationTime = FindAura(unit, 60503, "HELPFUL") -- Taste for Blood
                    local haveTasteForBlood = name ~= nil
                    if hadTasteForBlood ~= haveTasteForBlood then
                        if haveTasteForBlood then
                            f:Activate("Overpower", duration, true)
                        else
                            f:Deactivate("Overpower")
                        end
                        hadTasteForBlood = haveTasteForBlood
                    end
                end

                if hasSuddenDeathTalent then
                    local name, _, _, _, duration, expirationTime = FindAura(unit, 52437, "HELPFUL") -- Sudden Death
                    local haveSuddenDeath = name ~= nil
                    if hadSuddenDeath ~= haveSuddenDeath then
                        if haveSuddenDeath then
                            f:Activate("Execute", duration, true)
                        else
                            f:Deactivate("Execute")
                        end
                        hadSuddenDeath = haveSuddenDeath
                    end
                end

                if hasSwordAndBoardTalent then
                    local name, _, _, _, duration, expirationTime = FindAura(unit, 50227, "HELPFUL") -- Sword and Board
                    local haveSwordAndBoard = name ~= nil
                    if hadSwordAndBoard ~= haveSwordAndBoard then
                        if haveSwordAndBoard then
                            f:Activate("ShieldSlam", duration, true)
                        else
                            f:Deactivate("ShieldSlam")
                        end
                        hadSwordAndBoard = haveSwordAndBoard
                    end
                end
            end
        else
            self:SetScript("OnUpdate", nil)
            self:UnregisterEvent("UNIT_AURA")
        end

    elseif class == "ROGUE" then
        if ns.findHighestRank("Riposte") then
            self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
            procCombatLog = ns.CheckRiposte
            self:SetScript("OnUpdate", self.timerOnUpdate)
        else
            self:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
            self:SetScript("OnUpdate", nil)
        end

    elseif class == "PALADIN" then
        if ns.findHighestRank("Exorcism") then
            self:RegisterEvent("PLAYER_TARGET_CHANGED")
            self.PLAYER_TARGET_CHANGED = ns.PaladinExorcismCheck
            self:SetScript("OnUpdate", self.timerOnUpdate)

            if ns.findHighestRank("HammerOfWrath") then
                self:RegisterUnitEvent("UNIT_HEALTH", "target")
                self.PLAYER_TARGET_CHANGED = function(...)
                    ns.PaladinExorcismCheck(...)
                    ns.HOWCheck(...)
                end
                self.UNIT_HEALTH = ns.HOWCheck
            end
        end

    elseif class == "HUNTER" then

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
    elseif class == "WARLOCK" then
        self:SetScript("OnUpdate", self.timerOnUpdate)
        local hasNightfallTalent = IsPlayerSpell(18094) or IsPlayerSpell(18095)
        local hasBacklashTalent = IsPlayerSpell(34939) or IsPlayerSpell(34938) or IsPlayerSpell(34935)
        if hasNightfallTalent or hasBacklashTalent then
            self:RegisterUnitEvent("UNIT_AURA", "player")
            self:SetScript("OnUpdate", self.timerOnUpdate)
            self.UNIT_AURA = function(self, event, unit)
                if hasNightfallTalent then
                    local name, _, _, _, duration, expirationTime = FindAura(unit, 17941, "HELPFUL") -- Shadow Trance
                    local haveShadowTrance = name ~= nil
                    if hadShadowTrance ~= haveShadowTrance then
                        if haveShadowTrance then
                            f:Activate("ShadowBolt", duration, true)
                        else
                            f:Deactivate("ShadowBolt")
                        end
                        hadShadowTrance = haveShadowTrance
                    end
                end
                if hasBacklashTalent then
                    local name, _, _, _, duration, expirationTime = FindAura(unit, 34936, "HELPFUL") -- Backlash
                    local haveBacklash = name ~= nil
                    if hadBacklash ~= haveBacklash then
                        if haveBacklash then
                            f:Activate("ShadowBolt", duration, true)
                            f:Activate("Incinerate", duration, true)
                        else
                            f:Deactivate("ShadowBolt")
                            f:Deactivate("Incinerate")
                        end
                        hadBacklash = haveBacklash
                    end
                end
            end
        else
            self:SetScript("OnUpdate", nil)
            self:UnregisterEvent("UNIT_AURA")
        end
    elseif class == "SHAMAN" then
        if APILevel == 2 then
        self:SetScript("OnUpdate", self.timerOnUpdate)
        local hasShamanisticFocusTalent = IsPlayerSpell(43338)
        if hasShamanisticFocusTalent then
            self:RegisterUnitEvent("UNIT_AURA", "player")
            self:SetScript("OnUpdate", self.timerOnUpdate)
            self.UNIT_AURA = function(self, event, unit)
                if hasShamanisticFocusTalent then
                    local name, _, _, _, duration, expirationTime = FindAura(unit, 43339, "HELPFUL") -- Focused
                    local haveFocused = name ~= nil
                    if hadFocused ~= haveFocused then
                        if haveFocused then
                            f:Activate("EarthShock", duration, true)
                            f:Activate("FlameShock", duration, true)
                            f:Activate("FrostShock", duration, true)
                        else
                            f:Deactivate("EarthShock")
                            f:Deactivate("FlameShock")
                            f:Deactivate("FrostShock")
                        end
                        hadFocused = haveFocused
                    end
                end
            end
        else
            self:SetScript("OnUpdate", nil)
            self:UnregisterEvent("UNIT_AURA")
        end
        end
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

function f:FanoutEvent(event, ...)
    for frame, _ in pairs(registeredFrames) do
        local eventHandler = frame:GetScript("OnEvent")
        if eventHandler then
            eventHandler(frame, event, ...)
        end
    end
end

local reverseSpellRanks = {
    Overpower = { 11585, 11584, 7887, 7384 },
    Revenge = { 57823, 30357, 25288, 25269, 11601, 11600, 7379, 6574, 6572 },
    Rampage = { 30033, 30030, 29801},
    Riposte = { 14251 },
    Counterattack = { 27067, 20910, 20909, 19306 },
    KillCommand = { 34026 },
    Execute = { 47471, 47470, 25236, 25234, 20662, 20661, 20660, 20658, 5308 },
    ShadowBolt = { 47809, 47808, 27209, 25307, 11661, 11660, 11659, 7641, 1106, 1088, 705, 695, 686 },
    Incinerate = { 47838, 47837, 32231, 29722 },
    MongooseBite = { 36916, 14271, 14270, 14269, 1495 },
    Exorcism = { 48801, 48800, 27138, 10314, 10313, 10312, 5615, 5614, 879 },
    HammerOfWrath = { 48806, 48805, 27180, 24274, 24239, 24275 },
    VictoryRush = { 34428 },
    ShieldSlam = { 47488, 47487, 30356, 25258, 23925, 23924, 23923, 23922 },
    EarthShock = { 57823, 30357, 25288, 25269, 11601, 11600, 7379, 6574, 6572 },
    FlameShock = { 49233, 49232, 29228, 25457, 10448, 10447, 8053, 8052, 8050 },
    FrostShock = { 49231, 49230, 25454, 10414, 10413, 10412, 8046, 8045, 8044, 8042 },
}
function ns.findHighestRank(spellName)
    for _, spellID in ipairs(reverseSpellRanks[spellName]) do
        if IsPlayerSpell(spellID) then return spellID end
    end
end
local findHighestRank = ns.findHighestRank

function f:Activate(spellName, duration, keepExpiration)
    local state = activations[spellName]
    if not state then
        activations[spellName] = {}
        state = activations[spellName]
    end
    if not state.active then
        state.active = true
        state.expirationTime = duration and GetTime() + duration

        local highestRankSpellID = findHighestRank(spellName)
        self:FanoutEvent("SPELL_ACTIVATION_OVERLAY_GLOW_SHOW", highestRankSpellID)
    elseif not keepExpiration then
        state.expirationTime = duration and GetTime() + duration
    end
end
function f:Deactivate(spellName)
    local state = activations[spellName]
    if state and state.active == true then
        state.active = false
        state.expirationTime = nil

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
    for spellName, state in pairs(activations) do
        if state.expirationTime and now >= state.expirationTime then
            f:Deactivate(spellName)
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
            f:Activate("Execute", 10)
        else
            f:Deactivate("Execute")
        end
    else
        f:Deactivate("Execute")
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
                f:Activate("Overpower", 5)
            end

        end

        if eventType == "SPELL_CAST_SUCCESS" then
            local spellName = select(2, ...)
            if spellName == LocalizedOverpower then
                f:Deactivate("Overpower")
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
                f:Activate("Revenge", 5)
            end
        end
        if eventType == "SWING_DAMAGE" then
            local blocked = select(5, ...)
            if blocked then
                f:Activate("Revenge", 5)
            end
        end
    end

    if isSrcPlayer and eventType == "SPELL_CAST_SUCCESS" then
        local spellName = select(2, ...)
        if spellName == LocalizedRevenge then
            f:Deactivate("Revenge")
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
                f:Activate("Rampage", 5)
            end

        end
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
                f:Activate("Riposte", 5)
            end
        end
    end

    if isSrcPlayer and eventType == "SPELL_CAST_SUCCESS" then
        local spellName = select(2, ...)
        if spellName == LocalizedRiposte then -- Riposte
            f:Deactivate("Riposte")
        end
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
                f:Activate("Counterattack", 5)
            end
        end
    end

    if isSrcPlayer and eventType == "SPELL_CAST_SUCCESS" then
        local spellName = select(2, ...)
        if spellName == LocalizedCounterattack then
            f:Deactivate("Counterattack", 5)
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
                f:Activate("MongooseBite", 5)
            end
        end
    end

    if isSrcPlayer and eventType == "SPELL_CAST_SUCCESS" then
        local spellName = select(2, ...)
        if spellName == LocalizedMongooseBite then
            f:Deactivate("MongooseBite", 5)
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
                f:Activate("KillCommand", 5)
            end

        end
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
                f:Activate("Exorcism", 5)
            else
                f:Deactivate("Exorcism")
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
            f:Deactivate("Exorcism")
            periodicCheck = nil
        end
    end
end

function ns.HOWCheck(self, event, unit)
    if UnitExists("target") and not UnitIsFriend("player", "target") then
        local h = UnitHealth("target")
        local hm = UnitHealthMax("target")
        if h > 0 and h/hm <= 0.2 then
            f:Activate("HammerOfWrath", 10)
        else
            f:Deactivate("HammerOfWrath")
        end
    else
        f:Deactivate("HammerOfWrath")
    end
end
