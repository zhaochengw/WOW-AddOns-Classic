-- Version : German (by Endymion, StarDust, Sasmira, Gamefaq)
-- Last Update : 08/16/2006

if GetLocale() ~= "deDE" then return end

local media = LibStub("LibSharedMedia-3.0")

--Event and Damage option values
SCT.LOCALS.OPTION_EVENT1 = {name = "Schaden", tooltipText = "Aktiviert die Anzeige von Nahkampf- und\nsonstigem (Feuer, Fallen, etc...) Schaden"};
SCT.LOCALS.OPTION_EVENT2 = {name = "Fehlschlag", tooltipText = "Aktiviert die Anzeige wenn verfehlt"};
SCT.LOCALS.OPTION_EVENT3 = {name = "Ausweichen", tooltipText = "Aktiviert die Anzeige wenn ausgewichen"};
SCT.LOCALS.OPTION_EVENT4 = {name = "Parieren", tooltipText = "Aktiviert die Anzeige wenn pariert"};
SCT.LOCALS.OPTION_EVENT5 = {name = "Blocken", tooltipText = "Aktiviert die Anzeige wenn geblockt"};
SCT.LOCALS.OPTION_EVENT6 = {name = "Zauberschaden", tooltipText = "Aktiviert die Anzeige von Zauberschaden"};
SCT.LOCALS.OPTION_EVENT7 = {name = "Heilungen", tooltipText = "Aktiviert die Anzeige von Heilsprucheffekten"};
SCT.LOCALS.OPTION_EVENT8 = {name = "Widerstehen", tooltipText = "Aktiviert die Anzeige wenn widerstanden"};
SCT.LOCALS.OPTION_EVENT9 = {name = "Debuffs", tooltipText = "Aktiviert die Anzeige von Debuffs"};
SCT.LOCALS.OPTION_EVENT10 = {name = "Absorbieren", tooltipText = "Aktiviert die Anzeige wenn Schaden absorbiert"};
SCT.LOCALS.OPTION_EVENT11 = {name = "Wenig Gesundheit", tooltipText = "Aktiviert die Anzeige wenn wenig Gesundheit"};
SCT.LOCALS.OPTION_EVENT12 = {name = "Wenig Mana", tooltipText = "Aktiviert die Anzeige wenn wenig Mana"};
SCT.LOCALS.OPTION_EVENT13 = {name = "Kampfboni", tooltipText = "Aktiviert die Anzeige wenn du Gesundheit\ndurch Tr\195\164nke, Gegenst\195\164nde, Buffs, etc...\n(keine nat\195\188rliche Regeneration) erh\195\164ltst."};
SCT.LOCALS.OPTION_EVENT14 = {name = "Kampfein-/austritt", tooltipText = "Aktiviert die Anzeige wenn du einem\nKampf beitrittst oder diesen verl\195\164sst"};
SCT.LOCALS.OPTION_EVENT15 = {name = "Combopunkte", tooltipText = "Aktiviert die Anzeige von Combopunkten"};
SCT.LOCALS.OPTION_EVENT16 = {name = "Ehrenpunkte", tooltipText = "Aktiviert die Anzeige von Ehrenpunkten"};
SCT.LOCALS.OPTION_EVENT17 = {name = "Buffs", tooltipText = "Aktiviert die Anzeige von Buffs"};
SCT.LOCALS.OPTION_EVENT18 = {name = "Buff-Fades", tooltipText = "Aktiviert die Anzeige von Buff-Fades"};
SCT.LOCALS.OPTION_EVENT19 = {name = "Hinrichten/Zorn", tooltipText = "Aktiviert die Anzeige wenn eine F\195\164higkeit benutzbar wird (Hinrichten, Mungobiss ,Hammer des Zorns, etc...) "};
SCT.LOCALS.OPTION_EVENT20 = {name = "Ruf", tooltipText = "Aktiviert die Anzeige wann du Ruf Punkte bekommst oder verlierst"};
SCT.LOCALS.OPTION_EVENT21 = {name = "Deine Heilungen", tooltipText = "Aktiviert die Anzeige wie hoch du andere heilst"};
SCT.LOCALS.OPTION_EVENT22 = {name = "Fertigkeiten", tooltipText = "Aktiviert die Anzeige ob du Skill Punkte bekommst"};
SCT.LOCALS.OPTION_EVENT23 = {name = "Todessto\195\159", tooltipText = "Aktiviert die Anzeige wenn du einen Todessto\195\159 hast"};
SCT.LOCALS.OPTION_EVENT24 = {name = "Unterbrochen", tooltipText = "Aktiviert die Anzeige wenn du unterbrochen wirst"};
SCT.LOCALS.OPTION_EVENT26 = {name = "Runen", tooltipText = "Aktiviert die Anzeige wenn Runen bereit sind"};
SCT.LOCALS.OPTION_EVENT27 = {name = "Cooldowns", tooltipText = "Aktiviert die Anzeige wenn ein Cooldown abgeschlossen ist"};

--Check Button option values
SCT.LOCALS.OPTION_CHECK1 = { name = "Aktiviere SCT", tooltipText = "Aktiviert den scrollenden Kampftext."};
SCT.LOCALS.OPTION_CHECK2 = { name = "Markiere Kampftext", tooltipText = "Legt fest, ob scrollende Kampftexte in Sternchen gesetzt werden sollen."};
SCT.LOCALS.OPTION_CHECK3 = { name = "Zeige Heiler", tooltipText = "Aktiviert die Anzeige wer dich geheilt hat."};
SCT.LOCALS.OPTION_CHECK4 = { name = "Text nach unten scrollen", tooltipText = "L\195\164sst den Text nach unten scrollen."};
SCT.LOCALS.OPTION_CHECK5 = { name = "Zeige Krits", tooltipText = "Bei aktivierung werden kritische Treffer/Heilung gr\195\182\195\159er dargestellt und nicht scrollen sondern eine weile sichtbar stehn bleiben. Wenn aus, werden Crits wie folgt dargestellt +1236+, usw..."};
SCT.LOCALS.OPTION_CHECK6 = { name = "Zauberschadenstyp anzeigen", tooltipText = "Aktiviert die Zauberschadenstyp-Anzeige."};
SCT.LOCALS.OPTION_CHECK7 = { name = "Aktiviere Schriftart zum Schaden", tooltipText = "Aktiviert die \195\164nderrung der Ingame Schadensschriftart damit sie der SCT Schriftart entspricht.\n\nWICHTIG: DU MUST AUS DEM SPIEL AUSLOGGEN UND NEU EINLOGGEN DAMIT DIESE \195\164NDERRUNG \195\188BERNOMMEN WIRD. EIN SIMPLES NEULADEN DES UI WIRD NICHT FUNKTIONIEREN!"};
SCT.LOCALS.OPTION_CHECK8 = { name = "Zeige alle Regenerationen", tooltipText = "Aktiviert das Anzeigen von allen regenerationen um dich herum, nicht nur diese die im Kampflog angezeigt werden\n\nBEACHTE: Das erzeugt SEHR VIEL SPAM auf dem Bildschirm und manchmal f\195\188hrt es zu seltsamen Anzeigen wenn Druiden sich zur\195\188ck in Heiler Form verwandeln."};
SCT.LOCALS.OPTION_CHECK10 = { name = "Zeige \195\156berheilung", tooltipText = "Aktiviert die Anzeige um weiviel du andere \195\188berheilst oder andere dich \195\188berheilen. Diese Option ist abh\195\164ngig von der 'Deine Heilung' Option, welche auch aktiviert sein muss."};
SCT.LOCALS.OPTION_CHECK11 = { name = "Alarm Sounds", tooltipText = "Aktiviert oder Deaktiviert das abspielen von Sounds als zus\195\164tzliche Warnung bei zB. Wenig Leben."};
SCT.LOCALS.OPTION_CHECK12 = { name = "Zauberfarben", tooltipText = "Aktiviert/Deaktiviert das Anzeigen des Zauberschadens in Farbe der entsprechenden Klasse"};
SCT.LOCALS.OPTION_CHECK13 = { name = "Aktiviere Custom Events", tooltipText = "Aktiviert oder Deaktiviert die Anzeige von besonderen Situationen. Wenn deaktiviert wird wesendlich weniger Arbeitsspeicher von SCT ben\195\182tigt."};
SCT.LOCALS.OPTION_CHECK14 = { name = "Spell/Skill Name", tooltipText = "Enables or Disables showing the name of the Spell or Skill that damaged you"};
SCT.LOCALS.OPTION_CHECK15 = { name = "Aufblitzen", tooltipText = "L\195\164sst Krits zus\195\164tzlich 'aufblitzen' auf dem Bildschirm."};
SCT.LOCALS.OPTION_CHECK16 = { name = "Glancing/Crushing", tooltipText = "Enables or Disables showing Glancing ~150~ and Crushing ^150^ blows"};
SCT.LOCALS.OPTION_CHECK17 = { name = "Zeige eigene HOT's", tooltipText = "Enables or Disables showing your healing over time spells cast on others. Note: this can be very spammy if you cast a lot of them."};
SCT.LOCALS.OPTION_CHECK18 = { name = "Zeige Heilungen bei Nameplates", tooltipText = "Enables or Disables attempting to show your heals over the nameplate of the person(s) you heal.\n\nFriendly nameplates must be on, you must be able to see the nameplate, and it will not work 100% of the time. If it does not work, heals appear in the normal configured position.\n\nDisabling can require a reloadUI to take effect."};
SCT.LOCALS.OPTION_CHECK19 = { name = "Disable WoW Healing", tooltipText = "Enables or Disables showing the built in healing text, added in patch 2.1."};

--Slider options values
SCT.LOCALS.OPTION_SLIDER1 = { name="Text Animations Geschwindigkeit", minText="Schneller", maxText="Langsamer", tooltipText = "Legt die Animationsgeschwindigkeit des dargestellten Textes fest."};
SCT.LOCALS.OPTION_SLIDER2 = { name="Textgr\195\182\195\159e", minText="Kleiner", maxText="Gr\195\182\195\159er", tooltipText = "Legt die Gr\195\182\195\159e des dargestellten Textes fest."};
SCT.LOCALS.OPTION_SLIDER3 = { name="HP %", minText="10%", maxText="90%", tooltipText = "Legt fest ab wieviel Prozent Gesundheit\neine Warnung angezeigt werden soll."};
SCT.LOCALS.OPTION_SLIDER4 = { name="Mana %", minText="10%", maxText="90%", tooltipText = "Legt fest ab wieviel Prozent Mana\neine Warnung angezeigt werden soll."};
SCT.LOCALS.OPTION_SLIDER5 = { name="Texttransparenz", minText="0%", maxText="100%", tooltipText = "Legt die Transparenz des Textes fest."};
SCT.LOCALS.OPTION_SLIDER6 = { name="Abstand zwischen Text", minText="Kleiner", maxText="Gr\195\182\195\159er", tooltipText = "Legt den Abstand zwischen dem scrollenden Kampftext fest."};
SCT.LOCALS.OPTION_SLIDER7 = { name="Text X-Achse Position", minText="-600", maxText="600", tooltipText = "Legt die waagerechte Position des Textes fest"};
SCT.LOCALS.OPTION_SLIDER8 = { name="Text Y-Achse Position", minText="-400", maxText="400", tooltipText = "Legt die senkrechte Position des Textes fest"};
SCT.LOCALS.OPTION_SLIDER9 = { name="Nachrichten X-Achse Position", minText="-600", maxText="600", tooltipText = "Legt die waagerechte Position des Nachrichten Textes fest"};
SCT.LOCALS.OPTION_SLIDER10 = { name="Nachrichten Y-Achse Position", minText="-400", maxText="400", tooltipText = "Legt die senkrechte Position des Nachrichten Textes fest"};
SCT.LOCALS.OPTION_SLIDER11 = { name="Nachrichten ausblenden", minText="Schneller", maxText="Langsamer", tooltipText = "Legt die Geschwindigkeit bis der Test ausgeblendet wird fest"};
SCT.LOCALS.OPTION_SLIDER12 = { name="Text Gr\195\182\195\159e", minText="Kleiner", maxText="Gr\195\182\195\159er", tooltipText = "Legt die gr\195\182\195\159e des Message Textes fest"};
SCT.LOCALS.OPTION_SLIDER13 = { name="Heiler Filter", minText="0", maxText="500", tooltipText = "Controls the minimum amount a heal needs to heal you for to appear in SCT. Good for filtering out frequent small heals like Totems, Blessings, etc..."};
SCT.LOCALS.OPTION_SLIDER14 = { name="Mana Filter", minText="0", maxText="500", tooltipText = "Controls the minimum amount a power gain needs to be to appear in SCT. Good for filtering out frequent small power gains like Totems, Blessings, etc..."};
SCT.LOCALS.OPTION_SLIDER15 = { name="HUD Gap Distance", minText="0", maxText="200", tooltipText = "Controls the distance from the center for the HUD animation. Useful when wanting to keep eveything centered but adjust the distance from center"};
SCT.LOCALS.OPTION_SLIDER16 = { name="Shorten Spell Size", minText="1", maxText="30", tooltipText = "Spell names over this length will be shortend using the selected shorten type."};

--Spell Color options]
SCT.LOCALS.OPTION_COLOR1 = { name=SPELL_SCHOOL0_CAP, tooltipText = "Controls the color for "..SPELL_SCHOOL0_CAP.." spells"};
SCT.LOCALS.OPTION_COLOR2 = { name=SPELL_SCHOOL1_CAP, tooltipText = "Controls the color for "..SPELL_SCHOOL1_CAP.." spells"};
SCT.LOCALS.OPTION_COLOR3 = { name=SPELL_SCHOOL2_CAP, tooltipText = "Controls the color for "..SPELL_SCHOOL2_CAP.." spells"};
SCT.LOCALS.OPTION_COLOR4 = { name=SPELL_SCHOOL3_CAP, tooltipText = "Controls the color for "..SPELL_SCHOOL3_CAP.." spells"};
SCT.LOCALS.OPTION_COLOR5 = { name=SPELL_SCHOOL4_CAP, tooltipText = "Controls the color for "..SPELL_SCHOOL4_CAP.." spells"};
SCT.LOCALS.OPTION_COLOR6 = { name=SPELL_SCHOOL5_CAP, tooltipText = "Controls the color for "..SPELL_SCHOOL5_CAP.." spells"};
SCT.LOCALS.OPTION_COLOR7 = { name=SPELL_SCHOOL6_CAP, tooltipText = "Controls the color for "..SPELL_SCHOOL6_CAP.." spells"};

--Misc option values
SCT.LOCALS.OPTION_MISC1 = {name="SCT Optionen "..SCT.Version, tooltipText = "Links Klick zum Verschieben"};
SCT.LOCALS.OPTION_MISC2 = {name="Schlie\195\159en", tooltipText = "Zauberfarben schlie\195\159en" };
SCT.LOCALS.OPTION_MISC3 = {name="Edit", tooltipText = "Zauberfarben bearbeiten" };
SCT.LOCALS.OPTION_MISC4 = {name="Sonstige Optionen"};
SCT.LOCALS.OPTION_MISC5 = {name="Warnungs Optionen"};
SCT.LOCALS.OPTION_MISC6 = {name="Animations Optionen"};
SCT.LOCALS.OPTION_MISC7 = {name="W\195\164hle Spieler Profil"};
SCT.LOCALS.OPTION_MISC8 = {name="Speichern", tooltipText = "Speichert alle Einstellungen und schlie\195\159t die Optionen"};
SCT.LOCALS.OPTION_MISC9 = {name="Reset", tooltipText = "-Warnung-\n\nBist du sicher, dass du SCT auf die Standardeinstellungen zur\195\188cksetzen willst?"};
SCT.LOCALS.OPTION_MISC10 = {name="Profile", tooltipText = "W\195\164hle ein anderes Charakter Profil"};
SCT.LOCALS.OPTION_MISC11 = {name="Laden", tooltipText = "Lade ein anderes Profil f\195\188r diesen Charakter"};
SCT.LOCALS.OPTION_MISC12 = {name="L\195\182schen", tooltipText = "L\195\182scht das ausgew\195\164hlte Charakter Profil"};
SCT.LOCALS.OPTION_MISC13 = {name="Text Options" };
SCT.LOCALS.OPTION_MISC14 = {name="Fenster 1"};
SCT.LOCALS.OPTION_MISC15 = {name="Nachrichten"};
SCT.LOCALS.OPTION_MISC16 = {name="Animationen"};
SCT.LOCALS.OPTION_MISC17 = {name="Zauber Optionen"};
SCT.LOCALS.OPTION_MISC18 = {name="Fenster"};
SCT.LOCALS.OPTION_MISC19 = {name="Zauber"};
SCT.LOCALS.OPTION_MISC20 = {name="Fenster 2"};
SCT.LOCALS.OPTION_MISC21 = {name="Ereignisse"};
SCT.LOCALS.OPTION_MISC22 = {name="Classic Profil", tooltipText = "Laden des Classic Profil's. Justiert die Funktionen \195\164hnlich den des vorgegeben SCT Profil's."};
SCT.LOCALS.OPTION_MISC23 = {name="Performance Profil", tooltipText = "Laden des Performance Profil's. Justiert die Optionen so das die beste Performance mit SCT erreicht wird."};
SCT.LOCALS.OPTION_MISC24 = {name="Split Profil", tooltipText = "Laden des Split Profil's. Zeigt erhaltenen Schaden und Ereignisse auf der rechten Seite an und erhaltene Heilung und Buffs auf der linken Seite."};
SCT.LOCALS.OPTION_MISC25 = {name="Grayhoof Profil", tooltipText = "Laden von Grayhoof's Profil. Justiert SCT so wie Grayhoof (der Author von SCT) sein SCT eingestellt hat."};
SCT.LOCALS.OPTION_MISC26 = {name="Built In Profile", tooltipText = ""};
SCT.LOCALS.OPTION_MISC27 = {name="Split SCTD Profil", tooltipText = "Laden des Split SCTD Profil's. Wenn du SCTD installiert hast, werden eingehende Ereignisse auf der rechten Seite angezeigt, ausgehende Ereignisse auf der linken Seite angezeigt und Status Nachrichten oben angezeigt."};
SCT.LOCALS.OPTION_MISC28 = {name="Test", tooltipText = "Create Test event for each frame"};
SCT.LOCALS.OPTION_MISC29 = {name="Custom Events"};
SCT.LOCALS.OPTION_MISC36 = {name="Cooldown Optionen"};

--Animation Types
SCT.LOCALS.OPTION_SELECTION1 = { name="Animations Typ", tooltipText = "Welchen Animations Typ benutzen?", table = {[1] = "Vertical (Normal)",[2] = "Regenbogen",[3] = "Horizontal",[4] = "Im Winkel runter", [5] = "Im Winkel hoch", [6] = "Zuf\195\164llig", [7] = "HUD Curved", [8] = "HUD Angled"}};
SCT.LOCALS.OPTION_SELECTION2 = { name="Seiten Style", tooltipText = "Wie soll der zu Seite scrollende Text dargestellt werden?", table = {[1] = "Abwechselnt",[2] = "Schaden Links",[3] = "Schaden Rechts", [4] = "Alle Links", [5] = "Alle Rechts"}};
SCT.LOCALS.OPTION_SELECTION3 = { name="Schriftart", tooltipText = "Welche Schriftart benutzen?", table = media:List("font")};
SCT.LOCALS.OPTION_SELECTION4 = { name="Rand um Schriftart", tooltipText = "Welche Art Rand soll um die Schriftart verwendet werden?", table = {[1] = "Keine",[2] = "D\195\188nn",[3] = "Dick"}};
SCT.LOCALS.OPTION_SELECTION5 = { name="Nachrichten Schrifart", tooltipText = "Welche Schriftart bei Nachrichten benutzen?", table = media:List("font")};
SCT.LOCALS.OPTION_SELECTION6 = { name="Rand um Nachrichten", tooltipText = "Welche Art Rand soll um die Nachrichten Schriftart verwendet werden?", table = {[1] = "Keine",[2] = "D\195\188nn",[3] = "Dick"}};
SCT.LOCALS.OPTION_SELECTION7 = { name="Text Ausrichtung", tooltipText = "How the text aligns itself. Most useful for vertical or HUD animations. HUD alignment will make left side right-aligned and right side left-aligned.", table = {[1] = "Links",[2] = "Mitte",[3] = "Rechts", [4] = "HUD zentriert"}};
SCT.LOCALS.OPTION_SELECTION8 = { name="Shorten Spell Type", tooltipText = "How to shorten spell names.", table = {[1] = "Truncate",[2] = "Abbreviate"}};
