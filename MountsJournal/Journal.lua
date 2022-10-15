local addon, L = ...
local C_Timer, GetSpellInfo, wipe, tinsert, next, pairs, ipairs, select, type, sort = C_Timer, GetSpellInfo, wipe, tinsert, next, pairs, ipairs, select, type, sort
local util, mounts, config = MountsJournalUtil, MountsJournal, MountsJournalConfig
local journal = CreateFrame("FRAME", "MountsJournalFrame")
journal.mountTypes = util.mountTypes
util.setEventsMixin(journal)


local COLLECTION_ACHIEVEMENT_CATEGORY = 15246
local MOUNT_ACHIEVEMENT_CATEGORY = 15248
local NIGHT_FAE_BLUE_COLOR = CreateColor(.5020, .7098, .9922)


journal.colors = {
	gold = CreateColor(.8, .6, 0),
	gray = CreateColor(.5, .5, .5),
	dark = CreateColor(.3, .3, .3),
	mount1 = CreateColor(.824, .78, .235),
	mount2 = CreateColor(.42, .302, .224),
	mount3 = CreateColor(.031, .333, .388),
}
journal.displayedMounts = {}


journal:SetScript("OnEvent", function(self, event, ...) self[event](self, ...) end)


function journal:init()
	self.init = nil

	local lsfdd = LibStub("LibSFDropDown-1.4")
	local texPath = "Interface/AddOns/MountsJournal/textures/"

	-- FILTERS INIT
	local filtersMeta = {__index = function(self, key)
		self[key] = true
		return self[key]
	end}

	local function checkFilters(filters)
		if filters.collected == nil then filters.collected = true end
		if filters.notCollected == nil then filters.notCollected = true end
		if filters.unusable == nil then filters.unusable = true end
		filters.types = setmetatable(filters.types or {}, filtersMeta)
		filters.selected = setmetatable(filters.selected or {}, filtersMeta)
		filters.sources = setmetatable(filters.sources or {}, filtersMeta)
		filters.factions = setmetatable(filters.factions or {}, filtersMeta)
		filters.pet = setmetatable(filters.pet or {}, filtersMeta)
		filters.expansions = setmetatable(filters.expansions or {}, filtersMeta)
		filters.mountsWeight = filters.mountsWeight or {
			-- sign = nil,
			weight = 100,
		}
		filters.tags = filters.tags or {
			noTag = true,
			withAllTags = false,
			tags = {},
		}
	end

	checkFilters(mounts.filters)
	mounts.filters.sorting = mounts.filters.sorting or {
		by = "name",
		favoritesFirst = true,
	}
	checkFilters(mounts.defFilters)
	setmetatable(mounts.defFilters.tags.tags, filtersMeta)

	-- BACKGROUND FRAME
	self.bgFrame = CreateFrame("FRAME", "MountsJournalBackground", self.CollectionsJournal, "MJMountJournalFrameTemplate")
	local scale = self.bgFrame:GetEffectiveScale()
	local x, y = mounts.config.journalPosX, mounts.config.journalPosY
	if x then
		x = x / scale
	else
		x = (UIParent:GetWidth() - self.bgFrame:GetWidth()) / 2
	end
	if y then
		y = y / scale
	else
		y = (self.bgFrame:GetHeight() - UIParent:GetHeight()) / 2
	end
	self.bgFrame:SetPoint("TOPLEFT", x, y)
	self.bgFrame.TitleText:SetText(MOUNTS)
	SetPortraitToTexture(self.bgFrame.portrait, 303868)

	self.bgFrame:SetScript("OnShow", function(bgFrame)
		self:RegisterEvent("PLAYER_ENTERING_WORLD")
		self:RegisterEvent("COMPANION_UPDATE")
		self:RegisterEvent("PLAYER_REGEN_DISABLED")
		self:RegisterEvent("PLAYER_REGEN_ENABLED")

		self:RegisterEvent("ZONE_CHANGED")
		self:RegisterEvent("ZONE_CHANGED_INDOORS")
		self:RegisterEvent("ZONE_CHANGED_NEW_AREA")

		self:updateMountsList()
		self:updateMountDisplay()

		if InCombatLockdown() then
			bgFrame.summon1.icon:SetDesaturated(true)
			bgFrame.summon2.icon:SetDesaturated(true)
		else
			bgFrame.summon1.icon:SetDesaturated(false)
			bgFrame.summon2.icon:SetDesaturated(false)
			bgFrame.summon1.secure:Show()
			bgFrame.summon2.secure:Show()
		end
	end)

	self.bgFrame:SetScript("OnHide", function()
		self:UnregisterEvent("PLAYER_ENTERING_WORLD")
		self:UnregisterEvent("COMPANION_UPDATE")
		self:UnregisterEvent("PLAYER_REGEN_DISABLED")
		self:UnregisterEvent("PLAYER_REGEN_ENABLED")

		self:UnregisterEvent("ZONE_CHANGED")
		self:UnregisterEvent("ZONE_CHANGED_INDOORS")
		self:UnregisterEvent("ZONE_CHANGED_NEW_AREA")

		self.mountDisplay:Show()
		self.navBarBtn:SetChecked(false)
		self.mapSettings:Hide()
		self.worldMap:Hide()
	end)

	self.bgFrame:SetClampedToScreen(true)
	self.bgFrame:RegisterForDrag("LeftButton")
	self.bgFrame:SetScript("OnDragStart", self.bgFrame.StartMoving)
	self.bgFrame:SetScript("OnDragStop", function(self)
		local scale = self:GetEffectiveScale()
		mounts.config.journalPosX = self:GetLeft() * scale
		mounts.config.journalPosY = (self:GetTop() - UIParent:GetHeight()) * scale
		self:StopMovingOrSizing()
	end)
	self.bgFrame.closeButton:SetScript("OnKeyDown", function(self, key)
		if key == GetBindingKey("TOGGLEGAMEMENU") then
			self:Click()
			self:SetPropagateKeyboardInput(false)
		else
			self:SetPropagateKeyboardInput(true)
		end
	end)

	self.mountCount = self.bgFrame.mountCount
	self.achiev = self.bgFrame.achiev
	self.navBarBtn = self.bgFrame.navBarBtn
	self.navBar = self.bgFrame.navBar
	self.worldMap = self.bgFrame.worldMap
	self.mapSettings = self.bgFrame.mapSettings
	self.existingLists = self.mapSettings.existingLists
	self.filtersPanel = self.bgFrame.filtersPanel
	self.filtersToggle = self.filtersPanel.btnToggle
	self.gridToggleButton = self.filtersPanel.gridToggleButton
	self.searchBox = self.filtersPanel.searchBox
	self.filtersBar = self.filtersPanel.filtersBar
	self.shownPanel = self.bgFrame.shownPanel
	self.leftInset = self.bgFrame.leftInset
	self.mountDisplay = self.bgFrame.mountDisplay
	self.modelScene = self.mountDisplay.modelScene
	self.multipleMountBtn = self.modelScene.multipleMountBtn
	self.mountListUpdateAnim = self.leftInset.updateAnimFrame.anim
	self.scrollFrame = self.bgFrame.scrollFrame
	self.summonButton = self.bgFrame.summonButton
	self.weightFrame = self.bgFrame.mountsWeight

	-- MOUNT COUNT
	self.mountCount.collectedLabel:SetText(L["Collected:"])
	self:updateCountMounts()

	-- HINT
	self.bgFrame.hint:SetScript("OnEnter", function(hint)
		hint.highlight:Show()
		GameTooltip:SetOwner(self.scrollFrame, "ANCHOR_NONE")
		GameTooltip:SetPoint("TOPLEFT", self.scrollFrame, "TOPRIGHT", 0, -5)
		GameTooltip:SetText(L["ButtonsSelectedTooltipDescription"]:format(addon), nil, nil, nil, nil, true)
		GameTooltip:Show()
	end)

	-- MACRO BUTTONS
	local summon1 = self.bgFrame.summon1
	summon1:SetNormalTexture(303868)
	summon1.icon = summon1:GetNormalTexture()
	summon1:SetScript("OnDragStart", function()
		if InCombatLockdown() then return end
		if not GetMacroInfo(config.macroName) then
			config:createMacro(config.macroName, config.secureButtonNameMount, 303868)
		end
		PickupMacro(config.macroName)
	end)
	summon1:SetScript("OnEnter", function(btn)
		btn.highlight:Show()
		GameTooltip:SetOwner(btn, "ANCHOR_RIGHT")
		GameTooltip_SetTitle(GameTooltip, addon.." \""..SUMMON.." 1\"")
		GameTooltip:AddLine(L["Normal mount summon"])
		GameTooltip_AddColoredLine(GameTooltip, "\nMacro: /click "..config.secureButtonNameMount, NIGHT_FAE_BLUE_COLOR, false)
		if InCombatLockdown() then
			GameTooltip_AddErrorLine(GameTooltip, SPELL_FAILED_AFFECTING_COMBAT)
		end
		GameTooltip:Show()
	end)

	local summon2 = self.bgFrame.summon2
	summon2:SetNormalTexture(237534)
	summon2.icon = summon2:GetNormalTexture()
	summon2:SetScript("OnDragStart", function()
		if InCombatLockdown() then return end
		if not GetMacroInfo(config.secondMacroName) then
			config:createMacro(config.secondMacroName, config.secureButtonNameSecondMount, 237534)
		end
		PickupMacro(config.secondMacroName)
	end)
	summon2:SetScript("OnEnter", function(btn)
		btn.highlight:Show()
		GameTooltip:SetOwner(btn, "ANCHOR_RIGHT")
		GameTooltip_SetTitle(GameTooltip, addon.." \""..SUMMON.." 2\"")
		GameTooltip_AddNormalLine(GameTooltip, L["SecondMountTooltipDescription"]:gsub("\n\n", "\n"))
		GameTooltip_AddColoredLine(GameTooltip, "\nMacro: /click "..config.secureButtonNameSecondMount, NIGHT_FAE_BLUE_COLOR, false)
		if InCombatLockdown() then
			GameTooltip_AddErrorLine(GameTooltip, SPELL_FAILED_AFFECTING_COMBAT)
		end
		GameTooltip:Show()
	end)
	summon1.icon:SetDesaturated(true)
	summon1.icon:SetDesaturated(false)

	if InCombatLockdown() then
		summon1.icon:SetDesaturated(true)
		summon2.icon:SetDesaturated(true)
	else
		self:createSecureButtons()
	end

	-- NAVBAR BUTTON
	self.navBarBtn:HookScript("OnClick", function(btn)
		local checked = btn:GetChecked()
		self.mountDisplay:SetShown(not checked)
		self.worldMap:SetShown(checked)
		self.mapSettings:SetShown(checked)
	end)
	self.navBarBtn:SetScript("OnEnter", function(self)
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT", -4, -32)
		GameTooltip:SetText(L["Map / Model"])
		GameTooltip:Show()
	end)
	self.navBarBtn:SetScript("OnLeave", function() GameTooltip_Hide() end)

	-- NAVBAR
	self:on("MAP_CHANGE", function(self)
		self:setEditMountsList()
		self:updateMountsList()
		self:updateMapSettings()

		self.mountListUpdateAnim:Stop()
		self.mountListUpdateAnim:Play()
	end)

	-- MAP SETTINGS
	self.mapSettings:SetScript("OnShow", function() self:updateMapSettings() end)
	self.mapSettings.CurrentMap:SetText(L["Current Location"])
	self.mapSettings.CurrentMap:SetScript("OnClick", function()
		PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
		self.navBar:setCurrentMap()
	end)
	self.mapSettings.hint.tooltip = L["ZoneSettingsTooltip"]
	self.mapSettings.hint.tooltipDescription = "\n"..L["ZoneSettingsTooltipDescription"]
	self.mapSettings.Flags.Text:SetText(L["Enable Flags"])
	self.mapSettings.Flags:HookScript("OnClick", function(check) self:setFlag("enableFlags", check:GetChecked()) end)
	self.mapSettings.Ground = util.createCheckboxChild(L["Ground Mounts Only"], self.mapSettings.Flags)
	self.mapSettings.Ground:HookScript("OnClick", function(check) self:setFlag("groundOnly", check:GetChecked()) end)
	self.mapSettings.WaterWalk = util.createCheckboxChild(L["Water Walking"], self.mapSettings.Flags)
	self.mapSettings.WaterWalk.tooltipText = L["Water Walking"]
	self.mapSettings.WaterWalk.tooltipRequirement = L["WaterWalkFlagDescription"]
	self.mapSettings.WaterWalk:HookScript("OnClick", function(check) self:setFlag("waterWalkOnly", check:GetChecked()) end)
	self.mapSettings.listFromMap = lsfdd:CreateStretchButtonOriginal(self.mapSettings, 134, 30, true)
	self.mapSettings.listFromMap:SetPoint("BOTTOMLEFT", 33, 15)
	self.mapSettings.listFromMap:SetText(L["ListMountsFromZone"])
	self.mapSettings.listFromMap.maps = {}
	self.mapSettings.listFromMap:SetScript("OnClick", function(btn) self:listFromMapClick(btn) end)
	self.mapSettings.listFromMap:ddSetDisplayMode(addon)
	self.mapSettings.listFromMap:ddSetInitFunc(function(...) self:listFromMapInit(...) end)
	self.mapSettings.relationMap:SetPoint("LEFT", self.mapSettings.listFromMap, "RIGHT", 5, 0)
	self.mapSettings.relationClear:SetScript("OnClick", function()
		PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
		self.currentList.listFromID = nil
		self:getRemoveMountList(self.navBar.mapID)
		self:setEditMountsList()
		self:updateMountsList()
		self:updateMapSettings()
		-- mounts:setMountsList()
		self.existingLists:refresh()

		self.mountListUpdateAnim:Stop()
		self.mountListUpdateAnim:Play()
	end)

	-- EXISTING LISTS TOGGLE
	self.mapSettings.existingListsToggle:HookScript("OnClick", function(btn)
		self.existingLists:SetShown(btn:GetChecked())
	end)

	-- SCROLL FRAME
	self.scrollFrame.scrollBar.doNotHide = true
	HybridScrollFrame_CreateButtons(self.scrollFrame, "MJMountListPanelTemplate", 1, 0)

	local function mouseDown(btn, mouse) self.tags:hideDropDown(mouse) end
	local function typeClick(btn) self:mountToggle(btn) end
	local function dragClick(btn, mouse) self.tags:dragButtonClick(btn, mouse) end
	local function btnClick(btn, mouse) self.tags:listItemClick(btn:GetParent(), btn, mouse) end
	local function drag(btn) self.tags:dragMount(btn:GetParent().index) end
	local function grid3Click(btn, mouse) self.tags:listItemClick(btn, btn, mouse) end
	local function grid3Drag(btn) self.tags:dragMount(btn.index) end

	for _, child in ipairs(self.scrollFrame.buttons) do
		child.defaultList.dragButton:SetScript("OnMouseDown", mouseDown)
		child.defaultList.dragButton:SetScript("OnClick", dragClick)
		child.defaultList.dragButton:SetScript("OnDragStart", drag)
		child.defaultList.btn:SetScript("OnMouseDown", mouseDown)
		child.defaultList.btn:SetScript("OnClick", btnClick)
		child.defaultList.fly:SetScript("OnClick", typeClick)
		child.defaultList.ground:SetScript("OnClick", typeClick)
		child.defaultList.swimming:SetScript("OnClick", typeClick)
		for i, btn in ipairs(child.grid3List.mounts) do
			btn:SetScript("OnMouseDown", mouseDown)
			btn:SetScript("OnClick", grid3Click)
			btn:SetScript("OnDragStart", grid3Drag)
			btn.fly:SetScript("OnClick", typeClick)
			btn.ground:SetScript("OnClick", typeClick)
			btn.swimming:SetScript("OnClick", typeClick)
		end
	end

	self.default_UpdateMountList = function(...) self:defaultUpdateMountList(...) end
	self.grid3_UpdateMountList = function(...) self:grid3UpdateMountList(...) end
	self:setScrollGridMounts(mounts.config.gridToggle)

	-- MOUNT LEARNED
	self:on("MOUNT_LEARNED", function()
		self:updateCountMounts()
		self:sortMounts()
	end)

	-- FILTERS BAR
	self.filtersBar.clear:SetScript("OnClick", function() self:clearBtnFilters() end)

	local function tabClick(self)
		PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
		local id = self.id

		for _, tab in ipairs(self:GetParent().tabs) do
			if tab.id == id then
				tab.selected:Show()
				tab.content:Show()
			else
				tab.selected:Hide()
				tab.content:Hide()
			end
		end
	end

	local function setTabs(frame, ...)
		frame.tabs = {}

		for i = 1, select("#", ...) do
			local tab = CreateFrame("BUTTON", nil, frame, "MJTabTemplate")
			tab.id = select(i, ...)

			if i == 1 then
				tab:SetPoint("BOTTOMLEFT", frame, "TOPLEFT", 4, -4)
			else
				tab:SetPoint("LEFT", frame.tabs[i - 1], "RIGHT", -5, 0)
			end

			tab.text:SetText(L[tab.id])
			tab.content:SetPoint("TOPLEFT", frame, "TOPLEFT")
			tab.content:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT")
			tab:SetScript("OnClick", tabClick)

			frame[tab.id] = tab.content
			frame.tabs[i] = tab
		end

		if #frame.tabs ~= 0 then
			tabClick(frame.tabs[1])
		end
	end
	setTabs(self.filtersBar, "types", "selected", "sources")

	-- FILTERS BTN TOGGLE
	self.filtersToggle.vertical = true
	self.filtersToggle:SetChecked(mounts.config.filterToggle)

	self.filtersToggle.setFiltersToggleCheck = function()
		if mounts.config.filterToggle then
			self.filtersPanel:SetHeight(84)
			self.filtersBar:Show()
		else
			self.filtersPanel:SetHeight(29)
			self.filtersBar:Hide()
		end
	end
	self.filtersToggle.setFiltersToggleCheck()

	self.filtersToggle:HookScript("OnClick", function(btn)
		mounts.config.filterToggle = btn:GetChecked()
		btn.setFiltersToggleCheck()
	end)

	-- GRID TOGGLE BUTTON
	self.gridToggleButton:SetChecked(mounts.config.gridToggle)

	function self.gridToggleButton:setCoordIcon()
		if self:GetChecked() then
			self.icon:SetTexCoord(0, .625, 0, .25)
		else
			self.icon:SetTexCoord(0, .625, .28125, .5325)
		end
	end
	self.gridToggleButton:setCoordIcon()

	self.gridToggleButton:SetScript("OnClick", function(btn)
		PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
		local checked = btn:GetChecked()
		mounts.config.gridToggle = checked
		btn:setCoordIcon()
		self:setScrollGridMounts(checked)
	end)

	-- SEARCH BOX
	self.searchBox:HookScript("OnTextChanged", function(editBox, userInput)
		if userInput then
			self:updateMountsList()
		end
	end)
	self.searchBox:SetScript("OnHide", function(editBox)
		local text = editBox:GetText()
		if #text > 0 then
			editBox:SetText("")
			self:updateMountsList()
		end
	end)
	self.searchBox.clearButton:HookScript("OnClick", function()
		self:updateMountsList()
	end)

	-- FILTERS BUTTON
	self.filtersButton = lsfdd:CreateStretchButtonOriginal(self.filtersPanel, nil, 22)
	self.filtersButton:SetPoint("LEFT", self.searchBox, "RIGHT", -1, 0)
	self.filtersButton:SetPoint("TOPRIGHT", -3, -4)
	self.filtersButton:SetText(FILTER)
	self.filtersButton:ddSetDisplayMode(addon)
	self.filtersButton:ddSetInitFunc(function(...) self:filterDropDown_Initialize(...) end)

	-- MOUNTS WEIGHT SLIDER
	local weightControl_OnEnter = function(self)
		local parent = self:GetParent()
		parent:GetScript("OnEnter")(parent)
	end
	self.weightFrame:setOnChanged(function(frame, value)
		frame.setFunc(value)
		frame.slider.isModified = true
	end)
	self.weightFrame:setMinMax(1, 100)
	self.weightFrame:setText(L["Chance of summoning"])
	self.weightFrame:SetScript("OnEnter", function(frame)
		self.filtersButton:ddCloseMenus(frame.level)
	end)
	self.weightFrame.slider:HookScript("OnEnter", weightControl_OnEnter)
	self.weightFrame.slider:HookScript("OnMouseUp", function(slider)
		journal:updateMountsList()
		slider.isModified = nil
	end)
	self.weightFrame.slider:HookScript("OnHide", function(slider)
		if slider.isModified then
			journal:updateMountsList()
			slider.isModified = nil
		end
	end)
	self.weightFrame.slider:HookScript("OnMouseWheel", function()
		journal:updateMountsList()
	end)
	self.weightFrame.edit:HookScript("OnEnter", weightControl_OnEnter)
	self.weightFrame.edit:HookScript("OnEnterPressed", function()
		journal:updateMountsList()
	end)

	-- FILTERS BUTTONS
	local function filterClick(btn)
		self:setBtnFilters(btn:GetParent():GetParent().id)
	end

	local function filterEnter(btn)
		GameTooltip:SetOwner(btn, "ANCHOR_BOTTOM")
		GameTooltip:SetText(btn.tooltip)
		GameTooltip:Show()
	end

	local function filterLeave()
		GameTooltip:Hide()
	end

	local function CreateButtonFilter(id, parent, width, height, texture, tooltip)
		local btn = CreateFrame("CheckButton", nil, parent, width == height and "MJFilterButtonSquareTemplate" or "MJFilterButtonRectangleTemplate")
		btn.id = id
		btn.tooltip = tooltip
		btn:SetSize(width, height)
		if id == 1 then
			btn:SetPoint("LEFT", 5, 0)
			parent.childs = {}
		else
			btn:SetPoint("LEFT", parent.childs[#parent.childs], "RIGHT")
		end
		parent.childs[#parent.childs + 1] = btn

		btn.icon:SetTexture(texture.path)
		btn.icon:SetSize(texture.width, texture.height)
		if texture.texCoord then btn.icon:SetTexCoord(unpack(texture.texCoord)) end

		btn:SetScript("OnClick", filterClick)
		btn:SetScript("OnEnter", filterEnter)
		btn:SetScript("OnLeave", filterLeave)
	end

	-- FILTERS TYPES BUTTONS
	local typesTextures = {
		{path = texPath.."fly", width = 32, height = 16},
		{path = texPath.."ground", width = 32, height = 16},
		{path = texPath.."swimming", width = 32, height = 16},
	}

	for i = 1, #typesTextures do
		CreateButtonFilter(i, self.filtersBar.types, 83.3333, 25, typesTextures[i], L["MOUNT_TYPE_"..i])
	end

	-- FILTERS SELECTED BUTTONS
	typesTextures[4] = {path = "Interface/BUTTONS/UI-GROUPLOOT-PASS-DOWN", width = 16, height = 16}
	for i = 1, #typesTextures do
		CreateButtonFilter(i, self.filtersBar.selected, 62.5, 25, typesTextures[i], L["MOUNT_TYPE_"..i])
	end

	-- FILTERS SOURCES BUTTONS
	local sourcesTextures = {
		{path = texPath.."sources", texCoord = {0, .25, 0, .25}, width = 20, height = 20},
		{path = texPath.."sources", texCoord = {.25, .5, 0, .25}, width = 20, height = 20},
		{path = texPath.."sources", texCoord = {.5, .75, 0, .25}, width = 20, height = 20},
		{path = texPath.."sources", texCoord = {.75, 1, 0, .25}, width = 20, height = 20},
		nil,
		{path = texPath.."sources", texCoord = {.25, .5, .25, .5}, width = 20, height = 20},
		{path = texPath.."sources", texCoord = {.5, .75, .25, .5}, width = 20, height = 20},
		{path = texPath.."sources", texCoord = {.75, 1, .25, .5}, width = 20, height = 20},
		{path = texPath.."sources", texCoord = {0, .25, .5, .75}, width = 20, height = 20},
		{path = texPath.."sources", texCoord = {.25, .5, .5, .75}, width = 20, height = 20},
		-- {path = texPath.."sources", texCoord = {.5, .75, .5, .75}, width = 20, height = 20},
	}

	for i = 1, #sourcesTextures do
		if sourcesTextures[i] then
			CreateButtonFilter(i, self.filtersBar.sources, 27.7778, 25, sourcesTextures[i], _G["BATTLE_PET_SOURCE_"..i])
		end
	end

	-- SHOWN PANEL
	self.shownPanel.text:SetText(L["Shown:"])
	self.shownPanel.clear:SetScript("OnClick", function() self:resetToDefaultFilters() end)

	-- MODEL SCENE
	function self.modelScene:CreateOrTransitionActorFromScene(oldTagToActor, actorID)
		local actorInfo = C_ModelInfo.GetModelSceneActorInfoByID(11)
		actorInfo.modelActorID = actorID
		actorInfo.scriptTag = "unwrapped"
		actorInfo.yaw = 0
		actorInfo.pitch = 0
		actorInfo.roll = 0
		actorInfo.normalizeScaleAggressiveness = nil
		actorInfo.modelActorDisplayID = 6
		actorInfo.useCenterForOriginX = false
		actorInfo.useCenterForOriginY = false
		actorInfo.useCenterForOriginZ = true
		actorInfo.position.x = 0
		actorInfo.position.y = 0
		actorInfo.position.z = 0

		local existingActor = oldTagToActor[actorInfo.scriptTag]
		if existingActor then
			self:InitializeActor(existingActor, actorInfo)
			return existingActor
		end

		return self:AcquireAndInitializeActor(actorInfo)
	end

	function self.modelScene:CreateCameraFromScene(modelSceneCameraID)
		local modelSceneCameraInfo = C_ModelInfo.GetModelSceneCameraInfoByID(7)
		modelSceneCameraInfo.cameraType = "OrbitCamera"
		modelSceneCameraInfo.modelSceneCameraID = modelSceneCameraID
		modelSceneCameraInfo.yaw = 2.6179938316345
		modelSceneCameraInfo.pitch = 0
		modelSceneCameraInfo.roll = 0
		modelSceneCameraInfo.zoomedYawOffset = .17453292012215
		modelSceneCameraInfo.zoomedPitchOffset = 0
		modelSceneCameraInfo.zoomedRollOffset = 0
		modelSceneCameraInfo.minZoomDistance = 8
		modelSceneCameraInfo.flags = 1
		modelSceneCameraInfo.scriptTag = "primary"
		modelSceneCameraInfo.zoomDistance = 14
		modelSceneCameraInfo.maxZoomDistance = 24
		modelSceneCameraInfo.zoomedTargetOffset.x = 0
		modelSceneCameraInfo.zoomedTargetOffset.y = 0
		modelSceneCameraInfo.zoomedTargetOffset.z = -1.5
		modelSceneCameraInfo.target.x = 0
		modelSceneCameraInfo.target.y = 0
		modelSceneCameraInfo.target.z = 1
		if modelSceneCameraInfo then
			local camera = CameraRegistry:CreateCameraByType(modelSceneCameraInfo.cameraType)
			if camera then
				if modelSceneCameraInfo.scriptTag then
					self.tagToCamera[modelSceneCameraInfo.scriptTag] = camera
				end
				self:AddCamera(camera);
				camera:ApplyFromModelSceneCameraInfo(modelSceneCameraInfo, CAMERA_TRANSITION_TYPE_IMMEDIATE, CAMERA_MODIFICATION_TYPE_DISCARD)
				return camera
			end
		end
	end

	function self.modelScene:CreateOrTransitionCameraFromScene(oldTagToCamera, cameraTransitionType, cameraModificationType, modelSceneCameraID)
		local modelSceneCameraInfo = C_ModelInfo.GetModelSceneCameraInfoByID(7)
		modelSceneCameraInfo.cameraType = "OrbitCamera"
		modelSceneCameraInfo.modelSceneCameraID = modelSceneCameraID
		modelSceneCameraInfo.yaw = 2.6179938316345
		modelSceneCameraInfo.pitch = 0
		modelSceneCameraInfo.roll = 0
		modelSceneCameraInfo.zoomedYawOffset = .17453292012215
		modelSceneCameraInfo.zoomedPitchOffset = 0
		modelSceneCameraInfo.zoomedRollOffset = 0
		modelSceneCameraInfo.minZoomDistance = 8
		modelSceneCameraInfo.flags = 1
		modelSceneCameraInfo.scriptTag = "primary"
		modelSceneCameraInfo.zoomDistance = 14
		modelSceneCameraInfo.maxZoomDistance = 24
		modelSceneCameraInfo.zoomedTargetOffset.x = 0
		modelSceneCameraInfo.zoomedTargetOffset.y = 0
		modelSceneCameraInfo.zoomedTargetOffset.z = -1.5
		modelSceneCameraInfo.target.x = 0
		modelSceneCameraInfo.target.y = 0
		modelSceneCameraInfo.target.z = 1

		if modelSceneCameraInfo then
			local existingCamera = oldTagToCamera[modelSceneCameraInfo.scriptTag]
			if existingCamera and existingCamera:GetCameraType() == modelSceneCameraInfo.cameraType then
				self.tagToCamera[modelSceneCameraInfo.scriptTag] = existingCamera;

				self:AddCamera(existingCamera)
				existingCamera:ApplyFromModelSceneCameraInfo(modelSceneCameraInfo, cameraTransitionType, cameraModificationType)
				return existingCamera
			end

			return self:CreateCameraFromScene(modelSceneCameraID)
		end
	end

	-- MODEL SCENE CAMERA
	hooksecurefunc(self.modelScene, "SetActiveCamera", function(self)
		journal:event("SET_ACTIVE_CAMERA", self.activeCamera)
	end)

	-- CAMERA X INITIAL ACCELERATION
	self.xInitialAcceleration = CreateFrame("FRAME", nil, nil, "MJSliderFrameTemplate")
	self.xInitialAcceleration:setOnChanged(function(frame, value)
		mounts.cameraConfig.xInitialAcceleration = value
	end)
	self.xInitialAcceleration:setStep(.1)
	self.xInitialAcceleration:setMinMax(.1, 1)
	self.xInitialAcceleration:setText(L["Initial x-axis accseleration"])

	-- CAMERA X ACCELERATION
	self.xAcceleration = CreateFrame("FRAME", nil, nil, "MJSliderFrameTemplate")
	self.xAcceleration:setOnChanged(function(frame, value)
		mounts.cameraConfig.xAcceleration = value
	end)
	self.xAcceleration:setStep(.1)
	self.xAcceleration:setMinMax(-2, -.1)
	self.xAcceleration:setText(L["X-axis accseleration"])
	self.xAcceleration:setMaxLetters(4)

	-- CAMERA X MIN ACCELERATION
	self.xMinSpeed = CreateFrame("FRAME", nil, nil, "MJSliderFrameTemplate")
	self.xMinSpeed:setOnChanged(function(frame, value)
		mounts.cameraConfig.xMinSpeed = value
	end)
	self.xMinSpeed:setMinMax(0, 10)
	self.xMinSpeed:setText(L["Minimum x-axis speed"])

	-- CAMERA Y INITIAL ACCELERATION
	self.yInitialAcceleration = CreateFrame("FRAME", nil, nil, "MJSliderFrameTemplate")
	self.yInitialAcceleration:setOnChanged(function(frame, value)
		mounts.cameraConfig.yInitialAcceleration = value
	end)
	self.yInitialAcceleration:setStep(.1)
	self.yInitialAcceleration:setMinMax(.1, 1)
	self.yInitialAcceleration:setText(L["Initial y-axis accseleration"])

	-- CAMERA Y ACCELERATION
	self.yAcceleration = CreateFrame("FRAME", nil, nil, "MJSliderFrameTemplate")
	self.yAcceleration:setOnChanged(function(frame, value)
		mounts.cameraConfig.yAcceleration = value
	end)
	self.yAcceleration:setStep(.1)
	self.yAcceleration:setMinMax(-2, -.1)
	self.yAcceleration:setText(L["Y-axis accseleration"])
	self.yAcceleration:setMaxLetters(4)

	-- CAMERA Y MIN ACCELERATION
	self.yMinSpeed = CreateFrame("FRAME", nil, nil, "MJSliderFrameTemplate")
	self.yMinSpeed:setOnChanged(function(frame, value)
		mounts.cameraConfig.yMinSpeed = value
	end)
	self.yMinSpeed:setMinMax(0, 10)
	self.yMinSpeed:setText(L["Minimum y-axis speed"])

	-- MODEL SCENE SETTINGS
	local mssBtn = self.mountDisplay.modelSceneSettingsButton
	lsfdd:SetMixin(mssBtn)
	mssBtn:ddSetDisplayMode(addon)
	mssBtn:ddHideWhenButtonHidden()
	mssBtn:ddSetNoGlobalMouseEvent(true)

	mssBtn:ddSetInitFunc(function(btn, level)
		local info = {}

		info.keepShownOnClick = true
		info.isNotRadio = true
		info.text = L["Enable Acceleration around the X-axis"]
		info.checked = mounts.cameraConfig.xAccelerationEnabled
		info.func = function(_,_,_, checked)
			mounts.cameraConfig.xAccelerationEnabled = checked
		end
		btn:ddAddButton(info)

		info.customFrame = self.xInitialAcceleration
		info.OnLoad = function(frame)
			frame:setValue(mounts.cameraConfig.xInitialAcceleration)
		end
		btn:ddAddButton(info)

		info.customFrame = self.xAcceleration
		info.OnLoad = function(frame)
			frame:setValue(mounts.cameraConfig.xAcceleration)
		end
		btn:ddAddButton(info)

		info.customFrame = self.xMinSpeed
		info.OnLoad = function(frame)
			frame:setValue(mounts.cameraConfig.xMinSpeed)
		end
		btn:ddAddButton(info)

		btn:ddAddSpace()

		info.customFrame = nil
		info.text = L["Enable Acceleration around the Y-axis"]
		info.checked = mounts.cameraConfig.yAccelerationEnabled
		info.func = function(_,_,_, checked)
			mounts.cameraConfig.yAccelerationEnabled = checked
		end
		btn:ddAddButton(info)

		info.customFrame = self.yInitialAcceleration
		info.OnLoad = function(frame)
			frame:setValue(mounts.cameraConfig.yInitialAcceleration)
		end
		btn:ddAddButton(info)

		info.customFrame = self.yAcceleration
		info.OnLoad = function(frame)
			frame:setValue(mounts.cameraConfig.yAcceleration)
		end
		btn:ddAddButton(info)

		info.customFrame = self.yMinSpeed
		info.OnLoad = function(frame)
			frame:setValue(mounts.cameraConfig.yMinSpeed)
		end
		btn:ddAddButton(info)
	end)

	mssBtn:SetScript("OnClick", function(btn)
		PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
		btn:ddToggle(1, nil, btn, 0, 0)
	end)

	-- MODEL SCENE CONTROL
	local modelControl = self.modelScene.modelControl
	modelControl.zoomIn.icon:SetTexCoord(.57812500, .82812500, .14843750, .27343750)
	modelControl.zoomOut.icon:SetTexCoord(.29687500, .54687500, .00781250, .13281250)
	modelControl.panButton.icon:SetTexCoord(.29687500, .54687500, .28906250, .41406250)
	modelControl.rotateLeftButton.icon:SetTexCoord(.01562500, .26562500, .28906250, .41406250)
	modelControl.rotateRightButton.icon:SetTexCoord(.57812500, .82812500, .28906250, .41406250)
	modelControl.rotateUpButton.icon:SetTexCoord(.01562500, .26562500, .28906250, .41406250)
	modelControl.rotateUpButton.icon:SetRotation(-math.pi / 1.6, .5, .43)
	modelControl.rotateDownButton.icon:SetTexCoord(.57812500, .82812500, .41406250, .28906250)
	modelControl.rotateDownButton.icon:SetRotation(-math.pi / 1.6)

	modelControl.panButton:HookScript("OnMouseDown", function(self)
		self:GetParent():GetParent().isRightButtonDown = true
		MJModelPanningFrame:Show()
	end)
	modelControl.panButton:HookScript("OnMouseUp", function(self)
		self:GetParent():GetParent().isRightButtonDown = false
		MJModelPanningFrame:Hide()
	end)

	local function modelSceneControlOnUpdate(self, elapsed)
		self:GetParent():GetParent().activeCamera:HandleMouseMovement(self.cmd, elapsed * self.delta, self.snapToValue)
	end
	local function modelSceneControlOnMouseDown(self)
		self:SetScript("OnUpdate", modelSceneControlOnUpdate)
	end
	local function modelSceneControlOnMouseUp(self)
		self:SetScript("OnUpdate", nil)
	end

	modelControl.zoomIn:HookScript("OnMouseDown", modelSceneControlOnMouseDown)
	modelControl.zoomIn:HookScript("OnMouseUp", modelSceneControlOnMouseUp)
	modelControl.zoomOut:HookScript("OnMouseDown", modelSceneControlOnMouseDown)
	modelControl.zoomOut:HookScript("OnMouseUp", modelSceneControlOnMouseUp)
	modelControl.rotateLeftButton:HookScript("OnMouseDown", modelSceneControlOnMouseDown)
	modelControl.rotateLeftButton:HookScript("OnMouseUp", modelSceneControlOnMouseUp)
	modelControl.rotateRightButton:HookScript("OnMouseDown", modelSceneControlOnMouseDown)
	modelControl.rotateRightButton:HookScript("OnMouseUp", modelSceneControlOnMouseUp)
	modelControl.rotateUpButton:HookScript("OnMouseDown", modelSceneControlOnMouseDown)
	modelControl.rotateUpButton:HookScript("OnMouseUp", modelSceneControlOnMouseUp)
	modelControl.rotateDownButton:HookScript("OnMouseDown", modelSceneControlOnMouseDown)
	modelControl.rotateDownButton:HookScript("OnMouseUp", modelSceneControlOnMouseUp)

	modelControl.reset:SetScript("OnClick", function(self)
		self:GetParent():GetParent().activeCamera:resetPosition()
	end)

	-- SUMMON BUTTON
	self.summonButton:SetScript("OnClick", function()
		if self.selectedSpellID then
			self:useMount(self.selectedSpellID)
		end
	end)

	-- PROFILES
	self:on("UPDATE_PROFILE", function(self, changeProfile)
		mounts:setDB()
		self:setEditMountsList()
		self:updateMountsList()
		self:updateMapSettings()
		self.existingLists:refresh()

		if changeProfile then
			self.mountListUpdateAnim:Stop()
			self.mountListUpdateAnim:Play()
		end
	end)

	-- SETTINGS BUTTON
	self.bgFrame.btnConfig:SetText(L["Settings"])
	self.bgFrame.btnConfig:SetScript("OnClick", function() config:openConfig() end)

	-- MODULES INIT
	self:event("MODULES_INIT"):off("MODULES_INIT")

	-- INIT
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	self:RegisterEvent("COMPANION_UPDATE")
	self:RegisterEvent("PLAYER_REGEN_DISABLED")
	self:RegisterEvent("PLAYER_REGEN_ENABLED")

	self:RegisterEvent("ZONE_CHANGED")
	self:RegisterEvent("ZONE_CHANGED_INDOORS")
	self:RegisterEvent("ZONE_CHANGED_NEW_AREA")

	self:setArrowSelectMount(mounts.config.arrowButtonsBrowse)
	self:setEditMountsList()
	self:updateBtnFilters()
	self:sortMounts()
	self:selectMount(1)
	if not self.selectedSpellID then
		self:updateMountDisplay()
	end
end


function journal:createSecureButtons()
	self.createSecureButtons = nil

	self.bgFrame.summon1.secure = CreateFrame("BUTTON", nil, self.bgFrame.summon1, "MJSecureMacroButtonTemplate")
	local secure1 = self.bgFrame.summon1.secure
	secure1.parent = self.bgFrame.summon1
	secure1:SetAllPoints()
	secure1:SetAttribute("clickbutton", _G[config.secureButtonNameMount])

	self.bgFrame.summon2.secure = CreateFrame("BUTTON", nil, self.bgFrame.summon2, "MJSecureMacroButtonTemplate")
	local secure2 = self.bgFrame.summon2.secure
	secure2.parent = self.bgFrame.summon2
	secure2:SetAllPoints()
	secure2:SetAttribute("clickbutton", _G[config.secureButtonNameSecondMount])
end


function journal:PLAYER_REGEN_DISABLED()
	self.bgFrame.summon1.icon:SetDesaturated(true)
	self.bgFrame.summon2.icon:SetDesaturated(true)
	self.bgFrame.summon1.secure:Hide()
	self.bgFrame.summon2.secure:Hide()
end


function journal:PLAYER_REGEN_ENABLED()
	if self.createSecureButtons then
		self:createSecureButtons()
	else
		self.bgFrame.summon1.icon:SetDesaturated(false)
		self.bgFrame.summon2.icon:SetDesaturated(false)
		self.bgFrame.summon1.secure:Show()
		self.bgFrame.summon2.secure:Show()
	end
end


function journal:COMPANION_UPDATE(companionType)
	if companionType == "MOUNT" then
		self.scrollFrame:update()
		self:updateMountDisplay()
	end
end


function journal:setScrollGridMounts(grid)
	local scrollFrame = self.scrollFrame
	local offset = math.floor((scrollFrame.offset or 0) + .1)

	if grid then
		offset = math.ceil((offset + 1) / 3) - 1
		scrollFrame.update = self.grid3_UpdateMountList
	else
		offset = offset * 3
		scrollFrame.update = self.default_UpdateMountList
	end

	for _, btn in ipairs(scrollFrame.buttons) do
		btn.defaultList:SetShown(not grid)
		btn.grid3List:SetShown(grid)
	end

	scrollFrame:update()
	scrollFrame.scrollBar:SetValue(offset * scrollFrame.buttonHeight)
end


do
	local function setColor(self, btn, checked)
		local color = checked and self.colors.gold or self.colors.gray
		btn.icon:SetVertexColor(color:GetRGB())
		btn:SetChecked(checked)
	end

	function journal:updateMountToggleButton(btn)
		if btn.spellID then
			btn.fly:Enable()
			btn.ground:Enable()
			btn.swimming:Enable()
			setColor(self, btn.fly, self.list and self.list.fly[btn.spellID])
			setColor(self, btn.ground, self.list and self.list.ground[btn.spellID])
			setColor(self, btn.swimming, self.list and self.list.swimming[btn.spellID])
		else
			btn.fly:Disable()
			btn.ground:Disable()
			btn.swimming:Disable()
		end
	end
end


local function getColorWeight(weight)
	if weight > 50 then
		return ("|cff%02xff00%d%%|r"):format((100 - weight) * 5.1, weight)
	else
		return ("|cffff%02x00%d%%|r"):format(weight * 5.1, weight)
	end
end


function journal:defaultUpdateMountList(scrollFrame)
	local offset = HybridScrollFrame_GetOffset(scrollFrame)
	local numDisplayedMounts = #self.displayedMounts
	local canUseFlying = mounts:isCanUseFlying()

	for i = 1, #scrollFrame.buttons do
		local index = offset + i
		local dlist = scrollFrame.buttons[i].defaultList

		if index <= numDisplayedMounts then
			local spellID = self.displayedMounts[index]
			local faction = util.getMountInfoBySpellID(spellID)
			local name, _, icon = GetSpellInfo(spellID)
			local mountIndex, isCollected, active = mounts.indexBySpellID[spellID]
			if mountIndex then
				local creatureID, creatureName, creatureSpellID, icon, isSummoned = GetCompanionInfo("MOUNT", mountIndex)
				isCollected = true
				active = isSummoned
			end

			dlist.index = index
			dlist.spellID = spellID

			dlist.dragButton.icon:SetTexture(icon)
			dlist.dragButton.icon:SetVertexColor(1, 1, 1)
			dlist.dragButton.hidden:SetShown(self:isMountHidden(spellID))
			dlist.dragButton.favorite:SetShown(mounts.mountFavoritesList[spellID])
			dlist.dragButton.activeTexture:SetShown(active)

			local mountWeight = self.mountsWeight[spellID]
			if mountWeight then
				dlist.dragButton.mountWeight:SetText(getColorWeight(mountWeight))
				dlist.dragButton.mountWeight:Show()
				dlist.dragButton.mountWeightBG:Show()
			else
				dlist.dragButton.mountWeight:Hide()
				dlist.dragButton.mountWeightBG:Hide()
			end

			dlist.btn:Enable()
			dlist.btn.name:SetText(name)
			dlist.btn.background:SetVertexColor(1, 1, 1)
			dlist.btn.selectedTexture:SetShown(spellID == self.selectedSpellID)

			if faction < 3 then
				dlist.btn.factionIcon:SetAtlas(faction == 1 and "MountJournalIcons-Horde" or "MountJournalIcons-Alliance")
				dlist.btn.factionIcon:Show()
			else
				dlist.btn.factionIcon:Hide()
			end

			if mounts:isUsable(spellID, canUseFlying) then
				dlist.dragButton:Enable()
				dlist.dragButton.icon:SetDesaturated()
				dlist.dragButton.icon:SetAlpha(1)
				dlist.btn.name:SetFontObject("GameFontNormal")
			elseif isCollected then
				dlist.dragButton:Enable()
				dlist.dragButton.icon:SetDesaturated(true)
				dlist.dragButton.icon:SetVertexColor(.58823529411765, .19607843137255, .19607843137255)
				dlist.dragButton.icon:SetAlpha(.75)
				dlist.btn.name:SetFontObject("GameFontNormal")
				dlist.btn.background:SetVertexColor(1, 0, 0)
			else
				dlist.dragButton:Disable()
				dlist.dragButton.icon:SetDesaturated(true)
				dlist.dragButton.icon:SetAlpha(.25)
				dlist.btn.name:SetFontObject("GameFontDisable")
			end

			if dlist.showingTooltip then
				GameTooltip:SetHyperlink("spell:"..spellID)
			end
		else
			dlist.index = nil
			dlist.spellID = nil

			dlist.dragButton:Disable()
			dlist.dragButton.icon:SetTexture("Interface/PetBattles/MountJournalEmptyIcon")
			dlist.dragButton.icon:SetVertexColor(1, 1, 1)
			dlist.dragButton.icon:SetAlpha(.5)
			dlist.dragButton.icon:SetDesaturated(true)
			dlist.dragButton.hidden:Hide()
			dlist.dragButton.favorite:Hide()
			dlist.dragButton.activeTexture:Hide()
			dlist.dragButton.mountWeight:Hide()
			dlist.dragButton.mountWeightBG:Hide()

			dlist.btn:Disable()
			dlist.btn.name:SetText("")
			dlist.btn.factionIcon:Hide()
			dlist.btn.background:SetVertexColor(1, 1, 1)
			dlist.btn.selectedTexture:Hide()
		end

		self:updateMountToggleButton(dlist)
	end

	HybridScrollFrame_Update(scrollFrame, scrollFrame.buttonHeight * numDisplayedMounts, scrollFrame:GetHeight())
end


function journal:grid3UpdateMountList(scrollFrame)
	local offset = HybridScrollFrame_GetOffset(scrollFrame)
	local numDisplayedMounts = #self.displayedMounts
	local canUseFlying = mounts:isCanUseFlying()

	for i = 1, #scrollFrame.buttons do
		local grid3Buttons = scrollFrame.buttons[i].grid3List.mounts
		for j = 1, 3 do
			local index = (offset + i - 1) * 3 + j
			local g3btn = grid3Buttons[j]

			if index <= numDisplayedMounts then
				local spellID = self.displayedMounts[index]
				local name, _, icon = GetSpellInfo(spellID)
				local mountIndex, isCollected, active = mounts.indexBySpellID[spellID]
				if mountIndex then
					local creatureID, creatureName, creatureSpellID, icon, isSummoned = GetCompanionInfo("MOUNT", mountIndex)
					isCollected = true
					active = isSummoned
				end

				g3btn.index = index
				g3btn.spellID = spellID
				g3btn.active = active
				g3btn.icon:SetTexture(icon)
				g3btn.icon:SetVertexColor(1, 1, 1)
				g3btn:Enable()
				g3btn.selectedTexture:SetShown(spellID == self.selectedSpellID)
				g3btn.hidden:SetShown(self:isMountHidden(spellID))
				g3btn.favorite:SetShown(mounts.mountFavoritesList[spellID])

				local mountWeight = self.mountsWeight[spellID]
				if mountWeight then
					g3btn.mountWeight:SetText(getColorWeight(mountWeight))
					g3btn.mountWeight:Show()
					g3btn.mountWeightBG:Show()
				else
					g3btn.mountWeight:Hide()
					g3btn.mountWeightBG:Hide()
				end

				if mounts:isUsable(spellID, canUseFlying) then
					g3btn.icon:SetDesaturated()
					g3btn.icon:SetAlpha(1)
				elseif isCollected then
					g3btn.icon:SetDesaturated(true)
					g3btn.icon:SetVertexColor(.58823529411765, .19607843137255, .19607843137255)
					g3btn.icon:SetAlpha(.75)
				else
					g3btn.icon:SetDesaturated(true)
					g3btn.icon:SetAlpha(.5)
				end

				if g3btn.showingTooltip then
					GameTooltip:SetHyperlink("spell:"..spellID)
				end
			else
				g3btn.icon:SetTexture("Interface/PetBattles/MountJournalEmptyIcon")
				g3btn.icon:SetDesaturated(true)
				g3btn.icon:SetVertexColor(.4, .4, .4)
				g3btn.icon:SetAlpha(.5)
				g3btn.index = nil
				g3btn.spellID = nil
				g3btn.selected = false
				g3btn:Disable()
				g3btn.selectedTexture:Hide()
				g3btn.hidden:Hide()
				g3btn.favorite:Hide()
				g3btn.mountWeight:Hide()
				g3btn.mountWeightBG:Hide()
			end

			self:updateMountToggleButton(g3btn)
		end
	end

	HybridScrollFrame_Update(scrollFrame, scrollFrame.buttonHeight * math.ceil(numDisplayedMounts / 3), scrollFrame:GetHeight())
end


function journal:setArrowSelectMount(enabled)
	if not self.scrollFrame then return end
	if enabled then
		local time, pressed, delta, index
		local onUpdate = function(scroll, elapsed)
			time = time - elapsed
			if time <= 0 then
				time = .1
				index = index + delta
				if index < 1 or index > #self.displayedMounts then
					scroll:SetScript("OnUpdate", nil)
					return
				end
				self:selectMount(index)
			end
		end

		self.scrollFrame:SetScript("OnKeyDown", function(scroll, key)
			if key == "UP" or key == "DOWN" or key == "LEFT" or key == "RIGHT" then
				scroll:SetPropagateKeyboardInput(false)

				delta = (key == "UP" or key == "LEFT") and -1 or 1
				if mounts.config.gridToggle and (key == "UP" or key == "DOWN") then
					delta = delta * 3
				end

				index = nil
				for i = 1, #self.displayedMounts do
					if self.selectedSpellID == self.displayedMounts[i] then
						index = i
						break
					end
				end

				if not index then
					if mounts.config.gridToggle then
						index = scroll.buttons[1].grid3List.mounts[1].index
					else
						index = scroll.buttons[1].defaultList.index
					end
					if not index then return end
				else
					index = index + delta
					if index < 1 or index > #self.displayedMounts then return end
				end
				self:selectMount(index)

				pressed = key
				time = .5
				scroll:SetScript("OnUpdate", onUpdate)
			else
				scroll:SetPropagateKeyboardInput(true)
			end
		end)

		self.scrollFrame:SetScript("OnKeyUp", function(scroll, key)
			if pressed == key then
				scroll:SetScript("OnUpdate", nil)
			end
		end)

		self.scrollFrame:SetScript("OnHide", function(scroll)
			scroll:SetScript("OnUpdate", nil)
		end)
	else
		self.scrollFrame:SetScript("OnKeyDown", nil)
		self.scrollFrame:SetScript("OnKeyUp", nil)
		self.scrollFrame:SetScript("OnHide", nil)
		self.scrollFrame:SetScript("OnUpdate", nil)
	end
end


function journal:setEditMountsList()
	self.db = mounts.charDB.currentProfileName and mounts.profiles[mounts.charDB.currentProfileName] or mounts.defProfile
	self.zoneMounts = self.db.zoneMountsFromProfile and mounts.defProfile.zoneMounts or self.db.zoneMounts
	local mapID = self.navBar.mapID
	if mapID == self.navBar.defMapID then
		self.currentList = self.db
		self.listMapID = nil
		self.list = self.currentList
	else
		self.currentList = self.zoneMounts[mapID]
		self.listMapID = mapID
		self.list = self.currentList
		while self.list and self.list.listFromID do
			if self.list.listFromID == self.navBar.defMapID then
				self.listMapID = nil
				self.list = self.db
			else
				self.listMapID = self.list.listFromID
				self.list = self.zoneMounts[self.listMapID]
			end
		end
	end
	self.petForMount = self.db.petListFromProfile and mounts.defProfile.petForMount or self.db.petForMount
	self.mountsWeight = self.db.mountsWeight
end


function journal:updateCountMounts()
	self.mountCount.count:SetText(#mounts.mountsDB)
	self.mountCount.collected:SetText(GetNumCompanions("MOUNT"))
end


function journal:sortMounts()
	local fSort, mCache = mounts.filters.sorting, {}

	local function setMCache(info)
		mCache[info] = GetSpellInfo(info[1])
	end

	sort(mounts.mountsDB, function(a, b)
		if a == b then return false end

		-- FAVORITES
		if fSort.favoritesFirst then
			local isFavoriteA = mounts.mountFavoritesList[a[1]]
			local isFavoriteB = mounts.mountFavoritesList[b[1]]

			if isFavoriteA and not isFavoriteB then return true
			elseif not isFavoriteA and isFavoriteB then return false end
		end

		-- COLLECTED
		local isCollectedA = mounts.indexBySpellID[a[1]]
		local isCollectedB = mounts.indexBySpellID[b[1]]

		if isCollectedA and not isCollectedB then return true
		elseif not isCollectedA and isCollectedB then return false end

		-- TYPE
		if fSort.by == "type" then
			local typeA = a[3]
			local typeB = b[3]

			if typeA < typeB then return not fSort.reverse
			elseif typeA > typeB then return fSort.reverse end
		-- EXPANSION
		elseif fSort.by == "expansion" then
			local expansionA = a[6]
			local expansionB = b[6]

			if expansionA < expansionB then return not fSort.reverse
			elseif expansionA > expansionB then return fSort.reverse end
		end

		-- NAME
		if not mCache[a] then setMCache(a) end
		if not mCache[b] then setMCache(b) end
		local nameA = mCache[a]
		local nameB = mCache[b]
		local reverse = fSort.by == "name" and fSort.reverse

		if nameA < nameB then return not reverse
		elseif nameA > nameB then return reverse end

		return a[1] < b[1]
	end)

	self:updateMountsList()
end


-- isUsable FLAG CHANGED
function journal:PLAYER_ENTERING_WORLD()
	self:updateMountsList()
	self:updateMountDisplay()
end
journal.ZONE_CHANGED = journal.PLAYER_ENTERING_WORLD
journal.ZONE_CHANGED_INDOORS = journal.PLAYER_ENTERING_WORLD
journal.ZONE_CHANGED_NEW_AREA = journal.PLAYER_ENTERING_WORLD


function journal:createMountList(mapID)
	self.zoneMounts[mapID] = {
		fly = {},
		ground = {},
		swimming = {},
		flags = {},
	}
	self:setEditMountsList()
end


function journal:getRemoveMountList(mapID)
	if not mapID then return end
	local list = self.zoneMounts[mapID]

	local flags
	for _, value in pairs(list.flags) do
		if value then
			flags = true
			break
		end
	end

	if not (next(list.fly) or next(list.ground) or next(list.swimming))
	and not flags
	and not list.listFromID then
		self.zoneMounts[mapID] = nil
		self:setEditMountsList()
	end
end


function journal:mountToggle(btn)
	if not self.list then
		self:createMountList(self.listMapID)
	end
	local tbl = self.list[btn.type]
	local spellID = btn:GetParent().spellID

	PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
	if tbl[spellID] then
		tbl[spellID] = nil
		btn.icon:SetVertexColor(self.colors.gray:GetRGB())
		self:getRemoveMountList(self.listMapID)
	else
		tbl[spellID] = true
		btn.icon:SetVertexColor(self.colors.gold:GetRGB())
	end

	-- mounts:setMountsList()
	self.existingLists:refresh()
end


function journal:setFlag(flag, enable)
	if self.navBar.mapID == self.navBar.defMapID then return end

	if enable and not (self.currentList and self.currentList.flags) then
		self:createMountList(self.navBar.mapID)
	end
	self.currentList.flags[flag] = enable
	if not enable then
		self:getRemoveMountList(self.navBar.mapID)
	end

	-- mounts:setMountsList()
	self.existingLists:refresh()
end


do
	local mapLangTypes = {
		[1] = WORLD,
		[2] = CONTINENT,
		[3] = ZONE,
		[4] = INSTANCE,
	}
	function journal:listFromMapClick(btn)
		wipe(btn.maps)
		local assocMaps = {}
		for mapID, mapConfig in pairs(self.zoneMounts) do
			if not mapConfig.listFromID
			and mapID ~= self.navBar.mapID
			and (next(mapConfig.fly) or next(mapConfig.ground) or next(mapConfig.swimming)) then
				local mapInfo = util.getMapFullNameInfo(mapID)
				local mapLangType = mapLangTypes[mapInfo.mapType]
				if not mapLangType then
					mapInfo.mapType = 5
					mapLangType = OTHER
				end

				if not assocMaps[mapInfo.mapType] then
					assocMaps[mapInfo.mapType] = {
						name = mapLangType,
						list = {},
					}
					tinsert(btn.maps, assocMaps[mapInfo.mapType])
				end

				tinsert(assocMaps[mapInfo.mapType].list, {name = mapInfo.name, mapID = mapID})
			end
		end

		local function sortFunc(a, b) return a.name < b.name end
		sort(btn.maps, sortFunc)
		for _, mapInfo in ipairs(btn.maps) do
			sort(mapInfo.list, sortFunc)
		end

		PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
		btn:ddToggle(1, btn.maps, btn, 116, 21)
	end
end


do
	local function setListFrom(_, mapID)
		if journal.navBar.mapID == mapID then return end
		if not journal.currentList then
			journal:createMountList(journal.navBar.mapID)
		end
		journal.currentList.listFromID = mapID
		journal:setEditMountsList()
		journal:updateMountsList()
		journal:updateMapSettings()
		-- mounts:setMountsList()
		journal.existingLists:refresh()

		journal.mountListUpdateAnim:Stop()
		journal.mountListUpdateAnim:Play()
	end


	function journal:listFromMapInit(btn, level, value)
		local info = {}
		info.notCheckable = true

		if next(value) == nil then
			info.disabled = true
			info.text = EMPTY
			btn:ddAddButton(info, level)
		elseif level == 2 then
			info.list = {}
			for i, mapInfo in ipairs(value) do
				info.list[i] = {
					notCheckable = true,
					text = mapInfo.name,
					arg1 = mapInfo.mapID,
					func = setListFrom,
				}
			end
			btn:ddAddButton(info, level)
		else
			info.keepShownOnClick = true
			info.hasArrow = true
			for _, mapInfo in ipairs(value) do
				info.text = mapInfo.name
				info.value = mapInfo.list
				btn:ddAddButton(info, level)
			end

			info.keepShownOnClick = nil
			info.hasArrow = nil
			info.text = WORLD
			info.arg1 = self.navBar.defMapID
			info.func = setListFrom
			btn:ddAddButton(info, level)
		end
	end
end


function journal:updateMapSettings()
	local mapSettings = self.mapSettings
	if not mapSettings:IsShown() then return end
	local flags = self.currentList and self.currentList.flags

	mapSettings.Flags:SetChecked(flags and flags.enableFlags)
	mapSettings.Ground:SetChecked(flags and flags.groundOnly)
	mapSettings.WaterWalk:SetChecked(flags and flags.waterWalkOnly)

	local optionsEnable = self.navBar.mapID ~= self.navBar.defMapID
	mapSettings.Flags:SetEnabled(optionsEnable)
	mapSettings.listFromMap:SetEnabled(optionsEnable)

	local relationText = mapSettings.relationMap.text
	local relationClear = mapSettings.relationClear
	if self.currentList and self.currentList.listFromID then
		relationText:SetText(self.currentList.listFromID == self.navBar.defMapID and WORLD or util.getMapFullNameInfo(self.currentList.listFromID).name)
		relationText:SetTextColor(self.colors.gold:GetRGB())
		relationClear:Show()
	else
		relationText:SetText(L["No relation"])
		relationText:SetTextColor(self.colors.gray:GetRGB())
		relationClear:Hide()
	end
end


do
	local function transitionToModelSceneID(self, modelSceneID, cameraTransitionType, cameraModificationType, forceEvenIfSame)
		local modelSceneType, cameraIDs, actorIDs = 0, {1}, {1}

		if self.modelSceneID ~= modelSceneID or forceEvenIfSame then
			self.modelSceneID = modelSceneID
			self.cameraTransitionType = cameraTransitionType
			self.cameraModificationType = cameraModificationType
			self.forceEvenIfSame = forceEvenIfSame

			local actorsToRelease = {}
			for actor in self:EnumerateActiveActors() do
				actorsToRelease[actor] = true
			end

			local oldTagToActor = self.tagToActor
			self.tagToActor = {}

			for actorIndex, actorID in ipairs(actorIDs) do
				local actor = self:CreateOrTransitionActorFromScene(oldTagToActor, actorID)
				if actor then
					actorsToRelease[actor] = nil
				end
			end

			for actor in pairs(actorsToRelease) do
				self.actorPool:Release(actor)
			end

			local oldTagToCamera = self.tagToCamera
			self.tagToCamera = {}

			self.cameras = {}

			local needsNewCamera = true
			for cameraIndex, cameraID in ipairs(cameraIDs) do
				local camera = self:CreateOrTransitionCameraFromScene(oldTagToCamera, cameraTransitionType, cameraModificationType, cameraID)
				if camera == self.activeCamera then
					needsNewCamera = false
				end
			end

			if needsNewCamera then
				self:SetActiveCamera(self.cameras[1])
			end
			-- HACK: This should come from game data, instead we're caching them incase we Reset()
			self.lightDirX, self.lightDirY, self.lightDirZ = self:GetLightDirection()
		end

		C_ModelInfo.AddActiveModelScene(self, self.modelSceneID)
	end


	function journal:updateMountDisplay(forceSceneChange)
		local info = self.mountDisplay.info
		if self.selectedSpellID then
			local creatureName, _, icon = GetSpellInfo(self.selectedSpellID)
			local canUseFlying = mounts:isCanUseFlying()
			local isUsable = mounts:isUsable(self.selectedSpellID, canUseFlying)
			local mountIndex, active = mounts.indexBySpellID[self.selectedSpellID]
			if mountIndex then
				local creatureID, creatureName, creatureSpellID, icon, isSummoned = GetCompanionInfo("MOUNT", mountIndex)
				active = isSummoned
			end

			if self.mountDisplay.lastSpellID ~= self.selectedSpellID or forceSceneChange then
				self.mountDisplay.lastSpellID = self.selectedSpellID
				local faction, creatureID, mountType = util.getMountInfoBySpellID(self.selectedSpellID)

				info.name:SetText(creatureName)
				transitionToModelSceneID(self.modelScene, 4, CAMERA_TRANSITION_TYPE_IMMEDIATE, CAMERA_MODIFICATION_TYPE_MAINTAIN, forceSceneChange)

				local mountActor = self.modelScene:GetActorByTag("unwrapped")
				if mountActor then
					mountActor:SetModelByCreatureDisplayID(creatureID)

					-- mount self idle animation
					if isSelfMount then
						mountActor:SetAnimationBlendOperation(LE_MODEL_BLEND_OPERATION_NONE)
						mountActor:SetAnimation(618)
					else
						mountActor:SetAnimationBlendOperation(LE_MODEL_BLEND_OPERATION_ANIM)
						mountActor:SetAnimation(0)
					end
				end

				self:event("MOUNT_MODEL_UPDATE", mountType, self.selectedSpellID)
			end

			info.icon:SetTexture(icon)
			info:Show()
			self.modelScene:Show()
			self.mountDisplay.yesMountsTex:Show()
			self.mountDisplay.noMountsTex:Hide()
			self.mountDisplay.noMounts:Hide()

			if active then
				self.summonButton:SetText(BINDING_NAME_DISMOUNT)
				self.summonButton:SetEnabled(isUsable)
			else
				self.summonButton:SetText(MOUNT)
				self.summonButton:SetEnabled(isUsable)
			end
		else
			info:Hide()
			self.modelScene:Hide()
			self.mountDisplay.yesMountsTex:Hide()
			self.mountDisplay.noMountsTex:Show()
			self.mountDisplay.noMounts:Show()
			self.summonButton:Disable()
		end
	end
end


function journal:useMount(spellID)
	local index = mounts.indexBySpellID[spellID]
	if not index then return end
	local creatureID, creatureName, spellID, icon, active = GetCompanionInfo("MOUNT", index)
	if active then
		DismissCompanion("MOUNT")
	elseif mounts:isUsable(spellID, mounts:isCanUseFlying()) then
		mounts:summonPet(spellID)
		CallCompanion("MOUNT", index)
	end
end


do
	local function getMountButtonBySpellID(spellID)
		local buttons = journal.scrollFrame.buttons
		for i = 1, #buttons do
			local button = buttons[i]
			if mounts.config.gridToggle then
				for j = 1, 3 do
					local grid3Button = button.grid3List.mounts[j]
					if grid3Button.spellID == spellID then
						return grid3Button
					end
				end
			else
				if button.defaultList.spellID == spellID then
					return button
				end
			end
		end
	end


	function journal:setSelectedMount(spellID, index, button)
		self.selectedSpellID = spellID
		self.scrollFrame:update()
		self:updateMountDisplay()

		if not button then
			button = getMountButtonBySpellID(spellID)
		end
		if not button or (self.scrollFrame:GetBottom() or 0) >= (button:GetTop() or 0) then
			if not index then
				for i = 1, #self.displayedMounts do
					if spellID == self.displayedMounts[i] then
						index = i
						break
					end
				end
			end
			if index then
				if mounts.config.gridToggle then index = math.ceil(index / 3) end
				HybridScrollFrame_ScrollToIndex(self.scrollFrame, index, function() return self.scrollFrame.buttonHeight end)
			end
		end

		self:event("MOUNT_SELECT")
	end
end


function journal:selectMount(index)
	local spellID = self.displayedMounts[index]
	if spellID then self:setSelectedMount(spellID, index) end
end


function journal:filterDropDown_Initialize(btn, level, value)
	local info = {}
	info.keepShownOnClick = true
	info.isNotRadio = true

	if level == 1 then
		info.text = COLLECTED
		info.func = function(_,_,_, value)
			mounts.filters.collected = value
			self:updateMountsList()
		end
		info.checked = mounts.filters.collected
		btn:ddAddButton(info, level)

		info.text = NOT_COLLECTED
		info.func = function(_,_,_, value)
			mounts.filters.notCollected = value
			self:updateMountsList()
		end
		info.checked = mounts.filters.notCollected
		btn:ddAddButton(info, level)

		info.text = MOUNT_JOURNAL_FILTER_UNUSABLE
		info.func = function(_,_,_, value)
			mounts.filters.unusable = value
			self:updateMountsList()
		end
		info.checked = mounts.filters.unusable
		btn:ddAddButton(info, level)

		info.text = L["Hidden by player"]
		info.func = function(_,_,_, value)
			mounts.filters.hiddenByPlayer = value
			btn:ddRefresh(level)
			self:updateMountsList()
		end
		info.checked = mounts.filters.hiddenByPlayer
		btn:ddAddButton(info, level)

		info.indent = 16
		info.disabled = function() return not mounts.filters.hiddenByPlayer end
		info.text = L["only hidden"]
		info.func = function(_,_,_, value)
			mounts.filters.onlyHiddenByPlayer = value
			self:updateMountsList()
		end
		info.checked = mounts.filters.onlyHiddenByPlayer
		btn:ddAddButton(info, level)

		btn:ddAddSpace(level)

		info.indent = nil
		info.disabled = nil
		info.checked = nil
		info.isNotRadio = nil
		info.func = nil
		info.hasArrow = true
		info.notCheckable = true

		info.text = L["types"]
		info.value = 1
		btn:ddAddButton(info, level)

		info.text = L["selected"]
		info.value = 2
		btn:ddAddButton(info, level)

		info.text = SOURCES
		info.value = 3
		btn:ddAddButton(info, level)

		info.text = L["factions"]
		info.value = 4
		btn:ddAddButton(info, level)

		info.text = PET
		info.value = 5
		btn:ddAddButton(info, level)

		info.text = L["expansions"]
		info.value = 6
		btn:ddAddButton(info, level)

		info.text = L["Chance of summoning"]
		info.value = 7
		btn:ddAddButton(info, level)

		info.text = L["tags"]
		info.value = 8
		btn:ddAddButton(info, level)

		btn:ddAddSpace(level)

		info.text = L["sorting"]
		info.value = 9
		btn:ddAddButton(info, level)

		btn:ddAddSpace(level)

		info.keepShownOnClick = nil
		info.hasArrow = nil
		info.text = RESET
		info.func = function() self:resetToDefaultFilters() end
		btn:ddAddButton(info, level)

		info.text = L["Set current filters as default"]
		info.func = function() self:saveDefaultFilters() end
		btn:ddAddButton(info, level)

		info.text = L["Restore default filters"]
		info.func = function() self:restoreDefaultFilters() end
		btn:ddAddButton(info, level)
	else
		info.notCheckable = true

		if value == 1 then -- TYPES
			info.text = CHECK_ALL
			info.func = function()
				self:setAllFilters("types", true)
				self:updateBtnFilters()
				self:updateMountsList()
				btn:ddRefresh(level)
			end
			btn:ddAddButton(info, level)

			info.text = UNCHECK_ALL
			info.func = function()
				self:setAllFilters("types", false)
				self:updateBtnFilters()
				self:updateMountsList()
				btn:ddRefresh(level)
			end
			btn:ddAddButton(info, level)

			info.notCheckable = nil
			local types = mounts.filters.types
			for i = 1, 3 do
				info.text = L["MOUNT_TYPE_"..i]
				info.func = function(_,_,_, value)
					types[i] = value
					self:updateBtnFilters()
					self:updateMountsList()
				end
				info.checked = function() return types[i] end
				btn:ddAddButton(info, level)
			end
		elseif value == 2 then -- SELECTED
			info.text = CHECK_ALL
			info.func = function()
				self:setAllFilters("selected", true)
				self:updateBtnFilters()
				self:updateMountsList()
				btn:ddRefresh(level)
			end
			btn:ddAddButton(info, level)

			info.text = UNCHECK_ALL
			info.func = function()
				self:setAllFilters("selected", false)
				self:updateBtnFilters()
				self:updateMountsList()
				btn:ddRefresh(level)
			end
			btn:ddAddButton(info, level)

			info.notCheckable = nil
			local selected = mounts.filters.selected
			for i = 1, 4 do
				info.text = L["MOUNT_TYPE_"..i]
				info.func = function(_,_,_, value)
					selected[i] = value
					self:updateBtnFilters()
					self:updateMountsList()
				end
				info.checked = function() return selected[i] end
				btn:ddAddButton(info, level)
			end
		elseif value == 3 then -- SOURCES
			info.text = CHECK_ALL
			info.func = function()
				self:setAllFilters("sources", true)
				self:updateBtnFilters()
				self:updateMountsList()
				btn:ddRefresh(level)
			end
			btn:ddAddButton(info, level)

			info.text = UNCHECK_ALL
			info.func = function()
				self:setAllFilters("sources", false)
				self:updateBtnFilters()
				self:updateMountsList()
				btn:ddRefresh(level)
			end
			btn:ddAddButton(info, level)

			info.notCheckable = nil
			local sources = mounts.filters.sources
			for i = 1, 10 do
				if i ~= 5 then
					info.text = _G["BATTLE_PET_SOURCE_"..i]
					info.func = function(_,_,_, value)
						sources[i] = value
						self:updateBtnFilters()
						self:updateMountsList()
					end
					info.checked = function() return sources[i] end
					btn:ddAddButton(info, level)
				end
			end
		elseif value == 4 then -- FACTIONS
			info.text = CHECK_ALL
			info.func = function()
				self:setAllFilters("factions", true)
				self:updateMountsList()
				btn:ddRefresh(level)
			end
			btn:ddAddButton(info, level)

			info.text = UNCHECK_ALL
			info.func = function()
				self:setAllFilters("factions", false)
				self:updateMountsList()
				btn:ddRefresh(level)
			end
			btn:ddAddButton(info, level)

			info.notCheckable = nil
			local factions = mounts.filters.factions
			for i = 1, 3 do
				info.text = L["MOUNT_FACTION_"..i]
				info.func = function(_,_,_, value)
					factions[i] = value
					self:updateMountsList()
				end
				info.checked = function() return factions[i] end
				btn:ddAddButton(info, level)
			end
		elseif value == 5 then -- PET
			info.text = CHECK_ALL
			info.func = function()
				self:setAllFilters("pet", true)
				self:updateMountsList()
				btn:ddRefresh(level)
			end
			btn:ddAddButton(info, level)

			info.text = UNCHECK_ALL
			info.func = function()
				self:setAllFilters("pet", false)
				self:updateMountsList()
				btn:ddRefresh(level)
			end
			btn:ddAddButton(info, level)

			info.notCheckable = nil
			local pet = mounts.filters.pet
			for i = 1, 4 do
				info.text = L["PET_"..i]
				info.func = function(_,_,_, value)
					pet[i] = value
					self:updateMountsList()
				end
				info.checked = function() return pet[i] end
				btn:ddAddButton(info, level)
			end
		elseif value == 6 then -- EXPANSIONS
			info.text = CHECK_ALL
			info.func = function()
				self:setAllFilters("expansions", true)
				self:updateMountsList()
				btn:ddRefresh(level)
			end
			btn:ddAddButton(info, level)

			info.text = UNCHECK_ALL
			info.func = function()
				self:setAllFilters("expansions", false)
				self:updateMountsList()
				btn:ddRefresh(level)
			end
			btn:ddAddButton(info, level)

			info.notCheckable = nil
			local expansions = mounts.filters.expansions
			for i = 1, 3 do
				info.text = _G["EXPANSION_NAME"..(i - 1)]
				info.func = function(_,_,_, value)
					expansions[i] = value
					self:updateMountsList()
				end
				info.checked = function() return expansions[i] end
				btn:ddAddButton(info, level)
			end
		elseif value == 7 then -- CHANCE OF SUMMONING
			local filterWeight = mounts.filters.mountsWeight

			info.notCheckable = nil
			info.isNotRadio = nil

			info.text = L["Any"]
			info.func = function(button)
				filterWeight.sign = button.value
				btn:ddRefresh(level)
				self:updateMountsList()
			end
			info.checked = function() return not filterWeight.sign end
			btn:ddAddButton(info, level)

			info.text = L["> (more than)"]
			info.value = ">"
			info.checked = function() return filterWeight.sign == ">" end
			btn:ddAddButton(info, level)

			info.text = L["< (less than)"]
			info.value = "<"
			info.checked = function() return filterWeight.sign == "<" end
			btn:ddAddButton(info, level)

			info.text = L["= (equal to)"]
			info.value = "="
			info.checked = function() return filterWeight.sign == "=" end
			btn:ddAddButton(info, level)

			info.text = nil
			info.value = nil
			info.func = nil
			info.checked = nil
			info.customFrame = self.weightFrame
			info.OnLoad = function(frame)
				frame.level = level + 1
				frame:setValue(filterWeight.weight)
				frame.setFunc = function(value)
					if filterWeight.weight ~= value then
						filterWeight.weight = value
					end
				end
			end
			btn:ddAddButton(info, level)
		elseif value == 8 then -- TAGS
			local filterTags = self.tags.filter

			info.notCheckable = nil
			info.text = L["No tag"]
			info.func = function(_,_,_, value)
				filterTags.noTag = value
				self:updateMountsList()
			end
			info.checked = function() return filterTags.noTag end
			btn:ddAddButton(info, level)

			info.text = L["With all tags"]
			info.func = function(_,_,_, value)
				filterTags.withAllTags = value
				self:updateMountsList()
			end
			info.checked = function() return filterTags.withAllTags end
			btn:ddAddButton(info, level)

			btn:ddAddSeparator(level)

			info.notCheckable = true
			info.text = CHECK_ALL
			info.func = function()
				self.tags:setAllFilterTags(true)
				self:updateMountsList()
				btn:ddRefresh(level)
			end
			btn:ddAddButton(info, level)

			info.text = UNCHECK_ALL
			info.func = function()
				self.tags:setAllFilterTags(false)
				self:updateMountsList()
				btn:ddRefresh(level)
			end
			btn:ddAddButton(info, level)

			info.func = nil
			if #self.tags.sortedTags == 0 then
				info.disabled = true
				info.text = EMPTY
				btn:ddAddButton(info, level)
				info.disabled = nil
			else
				info.list = {}
				for i, tag in ipairs(self.tags.sortedTags) do
					info.list[i] = {
						keepShownOnClick = true,
						isNotRadio = true,
						text = function() return self.tags.sortedTags[i] end,
						func = function(btn, _,_, value)
							filterTags.tags[btn._text][2] = value
							self:updateMountsList()
						end,
						checked = function(btn) return filterTags.tags[btn._text][2] end,
						remove = function(btn)
							self.tags:deleteTag(btn._text)
						end,
						order = function(btn, step)
							self.tags:setOrderTag(btn._text, step)
						end,
					}
				end
				btn:ddAddButton(info, level)
				info.list = nil
			end

			btn:ddAddSeparator(level)

			info.keepShownOnClick = nil
			info.notCheckable = true
			info.checked = nil

			info.text = L["Add tag"]
			info.func = function()
				self.tags:addTag()
			end
			btn:ddAddButton(info, level)
		else -- SORTING
			local fSort = mounts.filters.sorting
			info.isNotRadio = nil
			info.notCheckable = nil

			info.text = NAME
			info.func = function()
				fSort.by = "name"
				self:sortMounts()
				btn:ddRefresh(level)
			end
			info.checked = function() return fSort.by == "name" end
			btn:ddAddButton(info, level)

			info.text = TYPE
			info.func = function()
				fSort.by = "type"
				self:sortMounts()
				btn:ddRefresh(level)
			end
			info.checked = function() return fSort.by == "type" end
			btn:ddAddButton(info, level)

			info.text = EXPANSION_FILTER_TEXT
			info.func = function()
				fSort.by = "expansion"
				self:sortMounts()
				btn:ddRefresh(level)
			end
			info.checked = function() return fSort.by == "expansion" end
			btn:ddAddButton(info, level)

			btn:ddAddSeparator(level)

			info.isNotRadio = true
			info.text = L["Reverse Sort"]
			info.func = function(_,_,_, value)
				fSort.reverse = value
				self:sortMounts()
			end
			info.checked = fSort.reverse
			btn:ddAddButton(info, level)

			info.text = L["Favorites First"]
			info.func = function(_,_,_, value)
				fSort.favoritesFirst = value
				self:sortMounts()
			end
			info.checked = fSort.favoritesFirst
			btn:ddAddButton(info, level)
		end
	end
end


function journal:saveDefaultFilters()
	local filters = mounts.filters
	local defFilters = mounts.defFilters

	defFilters.collected = filters.collected
	defFilters.notCollected = filters.notCollected
	defFilters.unusable = filters.unusable
	defFilters.hiddenByPlayer = filters.hiddenByPlayer
	defFilters.onlyHiddenByPlayer = filters.onlyHiddenByPlayer
	defFilters.mountsWeight.sign = filters.mountsWeight.sign
	defFilters.mountsWeight.weight = filters.mountsWeight.weight
	defFilters.tags.noTag = filters.tags.noTag
	defFilters.tags.withAllTags = filters.tags.withAllTags

	for i = 1, #filters.types do
		defFilters.types[i] = filters.types[i]
	end
	for i = 1, #filters.selected do
		defFilters.selected[i] = filters.selected[i]
	end
	for i = 1, #filters.sources do
		defFilters.sources[i] = filters.sources[i]
	end
	for i = 1, #filters.factions do
		defFilters.factions[i] = filters.factions[i]
	end
	for i = 1, #filters.expansions do
		defFilters.expansions[i] = filters.expansions[i]
	end
	for tag, value in pairs(filters.tags.tags) do
		defFilters.tags.tags[tag] = value[2]
	end

	self:setShownCountMounts()
end


function journal:restoreDefaultFilters()
	local defFilters = mounts.defFilters

	defFilters.collected = true
	defFilters.notCollected = true
	defFilters.unusable = true
	defFilters.hiddenByPlayer = false
	defFilters.onlyHiddenByPlayer = false
	defFilters.mountsWeight.sign = nil
	defFilters.mountsWeight.weight = 100
	defFilters.tags.noTag = true
	defFilters.tags.withAllTags = false
	wipe(defFilters.types)
	wipe(defFilters.selected)
	wipe(defFilters.sources)
	wipe(defFilters.factions)
	wipe(defFilters.pet)
	wipe(defFilters.expansions)
	wipe(defFilters.tags.tags)

	self:setShownCountMounts()
end


function journal:isDefaultFilters()
	if #self.searchBox:GetText() ~= 0 then return end
	local filters = mounts.filters
	local defFilters = mounts.defFilters

	if defFilters.collected ~= filters.collected
	or defFilters.notCollected ~= filters.notCollected
	or defFilters.unusable ~= filters.unusable
	or not defFilters.hiddenByPlayer ~= not filters.hiddenByPlayer
	or not defFilters.onlyHiddenByPlayer ~= not filters.onlyHiddenByPlayer
	or defFilters.mountsWeight.sign ~= filters.mountsWeight.sign
	or defFilters.mountsWeight.weight ~= filters.mountsWeight.weight
	or defFilters.tags.noTag ~= filters.tags.noTag
	or defFilters.tags.withAllTags ~= filters.tags.withAllTags
	then return end

	for i = 1, #filters.types do
		if defFilters.types[i] ~= filters.types[i] then return end
	end
	for i = 1, #filters.selected do
		if defFilters.selected[i] ~= filters.selected[i] then return end
	end
	for i = 1, #filters.sources do
		if defFilters.sources[i] ~= filters.sources[i] then return end
	end
	for i = 1, #filters.factions do
		if defFilters.factions[i] ~= filters.factions[i] then return end
	end
	for i = 2, #filters.pet do
		if defFilters.pet[i] ~= filters.pet[i] then return end
	end
	for i = 1, #filters.expansions do
		if defFilters.expansions[i] ~= filters.expansions[i] then return end
	end
	for tag, value in pairs(filters.tags.tags) do
		if defFilters.tags.tags[tag] ~= value[2] then return end
	end

	return true
end


function journal:setAllFilters(typeFilter, enabled)
	local filter = mounts.filters[typeFilter]
	for k in pairs(filter) do
		filter[k] = enabled
	end
end


function journal:clearBtnFilters()
	self:setAllFilters("sources", true)
	self:setAllFilters("types", true)
	self:setAllFilters("selected", true)
	PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
	self:updateBtnFilters()
	self:updateMountsList()
end


function journal:resetToDefaultFilters()
	local filters = mounts.filters
	local defFilters = mounts.defFilters

	filters.collected = defFilters.collected
	filters.notCollected = defFilters.notCollected
	filters.unusable = defFilters.unusable
	filters.hiddenByPlayer = defFilters.hiddenByPlayer
	filters.onlyHiddenByPlayer = defFilters.onlyHiddenByPlayer
	filters.mountsWeight.sign = defFilters.mountsWeight.sign
	filters.mountsWeight.weight = defFilters.mountsWeight.weight
	filters.tags.noTag = defFilters.tags.noTag
	filters.tags.withAllTags = defFilters.tags.withAllTags

	for i = 1, #filters.types do
		filters.types[i] = defFilters.types[i]
	end
	for i = 1, #filters.selected do
		filters.selected[i] = defFilters.selected[i]
	end
	for i = 1, #filters.sources do
		filters.sources[i] = defFilters.sources[i]
	end
	for i = 1, #filters.factions do
		filters.factions[i] = defFilters.factions[i]
	end
	for i = 2, #defFilters.pet do
		filters.pet[i] = defFilters.pet[i]
	end
	for i = 1, #filters.expansions do
		filters.expansions[i] = defFilters.expansions[i]
	end
	for tag, value in pairs(filters.tags.tags) do
		value[2] = defFilters.tags.tags[tag]
	end

	PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
	self.searchBox:SetText("")
	self:updateBtnFilters()
	self:updateMountsList()
end


function journal:setBtnFilters(tab)
	local i = 0
	local children = self.filtersBar[tab].childs
	local filters = mounts.filters[tab]

	for _, btn in ipairs(children) do
		local checked = btn:GetChecked()
		filters[btn.id] = checked
		if not checked then i = i + 1 end
	end

	if i == #children then
		self:setAllFilters(tab, true)
	end

	PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
	self:updateBtnFilters()
	self:updateMountsList()
end


function journal:updateBtnFilters()
	local filtersBar, clearShow = self.filtersBar, false

	for typeFilter, filter in pairs(mounts.filters) do
		-- SOURCES
		if typeFilter == "sources" then
			local i, n = 0, 0
			for k, v in pairs(filter) do
				if k ~= 0 then
					i = i + 1
					if v == true then n = n + 1 end
				end
			end

			if i == n then
				filter[0] = true
				for _, btn in ipairs(filtersBar.sources.childs) do
					btn:SetChecked(false)
					btn.icon:SetDesaturated()
				end
				filtersBar.sources:GetParent().filtred:Hide()
			else
				clearShow = true
				filter[0] = false
				for _, btn in ipairs(filtersBar.sources.childs) do
					local checked = filter[btn.id]
					btn:SetChecked(checked)
					btn.icon:SetDesaturated(not checked)
				end
				filtersBar.sources:GetParent().filtred:Show()
			end

		-- TYPES AND SELECTED
		elseif filtersBar[typeFilter] then
			local i = 0
			for _, v in ipairs(filter) do
				if v then i = i + 1 end
			end

			if i == #filter then
				for _, btn in ipairs(filtersBar[typeFilter].childs) do
					btn:SetChecked(false)
					if btn.id > 3 then
						btn.icon:SetDesaturated()
					else
						btn.icon:SetVertexColor(self.colors["mount"..btn.id]:GetRGB())
					end
				end
				filtersBar[typeFilter]:GetParent().filtred:Hide()
			else
				clearShow = true
				for _, btn in ipairs(filtersBar[typeFilter].childs) do
					local checked = filter[btn.id]
					btn:SetChecked(checked)
					if btn.id > 3 then
						btn.icon:SetDesaturated(not checked)
					else
						local color = checked and self.colors["mount"..btn.id] or self.colors.dark
						btn.icon:SetVertexColor(color:GetRGB())
					end
				end
				filtersBar[typeFilter]:GetParent().filtred:Show()
			end
		end
	end

	-- CLEAR BTN FILTERS
	filtersBar.clear:SetShown(clearShow)
end


function journal:isMountHidden(spellID)
	return mounts.globalDB.hiddenMounts and mounts.globalDB.hiddenMounts[spellID]
end


function journal:getFilterWeight(spellID)
	local filter = mounts.filters.mountsWeight
	if not filter.sign then
		return true
	else
		local mountWeight = self.mountsWeight[spellID] or 100
		if filter.sign == ">" then
			return mountWeight > filter.weight
		elseif filter.sign == "<" then
			return mountWeight < filter.weight
		else
			return mountWeight == filter.weight
		end
	end
end


function journal:setShownCountMounts()
	self.shownPanel.count:SetText(#self.displayedMounts)
	if self:isDefaultFilters() then
		self.shownPanel:Hide()
		self.leftInset:SetPoint("TOPLEFT", self.filtersPanel, "BOTTOMLEFT", 0, -2)
	else
		self.shownPanel:Show()
		self.leftInset:SetPoint("TOPLEFT", self.shownPanel, "BOTTOMLEFT", 0, -2)
	end
	self.leftInset:GetHeight()
end


function journal:updateMountsList()
	local filters, list, indexBySpellID, mountsDB, tags, GetSpellInfo, unpack = mounts.filters, self.list, mounts.indexBySpellID, mounts.mountsDB, self.tags, GetSpellInfo, unpack
	local sources, selected, factions, pet, types, expansions = filters.sources, filters.selected, filters.factions, filters.pet, filters.types, filters.expansions
	local canUseFlying = mounts:isCanUseFlying()
	local text = util.cleanText(self.searchBox:GetText())
	wipe(self.displayedMounts)

	for i = 1, #mountsDB do
		local spellID, _, mountType, sourceType, mountFaction, expansion = unpack(mountsDB[i])
		local name = GetSpellInfo(spellID)
		local isCollected = indexBySpellID[spellID]
		local isMountHidden = self:isMountHidden(spellID)
		local petID = self.petForMount[spellID]

		-- HIDDEN BY PLAYER
		if (not isMountHidden or filters.hiddenByPlayer)
		and (not (filters.hiddenByPlayer and filters.onlyHiddenByPlayer) or isMountHidden)
		-- COLLECTED
		and (isCollected and filters.collected or not isCollected and filters.notCollected)
		-- UNUSABLE
		and (filters.unusable or not isCollected or mounts:isUsable(spellID, canUseFlying))
		-- EXPANSIONS
		and expansions[expansion]
		-- SOURCES
		and sources[sourceType]
		-- SEARCH
		and (#text == 0
			or name:lower():find(text, 1, true)
			or tags:find(spellID, text))
		-- TYPE
		and types[mountType]
		-- FACTION
		and factions[mountFaction]
		-- SELECTED
		and (list and (selected[1] and list.fly[spellID]
		            or selected[2] and list.ground[spellID]
		            or selected[3] and list.swimming[spellID])
		  or selected[4] and not (list and (list.fly[spellID]
		                                 or list.ground[spellID]
		                                 or list.swimming[spellID])))
		-- PET
		and pet[petID ~= nil and (type(petID) == "number" and 3 or petID and 2 or 1) or 4]
		-- MOUNTS WEIGHT
		and self:getFilterWeight(spellID)
		-- TAGS
		and tags:getFilterMount(spellID) then
			self.displayedMounts[#self.displayedMounts + 1] = spellID
		end
	end

	self:setShownCountMounts()
	self.scrollFrame:update()
end


function journal:showToggle()
	if self.init then
		self:init()
	else
		self.bgFrame:SetShown(not self.bgFrame:IsShown())
	end
end


SLASH_MOUNTSJOURNALFRAME1 = "/mountsjournal"
SLASH_MOUNTSJOURNALFRAME2 = "/mj"
SlashCmdList["MOUNTSJOURNALFRAME"] = function() journal:showToggle() end