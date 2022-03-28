-- /***********************************************
--  * Lunar Object Module
--  *********************
--
--  Author	: Moongaze (Twisting Nether)
--  Description	: Handles the creation of frame objects within World of Warcraft. This
--                allows for easy frame and window creation with as little lines of
--                code as possible. Most, if not all, of the settings windows use these.
--
--  ***********************************************/

-- /***********************************************
--  * Module Setup
--  *********************

-- Create our Lunar object if it's not made
if (not Lunar) then
	Lunar = {};
end

-- Add our Object module to Lunar
if (not Lunar.Object) then
	Lunar.Object = {};
end

-- Set our current version for the module (used for version checking later on)
Lunar.Object.version = 1.52;

-- Create our dropdown data if it doesn't exist yet
if (not Lunar.Object.dropdownData) then
	Lunar.Object.dropdownData = {};	
end

-- Create our local dropdown menu info table to be reused multiple times
local dropInfo = {};

-- /***********************************************
--  * Functions
--  *********************

-- /***********************************************
--  * Create
--  * ========================
--  *
--  * Creates a new object with specified information
--  *
--  * Accepts: None
--  * Returns: None
--  *********************
function Lunar.Object:Create(objectType, objectName, objectParent, objectTitle, objectWidth, objectHeight, foregroundR, foregroundG, foregroundB, backgroundR, backgroundG, backgroundB, noAutoClose)

	-- Set our local
	local tempObject;
	
	-- Create the frame specified by objectType

	-- Object type: Window
	if (objectType == "window") then

		tempObject = CreateFrame("Frame", objectName, objectParent, "LunarWindow");

		-- Set the height of the window, if specified
		if (objectHeight) then
			_G[objectName .. "WindowContainer"]:SetHeight(objectHeight - 20);
		end

		-- Set the color of the window's background, if specified
		if ((backgroundR) and (backgroundG) and (backgroundB)) then
			_G[objectName .. "WindowContainer"]:SetBackdropColor(backgroundR, backgroundG, backgroundB, 1.0);
		end

		-- Set the window's title text
		if (objectTitle) then
			_G[objectName .. "Title"]:SetText(objectTitle);
		end

		-- Add the window to the special frames list, so it will auto-close when
		-- the user hits ESC.
		if not noAutoClose then
			table.insert(UISpecialFrames, objectName);
		end

		tempObject:SetMovable(true);
	end

--[[	-- Object type: Check box
	if (objectType == "checkbox") then

		tempObject = CreateFrame("CheckButton", objectName, objectParent, "OptionsCheckButtonTemplate");
		tempObject:SetWidth(21);
		tempObject:SetHeight(21);
		_G[tempObject:GetName() .. "Text"]:SetText(objectTitle);
	end
]]--
	-- Object type: Vertical Tab
	if (objectType == "verticaltab") then

		tempObject = CreateFrame("Frame", objectName, objectParent, "LunarVerticalTab");

		_G[tempObject:GetName() .. "Text"]:SetText(objectTitle);
		tempObject:SetHitRectInsets(0, 0, 4, 5);

--		tempObject:SetID(string.sub(objectName, string.len(objectName)));
	end

	-- Object type: Container
	if (objectType == "container") then

		tempObject = CreateFrame("Frame", objectName, objectParent, "LunarContainerSolid");

		-- Set the height of the container, if specified
		if (objectHeight) then
			tempObject:SetHeight(objectHeight);
		end
	end

	-- Set the width of the object, if specified
	if (objectWidth) then
		tempObject:SetWidth(objectWidth);
	end

	if (objectType == ("window" or "verticaltab" or "container")) then 
		-- Set the color of the object's background, if specified;
		if ((foregroundR) and (foregroundG) and (foregroundB)) then
			tempObject:SetBackdropColor(foregroundR, foregroundG, foregroundB, 1.0);
		end
      end

	-- return the object
	return tempObject
end

function Lunar.Object:CreateCheckbox(xLoc, yLoc, objectText, objectSetting, enabledValue, objectParent, settingUpdateFunction)

	-- Set our local
	local tempObject;

	tempObject = CreateFrame("CheckButton", "LSSettings" .. objectSetting, objectParent, "LunarCheckButton");

	_G[tempObject:GetName() .. "Text"]:SetFont((select(1, GameFontNormal:GetFont())), 10); --Fonts\\FRIZQT__.TTF", 10);
	_G[tempObject:GetName() .. "Text"]:SetJustifyV("Top");
	_G[tempObject:GetName() .. "Text"]:SetJustifyH("Left");
	_G[tempObject:GetName() .. "Text"]:ClearAllPoints();
	_G[tempObject:GetName() .. "Text"]:SetPoint("Topleft", tempObject, "TopRight", 0, -5);

	tempObject:SetWidth(21);
	tempObject:SetHeight(21);
	_G[tempObject:GetName() .. "Text"]:SetText(objectText);

	tempObject:SetPoint("Topleft", xLoc, yLoc);

	if (LunarSphereSettings[objectSetting] == enabledValue) then
		tempObject:SetChecked(true);
	else
		tempObject:SetChecked(false);
	end

	if (settingUpdateFunction) then
		tempObject:SetScript("OnClick", settingUpdateFunction);
	else
		tempObject:SetScript("OnClick", Lunar.Object.SetSetting);
--[[		tempObject:SetScript("OnClick",
		function ()
			LunarSphereSettings[objectSetting] = (self:GetChecked() == true)
			Lunar.Object.SetSetting();
		end);
--]]	end

	-- return the object
	return tempObject
end

function Lunar.Object:CreateRadio(xLoc, yLoc, objectText, objectSetting, ID, objectParent, settingUpdateFunction)

	-- Set our local
	local tempObject;

	tempObject = CreateFrame("CheckButton", "LSSettings" .. objectSetting .. ID, objectParent, "UIRadioButtonTemplate");

	tempObject:SetWidth(16);
	tempObject:SetHeight(16);
	tempObject:SetHitRectInsets(0, -100, 0, 0);
	_G[tempObject:GetName() .. "Text"]:SetText(objectText);

	tempObject:SetPoint("Topleft", xLoc, yLoc);
	if (LunarSphereSettings[objectSetting] == ID) then
		tempObject:SetChecked(true);
	end
	tempObject:SetID(ID);

	if (settingUpdateFunction) then
		tempObject:SetScript("OnClick", settingUpdateFunction);
	else
		tempObject:SetScript("OnClick", Lunar.Object.SetRadioSetting);
	end

	-- return the object
	return tempObject
end

function Lunar.Object:CreateColorSelector(xLoc, yLoc, objectText, objectSetting, objectParent, colorChangeFunction, hasAlpha)

	-- Set our local
	local tempObject;

	tempObject = CreateFrame("Button", "LSSettings" .. objectSetting, objectParent, "LunarColorSelector");

	tempObject:EnableMouse(true);
	_G[tempObject:GetName() .. "Text"]:SetText(objectText);

	tempObject:GetHighlightTexture():ClearAllPoints();
	tempObject:GetHighlightTexture():SetWidth(20);
	tempObject:GetHighlightTexture():SetHeight(20);
	tempObject:GetHighlightTexture():SetPoint("CENTER");

	tempObject:SetPoint("Topleft", xLoc, yLoc);
	if (not LunarSphereSettings[objectSetting]) then
		LunarSphereSettings[objectSetting] = {1.0, 1.0, 1.0};
		if (hasAlpha) then
			LunarSphereSettings[objectSetting][4] = 1.0;
		end
	end

	_G[tempObject:GetName() .. "Color"]:SetColorTexture(
		LunarSphereSettings[objectSetting][1],
		LunarSphereSettings[objectSetting][2],
		LunarSphereSettings[objectSetting][3]);

	tempObject.hasAlpha = hasAlpha;

	tempObject:SetScript("OnMouseUp", function(self)
		ColorPickerFrame:Hide();

		local colorR, colorG, colorB, colorA = unpack(LunarSphereSettings[objectSetting]);
--			colorR = LunarSphereSettings[objectSetting][1];
--			colorG = LunarSphereSettings[objectSetting][2];
--			colorB = LunarSphereSettings[objectSetting][3];
			
		ColorPickerFrame.opacityFunc = Lunar.API.BlankFunction;
		if (hasAlpha) then
			ColorPickerFrame.opacityFunc =
			function ()
				LunarSphereSettings[objectSetting][4] = 1 - OpacitySliderFrame:GetValue();
			end
			ColorPickerFrame.opacity = 1 - colorA;
		end

		ColorPickerFrame.func =
		function ()
			local r, g, b = ColorPickerFrame:GetColorRGB();
			LunarSphereSettings[objectSetting][1] = r;
			LunarSphereSettings[objectSetting][2] = g;
			LunarSphereSettings[objectSetting][3] = b;
			colorChangeFunction();
			_G[tempObject:GetName() .. "Color"]:SetColorTexture(r, g, b);
		end

		ColorPickerFrame.hasOpacity = self.hasAlpha; --false;
		ColorPickerFrame:SetColorRGB(colorR, colorG, colorB);
		ColorPickerFrame.previousValues = {r = colorR, g = colorG, b = colorB, opacity = colorA}; --nil};
		ColorPickerFrame.cancelFunc =
		function(self)
			LunarSphereSettings[objectSetting][1] = ColorPickerFrame.previousValues.r;
			LunarSphereSettings[objectSetting][2] = ColorPickerFrame.previousValues.g;
			LunarSphereSettings[objectSetting][3] = ColorPickerFrame.previousValues.b;
			if (self.hasAlpha) then
				LunarSphereSettings[objectSetting][4] = ColorPickerFrame.previousValues.opacity;
			end
			colorChangeFunction();
			_G[tempObject:GetName() .. "Color"]:SetColorTexture(
				LunarSphereSettings[objectSetting][1],
				LunarSphereSettings[objectSetting][2],
				LunarSphereSettings[objectSetting][3]);
		end;

		ShowUIPanel(ColorPickerFrame);	
	end);
		
	-- return the object
	return tempObject
end

function Lunar.Object:CreateButton(xLoc, yLoc, objectWidth, objectName, objectText, objectParent, clickFunction)

	-- Set our local
	local tempObject;

	tempObject = CreateFrame("Button", "LSSettings" .. objectName, objectParent, "OptionsButtonTemplate")

	tempObject:SetPoint("Topleft", xLoc, yLoc);
	tempObject:SetText(objectText);
	tempObject:SetWidth(objectWidth);
	tempObject:SetScript("OnClick", clickFunction);

	return tempObject;
end

function Lunar.Object:CreateImage(xLoc, yLoc, objectWidth, objectHeight, objectName, objectParent, imagePath)

	-- Set our local
	local tempObject;

	-- Parse the image page for the "$addon" string and replace it with the addon's path
	imagePath = string.gsub(imagePath, "$addon", LUNAR_ADDON_PATH);

	tempObject = CreateFrame("Button", "LSSettings" .. objectName, objectParent, "ActionButtonTemplate")
	tempObject:SetPoint("Topleft", xLoc, yLoc);
	tempObject:SetWidth(objectWidth);
	tempObject:SetHeight(objectHeight);
	tempObject:EnableMouse(false);
	tempObject:SetNormalTexture(imagePath)
	local t = tempObject:GetNormalTexture()
	t:SetSize(tempObject:GetSize())
	return tempObject;
end

function Lunar.Object:CreateIconPlaceholder(xLoc, yLoc, objectName, objectParent, acceptAssignment)

	-- Set our local
	local tempObject;

	tempObject = CreateFrame("Button", "LSSettings" .. objectName, objectParent, "ActionButtonTemplate")

	tempObject:SetPoint("Topleft", xLoc, yLoc);
	tempObject:SetWidth(32);
	tempObject:SetHeight(32);
	tempObject:GetNormalTexture():ClearAllPoints();
	tempObject:GetNormalTexture():SetPoint("Center");
	tempObject:GetNormalTexture():SetWidth(54);
	tempObject:GetNormalTexture():SetHeight(54);
	tempObject:EnableMouse(false);

	if (acceptAssignment) then
		tempObject:EnableMouse(true);
		tempObject:RegisterForClicks("AnyUp")
		tempObject:RegisterForDrag("LeftButton", "MiddleButton", "RightButton", "Button4", "Button5")
		tempObject:SetScript("OnClick", Lunar.Object.IconPlaceHolder_OnClick)
		tempObject:SetScript("OnReceiveDrag", Lunar.Object.IconPlaceHolder_OnClick);
	end

	return tempObject;
end

function Lunar.Object.EditBox_OnEnterPressed(self)
	local parent = self:GetParent();
	parent:SetValue(tonumber(self:GetText()) or 0);
end

function Lunar.Object:CreateSlider(xLoc, yLoc, objectText, objectSetting, objectParent, minValue, maxValue, valueStep, updateFunction, useTextBox)

	-- Set our local
	local tempObject;

	if (useTextBox == true) then
		tempObject = CreateFrame("Slider", "LSSettings" .. objectSetting, objectParent, "LunarHorizontalSliderWithTextbox");

		tempObject.hasTextBox = true;
		_G[tempObject:GetName() .. "Value"]:SetScript("OnEnterPressed", Lunar.Object.EditBox_OnEnterPressed);
--		_G[tempObject:GetName() .. "Value"]:SetNumeric(true);
		_G[tempObject:GetName() .. "Value"]:SetScript("OnEditFocusLost", Lunar.Object.EditBox_OnEnterPressed);
	else
		tempObject = CreateFrame("Slider", "LSSettings" .. objectSetting, objectParent, "LunarHorizontalSlider");
	end
--	tempObject:SetWidth(21);
--	tempObject:SetHeight(21);

	_G[tempObject:GetName() .. "Thumb"]:Show();
	_G[tempObject:GetName() .. "Text"]:SetFont((select(1, GameFontNormal:GetFont())), 10); --Fonts\\FRIZQT__.TTF", 10);
	_G[tempObject:GetName() .. "Text"]:SetText(objectText);
	_G[tempObject:GetName() .. "Text"]:SetVertexColor(NORMAL_FONT_COLOR.r , NORMAL_FONT_COLOR.g , NORMAL_FONT_COLOR.b);
	_G[tempObject:GetName() .. "Low"]:SetText(""); --minValue);
	_G[tempObject:GetName() .. "Low"]:SetVertexColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	_G[tempObject:GetName() .. "High"]:SetText(""); --maxValue);
	_G[tempObject:GetName() .. "High"]:SetVertexColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);

	if (useTextBox == true) then
		_G[tempObject:GetName() .. "Value"]:SetTextColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	else
		_G[tempObject:GetName() .. "Value"]:SetVertexColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	end

	tempObject:SetHitRectInsets(0, 0, 0, 0);

	tempObject:SetMinMaxValues(minValue, maxValue);
	tempObject:SetValueStep(valueStep);

	if (LunarSphereSettings[objectSetting]) then
		if (useTextBox == true) then
			_G[tempObject:GetName() .. "Value"]:SetText(tostring(floor((LunarSphereSettings[objectSetting] * 100) + 0.5) / 100));
		else
 			_G[tempObject:GetName() .. "Value"]:SetText(": " .. tostring(floor((LunarSphereSettings[objectSetting] * 100) + 0.5) / 100));
		end
		tempObject:SetValue(LunarSphereSettings[objectSetting]);
	else
		tempObject:SetValue(minValue);
		if (useTextBox == true) then
			_G[tempObject:GetName() .. "Value"]:SetText(tostring(floor((tempObject:GetValue() * 100) + 0.5) / 100));
		else
			_G[tempObject:GetName() .. "Value"]:SetText(": " .. tostring(floor((tempObject:GetValue() * 100) + 0.5) / 100));
		end
	end

	tempObject.updateFunction = updateFunction;

	tempObject:SetPoint("Topleft", xLoc, yLoc);
	tempObject:SetScript("OnValueChanged", Lunar.Object.Slider_OnValueChanged);
--[[	tempObject:SetScript("OnValueChanged", 
	function (self)
		if (LunarSphereSettings[self.objectSetting]) then
			LunarSphereSettings[self.objectSetting] = self:GetValue();
			_G[self:GetName() .. "Value"]:SetText(": " .. tostring(floor((LunarSphereSettings[self.objectSetting] * 100) + 0.5) / 100));
		else
			_G[self:GetName() .. "Value"]:SetText(": " .. tostring(floor((self:GetValue() * 100) + 0.5) / 100));
		end
		self.updateFunction(self);
	end);
--]]	
	-- return the object
	return tempObject
end

function Lunar.Object:CreateCaption(xLoc, yLoc, width, height, objectText, objectName, objectParent, small)

	-- Set our local
	local tempObject;

	if (not small) then
		tempObject = CreateFrame("Frame", "LSSettings" .. objectName, objectParent, "LunarCaption");
	else
		tempObject = CreateFrame("Frame", "LSSettings" .. objectName, objectParent, "LunarCaptionSmall");
	end

	tempObject:SetWidth(width);
	tempObject:SetHeight(height);

	_G[tempObject:GetName() .. "Text"]:SetText(objectText);

	tempObject:SetPoint("Topleft", xLoc, yLoc);
	
	-- return the object
	return tempObject
end

function Lunar.Object:CreateDropdown(xLoc, yLoc, width, objectName, objectText, listName, objectSetting, objectParent, updateFunction, extraFeature)

	-- Set our local
	local tempObject;

	tempObject = CreateFrame("Frame", "LSSettings" .. objectName, objectParent, "LunarDropDown");

	tempObject.lunarMenu = true;
--	tempObject.displayMode = "MENU"

	-- Make sure the left and right side don't mess with buttons around it
	tempObject:SetHitRectInsets(10, 10, 0, 0);

	_G[tempObject:GetName() .. "Label"]:SetText(objectText);
	tempObject:SetPoint("Topleft", xLoc, yLoc);
	tempObject:SetScript("OnLoad", 
	function(self)
		Lunar.Object:Dropdown_OnLoad(self, tempObject, width, listName, objectSetting, updateFunction, extraFeature);
	end);
	tempObject:SetScript("OnShow", 
	function(self)
		Lunar.Object.scaleDropdown = true;
		Lunar.Object.Dropdown_OnLoad(self, tempObject, width, listName, objectSetting, updateFunction, extraFeature);
	end);

	-- return the object
	return tempObject
end

function Lunar.Object.Dropdown_OnLoad(self, dropdownObject, width, listName, modifySetting, updateFunction, extraFeature)
	UIDropDownMenu_Initialize(self, function(self) Lunar.Object.DropdownInitialize(self, dropdownObject, listName, modifySetting, updateFunction) end);

	if (listName == "Speech_Database") then
		UIDropDownMenu_SetSelectedName(dropdownObject, Lunar.Speech:GetScriptName(1));
	else

		for i = 1, table.getn(Lunar.Object.dropdownData[listName]) do 
			if (extraFeature == true) then
--				UIDropDownMenu_SetSelectedName(dropdownObject, Lunar.Object.dropdownData[listName][1][1]);
				break;
			else
				if (Lunar.Object.dropdownData[listName][i][2] == LunarSphereSettings[modifySetting]) then
					UIDropDownMenu_SetSelectedName(dropdownObject, Lunar.Object.dropdownData[listName][i][1]);
					break;
				end
			end
		end
	end

	UIDropDownMenu_SetWidth(self, width);
end

function Lunar.Object.DropdownInitialize(self, dropdownObject, listName, modifySetting, updateFunction)

	if (UIDROPDOWNMENU_MENU_LEVEL == 1) then

		if (listName == "Speech_Database") then
			for i = 1, table.getn(LunarSpeechLibrary.script) do

				-- Wipe our information table
				Lunar.Object:WipeDropInfo();

				if not (LunarSpeechLibrary.script[i].speeches) then
					dropInfo.textR = 0.2
					dropInfo.textG = 0.6
					dropInfo.textB = 1.0
				end

				dropInfo.text = Lunar.Speech:GetScriptName(i);
				dropInfo.value = i;
				dropInfo.hasArrow = nil;
				dropInfo.checked = nil;
				dropInfo.func = 
				function (self)
					UIDropDownMenu_SetText(dropdownObject, self:GetText(), dropdownObject);
					UIDropDownMenu_SetSelectedName(dropdownObject, self:GetText());
					dropdownObject.selectedValue = self.value;
					_G["LSSettingsglobalScript"]:SetChecked(false);
					Lunar.Settings:UpdateSpeechList();
					Lunar.Settings:ResetSpeechObjects();
					if not (LunarSpeechLibrary.script[self.value].speeches) then
						_G["LSSettingsglobalScript"]:SetChecked(true);
					end
				end;
				UIDropDownMenu_AddButton(dropInfo);
			end	
		else
			for i = 1, table.getn(Lunar.Object.dropdownData[listName]) do

				-- Wipe our information table
				Lunar.Object:WipeDropInfo();
				dropInfo.text = Lunar.Object.dropdownData[listName][i][1];
				dropInfo.value = Lunar.Object.dropdownData[listName][i][2];

				-- If we have a 3rd entry in the dropdownData table, that means we have a submenu and we
				-- need to make sure we can access that menu
				dropInfo.hasArrow = nil;
				if (Lunar.Object.dropdownData[listName][i][3]) then
					dropInfo.hasArrow = 1;
					dropInfo.notCheckable = 1;
					dropInfo.value = i;
				end
				dropInfo.checked = nil;
				dropInfo.func = 
				function(self)

				if (listName == "Button_Type") then
						local clickType;
						-- 3.0.8 fix
						if (type(UIDROPDOWNMENU_OPEN_MENU) == "table") then
							clickType = tonumber(string.match(UIDROPDOWNMENU_OPEN_MENU:GetName(), "%d"));
						else
							-- Croq update 1.3
							clickType = tonumber(string.match(dropdownObject:GetName(), "%d"));
						end

						if (string.find(dropdownObject:GetName(), "LSSettingsbuttonType")) then
							Lunar.Settings["updateNeeded" .. Lunar.Button.currentStance .. clickType] = true;
						end

						-- Hacked code to make sure we clear the menu icon if we select something else
						-- from the button type dropdown
						if (UIDropDownMenu_GetSelectedName(dropdownObject) == Lunar.Locale["BUTTON_MENU"]) then
							if (self:GetText() ~= Lunar.Locale["BUTTON_MENU"]) then
								_G["LSSettingsbuttonAction" .. clickType .. "Icon"]:SetTexture("");
	--							Lunar.Button:SetButtonType(Lunar.Settings.buttonEdit, Lunar.Button.currentStance, clickType, 2, true);
							end
						end

						if (not Lunar.Object.dropdownData[listName][i][3]) then
							local oldValue = dropdownObject.selectedValue;
							UIDropDownMenu_SetText(dropdownObject, self:GetText(), dropdownObject);
--							UIDropDownMenu_SetSelectedName(dropdownObject, self:GetText());
							dropdownObject.selectedValue = self.value;

							if (listName == "Button_Type") then
								if (Lunar.Button.currentStance == Lunar.Button.defaultStance) then
									if (self.value == 2) then
										Lunar.Settings["menuLock" .. clickType] = true;
									else
										Lunar.Settings["menuLock" .. clickType] = nil;
									end
								end	
								if (self.value < 2) and (oldValue ~= 5) and (oldValue ~= 6) and (oldValue ~= 7) then
									_G["LSSettingsbuttonAction" .. clickType .. "Icon"]:SetTexture("");
									Lunar.Button:SetButtonType(Lunar.Settings.buttonEdit, Lunar.Button.currentStance, clickType, self.value, true);
								else
									if (self.value == 3) or (self.value == 4)  then
										_G["LSSettingsbuttonAction" .. clickType .. "Icon"]:SetTexture("");
									end	
									Lunar.Button:SetButtonType(Lunar.Settings.buttonEdit, Lunar.Button.currentStance, clickType, self.value, true);
								end
										
							end
						else
							UIDropDownMenu_SetSelectedName(dropdownObject, Lunar.Locale[Lunar.Object.dropdownData[listName][i][3] .. "1"]);	
							dropdownObject.selectedValue = Lunar.Object.dropdownData[listName][i][2];
							local buttonType = dropdownObject.selectedValue;
							local objectName, objectTexture;
							
							if (buttonType >= 10) and (buttonType < 90) or ((buttonType >= 110) and (buttonType <= 111)) then

								if (buttonType < 90) then
									if (buttonType >= 50) and (buttonType < 60)  then
										local subType;
										if (buttonType < 52) then
											subType = buttonType - 50 + 2;
										elseif (buttonType < 54) then
											subType = 4;
										elseif (buttonType < 56) then
											subType = 5;
										elseif (buttonType < 58) then
											subType = 0;
										else
											subType = 1;
										end	
										objectName = Lunar.Items:GetItem(Lunar.Items:GetCatagoryName(math.floor(buttonType / 10)), subType);
									else
										objectName = Lunar.Items:GetItem(Lunar.Items:GetCatagoryName(math.floor(buttonType / 10)), math.fmod(buttonType, 10));
									end
								else
									if (buttonType == 132) then
										objectName = Lunar.Items:GetItem("companion", 1, true);
									else
										objectName = Lunar.Items:GetItem(Lunar.Items:GetCatagoryName(buttonType - 109), 3, true);
									end
								end

	--							objectName = Lunar.Items:GetItem(Lunar.Items:GetCatagoryName(math.floor(buttonType / 10)), math.fmod(buttonType, 10));

	--							-- Grab our weakest item
	--							if (math.fmod(buttonType, 10) == 0) then
	--								objectName = Lunar.Items:GetItem(Lunar.Items:GetCatagoryName(math.floor(buttonType / 10)), true);
	--
	--							-- Or grab our strongest
	--							elseif (math.fmod(buttonType, 10) == 1) then
	--								objectName = Lunar.Items:GetItem(Lunar.Items:GetCatagoryName(math.floor(buttonType / 10)));
	--							end

								-- grab the texture, if the object exists
								objectTexture = "";
								if (objectName) then
									if (buttonType >= 80) and (buttonType < 90) then
										objectTexture = select(3, GetSpellInfo(string.sub(objectName, 3)));
									else
										_,_,_,_,_,_,_,_,_,objectTexture = GetItemInfo(objectName);
									end
								end

								_G["LSSettingsbuttonAction" .. clickType .. "Icon"]:SetTexture(objectTexture);
							end

							-- buttonType 80-89 == mount

							if (buttonType >= 90) and (buttonType < 100)  then
								objectTexture = Lunar.Button:GetBagTexture(buttonType);
 								_G["LSSettingsbuttonAction" .. clickType .. "Icon"]:SetTexture(objectTexture);
							end

							if (buttonType >= 100) and (buttonType < 110)  then
								if (buttonType == 100) then
									objectTexture = "portrait";
									SetPortraitTexture(_G["LSSettingsbuttonAction" .. clickType .. "Icon"], "player");
								else
									objectTexture = Lunar.Button.texturePath[buttonType - 100];
									if (buttonType == 109 ) and (UnitFactionGroup("player") == "Alliance")  then
										objectTexture = LUNAR_ART_PATH .. "menuPVP2.blp";
									end
									_G["LSSettingsbuttonAction" .. clickType .. "Icon"]:SetTexture(objectTexture);
								end
							end

							-- buttonType 110-119 = trade
							-- buttonType 120-129 = apply to weapon

							if (buttonType >= 130) and (buttonType < 131)  then
								objectTexture = GetInventoryItemTexture("player", buttonType - 117) or ("Interface\\Icons\\INV_Misc_QuestionMark");
								_G["LSSettingsbuttonAction" .. clickType .. "Icon"]:SetTexture(objectTexture);
							end

-- This is just a submenu option, not a main option
--							if (buttonType == 132) then
--								if (objectName) then
--									objectTexture = select(3, GetSpellInfo(string.sub(3, objectName)));
--								end
--							end

							-- Pet action buttons
							if (buttonType >= 140) and (buttonType < 150)  then
								local _, _, texture, isToken = GetPetActionInfo(buttonType - 139);
								if ( not isToken ) then
									objectTexture = texture;
								else
									objectTexture = _G[texture];
								end
								_G["LSSettingsbuttonAction" .. clickType .. "Icon"]:SetTexture(objectTexture);
							end

							Lunar.Button:SetButtonData(Lunar.Settings.buttonEdit, Lunar.Button.currentStance, clickType, buttonType, nil, nil, objectTexture, true);

						end

					elseif (listName == "Gauge_Events") then 
						local db = Lunar.Object.dropdownData[listName][self.value]
						local eventID = self.value;
						local text;
						if (db) then
							if (db[3]) then
								eventID = db[2];
								text = Lunar.Locale[Lunar.Object.dropdownData[listName][i][3] .. "1"];	
							end
						end
						if not (text) then
							text = Lunar.Object.dropdownData[listName][i][1];
						end
						UIDropDownMenu_SetSelectedValue(dropdownObject, eventID);
						_G[dropdownObject:GetName() .. "Text"]:SetText(text);
						Lunar.Sphere:SetGaugeType(_G["LSSettingsgaugeName"].currentGauge, eventID);
					else
--						UIDropDownMenu_SetSelectedName(dropdownObject, self:GetText());
						UIDropDownMenu_SetText(dropdownObject, self:GetText(), dropdownObject);
						UIDropDownMenu_SetSelectedName(dropdownObject, self:GetText());
						dropdownObject.selectedValue = self.value;
					end
							

					if (updateFunction) then
						updateFunction(self);
					end

				end

--				if not (Lunar.Settings.buttonEdit) then
--					Lunar.Settings.buttonEdit = -1;
--				end

				-- Hacked code to make sure we don't show the "menu" option on child buttons
				if (not ((listName == "Button_Type") and ((Lunar.Settings.buttonEdit > 10) or (Lunar.Settings.buttonEdit == 0)) and ((i == 5) or (i == 6) or (i == 7) )))  then

					-- Next, hacked code to make sure we can't assign menus on anything other than stance 0
					if (Lunar.Button.currentStance) and (Lunar.Settings.buttonEdit) then
						if not ((Lunar.Button.currentStance > Lunar.Button.defaultStance) and (Lunar.Settings.buttonEdit <= 10) and (i == 5) ) then
							UIDropDownMenu_AddButton(dropInfo);
						end
					else
						UIDropDownMenu_AddButton(dropInfo);
					end
				end
				
--				if (Lunar.Settings.buttonEdit == -1) then
--					Lunar.Settings.buttonEdit = nil;
--				end
			end
		end
	else
		i = 1;
		while (Lunar.Locale[Lunar.Object.dropdownData[listName][UIDROPDOWNMENU_MENU_VALUE][3] .. tostring(i)]) do 

			local clickType;
			-- 3.0.8 fix
			if (type(UIDROPDOWNMENU_OPEN_MENU) == "table") then
				clickType = tonumber(string.match(UIDROPDOWNMENU_OPEN_MENU:GetName(), "%d"));
			else
				clickType = tonumber(string.match(UIDROPDOWNMENU_OPEN_MENU, "%d"));
			end

			if (string.find(dropdownObject:GetName(), "LSSettingsbuttonType")) then
				Lunar.Settings["updateNeeded" .. Lunar.Button.currentStance .. clickType] = true;
			end

			-- Wipe our information table
			Lunar.Object:WipeDropInfo();
			dropInfo.text = Lunar.Locale[Lunar.Object.dropdownData[listName][UIDROPDOWNMENU_MENU_VALUE][3] .. tostring(i)]
			dropInfo.value = Lunar.Object.dropdownData[listName][UIDROPDOWNMENU_MENU_VALUE][2] + i - 1;

			dropInfo.checked = nil;
			dropInfo.func = Lunar.Object.SubmenuFunction
			dropInfo.arg1 = listName;
			UIDropDownMenu_AddButton(dropInfo, UIDROPDOWNMENU_MENU_LEVEL);

			i = i + 1;
		end
	end
end

function Lunar.Object:SubmenuFunction(listName, updateFunction)

	-- 3.0.8 fix
	if (type(UIDROPDOWNMENU_OPEN_MENU) == "table") then
		UIDropDownMenu_SetSelectedName(UIDROPDOWNMENU_OPEN_MENU, self:GetText());
		UIDROPDOWNMENU_OPEN_MENU.selectedValue = self.value;
	else
		UIDropDownMenu_SetSelectedName(_G[UIDROPDOWNMENU_OPEN_MENU], self:GetText());
		_G[UIDROPDOWNMENU_OPEN_MENU].selectedValue = self.value;
	end

	listName = listName or self.arg1; 

	if (listName == "Button_Type") then

		local buttonType = self.value;
		local clickType;
		local objectTexture;

		-- 3.0.8 fix
		if (type(UIDROPDOWNMENU_OPEN_MENU) == "table") then
			clickType = tonumber(string.match(UIDROPDOWNMENU_OPEN_MENU:GetName(), "%d"));
		else
			clickType = tonumber(string.match(UIDROPDOWNMENU_OPEN_MENU, "%d"));
		end

		-- Auto assign item or trade item...
		if (buttonType >= 10) and (buttonType < 90) or ((buttonType >= 110) and (buttonType <= 111))  then

			if (buttonType < 90) then
				if (buttonType >= 50) and (buttonType < 60)  then
					local subType;
					if (buttonType < 52) then
						subType = buttonType - 50 + 2;
					elseif (buttonType < 54) then
						subType = 4;
					elseif (buttonType < 56) then
						subType = 5;
					elseif (buttonType < 58) then
						subType = 0;
					else
						subType = 1;
					end	
					objectName = Lunar.Items:GetItem(Lunar.Items:GetCatagoryName(math.floor(buttonType / 10)), subType);
				else
					objectName = Lunar.Items:GetItem(Lunar.Items:GetCatagoryName(math.floor(buttonType / 10)), math.fmod(buttonType, 10));
				end
			else
--				if (buttonType == 132) then
--					objectName = Lunar.Items:GetItem("companion", 1, true);
--				else
					objectName = Lunar.Items:GetItem(Lunar.Items:GetCatagoryName(buttonType - 109), 3, true);
--				end
			end

	--		objectName = Lunar.Items:GetItem(Lunar.Items:GetCatagoryName(math.floor(buttonType / 10)), math.fmod(buttonType, 10));
			
	--		-- Grab our weakest item
	--		if (math.fmod(buttonType, 10) == 0) then
	--			objectName = Lunar.Items:GetItem(Lunar.Items:GetCatagoryName(math.floor(buttonType / 10)), true);
	--
	--		-- Or grab our strongest
	--		elseif (math.fmod(buttonType, 10) == 1) then
	--			objectName = Lunar.Items:GetItem(Lunar.Items:GetCatagoryName(math.floor(buttonType / 10)));
	--		end

			-- grab the texture, if the object exists
			objectTexture = "";
			if (objectName) then
				if (buttonType >= 80) and (buttonType < 90) then
					objectTexture = select(3, GetSpellInfo(string.sub(objectName, 3)));
				else
					_,_,_,_,_,_,_,_,_,objectTexture = GetItemInfo(objectName);
				end
			end

			_G["LSSettingsbuttonAction" .. clickType .. "Icon"]:SetTexture(objectTexture);

		end

		-- buttonType 80-89 == mount

		if (buttonType >= 90) and (buttonType < 100)  then
			objectTexture = Lunar.Button:GetBagTexture(buttonType);
			_G["LSSettingsbuttonAction" .. clickType .. "Icon"]:SetTexture(objectTexture);
		end

		if (buttonType >= 100) and (buttonType < 110)  then
			if (buttonType == 100) then
				objectTexture = "portrait"
				SetPortraitTexture(_G["LSSettingsbuttonAction" .. clickType .. "Icon"], "player");
			else
				objectTexture = Lunar.Button.texturePath[buttonType - 100]
				if (buttonType == 109 ) and (UnitFactionGroup("player") == "Alliance")  then
					objectTexture = LUNAR_ART_PATH .. "menuPVP2.blp";
				end
				_G["LSSettingsbuttonAction" .. clickType .. "Icon"]:SetTexture(objectTexture);
			end
		end

		-- buttonType 110-119 = trade
		-- buttonType 120-129 = apply to weapon

		if (buttonType == 130) or (buttonType == 131) then
			objectTexture = GetInventoryItemTexture("player", buttonType - 117) or ("Interface\\Icons\\INV_Misc_QuestionMark");
			_G["LSSettingsbuttonAction" .. clickType .. "Icon"]:SetTexture(objectTexture);
		end

		if (buttonType == 132) then
			objectTexture = "Interface\\Icons\\Ability_Hunter_BeastCall";
			_G["LSSettingsbuttonAction" .. clickType .. "Icon"]:SetTexture(objectTexture);
		end

		-- Pet action buttons
		if (buttonType >= 140) and (buttonType < 150)  then
			local _, _, texture, isToken = GetPetActionInfo(buttonType - 139);
			if ( not isToken ) then
				objectTexture = texture;
			else
				objectTexture = _G[texture];
			end
			_G["LSSettingsbuttonAction" .. clickType .. "Icon"]:SetTexture(objectTexture);
		end

		Lunar.Button:SetButtonData(Lunar.Settings.buttonEdit, Lunar.Button.currentStance, clickType, buttonType, nil, nil, objectTexture, true);

	elseif (listName == "Gauge_Events") then
		Lunar.Sphere:SetGaugeType(_G["LSSettingsgaugeName"].currentGauge, self.value)
	end

	HideDropDownMenu(1);
end

function Lunar.Object:SkinDropDown(level, value, dropDownFrame, anchorName, xOffset, yOffset, menuList)

	local backdrop = _G["DropDownList" .. UIDROPDOWNMENU_MENU_LEVEL .. "Backdrop"];
	-- This is an awful hack, but for the life of me I can't find where this
	-- f*cking global object is being created. This is why we *DO NOT* use
	-- global variables!
	OnLoadCheckMixin(backdrop)
	if not Lunar.Object.dropdownSkin then
		Lunar.Object.dropdownSkinLS = _G["LSSetttingsGaugeOptionsContainer"]:GetBackdrop()
		Lunar.Object.dropdownSkinColor = { backdrop:GetBackdropColor() };
		Lunar.Object.dropdownSkin = backdrop:GetBackdrop()
	end

	local menuObj;
	if (type(UIDROPDOWNMENU_OPEN_MENU) == "table") then
		menuObj = UIDROPDOWNMENU_OPEN_MENU
	elseif (type(UIDROPDOWNMENU_OPEN_MENU) == "string") then
		menuObj = _G[UIDROPDOWNMENU_OPEN_MENU];
	else
		menuObj = nil;
	end

	if (menuObj) then
		if (menuObj.lunarMenu) then
			backdrop:SetBackdrop(Lunar.Object.dropdownSkinLS);
			backdrop:SetBackdropColor(0.2,0.2,0.2,1.0);
			backdrop:SetFrameLevel(0);
		else
			backdrop:SetBackdrop(Lunar.Object.dropdownSkin);
			backdrop:SetBackdropColor(unpack(Lunar.Object.dropdownSkinColor));
		end
	end
end

function Lunar.Object.SetSetting(self)
	LunarSphereSettings[string.match(self:GetName(), "LSSettings(.*)")] = (self:GetChecked() == true)
end

function Lunar.Object.SetRadioSetting(self)
	local i = 0;
	local settingName = string.match(self:GetName(), "LSSettings(.*)(%d)");
	object = _G["LSSettings" .. settingName .. "0"];
	while (object) do 
		i = i + 1;
		object:SetChecked(false);
		object = _G["LSSettings" .. settingName .. i];
	end
	self:SetChecked(true);
	LunarSphereSettings[settingName] = self:GetID();
end

function Lunar.Object:WipeDropInfo()
	for i, v in pairs(dropInfo) do
		dropInfo[i] = nil;
	end
end

function Lunar.Object.Slider_OnValueChanged(self)
	local objectSetting = string.match(self:GetName(), "LSSettings(.*)");
	if (LunarSphereSettings[objectSetting]) then
		LunarSphereSettings[objectSetting] = self:GetValue();
		if (self.hasTextBox == true) then
			_G[self:GetName() .. "Value"]:SetText(tostring(floor((LunarSphereSettings[objectSetting] * 100) + 0.5) / 100));
			if (_G[self:GetName() .. "Value"]:HasFocus()) then
				_G[self:GetName() .. "Value"]:ClearFocus();
			end
		else
			_G[self:GetName() .. "Value"]:SetText(": " .. tostring(floor((LunarSphereSettings[objectSetting] * 100) + 0.5) / 100));
		end
	else
		if (self.hasTextBox == true) then
 			_G[self:GetName() .. "Value"]:SetText(tostring(floor((self:GetValue() * 100) + 0.5) / 100));
			if (_G[self:GetName() .. "Value"]:HasFocus()) then
				_G[self:GetName() .. "Value"]:ClearFocus();
			end
		else
			_G[self:GetName() .. "Value"]:SetText(": " .. tostring(floor((self:GetValue() * 100) + 0.5) / 100));
		end
	end
	self.updateFunction(self);
end

function Lunar.Object.IconPlaceHolder_OnClick(self)
	if (IsControlKeyDown() or GetCursorInfo() ) then

		local objectTexture, objectType, actionName, objectName, buttonID, currentStance, updateType, updateID, updateData, useCached;
		local buttonType = 0;
		local clickType = tonumber(string.match(self:GetName(), '%d'));

		objectName = "button"	
		buttonID = Lunar.Settings.buttonEdit;
		currentStance = Lunar.Button.currentStance;
		useCached = true;
				
		local typeName = UIDropDownMenu_GetSelectedName(_G["LSSettings" .. objectName .. "Type" .. clickType]);

		updateType, updateID, updateData, updateTrueSpellID = GetCursorInfo();

		-- NO. No flyouts for you!
		if (updateType == "flyout") then
			ClearCursor();
			return;
		end

--		if (buttonID > 0) then
			Lunar.Settings["updateNeeded" .. currentStance .. clickType] = true;
			Lunar.Settings["updateType" .. clickType], Lunar.Settings["updateID" .. clickType], Lunar.Settings["updateData" .. clickType] = updateType, updateID, updateData;
--		end

		if (typeName == Lunar.Locale["BUTTON_MENU"]) then
			buttonType = 2;
		elseif (typeName == Lunar.Locale["BUTTON_SELFCAST"]) then
			buttonType = 5;
		elseif (typeName == Lunar.Locale["BUTTON_FOCUSCAST"]) then
			buttonType = 6;
		elseif (typeName == Lunar.Locale["BUTTON_WEAPONAPPLY1"]) then
			buttonType = 120;
		elseif (typeName == Lunar.Locale["BUTTON_WEAPONAPPLY2"]) then
			buttonType = 121;
		elseif (typeName == Lunar.Locale["BUTTON_WEAPONAPPLY3"]) then
			buttonType = 122;
		elseif (typeName == Lunar.Locale["BUTTON_INVENTORY4"]) then
			buttonType = 133;
--		elseif (typeName == Lunar.Locale["BUTTON_TRADE1"]) then
--			buttonType = 110;
--		elseif (typeName == Lunar.Locale["BUTTON_TRADE2"]) then
--			buttonType = 111;
		elseif (typeName == Lunar.Locale["BUTTON_TRADE3"]) then
			buttonType = 112;
		else
			buttonType = 1;
		end

		if (updateType == "equipmentset") then
			buttonType = 133;
		end

		if (IsControlKeyDown() and ((not updateType) or (buttonID == 0))) then
			buttonType = 0;
		end

		if (buttonID > 0) and (IsControlKeyDown() and updateType) then
			buttonType = 2;
		end

		local nextSpellName, spellRank, spellName, spellID;

		if (updateType == "spell") then

			_, spellRank = GetSpellBookItemName(updateID, updateData);
--			nextSpellName = GetSpellBookItemName(updateID + 1, updateData);
			spellRank = "(" .. spellRank .. ")";

			--_, spellID = GetSpellBookItemInfo(updateID, updateData);
			actionName = GetSpellBookItemName(updateID, updateData);
			objectTexture = GetSpellTexture(updateID, updateData);
			spellName = GetSpellInfo(updateTrueSpellID);

			-- Fix for Call Pet for hunters.
			if (actionName ~= spellName) then
				actionName = updateTrueSpellID;
			-- Fix for normal sheep polymorph
			elseif (updateTrueSpellID == 118) then
				objectName = updateTrueSpellID;
			else
--				if (actionName ~= nextSpellName) then
--					if (string.find(spellRank, "%d")) then
--						spellRank = "";
--						actionName = Lunar.API:FixFaerie(actionName);
--					end
					if (spellRank == "()") then
						spellRank = "";
						actionName = Lunar.API:FixFaerie(actionName);
					end
--				end
				-- We don't want spell ranks on the first spell tab or professions tab data ... these are generic
				if (updateID <= (select(4, GetSpellTabInfo(1))) or updateID >= (select(3, GetSpellTabInfo(5)))) then
					spellRank = "";
				end
				actionName = actionName .. spellRank;
			end

		elseif (updateType == "battlepet") then

			-- Set the name of the spell and its texture
			updateType = "spell";
--			actionName, objectTexture = select(3, GetCompanionInfo(updateData, updateID));
--			actionName, objectTexture = select(11, C_PetJournal.GetPetInfoByPetID(updateID));
			_, _, _, _, _, _, _, actionName, objectTexture, _, displayID = C_PetJournal.GetPetInfoByPetID(updateID);

		elseif (updateType == "mount") then

			-- Set the name of the spell and its texture
			updateType = "spell";

			actionName, _, objectTexture = C_MountJournal.GetMountInfoByID(updateID)
			displayID, _, _, _, _ = C_MountJournal.GetMountInfoExtraByID(updateID)

		elseif (updateType == "item") then
			actionName, _, _, _, _, objectType, _, _, _, objectTexture = GetItemInfo(updateID);
-- NEW code for item names (item link for weapons/armor, to remember their "of the bear" and other animal
-- modifiers, all other items is JUST the item ID)
			if (objectType == LunarSphereGlobal.searchData.armor) or (objectType == LunarSphereGlobal.searchData.weapon) then
				-- Grab the item link and secure only the parts that we need for the item
				actionName = select(3, string.find(updateData, "^|c%x+|H(.+)|h%[.+%]"));
			else
				actionName = "item:" .. Lunar.API:GetItemID(updateData);
			end
--[[
			actionName = select(3, string.find(updateData, "^|c%x+|H(.+)|h%[.+%]"));
			if IsConsumableItem(actionName) then
				local uniqueID = select(10, string.find(actionName, "^item:(%d+):(%d+):(%d+):(%d+):(%d+):(%d+):(%-?%d+):(%-?%d+)"));
				if (uniqueID) and (uniqueID ~= "0")  then
					actionName = string.gsub(actionName, ":-" .. uniqueID, "");
					actionName = string.gsub(actionName, ":" .. uniqueID, "");
				end
			end
--]]
		elseif (updateType == "macro") then
			actionName, objectTexture = GetMacroInfo(Lunar.Settings["updateID" .. clickType]);
		elseif (updateType == "equipmentset") then
			updateType = "macrotext";
			actionName = "/equipset " .. updateID; -- updateID is actually name
			local setID = C_EquipmentSet.GetEquipmentSetID(updateID)
			objectTexture = select(2, C_EquipmentSet.GetEquipmentSetInfo(setID))
		end

		_G[self:GetName() .. "Icon"]:SetTexture(objectTexture);
		if (buttonType ~= _G["LSSettings" .. objectName .. "Type" .. clickType].selectedValue) then
			if (buttonType == 133) then
				UIDropDownMenu_SetText(_G["LSSettings" .. objectName .. "Type" .. clickType], Lunar.Locale["BUTTON_INVENTORY4"], _G["LSSettings" .. objectName .. "Type" .. clickType]);
--				UIDropDownMenu_SetSelectedName(_G["LSSettings" .. objectName .. "Type" .. clickType], Lunar.Locale["BUTTON_INVENTORY4"]);
			else
				UIDropDownMenu_SetText(_G["LSSettings" .. objectName .. "Type" .. clickType], Lunar.Object.dropdownData["Button_Type"][buttonType + 1][1], _G["LSSettings" .. objectName .. "Type" .. clickType]);
--				UIDropDownMenu_SetSelectedName(_G["LSSettings" .. objectName .. "Type" .. clickType], Lunar.Object.dropdownData["Button_Type"][buttonType + 1][1]);
			end
			_G["LSSettings" .. objectName .. "Type" .. clickType].selectedValue = buttonType;
		end

		Lunar.Button:SetButtonData(buttonID, currentStance, clickType, buttonType, updateType, actionName, objectTexture, useCached); 
	end

	ClearCursor();	
end

function Lunar.Object.SpeechIconPlaceHolder_OnClick(self)

	if GetCursorInfo() then

		Lunar.Settings:ActionList_PrepareAction()

		local scriptID = _G["LSSettingsscriptSelection"].selectedValue or (1)
		if (LunarSpeechLibrary.script[scriptID]) then
			UIDropDownMenu_SetSelectedValue(_G["LSSettingsassignmentSelection"], 1);
			_G["LSSettingsassignmentSelectionText"]:SetText(Lunar.Object.dropdownData["Speech_Assign"][2][1]);
			local objectTexture = string.match(_G["LSSettingsassignmentEditButton"].actionData or (""), ":::(.*)"); 
			_G["LSSettingsassignmentActionIcon"]:SetTexture(objectTexture);
		end
	end
end

function Lunar.Object.SphereActionIconPlaceHolder_OnClick(self)

	if GetCursorInfo() then

		local cursorType, cursorID, cursorData = GetCursorInfo();
		local actionName, objectTexture;

		if (cursorType == "spell") then
			actionName = GetSpellBookItemName(cursorID, cursorData);
			objectTexture = GetSpellTexture(cursorID, cursorData);
		elseif (updateType == "battlepet") then
			-- Set the name of the spell and its texture
			_, _, _, _, _, _, _, actionName, objectTexture, _, displayID = C_PetJournal.GetPetInfoByPetID(updateID);
		elseif (updateType == "mount") then
			-- Set the name of the spell and its texture
			actionName, _, objectTexture = C_MountJournal.GetMountInfo(updateData)
			displayID, _, _, _, _ = C_MountJournal.GetMountInfoExtra(updateData)
		elseif (cursorType == "item") then
			_, actionName, _, _, _, _, _, _, _, objectTexture = GetItemInfo(cursorID);
			actionName = "item:" .. Lunar.API:GetItemID(actionName);
		end

		if (objectTexture) then
			_G["LSSettingssphereActionAssignIcon"]:SetTexture(objectTexture);
		else
			_G["LSSettingssphereActionAssignIcon"]:SetTexture("");
		end

		LunarSphereSettings.sphereAction = actionName;

		local obj = _G["LSmain"];
		if (LunarSphereSettings.sphereTextType == LS_EVENT_SPHERE_COOLDOWN) then
			obj.actionTypeCooldown = nil;
			Lunar.Button.UpdateCooldown(obj);
		else
			obj.actionTypeCount = nil;
			Lunar.Button:UpdateCount(obj);
		end

		ClearCursor();
	end
end