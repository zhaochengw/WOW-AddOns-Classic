QuestLogFrame:HookScript('OnUpdate', function(self)
	local numEntries, numQuests = GetNumQuestLogEntries()
	
	if (numEntries == 0) then return end
	
	local questIndex, questLogTitle, title, level, _, isHeader, questTextFormatted, questCheck
	for i = 1, _G.QUESTS_DISPLAYED, 1 do
		questIndex = i + FauxScrollFrame_GetOffset(QuestLogListScrollFrame)
		
		if (questIndex <= numEntries) then
			questLogTitle = _G["QuestLogTitle"..i]
			questCheck = _G["QuestLogTitle"..i.."Check"]
			title, level, _, isHeader = GetQuestLogTitle(questIndex)
			
			if (not isHeader) then
				questTextFormatted = format("  [%d] %s", level, title)
				questLogTitle:SetText(questTextFormatted)
				questCheck:SetPoint("LEFT", questLogTitle, "LEFT", questLogTitle.Text:GetStringWidth()+15, 0)
				questCheck:SetVertexColor(64/255,224/255,208/255)
				questCheck:SetDrawLayer("ARTWORK")
			else
				questCheck:Hide()
			end
		end
	end
end)