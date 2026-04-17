local LibEvent = LibStub:GetLibrary("LibEvent.7000")

local function FindLine(tooltip, keyword)
    local line, text
    for i = 2, tooltip:NumLines() do
        line = _G[tooltip:GetName() .. "TextLeft" .. i]
        text = line:GetText() or ""
        if (string.find(text, keyword)) then
            return line, i, _G[tooltip:GetName() .. "TextRight" .. i]
        end
    end
end

local LevelLabel = STAT_AVERAGE_ITEM_LEVEL .. ": "
local SpecLabel = SPECIALIZATION .. ": "
-- ====== TinyInspect: production-stable patch ======
local function AppendToGameTooltip_Safe(guid, ilevel, spec, weaponLevel, isArtifact)
    local displayIlevel
    if type(ilevel) == "number" and ilevel >= 0 then
        displayIlevel = tostring(math.floor(ilevel))
    else
        displayIlevel = "..." 
    end

    spec = spec or ""
    if (TinyInspectClassicDB and not TinyInspectClassicDB.EnableMouseSpecialization) then spec = "" end

    local _, unit = GameTooltip:GetUnit()
    if (not unit or UnitGUID(unit) ~= guid) then
        local mg = UnitGUID("mouseover")
        if mg ~= guid then
            return
        end
    end

    local ilvlLine, _, lineRight = FindLine(GameTooltip, LevelLabel)
    local ilvlText = format("%s|cffffffff%s|r", LevelLabel, displayIlevel)
    local specText = format("|cffb8b8b8%s|r", spec)
    if (weaponLevel and weaponLevel > 0 and TinyInspectClassicDB and TinyInspectClassicDB.EnableMouseWeaponLevel) then
        ilvlText = ilvlText .. format(" (%s)", weaponLevel)
    end

    if (ilvlLine) then
        ilvlLine:SetText(ilvlText)
        if lineRight and lineRight.SetText then
            lineRight:SetText(specText)
        else
            GameTooltip:AddDoubleLine(ilvlText, specText)
        end
    else
        GameTooltip:AddDoubleLine(ilvlText, specText)
    end

    if GameTooltip:IsShown() then GameTooltip:Show() end
end

TinyInspect_InspectThrottle = TinyInspect_InspectThrottle or {}
TinyInspect_Pending = TinyInspect_Pending or {}

local function StartInspectPolling(guid, unit)
    if not guid or not unit then return end
    TinyInspect_Pending[guid] = TinyInspect_Pending[guid] or {unit = unit, t = GetTime(), attempts = 0}

    local function poll()
        local pending = TinyInspect_Pending[guid]
        if not pending then return end
        pending.attempts = (pending.attempts or 0) + 1
        local data = GetInspectInfo(unit)
        if data and data.ilevel and data.ilevel > 0 then
            AppendToGameTooltip_Safe(guid, floor(data.ilevel), data.spec, data.weaponLevel, data.isArtifact)
            TinyInspect_Pending[guid] = nil
            return
        end
        if pending.attempts < 6 then
            C_Timer.After(0.4, poll)
        else
            TinyInspect_Pending[guid] = nil
        end
    end

    C_Timer.After(0.2, poll)
end

local function DoNotifyInspectIfAllowed(unit, guid)
    if not unit or not guid then return end
    local now = GetTime()
    local last = TinyInspect_InspectThrottle[guid] or 0
    if (now - last) > 2 then
        local ok = pcall(function()
            ClearInspectPlayer()
            NotifyInspect(unit)
        end)
        if ok then
            TinyInspect_InspectThrottle[guid] = now
            TinyInspect_Pending[guid] = {unit = unit, t = now, attempts = 0}
            StartInspectPolling(guid, unit)
        end
    end
end

local function HandleTooltipForUnit(tooltip)
    if not (TinyInspectClassicDB and (TinyInspectClassicDB.EnableMouseItemLevel or TinyInspectClassicDB.EnableMouseSpecialization)) then return end
    local name, unit = tooltip:GetUnit()
    if not unit then return end

    if not UnitIsPlayer(unit) then
        return
    end

    local guid = UnitGUID(unit)
    local hp = UnitHealthMax(unit)
    local data = GetInspectInfo(unit)
    if data and data.hp == hp and data.ilevel and data.ilevel > 0 then
        return AppendToGameTooltip_Safe(guid, floor(data.ilevel), data.spec, data.weaponLevel, data.isArtifact)
    end

    if InCombatLockdown() or not CheckInteractDistance(unit, 1) or not CanInspect(unit) or not UnitIsVisible(unit) then return end

    local inspecting = GetInspecting()
    if inspecting and inspecting.guid ~= guid then
        AppendToGameTooltip_Safe(guid, "...", "", nil, nil)
        return
    end

    DoNotifyInspectIfAllowed(unit, guid)
    AppendToGameTooltip_Safe(guid, "...", "", nil, nil)
end

local function OnInspectReadyWrapper(arg1, ...)
    local guid, data
    if type(arg1) == "table" and arg1.guid then
        data = arg1; guid = arg1.guid
    elseif type(arg1) == "string" then
        guid = arg1
        data = select(1, ...)
    end
    if not guid then return end

    local ilevel, spec, weaponLevel, isArtifact
    if data and data.ilevel then
        ilevel = math.floor(data.ilevel); spec = data.spec; weaponLevel = data.weaponLevel; isArtifact = data.isArtifact
    else
        local pending = TinyInspect_Pending[guid]
        local unit = (pending and pending.unit) or "mouseover"
        local d = GetInspectInfo(unit)
        if d and d.ilevel then
            ilevel = math.floor(d.ilevel); spec = d.spec; weaponLevel = d.weaponLevel; isArtifact = d.isArtifact
        end
    end

    if ilevel or TinyInspect_Pending[guid] or (UnitGUID("mouseover") == guid) then
        if ilevel then
            AppendToGameTooltip_Safe(guid, ilevel, spec, weaponLevel, isArtifact)
            if GameTooltip:IsShown() then GameTooltip:Show() end
        end
        TinyInspect_Pending[guid] = nil
    end
end

local function RegisterTinyInspectHooks()
    if (GameTooltip and GameTooltip.ProcessInfo) then
        hooksecurefunc(GameTooltip, "ProcessInfo", function(self, info)
            if not info or not info.tooltipData then return end
            if info.tooltipData.type ~= 2 then return end
            HandleTooltipForUnit(self)
        end)
    end

    if GameTooltip then
        GameTooltip:HookScript("OnTooltipSetUnit", function(self)
            HandleTooltipForUnit(self)
        end)
    end

    if (LibEvent and LibEvent.attachTrigger) then
        LibEvent:attachTrigger("UNIT_INSPECT_READY", function(_, data)
            OnInspectReadyWrapper(data)
        end)
    end

    do
        local f = CreateFrame("Frame")

        local function tryRegister(evt)
            local ok, err = pcall(f.RegisterEvent, f, evt)
        end

        tryRegister("INSPECT_READY")
        tryRegister("UNIT_INSPECT_READY")

        f:SetScript("OnEvent", function(_, event, ...)
            OnInspectReadyWrapper((...))
        end)
    end

    if GameTooltip then
        GameTooltip:HookScript("OnTooltipCleared", function(self)
            self._tinyinspect_last_guid = nil
        end)
    end
end

local f_reg = CreateFrame("Frame")
f_reg:RegisterEvent("PLAYER_LOGIN")
f_reg:SetScript("OnEvent", function()
    RegisterTinyInspectHooks()
    f_reg:UnregisterEvent("PLAYER_LOGIN")
end)
-- ====== End production patch ======