-- CurrencyCore.lua
-- Main orchestration module for Currency Tracker functionality
-- Manages module lifecycle and coordinates between sub-components

local addonName, addonTable = ...
-- Bind localization table for display labels
local L = LibStub and LibStub("AceLocale-3.0", true) and LibStub("AceLocale-3.0"):GetLocale("Accountant_Classic", true) or nil

-- Lazy resolver for localization table to handle load-order differences
local function CT_GetL()
    if L then return L end
    if LibStub then
        local ace = LibStub("AceLocale-3.0", true)
        if ace then
            local LL = ace:GetLocale("Accountant_Classic", true)
            if LL then L = LL end
        end
    end
    return L
end

-- Open the Currency UI window using the UI module if available.
-- This function does not modify any CLI logic; it simply delegates to the UI layer.
function CurrencyTracker:OpenUI()
    local ui = self.CurrencyFrame or self.UIController
    if ui then
        if type(ui.Show) == "function" then
            ui:Show()
            return
        elseif type(ui.Toggle) == "function" then
            ui:Toggle(true)
            return
        end
    end
    -- Fallback: friendly placeholder; keep behavior read-only per design.
    print("[AC CT] Currency UI placeholder: showing all currencies for this session in chat.")
    self:PrintMultipleCurrencies("Session", false)
end

-- Create the main CurrencyTracker namespace
CurrencyTracker = CurrencyTracker or {}

-- Module state
local isEnabled = false
local isInitialized = false

-- Sub-module references (will be populated as modules are loaded)
-- Important: do NOT overwrite if modules were already defined by earlier files
CurrencyTracker.Constants = CurrencyTracker.Constants
CurrencyTracker.DataManager = CurrencyTracker.DataManager
CurrencyTracker.UIController = CurrencyTracker.UIController
CurrencyTracker.EventHandler = CurrencyTracker.EventHandler
CurrencyTracker.Storage = CurrencyTracker.Storage
CurrencyTracker.DisplayIntegration = CurrencyTracker.DisplayIntegration

-- Core module interface
function CurrencyTracker:Initialize()
    if isInitialized then
        return true
    end

-- Inspect raw metadata recorded for a currency: gain/lost source counts and last snapshot
function CurrencyTracker:MetaShow(sub)
    local tf, id = self:ParseShowCommand(sub) -- reuse timeframe parser; expects id at the end
    if not id then
        print("Usage: /ct meta show <timeframe> <id>")
        return
    end
    local server = _G.AC_SERVER or GetRealmName()
    local character = _G.AC_PLAYER or UnitName("player")
    local sv = _G.Accountant_ClassicSaveData
    if not (server and character and sv and sv[server] and sv[server][character]) then
        print("No saved data available")
        return
    end
    local metaRoot = sv[server][character].currencyMeta
    if not metaRoot or not metaRoot[id] then
        print("No metadata for currency "..tostring(id))
        return
    end
    local node = metaRoot[id][tf] or {}
    local gain = node.gain or {}
    local lost = node.lost or {}
    print(string.format("=== Meta Sources - %s (%d) ===", tf, id))
    -- 11.0.2: quantityLostSource renamed to destroyReason. We keep storing under 'lost'
    -- for backward compatibility, but adjust the displayed label on modern clients.
    local is1102 = CurrencyTracker and CurrencyTracker.Constants and CurrencyTracker.Constants.VersionUtils
        and CurrencyTracker.Constants.VersionUtils.IsVersionSupported
        and CurrencyTracker.Constants.VersionUtils.IsVersionSupported("11.0.2")
    local function sortedKeys(t)
        local keys = {}
        for k in pairs(t) do table.insert(keys, k) end
        table.sort(keys, function(a,b) return tostring(a) < tostring(b) end)
        return keys
    end
    local gk = sortedKeys(gain)
    print("Gain sources:")
    if #gk == 0 then
        print("  <none>")
    else
        for _, k in ipairs(gk) do
            local label = tostring(k)
            local token = CurrencyTracker.SourceCodeTokens and CurrencyTracker.SourceCodeTokens[tonumber(k)]
            if token then
                label = (L and L[token]) or token
            else
                label = "S:" .. tostring(k)
            end
            print(string.format("  %s: %d", label, gain[k] or 0))
        end
    end
    local lk = sortedKeys(lost)
    print(is1102 and "Destroy/Lost sources:" or "Lost sources:")
    if #lk == 0 then
        print("  <none>")
    else
        for _, k in ipairs(lk) do
            local label = tostring(k)
            local token = CurrencyTracker.DestroyReasonTokens and CurrencyTracker.DestroyReasonTokens[tonumber(k)]
            if token then
                label = (L and L[token]) or token
            else
                label = "S:" .. tostring(k)
            end
            print(string.format("  %s: %d", label, lost[k] or 0))
        end
    end
    if node.last then
        print(string.format("Last: gain=%s lost=%s sign=%s time=%s", tostring(node.last.gain), tostring(node.last.lost), tostring(node.last.sign), tostring(node.last.t)))
    end
    print("=========================")
end

-- True repair: remove previously recorded income/outgoing across aggregates
-- Syntax: "remove <id> <amount> <source> (income|outgoing)"
function CurrencyTracker:RepairRemove(sub)
    if not self.Storage or not self.Storage.RepairRemove then
        print("Repair not available: storage helper missing")
        return
    end
    -- Accept either numeric or string source tokens (e.g., 16 or Unknown)
    local id, amount, source, kind = sub:match("remove%s+(%d+)%s+(%d+)%s+(%d+)%s+(%a+)")
    if id and amount and source and kind then
        id = tonumber(id)
        amount = tonumber(amount)
        source = tonumber(source) -- numeric source
    else
        -- Fallback: string source (no spaces), e.g., Unknown or BaselinePrime
        id, amount, source, kind = sub:match("remove%s+(%d+)%s+(%d+)%s+([^%s]+)%s+(%a+)")
        id = tonumber(id)
        amount = tonumber(amount)
        -- keep source as string
    end
    if not id or not amount or not source or not kind then
        print("Usage: /ct repair remove <id> <amount> <source> (income|outgoing)")
        print("  <source> can be a number (e.g., 16) or a string token (e.g., Unknown, BaselinePrime)")
        return
    end
    local ok = self.Storage:RepairRemove(id, amount, source, kind)
    if ok then
        print(string.format("Removed %d from %s for currency %d (source=%s) across periods",
            amount, string.lower(kind), id, tostring(source)))
    else
        print("Removal failed")
    end
end

-- Adjust aggregates manually: "adjust <id> <delta> [source]"
function CurrencyTracker:RepairAdjust(sub)
    if not self.Storage or not self.Storage.AdjustCurrencyAggregates then
        print("Repair not available: storage helper missing")
        return
    end
    local id, delta, source = sub:match("adjust%s+(%d+)%s+(-?%d+)%s*(%d*)")
    id = tonumber(id)
    delta = tonumber(delta)
    source = tonumber(source)
    if not id or not delta then
        print("Usage: /ct repair adjust <id> <delta> [source]")
        return
    end
    local ok = self.Storage:AdjustCurrencyAggregates(id, delta, source)
    if ok then
        print(string.format("Adjusted currency %d by %d (source=%s)", id, delta, tostring(source or 0)))
    else
        print("Adjustment failed")
    end
end

-- List discovered currencies
function CurrencyTracker:DiscoverList()
    if not self.Storage or not self.Storage.GetDiscoveredCurrencies then
        print("No discovery storage available")
        return
    end
    local discovered = self.Storage:GetDiscoveredCurrencies() or {}
    local count = 0
    print("=== Discovered Currencies ===")
    -- Collect and sort by id for stable output
    local ids = {}
    for id in pairs(discovered) do table.insert(ids, id) end
    table.sort(ids)
    for _, id in ipairs(ids) do
        local meta = discovered[id]
        local tracked = (meta and meta.tracked ~= false)
        print(string.format("%d: %s (tracked=%s)", id, tostring(meta and meta.name or ("Currency "..tostring(id))), tracked and "true" or "false"))
        count = count + 1
    end
    if count == 0 then print("<none>") end
    print("=== End ===")
end

-- Track/untrack a discovered currency. Syntax: "track <id> [on|off]"; no state toggles.
function CurrencyTracker:DiscoverTrack(sub)
    if not self.Storage or not self.Storage.GetDiscoveredCurrencies then
        print("No discovery storage available")
        return
    end
    local id = tonumber(sub:match("track%s+(%d+)") or "")
    if not id then
        print("Usage: /ct discover track <id> [on|off]")
        return
    end
    local stateStr = sub:match("track%s+%d+%s+(%a+)")
    local discovered = self.Storage:GetDiscoveredCurrencies()
    discovered[id] = discovered[id] or {}
    -- If not previously saved, try to populate basic meta
    if self.Storage.SaveDiscoveredCurrency and (not discovered[id].id) then
        self.Storage:SaveDiscoveredCurrency(id)
        discovered = self.Storage:GetDiscoveredCurrencies()
    end

    local current = (discovered[id].tracked ~= false)
    local newVal
    if stateStr == nil then
        newVal = not current
    else
        stateStr = string.lower(stateStr)
        if stateStr == "on" or stateStr == "true" then
            newVal = true
        elseif stateStr == "off" or stateStr == "false" then
            newVal = false
        else
            print("Usage: /ct discover track <id> [on|off]")
            return
        end
    end
    discovered[id].tracked = newVal and true or false
    print(string.format("Discovered currency %d tracked=%s", id, newVal and "true" or "false"))
end

-- Clear all discovered currencies for the current character
function CurrencyTracker:DiscoverClear()
    if not self.Storage or not self.Storage.GetDiscoveredCurrencies then
        print("No discovery storage available")
        return
    end
    local discovered = self.Storage:GetDiscoveredCurrencies()
    local n = 0
    for k in pairs(discovered) do discovered[k] = nil; n = n + 1 end
    print(string.format("Cleared %d discovered currencies", n))
end
    
    -- Initialize sub-modules in proper order
    local success = true
    
    -- Constants module first (no initialization needed, just data)
    -- Storage must be initialized first
    if self.Storage and self.Storage.Initialize then
        success = success and self.Storage:Initialize()
    end
    
    -- Then data manager
    if self.DataManager and self.DataManager.Initialize then
        success = success and self.DataManager:Initialize()
    end
    
    -- Then event handler
    if self.EventHandler and self.EventHandler.Initialize then
        success = success and self.EventHandler:Initialize()
    end
    
    -- Headless mode: disable UI controller initialization
    -- if self.UIController and self.UIController.Initialize then
    --     success = success and self.UIController:Initialize()
    -- end
    
    -- Headless mode: disable display integration initialization
    -- if self.DisplayIntegration and self.DisplayIntegration.Initialize then
    --     success = success and self.DisplayIntegration:Initialize()
    -- end
    
    if success then
        isInitialized = true
        print("[AC CT] CurrencyTracker: Module initialized successfully")
        -- Diagnostics (debug only)
        if CurrencyTracker and CurrencyTracker.DEBUG_MODE then
            print(string.format("[AC CT] Core.Init: EventHandler=%s Init=%s Enable=%s",
                tostring(self.EventHandler), tostring(self.EventHandler and self.EventHandler.Initialize), tostring(self.EventHandler and self.EventHandler.Enable)))
        end
    else
        print("[AC CT] CurrencyTracker: Module initialization failed")
    end
    
    return success
end

function CurrencyTracker:Enable()
    if not isInitialized then
        if not self:Initialize() then
            return false
        end
    end
    
    if isEnabled then
        return true
    end
    
    -- Enable sub-modules
    local success = true
    
    -- Diagnostics before enabling EventHandler (debug only)
    if CurrencyTracker and CurrencyTracker.DEBUG_MODE then
        print(string.format("[AC CT] Core.Enable: about to enable EventHandler (exists=%s, hasEnable=%s)",
            tostring(self.EventHandler ~= nil), tostring(self.EventHandler and (type(self.EventHandler.Enable) == "function"))))
    end

    if self.EventHandler and self.EventHandler.Enable then
        local ok = self.EventHandler:Enable()
        success = success and ok
        if CurrencyTracker and CurrencyTracker.DEBUG_MODE then
            print(string.format("[AC CT] Core.Enable: EventHandler:Enable() returned %s", tostring(ok)))
        end
    else
        if CurrencyTracker and CurrencyTracker.DEBUG_MODE then
            print("[AC CT] Core.Enable: EventHandler missing or no Enable()")
        end
    end
    
    -- Headless mode: do not enable UI or display integration
    -- if self.UIController and self.UIController.Enable then
    --     success = success and self.UIController:Enable()
    -- end
    
    -- if self.DisplayIntegration and self.DisplayIntegration.Enable then
    --     success = success and self.DisplayIntegration:Enable()
    -- end
    
    if success then
        isEnabled = true
        print("[AC CT] CurrencyTracker: Module enabled")
    else
        print("[AC CT] CurrencyTracker: Module enable failed")
    end
    
    return success
end

function CurrencyTracker:Disable()
    if not isEnabled then
        return true
    end
    
    -- Disable sub-modules in reverse order
    local success = true
    
    if self.DisplayIntegration and self.DisplayIntegration.Disable then
        success = success and self.DisplayIntegration:Disable()
    end
    
    if self.UIController and self.UIController.Disable then
        success = success and self.UIController:Disable()
    end
    
    if self.EventHandler and self.EventHandler.Disable then
        success = success and self.EventHandler:Disable()
    end
    
    if success then
        isEnabled = false
        print("[AC CT] CurrencyTracker: Module disabled")
    else
        print("[AC CT] CurrencyTracker: Module disable failed")
    end
    
    return success
end

function CurrencyTracker:IsEnabled()
    return isEnabled
end

function CurrencyTracker:IsInitialized()
    return isInitialized
end

-- Version information
CurrencyTracker.VERSION = "1.0.0"
CurrencyTracker.MIN_ADDON_VERSION = "2.20.00"

-- Internal helpers for baseline preview/apply
-- Fetch live quantity for a currency id using modern or legacy API.
local function CT_GetRealCurrencyAmount(currencyID)
    if not currencyID then return nil end
    if C_CurrencyInfo and C_CurrencyInfo.GetCurrencyInfo then
        local ok, info = pcall(C_CurrencyInfo.GetCurrencyInfo, currencyID)
        if ok and type(info) == "table" then
            return info.quantity or 0
        end
    end
    if _G.GetCurrencyInfo then
        local ok, name, amount = pcall(_G.GetCurrencyInfo, currencyID)
        if ok and name then
            return amount or 0
        end
    end
    return nil
end

-- Adjust Total-only by a signed delta without touching other periods.
-- Positive delta increases Total.In; negative delta increases Total.Out.
local function CT_ApplyTotalOnlyDelta(currencyID, delta)
    if not currencyID or not delta or delta == 0 then return false end
    if not EnsureSavedVariablesStructure or not GetCurrentServerAndCharacter then return false end
    if not EnsureSavedVariablesStructure() then return false end
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
    bucket.Total["BaselinePrime"] = bucket.Total["BaselinePrime"] or { In = 0, Out = 0 }
    if delta > 0 then
        bucket.Total["BaselinePrime"].In = (bucket.Total["BaselinePrime"].In or 0) + delta
    else
        bucket.Total["BaselinePrime"].Out = (bucket.Total["BaselinePrime"].Out or 0) + (-delta)
    end
    charData.currencyOptions = charData.currencyOptions or {}
    charData.currencyOptions.lastUpdate = time()
    return true
end

-- Build baseline discrepancy list using a single logic path.
-- Returns an array of { id, name, ac, real, delta } for mismatches only.
function CurrencyTracker:BuildBaselineDiscrepancies()
    local results = {}
    local ids = {}
    if self.Storage and self.Storage.GetAvailableCurrencies then
        ids = self.Storage:GetAvailableCurrencies() or {}
    elseif self.DataManager and self.DataManager.GetAvailableCurrencies then
        ids = self.DataManager:GetAvailableCurrencies() or {}
    end

    for _, cid in ipairs(ids) do
        local data = self.Storage and self.Storage:GetCurrencyData(cid, "Total") or nil
        local acNet = (data and data.net) or 0
        local real = CT_GetRealCurrencyAmount(cid)
        if real ~= nil then
            local info = self.DataManager and self.DataManager:GetCurrencyInfo(cid) or nil
            local name = (info and info.name) or ("Currency " .. tostring(cid))
            if L and L[name] then name = L[name] end
            if acNet ~= real then
                table.insert(results, {
                    id = cid,
                    name = name,
                    ac = acNet,
                    real = real,
                    delta = (real - acNet),
                })
            end
        end
    end
    table.sort(results, function(a,b)
        if a.name == b.name then return a.id < b.id end
        return tostring(a.name) < tostring(b.name)
    end)
    return results
end

-- Preview baseline discrepancies: print only; no writes.
function CurrencyTracker:RepairBaselinePreview()
    local diffs = self:BuildBaselineDiscrepancies()
    if #diffs == 0 then
        print("Baseline preview: all totals match live values.")
        return
    end
    print("=== Baseline Preview (Total vs Live) ===")
    for _, d in ipairs(diffs) do
        print(string.format("%s (id=%d): AC-CT amount=%d | Real amount=%d | Delta=%+d",
            tostring(d.name), d.id, d.ac, d.real, d.delta))
    end
    print("=== End Preview ===")
end

-- Apply baseline corrections: reuse preview logic; write Total-only delta.
function CurrencyTracker:RepairBaselineApply()
    local diffs = self:BuildBaselineDiscrepancies()
    if #diffs == 0 then
        print("Baseline apply: nothing to change (all totals already match).")
        return
    end
    print("=== Baseline Apply (Total-only adjustments) ===")
    for _, d in ipairs(diffs) do
        local ok = CT_ApplyTotalOnlyDelta(d.id, d.delta)
        if ok then
            print(string.format("Fixed %s (id=%d): AC-CT %d -> %d (applied %+d)",
                tostring(d.name), d.id, d.ac, d.real, d.delta))
        else
            print(string.format("Failed to fix %s (id=%d)", tostring(d.name), d.id))
        end
    end
    print("=== End Apply ===")
end

-- Utility function to check if the main addon version is compatible
function CurrencyTracker:IsCompatibleVersion()
    -- This will be implemented when we integrate with the main addon
    -- For now, assume compatibility
    return true
end

-- Error logging function
function CurrencyTracker:LogError(message, ...)
    local formattedMessage = string.format(message, ...)
    print("CurrencyTracker ERROR: " .. formattedMessage)
end

-- Debug logging function (can be disabled in production)
function CurrencyTracker:LogDebug(message, ...)
    if self.DEBUG_MODE then
        local formattedMessage = string.format(message, ...)
        print("CurrencyTracker DEBUG: " .. formattedMessage)
    end
end

-- Set debug mode (can be controlled by user settings later)
-- Debug mode defaults to OFF; can be toggled via '/ct debug on|off'
CurrencyTracker.DEBUG_MODE = false

-- Event handler wrapper functions for main addon integration
function CurrencyTracker:OnCurrencyDisplayUpdate(currencyType, quantity, quantityChange, quantityGainSource, quantityLostSource)
    if not isInitialized or not isEnabled then
        return
    end
    
    if self.EventHandler and self.EventHandler.OnCurrencyDisplayUpdate then
        -- Forward all parameters if handler supports them; legacy handlers will ignore extras
        self.EventHandler:OnCurrencyDisplayUpdate(currencyType, quantity, quantityChange, quantityGainSource, quantityLostSource)
    end
end

function CurrencyTracker:OnBagUpdate(bagID)
    if not isInitialized or not isEnabled then
        return
    end
    
    if self.EventHandler and self.EventHandler.OnBagUpdate then
        self.EventHandler:OnBagUpdate(bagID)
    end
end

-- Function to get system status
function CurrencyTracker:GetStatus()
    local status = {
        isInitialized = isInitialized,
        isEnabled = isEnabled,
        version = self.VERSION,
        debugMode = self.DEBUG_MODE
    }
    
if self.UIController and self.UIController.GetSystemStatus then
        status.uiController = self.UIController:GetSystemStatus()
    end
    
    return status
end

-- Register production slash commands (headless mode)
SLASH_CURRENCYTRACKER1 = "/ct"
SlashCmdList["CURRENCYTRACKER"] = function(msg)
    local command = string.lower(msg or "")
    local cmd = command:match("^%s*(.*)$") or command

    -- Prefer the more specific 'show-all-currencies' before generic 'show'
    if cmd:find("^show%-all%-currencies") then
        local timeframe = select(1, CurrencyTracker:ParseShowCommand(cmd))
        local verbose = cmd:find("verbose") ~= nil
        CurrencyTracker:PrintMultipleCurrencies(timeframe, verbose)
    elseif cmd:find("^show%-all") then
        -- Alias for show-all-currencies; execute the exact same path
        local timeframe = select(1, CurrencyTracker:ParseShowCommand(cmd))
        local verbose = cmd:find("verbose") ~= nil
        CurrencyTracker:PrintMultipleCurrencies(timeframe, verbose)
    elseif cmd:find("^show") then
        CurrencyTracker:ShowCurrencyData(cmd)
    elseif cmd:find("^debug") then
        -- /ct debug on|off
        local sub = cmd:gsub("^debug%s*", "")
        sub = sub:gsub("^%s+", "")
        if sub == "on" then
            CurrencyTracker.DEBUG_MODE = true
            print("CurrencyTracker debug: ON")
        elseif sub == "off" then
            CurrencyTracker.DEBUG_MODE = false
            print("CurrencyTracker debug: OFF")
        else
            print("Usage: /ct debug on | /ct debug off")
            print("Current: "..(CurrencyTracker.DEBUG_MODE and "ON" or "OFF"))
        end
    elseif cmd:find("^status%s*$") then
        CurrencyTracker:ShowStatus()
    elseif cmd:find("^ui%s*$") then
        -- Open standalone Currency UI window (design doc: UI only renders; no logic duplication)
        if CurrencyTracker and CurrencyTracker.OpenUI then
            CurrencyTracker:OpenUI()
        else
            print("[AC CT] UI not available yet. Please ensure CurrencyFrame is loaded.")
        end
    elseif cmd:find("^get%-currency%-info") then
        -- Test helper: dump all fields returned by C_CurrencyInfo.GetCurrencyInfo for a given currency ID
        -- Usage: /ct get-currency-info <id>
        local sub = cmd:gsub("^get%-currency%-info%s*", "")
        sub = sub:gsub("^%s+", "")
        local id = tonumber(sub:match("^(%d+)"))
        if not id then
            print("Usage: /ct get-currency-info <currencyId>")
            return
        end
        if not (C_CurrencyInfo and C_CurrencyInfo.GetCurrencyInfo) then
            print("C_CurrencyInfo API not available")
            return
        end
        local ok, info = pcall(C_CurrencyInfo.GetCurrencyInfo, id)
        if not ok or type(info) ~= "table" or not next(info) then
            print(string.format("Currency %d not found or no info returned.", id))
            return
        end

        print(string.format("=== Currency Info (id=%d) ===", id))
        -- Known field order for readability
        local ordered = {
            "name", "description", "quantity", "trackedQuantity", "iconFileID",
            "maxQuantity", "canEarnPerWeek", "quantityEarnedThisWeek", "isTradeable", "quality",
            "maxWeeklyQuantity", "totalEarned", "discovered", "useTotalEarnedForMaxQty",
            "isHeader", "isHeaderExpanded", "isTypeUnused", "isShowInBackpack"
        }
        local printed = {}
        local function printKV(k, v)
            local t = type(v)
            if t == "boolean" then
                print(string.format("  %s: %s", k, v and "true" or "false"))
            elseif t == "number" then
                print(string.format("  %s: %s", k, tostring(v)))
            elseif t == "string" then
                print(string.format("  %s: %s", k, v))
            else
                -- tables or other types: tostring fallback
                print(string.format("  %s: %s", k, tostring(v)))
            end
        end
        for _, k in ipairs(ordered) do
            if info[k] ~= nil then
                printKV(k, info[k])
                printed[k] = true
            end
        end
        -- Print any remaining fields
        for k, v in pairs(info) do
            if not printed[k] then
                printKV(k, v)
            end
        end
        print("=== End Currency Info ===")
    elseif cmd:find("^set%s+whitelist") then
        -- /ct set whitelist [on|off]
        local sub = cmd:gsub("^set%s+whitelist%s*", "")
        sub = sub:gsub("^%s+", "")

        if not EnsureSavedVariablesStructure or not GetCurrentServerAndCharacter then
            print("Storage helpers unavailable; cannot save settings.")
            return
        end
        if not EnsureSavedVariablesStructure() then
            print("Failed to initialize storage structure.")
            return
        end
        local server, character = GetCurrentServerAndCharacter()
        local sv = _G.Accountant_ClassicSaveData
        if not (sv and sv[server] and sv[server][character]) then
            print("No character storage available.")
            return
        end
        local charData = sv[server][character]
        charData.currencyOptions = charData.currencyOptions or {}

        local current = charData.currencyOptions.whitelistFilter
        if current == nil then current = true end -- default ON

        if sub == "on" or sub == "true" then
            charData.currencyOptions.whitelistFilter = true
            print("Whitelist filter: ON (applies to /ct show and /ct show-all)")
        elseif sub == "off" or sub == "false" then
            charData.currencyOptions.whitelistFilter = false
            print("Whitelist filter: OFF (all currencies eligible; tracked filter still applies)")
        elseif sub == nil or sub == "" then
            print(string.format("Whitelist filter is currently: %s", (current and "ON" or "OFF")))
            print("Usage: /ct set whitelist on|off")
        else
            print("Usage: /ct set whitelist on|off")
        end
    elseif cmd:find("^set%-paras%s+near%-cap%-warning") then
        -- Configure near-cap warning parameters (per-character persistent settings)
        -- Usage:
        --   /ct set-paras near-cap-warning enable=true cap_percent=0.9 time_visible_sec=3 fade_duration_sec=0.8
        -- If no key=value pairs provided, prints current settings.
        local sub = cmd:gsub("^set%-paras%s+near%-cap%-warning%s*", "")
        sub = sub:gsub("^%s+", "")
        -- Normalize common input quirks: replace decimal comma with dot; trim trailing commas
        sub = sub:gsub(",", ".")

        -- Ensure SV structure is available
        if not EnsureSavedVariablesStructure or not GetCurrentServerAndCharacter then
            print("Storage helpers unavailable; cannot save settings.")
            return
        end
        if not EnsureSavedVariablesStructure() then
            print("Failed to initialize storage structure.")
            return
        end
        local server, character = GetCurrentServerAndCharacter()
        local sv = _G.Accountant_ClassicSaveData
        if not (sv and sv[server] and sv[server][character]) then
            print("No character storage available.")
            return
        end
        local charData = sv[server][character]
        charData.currencyOptions = charData.currencyOptions or {}
        charData.currencyOptions.nearCapAlert = charData.currencyOptions.nearCapAlert or {
            enable = true,
            cap_percent = 0.90,
            time_visible_sec = 3.0,
            fade_duration_sec = 0.8,
        }
        local opts = charData.currencyOptions.nearCapAlert

        -- Parse key=value pairs (forgiving parser with aliases and unit suffixes)
        local updated = false
        for key, value in string.gmatch(sub or "", "([%w_]+)%s*=%s*([^%s]+)") do
            local k = string.lower(key)
            -- Accept some aliases
            if k == "time" or k == "time_sec" or k == "timevisible" or k == "timevisiblesec" or k == "time_visible" then
                k = "time_visible_sec"
            elseif k == "fade" or k == "fade_sec" or k == "fadeduration" or k == "duration" or k == "duration_sec" then
                k = "fade_duration_sec"
            end

            if k == "enable" then
                local v = string.lower(value)
                if v == "true" or v == "on" or v == "1" or v == "yes" then
                    opts.enable = true; updated = true
                elseif v == "false" or v == "off" or v == "0" or v == "no" then
                    opts.enable = false; updated = true
                else
                    print("Invalid value for enable: "..value.." (use true/false)")
                end
            elseif k == "cap_percent" then
                local num = tonumber(value)
                if num and num > 0 and num <= 1.0 then
                    opts.cap_percent = num; updated = true
                else
                    print("Invalid cap_percent: expected 0-1 (e.g., 0.9)")
                end
            elseif k == "time_visible_sec" then
                -- Strip unit suffixes like 's' or 'sec'
                local cleaned = tostring(value):gsub("[sS][eE]?[cC]?$", "")
                local num = tonumber(cleaned)
                if num and num >= 0 then
                    opts.time_visible_sec = num; updated = true
                else
                    print("Invalid time_visible_sec: expected non-negative number")
                end
            elseif k == "fade_duration_sec" then
                -- Strip unit suffixes like 's' or 'sec'
                local cleaned = tostring(value):gsub("[sS][eE]?[cC]?$", "")
                local num = tonumber(cleaned)
                if num and num >= 0 then
                    opts.fade_duration_sec = num; updated = true
                else
                    print("Invalid fade_duration_sec: expected non-negative number")
                end
            else
                -- Ignore unknown parameters silently to be lenient with user input
            end
        end

        -- Touch lastUpdate
        charData.currencyOptions.lastUpdate = time()

        if updated then
            print(string.format("Near-cap alert settings updated: enable=%s cap_percent=%.2f time_visible_sec=%.2f fade_duration_sec=%.2f",
                tostring(opts.enable), opts.cap_percent or 0, opts.time_visible_sec or 0, opts.fade_duration_sec or 0))
            print("Note: Settings are saved in memory now. Type /reload to make them persistent.")
        else
            -- Show current configuration
            print("Near-cap alert settings:")
            print(string.format("  enable=%s", tostring(opts.enable)))
            print(string.format("  cap_percent=%.2f", tonumber(opts.cap_percent or 0.90)))
            print(string.format("  time_visible_sec=%.2f", tonumber(opts.time_visible_sec or 3.0)))
            print(string.format("  fade_duration_sec=%.2f", tonumber(opts.fade_duration_sec or 0.8)))
            print("Usage: /ct set-paras near-cap-warning enable=true cap_percent=0.9 time_visible_sec=3s fade_duration_sec=0.8s")
            print("  Notes: accepts aliases time= / fade= and unit suffixes 's'/'sec'. Decimal comma is allowed.")
        end
    elseif cmd:find("^discover") then
        -- /ct discover list | track <id> [on|off] | clear
        local sub = cmd:gsub("^discover%s*", "")
        sub = sub:gsub("^%s+", "")
        if sub == "list" then
            CurrencyTracker:DiscoverList()
        elseif sub:find("^track") then
            CurrencyTracker:DiscoverTrack(sub)
        elseif sub == "clear" then
            CurrencyTracker:DiscoverClear()
        else
            print("Usage: /ct discover list | track <id> [on|off] | clear")
        end
    elseif cmd:find("^repair") then
        -- /ct repair init
        -- /ct repair adjust <id> <delta> [source]
        -- /ct repair remove <id> <amount> <source> (income|outgoing)
        -- /ct repair baseline preview
        -- /ct repair baseline
        local sub = cmd:gsub("^repair%s*", "")
        sub = sub:gsub("^%s+", "")
        if sub == "init" then
            if CurrencyTracker.Storage and CurrencyTracker.Storage.ResetAllData then
                local ok = CurrencyTracker.Storage:ResetAllData()
                if ok then
                    print("[AC CT] CurrencyTracker: storage reset complete for current character (gold data untouched)")
                else
                    print("CurrencyTracker: storage reset failed")
                end
            else
                print("CurrencyTracker: storage reset helper unavailable")
            end
        elseif sub == "migrate-zero" or sub == "migrate" then
            if CurrencyTracker.Storage and CurrencyTracker.Storage.MigrateZeroSourceToBaselinePrime then
                local summary = CurrencyTracker.Storage:MigrateZeroSourceToBaselinePrime()
                print(string.format("[AC CT] Repair migrate-zero: currencies=%d periods=%d entries=%d moved +%d | -%d",
                    tonumber(summary.currencies or 0), tonumber(summary.periods or 0), tonumber(summary.entries or 0), tonumber(summary.inMoved or 0), tonumber(summary.outMoved or 0)))
            else
                print("CurrencyTracker: migrate-zero helper unavailable")
            end
        elseif sub:find("^adjust") then
            CurrencyTracker:RepairAdjust(sub)
        elseif sub:find("^remove") then
            CurrencyTracker:RepairRemove(sub)
        elseif sub:find("^baseline") then
            local rest = sub:gsub("^baseline%s*", "")
            rest = rest:gsub("^%s+", "")
            if rest == "preview" then
                CurrencyTracker:RepairBaselinePreview()
            elseif rest == "" then
                CurrencyTracker:RepairBaselineApply()
            else
                print("Usage: /ct repair baseline preview")
                print("       /ct repair baseline")
            end
        elseif sub:find("^negative%-sources") then
            -- /ct repair negative-sources [preview]
            if not CurrencyTracker.Storage or not CurrencyTracker.Storage.PreviewNegativeSourcesToBaseline or not CurrencyTracker.Storage.ApplyNegativeSourcesToBaseline then
                print("Repair not available: storage helpers missing")
            else
                local rest = sub:gsub("^negative%-sources%s*", "")
                rest = rest:gsub("^%s+", "")
                local isPreview = (rest == "preview")
                local summary
                if isPreview then
                    summary = CurrencyTracker.Storage:PreviewNegativeSourcesToBaseline()
                    print("=== Repair Preview: Negative Source Keys -> BaselinePrime ===")
                else
                    summary = CurrencyTracker.Storage:ApplyNegativeSourcesToBaseline()
                    print("=== Repair Applied: Negative Source Keys -> BaselinePrime ===")
                end

                local LL = CT_GetL()
                local function tfLabel(tf)
                    return (LL and LL[tf]) or tf
                end
                print(string.format("Currencies affected: %d", tonumber(summary.currencies or 0)))
                print(string.format("Timeframes affected: %d", tonumber(summary.periods or 0)))
                print(string.format("Total removed Out: %d", tonumber(summary.removedOut or 0)))
                if summary.baselineApplied ~= nil then
                    print(string.format("Total BaselinePrime.In reduced: %d", tonumber(summary.baselineApplied or 0)))
                end
                if summary.details then
                    for cid, rec in pairs(summary.details) do
                        local info = CurrencyTracker.DataManager and CurrencyTracker.DataManager:GetCurrencyInfo(cid) or nil
                        local name = (info and info.name) or ("Currency " .. tostring(cid))
                        if L and L[name] then name = L[name] end
                        print(string.format("- %s (id=%d): removedOut=%d", name, cid, tonumber(rec.totalRemovedOut or 0)))
                        for tf, amt in pairs(rec.negatives or {}) do
                            print(string.format("  * %s: removedOut=%d", tfLabel(tf), tonumber(amt or 0)))
                        end
                    end
                end
                print("=== End ===")
            end
        else
            print("Usage: /ct repair init")
            print("       /ct repair migrate-zero   -- Move numeric source 0 to 'BaselinePrime' across all timeframes")
            print("       /ct repair adjust <id> <delta> [source]")
            print("       /ct repair remove <id> <amount> <source> (income|outgoing)")
            print("       /ct repair baseline preview")
            print("       /ct repair baseline")
            print("       /ct repair negative-sources preview   -- Show what would be removed and baseline reduction")
            print("       /ct repair negative-sources           -- Apply removal and baseline reduction")
        end
    elseif cmd:find("^meta") then
        -- /ct meta show <timeframe> <id>
        local sub = cmd:gsub("^meta%s*", "")
        sub = sub:gsub("^%s+", "")
        if sub:find("^show") then
            CurrencyTracker:MetaShow(sub)
        else
            print("Usage: /ct meta show <timeframe> <id>")
        end
    else
        CurrencyTracker:ShowHelp()
    end
end

-- Show system status
function CurrencyTracker:ShowStatus()
    local status = self:GetStatus()
    print("=== CurrencyTracker Status ===")
    for key, value in pairs(status) do
        if type(value) == "table" then
            print(string.format("%s: [table]", key))
        else
            print(string.format("%s: %s", key, tostring(value)))
        end
    end
    print("=== End Status ===")
end

-- Parse timeframe and optional currencyID from a show command
-- Returns: timeframe (string), currencyID (number|nil)
function CurrencyTracker:ParseShowCommand(command)
    -- Extract parts and detect trailing numeric currency ID
    local currencyID = nil
    local parts = {}
    for part in string.gmatch(string.lower(command or ""), "%S+") do
        table.insert(parts, part)
    end

    if #parts > 0 then
        local lastPart = parts[#parts]
        local num = tonumber(lastPart)
        if num and num > 0 then
            currencyID = num
            parts[#parts] = nil
        end
    end

    -- Remove leading verb tokens to normalize timeframe detection
    if #parts > 0 and (parts[1] == "show" or parts[1] == "show-all-currencies" or parts[1] == "show-all" or parts[1] == "meta") then
        table.remove(parts, 1)
    end

    local timeframe = "Session" -- default
    local tfMap = {
        ["this-session"] = "Session",
        ["session"] = "Session",
        ["today"] = "Day",
        ["prv-day"] = "PrvDay",
        ["this-week"] = "Week",
        ["week"] = "Week",
        ["prv-week"] = "PrvWeek",
        ["this-month"] = "Month",
        ["month"] = "Month",
        ["prv-month"] = "PrvMonth",
        ["this-year"] = "Year",
        ["year"] = "Year",
        ["prv-year"] = "PrvYear",
        ["total"] = "Total",
    }

    if #parts > 0 then
        local key = parts[1]
        if tfMap[key] then
            timeframe = tfMap[key]
        else
            -- Fallback: substring search across remaining text
            local joined = table.concat(parts, " ")
            for k, v in pairs(tfMap) do
                if string.find(joined, k, 1, true) then
                    timeframe = v
                    break
                end
            end
        end
    end

    return timeframe, currencyID
end

-- Map internal timeframe keys to localized display labels
local function CT_GetTimeframeLabel(tf)
    -- Prefer existing UI tab labels where possible
    local map = {
        Session = "This Session",
        Day = "Today",
        PrvDay = "Prv. Day",
        Week = "This Week",
        PrvWeek = "Prv. Week",
        Month = "This Month",
        PrvMonth = "Prv. Month",
        Year = "This Year",
        PrvYear = "Prv. Year",
        Total = "Total",
    }
    local key = map[tf] or tf
    local LL = CT_GetL()
    return (LL and LL[key]) or key
end

-- Handle /ct show* commands
function CurrencyTracker:ShowCurrencyData(command)
    local timeframe, currencyID = self:ParseShowCommand(command)

    if (command or ""):find("^%s*show%-all%-currencies") then
        local verbose = (command or ""):find("verbose") ~= nil
        self:PrintMultipleCurrencies(timeframe, verbose)
        return
    end

    if not currencyID then
        if self.DataManager and self.DataManager.LoadCurrencySelection then
            currencyID = self.DataManager:LoadCurrencySelection()
        end
    end

    if not currencyID then
        print("No currency selected. Usage: /ct show <timeframe> [currencyid]")
        return
    end

    -- Whitelist filter (config-gated, default ON). Applies to /ct show.
    local function CT_IsWhitelistEnabled()
        if not EnsureSavedVariablesStructure or not GetCurrentServerAndCharacter then return true end
        local server, character = GetCurrentServerAndCharacter()
        local sv = _G.Accountant_ClassicSaveData
        if not (sv and sv[server] and sv[server][character]) then return true end
        local charData = sv[server][character]
        local opt = charData.currencyOptions and charData.currencyOptions.whitelistFilter
        if opt == nil then return true end
        return opt and true or false
    end

    if CT_IsWhitelistEnabled() then
        local wl = CurrencyTracker.Constants and CurrencyTracker.Constants.CurrencyWhitelist or nil
        if wl and #wl > 0 then
            local wlset = {}
            for _, id in ipairs(wl) do wlset[id] = true end
            if not wlset[currencyID] then
                print(string.format("Currency %d is not in whitelist (filter ON); hiding from /ct show", currencyID))
                return
            end
        end
    end

    -- Tracked filter: respect discovery tracked=false for single show as well
    local discovered = {}
    if self.Storage and self.Storage.GetDiscoveredCurrencies then
        discovered = self.Storage:GetDiscoveredCurrencies() or {}
    end
    local meta = discovered[currencyID]
    local isTracked = (meta == nil) or (meta.tracked ~= false)
    if not isTracked then
        print(string.format("Currency %d is marked untracked; use /ct discover track %d on to include", currencyID, currencyID))
        return
    end

    local data = nil
    if self.Storage and self.Storage.GetCurrencyData then
        data = self.Storage:GetCurrencyData(currencyID, timeframe)
    elseif self.DataManager and self.DataManager.GetCurrencyData then
        data = self.DataManager:GetCurrencyData(currencyID, timeframe)
    end

    self:PrintCurrencyData(currencyID, timeframe, data or { income = 0, outgoing = 0, net = 0, transactions = {} })
end

-- Print a single currency's data, resolving localized names and source labels
function CurrencyTracker:PrintCurrencyData(currencyID, timeframe, data)
    local currencyInfo = self.DataManager and self.DataManager:GetCurrencyInfo(currencyID) or nil
    local currencyName = (currencyInfo and currencyInfo.name) or ("Currency " .. tostring(currencyID))

    -- Localization for currency name
    if L and L[currencyName] then
        currencyName = L[currencyName]
    end

    local LL = CT_GetL()
    local headerFmt = (LL and LL["CT_HeaderFormat"]) or "=== %s (id: %s) - %s ==="
    local lblIncome = (LL and LL["CT_TotalIncome"]) or "Total Income"
    local lblOutgoing = (LL and LL["CT_TotalOutgoing"]) or "Total Outgoing"
    local lblNetChange = (LL and LL["CT_NetChange"]) or "Net Change"
    local lblTotalMax = (LL and LL["CT_LineTotalMax"]) or "TotalMax"

    print(string.format(headerFmt, currencyName, tostring(currencyID), CT_GetTimeframeLabel(tostring(timeframe))))
    print(string.format("%s: %d", lblIncome, (data and data.income) or 0))
    print(string.format("%s: %d", lblOutgoing, (data and data.outgoing) or 0))
    print(string.format("%s: %d", lblNetChange, (data and data.net) or 0))

    -- Show TotalMax from live API; treat nil/0 as Unlimited; no weekly cap shown
    if C_CurrencyInfo and C_CurrencyInfo.GetCurrencyInfo then
        local ok, ci = pcall(C_CurrencyInfo.GetCurrencyInfo, currencyID)
        if ok and type(ci) == "table" then
            local lblUnlimited = (LL and LL["CT_Unlimited"]) or "Unlimited"
            local totalCap = (ci.maxQuantity ~= nil and ci.maxQuantity) or ci.totalMax
            local totalText = (totalCap and totalCap > 0) and tostring(totalCap) or lblUnlimited
            print(string.format("%s: %s", lblTotalMax, totalText))
        end
    end

    -- Prefer a map of sources if available; fall back to transactions list
    if data and data.sources and next(data.sources) then
        local lblBySource = (LL and LL["CT_TransactionsBySource"]) or "Transactions by Source"
        print(lblBySource .. ":")
        for source, amounts in pairs(data.sources) do
            local income = (amounts and amounts.income) or (amounts and amounts.In) or 0
            local outgoing = (amounts and amounts.outgoing) or (amounts and amounts.Out) or 0
            local net = income - outgoing

            local sourceLabel = tostring(source)
            if type(source) == "number" then
                local code = source
                local token
                if code >= 0 then
                    token = CurrencyTracker.SourceCodeTokens and CurrencyTracker.SourceCodeTokens[code]
                else
                    local absCode = -code
                    token = CurrencyTracker.DestroyReasonTokens and CurrencyTracker.DestroyReasonTokens[absCode]
                end
                if token then
                    sourceLabel = (L and L[token]) or token
                else
                    sourceLabel = "S:" .. tostring(code)
                end
            end

            -- Localize string labels for custom keys (e.g., "BaselinePrime", "Unknown")
            if type(sourceLabel) == "string" and L and L[sourceLabel] then
                sourceLabel = L[sourceLabel]
            end

            local lblNet = (LL and LL["CT_LineNet"]) or "net"
            print(string.format("  %s: +%d | -%d (%s: %s%d)",
                sourceLabel,
                income,
                outgoing,
                lblNet,
                (net >= 0 and "+" or ""),
                net))
        end
    elseif data and data.transactions and #data.transactions > 0 then
        local lblBySource = (LL and LL["CT_TransactionsBySource"]) or "Transactions by Source"
        print(lblBySource .. ":")
        for _, transaction in ipairs(data.transactions) do
            local income = transaction.income or 0
            local outgoing = transaction.outgoing or 0
            local net = income - outgoing
            local label = tostring(transaction.source)
            if type(transaction.source) == "number" then
                local code = transaction.source
                local token
                if code >= 0 then
                    token = CurrencyTracker.SourceCodeTokens and CurrencyTracker.SourceCodeTokens[code]
                else
                    local absCode = -code
                    token = CurrencyTracker.DestroyReasonTokens and CurrencyTracker.DestroyReasonTokens[absCode]
                end
                if token then
                    label = (L and L[token]) or token
                else
                    label = "S:" .. tostring(code)
                end
            end
            -- Localize string labels for custom keys (e.g., "BaselinePrime", "Unknown")
            if type(label) == "string" and L and L[label] then
                label = L[label]
            end
            local lblNet = (LL and LL["CT_LineNet"]) or "net"
            print(string.format("  %s: +%d | -%d (%s: %s%d)",
                label,
                income,
                outgoing,
                lblNet,
                (net >= 0 and "+" or ""),
                net))
        end
    else
        local lblNone = (LL and LL["CT_NoTransactions"]) or "No transactions recorded."
        print(lblNone)
    end
    print("=========================")
end

-- Collect rows for multiple currencies using the exact same logic as CLI printing
-- Returns an array of rows: { id, name, income, outgoing, net, totalMax }
function CurrencyTracker:CollectMultipleCurrencies(timeframe, verbose)
    local rows = {}
    local currencies = {}
    if self.Storage and self.Storage.GetAvailableCurrencies then
        currencies = self.Storage:GetAvailableCurrencies() or {}
    elseif self.DataManager and self.DataManager.GetAvailableCurrencies then
        currencies = self.DataManager:GetAvailableCurrencies() or {}
    end

    if not currencies or #currencies == 0 then
        return rows
    end

    -- Discovery metadata for tracked filter
    local discovered = {}
    if self.Storage and self.Storage.GetDiscoveredCurrencies then
        discovered = self.Storage:GetDiscoveredCurrencies() or {}
    end

    -- Read whitelist toggle (default ON)
    local whitelistEnabled = true
    if EnsureSavedVariablesStructure and GetCurrentServerAndCharacter then
        local server, character = GetCurrentServerAndCharacter()
        local sv = _G.Accountant_ClassicSaveData
        if sv and sv[server] and sv[server][character] then
            local charData = sv[server][character]
            local opt = charData.currencyOptions and charData.currencyOptions.whitelistFilter
            if opt ~= nil then whitelistEnabled = opt and true or false end
        end
    end
    local wlset = nil
    if whitelistEnabled then
        local wl = CurrencyTracker.Constants and CurrencyTracker.Constants.CurrencyWhitelist or nil
        if wl and #wl > 0 then
            wlset = {}
            for _, id in ipairs(wl) do wlset[id] = true end
        end
    end

    for _, cid in ipairs(currencies) do
        -- Apply whitelist first (if enabled)
        if not wlset or wlset[cid] then
            local meta = discovered[cid]
            local isTracked = (meta == nil) or (meta.tracked ~= false)
            if verbose or isTracked then
                local data = self.Storage and self.Storage:GetCurrencyData(cid, timeframe) or nil
                local info = self.DataManager and self.DataManager:GetCurrencyInfo(cid) or nil
                local name = (info and info.name) or ("Currency " .. tostring(cid))
                if L and L[name] then name = L[name] end
                local income = (data and data.income) or 0
                local outgoing = (data and data.outgoing) or 0
                local net = income - outgoing

                -- Determine total max from live API
                local totalMaxText = nil
                if C_CurrencyInfo and C_CurrencyInfo.GetCurrencyInfo then
                    local ok, ci = pcall(C_CurrencyInfo.GetCurrencyInfo, cid)
                    if ok and type(ci) == "table" then
                        local lblUnlimited = (CT_GetL() and CT_GetL()["CT_Unlimited"]) or "Unlimited"
                        local totalCap = (ci.maxQuantity ~= nil and ci.maxQuantity) or ci.totalMax
                        totalMaxText = (totalCap and totalCap > 0) and tostring(totalCap) or lblUnlimited
                    end
                end

                table.insert(rows, {
                    id = cid,
                    name = name,
                    income = income,
                    outgoing = outgoing,
                    net = net,
                    totalMax = totalMaxText,
                })
            end
        end
    end

    table.sort(rows, function(a, b)
        if a.name == b.name then return a.id < b.id end
        return tostring(a.name) < tostring(b.name)
    end)

    return rows
end

-- Print a summary across all currencies for a timeframe
function CurrencyTracker:PrintMultipleCurrencies(timeframe, verbose)
    local rows = self:CollectMultipleCurrencies(timeframe, verbose)
    if not rows or #rows == 0 then
        local LL = CT_GetL()
        local lblNoData = (LL and LL["CT_NoCurrencyData"]) or "No currency data available."
        print(lblNoData)
        return
    end

    do
        local LL = CT_GetL()
        local headerFmt = (LL and LL["CT_AllCurrenciesHeader"]) or "=== All Currencies - %s ==="
        print(string.format(headerFmt, CT_GetTimeframeLabel(tostring(timeframe))))
    end
    local LL = CT_GetL()
    local lblIncome = (LL and LL["CT_LineIncome"]) or "Income"
    local lblOutgoing = (LL and LL["CT_LineOutgoing"]) or "Outgoing"
    local lblNet = (LL and LL["CT_LineNet"]) or "Net"
    local lblTotalMax = (LL and LL["CT_LineTotalMax"]) or "TotalMax"

    for _, row in ipairs(rows) do
        local output = string.format("%s (id=%d): %s %d | %s %d | %s %s%d",
            row.name, row.id,
            lblIncome, row.income or 0,
            lblOutgoing, row.outgoing or 0,
            lblNet, ((row.net or 0) >= 0 and "+" or ""),
            row.net or 0)
        if row.totalMax then
            output = output .. string.format(" | %s %s", lblTotalMax, row.totalMax)
        end
        print(output)
    end
    print("=========================")
end

function CurrencyTracker:SetNearCapAlert(args)
    local enable = args.enable == "true" or args.enable == nil
    local capPercent = tonumber(args.cap_percent) or 0.9
    local timeVisibleSec = tonumber(args.time_visible_sec) or 3
    local fadeDurationSec = tonumber(args.fade_duration_sec) or 0.8

    if not self.currencyOptions then self.currencyOptions = {} end
    if not self.currencyOptions.nearCapAlert then self.currencyOptions.nearCapAlert = {} end

    self.currencyOptions.nearCapAlert.enable = enable
    self.currencyOptions.nearCapAlert.capPercent = capPercent
    self.currencyOptions.nearCapAlert.timeVisibleSec = timeVisibleSec
    self.currencyOptions.nearCapAlert.fadeDurationSec = fadeDurationSec

    if not args.enable and not args.cap_percent and not args.time_visible_sec and not args.fade_duration_sec then
        print("Current near-cap alert settings:")
        print(string.format("  enable: %s", tostring(self.currencyOptions.nearCapAlert.enable)))
        print(string.format("  cap_percent: %.2f", self.currencyOptions.nearCapAlert.capPercent))
        print(string.format("  time_visible_sec: %d", self.currencyOptions.nearCapAlert.timeVisibleSec))
        print(string.format("  fade_duration_sec: %.2f", self.currencyOptions.nearCapAlert.fadeDurationSec))
    end
end

-- Print help for commands
function CurrencyTracker:ShowHelp()
    print("CurrencyTracker Commands:")
    print("  /ct show this-session [currencyid] - Show currency data for current session")
    print("  /ct show today [currencyid] - Show currency data for today")
    print("  /ct show prv-day [currencyid] - Show currency data for previous day")
    print("  /ct show this-week [currencyid] - Show currency data for this week")
    print("  /ct show prv-week [currencyid] - Show currency data for previous week")
    print("  /ct show this-month [currencyid] - Show currency data for this month")
    print("  /ct show prv-month [currencyid] - Show currency data for previous month")
    print("  /ct show this-year [currencyid] - Show currency data for this year")
    print("  /ct show prv-year [currencyid] - Show currency data for previous year")
    print("  /ct show total [currencyid] - Show currency data for total period")
    print("  /ct show-all-currencies this-session - Show all tracked currencies summary for current session")
    print("  /ct show-all-currencies today - Show all tracked currencies summary for today")
    print("  /ct show-all-currencies prv-day - Show all tracked currencies summary for previous day")
    print("  /ct show-all-currencies this-week - Show all tracked currencies summary for this week")
    print("  /ct show-all-currencies prv-week - Show all tracked currencies summary for previous week")
    print("  /ct show-all-currencies this-month - Show all tracked currencies summary for this month")
    print("  /ct show-all-currencies prv-month - Show all tracked currencies summary for previous month")
    print("  /ct show-all-currencies this-year - Show all tracked currencies summary for this year")
    print("  /ct show-all-currencies prv-year - Show all tracked currencies summary for previous year")
    print("  /ct show-all-currencies total - Show all tracked currencies summary for total period")
    print("  /ct show-all this-session - Alias of show-all-currencies for current session")
    print("  /ct show-all today - Alias of show-all-currencies for today")
    print("  /ct show-all prv-day - Alias of show-all-currencies for previous day")
    print("  /ct show-all this-week - Alias of show-all-currencies for this week")
    print("  /ct show-all prv-week - Alias of show-all-currencies for previous week")
    print("  /ct show-all this-month - Alias of show-all-currencies for this month")
    print("  /ct show-all prv-month - Alias of show-all-currencies for previous month")
    print("  /ct show-all this-year - Alias of show-all-currencies for this year")
    print("  /ct show-all prv-year - Alias of show-all-currencies for previous year")
    print("  /ct show-all total - Alias of show-all-currencies for total period")
    print("  Tip: append 'verbose' to include untracked currencies in the summary (e.g., /ct show-all total verbose)")
    print("  /ct debug on|off - Toggle in-game debug logging for currency events")
    print("  /ct status - Show system status")
    print("  /ct ui - Open the standalone Currency Tracker UI window")
    print("  /ct discover list - List dynamically discovered currencies")
    print("  /ct discover track <id> [on|off] - Track or untrack a discovered currency")
    print("  /ct discover clear - Clear discovered currencies")
    print("  /ct repair init - Reset currency tracker storage for this character (does not touch gold)")
    print("  /ct repair migrate-zero - Move numeric source 0 into 'BaselinePrime' across all timeframes (cosmetic)")
    print("  /ct repair adjust <id> <delta> [source] - Apply a signed correction across aggregates")
    print("  /ct repair remove <id> <amount> <source> (income|outgoing) - Remove recorded amounts across aggregates")
    print("  /ct repair baseline preview - Compare AC-CT Total with live amounts and list mismatches")
    print("  /ct repair baseline - Apply Total-only corrections to match live amounts (same checks as preview)")
    print("  /ct repair negative-sources preview - Preview removal of negative source keys and baseline reduction")
    print("  /ct repair negative-sources - Apply removal of negative source keys and baseline reduction")
    print("  /ct meta show <timeframe> <id> - Inspect raw gain/lost source counts for a currency")
    print("  /ct get-currency-info <currencyId> - Dump C_CurrencyInfo fields for the given currency ID (debug)")
    print("  /ct set-paras near-cap-warning [enable=true|false] [cap_percent=0.9] [time_visible_sec=3] [fade_duration_sec=0.8]")
    print("  /ct set whitelist [on|off] - Toggle whitelist filter for show/show-all (per-character, default ON)")
end

