-----------------------------------------------------------------------
-- AddOn namespace.
-----------------------------------------------------------------------
local ADDON_NAME, private = ...

local LibStub = _G.LibStub
local RareScanner = LibStub("AceAddon-3.0"):GetAddon("RareScanner")
local AL = LibStub("AceLocale-3.0"):GetLocale("RareScanner", false)
local RSACD = LibStub("AceConfigDialog-3.0")

local RSCustomNpcsOptions = private.NewLib("RareScannerCustomNpcsOptions")

-- RareScanner database libraries
local RSConfigDB = private.ImportLib("RareScannerConfigDB")
local RSMapDB = private.ImportLib("RareScannerMapDB")
local RSNpcDB = private.ImportLib("RareScannerNpcDB")
local RSGeneralDB = private.ImportLib("RareScannerGeneralDB")
local RSCollectionsDB  = private.ImportLib("RareScannerCollectionsDB")

-- RareScanner internal libraries
local RSConstants = private.ImportLib("RareScannerConstants")
local RSUtils = private.ImportLib("RareScannerUtils")

-- RareScanner service libraries
local RSMap = private.ImportLib("RareScannerMap")
local RSCustomNpcs = private.ImportLib("RareScannerCustomNpcs")
local RSTargetUnitTracker = private.ImportLib("RareScannerTargetUnitTracker")

local options

-----------------------------------------------------------------------
-- Import frame
-----------------------------------------------------------------------

local importNpcsFrame = CreateFrame("Frame", "RSImportNpcsFrame", SettingsPanel, "DialogBoxFrame")
importNpcsFrame:ClearAllPoints()
importNpcsFrame:SetPoint("TOPLEFT", SettingsPanel, "TOPLEFT")
importNpcsFrame:SetPoint("BOTTOMRIGHT", SettingsPanel, "BOTTOMRIGHT")
importNpcsFrame:SetScript("OnEnter", function() end)
    
-- scroll frame
local importNpcsScrollFrame = CreateFrame("ScrollFrame", "RSImportNpcsScrollFrame", importNpcsFrame, "UIPanelScrollFrameTemplate")
importNpcsScrollFrame:SetPoint("LEFT", 16, 0)
importNpcsScrollFrame:SetPoint("RIGHT", -33, 0)
importNpcsScrollFrame:SetPoint("TOP", 0, -12)
importNpcsScrollFrame:SetPoint("BOTTOM", RSImportNpcsFrameButton, "TOP", 0, 0)

-- edit box
local importNpcsEditBox = CreateFrame("EditBox", "RSImportNpcsEditBox", importNpcsScrollFrame)
importNpcsEditBox:SetSize(importNpcsScrollFrame:GetSize())
importNpcsEditBox:SetMultiLine(true)
importNpcsEditBox:SetAutoFocus(true)
importNpcsEditBox:SetFontObject("ChatFontNormal")
importNpcsEditBox:SetScript("OnEscapePressed", function() importNpcsFrame:Hide() end)
importNpcsScrollFrame:SetScrollChild(importNpcsEditBox)

-----------------------------------------------------------------------
-- Functions
-----------------------------------------------------------------------

local continent_map_ids

local function GetNpcID(npcKey)
	return strsub(npcKey,4)
end

local function GetContinentMapIds()
	if (not continent_map_ids) then
		continent_map_ids = {}
		
		for k, v in pairs(RSMapDB.GetContinents()) do
			if (v.zonefilter) then
				if (v.id) then
					continent_map_ids[k] = RSMap.GetMapName(k)
				else
					continent_map_ids[k] = AL["ZONES_CONTINENT_LIST"][k]
				end
			end
		end
		
		-- add wild zone
		continent_map_ids[RSConstants.ALL_ZONES_CUSTOM_NPC] = AL["ALL_ZONES"]
	end
	
	return continent_map_ids
end

local function LoadSubmapCombo(continentID, group, npcID)
	if (continentID) then
		local groupKey = RSCustomNpcs.GetGroupKey(group)
		local npcKey = RSCustomNpcs.GetNpcKey(npcID)
	
		options.args[groupKey].args[npcKey].args.subzones.values = {}
		private.options_cnpcs[groupKey][npcKey].subzone = nil
		
		if (continentID == RSConstants.ALL_ZONES_CUSTOM_NPC) then
			options.args[groupKey].args[npcKey].args.subzones.values[RSConstants.ALL_ZONES_CUSTOM_NPC] = AL["ALL_ZONES"]
			private.options_cnpcs[groupKey][npcKey].subzone = RSConstants.ALL_ZONES_CUSTOM_NPC
		else
			table.foreach(RSMapDB.GetContinents()[continentID].zones, function(index, zoneID)
				local zoneName = RSMap.GetMapName(zoneID)
				if (zoneName) then
					options.args[groupKey].args[npcKey].args.subzones.values[zoneID] = zoneName
				end
			end)
		end
	end
end

local function ParseCustomNpcOverlay(overlay)
	local coordinates = ""
	if (overlay) then
		for i, coordinate in pairs (overlay) do
			local x, y = strsplit("-",coordinate)
			local pattern
			if (i > 1) then
				pattern = ",%s-%s"
			else
				pattern = "%s-%s"
			end
			
			if (tonumber(x) < 1) then
				coordinates = coordinates..string.format(pattern, string.sub(x, 3), string.sub(y, 3))
			else
				coordinates = coordinates..string.format(pattern, x, y)
			end
		end
	end
	
	return coordinates
end

local function AddNewCustomNpc(npcID, group)
	if (not private.options_cnpcs) then
		private.options_cnpcs = {}
	end
	
	local groupKey = RSCustomNpcs.GetGroupKey(group)
	local npcKey = RSCustomNpcs.GetNpcKey(npcID)
	
	if (not private.options_cnpcs[groupKey]) then
		private.options_cnpcs[groupKey] = {}
		
		options.args[groupKey] = {
			type = "group",
			order = 0,
			name = RSNpcDB.GetCustomNpcGroupByKey(group),
			handler = RareScanner,
			desc = RSNpcDB.GetCustomNpcGroupByKey(group),
			args = {
				changeName = {
					order = 0,
					type = "input",
					name = AL["CUSTOM_NPC_GROUP_NAME"],
					desc = AL["CUSTOM_NPC_GROUP_NAME_DESC"],
					get = function(_, value) return RSNpcDB.GetCustomNpcGroupByKey(group) end,
					set = function(_, value)
						-- Skips if empty
						if (not value or strtrim(value) == '') then
							return
						end
						
						RSNpcDB.SetCustomNpcGroupByKey(group, value)
						options.args[groupKey].name = value
					end,
					validate = function(_, value)
						-- Check length
						if (value and strlen(strtrim(value)) > 20) then
							return AL["CUSTOM_NPC_VALIDATION_GROUP"]
						end
						
						return true
					end,
					width = "normal",
				},
				deleteGroup = {
					order = 1,
					name = AL["CUSTOM_NPC_GROUP_DELETE"],
					desc = AL["CUSTOM_NPC_GROUP_DELETE_DESC"],
					type = "execute",
					confirm = true,
					confirmText = string.format(AL["CUSTOM_NPC_GROUP_DELETE_CONFIRM"], RSNpcDB.GetCustomNpcGroupByKey(group)),
					func = function()
						-- Deletes every custom NPC
						for npcKey, _ in pairs (private.options_cnpcs[groupKey]) do
							local npcID = GetNpcID(npcKey)
							RSCustomNpcs.DeleteCustomNpc(npcID, options)
						end
						
						-- Deletes the current group
						private.options_cnpcs[groupKey] = nil
						options.args[groupKey] = nil
						RSNpcDB.DeleteCustomNpcGroup(group)
						
						-- Autoselects the next group available
						if (RSUtils.GetTableLength(RSNpcDB.GetCustomNpcGroups()) == 0) then
							RSNpcDB.SetCustomNpcGroupByKey(RSConstants.DEFAULT_GROUP, AL["CUSTOM_NPC_GROUP_DEFAULT"])
							private.options_cnpcs_selectedGroup = RSConstants.DEFAULT_GROUP
						else
							for group, _ in pairs (RSNpcDB.GetCustomNpcGroups()) do
								private.options_cnpcs_selectedGroup = group
								break;
							end
						end
	 				end,
					width = "normal",
				},
				exportGroup = {
					order = 2,
					name = AL["CUSTOM_NPC_EXPORT_GROUP"],
					desc = AL["CUSTOM_NPC_EXPORT_DESC"],
					type = "execute",
					func = function()
						local text = RSCustomNpcs.ExportCustomGroup(group)
						importNpcsEditBox:SetText(text)
	  					importNpcsEditBox:HighlightText()
						importNpcsEditBox.exporting = true
						importNpcsFrame:Show()
	 				end,
					width = "normal",
				},
			}
		}
	end
	
	private.options_cnpcs[groupKey][npcKey] = {}
	private.options_cnpcs[groupKey][npcKey].group = group
	
	if (not private.options_cnpcs[groupKey][npcKey].zones) then
		private.options_cnpcs[groupKey][npcKey].zones = {}
		private.options_cnpcs[groupKey][npcKey].coordinates = {}
	end

	options.args[groupKey].args[npcKey] = {
		type = "group",
		name = RSNpcDB.GetNpcName(tonumber(npcID)),
		handler = RareScanner,
		desc = RSNpcDB.GetNpcName(tonumber(npcID)),
		args = {
			separatorFindZone = {
				order = 0,
				type = "header",
				name = AL["CUSTOM_NPC_FIND_ZONES"],
			},
			infoZone = {
				order = 1,
				type = "description",
				name = WrapTextInColorCode(AL["CUSTOM_NPC_INFO"], "00FFFF00"),
			},
			continents = {
				order = 2.1,
				type = "select",
				name = AL["FILTER_CONTINENT"],
				desc = AL["FILTER_CONTINENT_DESC"],
				values = GetContinentMapIds(),
				sorting = function()
					return RSUtils.GetSortedKeysByValue(options.args[groupKey].args[npcKey].args.continents.values, function(a, b) return a < b end)
				end,
				get = function(_, key)
					-- initialize
					if (not private.options_cnpcs[groupKey][npcKey].continent) then
						private.options_cnpcs[groupKey][npcKey].continent = RSConstants.CURRENT_MAP_ID

						-- load submaps combo
						LoadSubmapCombo(private.options_cnpcs[groupKey][npcKey].continent, group, npcID)
					end

					return private.options_cnpcs[groupKey][npcKey].continent
				end,
				set = function(_, key, value)
					private.options_cnpcs[groupKey][npcKey].continent = key

					-- load subzones combo
					LoadSubmapCombo(key, group, npcID)
				end,
				width = 1.0,
			},
			subzones = {
				order = 2.2,
				type = "select",
				name = AL["FILTER_ZONE"],
				desc = AL["FILTER_ZONE_DESC"],
				values = {},
				sorting = function()
					return RSUtils.GetSortedKeysByValue(options.args[groupKey].args[npcKey].args.subzones.values, function(a, b) return a < b end)
				end,
				get = function(_, key) return private.options_cnpcs[groupKey][npcKey].subzone end,
				set = function(_, key, value)
					private.options_cnpcs[groupKey][npcKey].subzone = key
				end,
				width = 1.4,
				disabled = function() return (next(options.args[groupKey].args[npcKey].args.subzones.values) == nil) end,
			},
			addZone = {
				order = 3,
				name = AL["CUSTOM_NPC_ADD_ZONE"],
				desc = AL["CUSTOM_NPC_ADD_ZONE_DESC"],
				type = "execute",
				func = function()
					-- if already selected ignore it
					if (not private.options_cnpcs[groupKey][npcKey].zones[private.options_cnpcs[groupKey][npcKey].subzone]) then
						if (private.options_cnpcs[groupKey][npcKey].subzone == RSConstants.ALL_ZONES_CUSTOM_NPC) then
							private.options_cnpcs[groupKey][npcKey].zones[private.options_cnpcs[groupKey][npcKey].subzone] = AL["ALL_ZONES"]
						else
							private.options_cnpcs[groupKey][npcKey].zones[private.options_cnpcs[groupKey][npcKey].subzone] = RSMap.GetMapName(private.options_cnpcs[groupKey][npcKey].subzone)
						end
						
						private.options_cnpcs[groupKey][npcKey].zone = private.options_cnpcs[groupKey][npcKey].subzone
						RSNpcDB.SetCustomNpcInfo(npcID, private.options_cnpcs[groupKey][npcKey])
						RSTargetUnitTracker.Refresh()
					end
				end,
				width = "normal",
				disabled = function() return (not private.options_cnpcs[groupKey][npcKey].subzone) end,
			},
			separatorCurrentZones = {
				order = 4,
				type = "header",
				name = AL["CUSTOM_NPC_CURRENT_ZONES"],
			},
			zones = {
				order = 5.1,
				type = "select",
				name = AL["CUSTOM_NPC_CURRENT_ZONE"],
				desc = AL["CUSTOM_NPC_CURRENT_ZONE_DESC"],
				values = private.options_cnpcs[groupKey][npcKey].zones,
				sorting = function()
					return RSUtils.GetSortedKeysByValue(options.args[groupKey].args[npcKey].args.zones.values, function(a, b) return a < b end)
				end,
				get = function(_, key) return private.options_cnpcs[groupKey][npcKey].zone end,
				set = function(_, key, value)
					private.options_cnpcs[groupKey][npcKey].zone = key
				end,
				width = 1.4,
				disabled = function() return (next(private.options_cnpcs[groupKey][npcKey].zones) == nil) end,
			},
			deleteZone = {
				order = 5.2,
				name = AL["CUSTOM_NPC_DELETE_ZONE"],
				desc = AL["CUSTOM_NPC_DELETE_ZONE_DESC"],
				type = "execute",
				confirm = true,
				confirmText = AL["CUSTOM_NPC_DELETE_ZONE_CONFIRM"],
				func = function()
					private.options_cnpcs[groupKey][npcKey].zones[private.options_cnpcs[groupKey][npcKey].zone] = nil
					private.options_cnpcs[groupKey][npcKey].coordinates[private.options_cnpcs[groupKey][npcKey].zone] = nil
					
					if (RSNpcDB.DeleteCustomNpcZone(npcID, private.options_cnpcs[groupKey][npcKey].zone)) then
						RSGeneralDB.RemoveAlreadyFoundEntity(tonumber(npcID))
					end
					
					private.options_cnpcs[groupKey][npcKey].zone = next(private.options_cnpcs[groupKey][npcKey].zones)
				end,
				width = 1.0,
				disabled = function() return (next(private.options_cnpcs[groupKey][npcKey].zones) == nil) end,
			},
			coordinates = {
				order = 6,
				type = "input",
				name = AL["CUSTOM_NPC_COORDINATES"],
				desc = AL["CUSTOM_NPC_COORDINATES_DESC"],
				get = function(_, value) 
					if (private.options_cnpcs[groupKey][npcKey].zone) then
						return private.options_cnpcs[groupKey][npcKey].coordinates[private.options_cnpcs[groupKey][npcKey].zone]
					end
					
					return nil
				end,
				set = function(_, value)
					private.options_cnpcs[groupKey][npcKey].coordinates[private.options_cnpcs[groupKey][npcKey].zone] = value
					RSNpcDB.SetCustomNpcInfo(npcID, private.options_cnpcs[groupKey][npcKey])
				end,
				validate = function(_, value)
					-- Skips if empty
					if (not value or strtrim(value) == '') then
						return true
					end
					
					-- Check if contains proper characters
					if (string.match(value, "[^0-9,%-]")) then
						return string.format(AL["CUSTOM_NPC_VALIDATION_CHAR"], "0123456789-,")
					end
					
					-- Check if the string is well formed
					for coordinatePair in string.gmatch(value, '([^,]+)') do
						local coordx, coordy = 	strsplit("-", coordinatePair, 2)
						if (not coordx or tonumber(coordx) == nil or not coordy or tonumber(coordy) == nil) then
							return string.format(AL["CUSTOM_NPC_VALIDATION_COORD"], coordinatePair)
						end
					end
					
					return true
				end,
				width = "full",
				disabled = function() return (next(private.options_cnpcs[groupKey][npcKey].zones) == nil or not private.options_cnpcs[groupKey][npcKey].zone or private.options_cnpcs[groupKey][npcKey].zone == RSConstants.ALL_ZONES_CUSTOM_NPC) end,
			},
			separatorExtraInfo = {
				order = 7,
				type = "header",
				name = AL["CUSTOM_NPC_EXTRA_INFO"],
			},
			displayID = {
				order = 8,
				type = "input",
				name = AL["CUSTOM_NPC_DISPLAY_ID"],
				desc = AL["CUSTOM_NPC_DISPLAY_ID_DESC"],
				get = function(_, value) 
					return private.options_cnpcs[groupKey][npcKey].displayID
				end,
				set = function(_, value)
					private.options_cnpcs[groupKey][npcKey].displayID = value
					RSNpcDB.SetCustomNpcInfo(npcID, private.options_cnpcs[groupKey][npcKey])
				end,
				validate = function(_, value)
					-- Skips if empty
					if (not value or strtrim(value) == '') then
						return true
					end
					
					-- Check if number
					if (value and tonumber(value) == nil or RSUtils.Contains(value,"%.")) then
						return AL["CUSTOM_NPC_VALIDATION_NUMBER"]
					end
					
					return true
				end,
				width = "full",
			},
			loot = {
				order = 9,
				type = "input",
				name = AL["CUSTOM_NPC_LOOT"],
				desc = AL["CUSTOM_NPC_LOOT_DESC"],
				get = function(_, value) 
					return private.options_cnpcs[groupKey][npcKey].loot
				end,
				set = function(_, value)
					private.options_cnpcs[groupKey][npcKey].loot = value
					
					if (value and strtrim(value) ~= '') then
						local itemIDs = {}
						for itemID in string.gmatch(value, '([^,]+)') do
							tinsert(itemIDs, tonumber(itemID))
						end
						RSNpcDB.SetCustomNpcLoot(npcID, itemIDs)
						RSCollectionsDB.UpdateEntityCollectibles(tonumber(npcID), itemIDs, RSConstants.ITEM_SOURCE.NPC)
					else
						RSNpcDB.SetCustomNpcLoot(npcID, nil)
						if (RSCollectionsDB.GetAllEntitiesCollectionsLoot() and RSCollectionsDB.GetAllEntitiesCollectionsLoot()[RSConstants.ITEM_SOURCE.NPC] and RSCollectionsDB.GetAllEntitiesCollectionsLoot()[RSConstants.ITEM_SOURCE.NPC][tonumber(npcID)]) then
							RSCollectionsDB.GetAllEntitiesCollectionsLoot()[RSConstants.ITEM_SOURCE.NPC][tonumber(npcID)] = nil
						end
					end
					
					RSExplorerFrame:Refresh()
				end,
				validate = function(_, value)
					-- Skips if empty
					if (not value or strtrim(value) == '') then
						return true
					end
				
					-- Check if contains proper characters
					if (string.match(value, "[^0-9,]")) then
						return string.format(AL["CUSTOM_NPC_VALIDATION_CHAR"], "0123456789,")
					end
					
					-- Check if the string is well formed
					for itemID in string.gmatch(value, '([^,]+)') do
						if (not itemID or tonumber(itemID) == nil) then
							return AL["CUSTOM_NPC_VALIDATION_ITEM"]
						end
					end
					
					return true
				end,
				width = "full",
			},
			groups = {
				order = 10,
				type = "select",
				name = AL["CUSTOM_NPC_GROUP"],
				desc = AL["CUSTOM_NPC_GROUP_DESC"],
				values = function ()						
					return RSNpcDB.GetCustomNpcGroups()
				end,
				get = function(_, value)
					return group
				end,
				set = function(_, value)					
					-- Backup current info
					local currentInfo = private.options_cnpcs[groupKey][npcKey]
					
					-- Adds new custom NPC
					AddNewCustomNpc(npcID, value);
					
					-- Recovers information
					private.options_cnpcs[RSCustomNpcs.GetGroupKey(value)][npcKey].group = value
					private.options_cnpcs[RSCustomNpcs.GetGroupKey(value)][npcKey].displayID = currentInfo.displayID
					private.options_cnpcs[RSCustomNpcs.GetGroupKey(value)][npcKey].loot = currentInfo.loot
					
					for zoneID, _ in pairs (private.options_cnpcs[groupKey][npcKey].zones) do
						private.options_cnpcs[RSCustomNpcs.GetGroupKey(value)][npcKey].zones[zoneID] = currentInfo.zones[zoneID]
						private.options_cnpcs[RSCustomNpcs.GetGroupKey(value)][npcKey].zone = zoneID
						private.options_cnpcs[RSCustomNpcs.GetGroupKey(value)][npcKey].coordinates[zoneID] = currentInfo.coordinates[zoneID]
					end
					
					-- If the NPC is already saved, change the group in the database
					if (RSNpcDB.GetCustomNpcInfo(tonumber(npcID))) then
						RSNpcDB.SetCustomNpcGroup(npcID, value)
					end
					
					-- Removes current NPC
					private.options_cnpcs[groupKey][npcKey] = nil
					options.args[groupKey].args[npcKey] = nil
	
					-- Deletes the current group if empty
					if (RSUtils.GetTableLength(private.options_cnpcs[groupKey]) == 0) then
						private.options_cnpcs[groupKey] = nil
						options.args[groupKey] = nil
					end
					
					-- Selects the new group
					RSACD:SelectGroup("RareScanner Custom NPCs", RSCustomNpcs.GetGroupKey(value), RSCustomNpcs.GetNpcKey(npcID))
				end,
				width = "normal",
			},
			exportNpc = {
				order = 11,
				name = AL["CUSTOM_NPC_EXPORT_NPC"],
				desc = AL["CUSTOM_NPC_EXPORT_DESC"],
				type = "execute",
				func = function()
					local text = RSCustomNpcs.ExportCustomNpc(npcID)
					importNpcsEditBox:SetText(text)
  					importNpcsEditBox:HighlightText()
					importNpcsEditBox.exporting = true
					importNpcsFrame:Show()
 				end,
				width = "normal",
			},
			deleteNpc = {
				order = 12,
				name = AL["CUSTOM_NPC_DELETE_NPC"],
				desc = AL["CUSTOM_NPC_DELETE_NPC_DESC"],
				type = "execute",
				confirm = true,
				confirmText = string.format(AL["CUSTOM_NPC_DELETE_NPC_CONFIRM"], RSNpcDB.GetNpcName(tonumber(npcID))),
				func = function()
					RSCustomNpcs.DeleteCustomNpc(npcID, options)
 				end,
				width = "normal",
			},
		}
	}
end

local function RefresCustomNpcList()
	if (RSNpcDB.GetAllCustomNpcInfo()) then
		for npcID, npcInfo in pairs (RSNpcDB.GetAllCustomNpcInfo()) do
			local npcInfo = RSNpcDB.GetCustomNpcInfo(npcID)
			local group = npcInfo.group or RSConstants.DEFAULT_GROUP
			AddNewCustomNpc(npcID, group)
			
			-- Creates options table
			local groupKey = RSCustomNpcs.GetGroupKey(group)
			local npcKey = RSCustomNpcs.GetNpcKey(npcID)
			
			if (npcInfo.displayID and npcInfo.displayID ~= 0) then
				private.options_cnpcs[groupKey][npcKey].displayID = tostring(npcInfo.displayID)
			end
			
			local npcLoot = RSNpcDB.GetCustomNpcLoot(npcID)
			if (npcLoot) then
				private.options_cnpcs[groupKey][npcKey].loot = table.concat(npcLoot, ",")
			end

			if (type(npcInfo.zoneID) == "table") then
				for zoneID, zoneInfo in pairs (npcInfo.zoneID) do
					if (zoneID == RSConstants.ALL_ZONES_CUSTOM_NPC) then
						private.options_cnpcs[groupKey][npcKey].zones[zoneID] = AL["ALL_ZONES"]
						private.options_cnpcs[groupKey][npcKey].zone = zoneID
					else
						private.options_cnpcs[groupKey][npcKey].zones[zoneID] = RSMap.GetMapName(zoneID)
						private.options_cnpcs[groupKey][npcKey].zone = zoneID
						private.options_cnpcs[groupKey][npcKey].coordinates[zoneID] = ParseCustomNpcOverlay(zoneInfo.overlay)
					end
				end
			else
				if (npcInfo.zoneID == RSConstants.ALL_ZONES_CUSTOM_NPC) then
					private.options_cnpcs[groupKey][npcKey].zones[npcInfo.zoneID] = AL["ALL_ZONES"]
					private.options_cnpcs[groupKey][npcKey].zone = npcInfo.zoneID
				else
					private.options_cnpcs[groupKey][npcKey].zones[npcInfo.zoneID] = RSMap.GetMapName(npcInfo.zoneID)
					private.options_cnpcs[groupKey][npcKey].zone = npcInfo.zoneID
					private.options_cnpcs[groupKey][npcKey].coordinates[npcInfo.zoneID] = ParseCustomNpcOverlay(npcInfo.overlay)
				end
			end
		end
	end
end

-----------------------------------------------------------------------
-- Options tab: Custom NPCs
-----------------------------------------------------------------------

function RSCustomNpcsOptions.GetCustomNpcsOptions()
	if (not options) then
		-- Adds default group
		if (not RSNpcDB.GetCustomNpcGroupByKey(RSConstants.DEFAULT_GROUP)) then
			RSNpcDB.SetCustomNpcGroupByKey(RSConstants.DEFAULT_GROUP, AL["CUSTOM_NPC_GROUP_DEFAULT"])
		end
		
		options = {
			type = "group",
			order = 0,
			name = AL["CUSTOM_NPCS"],
			handler = RareScanner,
			desc = AL["CUSTOM_NPCS"],
			args = {
				description = {
					order = 0,
					type = "description",
					name = AL["CUSTOM_NPC_TEXT"],
				},
				groups = {
					order = 1.1,
					type = "select",
					name = AL["CUSTOM_NPC_GROUP"],
					desc = AL["CUSTOM_NPC_GROUP_DESC"],
					values = function ()						
						return RSNpcDB.GetCustomNpcGroups()
					end,
					get = function(_, value)
						-- Selects default group
						if (not private.options_cnpcs_selectedGroup) then
							for group, _ in pairs (RSNpcDB.GetCustomNpcGroups()) do
								private.options_cnpcs_selectedGroup = group
								break;
							end
						end
						
						return private.options_cnpcs_selectedGroup
					end,
					set = function(_, value)
						private.options_cnpcs_selectedGroup = value
					end,
					width = "normal",
				},
				addNewGroup = {
					order = 1.2,
					type = "input",
					name = AL["CUSTOM_NPC_GROUP_ADD"],
					desc = AL["CUSTOM_NPC_GROUP_ADD_DESC"],
					get = function(_, value) return private.options_cnpcs_newGroup_input end,
					set = function(_, value)
						if (value and strtrim(value) ~= '') then
							local groupAlreadyExists = false
							for _, groupName in pairs (RSNpcDB.GetCustomNpcGroups()) do
								if (groupName == strtrim(value)) then
									groupAlreadyExists = true
								end
							end
							
							if (not groupAlreadyExists) then
								RSNpcDB.AddCustomNpcGroup(strtrim(value))
								options.args.groups.values = RSNpcDB.GetCustomNpcGroups()
							end
						end
					end,
					validate = function(_, value)
						-- Check length
						if (value and strlen(strtrim(value)) > 20) then
							return AL["CUSTOM_NPC_VALIDATION_GROUP"]
						end
						
						return true
					end,
					width = "normal",
				},
				deleteGroup = {
					order = 1.3,
					name = AL["CUSTOM_NPC_GROUP_DELETE"],
					desc = AL["CUSTOM_NPC_GROUP_DELETE"],
					type = "execute",
					func = function()
						-- Deletes the current group
						RSNpcDB.DeleteCustomNpcGroup(private.options_cnpcs_selectedGroup)
						
						-- Autoselects the next group available
						if (RSUtils.GetTableLength(RSNpcDB.GetCustomNpcGroups()) == 0) then
							RSNpcDB.SetCustomNpcGroupByKey(RSConstants.DEFAULT_GROUP, AL["CUSTOM_NPC_GROUP_DEFAULT"])
							private.options_cnpcs_selectedGroup = RSConstants.DEFAULT_GROUP
						else
							for group, _ in pairs (RSNpcDB.GetCustomNpcGroups()) do
								private.options_cnpcs_selectedGroup = group
								break
							end
						end
	 				end,
					width = "normal",
					disabled = function()
						local groupKey = RSCustomNpcs.GetGroupKey(private.options_cnpcs_selectedGroup)
						
						-- If the groups contains NPCs or there is only one group and it is the default one
						if ((private.options_cnpcs and private.options_cnpcs[groupKey] and RSUtils.GetTableLength(private.options_cnpcs[groupKey]) > 0) or (RSUtils.GetTableLength(RSNpcDB.GetCustomNpcGroups()) == 1 and private.options_cnpcs_selectedGroup == RSConstants.DEFAULT_GROUP)) then
							return true
						else
							return false
						end
					end
				},
				newNpcID = {
					order = 2.1,
					type = "input",
					name = AL["CUSTOM_NPC_ADD_NPC"],
					desc = AL["CUSTOM_NPC_ADD_NPC_DESC"],
					get = function(_, value) return private.options_cnpcs_newNpcID_input end,
					set = function(_, value)
						-- Adds new custom NPC
						AddNewCustomNpc(value, private.options_cnpcs_selectedGroup);
						private.options_cnpcs_newNpcID_input = nil
	
						-- Selects the group
						RSACD:SelectGroup("RareScanner Custom NPCs", RSCustomNpcs.GetGroupKey(private.options_cnpcs_selectedGroup), RSCustomNpcs.GetNpcKey(value))
					end,
					validate = function(_, value)
						-- Check if number
						if (tonumber(value) == nil) then
							return AL["CUSTOM_NPC_VALIDATION_NUMBER"]
						end
						
						-- Check if valid NPC
						-- Call several times to let the server load it
						RSNpcDB.GetNpcName(tonumber(value))
						RSNpcDB.GetNpcName(tonumber(value))
						local name = RSNpcDB.GetNpcName(tonumber(value))
						if (not name) then
							return AL["CUSTOM_NPC_ADD_NPC_NOEXIST"]
						end
						
						-- Check if already supported by RareScanner
						if (RSNpcDB.GetInternalNpcInfo(tonumber(value)) or RSNpcDB.GetCustomNpcInfo(tonumber(value))) then
							return AL["CUSTOM_NPC_ADD_NPC_EXISTS_RS"]
						end
						
						-- Check if already added in the list
						if (RSUtils.GetTableLength(private.options_cnpcs) > 0) then
							for groupKey, _ in pairs (private.options_cnpcs) do
								if (private.options_cnpcs[groupKey][RSCustomNpcs.GetNpcKey(value)]) then
									return AL["CUSTOM_NPC_ADD_NPC_EXISTS_RS"]
								end
							end
						end
						
						return true
					end,
					width = "normal",
				},
				separator = {
					order = 2.2,
					type = "description",
					name = AL["CUSTOM_NPC_IMPORT_OR"],
					width = 0.1,
				},
				importNpc = {
					order = 2.3,
					type = "input",
					name = AL["CUSTOM_NPC_IMPORT_NPC"],
					desc = AL["CUSTOM_NPC_IMPORT_NPC_DESC"],
					type = "execute",
					func = function()
						importNpcsEditBox:SetText(AL["CUSTOM_NPC_IMPORT_HELP"])
  						importNpcsEditBox:HighlightText()
  						importNpcsEditBox.exporting = false
						importNpcsFrame:Show()
	 				end,
					width = "normal",
				},
			},
		}
		
		-- Preload already added custom NPCs
		RefresCustomNpcList()
	end

	return options
end

-----------------------------------------------------------------------
-- Import NPCs button events
-----------------------------------------------------------------------

RSImportNpcsFrameButton:SetScript("OnClick", function(self)
	if (importNpcsEditBox.exporting) then
		importNpcsFrame:Hide()
		return
	end
	
	local text = importNpcsEditBox:GetText()
	
	-- Skips if text is empty
	if (not text or strtrim(text) == '') then
		importNpcsFrame:Hide()
	end
	
	RSCustomNpcs.ImportNpcs(text, options, function(output)
		importNpcsEditBox:SetText("")
		if (output) then
			importNpcsEditBox:SetText(table.concat(output,"\n"))
		else
			importNpcsFrame:Hide()
		end
		RSTargetUnitTracker.Refresh()
		
		-- Refresh UI
		RefresCustomNpcList()
		RSACD:SelectGroup("RareScanner Custom NPCs")
	end)
end)
