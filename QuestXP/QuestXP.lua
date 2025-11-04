local addOnName, ns = ...
local questCache = {}
local LEVEL_CAP = GetMaxPlayerLevel()

local QXP = CreateFrame("FRAME")
QXP:RegisterEvent("ADDON_LOADED")

function QXP:ADDON_LOADED(loadedAddOnName)
    if loadedAddOnName == addOnName then
        QXPdb = QXPdb or {}

        QXP:RegisterEvent("QUEST_DETAIL")
        QXP:RegisterEvent("QUEST_ACCEPTED")
        QXP:RegisterEvent("QUEST_REMOVED")

        hooksecurefunc("QuestLog_Update", function()
            QXP:QuestLog_Update()
        end)

        hooksecurefunc(QuestLogListScrollFrame, "update", function()
            QXP:QuestLog_Update()
        end)
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

function QXP:QuestLog_Update()
    local xpLeveLTag = 'xp'
    if UnitLevel("player") == LEVEL_CAP then
        xpLeveLTag = '**'
    end

    local numEntries = GetNumQuestLogEntries();
    local scrollOffset = HybridScrollFrame_GetOffset(QuestLogListScrollFrame);
	local buttons = QuestLogListScrollFrame.buttons;

    for i=1, QUESTS_DISPLAYED, 1 do
		local questLogTitle = buttons[i];
		local questIndex = i + scrollOffset;
		questLogTitle:SetID(questIndex);

		local questTitleTag = questLogTitle.tag;
        if ( questIndex <= numEntries ) then
            local questLogTitleText, level, questTag, isHeader, isCollapsed, isComplete, frequency, questID = GetQuestLogTitle(questIndex)

            if not isHeader then           
                if QXPdb[questID] then
                    if questTitleTag:GetText() then
                        questTitleTag:SetText(string.format("(%d%s)%s", QXPdb[questID].XP, xpLeveLTag, questTitleTag:GetText()));
                    else
                        questTitleTag:SetText(string.format("(%d%s)", QXPdb[questID].XP, xpLeveLTag))
                        questTitleTag:Show()
                    end

                    QuestLogTitleButton_Resize(questLogTitle);
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