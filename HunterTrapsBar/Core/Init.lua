------------------------------------------------------------
-- HunterTrapsBar (V2) - Core/Init.lua
-- Clean rewrite foundation
------------------------------------------------------------

local ADDON_NAME = ...
-- HARD STOP: do NOT even create the addon table unless we are a Hunter.
do
    local _, class = UnitClass("player")
    if class ~= "HUNTER" then
        return
    end
end

HunterTrapsBar = HunterTrapsBar or {}
local HTB = HunterTrapsBar

HTB.VERSION = "5.0.0"
HTB.DB_VERSION = 2

-- Simple debug toggle (off by default)
HTB.DEBUG = false
local function dprint(...)
    if HTB.DEBUG then
        print("|cff33ff99HTB|r", ...)
    end
end

-- Defaults (small for v0.1 foundation)
local function GetDefaults()
    return {
        version = HTB.DB_VERSION,
        locked = true, -- locked by default for V2
        point = { "CENTER", "UIParent", "CENTER", 0, 0 },
        scale = 1.0,
        borders = true,
    }
end

local function CopyMissing(src, dst)
    for k, v in pairs(src) do
        if dst[k] == nil then
            if type(v) == "table" then
                dst[k] = {}
                CopyMissing(v, dst[k])
            else
                dst[k] = v
            end
        elseif type(v) == "table" and type(dst[k]) == "table" then
            CopyMissing(v, dst[k])
        end
    end
end

function HTB:InitDB()
    if type(HunterTrapsBarDB) ~= "table" then
        HunterTrapsBarDB = GetDefaults()
        dprint("DB created")
    else
        local defaults = GetDefaults()
        CopyMissing(defaults, HunterTrapsBarDB)

        -- If we ever need migrations later, this is where they go.
        if HunterTrapsBarDB.version ~= HTB.DB_VERSION then
            HunterTrapsBarDB.version = HTB.DB_VERSION
        end
        dprint("DB loaded")
    end

    self.DB = HunterTrapsBarDB
end

-- Bootstrap event frame
HTB.EventFrame = CreateFrame("Frame")
HTB.EventFrame:RegisterEvent("ADDON_LOADED")
HTB.EventFrame:RegisterEvent("PLAYER_LOGIN")

HTB.EventFrame:SetScript("OnEvent", function(_, event, arg1)
    if event == "ADDON_LOADED" and arg1 == "HunterTrapsBar" then
        HTB:InitDB()
        -- Create the bar immediately once DB exists
        if HTB.CreateBar then
            HTB:CreateBar()
        end
        return
    end

    if event == "PLAYER_LOGIN" then
        -- Apply saved placement once UI is fully ready
        if HTB.ApplyLayout then
            HTB:ApplyLayout()
        end
    end
end)
