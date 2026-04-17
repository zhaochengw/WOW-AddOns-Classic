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
	_label = "TRAINER",
	_name = L["Trainer"],
	-- ----------------------------------------------------------------------------
	-- Methods.
	-- ----------------------------------------------------------------------------
	_func_expand_list_entry = function(self, entry_index, entry_type, parent_entry, identifier, info, recipe, hide_location, hide_type)
		local trainer = self:GetEntity(identifier)

		if not trainer or not self.CanDisplayFaction(trainer.faction) then
			return entry_index
		end

		local entry = private.CreateListEntry(entry_type, parent_entry, recipe)
		entry:SetNPCID(identifier)
		entry:SetLocation(trainer.Location)
		entry:SetText("%s%s %s",
			self.EntryPadding,
			hide_type and "" or private.SetTextColor(self:ColorData().hex, self:Name()) .. ":",
			self.ColorNameByFaction(trainer.name, trainer.faction))

		entry_index = private.list_frame:InsertEntry(entry, entry_index, true)

		local coord_text = ""

		if trainer.coord_x ~= 0 and trainer.coord_y ~= 0 then
			coord_text = private.SetTextColor(CATEGORY_COLORS.coords.hex, COORDINATES_FORMAT:format(trainer.coord_x, trainer.coord_y))
		end

		if coord_text == "" and hide_location then
			return entry_index
		end

		entry = private.CreateListEntry(entry_type, parent_entry, recipe)
		entry:SetNPCID(identifier)
		entry:SetLocation(trainer.Location)
		local locName = (trainer.Location and trainer.Location:LocalizedName()) or UNKNOWN
		entry:SetText("%s%s %s",
			self.EntryPadding:rep(2),
			hide_location and "" or private.SetTextColor(CATEGORY_COLORS.location.hex, locName),
			coord_text)

		return private.list_frame:InsertEntry(entry, entry_index, true)
	end,
	_func_insert_tooltip_text = function(self, recipe, identifier, localizedLocationName, acquire_info, addline_func)
		local trainer = self:GetEntity(identifier)
		local trainerLocName = (trainer and trainer.Location and trainer.Location:LocalizedName()) or UNKNOWN

		if not trainer or (localizedLocationName and trainerLocName ~= localizedLocationName) then
			return
		end

		local display_tip, name_color = self.GetTipFactionInfo(trainer.faction)
		if not display_tip then
			return
		end
		addline_func(0, -2, false, self:Name(), self:ColorData(), trainer.name, name_color)

		local mx, my = (trainer and trainer.coord_x) or 0, (trainer and trainer.coord_y) or 0
		if mx ~= 0 and my ~= 0 then
			addline_func(1, -2, true, trainerLocName, CATEGORY_COLORS.location, COORDINATES_FORMAT:format(mx, my), CATEGORY_COLORS.coords)
		else
			addline_func(1, -2, true, trainerLocName, CATEGORY_COLORS.location, "", CATEGORY_COLORS.coords)
		end
	end,
	_func_waypoint_target = function(self, id_num, recipe)
		if not private.db.profile.maptrainer then
			return
		end

		local trainer = self:GetEntity(id_num)
		if self.CanDisplayFaction(trainer.faction) then
			return trainer
		end
	end
})
