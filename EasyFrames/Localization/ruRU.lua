local L = LibStub("AceLocale-3.0"):NewLocale("EasyFrames", "ruRU")
if not L then return end

L["loaded. Options:"] = "загружен. Настройки:"

L["Opacity"] = "Прозрачность"
L["Opacity of combat texture"] = "Прозрачность текстуры в бою"

L["Main options"] = "Главные настройки"
L["In main options you can set the global options like colored frames, buffs settings, etc"] = "В окне главных настроек вы можете установить глобальные настройки фреймов, таких как Раскрасить фреймы здоровья в цвет класса, настройки бафов и другие"

L["Percent"] = "Проценты"
L["Current + Max"] = "Текущее + Макс"
L["Current + Max + Percent"] = "Текущее + Макс + Проценты"
L["Current + Percent"] = "Текущее + Проценты"
L["Custom format"] = "Свой формат"
L["Smart"] = "Умный"

L["Portrait"] = "Портрет"
L["Default"] = "По умолчанию"
L["Hide"] = "Скрыть"

L["HP and MP bars"] = "Фреймы здоровья и маны"

L["Font size"] = "Размер шрифта"
L["Healthbar font size"] = "Размер шрифта фреймов здоровья"
L["Manabar font size"] = "Размер шрифта фреймов маны"
L["Font family"] = "Шрифт"
L["Healthbar font style"] = "Стиль шрифта фреймов здоровья"
L["Healthbar font family"] = "Шрифт фреймов здоровья"
L["Manabar font style"] = "Стиль шрифта фреймов маны"
L["Manabar font family"] = "Шрифт фреймов маны"
L["Font style"] = "Стиль шрифта"

L["Reverse the direction of losing health/mana"] = "Изменить направление потери здоровья/маны"
L["By default direction starting from right to left. If checked direction of losing health/mana will be from left to right"] = "По умолчанию направление потери здоровья/маны идет справа налево. Если установлено направление будет обратное - слева направо"

L["Custom format of HP"] = "Свой формат HP"
L["You can set custom HP format. More information about custom HP format you can read on project site.\n\n" ..
        "Formulas:"] = "Вы можете установить свой формат HP. Больше информации о данном формате HP можно прочитать на сайте проекта.\n\n" ..
        "Формулы:"
L["Use full values of health"] = "Использовать полные значения здоровья"
L["Formula converts the original value to the specified value.\n\n" ..
        "Description: for example formula is '%.fM'.\n" ..
        "The first part '%.f' is the formula itself, the second part 'M' is the abbreviation\n\n" ..
        "Example, value is 150550. '%.f' will be converted to '151' and '%.1f' to '150.6'"] = "Исходные значения преобразуются по заданной формуле.\n\n" ..
            "Описание: возьмем формулу - '%.fM'.\n" ..
            "Первая часть '%.f' это сама формула, вторая часть 'M' это аббревиатура\n\n" ..
            "Пример, значение HP 150550.\n'%.f' преобразует его в '151', а '%.1f' в '150.6'"
L["Value greater than 1000"] = "Значение больше 1000"
L["Value greater than 100 000"] = "Значение больше 100 000"
L["Value greater than 1 000 000"] = "Значение больше 1 000 000"
L["Value greater than 10 000 000"] = "Значение больше 10 000 000"
L["Value greater than 100 000 000"] = "Значение больше 100 000 000"
L["Value greater than 1 000 000 000"] = "Значение больше 1 000 000 000"
L["By default all formulas use divider (for value eq 1000 and more it's 1000, for 1 000 000 and more it's 1 000 000, etc).\n\n" ..
        "If checked formulas will use full values of HP (without divider)"] = "По умолчанию все формулы используют делитель (для значения 1000 и больше он равен 1000, для 1 000 000 и больше он равен 1 000 000 и т.д.).\n\n" ..
            "Если установлено формулы используют полные значения HP (без делителя)"
L["Displayed HP by pattern"] = "Отображение HP по шаблону"
L["You can use patterns:\n\n" ..
        "%CURRENT% - return current health\n" ..
        "%MAX% - return maximum of health\n" ..
        "%PERCENT% - return percent of current/max health\n\n" ..
        "All values are returned from formulas. For set abbreviation use formulas' fields"] = "Вы можете использовать шаблоны:\n\n" ..
            "%CURRENT% - возвращает текущее значение здоровья\n" ..
            "%MAX% - возвращает максимальное значение здоровья\n" ..
            "%PERCENT% - возвращает проценты от текущее/максимальное значение здоровья\n\n" ..
            "Все значения возвращаются с формул. Для установки аббревиатур используйте поля формул"
L["Use Chinese numerals format"] = "Использовать Китайскую систему счисления"

L["Custom format of mana"] = "Свой формат маны"
L["You can set custom mana format. More information about custom mana format you can read on project site.\n\n" ..
        "Formulas:"] = "Вы можете установить свой формат маны. Больше информации о данном формате маны можно прочитать на сайте проекта.\n\n" ..
        "Формулы:"
L["Use full values of mana"] = "Использовать полные значения маны"
L["By default all formulas use divider (for value eq 1000 and more it's 1000, for 1 000 000 and more it's 1 000 000, etc).\n\n" ..
        "If checked formulas will use full values of mana (without divider)"] = "По умолчанию все формулы используют делитель (для значения 1000 и больше он равен 1000, для 1 000 000 и больше он равен 1 000 000 и т.д.).\n\n" ..
            "Если установлено формулы используют полные значения маны (без делителя)"
L["Displayed mana by pattern"] = "Отображение маны по шаблону"
L["You can use patterns:\n\n" ..
        "%CURRENT% - return current mana\n" ..
        "%MAX% - return maximum of mana\n" ..
        "%PERCENT% - return percent of current/max mana\n\n" ..
        "All values are returned from formulas. For set abbreviation use formulas' fields"] = "Вы можете использовать шаблоны:\n\n" ..
        "%CURRENT% - возвращает текущее значение маны\n" ..
        "%MAX% - возвращает максимальное значение маны\n" ..
        "%PERCENT% - возвращает проценты от текущее/максимальное значение маны\n\n" ..
        "Все значения возвращаются с формул. Для установки аббревиатур используйте поля формул"

L["Frames"] = "Фреймы"
L["Setting for unit frames"] = "Настройки фреймов"

L["Class colored healthbars"] = "Раскрасить фреймы здоровья в цвет класса"
L["If checked frames becomes class colored.\n\n" ..
    "This option excludes the option 'Healthbar color is based on the current health value'"] = "Если установлено фреймы раскрашиваются в цвет класса.\n\n" ..
        "Эта настройка исключает настройку 'Цвет фреймов основан на текущем значении здоровья'"
L["Healthbar color is based on the current health value"] = "Цвет фреймов основан на текущем значении здоровья"
L["Healthbar color is based on the current health value.\n\n" ..
    "This option excludes the option 'Class colored healthbars'"] = "Цвет фреймов основан на текущем значении здоровья.\n\n" ..
        "Эта настройка исключает настройку 'Раскрасить фреймы здоровья в цвет класса'"
L["Custom buffsize"] = "Собственный размер бафов"
L["Buffs settings (like custom buffsize, highlight dispelled buffs, etc)"] = "Настройки бафов (использовать собственный размер бафов, подсвечивать бафы, которые могут быть рассеяны и другие)"
L["Turn on custom buffsize"] = "Собственный размер бафов"
L["Turn on custom target and focus frames buffsize"] = "Включить собственный размер бафов у цели и фокус фреймов"
L["Buffs"] = "Бафы"
L["Buffsize"] = "Размер бафов"
L["Self buffsize"] = "Размер своих бафов"
L["Buffsize that you create"] = "Размер бафов, которые вы создаете"
L["Highlight dispelled buffs"] = "Подсвечивать бафы, которые могут быть рассеяны"
L["Highlight buffs that can be dispelled from target frame"] = "Подсвечивать бафы у цели, которые могут быть рассеяны"
L["Dispelled buff scale"] = "Размер (scale) бафов (dispelled)"
L["Dispelled buff scale that can be dispelled from target frame"] = "Размер (scale) бафов, которые могут быть рассеяны"
L["Only if player can dispel them"] = "Только если игрок может их рассеять"
L["Highlight dispelled buffs only if player can dispel them"] = "Подсвечивать бафы у цели, которые могут быть рассеяны, только если игрок может их рассеять"
L["Show only my debuffs"] = "Показывать только мои дебафы"
L["Max buffs count"] = "Макс. количество бафов"
L["How many buffs you can see on target/focus frames"] = "Максимальное количество бафов отображаемых на фрейме цели и фокус фрейме"
L["Max debuffs count"] = "Макс. количество дебафов"
L["How many debuffs you can see on target/focus frames"] = "Максимальное количество дебафов отображаемых на фрейме цели и фокус фрейме"

L["Class portraits"] = "Иконка класса в портрете"
L["Replaces the unit-frame portrait with their class icon"] = "Заменяет портрет фрейма иконкой класса"
L["Hide frames out of combat"] = "Скрывать фреймы вне боя"
L["Hide frames out of combat (for example in resting)"] = "Скрывать фреймы вне боя (к примеру, во время отдыха)"
L["Only if HP equal to 100%"] = "Только если HP игрока равно 100%"
L["Hide frames out of combat only if HP equal to 100%"] = "Скрывать фреймы вне боя только если HP игрока равно 100%"
L["Opacity of frames"] = "Прозрачность фреймов"
L["Opacity of frames when frames is hidden (in out of combat)"] = "Прозрачность фреймов когда фреймы скрыты (вне боя)"

L["Texture"] = "Текстура"
L["Set the frames bar Texture"] = "Установить текстуру фреймов"
L["Use a light texture"] = "Использовать светлые текстуры"
L["Use a brighter texture (like Blizzard's default texture)"] = "Использовать светлые текстуры (как текстуры Blizzard по умолчанию)"
L["Bright frames border"] = "Светлые границы фреймов"
L["You can set frames border bright/dark color. From bright to dark. 0 - dark, 100 - bright"] = "Вы можете установить свет границ фреймов. От светлого к темному. 0 - темные границы, 100 - светлые"
L["Set the manabar texture by force"] = "Принудительно установить текстуру для фрейма маны"
L["Use a force manabar texture setter. The Blizzard UI resets to default manabar texture each time an addon tries to modify it. " ..
        "With this option, the texture setter will set texture by force.\n\n" ..
        "IMPORTANT. When this option is enabled the addon will use a more CPU. More information in the issue #28"] = "Использовать принудительную установку текстуры для мана фрейма. " ..
            "Blizzard UI сбрасывает текстуру фрейма маны каждый раз когда аддон пытается изменить ее. " ..
            "Используя эту опцию текстура будет установлена принудительно.\n\n" ..
                "ВАЖНО. Включив данную опцию аддон будет использовать больше CPU. Подробности на сайте проекта (issue #28)"

L["Frames colors"] = "Цвета фреймов"
L["In this section you can set the default colors for friendly, enemy and neutral frames"] = "В этом разделе вы можете установить цвета фреймов по умолчанию для дружественных, враждебных или нейтральных целей"
L["Set default friendly healthbar color"] = "Цвет по умолчанию дружественных целей"
L["You can set the default friendly healthbar color for frames"] = "Вы можете установить цвет фреймов по умолчанию дружественных к вам целей"
L["Set default enemy healthbar color"] = "Цвет по умолчанию враждебных целей"
L["You can set the default enemy healthbar color for frames"] = "Вы можете установить цвет фреймов по умолчанию враждебных к вам целей"
L["Set default neutral healthbar color"] = "Цвет по умолчанию нейтральных целей"
L["You can set the default neutral healthbar color for frames"] = "Вы можете установить цвет фреймов по умолчанию нейтральных к вам целей"
L["Reset color to default"] = "Сбросить цвет"

L["Other"] = "Другое"
L["In this section you can set the settings like 'show welcome message' etc"] = "В этом разделе вы можете установить разные настройки не вошедшие в другие разделы (показывать приветственный текст в чате и другие)"
L["Show welcome message"] = "Показывать приветственный текст в чате"
L["Show welcome message when addon is loaded"] = "Показывать приветственный текст в чате когда аддон был загружен"

L["Save positions of frames to current profile"] = "Сохранить позиции фреймов в текущий профиль"
L["Restore positions of frames from current profile"] = "Восстановить позиции фреймов с текущего профиля"
L["Saved"] = "Сохранены"
L["Restored"] = "Восстановлены"

L["Frame"] = "Фрейм"
L["Select the frame you want to set the position"] = "Фрейм которому необходимо установить позицию"
L["X coordinate"] = "X позиция"
L["Y coordinate"] = "Y позиция"

L["Set the color of the frame name"] = "Установить цвет имени фрейма"


L["Player"] = "Игрок"
L["In player options you can set scale player frame, healthbar text format, etc"] = "В разделе Игрок вы можете установить размер (scale) фрейма игрока, установить формат HP и другие"
L["Set the player's portrait"] = "Установить портрет игрока"
L["Player name"] = "Имя игрока"
L["Player name font family"] = "Шрифт имени игрока"
L["Player name font size"] = "Размер шрифта имени игрока"
L["Player name font style"] = "Стиль шрифта имени игрока"
L["Player name color"] = "Цвет имени игрока"
L["Show or hide some elements of frame"] = "Показать или скрыть некоторые элементы фрейма"
L["Show player name"] = "Показывать имя игрока"
L["Show player name inside the frame"] = "Показывать имя игрока внутри фрейма"
L["Player frame scale"] = "Размер фрейма игрока"
L["Scale of player unit frame"] = "Размер (scale) фрейма игрока"
L["Enable hit indicators"] = "Показывать входящий урон и исцеление"
L["Show or hide the damage/heal which you take on your unit frame"] = "Показывать получаемый урон/исцеление на фрейме игрока"
L["Player healthbar text format"] = "Формат HP игрока"
L["Set the player healthbar text format"] = "Установить формат отображения здоровья игрока"
L["Player manabar text format"] = "Формат маны игрока"
L["Set the player manabar text format"] = "Установить формат отображения маны игрока"
L["Show player specialbar"] = "Показывать фрейм классового ресурса"
L["Show or hide the player specialbar, like Paladin's holy power, Priest's orbs, Monk's harmony or Warlock's soul shards"] = "Показывать фрейм классового ресурса, такие как Энергия Света паладинов, Безумие пристов, Ци монахов, Осколки души чернокнижников и другие"
L["Show player resting icon"] = "Показывать иконку отдыха игрока"
L["Show or hide player resting icon when player is resting (e.g. in the tavern or in the capital)"] = "Показывать иконку отдыха игрока когда он отдыхает (например, в таверне или в столице)"
L["Show player status texture (inside the frame)"] = "Показывать статус текстуру игрока (внутри фрейма)"
L["Show or hide player status texture (blinking glow inside the frame when player is resting or in combat)"] = "Показывать статус текстуру игрока (мигающая рамка внутри фрейма во время отдыха или боя)"
L["Show player combat texture (outside the frame)"] = "Показывать фоновую текстуру игрока (снаружи фрейма)"
L["Show or hide player red background texture (blinking red glow outside the frame in combat)"] = "Показывать красную текстуру в бою (мигающая рамка снаружи фрейма во время боя)"
L["Show player group number"] = "Показывать номер группы"
L["Show or hide player group number when player is in a raid group (over portrait)"] = "Показывать номер группы когда игрок в рейде (над портретом)"
L["Show player role icon"] = "Показывать иконку роли игрока"
L["Show or hide player role icon when player is in a group"] = "Показывать иконку роли когда игрок в группе"
L["Show player PVP icon"] = "Показывать PVP иконку игрока"
L["Show or hide player PVP icon"] = "Показывать PVP иконку игрока"


L["Target"] = "Цель"
L["In target options you can set scale target frame, healthbar text format, etc"] = "В разделе Цель вы можете установить размер (scale) фрейма цели, установить формат HP и другие"
L["Set the target's portrait"] = "Установить портрет цели"
L["Target name"] = "Имя цели"
L["Target name font family"] = "Шрифт имени цели"
L["Target name font size"] = "Размер шрифта имени цели"
L["Target name font style"] = "Стиль шрифта имени цели"
L["Target name color"] = "Цвет имени цели"
L["Target frame scale"] = "Размер фрейма цели"
L["Scale of target unit frame"] = "Размер (scale) фрейма цели"
L["Target healthbar text format"] = "Формат HP цели"
L["Set the target healthbar text format"] = "Установить формат отображения здоровья цели"
L["Target manabar text format"] = "Формат маны цели"
L["Set the target manabar text format"] = "Установить формат отображения маны цели"
L["Show target of target frame"] = "Показывать цель цели"
L["Show target name"] = "Показывать имя цели"
L["Show target name inside the frame"] = "Показывать имя цели внутри фрейма"
L["Show target combat texture (outside the frame)"] = "Показывать фоновую текстуру цели (снаружи фрейма)"
L["Show or hide target red background texture (blinking red glow outside the frame in combat)"] = "Показывать красную текстуру в бою (мигающая рамка снаружи фрейма во время боя)"
L["Show blizzard's target castbar"] = "Показывать у цели castbar Blizzard"
L["When you change this option you need to reload your UI (because it's Blizzard config variable). \n\nCommand /reload"] = "После установки данной опции вам необходимо перезагрузить UI (т.к. это внутренние настройки Blizzard). \n\nКоманда /reload"
L["Show target PVP icon"] = "Показывать PVP иконку цели"
L["Show or hide target PVP icon"] = "Показывать PVP иконку цели"


L["Focus"] = "Фокус"
L["In focus options you can set scale focus frame, healthbar text format, etc"] = "В разделе Фокус вы можете установить размер (scale) фокус фрейма, установить формат HP и другие"
L["Set the focus's portrait"] = "Установить портрет фокус фрейма"
L["Focus name"] = "Имя фокус фрейма"
L["Focus name font family"] = "Шрифт имени фокус фрейма"
L["Focus name font size"] = "Размер шрифта имени фокус фрейма"
L["Focus name font style"] = "Стиль шрифта имени фокус фрейма"
L["Focus name color"] = "Цвет имени фокус фрейма"
L["Focus frame scale"] = "Размер фокус фрейма"
L["Scale of focus unit frame"] = "Размер (scale) фокус фрейма"
L["Focus healthbar text format"] = "Формат HP фокус фрейма"
L["Set the focus healthbar text format"] = "Установить формат отображения здоровья фокус фрейма"
L["Focus manabar text format"] = "Формат маны фокус фрейма"
L["Set the focus manabar text format"] = "Установить формат отображения маны фокус фрейма"
L["Show target of focus frame"] = "Показывать цель фокус фрейма"
L["Show name of focus frame"] = "Показывать имя фокус фрейма"
L["Show name of focus frame inside the frame"] = "Показывать имя фокус фрейма внутри фрейма"
L["Show focus combat texture (outside the frame)"] = "Показывать фоновую текстуру фокус фрейма (снаружи фрейма)"
L["Show or hide focus red background texture (blinking red glow outside the frame in combat)"] = "Показывать красную текстуру в бою (мигающая рамка снаружи фрейма во время боя)"
L["Show focus PVP icon"] = "Показывать PVP иконку фокус фрейма"
L["Show or hide focus PVP icon"] = "Показывать PVP иконку фокус фрейма"


L["Pet"] = "Питомец"
L["In pet options you can set scale pet frame, show/hide pet name, enable/disable pet hit indicators, etc"] = "В разделе Питомец вы можете установить размер (scale) фрейма питомца, Показывать имя питомца, включить отображение входящего урона и исцеления питомца и другие"
L["Pet name"] = "Имя питомца"
L["Pet name font family"] = "Шрифт имени питомца"
L["Pet name font size"] = "Размер шрифта имени питомца"
L["Pet name font style"] = "Стиль шрифта имени питомца"
L["Pet name color"] = "Цвет имени питомца"
L["Pet frame scale"] = "Размер фрейма питомца"
L["Scale of pet unit frame"] = "Размер (scale) фрейма питомца"
L["Pet healthbar text format"] = "Формат HP фрейма питомца"
L["Set the pet healthbar text format"] = "Установить формат отображения здоровья питомца"
L["Pet manabar text format"] = "Формат маны фрейма питомца"
L["Set the pet manabar text format"] = "Установить формат отображения маны питомца"
L["Show pet name"] = "Показывать имя питомца"
L["Show or hide the damage/heal which your pet take on pet unit frame"] = "Показывать получаемый урон/исцеление на фрейме питомца"
L["Show pet combat texture (inside the frame)"] = "Показывать фоновую текстуру фрейма питомца (внутри фрейма)"
L["Show or hide pet red background texture (blinking red glow inside the frame in combat)"] = "Показывать красную текстуру в бою (мигающая рамка внутри фрейма во время боя)"
L["Show pet combat texture (outside the frame)"] = "Показывать фоновую текстуру фрейма питомца (снаружи фрейма)"
L["Show or hide pet red background texture (blinking red glow outside the frame in combat)"] = "Показывать красную текстуру в бою (мигающая рамка снаружи фрейма во время боя)"


L["Party"] = "Группа"
L["In party options you can set scale party frames, healthbar text format, etc"] = "В разделе Группа вы можете установить размер (scale) фреймов группы, установить формат HP и другие"
L["Party frames scale"] = "Размер фреймов группы"
L["Scale of party unit frames"] = "Размер (scale) фреймов группы"
L["Party healthbar text format"] = "Формат HP фреймов группы"
L["Set the party healthbar text format"] = "Установить формат отображения здоровья фреймов группы"
L["Party manabar text format"] = "Формат маны фреймов группы"
L["Set the party manabar text format"] = "Установить формат отображения маны фреймов группы"
L["Party frames names"] = "Имена фреймов группы"
L["Show names of party frames"] = "Показывать имена фреймов группы"
L["Party names font style"] = "Стиль шрифта имени фреймов группы"
L["Party names font family"] = "Шрифт имени фреймов группы"
L["Party names font size"] = "Размер шрифта имени фреймов группы"
L["Party names color"] = "Цвет имени фреймов группы"
L["Show party pet frames"] = "Показывать питомцев группы"
