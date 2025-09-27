--------------------------------------------------------------------------
-- ruRU.lua 
--------------------------------------------------------------------------
--[[
GTFO Russian Localization
Translator: pcki11 and D_Angel and user_kh
]]--

if (GetLocale() == "ruRU") then
	local L = GTFOLocal;
	L.Active_Off = "GTFO приостановлен";
	L.Active_On = "GTFO работает";
	L.AlertType_Fail = "Fail"; -- Requires localization
	L.AlertType_FriendlyFire = "Friendly Fire"; -- Requires localization
	L.AlertType_High = "High"; -- Requires localization
	L.AlertType_Low = "Low"; -- Requires localization
	L.ClosePopup_Message = "Вы можете настроить GTFO позже написав: %s";
	L.Group_None = "Нет";
	L.Group_NotInGroup = "Вы не входите в группу или рейд.";
	L.Group_PartyMembers = "%d из %d участников группы используют этот аддон.";
	L.Group_RaidMembers = "%d из %d участников рейда используют этот аддон.";
	L.Help_Intro = "v%s (|cFFFFFFFFСписок команд|r)";
	L.Help_Options = "Показать настройки";
	L.Help_Suspend = "Выключить/включить аддон";
	L.Help_Suspended = "Аддон приостановлен.";
	L.Help_TestFail = "Тест звука (неудача)";
	L.Help_TestFriendlyFire = "Тест звука (friendly fire)";
	L.Help_TestHigh = "Тест звука (большие повреждения)";
	L.Help_TestLow = "Тест звука (низкие повреждения)";
	L.Help_Version = "Показать участников рейда с этим аддоном.";
	L.Loading_Loaded = "v%s загружена.";
	L.Loading_LoadedSuspended = "v%s загружена. (|cFFFF1111Приостановлен|r)";
	L.Loading_LoadedWithPowerAuras = "v%s загружена вместе с Power Auras.";
	L.Loading_NewDatabase = "v%s: Обнаружена новая версия базы данных, сброс настроек.";
	L.Loading_OutOfDate = "v%s доступна для скачивания!  |cFFFFFFFFПожалуйста обновитесь.|r";
	L.LoadingPopup_Message = "Ваши настройки GTFO были сброшены на стандартные. Хотите изменить настройки сейчас?";
	L.Loading_PowerAurasOutOfDate = "Ваша версия аддона |cFFFFFFFFPower Auras Classic|r устарела! Интеграция GTFO и Power Auras не удалась.";
	L.Recount_Environmental = "Environmental"; -- Requires localization
	L.Recount_Name = "GTFO Alerts"; -- Requires localization
	L.Skada_AlertList = "GTFO Alert Types"; -- Requires localization
	L.Skada_Category = "Alerts"; -- Requires localization
	L.Skada_SpellList = "GTFO Spells"; -- Requires localization
	L.TestSound_Fail = "Тест звука (неудача) в процессе.";
	L.TestSound_FailMuted = "Тест звука (неудача) в процессе. [|cFFFF4444БЕЗ ЗВУКА|r]";
	L.TestSound_FriendlyFire = "Test sound (friendly fire) playing."; -- Requires localization
	L.TestSound_FriendlyFireMuted = "Test sound (friendly fire) playing. [|cFFFF4444MUTED|r]"; -- Requires localization
	L.TestSound_High = "Тест звука (большие повреждения) в процессе.";
	L.TestSound_HighMuted = "Тест звука (большие повреждения) в процессе. [|cFFFF4444БЕЗ ЗВУКА|r]";
	L.TestSound_Low = "Тест звука (низкие повреждения) в процессе.";
	L.TestSound_LowMuted = "Тест звука (низкие повреждения) в процессе. [|cFFFF4444БЕЗ ЗВУКА|r]";
	L.UI_Enabled = "Включен.";
	L.UI_EnabledDescription = "Включить GTFO.";
	L.UI_Fail = "Звук предупреждения о неудаче.";
	L.UI_FailDescription = "Проиграть звук в случае если вы ДОЛЖНЫ были отойти - возможно в следующий раз вы будете знать заранее.";
	L.UI_FriendlyFire = "Friendly Fire sounds"; -- Requires localization
	L.UI_FriendlyFireDescription = "Enable GTFO alert sounds for when fellow teammates are walking explosions -- one of you better move!"; -- Requires localization
	L.UI_HighDamage = "Звук рейдовых / высоких повреждений";
	L.UI_HighDamageDescription = "Включить звук напоминания выйти из опасных зон.";
	L.UI_LowDamage = "Звук в ПВП / в мире / при низких повреждениях";
	L.UI_LowDamageDescription = "Включить звук напоминания о зонах с относительно низким уроном, решайте сами покинуть их или нет.";
	L.UI_SoundChannel = "Sound Channel"; -- Requires localization
	L.UI_SoundChannelDescription = "This is the volume channel that GTFO alert sounds will attach themselves to."; -- Requires localization
	L.UI_SpecialAlerts = "Special Alerts"; -- Requires localization
	L.UI_SpecialAlertsHeader = "Activate Special Alerts"; -- Requires localization
	L.UI_Test = "Тест";
	L.UI_TestDescription = "Тест звука.";
	L.UI_TestMode = "Экспериментальный/Бета режим";
	L.UI_TestModeDescription = "Activate untested/unverified alerts (Beta/PTR)"; -- Requires localization
	L.UI_TestModeDescription2 = "Пожалуйста, сообщайте о любых проблемах на |cFF44FFFF%s@%s.%s|r";
	L.UI_Trivial = "Trivial content alerts"; -- Requires localization
	L.UI_TrivialDescription = "Enable alerts for low-level encounters that would otherwise be considered trivial for your character's current level."; -- Requires localization
	L.UI_TrivialDescription2 = "Set the slider to the minimum % amount of HP damage taken for alerts to not be considered trivial."; -- Requires localization
	L.UI_TrivialSlider = "Минимальный % HP";
	L.UI_Unmute = "Play sounds when muted"; -- Requires localization
	L.UI_UnmuteDescription = "If you have the master sound muted, GTFO will temporarily turn on sound briefly to play GTFO sounds."; -- Requires localization
	L.UI_UnmuteDescription2 = "This requires the master volume (and selected channel) sliders to be higher than 0%."; -- Requires localization
	L.UI_Volume = "Громкость GTFO";
	L.UI_VolumeDescription = "Установить громкость проигрываемых звуков.";
	L.UI_VolumeLoud = "4: громко";
	L.UI_VolumeLouder = "5: громко";
	L.UI_VolumeMax = "Максимум";
	L.UI_VolumeMin = "Минимум";
	L.UI_VolumeNormal = "3: Нормальная";
	L.UI_VolumeQuiet = "1: Тихая";
	L.UI_VolumeSoft = "2: Средняя";
	L.Version_Off = "Version update reminders off"; -- Requires localization
	L.Version_On = "Version update reminders on"; -- Requires localization
end
