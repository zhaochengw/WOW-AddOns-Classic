-- Translated by StingerSoft
if GetLocale() ~= "ruRU" then return end

local media = LibStub("LibSharedMedia-3.0")

--Event and Damage option values
SCT.LOCALS.OPTION_EVENT1 = {name = "Урон", tooltipText = "Вкл/Выкл ближний урон и глобальный. (огонь, падения, и т.д...) урон"};
SCT.LOCALS.OPTION_EVENT2 = {name = "Промахи", tooltipText = "Вкл/Выкл отображение промахов"};
SCT.LOCALS.OPTION_EVENT3 = {name = "Уклонение", tooltipText = "Вкл/Выкл отображение уклонений"};
SCT.LOCALS.OPTION_EVENT4 = {name = "Парирование", tooltipText = "Вкл/Выкл отображение парирований"};
SCT.LOCALS.OPTION_EVENT5 = {name = "Блоки", tooltipText = "Вкл/Выкл отображение блоков"};
SCT.LOCALS.OPTION_EVENT6 = {name = "Заклинания", tooltipText = "Вкл/Выкл урон заклинаний"};
SCT.LOCALS.OPTION_EVENT7 = {name = "Лечение", tooltipText = "Вкл/Выкл исциления"};
SCT.LOCALS.OPTION_EVENT8 = {name = "Сопрот.", tooltipText = "Вкл/Выкл сопротивления магии"};
SCT.LOCALS.OPTION_EVENT9 = {name = "Дебаффы", tooltipText = "Вкл/Выкл отображение о получении отрицательного эффекта"};
SCT.LOCALS.OPTION_EVENT10 = {name = "Поглот/Разное", tooltipText = "Вкл/Выкл отображения поглощений, отражений, невосприимчивости, и т.д..."};
SCT.LOCALS.OPTION_EVENT11 = {name = "Мало здоровья", tooltipText = "Вкл/Выкл оповещение о низком уровне вашего здоровья"};
SCT.LOCALS.OPTION_EVENT12 = {name = "Мало маны", tooltipText = "Вкл/Выкл оповещение о низком уровне вашей маны"};
SCT.LOCALS.OPTION_EVENT13 = {name = "Получение энергии", tooltipText = "Вкл/Выкл оповещение о получении маны, ярости, энергии с зельев, предметов, положительных эффектов, и т.д...(Не регулярное востоновление)"};
SCT.LOCALS.OPTION_EVENT14 = {name = "Бой", tooltipText = "Вкл/Выкл оповещение о входе/выходе из боя"};
SCT.LOCALS.OPTION_EVENT15 = {name = "Приёмы в серии", tooltipText = "Вкл/Выкл оповещение о получении приёмов к серии"};
SCT.LOCALS.OPTION_EVENT16 = {name = "Получение чести", tooltipText = "Вкл/Выкл оповещение о получении очков чести"};
SCT.LOCALS.OPTION_EVENT17 = {name = "Баффы", tooltipText = "Вкл/Выкл оповещение о получении положительного эффекта"};
SCT.LOCALS.OPTION_EVENT18 = {name = "Спад баффа", tooltipText = "Вкл/Выкл оповещение о истечении положительного/отрицательного эффекта. Используя цвета положительного/отрицательного эффекта."};
SCT.LOCALS.OPTION_EVENT19 = {name = "Активация способ.", tooltipText = "Вкл/Выкл оповещение о активации способностей (Казнь, Укус мангуста, Молот гнева, и т.д...)"};
SCT.LOCALS.OPTION_EVENT20 = {name = "Репутация", tooltipText = "Вкл/Выкл оповещение о улучшении/ухедшении отношения с фракциями"};
SCT.LOCALS.OPTION_EVENT21 = {name = "Ваше исцеление", tooltipText = "Вкл/Выкл отображение на сколько вы исцелили кого"};
SCT.LOCALS.OPTION_EVENT22 = {name = "Навыки", tooltipText = "Вкл/Выкл оповещение о получении очков навыка"};
SCT.LOCALS.OPTION_EVENT23 = {name = "Решающие удары", tooltipText = "Вкл/Выкл оповещение о решающем ударе"};
SCT.LOCALS.OPTION_EVENT24 = {name = "Прерывания", tooltipText = "Вкл/Выкл оповещение о прерываниях"};
SCT.LOCALS.OPTION_EVENT25 = {name = "Рассеяния", tooltipText = "Вкл/Выкл оповещение рессеяниваний"};
SCT.LOCALS.OPTION_EVENT26 = {name = "Руны", tooltipText = "Вкл/Выкл оповещение о готовности рун"};

--Check Button option values
SCT.LOCALS.OPTION_CHECK1 = { name = "Включить SCT", tooltipText = "Вкл/Выкл Scrolling Combat Text"};
SCT.LOCALS.OPTION_CHECK2 = { name = "Помечать текст боя", tooltipText = "Вкл/Выкл отображение * по бокам всего выводимого текста Scrolling Combat Text"};
SCT.LOCALS.OPTION_CHECK3 = { name = "Имя лекаря", tooltipText = "Вкл/Выкл оповещение о том кто или что вас исцелило."};
SCT.LOCALS.OPTION_CHECK4 = { name = "Прокрутка вниз", tooltipText = "Вкл/Выкл прокрутку текста вниз"};
SCT.LOCALS.OPTION_CHECK5 = { name = "Фикс. криты", tooltipText = "Вкл/Выкл при получении критического удара/исцеления Фиксировать не некоторое время его значение над головой персонажа"};
SCT.LOCALS.OPTION_CHECK6 = { name = "Тип урона заклинания", tooltipText = "Вкл/Выкл отображение типа урона заклинаний (т.е. огонь, лёд и т.д...)"};
SCT.LOCALS.OPTION_CHECK7 = { name = "Применить шрифт к урону", tooltipText = "Enables or Disables changing the in game damage font to match the font used for SCT Text.\n\nIMPORTANT: YOU MUST LOG OUT AND BACK IN FOR THIS TO TAKE EFFECT. RELOADING THE UI WON'T WORK"};
SCT.LOCALS.OPTION_CHECK8 = { name = "Получение любой энергии", tooltipText = "Вкл/Выкл отображение всей получаемой энергии, не только тех что в журнале чата\n\nПРИМИЧАНИЕ: This is dependent on the regular Power Gain event being on, is VERY SPAMMY, and sometimes acts strange for Druids just after shapeshifting back to caster form."};
SCT.LOCALS.OPTION_CHECK10 = { name = "Пере-исцеление", tooltipText = "Enables or Disables showing how much you overheal for against you or your targets. Dependent on 'Your Heals' being on."};
SCT.LOCALS.OPTION_CHECK11 = { name = "Звук тревоги", tooltipText = "Вкл/Выкл проигрывания звуков для предупреждения."};
SCT.LOCALS.OPTION_CHECK12 = { name = "Цвета заклинаний", tooltipText = "Вкл/Выкл отображение урона заклинаний в цветах, установленных для каждого типа заклинаний"};
SCT.LOCALS.OPTION_CHECK13 = { name = "Включить свои события", tooltipText = "Вкл/Выкл использование пользовательских событий. Когда отключено, SCT потребляет гораздо меньше памяти.."};
SCT.LOCALS.OPTION_CHECK14 = { name = "Название спос-сти/закл-ия", tooltipText = "Вкл/Выкл отображение названия способности или заклинания, которое вам ненесло урон"};
SCT.LOCALS.OPTION_CHECK15 = { name = "Мигание", tooltipText = "Делает фиксированные криты 'мигающими' into view."};
SCT.LOCALS.OPTION_CHECK16 = { name = "Скольжение/Сокрушение", tooltipText = "Вкл/Выкл отображение Скользящие ~150~ и Сокрушительные ^150^ удары"};
SCT.LOCALS.OPTION_CHECK17 = { name = "Ваши ИзВ", tooltipText = "Вкл/Выкл отображение ваших применённых исцелений за время на других. Note: this can be very spammy if you cast a lot of them."};
SCT.LOCALS.OPTION_CHECK18 = { name = "Heals at Nameplates", tooltipText = "Enables or Disables attempting to show your heals over the nameplate of the person(s) you heal.\n\nFriendly nameplates must be on, you must be able to see the nameplate, and it will not work 100% of the time. If it does not work, heals appear in the normal configured position.\n\nDisabling can require a reloadUI to take effect."};
SCT.LOCALS.OPTION_CHECK19 = { name = "Отключить исцеления WoW", tooltipText = "Вкл/Выкл отображение встроенного игрового текста исцеления, добавленного в обновлении 2.1."};
SCT.LOCALS.OPTION_CHECK20 = { name = "Иконка заклинания", tooltipText = "Вкл/Выкл отображение иконок заклинаний или способностей"};
SCT.LOCALS.OPTION_CHECK21 = { name = "Иконки", tooltipText = "Вкл/Выкл отображение иконок заклинаний или способностей для пользовательских событий, если такие есть"};
SCT.LOCALS.OPTION_CHECK22 = { name = "Сделать критическим", tooltipText = "Сделать данное события всегда выводимым как критическое"};
SCT.LOCALS.OPTION_CHECK23 = { name = "Критический", tooltipText = "Событие будет критическим при срабатывании"};
SCT.LOCALS.OPTION_CHECK24 = { name = "Сопрот.", tooltipText = "Для вывода данного события должно произойти сопротивление чему либо"};
SCT.LOCALS.OPTION_CHECK25 = { name = "Блок", tooltipText = "Для вывода данного события должен произойти блок чего либо"};
SCT.LOCALS.OPTION_CHECK26 = { name = "Поглот.", tooltipText = "Для вывода данного события должно произойти поглощение чего либо"};
SCT.LOCALS.OPTION_CHECK27 = { name = "Скольжение", tooltipText = "Для вывода данного события должен произойти Скользящий удар"};
SCT.LOCALS.OPTION_CHECK28 = { name = "Сокрушение", tooltipText = "Для вывода данного события должен произойти Сокрушительный удар"};
SCT.LOCALS.OPTION_CHECK29 = { name = "Только свои дебаффы", tooltipText = "Будут выводиться только те событие в которых дебафф исходит от вас. Работает только для вашей цели."};


--Slider options values
SCT.LOCALS.OPTION_SLIDER1 = { name="Скорость анимации текста", minText="Быстрее", maxText="Медленнее", tooltipText = "Управление скоростью прокрутки анимации"};
SCT.LOCALS.OPTION_SLIDER2 = { name="Размер текста", minText="Меньше", maxText="Больше", tooltipText = "Управление размером прокручиваемого текста"};
SCT.LOCALS.OPTION_SLIDER3 = { name="ЗД %", minText="10%", maxText="90%", tooltipText = "Управление % требуемого здоровья для вывода предупреждения"};
SCT.LOCALS.OPTION_SLIDER4 = { name="Мана %",  minText="10%", maxText="90%", tooltipText = "Управление % требуемой маны для вывода предупреждения"};
SCT.LOCALS.OPTION_SLIDER5 = { name="Прозрачность текста", minText="0%", maxText="100%", tooltipText = "Настройка прозрачности текста"};
SCT.LOCALS.OPTION_SLIDER6 = { name="Расстояние движущегося текста", minText="Меньше", maxText="Больше", tooltipText = "Настройка расстояния между движущимся текстом"};
SCT.LOCALS.OPTION_SLIDER7 = { name="Смещение текста X от центра", minText="-600", maxText="600", tooltipText = "Настройка расположение центра текста"};
SCT.LOCALS.OPTION_SLIDER8 = { name="Смещение текста Y от центра", minText="-400", maxText="400", tooltipText = "Настройка расположение центра текста"};
SCT.LOCALS.OPTION_SLIDER9 = { name="Новости X смещение от центра", minText="-600", maxText="600", tooltipText = "Настройка расположение центра сообщений"};
SCT.LOCALS.OPTION_SLIDER10 = { name="Новости Y смещение от центра", minText="-400", maxText="400", tooltipText = "Настройка расположение центра сообщений"};
SCT.LOCALS.OPTION_SLIDER11 = { name="Скорость затухания сообщения", minText="Быстрее", maxText="Медленнее", tooltipText = "Настройка скорости затухания сообщения"};
SCT.LOCALS.OPTION_SLIDER12 = { name="Размер сообщения", minText="Меньше", maxText="Больше", tooltipText = "Настройка размера текста сообщения"};
SCT.LOCALS.OPTION_SLIDER13 = { name="Фильтр исциления", minText="0", maxText="500", tooltipText = "Настройка минимального значения исциления, привышая которое оно будет выводиться в SCT. Отличная фильтрация повторяющихся мелких исцилений таких как: Тотемы, Благословения, и т.д..."};
SCT.LOCALS.OPTION_SLIDER14 = { name="Фильтр маны", minText="0", maxText="500", tooltipText = "Настройка минимального значения получаемой энергии, привышая которое оно будет выводиться в SCT. Отличная фильтрация повторяющихся, мелких порций получаемой энергии таких как Тотемы, Благословения, и т.д..."};
SCT.LOCALS.OPTION_SLIDER15 = { name="Растояния промежутка в HUDе", minText="0", maxText="200", tooltipText = "Настройка растояния от центра для анимации HUDа. Полезно когда хотите сохранить всё центру, но настроить расстояние от центра"};
SCT.LOCALS.OPTION_SLIDER16 = { name="Размер сокращения заклинаний", minText="1", maxText="30", tooltipText = "Названия заклинаний длинее установленного значения будут сокращаться используя выбронныйт тип сокращений."};
SCT.LOCALS.OPTION_SLIDER17 = { name="Фильтр урона", minText="0", maxText="500", tooltipText = "Настройка минимального значения урона, привышая которое оно будет выводиться в SCT. Отличная фильтрация повторяющихся мелких ударов таких как: Ранящих щитов, Мелких ДОТов, и т.д..."};
SCT.LOCALS.OPTION_SLIDER18 = { name="Сумма аур", minText="0", maxText="20", tooltipText = "Необходимое число положительных/отрицательных эффектов для вызова события. 0 означает любую сумму"};

--Spell Color options
SCT.LOCALS.OPTION_COLOR1 = { name=SPELL_SCHOOL0_CAP, tooltipText = "Цвет для "..SPELL_SCHOOL0_CAP.." заклинаний"};
SCT.LOCALS.OPTION_COLOR2 = { name=SPELL_SCHOOL1_CAP, tooltipText = "Цвет для "..SPELL_SCHOOL1_CAP.." заклинаний"};
SCT.LOCALS.OPTION_COLOR3 = { name=SPELL_SCHOOL2_CAP, tooltipText = "Цвет для "..SPELL_SCHOOL2_CAP.." заклинаний"};
SCT.LOCALS.OPTION_COLOR4 = { name=SPELL_SCHOOL3_CAP, tooltipText = "Цвет для "..SPELL_SCHOOL3_CAP.." заклинаний"};
SCT.LOCALS.OPTION_COLOR5 = { name=SPELL_SCHOOL4_CAP, tooltipText = "Цвет для "..SPELL_SCHOOL4_CAP.." заклинаний"};
SCT.LOCALS.OPTION_COLOR6 = { name=SPELL_SCHOOL5_CAP, tooltipText = "Цвет для "..SPELL_SCHOOL5_CAP.." заклинаний"};
SCT.LOCALS.OPTION_COLOR7 = { name=SPELL_SCHOOL6_CAP, tooltipText = "Цвет для "..SPELL_SCHOOL6_CAP.." заклинаний"};
SCT.LOCALS.OPTION_COLOR8 = { name="Цвет события", tooltipText = "Окраска данного события."};

--Misc option values
SCT.LOCALS.OPTION_MISC1 = {name="Опции SCT "..SCT.version, tooltipText = "Правый клик для перетаскивания"};
SCT.LOCALS.OPTION_MISC2 = {name="Закрыть", tooltipText = "Закрыть окраску заклинаний" };
SCT.LOCALS.OPTION_MISC3 = {name="Править", tooltipText = "Редактировать окраску заклинаний" };
SCT.LOCALS.OPTION_MISC4 = {name="Различные опции"};
SCT.LOCALS.OPTION_MISC5 = {name="Опции предупреждений"};
SCT.LOCALS.OPTION_MISC6 = {name="Опции анимации"};
SCT.LOCALS.OPTION_MISC7 = {name="Выберите профиль игрока"};
SCT.LOCALS.OPTION_MISC8 = {name="Сохранить & Закрыть", tooltipText = "Сохранить все текущие настройи и закрыть окно настроек"};
SCT.LOCALS.OPTION_MISC9 = {name="Сброс", tooltipText = "-Внимание-\n\nВы уверены что вы хотите сбросить SCT на стандарт?"};
SCT.LOCALS.OPTION_MISC10 = {name="Профиля", tooltipText = "Выберите другой профиль для персонажа"};
SCT.LOCALS.OPTION_MISC11 = {name="Загрузить", tooltipText = "Загрузить профиль другого персонажа для данного персонажа"};
SCT.LOCALS.OPTION_MISC12 = {name="Удалить", tooltipText = "Удалить профиль персонажа"};
SCT.LOCALS.OPTION_MISC13 = {name="Опции текста" };
SCT.LOCALS.OPTION_MISC14 = {name="1 Фрейм"};
SCT.LOCALS.OPTION_MISC15 = {name="Сообщения"};
SCT.LOCALS.OPTION_MISC16 = {name="Анимация"};
SCT.LOCALS.OPTION_MISC17 = {name="Опции способностей"};
SCT.LOCALS.OPTION_MISC18 = {name="Фрейм"};
SCT.LOCALS.OPTION_MISC19 = {name="Способности"};
SCT.LOCALS.OPTION_MISC20 = {name="2 Фрейм"};
SCT.LOCALS.OPTION_MISC21 = {name="События"};
SCT.LOCALS.OPTION_MISC22 = {name="Класический профиль", tooltipText = "Загрузить класический профиль. SCT будет работать почти также как и со стандартными настройками"};
SCT.LOCALS.OPTION_MISC23 = {name="Профиль производ-сти", tooltipText = "Загрузить профиль. Включает все параметры, чтобы получить максимальную производительность от SCT"};
SCT.LOCALS.OPTION_MISC24 = {name="Профиль разделения", tooltipText = "Загрузить профиль разделения. То Входящий урон и события будут выводится с правой стороны, Входящие исцеление и баффы с левой стороны."};
SCT.LOCALS.OPTION_MISC25 = {name="Профиль Grayhoofа", tooltipText = "Загрузить профиль Grayhoofа. Настраивает SCT так как его настроил Grayhoof."};
SCT.LOCALS.OPTION_MISC26 = {name="Built In Profiles", tooltipText = ""};
SCT.LOCALS.OPTION_MISC27 = {name="Профиль разделения SCTD", tooltipText = "Загрузить разделённый SCTD профиль. Если у вас установлен SCTD, то Входящие события выводятся справой стороны, Исходящие события выводятся с левой стороны, остальное сверху."};
SCT.LOCALS.OPTION_MISC28 = {name="Тест", tooltipText = "Создаёт тестовое событие для всех фреймов"};
SCT.LOCALS.OPTION_MISC29 = {name="Свои события"};
SCT.LOCALS.OPTION_MISC30 = {name="Сохр. событие", tooltipText = "Сохранить изменения для данного события."};
SCT.LOCALS.OPTION_MISC31 = {name="Удалить событие", tooltipText = "Удалить данное пользовательское событие.", warning="-Внимание-\n\nВы уверены что вы хотите удалить данное событие?"};
SCT.LOCALS.OPTION_MISC32 = {name="Новое событие", tooltipText = "Создать новое пользовательское событие."};
SCT.LOCALS.OPTION_MISC33 = {name="Сброс событий", tooltipText = "Сброс всех событий на стандартные из файла sct_event_config.lua.", warning="-Внимание-\n\nВы уверены что вы хотите сбросить все пользовательские события SCT на стандартные?"};
SCT.LOCALS.OPTION_MISC34 = {name="Отмена", tooltipText = "Отмена всех изменений для данного события"};
SCT.LOCALS.OPTION_MISC35 = {name="Классы", tooltipText = "Выберите классы для данного события", open="<", close=">"};

--Selections
SCT.LOCALS.OPTION_SELECTION1 = { name="Тип анимации", tooltipText = "Какой тип анимации использовать", table = {[1] = "Верт.(Стандартный)", [2] = "Радужный", [3] = "Горизонтально", [4] = "Наискасок вниз", [5] = "Наискасок вверх", [6] = "Брызги", [7] = "HUD изогнутый", [8] = "HUD наискасок"}};
SCT.LOCALS.OPTION_SELECTION2 = { name="Сторона", tooltipText = "В какой стороне должна отображаться прокрутка текста", table = {[1] = "По выбору", [2] = "Урон слева", [3] = "Урон справа", [4] = "Всё слева", [5] = "Всё справа"}};
SCT.LOCALS.OPTION_SELECTION3 = { name="Шрифт", tooltipText = "Какой шрифт использовать", table = media:List("font")};
SCT.LOCALS.OPTION_SELECTION4 = { name="Контур шрифта", tooltipText = "Какой контур шрифта использовать", table = {[1] = "Без контура",[2] = "Тонкий",[3] = "Толстый"}};
SCT.LOCALS.OPTION_SELECTION5 = { name="Шрифт сообщения", tooltipText = "Какой шрифт использовать для вывода сообщений", table = media:List("font")};
SCT.LOCALS.OPTION_SELECTION6 = { name="Контур шрифта сообщений", tooltipText = "Какой контур шрифта использовать для вывода сообщений", table = {[1] = "Без контура", [2] = "Тонкий", [3] = "Толстый"}};
SCT.LOCALS.OPTION_SELECTION7 = { name="Расположение текста", tooltipText = "Каким образом расположить текст. Наиболее полезным для вертикальной или HUD анимации. HUD расположение сделает левую сторону пропорционально правой а правую, левой.", table = {[1] = "Слева", [2] = "По центру", [3] = "Справа", [4] = "По центру HUDа"}};
SCT.LOCALS.OPTION_SELECTION8 = { name="Сокрощение типа способностей", tooltipText = "Как сокрощать названия заклинаний.", table = {[1] = "Обрезать", [2] = "Сокращать"}};
SCT.LOCALS.OPTION_SELECTION9 = { name="Icon Alignment", tooltipText = "С какой стороны текста будет отображаться иконка.", table = {[1] = "Слева", [2] = "Справа", [3] = "Внутри", [4] = "Снаружи",}};

local eventtypes = {
  ["BUFF"] = "Получение ауры\баффа",
  ["FADE"] = "Истечение ауры\баффа",
  ["MISS"] = "Промах",
  ["HEAL"] = "Исцеление",
  ["DAMAGE"] = "Урон",
  ["DEATH"] = "Смерть",
  ["INTERRUPT"] = "Прерывание",
  ["POWER"] = "Энергия",
  ["SUMMON"] = "Призывание",
  ["DISPEL"] = "Рассеяние",
  ["CAST"] = "Применение",
}

local flags = {
  ["SELF"] = "Игрок",
  ["TARGET"] = "Цель",
  ["FOCUS"] = "Фокус",
  ["PET"] = "Питомец",
  ["ENEMY"] = "Враги",
  ["FRIEND"] = "Друзья",
  ["ANY"] = "Любой",
}

local frames = {
  [SCT.FRAME1] = SCT.LOCALS.OPTION_MISC14.name,
  [SCT.FRAME2] = SCT.LOCALS.OPTION_MISC20.name,
  [SCT.MSG] = SCT.LOCALS.OPTION_MISC15.name,
}

local misses = {
  ["ABSORB"] = ABSORB,
  ["DODGE"] = DODGE,
  ["RESIST"] = RESIST,
  ["PARRY"] = PARRY,
  ["MISS"] = MISS,
  ["BLOCK"] = BLOCK,
  ["REFLECT"] = REFLECT,
  ["DEFLECT"] = DEFLECT,
  ["IMMUNE"] = IMMUNE,
  ["EVADE"] = EVADE,
  ["ANY"] = "Any",
}

local power = {
  [Enum.PowerType.Mana] = MANA,
  [Enum.PowerType.Rage] = RAGE,
  [Enum.PowerType.Focus] = FOCUS,
  [Enum.PowerType.Energy] = ENERGY,
  [Enum.PowerType.ComboPoints] = COMBO_POINTS,
  [Enum.PowerType.Runes] = RUNES,
  [Enum.PowerType.RunicPower] = RUNIC_POWER,
  [Enum.PowerType.SoulShards] = SOUL_SHARDS,
  [Enum.PowerType.LunarPower] = LUNAR_POWER,
  [Enum.PowerType.HolyPower] = HOLY_POWER,
  [Enum.PowerType.Alternate] = ALTERNATE_RESOURCE_TEXT,
  [Enum.PowerType.Maelstrom] = MAELSTROM_POWER,
  [Enum.PowerType.Chi] = CHI_POWER,
  [Enum.PowerType.Insanity] = INSANITY_POWER,
  [Enum.PowerType.ArcaneCharges] = ARCANE_CHARGES_POWER,
  [Enum.PowerType.Fury] = FURY,
  [Enum.PowerType.Pain] = PAIN,
  [0] = "Any",
}

--Custom Selections
SCT.LOCALS.OPTION_CUSTOMSELECTION1 = { name="Тип события", tooltipText = "Какого типа это событие.", table = eventtypes};
SCT.LOCALS.OPTION_CUSTOMSELECTION2 = { name="Цель", tooltipText = "Who the event happens to.", table = flags};
SCT.LOCALS.OPTION_CUSTOMSELECTION3 = { name="Источник", tooltipText = "Who the event comes from.", table = flags};
SCT.LOCALS.OPTION_CUSTOMSELECTION4 = { name="Фрейм события", tooltipText = "What Frame to send the event to.", table = frames};
SCT.LOCALS.OPTION_CUSTOMSELECTION5 = { name="Тип промаха", tooltipText = "What type of miss to trigger off of.", table = misses};
SCT.LOCALS.OPTION_CUSTOMSELECTION6 = { name="Тип энергии", tooltipText = "What type of power to trigger off of.", table = power};

--EditBox options
SCT.LOCALS.OPTION_EDITBOX1 = { name="Название", tooltipText = "Название пользовательского события"};
SCT.LOCALS.OPTION_EDITBOX2 = { name="Отображение", tooltipText = "Что отображать в SCT для события. Используйте *1 - *5 для фиксированных значений:\n\n*1 - название заклинания\n*2 - источник\n*3 - цель\n*4 - изменения (величина, и т.д...)"};
SCT.LOCALS.OPTION_EDITBOX3 = { name="Поиск", tooltipText = "What spell or skill to search for. Can be empty (suppression) or partial words."};
SCT.LOCALS.OPTION_EDITBOX4 = { name="Звук", tooltipText = "Name of ingame sound to play for this event. Ex. GnomeExploration"};
SCT.LOCALS.OPTION_EDITBOX5 = { name="Звуковой файл", tooltipText = "Путь к звуковому файлу формата .ogg для данного события. Пример. Interface\\AddOns\\MyAddOn\\mysound.ogg или Sound\\Spells\\ShaysBell.ogg"};
