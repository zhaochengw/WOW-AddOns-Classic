if GetLocale() ~= "deDE" then return end
local L

--------------
-- Brawlers --
--------------
L= DBM:GetModLocalization("BrawlersGeneral")

L:SetGeneralLocalization({
	name = "Kampfgilde: Einstellungen"
})

L:SetWarningLocalization({
	warnQueuePosition2	= "Du bist %d. in der Warteschlange.",
	specWarnYourNext	= "Du bist als nächstes dran!",
	specWarnYourTurn	= "Du bist dran!"
})

L:SetOptionLocalization({
	warnQueuePosition2	= "Verkünde deine aktuelle Position in der Warteschlange<br/>(bei jeder Änderung)",
	specWarnYourNext	= "Spezialwarnung, wenn du als nächstes dran bist",
	specWarnYourTurn	= "Spezialwarnung, wenn es dein Kampf ist",
	SpectatorMode		= "Zeige Warnungen/Timer auch beim Zuschauen fremder Kämpfe<br/>(persönliche Spezialwarnungsmeldungen werden nicht angezeigt)",
	SpeakOutQueue		= "Verkünde akustisch deine aktuelle Position in der Warteschlange<br/>(bei jeder Änderung)",
	NormalizeVolume		= "Setze im Kampfgildengebiet die Lautstärke des DIALOG-Audiokanals automatisch auf die Lautstärke des SFX-Audiokanals, damit der Jubel nicht so laut ist."
})

L:SetMiscLocalization({
	Bizmo			= "Bizmo",--Alliance
	Bazzelflange	= "Boss Nobelflansch",--Horde
	BizmoIgnored	= "We Don't have all night. Hurry it up already!",--translate (trigger)
	BizmoIgnored2	= "Do you smell smoke?",--translate (trigger)
	BizmoIgnored3	= "I think it's about time to call this fight.",--translate (trigger)
	BizmoIgnored4	= "Is it getting hot in here? Or is it just me?",--translate (trigger)
	--I wish there was a better way to do this....so much localizing. :(
	Rank1			= "ersten Ranges",
	Rank2			= "zweiten Ranges",
	Rank3			= "dritten Ranges",
	Rank4			= "vierten Ranges",
	Rank5			= "fünften Ranges",
	Rank6			= "sechsten Ranges",
	Rank7			= "siebten Ranges",
	Rank8			= "achten Ranges",
	Rank9			= "9. Ranges",
	Rank10			= "Rang-10-Grubenkampfchampion",
	Proboskus		= "Oje... tut mir leid, aber Ihr werdet wohl gegen Proboskus antreten müssen.",--Alliance - needs to be verified (wowhead-captured translation)
	Proboskus2		= "Ha ha ha! Was habt Ihr auch für ein Pech! Es ist Proboskus! Ahhh ha ha ha! Ich hab fünfundzwanzig Goldstücke darauf gesetzt, dass Ihr im Feuer draufgeht!"--Horde
})

------------
-- Rank 1 --
------------
L= DBM:GetModLocalization("BrawlRank1")

L:SetGeneralLocalization({
	name = "Kampfgilde: Rang 1"
})

------------
-- Rank 2 --
------------
L= DBM:GetModLocalization("BrawlRank2")

L:SetGeneralLocalization({
	name = "Kampfgilde: Rang 2"
})

L:SetOptionLocalization({
	SetIconOnBlat	= "Setze Zeichen auf echten \"Blat\" (Totenkopf)"
})

------------
-- Rank 3 --
------------
L= DBM:GetModLocalization("BrawlRank3")

L:SetGeneralLocalization({
	name = "Kampfgilde: Rang 3"
})

------------
-- Rank 4 --
------------
L= DBM:GetModLocalization("BrawlRank4")

L:SetGeneralLocalization({
	name = "Kampfgilde: Rang 4"
})

------------
-- Rank 5 --
------------
L= DBM:GetModLocalization("BrawlRank5")

L:SetGeneralLocalization({
	name = "Kampfgilde: Rang 5"
})

------------
-- Rank 6 --
------------
L= DBM:GetModLocalization("BrawlRank6")

L:SetGeneralLocalization({
	name = "Kampfgilde: Rang 6"
})

------------
-- Rank 7 --
------------
L= DBM:GetModLocalization("BrawlRank7")

L:SetGeneralLocalization({
	name = "Kampfgilde: Rang 7"
})

--[[
------------
-- Rank 8 --
------------
L= DBM:GetModLocalization("BrawlRank8")

L:SetGeneralLocalization({
	name = "Kampfgilde: Rang 8"
})

------------
-- Rank 9 --
------------
L= DBM:GetModLocalization("BrawlRank9")

L:SetGeneralLocalization({
	name = "Kampfgilde: Rang 9"
})
--]]

-------------
-- Brawlers: Legacy --
-------------
L= DBM:GetModLocalization("BrawlLegacy")

L:SetGeneralLocalization({
	name = "Kampfgilde: alte Gegner"
})

L:SetOptionLocalization({
	SpeakOutStrikes		= "Verkünde akustisch die Anzahl der $spell:141190 Angriffe"
})

-------------
-- Brawlers: Challenges --
-------------
L= DBM:GetModLocalization("BrawlChallenges")

L:SetGeneralLocalization({
	name = "Kampfgilde: Herausforderungen"
})

L:SetWarningLocalization({
	specWarnRPS			= "Benutze %s!"
})

L:SetOptionLocalization({
	ArrowOnBoxing		= "Zeige DBM-Pfeil während $spell:140868, $spell:140862 und $spell:140886",
	specWarnRPS			= "Spezialwarnung für die richtige Auswahl bei $spell:141206"
})

L:SetMiscLocalization({
	rock			= "Stein",
	paper			= "Papier",
	scissors		= "Schere"
})

-------------
-- Brawlers: Rumble --
-------------
L= DBM:GetModLocalization("BrawlRumble")

L:SetGeneralLocalization({
	name = "Kampfgilde: Prügeleien"
})
