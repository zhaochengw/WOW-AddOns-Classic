if GetLocale() ~= "ruRU" then
	return
end
local L

------------
-- The Stone Guard --
------------
L = DBM:GetModLocalization(679)

L:SetWarningLocalization({
	SpecWarnOverloadSoon		= "Скоро %s!",
	specWarnBreakJasperChains	= "Рвите Яшмовые цепи!"
})

L:SetOptionLocalization({
	SpecWarnOverloadSoon		= "Показывать спецпредупреждение перед насыщением",
	specWarnBreakJasperChains	= "Показывать спецпредупреждение, когда можно разорвать $spell:130395",
	InfoFrame					= "Показывать информационное окно с энергией боссов, окаменением игроков и какой босс кастует окаменение"
})

L:SetMiscLocalization({
	Overload	= "%s вот-вот перенасытится!"
})

------------
-- Feng the Accursed --
------------
L = DBM:GetModLocalization(689)

L:SetWarningLocalization({
	WarnPhase			= "Фаза %d",
	specWarnBarrierNow	= "Используйте Преграждающий щит СЕЙЧАС!"
})

L:SetOptionLocalization({
	WarnPhase			= "Показывать предупреждение о смене фаз",
	specWarnBarrierNow	= "Показывать спецпредупреждение, когда Вам необходимо использовать $spell:115817 (только в режиме ЛФР)",
	RangeFrame	= DBM_CORE_L.AUTO_RANGE_OPTION_TEXT_SHORT:format("6") .. " во время аркан-фазы",
	SetIconOnWS			= DBM_CORE_L.AUTO_ICONS_OPTION_TARGETS:format(116784),
	SetIconOnAR			= DBM_CORE_L.AUTO_ICONS_OPTION_TARGETS:format(116417)
})

L:SetMiscLocalization({
	Fire	= "О, превозносимый! Моими руками ты отделишь их плоть от костей!",
	Arcane	= "О, великий мыслитель! Да снизойдет на меня твоя древняя мудрость!",
	Nature	= "О, великий дух! Даруй мне силу земли!",
	Shadow	= "Великие души защитников! Охраняйте меня!"
})

-------------------------------
-- Gara'jal the Spiritbinder --
-------------------------------
L = DBM:GetModLocalization(682)

L:SetOptionLocalization({
	SetIconOnVoodoo	= DBM_CORE_L.AUTO_ICONS_OPTION_TARGETS:format(122151)
})

L:SetMiscLocalization({
	Pull	= "Пора умирать!",
	RolePlay	= "А вот теперь вы меня разозлили!"
})

----------------------
-- The Spirit Kings --
----------------------
L = DBM:GetModLocalization(687)

L:SetWarningLocalization({
	DarknessSoon	= "Щит тьмы через %d сек."
})

L:SetTimerLocalization({
	timerUSRevive		= "Бессмертные тени формируются",
	timerRainOfArrowsCD	= "%s"
})

L:SetOptionLocalization({
	DarknessSoon	= "Производить 5-секундный отсчет для $spell:117697",
	timerUSRevive	= "Отсчет времени до формирования $spell:117506",
	timerRainOfArrowsCD = DBM_CORE_L.AUTO_TIMER_OPTIONS.cd:format(118122),
	RangeFrame			= DBM_CORE_L.AUTO_RANGE_OPTION_TEXT_SHORT:format("8")
})

------------
-- Elegon --
------------
L = DBM:GetModLocalization(726)

L:SetWarningLocalization({
	specWarnDespawnFloor	= "Пол исчезнет через 6 сек.!"
})

L:SetTimerLocalization({
	timerDespawnFloor	= "Пол исчезает!"
})

L:SetOptionLocalization({
	specWarnDespawnFloor	= "Показывать спецпредупреждение перед исчезновением пола",
	timerDespawnFloor		= "Отсчет времени до исчезновения пола",
	SetIconOnDestabilized	= DBM_CORE_L.AUTO_ICONS_OPTION_TARGETS:format(132222)
})

------------
-- Will of the Emperor --
------------
L = DBM:GetModLocalization(677)

L:SetOptionLocalization({
	InfoFrame		= "Показывать информационное окно для игроков с $spell:116525",
	CountOutCombo	= "Отсчитывать количество кастов $journal:5673<br/>Примечание: в настоящее время доступен только женский голос.",
	ArrowOnCombo	= "Показывать стрелку DBM во время $journal:5673<br/>Примечание: подразумевается, что танк стоит перед боссом, а все остальные - позади."
})

L:SetMiscLocalization({
	Pull		= "Машина гудит, возвращаясь к жизни. Спуститесь на нижний уровень!",--Эмоция
	Rage		= "Ярость императора эхом звучит среди холмов.",--Крик
	Strength	= "Сила императора сжимает эти земли в железных тисках.",--Эмоция
	Courage		= "Смелость императора безгранична.",--Эмоция
	Boss		= "Бессмертная армия сокрушит врагов императора."--Эмоция
})

------------
-- Imperial Vizier Zor'lok --
------------
L = DBM:GetModLocalization(745)

L:SetWarningLocalization({
	warnEcho			= "Появилось эхо!",
	warnEchoDown		= "Эхо повержено",
	specwarnAttenuation	= "%s у %s (%s)",
	specwarnPlatform	= "Смена платформы"
})

L:SetOptionLocalization({
	warnEcho			= "Показывать предупреждение о появлении Эха",
	warnEchoDown		= "Показывать предупреждение, когда Эхо будет побеждено",
	specwarnAttenuation	= DBM_CORE_L.AUTO_SPEC_WARN_OPTIONS.spell:format(127834),
	specwarnPlatform	= "Показывать спецпредупреждение, когда босс меняет платформу",
	ArrowOnAttenuation	= "Показывать стрелку DBM во время $spell:127834, чтобы указать в каком направлении двигаться",
	MindControlIcon		= DBM_CORE_L.AUTO_ICONS_OPTION_TARGETS:format(122740)
})

L:SetMiscLocalization({
	Platform	= "летит к одной из своих платформ!",
	Defeat		= "Мы не погрузимся в отчаяние. Если она хочет, чтобы мы погибли – так и будет."
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
	specwarnUnder	= "Выйдите из фиолетового круга!"
})

L:SetOptionLocalization({
	warnCrush		= DBM_CORE_L.AUTO_ANNOUNCE_OPTIONS.spell:format(122774),
	specwarnUnder	= "Показывать спецпредупреждение, когда Вы стоите под боссом",
	PheromonesIcon	= DBM_CORE_L.AUTO_ICONS_OPTION_TARGETS:format(122835)
})

L:SetMiscLocalization({
	UnderHim	= "под ним",
	Phase2		= "доспех Гаралона начинает трескаться и расползаться"
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
	warnReshapeLife				= "%s на >%s< (%d)",
	warnReshapeLifeTutor		= "1: Сбить каст/продебаффать цель (используйте это на боссе, чтобы настакать дебафф), 2: Сбить себе каст, когда кастуется Янтарный взрыв, 3: Восстановить силу воли, когда ее мало (используйте в основном на 3-й фазе), 4: Выйти (только на 1-й и 2-й фазе)",
	warnAmberExplosion			= ">%s< кастует %s",
	warnAmberExplosionAM		= "Янтарное чудовище кастует Янтарный взрыв - Сбейте!",--personal warning.
	warnInterruptsAvailable		= "Сбить %s могут: >%s<",
	warnWillPower				= "Текущая сила воли: %s",
	specwarnWillPower			= "Низкая сила воли! - выйдите или поглотите лужу",
	specwarnAmberExplosionYou	= "Сбейте СВОЙ %s!",--Struggle for Control interrupt.
	specwarnAmberExplosionAM	= "%s: Прервать %s!",--Amber Montrosity
	specwarnAmberExplosionOther	= "%s: Прервать %s!"--Mutated Construct
})

L:SetTimerLocalization{
	timerDestabalize		= "Дестабилизация (%2$d) : %1$s",
	timerAmberExplosionAMCD	= "Восст. Взрыв: Чудовище"
}

L:SetOptionLocalization({
	warnReshapeLife				= DBM_CORE_L.AUTO_ANNOUNCE_OPTIONS.target:format(122784),
	warnReshapeLifeTutor		= "Показывать назначение способностей у Мутировавшего организма",
	warnAmberExplosion			= "Показывать предупреждение (с источником) о начале применения $spell:122398",
	warnAmberExplosionAM		= "Персональное предупреждение о начале применения $spell:122398 (для прерывания)",
	warnInterruptsAvailable		= "Показывать, кто может сбить $spell:122402",
	warnWillPower				= "Предупреждать об уровне силы воли на 80, 50, 30, 10 и 4.",
	specwarnWillPower			= "Показывать спецпредупреждение, когда уровень силы воли слишком низкий",
	specwarnAmberExplosionYou	= "Показывать спецпредупреждение для прерывания своего $spell:122398",
	specwarnAmberExplosionAM	= "Показывать спецпредупреждение для прерывания $spell:122402 у Янтарного чудовища",
	specwarnAmberExplosionOther	= "Показывать спецпредупреждение для прерывания $spell:122398 у Мутировавшего организма",
	timerDestabalize			= DBM_CORE_L.AUTO_TIMER_OPTIONS.target:format(123059),
	timerAmberExplosionAMCD		= "Отсчет времени до следующего $spell:122402 у Янтарного чудовища",
	InfoFrame					= "Показывать информационное окно для игроков с низким уровнем силы воли",
	FixNameplates				= "Автоматически отключать мешающие индикаторы здоровья во время построения<br/>(восстанавливает настройки после выхода из боя)"
})

L:SetMiscLocalization({
	WillPower	= "Сила воли"
})

------------
-- Grand Empress Shek'zeer --
------------
L = DBM:GetModLocalization(743)

L:SetWarningLocalization({
	warnAmberTrap	= "Прогресс создания Янтарной ловушки: (%d/5)"
})

L:SetOptionLocalization({
	warnAmberTrap	= "Показывать предупреждение (с прогрессом) при создании $spell:125826",
	InfoFrame		= "Показывать информационное окно для игроков с $spell:125390",
	RangeFrame			= DBM_CORE_L.AUTO_RANGE_OPTION_TEXT:format(5, 123735),
	StickyResinIcons	= DBM_CORE_L.AUTO_ICONS_OPTION_TARGETS:format(124097),
	HeartOfFearIcon		= DBM_CORE_L.AUTO_ICONS_OPTION_TARGETS:format(123845)
})

L:SetMiscLocalization({
	PlayerDebuffs	= "Сосредоточение",
	YellPhase3		= "Больше никаких оправданий, императрица! Избавься от этих кретинов или я сам убью тебя!"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("HoFTrash")

L:SetGeneralLocalization({
	name	= "Трэш мобы Сердца Страха"
})

------------
-- Protectors of the Endless --
------------
L = DBM:GetModLocalization(683)

L:SetWarningLocalization({
	warnGroupOrder		= "Ротация: группа %s",
	specWarnYourGroup	= "Ваша группа должна получить дебафф!"
})

L:SetOptionLocalization({
	warnGroupOrder		= "Объявлять ротацию для $spell:118191<br/>(В настоящее время поддерживается только стратегия для 25 человек: 5,2,2,2, и т.д.)",
	specWarnYourGroup	= "Показывать спецпредупреждение, когда Ваша группа должна получить $spell:118191<br/>(Только для 25 человек)",
	RangeFrame			= DBM_CORE_L.AUTO_RANGE_OPTION_TEXT:format(8, 111850) .. "<br/>(Показывает всех, если на Вас дебафф, иначе только игроков с дебаффом)",
	SetIconOnPrison		= DBM_CORE_L.AUTO_ICONS_OPTION_TARGETS:format(117436)
})

------------
-- Tsulong --
------------
L = DBM:GetModLocalization(742)

L:SetMiscLocalization{
	Victory	= "Спасибо вам, незнакомцы. Я свободен."
}

-------------------------------
-- Lei Shi --
-------------------------------
L = DBM:GetModLocalization(729)

L:SetWarningLocalization({
	warnHideOver	= "%s закончилось"
})

L:SetTimerLocalization({
	timerSpecialCD	= "Восст. Спецспособность (%d)"
})

L:SetOptionLocalization({
	warnHideOver	= "Показывать предупреждение о появлении босса после $spell:123244",
	timerSpecialCD	= "Отсчет времени до следующей спецспособности",
	RangeFrame		= DBM_CORE_L.AUTO_RANGE_OPTION_TEXT:format(3, 123121) .. "<br/>(Показывает всех во время $spell:123244, иначе только танков)"
})

L:SetMiscLocalization{
	Victory	= "Я... а... о! Я?.. Все было таким... мутным."--wtb alternate and less crappy victory event.
}

----------------------
-- Sha of Fear --
----------------------
L = DBM:GetModLocalization(709)

L:SetWarningLocalization({
	MoveForward					= "Пробегите через босса",
	MoveRight					= "Перейдите направо",
	MoveBack					= "Вернитесь назад",
	specWarnBreathOfFearSoon	= "Скоро дыхание страха - зайдите в конус света!"
})

L:SetTimerLocalization({
	timerSpecialAbilityCD	= "След. Спецспособность",
	timerSpoHudCD			= "Восст. Страх / Изводень",
	timerSpoStrCD			= "Восст. Изводень / Клив",
	timerHudStrCD			= "Восст. Страх / Клив"
})

L:SetOptionLocalization({
	warnThrash					= DBM_CORE_L.AUTO_ANNOUNCE_OPTIONS.spell:format(131996),
	warnBreathOnPlatform		= "Показывать предупреждение о $spell:119414, когда Вы на платформе<br/>(Не рекомендуется, для лидера рейда)",
	specWarnBreathOfFearSoon	= "Заранее предупреждать о $spell:119414, если на Вас нет баффа $spell:117964",
	specWarnMovement			= "Показывать спецпредупреждение, указывающее, куда двигаться, когда произносится $spell:120047<br/>(На основе общей стратегии позиционирования)",
	timerSpecialAbility			= "Отсчет времени до применения следующей спецспособности",
	RangeFrame					= DBM_CORE_L.AUTO_RANGE_OPTION_TEXT:format(2, 119519),
	SetIconOnHuddle				= DBM_CORE_L.AUTO_ICONS_OPTION_TARGETS:format(120629)
})

--------------------------
-- Jin'rokh the Breaker --
--------------------------
L = DBM:GetModLocalization(827)

L:SetWarningLocalization({
	specWarnWaterMove	= "Скоро %s - выйдите из Проводящей воды!"
})

L:SetOptionLocalization({
	specWarnWaterMove	= "Показывать спецпредупреждение, если Вы стоите в $spell:138470<br/>(В том случае, если скоро $spell:137313 или спадает дебафф $spell:138732)",
	RangeFrame			= DBM_CORE_L.AUTO_RANGE_OPTION_TEXT_SHORT:format("8/4")
})

--------------
-- Horridon --
--------------
L = DBM:GetModLocalization(819)

L:SetWarningLocalization({
	warnAdds				= "%s",
	warnOrbofControl		= "Появилась Сфера контроля",
	specWarnOrbofControl	= "Появилась Сфера контроля!"
})

L:SetTimerLocalization({
	timerDoor	= "Следующие ворота племени",
	timerAdds	= "Следующие %s"
})

L:SetOptionLocalization({
	warnAdds				= "Показывать предупреждение, когда спрыгивают новые адды",
	warnOrbofControl		= "Показывать предупреждение о появлении $journal:7092",
	specWarnOrbofControl	= "Показывать спецпредупреждение о появлении $journal:7092",
	timerDoor				= "Отсчёт времени до следующей фазы ворот племени",
	timerAdds				= "Отсчёт времени до спрыгивания следующих аддов",
	SetIconOnAdds			= "Устанавливать метки на аддов, спрыгивающих с балкона",
	RangeFrame				= DBM_CORE_L.AUTO_RANGE_OPTION_TEXT:format(5, 136480),
	SetIconOnCharge			= DBM_CORE_L.AUTO_ICONS_OPTION_TARGETS:format(136769)
})

L:SetMiscLocalization({
	newForces		= "прибывают из-за ворот",--Войска племени Амани прибывают из-за ворот племени Амани!
	chargeTarget	= "бьет хвостом!"--Хорридон останавливает свой взгляд на Тентаклюме и бьет хвостом!
})

---------------------------
-- The Council of Elders --
---------------------------
L = DBM:GetModLocalization(816)

L:SetWarningLocalization({
	specWarnPossessed	= "%s на %s - переключитесь"
})

L:SetOptionLocalization({
	warnPossessed		= DBM_CORE_L.AUTO_ANNOUNCE_OPTIONS.target:format(136442),
	specWarnPossessed	= DBM_CORE_L.AUTO_SPEC_WARN_OPTIONS.switch:format(136442),
	RangeFrame			= DBM_CORE_L.AUTO_RANGE_OPTION_TEXT_SHORT:format(5),
	AnnounceCooldowns	= "Отсчитывать (до 3), какой сейчас каст $spell:137166 для рейдовых кулдаунов",
	SetIconOnBitingCold	= DBM_CORE_L.AUTO_ICONS_OPTION_TARGETS:format(136992),
	SetIconOnFrostBite	= DBM_CORE_L.AUTO_ICONS_OPTION_TARGETS:format(136922)
})

------------
-- Tortos --
------------
L = DBM:GetModLocalization(825)

L:SetWarningLocalization({
	warnKickShell			= "%s использован >%s< (осталось %d)",
	specWarnCrystalShell	= "Получите %s"
})

L:SetOptionLocalization({
	warnKickShell			= DBM_CORE_L.AUTO_ANNOUNCE_OPTIONS.spell:format(134031),
	specWarnCrystalShell	= "Показывать спецпредупреждение, когда на Вас нет дебаффа $spell:137633 и более 90% здоровья",
	InfoFrame				= "Показывать информационное окно для игроков без $spell:137633",
	ClearIconOnTurtles		= "Убирать метки с $journal:7129, когда активируется $spell:133971",
	AnnounceCooldowns		= "Подсчитывать, какой $spell:134920 применяется для восстановления способностей рейда"
})

L:SetMiscLocalization({
	WrongDebuff	= "Нет %s"
})

-------------
-- Megaera --
-------------
L = DBM:GetModLocalization(821)

L:SetTimerLocalization({
	timerBreathsCD	= "Следующее дыхание"
})

L:SetOptionLocalization({
	timerBreaths			= "Отсчёт времени до следующего дыхания",
	SetIconOnCinders		= DBM_CORE_L.AUTO_ICONS_OPTION_TARGETS:format(139822),
	SetIconOnTorrentofIce	= DBM_CORE_L.AUTO_ICONS_OPTION_TARGETS:format(139889),
	AnnounceCooldowns		= "Подсчитывать, какое $spell:139458 применяется для восстановления способностей рейда",
	Never					= "Никогда",
	Every					= "Каждый (последовательно)",
	EveryTwo				= "Восстановление способности, каждый 2-й",
	EveryThree				= "Восстановление способности, каждый 3-й",
	EveryTwoExcludeDiff		= "Восстановление способности, каждый 2-й (искл. $spell:139993)",
	EveryThreeExcludeDiff	= "Восстановление способности, каждый 3-й (искл. $spell:139993)"
})

L:SetMiscLocalization({
	rampageEnds	= "Ярость Мегеры идет на убыль."
})

------------
-- Ji-Kun --
------------
L = DBM:GetModLocalization(828)

L:SetWarningLocalization({
	warnFlock			= "%s %s %s",
	specWarnFlock		= "%s %s %s",
	specWarnBigBird		= "Страж гнезда: %s",
	specWarnBigBirdSoon	= "Скоро Страж гнезда: %s"
})

L:SetTimerLocalization({
	timerFlockCD	= "Гнездо (%d): %s"
})

L:SetOptionLocalization({
	warnFlock			= DBM_CORE_L.AUTO_ANNOUNCE_OPTIONS.count:format("ej7348"),
	specWarnFlock		= DBM_CORE_L.AUTO_SPEC_WARN_OPTIONS.switch:format("ej7348"),
	specWarnBigBird		= DBM_CORE_L.AUTO_SPEC_WARN_OPTIONS.switch:format("ej7827"),
	specWarnBigBirdSoon	= DBM_CORE_L.AUTO_SPEC_WARN_OPTIONS.soon:format("ej7827"),
	timerFlockCD		= DBM_CORE_L.AUTO_TIMER_OPTIONS.nextcount:format("ej7348"),
	RangeFrame			= DBM_CORE_L.AUTO_RANGE_OPTION_TEXT:format(10, 138923),
	ShowNestArrows	= "Показывать спецпредупреждение только для выбранного Вами местоположения гнезда",
	Never			= "Все гнезда",
	Northeast		= "Синий - Низ & Верх СВ",
	Southeast		= "Зеленый - Низ & Верх ЮВ",
	Southwest		= "Фиолетовый/Красный - Низ ЮЗ & Верх ЮЗ(25) или Верх Центр(10)",
	West			= "Красный - Низ З & Верх Центр (только 25)",
	Northwest		= "Желтый - Низ & Верх СЗ (только 25)",
	Guardians		= "Стражи гнезда"
})

L:SetMiscLocalization({
	eggsHatch		= "гнезд начинают проклевываться!",
	Upper			= "Верхний",
	Lower			= "Нижний",
	UpperAndLower	= "Верхний и Нижний",
	TrippleD		= "Тройной (2 нижних)",
	TrippleU		= "Тройной (2 верхних)",
	NorthEast		= "|cff0000ffСВ|r",--Синий
	SouthEast		= "|cFF088A08ЮВ|r",--Зеленый
	SouthWest		= "|cFF9932CDЮЗ|r",--Фиолетовый
	West			= "|cffff0000З|r",--Красный
	NorthWest		= "|cffffff00СЗ|r",--Желтый
	Middle10		= "|cFF9932CDЦентр|r",--Фиолетовый (Центр - это верх юго-запад для 10 ппл/LFR)
	Middle25		= "|cffff0000Центр|r",--Красный (Центр - это верх запад для 25 ппл)
	ArrowUpper		= " |TInterface\\Icons\\misc_arrowlup:12:12|t ",
	ArrowLower		= " |TInterface\\Icons\\misc_arrowdown:12:12|t "
})

--------------------------
-- Durumu the Forgotten --
--------------------------
L = DBM:GetModLocalization(818)

L:SetWarningLocalization({
	warnBeamNormal				= "Лучи - |cffff0000Красный|r : >%s<, |cff0000ffСиний|r : >%s<",
	warnBeamHeroic				= "Лучи - |cffff0000Красный|r : >%s<, |cff0000ffСиний|r : >%s<, |cffffff00Желтый|r : >%s<",
	warnAddsLeft				= "Туманов осталось: %d",
	specWarnBlueBeam			= "Синий луч на Вас - избегайте движения!",
	specWarnFogRevealed			= "%s обнаружен!",
	specWarnDisintegrationBeam	= "%s (%s)"
})

L:SetOptionLocalization({
	warnBeam			= "Показывать предупреждение для целей луча",
	warnAddsLeft		= "Показывать предупреждение для оставшихся туманов",
	specWarnFogRevealed	= "Показывать спецпредупреждение при обнаружении туманов",
	specWarnBlueBeam			= DBM_CORE_L.AUTO_SPEC_WARN_OPTIONS.spell:format(139202),
	specWarnDisintegrationBeam	= DBM_CORE_L.AUTO_SPEC_WARN_OPTIONS.spell:format("ej6882"),
	ArrowOnBeam			= "Показывать стрелку DBM во время $journal:6882, чтобы указать, в каком направлении двигаться",
	SetIconRays					= DBM_CORE_L.AUTO_ICONS_OPTION_TARGETS:format("ej6891"),
	SetIconLifeDrain			= DBM_CORE_L.AUTO_ICONS_OPTION_TARGETS:format(133795),
	SetIconOnParasite			= DBM_CORE_L.AUTO_ICONS_OPTION_TARGETS:format(133597),
	InfoFrame			= "Показывать информационное окно для кол-ва стаков $spell:133795",
	SetParticle			= "Автоматически устанавливать минимальную плотность частиц на пулле<br/>(Настройка восстановится после выхода из боя)"
})

L:SetMiscLocalization({
	LifeYell	= "Похищение жизни на %s (%d)"
})

----------------
-- Primordius --
----------------
L = DBM:GetModLocalization(820)

L:SetWarningLocalization({
	warnDebuffCount	= "Прогресс мутации: %d/5 хороших и %d плохих"
})

L:SetOptionLocalization({
	warnDebuffCount		= "Показывать предупреждение о количестве дебаффов, когда Вы поглощаете лужи",
	RangeFrame			= DBM_CORE_L.AUTO_RANGE_OPTION_TEXT_SHORT:format("5/3"),
	SetIconOnBigOoze	= "Ставить метку на $journal:6969"
})

-----------------
-- Dark Animus --
-----------------
L = DBM:GetModLocalization(824)

L:SetWarningLocalization({
	warnMatterSwapped	= "%s: >%s< и >%s< поменялись"
})

L:SetOptionLocalization({
	warnMatterSwapped	= "Показывать предупреждение для целей, которые поменялись местами с помощью $spell:138618",
	SetIconOnFont		= DBM_CORE_L.AUTO_ICONS_OPTION_TARGETS:format(138707)
})

L:SetMiscLocalization({
	Pull	= "Сфера взрывается!"
})

--------------
-- Iron Qon --
--------------
L = DBM:GetModLocalization(817)

L:SetWarningLocalization({
	warnDeadZone	= "%s: %s и %s защитованы"
})

L:SetOptionLocalization({
	warnDeadZone			= DBM_CORE_L.AUTO_ANNOUNCE_OPTIONS.spell:format(137229),
	SetIconOnLightningStorm	= DBM_CORE_L.AUTO_ICONS_OPTION_TARGETS:format(136192),
	RangeFrame	= "Показывать динамическое окно проверки дистанции (10 м.)<br/>Это умная рамка диапазона, которая показывает, когда слишком много объектов находятся слишком близко",
	InfoFrame	= "Показывать информационное окно для игроков с $spell:136193"
})

-------------------
-- Twin Consorts --
-------------------
L = DBM:GetModLocalization(829)

L:SetWarningLocalization({
	warnNight	= "Ночная фаза",
	warnDay		= "Дневная фаза",
	warnDusk	= "Фаза сумерек"
})

L:SetTimerLocalization({
	timerDayCD	= "След. Дневная фаза",
	timerDuskCD	= "След. Фаза сумерек"
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
	DuskPhase	= "Мне нужна твоя сила, Лу'линь!"
})

--------------
-- Lei Shen --
--------------
L = DBM:GetModLocalization(832)

L:SetWarningLocalization({
	specWarnIntermissionSoon	= "Скоро смена фазы",
	warnDiffusionChainSpread	= "%s распространилось на >%s<"
})

L:SetTimerLocalization({
	timerConduitCD	= "Восст. Первый проводник"
})

L:SetOptionLocalization({
	specWarnIntermissionSoon	= "Показывать спецпредупреждение перед началом промежуточной фазы",
	warnDiffusionChainSpread	= "Показывать предупреждение для целей, на которых действует $spell:135991",
	timerConduitCD				= "Отсчет времени до восстановления способности первого проводника",
	RangeFrame					= DBM_CORE_L.AUTO_RANGE_OPTION_TEXT_SHORT:format("8/6"),--Для двух разных заклинаний
	StaticShockArrow			= "Показывать стрелку DBM, когда на ком-то $spell:135695",
	OverchargeArrow				= "Показывать стрелку DBM, когда на ком-то $spell:136295",
	SetIconOnOvercharge			= DBM_CORE_L.AUTO_ICONS_OPTION_TARGETS:format(136295),
	SetIconOnStaticShock		= DBM_CORE_L.AUTO_ICONS_OPTION_TARGETS:format(135695)
})

L:SetMiscLocalization({
	StaticYell	= "Статический шок на %s (%d)"
})

------------
-- Ra-den --
------------
L = DBM:GetModLocalization(831)

L:SetWarningLocalization({
	specWarnUnstablVitaJump	= "Нестабильная жизнь перепрыгнула на Вас!"
})

L:SetOptionLocalization({
	specWarnUnstablVitaJump	= "Показывать спецпредупреждение, когда $spell:138297 перепрыгивает на Вас"
})

L:SetMiscLocalization({
	Defeat	= "Остановитесь! Я... не враг вам. Вы сильны. Даже сильнее его… Может, вы и правы. Может, есть еще надежда."
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("ToTTrash")

L:SetGeneralLocalization({
	name	= "Трэш мобы Престол Гроз"
})

L:SetOptionLocalization({
	RangeFrame	= DBM_CORE_L.AUTO_RANGE_OPTION_TEXT_SHORT:format(10)--Для 3-х разных заклинаний
})

---------------
-- Immerseus --
---------------
L = DBM:GetModLocalization(852)

L:SetMiscLocalization({
	Victory	= "У вас получилось! Теперь воды снова чисты."
})

---------------------------
-- The Fallen Protectors --
---------------------------
L = DBM:GetModLocalization(849)

L:SetWarningLocalization({
	specWarnCalamity	= "%s",
	specWarnMeasures	= "Скоро Крайние меры (%s)!"
})

---------------------------
-- Norushen --
---------------------------
L = DBM:GetModLocalization(866)

L:SetMiscLocalization({
	wasteOfTime	= "Хорошо, я создам поле для удерживания порчи."
})

------------------
-- Sha of Pride --
------------------
L = DBM:GetModLocalization(867)

L:SetOptionLocalization({
	SetIconOnFragment	= "Устанавливать метку на Оскверненный осколок"
})

L:SetMiscLocalization({
	PortalRP	= "Гордыня Гарроша выпустила последнего ша. Я не удивлена."
})

--------------
-- Galakras --
--------------
L = DBM:GetModLocalization(868)

L:SetWarningLocalization({
	warnTowerOpen	= "Башня открылась",
	warnTowerGrunt	= "Рубака у башни"
})

L:SetTimerLocalization({
	timerTowerCD		= "След. Башня",
	timerTowerGruntCD	= "След. Рубака у башни"
})

L:SetOptionLocalization({
	warnTowerOpen		= "Показывать предупреждение, когда башня открывается",
	warnTowerGrunt		= "Показывать предупреждение, когда появляется новый Рубака у башни",
	timerTowerCD		= "Отсчет времени до следующего нападения на башню",
	timerTowerGruntCD	= "Отсчет времени до следующего Рубаки у башни"
})

L:SetMiscLocalization({
	wasteOfTime		= "Отлично! Десант, стройся! Пехота – впереди.",--Alliance Version
	wasteOfTime2	= "Отлично, первый отряд высадился.",--Horde Version
	Pull			= "Воины Драконьей Пасти! Отбейте пристань и сбросьте врага в море! Во имя Истинной Орды!",
	newForces1		= "Вот и они!",--Jaina's line, horde may not be same
	newForces1H		= "Сбейте ее скорее, не терпится взять ее за глотку.",--Sylva's line, horde
	newForces2		= "Драконья Пасть, вперед!",
	newForces3		= "За Гарроша!",
	newForces4		= "Следующий отряд!",
	tower			= "Дверь "--Дверь южной/северной башни разбита!
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
	PrisonYell	= "Тюрьма на %s спадает (%d)"
})

---------------------
-- General Nazgrim --
---------------------
L = DBM:GetModLocalization(850)

L:SetWarningLocalization({
	warnDefensiveStanceSoon	= "Оборонительная стойка через %d сек."
})

L:SetOptionLocalization({
	warnDefensiveStanceSoon	= DBM_CORE_L.AUTO_ANNOUNCE_OPTIONS.prewarn:format(143593)
})

L:SetMiscLocalization({
	newForces1	= "Воины, бегом!",
	newForces2	= "Удерживайте врата!",
	newForces3	= "Сомкнуть ряды!",
	newForces4	= "Кор'крон, ко мне!",
	newForces5	= "Следующий отряд, вперед!",
	allForces	= "Кор'кронцы... все, кто со мной! Убейте их!",
	nextAdds	= "Следующие адды: ",
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
	wasteOfTime	= "Эй, записываем? Хорошо. Запускаю гоблинско-титанский блок управления. Все назад.",
	Module1 	= "Первый модуль готов к перезагрузке системы.",
	Victory		= "Второй модуль готов к перезагрузке системы."
})

---------------------------
-- Thok the Bloodthirsty --
---------------------------
L = DBM:GetModLocalization(851)

L:SetOptionLocalization({
	RangeFrame	= "Показывать динамическое окно проверки дистанции (10 м.)<br/>(Это умное окно проверки дистанции, которое появляется, когда Вы достигаете порога $spell:143442)"
})

----------------------------
-- Siegecrafter Blackfuse --
----------------------------
L = DBM:GetModLocalization(865)

L:SetMiscLocalization({
	newWeapons	= "На сборочную линию начинает поступать незаконченное оружие.",
	newShredder	= "Приближается автоматический крошшер!"
})

----------------------------
-- Paragons of the Klaxxi --
----------------------------
L = DBM:GetModLocalization(853)

L:SetWarningLocalization({
	specWarnActivatedVulnerable	= "Вы уязвимы к %s - Избегайте!",
	specWarnMoreParasites		= "Вам нужно больше паразитов - Не блокируйте!"
})

L:SetOptionLocalization({
	warnToxicCatalyst			= DBM_CORE_L.AUTO_ANNOUNCE_OPTIONS.spell:format("ej8036"),
	specWarnActivatedVulnerable	= "Показывать спецпредупреждение, когда Вы уязвимы к активирующимся идеалам",
	specWarnMoreParasites		= "Показывать спецпредупреждение, когда Вам нужно больше паразитов",
	yellToxicCatalyst			= DBM_CORE_L.AUTO_YELL_OPTION_TEXT.yell:format("ej8036")
})

L:SetMiscLocalization({
	--thanks to blizz, the only accurate way for this to work, is to translate 5 emotes in all languages
	one				= "один",
	two				= "два",
	three			= "три",
	four			= "четыре",
	five			= "пять",
	hisekFlavor		= "Смотрите, кто теперь тихий",--http://ptr.wowhead.com/quest=31510
	KilrukFlavor	= "Обычный рабочий день, уничтожаем рой",--http://ptr.wowhead.com/quest=31109
	XarilFlavor		= "Я вижу только темные небеса в твоем будущем",--http://ptr.wowhead.com/quest=31216
	KaztikFlavor	= "Сойдёт на угощение куньчуну",--http://ptr.wowhead.com/quest=31024
	KaztikFlavor2	= "1 богомол убит, осталось 199",--http://ptr.wowhead.com/quest=31808
	KorvenFlavor	= "Конец древней империи",--http://ptr.wowhead.com/quest=31232
	KorvenFlavor2	= "Забери свои гуртанские таблички и подавись ими",--http://ptr.wowhead.com/quest=31232
	IyyokukFlavor	= "Видишь возможности. Используй их!",--Does not have quests, http://ptr.wowhead.com/npc=65305
	KarozFlavor		= "Ты больше не будешь прыгать!",---Does not have quests, http://ptr.wowhead.com/npc=65303
	SkeerFlavor		= "Кровавое удовольствие!",--http://ptr.wowhead.com/quest=31178
	RikkalFlavor	= "Запрос образцов выполнен"--http://ptr.wowhead.com/quest=31508
})

------------------------
-- Garrosh Hellscream --
------------------------
L = DBM:GetModLocalization(869)

L:SetTimerLocalization({
	timerRoleplay	= GUILD_INTEREST_RP
})

L:SetOptionLocalization({
	timerRoleplay		= "Отсчет времени до ролевой игры (Гаррош/Тралл)",
	RangeFrame			= "Показывать динамическое окно проверки дистанции (8 м.)<br/>(Это умное окно проверки дистанции, которое появляется, когда Вы достигаете порога $spell:147126)",
	InfoFrame			= "Показывать информационное окно для игроков без снижения урона на переходной фазе"
})

L:SetMiscLocalization({
	wasteOfTime		= "Еще не поздно, Гаррош. Сними с себя мантию вождя. Мы можем закончить все здесь и сейчас.",
	NoReduce		= "Нет снижения урона",
	phase3End		= "Думаете, вы победили? Слепцы. Я раскрою вам глаза!"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("SoOTrash")

L:SetGeneralLocalization({
	name	= "Трэш мобы Осады Оргриммара"
})
