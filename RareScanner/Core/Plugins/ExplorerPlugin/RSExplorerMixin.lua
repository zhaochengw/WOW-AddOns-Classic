-----------------------------------------------------------------------
-- AddOn namespace.
-----------------------------------------------------------------------
local LibStub = _G.LibStub
local ADDON_NAME, private = ...

-- Locales
local AL = LibStub("AceLocale-3.0"):GetLocale("RareScanner");

-- RareScanner database libraries
local RSNpcDB = private.ImportLib("RareScannerNpcDB")
local RSContainerDB = private.ImportLib("RareScannerContainerDB")
local RSCollectionsDB = private.ImportLib("RareScannerCollectionsDB")
local RSGeneralDB = private.ImportLib("RareScannerGeneralDB")
local RSMapDB = private.ImportLib("RareScannerMapDB")
local RSConfigDB = private.ImportLib("RareScannerConfigDB")
local RSAchievementDB = private.ImportLib("RareScannerAchievementDB")

-- RareScanner general libraries
local RSConstants = private.ImportLib("RareScannerConstants")
local RSLogger = private.ImportLib("RareScannerLogger")
local RSUtils = private.ImportLib("RareScannerUtils")

-- RareScanner service libraries
local RSMap = private.ImportLib("RareScannerMap")
local RSNpcPOI = private.ImportLib("RareScannerNpcPOI")
local RSContainerPOI = private.ImportLib("RareScannerContainerPOI")
local RSLootTooltip = private.ImportLib("RareScannerLootTooltip")

-- Thirdparty
local LibDialog = LibStub("LibDialog-1.0RS")

-----------------------------------------------------
-- Filters panel
-----------------------------------------------------

RSExplorerFilters = { };

local filters = { }

local currentContinentDropDownValues = { }

local function MapByName_Sort(mapIDs)
	local comparison = function(mapID1, mapID2)
		local mapName1 = RSMapDB.GetMapName(mapID1) or ""
		local mapName2 = RSMapDB.GetMapName(mapID2) or ""

		-- Otherwise order by name
		local strCmpResult = strcmputf8i(mapName1, mapName2);
		if (strCmpResult ~= 0) then
			return strCmpResult < 0;
		end
	end
				
	table.sort(mapIDs, comparison)
end

local function AddContinentDropDownValue(entityID, entityInfo, continentDropDownValuesNotSorted, source)
	if ((source == RSConstants.ITEM_SOURCE.NPC and RSNpcDB.IsInternalNpcMultiZone(entityID)) or (source == RSConstants.ITEM_SOURCE.CONTAINER and RSContainerDB.IsInternalContainerMultiZone(entityID))) then
		for mapID, _ in pairs (entityInfo.zoneID) do
			local continentID = RSMapDB.GetContinentOfMap(mapID)
			if (continentID) then
				if (not continentDropDownValuesNotSorted[continentID]) then
					continentDropDownValuesNotSorted[continentID] = {}
				end
				if (not RSUtils.Contains(continentDropDownValuesNotSorted[continentID], mapID)) then
					table.insert(continentDropDownValuesNotSorted[continentID], mapID)
				end
			end
		end
	else
		local continentID = RSMapDB.GetContinentOfMap(entityInfo.zoneID)
		if (continentID) then
			if (not continentDropDownValuesNotSorted[continentID]) then
				continentDropDownValuesNotSorted[continentID] = {}
			end
			if (not RSUtils.Contains(continentDropDownValuesNotSorted[continentID], entityInfo.zoneID)) then
				table.insert(continentDropDownValuesNotSorted[continentID], entityInfo.zoneID)
			end
		end
	end
end

local function AddEntityContinentDropDownValue(entityID, entityInfo, continentDropDownValuesNotSorted, source, classIndex)
	local collectionsLoot = RSCollectionsDB.GetAllEntitiesCollectionsLoot()[source]

	local alreadyAdded = false
	if (not alreadyAdded and filters[RSConstants.EXPLORER_FILTER_DROP_MOUNTS] and collectionsLoot and collectionsLoot[entityID] and RSUtils.GetTableLength(collectionsLoot[entityID][RSConstants.ITEM_TYPE.MOUNT]) > 0) then
		AddContinentDropDownValue(entityID, entityInfo, continentDropDownValuesNotSorted, source)
		alreadyAdded = true
	end
	
	if (not alreadyAdded and filters[RSConstants.EXPLORER_FILTER_DROP_PETS] and collectionsLoot and collectionsLoot[entityID] and RSUtils.GetTableLength(collectionsLoot[entityID][RSConstants.ITEM_TYPE.PET]) > 0) then
		AddContinentDropDownValue(entityID, entityInfo, continentDropDownValuesNotSorted, source)
		alreadyAdded = true
	end
	
	if (not alreadyAdded and filters[RSConstants.EXPLORER_FILTER_DROP_TOYS] and collectionsLoot and collectionsLoot[entityID] and RSUtils.GetTableLength(collectionsLoot[entityID][RSConstants.ITEM_TYPE.TOY]) > 0) then
		AddContinentDropDownValue(entityID, entityInfo, continentDropDownValuesNotSorted, source)
		alreadyAdded = true
	end
	
	if (not alreadyAdded and filters[RSConstants.EXPLORER_FILTER_DROP_APPEARANCES] and collectionsLoot and collectionsLoot[entityID] and collectionsLoot[entityID][RSConstants.ITEM_TYPE.APPEARANCE] and RSUtils.GetTableLength(collectionsLoot[entityID][RSConstants.ITEM_TYPE.APPEARANCE][classIndex]) > 0) then
		AddContinentDropDownValue(entityID, entityInfo, continentDropDownValuesNotSorted, source)
		alreadyAdded = true
	end
	
	if (not alreadyAdded and filters[RSConstants.EXPLORER_FILTER_ACHIEVEMENT_CRITERIA] and entityInfo.achievementID) then
		local isContainer = source == RSConstants.ITEM_SOURCE.CONTAINER and true or false
	
		if (RSAchievementDB.IsNotCompletedAchievementCriteria(entityID, entityInfo.achievementID, entityInfo.questID, entityInfo.criteria, isContainer)) then
			AddContinentDropDownValue(entityID, entityInfo, continentDropDownValuesNotSorted, source)
			alreadyAdded = true
		end
	end
	
	if (not alreadyAdded) then
		if (filters[RSConstants.EXPLORER_FILTER_WITHOUT_COLLECTIBLES] and (not collectionsLoot or not collectionsLoot[entityID])) then
			AddContinentDropDownValue(entityID, entityInfo, continentDropDownValuesNotSorted, source)
			alreadyAdded = true
		else
			for groupKey, _ in pairs(RSCollectionsDB.GetItemGroups()) do	
				if (filters[string.format(RSConstants.EXPLORER_FILTER_DROP_CUSTOM, groupKey)] and collectionsLoot and collectionsLoot[entityID] and RSUtils.GetTableLength(collectionsLoot[entityID][string.format(RSConstants.ITEM_TYPE.CUSTOM, groupKey)]) > 0) then
					AddContinentDropDownValue(entityID, entityInfo, continentDropDownValuesNotSorted, source)
					alreadyAdded = true
				end
			end
		end
	end
end

local function PopulateContinentDropDown(mainFrame, continentDropDown)	
	currentContinentDropDownValues = { }
	local continentDropDownValuesNotSorted = { }
	local _, _, classIndex = UnitClass("player");
	
	if (RSUtils.GetTableLength(filters) > 0) then
		for npcID, npcInfo in pairs (RSNpcDB.GetAllInternalNpcInfo()) do
			local filtered = false
			
			-- Ignore if part of a disabled event
			if (RSNpcDB.IsDisabledEvent(npcID)) then
				filtered = true
			end
			
			-- Ignore if dead
			if (not filters[RSConstants.EXPLORER_FILTER_DEAD] and RSNpcDB.IsNpcKilled(npcID)) then
				filtered = true
			end
			
			-- Ignore if filtered
			if (not filtered and not filters[RSConstants.EXPLORER_FILTER_FILTERED] and RSConfigDB.GetNpcFiltered(npcID) ~= nil) then
				filtered = true
			end
			
			-- Add if matches collections
			if (not filtered) then
				AddEntityContinentDropDownValue(npcID, npcInfo, continentDropDownValuesNotSorted, RSConstants.ITEM_SOURCE.NPC, classIndex)
			end
		end
		
		for containerID, containerInfo in pairs (RSContainerDB.GetAllInternalContainerInfo()) do
			local filtered = false
			
			-- Ignore if part of a disabled event
			if (RSContainerDB.IsDisabledEvent(containerID)) then
				filtered = true
			end
			
			-- Ignore if dead
			if (not filters[RSConstants.EXPLORER_FILTER_DEAD] and RSContainerDB.IsContainerOpened(containerID)) then
				filtered = true
			end
			
			-- Ignore if filtered
			if (not filtered and not filters[RSConstants.EXPLORER_FILTER_FILTERED] and RSConfigDB.GetContainerFiltered(containerID) ~= nil) then
				filtered = true
			end
			
			-- Add if matches collections
			if (not filtered) then
				AddEntityContinentDropDownValue(containerID, containerInfo, continentDropDownValuesNotSorted, RSConstants.ITEM_SOURCE.CONTAINER, classIndex)
			end
		end
    end
    
    -- Sort continents by name
    local continentsSorted = { }
   	for continentID, _ in pairs(continentDropDownValuesNotSorted) do
   		table.insert(continentsSorted, continentID)
   	end
	MapByName_Sort(continentsSorted)

	-- Sort maps by name
	for continentID, mapIDs in pairs (continentDropDownValuesNotSorted) do
		local mapIDs = continentDropDownValuesNotSorted[continentID]
		MapByName_Sort(mapIDs)
		currentContinentDropDownValues[continentID] = mapIDs
	end
	
	-- If player is locking current map check if available and selects it
	if (RSConfigDB.IsLockingCurrentMap()) then
		-- Gets players map ID
		local currentPlayerMapID = C_Map.GetBestMapForUnit("player");
		if (currentPlayerMapID) then
			-- Gets players continent map ID
			local currentPlayerContinentID = RSMapDB.GetContinentOfMap(currentPlayerMapID)
			if (currentPlayerContinentID and RSUtils.Contains(continentsSorted, currentPlayerContinentID) and RSUtils.Contains(currentContinentDropDownValues[currentPlayerContinentID], currentPlayerMapID)) then
				RSConfigDB.SetExplorerContinentMapID(currentPlayerContinentID)
				RSConfigDB.SetExplorerMapID(currentPlayerMapID)
			end
		end
	end
	
	-- Tries to select the previous continent/map
	local previousContinentID = RSConfigDB.GetExplorerContinenMapID()
	local previousMapID = RSConfigDB.GetExplorerMapID()

	if (previousContinentID and previousMapID and RSUtils.Contains(continentsSorted, previousContinentID) and RSUtils.Contains(currentContinentDropDownValues[previousContinentID], previousMapID)) then
		continentDropDown:GenerateMenu()
		mainFrame:ShowContentPanels()
		mainFrame.ScanRequired:Hide()
		mainFrame.CustomLoot:Hide()
	-- Otherwise select the first map available
	elseif (RSUtils.GetTableLength(continentsSorted) > 0) then
   		for _, continentID in ipairs(continentsSorted) do
   			RSConfigDB.SetExplorerContinentMapID(continentID)
   			local mapID = currentContinentDropDownValues[continentID][1]
   			RSConfigDB.SetExplorerMapID(mapID)
			continentDropDown:GenerateMenu()
			break
	   	end
	   	
		mainFrame:ShowContentPanels()
		mainFrame.ScanRequired:Hide()
		mainFrame.CustomLoot:Hide()
	else
		continentDropDown:GenerateMenu()
		mainFrame:HideContentPanels()
		mainFrame.ScanRequired.ScanRequiredText:SetText(AL["EXPLORER_NO_RESULTS"])
		mainFrame.ScanRequired.StartScanningButton:Hide()
		mainFrame.ScanRequired:Show()
		mainFrame.Filters:Show()
   	end
end

local function FilterDropDownMenu_SetupMenu(dropDown, rootDescription)	
	-- Collections menu
	local collectionsSubmenu = rootDescription:CreateButton(AL["EXPLORER_FILTER_COLLECTIONS"]);
	local mountsFilter = collectionsSubmenu:CreateRadio(AL["EXPLORER_FILTER_MOUNTS"], 
		function(filterKey) return filters[filterKey] end, 
		function(filterKey) 
			-- Overriden by SetResponder
		end,
		RSConstants.EXPLORER_FILTER_DROP_MOUNTS)
	mountsFilter:SetResponder(function(filterKey)
		if (filters[filterKey]) then
			RSConfigDB.SetSearchingMounts(false)
			filters[filterKey] = nil
		else
			RSConfigDB.SetSearchingMounts(true)
			filters[filterKey] = true
		end
			
		return MenuResponse.Refresh;
	end)
	
	local petsFilter = collectionsSubmenu:CreateRadio(AL["EXPLORER_FILTER_PETS"], 
		function(filterKey) return filters[filterKey] end, 
		function(filterKey)
			-- Overriden by SetResponder
		end,
		RSConstants.EXPLORER_FILTER_DROP_PETS)
	petsFilter:SetResponder(function(filterKey)
		if (filters[filterKey]) then
			RSConfigDB.SetSearchingPets(false)
			filters[filterKey] = nil
		else
			RSConfigDB.SetSearchingPets(true)
			filters[filterKey] = true
		end
			
		return MenuResponse.Refresh;
	end)
	
	local toysFilter = collectionsSubmenu:CreateRadio(AL["EXPLORER_FILTER_TOYS"], 
		function(filterKey) return filters[filterKey] end, 
		function(filterKey)
			-- Overriden by SetResponder
		end,
		RSConstants.EXPLORER_FILTER_DROP_TOYS)
	toysFilter:SetResponder(function(filterKey)
		if (filters[filterKey]) then
			RSConfigDB.SetSearchingToys(false)
			filters[filterKey] = nil
		else
			RSConfigDB.SetSearchingToys(true)
			filters[filterKey] = true
		end
			
		return MenuResponse.Refresh;
	end)
	
	local appearancesFilter = collectionsSubmenu:CreateRadio(AL["EXPLORER_FILTER_APPEARANCES"], 
		function(filterKey) return filters[filterKey] end, 
		function(filterKey)
			-- Overriden by SetResponder
		end,
		RSConstants.EXPLORER_FILTER_DROP_APPEARANCES)
	appearancesFilter:SetResponder(function(filterKey)
		if (filters[filterKey]) then
			RSConfigDB.SetSearchingAppearances(false)
			filters[filterKey] = nil
		else
			RSConfigDB.SetSearchingAppearances(true)
			filters[filterKey] = true
		end
		
		return MenuResponse.Refresh;
	end)
	
	local itemGroups = RSCollectionsDB.GetItemGroups()
	if (itemGroups) then
		for groupKey, groupName in pairs (itemGroups) do
			if (RSCollectionsDB.HasGroupItems(groupKey)) then
				local customFilter = collectionsSubmenu:CreateRadio(string.format(AL["EXPLORER_FILTER_CUSTOM"], groupName), 
					function(filterKey) return filters[filterKey] end, 
					function(filterKey)
						-- Overriden by SetResponder
					end,
					string.format(RSConstants.EXPLORER_FILTER_DROP_CUSTOM, groupKey))
				customFilter:SetResponder(function(filterKey)
					if (filters[filterKey]) then
						RSConfigDB.SetSearchingCustom(groupKey, false)
						filters[filterKey] = nil
					else
						RSConfigDB.SetSearchingCustom(groupKey, true)
						filters[filterKey] = true
					end
					
					return MenuResponse.Refresh;
				end)
			end
		end
	end

	local missingAchievementFilter = collectionsSubmenu:CreateRadio(AL["EXPLORER_FILTER_ACHIEVEMENT"], 
		function(filterKey) return filters[filterKey] end, 
		function(filterKey)
			-- Overriden by SetResponder
		end,
		RSConstants.EXPLORER_FILTER_ACHIEVEMENT_CRITERIA)
	missingAchievementFilter:SetResponder(function(filterKey)
		if (filters[filterKey]) then
			RSConfigDB.SetSearchingMissingAchievementCriteria(false)
			filters[filterKey] = nil
		else
			RSConfigDB.SetSearchingMissingAchievementCriteria(true)
			filters[filterKey] = true
		end
		
		return MenuResponse.Refresh;
	end)

	-- State menu
	local stateSubmenu = rootDescription:CreateButton(AL["EXPLORER_FILTER_STATE"]);
	local deadFilter = stateSubmenu:CreateRadio(AL["EXPLORER_FILTER_DEAD"], 
		function(filterKey) return filters[filterKey] end, 
		function(filterKey) 
			-- Overriden by SetResponder
		end,
		RSConstants.EXPLORER_FILTER_DEAD)
	deadFilter:SetResponder(function(filterKey)
		if (filters[filterKey]) then
			RSConfigDB.SetShowDead(false)
			filters[filterKey] = nil
		else
			RSConfigDB.SetShowDead(true)
			filters[filterKey] = true
		end
			
		return MenuResponse.Refresh;
	end)
	
	local filteredFilter = stateSubmenu:CreateRadio(AL["EXPLORER_FILTER_FILTERED"], 
		function(filterKey) return filters[filterKey] end, 
		function(filterKey) 
			-- Overriden by SetResponder
		end,
		RSConstants.EXPLORER_FILTER_FILTERED)
	filteredFilter:SetResponder(function(filterKey)
		if (filters[filterKey]) then
			RSConfigDB.SetShowFiltered(false)
			filters[filterKey] = nil
		else
			RSConfigDB.SetShowFiltered(true)
			filters[filterKey] = true
		end
			
		return MenuResponse.Refresh;
	end)
	
	local noCollectiblesFilter = stateSubmenu:CreateRadio(AL["EXPLORER_FILTER_WITHOUT_COLLECTIBLES"], 
		function(filterKey) return filters[filterKey] end, 
		function(filterKey) 
			-- Overriden by SetResponder
		end,
		RSConstants.EXPLORER_FILTER_WITHOUT_COLLECTIBLES)
	noCollectiblesFilter:SetResponder(function(filterKey)
		if (filters[filterKey]) then
			RSConfigDB.SetShowWithoutCollectibles(false)
			filters[filterKey] = nil
		else
			RSConfigDB.SetShowWithoutCollectibles(true)
			filters[filterKey] = true
		end
			
		return MenuResponse.Refresh;
	end)
end

local function ContinentDropDownMenu_SetupMenu(dropDown, rootDescription)
	local collectionsLoot = RSCollectionsDB.GetAllEntitiesCollectionsLoot()[RSConstants.ITEM_SOURCE.NPC]
	
	local continentsSorted = { }
   	for continentID, _ in pairs(currentContinentDropDownValues) do
   		table.insert(continentsSorted, continentID)
   	end
	MapByName_Sort(continentsSorted)
	
	-- Continents submenu
	for _, continentID in ipairs(continentsSorted) do
		local continentName = RSMapDB.GetMapName(continentID)
		if (continentName) then
			local continentSubmenu = rootDescription:CreateRadio(continentName, 
				function(continentID) return continentID == RSConfigDB.GetExplorerContinenMapID() end, 
				function(continentID) end,
				continentID)
				
			-- Maps submenu
			for mapContinentID, mapIDs in pairs(currentContinentDropDownValues) do
				if (continentID == mapContinentID) then
					for _, mapID in ipairs (mapIDs) do
						local mapName = RSMapDB.GetMapName(mapID)
						
						continentSubmenu:CreateRadio(mapName, 
							function(mapID) return mapID == RSConfigDB.GetExplorerMapID() end, 
							function(mapID) 
								RSConfigDB.SetExplorerContinentMapID(continentID)
			  					RSConfigDB.SetExplorerMapID(mapID)
			  					
			  					-- Refresh list
			  					dropDown:GetParent().mainFrame.RareNPCList:RefreshDataProvider()
							end,
							mapID)
			  		end
				end
			end
  		end
	end
end

function RSExplorerFilters:Initialize(mainFrame)
	if (mainFrame.initialized) then
		mainFrame:Refresh()
	else
		self.mainFrame = mainFrame
		
		self.FilterDropDown:SetText(AL["EXPLORER_FILTERS"]);
		self.FilterDropDown:SetupMenu(FilterDropDownMenu_SetupMenu)
		self.FilterDropDown:SetUpdateCallback(function() mainFrame:Refresh() end)
		
		self.ContinentDropDown:SetDefaultText(AL["EXPLORER_NO_RESULTS"])
		PopulateContinentDropDown(self.mainFrame, self.ContinentDropDown)
		self.ContinentDropDown:SetupMenu(ContinentDropDownMenu_SetupMenu)
		
		self.LockCurrentZoneCheckButton.Text:SetText(AL["EXPLORER_LOCK_CURRENT_ZONE"])
		self.LockCurrentZoneCheckButton.tooltip = AL["EXPLORER_LOCK_CURRENT_ZONE_DESC"]
		self.LockCurrentZoneCheckButton:SetChecked(RSConfigDB.IsLockingCurrentMap())
		self.LockCurrentZoneCheckButton.func = function(self, checked)
			RSConfigDB.SetLockingCurrentMap(checked)
		end
		
		self.RestartScanningButton:SetText(AL["EXPLORER_RESCANN"])
		self.RestartScanningButton.tooltip = AL["EXPLORER_RESCANN_DESC"]
	end
end

function RSExplorerFilters:RestartScanning(self, button)
	local mainFrame = self:GetParent().mainFrame
	mainFrame.ScanRequired.ScanRequiredText:SetText(AL["EXPLORER_SCAN_MANUAL"])
	mainFrame.ScanRequired.StartScanningButton:SetText(AL["EXPLORER_START_SCAN"])
	mainFrame.ScanRequired.StartScanningButton:Show()
	mainFrame.ScanRequired:Show()
	mainFrame:ShowCustomLootPanels()
	mainFrame:HideContentPanels()
end

-----------------------------------------------------
-- Rare list panel
-----------------------------------------------------

RSExplorerRareList = { };

local RARE_TEXTURE_OFFSET = -24;

local function RSExplorerRareList_Sort(e1, e2)
	-- Order by missing collectibles
	if (e1.hasMissingMount ~= e2.hasMissingMount) then
		if (e1.hasMissingMount) then return true end
		if (e2.hasMissingMount) then return false end
	end
			
	if (e1.hasMissingPet ~= e2.hasMissingPet) then
		if (e1.hasMissingPet) then return true end
		if (e2.hasMissingPet) then return false end
	end
			
	if (e1.hasMissingToy ~= e2.hasMissingToy) then
		if (e1.hasMissingToy) then return true end
		if (e2.hasMissingToy) then return false end
	end
			
	if (e1.hasMissingAppearance ~= e2.hasMissingAppearance) then
		if (e1.hasMissingAppearance) then return true end
		if (e2.hasMissingAppearance) then return false end
	end
			
	if (e1.hasMissingCustom ~= e2.hasMissingCustom) then
		if (e1.hasMissingCustom) then return true end
		if (e2.hasMissingCustom) then return false end
	end
			
	if (e1.dead ~= e2.dead) then
		if (e1.dead) then return false end
		if (e2.dead) then return true end
	end
			
	if (e1.filtered ~= e2.filtered) then
		if (e1.filtered) then return false end
		if (e2.filtered) then return true end
	end
	
	-- Otherwise order by name
	local strCmpResult = strcmputf8i(e1.name, e2.name);
	if (strCmpResult ~= 0) then
		return strCmpResult < 0;
	end
end

function RSExplorerRareList:Initialize(mainFrame)
	if (mainFrame.initialized) then
		return
	end
	
	self.mainFrame = mainFrame
	self.scrollView = CreateScrollBoxListLinearView();
    self.scrollView:SetElementInitializer("RSExplorerListButtonTemplate", GenerateClosure(self.OnElementInitialize, self));
	ScrollUtil.InitScrollBoxListWithScrollBar(self.scrollBox, self.scrollBar, self.scrollView);
	
	self.selectionBehavior = ScrollUtil.AddSelectionBehavior(self.scrollBox);
    self.selectionBehavior:RegisterCallback("OnSelectionChanged", self.OnElementSelectionChanged, self);
	
	self.dataProvider = CreateDataProvider()
	self.dataProvider:SetSortComparator(RSExplorerRareList_Sort)
	self.scrollBox:SetDataProvider(self.dataProvider);
	
	local _, _, classIndex = UnitClass("player");
	self.classIndex = classIndex
	
	self:RefreshDataProvider();
end

local function ToggleButtonTexture(activeTextures, texture, hasMissingType)
	if (hasMissingType) then
		texture:ClearAllPoints();
		texture:SetPoint("TOPRIGHT", -2 + (activeTextures * RARE_TEXTURE_OFFSET), -2)
		texture:Show()
		return activeTextures + 1
	else
		texture:Hide()
		return activeTextures
	end
end

local function ToggleEntityState(element, elementData)
	if (elementData.dead) then
		element.Name:SetTextColor(0, 1, 1, 1)
	elseif (elementData.filtered) then
		element.Name:SetTextColor(0.83, 0.83, 0.83, 1)
	else
		element.Name:SetTextColor(1, 0.85, 0, 1)
	end
	
	if (elementData.filtered) then
		if (elementData.isNpc) then
			element.PortraitFrame.Portrait:SetDesaturated(1)
		else
			element.PortraitFrame.Treasure:SetDesaturated(1)
		end
		element.MountTexture:SetDesaturated(1)
		element.PetTexture:SetDesaturated(1)
		element.ToyTexture:SetDesaturated(1)
		element.AppearanceTexture:SetDesaturated(1)
		element.CustomTexture:SetDesaturated(1)
	else
		if (elementData.isNpc) then
			element.PortraitFrame.Portrait:SetDesaturated(nil)
		else
			element.PortraitFrame.Treasure:SetDesaturated(nil)
		end
		element.MountTexture:SetDesaturated(nil)
		element.PetTexture:SetDesaturated(nil)
		element.ToyTexture:SetDesaturated(nil)
		element.AppearanceTexture:SetDesaturated(nil)
		element.CustomTexture:SetDesaturated(nil)
	end
end

function RSExplorerRareList:OnElementInitialize(element, elementData)
	local activeTextures = 0
	activeTextures = ToggleButtonTexture(activeTextures, element.MountTexture, elementData.hasMissingMount)
	activeTextures = ToggleButtonTexture(activeTextures, element.PetTexture, elementData.hasMissingPet)
	activeTextures = ToggleButtonTexture(activeTextures, element.ToyTexture, elementData.hasMissingToy)
	activeTextures = ToggleButtonTexture(activeTextures, element.AppearanceTexture, elementData.hasMissingAppearance)
	activeTextures = ToggleButtonTexture(activeTextures, element.CustomTexture, elementData.hasMissingCustom)
	
	if (self.selectionBehavior:IsSelected(element)) then
		element.Selected:Show()
	else
		element.Selected:Hide()
	end
	
	element.Name:SetText(elementData.name)
	
	if (elementData.isContainer) then
		element.PortraitFrame.Treasure:Show()
		element.PortraitFrame.Portrait:Hide()
		element.PortraitFrame.RareOverlay:Hide()
		element.PortraitFrame.CustomOverlay:Hide()
	else
		element.PortraitFrame.Portrait:Show()
		element.PortraitFrame.Treasure:Hide()
		
		local retOk, _ = pcall(SetPortraitTextureFromCreatureDisplayID, element.PortraitFrame.Portrait, elementData.displayID)
		if (not retOk) then
			RSLogger:PrintDebugMessage(string.format("RSExplorerRareList:UpdateData: [npcID=%s][displayID=%s] Error al cargar el portaretrato.", elementData.entityID, elementData.displayID or "nil"))
		end
	
		if (elementData.custom) then
			element.PortraitFrame.RareOverlay:Hide()
			element.PortraitFrame.CustomOverlay:Show()
		else
			element.PortraitFrame.RareOverlay:Show()
			element.PortraitFrame.CustomOverlay:Hide()
		end
	end
	
	ToggleEntityState(element, elementData)
	
	element:RegisterForClicks("LeftButtonUp", "RightButtonDown");
	element:SetScript("OnClick", function(element, button) self:OnElementClick(element, elementData, button) end);
	element:SetScript("OnEnter", function(element) self:OnElementEnter(element, elementData) end);
	element:SetScript("OnLeave", function(element) self:OnElementLeave(element, elementData) end);
end

function RSExplorerRareList:OnElementClick(element, elementData, button)
	local mainFrame = self:GetParent()
	if (button == "LeftButton") then
		self.selectionBehavior:ClearSelections()
		self.selectionBehavior:Select(element);
	elseif (button == "RightButton") then
		if (elementData.isNpc) then
			if (RSConfigDB.GetNpcFiltered(elementData.entityID) ~= nil) then
				RSLogger:PrintMessage(AL["ENABLED_SEARCHING_ENTITIE"]..elementData.name)
				RSConfigDB.DeleteNpcFiltered(elementData.entityID)
				elementData.filtered = false
			else
				RSLogger:PrintMessage(AL["DISABLED_SEARCHING_ENTITIE"]..elementData.name)
				RSConfigDB.SetNpcFiltered(elementData.entityID)
				elementData.filtered = true
			end
		else
			if (RSConfigDB.GetContainerFiltered(elementData.entityID) ~= nil) then
				RSLogger:PrintMessage(AL["ENABLED_SEARCHING_ENTITIE"]..elementData.name)
				RSConfigDB.DeleteContainerFiltered(elementData.entityID)
				elementData.filtered = false
			else
				RSLogger:PrintMessage(AL["DISABLED_SEARCHING_ENTITIE"]..elementData.name)
				RSConfigDB.SetContainerFiltered(elementData.entityID)
				elementData.filtered = true
			end
		end
		
		ToggleEntityState(element, elementData)
	end
end

function RSExplorerRareList:OnElementEnter(element, elementData)
	local mainFrame = self:GetParent()
	local tooltip = mainFrame.Tooltip
	tooltip:SetOwner(element, "ANCHOR_LEFT")
	tooltip:SetText(elementData.name)
	tooltip:AddLine(AL["EXPLORER_BUTTON_TOOLTIP1"], 1, 1, 1)
	if (RSConfigDB.GetNpcFiltered(elementData.entityID) ~= nil) then
		tooltip:AddLine(AL["EXPLORER_BUTTON_TOOLTIP2"], 1, 1, 1)
	else
		tooltip:AddLine(AL["EXPLORER_BUTTON_TOOLTIP3"], 1, 1, 1)
	end
	tooltip:Show()
end

function RSExplorerRareList:OnElementLeave(element, elementData)
	local mainFrame = self:GetParent()
	local tooltip = mainFrame.Tooltip
	tooltip:Hide()
end

local function RSExplorerLoadMap(mapID, mapFrame)
	-- Avoid refreshing if the map didn't change
	if (mapFrame.mapID and mapFrame.mapID == mapID) then
		return
	end
	
	mapFrame.mapID = mapID
	
	-- Initialize variables
	if (not mapFrame.detailLayerPool) then
		mapFrame.detailLayerPool = CreateFramePool("FRAME", mapFrame, "RSMapCanvasDetailLayerTemplate");
		mapFrame.iconsPool = CreateFramePool("FRAME", mapFrame, "RSMapCanvasDetailIconsTemplate");
		mapFrame.overlayIconsPool = CreateFramePool("FRAME", mapFrame, "RSMapCanvasDetailIconsTemplate");
	end
	
	-- Load map frame
	mapFrame.detailLayerPool:ReleaseAll();
	
	local layers = C_Map.GetMapArtLayers(mapID);	
	for layerIndex, layerInfo in ipairs(layers) do
		local detailLayer = mapFrame.detailLayerPool:Acquire();
		detailLayer:SetAllPoints(mapFrame);
		detailLayer:SetMapAndLayer(mapID, layerIndex, mapFrame);
		detailLayer:Show();
	end
end

local function AddIcon(icon, texture, x, y, r, g, b)
	if (not x or not y) then
		return
	end
	
	icon.Texture:SetTexture(texture)
	if (r and g and b) then
		icon.Texture:SetVertexColor(r, g, b, 0.4)
		icon.Texture:SetDrawLayer("ARTWORK");
	else
		icon.Texture:SetDrawLayer("OVERLAY");
	end
	
	local xOffset = 0
	local yOffset = 0
	if (x > 1) then
		xOffset = ((x / 100) * icon:GetParent():GetWidth()) / 100
		yOffset = ((y / 100) * icon:GetParent():GetHeight()) / 100
	else
		xOffset = x * icon:GetParent():GetWidth()
		yOffset = y * icon:GetParent():GetHeight()
	end
	
	icon:SetPoint("CENTER", icon:GetParent(), "TOPLEFT", xOffset, -yOffset)
	icon:Show()
end

function RSExplorerRareList:OnElementSelectionChanged(elementData, selected)
    local element = self.scrollView:FindFrame(elementData);
    
    if (not element) then
    	return
    end
    
    -- Avoid refreshing UI for deselected elements
    if (not selected) then
    	element.Selected:Hide()
    	return
    else
   		element.Selected:Show()
   	end
    
    local mainFrame = self:GetParent()	
	local internalInfo = {}
	if (elementData.isNpc) then
		internalInfo = RSNpcDB.GetInternalNpcInfoByMapID(elementData.entityID, self.mapID)
	else
		internalInfo = RSContainerDB.GetInternalContainerInfoByMapID(elementData.entityID, self.mapID)
	end
	
	-- Name
	mainFrame.RareInfo.Name:SetText(elementData.name)
	
	-- Map
	local mapFrame = mainFrame.RareInfo.Map
	RSExplorerLoadMap(self.mapID, mapFrame)
	
	-- Icons / Spawning points
	mapFrame.overlayIconsPool:ReleaseAll()
	if (internalInfo.overlay) then
		local r, g, b = RSConfigDB.GetWorldMapOverlayColour(1)
		
		for _, coordinates in ipairs (internalInfo.overlay) do
			local x, y = strsplit("-", coordinates)
			local overlayIcon = mapFrame.overlayIconsPool:Acquire();
			AddIcon(overlayIcon, RSConstants.OVERLAY_SPOT_TEXTURE, tonumber(x), tonumber(y), r, g, b)
		end
	end
		
	-- Icons / Skull
	mapFrame.iconsPool:ReleaseAll()
	local entityPOI
	if (elementData.isNpc) then
		entityPOI = RSNpcPOI.GetNpcPOI(elementData.entityID, self.mapID, internalInfo, RSGeneralDB.GetAlreadyFoundEntity(elementData.entityID))
	else
		entityPOI = RSContainerPOI.GetContainerPOI(elementData.entityID, self.mapID, internalInfo, RSGeneralDB.GetAlreadyFoundEntity(elementData.entityID))
	end
	
	if (entityPOI) then
		local mainIcon = mapFrame.iconsPool:Acquire();
		AddIcon(mainIcon, entityPOI.Texture, tonumber(internalInfo.x), tonumber(internalInfo.y))

		-- Achievement
		if (RSUtils.GetTableLength(entityPOI.achievementIDs) > 0) then
			for _, achievementID in ipairs(entityPOI.achievementIDs) do
				mainFrame.RareInfo.AchievementIcon.achievementLink = RSAchievementDB.GetCachedAchievementLink(achievementID)
				mainFrame.RareInfo.AchievementIcon:Show()
				break
			end
		else
			mainFrame.RareInfo.AchievementIcon:Hide()
		end
	else
		mainFrame.RareInfo.AchievementIcon:Hide()
	end
	
	-- Loot
	mainFrame.lootItemsPool:ReleaseAll();
	self:AddItems(elementData, mainFrame.RareInfo.Mounts, RSConstants.ITEM_TYPE.MOUNT)
	self:AddItems(elementData, mainFrame.RareInfo.Pets, RSConstants.ITEM_TYPE.PET)
	self:AddItems(elementData, mainFrame.RareInfo.Toys, RSConstants.ITEM_TYPE.TOY)
	self:AddItems(elementData, mainFrame.RareInfo.Appearances, RSConstants.ITEM_TYPE.APPEARANCE)
	
	-- Refresh internal loot grid
	mainFrame.RareInfo.Custom.grid = nil
	
	-- With custom items take into account only if not filtered
	local customGroupKeys = {}
	for groupKey, _ in pairs(RSCollectionsDB.GetItemGroups()) do
		if (RSConfigDB.IsSearchingCustom(groupKey)) then
			tinsert(customGroupKeys, string.format(RSConstants.ITEM_TYPE.CUSTOM, groupKey))
		end
	end
	
	for _, customGroupKey in ipairs(customGroupKeys) do
		self:AddItems(elementData, mainFrame.RareInfo.Custom, customGroupKey, customGroupKeys)
	end
end

function RSExplorerRareList:AddEntityToDataProvider(entityID, entityInfo, entityName, source)
	local collectionsLoot = RSCollectionsDB.GetAllEntitiesCollectionsLoot()[source]
	local alreadyAdded = false
	
	if (not alreadyAdded and filters[RSConstants.EXPLORER_FILTER_DROP_MOUNTS] and collectionsLoot and collectionsLoot[entityID] and RSUtils.GetTableLength(collectionsLoot[entityID][RSConstants.ITEM_TYPE.MOUNT]) > 0) then
		self:AddToDataProvider(entityID, entityInfo, entityName, source)
		alreadyAdded = true
	end
		
	if (not alreadyAdded and filters[RSConstants.EXPLORER_FILTER_DROP_PETS] and collectionsLoot and collectionsLoot[entityID] and RSUtils.GetTableLength(collectionsLoot[entityID][RSConstants.ITEM_TYPE.PET]) > 0) then
		self:AddToDataProvider(entityID, entityInfo, entityName, source)
		alreadyAdded = true
	end
				
	if (not alreadyAdded and filters[RSConstants.EXPLORER_FILTER_DROP_TOYS] and collectionsLoot and collectionsLoot[entityID] and RSUtils.GetTableLength(collectionsLoot[entityID][RSConstants.ITEM_TYPE.TOY]) > 0) then
		self:AddToDataProvider(entityID, entityInfo, entityName, source)
		alreadyAdded = true
	end
			
	if (not alreadyAdded and filters[RSConstants.EXPLORER_FILTER_DROP_APPEARANCES] and collectionsLoot and collectionsLoot[entityID] and collectionsLoot[entityID][RSConstants.ITEM_TYPE.APPEARANCE] and RSUtils.GetTableLength(collectionsLoot[entityID][RSConstants.ITEM_TYPE.APPEARANCE][self.classIndex]) > 0) then
		self:AddToDataProvider(entityID, entityInfo, entityName, source)
		alreadyAdded = true
	end
	
	if (not alreadyAdded) then
		for groupKey, _ in pairs(RSCollectionsDB.GetItemGroups()) do	
			if (filters[string.format(RSConstants.EXPLORER_FILTER_DROP_CUSTOM, groupKey)] and collectionsLoot and collectionsLoot[entityID] and RSUtils.GetTableLength(collectionsLoot[entityID][string.format(RSConstants.ITEM_TYPE.CUSTOM, groupKey)]) > 0) then
				self:AddToDataProvider(entityID, entityInfo, entityName, source)
				alreadyAdded = true
			end
		end
	end
				
	if (not alreadyAdded and filters[RSConstants.EXPLORER_FILTER_ACHIEVEMENT_CRITERIA] and entityInfo.achievementID) then
		local isContainer = source == RSConstants.ITEM_SOURCE.CONTAINER and true or false
			
		if (RSAchievementDB.IsNotCompletedAchievementCriteria(entityID, entityInfo.achievementID, entityInfo.questID, entityInfo.criteria, isContainer)) then
			self:AddToDataProvider(entityID, entityInfo, entityName, source)
			alreadyAdded = true
		end
	end
	
	if (not alreadyAdded and filters[RSConstants.EXPLORER_FILTER_WITHOUT_COLLECTIBLES] and ((not collectionsLoot or not collectionsLoot[entityID]) or (collectionsLoot[entityID][RSConstants.ITEM_TYPE.APPEARANCE] and RSUtils.GetTableLength(collectionsLoot[entityID][RSConstants.ITEM_TYPE.APPEARANCE][self.classIndex]) == 0))) then
		self:AddToDataProvider(entityID, entityInfo, entityName, source)
		alreadyAdded = true
	end
end

function RSExplorerRareList:AddToDataProvider(entityID, entityInfo, entityName, itemSource)
	local elementData = {}
	elementData.entityID = entityID
	elementData.mapID = entityInfo.zoneID
	elementData.name = entityName
	
	if (itemSource == RSConstants.ITEM_SOURCE.NPC) then
		elementData.displayID = entityInfo.displayID
		elementData.filtered = RSConfigDB.GetNpcFiltered(entityID) ~= nil
		elementData.dead = RSNpcDB.IsNpcKilled(entityID)
		elementData.custom = entityInfo.custom
		elementData.isNpc = true
	else
		elementData.filtered = RSConfigDB.GetContainerFiltered(entityID) ~= nil
		elementData.dead = RSContainerDB.IsContainerOpened(entityID)
		elementData.custom = false
		elementData.isContainer = true
	end
	
	-- add extra information
	local collectionsLoot = RSCollectionsDB.GetAllEntitiesCollectionsLoot()
	if (collectionsLoot[itemSource] and collectionsLoot[itemSource][entityID]) then
		if (RSUtils.GetTableLength(collectionsLoot[itemSource][entityID][RSConstants.ITEM_TYPE.MOUNT]) > 0) then
			elementData.hasMissingMount = true
		else
			elementData.hasMissingMount = false
		end
		if (RSUtils.GetTableLength(collectionsLoot[itemSource][entityID][RSConstants.ITEM_TYPE.PET]) > 0) then
			elementData.hasMissingPet = true
		else
			elementData.hasMissingPet = false
		end
		if (RSUtils.GetTableLength(collectionsLoot[itemSource][entityID][RSConstants.ITEM_TYPE.TOY]) > 0) then
			elementData.hasMissingToy = true
		else
			elementData.hasMissingToy = false
		end
		if (collectionsLoot[itemSource][entityID][RSConstants.ITEM_TYPE.APPEARANCE] and RSUtils.GetTableLength(collectionsLoot[itemSource][entityID][RSConstants.ITEM_TYPE.APPEARANCE][self.classIndex]) > 0) then
			elementData.hasMissingAppearance = true
		else
			elementData.hasMissingAppearance = false
		end
		
		-- for custom items we show the texture only if they user is not filtering for an specific group
		for groupKey, _ in pairs(RSCollectionsDB.GetItemGroups()) do	
			if (RSUtils.GetTableLength(collectionsLoot[itemSource][entityID][string.format(RSConstants.ITEM_TYPE.CUSTOM, groupKey)]) > 0 and RSConfigDB.IsSearchingCustom(groupKey)) then
				elementData.hasMissingCustom = true
				break
			else
				elementData.hasMissingCustom = false
			end
		end
	end
	
	self.dataProvider:Insert(elementData);
end

function RSExplorerRareList:RefreshDataProvider()
	-- Deletes everything in the dataprovider
	self.dataProvider:Flush()

	self.mapID = RSConfigDB.GetExplorerMapID()
	
	-- Load rare NPC list
	for npcID, npcName in pairs(RSNpcDB.GetAllNpcNames()) do
		if (RSNpcDB.IsInternalNpcInMap(npcID, self.mapID, false, true)) then
			local npcInfo = RSNpcDB.GetInternalNpcInfoByMapID(npcID, self.mapID)
			
			if (npcInfo and npcInfo.displayID) then
				local filtered = false
			
				-- Ignore if part of a disabled event
				if (RSNpcDB.IsDisabledEvent(npcID)) then
					filtered = true
				end
				
				-- Ignore if dead
				if (not filters[RSConstants.EXPLORER_FILTER_DEAD] and RSNpcDB.IsNpcKilled(npcID)) then
					filtered = true
				end
				
				-- Ignore if filtered
				if (not filtered and not filters[RSConstants.EXPLORER_FILTER_FILTERED] and RSConfigDB.GetNpcFiltered(npcID) ~= nil) then
					filtered = true
				end
			
				if (not filtered) then
					self:AddEntityToDataProvider(npcID, npcInfo, npcName, RSConstants.ITEM_SOURCE.NPC)
				end
			else
				RSLogger:PrintDebugMessage(string.format("RSExplorerRareList:RefreshDataProvider: [npcID=%s]. Saltado por no tener informacion o displayID", npcID))
			end
		end
	end
	
	-- Load container list
	for containerID, _ in pairs(RSContainerDB.GetAllInternalContainerInfo()) do
		if (RSContainerDB.IsInternalContainerInMap(containerID, self.mapID, false, true)) then
			local containerInfo = RSContainerDB.GetInternalContainerInfoByMapID(containerID, self.mapID)
			
			if (containerInfo) then
				local filtered = false
				-- Ignore if part of a disabled event
				if (RSContainerDB.IsDisabledEvent(containerID)) then
					filtered = true
				end
				
				-- Ignore if opened
				if (not filters[RSConstants.EXPLORER_FILTER_DEAD] and RSContainerDB.IsContainerOpened(containerID)) then
					filtered = true
				end
				
				-- Ignore if filtered
				if (not filtered and not filters[RSConstants.EXPLORER_FILTER_FILTERED] and RSConfigDB.GetContainerFiltered(containerID) ~= nil) then
					filtered = true
				end
			
				if (not filtered) then
					self:AddEntityToDataProvider(containerID, containerInfo, RSContainerDB.GetContainerName(containerID), RSConstants.ITEM_SOURCE.CONTAINER)
				end
			else
				RSLogger:PrintDebugMessage(string.format("RSExplorerRareList:RefreshDataProvider: [containerID=%s]. Saltado por no tener informacion", containerID))
			end
		end
	end
	
	-- Autoselects the first element
	self.selectionBehavior:SelectFirstElementData()
end

function RSExplorerRareList:AddItems(elementData, parentFrame, itemType, customGroupKeys)
	local mainFrame = self:GetParent()
	
	local collectionsLoot
	if (elementData.isNpc) then
		collectionsLoot = RSCollectionsDB.GetAllEntitiesCollectionsLoot()[RSConstants.ITEM_SOURCE.NPC]
	else
		collectionsLoot = RSCollectionsDB.GetAllEntitiesCollectionsLoot()[RSConstants.ITEM_SOURCE.CONTAINER]
	end
	
	if (collectionsLoot and collectionsLoot[elementData.entityID]) then
		local itemIDs = nil
		if (itemType == RSConstants.ITEM_TYPE.APPEARANCE and collectionsLoot[elementData.entityID][itemType]) then
			-- Don't nest IFs!!
			if (collectionsLoot[elementData.entityID][itemType][self.classIndex]) then
				itemIDs = collectionsLoot[elementData.entityID][itemType][self.classIndex]
			end
		else
			itemIDs = collectionsLoot[elementData.entityID][itemType]
		end
		
	    if (RSUtils.GetTableLength(itemIDs) > 0) then
			local xOffset = 0
			local yOffset = -8
			local numColumn = 0
			local numRow = 0
			local maxLines = 1
			local maxItemsPerRow
    		if (itemType ~= RSConstants.ITEM_TYPE.APPEARANCE and not RSUtils.Contains(customGroupKeys, itemType)) then
    			maxItemsPerRow = 3
 			else
 				maxLines = 4
    			maxItemsPerRow = 7
 			end
 			
	    	-- Custom settings reuse grid properties
	    	if (RSUtils.Contains(customGroupKeys, itemType) and mainFrame.RareInfo.Custom.grid) then
	    		xOffset, yOffset, numRow, numColumn, maxItemsPerRow = unpack(mainFrame.RareInfo.Custom.grid)
	    	end
   
	    	for _, itemID in ipairs(itemIDs) do
	    		local _, _, _, _, icon, _, _ = C_Item.GetItemInfoInstant(itemID)
	    		local lootItem = mainFrame.lootItemsPool:Acquire();
	    		
	    		if (math.fmod(numColumn, maxItemsPerRow) == 0) then
	    			xOffset = xOffset + 10
	    		else
	    			xOffset = xOffset + lootItem:GetWidth() + 2
	    		end
	    		
	    		lootItem.itemID = itemID
	    		lootItem.Icon:SetTexture(icon)
	    		lootItem.isMount = itemType == RSConstants.ITEM_TYPE.MOUNT
	    		lootItem.isPet = itemType == RSConstants.ITEM_TYPE.PET
	    		lootItem.istoy = itemType == RSConstants.ITEM_TYPE.TOY
	    		lootItem.isAppearance = itemType == RSConstants.ITEM_TYPE.APPEARANCE
	    		lootItem.isCustom = RSUtils.Contains(customGroupKeys, itemType)
	    		
	    		lootItem:SetPoint("TOPLEFT", parentFrame, "TOPLEFT", xOffset, yOffset)
	    		lootItem:Show()
	    		
	    		numColumn = numColumn + 1
	    		
	    		if (math.fmod(numColumn, maxItemsPerRow) == 0) then
    				numRow = numRow + 1
    				if (numRow == maxLines) then	
    					break
    				end
    				
    				xOffset = 0
    				numColumn = 0
    				if (numRow > 1 and not lootItem.isAppearance and not lootItem.isCustom) then			
		    			break
		    		else	
		    			maxItemsPerRow = 8
		    			yOffset = yOffset - lootItem:GetHeight() - 2 
		    		end
    			end
    		end
 			
	    	-- Custom settings save current grid properties
	    	if (RSUtils.Contains(customGroupKeys, itemType)) then
	    		mainFrame.RareInfo.Custom.grid = { xOffset, yOffset, numRow, numColumn, maxItemsPerRow }
	    	end
		end
	end
end

-----------------------------------------------------
-- Rare loot
-----------------------------------------------------

function RSExplorerRareInfoLootItem_OnEnter(self)
	local mainFrame = self:GetParent():GetParent()
	local tooltip = mainFrame.Tooltip
	local itemIcon = self
	local item = Item:CreateFromItemID(self.itemID)
	item:ContinueOnItemLoad(function()
		tooltip:SetOwner(itemIcon, "BOTTOM_LEFT")
		tooltip:SetHyperlink(item:GetItemLink())
		
		-- Adds extra information
		RSLootTooltip.AddRareScannerInformation(tooltip, item:GetItemLink(), self.itemID)

		tooltip:Show()
	end)
end

function RSExplorerRareInfoLootItem_OnLeave(self)
	local mainFrame = self:GetParent():GetParent()
	local tooltip = mainFrame.Tooltip
	tooltip:Hide()
end

function RSExplorerRareInfoAchievement_OnEnter(self)
	local mainFrame = self:GetParent():GetParent()
	local tooltip = mainFrame.Tooltip
	tooltip:SetOwner(self, "BOTTOM_LEFT")
	tooltip:SetHyperlink(self.achievementLink)
	tooltip:Show()
end

function RSExplorerRareInfoAchievement_OnLeave(self)
	local mainFrame = self:GetParent():GetParent()
	local tooltip = mainFrame.Tooltip
	tooltip:Hide()
end

function RSExplorerRareInfoLootItem_OnClick(self, button)
	local itemIcon = self
	local item = Item:CreateFromItemID(self.itemID)
	item:ContinueOnItemLoad(function()
		if (IsControlKeyDown()) then
			if (itemIcon.isMount) then
				DressUpMountLink(item:GetItemLink())
			elseif (itemIcon.isPet) then
				DressUpBattlePetLink(item:GetItemLink())
			elseif (itemIcon.isAppearance) then
				DressUpItemLink(item:GetItemLink())
			end
		elseif (IsShiftKeyDown()) then
			ChatEdit_LinkItem(self.itemID, item:GetItemLink())
		end
	end)
end

-----------------------------------------------------
-- Rare detail frame
-----------------------------------------------------

RSExplorerDetailMap = { };

function RSExplorerDetailMap:OnLoad()
	self.detailTilePool = CreateTexturePool(self, "BACKGROUND", -7);
	self.overlayTexturePool = CreateTexturePool(self, "ARTWORK", 0);
	self.textureLoadGroup = CreateFromMixins(TextureLoadingGroupMixin);
	self.defailedTextureLoadGroup = CreateFromMixins(TextureLoadingGroupMixin);
end

function RSExplorerDetailMap:IsFullyLoaded()
	return not self.isWaitingForLoad;
end

function RSExplorerDetailMap:SetMapAndLayer(mapID, layerIndex, mapFrame)
	local mapArtID = C_Map.GetMapArtID(mapID) -- phased map art may be different for the same mapID
	if (self.mapID ~= mapID or self.mapArtID ~= mapArtID or self.layerIndex ~= layerIndex) then
		self.mapID = mapID;
		self.mapArtID = mapArtID;
		self.layerIndex = layerIndex;
		self:RefreshDetailTiles(mapFrame);
	end
end

function RSExplorerDetailMap:RefreshDetailTiles(mapFrame)
	self.detailTilePool:ReleaseAll();
	self.overlayTexturePool:ReleaseAll();
	self.textureLoadGroup:Reset();
	self.defailedTextureLoadGroup:Reset();
	self.isWaitingForLoad = true;
	self:SetAlpha(0);
	
	local layers = C_Map.GetMapArtLayers(self.mapID);
	local layerInfo = layers[self.layerIndex];
	local numDetailTilesRows = math.ceil(layerInfo.layerHeight / layerInfo.tileHeight);
	local numDetailTilesCols = math.ceil(layerInfo.layerWidth / layerInfo.tileWidth);
	local textures = C_Map.GetMapArtLayerTextures(self.mapID, self.layerIndex);
	local exploredMapTextures = C_MapExplorationInfo.GetExploredMapTextures(self.mapID)
	
	local prevRowDetailTile;
	local prevColDetailTile;
	
	-- Add unexplored layer
	for tileCol = 1, numDetailTilesCols do
		for tileRow = 1, numDetailTilesRows do
			if tileRow == 1 then
				prevRowDetailTile = nil;
			end
			local detailTile = self.detailTilePool:Acquire();
			self.textureLoadGroup:AddTexture(detailTile);
			local textureIndex = (tileRow - 1) * numDetailTilesCols + tileCol;
			detailTile:SetTexture(textures[textureIndex], nil, nil, "TRILINEAR");
			detailTile:ClearAllPoints();
			if prevRowDetailTile then
				detailTile:SetPoint("TOPLEFT", prevRowDetailTile, "BOTTOMLEFT");
			else
				if prevColDetailTile then
					detailTile:SetPoint("TOPLEFT", prevColDetailTile, "TOPRIGHT");
				else
					detailTile:SetPoint("TOPLEFT", self);
				end
			end
			detailTile:SetDrawLayer("BACKGROUND", -8 + self.layerIndex);
			detailTile:Show();			
			prevRowDetailTile = detailTile;
			if tileRow == 1 then
				prevColDetailTile = detailTile;
			end
		end
	end
	
	-- Add explored overlay
	if (exploredMapTextures) then
		local TILE_SIZE_WIDTH = layerInfo.tileWidth;
		local TILE_SIZE_HEIGHT = layerInfo.tileHeight;
		for i, exploredTextureInfo in ipairs(exploredMapTextures) do
			local numTexturesWide = ceil(exploredTextureInfo.textureWidth/TILE_SIZE_WIDTH);
			local numTexturesTall = ceil(exploredTextureInfo.textureHeight/TILE_SIZE_HEIGHT);
			local texturePixelWidth, textureFileWidth, texturePixelHeight, textureFileHeight;
			for j = 1, numTexturesTall do
				if ( j < numTexturesTall ) then
					texturePixelHeight = TILE_SIZE_HEIGHT;
					textureFileHeight = TILE_SIZE_HEIGHT;
				else
					texturePixelHeight = mod(exploredTextureInfo.textureHeight, TILE_SIZE_HEIGHT);
					if ( texturePixelHeight == 0 ) then
						texturePixelHeight = TILE_SIZE_HEIGHT;
					end
					textureFileHeight = 16;
					while(textureFileHeight < texturePixelHeight) do
						textureFileHeight = textureFileHeight * 2;
					end
				end
				for k = 1, numTexturesWide do
					local texture = self.overlayTexturePool:Acquire();
					self.defailedTextureLoadGroup:AddTexture(texture);
					if ( k < numTexturesWide ) then
						texturePixelWidth = TILE_SIZE_WIDTH;
						textureFileWidth = TILE_SIZE_WIDTH;
					else
						texturePixelWidth = mod(exploredTextureInfo.textureWidth, TILE_SIZE_WIDTH);
						if ( texturePixelWidth == 0 ) then
							texturePixelWidth = TILE_SIZE_WIDTH;
						end
						textureFileWidth = 16;
						while(textureFileWidth < texturePixelWidth) do
							textureFileWidth = textureFileWidth * 2;
						end
					end
					texture:SetWidth(texturePixelWidth);
					texture:SetHeight(texturePixelHeight);
					texture:SetTexCoord(0, texturePixelWidth/textureFileWidth, 0, texturePixelHeight/textureFileHeight);
					texture:SetPoint("TOPLEFT", exploredTextureInfo.offsetX + (TILE_SIZE_WIDTH * (k-1)), -(exploredTextureInfo.offsetY + (TILE_SIZE_HEIGHT * (j - 1))));
					texture:SetTexture(exploredTextureInfo.fileDataIDs[((j - 1) * numTexturesWide) + k], nil, nil, "TRILINEAR");
					texture:SetDrawLayer("ARTWORK", -1);
					texture:Show();
				end
			end
		end
	end
	
	-- Rescale
	local mapWidth = layerInfo.layerWidth
	if (mapWidth ~= mapFrame:GetWidth()) then
		local scaleFactor = mapFrame:GetWidth() / mapWidth
		self:SetScale(scaleFactor)
	end
end


function RSExplorerDetailMap:OnUpdate()
	if (self.isWaitingForLoad and self.textureLoadGroup:IsFullyLoaded() and self.defailedTextureLoadGroup:IsFullyLoaded()) then
		self.isWaitingForLoad = nil;
		self:RefreshAlpha();
		self.textureLoadGroup:Reset();
		self.defailedTextureLoadGroup:Reset();
	end
end

function RSExplorerDetailMap:RefreshAlpha()
	if (self:IsFullyLoaded()) then
		self:SetAlpha(1);
	else
		self:SetAlpha(0);
	end
end

-----------------------------------------------------
-- Control frames
-----------------------------------------------------

RSExplorerControl = {}

function RSExplorerControl:Initialize(mainFrame)
	if (mainFrame.initialized) then
		return
	end
	
	self.mainFrame = mainFrame
	self.ApplyFiltersButton:SetText(AL["EXPLORER_FILTERING"])
	self.ApplyFiltersButton.tooltip = string.format(AL["EXPLORER_FILTERING_DESC"], AL["EXPLORER_FILTERS"], AL["EXPLORER_FILTER_COLLECTIONS"])
	self.CreateProfilesBackupCheckButton.Text:SetText(AL["EXPLORER_CREATE_BACKUP"])
	self.CreateProfilesBackupCheckButton.tooltip = string.format(AL["EXPLORER_CREATE_BACKUP_DESC"], AL["EXPLORER_FILTERING"])
	self.CreateProfilesBackupCheckButton:SetChecked(RSConfigDB.IsCreateProfileBackup())
	self.CreateProfilesBackupCheckButton.func = function(self, checked)
		RSConfigDB.SetCreateProfileBackup(checked)
	end
	
	self.AutoFilterCheckButton.Text:SetText(AL["EXPLORER_AUTO_FILTER"])
	self.AutoFilterCheckButton.tooltip = AL["EXPLORER_AUTO_FILTER_DESC"]
	self.AutoFilterCheckButton:SetChecked(RSConfigDB.IsAutoFilteringOnCollect())
	self.AutoFilterCheckButton.func = function(self, checked)
		RSConfigDB.SetAutoFilteringOnCollect(checked)
	end
end

function RSExplorerControl:StartScanning(self, button)
	if (self:IsShown()) then
		local mainFrame = self:GetParent():GetParent()
		
		self:Hide()
		self:GetParent().ScanProcessText:Show()
		mainFrame:HideCustomLootPanels()
		
		local manualScan = self:GetParent().ScanRequiredText:GetText() == AL["EXPLORER_SCAN_MANUAL"]
		
		RSCollectionsDB.ApplyCollectionsEntitiesFilters(function()
	    	self:GetParent():Hide()
			self:GetParent().ScanProcessText:Hide()
    		mainFrame.RareInfo:Show()
			mainFrame:Initialize()
	    end, self:GetParent().ScanProcessText, manualScan)
	end
end

function RSExplorerControl:ApplyFilters(self, button)
	local mainFrame = self:GetParent().mainFrame
	local data = {
		callback = function()
			mainFrame:Refresh()
			local subdata = {
				filters = filters
			}
			LibDialog:Spawn(RSConstants.APPLY_COLLECTIONS_LOOT_FILTERS, subdata)
		end,
		filters = filters
	}
	LibDialog:Spawn(RSConstants.EXPLORER_FILTERING_DIALOG, data)
end

-----------------------------------------------------
-- Custom loot panel
-----------------------------------------------------

RSExplorerLoot = { };

local function LootGroupDropDown_SetupMenu(dropDown, rootDescription)
	local itemGroups = RSCollectionsDB.GetItemGroups()
	
	for key, name in pairs(itemGroups) do
		rootDescription:CreateRadio(name, 
			function(key)
				return dropDown.selectedGroupKey == key
			end, 
			function(key)
				dropDown.selectedGroupKey = key
			end,
			key)
	end
	
	-- Selects the first value
 	if (not dropDown.selectedGroupKey) then
	 	for key, name in pairs (itemGroups) do
			dropDown.selectedGroupKey = key
			break
		end
	end
end

function RSExplorerLoot:AddNewGroup(editbox)
	local value = editbox:GetText()
	if (value and strtrim(value) ~= '') then
		local key = RSCollectionsDB.AddItemGroup(value)
		if (key) then
			editbox:GetParent().LootGroupDropDown.selectedGroupKey = key
			editbox:GetParent().LootGroupDropDown:GenerateMenu()
			editbox:SetText("")
			editbox:ClearFocus()
			self:RefreshDataProvider()
		end
	end
end

function RSExplorerLoot:EditGroupName(editbox)
	local mainFrame = editbox:GetParent():GetParent()
	local controlFrame = mainFrame.ControlFrame
	local newGroupName = editbox:GetText()
	local elementData = self.selectionBehavior:GetFirstSelectedElementData()
	
	-- Change name
	RSCollectionsDB.SetGroupName(elementData.key, newGroupName)
	
	-- Refresh group dropdown if selected
	if (self.ControlFrame.LootGroupDropDown.selectedGroupKey == elementData.key) then
		controlFrame.LootGroupDropDown:GenerateMenu()
	end
	
	self:RefreshDataProvider()
end

function RSExplorerLoot:DeleteGroup(buttonFrame, button)
	local mainFrame = self
	local elementData = self.selectionBehavior:GetFirstSelectedElementData()
	
	local data = {
		callback = function()
			RSCollectionsDB.DeleteItemGroup(elementData.key)
	
			-- Selects the first item in the list
			for key, name in pairs(RSCollectionsDB.GetItemGroups()) do
				mainFrame.ControlFrame.LootGroupDropDown.selectedGroupKey = key
				mainFrame.ControlFrame.LootGroupDropDown:GenerateMenu()
				break
			end
			
			mainFrame.GroupInfo.lootItemsPool:ReleaseAll();
			mainFrame:RefreshDataProvider()
		end
	}
	LibDialog:Spawn(RSConstants.DELETE_GROUP_CONFIRMATION, data)
end

function RSExplorerLoot:AddItems(editbox)
	local value = editbox:GetText()
	local elementData = self.selectionBehavior:GetFirstSelectedElementData()
	
	if (value and strtrim(value) ~= '') then
		-- Validates string
		if (string.match(value, "[^0-9,]")) then
			LibDialog:Spawn(RSConstants.ITEM_LIST_VALIDATION_ERROR);
			return
		end
		
		-- Validates items
		local errorIDs = {}
		for itemIDstring in string.gmatch(value, '([^,]+)') do
			local itemID = tonumber(itemIDstring)
			local ret, _, itemType, itemSubType, itemEquipLoc, icon, classID, subclassID = pcall(C_Item.GetItemInfoInstant, itemID)
			if (not ret or not icon) then
				tinsert(errorIDs, itemID)
			else
				RSCollectionsDB.AddGroupItem(elementData.key, itemID)
			end
		end
		
		-- Prints wrong IDs
		if (RSUtils.GetTableLength(errorIDs) > 0) then
			LibDialog:Spawn(RSConstants.ITEM_LIST_WRONG_IDS_ERROR);
			local errorIDsString
			for _, itemID in ipairs(errorIDs) do
				if (not errorIDsString) then
					errorIDsString = itemID
				else
					errorIDsString = string.format("%s, %s", errorIDsString, itemID)
				end
			end
			RSLogger:PrintMessage(string.format(AL["EXPLORER_CUSTOM_ITEMS_WRONG_IDS_CHAT"], errorIDsString))
			return
		end
		
		-- Clean inputfield
		editbox:SetText("")
		
		-- Refresh info panel
		self:Refresh()
	end
end

function RSExplorerLoot:Refresh()
	local elementData = self.selectionBehavior:GetFirstSelectedElementData()
	if (not elementData) then
		return
	end
	
	self:OnElementSelectionChanged(elementData, true)
end

function RSExplorerCustomLootItem_OnEnter(self)
	local customLoot = self:GetParent():GetParent()
	local tooltip = customLoot.mainFrame.Tooltip
	local itemIcon = self
	local item = Item:CreateFromItemID(self.itemID)
	item:ContinueOnItemLoad(function()
		tooltip:SetOwner(itemIcon, "BOTTOM_LEFT")
		tooltip:SetHyperlink(item:GetItemLink())
		
		-- Adds extra information only for this tooltip
		tooltip:AddLine(RSUtils.TextColor(string.format(AL["EXPLORER_CUSTOM_ITEMS_TOOLTIP_ID"], item:GetItemID()), "FFFF00"))
		tooltip:AddLine(" ")
		tooltip:AddLine("|TInterface\\AddOns\\RareScanner\\Media\\Textures\\tooltip_shortcuts:18:60:::256:256:0:96:0:32|t "..RSUtils.TextColor(AL["EXPLORER_CUSTOM_ITEMS_TOOLTIP_DROP"], "00FF00"))
		
		tooltip:Show()
	end)
end

function RSExplorerCustomLootItem_OnLeave(self)
	local customLoot = self:GetParent():GetParent()
	local tooltip = customLoot.mainFrame.Tooltip
	tooltip:Hide()
end

function RSExplorerCustomLootItem_OnClick(self, button)
	local customLoot = self:GetParent():GetParent()
	local itemIcon = self
	
	if (button == "LeftButton" and not IsAltKeyDown() and IsShiftKeyDown()) then
		local item = Item:CreateFromItemID(itemIcon.itemID)
		item:ContinueOnItemLoad(function()
			ChatEdit_LinkItem(self.itemID, item:GetItemLink())
		end)
	elseif (button == "LeftButton" and IsAltKeyDown() and IsShiftKeyDown()) then
		RSCollectionsDB.DeleteGroupItem(self.groupKey, itemIcon.itemID)
		customLoot:Refresh()
	end
end

local function RSRexplorerGroupList_Sort(e1, e2)
	local strCmpResult = strcmputf8i(e1.name, e2.name);
	if (strCmpResult ~= 0) then
		return strCmpResult < 0;
	end
	
	return false
end

function RSExplorerLoot:Initialize(mainFrame)
	if (self.initialized) then
		return
	end
	
	self.initialized = true
	self.mainFrame = mainFrame
	self.ControlFrame.mainFrame = mainFrame
	
	-- Control panel
	self.ControlFrame.LootGroupLabel:SetText(AL["EXPLORER_CUSTOM_ITEMS_GROUP"])
	self.ControlFrame.LootNewGroupLabel:SetText(AL["EXPLORER_CUSTOM_ITEMS_ADD_GROUP"])
	self.ControlFrame.LootGroupDropDown.tooltip = AL["EXPLORER_CUSTOM_ITEMS_GROUP_DESC"]
	self.ControlFrame.LootGroupDropDown:SetupMenu(LootGroupDropDown_SetupMenu)
	self.ControlFrame.NewGroup.tooltip = AL["EXPLORER_CUSTOM_ITEMS_ADD_GROUP_DESC"]
	self.ControlFrame.ItemListLabel:SetText(AL["EXPLORER_CUSTOM_ITEMS_LIST"])
	self.ControlFrame.ItemList.tooltip = AL["EXPLORER_CUSTOM_ITEMS_LIST_DESC"]
	
	-- Group info
	self.GroupInfo.mainFrame = mainFrame
	self.GroupInfo.DeleteGroup:SetText(AL["EXPLORER_CUSTOM_ITEMS_DELETE_GROUP"])
	self.GroupInfo.EditGroupName.tooltip = AL["EXPLORER_CUSTOM_ITEMS_EDIT_GROUP"]
	self.GroupInfo.NoItems:SetText(AL["EXPLORER_CUSTOM_ITEMS_GROUP_EMPTY"])
	self.GroupInfo.lootItemsPool = CreateFramePool("Button", self.GroupInfo, "RSExplorerCustomLootItemTemplate");
	
	-- Group list
	self.GroupList.scrollView = CreateScrollBoxListLinearView();
    self.GroupList.scrollView:SetElementInitializer("RSExplorerGroupButtonTemplate", GenerateClosure(self.OnElementInitialize, self));
	ScrollUtil.InitScrollBoxListWithScrollBar(self.GroupList.scrollBox, self.GroupList.scrollBar, self.GroupList.scrollView);
	
	self.selectionBehavior = ScrollUtil.AddSelectionBehavior(self.GroupList.scrollBox);
    self.selectionBehavior:RegisterCallback("OnSelectionChanged", self.OnElementSelectionChanged, self);
	
	self.dataProvider = CreateDataProvider()
	self.dataProvider:SetSortComparator(RSRexplorerGroupList_Sort)
	self.GroupList.scrollBox:SetDataProvider(self.dataProvider);
	self:RefreshDataProvider();
	
	-- Starts hidding it
	mainFrame:HideCustomLootPanels()
end

function RSExplorerLoot:OnElementInitialize(element, elementData)
	element.Name:SetText(elementData.name)
	
	if (self.selectionBehavior:IsSelected(element)) then
		element.Selected:Show()
	else
		element.Selected:Hide()
	end
	
	element:SetScript("OnClick", function(element, button) self:OnElementClick(element, elementData, button) end);
end

function RSExplorerLoot:OnElementSelectionChanged(elementData, selected)
    local element = self.GroupList.scrollView:FindFrame(elementData);
    
    if (not element) then
    	return
    end
    
    -- Avoid refreshing UI for deselected elements
    if (not selected) then
    	element.Selected:Hide()
    	return
    else
   		element.Selected:Show()
   	end
   	
	self.GroupInfo.EditGroupName:SetText(elementData.name)
	
	-- Cleans current list
	self.GroupInfo.lootItemsPool:ReleaseAll();
		
	-- Name
	local itemIDs = RSCollectionsDB.GetGroupItems(elementData.key)
	if (RSUtils.GetTableLength(itemIDs) == 0) then
		self.GroupInfo.NoItems:Show()
	else
		self.GroupInfo.NoItems:Hide()
		
		local xOffset = 0
		local yOffset = -2
		local numColumn = 0
		local numRow = 0
		local maxLines = 8
		local maxItemsPerRow = 17
    	for _, itemID in ipairs(itemIDs) do
    		local _, _, _, _, icon, _, _ = C_Item.GetItemInfoInstant(itemID)
    		local lootItem = self.GroupInfo.lootItemsPool:Acquire();
    		
    		if (math.fmod(numColumn, maxItemsPerRow) ~= 0) then
    			xOffset = xOffset + lootItem:GetWidth() + 2
    		end
    		
    		lootItem.itemID = itemID
    		lootItem.groupKey = elementData.key
    		lootItem.Icon:SetTexture(icon)
    		lootItem:SetPoint("TOPLEFT", self.GroupInfo.ItemPanel, "TOPLEFT", xOffset, yOffset)
    		lootItem:Show()
    		
    		numColumn = numColumn + 1
    		
    		if (math.fmod(numColumn, maxItemsPerRow) == 0) then
				numRow = numRow + 1
				if (numRow == maxLines) then
					break
				end
				
				xOffset = 0
				numColumn = 0
				yOffset = yOffset - lootItem:GetHeight() - 2
			end
    	end
	end
end

function RSExplorerLoot:OnElementClick(element, elementData, button)
	self.selectionBehavior:ClearSelections()
	self.selectionBehavior:Select(element);
end

function RSExplorerLoot:RefreshDataProvider()
	-- Deletes everything in the dataprovider
	self.dataProvider:Flush()
	
	for key, name in pairs(RSCollectionsDB.GetItemGroups()) do
		local elementData = {}
		elementData.name = name
		elementData.key = key
		self.dataProvider:Insert(elementData);
	end
	
	-- Autoselects the first element
	self.selectionBehavior:SelectFirstElementData()
end

-----------------------------------------------------
-- Explorer main frame
-----------------------------------------------------

RSExplorerMixin = { };

function RSExplorerMixin:OnLoad()
	self.lootItemsPool = CreateFramePool("Button", self.RareInfo, "RSExplorerRareInfoLootItemTemplate");
	self.RareInfo.Mounts.Texture:SetTexture("Interface\\AddOns\\RareScanner\\Media\\Textures\\MountsCorner.blp")
	self.RareInfo.Mounts.Texture:SetVertexColor(1,1,1,0.5)
	self.RareInfo.Mounts.Texture.tooltip = AL["EXPLORER_MOUNTS"]
	self.RareInfo.Pets.Texture:SetTexture("Interface\\AddOns\\RareScanner\\Media\\Textures\\PetsCorner.blp")
	self.RareInfo.Pets.Texture:SetVertexColor(1,1,1,0.5)
	self.RareInfo.Pets.Texture.tooltip = AL["EXPLORER_PETS"]
	self.RareInfo.Toys.Texture:SetTexture("Interface\\AddOns\\RareScanner\\Media\\Textures\\ToysCorner.blp")
	self.RareInfo.Toys.Texture:SetVertexColor(1,1,1,0.5)
	self.RareInfo.Toys.Texture.tooltip = AL["EXPLORER_TOYS"]
	self.RareInfo.Appearances.Texture:SetTexture("Interface\\AddOns\\RareScanner\\Media\\Textures\\AppearancesCorner.blp")
	self.RareInfo.Appearances.Texture:SetVertexColor(1,1,1,0.5)
	self.RareInfo.Appearances.Texture.tooltip = AL["EXPLORER_APPEARANCES"]
	self.RareInfo.Custom.Texture:SetTexture("Interface\\AddOns\\RareScanner\\Media\\Textures\\CustomCorner.blp")
	self.RareInfo.Custom.Texture:SetVertexColor(1,1,1,0.5)
	self.RareInfo.Custom.Texture.tooltip = AL["EXPLORER_CUSTOM"]
	self:RegisterForDrag("LeftButton");
	tinsert(UISpecialFrames, self:GetName());
end

function RSExplorerMixin:HideCustomLootPanels()
	self.CustomLoot:Hide()
	self.CustomLoot.background:Hide()
	self.CustomLoot.Border:Hide()
	self.CustomLoot.ControlFrame:Hide()
	self.CustomLoot.GroupList:Hide()
	self.CustomLoot.GroupInfo:Hide()
	
	-- Move to the center
	self.ScanRequired:SetPoint("TOPLEFT")
	self.ScanRequired:SetPoint("TOPRIGHT")
	self.ScanRequired.moved = false
end

function RSExplorerMixin:ShowCustomLootPanels()
	self.CustomLoot:Show()
	self.CustomLoot.background:Show()
	self.CustomLoot.Border:Show()
	self.CustomLoot.ControlFrame:Show()
	self.CustomLoot.GroupList:Show()
	self.CustomLoot.GroupInfo:Show()
	
	-- Move to the bottom
	if (not self.ScanRequired.moved) then
		local pointte, relativeTote, relativePointte, xOfste, yOfste = self.ScanRequired:GetPoint()
		self.ScanRequired:SetPoint(pointte, relativeTote, relativePointte, xOfste, yOfste - 300)
		self.ScanRequired.moved = true
	end
end

function RSExplorerMixin:HideContentPanels()
	self.RareInfo:Hide()
	self.RareNPCList:Hide()
	self.Filters:Hide()
	self.Control:Hide()
end

function RSExplorerMixin:ShowContentPanels()
	self.RareInfo:Show()
	self.RareNPCList:Show()
	self.Filters:Show()
	self.Control:Show()
end

function RSExplorerMixin:Initialize()
	filters[RSConstants.EXPLORER_FILTER_DROP_MOUNTS] = RSConfigDB.IsSearchingMounts()
	filters[RSConstants.EXPLORER_FILTER_DROP_PETS] = RSConfigDB.IsSearchingPets()
	filters[RSConstants.EXPLORER_FILTER_DROP_TOYS] = RSConfigDB.IsSearchingToys()
	filters[RSConstants.EXPLORER_FILTER_DROP_APPEARANCES] = RSConfigDB.IsSearchingAppearances()
	filters[RSConstants.EXPLORER_FILTER_ACHIEVEMENT_CRITERIA] = RSConfigDB.IsSearchingMissingAchievementCriteria()
	filters[RSConstants.EXPLORER_FILTER_DEAD] = RSConfigDB.IsShowDead()
	filters[RSConstants.EXPLORER_FILTER_FILTERED] = RSConfigDB.IsShowFiltered()
	filters[RSConstants.EXPLORER_FILTER_WITHOUT_COLLECTIBLES] = RSConfigDB.IsShowWithoutCollectibles()
	
	for groupKey, _ in pairs(RSCollectionsDB.GetItemGroups()) do
		filters[string.format(RSConstants.EXPLORER_FILTER_DROP_CUSTOM, groupKey)] = RSConfigDB.IsSearchingCustom(groupKey)
	end
	
	self.Filters:Initialize(self);
	self.RareNPCList:Initialize(self);
	self.Control:Initialize(self);
	self.CustomLoot:Initialize(self);
	self.initialized = true
end

function RSExplorerMixin:OnShow()
    -- check if there is a new database and the whole scan should be done or if only the current class is missing in the scan
    if (not RSCollectionsDB.IsCollectionsScanDoneWithCurrentVersion() or not RSCollectionsDB.IsCollectionsScanByClassDone()) then
		if (not RSCollectionsDB.IsCollectionsScanDoneWithCurrentVersion()) then
    		self.ScanRequired.ScanRequiredText:SetText(AL["EXPLORER_SCAN_REQUIRED"])
    		self.ScanRequired.StartScanningButton:SetText(AL["EXPLORER_START_SCAN"])
    	else
    		self.ScanRequired.ScanRequiredText:SetText(AL["EXPLORER_SCAN_CLASS_REQUIRED"])
    		self.ScanRequired.StartScanningButton:SetText(AL["EXPLORER_START_SCAN"])
    	end
    	
    	self.ScanRequired.StartScanningButton:Show()		
    	self.CustomLoot:Show()
    	self.ScanRequired:Show()
    	self:HideContentPanels()
		self.CustomLoot:Initialize(self);
    	self:ShowCustomLootPanels()
    elseif (not self.initialized) then
		self:Initialize()
	end
	-- change to player's zone
	if (RSConfigDB.IsLockingCurrentMap()) then
		self:Refresh()
	end
	
	self:Show()
end

function RSExplorerMixin:Refresh()
	if (self.initialized) then
		PopulateContinentDropDown(self, self.Filters.ContinentDropDown)
		self.RareNPCList:RefreshDataProvider()
	end
end

function RSExplorerMixin:ShowTooltip(frame, message)
	if (frame.tooltip or message) then
		local tooltip = self.Tooltip
		tooltip:SetOwner(frame, "ANCHOR_BOTTOM")
		tooltip:AddLine(message or frame.tooltip, 1, 1, 1, true)
		tooltip:Show()
	end
end

function RSExplorerMixin:HideTooltip(frame)
	if (frame.tooltip or message) then
		local tooltip = self.Tooltip
		tooltip:Hide()
	end
end
