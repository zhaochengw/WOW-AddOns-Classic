local resolveUnitID

do
    local unitPrefix = {}
    local unitSuffix = {}

    do
        local unit, pet = "player", "pet"
        unitPrefix[unit] = unit
        unitPrefix[unit .. "target"] = unit
        unitPrefix[unit .. "targettarget"] = unit
        unitSuffix[unit] = ""
        unitSuffix[unit .. "target"] = "-target"
        unitSuffix[unit .. "targettarget"] = "-target-target"
        unitPrefix[pet] = unit
        unitSuffix[pet] = "-pet"
    end

    for i = 1, MAX_PARTY_MEMBERS do
        local unit, pet = "party" .. i, "partypet" .. i
        unitPrefix[unit] = unit
        unitPrefix[unit .. "target"] = unit
        unitPrefix[unit .. "targettarget"] = unit
        unitSuffix[unit] = ""
        unitSuffix[unit .. "target"] = "-target"
        unitSuffix[unit .. "targettarget"] = "-target-target"
        unitPrefix[pet] = unit
        unitSuffix[pet] = "-pet"
    end

    for i = 1, MAX_RAID_MEMBERS do
        local unit, pet = "raid" .. i, "raidpet" .. i
        unitPrefix[unit] = unit
        unitPrefix[unit .. "target"] = unit
        unitPrefix[unit .. "targettarget"] = unit
        unitSuffix[unit] = ""
        unitSuffix[unit .. "target"] = "-target"
        unitSuffix[unit .. "targettarget"] = "-target-target"
        unitPrefix[pet] = unit
        unitSuffix[pet] = "-pet"
    end

    function resolveUnitID(unit)
        if not unit then
            return nil
        end

        local prefix, suffix = unitPrefix[unit], unitSuffix[unit]

        if not UnitExists(prefix) or not UnitGUID(prefix) or not select(6, GetPlayerInfoByGUID(UnitGUID(prefix))) then
            return nil, prefix, suffix
        end

        return GetUnitName(prefix, true) .. suffix, prefix, suffix
    end
end

local groupNone = {"player"}
local groupParty = {"player"}
local groupRaid = {}

for i = 1, MAX_PARTY_MEMBERS do
    tinsert(groupParty, "party" .. i)
end

for i = 1, MAX_RAID_MEMBERS do
    tinsert(groupRaid, "raid" .. i)
end

local petIDs = {["player"] = "pet"}

for i = 1, MAX_PARTY_MEMBERS do
    petIDs["party" .. i] = "partypet" .. i
end

for i = 1, MAX_RAID_MEMBERS do
    petIDs["raid" .. i] = "raidpet" .. i
end

local frames = {}
setmetatable(frames, {__mode = "k"})

local hooks_CompactUnitFrame_UpdateAll = {}
local hooks_CompactUnitFrame_UpdateVisible = {}
local hooks_CompactUnitFrame_SetUnit = {}

local FuturePrototype = {}
local FutureMetatable = {
    __index = FuturePrototype,
    __metatable = true
}

function FuturePrototype:Run()
    if self._future then
        return self._future:Run()
    else
        return self._run(self)
    end
end

function FuturePrototype:Continue(future)
    if not self:IsCancelled() and not self:IsDone() then
        self:Cancel()
    end

    self._event = nil
    self._future = future
end

function FuturePrototype:Cancel()
    if self._future then
        self._future:Cancel()
    else
        self._cancelled = true
    end
end

function FuturePrototype:IsCancelled()
    if self._future then
        return self._future:IsCancelled()
    else
        return self._cancelled
    end
end

function FuturePrototype:IsDone()
    if self._future then
        return self._future:IsDone()
    else
        return self._done
    end
end

function FuturePrototype:Get()
    if self._future then
        return self._future:Get()
    else
        return self._result
    end
end

local continueOnGroupRosterLoaded
local continueOnNotInCombatLockdown
local continueOnGroupRosterLoadedAndNotInCombatLockdown

do
    local futures = {}
    local futureFrame = CreateFrame("Frame")
    futureFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
    futureFrame:RegisterEvent("UNIT_NAME_UPDATE")
    futureFrame:SetScript(
        "OnEvent",
        function(self, event)
            for i = #futures, 1, -1 do
                local future = futures[i]

                if future._event == true or future._event == event then
                    future:Run()
                end

                if future._event == nil or future:IsCancelled() or future:IsDone() then
                    futures[i] = futures[#futures]
                    futures[#futures] = nil
                end
            end
        end
    )

    local function isGroupRosterLoaded()
        local group

        if GetNumGroupMembers() == 0 then
            group = groupNone
        elseif not IsInRaid() then
            group = groupParty
        else
            group = groupRaid
        end

        for i = 1, #group do
            local unit = group[i]

            if UnitExists(unit) then
                local unitGUID = UnitGUID(unit)

                if not unitGUID or not select(6, GetPlayerInfoByGUID(unitGUID)) then
                    return false
                end
            end
        end

        return true
    end

    local function continueOn(event, condition, timeout, callback)
        local future = setmetatable({}, FutureMetatable)
        future._cancelled = false
        future._done = false
        future._event = event
        future._run = function()
            if future._cancelled or future._done then
                return future._result
            end

            if condition and not condition() then
                if timeout then
                    C_Timer.After(timeout, future._run)
                end

                return future._result
            end

            future._result = callback(future)
            future._done = true
            return future._result
        end

        C_Timer.After(0, future._run)
        tinsert(futures, future)
        return future
    end

    function continueOnGroupRosterLoaded(callback)
        return continueOn("UNIT_NAME_UPDATE", isGroupRosterLoaded, 1.0, callback)
    end

    local notInCombatLockdown = function()
        return not InCombatLockdown()
    end

    function continueOnNotInCombatLockdown(callback)
        return continueOn("PLAYER_REGEN_ENABLED", notInCombatLockdown, nil, callback)
    end

    function continueOnGroupRosterLoadedAndNotInCombatLockdown(callback, callback2)
        local time = GetTime()
        local future =
            continueOnGroupRosterLoaded(
            function(self)
                self:Continue(continueOnNotInCombatLockdown(callback))

                if callback2 and not self:IsDone() and time < GetTime() then
                    callback2()
                end
            end
        )

        if callback2 and not future:IsDone() then
            callback2()
        end

        return future
    end
end

local function CompactUnitFrame_Hide(frame)
    frame.background:Hide()

    frame.healthBar:SetMinMaxValues(0, 0)
    frame.healthBar:SetValue(0)

    if frame.powerBar then
        frame.powerBar:SetMinMaxValues(0, 0)
        frame.powerBar:SetValue(0)
        frame.powerBar.background:Hide()
    end

    frame.name:Hide()

    frame.selectionHighlight:Hide()

    if frame.aggroHighlight then
        frame.aggroHighlight:Hide()
    end

    if frame.LoseAggroAnim then
        frame.LoseAggroAnim:Stop()
    end

    if frame.statusText then
        frame.statusText:Hide()
    end

    if frame.myHealPrediction then
        frame.myHealPrediction:Hide()
    end

    if frame.otherHealPrediction then
        frame.otherHealPrediction:Hide()
    end

    if frame.totalAbsorb then
        frame.totalAbsorb:Hide()
    end

    if frame.totalAbsorbOverlay then
        frame.totalAbsorbOverlay:Hide()
    end

    if frame.overAbsorbGlow then
        frame.overAbsorbGlow:Hide()
    end

    if frame.myHealAbsorb then
        frame.myHealAbsorb:Hide()
    end

    if frame.myHealAbsorbLeftShadow then
        frame.myHealAbsorbLeftShadow:Hide()
    end

    if frame.myHealAbsorbRightShadow then
        frame.myHealAbsorbRightShadow:Hide()
    end

    if frame.overHealAbsorbGlow then
        frame.overHealAbsorbGlow:Hide()
    end

    if frame.roleIcon then
        frame.roleIcon:Hide()
    end

    if frame.readyCheckIcon then
        frame.readyCheckIcon:Hide()
    end

    CompactUnitFrame_HideAllBuffs(frame)
    CompactUnitFrame_HideAllDebuffs(frame)
    CompactUnitFrame_HideAllDispelDebuffs(frame)

    if frame.centerStatusIcon then
        frame.centerStatusIcon:Hide()
    end

    if frame.classificationIndicator then
        frame.classificationIndicator:Hide()
    end

    if frame.LevelFrame then
        if frame.LevelFrame.levelText then
            frame.LevelFrame.levelText:Hide()
        end

        if frame.LevelFrame.highLevelTexture then
            frame.LevelFrame.highLevelTexture:Hide()
        end
    end

    if frame.WidgetContainer then
        frame.WidgetContainer:UnregisterForWidgetSet()
    end
end

local CompactUnitFrame_UpdateAllSecure_IfUnitExists

if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
    function CompactUnitFrame_UpdateAllSecure_IfUnitExists(frame)
        CompactUnitFrame_UpdateMaxHealth(frame)
        CompactUnitFrame_UpdateHealth(frame)
        CompactUnitFrame_UpdateMaxPower(frame)
        CompactUnitFrame_UpdatePower(frame)
        CompactUnitFrame_UpdatePowerColor(frame)
        CompactUnitFrame_UpdateWidgetsOnlyMode(frame)
        CompactUnitFrame_UpdateSelectionHighlight(frame)
        CompactUnitFrame_UpdateAggroHighlight(frame)
        CompactUnitFrame_UpdateAggroFlash(frame)
        CompactUnitFrame_UpdateHealthBorder(frame)
        CompactUnitFrame_UpdateInRange(frame)
        CompactUnitFrame_UpdateStatusText(frame)
        CompactUnitFrame_UpdateHealPrediction(frame)
        CompactUnitFrame_UpdateRoleIcon(frame)
        CompactUnitFrame_UpdateReadyCheck(frame)
        CompactUnitFrame_UpdateAuras(frame)
        CompactUnitFrame_UpdateCenterStatusIcon(frame)
        CompactUnitFrame_UpdateClassificationIndicator(frame)
        CompactUnitFrame_UpdateWidgetSet(frame)
    end
elseif WOW_PROJECT_ID == WOW_PROJECT_WRATH_CLASSIC then
    function CompactUnitFrame_UpdateAllSecure_IfUnitExists(frame)
        CompactUnitFrame_UpdateMaxHealth(frame)
        CompactUnitFrame_UpdateHealth(frame)
        CompactUnitFrame_UpdateHealthColor(frame)
        CompactUnitFrame_UpdateMaxPower(frame)
        CompactUnitFrame_UpdatePower(frame)
        CompactUnitFrame_UpdatePowerColor(frame)
        CompactUnitFrame_UpdateName(frame)
        CompactUnitFrame_UpdateSelectionHighlight(frame)
        CompactUnitFrame_UpdateAggroHighlight(frame)
        CompactUnitFrame_UpdateAggroFlash(frame)
        CompactUnitFrame_UpdateHealthBorder(frame)
        CompactUnitFrame_UpdateInRange(frame)
        CompactUnitFrame_UpdateStatusText(frame)
        CompactUnitFrame_UpdateRoleIcon(frame)
        CompactUnitFrame_UpdateReadyCheck(frame)
        CompactUnitFrame_UpdateAuras(frame)
        CompactUnitFrame_UpdateCenterStatusIcon(frame)
        CompactUnitFrame_UpdateClassificationIndicator(frame)
        CompactUnitFrame_UpdateLevel(frame)
    end
elseif WOW_PROJECT_ID == WOW_PROJECT_CLASSIC then
    function CompactUnitFrame_UpdateAllSecure_IfUnitExists(frame)
        CompactUnitFrame_UpdateMaxHealth(frame)
        CompactUnitFrame_UpdateHealth(frame)
        CompactUnitFrame_UpdateHealthColor(frame)
        CompactUnitFrame_UpdateMaxPower(frame)
        CompactUnitFrame_UpdatePower(frame)
        CompactUnitFrame_UpdatePowerColor(frame)
        CompactUnitFrame_UpdateName(frame)
        CompactUnitFrame_UpdateSelectionHighlight(frame)
        CompactUnitFrame_UpdateHealthBorder(frame)
        CompactUnitFrame_UpdateInRange(frame)
        CompactUnitFrame_UpdateStatusText(frame)
        CompactUnitFrame_UpdateRoleIcon(frame)
        CompactUnitFrame_UpdateReadyCheck(frame)
        CompactUnitFrame_UpdateAuras(frame)
        CompactUnitFrame_UpdateCenterStatusIcon(frame)
        CompactUnitFrame_UpdateClassificationIndicator(frame)
        CompactUnitFrame_UpdateLevel(frame)
    end
end

local function CompactUnitFrame_UpdateAllSecure(frame)
    if not InCombatLockdown() then
        CompactUnitFrame_UpdateInVehicle(frame)
        CompactUnitFrame_UpdateVisible(frame)
    else
        if UnitExists(frame.displayedUnit) then
            if not frame.unitExists then
                frame.newUnit = true
            end

            frame.unitExists = true

            frame.background:Show()

            if frame.powerBar then
                frame.powerBar.background:Show()
            end
        else
            if CompactUnitFrame_ClearWidgetSet then
                CompactUnitFrame_ClearWidgetSet(frame)
            end

            CompactUnitFrame_Hide(frame)

            frame.unitExists = false
        end

        for _, hookfunc in ipairs(hooks_CompactUnitFrame_UpdateVisible) do
            hookfunc(frame)
        end
    end

    if frame.unitExists then
        CompactUnitFrame_UpdateAllSecure_IfUnitExists(frame)
    end

    for _, hookfunc in ipairs(hooks_CompactUnitFrame_UpdateAll) do
        hookfunc(frame)
    end
end

hooksecurefunc(
    "CompactUnitFrame_UpdateInVehicle",
    function(frame)
        if frames[frame] == nil then
            return
        end

        local unit = frame:GetAttribute("unit")
        local unitTarget = resolveUnitID(unit)

        if unitTarget then
            frame:SetAttribute("unit", unitTarget)
        end
    end
)

hooksecurefunc(
    "CompactUnitFrame_UpdateVisible",
    function(frame)
        if frames[frame] == nil then
            return
        end

        if resolveUnitID(frame.unit) then
            frame.unitExists = UnitExists(frame.displayedUnit)

            if frame.unitExists then
                frame.background:Show()

                if frame.powerBar then
                    frame.powerBar.background:Show()
                end
            else
                if UnitExists(frame.unit) then
                    if CompactUnitFrame_ClearWidgetSet then
                        CompactUnitFrame_ClearWidgetSet(frame)
                    end
                end

                frame:Show()

                CompactUnitFrame_Hide(frame)
            end
        else
            frame.background:Show()

            if frame.powerBar then
                frame.powerBar.background:Show()
            end
        end
    end
)

if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
    hooksecurefunc(
        "CompactUnitFrame_UpdateRoleIcon",
        function(frame)
            if frames[frame] == nil then
                return
            end

            if not frame.roleIcon then
                return
            end

            local raidID = UnitInRaid(frame.unit)

            if not (frame.optionTable.displayRaidRoleIcon and raidID and select(10, GetRaidRosterInfo(raidID))) then
                local size = frame.roleIcon:GetHeight()
                frame.roleIcon:Hide()
                frame.roleIcon:SetSize(1, size)
            end
        end
    )
end

local CompactRaidFrameContainer_UpdateDisplayedUnits
local CompactRaidFrameContainer_TryUpdate
local CompactRaidFrameContainer_ApplyToFrames

if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
    CompactRaidFrameContainer_UpdateDisplayedUnits = _G.CompactRaidFrameContainer_UpdateDisplayedUnits
    CompactRaidFrameContainer_TryUpdate = _G.CompactRaidFrameContainer_TryUpdate
    CompactRaidFrameContainer_ApplyToFrames = _G.CompactRaidFrameContainer_ApplyToFrames
else
    function CompactRaidFrameContainer_UpdateDisplayedUnits(self)
    end

    function CompactRaidFrameContainer_TryUpdate(self)
        return self:TryUpdate()
    end

    function CompactRaidFrameContainer_ApplyToFrames(self, ...)
        return self:ApplyToFrames(...)
    end
end

do
    local future

    hooksecurefunc(
        "CompactUnitFrame_SetUnit",
        function(frame, unit)
            if frames[frame] == nil then
                if frame:IsForbidden() or not frame:GetName() or not frame:GetName():find("^Compact") then
                    return
                end
            end

            assert(not InCombatLockdown())

            local unitTarget, parentUnit = resolveUnitID(unit)
            assert(not unit or parentUnit)

            local updateAll = frames[frame] ~= unitTarget

            if unitTarget then
                if frame:GetAttribute("unit") == unit then
                    if not frame.onUpdateFrame then
                        frame.onUpdateFrame = CreateFrame("Frame")
                    end

                    frame.onUpdateFrame.func = function(updateFrame, elapsed)
                        if frame.displayedUnit then
                            CompactUnitFrame_UpdateAllSecure(frame)
                        end
                    end

                    frame.onUpdateFrame.func2 = function(updateFrame, event, unit)
                        if event == "GROUP_ROSTER_UPDATE" then
                            CompactUnitFrame_UpdateAllSecure(frame)
                        elseif event == "PLAYER_ENTERING_WORLD" then
                            CompactUnitFrame_UpdateAllSecure(frame)
                        elseif event == "PLAYER_REGEN_ENABLED" then
                            CompactUnitFrame_UpdateAllSecure(frame)
                        elseif event == "UNIT_CONNECTION" then
                            local pet = petIDs[unit]

                            if unit == frame.unit or unit == frame.displayedUnit or pet == frame.unit or pet == frame.displayedUnit then
                                CompactUnitFrame_UpdateAllSecure(frame)
                            end
                        elseif event == "UNIT_PET" then
                            local pet = petIDs[unit]

                            if unit == frame.unit or unit == frame.displayedUnit or pet == frame.unit or pet == frame.displayedUnit then
                                CompactUnitFrame_UpdateAllSecure(frame)
                            end
                        elseif event == "UNIT_NAME_UPDATE" then
                            local pet = petIDs[unit]

                            if unit == frame.unit or unit == frame.displayedUnit or pet == frame.unit or pet == frame.displayedUnit then
                                if frames[frame] ~= resolveUnitID(frame.unit) then
                                    if future then
                                        future:Cancel()
                                    end

                                    future =
                                        continueOnGroupRosterLoadedAndNotInCombatLockdown(
                                        function()
                                            CompactRaidFrameContainer_UpdateDisplayedUnits(CompactRaidFrameContainer)
                                            CompactRaidFrameContainer_TryUpdate(CompactRaidFrameContainer)

                                            future = nil
                                        end
                                    )
                                end
                            end
                        elseif event == "UNIT_ENTERED_VEHICLE" or event == "UNIT_EXITED_VEHICLE" or event == "PLAYER_GAINS_VEHICLE_DATA" or event == "PLAYER_LOSES_VEHICLE_DATA" then
                            if unit == frame.unit or unit == frame.displayedUnit or unit == "player" then
                                CompactUnitFrame_UpdateAllSecure(frame)
                            end
                        end
                    end

                    if frame.onUpdateFrame.doUpdate then
                        frame.onUpdateFrame:SetScript("OnUpdate", frame.onUpdateFrame.func)
                    else
                        frame.onUpdateFrame:SetScript("OnUpdate", nil)
                    end

                    frame.onUpdateFrame:SetScript("OnEvent", frame.onUpdateFrame.func2)

                    frame.onUpdateFrame:RegisterEvent("GROUP_ROSTER_UPDATE")
                    frame.onUpdateFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
                    frame.onUpdateFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
                    frame.onUpdateFrame:RegisterEvent("UNIT_CONNECTION")
                    frame.onUpdateFrame:RegisterEvent("UNIT_NAME_UPDATE")
                    frame.onUpdateFrame:RegisterEvent("UNIT_PET")

                    frame:UnregisterEvent("GROUP_ROSTER_UPDATE")
                    frame:UnregisterEvent("PLAYER_ENTERING_WORLD")
                    frame:UnregisterEvent("PLAYER_REGEN_ENABLED")
                    frame:UnregisterEvent("UNIT_CONNECTION")
                    frame:UnregisterEvent("UNIT_PET")

                    if UnitHasVehicleUI then
                        frame:UnregisterEvent("UNIT_ENTERED_VEHICLE")
                        frame:UnregisterEvent("UNIT_EXITED_VEHICLE")
                        frame:UnregisterEvent("PLAYER_GAINS_VEHICLE_DATA")
                        frame:UnregisterEvent("PLAYER_LOSES_VEHICLE_DATA")

                        frame.onUpdateFrame:RegisterEvent("UNIT_ENTERED_VEHICLE")
                        frame.onUpdateFrame:RegisterEvent("UNIT_EXITED_VEHICLE")
                        frame.onUpdateFrame:RegisterEvent("PLAYER_GAINS_VEHICLE_DATA")
                        frame.onUpdateFrame:RegisterEvent("PLAYER_LOSES_VEHICLE_DATA")
                    end

                    CompactUnitFrame_RegisterEvents(frame)

                    updateAll = frames[frame] == nil
                end

                frame:SetAttribute("unit", unitTarget)
            else
                if unit then
                    frame.unit = nil
                    frame.displayedUnit = nil
                    frame.inVehicle = false
                    frame.readyCheckStatus = nil
                    frame.readyCheckDecay = nil
                    frame.isTanking = nil
                    frame.hideCastbar = frame.optionTable.hideCastbar
                    frame.healthBar.healthBackground = nil
                    frame.hasValidVehicleDisplay = nil

                    frame:SetAttribute("unit", nil)

                    CompactUnitFrame_UnregisterEvents(frame)

                    updateAll = true
                end

                if frame.onUpdateFrame then
                    frame.onUpdateFrame.doUpdate = nil
                    frame.onUpdateFrame:UnregisterAllEvents()
                    frame.onUpdateFrame:SetScript("OnEvent", nil)
                    frame.onUpdateFrame:SetScript("OnUpdate", nil)
                end

                frame.background:Show()

                if frame.powerBar then
                    frame.powerBar.background:Show()
                end

                if UnitExists(parentUnit) then
                    if future then
                        future:Cancel()
                    end

                    future =
                        continueOnGroupRosterLoadedAndNotInCombatLockdown(
                        function()
                            CompactRaidFrameContainer_UpdateDisplayedUnits(CompactRaidFrameContainer)
                            CompactRaidFrameContainer_TryUpdate(CompactRaidFrameContainer)

                            future = nil
                        end
                    )
                end
            end

            frames[frame] = unitTarget

            if updateAll then
                CompactUnitFrame_UpdateAllSecure(frame)
            end
        end
    )
end

hooksecurefunc(
    "CompactUnitFrame_SetUpdateAllEvent",
    function(frame, updateAllEvent, updateAllFilter)
        if frames[frame] == nil then
            if frame:IsForbidden() or not frame:GetName() or not frame:GetName():find("^Compact") then
                return
            end
        end

        frame.updateAllEvent = nil
        frame.updateAllFilter = nil

        if updateAllEvent == "GROUP_ROSTER_UPDATE" then
            frame:UnregisterEvent(updateAllEvent)
        end
    end
)

hooksecurefunc(
    "CompactUnitFrame_SetUpdateAllOnUpdate",
    function(frame, doUpdate)
        if frames[frame] == nil then
            if frame:IsForbidden() or not frame:GetName() or not frame:GetName():find("^Compact") then
                return
            end
        end

        if frame.onUpdateFrame then
            frame.onUpdateFrame.doUpdate = doUpdate
        end
    end
)

local function updateAllFrames()
    local group

    if GetNumGroupMembers() == 0 then
        group = groupNone
    elseif not IsInRaid() then
        group = groupParty
    else
        group = groupRaid
    end

    local unitIDs = {}

    for i = 1, #group do
        local unit = group[i]
        local unitName = resolveUnitID(unit)

        if unitName then
            unitIDs[unitName] = unit
            unitIDs[unitName .. "-target"] = unit .. "target"
            unitIDs[unitName .. "-target-target"] = unit .. "targettarget"
            unitIDs[unitName .. "-pet"] = petIDs[unit]
        end
    end

    for frame, unitTarget in pairs(frames) do
        local unit = unitIDs[unitTarget]
        local currentUnit = frame.unit

        if currentUnit ~= unit then
            local displayedUnit = frame.displayedUnit

            if not unit or currentUnit == displayedUnit then
                displayedUnit = unit
            end

            frame.unit = unit
            frame.displayedUnit = displayedUnit

            if not unit or not currentUnit then
                frame.inVehicle = false
                frame.readyCheckStatus = nil
                frame.readyCheckDecay = nil
                frame.isTanking = nil
                frame.hideCastbar = frame.optionTable.hideCastbar
                frame.healthBar.healthBackground = nil
            end

            if unit then
                local displayUnitTarget = frame:GetAttribute("unit")
                frame.displayedUnit = unitTarget == displayUnitTarget and unit or unitIDs[displayUnitTarget]
            end

            frame.hasValidVehicleDisplay = frame.unit ~= frame.displayedUnit

            if unit then
                CompactUnitFrame_RegisterEvents(frame)
            else
                CompactUnitFrame_UnregisterEvents(frame)
            end

            if not unit then
                if frame.onUpdateFrame then
                    frame.onUpdateFrame:SetScript("OnEvent", nil)
                    frame.onUpdateFrame:SetScript("OnUpdate", nil)
                end
            elseif not currentUnit then
                if frame.onUpdateFrame then
                    if frame.onUpdateFrame.doUpdate then
                        frame.onUpdateFrame:SetScript("OnUpdate", frame.onUpdateFrame.func)
                    else
                        frame.onUpdateFrame:SetScript("OnUpdate", nil)
                    end

                    frame.onUpdateFrame:SetScript("OnEvent", frame.onUpdateFrame.func2)
                end
            end

            CompactUnitFrame_UpdateAllSecure(frame)

            for _, hookfunc in ipairs(hooks_CompactUnitFrame_SetUnit) do
                hookfunc(frame, unit)
            end
        end
    end
end

local function CompactUnitFrame_OnEnter(self)
    if self.unit then
        UnitFrame_UpdateTooltip(self)
    end
end

hooksecurefunc(
    "CompactUnitFrame_SetUpFrame",
    function(frame)
        if frame:IsForbidden() or not frame:GetName() or not frame:GetName():find("^Compact") then
            return
        end

        frame:SetScript("OnEnter", CompactUnitFrame_OnEnter)
    end
)

do
    local function CompactPartyFrame_UpdateUnits(self)
        local name = self:GetName()

        do
            local unitFrame = _G[name .. "Member1"]

            CompactUnitFrame_SetUnit(unitFrame, nil)
            CompactUnitFrame_SetUnit(unitFrame, "player")
        end

        for i = 1, MEMBERS_PER_RAID_GROUP do
            if i > 1 then
                local unit = "party" .. (i - 1)
                local unitFrame = _G[name .. "Member" .. i]

                CompactUnitFrame_SetUnit(unitFrame, nil)

                if UnitExists(unit) then
                    CompactUnitFrame_SetUnit(unitFrame, unit)
                end
            end
        end
    end

    local future

    local function CompactPartyFrame_OnEvent(self, event)
        if event == "GROUP_ROSTER_UPDATE" then
            if future then
                future:Cancel()
            end

            future =
                continueOnGroupRosterLoadedAndNotInCombatLockdown(
                function()
                    CompactPartyFrame_UpdateUnits(self)

                    future = nil
                end,
                updateAllFrames
            )
        end
    end

    local _CompactPartyFrame_Generate = CompactPartyFrame_Generate

    function CompactPartyFrame_Generate()
        local frame, didCreate = _CompactPartyFrame_Generate()

        if didCreate then
            frame:RegisterEvent("GROUP_ROSTER_UPDATE")
            frame:SetScript("OnEvent", CompactPartyFrame_OnEvent)
            CompactPartyFrame_UpdateUnits(frame)
        end

        return frame, didCreate
    end
end

do
    function CompactRaidGroup_UpdateUnits(frame)
        local groupIndex = frame:GetID()
        local frameIndex = 1

        for i = 1, MAX_RAID_MEMBERS do
            local unit = "raid" .. i
            local raidID = UnitInRaid(unit)

            if raidID then
                local name, rank, subgroup = GetRaidRosterInfo(raidID)

                if subgroup == groupIndex and frameIndex <= MEMBERS_PER_RAID_GROUP then
                    local unitFrame = _G[frame:GetName() .. "Member" .. frameIndex]

                    CompactUnitFrame_SetUnit(unitFrame, nil)

                    if UnitExists(unit) then
                        CompactUnitFrame_SetUnit(unitFrame, unit)
                    end

                    frameIndex = frameIndex + 1
                end
            end
        end

        for i = frameIndex, MEMBERS_PER_RAID_GROUP do
            local unitFrame = _G[frame:GetName() .. "Member" .. i]
            CompactUnitFrame_SetUnit(unitFrame, nil)
        end
    end

    local future = {}

    function CompactRaidGroup_OnEvent(self, event)
        if event == "GROUP_ROSTER_UPDATE" then
            local groupIndex = self:GetID()

            if future[groupIndex] then
                future[groupIndex]:Cancel()
            end

            future[groupIndex] =
                continueOnGroupRosterLoadedAndNotInCombatLockdown(
                function()
                    CompactRaidGroup_UpdateUnits(self)

                    future[groupIndex] = nil
                end,
                updateAllFrames
            )
        end
    end
end

do
    local eventHandlers = {}

    local function CompactRaidFrameContainer_OnEvent(self, event, ...)
        local eventHandler = eventHandlers[event]

        if eventHandler then
            eventHandler(self, ...)
        end
    end

    if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
        _G.CompactRaidFrameContainer_OnEvent = CompactRaidFrameContainer_OnEvent
    else
        CompactRaidFrameContainerMixin.OnEvent = CompactRaidFrameContainer_OnEvent
    end

    CompactRaidFrameContainer:RegisterEvent("PLAYER_ENTERING_WORLD")
    CompactRaidFrameContainer:RegisterEvent("UNIT_CONNECTION")
    CompactRaidFrameContainer:SetScript("OnEvent", CompactRaidFrameContainer_OnEvent)

    local future

    function eventHandlers.GROUP_ROSTER_UPDATE(self)
        if future then
            future:Cancel()
        end

        future =
            continueOnGroupRosterLoadedAndNotInCombatLockdown(
            function()
                CompactRaidFrameContainer_UpdateDisplayedUnits(self)
                CompactRaidFrameContainer_TryUpdate(self)

                future = nil
            end,
            updateAllFrames
        )
    end

    local _CompactUnitFrameProfiles_ApplyProfile = CompactUnitFrameProfiles_ApplyProfile

    function eventHandlers.PLAYER_ENTERING_WORLD(self)
        if not InCombatLockdown() then
            CompactRaidFrameContainer_UpdateDisplayedUnits(self)

            if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE and RaidProfileExists(GetActiveRaidProfile()) then
                _CompactUnitFrameProfiles_ApplyProfile(GetActiveRaidProfile())
            else
                for _, settingName in ipairs(
                    {
                        "Managed",
                        "Locked",
                        "SortMode",
                        "KeepGroupsTogether",
                        "DisplayPets",
                        "DisplayMainTankAndAssist",
                        "IsShown",
                        "ShowBorders",
                        "HorizontalGroups"
                    }
                ) do
                    local settingValue = CompactRaidFrameManager_GetSetting(settingName)
                    CompactRaidFrameManager_SetSetting(settingName, settingValue)
                end

                CompactRaidFrameContainer_ApplyToFrames(CompactRaidFrameContainer, "normal", DefaultCompactUnitFrameSetup)
                CompactRaidFrameContainer_ApplyToFrames(CompactRaidFrameContainer, "normal", CompactUnitFrame_UpdateAll)
                CompactRaidFrameContainer_ApplyToFrames(CompactRaidFrameContainer, "mini", DefaultCompactMiniFrameSetup)
                CompactRaidFrameContainer_ApplyToFrames(CompactRaidFrameContainer, "mini", CompactUnitFrame_UpdateAll)
                CompactRaidFrameContainer_ApplyToFrames(CompactRaidFrameContainer, "group", CompactRaidGroup_UpdateBorder)

                CompactRaidFrameManager.dynamicContainerPosition = true
                CompactRaidFrameManager_UpdateContainerBounds(CompactRaidFrameManager)

                CompactRaidFrameContainer_TryUpdate(CompactRaidFrameContainer)
            end
        else
            eventHandlers.GROUP_ROSTER_UPDATE(self)
        end
    end

    function eventHandlers.UNIT_PET(self, unit)
        if self._displayPets then
            if strsub(unit, 1, 4) == "raid" or strsub(unit, 1, 5) == "party" or unit == "player" then
                eventHandlers.GROUP_ROSTER_UPDATE(self)
            end
        end
    end

    eventHandlers.UNIT_CONNECTION = eventHandlers.UNIT_PET
end

do
    local _CompactRaidFrameContainer_OnSizeChanged

    if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
        _CompactRaidFrameContainer_OnSizeChanged = _G.CompactRaidFrameContainer_OnSizeChanged
    else
        function _CompactRaidFrameContainer_OnSizeChanged(self)
            return self:OnSizeChanged()
        end
    end

    local future

    local function CompactRaidFrameContainer_OnSizeChanged(self)
        if future then
            future:Cancel()
        end

        future =
            continueOnGroupRosterLoadedAndNotInCombatLockdown(
            function()
                _CompactRaidFrameContainer_OnSizeChanged(self)

                future = nil
            end
        )
    end

    if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
        _G.CompactRaidFrameContainer_OnSizeChanged = CompactRaidFrameContainer_OnSizeChanged
    else
        CompactRaidFrameContainerMixin.OnSizeChanged = CompactRaidFrameContainer_OnSizeChanged
    end

    CompactRaidFrameContainer:SetScript("OnSizeChanged", CompactRaidFrameContainer_OnSizeChanged)
end

do
    local _CompactRaidFrameContainer_ReadyToUpdate = CompactRaidFrameContainer_ReadyToUpdate

    local function CompactRaidFrameContainer_ReadyToUpdate(self)
        return _CompactRaidFrameContainer_ReadyToUpdate(self) and not InCombatLockdown()
    end

    if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
        _G.CompactRaidFrameContainer_ReadyToUpdate = CompactRaidFrameContainer_ReadyToUpdate
    else
        CompactRaidFrameContainerMixin.ReadyToUpdate = CompactRaidFrameContainer_ReadyToUpdate
    end
end

do
    local _CompactRaidFrameContainer_LayoutFrames = CompactRaidFrameContainer_LayoutFrames

    local function CompactRaidFrameContainer_LayoutFrames(self)
        self._displayPets = self.displayPets
        return _CompactRaidFrameContainer_LayoutFrames(self)
    end

    if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
        _G.CompactRaidFrameContainer_LayoutFrames = CompactRaidFrameContainer_LayoutFrames
    else
        CompactRaidFrameContainerMixin.LayoutFrames = CompactRaidFrameContainer_LayoutFrames
    end
end

if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
    local _CompactUnitFrameProfiles_ApplyProfile = CompactUnitFrameProfiles_ApplyProfile

    local future

    function CompactUnitFrameProfiles_ApplyProfile(profile)
        if future then
            future:Cancel()
        end

        future =
            continueOnGroupRosterLoadedAndNotInCombatLockdown(
            function()
                _CompactUnitFrameProfiles_ApplyProfile(profile)

                future = nil
            end
        )
    end
end

if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
    local _CompactPartyFrame_RefreshMembers = CompactPartyFrame_RefreshMembers

    local future

    function CompactPartyFrame_RefreshMembers()
        if future then
            future:Cancel()
        end

        future =
            continueOnGroupRosterLoadedAndNotInCombatLockdown(
            function()
                _CompactPartyFrame_RefreshMembers()

                future = nil
            end,
            updateAllFrames
        )
    end
end

hooksecurefunc(
    "hooksecurefunc",
    function(table, functionName, hookfunc)
        if type(table) ~= "table" then
            hookfunc = functionName
            functionName = table
            table = _G
        end

        if table == _G then
            if functionName == "CompactUnitFrame_UpdateAll" then
                tinsert(hooks_CompactUnitFrame_UpdateAll, hookfunc)
            elseif functionName == "CompactUnitFrame_UpdateVisible" then
                tinsert(hooks_CompactUnitFrame_UpdateVisible, hookfunc)
            elseif functionName == "CompactUnitFrame_SetUnit" then
                tinsert(hooks_CompactUnitFrame_SetUnit, hookfunc)
            end
        end
    end
)
