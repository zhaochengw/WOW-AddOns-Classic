local addonname = ...
local Options = CreateFrame("Frame", nil, InterfaceOptionsFramePanelContainer)
Options:Hide()
Options.name = addonname



-- Variable for easy positioning
local lastItem

-- Ro's CreateFont function for easy FontString creation
local function CreateFont(fontName, r, g, b, anchorPoint, relativeTo, relativePoint, cx, cy, xoff, yoff, text)
	local font = Options:CreateFontString(nil, "BACKGROUND", fontName)
	font:SetJustifyH("LEFT")
	font:SetJustifyV("TOP")
	if type(r) == "string" then -- r is text, no positioning
		text = r
	else
		if r then
			font:SetTextColor(r, g, b, 1)
		end
		font:SetSize(cx, cy)
		font:SetPoint(anchorPoint, relativeTo, relativePoint, xoff, yoff)
	end
	font:SetText(text)
	return font
end

local function CreateCheckbox(name, text, width, height, anchorPoint, relativeTo, relativePoint, xoff, yoff, font)
	local checkbox = CreateFrame("CheckButton", name, Options, "InterfaceOptionsCheckButtonTemplate")
	checkbox:SetPoint(anchorPoint, relativeTo, relativePoint, xoff, yoff)
	checkbox:SetSize(width, height)
	local realfont = font or "GameFontNormal"
	checkbox.text = _G[name.."Text"]
	checkbox.text:SetFontObject(realfont)
	checkbox.text:SetText(" " .. text)
	lastItem = checkbox
	return checkbox
end

local function CreateEditbox(name, text, width, height, anchorPoint, relativeTo, relativePoint, xoff, yoff, font)
	local editbox = CreateFrame("EditBox", name, Options, "InputBoxTemplate")
	editbox:SetPoint(anchorPoint, relativeTo, relativePoint, xoff, yoff)
	editbox:SetSize(width, height)
	local realfont = font or "GameFontNormal"
	editbox:SetFontObject(realfont)
	editbox:SetText(" " .. text)
	lastItem = editbox
	return editbox
end

local function CreateButton(name, text, width, height, anchorPoint, relativeTo, relativePoint, xoff, yoff, font)
	local button = CreateFrame("Button", name, Options, "UIPanelButtonTemplate")
	button:SetPoint(anchorPoint, relativeTo, relativePoint, xoff, yoff)
	button:SetSize(width, height)
	button.text = _G[name.."Text"]
	local realfont = font or "GameFontNormal"
	button.text:SetFontObject(realfont)
	button.text:SetText(" " .. text)
	lastItem = button
	return button
end

local function CreateSlider(name, text, tooltipText, minValue, maxValue, width, height, anchorPoint, relativeTo, relativePoint, xoff, yoff, font)
	local slider = CreateFrame("Slider", name, Options, "OptionsSliderTemplate")
	slider:SetPoint(anchorPoint, relativeTo, relativePoint, xoff, yoff)
	slider:SetSize(width, height)
	slider:SetOrientation("HORIZONTAL")
	slider:SetMinMaxValues(minValue, maxValue)
	slider.minValue, slider.maxValue = slider:GetMinMaxValues()
	slider.textLow = _G[name.."Low"]
	slider.textHigh = _G[name.."High"]
	slider.text = _G[name.."Text"]
	slider.textLow:SetText(slider.minValue)
	slider.textHigh:SetText(slider.maxValue)
	slider.text:SetText(text)
	slider.tooltipText = tooltipText
	slider:SetValue(25)
	slider:SetValueStep(1)

	local realfont = font or "GameFontNormal"
	slider.textValue = slider:CreateFontString()
	slider.textValue:SetFontObject(realfont)
	slider.textValue:SetTextColor(1,1,1,1)
	slider.textValue:SetText(slider:GetValue())
	slider.textValue:SetPoint("TOP", slider, "BOTTOM", 0, 0)
	slider.textValue:Show()

	lastItem = slider
	return slider
end

local panelWidth = InterfaceOptionsFramePanelContainer:GetWidth() -- ~623
local wideWidth = panelWidth - 40

local title = CreateFont("GameFontNormalLarge", "SoulSort")
title:SetPoint("TOPLEFT",16,-12)
local ver = CreateFont("GameFontNormalSmall", "version " .. GetAddOnMetadata(addonname, "Version"))
ver:SetPoint("BOTTOMLEFT", title, "BOTTOMRIGHT", 4, 0)
local auth = CreateFont("GameFontNormalSmall", "by "..GetAddOnMetadata(addonname, "Author"))
auth:SetPoint("BOTTOMLEFT", ver, "BOTTOMRIGHT", 3, 0)
local desc = CreateFont("GameFontHighlight", nil, nil, nil, "TOPLEFT", title, "BOTTOMLEFT", wideWidth, 40, 0, -4, "SoulSort is a lightweight Soul Shard management addon that keeps your Soul Shards organized in your bags. The addon sorts all Soul Shards to be at the end of your bags (as far left as possible).")

local optMaxShards = CreateSlider("optMaxShards", "Max Soul Shards", "0 = Infinite", 0, 100, 300, 16, "TOPLEFT", title, "BOTTOMLEFT", 10, -70)
local optAutoMax = CreateCheckbox("optAutoMax", "Automatic", 32, 32, "LEFT", lastItem, "RIGHT", 20, 0)
if SS_IsClassicVersion() then
	local optAutoSort = CreateCheckbox("optAutoSort", "Automatically sort Soul Shards after combat", 32, 32, "TOPLEFT", optMaxShards, "BOTTOMLEFT", 0, -30)
else
	local optAutoSort = CreateCheckbox("optAutoSort", "Automatically sort Soul Shards after combat (not supported in TBC, use \"/ss sort\" instead)", 32, 32, "TOPLEFT", optMaxShards, "BOTTOMLEFT", 0, -30)
end
local optCounter = CreateCheckbox("optCounter", "Show Total Soul Shard count on Bag Bar", 32, 32, "TOPLEFT", lastItem, "BOTTOMLEFT", 0, 0)
local optCounterPerBag = CreateCheckbox("optCounterPerBag", "Show Soul Shard count for non-Soul Bags", 32, 32, "TOPLEFT", lastItem, "BOTTOMLEFT", 0, 0)
local optSortReverse = CreateCheckbox("optSortReverse", "Fill bags from bottom to top", 32, 32, "TOPLEFT", lastItem, "BOTTOMLEFT", 0, 0)
local optShowSortInfo = CreateCheckbox("optSortInfo", "Show information about your Soul Shards in chat when sorting", 32, 32, "TOPLEFT", lastItem, "BOTTOMLEFT", 0, 0)
local optDisableCombatWarning = CreateCheckbox("optDisableCombatWarning", "Disable warning when trying to sort Soul Shards in combat", 32, 32, "TOPLEFT", lastItem, "BOTTOMLEFT", 0, 0)
local optSortButton = CreateButton("optSortButton", "Sort Now", 100, 32, "TOPLEFT", lastItem, "BOTTOMLEFT", 0, -30)

optAutoMax.tooltipText = "Fills your Soul Bag(s) or your last bag."

optMaxShards:SetScript("OnValueChanged", function(self,event,arg1) 
	SS_SetMaxShards(math.floor(optMaxShards:GetValue()))
	--SoulSortOptions.MaxShards = math.floor(optMaxShards:GetValue())
	if SoulSortOptions.MaxShards == 0 then
		optMaxShards.textValue:SetText("Infinite")
	else
		optMaxShards.textValue:SetText(SoulSortOptions.MaxShards)
	end
end)

optAutoMax:SetScript("OnClick", function(self,event,arg1)
	SoulSortOptions.AutoMax = optAutoMax:GetChecked()
	if SoulSortOptions.AutoMax == true then
		optMaxShards:Disable()
		optMaxShards:SetAlpha(0.7)
		SS_CalculateAutoSize()
		optMaxShards:SetValue(SoulSortOptions.MaxShards)
	else
		optMaxShards:Enable()
		optMaxShards:SetAlpha(1)
	end
end)

if SS_IsClassicVersion() then
	optAutoSort:SetScript("OnClick", function(self,event,arg1) 
		SoulSortOptions.AutoSort = optAutoMax:GetChecked()
	end)
end

optCounter:SetScript("OnClick", function(self,event,arg1)
	SoulSortOptions.ShowCounter = optCounter:GetChecked()
	SS_UpdateCounterVisibilty()
end)

optCounterPerBag:SetScript("OnClick", function(self,event,arg1)
	SoulSortOptions.ShowCounterPerBag = optCounterPerBag:GetChecked()
	SS_UpdateCounterVisibilty()
end)

optSortButton:SetScript("OnClick", function(self,event,arg1) 
	if not InCombatLockdown() then
		SS_SortShards()
	else
		print("SoulSort: Cannot sort while in combat!")
	end
end)

function Options.refresh()
	optMaxShards:SetValue(SoulSortOptions.MaxShards)
	optAutoMax:SetChecked(SoulSortOptions.AutoMax)
	if SS_IsClassicVersion() then
		optAutoSort:SetChecked(SoulSortOptions.AutoSort)
	else
		optAutoSort:SetChecked(false)
		optAutoSort:Disable()
		optAutoSort:SetAlpha(0.7)
	end
	optCounter:SetChecked(SoulSortOptions.ShowCounter)
	optCounterPerBag:SetChecked(SoulSortOptions.ShowCounterPerBag)
	optSortReverse:SetChecked(SoulSortOptions.SortReverse)
	optShowSortInfo:SetChecked(SoulSortOptions.ShowSortInfo)
	optDisableCombatWarning:SetChecked(not SoulSortOptions.ShowCombatWarning);

	if SoulSortOptions.AutoMax == true then
		optMaxShards:Disable()
		optMaxShards:SetAlpha(0.7)
	else
		optMaxShards:Enable()
		optMaxShards:SetAlpha(1)
	end
end

function Options.okay()
	SS_SetMaxShards(optMaxShards:GetValue())
	--SoulSortOptions.MaxShards = optMaxShards:GetValue()
	SoulSortOptions.AutoMax = optAutoMax:GetChecked()
	if SS_IsClassicVersion() then
		SoulSortOptions.AutoSort = optAutoSort:GetChecked()
	end
	SoulSortOptions.ShowCounter = optCounter:GetChecked()
	SoulSortOptions.SortReverse = optSortReverse:GetChecked()
	SoulSortOptions.ShowSortInfo = optShowSortInfo:GetChecked()
	SoulSortOptions.ShowCombatWarning = not optDisableCombatWarning:GetChecked()
end

-- Add the options panel to the Blizzard list
InterfaceOptions_AddCategory(Options)