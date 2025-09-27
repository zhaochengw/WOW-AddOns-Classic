--------------------------------------------------------------------------
-- esES.lua 
--------------------------------------------------------------------------
--[[
GTFO Spanish Localization
Translator: Pablous
]]--

if (GetLocale() == "esES") then
	local L = GTFOLocal;
	L.Active_Off = "Addon desactivado";
	L.Active_On = "Addon activado";
	L.AlertType_Fail = "Fallo";
	L.AlertType_FriendlyFire = "Fuego Amigo";
	L.AlertType_High = "Alto";
	L.AlertType_Low = "Bajo";
	L.ClosePopup_Message = "Puedes configurar el GTFO mas tarde, escribiendo: %s";
	L.Group_None = "Nadie";
	L.Group_NotInGroup = "No estas en un grupo o raid.";
	L.Group_PartyMembers = "%d def %d personas del grupo utilizan este addon.";
	L.Group_RaidMembers = "%d de %d personas de la raid utilizan este addon.";
	L.Help_Intro = "v%s (|cFFFFFFFFCommand List|r)";
	L.Help_Options = "Opciones de visualizacion";
	L.Help_Suspend = "Desactivar/Activar addon";
	L.Help_Suspended = "El addon se encuentra desactivado.";
	L.Help_TestFail = "Reproducir un sonido de prueba (alerta de fallo)";
	L.Help_TestFriendlyFire = "Reproduce un sonido de prueba (fuego amigo)";
	L.Help_TestHigh = "Reproducir un sonido de prueba (daño alto)";
	L.Help_TestLow = "Reproducir un sonido de prueba (daño bajo)";
	L.Help_Version = "Mostrar otras personas que tengan este addon";
	L.Loading_Loaded = "v%s cargado.";
	L.Loading_LoadedSuspended = "v%s cargado. (|cFFFF1111Suspended|r)";
	L.Loading_LoadedWithPowerAuras = "v%s cargado con Power Auras.";
	L.Loading_NewDatabase = "v%s: Nueva base de datos detectada, restableciendo por defecto.";
	L.Loading_OutOfDate = "¡v%s esta disponible para descargar!  |cFFFFFFFFPlease update.|r";
	L.LoadingPopup_Message = "Tu configuracion del GTFO se ha restablecido. ¿Deseas configurarlo ahora?";
	L.Loading_PowerAurasOutOfDate = "¡Tu version de |cFFFFFFFFPower Auras Classic|r es antigua!  La integracion de GTFO & Power Auras no puede ser cargada.";
	L.Recount_Environmental = "Zona";
	L.Recount_Name = "Alertas del GTFO";
	L.Skada_AlertList = "GTFO Alert Types"; -- Requires localization
	L.Skada_Category = "Alerts"; -- Requires localization
	L.Skada_SpellList = "GTFO Spells"; -- Requires localization
	L.TestSound_Fail = "Reproduciendo sonido de prueba (alerta de fallo)";
	L.TestSound_FailMuted = "Reproduciendo sonido de prueba (alerta de fallo). [|cFFFF4444MUTED|r]";
	L.TestSound_FriendlyFire = "Reproduciendo sonido de prueba (fuego amigo).";
	L.TestSound_FriendlyFireMuted = "Reproduciendo sonido de prueba (fuego amigo). [|cFFFF4444MUTED|r]";
	L.TestSound_High = "Reproduciendo sonido de prueba (daño alto).";
	L.TestSound_HighMuted = "Reproduciendo sonido de prueba (daño alto). [|cFFFF4444MUTED|r]";
	L.TestSound_Low = "Reproduciendo sonido de prueba (daño bajo).";
	L.TestSound_LowMuted = "Reproduciendo sonido de prueba (daño bajo). [|cFFFF4444MUTED|r]";
	L.UI_Enabled = "Activado";
	L.UI_EnabledDescription = "Activa el addon GTFO";
	L.UI_Fail = "Sonido de Alerta de Fallo";
	L.UI_FailDescription = "Activa el sonido de alerta de GTFO cuando se SUPONIA que debias moverte -- ¡Espero que lo hayas aprendido para la proxima!";
	L.UI_FriendlyFire = "Sonidos de Fuego Amigo";
	L.UI_FriendlyFireDescription = "Activa el sonido de alerta de GTFO cuando un compañero te daña -- ¡Que alguien se aleje!";
	L.UI_HighDamage = "Sonido de Raid/Daño Alto";
	L.UI_HighDamageDescription = "Activa el sonido del GTFO para zonas peligrosas donde deberias moverte inmediatamente.";
	L.UI_LowDamage = "Sonidos de JcJ/Zona/Daño Bajo";
	L.UI_LowDamageDescription = "Activa el sonido del GTFO -- Muevete con discrecion de la zona de poco daño.";
	L.UI_SoundChannel = "Sound Channel"; -- Requires localization
	L.UI_SoundChannelDescription = "This is the volume channel that GTFO alert sounds will attach themselves to."; -- Requires localization
	L.UI_SpecialAlerts = "Special Alerts"; -- Requires localization
	L.UI_SpecialAlertsHeader = "Activate Special Alerts"; -- Requires localization
	L.UI_Test = "Prueba";
	L.UI_TestDescription = "Prueba el sonido.";
	L.UI_TestMode = "Modo Beta/Experimental";
	L.UI_TestModeDescription = "Activar alertas sin probar/verificar (Beta/PTR)";
	L.UI_TestModeDescription2 = "Por favor informa de cualquier problema a |cFF44FFFF%s@%s.%s|r";
	L.UI_Trivial = "Alertas de contenido trivial";
	L.UI_TrivialDescription = "Activa alertas para encuentros de bajo nivel que podrian ser triviales para un personaje de tu nivel.";
	L.UI_TrivialDescription2 = "Set the slider to the minimum % amount of HP damage taken for alerts to not be considered trivial."; -- Requires localization
	L.UI_TrivialSlider = "Minimum % of HP"; -- Requires localization
	L.UI_Unmute = "Reproducir sonidos cuando esta en silencio";
	L.UI_UnmuteDescription = "Si has silenciado todos los sonidos, o los efectos de sonido, GTFO activará temporalmente los sonidos para reproducir las alertas.";
	L.UI_UnmuteDescription2 = "Requiere que las barras de volumen esten a mas del 0%";
	L.UI_Volume = "Volumen del GTFO";
	L.UI_VolumeDescription = "Configura el volumen de los sonidos.";
	L.UI_VolumeLoud = "4: Alto";
	L.UI_VolumeLouder = "5: Alto";
	L.UI_VolumeMax = "Maximo";
	L.UI_VolumeMin = "Minimo";
	L.UI_VolumeNormal = "3: Normal (Recomendado)";
	L.UI_VolumeQuiet = "1: Silencio";
	L.UI_VolumeSoft = "2: Bajo";
	L.Version_Off = "Version update reminders off"; -- Requires localization
	L.Version_On = "Version update reminders on"; -- Requires localization
end
