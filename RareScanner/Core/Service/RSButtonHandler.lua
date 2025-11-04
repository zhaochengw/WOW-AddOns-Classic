-----------------------------------------------------------------------
-- AddOn namespace.
-----------------------------------------------------------------------
local LibStub = _G.LibStub
local ADDON_NAME, private = ...

local RSButtonHandler = private.NewLib("RareScannerButtonHandler")

-- Locales
local AL = LibStub("AceLocale-3.0"):GetLocale("RareScanner");

-- RareScanner database libraries
local RSNpcDB = private.ImportLib("RareScannerNpcDB")
local RSConfigDB = private.ImportLib("RareScannerConfigDB")
local RSGeneralDB = private.ImportLib("RareScannerGeneralDB")
local RSContainerDB = private.ImportLib("RareScannerContainerDB")
local RSEventDB = private.ImportLib("RareScannerEventDB")
local RSGuideDB = private.ImportLib("RareScannerGuideDB")

-- RareScanner internal libraries
local RSConstants = private.ImportLib("RareScannerConstants")
local RSUtils = private.ImportLib("RareScannerUtils")

-- RareScanner services
local RSMinimap = private.ImportLib("RareScannerMinimap")
local RSNotificationTracker = private.ImportLib("RareScannerNotificationTracker")
local RSLogger = private.ImportLib("RareScannerLogger")
local RSEventHandler = private.ImportLib("RareScannerEventHandler")
local RSRecentlySeenTracker = private.ImportLib("RareScannerRecentlySeenTracker")
local RSAudioAlerts = private.ImportLib("RareScannerAudioAlerts")

-- RareScanner other addons integration services
local RSTomtom = private.ImportLib("RareScannerTomtom")

-- Timers
local BUTTON_TIMER
local PREFOUND_TIMER

---============================================================================
-- Queue found alerts
---============================================================================

local foundAlerts = {}
local preFoundAlerts = {}

---============================================================================
-- Auxiliar functions
---============================================================================

local function GetVignetteInfoGUID(vignetteInfo)
	if (vignetteInfo.vignetteGUID) then
		return vignetteInfo.vignetteGUID
	end
	
	return vignetteInfo.objectGUID
end

local function FixVignetteInfo(vignetteInfo)
	local _, _, _, _, _, id, _ = strsplit("-", vignetteInfo.objectGUID);
	local entityID = tonumber(id)
	
	if (not entityID) then
		return
	end
	
	local mapID = RSGeneralDB.GetBestMapForUnit(entityID, vignetteInfo.atlasName)
	
	-- Check if it is an event to summon another NPC. In that case display NPC information instead
	if (RSConstants.NPCS_WITH_PRE_EVENT[entityID]) then
		local rareNpcID = RSNpcDB.GetFinalNpcID(entityID)
		RSGeneralDB.RemoveAlreadyFoundEntity(entityID)
		vignetteInfo.name = RSNpcDB.GetNpcName(rareNpcID)
		vignetteInfo.atlasName = RSConstants.NPC_VIGNETTE
		entityID = rareNpcID
		vignetteInfo.preEvent = true
	end
	
	-- Check if it is an event so summon another CONTAINER. In that case display CONTAINER information instead
	if (RSConstants.CONTAINERS_WITH_PRE_EVENT[entityID]) then
		local containerID = RSContainerDB.GetFinalContainerID(entityID)
		RSGeneralDB.RemoveAlreadyFoundEntity(entityID)
		local containerName = RSContainerDB.GetContainerName(containerID)
		if (containerName) then
			vignetteInfo.name = containerName
		end
		
		vignetteInfo.atlasName = RSConstants.CONTAINER_VIGNETTE
		entityID = containerID
		vignetteInfo.preEvent = true
	end
	
	-- Overrides name if Torghast vignette and not a known event
	if (vignetteInfo.type and vignetteInfo.type == Enum.VignetteType.Torghast and not RSUtils.Contains(RSConstants.EVENTS_WITH_NPC_VIGNETTE, entityID)) then
		local npcName = RSNpcDB.GetNpcName(entityID)
		if (npcName) then
			vignetteInfo.name = npcName
		end
	end
	
	-- Check if container with NPC vignette
	if (RSUtils.Contains(RSConstants.CONTAINER_WITH_NPC_VIGNETTE, entityID) or RSContainerDB.GetInternalContainerInfo(entityID)) then
		vignetteInfo.atlasName = RSConstants.CONTAINER_VIGNETTE
	end

	-- These NPCs are tagged with events
	if (RSUtils.Contains(RSConstants.NPCS_WITH_EVENT_VIGNETTE, entityID)) then
		vignetteInfo.atlasName = RSConstants.NPC_VIGNETTE
	end

	-- These NPCs are tagged with containers
	if (RSUtils.Contains(RSConstants.NPCS_WITH_CONTAINER_VIGNETTE, entityID)) then
		vignetteInfo.atlasName = RSConstants.NPC_VIGNETTE
	end
	
	-- These events are tagged with npcs
	if (RSUtils.Contains(RSConstants.EVENTS_WITH_NPC_VIGNETTE, entityID)) then
		vignetteInfo.atlasName = RSConstants.EVENT_VIGNETTE
	end

	-- These containers are tagged with rare NPCs
	if (RSUtils.Contains(RSConstants.CONTAINERS_WITH_NPC_VIGNETTE, entityID)) then
		vignetteInfo.atlasName = RSConstants.CONTAINER_VIGNETTE
	end
	
	-- These containers are tagged with events
	if (RSUtils.Contains(RSConstants.CONTAINERS_WITH_EVENT_VIGNETTE, entityID)) then
		vignetteInfo.atlasName = RSConstants.CONTAINER_VIGNETTE
	end
	
	-- There is one container without name in Shadowlands
	if (RSConstants.IsContainerAtlas(vignetteInfo.atlasName) and (not vignetteInfo.name or string.gsub(vignetteInfo.name, "", "") == "")) then
		vignetteInfo.name = AL["CONTAINER"]
	end
	
	return entityID, vignetteInfo
end

---============================================================================
-- Show button alerts
---============================================================================

local function UpdateRareFound(entityID, vignetteInfo, coordinates)
	-- Calculates all the parameters
	local atlasName

	-- If its a NPC
	local mapID = nil
	if (RSConstants.IsNpcAtlas(vignetteInfo.atlasName)) then
		atlasName = RSConstants.NPC_VIGNETTE

		-- MapID always try to get it first from the internal database
		-- GetBestMapForUnit not always returns the expected value!
		local npcInfo = RSNpcDB.GetInternalNpcInfo(entityID)
		if (RSNpcDB.IsInternalNpcMonoZone(entityID) and npcInfo.zoneID ~= 0) then
			mapID = npcInfo.zoneID
		else
			mapID = C_Map.GetBestMapForUnit("player")
		end
	-- If its a container
	elseif (RSConstants.IsContainerAtlas(vignetteInfo.atlasName)) then
		atlasName = RSConstants.CONTAINER_VIGNETTE

		-- MapID always try to get it first from the internal database
		-- GetBestMapForUnit not always returns the expected value!
		local containerInfo = RSContainerDB.GetInternalContainerInfo(entityID)
		if (RSContainerDB.IsInternalContainerMonoZone(entityID) and containerInfo.zoneID ~= 0) then
			mapID = containerInfo.zoneID
		else
			mapID = C_Map.GetBestMapForUnit("player")
		end
	-- If its an event
	elseif (RSConstants.IsEventAtlas(vignetteInfo.atlasName)) then
		atlasName = RSConstants.EVENT_VIGNETTE

		-- MapID always try to get it first from the internal database
		-- GetBestMapForUnit not always returns the expected value!
		local eventInfo = RSEventDB.GetInternalEventInfo(entityID)
		if (RSEventDB.IsInternalEventMonoZone(entityID) and eventInfo.zoneID ~= 0) then
			mapID = eventInfo.zoneID
		else
			mapID = C_Map.GetBestMapForUnit("player")
		end
	else
		return
	end

	if (not mapID or mapID == 0) then
		RSLogger:PrintDebugMessage(string.format("UpdateRareFound[%s]: Error! No se ha podido calcular el mapID para la entidad recien encontrada!", entityID))
		return
	end

	-- Extract the coordinates from the parameter if we are simulating a vignette, or from a real vignette info
	local vignettePosition = nil
	if (coordinates and coordinates.x and coordinates.y) then
		vignettePosition = coordinates
	elseif (not vignetteInfo.simulated) then
		vignettePosition = C_VignetteInfo.GetVignettePosition(vignetteInfo.vignetteGUID, mapID)

		if (not vignettePosition) then
			for i=1,9999,1 do 
				vignettePosition = C_VignetteInfo.GetVignettePosition(vignetteInfo.vignetteGUID, i)
				if (vignettePosition) then
					break
				end
			end
		end
	end

	if (not vignettePosition) then
		RSLogger:PrintDebugMessage(string.format("UpdateRareFound[%s]: Error! No se han podido calcular las coordenadas para la entidad recien encontrada en el mapa [%s]!", entityID, mapID and mapID or ""))
		return
	end

	local artID = C_Map.GetMapArtID(mapID)

	-- Updates if it was found before
	if (RSGeneralDB.GetAlreadyFoundEntity(entityID)) then
		RSGeneralDB.UpdateAlreadyFoundEntity(entityID, mapID, vignettePosition.x, vignettePosition.y, artID, atlasName)
		-- Adds if its the first time found
	else
		RSGeneralDB.AddAlreadyFoundEntity(entityID, mapID, vignettePosition.x, vignettePosition.y, artID, atlasName)
	end
	
	return vignettePosition
end

local function ShowAlert(button, vignetteInfo, isNavigating)
	local entityID, vignetteInfo = FixVignetteInfo(vignetteInfo)
	local mapID = RSGeneralDB.GetBestMapForUnit(entityID, vignetteInfo.atlasName)

	local vignettePosition = {}
	if (not isNavigating) then
		-- Ignore if hidden quest is completed
		if (RSConfigDB.IsIgnoringCompletedEntities()) then
			if (RSConstants.IsNpcAtlas(vignetteInfo.atlasName)) then
				if (RSNpcDB.GetInternalNpcInfo(entityID) and RSNpcDB.GetInternalNpcInfo(entityID).questID) then
					for _, questID in ipairs(RSNpcDB.GetInternalNpcInfo(entityID).questID) do
						if (C_QuestLog.IsQuestFlaggedCompleted(questID)) then
							RSLogger:PrintDebugMessage(string.format("Detectado NPC [%s] con misión oculta completa, se ignora.", entityID))
							return
						end
					end
				end
			elseif (RSConstants.IsContainerAtlas(vignetteInfo.atlasName)) then
				if (RSContainerDB.GetInternalContainerInfo(entityID) and RSContainerDB.GetInternalContainerInfo(entityID).questID) then
					for _, questID in ipairs(RSContainerDB.GetInternalContainerInfo(entityID).questID) do
						if (C_QuestLog.IsQuestFlaggedCompleted(questID)) then
							RSLogger:PrintDebugMessage(string.format("Detectado Contenedor [%s] con misión oculta completa, se ignora.", entityID))
							return
						end
					end
				end
			end
		end
		
		-- If the vignette is simulated
		if (vignetteInfo.x and vignetteInfo.y) then
			vignettePosition.x = vignetteInfo.x
			vignettePosition.y = vignetteInfo.y
			UpdateRareFound(entityID, vignetteInfo, vignettePosition)
		else
			vignettePosition = UpdateRareFound(entityID, vignetteInfo)
			
			-- If the entity doesn't have coordinates (for example a custom NPC) set a random coordinate set so at least it shows the notification
			if (not vignettePosition) then
				if (RSConstants.IsNpcAtlas(vignetteInfo.atlasName)) then
					vignettePosition = {}
					vignettePosition.x = -1
					vignettePosition.y = -1
				else
					return
				end
			end
		end

		-- If we have it as dead but we got a notification it means that the restart time is wrong (this is normal when playing while a world quest reset)
		if (RSNpcDB.IsNpcKilled(entityID)) then
			RSLogger:PrintDebugMessage(string.format("El NPC [%s] estaba marcado como muerto, pero lo acabamos de detectar vivo, resucitado!", entityID))
			RSNpcDB.DeleteNpcKilled(entityID)
		end
		
		-- disable ALL alerts for containers
		if (RSConstants.IsContainerAtlas(vignetteInfo.atlasName) and not RSConfigDB.IsScanningForContainers()) then
			RSLogger:PrintDebugMessage(string.format("El contenedor [%s] se ignora por haber deshabilitado alertas de contenedores", entityID))
			return
		-- disable alerts for filtered containers. Check if the container is filtered, in which case we don't show anything
		elseif (RSConstants.IsContainerAtlas(vignetteInfo.atlasName) and RSConfigDB.IsContainerFiltered(entityID)) then
			RSLogger:PrintDebugMessage(string.format("El contenedor [%s] se ignora por estar filtrado (completo)", entityID))
			return
		-- disable alerts for rare NPCs
		elseif (RSConstants.IsNpcAtlas(vignetteInfo.atlasName) and not RSConfigDB.IsScanningForNpcs()) then
			RSLogger:PrintDebugMessage(string.format("El NPC [%s] se ignora por haber deshabilitado alertas de NPCs", entityID))
			return
		-- disable alerts for filtered rare NPCs (completely)
		elseif (RSConstants.IsNpcAtlas(vignetteInfo.atlasName) and RSConfigDB.IsNpcFiltered(entityID)) then
			RSLogger:PrintDebugMessage(string.format("El NPC [%s] se ignora por estar filtrado (completo)", entityID))
			return
		-- disable alerts for filtered rare NPCs (alerts)
		elseif (RSConstants.IsNpcAtlas(vignetteInfo.atlasName) and RSConfigDB.IsNpcFilteredOnlyAlerts(entityID)) then
			RSLogger:PrintDebugMessage(string.format("El NPC [%s] se ignora por estar filtrado (alertas)", entityID))
			RSRecentlySeenTracker.AddRecentlySeen(entityID, vignetteInfo.atlasName, false)
			return true
		-- disable alerts for events
		elseif (RSConstants.IsEventAtlas(vignetteInfo.atlasName) and not RSConfigDB.IsScanningForEvents()) then
			RSLogger:PrintDebugMessage(string.format("El evento [%s] se ignora por haber deshabilitado alertas de eventos", entityID))
			return
		-- disable alerts for filtered events (completely)
		elseif (RSConstants.IsEventAtlas(vignetteInfo.atlasName) and RSConfigDB.IsEventFiltered(entityID)) then
			RSLogger:PrintDebugMessage(string.format("El evento [%s] se ignora por estar filtrado (completo)", entityID))
			return
		-- disable alerts for filtered events (alerts)
		elseif (RSConstants.IsEventAtlas(vignetteInfo.atlasName) and RSConfigDB.IsEventFilteredOnlyAlerts(entityID)) then
			RSLogger:PrintDebugMessage(string.format("El evento [%s] se ignora por estar filtrado (alertas)", entityID))
			RSRecentlySeenTracker.AddRecentlySeen(entityID, vignetteInfo.atlasName, false)
			return true
		-- disable alerts for filtered zones
		elseif (RSConfigDB.IsZoneFiltered(mapID) or RSConfigDB.IsZoneFilteredOnlyAlerts(mapID) or RSConfigDB.IsEntityZoneFilteredOnlyAlerts(entityID, vignetteInfo.atlasName, mapID)) then
			RSLogger:PrintDebugMessage(string.format("La entidad [%s] se ignora por pertenecer a una zona [%s] filtrada", entityID, mapID))
			return
		-- extra checkings for containers
		elseif (RSConstants.IsContainerAtlas(vignetteInfo.atlasName)) then		
			-- save containers to show it on the world map
			RSContainerDB.SetContainerName(entityID, vignetteInfo.name)
	
			-- some containers belong to places where rares die forever
			-- and anyway, this containers can respawn every day
			-- so if this is the case, mark it as an exception
			if (RSContainerDB.IsContainerOpened(entityID)) then
				RSContainerDB.SetContainerReseteable(entityID)
				RSContainerDB.DeleteContainerOpened(entityID)
				RSLogger:PrintDebugMessage(string.format("Contenedor [%s]. Detectado como reseteable (cuando no lo estaba)", entityID))
			end
			
			-- disable visual/sound alerts for filtered containers
			if (RSConfigDB.IsContainerFilteredOnlyAlerts(entityID)) then
				RSRecentlySeenTracker.AddRecentlySeen(entityID, vignetteInfo.atlasName, false)
				return true
			end
	
			-- disable button alert for containers
			if (not RSConfigDB.IsButtonDisplayingForContainers()) then
				RSRecentlySeenTracker.AddRecentlySeen(entityID, vignetteInfo.atlasName, false)
				RSTomtom.AddTomtomAutomaticWaypoint(mapID, vignettePosition.x, vignettePosition.y, vignetteInfo.name)
	
				if (RSNotificationTracker.IsAlreadyNotificated(vignetteInfo.id, false, entityID)) then
					RSLogger:PrintDebugMessage(string.format("El contenedor [%s] se ignora porque se ha avisado de esta hace menos de 2 minutos", entityID))
					return
				else
					RSNotificationTracker.AddNotification(vignetteInfo.id, false, entityID)
					
					if (RSConfigDB.IsFlashingWindowsTaskbar()) then
						FlashClientIcon()
					end
					
					RSAudioAlerts.PlaySoundAlert(vignetteInfo.atlasName)
					button:DisplayMessages(entityID, vignetteInfo.preEvent and string.format(AL["PRE_EVENT"], vignetteInfo.name) or vignetteInfo.name)
					return
				end
			end
		-- extra checkings for events
		elseif (RSConstants.IsEventAtlas(vignetteInfo.atlasName)) then
			-- check just in case its an NPC
			if (not RSNpcDB.GetInternalNpcInfo(entityID)) then
				RSEventDB.SetEventName(entityID, vignetteInfo.name)
			end
		end

		-- Sets the current vignette as new found
		RSNotificationTracker.AddNotification(vignetteInfo.id, isNavigating, entityID)
	else
		vignettePosition.x = vignetteInfo.x
		vignettePosition.y = vignetteInfo.y
	end

	--------------------------------
	-- show messages and play alarm
	--------------------------------
	if (not isNavigating) then
		if (RSConfigDB.IsFlashingWindowsTaskbar()) then
			FlashClientIcon()
		end
				
		button:DisplayMessages(entityID, vignetteInfo.preEvent and string.format(AL["PRE_EVENT"], vignetteInfo.name) or vignetteInfo.name)
		RSAudioAlerts.PlaySoundAlert(vignetteInfo.atlasName)
	end

	------------------------
	-- set up new button
	------------------------
	if (RSConfigDB.IsButtonDisplaying()) then
		-- Adds the new NPCID to the navigation list
		if (RSConfigDB.IsDisplayingNavigationArrows() and not isNavigating) then
			button.NextButton:AddNext(mapID, vignettePosition.x, vignettePosition.y, vignetteInfo.name, vignetteInfo.atlasName, vignetteInfo.objectGUID)
		end

		-- Show the button
		if (not button:IsShown() or isNavigating or not RSConfigDB.IsDisplayingNavigationArrows() or not RSConfigDB.IsNavigationLockEnabled()) then
			button.entityID = entityID
			-- Sometimes the vignette name doesn't match the servers name
			-- Let's try to use always the servers
			if (RSConstants.IsNpcAtlas(vignetteInfo.atlasName)) then
				local npcName = RSNpcDB.GetNpcName(entityID)
				button.name = npcName and npcName or vignetteInfo.name
			elseif (RSConstants.IsContainerAtlas(vignetteInfo.atlasName)) then
				local containerName = RSContainerDB.GetContainerName(entityID)
				button.name = containerName and containerName or vignetteInfo.name
			else
				local eventName = RSEventDB.GetEventName(entityID)
				button.name = eventName and eventName or vignetteInfo.name
			end
			
			button.mapID = mapID
			button.preEvent = vignetteInfo.preEvent
			button.atlasName = vignetteInfo.atlasName

			local npcInfo = RSNpcDB.GetInternalNpcInfo(entityID)
			button.displayID = npcInfo and npcInfo.displayID or nil
			button.x = vignettePosition.x
			button.y = vignettePosition.y

			-- Show button / miniature / loot bar if not in combat
			if (not InCombatLockdown()) then
				-- Wow API doesnt allow to call Show() (protected function) if you are under attack, so
				-- we check if this is the situation to avoid it and show the frames
				-- once the battle is over (pendingToShow)
				button:ShowButton()
			else
				-- Mark to show after combat
				button.pendingToShow = true
			end
		elseif (RSConfigDB.IsDisplayingNavigationArrows() and RSConfigDB.IsNavigationLockEnabled()) then
			-- reset the time to auto hide (so it takes into account the new entity found)
			button:StartHideTimer()

			-- Refresh the navigation arrows
			if (button.NextButton:EnableNextButton()) then
				button.NextButton:Show()
			else
				button.NextButton:Hide()
			end

			if (button.PreviousButton:EnablePreviousButton()) then
				button.PreviousButton:Show()
			else
				button.PreviousButton:Hide()
			end
		end
	end

	-- If navigation disabled, control Tomtom waypoint externally
	if (not RSConfigDB.IsButtonDisplaying() or not RSConfigDB.IsDisplayingNavigationArrows()) then
		RSTomtom.AddTomtomAutomaticWaypoint(mapID, vignettePosition.x, vignettePosition.y, vignetteInfo.name)
	end

	-- Add recently seen
	RSRecentlySeenTracker.AddRecentlySeen(entityID, vignetteInfo.atlasName, isNavigating)
	
	-- Enable guidance icons
	if (RSConfigDB.IsShowingAutoGuidanceIcons()) then
		local guide = false
		if (RSConstants.IsNpcAtlas(vignetteInfo.atlasName)) then
			guide = RSGuideDB.GetNpcGuide(entityID, mapID)
		elseif (RSConstants.IsContainerAtlas(vignetteInfo.atlasName)) then
			guide = RSGuideDB.GetContainerGuide(entityID, mapID)
		else
			guide = RSGuideDB.GetEventGuide(entityID, mapID)
		end
		
		local guideEntityID = RSGeneralDB.GetGuideActive()
		if (guideEntityID) then
			RSGeneralDB.RemoveGuideActive()
			RSMinimap.RemoveGuide(guideEntityID)
		end
		
		if (guide) then
			RSGeneralDB.SetGuideActive(entityID)
			RSMinimap.AddGuide(entityID)
		end
	end

	-- Refresh minimap
	return true
end

local function ShowAlerts(button)
	local refreshMinimap
	for k, vignetteInfo in pairs (foundAlerts) do
		if (ShowAlert(button, vignetteInfo, false) and not refreshMinimap) then
			refreshMinimap = true
		end
		
	    foundAlerts[k] = nil
		--RSLogger:PrintDebugMessage(string.format("Eliminado %s", k))
	end
	
	if (refreshMinimap) then
		--RSLogger:PrintDebugMessage(string.format("Refrescado minimapa tras mostrar todas las alertas"))
		RSMinimap.RefreshAllData(true)
	end
	
	if (RSUtils.GetTableLength(foundAlerts) > 0) then
		--RSLogger:PrintDebugMessage(string.format("Quedan alertas que mostrar"))
		ShowAlerts(button)
	else
		-- Cancel
		--RSLogger:PrintDebugMessage(string.format("BUTTON_TIMER:Cancel"))
		BUTTON_TIMER:Cancel()
	end
end

---============================================================================
-- Alerts handler
---============================================================================

function RSButtonHandler.AddAlert(button, vignetteInfo, isNavigating)
	if (not vignetteInfo) then
		RSLogger:PrintDebugMessage("Se ha intentado notificar algo para lo que no ha llegado vignetteInfo")
		return
	end
	
	--RSLogger:PrintDebugMessage(string.format("Vignette ATLAS [%s][%s]", vignetteInfo.atlasName, vignetteInfo.objectGUID))
	
	-- Fix vignette INFO for those vignettes with errors
	local entityID, vignetteInfo = FixVignetteInfo(vignetteInfo)
	if (not entityID or not vignetteInfo) then
		return
	end
	
	-- Avoid alerting for the same entity detected by different systems at the same time
	if (not isNavigating) then
		local trackingSystem = vignetteInfo.trackingSystem
		if (not vignetteInfo.simulated) then
			trackingSystem = RSConstants.TRACKING_SYSTEM.VIGNETTE
		end
		if (preFoundAlerts[entityID]) then
				--RSLogger:PrintDebugMessage(string.format("prefound existente para [%s] con sistema [%s] y nuevamente con sistema [%s] .", entityID, preFoundAlerts[entityID].trackingSystem, trackingSystem))
			if (preFoundAlerts[entityID].trackingSystem ~= trackingSystem) then
				--RSLogger:PrintDebugMessage(string.format("Ignorada alerta de [%s] por haberse detectado con otro sistema en menos de 5 segundos.", entityID))
				return
			end
		else
			preFoundAlerts[entityID] = { trackingSystem = trackingSystem, expireTime = time() + RSConstants.PREFOUND_TIMER }
		end
	end
	
	-- Apply filters
	local mapID = RSGeneralDB.GetBestMapForUnit(entityID, vignetteInfo.atlasName)
	local isInstance, _ = IsInInstance()
	
	-- Check it it is an entity that use a vignette but it isn't a rare, event or treasure
	if (RSUtils.Contains(RSConstants.IGNORED_VIGNETTES, entityID)) then
		--RSLogger:PrintDebugMessageEntityID(entityID, string.format("La entidad [%s] se ignora por estar ignorada", entityID))
		return
	-- Check if it should be ignored with a tracking system different than vignettes
	elseif (vignetteInfo.trackingSystem and vignetteInfo.trackingSystem ~= RSConstants.TRACKING_SYSTEM.VIGNETTE and RSUtils.Contains(RSConstants.IGNORED_TRACKING_SYSTEMS_NOT_VIGNETTE, entityID)) then
		--RSLogger:PrintDebugMessageEntityID(entityID, string.format("La entidad [%s] se ignora porque se ha detectado con un sistema de rastreao distinto de viñetas [%s]", entityID, vignetteInfo.trackingSystem))
		return
	-- Check if we have already found this vignette in a short period of time
	elseif (RSNotificationTracker.IsAlreadyNotificated(vignetteInfo.id, isNavigating, entityID, vignetteInfo.trackingSystem)) then
		--RSLogger:PrintDebugMessageEntityID(entityID, string.format("La entidad [%s] se ignora porque se ha avisado de esta hace menos de %s minutos", entityID, RSConfigDB.GetRescanTimer()))
		return
	-- disable scanning for every entity that is not treasure, event or rare
	elseif (not RSConstants.IsScanneableAtlas(vignetteInfo.atlasName)) then
		--RSLogger:PrintDebugMessageEntityID(entityID, string.format("Se ignora el atlas [%s] que no es escaneable", vignetteInfo.atlasName))
		return
	-- disable ALL alerts while cinematic is playing
	elseif (RSGeneralDB.GetCinematicPlaying()) then
		--RSLogger:PrintDebugMessageEntityID(entityID, string.format("La entidad [%s] se ignora por estar reproduciendose un video", entityID))
		return
	-- disable ALL alerts in instances
	elseif (isInstance == true and not isNavigating and not RSConfigDB.IsScanningInInstances()) then
		--RSLogger:PrintDebugMessageEntityID(entityID, string.format("La entidad [%s] se ignora por estar en una instancia", entityID))
		return
	-- disable alerts while flying
	elseif (UnitOnTaxi("player") and not RSConfigDB.IsScanningWhileOnTaxi()) then
		--RSLogger:PrintDebugMessageEntityID(entityID, string.format("La entidad [%s] se ignora por estar montado en un transporte", entityID))
		return
	-- disable alerts while in pet combat
	elseif (C_PetBattles.IsInBattle() and not RSConfigDB.IsScanningWhileOnPetBattle()) then
		--RSLogger:PrintDebugMessageEntityID(entityID, string.format("La entidad [%s] se ignora por estar en medio de un combate de mascotas", entityID))
		return
	end
	
	-- While navigating show right away
	if (isNavigating) then
		ShowAlert(button, vignetteInfo, isNavigating)
	-- Otherwise queue and show with a timer
	else
		--RSLogger:PrintDebugMessage(string.format("Detectado [%s]", GetVignetteInfoGUID(vignetteInfo)))
		foundAlerts[GetVignetteInfoGUID(vignetteInfo)] = vignetteInfo
		
		if (not BUTTON_TIMER or BUTTON_TIMER:IsCancelled()) then
			BUTTON_TIMER = C_Timer.NewTimer(RSConstants.BUTTON_TIMER, function()
				ShowAlerts(button)
			end)
		end
		if (not PREFOUND_TIMER) then
			PREFOUND_TIMER = C_Timer.NewTicker(RSConstants.PREFOUND_TIMER, function()
				for entityID, info in pairs(preFoundAlerts) do
					if (info.expireTime < time()) then
						preFoundAlerts[entityID] = nil
					end
				end
			end)
		end
	end
end