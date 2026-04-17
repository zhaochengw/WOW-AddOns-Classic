--[[
    Ackis Recipe List - Utilities
    Common utility functions used across the addon
    
    Provides:
    - API compatibility wrappers (C_AddOns, C_CVar, C_Spell fallbacks)
    - Secret value protection for Midnight/Patch 12.0+
    - Safe backdrop operations with combat deferral
    - Performance utilities (frame pooling, debouncing)
    
    Supports: Classic, TBC Anniversary, Era, MoP Classic, Midnight
]]

-- ============================================================================
-- Upvalued Lua API
-- ============================================================================
local pairs = _G.pairs
local ipairs = _G.ipairs
local pcall = _G.pcall
local tonumber = _G.tonumber
local tostring = _G.tostring
local type = _G.type
local unpack = _G.unpack
local next = _G.next
local math_floor = _G.math.floor

local table = _G.table

-- ============================================================================
-- AddOn Namespace
-- ============================================================================
local FOLDER_NAME, private = ...

-- ============================================================================
-- SECRET VALUE PROTECTION (Patch 12.0+ / Midnight)
-- Combat-related APIs can return "secret values" in restricted contexts.
-- These helpers provide safe operations that won't error on secrets.
-- ============================================================================

do
    local SafeOps = {}
    private.SafeOps = SafeOps

    --- Check if a value is a secret value (Patch 12.0+ combat restriction)
    --- @param value any The value to check
    --- @return boolean True if value is a secret value
    function SafeOps.IsSecretValue(value)
        if type(_G.issecretvalue) == "function" then
            return _G.issecretvalue(value)
        end
        return false
    end

    --- Safely get a value, returning fallback if it's a secret
    --- @param value any The value to check
    --- @param fallback any The value to return if secret (default: nil)
    --- @return any The original value or fallback
    function SafeOps.SafeValue(value, fallback)
        if SafeOps.IsSecretValue(value) then
            return fallback
        end
        return value
    end

    --- Safely convert a value to number, handling secrets
    --- @param value any The value to convert
    --- @param fallback number Value to return on error (default: 0)
    --- @return number The converted number or fallback
    function SafeOps.SafeToNumber(value, fallback)
        if SafeOps.IsSecretValue(value) then
            return fallback or 0
        end
        local ok, num = pcall(tonumber, value)
        if ok and num then
            return num
        end
        return fallback or 0
    end

    --- Safely convert a value to string, handling secrets
    --- @param value any The value to convert
    --- @param fallback string Value to return on error (default: "")
    --- @return string The converted string or fallback
    function SafeOps.SafeToString(value, fallback)
        fallback = fallback or ""
        if SafeOps.IsSecretValue(value) then
            return fallback
        end
        local ok, str = pcall(tostring, value)
        if ok and str then
            return str
        end
        return fallback
    end

    --- Safely perform an arithmetic operation on a value
    --- @param value any The value to operate on
    --- @param operation function The operation function to call
    --- @param fallback any Value to return on error
    --- @return any The operation result or fallback
    function SafeOps.SafeArithmetic(value, operation, fallback)
        if SafeOps.IsSecretValue(value) then
            return fallback
        end
        local ok, result = pcall(operation, value)
        if ok then
            return result
        end
        return fallback
    end

    --- Safely compare two values, handling secrets
    --- @param a any First value
    --- @param b any Second value
    --- @return boolean|nil Comparison result, or nil if either value is secret
    function SafeOps.SafeCompare(a, b)
        if SafeOps.IsSecretValue(a) or SafeOps.IsSecretValue(b) then
            return nil
        end
        return a == b
    end
end

-- ============================================================================
-- SAFE BACKDROP UTILITY
-- Handles BackdropTemplateMixin and combat/secret value protection.
-- Defers SetBackdrop calls when frame dimensions are secret values or
-- when in combat lockdown to prevent errors.
-- ============================================================================

do
    local BackdropUtil = {}
    private.BackdropUtil = BackdropUtil

    local pendingBackdrops = {}
    local backdropUpdateFrame = nil

    local function ProcessPendingBackdrops()
        if private.InCombatLockdown() then
            return
        end

        local processed = {}
        for frame, info in pairs(pendingBackdrops) do
            if frame and frame.SetBackdrop then
                local hasValidSize = false
                local ok, result = pcall(function()
                    local w = frame:GetWidth()
                    local h = frame:GetHeight()
                    if w and h then
                        local test = w + h
                        hasValidSize = test > 0 and not private.SafeOps.IsSecretValue(test)
                    end
                end)

                if ok and hasValidSize then
                    local setOk = pcall(frame.SetBackdrop, frame, info.backdrop)
                    if setOk and info.backdrop and info.borderColor then
                        local c = info.borderColor
                        pcall(frame.SetBackdropBorderColor, frame, c[1], c[2], c[3], c[4] or 1)
                    end
                    if info.backdrop and info.bgColor then
                        local c = info.bgColor
                        pcall(frame.SetBackdropColor, frame, c[1], c[2], c[3], c[4] or 1)
                    end
                    table.insert(processed, frame)
                end
            end
        end

        for _, f in ipairs(processed) do
            pendingBackdrops[f] = nil
        end

        if backdropUpdateFrame and not next(pendingBackdrops) then
            backdropUpdateFrame:Hide()
        end
    end

    local function EnsureBackdropUpdateFrame()
        if not backdropUpdateFrame then
            backdropUpdateFrame = _G.CreateFrame("Frame")
            backdropUpdateFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
            backdropUpdateFrame:SetScript("OnEvent", ProcessPendingBackdrops)
            local elapsed = 0
            backdropUpdateFrame:SetScript("OnUpdate", function(self, delta)
                elapsed = elapsed + delta
                if elapsed >= 0.1 then
                    elapsed = 0
                    ProcessPendingBackdrops()
                end
            end)
        end
    end

    function BackdropUtil.GetPixelSize(frame)
        local size = 1
        local ok, result = pcall(function()
            if frame and frame.GetEffectiveScale then
                local scale = frame:GetEffectiveScale()
                if scale and scale > 0 then
                    size = math_floor(1 / scale + 0.5)
                    if size < 1 then size = 1 end
                end
            end
        end)
        return size
    end

    function BackdropUtil.SafeSetBackdrop(frame, backdropInfo, bgColor, borderColor)
        if not frame then return false end

        if private.InCombatLockdown() then
            EnsureBackdropUpdateFrame()
            pendingBackdrops[frame] = {
                backdrop = backdropInfo,
                bgColor = bgColor,
                borderColor = borderColor
            }
            backdropUpdateFrame:Show()
            return false
        end

        local hasValidSize = false
        local ok = pcall(function()
            local w = frame:GetWidth()
            local h = frame:GetHeight()
            if w and h then
                local test = w + h
                hasValidSize = test > 0 and not private.SafeOps.IsSecretValue(test)
            end
        end)

        if not hasValidSize then
            EnsureBackdropUpdateFrame()
            pendingBackdrops[frame] = {
                backdrop = backdropInfo,
                bgColor = bgColor,
                borderColor = borderColor
            }
            backdropUpdateFrame:Show()
            return false
        end

        if frame.SetBackdrop then
            local setOk = pcall(frame.SetBackdrop, frame, backdropInfo)
            if setOk then
                if backdropInfo and bgColor and frame.SetBackdropColor then
                    pcall(frame.SetBackdropColor, frame, bgColor[1], bgColor[2], bgColor[3], bgColor[4] or 1)
                end
                if backdropInfo and borderColor and frame.SetBackdropBorderColor then
                    pcall(frame.SetBackdropBorderColor, frame, borderColor[1], borderColor[2], borderColor[3], borderColor[4] or 1)
                end
            end
            return setOk
        end
        return false
    end

    function BackdropUtil.CreateSimpleBackdrop(bgFile, edgeFile, edgeSize, insets)
        insets = insets or { left = 0, right = 0, top = 0, bottom = 0 }
        return {
            bgFile = bgFile or [[Interface\DialogFrame\UI-DialogBox-Background]],
            edgeFile = edgeFile,
            edgeSize = edgeSize or 0,
            tile = true,
            tileSize = 16,
            insets = insets
        }
    end
end

-- ============================================================================
-- SAFE FRAME CREATION WITH BACKDROPTEMPLATE
-- ============================================================================

do
    function private.CreateFrameWithBackdrop(frameType, name, parent, template)
        local frame
        if _G.BackdropTemplateMixin then
            frame = _G.CreateFrame(frameType, name, parent, template or "BackdropTemplate")
        else
            frame = _G.CreateFrame(frameType, name, parent, template)
        end
        return frame
    end
end

-- ============================================================================
-- ORIGINAL UTILITY METHODS (preserved, with modernization)
-- ============================================================================

local function GetEffectiveExpansionID()
    return tonumber(_G.GetBuildInfo():sub(1, 1))
end
private.GetEffectiveExpansionID = GetEffectiveExpansionID

function private.SetExpansionLogo(texture, expansionLevel)
    local logo = private.EXPANSION_LOGOS and private.EXPANSION_LOGOS[expansionLevel]
    if not logo then
        if texture and texture.Hide then texture:Hide() end
        return
    end
    if logo.texture then
        texture:SetTexture(logo.texture)
        texture:Show()
    elseif logo.atlas then
        texture:SetAtlas(logo.atlas)
        texture:Show()
    else
        if texture and texture.Hide then texture:Hide() end
    end
end

function private.SetTextColor(color_code, text)
    local cc = "ffffff"
    if type(color_code) == "string" then
        local hex = color_code:match("^[0-9a-fA-F]{6}") or color_code:gsub("[^0-9a-fA-F]", ""):sub(1, 6)
        if hex and #hex == 6 then
            cc = hex
        end
    end
    return ("|cff%s%s|r"):format(cc, tostring(text or ""))
end

function private.ItemLinkToID(item_link)
    if not item_link then return end
    return tonumber(item_link:match("item:(%d+)"))
end

function private.MobGUIDToIDNum(guid)
    if not guid or type(guid) ~= "string" then return end

    if guid:find("-") then
        local _, _, _, _, _, id_num = ("-"):split(guid)
        return tonumber(id_num)
    end

    local hex = guid:gsub("^0x", "")
    if #hex >= 10 then
        return tonumber(hex:sub(6, 10), 16)
    end
    return tonumber(guid)
end

-- ============================================================================
-- PERFORMANCE: CACHED REFERENCES
-- ============================================================================

private.cachedFrames = private.cachedFrames or {}
private.cachedTextures = private.cachedTextures or {}

function private.GetCachedFrame(frameType, parent)
    local cache = private.cachedFrames[frameType]
    if not cache then
        cache = {}
        private.cachedFrames[frameType] = cache
    end

    for i, frame in ipairs(cache) do
        if frame and not frame:IsShown() then
            frame:SetParent(parent)
            frame:ClearAllPoints()
            return frame, i
        end
    end
    return nil
end

function private.ReleaseFrame(frame)
    if not frame then return end
    local frameType = frame:GetObjectType()
    local cache = private.cachedFrames[frameType]
    if cache then
        frame:Hide()
        frame:ClearAllPoints()
        frame:SetParent(_G.UIParent)
    end
end

-- ============================================================================
-- PERFORMANCE: DEBOUNCE UTILITY
-- ============================================================================

function private.CreateDebouncedCallback(delay, callback)
    local frame = _G.CreateFrame("Frame")
    local elapsed = 0
    local pending = false
    local pendingArgs = {}

    frame:SetScript("OnUpdate", function(self, delta)
        if not pending then return end
        elapsed = elapsed + delta
        if elapsed >= delay then
            elapsed = 0
            pending = false
            frame:Hide()
            callback(unpack(pendingArgs))
        end
    end)

    return function(...)
        pendingArgs = { ... }
        elapsed = 0
        pending = true
        frame:Show()
    end
end

-- ============================================================================
-- BULK TABLE OPERATIONS (performance optimized)
-- ============================================================================

do
    local wipe = table.wipe

    function private.TableClear(t)
        if wipe then
            return wipe(t)
        end
        for k in pairs(t) do
            t[k] = nil
        end
    end

    function private.TableSize(t)
        local count = 0
        for _ in pairs(t) do
            count = count + 1
        end
        return count
    end
end
