-- ----------------------------------------------------------------------------
-- Localized Lua globals.
-- ----------------------------------------------------------------------------

local pairs = _G.pairs

-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local FOLDER_NAME, private = ...

private.RegisterAcquireType({
	-- ----------------------------------------------------------------------------
	-- Data.
	-- ----------------------------------------------------------------------------
	_colorData = { hex = "73b7ff", r = 0.45, g = 0.71, b = 1 },
	_hasCoordinates = false,
	_hasEntities = true,
	_label = "CUSTOM",
	_name = _G.MISCELLANEOUS,
	__waypoint_checks = {
		maptrainer = "TRAINER",
		mapvendor = "VENDOR",
		mapmixed = "TRAINER & VENDOR",
		mapquest = "QUEST",
	},
	__waypoint_filters = {
		"INSTANCE",
		"RAID",
		"WORLD_DROP",
		"MOB_DROP",
	},
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
	_func_waypoint_target = function(self, id_num, recipe)
		local profile = private.db.profile

		for field, flag in pairs(self.__waypoint_checks) do
			if profile[field] and recipe:HasFilter("common1", flag) then
				return self:GetEntity(id_num)
			end
		end

		for index = 1, #self.__waypoint_filters do
			if recipe:HasFilter("common1", self.__waypoint_filters[index]) then
				return self:GetEntity(id_num)
			end
		end
	end,
})
