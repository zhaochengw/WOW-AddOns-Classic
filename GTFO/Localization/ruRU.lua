--------------------------------------------------------------------------
-- ruRU.lua 
--------------------------------------------------------------------------
--[[
GTFO Russian Localization
Translator: pcki11 and D_Angel and user_kh
]]--

if (GetLocale() == "ruRU") then

GTFOLocal = 
{
	Active_Off = "GTFO приостановлен",
	Active_On = "GTFO работает",
	AlertType_Fail = "Fail", -- Requires localization
	AlertType_FriendlyFire = "Friendly Fire", -- Requires localization
	AlertType_High = "High", -- Requires localization
	AlertType_Low = "Low", -- Requires localization
	ClosePopup_Message = "Вы можете настроить GTFO позже написав: %s",
	Group_None = "Нет",
	Group_NotInGroup = "Вы не входите в группу или рейд.",
	Group_PartyMembers = "%d из %d участников группы используют этот аддон.",
	Group_RaidMembers = "%d из %d участников рейда используют этот аддон.",
	Help_Intro = "v%s (|cFFFFFFFFСписок команд|r)",
	Help_Options = "Показать настройки",
	Help_Suspend = "Выключить/включить аддон",
	Help_Suspended = "Аддон приостановлен.",
	Help_TestFail = "Тест звука (неудача)",
	Help_TestFriendlyFire = "Тест звука (friendly fire)",
	Help_TestHigh = "Тест звука (большие повреждения)",
	Help_TestLow = "Тест звука (низкие повреждения)",
	Help_Version = "Показать участников рейда с этим аддоном.",
	Loading_Loaded = "v%s загружена.",
	Loading_LoadedSuspended = "v%s загружена. (|cFFFF1111Приостановлен|r)",
	Loading_LoadedWithPowerAuras = "v%s загружена вместе с Power Auras.",
	Loading_NewDatabase = "v%s: Обнаружена новая версия базы данных, сброс настроек.",
	Loading_OutOfDate = "v%s доступна для скачивания!  |cFFFFFFFFПожалуйста обновитесь.|r",
	LoadingPopup_Message = "Ваши настройки GTFO были сброшены на стандартные. Хотите изменить настройки сейчас?",
	Loading_PowerAurasOutOfDate = "Ваша версия аддона |cFFFFFFFFPower Auras Classic|r устарела! Интеграция GTFO и Power Auras не удалась.",
	Recount_Environmental = "Environmental", -- Requires localization
	Recount_Name = "GTFO Alerts", -- Requires localization
	Skada_AlertList = "GTFO Alert Types", -- Requires localization
	Skada_Category = "Alerts", -- Requires localization
	Skada_SpellList = "GTFO Spells", -- Requires localization
	TestSound_Fail = "Тест звука (неудача) в процессе.",
	TestSound_FailMuted = "Тест звука (неудача) в процессе. [|cFFFF4444БЕЗ ЗВУКА|r]",
	TestSound_FriendlyFire = "Test sound (friendly fire) playing.", -- Requires localization
	TestSound_FriendlyFireMuted = "Test sound (friendly fire) playing. [|cFFFF4444MUTED|r]", -- Requires localization
	TestSound_High = "Тест звука (большие повреждения) в процессе.",
	TestSound_HighMuted = "Тест звука (большие повреждения) в процессе. [|cFFFF4444БЕЗ ЗВУКА|r]",
	TestSound_Low = "Тест звука (низкие повреждения) в процессе.",
	TestSound_LowMuted = "Тест звука (низкие повреждения) в процессе. [|cFFFF4444БЕЗ ЗВУКА|r]",
	UI_Enabled = "Включен.",
	UI_EnabledDescription = "Включить GTFO.",
	UI_Fail = "Звук предупреждения о неудаче.",
	UI_FailDescription = "Проиграть звук в случае если вы ДОЛЖНЫ были отойти - возможно в следующий раз вы будете знать заранее.",
	UI_FriendlyFire = "Friendly Fire sounds", -- Requires localization
	UI_FriendlyFireDescription = "Enable GTFO alert sounds for when fellow teammates are walking explosions -- one of you better move!", -- Requires localization
	UI_HighDamage = "Звук рейдовых / высоких повреждений",
	UI_HighDamageDescription = "Включить звук напоминания выйти из опасных зон.",
	UI_LowDamage = "Звук в ПВП / в мире / при низких повреждениях",
	UI_LowDamageDescription = "Включить звук напоминания о зонах с относительно низким уроном, решайте сами покинуть их или нет.",
	UI_SoundChannel = "Sound Channel", -- Requires localization
	UI_SoundChannelDescription = "This is the volume channel that GTFO alert sounds will attach themselves to.", -- Requires localization
	UI_SpecialAlerts = "Special Alerts", -- Requires localization
	UI_SpecialAlertsHeader = "Activate Special Alerts", -- Requires localization
	UI_Test = "Тест",
	UI_TestDescription = "Тест звука.",
	UI_TestMode = "Экспериментальный/Бета режим",
	UI_TestModeDescription = "Activate untested/unverified alerts (Beta/PTR)", -- Requires localization
	UI_TestModeDescription2 = "Пожалуйста, сообщайте о любых проблемах на |cFF44FFFF%s@%s.%s|r",
	UI_Trivial = "Trivial content alerts", -- Requires localization
	UI_TrivialDescription = "Enable alerts for low-level encounters that would otherwise be considered trivial for your character's current level.", -- Requires localization
	UI_TrivialDescription2 = "Set the slider to the minimum % amount of HP damage taken for alerts to not be considered trivial.", -- Requires localization
	UI_TrivialSlider = "Минимальный % HP",
	UI_Unmute = "Play sounds when muted", -- Requires localization
	UI_UnmuteDescription = "If you have the master sound muted, GTFO will temporarily turn on sound briefly to play GTFO sounds.", -- Requires localization
	UI_UnmuteDescription2 = "This requires the master volume (and selected channel) sliders to be higher than 0%.", -- Requires localization
	UI_Volume = "Громкость GTFO",
	UI_VolumeDescription = "Установить громкость проигрываемых звуков.",
	UI_VolumeLoud = "4: громко",
	UI_VolumeLouder = "5: громко",
	UI_VolumeMax = "Максимум",
	UI_VolumeMin = "Минимум",
	UI_VolumeNormal = "3: Нормальная",
	UI_VolumeQuiet = "1: Тихая",
	UI_VolumeSoft = "2: Средняя",
	Version_Off = "Version update reminders off", -- Requires localization
	Version_On = "Version update reminders on", -- Requires localization
}

end
