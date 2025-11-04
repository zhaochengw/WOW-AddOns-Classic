-----------------------------------------------------------------------
-- AddOn namespace.
-----------------------------------------------------------------------
local ADDON_NAME, private = ...

local LibStub = _G.LibStub
local ADDON_NAME, private = ...

-- RareScanner libraries
local RSConstants = private.ImportLib("RareScannerConstants")
local RSUtils = private.ImportLib("RareScannerUtils")

-- RareScanner database libraries
local RSConfigDB = private.ImportLib("RareScannerConfigDB")
local RSNpcDB = private.ImportLib("RareScannerNpcDB")
local RSGeneralDB = private.ImportLib("RareScannerGeneralDB")
local RSContainerDB = private.ImportLib("RareScannerContainerDB")
local RSAchievementDB =  private.ImportLib("RareScannerAchievementDB")
local RSEventDB = private.ImportLib("RareScannerEventDB")
local RSMapDB =  private.ImportLib("RareScannerMapDB")

-- RareScanner service libraries
local RSMinimap = private.ImportLib("RareScannerMinimap")
local RSProvider = private.ImportLib("RareScannerProvider")

-- Locales
local AL = LibStub("AceLocale-3.0"):GetLocale("RareScanner");

RSWorldMapButtonMixin = CreateFromMixins(WowStyle2IconButtonMixin);

function RSWorldMapButtonMixin:OnLoad()

end

function RSWorldMapButtonMixin:OnShow()
	self:SetupMenu();
end

function RSWorldMapButtonMixin:OnMenuResponse(menu, description)
	self:NotifyUpdate(description);
end

function RSWorldMapButtonMixin:NotifyUpdate(description)
	RSMinimap.RefreshAllData(true)
	RSProvider.RefreshAllDataProviders()
end

function RSWorldMapButtonMixin:OnMouseDown(button)
    self.Icon:SetPoint('TOPLEFT', self, "TOPLEFT", 7, -6)
    PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
end

function RSWorldMapButtonMixin:OnMouseUp()
	self.Icon:SetPoint('TOPLEFT', 7.2, -6)
end

function RSWorldMapButtonMixin:OnEnter()
    GameTooltip:SetOwner(self, 'ANCHOR_RIGHT')
    GameTooltip_SetTitle(GameTooltip, "RareScanner")
    GameTooltip:Show()
end

function RSWorldMapButtonMixin:Refresh()
    self:SetupMenu()
end

function RSWorldMapButtonMixin:SetupMenu()
	if (self.mapID and self.mapID == self:GetParent():GetMapID()) then
		return
	end
	
	DropdownButtonMixin.SetupMenu(self, function(dropdown, rootDescription)
		rootDescription:SetTag("MENU_WORLD_MAP_RARESCANNER");

		local mapID = self:GetParent():GetMapID();

		-- Rare NPCs
		local npcsSubmenu =	rootDescription:CreateButton("|T"..RSConstants.NORMAL_NPC_TEXTURE..":18:18:::::0:32:0:32|t "..AL["MAP_MENU_RARE_NPCS"]);		
    	npcsSubmenu:CreateTitle(AL["MAP_MENU_SHOW"])
		npcsSubmenu:CreateCheckbox(AL["MAP_MENU_SHOW_RARE_NPCS"], function() return RSConfigDB.IsShowingNpcs() end, 
			function()
				if (RSConfigDB.IsShowingNpcs()) then
					RSConfigDB.SetShowingNpcs(false)
				else
					RSConfigDB.SetShowingNpcs(true)
				end
			end)
			
		-- Show Rare NPCs
    	local npcsLastSeen = npcsSubmenu:CreateCheckbox("|T"..RSConstants.NORMAL_NPC_TEXTURE..":18:18:::::0:32:0:32|t "..AL["MAP_MENU_DISABLE_LAST_SEEN_FILTER"], 
    		function() return not RSConfigDB.IsMaxSeenTimeFilterEnabled() end, 
			function()
				if (RSConfigDB.IsMaxSeenTimeFilterEnabled()) then
					RSConfigDB.DisableMaxSeenTimeFilter()
				else
					RSConfigDB.EnableMaxSeenTimeFilter()
				end
			end)
		npcsLastSeen:SetEnabled(function() return RSConfigDB.IsShowingNpcs() end)
		
    	local npcsDead = npcsSubmenu:CreateCheckbox("|T"..RSConstants.BLUE_NPC_TEXTURE..":18:18:::::0:32:0:32|t "..AL["MAP_MENU_SHOW_DEAD_RARE_NPCS"], 
    		function() return RSConfigDB.IsShowingAlreadyKilledNpcs() end, 
			function()
				if (RSConfigDB.IsShowingAlreadyKilledNpcs()) then
					RSConfigDB.SetShowingAlreadyKilledNpcs(false)
				else
					RSConfigDB.SetShowingAlreadyKilledNpcs(true)
				end
			end)
		npcsDead:SetEnabled(function() return RSConfigDB.IsShowingNpcs() end)
		
    	local npcsNotDiscovered = npcsSubmenu:CreateCheckbox("|T"..RSConstants.RED_NPC_TEXTURE..":18:18:::::0:32:0:32|t "..AL["MAP_MENU_SHOW_NOT_DISCOVERED_RARE_NPCS"], 
    		function() return RSConfigDB.IsShowingNotDiscoveredNpcs() end, 
			function()
				if (RSConfigDB.IsShowingNotDiscoveredNpcs()) then
					RSConfigDB.SetShowingNotDiscoveredNpcs(false)
				else
					RSConfigDB.SetShowingNotDiscoveredNpcs(true)
				end
			end)
		npcsNotDiscovered:SetEnabled(function() return RSConfigDB.IsShowingNpcs() end)
		
    	local npcsFriendly = npcsSubmenu:CreateCheckbox("|T"..RSConstants.LIGHT_BLUE_NPC_TEXTURE..":18:18:::::0:32:0:32|t "..AL["MAP_MENU_SHOW_FRIENDLY_RARE_NPCS"], 
    		function() return RSConfigDB.IsShowingFriendlyNpcs() end, 
			function()
				if (RSConfigDB.IsShowingFriendlyNpcs()) then
					RSConfigDB.SetShowingFriendlyNpcs(false)
				else
					RSConfigDB.SetShowingFriendlyNpcs(true)
				end
			end)
		npcsFriendly:SetEnabled(function() return RSConfigDB.IsShowingNpcs() end)
	    
		local groups = RSNpcDB.GetCustomGroupsByMapID(mapID)
	    if (RSUtils.GetTableLength(groups) > 0) then
			for _, group in ipairs(groups) do
		    	local npcsGroup = npcsSubmenu:CreateCheckbox("|T"..RSConstants.PURPLE_NPC_TEXTURE..":18:18:::::0:32:0:32|t "..string.format(AL["MAP_MENU_SHOW_CUSTOM_NPC_GROUP"], RSNpcDB.GetCustomNpcGroupByKey(group)), 
		    		function() return not RSConfigDB.IsCustomNpcGroupFiltered(group) end, 
					function()
						if (RSConfigDB.IsCustomNpcGroupFiltered(group)) then
							RSConfigDB.SetCustomNpcGroupFiltered(group, false)
						else
							RSConfigDB.SetCustomNpcGroupFiltered(group, true)
						end
					end)
				npcsGroup:SetEnabled(function() return RSConfigDB.IsShowingNpcs() end)
			end
		end
		
		npcsSubmenu:CreateDivider()
		
    	local npcsAchievements = npcsSubmenu:CreateCheckbox("|A:"..RSConstants.ACHIEVEMENT_ICON_ATLAS..":18:18::::|a "..AL["MAP_MENU_SHOW_ACHIEVEMENT_RARE_NPCS"], 
    		function() return RSConfigDB.IsShowingAchievementRareNPCs() end, 
			function()
				if (RSConfigDB.IsShowingAchievementRareNPCs()) then
					RSConfigDB.SetShowingAchievementRareNPCs(false)
				else
					RSConfigDB.SetShowingAchievementRareNPCs(true)
				end
			end)
		npcsAchievements:SetEnabled(function() return RSConfigDB.IsShowingNpcs() end)
		
		for minieventID, minieventData in pairs (RSConstants.MINIEVENTS_WORLDMAP_FILTERS) do
			if (minieventData.npcs and RSUtils.Contains(minieventData.mapIDs, mapID)) then
				local text
				if (minieventData.atlas) then
					text = "|A:"..minieventData.atlas..":18:18::::|a "..minieventData.text
				else
					text = "|T"..minieventData.texture..":18:18::::|a "..minieventData.text
				end
				
				local npcsMinievents = npcsSubmenu:CreateCheckbox(text, 
		    		function() return not RSConfigDB.IsMinieventFiltered(minieventID) end, 
					function()
						if (RSConfigDB.IsMinieventFiltered(minieventID)) then
							RSConfigDB.SetMinieventFiltered(minieventID, false)
						else
							RSConfigDB.SetMinieventFiltered(minieventID, true)
						end
					end)
				npcsMinievents:SetEnabled(function() return RSConfigDB.IsShowingNpcs() end)
			end
		end
		
    	local npcsOthers = npcsSubmenu:CreateCheckbox(AL["MAP_MENU_SHOW_OTHER_RARE_NPCS"], 
    		function() return RSConfigDB.IsShowingOtherRareNPCs() end, 
			function()
				if (RSConfigDB.IsShowingOtherRareNPCs()) then
					RSConfigDB.SetShowingOtherRareNPCs(false)
				else
					RSConfigDB.SetShowingOtherRareNPCs(true)
				end
			end)
		npcsOthers:SetEnabled(function() return RSConfigDB.IsShowingNpcs() end)
		
		-- Filter NPCs		
		local npcIDsWithNames = RSNpcDB.GetActiveNpcIDsWithNamesByMapID(mapID)
		if (RSUtils.GetTableLength(npcIDsWithNames) > 0) then
			npcsSubmenu:CreateDivider()
			npcsSubmenu:CreateTitle(AL["MAP_MENU_FILTER"])
		
	    	local npcsFilterSubmenu = npcsSubmenu:CreateButton(AL["MAP_MENU_FILTER_NPCS"])
			npcsFilterSubmenu:SetScrollMode(500)
			npcsFilterSubmenu:CreateTitle(AL["MAP_MENU_FILTER_DESELECT"])
			
			-- Select/deselect all
			local npcDesSel = npcsFilterSubmenu:CreateButton(AL["MAP_MENU_FILTER_ALL"])
			npcDesSel:SetResponder(function(data, menuInputData, menu)
	    		local anySelected = true
    			for npcID, _ in pairs (npcIDsWithNames) do
    				if (not RSConfigDB.GetNpcFiltered(npcID)) then
    					anySelected = false
    					break
    				end
    			end
    			
    			if (anySelected) then
    				for npcID, _ in pairs (npcIDsWithNames) do
	    				RSConfigDB.DeleteNpcFiltered(npcID)
	    			end
    			else
    				for npcID, _ in pairs (npcIDsWithNames) do
	    				RSConfigDB.SetNpcFiltered(npcID)
	    			end
    			end
    
				return MenuResponse.Refresh;
			end)
			
			-- Select/deselect by group
		    if (RSUtils.GetTableLength(groups) > 0) then
				for _, group in ipairs(groups) do
			    	local npcDesSelGroup = npcsFilterSubmenu:CreateButton(string.format(AL["MAP_MENU_FILTER_ALL_GROUP"], RSNpcDB.GetCustomNpcGroupByKey(group))) 
			    	npcDesSelGroup:SetResponder(function(data, menuInputData, menu)
			    		local anySelected = true
		    			for npcID, _ in pairs (npcIDsWithNames) do
		    				if (RSNpcDB.IsCustomNpcInGroup(npcID, group) and not RSConfigDB.GetNpcFiltered(npcID)) then
		    					anySelected = false
		    					break
		    				end
		    			end
		    			
		    			if (anySelected) then
		    				for npcID, _ in pairs (npcIDsWithNames) do
		    					if (RSNpcDB.IsCustomNpcInGroup(npcID, group)) then
			    					RSConfigDB.DeleteNpcFiltered(npcID)
			    				end
			    			end
		    			else
		    				for npcID, _ in pairs (npcIDsWithNames) do
		    					if (RSNpcDB.IsCustomNpcInGroup(npcID, group)) then
			    					RSConfigDB.SetNpcFiltered(npcID)
			    				end
			    			end
		    			end
		    
						return MenuResponse.Refresh;
					end)
				end
			end
	
			for _, npcID in ipairs (RSUtils.GetSortedKeysByValue(npcIDsWithNames, function(a, b) return a < b end)) do
				local npcName = npcIDsWithNames[npcID]
				local text
				if (RSNpcDB.IsInternalNpcFriendly(npcID)) then
					text = "|T"..RSConstants.LIGHT_BLUE_NPC_TEXTURE..":18:18:::::0:32:0:32|t "
				elseif (RSNpcDB.IsNpcKilled(npcID)) then
					text = "|T"..RSConstants.BLUE_NPC_TEXTURE..":18:18:::::0:32:0:32|t "
				elseif (RSGeneralDB.GetAlreadyFoundEntity(npcID)) then
					text = "|T"..RSConstants.NORMAL_NPC_TEXTURE..":18:18:::::0:32:0:32|t "
				else
					text = "|T"..RSConstants.RED_NPC_TEXTURE..":18:18:::::0:32:0:32|t "
				end
				
				local npcInfo = RSNpcDB.GetInternalNpcInfo(npcID)
				if (npcInfo) then
					if (npcInfo.minieventID and RSConstants.MINIEVENTS_WORLDMAP_FILTERS[npcInfo.minieventID] and RSConstants.MINIEVENTS_WORLDMAP_FILTERS[npcInfo.minieventID].atlas) then
						text = text.."|A:"..RSConstants.MINIEVENTS_WORLDMAP_FILTERS[npcInfo.minieventID].atlas..":18:18::::|a "..npcName
					elseif (RSUtils.GetTableLength(RSAchievementDB.GetNotCompletedAchievementIDsByMap(npcID, mapID, npcInfo.achievementID, npcInfo.questID, npcInfo.criteria)) > 0) then
						text = text.."|A:"..RSConstants.ACHIEVEMENT_ICON_ATLAS..":18:18::::|a "..npcName
					else
						text = text..npcName
					end
				else
					text = text..npcName
				end
				
				local npcFilter = npcsFilterSubmenu:CreateCheckbox(text, 
		    		function() return RSConfigDB.GetNpcFiltered(npcID) == nil end, 
					function()
						if (RSConfigDB.GetNpcFiltered(npcID)) then
							RSConfigDB.DeleteNpcFiltered(npcID)
						else
							RSConfigDB.SetNpcFiltered(npcID)
						end
					end)
				npcFilter:SetEnabled(function() 
					local npcInfo = RSNpcDB.GetInternalNpcInfo(npcID)
					if (npcInfo and RSConfigDB.IsWeeklyRepNpcFilterEnabled()) then
						if (npcInfo.warbandQuestID) then
							for _, questID in ipairs(npcInfo.warbandQuestID) do
								if (C_QuestLog.IsQuestFlaggedCompletedOnAccount(questID)) then
									return false
								end
							end
						end
					end
					
					return true				
				end)
			end
		end
		
		-- Containers
	    local containersSubmenu = rootDescription:CreateButton("|TInterface\\AddOns\\RareScanner\\Media\\Icons\\OriginalChest:18:18:::::0:32:0:32|t "..AL["MAP_MENU_CONTAINERS"])
    	containersSubmenu:CreateTitle(AL["MAP_MENU_SHOW"])
    	containersSubmenu:CreateCheckbox(AL["MAP_MENU_SHOW_CONTAINERS"], function() return RSConfigDB.IsShowingContainers() end, 
			function()
				if (RSConfigDB.IsShowingContainers()) then
					RSConfigDB.SetShowingContainers(false)
				else
					RSConfigDB.SetShowingContainers(true)
				end
			end)
			
		-- Show Containers
    	local containersLastSeen = containersSubmenu:CreateCheckbox("|TInterface\\AddOns\\RareScanner\\Media\\Icons\\OriginalChest:18:18:::::0:32:0:32|t "..AL["MAP_MENU_DISABLE_LAST_SEEN_CONTAINER_FILTER"], 
    		function() return not RSConfigDB.IsMaxSeenTimeContainerFilterEnabled() end, 
			function()
				if (RSConfigDB.IsMaxSeenTimeContainerFilterEnabled()) then
					RSConfigDB.DisableMaxSeenContainerTimeFilter()
				else
					RSConfigDB.EnableMaxSeenContainerTimeFilter()
				end
			end)
		containersLastSeen:SetEnabled(function() return RSConfigDB.IsShowingContainers() end)

    	local containersOpened = containersSubmenu:CreateCheckbox("|T"..RSConstants.BLUE_CONTAINER_TEXTURE..":18:18:::::0:32:0:32|t "..AL["MAP_MENU_SHOW_OPEN_CONTAINERS"], 
    		function() return RSConfigDB.IsShowingAlreadyOpenedContainers() end, 
			function()
				if (RSConfigDB.IsShowingAlreadyOpenedContainers()) then
					RSConfigDB.SetShowingAlreadyOpenedContainers(false)
				else
					RSConfigDB.SetShowingAlreadyOpenedContainers(true)
				end
			end)
		containersOpened:SetEnabled(function() return RSConfigDB.IsShowingContainers() end)

    	local containersNotDiscovered = containersSubmenu:CreateCheckbox("|T"..RSConstants.RED_CONTAINER_TEXTURE..":18:18:::::0:32:0:32|t "..AL["MAP_MENU_SHOW_NOT_DISCOVERED_CONTAINERS"], 
    		function() return RSConfigDB.IsShowingNotDiscoveredContainers() end, 
			function()
				if (RSConfigDB.IsShowingNotDiscoveredContainers()) then
					RSConfigDB.SetShowingNotDiscoveredContainers(false)
				else
					RSConfigDB.SetShowingNotDiscoveredContainers(true)
				end
			end)
		containersNotDiscovered:SetEnabled(function() return RSConfigDB.IsShowingContainers() end)
		
		containersSubmenu:CreateDivider()

    	local containerAchievements = containersSubmenu:CreateCheckbox("|A:"..RSConstants.ACHIEVEMENT_ICON_ATLAS..":18:18::::|a "..AL["MAP_MENU_SHOW_ACHIEVEMENT_CONTAINERS"], 
    		function() return RSConfigDB.IsShowingAchievementContainers() end, 
			function()
				if (RSConfigDB.IsShowingAchievementContainers()) then
					RSConfigDB.SetShowingAchievementContainers(false)
				else
					RSConfigDB.SetShowingAchievementContainers(true)
				end
			end)
		containerAchievements:SetEnabled(function() return RSConfigDB.IsShowingContainers() end)
	
		for minieventID, minieventData in pairs (RSConstants.MINIEVENTS_WORLDMAP_FILTERS) do
			if (minieventData.containers and RSUtils.Contains(minieventData.mapIDs, mapID)) then
				local text
				if (minieventData.atlas) then
					text = "|A:"..minieventData.atlas..":18:18::::|a "..minieventData.text
				else
					text = "|T"..minieventData.texture..":18:18::::|a "..minieventData.text
				end
				
				local containerMinievent = containersSubmenu:CreateCheckbox(text, 
		    		function() return not RSConfigDB.IsMinieventFiltered(minieventID) end, 
					function()
						if (RSConfigDB.IsMinieventFiltered(minieventID)) then
							RSConfigDB.SetMinieventFiltered(minieventID, false)
						else
							RSConfigDB.SetMinieventFiltered(minieventID, true)
						end
					end)
				containerMinievent:SetEnabled(function() return RSConfigDB.IsShowingContainers() end)
			end
		end
			
    	local containerOthers = containersSubmenu:CreateCheckbox(AL["MAP_MENU_SHOW_OTHER_CONTAINERS"], 
    		function() return RSConfigDB.IsShowingOtherContainers() end, 
			function()
				if (RSConfigDB.IsShowingOtherContainers()) then
					RSConfigDB.SetShowingOtherContainers(false)
				else
					RSConfigDB.SetShowingOtherContainers(true)
				end
			end)
		containerOthers:SetEnabled(function() return RSConfigDB.IsShowingContainers() end)

		-- Filter Containers
		local containerIDsWithNames = RSContainerDB.GetActiveContainerIDsWithNamesByMapID(mapID)
		if (RSUtils.GetTableLength(containerIDsWithNames) > 0) then
			containersSubmenu:CreateDivider()
			containersSubmenu:CreateTitle(AL["MAP_MENU_FILTER"])
			
			local containersAchievementFilter = containersSubmenu:CreateCheckbox(AL["MAP_MENU_FILTER_CONTAINERS_ACHIEVEMENT"], function() return RSConfigDB.IsAchievementContainerFilterEnabled() end, 
				function()
					if (RSConfigDB.IsAchievementContainerFilterEnabled()) then
						RSConfigDB.SetAchievementContainerFilterEnabled(false)
					else
						RSConfigDB.SetAchievementContainerFilterEnabled(true)
					end
				end)
			
	    	local containersFilterSubmenu = containersSubmenu:CreateButton(AL["MAP_MENU_FILTER_CONTAINERS"])
			containersFilterSubmenu:SetScrollMode(500)
			containersFilterSubmenu:CreateTitle(AL["MAP_MENU_FILTER_DESELECT"])
			
			local containerDesSel = containersFilterSubmenu:CreateButton(AL["MAP_MENU_FILTER_ALL"])
			containerDesSel:SetResponder(function(data, menuInputData, menu)
	    		local anySelected = true
    			for containerID, _ in pairs (containerIDsWithNames) do
    				if (not RSConfigDB.GetContainerFiltered(containerID)) then
    					anySelected = false
    					break
    				end
    			end
    			
    			if (anySelected) then
    				for containerID, _ in pairs (containerIDsWithNames) do
	    				RSConfigDB.DeleteContainerFiltered(containerID)
	    			end
    			else
    				for containerID, _ in pairs (containerIDsWithNames) do
	    				RSConfigDB.SetContainerFiltered(containerID)
	    			end
    			end
    
				return MenuResponse.Refresh;
			end)
	
			for _, containerID in ipairs (RSUtils.GetSortedKeysByValue(containerIDsWithNames, function(a, b) return a < b end)) do
				local containerName = containerIDsWithNames[containerID]
				local text
				if (RSContainerDB.IsContainerOpened(containerID)) then
					text = "|T"..RSConstants.BLUE_CONTAINER_TEXTURE..":18:18:::::0:32:0:32|t "
				elseif (RSGeneralDB.GetAlreadyFoundEntity(containerID)) then
					text = "|T"..RSConstants.NORMAL_CONTAINER_TEXTURE..":18:18:::::0:32:0:32|t "
				else
					text = "|T"..RSConstants.RED_CONTAINER_TEXTURE..":18:18:::::0:32:0:32|t "
				end
				
				local containerInfo = RSContainerDB.GetInternalContainerInfo(containerID)
				if (containerInfo) then
					if (containerInfo.minieventID and RSConstants.MINIEVENTS_WORLDMAP_FILTERS[containerInfo.minieventID] and RSConstants.MINIEVENTS_WORLDMAP_FILTERS[containerInfo.minieventID].atlas) then
						text = text.."|A:"..RSConstants.MINIEVENTS_WORLDMAP_FILTERS[containerInfo.minieventID].atlas..":18:18::::|a "..containerName
					elseif (RSUtils.GetTableLength(RSAchievementDB.GetNotCompletedAchievementIDsByMap(containerID, mapID, containerInfo.achievementID, containerInfo.questID, containerInfo.criteria)) > 0) then
						text = text.."|A:"..RSConstants.ACHIEVEMENT_ICON_ATLAS..":18:18::::|a "..containerName
					else
						text = text..containerName
					end
				else
					text = text..containerName
				end
				
				local containerFilter = containersFilterSubmenu:CreateCheckbox(text, 
		    		function() return RSConfigDB.GetContainerFiltered(containerID) == nil end, 
					function()
						if (RSConfigDB.GetContainerFiltered(containerID)) then
							RSConfigDB.DeleteContainerFiltered(containerID)
						else
							RSConfigDB.SetContainerFiltered(containerID)
						end
					end)
				containerFilter:SetEnabled(function() 
					local conatinerInfo = RSContainerDB.GetInternalContainerInfo(containerID)
					if (conatinerInfo and RSConfigDB.IsAchievementContainerFilterEnabled() and conatinerInfo.achievementID and RSUtils.GetTableLength(RSAchievementDB.GetNotCompletedAchievementIDsByMap(containerID, mapID, containerInfo.achievementID, containerInfo.questID, containerInfo.criteria, true)) == 0) then
						return false
					end
					
					return true				
				end)
			end
		end
		
		-- Events
	    local eventsSubmenu = rootDescription:CreateButton("|TInterface\\AddOns\\RareScanner\\Media\\Icons\\OriginalStar:18:18:::::0:32:0:32|t "..AL["MAP_MENU_EVENTS"])
    	eventsSubmenu:CreateTitle(AL["MAP_MENU_SHOW"])
    	eventsSubmenu:CreateCheckbox(AL["MAP_MENU_SHOW_EVENTS"], function() return RSConfigDB.IsShowingEvents() end, 
			function()
				if (RSConfigDB.IsShowingEvents()) then
					RSConfigDB.SetShowingEvents(false)
				else
					RSConfigDB.SetShowingEvents(true)
				end
			end)
		
		-- Show events
    	local eventsLastSeen = eventsSubmenu:CreateCheckbox("|TInterface\\AddOns\\RareScanner\\Media\\Icons\\OriginalStar:18:18:::::0:32:0:32|t "..AL["MAP_MENU_DISABLE_LAST_SEEN_EVENT_FILTER"], 
    		function() return not RSConfigDB.IsMaxSeenTimeEventFilterEnabled() end, 
			function()
				if (RSConfigDB.IsMaxSeenTimeEventFilterEnabled()) then
					RSConfigDB.DisableMaxSeenEventTimeFilter()
				else
					RSConfigDB.EnableMaxSeenEventTimeFilter()
				end
			end)
		eventsLastSeen:SetEnabled(function() return RSConfigDB.IsShowingEvents() end)
			
    	local eventsCompleted = eventsSubmenu:CreateCheckbox("|T"..RSConstants.BLUE_EVENT_TEXTURE..":18:18:::::0:32:0:32|t "..AL["MAP_MENU_SHOW_COMPLETED_EVENTS"], 
    		function() return RSConfigDB.IsShowingCompletedEvents() end,
			function()
				if (RSConfigDB.IsShowingCompletedEvents()) then
					RSConfigDB.SetShowingCompletedEvents(false)
				else
					RSConfigDB.SetShowingCompletedEvents(true)
				end
			end)
		eventsCompleted:SetEnabled(function() return RSConfigDB.IsShowingEvents() end)
			
    	local eventsNotDiscovered = eventsSubmenu:CreateCheckbox("|T"..RSConstants.RED_EVENT_TEXTURE..":18:18:::::0:32:0:32|t "..AL["MAP_MENU_SHOW_NOT_DISCOVERED_EVENTS"], 
    		function() return RSConfigDB.IsShowingNotDiscoveredEvents() end,
			function()
				if (RSConfigDB.IsShowingNotDiscoveredEvents()) then
					RSConfigDB.SetShowingNotDiscoveredEvents(false)
				else
					RSConfigDB.SetShowingNotDiscoveredEvents(true)
				end
			end)
		eventsNotDiscovered:SetEnabled(function() return RSConfigDB.IsShowingEvents() end)
		
		-- Filter Events
		local eventIDsWithNames = RSEventDB.GetActiveEventIDsWithNamesByMapID(mapID, false)
		if (RSUtils.GetTableLength(eventIDsWithNames) > 0) then
			eventsSubmenu:CreateDivider()
			eventsSubmenu:CreateTitle(AL["MAP_MENU_FILTER"])
			
	    	local eventsFilterSubmenu = eventsSubmenu:CreateButton(AL["MAP_MENU_FILTER_EVENTS"])
			eventsFilterSubmenu:SetScrollMode(500)
			eventsFilterSubmenu:CreateTitle(AL["MAP_MENU_FILTER_DESELECT"])
			
			local eventDesSel = eventsFilterSubmenu:CreateButton(AL["MAP_MENU_FILTER_ALL"])
			eventDesSel:SetResponder(function(data, menuInputData, menu)
	    		local anySelected = true
    			for eventID, _ in pairs (eventIDsWithNames) do
    				if (not RSConfigDB.GetEventFiltered(eventID)) then
    					anySelected = false
    					break
    				end
    			end
    			
    			if (anySelected) then
    				for eventID, _ in pairs (eventIDsWithNames) do
	    				RSConfigDB.DeleteEventFiltered(eventID)
	    			end
    			else
    				for eventID, _ in pairs (eventIDsWithNames) do
	    				RSConfigDB.SetEventFiltered(eventID)
	    			end
    			end
    
				return MenuResponse.Refresh;
			end)
	
			for _, eventID in ipairs (RSUtils.GetSortedKeysByValue(eventIDsWithNames, function(a, b) return a < b end)) do
				local eventName = eventIDsWithNames[eventID]
				local text
				if (RSEventDB.IsEventCompleted(eventID)) then
					text = "|T"..RSConstants.BLUE_EVENT_TEXTURE..":18:18:::::0:32:0:32|t "
				elseif (RSGeneralDB.GetAlreadyFoundEntity(eventID)) then
					text = "|T"..RSConstants.NORMAL_EVENT_TEXTURE..":18:18:::::0:32:0:32|t "
				else
					text = "|T"..RSConstants.RED_EVENT_TEXTURE..":18:18:::::0:32:0:32|t "
				end
				
				local eventInfo = RSEventDB.GetInternalEventInfo(eventID)
				if (eventInfo) then
					if (eventInfo.minieventID and RSConstants.MINIEVENTS_WORLDMAP_FILTERS[eventInfo.minieventID] and RSConstants.MINIEVENTS_WORLDMAP_FILTERS[eventInfo.minieventID].atlas) then
						text = text.."|A:"..RSConstants.MINIEVENTS_WORLDMAP_FILTERS[eventInfo.minieventID].atlas..":18:18::::|a "..eventName
					elseif (RSUtils.GetTableLength(RSAchievementDB.GetNotCompletedAchievementIDsByMap(eventID, mapID, eventInfo.achievementID, eventInfo.questID, eventInfo.criteria)) > 0) then
						text = text.."|A:"..RSConstants.ACHIEVEMENT_ICON_ATLAS..":18:18::::|a "..eventName
					else
						text = text..eventName
					end
				else
					text = text..eventName
				end
				
				local eventFilter = eventsFilterSubmenu:CreateCheckbox(text, 
		    		function() return RSConfigDB.GetEventFiltered(eventID) == nil end, 
					function()
						if (RSConfigDB.GetEventFiltered(eventID)) then
							RSConfigDB.DeleteEventFiltered(eventID)
						else
							RSConfigDB.SetEventFiltered(eventID)
						end
					end)
			end
		end
			
		-- Not discovered old expansions
	 	rootDescription:CreateCheckbox(AL["MAP_MENU_SHOW_NOT_DISCOVERED_OLD"], 
	    	function() return RSConfigDB.IsShowingOldNotDiscoveredMapIcons() end,
	    	function() 
	    		if (RSConfigDB.IsShowingOldNotDiscoveredMapIcons()) then
					RSConfigDB.SetShowingOldNotDiscoveredMapIcons(false)
				else
					RSConfigDB.SetShowingOldNotDiscoveredMapIcons(true)
				end
			end)
			
		-- Filter zone
		local mapIDsWithNames = RSMapDB.GetActiveMapIDsWithNamesByMapID(mapID)
		if (RSUtils.GetTableLength(mapIDsWithNames) > 0) then
			rootDescription:CreateDivider()
			rootDescription:CreateTitle(AL["MAP_MENU_FILTER"])
			
	    	local mapsFilterSubmenu = rootDescription:CreateButton(AL["MAP_MENU_FILTER_MAPS"])
			mapsFilterSubmenu:SetScrollMode(500)
			mapsFilterSubmenu:CreateTitle(AL["MAP_MENU_FILTER_DESELECT"])
			
			local mapDesSel = mapsFilterSubmenu:CreateButton(AL["MAP_MENU_FILTER_ALL"])
			mapDesSel:SetResponder(function(data, menuInputData, menu)
	    		local anySelected = true
    			for mapID, _ in pairs (mapIDsWithNames) do
    				if (not RSConfigDB.GetZoneFiltered(mapID)) then
    					anySelected = false
    					break
    				end
    			end
    			
    			if (anySelected) then
    				for mapID, _ in pairs (mapIDsWithNames) do
	    				RSConfigDB.DeleteZoneFiltered(mapID)
	    			end
    			else
    				for mapID, _ in pairs (mapIDsWithNames) do
	    				RSConfigDB.SetZoneFiltered(mapID)
	    			end
    			end
    
				return MenuResponse.Refresh;
			end)
	
			for _, mapID in ipairs (RSUtils.GetSortedKeysByValue(mapIDsWithNames, function(a, b) return a < b end)) do
				local mapName = mapIDsWithNames[mapID]
				local eventFilter = mapsFilterSubmenu:CreateCheckbox(mapName, 
		    		function() return RSConfigDB.GetZoneFiltered(mapID) == nil end, 
					function()
						if (RSConfigDB.GetZoneFiltered(mapID)) then
							RSConfigDB.DeleteZoneFiltered(mapID)
						else
							RSConfigDB.SetZoneFiltered(mapID)
						end
					end)
			end
		end
	end);
	
	-- Avoids reconstructing if no changes
	self.mapID = self:GetParent():GetMapID()
end