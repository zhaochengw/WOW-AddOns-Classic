-----------------------------------------------------------------------
-- AddOn namespace.
-----------------------------------------------------------------------
local LibStub = _G.LibStub
local ADDON_NAME, private = ...

local RSEventHandler = private.NewLib("RareScannerEventHandler")

-- RareScanner database libraries
local RSConfigDB = private.ImportLib("RareScannerConfigDB")
local RSGeneralDB = private.ImportLib("RareScannerGeneralDB")
local RSMapDB = private.ImportLib("RareScannerMapDB")
local RSNpcDB = private.ImportLib("RareScannerNpcDB")
local RSContainerDB = private.ImportLib("RareScannerContainerDB")
local RSCollectionsDB = private.ImportLib("RareScannerCollectionsDB")
local RSAchievementDB = private.ImportLib("RareScannerAchievementDB")

-- RareScanner services
local RSButtonHandler = private.ImportLib("RareScannerButtonHandler")
local RSMinimap = private.ImportLib("RareScannerMinimap")
local RSEntityStateHandler = private.ImportLib("RareScannerEntityStateHandler")
local RSProvider = private.ImportLib("RareScannerProvider")
local RSMacro = private.ImportLib("RareScannerMacro")

-- RareScanner internal libraries
local RSConstants = private.ImportLib("RareScannerConstants")
local RSLogger = private.ImportLib("RareScannerLogger")
local RSUtils = private.ImportLib("RareScannerUtils")
local RSRoutines = private.ImportLib("RareScannerRoutines")


---============================================================================
-- Handle entities without vignette
---============================================================================

local function HandleEntityWithoutVignette(rareScannerButton, unitID, trackingSystem)
	if (not unitID) then
		return
	end
	
	local unitGuid = UnitGUID(unitID)
	if (not unitGuid) then
		return
	end
	
	local unitType, _, _, _, _, entityID = strsplit("-", unitGuid)
	if (unitType == "Creature" or unitType == "Vehicle") then
		local npcID = entityID and tonumber(entityID) or nil
		
		-- Ignore if friendly
		if (UnitIsFriend("player", unitID) and RSUtils.Contains(RSConstants.IGNORED_FRIENDLY_NPCS, npcID)) then
			RSLogger:PrintDebugMessage(string.format("Ignorado[%s] por ser amistoso.", npcID))
			return
		end
	
		local mapID = C_Map.GetBestMapForUnit("player")
		if (not mapID) then
			return
		end
		
		-- If its a supported NPC and its not killed
		if ((RSGeneralDB.GetAlreadyFoundEntity(npcID) or RSNpcDB.GetInternalNpcInfo(npcID)) and not UnitIsDead(unitID)) then
			local nameplateUnitName, _ = UnitName(unitID)
			if (not nameplateUnitName or nameplateUnitName == UNKNOWNOBJECT) then
				nameplateUnitName = RSNpcDB.GetNpcName(npcID)
			end
			
			local x, y = RSNpcDB.GetBestInternalNpcCoordinates(npcID, mapID)
			rareScannerButton:SimulateRareFound(npcID, unitGuid, nameplateUnitName, x, y, RSConstants.NPC_VIGNETTE, trackingSystem)
		end
	elseif (unitType == "Object") then
		local containerID = entityID and tonumber(entityID) or nil
		local containerName = UnitName(unitID)
		local containerDbName = RSContainerDB.GetContainerName(containerID)
		-- If the container didn't have a vignette this is the last chance to get the name
		if (RSContainerDB.GetInternalContainerInfo(containerID) and (containerDbName or containerDbName ~= containerName)) then
			if (containerName) then
				RSContainerDB.SetContainerName(containerName)
			end
		end
	end
end

---============================================================================
-- Event: NAME_PLATE_UNIT_ADDED
-- Fired when a nameplate appears
---============================================================================

local function OnNamePlateUnitAdded(rareScannerButton, namePlateID)
	if (namePlateID and not UnitIsUnit("player", namePlateID)) then
		HandleEntityWithoutVignette(rareScannerButton, namePlateID, RSConstants.TRACKING_SYSTEM.NAMEPLATE_MOUSEOVER)
	end
end

---============================================================================
-- Event: UPDATE_MOUSEOVER_UNIT
-- Fired when mouseovering a unit
---============================================================================

local function OnUpdateMouseoverUnit(rareScannerButton)
	if (not UnitIsUnit("player", "mouseover") and not UnitIsDead("mouseover")) then
		HandleEntityWithoutVignette(rareScannerButton, "mouseover", RSConstants.TRACKING_SYSTEM.NAMEPLATE_MOUSEOVER)
	end
end

---============================================================================
-- Event: PLAYER_REGEN_ENABLED
-- Fired when the player leaves combat
---============================================================================

local function OnPlayerRegenEnabled(rareScannerButton)
	if (rareScannerButton.pendingToShow) then
		rareScannerButton.pendingToShow = nil
		rareScannerButton.pendingToHide = nil -- just in case it was pending too
		rareScannerButton:ShowButton()
	elseif (rareScannerButton.pendingToHide) then
		rareScannerButton.pendingToHide = nil
		rareScannerButton:HideButton()
	end
end

---============================================================================
-- Event: COMBAT_LOG_EVENT_UNFILTERED
-- Fired with every event on the target
---============================================================================

local function OnCombatLogEventUnfiltered()
	local _, eventType, _, _, _, _, _, destGUID, _, _, _ = CombatLogGetCurrentEventInfo()
	if (eventType == "PARTY_KILL") then
		local _, _, _, _, _, id = strsplit("-", destGUID)
		local npcID = id and tonumber(id) or nil
		RSEntityStateHandler.SetDeadNpc(npcID)
	elseif (eventType == "UNIT_DIED") then
		local _, _, _, _, _, id = strsplit("-", destGUID)
		local npcID = id and tonumber(id) or nil

		-- Set it as dead if the target is already found and doesn't have the silver dragon anymore
		if (RSGeneralDB.GetAlreadyFoundEntity(npcID) and not RSNpcDB.IsNpcKilled(npcID)) then
			if (UnitExists("target") and destGUID == UnitGUID("target")) then
				local unitClassification = UnitClassification("target")
				if (unitClassification ~= "rare" and unitClassification ~= "rareelite") then
					RSEntityStateHandler.SetDeadNpc(npcID)
				end
			end
		end
	end
end

---============================================================================
-- Event: PLAYER_TARGET_CHANGED
-- Fired when changing the target
---============================================================================

local function OnPlayerTargetChanged(rareScannerButton)
	if (UnitExists("target") and not UnitIsUnit("player", "target") and not UnitIsDead("target")) then
		HandleEntityWithoutVignette(rareScannerButton, "target", RSConstants.TRACKING_SYSTEM.UNIT_TARGET)
		
		-- Update coordinates if the NPC doesnt have a vignette
		local targetUid = UnitGUID("target")
		local _, _, _, _, _, npcID = strsplit("-", targetUid)
		local npcInfo = RSNpcDB.GetInternalNpcInfo(tonumber(npcID))
		local playerMapID = C_Map.GetBestMapForUnit("player")
		
		if (npcInfo and (RSMapDB.IsZoneWithoutVignette(playerMapID) or npcInfo.noVignette) and not InCombatLockdown() and CheckInteractDistance("unit", 4)) then
			RSGeneralDB.UpdateAlreadyFoundEntityPlayerPosition(tonumber(npcID))
		end
	end
end

---============================================================================
-- Event: LOOT_OPENED
-- Fired when looting some entity
---============================================================================

local function OnLootOpened()
	local numItems = GetNumLootItems()
	if (not numItems or numItems <= 0) then
		return
	end

	local looted = false
	for i = 1, numItems do
		if (LootSlotHasItem(i)) then
			local destGUID = GetLootSourceInfo(i)
			local unitType, _, _, _, _, id = strsplit("-", destGUID)

			-- If the loot comes from a container that we support
			if (unitType == "GameObject") then
				local containerID = id and tonumber(id) or nil
				RSLogger:PrintDebugMessage(string.format("Abierto [%s].", containerID or ""))

				-- We support all the containers with vignette plus those ones that are part of achievements (without vignette)
				if (RSGeneralDB.GetAlreadyFoundEntity(containerID) or RSContainerDB.GetInternalContainerInfo(containerID)) then
					-- Sets the container as opened
					-- We are looping through all the items looted, we dont want to call this method with every item
					if (not looted) then
				
						-- Check if we have the Container in our database but the addon didnt detect it
						-- This will happend in the case where the container doesnt have a vignette
						if (not RSGeneralDB.GetAlreadyFoundEntity(containerID)) then
							RSGeneralDB.AddAlreadyFoundContainerWithoutVignette(containerID)
						else
							RSGeneralDB.UpdateAlreadyFoundEntityPlayerPosition(containerID)
						end
					
						RSEntityStateHandler.SetContainerOpen(containerID)
						looted = true
					end

					-- Records the loot obtained
					local itemLink = GetLootSlotLink(i)
					if (itemLink) then
						local _, _, _, lootType, id = string.find(itemLink, "|cnIQ?(%d*):|?H?([^:]*):?(%d+):?(%d*):?(%d*):?(%d*):?(%d*):?(%d*):?(%-?%d*):?(%-?%d*):?(%d*):?(%d*)|?h?%[?([^%[%]]*)%]?|?h?|?r?")
						if (lootType == "item") then
						local itemID = id and tonumber(id) or nil
							RSContainerDB.AddItemToContainerLootFound(containerID, itemID)
						end
					end
				end
			-- If the loot comes from a creature that we support
			elseif (unitType == "Creature") then
				local npcID = id and tonumber(id) or nil
				
				-- If its a supported NPC
				if (RSGeneralDB.GetAlreadyFoundEntity(npcID) or RSNpcDB.GetInternalNpcInfo(npcID)) then
					local itemLink = GetLootSlotLink(i)
					if (itemLink) then
						local _, _, _, lootType, id = string.find(itemLink, "|cnIQ?(%d*):|?H?([^:]*):?(%d+):?(%d*):?(%d*):?(%d*):?(%d*):?(%d*):?(%-?%d*):?(%-?%d*):?(%d*):?(%d*)|?h?%[?([^%[%]]*)%]?|?h?|?r?")
						if (lootType == "item") then
							local itemID = id and tonumber(id) or nil
							RSNpcDB.AddItemToNpcLootFound(npcID, itemID)
						end
					end
					
					-- Also update the position and set dead
					if (not looted) then
						RSGeneralDB.UpdateAlreadyFoundEntityPlayerPosition(npcID)
						RSEntityStateHandler.SetDeadNpc(npcID)
						looted = true
					end
				end
			end
		end
	end
end

---============================================================================
-- Event: CHAT_MSG_MONSTER_EMOTE
-- Event: CHAT_MSG_MONSTER_YELL
-- Fired when a monster emotes (red/brown message on chat)
---============================================================================
local function SimulateRareFound(rareScannerButton, npcID, mapID, name)
	if (RSNpcDB.GetInternalNpcInfo(npcID)) then
		local x, y = RSNpcDB.GetInternalNpcCoordinates(npcID, mapID)
		if (not x or not y) then
			x, y = RSNpcDB.GetBestInternalNpcCoordinates(npcID, mapID)
		end
		rareScannerButton:SimulateRareFound(npcID, nil, name, x, y, RSConstants.NPC_VIGNETTE, RSConstants.TRACKING_SYSTEM.CHAT_EMOTE)
	end
end

local function OnChatMsgMonster(rareScannerButton, message, name, guid)
	-- If not disabled
	if (not RSConfigDB.IsScanningChatAlerts()) then
		return
	end
	
	RSLogger:PrintDebugMessage(string.format("CHAT_MSG_MONSTER: [MESSAGE:%s]", message))
	
	local mapID = C_Map.GetBestMapForUnit("player")
	if (not mapID) then
		return
	end
	
	RSLogger:PrintDebugMessage(string.format("CHAT_MSG_MONSTER: [MAPID:%s]", mapID))
	
	-- Try to analyze the GUID
	if (guid) then
		RSLogger:PrintDebugMessage(string.format("CHAT_MSG_MONSTER: [GUID:%s]", guid))
		
		local _, _, _, _, _, id = strsplit("-", guid)
		local npcID = id and tonumber(id) or nil
		if (npcID) then
			local finalNpcID = RSNpcDB.GetFinalNpcID(npcID)
			SimulateRareFound(rareScannerButton, finalNpcID, mapID, RSNpcDB.GetNpcName(finalNpcID))
			return
		end
	end
	
	-- Try to analyze the Name
	if (name) then
		RSLogger:PrintDebugMessage(string.format("CHAT_MSG_MONSTER: [NAME:%s]", name))
		
		local npcID = RSNpcDB.GetNpcId(name, mapID)
		if (npcID) then
			SimulateRareFound(rareScannerButton, npcID, mapID, name)
			return
		end
	end
	
	-- Otherwise analyze the message
	for msg, npcID in pairs(private.MONSTER_EMOTE) do
		if (RSUtils.Contains(message, msg)) then
			RSLogger:PrintDebugMessage(string.format("CHAT_MSG_MONSTER: [FOUND:%s]", npcID))
			SimulateRareFound(rareScannerButton, npcID, mapID, RSNpcDB.GetNpcName(npcID))
			return
		end
	end
end

---============================================================================
-- Event: QUEST_TURNED_IN
-- Fired when a quest is turned in
---============================================================================

local function OnQuestTurnedIn(rareScannerButton, questID, xpReward, moneyReward)
	RSLogger:PrintDebugMessage(string.format("Misión [%s]. Completada.", questID))
	RSGeneralDB.SetCompletedQuest(questID)

	-- Checks if its an event
	local foundDebug = false
	for eventID, eventInfo in pairs (private.EVENT_INFO) do
		if (eventInfo.questID and RSUtils.Contains(eventInfo.questID, questID)) then
			RSEntityStateHandler.SetEventCompleted(eventID)
			foundDebug = true
			return
		end
	end

	if (RSConstants.DEBUG_MODE and not foundDebug) then
		RSLogger:PrintDebugMessage("DEBUG: Mision completada que no existe en EVENT_QUEST_IDS "..questID)
	end
end

---============================================================================
-- Event: CINEMATIC_START
-- Fired when a cinematic starts
---============================================================================

local function OnCinematicStart(rareScannerButton)
	RSGeneralDB.SetCinematicPlaying(true)

	if (rareScannerButton:IsVisible()) then
		rareScannerButton:HideButton()
	end
end

---============================================================================
-- Event: CINEMATIC_STOP
-- Fired when a cinematic stops
---============================================================================

local function OnCinematicStop(rareScannerButton)
	RSGeneralDB.SetCinematicPlaying(false)
end

---============================================================================
-- Event: NEW_MOUNT_ADDED
-- Fired when a new mount is added to the collection
---============================================================================

local function OnNewMountAdded(mountID)
	RSCollectionsDB.RemoveNotCollectedMount(mountID, function()
		RSExplorerFrame:Refresh()
	end)
end

---============================================================================
-- Event: NEW_PET_ADDED
-- Fired when a new pet is added to the collection
---============================================================================

local function OnNewPetAdded(petGUID)
	RSCollectionsDB.RemoveNotCollectedPet(petGUID, function()
		RSExplorerFrame:Refresh()
	end)
end

---============================================================================
-- Event: NEW_TOY_ADDED
-- Fired when a new toy is added to the collection
---============================================================================

local function OnNewToyAdded(itemID)
	RSCollectionsDB.RemoveNotCollectedToy(itemID, function()
		RSExplorerFrame:Refresh()
	end)
end

---============================================================================
-- Event: TRANSMOG_COLLECTION_UPDATED
-- Fired when a new appearance is added to the collection
---============================================================================

local function OnTransmogCollectionUpdated()
	local latestAppearanceID, _ = C_TransmogCollection.GetLatestAppearance();
	RSCollectionsDB.RemoveNotCollectedAppearance(latestAppearanceID, function()
		RSExplorerFrame:Refresh()
	end)
end

local function OnAchievementCriteriaEarned(achievementID)
	local refresh = false;
	for i=1, GetAchievementNumCriteria(achievementID) do
		local _, _, completed = GetAchievementCriteriaInfo(achievementID, i)
	   	if (completed) then
	   		-- If container/NPC
	   		if (private.ACHIEVEMENT_TARGET_IDS[achievementID]) then
				for _, entityID in ipairs(private.ACHIEVEMENT_TARGET_IDS[achievementID]) do
					local containerInfo = RSContainerDB.GetInternalContainerInfo(entityID)
					if (containerInfo) then
						if (containerInfo.criteria == i and not RSContainerDB.IsContainerOpened(entityID)) then
							RSLogger:PrintDebugMessage(string.format("Contenedor con criteria [%s][%s]. Completado.", achievementID, entityID))
							RSContainerDB.SetContainerOpened(entityID)
							RSMinimap.RefreshEntityState(entityID)
							refresh = true
						end
					else
						local npcInfo = RSNpcDB.GetInternalNpcInfo(entityID)
						if (npcInfo) then
							if (npcInfo.criteria == i and not RSNpcDB.IsNpcKilled(entityID)) then
								RSLogger:PrintDebugMessage(string.format("NPC con criteria [%s][%s]. Completado.", achievementID, entityID))
								RSNpcDB.SetNpcKilled(entityID)
								RSMinimap.RefreshEntityState(entityID)
								refresh = true
							end
						end
					end
				end
			end
		end
	end
	
	-- Update achievements cache
	if (refresh) then
		RSAchievementDB.RefreshAchievementCache(achievementID)
	end
end

---============================================================================
-- Event: CRITERIA_EARNED
-- Fired when a part of an achievement is earned
---============================================================================

local function OnCriteriaEarned(parentAchievementID, description)
	if (parentAchievementID) then
		RSLogger:PrintDebugMessage(string.format("Criteria del logro [%s][%s]. Completado.", parentAchievementID, description))
		if (RSUtils.Contains(private.ACHIEVEMENT_WITH_CRITERIA, parentAchievementID)) then
			OnAchievementCriteriaEarned(parentAchievementID)
		end
	end
end

---============================================================================
-- Event: UNIT_SPELLCAST_SUCCEEDED
-- Fired when a part of an achievement is earned
---============================================================================

local function OnUnitSpellcastSucceeded(unitTarget, castGUID, spellID)
	if (spellID) then
		-- Achievements
		if (private.ACHIEVEMENT_SPELL_IDS[spellID]) then
			OnAchievementCriteriaEarned(private.ACHIEVEMENT_SPELL_IDS[spellID])
		end
	end
end

---============================================================================
-- Event: PLAYER_LOGIN
-- Fired when the player logs in the game
---============================================================================

local function OnPlayerLogin(rareScannerButton)
	local x, y = RSGeneralDB.GetButtonPositionCoordinates()
	if (x and y) then
		rareScannerButton:ClearAllPoints()
		rareScannerButton:SetPoint("BOTTOMLEFT", x, y)
	end

	-- Adds custom chat window
	if (RSConfigDB.GetChatWindowName()) then
		RSLogger:CreateChatFrame(RSConfigDB.GetChatWindowName())
	end

	-- Init macro
	RSMacro.CreateMacro()

	rareScannerButton:UnregisterEvent("PLAYER_LOGIN")
end

---============================================================================
-- Event: PET_BATTLE_CLOSE
-- Fired when the player closes a pet battle
---============================================================================

local function OnPetBattleClose()
	-- For whatever reason the minimap icons are lost after closing a pet battle, so it forzes to show them again
	RSMinimap.RefreshAllData(true)
end

---============================================================================
-- Event: ITEM_TEXT_CLOSED
-- Fired when a finishing reading a text
---============================================================================

local function OnItemTextClose()
	local routines = {}
	local mapID = C_Map.GetBestMapForUnit("player")
	
	-- Many achievements require reading an object in the world, so check if the text closed belongs to any of these tracked achievements
	local achievementCriteriaRoutine = RSRoutines.LoopRoutineNew()
	achievementCriteriaRoutine:Init(function() return private.ACHIEVEMENT_WITH_CRITERIA end, 10,
		function(context, _, achievementID)
			if (not mapID or (mapID and private.ACHIEVEMENT_ZONE_IDS[mapID] and RSUtils.Contains(private.ACHIEVEMENT_ZONE_IDS[mapID], achievementID))) then
				OnAchievementCriteriaEarned(achievementID)
			end
		end, 
		function(context)			
			RSLogger:PrintDebugMessage("OnItemTextClose ejecutado")
		end
	)
	table.insert(routines, achievementCriteriaRoutine)
	
	-- Launch all the routines in order
	local chainRoutines = RSRoutines.ChainLoopRoutineNew()
	chainRoutines:Init(routines)
	chainRoutines:Run(function(context) end)
end

---============================================================================
-- Event handler
---============================================================================

local vignetteUpdatedDelay
local function HandleEvent(rareScannerButton, event, ...) 
	if (event == "PLAYER_LOGIN") then
		OnPlayerLogin(rareScannerButton)
	elseif (event == "NAME_PLATE_UNIT_ADDED") then
		OnNamePlateUnitAdded(rareScannerButton, ...)
	elseif (event == "UPDATE_MOUSEOVER_UNIT") then
		OnUpdateMouseoverUnit(rareScannerButton)
	elseif (event == "PLAYER_REGEN_ENABLED") then
		OnPlayerRegenEnabled(rareScannerButton)
	elseif (event == "COMBAT_LOG_EVENT_UNFILTERED") then
		OnCombatLogEventUnfiltered()
	elseif (event == "PLAYER_TARGET_CHANGED") then
		OnPlayerTargetChanged(rareScannerButton)
	elseif (event == "LOOT_OPENED") then
		OnLootOpened()
	elseif (event == "CHAT_MSG_MONSTER_YELL") then
		local message, name, _, _, _, _, _, _, _, _, _, guid = ...
		OnChatMsgMonster(rareScannerButton, message, name, guid)
	elseif (event == "CHAT_MSG_MONSTER_EMOTE") then
		local message, name, _, _, _, _, _, _, _, _, _, guid = ...
		OnChatMsgMonster(rareScannerButton, message, name, guid)
	elseif (event == "QUEST_TURNED_IN") then
		OnQuestTurnedIn(rareScannerButton, ...)
	elseif (event == "CINEMATIC_START") then
		OnCinematicStart(rareScannerButton)
	elseif (event == "CINEMATIC_STOP") then
		OnCinematicStop()
	elseif (event == "NEW_MOUNT_ADDED") then
		OnNewMountAdded(...)
	elseif (event == "NEW_PET_ADDED") then
		OnNewPetAdded(...)
	elseif (event == "NEW_TOY_ADDED") then
		OnNewToyAdded(...)
	elseif (event == "TRANSMOG_COLLECTION_UPDATED") then
		OnTransmogCollectionUpdated()
	elseif (event == "CRITERIA_EARNED") then
		OnCriteriaEarned(...)
	elseif (event == "UNIT_SPELLCAST_SUCCEEDED") then
		OnUnitSpellcastSucceeded(...)
	elseif (event == "PET_BATTLE_CLOSE") then
		OnPetBattleClose(...)
	elseif (event == "ITEM_TEXT_CLOSED") then
		OnItemTextClose(...)
	end
end

function RSEventHandler.RegisterEvents(rareScannerButton, addon)
	RareScanner = addon
	rareScannerButton:RegisterEvent("PLAYER_LOGIN")
	rareScannerButton:RegisterEvent("NAME_PLATE_UNIT_ADDED")
	rareScannerButton:RegisterEvent("UPDATE_MOUSEOVER_UNIT")
	rareScannerButton:RegisterEvent("PLAYER_REGEN_ENABLED")
	rareScannerButton:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	rareScannerButton:RegisterEvent("PLAYER_TARGET_CHANGED")
	rareScannerButton:RegisterEvent("LOOT_OPENED")
	rareScannerButton:RegisterEvent("CINEMATIC_START")
	rareScannerButton:RegisterEvent("CINEMATIC_STOP")
	rareScannerButton:RegisterEvent("CHAT_MSG_MONSTER_YELL")
	rareScannerButton:RegisterEvent("CHAT_MSG_MONSTER_EMOTE")
	rareScannerButton:RegisterEvent("QUEST_TURNED_IN")
	rareScannerButton:RegisterEvent("NEW_MOUNT_ADDED")
	rareScannerButton:RegisterEvent("NEW_PET_ADDED")
	rareScannerButton:RegisterEvent("NEW_TOY_ADDED")
	rareScannerButton:RegisterEvent("TRANSMOG_COLLECTION_UPDATED")
	rareScannerButton:RegisterEvent("CRITERIA_EARNED")
	rareScannerButton:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
	rareScannerButton:RegisterEvent("PET_BATTLE_CLOSE")
	rareScannerButton:RegisterEvent("ITEM_TEXT_CLOSED")

	-- Captures all events
	rareScannerButton:SetScript("OnEvent", function(self, event, ...)
		HandleEvent(self, event, ...) 
	end)
end