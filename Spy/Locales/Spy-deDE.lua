local L = LibStub("AceLocale-3.0"):NewLocale("Spy", "deDE")
if not L then return end
-- TOC Note: Detektiert und warnt Sie vor, in der Nähe befindlichen, Gegnern.

-- Configuration
L["Spy"] = "Spy"
L["Version"] = "Version"
L["Spy Option"] = "Spy"
L["Profiles"] = "Profile"

-- About
L["About"] = "Info"
L["SpyDescription1"] = [[
Spy ist ein Addon, das Sie über das Vorhandensein von, in der Nähe befindlichen, feindlichen Spielern benachrichtigt. Dies sind einige der Hauptmerkmale

]]

L["SpyDescription2"] = [[
|cffffd000 In der Nähe-Liste |cffffffff
Die "In der Nähe"-Liste zeigt alle feindlichen Spieler, die in der Nähe entdeckt wurden.  Spieler, die für eine gewisse Zeit nicht erkannt wurden, werden aus der Liste entfernt.

|cffffd000 Letzte Stunde-Liste |cffffffff
Zeigt alle Feinde, die in der letzten Stunde erkannt wurden.

|cffffd000 Ignorierliste |cffffffff
Spieler, die der Ignorierliste hinzugefügt werden, werden nicht vom Spy gemeldet. Mithilfe des Dropdown-Menüs der Schaltfläche oder Halten der STRG-Taste beim Klicken auf die Schaltfläche können Sie Spieler zu der Liste hinzufügen oder entfernen.

|cffffd000 Bei Sichtkontakt zu Töten-Liste |cffffffff
Wird ein Spieler der "Bei Sichtkontakt zu Töten"-Liste erkannt, erklingt ein Alarm. Mithilfe des Dropdown-Menüs der Schaltfläche oder Halten der STRG-Taste beim Klicken auf die Schaltfläche können Sie Spieler zu der Liste hinzufügen oder entfernen. Ausserdem können Sie mithilfe des Dropdown-Menüs die Gründe hinterlegen, warum Sie jemanden zu der "Bei Sichtkontakt zu Töten"-Liste hinzugefügt haben. Möchten Sie einen nicht in der Liste hinterlegten Grund eingeben, verwenden Sie "Geben Sie Ihren eigenen Grund..." in der anderen Liste.

]]

L["SpyDescription3"] = [[
|cffffd000 Statistics Window |cffffffff
The Statistics Window contains a list of all enemy encounters which can be sorted by name, level, guild, wins, losses and the last time an enemy was detected. It also provides the ability to search for a specific enemy by name or guild and has filters to show only enemies that are marked as Kill on Sight, with a Win/Loss or entered Reasons.

|cffffd000 Kill On Sight Button |cffffffff
If enabled, this button will be located on the enemy players target frame. Clicking on this button will add/remove the enemy target to/from the Kill On Sight list. Right clicking on the button will allow you to enter Kill on Sight reasons.

|cffffd000 Autor:|cffffffff Slipjack
]]

-- General Settings
L["GeneralSettings"] = "Allgemeine Einstellungen"
L["GeneralSettingsDescription"] = [[
Optionen für die Aktivierung oder Deaktivierung von Spy.
]] 
L["EnableSpy"] = "Aktiviert Spy"
L["EnableSpyDescription"] = "Aktiviert oder deaktiviert Spy."
L["EnabledInBattlegrounds"] = "Aktiviert Spy in Schlachtfeldern"
L["EnabledInBattlegroundsDescription"] = "Aktiviert oder deaktiviert Spy, wenn Sie in einer Arena sind."
L["EnabledInArenas"] = "Aktiviert Spy in Arenen"
L["EnabledInArenasDescription"] = "Aktiviert oder deaktiviert Spy, wenn Sie in einer Arena sind."
L["EnabledInWintergrasp"] = "Aktiviert Spy in Kampfgebieten der Welt"
L["EnabledInWintergraspDescription"] = "Aktiviert oder deaktiviert Spy, wenn Sie in Kampfgebieten der Welt, wie z.B. Wintergrasp in Northrend, sind."
L["DisableWhenPVPUnflagged"] = "Deaktiviert Spy, wenn PVP nicht eingeschaltet ist"
L["DisableWhenPVPUnflaggedDescription"] = "Aktiviert oder deaktiviert Spy, abhängig von Ihrem PVP-Status."
L["DisabledInZones"] = "Disable Spy while in these locations"
L["DisabledInZonesDescription"]	= "Selecet locations where Spy will be disabled"
L["Booty Bay"] = "Beutebucht"
L["Everlook"] = "Ewige Warte"						
L["Gadgetzan"] = "Gadgetzan"
L["Ratchet"] = "Ratschet"
L["The Salty Sailor Tavern"] = "Taverne \"Zum Salzigen Seemann\""
L["Shattrath City"] = "Shattrath"
L["Area 52"] = "Area 52"
L["Dalaran"] = "Dalaran"
L["Dalaran (Northrend)"] = "Dalaran (Nordend)"
L["Bogpaddle"] = "Kraulsumpf"
L["The Vindicaar"] = "Die Vindikaar" 
L["Krasus' Landing"] = "Krasus' Landeplatz"
L["The Violet Gate"] = "Das Violette Tor"
L["Magni's Encampment"] = "Magnis Lager"
L["Silithus"] = "Silithus"
L["Chamber of Heart"] = "Die Herzkammer"
L["Hall of Ancient Paths"] = "Halle der Uralten Pfade"
L["Sanctum of the Sages"] = "Das Sanktum der Weisen"
L["Rustbolt"] = "Rostbolzen"
L["Oribos"] = "Oribos"
L["Valdrakken"] = "Valdrakken"

-- Display
L["DisplayOptions"] = "Anzeigen"
L["DisplayOptionsDescription"] = [[
Optionen für das Spy-Fenster und QuickInfos.
]]
L["ShowOnDetection"] = "Blendet Spy ein, wenn feindliche Spieler erkannt werden"
L["ShowOnDetectionDescription"] = "Wählen Sie diese Einstellung, um das Spy-Fenster und In der Nähe-Liste anzuzeigen, wenn Spy verborgen ist und feindliche Spieler erkannt werden."
L["HideSpy"] = "Spy ausblenden, wenn keine feindlichen Spieler erkannt werden"
L["HideSpyDescription"] = "Wählen Sie diese Einstellung, um Spy auszublenden, wenn die In der Nähe-Liste angezeigt wird und leer wird. Spy wird nicht ausgeblendet, wenn Sie die Liste manuell löschen."
L["ShowOnlyPvPFlagged"] = "Zeige nur gegnerische Spieler, die im PvP-Modus sind"
L["ShowOnlyPvPFlaggedDescription"] = "Wählen Sie diese Einstellung, um nur die gegnerischen Spieler der In der Nähe-Liste anzuzeigen, die im PvP-Modus sind."
L["ShowKoSButton"] = "Zeigen Sie die Schaltfläche bei Sichtkontakt töten auf dem feindlichen Zielrahmen"
L["ShowKoSButtonDescription"] = "Stellen Sie dies ein, um die Schaltfläche bei Sichtkontakt töten im Zielrahman des Feindes anzuzeigen."
L["Alpha"] = "Transparenz"
L["AlphaDescription"] = "Stellen Sie die Transparenz des SPY-Fensters ein."
L["AlphaBG"] = "Transparenz auf Schlachtfeldern"
L["AlphaBGDescription"] = "Stellen Sie die Transparenz des SPY-Fensters auf Schlachtfeldern ein."
L["LockSpy"] = "Sperrt das Spy-Fenster"
L["LockSpyDescription"] = "Fixiert das Spy-Fenster an einem Ort, so dass es sich nicht bewegt."
L["ClampToScreen"] = "Auf dem Bildschirm halten"
L["ClampToScreenDescription"] = "Kontrolliert, ob das Spy-Fenster über die Bildschirmkanten hinaus verschoben werden kann."
L["InvertSpy"] = "Dreht das Spy-Fenster um"
L["InvertSpyDescription"] = "Kippt das Spy-Fenster verkehrt herum."
L["Reload"] = "Neu laden UI"
L["ReloadDescription"] = "Erforderlich beim Wechseln des SPY-Fenster."
L["ResizeSpy"] = "Adaptiert die Größe des Spy-Fensters automatisch."
L["ResizeSpyDescription"] = "Wählen Sie diese Einstellung, um die Größe des Spy-Fensters automatisch anzupassen, wenn feindliche Spieler hinzugefügt oder entfernt werden."
L["ResizeSpyLimit"] = "Listenlimit"
L["ResizeSpyLimitDescription"] = "Begrenzen Sie die Anzahl der im Spy-Fenster angezeigten gegnerischen Spieler."
L["DisplayTooltipNearSpyWindow"] = "Tooltip in der Nähe des Spy-Fensters anzeigen"
L["DisplayTooltipNearSpyWindowDescription"] = "Stellen Sie dies ein, um Tooltips in der Nähe des Spy-Fensters anzuzeigen."
L["SelectTooltipAnchor"] = "Tooltip-Ankerpunkt"
L["SelectTooltipAnchorDescription"] = "Wählen Sie den Ankerpunkt für den Tooltip aus, wenn die obige Option aktiviert wurde."
L["ANCHOR_CURSOR"] = "Mauszeiger"
L["ANCHOR_TOP"] = "Oben"
L["ANCHOR_BOTTOM"] = "Unterseite"
L["ANCHOR_LEFT"] = "Links"			
L["ANCHOR_RIGHT"] = "Rechts"
L["TooltipDisplayWinLoss"] = "Zeigt die Gewinn/Verlust-Statistik im Tooltip an."
L["TooltipDisplayWinLossDescription"] = "Wählen Sie diese Einstellung, um die Gewinn/Verlust-Statistik eines Spielers in dessen QuickInfo anzuzeigen."
L["TooltipDisplayKOSReason"] = "Zeigt die Gründe für das Töten bei Sichtkontakt im Tooltip an."
L["TooltipDisplayKOSReasonDescription"] = "Wählen Sie diese Einstellung, um die Gründe für das Töten eines Spielers bei Sichtkontakt in der QuickInfo des Spielers anzuzeigen."
L["TooltipDisplayLastSeen"] = "Zeigt die zuletzt angesehenen Details in der QuickInfo an."
L["TooltipDisplayLastSeenDescription"] = "Wählen Sie diese Einstellung, um die letzte bekannte Zeit und den letzten bekannten Ort eines Spielers in der QuickInfo des Spielers anzuzeigen."
L["DisplayListData"] = "Wählen Sie die anzuzeigenden feindlichen Daten aus"
L["Name"] = "Name"
L["Class"] = "Klasse"
L["Rank"] = "Rang"
L["SelectFont"] = "Wählen Sie eine Schriftart"
L["SelectFontDescription"] = "Wählen Sie eine Schriftart für das Spy-Fenster."
L["RowHeight"] = "Wählen Sie die Zeilenhöhe aus"
L["RowHeightDescription"] = "Wählen Sie die Zeilenhöhe für das Spy-Fenster aus."
L["Texture"] = "Textur"
L["TextureDescription"] = "Wählen Sie eine Textur für das SPY-Fenster"
 
-- Alerts
L["AlertOptions"] = "Warnungen"
L["AlertOptionsDescription"] = [[
Optionen für Warnungen, Ankündigungen und Warnungen, wenn feindliche Spieler erkannt werden.
]]
L["SoundChannel"] = "Wählen Sie Tonkanal"
L["Master"] = "Gesamt"
L["SFX"] = "Effekte"
L["Music"] = "Musik"
L["Ambience"] = "Umgebung"
L["Announce"] = "Ankündigungen senden an:"
L["None"] = "Nichts"
L["NoneDescription"] = "Melde nichts, wenn feindliche Spieler erkannt werden."
L["Self"] = "Selbst"
L["SelfDescription"] = "Melde dir selbst, wenn feindliche Spieler erkannt werden."
L["Party"] = "Gruppe"
L["PartyDescription"] = "Melde deiner Gruppe, wenn feindliche Spieler erkannt werden."
L["Guild"] = "Gilde"
L["GuildDescription"] = "Melde deiner Gilde, wenn feindliche Spieler erkannt werden."
L["Raid"] = "Angriff"
L["RaidDescription"] = "Melde deiner Raid, wenn feindliche Spieler erkannt werden."
L["LocalDefense"] = "Lokale Verteidigung"
L["LocalDefenseDescription"] = "Gebe dem lokalen Verteidigungskanal bekannt, wenn feindliche Spieler erkannt werden."
L["OnlyAnnounceKoS"] = "Gebe nur Gegner bekannt, die bei Sichtkontakt zu töten sind"
L["OnlyAnnounceKoSDescription"] = "Wählen Sie diese Einstellung, um nur die gegnerischen Spielern bekannt zu geben, die auf Ihrer Bei Sichtkontakt zu Töten-Liste sind."
L["WarnOnStealth"] = "Warnt, wenn Tarnungen erkannt werden"
L["WarnOnStealthDescription"] = "Wählen Sie diese Einstellung, um eine Warnung und einen Alarmton wiederzugeben, wenn ein feindlicher Spieler sich tarnt."
L["WarnOnKOS"] = "Warnt bei Erkennung eines Töten bei Sichtkontakts."
L["WarnOnKOSDescription"] = "Wählen Sie diese Einstellung, um eine Warnung und einen Alarmton wiederzugeben, wenn ein feindlicher Spieler von Ihrer Bei Sichtkontakt zu Töten-Liste erkannt wird"
L["WarnOnKOSGuild"] = "Warnt bei Erkennung einer Gilde der Bei Sichtkontakt zu Töten-Liste"
L["WarnOnKOSGuildDescription"] = "Wählen Sie diese Einstellung, um eine Warnung und einen Alarmton wiederzugeben, wenn ein feindlicher Spieler der gleichen Gilde wie jemand auf Ihrer Bei Sichtkontakt zu Töten-Liste erkannt wird."
L["WarnOnRace"] = "Warnt bei Erkennung einer Rasse"
L["WarnOnRaceDescription"] = "Wählen Sie diese Einstellung, um einen Alarmton wiederzugeben, wenn die ausgewählte Rasse detektiert wurde"
L["SelectWarnRace"] = "Wähle die Rasse, welche detektiert werden soll."
L["SelectWarnRaceDescription"] = "Wählen Sie eine Rasse, welche mittels akustischen Alarm angezeigt werden soll."
L["WarnRaceNote"] = "Hinweis: Sie müssen den Feind mindestens einmal ins Visier genommen haben, damit dessen Rasse in die Datenbank aufgenommen werden kann. Bei der nächsten Detektion ertönt ein Alarm. Das funktioniert nicht genauso, wie die Detektion von kämpfenden Gegnern in der Nähe."
L["DisplayWarningsInErrorsFrame"] = "Zeigt Warnungen im Fehler-Fenster an."
L["DisplayWarningsInErrorsFrameDescription"] = "Wählen Sie diese Einstellung, um eine Warnung wiederzugeben, anstatt grafische Popup-Frames anzuzeigen."
L["DisplayWarnings"] = "Wählen Sie den Speicherort der Warnmeldung"
L["Default"] = "Standard"
L["ErrorFrame"] = "Fehlerrahmen"
L["Moveable"] = "Beweglich"
L["EnableSound"] = "Aktiviert akustische Warnungen."
L["EnableSoundDescription"] = "Wählen Sie diese Einstellung, um akustische Warnungen zu aktivieren, wenn feindliche Spieler erkannt werden. Es erklingen unterschiedliche Warnungen, wenn ein feindlicher Spieler sich tarnt oder wenn ein feindlicher Spieler auf deiner Bei Sichtkontakt zu Töten-Liste ist."
L["OnlySoundKoS"] = "Es ertönen nur akustische Alarme fuer die Bei Sichtkontakt zu Töten-Liste"
L["OnlySoundKoSDescription"] = "Wählen Sie diese Einstellung, so dass nur akustische Warnungen ertönen, wenn feindliche Spieler von der Bei Sichtkontakt zu Töten-Liste erkannt werden."
L["StopAlertsOnTaxi"] = "Deaktivieren Sie Warnungen, während Sie sich auf einer Flugroute befinden"
L["StopAlertsOnTaxiDescription"] = "Stoppen Sie alle neuen Alarme und Warnungen, während Sie sich auf einer Flugroute befinden."
 
-- Nearby List
L["ListOptions"] = "In der Nähe-Liste"
L["ListOptionsDescription"] = [[
Optionen, wie feindliche Spieler hinzugefügt und entfernt werden.
]]
L["RemoveUndetected"] = "Entfernt feindliche Spieler aus der In der Nähe-Liste nach:"
L["1Min"] = "1 Minute"
L["1MinDescription"] = "Entfernt einen feindlichen Spieler, der seit über 1 Minute unentdeckt geblieben ist."
L["2Min"] = "2 Minuten"
L["2MinDescription"] = "Entfernt einen feindlichen Spieler, der seit über 2 Minuten unentdeckt geblieben ist."
L["5 Minuten"] = "5 Minuten"
L["5MinDescription"] = "Entfernt einen feindlichen Spieler, der seit über 5 Minuten unentdeckt geblieben ist."
L["10Min"] = "10 Minuten"
L["10MinDescription"] = "Entfernt einen feindlichen Spieler, der seit über 10 Minuten unentdeckt geblieben ist."
L["15Min"] = "15 Minuten"
L["15MinDescription"] = "Entfernt einen feindlichen Spieler, der seit über 15 Minuten unentdeckt geblieben ist."
L["Never"] = "Niemals entfernen"
L["NeverDescription"] = "Entfernt niemals feindliche Spieler. Die In der Nähe-Liste kann weiterhin manuell gelöscht werden."
L["ShowNearbyList"] = "Wechselt auf die In der Nähe-Liste bei Entdeckung feindlicher Spieler."
L["ShowNearbyListDescription"] = "Stellen Sie hier die Anzeige der In der Nähe-Liste ein, wenn sie nicht bereits bei Entdeckung feindlicher Spieler sichtbar ist."
L["PrioritiseKoS"] = "Priorisiere feindliche Spieler auf der In der Nähe-Liste, die sofort getötet werden sollen."
L["PrioritiseKoSDescription"] = "Stellen Sie hier ein, das feindliche Spieler, die sofort getötet werden sollen, immer zuerst  auf der In der Nähe-Liste erscheinen."
 
-- Map
L["MapOptions"] = "Karte"
L["MapOptionsDescription"] = [[
Optionen für Weltkarte und Minikarte, einschließlich Symbole und QuickInfos.
]]
L["MinimapDetection"] = "Aktiviere Minikarte Entdeckung"
L["MinimapDetectionDescription"] = "Wenn Sie den Mauszeiger über bekannte feindliche Spieler bewegen, die auf der Minikarte gefunden wurden, werden diese zur Nähe-Liste hinzugefügt."
L["MinimapNote"] = "          Hinweis: Funktioniert nur für Spieler, die Humanoide verfolgen können."
L["MinimapDetails"] = "Zeige die Details der Level/Klassen in QuickInfos an."
L["MinimapDetailsDescription"] = "Aktualisieren Sie hier die QuickInfo der Karte, sodass die Details der Level/Klassen neben feindlichen Namen angezeigt werden."
L["DisplayOnMap"] = "Symbole auf der Karte anzeigen"
L["DisplayOnMapDescription"] = "Zeigen Sie Kartensymbole für die Position anderer Spy-Benutzer in Ihrer Gruppe, Schlachtzug und Gilde an, wenn sie Feinde erkennen."
L["SwitchToZone"] = "Wechseln Sie in der aktuellen Zonenkarte auf feindliche Erkennung"
L["SwitchToZoneDescription"] = "Change the map to the players current zone map when enemies are detected."
L["MapDisplayLimit"] = "Limitiert angezeigte Kartensymbole auf:"
L["LimitNone"] = "Überall"
L["LimitNoneDescription"] = "Zeigt, unabhängig von Ihrem aktuellen Standort, alle erkannten Feinde auf der Karte an."
L["LimitSameZone"] = "Gleiche Zone"
L["LimitSameZoneDescription"] = "Zeigt nur die entdeckten Feinde auf der Karte an, die sich in der gleichen Zone befinden."
L["LimitSameContinent"] = "Gleicher Kontinent"
L["LimitSameContinentDescription"] = "Zeigt nur die entdeckten Feinde auf der Karte an, die sich auf dem gleichen Kontinent befinden."

-- Data Management
L["DataOptions"] = "Datenmanagement"
L["DataOptionsDescription"] = [[

Optionen, wie Spy Daten verwaltet und sammelt.
]]
L["PurgeData"] = "Eliminiert unentdeckte feindliche Spieler-Daten nach:"
L["OneDay"] = "1 Tag"
L["OneDayDescription"] = "Eliminiert Daten feindlicher Spieler, die für 1 Tag unentdeckt geblieben sind."
L["FiveDays"] = "5 Tage"
L["FiveDaysDescription"] = "Eliminiert Daten feindlicher Spieler, die für 5 Tage unentdeckt geblieben sind."
L["TenDays"] = "10 Tage"
L["TenDaysDescription"] = "Eliminiert Daten feindlicher Spieler, die für 10 Tage unentdeckt geblieben sind."
L["ThirtyDays"] = "30 Tage"
L["ThirtyDaysDescription"] = "Eliminiert Daten feindlicher Spieler, die für 30 Tage unentdeckt geblieben sind."
L["SixtyDays"] = "60 Tage"
L["SixtyDaysDescription"] = "Eliminiert Daten feindlicher Spieler, die für 60 Tage unentdeckt geblieben sind."
L["NinetyDays"] = "90 Tage"
L["NinetyDaysDescription"] = "Eliminiert Daten feindlicher Spieler, die für 90 Tage unentdeckt geblieben sind."
L["PurgeKoS"] = "Eliminiert feindliche Spieler, basierend auf der Zeit, die sie unentdeckt geblieben sind."
L["PurgeKoSDescription"] = "Eliminiert Sofort zu tötende Spieler, welche unentdeckt geblieben sind, basierend auf den Zeiteinstellungen für unentdeckte Spieler."
L["PurgeWinLossData"] = "Eliminiert Sieg/Verlust-Daten, basierend auf der unentdeckten Zeit."
L["PurgeWinLossDataDescription"] = "Stellt die Eliminierung der Sieg/Verlust-Daten Ihrer feindlichen Spieler-Begegnungen ein, basierend auf den Zeiteinstellungen für unentdeckte Spieler."
L["ShareData"] = "Teile die Daten mit anderen Spy-Benutzern."
L["ShareDataDescription"] = "Stellt ein, dass Details Ihrer feindlichen Spieler-Begegnungen mit anderen Spy-Benutzern Ihrer Gruppe und Gilde geteilt werden."
L["UseData"] = "Verwende Daten anderer Spy-Benutzer."
L["UseDataDescription"] = "Stelle dies ein, um gesammelte Daten anderer Spy-Benutzer Ihrer Gruppe und Gilde zu verwenden."
L["ShareKOSBetweenCharacters"] = "Teile Sofort zu tötende Spieler mit Ihren anderen Charakteren."
L["ShareKOSBetweenCharactersDescription"] = "Wählen Sie diese Einstellung, um die Sofort zu tötende Spieler mit Ihren anderen Charakteren auf dem gleichen Server und Lager zu teilen."

-- Commands
L["SlashCommand"] = "Slash Befehl"
L["SpySlashDescription"] = "Diese Schaltflächen führen die gleichen Funktionen aus, wie die in den Slash Befehl /spy"
L["Enable"] = "Aktivieren"
L["EnableDescription"] = "Aktiviert Spy und zeigt das Hauptfenster."
L["Show"] = "Zeigen"
L["ShowDescription"] = "Zeigt das Hauptfenster."
L["Hide"] = "Ausblenden"
L["HideDescription"] = "Blendet das Hauptfenster aus."
L["Reset"] = "Zurücksetzen"
L["ResetDescription"] = "Setzt die Position und die Darstellung des Hauptfensters zurück."
L["ClearSlash"] = "Löschen"
L["ClearSlashDescription"] = "Löscht die Liste der Spieler, die entdeckt wurden."
L["Config"] = "Konfigurieren"
L["ConfigDescription"] = "Öffnet das Interface-Konfigurationsfenster für Spy."
L["KOS"] = "KOS"
L["KOSDescription"] = "Fügt hinzu/entfernt einen Spieler von der Sofort zu Töten-Liste."
L["InvalidInput"] = "Ungültige Eingabe"
L["Ignore"] = "Ignorieren"
L["IgnoreDescription"] = "Fügt hinzu/entfernt einen Spieler von der Zu Ignorieren-Liste."
L["Test"] = "Testen"
L["TestDescription"] = "Zeigt eine Warnung an, damit Sie sie neu positionieren können."
 
--Listen
L["Nearby"] = "In der Nähe"
L["LastHour"] = "Letzte Stunde"
L["Ignore"] = "Ignorieren"
L["KillOnSight"] = "Sofort zu Töten"
 
--Stats
L["Won"] = "Gewonnen"
L["Lost"] = "Verloren"
L["Time"] = "Zeit"	
L["List"] = "Liste"	
L["Filter"] = "Filter"
L["Show Only"] = "Zeige nur"
L["Realm"] = "Realm"
L["Won/Lost"] = "Gewonnen/Verloren"
L["KOS"] = "KOS"
L["Reason"] = "Grund"	
L["HonorKills"] = "Ehrenvolle Siege"
L["PvPDeaths"] = "PvP Tode"

--Ausgabemeldungen
L["VersionCheck"] = "|cffc41e3aWarnung! Die falsche Version von Spy ist installiert. Diese Version ist für Wrath of the Lich King - Classic."
L["SpyEnabled"] = "|cff9933ffSpy-Addon aktiviert."
L["SpyDisabled"] = "|cff9933ffSpy-Addon deaktiviert. Tippen Sie |cffffffff/spy show|cff9933ff um es zu aktivieren."
L["UpgradeAvailable"] = "|cff9933ffEine neue Version von Spy ist verfügbar. Es kann von: \n| cffffffffhttps://www.curseforge.com/wow/addons/spy-wotlk heruntergeladen werden."
L["AlertStealthTitle"] = "Getarnte Spieler erkannt!"
L["AlertKOSTitle"] = "Sofort zu tötenden Spieler erkannt!"
L["AlertKOSGuildTitle"] = "Gilde eines Sofort zu tötenden Spielers erkannt!"
L["AlertTitle_kosaway"] = "Sofort zu tötenden Spieler lokalisiert bei "
L["AlertTitle_kosguildaway"] = "Gilde eines Sofort zu tötenden Spielers lokalisiert bei"
L["StealthWarning"] = "|cff9933ffGetarnten Spieler erkannt: |cffffffff"
L["KOSWarning"] = "|cffff0000Sofort zu töten-Spieler erkannt: |cffffffff"
L["KOSGuildWarning"] = "|cffff0000Gilde eines Sofort zu tötenden Spielers erkannt: |cffffffff"
L["SpySignatureColored"] = "|cff9933ff [Spy]"
L["PlayerDetectedColored"] = "Spieler erkannt: |cffffffff"
L["PlayersDetectedColored"] = "Spieler erkannt: |cffffffff"
L["KillOnSightDetectedColored"] = "Sofort zu tötenden Spieler erkannt: |cffffffff"
L["PlayerAddedToIgnoreColored"] = "Zur Ignorieren-Liste hinzugefügter Spieler: |cffffffff"
L["PlayerRemovedFromIgnoreColored"] = "Von der Ignorieren-Liste entfernter Spieler: |cffffffff"
L["PlayerAddedToKOSColored"] = "Fügt Spieler der Sofort zu töten-Liste hinzu: |cffffffff"
L["PlayerRemovedFromKOSColored"] = "Von der Sofort zu töten-Liste entfernter Spieler: |cffffffff"
L["PlayerDetected"] = "[Spy] Spieler erkannt:"
L["KillOnSightDetected"] = "[Spy] Sofort zu tötenden Spieler erkannt:"
L["Level"] = "Level"
L["LastSeen"] = "Zuletzt gesehen"
L["LessThanOneMinuteAgo"] = "vor weniger als einer minute"
L["MinutesAgo"] = "vor Minuten"
L["HoursAgo"] = "vor Stunden"
L["DaysAgo"] = "vor Tagen"
L["Close"] = "Schließen"
L["CloseDescription"] = "|cffffffffVerbirgt das Spy-Fenster. Es wird standardmäßig wieder gezeigt, wenn der nächste feindliche Spieler erkannt wird."
L["Left/Right"] = "Links/Rechts"
L["Left/RightDescription"] = "|cffffffffNavigiert zwischen den Listen: In der Nähe, Letzte Stunde, Ignorieren und Sofort zu töten."
L["Clear"] = "Löschen"
L["ClearDescription"] = "|cffffffffLöscht die Liste der Spieler, die gefunden wurden. Strg-Klick stoppt/startet Spy. Shift-Click schaltet den Ton ein / aus."
L["SoundEnabled"] = "Audiowarnungen aktiviert"
L["SoundDisabled"] = "Audiowarnungen deaktiviert"
L["NearbyCount"] = "Anzahl der Spieler in der Nähe "
L["NearbyCountDescription"] = "|cffffffffSendet die Anzahl der in der Nähe befindlichen Spieler zum chatten"
L["Statistics"] = "Statistiken"
L["StatsDescription"] = "|cffffffffZeigt eine Liste der angetroffenen feindlichen Spieler,  Aufzeichnungen über Gewinne/Niederlagen und wo sie zuletzt gesehen wurden"
L["AddToIgnoreList"] = "Fügt zur Ignorieren-Liste hinzu"
L["AddToKOSList"] = "Fügt zur Sofort zu töten-Liste hinzu"
L["RemoveFromIgnoreList"] = "Entfernt von der zu Ignorieren-Liste"
L["RemoveFromKOSList"] = "Entfernt von der Sofort zu töten-Liste"
L["RemoveFromStatsList"] = "Entfernt von der Statistikliste"   
L["AnnounceDropDownMenu"] = "Melden"
L["KOSReasonDropDownMenu"] = "Hinterlegt Grund für Sofort zu töten"
L["PartyDropDownMenu"] = "Gruppe"
L["RaidDropDownMenu"] = "Raid"
L["GuildDropDownMenu"] = "Gilde"
L["LocalDefenseDropDownMenu"] = "Lokale Verteidigung"
L["Player"] = "(Spieler)"
L["KOSReason"] = "Sofort zu töten"
L["KOSReasonIndent"] = "    "
L["KOSReasonOther"] = "Geben Sie Ihren eigenen Grund ein ..."
L["KOSReasonClear"] = "Löschen Grund"
L["StatsWins"] = "|cff40ff00Gewinne:"
L["StatsSeparator"] = ""
L["StatsLoses"] = "|cff0070ddNiederlagen:"
L["Located"] = "lokalisiert:"
L["Yards"] = "Yards"
L["LocalDefenseChannelName"] = "LokaleVerteidigung"
 
Spy_KOSReasonListLength = 6
Spy_KOSReasonList = {
	[1] = {
		["title"] = "Gestarteter Kampf";
		["content"] = {
			"Griff mich ohne Grund an",
			"Griff mich auf einer Suche an",
			"Griff mich an, während ich NSCs bekämpfte",
			"Griff mich an, während ich in der Nähe einer Instanz war",
			"Griff mich an, während ich AFK war",
			"Griff mich an, während ich ritt/flog",
			"Griff mich an, während ich schlechter Gesundheit/Mana war",
		};
	},
	[2] = {
		["title"] = "Stil des Kampfes";
		["content"] = {
			"Überfiel mich",
			"Attackiert mich immer, wenn es mich sieht",
			"Tötete mich mit einem Charakter höheren Levels",
			"Überwältigte mich mit einer Gruppe von Feinden",
			"Attackiert nicht ohne Backup",
			"Ruft immer um Hilfe",
			"Nutzt zu viel Menschenmengenkontrolle",
		};
	},
	[3] = {
		["title"] = "camping";
		["content"] = {
			"Camped mich",
			"Camped meinen anderen Charakter",
			"Camped untere Charaktere",
			"Camped durch Unsichtbare",
			"Camped Gildenmitglieder",
			"Camped Spiel NPCs/Ziele",
			"Camped eine/n Stadt/Ort ",
		};
	},
	[4] = {
		["title"] = "Suchen";
		["content"] = {
			"Griff mich an, während ich suchte.",
			"Griff mich an, nachdem ich mit der Suche geholfen hatte.",
			"Störte mit einen Suchobjekt.",
			"Startete eine Suche, die ich durchführen wollte",
			"Tötete meine Fraktion NPCs",
			"Tötete eine NPC Suche",
		};
	},
	[5] = {
		["title"] = "Diebstahl Ressourcen";
		["content"] = {
			"Gesammelte Kräuter, die ich wollte",
			"Gefundene Mineralien, die ich wollte",
			"Gesammelte Ressourcen, die ich wollte",
			"Tötete mich und stahl meine Ziele/seltene NPC",
			"Enthäutete meine Kills",
			"Barg meine Kills",
			"In meinem Pool gefischt",
		};
	},
	[6] = {
		["title"] = "Andere";
		["content"] = {
		"Markiert für PvP",
		"Stie mich von einer Klippe",
		"Verwendete Engineering-Tricks",
		"Gelingt es immer, zu entkommen",
		"Benutzt Gegenstände und Fähigkeiten um zu entkommen",
		"Nutzt Spielmechanism en aus",
		"Geben Sie Ihren eigenen Grund ein ...",
		};
	},
}
 
StaticPopupDialogs ["Spy_SetKOSReasonOther"] = {
	PreferredIndex = STATICPOPUPS_NUMDIALOGS,--http://forums.wowace.com/showthread.php?p=320956
	text = "Geben Sie den Grund für das Sofort zu töten %s ein",
	button1 = "Einstellen",
	button2 = "Abbrechen",
	timeout = 20,
	hasEditBox = 1,
	editBoxWidth = 260,		
	whileDead = 1,
	hideOnEscape = 1,
	OnShow = function(self)
		self.editBox:SetText("");
	end,
	OnAccept = function(self)
		local reason = Self.editBox:GetText()
		Spy:SetKOSReason(self.playerName, "Geben Sie Ihren eigenen Grund ein ...", reason)
	end,
};

-- Class descriptions
L["UNKNOWN"] = "Unbekannt"
L["DRUID"] = "Druide"
L["HUNTER"] = "Jäger"
L["MAGE"] = "Magier"
L["PALADIN"] = "Paladin"
L["PREIST"] = "Priester"
L["ROGUE"] = "Schurke"
L["SHAMAN"] = "Schamane"
L["WARLOCK"] = "Hexenmeister"
L["WARRIOR"] = "Krieger"
L["DEATHKNIGHT"] = "Todesritter"
L["MONK"] = "Mönch"
L["DEMONHUNTER"] = "Dämonenjäger"
L["EVOKER"] = "Rufer"
 
-- Race descriptions
L["Human"] = "Mensch"
L["Orc"] = "Orc"
L["Dwarf"] = "Zwerg"
L["Tauren"] = "Tauren"
L["Troll"] = "Troll"
L["Night Elf"] = "Nachtelf"
L["Undead"] = "Untoter"
L["Gnome"] = "Gnom"
L["Blood Elf"] = "Blutelf"
L["Draenei"] = "Draenei"
L["Goblin"] = "Goblin"
L["Worgen"] = "Worgen"
L["Pandaren"] = "Pandaren"
L["Highmountain Tauren"] = "Hochbergtauren"
L["Lightforged Draenei"] = "Lichtgeschmiedeter Draenei"
L["Nightborne"] = "Nachtgeborener"
L["Void Elf"] = "Leerenelf"	
L["Dark Iron Dwarf"] = "Dunkeleisenzwerg"
L["Mag'har Orc"] = "Mag'har"
L["Kul Tiran"] = "Kul Tiran"
L["Zandalari Troll"] = "Zandalaritroll"
L["Mechagnome"] = "Mechagnom"
L["Vulpera"] = "Vulpera"
L["Dracthyr"] = "Dracthyr"
 
-- Stealth Fähigkeiten
L["Stealth"] = "Verstohlenheit"
L["Prowl"] = "Schleichen"
 
-- Minimap-Farbcodes
L["MinimapGuildText"] = "|cffffffff"
L["MinimapClassTextUNKNOWN"] = "|cff191919"
L["MinimapClassTextDRUID"] = "|cffff7c0a"
L["MinimapClassTextHUNTER"] = "|cffaad372"
L["MinimapClassTextMAGE"] = "|cff68ccef"
L["MinimapClassTextPALADIN"] = "|cfff48cba"
L["MinimapClassTextPRIEST"] = "|cffffffff"
L["MinimapClassTextROGUE"] = "|cfffff468"
L["MinimapClassTextSHAMAN"] = "|cff2359ff"
L["MinimapClassTextWARLOCK"] = "|cff9382c9"
L["MinimapClassTextWARRIOR"] = "|cffc69b6d"
L["MinimapClassTextDEATHKNIGHT"] = "|cffc41e3a"
L["MinimapClassTextMONK"] = "|cff00ff96"
L["MinimapClassTextDEMONHUNTER"] = "|cffa330c9"
L["MinimapClassTextEVOKER"] = "|cff33937f"

Spy_IgnoreList = {
	["Briefkasten"]=true, ["Schreddermeister Mk1"]=true, ["Schrott-o-matik 1000"]=true,
	["Boat to Stormwind City"]=true, ["Boat to Boralus Harbor, Tiragarde Sound"]=true,
	["Schatztruhe"]=true, ["Kleine Schatztruhe"]=true,
	["Akundas Biss"]=true, ["Ankerkraut"]=true, ["Flussknospe"]=true,    
	["Meeresstängel"]=true, ["Sirenenpollen"]=true, ["Sternmoos"]=true,   
	["Winterkuss"]=true, ["War Headquarters (PvP)"]=true,
	["Allianzattentäter"]=true, ["Hordeattentäter"]=true,	
	["Mystiker Vogelhut"]=true, ["Cousin Träghand"]=true,
	["Azerit für die Allianz"]=true, ["Azerit für die Horde"]=true,	
};