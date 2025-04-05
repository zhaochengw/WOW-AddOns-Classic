if GetLocale() ~= "deDE" then return end
local L

--------------------------
--  General BG Options  --
--------------------------
L = DBM:GetModLocalization("PvPGeneral")

L:SetGeneralLocalization({
	name	= "Allgemeine Einstellungen"
})

L:SetTimerLocalization({
	TimerCap		= "%s",
	TimerFlag		= "Flaggenrespawn",
	TimerInvite		= "%s",
	TimerWin		= "Sieg in",
	TimerStart		= "Start in",
	TimerShadow		= "Schattensicht"})

L:SetOptionLocalization({
	TimerInvite			= "Zeige Zeit für Schlachtfeld-Beitrittsmöglichkeit",
	AutoSpirit			= "Automatisch Geist freilassen",
	ColorByClass		= "Einfärbung der Spielernamen nach Klasse in der Schlachtfeld-Punktetafel",
	HideBossEmoteFrame	= "Verberge das Fenster \"RaidBossEmoteFrame\" und Garnisons-/Gildenerfolgsmeldungen während Schlachtfeldern",
	ShowBasesToWin		= "Zeige Anzahl benötigter Basen zum Gewinnen",
	TimerCap			= "Zeige Timer für Eroberungen",
	TimerFlag			= "Zeige Timer für Flaggenrespawn",
	TimerStart			= "Zeige Timer für Start des Matches",
	TimerShadow			= "Zeige Timer für Schattensicht",
	TimerWin			= "Zeige Timer zum Sieg",
	ShowRelativeGameTime= "Sieg-Timer füllt sich relativ zur Startzeit des Schlachtfelds (Timer sieht immer fast fertig aus falls deaktiviert)"
})

L:SetMiscLocalization({
	-- Old string: "Die Schlacht beginnt in 2 Minuten."
	-- SoD arathi: "Die Schlacht um das Arathibecken wird in 2 Minuten beginnen."
	BgStart120          = "Die Schlacht .* in 2 Minuten",
	BgStart60			= "Die Schlacht .* in 1 Minute",
	BgStart30			= "Die Schlacht .* in 30 Sekunden",
	ArenaStart60		= "One minute until the Arena battle begins!",
	ArenaStart30		= "Thirty seconds until the Arena battle begins!",
	ArenaStart15		= "Fifteen seconds until the Arena battle begins!",
	ArenaInvite			= "Arenaeinladungen",
	BasesToWin			= "Basen benötigt zum Gewinnen: %d",
	WinBarText			= "%s gewinnt",
	-- TODO: Implement the flag carrying system
	FlagReset			= "The flag has been reset!", -- Unused
	FlagTaken			= "(.+) has taken the flag!", -- Unused
	FlagCaptured		= "The .+ ha%w+ captured the flag!",
	FlagDropped			= "The flag has been dropped!", -- Unused
	--
	ExprFlagPickUp		= "(.+) hat die Flagge der (%w+) aufgenommen!",
	ExprFlagCaptured	= "(.+) hat die Flagge der (%w+) errungen!",
	ExprFlagReturn		= "Die Flagge der (%w+) wurde von (.+) zu ihrem Stützpunkt zurückgebracht!",
	Vulnerable1			= "Eure Angriffe verursachen nun schwerere Verletzungen bei Flaggenträgern!",
	Vulnerable2			= "Eure Angriffe verursachen nun sehr schwere Verletzungen bei Flaggenträgern!",
	-- Alterac/IsleOfConquest/Ashenvale bosses
	InfoFrameHeader		= "[DBM] Boss HP",
	HordeBoss			= "Horde-Boss",
	AllianceBoss		= "Allianz-Boss",
	Galvangar			= "Galvangar",
	Balinda				= "Balinda",
	Ivus				= "Ivus",
	Lokholar			= "Lokholar",
	RunestoneBoss		= "Runestone",
	-- Note: no one ever seems to use the German words
	GlaiveBoss			= "Glaive",
	ResearchBoss		= "Research",
	MoonwellBoss		= "Moonwell",
	ShredderBoss		= "Shredder",
	CatapultBoss		= "Catapult",
	LumberBoss			= "Lumber",
	BonfireBoss			= "Bonfire",
	-- Ashran bosses
	Tremblade			= "Grand Marshall Tremblade",
	Volrath				= "High WArlord Volrath",
	Fangraal			= "Fangraal",
	Kronus				= "Kronus",
	-- Health sync frame
	Stale               = "(veraltet) ",


})
----------------------
--  Alterac Valley  --
----------------------
L = DBM:GetModLocalization("z30")

L:SetOptionLocalization({
	AutoTurnIn	= "Automatisches Abgeben der Quests im Alteractal",
	TimerBoss	= "Zeige Timer für verbleibende Zeit für Bosse"
})

------------------------
--  Isle of Conquest  --
------------------------
L = DBM:GetModLocalization("z628")

L:SetWarningLocalization({
	WarnSiegeEngine		= "Belagerungsmaschine bereit!",
	WarnSiegeEngineSoon	= "Belagerungsmaschine in ~10 Sekunden"
})

L:SetTimerLocalization({
	TimerSiegeEngine	= "Belagerungsmaschine"
})

L:SetOptionLocalization({
	TimerSiegeEngine	= "Zeige Zeit bis Belagerungsmaschine bereit ist",
	WarnSiegeEngine		= "Zeige Warnung, wenn Belagerungsmaschine bereit ist",
	WarnSiegeEngineSoon	= "Zeige Warnung, wenn Belagerungsmaschine fast bereit ist",
	ShowGatesHealth		= "Zeige Erhaltungsgrad beschädigter Tore (kann nach dem Beitritt<br/>zu einem bereits laufenden Schlachtfeld falsche Werte liefern!)"
})

L:SetMiscLocalization({
	GatesHealthFrame		= "Beschädigte Tore",
	SiegeEngine				= "Belagerungsmaschine",
	GoblinStartAlliance		= "Seht Ihr diese Zephyriumbomben? Benutzt sie an den Toren, während ich die Belagerungsmaschine repariere!",
	GoblinStartHorde		= "Ich arbeite an der Belagerungsmaschine. Haltet mir einfach nur den Rücken frei. Benutzt diese Zephyriumbomben an den Toren, solltet Ihr sie brauchen!",
	GoblinHalfwayAlliance	= "Ich hab's gleich! Haltet die Horde von hier fern. Kämpfen stand in der Ingenieursschule nicht auf dem Lehrplan!",
	GoblinHalfwayHorde		= "Ich hab's gleich! Haltet mir die Allianz vom Leib. Kämpfen steht nicht in meinem Vertrag!",
	GoblinFinishedAlliance	= "Meine beste Arbeit bisher! Diese Belagerungsmaschine ist bereit, ein bisschen Aktion zu sehen!",
	GoblinFinishedHorde		= "Die Belagerungsmaschine ist bereit, loszurollen!",
	GoblinBrokenAlliance	= "Es ist schon kaputt?! Ach, keine Sorge, nichts, was ich nicht reparieren kann.",
	GoblinBrokenHorde		= "Schon wieder kaputt?! Ich werde es richten... Ihr solltet allerdings nicht davon ausgehen, dass das noch unter die Garantie fällt."
})

-------------------------
--  Silvershard Mines  --
-------------------------
L = DBM:GetModLocalization("z727")

L:SetTimerLocalization({
	TimerRespawn	= "Wagen-Respawn"
})

L:SetOptionLocalization({
	TimerRespawn	= "Zeige Zeit bis zum Respawn der Wagen",
	TimerCart		= "Show cart cap timer"
})

L:SetMiscLocalization({
	Capture	= "hat eine Minenlore erobert",
	Arrived	= "has arived",
	Begun	= "has begun"
})

-------------------------
--  Temple of Kotmogu  --
-------------------------
L = DBM:GetModLocalization("z998")

L:SetMiscLocalization({
	OrbTaken	= "(%S+) hat die (%S+) Kugel genommen!",
	OrbReturn	= "Die (%S+) Kugel wurde zurückgebracht!"
})

----------------
--  Ashenvale --
----------------
L = DBM:GetModLocalization("m1440")

L:SetOptionLocalization({
	EstimatedStartTimer = "Zeige Timer für Startzeit des Events",
	HealthFrame         = "Zeige Infoframe mit Lebenspunkten der Bosses. Das Infoframe wird über deinen Raid und den Yell Chat mit anderen Raids synchronisiert. Diese Option funktioniert nur zuverlässig wenn mindestens ein Raid in der Zone über mehrere Bosse verteilt ist und genug Spieler DBM-PvP installiert haben."
})

L:SetTimerLocalization({
	EstimatedStart = "Event startet"
})

-----------------
--  Blood Moon --
-----------------
L = DBM:GetModLocalization("m1434")

L:SetMiscLocalization({
	ResTimerSelf = "Zeige Timer für Wiederbelebung.",
	ResTimerParty = "Zeige Timer für Wiederbelebung von Partymitgliedern.",
	ResTimerPartyClassColors = "Benutze Klassenfarben für Wiederbelebungstimer von Partymitgliedern.",
})
