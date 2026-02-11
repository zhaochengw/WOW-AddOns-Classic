-------------------------------------------------------------------------------
-- Module namespace.
-------------------------------------------------------------------------------
local FOLDER_NAME, private = ...

local addon = private.addon
if not addon then
	return
end

local constants = addon.constants
local module = addon:GetModule(private.module_name)

local LibStub = _G.LibStub
local L = LibStub("AceLocale-3.0"):GetLocale(constants.addon_name)

-------------------------------------------------------------------------------
-- What we're really here for.
-------------------------------------------------------------------------------
module.ITEM_FILTER_TYPES = {
	-- Nothing yet.
}

-- Nothing yet.
--function module:InitializeItemFilters(parent_panel)
--	self.InitializeItemFilters = nil
--end
