--[[
Copyright (c) 2009 - 2012 Ackis <John Pasula>
All rights reserved by the original author Ackis.
]]



local math = _G.math
local table = _G.table

local pairs = _G.pairs
local select = _G.select
local tostring = _G.tostring

-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local FOLDER_NAME, private = ...

local LibStub = _G.LibStub
---@type any
local addon = LibStub("AceAddon-3.0"):GetAddon(private.addon_name)
local L = LibStub("AceLocale-3.0"):GetLocale(private.addon_name)
local Dialog = LibStub("LibDialog-1.0")

-- ----------------------------------------------------------------------------
-- Imports.
-- ----------------------------------------------------------------------------
local BASIC_COLORS = private.BASIC_COLORS

-- ----------------------------------------------------------------------------
-- Constants
-- ----------------------------------------------------------------------------
local NUM_RECIPE_LINES	= 25
local SCROLL_DEPTH	= 5
local LISTFRAME_WIDTH	= 295
local LIST_ENTRY_WIDTH	= 286

-- ----------------------------------------------------------------------------
-- Upvalues
-- ----------------------------------------------------------------------------
local ListItem_ShowTooltip

local acquire_tip -- replaced by GameTooltip usage; keep reference for cleanup logic

-- ----------------------------------------------------------------------------
-- Dialogs.
-- ----------------------------------------------------------------------------
-- (Removed ARL_NotScanned popup)

--
Dialog:Register("ARL_AllFiltered", {
	text = L["ALL_FILTERED"],
	buttons = {
		{
			text = _G.OKAY
		},
	},
	show_while_dead = true,
	hide_on_escape = true,
	width = 360,
	text_justify_h = "LEFT",
	text_justify_v = "MIDDLE",
})

--
Dialog:Register("ARL_AllKnown", {
	text = L["ARL_ALLKNOWN"],
	buttons = {
		{
			text = _G.OKAY
		},
	},
	show_while_dead = true,
	hide_on_escape = true,
	width = 360,
	text_justify_h = "LEFT",
	text_justify_v = "MIDDLE",
})

--
Dialog:Register("ARL_AllExcluded", {
	text = L["ARL_ALLEXCLUDED"],
	buttons = {
		{
			text = _G.OKAY
		},
	},
	show_while_dead = true,
	hide_on_escape = true,
	width = 360,
	text_justify_h = "LEFT",
	text_justify_v = "MIDDLE",
})

--
Dialog:Register("ARL_SearchFiltered", {
	text = L["ARL_SEARCHFILTERED"],
	buttons = {
		{
			text = _G.OKAY
		},
	},
	show_while_dead = true,
	hide_on_escape = true,
	width = 360,
	text_justify_h = "LEFT",
	text_justify_v = "MIDDLE",
})

function private.DismissDialogs()
	-- Dialog:Dismiss("ARL_NotScanned") -- no longer used
	Dialog:Dismiss("ARL_AllFiltered")
	Dialog:Dismiss("ARL_AllKnown")
	Dialog:Dismiss("ARL_AllExcluded")
	Dialog:Dismiss("ARL_SearchFiltered")
end


-- ----------------------------------------------------------------------------
-- Frame creation and anchoring
-- ----------------------------------------------------------------------------
local SpellTooltip = _G.CreateFrame("GameTooltip", "AckisRecipeList_SpellTooltip", _G.UIParent, "GameTooltipTemplate")
local AcquireTooltip = _G.CreateFrame("GameTooltip", "AckisRecipeList_AcquireTooltip", _G.UIParent, "GameTooltipTemplate")

function private.InitializeListFrame()
	local MainPanel	= addon.Frame
	local ListFrame = private.CreateFrameWithBackdrop("Frame", nil, MainPanel)
	ListFrame:SetSize(LISTFRAME_WIDTH, 335)
	ListFrame:SetPoint("TOPLEFT", MainPanel, "TOPLEFT", 22, -75)
	local listBackdrop = {
		bgFile = [[Interface\DialogFrame\UI-DialogBox-Background-Dark]],
		tile = true,
		tileSize = 16,
	}
	private.BackdropUtil.SafeSetBackdrop(ListFrame, listBackdrop, {1, 1, 1, 1})
	ListFrame:EnableMouse(true)
	ListFrame:EnableMouseWheel(true)
	ListFrame:SetScript("OnHide", function(self)
		if acquire_tip and acquire_tip.Hide then
			acquire_tip:Hide()
		end
		SpellTooltip:Hide()
		_G.GameTooltip:Hide()
		self.selected_entry = nil

		if self.entries then
			for i = 1, #self.entries do
				local entry = self.entries[i]
				if entry and entry.children then
					private.ReleaseTable(entry.children)
					entry.children = nil
				end
			end
		end
	end)
	MainPanel.list_frame = ListFrame
	private.list_frame = ListFrame

	-- ----------------------------------------------------------------------------
	-- Scroll bar.
	-- ----------------------------------------------------------------------------
	local ScrollBar = _G.CreateFrame("Slider", nil, ListFrame)

	ScrollBar:SetPoint("TOPLEFT", ListFrame, "TOPRIGHT", 5, -11)
	ScrollBar:SetPoint("BOTTOMLEFT", ListFrame, "BOTTOMRIGHT", 5, 12)
	ScrollBar:SetWidth(24)

	ScrollBar:EnableMouseWheel(true)
	ScrollBar:SetOrientation("VERTICAL")

	ScrollBar:SetThumbTexture([[Interface\Buttons\UI-ScrollBar-Knob]])
	ScrollBar:SetMinMaxValues(0, 1)
	ScrollBar:SetValueStep(1)

	ListFrame.scroll_bar = ScrollBar

	local ScrollUpButton = _G.CreateFrame("Button", nil, ScrollBar, "UIPanelScrollUpButtonTemplate")

	ScrollUpButton:SetHeight(16)
	ScrollUpButton:SetWidth(18)
	ScrollUpButton:SetPoint("BOTTOM", ScrollBar, "TOP", 0, -4)

	local ScrollDownButton = _G.CreateFrame("Button", nil, ScrollBar,"UIPanelScrollDownButtonTemplate")

	ScrollDownButton:SetHeight(16)
	ScrollDownButton:SetWidth(18)
	ScrollDownButton:SetPoint("TOP", ScrollBar, "BOTTOM", 0, 4)

	local function ScrollBar_Scroll(delta)
		if not ScrollBar:IsShown() then
			return
		end
		local cur_val = ScrollBar:GetValue()
		local min_val, max_val = ScrollBar:GetMinMaxValues()

		if delta < 0 and cur_val < max_val then
			cur_val = math.min(max_val, cur_val + SCROLL_DEPTH)
			ScrollBar:SetValue(cur_val)
		elseif delta > 0 and cur_val > min_val then
			cur_val = math.max(min_val, cur_val - SCROLL_DEPTH)
			ScrollBar:SetValue(cur_val)
		end
	end

	ScrollUpButton:SetScript("OnClick", function(self, _, _)
		if _G.IsAltKeyDown() then
			local min_val = ScrollBar:GetMinMaxValues()
			ScrollBar:SetValue(min_val)
		else
			ScrollBar_Scroll(1)
		end
	end)

	ScrollDownButton:SetScript("OnClick", function(self, _, _)
		if _G.IsAltKeyDown() then
			local _, max_val = ScrollBar:GetMinMaxValues()
			ScrollBar:SetValue(max_val)
		else
			ScrollBar_Scroll(-1)
		end
	end)

	ScrollBar:SetScript("OnMouseWheel", function(self, delta)
		ScrollBar_Scroll(delta)
	end)

	ListFrame:SetScript("OnMouseWheel", function(self, delta)
		ScrollBar_Scroll(delta)
	end)

	-- This can be called either from ListFrame's OnMouseWheel script, manually
	-- sliding the thumb, or from clicking the up/down buttons.
	ScrollBar:SetScript("OnValueChanged", function(self, value)
		local min_val, max_val = self:GetMinMaxValues()

		if value == min_val then
			ScrollUpButton:Disable()
			ScrollDownButton:Enable()
		elseif value == max_val then
			ScrollUpButton:Enable()
			ScrollDownButton:Disable()
		else
			ScrollUpButton:Enable()
			ScrollDownButton:Enable()
		end
		MainPanel.current_tab:SetScrollValue(private.CurrentProfession, value)
		ListFrame:Update(nil, true)
	end)

	local function Bar_OnEnter(self)
		if ListFrame.selected_entry then
			return
		end
		if not self or not self.entry_index or self.entry_index == 0 then
			return
		end
		ListItem_ShowTooltip(ListFrame.entries[self.entry_index])
	end

	local function Bar_OnLeave()
		if ListFrame.selected_entry then
			return
		end
		if acquire_tip and acquire_tip.Hide then
			acquire_tip:Hide()
		end
		SpellTooltip:Hide()
	end

	local function ListItem_OnClick(self, button, down)
		local clickedIndex = self.entry_index

		if not clickedIndex or clickedIndex == 0 then
			return
		end
		local listEntry = ListFrame.entries[clickedIndex]
		local recipe = listEntry.recipe

		if button == "RightButton" and recipe and (not listEntry.parent or listEntry.parent.recipe ~= listEntry.recipe) then
			local old_selected = ListFrame.selected_entry
			local entry_button = listEntry.button

			ListFrame.selected_entry = nil

			if old_selected and old_selected.button then
				old_selected.button.selected_texture:Hide()
				Bar_OnLeave()
			end
			if entry_button then
				Bar_OnEnter(entry_button)
			end

			if old_selected ~= listEntry then
				entry_button.selected_texture:Show()
				ListFrame.selected_entry = listEntry
			end
		elseif recipe and _G.IsModifierKeyDown() then
            local hyperLink

            if _G.IsControlKeyDown() then
				if _G.IsShiftKeyDown() and recipe:HasCoordinates() then
					addon:AddWaypoint(recipe, listEntry:AcquireType(), listEntry:Location(), listEntry:NPCID())
                else
                    hyperLink = _G.GetSpellLink(recipe:SpellID())
				end
			elseif _G.IsShiftKeyDown() then
				local craftedItemID = recipe:CraftedItem()
				if craftedItemID then
					local _, itemLink = _G.GetItemInfo(craftedItemID)
					if itemLink then
                        hyperLink = itemLink
					else
						addon:Print(L["NoItemLink"])
					end
				else
					addon:Print(L["NoItemLink"])
				end
			elseif _G.IsAltKeyDown() then
				local exclusion_list = addon.db.profile.exclusionlist
				local recipeSpellID = recipe:SpellID()

				exclusion_list[recipeSpellID] = (not exclusion_list[recipeSpellID] and true or nil)
				ListFrame:Update(nil, false)
            end

            if hyperLink and not _G.ChatEdit_InsertLink(hyperLink) then
                local editBox = _G.ChatEdit_ChooseBoxForSend()

                _G.ChatEdit_ActivateChat(editBox)
                editBox:Insert(hyperLink)
            end
        else
            local currentTab = MainPanel.current_tab
            if listEntry.is_expanded then
                listEntry:CollapseChildren()
                currentTab:SaveListEntryState(listEntry, false)
                listEntry.is_expanded = false
            else
                currentTab:ExpandListEntry(listEntry)
                listEntry.is_expanded = true
            end
		end

		ListFrame:Update(nil, true)
	end

	-- ----------------------------------------------------------------------------
	-- The state and entry buttons and the container frames which hold them.
	-- ----------------------------------------------------------------------------
    local ListEntryButtonContainers = {}
    ListFrame.entries = {}
	ListFrame.ListEntryButtons = {}

	for index = 1, NUM_RECIPE_LINES do
		local buttonContainer = _G.CreateFrame("Frame", nil, ListFrame)
		buttonContainer:SetSize(LIST_ENTRY_WIDTH, 16)

        if index == 1 then
            buttonContainer:SetPoint("TOPLEFT", ListFrame, "TOPLEFT", 0, -3)
        else
            buttonContainer:SetPoint("TOPLEFT", ListEntryButtonContainers[index - 1], "BOTTOMLEFT", 0, 3)
        end

		local stateButton = _G.CreateFrame("Button", nil, ListFrame)
		stateButton:SetSize(16, 16)
        stateButton:SetPoint("LEFT", buttonContainer, "LEFT", 0, 0)
        stateButton:SetScript("OnClick", ListItem_OnClick)

        stateButton.container = buttonContainer

        local listEntry = _G.CreateFrame("Button", ("%s_ListEntryButton%d"):format(FOLDER_NAME, index), buttonContainer)
		listEntry:SetSize(LIST_ENTRY_WIDTH, 16)
        listEntry:SetPoint("LEFT", stateButton, "RIGHT", -3, 0)
        listEntry:RegisterForClicks("AnyUp")

        listEntry.stateButton = stateButton
        stateButton.listEntry = listEntry

		local highlightTexture = listEntry:CreateTexture(nil, "BORDER")
		highlightTexture:SetTexture([[Interface\ClassTrainerFrame\TrainerTextures]])
		highlightTexture:SetTexCoord(0.00195313, 0.57421875, 0.75390625, 0.84570313)
		highlightTexture:SetBlendMode("ADD")
		highlightTexture:SetPoint("TOPLEFT", 2, 0)
		highlightTexture:SetPoint("BOTTOMRIGHT", -2, 1)
		listEntry:SetHighlightTexture(highlightTexture)

		local selectedTexture = listEntry:CreateTexture(nil, "BORDER")
		selectedTexture:SetTexture([[Interface\ClassTrainerFrame\TrainerTextures]])
		selectedTexture:SetTexCoord(0.00195313, 0.57421875, 0.84960938, 0.94140625)
		selectedTexture:SetBlendMode("ADD")
		selectedTexture:SetPoint("TOPLEFT", 2, 0)
		selectedTexture:SetPoint("BOTTOMRIGHT", -2, 1)
		listEntry.selected_texture = selectedTexture

		local emphasisTexture = listEntry:CreateTexture(nil, "BORDER")
		emphasisTexture:SetTexture([[Interface\QUESTFRAME\Ui-QuestLogTitleHighlight]])
		emphasisTexture:SetVertexColor(1, 0.61, 0)
		emphasisTexture:SetBlendMode("ADD")
		emphasisTexture:SetPoint("TOPLEFT", 2, 0)
		emphasisTexture:SetPoint("BOTTOMRIGHT", -2, 1)
		listEntry.emphasis_texture = emphasisTexture

        local titleBackgroundTexture = listEntry:CreateTexture(nil, "ARTWORK")
        titleBackgroundTexture:SetAtlas("Objective-Header", false)
        titleBackgroundTexture:SetPoint("TOPLEFT", -9, 5)
        titleBackgroundTexture:SetPoint("BOTTOMRIGHT", 9, -23)
        listEntry.titleBackgroundTexture = titleBackgroundTexture

		local label = listEntry:CreateFontString(nil, "ARTWORK")
		label:SetPoint("LEFT", listEntry, "LEFT", 7, 0)
		label:SetPoint("RIGHT", listEntry, "RIGHT", -7, 0)
		label:SetFontObject("GameFontNormalSmall")
		label:SetJustifyH("LEFT")
		label:SetJustifyV("MIDDLE")
		label:SetWordWrap(false)

		listEntry:SetFontString(label)
		listEntry.text = label

		ListEntryButtonContainers[index] = buttonContainer
		ListFrame.ListEntryButtons[index] = listEntry
	end

	function ListFrame:InsertEntry(entry, entry_index, entry_expanded, expand_mode)
		local insert_index = entry_index
		entry.index = entry_index

		-- If we have acquire information for this entry, push the data table into the list
		-- and start processing the acquires.
		if expand_mode then
			entry.is_expanded = true
			table.insert(self.entries, insert_index, entry)

			if entry:IsHeader() or entry:IsSubHeader() then
				insert_index = MainPanel.current_tab:ExpandListEntry(entry, expand_mode)
			else
				MainPanel.current_tab:SaveListEntryState(entry, entry_expanded)
				insert_index = insert_index + 1
			end
		else
			entry.is_expanded = entry_expanded
			table.insert(self.entries, insert_index, entry)

			insert_index = insert_index + 1
		end
		return insert_index
	end

	-- ----------------------------------------------------------------------------
	-- Filter flag data and functions for ListFrame:Initialize()
	-- ----------------------------------------------------------------------------
		function ListFrame:Initialize(expand_mode)
			for i = 1, #self.entries do
				private.ReleaseTable(self.entries[i])
			end
			table.wipe(self.entries)

			-- ----------------------------------------------------------------------------
			-- Update recipe filters.
			-- ----------------------------------------------------------------------------
			local general_filters = addon.db.profile.filters.general
			local professionRecipes = private.CurrentProfession.Recipes
			local recipes_known, recipes_known_filtered = 0, 0
			local recipes_total, recipes_total_filtered = 0, 0

			for _, recipe in pairs(professionRecipes) do
				local can_display = false
				recipe:RemoveState("VISIBLE")

				if not recipe:HasState("IGNORED") then
					recipes_total = recipes_total + 1

					local is_known

					if MainPanel.is_linked then
						is_known = recipe:HasState("LINKED")
					else
						is_known = recipe:HasState("KNOWN")
					end
					recipes_known = recipes_known + (is_known and 1 or 0)

					can_display = recipe:CanDisplay()

					if can_display then
						recipes_total_filtered = recipes_total_filtered + 1
						recipes_known_filtered = recipes_known_filtered + (is_known and 1 or 0)

						if not general_filters.known and is_known then
							can_display = false
						end

						if not general_filters.unknown and not is_known then
							can_display = false
						end
					end
				end

				if can_display then
					recipe:AddState("VISIBLE")
				end
			end
			local player = private.Player
			player.recipes_total = recipes_total
			player.recipes_known = recipes_known
			player.recipes_total_filtered = recipes_total_filtered
			player.recipes_known_filtered = recipes_known_filtered

			-- ----------------------------------------------------------------------------
			-- Mark all exclusions in the recipe database to not be displayed, and update
			-- the player's known and unknown counts.
			-- ----------------------------------------------------------------------------
			local known_count = 0
			local unknown_count = 0

			for recipeSpellID in pairs(addon.db.profile.exclusionlist) do
				local recipe = professionRecipes[recipeSpellID]
				if recipe then
					if recipe:HasState("KNOWN") then
						known_count = known_count + 1
					else
						unknown_count = unknown_count + 1
					end
				end
			end
			player.excluded_recipes_known = known_count
			player.excluded_recipes_unknown = unknown_count

			-- ----------------------------------------------------------------------------
			-- Initialize the expand button and entries for the current tab.
			-- ----------------------------------------------------------------------------
            local currentTab = MainPanel.tabs[addon.db.profile.current_tab]
            local professionExpandButton = currentTab["expand_button_" .. private.CurrentProfession:LocalizedName()]

			if acquire_tip and acquire_tip.Hide then
				acquire_tip:Hide()
			end
			SpellTooltip:Hide()
			self.selected_entry = nil

			if professionExpandButton then
				MainPanel.expand_button:Expand(currentTab)
			else
				MainPanel.expand_button:Contract(currentTab)
			end
			local recipe_count = currentTab:Initialize(expand_mode)

			-- ----------------------------------------------------------------------------
			-- Update the progress bar display.
			-- ----------------------------------------------------------------------------
			local profile = addon.db.profile
			local max_value = profile.includefiltered and player.recipes_total or (player.recipes_total_filtered + (player.recipes_known - player.recipes_known_filtered))
			local cur_value = player.recipes_known	-- Current value will always be what we know regardless of filters.

			if not profile.includeexcluded and not profile.ignoreexclusionlist then
				max_value = max_value - player.excluded_recipes_known
			end
			local progress_bar = MainPanel.progress_bar

			progress_bar:SetMinMaxValues(0, max_value)
			progress_bar:SetValue(cur_value)

			local percentage = 0
			if max_value > 0 then
				percentage = (cur_value / max_value) * 100
			end

			if (max_value > 0) and (math.floor(percentage) < 101) and (cur_value >= 0) then
				local results = _G.SINGLE_PAGE_RESULTS_TEMPLATE:format(recipe_count)
				progress_bar.text:SetFormattedText("%d/%d - %1.2f%% (%s)", cur_value, max_value, percentage, results)
			else
				progress_bar.text:SetFormattedText("%s", L["NOT_YET_SCANNED"])
			end
		end

	-- Reset the current buttons/lines
	function ListFrame:ClearLines()
		for index = 1, NUM_RECIPE_LINES do
			local entry = self.ListEntryButtons[index]
			entry.text:SetFontObject(addon.db.profile.frameopts.small_list_font and "GameFontNormalSmall" or "GameFontNormal")
            entry.text:SetJustifyH("LEFT")
            entry:SetText("")
            entry:SetScript("OnEnter", nil)
            entry:SetScript("OnLeave", nil)
            entry:SetScript("OnClick", nil)
            entry:SetWidth(LIST_ENTRY_WIDTH)
            entry:Disable()
            entry.emphasis_texture:Hide()
            entry.selected_texture:Hide()
            entry.titleBackgroundTexture:Hide()
            entry.button = nil
            entry.entry_index = 0

			local stateButton = entry.stateButton
			stateButton.entry_index = 0
			stateButton:Hide()
			stateButton:Disable()
			stateButton:ClearAllPoints()
		end
	end

	function ListFrame:Update(expand_mode, refresh)
        if refresh then
            local writeIndex = 1
            for readIndex = 1, #self.entries do
                local entry = self.entries[readIndex]
                if entry._discard then
                    private.ReleaseTable(entry)
                else
                    if writeIndex ~= readIndex then
                        self.entries[writeIndex] = entry
                    end
                    writeIndex = writeIndex + 1
                end
            end
            for i = writeIndex, #self.entries do
                self.entries[i] = nil
            end
        else
            self:Initialize(expand_mode)
        end

		local listEntryCount = #self.entries

		if listEntryCount == 0 then
			self:ClearLines()

			-- disable expand button, it's useless here and would spam the same error again
			MainPanel.expand_button:SetNormalFontObject("GameFontDisableSmall")
			MainPanel.expand_button:Disable()
			self.scroll_bar:Hide()

			local showpopup = false

			if not addon.db.profile.hidepopup then
				showpopup = true
			end

			-- If we haven't run this before we'll show pop-ups for the first time.
			if addon.db.profile.addonversion ~= addon.version then
				addon.db.profile.addonversion = addon.version
				showpopup = true
			end
			local editbox_text = MainPanel.search_editbox:GetText()
			local player = private.Player

			if player.recipes_total == 0 then
				-- Do not show any popup when nothing has been scanned; scanning starts automatically
			elseif player.recipes_known == player.recipes_total then
				if showpopup then
					Dialog:Spawn("ARL_AllKnown")
				end
			elseif (player.recipes_total_filtered - player.recipes_known_filtered) == 0 then
				if showpopup then
					Dialog:Spawn("ARL_AllFiltered")
				end
			elseif player.excluded_recipes_unknown ~= 0 then
				if showpopup then
					Dialog:Spawn("ARL_AllExcluded")
				end
			elseif editbox_text ~= "" and editbox_text ~= _G.SEARCH then
				Dialog:Spawn("ARL_SearchFiltered")
			else
				addon:Print(L["NO_DISPLAY"])
			end
			return
		end
		local offset = 0

		private.DismissDialogs()

		MainPanel.expand_button:SetNormalFontObject("GameFontNormalSmall")
		MainPanel.expand_button:Enable()

		if listEntryCount <= NUM_RECIPE_LINES then
			self.scroll_bar:Hide()
		else
            local maxScrollValue = listEntryCount - NUM_RECIPE_LINES
            self.scroll_bar:SetMinMaxValues(0, math.max(0, maxScrollValue))

            local currentTab = MainPanel.current_tab
            local scrollValue = math.max(0, math.min(currentTab:ScrollValue(private.CurrentProfession) or 0, maxScrollValue))
            self.scroll_bar:SetValue(scrollValue)
            offset = scrollValue

			self.scroll_bar:Show()
		end
		self:ClearLines()

		local buttonIndex = 1
		local listEntryIndex = math.floor(buttonIndex + offset)

		-- Populate the buttons with new values
		while buttonIndex <= NUM_RECIPE_LINES and listEntryIndex <= listEntryCount do
            local listEntryButton = self.ListEntryButtons[buttonIndex]
			local listEntry = self.entries[listEntryIndex]
            local stateButton = listEntryButton.stateButton
            local isEntry = listEntry:IsEntry()
			local isSubentry = not isEntry and listEntry:IsSubEntry()
			local isHeader = not isSubentry and listEntry:IsHeader()
			local isSubheader = not isHeader and listEntry:IsSubHeader()
            local isTitle = not isSubheader and listEntry:IsTitle()

			if isHeader or isSubheader then
				stateButton:Show()

				if listEntry.is_expanded then
					stateButton:SetNormalTexture([[Interface\MINIMAP\UI-Minimap-ZoomOutButton-Up]])
					stateButton:SetPushedTexture([[Interface\MINIMAP\UI-Minimap-ZoomOutButton-Down]])
				else
					stateButton:SetNormalTexture([[Interface\MINIMAP\UI-Minimap-ZoomInButton-Up]])
					stateButton:SetPushedTexture([[Interface\MINIMAP\UI-Minimap-ZoomInButton-Down]])
				end
				stateButton:SetHighlightTexture([[Interface\MINIMAP\UI-Minimap-ZoomButton-Highlight]])
				stateButton.entry_index = listEntryIndex
				stateButton:Enable()
			else
				stateButton:Hide()
				stateButton:Disable()
			end

			if listEntry == ListFrame.selected_entry then
				listEntryButton.selected_texture:Show()
			end

            if isTitle then
                listEntryButton.titleBackgroundTexture:Show()
                listEntryButton.text:SetJustifyH("CENTER")
                listEntryButton.text:SetFontObject("QuestFont")
            elseif listEntry:IsEmphasized() then
                listEntryButton.emphasis_texture:Show()
			end

			if isTitle or isHeader or isEntry then
				stateButton:SetPoint("TOPLEFT", stateButton.container, "TOPLEFT", 0, 0)
            elseif isSubheader or isSubentry then
                stateButton:SetPoint("TOPLEFT", stateButton.container, "TOPLEFT", 15, 0)
                listEntryButton:SetWidth(LIST_ENTRY_WIDTH - 15)
			end
			listEntry.button = listEntryButton
			listEntryButton.entry_index = listEntryIndex

			listEntryButton:SetText(listEntry:Text())
			listEntryButton:SetScript("OnEnter", Bar_OnEnter)
			listEntryButton:SetScript("OnLeave", Bar_OnLeave)

            if not isTitle then
                listEntryButton:SetScript("OnClick", ListItem_OnClick)
                listEntryButton:Enable()
            end

			-- This function could possibly have been called from a mouse click or by scrolling. Since, in those cases, the list entries have
			-- changed, the mouse is likely over a different entry - a tooltip should be generated for it.
			if listEntryButton:IsMouseOver() then
				Bar_OnEnter(listEntryButton)
			end
			buttonIndex = buttonIndex + 1
			listEntryIndex = listEntryIndex + 1
		end
	end
end	-- InitializeListFrame()

-- ----------------------------------------------------------------------------
-- Tooltip functions and data.
-- ----------------------------------------------------------------------------
-- Font Objects needed for acquire_tip
local narrowFont
local normalFont

do
	local LSM3 = LibStub("LibSharedMedia-3.0", true)

	if LSM3 then
		narrowFont = LSM3:Fetch(LSM3.MediaType.FONT, "Arial Narrow")
		normalFont = LSM3:Fetch(LSM3.MediaType.FONT, "Friz Quadrata TT")
	else
		-- Fix for font issues on koKR
		if _G.GetLocale() == "koKR" then
			narrowFont = "Fonts\\2002.TTF"
			normalFont = "Fonts\\2002.TTF"
		else
			narrowFont = "Fonts\\ARIALN.TTF"
			normalFont = "Fonts\\FRIZQT__.TTF"
		end
	end
	local narrowFontObj = _G.CreateFont(("%s%s"):format(private.addon_name, "narrowFontObj"))
	local normalFontObj = _G.CreateFont(("%s%s"):format(private.addon_name, "normalFontObj"))

	-- I want to do a bit more comprehensive tooltip processing. Things like changing font sizes,
	-- adding padding to the left hand side, and using better color handling. So... this function
	-- will do that for me.
	--    leftPad,            -- number of times to pad two spaces on left side
	--    textSize,           -- add to or subtract from addon.db.profile.tooltip.acquire_fontsize to get fontsize
	--    useNarrowFont,      -- if 1, use ARIALN instead of FRITZQ
	--    leftText,           -- left-hand string
	--    leftColor,          -- color values for left-hand side
	--    rightText,          -- if present, this is the right-hand string
	--    rightColor)         -- if present, color vaues for right-hand side
	local function ttAdd(leftPad, textSize, useNarrowFont, leftText, leftColor, rightText, rightColor)
		leftText = ("    "):rep(leftPad or 0) .. (leftText or "")
		local r1, g1, b1 = leftColor.r, leftColor.g, leftColor.b
		if rightText then
			local r2, g2, b2 = rightColor.r, rightColor.g, rightColor.b
			acquire_tip:AddDoubleLine(leftText, tostring(rightText), r1, g1, b1, r2, g2, b2)
		else
			acquire_tip:AddLine(leftText, r1, g1, b1)
		end
	end

	-- ----------------------------------------------------------------------------
	-- Public API function for displaying a recipe's acquire data.
	-- * The addline_func paramater must be a function which accepts the same
	-- * arguments as ARL's ttAdd function.
	-- ----------------------------------------------------------------------------
	function addon:DisplayAcquireData(recipeSpellID, acquireTypeID, localizedLocationName, addline_func)
		local recipe = private.recipe_list[recipeSpellID]
		if not recipe then
			return
		end

        for acquireType, acquireData in recipe:AcquirePairs() do
			if not acquireTypeID or acquireType:ID() == acquireTypeID then
				local count = 0

				for identifier, info in pairs(acquireData) do
					acquireType:InsertTooltipText(recipe, identifier, localizedLocationName, info, addline_func)
					count = count + 1
				end

				if count == 0 then
					acquireType:InsertTooltipText(recipe, nil, localizedLocationName, nil, addline_func)
				end
			end
		end
	end

	-- ----------------------------------------------------------------------------
	-- Main tooltip function.
	-- ----------------------------------------------------------------------------
	local function InitializeTooltips(recipe)
		local spellTooltipAnchor = addon.db.profile.spelltooltiplocation
		local acquireTooltipAnchor = addon.db.profile.acquiretooltiplocation
		local spellHyperlink = _G.GetSpellLink(recipe:SpellID())
		local MainPanel = addon.Frame
	local spellTooltipOwner

		if acquireTooltipAnchor == _G.OFF then
			if acquire_tip and acquire_tip.Hide then acquire_tip:Hide() end
			spellTooltipOwner = MainPanel
		else
			acquire_tip = AcquireTooltip
			acquire_tip:SetOwner(MainPanel, "ANCHOR_NONE")
			acquire_tip:ClearAllPoints()
			acquire_tip:ClearLines()
			acquire_tip:SetScale(addon.db.profile.tooltip.scale or 1)

			if _G.TipTac and _G.TipTac.AddModifiedTip then
				_G.TipTac:AddModifiedTip(acquire_tip, true)
			end

			if acquireTooltipAnchor == "Right" then
				acquire_tip:SetPoint("TOPLEFT", MainPanel, "TOPRIGHT", MainPanel.is_expanded and -90 or -35, 0)
			elseif acquireTooltipAnchor == "Left" then
				acquire_tip:SetPoint("TOPRIGHT", MainPanel, "TOPLEFT")
			elseif acquireTooltipAnchor == "Top" then
				acquire_tip:SetPoint("BOTTOMLEFT", MainPanel, "TOPLEFT")
			elseif acquireTooltipAnchor == "Bottom" then
				acquire_tip:SetPoint("TOPLEFT", MainPanel, "BOTTOMLEFT", 0, 55)
			elseif acquireTooltipAnchor == "Mouse" then
				local x, y = _G.GetCursorPosition()
				local uiscale = _G.UIParent:GetEffectiveScale()
				acquire_tip:SetPoint("BOTTOMLEFT", _G.UIParent, "BOTTOMLEFT", x / uiscale, y / uiscale)
			end

			spellTooltipOwner = acquire_tip
		end

		-- If we have the spell link tooltip, link it to the acquire tooltip.
		if spellTooltipAnchor == _G.OFF then
			SpellTooltip:Hide()
		elseif spellHyperlink then
            SpellTooltip:SetOwner(spellTooltipOwner, "ANCHOR_NONE")
            SpellTooltip:ClearAllPoints()

            if spellTooltipAnchor == "Top" then
                SpellTooltip:SetPoint("BOTTOMLEFT", spellTooltipOwner, "TOPLEFT")
            elseif spellTooltipAnchor == "Bottom" then
                SpellTooltip:SetPoint("TOPLEFT", spellTooltipOwner, "BOTTOMLEFT")
            elseif spellTooltipAnchor == "Left" then
                SpellTooltip:SetPoint("TOPRIGHT", spellTooltipOwner, "TOPLEFT")
            elseif spellTooltipAnchor == "Right" then
                SpellTooltip:SetPoint("TOPLEFT", spellTooltipOwner, "TOPRIGHT")
            end

            -- Add TipTac Support
            if _G.TipTac and _G.TipTac.AddModifiedTip and not SpellTooltip.tiptac then
                _G.TipTac:AddModifiedTip(SpellTooltip)
                SpellTooltip.tiptac = true
            end

            -- Set the spell tooltip's scale, and copy its other values from GameTooltip so AddOns which modify it will work.
--            SpellTooltip:SetBackdrop(nil)
--            SpellTooltip:SetBackdrop(_G.GameTooltip:GetBackdrop() or nil)
--            SpellTooltip:SetBackdropColor(_G.GameTooltip:GetBackdropColor() or nil)
--            SpellTooltip:SetBackdropBorderColor(_G.GameTooltip:GetBackdropBorderColor() or nil)
--            SpellTooltip:SetScale(addon.db.profile.tooltip.scale)
 --           SpellTooltip:SetClampedToScreen(true)
 --           SpellTooltip:SetHyperlink(spellHyperlink)
            SpellTooltip:Show()
		end
	end

	local ITEM_BINDING_TYPES = {
		BIND_ON_EQUIP = L["BOEFilter"],
		BIND_ON_PICKUP = L["BOPFilter"],
	}

	local RECIPE_BINDING_TYPES = {
		BIND_ON_EQUIP = L["RecipeBOEFilter"],
		BIND_ON_PICKUP = L["RecipeBOPFilter"],
	}

	function ListItem_ShowTooltip(listEntry)
		if not listEntry then
			return
		end
		local recipe = listEntry.recipe

		if not recipe then
			return
		end
		InitializeTooltips(recipe)

	if not acquire_tip then
			return
		end
	acquire_tip:ClearLines()
	local name = recipe:LocalizedName()
	--
	local r,g,b = _G.GetItemQualityColor(recipe:QualityID())
	acquire_tip:AddLine(name, r, g, b)

		--
		local recipe_item_texture = recipe.crafted_item_id and select(10, _G.GetItemInfo(recipe.crafted_item_id))

		if recipe_item_texture then
			acquire_tip:AddLine(("|T%s:30:30|t"):format(recipe_item_texture))
		end

		if addon.db.profile.exclusionlist[recipe:SpellID()] then
			ttAdd(0, -1, true, L["RECIPE_EXCLUDED"], private.DIFFICULTY_COLORS.impossible)
		end

		-- Add in skill level requirement, colored correctly
		local skill_level = private.current_profession_scanlevel
		local color_type

		if recipe.skill_level > skill_level then
			color_type = "impossible"
		elseif skill_level >= recipe.trivial_level then
			color_type = "trivial"
		elseif skill_level >= recipe.easy_level then
			color_type = "easy"
		elseif skill_level >= recipe.medium_level then
			color_type = "medium"
		elseif skill_level >= recipe.optimal_level then
			color_type = "optimal"
		else
			color_type = "trivial"
		end
		ttAdd(0, -1, false, ("%s:"):format(_G.SKILL_LEVEL), BASIC_COLORS.normal, recipe.skill_level, private.DIFFICULTY_COLORS[color_type])
	acquire_tip:AddLine(" ")

		local _, recipe_item_binding = recipe:RecipeItem()

		if recipe_item_binding then
			ttAdd(0, -1, true, RECIPE_BINDING_TYPES[recipe_item_binding], BASIC_COLORS.normal)
		end

			local _, crafted_item_binding = recipe:CraftedItem()

		if crafted_item_binding then
			ttAdd(0, -1, true, ITEM_BINDING_TYPES[crafted_item_binding], BASIC_COLORS.normal)
		end

	acquire_tip:AddLine(" ")

		local recipe_specialty = recipe.specialty

		if recipe_specialty then
			local color_table = (recipe_specialty == private.current_profession_specialty) and BASIC_COLORS.white or private.DIFFICULTY_COLORS.impossible
			ttAdd(0, -1, false, _G.ITEM_REQ_SKILL:format(_G.GetSpellInfo(recipe_specialty)), color_table)
			acquire_tip:AddLine(" ")
		end
        ttAdd(0, -1, false, _G.SOURCES .. _G.HEADER_COLON, BASIC_COLORS.normal)

		local listEntryAcquireType = listEntry:AcquireType()
        local listEntryLocation = listEntry:Location()
		addon:DisplayAcquireData(recipe:SpellID(), listEntryAcquireType and listEntryAcquireType:ID() or nil, listEntryLocation and listEntryLocation:LocalizedName() or nil, ttAdd)

		if not addon.db.profile.hide_tooltip_hint then
			local hint_color = private.CATEGORY_COLORS.hint

			acquire_tip:AddLine(" ")
			acquire_tip:AddLine(" ")

			ttAdd(0, -1, 0, L["CLICK"], hint_color)
			ttAdd(0, -1, 0, L["ALT_CLICK"], hint_color)
			ttAdd(0, -1, 0, L["CTRL_CLICK"], hint_color)
			ttAdd(0, -1, 0, L["SHIFT_CLICK"], hint_color)

			if recipe:HasCoordinates() and _G.TomTom and (addon.db.profile.worldmap or addon.db.profile.minimap) then
				ttAdd(0, -1, 0, L["CTRL_SHIFT_CLICK"], hint_color)
			end
		end
	acquire_tip:Show()
	end
end	-- do
