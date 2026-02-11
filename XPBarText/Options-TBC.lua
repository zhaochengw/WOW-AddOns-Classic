local AddonName, AddonTable = ...
local L = AddonTable.Localize
local AddonTitle = select(2, C_AddOns.GetAddOnInfo(AddonName))
local PlainAddonTitle = AddonTitle:gsub("|c........", ""):gsub("|r", "")

local XPTOptions = CreateFrame("Frame")
XPTOptions:RegisterEvent("ADDON_LOADED")

local function XPTOptionsHandler(self, event, arg1)

if event == "ADDON_LOADED" and arg1 == "XPBarText" then
	SlashCmdList["XPTCONFIG"] = xptconfig;
		SLASH_XPTCONFIG1 = "/xpt"
end
	
end

XPTOptions:SetScript("OnEvent", XPTOptionsHandler)

local XPTIOFrame = CreateFrame("Frame")
XPTIOFrame.name = "XP Bar Text"

local lblTitle = XPTIOFrame:CreateFontString(nil, nil, "GameFontHighlight")
lblTitle:SetFont("Fonts\\FRIZQT__.TTF", 12)
lblTitle:SetPoint("TOPLEFT", XPTIOFrame, "TOPLEFT", 12, -12)
lblTitle:SetText("XP Bar Text v" .. C_AddOns.GetAddOnMetadata("XPBarText", "Version"))

localizedClass, englishClass, classIndex = UnitClass("player")

-- Toggle Full Information Display

local chkShowFullInfo = CreateFrame("CheckButton", nil, XPTIOFrame, "OptionsBaseCheckButtonTemplate")
chkShowFullInfo:SetPoint("TOPLEFT", lblTitle, "BOTTOMLEFT", 0, -16)

chkShowFullInfo:SetScript("OnUpdate", function(frame)
	if XPTConfig.ShowMoreInfo == "YES" then
		chkShowFullInfo:SetChecked(true)
	elseif XPTConfig.ShowMoreInfo == "NO" then
		chkShowFullInfo:SetChecked(false)
	end
end)

chkShowFullInfo:SetScript("OnClick", function(frame)
	local tick = frame:GetChecked()

	if tick == false then
		XPTConfig.ShowMoreInfo = 'NO'
	elseif tick == true then
		XPTConfig.ShowMoreInfo = 'YES'
	end
	
	UpdateXPBarText()
end)

local chkShowFullInfoText = XPTIOFrame:CreateFontString(nil, nil, "GameFontHighlight")
chkShowFullInfoText:SetPoint("LEFT", chkShowFullInfo, "RIGHT", 0, 1)
chkShowFullInfoText:SetText(L["Show more information on XP bar"])

-- Always Show Information

local chkAlwaysShowInfo = CreateFrame("CheckButton", nil, XPTIOFrame, "OptionsBaseCheckButtonTemplate")
chkAlwaysShowInfo:SetPoint("TOPLEFT", chkShowFullInfo, "BOTTOMLEFT", 0, -16)


chkAlwaysShowInfo:SetScript("OnUpdate", function(frame)
	if XPTConfig.AlwaysShowInfo == "YES" then
		chkAlwaysShowInfo:SetChecked(true)
	elseif XPTConfig.AlwaysShowInfo == "NO" then
		chkAlwaysShowInfo:SetChecked(false)
	end
end)

chkAlwaysShowInfo:SetScript("OnClick", function(frame)
	local tick = frame:GetChecked()

	if tick == false then
		XPTConfig.AlwaysShowInfo = 'NO'
	elseif tick == true then
		XPTConfig.AlwaysShowInfo = 'YES'
	end
	
	UpdateXPBarText()
end)

local chkAlwaysShowInfoText = XPTIOFrame:CreateFontString(nil, nil, "GameFontHighlight")
chkAlwaysShowInfoText:SetPoint("LEFT", chkAlwaysShowInfo, "RIGHT", 0, 1)
chkAlwaysShowInfoText:SetText(L["Always show information on XP bar"])

chkAlwaysShowInfo:SetScript("OnEnter", function(self)
	GameTooltip:SetOwner(self, "ANCHOR_TOP")
	GameTooltip:AddLine(L["If unchecked, the information will only be visible when you move the cursor over the XP bar."], 1, 1, 1)
	GameTooltip:Show()
end)

chkAlwaysShowInfo:SetScript("OnLeave", function(self)
	GameTooltip:Hide()
end)

-- Number Formatting

local chkNumberFormatting = CreateFrame("CheckButton", nil, XPTIOFrame, "OptionsBaseCheckButtonTemplate")
chkNumberFormatting:SetPoint("TOPLEFT", chkAlwaysShowInfo, "BOTTOMLEFT", 0, -16)

chkNumberFormatting:SetScript("OnUpdate", function(frame)
	if XPTConfig.FormatNumbers == "YES" then
		chkNumberFormatting:SetChecked(true)
	elseif XPTConfig.FormatNumbers == "NO" then
		chkNumberFormatting:SetChecked(false)
	end
end)

chkNumberFormatting:SetScript("OnClick", function(frame)
	local tick = frame:GetChecked()

	if tick == false then
		XPTConfig.FormatNumbers = 'NO'
	elseif tick == true then
		XPTConfig.FormatNumbers = 'YES'
	end
	
	UpdateXPBarText()
end)

local chkNumberFormattingText = XPTIOFrame:CreateFontString(nil, nil, "GameFontHighlight")
chkNumberFormattingText:SetPoint("LEFT", chkNumberFormatting, "RIGHT", 0, 1)
chkNumberFormattingText:SetText(L["Number Formatting"])

chkNumberFormatting:SetScript("OnEnter", function(self)
	GameTooltip:SetOwner(self, "ANCHOR_TOP")
	GameTooltip:AddLine(L["If enabled, numbers will be separated using a comma for easier reading."], 1, 1, 1)
	GameTooltip:Show()
end)

chkNumberFormatting:SetScript("OnLeave", function(self)
	GameTooltip:Hide()
end)

if classIndex == 3 then

-- Toggle Pet Information (Hunters only)

local chkShowPetInfo = CreateFrame("CheckButton", nil, XPTIOFrame, "OptionsBaseCheckButtonTemplate")
chkShowPetInfo:SetPoint("TOPLEFT", chkNumberFormatting, "BOTTOMLEFT", 0, -16)

chkShowPetInfo:SetScript("OnUpdate", function(frame)
	if XPTConfig.ShowPetInfo == "YES" then
		chkShowPetInfo:SetChecked(true)
	elseif XPTConfig.ShowPetInfo == "NO" then
		chkShowPetInfo:SetChecked(false)
	end
end)

chkShowPetInfo:SetScript("OnClick", function(frame)
	local tick = frame:GetChecked()

	if tick == false then
		XPTConfig.ShowPetInfo = 'NO'
	elseif tick == true then
		XPTConfig.ShowPetInfo = 'YES'
	end
	
	UpdateXPBarText()
end)

local chkShowPetInfoText = XPTIOFrame:CreateFontString(nil, nil, "GameFontHighlight")
chkShowPetInfoText:SetPoint("LEFT", chkShowPetInfo, "RIGHT", 0, 1)
chkShowPetInfoText:SetText(L["Show pet information on XP bar"])

end

-- Discord Info

local DiscordLogo = XPTIOFrame:CreateTexture(nil, "ARTWORK")
DiscordLogo:SetPoint("TOPLEFT", chkNumberFormatting, "BOTTOMLEFT", 0, -96)
DiscordLogo:SetSize(16, 16)
DiscordLogo:SetTexture("Interface\\AddOns\\XPBarText\\Textures\\DiscordLogo.tga")

local lblDiscord = XPTIOFrame:CreateFontString(nil, nil, "GameFontHighlight")
lblDiscord:SetPoint("LEFT", DiscordLogo, "RIGHT", 4, 0)
lblDiscord:SetText("|cFFEFC502https://discord.gg/BGKnpza|r")

-- Twitter Info

local TwitterLogo = XPTIOFrame:CreateTexture(nil, "ARTWORK")
TwitterLogo:SetPoint("TOPLEFT", DiscordLogo, "BOTTOMLEFT", 0, -8)
TwitterLogo:SetSize(16, 16)
TwitterLogo:SetTexture("Interface\\AddOns\\XPBarText\\Textures\\TwitterLogo.tga")

local lblTwitter = XPTIOFrame:CreateFontString(nil, nil, "GameFontHighlight")
lblTwitter:SetPoint("LEFT", TwitterLogo, "RIGHT", 4, 0)
lblTwitter:SetText("|cFFEFC502@GeodesicDragon|r")

local category, layout = Settings.RegisterCanvasLayoutCategory(XPTIOFrame, "XP Bar Text")
Settings.RegisterAddOnCategory(category)
XPTIOFrame.Category = category

function xptconfig()
	local category = XPTIOFrame.Category
	if category then
		Settings.OpenToCategory(category:GetID())
	else
		print("Category not found")
	end
end

--InterfaceOptions_AddCategory(XPTIOFrame);

--function xptconfig()
	--InterfaceOptionsFrame_OpenToCategory("XP Bar Text")
	--InterfaceOptionsFrame_OpenToCategory("XP Bar Text")
--end