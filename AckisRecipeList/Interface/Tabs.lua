--[[
Copyright (c) 2009 - 2012 Ackis <John Pasula>
All rights reserved by the original author Ackis.
]]

-- ----------------------------------------------------------------------------
-- Localized Lua globals.
-- ----------------------------------------------------------------------------
local table = _G.table

local pairs, ipairs = _G.pairs, _G.ipairs

-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local FOLDER_NAME, private = ...

local LibStub = _G.LibStub
local addon = LibStub("AceAddon-3.0"):GetAddon(private.addon_name)
local L = LibStub("AceLocale-3.0"):GetLocale(private.addon_name)
local HBD = LibStub("HereBeDragons-2.0")

-- ----------------------------------------------------------------------------
-- Constants.
-- ----------------------------------------------------------------------------
local frame_meta = { __index = _G.CreateFrame("Button") }
local tab_prototype = _G.setmetatable({}, frame_meta)
local tab_meta = { __index = tab_prototype }

-- ----------------------------------------------------------------------------
-- Imports.
-- ----------------------------------------------------------------------------
local CreateListEntry = private.CreateListEntry
local SetTextColor = private.SetTextColor
local AcquireTypes = private.AcquireTypes

-- ----------------------------------------------------------------------------
-- Helpers.
-- ----------------------------------------------------------------------------
-- Returns true on Classic Era clients (expansion index 1)
local function IsClassicEra()
	local ok, eff = pcall(function()
		return private.GetEffectiveExpansionID and private.GetEffectiveExpansionID()
	end)
	return ok and eff and eff <= 1
end

-- Normalize tab piece textures (left/middle/right) so they render consistently across clients.
-- Classic Era ships slightly different atlas slices; using full-height texcoords avoids the pale look.
local function ApplyTabTextures(self, isActive)
	local activePath  = "Interface\\PaperDollInfoFrame\\UI-Character-ActiveTab"
	local inactivePath = "Interface\\PaperDollInfoFrame\\UI-Character-InactiveTab"

	local vMaxActive = IsClassicEra() and 1 or 0.546875

	if isActive then
		self.left:SetTexture(activePath)
		self.left:SetTexCoord(0, 0.15625, 0, vMaxActive)

		self.middle:SetTexture(activePath)
		self.middle:SetTexCoord(0.15625, 0.84375, 0, vMaxActive)

		self.right:SetTexture(activePath)
		self.right:SetTexCoord(0.84375, 1, 0, vMaxActive)
	else
		self.left:SetTexture(inactivePath)
		self.left:SetTexCoord(0, 0.15625, 0, 1)

		self.middle:SetTexture(inactivePath)
		self.middle:SetTexCoord(0.15625, 0.84375, 0, 1)

		self.right:SetTexture(inactivePath)
		self.right:SetTexCoord(0.84375, 1, 0, 1)
	end

	-- Ensure no unintended tinting/desaturation from client defaults
	if self.left.SetVertexColor then
		self.left:SetVertexColor(1, 1, 1); self.left:SetAlpha(1)
	end
	if self.middle.SetVertexColor then
		self.middle:SetVertexColor(1, 1, 1); self.middle:SetAlpha(1)
	end
	if self.right.SetVertexColor then
		self.right:SetVertexColor(1, 1, 1); self.right:SetAlpha(1)
	end
	if self.left.SetDesaturated then pcall(self.left.SetDesaturated, self.left, false) end
	if self.middle.SetDesaturated then pcall(self.middle.SetDesaturated, self.middle, false) end
	if self.right.SetDesaturated then pcall(self.right.SetDesaturated, self.right, false) end
end

local function Tab_OnClick(self, button, down)
	local tabID = self:GetID()
	local MainPanel = addon.Frame

	for index in ipairs(MainPanel.tabs) do
		local tab = MainPanel.tabs[index]

		if index == tabID then
			self:ToFront()
		else
			tab:ToBack()
		end
	end

	addon.db.profile.current_tab = tabID
	MainPanel.current_tab = MainPanel.tabs[tabID]
	MainPanel.list_frame:Update(nil, false)

	if _G.SOUNDKIT and _G.PlaySound then
		_G.PlaySound(_G.SOUNDKIT.IG_CHARACTER_INFO_TAB, "Master")
	else
		-- MoP Classic fallback (numeric sound id)
		_G.PlaySound(841)
	end
end

local function CreateTab(id_num, text, ...)
	local tab = _G.setmetatable(_G.CreateFrame("Button", nil, addon.Frame), tab_meta)

	tab:SetID(id_num)
	tab:SetHeight(32)
	tab:SetPoint(...)
	tab:SetFrameLevel(tab:GetFrameLevel() + 4)

	tab.left = tab:CreateTexture(nil, "BORDER")
	tab.left:SetSize(20, 32)

	tab.right = tab:CreateTexture(nil, "BORDER")
	tab.right:SetSize(20, 32)
	tab.right:SetPoint("TOP", tab.left)
	tab.right:SetPoint("RIGHT", tab)

	tab.middle = tab:CreateTexture(nil, "BORDER")
	tab.middle:SetHeight(32)
	tab.middle:SetPoint("LEFT", tab.left, "RIGHT")
	tab.middle:SetPoint("RIGHT", tab.right, "LEFT")

	tab:SetHighlightTexture([[Interface\PaperDollInfoFrame\UI-Character-Tab-Highlight]], "ADD")

	local tab_highlight = tab:GetHighlightTexture()
	tab_highlight:ClearAllPoints()
	tab_highlight:SetPoint("TOPLEFT", tab, "TOPLEFT", 8, 1)
	tab_highlight:SetPoint("BOTTOMRIGHT", tab, "BOTTOMRIGHT", -8, 1)

	tab:SetDisabledFontObject(_G.GameFontHighlightSmall)
	tab:SetHighlightFontObject(_G.GameFontHighlightSmall)
	tab:SetNormalFontObject(_G.GameFontNormalSmall)

	tab:SetText(text)
	tab:SetWidth(40 + tab:GetFontString():GetStringWidth())

	tab:ToBack()

	tab:SetScript("OnClick", Tab_OnClick)

	return tab
end

-- ----------------------------------------------------------------------------
-- Tab methods.
-- ----------------------------------------------------------------------------
function tab_prototype:ToFront()
	self.left:ClearAllPoints()
	self.left:SetPoint("BOTTOMLEFT")

	ApplyTabTextures(self, true)

	self:Disable()
end

function tab_prototype:ToBack()
	self.left:ClearAllPoints()
	self.left:SetPoint("TOPLEFT")

	ApplyTabTextures(self, false)

	self:Enable()
end

function tab_prototype:SaveListEntryState(listEntry, expanded)
    local professionExpansionState = self.ProfessionState[private.CurrentProfession]

    local listEntryAcquireType = listEntry:AcquireType()
	if listEntryAcquireType then
		professionExpansionState[listEntryAcquireType] = expanded or nil
	end

    local listEntryLocation = listEntry:Location()
	if listEntryLocation then
		professionExpansionState[listEntryLocation] = expanded or nil
	end

	if listEntry.recipe then
		professionExpansionState[listEntry.recipe] = expanded or nil
	end
end

function tab_prototype:GetProfessionExpansionState(profession)
    local professionState = self.ProfessionState
    if not professionState then
        professionState = {
            [profession] = {}
        }

        self.ProfessionState = professionState
    end

    local professionExpansionState = self.ProfessionState[profession]
    if not professionExpansionState then
        professionExpansionState = {}
        self.ProfessionState[profession] = professionExpansionState
    end

    return professionExpansionState
end

function tab_prototype:ScrollValue(profession)
	return self["profession_" .. profession:Name() .. "_scroll_value"]
end

function tab_prototype:SetScrollValue(profession, value)
	self["profession_" .. profession:Name() .. "_scroll_value"] = value
end

-- ----------------------------------------------------------------------------
-- Tab initialization and methods.
-- ----------------------------------------------------------------------------
local AcquisitionTab
local LocationTab
local RecipesTab

-- Used for Location and Acquisition sort - since many recipes have multiple locations/acquire types it is
-- necessary to ensure each is counted only once.
local recipe_registry = {}

-- Recipes with these acquire types will never show as headers.
local CHILDLESS_ACQUIRE_TYPES = {
	[private.AcquireTypes.Achievement] = true,
	[private.AcquireTypes.Custom] = true,
	[private.AcquireTypes.Discovery] = true,
	[private.AcquireTypes.Retired] = true,
	[private.AcquireTypes.WorldDrop] = true,
}

local AcquireDataExpandPredicates = {
	[AcquireTypes.Trainer] = function(obtainFilters, shouldHideType)
		return obtainFilters.trainer
	end,
	[AcquireTypes.Vendor] = function(obtainFilters, shouldHideType)
		return obtainFilters.vendor or obtainFilters.pvp
	end,
	[AcquireTypes.Mixed] = function(obtainFilters, shouldHideType)
		return obtainFilters.mixed
	end,
	[AcquireTypes.MobDrop] = function(obtainFilters, shouldHideType)
		return obtainFilters.mobdrop or obtainFilters.instance or obtainFilters.raid
	end,
	[AcquireTypes.Quest] = function(obtainFilters, shouldHideType)
		return obtainFilters.quest
	end,
	[AcquireTypes.WorldEvent] = function(obtainFilters, shouldHideType)
		return obtainFilters.worldevent
	end,
	[AcquireTypes.Reputation] = function(obtainFilters, shouldHideType)
		return true
	end,
	[AcquireTypes.WorldDrop] = function(obtainFilters, shouldHideType)
		return obtainFilters.worlddrop and not shouldHideType
	end,
	[AcquireTypes.Custom] = function(obtainFilters, shouldHideType)
		return not shouldHideType
	end,
	[AcquireTypes.Discovery] = function(obtainFilters, shouldHideType)
		return not shouldHideType
	end,
	[AcquireTypes.Retired] = function(obtainFilters, shouldHideType)
		return not shouldHideType
	end,
	[AcquireTypes.Achievement] = function(obtainFilters, shouldHideType)
		return obtainFilters.achievement
	end,
	[AcquireTypes.TradeSkill] = function(obtainFilters, shouldHideType)
		return obtainFilters.tradeskill
	end,
}

local function ExpandAcquireData(listEntryIndex, listEntryType, parentListEntry, acquireType, acquireTypeData, recipe, shouldHideLocation, shouldHideType)
	local obtainFilters = addon.db.profile.filters.obtain

	for sourceID, sourceData in pairs(acquireTypeData) do
		local predicateFunc = AcquireDataExpandPredicates[acquireType]
		if predicateFunc and predicateFunc(obtainFilters, shouldHideType) then
			listEntryIndex = acquireType:ExpandListEntry(listEntryIndex, listEntryType, parentListEntry, sourceID, sourceData, recipe, shouldHideLocation, shouldHideType)
		end
	end

	return listEntryIndex
end

local function InitializeAcquisitionTab()
	local MainPanel = addon.Frame

	-- Used to hold tables for sorting the tab:The tables are only sorted once, upon creation.
	local SortedAcquireTypes

	AcquisitionTab = CreateTab(1, L["Acquisition"], "TOPLEFT", addon.Frame, "BOTTOMLEFT", 4, 81)

	function AcquisitionTab:Initialize(expand_mode)
		local recipe_count = 0
		local insert_index = 1

		table.wipe(recipe_registry)

		if not SortedAcquireTypes then
			SortedAcquireTypes = {}

            for name, acquireType in pairs(private.AcquireTypes) do
				SortedAcquireTypes[#SortedAcquireTypes + 1] = acquireType
            end

			table.sort(SortedAcquireTypes, function(acquireTypeA, acquireTypeB)
				local a = (acquireTypeA and acquireTypeA:Name()) or ""
				local b = (acquireTypeB and acquireTypeB:Name()) or ""
				return a < b
			end)
        end
        local currentProfession = private.CurrentProfession
		local localizedProfessionName = currentProfession:LocalizedName()
		local professionRecipes = currentProfession.Recipes
        local professionExpansionState = self:GetProfessionExpansionState(currentProfession)

		for index = 1, #SortedAcquireTypes do
			local acquireType = SortedAcquireTypes[index]
			local count = 0

			-- Check to see if any recipes for this acquire type will be shown - otherwise, don't show the type in the list.
			for spell_id, affiliation in acquireType:RecipePairs() do
				local recipe = professionRecipes[spell_id]

				if recipe and recipe:IsVisible() then
					count = count + 1

					if not recipe_registry[recipe] then
						recipe_registry[recipe] = true
						recipe_count = recipe_count + 1
					end
                elseif professionExpansionState[recipe] then
                    professionExpansionState[recipe] = nil
                end
			end

			if count > 0 then
				local isAcquireTypeExpanded = professionExpansionState[acquireType]
				local listEntry = CreateListEntry("header")
				listEntry:SetAcquireType(acquireType)
                listEntry:SetText("%s (%d)",
                    SetTextColor(acquireType:ColorData().hex, acquireType:Name()),
                    count)

				insert_index = MainPanel.list_frame:InsertEntry(listEntry, insert_index, isAcquireTypeExpanded or expand_mode, isAcquireTypeExpanded or expand_mode)
            elseif professionExpansionState[acquireType] then
                professionExpansionState[acquireType] = nil
            end
        end

		return recipe_count
	end

	function AcquisitionTab:ExpandListEntry(entry, expand_mode)
		local orig_index = entry.button and entry.button.entry_index or entry.index
		local expand_all = expand_mode == "deep"
		local entryAcquireType = entry:AcquireType()

		-- Entry_index is the position in self.entries that we want to expand. Since we are expanding the current entry, the return
		-- value should be the index of the next button after the expansion occurs
		local newListEntryIndex = orig_index + 1

		self:SaveListEntryState(entry, true)

		if entry:IsHeader() then
			local sorted_recipes = entryAcquireType:GetSortedRecipes()
            local currentProfession = private.CurrentProfession
            local localizedProfessionName = currentProfession:LocalizedName()
            local professionExpansionState = self:GetProfessionExpansionState(currentProfession)

            for index = 1, #sorted_recipes do
				local recipe = currentProfession.Recipes[sorted_recipes[index]]
				if recipe and recipe:IsVisible() then
					local expand = false
					local entry_type = "subheader"

					if CHILDLESS_ACQUIRE_TYPES[entryAcquireType] then
						expand = true
						entry_type = "entry"
					end
					local is_expanded = (professionExpansionState[recipe] and professionExpansionState[entryAcquireType])

					local listEntry = CreateListEntry(entry_type, entry, recipe)
					listEntry:SetAcquireType(entryAcquireType)
					listEntry:SetText(recipe:GetDisplayName())

					newListEntryIndex = MainPanel.list_frame:InsertEntry(listEntry, newListEntryIndex, expand or is_expanded, expand_all or is_expanded)
				end
			end
		elseif entry:IsSubHeader() then
            local recipeAcquireData = entry.recipe:AcquireDataOfType(entryAcquireType)
            if recipeAcquireData then
                newListEntryIndex = ExpandAcquireData(newListEntryIndex, "subentry", entry, entryAcquireType, recipeAcquireData, entry.recipe, false, true)
			end
        end

		return newListEntryIndex
	end
end

local function InitializeLocationTab()
	local MainPanel = addon.Frame

	-- Used to hold tables for sorting the tab: The tables are only sorted once upon creation.
	local SortedLocations

	LocationTab = CreateTab(2, L["Location"], "LEFT", AcquisitionTab, "RIGHT", -14, 0)

	function LocationTab:Initialize(expand_mode)
		local search_box = MainPanel.search_editbox

		table.wipe(recipe_registry)

		if not SortedLocations then
			SortedLocations = {}

			for name, location in pairs(private.Locations) do
				table.insert(SortedLocations, location)
			end

			table.sort(SortedLocations, function(locationA, locationB)
				local aCont = (locationA and locationA:ContinentID()) or 9999
				local bCont = (locationB and locationB:ContinentID()) or 9999
				if aCont == bCont then
					local aName = (locationA and locationA:LocalizedName()) or ""
					local bName = (locationB and locationB:LocalizedName()) or ""
					return aName < bName
				end
				return aCont < bCont
			end)
        end
        local currentProfession = private.CurrentProfession
        local localizedProfessionName = currentProfession:LocalizedName()
		local professionRecipes = currentProfession.Recipes
        local professionExpansionState = self:GetProfessionExpansionState(currentProfession)

        local currentContinentID

        local recipe_count = 0
        local insert_index = 1

		for index = 1, #SortedLocations do
            local location = SortedLocations[index]
            local localizedLocationName = location:LocalizedName()
			local count = 0

			-- Check to see if any recipes for this location will be shown - otherwise, don't show the location in the list.
            for recipe, affiliation in location:RecipePairs() do
				if professionRecipes[recipe:SpellID()] and recipe:IsVisible() then
					local good_count, bad_count = 0, 0
					local showOpposingFaction = addon.db.profile.filters.general.faction

					if not showOpposingFaction then
                        for name, acquireType in pairs(private.AcquireTypes) do
							local acquireData = recipe:AcquireDataOfType(acquireType)

							if acquireData and acquireType:HasCoordinates() then
                                local alignedCount = 0
                                local opposingCount = 0

                                for identifier in pairs(acquireData) do
                                    local entity = acquireType:GetEntity(identifier)
                                    local entityFaction = entity.faction

                                    if not location or entity.Location == location then
                                        if not entityFaction or entityFaction == private.Player.faction or entityFaction == "Neutral" then
                                            alignedCount = alignedCount + 1
                                        else
                                            opposingCount = opposingCount + 1
                                        end
                                    end
                                end

                                if alignedCount == 0 and opposingCount > 0 then
									bad_count = bad_count + 1
								else
									good_count = good_count + 1
								end
							end
						end
					end

					if showOpposingFaction or not (good_count == 0 and bad_count > 0) then
						count = count + 1

						if not recipe_registry[recipe] then
							recipe_registry[recipe] = true
							recipe_count = recipe_count + 1
						end
					end
                elseif professionExpansionState[recipe] then
                    professionExpansionState[recipe] = nil
                end
			end

			if count > 0 then
                local locationContinentID = location:ContinentID()
				if locationContinentID ~= currentContinentID then
					currentContinentID = locationContinentID

					local listEntry = CreateListEntry("title")
					-- Safe continent header name resolution
					local continentObj = private.ContinentLocationByID and locationContinentID and private.ContinentLocationByID[locationContinentID]
					local continentHeaderName = (continentObj and continentObj:LocalizedName())
						or (private.ZONE_NAMES and (private.ZONE_NAMES.AZEROTH or "Azeroth"))
						or "Azeroth"
					listEntry:SetText(SetTextColor(private.CATEGORY_COLORS.location.hex, continentHeaderName))
					insert_index = MainPanel.list_frame:InsertEntry(listEntry, insert_index)
				end

			local listEntry = CreateListEntry("header")
                listEntry:SetLocation(location)
			local currentMapID = HBD:GetPlayerZone()
			local PlayerZone = currentMapID and HBD:GetLocalizedMap(currentMapID)

				if localizedLocationName == _G.GetRealZoneText() then
					listEntry:Emphasize(true)
					listEntry:SetText("%s (%d)",
						SetTextColor(private.DIFFICULTY_COLORS.optimal.hex, localizedLocationName),
						count
					)
				else
					listEntry:Emphasize(false)
					listEntry:SetText("%s (%d)",
						SetTextColor(private.CATEGORY_COLORS.location.hex, localizedLocationName),
						count
					)
				end

				local isLocationExpanded = professionExpansionState[location]
				insert_index = MainPanel.list_frame:InsertEntry(listEntry, insert_index, isLocationExpanded or expand_mode, isLocationExpanded or expand_mode)
            elseif professionExpansionState[location] then
                professionExpansionState[location] = nil
            end
        end

		return recipe_count
	end

	function LocationTab:ExpandListEntry(entry, expand_mode)
		local orig_index = entry.button and entry.button.entry_index or entry.index
		local expand_all = expand_mode == "deep"
        local location = entry:Location()

		-- Entry_index is the position in self.entries that we want to expand. Since we are expanding the current entry, the return
		-- value should be the index of the next button after the expansion occurs
		local new_entry_index = orig_index + 1

		self:SaveListEntryState(entry, true)

		if entry:IsHeader() then
            local currentProfession = private.CurrentProfession
            local professionExpansionState = self:GetProfessionExpansionState(currentProfession)

            local sortedRecipes = location:GetSortedRecipes()
			for index = 1, #sortedRecipes do
				local recipe = currentProfession.Recipes[sortedRecipes[index]]

				if recipe and recipe:IsVisible() then
					local expand = false
					local entry_type = "subheader"

					-- Add World Drop entries as normal entries.
					if location:GetRecipeAffiliation(recipe) == "world_drop" then
						expand = true
						entry_type = "entry"
					end

					local isLocationExpanded = (professionExpansionState[recipe] and professionExpansionState[location])
					local listEntry = CreateListEntry(entry_type, entry, recipe)
					listEntry:SetText(recipe:GetDisplayName())
					listEntry:SetLocation(location)

					new_entry_index = MainPanel.list_frame:InsertEntry(listEntry, new_entry_index, expand or isLocationExpanded, expand_all or isLocationExpanded)
				end
			end
		elseif entry:IsSubHeader() then
			-- World Drops are not handled here because they are of type "entry".
            -- Only expand an acquisition entry if it is from this location.
            for acquireType, acquireData in entry.recipe:AcquirePairs() do
				for sourceID, sourceData in pairs(acquireData) do
					local hideAcquireType
					local shouldExecute

					if (acquireType == private.AcquireTypes.Trainer or acquireType == private.AcquireTypes.Vendor or acquireType == private.AcquireTypes.MobDrop or acquireType == private.AcquireTypes.Mixed or acquireType == private.AcquireTypes.Quest)
							and acquireType:GetEntity(sourceID).Location == location then
						shouldExecute = true
					elseif (acquireType == private.AcquireTypes.WorldEvent or acquireType == private.AcquireTypes.Custom or acquireType == private.AcquireTypes.Discovery)
							and acquireType:GetEntity(sourceID).Location == location then
						hideAcquireType = true
						shouldExecute = true
					elseif acquireType == private.AcquireTypes.Reputation then
						shouldExecute = true
						break
					end

					if shouldExecute then
						new_entry_index = acquireType:ExpandListEntry(new_entry_index, "subentry", entry, sourceID, sourceData, entry.recipe, true, hideAcquireType)
					end
				end
			end
		end
		return new_entry_index
	end
end

local function InitializeRecipesTab()
	local MainPanel = addon.Frame

	RecipesTab = CreateTab(3, _G.TRADESKILL_SERVICE_LEARN, "LEFT", LocationTab, "RIGHT", -14, 0)

	function RecipesTab:Initialize(expand_mode)
        local currentProfession = private.CurrentProfession
        local localizedProfessionName = currentProfession:LocalizedName()
		local professionRecipes = currentProfession.Recipes
        local professionExpansionState = self:GetProfessionExpansionState(currentProfession)

		private.SortRecipeList(professionRecipes)

		local sorted_recipes = addon.sorted_recipes
		local recipe_count = 0
		local insert_index = 1

		for i = 1, #sorted_recipes do
			local recipe = professionRecipes[sorted_recipes[i]]

			if recipe and recipe:IsVisible() then
				local listEntry = CreateListEntry("header", nil, recipe)
				listEntry:SetText(recipe:GetDisplayName())

				recipe_count = recipe_count + 1

				local isRecipeExpanded = professionExpansionState[recipe]
				insert_index = MainPanel.list_frame:InsertEntry(listEntry, insert_index, isRecipeExpanded or expand_mode, isRecipeExpanded or expand_mode)
			elseif professionExpansionState[recipe] then
				professionExpansionState[recipe] = nil
			end
        end

		return recipe_count
	end

	function RecipesTab:ExpandListEntry(entry, expand_mode)
		local orig_index = entry.button and entry.button.entry_index or entry.index

		-- Entry_index is the position in self.entries that we want to expand. Since we are expanding the current entry, the return
		-- value should be the index of the next button after the expansion occurs
		local new_entry_index = orig_index + 1

		self:SaveListEntryState(entry, true)

        for acquireType, acquireData in entry.recipe:AcquirePairs() do
			new_entry_index = ExpandAcquireData(new_entry_index, "entry", entry, acquireType, acquireData, entry.recipe)
		end
		return new_entry_index
	end
end

function private.InitializeTabs()
	local MainPanel = addon.Frame
	MainPanel.tabs = {}

	InitializeAcquisitionTab()
	MainPanel.tabs[#MainPanel.tabs + 1] = AcquisitionTab

	InitializeLocationTab()
	MainPanel.tabs[#MainPanel.tabs + 1] = LocationTab

	InitializeRecipesTab()
	MainPanel.tabs[#MainPanel.tabs + 1] = RecipesTab

	private.InitializeTabs = nil
end
