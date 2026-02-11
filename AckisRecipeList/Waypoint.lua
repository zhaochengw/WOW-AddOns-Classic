--[[
Copyright (c) 2009 - 2012 Ackis <John Pasula>
All rights reserved by the original author Ackis.
]]


-- ----------------------------------------------------------------------------
-- Localized Lua globals.
-- ----------------------------------------------------------------------------

local table = _G.table

local pairs = _G.pairs

-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local FOLDER_NAME, private = ...

local LibStub = _G.LibStub
local addon = LibStub("AceAddon-3.0"):GetAddon(private.addon_name)
local L = LibStub("AceLocale-3.0"):GetLocale(private.addon_name)
local UNKNOWN = L["Unknown"] or "Unknown"
local PARENS_TEMPLATE = _G.PARENS_TEMPLATE or "(%s)"

-- ----------------------------------------------------------------------------
-- Constants.
-- ----------------------------------------------------------------------------
local ActiveWaypoints = {}

-- Clears all the icons from the world map and the mini-map
function addon:ClearWaypoints()
    if not _G.TomTom or not _G.TomTom.RemoveWaypoint then
        return
    end

    while #ActiveWaypoints > 0 do
        _G.TomTom:RemoveWaypoint(table.remove(ActiveWaypoints))
    end
end

local WAYPOINT_ENTITIES = {}

local function AddAllWaypoints()
    local recipe_list = private.recipe_list
    local sorted_recipes = addon.sorted_recipes
    local editbox_text = addon.Frame.search_editbox:GetText()

    -- Scan through all recipes to display, and add the vendors to a list to get their acquire info
    for index = 1, #sorted_recipes do
        local recipe = recipe_list[sorted_recipes[index]]
        local matches_search = true

        if recipe:IsVisible() then
            for acquireType, acquireData in recipe:AcquirePairs() do
                for sourceID, sourceData in pairs(acquireData) do
                    if acquireType == private.AcquireTypes.Reputation then
                        for level, levelData in pairs(sourceData) do
                            for vendorID in pairs(levelData) do
                                local entity = acquireType:GetWaypointEntity(vendorID, recipe)
                                if entity then
                                    entity.acquire_type = acquireType
                                    WAYPOINT_ENTITIES[entity] = recipe
                                end
                            end
                        end
                    else
                        local entity = acquireType:GetWaypointEntity(sourceID, recipe)
                        if entity then
                            entity.acquire_type = acquireType
                            entity.reference_id = sourceID
                            WAYPOINT_ENTITIES[entity] = recipe
                        end
                    end
                end
            end
        end
    end
end

-- Replace the TomTom waypoint icon with the icon for the profession.
local function SetWaypointIcon(uid, ...)
    local map_children = { ... }

    for index = 1, #map_children do
        local child = map_children[index]

        if child.point and child.point.uid == uid then
            child.icon:SetTexture(private.CurrentProfession:WaypointIconTexture())
            break
        end
    end
end

local HEXCOLOR_TEXT_FORMAT = "|cff%s%s|r"

-- Adds mini-map and world map icons with tomtom.
-- Expected result: Icons are added to the world map and mini-map.
-- Input: An optional recipe ID, acquire ID, and location ID.
-- Output: Points are added to the maps
function addon:AddWaypoint(recipe, targetAcquireType, location, npcID)
    if not _G.TomTom then
        addon:Debug("TomTom not loaded. Aborting waypoint addition.")
        return
    end
    local useWorldmap = addon.db.profile.worldmap
    local useMinimap = addon.db.profile.minimap

    if not useWorldmap and not useMinimap then
        return
    end
    table.wipe(WAYPOINT_ENTITIES)

    if recipe then
        for acquireType, acquireData in recipe:AcquirePairs() do
            if not targetAcquireType or acquireType == targetAcquireType then
                for sourceID, sourceData in pairs(acquireData) do
                    if acquireType == private.AcquireTypes.Reputation then
                        for level, levelData in pairs(sourceData) do
                            for vendorID in pairs(levelData) do
                                local entity = acquireType:GetWaypointEntity(vendorID, recipe)
                                if entity then
                                    if not location or entity.Location == location then
                                        entity.acquire_type = acquireType
                                        entity.Location = entity.Location or location

                                        WAYPOINT_ENTITIES[entity] = recipe
                                    else
                                        addon:Debug("Failed location check.")
                                    end
                                end
                            end
                        end
                    else
                        if not npcID or sourceID == npcID then
                            local entity = acquireType:GetWaypointEntity(npcID or sourceID, recipe)
                            if entity then
                                if not location or entity.Location == location then
                                    entity.acquire_type = acquireType
                                    entity.Location = entity.Location or location
                                    entity.reference_id = sourceID

                                    WAYPOINT_ENTITIES[entity] = recipe
                                else
                                    addon:Debug("Failed location check.")
                                end
                            else
                                addon:Debug("We have no entity")
                            end
                        end
                    end
                end
            end
        end
    elseif addon.db.profile.autoscanmap then
        AddAllWaypoints()
    end

    for entity, recipe in pairs(WAYPOINT_ENTITIES) do
        local entityLocation = entity.Location
        if entityLocation then
            local acquireType = entity.acquire_type
            local entityName = entity.name or (entity.acquire_type == private.AcquireTypes.Quest and private.quest_names[entity.reference_id]) or UNKNOWN
            local _, _, _, qualityColor = _G.GetItemQualityColor(recipe:QualityID())
            local coloredAcquireTypeName = HEXCOLOR_TEXT_FORMAT:format(acquireType:ColorData().hex, acquireType:Name())
            local coloredEntityName = HEXCOLOR_TEXT_FORMAT:format(acquireType:ColorData().hex, entityName)
            local coloredRecipeName = _G.PARENS_TEMPLATE:format(("|c%s%s|r"):format(qualityColor, recipe:LocalizedName()))
            local waypointName = ("%s: %s %s\n%s"):format(coloredAcquireTypeName, coloredEntityName, coloredRecipeName, entityLocation:LocalizedName())

            -- Unset these - they're only needed for the waypoint system and shouldn't persist beyond.
            entity.acquire_type = nil
            entity.reference_id = nil

            -- Try to create waypoint for all locations, with fallback to chat print
            local coordX = entity.coord_x
            local coordY = entity.coord_y
            local waypointLocation = entityLocation

            local entranceX, entranceY = entityLocation:EntranceCoordinates()
            if entranceX > 0 and entranceY > 0 then
                waypointLocation = entityLocation:Parent()
                coordX = entranceX
                coordY = entranceY
            end

            local waypointCreated = false
            
            if coordX and coordY then
                local ok, waypoint = pcall(_G.TomTom.AddWaypoint, _G.TomTom, waypointLocation:MapID(), coordX / 100, coordY / 100, {
                    crazy = true,
                    title = waypointName,
                    persistent = nil,
                    minimap = true,
                    world = true
                })

                if ok and waypoint then
                    table.insert(ActiveWaypoints, waypoint)

                    SetWaypointIcon(waypoint, _G.Minimap:GetChildren())

                    if _G.TomTomMapOverlay then
                        SetWaypointIcon(waypoint, _G.TomTomMapOverlay:GetChildren())
                    end
                    waypointCreated = true
                elseif not ok then
                    -- TomTom failed to create waypoint, likely due to invalid MapID or coordinates
                    addon:Debug("TomTom waypoint creation failed: %s", waypoint or "unknown error")
                end
            else
                addon:Debug("No coordinates provided for recipe %s (ID %d).", recipe:LocalizedName(), recipe:SpellID())
            end

            -- Fallback: print to chat if waypoint creation failed
            if not waypointCreated then
                self:Print(waypointName)
            end
        else
                self:Debug("No location match for recipe %s (ID %d).", recipe:LocalizedName(), recipe:SpellID())
        end
    end
end
