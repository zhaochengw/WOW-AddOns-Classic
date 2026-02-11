-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local FOLDER_NAME, private = ...

local LibStub = _G.LibStub
local addon = LibStub("AceAddon-3.0"):GetAddon(private.addon_name)
local L = LibStub("AceLocale-3.0"):GetLocale(private.addon_name)

-- ----------------------------------------------------------------------------
-- Imports.
-- ----------------------------------------------------------------------------
local Z = private.ZONE_NAMES

function addon:InitDiscoveries()
    local function AddDiscovery(identifier, location, coordX, coordY, faction)
        return private.AcquireTypes.Discovery:AddEntity(addon, {
            coord_x = coordX,
            coord_y = coordY,
            faction = faction,
            identifier = identifier,
            item_list = {},
            locationName = location,
            name = L[identifier],
        })
    end

    AddDiscovery("DISCOVERY_AUTOLEARN")
    AddDiscovery("DISCOVERY_SHADOWLANDS")

    self.InitDiscoveries = nil
end

