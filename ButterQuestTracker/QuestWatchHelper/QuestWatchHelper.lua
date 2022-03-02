local AceEvent = LibStub:GetLibrary("AceEvent-3.0");
local QLH = LibStub("QuestLogHelper-1.0");
local helper = LibStub:NewLibrary("QuestWatchHelper-1.0", 1);
local isWoWClassic = select(4, GetBuildInfo()) < 30000;

local BlizzardTrackerFrame = isWoWClassic and QuestWatchFrame or ObjectiveTrackerFrame;

local timers = {};
local function debounce(name, func)
    if timers[name] then
        timers[name]:Cancel();
    end

    timers[name] = C_Timer.NewTimer(0.1, func);
end

local listeners = {};
local updatedQuestIndexes = {};
local function updateListeners(updatedQuest)
    updatedQuest.byUser = IsShiftKeyDown() and QLH:IsShown();
    updatedQuestIndexes[updatedQuest.index] = updatedQuest;

    debounce("listeners", function()
        for _, listener in ipairs(listeners) do
            listener(updatedQuestIndexes);
        end
        updatedQuestIndexes = {};
    end);
end

local function count(t)
    local _count = 0;
    for _, _ in pairs(t) do _count = _count + 1 end
    return _count;
end

local function findIndex(t, element)
    for index, value in pairs(t) do
        if value == element then
            return index;
        end
    end
end

function helper:GetFrame()
    return BlizzardTrackerFrame;
end

function helper:IsAutomaticQuestWatchEnabled()
    return GetCVar('autoQuestWatch') == '1';
end

function helper:SetAutomaticQuestWatch(autoQuestWatch)
    SetCVar('autoQuestWatch', autoQuestWatch and '1' or '0');
end

function helper:BypassWatchLimit(initialTrackedQuests)
    local trackedQuests = {};

    if isWoWClassic then
        local function _addWatch(index, isQuestie)
            -- This is a hack to ignore watch requests from Questie's Tracker...
            if isQuestie then return end

            local questID = QLH:GetQuestIDFromIndex(index);

            -- Ignore duplicates
            if questID and not trackedQuests[questID] then
                trackedQuests[questID] = true;

                updateListeners({
                    index = index,
                    questID = questID,
                    watched = true
                });
            end
        end

        hooksecurefunc("AutoQuestWatch_Insert", _addWatch);
        hooksecurefunc("AddQuestWatch", _addWatch);
        hooksecurefunc("RemoveQuestWatch", function(index, isQuestie)
            -- This is a hack to ignore watch requests from Questie's Tracker...
            if isQuestie then return end

            local questID = QLH:GetQuestIDFromIndex(index);

            -- Ignore duplicates
            if questID and trackedQuests[questID] then
                trackedQuests[questID] = nil;

                updateListeners({
                    index = index,
                    questID = questID,
                    watched = false
                });
            end
        end);

        IsQuestWatched = function(index)
            return trackedQuests[QLH:GetQuestIDFromIndex(index)] or false;
        end

        GetNumQuestWatches = function()
            return 0;
        end

        -- This bypasses a limitation that would prevent users from tracking quests without objectives
        GetNumQuestLeaderBoards = function(index)
            index = index or GetQuestLogSelection();
            local questID = QLH:GetQuestIDFromIndex(index);

            if not questID then return 0 end

            local quest = QLH:GetQuest(questID);

            if not quest then return 0 end

            local objectiveCount = count(quest.objectives);

            if objectiveCount == 0 then return 1 end

            return objectiveCount;
        end

        MAX_WATCHABLE_QUESTS = C_QuestLog.GetMaxNumQuests();

        QLH:OnQuestUpdated(function(quests)
            for questID, quest in pairs(quests) do
                if quest.abandoned and trackedQuests[questID] then
                    trackedQuests[questID] = nil;

                    updateListeners({
                        index = quest.index,
                        questID = quest.questID,
                        watched = false
                    });
                end
            end
        end);
    end

    for _, quest in pairs(QLH:GetQuests()) do
        if initialTrackedQuests[quest.questID] then
            AddQuestWatch(quest.index);
        else
            RemoveQuestWatch(quest.index);
        end
    end
end

function helper:OnQuestWatchUpdated(listener)
    tinsert(listeners, listener);
end

function helper:OffQuestWatchUpdated(listener)
    local index = findIndex(listeners, listener);

    if not index then return end

    table.remove(listeners, index);
end

function helper:KeepHidden()
    BlizzardTrackerFrame:HookScript("OnShow", function(frame)
        return frame:Hide()
    end);
    BlizzardTrackerFrame:Hide();
end

if not isWoWClassic then
    AceEvent.RegisterEvent(helper, "QUEST_WATCH_LIST_CHANGED", function(event, questID, added)
        if questID then
            if added then
                C_Timer.After(0.1, function()
                    local index = QLH:GetIndexFromQuestID(questID);

                    updateListeners({
                        index = index,
                        questID = questID,
                        watched = added == true
                    });
                end);
            else
                local index = QLH:GetIndexFromQuestID(questID);

                updateListeners({
                    index = index,
                    questID = questID,
                    watched = added == true
                });
            end
        end
    end);
end
