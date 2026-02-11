-- ----------------------------------------------------------------------------
-- Localized Lua globals.
-- ----------------------------------------------------------------------------

-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local FOLDER_NAME, private = ...

local LibStub = _G.LibStub
local L = LibStub("AceLocale-3.0"):GetLocale(private.addon_name)

private.RegisterAcquireType({
	-- ----------------------------------------------------------------------------
	-- Data.
	-- ----------------------------------------------------------------------------
	_colorData = { hex = "ff9500", r = 1, g = 0.58, b = 0 },
	_hasCoordinates = false,
	_hasEntities = true,
	_label = "DISCOVERY",
	_name = L["Discovery"],
	-- ----------------------------------------------------------------------------
	-- Methods.
	-- ----------------------------------------------------------------------------
	_func_expand_list_entry = function(self, entry_index, entry_type, parent_entry, identifier, info, recipe, hide_location, hide_type)
		local entry = private.CreateListEntry(entry_type, parent_entry, recipe)
		entry:SetText(self.EntryPadding .. private.SetTextColor(self:ColorData().hex, self:GetEntity(identifier).name))

		return private.list_frame:InsertEntry(entry, entry_index, true)
	end,
	_func_insert_tooltip_text = function(self, recipe, identifier, localizedLocationName, acquire_info, addline_func)
		addline_func(0, -1, false, self:GetEntity(identifier).name, self:ColorData())
	end,
})
