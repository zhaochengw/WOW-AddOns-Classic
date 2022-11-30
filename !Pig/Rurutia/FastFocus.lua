local _, addonTable = ...;
local fuFrame=List_R_F_1_11.F
local ADD_Checkbutton=addonTable.ADD_Checkbutton
local PIGDownMenu=addonTable.PIGDownMenu
---快速焦点
local UnitFrame = {
	PlayerFrame,
	PetFrame,
	PartyMemberFrame1,
	PartyMemberFrame2,
	PartyMemberFrame3,
	PartyMemberFrame4,
	PartyMemberFrame1PetFrame,
	PartyMemberFrame2PetFrame,
	PartyMemberFrame3PetFrame,
	PartyMemberFrame4PetFrame,
	TargetFrame,
	TargetofTargetFrame,
	CompactRaidGroup1Member1,
	CompactRaidGroup1Member2,
	CompactRaidGroup1Member3,
	CompactRaidGroup1Member4,
	CompactRaidGroup1Member5,
	CompactRaidGroup2Member1,
	CompactRaidGroup2Member2,
	CompactRaidGroup2Member3,
	CompactRaidGroup2Member4,
	CompactRaidGroup2Member5,
	CompactRaidGroup3Member1,
	CompactRaidGroup3Member2,
	CompactRaidGroup3Member3,
	CompactRaidGroup3Member4,
	CompactRaidGroup3Member5,
	CompactRaidGroup4Member1,
	CompactRaidGroup4Member2,
	CompactRaidGroup4Member3,
	CompactRaidGroup4Member4,
	CompactRaidGroup4Member5,
	CompactRaidGroup5Member1,
	CompactRaidGroup5Member2,
	CompactRaidGroup5Member3,
	CompactRaidGroup5Member4,
	CompactRaidGroup5Member5,
	CompactRaidGroup6Member1,
	CompactRaidGroup6Member2,
	CompactRaidGroup6Member3,
	CompactRaidGroup6Member4,
	CompactRaidGroup6Member5,
	CompactRaidGroup7Member1,
	CompactRaidGroup7Member2,
	CompactRaidGroup7Member3,
	CompactRaidGroup7Member4,
	CompactRaidGroup7Member5,
	CompactRaidGroup8Member1,
	CompactRaidGroup8Member2,
	CompactRaidGroup8Member3,
	CompactRaidGroup8Member4,
	CompactRaidGroup8Member5,
	--
	ElvUF_Player,
	ElvUF_Target,
	ElvUF_TargetTarget,
	ElvUF_PartyGroup1UnitButton1,
	ElvUF_PartyGroup1UnitButton2,
	ElvUF_PartyGroup1UnitButton3,
	ElvUF_PartyGroup1UnitButton4,
	ElvUF_PartyGroup1UnitButton5,
	ElvUF_Raid40Group1UnitButton1,
	ElvUF_Raid40Group1UnitButton2,
	ElvUF_Raid40Group1UnitButton3,
	ElvUF_Raid40Group1UnitButton4,
	ElvUF_Raid40Group1UnitButton5,
	ElvUF_Raid40Group2UnitButton1,
	ElvUF_Raid40Group2UnitButton2,
	ElvUF_Raid40Group2UnitButton3,
	ElvUF_Raid40Group2UnitButton4,
	ElvUF_Raid40Group2UnitButton5,
	ElvUF_Raid40Group3UnitButton1,
	ElvUF_Raid40Group3UnitButton2,
	ElvUF_Raid40Group3UnitButton3,
	ElvUF_Raid40Group3UnitButton4,
	ElvUF_Raid40Group3UnitButton5,
	ElvUF_Raid40Group4UnitButton1,
	ElvUF_Raid40Group4UnitButton2,
	ElvUF_Raid40Group4UnitButton3,
	ElvUF_Raid40Group4UnitButton4,
	ElvUF_Raid40Group4UnitButton5,
	ElvUF_Raid40Group5UnitButton1,
	ElvUF_Raid40Group5UnitButton2,
	ElvUF_Raid40Group5UnitButton3,
	ElvUF_Raid40Group5UnitButton4,
	ElvUF_Raid40Group5UnitButton5,
	ElvUF_Raid40Group6UnitButton1,
	ElvUF_Raid40Group6UnitButton2,
	ElvUF_Raid40Group6UnitButton3,
	ElvUF_Raid40Group6UnitButton4,
	ElvUF_Raid40Group6UnitButton5,
	ElvUF_Raid40Group7UnitButton1,
	ElvUF_Raid40Group7UnitButton2,
	ElvUF_Raid40Group7UnitButton3,
	ElvUF_Raid40Group7UnitButton4,
	ElvUF_Raid40Group7UnitButton5,
	ElvUF_Raid40Group8UnitButton1,
	ElvUF_Raid40Group8UnitButton2,
	ElvUF_Raid40Group8UnitButton3,
	ElvUF_Raid40Group8UnitButton4,
	ElvUF_Raid40Group8UnitButton5,
}
local function zhixingshezhiFocus(Frame)
	local gonegnengKEY = PIG["Rurutia"]["FastFocusKEY"].."-type1"
	Frame:SetAttribute(gonegnengKEY,"macro")
	Frame:SetAttribute("macrotext","/focus mouseover")
end
local function FastFocus_Open()
	for k,v in pairs(UnitFrame) do
		zhixingshezhiFocus(v)
	end
end
fuFrame.FastFocus =ADD_Checkbutton(nil,fuFrame,-80,"TOPLEFT",fuFrame,"TOPLEFT",20,-20,"快速设置焦点","勾选将开启快速设置焦点")
fuFrame.FastFocus:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG["Rurutia"]["FastFocus"]="ON";
		FastFocus_Open()
	else
		PIG["Rurutia"]["FastFocus"]="OFF";
		Pig_Options_RLtishi_UI:Show()
	end
end);
---
local shezhijiaodiananjian = {
	{"SHIFT+左键","shift"},
	{"CTRL+左键","ctrl"},
	{"ALT+左键","alt"},
}
local shezhijiaodiananjianName = {
	["shift"]="SHIFT+左键",
	["ctrl"]="CTRL+左键",
	["alt"]="ALT+左键",
}
fuFrame.FastFocus.xiala=PIGDownMenu(nil,{120,24},fuFrame.FastFocus,{"LEFT",fuFrame.FastFocus.Text, "RIGHT", 4,0})
function fuFrame.FastFocus.xiala:PIGDownMenu_Update_But(self)
	local info = {}
	info.func = self.PIGDownMenu_SetValue
	for i=1,#shezhijiaodiananjian,1 do
	    info.text, info.arg1, info.arg2 = shezhijiaodiananjian[i][1], shezhijiaodiananjian[i][2]
	    info.checked = shezhijiaodiananjian[i][2]==PIG["Rurutia"]["FastFocusKEY"]
		fuFrame.FastFocus.xiala:PIGDownMenu_AddButton(info)
	end 
end
function fuFrame.FastFocus.xiala:PIGDownMenu_SetValue(value,arg1)
	if InCombatLockdown() then PIG_print("战斗中无法更改按键") return end
	fuFrame.FastFocus.xiala:PIGDownMenu_SetText(value)
	PIG["Rurutia"]["FastFocusKEY"]=arg1
	FastFocus_Open()
	PIGCloseDropDownMenus()
end
--清除
local function FastClearFocus_Open()
	local gonegnengKEY = PIG["Rurutia"]["FastFocusKEY"].."-type1"
	FocusFrame:SetAttribute(gonegnengKEY,"macro")
	FocusFrame:SetAttribute("macrotext","/clearfocus")
end
fuFrame.FastFocus.FastClearFocus =ADD_Checkbutton(nil,fuFrame.FastFocus,-80,"LEFT",fuFrame.FastFocus.xiala,"RIGHT",50,0,"焦点头像点击快速清除","在焦点头像点击设置快捷键快速清除焦点目标")
fuFrame.FastFocus.FastClearFocus:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG["Rurutia"]["FastClearFocus"]="ON";
		FastClearFocus_Open()
	else
		PIG["Rurutia"]["FastClearFocus"]="OFF";
		Pig_Options_RLtishi_UI:Show()
	end
end);
--打开选项页面时===============
fuFrame:HookScript("OnShow", function (self)
	fuFrame.FastFocus.xiala:PIGDownMenu_SetText(shezhijiaodiananjianName[PIG["Rurutia"]["FastFocusKEY"]])
	if PIG["Rurutia"]["FastFocus"]=="ON" then
		fuFrame.FastFocus:SetChecked(true);
	end
	if PIG["Rurutia"]["FastClearFocus"]=="ON" then
		fuFrame.FastFocus.FastClearFocus:SetChecked(true);
	end
end);
--进入游戏时加载
addonTable.Rurutia_FastFocus = function()
	if PIG["Rurutia"]["FastFocus"]=="ON" then
		FastFocus_Open()
	end
	if PIG["Rurutia"]["FastClearFocus"]=="ON" then
		FastClearFocus_Open()
	end
end