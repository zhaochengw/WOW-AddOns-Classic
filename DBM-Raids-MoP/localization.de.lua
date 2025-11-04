if GetLocale() ~= "deDE" then
	return
end
local L

------------
-- The Stone Guard --
------------
L = DBM:GetModLocalization(679)

L:SetWarningLocalization({
	SpecWarnOverloadSoon		= "%s bald!",
	specWarnBreakJasperChains	= "Sprenge Jaspisketten!"
})

L:SetOptionLocalization({
	SpecWarnOverloadSoon		= "Spezialwarnung bevor eine Überladung gewirkt werden kann",
	specWarnBreakJasperChains	= "Spezialwarnung, wenn es sicher ist die $spell:130395 zu sprengen",
	InfoFrame					= "Zeige Infofenster für Bossenergie, Spielerversteinerung und welcher Boss Versteinerung wirkt"
})

L:SetMiscLocalization({
	Overload	= "%s überlädt sich gleich!"
})

------------
-- Feng the Accursed --
------------
L = DBM:GetModLocalization(689)

L:SetWarningLocalization({
	WarnPhase			= "Phase %d",
	specWarnBarrierNow	= "JETZT Nullifikationsbarriere benutzen!"
})

L:SetOptionLocalization({
	WarnPhase			= "Verkünde Phasenwechsel",
	specWarnBarrierNow	= "Spezialwarnung, wenn von dir erwartet wird $spell:115817 zu benutzen (nur bei Schlachtzugsbrowserkämpfen)",
	RangeFrame	= DBM_CORE_L.AUTO_RANGE_OPTION_TEXT_SHORT:format("6") .. " während Arkanphase"
})

L:SetMiscLocalization({
	Fire	= "Oh, Erhabener! Durch mich sollt Ihr das Fleisch von den Knochen schmelzen!",
	Arcane	= "Oh, Weiser der Zeitalter! Vertraut mir Euer arkanes Wissen an!",
	Nature	= "Oh, großer Geist! Gewährt mir die Macht der Erde!",
	Shadow	= "Große Seele vergangener Helden! Gewährt mir Euren Schild!"
})

-------------------------------
-- Gara'jal the Spiritbinder --
-------------------------------
L = DBM:GetModLocalization(682)

L:SetMiscLocalization({
	Pull	= "Jetzt is' Sterbenszeit!"
})

----------------------
-- The Spirit Kings --
----------------------
L = DBM:GetModLocalization(687)

L:SetWarningLocalization({
	DarknessSoon	= "Schild der Dunkelheit in %d Sekunden"
})

L:SetTimerLocalization({
	timerUSRevive		= "Unsterblicher Schatten Neuformung",
	timerRainOfArrowsCD	= "%s"
})

L:SetOptionLocalization({
	DarknessSoon	= "Zeige Vorwarnungscountdown für $spell:117697 (5s zuvor)",
	timerUSRevive	= "Zeige Zeit bis sich $spell:117506 neu formen"
})

------------
-- Elegon --
------------
L = DBM:GetModLocalization(726)

L:SetWarningLocalization({
	specWarnDespawnFloor	= "Der Boden verschwindet in 6 Sekunden!"
})

L:SetTimerLocalization({
	timerDespawnFloor	= "Boden verschwindet"
})

L:SetOptionLocalization({
	specWarnDespawnFloor	= "Spezialwarnung bevor der Boden (Energievortex) verschwindet",
	timerDespawnFloor		= "Zeige Zeit bis der Boden (Energievortex) verschwindet"
})

------------
-- Will of the Emperor --
------------
L = DBM:GetModLocalization(677)

L:SetOptionLocalization({
	InfoFrame		= "Zeige Infofenster für Spieler, welche von $spell:116525 betroffen sind",
	CountOutCombo	= "Zähle akustisch die Anzahl der $journal:5673 Wirkungen<br/>HINWEIS: Dafür ist derzeit nur die weibliche Stimme verfügbar.",
	ArrowOnCombo	= "Zeige DBM-Pfeil während $journal:5673  HINWEIS: Nimmt an,<br/>dass sich der Tank vor dem Boss befindet und alle anderen dahinter."
})

L:SetMiscLocalization({
	Pull		= "Die Maschine brummt und erwacht zu Leben! Geht zur unteren Ebene!",
	Rage		= "Der Zorn des Kaisers schallt durch die Berge.",
	Strength	= "Die Stärke des Kaisers erscheint in den Erkern!",
	Courage		= "Der Mut des Kaisers erscheint in den Erkern!",
	Boss		= "In den riesigen Erkern erscheinen zwei Titanenkonstrukte!"
})

------------
-- Imperial Vizier Zor'lok --
------------
L = DBM:GetModLocalization(745)

L:SetWarningLocalization({
	warnEcho			= "Echo erschienen",
	warnEchoDown		= "Echo besiegt",
	specwarnAttenuation	= "%s auf %s (%s)",
	specwarnPlatform	= "Plattformwechsel"
})

L:SetOptionLocalization({
	warnEcho			= "Verkünde das Erscheinen eines Echos",
	warnEchoDown		= "Verkünde den Sieg über ein Echo",
	specwarnPlatform	= "Spezialwarnung bei Plattformwechsel des Bosses",
	ArrowOnAttenuation	= "Zeige DBM-Pfeil während $spell:127834 zur Anzeige der Ausweichrichtung"
})

L:SetMiscLocalization({
	Platform	= "fliegt zu einer seiner Plattformen!",
	Defeat		= "Wir werden der Verzweiflung der dunklen Leere nicht nachgeben. Wenn es Ihr Wille ist, dass wir dahinscheiden, dann soll es so sein."
})

------------
-- Blade Lord Ta'yak --
------------
L = DBM:GetModLocalization(744)

-------------------------------
-- Garalon --
-------------------------------
L = DBM:GetModLocalization(713)

L:SetWarningLocalization({
	warnCrush		= "%s",
	specwarnUnder	= "Raus aus dem violetten Kreis!"
})

L:SetOptionLocalization({
	specwarnUnder	= "Spezialwarnung, wenn du dich unter dem Boss befindest",
})

L:SetMiscLocalization({
	UnderHim	= "Unter ihm",
	Phase2		= "Plattenrüstung reißt und platzt auf" --needs to be verified (video-captured translation, hero only)
})

----------------------
-- Wind Lord Mel'jarak --
----------------------
L = DBM:GetModLocalization(741)

------------
-- Amber-Shaper Un'sok --
------------
L = DBM:GetModLocalization(737)

L:SetWarningLocalization({
	warnReshapeLife				= "%s auf >%s< (%d)",
	warnReshapeLifeTutor		= "1: Unterbreche/Debuffe Ziel (zum Aufbau von Debuff-Stapeln auf dem Boss benutzen), 2: Unterbreche dich selbst beim Wirken einer Bernexplosion, 3: Regeneriere Willen (primär in Phase 3 bei geringem Willen nutzen), 4: Verlasse Konstrukt (nur Phase 1 und 2)",
	warnAmberExplosion			= ">%s< wirkt %s",
	warnAmberExplosionAM		= "Bernmonstrosität wirkt Bernexplosion - Jetzt unterbrechen!",
	warnInterruptsAvailable		= "Unterbrechungen verfügbar für %s: >%s<",
	warnWillPower				= "Aktueller Willen: %s",
	specwarnWillPower			= "Geringer Willen! - Konstrukt verlassen oder Pfütze verzehren",
	specwarnAmberExplosionYou	= "Unterbreche DEINE %s!",
	specwarnAmberExplosionAM	= "%s: Unterbreche %s!",
	specwarnAmberExplosionOther	= "%s: Unterbreche %s!"
})

L:SetTimerLocalization({
	timerDestabalize		= "Destabilisieren (%2$d) : %1$s",
	timerAmberExplosionAMCD	= "Explosion CD: Monstrosität"
})

L:SetOptionLocalization({
	warnReshapeLifeTutor		= "Zeige Überblick über den Zweck der Fähigkeiten Mutierter Konstrukte",
	warnAmberExplosion			= "Zeige Warnung (mit Quelle), wenn $spell:122398 gewirkt wird",
	warnAmberExplosionAM		= "Zeige persönliche Warnung, wenn Bernmonstrosität $spell:122398 wirkt (zum Unterbrechen)",
	warnInterruptsAvailable		= "Verkünde bei wem Bernstoß-Unterbrechungen für $spell:122402 verfügbar sind",
	warnWillPower				= "Verkünde aktuellen Willen bei 80, 50, 30, 10 und 4",
	specwarnWillPower			= "Spezialwarnung bei geringem Willen als Mutiertes Konstrukt",
	specwarnAmberExplosionYou	= "Spezialwarnung zum Unterbrechen deiner eigenen $spell:122398",
	specwarnAmberExplosionAM	= "Spezialwarnung zum Unterbrechen der $spell:122402 der Bernmonstrosität",
	specwarnAmberExplosionOther	= "Spezialwarnung zum Unterbrechen der $spell:122398 unkontrollierter Mutierter Konstrukte",
	timerAmberExplosionAMCD		= "Zeige Zeit bis nächste $spell:122402 der Bernmonstrosität",
	InfoFrame					= "Zeige Infofenster für Willen der Spieler"
})

L:SetMiscLocalization({
	WillPower	= "Willen"
})

------------
-- Grand Empress Shek'zeer --
------------
L = DBM:GetModLocalization(743)

L:SetWarningLocalization({
	warnAmberTrap	= "Bernfallenbau: %d/5"
})

L:SetOptionLocalization({
	warnAmberTrap	= "Verkünde den Fortschritt beim Bau einer $spell:125826",
	InfoFrame		= "Zeige Infofenster für Spieler, welche von $spell:125390 betroffen sind"
})

L:SetMiscLocalization({
	PlayerDebuffs	= "Fixiert",
	YellPhase3		= "KEINE AUSREDEN MEHR, KAISERIN! Tötet diese Idioten oder ich selbst mache Euch den Garaus!"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("HoFTrash")

L:SetGeneralLocalization({
	name	= "Trash des Herz der Angst"
})

------------
-- Protectors of the Endless --
------------
L = DBM:GetModLocalization(683)

L:SetWarningLocalization({
	warnGroupOrder		= "Neue Gruppe für Verderbte Essenz: %s",
	specWarnYourGroup	= "Deine Gruppe ist dran!"
})

L:SetOptionLocalization({
	warnGroupOrder		= "Verkünde Gruppenrotation für $spell:118191<br/>(unterstützt derzeit nur 25-Spieler, Strategie: 5222 1222 1222 1222 1111)",
	specWarnYourGroup	= "Spezialwarnung, wenn deine Gruppe bei $spell:118191 dran ist (unterstützt derzeit nur 25-Spieler, siehe oben)",
	RangeFrame			= DBM_CORE_L.AUTO_RANGE_OPTION_TEXT:format(8, 111850) .. "<br/>(zeigt jeden, falls du den Debuff hast; sonst nur betroffene Spieler)"
})

------------
-- Tsulong --
------------
L = DBM:GetModLocalization(742)

L:SetMiscLocalization{
	Victory	= "Ich danke Euch, Fremdlinge. Ich wurde befreit."
}

-------------------------------
-- Lei Shi --
-------------------------------
L = DBM:GetModLocalization(729)

L:SetWarningLocalization({
	warnHideOver	= "%s ist beendet"
})

L:SetTimerLocalization({
	timerSpecialCD	= "Spezialfähigkeiten CD (%d)"
})

L:SetOptionLocalization({
	warnHideOver	= "Zeige Warnung, wenn $spell:123244 beendet ist",
	timerSpecialCD	= "Abklingzeit der Spezialfähigkeiten anzeigen",
	RangeFrame		= DBM_CORE_L.AUTO_RANGE_OPTION_TEXT:format(3, 123121) .. "<br/>(zeigt jeden während $spell:123244, sonst nur die Tanks)"
})

L:SetMiscLocalization{
	Victory	= "Ich... ah... oh! Hab ich...? War ich...? Es war... so... trüb."
}

----------------------
-- Sha of Fear --
----------------------
L = DBM:GetModLocalization(709)

L:SetWarningLocalization({
	MoveWarningForward			= "Lauf durch",
	MoveWarningRight			= "Lauf nach rechts",
	MoveWarningBack				= "Lauf in alte Position",
	specWarnBreathOfFearSoon	= "Odem der Furcht bald - LAUFE in die Lichtmauer!"
})

L:SetTimerLocalization({
	timerSpecialAbilityCD	= "Nächste Spezialfähigkeit",
	timerSpoHudCD			= "Angst/Fontäne CD", -- Furchterfülltes Kauern / Wasserfontäne
	timerSpoStrCD			= "Fontäne/Stoß CD", -- Wasserfontäne / Unerbittlicher Stoß
	timerHudStrCD			= "Angst/Stoß CD" -- Furchterfülltes Kauern / Stoß
})

L:SetOptionLocalization({
	warnBreathOnPlatform		= "Zeige Warnung für $spell:119414, falls du auf einem der äußeren Schreine bist (nicht allgemein empfohlen, gedacht für Schlachtzugsleiter)",
	specWarnBreathOfFearSoon	= "Spezialvorwarn. für $spell:119414, falls dir der $spell:117964 Buff fehlt",
	specWarnMovement			= "Spezialwarnung zum Laufen bei $spell:120047",
	timerSpecialAbility			= "Zeige Zeit bis nächste Spezialfähigkeit gewirkt wird"
})

--------------------------
-- Jin'rokh the Breaker --
--------------------------
L = DBM:GetModLocalization(827)

L:SetWarningLocalization({
	specWarnWaterMove	= "%s bald - Raus aus dem leitfähigen Wasser!"
})

L:SetOptionLocalization({
	specWarnWaterMove	= "Spezialwarnung, falls du in $spell:138470 stehst (warnt bevor $spell:137313 gewirkt wird und kurz bevor $spell:138732 ausläuft)"
})

--------------
-- Horridon --
--------------
L = DBM:GetModLocalization(819)

L:SetWarningLocalization({
	warnAdds				= "%s",
	warnOrbofControl		= "Kugel der Kontrolle fallen gelassen",
	specWarnOrbofControl	= "Kugel der Kontrolle fallen gelassen!"
})

L:SetTimerLocalization({
	timerDoor	= "Nächstes Stammestor",
	timerAdds	= "Nächster %s"
})

L:SetOptionLocalization({
	warnAdds				= "Verkünde das Herunterspringen neuer Gegner",
	warnOrbofControl		= "Verkünde das Fallenlassen einer $journal:7092",
	specWarnOrbofControl	= "Spezialwarnung beim Fallenlassen einer $journal:7092",
	timerDoor				= "Zeige Zeit bis nächste Stammestorphase",
	timerAdds				= "Zeige Zeit bis der nächste Gegner herunterspringt",
	SetIconOnAdds			= "Setze Zeichen auf Balkongegner"
})

L:SetMiscLocalization({
	newForces		= "stürmen aus dem Stammestor",
	chargeTarget	= "schlägt mit dem Schwanz auf den Boden!"
})

---------------------------
-- The Council of Elders --
---------------------------
L = DBM:GetModLocalization(816)

L:SetWarningLocalization({
	specWarnPossessed	= "%s auf %s - Ziel wechseln"
})

L:SetOptionLocalization({
	AnnounceCooldowns	= "Zähle akustisch die Anzahl der $spell:137166 Wirkungen<br/>(für \"Raid-Cooldowns\")"
})

------------
-- Tortos --
------------
L = DBM:GetModLocalization(825)

L:SetWarningLocalization({
	warnKickShell			= "%s genutzt von >%s< (%d verbleibend)",
	specWarnCrystalShell	= "Hole %s"
})

L:SetOptionLocalization({
	specWarnCrystalShell	= "Spezialwarnung, falls dir der $spell:137633 Buff fehlt",
	InfoFrame				= "Zeige Infofenster für Spieler ohne $spell:137633<br/>mit mehr als 90% Lebenspunkten",
	ClearIconOnTurtles		= "Entferne Zeichen von $journal:7129 im Zustand $spell:133971",
	AnnounceCooldowns		= "Zähle akustisch die Anzahl der $spell:134920 Wirkungen<br/>(für \"Raid-Cooldowns\")"
})

L:SetMiscLocalization({
	WrongDebuff	= "Kein %s"
})

-------------
-- Megaera --
-------------
L = DBM:GetModLocalization(821)

L:SetTimerLocalization({
	timerBreathsCD	= "Nächster Atem"
})

L:SetOptionLocalization({
	timerBreaths			= "Zeige Zeit bis nächster Atem<br/>($spell:139843 / $spell:137731 / $spell:139840 / $spell:139993)",
	AnnounceCooldowns		= "Zähle akustisch die Anzahl der \"Toben\"-Wirkungen (für \"Raid-Cooldowns\")",
	Never					= "Nie",
	Every					= "Jede (fortlaufende Zählung)",
	EveryTwo				= "Jede (zyklisch bis 2)",
	EveryThree				= "Jede (zyklisch bis 3)",
	EveryTwoExcludeDiff		= "Ohne Diffusion (zyklisch bis 2)",
	EveryThreeExcludeDiff	= "Ohne Diffusion (zyklisch bis 3)"
})

L:SetMiscLocalization({
	rampageEnds	= "Megaeras Wut lässt nach."
})

------------
-- Ji-Kun --
------------
L = DBM:GetModLocalization(828)

L:SetWarningLocalization({
	warnFlock			= "%s - %s %s",
	specWarnFlock		= "%s - %s %s",
	specWarnBigBird		= "Nestwächter: %s",
	specWarnBigBirdSoon	= "Nestwächter bald: %s"
})

L:SetTimerLocalization({
	timerFlockCD	= "Nest (%d): %s"
})

L:SetOptionLocalization({
	ShowNestArrows	= "Zeige DBM-Pfeil für Nestaktivierung",
	Never			= "Nie",
	Northeast		= "Blau - Unten NO & Oben NO",
	Southeast		= "Grün - Unten SO & Oben SO",
	Southwest		= "Violett/Rot - Unten SW & Oben SW/Mitte (25er/10er)",
	West			= "Rot - Unten W & Oben Mitte (nur 25er)",
	Northwest		= "Gelb - Unten NW & Oben NW (nur 25er)",
	Guardians		= "Nestwächter"
})

L:SetMiscLocalization({
	eggsHatch		= "Nester beginnen, aufzubrechen!",
	Upper			= "Oben",
	Lower			= "Unten",
	UpperAndLower	= "Oben & Unten",
	TrippleD		= "Dreifach (2xUnten)",
	TrippleU		= "Dreifach (2xOben)",
	NorthEast		= "|cff0000ffNO|r",
	SouthEast		= "|cFF088A08SO|r",
	SouthWest		= "|cFF9932CDSW|r",
	West			= "|cffff0000W|r",
	NorthWest		= "|cffffff00NW|r",
	Middle10		= "|cFF9932CDMitte|r",
	Middle25		= "|cffff0000Mitte|r"
})

--------------------------
-- Durumu the Forgotten --
--------------------------
L = DBM:GetModLocalization(818)

L:SetWarningLocalization({
	warnBeamNormal				= "Strahlen - |cffff0000Rot|r : >%s<, |cff0000ffBlau|r : >%s<",
	warnBeamHeroic				= "Strahlen - |cffff0000Rot|r : >%s<, |cff0000ffBlau|r : >%s<, |cffffff00Gelb|r : >%s<",
	warnAddsLeft				= "Nebel verbleibend: %d",
	specWarnBlueBeam			= "Blaue Strahlen auf dir - Bleib möglichst stehen",
	specWarnFogRevealed			= "%s offenbart!",
	specWarnDisintegrationBeam	= "%s (%s)"
})

L:SetOptionLocalization({
	warnBeam			= "Verkünde Ziele der Farbstrahlen",
	warnAddsLeft		= "Verkünde die Anzahl der verbleibenden Nebel",
	specWarnFogRevealed	= "Spezialwarnung, wenn ein Nebel offenbart wird",
	ArrowOnBeam			= "Zeige DBM-Pfeil während $journal:6882 zur Anzeige der Ausweichrichtung",
	InfoFrame			= "Zeige Infofenster für $spell:133795 Stapel",
	SetParticle			= "Grafikeinstellung 'Partikeldichte' automatisch auf 'Niedrig' setzen<br/>(wird nach dem Kampfende auf die vorherige Einstellung zurückgesetzt)"
})

L:SetMiscLocalization({
	LifeYell	= "Lebensentzug auf %s (%d)"
})

----------------
-- Primordius --
----------------
L = DBM:GetModLocalization(820)

L:SetWarningLocalization({
	warnDebuffCount	= "Mutationen: %d/5 gute, %d schlechte"
})

L:SetOptionLocalization({
	warnDebuffCount		= "Zeige Warnung für die Debuffanzahl, wenn du Pfützen absorbierst",
	SetIconOnBigOoze	= "Setze Zeichen auf $journal:6969"
})

-----------------
-- Dark Animus --
-----------------
L = DBM:GetModLocalization(824)

L:SetWarningLocalization({
	warnMatterSwapped	= "%s: >%s< und >%s< getauscht"
})

L:SetOptionLocalization({
	warnMatterSwapped	= "Verkünde getauschte Ziele durch $spell:138618"
})

L:SetMiscLocalization({
	Pull	= "Die Kugel explodiert!"
})

--------------
-- Iron Qon --
--------------
L = DBM:GetModLocalization(817)

L:SetWarningLocalization({
	warnDeadZone	= "%s: %s und %s abgeschirmt"
})

L:SetOptionLocalization({
	RangeFrame	= "Zeige dynamisches Abstandsfenster (10m)<br/>(mit Indikator für zuviele Spieler in Reichweite)",
	InfoFrame	= "Zeige Infofenster für Spieler mit $spell:136193"
})

-------------------
-- Twin Consorts --
-------------------
L = DBM:GetModLocalization(829)

L:SetWarningLocalization({
	warnNight	= "Nachtphase",
	warnDay		= "Tagphase",
	warnDusk	= "Dämmerungsphase"
})

L:SetTimerLocalization({
	timerDayCD	= "Nächste Tagphase",
	timerDuskCD	= "Nächste Dämmerungsphase"
})

L:SetMiscLocalization({
	DuskPhase	= "Lu'lin, leiht mir Eure Kraft!"
})

--------------
-- Lei Shen --
--------------
L = DBM:GetModLocalization(832)

L:SetWarningLocalization({
	specWarnIntermissionSoon	= "Unterbrechung bald",
	warnDiffusionChainSpread	= "%s gesprungen auf >%s<"
})

L:SetTimerLocalization({
	timerConduitCD	= "Erste Leitung CD"
})

L:SetOptionLocalization({
	specWarnIntermissionSoon	= "Spezialvorwarnung für Unterbrechung",
	warnDiffusionChainSpread	= "Verkünde Sprungziele von $spell:135991",
	timerConduitCD				= "Abklingzeit der Fähigkeit der ersten Leitung anzeigen",
	StaticShockArrow			= "Zeige DBM-Pfeil, wenn jemand von $spell:135695 betroffen ist",
	OverchargeArrow				= "Zeige DBM-Pfeil, wenn jemand von $spell:136295 betroffen ist"
})

L:SetMiscLocalization({
	StaticYell	= "Elektroschock auf %s (%d)"
})

------------
-- Ra-den --
------------
L = DBM:GetModLocalization(831)

L:SetWarningLocalization({
	specWarnUnstablVitaJump	= "Instabile Vita ist auf dich übergesprungen!"
})

L:SetOptionLocalization({
	specWarnUnstablVitaJump	= "Spezialwarnung, wenn $spell:138297 auf dich überspringt"
})

L:SetMiscLocalization({
	Defeat	= "Wartet!"--needs to be verified (video-captured translation)
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("ToTTrash")

L:SetGeneralLocalization({
	name	= "Trash des Thron des Donners"
})

---------------
-- Immerseus --
---------------
L = DBM:GetModLocalization(852)

L:SetMiscLocalization({
	Victory	= "Ah, Ihr habt es geschafft! Das Wasser ist wieder rein."
})

---------------------------
-- The Fallen Protectors --
---------------------------
L = DBM:GetModLocalization(849)

L:SetWarningLocalization({
	specWarnCalamity	= "%s",
	specWarnMeasures	= "Verzweifelte Maßnahmen bald (%s)!"
})

---------------------------
-- Norushen --
---------------------------
L = DBM:GetModLocalization(866)

L:SetMiscLocalization({
	wasteOfTime	= "Nun gut, ich werde ein Feld erschaffen, das Eure Verderbnis eindämmt."
})

------------------
-- Sha of Pride --
------------------
L = DBM:GetModLocalization(867)

L:SetOptionLocalization({
	SetIconOnFragment	= "Setze Zeichen auf Verderbtes Fragment"
})

--------------
-- Galakras --
--------------
L = DBM:GetModLocalization(868)

L:SetWarningLocalization({
	warnTowerOpen	= "Turm offen",
	warnTowerGrunt	= "Turmgrunzer"
})

L:SetTimerLocalization({
	timerTowerCD		= "Nächster Turm",
	timerTowerGruntCD	= "Nächster Turmgrunzer"
})

L:SetOptionLocalization({
	warnTowerOpen		= "Verkünde, wenn ein Turm geöffnet wurde",
	warnTowerGrunt		= "Verkünde das Erscheinen eines Turmgrunzers",
	timerTowerCD		= "Zeige Zeit bis nächsten Turmangriff",
	timerTowerGruntCD	= "Zeige Zeit bis nächster Turmgrunzer erscheint"
})

L:SetMiscLocalization({
	wasteOfTime		= "Well done! Landing parties, form up! Footmen to the front!",--translate (alliance trigger)
	wasteOfTime2	= "Gute Arbeit. Die erste Kompanie ist an Land.",
	Pull			= "Drachenmalklan, nehmt den Hafen wieder ein und treibt sie ins Meer! Im Namen Höllschreis und der wahren Horde!",
	newForces1		= "Da kommen sie!",--needs to be verified (wowhead-captured translation) (alliance)
	newForces1H		= "Holt sie schnell vom Himmel, damit ich sie erwürgen kann.",
	newForces2		= "Drachenmalklan, ausrücken!",
	newForces3		= "Für Höllschrei!",
	newForces4		= "Nächster Trupp, vorwärts!",
	tower			= "Das Tor zum"--"Das Tor zum Nordturm ist durchbrochen!"/"Das Tor zum Südturm ist durchbrochen!"
})

--------------------------
-- Kor'kron Dark Shaman --
--------------------------
L = DBM:GetModLocalization(856)

L:SetMiscLocalization({
	PrisonYell	= "Gefängnis auf %s schwindet (%d)"
})

---------------------
-- General Nazgrim --
---------------------
L = DBM:GetModLocalization(850)

L:SetWarningLocalization({
	warnDefensiveStanceSoon	= "Verteidigungshaltung in %ds"
})

L:SetMiscLocalization({
	newForces1	= "Krieger, im Laufschritt!",
	newForces2	= "Verteidigt das Tor!",
	newForces3	= "Truppen, sammelt Euch!",
	newForces4	= "Kor'kron, zu mir!",
	newForces5	= "Nächste Staffel, nach vorn!",
	allForces	= "Alle Kor'kron unter meinem Befehl, tötet sie! Jetzt!",
	nextAdds	= "Nächste Adds: "
})

------------------------
-- Spoils of Pandaria --
------------------------
L = DBM:GetModLocalization(870)

L:SetMiscLocalization({
	wasteOfTime	= "Hallo? Mikrofontest... 1, 2, 3 – ok. Goblinisch-titanisches Steuerungsmodul wird gestartet, bitte zurückbleiben.",
	Module1 	= "Modul 1 bereit für den Systemneustart.",
	Victory		= "Modul 2 bereit für den Systemneustart."
})

---------------------------
-- Thok the Bloodthirsty --
---------------------------
L = DBM:GetModLocalization(851)

L:SetOptionLocalization({
	RangeFrame	= "Zeige dynamisches Abstandsfenster (10m)<br/>(mit Indikator für den \"Blutrausch\"-Schwellwert)"
})

----------------------------
-- Siegecrafter Blackfuse --
----------------------------
L = DBM:GetModLocalization(865)

L:SetMiscLocalization({
	newWeapons	= "Unfertige Waffen werden auf das Fabrikationsband befördert.",
	newShredder	= "Ein automatisierter Schredder nähert sich!"
})

----------------------------
-- Paragons of the Klaxxi --
----------------------------
L = DBM:GetModLocalization(853)

L:SetWarningLocalization({
	specWarnActivatedVulnerable	= "%s wird dir erhöhten Schaden zufügen - Meiden!",
	specWarnMoreParasites		= "Es werden mehr Parasiten benötigt - NICHT blocken!"
})

L:SetOptionLocalization({
	specWarnActivatedVulnerable	= "Spezialwarnung, wenn dir ein neuer Getreuer erhöhten Schaden zufügen wird",
	specWarnMoreParasites		= "Spezialwarnung, wenn mehr Parasiten benötigt werden"
})

L:SetMiscLocalization({
	one				= "Eins",
	two				= "Zwei",
	three			= "Drei",
	four			= "Vier",--needs to be verified (guessed)
	five			= "Fünf",--needs to be verified (guessed)
	hisekFlavor		= "Na, wer wurde jetzt zum Schweigen gebracht?",
	KilrukFlavor	= "Ein weiterer Tag der Vernichtung des Schwarms!",
	XarilFlavor		= "I sehe nur finstere Himmel in deiner Zukunft!",
	KaztikFlavor	= "Zerkleinert zu bloßen Kunchong-Leckereien!",
	KaztikFlavor2	= "1 Mantis tot, nur noch 199 weitere verbleibend!",
	KorvenFlavor	= "Das Ende eines uralten Reiches!",
	KorvenFlavor2	= "Nimm deine Gurthanitafeln und ersticke daran!",
	IyyokukFlavor	= "Erkennt die Möglichkeiten. Nutzt sie aus!",
	KarozFlavor		= "Du wirst nicht mehr herumspringen!",
	SkeerFlavor		= "Ein blutiges Vergnügen!",
	RikkalFlavor	= "Probenanforderung abgeschlossen!"
})

------------------------
-- Garrosh Hellscream --
------------------------
L = DBM:GetModLocalization(869)

L:SetTimerLocalization({
	timerRoleplay	= GUILD_INTEREST_RP
})

L:SetOptionLocalization({
	timerRoleplay		= "Dauer des Garrosh/Thrall-Rollenspiels anzeigen",
	RangeFrame			= "Zeige dynamisches Abstandsfenster (8m)<br/>(mit Indikator für den $spell:147088 Schwellwert)",
	InfoFrame			= "Zeige Infofenster für Spieler ohne Schadensreduzierung während der Unterbrechungsphasen"
})

L:SetMiscLocalization({
	wasteOfTime		= "Es ist noch nicht zu spät, Garrosh. Legt den Mantel des Kriegshäuptlings ab. Wir können dies hier beenden, jetzt, ohne Blutvergießen.",
	NoReduce		= "Keine Schadensreduzierung",

	phase3End		= "You think you have WON?" --translate (trigger)
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("SoOTrash")

L:SetGeneralLocalization({
	name	= "Trash der Schlacht um Orgrimmar"
})
