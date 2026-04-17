--------------------------------------------------------------------------
-- GTFO_Retail.lua 
--------------------------------------------------------------------------
--[[
GTFO
Author: Zensunim of Dragonblight [Retail], Myzrael [Classic]

Usage: /GTFO or go to Interface->Add-ons->GTFO
]]--

function GTFO_OnEvent(self, event, ...)
	if (event == "VARIABLES_LOADED") then
		C_ChatInfo.RegisterAddonMessagePrefix("GTFO");
		if (GTFOData.DataCode ~= GTFO.DataCode) then
			GTFO_SetDefaults();
			GTFO_ChatPrint(string.format(GTFOLocal.Loading_NewDatabase, GTFO.Version));
			GTFO_DisplayConfigPopupMessage();
		end
		GTFO.Settings = {
			Active = GTFOData.Active;
			Sounds = { GTFOData.Sounds[1], GTFOData.Sounds[2], GTFOData.Sounds[3], GTFOData.Sounds[4] };
			ScanMode = GTFOData.ScanMode;
			AlertMode = GTFOData.AlertMode;
			DebugMode = GTFOData.DebugMode;
			TestMode = GTFOData.TestMode;
			UnmuteMode = GTFOData.UnmuteMode;
			TrivialMode = GTFOData.TrivialMode;
			NoVersionReminder = GTFOData.NoVersionReminder;
			EnableVibration = GTFOData.EnableVibration;
			Volume = GTFOData.Volume or 3;
			TrivialDamagePercent = GTFOData.TrivialDamagePercent or GTFO.DefaultSettings.TrivialDamagePercent;
			SoundChannel = GTFOData.SoundChannel or GTFO.DefaultSettings.SoundChannel;
			BrannMode = GTFOData.BrannMode;
			IgnoreTimeAmount = GTFOData.IgnoreTimeAmount;
			AFKAlertMode = GTFOData.AFKAlertMode;
			IgnoreOptions = { };
			SoundOverrides = { "", "", "", "" };
			IgnoreSpellList = { };
		};
		
		-- Load spell ignore options (player set)
		if (GTFOData.IgnoreOptions) then
			for key, option in pairs(GTFOData.IgnoreOptions) do
				GTFO.Settings.IgnoreOptions[key] = GTFOData.IgnoreOptions[key];
			end
		end
		
		-- Load default spell ignore options
		if (GTFO.IgnoreSpellCategory) then
			for key, option in pairs(GTFO.IgnoreSpellCategory) do
				if (GTFO.IgnoreSpellCategory[key].isDefault) then
					GTFO.DefaultSettings.IgnoreOptions[key] = true;
					if (GTFO.Settings.IgnoreOptions[key] == nil) then
						GTFO.Settings.IgnoreOptions[key] = true;
					end
				end
			end
		end
		
		if (GTFOData.SoundOverrides) then
			for key, option in pairs(GTFOData.SoundOverrides) do
				GTFO.Settings.SoundOverrides[key] = GTFOData.SoundOverrides[key] or "";
			end
		end
		
		if (GTFOData.IgnoreSpellList) then
			for i, spellId in pairs(GTFOData.IgnoreSpellList) do
				GTFO.AddUnique(GTFO.Settings.IgnoreSpellList, spellId);
			end
		end

		GTFO_RenderOptions();
		GTFO_SaveSettings();
		GTFO_AddEvent("RefreshOptions", .1, function() GTFO_RefreshOptions(); end);

		if (GTFO.Settings.Active) then
			--GTFO_ChatPrint(string.format(GTFOLocal.Loading_Loaded, GTFO.Version));
		else
			GTFO_ChatPrint(string.format(GTFOLocal.Loading_LoadedSuspended, GTFO.Version));
		end
		
		GTFO.Users[UnitName("player")] = GTFO.VersionNumber;
		GTFO_GetSounds();
		GTFO.CanTank = GTFO_CanTankCheck();
		if (GTFO.CanTank) then
			GTFO_RegisterTankEvents();
		end
		GTFO.TankMode = GTFO_CheckTankMode();
		GTFO_SendUpdateRequest();
	
		-- Load Encounter and Instance cache data
		GTFO.BuildIndexes();
		GTFO.UpdateAFKStatus();
	
		-- Display state errors meant for debuggers:
		if (GTFO.Settings.ScanMode) then
			GTFO_ErrorPrint("Scan (debugging) mode is currently on.");
			GTFO_ErrorPrint(" To turn this off, type: |cFFEEEE00/gtfo scan|r");
		end
		if (GTFO.Settings.AlertMode) then
			GTFO_ErrorPrint("Alert (debugging) mode is currently on.");
			GTFO_ErrorPrint(" To turn this off, type: |cFFEEEE00/gtfo alert|r");
		end
		if (GTFO.Settings.DebugMode) then
			GTFO_ErrorPrint("Debug mode is currently on.");
			GTFO_ErrorPrint(" To turn this off, type: |cFFEEEE00/gtfo debug|r");
		end
		
		GTFO_ActivateMod();
		return;
	end
	if (event == "PLAYER_ENTERING_WORLD") then
		-- Refresh mode status just in case
		GTFO.TankMode = GTFO_CheckTankMode();
		GTFO.HandleAFKAlert(event, ...);
		GTFO_ActivateMod();
		return;
	end
	if (event == "PLAYER_STARTED_MOVING") then
		GTFO.VariableStore.PlayerAFK = false;
		return;
	end
	if (event == "PLAYER_FLAGS_CHANGED") then
		GTFO.HandleAFKAlert(event, ...);
		return;
	end
	if (event == "PLAYER_REGEN_DISABLED") then
		GTFO.HandleAFKAlert(event, ...);
		return;
	end
	if (event == "MIRROR_TIMER_START") then
		-- Fatigue bar warning
		local sType, iValue, iMaxValue, iScale, bPaused, sLabel = ...;
		if (sType == "EXHAUSTION" and iScale < 0) then
			if (GTFO.Settings.IgnoreOptions and GTFO.Settings.IgnoreOptions["Fatigue"]) then
				-- Fatigue being ignored
				--GTFO_DebugPrint("Won't alert FATIGUE - Manually ignored");
				return;
			end
			GTFO_PlaySound(1);
		end
		return;
	end
	if (event == "CHAT_MSG_ADDON") then
		local msgPrefix, msgMessage, msgType, msgSender = ...;
		if (msgPrefix == "GTFO" and msgMessage and msgMessage ~= "") then
			local iSlash = string.find(msgMessage,":",1);
			if (iSlash) then
				local sCommand = string.sub(msgMessage,1,iSlash - 1);
				local sValue = string.sub(msgMessage,iSlash + 1);
				if (sCommand == "V" and sValue) then
					-- Version update received
					--GTFO_DebugPrint(msgSender.." sent version info '"..sValue.."' to "..msgType);
					if (not GTFO.Users[msgSender]) then
						GTFO_SendUpdate(msgType);
					end
					GTFO.Users[msgSender] = sValue;
					if ((tonumber(sValue) > GTFO.VersionNumber) and not GTFO.UpdateFound) then
						GTFO.UpdateFound = GTFO_ParseVersionNumber(sValue);
						if (not GTFO.Settings.NoVersionReminder) then
							GTFO_ChatPrint(string.format(GTFOLocal.Loading_OutOfDate, GTFO.UpdateFound));
						end
					end
					return;
				elseif (sCommand == "U" and sValue) then
					-- Version Request
					--GTFO_DebugPrint(msgSender.." requested update to "..sValue);
					GTFO_SendUpdate(sValue);
					return;
				end
			end
		end
		return;
	end
	if (event == "GROUP_ROSTER_UPDATE") then
		--GTFO_DebugPrint("Group roster was updated");
		local sentUpdate = nil;
		GTFO_ScanGroupGUID();
		local PartyMembers = GetNumSubgroupMembers();
		if (PartyMembers > GTFO.PartyMembers and GTFO.RaidMembers == 0) then
			if (IsInGroup(LE_PARTY_CATEGORY_INSTANCE)) then
				GTFO_SendUpdate("INSTANCE_CHAT");
			else
				GTFO_SendUpdate("PARTY");
			end
			sentUpdate = true;
		end
		GTFO.PartyMembers = PartyMembers;

		local RaidMembers = GetNumGroupMembers();		
		if (not IsInRaid()) then
			RaidMembers = 0
		end

		if (RaidMembers > GTFO.RaidMembers) then
			if (IsInGroup(LE_PARTY_CATEGORY_INSTANCE)) then
				if (not sentUpdate) then
					GTFO_SendUpdate("INSTANCE_CHAT");
				end
			else
				GTFO_SendUpdate("RAID");
			end
		end
		GTFO.RaidMembers = RaidMembers;		
		return;
	end
	if (event == "UNIT_INVENTORY_CHANGED") then
		local msgUnit = ...;
		if (UnitIsUnit(msgUnit, "PLAYER")) then
			--GTFO_DebugPrint("Inventory changed, check tank mode");
			GTFO.TankMode = GTFO_CheckTankMode();
		end
		return;
	end
	if (event == "UPDATE_SHAPESHIFT_FORM") then
		--GTFO_DebugPrint("Form changed, check tank mode");
		GTFO.TankMode = GTFO_CheckTankMode();
		return;
	end
	if (event == "ACTIVE_TALENT_GROUP_CHANGED" or event == "PLAYER_TALENT_UPDATE") then
		--GTFO_DebugPrint("Spec changed, check tank/caster mode -- "..event);
		GTFO.TankMode = GTFO_CheckTankMode();
		GTFO.CasterMode = GTFO_CheckCasterMode();
		return;
	end
	if (event == "ENCOUNTER_START") then
		local encounterId, encounterName, difficultyID, groupSize = ...;
		GTFO.RegisterEncounter(encounterId);
		return;
	end
	if (event == "ENCOUNTER_END") then
		GTFO.CurrentEncounterId = nil;
		GTFO.PendingEncounterUnregister = true;
		GTFO.TryUnregisterEncounter();		
		return;
	end
	if (event == "PLAYER_REGEN_ENABLED") then
		if (GTFO.PendingEncounterUnregister) then
			GTFO.TryUnregisterEncounter();
		end
		GTFO.HandleAFKAlert(event, ...);
		return;
	end
end

function GTFO.IsPlayerAFK()
	local success, isAFK = pcall(function()
		return UnitIsAFK("player") == true;
	end);
	if (success) then
		return isAFK;
	end
	return nil;
end

function GTFO.UpdateAFKStatus()
	local isAFK = GTFO.IsPlayerAFK();
	if (isAFK ~= nil) then
		GTFO.VariableStore.PlayerAFK = isAFK;
	end
end

function GTFO.HandleAFKAlert(event, ...)
	if (event == "PLAYER_ENTERING_WORLD") then
		GTFO.UpdateAFKStatus();
		return;
	end
	if (event == "PLAYER_FLAGS_CHANGED") then
		local unit = ...;
		if (unit and UnitIsUnit(unit, "player")) then
			if (unit and UnitIsUnit(unit, "player")) then
				C_Timer.After(0, function()
					GTFO.UpdateAFKStatus();
				end);
			end
		end
		return;
	end
	if (event == "PLAYER_REGEN_ENABLED") then
		GTFO.UpdateAFKStatus();
		return;
	end
	if not (event == "PLAYER_REGEN_DISABLED" and GTFO.Settings.Active and GTFO.Settings.AFKAlertMode) then
		return;
	end

	local isAFK = GTFO.VariableStore.PlayerAFK;
	local currentAFK = GTFO.IsPlayerAFK();
	if (currentAFK ~= nil) then
		isAFK = currentAFK;
		GTFO.VariableStore.PlayerAFK = currentAFK;
	end

	if (isAFK == true) then
		GTFO_PlaySound(1);
	end
end

function GTFO.RegisterEncounter(encounterId)
	if (encounterId) then
		GTFO.CurrentEncounterId = encounterId;
		GTFO_DebugPrint("Register for encounter "..GTFO.CurrentEncounterId);
		local spells = GTFO.EncounterIndex[GTFO.CurrentEncounterId];
		if (spells and #spells > 0) then
			if (InCombatLockdown()) then
				GTFO_ChatPrint(GTFOLocal.Help_EncounterRegistrationBlocked);
				return;
			end
			GTFO_DebugPrint("Found "..#spells.." spell(s) for "..GTFO.CurrentEncounterId);
			GTFO.RegisterSpellList(spells, GTFO.EncounterPrivateAuraSoundIds);
		end
	end
end

function GTFO.TryUnregisterEncounter()
	if (InCombatLockdown()) then
		return;
	end

	GTFO.PendingEncounterUnregister = nil;
	GTFO.UnregisterEncounter();
end

function GTFO.UnregisterEncounter()
	for i, soundId in pairs(GTFO.EncounterPrivateAuraSoundIds) do
		C_UnitAuras.RemovePrivateAuraAppliedSound(soundId)
		--GTFO_DebugPrint(tostring(GTFO.EncounterPrivateAuraSoundIds)..": Unregistering encounter private aura");
	end
	GTFO.EncounterPrivateAuraSoundIds = { };
	return;
end

function GTFO.RegisterInstance()
	local name, instanceType, difficultyID, difficultyName, maxPlayers, dynamicDifficulty, isDynamic, instanceID, instanceGroupSize, LfgDungeonID = GetInstanceInfo();
	if (instanceID) then
		GTFO_DebugPrint("Register for instance "..tostring(instanceID));
		local spells = GTFO.InstanceIndex[instanceID];
		if (spells and #spells > 0) then
			GTFO_DebugPrint("Found "..#spells.." spell(s) for "..tostring(instanceID));
			GTFO.RegisterSpellList(spells, GTFO.InstancePrivateAuraSoundIds);
		end
	end
end

function GTFO.UnregisterInstance()
	for i, soundId in pairs(GTFO.InstancePrivateAuraSoundIds) do
		C_UnitAuras.RemovePrivateAuraAppliedSound(soundId)
		--GTFO_DebugPrint(tostring(GTFO.InstancePrivateAuraSoundIds)..": Unregistering instance private aura");
	end
	GTFO.InstancePrivateAuraSoundIds = { };
	return;
end

function GTFO.RegisterSpellList(spells, registeredIdList)
	for i, spellIdText in pairs(spells) do
		local spell = GTFO.SpellID[spellIdText];
		local spellId = tonumber(spellIdText);
		if not (spellId) then
			-- Spell is not a valid number
			GTFO_ErrorPrint("Invalid Spell ID '"..tostring(spellId).."'");
		elseif (tContains(GTFO.Settings.IgnoreSpellList, spellId)) then
			-- Spell is on the custom ignore list
			--GTFO_DebugPrint("Won't alert "..GTFO.SpellTooltip(spellId).." - Player custom ignore option");
		elseif (spell.test and not GTFO.Settings.TestMode) then
			-- Experiemental/Beta option is off, ignore
			--GTFO_DebugPrint("Won't alert "..GTFO.SpellTooltip(spellId).." - Test mode off");
		elseif (not C_UnitAuras.AuraIsPrivate(spellId)) then
			-- Blizzard changed this spell and it's no longer a private aura
			GTFO_DebugPrint("Error: Won't alert "..GTFO.SpellTooltip(spellId).." - This spell is no longer a private aura");
		else
			local alertLevel = GTFO_GetAlertID(spell);
			if (spell.test) then
				GTFO_ErrorPrint("TEST ALERT: Spell ID #"..spellId.." "..GTFO_GetSpellLink(spellId));
			end
			local soundFileName, soundChannel, soundLevel, altSoundFileName = GTFO_GetSoundData(alertLevel);
			if (soundLevel and soundLevel > 0) then
				for i = 1, soundLevel do
					local soundFileId = tonumber(soundFileName);
					local privateAuraSoundId = C_UnitAuras.AddPrivateAuraAppliedSound({
						spellID = spellId,
						unitToken = "player",
						soundFileName = (soundFileId and nil or soundFileName),
						soundFileID = soundFileId,
						outputChannel = soundChannel
					});
					GTFO.AddUnique(registeredIdList, privateAuraSoundId);
					--GTFO_DebugPrint(tostring(registeredIdList)..": Registering private aura sound "..tostring(soundFileId or soundFileName).." for "..GTFO.SpellTooltip(spellId));
					
					-- Alt sound support (Brann mode)
					if (altSoundFileName) then
						local altSoundFileId = tonumber(altSoundFileName);
						
						local privateAuraSoundIdAlt = C_UnitAuras.AddPrivateAuraAppliedSound({
							spellID = spellId,
							unitToken = "player",
							soundFileName = (altSoundFileId and nil or altSoundFileName),
							soundFileID = altSoundFileId,
							outputChannel = soundChannel
						});
						GTFO.AddUnique(registeredIdList, privateAuraSoundIdAlt);
						--GTFO_DebugPrint(tostring(registeredIdList)..": Registering private aura sound "..tostring(altSoundFileId or altSoundFileName).." for "..GTFO.SpellTooltip(spellId));						
					end
				end
			else
				--GTFO_DebugPrint("Ignoring alert for "..tostring(spellId));
			end
		end
	end
		
end

function GTFO_OnLoad()
	GTFOFrame:RegisterEvent("VARIABLES_LOADED");
	GTFOFrame:RegisterEvent("GROUP_ROSTER_UPDATE");
	GTFOFrame:RegisterEvent("CHAT_MSG_ADDON");
	GTFOFrame:RegisterEvent("MIRROR_TIMER_START");
	GTFOFrame:RegisterEvent("ENCOUNTER_START");
	GTFOFrame:RegisterEvent("ENCOUNTER_END");
	GTFOFrame:RegisterEvent("PLAYER_ENTERING_WORLD");
	GTFOFrame:RegisterEvent("PLAYER_REGEN_ENABLED");
	SlashCmdList["GTFO"] = GTFO_Command;
	SLASH_GTFO1 = "/GTFO";
end

-- Create Addon Menu options and interface
function GTFO_RenderOptions()

	
	local ConfigurationPanel = CreateFrame("FRAME","GTFO_MainFrame");
	ConfigurationPanel.name = "GTFO";
	local category, layout = Settings.RegisterCanvasLayoutCategory(ConfigurationPanel, ConfigurationPanel.name);
	Settings.RegisterAddOnCategory(category);
	GTFO.SettingsCategoryId = category:GetID();

	local IntroMessageHeader = ConfigurationPanel:CreateFontString(nil, "ARTWORK","GameFontNormalLarge");
	IntroMessageHeader:SetPoint("TOPLEFT", 10, -10);
	IntroMessageHeader:SetText("GTFO "..GTFO.Version);

	local EnabledButton = CreateFrame("CheckButton", "GTFO_EnabledButton", ConfigurationPanel, "ChatConfigCheckButtonTemplate");
	EnabledButton:SetPoint("TOPLEFT", 10, -35)
	EnabledButton.tooltip = GTFOLocal.UI_EnabledDescription;
	getglobal(EnabledButton:GetName().."Text"):SetText(GTFOLocal.UI_Enabled);
	EnabledButton.optionKey = "Enabled";
	EnabledButton:SetScript("OnClick", GTFO.ToggleCheckboxOption);

	local HighSoundButton = CreateFrame("CheckButton", "GTFO_HighSoundButton", ConfigurationPanel, "ChatConfigCheckButtonTemplate");
	HighSoundButton:SetPoint("TOPLEFT", 10, -65)
	HighSoundButton.tooltip = GTFOLocal.UI_HighDamageDescription;
	getglobal(HighSoundButton:GetName().."Text"):SetText(GTFOLocal.UI_HighDamage);
	HighSoundButton.optionKey = "HighSound";
	HighSoundButton:SetScript("OnClick", GTFO.ToggleCheckboxOption);

	local LowSoundButton = CreateFrame("CheckButton", "GTFO_LowSoundButton", ConfigurationPanel, "ChatConfigCheckButtonTemplate");
	LowSoundButton:SetPoint("TOPLEFT", 10, -95)
	LowSoundButton.tooltip = GTFOLocal.UI_LowDamageDescription.."\n\n|cffff2020"..GTFOLocal.UI_BrokenPartialReason.."|r";
	getglobal(LowSoundButton:GetName().."Text"):SetText(GTFOLocal.UI_LowDamage2);
	LowSoundButton.optionKey = "LowSound";
	LowSoundButton:SetScript("OnClick", GTFO.ToggleCheckboxOption);

	local FailSoundButton = CreateFrame("CheckButton", "GTFO_FailSoundButton", ConfigurationPanel, "ChatConfigCheckButtonTemplate");
	FailSoundButton:SetPoint("TOPLEFT", 10, -125)
	FailSoundButton.tooltip = GTFOLocal.UI_FailDescription;
	getglobal(FailSoundButton:GetName().."Text"):SetText(GTFOLocal.UI_Fail);
	FailSoundButton.optionKey = "FailSound";
	FailSoundButton:SetScript("OnClick", GTFO.ToggleCheckboxOption);

	local FriendlyFireSoundButton = CreateFrame("CheckButton", "GTFO_FriendlyFireSoundButton", ConfigurationPanel, "ChatConfigCheckButtonTemplate");
	FriendlyFireSoundButton:SetPoint("TOPLEFT", 10, -155)
	FriendlyFireSoundButton.tooltip = GTFOLocal.UI_FriendlyFireDescription;
	getglobal(FriendlyFireSoundButton:GetName().."Text"):SetText(GTFOLocal.UI_FriendlyFire);
	FriendlyFireSoundButton.optionKey = "FriendlyFireSound";
	FriendlyFireSoundButton:SetScript("OnClick", GTFO.ToggleCheckboxOption);

	local HighTestButton = CreateFrame("Button", "GTFO_HighTestButton", ConfigurationPanel, "UIPanelButtonTemplate");
	HighTestButton:SetPoint("TOPLEFT", 300, -65);
	HighTestButton.tooltip = GTFOLocal.UI_TestDescription;
	HighTestButton:SetScript("OnClick",GTFO_Option_HighTest);
	getglobal(HighTestButton:GetName().."Text"):SetText(GTFOLocal.UI_Test);

	local LowTestButton = CreateFrame("Button", "GTFO_LowTestButton", ConfigurationPanel, "UIPanelButtonTemplate");
	LowTestButton:SetPoint("TOPLEFT", 300, -95);
	LowTestButton.tooltip = GTFOLocal.UI_TestDescription;
	LowTestButton:SetScript("OnClick",GTFO_Option_LowTest);
	getglobal(LowTestButton:GetName().."Text"):SetText(GTFOLocal.UI_Test);

	local FailTestButton = CreateFrame("Button", "GTFO_FailTestButton", ConfigurationPanel, "UIPanelButtonTemplate");
	FailTestButton:SetPoint("TOPLEFT", 300, -125);
	FailTestButton.tooltip = GTFOLocal.UI_TestDescription;
	FailTestButton:SetScript("OnClick",GTFO_Option_FailTest);
	getglobal(FailTestButton:GetName().."Text"):SetText(GTFOLocal.UI_Test);

	local FriendlyFireTestButton = CreateFrame("Button", "GTFO_FriendlyFireTestButton", ConfigurationPanel, "UIPanelButtonTemplate");
	FriendlyFireTestButton:SetPoint("TOPLEFT", 300, -155);
	FriendlyFireTestButton.tooltip = GTFOLocal.UI_TestDescription;
	FriendlyFireTestButton:SetScript("OnClick",GTFO_Option_FriendlyFireTest);
	getglobal(FriendlyFireTestButton:GetName().."Text"):SetText(GTFOLocal.UI_Test);

	local HighResetButton = CreateFrame("Button", "GTFO_HighResetButton", ConfigurationPanel, "UIPanelButtonTemplate");
	HighResetButton:SetPoint("TOPLEFT", 360, -65);
	HighResetButton.tooltip = GTFOLocal.UI_ResetCustomSounds;
	HighResetButton:SetScript("OnClick",GTFO_Option_HighReset);
	getglobal(HighResetButton:GetName().."Text"):SetText(GTFOLocal.UI_Reset);

	local LowResetButton = CreateFrame("Button", "GTFO_LowResetButton", ConfigurationPanel, "UIPanelButtonTemplate");
	LowResetButton:SetPoint("TOPLEFT", 360, -95);
	LowResetButton.tooltip = GTFOLocal.UI_ResetCustomSounds;
	LowResetButton:SetScript("OnClick",GTFO_Option_LowReset);
	getglobal(LowResetButton:GetName().."Text"):SetText(GTFOLocal.UI_Reset);

	local FailResetButton = CreateFrame("Button", "GTFO_FailResetButton", ConfigurationPanel, "UIPanelButtonTemplate");
	FailResetButton:SetPoint("TOPLEFT", 360, -125);
	FailResetButton.tooltip = GTFOLocal.UI_ResetCustomSounds;
	FailResetButton:SetScript("OnClick",GTFO_Option_FailReset);
	getglobal(FailResetButton:GetName().."Text"):SetText(GTFOLocal.UI_Reset);

	local FriendlyFireResetButton = CreateFrame("Button", "GTFO_FriendlyFireResetButton", ConfigurationPanel, "UIPanelButtonTemplate");
	FriendlyFireResetButton:SetPoint("TOPLEFT", 360, -155);
	FriendlyFireResetButton.tooltip = GTFOLocal.UI_ResetCustomSounds;
	FriendlyFireResetButton:SetScript("OnClick",GTFO_Option_FriendlyFireReset);
	getglobal(FriendlyFireResetButton:GetName().."Text"):SetText(GTFOLocal.UI_Reset);

	local VolumeText = ConfigurationPanel:CreateFontString("GTFO_VolumeText","ARTWORK","GameFontNormal");
	VolumeText:SetPoint("TOPLEFT", 170, -195);
	VolumeText:SetText("");

	local VolumeSlider = CreateFrame("Slider", "GTFO_VolumeSlider", ConfigurationPanel, "OptionsSliderTemplate");
	VolumeSlider:SetPoint("TOPLEFT", 12, -195);
	VolumeSlider.tooltip = GTFOLocal.UI_VolumeDescription;
	VolumeSlider:SetScript("OnValueChanged",GTFO_Option_SetVolume);
	if (getglobal(GTFO_VolumeSlider:GetName().."Text")) then
		getglobal(GTFO_VolumeSlider:GetName().."Text"):SetText(GTFOLocal.UI_Volume);
		getglobal(GTFO_VolumeSlider:GetName().."High"):SetText(GTFOLocal.UI_VolumeMax);
		getglobal(GTFO_VolumeSlider:GetName().."Low"):SetText(GTFOLocal.UI_VolumeMin);
	end
	VolumeSlider:SetMinMaxValues(1,5);
	VolumeSlider:SetValueStep(1);
	VolumeSlider:SetValue(GTFO.Settings.Volume);
	GTFO_Option_SetVolumeText(GTFO.Settings.Volume);
	
	local UnmuteButton = CreateFrame("CheckButton", "GTFO_UnmuteButton", ConfigurationPanel, "ChatConfigCheckButtonTemplate");
	UnmuteButton:SetPoint("TOPLEFT", 10, -240)
	UnmuteButton.tooltip = GTFOLocal.UI_UnmuteDescription.."\n\n("..GTFOLocal.UI_UnmuteDescription2..")";
	getglobal(UnmuteButton:GetName().."Text"):SetText(GTFOLocal.UI_Unmute);
	UnmuteButton.optionKey = "Unmute";
	UnmuteButton:SetScript("OnClick", GTFO.ToggleCheckboxOption);

	local TrivialButton = CreateFrame("CheckButton", "GTFO_TrivialButton", ConfigurationPanel, "ChatConfigCheckButtonTemplate");
	TrivialButton:SetPoint("TOPLEFT", 10, -270)
	TrivialButton.tooltip = GTFOLocal.UI_TrivialDescription.."\n\n"..GTFOLocal.UI_TrivialDescription2;
	getglobal(TrivialButton:GetName().."Text"):SetText(GTFOLocal.UI_Trivial);
	TrivialButton.optionKey = "Trivial";
	TrivialButton:SetScript("OnClick", GTFO.ToggleCheckboxOption);

	local TrivialDamageText = ConfigurationPanel:CreateFontString("GTFO_TrivialDamageText","ARTWORK","GameFontNormal");
	TrivialDamageText:SetPoint("TOPLEFT", 450, -270);
	TrivialDamageText:SetText("");

	local TrivialDamageSlider = CreateFrame("Slider", "GTFO_TrivialDamageSlider", ConfigurationPanel, "OptionsSliderTemplate");
	TrivialDamageSlider:SetPoint("TOPLEFT", 300, -270);
	TrivialDamageSlider.tooltip = GTFOLocal.UI_TrivialSlider;
	TrivialDamageSlider:SetScript("OnValueChanged",GTFO_Option_SetTrivialDamage);
	if (getglobal(GTFO_TrivialDamageSlider:GetName().."Text")) then
		getglobal(GTFO_TrivialDamageSlider:GetName().."Text"):SetText(GTFOLocal.UI_TrivialSlider);
		getglobal(GTFO_TrivialDamageSlider:GetName().."High"):SetText(" ");
		getglobal(GTFO_TrivialDamageSlider:GetName().."Low"):SetText(" ");
	end
	TrivialDamageSlider:SetMinMaxValues(.5,10);
	TrivialDamageSlider:SetValueStep(.5);
	TrivialDamageSlider:SetValue(GTFO.Settings.TrivialDamagePercent);
	GTFO_Option_SetTrivialDamageText(GTFO.Settings.TrivialDamagePercent);

	local TestModeButton = CreateFrame("CheckButton", "GTFO_TestModeButton", ConfigurationPanel, "ChatConfigCheckButtonTemplate");
	TestModeButton:SetPoint("TOPLEFT", 10, -300)
	TestModeButton.tooltip = GTFOLocal.UI_TestModeDescription.."\n\n"..string.format(GTFOLocal.UI_TestModeDescription2,"zensunim","gmail","com");
	getglobal(TestModeButton:GetName().."Text"):SetText(GTFOLocal.UI_TestMode);
	TestModeButton.optionKey = "TestMode";
	TestModeButton:SetScript("OnClick", GTFO.ToggleCheckboxOption);

	local ChannelText = ConfigurationPanel:CreateFontString("GTFO_ChannelText","ARTWORK","GameFontNormal");
	ChannelText:SetPoint("TOPLEFT", 170, -350);
	ChannelText:SetText("");

	local ChannelIdSlider = CreateFrame("Slider", "GTFO_ChannelIdSlider", ConfigurationPanel, "OptionsSliderTemplate");
	ChannelIdSlider:SetPoint("TOPLEFT", 12, -350);
	ChannelIdSlider:SetScript("OnValueChanged",GTFO_Option_SetChannel);
	ChannelIdSlider:SetMinMaxValues(1,5);
	ChannelIdSlider:SetValueStep(1);
	ChannelIdSlider:SetValue(GTFO_GetCurrentSoundChannelId(GTFO.Settings.SoundChannel));
	if (getglobal(GTFO_ChannelIdSlider:GetName().."Text")) then
		getglobal(GTFO_ChannelIdSlider:GetName().."Text"):SetText(GTFOLocal.UI_SoundChannel);
		getglobal(GTFO_ChannelIdSlider:GetName().."High"):SetText(" ");
		getglobal(GTFO_ChannelIdSlider:GetName().."Low"):SetText(" ");
	end
	GTFO_Option_SetChannelIdText(GTFO_GetCurrentSoundChannelId(GTFO.Settings.SoundChannel));
	
	local VibrationButton = CreateFrame("CheckButton", "GTFO_VibrationButton", ConfigurationPanel, "ChatConfigCheckButtonTemplate");
	VibrationButton:SetPoint("TOPLEFT", 10, -380)
	VibrationButton.tooltip = GTFOLocal.UI_VibrationDescription;
	getglobal(VibrationButton:GetName().."Text"):SetText(GTFOLocal.UI_Vibration);
	VibrationButton.optionKey = "Vibration";
	VibrationButton:SetScript("OnClick", GTFO.ToggleCheckboxOption);

	local BrannModeText = ConfigurationPanel:CreateFontString("GTFO_BrannModeText","ARTWORK","GameFontNormal");
	BrannModeText:SetPoint("TOPLEFT", 170, -420);
	BrannModeText:SetText("");

	local BrannModeSlider = CreateFrame("Slider", "GTFO_BrannModeSlider", ConfigurationPanel, "OptionsSliderTemplate");
	BrannModeSlider:SetPoint("TOPLEFT", 12, -420);
	BrannModeSlider:SetScript("OnValueChanged",GTFO_Option_SetBrannMode);
	BrannModeSlider:SetMinMaxValues(0,2);
	BrannModeSlider:SetValueStep(1);
	BrannModeSlider:SetValue(GTFO.Settings.BrannMode or GTFO.DefaultSettings.BrannMode);
	BrannModeSlider.tooltip = GTFOLocal.UI_BrannModeDescription;
	BrannModeSlider:SetScript("OnEnter", function(self)
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
		GameTooltip:SetText(self.tooltip, nil, nil, nil, nil, true);
	end);
	BrannModeSlider:SetScript("OnLeave", function()
		GameTooltip:Hide();
	end);

	if (getglobal(GTFO_BrannModeSlider:GetName().."Text")) then
		getglobal(GTFO_BrannModeSlider:GetName().."Text"):SetText(GTFOLocal.UI_BrannMode);
		getglobal(GTFO_BrannModeSlider:GetName().."High"):SetText(" ");
		getglobal(GTFO_BrannModeSlider:GetName().."Low"):SetText(" ");
	end
	BrannModeText:SetText(GTFO_GetCurrentBrannMode(GTFO.Settings.BrannMode));

	local IgnoreTimeSlider = CreateFrame("Slider", "GTFO_IgnoreTimeSlider", ConfigurationPanel, "OptionsSliderTemplate");
	IgnoreTimeSlider:SetPoint("TOPLEFT", 12, -460);
	IgnoreTimeSlider:SetScript("OnValueChanged",GTFO_Option_SetIgnoreTime);
	IgnoreTimeSlider:SetMinMaxValues(0,5);
	IgnoreTimeSlider:SetValueStep(0.1);
	IgnoreTimeSlider:SetValue(GTFO.Settings.IgnoreTimeAmount or GTFO.DefaultSettings.IgnoreTimeAmount);
	IgnoreTimeSlider.tooltip = GTFOLocal.UI_IgnoreTimeDescription;
	IgnoreTimeSlider:SetScript("OnEnter", function(self)
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
		GameTooltip:SetText(self.tooltip, nil, nil, nil, nil, true);
	end);
	IgnoreTimeSlider:SetScript("OnLeave", function()
		GameTooltip:Hide();
	end);
	
	if (getglobal(GTFO_IgnoreTimeSlider:GetName().."Text")) then
		getglobal(GTFO_IgnoreTimeSlider:GetName().."Text"):SetText(GTFOLocal.UI_IgnoreTime);
		getglobal(GTFO_IgnoreTimeSlider:GetName().."High"):SetText(" ");
		getglobal(GTFO_IgnoreTimeSlider:GetName().."Low"):SetText(" ");
	end

	local AFKAlertButton = CreateFrame("CheckButton", "GTFO_AFKAlertButton", ConfigurationPanel, "ChatConfigCheckButtonTemplate");
	AFKAlertButton:SetPoint("TOPLEFT", 10, -490)
	AFKAlertButton.tooltip = GTFOLocal.UI_AFKAlertDescription_Retail;
	getglobal(AFKAlertButton:GetName().."Text"):SetText(GTFOLocal.UI_AFKAlert_Retail);
	AFKAlertButton.optionKey = "AFKAlert";
	AFKAlertButton:SetScript("OnClick", GTFO.ToggleCheckboxOption);

	local RestrictionsBox = CreateFrame("Frame", "GTFO_BrokenExplanationBox", ConfigurationPanel, "BackdropTemplate");
	RestrictionsBox:SetPoint("TOPRIGHT", -12, -12);
	RestrictionsBox:SetSize(310, 50);

	RestrictionsBox:SetBackdrop({
		bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
		tile = true,
		tileSize = 16,
		edgeSize = 16,
		insets = { left = 4, right = 4, top = 4, bottom = 4 },
	});
	RestrictionsBox:SetBackdropColor(0, 0, 0, 0.65);

	local icon = RestrictionsBox:CreateTexture(nil, "ARTWORK");
	icon:ClearAllPoints();
	icon:SetPoint("TOPLEFT", RestrictionsBox, "TOPLEFT", 12, -10);
	icon:SetSize(14, 14);
	icon:SetAtlas("communities-icon-lock", true);

	local title = RestrictionsBox:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
	title:ClearAllPoints();
	title:SetPoint("TOPLEFT", icon, "TOPRIGHT", 6, -8);
	title:SetText(GTFOLocal.UI_BrokenExplanation_Header);
	title:SetTextColor(1, 0.82, 0);

	local body = RestrictionsBox:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall");
	body:ClearAllPoints();
	body:SetPoint("TOPLEFT", icon, "BOTTOMLEFT", 0, -8);
	body:SetWidth(RestrictionsBox:GetWidth() - 24);
	body:SetJustifyH("LEFT");
	body:SetJustifyV("TOP");
	body:SetTextColor(0.9, 0.9, 0.9);
	body:SetText(GTFOLocal.UI_BrokenExplanation_Text);
	
	RestrictionsBox:SetScript("OnShow", function()
		local topPad = 10;
		local bottomPad = 12;
		local headerH = math.max(icon:GetHeight(), title:GetStringHeight());
		local bodyH = body:GetStringHeight();

		local neededH = topPad + headerH + 8 + bodyH + bottomPad;
		if (neededH < 80) then
			neededH = 80;
		end
		RestrictionsBox:SetHeight(neededH);
	end);

	-- Special Alerts frame
	local IgnoreOptionsPanel = CreateFrame("FRAME","GTFO_IgnoreOptionsFrame");
	IgnoreOptionsPanel.name = GTFOLocal.UI_SpecialAlerts;
	IgnoreOptionsPanel.parent = ConfigurationPanel.name;
	local subcategory, layout = Settings.RegisterCanvasLayoutSubcategory(category, IgnoreOptionsPanel, IgnoreOptionsPanel.name);
	Settings.RegisterAddOnCategory(subcategory);
	GTFO.SettingsSpecialAlertsCategoryId = subcategory:GetID();

	local IntroMessageHeader2 = IgnoreOptionsPanel:CreateFontString(nil, "ARTWORK","GameFontNormalLarge");
	IntroMessageHeader2:SetPoint("TOPLEFT", 10, -10);
	IntroMessageHeader2:SetText("GTFO "..GTFO.Version.." - "..GTFOLocal.UI_SpecialAlertsHeader);

	local yCount = -20;
	for key, option in pairs(GTFO.IgnoreSpellCategory) do
		if (GTFO.IgnoreSpellCategory[key].spellID) then
			yCount = yCount - 30;

			local IgnoreAlertButton = CreateFrame("CheckButton", "GTFO_IgnoreAlertButton_"..key, IgnoreOptionsPanel, "ChatConfigCheckButtonTemplate");
			IgnoreAlertButton:SetPoint("TOPLEFT", 10, yCount)
			getglobal(IgnoreAlertButton:GetName().."Text"):SetText(GTFO.IgnoreSpellCategory[key].desc);
			if (GTFO.IgnoreSpellCategory[key].tooltip) then
				_G["GTFO_IgnoreAlertButton_"..key].tooltip = GTFO.IgnoreSpellCategory[key].tooltip;
			end
			IgnoreAlertButton.optionKey = "Ignore"..key;
			IgnoreAlertButton:SetScript("OnClick", GTFO.ToggleCheckboxOption);
			
			if (GTFO.IgnoreSpellCategory[key].disabled) then
				GTFO.DisableBrokenCheckButton(IgnoreAlertButton, GTFOLocal.UI_BrokenReason);
			end
		end
	end

	GTFOSpellTooltip:ClearLines();

	if (AddonCompartmentFrame) then
		AddonCompartmentFrame:RegisterAddon({
			text = "GTFO",
			icon = "Interface\\Icons\\spell_fire_fire.blp",
			notCheckable = true,
			func = function(button, menuInputData, menu)
				Settings.OpenToCategory(GTFO.SettingsCategoryId);
			end,
			funcOnEnter = function(button)
				MenuUtil.ShowTooltip(button, function(tooltip)
					tooltip:SetText("GTFO "..GTFO.Version);
					tooltip:AddLine("|cFFFFFFFF"..GTFOLocal.Help_Options.."|r");
				end)
			end,
			funcOnLeave = function(button)
				MenuUtil.HideTooltip(button)
			end,
		});
	end
	
	GTFO.DisableBrokenCheckButton(GTFO_FriendlyFireSoundButton, GTFOLocal.UI_BrokenReason);
	GTFO.DisableBrokenCheckButton(GTFO_UnmuteButton, GTFOLocal.UI_BrokenReason);
	GTFO.DisableBrokenCheckButton(GTFO_TrivialButton, GTFOLocal.UI_BrokenReason);
	GTFO.DisableBrokenCheckButton(GTFO_VibrationButton, GTFOLocal.UI_BrokenReason);

	GTFO.DisableBrokenTestButton(GTFO_FriendlyFireTestButton);
	
	GTFO.DisableBrokenSlider(GTFO_TrivialDamageSlider, GTFOLocal.UI_BrokenReason);
	GTFO.DisableBrokenSlider(GTFO_IgnoreTimeSlider, GTFOLocal.UI_BrokenReason);

	GTFO.UIRendered = true;
end

function GTFO.ToggleCheckboxOption(self)
	local checked = self:GetChecked();
	local optionKey = self.optionKey;

	if (optionKey == "Enabled") then
		GTFO.Settings.Active = checked;
	elseif (optionKey == "HighSound") then
		GTFO.Settings.Sounds[1] = checked;
	elseif (optionKey == "LowSound") then
		GTFO.Settings.Sounds[2] = checked;
	elseif (optionKey == "FailSound") then
		GTFO.Settings.Sounds[3] = checked;
	elseif (optionKey == "FriendlyFireSound") then
		GTFO.Settings.Sounds[4] = checked;
	elseif (optionKey == "TestMode") then
		GTFO.Settings.TestMode = checked;
	elseif (optionKey == "Unmute") then
		GTFO.Settings.UnmuteMode = checked;
	elseif (optionKey == "Trivial") then
		GTFO.Settings.TrivialMode = checked;
	elseif (optionKey == "Vibration") then
		GTFO.Settings.EnableVibration = checked;
	elseif (optionKey == "AFKAlert") then
		GTFO.Settings.AFKAlertMode = checked;
	end
	
	for key, option in pairs(GTFO.IgnoreSpellCategory) do
		if (optionKey == "Ignore"..key) then
			GTFO.Settings.IgnoreOptions[key] = not checked;
		end
	end
	
	GTFO_SaveSettings();
end

function GTFO_ActivateMod()
	if (GTFO.CurrentEncounterId) then
		GTFO.UnregisterEncounter();
		if (GTFO.Settings.Active) then
			GTFO.RegisterEncounter(GTFO.CurrentEncounterId);
		end	
	end
	
	GTFO.UnregisterInstance();
	if (GTFO.Settings.Active) then
		GTFO.RegisterInstance()
	end	

	if (GTFO.Settings.Active and GTFO.Settings.AFKAlertMode) then
		GTFOFrame:RegisterEvent("PLAYER_FLAGS_CHANGED");
		GTFOFrame:RegisterEvent("PLAYER_REGEN_DISABLED");
		GTFOFrame:RegisterEvent("PLAYER_STARTED_MOVING");
		GTFO.UpdateAFKStatus();
	else
		GTFOFrame:UnregisterEvent("PLAYER_FLAGS_CHANGED");
		GTFOFrame:UnregisterEvent("PLAYER_REGEN_DISABLED");
		GTFOFrame:UnregisterEvent("PLAYER_STARTED_MOVING");
	end
end

function GTFO_Command_Help()
	DEFAULT_CHAT_FRAME:AddMessage("[GTFO] "..string.format(GTFOLocal.Help_Intro, GTFO.Version), 0.25, 1.0, 0.25);
	if not (GTFO.Settings.Active) then
		DEFAULT_CHAT_FRAME:AddMessage(GTFOLocal.Help_Suspended, 1.0, 0.1, 0.1);		
	end
	DEFAULT_CHAT_FRAME:AddMessage("|cFFEEEE00/gtfo options|r -- "..GTFOLocal.Help_Options, 0.25, 1.0, 0.75);
	DEFAULT_CHAT_FRAME:AddMessage("|cFFEEEE00/gtfo standby|r -- "..GTFOLocal.Help_Suspend, 0.25, 1.0, 0.75);
	DEFAULT_CHAT_FRAME:AddMessage("|cFFEEEE00/gtfo version|r -- "..GTFOLocal.Help_Version, 0.25, 1.0, 0.75);
	DEFAULT_CHAT_FRAME:AddMessage("|cFFEEEE00/gtfo test|r -- "..GTFOLocal.Help_TestHigh, 0.25, 1.0, 0.75);
	DEFAULT_CHAT_FRAME:AddMessage("|cFFEEEE00/gtfo ignore|r -- "..GTFOLocal.Help_IgnoreSpell, 0.25, 1.0, 0.75);
end


-- Save settings to persistant storage, refresh UI options
function GTFO_SaveSettings()
	--GTFO_DebugPrint("Saving settings");
	GTFOData.DataCode = GTFO.DataCode;
	GTFOData.Active = GTFO.Settings.Active;
	GTFOData.Sounds = { };
	GTFOData.Sounds[1] = GTFO.Settings.Sounds[1];
	GTFOData.Sounds[2] = GTFO.Settings.Sounds[2];
	GTFOData.Sounds[3] = GTFO.Settings.Sounds[3];
	GTFOData.Sounds[4] = GTFO.Settings.Sounds[4];
	GTFOData.Volume = GTFO.Settings.Volume;
	GTFOData.ScanMode = GTFO.Settings.ScanMode;
	GTFOData.AlertMode = GTFO.Settings.AlertMode;
	GTFOData.DebugMode = GTFO.Settings.DebugMode;
	GTFOData.TestMode = GTFO.Settings.TestMode;
	GTFOData.UnmuteMode = GTFO.Settings.UnmuteMode;
	GTFOData.TrivialMode = GTFO.Settings.TrivialMode;
	GTFOData.TrivialDamagePercent = GTFO.Settings.TrivialDamagePercent;
	GTFOData.NoVersionReminder = GTFO.Settings.NoVersionReminder;
	GTFOData.EnableVibration = GTFO.Settings.EnableVibration;
	GTFOData.SoundChannel = GTFO.Settings.SoundChannel;
	GTFOData.BrannMode = GTFO.Settings.BrannMode;
	GTFOData.IgnoreTimeAmount = GTFO.Settings.IgnoreTimeAmount;
	GTFOData.AFKAlertMode = GTFO.Settings.AFKAlertMode;
	GTFOData.IgnoreOptions = { };
	if (GTFO.Settings.IgnoreOptions) then
		for key, option in pairs(GTFO.Settings.IgnoreOptions) do
			GTFOData.IgnoreOptions[key] = GTFO.Settings.IgnoreOptions[key];
		end
	end
	GTFOData.SoundOverrides = { "", "", "", "" };
	GTFOData.IgnoreSpellList = { };
	
	if (not GTFO.ClassicMode and #GTFO.Settings.IgnoreSpellList > 0) then
		for i, spellId in pairs(GTFO.Settings.IgnoreSpellList) do
			GTFO.AddUnique(GTFOData.IgnoreSpellList, spellId);
		end
	end
	
	if (GTFO.UIRendered) then
		getglobal("GTFO_HighResetButton"):Hide();
		getglobal("GTFO_LowResetButton"):Hide();
		getglobal("GTFO_FailResetButton"):Hide();
		getglobal("GTFO_FriendlyFireResetButton"):Hide();
	end

	if (GTFO.Settings.SoundOverrides) then
		for key, option in pairs(GTFO.Settings.SoundOverrides) do
			GTFOData.SoundOverrides[key] = GTFO.Settings.SoundOverrides[key] or "";
			if (GTFOData.SoundOverrides[key] ~= "") then
				if (key == 1) then
					getglobal("GTFO_HighResetButton"):Show();
				end
				if (key == 2) then
					getglobal("GTFO_LowResetButton"):Show();
				end
				if (key == 3) then
					getglobal("GTFO_FailResetButton"):Show();
				end
				if (key == 4) then
					getglobal("GTFO_FriendlyFireResetButton"):Show();
				end
			end			
		end
	end
	
	if (not GTFO.ClassicMode and #GTFO.Settings.IgnoreSpellList > 0) then
		for i, spellId in pairs(GTFO.Settings.IgnoreSpellList) do
			GTFO.AddUnique(GTFOData.IgnoreSpellList, spellId);
		end
	end
	
	if (GTFO.UIRendered) then
		getglobal("GTFO_EnabledButton"):SetChecked(GTFO.Settings.Active);
		getglobal("GTFO_HighSoundButton"):SetChecked(GTFO.Settings.Sounds[1]);
		getglobal("GTFO_LowSoundButton"):SetChecked(GTFO.Settings.Sounds[2]);
		getglobal("GTFO_FailSoundButton"):SetChecked(GTFO.Settings.Sounds[3]);
		getglobal("GTFO_FriendlyFireSoundButton"):SetChecked(GTFO.Settings.Sounds[4]);
		getglobal("GTFO_TestModeButton"):SetChecked(GTFO.Settings.TestMode);
		getglobal("GTFO_UnmuteButton"):SetChecked(GTFO.Settings.UnmuteMode);
		getglobal("GTFO_TrivialButton"):SetChecked(GTFO.Settings.TrivialMode);
		getglobal("GTFO_VibrationButton"):SetChecked(GTFO.Settings.EnableVibration);
		getglobal("GTFO_AFKAlertButton"):SetChecked(GTFO.Settings.AFKAlertMode);

		for key, option in pairs(GTFO.IgnoreSpellCategory) do
			getglobal("GTFO_IgnoreAlertButton_"..key):SetChecked(not GTFO.Settings.IgnoreOptions[key]);
		end
	end
	
	GTFO_ActivateMod();
end

-- Reset all settings to default
function GTFO_SetDefaults()
	GTFO.Settings.Active = GTFO.DefaultSettings.Active;
	GTFO.Settings.Sounds = { };
	GTFO.Settings.Sounds[1] = GTFO.DefaultSettings.Sounds[1];
	GTFO.Settings.Sounds[2] = GTFO.DefaultSettings.Sounds[2];
	GTFO.Settings.Sounds[3] = GTFO.DefaultSettings.Sounds[3];
	GTFO.Settings.Sounds[4] = GTFO.DefaultSettings.Sounds[4];
	GTFO.Settings.Volume = GTFO.DefaultSettings.Volume;
	GTFO.Settings.ScanMode = GTFO.DefaultSettings.ScanMode;
	GTFO.Settings.AlertMode = GTFO.DefaultSettings.AlertMode;
	GTFO.Settings.DebugMode = GTFO.DefaultSettings.DebugMode;
	GTFO.Settings.TestMode = GTFO.DefaultSettings.TestMode;
	GTFO.Settings.UnmuteMode = GTFO.DefaultSettings.UnmuteMode;
	GTFO.Settings.TrivialMode = GTFO.DefaultSettings.TrivialMode;
	GTFO.Settings.NoVersionReminder = GTFO.DefaultSettings.NoVersionReminder;
	GTFO.Settings.EnableVibration = GTFO.DefaultSettings.EnableVibration;
	GTFO.Settings.TrivialDamagePercent = GTFO.DefaultSettings.TrivialDamagePercent;
	GTFO.Settings.SoundChannel = GTFO.DefaultSettings.SoundChannel;
	if (GTFO.UIRendered) then
		getglobal("GTFO_VolumeSlider"):SetValue(GTFO.DefaultSettings.Volume);
		getglobal("GTFO_TrivialDamageSlider"):SetValue(GTFO.DefaultSettings.TrivialDamagePercent);
		getglobal("GTFO_ChannelIdSlider"):SetValue(GTFO_GetCurrentSoundChannelId(GTFO.DefaultSettings.SoundChannel));
		getglobal("GTFO_BrannModeSlider"):SetValue(GTFO_GetCurrentBrannMode(GTFO.DefaultSettings.BrannMode));
		getglobal("GTFO_IgnoreTimeSlider"):SetValue(GTFO.DefaultSettings.IgnoreTimeAmount);
	end
	GTFO.Settings.IgnoreOptions = GTFO.DefaultSettings.IgnoreOptions;
	GTFO.Settings.SoundOverrides = GTFO.DefaultSettings.SoundOverrides;
	GTFO.Settings.IgnoreSpellList = GTFO.DefaultSettings.IgnoreSpellList;
	GTFO.Settings.BrannMode = GTFO.DefaultSettings.BrannMode;
	GTFO.Settings.IgnoreTimeAmount = GTFO.DefaultSettings.IgnoreTimeAmount;
	GTFO.Settings.AFKAlertMode = GTFO.DefaultSettings.AFKAlertMode;
	GTFO_SaveSettings();
end

function GTFO_GetAlertID(alert)
	if (alert.soundFunctionRetail) then
		return alert:soundFunctionRetail();
	end	

	local alertLevel;
	local tankAlert = nil;

	if (alert.tankSound or alert.tankSoundLFR or alert.tankSoundChallenge or alert.tankSoundMythic or alert.tankSoundHeroic) then
		-- TankSound alert present, check for tanking mode
		if (GTFO.TankMode or (GTFO.RaidMembers == 0 and GTFO.PartyMembers == 0)) then
			-- Tank or soloing
			tankAlert = true;
		elseif (not GTFO.RetailMode and GTFO_IsTank()) then
			tankAlert = true;
		end
	end
	
	if (tankAlert and alert.tankSound) then
		alertLevel = alert.tankSound;
	else
		alertLevel = alert.sound or 0;
	end
	
	if ((alert.soundLFR or (tankAlert and alert.tankSoundLFR)) and GTFO_IsInLFR()) then
		if (tankAlert and alert.tankSoundLFR) then
			alertLevel = alert.tankSoundLFR;
		elseif (alert.soundLFR) then
			alertLevel = alert.soundLFR;
		end
	elseif (alert.soundHeroic or alert.soundMythic or alert.soundChallenge or (tankAlert and (alert.tankSoundHeroic or alert.tankSoundMythic or alert.tankSoundChallenge))) then
		local isHeroic, isChallenge, isHeroicRaid, isMythic = select(3, GetDifficultyInfo(select(3, GetInstanceInfo())));
		if (isChallenge == true) then
			-- Mythic+/Challenge Mode
			local useAlert = true;
			if (alert.soundChallengeMinimumLevel) then
				local currentKey, _ = C_ChallengeMode.GetActiveKeystoneInfo()
				useAlert = alert.soundChallengeMinimumLevel >= tonumber(currentKey);
			end
			if (useAlert) then
				if (tankAlert and (alert.tankSoundChallenge or alert.tankSoundMythic or alert.tankSoundHeroic)) then
					alertLevel = alert.tankSoundChallenge or alert.tankSoundMythic or alert.tankSoundHeroic;
				elseif (alert.soundChallenge or alert.soundMythic or alert.soundHeroic) then
					alertLevel = alert.soundChallenge or alert.soundMythic or alert.soundHeroic;
				end
			end
		elseif (isMythic == true) then
			-- Mythic Mode
			if (tankAlert and (alert.tankSoundMythic or alert.tankSoundHeroic)) then
				alertLevel = alert.tankSoundMythic or alert.tankSoundHeroic;
			elseif (alert.soundMythic or alert.soundHeroic) then
				alertLevel = alert.soundMythic or alert.soundHeroic;
			end
		elseif (isHeroic == true or isHeroicRaid == true) then
			-- Heroic Mode
			if (tankAlert and alert.tankSoundHeroic) then
				alertLevel = alert.tankSoundHeroic;
			elseif (alert.soundHeroic) then
				alertLevel = alert.soundHeroic;
			end
		end
	end
	
	return alertLevel;
end

function GTFO_DisplayAura(alertTypeID)
   -- No visual displays available for now
end

function GTFO.DisableBrokenCheckButton(checkButton, reason)
	checkButton:SetChecked(false);
	checkButton:Disable();
	checkButton:SetScript("OnClick", nil);

	local label = _G[checkButton:GetName().."Text"];
	if (label) then
		label:SetTextColor(0.5, 0.5, 0.5);
	end

	if (reason) then
		checkButton.tooltip = (checkButton.tooltip or "").."\n\n|cffff2020"..reason.."|r";
	end
	
	if (not checkButton.GTFO_LockTexture) then
		local lock = checkButton:CreateTexture(nil, "OVERLAY");
		lock:SetPoint("CENTER", checkButton, "CENTER", 0, 0);
		lock:SetSize(14, 14);
		lock:SetAlpha(0.9);

		if (C_Texture and C_Texture.GetAtlasInfo and C_Texture.GetAtlasInfo("communities-icon-lock")) then
			lock:SetAtlas("communities-icon-lock", true);
		else
			lock:SetTexture("Interface\\Common\\UI-LockIcon");
		end

		checkButton.GTFO_LockTexture = lock;
	end

	checkButton.GTFO_LockTexture:Show();
end

function GTFO.DisableBrokenTestButton(button)
	button:Disable();
	button:SetScript("OnClick", nil);

	local t = _G[button:GetName().."Text"];
	if (t) then
		t:SetTextColor(0.5, 0.5, 0.5);
	end
end

function GTFO.DisableBrokenSlider(slider, reason)
	slider:Disable();
	slider:SetEnabled(false);
	slider:EnableMouse(false);

	if (reason) then
		slider.tooltip = (slider.tooltip or "").."\n\n|cffff2020"..reason.."|r";
	end

	local name = slider:GetName();
	local text = _G[name.."Text"];
	local high = _G[name.."High"];
	local low = _G[name.."Low"];

	if (text) then
		text:SetTextColor(0.5, 0.5, 0.5);
	end
	if (high) then
		high:SetTextColor(0.5, 0.5, 0.5);
	end
	if (low) then
		low:SetTextColor(0.5, 0.5, 0.5);
	end
end

-- Dev-only scan to help identify private auras
function GTFO.PrivateAuraScan()
	if (not GTFO.Settings.ScanMode) then
		GTFO_ErrorPrint("Scan mode was not enabled. Turn it on and reload UI before trying again.");
		return;
	end

	if (not C_UnitAuras or not C_UnitAuras.AuraIsPrivate) then
		GTFO_ErrorPrint("C_UnitAuras.AuraIsPrivate not available.");
		return;
	end

	-- Updated for 12.0.5
	local BlizzardPrivateAuraSpellIDs = { 153757, 153954, 154132, 154150, 244588, 244599, 245742, 246026, 248831, 291937, 319703, 323001, 324044, 337929, 344874, 345770, 345990, 346297, 346329, 346828, 346844, 346961, 346962, 347094, 347481, 348366, 348567, 349627, 349954, 349999, 350010, 350101, 350804, 350860, 350885, 350922, 351101, 351119, 352345, 353421, 353835, 355360, 355439, 356796, 358131, 358947, 369133, 369134, 376449, 376760,
376997, 377009, 386201, 388544, 389007, 389011, 389033, 391977, 396716, 406317, 407182, 410317, 410326, 410966, 414187, 417938, 418589, 419060, 420544, 420545, 421105, 421106, 421250, 421461, 421825, 421826, 421827, 421828, 421829, 422520, 423015, 423051, 423080, 423601, 424414, 424426, 424431, 424621, 425468, 425469, 425525, 425544, 425556, 425596, 425888, 425962, 425963, 425964, 426010, 426161,
426370, 426735, 426736, 426865, 427007, 427378, 427379, 427722, 428170, 428901, 428970, 428988, 429123, 430048, 432031, 432119, 432132, 432958, 432961, 433517, 433740, 434090, 434096, 434113, 434406, 434441, 434576, 434579, 434655, 434668, 434670, 434830, 435088, 435466, 435534, 435793, 436614, 436663, 436664, 436665, 436666, 436671, 436677, 436870, 438141, 438957, 439070, 439191, 439200, 439783,
439790, 439815, 441952, 442210, 446403, 446649, 446657, 447439, 447443, 448215, 448515, 448888, 449981, 450855, 450969, 451606, 451704, 453173, 453212, 453214, 453278, 454721, 459669, 460163, 460165, 460965, 461487, 461507, 461994, 463273, 463276, 463428, 463754, 465325, 465970, 465982, 466124, 466155, 466188, 466344, 467120, 467620, 468486, 468573, 468616, 468647, 468723, 468741, 468811, 468815,
470022, 470038, 470041, 470503, 470966, 472121, 472129, 472131, 472132, 472134, 472135, 472136, 472137, 472138, 472139, 472140, 472141, 472142, 472143, 472144, 472145, 472354, 472662, 472793, 472819, 472878, 473051, 473070, 473224, 473287, 473354, 473508, 473713, 473836, 474129, 474545, 474719, 474732, 474733, 474734, 474735, 1214749, 1214750, 1214757, 1214758, 1214759, 1214760, 1214761, 1214762, 1214763,
1214764, 1214765, 1214766, 1214767, 1215157, 1215804, 1215805, 1215808, 1215811, 1215812, 1216913, 1217241, 1217439, 1217446, 1217649, 1217792, 1217795, 1217997, 1218148, 1218203, 1218550, 1218591, 1218625, 1218669, 1219032, 1219033, 1219248, 1219279, 1219354, 1219439, 1219459, 1219531, 1219535, 1219607, 1219649, 1220390, 1220427, 1220610, 1220618, 1220671, 1220674, 1220679, 1220727, 1220981, 1220982, 1221490, 1222098, 1222232, 1222307, 1222310,
1222758, 1222970, 1223005, 1223042, 1223160, 1223177, 1223202, 1223364, 1223392, 1223483, 1223484, 1223485, 1223486, 1223489, 1223493, 1223533, 1223624, 1223725, 1223859, 1224117, 1224337, 1224414, 1224737, 1224795, 1224816, 1224828, 1224855, 1224857, 1224858, 1224859, 1224860, 1224861, 1224862, 1224864, 1224865, 1225011, 1225055, 1225056, 1225057, 1225058, 1225059, 1225060, 1225107, 1225130, 1225179, 1225203, 1225208, 1225221, 1225227, 1225303,
1225311, 1225316, 1225317, 1225318, 1225327, 1225444, 1225616, 1225626, 1225629, 1225673, 1225787, 1225792, 1226018, 1226311, 1226331, 1226362, 1226366, 1226395, 1226413, 1226444, 1226489, 1226493, 1226601, 1226602, 1226721, 1226827, 1226831, 1227049, 1227051, 1227052, 1227142, 1227152, 1227163, 1227276, 1227277, 1227373, 1227376, 1227378, 1227413, 1227470, 1227549, 1227557, 1227582, 1227604, 1227607, 1227639, 1227683, 1227748, 1227766, 1227767,
1227784, 1227847, 1228081, 1228114, 1228116, 1228169, 1228188, 1228196, 1228206, 1228214, 1228215, 1228219, 1228453, 1228458, 1228506, 1229325, 1230168, 1230910, 1231002, 1231086, 1231097, 1231408, 1231803, 1231871, 1232115, 1232268, 1232394, 1232412, 1232470, 1232539, 1232543, 1232704, 1232760, 1232774, 1232775, 1232782, 1232792, 1233074, 1233076, 1233105, 1233110, 1233372, 1233381, 1233411, 1233418, 1233446, 1233449, 1233454, 1233499, 1233602,
1233620, 1233657, 1233667, 1233669, 1233671, 1233673, 1233675, 1233676, 1233780, 1233796, 1233801, 1233802, 1233804, 1233865, 1233887, 1233891, 1233893, 1233968, 1233979, 1233999, 1234054, 1234119, 1234243, 1234244, 1234251, 1234266, 1234324, 1234529, 1234539, 1234570, 1235045, 1235151, 1235178, 1235510, 1235545, 1235747, 1235816, 1236126, 1236207, 1236513, 1236747, 1237038, 1237084, 1237097, 1237108, 1237167, 1237193, 1237212, 1237307, 1237325,
1237345, 1237607, 1237623, 1237696, 1237847, 1238206, 1238708, 1238773, 1238782, 1238874, 1239111, 1239270, 1239582, 1240005, 1240097, 1240222, 1240356, 1240362, 1240437, 1240562, 1240705, 1241090, 1241100, 1241137, 1241228, 1241292, 1241303, 1241316, 1241339, 1241357, 1241540, 1241840, 1241841, 1241844, 1241917, 1241946, 1241992, 1242071, 1242086, 1242088, 1242091, 1242157, 1242284, 1242304, 1242553, 1242803, 1242815, 1242883, 1243016, 1243220,
1243270, 1243577, 1243599, 1243641, 1243699, 1243721, 1243753, 1243771, 1243873, 1243901, 1243981, 1244165, 1244171, 1244348, 1244367, 1244523, 1244672, 1245059, 1245175, 1245384, 1245421, 1245554, 1245586, 1245592, 1245669, 1245688, 1245698, 1245752, 1245960, 1246145, 1246158, 1246462, 1246487, 1246489, 1246502, 1246509, 1246542, 1246653, 1246718, 1246736, 1246806, 1247045, 1247381, 1247415, 1247424, 1247585, 1248128, 1248171, 1248211, 1248464,
1248652, 1248697, 1248709, 1248721, 1248865, 1248979, 1248985, 1248994, 1249008, 1249020, 1249024, 1249065, 1249122, 1249123, 1249130, 1249139, 1249211, 1249265, 1249309, 1249425, 1249456, 1249478, 1249550, 1249558, 1249562, 1249565, 1249566, 1249584, 1249595, 1249609, 1249615, 1249716, 1250055, 1250185, 1250600, 1250671, 1250686, 1250828, 1250953, 1250991, 1251213, 1251772, 1251775, 1251785, 1251789, 1251840, 1251857, 1252001, 1252157, 1252214,
1252675, 1252733, 1252828, 1253024, 1253031, 1253036, 1253104, 1253418, 1253511, 1253520, 1253541, 1253543, 1253708, 1253709, 1253744, 1253770, 1253907, 1253979, 1254077, 1254113, 1254385, 1254635, 1255450, 1255453, 1255568, 1255573, 1255575, 1255612, 1255680, 1255697, 1255700, 1255763, 1255886, 1255890, 1255892, 1255908, 1255909, 1255910, 1255915, 1255979, 1256017, 1256040, 1256045, 1256167, 1256174, 1256180, 1256260, 1256337, 1256346, 1256350,
1256358, 1256359, 1256366, 1256388, 1256526, 1257087, 1257210, 1257211, 1257213, 1257310, 1257329, 1257610, 1257612, 1257741, 1257836, 1257869, 1257908, 1258147, 1258162, 1258176, 1258192, 1258514, 1259186, 1259287, 1259295, 1259413, 1259861, 1260027, 1260030, 1260203, 1260580, 1260643, 1260981, 1261276, 1261286, 1261301, 1261540, 1261799, 1261966, 1262020, 1262055, 1262596, 1262656, 1262676, 1262754, 1262772, 1262864, 1262972, 1262983, 1262999,
1263514, 1263523, 1263532, 1263542, 1263716, 1263766, 1263788, 1264246, 1264299, 1264453, 1264467, 1264595, 1264756, 1264757, 1264780, 1265152, 1265398, 1265426, 1265427, 1265480, 1265540, 1265650, 1265842, 1265940, 1266113, 1266375, 1266404, 1266587, 1266621, 1266623, 1266627, 1266807, 1266946, 1267186, 1268733, 1268840, 1268992, 1269626, 1269631, 1270497, 1270852, 1271579, 1271679, 1272324, 1272431, 1272527, 1272726, 1272788, 1272792, 1272798,
1272799, 1272807, 1272811, 1272816, 1272833, 1272834, 1272841, 1273133, 1273397, 1275059, 1275429, 1275687, 1276487, 1276515, 1276523, 1276527, 1276531, 1276648, 1276747, 1276982, 1277041, 1277076, 1277188, 1277189, 1277703, 1278981, 1279002, 1279111, 1279512, 1279708, 1280023, 1280064, 1280075, 1280076, 1280088, 1280123, 1280355, 1280616, 1280889, 1280956, 1281184, 1281743, 1281839, 1282006, 1282016, 1282027, 1282035, 1282036, 1282039, 1282049,
1282255, 1282257, 1282261, 1282272, 1282470, 1282678, 1282724, 1282750, 1282768, 1282770, 1282776, 1282892, 1282911, 1282923, 1282955, 1282982, 1283000, 1283069, 1283236, 1283247, 1283506, 1283624, 1284301, 1284527, 1284531, 1284533, 1284699, 1284786, 1284958, 1284984, 1285208, 1285211, 1285466, 1285504, 1285510, 1286294, 1286406, 1287014, 1287674, 1287696, 1287740, 1287778, 1287779, 1287782, 1288932, 1289760, 1290372 };

	-- Local only, this function produces a report and should not persist results
	local privateSet = {};
	local badSet = {};

	local function AddToSet(setTable, spellID)
		setTable[spellID] = true;
	end

	local function SetToSortedList(setTable)
		local list = {};
		for spellID in pairs(setTable) do
			list[#list + 1] = spellID;
		end
		table.sort(list);
		return list;
	end


	local function PrintSpellLine(prefix, spellID)
		GTFO_ChatPrint(tostring(prefix or "")..tostring(GTFO.SpellTooltip(spellID) or "").." - "..tostring(GTFO_GetSpellName(spellID) or ""));
	end

	-- Scan GTFO tables:
	-- - If data has encounter/instance metadata, it is expected to already be curated, verify it's still private.
	-- - Otherwise, treat it as unclassified and discover private auras.
	local function ScanGTFOTable(tbl)
		if (not tbl) then
			return 0, 0, 0;
		end

		local scanned = 0;
		local found = 0;
		local bad = 0;

		for k, data in pairs(tbl) do
			local spellID = tonumber(k);
			if (spellID) then
				local isClassified = (data and (data.encounter ~= nil or data.instance ~= nil or data.instances ~= nil));
				if (isClassified) then
					if (not C_UnitAuras.AuraIsPrivate(spellID)) then
						bad = bad + 1;
						AddToSet(badSet, spellID);
					end
				else
					scanned = scanned + 1;
					if (C_UnitAuras.AuraIsPrivate(spellID)) then
						found = found + 1;
						AddToSet(privateSet, spellID);
					end
				end
			end
		end

		return scanned, found, bad;
	end

	local function ScanBlizzardListForMissing()
		local missing = {};
		local missingCount = 0;

		if (not BlizzardPrivateAuraSpellIDs) then
			return missing, 0;
		end

		for i = 1, #BlizzardPrivateAuraSpellIDs do
			local spellID = BlizzardPrivateAuraSpellIDs[i];
			if (spellID) then
				local spellKey = tostring(spellID);
				local handled = (GTFO.SpellID and GTFO.SpellID[spellKey]) or (GTFO.FFSpellID and GTFO.FFSpellID[spellKey]) or (GTFO.IgnoreScan and GTFO.IgnoreScan[spellKey]);
				if (not handled) then
					missingCount = missingCount + 1;
					missing[#missing + 1] = spellID;
				end
			end
		end

		table.sort(missing);
		return missing, missingCount;
	end

	local scanned1, found1, bad1 = ScanGTFOTable(GTFO.SpellID);
	local scanned2, found2, bad2 = ScanGTFOTable(GTFO.FFSpellID);

	local missingFromGTFO, missingCount = ScanBlizzardListForMissing();

	local privateList = SetToSortedList(privateSet);
	local badList = SetToSortedList(badSet);

	GTFO_ChatPrint(
		"GTFO.PrivateAuraScan: scanned " .. (scanned1 + scanned2) ..
		" entries, found " .. (found1 + found2) ..
		" private-aura spellIDs, found " .. (bad1 + bad2) ..
		" misclassified auras, found Blizzard list missing from GTFO: " .. missingCount .. "."
	);

	for i = 1, #privateList do
		PrintSpellLine("Found potential spells: ", privateList[i]);
	end

	for i = 1, #badList do
		PrintSpellLine("Bad spells: ", badList[i]);
	end

	for i = 1, #missingFromGTFO do
		local spellID = missingFromGTFO[i];
		GTFO_ChatPrint("GTFO.IgnoreScan[\""..tostring(spellID).."\"] = true; -- "..(GTFO_GetSpellName(spellID) or "Unknown"));
	end

	local list = {};
	for i = 1, #privateList do
		list[#list + 1] = privateList[i];
	end
	table.sort(list, function(a, b) return a < b; end);

	return list;
end


function GTFO.SpellTooltip(spellId, text, color)
	return "|c"..tostring(color or "ff71d5ff").."|Hspell:"..spellId.."|h["..(tostring(text or spellId)).."]|h|r";
end


function GTFO.BuildIndexes()
	-- Intended for spells with instance/encounter identifiers
	local counter = 0;
	local excluded = 0;
	GTFO.EncounterIndex = { };
	GTFO.InstanceIndex = { };
	for spellId, data in pairs(GTFO.SpellID) do
		if (data.encounter or data.instance or data.instances or data.encounters) then
			if (data.instances and #data.instances > 0) then
				for i, instanceId in pairs(data.instances) do
					if (not GTFO.InstanceIndex[instanceId]) then
						GTFO.InstanceIndex[instanceId] = { };
					end
					GTFO.AddUnique(GTFO.InstanceIndex[instanceId], spellId);
					counter = counter + 1;
				end
			elseif (data.instance) then
				local instanceId = tonumber(data.instance);
				if (not GTFO.InstanceIndex[instanceId]) then
					GTFO.InstanceIndex[instanceId] = { };
				end
				GTFO.AddUnique(GTFO.InstanceIndex[instanceId], spellId);
				counter = counter + 1;
			elseif (data.encounters and #data.encounters > 0) then
				for i, encounterId in pairs(data.encounters) do
					if (not GTFO.EncounterIndex[encounterId]) then
						GTFO.EncounterIndex[encounterId] = { };
					end
					GTFO.AddUnique(GTFO.EncounterIndex[encounterId], spellId);
					counter = counter + 1;
				end
			elseif (data.encounter) then
				local encounterId = tonumber(data.encounter);
				if (not GTFO.EncounterIndex[encounterId]) then
					GTFO.EncounterIndex[encounterId] = { };
				end
				GTFO.AddUnique(GTFO.EncounterIndex[encounterId], spellId);
				counter = counter + 1;
			end
		else
			if (not GTFO.Settings.ScanMode) then
				-- Scanner is not turned on, go ahead and remove spells that don't matter
				GTFO.SpellID[spellId] = nil;
			end
			excluded = excluded + 1;
		end
	end

	for _, i in pairs(GTFO.EncounterIndex) do
		table.sort(i);
	end
	for _, i in pairs(GTFO.InstanceIndex) do
		table.sort(i);
	end
	GTFO_DebugPrint("Total spells indexed: "..counter);
	GTFO_DebugPrint("Total spells excluded: "..excluded);
end
