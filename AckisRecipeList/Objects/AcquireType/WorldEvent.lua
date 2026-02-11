-- ----------------------------------------------------------------------------
-- Localized Lua globals.
-- ----------------------------------------------------------------------------

-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local FOLDER_NAME, private = ...

private.RegisterAcquireType({
	-- ----------------------------------------------------------------------------
	-- Data.
	-- ----------------------------------------------------------------------------
	_colorData = { hex = "80590e", r = 0.50, g = 0.35, b = 0.05 },
	_hasCoordinates = true,
	_hasEntities = true,
	_label = "WORLD_EVENT",
	_name = _G.GetCategoryInfo(155),
	-- ----------------------------------------------------------------------------
	-- Methods.
	-- ----------------------------------------------------------------------------
	_func_expand_list_entry = function(self, entry_index, entry_type, parent_entry, identifier, info, recipe, hide_location, hide_type)
		local color_hex = self:ColorData().hex
		local entry = private.CreateListEntry(entry_type, parent_entry, recipe)
		entry:SetText("%s%s %s",
			self.EntryPadding,
			hide_type and "" or private.SetTextColor(color_hex, self:Name()) .. ":",
			private.SetTextColor(color_hex, self:GetEntity(identifier).name))

		return private.list_frame:InsertEntry(entry, entry_index, true)
	end,
	_func_insert_tooltip_text = function(self, recipe, identifier, localizedLocationName, acquire_info, addline_func)
		local color_data = self:ColorData()
		addline_func(0, -1, 0, self:Name(), color_data, self:GetEntity(identifier).name, color_data)
	end,
})
