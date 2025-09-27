--------------------------------------------------------------------------
-- itIT.lua 
--------------------------------------------------------------------------
--[[
GTFO Italian Localization
Translator: Asixandur
]]--

if (GetLocale() == "itIT") then
	local L = GTFOLocal;
	L.Active_Off = "Addon in pausa";
	L.Active_On = "Addon resumed"; -- Requires localization
	L.AlertType_Fail = "Fail"; -- Requires localization
	L.AlertType_FriendlyFire = "Friendly Fire"; -- Requires localization
	L.AlertType_High = "High"; -- Requires localization
	L.AlertType_Low = "Low"; -- Requires localization
	L.ClosePopup_Message = "You can configure your GTFO settings later by typing: %s"; -- Requires localization
	L.Group_None = "None"; -- Requires localization
	L.Group_NotInGroup = "You are not in a party or raid."; -- Requires localization
	L.Group_PartyMembers = "%d out of %d party members are using this addon."; -- Requires localization
	L.Group_RaidMembers = "%d out of %d raiders are using this addon."; -- Requires localization
	L.Help_Intro = "v%s (|cFFFFFFFFCommand List|r)"; -- Requires localization
	L.Help_Options = "Display options"; -- Requires localization
	L.Help_Suspend = "Suspend/Resume addon"; -- Requires localization
	L.Help_Suspended = "The addon is currently suspended."; -- Requires localization
	L.Help_TestFail = "Play a test sound (fail alert)"; -- Requires localization
	L.Help_TestFriendlyFire = "Play a test sound (friendly fire)"; -- Requires localization
	L.Help_TestHigh = "Play a test sound (high damage)"; -- Requires localization
	L.Help_TestLow = "Play a test sound (low damage)"; -- Requires localization
	L.Help_Version = "Show other raiders running this addon"; -- Requires localization
	L.Loading_Loaded = "v%s loaded."; -- Requires localization
	L.Loading_LoadedSuspended = "v%s loaded. (|cFFFF1111Suspended|r)"; -- Requires localization
	L.Loading_LoadedWithPowerAuras = "v%s loaded with Power Auras."; -- Requires localization
	L.Loading_NewDatabase = "v%s: New database version detected, resetting defaults."; -- Requires localization
	L.Loading_OutOfDate = "v%s is now available for download!  |cFFFFFFFFPlease update.|r"; -- Requires localization
	L.LoadingPopup_Message = "Your settings for GTFO have been reset to default.  Do you want to configure your settings now?"; -- Requires localization
	L.Loading_PowerAurasOutOfDate = "Your version of |cFFFFFFFFPower Auras Classic|r is out-of-date!  GTFO & Power Auras integration could not be loaded."; -- Requires localization
	L.Recount_Environmental = "Environmental"; -- Requires localization
	L.Recount_Name = "GTFO Alerts"; -- Requires localization
	L.Skada_AlertList = "GTFO Alert Types"; -- Requires localization
	L.Skada_Category = "Alerts"; -- Requires localization
	L.Skada_SpellList = "GTFO Spells"; -- Requires localization
	L.TestSound_Fail = "Test sound (fail alert) playing."; -- Requires localization
	L.TestSound_FailMuted = "Test sound (fail alert) playing. [|cFFFF4444MUTED|r]"; -- Requires localization
	L.TestSound_FriendlyFire = "Test sound (friendly fire) playing."; -- Requires localization
	L.TestSound_FriendlyFireMuted = "Test sound (friendly fire) playing. [|cFFFF4444MUTED|r]"; -- Requires localization
	L.TestSound_High = "Test sound (high damage) playing."; -- Requires localization
	L.TestSound_HighMuted = "Test sound (high damage) playing. [|cFFFF4444MUTED|r]"; -- Requires localization
	L.TestSound_Low = "Test sound (low damage) playing."; -- Requires localization
	L.TestSound_LowMuted = "Test sound (low damage) playing. [|cFFFF4444MUTED|r]"; -- Requires localization
	L.UI_Enabled = "Enabled"; -- Requires localization
	L.UI_EnabledDescription = "Enable the GTFO addon."; -- Requires localization
	L.UI_Fail = "Fail Alert sounds"; -- Requires localization
	L.UI_FailDescription = "Enable GTFO alert sounds for when you were SUPPOSED to move away -- hopefully you learn for next time!"; -- Requires localization
	L.UI_FriendlyFire = "Friendly Fire sounds"; -- Requires localization
	L.UI_FriendlyFireDescription = "Enable GTFO alert sounds for when fellow teammates are walking explosions -- one of you better move!"; -- Requires localization
	L.UI_HighDamage = "Raid/High Damage sounds"; -- Requires localization
	L.UI_HighDamageDescription = "Enable GTFO buzzer sounds for dangerous environments that you should move out of immediately."; -- Requires localization
	L.UI_LowDamage = "PvP/Environment/Low Damage sounds"; -- Requires localization
	L.UI_LowDamageDescription = "Enable GTFO boop sounds -- use your discretion whether or not to move from these low damage environments"; -- Requires localization
	L.UI_SoundChannel = "Sound Channel"; -- Requires localization
	L.UI_SoundChannelDescription = "This is the volume channel that GTFO alert sounds will attach themselves to."; -- Requires localization
	L.UI_SpecialAlerts = "Special Alerts"; -- Requires localization
	L.UI_SpecialAlertsHeader = "Activate Special Alerts"; -- Requires localization
	L.UI_Test = "Test"; -- Requires localization
	L.UI_TestDescription = "Test the sound."; -- Requires localization
	L.UI_TestMode = "Experimental/Beta Mode"; -- Requires localization
	L.UI_TestModeDescription = "Activate untested/unverified alerts (Beta/PTR)"; -- Requires localization
	L.UI_TestModeDescription2 = "Please report any issues to |cFF44FFFF%s@%s.%s|r"; -- Requires localization
	L.UI_Trivial = "Trivial content alerts"; -- Requires localization
	L.UI_TrivialDescription = "Enable alerts for low-level encounters that would otherwise be considered trivial for your character's current level."; -- Requires localization
	L.UI_TrivialDescription2 = "Set the slider to the minimum % amount of HP damage taken for alerts to not be considered trivial."; -- Requires localization
	L.UI_TrivialSlider = "Minimum % of HP"; -- Requires localization
	L.UI_Unmute = "Play sounds when muted"; -- Requires localization
	L.UI_UnmuteDescription = "If you have the master sound muted, GTFO will temporarily turn on sound briefly to play GTFO sounds."; -- Requires localization
	L.UI_UnmuteDescription2 = "This requires the master volume (and selected channel) sliders to be higher than 0%."; -- Requires localization
	L.UI_Volume = "GTFO Volume"; -- Requires localization
	L.UI_VolumeDescription = "Set the volume of the sounds playing."; -- Requires localization
	L.UI_VolumeLoud = "4: Loud"; -- Requires localization
	L.UI_VolumeLouder = "5: Loud"; -- Requires localization
	L.UI_VolumeMax = "Max"; -- Requires localization
	L.UI_VolumeMin = "Min"; -- Requires localization
	L.UI_VolumeNormal = "3: Normal (Recommended)"; -- Requires localization
	L.UI_VolumeQuiet = "1: Quiet"; -- Requires localization
	L.UI_VolumeSoft = "2: Soft"; -- Requires localization
	L.Version_Off = "Version update reminders off"; -- Requires localization
	L.Version_On = "Version update reminders on"; -- Requires localization
end
