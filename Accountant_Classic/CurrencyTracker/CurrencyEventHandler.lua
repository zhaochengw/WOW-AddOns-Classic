-- CurrencyEventHandler.lua
-- Monitors WoW events for currency changes
-- Handles event registration and currency change detection

local addonName = ...

-- Bind localization table for display labels/messages (lazy: safe if AceLocale not present)
local L = LibStub and LibStub("AceLocale-3.0", true) and LibStub("AceLocale-3.0"):GetLocale("Accountant_Classic", true) or nil

-- Create the EventHandler module
CurrencyTracker = CurrencyTracker or {}
CurrencyTracker.EventHandler = {}

local EventHandler = CurrencyTracker.EventHandler

-- Module state
local isInitialized = false
local isEnabled = false
local eventFrame = nil
local registeredEvents = {}

-- Currency tracking state
local lastCurrencyAmounts = {}
local updateBatch = {}
local batchTimer = nil
local inCombat = false
local primedCurrencies = {}
local bagDebounceTimer = nil
local didLoginPrime = false

-- Helpers: baseline priming directly via SavedVariables without changing Storage API
-- NOTE: We intentionally operate only on the Total period to avoid skewing time buckets.
local function IsCurrencyTotalEmpty(currencyID)
    if not currencyID then return false end
    if not EnsureSavedVariablesStructure or not GetCurrentServerAndCharacter then return false end
    if not EnsureSavedVariablesStructure() then return false end
    local server, character = GetCurrentServerAndCharacter()
    local sv = _G.Accountant_ClassicSaveData
    if not (sv and sv[server] and sv[server][character]) then return true end
    local charData = sv[server][character]
    charData.currencyData = charData.currencyData or {}
    if not charData.currencyData[currencyID] then return true end
    local total = charData.currencyData[currencyID].Total or {}
    for _, rec in pairs(total) do
        if type(rec) == "table" then
            local i = (rec.In or 0)
            local o = (rec.Out or 0)
            if i > 0 or o > 0 then return false end
        end
    end
    return true
end

local function PrimeBaselineTotalOnly(currencyID, amount)
    if not currencyID or not amount or amount <= 0 then return false end
    if not EnsureSavedVariablesStructure or not GetCurrentServerAndCharacter then return false end
    if not EnsureSavedVariablesStructure() then return false end
    -- Ensure structures via Storage initializer if available
    if CurrencyTracker.Storage and CurrencyTracker.Storage.InitializeCurrencyData then
        CurrencyTracker.Storage:InitializeCurrencyData(currencyID)
    end
    local server, character = GetCurrentServerAndCharacter()
    local sv = _G.Accountant_ClassicSaveData
    if not (sv and sv[server] and sv[server][character]) then return false end
    local charData = sv[server][character]
    charData.currencyData = charData.currencyData or {}
    charData.currencyData[currencyID] = charData.currencyData[currencyID] or {}
    local bucket = charData.currencyData[currencyID]
    bucket.Total = bucket.Total or {}
    -- Use a string key for baseline priming to avoid colliding with Enum 0 (ConvertOldItem)
    bucket.Total["BaselinePrime"] = bucket.Total["BaselinePrime"] or { In = 0, Out = 0 }
    bucket.Total["BaselinePrime"].In = (bucket.Total["BaselinePrime"].In or 0) + amount
    -- Touch lastUpdate if options table exists
    charData.currencyOptions = charData.currencyOptions or {}
    charData.currencyOptions.lastUpdate = time()
    return true
end

-- Core interface implementation
function EventHandler:Initialize()
    if isInitialized then
        return true
    end

    -- Create event frame
    eventFrame = CreateFrame("Frame", "CurrencyTrackerEventFrame")
    eventFrame:SetScript("OnEvent", function(_, event, ...)
        EventHandler:OnEvent(event, ...)
    end)

    isInitialized = true
    return true
end

function EventHandler:Enable()
    if not isInitialized then
        if not self:Initialize() then
            return false
        end
    end

    if isEnabled then
        return true
    end

    -- Register for events
    self:RegisterEvents()

    -- Debug-only confirmation
    if CurrencyTracker and CurrencyTracker.DEBUG_MODE then
        print("[AC CT] EventHandler enabled (events registered)")
    end

    isEnabled = true
    return true
end

function EventHandler:Disable()
    if not isEnabled then
        return true
    end

    -- Unregister events
    self:UnregisterEvents()

    -- Cancel any pending batch updates
    if batchTimer then
        batchTimer:Cancel()
        batchTimer = nil
    end

    isEnabled = false
    return true
end

-- Register for currency-related events
function EventHandler:RegisterEvents()
    if not eventFrame then
        return false
    end

    local events = {
        "ADDON_LOADED",
        "PLAYER_LOGIN",
        "PLAYER_ENTERING_WORLD",
        "PLAYER_LOGOUT",
        "PLAYER_REGEN_DISABLED", -- Entering combat
        "PLAYER_REGEN_ENABLED",  -- Leaving combat
    }

    -- Debug-only marker to verify this function is reached
    if CurrencyTracker and CurrencyTracker.DEBUG_MODE then
        print(string.format("[AC CT] RegisterEvents begin (eventFrame=%s, C_CurrencyInfo=%s)", tostring(eventFrame and eventFrame:GetName() or "nil"), tostring(not not C_CurrencyInfo)))
    end

    -- Register modern currency events if available
    if C_CurrencyInfo then
        table.insert(events, "CURRENCY_DISPLAY_UPDATE")
    end

    -- Register legacy fallback only if modern API is not available
    if not C_CurrencyInfo then
        table.insert(events, "BAG_UPDATE")
    end

    -- Debug summary
    CurrencyTracker:LogDebug("Preparing to register %d events (C_CurrencyInfo=%s)", #events, tostring(not not C_CurrencyInfo))

    for _, event in ipairs(events) do
        eventFrame:RegisterEvent(event)
        registeredEvents[event] = true
        CurrencyTracker:LogDebug("Registered event: %s", event)
        if event == "CURRENCY_DISPLAY_UPDATE" and CurrencyTracker and CurrencyTracker.DEBUG_MODE then
            print("[AC CT] Registered CURRENCY_DISPLAY_UPDATE")
        end
    end

    return true
end

-- Unregister all events
function EventHandler:UnregisterEvents()
    if not eventFrame then
        return
    end

    for event in pairs(registeredEvents) do
        eventFrame:UnregisterEvent(event)
        CurrencyTracker:LogDebug("Unregistered event: %s", event)
    end

    registeredEvents = {}
end

-- Main event handler
function EventHandler:OnEvent(event, ...)
    local arg1, arg2 = ...

    -- Debug-only dispatch confirmation
    if event == "CURRENCY_DISPLAY_UPDATE" and CurrencyTracker and CurrencyTracker.DEBUG_MODE then
        print("[AC CT] OnEvent: CURRENCY_DISPLAY_UPDATE")
    end

    if event == "ADDON_LOADED" and arg1 == addonName then
        self:OnAddonLoaded()
    elseif event == "PLAYER_LOGIN" then
        self:OnPlayerLogin()
    elseif event == "PLAYER_ENTERING_WORLD" then
        self:OnPlayerEnteringWorld(...)
    elseif event == "PLAYER_LOGOUT" then
        self:OnPlayerLogout()
    elseif event == "PLAYER_REGEN_DISABLED" then
        self:OnEnterCombat()
    elseif event == "PLAYER_REGEN_ENABLED" then
        self:OnLeaveCombat()
    elseif event == "CURRENCY_DISPLAY_UPDATE" then
        -- Forward all available args: currencyType, quantity, quantityChange, quantityGainSource, quantityLostSource
        self:OnCurrencyDisplayUpdate(...)
    elseif event == "BAG_UPDATE" then
        self:OnBagUpdate(arg1)
    end
end

-- Handle addon loaded
function EventHandler:OnAddonLoaded()
    CurrencyTracker:LogDebug("Addon loaded, initializing currency tracking")
    -- Initialize currency amounts for tracking changes
    self:InitializeCurrencyAmounts()
end

-- Handle player login
function EventHandler:OnPlayerLogin()
    CurrencyTracker:LogDebug("Player login, starting session tracking")
    -- Start new session tracking
    self:InitializeCurrencyAmounts()
    -- Parity with gold: perform rollover on login
    if CurrencyTracker.Storage and CurrencyTracker.Storage.ShiftCurrencyLogs then
        CurrencyTracker.Storage:ShiftCurrencyLogs()
    end
    -- Reset session guard so login priming can run exactly once per session
    didLoginPrime = false
end

-- Handle entering world (fires after login UI is ready); better timing for live currency reads
function EventHandler:OnPlayerEnteringWorld(isInitialLogin, isReloadingUi)
    -- Run baseline priming only once per session after the UI is fully ready.
    -- PLAYER_ENTERING_WORLD fires on zoning and instances, so guard it strictly.
    if didLoginPrime then
        return
    end
    -- Prefer Blizzard flags when present: only on true initial login and not on UI reloads.
    if isInitialLogin == false then
        return
    end
    if isReloadingUi == true then
        return
    end
    self:PrimeDiscoveredCurrenciesOnLogin()
    didLoginPrime = true
end

-- Prime baseline for all currencies known in the account-wide discovery list at login time.
-- This avoids relying on the first event to backfill baselines for previously discovered ids.
-- Behavior:
-- - For each discovered currency id:
--   - Read live amount (0 if unknown).
--   - If Total is empty and live > 0, write Total["BaselinePrime"].In += live (one-time).
--   - Prime in-memory snapshot and mark as primed to prevent duplicate baseline work.
-- Notes:
-- - We intentionally do NOT write any records into Day/Week/Month/Year.
-- - If live == 0, we simply ensure structures exist; we do not write a zero baseline row.
function EventHandler:PrimeDiscoveredCurrenciesOnLogin()
    if not (CurrencyTracker and CurrencyTracker.Storage and CurrencyTracker.Storage.GetDiscoveredCurrencies) then
        -- Always print a summary even if nothing ran
        local msg = string.format("[AC CT] Login prime summary: checked=%d, primed=%d (>0 live), ensured=%d (0 live)", 0, 0, 0)
        if DEFAULT_CHAT_FRAME and DEFAULT_CHAT_FRAME.AddMessage then
            DEFAULT_CHAT_FRAME:AddMessage(msg, 0.2, 1.0, 0.2)
        else
            print(msg)
        end
        CurrencyTracker:LogDebug(msg)
        return
    end
    local discovered = CurrencyTracker.Storage:GetDiscoveredCurrencies() or {}
    local checked, primed, ensured = 0, 0, 0
    for id, _ in pairs(discovered) do
        local currencyID = tonumber(id)
        if currencyID then
            checked = checked + 1
            local liveAmt = self:GetCurrentCurrencyAmount(currencyID) or 0
            if IsCurrencyTotalEmpty(currencyID) and liveAmt > 0 then
                PrimeBaselineTotalOnly(currencyID, liveAmt)
                primed = primed + 1
                CurrencyTracker:LogDebug("[Login Prime] id=%s baseline=%s (from live)", tostring(currencyID), tostring(liveAmt))
            else
                -- Ensure structures exist for consistency even if live is 0
                if CurrencyTracker.Storage and CurrencyTracker.Storage.InitializeCurrencyData then
                    CurrencyTracker.Storage:InitializeCurrencyData(currencyID)
                end
                ensured = ensured + 1
            end
            -- Prime in-memory snapshot so subsequent diffs are based on live
            lastCurrencyAmounts[currencyID] = liveAmt
            -- IMPORTANT: Only mark as primed when we actually had a positive live and (possibly) wrote baseline.
            -- If live==0, leave it unprimed so the first real event can perform baseline inference correctly.
            if liveAmt > 0 then
                primedCurrencies[currencyID] = true
            end
        end
    end
    -- Always print a concise summary, even if nothing was discovered/primed yet
    local msg = string.format("[AC CT] Login prime summary: checked=%d, primed=%d (>0 live), ensured=%d (0 live)", checked, primed, ensured)
    if DEFAULT_CHAT_FRAME and DEFAULT_CHAT_FRAME.AddMessage then
        DEFAULT_CHAT_FRAME:AddMessage(msg, 0.2, 1.0, 0.2)
    else
        print(msg)
    end
    CurrencyTracker:LogDebug(msg)
end

-- Handle player logout
function EventHandler:OnPlayerLogout()
    CurrencyTracker:LogDebug("Player logout, saving session data")
    -- Process any pending batch updates
    self:ProcessBatchUpdates()
end

-- Handle entering combat
function EventHandler:OnEnterCombat()
    inCombat = true
    CurrencyTracker:LogDebug("Entered combat, deferring currency operations")
end

-- Handle leaving combat
function EventHandler:OnLeaveCombat()
    inCombat = false
    CurrencyTracker:LogDebug("Left combat, resuming currency operations")
    -- Process any deferred updates
    self:ProcessBatchUpdates()
end

-- Handle currency display update (modern clients)
function EventHandler:OnCurrencyDisplayUpdate(currencyType, quantity, quantityChange, quantityGainSource, quantityLostSource, ...)
    -- Some clients include a leading table payload (seen in /etrace as 'CR: table: ...').
    -- Normalize by shifting arguments if the first parameter is a table.
    local raw1, raw2, raw3, raw4, raw5 = currencyType, quantity, quantityChange, quantityGainSource, quantityLostSource
    if type(currencyType) == "table" then
        -- Shift left by one: drop the leading table payload
        currencyType, quantity, quantityChange, quantityGainSource, quantityLostSource =
            quantity, quantityChange, quantityGainSource, quantityLostSource, nil
    end

    -- Early debug: always log event receipt and arguments when debug is ON,
    -- even if the computed change later is zero. This helps verify event flow.
    if CurrencyTracker and CurrencyTracker.DEBUG_MODE then
        print("[AC CT][Event] CURRENCY_DISPLAY_UPDATE received")
        print(string.format("  Args(raw): %s | %s | %s | %s | %s",
            tostring(raw1), tostring(raw2), tostring(raw3), tostring(raw4), tostring(raw5)))
        -- 11.0.2: quantityLostSource renamed to destroyReason. Keep dual-label for clarity in debug.
        local is1102 = CurrencyTracker and CurrencyTracker.Constants and CurrencyTracker.Constants.VersionUtils
            and CurrencyTracker.Constants.VersionUtils.IsVersionSupported
            and CurrencyTracker.Constants.VersionUtils.IsVersionSupported("11.0.2")
        local lossLabel = is1102 and "destroyReason" or "lostSource"
        local norm = string.format("  Args(norm): id=%s new=%s chg=%s gain=%s %s=%s",
            tostring(currencyType), tostring(quantity), tostring(quantityChange), tostring(quantityGainSource), lossLabel, tostring(quantityLostSource))
        print(norm)
    end

    if inCombat then
        -- Defer update during combat
        self:AddToBatch("CURRENCY_UPDATE", currencyType, quantity, quantityChange, quantityGainSource, quantityLostSource)
        return
    end

    self:ProcessCurrencyChange(currencyType, quantity, quantityChange, quantityGainSource, quantityLostSource)
end

-- Handle bag update (fallback for older clients)
function EventHandler:OnBagUpdate(bagID)
    if inCombat then
        -- Defer update during combat
        self:AddToBatch("BAG_UPDATE", bagID)
        return
    end

    -- Debounce legacy bag updates to coalesce bursts
    if bagDebounceTimer then
        bagDebounceTimer:Cancel()
        bagDebounceTimer = nil
    end
    bagDebounceTimer = C_Timer.NewTimer(0.3, function()
        bagDebounceTimer = nil
        -- Check for currency changes in bags
        EventHandler:CheckBagCurrencies()
    end)
end

-- Process currency change
function EventHandler:ProcessCurrencyChange(currencyID, newQuantity, quantityChange, quantityGainSource, quantityLostSource)
    if not currencyID then return end

    -- Normalize id to numeric to avoid mixed key types between discovery/storage/event paths
    local _numId = tonumber(currencyID)
    if _numId then currencyID = _numId end

    -- Parity with gold: ensure rollover before logging changes
    if CurrencyTracker.Storage and CurrencyTracker.Storage.ShiftCurrencyLogs then
        CurrencyTracker.Storage:ShiftCurrencyLogs()
    end

    -- Dynamic discovery: if this currency isn't supported yet, save basic metadata so
    -- downstream DataManager can surface it. Only attempt when Storage is available.
    if CurrencyTracker.DataManager and not CurrencyTracker.DataManager:IsCurrencySupported(currencyID) then
        if CurrencyTracker.Storage and CurrencyTracker.Storage.SaveDiscoveredCurrency then
            CurrencyTracker.Storage:SaveDiscoveredCurrency(currencyID)
            CurrencyTracker:LogDebug("Discovered new currency id=%s; saved basic metadata", tostring(currencyID))
        end
    end

    local old = lastCurrencyAmounts[currencyID] or 0
    local change = quantityChange
    if change == nil then
        change = (newQuantity or 0) - old
    end

    -- Sign-correction guard:
    -- On pre-11.0.2 clients, quantityChange could be absolute (always positive).
    -- Use the authoritative direction from (new - old) when both are available and magnitudes match but sign differs.
    if quantityChange ~= nil and newQuantity ~= nil then
        local diff = (newQuantity or 0) - old
        if diff ~= 0 and math.abs(diff) == math.abs(change) then
            local changePos = change > 0
            local diffPos = diff > 0
            if changePos ~= diffPos then
                change = diff
            end
        end
    end

    -- Safety baseline guard: if Total is empty and we have a concrete change, write inferred baseline
    -- regardless of in-memory primed flag. This handles ordering where an early event may arrive
    -- before login priming, and ensures Total gets its one-time baseline when appropriate.
    if quantityChange ~= nil and IsCurrencyTotalEmpty and IsCurrencyTotalEmpty(currencyID) then
        local effNew = newQuantity
        if effNew == nil then
            effNew = self:GetCurrentCurrencyAmount(currencyID)
        end
        local inferred = (effNew or 0) - (quantityChange or 0)
        if inferred and inferred > 0 then
            PrimeBaselineTotalOnly(currencyID, inferred)
            CurrencyTracker:LogDebug("Baseline guard applied at event: id=%s inferred=%s (new=%s chg=%s)", tostring(currencyID), tostring(inferred), tostring(effNew), tostring(quantityChange))
        end
    end

    -- Enhanced baseline priming on first sighting
    if not primedCurrencies[currencyID] then
        if quantityChange == nil then
            -- No explicit change provided: prime baseline using live amount as a one-time Total-only baseline,
            -- then prime in-memory and skip logging (we cannot determine a delta safely here).
            local liveAmt = newQuantity
            if liveAmt == nil then
                liveAmt = self:GetCurrentCurrencyAmount(currencyID)
            end
            if (liveAmt or 0) > 0 and IsCurrencyTotalEmpty(currencyID) then
                if PrimeBaselineTotalOnly(currencyID, liveAmt) then
                    CurrencyTracker:LogDebug("Primed Total baseline at first sight (no change arg) for id=%s amount=%s", tostring(currencyID), tostring(liveAmt))
                end
            end
            -- Ensure dynamic discovery so future logins include this currency in startup priming
            if CurrencyTracker.Storage and CurrencyTracker.Storage.SaveDiscoveredCurrency then
                CurrencyTracker.Storage:SaveDiscoveredCurrency(currencyID)
            end
            lastCurrencyAmounts[currencyID] = liveAmt or 0
            primedCurrencies[currencyID] = true
            CurrencyTracker:LogDebug("Primed currency %s at %s (no transaction recorded)", tostring(currencyID), tostring(lastCurrencyAmounts[currencyID]))
            return
        else
            -- Modern path: first event comes with a change value.
            -- Baseline (if needed) is already handled by the event-time safety guard above.
            -- Ensure dynamic discovery so future logins include this currency in startup priming
            if CurrencyTracker.Storage and CurrencyTracker.Storage.SaveDiscoveredCurrency then
                CurrencyTracker.Storage:SaveDiscoveredCurrency(currencyID)
            end
            -- Update in-memory snapshot so subsequent diffs are correct; proceed to log this delta below
            local effectiveNew = (newQuantity ~= nil) and newQuantity or self:GetCurrentCurrencyAmount(currencyID)
            lastCurrencyAmounts[currencyID] = effectiveNew or 0
            primedCurrencies[currencyID] = true
        end
    end

    if change ~= 0 then
        -- Determine numeric source key (unified):
        -- Modern clients often populate quantityGainSource for BOTH gains and losses.
        -- Prefer quantityGainSource; fall back to quantityLostSource (destroyReason) only if needed.
        -- Do not encode sign in the source key; the delta sign already determines In/Out.
        local sourceKey
        do
            local src = tonumber(quantityGainSource) or tonumber(quantityLostSource)
            if src then
                sourceKey = src
            else
                sourceKey = "Unknown" -- Unknown
            end
        end

        -- Record raw event metadata (both gain and lost/destroy sources) for analysis
        if CurrencyTracker.Storage and CurrencyTracker.Storage.RecordEventMetadata then
            local sign = (change > 0) and 1 or -1
            CurrencyTracker.Storage:RecordEventMetadata(currencyID, quantityGainSource, quantityLostSource, sign)
        end

        -- Track the change using DataManager
        if CurrencyTracker.DataManager then
            CurrencyTracker.DataManager:TrackCurrencyChange(currencyID, change, sourceKey)
        end

        -- Structured debug output (when enabled)
        if CurrencyTracker and CurrencyTracker.DEBUG_MODE then
            local incomeAdd = change > 0 and change or 0
            local outgoingAdd = change < 0 and -change or 0
            local rawNew = (newQuantity ~= nil) and tostring(newQuantity) or "nil"
            local rawChg = (quantityChange ~= nil) and tostring(quantityChange) or "nil"
            local rawGain = (quantityGainSource ~= nil) and tostring(quantityGainSource) or "nil"
            local rawLost = (quantityLostSource ~= nil) and tostring(quantityLostSource) or "nil"

            local is1102 = CurrencyTracker and CurrencyTracker.Constants and CurrencyTracker.Constants.VersionUtils
                and CurrencyTracker.Constants.VersionUtils.IsVersionSupported
                and CurrencyTracker.Constants.VersionUtils.IsVersionSupported("11.0.2")
            local lossLabel = is1102 and "destroyReason" or "lostSrc"

            print("[AC CT][Event]")
            print(string.format("  Raw: id=%s new=%s chg=%s gainSrc=%s %s=%s",
                tostring(currencyID), rawNew, rawChg, rawGain, lossLabel, rawLost))
            print(string.format("  Calc: old=%s delta=%s srcKey=%s",
                tostring(old), tostring(change), tostring(sourceKey)))
            print(string.format("  Save: path=currencyData[%s][Session|Day|Week|Month|Year|Total][%s] In+=%d Out+=%d",
                tostring(currencyID), tostring(sourceKey), incomeAdd, outgoingAdd))
        end

        -- Update stored amount
        if newQuantity ~= nil then
            lastCurrencyAmounts[currencyID] = newQuantity
        else
            lastCurrencyAmounts[currencyID] = old + change
        end

        -- Mark as primed after first processed change
        primedCurrencies[currencyID] = true
        
        do
            local is1102 = CurrencyTracker and CurrencyTracker.Constants and CurrencyTracker.Constants.VersionUtils
                and CurrencyTracker.Constants.VersionUtils.IsVersionSupported
                and CurrencyTracker.Constants.VersionUtils.IsVersionSupported("11.0.2")
            local lossLabel = is1102 and "destroyReason" or "lostSrc"
            CurrencyTracker:LogDebug("CURRENCY_DISPLAY_UPDATE id=%d new=%s chg=%s gainSrc=%s %s=%s srcKey=%s",
                currencyID, tostring(newQuantity), tostring(change), tostring(quantityGainSource), lossLabel, tostring(quantityLostSource), tostring(sourceKey))
        end

        -- Near-cap warning on gains: threshold and durations configurable per character
        if change > 0 and C_CurrencyInfo and C_CurrencyInfo.GetCurrencyInfo then
            local ok, ci = pcall(C_CurrencyInfo.GetCurrencyInfo, currencyID)
            if ok and type(ci) == "table" then
                local cap = (ci.maxQuantity ~= nil and ci.maxQuantity) or ci.totalMax
                if cap and cap > 0 then
                    -- Load per-character settings (defaults: enable=true, cap_percent=0.90, time=3.0, fade=0.8)
                    local enable, threshold, tVisible, tFade = true, 0.90, 3.0, 0.8
                    if EnsureSavedVariablesStructure and GetCurrentServerAndCharacter and EnsureSavedVariablesStructure() then
                        local server, character = GetCurrentServerAndCharacter()
                        local sv = _G.Accountant_ClassicSaveData
                        if sv and sv[server] and sv[server][character] then
                            local co = sv[server][character].currencyOptions
                            if co and co.nearCapAlert then
                                local o = co.nearCapAlert
                                if type(o.enable) == "boolean" then enable = o.enable end
                                if tonumber(o.cap_percent) then threshold = tonumber(o.cap_percent) end
                                if tonumber(o.time_visible_sec) then tVisible = tonumber(o.time_visible_sec) end
                                if tonumber(o.fade_duration_sec) then tFade = tonumber(o.fade_duration_sec) end
                            end
                        end
                    end

                    if enable then
                        local afterAmt = (newQuantity ~= nil) and newQuantity or (old + change)
                        local ratio = afterAmt / cap
                        if ratio >= threshold then
                            local name = ci.name or ("Currency " .. tostring(currencyID))
                            -- Localize name via AceLocale if available
                            if L and L[name] then name = L[name] end
                            -- Localized warning template (fallback to English)
                            local tmpl = (L and L["CT_WarnNearCap"]) or "Warning: %s has reached or exceeded 90%% of total cap (%d)"
                            local msg = string.format(tmpl, tostring(name), cap)
                            if UIErrorsFrame and UIErrorsFrame.AddMessage then
                                -- Apply configured timings
                                if UIErrorsFrame.SetTimeVisible then UIErrorsFrame:SetTimeVisible(tVisible or 3.0) end
                                if UIErrorsFrame.SetFadeDuration then UIErrorsFrame:SetFadeDuration(tFade or 0.8) end
                                UIErrorsFrame:AddMessage(msg, 1.0, 0.2, 0.2, 1.0)
                            else
                                -- Fallback: red colored chat message
                                print("|cffff2020" .. msg .. "|r")
                            end
                        end
                    end
                end
            end
        end
    end
end

-- Initialize currency amounts for change tracking
function EventHandler:InitializeCurrencyAmounts()
    lastCurrencyAmounts = {}
    primedCurrencies = {}

    -- Get supported currencies and initialize their amounts
    if CurrencyTracker.DataManager then
        local supported = CurrencyTracker.DataManager:GetSupportedCurrencies()

        for currencyID in pairs(supported) do
            local currentAmount = self:GetCurrentCurrencyAmount(currencyID)
            -- Snapshot only; baseline priming is handled in OnPlayerEnteringWorld and event-time guard.
            lastCurrencyAmounts[currencyID] = currentAmount or 0
            -- Do NOT mark primed here; we want first event to be eligible for inference when live==0,
            -- and OnPlayerEnteringWorld() will mark as primed when live>0.
        end
    end
end

-- Get current amount of a currency
function EventHandler:GetCurrentCurrencyAmount(currencyID)
    -- Try modern API first
    if C_CurrencyInfo and C_CurrencyInfo.GetCurrencyInfo then
        local info = C_CurrencyInfo.GetCurrencyInfo(currencyID)
        if info then
            return info.quantity or 0
        end
    end

    -- Try legacy API (may not exist in all client versions)
    local success, name, amount = pcall(function()
        if _G.GetCurrencyInfo then
            return _G.GetCurrencyInfo(currencyID)
        end
        return nil, 0
    end)

    if success and name then
        return amount or 0
    end

    return 0
end

-- Check currencies in bags (fallback method)
function EventHandler:CheckBagCurrencies()
    -- This is a fallback method for older clients
    -- Check if any tracked currencies have changed
    if CurrencyTracker.DataManager then
        local supported = CurrencyTracker.DataManager:GetSupportedCurrencies()

        for currencyID in pairs(supported) do
            local currentAmount = self:GetCurrentCurrencyAmount(currencyID)
            local lastAmount = lastCurrencyAmounts[currencyID]

            if lastAmount == nil then
                -- First sighting after login: prime only
                lastCurrencyAmounts[currencyID] = currentAmount or 0
                primedCurrencies[currencyID] = true
            elseif currentAmount ~= lastAmount then
                self:ProcessCurrencyChange(currencyID, currentAmount, nil, nil, nil)
            end
        end
    end
end

-- Identify the source of currency change
function EventHandler:IdentifySource()
    -- Basic source identification
    -- This can be enhanced with more sophisticated detection

    if inCombat then
        return "Combat"
    end

    -- Check for common UI frames that might indicate source
    if QuestFrame and QuestFrame:IsShown() then
        return "Quest"
    end

    if MerchantFrame and MerchantFrame:IsShown() then
        return "Vendor"
    end

    if TradeFrame and TradeFrame:IsShown() then
        return "Trade"
    end

    if MailFrame and MailFrame:IsShown() then
        return "Mail"
    end

    return "Unknown"
end

-- Add update to batch for processing later
function EventHandler:AddToBatch(updateType, ...)
    table.insert(updateBatch, {
        type = updateType,
        args = {...},
        timestamp = time()
    })

    -- Schedule batch processing if not already scheduled
    if not batchTimer then
        batchTimer = C_Timer.NewTimer(1.0, function()
            EventHandler:ProcessBatchUpdates()
        end)
    end
end

-- Process batched updates
function EventHandler:ProcessBatchUpdates()
    if #updateBatch == 0 then
        return
    end

    CurrencyTracker:LogDebug("Processing %d batched updates", #updateBatch)

    for _, update in ipairs(updateBatch) do
        if update.type == "CURRENCY_UPDATE" then
            -- args: currencyType, quantity, quantityChange, quantityGainSource, quantityLostSource
            self:ProcessCurrencyChange(update.args[1], update.args[2], update.args[3], update.args[4], update.args[5])
        elseif update.type == "BAG_UPDATE" then
            self:CheckBagCurrencies()
        end
    end

    -- Clear batch
    updateBatch = {}
    batchTimer = nil
end
