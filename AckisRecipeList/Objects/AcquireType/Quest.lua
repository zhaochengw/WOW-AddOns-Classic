-- ----------------------------------------------------------------------------
-- Localized Lua globals.
-- ----------------------------------------------------------------------------

-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local FOLDER_NAME, private = ...

local LibStub = _G.LibStub
local L = LibStub("AceLocale-3.0"):GetLocale(private.addon_name)
local UNKNOWN = L["Unknown"] or "Unknown"

-- ----------------------------------------------------------------------------
-- Imports.
-- ----------------------------------------------------------------------------
local CATEGORY_COLORS = private.CATEGORY_COLORS
local COORDINATES_FORMAT = private.COORDINATES_FORMAT

private.RegisterAcquireType({
	-- ----------------------------------------------------------------------------
	-- Data.
	-- ----------------------------------------------------------------------------
	_colorData = { hex = "dbdb2c", r = 0.86, g = 0.86, b = 0.17 },
	_hasCoordinates = true,
	_hasEntities = true,
	_label = "QUEST",
	_name = L["Quest"],
	-- ----------------------------------------------------------------------------
	-- Methods.
	-- ----------------------------------------------------------------------------
	_func_expand_list_entry = function(self, entry_index, entry_type, parent_entry, identifier, info, recipe, hide_location, hide_type)
		local quest = self:GetEntity(identifier)

		if not self.CanDisplayFaction(quest.faction) then
			return entry_index
		end

		local entry = private.CreateListEntry(entry_type, parent_entry, recipe)
		entry:SetLocation(quest.Location)
		entry:SetText("%s%s %s",
			self.EntryPadding,
			hide_type and "" or private.SetTextColor(self:ColorData().hex, self:Name()) .. ":",
			self.ColorNameByFaction(private.quest_names[identifier], quest.faction))

		entry_index = private.list_frame:InsertEntry(entry, entry_index, true)

		local coord_text = ""

		if quest.coord_x ~= 0 and quest.coord_y ~= 0 then
			coord_text = private.SetTextColor(CATEGORY_COLORS.coords.hex, COORDINATES_FORMAT:format(quest.coord_x, quest.coord_y))
		end

		if coord_text == "" and hide_location then
			return entry_index
		end

		local listEntry = private.CreateListEntry(entry_type, parent_entry, recipe)
		listEntry:SetLocation(quest.Location)
		local locName = (quest.Location and quest.Location:LocalizedName()) or UNKNOWN
		listEntry:SetText("%s%s %s",
			self.EntryPadding:rep(2),
			hide_location and "" or private.SetTextColor(CATEGORY_COLORS.location.hex, locName),
			coord_text)

		return private.list_frame:InsertEntry(listEntry, entry_index, true)
	end,
	_func_insert_tooltip_text = function(self, recipe, identifier, localizedLocationName, acquire_info, addline_func)
		local quest = self:GetEntity(identifier)
		local questLocName = (quest and quest.Location and quest.Location:LocalizedName()) or UNKNOWN

		if not quest or (localizedLocationName and questLocName ~= localizedLocationName) then
			return
		end
		local display_tip, name_color = self.GetTipFactionInfo(quest.faction)

		if not display_tip then
			return
		end
		addline_func(0, -1, false, self:Name(), self:ColorData(), private.quest_names[identifier], name_color)

		local mx, my = (quest and quest.coord_x) or 0, (quest and quest.coord_y) or 0
		if mx ~= 0 and my ~= 0 then
			addline_func(1, -2, true, questLocName, CATEGORY_COLORS.location, COORDINATES_FORMAT:format(mx, my), CATEGORY_COLORS.coords)
		else
			addline_func(1, -2, true, questLocName, CATEGORY_COLORS.location, "", CATEGORY_COLORS.coords)
		end
	end,
	_func_waypoint_target = function(self, id_num, recipe)
		if not private.db.profile.mapquest then
			return
		end

		local quest = self:GetEntity(id_num)
		if self.CanDisplayFaction(quest.faction) then
			return quest
		end
	end,
})
