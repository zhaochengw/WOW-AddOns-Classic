-- /***********************************************
--  * Lunar Settings Module
--  *********************
--
--  Author	: Moongaze (Twisting Nether)
--  Description	: Handles the creation of the settings frames and manages all
--                settings as well
--
--  ***********************************************/

-- /***********************************************
--  * Module Setup
--  *********************

-- Create our Lunar object if it's not made
if (not Lunar) then
	Lunar = {};
end

-- Add our Settings module to Lunar
if (not Lunar.Settings) then
	Lunar.Settings = {};
end

-- Set our current version for the module (used for version checking later on)
Lunar.Settings.version = 1.52;

local GetCursorInfo = GetCursorInfo;

-- Set our button ID for editing purposes
Lunar.Settings.buttonEdit = nil;
Lunar.Button.useStances = false; -- Here = nil

-- Set our feature memory sizes for the memory tab
local memorySize = {
	[1] = " |cFF00AAFF[13.6 kb]",
	[2] = " |cFF00AAFF[3.2 kb]",
	[3] = " |cFF00AAFF[5.1 kb]",
	[4] = " |cFF00AAFF[7.9 kb]",
	[5] = " |cFF00AAFF[4.6 kb]",
	[6] = " |cFF00AAFF[58.5 kb]",
	[7] = " |cFF00AAFF[33.6 kb]",
	[8] = " |cFF00AAFF[27.3 kb]",
	[9] = " |cFF00AAFF[15.3 kb]",
	[10] = " |cFF00AAFF[8.8 kb]",
	[11] = " |cFF00AAFF[4.5 kb]",
	[12] = " |cFF00AAFF[1.9 kb]",
};

-- Create our Locale object (to be dumped into it's own file later) and populate
-- the english text
--if (not Lunar.Locale) then
--end

Lunar.Settings.templateList = {};

-- If the Lunar Object module hasn't been loaded yet, start preparing the
-- load of it with some info that we need in this module.

if (not Lunar.Object) then
	Lunar.Object = {};
end

if (not Lunar.Object.dropdownData) then
	Lunar.Object.dropdownData = {};
end

-- Dump our dropdown data table for the dropdown menu system
Lunar.Object.dropdownData = {
	["Gauge_Events"] = {
		{Lunar.Locale["EVENT_PLAYER"], LS_EVENT_HEALTH, "EVENT_PLAYER"},
		{Lunar.Locale["EVENT_TARGET"], LS_EVENT_T_HEALTH, "EVENT_TARGET"},
--		{Lunar.Locale["EVENT_POWER"], LS_EVENT_POWER},
		{Lunar.Locale["EVENT_FIVE"], LS_EVENT_FIVE},
		{Lunar.Locale["EVENT_EXP"], LS_EVENT_EXP},
		{Lunar.Locale["EVENT_REP"], LS_EVENT_REP},
		{Lunar.Locale["EVENT_COMBO"], LS_EVENT_COMBO},
		{Lunar.Locale["EVENT_PETXP"], LS_EVENT_P_EXP},
		{Lunar.Locale["EVENT_EXTRA_POWER"], LS_EVENT_EXTRA_POWER},
		},
	["Gauge_Names"] = {
		{Lunar.Locale["OUTER_GAUGE"], 0},
		{Lunar.Locale["INNER_GAUGE"], 1},
		},
	["Sphere_Events"] = {
		{Lunar.Locale["EVENT_NONE"], LS_EVENT_NONE},
		{Lunar.Locale["EVENT_PLAYER1"], LS_EVENT_HEALTH},
		{Lunar.Locale["EVENT_PLAYER2"], LS_EVENT_POWER},
		{Lunar.Locale["EVENT_FIVE"], LS_EVENT_FIVE},
		{Lunar.Locale["EVENT_EXP"], LS_EVENT_EXP},
		{Lunar.Locale["EVENT_REP"], LS_EVENT_REP},
		{Lunar.Locale["EVENT_COMBO"], LS_EVENT_COMBO},
		{Lunar.Locale["EVENT_PETXP"], LS_EVENT_P_EXP},
		{Lunar.Locale["EVENT_EXTRA_POWER"], LS_EVENT_EXTRA_POWER},
--		{Lunar.Locale["EVENT_AMMO"], LS_EVENT_AMMO},
		{Lunar.Locale["EVENT_ACTION_COOLDOWN"], LS_EVENT_SPHERE_COOLDOWN},
		{Lunar.Locale["EVENT_ACTION_COUNT"], LS_EVENT_SPHERE_COUNT},
--		{Lunar.Locale["EVENT_SPHERE_COOLDOWN"], LS_EVENT_SPHERE_COOLDOWN},
--		{Lunar.Locale["EVENT_SPHERE_COUNT"], LS_EVENT_SPHERE_COUNT},
		},
	["Gauge_Marks"] = {
		{Lunar.Locale["MARKS_ZERO"], 0},
		{Lunar.Locale["MARKS_FIVE"], 5},
		{Lunar.Locale["MARKS_TEN"], 10},
		{Lunar.Locale["MARKS_TWENTY"], 20},
		},
	["Button_Type"] = {
		{Lunar.Locale["EVENT_NONE"], 0},
		{Lunar.Locale["BUTTON_SPELL_ITEM_MACRO"], 1},
		{Lunar.Locale["BUTTON_SELFCAST"], 5},
		{Lunar.Locale["BUTTON_FOCUSCAST"], 6},
		{Lunar.Locale["BUTTON_MENU"], 2},
		{Lunar.Locale["BUTTON_LASTSUBMENU"], 3},
		{Lunar.Locale["BUTTON_LASTSUBMENU2"], 4},
		{Lunar.Locale["BUTTON_DRINK"], 10, "BUTTON_DRINK"},
		{Lunar.Locale["BUTTON_FOOD"], 20, "BUTTON_FOOD"},
		{Lunar.Locale["BUTTON_HEALTHPOTION"], 30, "BUTTON_HEALTHPOTION"},
		{Lunar.Locale["BUTTON_MANAPOTION"], 40, "BUTTON_MANAPOTION"},
		{Lunar.Locale["BUTTON_ENERGY"], 50, "BUTTON_ENERGY"},
		{Lunar.Locale["BUTTON_RAGE"], 60, "BUTTON_RAGE"},
		{Lunar.Locale["BUTTON_BANDAGE"], 70, "BUTTON_BANDAGE"},
		{Lunar.Locale["BUTTON_MOUNT"], 80, "BUTTON_MOUNT"},
		{Lunar.Locale["BUTTON_BAG"], 90, "BUTTON_BAG"},
		{Lunar.Locale["BUTTON_MENUBAR"], 100, "BUTTON_MENUBAR"},
		{Lunar.Locale["BUTTON_TRADE"], 110, "BUTTON_TRADE"},
		{Lunar.Locale["BUTTON_WEAPONAPPLY"], 120, "BUTTON_WEAPONAPPLY"},
		{Lunar.Locale["BUTTON_INVENTORY"], 130, "BUTTON_INVENTORY"},
		{Lunar.Locale["BUTTON_PET"], 140, "BUTTON_PET"},
		},
	["Skin_Edit_Types"] = {
		{Lunar.Locale["SPHERE"], 0},
		{Lunar.Locale["BUTTONS"], 1},
		{Lunar.Locale["GAUGES"], 2},
		{Lunar.Locale["BORDERS"], 3},
		},
	["Menu_Dropdown"] = {
		{Lunar.Locale["_MENU_SETTINGS"], 0},
		{Lunar.Locale["_MENU_MOVE_SPHERE"], 1},
		{Lunar.Locale["_MENU_MOVE_DETACHED"], 3},
		{Lunar.Locale["_MENU_EDIT_BUTTONS"], 2},
		},
	["Speech_Channels"] = {
		{NONE, "NONE"},
		{CHAT_MSG_SAY, "SAY"},
		{CHAT_MSG_PARTY, "PARTY"},
		{CHAT_MSG_RAID, "RAID"},
		{CHAT_MSG_SAY .. "/" .. CHAT_MSG_PARTY .. "/" .. CHAT_MSG_RAID, "ANY"},
		{CHAT_MSG_PARTY .. "/" .. CHAT_MSG_RAID, "ANYGROUP"},
		{EMOTE_MESSAGE, "EMOTE"},
		{WHISPER, "WHISPER"},
		},	
	["Speech_Assign"] = {
		{Lunar.Locale["EVENT_NONE"], 0},
		{PLAYERSTAT_SPELL_COMBAT .. "/" .. HELPFRAME_ITEM_TITLE, 1},
		{Lunar.Locale["BUTTON_DRINK"], 2},
		{Lunar.Locale["BUTTON_FOOD"], 3},
		{Lunar.Locale["BUTTON_HEALTHPOTION"], 4},
		{Lunar.Locale["BUTTON_MANAPOTION"], 5},
		{Lunar.Locale["BUTTON_ENERGY"], 6},
		{Lunar.Locale["BUTTON_RAGE"], 7},
		{Lunar.Locale["BUTTON_BANDAGE"], 8},
		{Lunar.Locale["BUTTON_MOUNT"], 9},
		{Lunar.Locale["BUTTON_GROUNDMOUNT"], 10},
		{Lunar.Locale["BUTTON_FLYINGMOUNT"], 11},
		{Lunar.Locale["SPEECH_VANITY_PET"], 12},
		},
	["Anchor_Dropdown"] = {
		{Lunar.Locale["ANCHOR_DEFAULT"], 0},
		{Lunar.Locale["ANCHOR_CUSTOM"], 1},
		{Lunar.Locale["ANCHOR_MOUSE"], 2},
		{Lunar.Locale["ANCHOR_BUTTON1"], 3},
		{Lunar.Locale["ANCHOR_BUTTON2"], 4},
		{Lunar.Locale["ANCHOR_BUTTON3"], 5},
		{Lunar.Locale["ANCHOR_BUTTON4"], 6},
		{Lunar.Locale["ANCHOR_BUTTON5"], 7},
		{Lunar.Locale["ANCHOR_BUTTON6"], 8},
		{Lunar.Locale["ANCHOR_BUTTON7"], 9},
		{Lunar.Locale["ANCHOR_BUTTON8"], 10},
		},
	["Menu_Open_Type"] = {
		{Lunar.Locale["MENU_OPEN_TYPE1"], 1},
		{Lunar.Locale["MENU_OPEN_TYPE2"], 2},
		{Lunar.Locale["MENU_OPEN_TYPE3"], 3},
		},
	["Cooldown_Effects"] = {
		{Lunar.Locale["COOLDOWN_FX1"], 0},
		{Lunar.Locale["COOLDOWN_FX2"], 1},
		{Lunar.Locale["COOLDOWN_FX3"], 2},
		{Lunar.Locale["COOLDOWN_FX4"], 3},
		{Lunar.Locale["COOLDOWN_FX5"], 4},
		{Lunar.Locale["COOLDOWN_FX6"], 5},
		{Lunar.Locale["COOLDOWN_FX7"], 6},
		{Lunar.Locale["COOLDOWN_FX8"], 7},
		},
};

-- /***********************************************
--  * Functions
--  *********************
function Lunar.Settings:Load()

-- /***********************************************
--  * Initialize
--  * ========================
--  *
--  * Creates all of the setting frames and sets all values to their proper setting
--  *
--  * Accepts: None
--  * Returns: None
--  *********************
function Lunar.Settings:Initialize()

	-- Create our locals
	local tempFrame, tempFrameContainer, tempObject, index;

	-- Window and Container Sizes
	local windowWidth = 334;
	local windowHeight = 412;
	local containerWidth = 232;
	local containerHeight = 372;
	local sectionY = 0;

	-- Create our main settings window and assign the frame to the Settings object
	tempFrame = Lunar.Object:Create("window", "LSSettings", UIParent, Lunar.Locale["WINDOW_TITLE_SETTINGS"], windowWidth, windowHeight, 0.0, 0.0, 1.0);
	tempFrame:SetFrameStrata("HIGH");
	
	tempFrameContainer = _G[tempFrame:GetName() .. "WindowContainer"];
	tempFrame:Hide();

	Lunar.Settings.Frame = tempFrame;

	local refreshButtonsFunc = function ()
		local editSetting = LunarSphereSettings.buttonEditMode;
		LunarSphereSettings.buttonEditMode = true;
		Lunar.Button:ShowEmptyMenuButtons();
		LunarSphereSettings.buttonEditMode = editSetting;
		if not (editSetting == true) then
			Lunar.Button:HideEmptyMenuButtons();
		end
	end

	-- Create our tabs for the different settings we'll monkey with
	local tempLevel = tempFrameContainer:GetFrameLevel();
	tempObject = Lunar.Object:Create("verticaltab", "LSSettingsMainTab1313", tempFrameContainer, Lunar.Locale["DEBUG"]);
	tempObject:SetPoint("Topleft", 10, -286);
	tempObject:SetFrameLevel(tempLevel + 1);
	tempObject = Lunar.Object:Create("verticaltab", "LSSettingsMainTab1312", tempFrameContainer, Lunar.Locale["CREDITS"]);
	tempObject:SetPoint("Topleft", 10, -263);
	tempObject:SetFrameLevel(tempLevel + 2);
	tempObject = Lunar.Object:Create("verticaltab", "LSSettingsMainTab1311", tempFrameContainer, Lunar.Locale["MEMORY"]);
	tempObject:SetPoint("Topleft", 10, -240);
	tempObject:SetFrameLevel(tempLevel + 3);
	tempObject = Lunar.Object:Create("verticaltab", "LSSettingsMainTab1310", tempFrameContainer, Lunar.Locale["OTHER"]);
	tempObject:SetPoint("Topleft", 10, -217);
	tempObject:SetFrameLevel(tempLevel + 4);
	tempObject = Lunar.Object:Create("verticaltab", "LSSettingsMainTab1309", tempFrameContainer, Lunar.Locale["TEMPLATES"]);
	tempObject:SetPoint("Topleft", 10, -194);
	tempObject:SetFrameLevel(tempLevel + 5);
	tempObject = Lunar.Object:Create("verticaltab", "LSSettingsMainTab1308", tempFrameContainer, Lunar.Locale["TOOLTIPS"]);
	tempObject:SetPoint("Topleft", 10, -171);
	tempObject:SetFrameLevel(tempLevel + 6);
	tempObject = Lunar.Object:Create("verticaltab", "LSSettingsMainTab1307", tempFrameContainer, Lunar.Locale["SKINS"]);
	tempObject:SetPoint("Topleft", 10, -148);
	tempObject:SetFrameLevel(tempLevel + 7);
	tempObject = Lunar.Object:Create("verticaltab", "LSSettingsMainTab1306", tempFrameContainer, Lunar.Locale["SPEECH"]);
	tempObject:SetPoint("Topleft", 10, -125);
	tempObject:SetFrameLevel(tempLevel + 8);
	tempObject = Lunar.Object:Create("verticaltab", "LSSettingsMainTab1305", tempFrameContainer, Lunar.Locale["INVENTORY"]);
	tempObject:SetPoint("Topleft", 10, -102);
	tempObject:SetFrameLevel(tempLevel + 9);
	tempObject = Lunar.Object:Create("verticaltab", "LSSettingsMainTab1304", tempFrameContainer, Lunar.Locale["REAGENTS"]);
	tempObject:SetPoint("Topleft", 10, -79);
	tempObject:SetFrameLevel(tempLevel + 10);
	tempObject = Lunar.Object:Create("verticaltab", "LSSettingsMainTab1303", tempFrameContainer, Lunar.Locale["BUTTONS"]);
	tempObject:SetPoint("Topleft", 10, -56);
	tempObject:SetFrameLevel(tempLevel + 11);
	tempObject = Lunar.Object:Create("verticaltab", "LSSettingsMainTab1302", tempFrameContainer, Lunar.Locale["GAUGES"]);
	tempObject:SetPoint("Topleft", 10, -33);
	tempObject:SetFrameLevel(tempLevel + 12);
	tempObject = Lunar.Object:Create("verticaltab", "LSSettingsMainTab1301", tempFrameContainer, Lunar.Locale["SPHERE"]);
	tempObject:SetPoint("Topleft", 10, -10);
	tempObject:SetFrameLevel(tempLevel + 13);
	tempObject:SetBackdropColor(0.0,0.5,1.0,1.0);

	-- Create our first tab container. This holds our "Sphere Settings"
	tempObject = Lunar.Object:Create("container", "LSSettingsMainTab1301Container", tempFrameContainer, "", containerWidth, containerHeight);
	tempObject:SetPoint("Topleft", 92, -10);
	tempObject:SetFrameLevel(tempLevel + 15);
	tempFrameContainer = tempObject;

		_, Lunar.Settings.hasStances = UnitClass("player");
		if (Lunar.Settings.hasStances == "PALADIN") or (Lunar.Settings.hasStances == "DEATHKNIGHT") then
			--Lunar.Settings.hasAuras = true;
		elseif (Lunar.Settings.hasStances == "HUNTER") then
			--Lunar.Settings.hasAspects = true;
		end
		
		if not ((Lunar.Settings.hasStances == "WARRIOR") or (Lunar.Settings.hasStances == "ROGUE") or (Lunar.Settings.hasStances == "DRUID") or (Lunar.Settings.hasStances == "PRIEST") or (Lunar.Settings.hasStances == "SHAMAN") or (Lunar.Settings.hasStances == "WARLOCK")) then
			Lunar.Settings.hasStances = nil;
		end


		-- Create container for stance related options
		tempObject = Lunar.Object:Create("container", "LSSetttingsSphereStanceContainer", tempFrameContainer, "", containerWidth - 16, 128, 0.0, 0.0, 0.5); --172
		tempObject:SetPoint("Topleft", tempFrameContainer, "Topleft", 8, -8);
		tempFrameContainer = tempObject;

		sectionY = -118;
		sectionY = -20;

		-- Sphere event dropdown
		tempObject = Lunar.Object:CreateDropdown(-8, sectionY, 180, "sphereTextType", Lunar.Locale["SPHERE_GAUGE_EVENT"], "Sphere_Events", "sphereTextType", tempFrameContainer,
		function(self) 
			Lunar.Sphere:SetSphereTextType(self.value)
			if (self.value == LS_EVENT_SPHERE_COOLDOWN) or (self.value == LS_EVENT_SPHERE_COUNT) then
				_G["LSSettingssphereActionAssign"]:Show();
				_G["LSSettingsactionDisplayCaption"]:Show();
			else
				_G["LSSettingssphereActionAssign"]:Hide();
				_G["LSSettingsactionDisplayCaption"]:Hide();
			end					

			-- Hide percentage text in certain situations
--			if not ((self.value  == LS_EVENT_POWER) or (self.value  == LS_EVENT_EXTRA_POWER) or (self.value  == LS_EVENT_HEALTH) or (self.value  == LS_EVENT_COMBO))  then
--				_G["LSSettingsshowSphereTextPercentage"]:Hide();
--			else
--				_G["LSSettingsshowSphereTextPercentage"]:Show();
--			end

		end);

		-- Sphere text color changing object
		tempObject = Lunar.Object:CreateColorSelector(20, sectionY - 35, Lunar.Locale["SPHERE_TEXT_COLOR"], "sphereTextColor", tempFrameContainer, 
		function()
			Lunar.Sphere:SetSphereTextColor();
		end);

		tempObject = Lunar.Object:CreateButton(120, sectionY - 32, 80, "SphereTextDefaultColor", Lunar.Locale["DEFAULT"], tempFrameContainer,
		function()
			LunarSphereSettings.sphereTextColor[1] = 1;
			LunarSphereSettings.sphereTextColor[2] = 1;
			LunarSphereSettings.sphereTextColor[3] = 1;
			Lunar.Sphere:SetSphereTextColor();
		end);

		-- Sphere text shadow option
		tempObject = Lunar.Object:CreateCheckbox(8, sectionY - 54, Lunar.Locale["SHOW_SPHERE_TEXT_SHADOW"], "showSphereTextShadow", true, tempFrameContainer,
		function (self) 
			Lunar.Sphere:ShowSphereTextShadow(self:GetChecked() == true); 
		end);

		-- Sphere text percentage option
		tempObject = Lunar.Object:CreateCheckbox(8, sectionY - 70, STATUS_TEXT_PERCENT, "useSphereTextPercentage", true, tempFrameContainer,
		function (self) 
			Lunar.Sphere:ShowSphereTextPercentage(self:GetChecked() == true); 
		end);

		-- Hide percentage text in certain situations
		local textType = LunarSphereSettings.sphereTextType;
		if not ((textType == LS_EVENT_POWER) or (textType == LS_EVENT_EXTRA_POWER) or (textType == LS_EVENT_HEALTH) or (textType == LS_EVENT_COMBO))  then
			tempObject:Hide();
		end

		-- Action assignment box
		tempObject = Lunar.Object:CreateIconPlaceholder(12, sectionY - 74, "sphereActionAssign", tempFrameContainer, true);
		tempObject:SetWidth(24);
		tempObject:SetHeight(24);
		tempObject:GetNormalTexture():SetWidth(40);
		tempObject:GetNormalTexture():SetHeight(40);
		tempObject:SetScript("OnClick", Lunar.Object.SphereActionIconPlaceHolder_OnClick)
		tempObject:SetScript("OnReceiveDrag", Lunar.Object.SphereActionIconPlaceHolder_OnClick);
		if (LunarSphereSettings.sphereAction) then
			if GetSpellInfo(LunarSphereSettings.sphereAction) then
				objectTexture = GetSpellTexture(LunarSphereSettings.sphereAction);
			else
				objectTexture = GetItemIcon(LunarSphereSettings.sphereAction);	
			end
			_G["LSSettingssphereActionAssignIcon"]:SetTexture(objectTexture);
		end

		-- Action assignment box caption
		tempObject = Lunar.Object:CreateCaption(46, sectionY - 76, 150, 20, "|cFFFFFFFF" .. Lunar.Locale["SPHERE_ACTION_DISPLAY_TEXT"], "actionDisplayCaption", tempFrameContainer);

		-- Hide the assignment boxes if they aren't needed.
		if not ((textType == LS_EVENT_SPHERE_COOLDOWN) or (textType == LS_EVENT_SPHERE_COUNT)) then
			_G["LSSettingssphereActionAssign"]:Hide();
			tempObject:Hide();
		end


		tempFrameContainer = _G["LSSettingsMainTab1301Container"];

		sectionY = -148;

		-- Sphere scale option
		tempObject = Lunar.Object:CreateSlider(20, sectionY, Lunar.Locale["SPHERE_SCALE"], "sphereScale", tempFrameContainer, 0.1, 6.0, 0.01,
		function () 
			_G["LSmain"]:SetScale(LunarSphereSettings.sphereScale);
			Lunar.Settings:UpdateMainButtons();
		end, true);
		tempObject:SetWidth(160);

		-- Sphere button distance option
		tempObject = Lunar.Object:CreateSlider(20, sectionY - 25, Lunar.Locale["SPHERE_BUTTON_DISTANCE"], "buttonDistance", tempFrameContainer, 0, 500, 1, Lunar.Settings.UpdateMainButtons, true);
		tempObject:SetWidth(160);

		-- Sphere button spacing option
		tempObject = Lunar.Object:CreateSlider(20, sectionY - 50, Lunar.Locale["SPHERE_BUTTON_SPACING"], "buttonSpacing", tempFrameContainer, 0, 150, 1, Lunar.Settings.UpdateMainButtons, true);
		tempObject:SetWidth(160);

		-- Sphere button angle offset option
		tempObject = Lunar.Object:CreateSlider(20, sectionY - 75, Lunar.Locale["SPHERE_BUTTON_ANGLE_OFFSET"], "buttonOffset", tempFrameContainer, 0, 360, 1, Lunar.Settings.UpdateMainButtons, true);
		tempObject:SetWidth(160);

		-- Sphere button count option
		tempObject = Lunar.Object:CreateSlider(20, sectionY - 100, Lunar.Locale["SPHERE_MAIN_BUTTON_COUNT"], "mainButtonCount", tempFrameContainer, 1, 10, 1, refreshButtonsFunc, true);
		tempObject:SetWidth(160);
		tempObject:SetScript("OnMouseUp", fixSubmenuCompressionFunc);

		sectionY = -264;

		-- Sphere lockdown option
		tempObject = Lunar.Object:CreateCheckbox(10, sectionY, Lunar.Locale["_MENU_MOVE_SPHERE"], "sphereMoveable", true, tempFrameContainer);

		-- Detached buttons lockdown option
		tempObject = Lunar.Object:CreateCheckbox(10, sectionY - 16, Lunar.Locale["_MENU_MOVE_DETACHED"], "detachedMoveable", true, tempFrameContainer);

		-- Button Edit Mode option
		tempObject = Lunar.Object:CreateCheckbox(10, sectionY - 32, Lunar.Locale["EDIT_BUTTONS"], "buttonEditMode", true, tempFrameContainer,
		function (self)
			LunarSphereSettings.buttonEditMode = (self:GetChecked() == true); 
			Lunar.Settings.ButtonDialog:Hide();
			if (Lunar.combatLockdown ~= true) then
				Lunar.Sphere:ShowSphereEditGlow(LunarSphereSettings.showSphereEditGlow);
			end
		end);

		-- Sphere "edit mode" glow option
		tempObject = Lunar.Object:CreateCheckbox(10, sectionY - 48, Lunar.Locale["SHOW_UNLOCKED_SPHERE_GLOW"], "showSphereEditGlow", true, tempFrameContainer,
		function (self)
			Lunar.Sphere:ShowSphereEditGlow(self:GetChecked()); 
		end);

		-- Submenu Button Compression option
		tempObject = Lunar.Object:CreateCheckbox(10, sectionY - 64, Lunar.Locale["SUBMENU_BUTTON_COMPRESSION"], "submenuCompression", true, tempFrameContainer,
		function (self)
			LunarSphereSettings.submenuCompression = (self:GetChecked() == true); 
			Lunar.Settings:UpdateMainButtons();
--			local tempSetting = Lunar.Button.hiddenButtons;
--			Lunar.Button.hiddenButtons = false;
--			Lunar.Button:ShowEmptyMenuButtons();
--			Lunar.Button:HideEmptyMenuButtons();
--			Lunar.Button.hiddenButtons = tempSetting;
		end);

		-- Hide the sphere options
		tempObject = Lunar.Object:CreateCheckbox(10, sectionY - 80, Lunar.Locale["HIDE_CENTER_SPHERE"], "sphereAlpha", false, tempFrameContainer,
		function(self)
			if (self:GetChecked() == true) then
				Lunar.Sphere:ToggleSphere(0);
			else
				Lunar.Sphere:ToggleSphere(1);
			end
		end);

	-- Create our second tab container. This holds our "Gauge Settings"
	tempObject = Lunar.Object:Create("container", "LSSettingsMainTab1302Container", _G[tempFrame:GetName() .. "WindowContainer"], "", containerWidth, containerHeight);
	tempObject:SetPoint("Topleft", 92, -10);
	tempObject:SetFrameLevel(tempLevel + 15);
	tempObject:Hide();
	tempFrameContainer = tempObject;

		-- Gauge names dropdown
		tempObject = Lunar.Object:CreateDropdown(0, -20, 180, "gaugeName", Lunar.Locale["GAUGE_TO_EDIT"], "Gauge_Names", "gaugeName", tempFrameContainer,
		function(self)
			Lunar.Settings:UpdateGaugeOptions(self.value);
			if (self.value == 0) then
				_G["LSSettingsgaugeName"].currentGauge = "Outer";
			else
				_G["LSSettingsgaugeName"].currentGauge = "Inner";
			end
		end);
		UIDropDownMenu_SetSelectedValue(tempObject, 0);
		_G["LSSettingsgaugeNameText"]:SetText(Lunar.Locale["OUTER_GAUGE"]);
		tempObject.currentGauge = "Outer";

		-- Create container for gauge options
		tempObject = Lunar.Object:Create("container", "LSSetttingsGaugeOptionsContainer", tempFrameContainer, "", containerWidth - 16, 250, 0.0, 0.0, 0.5); --172
		tempObject:SetPoint("Topleft", tempFrameContainer, "Topleft", 8, -50);
		tempFrameContainer = tempObject;

			sectionY = -20

			-- Gauge event dropdown
			tempObject = Lunar.Object:CreateDropdown(-8, sectionY, 180, "gaugeType", Lunar.Locale["GAUGE_EVENT"], "Gauge_Events", "gaugeType", tempFrameContainer,
			function()
--[[
				local db = Lunar.Object.dropdownData["Gauge_Events"][this.value]
				local eventID = this.value;
				if (db) then
					if (db[3]) then
						eventID = db[2];
						UIDropDownMenu_SetSelectedName(this, Lunar.Locale[Lunar.Object.dropdownData[listName][i][3] .. "1"]);	
					end
				end
				UIDropDownMenu_SetSelectedName(this, Lunar.Locale[Lunar.Object.dropdownData[listName][i][3] .. "1"]);	
				dropdownObject.selectedValue = Lunar.Object.dropdownData[listName][i][2];
				
				Lunar.Sphere:SetGaugeType(_G["LSSettingsgaugeName"].currentGauge, eventID); --Lunar.Object.dropdownData["Gauge_Events"][this.value][2])
--]]
			end);

			-- Gauge color changing objects
			tempObject = Lunar.Object:CreateColorSelector(20, sectionY - 35, Lunar.Locale["GAUGE_COLOR"], "outerGaugeColor", tempFrameContainer, 
			function()
				Lunar.Sphere:UpdateDefaultColors("outerGauge");
				Lunar.Sphere:UpdateGaugeColors();
			end);

			-- Gauge color changing objects
			tempObject = Lunar.Object:CreateColorSelector(20, sectionY - 35, Lunar.Locale["GAUGE_COLOR"], "innerGaugeColor", tempFrameContainer, 
			function()
				Lunar.Sphere:UpdateDefaultColors("innerGauge");
				Lunar.Sphere:UpdateGaugeColors();
			end);
			tempObject:Hide();

			tempObject = Lunar.Object:CreateButton(120, sectionY - 32, 80, "DefaultColor", Lunar.Locale["DEFAULT"], tempFrameContainer,
			function()
				Lunar.Sphere:ResetDefaultColor(LunarSphereSettings[string.lower(_G["LSSettingsgaugeName"].currentGauge) .. "GaugeType"]);
			end);

			-- Gauge visible marks dropdown
			tempObject = Lunar.Object:CreateDropdown(-8, sectionY - 70, 180, "markSize", Lunar.Locale["GAUGE_MARKS"], "Gauge_Marks", "markSize", tempFrameContainer,
			function(self)
				local func = Lunar.Sphere["Set" .. _G["LSSettingsgaugeName"].currentGauge .. "MarkSize"]
				pcall(func, self, (self.value));
			end);

			local tempFunc = function () Lunar.Sphere:UpdateSkin("gaugeFill") end;

			-- Inner gauge angle option
			tempObject = Lunar.Object:CreateSlider(20, sectionY - 110, Lunar.Locale["GAUGE_ANGLE_OFFSET"], "innerGaugeAngle", tempFrameContainer, 0, 360, 1, tempFunc, true)

			-- Outer gauge angle option
			tempObject = Lunar.Object:CreateSlider(20, sectionY - 110, Lunar.Locale["GAUGE_ANGLE_OFFSET"], "outerGaugeAngle", tempFrameContainer, 0, 360, 1, tempFunc, true)

			-- Gauge reverse direction option
			tempObject = Lunar.Object:CreateCheckbox(10, sectionY - 130, Lunar.Locale["GAUGE_REVERSE"], "gaugeReverse", true, tempFrameContainer,
			function(self)
--				local value = self:GetChecked();
--				if (value ~= true) then
--					value = false;
--				end
				if (self:GetChecked()) then
					value = 1;
				else
					value = -1;
				end
				LunarSphereSettings[string.lower(_G["LSSettingsgaugeName"].currentGauge) .. "GaugeDirection"] = value;
				Lunar.Sphere:UpdateSkin("gaugeFill");
			end);

			-- Gauge uses darker marks option
			tempObject = Lunar.Object:CreateCheckbox(10, sectionY - 145, Lunar.Locale["GAUGE_MARKS_DARK"], "markDark", true, tempFrameContainer,
			function(self)
				local gaugeName = _G["LSSettingsgaugeName"].currentGauge
				LunarSphereSettings[string.lower(gaugeName) .. "MarkDark"] = (self:GetChecked() == true);
				local func = Lunar.Sphere["Set" .. gaugeName .. "MarkSize"]
				pcall(func, self, (LunarSphereSettings[string.lower(gaugeName) .. "MarkSize"]));
			end);

			-- Gauge uses animaion option


			tempObject = Lunar.Object:CreateCheckbox(10, sectionY - 160, Lunar.Locale["GAUGE_SHOW_ANIMATION"], "gaugeAnimate", true, tempFrameContainer,
			function(self)
				local func = Lunar.Sphere["Show" .. _G["LSSettingsgaugeName"].currentGauge .. "Animation"]
				pcall(func, self, (self:GetChecked() == true));
			end);

			-- Gauge is enabled option
			tempObject = Lunar.Object:CreateCheckbox(10, sectionY - 175, Lunar.Locale["GAUGE_SHOW"], "showGauge", true, tempFrameContainer,
			function(self)
				local func = Lunar.Sphere["Show" .. _G["LSSettingsgaugeName"].currentGauge .. "Gauge"]
				pcall(func, self, (self:GetChecked() == true));
				Lunar.Sphere:ShowOuterGauge(LunarSphereSettings.showOuter);
				Lunar.Sphere:ToggleSphere(LunarSphereSettings.sphereAlpha);
			end);

			Lunar.Settings:UpdateGaugeOptions(0);

--[[
	-- Create our second tab container. This holds our "Outer Gauge Settings"
	tempObject = Lunar.Object:Create("container", "LSSettingsMainTab1302Container", _G[tempFrame:GetName() .. "WindowContainer"], "", containerWidth, containerHeight);
	tempObject:SetPoint("Topleft", 92, -10);
	tempObject:SetFrameLevel(tempLevel + 15);
	tempObject:Hide();
	tempFrameContainer = tempObject;

		-- Outer gauge event dropdown
		tempObject = Lunar.Object:CreateDropdown(0, -20, 180, "outerGaugeType", Lunar.Locale["OUTER_GAUGE_EVENT"], "Gauge_Events", "outerGaugeType", tempFrameContainer, function() Lunar.Sphere:SetOuterGaugeType(this.value) end);

		-- Outer gauge color changing objects
		tempObject = Lunar.Object:CreateColorSelector(24, -55, Lunar.Locale["GAUGE_COLOR"], "outerGaugeColor", tempFrameContainer, 
		function()
			Lunar.Sphere:UpdateDefaultColors("outerGauge");
			Lunar.Sphere:UpdateGaugeColors();
		end);

		tempObject = Lunar.Object:CreateButton(135, -52, 80, "DefaultOuterColor", Lunar.Locale["DEFAULT"], tempFrameContainer,
		function()
			Lunar.Sphere:ResetDefaultColor(LunarSphereSettings["outerGaugeType"]);
		end);

		-- Outer gauge visible marks dropdown
		tempObject = Lunar.Object:CreateDropdown(0, -90, 180, "outerMarkSize", Lunar.Locale["OUTER_GAUGE_MARKS"], "Gauge_Marks", "outerMarkSize", tempFrameContainer, function() Lunar.Sphere:SetOuterMarkSize(this.value) end);

		-- Outer gauge uses darker marks option
		tempObject = Lunar.Object:CreateCheckbox(10, -120, Lunar.Locale["OUTER_MARKS_DARK"], "outerMarkDark", true, tempFrameContainer,
		function()
			LunarSphereSettings.outerMarkDark = (self:GetChecked() == true);
			Lunar.Sphere:SetOuterMarkSize(LunarSphereSettings.outerMarkSize);
		end);

		-- Outer gauge uses animaion option
		tempObject = Lunar.Object:CreateCheckbox(10, -140, Lunar.Locale["SHOW_OUTER_GAUGE_ANIMATION"], "outerGaugeAnimate", true, tempFrameContainer,
		function()
			Lunar.Sphere:ShowOuterAnimation(self:GetChecked() == true);
		end);

		-- Outer gauge is enabled option
		tempObject = Lunar.Object:CreateCheckbox(10, -160, Lunar.Locale["SHOW_OUTER_GAUGE"], "showOuter", true, tempFrameContainer,
		function()
			Lunar.Sphere:ShowOuterGauge(self:GetChecked() == true);
		end);
--]]
	-- Create our third tab container. This holds our "Button settings"
	tempObject = Lunar.Object:Create("container", "LSSettingsMainTab1303Container", _G[tempFrame:GetName() .. "WindowContainer"], "", containerWidth, containerHeight);
	tempObject:SetPoint("Topleft", 92, -10);
	tempObject:SetFrameLevel(tempLevel + 15);
	tempObject:Hide();
	tempFrameContainer = tempObject;

		-- Create teaser =)
--		tempObject = Lunar.Object:CreateCaption(60, -115, 150, 20, "I'm such a tease ...\n   (Coming soon)", "buttonTeaser", tempFrameContainer);

		-- Scroll frame
		tempObject = Lunar.API:CreateFrame("ScrollFrame", "LSSettingsButtonsScrollFrame", tempFrameContainer, 200, 352, nil, nil, 0);
		tempObject:SetPoint("Topleft", 0, -10);
		tempObject:Show();

		sectionY = 0;

		-- Create border of scroll frame
		tempObject = Lunar.Object:Create("container", "LSButtonsListBorder", tempFrameContainer, "", 202, 383, 0.1, 0.1, 0.1)
		tempObject:SetPoint("TopLeft", tempFrameContainer, "TopLeft", 0, sectionY);
		tempObject:SetFrameLevel(tempFrameContainer:GetFrameLevel() + 1);
		tempObject:EnableMouse("true");
		tempObject:EnableMouseWheel("true");
		tempObject.scrollerName = "LSSettingsButtonsListSlider";
		tempObject:SetScript("OnMouseWheel", Lunar.Settings.OnMouseWheelScroll);
		tempObject:SetAlpha(0);

		-- Create border of scroller
		tempObject = Lunar.Object:Create("container", "LSButtonsListScrollerBorder", tempFrameContainer, "", 31, 372, 0.1, 0.1, 0.1)
		tempObject:ClearAllPoints();
		tempObject:SetPoint("TopRight", tempFrameContainer, "TopRight", 0, sectionY);
		tempObject:SetFrameLevel(tempFrameContainer:GetFrameLevel() + 2);
		tempObject:EnableMouseWheel("true");
		tempObject.scrollerName = "LSSettingsButtonsListSlider";
		tempObject:SetScript("OnMouseWheel", Lunar.Settings.OnMouseWheelScroll);

		-- Create slider bar
		tempObject = CreateFrame("Slider", "LSSettingsButtonsListSlider", tempFrameContainer, "LunarVerticalSlider");

		tempObject:SetPoint("TopRight", tempFrameContainer, "TopRight", -8, sectionY - 4);
		tempObject:SetWidth(15);
		tempObject:SetHeight(362);
		tempObject:SetValueStep(16);
		tempObject:SetFrameLevel(tempFrameContainer:GetFrameLevel() + 3);
		tempObject:SetMinMaxValues(0, 116);
		tempObject:Show();
		tempObject:SetScript("OnValueChanged",
		function(self)
			_G["LSSettingsButtonsScrollFrame"]:SetVerticalScroll(self:GetValue());
		end);

		-- Scroll frame contents
		tempFrameContainer = Lunar.API:CreateFrame("Frame", "LSSettingsButtonsscrollFrameChild", _G["LSSettingsButtonsScrollFrame"], 190, 832, nil, nil, 0);
		_G["LSSettingsButtonsScrollFrame"]:SetScrollChild(tempFrameContainer);

		sectionY = 0;

			-- Vivid color options --Lunar.Locale["STATUS_BUTTON_COLORS"]
--			tempObject = Lunar.Object:CreateCaption(32, sectionY, 150, 20, "|cFFFFFFFF" .. Lunar.Locale["VIVID_BUTTON_STATUS_COLORS"], "vividColorSettings", tempFrameContainer);
			tempObject = Lunar.Object:CreateCaption(10, sectionY, 150, 20, "|cFFFFFFFF" .. Lunar.Locale["STATUS_BUTTON_COLORS"], "vividColorSettings", tempFrameContainer);

			-- Create Vivid button status colors check box
			tempObject = Lunar.Object:CreateCheckbox(10, sectionY - 16, Lunar.Locale["VIVID_BUTTON_STATUS_COLORS"], "vividButtons", true, tempFrameContainer);
--			tempObject = Lunar.Object:CreateCheckbox(10, sectionY, "", "vividButtons", true, tempFrameContainer);

			sectionY = -41;

			tempObject = Lunar.Object:CreateColorSelector(18, sectionY, Lunar.Locale["VIVID_NORANGE"], "vividRange", tempFrameContainer, Lunar.API.BlankFunction);
			tempObject = Lunar.Object:CreateColorSelector(18, sectionY - 26, Lunar.Locale["VIVID_NOMANA"], "vividMana", tempFrameContainer, Lunar.API.BlankFunction);
			tempObject = Lunar.Object:CreateColorSelector(18, sectionY - 52, Lunar.Locale["VIVID_NOMANARANGE"], "vividManaRange", tempFrameContainer, Lunar.API.BlankFunction);

			sectionY = -120;

			-- Button display options
			tempObject = Lunar.Object:CreateCaption(12, sectionY, 150, 20, "|cFFFFFFFF" .. Lunar.Locale["MENU_GLOBAL_SCALE"], "globalButtonScaleSettings", tempFrameContainer);

			-- Create button function (shared for all 4 buttons.
			local scaleButtonFunc = function(self)
				local db = LunarSphereSettings.buttonData;
				local index;
--				local typeString = string.match(self:GetName(), "Apply(.*)Scale%d");
				local typeString = string.match(self:GetName(), "LSSettingsglobal(.*)ButtonScale");
				local value = _G["LSSettingsglobal" .. typeString .. "ButtonScale"]:GetValue();
--				local value1 = _G["LSSettingsglobalButtonButtonScale"]:GetValue();
--				local value2 = _G["LSSettingsglobalChildButtonScale"]:GetValue();
--				local useScale = tonumber(string.match(self:GetName(), "%d"))
--				if (useScale == 0) then
--					value = 1;
--				end
				for index = 1, 10 do 
					db[index][string.lower(typeString).."Scale"] = value;
--					db[index]["use" .. typeString .. "Scale"] = useScale;
					db[index]["use" .. typeString .. "Scale"] = 1;
--					db[index]["buttonScale"] = value1;
--					db[index]["useButtonScale"] = 1;
--					db[index]["childScale"] = value2;
--					db[index]["useChildScale"] = 1;
					Lunar.Button:SetupMenuAngle(index);
				end
				Lunar.Settings.buttonEditCache = nil;
				Lunar.Settings.ButtonDialog:Hide();
			end

			-- Global menu button scale and apply button
--			tempObject = Lunar.Object:CreateSlider(15, sectionY - 30, Lunar.Locale["MAIN_BUTTON_SCALE"], "globalButtonButtonScale", tempFrameContainer, 0.5, 3, 0.05, Lunar.API.BlankFunction);
			tempObject = Lunar.Object:CreateSlider(15, sectionY - 30, Lunar.Locale["MAIN_BUTTON_SCALE"], "globalButtonButtonScale", tempFrameContainer, 0.1, 6, 0.01, Lunar.API.BlankFunction, true);
--			tempObject:SetScript("OnValueChanged", Lunar.API.BlankFunction);
			tempObject:SetValue((LunarSphereSettings.buttonData and LunarSphereSettings.buttonData[1] and LunarSphereSettings.buttonData[1].buttonScale) or 1);
			tempObject.updateFunction = scaleButtonFunc;
			tempObject:SetScript("OnValueChanged", Lunar.Object.Slider_OnValueChanged);

			tempObject:SetWidth(140);
--			tempObject:SetValue(1);
--			tempObject = Lunar.Object:CreateButton(10, sectionY - 50, 94, "ApplyButtonScale1", Lunar.Locale["APPLY"], tempFrameContainer, scaleButtonFunc);
--			tempObject:SetHeight(18);
--			tempObject = Lunar.Object:CreateButton(104, sectionY - 50, 94, "ApplyButtonScale0", RESET, tempFrameContainer, scaleButtonFunc);
--			tempObject:SetHeight(18);

			sectionY = sectionY - 30;

			-- Global submenu button scale, apply, and reset buttons
--			tempObject = Lunar.Object:CreateSlider(15, sectionY - 30, Lunar.Locale["SUBMENU_BUTTON_SCALE"], "globalChildButtonScale", tempFrameContainer, 0.5, 3, 0.05, Lunar.API.BlankFunction);
			tempObject = Lunar.Object:CreateSlider(15, sectionY - 30, Lunar.Locale["SUBMENU_BUTTON_SCALE"], "globalChildButtonScale", tempFrameContainer, 0.1, 6, 0.01, Lunar.API.BlankFunction, true);
			tempObject:SetWidth(140);
--			tempObject:SetValue(1);
--			tempObject = Lunar.Object:CreateButton(10, sectionY - 50, 94, "ApplyChildScale1", Lunar.Locale["APPLY"], tempFrameContainer, scaleButtonFunc);
--			tempObject:SetHeight(18);
--			tempObject = Lunar.Object:CreateButton(104, sectionY - 50, 94, "ApplyChildScale0", RESET, tempFrameContainer, scaleButtonFunc);
--			tempObject:SetHeight(18);
--			tempObject:SetScript("OnValueChanged", Lunar.API.BlankFunction);
			tempObject:SetValue((LunarSphereSettings.buttonData and LunarSphereSettings.buttonData[1] and LunarSphereSettings.buttonData[1].childScale) or 1);
			tempObject.updateFunction = scaleButtonFunc;
			tempObject:SetScript("OnValueChanged", Lunar.Object.Slider_OnValueChanged);

			sectionY = -202;

			-- Cooldown display options
			tempObject = Lunar.Object:CreateCaption(12, sectionY, 150, 20, "|cFFFFFFFF" .. Lunar.Locale["COOLDOWN_DISPLAY_OPTIONS"], "cooldownDisplaySettings", tempFrameContainer);

			-- Skip global cooldown
			tempObject = Lunar.Object:CreateCheckbox(10, sectionY - 15, Lunar.Locale["SKIP_GLOBAL_COOLDOWN"], "skipGlobalCooldown", true, tempFrameContainer);

			-- Show cooldown shine
			tempObject = Lunar.Object:CreateCheckbox(10, sectionY - 30, Lunar.Locale["COOLDOWN_SHOW_SHINE"], "cooldownShowShine", true, tempFrameContainer);

			-- Show cooldown text
			tempObject = Lunar.Object:CreateCheckbox(10, sectionY - 45, Lunar.Locale["COOLDOWN_SHOW_TEXT"], "cooldownShowText", true, tempFrameContainer,
			function (self)
				LunarSphereSettings.cooldownShowText = (self:GetChecked() == true);
				if not LunarSphereSettings.cooldownShowText then
					local index, button;
					for index = 1, 130 do
						if (index > 10) then
							button = _G["LunarSub" .. index .. "Button"];
						else
							button = _G["LunarMenu" .. index .. "Button"];
						end
						button.cooldownText:Hide();
					end
				end
			end);

			-- Cooldown effect dropdown
			tempObject = Lunar.Object:CreateDropdown(-8, sectionY - 75, 170, "cooldownEffect", Lunar.Locale["COOLDOWN_ICON_EFFECTS"], "Cooldown_Effects", "cooldownEffect", tempFrameContainer,
			function(self)
				LunarSphereSettings.cooldownEffect = self.value;
				for index = 1, 130 do
					if (index > 10) then
						button = _G["LunarSub" .. index .. "Button"];
					else
						button = _G["LunarMenu" .. index .. "Button"];
					end
					Lunar.Button.UpdateCooldown(button);
				end
			end);

			tempObject = Lunar.Object:CreateColorSelector(18, sectionY - 110, Lunar.Locale["COOLDOWN_COLOR_TEXT"], "cooldownColorText", tempFrameContainer,
			function ()
				local index, button;
				for index = 1, 130 do
					if (index > 10) then
						button = _G["LunarSub" .. index .. "Button"];
					else
						button = _G["LunarMenu" .. index .. "Button"];
					end
					button.cooldownText:SetTextColor(unpack(LunarSphereSettings.cooldownColorText));
				end
			end);

			tempObject = Lunar.Object:CreateColorSelector(114, sectionY - 110, Lunar.Locale["COOLDOWN_COLOR_TINT"], "cooldownColorTint", tempFrameContainer,
			function ()
				local index, button;
				for index = 1, 130 do
					if (index > 10) then
						button = _G["LunarSub" .. index .. "Button"];
					else
						button = _G["LunarMenu" .. index .. "Button"];
					end
					button.cooldown:SetVertexColor(unpack(LunarSphereSettings.cooldownColorTint));
					button.cooldown:SetAlpha(LunarSphereSettings.cooldownColorTint[4]);
				end
			end, true);

	--[[
			["COOLDOWN_ICON_EFFECTS"] = "Special cooldown effects",
			["COOLDOWN_FX1"] = NONE,
			["COOLDOWN_FX2"] = "Fade out tint",
			["COOLDOWN_FX3"] = "Fade in button",
			["COOLDOWN_FX4"] = "Shrink tint",
			["COOLDOWN_SHOW_SHINE"] = "Show shine when ready",
			["COOLDOWN_SHOW_TEXT"] = "Show cooldown text",
			["COOLDOWN_COLOR_TINT"] = "Icon tint",
			["COOLDOWN_COLOR_TEXT"] = "Text color",
	--]]
			sectionY = -338;

			-- Button display options
			tempObject = Lunar.Object:CreateCaption(12, sectionY, 150, 20, "|cFFFFFFFF" .. Lunar.Locale["DISPLAY_BUTTON_OPTIONS"], "buttonDisplaySettings", tempFrameContainer);

			-- Create Hide Keybinds check box
			tempObject = Lunar.Object:CreateCheckbox(10, sectionY - 16, Lunar.Locale["HIDE_KEYBINDS"], "hideKeybinds", true, tempFrameContainer,
			function (self)
				LunarSphereSettings.hideKeybinds = (self:GetChecked() == true)
				Lunar.Button.ToggleKeybinds();
			end);

			-- Create "Keep keybinds while swapping" check box
			tempObject = Lunar.Object:CreateCheckbox(10, sectionY - 31, Lunar.Locale["KEEP_KEYBINDS"], "keepKeybinds", true, tempFrameContainer);

			-- Create DrDamage support check box
			tempObject = Lunar.Object:CreateCheckbox(10, sectionY - 46, Lunar.Locale["DRDAMAGE_SUPPORT"], "enableDrDamage", true, tempFrameContainer,
			function (self)
				LunarSphereSettings.enableDrDamage = (self:GetChecked() == true)
				Lunar.Button.updateDrDamage = true;
				Lunar.API:SupportForDrDamage();
				if (DrDamage) then
--					DrDamage:RefreshAB()
					DrDamage:UpdateAB();
				end
				Lunar.Button.updateCounterFrame.updateButtons = 2;
				Lunar.updateButtons = 2;
				Lunar.Button.updateCounterFrame.elapsed = 0;
			end);

			-- Create the "Enable Dr. Damage Tooltips" option
			tempObject = Lunar.Object:CreateCheckbox(10, sectionY - 61, Lunar.Locale["DRDAMAGE_SUPPORTTIP"], "enableDrDamageTips", true, tempFrameContainer);

			-- Create the "Always show pet buttons when pet is out" option
			tempObject = Lunar.Object:CreateCheckbox(10, sectionY - 76, Lunar.Locale["ALWAYS_SHOW_PET"], "alwaysShowPet", true, tempFrameContainer,
			function (self)
				LunarSphereSettings.alwaysShowPet = (self:GetChecked() == true);
				refreshButtonsFunc();
			end);

			-- Create the "Force drag-and-drop assignment" option
			tempObject = Lunar.Object:CreateCheckbox(10, sectionY - 100, Lunar.Locale["FORCE_DRAGDROP"], "forceDragDrop", true, tempFrameContainer);


	-- Create our forth tab container. This holds our "Reagents Settings"
	tempObject = Lunar.Object:Create("container", "LSSettingsMainTab1304Container", _G[tempFrame:GetName() .. "WindowContainer"], "", containerWidth, containerHeight);
	tempObject:SetPoint("Topleft", 92, -10);
	tempObject:SetFrameLevel(tempLevel + 15);
	tempObject:Hide();
	tempFrameContainer = tempObject;

		if (LunarSphereSettings.memoryDisableReagents) then

			-- Create Disabled Caption
			tempObject = Lunar.Object:CreateCaption(20, -20, 100, 20, Lunar.Locale["MEMORY_DISABLED"], "memReagentsDisabled", tempFrameContainer, true);

		else
			-- Auto-Restock Reagents option
			tempObject = Lunar.Object:CreateCheckbox(10, -10, Lunar.Locale["AUTO_RESTOCK_REAGENTS"], "autoReagents", true, tempFrameContainer)
			tempObject:SetHitRectInsets(0, -190, 0, 0);

			-- Grab reagents from bank option
			tempObject = Lunar.Object:CreateCheckbox(30, -26, Lunar.Locale["REAGENTS_FROM_BANK"], "autoReagentsBank", true, tempFrameContainer);
			tempObject:SetHitRectInsets(0, -190, 0, 0);

			-- Print the purchase summary option
			tempObject = Lunar.Object:CreateCheckbox(10, -42, Lunar.Locale["PRINT_PURCHASE_REPORT"], "printReagentPurchase", true, tempFrameContainer);
			tempObject:SetHitRectInsets(0, -190, 0, 0);

			-- Confirm purchase over 10 gold option
			tempObject = Lunar.Object:CreateCheckbox(10, -58, Lunar.Locale["CONFIRM_OVER_10"], "confirmOver10", true, tempFrameContainer);
			tempObject:SetHitRectInsets(0, -190, 0, 0);
			_G[tempObject:GetName() .. "Text"]:SetVertexColor(0.5,0.5,0.5);

			-- Create "Item / Reagents" Caption
			tempObject = Lunar.Object:CreateCaption(24, -78, 100, 20, "|cFFFFFFFF"..Lunar.Locale["ITEM_REAGENT"], "itemsReagents", tempFrameContainer);

			-- Create "Restock Count" Caption
			tempObject = Lunar.Object:CreateCaption(150, -78, 100, 20, "|cFFFFFFFF"..Lunar.Locale["MAX_COUNT"], "restockCount", tempFrameContainer);
			tempObject:ClearAllPoints();
			tempObject:SetPoint("TopRight", tempFrameContainer, "TopRight", 10, -78);

			-- Create border of list
			tempObject = Lunar.Object:Create("container", "LSReagentBorder", tempFrameContainer, "", 190, 128, 0.1, 0.1, 0.1)
			tempObject:SetPoint("TopLeft", tempFrameContainer, "TopLeft", 10, -98);
			tempObject:SetFrameLevel(tempFrameContainer:GetFrameLevel() + 1);
			tempObject:EnableMouse("true");
			tempObject:EnableMouseWheel("true");
			tempObject.scrollerName = "LSSettingsReagentSlider";
			tempObject:SetScript("OnMouseWheel", Lunar.Settings.OnMouseWheelScroll);

			-- Create border of scroller
			tempObject = Lunar.Object:Create("container", "LSReagentScrollerBorder", tempFrameContainer, "", 31, 128, 0.1, 0.1, 0.1)
			tempObject:ClearAllPoints();
			tempObject:SetPoint("TopRight", tempFrameContainer, "TopRight", -10, -98);
			tempObject:SetFrameLevel(_G["LSReagentBorder"]:GetFrameLevel() + 1);
			tempObject:SetFrameLevel(tempFrameContainer:GetFrameLevel() + 2);
			tempObject:EnableMouseWheel("true");
			tempObject.scrollerName = "LSSettingsReagentSlider";
			tempObject:SetScript("OnMouseWheel", Lunar.Settings.OnMouseWheelScroll);

			-- Create slider bar
			tempObject = CreateFrame("Slider", "LSSettingsReagentSlider", tempFrameContainer, "LunarVerticalSlider");

			tempObject:SetPoint("TopRight", tempFrameContainer, "TopRight", -18, -104);
			tempObject:SetWidth(15);
			tempObject:SetHeight(116);
			tempObject:SetFrameLevel(tempFrameContainer:GetFrameLevel() + 3);
			tempObject:SetValueStep(1);
			tempObject:Show();
			tempObject:SetScript("OnValueChanged", Lunar.Settings.UpdateReagentList);

			tempObject:SetScript("OnShow", Lunar.Settings.UpdateReagentList);

			for index = 1, 4 do 

				-- Create message text box
				tempObject = CreateFrame("EditBox", "LSReagentCount" .. index, tempFrameContainer, "LunarEditBox");

				tempObject:ClearAllPoints();
				tempObject:SetPoint("Topright", tempFrameContainer, "Topright", -42, -85 - (index * 27))
				tempObject:SetWidth(44);
				tempObject:SetNumeric(true);
				tempObject:SetMaxLetters(5);
				tempObject:SetID(index);
				tempObject:SetFrameLevel(tempFrameContainer:GetFrameLevel() + 3);
				tempObject:Show();

				tempObject:SetScript("OnTextChanged", Lunar.Settings.ReagentList_OnTextChanged);
				tempObject:SetScript("OnEnter", Lunar.Settings.ReagentList_OnEnter);
				tempObject:SetScript("OnLeave", Lunar.Settings.ReagentList_OnLeave);
				tempObject:SetScript("OnReceiveDrag", Lunar.Settings.ReagentList_OnReceiveDrag);
				tempObject:SetScript("OnMouseUp", Lunar.Settings.ReagentList_OnReceiveDrag);

				tempObject = Lunar.Object:CreateImage(20, -83 - index * 27, 24, 24, "ReagentIcon" .. index, tempFrameContainer, "$addon\\art\\mouse3");
				tempObject:SetID(index);
				tempObject:EnableMouse("true");
				tempObject:SetFrameLevel(tempFrameContainer:GetFrameLevel() + 3);
				tempObject:SetScript("OnReceiveDrag", Lunar.Settings.ReagentList_OnReceiveDrag);
				tempObject:SetScript("OnMouseUp", Lunar.Settings.ReagentList_OnReceiveDrag);
				tempObject:SetScript("OnEnter", Lunar.Settings.ReagentList_OnEnter);
				tempObject:SetScript("OnLeave", Lunar.Settings.ReagentList_OnLeave);

				tempObject = Lunar.Object:CreateCaption(52, -85 - index * 27, 90, 20, "", "ReagentName" .. index, tempFrameContainer, true);
				tempObject:ClearAllPoints();
				tempObject:EnableMouse("true");
				tempObject:SetFrameLevel(tempFrameContainer:GetFrameLevel() + 3);
				tempObject:SetPoint("TopLeft", tempFrameContainer, "TopLeft", 48, -84 - index * 27);
				tempObject:SetPoint("BottomRight", tempFrameContainer, "TopRight", -88, -110 - index * 27);
				tempObject:SetHitRectInsets(-5, -18, 0, 0);
				tempObject:SetID(index);
				_G[tempObject:GetName() .. "Text"]:SetWidth(96);
				_G[tempObject:GetName() .. "Text"]:SetHeight(26);
				_G[tempObject:GetName() .. "Text"]:SetJustifyH("Left");
				_G[tempObject:GetName() .. "Text"]:SetJustifyV("Top");
				tempObject:SetScript("OnReceiveDrag", Lunar.Settings.ReagentList_OnReceiveDrag);
				tempObject:SetScript("OnMouseUp", Lunar.Settings.ReagentList_OnReceiveDrag);
				tempObject:SetScript("OnEnter", Lunar.Settings.ReagentList_OnEnter);
				tempObject:SetScript("OnLeave", Lunar.Settings.ReagentList_OnLeave);

			end

			_G["LSReagentBorder"]:SetScript("OnReceiveDrag", Lunar.Settings.ReagentList_OnReceiveDrag);
			_G["LSReagentBorder"]:SetScript("OnMouseUp", Lunar.Settings.ReagentList_OnReceiveDrag);
			_G["LSReagentBorder"]:SetID(0);

			-- Create highlighter
			tempObject = Lunar.Object:CreateImage(20, -83 - 1 * 27, 170, 26, "ReagentHighlight", tempFrameContainer, "Interface\\HelpFrame\\HelpFrameButton-Highlight");
			tempObject:GetNormalTexture():SetTexCoord(0,1.0,0,0.578125);
			tempObject:GetNormalTexture():SetVertexColor(0,1,0);
			tempObject:GetNormalTexture():SetBlendMode("Add");
			tempObject:SetAlpha(0.3);
			tempObject:SetID(0);
			tempObject:Hide();
			tempObject:SetFrameLevel(tempFrameContainer:GetFrameLevel() + 2);

			-- Add instructions
			tempObject = Lunar.Object:CreateCaption(10, -236, 150, 210, Lunar.Locale["REAGENT_INSTRUCTIONS"], "reagentInstructions", tempFrameContainer, true);
			_G[tempObject:GetName() .. "Text"]:SetWidth(210);
			_G[tempObject:GetName() .. "Text"]:SetHeight(210);
			_G[tempObject:GetName() .. "Text"]:SetJustifyV("Top");
			_G[tempObject:GetName() .. "Text"]:SetJustifyH("Center");

		end

	-- Create our fifth tab container. This holds our "Inventory Settings"
	tempObject = Lunar.Object:Create("container", "LSSettingsMainTab1305Container", _G[tempFrame:GetName() .. "WindowContainer"], "", containerWidth, containerHeight);
	tempObject:SetPoint("Topleft", 92, -10);
	tempObject:SetFrameLevel(tempLevel + 15);
	tempObject:Hide();
	tempFrameContainer = tempObject;

		-- Create Vendor Caption
		tempObject = Lunar.Object:CreateCaption(10, -10, 150, 20, "|cFFFFFFFF"..Lunar.Locale["VENDOR_OPTIONS"], "vendorOptions", tempFrameContainer);

			if (LunarSphereSettings.memoryDisableJunk) then

				-- Create Disabled Caption
				tempObject = Lunar.Object:CreateCaption(20, -30, 100, 20, Lunar.Locale["MEMORY_DISABLED"], "memJunkDisabled", tempFrameContainer, true);

			else

				-- Auto-Sell Junk option
				tempObject = Lunar.Object:CreateCheckbox(10, -30, Lunar.Locale["AUTOSELL_JUNK"], "autoSellJunk", true, tempFrameContainer,
				function (self)
					LunarSphereSettings.autoSellJunk = (self:GetChecked() == true);
					Lunar.Settings:SetEnabled(_G["LSSettingsprintJunkProfit"], LunarSphereSettings.autoSellJunk);
					Lunar.Settings:SetEnabled(_G["LSSettingskeepNonEquip"], LunarSphereSettings.autoSellJunk);
					Lunar.Settings:SetEnabled(_G["LSSettingskeepWeapons"], LunarSphereSettings.autoSellJunk);
					Lunar.Settings:SetEnabled(_G["LSSettingskeepArmor"], LunarSphereSettings.autoSellJunk);
				end);
				tempObject:SetHitRectInsets(0, -135, 0, 0);

					-- Profit Printout option
					tempObject = Lunar.Object:CreateCheckbox(30, -46, Lunar.Locale["PRINT_PROFIT"], "printJunkProfit", true, tempFrameContainer);
					Lunar.Settings:SetEnabled(tempObject, LunarSphereSettings.autoSellJunk);

					-- Don't sell Non-equipable Items option
					tempObject = Lunar.Object:CreateCheckbox(30, -62, Lunar.Locale["KEEP_NON_EQUIP"], "keepNonEquip", true, tempFrameContainer);
					Lunar.Settings:SetEnabled(tempObject, LunarSphereSettings.autoSellJunk);

					-- Don't sell Weapons option
					tempObject = Lunar.Object:CreateCheckbox(30, -78, Lunar.Locale["KEEP_WEAPONS"], "keepWeapons", true, tempFrameContainer);
					Lunar.Settings:SetEnabled(tempObject, LunarSphereSettings.autoSellJunk);

					-- Don't sell Armor option
					tempObject = Lunar.Object:CreateCheckbox(30, -94, Lunar.Locale["KEEP_ARMOR"], "keepArmor", true, tempFrameContainer);
					Lunar.Settings:SetEnabled(tempObject, LunarSphereSettings.autoSellJunk);
			end

			sectionY = -114;

			if (LunarSphereSettings.memoryDisableRepairs) then

				-- Create Disabled Caption
				tempObject = Lunar.Object:CreateCaption(20, sectionY, 100, 20, Lunar.Locale["MEMORY_DISABLED"], "memRepairsDisabled", tempFrameContainer, true);

			else

				Lunar.Settings:CreateRepairLogDialog();

				-- Auto-Repair option (old y: -152)
				tempObject = Lunar.Object:CreateCheckbox(10, sectionY, Lunar.Locale["AUTO_REPAIR"], "autoRepair", true, tempFrameContainer,
				function (self)
					LunarSphereSettings.autoRepair = (self:GetChecked() == true);
					-- Gray-out the other checkboxes
					Lunar.Settings:SetEnabled(_G["LSSettingsprintRepairBill"], LunarSphereSettings.autoRepair);
					if (Lunar.API:GetBuildInfo() >= 23000 ) then
						Lunar.Settings:SetEnabled(_G["LSSettingsuseGuildFunds"], LunarSphereSettings.autoRepair);
					end
				end);
				tempObject:SetHitRectInsets(0, -80, 0, 0);

					-- View Repair Log button
					tempObject = Lunar.Object:CreateButton(116, sectionY, 100, "ViewRepairLog", Lunar.Locale["WINDOW_TITLE_REPAIRLOG"], tempFrameContainer,
					function()
						Lunar.Settings.RepairLogDialog:Hide();
						Lunar.Settings.RepairLogDialog:Show();
					end);

					-- Repair Bill Printout option
					tempObject = Lunar.Object:CreateCheckbox(30, sectionY - 18, Lunar.Locale["PRINT_REPAIR_BILL"], "printRepairBill", true, tempFrameContainer);
					Lunar.Settings:SetEnabled(tempObject, LunarSphereSettings.autoRepair);

					-- Use guild funds checkbox
					if (Lunar.API:GetBuildInfo() >= 23000 ) then
						tempObject = Lunar.Object:CreateCheckbox(30, sectionY - 34, Lunar.Locale["USE_GUILD_FUNDS"], "useGuildFunds", true, tempFrameContainer);
						Lunar.Settings:SetEnabled(tempObject, LunarSphereSettings.autoRepair);
					end
			end

			-- Bypass Gossip option
			tempObject = Lunar.Object:CreateCheckbox(10, sectionY - 50, Lunar.Locale["BYPASS_GOSSIP"], "skipGossip", true, tempFrameContainer);

			-- Create Mail Caption
			sectionY = -184;

			tempObject = Lunar.Object:CreateCaption(10, sectionY, 150, 20, "|cFFFFFFFF"..Lunar.Locale["MAIL_OPTIONS"], "mailOptions", tempFrameContainer);

				if (LunarSphereSettings.memoryDisableAHMail) then

					-- Create Disabled Caption
					tempObject = Lunar.Object:CreateCaption(20, sectionY - 20, 100, 20, Lunar.Locale["MEMORY_DISABLED"], "memAHMailDisabled", tempFrameContainer, true);

				else

					-- Grab all money mailing option
					tempObject = Lunar.Object:CreateCheckbox(10, sectionY - 20, Lunar.Locale["RETRIEVE_ALL_MONEY"], "getMailMoney", true, tempFrameContainer,
					function (self)
						LunarSphereSettings.getMailMoney = (self:GetChecked() == true);
						Lunar.API:GetMailSetup(LunarSphereSettings.getMailMoney, LunarSphereSettings.getMailItems);
					end);
					tempObject:SetHitRectInsets(0, -175, 0, 0);

					-- Grab all items mailing option
					tempObject = Lunar.Object:CreateCheckbox(10, sectionY - 36, Lunar.Locale["RETRIEVE_ALL_ITEMS"], "getMailItems", true, tempFrameContainer,
					function (self)
						LunarSphereSettings.getMailItems = (self:GetChecked() == true);
						Lunar.API:GetMailSetup(LunarSphereSettings.getMailMoney, LunarSphereSettings.getMailItems);
					end);
					tempObject:SetHitRectInsets(0, -175, 0, 0);

				end

--			-- Create AH Caption
--			sectionY = -240;
--			tempObject = Lunar.Object:CreateCaption(10, sectionY, 150, 20, "|cFFFFFFFF"..Lunar.Locale["AH_OPTIONS"], "ahOptions", tempFrameContainer);
--
--				if (LunarSphereSettings.memoryDisableAHTotals) then
--
--					-- Create Disabled Caption
--					tempObject = Lunar.Object:CreateCaption(20, sectionY - 18, 100, 20, Lunar.Locale["MEMORY_DISABLED"], "memAHTotalsDisabled", tempFrameContainer, true);
--
--				else
--						
--					-- Show bid totals option
--					tempObject = Lunar.Object:CreateCheckbox(10, sectionY - 18, Lunar.Locale["SHOW_TOTALS_AH"], "showTotalAH", true, tempFrameContainer,
--					function (self)
--						LunarSphereSettings.showTotalAH = (self:GetChecked() == true);
--						Lunar.API:ShowAuctionTotals((self:GetChecked() == true));
--					end);
--					tempObject:SetHitRectInsets(0, -175, 0, 0);
--
--				end

	-- Create our sixth tab container. This holds our "Speech Settings"
	tempObject = Lunar.Object:Create("container", "LSSettingsMainTab1306Container", _G[tempFrame:GetName() .. "WindowContainer"], "", containerWidth, containerHeight);
	tempObject:SetPoint("Topleft", 92, -10);
	tempObject:SetFrameLevel(tempLevel + 15);
	tempObject:Hide();
	tempFrameContainer = tempObject;

		sectionY = -20;

		if (LunarSphereSettings.memoryDisableSpeech) then

			-- Create Disabled Caption
			tempObject = Lunar.Object:CreateCaption(20, sectionY, 100, 20, Lunar.Locale["MEMORY_DISABLED"], "memSpeechDisabled", tempFrameContainer, true);

		else

			tempObject:SetScript("OnShow", Lunar.Settings.UpdateSpeechList);
					
			-- Current speech edit box
			tempObject = CreateFrame("EditBox", "LSSettingsScriptName", tempFrameContainer, "LunarEditBox");

			tempObject:SetPoint("Topleft", tempFrameContainer, "Topleft", 26, sectionY - 4)
			tempObject:SetWidth(166);
			tempObject:Hide();
			tempObject:SetFrameLevel(tempObject:GetFrameLevel() + 1);

			tempObject = Lunar.Object:CreateButton(9, sectionY - 26, 109, "ScriptSave", SAVE, tempFrameContainer,
			function(self)

				local dropdown = _G["LSSettingsscriptSelection"];
				local scriptName = _G["LSSettingsScriptName"]:GetText();
				local scriptID = dropdown.selectedValue;

				if (scriptName) and (scriptName ~= "")  then

					-- If the ID is 1, we are creating a new script. Otherwise, we're renaming

					local success;
					if (self:GetID() == 1) then
						success = Lunar.Speech:AddScriptToLibrary(scriptName);
						_G["LSSettingsglobalScript"]:SetChecked(false);
					else
						success = Lunar.Speech:RenameScriptInLibrary(_G[dropdown:GetName() .. "Text"]:GetText(), scriptName);
					end

					if (success) then
						_G[dropdown:GetName() .. "Text"]:SetText(scriptName);
						if (self:GetID() == 1) then
							scriptID = table.getn(LunarSpeechLibrary.script);
						end
					end

				end

				scriptName = _G[dropdown:GetName() .. "Text"]:GetText();
				dropdown:Hide();
				dropdown:Show();
				UIDropDownMenu_SetSelectedName(dropdown, scriptName);
				dropdown.selectedValue = scriptID;
				Lunar.Settings:ResetSpeechObjects()
				Lunar.Settings:UpdateSpeechList();
				Lunar.Settings:HideSaveCancelObjects()
			end);
			tempObject:SetFrameLevel(tempObject:GetFrameLevel() + 1);
			tempObject:Hide();

			tempObject = Lunar.Object:CreateButton(114, sectionY - 26, 109, "ScriptCancel", CANCEL, tempFrameContainer, Lunar.Settings.HideSaveCancelObjects);
			tempObject:SetFrameLevel(tempObject:GetFrameLevel() + 1);
			tempObject:Hide();

			-- Script selection dropdown
			tempObject = Lunar.Object:CreateDropdown(0, sectionY, 180, "scriptSelection", Lunar.Locale["_SCRIPTS_IN_LIBRARY"], "Speech_Database", "spellType", tempFrameContainer, Lunar.API.BlankFunction)

			tempObject = Lunar.Object:CreateButton(10, sectionY - 26, 72, "scriptNew", NEW, tempFrameContainer, Lunar.Settings.PrepNewRenameSettings);
			tempObject:SetID(1);

			tempObject = Lunar.Object:CreateButton(80, sectionY - 26, 72, "scriptRename", PET_RENAME, tempFrameContainer, Lunar.Settings.PrepNewRenameSettings);
			tempObject:SetID(2);		
			
			tempObject = Lunar.Object:CreateButton(150, sectionY - 26, 72, "scriptDelete", DELETE, tempFrameContainer,
			function()
				local dropdown = _G["LSSettingsscriptSelection"];
				local scriptID = dropdown.selectedValue;
				local success = Lunar.Speech:RemoveScriptFromLibrary(_G[dropdown:GetName() .. "Text"]:GetText());
				if (success) then
					if (scriptID > table.getn(LunarSpeechLibrary.script)) then
						scriptID = scriptID - 1;
					end
					_G["LSSettingsglobalScript"]:SetChecked(false);
					if (scriptID > 0) and not (LunarSpeechLibrary.script[scriptID].speeches) then
						_G["LSSettingsglobalScript"]:SetChecked(true);
					end
					UIDropDownMenu_SetSelectedValue(dropdown, scriptID);
					_G[dropdown:GetName() .. "Text"]:SetText(Lunar.Speech:GetScriptName(scriptID));
					Lunar.Settings:UpdateSpeechList(); 
				end
			end);

			tempObject = Lunar.Object:CreateButton(9, sectionY - 46, 109, "ScriptImport", Lunar.Locale["IMPORT"], tempFrameContainer,
			function()
				local dropdown = _G["LSSettingsscriptSelection"];
				Lunar.Speech:Import();
				dropdown:Hide();
				dropdown:Show();
				UIDropDownMenu_SetSelectedName(dropdown, Lunar.Speech:GetScriptName(1));
				dropdown.selectedValue = 1;
				Lunar.Settings:UpdateSpeechList();
			end);

			tempObject = Lunar.Object:CreateButton(114, sectionY - 46, 109, "ScriptExport", Lunar.Locale["EXPORT"], tempFrameContainer,
			function()
				Lunar.Speech:Export(true);
			end);

			-- Checkbox: Make script global
			tempObject = Lunar.Object:CreateCheckbox(10, sectionY - 66, Lunar.Locale["MAKE_SCRIPT_GLOBAL"], "globalScript", true, tempFrameContainer,
			function (self)
				local scriptID = _G["LSSettingsscriptSelection"].selectedValue;
				if (scriptID == 0) then
					self:SetChecked(false);
				end
				Lunar.Speech:ToggleGlobal(scriptID);	
				Lunar.Settings:UpdateSpeechList();
			end); 

			-- Create tabs for the speech tab (weee! more tabs ...)
			tempObject = Lunar.Object:Create("verticaltab", "LSSettingsSpeechMiniTab21", tempFrameContainer, Lunar.Locale["SPEECHES"]);
			_G[tempObject:GetName() .. "Text"]:SetJustifyH("CENTER");
			tempObject:SetPoint("Topleft", 8, -90 - 18);
			tempObject:SetWidth(112);
			tempObject:SetFrameLevel(tempObject:GetFrameLevel() + 4);
			tempObject:SetBackdropColor(0.0,0.5,1.0,1.0);
			tempObject = Lunar.Object:Create("verticaltab", "LSSettingsSpeechMiniTab22", tempFrameContainer, Lunar.Locale["SETTINGS"]);
			_G[tempObject:GetName() .. "Text"]:SetJustifyH("CENTER");
			tempObject:SetPoint("Topleft", 112, -90 - 18);
			tempObject:SetWidth(112);
			tempObject:SetFrameLevel(tempObject:GetFrameLevel() + 3);

			-- Container for scripts
			tempObject = Lunar.Object:Create("container", "LSSettingsSpeechMiniTab21Container", _G["LSSettingsMainTab1306Container"], "", containerWidth, containerHeight - 140 - 18);
			tempObject:SetPoint("Topleft", 0, -116 - 18);
			tempObject:SetFrameLevel(tempLevel + 15);
			tempObject:SetFrameLevel(tempObject:GetFrameLevel() + 15);
			tempFrameContainer = tempObject;

				sectionY = -4;

				-- Create Speeches in Script Caption
				tempObject = Lunar.Object:CreateCaption(10, sectionY, 100, 20, Lunar.Locale["_SPEECHES_IN_SCRIPT"], "speechesInScriptCaption", tempFrameContainer, true);

				-- Create border of list
				tempObject = Lunar.Object:Create("container", "LSSpeechBorder", tempFrameContainer, "", 194, 88, 0.1, 0.1, 0.1)
				tempObject:SetPoint("TopLeft", tempFrameContainer, "TopLeft", 8, sectionY - 17);
				tempObject:SetFrameLevel(tempFrameContainer:GetFrameLevel() + 1);
				tempObject:EnableMouse("true");
				tempObject:EnableMouseWheel("true");
				tempObject.scrollerName = "LSSettingsSpeechSlider";
				tempObject:SetScript("OnMouseWheel", Lunar.Settings.OnMouseWheelScroll);

				-- Create border of scroller
				tempObject = Lunar.Object:Create("container", "LSSpeechScrollerBorder", tempFrameContainer, "", 31, 88, 0.1, 0.1, 0.1)
				tempObject:ClearAllPoints();
				tempObject:SetPoint("TopRight", tempFrameContainer, "TopRight", -8, sectionY - 17);
				tempObject:SetFrameLevel(tempFrameContainer:GetFrameLevel() + 2);
				tempObject:EnableMouseWheel("true");
				tempObject.scrollerName = "LSSettingsSpeechSlider";
				tempObject:SetScript("OnMouseWheel", Lunar.Settings.OnMouseWheelScroll);

				-- Create slider bar
				tempObject = CreateFrame("Slider", "LSSettingsSpeechSlider", tempFrameContainer, "LunarVerticalSlider");

				tempObject:SetPoint("TopRight", tempFrameContainer, "TopRight", -16, sectionY - 23);
				tempObject:SetWidth(15);
				tempObject:SetHeight(76);
				tempObject:SetValueStep(1);
				tempObject:SetFrameLevel(tempFrameContainer:GetFrameLevel() + 3);
				tempObject:Show();
				tempObject:SetScript("OnValueChanged", Lunar.Settings.UpdateSpeechList);

				for index = 1, 5 do 

					tempObject = Lunar.Object:CreateCaption(20, sectionY - 7 - index * 15, 170, 15, "", "SpeechData" .. index, tempFrameContainer, true);
					tempObject:EnableMouse("true");
					tempObject:SetFrameLevel(tempFrameContainer:GetFrameLevel() + 3);
					tempObject:SetID(index);
					_G[tempObject:GetName() .. "Text"]:SetVertexColor(1,1,1);
					_G[tempObject:GetName() .. "Text"]:SetText("");
					_G[tempObject:GetName() .. "Text"]:SetWidth(170);
					_G[tempObject:GetName() .. "Text"]:SetHeight(15);

					tempObject:SetScript("OnMouseUp", Lunar.Settings.SpeechList_OnClick);
					tempObject:SetScript("OnEnter", Lunar.Settings.SpeechList_OnEnter);
					tempObject:SetScript("OnLeave", Lunar.Settings.SpeechList_OnLeave);

				end

				-- Create highlighter
				tempObject = Lunar.Object:CreateImage(15, sectionY - 24, 182, 15, "SpeechHighlight", tempFrameContainer, "Interface\\HelpFrame\\HelpFrameButton-Highlight");
				tempObject:GetNormalTexture():SetTexCoord(0,1.0,0,0.578125);
				tempObject:GetNormalTexture():SetVertexColor(0,1,0);
				tempObject:GetNormalTexture():SetBlendMode("Add");
				tempObject:SetAlpha(0.3);
				tempObject:SetID(0);
				tempObject:Hide();
				tempObject:SetFrameLevel(tempFrameContainer:GetFrameLevel() + 1);

				-- Create selected highlighter
				tempObject = Lunar.Object:CreateImage(15, sectionY - 24, 182, 15, "SpeechSelectedHighlight", tempFrameContainer, "Interface\\HelpFrame\\HelpFrameButton-Highlight");
				tempObject:GetNormalTexture():SetTexCoord(0,1.0,0,0.578125);
				tempObject:GetNormalTexture():SetVertexColor(0,1,0);
				tempObject:GetNormalTexture():SetBlendMode("Add");
				tempObject:SetAlpha(0.9);
				tempObject:SetID(0);
				tempObject:Hide();
				tempObject:SetFrameLevel(tempFrameContainer:GetFrameLevel() + 1);

				sectionY = -104; -- -304;

				-- Current speech caption
				tempObject = Lunar.Object:CreateCaption(10, sectionY, 100, 20, Lunar.Locale["CURRENT_SPEECH"], "currentSpeechCaption", tempFrameContainer, true);

				-- Current speech edit box
				tempObject = CreateFrame("EditBox", "LSSettingsCurrentSpeech", tempFrameContainer, "LunarEditBox");

				tempObject:SetPoint("Topleft", tempFrameContainer, "Topleft", 16, sectionY - 17)
				tempObject:SetWidth(206);
				tempObject:Show();

				tempObject = Lunar.Object:CreateButton(10, sectionY - 37, 72, "speechNew", ADD, tempFrameContainer,
				function(self)
					editbox = _G["LSSettingsCurrentSpeech"];
					local speech = editbox:GetText();
					if (string.len(speech) > 0) then
						local scriptName = Lunar.Speech:GetScriptName(UIDropDownMenu_GetSelectedValue(_G["LSSettingsscriptSelection"]));
						Lunar.Speech:AddSpeechToScript(scriptName, speech);
						Lunar.Settings:UpdateSpeechList();
						Lunar.Settings:ResetSpeechObjects();
					end
				end);

				tempObject = Lunar.Object:CreateButton(80, sectionY - 37, 72, "speechSave", SAVE, tempFrameContainer,
				function(self)
					editbox = _G["LSSettingsCurrentSpeech"];
					local speech = editbox:GetText();
					if (string.len(speech) > 0) then
						local highlight = _G["LSSettingsSpeechSelectedHighlight"];
						local scriptID = UIDropDownMenu_GetSelectedValue(_G["LSSettingsscriptSelection"]) or (1);
						local scriptName = Lunar.Speech:GetScriptName(scriptID);
						local speechID = highlight:GetID() + _G["LSSettingsSpeechSlider"]:GetValue();
						Lunar.Speech:EditSpeechInScript(scriptName, speechID, speech);
						Lunar.Settings:UpdateSpeechList();
						Lunar.Settings:ResetSpeechObjects();
					end
				end);
				tempObject:Disable();
				
				tempObject = Lunar.Object:CreateButton(150, sectionY - 37, 72, "speechDelete", DELETE, tempFrameContainer,
				function(self)
					editbox = _G["LSSettingsCurrentSpeech"];
					local speech = editbox:GetText();
					if (string.len(speech) > 0) then
						local scriptName = Lunar.Speech:GetScriptName(UIDropDownMenu_GetSelectedValue(_G["LSSettingsscriptSelection"]));
						Lunar.Speech:RemoveSpeechFromScript(scriptName, speech);
						Lunar.Settings:UpdateSpeechList();
						Lunar.Settings:ResetSpeechObjects();
					end
				end);
				tempObject:Disable();

			tempFrameContainer = _G["LSSettingsMainTab1306Container"];

			-- Container for script settings
			tempObject = Lunar.Object:Create("container", "LSSettingsSpeechMiniTab22Container", _G["LSSettingsMainTab1306Container"], "", containerWidth, containerHeight - 140 - 18);
			tempObject:SetPoint("Topleft", 0, -116 - 18);
			tempObject:SetFrameLevel(tempObject:GetFrameLevel() + 15);
			tempObject:Hide();
			tempFrameContainer = tempObject;

				sectionY = -18

				-- Action assignment dropdown
				tempObject = Lunar.Object:CreateDropdown(-8, sectionY, 110, "assignmentSelection", Lunar.Locale["ACTION_ASSIGNMENT"], "Speech_Assign", "spellType", tempFrameContainer,
				function(self)
					local scriptID = _G["LSSettingsscriptSelection"].selectedValue;
					if (scriptID) and (LunarSpeechLibrary.script[scriptID]) then

						-- If the icon was clicked, we assign the name to it for saving later
						local button = _G["LSSettingsassignmentEditButton"];

						local actionType = _G["LSSettingsassignmentSelection"].selectedValue;
						button.actionData = nil;
						if (actionType > 1) then
							button.actionData = Lunar.Speech.actionAssignNames[actionType];
						end
							
						local objectTexture = string.match((button.actionData or ("")), ":::(.*)") or ("");
						if (actionType == 0) then
							objectTexture = "";
							button.actionData = nil;
						end
						_G["LSSettingsassignmentActionIcon"]:SetTexture(objectTexture);
					end
				end);

				-- Action assignment box
				tempObject = Lunar.Object:CreateIconPlaceholder(139, sectionY - 1, "assignmentAction", tempFrameContainer, true);
				tempObject:SetWidth(24);
				tempObject:SetHeight(24);
				tempObject:GetNormalTexture():SetWidth(40);
				tempObject:GetNormalTexture():SetHeight(40);
				tempObject:SetScript("OnClick", Lunar.Object.SpeechIconPlaceHolder_OnClick)
				tempObject:SetScript("OnReceiveDrag", Lunar.Object.SpeechIconPlaceHolder_OnClick);

				-- Create add/save button
				tempObject = Lunar.Object:CreateButton(165, sectionY - 3, 56, "assignmentEditButton", ADD, tempFrameContainer, Lunar.Settings.ActionList_AddAction);

				-- Create border of list
				tempObject = Lunar.Object:Create("container", "LSAssignActionBorder", tempFrameContainer, "", 190, 78, 0.1, 0.1, 0.1)
				tempObject:SetPoint("TopLeft", tempFrameContainer, "TopLeft", 10, sectionY - 30);
				tempObject:SetFrameLevel(tempFrameContainer:GetFrameLevel() + 1);
				tempObject:EnableMouse("true");
				tempObject:EnableMouseWheel("true");
				tempObject.scrollerName = "LSSettingsAssignActionSlider";
				tempObject:SetScript("OnMouseWheel", Lunar.Settings.OnMouseWheelScroll);

				-- Create border of scroller
				tempObject = Lunar.Object:Create("container", "LSAssignActionScrollerBorder", tempFrameContainer, "", 31, 78, 0.1, 0.1, 0.1)
				tempObject:ClearAllPoints();
				tempObject:SetPoint("TopRight", tempFrameContainer, "TopRight", -10, sectionY - 30);
				tempObject:SetFrameLevel(_G["LSAssignActionBorder"]:GetFrameLevel() + 1);
				tempObject:SetFrameLevel(tempFrameContainer:GetFrameLevel() + 2);
				tempObject:EnableMouseWheel("true");
				tempObject.scrollerName = "LSSettingsAssignActionSlider";
				tempObject:SetScript("OnMouseWheel", Lunar.Settings.OnMouseWheelScroll);

				-- Create slider bar
				tempObject = CreateFrame("Slider", "LSSettingsAssignActionSlider", tempFrameContainer, "LunarVerticalSlider");

				tempObject:SetPoint("TopRight", tempFrameContainer, "TopRight", -18, sectionY - 36);
				tempObject:SetWidth(15);
				tempObject:SetHeight(66);
				tempObject:SetFrameLevel(tempFrameContainer:GetFrameLevel() + 3);
				tempObject:SetValueStep(1);
				tempObject:Show();
				tempObject:SetScript("OnValueChanged", Lunar.Settings.UpdateActionList);
				tempObject:SetScript("OnShow", Lunar.Settings.UpdateActionList);

				-- Create highlighter
				tempObject = Lunar.Object:CreateImage(20, sectionY - 30 - 1 * 20, 170, 20, "AssignActionHighlight", tempFrameContainer, "Interface\\HelpFrame\\HelpFrameButton-Highlight");
				tempObject:GetNormalTexture():SetTexCoord(0,1.0,0,0.578125);
				tempObject:GetNormalTexture():SetVertexColor(0,1,0);
				tempObject:GetNormalTexture():SetBlendMode("Add");
				tempObject:SetAlpha(0.3);
				tempObject:SetID(0);
				tempObject:Hide();
				tempObject:SetFrameLevel(tempFrameContainer:GetFrameLevel() + 2);
				tempObject.listItemName = "LSSettingsAssignActionIcon";

				for index = 1, 3 do 

					tempObject = Lunar.Object:CreateImage(20, sectionY - 20 - index * 20, 18, 18, "AssignActionIcon" .. index, tempFrameContainer, "$addon\\art\\mouse3");
					tempObject.highlight = _G["LSSettingsAssignActionHighlight"];
					tempObject:SetID(index);
					tempObject:EnableMouse("true");
					tempObject:SetFrameLevel(tempFrameContainer:GetFrameLevel() + 3);
					tempObject:SetHitRectInsets(0, 0, -2, -2);
					tempObject:SetScript("OnReceiveDrag", Lunar.Settings.ActionList_OnDragOrClick);
					tempObject:SetScript("OnMouseUp", Lunar.Settings.ActionList_OnDragOrClick);
					tempObject:SetScript("OnEnter", Lunar.Settings.List_OnEnter);
					tempObject:SetScript("OnLeave", Lunar.Settings.List_OnLeave);

					tempObject = Lunar.Object:CreateCaption(52, sectionY - 23 - index * 20, 90, 18, "", "AssignActionName" .. index, tempFrameContainer, true);
					tempObject.highlight = _G["LSSettingsAssignActionHighlight"];
					tempObject:ClearAllPoints();
					tempObject:EnableMouse("true");
					tempObject:SetFrameLevel(tempFrameContainer:GetFrameLevel() + 3);
					tempObject:SetPoint("TopLeft", tempFrameContainer, "TopLeft", 42, sectionY - 25 - index * 20);
					tempObject:SetPoint("BottomRight", tempFrameContainer, "TopRight", -30, sectionY - 38 - index * 20);
					tempObject:SetHitRectInsets(-6, 10, -5, -2);
					tempObject:SetID(index);
					_G[tempObject:GetName() .. "Text"]:SetWidth(140);
					_G[tempObject:GetName() .. "Text"]:SetHeight(18);
					_G[tempObject:GetName() .. "Text"]:SetJustifyH("Left");
					_G[tempObject:GetName() .. "Text"]:SetJustifyV("Top");
					tempObject:SetScript("OnReceiveDrag", Lunar.Settings.ActionList_OnDragOrClick);
					tempObject:SetScript("OnMouseUp", Lunar.Settings.ActionList_OnDragOrClick);
					tempObject:SetScript("OnEnter", Lunar.Settings.List_OnEnter);
					tempObject:SetScript("OnLeave", Lunar.Settings.List_OnLeave);

				end

				_G["LSAssignActionBorder"]:SetScript("OnReceiveDrag", Lunar.Settings.ActionList_OnDragOrClick);
				_G["LSAssignActionBorder"]:SetScript("OnMouseUp", Lunar.Settings.ActionList_OnDragOrClick);
				_G["LSAssignActionBorder"]:SetID(-1);

				-- Add instructions
				tempObject = Lunar.Object:CreateCaption(10, sectionY - 108, 150, 16, Lunar.Locale["CTRL_CLICK_TO_DELETE"], "actionListInstructions", tempFrameContainer, true);
				_G[tempObject:GetName() .. "Text"]:SetWidth(210);
				_G[tempObject:GetName() .. "Text"]:SetHeight(16);
				_G[tempObject:GetName() .. "Text"]:SetJustifyV("Top");
				_G[tempObject:GetName() .. "Text"]:SetJustifyH("Center");

				sectionY = -140;

				-- Create Chat Channel Caption
				tempObject = Lunar.Object:CreateCaption(10, sectionY, 100, 20, CHAT_CHANNELS .. ":", "chatChannels", tempFrameContainer, true);

				-- Channel assignment dropdown
				tempObject = Lunar.Object:CreateDropdown(84, sectionY, 102, "channelSelection", "", "Speech_Channels", "channelType", tempFrameContainer,
				function(self)
					local scriptID = _G["LSSettingsscriptSelection"].selectedValue;
					if (scriptID) and (LunarSpeechLibrary.script[scriptID]) then
						LunarSpeechLibrary.script[scriptID].channelName = _G["LSSettingschannelSelection"].selectedValue
					end
				end);

				-- Create display odds caption
				tempObject = Lunar.Object:CreateCaption(10, sectionY - 26, 60, 20, Lunar.Locale["ODDS"] .. ":", "scriptOddsCaption", tempFrameContainer, true);

				-- Script display odds slider
				tempObject = Lunar.Object:CreateSlider(70, sectionY - 28, "", "scriptOdds", tempFrameContainer, 0, 100, 1,
				function (self) 
					local scriptID = _G["LSSettingsscriptSelection"].selectedValue;
					if (scriptID) and (LunarSpeechLibrary.script[scriptID]) then
						LunarSpeechLibrary.script[scriptID].runProbability = self:GetValue();
					end
				end, true);
				_G[tempObject:GetName() .. "Value"]:SetPoint("Topleft", tempObject, "Topright", 7, 1);
				tempObject:SetWidth(90);

				-- Pick speeches in order checkbox
				tempObject = Lunar.Object:CreateCheckbox(10, sectionY - 44, Lunar.Locale["PICK_IN_ORDER"], "inOrder", true, tempFrameContainer,
				function (self)
					local scriptID = _G["LSSettingsscriptSelection"].selectedValue;
					if (scriptID) and (LunarSpeechLibrary.script[scriptID]) then
						LunarSpeechLibrary.script[scriptID].inOrder = self:GetChecked();
					end
				end);

			tempFrameContainer = _G["LSSettingsMainTab1306Container"];

			-- Checkbox: Mute Speech Module 
			tempObject = Lunar.Object:CreateCheckbox(10, -346, Lunar.Locale["MUTE_SPEECH_TAB"], "muteSpeech", true, tempFrameContainer); 
	
		end

	-- Create our seventh tab container. This holds our "Skin Settings"
	tempObject = Lunar.Object:Create("container", "LSSettingsMainTab1307Container", _G[tempFrame:GetName() .. "WindowContainer"], "", containerWidth, containerHeight);
	tempObject:SetPoint("Topleft", 92, -10);
	tempObject:SetFrameLevel(tempLevel + 15);
	tempObject:Hide();
	tempFrameContainer = tempObject;

		sectionY = -20;

		if (LunarSphereSettings.memoryDisableSkins) then

			-- Create Disabled Caption
			tempObject = Lunar.Object:CreateCaption(20, sectionY, 100, 20, Lunar.Locale["MEMORY_DISABLED"], "memSkinsDisabled", tempFrameContainer, true);

		else

			Lunar.Settings:CreateImportArtDialog();

			-- Skin to modify dropdown list
			tempObject = Lunar.Object:CreateDropdown(0, -20, 180, "skinEditMode", Lunar.Locale["SKIN_TO_EDIT"], "Skin_Edit_Types", "currentSkinEdit", tempFrameContainer,
			function(self)
				LunarSphereSettings.currentSkinEdit = self.value;
				Lunar.Settings.UpdateSkinOptions();
				Lunar.Settings.UpdateTextureList();
			end);

			-- Create Texture Selection Caption
			tempObject = Lunar.Object:CreateCaption(10, -45, 150, 20, "|cFFFFFFFF"..Lunar.Locale["TEXTURES"], "textures", tempFrameContainer);

			-- Create border of list
			tempObject = Lunar.Object:Create("container", "LSTextureListBorder", tempFrameContainer, "", 190, 86, 1, 0.0, 0.0)
			tempObject:SetPoint("TopLeft", tempFrameContainer, "TopLeft", 10, -65);
			tempObject:SetFrameLevel(tempFrameContainer:GetFrameLevel() + 1);
			tempObject:EnableMouse("true");
			tempObject:EnableMouseWheel("true");
			tempObject.scrollerName = "LSTextureScrollerSlider";
			tempObject:SetScript("OnMouseWheel", Lunar.Settings.OnMouseWheelScroll);

			-- Create border of scroller
			tempObject = Lunar.Object:Create("container", "LSTextureScrollerBorder", tempFrameContainer, "", 31, 86, 0.1, 0.1, 0.1)
			tempObject:ClearAllPoints();
			tempObject:SetPoint("TopRight", tempFrameContainer, "TopRight", -10, -65);
			tempObject:SetFrameLevel(_G["LSTextureListBorder"]:GetFrameLevel() + 1);
			tempObject:SetFrameLevel(tempFrameContainer:GetFrameLevel() + 2);
			tempObject:EnableMouseWheel("true");
			tempObject.scrollerName = "LSTextureScrollerSlider";
			tempObject:SetScript("OnMouseWheel", Lunar.Settings.OnMouseWheelScroll);

			-- Create slider bar
			tempObject = CreateFrame("Slider", "LSTextureScrollerSlider", tempFrameContainer, "LunarVerticalSlider");

			tempObject:SetPoint("TopRight", tempFrameContainer, "TopRight", -18, -71);
			tempObject:SetWidth(15);
			tempObject:SetHeight(74);
			tempObject:SetValueStep(1);
			tempObject:SetFrameLevel(tempFrameContainer:GetFrameLevel() + 3);
			tempObject:Show();
			tempObject:SetScript("OnValueChanged", Lunar.Settings.UpdateTextureList);
			tempObject:SetScript("OnShow", tempObject:GetScript("OnValueChanged"));

			local xLoc, yLoc;

			for yLoc = 0, 1 do 
				for xLoc = 0, 4 do 

					tempObject = Lunar.Object:CreateImage(19 + xLoc * 35, -75 - yLoc * 35, 32, 32, "TextureIcon" .. (xLoc + (yLoc * 5) + 1), tempFrameContainer, "$addon\\art\\buttonSkin_29");
					tempObject:SetID(xLoc + (yLoc * 5) + 1);
					tempObject:EnableMouse("true");
					tempObject:SetFrameLevel(tempFrameContainer:GetFrameLevel() + 3);
					if ((xLoc == 0) and (yLoc == 0)) then
						tempObject:SetScript("OnMouseDown",
						function (self)
							if (IsControlKeyDown()) then
								local artID = _G["LSTextureScrollerSlider"]:GetValue() * 5 + self:GetID();
								if (LunarSphereSettings.currentSkinEdit == 0) then
									if (LunarSphereSettings.sphereSkin > (Lunar.includedSpheres + LUNAR_EXTRA_SPHERE_ICON_COUNT)) then
										if (artID < LunarSphereSettings.sphereSkin) then
											LunarSphereSettings.sphereSkin = LunarSphereSettings.sphereSkin - 1;
										elseif (artID == LunarSphereSettings.sphereSkin) then
											LunarSphereSettings.sphereSkin = 1;
										end
									end
									artID = Lunar.API:GetArtByCatagoryIndex("sphere", artID - Lunar.includedSpheres - LUNAR_EXTRA_SPHERE_ICON_COUNT);
									Lunar.API:RemoveArt("", artID);
									Lunar.Sphere:SetSphereTexture(LunarSphereSettings.sphereSkin);
								elseif (LunarSphereSettings.currentSkinEdit == 1) then
									if (LunarSphereSettings.buttonSkin > Lunar.includedButtons) then
										if (artID < LunarSphereSettings.buttonSkin) then
											LunarSphereSettings.buttonSkin = LunarSphereSettings.buttonSkin - 1;
										elseif (artID == LunarSphereSettings.buttonSkin) then
											LunarSphereSettings.buttonSkin = 1;
										end
									end
									artID = Lunar.API:GetArtByCatagoryIndex("button", artID - Lunar.includedButtons);
									Lunar.API:RemoveArt("", artID);
									Lunar.Button:UpdateSkin(LUNAR_ART_PATH .. "buttonSkin_" .. LunarSphereSettings.buttonSkin .. ".blp");
								elseif (LunarSphereSettings.currentSkinEdit == 2) then
									if (LunarSphereSettings.gaugeFill > Lunar.includedGauges) then
										if (artID < LunarSphereSettings.gaugeFill) then
											LunarSphereSettings.gaugeFill = LunarSphereSettings.gaugeFill - 1;
										elseif (artID == LunarSphereSettings.gaugeFill) then
											LunarSphereSettings.gaugeFill = 1;
										end
									end
									artID = Lunar.API:GetArtByCatagoryIndex("gauge", artID - Lunar.includedGauges);
									Lunar.API:RemoveArt("", artID);
									Lunar.Sphere:UpdateSkin("gauge", LUNAR_ART_PATH .. "gaugeFill_" .. LunarSphereSettings.gaugeFill .. ".blp");
								elseif (LunarSphereSettings.currentSkinEdit == 3) then
									if (LunarSphereSettings.gaugeBorder > Lunar.includedBorders) then
										if (artID < LunarSphereSettings.gaugeBorder) then
											LunarSphereSettings.gaugeBorder = LunarSphereSettings.gaugeBorder - 1;
										elseif (artID == LunarSphereSettings.gaugeBorder) then
											LunarSphereSettings.gaugeBorder = 1;
										end
									end
									artID = Lunar.API:GetArtByCatagoryIndex("border", artID - Lunar.includedBorders);
									Lunar.API:RemoveArt("", artID);
									Lunar.Sphere:UpdateSkin("border", LUNAR_ART_PATH .. "gaugeBorder_" .. LunarSphereSettings.gaugeBorder .. ".blp");
								end

								Lunar.Settings:UpdateTextureList();
							else
								local xLoc, yLoc;
								yLoc = math.floor((self:GetID() - 1) / 5);
								xLoc = self:GetID() - (yLoc * 5) - 1;
								_G["LSSettingsTextureSelector"]:SetPoint("Topleft", 18 + xLoc * 35, -74 - yLoc * 35);
								_G["LSSettingsTextureSelector"]:Show();
								if (LunarSphereSettings.currentSkinEdit == 0) then
									Lunar.Sphere:SetSphereTexture(_G["LSTextureScrollerSlider"]:GetValue() * 5 + self:GetID());
								elseif (LunarSphereSettings.currentSkinEdit == 1) then
									LunarSphereSettings.buttonSkin = _G["LSTextureScrollerSlider"]:GetValue() * 5 + self:GetID();

									-- Included art
									if (LunarSphereSettings.buttonSkin <= Lunar.includedButtons) then
										Lunar.Button:UpdateSkin(LUNAR_ART_PATH .. "buttonSkin_" .. LunarSphereSettings.buttonSkin .. ".blp");
									
									-- custom import art
									else
										local artIndex, artType, width, height, artFilename = Lunar.API:GetArtByCatagoryIndex("button", LunarSphereSettings.buttonSkin - Lunar.includedButtons);
										if (artFilename) then
											Lunar.Button:UpdateSkin(LUNAR_IMPORT_PATH .. artFilename);
										end
									end	
								elseif (LunarSphereSettings.currentSkinEdit == 2) then
									LunarSphereSettings.gaugeFill = _G["LSTextureScrollerSlider"]:GetValue() * 5 + self:GetID();
									Lunar.Sphere:UpdateSkin("gaugeFill");
								elseif (LunarSphereSettings.currentSkinEdit == 3) then
									LunarSphereSettings.gaugeBorder = _G["LSTextureScrollerSlider"]:GetValue() * 5 + self:GetID();
									Lunar.Sphere:UpdateSkin("gaugeBorder");
								end
							end
						end);

						tempObject = CreateFrame("PlayerModel", "LSSettingsSkin3D", tempFrameContainer, BackdropTemplateMixin and "BackdropTemplate");

						tempObject:SetWidth(32);
						tempObject:SetHeight(32);
						tempObject:SetScript("OnUpdate", function (self) self:SetCamera(0) end);
						tempObject:EnableMouse("true");
						tempObject:SetFrameLevel(tempFrameContainer:GetFrameLevel() + 3);
						tempObject:SetScript("OnMouseDown", _G["LSSettingsTextureIcon1"]:GetScript("OnMouseDown"));
						tempObject:Hide();

					else
						tempObject:SetScript("OnMouseDown", _G["LSSettingsTextureIcon1"]:GetScript("OnMouseDown"));
					end

					-- Create highlighter
					tempObject = Lunar.Object:CreateImage(19 + xLoc * 35, -75 - yLoc * 35, 32, 32, "TextureIcon" .. (xLoc + (yLoc * 5) + 1) .. "Border", tempFrameContainer, "Interface\\Buttons\\CheckButtonHilight");
					tempObject:GetNormalTexture():SetVertexColor(0,0,1);
					tempObject:GetNormalTexture():SetBlendMode("Add");
					tempObject:EnableMouse(false);
					tempObject:SetAlpha(1);
					tempObject:Show();
					tempObject:SetFrameLevel(tempFrameContainer:GetFrameLevel() + 5);

				end
			end

			-- Create selected highlighter
			tempObject = Lunar.Object:CreateImage(19, -75, 34, 34, "TextureSelector", tempFrameContainer, "Interface\\Buttons\\CheckButtonHilight");
			tempObject:GetNormalTexture():SetVertexColor(0,0.5,1);
			tempObject:GetNormalTexture():SetVertexColor(1,0.5,0);
			tempObject:GetNormalTexture():SetBlendMode("Add");
			tempObject:SetAlpha(1);
			tempObject:Hide();
			tempObject:SetFrameLevel(tempFrameContainer:GetFrameLevel() + 4);

			-- Add import instructions
			tempObject = Lunar.Object:CreateCaption(10, -300, 150, 210, Lunar.Locale["INSTRUCTIONS_IMPORT"], "importInstructions", tempFrameContainer, true);
			_G[tempObject:GetName() .. "Text"]:SetWidth(210);
			_G[tempObject:GetName() .. "Text"]:SetHeight(210);
			_G[tempObject:GetName() .. "Text"]:SetJustifyV("Top");
			_G[tempObject:GetName() .. "Text"]:SetJustifyH("Center");

			-- Create import button
			tempObject = Lunar.Object:CreateButton(36, -280, 128, "ImportArtButton", Lunar.Locale["WINDOW_TITLE_IMPORTART"], tempFrameContainer,
			function(self)
				local tempDropdown = _G["LSSettingsimportArtType"];
				_G["LSSettingsImportArtFilenameTextbox"]:SetText("");
				UIDropDownMenu_SetSelectedValue(tempDropdown, LunarSphereSettings.currentSkinEdit)
				Lunar.Settings.ImportArtDialog:Show();
			end);
			tempObject:ClearAllPoints();
			tempObject:SetPoint("BOTTOM", tempFrameContainer, "BOTTOM", 0, 80);

			-- Setup extra settings for sphere
			-- *******************************

				-- Show sphere shine
				tempObject = Lunar.Object:CreateCheckbox(10, -155, Lunar.Locale["SHOW_SPHERE_SHINE"], "showSphereShine", true, tempFrameContainer,
				function(self) 
					Lunar.Sphere:ShowSphereShine(self:GetChecked() == true); 
				end);

				-- Sphere color changing objects
				tempObject = Lunar.Object:CreateColorSelector(24, -185, Lunar.Locale["SPHERE_COLOR"], "sphereColor", tempFrameContainer, function() Lunar.Sphere:SetSphereColor() end);

				tempObject = Lunar.Object:CreateButton(135, -182, 80, "DefaultSphereColor", Lunar.Locale["DEFAULT"], tempFrameContainer,
				function(self)
					LunarSphereSettings.sphereColor[1] = 1;
					LunarSphereSettings.sphereColor[2] = 1;
					LunarSphereSettings.sphereColor[3] = 1;
					_G["LSSettingssphereColorColor"]:SetColorTexture(1,1,1);
					Lunar.Sphere:SetSphereColor();
				end);

				-- Use sphere click icon
				tempObject = Lunar.Object:CreateCheckbox(10, -210, Lunar.Locale["USE_SPHERE_CLICK_ICON"], "useSphereClickIcon", true, tempFrameContainer,
				function (self)
					LunarSphereSettings.useSphereClickIcon = (self:GetChecked() == true);
					Lunar.Sphere:SetSphereTexture();
				end);

				-- Use random sphere texture option
				tempObject = Lunar.Object:CreateCheckbox(10, -225, Lunar.Locale["SPHERE_TEXTURE_RANDOM"], "randomSphereTexture", true, tempFrameContainer,
				function (self)
					LunarSphereSettings.randomSphereTexture = (self:GetChecked() == true);
					if (self:GetChecked() == true) then
						Lunar.Sphere:SetSphereTexture(math.random(1, (Lunar.includedSpheres + LUNAR_EXTRA_SPHERE_ICON_COUNT + Lunar.API:GetArtCount("sphere"))));
						Lunar.Settings.UpdateTextureList();
					end
				end);

			-- Setup extra settings for buttons
			-- ********************************

				-- Show button shine
				tempObject = Lunar.Object:CreateCheckbox(10, -155, Lunar.Locale["SHOW_BUTTON_SHINE"], "showButtonShine", true, tempFrameContainer,
				function(self) 
					Lunar.Button:ShowButtonShine(self:GetChecked() or false); 
				end);

				-- Button Border Color
				tempObject = Lunar.Object:CreateColorSelector(24, -185, Lunar.Locale["NORMAL_BUTTON_COLOR"], "buttonColor", tempFrameContainer, Lunar.Button.UpdateButtonColors);

				tempObject = Lunar.Object:CreateButton(135, -182, 80, "DefaultButtonColor", Lunar.Locale["DEFAULT"], tempFrameContainer,
				function(self)
					LunarSphereSettings.buttonColor[1] = 1;
					LunarSphereSettings.buttonColor[2] = 1;
					LunarSphereSettings.buttonColor[3] = 1;
					_G["LSSettingsbuttonColorColor"]:SetColorTexture(1,1,1);
					Lunar.Button:UpdateButtonColors();
				end);

				-- Menu Button Border Color
				tempObject = Lunar.Object:CreateColorSelector(24, -215, Lunar.Locale["MENU_BUTTON_COLOR"], "menuButtonColor", tempFrameContainer,
				function(self)
					Lunar.Button:UpdateButtonColors(true);
				end);

				tempObject = Lunar.Object:CreateButton(135, -212, 80, "DefaultMenuButtonColor", Lunar.Locale["DEFAULT"], tempFrameContainer,
				function(self)
					LunarSphereSettings.menuButtonColor[1] = 0.3;
					LunarSphereSettings.menuButtonColor[2] = 0.6;
					LunarSphereSettings.menuButtonColor[3] = 1;
					_G["LSSettingsmenuButtonColorColor"]:SetColorTexture(0.3,0.6,1);
					Lunar.Button:UpdateButtonColors(true);
				end);

			-- Setup extra settings for Gauges
			-- ************************************

				-- Create No Images Caption
--				tempObject = Lunar.Object:CreateCaption(20, -75, 150, 20, "|cFFFFFFFF"..Lunar.Locale["NO_IMAGES_AVAILABLE"], "noImages", tempFrameContainer);

				-- Show outer gauge shine
				tempObject = Lunar.Object:CreateCheckbox(10, -155, Lunar.Locale["SHOW_OUTER_GAUGE_SHINE"], "showOuterGaugeShine", true, tempFrameContainer,
				function(self) 
					Lunar.Sphere:ShowGaugeShines((_G["LSSettingsshowInnerGaugeShine"]:GetChecked() or false), (_G["LSSettingsshowOuterGaugeShine"]:GetChecked() or false)); 
				end);

				-- Show inner gauge shine
				tempObject = Lunar.Object:CreateCheckbox(10, -175, Lunar.Locale["SHOW_INNER_GAUGE_SHINE"], "showInnerGaugeShine", true, tempFrameContainer, _G["LSSettingsshowOuterGaugeShine"]:GetScript("OnClick"));

--				function() 
--					Lunar.Sphere:ShowGaugeShines((self:GetChecked() or false), nil); 
--				end);


			-- Setup extra settings for Borders
			-- ************************************

				-- Border color selector
				tempObject = Lunar.Object:CreateColorSelector(24, -165, Lunar.Locale["BORDER_COLOR"], "gaugeBorderColor", tempFrameContainer, Lunar.Sphere.UpdateSkin);
--				function()
--					Lunar.Button:UpdateButtonColors(true);
--				end);

				-- Show gauge shine
--				tempObject = Lunar.Object:CreateCheckbox(10, -155, Lunar.Locale["SHOW_INNER_GAUGE_SHINE"], "showInnerGaugeShine", true, tempFrameContainer,
--				function() 
--					Lunar.Sphere:ShowGaugeShines((self:GetChecked() or false), nil); 
--				end);

		end

	-- Create our eighth tab container. This holds our "Tooltips Settings"
	tempObject = Lunar.Object:Create("container", "LSSettingsMainTab1308Container", _G[tempFrame:GetName() .. "WindowContainer"], "", containerWidth, containerHeight);
	tempObject:SetPoint("Topleft", 92, -10);
	tempObject:SetFrameLevel(tempLevel + 15);
	tempObject:Hide();
	tempFrameContainer = tempObject;

		sectionY = -10

		-- Create Tooltip Display Caption
		tempObject = Lunar.Object:CreateCaption(10, sectionY, 150, 20, "|cFFFFFFFF"..Lunar.Locale["TOOLTIP_TYPE"], "tooltipType", tempFrameContainer);

			-- Tooltip type: normal
			tempObject = Lunar.Object:CreateRadio(10, sectionY - 18, VOICE_CHAT_NORMAL, "tooltipType", 1, tempFrameContainer)
			tempObject:SetHitRectInsets(0, -82, 0, 0);

			-- Tooltip type: name only
			tempObject = Lunar.Object:CreateRadio(104, sectionY - 18, Lunar.Locale["TOOLTIP_TYPE_NAME"], "tooltipType", 2, tempFrameContainer)
			tempObject:SetHitRectInsets(0, -82, 0, 0);

			-- Tooltip type: simple
			tempObject = Lunar.Object:CreateRadio(10, sectionY - 34, Lunar.Locale["TOOLTIP_TYPE_SIMPLE"], "tooltipType", 3, tempFrameContainer)
			tempObject:SetHitRectInsets(0, -82, 0, 0);

			-- Tooltip type: none
			tempObject = Lunar.Object:CreateRadio(104, sectionY - 34, NONE, "tooltipType", 0, tempFrameContainer)
			tempObject:SetHitRectInsets(0, -82, 0, 0);

		sectionY = -57

		-- Create Tooltip Descriptions Caption
		tempObject = Lunar.Object:CreateCaption(10, sectionY, 150, 20, "|cFFFFFFFF"..Lunar.Locale["TOOLTIP_DESCRIPTIONS"], "tooltipDisplay", tempFrameContainer);

			-- Hide keybinds
			tempObject = Lunar.Object:CreateCheckbox(10, sectionY - 15, Lunar.Locale["TOOLTIPS_HIDE_KEYBINDS"], "hideKeybindTooltips", true, tempFrameContainer); --,

			-- Hide yellow text
			tempObject = Lunar.Object:CreateCheckbox(10, sectionY - 30, Lunar.Locale["HIDE_YELLOW_TEXT"], "hideYellowTooltips", true, tempFrameContainer,
			function (self)
				local value = (self:GetChecked() == true);
				LunarSphereSettings.hideYellowTooltips = value;
				Lunar.Settings:SetEnabled(_G["LSSettingsyellowTooltipType0"], value);
				Lunar.Settings:SetEnabled(_G["LSSettingsyellowTooltipType1"], value);
			end);

				-- All yellow text
				tempObject = Lunar.Object:CreateRadio(20, sectionY - 48, ALL, "yellowTooltipType", 0, tempFrameContainer)
				tempObject:SetHitRectInsets(0, -42, 0, 0);
				Lunar.Settings:SetEnabled(tempObject, LunarSphereSettings.hideYellowTooltips);

				-- Just long yellow text
				tempObject = Lunar.Object:CreateRadio(82, sectionY - 48, Lunar.Locale["HIDE_LONG_TEXT_ONLY"], "yellowTooltipType", 1, tempFrameContainer)
				Lunar.Settings:SetEnabled(tempObject, LunarSphereSettings.hideYellowTooltips);

			-- Hide green text
			tempObject = Lunar.Object:CreateCheckbox(10, sectionY - 63, Lunar.Locale["HIDE_GREEN_TEXT"], "hideGreenTooltips", true, tempFrameContainer,
			function (self)
				local value = (self:GetChecked() == true);
				LunarSphereSettings.hideGreenTooltips = value;
				Lunar.Settings:SetEnabled(_G["LSSettingsgreenTooltipType0"], value);
				Lunar.Settings:SetEnabled(_G["LSSettingsgreenTooltipType1"], value);
			end);

				-- All green text
				tempObject = Lunar.Object:CreateRadio(20, sectionY - 81, ALL, "greenTooltipType", 0, tempFrameContainer)
				tempObject:SetHitRectInsets(0, -42, 0, 0);
				Lunar.Settings:SetEnabled(tempObject, LunarSphereSettings.hideGreenTooltips);

				-- Just long green text
				tempObject = Lunar.Object:CreateRadio(82, sectionY - 81, Lunar.Locale["HIDE_LONG_TEXT_ONLY"], "greenTooltipType", 1, tempFrameContainer)
				Lunar.Settings:SetEnabled(tempObject, LunarSphereSettings.hideGreenTooltips);

		sectionY = -150

		-- Create Tooltip Colors Caption
		tempObject = Lunar.Object:CreateCaption(10, sectionY, 150, 20, "|cFFFFFFFF"..Lunar.Locale["TOOLTIP_COLOR"], "tooltipColor", tempFrameContainer);

			-- Tooltip border color changer
			tempObject = Lunar.Object:CreateColorSelector(16, sectionY - 26, Lunar.Locale["TOOLTIP_BORDER"], "tooltipBorder", tempFrameContainer, Lunar.API.BlankFunction, true);

			tempObject = Lunar.Object:CreateButton(135, sectionY - 4, 80, "DefaultTooltipColors", Lunar.Locale["DEFAULT"], tempFrameContainer,
			function(self)
				local i;
				local db = LunarSphereSettings.tooltipBorder;
				for i = 1, 4 do 
					db[i] = 1;
				end
				_G["LSSettingstooltipBorderColor"]:SetColorTexture(db[1], db[2], db[3]);
				db = LunarSphereSettings.tooltipBackground;
				db[1] = 0.05;
				db[2] = 0.05;
				db[3] = 0.10;
				db[4] = 0.75;
				_G["LSSettingstooltipBackgroundColor"]:SetColorTexture(db[1], db[2], db[3]);
			end);


			-- Tooltip background color changer
			tempObject = Lunar.Object:CreateColorSelector(112, sectionY - 26, Lunar.Locale["TOOLTIP_BACKGROUND"], "tooltipBackground", tempFrameContainer, Lunar.API.BlankFunction, true);

			-- Apply skin to LunarSphere tooltips
			tempObject = Lunar.Object:CreateCheckbox(10, sectionY - 46, Lunar.Locale["TOOLTIP_APPLY_TO_LS"], "skinTooltips", true, tempFrameContainer,
			function (self)
				LunarSphereSettings.skinTooltips = (self:GetChecked() == true);
				Lunar.Settings:SetEnabled(_G["LSSettingsskinAllTooltips"], LunarSphereSettings.skinTooltips);
				if (LunarSphereSettings.skinTooltips ~= true) and (Lunar.origBackdrop) then
					GameTooltip:SetBackdrop(Lunar.origBackdrop);
					GameTooltip:SetBackdropColor(unpack(Lunar.origBackdropColor));
					GameTooltip:SetBackdropBorderColor(unpack(Lunar.origBackdropBorderColor));
				end
			end);

				-- Apply skin to all tooltips
				tempObject = Lunar.Object:CreateCheckbox(30, sectionY - 61, Lunar.Locale["TOOLTIP_APPLY_TO_ALL"], "skinAllTooltips", true, tempFrameContainer);
				Lunar.Settings:SetEnabled(_G["LSSettingsskinAllTooltips"], LunarSphereSettings.skinTooltips);

			-- Create the "Fade out tooltip" option
			tempObject = Lunar.Object:CreateCheckbox(10, sectionY - 76, Lunar.Locale["TOOLTIP_FADE_OUT"], "fadeOutTooltips", true, tempFrameContainer);


		sectionY = -240

		-- Create LS Tooltip Anchor Caption
		tempObject = Lunar.Object:CreateCaption(10, sectionY, 150, 20, "|cFFFFFFFF"..Lunar.Locale["ANCHOR_MODE"], "tooltipAnchorModeLS", tempFrameContainer);

			-- LS Anchor type dropdown list
			tempObject = Lunar.Object:CreateDropdown(0, sectionY - 18, 180, "anchorModeLS", "", "Anchor_Dropdown", "anchorModeLS", tempFrameContainer,
			function(self)
				LunarSphereSettings.anchorModeLS = self.value;
				-- enable or disable the buttons
			end);

			-- Show/Hide LunarSphere Anchor
			tempObject = Lunar.Object:CreateButton(16, sectionY - 44, 140, "anchorShowLS", Lunar.Locale["_SHOW_ANCHOR"], tempFrameContainer,
			function(self)
				if (self.on) then
					self:SetText(Lunar.Locale["_SHOW_ANCHOR"]);
					_G["LSSettingsLSAnchor"]:Hide();	
					self.on = nil;
				else
					self:SetText(Lunar.Locale["_HIDE_ANCHOR"]);
					_G["LSSettingsLSAnchor"]:Show();	
					self.on = true;
				end
			end);

			tempObject = Lunar.Object:CreateButton(154, sectionY - 44, 60, "anchorResetLS", RESET, tempFrameContainer,
			function(self)
				local anchor = _G["LSSettingsLSAnchor"];
				anchor:ClearAllPoints();
				anchor:SetPoint("Center");
			
				local point, relativeTo, relativePoint, xOfs, yOfs, settingName;
				point, relativeTo, relativePoint, xOfs, yOfs = anchor:GetPoint();
				LunarSphereSettings.anchorCornerLSrelativePoint = relativePoint;
				LunarSphereSettings.anchorCornerLSxOfs = xOfs;
				LunarSphereSettings.anchorCornerLSyOfs = yOfs;

			end);

		sectionY = -305 -- -307

		-- Create GameTooltip Anchor Caption
		tempObject = Lunar.Object:CreateCaption(10, sectionY, 150, 20, "|cFFFFFFFF"..Lunar.Locale["TOOLTIP_ANCHOR"], "tooltipAnchorMode", tempFrameContainer);

			-- Apply skin to all tooltips
			tempObject = Lunar.Object:CreateCheckbox(10, sectionY - 16, Lunar.Locale["TOOLTIP_SET_DEFAULT"], "anchorMode", true, tempFrameContainer);

			-- Show/Hide LunarSphere Anchor
			tempObject = Lunar.Object:CreateButton(16, sectionY - 34, 140, "anchorShow", Lunar.Locale["_SHOW"], tempFrameContainer,
			function(self)
				if (self.on) then
					self:SetText(Lunar.Locale["_SHOW"]);
					_G["LSSettingsAnchor"]:Hide();	
					self.on = nil;
				else
					self:SetText(HIDE);
					_G["LSSettingsAnchor"]:Show();	
					self.on = true;
				end
			end);

			tempObject = Lunar.Object:CreateButton(154, sectionY - 34, 60, "anchorReset", RESET, tempFrameContainer,
			function(self)
				local anchor = _G["LSSettingsAnchor"];
				anchor:ClearAllPoints();
				anchor:SetPoint("TOPLEFT", "UIParent", "BOTTOMRIGHT", -CONTAINER_OFFSET_X - 13, CONTAINER_OFFSET_Y + 9);
			
				local point, relativeTo, relativePoint, xOfs, yOfs, settingName;
				point, relativeTo, relativePoint, xOfs, yOfs = anchor:GetPoint();
				LunarSphereSettings.anchorCornerrelativePoint = relativePoint;
				LunarSphereSettings.anchorCornerxOfs = xOfs;
				LunarSphereSettings.anchorCorneryOfs = yOfs;

			end);

	-- Create our nineth tab container. This holds our "Templates Settings"
	tempObject = Lunar.Object:Create("container", "LSSettingsMainTab1309Container", _G[tempFrame:GetName() .. "WindowContainer"], "", containerWidth, containerHeight);
	tempObject:SetPoint("Topleft", 92, -10);
	tempObject:SetFrameLevel(tempLevel + 15);
	tempObject:Hide();
	tempFrameContainer = tempObject;
	tempObject:SetScript("OnShow", Lunar.Settings.UpdateTemplateList);

		-- Create teaser =)
--		tempObject = Lunar.Object:CreateCaption(60, -115, 150, 20, "I'm such a tease ...\n   (Coming soon)", "templateTeaser", tempFrameContainer);

		sectionY = -20;

		if (LunarSphereSettings.memoryDisableTemplates) then

			-- Create Disabled Caption
			tempObject = Lunar.Object:CreateCaption(20, sectionY, 100, 20, Lunar.Locale["MEMORY_DISABLED"], "memTemplatesDisabled", tempFrameContainer, true);

		else
				
			sectionY = -4;

			-- Create Template List Caption
			tempObject = Lunar.Object:CreateCaption(10, sectionY, 100, 20, Lunar.Locale["_TEMPLATE_LIST"], "templateListCaption", tempFrameContainer, true);

				-- Create border of list
				tempObject = Lunar.Object:Create("container", "LSTemplateListBorder", tempFrameContainer, "", 194, 163, 0.1, 0.1, 0.1)
				tempObject:SetPoint("TopLeft", tempFrameContainer, "TopLeft", 8, sectionY - 17);
				tempObject:SetFrameLevel(tempFrameContainer:GetFrameLevel() + 1);
				tempObject:EnableMouse("true");
				tempObject:EnableMouseWheel("true");
				tempObject.scrollerName = "LSSettingsTemplateListSlider";
				tempObject:SetScript("OnMouseWheel", Lunar.Settings.OnMouseWheelScroll);

				-- Create border of scroller
				tempObject = Lunar.Object:Create("container", "LSTemplateListScrollerBorder", tempFrameContainer, "", 31, 163, 0.1, 0.1, 0.1)
				tempObject:ClearAllPoints();
				tempObject:SetPoint("TopRight", tempFrameContainer, "TopRight", -8, sectionY - 17);
				tempObject:SetFrameLevel(tempFrameContainer:GetFrameLevel() + 2);
				tempObject:EnableMouseWheel("true");
				tempObject.scrollerName = "LSSettingsTemplateListSlider";
				tempObject:SetScript("OnMouseWheel", Lunar.Settings.OnMouseWheelScroll);

				-- Create slider bar
				tempObject = CreateFrame("Slider", "LSSettingsTemplateListSlider", tempFrameContainer, "LunarVerticalSlider");

				tempObject:SetPoint("TopRight", tempFrameContainer, "TopRight", -16, sectionY - 23);
				tempObject:SetWidth(15);
				tempObject:SetHeight(151);
				tempObject:SetValueStep(1);
				tempObject:SetFrameLevel(tempFrameContainer:GetFrameLevel() + 3);
				tempObject:Show();
				tempObject:SetScript("OnValueChanged", Lunar.Settings.UpdateTemplateList);

				-- Create highlighter
				tempObject = Lunar.Object:CreateImage(15, sectionY - 24, 182, 30, "TemplateListHighlight", tempFrameContainer, "Interface\\HelpFrame\\HelpFrameButton-Highlight");
				tempObject:GetNormalTexture():SetTexCoord(0,1.0,0,0.578125);
				tempObject:GetNormalTexture():SetVertexColor(0,1,0);
				tempObject:GetNormalTexture():SetBlendMode("Add");
				tempObject:SetAlpha(0.3);
				tempObject:SetID(0);
				tempObject:Hide();
				tempObject:SetFrameLevel(tempFrameContainer:GetFrameLevel() + 1);
				tempObject.listItemName = "LSSettingsTemplateData";
				local tempName, tempClass, tempOptions;
				for index = 1, 5 do 
					tempName, tempClass, tempOptions = string.match(Lunar.Settings.templateList[index] or (""), "(.*):::(.*):::(.*)");
					tempObject = Lunar.Object:CreateCaption(15, sectionY - 9 + 15 - index * 30, 170, 15, "", "TemplateData" .. index, tempFrameContainer, true);
					tempObject:EnableMouse("true");
					tempObject:SetFrameLevel(tempFrameContainer:GetFrameLevel() + 3);
					tempObject:SetHitRectInsets(0, 0, 0, -15);
					tempObject:SetID(index);
					tempObject.highlight = _G["LSSettingsTemplateListHighlight"];
					_G[tempObject:GetName() .. "Text"]:SetVertexColor(1,1,1);
					_G[tempObject:GetName() .. "Text"]:SetText(tempName);
					_G[tempObject:GetName() .. "Text"]:SetWidth(170);
					_G[tempObject:GetName() .. "Text"]:SetHeight(15);

					tempObject:SetScript("OnMouseUp", Lunar.Settings.TemplateList_OnClick);
					tempObject:SetScript("OnEnter", Lunar.Settings.List_OnEnter);
					tempObject:SetScript("OnLeave", Lunar.Settings.List_OnLeave);

					tempObject = Lunar.Object:CreateCaption(15, sectionY - 9 - index * 30, 170, 15, "", "TemplateData" .. index .. "Class", tempFrameContainer, true);
					tempObject:SetFrameLevel(tempFrameContainer:GetFrameLevel() + 3);
					_G[tempObject:GetName() .. "Text"]:SetVertexColor(0.6,0.6,1);
					_G[tempObject:GetName() .. "Text"]:SetText("   - " .. (tempClass or ("")));
					_G[tempObject:GetName() .. "Text"]:SetWidth(170);
					_G[tempObject:GetName() .. "Text"]:SetHeight(15);

				end

				-- Create selected highlighter
				tempObject = Lunar.Object:CreateImage(15, sectionY - 24, 182, 30, "TemplateListSelectedHighlight", tempFrameContainer, "Interface\\HelpFrame\\HelpFrameButton-Highlight");
				tempObject:GetNormalTexture():SetTexCoord(0,1.0,0,0.578125);
				tempObject:GetNormalTexture():SetVertexColor(0,1,0);
				tempObject:GetNormalTexture():SetBlendMode("Add");
				tempObject:SetAlpha(0.9);
				tempObject:SetID(0);
				tempObject:Hide();
				tempObject:SetFrameLevel(tempFrameContainer:GetFrameLevel() + 1);

				-- Create "Save" button
				tempObject = Lunar.Object:CreateButton(10, sectionY - 182, 72, "templateSave", SAVE, tempFrameContainer,
				function (self)
					local dialog = Lunar.Settings.TemplateHandlerDialog;
					local selector = _G["LSSettingsTemplateListSelectedHighlight"];

					dialog:Hide();

					-- If there is a template selected, we auto-fill the data with
					-- the currently selected template's info
					dialog.loading = nil;

					if (selector:GetID() ~= 0) then
						dialog.loadName, dialog.loadClass, dialog.loadOptions , dialog.loadSize = string.match(Lunar.Settings.templateList[selector:GetID()] or (""), "(.*):::(.*):::(.*):::(.*)");
					else
						dialog.loadName = nil;
						dialog.loadOptions = nil;
						dialog.loadClass = nil;
						dialog.loadSize = nil;
					end
--					selector:Hide();
--					selector:SetID(0);

					dialog:Show();

				end);

				-- Create "Load" template button
				tempObject = Lunar.Object:CreateButton(80, sectionY - 182, 72, "templateLoad", Lunar.Locale["_LOAD"], tempFrameContainer,
				function (self)
					local dialog = Lunar.Settings.TemplateHandlerDialog;
					dialog:Hide();
					local id = _G["LSSettingsTemplateListSelectedHighlight"]:GetID();
					if (id > 0) then
						id = id + _G["LSSettingsTemplateListSlider"]:GetValue();
						dialog.loading = true;
						dialog.loadName, dialog.loadClass, dialog.loadOptions, dialog.loadSize = string.match(Lunar.Settings.templateList[id] or (""), "(.*):::(.*):::(.*):::(.*)");
						dialog:Show();
					end
				end);
				tempObject:Disable();

				-- Create "Delete" template button
				tempObject = Lunar.Object:CreateButton(150, sectionY - 182, 72, "templateDelete", DELETE, tempFrameContainer,
				function (self)
					local id = _G["LSSettingsTemplateListSelectedHighlight"]:GetID() + _G["LSSettingsTemplateListSlider"]:GetValue();
--					local exportID, index;
					local index;
					for index = 1, #LunarSphereExport.template do 
						if (LunarSphereExport.template[index].listData == Lunar.Settings.templateList[id]) then
							if (LunarSphereSettings.dualTemplate1 == Lunar.Settings.templateList[id]) then
								LunarSphereSettings.dualTemplate1 = nil;
							end
							if (LunarSphereSettings.dualTemplate2 == Lunar.Settings.templateList[id]) then
								LunarSphereSettings.dualTemplate2 = nil;
							end
							table.remove(LunarSphereExport.template, index);
--							exportID = index;
							break;
						end
					end
					table.remove(Lunar.Settings.templateList, id);

					-- if the ID existed, because it was a user made template that the user has in their
					-- export file (not in their import file), delete it
--					if (exportID) then
--						table.remove(LunarSphereExport.template, exportID);
--					end
					Lunar.Settings:UpdateTemplateList();
				end);
				tempObject:Disable();

				-- Create "Primary" template button
				tempObject = Lunar.Object:CreateButton(10, sectionY - 182 - 20, 108, "templatePrimary", PRIMARY, tempFrameContainer,
				function (self)
					local id = _G["LSSettingsTemplateListSelectedHighlight"]:GetID();
					if (id > 0) then
						id = id + _G["LSSettingsTemplateListSlider"]:GetValue();
						-- Enable or disable
						if (LunarSphereSettings.dualTemplate1 == Lunar.Settings.templateList[id]) then
							LunarSphereSettings.dualTemplate1 = nil;
						else
							LunarSphereSettings.dualTemplate1 = Lunar.Settings.templateList[id];
						end
						Lunar.Settings:UpdateTemplateList();
					end
				end);
				tempObject:Disable();

				-- Create "Secondary" template button
				tempObject = Lunar.Object:CreateButton(114, sectionY - 182 - 20, 108, "templateSecondary", SECONDARY, tempFrameContainer,
				function (self)
					local id = _G["LSSettingsTemplateListSelectedHighlight"]:GetID();
					if (id > 0) then
						id = id + _G["LSSettingsTemplateListSlider"]:GetValue();
						-- Enable or disable
						if (LunarSphereSettings.dualTemplate2 == Lunar.Settings.templateList[id]) then
							LunarSphereSettings.dualTemplate2 = nil;
						else
							LunarSphereSettings.dualTemplate2 = Lunar.Settings.templateList[id];
						end
						Lunar.Settings:UpdateTemplateList();
					end
				end);
				tempObject:Disable();

				tempObject = CreateFrame("Button", "LSSettingsDualSpecWarning", _G["LSSettingstemplatePrimary"], BackdropTemplateMixin and "BackdropTemplate");

				tempObject:SetWidth(216);
				tempObject:SetHeight(20);
				tempObject:ClearAllPoints();
				tempObject:SetPoint("TOPLEFT");
				tempObject:SetScript("OnEnter", function(self)
					if (LunarSphereSettings.enableTemplateHotswapping) then
						return;
					end
					GameTooltip:SetOwner(self, "ANCHOR_CURSOR");
					GameTooltip:SetText(Lunar.Locale["_TEMPLATES_DUAL_TOOLTIP"]);
					GameTooltip:Show();
				end);
				tempObject:SetScript("OnLeave", function()
					GameTooltip:Hide();
				end);
				tempObject:SetFrameLevel(tempObject:GetFrameLevel() + 1);
				if not LunarSphereSettings.enableTemplateHotswapping then
					tempObject:Show();
				else
					tempObject:Hide();
				end

				-- Create Template Help Caption
				tempObject = Lunar.Object:CreateCaption(14, sectionY - 208 - 20 , 200, 90, Lunar.Locale["TEMPLATE_HELP"], "templateHelpCaption", tempFrameContainer, true);
				_G[tempObject:GetName() .. "Text"]:SetWidth(200);
				_G[tempObject:GetName() .. "Text"]:SetHeight(90);
				_G[tempObject:GetName() .. "Text"]:SetJustifyV("Top");
				_G[tempObject:GetName() .. "Text"]:SetJustifyH("Center");

				-- Enable template hotswapping
				tempObject = Lunar.Object:CreateCheckbox(10, sectionY - 208 - 20 - 30, Lunar.Locale["TEMPLATE_HOTSWAP"], "enableTemplateHotswapping", true, tempFrameContainer,
				function (self)
					LunarSphereSettings.enableTemplateHotswapping = (self:GetChecked() == true)
					if (LunarSphereSettings.enableTemplateHotswapping == true) then
						ReloadUI();
					else
						Lunar.Template = nil;
						Lunar.Button.ReloadAllButtons = nil;
						_G["LSSettingsDualSpecWarning"]:Show();
						_G["LSSettingstemplatePrimary"]:Disable();
						_G["LSSettingstemplateSecondary"]:Disable();
					end
				end);
				tempObject:SetHitRectInsets(0, -90, 0, 0);

			sectionY = -294;

			-- Create Backup Options Caption
			tempObject = Lunar.Object:CreateCaption(10, sectionY - 2, 104, 20, "|cFFFFFFFF"..Lunar.Locale["BACKUP_OPTIONS"], "backupOptionsCaption", tempFrameContainer);

				-- Create "Create" backup button
				tempObject = Lunar.Object:CreateButton(10, sectionY - 22, 72, "backupCreate", CREATE, tempFrameContainer,
				function (self)
					LunarSphereSettings.backupSize = nil;
					LunarSphereSettings.backupDB = nil;

					Lunar.Memory:PrepareForCalculation("tempSize");
					LunarSphereSettings.backupDB = Lunar.API:CopyTable(LunarSphereSettings);
					local total = Lunar.Memory:Calculate();
					Lunar.Memory.memoryData.tempSize = nil;

					total = tostring(math.floor(total * 10)/10)
					LunarSphereSettings.backupSize = total;
					local text = _G["LSSettingsbackupCurrentSizeCaptionText"]
					text:SetText(string.gsub(Lunar.Locale["_CURRENT_BACKUP_SIZE"], "%%d", total));
					text:GetParent():Show();
					Lunar.Settings:SetEnabled(_G["LSSettingsbackupRestore"], true);
					Lunar.Settings:SetEnabled(_G["LSSettingsbackupDelete"], true);
				end);

				-- Create "Restore" backup button
				tempObject = Lunar.Object:CreateButton(80, sectionY - 22, 72, "backupRestore", Lunar.Locale["RESTORE"], tempFrameContainer,
				function (self)
					if (LunarSphereSettings.backupDB) then
						local backupDB = Lunar.API:CopyTable(LunarSphereSettings.backupDB);
						local backupSize = LunarSphereSettings.backupSize;
						LunarSphereSettings = LunarSphereSettings.backupDB;
						LunarSphereSettings.backupDB = backupDB;
						LunarSphereSettings.backupSize = backupSize;
						ReloadUI();
					end
				end);
				Lunar.Settings:SetEnabled(tempObject, (LunarSphereSettings.backupSize ~= nil));

				-- Create "Delete" backup button
				tempObject = Lunar.Object:CreateButton(150, sectionY - 22, 72, "backupDelete", DELETE, tempFrameContainer,
				function(self)
					LunarSphereSettings.backupDB = nil;
					LunarSphereSettings.backupSize = nil;
					_G["LSSettingsbackupCurrentSizeCaption"]:Hide();
					collectgarbage();
					Lunar.Settings:SetEnabled(_G["LSSettingsbackupRestore"]);
					Lunar.Settings:SetEnabled(_G["LSSettingsbackupDelete"]);
				end);
				Lunar.Settings:SetEnabled(tempObject, (LunarSphereSettings.backupSize ~= nil));

				-- Create Backup Memory Used Caption
				tempObject = Lunar.Object:CreateCaption(10, sectionY - 46 , 100, 30, Lunar.Locale["_CURRENT_BACKUP_SIZE"], "backupCurrentSizeCaption", tempFrameContainer, true);
				_G[tempObject:GetName() .. "Text"]:SetWidth(210);
				_G[tempObject:GetName() .. "Text"]:SetHeight(30);
				_G[tempObject:GetName() .. "Text"]:SetJustifyV("Top");
				_G[tempObject:GetName() .. "Text"]:SetJustifyH("Center");
				if not LunarSphereSettings.backupSize then
					tempObject:Hide();
				else
					_G[tempObject:GetName() .. "Text"]:SetText(string.gsub(Lunar.Locale["_CURRENT_BACKUP_SIZE"], "%%d", LunarSphereSettings.backupSize));
				end

		end
	-- Create our tenth tab container. This holds our "Other Settings"
	tempObject = Lunar.Object:Create("container", "LSSettingsMainTab1310Container", _G[tempFrame:GetName() .. "WindowContainer"], "", containerWidth, containerHeight);
	tempObject:SetPoint("Topleft", 92, -10);
	tempObject:SetFrameLevel(tempLevel + 15);
	tempObject:Hide();
	tempFrameContainer = tempObject;

		-- Create Hide Default UI Objects Caption
		tempObject = Lunar.Object:CreateCaption(10, -10, 150, 20, "|cFFFFFFFF"..Lunar.Locale["HIDE_DEFAULT_UI_OBJECTS"], "hideDefaultUIObjects", tempFrameContainer);

			if (LunarSphereSettings.memoryDisableDefaultUI) then

				-- Create Disabled Caption
				tempObject = Lunar.Object:CreateCaption(20, -30, 100, 20, Lunar.Locale["MEMORY_DISABLED"], "memDefaultUIDisabled", tempFrameContainer, true);

			else

				-- Create Disabled Caption
				tempObject = Lunar.Object:CreateCaption(20, -30, 100, 20, "Section disabled while in combat", "InCombatHideUI", tempFrameContainer, true);
				tempObject:Hide();

				-- Hide Player Frame option
				tempObject = Lunar.Object:CreateCheckbox(10, -30, Lunar.Locale["HIDE_PLAYER"], "hidePlayer", true, tempFrameContainer,
				function (self)
					LunarSphereSettings.hidePlayer = (self:GetChecked() == true)
					Lunar.API:HidePlayerFrame((self:GetChecked() == true));
				tempObject:SetHitRectInsets(0, -90, 0, 0);
				end);

				-- Hide entire minimap
				tempObject = Lunar.Object:CreateCheckbox(10, -46, Lunar.Locale["HIDE_MINIMAP"], "hideMinimap", true, tempFrameContainer,
				function (self)
					LunarSphereSettings.hideMinimap = (self:GetChecked() == true)
					Lunar.API:HideMinimap((self:GetChecked() == true));
				end);
				tempObject:SetHitRectInsets(0, -90, 0, 0);

				-- Hide Time of Day option
				tempObject = Lunar.Object:CreateCheckbox(10, -62, Lunar.Locale["HIDE_TIME"], "hideTime", true, tempFrameContainer,
				function (self)
					LunarSphereSettings.hideTime = (self:GetChecked() == true)
					Lunar.API:HideMinimapTime((self:GetChecked() == true));
				end);
				tempObject:SetHitRectInsets(0, -90, 0, 0);

				-- Hide Zoom option
				tempObject = Lunar.Object:CreateCheckbox(10, -78, Lunar.Locale["HIDE_ZOOM"], "hideZoom", true, tempFrameContainer,
				function (self)
					LunarSphereSettings.hideZoom = (self:GetChecked() == true)
					Lunar.API:HideMinimapZoom((self:GetChecked() == true));
				end);
				tempObject:SetHitRectInsets(0, -90, 0, 0);

				-- Hide Worldmap Button
				tempObject = Lunar.Object:CreateCheckbox(10, -94, Lunar.Locale["HIDE_WORLDMAP"], "hideWorldmap", true, tempFrameContainer,
				function (self)
					LunarSphereSettings.hideWorldmap = (self:GetChecked() == true)
					Lunar.API:HideWorldmap((self:GetChecked() == true));
				end);
				tempObject:SetHitRectInsets(0, -90, 0, 0);

				-- Hide Calendar option
				tempObject = Lunar.Object:CreateCheckbox(10, -110, Lunar.Locale["HIDE_CALENDAR"], "hideCalendar", true, tempFrameContainer,
				function (self)
					LunarSphereSettings.hideCalendar = (self:GetChecked() == true)
					Lunar.API:HideCalendar((self:GetChecked() == true));
				end);
				tempObject:SetHitRectInsets(0, -90, 0, 0);

				-- Hide Pet Bar option
				tempObject = Lunar.Object:CreateCheckbox(10, -126, Lunar.Locale["HIDE_TRACKING"], "hideTracking", true, tempFrameContainer,
				function (self)
					LunarSphereSettings.hideTracking = (self:GetChecked() == true)
					Lunar.API:HideTracking((self:GetChecked() == true));
				end);
				tempObject:SetHitRectInsets(0, -90, 0, 0);

				-- Hide EXP option
				tempObject = Lunar.Object:CreateCheckbox(10, -142, Lunar.Locale["HIDE_EXP"], "hideEXP", true, tempFrameContainer,
				function (self)
					LunarSphereSettings.hideEXP = (self:GetChecked() == true)
					Lunar.API:HideExpBars((self:GetChecked() == true));
				end);
				tempObject:SetHitRectInsets(0, -90, 0, 0);

				-- Hide Gryphons option
				tempObject = Lunar.Object:CreateCheckbox(120, -30, Lunar.Locale["HIDE_GRYPHONS"], "hideGryphons", true, tempFrameContainer,
				function (self)
					LunarSphereSettings.hideGryphons = (self:GetChecked() == true)
					Lunar.API:HideGryphons((self:GetChecked() == true));
				end);

				-- Hide Menus option
				tempObject = Lunar.Object:CreateCheckbox(120, -46, Lunar.Locale["HIDE_MENUS"], "hideMenus", true, tempFrameContainer,
				function (self)
					LunarSphereSettings.hideMenus = (self:GetChecked() == true)
					Lunar.API:HideMenus((self:GetChecked() == true));
				end);

				-- Hide Bags option
				tempObject = Lunar.Object:CreateCheckbox(120, -62, Lunar.Locale["HIDE_BAGS"], "hideBags", true, tempFrameContainer,
				function (self)
					LunarSphereSettings.hideBags = (self:GetChecked() == true)
					Lunar.API:HideBags((self:GetChecked() == true));
				end);

				-- Hide Bottom Bar option
				tempObject = Lunar.Object:CreateCheckbox(120, -78, Lunar.Locale["HIDE_BOTTOM_BAR"], "hideBottomBar", true, tempFrameContainer,
				function (self)
					LunarSphereSettings.hideBottomBar = (self:GetChecked() == true)
					Lunar.API:HideBottomBar((self:GetChecked() == true));
				end);

				-- Hide Action Buttons option
				tempObject = Lunar.Object:CreateCheckbox(120, -94, Lunar.Locale["HIDE_ACTION_BUTTONS"], "hideActions", true, tempFrameContainer,
				function (self)
					LunarSphereSettings.hideActions = (self:GetChecked() == true)
					Lunar.API:HideActionButtons((self:GetChecked() == true));
				end);
				tempObject:SetHitRectInsets(0, -90, 0, 0);

				-- Hide Stance Bar option
				tempObject = Lunar.Object:CreateCheckbox(120, -110, Lunar.Locale["HIDE_STANCE_BAR"], "hideStance", true, tempFrameContainer,
				function (self)
					LunarSphereSettings.hideStance = (self:GetChecked() == true)
					Lunar.API:HideStanceBar((self:GetChecked() == true));
				end);
				tempObject:SetHitRectInsets(0, -90, 0, 0);

				-- Hide Pet Bar option
				tempObject = Lunar.Object:CreateCheckbox(120, -126, Lunar.Locale["HIDE_PET_BAR"], "hidePetBar", true, tempFrameContainer,
				function (self)
					LunarSphereSettings.hidePetBar = (self:GetChecked() == true)
					Lunar.API:HidePetBar((self:GetChecked() == true));
				end);
				tempObject:SetHitRectInsets(0, -90, 0, 0);

				--[[ Hide Totem Bar option --No longer exists in game
				tempObject = Lunar.Object:CreateCheckbox(120, -142, Lunar.Locale["HIDE_TOTEMBAR"], "hideTotemBar", true, tempFrameContainer,
				function (self)
					LunarSphereSettings.hideTotemBar = (self:GetChecked() == true);
					Lunar.API:HideTotemBar((self:GetChecked() == true));
				end);
				tempObject:SetHitRectInsets(0, -90, 0, 0);--]]

			end

		sectionY = -158;
		-- Create Add to Minimap Caption
		tempObject = Lunar.Object:CreateCaption(10, sectionY, 150, 20, "|cFFFFFFFF"..Lunar.Locale["ADD_TO_MINIMAP"], "addToMinimap", tempFrameContainer);

			if (LunarSphereSettings.memoryDisableMinimap) then

				-- Create Disabled Caption
				tempObject = Lunar.Object:CreateCaption(20, sectionY -20, 100, 20, Lunar.Locale["MEMORY_DISABLED"], "memMinimapDisabled", tempFrameContainer, true);

			else

				-- Enable Scrollwheel Zoom option
				tempObject = Lunar.Object:CreateCheckbox(10, sectionY - 20, Lunar.Locale["SCROLL_ZOOM"], "minimapScroll", true, tempFrameContainer,
				function (self)

					Lunar.API:SetMinimapScroll((self:GetChecked() == true));
				end);

				-- Coordinates option
				tempObject = Lunar.Object:CreateCheckbox(120, sectionY - 36, Lunar.Locale["COORDS"], "showCoordinates", true, tempFrameContainer,
				function (self)
					LunarSphereSettings.showCoordinates = (self:GetChecked() == true)
					Lunar.API:ShowMinimapCoords((self:GetChecked() == true))
					Lunar.API.updateTimer = 1;
				end);

				-- Current Time option
				tempObject = Lunar.Object:CreateCheckbox(10, sectionY - 36, Lunar.Locale["TIME"], "showTime", true, tempFrameContainer,
				function (self)
					LunarSphereSettings.showTime = (self:GetChecked() == true)
					Lunar.API:ShowMinimapTime(LunarSphereSettings.showTime, LunarSphereSettings.militaryTime, LunarSphereSettings.timeOffset)
					Lunar.API.updateTimer = 1;
					Lunar.Settings:SetEnabled(_G["LSSettingsmilitaryTime"], LunarSphereSettings.showTime);
				end);

					-- Military option
					tempObject = Lunar.Object:CreateCheckbox(30, sectionY - 52, Lunar.Locale["MILITARY"], "militaryTime", true, tempFrameContainer,
					function (self)
						LunarSphereSettings.militaryTime = (self:GetChecked() == true);
						Lunar.API:ShowMinimapTime(LunarSphereSettings.showTime, LunarSphereSettings.militaryTime, LunarSphereSettings.timeOffset)
						Lunar.API.updateTimer = 1;
					end);
					Lunar.Settings:SetEnabled(_G["LSSettingsmilitaryTime"], LunarSphereSettings.showTime);

					-- Server Time Offset chooser
					tempObject = Lunar.Object:CreateSlider(42, sectionY - 84, Lunar.Locale["CURRENT_TIME_OFFSET"], "timeOffset", tempFrameContainer, -12, 12, 1,
					function (self) 
						LunarSphereSettings.timeOffset = self:GetValue();
						Lunar.API.updateTimer = 1;
					end);

			end

		sectionY = -257;
		-- Create Start-Up Message Caption
		tempObject = Lunar.Object:CreateCaption(10, sectionY, 150, 20, "|cFFFFFFFF"..Lunar.Locale["START_UP_MESSAGE"], "startUpMessage", tempFrameContainer);

			-- Create use message check box
			tempObject = Lunar.Object:CreateCheckbox(10, sectionY - 20, "", "showStartupMessage", true, tempFrameContainer,
			function (self)
				LunarSphereSettings.showStartupMessage = (self:GetChecked() == true)
				if (LunarSphereSettings.startupMessage == "gievcowlevel") then
					LunarSphereSettings.gievcowlevel = self:GetChecked();
				end
				LunarSphere_cow();
			end);
			tempObject:SetHitRectInsets(0, -16, 0, 0);

			-- Create message text box
			tempObject = CreateFrame("EditBox", "LSSettingsStartUpMessage", tempFrameContainer, "LunarEditBox");

			tempObject:SetPoint("Topleft", tempFrameContainer, "Topleft", 40, sectionY - 20)
			tempObject:SetWidth(178);
			tempObject:Show();
			if (LunarSphereSettings.startupMessage) then
				tempObject:SetText(LunarSphereSettings.startupMessage);
			end
			tempObject:SetScript("OnTextChanged",
			function (self)
				LunarSphereSettings.startupMessage = self:GetText();
			end);

		sectionY = -296;

		-- Create Auto-scale Windows check box
		tempObject = Lunar.Object:CreateCheckbox(10, sectionY, Lunar.Locale["AUTO_SCALE_WINDOWS"], "autoScaleWindows", true, tempFrameContainer,
		function (self)
			LunarSphereSettings.autoScaleWindows = (self:GetChecked() == true)
			Lunar.Settings.updateScale = tonumber(GetCVar("useUiScale"));
		end);

		sectionY = -320

		-- Create Sphere Location Caption
		tempObject = Lunar.Object:CreateCaption(10, sectionY, 150, 20, "|cFFFFFFFF"..Lunar.Locale["SPHERE_LOCATION"], "sphereLocation", tempFrameContainer);

			-- Create X Location Caption
			tempObject = Lunar.Object:CreateCaption(10, sectionY - 20, 30, 20, "X: ", "sphereLocationX", tempFrameContainer);

			-- Create message text box
			tempObject = CreateFrame("EditBox", "LSSettingsXLocationEdit", tempFrameContainer, "LunarEditBox");

			tempObject:SetPoint("Topleft", tempFrameContainer, "Topleft", 36, sectionY - 20)
			tempObject:SetWidth(40);
			tempObject:Show();
			tempObject:SetMaxBytes(6);
			tempObject:SetText(0);

			-- Create Y Location Caption
			tempObject = Lunar.Object:CreateCaption(86, sectionY - 20, 30, 20, "Y: ", "sphereLocationY", tempFrameContainer);

			-- Create message text box
			tempObject = CreateFrame("EditBox", "LSSettingsYLocationEdit", tempFrameContainer, "LunarEditBox");

			tempObject:SetPoint("Topleft", tempFrameContainer, "Topleft", 112, sectionY - 20)
			tempObject:SetWidth(40);
			tempObject:Show();
			tempObject:SetMaxBytes(6);
			tempObject:SetText(0);

			-- Apply location button
			tempObject = Lunar.Object:CreateButton(158, sectionY - 20, 64, "applyLocation", Lunar.Locale["APPLY"], tempFrameContainer,
			function(self)
				LunarSphereSettings.xOfs = tonumber(_G["LSSettingsXLocationEdit"]:GetText());
				LunarSphereSettings.yOfs = tonumber(_G["LSSettingsYLocationEdit"]:GetText());
				LunarSphereSettings.relativePoint = "Center";
				_G["LSmain"]:ClearAllPoints();
				_G["LSmain"]:SetPoint("Center", UIParent, "Center", LunarSphereSettings.xOfs, LunarSphereSettings.yOfs);
			end);

	-- Create our eleventh tab container. This holds our "Memory Settings"
	tempObject = Lunar.Object:Create("container", "LSSettingsMainTab1311Container", _G[tempFrame:GetName() .. "WindowContainer"], "", containerWidth, containerHeight);
	tempObject:SetPoint("Topleft", 92, -10);
	tempObject:SetFrameLevel(tempLevel + 15);
	tempObject:Hide();
	tempFrameContainer = tempObject;

		sectionY = -10;

		-- LunarSphere Features caption
		tempObject = Lunar.Object:CreateCaption(10, sectionY, 150, 20, "|cFFFFFFFF"..Lunar.Locale["LUNARSPHERE_FEATURES"], "lunarSphereFeatures", tempFrameContainer);

		-- Scroll frame
		tempObject = Lunar.API:CreateFrame("ScrollFrame", "LSSettingsMemoryScrollFrame", tempFrameContainer, 184, 158, nil, nil, 0);
		tempObject:SetPoint("Topleft", 16, sectionY - 34);
		tempObject:Show();

		sectionY = -4;

		-- Create border of scroll frame
		tempObject = Lunar.Object:Create("container", "LSMemoryListBorder", tempFrameContainer, "", 194, 183, 0.1, 0.1, 0.1)
		tempObject:SetPoint("TopLeft", tempFrameContainer, "TopLeft", 8, sectionY - 25);
		tempObject:SetFrameLevel(tempFrameContainer:GetFrameLevel() + 1);
		tempObject:EnableMouse("true");
		tempObject:EnableMouseWheel("true");
		tempObject.scrollerName = "LSSettingsMemoryListSlider";
		tempObject:SetScript("OnMouseWheel", Lunar.Settings.OnMouseWheelScroll);

		-- Create border of scroller
		tempObject = Lunar.Object:Create("container", "LSMemoryListScrollerBorder", tempFrameContainer, "", 31, 183, 0.1, 0.1, 0.1)
		tempObject:ClearAllPoints();
		tempObject:SetPoint("TopRight", tempFrameContainer, "TopRight", -8, sectionY - 25);
		tempObject:SetFrameLevel(tempFrameContainer:GetFrameLevel() + 2);
		tempObject:EnableMouseWheel("true");
		tempObject.scrollerName = "LSSettingsMemoryListSlider";
		tempObject:SetScript("OnMouseWheel", Lunar.Settings.OnMouseWheelScroll);

		-- Create slider bar
		tempObject = CreateFrame("Slider", "LSSettingsMemoryListSlider", tempFrameContainer, "LunarVerticalSlider");

		tempObject:SetPoint("TopRight", tempFrameContainer, "TopRight", -16, sectionY - 31);
		tempObject:SetWidth(15);
		tempObject:SetHeight(171);
		tempObject:SetValueStep(16);
		tempObject:SetFrameLevel(tempFrameContainer:GetFrameLevel() + 3);
		tempObject:SetMinMaxValues(0, 160);
		tempObject:Show();
		tempObject:SetScript("OnValueChanged",
		function(self)
			_G["LSSettingsMemoryScrollFrame"]:SetVerticalScroll(self:GetValue());
		end);

		-- Scroll frame contents
		tempFrameContainer = Lunar.API:CreateFrame("Frame", "LSSettingsMemoryScrollFrameChild", _G["LSSettingsMemoryScrollFrame"], 184, 374, nil, nil, 0);
		_G["LSSettingsMemoryScrollFrame"]:SetScrollChild(tempFrameContainer);

			Lunar.Settings.memoryEdit = {};
			Lunar.Settings.memoryEditCount = 12;

			sectionY = 4;
			local memID = 1;

			-- Reagent tab info
			tempObject = Lunar.Object:CreateCaption(5, sectionY, 150, 20, "|cFFFFFFFF"..Lunar.Locale["TAB_REAGENT"], "reagentTabCaption", tempFrameContainer);

				-- Create disable section checkbox
				tempObject = Lunar.Object:CreateCheckbox(5, sectionY - 16, Lunar.Locale["TAB_DISABLE_SECTION"] .. memorySize[memID], "memoryDisableReagents", true, tempFrameContainer, Lunar.Settings.SetMemoryValue);
				tempObject:SetID(memID);
				memID = memID + 1;

			sectionY = sectionY - (16 * 2);

			-- Inventory tab info
			tempObject = Lunar.Object:CreateCaption(5, sectionY, 150, 20, "|cFFFFFFFF"..Lunar.Locale["TAB_INVENTORY"], "inventoryTabCaption", tempFrameContainer);

				-- Create disable junk checkbox
				tempObject = Lunar.Object:CreateCheckbox(5, sectionY - 16, Lunar.Locale["TAB_INVENTORY_JUNK"] .. memorySize[memID], "memoryDisableJunk", true, tempFrameContainer, Lunar.Settings.SetMemoryValue);
				tempObject:SetID(memID);
				memID = memID + 1;

				-- Create disable repairs checkbox
				tempObject = Lunar.Object:CreateCheckbox(5, sectionY - 32, Lunar.Locale["TAB_INVENTORY_REPAIR"] .. memorySize[memID], "memoryDisableRepairs", true, tempFrameContainer, Lunar.Settings.SetMemoryValue);
				tempObject:SetID(memID);
				memID = memID + 1;

				-- Create disable AH mail checkbox
				tempObject = Lunar.Object:CreateCheckbox(5, sectionY - 48, Lunar.Locale["TAB_INVENTORY_AHMAIL"] .. memorySize[memID], "memoryDisableAHMail", true, tempFrameContainer, Lunar.Settings.SetMemoryValue);
				tempObject:SetID(memID);
				memID = memID + 1;

				-- Create disable AH totals checkbox
				tempObject = Lunar.Object:CreateCheckbox(5, sectionY - 64, Lunar.Locale["TAB_INVENTORY_AHTOTALS"] .. memorySize[memID], "memoryDisableAHTotals", true, tempFrameContainer, Lunar.Settings.SetMemoryValue);
				tempObject:SetID(memID);
				memID = memID + 1;

			sectionY = sectionY - (16 * 5);

			-- Speech tab info
			tempObject = Lunar.Object:CreateCaption(5, sectionY, 150, 20, "|cFFFFFFFF"..Lunar.Locale["TAB_SPEECH"], "speechTabCaption", tempFrameContainer);

				-- Create disable section checkbox
				tempObject = Lunar.Object:CreateCheckbox(5, sectionY - 16, Lunar.Locale["TAB_DISABLE_SECTION"] .. memorySize[memID], "memoryDisableSpeech", true, tempFrameContainer, Lunar.Settings.SetMemoryValue);
				tempObject:SetID(memID);
				memID = memID + 1;

			sectionY = sectionY - (16 * 2);

			-- Skins tab info
			tempObject = Lunar.Object:CreateCaption(5, sectionY, 150, 20, "|cFFFFFFFF"..Lunar.Locale["TAB_SKINS"], "skinsTabCaption", tempFrameContainer);

				-- Create disable section checkbox
				tempObject = Lunar.Object:CreateCheckbox(5, sectionY - 16, Lunar.Locale["TAB_DISABLE_SETTINGS"] .. memorySize[memID], "memoryDisableSkins", true, tempFrameContainer, Lunar.Settings.SetMemoryValue);
				tempObject:SetID(memID);
				memID = memID + 1;

			sectionY = sectionY - (16 * 2);

			-- Templates tab info
			tempObject = Lunar.Object:CreateCaption(5, sectionY, 150, 20, "|cFFFFFFFF"..Lunar.Locale["TAB_TEMPLATES"], "templatesTabCaption", tempFrameContainer);

				-- Create disable section checkbox
				tempObject = Lunar.Object:CreateCheckbox(5, sectionY - 16, Lunar.Locale["TAB_DISABLE_SECTION"] .. memorySize[memID], "memoryDisableTemplates", true, tempFrameContainer, Lunar.Settings.SetMemoryValue);
				tempObject:SetID(memID);
				memID = memID + 1;

			sectionY = sectionY - (16 * 2);

			-- Other tab info
			tempObject = Lunar.Object:CreateCaption(5, sectionY, 150, 20, "|cFFFFFFFF"..Lunar.Locale["TAB_OTHER"], "otherTabCaption", tempFrameContainer);

				-- Create disable default UI checkbox
				tempObject = Lunar.Object:CreateCheckbox(5, sectionY - 16, Lunar.Locale["TAB_OTHER_HIDEUI"] .. memorySize[memID], "memoryDisableDefaultUI", true, tempFrameContainer, Lunar.Settings.SetMemoryValue);
				tempObject:SetID(memID);
				memID = memID + 1;

				-- Create disable minimap checkbox
				tempObject = Lunar.Object:CreateCheckbox(5, sectionY - 32, Lunar.Locale["TAB_OTHER_MINIMAP"] .. memorySize[memID], "memoryDisableMinimap", true, tempFrameContainer, Lunar.Settings.SetMemoryValue);
				tempObject:SetID(memID);
				memID = memID + 1;

			sectionY = sectionY - (16 * 3);

			-- Memory tab info
			tempObject = Lunar.Object:CreateCaption(5, sectionY, 150, 20, "|cFFFFFFFF"..Lunar.Locale["TAB_MEMORY"], "otherMemoryCaption", tempFrameContainer);

				-- Create disable default UI checkbox
				tempObject = Lunar.Object:CreateCheckbox(5, sectionY - 16, Lunar.Locale["TAB_MEMORY_STATS"] .. memorySize[memID], "memoryDisableMemCPU", true, tempFrameContainer, Lunar.Settings.SetMemoryValue);
				tempObject:SetID(memID);
				memID = memID + 1;

			sectionY = sectionY - (16 * 2);

			-- Credits tab info
			tempObject = Lunar.Object:CreateCaption(5, sectionY, 150, 20, "|cFFFFFFFF"..Lunar.Locale["TAB_CREDITS"], "creditsMemoryCaption", tempFrameContainer);

				-- Create disable default UI checkbox
				tempObject = Lunar.Object:CreateCheckbox(5, sectionY - 16, Lunar.Locale["TAB_DISABLE_SECTION"] .. memorySize[memID], "memoryDisableCredits", true, tempFrameContainer, Lunar.Settings.SetMemoryValue);
				tempObject:SetID(memID);
				memID = memID + 1;

		tempFrameContainer = _G["LSSettingsMainTab1311Container"];

		sectionY = -214

		-- Reload UI button
		tempObject = Lunar.Object:CreateButton(10, sectionY, 212, "MemoryReloadButton", Lunar.Locale["MEMORY_RELOAD"], tempFrameContainer, ReloadUI);
		tempObject:Disable();

		sectionY = sectionY - 26;

		if (LunarSphereSettings.memoryDisableMemCPU) then

			-- Create Disabled Caption
			tempObject = Lunar.Object:CreateCaption(20, sectionY, 100, 20, Lunar.Locale["MEMORY_DISABLED"], "memMemoryCPUDisabled", tempFrameContainer, true);

		else

			-- Memory and CPU Statistics caption
			tempObject = Lunar.Object:CreateCaption(10, sectionY, 150, 20, "|cFFFFFFFF"..Lunar.Locale["MEMORY_CPU_STATS"], "memoryCPUStatsCaption", tempFrameContainer);

				-- CPU Profiling enable checkbox
				tempObject = Lunar.Object:CreateCheckbox(10, sectionY - 16, Lunar.Locale["MEMORY_CPU_ENABLED"], "memorySetCPU", true, tempFrameContainer,
				function (self)
					if (self:GetChecked() == true) then
						SetCVar("scriptProfile", "1");
					else
						SetCVar("scriptProfile", "0");
					end
					ReloadUI();
				end);
				if (GetCVar("scriptProfile") == "1") then
					tempObject:SetChecked(true);
				end
				tempObject.timer = 0;
				tempObject:SetScript("OnUpdate",
				function(self, arg1)
					self.timer = self.timer + arg1;
					if (self.timer >= 1) then
						self.timer = 0;

						-- Update LS memory stats
						local memoryLS = Lunar.API:MemoryUsage();
						memoryLS = memoryLS + math.floor(GetAddOnMemoryUsage("LunarSphereExporter") * 10)/10;
						local memoryPerSec = math.floor((memoryLS - (self.lastMemory or (memoryLS))) * 10)/10;
						self.lastMemory = memoryLS;
						if (memoryPerSec > 30) then
							memoryPerSec = "|cFFCC0000" .. memoryPerSec; 
						elseif (memoryPerSec > 10) then
							memoryPerSec = "|cFFCCCC00" .. memoryPerSec; 
						else
							memoryPerSec = "|cFF00CC00" .. memoryPerSec;
						end
						_G["LSSettingsmemoryUseLSValueCaptionText"]:SetText("|cFFFFFFFF" .. memoryLS .. " kb (" .. memoryPerSec .. "/s|cFFFFFFFF)");

						-- Update all addon stats
						local name, enabled, loadable, usedKB
						local totalKB = 0;
						for i = 1, GetNumAddOns() do
							name, _, _, enabled, loadable, _, _ = GetAddOnInfo(i);
							if (enabled == 1) then
								usedKB = GetAddOnMemoryUsage(name);
								totalKB = totalKB + usedKB;
							end
						end
						memoryPerSec = math.floor((totalKB - (self.lastTotalMemory or (totalKB))) * 10)/10;
						self.lastTotalMemory = totalKB;
						if (memoryPerSec > 40) then
							memoryPerSec = "|cFFCC0000" .. memoryPerSec; 
						elseif (memoryPerSec > 15) then
							memoryPerSec = "|cFFCCCC00" .. memoryPerSec; 
						else
							memoryPerSec = "|cFF00CC00" .. memoryPerSec;
						end
						_G["LSSettingsmemoryUseValueCaptionText"]:SetText("|cFFFFFFFF" .. tostring(math.floor(totalKB * 10)/10) .. " kb (" .. memoryPerSec .. "/s|cFFFFFFFF)");

						-- Update the CPU usage if it's enabled
						if (GetCVar("scriptProfile") == "1") then
							UpdateAddOnCPUUsage();
							local cpuUsage = GetAddOnCPUUsage("LunarSphere");
							local cpuPerSec = math.floor((cpuUsage - (self.lastCPU or (cpuUsage))) * 10)/10;
							self.lastCPU = cpuUsage;
							if (cpuPerSec > 20) then
								cpuPerSec = "|cFFCC0000" .. cpuPerSec .. " ms"; 
							elseif (cpuPerSec > 10) then
								cpuPerSec = "|cFFCCCC00" .. cpuPerSec .. " ms"; 
							else
								cpuPerSec = "|cFF00CC00" .. cpuPerSec .. " ms";
							end
							_G["LSSettingsmemoryCPULSValueCaptionText"]:SetText(cpuPerSec); --"|cFFFFFFFF" .. cpu .. " kb (" .. memoryPerSec .. "/s|cFFFFFFFF)");

						end

					end
				end);

				tempObject:SetScript("OnShow",
				function (self)
					self.lastMemory = nil;
					self.lastCPU = nil;
					self.lastTotalMemory = nil;
				end);

				-- LS memory use caption
				tempObject = Lunar.Object:CreateCaption(10, sectionY - 32, 150, 20, Lunar.Locale["MEMORY_USAGE"], "memoryUseLSCaption", tempFrameContainer, true);

				-- LS memory use value
				tempObject = Lunar.Object:CreateCaption(110, sectionY - 32, 150, 20, "0", "memoryUseLSValueCaption", tempFrameContainer, true);

				-- All addon memory use caption
				tempObject = Lunar.Object:CreateCaption(10, sectionY - 48, 150, 20, Lunar.Locale["MEMORY_ALL_USAGE"], "memoryUseCaption", tempFrameContainer, true);

				-- All addon memory use value
				tempObject = Lunar.Object:CreateCaption(110, sectionY - 48, 150, 20, "0", "memoryUseValueCaption", tempFrameContainer, true);


				-- LS CPU use caption
				tempObject = Lunar.Object:CreateCaption(10, sectionY - 64, 150, 20, Lunar.Locale["MEMORY_CPU_USAGE"], "memoryCPULSCaption", tempFrameContainer, true);
				if (GetCVar("scriptProfile") == "0") then
					_G[tempObject:GetName() .. "Text"]:SetTextColor(0.5,0.5,0.5);
				end

				-- LS CPU use value
				tempObject = Lunar.Object:CreateCaption(110, sectionY - 64, 150, 20, "0", "memoryCPULSValueCaption", tempFrameContainer, true);
				if (GetCVar("scriptProfile") == "0") then
					_G[tempObject:GetName() .. "Text"]:SetTextColor(0.5,0.5,0.5);
				end

				-- Memory printout button
				tempObject = Lunar.Object:CreateButton(10, sectionY - 96, 212, "memoryPrintout", Lunar.Locale["MEMORY_USE_SUMMARY"], tempFrameContainer,
				function()
					Lunar.API:Print(Lunar.Locale["_MEMORY_DUMP"]);
					Lunar.API:Print("===================================");
					Lunar.API:PrintMemoryStats();
					Lunar.API:Print("===================================");
				end);

				memorySize = nil;
		end

	-- Create our twelveth tab container. This holds our "Credits"
	tempObject = Lunar.Object:Create("container", "LSSettingsMainTab1312Container", _G[tempFrame:GetName() .. "WindowContainer"], "", containerWidth, containerHeight);
	tempObject:SetPoint("Topleft", 92, -10);
	tempObject:SetFrameLevel(tempLevel + 15);
	tempObject:Hide();
	tempFrameContainer = tempObject;

		if (LunarSphereSettings.memoryDisableCredits) then

			-- Create Disabled Caption
			tempObject = Lunar.Object:CreateCaption(20, -30, 100, 20, Lunar.Locale["MEMORY_DISABLED"], "memCreditsDisabled", tempFrameContainer, true);

		else

			sectionY = 0;

			-- Scroll frame
			tempObject = Lunar.API:CreateFrame("ScrollFrame", "LSSettingsCreditsScrollFrame", tempFrameContainer, 190, 358, nil, nil, 0);
			tempObject:SetPoint("Topleft", 8, sectionY - 8);
			tempObject:Show();

			sectionY = 0;

			-- Create border of scroll frame
			tempObject = Lunar.Object:Create("container", "LSCreditsListBorder", tempFrameContainer, "", 202, 383, 0.1, 0.1, 0.1)
			tempObject:SetPoint("TopLeft", tempFrameContainer, "TopLeft", 0, sectionY);
			tempObject:SetFrameLevel(tempFrameContainer:GetFrameLevel() + 1);
			tempObject:EnableMouse("true");
			tempObject:EnableMouseWheel("true");
			tempObject.scrollerName = "LSSettingsCreditsListSlider";
			tempObject:SetScript("OnMouseWheel", Lunar.Settings.OnMouseWheelScroll);
			tempObject:SetAlpha(0);

			-- Create border of scroller
			tempObject = Lunar.Object:Create("container", "LSCreditListScrollerBorder", tempFrameContainer, "", 31, 372, 0.1, 0.1, 0.1)
			tempObject:ClearAllPoints();
			tempObject:SetPoint("TopRight", tempFrameContainer, "TopRight", 0, sectionY);
			tempObject:SetFrameLevel(tempFrameContainer:GetFrameLevel() + 2);
			tempObject:EnableMouseWheel("true");
			tempObject.scrollerName = "LSSettingsCreditsListSlider";
			tempObject:SetScript("OnMouseWheel", Lunar.Settings.OnMouseWheelScroll);

			-- Create slider bar
			tempObject = CreateFrame("Slider", "LSSettingsCreditsListSlider", tempFrameContainer, "LunarVerticalSlider");

			tempObject:SetPoint("TopRight", tempFrameContainer, "TopRight", -8, sectionY - 4);
			tempObject:SetWidth(15);
			tempObject:SetHeight(362);
			tempObject:SetValueStep(16);
			tempObject:SetFrameLevel(tempFrameContainer:GetFrameLevel() + 3);
			tempObject:SetMinMaxValues(0, 128);
			tempObject:Show();
			tempObject:SetScript("OnValueChanged",
			function(self)
				_G["LSSettingsCreditsScrollFrame"]:SetVerticalScroll(self:GetValue());
			end);
			-- Scroll frame contents
			tempFrameContainer = Lunar.API:CreateFrame("Frame", "LSSettingsCreditscrollFrameChild", _G["LSSettingsCreditsScrollFrame"], 190, 832, nil, nil, 0);
			_G["LSSettingsCreditsScrollFrame"]:SetScrollChild(tempFrameContainer);

				sectionY = 0;

				local creditContents = {
					"voyseys, Fullmoon, N3od3ath";
					"Ace977977, Calif94577, Deadman80, Deep42, Erudan, Faytel, Illutian, Jaycce, Jonzadar, Kae, Kj Maghica, Mitsobar, NapalmDawn, Pakka, Seanmcgpa, Tank, Valderon, Xenoid, Zacharum, Zoquara";
					"Moongaze for bringing LunarShpere into our WoW lives and Erudan for the hard work on the random mount code :D";
						"|cFFFFFFFFProject coded by:\n\nMoongaze:|r\n(Twisting Nether - Horde - US)\n|cFFFFFFFFhttp://www.lunaraddons.com\n\n" ..
						"|cFFFFFFFFLunarSphere is based on sphere addons such as:|r\n\nCryolysis, HolyHope, Necrosis, Sabella, Serenity, Totemus, Venantes\n\n" ..
						"|cFFFFFFFFBLP converter used:|r\n\nBLPConverter by Patrick Cyr\n\n" ..
						"|cFFFFFFFFSpecial thanks to:|r\n\n" ..
						"|cFF4CB9FFElesarr|r\nHuge support and kept me sane!\n" ..
						"|cFF4CB9FFLothaer|r\nLots of support and help, OMG.\n" ..
						"|cFF4CB9FFDaBigNob|r\nWOW! Thank you for the cookies!\n" .. 
						"|cFF4CB9FFAvaCam|r\nHuge help and thanks for the cookies!\n" .. 
						"|cFF4CB9FFHaggo|r\nSo much help, including a mirror!\n" .. 
						"|cFF4CB9FFBishop|r\nTons of help, and a mirror!\n" .. 
						"|cFF4CB9FFVirtualplay|r\nLots of input, and a mirror!\n" .. 
						"|cFF4CB9FFExuro|r\nSo much input on this project!\n" .. 
						"|cFF4CB9FFLaurelei|r\nHuge help with a lot of stuff!\n" .. 
						"|cFF4CB9FFChaos|r\nHuge help in the forums!\n" .. 
						"|cFF4CB9FFLarania|r\nYou helped so much, thanks!\n" .. 
						"|cFF4CB9FFBriandre|r\nGreat support and help in the forums!\n" .. 
						"|cFF4CB9FFScaredofspiders|r\nLots of good stuff, thanks!\n" .. 
						"|cFF4CB9FFBearhooves|r\nThanks for all the help!\n" .. 
						"|cFF4CB9FFtninja|r\nlol, you know why =P\n\n" ..
						"|cFFFFFFFFLocalization by:|r\n\nwww184436@CWDG (zhCN)\nwln333@CWDG (zhCN)\nchacha@Whisperwind (zhTW)\nHaggo (deDE)\nHijikata (deDE)";
					"Abish, Albert, Anrie, AutolycusWolf, Balthizar, Barren, Beguile, Bloodeagle, Brendon2424, Ceil, Ceniza, Cidhighwind, Cleolump, Daelin, Djp, Dredd, Dwimmerlaik, Ed, Eleve, Enjoyrc, Erudan, Faidwen, Felislachesis, Gabrix, Grimble, Happyburger, HatteSoul, Hawaiianghost, Jimbojones, Jonsnow, Kae, Kashari, Kharon, Kyouraku, Lonsdale, Lordc, Mara1129, Mitsobar, Morgraan, Mortimus, Narcle, Nobbynob, Omegajim, Ose, Peeeboloco, Positivx, Pusikas, Raederle, Rasmus, Rasu, Ricowan, Robshield, Shirga, Silentbob, SouthpawGreg, Sueisfine, Tank, Tenson, Tiolia, Tpmdm, Unrak, Verderf, Vexi, Viserion, Wendar, Wolftusk, Yoduki, Zarahemla, Zenithan, Zinji, Zoquara";
					"Aerimus, Andrew23890, Angel, Anxi, Arakara, Arinbjorn, Arvelen, Athel, Aylaiine, Aztik, Bacail, Bbfpaco, Boongles, Boris, Boydmeister, Bud66, Callamity, Callmedagooch, Captainskyhawk, Cedia, Cgatton, Charka, Chunhua, Cleopatra, Colder99, Curtana, Cyberdan83, Cyneburga, Dadude, Dannyboy, Darnek, Darth3Pio, Deathhamster, Deekar, Delen, Destrier, Deviad, Djanna, Docseuzz, Draught, Droid, Drsuse, Elcottleto, Elekktra, Empres, Evinras, GallopingCow, Gilceleb, Gothicrose, Grimlokai, Griz, Hcidivision17, Hijikata, Hikarii, Hornspawn, Hrathar, Iliya, Islandsoul, Jaco, Jeanjean, Jehosephat, Jorenn, Kaellan, Kallah, Kazumatsb, Keilun, Kelana, Khreasilya, Kilee, Kinetic, Koimagheul, Kolb, Krekreck, Kutai, Lery, Lichbane, Lite, Loteru, Louisdepre, Lunatic, Lunnale, Lynn, Madlax, Maelduine, Maerius, Maerynn, Makitor, Malathar, Malcolm, Marukale, Masta, Mastafrooper, Maxgane, Mccord, Megis, Militis, Mithras, Mokakona, Mosrael, Mpegmail, Mythik, Mzenger, Necrys, Nerd65, Nerz, Nightmenace, Nosscire, Novax, Nuno, Nytekat, Onegodd, Opieself, Orange, Pare, Pleaseaccept, Polgra, Premutos, Priesty, Psygno, Pyro, Quinten, Ramstall, Rdsiam, Remind, Reyn, Risin, Ronalds, Rothana, Rudy9443, Ruffhewn, Ryianne, Sapph, Senuska, Shadowelf, Sidonis, Sirmarkus, Skunkwerks, Solipsist, Somnic, Sukrim, Syblaze, Syntress, Tamraine, Tarielen, Tarvarno, Tatzel, Tayedaen, Tenub, Tht, Tiamaster, Torisen, Trellian, Truly, Uncontrollable, Vbrokop, Vendonis, Vonwen, Vyzov, Whimpy71, Wrd, Wyllow, Wyveryx, Xanilus, Xavorin, Zantar, Zikthule, Zot, and 234 others";
					" ";
				};

				local tempObject2;
				local childHeight = 0;
				-- Catagory 1 name
				tempObject = Lunar.Object:CreateCaption(5, sectionY, 150, 20, "|cFFFFFFFF"..Lunar.Locale["CREDIT_CAT1"], "creditCatagory1Caption", tempFrameContainer);
				_G[tempObject:GetName() .. "Text"]:SetWidth(180);
				_G[tempObject:GetName() .. "Text"]:SetJustifyV("Top");
				_G[tempObject:GetName() .. "Text"]:SetJustifyH("Center");
				tempObject2 = tempObject;
--				childHeight = childHeight + math.abs(_G[tempObject:GetName() .. "Text"]:GetTop());
				childHeight = childHeight + _G[tempObject:GetName() .. "Text"]:GetHeight() + 8

				-- Catagory 1 contents
				tempObject = Lunar.Object:CreateCaption(5, sectionY, 150, 20, creditContents[1], "creditCat1Contents", tempFrameContainer, true);
				_G[tempObject:GetName() .. "Text"]:ClearAllPoints();
				_G[tempObject:GetName() .. "Text"]:SetPoint("Topleft", _G[tempObject2:GetName() .. "Text"], "BottomLeft", 0, -4)
				_G[tempObject:GetName() .. "Text"]:SetWidth(180);
				_G[tempObject:GetName() .. "Text"]:SetJustifyV("Top");
				_G[tempObject:GetName() .. "Text"]:SetJustifyH("Center");
				childHeight = childHeight + _G[tempObject:GetName() .. "Text"]:GetHeight() + 8
				tempObject2 = tempObject;

				for i = 2, 7 do 
					-- Catagory i name
					tempObject = Lunar.Object:CreateCaption(5, sectionY, 150, 20, "|cFFFFFFFF"..Lunar.Locale["CREDIT_CAT" .. i], "creditCatagory" .. i .. "Caption", tempFrameContainer);
					_G[tempObject:GetName() .. "Text"]:ClearAllPoints();
					_G[tempObject:GetName() .. "Text"]:SetPoint("Topleft", _G[tempObject2:GetName() .. "Text"], "BottomLeft", 0, -8)
					_G[tempObject:GetName() .. "Text"]:SetWidth(180);
					_G[tempObject:GetName() .. "Text"]:SetJustifyV("Top");
					_G[tempObject:GetName() .. "Text"]:SetJustifyH("Center");
					childHeight = childHeight + _G[tempObject:GetName() .. "Text"]:GetHeight() + 8
					tempObject2 = tempObject;

					-- Catagory i contents
					tempObject = Lunar.Object:CreateCaption(5, sectionY, 150, 20, creditContents[i], "creditCat" .. i .. "Contents", tempFrameContainer, true);
					_G[tempObject:GetName() .. "Text"]:ClearAllPoints();
					_G[tempObject:GetName() .. "Text"]:SetPoint("Topleft", _G[tempObject2:GetName() .. "Text"], "BottomLeft", 0, -4)
					_G[tempObject:GetName() .. "Text"]:SetWidth(180);
					_G[tempObject:GetName() .. "Text"]:SetJustifyV("Top");
					_G[tempObject:GetName() .. "Text"]:SetJustifyH("Center");
					childHeight = childHeight + _G[tempObject:GetName() .. "Text"]:GetHeight() + 8
					tempObject2 = tempObject;
				end

--			childHeight = childHeight + math.abs(_G[tempObject:GetName() .. "Text"]:GetHeight());
			_G["LSSettingsCreditscrollFrameChild"]:SetHeight(childHeight);
			childHeight = childHeight - 360;
			_G["LSSettingsCreditsListSlider"]:SetMinMaxValues(0, childHeight);
		end

	-- Create our thirteenth container. This holds our "Debug Settings"
	tempObject = Lunar.Object:Create("container", "LSSettingsMainTab1313Container", _G[tempFrame:GetName() .. "WindowContainer"], "", containerWidth, containerHeight);
	tempObject:SetPoint("Topleft", 92, -10);
	tempObject:Hide();
	tempObject:SetFrameLevel(tempLevel + 15);
	tempFrameContainer = tempObject;

		-- Debug mode: Disable/Enable addons
		tempObject = Lunar.Object:CreateButton(10, -10, 212, "DebugToggleAddons", Lunar.Locale["DEBUG_DISABLE_ADDONS"], tempFrameContainer,
		function ()
			if LunarSphereSettings.debugAddonList then
				Lunar.API:ToggleActiveAddons(true)
			else
				Lunar.API:ToggleActiveAddons();
			end
		end);

		if (LunarSphereSettings.debugAddonList) then
			tempObject:SetText(Lunar.Locale["DEBUG_ENABLE_ADDONS"]);
		end

		-- Debug mode: Item printout
		tempObject = Lunar.Object:CreateButton(10, -30, 212, "DebugItemPrintout", Lunar.Locale["DEBUG_ITEM_PRINTOUT"], tempFrameContainer, Lunar.Items.DebugPrint);

		-- Debug mode: Delete export templates
		tempObject = Lunar.Object:CreateButton(10, -70, 212, "DebugTemplateClean", Lunar.Locale["DEBUG_DELETE_TEMPLATES"], tempFrameContainer,
		function()
			if (LunarSphereExport) and (LunarSphereExport.template)  then
				LunarSphereExport.template = nil;
				Lunar.Settings:BuildTemplateList();
				collectgarbage();
			end
		end);

		-- Debug mode: Wipe Button Data
		tempObject = Lunar.Object:CreateButton(10, -110, 212, "DebugWipeButtons", Lunar.Locale["DEBUG_WIPE_BUTTONS"], tempFrameContainer,
		function()
			LunarSphereSettings.buttonData = {};
			ReloadUI();
		end);
		--tempObject:GetNormalTexture():SetVertexColor(1,0,0);

		-- Debug mode: Wipe All Data
		tempObject = Lunar.Object:CreateButton(10, -130, 212, "DebugWipeAll", Lunar.Locale["DEBUG_RESET_LS"], tempFrameContainer,
		function()
			LunarSphereGlobal.backupDB = LunarSphereSettings.backupDB;
			LunarSphereGlobal.backupSize = LunarSphereSettings.backupSize;
			LunarSphereSettings = nil;
			ReloadUI();
		end);
		--tempObject:GetNormalTexture():SetVertexColor(1,0,0);

		if (LunarSphereGlobal.debugModeOn) then
			
			-- Create texture input text box
			tempObject = CreateFrame("EditBox", "LSSettingsDebugSpellAdd", tempFrameContainer, "LunarEditBox");

			tempObject:SetPoint("Topleft", tempFrameContainer, "Topleft", 40, -180)
			tempObject:SetWidth(178);
			tempObject:Show();
			tempObject:SetScript("OnTextChanged", function (self)
				if (self:GetText() == "") then
					LunarSphereSettings.debugSpellAdd = false
					_G["LSSettingsdebugSpellAdd"]:SetChecked(false);
					Lunar.Button.debugTexture = false;
				else
					LunarSphereSettings.debugSpellAdd = true;
					_G["LSSettingsdebugSpellAdd"]:SetChecked(true);
					Lunar.Button.debugTexture = self:GetText();
				end
			end);

			-- Create stance input text box
			tempObject = CreateFrame("EditBox", "LSSettingsDebugSpellAddStance", tempFrameContainer, "LunarEditBox");

			tempObject:SetPoint("Topleft", tempFrameContainer, "Topleft", 40, -200)
			tempObject:SetWidth(48);
			tempObject:Show();
			tempObject:SetScript("OnTextChanged", function (self)
				if (self:GetText() == "") then
					Lunar.Button.debugStance = nil;
				else
					Lunar.Button.debugStance = tonumber(self:GetText());
				end
			end);

			-- Create input new texture check box
			tempObject = Lunar.Object:CreateCheckbox(10, -180, "", "debugSpellAdd", true, tempFrameContainer);

			-- Create turn on template editing
			tempObject = Lunar.Object:CreateCheckbox(10, -160, "Template Editing On", "editingTemplates", true, tempFrameContainer,
			function (self)
				LunarSphereSettings.editingTemplates = (self:GetChecked() == true)
				_G["LSSettingsDebugTooltipCode"]:SetText("if frame then a2 = frame:GetID(); if a2 then _,_,_,a1 = Lunar.Button:GetButtonData(a2, Lunar.Button.debugStance , 1); _G['LSSettingsDebugSpellAdd']:SetText(string.match(a1 or '', 'Icons\\(.*)') or ''); end; end");
			end);

		end

		-- Debug mode: Set trade stack total caption
		tempObject = Lunar.Object:CreateCaption(12, -215, 150, 20, Lunar.Locale["DEBUG_STACKS_TO_TRADE"], "stacksToTradeCaption", tempFrameContainer);

		-- Debug mode: Set trade stack total button
		tempObject = Lunar.Object:CreateButton(110, -215, 64, "DebugStackTotal", LunarSphereSettings.stackTradeTotal or (1), tempFrameContainer,
		function(self)
			if not LunarSphereSettings.stackTradeTotal then
				LunarSphereSettings.stackTradeTotal = 1;
			end
			LunarSphereSettings.stackTradeTotal = LunarSphereSettings.stackTradeTotal + 1;
			if (LunarSphereSettings.stackTradeTotal > 7) then
				LunarSphereSettings.stackTradeTotal = 1;
			end
			self:SetText(LunarSphereSettings.stackTradeTotal);
		end);

		-- Create the "Epic Random Flying (310% only)" option
		tempObject = Lunar.Object:CreateCheckbox(10, -280, Lunar.Locale["DEBUG_310_ONLY"], "useOnly310Mounts", true, tempFrameContainer,
		function (self)
			LunarSphereSettings.useOnly310Mounts = (self:GetChecked() == true);
			Lunar.Items:UpdateLowHighItems();
		end);

		-- Create the "Force minimap as sphere texture" option
		tempObject = Lunar.Object:CreateCheckbox(10, -295, Lunar.Locale["DEBUG_FORCE_MINIMAP"], "debugMinimapTexture", true, tempFrameContainer,
		function (self)
			LunarSphereSettings.debugMinimapTexture = (self:GetChecked() == true);
			Lunar.Sphere:MinimapTest();
		end);

		-- Create Show Debug Tooltip
		tempObject = Lunar.Object:CreateCaption(10, -315, 150, 20, Lunar.Locale["DEBUG_SHOW_DEBUG_TOOLTIP"], "showDebugTooltipCaption", tempFrameContainer);

			-- Create use message check box
			tempObject = Lunar.Object:CreateCheckbox(10, -335, "", "showDebugTooltip", true, tempFrameContainer,
			function (self)
				Lunar.API.debugTooltipFunction = false;
				LunarSphereSettings.showDebugTooltip = (self:GetChecked() == true)
			end);
			tempObject:SetHitRectInsets(0, -16, 0, 0);

			-- Create message text box
			tempObject = CreateFrame("EditBox", "LSSettingsDebugTooltipCode", tempFrameContainer, "LunarEditBox");

			tempObject:SetPoint("Topleft", tempFrameContainer, "Topleft", 40, -335)
			tempObject:SetWidth(178);
			tempObject:Show();
			if (LunarSphereSettings.debugTooltipCode) then
				tempObject:SetText(LunarSphereSettings.debugTooltipCode);
			end
			tempObject:SetScript("OnTextChanged",
			function (self)
				Lunar.API.debugTooltipFunction = false;
				_G["LSSettingsshowDebugTooltip"]:SetChecked(false);
				LunarSphereSettings.showDebugTooltip = false;
				LunarSphereSettings.debugTooltipCode = self:GetText();
			end);

	-- Create our button settings dialog (to be used repeatedly)
	Lunar.Settings:CreateButtonDialog();
	Lunar.Settings:CreateStartupDialog();

	-- Create our menu dropdown
	tempObject = CreateFrame("Frame", "LSSettingsMenuDropdown", _G["LSmain"], "UIDropDownMenuTemplate");

	tempObject.lunarMenu = true;
	UIDropDownMenu_Initialize(tempObject, Lunar.Settings.MenuDropdownInitialize); --, "MENU");

end

-- /***********************************************
--  * CreateButtonDialog
--  * ========================
--  *
--  * Creates the main button setting dialog frame that the user will interact with
--  * while editing their buttons manually.
--  *
--  * Accepts: None
--  * Returns: None
--  *********************
function Lunar.Settings:CreateButtonDialog()

	-- Create our locals
	local tempFrame, tempFrameContainer, tempObject, offsetY, sectionY;

	-- Create our button setting dialog window and assign it to the Settings object.
	-- This frame will be called whenever a button needs to be edited...
	Lunar.Settings.ButtonDialog = Lunar.Object:Create("window", "LSButtonDialog", UIParent, Lunar.Locale["WINDOW_TITLE_BUTTONSETTINGS"], 326 + 32, 492, 0.0, 1.0, 0.0);
	Lunar.Settings.ButtonDialog:SetFrameStrata("HIGH");
	Lunar.Settings.ButtonDialog:EnableKeyboard(false);
	Lunar.Settings.ButtonDialog:SetScript("OnKeyDown", Lunar.Settings.Keybind_OnKeyDown);
	Lunar.Settings.ButtonDialog:SetScript("OnKeyUp", Lunar.Settings.Keybind_OnKeyUp);
	Lunar.Settings.ButtonDialog:Hide();

	tempFrameContainer = _G[Lunar.Settings.ButtonDialog:GetName() .. "WindowContainer"];

	-- Scroll frame
	tempObject = Lunar.API:CreateFrame("ScrollFrame", "LSSettingsButtonSettingsScrollFrame", tempFrameContainer, 332, 329, nil, nil, 0);
	tempObject:SetPoint("Topleft", 0, -10);
	tempObject:SetPoint("BottomRight", -15, 32);
	tempObject:EnableMouse("true");
	tempObject:EnableMouseWheel("true");
	tempObject.scrollerName = "LSSettingsButtonSettingsListSlider";
	tempObject:SetScript("OnMouseWheel", Lunar.Settings.OnMouseWheelScroll);
	tempObject:Show();

	sectionY = -4 + 10;

	-- Create border of scroll frame
	tempObject = Lunar.Object:Create("container", "LSButtonSettingsListBorder", tempFrameContainer, "", 332, 133, 0.2, 0.2, 0.2)
	tempObject:SetPoint("TopLeft", tempFrameContainer, "BottomLeft", 0, 32);
	tempObject:SetPoint("BottomRight", tempFrameContainer, "BottomRight", 0, -8);
	tempObject:SetFrameLevel(tempFrameContainer:GetFrameLevel() + 1);

	-- Create border of scroller
	tempObject = Lunar.Object:Create("container", "LSButtonSettingsListScrollerBorder", tempFrameContainer, "", 31, 133, 0.1, 0.1, 0.1)
	tempObject:ClearAllPoints();
	tempObject:SetPoint("TopRight", tempFrameContainer, "TopRight", -7, sectionY - 13);
	tempObject:SetPoint("BottomRight", tempFrameContainer, "BottomRight", -7, 32);
	tempObject:SetFrameLevel(tempFrameContainer:GetFrameLevel() + 2);
	tempObject:EnableMouseWheel("true");
	tempObject.scrollerName = "LSSettingsButtonSettingsListSlider";
	tempObject:SetScript("OnMouseWheel", Lunar.Settings.OnMouseWheelScroll);

	-- Create slider bar
	tempObject = CreateFrame("Slider", "LSSettingsButtonSettingsListSlider", tempFrameContainer, "LunarVerticalSlider");

	tempObject:SetPoint("TopRight", tempFrameContainer, "TopRight", -15, sectionY - 19);
	tempObject:SetPoint("BottomRight", tempFrameContainer, "BottomRight", -7, 38);
	tempObject:SetWidth(15);
	tempObject:SetValueStep(16);
	tempObject:SetFrameLevel(tempFrameContainer:GetFrameLevel() + 3);
	tempObject:SetMinMaxValues(0, 118); --06);
	tempObject:Show();
	tempObject:SetScript("OnValueChanged",
	function(self)
		_G["LSSettingsButtonSettingsScrollFrame"]:SetVerticalScroll(self:GetValue());
	end);

	-- Scroll frame contents
	tempFrameContainer = Lunar.API:CreateFrame("Frame", "LSSettingsButtonSettingsScrollFrameChild", _G["LSSettingsButtonSettingsScrollFrame"], 184, 400, nil, nil, 0);

	_G["LSSettingsButtonSettingsScrollFrame"]:SetScrollChild(tempFrameContainer);

	_, Lunar.Settings.hasStances = UnitClass("player");

	-- "Use Stances" check box
	if not ((Lunar.Settings.hasStances == "WARRIOR") or (Lunar.Settings.hasStances == "ROGUE") or (Lunar.Settings.hasStances == "DRUID") or (Lunar.Settings.hasStances == "PRIEST") or (Lunar.Settings.hasStances == "SHAMAN")) then
		Lunar.Settings.hasStances = nil;
	end

	tempObject = Lunar.Object:CreateCheckbox(10, -2, Lunar.Locale["USE_STANCES"], "useStances", true, tempFrameContainer,
	function(self)
		Lunar.Button.useStances = (self:GetChecked() == true);
		Lunar.Settings:StanceIconSetup("LSSettings", 192, 24, Lunar.Button.currentStance, Lunar.Button.useStances)
		Lunar.Settings.StanceIcon_Click(_G["LSSettingsStanceIcon" .. Lunar.Button.currentStance])
		Lunar.Settings:ReadButtonSettings();
	end);
	tempObject:SetHitRectInsets(0, -75, 0, 0);

	-- Create our stance placeholder art
	local x;
	for x = 0, 12 do 
		if (x == 0) then
			tempObject = Lunar.Object:CreateImage(108, 0, 24, 24, "StanceIcon0", tempFrameContainer, "$addon\\art\\mouse1");
		else
			if (Lunar.Settings.hasStances) then
				tempObject = Lunar.Object:CreateImage(108 + (x * 24), 0, 24, 24, "StanceIcon" .. x, _G["LSSettingsStanceIcon0"], "$addon\\art\\mouse1");
				tempObject:ClearAllPoints();
				tempObject:SetPoint("Left", _G["LSSettingsStanceIcon" .. (x - 1)], "Right");
			end	
		end
		if (Lunar.Settings.hasStances) or (x == 0) then
			tempObject:SetHighlightTexture("Interface\\Buttons\\CheckButtonHilight"); --Interface\\Buttons\\ButtonHilight-Square");
			tempObject:GetHighlightTexture():SetBlendMode("ADD");
			tempObject:EnableMouse(true);
			tempObject:SetScript("OnEnter", Lunar.Settings.StanceIcon_Enter);
			tempObject:SetScript("OnLeave", Lunar.Settings.StanceIcon_Leave);
			tempObject:SetScript("OnMouseDown", Lunar.Settings.StanceIcon_Click);
			tempObject:SetID(x);
		end
	end

	-- Create our mouse icons (indicating which mouse button the action corresponds to)
	tempObject = Lunar.Object:CreateImage(11, -28, 32, 32, "Mouse1", tempFrameContainer, "$addon\\art\\mouse1");
	tempObject = Lunar.Object:CreateImage(11, -62, 32, 32, "Mouse2", tempFrameContainer, "$addon\\art\\mouse2");
	tempObject = Lunar.Object:CreateImage(11, -96, 32, 32, "Mouse3", tempFrameContainer, "$addon\\art\\mouse3");

	-- Create our dropdown objects (can be changed during runtime)
	local dropdownFunc = function(self) Lunar.Settings["updateNeeded" .. string.match(self:GetName(), "%d")] = true; end
	tempObject = Lunar.Object:CreateDropdown(30, -30, 150, "buttonType1", "", "Button_Type", 1, tempFrameContainer, dropdownFunc, true);
	tempObject = Lunar.Object:CreateDropdown(30, -64, 150, "buttonType3", "", "Button_Type", 3, tempFrameContainer, dropdownFunc, true);
	tempObject = Lunar.Object:CreateDropdown(30, -98, 150, "buttonType2", "", "Button_Type", 2, tempFrameContainer, dropdownFunc, true);

	-- Create placeholder images for currently assigned actions
	tempObject = Lunar.Object:CreateIconPlaceholder(219, -28, "buttonAction1", tempFrameContainer, true);
	tempObject = Lunar.Object:CreateIconPlaceholder(219, -62, "buttonAction3", tempFrameContainer, true);
	tempObject = Lunar.Object:CreateIconPlaceholder(219, -96, "buttonAction2", tempFrameContainer, true);

	tempObject = Lunar.Object:CreateButton(254, -29, 62, "KeybindButton1", Lunar.Locale["_KEYBIND"], tempFrameContainer, Lunar.Settings.Keybind_OnClick);
	tempObject:SetHeight(30);
	tempObject:SetID(1);
	tempObject:RegisterForClicks("AnyUp");
	tempObject:SetScript("OnEnter",
		function (self)
			GameTooltip:SetOwner(self, "ANCHOR_CURSOR");
			GameTooltip:SetText(Lunar.Locale["_KEYBIND_TOOLTIP1"]);
			GameTooltip:AddLine(Lunar.Locale["_KEYBIND_TOOLTIP2"]);
			GameTooltip:AddLine(Lunar.Locale["_KEYBIND_TOOLTIP3"]);
			GameTooltip:Show();
		end);
	tempObject:SetScript("OnLeave",
		function ()
			GameTooltip:Hide();
		end);

	tempObject = Lunar.Object:CreateButton(254, -63, 62, "KeybindButton2", Lunar.Locale["_KEYBIND"], tempFrameContainer, Lunar.Settings.Keybind_OnClick);
	tempObject:SetHeight(30);
	tempObject:SetID(2);
	tempObject:RegisterForClicks("AnyUp");
	tempObject:SetScript("OnEnter", _G["LSSettingsKeybindButton1"]:GetScript("OnEnter"));
	tempObject:SetScript("OnLeave", _G["LSSettingsKeybindButton1"]:GetScript("OnLeave"));

	tempObject = Lunar.Object:CreateButton(254, -97, 62, "KeybindButton3", Lunar.Locale["_KEYBIND"], tempFrameContainer, Lunar.Settings.Keybind_OnClick);
	tempObject:SetHeight(30);
	tempObject:SetID(3);
	tempObject:RegisterForClicks("AnyUp");
	tempObject:SetScript("OnEnter", _G["LSSettingsKeybindButton1"]:GetScript("OnEnter"));
	tempObject:SetScript("OnLeave", _G["LSSettingsKeybindButton1"]:GetScript("OnLeave"));

	-- Create container for icon, count, cooldown options
	tempObject = Lunar.Object:Create("container", "LSSetttingsClickTypeContainer", tempFrameContainer, "", 286, 98, 0.0, 0.3, 0.0);
	tempObject:SetPoint("Topleft", tempFrameContainer, "Topleft", 20, -132);

	-- Create click type icons for assigning counts and icons and cooldowns
	tempObject = Lunar.Object:CreateImage(162, -144, 26, 26, "clickType0", tempFrameContainer, "Interface\\Buttons\\UI-GroupLoot-Pass-Up");
	tempObject = Lunar.Object:CreateImage(198, -144, 26, 26, "clickType1", tempFrameContainer, "$addon\\art\\mouse1");
	tempObject = Lunar.Object:CreateImage(234, -144, 26, 26, "clickType2", tempFrameContainer, "$addon\\art\\mouse2");
	tempObject = Lunar.Object:CreateImage(270, -144, 26, 26, "clickType3", tempFrameContainer, "$addon\\art\\mouse3");

	-- Create Show Icon Caption
	tempObject = Lunar.Object:CreateCaption(34, -172, 150, 20, Lunar.Locale["SHOW_ICON"], "showIconCaption", tempFrameContainer);

	-- Create Checkboxes for Show Icon
	local index;
	for x = 0, 3 do 
		index = x;
		if (index == 2) then
			index = 3;
		elseif (index == 3) then
			index = 2;
		end

		tempObject = Lunar.Object:CreateCheckbox(165 + (x * 36), -172, "", "showIcon" .. index, true, tempFrameContainer, Lunar.Settings.ShowIconFunction);
		tempObject:SetID(index);
		tempObject:SetHitRectInsets(-4, -4, 3, 3);
	end

	-- Create Show Count Caption
	tempObject = Lunar.Object:CreateCaption(34, -188, 150, 20, Lunar.Locale["SHOW_COUNT"], "showCountCaption", tempFrameContainer);

	-- Create Checkboxes for Show Count
	for x = 0, 3 do 
		index = x;
		if (index == 2) then
			index = 3;
		elseif (index == 3) then
			index = 2;
		end
		tempObject = Lunar.Object:CreateCheckbox(165 + (x * 36), -188, "", "showCount" .. index, true, tempFrameContainer, Lunar.Settings.ShowCountFunction);
		tempObject:SetID(index);
		tempObject:SetHitRectInsets(-4, -4, 3, 3);
	end

	-- Create Show Cooldown Caption
	tempObject = Lunar.Object:CreateCaption(34, -204, 150, 20, Lunar.Locale["SHOW_COOLDOWN"], "showCooldownCaption", tempFrameContainer);

	-- Create Checkboxes for Show Cooldown
	for x = 0, 3 do 
		index = x;
		if (index == 2) then
			index = 3;
		elseif (index == 3) then
			index = 2;
		end
		tempObject = Lunar.Object:CreateCheckbox(165 + (x * 36), -204, "", "showCooldown" .. index, true, tempFrameContainer, Lunar.Settings.ShowCooldownFunction);
		tempObject:SetID(index);
		tempObject:SetHitRectInsets(-4, -4, 3, 3);
	end

	-- Create Set button padding Checkbox (only visible on child buttons)
	tempObject = Lunar.Object:CreateCheckbox(10, -230, Lunar.Locale["SET_BUTTON_PADDING"], "useButtonPadding", true, tempFrameContainer,
	function(self)
		LunarSphereSettings.buttonData[Lunar.Settings.buttonEdit].useButtonPadding = self:GetChecked();
		Lunar.Button:SetupMenuAngle(_G["LunarSub" .. Lunar.Settings.buttonEdit .. "Button"].parentID);
	end);

	-- Create Button padding slider (only visible on child buttons)
	tempObject = Lunar.Object:CreateSlider(148, -232, "", "buttonPadding", tempFrameContainer, 0, 1000, 1, 
	function (self) 
		LunarSphereSettings.buttonData[Lunar.Settings.buttonEdit].buttonPadding = self:GetValue();
		Lunar.Button:SetupMenuAngle(_G["LunarSub" .. Lunar.Settings.buttonEdit .. "Button"].parentID);
	end, true);
	tempObject:SetWidth(124);

	tempFrameContainer = Lunar.API:CreateFrame("frame", "LSSettingsMainButtonOptions", tempFrameContainer, 326, 332, nil, nil, 0)
	tempFrameContainer:SetPoint("Topleft", "LSSettingsButtonSettingsScrollFrameChild", "Topleft", 0, -232);
--	tempFrameContainer:SetPoint("Topleft", _G[Lunar.Settings.ButtonDialog:GetName() .. "WindowContainer"], "Topleft", 0, -232);
	
	-- Create Set button scale Checkbox
	tempObject = Lunar.Object:CreateCheckbox(10, 2, Lunar.Locale["SET_BUTTON_SCALE"], "useButtonScale", true, tempFrameContainer, Lunar.Settings.SetUseButtonMenuValue);

	-- Create Button scale slider
	tempObject = Lunar.Object:CreateSlider(148, 0, "", "buttonScale", tempFrameContainer, 0.1, 6.0, 0.01, Lunar.Settings.SetButtonMenuValue, true);
	tempObject:SetWidth(124);

	-- Create Set child button scale Checkbox
	tempObject = Lunar.Object:CreateCheckbox(10, -17, Lunar.Locale["SET_CHILD_SCALE"], "useChildScale", true, tempFrameContainer, Lunar.Settings.SetUseButtonMenuValue);

	-- Create Child button scale slider
	tempObject = Lunar.Object:CreateSlider(148, -19, "", "childScale", tempFrameContainer, 0.1, 6.0, 0.01, Lunar.Settings.SetButtonMenuValue, true);
	tempObject:SetWidth(124);

	-- Create Set child button spacing Checkbox
	tempObject = Lunar.Object:CreateCheckbox(10, -36, Lunar.Locale["SET_CHILD_SPACING"], "useChildSpacing", true, tempFrameContainer, Lunar.Settings.SetUseButtonMenuValue);

	-- Create Child button spacing slider
	tempObject = Lunar.Object:CreateSlider(148, -38, "", "childSpacing", tempFrameContainer, 0, 1000, 1, Lunar.Settings.SetButtonMenuValue, true);
	tempObject:SetWidth(124);

	-- Create Set menu angle Checkbox
	tempObject = Lunar.Object:CreateCheckbox(10, -55, Lunar.Locale["SET_MENU_ANGLE"], "useMenuAngle", true, tempFrameContainer, Lunar.Settings.SetUseButtonMenuValue);

	-- Create Menu angle slider
	tempObject = Lunar.Object:CreateSlider(148, -57, "", "menuAngle", tempFrameContainer, 0, 360, 1, Lunar.Settings.SetButtonMenuValue, true);
	tempObject:SetWidth(124);

	-- Create Set menu offset Checkbox
	tempObject = Lunar.Object:CreateCheckbox(10, -74, Lunar.Locale["SET_MENU_OFFSET"], "useMenuOffset", true, tempFrameContainer, Lunar.Settings.SetUseButtonMenuValue);

	-- Create Menu offset slider
	tempObject = Lunar.Object:CreateSlider(148, -76, "", "menuOffset", tempFrameContainer, 0, 360, 1, Lunar.Settings.SetButtonMenuValue, true);
	tempObject:SetWidth(124);

	-- Submenu button count caption
	tempObject = Lunar.Object:CreateCaption(10, -93, 100, 20, Lunar.Locale["BUTTON_SUB_COUNT"], "subButtonCountCaption", tempFrameContainer, true);

	-- Submenu button count slider
	tempObject = Lunar.Object:CreateSlider(148, -95, "", "subButtonCount", tempFrameContainer, 1, 12, 1,
	function (self)
		if (Lunar.Settings.buttonEdit > 0) and (Lunar.Settings.buttonEdit <= 10) then
			LunarSphereSettings.buttonData[Lunar.Settings.buttonEdit].subButtonCount = self:GetValue();
			Lunar.Button:ShowEmptyMenuButtons();
		end
	end, true);
	tempObject:SetWidth(124);

	-- Create container for visibility rule options
	tempObject = Lunar.Object:Create("container", "LSSetttingsVisibilityContainer", tempFrameContainer, "", 286, 90, 0.0, 0.3, 0.0);
	tempObject:SetPoint("Topleft", tempFrameContainer, "Topleft", 20, -115);

	-- Create Visibility Captions
	offsetY = -107 - 12;
	tempObject = Lunar.Object:CreateCaption(170, offsetY, 90, 20, Lunar.Locale["_BUTTON"], "buttonCaption", tempFrameContainer, true);
	_G[tempObject:GetName() .. "Text"]:SetWidth(90);
	_G[tempObject:GetName() .. "Text"]:SetJustifyH("CENTER");
	tempObject = Lunar.Object:CreateCaption(220, offsetY, 90, 20, Lunar.Locale["_SUBMENU"], "submenuCaption", tempFrameContainer, true);
	_G[tempObject:GetName() .. "Text"]:SetWidth(90);
	_G[tempObject:GetName() .. "Text"]:SetJustifyH("CENTER");
	tempObject = Lunar.Object:CreateCaption(34, offsetY - 16, 150, 20, Lunar.Locale["_SHOW_IN_COMBAT"], "showInCombatCaption", tempFrameContainer, true);
	tempObject = Lunar.Object:CreateCaption(34, offsetY - 30, 150, 20, Lunar.Locale["_HIDE_IN_COMBAT"], "hideInCombatCaption", tempFrameContainer, true);
	tempObject = Lunar.Object:CreateCaption(34, offsetY - 44, 150, 20, Lunar.Locale["_SHOW_OUT_OF_COMBAT"], "showOutOfCombatCaption", tempFrameContainer, true);
	tempObject = Lunar.Object:CreateCaption(34, offsetY - 58, 150, 20, Lunar.Locale["_HIDE_OUT_OF_COMBAT"], "hideOutOfCombatCaption", tempFrameContainer, true);

	-- Create Checkboxes for Visibility options
	for x = 0, 1 do 
		tempObject = Lunar.Object:CreateCheckbox(204 + (50 * x), offsetY - 16, "", "visibleOption0" .. x, true, tempFrameContainer, Lunar.Settings.ButtonVisibilityFunction);
		tempObject:SetID(LUNAR_GET_SHOW_COMBAT);
		tempObject:SetHitRectInsets(-4, -4, 3, 3);
		tempObject = Lunar.Object:CreateCheckbox(204 + (50 * x), offsetY - 30, "", "visibleOption1" .. x, true, tempFrameContainer, Lunar.Settings.ButtonVisibilityFunction);
		tempObject:SetID(LUNAR_GET_HIDE_COMBAT);
		tempObject:SetHitRectInsets(-4, -4, 3, 3);
		tempObject = Lunar.Object:CreateCheckbox(204 + (50 * x), offsetY - 44, "", "visibleOption2" .. x, true, tempFrameContainer, Lunar.Settings.ButtonVisibilityFunction);
		tempObject:SetID(LUNAR_GET_SHOW_NO_COMBAT);
		tempObject:SetHitRectInsets(-4, -4, 3, 3);
		tempObject = Lunar.Object:CreateCheckbox(204 + (50 * x), offsetY - 58, "", "visibleOption3" .. x, true, tempFrameContainer, Lunar.Settings.ButtonVisibilityFunction);
		tempObject:SetID(LUNAR_GET_HIDE_NO_COMBAT);
		tempObject:SetHitRectInsets(-4, -4, 3, 3);
	end

	-- Create Detach from sphere Checkbox
	tempObject = Lunar.Object:CreateCheckbox(10, offsetY - 84, Lunar.Locale["DETACH_FROM_SPHERE"], "detached", true, _G["LSSettingsMainButtonOptions"],
	function (self)
		LunarSphereSettings.buttonData[Lunar.Settings.buttonEdit].detached = self:GetChecked();
		Lunar.Button:SetupMenuAngle(Lunar.Settings.buttonEdit);
	end);

	offsetY = offsetY - 84 - 20

	-- Create Menu Opening options caption
	tempObject = Lunar.Object:CreateCaption(10, offsetY, 100, 20, "|cFFFFFFFF" .. Lunar.Locale["MENU_BUTTON_OPTIONS"], "menuButtonOptionsCaption", tempFrameContainer);
	tempObject = Lunar.Object:CreateDropdown(-4, offsetY - 30, 270, "menuType", Lunar.Locale["MENU_OPEN_TYPE"], "Menu_Open_Type", 0, tempFrameContainer, Lunar.API.BlankFunction, true);

	-- Create Set menu close delay timer Checkbox
	tempObject = Lunar.Object:CreateCheckbox(10, offsetY - 58, Lunar.Locale["MENU_USE_DELAY"], "menuUseDelay", true, tempFrameContainer, Lunar.Settings.SetUseButtonMenuValue);

	-- Create Menu delay timer slider
	tempObject = Lunar.Object:CreateSlider(148, offsetY - 60, "", "menuDelay", tempFrameContainer, 0.1, 10, 0.1, Lunar.Settings.SetButtonMenuValue, true);
	tempObject:SetWidth(124);

	-- Create Set menu close upon clicking submenu action Checkbox
	tempObject = Lunar.Object:CreateCheckbox(10, offsetY - 74, Lunar.Locale["MENU_USE_SUBMENU_CLOSE"], "menuUseSubmenuClose", true, tempFrameContainer, Lunar.Settings.SetUseButtonMenuValue);

	-- Create "Apply to all menu buttons" button
	tempObject = Lunar.Object:CreateButton(10, offsetY - 100, 192, "ApplyToAllMenus", Lunar.Locale["MENU_APPLY_ALL"], tempFrameContainer,
	function(self)
		local index, db, dbSet;
		dbSet = LunarSphereSettings.buttonData[Lunar.Settings.buttonEdit];
		dbSet.menuUseDelay = _G["LSSettingsmenuUseDelay"]:GetChecked();
		dbSet.menuDelay = _G["LSSettingsmenuDelay"]:GetValue();
		dbSet.menuUseSubmenuClose = _G["LSSettingsmenuUseSubmenuClose"]:GetChecked();
		for index = 1, 3 do 
			if (_G["LSSettingsmenuType"].selectedName == Lunar.Object.dropdownData["Menu_Open_Type"][index][1]) then
				dbSet.menuType = index;
				break;
			end
		end
		for index = 1, 10 do 
			db = LunarSphereSettings.buttonData[index];
			db.menuType = dbSet.menuType;
			db.menuDelay = dbSet.menuDelay;
			db.menuUseDelay = dbSet.menuUseDelay;
			db.menuUseSubmenuClose = dbSet.menuUseSubmenuClose;
		end
--		Lunar.Button:ToggleMenuAutoHide();
	end);

	-- Button on bottom-center of window
	tempObject = Lunar.Object:CreateButton(56, -442, 92, "SaveButtonEditButton", SAVE, _G[Lunar.Settings.ButtonDialog:GetName() .. "WindowContainer"],
	function(self)
		local clickType;

		-- First, see if any menus need to be made or preserved. If so, mark 'em
		for clickType = 1, 3 do
			if (Lunar.Settings["updateNeeded" .. Lunar.Button.defaultStance .. clickType]) then
				if (Lunar.Button:GetButtonType(Lunar.Settings.buttonEdit, Lunar.Button.defaultStance, clickType, true) == 2) then
					Lunar.Button:SetButtonType(Lunar.Settings.buttonEdit, Lunar.Button.defaultStance, clickType, 2);
				end
			end
		end

		-- Update menu opening options
		if (Lunar.Settings.buttonEdit > 0) and (Lunar.Settings.buttonEdit <= 10) then
			LunarSphereSettings.buttonData[Lunar.Settings.buttonEdit].menuUseDelay = _G["LSSettingsmenuUseDelay"]:GetChecked();
			LunarSphereSettings.buttonData[Lunar.Settings.buttonEdit].menuDelay = _G["LSSettingsmenuDelay"]:GetValue();
			local menuCheck;
			for menuCheck = 1, 3 do 
				if (_G["LSSettingsmenuType"].selectedName == Lunar.Object.dropdownData["Menu_Open_Type"][menuCheck][1]) then
					LunarSphereSettings.buttonData[Lunar.Settings.buttonEdit].menuType = menuCheck;
					break;
				end
			end
		end

		-- Save the stance using data
		if (Lunar.Settings.buttonEdit <= 10) then
			if (Lunar.Button.useStances == false) then
				Lunar.Button.useStances = false; -- Here = nil;
			end
			if (LunarSphereSettings.buttonData[Lunar.Settings.buttonEdit].useStances ~= Lunar.Button.useStances) then
				LunarSphereSettings.buttonData[Lunar.Settings.buttonEdit].useStances = Lunar.Button.useStances;
				if (Lunar.Settings.buttonEdit > 0) then
					Lunar.Button:SetupStances(_G["LunarMenu" .. Lunar.Settings.buttonEdit .. "Button"]);
					for button = 1, 12 do 
						Lunar.Button:SetupStances(_G["LunarSub" .. (10 + ((Lunar.Settings.buttonEdit-1) * 12) + button) .. "Button"]);
					end
				else
					Lunar.Button:SetupStances(_G["LSmain"]);
				end						
			end
		end

		local savedType, actionName, actionType, actionTexture, buttonType;
		local maxStances = Lunar.Button.defaultStance;
		if (Lunar.Settings.hasStances) then
			maxStances = 12;
		end

		if (Lunar.Settings.buttonEdit > 10) then
			button = _G["LunarSub" .. Lunar.Settings.buttonEdit .. "Button"]
		elseif (Lunar.Settings.buttonEdit == 0) then
			button = _G["LSmain"]
		else
			button = _G["LunarMenu" .. Lunar.Settings.buttonEdit .. "Button"]
		end

		LunarSphereSettings.buttonData[Lunar.Settings.buttonEdit].buttonSettings = Lunar.Button.cached_buttonSettings;
		LunarSphereSettings.buttonData[Lunar.Settings.buttonEdit].keybindData = Lunar.Button.cached_keybindData;

		-- Now, scan for new changes
		for stance = Lunar.Button.defaultStance, maxStances do --12 do 

			for clickType = 1, 3 do

				if (Lunar.Settings["updateNeeded" .. stance .. clickType]) then

					buttonType = Lunar.Button:GetButtonType(Lunar.Settings.buttonEdit, stance, clickType, true);
					if (not buttonType) then
						buttonType = 0;
					end

					-- We update differently for different button types, if they exist
					if (buttonType) then
						if (stance == Lunar.Button.defaultStance) then
							if (Lunar.Button:GetButtonType(Lunar.Settings.buttonEdit, stance, clickType) == 2) then
								if not (buttonType == 2) then
									Lunar.Button:SetButtonType(Lunar.Settings.buttonEdit, stance, clickType, buttonType);
									Lunar.Button:SetupAsMenu(button, clickType, false)
									Lunar.Button:MenuDestroyCheck(Lunar.Settings.buttonEdit);
								end
							end
						end

						-- Type: None
						if (buttonType == 0) then

							button:SetAttribute("*type-S" .. stance .. clickType, "spell");
							button:SetAttribute("*spell-S" .. stance .. clickType, "");
								
							Lunar.Button:SetButtonData(Lunar.Settings.buttonEdit, stance, clickType, 0, "", "", " ");

						-- Type: Spell/Item/Macro (and the self-cast or quick-swap versions)
						elseif (buttonType == 1) or (buttonType == 5) or (buttonType == 6) then

							buttonType, actionType, actionName, actionTexture = Lunar.Button:GetButtonData(Lunar.Settings.buttonEdit, stance, clickType, true);
							Lunar.Button:SetButtonData(Lunar.Settings.buttonEdit, stance, clickType, buttonType, actionType, actionName, actionTexture);
							LunarSphereSettings.buttonData[Lunar.Settings.buttonEdit].empty = false;

							GameTooltip:Hide();
									
						-- Type: Menu
						elseif (buttonType == 2) then
							if (not Lunar.Button.updateType) then
								Lunar.Button.updateType = "spell";
								Lunar.Button.updateID = nil;
							end
							button:SetAttribute("*type-S" .. stance .. clickType, "spell");
							button:SetAttribute("*spell-S" .. stance .. clickType, "");
							button:SetAttribute("*item-S" .. stance .. clickType, "");
							button:SetAttribute("*macro-S" .. stance .. clickType, "");
							_, _,_ , actionTexture = Lunar.Button:GetButtonData(Lunar.Settings.buttonEdit, stance, clickType, true);
							Lunar.Button:SetButtonData(Lunar.Settings.buttonEdit, stance, clickType, buttonType, nil, nil, actionTexture);
							Lunar.Button:ConvertToMenu(button, clickType);
							Lunar.Sphere:ShowSphereEditGlow(LunarSphereSettings.showSphereEditGlow);
							GameTooltip:Hide();

						elseif (buttonType >= 3) then
							
							savedType = Lunar.Button:GetButtonType(Lunar.Settings.buttonEdit, stance, clickType);

							-- If the button is currently a menu, and this assignment will wipe all menu actions
							-- from the button, wipe the menu completely
							if (stance == 0) then
								if (LunarSphereSettings.buttonData[Lunar.Settings.buttonEdit].isMenu == true) then
									Lunar.Button:SetupAsMenu(button, clickType, false)
									Lunar.Button:SetButtonType(Lunar.Settings.buttonEdit, stance, clickType, 0);
									Lunar.Button:MenuDestroyCheck(Lunar.Settings.buttonEdit)
								end
							end

							-- Use last submenu item and Second to last submenu item
							if (buttonType == 3) or (buttonType == 4) then
								button:SetAttribute("*type-S" .. stance .. clickType, "spell");
								button:SetAttribute("*spell-S" .. stance .. clickType, "");
								button:SetAttribute("*item-S" .. stance .. clickType, "");
								button:SetAttribute("*macro-S" .. stance .. clickType, "");
								if (buttonType == 3) then
									button.subButtonType = nil;
								else
									button.subButtonType2 = nil;
								end
								Lunar.Button:SetButtonData(Lunar.Settings.buttonEdit, stance, clickType, buttonType, "spell", "", "");
								LunarSphereSettings.buttonData[Lunar.Settings.buttonEdit].empty = false;
								Lunar.Button:Update(button);
								GameTooltip:Hide();

							-- Auto-assign button types (potions, food, mounts, etc)
							elseif ((buttonType >= 10) and (buttonType <= 111)) or ((buttonType >= 130) and (buttonType <= 149)) then
								-- Equipment set
								if (buttonType == 133) then
									Lunar.Button.updateType = "equipmentset";
									_, _, Lunar.Button.updateID = Lunar.Button:GetButtonData(Lunar.Settings.buttonEdit, stance, clickType, true);
									if (Lunar.Button.updateID) then
										Lunar.Button.updateID = string.gsub(Lunar.Button.updateID, "/equipset ", "");
									else
										button:SetAttribute("*type-S" .. stance .. clickType, "spell");
										button:SetAttribute("*spell-S" .. stance .. clickType, "");
										Lunar.Button:SetButtonData(Lunar.Settings.buttonEdit, stance, clickType, 0, "", "", " ");
										buttonType = 0;
									end
								end
								if (buttonType ~= 0) then
									Lunar.Button:AssignByType(button, clickType, buttonType, stance);
								end
								GameTooltip:Hide();

							-- Weapon apply actions
							elseif ((buttonType >= 112) and (buttonType <= 122)) then
								-- Check if there is update data. If there isn't, check if
								-- we have previous data that came from an item. If so, set
								-- that as our update data.
								if (not Lunar.Button.updateType) then
									_, actionType, actionName = Lunar.Button:GetButtonData(Lunar.Settings.buttonEdit, stance, clickType, true);
--									if (actionType == "item") then
									if actionType then
										Lunar.Button.updateType = actionType;
										Lunar.Button.updateData = actionName;
									end
								end
								if (Lunar.Button.updateType) then
									Lunar.Button:AssignByType(button, clickType, buttonType, stance);
									GameTooltip:Hide();
								else
									Lunar.Button:SetButtonType(Lunar.Settings.buttonEdit, stance, clickType, savedType);
								end
							end
						end
					end			
				end
			end
		end

		if (Lunar.Settings.buttonEdit > 0) then
			_G[button:GetName() .. "Icon"]:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Background");
			SetPortraitToTexture(_G[button:GetName() .. "Icon"], _G[button:GetName() .. "Icon"]:GetTexture());
			button:GetNormalTexture():SetVertexColor(unpack(LunarSphereSettings.buttonColor));
			button:GetPushedTexture():SetVertexColor(unpack(LunarSphereSettings.buttonColor));

			button:SetAttribute("width", 4);
			button:SetWidth(4);

			Lunar.Button:FixMenus();
			if (LunarSphereSettings.buttonData[Lunar.Settings.buttonEdit].empty) then
				_G[button:GetName() .. "Count"]:Hide();
				_G[button:GetName() .. "Icon"]:SetAlpha(0.5);
			end
		end
		Lunar.Button:LoadButtonData(Lunar.Settings.buttonEdit);

		if (Lunar.Settings.buttonEdit > 10) then
			_G["LunarMenu" .. button.parentID .. "ButtonHeader"]:SetAttribute("_bindingset", "");
			_G["LunarMenu" .. button.parentID .. "ButtonHeader"]:SetAttribute("state-state", _G["LunarMenu" .. button.parentID .. "ButtonHeader"]:GetAttribute("state"));
		elseif (Lunar.Settings.buttonEdit == 0) then
			_G["LunarSphereMainButtonHeader"]:SetAttribute("_bindingset", "");
			_G["LunarSphereMainButtonHeader"]:SetAttribute("state-state", _G["LunarSphereMainButtonHeader"]:GetAttribute("state"));
			Lunar.Sphere:SetSphereTexture();
		else		
			_G["LunarSphereButtonHeader"]:SetAttribute("_bindingset", "");
			_G["LunarSphereButtonHeader"]:SetAttribute("state-state", _G["LunarSphereButtonHeader"]:GetAttribute("state"));
		end

		-- Update menu opening types
		Lunar.Button:ToggleMenuAutoHide();

		Lunar.Button:ShowEmptyMenuButtons()
		collectgarbage();
		
		Lunar.Settings.buttonEditCache = nil;
		Lunar.Settings.ButtonDialog:Hide();
		Lunar.Settings.buttonEdit = nil;

		Lunar.API:SupportForDrDamage();

	end);

	-- Create the OnShow event. This will populate our lists and icons with the data the button has.
	tempObject:SetScript("OnShow",
	function (self)

		if (Lunar.Settings.buttonEdit) then

			Lunar.Settings.buttonEditCache = Lunar.API:CopyTable(LunarSphereSettings.buttonData[Lunar.Settings.buttonEdit]);

			_G["LSSettingsshowIcon0"]:Hide();
			local slider = _G["LSSettingsButtonSettingsListSlider"];

			if (Lunar.Settings.buttonEdit == 0) then
				_G[Lunar.Settings.ButtonDialog:GetName() .. "WindowContainer"]:SetHeight(273);
				_G["LSSettingsshowIcon0"]:Show();
				_G["LSSettingsMainButtonOptions"]:Hide();
				_G["LSSettingsbuttonPadding"]:Hide();
				_G["LSSettingsuseButtonPadding"]:Hide();
				slider:GetThumbTexture():SetVertexColor(0.5,0.5,0.5);
				slider:SetMinMaxValues(0, 0);

				_G["LSSettingsshowCountCaption"]:Hide();
				_G["LSSettingsshowCooldownCaption"]:Hide();
				local x;
				for x = 0, 3 do 
					_G["LSSettingsshowCount" .. x]:Hide();
					_G["LSSettingsshowCooldown" .. x]:Hide();
				end

			elseif (Lunar.Settings.buttonEdit > 10) then
				_G[Lunar.Settings.ButtonDialog:GetName() .. "WindowContainer"]:SetHeight(294);
				_G["LSSettingsMainButtonOptions"]:Hide();
				_G["LSSettingsbuttonPadding"]:Show();
				_G["LSSettingsuseButtonPadding"]:Show();
				_G["LSSettingsbuttonPadding"]:SetValue(LunarSphereSettings.buttonData[Lunar.Settings.buttonEdit].buttonPadding or 0);
				_G["LSSettingsuseButtonPadding"]:SetChecked(LunarSphereSettings.buttonData[Lunar.Settings.buttonEdit].useButtonPadding);
				slider:GetThumbTexture():SetVertexColor(0.5,0.5,0.5);
				slider:SetMinMaxValues(0, 0);

				_G["LSSettingsshowCountCaption"]:Show();
				_G["LSSettingsshowCooldownCaption"]:Show();
				local x;
				for x = 0, 3 do 
					_G["LSSettingsshowCount" .. x]:Show();
					_G["LSSettingsshowCooldown" .. x]:Show();
				end

			else
				_G["LSSettingsbuttonPadding"]:Hide();
				_G["LSSettingsuseButtonPadding"]:Hide();
				_G[Lunar.Settings.ButtonDialog:GetName() .. "WindowContainer"]:SetHeight(446 + 10);
				_G["LSSettingsMainButtonOptions"]:Show();
				_G["LSSettingsuseMenuAngle"]:SetChecked(LunarSphereSettings.buttonData[Lunar.Settings.buttonEdit].useMenuAngle);
				_G["LSSettingsmenuAngle"]:SetValue(LunarSphereSettings.buttonData[Lunar.Settings.buttonEdit].menuAngle or 0);
				_G["LSSettingsuseMenuOffset"]:SetChecked(LunarSphereSettings.buttonData[Lunar.Settings.buttonEdit].useMenuOffset);
				_G["LSSettingsmenuOffset"]:SetValue(LunarSphereSettings.buttonData[Lunar.Settings.buttonEdit].menuOffset or 0);
				_G["LSSettingsuseChildScale"]:SetChecked(LunarSphereSettings.buttonData[Lunar.Settings.buttonEdit].useChildScale);
				_G["LSSettingschildScale"]:SetValue(LunarSphereSettings.buttonData[Lunar.Settings.buttonEdit].childScale or 1.0);
				_G["LSSettingsuseChildSpacing"]:SetChecked(LunarSphereSettings.buttonData[Lunar.Settings.buttonEdit].useChildSpacing);
				_G["LSSettingschildSpacing"]:SetValue(LunarSphereSettings.buttonData[Lunar.Settings.buttonEdit].childSpacing or 4);
				_G["LSSettingsuseButtonScale"]:SetChecked(LunarSphereSettings.buttonData[Lunar.Settings.buttonEdit].useButtonScale);
				_G["LSSettingsbuttonScale"]:SetValue(LunarSphereSettings.buttonData[Lunar.Settings.buttonEdit].buttonScale or 1.0);
				_G["LSSettingsdetached"]:SetChecked(LunarSphereSettings.buttonData[Lunar.Settings.buttonEdit].detached);
				_G["LSSettingssubButtonCount"]:SetValue(LunarSphereSettings.buttonData[Lunar.Settings.buttonEdit].subButtonCount or 12);

				-- Setup the menu open type settings
				local dropdown = _G["LSSettingsmenuType"];
				UIDropDownMenu_SetText(dropdown, Lunar.Object.dropdownData["Menu_Open_Type"][LunarSphereSettings.buttonData[Lunar.Settings.buttonEdit].menuType or (1)][1], dropdown);
--				UIDropDownMenu_SetSelectedName(dropdown, Lunar.Object.dropdownData["Menu_Open_Type"][LunarSphereSettings.buttonData[Lunar.Settings.buttonEdit].menuType or (1)][1]);
				_G["LSSettingsmenuUseDelay"]:SetChecked(LunarSphereSettings.buttonData[Lunar.Settings.buttonEdit].menuUseDelay or (false));
				_G["LSSettingsmenuDelay"]:SetValue(LunarSphereSettings.buttonData[Lunar.Settings.buttonEdit].menuDelay or (3));
				_G["LSSettingsmenuUseSubmenuClose"]:SetChecked(LunarSphereSettings.buttonData[Lunar.Settings.buttonEdit].menuUseSubmenuClose or (false));

				slider:GetThumbTexture():SetVertexColor(1,1,1);
				slider:SetMinMaxValues(0, 144 + 16 + 12);
				slider:SetValue(0);

				_G["LSSettingsshowCountCaption"]:Show();
				_G["LSSettingsshowCooldownCaption"]:Show();
				local x;
				for x = 0, 3 do 
					_G["LSSettingsshowCount" .. x]:Show();
					_G["LSSettingsshowCooldown" .. x]:Show();
				end

			end

			-- Store the button's data in the cache (so we can edit all we want without screwing
			-- up the button
			Lunar.Button.cached_buttonTypeData = LunarSphereSettings.buttonData[Lunar.Settings.buttonEdit].buttonTypeData;
			Lunar.Button.cached_actionData = LunarSphereSettings.buttonData[Lunar.Settings.buttonEdit].actionData;
			Lunar.Button.cached_actionTexture = LunarSphereSettings.buttonData[Lunar.Settings.buttonEdit].actionTexture;
			Lunar.Button.cached_buttonSettings = LunarSphereSettings.buttonData[Lunar.Settings.buttonEdit].buttonSettings;
			Lunar.Button.cached_keybindData = LunarSphereSettings.buttonData[Lunar.Settings.buttonEdit].keybindData;
			if (not Lunar.Button.cached_buttonSettings) then
				if (Lunar.Settings.buttonEdit > 0) then
					Lunar.Button.cached_buttonSettings = string.rep("1110000", 13);
				else
					Lunar.Button.cached_buttonSettings = string.rep("0000000", 13);
				end
			end

			-- Store if this button has stance support. If this is a submenu button, disable
			-- the ability to turn on and off the stance support (this is only handled on menu
			-- buttons)
			Lunar.Button.useStances = Lunar.Button:GetUseStances(Lunar.Settings.buttonEdit);
			if not (Lunar.Settings.hasStances) then
				Lunar.Button.useStances = false; -- Here = nil;
			end

			_G["LSSettingsuseStances"]:SetChecked(Lunar.Button.useStances);
			_G["LSSettingsuseStances"]:Enable();
			_G["LSSettingsuseStancesText"]:SetTextColor(1.0,0.85,0.0);
			if (Lunar.Settings.buttonEdit > 10) or (not Lunar.Settings.hasStances) then
				_G["LSSettingsuseStances"]:Disable();
				_G["LSSettingsuseStancesText"]:SetTextColor(0.5,0.5,0.5);
			end

			-- Grab the current stance we're in for the start of editing
			local stance;
			if (Lunar.Settings.buttonEdit > 10) then
				stance = Lunar.Button:GetAssignedStance(_G["LunarSub" .. Lunar.Settings.buttonEdit .. "Button"], true)
			elseif (Lunar.Settings.buttonEdit == 0)  then
				stance = Lunar.Button:GetAssignedStance(_G["LSmain"], true)
			else
				stance = Lunar.Button:GetAssignedStance(_G["LunarMenu" .. Lunar.Settings.buttonEdit .. "Button"], true)
			end
			Lunar.Button.currentStance = stance;

			Lunar.Settings:StanceIconSetup("LSSettings", 192, 24, stance, Lunar.Button.useStances)

			if (Lunar.Settings.buttonEdit > 0) and (Lunar.Settings.buttonEdit <= 10) then
				local index, visibleValue;
				for index = 0, 3 do 
					visibleValue = Lunar.Button:GetButtonSetting(Lunar.Settings.buttonEdit, stance, index + 4, true);
					_G["LSSettingsvisibleOption" .. index .. "0"]:SetChecked(false);
					_G["LSSettingsvisibleOption" .. index .. "1"]:SetChecked(false);
					if (visibleValue > 1) then
						_G["LSSettingsvisibleOption" .. index .. "1"]:SetChecked(true);
					end
					if (visibleValue == 1) or (visibleValue == 3) then
						_G["LSSettingsvisibleOption" .. index .. "0"]:SetChecked(true);
					end
				end

			end

			-- Clear any saved data from previous edits, also setup our menu locks
			for x = 1, 3 do 

				-- Setup our beginning menu lock data. This is used to transfer the "Open Menu"
				-- selection to all stances in the specified click type, so the menu always
				-- opens with the same button
				if (Lunar.Button:GetButtonType(Lunar.Settings.buttonEdit, Lunar.Button.defaultStance, x) == 2) then
					Lunar.Settings["menuLock" .. x] = true;
				else
					Lunar.Settings["menuLock" .. x] = nil;
				end
			end

			Lunar.Settings:ReadButtonSettings()

		end
	end);

	tempObject:ClearAllPoints();
	tempObject:SetPoint("Bottom", _G[Lunar.Settings.ButtonDialog:GetName() .. "WindowContainer"], "Bottom", -48, 2);

	tempObject = Lunar.Object:CreateButton(176, -442, 92, "CancelButtonEditButton", CANCEL, _G[Lunar.Settings.ButtonDialog:GetName() .. "WindowContainer"],
	function ()
		_G["LSButtonDialog"]:Hide();
	end);

	tempObject:ClearAllPoints();
	tempObject:SetPoint("Bottom", _G[Lunar.Settings.ButtonDialog:GetName() .. "WindowContainer"], "Bottom", 48, 2);

	-- OnHide will delete the reference to the button to edit. May do more later on ...
	Lunar.Settings.ButtonDialog:SetScript("OnHide",
	function ()
		if (Lunar.Settings.buttonEditCache) then
			local id = Lunar.Settings.buttonEdit;
			LunarSphereSettings.buttonData[id] = Lunar.API:CopyTable(Lunar.Settings.buttonEditCache);
			if (id ~= 0) then
				if (id > 10) then
					id = math.floor((id - 11) / 12) + 1;
				end
				Lunar.Button:SetupMenuAngle(id);
			end
			Lunar.Settings.buttonEditCache = nil;
		end
		Lunar.Settings.buttonEdit = nil;
		collectgarbage();
	end);
end

-- /***********************************************
--  * CreateStartupDialog
--  * ========================
--  *
--  * Creates the Startup Message dialog frame that appears at startup ... if enabled
--  *
--  * Accepts: None
--  * Returns: None
--  *********************
function Lunar.Settings:CreateStartupDialog()

	if (LunarSphereSettings.showStartupMessage == true) or (LunarSphereSettings.firstRun) then

		-- Create our locals
		local tempFrame, tempFrameContainer, tempObject, index;

		-- Create our button setting dialog window and assign it to the Settings object.
		-- This frame will be called whenever a button needs to be edited...
		if (LunarSphereSettings.firstRun) then
			Lunar.Settings.StartupDialog = Lunar.Object:Create("window", "LSStartupDialog", UIParent, Lunar.Locale["START_UP_MESSAGE"], 320, 200, 0.0, 1.0, 1.0, nil, nil, nil, true);
		else
			Lunar.Settings.StartupDialog = Lunar.Object:Create("window", "LSStartupDialog", UIParent, Lunar.Locale["START_UP_MESSAGE"], 320, 192, 0.0, 1.0, 1.0);
		end

		Lunar.Settings.StartupDialog:ClearAllPoints();
		Lunar.Settings.StartupDialog:SetPoint("Center", UIParent, "Center", 0, 96);
		Lunar.Settings.StartupDialog:SetFrameStrata("Dialog");
		Lunar.Settings.StartupDialog:Show();

		if (GetCVar("useUiScale") == "1") then
			Lunar.Settings.StartupDialog:SetScale(1 / GetCVar("uiscale"));
		end

		tempFrameContainer = _G[Lunar.Settings.StartupDialog:GetName() .. "WindowContainer"];

		tempObject = Lunar.Object:CreateCaption(13, -8, 150, 20, "|cFFFFFFFF".. (LunarSphereSettings.startupMessage or ("")), "startupMessageContents", tempFrameContainer);
		tempObject:ClearAllPoints();
--		tempObject:SetPoint("TopLeft", tempFrameContainer, "TopLeft", 13, -8);
--		tempObject:SetPoint("BottomRight", tempFrameContainer, "BottomRight", -13, 38);
		_G[tempObject:GetName() .. "Text"]:SetWidth(296);
		_G[tempObject:GetName() .. "Text"]:SetPoint("TopLeft", tempFrameContainer, "TopLeft", 13, -16);
--		_G[tempObject:GetName() .. "Text"]:SetPoint("TopRight", tempFrameContainer, "TopRight", -13, -16);
--		_G[tempObject:GetName() .. "Text"]:SetPoint("Bottom", tempFrameContainer, "Bottom", 0, -800);
				
--		_G[tempObject:GetName() .. "Text"]:SetWidth(164);
--		_G[tempObject:GetName() .. "Text"]:SetHeight(164);
		_G[tempObject:GetName() .. "Text"]:SetJustifyV("Top");
		_G[tempObject:GetName() .. "Text"]:SetJustifyH("Center");
		_G[tempObject:GetName() .. "Text"]:Show();

		if (LunarSphereSettings.firstRun) then
			_G[tempObject:GetName() .. "Text"]:SetPoint("BottomRight", tempFrameContainer, "BottomRight", -13, 96);
		else
			tempFrameContainer:SetHeight(_G[tempObject:GetName() .. "Text"]:GetHeight() + 56);
--			_G[tempObject:GetName() .. "Text"]:SetPoint("BottomRight", tempFrameContainer, "BottomRight", -13, 0);
		end

		if (LunarSphereSettings.firstRun) then
			tempObject:SetPoint("BottomRight", tempFrameContainer, "BottomRight", -13, 96);
			_G["LSStartupDialogCloseButton"]:Disable();
			_G["LSStartupDialogCloseButton"]:GetNormalTexture():SetVertexColor(0.5,0.5,0.5);

			_G[tempObject:GetName() .. "Text"]:SetText(Lunar.Locale["FIRST_TIME_TEXT"]);

			-- Button #1
			tempObject = Lunar.Object:CreateButton(50, -142, 200, "StartupMessageOpt1", Lunar.Locale["FIRST_TIME_OPT1"], tempFrameContainer,
			function()
				LunarSphereSettings.loadTemplate = Lunar.Settings.templateList[2]
				LunarSphereSettings.firstRun = nil;
				ReloadUI();
			end);
			tempObject:ClearAllPoints();
			tempObject:SetPoint("Top", _G["LSSettingsstartupMessageContentsText"], "Bottom", 0, -16);

			-- Button #2
			tempObject = Lunar.Object:CreateButton(50, -142, 200, "StartupMessageOpt2", Lunar.Locale["FIRST_TIME_OPT2"], tempFrameContainer,
			function()
				LunarSphereSettings.loadTemplate = Lunar.Settings.templateList[1]
				LunarSphereSettings.firstRun = nil;
				ReloadUI();
			end);
			tempObject:ClearAllPoints();
			tempObject:SetPoint("Top", _G["LSSettingsStartupMessageOpt1"], "Bottom", 0, -4);

			-- Button #3
			tempObject = Lunar.Object:CreateButton(50, -142, 200, "StartupMessageOpt3", Lunar.Locale["FIRST_TIME_OPT3"], tempFrameContainer,
			function()
				LunarSphereSettings.firstRun = nil;
				Lunar.Settings.StartupDialog:Hide();
			end);
			tempObject:ClearAllPoints();
			tempObject:SetPoint("Top", _G["LSSettingsStartupMessageOpt2"], "Bottom", 0, -4);

		else

			-- Close Button button
			tempObject = Lunar.Object:CreateButton(116, -142, 92, "StartupMessageClose", CLOSE, tempFrameContainer,
			function()
				Lunar.Settings.StartupDialog:Hide();
			end);
			tempObject:ClearAllPoints();
			tempObject:SetPoint("Bottom", 0, 10);
		end
	end
end

-- /***********************************************
--  * ToggleSettingsFrame
--  * ========================
--  *
--  * Shows or hides the settings frame, based upon it's current state
--  *
--  * Accepts: None
--  * Returns: None
--  *********************
function Lunar.Settings:ToggleSettingsFrame()

	-- If it's visible, hide it. If it's hidden, show it
	if (Lunar.Settings.Frame:IsShown()) then
		Lunar.Settings.Frame:Hide();
	else
		Lunar.Settings.Frame:Show();	
	end
end

function Lunar.Settings.StanceIcon_Enter(self)
	self:LockHighlight();
end

function Lunar.Settings.StanceIcon_Leave(self)
	local stanceIconName = string.match(self:GetName(), "LSSettings(.*)Icon");
--	if (_G["LSSettings" .. stanceIconName .. "Icon0"].currentStance ~= self:GetID()) then
	if (Lunar.Button.currentStance ~= self:GetID()) then
		self:UnlockHighlight();
	end
end

function Lunar.Settings.StanceIcon_Click(self, button)
	
	local id = self:GetID();
	if (button) and not (type(button) == "string") then
		id = button:GetID();
	end

--[[	local stanceIconName = string.match(self:GetName(), "LSSettings(.*)Icon");
	local currentStance = _G["LSSettings" .. stanceIconName .. "Icon0"].currentStance or 0;

	_G["LSSettings" .. stanceIconName .. "Icon" .. currentStance]:UnlockHighlight();
	_G["LSSettings" .. stanceIconName .. "Icon" .. currentStance]:GetHighlightTexture():SetVertexColor(1,1,1);
	_G["LSSettings" .. stanceIconName .. "Icon0"].currentStance = self:GetID();
	_G["LSSettings" .. stanceIconName .. "Icon" .. self:GetID()]:LockHighlight();
	_G["LSSettings" .. stanceIconName .. "Icon" .. self:GetID()]:GetHighlightTexture():SetVertexColor(0,1,0);
--]]
	_G["LSSettingsStanceIcon" .. Lunar.Button.currentStance]:UnlockHighlight();
	_G["LSSettingsStanceIcon" .. Lunar.Button.currentStance]:GetHighlightTexture():SetVertexColor(1,1,1);
	Lunar.Button.currentStance = id;
	_G["LSSettingsStanceIcon" .. Lunar.Button.currentStance]:LockHighlight();
	_G["LSSettingsStanceIcon" .. Lunar.Button.currentStance]:GetHighlightTexture():SetVertexColor(0,1,0);

--	if (stanceIconName == "Stance") then
		Lunar.Settings:ReadButtonSettings();
--	elseif (stanceIconName == "SphereStance") then
--		Lunar.Settings:ReadButtonSettings(true);
--	end
end

function Lunar.Settings:ReadButtonSettings(sphere)
	
	local clickType, buttonType, buttonTexture, currentStance, buttonID, useCached, objectName, keybind;

--	if (Lunar.Settings.buttonEdit > 0) then --not (sphere) then
		for clickType = 0, 3 do 
			if (clickType ~= 0) then
				_G["LSSettingsshowIcon" .. clickType]:SetChecked(false);			
			end
			_G["LSSettingsshowCount" .. clickType]:SetChecked(false);
			_G["LSSettingsshowCooldown" .. clickType]:SetChecked(false);
		end

		_G["LSSettingsshowIcon" .. Lunar.Button:GetButtonSetting(Lunar.Settings.buttonEdit, Lunar.Button.currentStance, LUNAR_GET_SHOW_ICON, true)]:SetChecked(true);
		_G["LSSettingsshowCount" .. Lunar.Button:GetButtonSetting(Lunar.Settings.buttonEdit, Lunar.Button.currentStance, LUNAR_GET_SHOW_COUNT, true)]:SetChecked(true);
		_G["LSSettingsshowCooldown" .. Lunar.Button:GetButtonSetting(Lunar.Settings.buttonEdit, Lunar.Button.currentStance, LUNAR_GET_SHOW_COOLDOWN, true)]:SetChecked(true);
		buttonID = Lunar.Settings.buttonEdit;
		currentStance = Lunar.Button.currentStance;
		useCached = true
		objectName = "button"
--	else
--		buttonID = 0;
--		currentStance = _G["LSSettingsSphereStanceIcon0"].currentStance or (0);
--		objectName = "SphereButton"
--	end

	-- Reset the keybind grabber
	Lunar.Settings.ButtonDialog:EnableKeyboard(false);
	Lunar.Settings.ButtonDialog.keybindButton = "";
	Lunar.Settings.ButtonDialog.keybindModifier = "";
	Lunar.Settings.ButtonDialog.activeKeybindButton = nil;

	for clickType = 1, 3 do 

		buttonType, _, _, buttonTexture = Lunar.Button:GetButtonData(buttonID, currentStance, clickType, useCached);

		-- Pull the keybind from stance 0 until we have stance specific keybinds ready.
		keybind = Lunar.Button:GetButtonKeybind(buttonID, 0, clickType, useCached) or Lunar.Locale["_KEYBIND"];
		if not (keybind == Lunar.Locale["_KEYBIND"]) then
			keybind = Lunar.API:ShortKeybindText(keybind);
		end
		_G["LSSettings" .. objectName .. "Type" .. clickType .. "Text"]:SetTextColor(1,1,1);
		_G["LSSettings" .. objectName .. "Type" .. clickType .. "Button"]:Enable();
		if (currentStance > Lunar.Button.defaultStance) and not sphere then
			if (Lunar.Settings["menuLock" .. clickType]) then
				buttonType = 2;
				_G["LSSettingsbuttonType" .. clickType .. "Text"]:SetTextColor(0.5,0.5,0.5);
				_G["LSSettingsbuttonType" .. clickType .. "Button"]:Disable();
			end
		end

		_G["LSSettingsKeybindButton" .. clickType]:SetText(keybind);
		_G["LSSettingsKeybindButton" .. clickType]:UnlockHighlight();

		if (buttonTexture) or (buttonType) then
			if (buttonType == 100) then
				SetPortraitTexture(_G["LSSettings" .. objectName .. "Action" .. clickType .. "Icon"], "player");
			else

				-- Pet action bar buttons and bag buttons can update their icons during the game
				-- so we need to not rely on the current texture saved, but rather, the current
				-- ingame texture being used.
				if (buttonType >= 91 and (buttonType <= 94)) then

					-- Get bag texture
					buttonTexture = Lunar.Button:GetBagTexture(buttonType);
				
				elseif (buttonType >= 140 and (buttonType < 150)) then
					
					-- Get pet bar texture
					local _, _, texture, isToken = GetPetActionInfo(buttonType - 139);
					if ( not isToken ) then
						buttonTexture = texture;
					else
						buttonTexture = _G[texture];
					end

				end
					
				_G["LSSettings" .. objectName .. "Action" .. clickType .. "Icon"]:SetTexture(buttonTexture);
			end
		else
			_G["LSSettings" .. objectName .. "Action" .. clickType .. "Icon"]:SetTexture("");
		end

		if (not buttonType) then
			buttonType = 0;
		end

		if (buttonType) then
					
			-- If the button type is 10 or larger, we need to the current text from a submenu
			-- So, time to crawl through our data
			if (buttonType >= 10) then

				-- Setup our search variables
				local menuIndex = math.floor(buttonType / 10) * 10
				local submenuIndex = buttonType - menuIndex + 1;
				local index;

				-- Search our data on the menus and see if our menuIndex matches. We'll need
				-- this index to pull the localizated menu data later
				for index = 1, table.getn(Lunar.Object.dropdownData["Button_Type"]) do
					if (Lunar.Object.dropdownData["Button_Type"][index][2] == menuIndex) then
						menuIndex = index;
						break;
					end
				end

				-- Write our current submenu text
				UIDropDownMenu_SetSelectedName(_G["LSSettings" .. objectName .. "Type" .. clickType], Lunar.Locale[Lunar.Object.dropdownData["Button_Type"][menuIndex][3] .. submenuIndex]);
				UIDropDownMenu_SetText(_G["LSSettings" .. objectName .. "Type" .. clickType], Lunar.Locale[Lunar.Object.dropdownData["Button_Type"][menuIndex][3] .. submenuIndex]) --, _G["LSSettings" .. objectName .. "Type" .. clickType]);

			-- Otherwise, just display the text like normal
			else
				local menuIndex = buttonType + 1;
				-- Since we re-ordered the menu choices after the fact, we need to re-make some
				-- of the indexes.
				if (buttonType == 2) then
					menuIndex = 5;
				end
				if (buttonType == 3) then
					menuIndex = 6;
				end
				if (buttonType == 4) then
					menuIndex = 7;
				end
				if (buttonType == 5) then
					menuIndex = 3;
				end
				if (buttonType == 6) then
					menuIndex = 4;
				end
				UIDropDownMenu_SetSelectedName(_G["LSSettings" .. objectName .. "Type" .. clickType], Lunar.Object.dropdownData["Button_Type"][menuIndex][1]);
				UIDropDownMenu_SetText(_G["LSSettings" .. objectName .. "Type" .. clickType], Lunar.Object.dropdownData["Button_Type"][menuIndex][1]); --, _G["LSSettings" .. objectName .. "Type" .. clickType]);

			end
		end
		_G["LSSettings" .. objectName .. "Type" .. clickType].selectedValue = buttonType
	end
	
end

function Lunar.Settings:UpdateMainButtons()

	local index;
	for index = 1, 10 do
		Lunar.Button:SetupMenuAngle(index);
	end

	-- Do this to fix the submenu compression.
	if (LunarSphereSettings.buttonEditMode ~= true) then
		Lunar.Button.hiddenButtons = nil;
		Lunar.Button:HideEmptyMenuButtons(true);
	end

end

function Lunar.Settings:SetEnabled(object, isEnabled)

	local objectText = _G[object:GetName() .. "Text"];

	if (isEnabled == true) then
		if (objectText) then
			objectText:SetTextColor(1.0,0.85,0.0);
		end
		object:Enable();
	else
		if (objectText) then
			objectText:SetTextColor(0.5,0.5,0.5);
		end
		object:Disable();
	end
	
end

function Lunar.Settings.List_OnEnter(self)
	if (self.highlight:GetID() ~= self:GetID()) then
		self.highlight:SetID(self:GetID());
		self.highlight:SetPoint("TopLeft",_G[self.highlight.listItemName .. self:GetID()], "Topleft");
	end
	self.highlight:Show();
end

function Lunar.Settings.List_OnLeave(self)
	self.highlight:Hide();
end

function Lunar.Settings.ShowIconFunction(self)
	_G["LSSettingsshowIcon" .. Lunar.Button:GetButtonSetting(Lunar.Settings.buttonEdit, Lunar.Button.currentStance, LUNAR_GET_SHOW_ICON, true)]:SetChecked(false);
	self:SetChecked(true);
	Lunar.Button:SetButtonSetting(Lunar.Settings.buttonEdit, Lunar.Button.currentStance, LUNAR_GET_SHOW_ICON, self:GetID(), true)
end

function Lunar.Settings.ShowCountFunction(self)
	_G["LSSettingsshowCount" .. Lunar.Button:GetButtonSetting(Lunar.Settings.buttonEdit, Lunar.Button.currentStance, LUNAR_GET_SHOW_COUNT, true)]:SetChecked(false);
	self:SetChecked(true);
	Lunar.Button:SetButtonSetting(Lunar.Settings.buttonEdit, Lunar.Button.currentStance, LUNAR_GET_SHOW_COUNT, self:GetID(), true)
end

function Lunar.Settings.ShowCooldownFunction(self)
	_G["LSSettingsshowCooldown" .. Lunar.Button:GetButtonSetting(Lunar.Settings.buttonEdit, Lunar.Button.currentStance, LUNAR_GET_SHOW_COOLDOWN, true)]:SetChecked(false);
	self:SetChecked(true);
	Lunar.Button:SetButtonSetting(Lunar.Settings.buttonEdit, Lunar.Button.currentStance, LUNAR_GET_SHOW_COOLDOWN, self:GetID(), true)
end

function Lunar.Settings.SetUseButtonMenuValue(self)
	LunarSphereSettings.buttonData[Lunar.Settings.buttonEdit][string.match(self:GetName(), "LSSettings(.*)")] = self:GetChecked();
	Lunar.Button:SetupMenuAngle(Lunar.Settings.buttonEdit);
end

function Lunar.Settings.SetButtonMenuValue(self) 
	LunarSphereSettings.buttonData[Lunar.Settings.buttonEdit][string.match(self:GetName(), "LSSettings(.*)")] = self:GetValue();
	Lunar.Button:SetupMenuAngle(Lunar.Settings.buttonEdit);
end

function Lunar.Settings:StanceIconSetup(stanceIconName, stanceIconWidthBoundry, maxIconWidth, currentStance, useStances)

	-- Setup our stance icons. The first stance will always be visible (normal
	-- form) and the others will only be visible if the player has it unlocked and
	-- the "Use Stances" option is turned on.
	local x, maxX, stanceWidth, shiftIcon, shiftID, shiftActive, shiftCastable, iconObject;

	maxX = GetNumShapeshiftForms();

    if (LunarSphereSettings.debugSpellAdd == true) then
        maxX = 8;
    elseif (maxX == 0) then
		maxX = 1;
    end

	stanceWidth = math.floor(stanceIconWidthBoundry / maxX);
	if (stanceWidth > maxIconWidth) then
		stanceWidth = maxIconWidth;
	end
	maxX = Lunar.Button.defaultStance;
	if (Lunar.Settings.hasStances) then
		maxX = 12;
	end
	for x = 0, maxX do 
		iconObject = _G[stanceIconName .. "StanceIcon" .. x];
		if (x == 0) and (Lunar.Button.defaultStance == 0) then
			SetPortraitTexture(iconObject:GetNormalTexture(), "player");
			iconObject:SetWidth(stanceWidth);
		else
			iconObject:SetNormalTexture("");
			iconObject:SetWidth(1);
		end
		if (x > 0) then
			iconObject:SetWidth(1);
			iconObject:Hide();
			if (x <= maxX) then
				if (x == 1) and (Lunar.Button.defaultStance == 1) and not (useStances == true)  then
					SetPortraitTexture(iconObject:GetNormalTexture(), "player");
					iconObject:SetWidth(stanceWidth);
					iconObject:Show();
				else
					shiftIcon, shiftActive, shiftCastable, shiftID = GetShapeshiftFormInfo(x);

				if ((LunarSphereSettings.debugSpellAdd == true) and not shiftIcon) then 
					shiftIcon = "Interface\\Icons\\INV_Misc_QuestionMark";
				end
					-- Rogues have stealth (1) and shadow dance (2), but the shadow
					-- dance is actually stance 3, not 2.
					if (select(2, UnitClass("player")) == "ROGUE") then
						if (x == 2) then
							shiftIcon = nil;
						elseif (x == 3) then
							shiftIcon, shiftActive, shiftCastable, shiftID = GetShapeshiftFormInfo(2);
						end
					end

					if (shiftIcon) then
						if (shiftActive) then
							shiftIcon = GetSpellTexture(shiftID);
						end
						iconObject:SetNormalTexture(shiftIcon);
						iconObject:GetNormalTexture():SetTexCoord(0.1,0.9,0.1,0.9);
						iconObject:SetWidth(stanceWidth);
						if (useStances) then
							iconObject:Show();
						end
						iconObject.stanceName = shiftID;
					end
				end
			end
		end
		iconObject:UnlockHighlight();
		iconObject:GetNormalTexture():SetVertexColor(1,1,1);
		if (currentStance == x) then
			iconObject:LockHighlight();
			iconObject:GetHighlightTexture():SetVertexColor(0,1,0);
			_G[stanceIconName .. "StanceIcon0"].currentStance = x;
		end
	end
	if (Lunar.Button.defaultStance == 1) and (useStances == true) then
		_G[stanceIconName .. "StanceIcon0"]:SetNormalTexture("");
		_G[stanceIconName .. "StanceIcon0"]:EnableMouse(false);
	else
		_G[stanceIconName .. "StanceIcon0"]:EnableMouse(true);
	end
end

local dropInfo = {};
function Lunar.Settings:MenuDropdownInitialize()

	local listName = "Menu_Dropdown";

	if (UIDROPDOWNMENU_MENU_LEVEL == 1) then
		
		for i = 1, table.getn(Lunar.Object.dropdownData[listName]) do

			-- Wipe our information table
			Lunar.Object:WipeDropInfo();
			dropInfo.text = Lunar.Object.dropdownData[listName][i][1];
			dropInfo.value = Lunar.Object.dropdownData[listName][i][2];

			-- If we have a 3rd entry in the dropdownData table, that means we have a submenu and we
			-- need to make sure we can access that menu
			dropInfo.hasArrow = nil;
			dropInfo.checked = nil;
			if (dropInfo.value == 1) and (LunarSphereSettings.sphereMoveable) then
				dropInfo.checked = true;
			elseif (dropInfo.value == 2) and (LunarSphereSettings.buttonEditMode) then
				dropInfo.checked = true;
			elseif (dropInfo.value == 3) and (LunarSphereSettings.detachedMoveable) then
				dropInfo.checked = true;
			end

			dropInfo.func = 
			function(self)

				if (self.value == 0) then
					Lunar.Settings:ToggleSettingsFrame();
				elseif (self.value == 1) then
					LunarSphereSettings.sphereMoveable = not self.checked;
					_G["LSSettingssphereMoveable"]:SetChecked(not self.checked);
				elseif (self.value == 2) then
					LunarSphereSettings.buttonEditMode = not self.checked; 
					_G["LSSettingsbuttonEditMode"]:SetChecked(not self.checked);
					Lunar.Settings.ButtonDialog:Hide();
					if (Lunar.combatLockdown ~= true) then
						Lunar.Sphere:ShowSphereEditGlow(LunarSphereSettings.showSphereEditGlow);
					end
				elseif (self.value == 3) then
					LunarSphereSettings.detachedMoveable = not self.checked;
					_G["LSSettingsdetachedMoveable"]:SetChecked(not self.checked);
				end
			end

			UIDropDownMenu_AddButton(dropInfo);
		end
	end
end

function Lunar.Settings.ButtonVisibilityFunction(self)

	local value = 0;
	local groupName = string.match(self:GetName(), "LSSettings(.*)%d");
	if (_G["LSSettings" .. groupName .. "0"]:GetChecked()) then
		value = value + 1;
	end
	if (_G["LSSettings" .. groupName .. "1"]:GetChecked()) then
		value = value + 2;
	end
	Lunar.Button:SetButtonSetting(Lunar.Settings.buttonEdit, Lunar.Button.currentStance, self:GetID(), tostring(value), true)
end

function Lunar.Settings.Keybind_OnKeyUp(self, button)

	if ( button == "LSHIFT" or button == "RSHIFT" or button == "LCTRL" or button == "RCTRL" or button == "LALT" or button == "RALT" ) then
		local dash = "";
		self.keybindModifier = "";
		if (IsAltKeyDown()) then
			self.keybindModifier = "ALT";
			dash = "-";
		end
		if (IsControlKeyDown()) then
			self.keybindModifier = self.keybindModifier .. dash .. "CTRL";
			dash = "-";
		end
		if (IsShiftKeyDown()) then
			self.keybindModifier = self.keybindModifier .. dash .. "SHIFT";
		end
	end
end

function Lunar.Settings.Keybind_OnKeyDown(self, button, frame)

	local obj = self;
	if (frame) then
		obj = frame;
	end

	if (button == "ESCAPE" ) then
		obj:EnableKeyboard(false);
		obj.activeKeybindButton:SetText(Lunar.Locale["_KEYBIND"]);
		Lunar.Button:SetData(Lunar.Settings.buttonEdit, Lunar.Button.currentStance, obj.activeKeybindButton:GetID(), "keybindData", "", nil, true)
		obj.activeKeybindButton:UnlockHighlight();
		obj.activeKeybindButton.savedText = nil;
		obj.activeKeybindButton = nil;
	else
		if ( GetBindingFromClick(button) == "SCREENSHOT" ) then
			RunBinding("SCREENSHOT");
			return;
		end

		if ( button == "UNKNOWN" ) then
			return;
		end

		if ( button == "LSHIFT" or button == "RSHIFT" or button == "LCTRL" or button == "RCTRL" or button == "LALT" or button == "RALT" ) then
			button = string.sub(button, 2)
			if ( obj.keybindModifier == "" ) then
				obj.keybindModifier = button;
			else
				if not string.find(obj.keybindModifier, button) then
					obj.keybindModifier = obj.keybindModifier .. "-" .. button;
				end	
			end
			return;
		elseif ( obj.keybindButton ~= "" ) then
			return;
		end

		local dash = "";
		obj.keybindModifier = "";
		if (IsAltKeyDown()) then
			obj.keybindModifier = "ALT";
			dash = "-";
		end
		if (IsControlKeyDown()) then
			obj.keybindModifier = obj.keybindModifier .. dash .. "CTRL";
			dash = "-";
		end
		if (IsShiftKeyDown()) then
			obj.keybindModifier = obj.keybindModifier .. dash .. "SHIFT";
		end

		if ( obj.keybindModifier == "" ) then
			obj.keybindButton = button;
		else
			obj.keybindButton = obj.keybindModifier .. "-" .. button;
		end
		obj:EnableKeyboard(false);
		obj.activeKeybindButton:SetText(Lunar.API:ShortKeybindText(obj.keybindButton));
		Lunar.Button:SetData(Lunar.Settings.buttonEdit, Lunar.Button.currentStance, obj.activeKeybindButton:GetID(), "keybindData", obj.keybindButton, nil, true)
		obj.activeKeybindButton:UnlockHighlight();
		obj.activeKeybindButton.savedText = nil;
		obj.activeKeybindButton = nil;
	end
end

function Lunar.Settings.Keybind_OnClick(self, button)


	Lunar.Settings.ButtonDialog:EnableKeyboard(true);
	Lunar.Settings.ButtonDialog.keybindButton = "";
	Lunar.Settings.ButtonDialog.keybindModifier = "";

	if (Lunar.Settings.ButtonDialog.activeKeybindButton) then

		-- If we're already doing the keybind, convert the clicks to assignment names
		if (button == "LeftButton") or (button == "RightButton") then
			Lunar.Settings.ButtonDialog.activeKeybindButton:SetText(Lunar.Settings.ButtonDialog.activeKeybindButton.savedText);
			Lunar.Settings.ButtonDialog.activeKeybindButton.savedText = nil;
			Lunar.Settings.ButtonDialog.activeKeybindButton:UnlockHighlight();
		else
			-- Convert the mouse button names to click names
			if ( button == "LeftButton" ) then
				button = "BUTTON1";
			elseif ( button == "RightButton" ) then
				button = "BUTTON2";
			elseif ( button == "MiddleButton" ) then
				button = "BUTTON3";
			elseif ( button == "Button4" ) then
				button = "BUTTON4"
			elseif ( button == "Button5" ) then
				button = "BUTTON5"
			end
				
			Lunar.Settings:Keybind_OnKeyDown(button, Lunar.Settings.ButtonDialog);
		end
	end

	if (button == "LeftButton") then --or (button == "RightButton") then
		Lunar.Settings.ButtonDialog.activeKeybindButton = self;
		self:LockHighlight();
		self.savedText = self:GetText();
		self:SetText("");
	elseif (button == "RightButton") then
		Lunar.Settings.ButtonDialog:EnableKeyboard(false);
		self:SetText(Lunar.Locale["_KEYBIND"]);
		Lunar.Button:SetData(Lunar.Settings.buttonEdit, Lunar.Button.currentStance, self:GetID(), "keybindData", "", nil, true)
		self:UnlockHighlight();
		self.savedText = nil;
		Lunar.Settings.ButtonDialog.activeKeybindButton = nil;
	end
end

function Lunar.Settings.OnMouseWheelScroll(self, arg1)
	_G[self.scrollerName]:SetValue(
		_G[self.scrollerName]:GetValue()	- (_G[self.scrollerName]:GetValueStep() * arg1));
end

function Lunar.Settings.SetMemoryValue(self)
	Lunar.Object.SetSetting(self);
	Lunar.Settings.memoryEdit[self:GetID()] = not Lunar.Settings.memoryEdit[self:GetID()]
	Lunar.Settings:UpdateMemoryReloadButton()
end

function Lunar.Settings:UpdateGaugeOptions(gaugeID)

	local gaugeName = "inner";
	local gaugeUpper = "Inner";
	local oColor = _G["LSSettingsouterGaugeColor"]
	local iColor = _G["LSSettingsinnerGaugeColor"]
	local oAngle = _G["LSSettingsouterGaugeAngle"]
	local iAngle = _G["LSSettingsinnerGaugeAngle"]
	
	oColor:Hide();
	oAngle:Hide();
	iColor:Show();
	iAngle:Show();
	
	if (gaugeID == 0) then
		gaugeName = "outer";
		gaugeUpper = "Outer";
		oColor:Show();
		oAngle:Show();
		iColor:Hide();
		iAngle:Hide();
	end

	local i, id, subID, db;
	
	id = LunarSphereSettings[gaugeName .. "GaugeType"];
	UIDropDownMenu_SetSelectedValue(_G["LSSettingsgaugeType"], id);

	-- Only do player and target events for now
	if ((id >= 10) and (id < 12)) or ((id >= 20) and (id < 22))  then
		subID = math.fmod(id, 10) + 1;
		id = id - subID + 1;
	end

	db = Lunar.Object.dropdownData["Gauge_Events"];
	for i = 1, table.getn(db) do 
		if (db[i][2] == id) then
			if (subID) then
				_G["LSSettingsgaugeTypeText"]:SetText(Lunar.Locale[db[i][3] .. subID]);
			else
				_G["LSSettingsgaugeTypeText"]:SetText(db[i][1]);
			end
			break;
		end
	end

	id = LunarSphereSettings[gaugeName .. "MarkSize"];
	UIDropDownMenu_SetSelectedValue(_G["LSSettingsmarkSize"], id);
	db = Lunar.Object.dropdownData["Gauge_Marks"];
	for i = 1, table.getn(db) do 
		if (db[i][2] == id) then
			_G["LSSettingsmarkSizeText"]:SetText(db[i][1]);
			break;
		end
	end

	revdir = true;
	if (LunarSphereSettings[gaugeName .. "GaugeDirection"] ~= 1) then
		revdir = false;
	end

	_G["LSSettingsmarkDark"]:SetChecked(LunarSphereSettings[gaugeName .. "MarkDark"]);
	_G["LSSettingsgaugeAnimate"]:SetChecked(LunarSphereSettings[gaugeName .. "GaugeAnimate"]);
	_G["LSSettingsshowGauge"]:SetChecked(LunarSphereSettings["show" .. gaugeUpper]);
	_G["LSSettingsgaugeReverse"]:SetChecked(revdir);
end


function Lunar.Settings:UpdateMemoryReloadButton()
	local i, reloadNeeded;
	for i = 1, Lunar.Settings.memoryEditCount do 
		if (Lunar.Settings.memoryEdit[i]) then
			reloadNeeded = true;
			break;
		end
	end
	if (reloadNeeded == true) then
		_G["LSSettingsMemoryReloadButton"]:Enable();
	else
		_G["LSSettingsMemoryReloadButton"]:Disable();
	end
end

if not (LunarSphereSettings.memoryDisableSpeech) then

	function Lunar.Settings.ActionList_AddAction(self)

		local button = _G["LSSettingsassignmentEditButton"];
		local scriptID = _G["LSSettingsscriptSelection"].selectedValue or (0);
		local slider = _G["LSSettingsAssignActionSlider"];
		local foundIndex = 0;
		local db = LunarSpeechLibrary.script[scriptID];
		local totalActions = 0

		if (db and button.actionData) then

			if (not db.spells) then
				db.spells = {};
			end
			totalActions = table.getn(db.spells) or (0) 
			
			local scriptName = Lunar.Speech:GetScriptName(scriptID);
			
			-- If we're saving, go that route. Otherwise, we just add
			if (button.savedData) then

				-- Check to see if the original data we're saving over still exists
				foundIndex = Lunar.Speech:GetSpellFromScript(scriptName, button.savedData);
				if (foundIndex) then

					-- See if the new data to replace it with exists. If not, replace it and
					-- save our new scroll location. If it does exist, scroll to show where
					-- it exists.
					local index = Lunar.Speech:GetSpellFromScript(scriptName, button.actionData)
					if not index then
						db.spells[foundIndex] = button.actionData;
						foundIndex = table.getn(db.spells);
					else
						foundIndex	= index;
					end

				end
			else
				Lunar.Speech:AddSpellToScript(Lunar.Speech:GetScriptName(scriptID), button.actionData);
				foundIndex = Lunar.Speech:GetSpellFromScript(Lunar.Speech:GetScriptName(scriptID), button.actionData);
				totalActions = table.getn(db.spells) or (0) 
			end

			if (totalActions > 3) then
				slider:SetMinMaxValues(0, totalActions - 3);
			end

			-- Update our scroller and then refresh our list
			if ((foundIndex or (0)) > 3) then
				slider:SetValue(foundIndex - 3);
			else
				slider:SetValue(0);
			end

			Lunar.Settings:UpdateActionList();
			
		end

		if (self == button) then
			Lunar.Settings:ActionList_ClearActionObjects();
		end
		
		Lunar.Speech:UpdateRegisteredSpells()

	end

	function Lunar.Settings:ActionList_ClearActionObjects()
		local button = _G["LSSettingsassignmentEditButton"];
		button:SetText(ADD);
		button.actionData = nil;
		button.savedData = nil;
		UIDropDownMenu_SetSelectedValue(_G["LSSettingsassignmentSelection"], 0);
		_G["LSSettingsassignmentSelectionText"]:SetText(Lunar.Object.dropdownData["Speech_Assign"][1][1]);
		_G["LSSettingsassignmentActionIcon"]:SetTexture("");
	end

	function Lunar.Settings:ActionList_PrepareAction()

		if GetCursorInfo() then
		
			local button = _G["LSSettingsassignmentEditButton"];
			local cursorType, cursorID, cursorData = GetCursorInfo();
			local actionName, actionRank, objectTexture;

			-- Now, let's find out if we were actually dragging a PET or MOUNT
			-- so that we can, you know, assign those instead.
			if (Lunar.Button.CompanionType) then
				cursorType = "companion";
				actionName, objectTexture = select(3, GetCompanionInfo(Lunar.Button.CompanionType, Lunar.Button.CompanionID));
--				actionName = GetSpellInfo(actionName);
			end
			Lunar.Button.CompanionType = nil;
			Lunar.Button.CompanionID = nil;

			if (cursorType == "spell") then
				actionName, actionRank = GetSpellBookItemName(cursorID, cursorData);
				objectTexture = GetSpellTexture(cursorID, cursorData);

				-- Fix for Call Pet for hunters.
				local _, spellID = GetSpellBookItemInfo(cursorID, cursorData);
				local spellName = GetSpellInfo(spellID);
				if (actionName ~= spellName) then
					actionName = spellName;
				end

			elseif (cursorType == "item") then
				actionName, _, _, _, _, _, _, _, _, objectTexture = GetItemInfo(cursorID);
				actionName = GetItemSpell(actionName);
			end

			if (actionName) then
				if (actionRank) and (actionRank ~= "") and (not (string.find(actionRank, "%d"))) then --and not (actionRank == Lunar.Speech.summonText) then
					button.actionData = actionName .. "(" .. actionRank .. "):::" .. objectTexture;
				else
					button.actionData = actionName .. ":::" .. objectTexture;
				end
			end

		end

		ClearCursor();
		
	end

	function Lunar.Settings.ActionList_OnDragOrClick(self)

		local button = _G["LSSettingsassignmentEditButton"];

		if GetCursorInfo() then
			
			-- Backup our save over data, if it exists
			local origSavedData = button.savedData;
			local origActionData = button.actionData;

			-- Prepare to save this dragged action and then add it
			Lunar.Settings:ActionList_PrepareAction();
			button.savedData = nil;
			Lunar.Settings:ActionList_AddAction();

			-- Restore original save over data, if it existed
			if (origSavedData) then
				button.savedData = origSavedData;
				button.actionData = origActionData;
				button:SetText(SAVE);
			end

		else
			local spellID = self:GetID() + _G["LSSettingsAssignActionSlider"]:GetValue();
			local scriptID = _G["LSSettingsscriptSelection"].selectedValue or (0);
			local spellData = LunarSpeechLibrary.script[scriptID].spells[spellID];
			if IsControlKeyDown() then
				if (self:GetID() > 0) then
					Lunar.Speech:RemoveSpellFromScript(Lunar.Speech:GetScriptName(scriptID), spellData);
					if (spellData == button.savedData) then
						Lunar.Settings:ActionList_ClearActionObjects();
					end
					Lunar.Speech:UpdateRegisteredSpells()
				end
			else
				button.savedData = spellData;
				button.actionData = nil;
				button:SetText(SAVE);
				local actionTexture = string.match(spellData, ":::(.*)");
				local selectID = 1;
				local key, value
				for key, value in pairs(Lunar.Speech.actionAssignNames) do
					if (value == spellData) then
						selectID = key;
						break;
					end
				end
				UIDropDownMenu_SetSelectedValue(_G["LSSettingsassignmentSelection"], selectID);
				_G["LSSettingsassignmentSelectionText"]:SetText(Lunar.Object.dropdownData["Speech_Assign"][selectID + 1][1]);
				_G["LSSettingsassignmentActionIcon"]:SetTexture(actionTexture);
			end
		end

		Lunar.Settings:UpdateActionList();
					
	end

	function Lunar.Settings:UpdateActionList()

		local objectTexture, objectName, index, text, icon, i, spellData, key, value;
		local slider = _G["LSSettingsAssignActionSlider"];
		local scriptID = _G["LSSettingsscriptSelection"].selectedValue or (0);
		local db = LunarSpeechLibrary.script;
		local totalActions = 0;

		if (db[scriptID] and db[scriptID].spells) then
			totalActions = table.getn(db[scriptID].spells)
		end
		index = totalActions;

		if (totalActions > 3) then
			index = index - 3;
			slider:GetThumbTexture():SetVertexColor(1,1,1);
		else
			index = 0;	
			slider:GetThumbTexture():SetVertexColor(0.5, 0.5, 0.5);
		end

		slider:SetMinMaxValues(0, index);

		for index = 1, 3 do
			icon = _G["LSSettingsAssignActionIcon" .. index];
			text = _G["LSSettingsAssignActionName" .. index];
			icon:Hide();
			text:Hide();
			if (totalActions > 0) then
				i = index + slider:GetValue();
				spellData = db[scriptID].spells[i];
				if (spellData) then
					objectName, objectTexture = string.match(spellData, "(.*):::(.*)");
					for key, value in pairs(Lunar.Speech.actionAssignNames) do
						if (value == spellData) then
							objectName = Lunar.Object.dropdownData["Speech_Assign"][key + 1][1];
							break;
						end
					end
					icon:SetNormalTexture(objectTexture);
					_G[text:GetName() .. "Text"]:SetText(objectName);
					icon:Show();
					text:Show();
				end
			end
		end

	end

	function Lunar.Settings:GetChannelText(channelName)
		local index;
		for index = 1, table.getn(Lunar.Object.dropdownData["Speech_Channels"]) do 
			if (Lunar.Object.dropdownData["Speech_Channels"][index][2] == channelName) then
				return Lunar.Object.dropdownData["Speech_Channels"][index][1];
			end	
		end
	end

	function Lunar.Settings.SpeechList_OnClick(self)

		local highlight = _G["LSSettingsSpeechSelectedHighlight"];
		if (not IsControlKeyDown()) then
			if (self:GetID() > 0) then
				if (highlight:GetID() ~= self:GetID()) then
					highlight:SetID(self:GetID());
					highlight:SetPoint("TopLeft", _G["LSSettingsSpeechData" .. self:GetID()], "Topleft", -5, -2);
				end
				highlight:Show();
				scriptID = UIDropDownMenu_GetSelectedValue(_G["LSSettingsscriptSelection"]) or (1);
				local speech, default = Lunar.Speech:GetSpeech(scriptID, self:GetID() + _G["LSSettingsSpeechSlider"]:GetValue());
				_G["LSSettingsCurrentSpeech"]:SetText(speech);
				_G["LSSettingsspeechSave"]:Enable();
				if (default) then
	--				_G["LSSettingsspeechSave"]:Disable();
					_G["LSSettingsspeechDelete"]:Disable();
				else
	--				_G["LSSettingsspeechSave"]:Enable();
					_G["LSSettingsspeechDelete"]:Enable();
				end
			end	

		else
			local scriptName = Lunar.Speech:GetScriptName(UIDropDownMenu_GetSelectedValue(_G["LSSettingsscriptSelection"]));
			local scriptID = UIDropDownMenu_GetSelectedValue(_G["LSSettingsscriptSelection"]) or (1);
			local speech, default = Lunar.Speech:GetSpeech(scriptID, self:GetID() + _G["LSSettingsSpeechSlider"]:GetValue());
			if not default then
				Lunar.Speech:RemoveSpeechFromScript(scriptName, speech);
				Lunar.Settings:UpdateSpeechList();
				Lunar.Settings:ResetSpeechObjects();
			end
		end
		
		ClearCursor();
	end

	function Lunar.Settings.SpeechList_OnEnter(self)
		local highlight = _G["LSSettingsSpeechHighlight"];
		if (highlight:GetID() ~= self:GetID()) then
			highlight:SetID(self:GetID());
			highlight:SetPoint("TopLeft", _G["LSSettingsSpeechData" .. self:GetID()], "Topleft", -5, -2);
		end
		highlight:Show();
	end

	function Lunar.Settings.SpeechList_OnLeave()
		_G["LSSettingsSpeechHighlight"]:Hide();
	end

	function Lunar.Settings:ResetSpeechObjects()

		local highlight = _G["LSSettingsSpeechSelectedHighlight"];
		highlight:SetID(0);
		highlight:Hide();
		_G["LSSettingsCurrentSpeech"]:SetText("");
		_G["LSSettingsspeechSave"]:Disable();
		_G["LSSettingsspeechDelete"]:Disable();
		
	end

	function Lunar.Settings:HideSaveCancelObjects()
		_G["LSSettingsScriptName"]:Hide();
		_G["LSSettingsScriptSave"]:Hide();
		_G["LSSettingsScriptCancel"]:Hide();
		_G["LSSettingsscriptSelectionButton"]:Enable();
		_G["LSSettingsscriptSelectionText"]:SetAlpha(1);
		_G["LSSettingsScriptImport"]:Enable();
		_G["LSSettingsScriptExport"]:Enable();
	end

	function Lunar.Settings.PrepNewRenameSettings(self)
		_G["LSSettingsScriptName"]:SetText("");
		_G["LSSettingsScriptName"]:Show();
		_G["LSSettingsScriptName"]:HighlightText(0,0);
		_G["LSSettingsScriptName"]:SetFocus();
		_G["LSSettingsScriptSave"]:Show();
		_G["LSSettingsScriptCancel"]:Show();
		_G["LSSettingsscriptSelectionText"]:SetAlpha(0);
		_G["LSSettingsscriptSelectionButton"]:Disable();
		_G["LSSettingsScriptSave"]:SetID(self:GetID());
		_G["LSSettingsScriptImport"]:Disable();
		_G["LSSettingsScriptExport"]:Disable();
	end

	function Lunar.Settings:UpdateSpeechList()

		local slider = _G["LSSettingsSpeechSlider"];
		local index, scriptIndex, speech, isGlobal, globalIndex;

		local speechCount, scriptCount = 0, 0;

		_G["LSSettingsscriptDelete"]:Enable();
		_G["LSSettingsscriptSelectionText"]:SetTextColor(1,1,1);

		if (LunarSpeechLibrary.script) then
			scriptCount = table.getn(LunarSpeechLibrary.script);
			scriptIndex = UIDropDownMenu_GetSelectedValue(_G["LSSettingsscriptSelection"]) or (1);

			_G["LSSettingsscriptSelection"].selectedValue = scriptIndex;
			if (scriptIndex > 0) then
				if (LunarSpeechLibrary.script[scriptIndex]) then
					if not (LunarSpeechLibrary.script[scriptIndex].speeches) then
						_G["LSSettingsscriptSelectionText"]:SetTextColor(0.2,0.6,1.0);
					end
					globalIndex, speechCount, isGlobal = Lunar.Speech:GetLibraryID(Lunar.Speech:GetScriptName(scriptIndex));
					speechCount = speechCount or (0)
	--				if (LunarSphereGlobal.speechLibrary[scriptIndex].default) then
	--					_G["LSSettingsscriptDelete"]:Disable();
	--					_G["LSSettingsscriptSelectionText"]:SetVertexColor(0.2,0.6,1.0);
	--				end

					-- Action assignment dropdown
					UIDropDownMenu_SetSelectedValue(_G["LSSettingsassignmentSelection"], LunarSpeechLibrary.script[scriptIndex].actionAssign or (0));
					_G["LSSettingsassignmentSelectionText"]:SetText(Lunar.Object.dropdownData["Speech_Assign"][(LunarSpeechLibrary.script[scriptIndex].actionAssign or (0)) + 1][1]);

					local objectTexture = "";
					if (LunarSpeechLibrary.script[scriptIndex].actionAssign or (0)) > 0 then
						if (LunarSpeechLibrary.script[scriptIndex].spells) then
							_, objectTexture = string.match(LunarSpeechLibrary.script[scriptIndex].spells[1] or ("") , "(.*):::(.*)")
						end
					end
					_G["LSSettingsassignmentActionIcon"]:SetTexture(objectTexture);

					-- Channel assignment dropdown
					UIDropDownMenu_SetSelectedValue(_G["LSSettingschannelSelection"], LunarSpeechLibrary.script[scriptIndex].channelName or ("SAY"));
					_G["LSSettingschannelSelectionText"]:SetText(Lunar.Settings:GetChannelText(_G["LSSettingschannelSelection"].selectedValue));

					_G["LSSettingsscriptOdds"]:SetValue(LunarSpeechLibrary.script[scriptIndex].runProbability or (100));
					_G["LSSettingsinOrder"]:SetChecked(LunarSpeechLibrary.script[scriptIndex].inOrder);
				end
			else
				scriptIndex = nil;
			end
		else
			_G["LSSettingsscriptSelection"].selectedValue = 0;
		end

		_G["LSSettingsscriptSelectionLabel"]:SetText(string.gsub(Lunar.Locale["_SCRIPTS_IN_LIBRARY"], "%%d", scriptCount));
		_G["LSSettingsspeechesInScriptCaptionText"]:SetText(string.gsub(Lunar.Locale["_SPEECHES_IN_SCRIPT"], "%%d", speechCount));

		if (speechCount > 5) then
			index = speechCount - 5;
			slider:GetThumbTexture():SetVertexColor(1,1,1);
		else
			index = 0;
			slider:GetThumbTexture():SetVertexColor(0.5, 0.5, 0.5);
		end

		slider:SetMinMaxValues(0, index);

		if (isGlobal) then
			scriptIndex = globalIndex;
		end

		for index = 1, 5 do
			_G["LSSettingsSpeechData" .. index]:Hide();
			if scriptIndex then
				speech = index + slider:GetValue();
				if (speech <= speechCount) then
					speech, default = Lunar.Speech:GetSpeech(scriptIndex, speech, isGlobal)
					_G["LSSettingsSpeechData" .. index .. "Text"]:SetText(speech);
					if (default) then
						_G["LSSettingsSpeechData" .. index .. "Text"]:SetVertexColor(0.2,0.6,1.0);
					else
						_G["LSSettingsSpeechData" .. index .. "Text"]:SetVertexColor(1,1,1);
					end
					_G["LSSettingsSpeechData" .. index]:Show();
				end
			end
		end

		Lunar.Settings:UpdateActionList();

	end
end

if not (LunarSphereSettings.memoryDisableReagents) then

	function Lunar.Settings:UpdateReagentList()

		local slider = _G["LSSettingsReagentSlider"];
		local objectTexture, index;
		
		if (LunarSphereSettings.reagentList) then
			index = table.getn(LunarSphereSettings.reagentList);
		end
		if (index > 4) then
			index = index - 4;
			slider:GetThumbTexture():SetVertexColor(1,1,1);
		else
			index = 0;	
			slider:GetThumbTexture():SetVertexColor(0.5, 0.5, 0.5);
		end

		slider:SetMinMaxValues(0, index);

		for index = 1, 4 do
			_G["LSSettingsReagentIcon" .. index]:Hide();
			_G["LSSettingsReagentName" .. index]:Hide();
			_G["LSReagentCount" .. index]:Hide();
			if (LunarSphereSettings.reagentList) then
				if (LunarSphereSettings.reagentList[index + slider:GetValue()]) then
					if (LunarSphereSettings.reagentList[index + slider:GetValue()].itemID) then
						_,_,_,_,_,_,_,_,_, objectTexture = GetItemInfo(LunarSphereSettings.reagentList[index + slider:GetValue()].itemID);

						_G["LSSettingsReagentIcon" .. index]:SetNormalTexture(objectTexture);
						_G["LSSettingsReagentName" .. index .. "Text"]:SetText(LunarSphereSettings.reagentList[index + slider:GetValue()].name);
						if (not LunarSphereSettings.reagentList[index + slider:GetValue()].maxAmount) then
							LunarSphereSettings.reagentList[index + slider:GetValue()].maxAmount = 0;
						end
						_G["LSReagentCount" .. index]:SetText(LunarSphereSettings.reagentList[index + slider:GetValue()].maxAmount);
						_G["LSSettingsReagentIcon" .. index]:Show();
						_G["LSSettingsReagentName" .. index]:Show();
						_G["LSReagentCount" .. index]:Show();

					end
				end
			end
		end
	end

	function Lunar.Settings.ReagentList_OnTextChanged(self)
		LunarSphereSettings.reagentList[_G["LSSettingsReagentSlider"]:GetValue() + self:GetID()].maxAmount = tonumber(self:GetText());
	end

	function Lunar.Settings.ReagentList_OnEnter(self)
		local highlight = _G["LSSettingsReagentHighlight"];
		if (highlight:GetID() ~= self:GetID()) then
			highlight:SetID(self:GetID());
			highlight:SetPoint("TopLeft", _G["LSSettingsReagentIcon" .. self:GetID()], "Topleft");
		end
		highlight:Show();
	end

	function Lunar.Settings:ReagentList_OnLeave()
		_G["LSSettingsReagentHighlight"]:Hide();
	end

	function Lunar.Settings.ReagentList_OnReceiveDrag(self)

		if (not IsControlKeyDown()) then
			if (CursorHasItem()) then
				local itemID, listIndex, foundIndex;
				_, itemID = GetCursorInfo();

				foundIndex = nil;

				for listIndex = 1, table.getn(LunarSphereSettings.reagentList) do 
					if (LunarSphereSettings.reagentList[listIndex].itemID == itemID) then
						foundIndex = listIndex;
						break;
					end
				end

				if (not foundIndex) then

					local objectName, objectType, stackTotal, objectTexture;

					-- Get the name of the item, what it can stack as, and its texture
					objectName, _, _, _, _, objectType, _, stackTotal, _, objectTexture = GetItemInfo(itemID);

					table.insert(LunarSphereSettings.reagentList, {["name"] = objectName, ["maxAmount"] = 20, ["itemID"] = itemID});
					index = table.getn(LunarSphereSettings.reagentList);
					if (index > 4) then
						_G["LSSettingsReagentSlider"]:SetMinMaxValues(0, index - 4);
						_G["LSSettingsReagentSlider"]:SetValue(index - 4);
					else
						_G["LSSettingsReagentSlider"]:SetValue(0);
						Lunar.Settings.UpdateReagentList();
					end
		
					_G["LSReagentCount4"]:SetFocus();
					_G["LSReagentCount4"]:HighlightText();
				
				else
				
					if (foundIndex > 4) then
						_G["LSSettingsReagentSlider"]:SetValue(foundIndex - 4);
						_G["LSReagentCount4"]:SetFocus();
						_G["LSReagentCount4"]:HighlightText();
					else
						_G["LSSettingsReagentSlider"]:SetValue(0);
						_G["LSReagentCount" .. foundIndex]:SetFocus();
						Lunar.Settings.UpdateReagentList();
						_G["LSReagentCount" .. foundIndex]:HighlightText();
					end
				end

			else
				if (self:GetID() > 0) then
					_G["LSReagentCount" .. self:GetID()]:SetFocus();
					_G["LSReagentCount1"]:HighlightText(0,0);
					_G["LSReagentCount2"]:HighlightText(0,0);
					_G["LSReagentCount3"]:HighlightText(0,0);
					_G["LSReagentCount4"]:HighlightText(0,0);
					_G["LSReagentCount" .. self:GetID()]:HighlightText();
				end	
			end

		else
			if (self:GetID() > 0) then
				table.remove(LunarSphereSettings.reagentList, self:GetID() + _G["LSSettingsReagentSlider"]:GetValue());
				Lunar.Settings.UpdateReagentList();
			end	
		end
		
		ClearCursor();
	end
end

if not (LunarSphereSettings.memoryDisableRepair) then

	-- /***********************************************
	--  * CreateRepairLogDialog
	--  * ========================
	--  *
	--  * Creates the Repair Log dialog frame that will show the last 10 items in the log
	--  *
	--  * Accepts: None
	--  * Returns: None
	--  *********************
	function Lunar.Settings:CreateRepairLogDialog()

		-- Create our locals
		local tempFrame, tempFrameContainer, tempObject, index;

		-- Create our button setting dialog window and assign it to the Settings object.
		-- This frame will be called whenever a button needs to be edited...
		Lunar.Settings.RepairLogDialog = Lunar.Object:Create("window", "LSRepairLogDialog", UIParent, Lunar.Locale["WINDOW_TITLE_REPAIRLOG"], 252, 226, 1.0, 0.0, 0.0);
		Lunar.Settings.RepairLogDialog:Hide();
		Lunar.Settings.RepairLogDialog:SetFrameStrata("HIGH");

		Lunar.Settings.RepairLogDialog:SetScript("OnShow",
		function ()

			-- Set our locals
			local index, captionText;

			-- Create our log if it doesn't exist
			if (not LunarSphereSettings.repairLog) then
				LunarSphereSettings.repairLog = {};
			end

			-- Populate each entry with the data found in the repair log
			for index = 1, 10 do
				captionText = "";
				if (LunarSphereSettings.repairLog[index]) then
					captionText = LunarSphereSettings.repairLog[index];
				end
				_G["LSSettingsRepairLogEntry" .. index .. "Text"]:SetText("|cFF999999" .. captionText);
			end

			-- If there was nothing found, let the user know
			if (not LunarSphereSettings.repairLog[1]) then
				_G["LSSettingsRepairLogEntry1Text"]:SetText("|cFF999999" .. Lunar.Locale["_NO_RECORDS_FOUND"]);
			end
		end);

		tempFrameContainer = _G[Lunar.Settings.RepairLogDialog:GetName() .. "WindowContainer"];

		-- Create Last 10 Entries Caption
		tempObject = Lunar.Object:CreateCaption(13, -8, 150, 20, "|cFFFFFFFF"..Lunar.Locale["LAST_10_ENTRIES"], "lastTenEntries", tempFrameContainer);

		-- Create entries
		for index = 1, 10 do 

			-- Create Entry #Index
			tempObject = Lunar.Object:CreateCaption(13, -10 - index * 14, 240, 20, "None", "RepairLogEntry" .. index, tempFrameContainer);
			
		end

		-- Close Button button
		tempObject = Lunar.Object:CreateButton(79, -172, 92, "RepairLogClose", CLOSE, tempFrameContainer,
		function()
			Lunar.Settings.RepairLogDialog:Hide();
		end);

	end

	function Lunar.Settings:AddToRepairLog(repairBill)

		-- If the repair log doesn't exist, make it now
		if (not LunarSphereSettings.repairLog) then
			LunarSphereSettings.repairLog = {};
		end

		-- Switch the "Guild Repair" text to the shorter "(GR)"
		repairBill = string.gsub(repairBill, Lunar.Locale["_GUILD_FUNDS_TAG"], Lunar.Locale["_GUILD_FUNDS_TAG_SMALL"]);

		-- Cycle through each entry in the log
		local index;
		for index = 9, 1, -1 do 

			-- Shift the current item down
			if (LunarSphereSettings.repairLog[index]) then
				LunarSphereSettings.repairLog[index + 1] = LunarSphereSettings.repairLog[index];
			end

			-- If we're at the first item, add our new entry
			if (index == 1) then
				LunarSphereSettings.repairLog[index] = date("%m/%d/%y-%H:%M:  ") .. repairBill;
			end
		end
	end
	
end

if not (LunarSphereSettings.memoryDisableTemplates) then
	-- /***********************************************
	--  * CreateTemplateHandlerDialog
	--  * ========================
	--  *
	--  * Creates the template import and export window
	--  *
	--  * Accepts: None
	--  * Returns: None
	--  *********************
	function Lunar.Settings:CreateTemplateHandlerDialog()

		-- Create our locals
		local tempFrame, tempFrameContainer, tempObject, sectionY;

		-- Create our dialog window and assign it to the Settings object.
		-- This frame will be called whenever we need to load or save a template
		Lunar.Settings.TemplateHandlerDialog = Lunar.Object:Create("window", "LSTemplateHandlerDialog", UIParent, Lunar.Locale["WINDOW_TITLE_TEMPLATE"], 234, 210, 0.0, 1.0, 1.0);
		Lunar.Settings.TemplateHandlerDialog:SetFrameStrata("HIGH");
		Lunar.Settings.TemplateHandlerDialog:Hide();
		Lunar.Settings.TemplateHandlerDialog:SetScript("OnShow", function (self)
			Lunar.Settings:WipeTemplateHandler();
			LunarSphereSettings.templateSaveClassType = 0;
			if (self.loadClass == "ANY") then
				LunarSphereSettings.templateSaveClassType = 1;
			end
			local i, frame;
			for i = 1, 5 do 
				frame = _G["LSSettingstemplateOptions" .. i]
				frame:SetChecked(false);
				Lunar.Settings:SetEnabled(frame, true);
				if (self.loading) then
					if (string.sub(self.loadOptions, i, i) == "1") then
						frame:SetChecked(true);
						LunarSphereSettings["templateOptions" .. i] = true;
					else
						Lunar.Settings:SetEnabled(frame, nil);
					end
				elseif (self.loadOptions) then
					if (string.sub(self.loadOptions, i, i) == "1") then
						frame:SetChecked(true);
						LunarSphereSettings["templateOptions" .. i] = true;
					end
				end
			end
			frame = _G["LSSettingsTemplateNameTextbox"]
			frame:SetText(self.loadName or (""));
			frame:EnableKeyboard(not self.loading);
			frame:EnableMouse(not self.loading);
			if (self.loading) then
				frame:SetTextColor(0.5,0.5,0.5);
			else
				frame:SetTextColor(1,1,1);
			end

			frame = _G["LSSettingstemplateSaveClassType0"]
			frame:SetChecked(not (self.loadClass == "ANY"))
			Lunar.Settings:SetEnabled(frame, not self.loading);

			frame = _G["LSSettingstemplateSaveClassType1"]
			frame:SetChecked(self.loadClass == "ANY")
			Lunar.Settings:SetEnabled(frame, not self.loading);
		
			frame = _G["LSSettingstemplateOptionsCaptionText"];
			if (self.loading) then
				frame:SetText("|cFFFFFFFF" .. Lunar.Locale["_TEMPLATE_DATA_LOAD"]);
				_G["LSSettingsTemplateOkayButton"]:SetText(Lunar.Locale["_LOAD"]);
			else
				frame:SetText("|cFFFFFFFF" .. Lunar.Locale["_TEMPLATE_DATA_SAVE"]);
				_G["LSSettingsTemplateOkayButton"]:SetText(SAVE);
			end

		end);

		tempFrameContainer = _G[Lunar.Settings.TemplateHandlerDialog:GetName() .. "WindowContainer"];

		-- Create filename caption
		tempObject = Lunar.Object:CreateCaption(15, -10, 150, 20, "|cFFFFFFFF" .. Lunar.Locale["TEMPLATE_NAME"], "templateNameCaption", tempFrameContainer, true);

		-- Create filename text box
		tempObject = CreateFrame("EditBox", "LSSettingsTemplateNameTextbox", tempFrameContainer, "LunarEditBox");

		tempObject:SetPoint("Topleft", tempFrameContainer, "Topleft", 20, -30)
		tempObject:SetWidth(198);
		tempObject:Show();

		sectionY = -52
		-- Create class type caption
		tempObject = Lunar.Object:CreateCaption(10, sectionY, 150, 20, "|cFFFFFFFF" .. Lunar.Locale["TEMPLATE_FOR"], "templateClassCaption", tempFrameContainer, true);

		-- Class type: current
		tempObject = Lunar.Object:CreateRadio(10, sectionY - 16, UnitClass("player"), "templateSaveClassType", 0, tempFrameContainer)
		tempObject:SetHitRectInsets(0, -82, 0, 0);

		-- Class type: all
		tempObject = Lunar.Object:CreateRadio(117, sectionY - 16, Lunar.Locale["_TEMPLATE_ALL_CLASSES"], "templateSaveClassType", 1, tempFrameContainer)
		tempObject:SetHitRectInsets(0, -82, 0, 0);

		sectionY = -86;

		-- Create template save/load option caption
		tempObject = Lunar.Object:CreateCaption(10, sectionY, 150, 20, "|cFFFFFFFF" .. Lunar.Locale["_TEMPLATE_DATA_SAVE"], "templateOptionsCaption", tempFrameContainer, true);

			-- Create Button Data check box
			tempObject = Lunar.Object:CreateCheckbox(10, sectionY - 16, Lunar.Locale["TEMPLATE_DATA_BUTTON"], "templateOptions1", true, tempFrameContainer);
			tempObject:SetHitRectInsets(0, -80, 0, 0);

			-- Create Keybind Data check box
			tempObject = Lunar.Object:CreateCheckbox(117, sectionY - 16, Lunar.Locale["TEMPLATE_DATA_KEYBIND"], "templateOptions2", true, tempFrameContainer);
			tempObject:SetHitRectInsets(0, -80, 0, 0);

			-- Create Sphere Data check box
			tempObject = Lunar.Object:CreateCheckbox(10, sectionY - 32, Lunar.Locale["TEMPLATE_DATA_SPHERE"], "templateOptions3", true, tempFrameContainer);
			tempObject:SetHitRectInsets(0, -80, 0, 0);

			-- Create Reagent Data check box
			tempObject = Lunar.Object:CreateCheckbox(117, sectionY - 32, Lunar.Locale["TEMPLATE_DATA_REAGENT"], "templateOptions4", true, tempFrameContainer);
			tempObject:SetHitRectInsets(0, -80, 0, 0);

			-- Create Skin Data check box
			tempObject = Lunar.Object:CreateCheckbox(10, sectionY - 48, Lunar.Locale["TEMPLATE_DATA_SKIN"], "templateOptions5", true, tempFrameContainer);
			tempObject:SetHitRectInsets(0, -80, 0, 0);

		-- Save/Load button
		tempObject = Lunar.Object:CreateButton(25, sectionY - 70, 92, "TemplateOkayButton", SAVE, tempFrameContainer,
		function()
			local db = LunarSphereSettings;
			if (Lunar.Settings.TemplateHandlerDialog.loading) then
				local dialog = Lunar.Settings.TemplateHandlerDialog;
				local listData = dialog.loadName .. ":::" .. dialog.loadClass .. ":::";
				local i;
				for i = 1, 5 do 
					if (db["templateOptions" .. i] == true) then
						listData = listData .. "1";
					else
						listData = listData .. "0";
					end
				end
				LunarSphereSettings.loadTemplate = listData .. ":::" .. dialog.loadSize;

				-- hotswap templates ...
				if (LunarSphereSettings.enableTemplateHotswapping == true) then
					if (Lunar.Button.ReloadAllButtons) then
						Lunar.Template:LoadTemplateData();
						Lunar.Template:ParseTemplateData();
						LunarSphereSettings.loadTemplate = nil;
						Lunar.Button:ReloadAllButtons();
					else
						ReloadUI();
					end
				else
					ReloadUI();
				end

			else
				local templateName = _G["LSSettingsTemplateNameTextbox"]:GetText();
				if (templateName) and (templateName ~= "")  then
					local i;
					local found, name, size;
					for i = 1, table.getn(Lunar.Settings.templateList) do
						name, _, _, size = select(1, string.match(Lunar.Settings.templateList[i], "(.*):::(.*):::(.*):::(.*)"));
						if (name == templateName) then
							found = i;
							break;
						end
					end
					-- Same name? Overwrite it...
					if (found and (size ~= "")) then
						-- We do some tricky shit right here. If the template
						-- already existed, we create a new one, place it's index
						-- data where the old one exists in our current template
						-- list and then delete the old one. Yeah.
						local listData = templateName .. ":::";
						if (db.templateSaveClassType == 1) then
							listData = listData .. "ANY:::"
						else
							listData = listData .. select(2, UnitClass("player")) .. ":::";
						end
						for i = 1, 5 do 
							if (db["templateOptions" .. i] == true) then
								listData = listData .. "1";
							else
								listData = listData .. "0";
							end
						end
						if (Lunar.Export) then
							listData = Lunar.Export:ExportData("template", nil, listData)

							-- Find our old template and kill it while fixing our dual spec settings
							local dualFix1, dualFix2;
							for index = 1, #LunarSphereExport.template do 
								if (LunarSphereExport.template[index].listData == Lunar.Settings.templateList[found]) then
									if (LunarSphereSettings.dualTemplate1 == Lunar.Settings.templateList[found]) then
										LunarSphereSettings.dualTemplate1 = listData;
									end
									if (LunarSphereSettings.dualTemplate2 == Lunar.Settings.templateList[found]) then
										LunarSphereSettings.dualTemplate2 = listData;
									end
									table.remove(LunarSphereExport.template, index);
									break;
								end
							end

							-- Now, we add our new template into the old template location in our list.
							Lunar.Settings.templateList[found] = listData;

						else
							Lunar.API:Print(LUNARSPHERE_CHAT .. Lunar.Locale["_LUNAR_EXPORT_NOT_FOUND"]);
						end
						Lunar.Settings:UpdateTemplateList();

					-- Not the same name? Make a new one
					else
						local listData = templateName .. ":::";
						if (db.templateSaveClassType == 1) then
							listData = listData .. "ANY:::"
						else
							listData = listData .. select(2, UnitClass("player")) .. ":::";
						end
						for i = 1, 5 do 
							if (db["templateOptions" .. i] == true) then
								listData = listData .. "1";
							else
								listData = listData .. "0";
							end
						end
						if (Lunar.Export) then
							listData = Lunar.Export:ExportData("template", nil, listData)
							table.insert(Lunar.Settings.templateList, listData);
						else
							Lunar.API:Print(LUNARSPHERE_CHAT .. Lunar.Locale["_LUNAR_EXPORT_NOT_FOUND"]);
						end
						Lunar.Settings:UpdateTemplateList();
					end
				end
			end	
			Lunar.Settings.TemplateHandlerDialog:Hide();
		end);

		-- Cancel button
		tempObject = Lunar.Object:CreateButton(119, sectionY - 70, 92, "TemplateCancelButton", CANCEL, tempFrameContainer,
		function()
			Lunar.Settings:WipeTemplateHandler();
			Lunar.Settings.TemplateHandlerDialog:Hide();
		end);
	end

	function Lunar.Settings:WipeTemplateHandler()
		local db = LunarSphereSettings;
		local i;
		for i = 1, 5 do 
			db["templateOptions" .. i] = nil;			
		end
		db.templateSaveClassType = nil;
	end

	function Lunar.Settings.TemplateList_OnClick(self)

		local highlight = _G["LSSettingsTemplateListSelectedHighlight"];
		-- If we select something else, highlight it
		if (highlight:GetID() ~= self:GetID()) then

			highlight:SetID(self:GetID());
			highlight:SetPoint("TopLeft", _G["LSSettingsTemplateData" .. self:GetID()], "Topleft", 0, 0);

		-- Otherwise, unselect it and leave now
		else
			highlight:SetID(0);
			highlight:Hide();
			_G["LSSettingstemplateLoad"]:Disable();
			_G["LSSettingstemplatePrimary"]:Disable();
			_G["LSSettingstemplateSecondary"]:Disable();
			_G["LSSettingstemplateDelete"]:Disable();
			return;
		end	

		highlight:Show();

		_G["LSSettingstemplateLoad"]:Enable();

		if (LunarSphereSettings.enableTemplateHotswapping) then
			_G["LSSettingstemplatePrimary"]:Enable();
			_G["LSSettingstemplateSecondary"]:Enable();
		end

		local index = highlight:GetID() + _G["LSSettingsTemplateListSlider"]:GetValue();
		local tempName, tempClass, tempOptions, tempSize = string.match(Lunar.Settings.templateList[index] or (""), "(.*):::(.*):::(.*):::(.*)");
		local button = _G["LSSettingstemplateDelete"];
		if (tempSize ~= "") then
			button:Enable();
		else
			button:Disable();
		end
		ClearCursor();

	end

	function Lunar.Settings:BuildTemplateList()

		local db = LunarSphereImport
		local j, tempClass;
		local playerClass = select(2, UnitClass("player"));
		local list = Lunar.Settings.templateList;

		if (Lunar.Locale["TEMPLATE_DEFAULT"]) then
			table.insert(list, Lunar.Locale["TEMPLATE_DEFAULT"] .. ":::ANY:::10101:::");
		end
		if (Lunar.Locale["TEMPLATE_" .. playerClass]) then
			table.insert(list, Lunar.Locale["TEMPLATE_" .. playerClass] .. ":::" .. playerClass .. ":::10101:::");
		end

		-- wipe all data and then rebuild
		for j = 3, table.getn(list) do 
			table.remove(list, 3);
		end

		for j = 1, 2 do 
			if (db) and (db.template) then
				local i;
				for i = 1, table.getn(db.template) do 
--					if not db.template[i].listData then
--						table.remove(db.template, i);
--					else
						tempClass = select(2, string.match(db.template[i].listData, "(.*):::(.*):::(.*):::(.*)"));
						if (tempClass == "ANY") or (tempClass == playerClass) then
							table.insert(list, db.template[i].listData);
						end
--					end
				end
			end
			db = LunarSphereExport;
		end
	end

	function Lunar.Settings:UpdateTemplateList()

		local slider = _G["LSSettingsTemplateListSlider"];
		local i, index, tempName, tempClass, tempClassType, tempOptions, tempSize, frame;
		local templateCount = table.getn(Lunar.Settings.templateList);

		_G["LSSettingstemplateListCaptionText"]:SetText(string.gsub(Lunar.Locale["_TEMPLATE_LIST"], "%%d", templateCount));

		if (templateCount > 5) then
			i = templateCount - 5;
			slider:GetThumbTexture():SetVertexColor(1,1,1);
		else
			i = 0;
			slider:GetThumbTexture():SetVertexColor(0.5, 0.5, 0.5);
		end

		slider:SetMinMaxValues(0, i);

		for i = 1, 5 do
			frame = _G["LSSettingsTemplateData" .. i]
			frame:Hide();
			_G[frame:GetName() .. "Class"]:Hide();
			index = i + slider:GetValue();
			if (index <= templateCount) then
				tempName, tempClass, tempOptions, tempSize = string.match(Lunar.Settings.templateList[index] or (""), "(.*):::(.*):::(.*):::(.*)");
				if (tempSize ~= "") then
					tempName = tempName .. " |cFF00FF00(" .. tempSize .. ")";
				end
				_G[frame:GetName() .. "Text"]:SetText("  " .. tempName);
				if (tempClass == "ANY") then
					tempClass = Lunar.Locale["_TEMPLATE_ALL_CLASSES"];
				else
					tempClass = UnitClass("player");
				end

				if (Lunar.Settings.templateList[index] == LunarSphereSettings.dualTemplate1) then
					tempClass = tempClass .. " |cFFFFFF00(" .. PRIMARY .. ")"
				end
				if (Lunar.Settings.templateList[index] == LunarSphereSettings.dualTemplate2) then
					tempClass = tempClass .. " |cFFFFFF00(" .. SECONDARY .. ")"
				end

				_G[frame:GetName() .. "ClassText"]:SetText("    - " .. tempClass);
				frame:Show();
				_G[frame:GetName() .. "Class"]:Show();
			end
		end

		frame = _G["LSSettingsTemplateListSelectedHighlight"]
		frame:Hide();
		frame:SetID(0);
		_G["LSSettingstemplateLoad"]:Disable();
		_G["LSSettingstemplateDelete"]:Disable();
		_G["LSSettingstemplatePrimary"]:Disable();
		_G["LSSettingstemplateSecondary"]:Disable();
	end
end

if not (LunarSphereSettings.memoryDisableSkins) then
	-- /***********************************************
	--  * CreateImportArtDialog
	--  * ========================
	--  *
	--  * Creates the import art window that will handle a few of the art import features
	--  *
	--  * Accepts: None
	--  * Returns: None
	--  *********************
	function Lunar.Settings:CreateImportArtDialog()

		-- Create our locals
		local tempFrame, tempFrameContainer, tempObject;

		-- Create our import art dialog window and assign it to the Settings object.
		-- This frame will be called whenever we need to input some import info
		Lunar.Settings.ImportArtDialog = Lunar.Object:Create("window", "LSImportArtDialog", UIParent, Lunar.Locale["WINDOW_TITLE_IMPORTART"], 204, 186, 1.0, 1.0, 0.0);
		Lunar.Settings.ImportArtDialog:SetFrameStrata("HIGH");
		Lunar.Settings.ImportArtDialog:Hide();
		tempFrameContainer = _G[Lunar.Settings.ImportArtDialog:GetName() .. "WindowContainer"];

		-- Create filename caption
		tempObject = Lunar.Object:CreateCaption(15, -10, 150, 20, Lunar.Locale["ART_FILENAME"], "importArtFilenameCaption", tempFrameContainer, true);

		-- Create filename text box
		tempObject = CreateFrame("EditBox", "LSSettingsImportArtFilenameTextbox", tempFrameContainer, "LunarEditBox");

		tempObject:SetPoint("Topleft", tempFrameContainer, "Topleft", 20, -30)
		tempObject:SetWidth(168);
		tempObject:Show();

		-- Art type dropdown list
		tempObject = Lunar.Object:CreateDropdown(-5, -65, 164, "importArtType", Lunar.Locale["ART_TYPE"], "Skin_Edit_Types", "", tempFrameContainer, Lunar.API.BlankFunction);

		UIDropDownMenu_SetText(tempObject, Lunar.Locale["SPHERE"], tempObject);
--		UIDropDownMenu_SetSelectedName(tempObject, Lunar.Locale["SPHERE"])
		tempObject.selectedValue = 0;
	--[[
		-- Create width caption
		tempObject = Lunar.Object:CreateCaption(10, -95, 92, 20, Lunar.Locale["WIDTH"], "importArtWidth", tempFrameContainer, true);
		_G[tempObject:GetName() .. "Text"]:SetWidth(92);
		_G[tempObject:GetName() .. "Text"]:SetHeight(20);
		_G[tempObject:GetName() .. "Text"]:SetJustifyV("Top");
		_G[tempObject:GetName() .. "Text"]:SetJustifyH("Center");

		-- Create width text box
		tempObject = CreateFrame("EditBox", "LSSettingsImportArtWidthTextbox", tempFrameContainer, "LunarEditBox");

		tempObject:SetPoint("Topleft", tempFrameContainer, "Topleft", 26, -110)
		tempObject:SetWidth(64);
		tempObject:Show();

		-- Create height caption
		tempObject = Lunar.Object:CreateCaption(102, -95, 92, 20, Lunar.Locale["HEIGHT"], "importArtHeight", tempFrameContainer, true);
		_G[tempObject:GetName() .. "Text"]:SetWidth(92);
		_G[tempObject:GetName() .. "Text"]:SetHeight(20);
		_G[tempObject:GetName() .. "Text"]:SetJustifyV("Top");
		_G[tempObject:GetName() .. "Text"]:SetJustifyH("Center");

		-- Create height text box
		tempObject = CreateFrame("EditBox", "LSSettingsImportArtHeightTextbox", tempFrameContainer, "LunarEditBox");

		tempObject:SetPoint("Topleft", tempFrameContainer, "Topleft", 118, -110)
		tempObject:SetWidth(64);
		tempObject:Show();
	--]]

		-- Import art button
		tempObject = Lunar.Object:CreateButton(10, -134, 92, "ImportArtButton", Lunar.Locale["IMPORT"], tempFrameContainer,
		function()
			local artType = _G["LSSettingsimportArtType"].selectedValue;
			if (artType == 0) then
				artType = "sphere";
			elseif (artType == 1) then
				artType = "button";
			elseif (artType == 2) then
				artType = "gauge"
			elseif (artType == 3) then
				artType = "border"
			else
				artType = nil;
			end
			Lunar.API:AddArt(artType, 64, 64, _G["LSSettingsImportArtFilenameTextbox"]:GetText());
			Lunar.Settings.UpdateTextureList();
		end);

		-- Cancel button
		tempObject = Lunar.Object:CreateButton(102, -134, 92, "ImportArtCancel", CLOSE, tempFrameContainer,
		function()
			Lunar.Settings.ImportArtDialog:Hide();
		end);
	end

	function Lunar.Settings:UpdateTextureList()

		local slider = _G["LSTextureScrollerSlider"];
		local skinType, index, xLoc, yLoc, totalPages, selectedSkin, maxSkins;
		local lastSkinIndex, artType, width, height, artFilename, artCatagory, baseCount;

		maxSkins = 0;

		if (LunarSphereSettings.currentSkinEdit == 0) then
			maxSkins = Lunar.includedSpheres + LUNAR_EXTRA_SPHERE_ICON_COUNT;
			artCatagory = "sphere";
			skinType = "sphereSkin";
		elseif (LunarSphereSettings.currentSkinEdit == 1) then
			maxSkins = Lunar.includedButtons
			artCatagory = "button";
			skinType = "buttonSkin";
		elseif (LunarSphereSettings.currentSkinEdit == 2) then
			maxSkins = Lunar.includedGauges
			artCatagory = "gauge";
			skinType = "gaugeFill";
		elseif (LunarSphereSettings.currentSkinEdit == 3) then
			maxSkins = Lunar.includedBorders
			artCatagory = "border";
			skinType = "gaugeBorder";
		end
		baseCount = maxSkins;
		maxSkins = maxSkins + Lunar.API:GetArtCount(artCatagory);

		if (skinType) then
			selectedSkin = LunarSphereSettings[skinType];
		end
		totalPages = math.floor((maxSkins - 1) / 5);
		if (totalPages > 1) then
			totalPages = totalPages - 1;
			slider:GetThumbTexture():SetVertexColor(1,1,1);
		else
			totalPages = 0;	
			slider:GetThumbTexture():SetVertexColor(0.5, 0.5, 0.5);
		end

		slider:SetMinMaxValues(0, totalPages);

		index = math.floor(slider:GetValue() * 5 + 1);

		-- Set our custom art index starting place. If our slider is past the normal included
		-- buttons, we need to adjust the lastSkinIndex (which is the index of our custom skins)
		-- to ensure we show the right icons.
		lastSkinIndex = 1;
--		if (index >= (baseCount + 5)) and (skinType == "sphereSkin") then
--			lastSkinIndex = index - (Lunar.includedSpheres + LUNAR_EXTRA_SPHERE_ICON_COUNT)
--		else		if (index >= (baseCount + 5)) and (skinType == "buttonSkin") then
--			lastSkinIndex = index - (Lunar.includedButtons)
--		elseif (index >= (baseCount + 5)) and (skinType == "gaugeFill") then
--			lastSkinIndex = index - (Lunar.includedGauges)
--		elseif (index >= (baseCount + 5)) and (skinType == "gaugeBorder") then
--			lastSkinIndex = index - (Lunar.includedBorders)
--		end
		if (index >= (baseCount + 5)) then
			lastSkinIndex = index - baseCount;
		end

		_G["LSSettingsTextureSelector"]:Hide();
		_G["LSSettingsSkin3D"]:Hide();

		local hidePortrait;

		for yLoc = 0, 1 do 
			for xLoc = 0, 4 do
				_G["LSSettingsTextureIcon" .. (xLoc + (yLoc * 5) + 1) .. "Border"]:Hide();
				_G["LSSettingsTextureIcon" .. (xLoc + (yLoc * 5) + 1)]:GetNormalTexture():SetTexCoord(0,1,0,1);
				if (index <= maxSkins) then
					if (skinType == "sphereSkin") then
						if (index == (Lunar.includedSpheres + 1))  then
							SetPortraitTexture(_G["LSSettingsTextureIcon" .. (xLoc + (yLoc * 5) + 1)]:GetNormalTexture(), "player");
						elseif (index == (Lunar.includedSpheres + 2))  then
							-- 3d portrait placeholder ...
							_G["LSSettingsSkin3D"]:Show();
							_G["LSSettingsSkin3D"]:SetAllPoints(_G["LSSettingsTextureIcon" .. (xLoc + (yLoc * 5) + 1)]);
							_G["LSSettingsTextureIcon" .. (xLoc + (yLoc * 5) + 1)]:Hide();
							_G["LSSettingsSkin3D"]:SetUnit("player");
							_G["LSSettingsSkin3D"]:SetCamera(0);
							_G["LSSettingsSkin3D"]:SetID(_G["LSSettingsTextureIcon" .. (xLoc + (yLoc * 5) + 1)]:GetID());
							hidePortrait = true;
	--						SetPortraitTexture(_G["LSSettingsTextureIcon" .. (xLoc + (yLoc * 5) + 1)]:GetNormalTexture(), "player");
						-- class and faction icons
						elseif ((index > (Lunar.includedSpheres + 2)) and (index <= (Lunar.includedSpheres + LUNAR_EXTRA_SPHERE_ICON_COUNT))) then
							_G["LSSettingsTextureIcon" .. (xLoc + (yLoc * 5) + 1)]:SetNormalTexture(LUNAR_ART_PATH .. "sphereClass_" .. (index - Lunar.includedSpheres - 2));
						-- normal skin icons
						elseif (index < (Lunar.includedSpheres + LUNAR_EXTRA_SPHERE_ICON_COUNT)) then
							_G["LSSettingsTextureIcon" .. (xLoc + (yLoc * 5) + 1)]:SetNormalTexture(LUNAR_ART_PATH .. skinType .. "_" .. index);
						-- Custom imported art
						else
							lastSkinIndex, artType, width, height, artFilename = Lunar.API:GetNextArt("sphere", lastSkinIndex);
							if (artFilename) then
								_G["LSSettingsTextureIcon" .. (xLoc + (yLoc * 5) + 1)]:SetNormalTexture(LUNAR_IMPORT_PATH .. artFilename);
								lastSkinIndex = lastSkinIndex + 1;
							end
							_G["LSSettingsTextureIcon" .. (xLoc + (yLoc * 5) + 1) .. "Border"]:Show();
						end
					else
						-- Normal art	
						if (index <= baseCount) then --Lunar.includedButtons) then
							_G["LSSettingsTextureIcon" .. (xLoc + (yLoc * 5) + 1)]:SetNormalTexture(LUNAR_ART_PATH .. skinType .. "_" .. index);
						-- Custom imported art
						else
							lastSkinIndex, artType, width, height, artFilename = Lunar.API:GetNextArt(artCatagory, lastSkinIndex); --"button", lastSkinIndex);
							if (artFilename) then
								_G["LSSettingsTextureIcon" .. (xLoc + (yLoc * 5) + 1)]:SetNormalTexture(LUNAR_IMPORT_PATH .. artFilename);
								lastSkinIndex = lastSkinIndex + 1;
							end
							_G["LSSettingsTextureIcon" .. (xLoc + (yLoc * 5) + 1) .. "Border"]:Show();
						end
						if (skinType == "gaugeFill") then
							_G["LSSettingsTextureIcon" .. (xLoc + (yLoc * 5) + 1)]:GetNormalTexture():SetTexCoord(0,0.5,0,0.5);
						end
					end
					if (not hidePortrait) then
						_G["LSSettingsTextureIcon" .. (xLoc + (yLoc * 5) + 1)]:Show();
					end
					hidePortrait = nil;
				else
					_G["LSSettingsTextureIcon" .. (xLoc + (yLoc * 5) + 1)]:Hide();
				end
				if (index == selectedSkin) then
					_G["LSSettingsTextureSelector"]:SetPoint("Topleft", 18 + xLoc * 35, -74 - yLoc * 35);
					_G["LSSettingsTextureSelector"]:Show();
				end
				index = index + 1;
			end	
		end
		
		Lunar.Settings:UpdateSkinOptions()
	end

	function Lunar.Settings:UpdateSkinOptions()

		_G["LSSettingsshowSphereShine"]:Hide();
		_G["LSSettingssphereColor"]:Hide();
		_G["LSSettingsDefaultSphereColor"]:Hide();
		_G["LSSettingsshowButtonShine"]:Hide();
		_G["LSSettingsbuttonColor"]:Hide();
		_G["LSSettingsDefaultButtonColor"]:Hide();
		_G["LSSettingsmenuButtonColor"]:Hide();
		_G["LSSettingsDefaultMenuButtonColor"]:Hide();
		_G["LSSettingsshowOuterGaugeShine"]:Hide();
		_G["LSSettingsshowInnerGaugeShine"]:Hide();
		_G["LSSettingsuseSphereClickIcon"]:Hide();
		_G["LSSettingsrandomSphereTexture"]:Hide();
		_G["LSSettingsgaugeBorderColor"]:Hide();
--		_G["LSSettingsnoImages"]:Hide();				-- need to remove object
		if (LunarSphereSettings.currentSkinEdit == 0) then
			_G["LSSettingsshowSphereShine"]:Show();
			_G["LSSettingssphereColor"]:Show();
			_G["LSSettingsDefaultSphereColor"]:Show();
			_G["LSSettingsuseSphereClickIcon"]:Show();
			_G["LSSettingsrandomSphereTexture"]:Show();
		elseif (LunarSphereSettings.currentSkinEdit == 1) then
			_G["LSSettingsshowButtonShine"]:Show();
			_G["LSSettingsbuttonColor"]:Show();
			_G["LSSettingsmenuButtonColor"]:Show();
			_G["LSSettingsDefaultButtonColor"]:Show();
			_G["LSSettingsDefaultMenuButtonColor"]:Show();
		elseif (LunarSphereSettings.currentSkinEdit == 2) then
--			_G["LSSettingsnoImages"]:Show();
			_G["LSSettingsshowInnerGaugeShine"]:Show();
			_G["LSSettingsshowOuterGaugeShine"]:Show();
		elseif (LunarSphereSettings.currentSkinEdit == 3) then
			_G["LSSettingsgaugeBorderColor"]:Show();
--			_G["LSSettingsnoImages"]:Show();
--			_G["LSSettingsshowInnerGaugeShine"]:Show();
		end
		
	end
end

function Lunar.Settings.AnchorButton_OnClick(self)
	self:GetParent():Hide();	
end

function Lunar.Settings.AnchorRadio_OnDragStart(self)
	self:GetParent():StartMoving();
end

function Lunar.Settings.AnchorOrRadio_OnDragStop(self)
	local point, relativeTo, relativePoint, xOfs, yOfs, settingName;
	if (self.tooltipName) then
		self:StopMovingOrSizing();
		point, relativeTo, relativePoint, xOfs, yOfs = self:GetPoint();
		settingName = self.tooltipName
	else
		self:GetParent():StopMovingOrSizing();
		point, relativeTo, relativePoint, xOfs, yOfs = self:GetParent():GetPoint();
		settingName = self:GetParent().tooltipName;
	end
	LunarSphereSettings[settingName .. "point"] = point;
--	LunarSphereSettings[settingName .. "relativeTo"] = relativeTo;
	LunarSphereSettings[settingName .. "relativePoint"] = relativePoint;
	LunarSphereSettings[settingName .. "xOfs"] = xOfs;
	LunarSphereSettings[settingName .. "yOfs"] = yOfs;
end

function Lunar.Settings.AnchorRadio_OnClick(self)
	Lunar.Object.SetRadioSetting(self);
	local settingName = string.match(self:GetName(), "LSSettings(.*)(%d)");
	local pos = LunarSphereSettings[settingName] +  1;
	local temp = _G["LSSettings" .. self:GetParent().tooltipName];
	temp:ClearAllPoints();
	temp:SetPoint(Lunar.Button.tooltipPos[9 - pos], self:GetParent(), Lunar.Button.tooltipPos[pos]);
end

function Lunar.Settings:CreateAnchorPlaceholders()
	local frame, tex, text, temp, pos, i;

	local anchorSetting = "LS";

	for i = 1, 2 do 

		frame = Lunar.API:CreateFrame("Frame", "LSSettings" .. anchorSetting .. "Anchor", UIParent, 80, 80, nil, true, 0)
		if (anchorSetting == "LS") then
			frame:SetPoint(
				-- "Center");
				(LunarSphereSettings.anchorCornerLSpoint or "Center"), UIParent,
				(LunarSphereSettings.anchorCornerLSrelativePoint or "Center"),
				(LunarSphereSettings.anchorCornerLSxOfs or 0),
				(LunarSphereSettings.anchorCornerLSyOfs or 0));

		else
			frame:SetPoint(
				--"TOPLEFT", "UIParent", "BOTTOMRIGHT", -CONTAINER_OFFSET_X - 13, CONTAINER_OFFSET_Y + 9);
				(LunarSphereSettings.anchorCornerpoint or "Topleft"), UIParent,
				(LunarSphereSettings.anchorCornerrelativePoint or "Bottomright"),
				(LunarSphereSettings.anchorCornerxOfs or (-CONTAINER_OFFSET_X - 13)),
				(LunarSphereSettings.anchorCorneryOfs or (CONTAINER_OFFSET_Y + 9)));
		end
				
		frame:SetFrameStrata("DIALOG");
		frame:RegisterForDrag("LeftButton");
		frame:SetMovable(true);
		frame:SetScript("OnDragStart", frame.StartMoving);
		frame:SetScript("OnDragStop", Lunar.Settings.AnchorOrRadio_OnDragStop);
		frame.tooltipName = "anchorCorner" .. anchorSetting;

		pos = LunarSphereSettings["anchorCorner" .. anchorSetting] +  1;
		temp = Lunar.API:CreateFrame("Frame", "LSSettings" .. frame.tooltipName, frame, 80, 60, nil, true, 0)

		if not GameTooltip.GetBackdrop then
		    Mixin(GameTooltip, BackdropTemplateMixin)
		end

		temp:SetBackdrop(GameTooltip:GetBackdrop());
		temp:SetPoint(Lunar.Button.tooltipPos[9 - pos], frame, Lunar.Button.tooltipPos[pos]);
		temp:RegisterForDrag("LeftButton");
		temp:SetScript("OnDragStart", Lunar.Settings.AnchorRadio_OnDragStart);
		temp:SetScript("OnDragStop", Lunar.Settings.AnchorOrRadio_OnDragStop);

		tex = frame:CreateTexture("", "BACKGROUND");
		tex:SetAllPoints(frame);
		tex:SetColorTexture(0.0, 0.6, 0.8, 0.75);
		frame.texture = tex;

		text = frame:CreateFontString("", "OVERLAY");
		text:SetPoint("CENTER", 0, 0)
		text:SetFont(STANDARD_TEXT_FONT, 14, "OUTLINE")
		text:SetTextColor(1, 1, 1)
		if (anchorSetting == "LS") then
			text:SetText("LS")
		else
			text:SetText("Tooltip");
		end
		frame.text = text;

		temp = Lunar.Object:CreateRadio(-4, 4, "", frame.tooltipName, 0, frame, Lunar.Settings.AnchorRadio_OnClick);
		temp:SetHitRectInsets(0, 1, 0, 0);
		temp:RegisterForDrag("LeftButton");
		temp:SetScript("OnDragStart", Lunar.Settings.AnchorRadio_OnDragStart);
		temp:SetScript("OnDragStop", Lunar.Settings.AnchorOrRadio_OnDragStop);

		temp = Lunar.Object:CreateRadio(32, 4, "", frame.tooltipName, 1, frame, Lunar.Settings.AnchorRadio_OnClick);
		temp:SetHitRectInsets(0, 1, 0, 0);
		temp:RegisterForDrag("LeftButton");
		temp:SetScript("OnDragStart", Lunar.Settings.AnchorRadio_OnDragStart);
		temp:SetScript("OnDragStop", Lunar.Settings.AnchorOrRadio_OnDragStop);

		temp = Lunar.Object:CreateRadio(64 + 4, 4, "", frame.tooltipName, 2, frame, Lunar.Settings.AnchorRadio_OnClick);
		temp:SetHitRectInsets(0, 1, 0, 0);
		temp:RegisterForDrag("LeftButton");
		temp:SetScript("OnDragStart", Lunar.Settings.AnchorRadio_OnDragStart);
		temp:SetScript("OnDragStop", Lunar.Settings.AnchorOrRadio_OnDragStop);

		temp = Lunar.Object:CreateRadio(-4, -32, "", frame.tooltipName, 3, frame, Lunar.Settings.AnchorRadio_OnClick);
		temp:SetHitRectInsets(0, 1, 0, 0);
		temp:RegisterForDrag("LeftButton");
		temp:SetScript("OnDragStart", Lunar.Settings.AnchorRadio_OnDragStart);
		temp:SetScript("OnDragStop", Lunar.Settings.AnchorOrRadio_OnDragStop);

		temp = Lunar.Object:CreateRadio(64 + 4, -32, "", frame.tooltipName, 4, frame, Lunar.Settings.AnchorRadio_OnClick);
		temp:SetHitRectInsets(0, 1, 0, 0);
		temp:RegisterForDrag("LeftButton");
		temp:SetScript("OnDragStart", Lunar.Settings.AnchorRadio_OnDragStart);
		temp:SetScript("OnDragStop", Lunar.Settings.AnchorOrRadio_OnDragStop);

		temp = Lunar.Object:CreateRadio(-4, -64 - 4, "", frame.tooltipName, 5, frame, Lunar.Settings.AnchorRadio_OnClick);
		temp:SetHitRectInsets(0, 1, 0, 0);
		temp:RegisterForDrag("LeftButton");
		temp:SetScript("OnDragStart", Lunar.Settings.AnchorRadio_OnDragStart);
		temp:SetScript("OnDragStop", Lunar.Settings.AnchorOrRadio_OnDragStop);

		temp = Lunar.Object:CreateRadio(32, -64 - 4, "", frame.tooltipName, 6, frame, Lunar.Settings.AnchorRadio_OnClick);
		temp:SetHitRectInsets(0, 1, 0, 0);
		temp:RegisterForDrag("LeftButton");
		temp:SetScript("OnDragStart", Lunar.Settings.AnchorRadio_OnDragStart);
		temp:SetScript("OnDragStop", Lunar.Settings.AnchorOrRadio_OnDragStop);

		temp = Lunar.Object:CreateRadio(64 + 4, -64 - 4, "", frame.tooltipName, 7, frame, Lunar.Settings.AnchorRadio_OnClick);
		temp:SetHitRectInsets(0, 1, 0, 0);
		temp:RegisterForDrag("LeftButton");
		temp:SetScript("OnDragStart", Lunar.Settings.AnchorRadio_OnDragStart);
		temp:SetScript("OnDragStop", Lunar.Settings.AnchorOrRadio_OnDragStop);

		frame:Hide();

		anchorSetting = "";
	end
end

end

function Lunar.Settings:EnableHideUI(enable)

	if (LunarSphereSettings.memoryDisableDefaultUI) then
		return;
	end

	local funcName = "Hide";
	_G["LSSettings" .. "InCombatHideUI"]:Show();
	if (enable == true) then
		funcName = "Show";
		_G["LSSettings" .. "InCombatHideUI"]:Hide();
	end

	local checkBox;

	checkBox = _G["LSSettings" .. "hidePlayer"];
	pcall(checkBox[funcName], checkBox, nil);

	checkBox = _G["LSSettings" .. "hideMinimap"];
	pcall(checkBox[funcName], checkBox, nil);

	checkBox = _G["LSSettings" .. "hideTime"];
	pcall(checkBox[funcName], checkBox, nil);

	checkBox = _G["LSSettings" .. "hideZoom"];
	pcall(checkBox[funcName], checkBox, nil);

	checkBox = _G["LSSettings" .. "hideWorldmap"];
	pcall(checkBox[funcName], checkBox, nil);

	checkBox = _G["LSSettings" .. "hideCalendar"];
	pcall(checkBox[funcName], checkBox, nil);

	checkBox = _G["LSSettings" .. "hideTracking"];
	pcall(checkBox[funcName], checkBox, nil);

	checkBox = _G["LSSettings" .. "hideEXP"];
	pcall(checkBox[funcName], checkBox, nil);

	checkBox = _G["LSSettings" .. "hideGryphons"];
	pcall(checkBox[funcName], checkBox, nil);

	checkBox = _G["LSSettings" .. "hideMenus"];
	pcall(checkBox[funcName], checkBox, nil);

	checkBox = _G["LSSettings" .. "hideBags"];
	pcall(checkBox[funcName], checkBox, nil);

	checkBox = _G["LSSettings" .. "hideBottomBar"];
	pcall(checkBox[funcName], checkBox, nil);

	checkBox = _G["LSSettings" .. "hideActions"];
	pcall(checkBox[funcName], checkBox, nil);

	checkBox = _G["LSSettings" .. "hideStance"];
	pcall(checkBox[funcName], checkBox, nil);

	checkBox = _G["LSSettings" .. "hidePetBar"];
	pcall(checkBox[funcName], checkBox, nil);

--	checkBox = _G["LSSettings" .. "hideTotemBar"];
--	pcall(checkBox[funcName], checkBox, nil);

end
