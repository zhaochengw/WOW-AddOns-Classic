if GetLocale() ~= "frFR" then
	return
end
local L

------------
-- The Stone Guard --
------------
L = DBM:GetModLocalization(679)

L:SetWarningLocalization({
	SpecWarnOverloadSoon		= "%s bientôt !", -- prepare survival ablility or move boss. need more specific message.
	specWarnBreakJasperChains	= "Cassez les Chaînes de Jaspe !"
})

L:SetOptionLocalization({
	SpecWarnOverloadSoon		= "Alerte spéciale avant la surcharge",
	specWarnBreakJasperChains	= "Alerte spéciale quand il est sûr de casser $spell:130395",
	InfoFrame					= "Afficher le cadre d'information pour la puissance des boss, la pétrification des joueurs, et quand le boss lance la pétrification"
})

L:SetMiscLocalization({
	Overload	= "%s est sur le point de surcharger !"
})

------------
-- Feng the Accursed --
------------
L = DBM:GetModLocalization(689)

L:SetWarningLocalization({
	WarnPhase	= "Phase %d"
})

L:SetOptionLocalization({
	WarnPhase	= "Annoncer la transition de Phase",
	RangeFrame	= "Afficher le cadre de distance (6m) durant la phase d'arcane"
})

L:SetMiscLocalization({
	Fire	= "Ô être exalté ! Grâce à moi vous ferez fondre la chair et les os !",
	Arcane	= "Ô sagesse ancestrale ! Distille en moi ta sagesse arcanique !",
	Nature	= "Ô grand esprit ! Accorde-moi le pouvoir de la terre !",
	Shadow	= "Grandes âmes des champions du passé ! Confiez-moi votre bouclier !"
})

-------------------------------
-- Gara'jal the Spiritbinder --
-------------------------------
L = DBM:GetModLocalization(682)

L:SetMiscLocalization({
	Pull	= "L'heure de mourir elle est arrivée maintenant !"
})

----------------------
-- The Spirit Kings --
----------------------
L = DBM:GetModLocalization(687)

L:SetWarningLocalization({
	DarknessSoon		= "Bouclier des ténèbres sur %ds"
})

L:SetTimerLocalization({
	timerUSRevive		= "Ombres éternelles reconstitué",
	timerRainOfArrowsCD	= "%s"
})

L:SetOptionLocalization({
	DarknessSoon		= "Alerte préventive pour $spell:117697 (5s avant) ",
	timerUSRevive		= "Délai avec que $spell:117506 ne se reconstitue",
	RangeFrame			= "Afficher le cadre de distance (8m)"
})

------------
-- Elegon --
------------
L = DBM:GetModLocalization(726)

L:SetWarningLocalization({
	specWarnDespawnFloor	= "Le sol disparait dans 6sec!"
})

L:SetTimerLocalization({
	timerDespawnFloor	= "Sol disparu"
})

L:SetOptionLocalization({
	specWarnDespawnFloor	= "Alerte spéciale avant que le sol ne disparaisse",
	timerDespawnFloor		= "Afficher le temps avant que le sol disparaît"
})

------------
-- Will of the Emperor --
------------
L = DBM:GetModLocalization(677)

L:SetOptionLocalization({
	InfoFrame		= "Afficher le cadre d'informations pour les joueurs touché par $spell:116525",
	CountOutCombo	= "Comptez le nombre de $journal:5673 vocalement<br/>NOTE: Disponible qu'avec l'option de voix féminine.",
	ArrowOnCombo	= "Afficher la flêche DBM pendant $journal:5673<br/>NOTE: Cela suppose que le Tank est face au Boss <br/>et que personne d'autre n'est derrière."
})

L:SetMiscLocalization({
	Pull		= "La machine s'anime en bourdonnant ! Allez au niveau inférieur !",--Emote
	Rage		= "La rage de l'empereur se répercute dans les collines.",--Yell
	Strength	= "La Force de l'empereur apparaît dans les alcôves !",--Emote
	Courage		= "Le Courage de l'empereur apparaît dans les alcôves !",--Emote
	Boss		= "Deux assemblages titanesques apparaissent dans les grandes alcôves !"--Emote
})

------------
-- Imperial Vizier Zor'lok --
------------
L = DBM:GetModLocalization(745)

L:SetWarningLocalization({
	warnAttenuation		= "%s sur %s (%s)",
	warnEcho			= "Echo apparut",
	warnEchoDown		= "Echo vaincu",
	specwarnAttenuation	= "%s sur %s (%s)",
	specwarnPlatform	= "Changement de plateforme"
})

L:SetOptionLocalization({
	warnEcho			= "Annoncer quand un Echo apparaît",
	warnEchoDown		= "Annoncer quand un Echo est vaincu",
	specwarnPlatform	= "Alerte indiquant quand le Boss change de platforme",
	ArrowOnAttenuation	= "Afficher la flêche DBM pendant $spell:127834 <br/>pour indiquer dans quelle direction bouger"
})

L:SetMiscLocalization({
	Platform	= "s'envole vers l'une de ses plateformes !",
	Defeat		= "Nous ne nous laisserons pas aller au désespoir du vide. Si Sa volonté est de nous faire périr, il en sera ainsi.",
	Left		= "Gauche",
	Right		= "Droite"
})

------------
-- Blade Lord Ta'yak --
------------
L = DBM:GetModLocalization(744)

L:SetOptionLocalization({
	RangeFrame			= "Afficher le cadre de distance (10m) pour $spell:123175"
})

-------------------------------
-- Garalon --
-------------------------------
L = DBM:GetModLocalization(713)

L:SetWarningLocalization({
	warnCrush		= "%s",
	specwarnUnder	= "Sortez du cercle violet !"
})

L:SetOptionLocalization({
	specwarnUnder	= "Alerte spécial quand vous êtes sous le Boss",
})

L:SetMiscLocalization({
	UnderHim	= "sous lui",
	Phase2		= "commence à se fendiller !"
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
	warnReshapeLife				= "%s sur >%s< (%d)",--Localized because i like class colors on warning and shoving a number into targetname broke it using the generic.
	warnReshapeLifeTutor		= "1: Interrompt/debuff la cible, 2: Vous faites une pause, 3: Regen Vie/Volonté, 4: Sortir du véhicule",
	warnAmberExplosion			= ">%s< lance %s",-- à vérifier.
	warnAmberExplosionAM		= "Monstruosité d’ambre à lancé Explosion d'ambre - Interrompez Maintenant !",--personal warning.
	warnInterruptsAvailable		= "Interruption disponible pour %s: >%s<",
	warnWillPower				= "Volonté actuelle: %s",
	specwarnWillPower			= "Volonté faible ! - 5s restante",
	specwarnAmberExplosionYou	= "Interrompez VOTRE %s !",--Struggle for Control interrupt.
	specwarnAmberExplosionAM	= "%s: Interrompt %s !",--Amber Montrosity
	specwarnAmberExplosionOther	= "%s: Interrompt %s !"--Mutated Construct
})

L:SetTimerLocalization({
	timerDestabalize		= "Déstabiliser (%2$d) : %1$s",
	timerAmberExplosionAMCD	= "Explosion CD: Monstruosité"
})

L:SetOptionLocalization({
	warnReshapeLifeTutor		= "Voir l'aperçu des compétences de l'Assemblage muté",
	warnAmberExplosion			= "Alerte (avec la source) quand $spell:122398 est incanté",
	warnAmberExplosionAM		= "Alerte personnelle quand la Monstruosité d’ambre à lancé<br/> $spell:122398 (pour interrompre)",
	warnInterruptsAvailable		= "Annoncer qui a Frappe d'ambre disponible pour interrompre <br/> $spell:122402",
	warnWillPower				= "Annonce la Volonté actuelle à 80, 50, 30, 10, et 4.",
	specwarnWillPower			= "Alerte spéciale quand la Volonté est faible dans l'Assemblage muté",
	specwarnAmberExplosionYou	= "Alerte spéciale pour interrompre votre propre $spell:122398",
	specwarnAmberExplosionAM	= "Alerte spéciale pour interrompre $spell:122402<br/>de la Monstruosité d’ambre",
	specwarnAmberExplosionOther	= "Alerte spéciale pour interrompre le $spell:122398<br/>de l'Assemblage muté",-- à vérifier
	timerAmberExplosionAMCD		= "Afficher le temps avant la prochaine $spell:122402<br/>de la Monstruosité d'ambre",
	InfoFrame					= "Afficher le cadre d'information de la Volonté des joueurs"
})

L:SetMiscLocalization({
	WillPower	= "Volonté"
})

------------
-- Grand Empress Shek'zeer --
------------
L = DBM:GetModLocalization(743)

L:SetWarningLocalization({
	warnAmberTrap	= "Progression du Piège d'ambre: (%d/5)"
})

L:SetOptionLocalization({
	warnAmberTrap	= "Alerte préventive (avec progression) quand $spell:125826 est créé", -- maybe bad translation.
	InfoFrame		= "Afficher le cadre d'informations pour les joueurs touché par $spell:125390",
	RangeFrame		= "Afficher le cadre de distance (5m) pour $spell:123735"
})

L:SetMiscLocalization({
	PlayerDebuffs	= "Fixer",
	YellPhase3		= "Assez de vos excuses, impératrice ! Éliminez ces crétins ou je vous achève moi-même !"
})

------------
-- Protectors of the Endless --
------------
L = DBM:GetModLocalization(683)

L:SetWarningLocalization({
	warnGroupOrder		= "Rotation : Groupe %s",
	specWarnYourGroup	= "C'est votre groupe - Rotation !"
})

L:SetOptionLocalization({
	warnGroupOrder		= "Annoncer une rotation de groupe pour $spell:118191<br/>(À l'heure actuelle ne supporte que le raid 25 | 5,2,2,2, etc...)",
	specWarnYourGroup	= "Alerte spécial quand votre groupe doit faire rotation pour $spell:118191<br/>(Raid 25 seulement)",
	RangeFrame			= "Afficher le cadre de distance (8m) pour $spell:111850<br/>(Affiche tout le monde si vous avez le debuff, sinon ceux avec le debuff)"
})

------------
-- Tsulong --
------------
L = DBM:GetModLocalization(742)

L:SetMiscLocalization{
	Victory	= "Je vous remercie étrangers. J'ai été libéré."
}

-------------------------------
-- Lei Shi --
-------------------------------
L = DBM:GetModLocalization(729)

L:SetWarningLocalization({
	warnHideOver	= "%s est fini"
})

L:SetTimerLocalization({
	timerSpecialCD	= "Délai capacité spécial (%d)"
})

L:SetOptionLocalization({
	warnHideOver		= "Alerte quand $spell:123244 est fini",
	timerSpecialCD		= "Délai avant la prochaine capacité spécial", -- revoir
	SetIconOnProtector	= "Mettre un icone sur les $journal:6224<br/>(Pas fiable si il y a des assistants(promot))",
	RangeFrame			= "Afficher le cadre de distance (3m) pour $spell:123121<br/>(Affiche tout le monde pendant $spell:123244, sinon, ne montre que les Tank)"
})

L:SetMiscLocalization{
	Victory	= "Je... ah... oh ! J'ai... ? Tout était... si... embrouillé."--wtb alternate and less crappy victory event.
}

----------------------
-- Sha of Fear --
----------------------
L = DBM:GetModLocalization(709)

L:SetWarningLocalization({
	MoveWarningForward			= "Allez de l'autre côté !",
	MoveWarningRight			= "Allez vers la droite !",
	MoveWarningBack				= "Allez à la position précédente !",
	specWarnBreathOfFearSoon	= "Souffle de peur bientôt - Allez dans le mur !"
})

L:SetTimerLocalization({
	timerSpecialAbilityCD		= "Capacité spéciale suivante",
	timerSpoHudCD				= "Délai Peur / Geysérit",
	timerSpoStrCD				= "Délai Geysérit / Frappe",
	timerHudStrCD				= "Délai Peur / Frappe"
})

L:SetOptionLocalization({
	specWarnBreathOfFearSoon	= "Alerte spécial préventive pour $spell:119414 si vous n'avez pas le buff $spell:117964"
})

L:SetOptionLocalization({
	RangeFrame				= "Afficher le cadre de distance (2m) pour $spell:119519",
	MoveWarningForward		= "Alerte spécial pour aller de l'autre côté quand $spell:120047 est lancé",
	MoveWarningRight		= "Alerte spécial pour aller à droite quand $spell:120047 est lancé",
	MoveWarningBack			= "Alerte spécial pour aller à la position précédente quand <br/>$spell:120047 est fini",
	timerSpecialAbilityCD	= "Délai pour la prochaine fois que la capacité spéciale est lancé",
	timerSpoHudCD			= "Délai pour le prochain lancé de $spell:120629 ou $spell:120519",
	timerSpoStrCD			= "Délai pour le prochain lancé de $spell:120519 ou $spell:120672",
	timerHudStrCD			= "Délai pour le prochain lancé de $spell:120629 ou $spell:120672"
})

--------------------------
-- Jin'rokh the Breaker --
--------------------------
L = DBM:GetModLocalization(827)

--------------
-- Horridon --
--------------
L = DBM:GetModLocalization(819)

L:SetTimerLocalization({
	timerDoor	= "Prochaine Porte Tribale"
})

L:SetOptionLocalization({
	timerDoor	= "Afficher le temps pour la prochain phase de Porte Tribale"
})

L:SetMiscLocalization({
	newForces		= "surgissent de la porte",--Farraki forces pour from the Farraki Tribal Door!
	chargeTarget	= "fait battre sa queue"--Horridon sets his eyes on Eraeshio and stamps his tail!
})

---------------------------
-- The Council of Elders --
---------------------------
L = DBM:GetModLocalization(816)

L:SetOptionLocalization({
	RangeFrame	= "Afficher le cadre de distance"
})

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
	eggsHatch	= "commencent à éclore"
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

L:SetOptionLocalization({
	RangeFrame	= "Afficher le cadre de distance dynamique<br/>(Un cadre de distance intelligent qui indique quand trop de joueurs sont trop proches)"
})

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
