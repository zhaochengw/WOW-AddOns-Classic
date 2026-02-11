-- ----------------------------------------------------------------------------
-- Localized Lua globals.
-- ----------------------------------------------------------------------------

-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local FOLDER_NAME, private = ...

-- ----------------------------------------------------------------------------
-- Imports.
-- ----------------------------------------------------------------------------
local BASIC_COLORS = private.BASIC_COLORS

private.RegisterAcquireType({
	-- ----------------------------------------------------------------------------
	-- Data.
	-- ----------------------------------------------------------------------------
	_colorData = { hex = "faeb98", r = 0.98, g = 0.92, b = 0.59 },
	_hasCoordinates = false,
	_hasEntities = false,
	_label = "ACHIEVEMENT",
	_name = _G.ACHIEVEMENTS,
	-- ----------------------------------------------------------------------------
	-- Methods.
	-- ----------------------------------------------------------------------------
	_func_expand_list_entry = function(self, entry_index, entry_type, parent_entry, identifier, info, recipe, hide_location, hide_type)
		local _, achievement_name = _G.GetAchievementInfo(identifier)
		local entry = private.CreateListEntry(entry_type, parent_entry, recipe)
		entry:SetText("%s%s %s",
			self.EntryPadding,
			hide_type and "" or private.SetTextColor(self:ColorData().hex, _G.ACHIEVEMENTS) .. ":",
			private.SetTextColor(BASIC_COLORS.normal.hex, achievement_name))

		return private.list_frame:InsertEntry(entry, entry_index, true)
	end,
	_func_insert_tooltip_text = function(self, recipe, identifier, localizedLocationName, acquire_info, addline_func)
		local _, achievement_name, _, _, _, _, _, achievement_desc = _G.GetAchievementInfo(identifier)

		-- The recipe is an actual reward from an achievement if flagged - else we're just using the text to describe how to get it.
		if recipe:HasFilter("common1", "ACHIEVEMENT") then
			addline_func(0, -1, false, _G.ACHIEVEMENTS, self:ColorData(), achievement_name, BASIC_COLORS.normal)
		end
		addline_func(0, -1, false, achievement_desc, self:ColorData())
	end,
})
