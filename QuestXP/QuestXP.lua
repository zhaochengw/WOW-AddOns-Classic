local addOnName, ns = ...
local questCache = {}
local LEVEL_CAP = 80

local QXP = CreateFrame("FRAME")
QXP:RegisterEvent("ADDON_LOADED")

function QXP:ADDON_LOADED(loadedAddOnName)
    if loadedAddOnName == addOnName then
        QXPdb = QXPdb or {}

        QXP:RegisterEvent("QUEST_DETAIL")
        QXP:RegisterEvent("QUEST_ACCEPTED")
        QXP:RegisterEvent("QUEST_REMOVED")

        hooksecurefunc("QuestLog_Update", function()
            QXP:QuestLog_Update("QuestLog")
        end)

        hooksecurefunc(QuestLogListScrollFrame, "update", function()
            QXP:QuestLog_Update("QuestLog")
        end)

        -- support QuestLogEx
        if QuestLogEx then
            hooksecurefunc("QuestLog_Update", function()
                QXP:QuestLog_Update("QuestLogEx")
            end)
        end
    end
end

function QXP:QUEST_DETAIL()
    local questID = GetQuestID()
    local questXP = GetRewardXP()

    if questID > 0 and questXP > 0 then
        questCache[questID] = {
            XP = questXP
        }
    end
end

function QXP:QUEST_ACCEPTED(questIndex, questID)
    if questCache[questID] then
        QXPdb[questID] = questCache[questID]
    else
        local questXP = GetRewardXP()
        if questXP > 0 then
            QXPdb[questID] = {
                XP = questXP
            }
        end
    end
end

function QXP:QUEST_REMOVED(questID)
    QXPdb[questID] = nil
end

function QXP:QuestLog_Update(addonName)
    local headerXP = {}
    local header
    local xpLeveLTag = 'xp'

    if UnitLevel("player") == LEVEL_CAP then
        xpLeveLTag = '**'
    end

    local numEntries, numQuests = GetNumQuestLogEntries();
    local scrollOffset = HybridScrollFrame_GetOffset(QuestLogListScrollFrame);
    local buttons = QuestLogListScrollFrame.buttons;
    local buttonHeight = buttons[1]:GetHeight();
    local displayedHeight = 0;

    local questIndex, questLogTitle, questTitleTag, questNumGroupMates, questNormalText, questHighlight, questCheck;
    local questLogTitleText, level, questTag, isHeader, isCollapsed, isComplete, color;
    local numPartyMembers, partyMembersOnQuest, tempWidth, textWidth;

    if addonName == "QuestLogEx" then
        numQuestsDisplayed = QuestLogEx.db.global.maxQuestsDisplayed
    else
        numQuestsDisplayed = QUESTS_DISPLAYED
    end

    for i=1, numQuestsDisplayed, 1 do
        questLogTitle = buttons[i];
        questIndex = i + scrollOffset;
        questLogTitle:SetID(questIndex);
        questTitleTag = questLogTitle.tag;
        questNumGroupMates = questLogTitle.groupMates;
        questCheck = questLogTitle.check;
        questNormalText = questLogTitle.normalText

        -- Need to get the quest info here, for the buttons
        if ( questIndex <= numEntries ) then
            questLogTitleText, level, questTag, isHeader, isCollapsed, isComplete, frequency, questID, startEvent, displayQuestID, isOnMap, hasLocalPOI, isTask, isBounty, isStory, isHidden, isScaling = GetQuestLogTitle(questIndex);

            -- Set the quest tag
            if ( isComplete and isComplete < 0 ) then
                questTag = FAILED;
            elseif ( isComplete and isComplete > 0 ) then
                questTag = COMPLETE;
            elseif ( frequency == LE_QUEST_FREQUENCY_DAILY ) then
                if ( questTag ) then
                    questTag = format(DAILY_QUEST_TAG_TEMPLATE, questTag);
                else
                    questTag = DAILY;
                end
            end

            if ( questTag ) then
                if QXPdb[questID] then
                    questTitleTag:SetText(string.format("(%d%s)(%s)", QXPdb[questID].XP, xpLeveLTag, questTag));
                else
                    questTitleTag:SetText("("..questTag..")");
                end
                -- Shrink text to accomdate quest tags without wrapping
                tempWidth = 275 - 15 - questTitleTag:GetWidth();

                if ( QuestLogDummyText:GetWidth() > tempWidth ) then
                    textWidth = tempWidth;
                else
                    textWidth = QuestLogDummyText:GetWidth();
                end
                questNormalText:SetWidth(tempWidth);
                -- If there's quest tag position check accordingly
                questTitleTag:Show();
                --questCheck:Hide();
            else
                if QXPdb[questID] then
                    questTitleTag:SetText(string.format("(%d%s)", QXPdb[questID].XP, xpLeveLTag));

                    -- Shrink text to accomdate quest tags without wrapping
                    tempWidth = 275 - 15 - questTitleTag:GetWidth();

                    if ( QuestLogDummyText:GetWidth() > tempWidth ) then
                        textWidth = tempWidth;
                    else
                        textWidth = QuestLogDummyText:GetWidth();
                    end
                    questNormalText:SetWidth(tempWidth);
                    -- If there's quest tag position check accordingly
                    questTitleTag:Show();
                    --questCheck:Hide();
                else
                    questTitleTag:SetText("");
                end
            end

            QuestLogTitleButton_Resize(questLogTitle)
        end
    end

end

QXP:SetScript("OnEvent",
    function (self, event, ...)
        if self[event] then
            return self[event](self, ...)
        end
    end
)