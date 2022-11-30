local addonName, addonTable = ...;
local fuFrame=List_R_F_1_11.F
local ADD_Checkbutton=addonTable.ADD_Checkbutton
local PIGDownMenu=addonTable.PIGDownMenu
--任务完成
local AudioList = {
	{"音频1",567431},
	{"音频2",567478},
	{"音频3",539267},
	{"音频4",1575155},
	{"音频5","Interface/AddOns/"..addonName.."_Rurutia/media/ogg/1.ogg"},
	{"音频6","Interface/AddOns/"..addonName.."_Rurutia/media/ogg/2.ogg"},
}
local function QuestsEnd_Open()
	local QuestsEndFrameUI = CreateFrame("Frame");
	if PIG["Rurutia"]["QuestsEnd"]=="ON" then
		QuestsEndFrameUI:RegisterEvent("QUEST_WATCH_UPDATE")
		QuestsEndFrameUI:RegisterEvent("QUEST_WATCH_LIST_CHANGED")
		QuestsEndFrameUI:RegisterEvent("QUEST_LOG_UPDATE")
		QuestsEndFrameUI:RegisterEvent("UNIT_QUEST_LOG_CHANGED")
	else
		QuestsEndFrameUI:UnregisterAllEvents();
	end
	QuestsEndFrameUI:SetScript("OnEvent", function(self,event,arg1,arg2,arg3)
		print(event,arg1,arg2,arg3)
		if event=="QUEST_WATCH_UPDATE" then
			if arg1 then
				PlaySoundFile(AudioList[PIG["Rurutia"]["QuestsEndAudio"]][2], "Master")
			end
		end
	end)
end
fuFrame.QuestsEnd =ADD_Checkbutton(nil,fuFrame,-100,"TOPLEFT",fuFrame,"TOPLEFT",20,-80,"任务完成提示音","任务完成提示音")
fuFrame.QuestsEnd:Disable();
fuFrame.QuestsEnd.Text:SetTextColor(0.5, 0.5, 0.5, 1);
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
--打开选项页面时===============
fuFrame:HookScript("OnShow", function (self)
	fuFrame.QuestsEnd.xiala:PIGDownMenu_SetText(AudioList[PIG["Rurutia"]["QuestsEndAudio"]][1])
	if PIG["Rurutia"]["QuestsEnd"]=="ON" then
		fuFrame.ShiftFocus:SetChecked(true);
	end
end);
--进入游戏时加载
addonTable.Rurutia_QuestsEnd = function()
	--QuestsEnd_Open()
end