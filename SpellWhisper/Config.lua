--版本控制：2.1.1 取消对TradeLog的支持

--[[
	致谢：Akinoso，参考了你的AkiTools很多
]]

local AddonName, Addon = ...

local Config = Addon.Config
local Panel = Addon.Panel
local ScrollFrame = Addon.ScrollFrame
local MinimapIcon = Addon.MinimapIcon
local L = Addon.L

--设置面板初始化
Panel:SetSize(500, 1000)
ScrollFrame.ScrollBar:ClearAllPoints()
ScrollFrame.ScrollBar:SetPoint("TOPLEFT", ScrollFrame, "TOPRIGHT", -20, -20)
ScrollFrame.ScrollBar:SetPoint("BOTTOMLEFT", ScrollFrame, "BOTTOMRIGHT", -20, 20)
ScrollFrame:SetScrollChild(Panel)
ScrollFrame.name = AddonName
InterfaceOptions_AddCategory(ScrollFrame)
--标题
local PanelTitle = Panel:CreateFontString(nil, "ARTWORK", "GameFontNormalLargeLeft")
PanelTitle:SetPoint("TOPLEFT", 16, -16)
PanelTitle:SetText("|cFFFF6633" .. AddonName .. "|r" .. " v" .. Addon.Version)
--所有组件表
Panel.Controls = {}
--创建唯一命名函数
local UniqueName
do
	local ControlID = 1

	function UniqueName(Name)
		ControlID = ControlID + 1
		return string.format("%s_%s_%02d", AddonName, Name, ControlID)
	end
end
--设置面板确定函数
function ScrollFrame:ConfigOkay()
	for _, Control in pairs(Panel.Controls) do
		Control:SaveValue(Control.CurrentValue)
	end
	local msg = ""
	for k in pairs(Addon.RunTime[Config.SelectedSpellType]) do
		if msg == "" then
			msg = k
		else
			msg = msg .. "\n" .. k
		end
	end
	Addon.CurrentSpellListText = msg
end
--设置面板回到默认设置函数
function ScrollFrame:ConfigDefault()
	for _, Control in pairs(Panel.Controls) do
		Control.CurrentValue = Control.DefaultValue
		Control:SaveValue(Control.CurrentValue)
	end
end
--设置面板刷新函数
function ScrollFrame:ConfigRefresh()
	for _, Control in pairs(Panel.Controls) do
		Control.CurrentValue = Control:LoadValue(Control)
		Control:UpdateValue(Control)
	end
end
--创建标题函数
function Panel:CreateHeading(text)
	local Title = self:CreateFontString(nil, "ARTWORK", "GameFontNormalLeft")
	Title:SetText(text)
	return Title
end
--创建文本函数
function Panel:CreateText(text)
	local TextBlob = self:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmallLeft")
	TextBlob:SetText(text)
	return TextBlob
end
--创建按钮函数
function Panel:CreateButton(text, RunFunction)
	local Button = CreateFrame("Button", nil, self, "UIPanelButtonTemplate")
	Button:Enable()
	Button:SetSize(50, 26)
	Button:SetText(text)
	Button:SetScript("OnClick", RunFunction)
	return Button
end
--创建选择框函数
function Panel:CreateCheckBox(text, LoadValue, SaveValue, DefaultValue)
	local CheckBox = CreateFrame("CheckButton", UniqueName("CheckButton"), self, "InterfaceOptionsCheckButtonTemplate")

	CheckBox.LoadValue = function(self)
		self.CurrentValue = LoadValue(self)
		return self.CurrentValue
	end
	CheckBox.SaveValue = function(self, v)
		self.CurrentValue = v
		SaveValue(self, v)
	end
	CheckBox.DefaultValue = DefaultValue
	CheckBox.UpdateValue = function(self)
		self:SetChecked(self.CurrentValue)
	end
	getglobal(CheckBox:GetName() .. "Text"):SetText(text)
	CheckBox:SetScript(
		"OnClick",
		function(self)
			self.CurrentValue = self:GetChecked()
		end
	)

	self.Controls[CheckBox:GetName()] = CheckBox
	return CheckBox
end
--下拉菜单点击函数
local function DropDownOnClick(_, DropDown, SelectedValue)
	DropDown.CurrentValue = SelectedValue
	UIDropDownMenu_SetText(DropDown, DropDown.ValueTexts[SelectedValue])
end
--下拉菜单初始化函数
local function DropDownInitialize(frame)
	local info = UIDropDownMenu_CreateInfo()

	for i = 1, #frame.ValueList, 2 do
		local k, v = frame.ValueList[i], frame.ValueList[i + 1]
		info.text = v
		info.value = k
		info.checked = frame.CurrentValue == k
		info.func = DropDownOnClick
		info.arg1, info.arg2 = frame, k
		UIDropDownMenu_AddButton(info)
	end
end
--创建下拉菜单函数
function Panel:CreateDropDown(text, ValueList, LoadValue, SaveValue, DefaultValue)
	local DropDown = CreateFrame("Frame", UniqueName("DropDown"), self, "UIDropDownMenuTemplate")

	local Title = self:CreateFontString(nil, "ARTWORK", "GameFontNormalSmallLeft")
	Title:SetText(text)
	Title:SetPoint("BOTTOMLEFT", DropDown, "left", -80, -6)

	DropDown.LoadValue = function(self)
		self.CurrentValue = LoadValue(self)
		return self.CurrentValue
	end
	DropDown.SaveValue = function(self, v)
		self.CurrentValue = v
		SaveValue(self, v)
	end
	DropDown.DefaultValue = DefaultValue
	DropDown.UpdateValue = function(self)
		UIDropDownMenu_SetText(self, self.ValueTexts[self.CurrentValue])
	end

	DropDown.ValueList = ValueList
	DropDown.ValueTexts = {}
	for i = 1, #ValueList, 2 do
		local k, v = ValueList[i], ValueList[i + 1]
		DropDown.ValueTexts[k] = v
	end

	DropDown:SetScript(
		"OnShow",
		function(self)
			UIDropDownMenu_Initialize(self, DropDownInitialize)
		end
	)

	UIDropDownMenu_JustifyText(DropDown, "LEFT")
	UIDropDownMenu_SetWidth(DropDown, 120)
	UIDropDownMenu_SetButtonWidth(DropDown, 144)

	self.Controls[DropDown:GetName()] = DropDown
	return DropDown
end
--创建滑块函数
function Panel:CreateSliderBar(_, LoadValue, SaveValue, DefaultValue)
	local SliderBar = CreateFrame("Slider", UniqueName("Slider"), self, "OptionsSliderTemplate")

	SliderBar.LoadValue = function(self)
		self.CurrentValue = LoadValue(self)
		return self.CurrentValue
	end
	SliderBar.SaveValue = function(self, v)
		self.CurrentValue = v
		SaveValue(self, v)
	end
	SliderBar.DefaultValue = DefaultValue
	SliderBar.UpdateValue = function(self)
		self:SetValue(self.CurrentValue)
	end
	SliderBar:SetScript(
		"OnValueChanged",
		function(self, v)
			self.CurrentValue = math.floor(self:GetValue())
			self.Text:SetText(math.floor(v))
		end
	)

	self.Controls[SliderBar:GetName()] = SliderBar
	return SliderBar
end
--创建输入框函数
function Panel:CreateEditBox(_, LoadValue, SaveValue, DefaultValue)
	local EditBox = CreateFrame("EditBox", UniqueName("EditBox"), self, "InputBoxTemplate")

	if EditBox:IsAutoFocus() then
		EditBox:SetAutoFocus(false)
	end

	EditBox.LoadValue = function(self)
		self.CurrentValue = LoadValue(self)
		return self.CurrentValue
	end
	EditBox.SaveValue = function(self, v)
		self.CurrentValue = v
		SaveValue(self, v)
	end
	EditBox.DefaultValue = DefaultValue
	EditBox.UpdateValue = function(self)
		self:SetText(self.CurrentValue)
	end

	EditBox:SetScript(
		"OnEditFocusGained",
		function(self)
			self:HighlightText()
		end
	)
	EditBox:SetScript(
		"OnEditFocusLost",
		function(self)
			self:SetText(self.CurrentValue)
		end
	)
	EditBox:SetScript(
		"OnEnterPressed",
		function(self)
			if self:HasFocus() then
				self.CurrentValue = self:GetText()
				self:ClearFocus()
			end
		end
	)
	EditBox:SetScript(
		"OnEscapePressed",
		function(self)
			if self:HasFocus() then
				self:SetText(self.CurrentValue)
				self.CurrentValue = self:GetText()
				self:ClearFocus()
			end
		end
	)

	self.Controls[EditBox:GetName()] = EditBox
	return EditBox
end


--设置面板初始化函数
function Panel:Initialize()

	--插件有关说明文本
	--作者信息
	local Author = self:CreateText(L["|cFFFFC040By:|r |cFF9382C9Aoikaze|r-|cFFFF66FFZeroZone|r-|cFFDE2910CN|r"])
	--反馈和更新链接
	local FeedbackHeading = self:CreateText(L["|cFFFF33CCFeedback & Update: |r"])
	local FeedbackLink = self:CreateEditBox(nil,
		function(self) return L["Feedback & Update Link"] end,
		function(self, text) self.CurrentValue = L["Feedback & Update Link"] end,
		L["Feedback & Update Link"])
	FeedbackLink:SetMultiLine(true)
	FeedbackLink:SetHeight(30)
	FeedbackLink:SetWidth(430)

	--启用插件选择框
	local AddonSwitch = self:CreateCheckBox(L["Enable |cFFBA55D3SpellWhisper|r"],
		function(self) return Config.IsEnable end,
		function(self, v) Config.IsEnable = v end,
		true)
	-- 小地圖開關
	local ShowMinimapIcon = self:CreateCheckBox(L["Show Minimap |cFF00F0F0Icon|r"],
		function(self) return Config.ShowMinimapIcon end,
		function(self, v)
			Config.ShowMinimapIcon = v
			if not (Addon.LDB and Addon.LDBIcon and ((IsAddOnLoaded("TitanClassic")) or (IsAddOnLoaded("Titan")))) then
				if Config.ShowMinimapIcon and not MinimapIcon.Minimap:IsShown() then
					MinimapIcon.Minimap:Show()
				elseif not Config.ShowMinimapIcon and MinimapIcon.Minimap:IsShown() then
					MinimapIcon.Minimap:Hide()
				end
			end
		end,
		false)

	--仅自身提示模式
	local SelfOnlySwitch = self:CreateCheckBox(L["|cFFCC9933Self|r Spell Only"],
		function(self) return Config.SelfOnly end,
		function(self, v) Config.SelfOnly = v end,
		false)

	--版本信息检查标题和按钮（检查，显示）
	local CheckVersionHeading = self:CreateHeading(L["Check & Display Version"])
	local CheckVerBtn = self:CreateButton(L["Check Version"],
		function(self)
			Addon:SendVerCheck()
			C_Timer.After(1, function() Addon:DisplayVersion() end)
		end)
	CheckVerBtn:SetWidth(160)

	--延时任务提示开关
	local DelayTaskTips = self:CreateCheckBox(L["|cFFA330C9Delay Task|r Tips"],
		function(self) return Config.DelayTips end,
		function(self, v) Config.DelayTips = v end,
		true)

	--通告输出模式
	local OutputChannelList = self:CreateDropDown(L["Channel: "],
		{"off", L["off"],--[[ "say", L["say"], "yell", L["yell"],]] "party", L["party"], "raid", L["raid"], "Raid_Warning", L["Raid_Warning"], "self", L["self"], "hud", L["hud"],},
		function(self) return Config.OutputChannel end,
		function(self, v) Config.OutputChannel = v end,
		"raid")

	--仇恨目标提示功能
	local ThreatTipSwitch = self:CreateDropDown(L["Threat: "],
		{"off", L["off"], "worldboss", L["worldboss"], "elite", L["elite"], "all", L["all"],},
		function(self) return Config.ThreatType end,
		function(self, v) Config.ThreatType = v end,
		"worldboss")

	--滑块 防破控重复刷屏
	local BreakWaitTimeHeading = self:CreateHeading(L["Anti Break Disturbance Time"])
	local BreakWaitTimeSlider =	self:CreateSliderBar(nil,
		function(self) return Config.BreakTime end,
		function(self, v)
			if Config.IsEnable and math.floor(v) ~= 0 and not Addon.Frame:IsShown() then
				Addon.Frame:Show()
			end
			Config.BreakTime = math.floor(v)
		end,
		8)
	BreakWaitTimeSlider:SetOrientation("HORIZONTAL")
	BreakWaitTimeSlider:SetHeight(14)
	BreakWaitTimeSlider:SetWidth(160)
	BreakWaitTimeSlider:SetMinMaxValues(0, 20)
	BreakWaitTimeSlider:SetValueStep(1)
	BreakWaitTimeSlider.Low:SetText(L["off"])
	BreakWaitTimeSlider.High:SetText(SecondsToTime(20))

	--滑块 防重复打扰延时
	local WaitTimeHeading = self:CreateHeading(L["Anti Disturbance Time"])
	local WaitTimeSlider = self:CreateSliderBar(nil,
		function(self) return Config.WaitTime end,
		function(self, v)
			if Config.IsEnable and math.floor(v) ~= 0 and not Addon.Frame:IsShown() then
				Addon.Frame:Show()
			end
			Config.WaitTime = math.floor(v)
		end,
		8)
	WaitTimeSlider:SetOrientation("HORIZONTAL")
	WaitTimeSlider:SetHeight(14)
	WaitTimeSlider:SetWidth(160)
	WaitTimeSlider:SetMinMaxValues(0, 20)
	WaitTimeSlider:SetValueStep(1)
	WaitTimeSlider.Low:SetText(L["off"])
	WaitTimeSlider.High:SetText(SecondsToTime(20))

	--密语
	local WhisperHeading = self:CreateHeading(L["Whisper Mode"])
	--启用密语选择框
	local WhisperSwitch = self:CreateCheckBox(L["Enable |cFFFFCC33Whisper|r"],
		function(self) return Config.IsWhisperEnable end,
		function(self, v) Config.IsWhisperEnable = v end,
		true)
	--控制技能TOT密语提示开关
	local ToTWhisperSwitch = self:CreateCheckBox(L["Enable |cFF44CEF6TOT Whisper|r Warning"],
		function(self) return Config.ToTWarningEnable end,
		function(self, v) Config.ToTWarningEnable = v end,
		false)

	--战场通告标题
	local BGWarningHeading = self:CreateHeading(L["BG Auto Report"])
	--战场通告选择框
	local BGWarningSwitch = self:CreateCheckBox(L["Enable |cFF0099FFBG Auto Report|r"],
		function(self) return Config.IsBGWarningEnable end,
		function(self, v) Config.IsBGWarningEnable = v end,
		true)

	--跟随密语设置(标题)
	local FollowHeading = self:CreateHeading(L["Auto Follow Setting"])
	local FollowWhenCombat = self:CreateCheckBox(L["Enable |cFFFF6600Combat Follow|r"],
		function(self) return Config.CombatFollow end,
		function(self, v) Config.CombatFollow = v end,
		false)
	local StartFollowText = self:CreateText(L["|cFFFF99CCStart Follow|r KeyWords:"])
	local StopFollowText = self:CreateText(L["|cFF999966Stop Follow|r KeyWords:"])
	local CombatFollowSwitchText = self:CreateText(L["|cFFD9B611Combat Follow Mode|r KeyWords:"])
	--跟随密语关键词设置输入框
	local StartFollowKey = self:CreateEditBox(nil,
		function(self) return Config.StartFollow end,
		function(self, text) Config.StartFollow = text end,
		"")
	StartFollowKey:SetMultiLine(false)
	StartFollowKey:SetHeight(30)
	StartFollowKey:SetWidth(240)
	--停止跟随密语关键词设置输入框
	local StopFollowKey = self:CreateEditBox(nil,
		function(self) return Config.StopFollow end,
		function(self, text) Config.StopFollow = text end,
		"")
	StopFollowKey:SetMultiLine(false)
	StopFollowKey:SetHeight(30)
	StopFollowKey:SetWidth(240)
	--战斗跟随开关关键词设置输入框
	local ChangeCombatFollowModeKey = self:CreateEditBox(nil,
		function(self) return Config.CombatFollowSwitchKey end,
		function(self, text) Config.CombatFollowSwitchKey = text end,
		"")
	ChangeCombatFollowModeKey:SetMultiLine(true)
	ChangeCombatFollowModeKey:SetHeight(30)
	ChangeCombatFollowModeKey:SetWidth(240)

	--添加/删除监控列表类型下拉菜单框
	local DisplaySpellType = self:CreateDropDown(L["Spell Monitor: "],
		{"InstantHarm", L["Instant Harm"], "InstantHelp", L["Instant Help"], "CastHarm", L["Cast Harm"], "CastHelp", L["Cast Help"], "SelfBuff", L["Self Buff"], "Healing", L["Healing"], "Other", L["Other"], "Notips", L["Ignore"],},
		function(self) return Config.SelectedSpellType end,
		function(self, v) Config.SelectedSpellType = v end,
		"Other")
	--列表框
	local SpellListBox = self:CreateText(Addon.CurrentSpellListText)
	--显示列表按钮
	local DisplaySpellButton = self:CreateButton(L["Display"],
		function(self)
			ScrollFrame:ConfigOkay()
			SpellListBox:SetText(Addon.CurrentSpellListText)
			ScrollFrame:ConfigRefresh()
		end)
	--技能列表还原
	local RestoreButton = self:CreateButton(L["Restore"],
		function(self)
			Addon.RunTime = {}
			Addon:UpdateTable(Addon.RunTime, Addon.Default)
			ScrollFrame:ConfigOkay()
			SpellListBox:SetText(Addon.CurrentSpellListText)
			ScrollFrame:ConfigRefresh()
		end)
	--技能列表标题
	local SpellListHeading = self:CreateHeading(L["Spell List"])
	--编辑框
	local SpellEditBox = self:CreateEditBox(nil,
		function(self) return "" end,
		function(self, text) self.CurrentValue = text end,
		"")
	SpellEditBox:SetMultiLine(false)
	SpellEditBox:SetHeight(30)
	SpellEditBox:SetWidth(160)
	--添加按钮
	local AddSpellButton = self:CreateButton(L["Add"],
		function(self)
			if SpellEditBox:GetText() ~= "" then
				Addon.RunTime[Config.SelectedSpellType][SpellEditBox:GetText()] = true
			end
			ScrollFrame:ConfigOkay()
			SpellListBox:SetText(Addon.CurrentSpellListText)
			ScrollFrame:ConfigRefresh()
		end)
	--“移除”按钮
	local RemoveSpellButton = self:CreateButton(L["Remove"],
		function(self)
			if Addon.RunTime[Config.SelectedSpellType][SpellEditBox:GetText()] then
				Addon.RunTime[Config.SelectedSpellType][SpellEditBox:GetText()] = nil
			end
			ScrollFrame:ConfigOkay()
			SpellListBox:SetText(Addon.CurrentSpellListText)
			ScrollFrame:ConfigRefresh()
		end)
	--通告模板
	local SpellOutputSelect = self:CreateDropDown(L["Announce Template: "],
		{
			"SPELLWHISPER_TEXT_SENTTOGROUPSTART",
			L["Tell Group Spell Start Casting"],
			"SPELLWHISPER_TEXT_SENTTOGROUPDONE",
			L["Tell Group Spell Have Done"],
			"SPELLWHISPER_TEXT_SENTTOPLAYERSTART",
			L["Whisper Someone Spell Start Casting"],
			"SPELLWHISPER_TEXT_SENTTOPLAYERDONE",
			L["Whisper Someone Spell Have Done"],
			"SPELLWHISPER_TEXT_SENTTOPLAYERTARGETTHETARGET",
			L["Tell Someone To Change His/Her Target"],
			"SPELLWHISPER_TEXT_BROKEN",
			L["Announce CC Spell Broken"],
			"SPELLWHISPER_TEXT_INTERRUPT",
			L["Announce Enemy's Spell Interrupted"],
			"SPELLWHISPER_TEXT_STOLEN",
			L["Announce Spell Stolen"],
			"SPELLWHISPER_TEXT_REFLECT",
			L["Announce Spell Reflect"],
			"SPELLWHISPER_TEXT_MISSED",
			L["Announce Spell/Skill Missed"],
			"SPELLWHISPER_TEXT_DISPEL",
			L["Announce Enemy's Buff Dispelled"],
			"SPELLWHISPER_TEXT_HEALINGFAILED",
			L["Tell Target Heal Spell Failed"],
			"SPELLWHISPER_TEXT_BGWARNING",
			L["Warning Group You Have Be Controlled In BG"],
            "SPELLWHISPER_TEXT_THREAT",
            L["Announce Mob's First Target Have Changed"],
		},
		function(self) return Config.SelectedSpellOutputType end,
		function(self, v) Config.SelectedSpellOutputType = v end,
		"SPELLWHISPER_TEXT_SENTTOGROUPDONE")
	local DisplaySpellOutputButton = self:CreateButton(L["Display"],
		function(self)
			ScrollFrame:ConfigOkay()
			ScrollFrame:ConfigRefresh()
		end)
	local SpellOutputEditBox = self:CreateEditBox(nil,
		function(self)
			self:SetText("") --刷新
			if Config.SelectedSpellOutputType and Config["SpellOutput"] and Config["SpellOutput"][Config.SelectedSpellOutputType] then
				return Config["SpellOutput"][Config.SelectedSpellOutputType]
			end
			return L[Config.SelectedSpellOutputType]
		end,
		function(self, text) self.CurrentValue = text end,
		"")
		SpellOutputEditBox:SetMultiLine(false)
		SpellOutputEditBox:SetHeight(30)
		SpellOutputEditBox:SetWidth(410)
	local SetSpellOutputButton = self:CreateButton(L["Set"],
		function(self)
			if SpellOutputEditBox:GetText() ~= "" then
				Config["SpellOutput"][Config.SelectedSpellOutputType] = SpellOutputEditBox:GetText()
			end
			ScrollFrame:ConfigOkay()
			ScrollFrame:ConfigRefresh()
		end)
	local SetDefaultSpellOutputButton = self:CreateButton(L["Default"],
		function(self)
			if Config["SpellOutput"][Config.SelectedSpellOutputType] then
				Config["SpellOutput"][Config.SelectedSpellOutputType] = nil
			end
			ScrollFrame:ConfigOkay()
			ScrollFrame:ConfigRefresh()
		end)

	--控件位置设定
	--作者信息
	Author:SetPoint("LEFT", PanelTitle, "RIGHT", 220, 0)
	--反馈和更新链接
	FeedbackHeading:SetPoint("TOPLEFT", PanelTitle, "BOTTOMLEFT", 30, -30)
	FeedbackLink:SetPoint("LEFT", FeedbackHeading, "RIGHT", 15, 0)
	--检查和显示版本号
	CheckVersionHeading:SetPoint("TOPLEFT", PanelTitle, "BOTTOMLEFT", 30, -70)
	CheckVerBtn:SetPoint("LEFT", CheckVersionHeading, "LEFT", 350, 0)
	--插件开关
	AddonSwitch:SetPoint("TOPLEFT", PanelTitle, "BOTTOMLEFT", 0, -120)
	--小地图按钮
	ShowMinimapIcon:SetPoint("LEFT", AddonSwitch, "LEFT", 240, 0)
	--仅自身提示模式
	SelfOnlySwitch:SetPoint("TOPLEFT", AddonSwitch, "BOTTOMLEFT", 30, -10)
	--延时命令提示
	DelayTaskTips:SetPoint("TOPLEFT", AddonSwitch, "BOTTOMLEFT", 240, -10)
	--密语通知
	WhisperHeading:SetPoint("TOPLEFT", AddonSwitch, "BOTTOMLEFT", 0, -50)
	WhisperSwitch:SetPoint("TOPLEFT", WhisperHeading, "BOTTOMLEFT", 30, -10)
	ToTWhisperSwitch:SetPoint("TOPLEFT", WhisperHeading, "BOTTOMLEFT", 240, -10)
	--输出频道
	OutputChannelList:SetPoint("TOPLEFT", AddonSwitch, "BOTTOMLEFT", 110, -120)
	--仇恨目标提示
	ThreatTipSwitch:SetPoint("TOPLEFT", AddonSwitch, "BOTTOMLEFT", 110, -160)
	--自定义输出字串
	SpellOutputSelect:SetPoint("TOPLEFT", AddonSwitch, "BOTTOMLEFT", 110, -200)
	SpellOutputEditBox:SetPoint("TOPLEFT", AddonSwitch, "BOTTOMLEFT", 40, -235)
	DisplaySpellOutputButton:SetPoint("TOPLEFT", AddonSwitch, "BOTTOMLEFT", 280, -200)
	SetSpellOutputButton:SetPoint("LEFT", DisplaySpellOutputButton, "RIGHT", 10, 0)
	SetDefaultSpellOutputButton:SetPoint("LEFT", SetSpellOutputButton, "RIGHT", 10, 0)
	--防打扰破控延时
	BreakWaitTimeHeading:SetPoint("TOPLEFT", AddonSwitch, "BOTTOMLEFT", 30, -295)
	BreakWaitTimeSlider:SetPoint("TOPLEFT", AddonSwitch, "BOTTOMLEFT", BreakWaitTimeHeading:GetStringWidth() + 60, -295)
	--防打扰延时
	WaitTimeHeading:SetPoint("TOPLEFT", AddonSwitch, "BOTTOMLEFT", 30, -350)
	WaitTimeSlider:SetPoint("TOPLEFT", AddonSwitch, "BOTTOMLEFT", WaitTimeHeading:GetStringWidth() + 60, -350)
	--战场自动报告
	BGWarningHeading:SetPoint("TOPLEFT", AddonSwitch, "BOTTOMLEFT", 0, -400)
	BGWarningSwitch:SetPoint("TOPLEFT", BGWarningHeading, "BOTTOMLEFT", 30, -12)
	--密语跟随
	FollowHeading:SetPoint("TOPLEFT", AddonSwitch, "BOTTOMLEFT", 0, -475)
	FollowWhenCombat:SetPoint("LEFT", FollowHeading, "LEFT", 240, 0)
	StartFollowText:SetPoint("TOPLEFT", FollowHeading, "BOTTOMLEFT", 30, -20)
	StopFollowText:SetPoint("TOPLEFT", StartFollowText, "BOTTOMLEFT", 0, -20)
	CombatFollowSwitchText:SetPoint("TOPLEFT", StopFollowText, "BOTTOMLEFT", 0, -20)
	StartFollowKey:SetPoint("LEFT", StartFollowText, "RIGHT", 35, 0)
	StopFollowKey:SetPoint("LEFT", StopFollowText, "RIGHT", 35, 0)
	ChangeCombatFollowModeKey:SetPoint("LEFT", CombatFollowSwitchText, "RIGHT", 35, 0)
	--监控法术类型菜单
	SpellListHeading:SetPoint("TOPLEFT", AddonSwitch, "BOTTOMLEFT", 0, -625)
	DisplaySpellType:SetPoint("TOPLEFT", AddonSwitch, "BOTTOMLEFT", 110, -655)
	DisplaySpellButton:SetPoint("TOPLEFT", AddonSwitch, "BOTTOMLEFT", 280, -655)
	RestoreButton:SetPoint("TOPLEFT", AddonSwitch, "BOTTOMLEFT", 340, -655)
	SpellListBox:SetPoint("TOPLEFT", SpellListHeading, "BOTTOMLEFT", 60, -70)
	SpellEditBox:SetPoint("TOPLEFT", SpellListHeading, "BOTTOMLEFT", 220, -60)
	AddSpellButton:SetPoint("TOPLEFT", SpellEditBox, "BOTTOMLEFT", 10, -15)
	RemoveSpellButton:SetPoint("LEFT", AddSpellButton, "RIGHT", 40, 0)
end

--面板初始化
Panel:Initialize()
Panel:Show()
ScrollFrame.okay = ScrollFrame.ConfigOkay
ScrollFrame.default = ScrollFrame.ConfigDefault
ScrollFrame.refresh = ScrollFrame.ConfigRefresh
ScrollFrame:ConfigRefresh()
ScrollFrame:Show()
