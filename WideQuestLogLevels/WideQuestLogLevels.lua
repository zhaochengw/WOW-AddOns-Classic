QuestLogFrame:HookScript('OnUpdate', function(self)
	local numEntries, numQuests = GetNumQuestLogEntries();
	
	if (numEntries == 0) then return end
	
	local questIndex, questLogTitle, title, level, _, isHeader, questTextFormatted, questCheck, questCheckXOfs
	for i = 1, QUESTS_DISPLAYED, 1 do
		questIndex = i + FauxScrollFrame_GetOffset(QuestLogListScrollFrame);
		
		if (questIndex <= numEntries) then
			questLogTitle = _G["QuestLogTitle"..i]
			questCheck = _G["QuestLogTitle"..i.."Check"]
			title, level, _, isHeader = GetQuestLogTitle(questIndex)
			
			if (not isHeader) then
				questTextFormatted = format("  [%d] %s", level, title)
				questLogTitle:SetText(questTextFormatted)
				QuestLogDummyText:SetText(questTextFormatted)
			end

			questCheck:SetPoint("LEFT", questLogTitle, "LEFT", QuestLogDummyText:GetWidth()+24, 0);
		end
	end
end)