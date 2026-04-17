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
	_colorData = { hex = "c98e26", r = 0.79, g = 0.56, b = 0.14 },
	_hasCoordinates = true,
	_hasEntities = true,
	_label = "MIXED",
	_name = L["Trainer & Vendor"],
	-- ----------------------------------------------------------------------------
	-- Methods.
	-- ----------------------------------------------------------------------------
	_func_expand_list_entry = function(self, entry_index, entry_type, parent_entry, identifier, info, recipe, hide_location, hide_type)
		local mixed = self:GetEntity(identifier)

		if not mixed or not self.CanDisplayFaction(mixed.faction) then
			return entry_index
		end

		local entry = private.CreateListEntry(entry_type, parent_entry, recipe)
		entry:SetNPCID(identifier)
		entry:SetLocation(mixed.Location)
		entry:SetText("%s%s %s",
			self.EntryPadding,
			hide_type and "" or private.SetTextColor(self:ColorData().hex, self:Name()) .. ":",
			self.ColorNameByFaction(mixed.name, mixed.faction))

		entry_index = private.list_frame:InsertEntry(entry, entry_index, true)

		local coord_text = ""

		if mixed.coord_x ~= 0 and mixed.coord_y ~= 0 then
			coord_text = private.SetTextColor(CATEGORY_COLORS.coords.hex, COORDINATES_FORMAT:format(mixed.coord_x, mixed.coord_y))
		end

		if coord_text == "" and hide_location then
			return entry_index
		end

		entry = private.CreateListEntry(entry_type, parent_entry, recipe)
		entry:SetNPCID(identifier)
		entry:SetLocation(mixed.Location)
		local locName = (mixed.Location and mixed.Location:LocalizedName()) or UNKNOWN
		entry:SetText("%s%s %s",
			self.EntryPadding:rep(2),
			hide_location and "" or private.SetTextColor(CATEGORY_COLORS.location.hex, locName),
			coord_text)

		return private.list_frame:InsertEntry(entry, entry_index, true)
	end,
	_func_insert_tooltip_text = function(self, recipe, identifier, localizedLocationName, acquire_info, addline_func)
		local mixed = self:GetEntity(identifier)
		local mixedLocName = (mixed and mixed.Location and mixed.Location:LocalizedName()) or UNKNOWN

		if not mixed or (localizedLocationName and mixedLocName ~= localizedLocationName) then
			return
		end

		local display_tip, name_color = self.GetTipFactionInfo(mixed.faction)
		if not display_tip then
			return
		end
		addline_func(0, -2, false, self:Name(), self:ColorData(), mixed.name, name_color)

		local mx, my = (mixed and mixed.coord_x) or 0, (mixed and mixed.coord_y) or 0
		if mx ~= 0 and my ~= 0 then
			addline_func(1, -2, true, mixedLocName, CATEGORY_COLORS.location, COORDINATES_FORMAT:format(mx, my), CATEGORY_COLORS.coords)
		else
			addline_func(1, -2, true, mixedLocName, CATEGORY_COLORS.location, "", CATEGORY_COLORS.coords)
		end
	end,
	_func_waypoint_target = function(self, id_num, recipe)
		if not private.db.profile.mapmixed then
			return
		end

		local mixed = self:GetEntity(id_num)
		if self.CanDisplayFaction(mixed.faction) then
			return mixed
		end
	end
})
