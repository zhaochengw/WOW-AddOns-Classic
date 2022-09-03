
local AddonName, Addon = ...

local Config = Addon.Config
local TradeLog = Addon.TradeLog
local Panel = Addon.Panel
local ScrollFrame = Addon.ScrollFrame
local L = Addon.L
local MinimapIcon = Addon.MinimapIcon

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
	FeedbackLink:SetWidth(410)

	--交易相关
	--标题
	local TradeModeTitle = self:CreateHeading(L["Trade Function"])
	--交易记录开关
	local TradeLogSwitch = self:CreateCheckBox(L["Enable |cFF00CD00Whisper|r"],
		function(self) return Config.LogTrades end,
		function(self, v) Config.LogTrades = v end,
		true)
	-- 交易信息发送到团队开关
	local SendToGroupCheckBox = self:CreateCheckBox(L["Send to |cFFF0F000Group|r"],
		function(self) return Config.SendToGroup end,
		function(self, v) Config.SendToGroup = v end,
		false)
	-- 小地圖開關
	local ShowMinimapIconCheckBox = self:CreateCheckBox(L["Show |cFF4169E1Minimap Button|r"],
		function(self) return Config.ShowMinimapIcon end,
		function(self, v)
			Config.ShowMinimapIcon = v
			if Config.ShowMinimapIcon then
				MinimapIcon.Minimap:Show()
			elseif not Config.ShowMinimapIcon and MinimapIcon.Minimap:IsShown() then
				MinimapIcon.Minimap:Hide()
			end
		end,
		true)
	--交易日志保存时间
	local TradeLogDayHeading = self:CreateHeading(L["Trade Log Days"])
	local TradeLogDays = self:CreateSliderBar(nil,
		function(self) return Config.LogDays end,
		function(self, v) Config.LogDays = math.floor(v) end,
		90)
	TradeLogDays:SetOrientation("HORIZONTAL")
	TradeLogDays:SetHeight(14)
	TradeLogDays:SetWidth(160)
	TradeLogDays:SetMinMaxValues(0, 365)
	TradeLogDays:SetValueStep(1)
	TradeLogDays.Low:SetText(L["off"])
	TradeLogDays.High:SetText(L["365 Days"])
	-- 永久记录
	local ForeverLog = self:CreateCheckBox(L["Log |cFFFF7F50Every Day|r"],
		function(self) return Config.LogEverything end,
		function(self, v) Config.LogEverything = v end,
		false)
	-- 日历开关
	local EnableCalendarFrame = self:CreateCheckBox(L["Enable |cFF00FFFFCalendar|r"],
		function(self) return Config.EnableCalendar end,
		function(self, v) Config.EnableCalendar = v end,
		true)
	--打印交易信息的Button
	local PrintTradeLog = self:CreateButton(L["Print Logs"],
		function(self)
			if Addon.Output.background:IsShown() and Addon.Output.export:GetParent():IsShown() then
				Addon.Output.export:GetParent():Hide()
				Addon.Output.background:Hide()
				Addon.Calendar.background:Hide()
			else
				Addon.Output.dropdowntitle:Show()
				Addon.Output.dropdownlist:Show()
				Addon.Output.dropdownbutton:Show()
				Addon:PrintTradeLog("ALL", nil)
				if Addon.Config.EnableCalendar then
					Addon:GetAvailableDate()
					Addon.Calendar.background:Show()
					Addon:RefreshCalendar()
				end
			end
		end)
	PrintTradeLog:SetWidth(100)
	local DeleteAllLog = self:CreateButton(L["Delete All"],
		function(self)
			for i = #TradeLog, 1, -1 do
				table.remove(TradeLog, i)
			end
			print(L["<|cFFBA55D3MailLogger|r>All Logs was deleted!"])
		end)
	DeleteAllLog:SetWidth(100)
	--阻止小号交易
	local PreventRobotTradeTitle = self:CreateHeading(L["Prevent Robot Trades Me"])
	local PreventRobotTradeSwitch = self:CreateCheckBox(L["Enable |cFFFF0000Preventer|r"],
		function(self) return Config.PreventTrade end,
		function(self, v) Config.PreventTrade = v end,
		false)
	--清空筛选角色名
	local MaintanceHeading = self:CreateHeading(L["Delete All Alts"])
	local MaintnceButton = self:CreateButton(L["Maintance"],
		function(self)
			Config.AltList = {[(UnitName("player"))] = true,}
			Config.SelectName = (UnitName("player"))
			if Addon.Output.background:IsShown() then
				Addon.Output.background:Hide()
			end
			Addon.Output:Initialize()
			print(L["<|cFFBA55D3MailLogger|r>All other Alts was deleted!"])
		end)
	MaintnceButton:SetWidth(100)
	--显示列表按钮
	local DisplaySpellButton = self:CreateButton(L["Display"],
		function(self)
			Addon.Output.title:SetText(L["Ignore Items List"])
			Addon.Output.background:Show()
			Addon.Output.export:GetParent():Show()
			Addon.Output.dropdowntitle:Hide()
			Addon.Output.dropdownlist:Hide()
			Addon.Output.dropdownbutton:Hide()
			local msg = ""
			for k in pairs(Addon.IgnoreItems) do
				msg = msg .. k .. "\n"
			end
			if msg == "" then
				Addon.Output.export:SetText(L["No Ignore Item"])
			else
				Addon.Output.export:SetText(msg)
			end
		end)
	DisplaySpellButton:SetWidth(80)
	--技能列表还原
	local RestoreButton = self:CreateButton(L["Restore"],
		function(self)
			Addon.IgnoreItems = {}
			Addon:UpdateTable(Addon.IgnoreItems, Addon.DefaultIgnoreItems)
			Addon.Output.title:SetText(L["Ignore Items List"])
			Addon.Output.background:Show()
			Addon.Output.export:GetParent():Show()
			Addon.Output.dropdowntitle:Hide()
			Addon.Output.dropdownlist:Hide()
			Addon.Output.dropdownbutton:Hide()
			local msg = ""
			for k in pairs(Addon.IgnoreItems) do
				msg = msg .. k .. "\n"
			end
			if msg == "" then
				Addon.Output.export:SetText(L["No Ignore Item"])
			else
				Addon.Output.export:SetText(msg)
			end
		end)
	RestoreButton:SetWidth(80)
	--技能列表标题
	local IgnoreItemsTitle = self:CreateHeading(L["Ignore Items List Editor"])
	--编辑框
	local ItemEditBox = self:CreateEditBox(nil,
		function(self) return "" end,
		function(self, text) self.CurrentValue = text end,
		"")
	ItemEditBox:SetMultiLine(false)
	ItemEditBox:SetHeight(30)
	ItemEditBox:SetWidth(180)
	--添加按钮
	local AddItem = self:CreateButton(L["Add"],
		function(self)
			if ItemEditBox:GetText() ~= "" then
				Addon.IgnoreItems[ItemEditBox:GetText()] = true
			end
			Addon.Output.title:SetText(L["Ignore Items List"])
			Addon.Output.background:Show()
			Addon.Output.export:GetParent():Show()
			Addon.Output.dropdowntitle:Hide()
			Addon.Output.dropdownlist:Hide()
			Addon.Output.dropdownbutton:Hide()
			local msg = ""
			for k in pairs(Addon.IgnoreItems) do
				msg = msg .. k .. "\n"
			end
			if msg == "" then
				Addon.Output.export:SetText(L["No Ignore Item"])
			else
				Addon.Output.export:SetText(msg)
			end
		end)
	AddItem:SetWidth(80)
	--“移除”按钮
	local RemoveItem = self:CreateButton(L["Remove"],
		function(self)
			if Addon.IgnoreItems[ItemEditBox:GetText()] then
				Addon.IgnoreItems[ItemEditBox:GetText()] = nil
			end
			Addon.Output.title:SetText(L["Ignore Items List"])
			Addon.Output.background:Show()
			Addon.Output.export:GetParent():Show()
			Addon.Output.dropdowntitle:Hide()
			Addon.Output.dropdownlist:Hide()
			Addon.Output.dropdownbutton:Hide()
			local msg = ""
			for k in pairs(Addon.IgnoreItems) do
				msg = msg .. k .. "\n"
			end
			if msg == "" then
				Addon.Output.export:SetText(L["No Ignore Item"])
			else
				Addon.Output.export:SetText(msg)
			end
		end)
	RemoveItem:SetWidth(80)

	--控件位置设定
	--作者信息
	Author:SetPoint("LEFT", PanelTitle, "RIGHT", 220, 0)
	--反馈和更新链接
	FeedbackHeading:SetPoint("TOPLEFT", PanelTitle, "BOTTOMLEFT", 30, -30)
	FeedbackLink:SetPoint("LEFT", FeedbackHeading, "RIGHT", 15, 0)
	--交易管理
	TradeModeTitle:SetPoint("TOPLEFT", PanelTitle, "BOTTOMLEFT", 0, -60)
	TradeLogSwitch:SetPoint("TOPLEFT", TradeModeTitle, "BOTTOMLEFT", 30, -15)
	SendToGroupCheckBox:SetPoint("LEFT", TradeLogSwitch, "LEFT", 150, 0)
	ShowMinimapIconCheckBox:SetPoint("LEFT", SendToGroupCheckBox, "LEFT", 150, 0)
	ForeverLog:SetPoint("TOPLEFT", TradeModeTitle, "BOTTOMLEFT", 30, -75)
	EnableCalendarFrame:SetPoint("LEFT", ForeverLog, "LEFT", 150, 0)
	TradeLogDayHeading:SetPoint("TOPLEFT", TradeModeTitle, "BOTTOMLEFT", 30, -125)
	TradeLogDays:SetPoint("TOPLEFT", TradeModeTitle, "BOTTOMLEFT", TradeLogDayHeading:GetStringWidth() + 60, -125)
	PrintTradeLog:SetPoint("TOPLEFT", TradeModeTitle, "BOTTOMLEFT", 350, -75)
	DeleteAllLog:SetPoint("TOPLEFT", TradeModeTitle, "BOTTOMLEFT", 350, -125)
	PreventRobotTradeTitle:SetPoint("TOPLEFT", PanelTitle, "BOTTOMLEFT", 0, -260)
	PreventRobotTradeSwitch:SetPoint("TOPLEFT", PreventRobotTradeTitle, "BOTTOMLEFT", 30, -15)
	MaintanceHeading:SetPoint("LEFT", PreventRobotTradeTitle, "LEFT", 320, 0)
	MaintnceButton:SetPoint("LEFT", PreventRobotTradeSwitch, "LEFT", 320, 0)
	--忽略列表
	IgnoreItemsTitle:SetPoint("TOPLEFT", PanelTitle, "BOTTOMLEFT", 0, -360)
	DisplaySpellButton:SetPoint("LEFT", IgnoreItemsTitle, "LEFT", 290, 0)
	RestoreButton:SetPoint("LEFT", DisplaySpellButton, "LEFT", 80, 0)
	AddItem:SetPoint("TOPLEFT", DisplaySpellButton, "TOPLEFT", 0, -45)
	RemoveItem:SetPoint("LEFT", AddItem, "LEFT", 80, 0)
	ItemEditBox:SetPoint("LEFT", AddItem, "LEFT", -260, 0)
end

--面板初始化
Panel:Initialize()
Panel:Show()
ScrollFrame.okay = ScrollFrame.ConfigOkay
ScrollFrame.default = ScrollFrame.ConfigDefault
ScrollFrame.refresh = ScrollFrame.ConfigRefresh
ScrollFrame:ConfigRefresh()
ScrollFrame:Show()
