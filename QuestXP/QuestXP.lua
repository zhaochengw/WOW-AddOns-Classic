local addOnName, ns = ...
local questCache = {}
local LEVEL_CAP = 70

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

    -- pre-calculate zone XP totals (TODO)
    local numEntries, numQuests = GetNumQuestLogEntries()
    for i=1, numEntries, 1 do
        local questLogTitleText, level, questTag, isHeader, isCollapsed, isComplete, frequency, questID, startEvent, displayQuestID, isOnMap, hasLocalPOI, isTask, isBounty, isStory, isHidden, isScaling = GetQuestLogTitle(i);
        if isHeader then
            header = questLogTitleText
            headerXP[header] = 0
        else
            if QXPdb[questID] then
                headerXP[header] = headerXP[header] + QXPdb[questID].XP
            end
        end
    end

    if addonName == "QuestLogEx" then
        numQuestsDisplayed = QuestLogEx.db.global.maxQuestsDisplayed
    else
        numQuestsDisplayed = QUESTS_DISPLAYED
    end

    for i=1, numQuestsDisplayed, 1 do
        local questIndex = i + FauxScrollFrame_GetOffset(_G[addonName.."ListScrollFrame"])
        local questLogTitleText, level, questTag, isHeader, isCollapsed, isComplete, frequency, questID, startEvent, displayQuestID, isOnMap, hasLocalPOI, isTask, isBounty, isStory, isHidden, isScaling = GetQuestLogTitle(questIndex);

        if isHeader then
            -- TODO: work out a way of summarising without it breaking on collpase
            -- if headerXP[questLogTitleText] > 0 then
            --     local questHeaderText = _G[addonName.."ListScrollFrameButton"..i.."NormalText"]
            --     questHeaderText:SetText(string.format("%s (%dxp)", questLogTitleText, headerXP[questLogTitleText]))
            -- end
        elseif QXPdb[questID] then
            local questTitleTag = _G[addonName.."ListScrollFrameButton"..i.."Tag"]
            local questTitleTagText = questTitleTag:GetText() or ""
            local questNormalText = _G[addonName.."ListScrollFrameButton"..i.."NormalText"]
            questTitleTag:SetText(string.format("(%d%s)%s", QXPdb[questID].XP, xpLeveLTag, questTitleTagText))


            if ( isComplete and isComplete < 0 ) then
                questTag = FAILED;
            elseif ( isComplete and isComplete > 0 ) then
                questTag = COMPLETE;
            end
            -- Blizz code for calculating widths
            if ( questTag ) then
                QuestLogDummyText:SetText("  "..questLogTitleText);
                -- Shrink text to accomdate quest tags without wrapping
                tempWidth = 275 - 15 - questTitleTag:GetWidth();

                if ( QuestLogDummyText:GetWidth() > tempWidth ) then
                    textWidth = tempWidth;
                else
                    textWidth = QuestLogDummyText:GetWidth();
                end

                questNormalText:SetWidth(tempWidth);
            else
                if ( questNormalText:GetWidth() > 275 ) then
                    questNormalText:SetWidth(260);
                end
            end
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