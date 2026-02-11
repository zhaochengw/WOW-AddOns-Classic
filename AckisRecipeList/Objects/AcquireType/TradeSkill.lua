-- ----------------------------------------------------------------------------
-- Localized Lua globals.
-- ----------------------------------------------------------------------------

local pairs = _G.pairs

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
	_colorData = { hex = "309ad1", r = 0.19, g = 0.60, b = 0.82 },
	_hasCoordinates = false,
	_hasEntities = false,
	_label = "TRADE_SKILL",
	_name = _G.TRADE_SKILLS,
	-- ----------------------------------------------------------------------------
	-- Methods.
	-- ----------------------------------------------------------------------------
	_func_expand_list_entry = function(self, entryIndex, entryType, parentEntry, identifier, acquireInfo, recipe, hideLocation, hideType)
		local entry = private.CreateListEntry(entryType, parentEntry, recipe)

		entry:SetText("%s%s: %s",
			self.EntryPadding,
			private.SetTextColor(self:ColorData().hex, private.PROFESSION_ID_TO_LOCALIZED_NAME[identifier]),
			private.SetTextColor(private.CATEGORY_COLORS.location.hex, acquireInfo))

		return private.list_frame:InsertEntry(entry, entryIndex, true)
	end,
	_func_insert_tooltip_text = function(self, recipe, identifier, localizedLocationName, acquireInfo, addlineFunc)
		addlineFunc(0, -1, false, private.PROFESSION_ID_TO_LOCALIZED_NAME[identifier], self:ColorData(), acquireInfo, private.CATEGORY_COLORS.location)
	end,
	_GetOrCreateRecipeData = function(sourceData, professionID, localizedLocationName)
		sourceData[professionID] = localizedLocationName
		return sourceData
	end,
})
