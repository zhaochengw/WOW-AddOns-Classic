local addonName, addonTable = ...;
local fuFrame=List_R_F_1_11.F
local _, _, _, tocversion = GetBuildInfo()
local ADD_Checkbutton=addonTable.ADD_Checkbutton
local Create=addonTable.Create
local PIGDownMenu=Create.PIGDownMenu
--任务完成
local AudioList = {
	{"升级音效",567431},
	{"就位音效",567478},
	{"露露语音1","Interface/AddOns/"..addonName.."_Rurutia/media/ogg/1.ogg"},
	{"露露语音2","Interface/AddOns/"..addonName.."_Rurutia/media/ogg/2.ogg"},
	{"露露语音3","Interface/AddOns/"..addonName.."_Rurutia/media/ogg/3.ogg"},
	{"露露语音4","Interface/AddOns/"..addonName.."_Rurutia/media/ogg/4.ogg"},
	{"露露语音5","Interface/AddOns/"..addonName.."_Rurutia/media/ogg/5.ogg"},
}

local QuestsEndFrameUI = CreateFrame("Frame");
QuestsEndFrameUI.wanchengqingkuang={}
QuestsEndFrameUI.chucijiazai=false
local function huoqurenwuzhuangtai()
	if tocversion<100000 then
		local numShownEntries, numQuests = GetNumQuestLogEntries()
		for i=1,numShownEntries do
			local title, level, suggestedGroup, isHeader, isCollapsed, isComplete, frequency, questID = GetQuestLogTitle(i)
			if not isHeader then--不是标题
				local yiwancheng = true
				--print(isComplete)
				if isComplete==1 then	
					if not QuestsEndFrameUI.wanchengqingkuang[questID] and QuestsEndFrameUI.chucijiazai then
						PlaySoundFile(AudioList[PIG["Rurutia"]["QuestsEndAudio"]][2], "Master")	
					end
				else
					yiwancheng = false
				end
				QuestsEndFrameUI.wanchengqingkuang[questID]=yiwancheng
				-- local numQuestLogLeaderBoards,= GetNumQuestLeaderBoards(questID)
				-- for ii=1,1 do
				-- 	local description, objectiveType, isCompleted = GetQuestLogLeaderBoard(ii, i)
				-- 	print(description, objectiveType, isCompleted)
				-- end
			end
		end
	else
		local numShownEntries, numQuests = C_QuestLog.GetNumQuestLogEntries()
		for i=1,numShownEntries do
			local info = C_QuestLog.GetInfo(i)
			if not info.isHeader then--不是标题
				local objectives = C_QuestLog.GetQuestObjectives(info.questID)
				local renwuzixiang = #objectives
				if renwuzixiang>0 then
					local yiwancheng = true
					for ii=1,renwuzixiang do
						if not objectives[ii].finished then
							yiwancheng = objectives[ii].finished
							break
						end
					end
					if yiwancheng then
						if not QuestsEndFrameUI.wanchengqingkuang[info.questID] and QuestsEndFrameUI.chucijiazai then
							PlaySoundFile(AudioList[PIG["Rurutia"]["QuestsEndAudio"]][2], "Master")	
						end		
					end
					QuestsEndFrameUI.wanchengqingkuang[info.questID]=yiwancheng
				end
			end
		end
	end
	QuestsEndFrameUI.chucijiazai=true
end
local function zhucewshijian()
	huoqurenwuzhuangtai()
	QuestsEndFrameUI:RegisterEvent("QUEST_WATCH_UPDATE")
	QuestsEndFrameUI:RegisterEvent("QUEST_WATCH_LIST_CHANGED")
	QuestsEndFrameUI:RegisterEvent("QUEST_LOG_UPDATE")
	QuestsEndFrameUI:RegisterEvent("UNIT_QUEST_LOG_CHANGED")
end
local function QuestsEnd_Open()
	QuestsEndFrameUI:RegisterEvent("PLAYER_ENTERING_WORLD")
	QuestsEndFrameUI:SetScript("OnEvent", function(self,event,arg1,arg2,arg3)
		--print(event,arg1,arg2,arg3)
		if event=="PLAYER_ENTERING_WORLD" then
			C_Timer.After(6,zhucewshijian)
		else
			huoqurenwuzhuangtai()
		end
	end)
end
fuFrame.QuestsEnd =ADD_Checkbutton(nil,fuFrame,-100,"TOPLEFT",fuFrame,"TOPLEFT",20,-80,"任务完成提示音","任务完成提示音")
fuFrame.QuestsEnd:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG["Rurutia"]["QuestsEnd"]="ON";	
	else
		PIG["Rurutia"]["QuestsEnd"]="OFF";
	end
	QuestsEnd_Open()
end);
fuFrame.QuestsEnd.xiala=PIGDownMenu(nil,{120,24},fuFrame.QuestsEnd,{"LEFT",fuFrame.QuestsEnd.Text, "RIGHT", 4,0})
function fuFrame.QuestsEnd.xiala:PIGDownMenu_Update_But(self)
	local info = {}
	info.func = self.PIGDownMenu_SetValue
	for i=1,#AudioList,1 do
	    info.text, info.arg1 = AudioList[i][1], i
	    info.checked = i==PIG["Rurutia"]["QuestsEndAudio"]
		fuFrame.QuestsEnd.xiala:PIGDownMenu_AddButton(info)
	end 
end
function fuFrame.QuestsEnd.xiala:PIGDownMenu_SetValue(value,arg1)
	fuFrame.QuestsEnd.xiala:PIGDownMenu_SetText(value)
	PIG["Rurutia"]["QuestsEndAudio"]=arg1
	PIGCloseDropDownMenus()
end

fuFrame.QuestsEnd.PlayBut = CreateFrame("Button",nil,fuFrame.QuestsEnd);
fuFrame.QuestsEnd.PlayBut:SetNormalTexture("interface/buttons/ui-spellbookicon-nextpage-up.blp")
fuFrame.QuestsEnd.PlayBut:SetPushedTexture("interface/buttons/ui-spellbookicon-nextpage-down.blp")
fuFrame.QuestsEnd.PlayBut:SetDisabledTexture("interface/buttons/ui-spellbookicon-nextpage-disabled.blp")
fuFrame.QuestsEnd.PlayBut:SetHighlightTexture("interface/buttons/ui-common-mousehilight.blp");--高亮纹理
fuFrame.QuestsEnd.PlayBut:SetSize(28,28);
fuFrame.QuestsEnd.PlayBut:SetPoint("LEFT",fuFrame.QuestsEnd.xiala,"RIGHT",8,0);
fuFrame.QuestsEnd.PlayBut:SetScript("OnClick", function()
	PlaySoundFile(AudioList[PIG["Rurutia"]["QuestsEndAudio"]][2], "Master")
end)
fuFrame.weijiancedao = fuFrame:CreateFontString();
fuFrame.weijiancedao:SetPoint("LEFT", fuFrame.QuestsEnd.PlayBut, "RIGHT", 6, 0);
fuFrame.weijiancedao:SetFont(ChatFontNormal:GetFont(), 14,"OUTLINE")
fuFrame.weijiancedao:SetTextColor(1, 1, 0, 1);
fuFrame.weijiancedao:SetText("没有检测到露露扩展包");

--打开选项页面时===============
fuFrame:HookScript("OnShow", function (self)
	fuFrame.QuestsEnd.xiala:PIGDownMenu_SetText(AudioList[PIG["Rurutia"]["QuestsEndAudio"]][1])
	if PIG["Rurutia"]["QuestsEnd"]=="ON" then
		fuFrame.QuestsEnd :SetChecked(true);
	end
	local name, title, notes, loadable = GetAddOnInfo(addonName.."_Rurutia")
	if loadable then
		fuFrame.weijiancedao:Hide()	
	end
end);
--进入游戏时加载
addonTable.Rurutia_QuestsEnd = function()
 	if PIG["Rurutia"]["QuestsEnd"]=="ON" then
		QuestsEnd_Open()
	end
end