if GetLocale() ~= "itIT" then
	return
end

local L

------------
-- The Stone Guard --
------------
L = DBM:GetModLocalization(679)

L:SetWarningLocalization({
	SpecWarnOverloadSoon	= "%s tra 7s!"
})

L:SetOptionLocalization({
	SpecWarnOverloadSoon	= "Mostra un avviso speciale prima del Sovraccarico"
})

L:SetMiscLocalization({
	Overload	= "%s sta per Sovraccaricarsi!"
})

------------
-- Feng the Accursed --
------------
L = DBM:GetModLocalization(689)

L:SetWarningLocalization({
	WarnPhase	= "Fase %d"
})

L:SetOptionLocalization({
	WarnPhase	= "Annuncia le Transizioni di Fase"
})

L:SetMiscLocalization({
	Fire	= "Oh, potente! Attraverso me scioglierai la carne dalle ossa!", -- Copied from ChatLog
	Arcane	= "Oh, saggio delle ere! Concedimi la tua saggezza arcana!",-- Copied from ChatLog
	Nature	= "Oh, grande spirito... concedimi il potere della terra!",---- Copied from ChatLog
	Shadow	= "Grande spirito dei campioni del passato! concedimi il tuo scudo!"-- Need Review
})

-------------------------------
-- Gara'jal the Spiritbinder --
-------------------------------
L = DBM:GetModLocalization(682)

L:SetMiscLocalization({
	Pull	= "È giunta l'ora di schiattare!" -- ChatLog
})

----------------------
-- The Spirit Kings --
----------------------
L = DBM:GetModLocalization(687)

L:SetOptionLocalization({
	RangeFrame	= "Mostra Monitor di Prossimita' (8)"
})

------------
-- Elegon --
------------
L = DBM:GetModLocalization(726)

L:SetWarningLocalization({
	specWarnDespawnFloor	= "Guarda dove metti i piedi!" -- NEED REVIEW
})

L:SetTimerLocalization({
	timerDespawnFloor	= "Guarda dove metti i piedi!" -- NEED REVIEW
})

L:SetOptionLocalization({
	specWarnDespawnFloor	= "Mostra un avviso speciale prima che il vortice svanisca",
	timerDespawnFloor		= "Mostra un timer per la scomparsa del vortice"
})

------------
-- Will of the Emperor --
------------
L = DBM:GetModLocalization(677)

L:SetOptionLocalization({
	InfoFrame	= "Visualizza nella Finestra Informativa chi e' afflitto da $spell:116525"
})

L:SetMiscLocalization({
	Pull		= "La macchina si mette in moto! Raggiungi il piano inferiore!",--Emote (ChatLog)
	Rage		= "La Rabbia dell'Imperatore risuona tra le colline.",--Yell (ChatLog)
	Strength	= "La Forza dell'Imperatore appare nelle volte!",--Emote (ChatLog)
	Courage		= "Il Coraggio dell'Imperatore appare nelle volte!",--Emote (ChatLog)
	Boss		= "Due Costrutti Titanici appaiono nelle alcove più grandi!"--Emote (ChatLog)
})

------------
-- Imperial Vizier Zor'lok --
------------
L = DBM:GetModLocalization(745)

L:SetWarningLocalization({
	specwarnPlatform	= "Platform change"
})

L:SetOptionLocalization({
	specwarnPlatform	= "Visualizza un avviso speciale quando il boss cambia piattaforme."
})

L:SetMiscLocalization({
	Platform	= "Il Visir Imperiale Zor'lok vola verso una delle sue piattaforme!",-- da Chat Log
	Defeat		= "We will not give in to the despair of the dark void. If Her will for us is to perish, then it shall be so."-- da tradurre con Chat Log
})

------------
-- Blade Lord Ta'yak --
------------
L = DBM:GetModLocalization(744)

L:SetOptionLocalization({
	RangeFrame			= "Visualizza il radar (8) per $spell:123175"
})

-------------------------------
-- Garalon --
-------------------------------
L = DBM:GetModLocalization(713)

----------------------
-- Wind Lord Mel'jarak --
----------------------
L = DBM:GetModLocalization(741)

L:SetMiscLocalization({
	Reinforcements		= "Wind Lord Mel'jarak calls for reinforcements!"
})

------------
-- Amber-Shaper Un'sok --
------------
L = DBM:GetModLocalization(737)

------------
-- Grand Empress Shek'zeer --
------------
L = DBM:GetModLocalization(743)

L:SetOptionLocalization({
	InfoFrame	= "Visualizza il frame di Informazioni per chi e' colpito da $spell:125390",
	RangeFrame	= "Visualizza il Radar di prossimita' (5) per $spell:123735"
})

L:SetMiscLocalization({
	PlayerDebuffs	= "Inseguito"
})

--------------------------
-- Jin'rokh the Breaker --
--------------------------
L = DBM:GetModLocalization(827)

--------------
-- Horridon --
--------------
L = DBM:GetModLocalization(819)

L:SetMiscLocalization({
	newForces		= "irrompono",--Le forze Farraki irrompono dalla loro porta!
	chargeTarget	= "posa il suo sguardo"--Horridon posa il suo sguardo su Slevint e sbatte la coda!
})

---------------------------
-- The Council of Elders --
---------------------------
L = DBM:GetModLocalization(816)

------------
-- Tortos --
------------
L = DBM:GetModLocalization(825)

-------------
-- Megaera --
-------------
L = DBM:GetModLocalization(821)

------------
-- Ji-Kun --
------------
L = DBM:GetModLocalization(828)

L:SetMiscLocalization({
	eggsHatch	= "iniziano a schiudersi"
})

--------------------------
-- Durumu the Forgotten --
--------------------------
L = DBM:GetModLocalization(818)

----------------
-- Primordius --
----------------
L = DBM:GetModLocalization(820)

-----------------
-- Dark Animus --
-----------------
L = DBM:GetModLocalization(824)

--------------
-- Iron Qon --
--------------
L = DBM:GetModLocalization(817)

-------------------
-- Twin Consorts --
-------------------
L = DBM:GetModLocalization(829)

--------------
-- Lei Shen --
--------------
L = DBM:GetModLocalization(832)

------------
-- Ra-den --
------------
L = DBM:GetModLocalization(831)
