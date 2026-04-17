--[[
    Ackis Recipe List - Waypoint
    Waypoint system with TomTom integration and HereBeDragons fallback

    Provides:
    - TomTom integration when available
    - Standalone minimap/worldmap pins via HereBeDragons-Pins
    - Map ID resolution via HereBeDragons internal database
    - Auto-scan waypoints for current zone
]]

-- ============================================================================
-- Upvalued Lua API
-- ============================================================================
local pairs = _G.pairs
local ipairs = _G.ipairs
local strformat = _G.string.format
local wipe = _G.table.wipe
local GetTime = _G.GetTime
local pcall = _G.pcall

-- ============================================================================
-- AddOn Namespace
-- ============================================================================
local FOLDER_NAME, private = ...

local LibStub = _G.LibStub
local addon = LibStub("AceAddon-3.0"):GetAddon(private.addon_name)
local L = LibStub("AceLocale-3.0"):GetLocale(private.addon_name)

-- HereBeDragons
local HBD = LibStub("HereBeDragons-2.0")
local HBDPins = LibStub("HereBeDragons-Pins-2.0")

-- TomTom integration
local TomTom = _G.TomTom

-- ============================================================================
-- Constants
-- ============================================================================
local UNKNOWN = L["Unknown"] or "Unknown"
local PARENS_TEMPLATE = _G.PARENS_TEMPLATE or "(%s)"
local HEX_FORMAT = "|cff%s%s|r"

-- Waypoint storage
local activeWaypoints = {}

-- Auto-scan state
local lastAutoScanTime = 0
local AUTO_SCAN_THROTTLE = 2 -- seconds

-- ============================================================================
-- Map ID Resolution
-- ============================================================================

local function ResolveMapID(location)
    if not location then
        return nil
    end

    local storedMapID = location:MapID()
    if storedMapID and storedMapID > 0 then
        local name = HBD:GetLocalizedMap(storedMapID)
        if name then
            return storedMapID
        end
    end

    local zoneName = location:LocalizedName()
    if not zoneName then
        return nil
    end

    local lowerZoneName = zoneName:lower()
    local allMapIDs = HBD:GetAllMapIDs()

    for _, mapID in ipairs(allMapIDs) do
        local mapName = HBD:GetLocalizedMap(mapID)
        if mapName and mapName:lower() == lowerZoneName then
            return mapID
        end
    end

    local parent = location:Parent()
    while parent do
        local parentMapID = parent:MapID()
        if parentMapID and parentMapID > 0 then
            local name = HBD:GetLocalizedMap(parentMapID)
            if name then
                return parentMapID
            end
        end
        parent = parent:Parent()
    end

    return nil
end

-- ============================================================================
-- Pin Factory (for standalone mode)
-- ============================================================================

local function CreatePin(title)
    local pin = _G.CreateFrame("Button", nil, _G.Minimap)
    pin:SetSize(16, 16)
    pin.title = title or ""

    local texture = pin:CreateTexture(nil, "BACKGROUND")
    texture:SetTexture(136815)
    texture:SetAllPoints()

    pin:SetHighlightTexture(136815)
    pin:GetHighlightTexture():SetVertexColor(1, 1, 0, 0.5)

    pin:SetScript("OnEnter", function(self)
        _G.GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        _G.GameTooltip:SetText(self.title, 1, 1, 1)
        _G.GameTooltip:Show()
    end)

    pin:SetScript("OnLeave", function()
        _G.GameTooltip:Hide()
    end)

    pin:RegisterForClicks("RightButtonUp")

    return pin
end

-- ============================================================================
-- Public API
-- ============================================================================

function addon:RemoveWaypoint(waypoint)
    if not waypoint then return end

    if waypoint.tomtom_uid then
        if TomTom then
            TomTom:RemoveWaypoint(waypoint.tomtom_uid)
        end
    else
        HBDPins:RemoveMinimapIcon(addon, waypoint.pin)
        HBDPins:RemoveWorldMapIcon(addon, waypoint.pin)
    end

    activeWaypoints[waypoint] = nil
end

function addon:ClearWaypoints()
    for waypoint in pairs(activeWaypoints) do
        if waypoint.tomtom_uid then
            if TomTom then
                TomTom:RemoveWaypoint(waypoint.tomtom_uid)
            end
        else
            HBDPins:RemoveMinimapIcon(addon, waypoint.pin)
            HBDPins:RemoveWorldMapIcon(addon, waypoint.pin)
        end
    end
    wipe(activeWaypoints)
end

function addon:SetWaypoint(mapID, x, y, title)
    if not mapID or mapID <= 0 or not x or not y then
        return false
    end

    local waypoint = {}

    if TomTom then
        local uid = TomTom:AddWaypoint(mapID, x, y, {
            title = title,
            persistent = false,
            minimap = addon.db.profile.minimap,
            worldmap = addon.db.profile.worldmap,
        })

        if uid then
            waypoint.tomtom_uid = uid
            activeWaypoints[waypoint] = true
            return true
        end
    end

    local pin = CreatePin(title)
    waypoint.pin = pin

    if addon.db.profile.minimap then
        HBDPins:AddMinimapIconMap(addon, pin, mapID, x, y, true, true)
    end

    if addon.db.profile.worldmap then
        HBDPins:AddWorldMapIconMap(addon, pin, mapID, x, y)
    end

    activeWaypoints[waypoint] = true

    return true
end

-- ============================================================================
-- Recipe Waypoint Integration
-- ============================================================================

local waypointEntities = {}

local function CollectRecipeWaypoints(recipe, targetAcquireType, location, npcID)
    if not recipe then return end

    for acquireType, acquireData in recipe:AcquirePairs() do
        if not targetAcquireType or acquireType == targetAcquireType then
            for sourceID, sourceData in pairs(acquireData) do
                if acquireType == private.AcquireTypes.Reputation then
                    for level, levelData in pairs(sourceData) do
                        for vendorID in pairs(levelData) do
                            local entity = acquireType:GetWaypointEntity(vendorID, recipe)
                            if entity and (not location or entity.Location == location) then
                                entity.acquire_type = acquireType
                                entity.Location = entity.Location or location
                                waypointEntities[entity] = recipe
                            end
                        end
                    end
                else
                    if not npcID or sourceID == npcID then
                        local entity = acquireType:GetWaypointEntity(npcID or sourceID, recipe)
                        if entity and (not location or entity.Location == location) then
                            entity.acquire_type = acquireType
                            entity.Location = entity.Location or location
                            entity.reference_id = sourceID
                            waypointEntities[entity] = recipe
                        end
                    end
                end
            end
        end
    end
end

local function CollectAllWaypoints()
    local recipe_list = private.recipe_list

    for spellID, recipe in pairs(recipe_list) do
        if recipe:IsVisible() then
            CollectRecipeWaypoints(recipe)
        end
    end
end

local function CollectZoneWaypoints(zoneLocation, zoneName)
    if not zoneLocation then return end

    local recipe_list = private.recipe_list
    local targetZoneName = zoneName or zoneLocation:LocalizedName()

    for spellID, recipe in pairs(recipe_list) do
        if recipe:IsVisible() then
            for acquireType, acquireData in recipe:AcquirePairs() do
                for sourceID, sourceData in pairs(acquireData) do
                    if acquireType == private.AcquireTypes.Reputation then
                        for level, levelData in pairs(sourceData) do
                            for vendorID in pairs(levelData) do
                                local entity = acquireType:GetWaypointEntity(vendorID, recipe)
                                if entity and entity.Location and entity.Location:LocalizedName() == targetZoneName then
                                    entity.acquire_type = acquireType
                                    waypointEntities[entity] = recipe
                                end
                            end
                        end
                    else
                        local entity = acquireType:GetWaypointEntity(sourceID, recipe)
                        if entity and entity.Location and entity.Location:LocalizedName() == targetZoneName then
                            entity.acquire_type = acquireType
                            entity.reference_id = sourceID
                            waypointEntities[entity] = recipe
                        end
                    end
                end
            end
        end
    end
end

function addon:AddWaypoint(recipe, targetAcquireType, location, npcID)
    if not addon.db.profile.minimap and not addon.db.profile.worldmap then
        return
    end

    wipe(waypointEntities)

    if recipe then
        CollectRecipeWaypoints(recipe, targetAcquireType, location, npcID)
    elseif addon.db.profile.autoscanmap then
        CollectAllWaypoints()
    end

    for entity, recipe in pairs(waypointEntities) do
        local entityLocation = entity.Location
        local coordX = entity.coord_x
        local coordY = entity.coord_y

        if entityLocation then
            local acquireType = entity.acquire_type
            local entityName = entity.name
                or (entity.acquire_type == private.AcquireTypes.Quest and private.quest_names[entity.reference_id])
                or UNKNOWN

            local qualityColor = "ffffff"
            local ok, r, g, b, hex = pcall(_G.GetItemQualityColor, recipe:QualityID())
            if ok and hex then
                if #hex == 8 then
                    qualityColor = hex:sub(3)
                else
                    qualityColor = hex
                end
            end

            local acquireHex = acquireType:ColorData().hex
            if acquireHex and #acquireHex == 8 then
                acquireHex = acquireHex:sub(3)
            end

            local coloredType = HEX_FORMAT:format(acquireHex or "ffffff", acquireType:Name())
            local coloredName = HEX_FORMAT:format(acquireHex or "ffffff", entityName)
            local coloredRecipe = PARENS_TEMPLATE:format(HEX_FORMAT:format(qualityColor, recipe:LocalizedName()))
            local title = strformat("%s: %s %s\n%s", coloredType, coloredName, coloredRecipe, entityLocation:LocalizedName())

            entity.acquire_type = nil
            entity.reference_id = nil

            local waypointLocation = entityLocation
            local entranceX, entranceY = entityLocation:EntranceCoordinates()
            if entranceX and entranceY and entranceX > 0 and entranceY > 0 then
                waypointLocation = entityLocation:Parent()
                coordX = entranceX
                coordY = entranceY
            end

            if coordX and coordY and coordX > 0 and coordY > 0 then
                local mapID = ResolveMapID(waypointLocation)
                if mapID then
                    local x = coordX / 100
                    local y = coordY / 100
                    if not self:SetWaypoint(mapID, x, y, title) then
                        addon:Print(title)
                    end
                else
                    addon:Print(title)
                end
            else
                addon:Print(title)
            end
        end
    end
end

-- ============================================================================
-- Auto-Scan Zone Waypoints
-- ============================================================================

function addon:AutoScanZoneWaypoints()
    if not addon.db.profile.autoscanmap then
        return
    end

    if not addon.db.profile.minimap and not addon.db.profile.worldmap then
        return
    end

    local recipe_list = private.recipe_list
    if not recipe_list or not next(recipe_list) then
        return
    end

    local now = GetTime()
    if now - lastAutoScanTime < AUTO_SCAN_THROTTLE then
        return
    end
    lastAutoScanTime = now

    local playerMapID = HBD:GetPlayerZone()
    if not playerMapID then
        return
    end

    local zoneName = HBD:GetLocalizedMap(playerMapID)
    if not zoneName then
        return
    end

    local zoneLocation = private.LocationsByLocalizedName[zoneName]
    if not zoneLocation then
        return
    end

    self:ClearWaypoints()
    wipe(waypointEntities)

    CollectZoneWaypoints(zoneLocation, zoneName)

    local count = 0
    for entity, recipe in pairs(waypointEntities) do
        local entityLocation = entity.Location
        local coordX = entity.coord_x
        local coordY = entity.coord_y

        if entityLocation then
            local acquireType = entity.acquire_type
            local entityName = entity.name
                or (entity.acquire_type == private.AcquireTypes.Quest and private.quest_names[entity.reference_id])
                or UNKNOWN

            local qualityColor = "ffffff"
            local ok, r, g, b, hex = pcall(_G.GetItemQualityColor, recipe:QualityID())
            if ok and hex then
                if #hex == 8 then
                    qualityColor = hex:sub(3)
                else
                    qualityColor = hex
                end
            end

            local acquireHex = acquireType:ColorData().hex
            if acquireHex and #acquireHex == 8 then
                acquireHex = acquireHex:sub(3)
            end

            local coloredType = HEX_FORMAT:format(acquireHex or "ffffff", acquireType:Name())
            local coloredName = HEX_FORMAT:format(acquireHex or "ffffff", entityName)
            local coloredRecipe = PARENS_TEMPLATE:format(HEX_FORMAT:format(qualityColor, recipe:LocalizedName()))
            local title = strformat("%s: %s %s\n%s", coloredType, coloredName, coloredRecipe, entityLocation:LocalizedName())

            entity.acquire_type = nil
            entity.reference_id = nil

            local waypointLocation = entityLocation
            local entranceX, entranceY = entityLocation:EntranceCoordinates()
            if entranceX and entranceY and entranceX > 0 and entranceY > 0 then
                waypointLocation = entityLocation:Parent()
                coordX = entranceX
                coordY = entranceY
            end

            if coordX and coordY and coordX > 0 and coordY > 0 then
                local mapID = ResolveMapID(waypointLocation)
                if mapID then
                    local x = coordX / 100
                    local y = coordY / 100
                    if self:SetWaypoint(mapID, x, y, title) then
                        count = count + 1
                    end
                end
            end
        end
    end

    if count > 0 then
        addon:Print(L["Auto-scanned %d waypoints for %s"]:format(count, zoneName))
    end
end

-- ============================================================================
-- Event Frame for Auto-Scan
-- ============================================================================

local autoScanFrame = _G.CreateFrame("Frame")
autoScanFrame:RegisterEvent("ZONE_CHANGED")
autoScanFrame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
autoScanFrame:RegisterEvent("PLAYER_ENTERING_WORLD")

autoScanFrame:SetScript("OnEvent", function(self, event)
    if event == "PLAYER_ENTERING_WORLD" then
        _G.C_Timer.After(1, function()
            addon:AutoScanZoneWaypoints()
        end)
    else
        addon:AutoScanZoneWaypoints()
    end
end)
