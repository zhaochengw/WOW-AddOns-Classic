if GetLocale() ~= "ruRU" then return end
local L

----------------
--  Argaloth  --
----------------
L= DBM:GetModLocalization(139)

-----------------
--  Occu'thar  --
-----------------
L= DBM:GetModLocalization(140)

----------------------------------
--  Alizabal, Mistress of Hate  --
----------------------------------
L= DBM:GetModLocalization(339)

L:SetTimerLocalization({
	TimerFirstSpecial		= "Первая спецспособность"
})

L:SetOptionLocalization({
	TimerFirstSpecial		= "Отсчет времени до первой спецспособности после $spell:105738<br/>Первая спецспособность случайная: $spell:105067 или $spell:104936"
})

-------------------------------
--  Dark Iron Golem Council  --
-------------------------------
L = DBM:GetModLocalization(169)

L:SetTimerLocalization({
	timerShadowConductorCast	= "Проводник тьмы",
	timerArcaneLockout			= "Волшебный уничтожитель",
	timerArcaneBlowbackCast		= "Чародейская обратная вспышка",
	timerNefAblity				= "Восст. баффа" --Ability Buff CD
})

L:SetOptionLocalization({
	timerShadowConductorCast	= "Отсчет времени до применения заклинания $spell:92048",
	timerArcaneLockout			= "Отсчет времени до блокировки $spell:79710",
	timerArcaneBlowbackCast		= "Отсчет времени до применения заклинания $spell:91879",
	timerNefAblity				= "Отсчет времени до восстановления баффа (героический режим)"
})

L:SetMiscLocalization({
	YellTargetLock				= "На МНЕ - Обрамляющие тени! Прочь от меня!"
})

--------------
--  Magmaw  --
--------------
L = DBM:GetModLocalization(170)

L:SetWarningLocalization({
	SpecWarnInferno	= "Появляется Пыляющее костяное создание! (~4 сек.)"
})

L:SetOptionLocalization({
	SpecWarnInferno	= "Предупреждать заранее о $spell:92154 (~4 сек.)"
})

L:SetMiscLocalization({
	Slump			= "%s внезапно падает, выставляя клешни!",
	HeadExposed		= "%s насаживается на пику, обнажая голову!",
	YellPhase2		= "Непостижимо! Вы, кажется, можете уничтожить моего лавового червяка! Пожалуй, я помогу ему."
})

-----------------
--  Atramedes  --
-----------------
L = DBM:GetModLocalization(171)

L:SetMiscLocalization({
	NefAdd					= "Атрамед, они вон там!",
	Airphase				= "Да, беги! С каждым шагом твое сердце бьется все быстрее. Эти громкие, оглушительные удары... Тебе некуда бежать!"
})

-----------------
--  Chimaeron  --
-----------------
L = DBM:GetModLocalization(172)

L:SetOptionLocalization({
	SetIconOnSlime	= DBM_CORE_L.AUTO_ICONS_OPTION_TARGETS:format(82935),
	InfoFrame		= "Показывать инфофрейм со здоровьем (<10k здоровья)"
})

L:SetMiscLocalization({
	HealthInfo	= "Здоровье"
})

----------------
--  Maloriak  --
----------------
L = DBM:GetModLocalization(173)

L:SetWarningLocalization({
	WarnPhase			= "%s фаза"
})

L:SetTimerLocalization({
	TimerPhase			= "Следующая фаза"
})

L:SetOptionLocalization({
	WarnPhase			= "Показывать предупреждение о смене фаз",
	SetTextures			= "Автоматически отключить \"Проецирование текстур\" в темной фазе<br/>(включается обратно при выходе из фазы)"
})

L:SetMiscLocalization({
	YellRed				= "красный|r пузырек в котел!",--Partial matchs, no need for full strings unless you really want em, mod checks for both.
	YellBlue			= "синий|r пузырек в котел!",
	YellGreen			= "зеленый|r пузырек в котел!",
	YellDark			= "магию на котле!"
})

----------------
--  Nefarian  --
----------------
L = DBM:GetModLocalization(174)

L:SetWarningLocalization({
	warnShadowblazeSoon		= "%s"
})

L:SetTimerLocalization({
	timerNefLanding		= "Приземление Нефариана"
})

L:SetOptionLocalization({
	warnShadowblazeSoon	= "Заранее показывать обратный отсчет времени до $spell:81031 (за 5 секунд до каста)<br/>(Отсчет пойдет только после первой синхронизации таймера с эмоцией босса для обеспечения точности)",
	timerNefLanding		= "Отсчет времени до приземления Нефариана",
	SetWater			= "Автоматически отключать настройку Брызги воды<br/>(Включается обратно при выходе из боя)"
})

L:SetMiscLocalization({
	NefAoe				= "В воздухе трещат электрические разряды!",
	YellPhase2			= "Дерзкие смертные! Неуважение к чужой собственности нужно пресекать самым жестоким образом!",
	YellPhase3			= "Я пытался следовать законам гостеприимства, но вы всё никак не умрете! Придется отбросить условности и просто... УБИТЬ ВАС ВСЕХ!",
	YellShadowBlaze		= "И плоть превратится в прах!",
	ShadowBlazeExact		= "Вспышка пламени тени через %d"
})

-------------------------------
--  Blackwing Descent Trash  --
-------------------------------
L = DBM:GetModLocalization("BWDTrash")

L:SetGeneralLocalization({
	name = "Трэш мобы Твердыни Крыла Тьмы"
})

--------------------------
--  Halfus Wyrmbreaker  --
--------------------------
L= DBM:GetModLocalization(156)


---------------------------
--  Valiona & Theralion  --
---------------------------
L= DBM:GetModLocalization(157)

L:SetOptionLocalization({
	TBwarnWhileBlackout		= "Показывать предупреждение о $spell:86369, когда активно $spell:86788",
	BlackoutShieldFrame		= "Показывать здоровье босса с помощью шкалы здоровья для $spell:86788"
})

L:SetMiscLocalization({
	Trigger1				= "Глубокий вдох",
	BlackoutTarget			= "Затмение: %s"
})

----------------------------------
--  Twilight Ascendant Council  --
----------------------------------
L= DBM:GetModLocalization(158)

L:SetWarningLocalization({
	specWarnBossLow			= "%s ниже 30%% - скоро следующая фаза!",
	SpecWarnGrounded		= "Получите ауру заземления!",
	SpecWarnSearingWinds	= "Получите ауру кружащихся ветров!"
})

L:SetTimerLocalization({
	timerTransition			= "Смена фаз"
})

L:SetOptionLocalization({
	specWarnBossLow			= "Показывать спецпредупреждение, когда здоровье боссов опускается до 30%",
	SpecWarnGrounded		= "Показывать спецпредупреждение, когда у Вас не хватает ауры $spell:83581<br/>(~10сек перед началом применения)",
	SpecWarnSearingWinds	= "Показывать спецпредупреждение, когда у Вас не хватает ауры $spell:83500<br/>(~10сек перед началом применения)",
	timerTransition			= "Отсчет времени до перехода в другую фазу",
	yellScrewed				= "Кричать, когда на Вас одновременно $spell:83099 и $spell:92307"
})

L:SetMiscLocalization({
	Quake					= "Земля уходит у вас из-под ног...",
	Thundershock			= "Воздух потрескивает от скопившейся энергии...",
	Switch					= "Закончим этот фарс!",--"We will handle them!" comes 3 seconds after this one
	Phase3					= "Ваше упорство...",--"BEHOLD YOUR DOOM!" is about 13 seconds after
	Kill					= "Невозможно....",
	blizzHatesMe			= "Сфера и громотвод на МНЕ! С ДОРОГИ!!!",
	WrongDebuff				= "Отсутствует %s"
})

----------------
--  Cho'gall  --
----------------
L= DBM:GetModLocalization(167)

----------------
--  Sinestra  --
----------------
L= DBM:GetModLocalization(168)

L:SetWarningLocalization({
	WarnOrbSoon			= "Сферы через %d сек!",
	SpecWarnOrbs		= "Скоро появятся сферы!",
	warnWrackJump		= "%s прыгнуло на >%s<",
	warnAggro			= "На >%s< АГРО (возможные цели сфер)",
	SpecWarnAggroOnYou	= "На Вас АГРО! Смотрите за сферами!"
})

L:SetTimerLocalization({
	TimerEggWeakening	= "Снятие защиты с яиц",
	TimerEggWeaken		= "Восст. Сумеречного панциря",
	TimerOrbs			= "Восст. Сферы Тьмы"
})

L:SetOptionLocalization({
	WarnOrbSoon			= "Показывать предупреждение о появлении сфер (за 5с до начала, каждую 1с)<br/>Предупреждение может быть неточным. Может быть спамом.",
	warnWrackJump		= "Показывать цели, на которые прыгает $spell:92955",
	warnAggro			= "Показывать игроков, имеющих агро от сфер<br/>Может быть целью сфер",
	SpecWarnAggroOnYou	= "Показывать спецпредупреждение, если на Вас есть агро при появлении сфер<br/>Может быть целью сфер",
	SpecWarnOrbs		= "Показывать спецпредупреждение при появлении сфер<br/>Предупреждение может быть неточным",
	TimerEggWeakening	= "Отсчет времени до снятия $spell:87654",
	TimerEggWeaken		= "Отсчет времени до восстановления $spell:87654",
	TimerOrbs			= "Отсчет времени до следующих сфер<br/>Таймер может быть неточным",
	SetIconOnOrbs		= "Устанавливать метки на игроков, имеющих агро от сфер<br/>Может быть целью сфер",
	InfoFrame			= "Показывать список игроков, имеющих агро"
})

L:SetMiscLocalization({
	YellDragon			= "Ешьте, дети мои! Пусть их мясо насытит вас!",
	YellEgg				= "Ты так в этом уверен? Глупец!",
	HasAggro			= "Имеют агро"
})

-------------------------------------
--  The Bastion of Twilight Trash  --
-------------------------------------
L = DBM:GetModLocalization("BoTrash")

L:SetGeneralLocalization({
	name =	"Трэш мобы Сумеречный бастион"
})

------------------------
--  Conclave of Wind  --
------------------------
L = DBM:GetModLocalization(154)

L:SetWarningLocalization({
	warnSpecial			= "Активация Урагана/Зефира/Ледяного дождя",
	specWarnSpecial		= "Активация особой способности!",
	warnSpecialSoon		= "Особые способности через 10 сек!"
})

L:SetTimerLocalization({
	timerSpecial		= "Перезарядка спецспособности",
	timerSpecialActive	= "Активация спецспособности"
})

L:SetOptionLocalization({
	warnSpecial			= "Показывать предупреждение при применении $spell:84638, $spell:84643 и $spell:84644",
	specWarnSpecial		= "Показывать спецпредупреждение о применении спецспособностей",
	timerSpecial		= "Отсчет времени до восстановления спецспособностей",
	timerSpecialActive	= "Отсчет времени действия спецспособностей",
	warnSpecialSoon		= "Показывать предупреждение за 10 секунд до применения особых способностей",
	OnlyWarnforMyTarget	= "Показывать только таймеры/предупреждения для текущей цели и фокуса<br/>(Скрывает все остальное. ЭТО ВКЛЮЧАЕТ В СЕБЯ ПУЛЛ)"
})

L:SetMiscLocalization({
	gatherstrength		= "близок к обретению абсолютной силы!"
})

---------------
--  Al'Akir  --
---------------
L = DBM:GetModLocalization(155)

L:SetTimerLocalization({
	TimerFeedback 	= "Ответная реакция (%d)"
})

L:SetOptionLocalization({
	LightningRodIcon= DBM_CORE_L.AUTO_ICONS_OPTION_TARGETS:format(89668),
	TimerFeedback	= "Отсчет времени длительности $spell:87904"
})

-----------------
-- Beth'tilac --
-----------------
L= DBM:GetModLocalization(192)

L:SetMiscLocalization({
	EmoteSpiderlings 	= "Сверху свисают пеплопряды-ткачи!"
})

-------------------
-- Lord Rhyolith --
-------------------
L= DBM:GetModLocalization(193)

---------------
-- Alysrazor --
---------------
L= DBM:GetModLocalization(194)

L:SetWarningLocalization({
	WarnPhase			= "Фаза %d",
	WarnNewInitiate		= "Друид (%s)"
})

L:SetTimerLocalization({
	TimerPhaseChange	= "Фаза %d",
	TimerHatchEggs		= "Яйца",
	timerNextInitiate	= "Друид (%s)"
})

L:SetOptionLocalization({
	WarnPhase			= "Показывать предупреждение о смене фаз",
	WarnNewInitiate		= "Показывать предупреждение о появлении нового друида-огнеястреба",
	timerNextInitiate	= "Отсчет времени до появления нового друида-огнеястреба",
	TimerPhaseChange	= "Отсчет времени до следующей фазы",
	TimerHatchEggs		= "Отсчет времени до вылупления яиц"
})

L:SetMiscLocalization({
	YellPull			= "Теперь я служу новому господину, смертные!",
	YellPhase2			= "Небо над вами принадлежит МНЕ!",
	LavaWorms			= "На поверхность вылезают огненные лавовые паразиты!",
	East				= "на востоке",
	West				= "на западе",
	Both				= "обе стороны"
})

-------------
-- Shannox --
-------------
L= DBM:GetModLocalization(195)

-------------
-- Baleroc --
-------------
L= DBM:GetModLocalization(196)

L:SetWarningLocalization({
	warnStrike	= "%s (%d)"
})

L:SetTimerLocalization({
	timerStrike			= "След. %s",
	TimerBladeActive	= "%s",
	TimerBladeNext		= "Следующее лезвие"
})

L:SetOptionLocalization({
	ResetShardsinThrees	= "Отсчитывать количество $spell:99259 в группах по 3 сек.(25 м.) и 2 сек.(10 м.)",
	warnStrike			= "Показывать предупреждение для $spell:387176 и $spell:143962",
	timerStrike			= "Отсчет времени до следующих $spell:387176 и $spell:143962",
	TimerBladeActive	= "Отсчет времени длительности активного лезвия",
	TimerBladeNext		= "Отсчет времени до следующих $spell:387176 и $spell:99350"
})

--------------------------------
-- Majordomo Fandral Staghelm --
--------------------------------
L= DBM:GetModLocalization(197)

L:SetTimerLocalization({
	timerNextSpecial		= "След. %s (%d)"
})

L:SetOptionLocalization({
	timerNextSpecial		= "Отсчет времени до следующей спецспособности"
})

--------------
-- Ragnaros --
--------------
L= DBM:GetModLocalization(198)

L:SetWarningLocalization({
	warnRageRagnarosSoon	= "%s на %s через 5 сек.",--Spellname on targetname
	warnSplittingBlow		= "%s через %s",--Spellname in Location
	warnEngulfingFlame		= "%s через %s",--Spellname in Location
	warnEmpoweredSulf		= "%s через 5 сек."--The spell has a 5 second channel, but tooltip doesn't reflect it so cannot auto localize
})

L:SetTimerLocalization({
	timerRageRagnaros	= "%s на %s",
	TimerPhaseSons		= "Окончание переходной фазы"
})

L:SetOptionLocalization({
	warnRageRagnarosSoon		= DBM_CORE_L.AUTO_ANNOUNCE_OPTIONS.prewarn:format(101109),
	warnSplittingBlow			= "Показывать предупреждение для $spell:98951",
	warnEngulfingFlame			= "Показывать предупреждение для $spell:99171 (обычный режим)",
	WarnEngulfingFlameHeroic	= "Показывать предупреждение о появлении $spell:99171 (героический режим)",
	warnSeedsLand				= "Показывать предупреждение/таймер до появления $spell:98520, а не до их появления в воздухе",
	warnEmpoweredSulf			= DBM_CORE_L.AUTO_ANNOUNCE_OPTIONS.cast:format(100604),
	timerRageRagnaros			= DBM_CORE_L.AUTO_TIMER_OPTIONS.cast:format(101109),
	TimerPhaseSons				= "Отсчет времени до окончания \"фазы Сыновей пламени\"",
	InfoHealthFrame				= "Показывать инфофрейм для игроков с низким уровнем здоровья (<100k)",
	MeteorFrame					= "Показывать инфофрейм для целей $spell:99849",
	AggroFrame					= "Показывать инфофрейм для игроков, не имеющих аггро от $journal:2647"
})

L:SetMiscLocalization({
	East				= "на востоке",
	West				= "на западе",
	Middle				= "в центре",
	North				= "в мили",
	South				= "сзади",
	HealthInfo			= "Уровень здоровья <100k",
	HasNoAggro			= "Без аггро",
	MeteorTargets		= "ОМФГ Метеоры!",--Keep rollin' rollin' rollin' rollin'.
	TransitionEnded1	= "Довольно! Пора покончить с этим.",
	TransitionEnded2	= "Сульфурас уничтожит вас!",
	TransitionEnded3	= "На колени, смертные!",
	Defeat				= "Слишком рано!.. Вы пришли слишком рано...",
	Phase4				= "Слишком рано..."
})

-----------------------
--  Firelands Trash  --
-----------------------
L = DBM:GetModLocalization("FirelandsTrash")

L:SetGeneralLocalization({
	name = "Трэш мобы Огненные Просторы"
})

----------------
--  Volcanus  --
----------------
L = DBM:GetModLocalization("Volcanus")

L:SetGeneralLocalization({
	name = "Вулканий"
})

L:SetTimerLocalization({
	timerStaffTransition	= "Переходная фаза заканчивается"
})

L:SetOptionLocalization({
	timerStaffTransition	= "Отсчет времени до переходной фазы"
})

L:SetMiscLocalization({
	StaffEvent				= "Ветвь Нордрассила яростно реагирует на прикосновение %S+",--Reg expression pull match
	StaffTrees				= "Из-под земли появляются пылающие древни, чтобы помощь защитнику!",--Might add a spec warning for this later.
	StaffTransition			= "Пламя, пожирающее измученного заступника, меркнет."
})

-----------------------
--  Nexus Legendary  --
-----------------------
L = DBM:GetModLocalization("NexusLegendary")

L:SetGeneralLocalization({
	name = "Тиринар"
})

-------------
-- Morchok --
-------------
L= DBM:GetModLocalization(311)

L:SetWarningLocalization({
	KohcromWarning	= "%s: %s"
})

L:SetTimerLocalization({
	KohcromCD		= "Кохром повторяет %s"
})

L:SetOptionLocalization({
	KohcromWarning	= "Показывать предупреждение для $journal:4262, имитирующих способности",
	KohcromCD		= "Отсчет времени до следующей имитации способности $journal:4262"
})

L:SetMiscLocalization({
})

---------------------
-- Warlord Zon'ozz --
---------------------
L= DBM:GetModLocalization(324)

L:SetOptionLocalization({
	ShadowYell			= "Кричать, когда на Вас $spell:103434<br/>(героический режим)",
})

L:SetMiscLocalization({
	voidYell	= "Гул'каф ан'ков Н'Зот."--Перевод крика, который босс издает для заклинания 'Сфера рассоздания'. Последние логи от DS указывают на то, что Blizzard удалили событие, которое обнаруживало заклинания.
})

-----------------------------
-- Yor'sahj the Unsleeping --
-----------------------------
L= DBM:GetModLocalization(325)

L:SetWarningLocalization({
	warnOozesHit	= "%s поглотил %s"
})

L:SetTimerLocalization({
	timerOozesActive	= "Капли, доступные для атаки",
	timerOozesReach		= "Капли достигли босса"
})

L:SetOptionLocalization({
	warnOozesHit		= "Показывать предупреждение для каплей, которые достигли босса",
	timerOozesActive	= "Отсчет времени до того момента, когда капли становятся доступными для атаки",
	timerOozesReach		= "Отсчет времени до того момента, когда капли достигнут Йор'саджа",
})

L:SetMiscLocalization({
	Black			= "|cFF424242черная|r",
	Purple			= "|cFF9932CDтеневая|r",
	Red				= "|cFFFF0404алая|r",
	Green			= "|cFF088A08кислотная|r",
	Blue			= "|cFF0080FFкобальтовая|r",
	Yellow			= "|cFFFFA901светящаяся|r"
})

-----------------------
-- Hagara the Binder --
-----------------------
L= DBM:GetModLocalization(317)

L:SetWarningLocalization({
	WarnPillars				= "%s: осталось %d",
	warnFrostTombCast		= "%s через 8 сек."
})

L:SetTimerLocalization({
	TimerSpecial			= "Первая спецспособность"
})

L:SetOptionLocalization({
	WarnPillars				= "Объявлять, сколько осталось $journal:3919 или $journal:4069",
	TimerSpecial			= "Отсчет времени до первой спецспособности",
	warnFrostTombCast		= DBM_CORE_L.AUTO_ANNOUNCE_OPTIONS.cast:format(104448),
	SetIconOnFrostTomb		= DBM_CORE_L.AUTO_ICONS_OPTION_TARGETS:format(104451),
	SetIconOnFrostflake		= DBM_CORE_L.AUTO_ICONS_OPTION_TARGETS:format(109325),
	SpecialCount			= "Звуковой отсчет для $spell:105256 или $spell:105465",
	SetBubbles				= "Автоматически отключать сообщения в облачках, когда $spell:104451 доступен<br/>(восстанавливает их после окончания боя)"
})

L:SetMiscLocalization({
	TombIconSet				= "Значок Ледяной метки {rt%d} установлен на %s"
})

---------------
-- Ultraxion --
---------------
L= DBM:GetModLocalization(331)

L:SetWarningLocalization({
	specWarnHourofTwilightN		= "%s (%d) через 5 сек."
})

L:SetTimerLocalization({
	TimerCombatStart	= "Ультраксион приземляется"
})

L:SetOptionLocalization({
	TimerCombatStart	= "Отсчет времени до приземления Ультраксиона",
	ResetHoTCounter		= "Сброс счетчика \"Время сумерек\"",--$spell doesn't work in this function apparently so use typed spellname for now.
	Never				= "Никогда",
	ResetDynamic		= "Сброс на 3/2 (гер./обыч.)",
	Reset3Always		= "Сброс всегда на 3",
	SpecWarnHoTN		= "Показывать спецпредупреждение за 5 сек. до \"Время сумерек\". Если сброс счетчика \"Никогда\", используется правило на 3",
	One					= "1 (т.е. 1 4 7)",
	Two					= "2 (т.е. 2 5)",
	Three				= "3 (т.е. 3 6)"
})

L:SetMiscLocalization({
	Pull				= "Я чувствую приближение Хаоса... Мой разум не в силах этого выдержать!"
})

-------------------------
-- Warmaster Blackhorn --
-------------------------
L= DBM:GetModLocalization(332)

L:SetWarningLocalization({
	SpecWarnElites	= "Элитные сумеречные бойцы!"
})

L:SetTimerLocalization({
	TimerAdd			= "След. Адды"
})

L:SetOptionLocalization({
	TimerAdd			= "Отсчет времени до появления следующих Элитных сумеречных бойцов",
	SpecWarnElites		= "Показывать спецпредупреждение для новых Элитных сумеречных бойцов",
	SetTextures			= "Автоматически отключать проэцирование текстур на 1-й фазе<br/>(возвращает в исходное состояние на 2 фазе)"
})

L:SetMiscLocalization({
	Pull				= "Быстрее! Полный вперед! Мы не должны упустить его!",
	SapperEmote			= "Дракон пикирует на палубу, чтобы сбросить на нее сумеречного сапера!",
	GorionaRetreat			= "издает полный боли визг и скрывается в клубящихся вокруг облаках."
})

-------------------------
-- Spine of Deathwing  --
-------------------------
L= DBM:GetModLocalization(318)

L:SetWarningLocalization({
	warnSealArmor			= "%s",
	SpecWarnTendril			= "Закрепитесь!"
})

L:SetOptionLocalization({
	warnSealArmor			= DBM_CORE_L.AUTO_ANNOUNCE_OPTIONS.cast:format(105847),
	SpecWarnTendril			= "Показывать спецпредупреждение, когда на Вас нет дебаффа $spell:105563",
	InfoFrame				= "Показывать инфофрейм для игроков без $spell:105563",
	SetIconOnGrip			= DBM_CORE_L.AUTO_ICONS_OPTION_TARGETS:format(105490),
	ShowShieldInfo			= "Показывать полосы здоровья для исцеления $spell:105479<br/>(Игнорирует параметр рамки здоровья босса)"
})

L:SetMiscLocalization({
	Pull			= "Смотрите, он разваливается! Оторвите пластины, и у нас появится шанс сбить его!",
	NoDebuff		= "Нет %s",
	PlasmaTarget	= "Жгучая плазма: %s",
	DRoll			= "собирается накрениться",
	DLevels			= "выравнивается"
})

---------------------------
-- Madness of Deathwing  --
---------------------------
L= DBM:GetModLocalization(333)

L:SetOptionLocalization({
	SetIconOnParasite	= DBM_CORE_L.AUTO_ICONS_OPTION_TARGETS:format(108649)
})

L:SetMiscLocalization({
	Pull				= "У вас НИЧЕГО не вышло. Я РАЗОРВУ ваш мир на куски."
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("DSTrash")

L:SetGeneralLocalization({
	name =	"Трэш мобы Душа Дракона"
})

L:SetWarningLocalization({
	DrakesLeft			= "Осталось Сумеречных агрессоров: %d"
})

L:SetTimerLocalization({
	timerRoleplay		= GUILD_INTEREST_RP,
	TimerDrakes			= "%s"
})

L:SetOptionLocalization({
	DrakesLeft			= "Показывать предупреждение для оставшихся Сумеречных агрессоров",
	TimerDrakes			= "Отсчет времени до применения $spell:109904 Сумеречными агрессорами"
})

L:SetMiscLocalization({
	firstRP				= "Хвала Титанам, они вернулись!",
	UltraxionTrash		= "Рад встрече, Алекстраза. Скоро ты увидишь, над чем я трудился.",
	UltraxionTrashEnded = "Детеныши, эксперименты, шаги к будущему величию. Вы увидите, чего я добился."
})
