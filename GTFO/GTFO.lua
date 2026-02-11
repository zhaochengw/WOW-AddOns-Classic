--------------------------------------------------------------------------
-- GTFO.lua 
--------------------------------------------------------------------------
--[[
GTFO
Author: Zensunim of Dragonblight [Retail], Myzrael [Classic]

Usage: /GTFO or go to Interface->Add-ons->GTFO
]]--
GTFO = {
	DefaultSettings = {
		Active = true;
		Sounds = { true, true, true, true };
		ScanMode = nil;
		AlertMode = nil;
		DebugMode = nil; -- Turn on debug alerts
		TestMode = nil; -- Activate alerts for events marked as "test only"
		UnmuteMode = nil;
		TrivialMode = nil;
		NoVersionReminder = nil;
		EnableVibration = nil;
		Volume = 3; -- Volume setting, 3 = default
		SoundChannel = "Master"; -- Sound channel to play on
		IgnoreOptions = { };
		TrivialDamagePercent = 2; -- Minimum % of HP lost required for an alert to be trivial
		SoundOverrides = { "", "", "", "" }; -- Override table for GTFO sounds
		IgnoreSpellList = { };
		BrannMode = 0;
		IgnoreTimeAmount = .2;
	};
	Version = "6.1"; -- Version number (text format)
	VersionNumber = 0; -- Numeric version number for checking out-of-date clients (placeholder until client is detected)
	RetailVersionNumber = 60100; -- Numeric version number for checking out-of-date clients (retail)
	ClassicVersionNumber = 60000; -- Numeric version number for checking out-of-date clients (Vanilla classic)
	BurningCrusadeVersionNumber = 60000; -- Numeric version number for checking out-of-date clients (TBC classic)
	WrathVersionNumber = 60000; -- Numeric version number for checking out-of-date clients (Wrath classic)
	CataclysmVersionNumber = 60000; -- Numeric version number for checking out-of-date clients (Cata classic)
	MistsVersionNumber = 60000; -- Numeric version number for checking out-of-date clients (MoP classic)
	DataLogging = nil; -- Indicate whether or not the addon needs to run the datalogging function (for hooking)
	DataCode = "4"; -- Saved Variable versioning, change this value to force a reset to default
	CanTank = nil; -- The active character is capable of tanking
	CanCast = nil; -- The active character is capable of casting
	TankMode = nil; -- The active character is a tank
	CasterMode = nil; -- The active character is a caster
	PlayerClass = select(2, UnitClass("player")); -- The active character's class
	SpellName = { }; -- List of spells (for Classic only since Spell IDs are not available in the combat log)
	SpellID = { }; -- List of spell IDs
	FFSpellID = { }; -- List of friendly fire spell IDs
	IgnoreSpellCategory = { }; -- List of spell groups to ignore
	IgnoreScan = { }; -- List of spell groups to ignore during scans
	MobID = { }; -- List of mob IDs for melee attack detection
	GroupGUID = { }; -- List of GUIDs of members in your group
	UpdateFound = nil; -- Upgrade available?
	IgnoreTime = nil;
	IgnoreUpdateTimeAmount = 5; -- Number of seconds between sending out version updates
	IgnoreUpdateTime = nil;
	IgnoreUpdateRequestTimeAmount = 90; -- Number of seconds between sending out version update requests
	IgnoreUpdateRequestTime = nil;
	Events = { }; -- Event queue
	Users = { }; -- User version database
	Sounds = { }; -- Sound Files
	SoundSettings = { }; -- CVARs for temporary muting
	SoundTimes = { .5, .3, .4, .5 }; -- Length of sound files in seconds (for auto-unmute)
	VibrationTypes = { "High", "Low", "Low", "High" };
	VibrationIntensity = { 1.0, .1, .25, 1.0 };
	PartyMembers = 0;
	RaidMembers = 0;
	PowerAuras = nil; -- PowerAuras Integration enabled
	WeakAuras = nil; -- WeakAuras Integration enabled
	Recount = nil; -- Recount Integration enabled
	Skada = nil; -- Skada Integration enabled
	Settings = { };
	UIRendered = nil;
	VariableStore = { -- Variable storage for special circumstances
		StackCounter = 0;
		DisableGTFO = nil;
	};
	BetaMode = nil; -- WoW Beta/PTR client detection
	DragonflightMode = nil; -- WoW Dragonflight UI client detection
	RetailMode = nil; -- WoW Retail client detection
	ClassicMode = nil; -- WoW Classic client detection
	BurningCrusadeMode = nil; -- WoW TBC client detection
	WrathMode = nil; -- WoW Wrath client detection
	CataclysmMode = nil; -- WoW Cataclysm client detection
	MistsMode = nil; -- WoW Mists client detection
	SoundChannels = { 
		{ Code = "Master", Name = _G.MASTER_VOLUME },
		{ Code = "SFX", Name = _G.SOUND_VOLUME, CVar = "Sound_EnableSFX" },
		{ Code = "Ambience", Name = _G.AMBIENCE_VOLUME, CVar = "Sound_EnableAmbience" },
		{ Code = "Music", Name = _G.MUSIC_VOLUME, CVar = "Sound_EnableMusic" },
		{ Code = "Dialog", Name = _G.DIALOG_VOLUME, CVar = "Sound_EnableDialog" },
	};
	Scans = { };
	EncounterPrivateAuraSoundIds = { };
	InstancePrivateAuraSoundIds = { };
	EncounterIndex = { }; -- Cache for encounters (Retail)
	InstanceIndex = { }; -- Cache for instances (Retail)
};

GTFOData = {};

local buildNumber = select(4, GetBuildInfo());

if (buildNumber > 120000) then
	GTFO.BetaMode = true;
end
if (buildNumber >= 120000) then
	GTFO.MidnightMode = true;
end
if (buildNumber >= 100000) then
	GTFO.DragonflightMode = true;
	GTFO.SoundChannels[2].Name = _G.FX_VOLUME;
end
if (buildNumber <= 20000) then
	GTFO.ClassicMode = true;
	GTFO.VersionNumber = GTFO.ClassicVersionNumber;
elseif (buildNumber <= 30000) then
	GTFO.BurningCrusadeMode = true;
	GTFO.VersionNumber = GTFO.BurningCrusadeVersionNumber;
elseif (buildNumber <= 40000) then
	GTFO.WrathMode = true;
	GTFO.VersionNumber = GTFO.WrathVersionNumber;
elseif (buildNumber <= 50000) then
	GTFO.CataclysmMode = true;
	GTFO.VersionNumber = GTFO.CataclysmVersionNumber;
elseif (buildNumber <= 60000) then
	GTFO.MistsMode = true;
	GTFO.VersionNumber = GTFO.MistsVersionNumber;
else
	GTFO.RetailMode = true;
	GTFO.VersionNumber = GTFO.RetailVersionNumber;
	local currentDate = date("*t");
	GTFO.AprilFoolsDay = (currentDate.month == 4 and currentDate.day == 1);
end

StaticPopupDialogs["GTFO_POPUP_MESSAGE"] = {
	preferredIndex = 3,
	text = GTFOLocal.LoadingPopup_Message,
	button1 = YES,
	button2 = NO,
	OnAccept = function()
		GTFO_Command_Options()
	end,
	OnCancel = function()
		GTFO_ChatPrint(string.format(GTFOLocal.ClosePopup_Message," |cFFFFFFFF/gtfo options|r"))
	end,
	timeout = 0,
	whileDead = true,
	hideOnEscape = true,
};	

function GTFO_ChatPrint(str)
	DEFAULT_CHAT_FRAME:AddMessage("[GTFO] "..tostring(str), 0.25, 1.0, 0.25);
end

function GTFO_ErrorPrint(str)
	DEFAULT_CHAT_FRAME:AddMessage("[GTFO] "..tostring(str), 1.0, 0.5, 0.5);
end

function GTFO_DebugPrint(str)
	if (GTFO.Settings.DebugMode) then
		DEFAULT_CHAT_FRAME:AddMessage("[GTFO] "..tostring(str), 0.75, 1.0, 0.25);
	end
end

function GTFO_ScanPrint(str, bNew)
	if (GTFO.Settings.ScanMode) then
		if (bNew) then
			DEFAULT_CHAT_FRAME:AddMessage("[GTFO:New] "..tostring(str), 0.5, 0.5, 0.85);
		else
			DEFAULT_CHAT_FRAME:AddMessage("[GTFO:Scan] "..tostring(str), 0.5, 0.65, 0.65);
		end

	end
end

function GTFO_AlertPrint(str)
	if (GTFO.Settings.AlertMode) then
		DEFAULT_CHAT_FRAME:AddMessage("[GTFO] "..tostring(str), 0.5, 0.5, 0.85);
	end
end

function GTFO_GetMobId(sGUID)
	local mobType, _, _, _, _, mobId = strsplit("-", sGUID or "")
	if mobType and (mobType == "Creature" or mobType == "Vehicle" or mobType == "Pet") then
		return tonumber(mobId)
	end
	return 0;
end

function GTFO_ScanGroupGUID()
	GTFO.GroupGUID = { };
	local partyMembers, raidMembers;
	raidMembers = GetNumGroupMembers();
	partyMembers = GetNumSubgroupMembers();
	if (not IsInRaid()) then
		raidMembers = 0
	end
	if (raidMembers > 0) then
		for i = 1, raidMembers, 1 do
			if not (UnitIsUnit("raid"..i, "player")) then
				tinsert(GTFO.GroupGUID, UnitGUID("raid"..i));
			end;
		end
	end
	if (partyMembers > 0) then
		for i = 1, partyMembers, 1 do
			if not (UnitIsUnit("party"..i, "player")) then
				tinsert(GTFO.GroupGUID, UnitGUID("party"..i));
			end;
		end
	end
end

function GTFO_Command(arg1)
	local Command = string.upper(arg1);
	local DescriptionOffset = string.find(arg1,"%s",1);
	local Description = nil;
	
	if (DescriptionOffset) then
		Command = string.upper(string.sub(arg1, 1, DescriptionOffset - 1));
		Description = tostring(string.sub(arg1, DescriptionOffset + 1));
	end
	
	--GTFO_DebugPrint("Command executed: "..Command);
	
	if (Command == "OPTION" or Command == "OPTIONS") then
		GTFO_Command_Options();
	elseif (Command == "STANDBY") then
		GTFO_Command_Standby();
	elseif (Command == "DEBUG") then
		GTFO_Command_Debug();
	elseif (Command == "SCAN" or Command == "SCANNER") then
		GTFO_Command_ScanMode();
	elseif (Command == "ALERT") then
		GTFO_Command_AlertMode();
	elseif (Command == "TESTMODE") then
		GTFO_Command_TestMode();
	elseif (Command == "VERSION") then
		GTFO_Command_Version();
	elseif (Command == "TEST") then
		if (DescriptionOffset) then
			GTFO_Command_Test(tonumber(Description));
		else
			GTFO_Command_Test(1);
		end
	elseif (Command == "TEST1") then
		GTFO_Command_Test(1);
	elseif (Command == "TEST2") then
		GTFO_Command_Test(2);
	elseif (Command == "TEST3") then
		GTFO_Command_Test(3);
	elseif (Command == "TEST4") then
		GTFO_Command_Test(4);
	elseif (Command == "CUSTOM") then
		GTFO_Command_SetCustomSound(1, Description);
	elseif (Command == "CUSTOM1") then
		GTFO_Command_SetCustomSound(1, Description);
	elseif (Command == "CUSTOM2") then
		GTFO_Command_SetCustomSound(2, Description);
	elseif (Command == "CUSTOM3") then
		GTFO_Command_SetCustomSound(3, Description);
	elseif (Command == "CUSTOM4") then
		GTFO_Command_SetCustomSound(4, Description);
	elseif (Command == "NOVERSION") then
		GTFO_Command_VersionReminder();
	elseif (Command == "DATA") then
		GTFO_Command_Data();
	elseif (Command == "CLEAR") then
		GTFO_Command_ClearData();
	elseif (Command == "VIBRATE" or Command == "VIB") then
		GTFO_Command_Vibrate();
	elseif (Command == "HELP" or Command == "") then
		GTFO_Command_Help();
	elseif (Command == "BRANN") then
		GTFO_Command_BrannMode();
	elseif (Command == "IGNORE") then
		GTFO_Command_IgnoreSpell(Description);
	elseif (Command == "REPORT" and GTFO.PrivateAuraScan) then
		GTFO.PrivateAuraScan();
	else
		GTFO_Command_Help();
	end
end

function GTFO_Command_Test(iSound)
	if (iSound == 1) then
		GTFO_PlaySound(1);
		if (GTFO.Settings.Sounds[1]) then
			GTFO_ChatPrint(GTFOLocal.TestSound_High);
		else
			GTFO_ChatPrint(GTFOLocal.TestSound_HighMuted);		
		end
	elseif (iSound == 2) then
		GTFO_PlaySound(2);
		if (GTFO.Settings.Sounds[2]) then
			GTFO_ChatPrint(GTFOLocal.TestSound_Low);
		else
			GTFO_ChatPrint(GTFOLocal.TestSound_LowMuted);		
		end
	elseif (iSound == 3) then			
		GTFO_PlaySound(3);
		if (GTFO.Settings.Sounds[3]) then
			GTFO_ChatPrint(GTFOLocal.TestSound_Fail);
		else
			GTFO_ChatPrint(GTFOLocal.TestSound_FailMuted);		
		end
	elseif (iSound == 4) then			
		GTFO_PlaySound(4);
		if (GTFO.Settings.Sounds[4]) then
			GTFO_ChatPrint(GTFOLocal.TestSound_FriendlyFire);
		else
			GTFO_ChatPrint(GTFOLocal.TestSound_FriendlyFireMuted);		
		end
	end
end

function GTFO_Command_IgnoreSpell(iSpellId)
	if (GTFO.ClassicMode) then
		-- Classic doesn't use Spell IDs, so it's not supported
		GTFO_ErrorPrint(GTFOLocal.UI_NotSupported_Classic);		
		return;
	end
	
	local sCommand = tostring(iSpellId):lower();
	local spellId = tonumber(iSpellId) or 0;
	if (sCommand == "" or sCommand == "nil") then
		if (#GTFO.Settings.IgnoreSpellList > 0) then
			GTFO_ChatPrint(GTFOLocal.UI_IgnoreSpell_List);
			for i, IgnoredSpellId in pairs(GTFO.Settings.IgnoreSpellList) do
				GTFO_ChatPrint("  "..IgnoredSpellId..": "..GTFO_GetSpellLink(IgnoredSpellId));
			end
		else
			GTFO_ChatPrint(GTFOLocal.UI_IgnoreSpell_None);
		end
		GTFO_ChatPrint(GTFOLocal.UI_IgnoreSpell_Help);
	elseif (spellId > 0) then
		local spellLink = GTFO_GetSpellLink(spellId);
		if (tContains(GTFO.Settings.IgnoreSpellList, spellId)) then
			-- Remove spell ID
			for i, IgnoredSpellId in pairs(GTFO.Settings.IgnoreSpellList) do
				if (IgnoredSpellId == spellId) then
					tremove(GTFO.Settings.IgnoreSpellList, i);
					GTFO_ChatPrint(string.format(GTFOLocal.UI_IgnoreSpell_Remove,spellId,(spellLink or "")));
					GTFO_SaveSettings();
					return;
				end
			end
		else
			-- Add spell ID
			if (not spellLink) then
				GTFO_ErrorPrint(string.format(GTFOLocal.UI_IgnoreSpell_InvalidSpellId, spellId));	
				return;
			end
			GTFO.AddUnique(GTFO.Settings.IgnoreSpellList, spellId);
			GTFO_ChatPrint(string.format(GTFOLocal.UI_IgnoreSpell_Add,spellId,spellLink));
			GTFO_SaveSettings();
		end
	else
		GTFO_ErrorPrint("Invalid command.")
	end
end


function GTFO_Command_SetCustomSound(iSound, sSound)
	GTFO.Settings.SoundOverrides[iSound] = tostring(sSound or "");
	if (iSound == 1) then
		if (GTFO.Settings.SoundOverrides[iSound] == "") then
			GTFO_Option_HighReset();
		else
			GTFO_ChatPrint(string.format(GTFOLocal.UI_CustomSounds_Set, GTFOLocal.AlertType_High));
			GTFO_SaveSettings();
			GTFO_Option_HighTest();
		end
	elseif (iSound == 2) then
		if (GTFO.Settings.SoundOverrides[iSound] == "") then
			GTFO_Option_LowReset();
		else
			GTFO_ChatPrint(string.format(GTFOLocal.UI_CustomSounds_Set, GTFOLocal.AlertType_Low));
			GTFO_SaveSettings();
			GTFO_Option_LowTest();
		end
	elseif (iSound == 3) then
		if (GTFO.Settings.SoundOverrides[iSound] == "") then
			GTFO_Option_FailReset();
		else
			GTFO_ChatPrint(string.format(GTFOLocal.UI_CustomSounds_Set, GTFOLocal.AlertType_Fail));
			GTFO_SaveSettings();
			GTFO_Option_FailTest();
		end
	elseif (iSound == 4) then
		if (GTFO.Settings.SoundOverrides[iSound] == "") then
			GTFO_Option_FriendlyFireReset();
		else
			GTFO_ChatPrint(string.format(GTFOLocal.UI_CustomSounds_Set, GTFOLocal.AlertType_FriendlyFire));
			GTFO_SaveSettings();
			GTFO_Option_FriendlyFireTest();
		end
	end
end

function GTFO_Command_Debug()
	if (GTFO.Settings.DebugMode) then
		GTFO.Settings.DebugMode = nil;
		GTFO_ChatPrint("Debug mode off.");
	else
		GTFO.Settings.DebugMode = true;
		GTFO_ChatPrint("Debug mode on.");
	end
	GTFO_SaveSettings();
end

function GTFO_Command_ScanMode()
	if (GTFO.Settings.ScanMode) then
		GTFO.Settings.ScanMode = nil;
		GTFO_ChatPrint("Scan mode off.");
	else
		GTFO.Settings.ScanMode = true;
		GTFO_ChatPrint("Scan mode on.");
	end
	GTFO_SaveSettings();
end

function GTFO_Command_AlertMode()
	if (GTFO.Settings.AlertMode) then
		GTFO.Settings.AlertMode = nil;
		GTFO_ChatPrint("Alert display mode off.");
	else
		GTFO.Settings.AlertMode = true;
		GTFO_ChatPrint("Alert display mode mode on.");
	end
	GTFO_SaveSettings();
end

function GTFO_Command_TestMode()
	if (GTFO.Settings.TestMode) then
		GTFO.Settings.TestMode = nil;
		GTFO_ChatPrint("Test mode off.");
	else
		GTFO.Settings.TestMode = true;
		GTFO_ChatPrint("Test mode on.");
	end
	GTFO_SaveSettings();
end

function GTFO_Command_Standby()
	if (GTFO.Settings.Active) then
		GTFO.Settings.Active = nil;
		GTFO_ChatPrint(GTFOLocal.Active_Off);
	else
		GTFO.Settings.Active = true;
		GTFO_ChatPrint(GTFOLocal.Active_On);
	end
	GTFO_SaveSettings();
end

function GTFO_Command_Vibrate()
	if (GTFO.Settings.EnableVibration) then
		GTFO.Settings.EnableVibration = nil;
		GTFO_ChatPrint(GTFOLocal.Vibration_Off);
	else
		GTFO.Settings.EnableVibration = true;
		GTFO_ChatPrint(GTFOLocal.Vibration_On);
	end
	GTFO_SaveSettings();
end

function GTFO_Command_BrannMode()
	if (GTFO.Settings.BrannMode == 2 or not GTFO.Settings.BrannMode) then
		GTFO.Settings.BrannMode = 0;
		GTFO_ChatPrint(GTFOLocal.BrannMode_Off);
	elseif (GTFO.Settings.BrannMode == 1) then
		GTFO.Settings.BrannMode = 2;
		GTFO_ChatPrint(GTFOLocal.BrannMode_On);
	else
		GTFO.Settings.BrannMode = 1;
		GTFO_ChatPrint(GTFOLocal.BrannMode_OnWithDefault);
	end
	GTFO_SaveSettings();
end

function GTFO_Command_VersionReminder()
	if (GTFO.Settings.NoVersionReminder) then
		GTFO.Settings.NoVersionReminder = nil;
		GTFO_ChatPrint(GTFOLocal.Version_On);
	else
		GTFO.Settings.NoVersionReminder = true;
		GTFO_ChatPrint(GTFOLocal.Version_Off);
	end
	GTFO_SaveSettings();
end

function GTFO_PlaySound(iSound, bOverride, bForceVibrate)
	if ((iSound or 0) == 0) then
		return;
	end
	
	local currentTime = GetTime();
	if (GTFO.IgnoreTime) then
		if (currentTime < GTFO.IgnoreTime) then
			return;
		end
	end
	GTFO.IgnoreTime = currentTime + (GTFO.Settings.IgnoreTimeAmount or GTFO.DefaultSettings.IgnoreTimeAmount);

	if (bOverride or GTFO.Settings.Sounds[iSound]) then
		local soundChannel = GTFO.Settings.SoundChannel;
		
		if (bOverride) then
			local channel = math.floor(getglobal("GTFO_ChannelIdSlider"):GetValue());
			soundChannel = GTFO.SoundChannels[channel].Code;
		end
		if (bOverride and getglobal("GTFO_UnmuteButton"):GetChecked()) then
			GTFO_UnmuteSound(GTFO.SoundTimes[iSound], soundChannel);
		elseif (GTFO.Settings.UnmuteMode and GTFO.SoundTimes[iSound] and not bOverride) then
			GTFO_UnmuteSound(GTFO.SoundTimes[iSound], soundChannel);
		end
		
		local soundFile = tostring(GTFO.Settings.SoundOverrides[iSound] or "");
		local soundFile2 = "";
		local brannSound = (GTFO.Settings.BrannMode or 0) > 0;
		if (soundFile == "") then
			-- Sad, this only works if the dialog channel is unmuted, will need to investigate further
			if (brannSound and iSound == 1) then
				soundFile = GTFO.BrannModeSounds[1][math.random(#GTFO.BrannModeSounds[1])];
			elseif (brannSound and iSound == 3) then
				soundFile = GTFO.BrannModeSounds[2][math.random(#GTFO.BrannModeSounds[2])];
			else
				soundFile = GTFO.Sounds[iSound];
			end
			if (GTFO.Settings.BrannMode == 1) then
				soundFile2 = GTFO.Sounds[iSound];
			end
		end

		if (tonumber(soundFile) or 0 > 0) then
			GTFO_PlaySoundId(soundFile, soundChannel);
		else
			GTFO_PlaySoundFile(soundFile, soundChannel);
		end
		
		-- Play 2 times if the volume is at louder
		if (GTFO.Settings.Volume >= 4) then
			if (tonumber(soundFile) or 0 > 0) then
				GTFO_PlaySoundId(soundFile, soundChannel);
			else
				GTFO_PlaySoundFile(soundFile, soundChannel);
			end
		end
		
		-- Play 3 times if the volume is at max
		if (GTFO.Settings.Volume >= 5) then
			if (tonumber(soundFile) or 0 > 0) then
				GTFO_PlaySoundId(soundFile, soundChannel);
			else
				GTFO_PlaySoundFile(soundFile, soundChannel);
			end
		end
		
		-- Play secondary soundfile 
		if (soundFile2 ~= "") then
			if (tonumber(soundFile2) or 0 > 0) then
				GTFO_PlaySoundId(soundFile2, soundChannel);
			else
				GTFO_PlaySoundFile(soundFile2, soundChannel);
			end
			
			-- Play 2 times if the volume is at louder
			if (GTFO.Settings.Volume >= 4) then
				if (tonumber(soundFile2) or 0 > 0) then
					GTFO_PlaySoundId(soundFile2, soundChannel);
				else
					GTFO_PlaySoundFile(soundFile2, soundChannel);
				end
			end
			
			-- Play 3 times if the volume is at max
			if (GTFO.Settings.Volume >= 5) then
				if (tonumber(soundFile2) or 0 > 0) then
					GTFO_PlaySoundId(soundFile2, soundChannel);
				else
					GTFO_PlaySoundFile(soundFile2, soundChannel);
				end
			end
		end
	end
	GTFO_DisplayAura(iSound);
	if (bForceVibrate == true or (bForceVibrate == nil and GTFO.Settings.EnableVibration)) then
		GTFO_Vibrate(iSound);
	end
end

function GTFO_GetSoundData(iAlertLevel)
	if ((iAlertLevel or 0) == 0) then
		return;
	end

	if (GTFO.Settings.Sounds[iAlertLevel]) then
		local soundChannel = GTFO.Settings.SoundChannel;
		local soundLevel = 1;
		
		local soundFile = tostring(GTFO.Settings.SoundOverrides[iAlertLevel] or "");
		local soundFile2 = nil;
		local brannSound = (GTFO.Settings.BrannMode or 0) > 0;
		if (soundFile == "") then
			-- Sad, this only works if the dialog channel is unmuted, will need to investigate further
			if (brannSound and iAlertLevel == 1) then
				soundFile = GTFO.BrannModeSounds[1][math.random(#GTFO.BrannModeSounds[1])];
			elseif (brannSound and iAlertLevel == 3) then
				soundFile = GTFO.BrannModeSounds[2][math.random(#GTFO.BrannModeSounds[2])];
			else
				soundFile = GTFO.Sounds[iAlertLevel];
			end
			if (GTFO.Settings.BrannMode == 1) then
				soundFile2 = GTFO.Sounds[iAlertLevel];
			end
		end

		-- Play 2 times if the volume is at louder
		if (GTFO.Settings.Volume >= 4) then
			soundLevel = 2
		end
		
		-- Play 3 times if the volume is at max
		if (GTFO.Settings.Volume >= 5) then
			soundLevel = 3
		end
		
		return soundFile, soundChannel, soundLevel, soundFile2;
	end
end

function GTFO_PlaySoundFile(sFile, sChannel)
	local willPlay, handle = PlaySoundFile(sFile, sChannel);
	if (willPlay) then
		-- Stop the sound automatically after 3 seconds in case someone trolls you with a 10 minute song
		GTFO_AddEvent("Sound"..handle, 3, function() StopSound(handle, 250); end);
	end
end

function GTFO_PlaySoundId(iSound, sChannel)
	local willPlay, handle = PlaySound(iSound, sChannel, false);
	if (willPlay) then
		-- Stop the sound automatically after 3 seconds in case someone trolls you with a 10 minute song
		GTFO_AddEvent("Sound"..handle, 3, function() StopSound(handle, 250); end);
	end
end

-- Play vibration
function GTFO_Vibrate(iSound)
	if (GTFO.VibrationTypes[iSound] and GTFO.VibrationIntensity[iSound] > 0) then
		C_GamePad.SetVibration(GTFO.VibrationTypes[iSound], GTFO.VibrationIntensity[iSound]);
	end
end

function GTFO_RefreshOptions()
	-- Spell info isn't available right away, so do this after loading
	for key, option in pairs(GTFO.IgnoreSpellCategory) do
		if (GTFO.IgnoreSpellCategory[key].spellID and not (GetLocale() == "enUS" and GTFO.IgnoreSpellCategory[key].override)) then
			local IgnoreAlertButton = _G["GTFO_IgnoreAlertButton_"..key];
			if (IgnoreAlertButton) then
				local spellID = GTFO.IgnoreSpellCategory[key].spellID;
				local spellName = GTFO_GetSpellName(spellID);
				if (spellName) then
					getglobal(IgnoreAlertButton:GetName().."Text"):SetText(spellName);
				
					GTFOSpellTooltip:SetOwner(_G["GTFOFrame"],"ANCHOR_NONE");
					GTFOSpellTooltip:ClearLines();
					if (not GTFO.ClassicMode) then
						GTFOSpellTooltip:SetHyperlink(GTFO_GetSpellLink(spellID));
					end
					local tooltipText = tostring(getglobal("GTFOSpellTooltipTextLeft1"):GetText());
					if (GTFOSpellTooltip:NumLines()) then
						if (getglobal("GTFOSpellTooltipTextLeft"..tostring(GTFOSpellTooltip:NumLines()))) then
							tooltipText = tooltipText.."\n"..tostring(getglobal("GTFOSpellTooltipTextLeft"..tostring(GTFOSpellTooltip:NumLines())):GetText());
						end
					end
					IgnoreAlertButton.tooltip = tooltipText;
				else
					getglobal(IgnoreAlertButton:GetName().."Text"):SetText(GTFO.IgnoreSpellCategory[key].desc);
				end
			end
		end
	end
end

-- Event handling
function GTFO_OnUpdate()
	local currentTime = GetTime();
	
	if (#GTFO.Events > 0) then
		for index, event in pairs(GTFO.Events) do
			if (currentTime > event.ExecuteTime) then
				if (event.Code) then
					event:Code();
				end
				if (event.Repeat > 0) then
					event.ExecuteTime = currentTime + event.Repeat;
					--GTFO_DebugPrint("Repeating event #"..index.." for "..event.Repeat.." seconds.");
				else
					--GTFO_DebugPrint("Removing event #"..index.." - "..event.Name);
					tremove(GTFO.Events, index);
				end				
			end
		end
	end
	
	-- Check for GTFO events
	if (#GTFO.Events <= 0) then
		GTFOFrame:SetScript("OnUpdate", nil);
		--GTFO_DebugPrint("Event update checking disabled.");
	end	
end

function GTFO_UnmuteSound(delayTime, soundChannel)
	if (not GTFO_FindEvent("Mute")) then
		GTFO.SoundSettings.EnableAllSound = GetCVar("Sound_EnableAllSound");
		GTFO.SoundSettings.SecondaryCVar = GTFO_GetSoundChannelCVar(soundChannel);
		if (GTFO.SoundSettings.SecondaryCVar) then
			GTFO.SoundSettings.EnableSecondary = GetCVar(GTFO.SoundSettings.SecondaryCVar);
			SetCVar(GTFO.SoundSettings.SecondaryCVar, 1);
		end
		SetCVar("Sound_EnableAllSound", 1);
		--GTFO_DebugPrint("Temporarily unmuting volume for "..delayTime.. " seconds.");
	end
	GTFO_AddEvent("Mute", delayTime, function() GTFO_MuteSound(); end);
end

function GTFO_MuteSound()
	SetCVar("Sound_EnableAllSound", GTFO.SoundSettings.EnableAllSound);
	if (GTFO.SoundSettings.SecondaryCVar) then
		SetCVar(GTFO.SoundSettings.SecondaryCVar, GTFO.SoundSettings.EnableSecondary);
	end
	--GTFO_DebugPrint("Muting sound again.");
end

function GTFO_Option_HighTest()
	GTFO_PlaySound(1, true, getglobal("GTFO_VibrationButton"):GetChecked());
end

function GTFO_Option_LowTest()
	GTFO_PlaySound(2, true, getglobal("GTFO_VibrationButton"):GetChecked());
end

function GTFO_Option_FailTest()
	GTFO_PlaySound(3, true, getglobal("GTFO_VibrationButton"):GetChecked());
end

function GTFO_Option_FriendlyFireTest()
	GTFO_PlaySound(4, true, getglobal("GTFO_VibrationButton"):GetChecked());
end

function GTFO_Option_HighReset()
	GTFO.Settings.SoundOverrides[1] = "";
	GTFO_SaveSettings();
	GTFO_Option_HighTest();
	GTFO_ChatPrint(string.format(GTFOLocal.UI_CustomSounds_Removed, GTFOLocal.AlertType_High));
end

function GTFO_Option_LowReset()
	GTFO.Settings.SoundOverrides[2] = "";
	GTFO_SaveSettings();
	GTFO_Option_LowTest();
	GTFO_ChatPrint(string.format(GTFOLocal.UI_CustomSounds_Removed, GTFOLocal.AlertType_Low));
end

function GTFO_Option_FailReset()
	GTFO.Settings.SoundOverrides[3] = "";
	GTFO_SaveSettings();
	GTFO_Option_FailTest();
	GTFO_ChatPrint(string.format(GTFOLocal.UI_CustomSounds_Removed, GTFOLocal.AlertType_Fail));
end

function GTFO_Option_FriendlyFireReset()
	GTFO.Settings.SoundOverrides[4] = "";
	GTFO_SaveSettings();
	GTFO_Option_FriendlyFireTest();
	GTFO_ChatPrint(string.format(GTFOLocal.UI_CustomSounds_Removed, GTFOLocal.AlertType_FriendlyFire));
end

function GTFO.AlertText(iAlert)
	local alert = tonumber(iAlert);
	if (alert == 1) then
		return GTFOLocal.AlertType_High;
	elseif (alert == 2) then
		return GTFOLocal.AlertType_Low;
	elseif (alert == 3) then
		return GTFOLocal.AlertType_Fail;
	elseif (alert == 4) then
		return GTFOLocal.AlertType_FriendlyFire;
	else
		return GTFOLocal.Group_None;
	end
end

-- Get a list of all the people in your group/raid using GTFO and their version numbers
function GTFO_Command_Version()
	GTFO_SendUpdateRequest();
	local partymembers, raidmembers;

	partymembers = GetNumSubgroupMembers();
	raidmembers = GetNumGroupMembers();
	if (not IsInRaid()) then
		raidmembers = 0
	end

	local users = 0;

	if (raidmembers > 0 or partymembers > 0) then
		if (raidmembers > 0) then
			for i = 1, raidmembers, 1 do
				local displayName;
				local name, server = UnitName("raid"..i);
				local fullname = name;
				if (server and server ~= "") then
					fullname = name.."-"..server;
					displayName = fullname;
				else
					fullname = name.."-"..GTFO_GetRealmName()
					displayName = name;
				end
				if (GTFO.Users[fullname]) then
					GTFO_ChatPrint(displayName..": "..GTFO_ParseVersionColor(GTFO.Users[fullname]));
					users = users + 1;
				else
					GTFO_ChatPrint(displayName..": |cFF999999"..GTFOLocal.Group_None.."|r");
				end
			end
			GTFO_ChatPrint(string.format(GTFOLocal.Group_RaidMembers, users, raidmembers));
		elseif (partymembers > 0) then
			GTFO_ChatPrint(UnitName("player")..": "..GTFO_ParseVersionColor(GTFO.VersionNumber));
			users = 1;
			for i = 1, partymembers, 1 do
				local displayName;
				local name, server = UnitName("party"..i);
				local fullname = name;
				if (server and server ~= "") then
					fullname = name.."-"..server
					displayName = fullname;
				else
					fullname = name.."-"..GTFO_GetRealmName()
					displayName = name;
				end
				if (GTFO.Users[fullname]) then
					GTFO_ChatPrint(displayName..": "..GTFO_ParseVersionColor(GTFO.Users[fullname]));
					users = users + 1;
				else
					GTFO_ChatPrint(displayName..": |cFF999999"..GTFOLocal.Group_None.."|r");
				end
			end
			GTFO_ChatPrint(string.format(GTFOLocal.Group_PartyMembers, users, (partymembers + 1)));
		end
	else
		GTFO_ErrorPrint(GTFOLocal.Group_NotInGroup);
	end		
end

function GTFO_ParseVersionColor(iVersionNumber)
	local Color = "";
	if (GTFO.VersionNumber < iVersionNumber * 1) then
		Color = "|cFFFFFF00"
	elseif (GTFO.VersionNumber == iVersionNumber * 1) then
		Color = "|cFFFFFFFF"
	else
		Color = "|cFFAAAAAA"
	end
	return Color..GTFO_ParseVersionNumber(iVersionNumber).."|r"
end

function GTFO_ParseVersionNumber(iVersionNumber)
	local sVersion = "";
	local iMajor = math.floor(iVersionNumber * 0.0001);
	local iMinor = math.floor((iVersionNumber - (iMajor * 10000)) * 0.01)
	local iMinor2 = iVersionNumber - (iMajor * 10000) - (iMinor * 100)
	if (iMinor2 > 0) then
		sVersion = iMajor.."."..iMinor.."."..iMinor2
	else
		sVersion = iMajor.."."..iMinor
	end
	return sVersion;
end

function GTFO_SendUpdate(sMethod)
	if not (sMethod == "PARTY" or sMethod == "RAID" or sMethod == "INSTANCE_CHAT") then
		return;
	end
	local currentTime = GetTime();
	if (GTFO.IgnoreUpdateTime) then
		if (currentTime < GTFO.IgnoreUpdateTime) then
			return;
		end
	end
	GTFO.IgnoreUpdateTime = currentTime + GTFO.IgnoreUpdateTimeAmount;

	--GTFO_DebugPrint("Sending version info to "..sMethod);
	C_ChatInfo.SendAddonMessage("GTFO","V:"..GTFO.VersionNumber,sMethod)
end

function GTFO_SendUpdateRequest()
	local currentTime = GetTime();
	if (GTFO.IgnoreUpdateRequestTime) then
		if (currentTime < GTFO.IgnoreUpdateRequestTime) then
			return;
		end
	end
	GTFO.IgnoreUpdateRequestTime = currentTime + GTFO.IgnoreUpdateRequestTimeAmount;

	raidmembers = GetNumGroupMembers();
	partymembers = GetNumSubgroupMembers();
	if (not IsInRaid()) then
		raidmembers = 0
	end
	
	if (IsInGroup(LE_PARTY_CATEGORY_INSTANCE)) then
		C_ChatInfo.SendAddonMessage("GTFO","U:INSTANCE_CHAT","INSTANCE_CHAT");
	elseif (raidmembers > 0) then
		C_ChatInfo.SendAddonMessage("GTFO","U:RAID","RAID");
	elseif (partymembers > 0) then
		C_ChatInfo.SendAddonMessage("GTFO","U:PARTY","PARTY");
	end
end

function GTFO_Command_Options()
	if (InCombatLockdown()) then
		GTFO_ErrorPrint(GTFOLocal.Help_SettingsDuringCombat);
		return;
	end
	if (Settings and Settings.OpenToCategory) then
		Settings.OpenToCategory(GTFO.SettingsCategoryId);
		Settings.OpenToCategory(GTFO.SettingsCategoryId);
		Settings.OpenToCategory(GTFO.SettingsCategoryId);
	else
		InterfaceOptionsFrame_OpenToCategory("GTFO");
		InterfaceOptionsFrame_OpenToCategory("GTFO");
		InterfaceOptionsFrame_OpenToCategory("GTFO");	
	end
end

function GTFO_Option_SetVolume()
	if (not GTFO.UIRendered) then
		return;
	end
	local volumeSetting = math.floor(getglobal("GTFO_VolumeSlider"):GetValue());
	if (GTFO.Settings.Volume ~= volumeSetting) then
		--GTFO_DebugPrint("Setting volume from "..tostring(GTFO.Settings.Volume).." to "..volumeSetting);
		GTFO.Settings.Volume = volumeSetting;
		getglobal("GTFO_VolumeSlider"):SetValue(GTFO.Settings.Volume);
		GTFO_GetSounds();
		GTFO_Option_SetVolumeText(GTFO.Settings.Volume);
		GTFO_SaveSettings();
	else
		getglobal("GTFO_VolumeSlider"):SetValue(GTFO.Settings.Volume);
	end
end

function GTFO_Option_SetVolumeText(iVolume)
	if (iVolume == 1) then
		getglobal("GTFO_VolumeText"):SetText(GTFOLocal.UI_VolumeQuiet);
	elseif (iVolume == 2) then
		getglobal("GTFO_VolumeText"):SetText(GTFOLocal.UI_VolumeSoft);
	elseif (iVolume == 4) then
		getglobal("GTFO_VolumeText"):SetText(GTFOLocal.UI_VolumeLoud);
	elseif (iVolume == 5) then
		getglobal("GTFO_VolumeText"):SetText(GTFOLocal.UI_VolumeLouder);
	elseif (iVolume > 5) then
		getglobal("GTFO_VolumeText"):SetText(iVolume);
	else
		getglobal("GTFO_VolumeText"):SetText(GTFOLocal.UI_VolumeNormal);
	end
end

function GTFO_Option_SetChannelIdText(iChannelId)
	getglobal("GTFO_ChannelText"):SetText(GTFO.SoundChannels[iChannelId].Name);
end

function GTFO_Option_SetTrivialDamage()
	if (not GTFO.UIRendered) then
		return;
	end
	local trivialSetting = math.floor(getglobal("GTFO_TrivialDamageSlider"):GetValue() * 10)/10;
	if (GTFO.Settings.TrivialDamagePercent ~= trivialSetting) then
		--GTFO_DebugPrint("Setting trivial damage percent from "..tostring(GTFO.Settings.TrivialDamagePercent).." to "..trivialSetting);
		GTFO.Settings.TrivialDamagePercent = trivialSetting;
		getglobal("GTFO_TrivialDamageSlider"):SetValue(GTFO.Settings.TrivialDamagePercent);
		GTFO_GetSounds();
		GTFO_Option_SetTrivialDamageText(GTFO.Settings.TrivialDamagePercent);
		GTFO_SaveSettings();
	else
		getglobal("GTFO_TrivialDamageSlider"):SetValue(GTFO.Settings.TrivialDamagePercent);
	end
end

function GTFO_Option_SetChannel()
	if (not GTFO.UIRendered) then
		return;
	end
	local channelId = math.floor(getglobal("GTFO_ChannelIdSlider"):GetValue());
	local channelSetting = GTFO.SoundChannels[channelId].Code;
	if (GTFO.Settings.SoundChannel ~= channelSetting) then
		--GTFO_DebugPrint("Setting sound channel from "..tostring(GTFO.Settings.SoundChannel).." to "..channelSetting);
		GTFO.Settings.SoundChannel = channelSetting;
		getglobal("GTFO_ChannelIdSlider"):SetValue(channelId);
		GTFO_Option_SetChannelIdText(channelId);
		GTFO_SaveSettings();
	else
		getglobal("GTFO_ChannelIdSlider"):SetValue(channelId);
	end
end

function GTFO_Option_SetBrannMode()
	if (not GTFO.UIRendered) then
		return;
	end
	local brannMode = math.floor(getglobal("GTFO_BrannModeSlider"):GetValue());
	if (GTFO.Settings.BrannMode ~= brannMode) then
		--GTFO_DebugPrint("Setting Brann mode from "..tostring(GTFO.Settings.BrannMode).." to "..brannMode);
		GTFO.Settings.BrannMode = brannMode;
		getglobal("GTFO_BrannModeSlider"):SetValue(brannMode);
		getglobal("GTFO_BrannModeText"):SetText(GTFO_GetCurrentBrannMode(GTFO.Settings.BrannMode));
		GTFO_SaveSettings();
	else
		getglobal("GTFO_BrannModeSlider"):SetValue(brannMode);
	end
end

function GTFO_Option_SetIgnoreTime()
	if (not GTFO.UIRendered) then
		return;
	end
	local ignoreTime = math.floor(getglobal("GTFO_IgnoreTimeSlider"):GetValue() * 10)/10;
	if (GTFO.Settings.IgnoreTimeAmount ~= ignoreTime) then
		--GTFO_DebugPrint("Setting ignore time amount from "..tostring(GTFO.Settings.IgnoreTimeAmount).." to "..ignoreTime);
		GTFO.Settings.IgnoreTimeAmount = ignoreTime;
		getglobal("GTFO_IgnoreTimeSlider"):SetValue(ignoreTime);
		getglobal("GTFO_IgnoreTimeText"):SetText(GTFO.Settings.IgnoreTimeAmount.." "..(GTFOLocal.UI_IgnoreTime_Seconds or ""));
		GTFO_SaveSettings();
	else
		getglobal("GTFO_IgnoreTimeSlider"):SetValue(ignoreTime);
	end
end

function GTFO_Option_SetTrivialDamageText(iTrivialDamagePercent)
	if (not GTFO.UIRendered) then
		return;
	end
	getglobal("GTFO_TrivialDamageText"):SetText(iTrivialDamagePercent.."%");
end

-- Cache sound file locations 
function GTFO_GetSounds()
	if (GTFO.Settings.Volume == 2) then
		GTFO.Sounds = {
			"Interface\\AddOns\\GTFO\\Sounds\\alarmbuzzer_soft.ogg",
			"Interface\\AddOns\\GTFO\\Sounds\\alarmbeep_soft.ogg",
			"Interface\\AddOns\\GTFO\\Sounds\\alarmdouble_soft.ogg",
			"Interface\\AddOns\\GTFO\\Sounds\\alarmbuzz_soft.ogg",
		};
	elseif (GTFO.Settings.Volume == 1) then
		GTFO.Sounds = {
			"Interface\\AddOns\\GTFO\\Sounds\\alarmbuzzer_quiet.ogg",
			"Interface\\AddOns\\GTFO\\Sounds\\alarmbeep_quiet.ogg",
			"Interface\\AddOns\\GTFO\\Sounds\\alarmdouble_quiet.ogg",
			"Interface\\AddOns\\GTFO\\Sounds\\alarmbuzz_quiet.ogg",
		};
	else	
		GTFO.Sounds = {
			"Interface\\AddOns\\GTFO\\Sounds\\alarmbuzzer.ogg",
			"Interface\\AddOns\\GTFO\\Sounds\\alarmbeep.ogg",
			"Interface\\AddOns\\GTFO\\Sounds\\alarmdouble.ogg",
			"Interface\\AddOns\\GTFO\\Sounds\\alarmbuzz.ogg",
		};
	end
	
	if not (GTFO.BrannModeSounds) then
		GTFO.BrannModeSounds = {
			{
				"Interface\\AddOns\\GTFO\\Sounds\\Brann\\VO_110_Brann_Bronzebeard_33_M.ogg", -- Get out of the way!
				"Interface\\AddOns\\GTFO\\Sounds\\Brann\\VO_110_Brann_Bronzebeard_34_M.ogg", -- Don't stand there!
				"Interface\\AddOns\\GTFO\\Sounds\\Brann\\VO_110_Brann_Bronzebeard_35_M.ogg", -- You got to dodge
				"Interface\\AddOns\\GTFO\\Sounds\\Brann\\VO_110_Brann_Bronzebeard_43_M.ogg", -- Keepers preserve ye!
				"Interface\\AddOns\\GTFO\\Sounds\\Brann\\VO_110_Brann_Bronzebeard_47_M.ogg", -- Hey, be careful!
			},
			{
				"Interface\\AddOns\\GTFO\\Sounds\\Brann\\VO_110_Brann_Bronzebeard_33_M.ogg", -- Get out of the way!
				"Interface\\AddOns\\GTFO\\Sounds\\Brann\\VO_110_Brann_Bronzebeard_34_M.ogg", -- Don't stand there!
				"Interface\\AddOns\\GTFO\\Sounds\\Brann\\VO_110_Brann_Bronzebeard_35_M.ogg", -- You got to dodge
				"Interface\\AddOns\\GTFO\\Sounds\\Brann\\VO_110_Brann_Bronzebeard_42_M.ogg", -- Don't go dying on me
				"Interface\\AddOns\\GTFO\\Sounds\\Brann\\VO_110_Brann_Bronzebeard_43_M.ogg", -- Keepers preserve ye!
				"Interface\\AddOns\\GTFO\\Sounds\\Brann\\VO_110_Brann_Bronzebeard_44_M.ogg", -- It can't end like this!
				"Interface\\AddOns\\GTFO\\Sounds\\Brann\\VO_110_Brann_Bronzebeard_47_M.ogg", -- Hey, be careful!
				"Interface\\AddOns\\GTFO\\Sounds\\Brann\\VO_110_Brann_Bronzebeard_57_M.ogg", -- I know you can do better than that
				"Interface\\AddOns\\GTFO\\Sounds\\Brann\\VO_110_Brann_Bronzebeard_89_M.ogg", -- Little too close for my taste
			},
		};
	end
end

-- Show pop-up alert
function GTFO_DisplayConfigPopupMessage()
	StaticPopup_Show("GTFO_POPUP_MESSAGE");
end

function GTFO_GetAlertType(alertID)
	if (alertID == 1) then
		return GTFOLocal.AlertType_High;
	elseif (alertID == 2) then
		return GTFOLocal.AlertType_Low;
	elseif (alertID == 3) then
		return GTFOLocal.AlertType_Fail;
	elseif (alertID == 4) then
		return GTFOLocal.AlertType_FriendlyFire;
	end
	return nil;
end

function GTFO_GetAlertByID(alertName)
	if (alertName == GTFOLocal.AlertType_High) then
		return 1;
	elseif (alertName == GTFOLocal.AlertType_Low) then
		return 2;
	elseif (alertName == GTFOLocal.AlertType_Fail) then
		return 3;
	elseif (alertName == GTFOLocal.AlertType_FriendlyFire) then
		return 4;
	end
	return nil;
end

function GTFO_GetAlertIcon(alertID)
	if (alertID == 1) then
		return "Interface\\Icons\\Spell_Fire_Fire";
	elseif (alertID == 2) then
		return "Interface\\Icons\\Spell_Fire_BlueFire";
	elseif (alertID == 3) then
		return "Interface\\Icons\\Ability_Suffocate";
	elseif (alertID == 4) then
		return "Interface\\Icons\\Spell_Fire_FelFlameRing";
	end
	return nil;
end

function GTFO_AddEvent(eventName, eventTime, eventCode, eventRepeat)
		local event = {
			Name = tostring(eventName);
			ExecuteTime = GetTime() + eventTime;
			Code = eventCode;
			Repeat = 0;
		};
		local eventIndex = nil;
		
		if (eventRepeat) then
			event.Repeat = eventRepeat;
		end

		-- Check for existing event
		eventIndex = GTFO_FindEvent(event.Name);
		
		if (eventIndex) then
			GTFO.Events[eventIndex].ExecuteTime = event.ExecuteTime;
			--GTFO_DebugPrint("Extending event '"..event.Name.."' to be executed in "..eventTime.." seconds.");
		else
			tinsert(GTFO.Events, event);
			--GTFO_DebugPrint("Adding event '"..event.Name.."' to be executed in "..eventTime.." seconds.");			
			GTFOFrame:SetScript("OnUpdate", GTFO_OnUpdate);
			--GTFO_DebugPrint("Event update checking enabled.");
		end
end

function GTFO_RemoveEvent(eventName)
	if (#GTFO.Events > 0) then
		for index, event in pairs(GTFO.Events) do
			if (event.Name == eventName) then
				--GTFO_DebugPrint("Removed event: "..tostring(eventName));
				tremove(GTFO.Events, index);
				return;
			end
		end
	end
end

function GTFO_FindEvent(eventName)
	if (#GTFO.Events > 0) then
		for index, currentEvent in pairs(GTFO.Events) do
			if (currentEvent.Name == eventName) then
				return index;
			end
		end
	end	
	return nil;
end

function GTFO_IsInLFR()
	return IsInGroup(LE_PARTY_CATEGORY_INSTANCE);
end

function GTFO_GetSoundChannelCVar(soundChannel)
	for _, item in pairs(GTFO.SoundChannels) do
	  if (item.Code and item.Code == soundChannel) then
	    return item.CVar;
	  end
	end
	return;	
end

function GTFO_GetRealmName()
	return gsub(GetRealmName(), "%s", "");
end

function GTFO_SpellScan(spellId, spellOrigin, spellDamage)
	local test = false;
	if (GTFO.Settings.ScanMode) then
		local damage = tonumber(spellDamage) or 0;
		if (GTFO.Scans[spellId]) then
			GTFO.Scans[spellId].Times = GTFO.Scans[spellId].Times + 1;
			GTFO.Scans[spellId].Damage = GTFO.Scans[spellId].Damage + damage;
			return true;
		elseif (GTFO.IgnoreScan[spellId]) then
			-- Ignored spell
			return false;
		else
			if (GTFO.SpellID[spellId]) then 
				test = GTFO.SpellID[spellId].test or false;
				if not (test) then
					return false;
				end
			elseif (GTFO.FFSpellID[spellId]) then
				test = GTFO.FFSpellID[spellId].test or false;
				if not (test) then
					return false;
				end
			end

			GTFO.Scans[spellId] = {
				TimeAdded = GetTime();
				Times = 1;
				SpellID = spellId;
				SpellName = tostring(select(1, GTFO_GetSpellName(spellId)));
				SpellDescription = GTFO_GetSpellDescription(spellId) or "";
				SpellOrigin = tostring(spellOrigin);
				IsDebuff = (spellDamage == "DEBUFF");
				Damage = damage;
				IsTest = test;
			};
			return true;
		end
	end
	return false;
end

-- For Vanilla Classic because SpellIDs are not available
function GTFO_SpellScanName(spellName, spellOrigin, spellDamage)
	if (GTFO.Settings.ScanMode) then
		local damage = tonumber(spellDamage) or 0;
		if not (GTFO.Scans[spellName] or GTFO.SpellName[spellName] or GTFO.IgnoreScan[spellName]) then
			GTFO.Scans[spellName] = {
				TimeAdded = GetTime();
				Times = 1;
				SpellID = 0;
				SpellName = spellName;
				SpellOrigin = tostring(spellOrigin);
				IsDebuff = (spellDamage == "DEBUFF");
				Damage = damage;
			};
		elseif (GTFO.Scans[spellName]) then
			GTFO.Scans[spellName].Times = GTFO.Scans[spellName].Times + 1;
			GTFO.Scans[spellName].Damage = GTFO.Scans[spellName].Damage + damage;
		end
	end
end

function GTFO_Command_Data()
	if (next(GTFO.Scans) == nil) then
		GTFO_ErrorPrint("No scan data available.");
		return;
	end
	if (not PratCCFrame) then
		GTFO_ErrorPrint("Prat Addon is required to use this feature.");
		return;
	end

	local dataOutput = "";
	local scans = { };
	for key, data in pairs(GTFO.Scans) do
    table.insert(scans, data);
  end
  table.sort(scans, (function(a, b) return tonumber(a.TimeAdded) < tonumber(b.TimeAdded) end));
  
	for _, data in pairs(scans) do
		dataOutput = dataOutput.."-- |cff00ff00"..tostring(data.SpellName).." (x"..data.Times;

		if (data.SpellDescription == nil or data.SpellDescription == "") then
			data.SpellDescription = GTFO_GetSpellDescription(data.SpellID) or "";
		end
		
		if (data.Damage > 0) then
			dataOutput = dataOutput..", "..data.Damage
		end
		dataOutput = dataOutput..")|r\n";
		dataOutput = dataOutput.."-- |cff00aa00"..tostring(data.SpellDescription or "").."|r\n";
		dataOutput = dataOutput.."GTFO.SpellID[\""..data.SpellID.."\"] = {\n";
		dataOutput = dataOutput.."  --desc = \""..tostring(data.SpellName).." ("..tostring(data.SpellOrigin)..")\";\n";
		if (data.IsDebuff) then
			dataOutput = dataOutput.."  applicationOnly = true;\n";
		end
		if (data.IsTest) then
			dataOutput = dataOutput.."  test = true;\n";
		end
		dataOutput = dataOutput.."  sound = 1;\n";
		dataOutput = dataOutput.."};\n";
		dataOutput = dataOutput.."\n";
	end

	local display = "|cffffffff"..dataOutput.."|r"
	PratCCText:SetText("GTFO Spells");
	PratCCFrameScrollText:SetText(display);
	PratCCFrame:Show()
end

function GTFO_Command_ClearData()
	GTFO.Scans = { };
	return;
end

function GTFO_ScanSpells()
	GTFO.SpellName = { };
	for spellId, record in pairs(GTFO.SpellID) do
		local spellName = GTFO_GetSpellName(spellId);
		if (spellName or "" ~= "") then
			if (GTFO.SpellName[spellName] ~= nil) then
			GTFO_ErrorPrint("Duplicate spell "..spellName.." from ID #"..tostring(spellId));
			else
				GTFO.SpellName[spellName] = spellId;
			end
		else
			GTFO_ErrorPrint("Unknown or invalid spell ID #"..tostring(spellId));
		end
	end		
end

function GTFO_GetCurrentSoundChannelId(sSoundChannel)
	for key, option in pairs(GTFO.SoundChannels) do
		if ((sSoundChannel) == option.Code) then
			return key;
		end
	end
	return 1; -- Default
end

function GTFO_GetCurrentBrannMode(iCode)
	local code = tonumber(iCode) or 0;
	if (code == 1) then
		return GTFOLocal.BrannMode_OnWithDefault;
	elseif (code == 2) then
		return GTFOLocal.BrannMode_On;
	end
	return GTFOLocal.BrannMode_Off;
end

function GTFO_GetSpellName(spellId)
	if (C_Spell and C_Spell.GetSpellInfo) then
		local spell = C_Spell.GetSpellInfo(tonumber(spellId));
		if (spell) then
			return spell.name;
		end
	else
		return GetSpellInfo(spellId);
	end
end

function GTFO_GetSpellLink(spellId)
	if (C_Spell and C_Spell.GetSpellLink) then
		return C_Spell.GetSpellLink(spellId);
	else
		return GetSpellLink(spellId);
	end
end

function GTFO_GetSpellDescription(spellId)
	if (C_Spell and C_Spell.GetSpellDescription) then
		return C_Spell.GetSpellDescription(spellId);
	else
		return GetSpellDescription(spellId);
	end
end

function GTFO_GetSpecIndex()
	if C_SpecializationInfo and C_SpecializationInfo.GetSpecialization then
		return C_SpecializationInfo.GetSpecialization();
	elseif GetSpecialization then
		return GetSpecialization();
	end
	return nil;
end

function GTFO_GetSpecRole(spec)
	if C_SpecializationInfo and C_SpecializationInfo.GetSpecializationRole then
		return C_SpecializationInfo.GetSpecializationRole(spec);
	elseif GetSpecializationRole then
		return GetSpecializationRole(spec);
	end
	return nil;
end

-- Detect if the player is tanking or not
function GTFO_CheckTankMode()
	if (GTFO.CanTank) then
		if (GTFO.PlayerClass == "DRUID") then
			local stance = GetShapeshiftForm();
			if (stance == 1) then
				--GTFO_DebugPrint("Bear Form found - tank mode activated");
				return true;
			end
		elseif ((not (GTFO.ClassicMode or GTFO.BurningCrusadeMode or GTFO.WrathMode or GTFO.CataclysmMode)) and (GTFO.PlayerClass == "MONK" or GTFO.PlayerClass == "DEMONHUNTER" or GTFO.PlayerClass == "WARRIOR" or GTFO.PlayerClass == "DEATHKNIGHT" or GTFO.PlayerClass == "PALADIN")) then
			-- Get the exact specialization role as defined by the class
			local spec = GTFO_GetSpecIndex();
			if (spec and GTFO_GetSpecRole(spec) == "TANK") then
				--GTFO_DebugPrint("Tank spec found - tank mode activated");
				return true;
			end
		elseif ((GTFO.ClassicMode or GTFO.BurningCrusadeMode or GTFO.WrathMode or GTFO.CataclysmMode) and (GTFO.PlayerClass == "WARRIOR" or GTFO.PlayerClass == "PALADIN" or GTFO.PlayerClass == "DEATHKNIGHT")) then
			GTFO.CanTank = true;
		else
			--GTFO_DebugPrint("Failed Tank Mode - This code shouldn't have ran");
			GTFO.CanTank = nil;
		end
	end
	--GTFO_DebugPrint("Tank mode off");
	return nil;
end

function GTFO_IsTank()
	if (GTFO_CanTankCheck()) then
		if (GTFO.PlayerClass == "PALADIN") then
			-- Check for Righteous Fury (Classic)
			if (GTFO.ClassicMode or GTFO.BurningCrusadeMode or GTFO.WrathMode or GTFO.CataclysmMode) then
				return GTFO_HasBuff("player", 25780);
			end
			
			-- Backup check (removed in retail)
			if (UnitGroupRolesAssigned("player") == "TANK" or GetPartyAssignment("MAINTANK", "player")) then
				return true;
			end
		elseif (GTFO.PlayerClass == "DRUID") then
			-- Check for Bear Form
			return GTFO_HasBuff("player", 5487);
		elseif (GTFO.PlayerClass == "DEATHKNIGHT") then
			-- Check for Frost Presence (Wrath Classic)
			if (GTFO.WrathMode or GTFO.CataclysmMode) then
				return GTFO_HasBuff("player", 48263);
			end
			
			-- Backup check (removed in retail)
			if (UnitGroupRolesAssigned("player") == "TANK" or GetPartyAssignment("MAINTANK", "player")) then
				return true;
			end
		elseif (GTFO.PlayerClass == "WARRIOR" or GTFO.PlayerClass == "MONK" or GTFO.PlayerClass == "DEMONHUNTER" or GTFO.PlayerClass == "DEATHKNIGHT") then
			-- No definitive way to determine...take a guess.
			if (UnitGroupRolesAssigned("player") == "TANK" or GetPartyAssignment("MAINTANK", "player")) then
				return true;
			end
		end	
	end
	return;
end

function GTFO_CanTankCheck()
	if (GTFO.PlayerClass == "PALADIN" or GTFO.PlayerClass == "DRUID" or GTFO.PlayerClass == "DEATHKNIGHT" or GTFO.PlayerClass == "WARRIOR" or GTFO.PlayerClass == "MONK" or GTFO.PlayerClass == "DEMONHUNTER") then
		----GTFO_DebugPrint("Possible tank detected for "..target);
		return true;
	else
		----GTFO_DebugPrint("This class isn't a tank");
	end
	return;
end

function GTFO_RegisterTankEvents()
	if (GTFO.PlayerClass == "PALADIN") then
		GTFOFrame:RegisterEvent("UNIT_INVENTORY_CHANGED");
	else
		GTFOFrame:RegisterEvent("UPDATE_SHAPESHIFT_FORM");
	end
end

function GTFO.AddUnique(tTable, oItem)
	if (oItem and not tContains(tTable, oItem)) then
		tinsert(tTable, oItem);
	end
end
