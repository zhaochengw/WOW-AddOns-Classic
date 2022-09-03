local L = LibStub("AceLocale-3.0"):NewLocale("PallyPower", "ruRU", false, false)
if not L then return end 
L["--- End of assignments ---"] = "--- Конец назначений ---"
L["--- Paladin assignments ---"] = "---  Благословения Паладинов ---"
L["...with Normal..."] = "...на Обычное Благословение..."
L["[|cffffd200Enable|r/|cffffd200Disable|r] The Aura Button or select the Aura you want to track."] = "[|cffffd200Вкл|r/|cffffd200Выкл|r] Кнопка Ауры или выбор Ауры для отслеживания."
L["[|cffffd200Enable|r/|cffffd200Disable|r] The Auto Buff Button or [|cffffd200Enable|r/|cffffd200Disable|r] Wait for Players."] = "[|cffffd200Вкл|r/|cffffd200Выкл|r] кнопку Автобаффа и [|cffffd200Вкл|r/|cffffd200Выкл|r] Ожидание игроков."
L["[|cffffd200Enable|r/|cffffd200Disable|r] The Drag Handle Button."] = "[|cffffd200Вкл|r/|cffffd200Выкл|r] кнопку Перетаскивания."
L["[|cffffd200Enable|r/|cffffd200Disable|r] The Player(s) or Class Buttons."] = "[|cffffd200Вкл|r/|cffffd200Выкл|r] кнопки Игроков или Классов."
L["[|cffffd200Enable|r/|cffffd200Disable|r] The Seal Button, Enable/Disable Righteous Fury or select the Seal you want to track."] = "[|cffffd200Вкл|r/|cffffd200Выкл|r] кнопку Печати, [|cffffd200Вкл|r/|cffffd200Выкл|r] Праведное неистовство или выбрать Печать для отслеживания."
L["[Enable/Disable] Class Buttons"] = "[Показать/Скрыть] Кнопки классов"
L["[Enable/Disable] PallyPower"] = "[Показать/Скрыть] PallyPower"
L["[Enable/Disable] PallyPower in Party"] = "[Показывать/Скрыть] PallyPower в группе"
L["[Enable/Disable] PallyPower while Solo"] = "[Показать/Скрыть] PallyPower при игре в одиночку"
L["[Enable/Disable] Righteous Fury"] = "[Вкл/Выкл] кнопку Праведного неистовства"
L["[Enable/Disable] The Aura Button"] = "[Вкл/Выкл] кнопку Ауры"
L["[Enable/Disable] The Auto Buff Button"] = "[Вкл/Выкл] кнопку Автобаффа"
L["[Enable/Disable] The Drag Handle"] = "[Вкл/Выкл] кнопку Перетаскивания"
L["[Enable/Disable] The Seal Button"] = "[Включить / Отключить] Кнопка тюлень"
L["[Show/Hide] Minimap Icon"] = "[Показат/Скрыть] иконку у миникарты"
L["[Show/Hide] The PallyPower Tooltips"] = "[Показать/Скрыть] подсказки PallyPower"
L["a Normal Blessing from:"] = "Обычное благословение от:"
L["Aura Button"] = "Кнопка Ауры"
L["Aura Tracker"] = "Отслеживание Ауры"
L["Auto Buff Button"] = "Кнопка Автобаффа"
L["Auto Greater Blessing Key"] = "Клавиша Великого Благословения"
L["Auto Normal Blessing Key"] = "Клавиша Обычного Благословения"
L["AUTO_ASSIGN_TOOLTIP"] = [=[Автоназначение всех Благословений
в зависимости от количества доступных
паладинов и доступных им Благословений.

[Shift-ЛКМ]|r Использовать шаблон для
Полей Боя вместо Рейдового.]=]
L["Auto-Assign"] = "Автоназначить"
L["Auto-Buff Main Assistant"] = "Автозамена Благословения для Наводчика"
L["Auto-Buff Main Tank"] = "Автобафф Главного танка"
L["AUTOKEY1_DESC"] = "Назначение клавиши для автоматического баффа Обычным Благословением."
L["AUTOKEY2_DESC"] = "Назначение клавиши для автоматического баффа Великим Благословением."
L["Background Textures"] = "Текстура фона кнопок"
L["Blessing Assignments Scale"] = "Размер окна назначения благословений"
L["BLESSING_REPORT_TOOLTIP"] = [=[Оповещение о всех назначенных
Благословениях в заданный канал.]=]
L["Blessings Report"] = "Отчёт"
L["Blessings Report Channel"] = "Канал для Отчёта"
L["Borders"] = "Рамки"
L["Buff Button | Player Button Layout"] = "Расположение кнопок баффов и игрока"
L["Buff Duration"] = "Учит. длительность"
L["Buttons"] = "Кнопки"
L["can be assigned"] = "может быть назначен"
L["Change global settings"] = "Изменение общих настроек"
L["Change the Button Background Textures"] = "Изменить текстуру фона кнопки"
L["Change the Button Borders"] = "Смена рамок Кнопок"
L["Change the button settings"] = "Изменение настроек кнопок"
L["Change the status colors of the buff buttons"] = "Изменить цвет статуса кнопок баффов"
L["Change the way PallyPower looks"] = "Изменить внешний вид PallyPower"
L["Class & Player Buttons"] = "Кнопки Класса и Игрока"
L["Class Buttons"] = "Кнопки Классов"
L["Clear"] = "Сброс"
L["Drag Handle"] = "Кнопка Перетаскивания"
L["Drag Handle Button"] = "Кнопка Перетаскивания"
L["DRAGHANDLE_TOOLTIP"] = [=[|cffffffff[ЛКМ]|r |cffff0000Заблокировать|r/|cff00ff00Разблокировать|r PallyPower
|cffffffff[Удерживать ЛКМ]|r Передвинуть PallyPower
|cffffffff[ПКМ]|r Открыть окно назначения Благословений
|cffffffff[Shift-ПКМ]|r Открыть окно Настроек]=]
L["Enable PallyPower"] = "Всегда/Никогда"
L["Free Assignment"] = "Вольный режим"
L["FREE_ASSIGN_TOOLTIP"] = [=[Разрешает другим паладинам изменять
благословения, не являясь лидером
группы (рейда) / помощником в рейде.]=]
L["Fully Buffed"] = "Полные баффы"
L["Hide Bench (by Subgroup)"] = "Скрыть запасных (по подгруппам)"
L["Horizontal Left | Down"] = "По горизонтали слева | вниз"
L["Horizontal Left | Up"] = "По горизонтали слева | вверх"
L["Horizontal Right | Down"] = "По горизонтальное вправо | вниз"
L["Horizontal Right | Up"] = "По горизонтальное вправо | вверх"
L["If this option is disabled it will also disable the Player Buttons and you will only be able to buff using the Auto Buff button."] = "Если эта опция отключена, то кнопки игрока будут так же отключены, и вы сможете использовать только кнопку Автобаффа."
L["If this option is disabled then Class and Player buttons will ignore buffs' duration, allowing buffs to be reapplied at will. This is especially useful for Protection Paladins when they spam Greater Blessings to generate more threat."] = "Если эта опция отключена, тогда кнопки «Класс» и «Игрок» будут игнорировать длительность эффекта, позволяя повторно использовать Благословение. Это особенно полезно для танков паладинов, когда они обновляют Великие благословения, чтобы генерировать больше угрозы."
L["If this option is disabled then you will no longer see the pop out buttons showing individual players and you will not be able to reapply Normal Blessings while in combat."] = "Если эта опция отключена, то вы больше не увидите всплывающие кнопки при наведении на кнопку Класса, показывающие отдельных игроков. Вы не сможете повторно применить Обычные благословения в бою."
L["If this option is enabled then the Auto Buff Button and the Class Buff Button(s) will not auto buff a Greater Blessing if recipient(s) are not within the Paladins range (100yds). This range check excludes AFK, Dead and Offline players."] = "Если эта опция включена, то кнопка Автобаффа не будет автоматически пытаться бафать класс Великим Благословением или игрока Обычным Благословением, если они мертвы, не в сети или не находятся в пределах досягаемости."
--[[Translation missing --]]
L["If you enable this option PallyPower will automatically over-write a Greater Blessing with a Normal Blessing on players marked with the |cffffd200Main Assistant|r role in the Blizzard Raid Panel. This is useful for spot buffing the |cffffd200Main Assistant|r role with Blessing of Sanctuary."] = "If you enable this option PallyPower will automatically over-write a Greater Blessing with a Normal Blessing on players marked with the |cffffd200Main Assistant|r role in the Blizzard Raid Panel. This is useful for spot buffing the |cffffd200Main Assistant|r role with Blessing of Sanctuary."
L["If you enable this option PallyPower will automatically over-write a Greater Blessing with a Normal Blessing on players marked with the |cffffd200Main Assistant|r role in the Blizzard Raid Panel. This is useful to avoid blessing the |cffffd200Main Assistant|r role with a Greater Blessing of Salvation."] = "Если вы включите эту опцию, PallyPower автоматически перезапишет Великое благословение на Обычное благословением для игроков, помеченных ролью |cffffd200Наводчик|r в интерфейсе рейда. Это полезно, чтобы самостоятельно заменять Великое благословение спасения другим благословением для роли |cffffd200Наводчика|r кликая по кнопке игрока ПКМ."
--[[Translation missing --]]
L["If you enable this option PallyPower will automatically over-write a Greater Blessing with a Normal Blessing on players marked with the |cffffd200Main Tank|r role in the Blizzard Raid Panel. This is useful for spot buffing the |cffffd200Main Tank|r role with Blessing of Sanctuary."] = "If you enable this option PallyPower will automatically over-write a Greater Blessing with a Normal Blessing on players marked with the |cffffd200Main Tank|r role in the Blizzard Raid Panel. This is useful for spot buffing the |cffffd200Main Tank|r role with Blessing of Sanctuary."
L["If you enable this option PallyPower will automatically over-write a Greater Blessing with a Normal Blessing on players marked with the |cffffd200Main Tank|r role in the Blizzard Raid Panel. This is useful to avoid blessing the |cffffd200Main Tank|r role with a Greater Blessing of Salvation."] = "Если вы включите эту опцию, PallyPower автоматически перезапишет Великое благословение Обычным Благословением для игроков, помеченных ролью |cffffd200Главный танк|r в интерфейсе рейда. Это полезно, чтобы самостоятельно заменять Великое благословение спасения другим благословением для роли |cffffd200Главного танка|r кликая по кнопке игрока ПКМ."
L["If you enable this option, you will not be allowed to assign Blessing of Wisdom to Warriors or Rogues, and Blessing of Might to Mages, Warlocks, or Hunters."] = "Если эта опция включена, то запрещает назначать Благословение мудрости для Воинов или Разбойников и Благословение могущества для Магов, Чернокнижников и Охотников."
L["If you enable this option, you will not be allowed to assign Blessing of Wisdom to Warriors, Rogues, or Death Knights and Blessing of Might to Mages, Warlocks, or Hunters."] = [=[Если вы включите эту опцию, вы не сможете назначать Благословение мудрости для
Воинов, Разбойников или Рыцарей смерти или Благословение могущества для Магов, Чернокнижников и Охотников.]=]
L["LAYOUT_TOOLTIP"] = "Вертикально [Слева/Справа] Горизонтально [Вверху/Внизу]"
L["Main PallyPower Settings"] = "Когда показывать PallyPower"
L["Main Tank / Main Assist Roles"] = "Роли Главный танк / Наводчик"
L["MAIN_ROLES_DESCRIPTION"] = [=[Эти параметры можно использовать для автоматического назначения (автозамены)  любого Великого Благословения на Обычное Благословение, назначенного |cffff0000Воинам, Друидам или Паладинам|r.

Обычно роли |cffffd200Главный танк|r и |cffffd200Наводчик|r в рейдовом интерфейсе использовались для идентификации Главных Танков (МТ) и Вспомогательных Танков (ОТ), однако некоторые гильдии назначают роль |cffffd200Главный танк|r всем танкам, а роль |cffffd200Наводчик|r целителям. Наличие отдельных параметров для обеих ролей позволит удалить, например, Великое благословение спасения с танков, или назначить Друидам целителям, отмеченным ролью |cffffd200Наводчик|r автозамену Великого благословения могущества, назначенного на ДПС Друидов, на Благословение мудрости.

|cffffff00Примечание: если в рейде 5 или более Паладинов (достаточно, чтобы назначить все Великие Благословения), то эти настройки автоматически отключаются. Танкам необходимо снимать Великое благословение спасение самостоятельно.|r]=]
--[[Translation missing --]]
L["MAIN_ROLES_DESCRIPTION_WRATH"] = [=[These options can be used to automatically assign alternate Normal Blessings for any Greater Blessing assigned to Warriors, Death Knights, Druids, or Paladins |cffff0000only|r.

Normally the Main Tank and the Main Assist roles have been used to identify Main Tanks and Off-Tanks (Main Assist) however, some guilds assign the Main Tank role to both Main Tanks and Off-Tanks and assign the Main Assist role to Healers.

By having a separate setting for both roles it will allow Paladin Class Leaders or Raid Leaders to add, as an example, Blessing of Sanctuary to tanking classes. Another example being if Druid or Paladin Healers are marked with the Main Assist role, they could be set up to get normal Blessing of Wisdom vs Greater Blessing of Might which would allow assigning Greater Blessing of Might for DPS spec'd Druids and Paladins and normal Blessing of Wisdom to Healing spec'd Druids and Paladins.]=]
L["MINIMAP_ICON_TOOLTIP"] = [=[|cffffffff[ЛКМ]|r Открыть назначение благословений
|cffffffff[ПКМ]|r Открыть настройки]=]
L["None"] = "Нет"
L["None Buffed"] = "Нет баффов"
L["Options"] = "Настройки"
L["OPTIONS_BUTTON_TOOLTIP"] = "Открыть окно настроек PallyPower."
L["Override Druids / Paladins..."] = "Автозамена для Друидов/Паладинов..."
L["Override Warriors / Death Knights..."] = "Переопределить Воинов / Рыцарей Смерти..."
L["Override Warriors..."] = "Автозамена для Воинов..."
L["PallyPower Buttons Scale"] = "Масштаб кнопок баффа"
L["PallyPower Classic"] = "PallyPower"
L["Partially Buffed"] = "Неполные баффы"
L["Player Buttons"] = "Кнопки Игроков"
L["PP_CLEAR_TOOLTIP"] = [=[Очищает все назначенные
Благословения для всех
Паладинов в группе/рейде]=]
L["PP_REFRESH_TOOLTIP"] = [=[Обновить все назначенные
Благословения, Таланты,
Знаки королей для Паладинов
в группе/рейде]=]
L["Preset"] = "Предустановка"
L["PRESET_TOOLTIP"] = "|cffffffff[Левый клик]|r Загрузите последнюю сохраненную предустановку. |cffffffff[Shift-левый клик]|r Сохраните предустановку всех великих и обыкновенных благословений, настроенных в данный момент."
L["Raid only options"] = "Настройки только для рейда"
L["Refresh"] = "Обновить"
L["REPORT_CHANNEL_OPTION_TOOLTIP"] = [=[Установите канал для Отчёта о Благословениях:

|cffffd200[Нет]|r Канал в зависимости от размера группы (Группа/Рейд)

|cffffd200[Список каналов]|r Автоматически заполненный список каналов, основанный на каналах, к которым игрок присоединился.|nКаналы по умолчанию, такие как Торговля, Общий и т. д. автоматически отфильтровываются из списка.

|cffffff00Примечание: если вы измените свой порядок каналов, вам потребуется перезагрузить интерфейс и убедиться, что он вещает на правильный канал.|r]=]
L["Reset all PallyPower frames back to center"] = "Вернуть все рамки PallyPower в центр"
L["Reset Frames"] = "Сброс рамок"
L["RESIZEGRIP_TOOLTIP"] = [=[ЛКМ и удерживание, для изменения размера.
ПКМ сбрасывает размер до изначального]=]
L["Righteous Fury"] = "Праведное неистовство"
L["Salv in Combat"] = "Сальва в бою"
L["SALVCOMBAT_OPTION_TOOLTIP"] = [=[Если эта опция включена, то вы сможете баффать Воинов, Друидов и Паладинов Великим благословением спасения пока находитесь в бою 

|cffffff00Примечание: эта настройка работает ТОЛЬКО в рейдовой группе, т.к. по традиции большинство танков использует аддоны для автоматического снятия баффов, которые работают только вне боя. Эта опция нужна для предотвращения случайного применения Благословения спасения на танков в бою.]=]
L["Seal Button"] = "Кнопка Печати"
L["Seal Tracker"] = "Отслеживание Печати"
L["Select the Aura you want to track"] = "Выбор Ауры для отслеживания"
L["Select the Greater Blessing assignment you wish to over-write on Main Assist: Druids / Paladins."] = "Выберите Великое Благословение для автозамены на другое Обычное Благословение для Друидов/Паладинов, отмеченных ролью Наводчика."
L["Select the Greater Blessing assignment you wish to over-write on Main Assist: Warriors / Death Knights."] = "Выберите назначенное великое благословение, которое вы хотите использовать, чтобы перезаписать когда главный помощник: Воины / Рыцари смерти."
L["Select the Greater Blessing assignment you wish to over-write on Main Assist: Warriors."] = "Выберите Великое Благословение для автозамены на другое Обычное Благословение для Воинов, отмеченных ролью Наводчика."
L["Select the Greater Blessing assignment you wish to over-write on Main Tank: Druids / Paladins."] = "Выберите Великое Благословение для автозамены на другое Обычное Благословение для Друидов/Паладинов, отмеченных ролью Главного Танка."
L["Select the Greater Blessing assignment you wish to over-write on Main Tank: Warriors / Death Knights."] = "Выберите назначенное великое благословение, которое вы хотите использовать, чтобы перезаписать когда основной танк: Воины / Рыцари смерти."
L["Select the Greater Blessing assignment you wish to over-write on Main Tank: Warriors."] = "Выберите великое благословение, которое хотите перебафать на главного танка: Воина."
L["Select the Normal Blessing you wish to use to over-write the Main Assist: Druids / Paladins."] = "Выберите Обычное Благословение, которым будет заменяться Великое Благословение для Друидов/Паладинов, отмеченных ролью Наводчика."
L["Select the Normal Blessing you wish to use to over-write the Main Assist: Warriors / Death Knights."] = "Выберите обычное благословение, которое вы хотите использовать, чтобы перезаписать когда главные помощник: Воины / Рыцари смерти."
L["Select the Normal Blessing you wish to use to over-write the Main Assist: Warriors."] = "Выберите Обычное Благословение, которым будет заменяться Великое Благословение для Воинов, отмеченных ролью Наводчика."
L["Select the Normal Blessing you wish to use to over-write the Main Tank: Druids / Paladins."] = "Выберите Обычное Благословение, которым будет заменяться Великое Благословение для Друидов/Паладинов, отмеченных ролью Главного Танка."
L["Select the Normal Blessing you wish to use to over-write the Main Tank: Warriors / Death Knights."] = "Выберите обычное благословение, которое вы хотите использовать, чтобы перезаписать когда основной танк: Воины / Рыцари смерти."
L["Select the Normal Blessing you wish to use to over-write the Main Tank: Warriors."] = "Выберите обычное благословение, которое хотите перебафать на главного танка: Воина."
L["Select the Seal you want to track"] = "Выбор Печати для отслеживания"
L["Show Minimap Icon"] = "Иконка у миникарты"
L["Show Pets"] = "Показывать питомцев"
L["Show Tooltips"] = "Показывать подсказки"
L["SHOWPETS_OPTION_TOOLTIP_BCC"] = "Если вы включите эту опцию, питомцы будут отображаться в соответствующем классе, с которым у них общие Великие Благословения. |cffffff00Примечание: Бесы чернокнижника будут скрыты, если Фазовый сдвиг не отключен. Сайаад (Суккубы/Инкубы) всегда будут скрыты, так как их основное использование — Демоническое Жертвоприношение.|r"
L["SHOWPETS_OPTION_TOOLTIP_VANILLA"] = [=[Если эта опция включена, то питомцы будут отображаться как отдельный класс.

|cffffff00Примечание: из-за того, как работают Великие Благословения, питомцев необходимо баффать отдельно. Также Бес Чернокнижника будет скрыт, если включено Бегство в астрал.]=]
L["Smart Buffs"] = "Умные баффы"
L["This allows you to adjust the overall size of the Blessing Assignments Panel"] = "Это позволяет настроить общий размер окна назначений благословения"
L["This allows you to adjust the overall size of the PallyPower Buttons"] = "Установить масштаб панели кнопок баффа"
L["Use in Party"] = "В группе"
L["Use when Solo"] = "При игре в одиночку"
L["Vertical Down | Left"] = "По вертикали вниз | слева"
L["Vertical Down | Right"] = "По вертикали вниз | справа"
L["Vertical Up | Left"] = "По вертикали вверх | слева"
L["Vertical Up | Right"] = "По вертикали вверх | справа"
L["Visibility Settings"] = "Настройки видимости"
L["Wait for Players"] = "Ожидать игроков"
L["What to buff with PallyPower"] = "Что баффать при помощи PallyPower"
L["While you are in a Raid dungeon, hide any players outside of the usual subgroups for that dungeon. For example, if you are in a 10-player dungeon, any players in Group 3 or higher will be hidden."] = "Пока вы находитесь в рейдовом подземелье, скроет всех игроков, не входящих в обычные подгруппы для этого подземелья. Например, если вы находитесь в подземелье на 10 игроков, все игроки из группы 3 и выше будут скрыты."

