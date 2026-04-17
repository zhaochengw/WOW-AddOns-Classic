--[[
Copyright (c) 2009 - 2012 Ackis <John Pasula>
All rights reserved by the original author Ackis.
]]

-- ----------------------------------------------------------------------------
-- Localized Lua globals.
-- ----------------------------------------------------------------------------
local select = _G.select

local math = _G.math
local table = _G.table

local ipairs, pairs = _G.ipairs, _G.pairs

local tonumber = _G.tonumber
local tostring = _G.tostring

-- Use _G.SOUNDKIT directly when available (guarded where used)

-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local FOLDER_NAME, private	= ...

local LibStub = _G.LibStub
local addon	= LibStub("AceAddon-3.0"):GetAddon(private.addon_name)
local L		= LibStub("AceLocale-3.0"):GetLocale(private.addon_name)

function private.InitializeFrame()
	-- ----------------------------------------------------------------------------
	-- Create the MainPanel and set its values
	-- ----------------------------------------------------------------------------
	local MainPanel = private.CreateFrameWithBackdrop("Frame", "ARL_MainPanel", _G.UIParent)

	-- The panel width changes when contracting and expanding - store it for later use.
	MainPanel.normal_width = 384
	MainPanel.expanded_width = 768

	MainPanel:SetWidth(MainPanel.normal_width)
	MainPanel:SetHeight(512)
	MainPanel:SetFrameStrata("MEDIUM")
	MainPanel:SetToplevel(true)
	MainPanel:SetClampedToScreen(true)
	MainPanel:SetClampRectInsets(0, -35, 0, 53)

	MainPanel:SetHitRectInsets(0, 35, 0, 53)
	MainPanel:EnableMouse(true)
	MainPanel:EnableKeyboard(true)
	MainPanel:SetMovable(true)

	MainPanel.is_expanded = false

	-- Let the user banish the MainPanel with the ESC key.
	table.insert(_G.UISpecialFrames, "ARL_MainPanel")
	addon.Frame = MainPanel

	do
		local top_left = MainPanel:CreateTexture(nil, "OVERLAY")
		top_left:SetTexture("Interface\\QuestFrame\\UI-QuestLog-TopLeft")
		top_left:SetPoint("TOPLEFT", MainPanel, "TOPLEFT", 0, 0)
		MainPanel.top_left = top_left

		local top_right = MainPanel:CreateTexture(nil, "OVERLAY")
		top_right:SetTexture("Interface\\QuestFrame\\UI-QuestLog-TopRight")
		top_right:SetPoint("TOPRIGHT", MainPanel, "TOPRIGHT", 0, 0)
		MainPanel.top_right = top_right

		local bottom_left = MainPanel:CreateTexture(nil, "OVERLAY")
		bottom_left:SetTexture("Interface\\QuestFrame\\UI-QuestLog-BotLeft")
		bottom_left:SetPoint("BOTTOMLEFT", MainPanel, "BOTTOMLEFT", 0, 0)
		MainPanel.bottom_left = bottom_left

		local bottom_right = MainPanel:CreateTexture(nil, "OVERLAY")
		bottom_right:SetTexture("Interface\\QuestFrame\\UI-QuestLog-BotRight")
		bottom_right:SetPoint("BOTTOMRIGHT", MainPanel, "BOTTOMRIGHT", 0, 0)
		MainPanel.bottom_right = bottom_right

		local title_bar = MainPanel:CreateFontString(nil, "OVERLAY")
		title_bar:SetFontObject("GameFontHighlightSmall")
		title_bar:SetPoint("TOPLEFT", MainPanel, "TOPLEFT", 20, -20)
		title_bar:SetPoint("TOPRIGHT", MainPanel, "TOPRIGHT", -40, -20)
		title_bar:SetJustifyH("CENTER")
		MainPanel.title_bar = title_bar

		MainPanel:Hide()
	end	-- do block

	-- ----------------------------------------------------------------------------
	-- MainPanel scripts/functions.
	-- ----------------------------------------------------------------------------
	MainPanel:SetScript("OnHide", function(self)
		private.DismissDialogs()
		private.CleanupPanel()
		private.UnregisterUIEvents()
	end)

	MainPanel:SetScript("OnMouseDown", MainPanel.StartMoving)

	MainPanel:SetScript("OnMouseUp", function(self, button)
		self:StopMovingOrSizing()

		local opts = addon.db.profile.frameopts
		local from, _, to, x, y = self:GetPoint()

		opts.anchorFrom = from
		opts.anchorTo = to

		if self.is_expanded then
			if opts.anchorFrom == "TOPLEFT" or opts.anchorFrom == "LEFT" or opts.anchorFrom == "BOTTOMLEFT" then
				opts.offsetx = x
			elseif opts.anchorFrom == "TOP" or opts.anchorFrom == "CENTER" or opts.anchorFrom == "BOTTOM" then
				opts.offsetx = x - 151 / 2
			elseif opts.anchorFrom == "TOPRIGHT" or opts.anchorFrom == "RIGHT" or opts.anchorFrom == "BOTTOMRIGHT" then
				opts.offsetx = x - 151
			end
		else
			opts.offsetx = x
		end
		opts.offsety = y
	end)

	-- ----------------------------------------------------------------------------
	-- Displays the main GUI frame.
	-- ----------------------------------------------------------------------------
	function MainPanel:Display(isTradeSkillLinked)
		self.is_linked = isTradeSkillLinked
		self.prof_button:SetTexture()

		local editbox = self.search_editbox
        if private.CurrentProfession ~= private.PreviousProfession then
			editbox.prev_search = nil
		end

		if editbox.prev_search then
			editbox:SetText(editbox.prev_search)
		end

		-- The first time this function is called, everything in the expanded section of the MainPanel must be created.
		if private.InitializeFilterPanel then
			private.InitializeFilterPanel()
        end
        local currentProfession = private.CurrentProfession
		local professionModule = currentProfession:Module()
		local panel

		if professionModule.InitializeItemFilters then
			local panelName = "items_" .. currentProfession:Name():lower()
			panel = self.filter_menu:CreateSubMenu(panelName)

			self.filter_menu.item[panelName] = self.filter_menu[panelName]
			self.filter_menu[panelName] = nil

            professionModule:InitializeItemFilters(panel)
		else
			panel = self.filter_menu.item["items_" .. currentProfession:Name():lower()]
		end
		private.UpdateFilterMarks()

		if panel then
			self.menu_toggle_item.icon_texture:SetVertexColor(1, 1, 1)
			self.menu_toggle_item.bg_texture:SetVertexColor(1, 1, 1)
			self.menu_toggle_item:Enable()

			if self.filter_menu.item:IsVisible() then
				self.filter_menu.item:Hide()
				self.filter_menu.item:Show()
			end
		else
			self.menu_toggle_item.icon_texture:SetVertexColor(0.50, 0.50, 0.50)
			self.menu_toggle_item.bg_texture:SetVertexColor(0.50, 0.50, 0.50)
			self.menu_toggle_item:Disable()

			if self.filter_menu.item:IsVisible() then
				self.filter_menu.item:Hide()
				self.menu_toggle_item:SetChecked(false)

				self.menu_toggle_general:SetChecked(true)
				self.filter_menu.general:Show()
				self.filter_menu:Show()
			end
		end

		-- If there is no current tab, this is the first time the panel has been
		-- shown so things must be initialized. In this case, MainPanel.list_frame:Update()
		-- will be called by the tab's OnClick handler.
		if self.current_tab then
			self.list_frame:Update(nil, false)
		else
			local currentTab = self.tabs[addon.db.profile.current_tab]
			currentTab:GetScript("OnClick")(currentTab)

			self.current_tab = currentTab
		end
		self.sort_button:SetTextures()
		self.filter_toggle:SetTextures()

		self:UpdateTitle()
		-- Refresh portrait texture explicitly to avoid any external interference.
		if self.prof_button and self.prof_button.SetTexture then
			self.prof_button:SetTexture()
		end
		self:Show()
	end

	do
		-- ----------------------------------------------------------------------------
		-- Restore the panel's position on the screen.
		-- ----------------------------------------------------------------------------
		local function Reset_Position(self)
			local opts = addon.db.profile.frameopts
			local FixedOffsetX = opts.offsetx

			self:ClearAllPoints()

			if opts.anchorTo == "" then	-- no values yet, clamp to whatever frame is appropriate
				if _G.ATSWFrame then
					self:SetPoint("CENTER", _G.ATSWFrame, "CENTER", 490, 0)
				elseif _G.CauldronFrame then
					self:SetPoint("CENTER", _G.CauldronFrame, "CENTER", 490, 0)
				elseif _G.Skillet then
					self:SetPoint("CENTER", _G.SkilletFrame, "CENTER", 468, 0)
				else
					self:SetPoint("TOPLEFT", _G.TradeSkillFrame, "TOPRIGHT", 10, 0)
				end
			else
				if self.is_expanded then
					if opts.anchorFrom == "TOPLEFT" or opts.anchorFrom == "LEFT" or opts.anchorFrom == "BOTTOMLEFT" then
						FixedOffsetX = opts.offsetx
					elseif opts.anchorFrom == "TOP" or opts.anchorFrom == "CENTER" or opts.anchorFrom == "BOTTOM" then
						FixedOffsetX = opts.offsetx + 151/2
					elseif opts.anchorFrom == "TOPRIGHT" or opts.anchorFrom == "RIGHT" or opts.anchorFrom == "BOTTOMRIGHT" then
						FixedOffsetX = opts.offsetx + 151
					end
				end
				self:SetPoint(opts.anchorFrom, _G.UIParent, opts.anchorTo, FixedOffsetX, opts.offsety)
			end
			self:SetScale(addon.db.profile.frameopts.uiscale)
		end

		MainPanel:SetScript("OnShow", function(self)
			Reset_Position(self)
			private.RegisterUIEvents()
		end)
	end	-- do-block

	do
		local VALID_CATEGORY = {
			["general"]	= true,
			["obtain"]	= true,
			["binding"]	= true,
			["item"]	= true,
			["quality"]	= true,
			["player"]	= true,
			["rep"]		= true,
		}

		function MainPanel:ToggleState()
			local x, y = self:GetLeft(), self:GetBottom()

			if self.is_expanded then
				-- Hide the category buttons
				for category in pairs(self.filter_menu) do
					if VALID_CATEGORY[category] then
						self["menu_toggle_" .. category]:Hide()
					end
				end

				self.filter_reset:Hide()
				self.filter_menu:Hide()

				if _G.SOUNDKIT and _G.PlaySound then
					_G.PlaySound(_G.SOUNDKIT.IG_CHARACTER_INFO_CLOSE, "Master")
				end

				self:SetWidth(self.normal_width)
				self:SetHitRectInsets(0, 35, 0, 53)
				self:SetClampRectInsets(0, -35, 0, 53)

				self.top_left:SetTexture("Interface\\QuestFrame\\UI-QuestLog-TopLeft")
				self.top_right:SetTexture("Interface\\QuestFrame\\UI-QuestLog-TopRight")
				self.bottom_left:Show()
				self.bottom_right:Show()

				self.xclose_button:ClearAllPoints()
				self.xclose_button:SetPoint("TOPRIGHT", self, "TOPRIGHT", -30, -8)
			else
				local found_active = false

				-- Show the category buttons. If one has been selected, show its information in the panel.
				for category in pairs(MainPanel.filter_menu) do
					local toggle = "menu_toggle_" .. category

					if VALID_CATEGORY[category] then
						MainPanel[toggle]:Show()

						if MainPanel[toggle]:GetChecked() then
							found_active = true
							MainPanel.filter_menu[category]:Show()
							MainPanel.filter_menu:Show()
						end
					end
				end

				-- If nothing was checked, default to the general filters.
				if not found_active then
					MainPanel.menu_toggle_general:SetChecked(true)
					MainPanel.filter_menu.general:Show()
					MainPanel.filter_menu:Show()
				end
				-- Ensure the toggle container row is visible when expanded
				if MainPanel.filter_menu and MainPanel.filter_menu.toggle_container then
					MainPanel.filter_menu.toggle_container:Show()
				end
				MainPanel.filter_reset:Show()

				if _G.SOUNDKIT and _G.PlaySound then
					_G.PlaySound(_G.SOUNDKIT.IG_CHARACTER_INFO_OPEN, "Master")
				end

				self:SetWidth(self.expanded_width)
				self:SetHitRectInsets(0, 90, 0, 53)
				self:SetClampRectInsets(0, -90, 0, 53)

				self.top_left:SetTexture("Interface\\QuestFrame\\UI-QuestLogDualPane-Left")
				self.top_right:SetTexture("Interface\\QuestFrame\\UI-QuestLogDualPane-Right")
				self.bottom_left:Hide()
				self.bottom_right:Hide()

				self.xclose_button:ClearAllPoints()
				self.xclose_button:SetPoint("TOPRIGHT", self, "TOPRIGHT", -84, -8)
			end
			self.is_expanded = not self.is_expanded

			self:ClearAllPoints()
			self:SetPoint("BOTTOMLEFT", _G.UIParent, "BOTTOMLEFT", x, y)
			self:UpdateTitle()
		end
	end	-- do-block

	function MainPanel:UpdateTitle()
		local localizedProfessionName = private.CurrentProfession:LocalizedName()

		if not self.is_expanded then
			self.title_bar:SetFormattedText(private.SetTextColor(private.BASIC_COLORS.normal.hex, "ARLC (%s) - %s"), addon.version, localizedProfessionName)
			return
		end

		local total, active = 0, 0
		for filter, info in pairs(self.filter_menu.value_map) do
			if info.svroot then
				if info.svroot[filter] == true then
					active = active + 1
				end
				total = total + 1
			end
		end

		self.title_bar:SetFormattedText(private.SetTextColor(private.BASIC_COLORS.normal.hex, "ARLC (%s) - %s (%d/%d %s)"), addon.version, localizedProfessionName, active, total, _G.FILTERS)
	end

	-- ----------------------------------------------------------------------------
	-- Create the profession-cycling button and assign its values.
	-- ----------------------------------------------------------------------------
	local profession_cycler = _G.CreateFrame("Button", nil, MainPanel)
	profession_cycler:SetSize(60, 60)
	profession_cycler:SetPoint("TOPLEFT", 7, -6)
	profession_cycler:SetHighlightTexture([[Interface\Cooldown\ping4]])
	profession_cycler:RegisterForClicks("LeftButtonUp", "RightButtonUp")
	profession_cycler:SetFrameLevel(MainPanel:GetFrameLevel() + 5)
	MainPanel.prof_button = profession_cycler

	-- Create the portrait texture on MainPanel (not on the button) so the QuestLog ring art (OVERLAY on MainPanel)
	-- draws above it and gives a circular look without masks.
	local profession_texture = MainPanel:CreateTexture(nil, "ARTWORK")
	profession_texture:SetAllPoints(profession_cycler)
	profession_texture:SetDrawLayer("ARTWORK", 0)
	profession_texture:SetVertexColor(1,1,1,1)
	profession_texture:SetAlpha(1)
	MainPanel.profession_texture = profession_texture

	-- Apply a circular mask if supported.
	if profession_texture.AddMaskTexture and profession_cycler.CreateMaskTexture then
		local portrait_mask = profession_cycler:CreateMaskTexture(nil, "ARTWORK")
		portrait_mask:SetAllPoints(profession_cycler)
		portrait_mask:SetTexture([[Interface\CharacterFrame\TempPortraitAlphaMask]])
		profession_texture:AddMaskTexture(portrait_mask)
		MainPanel.profession_mask = portrait_mask
	end


	-- ----------------------------------------------------------------------------
	-- ProfCycle scripts/functions.
	-- ----------------------------------------------------------------------------
	do
		-- Changes to the TradeSkill handling in Legion necessitate a 0.1 second timer to run this function.
		local function ScanCurrentProfession()
			addon:Scan()
		end

		local availableProfessions = {}

		profession_cycler:SetScript("OnClick", function(self, button_name, down)
			local player = private.Player
			table.wipe(availableProfessions)

			for index = 1, #private.ORDERED_LOCALIZED_PROFESSION_NAMES do
                local localizedProfessionName = private.ORDERED_LOCALIZED_PROFESSION_NAMES[index]

				if player.professions[localizedProfessionName] then
					if not private.Professions[localizedProfessionName] then
						addon:InitializeProfession(localizedProfessionName, true) -- suppress popups while cycling
					end

					availableProfessions[#availableProfessions + 1] = private.Professions[localizedProfessionName]
				end
			end

			local currentProfessionIndex
			for index = 1, #availableProfessions do
				if availableProfessions[index] == private.CurrentProfession then
					currentProfessionIndex = index
					break
				end
			end

            if currentProfessionIndex then
                if button_name == "LeftButton" then
                    currentProfessionIndex = currentProfessionIndex + 1

                    if currentProfessionIndex > #availableProfessions then
                        currentProfessionIndex = 1
                    end
                elseif button_name == "RightButton" then
                    currentProfessionIndex = currentProfessionIndex - 1

                    if currentProfessionIndex < 1 then
                        currentProfessionIndex = #availableProfessions
                    end
                end

				if _G.SOUNDKIT and _G.PlaySound then
					_G.PlaySound(_G.SOUNDKIT.IG_CHARACTER_NPC_SELECT, "Master")
				end

                -- If not shown, save the current sound effects setting then set it to 0.
				local cVarSfx
				local isPanelShown = (addon.scan_button and addon.scan_button.GetParent and addon.scan_button:GetParent():IsVisible()) or false
                if not isPanelShown then
                    cVarSfx = private.GetCVar("Sound_EnableSFX")
                    private.SetCVar("Sound_EnableSFX", "0")
                end

				local activationSpellName = availableProfessions[currentProfessionIndex]:ActivationSpellName()

                _G.CastSpellByName(activationSpellName)
				_G.C_Timer.After(0.1, ScanCurrentProfession)

                if not isPanelShown then
                    _G.CloseTradeSkill()
                    private.SetCVar("Sound_EnableSFX", cVarSfx or "1")
				end
            end
		end)
	end -- do-block

	function profession_cycler:SetTexture()
		-- Use only our profession icon (no reads/writes to Blizzard portrait).
		local texPath
		if private.CurrentProfession and private.CurrentProfession.WaypointIconTexture then
			texPath = private.CurrentProfession:WaypointIconTexture()
		end
		texPath = texPath or [[Interface\Icons\INV_Misc_Book_11]]
		local portrait = MainPanel.profession_texture
		if portrait and portrait.SetTexture then
			portrait:SetTexture(texPath)
			portrait:SetVertexColor(1,1,1,1)
			portrait:SetAlpha(1)
			portrait:Show()
		end
	end

	-- ----------------------------------------------------------------------------
	-- The search entry box and associated methods.
	-- ----------------------------------------------------------------------------
	local SearchRecipes
	do
		local recipeNameIndex = {}
		local indexProfession = nil
		local indexValid = false

		local function BuildSearchIndex()
			local profession = private.CurrentProfession
			if not profession or not profession.Recipes then
				return
			end

			if indexProfession == profession and indexValid then
				return
			end

			table.wipe(recipeNameIndex)
			indexProfession = profession

			for spellID, recipe in pairs(profession.Recipes) do
				local name = recipe:LocalizedName()
				if name and name ~= "" then
					local lowerName = name:lower()
					if not recipeNameIndex[lowerName] then
						recipeNameIndex[lowerName] = {}
					end
					recipeNameIndex[lowerName][spellID] = true
				end
			end
			indexValid = true
		end

		private.InvalidateSearchIndex = function()
			indexValid = false
		end

		local recipe_fields = {
			"_localizedName",
			"skill_level",
			"specialty",
		}

		local function SearchByField(recipe, search_pattern)
			for index, field in ipairs(recipe_fields) do
				local str = recipe[field] and tostring(recipe[field]):lower()

				if str and str:find(search_pattern) then
					return true
				end
			end
			return false
		end

		local function SearchByAcquireType(recipe, searchPattern)
			for acquireTypeLabel, acquireType in pairs(private.AcquireTypes) do
				local hasData = acquireType and recipe:AcquireDataOfType(acquireType)
				local atName = (acquireType and acquireType.Name and acquireType:Name()) or nil
				if hasData and atName and atName:lower():find(searchPattern) then
					return true
				end
			end
			return false
		end

		local function SearchByLocation(recipe, searchPattern)
			for name, location in pairs(private.Locations) do
				if location and location.HasRecipe and location:HasRecipe(recipe) then
					local locName = location.LocalizedName and location:LocalizedName() or nil
					if locName and locName:lower():find(searchPattern) then
						return true
					end
				end
			end

			return false
		end

		local function SearchByQuality(recipe, searchPattern)
			local qualityNames = private.ITEM_QUALITY_NAMES or {}
			local qname = qualityNames[recipe:QualityID()]
			if qname and qname:lower():find(searchPattern) then
				return true
			end
			return false
		end

		local function SearchByList(recipe, searchPattern, acquireType)
			if not acquireType or not acquireType.EntityPairs then
				return false
			end
			for id_num, unit in acquireType:EntityPairs() do
				local uname = unit and unit.name or nil
				if unit and unit.item_list and unit.item_list[recipe:SpellID()] and uname and uname:lower():find(searchPattern) then
					return true
				end
			end
			return false
		end

		local function SearchByTrainer(recipe, searchPattern)
			return SearchByList(recipe, searchPattern, private.AcquireTypes.Trainer)
		end

		local function SearchByVendor(recipe, searchPattern)
			return SearchByList(recipe, searchPattern, private.AcquireTypes.Vendor)
		end

		local function SearchByMobDrop(recipe, searchPattern)
			return SearchByList(recipe, searchPattern, private.AcquireTypes.MobDrop)
		end

		local function SearchByCustom(recipe, searchPattern)
			return SearchByList(recipe, searchPattern, private.AcquireTypes.Custom)
		end

		local function SearchByDiscovery(recipe, searchPattern)
			return SearchByList(recipe, searchPattern, private.AcquireTypes.Discovery)
		end

		local function SearchByReputation(recipe, searchPattern)
			local reputationAcquireType = private.AcquireTypes and private.AcquireTypes.Reputation
			if not reputationAcquireType then
				return false
			end
			local reputationAcquireData = recipe:AcquireDataOfType(reputationAcquireType)

			if reputationAcquireData then
				for sourceID, sourceData in pairs(reputationAcquireData) do
					local entity = reputationAcquireType.GetEntity and reputationAcquireType:GetEntity(sourceID) or nil
					local name = entity and entity.name or nil
					if name and name:lower():find(searchPattern) then
						return true
					end
				end
			end

			return false
		end

		local SEARCH_FUNCTIONS = {
			SearchByField,
			SearchByQuality,
			SearchByAcquireType,
			SearchByLocation,
			SearchByReputation,
			SearchByTrainer,
			SearchByVendor,
			SearchByMobDrop,
			SearchByCustom,
			SearchByDiscovery,
		}

		-- Scans through the recipe database and toggles the flag on if the item is in the search criteria
		function SearchRecipes(searchPattern)
			if not searchPattern then
				return
			end
			searchPattern = searchPattern:lower()
			BuildSearchIndex()

			local profession = private.CurrentProfession
			if not profession or not profession.Recipes then
				return
			end

			local foundByName = false
			for lowerName, spellIDs in pairs(recipeNameIndex) do
				if lowerName:find(searchPattern) then
					foundByName = true
					break
				end
			end

			for _, recipe in pairs(profession.Recipes) do
				recipe:RemoveState("RELEVANT")

				if foundByName then
					local name = recipe:LocalizedName()
					if name and name:lower():find(searchPattern) then
						recipe:AddState("RELEVANT")
					end
				else
					for search_index = 2, #SEARCH_FUNCTIONS do
						if SEARCH_FUNCTIONS[search_index](recipe, searchPattern) then
							recipe:AddState("RELEVANT")
							break
						end
					end
				end
			end
		end
	end	-- do-block

	-- ----------------------------------------------------------------------------
	-- Search EditBox
	-- ----------------------------------------------------------------------------
	local SearchBox = _G.CreateFrame("EditBox", "ARL_SearchBox", MainPanel, "SearchBoxTemplate")

	SearchBox:EnableMouse(true)
	SearchBox:SetAutoFocus(false)
	SearchBox:SetFontObject("ChatFontSmall")
	SearchBox:SetWidth(130)
	SearchBox:SetHeight(12)
	SearchBox:SetPoint("TOPLEFT", MainPanel, "TOPLEFT", 75, -39)
	SearchBox:Show()

	MainPanel.search_editbox = SearchBox

	SearchBox:SetHistoryLines(10)

	-- Allow removal of focus from the SearchBox by clicking on the WorldFrame.
	do
		local old_x, old_y, click_time

		_G.WorldFrame:HookScript("OnMouseDown", function(frame, ...)
			if not SearchBox:HasFocus() then
				return
			end
			old_x, old_y = _G.GetCursorPosition()
			click_time = _G.GetTime()
		end)

		_G.WorldFrame:HookScript("OnMouseUp", function(frame, ...)
			if not SearchBox:HasFocus() then
				return
			end
			local x, y = _G.GetCursorPosition()

			if not old_x or not old_y or not x or not y or not click_time then
				SearchBox:ClearFocus()
				return
			end

			if (math.abs(x - old_x) + math.abs(y - old_y)) <= 5 and _G.GetTime() - click_time < .5 then
				SearchBox:ClearFocus()
			end
		end)
	end

	-- Resets the SearchBox text and the state of all MainPanel.list_frame and recipe_list entries.
	function SearchBox:Reset()
		for _, recipe in pairs(private.CurrentProfession.Recipes) do
			recipe:RemoveState("RELEVANT")
		end
		self.prev_search = nil

		if self:HasFocus() then
			self:HighlightText()
		end
		MainPanel.list_frame:Update(nil, false)
	end

	-- If there is text in the search box, return the recipe's RELEVANT state.
	function SearchBox:MatchesRecipe(recipe)
		local editbox_text = self:GetText()

		if editbox_text ~= "" and editbox_text ~= _G.SEARCH then
			return recipe:HasState("RELEVANT")
		end
		return true
	end

	SearchBox:HookScript("OnEnterPressed", function(self)
		local searchtext = self:GetText()
		searchtext = searchtext:trim()

		if not searchtext or searchtext == "" then
			self:Reset()
			return
		end
		self:HighlightText()

		if searchtext == _G.SEARCH then
			return
		end
		self.prev_search = searchtext

		self:AddHistoryLine(searchtext)
		SearchRecipes(searchtext)
		MainPanel.list_frame:Update(nil, false)
	end)

	SearchBox:HookScript("OnEditFocusLost", function(self)
		_G.SearchBoxTemplate_OnEditFocusLost(self)

		local text = self:GetText()

		if text == "" or text == _G.SEARCH then
			self:Reset()
			return
		end
		self:AddHistoryLine(text)
	end)


	SearchBox:SetScript("OnTextSet", function(self)
		if not self:HasFocus() and self:GetText() == "" then
			self.searchIcon:SetVertexColor(0.6, 0.6, 0.6)
			self.clearButton:Hide()
		else
			self.searchIcon:SetVertexColor(1.0, 1.0, 1.0)
			self.clearButton:Show()
		end

		local text = self:GetText()
		if text ~= "" and text ~= _G.SEARCH and text ~= self.prev_search then
			self:HighlightText()
		else
			self:Reset()
		end
	end)

	do
		local last_update = 0
		local updater = _G.CreateFrame("Frame", nil, _G.UIParent)

		updater:Hide()
		updater:SetScript("OnUpdate", function(self, elapsed)
			last_update = last_update + elapsed

			if last_update < 0.25 then
				return
			end
			local search_text = SearchBox:GetText()

			if #search_text < 4 then
				last_update = 0
				return
			end
			last_update = 0

			SearchRecipes(search_text)
			MainPanel.list_frame:Update(nil, false)
			self:Hide()
		end)

		SearchBox:HookScript("OnTextChanged", function(self, is_typed)
			if not is_typed then
				return
			end
			local text = self:GetText()

			if text ~= "" and text ~= _G.SEARCH and text ~= self.prev_search then
				updater:Show()
				last_update = 0
			else
				self:Reset()
			end
		end)
	end	-- do

	-- ----------------------------------------------------------------------------
	-- Create the expand button and set its scripts.
	-- ----------------------------------------------------------------------------
	local expand_button_frame = _G.CreateFrame("Frame", nil, MainPanel)

	expand_button_frame:SetHeight(20)
	expand_button_frame:SetPoint("TOPLEFT", SearchBox, "BOTTOMLEFT", -12, -5)

	expand_button_frame.left = expand_button_frame:CreateTexture(nil, "BACKGROUND")
	expand_button_frame.left:SetWidth(8)
	expand_button_frame.left:SetHeight(22)
	expand_button_frame.left:SetPoint("TOPLEFT", expand_button_frame, 0, 4)
	expand_button_frame.left:SetTexture("Interface\\QuestFrame\\UI-QuestLogSortTab-Left")

	expand_button_frame.right = expand_button_frame:CreateTexture(nil, "BACKGROUND")
	expand_button_frame.right:SetWidth(8)
	expand_button_frame.right:SetHeight(22)
	expand_button_frame.right:SetPoint("TOPRIGHT", expand_button_frame, 0, 4)
	expand_button_frame.right:SetTexture("Interface\\QuestFrame\\UI-QuestLogSortTab-Right")

	expand_button_frame.middle = expand_button_frame:CreateTexture(nil, "BACKGROUND")
	expand_button_frame.middle:SetHeight(22)
	expand_button_frame.middle:SetPoint("LEFT", expand_button_frame.left, "RIGHT")
	expand_button_frame.middle:SetPoint("RIGHT", expand_button_frame.right, "LEFT")
	expand_button_frame.middle:SetTexture("Interface\\QuestFrame\\UI-QuestLogSortTab-Middle")

	local expand_button = _G.CreateFrame("Button", nil, MainPanel)
	expand_button:SetWidth(16)
	expand_button:SetHeight(16)

	local expand_label = expand_button:CreateFontString(nil, "ARTWORK")
	expand_label:SetFontObject("GameFontNormalSmall")
	expand_label:SetPoint("LEFT", expand_button, "Right", 0, 0)
	expand_label:SetJustifyH("LEFT")
	expand_label:SetText(_G.ALL)

	expand_button:SetFontString(expand_label)
	private.SetTooltipScripts(expand_button, L["EXPANDALL_DESC"])

	-- Make sure the button frame is large enough to hold the localized word for "All"
	expand_button_frame:SetWidth(27 + expand_button:GetFontString():GetStringWidth())

	MainPanel.expand_button = expand_button

	expand_button:SetPoint("LEFT", expand_button_frame.left, "RIGHT", -3, -3)

	expand_button:SetScript("OnClick", function(self, mouse_button, down)
		local currentTab = MainPanel.current_tab
        local currentProfession = private.CurrentProfession
        local localizedProfessionName = currentProfession:LocalizedName()
		local professionExpandButton = currentTab["expand_button_" .. localizedProfessionName]
		local expandMode

		if professionExpandButton and currentTab.ProfessionState and currentTab.ProfessionState[currentProfession] then
			table.wipe(currentTab.ProfessionState[currentProfession])
		else
			if _G.IsShiftKeyDown() then
				expandMode = "deep"
			else
				expandMode = "normal"
			end
		end
		-- MainPanel.list_frame:Update() must be called before the button can be expanded or contracted, since
		-- the button is contracted from there.
		-- If expand_mode is nil, that means expand nothing.
		MainPanel.list_frame:Update(expandMode, false)

		if professionExpandButton then
			self:Contract(currentTab)
		else
			self:Expand(currentTab)
		end
	end)

	function expand_button:Expand(currentTab)
		currentTab["expand_button_" .. private.CurrentProfession:LocalizedName()] = true

		self:SetNormalTexture("Interface\\BUTTONS\\UI-MinusButton-Up")
		self:SetPushedTexture("Interface\\BUTTONS\\UI-MinusButton-Down")
		self:SetHighlightTexture("Interface\\BUTTONS\\UI-PlusButton-Hilight")
		self:SetDisabledTexture("Interface\\BUTTONS\\UI-MinusButton-Disabled")

		private.SetTooltipScripts(self, L["CONTRACTALL_DESC"])
	end

	function expand_button:Contract(currentTab)
		currentTab["expand_button_" .. private.CurrentProfession:LocalizedName()] = nil

		self:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up")
		self:SetPushedTexture("Interface\\Buttons\\UI-PlusButton-Down")
		self:SetHighlightTexture("Interface\\Buttons\\UI-PlusButton-Hilight")
		self:SetDisabledTexture("Interface\\Buttons\\UI-PlusButton-Disabled")

		private.SetTooltipScripts(self, L["EXPANDALL_DESC"])
	end

	-- ----------------------------------------------------------------------------
	-- "Display Exclusions" checkbox.
	-- ----------------------------------------------------------------------------
	local ExcludeToggle = _G.CreateFrame("CheckButton", nil, MainPanel, "UICheckButtonTemplate")
	ExcludeToggle:SetPoint("TOPLEFT", SearchBox, "TOPRIGHT", 0, 0)
	ExcludeToggle:SetSize(16, 16)

	ExcludeToggle.text = ExcludeToggle:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	ExcludeToggle.text:SetPoint("LEFT", ExcludeToggle, "RIGHT", 0, 0)

	ExcludeToggle:SetScript("OnClick", function(self, button, down)
		addon.db.profile.ignoreexclusionlist = not addon.db.profile.ignoreexclusionlist
		MainPanel.list_frame:Update(nil, false)
	end)

	ExcludeToggle:SetScript("OnShow", function(self)
		self:SetChecked(addon.db.profile.ignoreexclusionlist)
	end)

	ExcludeToggle.text:SetText(L["Display Exclusions"])
	private.SetTooltipScripts(ExcludeToggle, L["DISPLAY_EXCLUSION_DESC"], 1)

	-- ----------------------------------------------------------------------------
	-- Create the X-close button, and set its scripts.
	-- ----------------------------------------------------------------------------
	MainPanel.xclose_button = _G.CreateFrame("Button", nil, MainPanel, "UIPanelCloseButton")
	MainPanel.xclose_button:SetPoint("TOPRIGHT", MainPanel, "TOPRIGHT", -30, -8)

	MainPanel.xclose_button:SetScript("OnClick", function(self, button, down)
		MainPanel:Hide()
	end)

	-- ----------------------------------------------------------------------------
	-- Create MainPanel.filter_toggle, and set its scripts.
	-- ----------------------------------------------------------------------------
	do
		local filter_toggle = _G.CreateFrame("Button", nil, MainPanel)
		filter_toggle:SetWidth(24)
		filter_toggle:SetHeight(24)
		filter_toggle:SetPoint("TOPLEFT", MainPanel, "TOPLEFT", 323, -41)

		private.SetTooltipScripts(filter_toggle, L["FILTER_OPEN_DESC"])

		filter_toggle:SetScript("OnClick", function(self, button, down)
			private.SetTooltipScripts(self, MainPanel.is_expanded and L["FILTER_OPEN_DESC"] or L["FILTER_CLOSE_DESC"])

			MainPanel:ToggleState()
			self:SetTextures()
		end)

		filter_toggle:SetHighlightTexture([[Interface\CHATFRAME\UI-ChatIcon-BlinkHilight]])

		function filter_toggle:SetTextures()
			if MainPanel.is_expanded then
				self:SetNormalTexture([[Interface\BUTTONS\UI-SpellbookIcon-PrevPage-Up]])
				self:SetPushedTexture([[Interface\BUTTONS\UI-SpellbookIcon-PrevPage-Down]])
				self:SetDisabledTexture([[Interface\BUTTONS\UI-SpellbookIcon-PrevPage-Disabled]])
			else
				self:SetNormalTexture([[Interface\BUTTONS\UI-SpellbookIcon-NextPage-Up]])
				self:SetPushedTexture([[Interface\BUTTONS\UI-SpellbookIcon-NextPage-Down]])
				self:SetDisabledTexture([[Interface\BUTTONS\UI-SpellbookIcon-NextPage-Disabled]])
			end
		end
		MainPanel.filter_toggle = filter_toggle
	end	-- do-block

	-- ----------------------------------------------------------------------------
	-- Sort-mode toggle button.
	-- ----------------------------------------------------------------------------
	local sort_toggle = _G.CreateFrame("Button", nil, MainPanel)
	sort_toggle:SetWidth(24)
	sort_toggle:SetHeight(24)
	sort_toggle:SetPoint("LEFT", expand_button_frame, "RIGHT", 0, 2)

	private.SetTooltipScripts(sort_toggle, L["SORTING_DESC"])

	MainPanel.sort_button = sort_toggle

	sort_toggle:SetScript("OnClick", function(self, button, down)
		local sort_type = addon.db.profile.sorting

		addon.db.profile.sorting = (sort_type == "Ascending" and "Descending" or "Ascending")

		self:SetTextures()
		MainPanel.list_frame:Update(nil, false)
	end)

	sort_toggle:SetHighlightTexture([[Interface\CHATFRAME\UI-ChatIcon-BlinkHilight]])

	function sort_toggle:SetTextures()
		local sort_type = addon.db.profile.sorting

		if sort_type == "Ascending" then
			self:SetNormalTexture([[Interface\CHATFRAME\UI-ChatIcon-ScrollDown-Up]])
			self:SetPushedTexture([[Interface\CHATFRAME\UI-ChatIcon-ScrollDown-Down]])
			self:SetDisabledTexture([[Interface\CHATFRAME\UI-ChatIcon-ScrollDown-Disabled]])
		else
			self:SetNormalTexture([[Interface\CHATFRAME\UI-ChatIcon-ScrollUp-Up]])
			self:SetPushedTexture([[Interface\CHATFRAME\UI-ChatIcon-ScrollUp-Down]])
			self:SetDisabledTexture([[Interface\CHATFRAME\UI-ChatIcon-ScrollUp-Disabled]])
		end
	end

	-- ----------------------------------------------------------------------------
	-- Sort By buttons.
	-- ----------------------------------------------------------------------------
	do
		local name_button, skill_button

		local function ToggleOnClick(self)
			addon.db.profile.skill_view = not addon.db.profile.skill_view

			name_button:GetScript("OnShow")(name_button)
			skill_button:GetScript("OnShow")(skill_button)
			MainPanel.list_frame:Update(nil, false)
		end

	local sort_label = MainPanel:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
	sort_label:SetPoint("LEFT", sort_toggle, "RIGHT", 0, 0)
	-- Safe fallback if the global is missing on some clients
	sort_label:SetText(_G.COMPACT_UNIT_FRAME_PROFILE_SORTBY or "Sort by")

		name_button = _G.CreateFrame("Button", nil, MainPanel)
		-- Use FontObject references (with fallbacks) instead of string names for safety
		local Font_NormalGraySmall   = _G.GameFontNormalGraySmall or _G.GameFontNormalSmall or _G.GameFontNormal
		local Font_NormalSmall       = _G.GameFontNormalSmall or _G.GameFontNormal
		local Font_HighlightSmallOut = _G.GameFontHighlightSmallOutline or _G.GameFontHighlightSmall or _G.GameFontHighlight

		name_button:SetNormalFontObject(Font_NormalGraySmall)
		name_button:SetHighlightFontObject(Font_NormalSmall)
		name_button:SetDisabledFontObject(Font_HighlightSmallOut)

		do
			local fs = name_button:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
			if fs and fs.SetFontObject then
				fs:SetFontObject(Font_NormalSmall)
			end
			name_button:SetFontString(fs)
		end
		name_button:SetText(_G.NAME or "Name")
		name_button:SetSize(name_button:GetFontString():GetStringWidth(), 16)
		name_button:SetPoint("LEFT", sort_label, "RIGHT", 2, 0)

		name_button:SetScript("OnClick", ToggleOnClick)

		name_button:SetScript("OnShow", function(self)
			self[addon.db.profile.skill_view and "Enable" or "Disable"](self)
		end)

		local separator = MainPanel:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
		separator:SetPoint("LEFT", name_button, "RIGHT", 0, 0)
		separator:SetText(" / ")

		skill_button = _G.CreateFrame("Button", nil, MainPanel)
		-- Match the same robust FontObjects for safety
		local fs2 = skill_button:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
		if fs2 and fs2.SetFontObject then
			fs2:SetFontObject(Font_NormalSmall)
		end
		skill_button:SetFontString(fs2)

		skill_button:SetNormalFontObject(Font_NormalGraySmall)
		skill_button:SetHighlightFontObject(Font_NormalSmall)
		skill_button:SetDisabledFontObject(Font_HighlightSmallOut)
		skill_button:SetText(_G.SKILL_LEVEL or "Skill Level")
		skill_button:SetSize(skill_button:GetFontString():GetStringWidth(), 16)
		skill_button:SetPoint("LEFT", separator, "RIGHT", 0, 0)

		skill_button:SetScript("OnClick", ToggleOnClick)

		skill_button:SetScript("OnShow", function(self)
			self[addon.db.profile.skill_view and "Disable" or "Enable"](self)
		end)
	end -- do-block

	-- ----------------------------------------------------------------------------
	-- Create MainPanel.progress_bar and set its scripts
	-- ----------------------------------------------------------------------------
	do
		local progress_bar = private.CreateFrameWithBackdrop("StatusBar", nil, MainPanel)
		progress_bar:SetWidth(216)
		progress_bar:SetHeight(18)
		progress_bar:SetPoint("BOTTOMLEFT", MainPanel, 17, 80)
		local progressBackdrop = {
			bgFile = [[Interface\DialogFrame\UI-DialogBox-Background-Dark]],
			tile = true,
			tileSize = 16,
		}
		private.BackdropUtil.SafeSetBackdrop(progress_bar, progressBackdrop)

		progress_bar:SetStatusBarTexture([[Interface\TARGETINGFRAME\UI-StatusBar]])
		progress_bar:SetOrientation("HORIZONTAL")
		progress_bar:SetStatusBarColor(0.37, 0.45, 1.0)

		local border = progress_bar:CreateTexture(nil, "OVERLAY")
		border:SetWidth(288)
		border:SetHeight(78)
		border:SetPoint("TOPLEFT", progress_bar, "TOPLEFT", -36, 31)
		border:SetTexture([[Interface\CastingBar\UI-CastingBar-Border]])

		local text = progress_bar:CreateFontString(nil, "ARTWORK")
		text:SetWidth(195)
		text:SetHeight(14)
		text:SetFontObject("GameFontHighlightSmall")
		text:SetPoint("CENTER", progress_bar, "CENTER", 0, 0)
		text:SetJustifyH("CENTER")
	text:SetJustifyV("MIDDLE")

		progress_bar.text = text
		MainPanel.progress_bar = progress_bar
	end	-- do

	-- ----------------------------------------------------------------------------
	-- Create the close button, and set its scripts.
	-- ----------------------------------------------------------------------------
	local close_button = _G.CreateFrame("Button", ("%s_CloseButton"):format(FOLDER_NAME), MainPanel, "UIPanelButtonTemplate")
	close_button:SetWidth(111)
	close_button:SetHeight(24)
	close_button:SetPoint("LEFT", MainPanel.progress_bar, "RIGHT", 3, 1)
	-- Some clients may not have EXIT; fall back to CLOSE or a literal
	close_button:SetText(_G.EXIT or _G.CLOSE or "Close")

	MainPanel.close_button = close_button

	close_button:SetScript("OnClick", function(self, button, down)
		MainPanel:Hide()
	end)

	private.SetTooltipScripts(close_button, L["CLOSE_DESC"])
	-- ----------------------------------------------------------------------------
	-- Initialize components defined in other files.
	-- ----------------------------------------------------------------------------
	private.InitializeListFrame()
	private.InitializeTabs()

	private.InitializeFrame = nil
end

-- ----------------------------------------------------------------------------
-- Panel cleanup - called when MainPanel is hidden
-- ----------------------------------------------------------------------------
function private.CleanupPanel()
	local searchBox = addon.Frame and addon.Frame.search_editbox
	if searchBox then
		searchBox:ClearFocus()
	end

	if private.InvalidateSearchIndex then
		private.InvalidateSearchIndex()
	end

	_G.GameTooltip:Hide()

	local listFrame = private.list_frame
	if listFrame then
		if listFrame.entries then
			for i = 1, #listFrame.entries do
				local entry = listFrame.entries[i]
				if entry then
					if entry.children then
						private.ReleaseTable(entry.children)
						entry.children = nil
					end
					entry._discard = true
				end
			end
		end
		listFrame.selected_entry = nil
	end
end
