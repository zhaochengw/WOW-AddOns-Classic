--- Kaliel's Tracker
--- Copyright (c) 2012-2023, Marouan Sabbagh <mar.sabbagh@gmail.com>
--- All Rights Reserved.
---
--- This file is part of addon Kaliel's Tracker.

local addonName, KT = ...
local M = KT:NewModule(addonName.."_QuestLog")
KT.QuestLog = M

local _DBG = function(...) if _DBG then _DBG("KT", ...) end end

local db, dbChar

local dropDownFrame

--------------
-- Internal --
--------------

local function IsQuestInList(questID)
	local result = false
	for _, quest in ipairs(dbChar.trackedQuests) do
		if quest.id == questID then
			result = true
			break
		end
	end
	return result
end

local function AddQuestToList(questID, zone)
	if not IsQuestInList(questID) then
		tinsert(dbChar.trackedQuests, { ["id"] = questID, ["zone"] = zone })
	end
end

local function RemoveQuestFromList(questID)
	for k, quest in ipairs(dbChar.trackedQuests) do
		if quest.id == questID then
			tremove(dbChar.trackedQuests, k)
			break
		end
	end
end

local function SetHooks()
	-- Quest Log -------------------------------------------------------------------------------------------------------

	function _QuestLog_ToggleQuestWatch(questIndex)  -- R
		if KT_GetNumQuestWatches() < MAX_WATCHABLE_QUESTS then
			local questID = GetQuestIDFromLogIndex(questIndex)
			if IsQuestWatched(questIndex) then
				KT_RemoveQuestWatch(questID)
			else
				KT_AddQuestWatch(questID)
			end
		end
	end

	function QuestLogTitleButton_OnClick(self, button)  -- R
		if ( self.isHeader ) then
			return;
		end
		local questName = self:GetText()
		local questIndex = self:GetID()
		local questID = GetQuestIDFromLogIndex(questIndex)
		if ( IsModifiedClick("CHATLINK") and ChatEdit_GetActiveWindow() ) then
			-- Trim leading whitespace and put it into chat
			ChatEdit_InsertLink("["..gsub(questName, " *(.*)", "%1").." ("..questID..")]")
		elseif ( IsShiftKeyDown() ) then
			-- Shift-click toggles quest-watch on this quest.
			if not db.filterAuto[1] then
			    _QuestLog_ToggleQuestWatch(questIndex)
			end
		end
		QuestLog_SetSelection(questIndex)
		QuestLog_Update()
	end

	-- Quest Watch -----------------------------------------------------------------------------------------------------

	function IsQuestWatched(questLogIndex)  -- R
		local questID = GetQuestIDFromLogIndex(questLogIndex)
		return IsQuestInList(questID)
	end

	WatchFrame_Update = function() end
end

--------------
-- External --
--------------

function KT_GetQuestListInfo(id, isQuestID)
	if isQuestID then
		for k, quest in ipairs(dbChar.trackedQuests) do
			if quest.id == id then
				id = k
				break
			end
		end
	end
	return dbChar.trackedQuests[id]
end

function KT_GetNumQuestWatches()
	return #dbChar.trackedQuests
end

function KT_AddQuestWatch(questID, zone)
	if not zone then
		zone = KT.QuestUtils_GetQuestZone(questID)
	end
	AddQuestToList(questID, zone)
	KT:Event_QUEST_WATCH_LIST_CHANGED(questID, true)
end

function KT_RemoveQuestWatch(questID)
	RemoveQuestFromList(questID)
	KT:Event_QUEST_WATCH_LIST_CHANGED(questID)
end

function KT_SanitizeQuestList()
	local questInfo, questLogIndex
	for i = #dbChar.trackedQuests, 1, -1 do
		questInfo = dbChar.trackedQuests[i]
		questLogIndex = GetQuestLogIndexByID(questInfo.id)
		if not questLogIndex or questLogIndex <= 0 then
			tremove(dbChar.trackedQuests, i)
		end
	end
end

function M:OnInitialize()
	_DBG("|cffffff00Init|r - "..self:GetName(), true)
	db = KT.db.profile
	dbChar = KT.db.char
end

function M:OnEnable()
	_DBG("|cff00ff00Enable|r - "..self:GetName(), true)

	-- Clear Blizzard Quest Watch List
	for i=GetNumQuestWatches(), 1, -1 do
		local questIndex = GetQuestIndexForWatch(i)
		RemoveQuestWatch(questIndex)
	end
	WatchFrame_Update()

	SetHooks()
end