local addon, L = ...
local aboutConfig = CreateFrame("FRAME", "MountsJournalConfigAbout", InterfaceOptionsFramePanelContainer)
aboutConfig:Hide()
aboutConfig.name = L["About"]
aboutConfig.parent = addon


aboutConfig:SetScript("OnShow", function(self)
	self:SetScript("OnShow", nil)

	self.model = CreateFrame("PlayerModel", nil, self)
	self.model:SetSize(220, 220)
	self.model:SetPoint("TOPLEFT", 25, 20)
	self.model:SetDisplayInfo(29161)
	self.model:SetRotation(.4)

	-- ADDON NAME
	local addonName = self:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
	addonName:SetPoint("TOP", 0, -48)
	addonName:SetText(addon)
	local font, size, flags = addonName:GetFont()
	addonName:SetFont(font, 30, flags)

	-- AUTHOR
	local author = self:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	author:SetPoint("TOPRIGHT", addonName, "BOTTOM", -2, -48)
	author:SetText(L["author"])

	local authorName = self:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
	authorName:SetPoint("LEFT", author, "RIGHT", 4, 0)
	authorName:SetText(GetAddOnMetadata(addon, "Author"))

	-- VERSION
	local versionText = self:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	versionText:SetPoint("TOPRIGHT", author, "BOTTOMRIGHT", 0, -8)
	versionText:SetText(GAME_VERSION_LABEL)

	local version = self:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
	version:SetPoint("LEFT", versionText, "RIGHT", 4, 0)
	version:SetText(GetAddOnMetadata(addon, "Version"))

	-- HELP TRANSLATION
	local helpText = self:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	helpText:SetPoint("TOP", version, "BOTTOM", 0, -48)
	helpText:SetPoint("LEFT", 32, 0)
	helpText:SetText(L["Help with translation of %s. Thanks."]:format(addon))

	local link = "https://www.curseforge.com/wow/addons/mountsjournal/localization"
	local editbox = CreateFrame("Editbox", nil, self)
	editbox:SetAutoFocus(false)
	editbox:SetAltArrowKeyMode(true)
	editbox:SetFontObject("GameFontHighlight")
	editbox:SetSize(500, 20)
	editbox:SetPoint("TOPLEFT", helpText, "BOTTOMLEFT", 8, 0)
	editbox:SetText(link)
	editbox:SetCursorPosition(0)
	editbox:SetScript("OnEditFocusGained", function(self) self:HighlightText() end)
	editbox:SetScript("OnEditFocusLost", function(self) self:HighlightText(0, 0) end)
	editbox:SetScript("OnEscapePressed", function(self) self:ClearFocus() end)
	editbox:SetScript("OnTextChanged", function(self, userInput)
		if userInput then
			self:SetText(link)
			self:HighlightText()
		end
	end)

	-- TRANSLATORS
	local translators = self:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	translators:SetPoint("TOPLEFT", helpText, "BOTTOMLEFT", 0, -80)
	translators:SetText(L["Localization Translators:"])

	local langs, last = {
		{"deDE", "SlayerEGT, Asraael, Flammenengel92, isatis2109, scienetic, fredundaunted"},
		{"esMX", "Pedrorco"},
		{"frFR", "6urvan, Asraael, okaboo, Braincell1980, macumbafeh"},
		{"ptBR", "LutzPS"},
		{"zhCN", "萌丶汉丶纸"},
		{"zhTW", "BNS333"},
	}

	for _, l in ipairs(langs) do
		local sl = self:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
		if last then
			sl:SetPoint("TOPRIGHT", last, "BOTTOMLEFT", -5, -10)
		else
			sl:SetPoint("TOP", translators, "BOTTOM", 0, -16)
			sl:SetPoint("RIGHT", self, "LEFT", 136, 0)
		end
		sl:SetJustifyH("RIGHT")
		sl:SetText("|cff82c5ff"..l[1]..":|r")

		local st = self:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
		st:SetPoint("LEFT", sl, "RIGHT", 5, 0)
		st:SetPoint("RIGHT", -96, 0)
		st:SetJustifyH("LEFT")
		st:SetText("|cffffff9a"..l[2].."|r")

		last = st
	end
end)


InterfaceOptions_AddCategory(aboutConfig)