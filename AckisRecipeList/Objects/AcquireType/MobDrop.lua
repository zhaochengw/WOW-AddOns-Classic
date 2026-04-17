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
	_colorData = { hex = "962626", r = 0.59, g = 0.15, b = 0.15 },
	_hasCoordinates = true,
	_hasEntities = true,
	_label = "MOB_DROP",
	_name = L["Mob Drop"],
	-- ----------------------------------------------------------------------------
	-- Methods.
	-- ----------------------------------------------------------------------------
	_func_expand_list_entry = function(self, entry_index, entry_type, parent_entry, identifier, info, recipe, hide_location, hide_type)
		local mob = self:GetEntity(identifier) or {}
		local entry = private.CreateListEntry(entry_type, parent_entry, recipe)
		entry:SetNPCID(identifier)
		entry:SetLocation(mob.Location)
		entry:SetText("%s%s %s",
			self.EntryPadding,
			hide_type and "" or private.SetTextColor(self:ColorData().hex, self:Name()) .. ":",
			private.SetTextColor(private.REPUTATION_COLORS.hostile.hex, mob.name or UNKNOWN))

		entry_index = private.list_frame:InsertEntry(entry, entry_index, true)

		local coord_text = ""
		local mx, my = mob.coord_x or 0, mob.coord_y or 0

		if mx ~= 0 and my ~= 0 then
			coord_text = private.SetTextColor(CATEGORY_COLORS.coords.hex, COORDINATES_FORMAT:format(mx, my))
		end

		if coord_text == "" and hide_location then
			return entry_index
		end

		entry = private.CreateListEntry(entry_type, parent_entry, recipe)
		entry:SetNPCID(identifier)
		entry:SetLocation(mob.Location)
		local locName = (mob.Location and mob.Location:LocalizedName()) or UNKNOWN
		entry:SetText("%s%s %s",
			self.EntryPadding:rep(2),
			hide_location and "" or private.SetTextColor(CATEGORY_COLORS.location.hex, locName),
			coord_text)

		return private.list_frame:InsertEntry(entry, entry_index, true)
	end,
	_func_insert_tooltip_text = function(self, recipe, identifier, localizedLocationName, acquire_info, addline_func)
		local mob = self:GetEntity(identifier)
		local mobLocName = (mob and mob.Location and mob.Location:LocalizedName()) or UNKNOWN

		if not mob or (localizedLocationName and mobLocName ~= localizedLocationName) then
			return
		end
		addline_func(0, -1, false, L["Mob Drop"], self:ColorData(), mob.name, private.REPUTATION_COLORS.hostile)

		local mx, my = (mob and mob.coord_x) or 0, (mob and mob.coord_y) or 0
		if mx ~= 0 and my ~= 0 then
			addline_func(1, -2, true, mobLocName, CATEGORY_COLORS.location, COORDINATES_FORMAT:format(mx, my), CATEGORY_COLORS.coords)
		else
			addline_func(1, -2, true, mobLocName, CATEGORY_COLORS.location, "", CATEGORY_COLORS.coords)
		end
	end,
	_func_waypoint_target = function(self, id_num, recipe)
		return private.db.profile.mapmob and self:GetEntity(id_num)
	end,
})
