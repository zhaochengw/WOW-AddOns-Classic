-- $Id: Constants.lua 81 2022-03-24 14:15:10Z arithmandar $
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
private.addon_name = "Atlas_DungeonLocs"
private.category = "Dungeon Locations"

local constants = {}
private.constants = constants

constants.defaults = {
	profile = {
		all_faction = true,
	},
}

constants.events = {}
