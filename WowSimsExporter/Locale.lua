-- Locale loader for WowSimsExporter
local addonName, Env = ...

local L = {}

-- Get locale
local locale = GetLocale()

-- Load locale file
if locale == "zhCN" then
    if _G.WowSimsExporterLocale and _G.WowSimsExporterLocale.zhCN then
        L = _G.WowSimsExporterLocale.zhCN
    end
end

-- Fallback function
local function GetLocalizedString(key, ...)
    if L[key] then
        if select("#", ...) > 0 then
            return L[key]:format(...)
        else
            return L[key]
        end
    end
    -- Return key as fallback if not found
    if select("#", ...) > 0 then
        return key:format(...)
    else
        return key
    end
end

-- Export locale function
Env.L = GetLocalizedString

