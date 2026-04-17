local AddonName, AddonTable = ...
local L = AddonTable.Localize
local AddonTitle = select(2, C_AddOns.GetAddOnInfo("XPBarText"))
local PlainAddonTitle = AddonTitle:gsub("|c........", ""):gsub("|r", "")

local XPTOptions = CreateFrame("Frame")
XPTOptions:RegisterEvent("ADDON_LOADED")

local function XPTOptionsHandler(self, event, arg1)

if event == "ADDON_LOADED" and arg1 == "XPBarText" then
	SlashCmdList["XPTConfig"] = XPTConfigWindow;
		SLASH_XPTConfig1 = "/xpt"
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

-- Number Formatting

local chkNumberFormatting = CreateFrame("CheckButton", nil, XPTIOFrame, "OptionsBaseCheckButtonTemplate")
chkNumberFormatting:SetPoint("TOPLEFT", chkShowFullInfo, "BOTTOMLEFT", 0, -16)

chkNumberFormatting:SetScript("OnUpdate", function(frame)
	if XPTConfig.FormatNumbers == "YES" then
		chkNumberFormatting:SetChecked(true)
		UpdateXPBarText()
	elseif XPTConfig.FormatNumbers == "NO" then
		chkNumberFormatting:SetChecked(false)
		UpdateXPBarText()
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

-- Toggle Rested XP Ticker

local chkToggleRestedTicker = CreateFrame("CheckButton", nil, XPTIOFrame, "OptionsBaseCheckButtonTemplate")
chkToggleRestedTicker:SetPoint("TOPLEFT", chkNumberFormatting, "BOTTOMLEFT", 0, -16)

chkToggleRestedTicker:SetScript("OnUpdate", function(frame)
	if XPTConfig.ShowXPTicker == "YES" then
		chkToggleRestedTicker:SetChecked(true)
	elseif XPTConfig.ShowXPTicker == "NO" then
		chkToggleRestedTicker:SetChecked(false)
	end
end)

chkToggleRestedTicker:SetScript("OnClick", function(frame)
	local tick = frame:GetChecked()

	if tick == false then
		XPTConfig.ShowXPTicker = 'NO'
	elseif tick == true then
		XPTConfig.ShowXPTicker = 'YES'
	end
	
	UpdateXPBarText()
	UpdateXPTicker()
end)

local chkToggleRestedTickerText = XPTIOFrame:CreateFontString(nil, nil, "GameFontHighlight")
chkToggleRestedTickerText:SetPoint("LEFT", chkToggleRestedTicker, "RIGHT", 0, 1)
chkToggleRestedTickerText:SetText(L["Show Rested XP Ticker"])

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

function XPTConfigWindow()
	local category = XPTIOFrame.Category
	if category then
		Settings.OpenToCategory(category:GetID())
	else
		print("Category not found")
	end
end