-----------------------------------------------------------------------
-- AddOn namespace.
-----------------------------------------------------------------------
local ADDON_NAME, private = ...

local LibStub = _G.LibStub
local AL = LibStub("AceLocale-3.0"):GetLocale("RareScanner", false)

local RSCustomNpcs = private.NewLib("RareScannerCustomNpcs")

-- RareScanner database libraries
local RSMapDB = private.ImportLib("RareScannerMapDB")
local RSNpcDB = private.ImportLib("RareScannerNpcDB")
local RSGeneralDB = private.ImportLib("RareScannerGeneralDB")
local RSCollectionsDB = private.ImportLib("RareScannerCollectionsDB")

-- RareScanner general libraries
local RSConstants = private.ImportLib("RareScannerConstants")
local RSUtils = private.ImportLib("RareScannerUtils")
local RSTooltipScanners = private.ImportLib("RareScannerTooltipScanners")
local RSRoutines = private.ImportLib("RareScannerRoutines")

-- RareScanner service libraries
local RSMinimap = private.ImportLib("RareScannerMinimap")

-----------------------------------------------------------------------
-- Functions to delete custom NPCs
-----------------------------------------------------------------------

function RSCustomNpcs.GetGroupKey(group)
	return "GROUP"..group
end

function RSCustomNpcs.GetNpcKey(npcID)
	return "NPC"..npcID
end

function RSCustomNpcs.DeleteCustomNpc(npcID, options)
	local npcInfo = RSNpcDB.GetCustomNpcInfo(tonumber(npcID))
	if (not npcInfo) then
		return
	end
	
	RSNpcDB.DeleteCustomNpcInfo(npcID)
	RSGeneralDB.RemoveAlreadyFoundEntity(tonumber(npcID))
	if (RSCollectionsDB.GetAllEntitiesCollectionsLoot() and RSCollectionsDB.GetAllEntitiesCollectionsLoot()[RSConstants.ITEM_SOURCE.NPC] and RSCollectionsDB.GetAllEntitiesCollectionsLoot()[RSConstants.ITEM_SOURCE.NPC][tonumber(npcID)]) then
		RSCollectionsDB.GetAllEntitiesCollectionsLoot()[RSConstants.ITEM_SOURCE.NPC][tonumber(npcID)] = nil
		RSExplorerFrame:Refresh()
	end
	
	-- Update options panel
	if (options) then
		local groupKey = RSCustomNpcs.GetGroupKey(npcInfo.group or RSConstants.DEFAULT_GROUP)
		local npcKey = RSCustomNpcs.GetNpcKey(npcID)
		
		private.options_cnpcs[groupKey][npcKey] = nil
		options.args[groupKey].args[npcKey] = nil
		
		-- If the group is empty also delete it
		if (RSUtils.GetTableLength(private.options_cnpcs[groupKey]) == 0) then
			options.args[groupKey] = nil
			private.options_cnpcs[groupKey] = nil
		end
	end
	
	-- Update minimap
	RSMinimap.HideIcon(tonumber(npcID))
end

-----------------------------------------------------------------------
-- Functions to import
-----------------------------------------------------------------------

local function AddLineError(errorLine, string, errorMessage)
	if (RSUtils.GetTableLength(errorLine) == 0) then
		tinsert(errorLine, string.format("%s", string))
	end
	
	tinsert(errorLine, string.format("# |A:common-icon-redx:10:10::::|a %s", errorMessage))
end

function RSCustomNpcs.ImportNpcs(text, options, callback)
	local output = {}
	
	-- Skips if text is empty
	if (not text or strtrim(text) == '') then
		callback(output)
		return
	end
	
	-- Splits lines	
	local lines = {}
	for s in text:gmatch("[^\r\n]+") do
		tinsert(lines, s)
	end
	
	-- Process each line
	local skiplableNumLines = 0
	local importRoutine = RSRoutines.LoopIndexRoutineNew()
	importRoutine:Init(function() return #lines end, 15, 
		function(context, index)
			local s = strtrim(lines[index])
			
			-- Ignore if it starts with #
			if (not RSUtils.StartsWith(s, "#")) then
				local npcErrorLines = {}
				local newNpcInfo = {}
				newNpcInfo.zones = {}
				newNpcInfo.items = {}
				
				-- Extracts params
				local npcID, mapCoordsString, lootString, displayID, groupName = strsplit(" ", s, 5)
				
				-- Validate NPCID
				local npcIDcorrect = false
				if (not npcID or strtrim(npcID) == '') then
					AddLineError(npcErrorLines, s, AL["CUSTOM_NPC_ERROR1_NPCID"])
				elseif (tonumber(npcID) == nil) then
					AddLineError(npcErrorLines, s, string.format(AL["CUSTOM_NPC_ERROR2_NPCID"], npcID))
				elseif (not RSNpcDB.GetCustomNpcInfo(tonumber(npcID)) and RSNpcDB.GetInternalNpcInfo(tonumber(npcID))) then
					AddLineError(npcErrorLines, s, string.format(AL["CUSTOM_NPC_ERROR4_NPCID"], npcID))
				else
					npcIDcorrect = true
				end
				
				-- Validate MAP_COORDS
				if (mapCoordsString) then
					-- Skip if asterisk
					if (strtrim(mapCoordsString) ~= '*') then
						-- Validate each set of MAPID:COORDS
						for mapIdCoords in string.gmatch(mapCoordsString, '([^|]+)') do
							local mapIDcorrect = false
							
							-- Validate MAPID
							local mapID, coords = strsplit(":", mapIdCoords, 2)
							if (not mapID or strtrim(mapID) == '') then
								AddLineError(npcErrorLines, s, AL["CUSTOM_NPC_ERROR1_MAPID"])
							elseif (tonumber(mapID) == nil or RSUtils.Contains(mapID,"%.")) then
								AddLineError(npcErrorLines, s, string.format(AL["CUSTOM_NPC_ERROR2_MAPID"], mapID))
							else
								local mapFound = false
								for _, continentInfo in pairs(RSMapDB.GetContinents()) do
									if (RSUtils.Contains(continentInfo.zones, tonumber(mapID))) then
										mapFound = true
										break
									end
								end
								
								if (not mapFound) then
									AddLineError(npcErrorLines, s, string.format(AL["CUSTOM_NPC_ERROR3_MAPID"], mapID))
								else
									newNpcInfo.zones[mapID] = {}
									mapIDcorrect = true
								end
							end
							
							-- Validate COORDS
							if (coords) then
								for coord in string.gmatch(coords, '([^,]+)') do
									local x, y = strsplit("-", coord, 2)
									if (not x or strtrim(x) == '') then
										AddLineError(npcErrorLines, s, AL["CUSTOM_NPC_ERROR1_COORDX"])
									elseif (tonumber(x) == nil or RSUtils.Contains(x,"%.")) then
										AddLineError(npcErrorLines, s, string.format(AL["CUSTOM_NPC_ERROR2_COORDX"], x))
									elseif (strlen(x) ~= 4) then
										AddLineError(npcErrorLines, s, string.format(AL["CUSTOM_NPC_ERROR3_COORDX"], x))
									end
									if (not y or strtrim(y) == '') then
										AddLineError(npcErrorLines, s, AL["CUSTOM_NPC_ERROR1_COORDY"])
									elseif (tonumber(y) == nil or RSUtils.Contains(y,"%.")) then
										AddLineError(npcErrorLines, s, string.format(AL["CUSTOM_NPC_ERROR2_COORDY"], y))
									elseif (strlen(y) ~= 4) then
										AddLineError(npcErrorLines, s, string.format(AL["CUSTOM_NPC_ERROR3_COORDY"], y))
									end
								end
								
								if (mapIDcorrect) then
									if (not newNpcInfo.coordinates) then
										newNpcInfo.coordinates = {}
									end
									
									newNpcInfo.coordinates[mapID] = coords
								end
							end
						end
					else
						newNpcInfo.zones[RSConstants.ALL_ZONES_CUSTOM_NPC] = {}
					end
				else
					newNpcInfo.zones[RSConstants.ALL_ZONES_CUSTOM_NPC] = {}
				end
				
				-- Validate LOOT
				if (lootString) then
					-- Skip if asterisk
					if (strtrim(lootString) ~= '*') then
						-- Validate each ITEMID
						for itemID in string.gmatch(lootString, '([^,]+)') do
							if (not itemID or strtrim(itemID) == '') then
								AddLineError(npcErrorLines, s, AL["CUSTOM_NPC_ERROR1_ITEMID"])
							elseif (tonumber(itemID) == nil or RSUtils.Contains(itemID,"%.")) then
								AddLineError(npcErrorLines, s, string.format(AL["CUSTOM_NPC_ERROR2_ITEMID"], itemID))
							else
								tinsert(newNpcInfo.items, tonumber(itemID))
							end
						end
					end
				end
				
				-- Validate DISPLAYID
				if (displayID) then
					-- Skip if asterisk
					if (strtrim(displayID) ~= '*') then
						if (tonumber(displayID) == nil or RSUtils.Contains(displayID,"%.")) then
							AddLineError(npcErrorLines, s, string.format(AL["CUSTOM_NPC_ERROR1_DISPLAYID"], displayID))
						else
							newNpcInfo.displayID = displayID
						end
					end
				end
				
				-- Validate GROUP
				if (groupName) then
					-- Skip if asterisk
					if (strtrim(groupName) ~= '*') then
						if (strlen(strtrim(groupName)) > 20) then
							AddLineError(npcErrorLines, s, string.format(AL["CUSTOM_NPC_ERROR1_GROUP"], groupName))
						else
							-- Reuse if exists
							newNpcInfo.group = RSNpcDB.GetCustomNpcGroupByValue(groupName)
						end
					else
						newNpcInfo.group = RSConstants.DEFAULT_GROUP
						
						-- Adds default group if it was removed
						if (not RSNpcDB.GetCustomNpcGroupByKey(RSConstants.DEFAULT_GROUP)) then
							RSNpcDB.SetCustomNpcGroupByKey(RSConstants.DEFAULT_GROUP, AL["CUSTOM_NPC_GROUP_DEFAULT"])
						end
					end
				else
					newNpcInfo.group = RSConstants.DEFAULT_GROUP
					
					-- Adds default group if it was removed
					if (not RSNpcDB.GetCustomNpcGroupByKey(RSConstants.DEFAULT_GROUP)) then
						RSNpcDB.SetCustomNpcGroupByKey(RSConstants.DEFAULT_GROUP, AL["CUSTOM_NPC_GROUP_DEFAULT"])
					end
				end
				
				-- Check if NPC exists
				if (npcIDcorrect) then
					RSTooltipScanners.ScanNpcName(npcID, function(npcName)
						if (not npcName) then
							AddLineError(npcErrorLines, s, string.format(AL["CUSTOM_NPC_ERROR3_NPCID"], npcID))
						elseif (RSUtils.GetTableLength(npcErrorLines) == 0) then
							-- Deletes just in case it already exists
							if (options) then
								RSCustomNpcs.DeleteCustomNpc(npcID, options)
							end
							
							-- If the group doesn't exist, create it first
							if (not newNpcInfo.group and not RSNpcDB.GetCustomNpcGroupByValue(groupName)) then
								newNpcInfo.group = RSNpcDB.AddCustomNpcGroup(groupName)
							end
			
							-- Inserts again
							RSNpcDB.SetCustomNpcInfo(npcID, newNpcInfo)
							
							if (RSUtils.GetTableLength(newNpcInfo.items) > 0) then
								RSNpcDB.SetCustomNpcLoot(npcID, newNpcInfo.items)
								RSCollectionsDB.UpdateEntityCollectibles(tonumber(npcID), newNpcInfo.items, RSConstants.ITEM_SOURCE.NPC)
							end
						
							tinsert(output, string.format("# |A:common-icon-checkmark:10:10::::|a %s", string.format(AL["CUSTOM_NPC_IMPORT_OK"], s)))
						else
							for _, string in pairs(npcErrorLines) do
								tinsert(output, string)
							end
						end
						
						callback(output)
					end)
				else
					for _, string in pairs(npcErrorLines) do
						tinsert(output, string)
					end
					callback(output)
				end
			else
				skiplableNumLines = skiplableNumLines + 1
			end
		end, 
		function(context)
			-- If all lines skipable call callback	
			if (skiplableNumLines == #lines) then
				callback()
			end
		end
	)
	
	local chainRoutines = RSRoutines.ChainLoopRoutineNew()
	chainRoutines:Init({ importRoutine })
	chainRoutines:Run(function(context) end)
end

-----------------------------------------------------------------------
-- Functions to export
-----------------------------------------------------------------------

local function ExportGroupString(npcID)
	local npcInfo = RSNpcDB.GetCustomNpcInfo(tonumber(npcID))
	
	local groupName = ""
	if (npcInfo.group and npcInfo.group ~= RSConstants.DEFAULT_GROUP) then
		groupName = RSNpcDB.GetCustomNpcGroupByKey(npcInfo.group)
	end
	
	return groupName
end

local function ExportDisplayIdString(npcID)
	local npcInfo = RSNpcDB.GetCustomNpcInfo(tonumber(npcID))
	
	local displayID = ""
	if (npcInfo.displayID and npcInfo.displayID ~= 0) then
		displayID = npcInfo.displayID
	end
	
	return displayID
end

local function ExportLootString(npcID)
	local npcLoot = RSNpcDB.GetCustomNpcLoot(npcID)
	
	local lootString = ""
	if (npcLoot) then
		lootString = table.concat(npcLoot, ",")
	end
	
	return lootString
end

local function ExportMapCoordsString(npcID)
	local npcInfo = RSNpcDB.GetCustomNpcInfo(tonumber(npcID))
	
	local maps = {}
	if (type(npcInfo.zoneID) == "table") then
		for mapID, mapInfo in pairs (npcInfo.zoneID) do
			if (mapID == RSConstants.ALL_ZONES_CUSTOM_NPC) then
				maps = {}
				break
			elseif (mapInfo.overlay) then
				maps[mapID] = table.concat(mapInfo.overlay, ",")
			else
				maps[mapID] = ""
			end
		end
	else
		if (npcInfo.zoneID == RSConstants.ALL_ZONES_CUSTOM_NPC) then
			maps = {}
		elseif (npcInfo.overlay) then
			maps[npcInfo.zoneID] = table.concat(npcInfo.overlay, ",")
		else
			maps[npcInfo.zoneID] = ""
		end
	end
	
	local mapString = ""
	if (RSUtils.GetTableLength(maps) > 0) then
		local mapStrings = {}
		for mapID, coords in pairs(maps) do
			if (coords and coords ~= "") then
				tinsert(mapStrings, string.format("%s:%s", mapID, coords))
			else
				tinsert(mapStrings, mapID)
			end
		end
		mapString = table.concat(mapStrings, "|")
	end
	
	return mapString
end

function RSCustomNpcs.ExportCustomNpc(npcID)
	local npcInfo = RSNpcDB.GetCustomNpcInfo(tonumber(npcID))
	
	-- Export map/coords
	local mapString = ExportMapCoordsString(npcID)
	
	-- Export loot
	local lootString = ExportLootString(npcID)
	
	-- Export displayID
	local displayIdString = ExportDisplayIdString(npcID)
	
	-- Export group
	local groupString = ExportGroupString(npcID)
	
	local text = {}
	tinsert(text, npcID)
	
	if (mapString == "" and (lootString ~= "" or displayIdString ~= "" or groupString ~= "")) then
		tinsert(text, "*")
	else
		tinsert(text, mapString)
	end
	
	if (lootString == "" and (displayIdString ~= "" or groupString ~= "")) then
		tinsert(text, "*")
	else
		tinsert(text, lootString)
	end
	
	if (displayIdString == "" and groupString ~= "") then
		tinsert(text, "*")
	else
		tinsert(text, displayIdString)
	end
	
	tinsert(text, groupString)
	
	return strtrim(table.concat(text, " "))
end

function RSCustomNpcs.ExportCustomGroup(group)
	local text = {}
	for npcID, npcInfo in pairs (RSNpcDB.GetAllCustomNpcInfo()) do
		if ((not npcInfo.group and group == RSConstants.DEFAULT_GROUP) or (npcInfo.group == group)) then
			tinsert(text, RSCustomNpcs.ExportCustomNpc(npcID))
		end
	end
	
	if (RSUtils.GetTableLength(text) > 0) then
		return table.concat(text, "\n")
	end
	
	return ""
end