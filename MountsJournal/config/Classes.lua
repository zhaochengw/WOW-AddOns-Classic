local addon, L = ...
local util, mounts = MountsJournalUtil, MountsJournal
local classConfig = CreateFrame("Frame", "MountsJournalConfigClasses", InterfaceOptionsFramePanelContainer)
classConfig:Hide()
classConfig.name = L["Class settings"]
classConfig.parent = addon


classConfig:SetScript("OnShow", function(self)
	self:SetScript("OnShow", nil)
	self.macrosConfig = mounts.config.macrosConfig
	self.charMacrosConfig = mounts.charDB.macrosConfig

	-- VERSION
	local ver = self:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
	ver:SetPoint("TOPRIGHT", -16, 16)
	ver:SetTextColor(.5, .5, .5, 1)
	ver:SetJustifyH("RIGHT")
	ver:SetText(GetAddOnMetadata(addon, "Version"))

	-- TITLE
	local title = self:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
	title:SetPoint("TOPLEFT", 16, -16)
	title:SetText(L["Class settings"])

	-- SUBTITLE
	local subtitle = self:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
	self.subtitle = subtitle
	subtitle:SetHeight(30)
	subtitle:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 1, -8)
	subtitle:SetNonSpaceWrap(true)
	subtitle:SetJustifyH("LEFT")
	subtitle:SetJustifyV("TOP")

	-- LEFT PANEL
	self.leftPanel = CreateFrame("FRAME", nil, self, "MJOptionsPanel")
	self.leftPanel:SetPoint("TOPLEFT", 8, -67)
	self.leftPanel:SetPoint("BOTTOMRIGHT", self, "BOTTOMLEFT", 181, 8)

	-- CLASS BUTTONS
	local _, playerClassName = UnitClass("player")
	local firstClassFrame
	local lastClassFrame

	local function classClickFunc(btn)
		self.currentMacrosConfig = self.macrosConfig[btn.key]
		self:showClassSettings(btn)
	end

	for i = 1, GetNumClasses() do
		local localized, className = GetClassInfo(i)
		if className then
			local r, g, b = GetClassColor(className)
			local classFrame = CreateFrame("BUTTON", nil, self.leftPanel, "MJClassButtonTemplate")

			if lastClassFrame then
				classFrame:SetPoint("TOPLEFT", lastClassFrame, "BOTTOMLEFT", 0, 0)
			else
				classFrame:SetPoint("TOPLEFT", self.leftPanel, 3, -3)
			end
			lastClassFrame = classFrame
			classFrame.key = className
			classFrame.name:SetText(localized)
			classFrame.name:SetTextColor(r, g, b)
			classFrame.check:SetVertexColor(r, g, b)
			classFrame.highlight:SetVertexColor(r, g, b)
			classFrame.icon:SetTexCoord(unpack(CLASS_ICON_TCOORDS[className]))
			classFrame:SetScript("OnClick", classClickFunc)

			if playerClassName == className then
				firstClassFrame = classFrame
			end
		end
	end

	-- CURRENT CHARACTER
	local r, g, b = GetClassColor(playerClassName)
	local classFrame = CreateFrame("BUTTON", nil, self.leftPanel, "MJClassButtonTemplate")
	classFrame:SetPoint("TOPLEFT", lastClassFrame, "BOTTOMLEFT", 0, -20)
	classFrame.key = playerClassName
	classFrame.name:SetPoint("RIGHT", -30, 0)
	classFrame.name:SetText(UnitName("player"))
	classFrame.name:SetTextColor(r, g, b)
	classFrame.description = L["CHARACTER_CLASS_DESCRIPTION"]
	classFrame.check:SetVertexColor(r, g, b)
	classFrame.highlight:SetVertexColor(r, g, b)
	classFrame.icon:SetTexCoord(unpack(CLASS_ICON_TCOORDS[playerClassName]))
	classFrame:SetScript("OnClick", function(btn)
		self.currentMacrosConfig = self.charMacrosConfig
		self:showClassSettings(btn)
	end)
	if self.charMacrosConfig.enable then
		firstClassFrame = classFrame
	end

	-- CURRENT CHARACTER ENABLE
	self.charCheck = CreateFrame("CHECKBUTTON", nil, classFrame, "MJBaseCheckButtonTemplate")
	self.charCheck:SetPoint("RIGHT", -5, -1)
	self.charCheck:SetChecked(self.charMacrosConfig.enable)
	self.charCheck:HookScript("OnClick", function(btn)
		self.charMacrosConfig.enable = btn:GetChecked()
		util.refreshMacro()
	end)

	-- RIGHT PANEL
	local rightPanel = CreateFrame("FRAME", nil, self, "MJOptionsPanel")
	self.rightPanel = rightPanel
	rightPanel:SetPoint("TOPRIGHT", -8, -67)
	rightPanel:SetPoint("BOTTOMLEFT", self.leftPanel, "BOTTOMRIGHT", 0, 0)

	-- RIGHT PANEL SCROLL
	self.rightPanelScroll = CreateFrame("ScrollFrame", nil, rightPanel, "MJPanelScrollFrameTemplate")
	self.rightPanelScroll:SetPoint("TOPLEFT", rightPanel, 4, -6)
	self.rightPanelScroll:SetPoint("BOTTOMRIGHT", rightPanel, -26, 5)

	-- CLASS FEATURE
	self.checkPool = CreateFramePool("CHECKBUTTON", self.rightPanelScroll.child, "MJCheckButtonTemplate", function(_, frame)
		frame:Hide()
		frame:ClearAllPoints()
		frame:Enable()
		if frame.childs then
			wipe(frame.childs)
		end
	end)

	-- MOVE FALL MACRO
	local moveFallMF = CreateFrame("FRAME", nil, self.rightPanelScroll.child, "MJMacroFrame")
	self.moveFallMF = moveFallMF
	self.macroEditBox = moveFallMF.editFrame
	moveFallMF:SetPoint("LEFT", 9, 0)
	moveFallMF.label:SetText(L["HELP_MACRO_MOVE_FALL"])
	moveFallMF.enable:HookScript("OnClick", function(btn)
		self.currentMacrosConfig.macroEnable = btn:GetChecked()
		util.refreshMacro()
	end)
	moveFallMF.defaultBtn:HookScript("OnClick", function()
		self.macroEditBox:SetText(self.rightPanel.currentBtn.default)
		self.macroEditBox:ClearFocus()
		local enable = not not self.currentMacrosConfig.macro
		moveFallMF.saveBtn:SetEnabled(enable)
		moveFallMF.cancelBtn:SetEnabled(enable)
	end)
	moveFallMF.cancelBtn:HookScript("OnClick", function()
		self.macroEditBox:SetText(self.currentMacrosConfig.macro or self.rightPanel.currentBtn.default)
		self.macroEditBox:ClearFocus()
	end)
	moveFallMF.saveBtn:HookScript("OnClick", function()
		self:macroSave()
		util.refreshMacro()
	end)

	-- COMBAT MACRO
	local combatMF = CreateFrame("FRAME", nil, self.rightPanelScroll.child, "MJMacroFrame")
	self.combatMF = combatMF
	self.combatMacroEditBox = combatMF.editFrame
	combatMF:SetPoint("TOPLEFT", moveFallMF.background, "BOTTOMLEFT", 0, -50)
	combatMF.label:SetText(L["HELP_MACRO_COMBAT"])
	combatMF.enable:HookScript("OnClick", function(btn)
		self.currentMacrosConfig.combatMacroEnable = btn:GetChecked()
		util.refreshMacro()
	end)
	combatMF.defaultBtn:HookScript("OnClick", function()
		self.combatMacroEditBox:SetText(self.rightPanel.currentBtn.default)
		self.combatMacroEditBox:ClearFocus()
		local enable = not not self.currentMacrosConfig.combatMacro
		combatMF.saveBtn:SetEnabled(enable)
		combatMF.cancelBtn:SetEnabled(enable)
	end)
	combatMF.cancelBtn:HookScript("OnClick", function()
		self.combatMacroEditBox:SetText(self.currentMacrosConfig.combatMacro or self.rightPanel.currentBtn.default)
		self.combatMacroEditBox:ClearFocus()
	end)
	combatMF.saveBtn:HookScript("OnClick", function()
		self:combatMacroSave()
		util.refreshMacro()
	end)

	self:updateDefMacros()
	firstClassFrame:Click()
	self:RegisterEvent("LEARNED_SPELL_IN_TAB")
end)


function classConfig:updateDefMacros()
	for i, classFrame in ipairs({self.leftPanel:GetChildren()}) do
		classFrame.default = util.getClassMacro(classFrame.key, function()
			classFrame.default = util.getClassMacro(classFrame.key)
			if self.rightPanel and self.rightPanel.currentBtn == classFrame then
				classFrame:Click()
			end
		end)
	end
end
classConfig:SetScript("OnEvent", classConfig.updateDefMacros)


do
	local classOptions = {
		PALADIN = {
			{
				key = "useCrusaderAura",
				hlink = GetSpellLink(32223),
				childs = {
					{
						key = "returnLastAura",
					},
				},
			},
		},
		PRIEST = {
			{
				key = "useLevitation",
				text = L["CLASS_USEWHENCHARACTERFALLS"],
				hlink = GetSpellLink(1706),
			},
		},
		DEATHKNIGHT = {
			{
				key = "usePathOfFrost",
				text = L["CLASS_USEWATERWALKINGSPELL"],
				hlink = GetSpellLink(3714),
				childs = {
					{
						key = "useOnlyInWaterWalkLocation",
						text = L["CLASS_USEONLYWATERWALKLOCATION"],
					},
				},
			},
		},
		SHAMAN = {
			{
				key = "useWaterWalking",
				text = L["CLASS_USEWATERWALKINGSPELL"],
				hlink = GetSpellLink(546),
				childs = {
					{
						key = "useOnlyInWaterWalkLocation",
						text = L["CLASS_USEONLYWATERWALKLOCATION"],
					},
				},
			},
		},
		MAGE = {
			{
				key = "useSlowFall",
				text = L["CLASS_USEWHENCHARACTERFALLS"],
				hlink = GetSpellLink(130),
			},
		},
		DRUID = {
			{
				key = "useLastDruidForm",
			},
			{
				key = "useTravelIfCantFly",
				hlink = GetSpellLink(783),
			},
			{
				key = "useMacroAlways",
				childs = {
					{
						key = "useMacroOnlyCanFly",
					},
				}
			},
		},
	}


	local function optionClick(self, btn)
		local isEnabled = btn:GetChecked()
		self.currentMacrosConfig[btn.key] = isEnabled
		util.refreshMacro()

		if type(btn.childs) == "table" then
			for _, childOption in ipairs(btn.childs) do
				childOption:SetEnabled(isEnabled)
			end
		end
	end


	function classConfig:createOption(option, className)
		local optionFrame = self.checkPool:Acquire()
		optionFrame:SetChecked(self.currentMacrosConfig[option.key])
		optionFrame.Text:SetText((option.text or L[(className.."_"..option.key):upper()]):format(option.hlink))
		if not optionFrame.key then
			optionFrame.Text:SetSize(365, 30)
			optionFrame:HookScript("OnClick", function(btn) optionClick(self, btn) end)
		end
		optionFrame.key = option.key
		if option.hlink and not optionFrame:GetHyperlinksEnabled() then
			util.setHyperlinkTooltip(optionFrame)
		end
		optionFrame:Show()
		return optionFrame
	end


	function classConfig:showClassSettings(btn)
		if self.rightPanel.currentBtn then
			self.rightPanel.currentBtn.check:Hide()
		end
		self.subtitle:SetText(("%s: %s %s"):format(L["Settings"], btn.name:GetText(), btn.description or ""))
		self.rightPanel.currentBtn = btn
		btn.check:Show()

		self.moveFallMF.enable:SetChecked(self.currentMacrosConfig.macroEnable)
		self.macroEditBox:SetText(self.currentMacrosConfig.macro or btn.default)
		self.moveFallMF.saveBtn:Disable()
		self.moveFallMF.cancelBtn:Disable()
		self.combatMF.enable:SetChecked(self.currentMacrosConfig.combatMacroEnable)
		self.combatMacroEditBox:SetText(self.currentMacrosConfig.combatMacro or btn.default)
		self.combatMF.saveBtn:Disable()
		self.combatMF.cancelBtn:Disable()

		self.checkPool:ReleaseAll()
		if classOptions[btn.key] then
			local lastOptionFrame
			for _, option in ipairs(classOptions[btn.key]) do
				local optionFrame = self:createOption(option, btn.key)
				if lastOptionFrame then
					optionFrame:SetPoint("LEFT", 9, 0)
					optionFrame:SetPoint("TOP", lastOptionFrame, "BOTTOM", 0, 0)
				else
					optionFrame:SetPoint("TOPLEFT", 9, -9)
				end

				if option.childs then
					optionFrame.childs = optionFrame.childs or {}
					local isEnabled = optionFrame:GetChecked()
					local lastSubOptionFrame
					for _, subOption in ipairs(option.childs) do
						local subOptionFrame = self:createOption(subOption, btn.key)
						subOptionFrame:SetEnabled(isEnabled)
						if lastSubOptionFrame then
							subOptionFrame:SetPoint("TOPLEFT", lastOptionFrame, "BOTTOMLEFT", 0, 0)
						else
							subOptionFrame:SetPoint("TOPLEFT", optionFrame, "BOTTOMLEFT", 20, 0)
						end
						tinsert(optionFrame.childs, subOptionFrame)
						lastSubOptionFrame = subOptionFrame
					end
					lastOptionFrame = lastSubOptionFrame
				else
					lastOptionFrame = optionFrame
				end
			end
			self.moveFallMF:SetPoint("TOP", lastOptionFrame, "BOTTOM", 0, -24)
		else
			self.moveFallMF:SetPoint("TOP", 0, -14)
		end
		PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
	end
end


function classConfig:macroSave()
	local text = self.macroEditBox:GetEditBox():GetText()
	if text == self.rightPanel.currentBtn.default then
		self.currentMacrosConfig.macro = nil
	else
		self.currentMacrosConfig.macro = text
	end
	self.macroEditBox:ClearFocus()
end


function classConfig:combatMacroSave()
	local text = self.combatMacroEditBox:GetEditBox():GetText()
	if text == self.rightPanel.currentBtn.default then
		self.currentMacrosConfig.combatMacro = nil
	else
		self.currentMacrosConfig.combatMacro = text
	end
	self.combatMacroEditBox:ClearFocus()
end


classConfig.okay = function(self)
	self:macroSave()
	self:combatMacroSave()
	util.refreshMacro()
end


InterfaceOptions_AddCategory(classConfig)