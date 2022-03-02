local addonName, addon = ...

local LOC = {
	Left = "左",
	Right = "右",
	Up = "上",
	Down = "下",
	Horizontal = "水平",
	Vertical = "垂直",
	Water = "造水",
	Food = "造食",
	Teleports = "传送",
	Portals = "传送门",
	Gems = "法力宝石",
	Polymorph = "变形术",
	_RITUAL = "餐桌",
	none = "无",
}


local _, playerClass = UnitClass("player")
if playerClass ~= "MAGE" then
	print("MageButtons disabled, you are not a mage :(")
	return 0
end

local AceGUI = LibStub("AceGUI-3.0")
local btnTbl = {}
local directionTbl = {}


-- Main options panel
mbPanel = CreateFrame("Frame")
mbPanel.name = addonName
InterfaceOptions_AddCategory(mbPanel)

-- Title Text
local title = mbPanel:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
title:SetPoint("TOPLEFT", 16, -16)
title:SetText(addonName)

-- Label for dropdown boxes
local usageText = mbPanel:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
usageText:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -70)
usageText:SetJustifyH("LEFT")
usageText:SetText("按钮顺序 (从左至右，或从上至下):")

-- Bottom usage text
local usageText2 = mbPanel:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
usageText2:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 85, -420)
usageText2:SetJustifyH("CENTER")
usageText2:SetText("点击确定更改, 请重载界面 (/reload)\n(重载后才会正确加载按钮材质)")

---------------------------------
-- Checkbox for Button Borders --
---------------------------------
local mbBorderCheck = CreateFrame("CheckButton", "mbBorderCheck", mbPanel, "InterfaceOptionsCheckButtonTemplate")
mbBorderCheckText:SetText("隐藏按钮边框")
mbBorderCheck.tooltipText = "隐藏默认按钮边框 / 变为方形按钮"

-- Load the current checkbox state when the options panel opens
mbBorderCheck:SetScript("OnShow",
	function()
		local borderStatus = addon:getSV("borderStatus", "borderStatus") or 1

		if ( borderStatus == 1 ) then
			mbBorderCheck:SetChecked(true)
		else
			mbBorderCheck:SetChecked(false)
		end
	end
)
mbBorderCheck:SetPoint("TOPLEFT", mbPanel, "TOPLEFT", 20, -40)

-- Store checkbox state in SavedVariables
mbBorderCheck:SetScript("OnClick",
	function()
		if (mbBorderCheck:GetChecked()) then
			borderTbl = {
				borderStatus = 1,
			}

			MageButtonsDB["borderStatus"] = borderTbl
		else
			borderTbl = {
				borderStatus = 0,
			}

			MageButtonsDB["borderStatus"] = borderTbl
		end
	end
);

---------------------------------
-- Checkbox for minimap button --
---------------------------------
local mbMapCheck = CreateFrame("CheckButton", "mbMapCheck", mbPanel, "InterfaceOptionsCheckButtonTemplate")
mbMapCheckText:SetText("显示小地图按钮")
mbMapCheck.tooltipText = "显示或隐藏小地图按钮"

-- Load the current checkbox state when the options panel opens
mbMapCheck:SetScript("OnShow",
	function()
		local maptbl = MageButtonsDB["minimap"]

		if ( maptbl.icon == 1 ) then
			mbMapCheck:SetChecked(true)
		else
			mbMapCheck:SetChecked(false)
		end
	end
)
mbMapCheck:SetPoint("TOPLEFT", mbPanel, "TOPLEFT", 20, -60)

-- Store checkbox state in SavedVariables
mbMapCheck:SetScript("OnClick",
	function()
		if (mbMapCheck:GetChecked()) then
			mapTbl = {
				icon = 1,
			}

			MageButtonsDB["minimap"] = mapTbl
			local tog = 1
			addon:maptoggle(tog)
		else
			mapTbl = {
				icon = 0,
			}

			MageButtonsDB["minimap"] = mapTbl
			local tog = 0
			addon:maptoggle(tog)
		end

	end
);

-----------------------------
-- Checkbox for frame lock --
-----------------------------
local mbLockCheck = CreateFrame("CheckButton", "mbLockCheck", mbPanel, "InterfaceOptionsCheckButtonTemplate")
mbLockCheckText:SetText("锁定 / 解锁")
mbLockCheck.tooltipText = "锁定或解锁法师按钮框架"

-- Load the current checkbox state when the options panel opens
mbLockCheck:SetScript("OnShow",
	function()
		local lockStatus = addon:getSV("framelock", "lock") or 0

		if ( lockStatus == 1 ) then
			mbLockCheck:SetChecked(true)
		else
			mbLockCheck:SetChecked(false)
		end
	end
)
mbLockCheck:SetPoint("LEFT", mbBorderCheck, "RIGHT", 150, 0)

-- Store checkbox state in SavedVariables
mbLockCheck:SetScript("OnClick",
	function()
		if (mbLockCheck:GetChecked()) then
			lockTbl = {
				lock = 1,
			}

			MageButtonsDB["framelock"] = lockTbl

			addon.config_frame:SetMovable(false)
			addon.config_frame:EnableMouse(false)
			addon.config_frame:SetBackdropColor(0, 0, 0, 0)
			lockStatus = 1
		else
			lockTbl = {
				lock = 0,
			}

			MageButtonsDB["framelock"] = lockTbl

			addon.config_frame:SetMovable(true)
			addon.config_frame:EnableMouse(true)
			addon.config_frame:SetBackdropColor(0, .7, 1, 1)
			lockStatus = 0
		end

	end
);
----------------
--   Events   --
----------------
function addon.init_config()
	MageButtonsDB = MageButtonsDB or {  };

	local buttonNames = {"1", "2", "3", "4", "5", "6", "7", }
	local button1value = "none"
	local btnNumber = 1
	local buttonvalue = MageButtonsDB["btnNumber" .. btnNumber]

	-- list of choices
	buttonTypeTable = { "Water", "Food", "Teleports", "Portals", "Gems", "Polymorph", "_RITUAL", "none", }
	categories = { "Water", "Food", "Teleports", "Portals", "Gems", "Polymorph", "_RITUAL", }

	local i = 1
	local yoffset = -30

	btnTbl["1"] = addon:getSV("buttons", "1")
	btnTbl["2"] = addon:getSV("buttons", "2")
	btnTbl["3"] = addon:getSV("buttons", "3")
	btnTbl["4"] = addon:getSV("buttons", "4")
	btnTbl["5"] = addon:getSV("buttons", "5")
	btnTbl["6"] = addon:getSV("buttons", "6")
	btnTbl["7"] = addon:getSV("buttons", "7")

	for i = 1, 7, 1 do
		buttonKey = buttonNames[i]
		defaultValue = "set me!"
		if i == 1 then
			btype1 = addon:getSV("buttons", "1") or defaultValue
			buttonTypeTable1 = { btype1, "Water", "Food", "Teleports", "Portals", "Gems", "Polymorph", "_RITUAL", "none"}
		elseif i == 2 then
			btype2 = addon:getSV("buttons", "2") or defaultValue
			buttonTypeTable2 = { btype2, "Water", "Food", "Teleports", "Portals", "Gems", "Polymorph", "_RITUAL", "none"}
		elseif i == 3 then
			btype3 = addon:getSV("buttons", "3") or defaultValue
			buttonTypeTable3 = { btype3, "Water", "Food", "Teleports", "Portals", "Gems", "Polymorph", "_RITUAL", "none"}
		elseif i == 4 then
			btype4 = addon:getSV("buttons", "4") or defaultValue
			buttonTypeTable4 = { btype4, "Water", "Food", "Teleports", "Portals", "Gems", "Polymorph", "_RITUAL", "none"}
		elseif i == 5 then
			btype5 = addon:getSV("buttons", "5") or defaultValue
			buttonTypeTable5 = { btype5, "Water", "Food", "Teleports", "Portals", "Gems", "Polymorph", "_RITUAL", "none"}
		elseif i == 6 then
			btype6 = addon:getSV("buttons", "6") or defaultValue
			buttonTypeTable6 = { btype6, "Water", "Food", "Teleports", "Portals", "Gems", "Polymorph", "_RITUAL", "none"}
		elseif i == 7 then
			btype6 = addon:getSV("buttons", "7") or defaultValue
			buttonTypeTable7 = { btype6, "Water", "Food", "Teleports", "Portals", "Gems", "Polymorph", "_RITUAL", "none"}
		end

		--------------------
		-- Dropdown Boxes --
		--------------------
		local obj = [[if not buttonTypes]] .. i .. [[ then
			CreateFrame("Button", "buttonTypes]] .. i .. [[", mbPanel, "UIDropDownMenuTemplate")
		end

		buttonTypes]] .. i .. [[:ClearAllPoints()
		buttonTypes]] .. i .. [[:SetPoint("TOPLEFT", mbMapCheck, "BOTTOMLEFT", -2, ]] .. yoffset.. [[)
		buttonTypes]] .. i .. [[:Show()

		local buttonLabel]] .. i .. [[ = mbPanel:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
		buttonLabel]] .. i .. [[:SetPoint("RIGHT", buttonTypes]] .. i .. [[, "LEFT", 7, 0)
		buttonLabel]] .. i .. [[:SetJustifyH("LEFT")
		buttonLabel]] .. i .. [[:SetText("]] .. i .. [[")
		]]
		local cmdRun = assert(loadstring(obj))
		cmdRun()

		-- return dropdown selection and
		-- dropdown box properties
		if i == 1 then
			local function OnClick(self)
				UIDropDownMenu_SetSelectedID(buttonTypes1, self:GetID(), text, value)
				if self.value ~= nil then btnTbl["1"] = self.value end
				return btnTbl[buttonKey]
			end

			local function initialize(self, level)
			for k,v in pairs(buttonTypeTable1) do
					info = UIDropDownMenu_CreateInfo(); info.text = LOC[v]; info.value = v; info.func = OnClick; UIDropDownMenu_AddButton(info, level)
				end
			end

			UIDropDownMenu_Initialize(buttonTypes1, initialize)
		elseif i == 2 then
			local function OnClick(self)
				UIDropDownMenu_SetSelectedID(buttonTypes2, self:GetID(), text, value)
				btnTbl["2"] = self.value
				if self.value ~= nil then btnTbl["2"] = self.value end
				return btnTbl[buttonKey]
			end

			local function initialize(self, level)
			for k,v in pairs(buttonTypeTable2) do
					info = UIDropDownMenu_CreateInfo(); info.text = LOC[v]; info.value = v; info.func = OnClick; UIDropDownMenu_AddButton(info, level)
				end
			end

			UIDropDownMenu_Initialize(buttonTypes2, initialize)
		elseif i == 3 then
			local function OnClick(self)
				UIDropDownMenu_SetSelectedID(buttonTypes3, self:GetID(), text, value)
				btnTbl["3"] = self.value
				if self.value ~= nil then btnTbl["3"] = self.value end
				return btnTbl[buttonKey]
			end

			local function initialize(self, level)
			for k,v in pairs(buttonTypeTable3) do
					info = UIDropDownMenu_CreateInfo(); info.text = LOC[v]; info.value = v; info.func = OnClick; UIDropDownMenu_AddButton(info, level)
				end
			end

			UIDropDownMenu_Initialize(buttonTypes3, initialize)
		elseif i == 4 then
			local function OnClick(self)
				UIDropDownMenu_SetSelectedID(buttonTypes4, self:GetID(), text, value)
				btnTbl["4"] = self.value
				if self.value ~= nil then btnTbl["4"] = self.value end
				return btnTbl[buttonKey]
			end

			local function initialize(self, level)
			for k,v in pairs(buttonTypeTable4) do
					info = UIDropDownMenu_CreateInfo(); info.text = LOC[v]; info.value = v; info.func = OnClick; UIDropDownMenu_AddButton(info, level)
				end
			end

			UIDropDownMenu_Initialize(buttonTypes4, initialize)
		elseif i == 5 then
			local function OnClick(self)
				UIDropDownMenu_SetSelectedID(buttonTypes5, self:GetID(), text, value)
				btnTbl["5"] = self.value
				if self.value ~= nil then btnTbl["5"] = self.value end
				return btnTbl[buttonKey]
			end

			local function initialize(self, level)
			for k,v in pairs(buttonTypeTable5) do
					info = UIDropDownMenu_CreateInfo(); info.text = LOC[v]; info.value = v; info.func = OnClick; UIDropDownMenu_AddButton(info, level)
				end
			end

			UIDropDownMenu_Initialize(buttonTypes5, initialize)
		elseif i == 6 then
			local function OnClick(self)
				UIDropDownMenu_SetSelectedID(buttonTypes6, self:GetID(), text, value)
				btnTbl["6"] = self.value
				if self.value ~= nil then btnTbl["6"] = self.value end
				return btnTbl[buttonKey]
			end

			local function initialize(self, level)
			for k,v in pairs(buttonTypeTable6) do
					info = UIDropDownMenu_CreateInfo(); info.text = LOC[v]; info.value = v; info.func = OnClick; UIDropDownMenu_AddButton(info, level)
				end
			end

			UIDropDownMenu_Initialize(buttonTypes6, initialize)
		elseif i == 7 then
			local function OnClick(self)
				UIDropDownMenu_SetSelectedID(buttonTypes7, self:GetID(), text, value)
				btnTbl["7"] = self.value
				if self.value ~= nil then btnTbl["7"] = self.value end
				return btnTbl[buttonKey]
			end

			local function initialize(self, level)
			for k,v in pairs(buttonTypeTable7) do
					info = UIDropDownMenu_CreateInfo(); info.text = LOC[v]; info.value = v; info.func = OnClick; UIDropDownMenu_AddButton(info, level)
				end
			end

			UIDropDownMenu_Initialize(buttonTypes7, initialize)
		end

		local obj2 = [[UIDropDownMenu_SetWidth(buttonTypes]] .. i .. [[, 100);
		UIDropDownMenu_SetButtonWidth(buttonTypes]] .. i .. [[, 124)
		UIDropDownMenu_SetSelectedID(buttonTypes]] .. i .. [[, 1)
		UIDropDownMenu_JustifyText(buttonTypes]] .. i .. [[, "LEFT")

		]]
		local cmdRun2 = assert(loadstring(obj2))
		cmdRun2()
		yoffset = yoffset - 20
	end


	-------------------------------------------
	--- Drop Down Menu for Growth Direction ---
	-------------------------------------------
	local direction = addon:getSV("growth", "direction")
	if direction == 0 then
		direction = "Vertical"
	end
	directionTbl["direction"] = direction

	if not growthDirectionBox then
		CreateFrame("Button", "growthDirectionBox", mbPanel, "UIDropDownMenuTemplate")
	end

	growthDirectionBox:ClearAllPoints()
	growthDirectionBox:SetPoint("TOPLEFT", mbMapCheck, "BOTTOMLEFT", 0, -190)
	growthDirectionBox:Show()

	-- list of choices
	local directions = {
		direction,
		"Horizontal",
		"Vertical",
	}

	-- return dropdown selection
	local function OnClick(self)
		UIDropDownMenu_SetSelectedID(growthDirectionBox, self:GetID(), text, value)
		growthDirection = self.value
		directionTbl["direction"] = growthDirection
		return growthDirection
	end

	-- dropdown box properties
	local function initialize(self, level)
		local info = UIDropDownMenu_CreateInfo()
		for k,v in pairs(directions) do
			info = UIDropDownMenu_CreateInfo()
			info.text = LOC[v]
			info.value = v
			info.func = OnClick
			UIDropDownMenu_AddButton(info, level)
		end
	end

	UIDropDownMenu_Initialize(growthDirectionBox, initialize)
	UIDropDownMenu_SetWidth(growthDirectionBox, 100);
	UIDropDownMenu_SetButtonWidth(growthDirectionBox, 124)
	UIDropDownMenu_SetSelectedID(growthDirectionBox, 1)
	UIDropDownMenu_JustifyText(growthDirectionBox, "LEFT")

	growthDirectionBox.Label = growthDirectionBox:CreateFontString(nil, 'ARTWORK', 'GameFontWhiteSmall')
	growthDirectionBox.Label:SetPoint("BOTTOMLEFT", growthDirectionBox, "TOPLEFT", 10, 1)
	growthDirectionBox.Label:SetText("排列方向:")


	-------------------------------------------
	--- Drop Down Menu for Button Direction ---
	-------------------------------------------
	local buttonDir = addon:getSV("growth", "buttons")
	if buttonDir == 0 then
		buttonDir = "Left"
	end
	directionTbl["buttons"] = buttonDir

	if not buttonDirectionBox then
		CreateFrame("Button", "buttonDirectionBox", mbPanel, "UIDropDownMenuTemplate")
	end

	buttonDirectionBox:ClearAllPoints()
	buttonDirectionBox:SetPoint("TOPLEFT", mbMapCheck, "BOTTOMLEFT", 0, -250)
	buttonDirectionBox:Show()

	-- list of choices
	local buttonDirs = {
		buttonDir,
		"Left",
		"Right",
		"Up",
		"Down",
	}

	-- return dropdown selection
	local function OnClick(self)
		UIDropDownMenu_SetSelectedID(buttonDirectionBox, self:GetID(), text, value)
		buttonDirection = self.value
		directionTbl["buttons"] = buttonDirection
		return buttonDirection
	end

	-- dropdown box properties
	local function initialize(self, level)
		local info = UIDropDownMenu_CreateInfo()
		for k,v in pairs(buttonDirs) do
			info = UIDropDownMenu_CreateInfo()
			info.text = LOC[v]
			info.value = v
			info.func = OnClick
			UIDropDownMenu_AddButton(info, level)
		end
	end

	UIDropDownMenu_Initialize(buttonDirectionBox, initialize)
	UIDropDownMenu_SetWidth(buttonDirectionBox, 100);
	UIDropDownMenu_SetButtonWidth(buttonDirectionBox, 124)
	UIDropDownMenu_SetSelectedID(buttonDirectionBox, 1)
	UIDropDownMenu_JustifyText(buttonDirectionBox, "LEFT")

	buttonDirectionBox.Label = buttonDirectionBox:CreateFontString(nil, 'ARTWORK', 'GameFontWhiteSmall')
	buttonDirectionBox.Label:SetPoint("BOTTOMLEFT", buttonDirectionBox, "TOPLEFT", 10, 1)
	buttonDirectionBox.Label:SetText("按钮排列方向:")

	---------------------------------------
	-- Color picker for background color --
	-- (largely borrowed from TidyPlates)--
	---------------------------------------
	local workingFrame
	local function ChangeColor(cancel)
		local a, r, g, b
		if cancel then
			--r,g,b,a = unpack(ColorPickerFrame.startingval )
			workingFrame:SetBackdropColor(unpack(ColorPickerFrame.startingval ))
		else
			a, r, g, b = OpacitySliderFrame:GetValue(), ColorPickerFrame:GetColorRGB();
			workingFrame:SetBackdropColor(r,g,b,1-a)
			redBox:SetText(r)
			blueBox:SetText(b)
			greenBox:SetText(g)
			alphaBox:SetText(1-a)
			if workingFrame.OnValueChanged then workingFrame:OnValueChanged() end
		end
	end

	local function ShowColorPicker(cpframe)
		local r,g,b,a = cpframe:GetBackdropColor()
		workingFrame = cpframe
		ColorPickerFrame.func, ColorPickerFrame.opacityFunc, ColorPickerFrame.cancelFunc = 	ChangeColor, ChangeColor, ChangeColor;
		ColorPickerFrame.startingval  = {r,g,b,a}
		ColorPickerFrame:SetColorRGB(r,g,b);
		ColorPickerFrame.hasOpacity = true
		ColorPickerFrame.opacity = 1 - a
		ColorPickerFrame:SetFrameStrata(cpframe:GetFrameStrata())
		ColorPickerFrame:SetFrameLevel(cpframe:GetFrameLevel()+1)
		ColorPickerFrame:Hide(); ColorPickerFrame:Show(); -- Need to activate the OnShow handler.
	end

	-- Save the RGBA values to Saved Variables
	local redValue = addon:getSV("bgcolor", "red") or .1
	local greenValue = addon:getSV("bgcolor", "green") or .1
	local blueValue = addon:getSV("bgcolor", "blue") or .1
	local alphaValue = addon:getSV("bgcolor", "alpha") or 1

	local colorbox = CreateFrame("Button", colorbox, mbPanel)
	colorbox:SetWidth(24)
	colorbox:SetHeight(24)
	colorbox:SetPoint("LEFT", usageText, "RIGHT", 80, -20)
	colorbox:SetBackdrop({bgFile = "Interface\\ChatFrame\\ChatFrameColorSwatch",
											edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
											tile = false, tileSize = 16, edgeSize = 8,
											insets = { left = 1, right = 1, top = 1, bottom = 1 }});
	colorbox:SetBackdropColor(redValue, greenValue, blueValue, alphaValue);
	colorbox:SetScript("OnClick",function()
		local rc, bc gc, al = ShowColorPicker(colorbox)
	end)

	colorbox.Label = colorbox:CreateFontString(nil, 'ARTWORK', 'GameFontWhiteSmall')
	colorbox.Label:SetPoint("BOTTOMLEFT", colorbox, "TOPLEFT", -10, 3)
	colorbox.Label:SetText("框架背景颜色 (R, G, B, A):")

	colorbox.GetValue = function() local color = {}; color.r, color.g, color.b, color.a = colorbox:GetBackdropColor(); return color end
	colorbox.SetValue = function(self, color)
		colorbox:SetBackdropColor(color.r, color.g, color.b, color.a)
	end

	--------------------------------
	-- Text boxes for RGBA values --
	--------------------------------
	redBox = CreateFrame("EditBox", redBox, mbPanel, "InputBoxTemplate")
	redBox:SetWidth(30)
	redBox:SetHeight(30)
	redBox:SetPoint("LEFT", colorbox, "RIGHT", 20, 0)
	redBox:SetMaxLetters(4)
	redBox:SetHyperlinksEnabled(false)
	redBox:SetText(redValue)
	redBox:SetAutoFocus(false)
	redBox:SetCursorPosition(0)

	greenBox = CreateFrame("EditBox", greenBox, mbPanel, "InputBoxTemplate")
	greenBox:SetWidth(30)
	greenBox:SetHeight(30)
	greenBox:SetPoint("LEFT", redBox, "RIGHT", 10, 0)
	greenBox:SetMaxLetters(4)
	greenBox:SetHyperlinksEnabled(false)
	greenBox:SetText(greenValue)
	greenBox:SetAutoFocus(false)
	greenBox:SetCursorPosition(0)

	blueBox = CreateFrame("EditBox", blueBox, mbPanel, "InputBoxTemplate")
	blueBox:SetWidth(30)
	blueBox:SetHeight(30)
	blueBox:SetPoint("LEFT", greenBox, "RIGHT", 10, 0)
	blueBox:SetMaxLetters(4)
	blueBox:SetHyperlinksEnabled(false)
	blueBox:SetText(blueValue)
	blueBox:SetAutoFocus(false)
	blueBox:SetCursorPosition(0)

	alphaBox = CreateFrame("EditBox", alphaBox, mbPanel, "InputBoxTemplate")
	alphaBox:SetWidth(30)
	alphaBox:SetHeight(30)
	alphaBox:SetPoint("LEFT", blueBox, "RIGHT", 10, 0)
	alphaBox:SetMaxLetters(4)
	alphaBox:SetHyperlinksEnabled(false)
	alphaBox:SetText(alphaValue)
	alphaBox:SetAutoFocus(false)
	alphaBox:SetCursorPosition(0)

	------------------------------
	-- Text box for button size --
	------------------------------
	local buttonSize = addon:getSV("buttonSettings", "size") or 26
	buttonSizeBox = CreateFrame("EditBox", buttonSizeBox, mbPanel, "InputBoxTemplate")
	buttonSizeBox:SetWidth(30)
	buttonSizeBox:SetHeight(30)
	buttonSizeBox:SetPoint("TOPLEFT", colorbox, "BOTTOMLEFT", 0, -40)
	buttonSizeBox:SetMaxLetters(4)
	buttonSizeBox:SetHyperlinksEnabled(false)
	buttonSizeBox:SetText(buttonSize)
	buttonSizeBox:SetAutoFocus(false)
	buttonSizeBox:SetCursorPosition(0)

	buttonSizeBox.Label = colorbox:CreateFontString(nil, 'ARTWORK', 'GameFontWhiteSmall')
	buttonSizeBox.Label:SetPoint("BOTTOMLEFT", buttonSizeBox, "TOPLEFT", -10, 1)
	buttonSizeBox.Label:SetText("按钮大小:")

	---------------------------------
	-- Text box for button padding --
	---------------------------------
	local paddingSize = addon:getSV("buttonSettings", "padding") or 5
	buttonPaddingBox = CreateFrame("EditBox", buttonPaddingBox, mbPanel, "InputBoxTemplate")
	buttonPaddingBox:SetWidth(30)
	buttonPaddingBox:SetHeight(30)
	buttonPaddingBox:SetPoint("TOPLEFT", colorbox, "BOTTOMLEFT", 0, -100)
	buttonPaddingBox:SetMaxLetters(4)
	buttonPaddingBox:SetHyperlinksEnabled(false)
	buttonPaddingBox:SetText(paddingSize)
	buttonPaddingBox:SetAutoFocus(false)
	buttonPaddingBox:SetCursorPosition(0)

	buttonPaddingBox.Label = colorbox:CreateFontString(nil, 'ARTWORK', 'GameFontWhiteSmall')
	buttonPaddingBox.Label:SetPoint("BOTTOMLEFT", buttonPaddingBox, "TOPLEFT", -10, 1)
	buttonPaddingBox.Label:SetText("按钮填充:")

	-------------------------------------
	-- Text box for background padding --
	-------------------------------------
	local bgPaddingSize = addon:getSV("buttonSettings", "bgpadding") or 2.5
	bgPaddingBox = CreateFrame("EditBox", bgPaddingBox, mbPanel, "InputBoxTemplate")
	bgPaddingBox:SetWidth(30)
	bgPaddingBox:SetHeight(30)
	bgPaddingBox:SetPoint("TOPLEFT", colorbox, "BOTTOMLEFT", 0, -160)
	bgPaddingBox:SetMaxLetters(4)
	bgPaddingBox:SetHyperlinksEnabled(false)
	bgPaddingBox:SetText(bgPaddingSize)
	bgPaddingBox:SetAutoFocus(false)
	bgPaddingBox:SetCursorPosition(0)

	bgPaddingBox.Label = colorbox:CreateFontString(nil, 'ARTWORK', 'GameFontWhiteSmall')
	bgPaddingBox.Label:SetPoint("BOTTOMLEFT", bgPaddingBox, "TOPLEFT", -10, 1)
	bgPaddingBox.Label:SetText("背景框架填充:")


end

--------------------------------------------------
--- Save items when the Okay button is pressed ---
--------------------------------------------------
mbPanel.okay = function ()
	local bgColorTbl = { red = redBox:GetText(),
						 blue = blueBox:GetText(),
						 green = greenBox:GetText(),
						 alpha = alphaBox:GetText(),
					}

	local buttonSettingsTbl = { size = buttonSizeBox:GetText(),
								padding = buttonPaddingBox:GetText(),
								bgpadding = bgPaddingBox:GetText() }

	MageButtonsDB["buttons"] = btnTbl
	MageButtonsDB["growth"] = directionTbl
	MageButtonsDB["bgcolor"] = bgColorTbl
	MageButtonsDB["buttonSettings"] = buttonSettingsTbl

	growthDir = directionTbl["direction"]
	menuDir = directionTbl["buttons"]
	btnSize = buttonSettingsTbl["size"]
	padding = buttonSettingsTbl["padding"]
	if mbBorderCheck:GetChecked() then border = 1 else border = 0 end
	backdropPadding = buttonSettingsTbl["bgpadding"]
	backdropRed = bgColorTbl["red"]
	backdropGreen = bgColorTbl["green"]
	backdropBlue = bgColorTbl["blue"]
	backdropAlpha = bgColorTbl["alpha"]

	addon:makeBaseButtons()
end

