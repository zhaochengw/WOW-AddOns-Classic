-------------------------------------------------------------------------------
-- Module namespace.
-------------------------------------------------------------------------------
local FOLDER_NAME, private = ...

local addon = private.addon
if not addon then
	return
end

local module = addon:GetModule(private.module_name)
local L = _G.LibStub("AceLocale-3.0"):GetLocale(addon.constants.addon_name)

-----------------------------------------------------------------------
-- What we _really_ came here to see...
-----------------------------------------------------------------------
function module:InitializeDiscoveries()
	local function AddDiscovery(identifier, locationName, coordX, coordY, faction)
		addon.AcquireTypes.Discovery:AddEntity(module, {
			coord_x = coordX,
			coord_y = coordY,
			faction = faction,
			identifier = identifier,
			item_list = {},
			locationName = locationName,
			name = L[identifier],
		})
	end

	AddDiscovery("DISCOVERY_BS_PANDARIA")
	AddDiscovery("DISCOVERY_BS_WEAP_PANDARIA")
	AddDiscovery("DISCOVERY_BS_INGOT_PANDARIA")
	AddDiscovery("DISCOVERY_BS_BFA")

	self.InitializeDiscoveries = nil
end
