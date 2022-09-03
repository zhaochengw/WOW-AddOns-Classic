-----------------------------------------------------------------------
-- AddOn namespace.
-----------------------------------------------------------------------
local LibStub = _G.LibStub
local RareScanner
local ADDON_NAME, private = ...

-- Range checker
local rc = LibStub("LibRangeCheck-2.0")

local RSEventHandler = private.NewLib("RareScannerEventHandler")

-- RareScanner database libraries
local RSConfigDB = private.ImportLib("RareScannerConfigDB")
local RSGeneralDB = private.ImportLib("RareScannerGeneralDB")
local RSMapDB = private.ImportLib("RareScannerMapDB")
local RSNpcDB = private.ImportLib("RareScannerNpcDB")
local RSContainerDB = private.ImportLib("RareScannerContainerDB")

-- RareScanner services
local RSMinimap = private.ImportLib("RareScannerMinimap")

-- RareScanner internal libraries
local RSConstants = private.ImportLib("RareScannerConstants")
local RSLogger = private.ImportLib("RareScannerLogger")
local RSUtils = private.ImportLib("RareScannerUtils")


---============================================================================
-- Handle entities without vignette
---============================================================================

local function HandleEntityWithoutVignette(rareScannerButton, unitID)
	if (not unitID) then
		return
	end
	
	local unitGuid = UnitGUID(unitID)
	if (not unitGuid) then
		return
	end
	
	local unitType, _, _, _, _, entityID = strsplit("-", unitGuid)
	if (unitType == "Creature") then
		local npcID = entityID and tonumber(entityID) or nil
	
		-- Get mapID
		local mapID = C_Map.GetBestMapForUnit("player")
		local inInstance, _ = IsInInstance()
		
		-- Check if NPC in dungeon, in wich case we get fake mapIDs
		if (not mapID or inInstance) then
			local npcInfo = RSNpcDB.GetInternalNpcInfo(npcID)
			if (npcInfo and npcInfo.zoneID and private.DUNGEONS_IDS[npcInfo.zoneID]) then
				local nameplateUnitName, _ = UnitName(unitID)
				rareScannerButton:SimulateRareFound(npcID, unitGuid, nameplateUnitName, 0, 0, RSConstants.NPC_VIGNETTE)
			end
			
			return
		end
	
		-- If its a supported NPC and its not killed
		if ((RSGeneralDB.GetAlreadyFoundEntity(npcID) or RSNpcDB.GetInternalNpcInfo(npcID))) then			
			local nameplateUnitName, _ = UnitName(unitID)
			local x, y
			
			-- It uses the player position in first instance
			local playerMapPosition = C_Map.GetPlayerMapPosition(mapID, "player")
			if (playerMapPosition) then
				x, y = playerMapPosition:GetXY()
			end
	
			-- Otherwise uses the internal coordinates
			-- In dungeons and such its not possible to get the player position
			if (not x or not y) then
				x, y = RSNpcDB.GetInternalNpcCoordinates(npcID, mapID)
			end
	
			rareScannerButton:SimulateRareFound(npcID, unitGuid, nameplateUnitName, x, y, RSConstants.NPC_VIGNETTE)
	
			-- And then try to find better coordinates while the player approaches
			local minRange, maxRange = rc:GetRange(unitID)
			if (playerMapPosition and (minRange or maxRange)) then
				C_Timer.NewTicker(RSConstants.FIND_BETTER_COORDINATES_WITH_RANGE_TIMER, function()
					local minRange, maxRange = rc:GetRange(unitID)
					if (minRange and minRange < 10) then
						RSGeneralDB.UpdateAlreadyFoundEntityPlayerPosition(npcID)
					end
				end, 15)
			end
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
end

---============================================================================
-- Event: NAME_PLATE_UNIT_ADDED
-- Fired when a nameplate appears
---============================================================================

local function OnNamePlateUnitAdded(rareScannerButton, namePlateID)
	if (namePlateID and not UnitIsUnit("player", namePlateID)) then
		HandleEntityWithoutVignette(rareScannerButton, namePlateID)
	end
end

---============================================================================
-- Event: UPDATE_MOUSEOVER_UNIT
-- Fired when mouseovering a unit
---============================================================================

local function OnUpdateMouseoverUnit(rareScannerButton)
	if (not UnitIsUnit("player", "mouseover")) then
		HandleEntityWithoutVignette(rareScannerButton, "mouseover")
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
-- Event: PLAYER_TARGET_CHANGED
-- Fired when changing the target
---============================================================================

local function OnPlayerTargetChanged()
	if (UnitExists("target")) then
		local unitType, _, _, _, _, entityID = strsplit("-", UnitGUID("target"))
		if (unitType == "Creature") then
			local npcID = entityID and tonumber(entityID) or nil
	
			-- Check if we have the NPC in our database but the addon didnt detect it because nameplates wheren't on
			if (not RSGeneralDB.GetAlreadyFoundEntity(npcID) and RSNpcDB.GetInternalNpcInfo(npcID)) then
				RSGeneralDB.AddAlreadyFoundNpcWithoutVignette(npcID)
			end
	
			-- Update coordinates and last time seen
			if (RSGeneralDB.GetAlreadyFoundEntity(npcID)) then
				RSGeneralDB.UpdateAlreadyFoundEntityPlayerPosition(npcID)
				RSGeneralDB.UpdateAlreadyFoundEntityTime(npcID)
			end
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

	local containerLooted = false
	for i = 1, numItems do
		if (LootSlotHasItem(i)) then
			local destGUID = GetLootSourceInfo(i)
			local unitType, _, _, _, _, id = strsplit("-", destGUID)

			-- If the loot comes from a container that we support
			if (unitType == "GameObject") then
				local containerID = id and tonumber(id) or nil

				-- We support all the containers with vignette plus those ones that are part of achievements (without vignette)
				if (RSGeneralDB.GetAlreadyFoundEntity(containerID) or RSContainerDB.GetInternalContainerInfo(containerID)) then
					-- Sets the container as opened
					-- We are looping through all the items looted, we dont want to call this method with every item
					if (not containerLooted) then
						RSLogger:PrintDebugMessage(string.format("Abierto [%s].", containerID or ""))
				
						-- Check if we have the Container in our database but the addon didnt detect it
						-- This will happend in the case where the container doesnt have a vignette
						if (not RSGeneralDB.GetAlreadyFoundEntity(containerID)) then
							RSGeneralDB.AddAlreadyFoundContainerWithoutVignette(containerID)
						else
							RSGeneralDB.UpdateAlreadyFoundEntityPlayerPosition(containerID)
						end
					
						containerLooted = true
					end

					-- Records the loot obtained
					local itemLink = GetLootSlotLink(i)
					if (itemLink) then
						local _, _, _, lootType, id, _, _, _, _, _, _, _, _, _, name = string.find(itemLink, "|?c?f?f?(%x*)|?H?([^:]*):?(%d+):?(%d*):?(%d*):?(%d*):?(%d*):?(%d*):?(%-?%d*):?(%-?%d*):?(%d*):?(%d*)|?h?%[?([^%[%]]*)%]?|?h?|?r?")
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
				if (RSGeneralDB.GetAlreadyFoundEntity(npcID)) then
					local itemLink = GetLootSlotLink(i)
					if (itemLink) then
						local _, _, _, lootType, id, _, _, _, _, _, _, _, _, _, name = string.find(itemLink, "|?c?f?f?(%x*)|?H?([^:]*):?(%d+):?(%d*):?(%d*):?(%d*):?(%d*):?(%d*):?(%-?%d*):?(%-?%d*):?(%d*):?(%d*)|?h?%[?([^%[%]]*)%]?|?h?|?r?")
						if (lootType == "item") then
							local itemID = id and tonumber(id) or nil
							RSNpcDB.AddItemToNpcLootFound(npcID, itemID)
						end
					end
				end
			end
		end
	end
end

---============================================================================
-- Event: CINEMATIC_START
-- Fired when a cinematic starts
---============================================================================

local isCinematicPlaying = false
local function OnCinematicStart(rareScannerButton)
	isCinematicPlaying = true
	if (rareScannerButton:IsVisible()) then
		rareScannerButton:HideButton()
	end
end

---============================================================================
-- Event: CINEMATIC_STOP
-- Fired when a cinematic stops
---============================================================================

local function OnCinematicStop(rareScannerButton)
	isCinematicPlaying = false
end

function RSEventHandler.IsCinematicPlaying()
	return isCinematicPlaying
end

---============================================================================
-- Event handler
---============================================================================

local function HandleEvent(rareScannerButton, event, ...) 
	if (event == "PLAYER_LOGIN") then
		OnPlayerLogin(rareScannerButton)
	elseif (event == "NAME_PLATE_UNIT_ADDED") then
		OnNamePlateUnitAdded(rareScannerButton, ...)
	elseif (event == "UPDATE_MOUSEOVER_UNIT") then
		OnUpdateMouseoverUnit(rareScannerButton)
	elseif (event == "PLAYER_REGEN_ENABLED") then
		OnPlayerRegenEnabled(rareScannerButton)
	elseif (event == "PLAYER_TARGET_CHANGED") then
		OnPlayerTargetChanged()
	elseif (event == "LOOT_OPENED") then
		OnLootOpened()
	elseif (event == "CINEMATIC_START") then
		OnCinematicStart(rareScannerButton)
	elseif (event == "CINEMATIC_STOP") then
		OnCinematicStop()
	end
end

function RSEventHandler.RegisterEvents(rareScannerButton, addon)
	RareScanner = addon
	rareScannerButton:RegisterEvent("PLAYER_LOGIN")
	rareScannerButton:RegisterEvent("NAME_PLATE_UNIT_ADDED")
	rareScannerButton:RegisterEvent("UPDATE_MOUSEOVER_UNIT")
	rareScannerButton:RegisterEvent("PLAYER_REGEN_ENABLED")
	rareScannerButton:RegisterEvent("PLAYER_TARGET_CHANGED")
	rareScannerButton:RegisterEvent("LOOT_OPENED")
	rareScannerButton:RegisterEvent("CINEMATIC_START")
	rareScannerButton:RegisterEvent("CINEMATIC_STOP")

	-- Captures all events
	rareScannerButton:SetScript("OnEvent", function(self, event, ...)
		HandleEvent(self, event, ...) 
	end)
end