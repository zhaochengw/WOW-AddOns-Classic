--------------------------------------------------------------------------
-- deDE.lua 
--------------------------------------------------------------------------
--[[
GTFO German Localization
Translator: Freydis88, GusBackus, Zaephyr81, Pas06
]]--

if (GetLocale() == "deDE") then
	local L = GTFOLocal;
	L.Active_Off = "AddOn pausiert";
	L.Active_On = "AddOn wird fortgesetzt";
	L.AlertType_Fail = "Versagt";
	L.AlertType_FriendlyFire = "Schaden durch eigene Verbündete";
	L.AlertType_High = "Hoch";
	L.AlertType_Low = "Niedrig";
	L.ClosePopup_Message = "Mit %s kannst du deine GTFO Einstellungen später ändern.";
	L.Group_None = "Keine";
	L.Group_NotInGroup = "Du bist weder in einer Gruppe, noch in einem Schlachtzug";
	L.Group_PartyMembers = "%d von %d Gruppenmitgliedern verwenden dieses Add-On";
	L.Group_RaidMembers = "%d von %d Schlachtzugmitgliedern verwenden dieses AddOn";
	L.Help_Intro = "v%s (|cFFFFFFFFBefehlsliste|r)";
	L.Help_Options = "Optionen anzeigen";
	L.Help_Suspend = "AddOn pausieren/fortsetzen";
	L.Help_Suspended = "Derzeit pausiert das AddOn.";
	L.Help_TestFail = "Tonsignal zum Testen abspielen (Warnsignal für Fehlschläge)";
	L.Help_TestFriendlyFire = "Tonsignal zum Testen abspielen (Friendly Fire)";
	L.Help_TestHigh = "Tonsignal zum Testen abspielen (hoher Schaden)";
	L.Help_TestLow = "Tonsignal zum Testen abspielen (niedriger Schaden)";
	L.Help_Version = "Andere Schlachtzugmitglieder anzeigen, die dieses AddOn aktiviert haben.";
	L.Loading_Loaded = "v%s wurde geladen.";
	L.Loading_LoadedSuspended = "v%s wurde geladen. (|cFFFF1111Pausiert|r)";
	L.Loading_LoadedWithPowerAuras = "v%s mit Power Auras wurde geladen.";
	L.Loading_NewDatabase = "v%s: Eine neue Version der Datenbank wurde gefunden; es wird auf die Standardeinstellungen zurückgesetzt.";
	L.Loading_OutOfDate = "v%s ist nun zum Herunterladen verfügbar!  |cFFFFFFFFBitte aktualisieren.|r";
	L.LoadingPopup_Message = "GTFO Einstellungen wurden zurückgesetzt. Jetzt neu konfigurieren?";
	L.Loading_PowerAurasOutOfDate = "Deine Version von |cFFFFFFFFPower Auras Classic|r ist veraltet!  GTFO & Power-Auras-Integration konnte nicht geladen werden.";
	L.Recount_Environmental = "Umgebung ";
	L.Recount_Name = "GTFO Alarme";
	L.Skada_AlertList = "GTFO Alarmtypen";
	L.Skada_Category = "Warnungen";
	L.Skada_SpellList = "GTFO Zauber";
	L.TestSound_Fail = "Tonsignal zum Testen (Warnsignal für Fehlschläge) wird abgespielt.";
	L.TestSound_FailMuted = "Tonsignal zum Testen (Warnsignal für Fehlschläge) wird abgespielt. [|cFFFF4444VERSTUMMT|r]";
	L.TestSound_FriendlyFire = "Tonsignal zum Testen (Friendly Fire) wird abgespielt.";
	L.TestSound_FriendlyFireMuted = "Tonsignal zum Testen (Friendly Fire) wird abgespielt. [|cFFFF4444VERSTUMMT|r]";
	L.TestSound_High = "Tonsignal zum Testen (hoher Schaden) wird abgespielt.";
	L.TestSound_HighMuted = "Tonsignal zum Testen (hoher Schaden) wird abgespielt. [|cFFFF4444VERSTUMMT|r]";
	L.TestSound_Low = "Tonsignal zum Testen (niedriger Schaden) wird abgespielt.";
	L.TestSound_LowMuted = "Tonsignal zum Testen (niedriger Schaden) wird abgespielt. [|cFFFF4444VERSTUMMT|r]";
	L.UI_Enabled = "Aktiviert";
	L.UI_EnabledDescription = "GTFO-Add-On aktivieren";
	L.UI_Fail = "Warnsignale für Fehlschläge";
	L.UI_FailDescription = "GTFO-Warnsignale für den Fall, dass du dich nicht wegbewegt hast, aktivieren -- hoffentlich lernst du es für das nächste Mal!";
	L.UI_FriendlyFire = "Friendly Fire Tonsignale";
	L.UI_FriendlyFireDescription = "GTFO Alarmsignale für den Fall, dass Gruppenmitglieder wandelnde Bomben sind, aktivieren -- einer von euch sollte sich bewegen!";
	L.UI_HighDamage = "Tonsignale für Schlachtzug/hoher Schaden";
	L.UI_HighDamageDescription = "GTFO-Summer-Tonsignale für gefährliche Umgebungen, aus denen du sofort verschwinden solltest, aktivieren.";
	L.UI_LowDamage = "Tonsignale für PvP/Umgebung/niedriger Schaden";
	L.UI_LowDamageDescription = "GTFO-Deppen-Tonsignale aktivieren -- entscheide nach deinem Ermessen, ob du aus diesen Umgebungen mit niedrigem Schaden verschwindest oder nicht.";
	L.UI_SoundChannel = "Soundkanal";
	L.UI_SoundChannelDescription = "This is the volume channel that GTFO alert sounds will attach themselves to."; -- Requires localization
	L.UI_SpecialAlerts = "Spezielle Alarme";
	L.UI_SpecialAlertsHeader = "Aktiviere spezielle Alarme";
	L.UI_Test = "Test";
	L.UI_TestDescription = "Tonsignale testen.";
	L.UI_TestMode = "Experimenteller/Beta Modus";
	L.UI_TestModeDescription = "Aktiviert ungetestete/ungeprüfte Warnungen. (Beta/PTR)";
	L.UI_TestModeDescription2 = "Meldet Probleme bitte an |cFF44FFFF%s@%s.%s|r";
	L.UI_Trivial = "Warnsignale für belanglose Begegnungen";
	L.UI_TrivialDescription = "Aktiviert Tonsignale für niedrigstufige Gegner, welche dir auf deinem Level nicht ernsthaft schaden.";
	L.UI_TrivialDescription2 = "Ziehe den Schieberegler, um die Schwelle für den minimalen prozentualen Anteil des erlittenen Schadens an den Lebenspunkten einzustellen, ab dem Alarme nicht mehr als geringfügig betrachtet werden.";
	L.UI_TrivialSlider = "Minimum % der Lebenspunkte";
	L.UI_Unmute = "Tonsignale abspielen, wenn stummgeschaltet";
	L.UI_UnmuteDescription = "Falls Du die allgemeine Tonausgabe oder die Sound-Effekte stummgeschaltet haben solltest, aktiviert GTFO vorübergehend die Audiosignale, um ausschließlich jene von GTFO abzuspielen.";
	L.UI_UnmuteDescription2 = "Dies erfordert, dass die Gesamtlautstärle höher als 0% sein muss.";
	L.UI_Volume = "GTFO-Lautstärke";
	L.UI_VolumeDescription = "Audiolautstärke einstellen.";
	L.UI_VolumeLoud = "4: Laut";
	L.UI_VolumeLouder = "5: Laut";
	L.UI_VolumeMax = "Max. ";
	L.UI_VolumeMin = "Min. ";
	L.UI_VolumeNormal = "3: Normal (wird empfohlen)";
	L.UI_VolumeQuiet = "1: Still";
	L.UI_VolumeSoft = "2: Leise";
	L.Version_Off = "Aktualisierungshinweise aus";
	L.Version_On = "Aktualisierungshinweise an";
end
