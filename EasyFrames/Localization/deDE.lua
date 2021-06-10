local L = LibStub("AceLocale-3.0"):NewLocale("EasyFrames", "deDE")
if not L then return end

L["loaded. Options:"] = "geladen. Optionen:"

L["Opacity"] = "Deckkraft"
L["Opacity of combat texture"] = "Deckkraft von Kampftexturen"

L["Main options"] = "Hauptoptionen"
L["In main options you can set the global options like colored frames, buffs settings, etc"] = "In den Hauptoptionen kannst du globale Optionen wie farbige Rahmen, Klassenportraits usw. einstellen"

L["Percent"] = "Prozent"
L["Current + Max"] = "Aktuell + Max"
L["Current + Max + Percent"] = "Aktuell + Max + Prozent"
L["Current + Percent"] = "Aktuell + Prozent"
L["Custom format"] = "Benutzerdefiniertes Format"

L["HP and MP bars"] = "Lebens- und Manabalken"

L["Font size"] = "Schriftgröße"
L["Healthbar font size"] = "Schriftgröße von Lebens"
L["Manabar font size"] = "Schriftgröße von Manabalken"
L["Font family"] = "Schriftart"
L["Healthbar font family"] = "Schriftart von Lebens"
L["Manabar font family"] = "Schriftart von Manabalken"
L["Font style"] = "Schriftstil"

L["Reverse the direction of losing health/mana"] = "Kehre die Richtung von verlorenem Leben/Mana um"
L["By default direction starting from right to left. If checked direction of losing health/mana will be from left to right"] = "Standardmäßig startet die Richtung von rechts nach links. Mit aktivierter Option wird die Richtung von links nach rechts geändert"

L["Custom format of HP"] = "Benutzerdefiniertes Format der HP"
L["You can set custom HP format. More information about custom HP format you can read on project site.\n\n" ..
        "Formulas:"] = "Du kannst ein beliebiges Format der Lebenspunkte einstellen. Mehr Informationen zu den Einstellungen kannst du auf der Projektseite nachlesen.\n\n" ..
        "Formeln:"
L["Use full values of health"] = "Verwende vollständige Werte der Gesundheit"
L["Formula converts the original value to the specified value.\n\n" ..
        "Description: for example formula is '%.fM'.\n" ..
        "The first part '%.f' is the formula itself, the second part 'M' is the abbreviation\n\n" ..
        "Example, value is 150550. '%.f' will be converted to '151' and '%.1f' to '150.6'"] = "Formel wandelt den Originalwert in den spezifischen Wert um.\n\n" ..
        "Beschreibung: Als beispiel ist die Formel '%.fM'.\n" ..
        "Der erste Teil '%.f' ist die Formel selber, der zweite Teil 'M' ist die Abkürzung \n\n" ..
        "Der Wert ist beispielsweise 150550. '%.f' wird in '151' umgewandelt und '%.1f' in '150.6'"
L["Value greater than 1000"] = "Wert größer als 1,000"
L["Value greater than 100 000"] = "Wert größer als 100,000"
L["Value greater than 1 000 000"] = "Wert größer als 1,000,000"
L["Value greater than 10 000 000"] = "Wert größer als 10,000,000"
L["Value greater than 100 000 000"] = "Wert größer als 100,000,000"
L["Value greater than 1 000 000 000"] = "Wert größer als 1,000,000,000"
L["By default all formulas use divider (for value eq 1000 and more it's 1000, for 1 000 000 and more it's 1 000 000, etc).\n\n" ..
        "If checked formulas will use full values of HP (without divider)"] = "Standardmäßig benutzen alle Formeln Trennzeichen (z. B. für den Wert 1000 und darüber 1000, für 1 000 000 und darüber 1 000 000 usw.).\n\n" ..
        "Falls ausgewählt, werden die Formeln vollständige Gesundheitswerte anzeigen (ohne Trennzeichen)"
L["Displayed HP by pattern"] = "Angezeigte Lebenspunkte nach dem Muster"
L["You can use patterns:\n\n" ..
        "%CURRENT% - return current health\n" ..
        "%MAX% - return maximum of health\n" ..
        "%PERCENT% - return percent of current/max health\n\n" ..
        "All values are returned from formulas. For set abbreviation use formulas' fields"] = "Du kannst Vorlagen verwenden:\n\n" ..
        "%CURRENT% - Aktueller Wert\n" ..
        "%MAX% - Maximaler Wert\n" ..
        "%PERCENT% - Prozentualer Wert\n\n" ..
        "Alle Werte werden durch Formeln berechnet. Verwende die Formularfelder, um Abkürzungen einzustellen"

L["Frames"] = "Rahmen"
L["Setting for unit frames"] = "Einstellungen für die Einheitsrahmen"

L["Class colored healthbars"] = "Lebensbalken in Klassenfarben"
L["If checked frames becomes class colored.\n\n" ..
        "This option excludes the option 'Healthbar color is based on the current health value'"] = "Bei Aktivierung werden die Rahmen in der Klassenfarbe eingefärbt\n\n" ..
        "Diese Option schließt die Option 'Lebensbalkenfarbe basierend auf aktuellem Gesundheitswert' aus"
L["Healthbar color is based on the current health value"] = "Lebensbalkenfarbe basierend auf aktuellem Gesundheitswert"
L["Healthbar color is based on the current health value.\n\n" ..
        "This option excludes the option 'Class colored healthbars'"] = "Lebensbalkenfarbe basierend auf aktuellem Gesundheitswert\n\n" ..
        "Diese Option schließt die Option 'Lebensbalken in Klassenfarben' aus"
L["Custom buffsize"] = "Benutzerdefinierte Buffgröße"
L["Buffs settings (like custom buffsize, highlight dispelled buffs, etc)"] = "Einstellungen für Stärkungszauber (wie beliebige Stärkungszaubergröße, Hervorheben von entfernbaren Stärkungszaubern usw.)"
L["Turn on custom buffsize"] = "Veränderbare Größe von Stärkungszaubern aktivieren"
L["Turn on custom target and focus frames buffsize"] = "Veränderbare Größe von Ziel- und Fokusrahmengröße aktivieren"
L["Buffs"] = "Stärkungszauber"
L["Buffsize"] = "Stärkungszaubergröße"
L["Self buffsize"] = "Größe eigener Stärkungszauber"
L["Buffsize that you create"] = "Größe deiner gewirkten Stärkungszauber"
L["Highlight dispelled buffs"] = "Hebe entfernbare Stärkungszauber hervor"
L["Highlight buffs that can be dispelled from target frame"] = "Hebe Stärkungszauber hervor, die vom Ziel entfernt werden können"
L["Dispelled buff scale"] = "Skalierung von entfernbaren Stärkungszaubern"
L["Dispelled buff scale that can be dispelled from target frame"] = "Größe von Stärkungszaubern, die vom Ziel entfernt werden können"
L["Only if player can dispel them"] = "Nur, wenn der Spieler sie reinigen kann"
L["Highlight dispelled buffs only if player can dispel them"] = "Hebe entfernbare Buffs nur hervor, wenn der Spieler sie reinigen kann"

L["Class portraits"] = "Klassenportraits"
L["Replaces the unit-frame portrait with their class icon"] = "Ersetzt den Portraitrahmen durch das Klassensymbol"

L["Texture"] = "Textur"
L["Set the frames bar Texture"] = "Einstellungen der Rahmentexturen"
L["Use a light texture"] = "Verwende eine helle Textur"
L["Use a brighter texture (like Blizzard's default texture)"] = "Verwende eine hellere Textur (wie Blizzards Standardtextur)"
L["Bright frames border"] = "Helligkeit der Rahmenbegrenzungen"
L["You can set frames border bright/dark color. From bright to dark. 0 - dark, 100 - bright"] = "Du kannst die Rahmenbegrenzungen hell/dunkel einstellen. Von hell nach dunkel. 0 - dunkel, 100 - hell"

L["Frames colors"] = "Rahmenfarben"
L["In this section you can set the default colors for friendly, enemy and neutral frames"] = "In diesem Abschnitt kannst du die Standardfarben für freundliche, feindliche und neutrale Rahmen einstellen"
L["Set default friendly healthbar color"] = "Standardfarbe für freundliche Lebensbalken"
L["You can set the default friendly healthbar color for frames"] = "Hier kannst du die Standardfarbe für freundliche Lebensbalken einstellen"
L["Set default enemy healthbar color"] = "Standardfarbe für feindliche Lebensbalken"
L["You can set the default enemy healthbar color for frames"] = "Hier kannst du die Standardfarbe für feindliche Lebensbalken einstellen"
L["Set default neutral healthbar color"] = "Standardfarbe für neutrale Lebensbalken"
L["You can set the default neutral healthbar color for frames"] = "Hier kannst du die Standardfarbe für neutrale Lebensbalken einstellen"
L["Reset color to default"] = "Setze die Farben auf Standard zurück"

L["Other"] = "Anderes"
L["In this section you can set the settings like 'show welcome message' etc"] = "In diesem Abschnitt kannst du Einstellungen wie 'Zeige Willkommensnachricht' usw. einstellen"
L["Show welcome message"] = "Zeige Willkommensnachricht"
L["Show welcome message when addon is loaded"] = "Zeige Willkommensnachricht, wenn das Addon geladen wird"



L["Player"] = "Spieler"
L["In player options you can set scale player frame, healthbar text format, etc"] = "In den Spieleroptionen kannst du Skalierungen der eigenen Rahmengröße, das Textformat des Lebensbalkens usw. einstellen"
L["Player name"] = "Spielername"
L["Show or hide some elements of frame"] = "Zeige oder verstecke Teile des Rahmens"
L["Show player name"] = "Zeige Spielernamen"
L["Show player name inside the frame"] = "Zeige den Spielernamen innerhalb des Rahmens"
L["Player frame scale"] = "Skalierung des Spielerrahmens"
L["Scale of player unit frame"] = "Skalierung der Größe des Spielerrahmens"
L["Enable hit indicators"] = "Verwende Trefferanzeige"
L["Show or hide the damage/heal which you take on your unit frame"] = "Zeige oder verstecke auf deiner Anzeige Schaden/Heilung, welchen du erlitten hast"
L["Player healthbar text format"] = "Textformat des eigenen Lebensbalkens"
L["Set the player healthbar text format"] = "Stelle das Textformat des eigenen Lebensbalkens ein"
L["Show player specialbar"] = "Zeige Spezialleiste des Spielers"
L["Show or hide the player specialbar, like Paladin's holy power, Priest's orbs, Monk's harmony or Warlock's soul shards"] = "Zeige oder verstecke die Spezialleiste des Spielers, wie z. B. Heilige Kraft vom Paladin, Priesterkugeln, Chi beim Mönch oder Seelensplitter vom Hexenmeister"
L["Show player resting icon"] = "Zeige Erholungssymbol"
L["Show or hide player resting icon when player is resting (e.g. in the tavern or in the capital)"] = "Zeige oder verstecke das Erholungssymbol, wenn der Spieler sich ausruht (z. B. in einer Taverne oder Hauptstadt)"
L["Show player status texture (inside the frame)"] = "Zeige Statustextur des Spielers (innerhalb des Rahmens)"
L["Show or hide player status texture (blinking glow inside the frame when player is resting or in combat)"] = "Zeige oder verstecke das Statussymbol des Spielers (blinkendes Leuchten innerhalb des Rahmens, wenn der Spieler sich ausruht oder im Kampf ist)"
L["Show player combat texture (outside the frame)"] = "Zeige Kampftextur des Spielers (außerhalb des Rahmens)"
L["Show or hide player red background texture (blinking red glow outside the frame in combat)"] = "Zeige oder verstecke die Hintergrundtextur (rot-blinkendes Leuchten außerhalb des Rahmens im Kampf)"
L["Show player group number"] = "Zeige Gruppennummer des Spielers"
L["Show or hide player group number when player is in a raid group (over portrait)"] = "Zeige oder verstecke die Gruppennummer des Spielers, wenn der Spieler sich in einem Schlachtzug befindet (oberhalb des Portrais)"
L["Show player role icon"] = "Zeige Rollensymbol des Spielers"
L["Show or hide player role icon when player is in a group"] = "Zeige oder verstecke das Rollensymbol, wenn der Spieler in einer Gruppe ist"


L["Target"] = "Ziel"
L["In target options you can set scale target frame, healthbar text format, etc"] = "In den Zieloptionen kannst du Skalierungen des Zielrahmens, das Textformat des Lebensbalkens usw. einstellen"
L["Target name"] = "Zielname"
L["Target frame scale"] = "Skalierung des Zielrahmens"
L["Scale of target unit frame"] = "Skalierung der Größe des Zielrahmens"
L["Target healthbar text format"] = "Textformat des Ziellebensbalkens"
L["Set the target healthbar text format"] = "Stelle das Textformat des Ziellebensbalkens ein"
L["Show target of target frame"] = "Zeige den Rahmen vom Ziel des Ziels"
L["Show target name"] = "Zeige Zielnamen"
L["Show target name inside the frame"] = "Zeige den Zielnamen innerhalb des Rahmens"
L["Show target combat texture (outside the frame)"] = "Zeige Kampftextur des Ziels (außerhalb des Rahmens)"
L["Show or hide target red background texture (blinking red glow outside the frame in combat)"] = "Zeige oder verstecke die Hintergrundtextur (rot-blinkendes Leuchten außerhalb des Rahmens im Kampf)"
L["Show blizzard's target castbar"] = "Zeige Blizzards Zauberleiste"
L["When you change this option you need to reload your UI (because it's Blizzard config variable). \n\nCommand /reload"] = "Wenn du diese Option änderst, musst du dein UI neuladen (da es eine Funktion von Blizzard ist. \n\nBefehl /reload"


L["Focus"] = "Fokus"
L["In focus options you can set scale focus frame, healthbar text format, etc"] = "In den Fokusoptionen kannst du Skalierungen des Fokusrahmens, das Textformat des Lebensbalkens usw. einstellen"
L["Focus name"] = "Fokusname"
L["Focus frame scale"] = "Skalierung des Fokusrahmens"
L["Scale of focus unit frame"] = "Skalierung der Größe des Fokusrahmens"
L["Focus healthbar text format"] = "Textformat des Fokuslebensbalkens"
L["Set the focus healthbar text format"] = "Stelle das Textformat des Fokuslebensbalkens ein"
L["Show target of focus frame"] = "Zeige den Rahmen vom Ziel des Fokus"
L["Show name of focus frame"] = "Zeige Fokusnamen"
L["Show name of focus frame inside the frame"] = "Zeige den Fokusnamen innerhalb des Rahmens"
L["Show focus combat texture (outside the frame)"] = "Zeige Kampftextur des Fokus (außerhalb des Rahmens)"
L["Show or hide focus red background texture (blinking red glow outside the frame in combat)"] = "Zeige oder verstecke die Hintergrundtextur (rot-blinkendes Leuchten außerhalb des Rahmens im Kampf)"

L["Pet"] = "Begleiter"
L["In pet options you can set scale pet frame, show/hide pet name, enable/disable pet hit indicators, etc"] = "In den Begleiteroptionen kannst du die Skalierung des Begleiterrahmens, Begleitername ein-/ausblenden, erlittene Treffer ein-/ausschalten usw."
L["Pet name"] = "Begleitername"
L["Pet frame scale"] = "Skalierung des Begleiterrahmens"
L["Scale of pet unit frame"] = "Skalierung der Größe des Begleiterrahmens"
L["Lock pet frame"] = "Begleiterrahmen sperren"
L["Lock or unlock pet frame. When unlocked you can move frame using your mouse (draggable)"] = "Sperren oder Entsperren des Begleiterrahmens. Bei Entsperrung kannst du den Rahmen mit deiner Maus verschieben"
L["Pet healthbar text format"] = "Textformat des Begleiterlebensbalkens"
L["Show pet name"] = "Zeige Begleiternamen"
L["Show or hide the damage/heal which your pet take on pet unit frame"] = "Zeige oder verstecke Schaden/Heilung, welchen dein Begleiter erlitten hat"
L["Show pet combat texture (inside the frame)"] = "Zeige Kampftextur des Begleiters (innerhalb des Rahmens)"
L["Show or hide pet red background texture (blinking red glow inside the frame in combat)"] = "Zeige oder verstecke die Hintergrundtextur (rot-blinkendes Leuchten innerhalb des Rahmens im Kampf)"
L["Show pet combat texture (outside the frame)"] = "Zeige Kampftextur des Begleiters (außerhalb des Rahmens)"
L["Show or hide pet red background texture (blinking red glow outside the frame in combat)"] = "Zeige oder verstecke die Hintergrundtextur (rot-blinkendes Leuchten außerhalb des Rahmens im Kampf)"

L["Party"] = "Gruppe"
L["In party options you can set scale party frames, healthbar text format, etc"] = "In den Gruppenoptionen kannst du die Skalierung der Gruppenrahmen, das Textformat des Lebensbalkens usw. einstellen"
L["Party frames scale"] = "Skalierung der Gruppenrahmen"
L["Scale of party unit frames"] = "Skalierung der Größe der Gruppenrahmen"
L["Party healthbar text format"] = "Textformat der Gruppenlebensbalken"
L["Set the party healthbar text format"] = "Stelle das Textformat der Gruppenlebensbalken ein"
L["Party frames names"] = "Gruppenrahmennamen"
L["Show names of party frames"] = "Zeige Namen der Gruppenmitglieder"