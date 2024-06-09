-- $Id: Constants.lua 153 2022-11-12 08:09:44Z arithmandar $
-----------------------------------------------------------------------
-- Upvalued Lua API.
-----------------------------------------------------------------------
-- Functions
local _G = getfenv(0)
-- Libraries
-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local FOLDER_NAME, private = ...
private.addon_name = "WorldMapTrackingEnhanced"

local LibStub = _G.LibStub

local constants = {}
private.constants = constants

constants.defaults = {
	profile = {
		enableModules = {
			['*'] = true,
		},
		useSeparator = true,
		showOnLeft = false,
		independantButton = false,
	},
}

constants.events = {
--	"CLOSE_WORLD_MAP",
}
