if GetLocale() ~= "ruRU" then return end

local L

---------------
--  Kalecgos --
---------------
L = DBM:GetModLocalization("Kal")

L:SetGeneralLocalization{
	name = "Калесгос"
}

L:SetWarningLocalization{
	WarnPortal			= "Портал #%d : >%s< (Группа %d)",
	SpecWarnWildMagic	= "Дикая магия - %s!"
}

L:SetTimerLocalization{
	TimerNextPortal		= "Портал (%d)"
}

L:SetOptionLocalization{
	WarnPortal			= "Показывать предупреждение для цели $spell:46021",
	SpecWarnWildMagic	= "Показать спецпредупреждение для $spell:45004",
	ShowFrame			= "Показывать фрейм $spell:44852",
	FrameClassColor		= "Использовать цвета классов во фрейме $spell:44852",
	FrameUpwards		= "Развернуть фрейм $spell:44852 вверх",
	FrameLocked			= "Сделать фрейм $spell:44852 неподвижным",
	RangeFrame			= DBM_CORE_L.AUTO_RANGE_OPTION_TEXT:format(10, 46021)
}

L:SetMiscLocalization{
	Demon				= "Сатроварр Осквернитель",
	Heal				= "+100% хила",
	Haste				= "+100% время каста",
	Hit					= "-50% шанс попадания",
	Crit				= "+100% крит. дамага",
	Aggro				= "+100% угроза",
	Mana				= "-50% стоимости заклинаний",
	FrameTitle			= "Призрачный мир",
	FrameLock			= "Закрепить рамку",
	FrameClassColor		= "Использовать цвета класса",
	FrameOrientation	= "Развернуть вверх",
	FrameHide			= "Скрыть рамку",
	FrameClose			= "Закрыть"
}

----------------
--  Brutallus --
----------------
L = DBM:GetModLocalization("Brutallus")

L:SetGeneralLocalization{
	name = "Бруталл"
}

L:SetMiscLocalization{
	Pull			= "Аа, новые овечки на заклание?"
}

--------------
--  Felmyst --
--------------
L = DBM:GetModLocalization("Felmyst")

L:SetGeneralLocalization{
	name = "Пророк Скверны"
}

L:SetWarningLocalization{
	WarnPhase		= "Фаза %s"
}

L:SetTimerLocalization{
	TimerPhase		= "Следующая фаза %s",
}

L:SetOptionLocalization{
	WarnPhase		= "Показывать предупреждение для следующей фазы",
	TimerPhase		= "Отсчёт времени до следующей фазы",
	VaporIcon		= DBM_CORE_L.AUTO_ICONS_OPTION_TARGETS:format(45392),
	EncapsIcon		= DBM_CORE_L.AUTO_ICONS_OPTION_TARGETS:format(45665)
}

L:SetMiscLocalization{
	Air				= "Воздух",
	Ground			= "Земля",
	AirPhase		= "Я сильнее, чем когда-либо прежде!",
	Breath			= "%s делает глубокий вдох."
}

-----------------------
--  The Eredar Twins --
-----------------------
L = DBM:GetModLocalization("Twins")

L:SetGeneralLocalization{
	name = "Эредарские близнецы"
}

L:SetMiscLocalization{
	Nova			= "направляет Кольцо Тьмы на (.+)",
	Conflag			= "направляет Поджигание на (.+)",
	Sacrolash		= "Леди Сакролаш",
	Alythess		= "Главная чернокнижница Алитесса"
}

------------
--  M'uru --
------------
L = DBM:GetModLocalization("Muru")

L:SetGeneralLocalization{
	name = "М'ууру"
}

L:SetWarningLocalization{
	WarnHuman		= "Гуманоиды (%d)",
	WarnVoid		= "Часовой Бездны (%d)",
	WarnFiend		= "Исчадие тьмы появилось"
}

L:SetTimerLocalization{
	TimerHuman		= "Следующие Гуманоиды (%s)",
	TimerVoid		= "Следующий Часовой Бездны (%s)",
	TimerPhase		= "Энтропий"
}

L:SetOptionLocalization{
	WarnHuman		= "Показывать предупреждение для Гуманоидов",
	WarnVoid		= "Показывать предупреждение для Часового Бездны",
	WarnFiend		= "Показывать предупреждение для Демонов во 2-й фазе",
	TimerHuman		= "Отсчёт времени до Гуманоидов",
	TimerVoid		= "Отсчёт времени до Часового Бездны",
	TimerPhase		= "Отсчёт времени до перехода на 2-ю фазу"
}

L:SetMiscLocalization{
	Entropius		= "Энтропий"
}

----------------
--  Kil'jeden --
----------------
L = DBM:GetModLocalization("Kil")

L:SetGeneralLocalization{
	name = "Кил'джеден"
}

L:SetWarningLocalization{
	WarnDarkOrb		= "Появились Темные сферы",
	WarnBlueOrb		= "Сфера Дракона активирована",
	SpecWarnDarkOrb	= "Появились Темные сферы!",
	SpecWarnBlueOrb	= "Сферы Дракона активированы!"
}

L:SetTimerLocalization{
	TimerBlueOrb	= "Активировать Сферы Дракона"
}

L:SetOptionLocalization{
	WarnDarkOrb		= "Показывать предупреждение для Темных сфер",
	WarnBlueOrb		= "Показывать предупреждение для Сфер Дракона",
	SpecWarnDarkOrb	= "Показывать спецпредупреждение для Темных сфер",
	SpecWarnBlueOrb	= "Показывать спецпредупреждение для Сфер Дракона",
	TimerBlueOrb	= "Отсчёт времени до активации формы Сфер Дракона",
	RangeFrame		= DBM_CORE_L.AUTO_RANGE_OPTION_TEXT:format(10, 45641),
	BloomIcon		= DBM_CORE_L.AUTO_ICONS_OPTION_TARGETS:format(45641)
}

L:SetMiscLocalization{
	YellPull		= "Те, кем можно было пожертвовать, мертвы. Так тому и быть! Я добьюсь успеха там, где Саргерас потерпел поражение! Я заставлю этот жалкий мирок истекать кровью и навеки закреплю за собой место повелителя Пылающего Легиона! Пробил последний час этого мира!",
	OrbYell1		= "Я наполню сферы своей энергией! Готовьтесь!",
	OrbYell2		= "Я наполнил энергией еще одну сферу! Быстрее используйте ее!",
	OrbYell3		= "Еще одна сфера готова! Поторопитесь!",
	OrbYell4		= "Я отдал все, что мог. Моя энергия в ваших руках!"

}

-----------------
--  Najentus  --
-----------------
L = DBM:GetModLocalization("Najentus")

L:SetGeneralLocalization{
	name = "Верховный Полководец Надж'ентус"
}

L:SetMiscLocalization{
	HealthInfo	= "Инфо о здоровье"
}

----------------
-- Supremus --
----------------
L = DBM:GetModLocalization("Supremus")

L:SetGeneralLocalization{
	name = "Супремус"
}

L:SetWarningLocalization{
	WarnPhase		= "Фаза %s"
}

L:SetTimerLocalization{
	TimerPhase		= "Следующая фаза %s"
}

L:SetOptionLocalization{
	WarnPhase		= "Показывать предупреждение для следующей фазы",
	TimerPhase		= "Отсчёт времени до следующего этапа",
	KiteIcon		= "Устанавливать метку на цели, которая должна кайтить"
}

L:SetMiscLocalization{
	PhaseTank		= "в гневе ударяет по земле!",
	PhaseKite		= "Земля начинает раскалываться!",
	ChangeTarget	= "атакует новую цель!",
	Kite			= "Кайт",
	Tank			= "Танк"
}

-------------------------
--  Shape of Akama  --
-------------------------
L = DBM:GetModLocalization("Akama")

L:SetGeneralLocalization{
	name = "Тень Акамы"
}

L:SetWarningLocalization({
	warnAshtongueDefender	= "Пеплоуст-защитник",
	warnAshtongueSorcerer	= "Пеплоуст-колдун"
})

L:SetTimerLocalization({
	timerAshtongueDefender	= "Пеплоуст-защитник: %s",
	timerAshtongueSorcerer	= "Пеплоуст-колдун: %s"
})

L:SetOptionLocalization({
	warnAshtongueDefender	= "Показывать предупреждение для Пеплоуста-защитника",
	warnAshtongueSorcerer	= "Показывать предупреждение для Пеплоуста-колдуна",
	timerAshtongueDefender	= "Отсчёт времени до Пеплоуста-защитника",
	timerAshtongueSorcerer	= "Отсчёт времени до Пеплоуста-колдуна"
})

-------------------------
--  Teron Gorefiend  --
-------------------------
L = DBM:GetModLocalization("TeronGorefiend")

L:SetGeneralLocalization{
	name = "Терон Кровожад"
}

L:SetTimerLocalization{
	TimerVengefulSpirit		= "Призрак : %s"
}

L:SetOptionLocalization{
	TimerVengefulSpirit		= "Отсчёт времени до продолжительности действия Призрака"
}

----------------------------
--  Gurtogg Bloodboil  --
----------------------------
L = DBM:GetModLocalization("Bloodboil")

L:SetGeneralLocalization{
	name = "Гуртогг Кипящая Кровь"
}

--------------------------
--  Essence Of Souls  --
--------------------------
L = DBM:GetModLocalization("Souls")

L:SetGeneralLocalization{
	name = "Воплощение Душ"
}

L:SetWarningLocalization{
	WarnMana		= "Ноль маны через 30 сек"
}

L:SetTimerLocalization{
	TimerMana		= "Ноль маны"
}

L:SetOptionLocalization{
	WarnMana		= "Показывать предупреждение, когда ноль маны во 2-й фазе",
	TimerMana		= "Показывать таймер, когда ноль маны во 2-й фазе"
}

L:SetMiscLocalization{
	Suffering		= "Воплощение страдания",
	Desire			= "Воплощение мечты",
	Anger			= "Воплощение гнева",
	Phase1End		= "Я не хочу обратно!",
	Phase2End		= "Я буду неподалеку!"
}

-----------------------
--  Mother Shahraz --
-----------------------
L = DBM:GetModLocalization("Shahraz")

L:SetGeneralLocalization{
	name = "Матушка Шахраз"
}

L:SetTimerLocalization{
	timerAura	= "%s"
}

L:SetOptionLocalization{
	timerAura	= "Отсчёт времени до Радужной ауры",
	FAHelper	= "Установить режим мода для $spell:41001<br/>Используется предпочтение лидеров рейдов, если они используют DBM",
	North		= "Звезда - слева/запад, круг - справа/восток, ромб - вверх/север",--По умолчанию
	South		= "Звезда - слева/запад, круг - справа/восток, ромб - внизу/юг",
	None		= "Стрелки не будут отображаться. Инфофрейм будет показывать цифры вместо направлений"
}

----------------------
--  Illidari Council  --
----------------------
L = DBM:GetModLocalization("Council")

L:SetGeneralLocalization{
	name = "Совет Иллидари"
}

L:SetWarningLocalization{
	Immune			= "Маланда - %s иммунитет на 15 сек."
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
	Immune			= "Показывать предупреждение, когда Маланда становится невосприимчивой к заклинаниям или ближнему бою"
}

L:SetMiscLocalization{
	Gathios			= "Гатиос Изувер",
	Malande			= "Леди Маланда",
	Zerevor			= "Верховный пустомант Зеревор",
	Veras			= "Верас Глубокий Мрак",
	Melee			= "Ближний бой",
	Spell			= "Заклинание"
}

-------------------------
--  Illidan Stormrage --
-------------------------
L = DBM:GetModLocalization("Illidan")

L:SetGeneralLocalization{
	name = "Иллидан Ярость Бури"
}

L:SetWarningLocalization{
	WarnHuman		= "Обычная фаза",
	WarnDemon		= "Фаза Демона"
}

L:SetTimerLocalization{
	TimerNextHuman		= "Следующая Обычная фаза",
	TimerNextDemon		= "Следующая фаза Демона"
}

L:SetOptionLocalization{
	WarnHuman		= "Показывать предупреждение для Обычной фазы",
	WarnDemon		= "Показывать предупреждение для фазы Демона",
	TimerNextHuman	= "Отсчёт времени до Обычной фазы",
	TimerNextDemon	= "Отсчёт времени до фазы Демона",
	RangeFrame		= "Показывать проверку дистанции (10 ярдов) в фазах 3 и 4"
}

L:SetMiscLocalization{
	Pull			= "Акама. Я не удивлен твоей двуличностью. Давно нужно было убить тебя и твоих мерзких прихвостней.",
	Eyebeam			= "Взгляните в глаза Предателя!",
	Demon			= "Узрите силу... истинного демона!",
	Phase4			= "Это все, смертные? Это все, на что вы способны?"
}

------------------------
--  Rage Winterchill  --
------------------------
L = DBM:GetModLocalization("Rage")

L:SetGeneralLocalization{
	name = "Лютый Хлад"
}

-----------------
--  Anetheron  --
-----------------
L = DBM:GetModLocalization("Anetheron")

L:SetGeneralLocalization{
	name = "Анетерон"
}

----------------
--  Kazrogal  --
----------------
L = DBM:GetModLocalization("Kazrogal")

L:SetGeneralLocalization{
	name = "Каз'рогал"
}

---------------
--  Azgalor  --
---------------
L = DBM:GetModLocalization("Azgalor")

L:SetGeneralLocalization{
	name = "Азгалор"
}

------------------
--  Archimonde  --
------------------
L = DBM:GetModLocalization("Archimonde")

L:SetGeneralLocalization{
	name = "Архимонд"
}

----------------
-- WaveTimers --
----------------
L = DBM:GetModLocalization("HyjalWaveTimers")

L:SetGeneralLocalization{
	name 		= "Трэш мобы"
}

L:SetWarningLocalization{
	WarnWave	= "%s"
}

L:SetTimerLocalization{
	TimerWave	= "Следующая волна"
}

L:SetOptionLocalization{
	WarnWave		= "Предупреждать о приближении новой волны",
	DetailedWave	= "Подробное предупреждение о приближении новой волны (какие именно мобы)",
	TimerWave		= "Отсчёт времени до следующей волны"
}

L:SetMiscLocalization{
	HyjalZoneName	= "Вершина Хиджала",
	Thrall			= "Тралл",
	Jaina			= "Леди Джайна Праудмур",
	GeneralBoss		= "Босс прибывает",
	RageWinterchill	= "Лютый Хлад прибывает",
	Anetheron		= "Анетерон прибывает",
	Kazrogal		= "Каз'рогал прибывает",
	Azgalor			= "Азгалор прибывает",
	WarnWave_0		= "Волна %s/8",
	WarnWave_1		= "Волна %s/8 - %s %s",
	WarnWave_2		= "Волна %s/8 - %s %s и %s %s",
	WarnWave_3		= "Волна %s/8 - %s %s, %s %s и %s %s",
	WarnWave_4		= "Волна %s/8 - %s %s, %s %s, %s %s и %s %s",
	WarnWave_5		= "Волна %s/8 - %s %s, %s %s, %s %s, %s %s и %s %s",
	RageGossip		= "Мои спутники и я – с вами, леди Праудмур.",
	AnetheronGossip	= "Мы готовы встретить любого, кого пошлет Архимонд.",
	KazrogalGossip	= "Я с тобой, Тралл.",
	AzgalorGossip	= "Нам нечего бояться.",
	Ghoul			= "Вурдалака",
	Abomination		= "Поганища",
	Necromancer		= "Некроманта",
	Banshee			= "Банши",
	Fiend			= "Некрорахнида",
	Gargoyle		= "Горгульи",
	Wyrm			= "Ледяной змей",
	Stalker			= "Ловчих Скверны",
	Infernal		= "Инфернала"
}

-----------
--  Alar --
-----------
L = DBM:GetModLocalization("Alar")

L:SetGeneralLocalization{
	name = "Ал'ар"
}

L:SetTimerLocalization{
	NextPlatform	= "Следующая платформа"
}

L:SetOptionLocalization{
	NextPlatform	= "Показывать таймер, сколько времени Ал'ар может оставаться на платформе (может уйти раньше, но почти никогда позже)"
}

------------------
--  Void Reaver --
------------------
L = DBM:GetModLocalization("VoidReaver")

L:SetGeneralLocalization{
	name = "Страж Бездны"
}

--------------------------------
--  High Astromancer Solarian --
--------------------------------
L = DBM:GetModLocalization("Solarian")

L:SetGeneralLocalization{
	name = "Верховный звездочет Солариан"
}

L:SetWarningLocalization{
	WarnSplit		= "Разделение",
	WarnSplitSoon	= "Разделение через 5 секунд",
	WarnAgent		= "Посланники появились",
	WarnPriest		= "Жрецы и Солариан появились"

}

L:SetTimerLocalization{
	TimerSplit		= "Следующее разделение",
	TimerAgent		= "Посланники прибывают",
	TimerPriest		= "Жрецы и Солариан прибывают"
}

L:SetOptionLocalization{
	WarnSplit		= "Показывать предупреждение для разделения",
	WarnSplitSoon	= "Заранее предупреждать о разделении",
	WarnAgent		= "Показывать предупреждение о появлении Посланников",
	WarnPriest		= "Показывать предупреждение о появлении Жрецов и Солариана",
	TimerSplit		= "Отсчёт времени до разделения",
	TimerAgent		= "Отсчёт времени до появления Посланников",
	TimerPriest		= "Отсчёт времени до появления Жрецов и Солариана"
}

L:SetMiscLocalization{
	YellSplit1		= "Я навсегда избавлю вас от мании величия!",
	YellSplit2		= "Вы безнадежно слабы!",
	YellPhase2		= "Я сольюсь... с БЕЗДНОЙ!"
}

---------------------------
--  Kael'thas Sunstrider --
---------------------------
L = DBM:GetModLocalization("KaelThas")

L:SetGeneralLocalization{
	name = "Кель'тас Солнечный Скиталец"
}

L:SetWarningLocalization{
	WarnGaze		= "Взгляд на >%s<",
	WarnMobDead		= "%s упал",
	WarnEgg			= "Появилось яйцо Феникса",
	SpecWarnGaze	= "Взгляни на себя - убегай!",
	SpecWarnEgg		= "Появилось яйцо Феникса — поменяйте цель!"
}

L:SetTimerLocalization{
	TimerPhase		= "Следующая фаза",
	TimerPhase1mob	= "%s",
	TimerNextGaze	= "Новая цель взгляда",
	TimerRebirth	= "Возрождение Феникса"
}

L:SetOptionLocalization{
	WarnGaze		= "Показывать предупреждение для цели взгляда Таладреда Светокрада",
	WarnMobDead		= "Показывать предупреждение о падении моба на 2-й фазе",
	WarnEgg			= "Показывать предупреждение при появлении яйца Феникса",
	SpecWarnGaze	= "Показывать спецпредупреждение, когда на Вас взгляд",
	SpecWarnEgg		= "Показывать спецпредупреждение, когда появляется яйцо Феникса",
	TimerPhase		= "Отсчёт времени до следующего этапа",
	TimerPhase1mob	= "Отсчёт времени до активного моба на 1-й фазе",
	TimerNextGaze	= "Отсчёт времени до изменения цели взгляда Таладреда Светокрада",
	TimerRebirth	= "Отсчёт времени до оставшегося возрождения Яйца Феникса",
	GazeIcon		= "Установить метку на цель взгляда Таладреда Светокрада"
}

L:SetMiscLocalization{
	YellPhase2	= "Как видите, оружия у меня предостаточно...",
	YellPhase3	= "Возможно, я недооценил вас. Было бы несправедливо заставлять вас драться с четырьмя советниками сразу, но... Мои люди тоже никогда не знали справедливости. Я лишь возвращаю долг.",
	YellPhase4	= "Увы, иногда приходится брать все в свои руки. Баламоре шаналь!",
	YellPhase5	= "Я не затем ступил на этот путь, чтобы остановиться на полдороги! Мои планы должны сбыться – и они сбудутся! Узрите же истинную мощь!",
	YellSang	= "Вы справились с моими лучшими советниками... Но перед мощью Кровавого Молота не устоит никто. Узрите лорда Сангвинара!",
	YellCaper	= "Каперниан проследит, чтобы вы не задержались здесь надолго.",
	YellTelo	= "Неплохо, теперь вы можете потягаться с моим главным инженером Телоникусом.",
	EmoteGaze	= "бросает взгляд на ([^%s]+)!",
	Thaladred	= "Таладред Светокрад",
	Sanguinar	= "Лорд Сангвинар",
	Capernian	= "Великий Звездочет Каперниан",
	Telonicus	= "Старший инженер Телоникус",
	Bow			= "Длинный лук Края Пустоты",
	Axe			= "Сокрушитель",
	Mace		= "Вселенский вдохновитель",
	Dagger		= "Клинок Бесконечности",
	Sword		= "Астральный тесак",
	Shield		= "Фазовый щит",
	Staff		= "Посох распыления",
	Egg			= "Яйцо феникса"
}

---------------------------
--  Hydross the Unstable --
---------------------------
L = DBM:GetModLocalization("Hydross")

L:SetGeneralLocalization{
	name = "Гидросс Нестабильный"
}

L:SetWarningLocalization{
	WarnMark 		= "%s : %s",
	WarnPhase		= "Фаза %s",
	SpecWarnMark	= "%s : %s"
}

L:SetTimerLocalization{
	TimerMark	= "Следующий %s : %s"
}

L:SetOptionLocalization{
	WarnMark		= "Показать предупреждение для меток",
	WarnPhase		= "Показать предупреждение для следующей фазы",
	SpecWarnMark	= "Показывать предупреждение, когда урон от дебаффа меток превышает 100%",
	TimerMark		= "Отсчёт времени до следующих меток"
}

L:SetMiscLocalization{
	Frost	= "Мороз",
	Nature	= "Природа"
}

-----------------------
--  The Lurker Below --
-----------------------
L = DBM:GetModLocalization("LurkerBelow")

L:SetGeneralLocalization{
	name = "Скрытень из глубин"
}

L:SetWarningLocalization{
	WarnSubmerge		= "Погружение",
	WarnEmerge			= "Появление"
}

L:SetTimerLocalization{
	TimerSubmerge		= "Восстановление Погружения",
	TimerEmerge			= "Восстановление Появления"
}

L:SetOptionLocalization{
	WarnSubmerge		= "Показывать предупреждение при погружении",
	WarnEmerge			= "Показывать предупреждение при появлении",
	TimerSubmerge		= "Отсчёт времени до погружения",
	TimerEmerge			= "Отсчёт времени до появления"
}

--------------------------
--  Leotheras the Blind --
--------------------------
L = DBM:GetModLocalization("Leotheras")

L:SetGeneralLocalization{
	name = "Леотерас Слепец"
}

L:SetWarningLocalization{
	WarnPhase		= "Фаза %s"
}

L:SetTimerLocalization{
	TimerPhase	= "Следующая фаза %s"
}

L:SetOptionLocalization{
	WarnPhase		= "Показывать предупреждение для следующей фазы",
	TimerPhase		= "Отсчёт времени до следующей фазы"
}

L:SetMiscLocalization{
	Human		= "Человек",
	Demon		= "Демон",
	YellDemon	= "Прочь, жалкий эльф. Настало мое время!",
	YellPhase1  = "Наконец-то мое заточение окончено!",
	YellPhase2	= "Нет... нет! Что вы наделали? Я – главный! Слышишь меня? Я... Ааааах! Мне его... не удержать."
}

-----------------------------
--  Fathom-Lord Karathress --
-----------------------------
L = DBM:GetModLocalization("Fathomlord")

L:SetGeneralLocalization{
	name = "Повелитель глубин Каратресс"
}

L:SetMiscLocalization{
	Caribdis	= "Хранительница глубин Карибдис",
	Tidalvess	= "Хранитель глубин Волниис",
	Sharkkis	= "Хранитель глубин Шарккис"
}

--------------------------
--  Morogrim Tidewalker --
--------------------------
L = DBM:GetModLocalization("Tidewalker")

L:SetGeneralLocalization{
	name = "Морогрим Волноступ"
}

L:SetWarningLocalization{
	SpecWarnMurlocs	= "Мурлоки на подходе!"
}

L:SetTimerLocalization{
	TimerMurlocs	= "Мурлоки"
}

L:SetOptionLocalization{
	SpecWarnMurlocs	= "Показывать спецпредупреждение при появлении Мурлоков",
	TimerMurlocs	= "Отсчёт времени до появления Мурлоков",
	GraveIcon		= DBM_CORE_L.AUTO_ICONS_OPTION_TARGETS:format(38049)
}


-----------------
--  Lady Vashj --
-----------------
L = DBM:GetModLocalization("Vashj")

L:SetGeneralLocalization{
	name = "Леди Вайш"
}

L:SetWarningLocalization{
	WarnElemental		= "Нечистый элементаль через ~5 сек. (%s)",
	WarnStrider			= "Долгоног через ~5 сек. (%s)",
	WarnNaga			= "Нага через ~5 сек. (%s)",
	WarnShield			= "Щит %d/4 уменьшен",
	WarnLoot			= "Порченая магма на >%s<",
	SpecWarnElemental	= "Нечистый элементаль - переключитесь!"
}

L:SetTimerLocalization{
	TimerElementalActive	= "Активный элементаль",
	TimerElemental		= "Восстановление элементаля (%d)",
	TimerStrider		= "Следующий Долгоног (%d)",
	TimerNaga			= "Следующая Нага (%d)"
}

L:SetOptionLocalization{
	WarnElemental		= "Заранее предупреждать о следующем Нечистом элементале",
	WarnStrider			= "Заранее предупреждать о следующем Долгоноге",
	WarnNaga			= "Заранее предупреждать о следующей Наге",
	WarnShield			= "Показывать предупреждение об отключении щита на 2-й фазе",
	WarnLoot			= "Показывать предупреждение о добыче Порченой магмы",
	TimerElementalActive	= "Отсчёт времени, в течение которого активен Нечистый элементаль",
	TimerElemental		= "Отсчёт времени до восстановления Нечистого элементаля",
	TimerStrider		= "Отсчёт времени до следующего Долгонога",
	TimerNaga			= "Отсчёт времени до следующей Наги",
	SpecWarnElemental	= "Показывать спецпредупреждение при появлении Нечистого элементаля",
	ChargeIcon			= DBM_CORE_L.AUTO_ICONS_OPTION_TARGETS:format(38280),
	AutoChangeLootToFFA	= "Переключить режим добычи на 'Свободную для всех' на 2-й фазе"
}

L:SetMiscLocalization{
	DBM_VASHJ_YELL_PHASE2	= "Время пришло! Не щадите никого!",
	DBM_VASHJ_YELL_PHASE3	= "Вам не пора прятаться?",
	LootMsg			= "([^%s]+).*Hitem:(%d+)"
}

--Maulgar
L = DBM:GetModLocalization("Maulgar")

L:SetGeneralLocalization{
	name = "Король Молгар"
}


--Gruul the Dragonkiller
L = DBM:GetModLocalization("Gruul")

L:SetGeneralLocalization{
	name = "Груул Драконобой"
}

L:SetWarningLocalization{
	WarnGrowth	= "%s (%d)"
}

L:SetOptionLocalization{
	WarnGrowth		= "Показывать предупреждение для $spell:36300",
	RangeDistance	= "Фрейм дистанции для |cff71d5ff|Hspell:33654|hДробление|h|r",
	Smaller			= "Маленькая дистанция (11 м.)",
	Safe			= "Безопасная дистанция (18 м.)"
}

-- Magtheridon
L = DBM:GetModLocalization("Magtheridon")

L:SetGeneralLocalization{
	name = "Магтеридон"
}

L:SetTimerLocalization{
	timerP2	= "2-я фаза"
}

L:SetOptionLocalization{
	timerP2	= "Отсчёт времени до начала 2-й фазы"
}

L:SetMiscLocalization{
	DBM_MAG_EMOTE_PULL		= "%s начинает ослабевать!",
	DBM_MAG_YELL_PHASE2		= "Я... свободен!",
	DBM_MAG_YELL_PHASE3		= "Пусть стены темницы содрогнутся... и падут!"
}

--Attumen
L = DBM:GetModLocalization("Attumen")

L:SetGeneralLocalization{
	name = "Ловчий Аттумен"
}

L:SetMiscLocalization{
	DBM_ATH_YELL_1		= "Давай, Полночь, разгоним этот сброд!"
}


--Moroes
L = DBM:GetModLocalization("Moroes")

L:SetGeneralLocalization{
	name = "Мороуз"
}

L:SetWarningLocalization{
	DBM_MOROES_VANISH_FADED	= "Исчезновение рассеивается"
}

L:SetOptionLocalization{
	DBM_MOROES_VANISH_FADED	= "Показывать предупреждение об исчезновении"
}


-- Maiden of Virtue
L = DBM:GetModLocalization("Maiden")

L:SetGeneralLocalization{
	name = "Благочестивая дева"
}


-- Romulo and Julianne
L = DBM:GetModLocalization("RomuloAndJulianne")

L:SetGeneralLocalization{
	name = "Ромуло и Джулианна"
}

L:SetMiscLocalization{
	Event				= "Tonight... we explore a tale of forbidden love!",
	RJ_Pull				= "Что ты за дьявол, что меня так мучишь?",
	DBM_RJ_PHASE2_YELL	= "Ночь, добрая и строгая, приди! Верни мне моего Ромуло!",
	Romulo				= "Ромуло",
	Julianne			= "Джулианна"
}


-- Big Bad Wolf
L = DBM:GetModLocalization("BigBadWolf")

L:SetGeneralLocalization{
	name = "Злой и страшный серый волк"
}

L:SetMiscLocalization{
	DBM_BBW_YELL_1			= "Кем бы мне тут закусить?"
}

-- Wizard of Oz
L = DBM:GetModLocalization("Oz")

L:SetGeneralLocalization{
	name = "Волшебник из страны Оз"
}

L:SetWarningLocalization{
	DBM_OZ_WARN_TITO		= "Тито",
	DBM_OZ_WARN_ROAR		= "Хохотун",
	DBM_OZ_WARN_STRAWMAN	= "Балбес",
	DBM_OZ_WARN_TINHEAD		= "Медноголовый",
	DBM_OZ_WARN_CRONE		= "Ведьма"
}

L:SetTimerLocalization{
	DBM_OZ_WARN_TITO		= "Тито",
	DBM_OZ_WARN_ROAR		= "Хохотун",
	DBM_OZ_WARN_STRAWMAN	= "Балбес",
	DBM_OZ_WARN_TINHEAD		= "Медноголовый"
}

L:SetOptionLocalization{
	AnnounceBosses			= "Показывать предупреждение о появлении боссов",
	ShowBossTimers			= "Показывать таймеры появления боссов"
}

L:SetMiscLocalization{
	DBM_OZ_YELL_DOROTHEE	= "Тито, мы просто обязаны найти дорогу домой! Старый волшебник – наша единственная надежда. Пугало, Рычун, Нержавей, вы... ой, к нам кто-то пришел!",
	DBM_OZ_YELL_ROAR		= "Я вас не боюсь! Совсем! Хотите сражаться? Хотите, да? Ну же! Я буду драться, даже если мне свяжут лапы за спиной!",
	DBM_OZ_YELL_STRAWMAN	= "И что же мне с вами делать? Никак не соображу.",
	DBM_OZ_YELL_TINHEAD		= "Мне очень нужно сердце. Может, забрать твое?",
	DBM_OZ_YELL_CRONE		= "Горе вам, всем и каждому, мои крошки!"
}

-- Curator
L = DBM:GetModLocalization("Curator")

L:SetGeneralLocalization{
	name = "Смотритель"
}

L:SetWarningLocalization{
	warnAdd		= "Адд появился"
}

L:SetOptionLocalization{
	warnAdd		= "Показывать предупреждение при появлении адда"
}

-- Terestian Illhoof
L = DBM:GetModLocalization("TerestianIllhoof")

L:SetGeneralLocalization{
	name = "Терестиан Больное Копыто"
}

L:SetMiscLocalization{
	Kilrek					= "Кил'рек",
	DChains					= "Демонические цепи"
}


-- Shade of Aran
L = DBM:GetModLocalization("Aran")

L:SetGeneralLocalization{
	name = "Тень Арана"
}

L:SetWarningLocalization{
	DBM_ARAN_DO_NOT_MOVE	= "Венец пламени — Не двигайтесь!"
}

L:SetTimerLocalization{
	timerSpecial			= "Восст. спецспособности"
}

L:SetOptionLocalization{
	timerSpecial			= "Отсчёт времени до восстановления спецспособности",
	DBM_ARAN_DO_NOT_MOVE	= "Показывать спецпредупреждение для $spell:30004"
}


--Netherspite
L = DBM:GetModLocalization("Netherspite")

L:SetGeneralLocalization{
	name = "Гнев Пустоты"
}

L:SetWarningLocalization{
	warningPortal			= "Фаза порталов",
	warningBanish			= "Фаза изгнания"
}

L:SetTimerLocalization{
	timerPortalPhase	= "Фаза порталов заканчивается",
	timerBanishPhase	= "Фаза изгнания заканчивается"
}

L:SetOptionLocalization{
	warningPortal			= "Показывать предупреждение для фазы портала",
	warningBanish			= "Показывать предупреждение для фазы изгнания",
	timerPortalPhase		= "Показать таймер длительности фазы портала",
	timerBanishPhase		= "Показать таймер длительности фазы изгнания"
}

L:SetMiscLocalization{
	DBM_NS_EMOTE_PHASE_2	= "%s впадает в предельную ярость!",
	DBM_NS_EMOTE_PHASE_1	= "%s издает крик, отступая, открывая путь Пустоте."
}

--Chess
L = DBM:GetModLocalization("Chess")

L:SetGeneralLocalization{
	name = "Шахматное событие"
}

L:SetTimerLocalization{
	timerCheat	= "Восстановление жульничества"
}

L:SetOptionLocalization{
	timerCheat	= "Отсчёт времени до восстановления жульничества"
}

L:SetMiscLocalization{
	EchoCheats	= "Эхо Медива жульничает!"
}


--Prince Malchezaar
L = DBM:GetModLocalization("Prince")

L:SetGeneralLocalization{
	name = "Принц Малчезар"
}

L:SetMiscLocalization{
	DBM_PRINCE_YELL_P2		= "Глупцы! Время – это огонь, сжигающий вас!",
	DBM_PRINCE_YELL_P3		= "Как вы осмелились бросить вызов столь колоссальной мощи?",
	DBM_PRINCE_YELL_INF1	= "Мне открыты все реальности, все измерения!",
	DBM_PRINCE_YELL_INF2	= "Вы противостоите не только Малчезару, но и всем подвластным мне легионам!"
}


-- Nightbane
L = DBM:GetModLocalization("NightbaneRaid")

L:SetGeneralLocalization{
	name = "Ночная Погибель (Рейд)"
}

L:SetWarningLocalization{
	DBM_NB_AIR_WARN			= "Воздушная фаза"
}

L:SetTimerLocalization{
	timerAirPhase			= "Воздушная фаза"
}

L:SetOptionLocalization{
	DBM_NB_AIR_WARN			= "Показывать предупреждение для Воздушной фазы",
	timerAirPhase			= "Показывать таймер продолжительности Воздушной фазы"
}

L:SetMiscLocalization{
	DBM_NB_EMOTE_PULL		= "Древнее существо пробуждается вдалеке...",
	DBM_NB_YELL_AIR			= "Жалкие букашки! Я изжарю вас с воздуха!",
	DBM_NB_YELL_GROUND		= "Довольно! Я сойду на землю и сам раздавлю тебя!",
	DBM_NB_YELL_GROUND2		= "Ничтожества! Я вам покажу мою силу поближе!"
}

-- Named Beasts
L = DBM:GetModLocalization("Shadikith")

L:SetGeneralLocalization{
	name = "Шадикит Скользящий"
}

L = DBM:GetModLocalization("Hyakiss")

L:SetGeneralLocalization{
	name = "Хиакисс Скрытень"
}

L = DBM:GetModLocalization("Rokad")

L:SetGeneralLocalization{
	name = "Рокад Опустошитель"
}

if WOW_PROJECT_ID == (WOW_PROJECT_MAINLINE or 1) then return end--Anything below here is only needed for classic wrath or classic bc

---------------
--  Nalorakk --
---------------
L = DBM:GetModLocalization("Nalorakk")

L:SetGeneralLocalization{
	name = "Налоракк"
}

L:SetWarningLocalization{
	WarnBear		= "Форма медведя",
	WarnBearSoon	= "Форма медведя через ~5 сек.",
	WarnNormal		= "Обычная форма",
	WarnNormalSoon	= "Обычная форма через ~5 сек."
}

L:SetTimerLocalization{
	TimerBear		= "Форма медведя",
	TimerNormal		= "Обычная форма"
}

L:SetOptionLocalization{
	WarnBear		= "Показывать предупреждение для формы медведя",
	WarnBearSoon	= "Заранее предупреждать о форме медведя",
	WarnNormal		= "Показывать предупреждение для обычной формы",
	WarnNormalSoon	= "Заранее предупреждать об обычной форме",
	TimerBear		= "Отсчёт времени до формы медведя",
	TimerNormal		= "Отсчёт времени до обычной формы"
}

L:SetMiscLocalization{
	YellBear 	= "Хотели разбудить во мне зверя? Вам это удалось.",
	YellNormal	= "С дороги!"
}

---------------
--  Akil'zon --
---------------
L = DBM:GetModLocalization("Akilzon")

L:SetGeneralLocalization{
	name = "Акил'зон"
}

---------------
--  Jan'alai --
---------------
L = DBM:GetModLocalization("Janalai")

L:SetGeneralLocalization{
	name = "Джан'алай"
}

L:SetMiscLocalization{
	YellBomb	= "Щас я вас сожгу!",
	YellAdds	= "Эй, хранители! Займитесь яйцами!"
}

--------------
--  Halazzi --
--------------
L = DBM:GetModLocalization("Halazzi")

L:SetGeneralLocalization{
	name = "Халаззи"
}

L:SetWarningLocalization{
	WarnSpirit	= "Фаза духа",
	WarnNormal	= "Обычная фаза"
}

L:SetOptionLocalization{
	WarnSpirit	= "Показывать предупреждение для фазы духа",
	WarnNormal	= "Показывать предупреждение для обычной фазы"
}

L:SetMiscLocalization{
	YellSpirit	= "Мы с моим духом уничтожим вас!",
	YellNormal	= "Дух мой, вернись ко мне!"
}

--------------------------
--  Hex Lord Malacrass --
--------------------------
L = DBM:GetModLocalization("Malacrass")

L:SetGeneralLocalization{
	name = "Повелитель проклятий Малакрасс"
}

L:SetMiscLocalization{
	YellPull	= "Тьма поглотит вас!"
}

--------------
--  Zul'jin --
--------------
L = DBM:GetModLocalization("ZulJin")

L:SetGeneralLocalization{
	name = "Зул'джин"
}

L:SetMiscLocalization{
	YellPhase2	= "Несколько новых трюков от брата-медведя.",
	YellPhase3	= "Вам никуда не спрятаться от орла!",
	YellPhase4	= "Познакомьтесь с моими новыми братьями: клык и коготь!",
	YellPhase5	= "Не нужно смотреть в небо, чтобы увидеть дракондора!"
}
