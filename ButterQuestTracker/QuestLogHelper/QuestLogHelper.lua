local AceEvent = LibStub:GetLibrary("AceEvent-3.0");
local helper = LibStub:NewLibrary("QuestLogHelper-1.0", 1);
local isWoWClassic = select(4, GetBuildInfo()) < 20000;
-- /dump LibStub("QuestLogHelper-1.0"):GetQuests();
-- /dump LibStub("QuestLogHelper-1.0"):GetWatchedQuests();

local class = UnitClass("player");
local professions = {
    'Herbalism',
    'Mining',
    'Skinning',
    'Alchemy',
    'Blacksmithing',
    'Enchanting',
    'Engineering',
    'Leatherworking',
    'Tailoring',
    'Cooking',
    'Fishing',

    -- Classic Only Professions
    'First Aid',

    -- Retail Only Professions
    'Inscription',
    'Jewelcrafting',
    'Archaeology'
};

local cache = {
    indexToQuestID = {},
    lastUpdated = {}
};

local function trim(s)
  return (s:gsub("^%s*(.-)%s*$", "%1"));
end

local function count(t)
    local _count = 0;
    if t then
        for _, _ in pairs(t) do _count = _count + 1 end
    end
    return _count;
end

local function has_value (tab, val)
    for _, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end

local function getQuestGrayLevel(level)
    if (level <= 5) then
        return 0;
    elseif (level <= 39) then
        return (level - math.floor(level / 10) - 5);
    else
        return (level - math.floor(level / 5) - 1);
    end
end

local function getCompletionPercent(objectives)
    local completionPercent = 0;

    for _, objective in ipairs(objectives) do
        if objective.completed then
            completionPercent = completionPercent + 1;
        elseif objective.numFulfilled ~= 0 then
            completionPercent = completionPercent + (objective.fulfilled / objective.required);
        end
    end

    local n = #objectives;
    if n == 0 then
        return 0
    end
    return completionPercent / n;
end

local listeners = {};
local updateListenersTimer;
local updatedQuests = {};
local function updateListeners(questID, info)
    if updateListenersTimer then
        updateListenersTimer:Cancel();
    end

    updatedQuests[questID] = info;

    updateListenersTimer = C_Timer.NewTimer(0.1, function()
        for _, listener in ipairs(listeners) do
            listener(updatedQuests);
        end
        updatedQuests = {};
    end)
end

function helper:OnQuestUpdated(listener)
    tinsert(listeners, listener);
end

function helper:SetQuestsLastUpdated(questsLastUpdated)
    if not questsLastUpdated then return end

    local quests = self:GetQuests();

    for questID, lastUpdated in pairs(questsLastUpdated) do
        if quests[questID] then
            quests[questID].lastUpdated = lastUpdated;
        else
            questsLastUpdated[questID] = nil;
        end
    end

    return questsLastUpdated;
end

function helper:GetQuestIDFromIndex(index)
    if not index then return nil end

    if cache.indexToQuestID and cache.quests then
        return cache.indexToQuestID[index];
    end

    return nil;
end

function helper:GetIndexFromQuestID(questID)
    local quest = self:GetQuest(questID);

    return quest and quest.index;
end

function helper:GetQuestFrame()
    if not self._questFrame then
        if QuestGuru then -- https://www.curseforge.com/wow/addons/questguru_classic
            self._questFrame = QuestGuru;
            self._questFrame.addon = 'QuestGuru';
        elseif ClassicQuestLog then -- https://www.curseforge.com/wow/addons/classic-quest-log
            self._questFrame = ClassicQuestLog;
            self._questFrame.addon = 'ClassicQuestLog';
        elseif QuestLogEx then -- https://www.wowinterface.com/downloads/info24980-QuestLogEx.html
            self._questFrame = QuestLogExFrame;
            self._questFrame.addon = 'QuestLogEx';
        elseif QuestLogFrame then -- This is the built-in frame for classic, however sometimes it isn't initialized...
            self._questFrame = QuestLogFrame;
            self._questFrame.addon = 'Classic';
        elseif WorldMapFrame then
            self._questFrame = WorldMapFrame;
            self._questFrame.addon = 'Retail';
        end
    end

    return self._questFrame;
end

function helper:IsShown()
    return self:GetQuestFrame() and self:GetQuestFrame():IsShown();
end

function helper:IsQuestSelected(index)
    return GetQuestLogSelection() == index;
end

function helper:GetWowheadURL(questID)
    if isWoWClassic then
        return "https://classic.wowhead.com/quest=" .. questID;
    end

    return "https://wowhead.com/quest=" .. questID;
end

function helper:ToggleQuest(index, forceShow)
    local isQuestAlreadyOpen = self:IsShown() and self:IsQuestSelected(index);
    local questFrame = self:GetQuestFrame();

    if not questFrame then
        return false;
    end

    if isQuestAlreadyOpen then
        HideUIPanel(questFrame);
    else
        ShowUIPanel(questFrame);
        self:Select(index);

        if questFrame.addon == 'QuestLogEx' then
            QuestLogEx:Maximize();
        elseif questFrame.addon == 'Classic' then
            local valueStep = QuestLogListScrollFrame.ScrollBar:GetValueStep();
            QuestLogListScrollFrame.ScrollBar:SetValue(index * valueStep - valueStep * 3);
        elseif questFrame.addon == 'Retail' then
            QuestMapFrame_ShowQuestDetails(self:GetQuestIDFromIndex(index));
        end
    end
end

function helper:GetDifficulty(level)
    local playerLevel = UnitLevel("player");

    if (level > (playerLevel + 4)) then
        return 4; -- Extremely Hard (Red)
    elseif (level > (playerLevel + 2)) then
        return 3; -- Hard (Orange)
    elseif (level <= (playerLevel + 2)) and (level >= (playerLevel - 2)) then
        return 2; -- Normal (Yellow)
    elseif (level > getQuestGrayLevel(playerLevel)) then
        return 1; -- Easy
    end

    return 0; -- Too Easy
end

function helper:GetDifficultyColor(difficulty)
    if (difficulty == 4) then
         -- Red
        return { r = 1, g = 0.1, b = 0.1 };
    elseif (difficulty == 3) then
        return { r = 1, g = 0.5, b = 0.25 }; -- Orange
    elseif (difficulty == 2) then
        return { r = 1, g = 1, b = 0 }; -- Yellow
    elseif (difficulty == 1) then
        return { r = 0.25, g = 0.75, b = 0.25 }; -- Green
    end

    return { r = 0.75, g = 0.75, b = 0.75 }; -- Grey
end

function helper:Refresh()
    local initialized = cache.quests and true;
    cache.quests = cache.quests or {};

    local numberOfEntries = GetNumQuestLogEntries();

    for questID, quest in pairs(cache.quests) do
        if not C_QuestLog.IsOnQuest(questID) then
            cache.quests[questID] = nil;
            cache.lastUpdated[questID] = nil;
            cache.indexToQuestID[quest.index] = nil;

            updateListeners(questID, {
                index = quest.index,
                questID = quest.questID,
                lastUpdated = quest.lastUpdated,
                previousCompletionPercent = quest.completionPercent,
                completionPercent = quest.completionPercent,
                abandoned = true
            });
        end
    end

	local zone;
    for index = 1, numberOfEntries, 1 do
        local title, level, _, isHeader, _, isComplete, _, questID = GetQuestLogTitle(index);
        local isClassQuest = zone == class;
        local isProfessionQuest = has_value(professions, zone);

        if isHeader then
            zone = title;
        else
            local accepted = initialized and not cache.quests[questID] and true;

            if not cache.quests[questID] then
                cache.quests[questID] = {
                    title = title,
                    level = level,
                    questID = questID,
                    zone = zone,

                    -- Extras

                    sharable = self:IsQuestSharable(index),
                    summary = self:GetQuestSummary(index),
                    isClassQuest = isClassQuest,
                    isProfessionQuest = isProfessionQuest
                };
            end

            local quest = cache.quests[questID];

            if quest.index and cache.indexToQuestID[quest.index] == questID then
                cache.indexToQuestID[quest.index] = nil;
            end
            cache.indexToQuestID[index] = questID;

            quest.index = index;
            quest.completed = isComplete == 1;
            quest.failed = isComplete == -1;
            quest.difficulty = self:GetDifficulty(level);
            quest.objectives = self:GetObjectives(questID);

            local completionPercent = getCompletionPercent(quest.objectives);

            local updated = quest.completionPercent and quest.completionPercent ~= completionPercent;
            if updated then
                quest.lastUpdated = time();

                updateListeners(questID, {
                    index = quest.index,
                    questID = quest.questID,
                    lastUpdated = quest.lastUpdated,
                    previousCompletionPercent = quest.completionPercent,
                    completionPercent = completionPercent,
                    accepted = accepted,
                    updated = updated
                });
            elseif accepted then
                quest.lastUpdated = time();

                updateListeners(questID, {
                    index = quest.index,
                    questID = quest.questID,
                    lastUpdated = quest.lastUpdated,
                    previousCompletionPercent = quest.completionPercent,
                    completionPercent = completionPercent,
                    accepted = accepted,
                    updated = updated
                });
            else
                quest.lastUpdated = quest.lastUpdated or cache.lastUpdated[questID];
            end

            quest.completionPercent = getCompletionPercent(quest.objectives);
        end
    end

    return cache.quests;
end

function helper:AreQuestsLoaded()
    return cache.quests ~= nil;
end

function helper:GetQuests()
    if not self:AreQuestsLoaded() then
        self:Refresh();
    end

    return cache.quests;
end

function helper:GetQuest(questID)
    if not cache.quests then
        self:Refresh();
    end

    return cache.quests[questID];
end

function helper:GetQuestCount()
    return count(helper:GetQuests());
end

function helper:GetWatchedQuests()
    local quests = self:GetQuests();
    local watchedQuests = {};

    for questID, quest in pairs(quests) do
        if IsQuestWatched(quest.index) then
            watchedQuests[questID] = quest;
        end
    end

    return watchedQuests;
end

function helper:GetObjectives(questID)
    local objectives = C_QuestLog.GetQuestObjectives(questID);
    local formattedObjectives = {};

    for i, objective in ipairs(objectives) do
        -- Some quests will return blank objectives.
        --
        -- Examples
        -- - https://classic.wowhead.com/quest=1149
        if objective.text and trim(objective.text) ~= "" then
            formattedObjectives[i] = {
                text = objective.text,
                type = objective.type,
                completed = objective.finished,
                fulfilled = objective.numFulfilled,
                required = objective.numRequired
            };
        end
    end

    return formattedObjectives;
end

function helper:IsQuestSharable(index)
    self:SetFocusByQuestIndex(index);
    local sharable = GetQuestLogPushable();
    self:RevertFocus();

    return sharable;
end

function helper:AbandonQuest(index)
    self:SetFocusByQuestIndex(index);
    SetAbandonQuest();
    AbandonQuest();
    self:RevertFocus();
end

function helper:ShareQuest(index)
    self:SetFocusByQuestIndex(index);
    QuestLogPushQuest();
    self:RevertFocus();
end

function helper:GetQuestSummary(index)
    self:SetFocusByQuestIndex(index);
    local _, desc = GetQuestLogQuestText();
    self:RevertFocus();

    return desc;
end

function helper:Select(index)
    if isWoWClassic then
        QuestLog_SetSelection(index);
    else
        SelectQuestLogEntry(index);
    end
end

function helper:SetFocusByQuestIndex(index)
    local questID = self:GetQuestIDFromIndex(index);

    local options = {
        questLog = index
    };

    if isWoWClassic then
        -- Do wow classic specific focus logic
    else
        options.worldMap = questID;
        options.superTracked = questID;
    end

    self:SetFocus(options);
end

local previousValues;
function helper:SetFocus(options)
    previousValues = {};

    if options.questLog then
        previousValues.questLog = GetQuestLogSelection();
        self:Select(options.questLog);
    end

    if options.superTracked and not isWoWClassic then
        previousValues.superTracked = GetSuperTrackedQuestID();
        SetSuperTrackedQuestID(options.superTracked);
    end
end

function helper:RevertFocus()
    if not previousValues then return end

    self:SetFocus(previousValues);
    previousValues = nil;
end

AceEvent.RegisterEvent(helper, "QUEST_LOG_UPDATE", "Refresh");
