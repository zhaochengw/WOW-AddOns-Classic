local L

------------
-- The Stone Guard --
------------
L = DBM:GetModLocalization(679)

L:SetWarningLocalization({
	SpecWarnOverloadSoon		= "%s soon!", -- prepare survival ablility or move boss. need more specific message.
	specWarnBreakJasperChains	= "Break Jasper Chains!"
})

L:SetOptionLocalization({
	SpecWarnOverloadSoon		= "Show special warning before overload", -- need to change this, i can not translate this with good grammer. please help.
	specWarnBreakJasperChains	= "Show special warning when it is safe to break $spell:130395",
	InfoFrame					= "Show info frame for boss power, player petrification, and which boss is casting petrification"
})

L:SetMiscLocalization({
	Overload	= "%s is about to Overload!"
})

------------
-- Feng the Accursed --
------------
L = DBM:GetModLocalization(689)

L:SetWarningLocalization({
	WarnPhase			= "Phase %d",
	specWarnBarrierNow	= "Use Nullification Barrier NOW!"
})

L:SetOptionLocalization({
	WarnPhase			= "Announce Phase transition",
	specWarnBarrierNow	= "Show special warning when you're supposed to use $spell:115817 (only applies to LFR)",
	RangeFrame			= DBM_CORE_L.AUTO_RANGE_OPTION_TEXT_SHORT:format("6") .. " during arcane phase",
	SetIconOnWS			= DBM_CORE_L.AUTO_ICONS_OPTION_TARGETS:format(116784),
	SetIconOnAR			= DBM_CORE_L.AUTO_ICONS_OPTION_TARGETS:format(116417)
})

L:SetMiscLocalization({
	Fire	= "Oh exalted one! Through me you shall melt flesh from bone!",
	Arcane	= "Oh sage of the ages! Instill to me your arcane wisdom!",
	Nature	= "Oh great spirit! Grant me the power of the earth!",--I did not log this one, text is probably not right
	Shadow	= "Great soul of champions past! Bear to me your shield!"
})

-------------------------------
-- Gara'jal the Spiritbinder --
-------------------------------
L = DBM:GetModLocalization(682)

L:SetOptionLocalization({
	SetIconOnVoodoo	= DBM_CORE_L.AUTO_ICONS_OPTION_TARGETS:format(122151)
})

L:SetMiscLocalization({
	Pull		= "It be dyin' time, now!",
	RolePlay	= "Now you done made me angry!"
})

----------------------
-- The Spirit Kings --
----------------------
L = DBM:GetModLocalization(687)

L:SetWarningLocalization({
	DarknessSoon	= "Shield of Darkness in %ds"
})

L:SetTimerLocalization({
	timerUSRevive		= "Undying Shadow Reform",
	timerRainOfArrowsCD	= "%s"
})

L:SetOptionLocalization({
	DarknessSoon		= "Show pre-warning countdown for $spell:117697 (5s before)",
	timerUSRevive		= "Show timer for $spell:117506 reform",
	timerRainOfArrowsCD = DBM_CORE_L.AUTO_TIMER_OPTIONS.cd:format(118122),
	RangeFrame			= DBM_CORE_L.AUTO_RANGE_OPTION_TEXT_SHORT:format("8")
})

------------
-- Elegon --
------------
L = DBM:GetModLocalization(726)

L:SetWarningLocalization({
	specWarnDespawnFloor	= "Floor despawn in 6s!"
})

L:SetTimerLocalization({
	timerDespawnFloor	= "Floor despawns"
})

L:SetOptionLocalization({
	specWarnDespawnFloor	= "Show special warning before floor vanishes",
	timerDespawnFloor		= "show timer for when floor vanishes",
	SetIconOnDestabilized	= DBM_CORE_L.AUTO_ICONS_OPTION_TARGETS:format(132222)
})

------------
-- Will of the Emperor --
------------
L = DBM:GetModLocalization(677)

L:SetOptionLocalization({
	InfoFrame		= "Show info frame for players affected by $spell:116525",
	CountOutCombo	= "Count out $journal:5673 casts<br/>NOTE: This currently only has female voice option.",
	ArrowOnCombo	= "Show DBM Arrow during $journal:5673<br/>NOTE: This assumes tank is in front of boss and anyone else is behind."
})

L:SetMiscLocalization({
	Pull		= "The machine hums to life!  Get to the lower level!",--Emote
	Rage		= "The Emperor's Rage echoes through the hills.",--Yell
	Strength	= "The Emperor's Strength appears in the alcoves!",--Emote
	Courage		= "The Emperor's Courage appears in the alcoves!",--Emote
	Boss		= "Two titanic constructs appear in the large alcoves!"--Emote
})

------------
-- Imperial Vizier Zor'lok --
------------
L = DBM:GetModLocalization(745)

L:SetWarningLocalization({
	warnEcho			= "Echo has spawned",
	warnEchoDown		= "Echo defeated",
	specwarnAttenuation	= "%s on %s (%s)",
	specwarnPlatform	= "Platform change"
})

L:SetOptionLocalization({
	warnEcho			= "Announce when an Echo spawns",
	warnEchoDown		= "Announce when an Echo is defeated",
	specwarnAttenuation	= DBM_CORE_L.AUTO_SPEC_WARN_OPTIONS.spell:format(127834),
	specwarnPlatform	= "Show special warning when boss changes platforms",
	ArrowOnAttenuation	= "Show DBM Arrow during $spell:127834 to indicate which direction to move",
	MindControlIcon		= DBM_CORE_L.AUTO_ICONS_OPTION_TARGETS:format(122740)
})

L:SetMiscLocalization({
	Platform	= "flies to one of his platforms!",
	Defeat		= "We will not give in to the despair of the dark void. If Her will for us is to perish, then it shall be so."
})

------------
-- Blade Lord Ta'yak --
------------
L = DBM:GetModLocalization(744)

L:SetOptionLocalization({
	RangeFrame			= DBM_CORE_L.AUTO_RANGE_OPTION_TEXT:format(10, 123175)
})

-------------------------------
-- Garalon --
-------------------------------
L = DBM:GetModLocalization(713)

L:SetWarningLocalization({
	warnCrush		= "%s",
	specwarnUnder	= "Move out of purple ring!"
})

L:SetOptionLocalization({
	warnCrush		= DBM_CORE_L.AUTO_ANNOUNCE_OPTIONS.spell:format(122774),
	specwarnUnder	= "Show special warning when you are under boss",
	PheromonesIcon	= DBM_CORE_L.AUTO_ICONS_OPTION_TARGETS:format(122835)
})

L:SetMiscLocalization({
	UnderHim	= "under him",
	Phase2		= "armor plating begins to crack"
})

----------------------
-- Wind Lord Mel'jarak --
----------------------
L = DBM:GetModLocalization(741)

L:SetOptionLocalization({
	AmberPrisonIcons		= DBM_CORE_L.AUTO_ICONS_OPTION_TARGETS:format(121885),
	specWarnReinforcements	= DBM_CORE_L.AUTO_SPEC_WARN_OPTIONS.spell:format("ej6554")
})

------------
-- Amber-Shaper Un'sok --
------------
L = DBM:GetModLocalization(737)

L:SetWarningLocalization({
	warnReshapeLife				= "%s on >%s< (%d)",--Localized because i like class colors on warning and shoving a number into targetname broke it using the generic.
	warnReshapeLifeTutor		= "1: Interrupt/debuff target (use this on boss to build debuff stacks), 2: Interrupt yourself when casting Amber Explosion, 3: Restore Willpower when it's low (use primarily in phase 3), 4: Escape Vehicle (phase 1 & 2 only)",
	warnAmberExplosion			= ">%s< is casting %s",
	warnAmberExplosionAM		= "Amber Monstrosity is casting Amber Explosion - Interrupt Now!",--personal warning.
	warnInterruptsAvailable		= "Interupts available for %s: >%s<",
	warnWillPower				= "Current Will Power: %s",
	specwarnWillPower			= "Low Will Power! - Leave vehicle or consume a puddle",
	specwarnAmberExplosionYou	= "Interrupt YOUR %s!",--Struggle for Control interrupt.
	specwarnAmberExplosionAM	= "%s: Interrupt %s!",--Amber Montrosity
	specwarnAmberExplosionOther	= "%s: Interrupt %s!"--Mutated Construct
})

L:SetTimerLocalization({
	timerDestabalize		= "Destabalize (%2$d) : %1$s",
	timerAmberExplosionAMCD	= "Explosion CD: Monstrosity"
})

L:SetOptionLocalization({
	warnReshapeLife				= DBM_CORE_L.AUTO_ANNOUNCE_OPTIONS.target:format(122784),
	warnReshapeLifeTutor		= "Display ability purpose rundown of Mutated Construct abilities",
	warnAmberExplosion			= "Show warning (with source) when $spell:122398 is cast",
	warnAmberExplosionAM		= "Show personal warning when Amber Montrosity's<br/> $spell:122398 is cast(for interrupt)",
	warnInterruptsAvailable		= "Announce who has Amber Strike interrupts available for<br/> $spell:122402",
	warnWillPower				= "Announce current will power at 80, 50, 30, 10, and 4.",
	specwarnWillPower			= "Show special warning when will power is low in construct",
	specwarnAmberExplosionYou	= "Show special warning to interrupt your own $spell:122398",
	specwarnAmberExplosionAM	= "Show special warning to interrupt Amber Montrosity's<br/> $spell:122402",
	specwarnAmberExplosionOther	= "Show special warning to interrupt loose Mutated Construct's<br/> $spell:122398",
	timerDestabalize			= DBM_CORE_L.AUTO_TIMER_OPTIONS.target:format(123059),
	timerAmberExplosionAMCD		= "Show timer for Amber Monstrosity's next $spell:122402",
	InfoFrame					= "Show info frame for players will power",
	FixNameplates				= "Automatically disable interfering nameplates while a construct<br/>(restores settings upon leaving combat)"
})

L:SetMiscLocalization({
	WillPower	= "Will Power"
})

------------
-- Grand Empress Shek'zeer --
------------
L = DBM:GetModLocalization(743)

L:SetWarningLocalization({
	warnAmberTrap	= "Amber Trap progress: (%d/5)"
})

L:SetOptionLocalization({
	warnAmberTrap		= "Show warning (with progress) when $spell:125826 is making", -- maybe bad translation.
	InfoFrame			= "Show info frame for players affected by $spell:125390",
	RangeFrame			= DBM_CORE_L.AUTO_RANGE_OPTION_TEXT:format(5, 123735),
	StickyResinIcons	= DBM_CORE_L.AUTO_ICONS_OPTION_TARGETS:format(124097),
	HeartOfFearIcon		= DBM_CORE_L.AUTO_ICONS_OPTION_TARGETS:format(123845)
})

L:SetMiscLocalization({
	PlayerDebuffs	= "Fixated",
	YellPhase3		= "No more excuses, Empress! Eliminate these cretins or I will kill you myself!"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("HoFTrash")

L:SetGeneralLocalization({
	name	= "Heart of Fear Trash"
})

------------
-- Protectors of the Endless --
------------
L = DBM:GetModLocalization(683)

L:SetWarningLocalization({
	warnGroupOrder		= "Rotate In: Group %s",
	specWarnYourGroup	= "Your Group - Rotate In!"
})

L:SetOptionLocalization({
	warnGroupOrder		= "Announce group rotation for $spell:118191<br/>(Currently only supports 25 man 5,2,2,2, etc... strat)",
	specWarnYourGroup	= "Show special warning when it's your group's turn for $spell:118191<br/>(25 man only)",
	RangeFrame			= DBM_CORE_L.AUTO_RANGE_OPTION_TEXT:format(8, 111850) .. "<br/>(Shows everyone if you have debuff, only players with debuff if not)",
	SetIconOnPrison		= DBM_CORE_L.AUTO_ICONS_OPTION_TARGETS:format(117436)
})

------------
-- Tsulong --
------------
L = DBM:GetModLocalization(742)

L:SetMiscLocalization{
	Victory	= "I thank you, strangers. I have been freed."
}

-------------------------------
-- Lei Shi --
-------------------------------
L = DBM:GetModLocalization(729)

L:SetWarningLocalization({
	warnHideOver	= "%s has ended"
})

L:SetTimerLocalization({
	timerSpecialCD	= "Special CD (%d)"
})

L:SetOptionLocalization({
	warnHideOver	= "Show warning when $spell:123244 has ended",
	timerSpecialCD	= "Show timer for special ability CD",
	RangeFrame		= DBM_CORE_L.AUTO_RANGE_OPTION_TEXT:format(3, 123121) .. "<br/>(Shows everyone during Hide, otherwise, only shows tanks)"
})

L:SetMiscLocalization{
	Victory	= "I... ah... oh! Did I...? Was I...? It was... so... cloudy."--wtb alternate and less crappy victory event.
}

----------------------
-- Sha of Fear --
----------------------
L = DBM:GetModLocalization(709)

L:SetWarningLocalization({
	MoveForward					= "Move Through",
	MoveRight					= "Move Right",
	MoveBack					= "Move To Old Position",
	specWarnBreathOfFearSoon	= "Breath of Fear soon - MOVE into wall!"
})

L:SetTimerLocalization({
	timerSpecialAbilityCD	= "Next Special Ability",
	timerSpoHudCD			= "Fear / Waterspout CD",
	timerSpoStrCD			= "Waterspout / Strike CD",
	timerHudStrCD			= "Fear / Strike CD"
})

L:SetOptionLocalization({
	warnThrash					= DBM_CORE_L.AUTO_ANNOUNCE_OPTIONS.spell:format(131996),
	warnBreathOnPlatform		= "Show $spell:119414 warning when you are on platform<br/>(not recommended, for raid leader)",
	specWarnBreathOfFearSoon	= "Show pre-special warning for $spell:119414 if you not have a $spell:117964 buff",
	specWarnMovement			= "Show special warning directing where to move when $spell:120047 is being cast<br/>(based on common position strategy of standing at entrance pizza slice and then following movements when DBM gives them)",
	timerSpecialAbility			= "Show timer for when next special ability will be cast",
	RangeFrame					= DBM_CORE_L.AUTO_RANGE_OPTION_TEXT:format(2, 119519),
	SetIconOnHuddle				= DBM_CORE_L.AUTO_ICONS_OPTION_TARGETS:format(120629)
})

--------------------------
-- Jin'rokh the Breaker --
--------------------------
L = DBM:GetModLocalization(827)

L:SetWarningLocalization({
	specWarnWaterMove	= "%s soon - get out from Conductive Water!"
})

L:SetOptionLocalization({
	specWarnWaterMove	= "Show special warning if you standing in $spell:138470<br/>(Warns at $spell:137313 pre-cast or $spell:138732 debuff fades shortly)",
	RangeFrame			= DBM_CORE_L.AUTO_RANGE_OPTION_TEXT_SHORT:format("8/4")
})

--------------
-- Horridon --
--------------
L = DBM:GetModLocalization(819)

L:SetWarningLocalization({
	warnAdds				= "%s",
	warnOrbofControl		= "Orb of Control dropped",
	specWarnOrbofControl	= "Orb of Control dropped!"
})

L:SetTimerLocalization({
	timerDoor	= "Next Tribal Door",
	timerAdds	= "Next %s"
})

L:SetOptionLocalization({
	warnAdds				= "Announce when new adds jump down",
	warnOrbofControl		= "Announce when $journal:7092 dropped",
	specWarnOrbofControl	= "Show special warning when $journal:7092 dropped",
	timerDoor				= "Show timer for next Tribal Door phase",
	timerAdds				= "Show timer for when next add jumps down",
	SetIconOnAdds			= "Set icons on balcony adds",
	RangeFrame				= DBM_CORE_L.AUTO_RANGE_OPTION_TEXT:format(5, 136480),
	SetIconOnCharge			= DBM_CORE_L.AUTO_ICONS_OPTION_TARGETS:format(136769)
})

L:SetMiscLocalization({
	newForces		= "forces pour from the",--Farraki forces pour from the Farraki Tribal Door!
	chargeTarget	= "stamps his tail!"--Horridon sets his eyes on Eraeshio and stamps his tail!
})

---------------------------
-- The Council of Elders --
---------------------------
L = DBM:GetModLocalization(816)

L:SetWarningLocalization({
	specWarnPossessed	= "%s on %s - switch targets"
})

L:SetOptionLocalization({
	warnPossessed		= DBM_CORE_L.AUTO_ANNOUNCE_OPTIONS.target:format(136442),
	specWarnPossessed	= DBM_CORE_L.AUTO_SPEC_WARN_OPTIONS.switch:format(136442),
	RangeFrame			= DBM_CORE_L.AUTO_RANGE_OPTION_TEXT_SHORT:format(5),
	AnnounceCooldowns	= "Count out (up to 3) which $spell:137166 cast it is for raid cooldowns",
	SetIconOnBitingCold	= DBM_CORE_L.AUTO_ICONS_OPTION_TARGETS:format(136992),
	SetIconOnFrostBite	= DBM_CORE_L.AUTO_ICONS_OPTION_TARGETS:format(136922)
})

------------
-- Tortos --
------------
L = DBM:GetModLocalization(825)

L:SetWarningLocalization({
	warnKickShell			= "%s used by >%s< (%d remaining)",
	specWarnCrystalShell	= "Get %s"
})

L:SetOptionLocalization({
	warnKickShell			= DBM_CORE_L.AUTO_ANNOUNCE_OPTIONS.spell:format(134031),
	specWarnCrystalShell	= "Show special warning when you are missing<br/> $spell:137633 debuff and are above 90% health",
	InfoFrame				= "Show info frame for players without $spell:137633",
	ClearIconOnTurtles		= "Clear icons on $journal:7129 when affected by $spell:133971",
	AnnounceCooldowns		= "Count out which $spell:134920 cast it is for raid cooldowns"
})

L:SetMiscLocalization({
	WrongDebuff	= "No %s"
})

-------------
-- Megaera --
-------------
L = DBM:GetModLocalization(821)

L:SetTimerLocalization({
	timerBreathsCD	= "Next Breath"
})

L:SetOptionLocalization({
	timerBreaths			= "Show timer for next breath",
	SetIconOnCinders		= DBM_CORE_L.AUTO_ICONS_OPTION_TARGETS:format(139822),
	SetIconOnTorrentofIce	= DBM_CORE_L.AUTO_ICONS_OPTION_TARGETS:format(139889),
	AnnounceCooldowns		= "Count out which Rampage cast it is for raid cooldowns",
	Never					= "Never",
	Every					= "Every (consecutive)",
	EveryTwo				= "Cooldown order of 2",
	EveryThree				= "Cooldown order of 3",
	EveryTwoExcludeDiff		= "Cooldown order of 2 (Exluding Diffusion)",
	EveryThreeExcludeDiff	= "Cooldown order of 3 (Exluding Diffusion)"
})

L:SetMiscLocalization({
	rampageEnds	= "Megaera's rage subsides."
})

------------
-- Ji-Kun --
------------
L = DBM:GetModLocalization(828)

L:SetWarningLocalization({
	warnFlock			= "%s %s %s",
	specWarnFlock		= "%s %s %s",
	specWarnBigBird		= "Nest Guardian: %s",
	specWarnBigBirdSoon	= "Nest Guardian Soon: %s"
})

L:SetTimerLocalization({
	timerFlockCD	= "Nest (%d): %s"
})

L:SetOptionLocalization({
	warnFlock			= DBM_CORE_L.AUTO_ANNOUNCE_OPTIONS.count:format("ej7348"),
	specWarnFlock		= DBM_CORE_L.AUTO_SPEC_WARN_OPTIONS.switch:format("ej7348"),
	specWarnBigBird		= DBM_CORE_L.AUTO_SPEC_WARN_OPTIONS.switch:format("ej7827"),
	specWarnBigBirdSoon	= DBM_CORE_L.AUTO_SPEC_WARN_OPTIONS.soon:format("ej7827"),
	timerFlockCD		= DBM_CORE_L.AUTO_TIMER_OPTIONS.nextcount:format("ej7348"),
	RangeFrame			= DBM_CORE_L.AUTO_RANGE_OPTION_TEXT:format(10, 138923),
	ShowNestArrows		= "Show special alerts only for your selected nest location",
	Never				= "All nests",
	Northeast			= "Blue - Lower & Upper NE",
	Southeast			= "Green - Lower & Upper SE",
	Southwest			= "Purple/Red - Lower SW & Upper SW(25) or Upper Middle(10)",
	West				= "Red - Lower W & Upper Middle (25 only)",
	Northwest			= "Yellow - Lower & Upper NW (25 only)",
	Guardians			= "Nest Guardians"
})

L:SetMiscLocalization({
	eggsHatch		= "nests begin to hatch!",
	Upper			= "Upper",
	Lower			= "Lower",
	UpperAndLower	= "Upper & Lower",
	TrippleD		= "Tripple (2xDwn)",
	TrippleU		= "Tripple (2xUp)",
	NorthEast		= "|cff0000ffNE|r",--Blue
	SouthEast		= "|cFF088A08SE|r",--Green
	SouthWest		= "|cFF9932CDSW|r",--Purple
	West			= "|cffff0000W|r",--Red
	NorthWest		= "|cffffff00NW|r",--Yellow
	Middle10		= "|cFF9932CDMiddle|r",--Purple (Middle is upper southwest on 10 man/LFR)
	Middle25		= "|cffff0000Middle|r",--Red (Middle is upper west on 25 man)
	ArrowUpper		= " |TInterface\\Icons\\misc_arrowlup:12:12|t ",
	ArrowLower		= " |TInterface\\Icons\\misc_arrowdown:12:12|t "
})

--------------------------
-- Durumu the Forgotten --
--------------------------
L = DBM:GetModLocalization(818)

L:SetWarningLocalization({
	warnBeamNormal				= "Beam - |cffff0000Red|r : >%s<, |cff0000ffBlue|r : >%s<",
	warnBeamHeroic				= "Beam - |cffff0000Red|r : >%s<, |cff0000ffBlue|r : >%s<, |cffffff00Yellow|r : >%s<",
	warnAddsLeft				= "Fogs remaining: %d",
	specWarnBlueBeam			= "Blue Beam on you - Avoid Moving",
	specWarnFogRevealed			= "%s revealed!",
	specWarnDisintegrationBeam	= "%s (%s)"
})

L:SetOptionLocalization({
	warnBeam					= "Announce beam targets",
	warnAddsLeft				= "Announce how many Fogs remain",
	specWarnFogRevealed			= "Show special warning when a fog is revealed",
	specWarnBlueBeam			= DBM_CORE_L.AUTO_SPEC_WARN_OPTIONS.spell:format(139202),
	specWarnDisintegrationBeam	= DBM_CORE_L.AUTO_SPEC_WARN_OPTIONS.spell:format("ej6882"),
	ArrowOnBeam					= "Show DBM Arrow during $journal:6882 to indicate which direction to move",
	SetIconRays					= DBM_CORE_L.AUTO_ICONS_OPTION_TARGETS:format("ej6891"),
	SetIconLifeDrain			= DBM_CORE_L.AUTO_ICONS_OPTION_TARGETS:format(133795),
	SetIconOnParasite			= DBM_CORE_L.AUTO_ICONS_OPTION_TARGETS:format(133597),
	InfoFrame					= "Show info frame for $spell:133795 stacks",
	SetParticle					= "Automatically set particle density to low on pull<br/>(Restores previous setting on combat end)"
})

L:SetMiscLocalization({
	LifeYell	= "Life Drain on %s (%d)"
})

----------------
-- Primordius --
----------------
L = DBM:GetModLocalization(820)

L:SetWarningLocalization({
	warnDebuffCount	= "Mutate progress : %d/5 good & %d bad"
})

L:SetOptionLocalization({
	warnDebuffCount		= "Show debuff count warnings when you absorb pools",
	RangeFrame			= DBM_CORE_L.AUTO_RANGE_OPTION_TEXT_SHORT:format("5/3"),
	SetIconOnBigOoze	= "Set icon on $journal:6969"
})

-----------------
-- Dark Animus --
-----------------
L = DBM:GetModLocalization(824)

L:SetWarningLocalization({
	warnMatterSwapped	= "%s: >%s< and >%s< swapped"
})

L:SetOptionLocalization({
	warnMatterSwapped	= "Announce targets swapped by $spell:138618",
	SetIconOnFont		= DBM_CORE_L.AUTO_ICONS_OPTION_TARGETS:format(138707)
})

L:SetMiscLocalization({
	Pull	= "The orb explodes!"
})

--------------
-- Iron Qon --
--------------
L = DBM:GetModLocalization(817)

L:SetWarningLocalization({
	warnDeadZone	= "%s: %s and %s shielded"
})

L:SetOptionLocalization({
	warnDeadZone			= DBM_CORE_L.AUTO_ANNOUNCE_OPTIONS.spell:format(137229),
	SetIconOnLightningStorm	= DBM_CORE_L.AUTO_ICONS_OPTION_TARGETS:format(136192),
	RangeFrame				= "Show dynamic range frame (10)<br/>(This is a smart range frame that shows when too many are too close)",
	InfoFrame				= "Show info frame for players with $spell:136193"
})

-------------------
-- Twin Consorts --
-------------------
L = DBM:GetModLocalization(829)

L:SetWarningLocalization({
	warnNight	= "Night phase",
	warnDay		= "Day phase",
	warnDusk	= "Dusk phase"
})

L:SetTimerLocalization({
	timerDayCD	= "Next day phase",
	timerDuskCD	= "Next dusk phase"
})

L:SetOptionLocalization({
	warnNight	= DBM_CORE_L.AUTO_ANNOUNCE_OPTIONS.spell:format("ej7641"),
	warnDay		= DBM_CORE_L.AUTO_ANNOUNCE_OPTIONS.spell:format("ej7645"),
	warnDusk	= DBM_CORE_L.AUTO_ANNOUNCE_OPTIONS.spell:format("ej7633"),
	timerDayCD	= DBM_CORE_L.AUTO_TIMER_OPTIONS.next:format("ej7645"),
	timerDuskCD	= DBM_CORE_L.AUTO_TIMER_OPTIONS.next:format("ej7633"),
	RangeFrame	= DBM_CORE_L.AUTO_RANGE_OPTION_TEXT_SHORT:format(5)
})

L:SetMiscLocalization({
	DuskPhase	= "Lu'lin! Lend me your strength!"
})

--------------
-- Lei Shen --
--------------
L = DBM:GetModLocalization(832)

L:SetWarningLocalization({
	specWarnIntermissionSoon	= "Intermission soon",
	warnDiffusionChainSpread	= "%s spread on >%s<"
})

L:SetTimerLocalization({
	timerConduitCD	= "First Conduit CD"
})

L:SetOptionLocalization({
	specWarnIntermissionSoon	= "Show pre-special warning before Intermission",
	warnDiffusionChainSpread	= "Announce $spell:135991 spread targets",
	timerConduitCD				= "Show timer for first conduit ability cooldown",
	RangeFrame					= DBM_CORE_L.AUTO_RANGE_OPTION_TEXT_SHORT:format("8/6"),--For two different spells
	StaticShockArrow			= "Show DBM Arrow when someone is affected by $spell:135695",
	OverchargeArrow				= "Show DBM Arrow when someone is affected by $spell:136295",
	SetIconOnOvercharge			= DBM_CORE_L.AUTO_ICONS_OPTION_TARGETS:format(136295),
	SetIconOnStaticShock		= DBM_CORE_L.AUTO_ICONS_OPTION_TARGETS:format(135695)
})

L:SetMiscLocalization({
	StaticYell	= "Static Shock on %s (%d)"
})

------------
-- Ra-den --
------------
L = DBM:GetModLocalization(831)

L:SetWarningLocalization({
	specWarnUnstablVitaJump	= "Unstable Vita jumped to you!"
})

L:SetOptionLocalization({
	specWarnUnstablVitaJump	= "Show special warning when $spell:138297 jumps to you"
})

L:SetMiscLocalization({
	Defeat	= "Wait!"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("ToTTrash")

L:SetGeneralLocalization({
	name	= "Throne of Thunder Trash"
})

L:SetOptionLocalization({
	RangeFrame	= DBM_CORE_L.AUTO_RANGE_OPTION_TEXT_SHORT:format(10)--For 3 different spells
})

---------------
-- Immerseus --
---------------
L = DBM:GetModLocalization(852)

L:SetMiscLocalization({
	Victory	= "Ah, you have done it!  The waters are pure once more."
})

---------------------------
-- The Fallen Protectors --
---------------------------
L = DBM:GetModLocalization(849)

L:SetWarningLocalization({
	specWarnCalamity	= "%s",
	specWarnMeasures	= "Desperate Measures soon (%s)!"
})

---------------------------
-- Norushen --
---------------------------
L = DBM:GetModLocalization(866)

L:SetMiscLocalization({
	wasteOfTime	= "Very well, I will create a field to keep your corruption quarantined."
})

------------------
-- Sha of Pride --
------------------
L = DBM:GetModLocalization(867)

L:SetOptionLocalization({
	SetIconOnFragment	= "Set icon on Corrupted Fragment"
})

L:SetMiscLocalization({
	PortalRP	= "So Hellscream's arrogance unleashed the last of the sha. I am not surprised."
})

--------------
-- Galakras --
--------------
L = DBM:GetModLocalization(868)

L:SetWarningLocalization({
	warnTowerOpen	= "Tower opened",
	warnTowerGrunt	= "Tower Grunt"
})

L:SetTimerLocalization({
	timerTowerCD		= "Next Tower",
	timerTowerGruntCD	= "Next Tower Grunt"
})

L:SetOptionLocalization({
	warnTowerOpen		= "Announce when tower opens",
	warnTowerGrunt		= "Announce when new tower grunt spawns",
	timerTowerCD		= "Show timer for next tower assault",
	timerTowerGruntCD	= "Show timer for next tower grunt"
})

L:SetMiscLocalization({
	wasteOfTime		= "Well done! Landing parties, form up! Footmen to the front!",--Alliance Version
	wasteOfTime2	= "Well done. The first brigade has made landfall.",--Horde Version
	Pull			= "Dragonmaw clan, retake the docks and push them into the sea!  In the name of Hellscream and the True Horde!",
	newForces1		= "Here they come!",--Jaina's line, alliance
	newForces1H		= "Bring her down quick so I can wrap my fingers around her neck.",--Sylva's line, horde
	newForces2		= "Dragonmaw, advance!",
	newForces3		= "For Hellscream!",
	newForces4		= "Next squad, push forward!",
	tower			= "The door barring the"--The door barring the South/North Tower has been breached!
})

--------------------
--Iron Juggernaut --
--------------------
L = DBM:GetModLocalization(864)

L:SetOptionLocalization({
	timerAssaultModeCD	= DBM_CORE_L.AUTO_TIMER_OPTIONS.next:format("ej8177"),
	timerSiegeModeCD	= DBM_CORE_L.AUTO_TIMER_OPTIONS.next:format("ej8178")
})

--------------------------
-- Kor'kron Dark Shaman --
--------------------------
L = DBM:GetModLocalization(856)

L:SetMiscLocalization({
	PrisonYell	= "Prison on %s fades (%d)"
})

---------------------
-- General Nazgrim --
---------------------
L = DBM:GetModLocalization(850)

L:SetWarningLocalization({
	warnDefensiveStanceSoon	= "Defensive Stance in %ds"
})

L:SetOptionLocalization({
	warnDefensiveStanceSoon	= DBM_CORE_L.AUTO_ANNOUNCE_OPTIONS.prewarn:format(143593)
})

L:SetMiscLocalization({
	newForces1	= "Warriors, on the double!",
	newForces2	= "Defend the gate!",
	newForces3	= "Rally the forces!",
	newForces4	= "Kor'kron, at my side!",
	newForces5	= "Next squad, to the front!",
	allForces	= "All Kor'kron... under my command... kill them... NOW!",
	nextAdds	= "Next Adds: ",
	mage		= "|c"..RAID_CLASS_COLORS["MAGE"].colorStr..LOCALIZED_CLASS_NAMES_MALE["MAGE"].."|r",
	shaman		= "|c"..RAID_CLASS_COLORS["SHAMAN"].colorStr..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"].."|r",
	rogue		= "|c"..RAID_CLASS_COLORS["ROGUE"].colorStr..LOCALIZED_CLASS_NAMES_MALE["ROGUE"].."|r",
	hunter		= "|c"..RAID_CLASS_COLORS["HUNTER"].colorStr..LOCALIZED_CLASS_NAMES_MALE["HUNTER"].."|r",
	warrior		= "|c"..RAID_CLASS_COLORS["WARRIOR"].colorStr..LOCALIZED_CLASS_NAMES_MALE["WARRIOR"].."|r"
})

------------------------
-- Spoils of Pandaria --
------------------------
L = DBM:GetModLocalization(870)

L:SetMiscLocalization({
	wasteOfTime	= "Hey, we recording?  Yeah?  Okay.  Goblin-Titan control module starting up, please stand back.",
	Module1 	= "Module 1's all prepared for system reset.",
	Victory		= "Module 2's all prepared for system reset."
})

---------------------------
-- Thok the Bloodthirsty --
---------------------------
L = DBM:GetModLocalization(851)

L:SetOptionLocalization({
	RangeFrame	= "Show dynamic range frame (10)<br/>(This is a smart range frame that shows when you reach Frenzy threshold)"
})

----------------------------
-- Siegecrafter Blackfuse --
----------------------------
L = DBM:GetModLocalization(865)

L:SetMiscLocalization({
	newWeapons	= "Unfinished weapons begin to roll out on the assembly line.",
	newShredder	= "An Automated Shredder draws near!"
})

----------------------------
-- Paragons of the Klaxxi --
----------------------------
L = DBM:GetModLocalization(853)

L:SetWarningLocalization({
	specWarnActivatedVulnerable	= "You are vulnerable to %s - Avoid!",
	specWarnMoreParasites		= "You need more parasites - Do NOT block!"
})

L:SetOptionLocalization({
	warnToxicCatalyst			= DBM_CORE_L.AUTO_ANNOUNCE_OPTIONS.spell:format("ej8036"),
	specWarnActivatedVulnerable	= "Show special warning when you are vulnerable to activating paragons",
	specWarnMoreParasites		= "Show special warning when you need more parasites",
	yellToxicCatalyst			= DBM_CORE_L.AUTO_YELL_OPTION_TEXT.yell:format("ej8036")
})

L:SetMiscLocalization({
	--thanks to blizz, the only accurate way for this to work, is to translate 5 emotes in all languages
	one				= "One",
	two				= "Two",
	three			= "Three",
	four			= "Four",
	five			= "Five",
	hisekFlavor		= "Look who's quiet now",--http://ptr.wowhead.com/quest=31510
	KilrukFlavor	= "Just another day, culling the swarm",--http://ptr.wowhead.com/quest=31109
	XarilFlavor		= "I see only dark skies in your future",--http://ptr.wowhead.com/quest=31216
	KaztikFlavor	= "Reduced to mere kunchong treats",--http://ptr.wowhead.com/quest=31024
	KaztikFlavor2	= "1 Mantid down, only 199 to go",--http://ptr.wowhead.com/quest=31808
	KorvenFlavor	= "The end of an ancient empire",--http://ptr.wowhead.com/quest=31232
	KorvenFlavor2	= "Take your Gurthani Tablets and choke on them",--http://ptr.wowhead.com/quest=31232
	IyyokukFlavor	= "See opportunities. Exploit them!",--Does not have quests, http://ptr.wowhead.com/npc=65305
	KarozFlavor		= "You won't be leaping anymore!",---Does not have quests, http://ptr.wowhead.com/npc=65303
	SkeerFlavor		= "A bloody delight!",--http://ptr.wowhead.com/quest=31178
	RikkalFlavor	= "Specimen request fulfilled"--http://ptr.wowhead.com/quest=31508
})

------------------------
-- Garrosh Hellscream --
------------------------
L = DBM:GetModLocalization(869)

L:SetTimerLocalization({
	timerRoleplay	= GUILD_INTEREST_RP
})

L:SetOptionLocalization({
	timerRoleplay		= "Show timer for Garrosh/Thrall RP",
	RangeFrame			= "Show dynamic range frame (8)<br/>(This is a smart range frame that shows when you reach $spell:147126 threshold)",
	InfoFrame			= "Show info frame for players without damage reduction during intermission"
})

L:SetMiscLocalization({
	wasteOfTime		= "It is not too late, Garrosh. Lay down the mantle of Warchief. We can end this here, now, with no more bloodshed.",
	NoReduce		= "No damage reduction",
	phase3End		= "You think you have WON?"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("SoOTrash")

L:SetGeneralLocalization({
	name	= "Siege of Orgrimmar Trash"
})
