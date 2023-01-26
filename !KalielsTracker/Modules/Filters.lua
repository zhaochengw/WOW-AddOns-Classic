--- Kaliel's Tracker
--- Copyright (c) 2012-2023, Marouan Sabbagh <mar.sabbagh@gmail.com>
--- All Rights Reserved.
---
--- This file is part of addon Kaliel's Tracker.

local addonName, KT = ...
local M = KT:NewModule(addonName.."_Filters")
KT.Filters = M

local _DBG = function(...) if _DBG then _DBG("KT", ...) end end

-- Lua API
local ipairs = ipairs
local pairs = pairs
local strfind = string.find
local strlower = string.lower
local tinsert = table.insert
local tremove = table.remove
local tsort = table.sort

-- WoW API
local _G = _G

local db, dbChar
local mediaPath = "Interface\\AddOns\\"..addonName.."\\Media\\"

local KTF = KT.frame
local OTF = ObjectiveTrackerFrame
local OTFHeader = OTF.HeaderMenu

local continents = KT.GetMapContinents()
local achievCategory = GetCategoryList()
local instanceQuestDifficulty = {
	[DIFFICULTY_DUNGEON_NORMAL] = { Enum.QuestTag.Dungeon },
	[DIFFICULTY_DUNGEON_HEROIC] = { Enum.QuestTag.Dungeon, Enum.QuestTag.Heroic },
	[DIFFICULTY_RAID10_NORMAL] = { Enum.QuestTag.Raid, Enum.QuestTag.Raid10 },
	[DIFFICULTY_RAID25_NORMAL] = { Enum.QuestTag.Raid, Enum.QuestTag.Raid25 },
	[DIFFICULTY_RAID10_HEROIC] = { Enum.QuestTag.Raid, Enum.QuestTag.Raid10 },
	[DIFFICULTY_RAID25_HEROIC] = { Enum.QuestTag.Raid, Enum.QuestTag.Raid25 },
	[DIFFICULTY_RAID_LFR] = { Enum.QuestTag.Raid },
	[DIFFICULTY_DUNGEON_CHALLENGE] = { Enum.QuestTag.Dungeon },
	[DIFFICULTY_RAID40] = { Enum.QuestTag.Raid },
	[DIFFICULTY_PRIMARYRAID_NORMAL] = { Enum.QuestTag.Raid },
	[DIFFICULTY_PRIMARYRAID_HEROIC] = { Enum.QuestTag.Raid },
	[DIFFICULTY_PRIMARYRAID_MYTHIC] = { Enum.QuestTag.Raid },
	[DIFFICULTY_PRIMARYRAID_LFR] = { Enum.QuestTag.Raid },
}
local factionColor = { ["Horde"] = "ff0000", ["Alliance"] = "007fff" }

local eventFrame

--------------
-- Internal --
--------------

local function SetHooks()
	local bck_ObjectiveTracker_OnEvent = OTF:GetScript("OnEvent")
	OTF:SetScript("OnEvent", function(self, event, ...)
		if event == "QUEST_ACCEPTED" then
			if db.filterAuto[1] then
				local _, questID = ...
				ObjectiveTracker_Update(OBJECTIVE_TRACKER_UPDATE_QUEST_ADDED, questID)
				return
			end
		end
		bck_ObjectiveTracker_OnEvent(self, event, ...)
	end)

	-- Quests
	local bck_QuestObjectiveTracker_UntrackQuest = QuestObjectiveTracker_UntrackQuest
	QuestObjectiveTracker_UntrackQuest = function(dropDownButton, questID)
		if not db.filterAuto[1] then
			bck_QuestObjectiveTracker_UntrackQuest(dropDownButton, questID)
		end
	end
	
	local bck_QuestMapQuestOptions_TrackQuest = QuestMapQuestOptions_TrackQuest
	QuestMapQuestOptions_TrackQuest = function(questID)
		if not db.filterAuto[1] then
			bck_QuestMapQuestOptions_TrackQuest(questID)
		end
	end

	-- Achievements
	local bck_AchievementObjectiveTracker_UntrackAchievement = AchievementObjectiveTracker_UntrackAchievement
	AchievementObjectiveTracker_UntrackAchievement = function(dropDownButton, achievementID)
		if not db.filterAuto[2] then
			bck_AchievementObjectiveTracker_UntrackAchievement(dropDownButton, achievementID)
		end
	end

	-- Quest Log
	hooksecurefunc("QuestLogControlPanel_UpdateState", function()
		if db.filterAuto[1] then
			QuestLogFrameTrackButton:Disable()
		else
			QuestLogFrameTrackButton:Enable()
		end
	end)
end

local function SetHooks_AchievementUI()
	local bck_AchievementButton_ToggleTracking = AchievementButton_ToggleTracking
	AchievementButton_ToggleTracking = function(id)
		if not db.filterAuto[2] then
			return bck_AchievementButton_ToggleTracking(id)
		end
	end

	hooksecurefunc("AchievementButton_DisplayAchievement", function(button, category, achievement, selectionID, renderOffScreen)
		if not button.completed then
			if db.filterAuto[2] then
				button.tracked:Disable()
			else
				button.tracked:Enable()
			end
		end
	end)
end

local function GetActiveWorldEvents()
	local eventsText = ""
	local date = C_DateAndTime.GetCurrentCalendarTime()
	C_Calendar.SetAbsMonth(date.month, date.year)
	local numEvents = C_Calendar.GetNumDayEvents(0, date.monthDay)
	for i=1, numEvents do
		local event = C_Calendar.GetDayEvent(0, date.monthDay, i)
		if event.calendarType == "HOLIDAY" then
			local gameHour, gameMinute = GetGameTime()
			if event.sequenceType == "START" then
				if gameHour >= event.startTime.hour and gameMinute >= event.startTime.minute then
					eventsText = eventsText..event.title.." "
				end
			elseif event.sequenceType == "END" then
				if gameHour <= event.endTime.hour and gameMinute <= event.endTime.minute then
					eventsText = eventsText..event.title.." "
				end
			else
				eventsText = eventsText..event.title.." "
			end
		end
	end
	return eventsText
end

local function IsInstanceQuest(questID)
	local _, _, difficulty, _ = GetInstanceInfo()
	local difficultyTags = instanceQuestDifficulty[difficulty]
	if difficultyTags then
		local tagID, tagName = GetQuestTagInfo(questID)
		for _, tag in ipairs(difficultyTags) do
			_DBG(difficulty.." ... "..tag, true)
			if tag == tagID then
				return true
			end
		end
	end
	return false
end

local function Filter_Quests(spec, idx)
	if not spec then return end
	local numEntries, _ = GetNumQuestLogEntries()

	KT.stopUpdate = true
	if KT_GetNumQuestWatches() > 0 then
		for i=1, numEntries do
			local _, _, _, isHeader, _, _, _, questID, _, _, _, _, isTask, isBounty = GetQuestLogTitle(i)
			if not isHeader and not isTask and (not isBounty or IsQuestComplete(questID)) then
				KT_RemoveQuestWatch(questID)
			end
		end
	end

	local headerName
	if spec == "all" then
		for i=1, numEntries do
			local title, _, _, isHeader, _, _, _, questID, _, _, _, _, isTask, isBounty = GetQuestLogTitle(i)
			if isHeader then
				headerName = title
			else
				if not isTask and (not isBounty or IsQuestComplete(questID)) then
					KT_AddQuestWatch(questID, headerName)
				end
			end
		end
	elseif spec == "group" then
		headerName = nil
		for i=idx, numEntries do
			local title, _, _, isHeader, _, _, _, questID, _, _, _, _, isTask, isBounty = GetQuestLogTitle(i)
			if isHeader and not headerName then
				headerName = title
			else
				if not isHeader and not isTask and (not isBounty or IsQuestComplete(questID)) then
					KT_AddQuestWatch(questID, headerName)
				else
					break
				end
			end
		end
		MSA_CloseDropDownMenus()
	elseif spec == "zone" then
		local mapID = KT.GetCurrentMapAreaID()
		local zoneName = GetZoneText() or ""
		local subzoneName = GetSubZoneText() or ""
		local zoneNameLower = strlower(zoneName)
		local subzoneNameLower = strlower(subzoneName)
		local isInZone = false
		local zoneInDesc = false
		local isInQuestieZone = false
		for i=1, numEntries do
			local title, _, _, isHeader, _, _, _, questID, _, _, isOnMap, _, isTask, isBounty = GetQuestLogTitle(i)
			if isHeader then
				headerName = title
				isInZone = (strfind(zoneName, title) ~= nil or (subzoneName ~= "" and strfind(subzoneName, title) ~= nil) or KT.playerClass == title)
			else
				if not isInZone then
					local _, questDescription = GetQuestLogQuestText(i)
					questDescription = strlower(questDescription)
					zoneInDesc = (strfind(questDescription, zoneNameLower) ~= nil or
								(subzoneNameLower ~= "" and strfind(questDescription, subzoneNameLower) ~= nil))
					if not zoneInDesc then
						isInQuestieZone = false
						local zones = KT.AddonQuestie:GetQuestZones(questID)
						for _, zone in pairs(zones) do
							if zone == mapID then
								isInQuestieZone = true
								break
							end
						end
					end
				end
				if not isTask and (not isBounty or IsQuestComplete(questID)) and (isOnMap or isInZone or zoneInDesc or isInQuestieZone) then
					if KT.inInstance then
						if IsInstanceQuest(questID) then
							KT_AddQuestWatch(questID, headerName)
						end
					else
						KT_AddQuestWatch(questID, headerName)
					end
				end
			end
		end
	elseif spec == "daily" then
		for i=1, numEntries do
			local title, _, _, isHeader, _, _, frequency, questID, _, _, _, _, isTask, isBounty = GetQuestLogTitle(i)
			if isHeader then
				headerName = title
			else
				if not isTask and (not isBounty or IsQuestComplete(questID)) and frequency >= 2 then
					KT_AddQuestWatch(questID, headerName)
				end
			end
		end
	elseif spec == "instance" then
		for i=1, numEntries do
			local title, _, _, isHeader, _, _, _, questID, _, _, _, _, isTask, isBounty = GetQuestLogTitle(i)
			if isHeader then
				headerName = title
			else
				if not isTask and (not isBounty or IsQuestComplete(questID)) then
					local tagID, _ = GetQuestTagInfo(questID)
					if tagID == Enum.QuestTag.Dungeon or
						tagID == Enum.QuestTag.Heroic or
						tagID == Enum.QuestTag.Raid or
						tagID == Enum.QuestTag.Raid10 or
						tagID == Enum.QuestTag.Raid25 then
						KT_AddQuestWatch(questID, headerName)
					end
				end
			end
		end
	elseif spec == "complete" then
		for i=1, numEntries do
			local title, _, _, isHeader, _, _, _, questID, _, _, _, _, isTask, isBounty = GetQuestLogTitle(i)
			if isHeader then
				headerName = title
			else
				if not isTask and (not isBounty or IsQuestComplete(questID)) and IsQuestComplete(questID) then
					KT_AddQuestWatch(questID, headerName)
				end
			end
		end
	end
	KT.stopUpdate = false

	ObjectiveTracker_Update(OBJECTIVE_TRACKER_UPDATE_MODULE_QUEST)
	if QuestLogFrame:IsVisible() then
		QuestLog_Update()
	end
end

local function Filter_Achievements(spec)
	if not spec then return end
	local trackedAchievements = { GetTrackedAchievements() }

	KT.stopUpdate = true
	if GetNumTrackedAchievements() > 0 then
		for i=1, #trackedAchievements do
			RemoveTrackedAchievement(trackedAchievements[i])
		end
	end

	if spec == "zone" then
		local continentName = KT.GetCurrentMapContinent().name
		local zoneName = GetRealZoneText() or ""
		local categoryName = continentName
		if KT.GetCurrentMapContinent().mapID == 619 then
			categoryName = EXPANSION_NAME6	-- Legion
		elseif KT.GetCurrentMapContinent().mapID == 875 then
			categoryName = EXPANSION_NAME7	-- Battle for Azeroth
		end
		local instance = KT.inInstance and 168 or nil
		_DBG(zoneName.." ... "..KT.GetCurrentMapAreaID(), true)

		-- Dungeons & Raids
		local instanceDifficulty
		if instance and db.filterAchievCat[instance] then
			local _, type, difficulty, difficultyName = GetInstanceInfo()
			local _, _, sufix = strfind(difficultyName, "^.* %((.*)%)$")
			instanceDifficulty = difficultyName
			if sufix then
				instanceDifficulty = sufix
			end
			_DBG(type.." ... "..difficulty.." ... "..difficultyName, true)
		end

		-- World Events
		local events = ""
		if db.filterAchievCat[155] then
			events = GetActiveWorldEvents()
		end

		for i=1, #achievCategory do
			local category = achievCategory[i]
			local name, parentID, _ = GetCategoryInfo(category)

			if db.filterAchievCat[parentID] then
				if (parentID == 92) or										-- General
						(parentID == 96 and name == categoryName) or		-- Quests
						(parentID == 97 and name == categoryName) or		-- Exploration
						(parentID == 95 and strfind(zoneName, name)) or		-- Player vs. Player
						(category == instance or parentID == instance) or	-- Dungeons & Raids
						(parentID == 169) or								-- Professions
						(parentID == 201) or								-- Reputation
						(parentID == 155 and strfind(events, name)) then	-- World Events
					local aNumItems, _ = GetCategoryNumAchievements(category)
					for i=1, aNumItems do
						local track = false
						local aId, aName, _, aCompleted, _, _, _, aDescription = GetAchievementInfo(category, i)
						if aId and not aCompleted then
							--_DBG(aId.." ... "..aName, true)
							if parentID == 95 or
									(not instance and (category == 15117 or parentID == 15117) and strfind(aName.." - "..aDescription, continentName)) then
								track = true
							elseif strfind(aName.." - "..aDescription, zoneName) then
								if category == instance or parentID == instance then
									if instanceDifficulty == "Normal" then
										if not strfind(aName.." - "..aDescription, "[Heroic|Mythic]") then
											track = true
										end
									else
										if strfind(aName.." - "..aDescription, instanceDifficulty) or
												(strfind(aName.." - "..aDescription, "difficulty or higher")) then	-- TODO: other languages
											track = true
										end
									end
								else
									track = true
								end
							elseif strfind(aDescription, " capita") then	-- capital city (TODO: de, ru strings)
								local cNumItems = GetAchievementNumCriteria(aId)
								for i=1, cNumItems do
									local cDescription, _, cCompleted = GetAchievementCriteriaInfo(aId, i)
									if not cCompleted and strfind(cDescription, zoneName) then
										track = true
										break
									end
								end
							end
							if track then
								AddTrackedAchievement(aId)
							end
						end
						if GetNumTrackedAchievements() == MAX_TRACKED_ACHIEVEMENTS then
							break
						end
					end
				end
			end
			if GetNumTrackedAchievements() == MAX_TRACKED_ACHIEVEMENTS then
				break
			end
			if parentID == -1 then
				--_DBG(category.." ... "..name, true)
			end
		end
	elseif spec == "wevent" then
		local events = GetActiveWorldEvents()
		local eventName = ""

		for i=1, #achievCategory do
			local category = achievCategory[i]
			local name, parentID, _ = GetCategoryInfo(category)

			if parentID == 155 and strfind(events, name) then	-- World Events
				eventName = eventName..(eventName ~= "" and ", " or "")..name
				local aNumItems, _ = GetCategoryNumAchievements(category)
				for i=1, aNumItems do
					local aId, aName, _, aCompleted, _, _, _, aDescription = GetAchievementInfo(category, i)
					if aId and not aCompleted then
						AddTrackedAchievement(aId)
					end
					if GetNumTrackedAchievements() == MAX_TRACKED_ACHIEVEMENTS then
						break
					end
				end
			end
			if GetNumTrackedAchievements() == MAX_TRACKED_ACHIEVEMENTS then
				break
			end
			if parentID == -1 then
				--_DBG(category.." ... "..name, true)
			end
		end

		if db.messageAchievement then
			local numTracked = GetNumTrackedAchievements()
			if numTracked == 0 then
				KT:SetMessage("There is currently no World Event.", 1, 1, 0)
			elseif numTracked > 0 then
				KT:SetMessage("World Event - "..eventName, 1, 1, 0)
			end
		end
	end
	KT.stopUpdate = false

	if AchievementFrame then
		AchievementFrameAchievements_ForceUpdate()
	end
	ObjectiveTracker_Update(OBJECTIVE_TRACKER_UPDATE_MODULE_ACHIEVEMENT)
end

local DropDown_Initialize	-- function

local function DropDown_Toggle(level, button)
	local dropDown = KT.DropDown
	if dropDown.activeFrame ~= KTF.FilterButton then
		MSA_CloseDropDownMenus()
	end
	dropDown.activeFrame = KTF.FilterButton
	dropDown.initialize = DropDown_Initialize
	MSA_ToggleDropDownMenu(level or 1, button and MSA_DROPDOWNMENU_MENU_VALUE or nil, dropDown, KTF.FilterButton, -15, -1, nil, button or nil, MSA_DROPDOWNMENU_SHOW_TIME)
	if button then
		_G["MSA_DropDownList"..MSA_DROPDOWNMENU_MENU_LEVEL].showTimer = nil
	end
end

local function DropDown_Filter_Quests(self, spec, idx)
	KT.forceExpand = dbChar.collapsed
	Filter_Quests(spec, idx)
	dbChar.quests.filter = spec
	dbChar.quests.filterIdx = idx
end

local function DropDown_Filter_Achievements(self, spec)
	KT.forceExpand = dbChar.collapsed
	Filter_Achievements(spec)
end

local function DropDown_Filter_AutoTrack(self, id, spec)
	db.filterAuto[id] = (db.filterAuto[id] ~= spec) and spec or nil
	if db.filterAuto[id] then
		KT.forceExpand = dbChar.collapsed
		if id == 1 then
			Filter_Quests(spec)
		elseif id == 2 then
			Filter_Achievements(spec)
		end
		KTF.FilterButton:GetNormalTexture():SetVertexColor(0, 1, 0)
	else
		if id == 1 then
			KT.forceExpand = dbChar.collapsed
			Filter_Quests(dbChar.quests.filter, dbChar.quests.filterIdx)
			if QuestLogFrame:IsVisible() then
				QuestLog_Update()
			end
		elseif id == 2 and AchievementFrame then
			AchievementFrameAchievements_ForceUpdate()
		end
		if not (db.filterAuto[1] or db.filterAuto[2]) then
			KTF.FilterButton:GetNormalTexture():SetVertexColor(KT.headerBtnColor.r, KT.headerBtnColor.g, KT.headerBtnColor.b)
		end
	end
end

local function DropDown_Filter_AchievCat_CheckAll(self, state)
	for id, _ in pairs(db.filterAchievCat) do
		db.filterAchievCat[id] = state
	end
	if db.filterAuto[2] then
		KT.forceExpand = dbChar.collapsed
		Filter_Achievements(db.filterAuto[2])
		MSA_CloseDropDownMenus()
	else
		local listFrame = _G["MSA_DropDownList"..MSA_DROPDOWNMENU_MENU_LEVEL]
		DropDown_Toggle(MSA_DROPDOWNMENU_MENU_LEVEL, _G["MSA_DropDownList"..listFrame.parentLevel.."Button"..listFrame.parentID])
	end
end

local function GetInlineFactionIcon()
	local coords = QUEST_TAG_TCOORDS[strupper(KT.playerFaction)]
	return CreateTextureMarkup(QUEST_ICONS_FILE, QUEST_ICONS_FILE_WIDTH, QUEST_ICONS_FILE_HEIGHT, 22, 22
		, coords[1]
		, coords[2] - 0.02 -- Offset to stop bleeding from next image
		, coords[3]
		, coords[4])
end

function DropDown_Initialize(self, level)
	local numEntries, numQuests = GetNumQuestLogEntries()
	local info = MSA_DropDownMenu_CreateInfo()
	info.isNotRadio = true
	info.iconAtlas = false

	if level == 1 then
		info.notCheckable = true

		-- Quests
		info.text = TRACKER_HEADER_QUESTS
		info.isTitle = true
		MSA_DropDownMenu_AddButton(info)

		info.isTitle = false
		info.disabled = (db.filterAuto[1])
		info.func = DropDown_Filter_Quests

		info.text = "All  ("..numQuests..")"
		info.hasArrow = not (db.filterAuto[1])
		info.value = 1
		info.arg1 = "all"
		MSA_DropDownMenu_AddButton(info)

		info.hasArrow = false

		info.text = "Zone"
		info.arg1 = "zone"
		MSA_DropDownMenu_AddButton(info)

		info.text = "Daily"
		info.icon = QUEST_ICONS_FILE
		info.tCoordLeft = QUEST_TAG_TCOORDS["DAILY"][1]
		info.tCoordRight = QUEST_TAG_TCOORDS["DAILY"][2]
		info.tCoordTop = QUEST_TAG_TCOORDS["DAILY"][3]
		info.tCoordBottom = QUEST_TAG_TCOORDS["DAILY"][4]
		info.arg1 = "daily"
		MSA_DropDownMenu_AddButton(info)

		info.text = "Instance"
		info.iconAtlas = true
		info.icon = "worldquest-icon-dungeon"
		info.arg1 = "instance"
		MSA_DropDownMenu_AddButton(info)

		info.iconAtlas = false

		info.text = "Completed"
		info.iconAtlas = false
		info.icon = QUEST_ICONS_FILE
		info.tCoordLeft = QUEST_TAG_TCOORDS["COMPLETED"][1]
		info.tCoordRight = QUEST_TAG_TCOORDS["COMPLETED"][2]
		info.tCoordTop = QUEST_TAG_TCOORDS["COMPLETED"][3]
		info.tCoordBottom = QUEST_TAG_TCOORDS["COMPLETED"][4]
		info.arg1 = "complete"
		MSA_DropDownMenu_AddButton(info)

		info.icon = nil

		info.text = "Untrack All"
		info.disabled = (db.filterAuto[1] or KT_GetNumQuestWatches() == 0)
		info.arg1 = ""
		MSA_DropDownMenu_AddButton(info)

		info.text = "Sorting"
		info.keepShownOnClick = true
		info.hasArrow = true
		info.disabled = false
		info.value = 2
		info.func = nil
		MSA_DropDownMenu_AddButton(info)

		info.keepShownOnClick = false
		info.hasArrow = false

		info.text = "|cff00ff00Auto|r Zone"
		info.notCheckable = false
		info.disabled = false
		info.arg1 = 1
		info.arg2 = "zone"
		info.checked = (db.filterAuto[info.arg1] == info.arg2)
		info.func = DropDown_Filter_AutoTrack
		MSA_DropDownMenu_AddButton(info)

		MSA_DropDownMenu_AddSeparator(info)

		-- Achievements
		info.text = TRACKER_HEADER_ACHIEVEMENTS
		info.isTitle = true
		MSA_DropDownMenu_AddButton(info)

		info.isTitle = false
		info.disabled = false

		info.text = "Categories"
		info.keepShownOnClick = true
		info.hasArrow = true
		info.value = 3
		info.func = nil
		MSA_DropDownMenu_AddButton(info)

		info.keepShownOnClick = false
		info.hasArrow = false
		info.disabled = (db.filterAuto[2])
		info.func = DropDown_Filter_Achievements

		info.text = "Zone"
		info.arg1 = "zone"
		MSA_DropDownMenu_AddButton(info)

		info.text = "World Event"
		info.arg1 = "wevent"
		MSA_DropDownMenu_AddButton(info)

		info.text = "Untrack All"
		info.disabled = (db.filterAuto[2] or GetNumTrackedAchievements() == 0)
		info.arg1 = ""
		MSA_DropDownMenu_AddButton(info)

		info.text = "|cff00ff00Auto|r Zone"
		info.notCheckable = false
		info.disabled = false
		info.arg1 = 2
		info.arg2 = "zone"
		info.checked = (db.filterAuto[info.arg1] == info.arg2)
		info.func = DropDown_Filter_AutoTrack
		MSA_DropDownMenu_AddButton(info)
	elseif level == 2 then
		info.notCheckable = true

		if MSA_DROPDOWNMENU_MENU_VALUE == 1 then
			info.arg1 = "group"
			info.func = DropDown_Filter_Quests

			if numEntries > 0 then
				local zoneName = GetZoneText() or ""
				local subzoneName = GetSubZoneText() or ""
				local headerTitle, headerOnMap, headerShown
				for i=1, numEntries do
					local title, _, _, isHeader, _, _, _, questID, _, _, isOnMap, _, isTask, isBounty, _, isHidden = GetQuestLogTitle(i)
					if isHeader then
						headerTitle = title
						headerOnMap = (isOnMap or title == zoneName or title == subzoneName)
						headerShown = false
					elseif not isTask and (not isBounty or IsQuestComplete(questID)) and not isHidden then
						if not headerShown then
							info.text = (headerOnMap and "|cff00ff00" or "")..headerTitle
							info.arg2 = i - 1
							MSA_DropDownMenu_AddButton(info, level)
							headerShown = true
						end
					end
				end
			end
		elseif MSA_DROPDOWNMENU_MENU_VALUE == 2 then
			info.notCheckable = false
			info.isNotRadio = false
			info.func = function(_, arg)
				dbChar.quests.sort = arg
				local listFrame = _G["MSA_DropDownList"..MSA_DROPDOWNMENU_MENU_LEVEL]
				DropDown_Toggle(MSA_DROPDOWNMENU_MENU_LEVEL, _G["MSA_DropDownList"..listFrame.parentLevel.."Button"..listFrame.parentID])
				ObjectiveTracker_Update()
			end

			info.text = "Disabled"
			info.arg1 = nil
			info.checked = (dbChar.quests.sort == info.arg1)
			MSA_DropDownMenu_AddButton(info, level)

			info.text = "by Zone"
			info.arg1 = "zone"
			info.checked = (dbChar.quests.sort == info.arg1)
			MSA_DropDownMenu_AddButton(info, level)

			info.text = "by Level"
			info.arg1 = "level"
			info.checked = (dbChar.quests.sort == info.arg1)
			MSA_DropDownMenu_AddButton(info, level)

			info.text = "by Level (reversed)"
			info.arg1 = "levelReversed"
			info.checked = (dbChar.quests.sort == info.arg1)
			MSA_DropDownMenu_AddButton(info, level)

			MSA_DropDownMenu_AddSeparator(info, level)
			info.notCheckable = false
			info.func = function(_, arg)
				dbChar.quests.sortCompleted = arg
				local listFrame = _G["MSA_DropDownList"..MSA_DROPDOWNMENU_MENU_LEVEL]
				DropDown_Toggle(MSA_DROPDOWNMENU_MENU_LEVEL, _G["MSA_DropDownList"..listFrame.parentLevel.."Button"..listFrame.parentID])
				ObjectiveTracker_Update()
			end

			info.text = "Completed not moved"
			info.arg1 = nil
			info.checked = (dbChar.quests.sortCompleted == info.arg1)
			MSA_DropDownMenu_AddButton(info, level)

			info.text = "Completed at top"
			info.arg1 = "top"
			info.checked = (dbChar.quests.sortCompleted == info.arg1)
			MSA_DropDownMenu_AddButton(info, level)

			info.text = "Completed at bottom"
			info.arg1 = "bottom"
			info.checked = (dbChar.quests.sortCompleted == info.arg1)
			MSA_DropDownMenu_AddButton(info, level)
		elseif MSA_DROPDOWNMENU_MENU_VALUE == 3 then
			info.func = DropDown_Filter_AchievCat_CheckAll

			info.text = "Check All"
			info.arg1 = true
			MSA_DropDownMenu_AddButton(info, level)

			info.text = "Uncheck All"
			info.arg1 = false
			MSA_DropDownMenu_AddButton(info, level)

			info.keepShownOnClick = true
			info.notCheckable = false
			info.func = function(_, arg)
				db.filterAchievCat[arg] = not db.filterAchievCat[arg]
				if db.filterAuto[2] then
					DropDown_Filter_Achievements(_, db.filterAuto[2])
					MSA_CloseDropDownMenus()
				end
			end

			for i=1, #achievCategory do
				local id = achievCategory[i]
				local name, parentID, _ = GetCategoryInfo(id)
				if parentID == -1 and id ~= 81 then		-- Skip "Feats of Strength"
					info.text = name
					info.checked = (db.filterAchievCat[id])
					info.arg1 = id
					MSA_DropDownMenu_AddButton(info, level)
				end
			end
		end
	end
end

local function SetFrames()
	-- Event frame
	if not eventFrame then
		eventFrame = CreateFrame("Frame")
		eventFrame:SetScript("OnEvent", function(self, event, arg1, ...)
			_DBG("Event - "..event, true)
			if event == "ADDON_LOADED" and arg1 == "Blizzard_AchievementUI" then
				SetHooks_AchievementUI()
				self:UnregisterEvent(event)
			elseif event == "QUEST_ACCEPTED" or
					event == "ZONE_CHANGED" or
					event == "ZONE_CHANGED_INDOORS" then
				if db.filterAuto[1] == "zone" then
					KT.questStateStopUpdate = true
					Filter_Quests("zone")
					KT.questStateStopUpdate = false
				end
			elseif event == "ZONE_CHANGED_NEW_AREA" then
				if db.filterAuto[1] == "zone" then
					KT.questStateStopUpdate = true
					Filter_Quests("zone")
					KT.questStateStopUpdate = false
				end
				if db.filterAuto[2] == "zone" then
					Filter_Achievements("zone")
				end
			end
		end)
	end
	eventFrame:RegisterEvent("ADDON_LOADED")
	eventFrame:RegisterEvent("QUEST_ACCEPTED")
	eventFrame:RegisterEvent("ZONE_CHANGED")
	eventFrame:RegisterEvent("ZONE_CHANGED_INDOORS")
	eventFrame:RegisterEvent("ZONE_CHANGED_NEW_AREA")

	-- Filter button
	local button = CreateFrame("Button", addonName.."FilterButton", KTF)
	button:SetSize(16, 16)
	button:SetPoint("TOPRIGHT", KTF.MinimizeButton, "TOPLEFT", -4, 0)
	button:SetFrameLevel(KTF:GetFrameLevel() + 10)
	button:SetNormalTexture(mediaPath.."UI-KT-HeaderButtons")
	button:GetNormalTexture():SetTexCoord(0.5, 1, 0.5, 0.75)
	
	button:RegisterForClicks("AnyDown")
	button:SetScript("OnClick", function(self, btn)
		DropDown_Toggle()
	end)
	button:SetScript("OnEnter", function(self)
		self:GetNormalTexture():SetVertexColor(1, 1, 1)
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		GameTooltip:AddLine("Filter", 1, 1, 1)
		GameTooltip:AddLine(db.filterAuto[1] and "- "..db.filterAuto[1].." Quests", 0, 1, 0)
		GameTooltip:AddLine(db.filterAuto[2] and "- "..db.filterAuto[2].." Achievements", 0, 1, 0)
		GameTooltip:Show()
	end)
	button:SetScript("OnLeave", function(self)
		if db.filterAuto[1] or db.filterAuto[2] then
			self:GetNormalTexture():SetVertexColor(0, 1, 0)
		else
			self:GetNormalTexture():SetVertexColor(KT.headerBtnColor.r, KT.headerBtnColor.g, KT.headerBtnColor.b)
		end
		GameTooltip:Hide()
	end)
	KTF.FilterButton = button

	OTFHeader.Title:SetWidth(OTFHeader.Title:GetWidth() - 20)

	-- Move other buttons
	if db.headerOtherButtons then
		local point, _, relativePoint, xOfs, yOfs = KTF.AchievementsButton:GetPoint()
		KTF.AchievementsButton:SetPoint(point, KTF.FilterButton, relativePoint, xOfs, yOfs)
	end
end

--------------
-- External --
--------------

function M:OnInitialize()
	_DBG("|cffffff00Init|r - "..self:GetName(), true)
	db = KT.db.profile
	dbChar = KT.db.char

    local defaults = KT:MergeTables({
        profile = {
            filterAuto = {
				nil,	-- [1] Quests
				nil,	-- [2] Achievements
			},
			filterAchievCat = {
				[92] = true,	-- General
				[96] = true,	-- Quests
				[97] = true,	-- Exploration
				[95] = true,	-- Player vs. Player
				[168] = true,	-- Dungeons & Raids
				[169] = true,	-- Professions
				[201] = true,	-- Reputation
				[155] = true,	-- World Events
			},
        },
		char = {
			quests = {
				filter = nil,
				filterIdx = nil,
				sort = nil,
				sortCompleted = nil,
			},
		}
    }, KT.db.defaults)
	KT.db:RegisterDefaults(defaults)
end

function M:OnEnable()
	_DBG("|cff00ff00Enable|r - "..self:GetName(), true)
	SetHooks()
	SetFrames()
end

function M:QuestSort(questWatchInfoList)
	if KT.IsTableEmpty(questWatchInfoList) then return end

	if dbChar.quests.sort == "zone" then
		-- by Zone
		tsort(questWatchInfoList, function(a, b)
			local aZone, bZone = KT_GetQuestListInfo(a[1], true).zone, KT_GetQuestListInfo(b[1], true).zone
			if aZone == bZone then
				return a[2] < b[2]
			end
			return aZone < bZone
		end)
	elseif dbChar.quests.sort == "level" then
		-- by Level
		tsort(questWatchInfoList, function(a, b)
			if a[2] == b[2] then
				return a[3] < b[3]
			end
			return a[2] < b[2]
		end)
	elseif dbChar.quests.sort == "levelReversed" then
		-- by Level (reverse)
		tsort(questWatchInfoList, function(a, b)
			if a[2] == b[2] then
				return a[3] < b[3]
			end
			return a[2] > b[2]
		end)
	end

	if dbChar.quests.sortCompleted == "top" then
		-- Completed at top
		local idx = 1
		local item
		for i = 1, #questWatchInfoList do
			if questWatchInfoList[i][7] == 1 or questWatchInfoList[i][5] == 0 then
				item = tremove(questWatchInfoList, i)
				tinsert(questWatchInfoList, idx, item)
				idx = idx + 1
			end
		end
	elseif dbChar.quests.sortCompleted == "bottom" then
		-- Completed at bottom
		local idx = #questWatchInfoList
		local item
		for i = #questWatchInfoList, 1, -1 do
			if questWatchInfoList[i][7] == 1 or questWatchInfoList[i][5] == 0 then
				item = tremove(questWatchInfoList, i)
				tinsert(questWatchInfoList, idx, item)
				idx = idx - 1
			end
		end
	end
end

function M:Init()
	if db.filterAuto[1] == "zone" then
		KT.questStateStopUpdate = true
		Filter_Quests("zone")
		KT.questStateStopUpdate = false
	end
end