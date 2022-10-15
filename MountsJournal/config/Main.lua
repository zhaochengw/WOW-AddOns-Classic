local addon, L = ...
local util, mounts, binding = MountsJournalUtil, MountsJournal, _G[addon.."Binding"]
local config = CreateFrame("FRAME", "MountsJournalConfig", InterfaceOptionsFramePanelContainer)
config:Hide()
config.name = addon
config.macroName = "MJMacro"
config.secondMacroName = "MJSecondMacro"
config.secureButtonNameMount = addon.."_Mount"
config.secureButtonNameSecondMount = addon.."_SecondMount"


config:SetScript("OnEvent", function(self, event, ...) self[event](self, ...) end)
config:RegisterEvent("PLAYER_LOGIN")


-- BIND MOUNT
function config:PLAYER_LOGIN()
	self.bindMount = binding:createButtonBinding(nil, self.secureButtonNameMount, ("%s %s %d"):format(addon, SUMMONS, 1), "MJSecureActionButtonTemplate")
	self.bindSecondMount = binding:createButtonBinding(nil, self.secureButtonNameSecondMount, ("%s %s %d"):format(addon, SUMMONS, 2), "MJSecureActionButtonTemplate")
	self.bindSecondMount.secure.forceModifier = true
end


-- SHOW CONFIG
config:SetScript("OnShow", function(self)
	StaticPopupDialogs[util.addonName.."MACRO_EXISTS"] = {
		text = addon..": "..L["A macro named \"%s\" already exists, overwrite it?"],
		button1 = ACCEPT,
		button2 = CANCEL,
		hideOnEscape = 1,
		whileDead = 1,
		OnAccept = function(popup, cb) popup:Hide() cb() end,
	}

	-- ENABLE APPLY
	local function applyEnable() self.applyBtn:Enable() end

	-- TOOLTIP
	local function setTooltip(frame, anchor, title, text)
		frame:SetScript("OnEnter", function()
			GameTooltip:SetOwner(frame, anchor)
			GameTooltip:SetText(title)
			GameTooltip:AddLine(text, 1, 1, 1, 1, true)
			GameTooltip:Show()
		end)

		frame:SetScript("OnLeave", function()
			GameTooltip_Hide()
		end)
	end

	-- VERSION
	local ver = self:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
	ver:SetPoint("TOPRIGHT", -16, 16)
	ver:SetTextColor(.5, .5, .5, 1)
	ver:SetJustifyH("RIGHT")
	ver:SetText(GetAddOnMetadata(addon, "Version"))

	-- TITLE
	local title = self:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
	title:SetPoint("TOPLEFT", 16, -16)
	title:SetJustifyH("LEFT")
	title:SetText(L["%s Configuration"]:format(addon))

	-- SUBTITLE
	local subtitle = self:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
	subtitle:SetHeight(30)
	subtitle:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 1, -8)
	subtitle:SetNonSpaceWrap(true)
	subtitle:SetJustifyH("LEFT")
	subtitle:SetJustifyV("TOP")
	subtitle:SetText(L["ConfigPanelTitle"])

	-- LEFT PANEL
	self.leftPanel = CreateFrame("FRAME", nil, self, "MJOptionsPanel")
	self.leftPanel:SetPoint("TOPLEFT", self, 8, -67)
	self.leftPanel:SetPoint("BOTTOMRIGHT", self, "BOTTOMLEFT", 300, 32)

	-- SUMMON 1
	local summon1 = self.leftPanel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	summon1:SetPoint("TOPLEFT", subtitle, "BOTTOMLEFT", 8, -20)
	summon1:SetText(SUMMON.." 1")

	-- CREATE MACRO
	self.createMacroBtn = CreateFrame("BUTTON", nil, self.leftPanel, "UIPanelButtonTemplate")
	self.createMacroBtn:SetSize(258, 30)
	self.createMacroBtn:SetPoint("TOPLEFT", summon1, "BOTTOMLEFT", 0, -5)
	self.createMacroBtn:SetText(L["CreateMacro"])
	self.createMacroBtn:SetScript("OnClick", function() self:createMacro(self.macroName, self.secureButtonNameMount, 303868, true) end)

	setTooltip(self.createMacroBtn, "ANCHOR_TOP", L["CreateMacro"], L["CreateMacroTooltip"])

	-- OR TEXT
	local macroOrBind = self.leftPanel:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
	macroOrBind:SetPoint("TOP", self.createMacroBtn, "BOTTOM", 0, -3)
	macroOrBind:SetText(L["or key bind"])

	-- BIND MOUNT
	self.bindMount:SetParent(self.leftPanel)
	self.bindMount:SetSize(258, 22)
	self.bindMount:SetPoint("TOPLEFT", self.createMacroBtn, "BOTTOMLEFT", 0, -20)

	-- HELP PLATE
	local helpPlate = CreateFrame("FRAME", nil, self.leftPanel, "MJHelpPlate")
	helpPlate:SetPoint("TOP", self.bindMount, "BOTTOM", 0, -20)
	helpPlate.tooltip = L["SecondMountTooltipTitle"]:format(SUMMON)
	helpPlate.tooltipDescription = "\n"..L["SecondMountTooltipDescription"]

	-- MODIFIER TEXT
	local modifierText = self.leftPanel:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
	modifierText:SetPoint("TOPLEFT", self.bindMount, "BOTTOMLEFT", 0, -80)
	modifierText:SetText(L["Modifier"]..":")

	-- MODIFIER COMBOBOX
	local modifierCombobox = LibStub("LibSFDropDown-1.4"):CreateButton(self.leftPanel)
	self.modifierCombobox = modifierCombobox
	modifierCombobox:SetPoint("LEFT", modifierText, "RIGHT", 7, 0)
	modifierCombobox:ddSetInitFunc(function(self, level)
		local info = {}
		for i, modifier in ipairs({"ALT", "CTRL", "SHIFT", "NONE"}) do
			info.text = _G[modifier.."_KEY"]
			info.value = modifier
			info.checked = function(btn) return modifierCombobox.selectedValue == btn.value end
			info.func = function(btn)
				self:ddSetSelectedValue(btn.value)
				config.applyBtn:Enable()
			end
			self:ddAddButton(info, level)
		end
	end)

	-- SUMMON 2
	local summon2 = self.leftPanel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	summon2:SetPoint("TOPLEFT", modifierText, "BOTTOMLEFT", 0, -20)
	summon2:SetText(SUMMON.." 2")

	-- CREATE SECOND MACRO
	self.createSecondMacroBtn = CreateFrame("BUTTON", nil, self.leftPanel, "UIPanelButtonTemplate")
	self.createSecondMacroBtn:SetSize(258, 30)
	self.createSecondMacroBtn:SetPoint("TOPLEFT", summon2, "BOTTOMLEFT", 0, -5)
	self.createSecondMacroBtn:SetText(L["CreateMacro"])
	self.createSecondMacroBtn:SetScript("OnClick", function() self:createMacro(self.secondMacroName, self.secureButtonNameSecondMount, 237534, true) end)

	setTooltip(self.createSecondMacroBtn, "ANCHOR_TOP", L["CreateMacro"], L["CreateMacroTooltip"])

	-- OR TEXT SECOND
	local macroOrBindSecond = self.leftPanel:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
	macroOrBindSecond:SetPoint("TOP", self.createSecondMacroBtn, "BOTTOM", 0, -3)
	macroOrBindSecond:SetText(L["or key bind"])

	-- BIND SECOND MOUNT
	self.bindSecondMount:SetParent(self.leftPanel)
	self.bindSecondMount:SetSize(258, 22)
	self.bindSecondMount:SetPoint("TOP", self.createSecondMacroBtn, "BOTTOM", 0, -20)

	-- UNBOUND MESSAGE
	binding.unboundMessage:SetParent(self)
	binding.unboundMessage:SetSize(500, 10)
	binding.unboundMessage:SetPoint("BOTTOMLEFT", self, "BOTTOMLEFT", 14, 14)

	-- RIGHT PANEL
	self.rightPanel = CreateFrame("FRAME", nil, self, "MJOptionsPanel")
	self.rightPanel:SetPoint("TOPLEFT", self.leftPanel, "TOPRIGHT", 4, 0)
	self.rightPanel:SetPoint("BOTTOMRIGHT", self, -8, 32)

	self.rightPanelScroll = CreateFrame("ScrollFrame", nil, self.rightPanel, "MJPanelScrollFrameTemplate")
	self.rightPanelScroll:SetPoint("TOPLEFT", self.rightPanel, 4, -6)
	self.rightPanelScroll:SetPoint("BOTTOMRIGHT", self.rightPanel, -26, 5)

	-- SHOW MINIMAP BUTTON
	self.showMinimapButton = CreateFrame("CheckButton", nil, self.rightPanelScroll.child, "MJCheckButtonTemplate")
	self.showMinimapButton:SetPoint("TOPLEFT", self.rightPanelScroll.child, "BOTTOMLEFT", 9, -9)
	self.showMinimapButton.Text:SetText(L["Show Minimap Button"])
	self.showMinimapButton:HookScript("OnClick", applyEnable)

	-- LOCK MINIMAP BUTTON
	self.lockMinimapButton = util.createCheckboxChild(L["Lock Minimap Button"], self.showMinimapButton)
	self.lockMinimapButton:HookScript("OnClick", applyEnable)

	-- USE REPAIR MOUNTS
	self.useRepairMounts = CreateFrame("CheckButton", nil, self.rightPanelScroll.child, "MJCheckButtonTemplate")
	self.useRepairMounts:SetPoint("TOPLEFT", self.lockMinimapButton, "BOTTOMLEFT", -20, -15)
	self.useRepairMounts.Text:SetText(L["If item durability is less than"])
	self.useRepairMounts.tooltipText = L["If item durability is less than"]
	self.useRepairMounts.tooltipRequirement = L["UseRepairMountsDescription"]
	self.useRepairMounts:HookScript("OnClick", applyEnable)

	-- editbox
	self.repairPercent = CreateFrame("Editbox", nil, self.rightPanelScroll.child, "MJNumberTextBox")
	self.repairPercent:SetPoint("LEFT", self.useRepairMounts.Text, "RIGHT", 3, 0)
	self.repairPercent:SetScript("OnTextChanged", function(editBox, userInput)
		if userInput then
			local value = tonumber(editBox:GetText()) or 0
			if value < 0 then
				editBox:SetNumber(0)
			elseif value > 100 then
				editBox:SetNumber(100)
			end
			applyEnable()
		end
	end)
	self.repairPercent:SetScript("OnMouseWheel", function(editBox, delta)
		if editBox:IsEnabled() then
			local value = (tonumber(editBox:GetText()) or 0) + (delta > 0 and 1 or -1)
			if value >= 0 and value <= 100 then
				editBox:SetNumber(value)
			end
			applyEnable()
		end
	end)
	util.setCheckboxChild(self.useRepairMounts, self.repairPercent)

	-- text
	self.repairPercentText = self.repairPercent:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
	self.repairPercentText:SetPoint("LEFT", self.repairPercent, "RIGHT", 3, 0)
	self.repairPercentText:SetText("%")

	-- USE REPAIR MOUNTS IN FLYABLE ZONES
	self.repairFlyable = util.createCheckboxChild(L["In flyable zones"], self.useRepairMounts)
	self.repairFlyable.tooltipText = L["In flyable zones"]
	self.repairFlyable.tooltipRequirement = L["UseRepairMountsDescription"]
	self.repairFlyable.setEnabledFunc = function(btn)
		self.repairFlyablePercentText:SetTextColor(btn.Text:GetTextColor())
	end
	self.repairFlyable:HookScript("OnEnable", self.repairFlyable.setEnabledFunc)
	self.repairFlyable:HookScript("OnDisable", self.repairFlyable.setEnabledFunc)
	self.repairFlyable:HookScript("OnClick", applyEnable)

	-- editbox
	self.repairFlyablePercent = CreateFrame("Editbox", nil, self.rightPanelScroll.child, "MJNumberTextBox")
	self.repairFlyablePercent:SetPoint("LEFT", self.repairFlyable.Text, "RIGHT", 3, 0)
	self.repairFlyablePercent:SetScript("OnTextChanged", function(editBox, userInput)
		if userInput then
			local value = tonumber(editBox:GetText()) or 0
			if value < 0 then
				editBox:SetNumber(0)
			elseif value > 100 then
				editBox:SetNumber(100)
			end
			applyEnable()
		end
	end)
	self.repairFlyablePercent:SetScript("OnMouseWheel", function(editBox, delta)
		if editBox:IsEnabled() then
			local value = (tonumber(editBox:GetText()) or 0) + (delta > 0 and 1 or -1)
			if value >= 0 and value <= 100 then
				editBox:SetNumber(value)
			end
			applyEnable()
		end
	end)
	util.setCheckboxChild(self.repairFlyable, self.repairFlyablePercent)

	-- text
	self.repairFlyablePercentText = self.repairPercent:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
	self.repairFlyablePercentText:SetPoint("LEFT", self.repairFlyablePercent, "RIGHT", 3, 0)
	self.repairFlyablePercentText:SetText("%")

	-- REPAIR MOUNTS COMBOBOX
	self.repairMountsCombobox = LibStub("LibSFDropDown-1.4"):CreateButton(self.rightPanelScroll.child, 230)
	self.repairMountsCombobox:SetPoint("TOPLEFT", self.repairFlyable, "BOTTOMLEFT", 0, -8)
	self.repairMountsCombobox:ddSetInitFunc(function(self, level)
		local info = {}

		info.tooltipWhileDisabled = true
		for i, spellID in ipairs(mounts.repairMounts) do
			local faction = util.getMountInfoBySpellID(spellID)
			local playerFaction = UnitFactionGroup("Player")

			if faction == 1 and playerFaction == "Horde"
			or faction == 2 and playerFaction == "Alliance" then
				local name, _, icon = GetSpellInfo(spellID)
				info.text = name
				info.icon = icon
				info.value = spellID
				info.disabled = not mounts.indexBySpellID[spellID]
				info.checked = function(btn) return self.selectedValue == btn.value end
				info.func = function(btn)
					self:ddSetSelectedValue(btn.value)
					config.applyBtn:Enable()
				end
				info.OnTooltipShow = function(btn, tooltip)
					tooltip:SetHyperlink("spell:"..spellID)
				end
				self:ddAddButton(info, level)
			end
		end
	end)
	util.setCheckboxChild(self.useRepairMounts, self.repairMountsCombobox)

	-- USE MAGIC BROOM
	self.useMagicBroom = CreateFrame("CheckButton", nil, self.rightPanelScroll.child, "MJCheckButtonTemplate")
	self.useMagicBroom:SetPoint("TOPLEFT", self.repairMountsCombobox, "BOTTOMLEFT", -20, -20)
	local magicBroom = Item:CreateFromItemID(37011)
	if magicBroom:IsItemDataCached() then
		self.useMagicBroom.Text:SetText(L["Use %s"]:format(magicBroom:GetItemLink()))
	else
		magicBroom:ContinueOnItemLoad(function()
			self.useMagicBroom.Text:SetText(L["Use %s"]:format(magicBroom:GetItemLink()))
		end)
	end
	util.setHyperlinkTooltip(self.useMagicBroom)
	self.useMagicBroom.tooltipText = L["UseMagicBroomTitle"]
	self.useMagicBroom.tooltipRequirement = L["UseMagicBroomDescription"]
	self.useMagicBroom:HookScript("OnClick", applyEnable)

	-- NO PET IN RAID
	self.noPetInRaid = CreateFrame("CheckButton", nil, self.rightPanelScroll.child, "MJCheckButtonTemplate")
	self.noPetInRaid:SetPoint("TOPLEFT", self.useMagicBroom, "BOTTOMLEFT", 0, -15)
	self.noPetInRaid.Text:SetSize(245, 25)
	self.noPetInRaid.Text:SetText(L["NoPetInRaid"])
	self.noPetInRaid:HookScript("OnClick", applyEnable)

	-- NO PET IN GROUP
	self.noPetInGroup = CreateFrame("CheckButton", nil, self.rightPanelScroll.child, "MJCheckButtonTemplate")
	self.noPetInGroup:SetPoint("TOPLEFT", self.noPetInRaid, "BOTTOMLEFT", 0, -3)
	self.noPetInGroup.Text:SetSize(245, 25)
	self.noPetInGroup.Text:SetText(L["NoPetInGroup"])
	self.noPetInGroup:HookScript("OnClick", applyEnable)

	-- COPY MOUNT TARGET
	self.copyMountTarget = CreateFrame("CheckButton", nil, self.rightPanelScroll.child, "MJCheckButtonTemplate")
	self.copyMountTarget:SetPoint("TOPLEFT", self.noPetInGroup, "BOTTOMLEFT", 0, -15)
	self.copyMountTarget.Text:SetSize(245, 25)
	self.copyMountTarget.Text:SetText(L["CopyMountTarget"])
	self.copyMountTarget:HookScript("OnClick", applyEnable)

	-- ARROW BUTTONS
	self.arrowButtons = CreateFrame("CheckButton", nil, self.rightPanelScroll.child, "MJCheckButtonTemplate")
	self.arrowButtons:SetPoint("TOPLEFT", self.copyMountTarget, "BOTTOMLEFT", 0, -15)
	self.arrowButtons.Text:SetSize(245, 25)
	self.arrowButtons.Text:SetText(L["Enable arrow buttons to browse mounts"])
	self.arrowButtons:HookScript("OnClick", applyEnable)

	-- OPEN HYPERLINKS
	self.openLinks = CreateFrame("CheckButton", nil, self.rightPanelScroll.child, "MJCheckButtonTemplate")
	self.openLinks:SetPoint("TOPLEFT", self.arrowButtons, "BOTTOMLEFT", 0, -15)
	self.openLinks.Text:SetSize(245, 25)
	self.openLinks.Text:SetText(L["Open links in %s"]:format(addon))
	self.openLinks.tooltipText = L["Open links in %s"]:format(addon)
	local dressUpMod = ("-"):split(GetModifiedClick("DRESSUP"))
	local chatLinkMod = ("-"):split(GetModifiedClick("CHATLINK"))
	self.openLinks.tooltipRequirement = ("%s+%s %s\n%s+%s+%s %s"):format(dressUpMod, L["Click opens in"], addon, dressUpMod, chatLinkMod, L["Click opens in"], DRESSUP_FRAME)
	self.openLinks:HookScript("OnClick", applyEnable)

	-- APPLY
	self.applyBtn = CreateFrame("BUTTON", nil, self, "UIPanelButtonTemplate")
	self.applyBtn:SetSize(96, 22)
	self.applyBtn:Disable()
	self.applyBtn:SetPoint("BOTTOMRIGHT", -8, 8)
	self.applyBtn:SetText(APPLY)
	self.applyBtn:SetScript("OnClick", function(btn)
		PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
		self:okay()
		btn:Disable()
	end)

	-- UPDATE BINDING BUTTONS
	binding:on("SET_BINDING", function(binding, btn)
		if self.bindMount ~= btn then binding:setButtonText(self.bindMount) end
		if self.bindSecondMount ~= btn then binding:setButtonText(self.bindSecondMount) end
		self.applyBtn:Enable()
	end)

	-- REFRESH
	self:SetScript("OnShow", function(self)
		binding.unboundMessage:Hide()
		modifierCombobox:ddSetSelectedValue(mounts.config.modifier)
		modifierCombobox:ddSetSelectedText(_G[mounts.config.modifier.."_KEY"])
		self.showMinimapButton:SetChecked(not mounts.config.omb.hide)
		self.lockMinimapButton:SetChecked(mounts.config.omb.lock)
		self.useRepairMounts:SetChecked(mounts.config.useRepairMounts)
		self.repairFlyable:SetChecked(mounts.config.useRepairFlyable)
		self.repairPercent:SetNumber(tonumber(mounts.config.useRepairMountsDurability) or 0)
		self.repairFlyablePercent:SetNumber(tonumber(mounts.config.useRepairFlyableDurability) or 0)
		self.repairMountsCombobox:ddSetSelectedValue(mounts.config.repairSelectedMount)
		if mounts.config.repairSelectedMount then
			local name, _, icon = GetSpellInfo(mounts.config.repairSelectedMount)
			self.repairMountsCombobox:ddSetSelectedText(name, icon)
		else
			self.repairMountsCombobox:ddSetSelectedText(L["Random available mount"], 413588)
		end
		self.useMagicBroom:SetChecked(mounts.config.useMagicBroom)
		if self.useUnderlightAngler then
			self.useUnderlightAngler:SetChecked(mounts.config.useUnderlightAngler)
			self.autoUseUnderlightAngler:SetChecked(mounts.config.autoUseUnderlightAngler)
		end
		self.noPetInRaid:SetChecked(mounts.config.noPetInRaid)
		self.noPetInGroup:SetChecked(mounts.config.noPetInGroup)
		self.copyMountTarget:SetChecked(mounts.config.copyMountTarget)
		self.arrowButtons:SetChecked(mounts.config.arrowButtonsBrowse)
		self.openLinks:SetChecked(mounts.config.openHyperlinks)
		self.applyBtn:Disable()
	end)
	self:GetScript("OnShow")(self)
end)


function config:createMacro(macroName, buttonName, texture, openMacroFrame, overwrite)
	if InCombatLockdown() then return end
	local _, ctexture = GetMacroInfo(macroName)
	if ctexture and not overwrite then
		StaticPopup_Show(util.addonName.."MACRO_EXISTS", macroName, nil, function()
			self:createMacro(macroName, buttonName, ctexture, openMacroFrame, true)
		end)
		return
	end

	if overwrite then
		EditMacro(macroName, macroName, texture, "/click "..buttonName)
	else
		CreateMacro(macroName, texture, "/click "..buttonName)
	end

	if MacroFrame and MacroFrame:IsShown() then
		MacroFrame_Update()
	end

	if not openMacroFrame then return end

	if not IsAddOnLoaded("Blizzard_MacroUI") then
		LoadAddOn("Blizzard_MacroUI")
	end

	if not MacroFrame:IsShown() then
		InterfaceOptionsFrame:SetAttribute("UIPanelLayout-allowOtherPanels", 1)
		ShowUIPanel(MacroFrame)
		InterfaceOptionsFrame:SetAttribute("UIPanelLayout-allowOtherPanels", nil)
	end

	if MacroFrame.selectedTab ~= 1 then
		PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
		PanelTemplates_SetTab(MacroFrame, MacroFrameTab1:GetID())
		MacroFrame_SaveMacro()
		MacroFrame_SetAccountMacros()
	end

	local index = GetMacroIndexByName(macroName)
	local line = ceil(index / 6)
	MacroButtonScrollFrame:SetVerticalScroll(line < 3 and 0 or 46 * (line - 2))
	MacroButton_OnClick(_G["MacroButton"..index])
end


config.okay = function(self)
	binding.unboundMessage:Hide()
	mounts:setModifier(self.modifierCombobox.selectedValue)
	binding:saveBinding()
	local ldbi = LibStub("LibDBIcon-1.0")
	mounts.config.omb.hide = not self.showMinimapButton:GetChecked()
	if mounts.config.omb.hide then
		ldbi:Hide(addon)
	else
		ldbi:Show(addon)
	end
	if self.lockMinimapButton:GetChecked() then
		ldbi:Lock(addon)
	else
		ldbi:Unlock(addon)
	end
	mounts.config.useRepairMounts = self.useRepairMounts:GetChecked()
	mounts.config.useRepairMountsDurability = tonumber(self.repairPercent:GetText()) or 0
	mounts.config.useRepairFlyable = self.repairFlyable:GetChecked()
	mounts.config.useRepairFlyableDurability = tonumber(self.repairFlyablePercent:GetText()) or 0
	mounts:UPDATE_INVENTORY_DURABILITY()
	mounts.config.repairSelectedMount = self.repairMountsCombobox.selectedValue
	mounts.config.useMagicBroom = self.useMagicBroom:GetChecked()
	mounts.config.noPetInRaid = self.noPetInRaid:GetChecked()
	mounts.config.noPetInGroup = self.noPetInGroup:GetChecked()
	mounts.config.copyMountTarget = self.copyMountTarget:GetChecked()
	mounts.config.arrowButtonsBrowse = self.arrowButtons:GetChecked()
	mounts.config.openHyperlinks = self.openLinks:GetChecked()
	MountsJournalFrame:setArrowSelectMount(mounts.config.arrowButtonsBrowse)
end


config.cancel = function()
	binding:resetBinding()
end


-- ADD CATEGORY
InterfaceOptions_AddCategory(config)


-- OPEN CONFIG
function config:openConfig()
	if InterfaceOptionsFrameAddOns:IsVisible() and self:IsVisible() then
		InterfaceOptionsFrame:Hide()
		self:cancel()
	else
		InterfaceOptionsFrame_OpenToCategory(addon)
		if not InterfaceOptionsFrameAddOns:IsVisible() then
			InterfaceOptionsFrame_OpenToCategory(addon)
		end
	end
end


SLASH_MOUNTSCONFIG1 = "/mountconfig"
SLASH_MOUNTSCONFIG2 = "/mco"
SlashCmdList["MOUNTSCONFIG"] = function() config:openConfig() end