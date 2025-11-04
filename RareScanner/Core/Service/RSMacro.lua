-----------------------------------------------------------------------
-- AddOn namespace.
-----------------------------------------------------------------------
local LibStub = _G.LibStub
local ADDON_NAME, private = ...

-- Locales
local AL = LibStub("AceLocale-3.0"):GetLocale("RareScanner");

local RSMacro = private.NewLib("RareScannerMacro")

-- RareScanner database libraries
local RSConfigDB = private.ImportLib("RareScannerConfigDB")
local RSNpcDB = private.ImportLib("RareScannerNpcDB")
local RSMapDB = private.ImportLib("RareScannerMapDB")

-- RareScanner services
local RSMap = private.ImportLib("RareScannerMap")

-- RareScanner internal libraries
local RSConstants = private.ImportLib("RareScannerConstants")
local RSUtils = private.ImportLib("RareScannerUtils")
local RSLogger = private.ImportLib("RareScannerLogger")

---============================================================================
-- Create Macro functions
---============================================================================

local lastPlayerMapID, lastPlayerX, lastPlayerY
local nearbyNpcIDs
local macroTooLong = true
local timer
local macro

function RSMacro.IsAvailableMacroSlot()
	return GetNumMacros() < 119
end

function RSMacro.CreateMacro()
	if (not RSConfigDB.IsScanningWithMacro()) then
		return
	end
	
	if (InCombatLockdown()) then
		return
	end
	
	if (not GetMacroInfo(RSConstants.RARESCANNER_MACRO_NAME)) then
        CreateMacro(RSConstants.RARESCANNER_MACRO_NAME, GetFileIDFromPath(RSConstants.RARESCANNER_MACRO_ICON), "")
        RSLogger:PrintMessage(string.format(AL["ENABLE_SCAN_MACRO_CREATED"], RSConstants.RARESCANNER_MACRO_NAME, string.format("|T%s:14|t", RSConstants.RARESCANNER_MACRO_ICON)))
    end
    
    -- Ticker to auto refresh the macro
    if (not timer or timer:IsCancelled()) then
		timer = C_Timer.NewTicker(RSConstants.RARESCANNER_MACRO_REFRESH_TIMER, function()
    		RSMacro.UpdateMacro()
   	 	end)
	end
end

function RSMacro.DeleteMacro()    
    if (timer) then
		timer:Cancel()
	end
	
	if (not GetMacroInfo(RSConstants.RARESCANNER_MACRO_NAME)) then
		return
    end
    
	if (not InCombatLockdown()) then
   		DeleteMacro(RSConstants.RARESCANNER_MACRO_NAME)
   	end
end

---============================================================================
-- Update Macro functions
---============================================================================

local function RefreshNpcIDs(mapID)
	lastPlayerMapID = mapID
	
	-- Search only for custom NPCs
	if (not RSMapDB.IsZoneWithoutVignette(mapID)) then
		nearbyNpcIDs = RSNpcDB.GetNpcIDsByMapID(mapID, true, true)
	-- Search for everything
	else
		nearbyNpcIDs = RSNpcDB.GetNpcIDsByMapID(mapID)
	end
end

local function GetNotFilteredNpcName(npcID)
	if (RSConfigDB.IsNpcFiltered(npcID) or RSConfigDB.IsNpcFilteredOnlyAlerts(npcID)) then
		return nil
	end
	
	return RSNpcDB.GetNpcName(npcID)
end

local function IsNpcNearby(npcID, mapID, playerx, playery)
	if (playerx and playery) then
		local npcInfo = RSNpcDB.GetInternalNpcInfoByMapID(npcID, mapID)
		if (not npcInfo) then
			return false
		end
		
		if (npcInfo.overlay) then
			for _, coordinates in ipairs (npcInfo.overlay) do
				local xo, yo = strsplit("-", coordinates)
				local distance = RSUtils.DistanceBetweenCoords(playerx, RSUtils.FixCoord(xo), playery, RSUtils.FixCoord(yo));
				if (distance >= 0 and distance <= RSConstants.RARESCANNER_MACRO_TARGET_MAX_DISTANCE) then
					--RSLogger:PrintDebugMessage(string.format("NPC (OVERLAY) [%s], distancia del jugador [%s]", RSNpcDB.GetNpcName(npcID), distance))
					return true
				end
			end
		else
			local distance = RSUtils.DistanceBetweenCoords(playerx, npcInfo.x, playery, npcInfo.y);
			if (distance >= 0 and distance <= RSConstants.RARESCANNER_MACRO_TARGET_MAX_DISTANCE) then
				--RSLogger:PrintDebugMessage(string.format("NPC (COORDS) [%s], distancia del jugador [%s]", RSNpcDB.GetNpcName(npcID), distance))
				return true
			end
		end
	end
	
	return false
end

function RSMacro.UpdateMacro()
	if (not RSConfigDB.IsScanningWithMacro()) then
		return
	end
	
	-- Regenerate just in case the player deleted it
	if (not GetMacroInfo(RSConstants.RARESCANNER_MACRO_NAME)) then
		if (RSMacro.IsAvailableMacroSlot()) then
			RSMacro.CreateMacro()
		end
		
		-- Forces to update
		macroTooLong = true
		lastPlayerX = nil
		lastPlayerY = nil
	end
	
	-- Refresh NPCID list
	local playerMapID = C_Map.GetBestMapForUnit("player")
	if (not playerMapID) then
		return
	end
	
	-- Cache map to avoid constant updates
	if (not lastPlayerMapID or lastPlayerMapID ~= playerMapID) then
		RefreshNpcIDs(playerMapID)
	-- Don't update if every NPC was added in the previous UPDATE, then dont do anything
	elseif (not macroTooLong) then
		--RSLogger:PrintDebugMessage("No es necesario refrescar la macro porque ha cabido entera")
		return
	-- Don't update if the player hasn't moved or didn't move too far
	elseif (lastPlayerX and lastPlayerY) then
		local playerMapPosition = C_Map.GetPlayerMapPosition(playerMapID, "player")
		local playerx, playery
		if (playerMapPosition) then
			playerx, playery = playerMapPosition:GetXY()
		end
		
		if (playerx and playery) then
			local distance = RSUtils.DistanceBetweenCoords(playerx, lastPlayerX, playery, lastPlayerY);
			if (distance == 0 or distance < RSConstants.RARESCANNER_MACRO_UPDATE_NPCS_DISTANCE) then
				--RSLogger:PrintDebugMessage(string.format("No se refresca macro pues el usuario se ha movido solo [%s]", distance))
				return
			end
		end
	end
	
	-- Update target macro
	if (RSUtils.GetTableLength(nearbyNpcIDs) > 0) then
		macroTooLong = false
		
		-- Try to add every active NPC in the map
		for _, npcID in ipairs(nearbyNpcIDs) do
			local npcName = GetNotFilteredNpcName(npcID)
			if (npcName) then
				if (macro) then
	                macro = string.format('%s\n/targetexact %s', macro, npcName)
	            else
	                macro = string.format('/targetexact %s', npcName)
	            end
	            
	            if (#macro > 255) then
	            	macro = nil
	            	macroTooLong = true
	            	break
	            end
	    	end
		end
		
		-- Try to add every nearby active NPC in the map
		if (macroTooLong) then
			local playerMapPosition = C_Map.GetPlayerMapPosition(playerMapID, "player")
			local playerx, playery
			if (playerMapPosition) then
				playerx, playery = playerMapPosition:GetXY()
			end
			
			if (playerx and playery) then			
				-- Cache position of the player
				lastPlayerX = playerx
				lastPlayerY = playery
				
				for _, npcID in ipairs(nearbyNpcIDs) do
					local npcName = GetNotFilteredNpcName(npcID)
					if (npcName and IsNpcNearby(npcID, playerMapID, playerx, playery)) then
						--RSLogger:PrintDebugMessage(string.format("Añadiendo a la macro [%s]", npcName))
						if (macro) then
			                macro = string.format('%s\n/targetexact %s', macro, npcName)
			            else
			                macro = string.format('/targetexact %s', npcName)
			            end
			
						-- If too long removes latest element and stops adding
						if (#macro > 255) then
			                macro = macro:gsub("\n[^\\n]*$", "")
							--RSLogger:PrintDebugMessage(string.format("Macro demasiado larga, se recorta [%s]", macro))
			                break
			            end
			    	end
				end
			end
		end
		
		-- Refresh macro
		if (not InCombatLockdown()) then
			--RSLogger:PrintDebugMessage(string.format("Macro actualizada [%s]", macro))
			EditMacro(RSConstants.RARESCANNER_MACRO_NAME, RSConstants.RARESCANNER_MACRO_NAME, nil, macro)
		end
	end
end