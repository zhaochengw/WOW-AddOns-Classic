-- CurrencyStorage.lua
-- Manages persistent storage of currency data with backward compatibility
-- Ensures existing SavedVariables structure remains unchanged

-- Create the Storage module
CurrencyTracker = CurrencyTracker or {}
CurrencyTracker.Storage = {}

local Storage = CurrencyTracker.Storage

-- Safe logging helpers (avoid errors if logger isn't initialized yet)
local function SafeLogError(fmt, ...)
    if CurrencyTracker and CurrencyTracker.LogError then
        CurrencyTracker:LogError(fmt, ...)
    else
        local ok, msg = pcall(string.format, tostring(fmt or ""), ...)
        msg = ok and msg or tostring(fmt)
        if DEFAULT_CHAT_FRAME and DEFAULT_CHAT_FRAME.AddMessage then
            DEFAULT_CHAT_FRAME:AddMessage("[Accountant_Classic][Error] " .. msg, 1, 0, 0)
        else
            print("[Accountant_Classic][Error] " .. msg)
        end
    end

    -- Normalize discovery keys: move string numeric keys (e.g., "3008") to numeric keys (3008)
    do
        local moved = 0
        local toMove = {}
        for k, v in pairs(globalDiscovery) do
            if type(k) == "string" then
                local num = tonumber(k)
                if num then
                    -- If numeric slot not present, schedule move; otherwise shallow-merge later
                    table.insert(toMove, { from = k, to = num, val = v })
                end
            end
        end
        for _, m in ipairs(toMove) do
            if globalDiscovery[m.to] == nil then
                globalDiscovery[m.to] = {}
            end
            local tgt = globalDiscovery[m.to]
            for kk, vv in pairs(m.val) do
                if tgt[kk] == nil then
                    tgt[kk] = vv
                end
            end
            if globalDiscovery[m.from] ~= nil then
                globalDiscovery[m.from] = nil
                moved = moved + 1
            end
        end
        if moved > 0 then
            SafeLogDebug("Normalized %d discovery keys from string to numeric", moved)
        end
    end
end

-- Define SafeLogDebug early so calls before logger init don't error
local function SafeLogDebug(fmt, ...)
    if CurrencyTracker and CurrencyTracker.LogDebug then
        CurrencyTracker:LogDebug(fmt, ...)
    else
        -- Be quiet in production; uncomment for early init debugging
        -- local ok, msg = pcall(string.format, tostring(fmt or ""), ...)
        -- print("[Accountant_Classic][Debug] " .. (ok and msg or tostring(fmt)))
    end
end

-- Migrate numeric source key 0 to string key "BaselinePrime" across all timeframes.
-- This is a cosmetic repair to avoid showing "ConvertOldItem" for unknown/baseline rows.
-- Returns a summary table: { currencies = n, periods = n, entries = n, inMoved = x, outMoved = y }
function Storage:MigrateZeroSourceToBaselinePrime()
    -- Ensure SavedVariables exists and basic structure is present
    if not EnsureSavedVariablesStructure() then
        return { currencies = 0, periods = 0, entries = 0, inMoved = 0, outMoved = 0 }
    end

    local server, character = GetCurrentServerAndCharacter()
    local sv = _G.Accountant_ClassicSaveData
    local charData = sv[server][character]
    charData.currencyData = charData.currencyData or {}

    local summary = { currencies = 0, periods = 0, entries = 0, inMoved = 0, outMoved = 0 }

    -- Consider all known periods, including previous buckets used by shifting logic
    local PERIODS = {
        "Session", "Day", "Week", "Month", "Year", "Total",
        "PrvDay", "PrvWeek", "PrvMonth", "PrvYear",
    }

    for currencyID, periods in pairs(charData.currencyData) do
        local currencyTouched = false
        for _, period in ipairs(PERIODS) do
            local bucket = periods[period]
            if type(bucket) == "table" and bucket[0] then
                local rec = bucket[0]
                local movedIn = (rec.In or 0)
                local movedOut = (rec.Out or 0)
                if (movedIn > 0) or (movedOut > 0) then
                    bucket["BaselinePrime"] = bucket["BaselinePrime"] or { In = 0, Out = 0 }
                    bucket["BaselinePrime"].In = (bucket["BaselinePrime"].In or 0) + movedIn
                    bucket["BaselinePrime"].Out = (bucket["BaselinePrime"].Out or 0) + movedOut
                    summary.inMoved = summary.inMoved + movedIn
                    summary.outMoved = summary.outMoved + movedOut
                    summary.entries = summary.entries + 1
                    currencyTouched = true
                else
                    -- Zero entry: just drop it
                end
                -- Remove the numeric key regardless once merged
                bucket[0] = nil
                summary.periods = summary.periods + 1
            end
        end
        if currencyTouched then
            summary.currencies = summary.currencies + 1
        end
    end

    -- Touch lastUpdate to mark maintenance
    charData.currencyOptions = charData.currencyOptions or {}
    charData.currencyOptions.lastUpdate = time()

    SafeLogDebug("MigrateZeroSourceToBaselinePrime completed: currencies=%d periods=%d entries=%d inMoved=%d outMoved=%d",
        summary.currencies, summary.periods, summary.entries, summary.inMoved, summary.outMoved)

    return summary
end



-- Remove previously recorded income/outgoing across aggregates for a currency and source.
-- kind: "income" or "outgoing" (case-insensitive). Amount must be positive.
-- Clamps at 0 without going negative. Adjusts periods: Session, Day, Week, Month, Year, Total.
function Storage:RepairRemove(currencyID, amount, sourceKey, kind)
    if not currencyID or not amount or amount <= 0 then
        return false
    end
    local k = string.lower(kind or "")
    if k ~= "income" and k ~= "outgoing" then
        return false
    end

    if not EnsureSavedVariablesStructure() then
        return false
    end

    -- Ensure structures exist
    self:InitializeCurrencyData(currencyID)

    local server, character = GetCurrentServerAndCharacter()
    local currencyData = Accountant_ClassicSaveData[server][character].currencyData[currencyID]

    local periods = { "Session", "Day", "Week", "Month", "Year", "Total" }
    local source = sourceKey
    if source == nil then source = "Unknown" end

    -- Resolve string source keys in a tolerant way: case-insensitive and localized aliases
    if type(source) == "string" then
        local function findExistingKey(target)
            for _, period in ipairs(periods) do
                local bucket = currencyData[period]
                if type(bucket) == "table" then
                    for key in pairs(bucket) do
                        if type(key) == "string" and string.lower(key) == target then
                            return key
                        end
                    end
                end
            end
            return nil
        end
        local want = string.lower(tostring(source))
        local resolved = findExistingKey(want)
        if not resolved then
            -- Common canonical aliases
            if want == "unknown" or want == string.lower("未知") then
                resolved = findExistingKey("unknown") or "Unknown"
            elseif want == "baselineprime" or want == string.lower("基线补写（初始余额）") then
                resolved = findExistingKey("baselineprime") or "BaselinePrime"
            end
        end
        source = resolved or source
    end

    local removedTotal = 0
    for _, period in ipairs(periods) do
        currencyData[period] = currencyData[period] or {}
        currencyData[period][source] = currencyData[period][source] or { In = 0, Out = 0 }

        local rec = currencyData[period][source]
        if k == "income" then
            local before = rec.In or 0
            local toRemove = math.min(before, amount)
            rec.In = before - toRemove
            removedTotal = removedTotal + toRemove
        else -- outgoing
            local before = rec.Out or 0
            local toRemove = math.min(before, amount)
            rec.Out = before - toRemove
            removedTotal = removedTotal + toRemove
        end
        -- Do not cascade over-removal to later periods; this is an explicit per-call removal.
    end

    Accountant_ClassicSaveData[server][character].currencyOptions.lastUpdate = time()
    SafeLogDebug("RepairRemove applied: ID=%d, kind=%s, amount=%d, source=%s, removed_sum=%d",
        currencyID, k, amount, tostring(source), removedTotal)
    return removedTotal > 0
end

-- Clear the Session period for all currencies (called on login/initialize)
function Storage:ResetSession()
    -- Avoid relying on helper functions during very early init.
    local server = _G.AC_SERVER or GetRealmName()
    local character = _G.AC_PLAYER or UnitName("player")
    if not (server and character) then return false end
    if not _G.Accountant_ClassicSaveData then return true end
    if not _G.Accountant_ClassicSaveData[server] then return true end
    if not _G.Accountant_ClassicSaveData[server][character] then return true end

    local charData = _G.Accountant_ClassicSaveData[server][character]
    if not charData.currencyData then return true end
    for _, periods in pairs(charData.currencyData) do
        if type(periods) == "table" then
            periods.Session = {}
        end
    end
    SafeLogDebug("Session buckets reset for %s-%s", tostring(server), tostring(character))
    return true
end

-- Apply a signed adjustment across aggregates for a currency and source.
-- Positive delta increases Income; negative delta increases Outgoing by abs(delta).
-- Adjusts only these periods: Session, Day, Week, Month, Year, Total.
function Storage:AdjustCurrencyAggregates(currencyID, delta, sourceKey)
    if not currencyID or not delta or delta == 0 then
        return false
    end
    if not EnsureSavedVariablesStructure() then
        return false
    end

    -- Initialize structures if missing
    self:InitializeCurrencyData(currencyID)

    local server, character = GetCurrentServerAndCharacter()
    local currencyData = Accountant_ClassicSaveData[server][character].currencyData[currencyID]

    local periods = { "Session", "Day", "Week", "Month", "Year", "Total" }
    local source = sourceKey
    if source == nil then source = "Unknown" end

    for _, period in ipairs(periods) do
        currencyData[period] = currencyData[period] or {}
        currencyData[period][source] = currencyData[period][source] or { In = 0, Out = 0 }

        if delta > 0 then
            currencyData[period][source].In = (currencyData[period][source].In or 0) + delta
        else
            local amount = -delta
            currencyData[period][source].Out = (currencyData[period][source].Out or 0) + amount
        end
    end

    -- Update last update timestamp
    Accountant_ClassicSaveData[server][character].currencyOptions.lastUpdate = time()

    SafeLogDebug("Adjusted aggregates: ID=%d, delta=%d, source=%s", currencyID, delta, tostring(source))
    return true
end

-- Perform rollover of Day/Week/Month/Year into Prv* for currency data
-- Week-start parity with gold: use per-character options.weekstart and compute a WeekStart string like addon:WeekStart()
function Storage:ShiftCurrencyLogs()
    if not EnsureSavedVariablesStructure() then
        return false
    end

    local server, character = GetCurrentServerAndCharacter()
    local charData = Accountant_ClassicSaveData[server][character]
    if not charData then return false end

    charData.currencyOptions = charData.currencyOptions or {}
    local opts = charData.currencyOptions
    local currencies = charData.currencyData
    if not currencies then return true end

    local now = time()
    local cdate = date("%d/%m/%y", now)
    local cmonth = date("%m", now)
    local cyear = date("%Y", now)

    -- Compute week start string respecting user's weekstart setting (1=Sunday, per WoW wday semantics)
    local function ComputeWeekStartString(weekstart)
        local oneday = 86400
        local ct = now
        local dt = date("*t", ct)
        local thisDay = dt.wday
        weekstart = tonumber(weekstart) or 1
        while thisDay ~= weekstart do
            ct = ct - oneday
            dt = date("*t", ct)
            thisDay = dt.wday
        end
        -- Format mm/dd/yy then trim to 8 chars (parity with gold)
        local wdate = date("%m/%d/%y", ct)
        return string.sub(wdate, 1, 8)
    end

    local weekstartSetting = (Accountant_ClassicSaveData[server][character]
        and Accountant_ClassicSaveData[server][character].options
        and Accountant_ClassicSaveData[server][character].options.weekstart) or 1
    local cweek = ComputeWeekStartString(weekstartSetting)

    -- Initialize on first run to avoid unintended shifts
    if not opts.date or not opts.dateweek or not opts.month or not opts.curryear then
        opts.date = cdate
        opts.dateweek = cweek
        opts.month = cmonth
        opts.curryear = cyear
        opts.lastUpdate = now
        return true
    end

    local dayChanged = (opts.date ~= cdate)
    local weekChanged = (opts.dateweek ~= cweek)
    local monthChanged = (opts.month ~= cmonth)
    local yearChanged = (opts.curryear ~= cyear)

    if not (dayChanged or weekChanged or monthChanged or yearChanged) then
        return true
    end

    local function shallowCopy(tbl)
        local out = {}
        for k, v in pairs(tbl or {}) do out[k] = v end
        return out
    end

    for _, periods in pairs(currencies) do
        if type(periods) == "table" then
            periods.Session = periods.Session or {}
            periods.Day = periods.Day or {}
            periods.PrvDay = periods.PrvDay or {}
            periods.Week = periods.Week or {}
            periods.PrvWeek = periods.PrvWeek or {}
            periods.Month = periods.Month or {}
            periods.PrvMonth = periods.PrvMonth or {}
            periods.Year = periods.Year or {}
            periods.PrvYear = periods.PrvYear or {}
            periods.Total = periods.Total or {}

            if dayChanged then
                periods.PrvDay = shallowCopy(periods.Day)
                periods.Day = {}
            end
            if weekChanged then
                periods.PrvWeek = shallowCopy(periods.Week)
                periods.Week = {}
            end
            if monthChanged then
                periods.PrvMonth = shallowCopy(periods.Month)
                periods.Month = {}
            end
            if yearChanged then
                periods.PrvYear = shallowCopy(periods.Year)
                periods.Year = {}
            end
        end
    end

    -- Update tracking fields to current
    opts.date = cdate
    opts.dateweek = cweek
    opts.month = cmonth
    opts.curryear = cyear
    opts.lastUpdate = now
    return true
end

-- Module state
local isInitialized = false

-- Constants for data structure
local CURRENCY_VERSION = "3.00.00"
local DEFAULT_CURRENCY = 1166 -- Timewarped Badge

-- Time period constants (matching existing addon structure)
local TIME_PERIODS = {
    "Session", "Day", "Week", "Month", "Year", "Total", "PrvDay", "PrvWeek"
}

-- Helper function to get current server and character
function GetCurrentServerAndCharacter()
    -- These globals are set by the main addon
    local server = AC_SERVER or GetRealmName()
    local character = AC_PLAYER or UnitName("player")
    return server, character
end

-- Helper function to ensure SavedVariables structure exists
function EnsureSavedVariablesStructure()
    if not Accountant_ClassicSaveData then
        SafeLogError("Accountant_ClassicSaveData not available")
        return false
    end
    
    local server, character = GetCurrentServerAndCharacter()
    if not server or not character then
        SafeLogError("Server or character not available")
        return false
    end
    
    -- Ensure server structure exists
    if not Accountant_ClassicSaveData[server] then
        Accountant_ClassicSaveData[server] = {}
    end
    
    -- Ensure character structure exists
    if not Accountant_ClassicSaveData[server][character] then
        Accountant_ClassicSaveData[server][character] = {
            options = {},
            data = {}
        }
    end
    
    return true
end

-- Core interface implementation
function Storage:Initialize()
    if isInitialized then
        return true
    end
    
    -- Ensure SavedVariables structure exists
    if not EnsureSavedVariablesStructure() then
        return false
    end
    
    -- Initialize currency storage structures
    local success = self:InitializeCurrencyStorage()
    if success then
        -- Validate existing data
        self:ValidateData()
        -- One-time rollover check per session (parity with gold shifting logic)
        self:ShiftCurrencyLogs()
        -- Reset current session buckets so a new login starts clean
        self:ResetSession()
        isInitialized = true
    end
    
    return success
end

-- Initialize currency storage in SavedVariables (additive approach)
function Storage:InitializeCurrencyStorage()
    if not EnsureSavedVariablesStructure() then
        return false
    end
    
    local server, character = GetCurrentServerAndCharacter()
    local charData = Accountant_ClassicSaveData[server][character]
    
    -- Add currencyData field if it doesn't exist (preserves existing data)
    if not charData.currencyData then
        charData.currencyData = {}
        SafeLogDebug("Initialized currencyData structure for %s-%s", server, character)
    end
    
    -- Add currencyOptions field if it doesn't exist
    if not charData.currencyOptions then
        charData.currencyOptions = {
            selectedCurrency = DEFAULT_CURRENCY,
            trackingEnabled = true,
            lastUpdate = time(),
            version = CURRENCY_VERSION
        }
        SafeLogDebug("Initialized currencyOptions for %s-%s", server, character)
    end

    -- Ensure account-wide global discovery structure exists (renamed to Accountant_Classic_CurrencyDB)
    _G.Accountant_Classic_CurrencyDB = _G.Accountant_Classic_CurrencyDB or {}
    _G.Accountant_Classic_CurrencyDB.currencyDiscovery = _G.Accountant_Classic_CurrencyDB.currencyDiscovery or {}
    local globalDiscovery = _G.Accountant_Classic_CurrencyDB.currencyDiscovery


    -- Backward-compat migration: per-character discovery -> global (one-time per character)
    if charData.currencyDiscovery and type(charData.currencyDiscovery) == "table" and not charData._currencyDiscoveryMigrated then
        local migrated = 0
        for id, meta in pairs(charData.currencyDiscovery) do
            if id ~= nil then
                globalDiscovery[id] = globalDiscovery[id] or {}
                -- Shallow merge to preserve any existing global flags
                local g = globalDiscovery[id]
                g.id = g.id or meta.id or id
                g.name = g.name or meta.name
                g.icon = g.icon or meta.icon
                g.expansion = g.expansion or meta.expansion
                g.expansionName = g.expansionName or meta.expansionName
                g.patch = g.patch or meta.patch
                g.category = g.category or meta.category
                if g.tracked == nil and meta.tracked ~= nil then
                    g.tracked = meta.tracked
                end
                migrated = migrated + 1
            end
        end
        -- Mark this character as migrated to avoid repeated merges
        charData._currencyDiscoveryMigrated = true
        if migrated > 0 then
            SafeLogDebug("Migrated %d discovered currencies from %s-%s to global", migrated, server, character)
            local msg = string.format("[AC CT] Migrated %d discovered currencies from %s-%s to shared database (Accountant_Classic_CurrencyDB).", migrated, tostring(server), tostring(character))
            if DEFAULT_CHAT_FRAME and DEFAULT_CHAT_FRAME.AddMessage then
                DEFAULT_CHAT_FRAME:AddMessage(msg, 0.2, 1.0, 0.2)
            else
                print(msg)
            end
            -- Safety: remove legacy per-character table after successful migration
            local removed = 0
            if type(charData.currencyDiscovery) == "table" then
                for k in pairs(charData.currencyDiscovery) do
                    charData.currencyDiscovery[k] = nil
                    removed = removed + 1
                end
                charData.currencyDiscovery = nil
            end
            local delMsg = string.format("[AC CT] Cleaned legacy per-character discovery table for %s-%s (removed %d entries).", tostring(server), tostring(character), removed)
            if DEFAULT_CHAT_FRAME and DEFAULT_CHAT_FRAME.AddMessage then
                DEFAULT_CHAT_FRAME:AddMessage(delMsg, 0.2, 1.0, 0.2)
            else
                print(delMsg)
            end
        end
    end
    
    -- Add currencyMeta table to capture raw event metadata (gain/lost sources)
    if not charData.currencyMeta then
        charData.currencyMeta = {}
        SafeLogDebug("Initialized currencyMeta for %s-%s", server, character)
    end
    
    -- Ensure version is up to date
    if not charData.currencyOptions.version or charData.currencyOptions.version ~= CURRENCY_VERSION then
        local oldVersion = charData.currencyOptions.version
        charData.currencyOptions.version = CURRENCY_VERSION
        
        -- Perform migration if needed
        if oldVersion then
            self:MigrateData(oldVersion, CURRENCY_VERSION)
        end
    end
    
    return true
end

-- Initialize currency data structure for a specific currency
function Storage:InitializeCurrencyData(currencyID)
    if not currencyID then
        return false
    end
    
    if not EnsureSavedVariablesStructure() then
        return false
    end
    
    local server, character = GetCurrentServerAndCharacter()
    local currencyData = Accountant_ClassicSaveData[server][character].currencyData
    
    if not currencyData[currencyID] then
        currencyData[currencyID] = {}
        
        -- Initialize all time periods with empty data structure
        for _, period in ipairs(TIME_PERIODS) do
            currencyData[currencyID][period] = {}
        end
        
        SafeLogDebug("Initialized data structure for currency %d", currencyID)
    end
    
    return true
end

-- Record a currency transaction
function Storage:RecordCurrencyTransaction(currencyID, amount, isIncome, source, zone)
    if not currencyID or not amount or amount <= 0 then
        return false
    end
    
    if not EnsureSavedVariablesStructure() then
        return false
    end
    
    -- Initialize currency data if needed
    self:InitializeCurrencyData(currencyID)
    
    local server, character = GetCurrentServerAndCharacter()
    local currencyData = Accountant_ClassicSaveData[server][character].currencyData[currencyID]
    
    source = source or "Unknown"
    
    -- Update all relevant time periods
    local periodsToUpdate = {"Session", "Day", "Week", "Month", "Year", "Total"}
    
    for _, period in ipairs(periodsToUpdate) do
        if not currencyData[period][source] then
            currencyData[period][source] = { In = 0, Out = 0 }
        end
        
        if isIncome then
            currencyData[period][source].In = currencyData[period][source].In + amount
        else
            currencyData[period][source].Out = currencyData[period][source].Out + amount
        end
    end
    
    -- Update last update timestamp
    Accountant_ClassicSaveData[server][character].currencyOptions.lastUpdate = time()
    
    SafeLogDebug("Recorded currency transaction: ID=%d, Amount=%d, Income=%s, Source=%s", 
        currencyID, amount, tostring(isIncome), source)
    
    return true
end

-- Get currency data for a specific timeframe
function Storage:GetCurrencyData(currencyID, timeframe)
    if not currencyID then
        return nil
    end
    
    timeframe = timeframe or "Session"
    
    if not EnsureSavedVariablesStructure() then
        return nil
    end
    
    local server, character = GetCurrentServerAndCharacter()
    local charData = Accountant_ClassicSaveData[server][character]
    
    if not charData.currencyData or not charData.currencyData[currencyID] then
        return {
            income = 0,
            outgoing = 0,
            net = 0,
            transactions = {}
        }
    end
    
    local currencyData = charData.currencyData[currencyID][timeframe] or {}
    local totalIncome = 0
    local totalOutgoing = 0
    local transactions = {}
    
    -- Calculate totals and build transaction list
    for source, data in pairs(currencyData) do
        if type(data) == "table" and data.In and data.Out then
            totalIncome = totalIncome + (data.In or 0)
            totalOutgoing = totalOutgoing + (data.Out or 0)
            
            if data.In > 0 or data.Out > 0 then
                table.insert(transactions, {
                    source = source,
                    income = data.In or 0,
                    outgoing = data.Out or 0,
                    net = (data.In or 0) - (data.Out or 0)
                })
            end
        end
    end
    
    return {
        income = totalIncome,
        outgoing = totalOutgoing,
        net = totalIncome - totalOutgoing,
        transactions = transactions
    }
end

-- Get list of currencies that have data
function Storage:GetAvailableCurrencies()
    if not EnsureSavedVariablesStructure() then
        return {}
    end
    
    local server, character = GetCurrentServerAndCharacter()
    local charData = Accountant_ClassicSaveData[server][character]
    
    if not charData.currencyData then
        return {}
    end
    
    local currencies = {}
    for currencyID, _ in pairs(charData.currencyData) do
        table.insert(currencies, tonumber(currencyID))
    end
    
    return currencies
end

-- Save currency selection preference
function Storage:SaveCurrencySelection(currencyID)
    if not currencyID then
        return false
    end
    
    if not EnsureSavedVariablesStructure() then
        return false
    end
    
    local server, character = GetCurrentServerAndCharacter()
    local currencyOptions = Accountant_ClassicSaveData[server][character].currencyOptions
    
    if currencyOptions then
        currencyOptions.selectedCurrency = currencyID
        SafeLogDebug("Saved currency selection: %d", currencyID)
        return true
    end

    return false
end

function Storage:LoadCurrencySelection()
    if not EnsureSavedVariablesStructure() then
        return DEFAULT_CURRENCY
    end
    
    local server, character = GetCurrentServerAndCharacter()
    local currencyOptions = Accountant_ClassicSaveData[server][character].currencyOptions
    
    if currencyOptions and currencyOptions.selectedCurrency then
        return currencyOptions.selectedCurrency
    end
    
    return DEFAULT_CURRENCY
end

-- Check if currency tracking is enabled
function Storage:IsTrackingEnabled()
    if not EnsureSavedVariablesStructure() then
        return false
    end
    
    local server, character = GetCurrentServerAndCharacter()
    local currencyOptions = Accountant_ClassicSaveData[server][character].currencyOptions
    
    return currencyOptions and currencyOptions.trackingEnabled ~= false
end

-- Set currency tracking enabled/disabled
function Storage:SetTrackingEnabled(enabled)
    if not EnsureSavedVariablesStructure() then
        return false
    end
    
    local server, character = GetCurrentServerAndCharacter()
    local currencyOptions = Accountant_ClassicSaveData[server][character].currencyOptions
    
    if currencyOptions then
        currencyOptions.trackingEnabled = enabled
        return true
    end
    
    return false
end

-- Migrate data from older versions
function Storage:MigrateData(oldVersion, newVersion)
    SafeLogDebug("Migrating currency data from version %s to %s", 
        tostring(oldVersion), tostring(newVersion))
    
    -- Future migration logic will go here
    -- For now, just update the version
    
    return true
end

-- Validate data integrity
function Storage:ValidateData()
    if not EnsureSavedVariablesStructure() then
        return false
    end
    
    local server, character = GetCurrentServerAndCharacter()
    local charData = Accountant_ClassicSaveData[server][character]
    
    -- Validate currencyData structure
    if charData.currencyData then
        for currencyID, currencyData in pairs(charData.currencyData) do
            if type(currencyData) ~= "table" then
                SafeLogError("Invalid currency data structure for currency %s", tostring(currencyID))
                charData.currencyData[currencyID] = nil
            else
                -- Validate time periods
                for _, period in ipairs(TIME_PERIODS) do
                    if currencyData[period] and type(currencyData[period]) ~= "table" then
                        SafeLogError("Invalid time period data for currency %s, period %s", 
                            tostring(currencyID), period)
                        currencyData[period] = {}
                    end
                end
            end
        end
    end
    
    -- Validate currencyOptions structure
    if charData.currencyOptions then
        if type(charData.currencyOptions.selectedCurrency) ~= "number" then
            charData.currencyOptions.selectedCurrency = DEFAULT_CURRENCY
        end
        
        if type(charData.currencyOptions.trackingEnabled) ~= "boolean" then
            charData.currencyOptions.trackingEnabled = true
        end
    end

    -- Validate currencyDiscovery structure
    if charData.currencyDiscovery and type(charData.currencyDiscovery) ~= "table" then
        charData.currencyDiscovery = {}
    end
    
    -- Validate currencyMeta structure (optional, non-breaking)
    if charData.currencyMeta and type(charData.currencyMeta) ~= "table" then
        charData.currencyMeta = {}
    end
    
    SafeLogDebug("Currency data validation completed")
    return true
end

-- Build a preview of repairing negative source keys by removing them and
-- subtracting their total Out from Total.BaselinePrime.In. This does not modify data.
-- Returns a summary table:
-- {
--   currencies = n,
--   periods = n,
--   removedOut = total_out_removed,
--   details = {
--     [currencyID] = {
--       negatives = { ["Session"]=amt, ["Day"]=amt, ... },
--       totalRemovedOut = amt,
--     }
--   }
-- }
function Storage:PreviewNegativeSourcesToBaseline()
    if not EnsureSavedVariablesStructure() then
        return { currencies = 0, periods = 0, removedOut = 0, details = {} }
    end

    local server, character = GetCurrentServerAndCharacter()
    local charData = Accountant_ClassicSaveData[server][character]
    local details = {}
    local periodsTouched = 0
    local currenciesTouched = 0
    -- We define removedOut to mean removal counted from the Total timeframe only,
    -- because only Total is compensated by BaselinePrime.In.
    local removedTotal = 0

    local PERIODS = { "Session", "Day", "Week", "Month", "Year", "Total" }

    for cid, periods in pairs(charData.currencyData or {}) do
        local perCur = { negatives = {}, totalRemovedOut = 0, removedFromTotal = 0 }
        local hadAny = false
        for _, tf in ipairs(PERIODS) do
            local bucket = periods[tf]
            if type(bucket) == "table" then
                local sumOut = 0
                for sk, rec in pairs(bucket) do
                    if type(sk) == "number" and sk < 0 and type(rec) == "table" then
                        sumOut = sumOut + (rec.Out or 0)
                    end
                end
                if sumOut > 0 then
                    perCur.negatives[tf] = sumOut
                    perCur.totalRemovedOut = perCur.totalRemovedOut + sumOut
                    if tf == "Total" then
                        perCur.removedFromTotal = perCur.removedFromTotal + sumOut
                    end
                    periodsTouched = periodsTouched + 1
                    hadAny = true
                end
            end
        end
        if hadAny then
            details[cid] = perCur
            removedTotal = removedTotal + (perCur.removedFromTotal or 0)
            currenciesTouched = currenciesTouched + 1
        end
    end

    return {
        currencies = currenciesTouched,
        periods = periodsTouched,
        removedOut = removedTotal, -- from Total timeframe only
        details = details,
    }
end

-- Apply the negative-source repair:
-- 1) Remove entries with numeric source keys < 0 across Session/Day/Week/Month/Year/Total
-- 2) Subtract the total removed Out across all periods from Total.BaselinePrime.In (clamped to >= 0)
-- Returns a summary table similar to Preview with an additional field baselineApplied.
function Storage:ApplyNegativeSourcesToBaseline()
    if not EnsureSavedVariablesStructure() then
        return { currencies = 0, periods = 0, removedOut = 0, baselineApplied = 0, details = {} }
    end

    local server, character = GetCurrentServerAndCharacter()
    local sv = Accountant_ClassicSaveData
    local charData = sv[server][character]
    charData.currencyData = charData.currencyData or {}

    -- Reuse preview logic to guarantee identical detection behavior
    local preview = self:PreviewNegativeSourcesToBaseline()

    local baselineApplied = 0
    local PERIODS = { "Session", "Day", "Week", "Month", "Year", "Total" }

    -- If nothing to do, still touch lastUpdate and return summary with baselineApplied=0
    if not preview or (preview.currencies or 0) == 0 then
        charData.currencyOptions = charData.currencyOptions or {}
        charData.currencyOptions.lastUpdate = time()
        preview = preview or { currencies = 0, periods = 0, removedOut = 0, details = {} }
        preview.baselineApplied = 0
        return preview
    end

    -- Apply deletions and baseline adjustment based on preview details
    for cid, rec in pairs(preview.details or {}) do
        local periods = charData.currencyData[cid]
        if type(periods) == "table" then
            -- Remove negative source keys across all timeframes
            for _, tf in ipairs(PERIODS) do
                periods[tf] = periods[tf] or {}
                local bucket = periods[tf]
                if type(bucket) == "table" then
                    for sk in pairs(bucket) do
                        if type(sk) == "number" and sk < 0 then
                            bucket[sk] = nil
                        end
                    end
                end
            end

            -- Subtract from Total.BaselinePrime.In using preview.removedFromTotal
            local removedFromTotal = tonumber(rec.removedFromTotal or 0) or 0
            if removedFromTotal > 0 then
                periods.Total = periods.Total or {}
                periods.Total["BaselinePrime"] = periods.Total["BaselinePrime"] or { In = 0, Out = 0 }
                local before = periods.Total["BaselinePrime"].In or 0
                local toSub = math.min(before, removedFromTotal)
                periods.Total["BaselinePrime"].In = before - toSub
                baselineApplied = baselineApplied + toSub
            end
        end
    end

    -- Touch lastUpdate
    charData.currencyOptions = charData.currencyOptions or {}
    charData.currencyOptions.lastUpdate = time()

    -- Return the preview summary augmented with baselineApplied so caller sees the final effect
    preview.baselineApplied = baselineApplied
    return preview
end

-- Retrieve the table of dynamically discovered currencies for the current character.
-- Returns a live table reference so callers can mutate it in-place.
function Storage:GetDiscoveredCurrencies()
    -- Use account-wide shared discovery table (Accountant_Classic_CurrencyDB)
    _G.Accountant_Classic_CurrencyDB = _G.Accountant_Classic_CurrencyDB or {}
    _G.Accountant_Classic_CurrencyDB.currencyDiscovery = _G.Accountant_Classic_CurrencyDB.currencyDiscovery or {}
    return _G.Accountant_Classic_CurrencyDB.currencyDiscovery
end

-- Save basic metadata for a dynamically discovered currency so downstream
-- modules (e.g., DataManager) can treat it as supported and allow tracking.
-- Idempotent: safely merges/updates existing entry without clearing user-set flags.
function Storage:SaveDiscoveredCurrency(currencyID)
    if not currencyID then return false end
    local n = tonumber(currencyID)
    if not n then return false end
    currencyID = n
    -- Ensure global table exists (Accountant_Classic_CurrencyDB)
    _G.Accountant_Classic_CurrencyDB = _G.Accountant_Classic_CurrencyDB or {}
    _G.Accountant_Classic_CurrencyDB.currencyDiscovery = _G.Accountant_Classic_CurrencyDB.currencyDiscovery or {}
    local discovery = _G.Accountant_Classic_CurrencyDB.currencyDiscovery
    discovery[currencyID] = discovery[currencyID] or {}
    local meta = discovery[currencyID]

    -- Always store the id field
    meta.id = currencyID

    -- Populate name/icon from modern API when available; keep prior values if present
    if C_CurrencyInfo and C_CurrencyInfo.GetCurrencyInfo then
        local ok, info = pcall(C_CurrencyInfo.GetCurrencyInfo, currencyID)
        if ok and type(info) == "table" then
            meta.name = meta.name or info.name or ("Currency " .. tostring(currencyID))
            meta.icon = meta.icon or info.iconFileID
        end
    end

    -- Default tracking to true unless explicitly set to false by the user
    if meta.tracked == nil then
        meta.tracked = true
    end

    -- Optional placeholders (non-authoritative without Constants): expansion/patch/category
    meta.category = meta.category or "Discovered"

    SafeLogDebug("Saved discovered currency metadata (id=%d, tracked=%s)", currencyID, tostring(meta.tracked))
    return true
end

-- Record raw event metadata for analysis/diagnostics: counts of gain/lost sources
-- and the last-seen snapshot. Minimal write path that is safe during early init.
-- sign: +1 for gain, -1 for loss, used only for the 'last' snapshot (counters use absolute source ids)
--
-- NOTE (WoW 11.0.2+): The fifth event argument formerly known as `quantityLostSource`
-- was renamed by Blizzard to `destroyReason`. To maintain backward compatibility
-- and avoid SavedVariables migrations, we intentionally continue to persist this
-- negative-direction source under the existing `lost` bucket (node.lost[...] and
-- node.last.lost). Display layers may choose to label it as "Destroy/Lost" on
-- modern clients, but storage shape remains unchanged.
function Storage:RecordEventMetadata(currencyID, quantityGainSource, quantityLostSource, sign)
    if not currencyID then return false end
    if not EnsureSavedVariablesStructure() then return false end

    local server, character = GetCurrentServerAndCharacter()
    local sv = Accountant_ClassicSaveData
    local charData = sv[server][character]
    charData.currencyMeta = charData.currencyMeta or {}
    charData.currencyMeta[currencyID] = charData.currencyMeta[currencyID] or {}

    -- We record under two simple timeframes for now: Session and Total.
    local tfs = { "Session", "Total" }
    for _, tf in ipairs(tfs) do
        local node = charData.currencyMeta[currencyID][tf] or {}
        node.gain = node.gain or {}
        node.lost = node.lost or {}

        -- Increment counters using absolute source codes when available
        local g = tonumber(quantityGainSource)
        if g then
            node.gain[g] = (node.gain[g] or 0) + 1
        end
        local l = tonumber(quantityLostSource)
        if l then
            node.lost[l] = (node.lost[l] or 0) + 1
        end

        -- Keep last snapshot for quick inspection
        node.last = {
            gain = quantityGainSource,
            lost = quantityLostSource,
            sign = sign,
            t = time(),
        }

        charData.currencyMeta[currencyID][tf] = node
    end

    return true
end

-- Clean up old data based on retention settings
function Storage:CleanupOldData()
    -- This will implement data retention policies in the future
    -- For now, just log that cleanup was requested
    SafeLogDebug("Currency data cleanup completed")
    return true
end

-- Reset all currency data (for testing or user request)
function Storage:ResetAllData()
    if not EnsureSavedVariablesStructure() then
        return false
    end
    
    local server, character = GetCurrentServerAndCharacter()
    local charData = Accountant_ClassicSaveData[server][character]
    
    charData.currencyData = {}
    charData.currencyOptions = {
        selectedCurrency = DEFAULT_CURRENCY,
        trackingEnabled = true,
        lastUpdate = time(),
        version = CURRENCY_VERSION
    }
    
    SafeLogDebug("Reset all currency data for %s-%s", server, character)
    return true
end

-- Get currency data for a specific character (used by All Chars display)
function Storage:GetCharacterCurrencyData(server, character, currencyID, timeframe)
    if not server or not character or not currencyID then
        return nil
    end
    
    timeframe = timeframe or "Total"
    
    -- Check if SavedVariables exists
    if not Accountant_ClassicSaveData or not Accountant_ClassicSaveData[server] or 
       not Accountant_ClassicSaveData[server][character] then
        return nil
    end
    
    local charData = Accountant_ClassicSaveData[server][character]
    
    if not charData.currencyData or not charData.currencyData[currencyID] then
        return {
            income = 0,
            outgoing = 0,
            net = 0,
            lastUpdate = "Never"
        }
    end
    
    local currencyData = charData.currencyData[currencyID][timeframe] or {}
    local totalIncome = 0
    local totalOutgoing = 0
    
    -- Calculate totals
    for source, data in pairs(currencyData) do
        if type(data) == "table" and data.In and data.Out then
            totalIncome = totalIncome + (data.In or 0)
            totalOutgoing = totalOutgoing + (data.Out or 0)
        end
    end
    
    -- Get last update time
    local lastUpdate = "Never"
    if charData.currencyOptions and charData.currencyOptions.lastUpdate then
        lastUpdate = date("%d/%m/%y", charData.currencyOptions.lastUpdate)
    end
    
    return {
        income = totalIncome,
        outgoing = totalOutgoing,
        net = totalIncome - totalOutgoing,
        lastUpdate = lastUpdate
    }
end

-- Get storage statistics
function Storage:GetStorageStats()
    if not EnsureSavedVariablesStructure() then
        return nil
    end
    
    local server, character = GetCurrentServerAndCharacter()
    local charData = Accountant_ClassicSaveData[server][character]
    
    local stats = {
        currenciesTracked = 0,
        totalTransactions = 0,
        lastUpdate = 0
    }
    
    if charData.currencyData then
        for currencyID, currencyData in pairs(charData.currencyData) do
            stats.currenciesTracked = stats.currenciesTracked + 1
            
            -- Count transactions in Total period
            if currencyData.Total then
                for source, data in pairs(currencyData.Total) do
                    if type(data) == "table" and (data.In or data.Out) then
                        if (data.In or 0) > 0 then
                            stats.totalTransactions = stats.totalTransactions + 1
                        end
                        if (data.Out or 0) > 0 then
                            stats.totalTransactions = stats.totalTransactions + 1
                        end
                    end
                end
            end
        end
    end
    
    if charData.currencyOptions and charData.currencyOptions.lastUpdate then
        stats.lastUpdate = charData.currencyOptions.lastUpdate
    end
    
    return stats
end
