-- ----------------------------------------------------------------------------
-- Localized Lua globals.
-- ----------------------------------------------------------------------------

local pairs = _G.pairs

-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local FOLDER_NAME, private = ...

-- ----------------------------------------------------------------------------
-- Imports.
-- ----------------------------------------------------------------------------
local CATEGORY_COLORS = private.CATEGORY_COLORS
local COORDINATES_FORMAT = private.COORDINATES_FORMAT
local LFAC = private.LOCALIZED_FACTION_STRINGS_FROM_LABEL

local REPUTATION_VENDOR_LABEL = private.VENDOR_TYPE_FORMAT:format(_G.REPUTATION)

private.RegisterAcquireType({
	-- ----------------------------------------------------------------------------
	-- Data.
	-- ----------------------------------------------------------------------------
	_colorData = { hex = "855a99", r = 0.52, g = 0.35, b = 0.6 },
	_hasCoordinates = false,
	_hasEntities = true,
	_label = "REPUTATION",
	_name = REPUTATION_VENDOR_LABEL,
	-- ----------------------------------------------------------------------------
	-- Methods.
	-- ----------------------------------------------------------------------------
	_func_expand_list_entry = function(self, entry_index, entry_type, parent_entry, identifier, info, recipe, hide_location, hide_type)
		for reputation_level, reputation_level_info in pairs(info) do
			for vendor_id in pairs(reputation_level_info) do
				local rep_vendor = private.AcquireTypes.Vendor:GetEntity(vendor_id)

				if not self.CanDisplayFaction(rep_vendor.faction) then
					return entry_index
				end

				if not self.__faction_labels then
					local rep_color = private.REPUTATION_COLORS

					self.__faction_labels = {
						[0] = private.SetTextColor(rep_color.neutral.hex, LFAC.NEUTRAL .. " : "),
						[1] = private.SetTextColor(rep_color.friendly.hex, LFAC.FRIENDLY .. " : "),
						[2] = private.SetTextColor(rep_color.honored.hex, LFAC.HONORED .. " : "),
						[3] = private.SetTextColor(rep_color.revered.hex, LFAC.REVERED .. " : "),
						[4] = private.SetTextColor(rep_color.exalted.hex, LFAC.EXALTED .. " : ")
					}
				end

				local entry = private.CreateListEntry(entry_type, parent_entry, recipe)
				entry:SetNPCID(vendor_id)
				entry:SetLocation(rep_vendor.Location)
				entry:SetText("%s%s %s",
					self.EntryPadding,
					hide_type and "" or private.SetTextColor(self:ColorData().hex, REPUTATION_VENDOR_LABEL) .. ":",
					private.SetTextColor(CATEGORY_COLORS.repname.hex, self:GetEntity(identifier).name))

				entry_index = private.list_frame:InsertEntry(entry, entry_index, true)

				entry = private.CreateListEntry(entry_type, parent_entry, recipe)
				entry:SetNPCID(vendor_id)
				entry:SetLocation(rep_vendor.Location)
				entry:SetText(self.EntryPadding:rep(2) .. self.__faction_labels[reputation_level] .. self.ColorNameByFaction(rep_vendor.name, rep_vendor.faction))

				entry_index = private.list_frame:InsertEntry(entry, entry_index, true)

				local coord_text = ""

				if rep_vendor.coord_x ~= 0 and rep_vendor.coord_y ~= 0 then
					coord_text = private.SetTextColor(CATEGORY_COLORS.coords.hex, COORDINATES_FORMAT:format(rep_vendor.coord_x, rep_vendor.coord_y))
				end

				if coord_text == "" and hide_location then
					return entry_index
				end

				entry = private.CreateListEntry(entry_type, parent_entry, recipe)
				entry:SetNPCID(vendor_id)
				entry:SetLocation(rep_vendor.Location)
				local locName = (rep_vendor.Location and rep_vendor.Location.LocalizedName and rep_vendor.Location:LocalizedName()) or "Unknown"
				entry:SetText("%s%s %s",
					self.EntryPadding:rep(3),
					hide_location and "" or private.SetTextColor(CATEGORY_COLORS.location.hex, locName),
					coord_text)

				return private.list_frame:InsertEntry(entry, entry_index, true)
			end
		end
	end,
	_func_insert_tooltip_text = function(self, recipe, identifier, localizedLocationName, acquire_info, addline_func)
		for reputationLevel, levelData in pairs(acquire_info) do
			for vendorID in pairs(levelData) do
				local vendor = private.AcquireTypes.Vendor:GetEntity(vendorID)

				local matchesLocation = true
				if localizedLocationName then
					if vendor and vendor.Location and vendor.Location.LocalizedName then
						matchesLocation = (vendor.Location:LocalizedName() == localizedLocationName)
					else
						matchesLocation = false
					end
				end

				if vendor and matchesLocation then
					local canDisplay, nameColor = self.GetTipFactionInfo(vendor.faction)

					if canDisplay then
						addline_func(0, -1, false, REPUTATION_VENDOR_LABEL, self:ColorData(), self:GetEntity(identifier).name, CATEGORY_COLORS.repname)

						if reputationLevel == 0 then
							addline_func(1, -2, false, LFAC.NEUTRAL, private.REPUTATION_COLORS.neutral, vendor.name, nameColor)
						elseif reputationLevel == 1 then
							addline_func(1, -2, false, LFAC.FRIENDLY, private.REPUTATION_COLORS.friendly, vendor.name, nameColor)
						elseif reputationLevel == 2 then
							addline_func(1, -2, false, LFAC.HONORED, private.REPUTATION_COLORS.honored, vendor.name, nameColor)
						elseif reputationLevel == 3 then
							addline_func(1, -2, false, LFAC.REVERED, private.REPUTATION_COLORS.revered, vendor.name, nameColor)
						else
							addline_func(1, -2, false, LFAC.EXALTED, private.REPUTATION_COLORS.exalted, vendor.name, nameColor)
						end

						local locName = (vendor.Location and vendor.Location.LocalizedName and vendor.Location:LocalizedName()) or "Unknown"
						if vendor.coord_x ~= 0 and vendor.coord_y ~= 0 then
							addline_func(2, -2, true, locName, CATEGORY_COLORS.location, COORDINATES_FORMAT:format(vendor.coord_x, vendor.coord_y), CATEGORY_COLORS.coords)
						else
							addline_func(2, -2, true, locName, CATEGORY_COLORS.location, "", CATEGORY_COLORS.coords)
						end
					end
				end
			end
		end
	end,
	_func_waypoint_target = function(self, id_num, recipe)
		if not private.db.profile.mapvendor then
			return
		end

		local vendor = private.AcquireTypes.Vendor:GetEntity(id_num)
		if private.Player.reputation_levels[self:GetEntity(vendor.reputation_id).name] then
			return vendor
		end
	end,
	_GetOrCreateRecipeData = function(sourceData, ...)
		local factionID, reputationLevel = ...

		if factionID and reputationLevel then
			if not sourceData[factionID] then
				sourceData[factionID] = {
					[reputationLevel] = {}
				}
			elseif not sourceData[factionID][reputationLevel] then
				sourceData[factionID][reputationLevel] = {}
			end
		end

		return sourceData
	end
})
